using System;
using Wayland;
namespace Wayland;
/*
    Copyright © 2008-2011 Kristian Høgsberg
    Copyright © 2010-2011 Intel Corporation
    Copyright © 2012-2013 Collabora, Ltd.

    Permission is hereby granted, free of charge, to any person
    obtaining a copy of this software and associated documentation files
    (the "Software"), to deal in the Software without restriction,
    including without limitation the rights to use, copy, modify, merge,
    publish, distribute, sublicense, and/or sell copies of the Software,
    and to permit persons to whom the Software is furnished to do so,
    subject to the following conditions:

    The above copyright notice and this permission notice (including the
    next paragraph) shall be included in all copies or substantial
    portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
    BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
    ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
  */
[CRepr]
public struct wl_display
{
    public static wl_interface Interface = .("wl_display", 1, 2, &wl_display_requests[0], 2, &wl_display_events[0]);
    
    private static wl_message[2] wl_display_requests = .(.("sync", "n", &sync_message_types[0]), .("get_registry", "n", &get_registry_message_types[0]));
    private static wl_message[2] wl_display_events = .(.("error", "ous", &error_message_types[0]), .("delete_id", "u", &delete_id_message_types[0]));
    
    private static wl_interface*[1] sync_message_types = .(&wl_callback.Interface);
    private static wl_interface*[1] get_registry_message_types = .(&wl_registry.Interface);

    private static wl_interface*[3] error_message_types = .(null, null, null);
    private static wl_interface*[1] delete_id_message_types = .(null);
    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public int AddListener(Listener* listener, void* data) => Wayland.wl_proxy_add_listener(proxy, (.)listener, data);      
    
    [CRepr]
    public struct Listener
    {
       public function void(void* data, wl_display wl_display, wl_object* object_id, uint32 code, char8* message) error;
       public function void(void* data, wl_display wl_display, uint32 id) delete_id;
    }

    public wl_callback sync()
    {
        wl_proxy* id;
        id = Wayland.wl_proxy_marshal_constructor(proxy, 0, &wl_callback.Interface, null);
        return .(id);
    }
    public wl_registry get_registry()
    {
        wl_proxy* id;
        id = Wayland.wl_proxy_marshal_constructor(proxy, 1, &wl_registry.Interface, null);
        return .(id);
    }
    public enum error
    {
        InvalidObject = 0,
        InvalidMethod = 1,
        NoMemory = 2,
        Implementation = 3,
    }
}
[CRepr]
public struct wl_registry
{
    public static wl_interface Interface = .("wl_registry", 1, 1, &wl_registry_requests[0], 2, &wl_registry_events[0]);
    
    private static wl_message[1] wl_registry_requests = .(.("bind", "un", &bind_message_types[0]));
    private static wl_message[2] wl_registry_events = .(.("global", "usu", &global_message_types[0]), .("global_remove", "u", &global_remove_message_types[0]));
    
    private static wl_interface*[2] bind_message_types = .(null, null);

    private static wl_interface*[3] global_message_types = .(null, null, null);
    private static wl_interface*[1] global_remove_message_types = .(null);
    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public int AddListener(Listener* listener, void* data) => Wayland.wl_proxy_add_listener(proxy, (.)listener, data);      
    
    [CRepr]
    public struct Listener
    {
       public function void(void* data, wl_registry wl_registry, uint32 name, char8* iface, uint32 version) global;
       public function void(void* data, wl_registry wl_registry, uint32 name) global_remove;
    }

    public void* bind(uint32 name, wl_interface* iface, uint32 version)
    {
        wl_proxy* id;
        id = Wayland.wl_proxy_marshal_constructor_versioned(proxy, 0, iface, version, name, iface.name, version, null);
        return (.)id;
    }
}
[CRepr]
public struct wl_callback
{
    public static wl_interface Interface = .("wl_callback", 1, 0, null, 1, &wl_callback_events[0]);
    
    private static wl_message[0] wl_callback_requests = .();
    private static wl_message[1] wl_callback_events = .(.("done", "u", &done_message_types[0]));
    

    private static wl_interface*[1] done_message_types = .(null);
    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public int AddListener(Listener* listener, void* data) => Wayland.wl_proxy_add_listener(proxy, (.)listener, data);      
    
    [CRepr]
    public struct Listener
    {
       public function void(void* data, wl_callback wl_callback, uint32 callback_data) done;
    }

}
[CRepr]
public struct wl_compositor
{
    public static wl_interface Interface = .("wl_compositor", 6, 2, &wl_compositor_requests[0], 0, null);
    
    private static wl_message[2] wl_compositor_requests = .(.("create_surface", "n", &create_surface_message_types[0]), .("create_region", "n", &create_region_message_types[0]));
    private static wl_message[0] wl_compositor_events = .();
    
    private static wl_interface*[1] create_surface_message_types = .(&wl_surface.Interface);
    private static wl_interface*[1] create_region_message_types = .(&wl_region.Interface);

    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public wl_surface create_surface()
    {
        wl_proxy* id;
        id = Wayland.wl_proxy_marshal_constructor(proxy, 0, &wl_surface.Interface, null);
        return .(id);
    }
    public wl_region create_region()
    {
        wl_proxy* id;
        id = Wayland.wl_proxy_marshal_constructor(proxy, 1, &wl_region.Interface, null);
        return .(id);
    }
}
[CRepr]
public struct wl_shm_pool
{
    public static wl_interface Interface = .("wl_shm_pool", 2, 3, &wl_shm_pool_requests[0], 0, null);
    
    private static wl_message[3] wl_shm_pool_requests = .(.("create_buffer", "niiiiu", &create_buffer_message_types[0]), .("destroy", "", null), .("resize", "i", &resize_message_types[0]));
    private static wl_message[0] wl_shm_pool_events = .();
    
