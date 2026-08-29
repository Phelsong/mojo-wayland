# AUTO-GENERATED — DO NOT EDIT.
# from protocol 'wayland'
from wayland.core import WLPtr, WLArgument, WLString, MAX_EVENT_ARGS, _cstr, _shim_listen, _shim_event_pop, _shim_string_free, _proxy_constructor_versioned, wl_proxy_marshal_array, wl_proxy_marshal_array_constructor_versioned, wl_proxy_destroy
from std.memory import stack_allocation

# ---- wl_display v1 ----
comptime DISPLAY_ERROR_OP: UInt32 = 0
comptime DISPLAY_DELETE_ID_OP: UInt32 = 1

comptime DISPLAY_ERROR_INVALID_OBJECT: UInt32 = 0
comptime DISPLAY_ERROR_INVALID_METHOD: UInt32 = 1
comptime DISPLAY_ERROR_NO_MEMORY: UInt32 = 2
comptime DISPLAY_ERROR_IMPLEMENTATION: UInt32 = 3

def wl_display_sync(self: WLPtr) raises -> WLPtr:
    # opcode 0: sync
    # opcode 0: sync, creates wl_callback
    # slots follow wire-signature positions (new_id slot zeroed)
    var args_array = stack_allocation[1, WLArgument]()
    return _proxy_constructor_versioned(self, 0, args_array, "wl_callback", 1)


def wl_display_get_registry(self: WLPtr) raises -> WLPtr:
    # opcode 1: get_registry
    # opcode 1: get_registry, creates wl_registry
    # slots follow wire-signature positions (new_id slot zeroed)
    var args_array = stack_allocation[1, WLArgument]()
    return _proxy_constructor_versioned(self, 1, args_array, "wl_registry", 1)


def wl_display_listen(self: WLPtr, out_queue: UnsafePointer[WLPtr, MutAnyOrigin]) -> Int32:
    """Register the capture dispatcher on wl_display and write
    the queue handle to out_queue[0]. Pop events from that queue."""
    return _shim_listen(self, "wl_display", out_queue)

def wl_display_next_error(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending error event into out_args (len 3). False = none."""
    var rc = _shim_event_pop(queue, 0, out_args)
    return rc == 0

def wl_display_next_delete_id(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending delete_id event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 1, out_args)
    return rc == 1

# ---- wl_registry v1 ----
comptime REGISTRY_GLOBAL_OP: UInt32 = 0
comptime REGISTRY_GLOBAL_REMOVE_OP: UInt32 = 1

def wl_registry_bind(self: WLPtr, iface: WLPtr, iface_name: WLString, name: UInt32, version: UInt32) -> WLPtr:
    # opcode 0: generic constructor (caller picks interface;
    # scanner synthesizes 's' interface-name + 'u' version wire args)
    var args_array = stack_allocation[3, WLArgument]()
    args_array[0] = WLArgument.make_u(name)
    args_array[1] = WLArgument.make_s(iface_name)
    args_array[2] = WLArgument.make_u(version)
    return wl_proxy_marshal_array_constructor_versioned(self, 0, args_array, iface, version)


def wl_registry_listen(self: WLPtr, out_queue: UnsafePointer[WLPtr, MutAnyOrigin]) -> Int32:
    """Register the capture dispatcher on wl_registry and write
    the queue handle to out_queue[0]. Pop events from that queue."""
    return _shim_listen(self, "wl_registry", out_queue)

def wl_registry_next_global(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending global event into out_args (len 3). False = none."""
    var rc = _shim_event_pop(queue, 0, out_args)
    return rc == 0

def wl_registry_next_global_remove(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending global_remove event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 1, out_args)
    return rc == 1

# ---- wl_callback v1 ----
comptime CALLBACK_DONE_OP: UInt32 = 0

def wl_callback_listen(self: WLPtr, out_queue: UnsafePointer[WLPtr, MutAnyOrigin]) -> Int32:
    """Register the capture dispatcher on wl_callback and write
    the queue handle to out_queue[0]. Pop events from that queue."""
    return _shim_listen(self, "wl_callback", out_queue)

def wl_callback_next_done(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending done event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 0, out_args)
    return rc == 0

# ---- wl_compositor v7 ----
def wl_compositor_create_surface(self: WLPtr) raises -> WLPtr:
    # opcode 0: create_surface
    # opcode 0: create_surface, creates wl_surface
    # slots follow wire-signature positions (new_id slot zeroed)
    var args_array = stack_allocation[1, WLArgument]()
    return _proxy_constructor_versioned(self, 0, args_array, "wl_surface", 7)


def wl_compositor_create_region(self: WLPtr) raises -> WLPtr:
    # opcode 1: create_region
    # opcode 1: create_region, creates wl_region
    # slots follow wire-signature positions (new_id slot zeroed)
    var args_array = stack_allocation[1, WLArgument]()
    return _proxy_constructor_versioned(self, 1, args_array, "wl_region", 7)


def wl_compositor_release(self: WLPtr):
    # opcode 2: destructor
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 2, args_array)
    wl_proxy_destroy(self)


# ---- wl_shm_pool v3 ----
comptime SHM_POOL_ERROR_INVALID_FORMAT: UInt32 = 0
comptime SHM_POOL_ERROR_INVALID_STRIDE: UInt32 = 1

def wl_shm_pool_create_buffer(self: WLPtr, offset: Int32, width: Int32, height: Int32, stride: Int32, format: UInt32) raises -> WLPtr:
    # opcode 0: create_buffer
    # opcode 0: create_buffer, creates wl_buffer
    # slots follow wire-signature positions (new_id slot zeroed)
    var args_array = stack_allocation[6, WLArgument]()
    args_array[1] = WLArgument.make_i(offset)
    args_array[2] = WLArgument.make_i(width)
    args_array[3] = WLArgument.make_i(height)
    args_array[4] = WLArgument.make_i(stride)
    args_array[5] = WLArgument.make_u(format)
    return _proxy_constructor_versioned(self, 0, args_array, "wl_buffer", 3)


def wl_shm_pool_destroy(self: WLPtr):
    # opcode 1: destructor
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 1, args_array)
    wl_proxy_destroy(self)


def wl_shm_pool_resize(self: WLPtr, size: Int32):
    # opcode 2
    var args_array = stack_allocation[1, WLArgument]()
    args_array[0] = WLArgument.make_i(size)
    wl_proxy_marshal_array(self, 2, args_array)


# ---- wl_shm v3 ----
comptime SHM_FORMAT_OP: UInt32 = 0

comptime SHM_ERROR_INVALID_FORMAT: UInt32 = 0
comptime SHM_ERROR_INVALID_STRIDE: UInt32 = 1
comptime SHM_ERROR_INVALID_FD: UInt32 = 2

