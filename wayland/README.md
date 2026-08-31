# mojo-wayland

Mojo bindings for the Wayland client protocol, generated from the official
protocol XML. Experimental; lives in this repo for now and is designed to be
extracted into a standalone project later.

## License

MIT — see [LICENSE](../LICENSE).

The generated files under `wayland/gen/` are derived from the Wayland core
protocol and xdg-shell protocol XMLs, which carry their own permissive
copyright notices, reproduced in `wayland/c/generated/`. The generated
bindings inherit those notices.

## Layout

| Path                       | Purpose                                                    |
| -------------------------- | ---------------------------------------------------------- |
| `scripts/wayland_bindgen.py` | Generator: protocol XML → Mojo modules (see below)         |
| `wayland/core.mojo`        | Hand-written runtime (external_call stubs, WLArgument, shim glue) — NOT regenerated |
| `wayland/gen/wayland.mojo` | Generated: requests, event opcodes, listen/next accessors  |
| `wayland/gen/xdg_shell.mojo` | Generated: xdg-shell (wm_base, surface, toplevel, ...)   |
| `wayland/c/shim.c`         | Tiny C shim: event capture dispatcher + interface table    |
| `wayland/c/generated/`     | wayland-scanner private-code + header for xdg-shell (xdg interfaces are NOT in libwayland-client) |
| `wayland-test/test_globals.mojo` | Live test: connect → registry → print all globals   |
| `wayland-test/test_window.mojo`  | Live test: full xdg-shell window with a wl_shm gradient buffer |

## How it works

- **Requests** are lowered through `wl_proxy_marshal_array` /
  `wl_proxy_marshal_array_constructor_versioned` (libwayland exports no
  per-request symbols; `wl_surface_commit` & co. are header-inline only).
  Everything resolves via `external_call` against `libwayland-client`, linked
  at build time with `-lwayland-client`.
- **Interface records** (`wl_registry_interface` etc.) are data symbols — the
  C shim exposes a static name → `wl_interface*` table
  (`wayland_shim_interface("wl_registry")`).
- **Events** use one generic C dispatcher (`wl_proxy_add_dispatcher`) that
  captures `(opcode, args)` per proxy into a FIFO owned by the shim. Mojo
  polls with `{iface}_next_{event}(queue, out_args)` and frees copied string
  args with `_shim_string_free`.
- `WLArgument` mirrors `union wl_argument` exactly (**8 bytes on x86_64**).
- **Argument arrays are indexed by wire-signature position**: `new_id` slots
  stay zeroed (libwayland writes the new proxy id there); every other arg
  lands at its position in the XML arg list. Dense-packing non-`new_id` args
  causes the compositor to read garbage (e.g. `get_xdg_surface` signature
  `no` — the surface must be in slot 1, slot 0 is the new_id).
- **Child proxies inherit the parent's version**: constructors resolve the
  version via `wl_proxy_get_version(parent)` — never hardcode the XML version
  (binding `xdg_wm_base` at v3 and creating an `xdg_surface` at v7 is a
  protocol error).
- `wl_registry.bind` is special: the wire signature is `usun`, so the
  generated `wl_registry_bind` takes BOTH the interface pointer (for the
  constructed proxy) and the interface NAME string (marshalled as the `s`
  wire arg) plus name+version.
- **XDg interfaces** come from `wayland-scanner private-code` compiled into
  the shim DSO; they are not exported by libwayland-client.

## Usage

```bash
pixi run wayland-build      # regen + package → .pixi/envs/default/lib/wayland.mojopkg
pixi run wayland-test       # build + run live registry test on $WAYLAND_DISPLAY
pixi run wayland-window     # build + run live xdg-shell window (400x300 gradient)
```

The registry test prints every global your compositor advertises and exits 0.
The window test opens a real 400x300 teal-purple gradient window (answers xdg
pings, exits on close), proving: connect, generic bind, xdg-shell configure
handshake, wl_shm via memfd, buffer attach/commit, and the event loop.