    private static wl_interface*[6] create_buffer_message_types = .(&wl_buffer.Interface, null, null, null, null, null);
    private static wl_interface*[1] resize_message_types = .(null);

    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public wl_buffer create_buffer(int32 offset, int32 width, int32 height, int32 stride, uint32 format)
    {
        wl_proxy* id;
        id = Wayland.wl_proxy_marshal_constructor(proxy, 0, &wl_buffer.Interface, null, offset, width, height, stride, format);
        return .(id);
    }
    public void destroy()
    {
        Wayland.wl_proxy_marshal(proxy, 1);
        Wayland.wl_proxy_destroy(proxy);
    }
    public void resize(int32 size)
    {
        Wayland.wl_proxy_marshal(proxy, 2, size);
    }
}
[CRepr]
public struct wl_shm
{
    public static wl_interface Interface = .("wl_shm", 2, 2, &wl_shm_requests[0], 1, &wl_shm_events[0]);
    
    private static wl_message[2] wl_shm_requests = .(.("create_pool", "nhi", &create_pool_message_types[0]), .("release", "", null));
    private static wl_message[1] wl_shm_events = .(.("format", "u", &format_message_types[0]));
    
    private static wl_interface*[3] create_pool_message_types = .(&wl_shm_pool.Interface, null, null);

    private static wl_interface*[1] format_message_types = .(null);
    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public int AddListener(Listener* listener, void* data) => Wayland.wl_proxy_add_listener(proxy, (.)listener, data);      
    
    [CRepr]
    public struct Listener
    {
       public function void(void* data, wl_shm wl_shm, uint32 format) format;
    }

    public wl_shm_pool create_pool(int32 fd, int32 size)
    {
        wl_proxy* id;
        id = Wayland.wl_proxy_marshal_constructor(proxy, 0, &wl_shm_pool.Interface, null, fd, size);
        return .(id);
    }
    public void release()
    {
        Wayland.wl_proxy_marshal(proxy, 1);
        Wayland.wl_proxy_destroy(proxy);
    }
    public enum error
    {
        InvalidFormat = 0,
        InvalidStride = 1,
        InvalidFd = 2,
    }
    public enum format
    {
        Argb8888 = 0,
        Xrgb8888 = 1,
        C8 = 0x20203843,
        Rgb332 = 0x38424752,
        Bgr233 = 0x38524742,
        Xrgb4444 = 0x32315258,
        Xbgr4444 = 0x32314258,
        Rgbx4444 = 0x32315852,
        Bgrx4444 = 0x32315842,
        Argb4444 = 0x32315241,
        Abgr4444 = 0x32314241,
        Rgba4444 = 0x32314152,
        Bgra4444 = 0x32314142,
        Xrgb1555 = 0x35315258,
        Xbgr1555 = 0x35314258,
        Rgbx5551 = 0x35315852,
        Bgrx5551 = 0x35315842,
        Argb1555 = 0x35315241,
        Abgr1555 = 0x35314241,
        Rgba5551 = 0x35314152,
        Bgra5551 = 0x35314142,
        Rgb565 = 0x36314752,
        Bgr565 = 0x36314742,
        Rgb888 = 0x34324752,
        Bgr888 = 0x34324742,
        Xbgr8888 = 0x34324258,
        Rgbx8888 = 0x34325852,
        Bgrx8888 = 0x34325842,
        Abgr8888 = 0x34324241,
        Rgba8888 = 0x34324152,
        Bgra8888 = 0x34324142,
        Xrgb2101010 = 0x30335258,
        Xbgr2101010 = 0x30334258,
        Rgbx1010102 = 0x30335852,
        Bgrx1010102 = 0x30335842,
        Argb2101010 = 0x30335241,
        Abgr2101010 = 0x30334241,
        Rgba1010102 = 0x30334152,
        Bgra1010102 = 0x30334142,
        Yuyv = 0x56595559,
        Yvyu = 0x55595659,
        Uyvy = 0x59565955,
        Vyuy = 0x59555956,
        Ayuv = 0x56555941,
        Nv12 = 0x3231564e,
        Nv21 = 0x3132564e,
        Nv16 = 0x3631564e,
        Nv61 = 0x3136564e,
        Yuv410 = 0x39565559,
        Yvu410 = 0x39555659,
        Yuv411 = 0x31315559,
        Yvu411 = 0x31315659,
        Yuv420 = 0x32315559,
        Yvu420 = 0x32315659,
        Yuv422 = 0x36315559,
        Yvu422 = 0x36315659,
        Yuv444 = 0x34325559,
        Yvu444 = 0x34325659,
        R8 = 0x20203852,
        R16 = 0x20363152,
        Rg88 = 0x38384752,
        Gr88 = 0x38385247,
        Rg1616 = 0x32334752,
        Gr1616 = 0x32335247,
        Xrgb16161616F = 0x48345258,
        Xbgr16161616F = 0x48344258,
        Argb16161616F = 0x48345241,
        Abgr16161616F = 0x48344241,
        Xyuv8888 = 0x56555958,
        Vuy888 = 0x34325556,
        Vuy101010 = 0x30335556,
        Y210 = 0x30313259,
        Y212 = 0x32313259,
        Y216 = 0x36313259,
        Y410 = 0x30313459,
        Y412 = 0x32313459,
        Y416 = 0x36313459,
        Xvyu2101010 = 0x30335658,
        Xvyu1216161616 = 0x36335658,
        Xvyu16161616 = 0x38345658,
        Y0L0 = 0x304c3059,
        X0L0 = 0x304c3058,
        Y0L2 = 0x324c3059,
        X0L2 = 0x324c3058,
        Yuv4208Bit = 0x38305559,
        Yuv42010Bit = 0x30315559,
        Xrgb8888A8 = 0x38415258,
        Xbgr8888A8 = 0x38414258,
        Rgbx8888A8 = 0x38415852,
        Bgrx8888A8 = 0x38415842,
        Rgb888A8 = 0x38413852,
        Bgr888A8 = 0x38413842,
        Rgb565A8 = 0x38413552,
        Bgr565A8 = 0x38413542,
        Nv24 = 0x3432564e,
        Nv42 = 0x3234564e,
        P210 = 0x30313250,
        P010 = 0x30313050,
        P012 = 0x32313050,
        P016 = 0x36313050,
        Axbxgxrx106106106106 = 0x30314241,
        Nv15 = 0x3531564e,
        Q410 = 0x30313451,
        Q401 = 0x31303451,
        Xrgb16161616 = 0x38345258,
        Xbgr16161616 = 0x38344258,
        Argb16161616 = 0x38345241,
        Abgr16161616 = 0x38344241,
        C1 = 0x20203143,
        C2 = 0x20203243,
        C4 = 0x20203443,
        D1 = 0x20203144,
        D2 = 0x20203244,
        D4 = 0x20203444,
        D8 = 0x20203844,
        R1 = 0x20203152,
        R2 = 0x20203252,
        R4 = 0x20203452,
        R10 = 0x20303152,
        R12 = 0x20323152,
        Avuy8888 = 0x59555641,
        Xvuy8888 = 0x59555658,
        P030 = 0x30333050,
    }
}
[CRepr]
public struct wl_buffer
{
    public static wl_interface Interface = .("wl_buffer", 1, 1, &wl_buffer_requests[0], 1, &wl_buffer_events[0]);
    