comptime SHM_FORMAT_ARGB8888: UInt32 = 0
comptime SHM_FORMAT_XRGB8888: UInt32 = 1
comptime SHM_FORMAT_C8: UInt32 = 538982467
comptime SHM_FORMAT_RGB332: UInt32 = 943867730
comptime SHM_FORMAT_BGR233: UInt32 = 944916290
comptime SHM_FORMAT_XRGB4444: UInt32 = 842093144
comptime SHM_FORMAT_XBGR4444: UInt32 = 842089048
comptime SHM_FORMAT_RGBX4444: UInt32 = 842094674
comptime SHM_FORMAT_BGRX4444: UInt32 = 842094658
comptime SHM_FORMAT_ARGB4444: UInt32 = 842093121
comptime SHM_FORMAT_ABGR4444: UInt32 = 842089025
comptime SHM_FORMAT_RGBA4444: UInt32 = 842088786
comptime SHM_FORMAT_BGRA4444: UInt32 = 842088770
comptime SHM_FORMAT_XRGB1555: UInt32 = 892424792
comptime SHM_FORMAT_XBGR1555: UInt32 = 892420696
comptime SHM_FORMAT_RGBX5551: UInt32 = 892426322
comptime SHM_FORMAT_BGRX5551: UInt32 = 892426306
comptime SHM_FORMAT_ARGB1555: UInt32 = 892424769
comptime SHM_FORMAT_ABGR1555: UInt32 = 892420673
comptime SHM_FORMAT_RGBA5551: UInt32 = 892420434
comptime SHM_FORMAT_BGRA5551: UInt32 = 892420418
comptime SHM_FORMAT_RGB565: UInt32 = 909199186
comptime SHM_FORMAT_BGR565: UInt32 = 909199170
comptime SHM_FORMAT_RGB888: UInt32 = 875710290
comptime SHM_FORMAT_BGR888: UInt32 = 875710274
comptime SHM_FORMAT_XBGR8888: UInt32 = 875709016
comptime SHM_FORMAT_RGBX8888: UInt32 = 875714642
comptime SHM_FORMAT_BGRX8888: UInt32 = 875714626
comptime SHM_FORMAT_ABGR8888: UInt32 = 875708993
comptime SHM_FORMAT_RGBA8888: UInt32 = 875708754
comptime SHM_FORMAT_BGRA8888: UInt32 = 875708738
comptime SHM_FORMAT_XRGB2101010: UInt32 = 808669784
comptime SHM_FORMAT_XBGR2101010: UInt32 = 808665688
comptime SHM_FORMAT_RGBX1010102: UInt32 = 808671314
comptime SHM_FORMAT_BGRX1010102: UInt32 = 808671298
comptime SHM_FORMAT_ARGB2101010: UInt32 = 808669761
comptime SHM_FORMAT_ABGR2101010: UInt32 = 808665665
comptime SHM_FORMAT_RGBA1010102: UInt32 = 808665426
comptime SHM_FORMAT_BGRA1010102: UInt32 = 808665410
comptime SHM_FORMAT_YUYV: UInt32 = 1448695129
comptime SHM_FORMAT_YVYU: UInt32 = 1431918169
comptime SHM_FORMAT_UYVY: UInt32 = 1498831189
comptime SHM_FORMAT_VYUY: UInt32 = 1498765654
comptime SHM_FORMAT_AYUV: UInt32 = 1448433985
comptime SHM_FORMAT_NV12: UInt32 = 842094158
comptime SHM_FORMAT_NV21: UInt32 = 825382478
comptime SHM_FORMAT_NV16: UInt32 = 909203022
comptime SHM_FORMAT_NV61: UInt32 = 825644622
comptime SHM_FORMAT_YUV410: UInt32 = 961959257
comptime SHM_FORMAT_YVU410: UInt32 = 961893977
comptime SHM_FORMAT_YUV411: UInt32 = 825316697
comptime SHM_FORMAT_YVU411: UInt32 = 825316953
comptime SHM_FORMAT_YUV420: UInt32 = 842093913
comptime SHM_FORMAT_YVU420: UInt32 = 842094169
comptime SHM_FORMAT_YUV422: UInt32 = 909202777
comptime SHM_FORMAT_YVU422: UInt32 = 909203033
comptime SHM_FORMAT_YUV444: UInt32 = 875713881
comptime SHM_FORMAT_YVU444: UInt32 = 875714137
comptime SHM_FORMAT_R8: UInt32 = 538982482
comptime SHM_FORMAT_R16: UInt32 = 540422482
comptime SHM_FORMAT_RG88: UInt32 = 943212370
comptime SHM_FORMAT_GR88: UInt32 = 943215175
comptime SHM_FORMAT_RG1616: UInt32 = 842221394
comptime SHM_FORMAT_GR1616: UInt32 = 842224199
comptime SHM_FORMAT_XRGB16161616F: UInt32 = 1211388504
comptime SHM_FORMAT_XBGR16161616F: UInt32 = 1211384408
comptime SHM_FORMAT_ARGB16161616F: UInt32 = 1211388481
comptime SHM_FORMAT_ABGR16161616F: UInt32 = 1211384385
comptime SHM_FORMAT_XYUV8888: UInt32 = 1448434008
comptime SHM_FORMAT_VUY888: UInt32 = 875713878
comptime SHM_FORMAT_VUY101010: UInt32 = 808670550
comptime SHM_FORMAT_Y210: UInt32 = 808530521
comptime SHM_FORMAT_Y212: UInt32 = 842084953
comptime SHM_FORMAT_Y216: UInt32 = 909193817
comptime SHM_FORMAT_Y410: UInt32 = 808531033
comptime SHM_FORMAT_Y412: UInt32 = 842085465
comptime SHM_FORMAT_Y416: UInt32 = 909194329
comptime SHM_FORMAT_XVYU2101010: UInt32 = 808670808
comptime SHM_FORMAT_XVYU12_16161616: UInt32 = 909334104
comptime SHM_FORMAT_XVYU16161616: UInt32 = 942954072
comptime SHM_FORMAT_Y0L0: UInt32 = 810299481
comptime SHM_FORMAT_X0L0: UInt32 = 810299480
comptime SHM_FORMAT_Y0L2: UInt32 = 843853913
comptime SHM_FORMAT_X0L2: UInt32 = 843853912
comptime SHM_FORMAT_YUV420_8BIT: UInt32 = 942691673
comptime SHM_FORMAT_YUV420_10BIT: UInt32 = 808539481
comptime SHM_FORMAT_XRGB8888_A8: UInt32 = 943805016
comptime SHM_FORMAT_XBGR8888_A8: UInt32 = 943800920
comptime SHM_FORMAT_RGBX8888_A8: UInt32 = 943806546
comptime SHM_FORMAT_BGRX8888_A8: UInt32 = 943806530
comptime SHM_FORMAT_RGB888_A8: UInt32 = 943798354
comptime SHM_FORMAT_BGR888_A8: UInt32 = 943798338
comptime SHM_FORMAT_RGB565_A8: UInt32 = 943797586
comptime SHM_FORMAT_BGR565_A8: UInt32 = 943797570
comptime SHM_FORMAT_NV24: UInt32 = 875714126
comptime SHM_FORMAT_NV42: UInt32 = 842290766
comptime SHM_FORMAT_P210: UInt32 = 808530512
comptime SHM_FORMAT_P010: UInt32 = 808530000
comptime SHM_FORMAT_P012: UInt32 = 842084432
comptime SHM_FORMAT_P016: UInt32 = 909193296
comptime SHM_FORMAT_AXBXGXRX106106106106: UInt32 = 808534593
comptime SHM_FORMAT_NV15: UInt32 = 892425806
comptime SHM_FORMAT_Q410: UInt32 = 808531025
comptime SHM_FORMAT_Q401: UInt32 = 825242705
comptime SHM_FORMAT_XRGB16161616: UInt32 = 942953048
comptime SHM_FORMAT_XBGR16161616: UInt32 = 942948952
comptime SHM_FORMAT_ARGB16161616: UInt32 = 942953025
comptime SHM_FORMAT_ABGR16161616: UInt32 = 942948929
comptime SHM_FORMAT_C1: UInt32 = 538980675
comptime SHM_FORMAT_C2: UInt32 = 538980931
comptime SHM_FORMAT_C4: UInt32 = 538981443
comptime SHM_FORMAT_D1: UInt32 = 538980676
comptime SHM_FORMAT_D2: UInt32 = 538980932
comptime SHM_FORMAT_D4: UInt32 = 538981444
comptime SHM_FORMAT_D8: UInt32 = 538982468
comptime SHM_FORMAT_R1: UInt32 = 538980690
comptime SHM_FORMAT_R2: UInt32 = 538980946
comptime SHM_FORMAT_R4: UInt32 = 538981458
comptime SHM_FORMAT_R10: UInt32 = 540029266
comptime SHM_FORMAT_R12: UInt32 = 540160338
comptime SHM_FORMAT_AVUY8888: UInt32 = 1498764865
comptime SHM_FORMAT_XVUY8888: UInt32 = 1498764888
comptime SHM_FORMAT_P030: UInt32 = 808661072
comptime SHM_FORMAT_RGB161616: UInt32 = 942950226
comptime SHM_FORMAT_BGR161616: UInt32 = 942950210
comptime SHM_FORMAT_R16F: UInt32 = 1210064978
comptime SHM_FORMAT_GR1616F: UInt32 = 1210077767
comptime SHM_FORMAT_BGR161616F: UInt32 = 1213351746
comptime SHM_FORMAT_R32F: UInt32 = 1176510546
comptime SHM_FORMAT_GR3232F: UInt32 = 1176523335
comptime SHM_FORMAT_BGR323232F: UInt32 = 1179797314
comptime SHM_FORMAT_ABGR32323232F: UInt32 = 1178092097
comptime SHM_FORMAT_NV20: UInt32 = 808605262
comptime SHM_FORMAT_NV30: UInt32 = 808670798
comptime SHM_FORMAT_S010: UInt32 = 808530003
comptime SHM_FORMAT_S210: UInt32 = 808530515
comptime SHM_FORMAT_S410: UInt32 = 808531027
comptime SHM_FORMAT_S012: UInt32 = 842084435
comptime SHM_FORMAT_S212: UInt32 = 842084947
comptime SHM_FORMAT_S412: UInt32 = 842085459
comptime SHM_FORMAT_S016: UInt32 = 909193299
comptime SHM_FORMAT_S216: UInt32 = 909193811
comptime SHM_FORMAT_S416: UInt32 = 909194323
comptime SHM_FORMAT_XVUY2101010: UInt32 = 808671576
comptime SHM_FORMAT_P230: UInt32 = 808661584
comptime SHM_FORMAT_T430: UInt32 = 808662100
comptime SHM_FORMAT_Y8: UInt32 = 1497715271
comptime SHM_FORMAT_XYYY2101010: UInt32 = 876695641

