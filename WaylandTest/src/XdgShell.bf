using System;
using Wayland;
namespace XdgShell;
/*
    Copyright © 2008-2013 Kristian Høgsberg
    Copyright © 2013      Rafael Antognolli
    Copyright © 2013      Jasper St. Pierre
    Copyright © 2010-2013 Intel Corporation
    Copyright © 2015-2017 Samsung Electronics Co., Ltd
    Copyright © 2015-2017 Red Hat Inc.

    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice (including the next
    paragraph) shall be included in all copies or substantial portions of the
    Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
    THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
    DEALINGS IN THE SOFTWARE.
  */
[CRepr]
public struct xdg_wm_base
{
    public static wl_interface Interface = .("xdg_wm_base", 6, 4, &xdg_wm_base_requests[0], 1, &xdg_wm_base_events[0]);
    
    private static wl_message[4] xdg_wm_base_requests = .(.("destroy", "", null), .("create_positioner", "n", &create_positioner_message_types[0]), .("get_xdg_surface", "no", &get_xdg_surface_message_types[0]), .("pong", "u", &pong_message_types[0]));
    private static wl_message[1] xdg_wm_base_events = .(.("ping", "u", &ping_message_types[0]));
    
    private static wl_interface*[1] create_positioner_message_types = .(&xdg_positioner.Interface);
    private static wl_interface*[2] get_xdg_surface_message_types = .(&xdg_surface.Interface, &wl_surface.Interface);
    private static wl_interface*[1] pong_message_types = .(null);

    private static wl_interface*[1] ping_message_types = .(null);
    
    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public bool   IsBound => proxy != null;
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);

    public int AddListener(Listener* listener, void* data) => Wayland.wl_proxy_add_listener(proxy, (.)listener, data);      
    
    [CRepr]
    public struct Listener
    {
       public function void(void* data, xdg_wm_base xdg_wm_base, uint32 serial) Ping;
    }

    public void Destroy()
    {
        Wayland.wl_proxy_marshal(proxy, 0);
        Wayland.wl_proxy_destroy(proxy);
    }
    public xdg_positioner CreatePositioner()
    {
        wl_proxy* id;
        id = Wayland.wl_proxy_marshal_constructor(proxy, 1, &xdg_positioner.Interface, null);
        return .(id);
    }
    public xdg_surface GetXdgSurface(wl_surface surface)
    {
        wl_proxy* id;
        id = Wayland.wl_proxy_marshal_constructor(proxy, 2, &xdg_surface.Interface, null, surface);
        return .(id);
    }
    public void Pong(uint32 serial)
    {
        Wayland.wl_proxy_marshal(proxy, 3, serial);
    }
    public enum Error
    {
        Role = 0,
        DefunctSurfaces = 1,
        NotTheTopmostPopup = 2,
        InvalidPopupParent = 3,
        InvalidSurfaceState = 4,
        InvalidPositioner = 5,
        Unresponsive = 6,
    }
}
[CRepr]
public struct xdg_positioner
{
    public static wl_interface Interface = .("xdg_positioner", 6, 10, &xdg_positioner_requests[0], 0, null);
    
    private static wl_message[10] xdg_positioner_requests = .(.("destroy", "", null), .("set_size", "ii", &set_size_message_types[0]), .("set_anchor_rect", "iiii", &set_anchor_rect_message_types[0]), .("set_anchor", "u", &set_anchor_message_types[0]), .("set_gravity", "u", &set_gravity_message_types[0]), .("set_constraint_adjustment", "u", &set_constraint_adjustment_message_types[0]), .("set_offset", "ii", &set_offset_message_types[0]), .("set_reactive", "", null), .("set_parent_size", "ii", &set_parent_size_message_types[0]), .("set_parent_configure", "u", &set_parent_configure_message_types[0]));
    private static wl_message[0] xdg_positioner_events = .();
    