    private static wl_message[1] wl_buffer_requests = .(.("destroy", "", null));
    private static wl_message[1] wl_buffer_events = .(.("release", "", null));
    

    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public int AddListener(Listener* listener, void* data) => Wayland.wl_proxy_add_listener(proxy, (.)listener, data);      
    
    [CRepr]
    public struct Listener
    {
       public function void(void* data, wl_buffer wl_buffer) release;
    }

    public void destroy()
    {
        Wayland.wl_proxy_marshal(proxy, 0);
        Wayland.wl_proxy_destroy(proxy);
    }
}
[CRepr]
public struct wl_data_offer
{
    public static wl_interface Interface = .("wl_data_offer", 3, 5, &wl_data_offer_requests[0], 3, &wl_data_offer_events[0]);
    
    private static wl_message[5] wl_data_offer_requests = .(.("accept", "u?s", &accept_message_types[0]), .("receive", "sh", &receive_message_types[0]), .("destroy", "", null), .("finish", "", null), .("set_actions", "uu", &set_actions_message_types[0]));
    private static wl_message[3] wl_data_offer_events = .(.("offer", "s", &offer_message_types[0]), .("source_actions", "u", &source_actions_message_types[0]), .("action", "u", &action_message_types[0]));
    
    private static wl_interface*[2] accept_message_types = .(null, null);
    private static wl_interface*[2] receive_message_types = .(null, null);
    private static wl_interface*[2] set_actions_message_types = .(null, null);

    private static wl_interface*[1] offer_message_types = .(null);
    private static wl_interface*[1] source_actions_message_types = .(null);
    private static wl_interface*[1] action_message_types = .(null);
    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public int AddListener(Listener* listener, void* data) => Wayland.wl_proxy_add_listener(proxy, (.)listener, data);      
    
    [CRepr]
    public struct Listener
    {
       public function void(void* data, wl_data_offer wl_data_offer, char8* mime_type) offer;
       public function void(void* data, wl_data_offer wl_data_offer, uint32 source_actions) source_actions;
       public function void(void* data, wl_data_offer wl_data_offer, uint32 dnd_action) action;
    }

    public void accept(uint32 serial, char8* mime_type)
    {
        Wayland.wl_proxy_marshal(proxy, 0, serial, mime_type);
    }
    public void receive(char8* mime_type, int32 fd)
    {
        Wayland.wl_proxy_marshal(proxy, 1, mime_type, fd);
    }
    public void destroy()
    {
        Wayland.wl_proxy_marshal(proxy, 2);
        Wayland.wl_proxy_destroy(proxy);
    }
    public void finish()
    {
        Wayland.wl_proxy_marshal(proxy, 3);
    }
    public void set_actions(uint32 dnd_actions, uint32 preferred_action)
    {
        Wayland.wl_proxy_marshal(proxy, 4, dnd_actions, preferred_action);
    }
    public enum error
    {
        InvalidFinish = 0,
        InvalidActionMask = 1,
        InvalidAction = 2,
        InvalidOffer = 3,
    }
}
[CRepr]
public struct wl_data_source
{
    public static wl_interface Interface = .("wl_data_source", 3, 3, &wl_data_source_requests[0], 6, &wl_data_source_events[0]);
    
    private static wl_message[3] wl_data_source_requests = .(.("offer", "s", &offer_message_types[0]), .("destroy", "", null), .("set_actions", "u", &set_actions_message_types[0]));
    private static wl_message[6] wl_data_source_events = .(.("target", "?s", &target_message_types[0]), .("send", "sh", &send_message_types[0]), .("cancelled", "", null), .("dnd_drop_performed", "", null), .("dnd_finished", "", null), .("action", "u", &action_message_types[0]));
    
    private static wl_interface*[1] offer_message_types = .(null);
    private static wl_interface*[1] set_actions_message_types = .(null);

    private static wl_interface*[1] target_message_types = .(null);
    private static wl_interface*[2] send_message_types = .(null, null);
    private static wl_interface*[1] action_message_types = .(null);
    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public int AddListener(Listener* listener, void* data) => Wayland.wl_proxy_add_listener(proxy, (.)listener, data);      
    
    [CRepr]
    public struct Listener
    {
       public function void(void* data, wl_data_source wl_data_source, char8* mime_type) target;
       public function void(void* data, wl_data_source wl_data_source, char8* mime_type, int32 fd) send;
       public function void(void* data, wl_data_source wl_data_source) cancelled;
       public function void(void* data, wl_data_source wl_data_source) dnd_drop_performed;
       public function void(void* data, wl_data_source wl_data_source) dnd_finished;
       public function void(void* data, wl_data_source wl_data_source, uint32 dnd_action) action;
    }

    public void offer(char8* mime_type)
    {
        Wayland.wl_proxy_marshal(proxy, 0, mime_type);
    }
    public void destroy()
    {
        Wayland.wl_proxy_marshal(proxy, 1);
        Wayland.wl_proxy_destroy(proxy);
    }
    public void set_actions(uint32 dnd_actions)
    {
        Wayland.wl_proxy_marshal(proxy, 2, dnd_actions);
    }
    public enum error
    {
        InvalidActionMask = 0,
        InvalidSource = 1,
    }
}
[CRepr]
public struct wl_data_device
{
    public static wl_interface Interface = .("wl_data_device", 3, 3, &wl_data_device_requests[0], 6, &wl_data_device_events[0]);
    
