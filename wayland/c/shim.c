// SPDX-License-Identifier: MIT
// SPDX-FileCopyrightText: 2026 Josh S Wilkinson
/* shim.c — C support for mojo-wayland bindings.
 *
 * Three responsibilities:
 *   1. wayland_shim_interface: resolve wl_*_interface DATA symbols by name
 *      (external_call can only resolve functions, not data symbols).
 *   2. wayland_shim_listen: install a generic wl_dispatcher on a proxy that
 *      captures every event as (opcode, args copy) into a queue.
 *   3. wayland_shim_event_pop: pop the next captured event matching an
 *      opcode out to Mojo as a flat argument array.
 *
 * Event queues are keyed by the queue object handed to the dispatcher (its
 * `user_data` argument), so multiple proxies each get their own FIFO.
 *
 * String args ('s') point into libwayland-owned memory that dies right after
 * dispatch returns; capture DEEP-COPIES them into malloc'd buffers handed to
 * Mojo. Mojo owns the copy and must free it via wayland_shim_string_free.
 *
 * ============================================================================
 * MAINTENANCE — wayland/c/shim.c
 * ============================================================================
 * Contracts with the Mojo side (all three are duplicated as [SYNC:*] notes in
 * wayland/core.mojo):
 *
 *   [SYNC:shim] SHIM_MAX_ARGS (16) == MAX_EVENT_ARGS in wayland/core.mojo.
 *       The pop path memsets out_args[0..SHIM_MAX_ARGS) unconditionally, so a
 *       shorter Mojo-side stack buffer overflows. Bump both together; also
 *       check the largest event arg count in any generated protocol first —
 *       16 covers core + xdg-shell, but tablet/tablet-v2 events go higher.
 *
 *   [SYNC:iface] SHIM_IFACE_ENTRIES must list every interface name the
 *       generated bindings may pass to wayland_shim_interface(). Missing
 *       names return NULL -> Mojo raises "unknown interface". Interfaces NOT
 *       exported by libwayland-client (all of xdg-shell) additionally need
 *       their wayland-scanner private-code object linked INTO this DSO (see
 *       the `scanner` + `shim` pixi tasks); libwayland-exported ones resolve
 *       via the extern declarations.
 *
 *   [SYNC:abi] the four exported wayland_shim_* signatures are called via
 *       Mojo external_call with a hand-maintained stub per function in
 *       wayland/core.mojo — renaming/reordering parameters breaks at runtime,
 *       not compile time (no cross-language type checking). external_call
 *       quirks (verified on 1.1.0, see tests/test_ffi_probe*.mojo): zero-arg
 *       calls are unsafe (undefined first register); two calls to the same
 *       symbol with different arities in one module fail LLVM lowering —
 *       hence the shim exposes exactly one signature per entry point.
 *
 * Known lifetimes / leaks (by design, documented):
 *   - Shim queues (calloc in wayland_shim_listen) are never freed: queue
 *     handles stay valid for the process lifetime. A queue_free entry point
 *     is straightforward to add if long-lived apps churn many proxies.
 *   - Undelivered events left in a queue at disconnect are freed with the
 *     event's string copies in the pop loop; events never popped still leak
 *     their string copies (bounded: one per pending event).
 *
 * Style/build notes:
 *   - Fully static interface resolution (no dlopen/dlsym) so two
 *     libwayland-client copies in one process can never desynchronize;
 *     see the comment above SHIM_IFACE_ENTRIES.
 *   - Built with -Wall and zero warnings; keep it that way.
 * ============================================================================
 */
#define _GNU_SOURCE
#include <pthread.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <wayland-client-core.h>
#include <wayland-util.h>

/* ---- interface symbol resolution ----
 * wl_*_interface are DATA symbols. Two libwayland-client copies can coexist
 * in one process (e.g. pixi env + system), and dlopen/dlsym by soname may
 * resolve against a different copy than the one Mojo's external_call
 * dispatches into — pointers would then be silently mismatched. Instead we
 * declare the core-protocol interface symbols directly and select by name.
 * This is fully static and immune to which copy is loaded (the symbols are
 * data, identical across copies). */