def wl_shm_create_pool(self: WLPtr, fd: Int32, size: Int32) raises -> WLPtr:
    # opcode 0: create_pool
    # opcode 0: create_pool, creates wl_shm_pool
    # slots follow wire-signature positions (new_id slot zeroed)
    var args_array = stack_allocation[3, WLArgument]()
    args_array[1] = WLArgument.make_h(fd)
    args_array[2] = WLArgument.make_i(size)
    return _proxy_constructor_versioned(self, 0, args_array, "wl_shm_pool", 3)


def wl_shm_release(self: WLPtr):
    # opcode 1: destructor
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 1, args_array)
    wl_proxy_destroy(self)


def wl_shm_listen(self: WLPtr, out_queue: UnsafePointer[WLPtr, MutAnyOrigin]) -> Int32:
    """Register the capture dispatcher on wl_shm and write
    the queue handle to out_queue[0]. Pop events from that queue."""
    return _shim_listen(self, "wl_shm", out_queue)

def wl_shm_next_format(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending format event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 0, out_args)
    return rc == 0

# ---- wl_buffer v1 ----
comptime BUFFER_RELEASE_OP: UInt32 = 0

def wl_buffer_destroy(self: WLPtr):
    # opcode 0: destructor
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 0, args_array)
    wl_proxy_destroy(self)


def wl_buffer_listen(self: WLPtr, out_queue: UnsafePointer[WLPtr, MutAnyOrigin]) -> Int32:
    """Register the capture dispatcher on wl_buffer and write
    the queue handle to out_queue[0]. Pop events from that queue."""
    return _shim_listen(self, "wl_buffer", out_queue)

def wl_buffer_next_release(queue: WLPtr) -> Bool:
    """Pop the next pending release event. False = none."""
    var scratch = stack_allocation[1, WLArgument]()
    var rc = _shim_event_pop(queue, 0, scratch)
    return rc == 0

# ---- wl_data_offer v4 ----
comptime DATA_OFFER_OFFER_OP: UInt32 = 0
comptime DATA_OFFER_SOURCE_ACTIONS_OP: UInt32 = 1
comptime DATA_OFFER_ACTION_OP: UInt32 = 2

comptime DATA_OFFER_ERROR_INVALID_FINISH: UInt32 = 0
comptime DATA_OFFER_ERROR_INVALID_ACTION_MASK: UInt32 = 1
comptime DATA_OFFER_ERROR_INVALID_ACTION: UInt32 = 2
comptime DATA_OFFER_ERROR_INVALID_OFFER: UInt32 = 3

def wl_data_offer_accept(self: WLPtr, serial: UInt32, mime_type: WLString):
    # opcode 0
    var args_array = stack_allocation[2, WLArgument]()
    args_array[0] = WLArgument.make_u(serial)
    args_array[1] = WLArgument.make_s(mime_type)
    wl_proxy_marshal_array(self, 0, args_array)


def wl_data_offer_receive(self: WLPtr, mime_type: WLString, fd: Int32):
    # opcode 1
    var args_array = stack_allocation[2, WLArgument]()
    args_array[0] = WLArgument.make_s(mime_type)
    args_array[1] = WLArgument.make_h(fd)
    wl_proxy_marshal_array(self, 1, args_array)


def wl_data_offer_destroy(self: WLPtr):
    # opcode 2: destructor
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 2, args_array)
    wl_proxy_destroy(self)


def wl_data_offer_finish(self: WLPtr):
    # opcode 3
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 3, args_array)


def wl_data_offer_set_actions(self: WLPtr, dnd_actions: UInt32, preferred_action: UInt32):
    # opcode 4
    var args_array = stack_allocation[2, WLArgument]()
    args_array[0] = WLArgument.make_u(dnd_actions)
    args_array[1] = WLArgument.make_u(preferred_action)
    wl_proxy_marshal_array(self, 4, args_array)


def wl_data_offer_listen(self: WLPtr, out_queue: UnsafePointer[WLPtr, MutAnyOrigin]) -> Int32:
    """Register the capture dispatcher on wl_data_offer and write
    the queue handle to out_queue[0]. Pop events from that queue."""
    return _shim_listen(self, "wl_data_offer", out_queue)

def wl_data_offer_next_offer(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending offer event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 0, out_args)
    return rc == 0

def wl_data_offer_next_source_actions(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending source_actions event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 1, out_args)
    return rc == 1

def wl_data_offer_next_action(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending action event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 2, out_args)
    return rc == 2

# ---- wl_data_source v4 ----
comptime DATA_SOURCE_TARGET_OP: UInt32 = 0
comptime DATA_SOURCE_SEND_OP: UInt32 = 1
comptime DATA_SOURCE_CANCELLED_OP: UInt32 = 2
comptime DATA_SOURCE_DND_DROP_PERFORMED_OP: UInt32 = 3
comptime DATA_SOURCE_DND_FINISHED_OP: UInt32 = 4
comptime DATA_SOURCE_ACTION_OP: UInt32 = 5

comptime DATA_SOURCE_ERROR_INVALID_ACTION_MASK: UInt32 = 0
comptime DATA_SOURCE_ERROR_INVALID_SOURCE: UInt32 = 1

def wl_data_source_offer(self: WLPtr, mime_type: WLString):
    # opcode 0
    var args_array = stack_allocation[1, WLArgument]()
    args_array[0] = WLArgument.make_s(mime_type)
    wl_proxy_marshal_array(self, 0, args_array)


def wl_data_source_destroy(self: WLPtr):
    # opcode 1: destructor
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 1, args_array)
    wl_proxy_destroy(self)