    private static wl_message[3] wl_data_device_requests = .(.("start_drag", "?oo?ou", &start_drag_message_types[0]), .("set_selection", "?ou", &set_selection_message_types[0]), .("release", "", null));
    private static wl_message[6] wl_data_device_events = .(.("data_offer", "n", &data_offer_message_types[0]), .("enter", "uoff?o", &enter_message_types[0]), .("leave", "", null), .("motion", "uff", &motion_message_types[0]), .("drop", "", null), .("selection", "?o", &selection_message_types[0]));
    
    private static wl_interface*[4] start_drag_message_types = .(&wl_data_source.Interface, &wl_surface.Interface, &wl_surface.Interface, null);
    private static wl_interface*[2] set_selection_message_types = .(&wl_data_source.Interface, null);

    private static wl_interface*[1] data_offer_message_types = .(&wl_data_offer.Interface);
    private static wl_interface*[5] enter_message_types = .(null, &wl_surface.Interface, null, null, &wl_data_offer.Interface);
    private static wl_interface*[3] motion_message_types = .(null, null, null);
    private static wl_interface*[1] selection_message_types = .(&wl_data_offer.Interface);
    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public int AddListener(Listener* listener, void* data) => Wayland.wl_proxy_add_listener(proxy, (.)listener, data);      
    
    [CRepr]
    public struct Listener
    {
       public function void(void* data, wl_data_device wl_data_device, uint32 id) data_offer;
       public function void(void* data, wl_data_device wl_data_device, uint32 serial, wl_object* surface, wl_fixed_t x, wl_fixed_t y, wl_object* id) enter;
       public function void(void* data, wl_data_device wl_data_device) leave;
       public function void(void* data, wl_data_device wl_data_device, uint32 time, wl_fixed_t x, wl_fixed_t y) motion;
       public function void(void* data, wl_data_device wl_data_device) drop;
       public function void(void* data, wl_data_device wl_data_device, wl_object* id) selection;
    }

    public void start_drag(wl_object* source, wl_object* origin, wl_object* icon, uint32 serial)
    {
        Wayland.wl_proxy_marshal(proxy, 0, source, origin, icon, serial);
    }
    public void set_selection(wl_object* source, uint32 serial)
    {
        Wayland.wl_proxy_marshal(proxy, 1, source, serial);
    }
    public void release()
    {
        Wayland.wl_proxy_marshal(proxy, 2);
        Wayland.wl_proxy_destroy(proxy);
    }
    public enum error
    {
        Role = 0,
        UsedSource = 1,
    }
}
[CRepr]
public struct wl_data_device_manager
{
    public static wl_interface Interface = .("wl_data_device_manager", 3, 2, &wl_data_device_manager_requests[0], 0, null);
    
    private static wl_message[2] wl_data_device_manager_requests = .(.("create_data_source", "n", &create_data_source_message_types[0]), .("get_data_device", "no", &get_data_device_message_types[0]));
    private static wl_message[0] wl_data_device_manager_events = .();
    
    private static wl_interface*[1] create_data_source_message_types = .(&wl_data_source.Interface);
    private static wl_interface*[2] get_data_device_message_types = .(&wl_data_device.Interface, &wl_seat.Interface);

    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public wl_data_source create_data_source()
    {
        wl_proxy* id;
        id = Wayland.wl_proxy_marshal_constructor(proxy, 0, &wl_data_source.Interface, null);
        return .(id);
    }
    public wl_data_device get_data_device(wl_object* seat)
    {
        wl_proxy* id;
        id = Wayland.wl_proxy_marshal_constructor(proxy, 1, &wl_data_device.Interface, null, seat);
        return .(id);
    }
    public enum dnd_action
    {
        None = 0,
        Copy = 1,
        Move = 2,
        Ask = 4,
    }
}
[CRepr]
public struct wl_shell
{
    public static wl_interface Interface = .("wl_shell", 1, 1, &wl_shell_requests[0], 0, null);
    
    private static wl_message[1] wl_shell_requests = .(.("get_shell_surface", "no", &get_shell_surface_message_types[0]));
    private static wl_message[0] wl_shell_events = .();
    
    private static wl_interface*[2] get_shell_surface_message_types = .(&wl_shell_surface.Interface, &wl_surface.Interface);

    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public wl_shell_surface get_shell_surface(wl_object* surface)
    {
        wl_proxy* id;
        id = Wayland.wl_proxy_marshal_constructor(proxy, 0, &wl_shell_surface.Interface, null, surface);
        return .(id);
    }
    public enum error
    {
        Role = 0,
    }
}
[CRepr]
public struct wl_shell_surface
{
    public static wl_interface Interface = .("wl_shell_surface", 1, 10, &wl_shell_surface_requests[0], 3, &wl_shell_surface_events[0]);
    
    private static wl_message[10] wl_shell_surface_requests = .(.("pong", "u", &pong_message_types[0]), .("move", "ou", &move_message_types[0]), .("resize", "ouu", &resize_message_types[0]), .("set_toplevel", "", null), .("set_transient", "oiiu", &set_transient_message_types[0]), .("set_fullscreen", "uu?o", &set_fullscreen_message_types[0]), .("set_popup", "ouoiiu", &set_popup_message_types[0]), .("set_maximized", "?o", &set_maximized_message_types[0]), .("set_title", "s", &set_title_message_types[0]), .("set_class", "s", &set_class_message_types[0]));
    private static wl_message[3] wl_shell_surface_events = .(.("ping", "u", &ping_message_types[0]), .("configure", "uii", &configure_message_types[0]), .("popup_done", "", null));
    
    private static wl_interface*[1] pong_message_types = .(null);
    private static wl_interface*[2] move_message_types = .(&wl_seat.Interface, null);
    private static wl_interface*[3] resize_message_types = .(&wl_seat.Interface, null, null);
    private static wl_interface*[4] set_transient_message_types = .(&wl_surface.Interface, null, null, null);
    private static wl_interface*[3] set_fullscreen_message_types = .(null, null, &wl_output.Interface);
    private static wl_interface*[6] set_popup_message_types = .(&wl_seat.Interface, null, &wl_surface.Interface, null, null, null);
    private static wl_interface*[1] set_maximized_message_types = .(&wl_output.Interface);
    private static wl_interface*[1] set_title_message_types = .(null);
    private static wl_interface*[1] set_class_message_types = .(null);