#define SHIM_IFACE_ENTRIES(X)                                                  \
    X(wl_buffer_interface)                                                     \
    X(wl_callback_interface)                                                   \
    X(wl_compositor_interface)                                                 \
    X(wl_data_device_interface)                                                \
    X(wl_data_device_manager_interface)                                        \
    X(wl_data_offer_interface)                                                 \
    X(wl_data_source_interface)                                                \
    X(wl_keyboard_interface)                                                   \
    X(wl_output_interface)                                                     \
    X(wl_pointer_interface)                                                    \
    X(wl_region_interface)                                                     \
    X(wl_registry_interface)                                                   \
    X(wl_seat_interface)                                                       \
    X(wl_shell_interface)                                                      \
    X(wl_shell_surface_interface)                                              \
    X(wl_shm_interface)                                                        \
    X(wl_shm_pool_interface)                                                   \
    X(wl_subcompositor_interface)                                              \
    X(wl_subsurface_interface)                                                 \
    X(wl_surface_interface)                                                    \
    X(wl_touch_interface)                                                      \
    /* xdg-shell (generated bindings resolve these by name too) */             \
    X(xdg_wm_base_interface)                                                   \
    X(xdg_positioner_interface)                                                \
    X(xdg_surface_interface)                                                   \
    X(xdg_toplevel_interface)                                                  \
    X(xdg_popup_interface)

#define SHIM_DECLARE_IFACE(sym) extern const struct wl_interface sym;
SHIM_IFACE_ENTRIES(SHIM_DECLARE_IFACE)
#undef SHIM_DECLARE_IFACE

/* xdg-shell interfaces are NOT exported by libwayland-client — they come from
 * generated protocol code (wayland-scanner private-code), built into the shim
 * itself (generated/xdg-shell-protocol.c defines them WL_PRIVATE, which
 * resolves within this DSO).  Include only the forward decls to reuse the
 * same symbol list in the lookup macro. */
#include "generated/xdg-shell-client-protocol.h"