def wl_data_source_set_actions(self: WLPtr, dnd_actions: UInt32):
    # opcode 2
    var args_array = stack_allocation[1, WLArgument]()
    args_array[0] = WLArgument.make_u(dnd_actions)
    wl_proxy_marshal_array(self, 2, args_array)


def wl_data_source_listen(self: WLPtr, out_queue: UnsafePointer[WLPtr, MutAnyOrigin]) -> Int32:
    """Register the capture dispatcher on wl_data_source and write
    the queue handle to out_queue[0]. Pop events from that queue."""
    return _shim_listen(self, "wl_data_source", out_queue)

def wl_data_source_next_target(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending target event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 0, out_args)
    return rc == 0

def wl_data_source_next_send(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending send event into out_args (len 2). False = none."""
    var rc = _shim_event_pop(queue, 1, out_args)
    return rc == 1

def wl_data_source_next_cancelled(queue: WLPtr) -> Bool:
    """Pop the next pending cancelled event. False = none."""
    var scratch = stack_allocation[1, WLArgument]()
    var rc = _shim_event_pop(queue, 2, scratch)
    return rc == 2

def wl_data_source_next_dnd_drop_performed(queue: WLPtr) -> Bool:
    """Pop the next pending dnd_drop_performed event. False = none."""
    var scratch = stack_allocation[1, WLArgument]()
    var rc = _shim_event_pop(queue, 3, scratch)
    return rc == 3

def wl_data_source_next_dnd_finished(queue: WLPtr) -> Bool:
    """Pop the next pending dnd_finished event. False = none."""
    var scratch = stack_allocation[1, WLArgument]()
    var rc = _shim_event_pop(queue, 4, scratch)
    return rc == 4

def wl_data_source_next_action(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending action event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 5, out_args)
    return rc == 5

# ---- wl_data_device v4 ----
comptime DATA_DEVICE_DATA_OFFER_OP: UInt32 = 0
comptime DATA_DEVICE_ENTER_OP: UInt32 = 1
comptime DATA_DEVICE_LEAVE_OP: UInt32 = 2
comptime DATA_DEVICE_MOTION_OP: UInt32 = 3
comptime DATA_DEVICE_DROP_OP: UInt32 = 4
comptime DATA_DEVICE_SELECTION_OP: UInt32 = 5

comptime DATA_DEVICE_ERROR_ROLE: UInt32 = 0
comptime DATA_DEVICE_ERROR_USED_SOURCE: UInt32 = 1

def wl_data_device_start_drag(self: WLPtr, source: UnsafePointer[NoneType, MutAnyOrigin], origin: UnsafePointer[NoneType, MutAnyOrigin], icon: UnsafePointer[NoneType, MutAnyOrigin], serial: UInt32):
    # opcode 0
    var args_array = stack_allocation[4, WLArgument]()
    args_array[0] = WLArgument.make_o(source)
    args_array[1] = WLArgument.make_o(origin)
    args_array[2] = WLArgument.make_o(icon)
    args_array[3] = WLArgument.make_u(serial)
    wl_proxy_marshal_array(self, 0, args_array)


def wl_data_device_set_selection(self: WLPtr, source: UnsafePointer[NoneType, MutAnyOrigin], serial: UInt32):
    # opcode 1
    var args_array = stack_allocation[2, WLArgument]()
    args_array[0] = WLArgument.make_o(source)
    args_array[1] = WLArgument.make_u(serial)
    wl_proxy_marshal_array(self, 1, args_array)


def wl_data_device_release(self: WLPtr):
    # opcode 2: destructor
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 2, args_array)
    wl_proxy_destroy(self)


def wl_data_device_listen(self: WLPtr, out_queue: UnsafePointer[WLPtr, MutAnyOrigin]) -> Int32:
    """Register the capture dispatcher on wl_data_device and write
    the queue handle to out_queue[0]. Pop events from that queue."""
    return _shim_listen(self, "wl_data_device", out_queue)

def wl_data_device_next_data_offer(queue: WLPtr) -> Bool:
    """Pop the next pending data_offer event. False = none."""
    var scratch = stack_allocation[1, WLArgument]()
    var rc = _shim_event_pop(queue, 0, scratch)
    return rc == 0

def wl_data_device_next_enter(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending enter event into out_args (len 5). False = none."""
    var rc = _shim_event_pop(queue, 1, out_args)
    return rc == 1

def wl_data_device_next_leave(queue: WLPtr) -> Bool:
    """Pop the next pending leave event. False = none."""
    var scratch = stack_allocation[1, WLArgument]()
    var rc = _shim_event_pop(queue, 2, scratch)
    return rc == 2

def wl_data_device_next_motion(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending motion event into out_args (len 3). False = none."""
    var rc = _shim_event_pop(queue, 3, out_args)
    return rc == 3

def wl_data_device_next_drop(queue: WLPtr) -> Bool:
    """Pop the next pending drop event. False = none."""
    var scratch = stack_allocation[1, WLArgument]()
    var rc = _shim_event_pop(queue, 4, scratch)
    return rc == 4

def wl_data_device_next_selection(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending selection event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 5, out_args)
    return rc == 5

# ---- wl_data_device_manager v4 ----
comptime DATA_DEVICE_MANAGER_DND_ACTION_NONE: UInt32 = 0
comptime DATA_DEVICE_MANAGER_DND_ACTION_COPY: UInt32 = 1
comptime DATA_DEVICE_MANAGER_DND_ACTION_MOVE: UInt32 = 2
comptime DATA_DEVICE_MANAGER_DND_ACTION_ASK: UInt32 = 4

def wl_data_device_manager_create_data_source(self: WLPtr) raises -> WLPtr:
    # opcode 0: create_data_source
    # opcode 0: create_data_source, creates wl_data_source
    # slots follow wire-signature positions (new_id slot zeroed)
    var args_array = stack_allocation[1, WLArgument]()
    return _proxy_constructor_versioned(self, 0, args_array, "wl_data_source", 4)


def wl_data_device_manager_get_data_device(self: WLPtr, seat: UnsafePointer[NoneType, MutAnyOrigin]) raises -> WLPtr:
    # opcode 1: get_data_device
    # opcode 1: get_data_device, creates wl_data_device
    # slots follow wire-signature positions (new_id slot zeroed)
    var args_array = stack_allocation[2, WLArgument]()
    args_array[1] = WLArgument.make_o(seat)
    return _proxy_constructor_versioned(self, 1, args_array, "wl_data_device", 4)


def wl_data_device_manager_release(self: WLPtr):
    # opcode 2: destructor
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 2, args_array)
    wl_proxy_destroy(self)


# ---- wl_shell v1 ----
comptime SHELL_ERROR_ROLE: UInt32 = 0

def wl_shell_get_shell_surface(self: WLPtr, surface: UnsafePointer[NoneType, MutAnyOrigin]) raises -> WLPtr:
    # opcode 0: get_shell_surface
    # opcode 0: get_shell_surface, creates wl_shell_surface
    # slots follow wire-signature positions (new_id slot zeroed)
    var args_array = stack_allocation[2, WLArgument]()
    args_array[1] = WLArgument.make_o(surface)
    return _proxy_constructor_versioned(self, 0, args_array, "wl_shell_surface", 1)


# ---- wl_shell_surface v1 ----
comptime SHELL_SURFACE_PING_OP: UInt32 = 0
comptime SHELL_SURFACE_CONFIGURE_OP: UInt32 = 1
comptime SHELL_SURFACE_POPUP_DONE_OP: UInt32 = 2

comptime SHELL_SURFACE_RESIZE_NONE: UInt32 = 0
comptime SHELL_SURFACE_RESIZE_TOP: UInt32 = 1
comptime SHELL_SURFACE_RESIZE_BOTTOM: UInt32 = 2
comptime SHELL_SURFACE_RESIZE_LEFT: UInt32 = 4
comptime SHELL_SURFACE_RESIZE_TOP_LEFT: UInt32 = 5
comptime SHELL_SURFACE_RESIZE_BOTTOM_LEFT: UInt32 = 6
comptime SHELL_SURFACE_RESIZE_RIGHT: UInt32 = 8
comptime SHELL_SURFACE_RESIZE_TOP_RIGHT: UInt32 = 9
comptime SHELL_SURFACE_RESIZE_BOTTOM_RIGHT: UInt32 = 10

comptime SHELL_SURFACE_TRANSIENT_INACTIVE: UInt32 = 1

comptime SHELL_SURFACE_FULLSCREEN_METHOD_DEFAULT: UInt32 = 0
comptime SHELL_SURFACE_FULLSCREEN_METHOD_SCALE: UInt32 = 1
comptime SHELL_SURFACE_FULLSCREEN_METHOD_DRIVER: UInt32 = 2
comptime SHELL_SURFACE_FULLSCREEN_METHOD_FILL: UInt32 = 3

def wl_shell_surface_pong(self: WLPtr, serial: UInt32):
    # opcode 0
    var args_array = stack_allocation[1, WLArgument]()
    args_array[0] = WLArgument.make_u(serial)
    wl_proxy_marshal_array(self, 0, args_array)


def wl_shell_surface_move(self: WLPtr, seat: UnsafePointer[NoneType, MutAnyOrigin], serial: UInt32):
    # opcode 1
    var args_array = stack_allocation[2, WLArgument]()
    args_array[0] = WLArgument.make_o(seat)
    args_array[1] = WLArgument.make_u(serial)
    wl_proxy_marshal_array(self, 1, args_array)


def wl_shell_surface_resize(self: WLPtr, seat: UnsafePointer[NoneType, MutAnyOrigin], serial: UInt32, edges: UInt32):
    # opcode 2
    var args_array = stack_allocation[3, WLArgument]()
    args_array[0] = WLArgument.make_o(seat)
    args_array[1] = WLArgument.make_u(serial)
    args_array[2] = WLArgument.make_u(edges)
    wl_proxy_marshal_array(self, 2, args_array)


def wl_shell_surface_set_toplevel(self: WLPtr):
    # opcode 3
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 3, args_array)


def wl_shell_surface_set_transient(self: WLPtr, parent: UnsafePointer[NoneType, MutAnyOrigin], x: Int32, y: Int32, flags: UInt32):
    # opcode 4
    var args_array = stack_allocation[4, WLArgument]()
    args_array[0] = WLArgument.make_o(parent)
    args_array[1] = WLArgument.make_i(x)
    args_array[2] = WLArgument.make_i(y)
    args_array[3] = WLArgument.make_u(flags)
    wl_proxy_marshal_array(self, 4, args_array)


def wl_shell_surface_set_fullscreen(self: WLPtr, method: UInt32, framerate: UInt32, output: UnsafePointer[NoneType, MutAnyOrigin]):
    # opcode 5
    var args_array = stack_allocation[3, WLArgument]()
    args_array[0] = WLArgument.make_u(method)
    args_array[1] = WLArgument.make_u(framerate)
    args_array[2] = WLArgument.make_o(output)
    wl_proxy_marshal_array(self, 5, args_array)


def wl_shell_surface_set_popup(self: WLPtr, seat: UnsafePointer[NoneType, MutAnyOrigin], serial: UInt32, parent: UnsafePointer[NoneType, MutAnyOrigin], x: Int32, y: Int32, flags: UInt32):
    # opcode 6
    var args_array = stack_allocation[6, WLArgument]()
    args_array[0] = WLArgument.make_o(seat)
    args_array[1] = WLArgument.make_u(serial)
    args_array[2] = WLArgument.make_o(parent)
    args_array[3] = WLArgument.make_i(x)
    args_array[4] = WLArgument.make_i(y)
    args_array[5] = WLArgument.make_u(flags)
    wl_proxy_marshal_array(self, 6, args_array)


def wl_shell_surface_set_maximized(self: WLPtr, output: UnsafePointer[NoneType, MutAnyOrigin]):
    # opcode 7
    var args_array = stack_allocation[1, WLArgument]()
    args_array[0] = WLArgument.make_o(output)
    wl_proxy_marshal_array(self, 7, args_array)


def wl_shell_surface_set_title(self: WLPtr, title: WLString):
    # opcode 8
    var args_array = stack_allocation[1, WLArgument]()
    args_array[0] = WLArgument.make_s(title)
    wl_proxy_marshal_array(self, 8, args_array)


def wl_shell_surface_set_class(self: WLPtr, class_: WLString):
    # opcode 9
    var args_array = stack_allocation[1, WLArgument]()
    args_array[0] = WLArgument.make_s(class_)
    wl_proxy_marshal_array(self, 9, args_array)


def wl_shell_surface_listen(self: WLPtr, out_queue: UnsafePointer[WLPtr, MutAnyOrigin]) -> Int32:
    """Register the capture dispatcher on wl_shell_surface and write
    the queue handle to out_queue[0]. Pop events from that queue."""
    return _shim_listen(self, "wl_shell_surface", out_queue)

def wl_shell_surface_next_ping(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending ping event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 0, out_args)
    return rc == 0

def wl_shell_surface_next_configure(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending configure event into out_args (len 3). False = none."""
    var rc = _shim_event_pop(queue, 1, out_args)
    return rc == 1

def wl_shell_surface_next_popup_done(queue: WLPtr) -> Bool:
    """Pop the next pending popup_done event. False = none."""
    var scratch = stack_allocation[1, WLArgument]()
    var rc = _shim_event_pop(queue, 2, scratch)
    return rc == 2

# ---- wl_surface v7 ----
comptime SURFACE_ENTER_OP: UInt32 = 0
comptime SURFACE_LEAVE_OP: UInt32 = 1
comptime SURFACE_PREFERRED_BUFFER_SCALE_OP: UInt32 = 2
comptime SURFACE_PREFERRED_BUFFER_TRANSFORM_OP: UInt32 = 3

comptime SURFACE_ERROR_INVALID_SCALE: UInt32 = 0
comptime SURFACE_ERROR_INVALID_TRANSFORM: UInt32 = 1
comptime SURFACE_ERROR_INVALID_SIZE: UInt32 = 2
comptime SURFACE_ERROR_INVALID_OFFSET: UInt32 = 3
comptime SURFACE_ERROR_DEFUNCT_ROLE_OBJECT: UInt32 = 4
comptime SURFACE_ERROR_NO_BUFFER: UInt32 = 5

def wl_surface_destroy(self: WLPtr):
    # opcode 0: destructor
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 0, args_array)
    wl_proxy_destroy(self)


def wl_surface_attach(self: WLPtr, buffer: UnsafePointer[NoneType, MutAnyOrigin], x: Int32, y: Int32):
    # opcode 1
    var args_array = stack_allocation[3, WLArgument]()
    args_array[0] = WLArgument.make_o(buffer)
    args_array[1] = WLArgument.make_i(x)
    args_array[2] = WLArgument.make_i(y)
    wl_proxy_marshal_array(self, 1, args_array)


def wl_surface_damage(self: WLPtr, x: Int32, y: Int32, width: Int32, height: Int32):
    # opcode 2
    var args_array = stack_allocation[4, WLArgument]()
    args_array[0] = WLArgument.make_i(x)
    args_array[1] = WLArgument.make_i(y)
    args_array[2] = WLArgument.make_i(width)
    args_array[3] = WLArgument.make_i(height)
    wl_proxy_marshal_array(self, 2, args_array)


def wl_surface_frame(self: WLPtr) raises -> WLPtr:
    # opcode 3: frame
    # opcode 3: frame, creates wl_callback
    # slots follow wire-signature positions (new_id slot zeroed)
    var args_array = stack_allocation[1, WLArgument]()
    return _proxy_constructor_versioned(self, 3, args_array, "wl_callback", 7)


def wl_surface_set_opaque_region(self: WLPtr, region: UnsafePointer[NoneType, MutAnyOrigin]):
    # opcode 4
    var args_array = stack_allocation[1, WLArgument]()
    args_array[0] = WLArgument.make_o(region)
    wl_proxy_marshal_array(self, 4, args_array)


def wl_surface_set_input_region(self: WLPtr, region: UnsafePointer[NoneType, MutAnyOrigin]):
    # opcode 5
    var args_array = stack_allocation[1, WLArgument]()
    args_array[0] = WLArgument.make_o(region)
    wl_proxy_marshal_array(self, 5, args_array)


def wl_surface_commit(self: WLPtr):
    # opcode 6
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 6, args_array)


