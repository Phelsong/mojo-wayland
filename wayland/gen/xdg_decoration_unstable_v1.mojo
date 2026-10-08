# AUTO-GENERATED — DO NOT EDIT.
# from protocol 'xdg_decoration_unstable_v1'
from wayland.core import WLPtr, WLArgument, WLString, MAX_EVENT_ARGS, _cstr, _shim_listen, _shim_event_pop, _shim_string_free, _proxy_constructor_versioned, wl_proxy_marshal_array, wl_proxy_marshal_array_constructor_versioned, wl_proxy_destroy
from std.memory import stack_allocation

# ---- zxdg_decoration_manager_v1 v2 ----
def zxdg_decoration_manager_v1_destroy(self: WLPtr):
    # opcode 0: destructor
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 0, args_array)
    wl_proxy_destroy(self)


def zxdg_decoration_manager_v1_get_toplevel_decoration(self: WLPtr, toplevel: Pointer[NoneType, MutUntrackedOrigin]) raises -> WLPtr:
    # opcode 1: get_toplevel_decoration
    # opcode 1: get_toplevel_decoration, creates zxdg_toplevel_decoration_v1
    # slots follow wire-signature positions (new_id slot zeroed)
    var args_array = stack_allocation[2, WLArgument]()
    args_array[unsafe_offset=1] = WLArgument.make_o(toplevel)
    return _proxy_constructor_versioned(self, 1, args_array, "zxdg_toplevel_decoration_v1", 2)


# ---- zxdg_toplevel_decoration_v1 v2 ----
comptime ZXDG_TOPLEVEL_DECORATION_V1_CONFIGURE_OP: UInt32 = 0

comptime ZXDG_TOPLEVEL_DECORATION_V1_ERROR_UNCONFIGURED_BUFFER: UInt32 = 0
comptime ZXDG_TOPLEVEL_DECORATION_V1_ERROR_ALREADY_CONSTRUCTED: UInt32 = 1
comptime ZXDG_TOPLEVEL_DECORATION_V1_ERROR_ORPHANED: UInt32 = 2
comptime ZXDG_TOPLEVEL_DECORATION_V1_ERROR_INVALID_MODE: UInt32 = 3

comptime ZXDG_TOPLEVEL_DECORATION_V1_MODE_CLIENT_SIDE: UInt32 = 1
comptime ZXDG_TOPLEVEL_DECORATION_V1_MODE_SERVER_SIDE: UInt32 = 2

def zxdg_toplevel_decoration_v1_destroy(self: WLPtr):
    # opcode 0: destructor
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 0, args_array)
    wl_proxy_destroy(self)


def zxdg_toplevel_decoration_v1_set_mode(self: WLPtr, mode: UInt32):
    # opcode 1
    var args_array = stack_allocation[1, WLArgument]()
    args_array[unsafe_offset=0] = WLArgument.make_u(mode)
    wl_proxy_marshal_array(self, 1, args_array)


def zxdg_toplevel_decoration_v1_unset_mode(self: WLPtr):
    # opcode 2
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 2, args_array)


def zxdg_toplevel_decoration_v1_listen(self: WLPtr, out_queue: Pointer[WLPtr, MutUntrackedOrigin]) -> Int32:
    """Register the capture dispatcher on zxdg_toplevel_decoration_v1 and write
    the queue handle to out_queue[0]. Pop events from that queue."""
    return _shim_listen(self, "zxdg_toplevel_decoration_v1", out_queue)

def zxdg_toplevel_decoration_v1_next_configure(queue: WLPtr, out_args: Pointer[WLArgument, MutUntrackedOrigin]) -> Bool:
    """Pop the next pending configure event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 0, out_args)
    return rc == 0