    private static wl_interface*[1] ping_message_types = .(null);
    private static wl_interface*[3] configure_message_types = .(null, null, null);
    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public int AddListener(Listener* listener, void* data) => Wayland.wl_proxy_add_listener(proxy, (.)listener, data);      
    
    [CRepr]
    public struct Listener
    {
       public function void(void* data, wl_shell_surface wl_shell_surface, uint32 serial) ping;
       public function void(void* data, wl_shell_surface wl_shell_surface, uint32 edges, int32 width, int32 height) configure;
       public function void(void* data, wl_shell_surface wl_shell_surface) popup_done;
    }

    public void pong(uint32 serial)
    {
        Wayland.wl_proxy_marshal(proxy, 0, serial);
    }
    public void move(wl_object* seat, uint32 serial)
    {
        Wayland.wl_proxy_marshal(proxy, 1, seat, serial);
    }
    public void resize(wl_object* seat, uint32 serial, uint32 edges)
    {
        Wayland.wl_proxy_marshal(proxy, 2, seat, serial, edges);
    }
    public void set_toplevel()
    {
        Wayland.wl_proxy_marshal(proxy, 3);
    }
    public void set_transient(wl_object* parent, int32 x, int32 y, uint32 flags)
    {
        Wayland.wl_proxy_marshal(proxy, 4, parent, x, y, flags);
    }
    public void set_fullscreen(uint32 method, uint32 framerate, wl_object* output)
    {
        Wayland.wl_proxy_marshal(proxy, 5, method, framerate, output);
    }
    public void set_popup(wl_object* seat, uint32 serial, wl_object* parent, int32 x, int32 y, uint32 flags)
    {
        Wayland.wl_proxy_marshal(proxy, 6, seat, serial, parent, x, y, flags);
    }
    public void set_maximized(wl_object* output)
    {
        Wayland.wl_proxy_marshal(proxy, 7, output);
    }
    public void set_title(char8* title)
    {
        Wayland.wl_proxy_marshal(proxy, 8, title);
    }
    public void set_class(char8* class_)
    {
        Wayland.wl_proxy_marshal(proxy, 9, class_);
    }
    public enum resize
    {
        None = 0,
        Top = 1,
        Bottom = 2,
        Left = 4,
        TopLeft = 5,
        BottomLeft = 6,
        Right = 8,
        TopRight = 9,
        BottomRight = 10,
    }
    public enum transient
    {
        Inactive = 0x1,
    }
    public enum fullscreen_method
    {
        Default = 0,
        Scale = 1,
        Driver = 2,
        Fill = 3,
    }
}
[CRepr]
public struct wl_surface
{
    public static wl_interface Interface = .("wl_surface", 6, 11, &wl_surface_requests[0], 4, &wl_surface_events[0]);
    
    private static wl_message[11] wl_surface_requests = .(.("destroy", "", null), .("attach", "?oii", &attach_message_types[0]), .("damage", "iiii", &damage_message_types[0]), .("frame", "n", &frame_message_types[0]), .("set_opaque_region", "?o", &set_opaque_region_message_types[0]), .("set_input_region", "?o", &set_input_region_message_types[0]), .("commit", "", null), .("set_buffer_transform", "i", &set_buffer_transform_message_types[0]), .("set_buffer_scale", "i", &set_buffer_scale_message_types[0]), .("damage_buffer", "iiii", &damage_buffer_message_types[0]), .("offset", "ii", &offset_message_types[0]));
    private static wl_message[4] wl_surface_events = .(.("enter", "o", &enter_message_types[0]), .("leave", "o", &leave_message_types[0]), .("preferred_buffer_scale", "i", &preferred_buffer_scale_message_types[0]), .("preferred_buffer_transform", "u", &preferred_buffer_transform_message_types[0]));
    
    private static wl_interface*[3] attach_message_types = .(&wl_buffer.Interface, null, null);
    private static wl_interface*[4] damage_message_types = .(null, null, null, null);
    private static wl_interface*[1] frame_message_types = .(&wl_callback.Interface);
    private static wl_interface*[1] set_opaque_region_message_types = .(&wl_region.Interface);
    private static wl_interface*[1] set_input_region_message_types = .(&wl_region.Interface);
    private static wl_interface*[1] set_buffer_transform_message_types = .(null);
    private static wl_interface*[1] set_buffer_scale_message_types = .(null);
    private static wl_interface*[4] damage_buffer_message_types = .(null, null, null, null);
    private static wl_interface*[2] offset_message_types = .(null, null);

    private static wl_interface*[1] enter_message_types = .(&wl_output.Interface);
    private static wl_interface*[1] leave_message_types = .(&wl_output.Interface);
    private static wl_interface*[1] preferred_buffer_scale_message_types = .(null);
    private static wl_interface*[1] preferred_buffer_transform_message_types = .(null);
    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public int AddListener(Listener* listener, void* data) => Wayland.wl_proxy_add_listener(proxy, (.)listener, data);      
    
    [CRepr]
    public struct Listener
    {
       public function void(void* data, wl_surface wl_surface, wl_object* output) enter;
       public function void(void* data, wl_surface wl_surface, wl_object* output) leave;
       public function void(void* data, wl_surface wl_surface, int32 factor) preferred_buffer_scale;
       public function void(void* data, wl_surface wl_surface, uint32 transform) preferred_buffer_transform;
    }

