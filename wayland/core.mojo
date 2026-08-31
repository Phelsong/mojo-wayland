# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2026 Josh S Wilkinson
# This file is NOT regenerated.
from std.ffi import external_call
from std.memory import stack_allocation

comptime MUT_PTR = Pointer[NoneType, MutUntrackedOrigin]

# Opaque object handle. All wl_* objects (display, surface, seat, ...) are
# pointers to wl_proxy internally.
comptime WLPtr = MUT_PTR

# A protocol string argument. The C shim copies to a NUL-terminated buffer
# that lives for the duration of the request; Mojo side just carries bytes.
comptime WLString = Pointer[Byte, MutUntrackedOrigin]

# Max protocol args of any single event across known protocols.
comptime MAX_EVENT_ARGS = 16


def _cstr(s: String) -> Pointer[Int8, MutUntrackedOrigin]:
    """Null-terminated C char* view into a Mojo String (borrowed).
    Copies internally so immutable callers are fine."""
    var copy = String(s)
    var cs = copy.as_c_string_slice()
    return rebind[Pointer[Int8, MutUntrackedOrigin]](cs)


def _shim_interface(name: String) -> WLPtr:
    """Resolve a wl_*_interface data symbol by name via the C shim."""
    return external_call["wayland_shim_interface", WLPtr](_cstr(name))


def _proxy_constructor_versioned(proxy: WLPtr, opcode: UInt32, args: Pointer[WLArgument, MutUntrackedOrigin], iface_name: String, version: UInt32) raises -> WLPtr:
    """Constructor helper: resolves the interface record by name through the
    C shim (wl_*_interface are data symbols, invisible to external_call).

    The `version` argument is IGNORED in favour of the parent proxy's
    negotiated version - this mirrors what wayland-scanner emits
    (`wl_proxy_get_version(parent)`), because a child object must never
    claim a newer version than its factory object was bound with."""
    var iface = _shim_interface(iface_name)
    if Int(iface) == 0:
        raise Error("wayland: unknown interface " + iface_name)
    var parent_version = wl_proxy_get_version(proxy)
    return wl_proxy_marshal_array_constructor_versioned(proxy, opcode, args, iface, parent_version)


# --- event capture shim ---
# The C shim installs a wl_dispatcher per proxy that captures every event's
# opcode + marshalled arguments into a queue. listen() returns the queue
# handle; pop() takes the queue so the C side needs no proxy lookups.


def _shim_listen(proxy: WLPtr, iface_name: String, out_queue: Pointer[WLPtr, MutUntrackedOrigin]) -> Int32:
    """Install the capture dispatcher on a proxy. Returns 0 on success and
    writes the queue handle to out_queue (out param: the C side writes one
    pointer, so this takes a single-slot buffer, not the slot's value)."""
    return external_call["wayland_shim_listen", Int32](proxy, _cstr(iface_name), out_queue)


def _shim_event_pop(queue: WLPtr, opcode: UInt32, out_args: Pointer[WLArgument, MutUntrackedOrigin]) -> Int32:
    """Pop one captured event into out_args. Returns its opcode or -1.
    Any returned string args are malloc'd copies owned by the caller
    (free via wayland_shim_string_free)."""
    return external_call["wayland_shim_event_pop", Int32](queue, opcode, out_args)


def _shim_string_free(s: WLString):
    """Free a string copy returned by a popped 's' argument."""
    external_call["wayland_shim_string_free", NoneType](s)


def shim_interface(name: String) raises -> WLPtr:
    """Resolve a protocol interface record (wl_registry_interface etc.) by
    name through the C shim. Data symbols are invisible to external_call;
    the shim matches them by name. Needed for generic binds where the
    caller picks the interface (e.g. binding xdg_wm_base or wl_seat from
    the registry)."""
    var iface = _shim_interface(name)
    if Int(iface) == 0:
        raise Error("wayland: unknown interface " + name)
    return iface


def wl_display_connect(name: UInt64) -> WLPtr:
    # NOTE: an explicit explicit-name argument is REQUIRED. A zero-arg
    # external_call on Mojo 1.0.0 emits a call with an UNDEFINED first
    # register (garbage or stack pointer), which libwayland treats as a
    # literal socket name — connect then fails depending on surrounding
    # codegen. Passing UInt64(0) = NULL name is the only safe form.
    return external_call["wl_display_connect", WLPtr](name)


def wl_display_disconnect(display: WLPtr):
    external_call["wl_display_disconnect", NoneType](display)


def wl_display_roundtrip(display: WLPtr) -> Int32:
    return external_call["wl_display_roundtrip", Int32](display)


def wl_display_dispatch(display: WLPtr) -> Int32:
    return external_call["wl_display_dispatch", Int32](display)


def wl_display_dispatch_pending(display: WLPtr) -> Int32:
    return external_call["wl_display_dispatch_pending", Int32](display)


def wl_display_flush(display: WLPtr) -> Int32:
    return external_call["wl_display_flush", Int32](display)


def wl_display_get_fd(display: WLPtr) -> Int32:
    return external_call["wl_display_get_fd", Int32](display)


def wl_display_get_error(display: WLPtr) -> Int32:
    return external_call["wl_display_get_error", Int32](display)


def wl_display_get_protocol_error(display: WLPtr, out_interface: WLPtr, out_id: Pointer[UInt32, MutUntrackedOrigin]) -> UInt32:
    return external_call["wl_display_get_protocol_error", UInt32](display, out_interface, out_id)


def wl_proxy_get_id(proxy: WLPtr) -> UInt32:
    return external_call["wl_proxy_get_id", UInt32](proxy)