void *wayland_shim_interface(const char *name)
{
    /* Generated code passes the protocol interface name ("wl_registry");
     * the C symbol is that name plus the "_interface" suffix. */
    char buf[64]; /* [SYNC:iface] sized for the longest entry + "_interface";
                     SHIM_IFACE_ENTRIES growth must re-check this bound (the
                     length guard below returns NULL, never overflows). */
    size_t n = strlen(name);
    if (n + sizeof("_interface") > sizeof(buf))
        return NULL;
    memcpy(buf, name, n);
    memcpy(buf + n, "_interface", sizeof("_interface"));
#define SHIM_CMP(sym)                                                          \
    if (strcmp(buf, #sym) == 0)                                                \
        return (void *)&sym;
    SHIM_IFACE_ENTRIES(SHIM_CMP)
#undef SHIM_CMP
    return NULL;
}

/* ---- captured event ---- */

#define SHIM_MAX_ARGS 16 /* [SYNC:shim] == MAX_EVENT_ARGS in core.mojo */

typedef struct shim_event {
    struct shim_event *next;
    uint32_t opcode;
    uint32_t nargs;
    union wl_argument args[SHIM_MAX_ARGS];
    /* malloc'd string copies; args[i].s points here for 's' args */
    char *owned[SHIM_MAX_ARGS];
} shim_event_t;

typedef struct shim_queue {
    shim_event_t *head;
    shim_event_t *tail;
} shim_queue_t;

static pthread_mutex_t g_lock = PTHREAD_MUTEX_INITIALIZER;

static void queue_push(shim_queue_t *q, shim_event_t *ev)
{
    pthread_mutex_lock(&g_lock);
    ev->next = NULL;
    if (q->tail)
        q->tail->next = ev;
    else
        q->head = ev;
    q->tail = ev;
    pthread_mutex_unlock(&g_lock);
}

/* Deep-copy args per the message signature, duplicating strings.
 * Signature walk skips wayland's numeric version qualifiers (digits after
 * 'o'/'n') and the '?' nullable marker; both are metadata, not args.
 * [SYNC:abi] out_args handed back to Mojo are consumed by the generated
 * next_* accessors — slot order MUST match the wire signature order. */
static void copy_args(shim_event_t *ev, const union wl_argument *src,
                      const char *signature)
{
    uint32_t n = 0;
    for (const char *c = signature; *c && n < SHIM_MAX_ARGS; c++) {
        char t = *c;
        if (t >= '0' && t <= '9')
            continue; /* version qualifier on object args, not an arg */
        if (t == '?')
            continue; /* nullable marker handled by following type char */
        ev->args[n] = src[n];
        ev->owned[n] = NULL;
        if (t == 's' && src[n].s) {
            size_t len = strlen(src[n].s) + 1;
            ev->owned[n] = (char *)malloc(len);
            if (ev->owned[n]) {
                memcpy(ev->owned[n], src[n].s, len);
                ev->args[n].s = ev->owned[n];
            }
        }
        n++;
    }
    ev->nargs = n;
}

static int shim_dispatcher(const void *user_data, void *target,
                           uint32_t opcode, const struct wl_message *msg,
                           union wl_argument *args)
{
    shim_queue_t *q = (shim_queue_t *)user_data;
    shim_event_t *ev = (shim_event_t *)calloc(1, sizeof(shim_event_t));
    if (!ev)
        return -1;
    ev->opcode = opcode;
    copy_args(ev, args, msg ? msg->signature : "");
    queue_push(q, ev);
    return 0;
}

/* Mojo-facing: install the capture dispatcher. Returns 0 on success. The
 * returned handle (written to *out_queue) is the shim-queue pointer; pop
 * functions take it instead of the proxy so we never need proxy lookups.
 * [LEAK] the queue is intentionally never freed (see MAINTENANCE notes). */
int wayland_shim_listen(void *proxy, const char *iface_name, void **out_queue)
{
    (void)iface_name;
    shim_queue_t *q = (shim_queue_t *)calloc(1, sizeof(shim_queue_t));
    if (!q)
        return -1;
    if (wl_proxy_add_dispatcher((struct wl_proxy *)proxy, shim_dispatcher, q,
                                NULL) < 0) {
        free(q);
        return -1;
    }
    if (out_queue)
        *out_queue = q;
    return 0;
}

/* Mojo-facing: pop the next captured event whose opcode matches, from the
 * queue returned by wayland_shim_listen. Returns the opcode, or -1 if none.
 * out_args must have room for SHIM_MAX_ARGS entries. 's' arguments are
 * malloc'd copies owned by the caller (free via wayland_shim_string_free). */
int wayland_shim_event_pop(void *queue, uint32_t opcode,
                           union wl_argument *out_args)
{
    shim_queue_t *q = (shim_queue_t *)queue;
    pthread_mutex_lock(&g_lock);
    shim_event_t **pp = &q->head;
    while (*pp) {
        if ((*pp)->opcode == opcode) {
            shim_event_t *ev = *pp;
            *pp = ev->next;
            if (q->tail == ev)
                q->tail = (*pp) ? q->tail : NULL;
            pthread_mutex_unlock(&g_lock);

            memset(out_args, 0, sizeof(union wl_argument) * SHIM_MAX_ARGS);
            for (uint32_t k = 0; k < ev->nargs; k++) {
                out_args[k] = ev->args[k];
                /* hand ownership of string copies to Mojo; clear the node's
                 * copy so the free below doesn't double-free. */
                ev->args[k].s = NULL;
                ev->owned[k] = NULL;
            }
            free(ev);
            return (int)opcode;
        }
        pp = &(*pp)->next;
    }
    pthread_mutex_unlock(&g_lock);
    return -1;
}

/* Free a string copy returned via a popped 's' argument. */
void wayland_shim_string_free(char *s)
{
    free(s);
}