    public void destroy()
    {
        Wayland.wl_proxy_marshal(proxy, 0);
        Wayland.wl_proxy_destroy(proxy);
    }
    public void attach(wl_object* buffer, int32 x, int32 y)
    {
        Wayland.wl_proxy_marshal(proxy, 1, buffer, x, y);
    }
    public void damage(int32 x, int32 y, int32 width, int32 height)
    {
        Wayland.wl_proxy_marshal(proxy, 2, x, y, width, height);
    }
    public wl_callback frame()
    {
        wl_proxy* id;
        id = Wayland.wl_proxy_marshal_constructor(proxy, 3, &wl_callback.Interface, null);
        return .(id);
    }
    public void set_opaque_region(wl_object* region)
    {
        Wayland.wl_proxy_marshal(proxy, 4, region);
    }
    public void set_input_region(wl_object* region)
    {
        Wayland.wl_proxy_marshal(proxy, 5, region);
    }
    public void commit()
    {
        Wayland.wl_proxy_marshal(proxy, 6);
    }
    public void set_buffer_transform(int32 transform)
    {
        Wayland.wl_proxy_marshal(proxy, 7, transform);
    }
    public void set_buffer_scale(int32 scale)
    {
        Wayland.wl_proxy_marshal(proxy, 8, scale);
    }
    public void damage_buffer(int32 x, int32 y, int32 width, int32 height)
    {
        Wayland.wl_proxy_marshal(proxy, 9, x, y, width, height);
    }
    public void offset(int32 x, int32 y)
    {
        Wayland.wl_proxy_marshal(proxy, 10, x, y);
    }
    public enum error
    {
        InvalidScale = 0,
        InvalidTransform = 1,
        InvalidSize = 2,
        InvalidOffset = 3,
        DefunctRoleObject = 4,
    }
}
[CRepr]
public struct wl_seat
{
    public static wl_interface Interface = .("wl_seat", 10, 4, &wl_seat_requests[0], 2, &wl_seat_events[0]);
    
    private static wl_message[4] wl_seat_requests = .(.("get_pointer", "n", &get_pointer_message_types[0]), .("get_keyboard", "n", &get_keyboard_message_types[0]), .("get_touch", "n", &get_touch_message_types[0]), .("release", "", null));
    private static wl_message[2] wl_seat_events = .(.("capabilities", "u", &capabilities_message_types[0]), .("name", "s", &name_message_types[0]));
    
    private static wl_interface*[1] get_pointer_message_types = .(&wl_pointer.Interface);
    private static wl_interface*[1] get_keyboard_message_types = .(&wl_keyboard.Interface);
    private static wl_interface*[1] get_touch_message_types = .(&wl_touch.Interface);

    private static wl_interface*[1] capabilities_message_types = .(null);
    private static wl_interface*[1] name_message_types = .(null);
    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public int AddListener(Listener* listener, void* data) => Wayland.wl_proxy_add_listener(proxy, (.)listener, data);      
    
    [CRepr]
    public struct Listener
    {
       public function void(void* data, wl_seat wl_seat, uint32 capabilities) capabilities;
       public function void(void* data, wl_seat wl_seat, char8* name) name;
    }

    public wl_pointer get_pointer()
    {
        wl_proxy* id;
        id = Wayland.wl_proxy_marshal_constructor(proxy, 0, &wl_pointer.Interface, null);
        return .(id);
    }
    public wl_keyboard get_keyboard()
    {
        wl_proxy* id;
        id = Wayland.wl_proxy_marshal_constructor(proxy, 1, &wl_keyboard.Interface, null);
        return .(id);
    }
    public wl_touch get_touch()
    {
        wl_proxy* id;
        id = Wayland.wl_proxy_marshal_constructor(proxy, 2, &wl_touch.Interface, null);
        return .(id);
    }
    public void release()
    {
        Wayland.wl_proxy_marshal(proxy, 3);
        Wayland.wl_proxy_destroy(proxy);
    }
    public enum capability
    {
        Pointer = 1,
        Keyboard = 2,
        Touch = 4,
    }
    public enum error
    {
        MissingCapability = 0,
    }
}
[CRepr]
public struct wl_pointer
{
    public static wl_interface Interface = .("wl_pointer", 10, 2, &wl_pointer_requests[0], 11, &wl_pointer_events[0]);
    
    private static wl_message[2] wl_pointer_requests = .(.("set_cursor", "u?oii", &set_cursor_message_types[0]), .("release", "", null));
    private static wl_message[11] wl_pointer_events = .(.("enter", "uoff", &enter_message_types[0]), .("leave", "uo", &leave_message_types[0]), .("motion", "uff", &motion_message_types[0]), .("button", "uuuu", &button_message_types[0]), .("axis", "uuf", &axis_message_types[0]), .("frame", "", null), .("axis_source", "u", &axis_source_message_types[0]), .("axis_stop", "uu", &axis_stop_message_types[0]), .("axis_discrete", "ui", &axis_discrete_message_types[0]), .("axis_value120", "ui", &axis_value120_message_types[0]), .("axis_relative_direction", "uu", &axis_relative_direction_message_types[0]));
    
    private static wl_interface*[4] set_cursor_message_types = .(null, &wl_surface.Interface, null, null);

    private static wl_interface*[4] enter_message_types = .(null, &wl_surface.Interface, null, null);
    private static wl_interface*[2] leave_message_types = .(null, &wl_surface.Interface);
    private static wl_interface*[3] motion_message_types = .(null, null, null);
    private static wl_interface*[4] button_message_types = .(null, null, null, null);
    private static wl_interface*[3] axis_message_types = .(null, null, null);
    private static wl_interface*[1] axis_source_message_types = .(null);
    private static wl_interface*[2] axis_stop_message_types = .(null, null);
    private static wl_interface*[2] axis_discrete_message_types = .(null, null);
    private static wl_interface*[2] axis_value120_message_types = .(null, null);
    private static wl_interface*[2] axis_relative_direction_message_types = .(null, null);
    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public int AddListener(Listener* listener, void* data) => Wayland.wl_proxy_add_listener(proxy, (.)listener, data);      
    
    [CRepr]
    public struct Listener
    {
       public function void(void* data, wl_pointer wl_pointer, uint32 serial, wl_object* surface, wl_fixed_t surface_x, wl_fixed_t surface_y) enter;
       public function void(void* data, wl_pointer wl_pointer, uint32 serial, wl_object* surface) leave;
       public function void(void* data, wl_pointer wl_pointer, uint32 time, wl_fixed_t surface_x, wl_fixed_t surface_y) motion;
       public function void(void* data, wl_pointer wl_pointer, uint32 serial, uint32 time, uint32 button, uint32 state) button;
       public function void(void* data, wl_pointer wl_pointer, uint32 time, uint32 axis, wl_fixed_t value) axis;
       public function void(void* data, wl_pointer wl_pointer) frame;
       public function void(void* data, wl_pointer wl_pointer, uint32 axis_source) axis_source;
       public function void(void* data, wl_pointer wl_pointer, uint32 time, uint32 axis) axis_stop;
       public function void(void* data, wl_pointer wl_pointer, uint32 axis, int32 discrete) axis_discrete;
       public function void(void* data, wl_pointer wl_pointer, uint32 axis, int32 value120) axis_value120;
       public function void(void* data, wl_pointer wl_pointer, uint32 axis, uint32 direction) axis_relative_direction;
    }