def wl_surface_set_buffer_transform(self: WLPtr, transform: Int32):
    # opcode 7
    var args_array = stack_allocation[1, WLArgument]()
    args_array[0] = WLArgument.make_i(transform)
    wl_proxy_marshal_array(self, 7, args_array)


def wl_surface_set_buffer_scale(self: WLPtr, scale: Int32):
    # opcode 8
    var args_array = stack_allocation[1, WLArgument]()
    args_array[0] = WLArgument.make_i(scale)
    wl_proxy_marshal_array(self, 8, args_array)


def wl_surface_damage_buffer(self: WLPtr, x: Int32, y: Int32, width: Int32, height: Int32):
    # opcode 9
    var args_array = stack_allocation[4, WLArgument]()
    args_array[0] = WLArgument.make_i(x)
    args_array[1] = WLArgument.make_i(y)
    args_array[2] = WLArgument.make_i(width)
    args_array[3] = WLArgument.make_i(height)
    wl_proxy_marshal_array(self, 9, args_array)


def wl_surface_offset(self: WLPtr, x: Int32, y: Int32):
    # opcode 10
    var args_array = stack_allocation[2, WLArgument]()
    args_array[0] = WLArgument.make_i(x)
    args_array[1] = WLArgument.make_i(y)
    wl_proxy_marshal_array(self, 10, args_array)