    private static wl_interface*[2] set_size_message_types = .(null, null);
    private static wl_interface*[4] set_anchor_rect_message_types = .(null, null, null, null);
    private static wl_interface*[1] set_anchor_message_types = .(null);
    private static wl_interface*[1] set_gravity_message_types = .(null);
    private static wl_interface*[1] set_constraint_adjustment_message_types = .(null);
    private static wl_interface*[2] set_offset_message_types = .(null, null);
    private static wl_interface*[2] set_parent_size_message_types = .(null, null);
    private static wl_interface*[1] set_parent_configure_message_types = .(null);

    
    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public bool   IsBound => proxy != null;
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);

    public void Destroy()
    {
        Wayland.wl_proxy_marshal(proxy, 0);
        Wayland.wl_proxy_destroy(proxy);
    }
    public void SetSize(int32 width, int32 height)
    {
        Wayland.wl_proxy_marshal(proxy, 1, width, height);
    }
    public void SetAnchorRect(int32 x, int32 y, int32 width, int32 height)
    {
        Wayland.wl_proxy_marshal(proxy, 2, x, y, width, height);
    }
    public void SetAnchor(uint32 anchor)
    {
        Wayland.wl_proxy_marshal(proxy, 3, anchor);
    }
    public void SetGravity(uint32 gravity)
    {
        Wayland.wl_proxy_marshal(proxy, 4, gravity);
    }
    public void SetConstraintAdjustment(uint32 constraint_adjustment)
    {
        Wayland.wl_proxy_marshal(proxy, 5, constraint_adjustment);
    }
    public void SetOffset(int32 x, int32 y)
    {
        Wayland.wl_proxy_marshal(proxy, 6, x, y);
    }
    public void SetReactive()
    {
        Wayland.wl_proxy_marshal(proxy, 7);
    }
    public void SetParentSize(int32 parent_width, int32 parent_height)
    {
        Wayland.wl_proxy_marshal(proxy, 8, parent_width, parent_height);
    }
    public void SetParentConfigure(uint32 serial)
    {
        Wayland.wl_proxy_marshal(proxy, 9, serial);
    }
    public enum Error
    {
        InvalidInput = 0,
    }
    public enum Anchor
    {
        None = 0,
        Top = 1,
        Bottom = 2,
        Left = 3,
        Right = 4,
        TopLeft = 5,
        BottomLeft = 6,
        TopRight = 7,
        BottomRight = 8,
    }
    public enum Gravity
    {
        None = 0,
        Top = 1,
        Bottom = 2,
        Left = 3,
        Right = 4,
        TopLeft = 5,
        BottomLeft = 6,
        TopRight = 7,
        BottomRight = 8,
    }
    public enum ConstraintAdjustment
    {
        None = 0,
        SlideX = 1,
        SlideY = 2,
        FlipX = 4,
        FlipY = 8,
        ResizeX = 16,
        ResizeY = 32,
    }
}
[CRepr]
public struct xdg_surface
{
    public static wl_interface Interface = .("xdg_surface", 6, 5, &xdg_surface_requests[0], 1, &xdg_surface_events[0]);
    
    private static wl_message[5] xdg_surface_requests = .(.("destroy", "", null), .("get_toplevel", "n", &get_toplevel_message_types[0]), .("get_popup", "n?oo", &get_popup_message_types[0]), .("set_window_geometry", "iiii", &set_window_geometry_message_types[0]), .("ack_configure", "u", &ack_configure_message_types[0]));
    private static wl_message[1] xdg_surface_events = .(.("configure", "u", &configure_message_types[0]));
    
    private static wl_interface*[1] get_toplevel_message_types = .(&xdg_toplevel.Interface);
    private static wl_interface*[3] get_popup_message_types = .(&xdg_popup.Interface, &xdg_surface.Interface, &xdg_positioner.Interface);
    private static wl_interface*[4] set_window_geometry_message_types = .(null, null, null, null);
    private static wl_interface*[1] ack_configure_message_types = .(null);