    public void set_cursor(uint32 serial, wl_object* surface, int32 hotspot_x, int32 hotspot_y)
    {
        Wayland.wl_proxy_marshal(proxy, 0, serial, surface, hotspot_x, hotspot_y);
    }
    public void release()
    {
        Wayland.wl_proxy_marshal(proxy, 1);
        Wayland.wl_proxy_destroy(proxy);
    }
    public enum error
    {
        Role = 0,
    }
    public enum button_state
    {
        Released = 0,
        Pressed = 1,
    }
    public enum axis
    {
        VerticalScroll = 0,
        HorizontalScroll = 1,
    }
    public enum axis_source
    {
        Wheel = 0,
        Finger = 1,
        Continuous = 2,
        WheelTilt = 3,
    }
    public enum axis_relative_direction
    {
        Identical = 0,
        Inverted = 1,
    }
}
[CRepr]
public struct wl_keyboard
{
    public static wl_interface Interface = .("wl_keyboard", 10, 1, &wl_keyboard_requests[0], 6, &wl_keyboard_events[0]);
    
    private static wl_message[1] wl_keyboard_requests = .(.("release", "", null));
    private static wl_message[6] wl_keyboard_events = .(.("keymap", "uhu", &keymap_message_types[0]), .("enter", "uoa", &enter_message_types[0]), .("leave", "uo", &leave_message_types[0]), .("key", "uuuu", &key_message_types[0]), .("modifiers", "uuuuu", &modifiers_message_types[0]), .("repeat_info", "ii", &repeat_info_message_types[0]));
    

    private static wl_interface*[3] keymap_message_types = .(null, null, null);
    private static wl_interface*[3] enter_message_types = .(null, &wl_surface.Interface, null);
    private static wl_interface*[2] leave_message_types = .(null, &wl_surface.Interface);
    private static wl_interface*[4] key_message_types = .(null, null, null, null);
    private static wl_interface*[5] modifiers_message_types = .(null, null, null, null, null);
    private static wl_interface*[2] repeat_info_message_types = .(null, null);
    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public int AddListener(Listener* listener, void* data) => Wayland.wl_proxy_add_listener(proxy, (.)listener, data);      
    
    [CRepr]
    public struct Listener
    {
       public function void(void* data, wl_keyboard wl_keyboard, uint32 format, int32 fd, uint32 size) keymap;
       public function void(void* data, wl_keyboard wl_keyboard, uint32 serial, wl_object* surface, wl_array* keys) enter;
       public function void(void* data, wl_keyboard wl_keyboard, uint32 serial, wl_object* surface) leave;
       public function void(void* data, wl_keyboard wl_keyboard, uint32 serial, uint32 time, uint32 key, uint32 state) key;
       public function void(void* data, wl_keyboard wl_keyboard, uint32 serial, uint32 mods_depressed, uint32 mods_latched, uint32 mods_locked, uint32 group) modifiers;
       public function void(void* data, wl_keyboard wl_keyboard, int32 rate, int32 delay) repeat_info;
    }

    public void release()
    {
        Wayland.wl_proxy_marshal(proxy, 0);
        Wayland.wl_proxy_destroy(proxy);
    }
    public enum keymap_format
    {
        NoKeymap = 0,
        XkbV1 = 1,
    }
    public enum key_state
    {
        Released = 0,
        Pressed = 1,
        Repeated = 2,
    }
}
[CRepr]
public struct wl_touch
{
    public static wl_interface Interface = .("wl_touch", 10, 1, &wl_touch_requests[0], 7, &wl_touch_events[0]);
    
    private static wl_message[1] wl_touch_requests = .(.("release", "", null));
    private static wl_message[7] wl_touch_events = .(.("down", "uuoiff", &down_message_types[0]), .("up", "uui", &up_message_types[0]), .("motion", "uiff", &motion_message_types[0]), .("frame", "", null), .("cancel", "", null), .("shape", "iff", &shape_message_types[0]), .("orientation", "if", &orientation_message_types[0]));
    

    private static wl_interface*[6] down_message_types = .(null, null, &wl_surface.Interface, null, null, null);
    private static wl_interface*[3] up_message_types = .(null, null, null);
    private static wl_interface*[4] motion_message_types = .(null, null, null, null);
    private static wl_interface*[3] shape_message_types = .(null, null, null);
    private static wl_interface*[2] orientation_message_types = .(null, null);
    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public int AddListener(Listener* listener, void* data) => Wayland.wl_proxy_add_listener(proxy, (.)listener, data);      
    
    [CRepr]
    public struct Listener
    {
       public function void(void* data, wl_touch wl_touch, uint32 serial, uint32 time, wl_object* surface, int32 id, wl_fixed_t x, wl_fixed_t y) down;
       public function void(void* data, wl_touch wl_touch, uint32 serial, uint32 time, int32 id) up;
       public function void(void* data, wl_touch wl_touch, uint32 time, int32 id, wl_fixed_t x, wl_fixed_t y) motion;
       public function void(void* data, wl_touch wl_touch) frame;
       public function void(void* data, wl_touch wl_touch) cancel;
       public function void(void* data, wl_touch wl_touch, int32 id, wl_fixed_t major, wl_fixed_t minor) shape;
       public function void(void* data, wl_touch wl_touch, int32 id, wl_fixed_t orientation) orientation;
    }

    public void release()
    {
        Wayland.wl_proxy_marshal(proxy, 0);
        Wayland.wl_proxy_destroy(proxy);
    }
}
[CRepr]
public struct wl_output
{
    public static wl_interface Interface = .("wl_output", 4, 1, &wl_output_requests[0], 6, &wl_output_events[0]);
    
    private static wl_message[1] wl_output_requests = .(.("release", "", null));
    private static wl_message[6] wl_output_events = .(.("geometry", "iiiiissi", &geometry_message_types[0]), .("mode", "uiii", &mode_message_types[0]), .("done", "", null), .("scale", "i", &scale_message_types[0]), .("name", "s", &name_message_types[0]), .("description", "s", &description_message_types[0]));
    