def wl_surface_get_release(self: WLPtr) raises -> WLPtr:
    # opcode 11: get_release
    # opcode 11: get_release, creates wl_callback
    # slots follow wire-signature positions (new_id slot zeroed)
    var args_array = stack_allocation[1, WLArgument]()
    return _proxy_constructor_versioned(self, 11, args_array, "wl_callback", 7)


def wl_surface_listen(self: WLPtr, out_queue: UnsafePointer[WLPtr, MutAnyOrigin]) -> Int32:
    """Register the capture dispatcher on wl_surface and write
    the queue handle to out_queue[0]. Pop events from that queue."""
    return _shim_listen(self, "wl_surface", out_queue)

def wl_surface_next_enter(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending enter event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 0, out_args)
    return rc == 0

def wl_surface_next_leave(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending leave event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 1, out_args)
    return rc == 1

def wl_surface_next_preferred_buffer_scale(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending preferred_buffer_scale event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 2, out_args)
    return rc == 2

def wl_surface_next_preferred_buffer_transform(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending preferred_buffer_transform event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 3, out_args)
    return rc == 3

# ---- wl_seat v11 ----
comptime SEAT_CAPABILITIES_OP: UInt32 = 0
comptime SEAT_NAME_OP: UInt32 = 1

comptime SEAT_CAPABILITY_POINTER: UInt32 = 1
comptime SEAT_CAPABILITY_KEYBOARD: UInt32 = 2
comptime SEAT_CAPABILITY_TOUCH: UInt32 = 4

comptime SEAT_ERROR_MISSING_CAPABILITY: UInt32 = 0

def wl_seat_get_pointer(self: WLPtr) raises -> WLPtr:
    # opcode 0: get_pointer
    # opcode 0: get_pointer, creates wl_pointer
    # slots follow wire-signature positions (new_id slot zeroed)
    var args_array = stack_allocation[1, WLArgument]()
    return _proxy_constructor_versioned(self, 0, args_array, "wl_pointer", 11)


def wl_seat_get_keyboard(self: WLPtr) raises -> WLPtr:
    # opcode 1: get_keyboard
    # opcode 1: get_keyboard, creates wl_keyboard
    # slots follow wire-signature positions (new_id slot zeroed)
    var args_array = stack_allocation[1, WLArgument]()
    return _proxy_constructor_versioned(self, 1, args_array, "wl_keyboard", 11)


def wl_seat_get_touch(self: WLPtr) raises -> WLPtr:
    # opcode 2: get_touch
    # opcode 2: get_touch, creates wl_touch
    # slots follow wire-signature positions (new_id slot zeroed)
    var args_array = stack_allocation[1, WLArgument]()
    return _proxy_constructor_versioned(self, 2, args_array, "wl_touch", 11)


def wl_seat_release(self: WLPtr):
    # opcode 3: destructor
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 3, args_array)
    wl_proxy_destroy(self)


def wl_seat_listen(self: WLPtr, out_queue: UnsafePointer[WLPtr, MutAnyOrigin]) -> Int32:
    """Register the capture dispatcher on wl_seat and write
    the queue handle to out_queue[0]. Pop events from that queue."""
    return _shim_listen(self, "wl_seat", out_queue)

def wl_seat_next_capabilities(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending capabilities event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 0, out_args)
    return rc == 0

def wl_seat_next_name(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending name event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 1, out_args)
    return rc == 1

# ---- wl_pointer v11 ----
comptime POINTER_ENTER_OP: UInt32 = 0
comptime POINTER_LEAVE_OP: UInt32 = 1
comptime POINTER_MOTION_OP: UInt32 = 2
comptime POINTER_BUTTON_OP: UInt32 = 3
comptime POINTER_AXIS_OP: UInt32 = 4
comptime POINTER_FRAME_OP: UInt32 = 5
comptime POINTER_AXIS_SOURCE_OP: UInt32 = 6
comptime POINTER_AXIS_STOP_OP: UInt32 = 7
comptime POINTER_AXIS_DISCRETE_OP: UInt32 = 8
comptime POINTER_AXIS_VALUE120_OP: UInt32 = 9
comptime POINTER_AXIS_RELATIVE_DIRECTION_OP: UInt32 = 10
comptime POINTER_WARP_OP: UInt32 = 11

comptime POINTER_ERROR_ROLE: UInt32 = 0

comptime POINTER_BUTTON_STATE_RELEASED: UInt32 = 0
comptime POINTER_BUTTON_STATE_PRESSED: UInt32 = 1

comptime POINTER_AXIS_VERTICAL_SCROLL: UInt32 = 0
comptime POINTER_AXIS_HORIZONTAL_SCROLL: UInt32 = 1

comptime POINTER_AXIS_SOURCE_WHEEL: UInt32 = 0
comptime POINTER_AXIS_SOURCE_FINGER: UInt32 = 1
comptime POINTER_AXIS_SOURCE_CONTINUOUS: UInt32 = 2
comptime POINTER_AXIS_SOURCE_WHEEL_TILT: UInt32 = 3

comptime POINTER_AXIS_RELATIVE_DIRECTION_IDENTICAL: UInt32 = 0
comptime POINTER_AXIS_RELATIVE_DIRECTION_INVERTED: UInt32 = 1