    private static wl_interface*[1] configure_message_types = .(null);
    
    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public bool   IsBound => proxy != null;
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);

    public int AddListener(Listener* listener, void* data) => Wayland.wl_proxy_add_listener(proxy, (.)listener, data);      
    
    [CRepr]
    public struct Listener
    {
       public function void(void* data, xdg_surface xdg_surface, uint32 serial) Configure;
    }

    public void Destroy()
    {
        Wayland.wl_proxy_marshal(proxy, 0);
        Wayland.wl_proxy_destroy(proxy);
    }
    public xdg_toplevel GetToplevel()
    {
        wl_proxy* id;
        id = Wayland.wl_proxy_marshal_constructor(proxy, 1, &xdg_toplevel.Interface, null);
        return .(id);
    }
    public xdg_popup GetPopup(xdg_surface parent, xdg_positioner positioner)
    {
        wl_proxy* id;
        id = Wayland.wl_proxy_marshal_constructor(proxy, 2, &xdg_popup.Interface, null, parent, positioner);
        return .(id);
    }
    public void SetWindowGeometry(int32 x, int32 y, int32 width, int32 height)
    {
        Wayland.wl_proxy_marshal(proxy, 3, x, y, width, height);
    }
    public void AckConfigure(uint32 serial)
    {
        Wayland.wl_proxy_marshal(proxy, 4, serial);
    }
    public enum Error
    {
        NotConstructed = 1,
        AlreadyConstructed = 2,
        UnconfiguredBuffer = 3,
        InvalidSerial = 4,
        InvalidSize = 5,
        DefunctRoleObject = 6,
    }
}
[CRepr]
public struct xdg_toplevel
{
    public static wl_interface Interface = .("xdg_toplevel", 6, 14, &xdg_toplevel_requests[0], 4, &xdg_toplevel_events[0]);
    
    private static wl_message[14] xdg_toplevel_requests = .(.("destroy", "", null), .("set_parent", "?o", &set_parent_message_types[0]), .("set_title", "s", &set_title_message_types[0]), .("set_app_id", "s", &set_app_id_message_types[0]), .("show_window_menu", "ouii", &show_window_menu_message_types[0]), .("move", "ou", &move_message_types[0]), .("resize", "ouu", &resize_message_types[0]), .("set_max_size", "ii", &set_max_size_message_types[0]), .("set_min_size", "ii", &set_min_size_message_types[0]), .("set_maximized", "", null), .("unset_maximized", "", null), .("set_fullscreen", "?o", &set_fullscreen_message_types[0]), .("unset_fullscreen", "", null), .("set_minimized", "", null));
    private static wl_message[4] xdg_toplevel_events = .(.("configure", "iia", &configure_message_types[0]), .("close", "", null), .("configure_bounds", "ii", &configure_bounds_message_types[0]), .("wm_capabilities", "a", &wm_capabilities_message_types[0]));
    
    private static wl_interface*[1] set_parent_message_types = .(&xdg_toplevel.Interface);
    private static wl_interface*[1] set_title_message_types = .(null);
    private static wl_interface*[1] set_app_id_message_types = .(null);
    private static wl_interface*[4] show_window_menu_message_types = .(&wl_seat.Interface, null, null, null);
    private static wl_interface*[2] move_message_types = .(&wl_seat.Interface, null);
    private static wl_interface*[3] resize_message_types = .(&wl_seat.Interface, null, null);
    private static wl_interface*[2] set_max_size_message_types = .(null, null);
    private static wl_interface*[2] set_min_size_message_types = .(null, null);
    private static wl_interface*[1] set_fullscreen_message_types = .(&wl_output.Interface);