    private static wl_interface*[8] geometry_message_types = .(null, null, null, null, null, null, null, null);
    private static wl_interface*[4] mode_message_types = .(null, null, null, null);
    private static wl_interface*[1] scale_message_types = .(null);
    private static wl_interface*[1] name_message_types = .(null);
    private static wl_interface*[1] description_message_types = .(null);
    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public int AddListener(Listener* listener, void* data) => Wayland.wl_proxy_add_listener(proxy, (.)listener, data);      
    
    [CRepr]
    public struct Listener
    {
       public function void(void* data, wl_output wl_output, int32 x, int32 y, int32 physical_width, int32 physical_height, int32 subpixel, char8* make, char8* model, int32 transform) geometry;
       public function void(void* data, wl_output wl_output, uint32 flags, int32 width, int32 height, int32 refresh) mode;
       public function void(void* data, wl_output wl_output) done;
       public function void(void* data, wl_output wl_output, int32 factor) scale;
       public function void(void* data, wl_output wl_output, char8* name) name;
       public function void(void* data, wl_output wl_output, char8* description) description;
    }

    public void release()
    {
        Wayland.wl_proxy_marshal(proxy, 0);
        Wayland.wl_proxy_destroy(proxy);
    }
    public enum subpixel
    {
        Unknown = 0,
        None = 1,
        HorizontalRgb = 2,
        HorizontalBgr = 3,
        VerticalRgb = 4,
        VerticalBgr = 5,
    }
    public enum transform
    {
        Normal = 0,
        _90 = 1,
        _180 = 2,
        _270 = 3,
        Flipped = 4,
        Flipped90 = 5,
        Flipped180 = 6,
        Flipped270 = 7,
    }
    public enum mode
    {
        Current = 0x1,
        Preferred = 0x2,
    }
}
[CRepr]
public struct wl_region
{
    public static wl_interface Interface = .("wl_region", 1, 3, &wl_region_requests[0], 0, null);
    
    private static wl_message[3] wl_region_requests = .(.("destroy", "", null), .("add", "iiii", &add_message_types[0]), .("subtract", "iiii", &subtract_message_types[0]));
    private static wl_message[0] wl_region_events = .();
    
    private static wl_interface*[4] add_message_types = .(null, null, null, null);
    private static wl_interface*[4] subtract_message_types = .(null, null, null, null);

    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public void destroy()
    {
        Wayland.wl_proxy_marshal(proxy, 0);
        Wayland.wl_proxy_destroy(proxy);
    }
    public void add(int32 x, int32 y, int32 width, int32 height)
    {
        Wayland.wl_proxy_marshal(proxy, 1, x, y, width, height);
    }
    public void subtract(int32 x, int32 y, int32 width, int32 height)
    {
        Wayland.wl_proxy_marshal(proxy, 2, x, y, width, height);
    }
}
[CRepr]
public struct wl_subcompositor
{
    public static wl_interface Interface = .("wl_subcompositor", 1, 2, &wl_subcompositor_requests[0], 0, null);
    
    private static wl_message[2] wl_subcompositor_requests = .(.("destroy", "", null), .("get_subsurface", "noo", &get_subsurface_message_types[0]));
    private static wl_message[0] wl_subcompositor_events = .();
    
    private static wl_interface*[3] get_subsurface_message_types = .(&wl_subsurface.Interface, &wl_surface.Interface, &wl_surface.Interface);

    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public void destroy()
    {
        Wayland.wl_proxy_marshal(proxy, 0);
        Wayland.wl_proxy_destroy(proxy);
    }
    public wl_subsurface get_subsurface(wl_object* surface, wl_object* parent)
    {
        wl_proxy* id;
        id = Wayland.wl_proxy_marshal_constructor(proxy, 1, &wl_subsurface.Interface, null, surface, parent);
        return .(id);
    }
    public enum error
    {
        BadSurface = 0,
        BadParent = 1,
    }
}
[CRepr]
public struct wl_subsurface
{
    public static wl_interface Interface = .("wl_subsurface", 1, 6, &wl_subsurface_requests[0], 0, null);
    
    private static wl_message[6] wl_subsurface_requests = .(.("destroy", "", null), .("set_position", "ii", &set_position_message_types[0]), .("place_above", "o", &place_above_message_types[0]), .("place_below", "o", &place_below_message_types[0]), .("set_sync", "", null), .("set_desync", "", null));
    private static wl_message[0] wl_subsurface_events = .();
    
    private static wl_interface*[2] set_position_message_types = .(null, null);
    private static wl_interface*[1] place_above_message_types = .(&wl_surface.Interface);
    private static wl_interface*[1] place_below_message_types = .(&wl_surface.Interface);

    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public void destroy()
    {
        Wayland.wl_proxy_marshal(proxy, 0);
        Wayland.wl_proxy_destroy(proxy);
    }
    public void set_position(int32 x, int32 y)
    {
        Wayland.wl_proxy_marshal(proxy, 1, x, y);
    }
    public void place_above(wl_object* sibling)
    {
        Wayland.wl_proxy_marshal(proxy, 2, sibling);
    }
    public void place_below(wl_object* sibling)
    {
        Wayland.wl_proxy_marshal(proxy, 3, sibling);
    }
    public void set_sync()
    {
        Wayland.wl_proxy_marshal(proxy, 4);
    }
    public void set_desync()
    {
        Wayland.wl_proxy_marshal(proxy, 5);
    }
    public enum error
    {
        BadSurface = 0,
    }
}
[CRepr]
public struct wl_fixes
{
    public static wl_interface Interface = .("wl_fixes", 1, 2, &wl_fixes_requests[0], 0, null);
    
    private static wl_message[2] wl_fixes_requests = .(.("destroy", "", null), .("destroy_registry", "o", &destroy_registry_message_types[0]));
    private static wl_message[0] wl_fixes_events = .();
    
    private static wl_interface*[1] destroy_registry_message_types = .(&wl_registry.Interface);

    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

    public void destroy()
    {
        Wayland.wl_proxy_marshal(proxy, 0);
        Wayland.wl_proxy_destroy(proxy);
    }
    public void destroy_registry(wl_object* registry)
    {
        Wayland.wl_proxy_marshal(proxy, 1, registry);
    }
}