def wl_pointer_set_cursor(self: WLPtr, serial: UInt32, surface: UnsafePointer[NoneType, MutAnyOrigin], hotspot_x: Int32, hotspot_y: Int32):
    # opcode 0
    var args_array = stack_allocation[4, WLArgument]()
    args_array[0] = WLArgument.make_u(serial)
    args_array[1] = WLArgument.make_o(surface)
    args_array[2] = WLArgument.make_i(hotspot_x)
    args_array[3] = WLArgument.make_i(hotspot_y)
    wl_proxy_marshal_array(self, 0, args_array)


def wl_pointer_release(self: WLPtr):
    # opcode 1: destructor
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 1, args_array)
    wl_proxy_destroy(self)


def wl_pointer_listen(self: WLPtr, out_queue: UnsafePointer[WLPtr, MutAnyOrigin]) -> Int32:
    """Register the capture dispatcher on wl_pointer and write
    the queue handle to out_queue[0]. Pop events from that queue."""
    return _shim_listen(self, "wl_pointer", out_queue)

def wl_pointer_next_enter(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending enter event into out_args (len 4). False = none."""
    var rc = _shim_event_pop(queue, 0, out_args)
    return rc == 0

def wl_pointer_next_leave(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending leave event into out_args (len 2). False = none."""
    var rc = _shim_event_pop(queue, 1, out_args)
    return rc == 1

def wl_pointer_next_motion(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending motion event into out_args (len 3). False = none."""
    var rc = _shim_event_pop(queue, 2, out_args)
    return rc == 2

def wl_pointer_next_button(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending button event into out_args (len 4). False = none."""
    var rc = _shim_event_pop(queue, 3, out_args)
    return rc == 3

def wl_pointer_next_axis(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending axis event into out_args (len 3). False = none."""
    var rc = _shim_event_pop(queue, 4, out_args)
    return rc == 4

def wl_pointer_next_frame(queue: WLPtr) -> Bool:
    """Pop the next pending frame event. False = none."""
    var scratch = stack_allocation[1, WLArgument]()
    var rc = _shim_event_pop(queue, 5, scratch)
    return rc == 5

def wl_pointer_next_axis_source(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending axis_source event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 6, out_args)
    return rc == 6

def wl_pointer_next_axis_stop(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending axis_stop event into out_args (len 2). False = none."""
    var rc = _shim_event_pop(queue, 7, out_args)
    return rc == 7

def wl_pointer_next_axis_discrete(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending axis_discrete event into out_args (len 2). False = none."""
    var rc = _shim_event_pop(queue, 8, out_args)
    return rc == 8

def wl_pointer_next_axis_value120(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending axis_value120 event into out_args (len 2). False = none."""
    var rc = _shim_event_pop(queue, 9, out_args)
    return rc == 9

def wl_pointer_next_axis_relative_direction(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending axis_relative_direction event into out_args (len 2). False = none."""
    var rc = _shim_event_pop(queue, 10, out_args)
    return rc == 10

def wl_pointer_next_warp(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending warp event into out_args (len 2). False = none."""
    var rc = _shim_event_pop(queue, 11, out_args)
    return rc == 11

# ---- wl_keyboard v11 ----
comptime KEYBOARD_KEYMAP_OP: UInt32 = 0
comptime KEYBOARD_ENTER_OP: UInt32 = 1
comptime KEYBOARD_LEAVE_OP: UInt32 = 2
comptime KEYBOARD_KEY_OP: UInt32 = 3
comptime KEYBOARD_MODIFIERS_OP: UInt32 = 4
comptime KEYBOARD_REPEAT_INFO_OP: UInt32 = 5

comptime KEYBOARD_KEYMAP_FORMAT_NO_KEYMAP: UInt32 = 0
comptime KEYBOARD_KEYMAP_FORMAT_XKB_V1: UInt32 = 1

comptime KEYBOARD_KEY_STATE_RELEASED: UInt32 = 0
comptime KEYBOARD_KEY_STATE_PRESSED: UInt32 = 1
comptime KEYBOARD_KEY_STATE_REPEATED: UInt32 = 2

def wl_keyboard_release(self: WLPtr):
    # opcode 0: destructor
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 0, args_array)
    wl_proxy_destroy(self)


def wl_keyboard_listen(self: WLPtr, out_queue: UnsafePointer[WLPtr, MutAnyOrigin]) -> Int32:
    """Register the capture dispatcher on wl_keyboard and write
    the queue handle to out_queue[0]. Pop events from that queue."""
    return _shim_listen(self, "wl_keyboard", out_queue)

def wl_keyboard_next_keymap(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending keymap event into out_args (len 3). False = none."""
    var rc = _shim_event_pop(queue, 0, out_args)
    return rc == 0

def wl_keyboard_next_enter(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending enter event into out_args (len 3). False = none."""
    var rc = _shim_event_pop(queue, 1, out_args)
    return rc == 1

def wl_keyboard_next_leave(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending leave event into out_args (len 2). False = none."""
    var rc = _shim_event_pop(queue, 2, out_args)
    return rc == 2

def wl_keyboard_next_key(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending key event into out_args (len 4). False = none."""
    var rc = _shim_event_pop(queue, 3, out_args)
    return rc == 3

def wl_keyboard_next_modifiers(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending modifiers event into out_args (len 5). False = none."""
    var rc = _shim_event_pop(queue, 4, out_args)
    return rc == 4

def wl_keyboard_next_repeat_info(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending repeat_info event into out_args (len 2). False = none."""
    var rc = _shim_event_pop(queue, 5, out_args)
    return rc == 5

# ---- wl_touch v11 ----
comptime TOUCH_DOWN_OP: UInt32 = 0
comptime TOUCH_UP_OP: UInt32 = 1
comptime TOUCH_MOTION_OP: UInt32 = 2
comptime TOUCH_FRAME_OP: UInt32 = 3
comptime TOUCH_CANCEL_OP: UInt32 = 4
comptime TOUCH_SHAPE_OP: UInt32 = 5
comptime TOUCH_ORIENTATION_OP: UInt32 = 6

def wl_touch_release(self: WLPtr):
    # opcode 0: destructor
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 0, args_array)
    wl_proxy_destroy(self)


def wl_touch_listen(self: WLPtr, out_queue: UnsafePointer[WLPtr, MutAnyOrigin]) -> Int32:
    """Register the capture dispatcher on wl_touch and write
    the queue handle to out_queue[0]. Pop events from that queue."""
    return _shim_listen(self, "wl_touch", out_queue)

def wl_touch_next_down(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending down event into out_args (len 6). False = none."""
    var rc = _shim_event_pop(queue, 0, out_args)
    return rc == 0

def wl_touch_next_up(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending up event into out_args (len 3). False = none."""
    var rc = _shim_event_pop(queue, 1, out_args)
    return rc == 1

def wl_touch_next_motion(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending motion event into out_args (len 4). False = none."""
    var rc = _shim_event_pop(queue, 2, out_args)
    return rc == 2

def wl_touch_next_frame(queue: WLPtr) -> Bool:
    """Pop the next pending frame event. False = none."""
    var scratch = stack_allocation[1, WLArgument]()
    var rc = _shim_event_pop(queue, 3, scratch)
    return rc == 3

def wl_touch_next_cancel(queue: WLPtr) -> Bool:
    """Pop the next pending cancel event. False = none."""
    var scratch = stack_allocation[1, WLArgument]()
    var rc = _shim_event_pop(queue, 4, scratch)
    return rc == 4

def wl_touch_next_shape(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending shape event into out_args (len 3). False = none."""
    var rc = _shim_event_pop(queue, 5, out_args)
    return rc == 5

def wl_touch_next_orientation(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending orientation event into out_args (len 2). False = none."""
    var rc = _shim_event_pop(queue, 6, out_args)
    return rc == 6

# ---- wl_output v4 ----
comptime OUTPUT_GEOMETRY_OP: UInt32 = 0
comptime OUTPUT_MODE_OP: UInt32 = 1
comptime OUTPUT_DONE_OP: UInt32 = 2
comptime OUTPUT_SCALE_OP: UInt32 = 3
comptime OUTPUT_NAME_OP: UInt32 = 4
comptime OUTPUT_DESCRIPTION_OP: UInt32 = 5

comptime OUTPUT_SUBPIXEL_UNKNOWN: UInt32 = 0
comptime OUTPUT_SUBPIXEL_NONE: UInt32 = 1
comptime OUTPUT_SUBPIXEL_HORIZONTAL_RGB: UInt32 = 2
comptime OUTPUT_SUBPIXEL_HORIZONTAL_BGR: UInt32 = 3
comptime OUTPUT_SUBPIXEL_VERTICAL_RGB: UInt32 = 4
comptime OUTPUT_SUBPIXEL_VERTICAL_BGR: UInt32 = 5

comptime OUTPUT_TRANSFORM_NORMAL: UInt32 = 0
comptime OUTPUT_TRANSFORM_90: UInt32 = 1
comptime OUTPUT_TRANSFORM_180: UInt32 = 2
comptime OUTPUT_TRANSFORM_270: UInt32 = 3
comptime OUTPUT_TRANSFORM_FLIPPED: UInt32 = 4
comptime OUTPUT_TRANSFORM_FLIPPED_90: UInt32 = 5
comptime OUTPUT_TRANSFORM_FLIPPED_180: UInt32 = 6
comptime OUTPUT_TRANSFORM_FLIPPED_270: UInt32 = 7

comptime OUTPUT_MODE_CURRENT: UInt32 = 1
comptime OUTPUT_MODE_PREFERRED: UInt32 = 2

def wl_output_release(self: WLPtr):
    # opcode 0: destructor
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 0, args_array)
    wl_proxy_destroy(self)


def wl_output_listen(self: WLPtr, out_queue: UnsafePointer[WLPtr, MutAnyOrigin]) -> Int32:
    """Register the capture dispatcher on wl_output and write
    the queue handle to out_queue[0]. Pop events from that queue."""
    return _shim_listen(self, "wl_output", out_queue)

def wl_output_next_geometry(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending geometry event into out_args (len 8). False = none."""
    var rc = _shim_event_pop(queue, 0, out_args)
    return rc == 0

def wl_output_next_mode(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending mode event into out_args (len 4). False = none."""
    var rc = _shim_event_pop(queue, 1, out_args)
    return rc == 1

def wl_output_next_done(queue: WLPtr) -> Bool:
    """Pop the next pending done event. False = none."""
    var scratch = stack_allocation[1, WLArgument]()
    var rc = _shim_event_pop(queue, 2, scratch)
    return rc == 2

def wl_output_next_scale(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending scale event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 3, out_args)
    return rc == 3

def wl_output_next_name(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending name event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 4, out_args)
    return rc == 4

def wl_output_next_description(queue: WLPtr, out_args: UnsafePointer[WLArgument, MutAnyOrigin]) -> Bool:
    """Pop the next pending description event into out_args (len 1). False = none."""
    var rc = _shim_event_pop(queue, 5, out_args)
    return rc == 5

# ---- wl_region v7 ----
def wl_region_destroy(self: WLPtr):
    # opcode 0: destructor
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 0, args_array)
    wl_proxy_destroy(self)


def wl_region_add(self: WLPtr, x: Int32, y: Int32, width: Int32, height: Int32):
    # opcode 1
    var args_array = stack_allocation[4, WLArgument]()
    args_array[0] = WLArgument.make_i(x)
    args_array[1] = WLArgument.make_i(y)
    args_array[2] = WLArgument.make_i(width)
    args_array[3] = WLArgument.make_i(height)
    wl_proxy_marshal_array(self, 1, args_array)


def wl_region_subtract(self: WLPtr, x: Int32, y: Int32, width: Int32, height: Int32):
    # opcode 2
    var args_array = stack_allocation[4, WLArgument]()
    args_array[0] = WLArgument.make_i(x)
    args_array[1] = WLArgument.make_i(y)
    args_array[2] = WLArgument.make_i(width)
    args_array[3] = WLArgument.make_i(height)
    wl_proxy_marshal_array(self, 2, args_array)


# ---- wl_subcompositor v1 ----
comptime SUBCOMPOSITOR_ERROR_BAD_SURFACE: UInt32 = 0
comptime SUBCOMPOSITOR_ERROR_BAD_PARENT: UInt32 = 1

def wl_subcompositor_destroy(self: WLPtr):
    # opcode 0: destructor
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 0, args_array)
    wl_proxy_destroy(self)


def wl_subcompositor_get_subsurface(self: WLPtr, surface: UnsafePointer[NoneType, MutAnyOrigin], parent: UnsafePointer[NoneType, MutAnyOrigin]) raises -> WLPtr:
    # opcode 1: get_subsurface
    # opcode 1: get_subsurface, creates wl_subsurface
    # slots follow wire-signature positions (new_id slot zeroed)
    var args_array = stack_allocation[3, WLArgument]()
    args_array[1] = WLArgument.make_o(surface)
    args_array[2] = WLArgument.make_o(parent)
    return _proxy_constructor_versioned(self, 1, args_array, "wl_subsurface", 1)


# ---- wl_subsurface v1 ----
comptime SUBSURFACE_ERROR_BAD_SURFACE: UInt32 = 0

def wl_subsurface_destroy(self: WLPtr):
    # opcode 0: destructor
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 0, args_array)
    wl_proxy_destroy(self)


def wl_subsurface_set_position(self: WLPtr, x: Int32, y: Int32):
    # opcode 1
    var args_array = stack_allocation[2, WLArgument]()
    args_array[0] = WLArgument.make_i(x)
    args_array[1] = WLArgument.make_i(y)
    wl_proxy_marshal_array(self, 1, args_array)


def wl_subsurface_place_above(self: WLPtr, sibling: UnsafePointer[NoneType, MutAnyOrigin]):
    # opcode 2
    var args_array = stack_allocation[1, WLArgument]()
    args_array[0] = WLArgument.make_o(sibling)
    wl_proxy_marshal_array(self, 2, args_array)


def wl_subsurface_place_below(self: WLPtr, sibling: UnsafePointer[NoneType, MutAnyOrigin]):
    # opcode 3
    var args_array = stack_allocation[1, WLArgument]()
    args_array[0] = WLArgument.make_o(sibling)
    wl_proxy_marshal_array(self, 3, args_array)


def wl_subsurface_set_sync(self: WLPtr):
    # opcode 4
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 4, args_array)


def wl_subsurface_set_desync(self: WLPtr):
    # opcode 5
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 5, args_array)


# ---- wl_fixes v2 ----
comptime FIXES_ERROR_INVALID_ACK_REMOVE: UInt32 = 0

def wl_fixes_destroy(self: WLPtr):
    # opcode 0: destructor
    var args_array = stack_allocation[1, WLArgument]()
    wl_proxy_marshal_array(self, 0, args_array)
    wl_proxy_destroy(self)


def wl_fixes_destroy_registry(self: WLPtr, registry: UnsafePointer[NoneType, MutAnyOrigin]):
    # opcode 1
    var args_array = stack_allocation[1, WLArgument]()
    args_array[0] = WLArgument.make_o(registry)
    wl_proxy_marshal_array(self, 1, args_array)


def wl_fixes_ack_global_remove(self: WLPtr, registry: UnsafePointer[NoneType, MutAnyOrigin], name: UInt32):
    # opcode 2
    var args_array = stack_allocation[2, WLArgument]()
    args_array[0] = WLArgument.make_o(registry)
    args_array[1] = WLArgument.make_u(name)
    wl_proxy_marshal_array(self, 2, args_array)