    private static wl_interface*[3] configure_message_types = .(null, null, null);
    private static wl_interface*[2] configure_bounds_message_types = .(null, null);
    private static wl_interface*[1] wm_capabilities_message_types = .(null);
    
    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public bool   IsBound => proxy != null;
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);

    public int AddListener(Listener* listener, void* data) => Wayland.wl_proxy_add_listener(proxy, (.)listener, data);      
    
    [CRepr]
    public struct Listener
    {
       public function void(void* data, xdg_toplevel xdg_toplevel, int32 width, int32 height, wl_array* states) Configure;
       public function void(void* data, xdg_toplevel xdg_toplevel) Close;
       public function void(void* data, xdg_toplevel xdg_toplevel, int32 width, int32 height) ConfigureBounds;
       public function void(void* data, xdg_toplevel xdg_toplevel, wl_array* capabilities) WmCapabilities;
    }

    public void Destroy()
    {
        Wayland.wl_proxy_marshal(proxy, 0);
        Wayland.wl_proxy_destroy(proxy);
    }
    public void SetParent(xdg_toplevel parent)
    {
        Wayland.wl_proxy_marshal(proxy, 1, parent);
    }
    public void SetTitle(char8* title)
    {
        Wayland.wl_proxy_marshal(proxy, 2, title);
    }
    public void SetAppId(char8* app_id)
    {
        Wayland.wl_proxy_marshal(proxy, 3, app_id);
    }
    public void ShowWindowMenu(wl_seat seat, uint32 serial, int32 x, int32 y)
    {
        Wayland.wl_proxy_marshal(proxy, 4, seat, serial, x, y);
    }
    public void Move(wl_seat seat, uint32 serial)
    {
        Wayland.wl_proxy_marshal(proxy, 5, seat, serial);
    }
    public void Resize(wl_seat seat, uint32 serial, uint32 edges)
    {
        Wayland.wl_proxy_marshal(proxy, 6, seat, serial, edges);
    }
    public void SetMaxSize(int32 width, int32 height)
    {
        Wayland.wl_proxy_marshal(proxy, 7, width, height);
    }
    public void SetMinSize(int32 width, int32 height)
    {
        Wayland.wl_proxy_marshal(proxy, 8, width, height);
    }
    public void SetMaximized()
    {
        Wayland.wl_proxy_marshal(proxy, 9);
    }
    public void UnsetMaximized()
    {
        Wayland.wl_proxy_marshal(proxy, 10);
    }
    public void SetFullscreen(wl_output output)
    {
        Wayland.wl_proxy_marshal(proxy, 11, output);
    }
    public void UnsetFullscreen()
    {
        Wayland.wl_proxy_marshal(proxy, 12);
    }
    public void SetMinimized()
    {
        Wayland.wl_proxy_marshal(proxy, 13);
    }
    public enum Error
    {
        InvalidResizeEdge = 0,
        InvalidParent = 1,
        InvalidSize = 2,
    }
    public enum ResizeEdge
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
    public enum State
    {
        Maximized = 1,
        Fullscreen = 2,
        Resizing = 3,
        Activated = 4,
        TiledLeft = 5,
        TiledRight = 6,
        TiledTop = 7,
        TiledBottom = 8,
        Suspended = 9,
    }
    public enum WmCapabilities
    {
        WindowMenu = 1,
        Maximize = 2,
        Fullscreen = 3,
        Minimize = 4,
    }
}
[CRepr]
public struct xdg_popup
{
    public static wl_interface Interface = .("xdg_popup", 6, 3, &xdg_popup_requests[0], 3, &xdg_popup_events[0]);
    
    private static wl_message[3] xdg_popup_requests = .(.("destroy", "", null), .("grab", "ou", &grab_message_types[0]), .("reposition", "ou", &reposition_message_types[0]));
    private static wl_message[3] xdg_popup_events = .(.("configure", "iiii", &configure_message_types[0]), .("popup_done", "", null), .("repositioned", "u", &repositioned_message_types[0]));
    
    private static wl_interface*[2] grab_message_types = .(&wl_seat.Interface, null);
    private static wl_interface*[2] reposition_message_types = .(&xdg_positioner.Interface, null);

    private static wl_interface*[4] configure_message_types = .(null, null, null, null);
    private static wl_interface*[1] repositioned_message_types = .(null);
    
    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {
        this.proxy = proxy;
    }
    
    public bool   IsBound => proxy != null;
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);

    public int AddListener(Listener* listener, void* data) => Wayland.wl_proxy_add_listener(proxy, (.)listener, data);      
    
    [CRepr]
    public struct Listener
    {
       public function void(void* data, xdg_popup xdg_popup, int32 x, int32 y, int32 width, int32 height) Configure;
       public function void(void* data, xdg_popup xdg_popup) PopupDone;
       public function void(void* data, xdg_popup xdg_popup, uint32 token) Repositioned;
    }

    public void Destroy()
    {
        Wayland.wl_proxy_marshal(proxy, 0);
        Wayland.wl_proxy_destroy(proxy);
    }
    public void Grab(wl_seat seat, uint32 serial)
    {
        Wayland.wl_proxy_marshal(proxy, 1, seat, serial);
    }
    public void Reposition(xdg_positioner positioner, uint32 token)
    {
        Wayland.wl_proxy_marshal(proxy, 2, positioner, token);
    }
    public enum Error
    {
        InvalidGrab = 0,
    }
}