Note: on some pixi versions `pixi run` sandboxes the task environment in a way
that breaks `wl_display_connect` (connection refused at runtime). If the test
fails to connect under `pixi run` but builds fine, either run it with
`pixi exec wayland-test` or invoke the binary directly:

```bash
pixi run wayland-build pixi run wayland-shim
pixi run mojo build wayland-test/test_globals.mojo -I . -o .pixi/test_globals \
    -Xlinker -L.pixi/lib -Xlinker -L.pixi/envs/default/lib \
    -Xlinker -lwayland_shim -Xlinker -lwayland-client
LD_LIBRARY_PATH=.pixi/lib:.pixi/envs/default/lib .pixi/test_globals
```

## Mojo 1.0.0b2 notes (things that cost us here)

- `std.ffi.OwnedDLHandle.get_function` is unusable: a `def(...) -> T` type in
  parameter position becomes `AnyTrait` and fails the
  `TrivialRegisterPassable` constraint. Use `external_call` + link-time
  linking instead.
- `fn` keyword removed; `def` only. No inline ternary. Dict has no
  `.contains()`.
- Null checks: `Int(ptr) == 0` (UnsafePointer is non-nullable);
  construction via `UnsafePointer[T, MutAnyOrigin](unsafe_from_address=addr)`.
- `InlineArray[Byte, N](uninitialized=True)` — `undef=` doesn't exist.
- `external_call` can't return None: declare `def f(...):` without a return
  type for void C functions.
- **Zero-arg `external_call` is unsafe**: `external_call["f", T]()` emits a
  call with an UNDEFINED first argument register. If the C function takes no
  args (e.g. `wl_display_connect(void)`), the callee may still read garbage
  from the register — `wl_display_connect` interpreted it as a socket name
  and connection failed depending on surrounding codegen. Always declare at
  least one explicit argument (pass `UInt64(0)` for NULL) for zero-arg C
  functions.
- Buffers passed to `{iface}_next_{event}(queue, out_args)` MUST be
  `MAX_EVENT_ARGS` (16) entries; the C shim memset-cleans the whole array
  regardless of the event's real arg count (a 1-entry scratch buffer will
  smash the stack).
- `match` is a reserved keyword; tuples don't work as return types; `var (a,
  b) = f()` destructuring doesn't exist.
- Relative imports between subpackages fail; use absolute
  (`from wayland.core import ...`).

## Extracting to its own repo

The package is self-contained: `wayland/` + `scripts/wayland_bindgen.py` have
no imports from Quire's `functions/` or `main.mojo`. To extract:

1. Copy `wayland/` and `scripts/wayland_bindgen.py` into the new repo.
2. Copy the `wayland-*` tasks from `pixi.toml`.
3. Regenerate the xdg-shell private-code if the protocol XML changes:
   `wayland-scanner private-code <xdg-shell.xml> wayland/c/generated/xdg-shell-protocol.c`
   and `wayland-scanner client-header <xdg-shell.xml> wayland/c/generated/xdg-shell-client-protocol.h`.
4. Add extension protocols with more XMLs:
   `pixi run wayland-gen /usr/share/wayland/wayland.xml <extra>.xml`
   (e.g. `/usr/share/wayland-protocols/stable/xdg-shell/xdg-shell.xml`).
   Each emits `wayland/gen/<proto>.mojo` and is re-exported from `__init__`.

## Known limitations

- Events are poll-based (`dispatch` then `next_*` per event), not callback-
  based; a callback API would need C→Mojo trampolines.
- String args in popped events must be freed with `_shim_string_free`.
- The core protocol + xdg-shell are generated; further extensions need their
  XMLs passed to the generator (and any non-libwayland interfaces added to
  the shim's `SHIM_IFACE_ENTRIES` + scanner private-code build).
- Destructor requests marshal then `wl_proxy_destroy`; there is no
  automatic object-lifetime management.