def wl_proxy_get_version(proxy: WLPtr) -> UInt32:
    return external_call["wl_proxy_get_version", UInt32](proxy)


def wl_proxy_destroy(proxy: WLPtr):
    external_call["wl_proxy_destroy", NoneType](proxy)


def wl_proxy_marshal_array(proxy: WLPtr, opcode: UInt32, args: Pointer[WLArgument, MutUntrackedOrigin]):
    external_call["wl_proxy_marshal_array", NoneType](proxy, opcode, args)


def wl_proxy_marshal_array_constructor_versioned(proxy: WLPtr, opcode: UInt32, args: Pointer[WLArgument, MutUntrackedOrigin], iface: WLPtr, version: UInt32) -> WLPtr:
    return external_call["wl_proxy_marshal_array_constructor_versioned", WLPtr](proxy, opcode, args, iface, version)


def wl_proxy_marshal_array_flags(proxy: WLPtr, opcode: UInt32, args: Pointer[WLArgument, MutUntrackedOrigin], iface: WLPtr, version: UInt32, flags: UInt32) -> WLPtr:
    return external_call["wl_proxy_marshal_array_flags", WLPtr](proxy, opcode, args, iface, version, flags)


def wl_proxy_add_listener(proxy: WLPtr, listener: WLPtr, data: WLPtr) -> Int32:
    return external_call["wl_proxy_add_listener", Int32](proxy, listener, data)


def wl_proxy_set_user_data(proxy: WLPtr, data: WLPtr):
    external_call["wl_proxy_set_user_data", NoneType](proxy, data)


def wl_proxy_get_user_data(proxy: WLPtr) -> WLPtr:
    return external_call["wl_proxy_get_user_data", WLPtr](proxy)


def wl_proxy_set_queue(proxy: WLPtr, queue: WLPtr):
    external_call["wl_proxy_set_queue", NoneType](proxy, queue)


def wl_list_init(lst: WLPtr):
    external_call["wl_list_init", NoneType](lst)


def wl_array_init(arr: WLPtr):
    external_call["wl_array_init", NoneType](arr)


def wl_array_release(arr: WLPtr):
    external_call["wl_array_release", NoneType](arr)


def wl_array_add(arr: WLPtr, size: Int) -> WLPtr:
    return external_call["wl_array_add", WLPtr](arr, size)


# wl_argument mirror (8 bytes on x86_64). Byte buffer with typed constructors;
# layout matches wayland-client's union EXACTLY.
struct WLArgument(Copyable, Movable):
    var raw: InlineArray[Byte, 8]

    def __init__(out self):
        self.raw = InlineArray[Byte, 8](uninitialized=True)
        for i in range(8):
            self.raw[i] = Byte(0)

    def __copyinit__(mut self, existing: Self):
        self.raw = InlineArray[Byte, 8](uninitialized=True)
        for i in range(8):
            self.raw[i] = existing.raw[i]

    @staticmethod
    def store32(b: Pointer[Byte, MutUntrackedOrigin], off: Int, value: Int32):
        b[off] = Byte(value & 0xFF)
        b[off + 1] = Byte((value >> 8) & 0xFF)
        b[off + 2] = Byte((value >> 16) & 0xFF)
        b[off + 3] = Byte((value >> 24) & 0xFF)

    @staticmethod
    def store64(b: Pointer[Byte, MutUntrackedOrigin], off: Int, value: UInt):
        b[off] = Byte(value & 0xFF)
        b[off + 1] = Byte((value >> 8) & 0xFF)
        b[off + 2] = Byte((value >> 16) & 0xFF)
        b[off + 3] = Byte((value >> 24) & 0xFF)
        b[off + 4] = Byte((value >> 32) & 0xFF)
        b[off + 5] = Byte((value >> 40) & 0xFF)
        b[off + 6] = Byte((value >> 48) & 0xFF)
        b[off + 7] = Byte((value >> 56) & 0xFF)

    @staticmethod
    def make_i(value: Int32) -> Self:
        var a = Self()
        var bp = Pointer[Byte, MutUntrackedOrigin](unsafe_from_address=Int(a.raw.unsafe_ptr()))
        Self.store32(bp, 0, value)
        return a.copy()

    @staticmethod
    def make_u(value: UInt32) -> Self:
        var a = Self()
        var bits: UInt = UInt(value)
        var bp = Pointer[Byte, MutUntrackedOrigin](unsafe_from_address=Int(a.raw.unsafe_ptr()))
        Self.store32(bp, 0, Int32(bits))
        return a.copy()

    @staticmethod
    def make_f(value: Float64) -> Self:
        # wl_fixed: int24.8 signed fixed-point
        var fixed: Int32 = Int32(value * 256.0)
        return Self.make_i(fixed).copy()

    @staticmethod
    def make_s(value: WLString) -> Self:
        return Self._from_ptr(UInt(Int(value))).copy()

    @staticmethod
    def make_o(value: WLPtr) -> Self:
        return Self._from_ptr(UInt(Int(value))).copy()

    @staticmethod
    def make_n(value: WLPtr) -> Self:
        return Self._from_ptr(UInt(Int(value))).copy()

    @staticmethod
    def make_a(value: WLPtr) -> Self:
        return Self._from_ptr(UInt(Int(value))).copy()

    @staticmethod
    def make_h(value: Int32) -> Self:
        return Self.make_i(value).copy()

    @staticmethod
    def _from_ptr(val: UInt) -> Self:
        var a = Self()
        var bp = Pointer[Byte, MutUntrackedOrigin](unsafe_from_address=Int(a.raw.unsafe_ptr()))
        Self.store64(bp, 0, val)
        return a.copy()
