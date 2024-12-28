using System;
using Wayland;
using XdgShell;
namespace WaylandTest;

public class Program
{
    static wl_display display;
    static wl_registry registry;
    static wl_compositor compositor;
    static wl_surface surface;

    static xdg_wm_base wm;
    static xdg_surface xdgSurface;
    static xdg_toplevel toplevel;

    static bool closed = false;
    
    static wl_registry.Listener registry_listener = .{
        Global = (data, registry, id, iface, version) => 
        {
            switch(StringView(iface))
            {
                case "wl_compositor":
                    compositor = .((.)registry.Bind(id, &wl_compositor.Interface, version));
                case "xdg_wm_base":
                    wm = .((.)registry.Bind(id, &xdg_wm_base.Interface, version));
            }
        },
        GlobalRemove = (data, registry, id) => {}
    };
    static xdg_wm_base.Listener wm_listener = .{
        Ping = (data, wm, serial) => wm.Pong(serial)
    };
    static xdg_surface.Listener surface_listener = .{
        Configure = (data, surface, serial) => surface.AckConfigure(serial)
    };
    static xdg_toplevel.Listener toplevel_listener = .{
        Configure = (data, toplevel, width, height, states) => {},
        Close = (data, toplevel) => { closed = true; },
        ConfigureBounds = (data, toplevel, width, height) => {},
        WmCapabilities = (data, toplevel, wl_array) => {}
    };

    public static void Main()
    {
        display = wl_display.Connect(null);
        if(!display.IsBound)
        {
            Console.WriteLine("Failed to connect to display.");
            return;
        }

        if(Init() case .Err)
        {
            display.Disconnect();
            return;
        }

        while(!closed)
        {
            if(display.Dispatch() < 0) break;
        }

        display.Disconnect();
    }

    public static Result<void> Init()
    {
        registry = display.GetRegistry();
        registry.AddListener(&registry_listener, null);
        
        display.Dispatch();
        display.Roundtrip();
        
        if(!compositor.IsBound) return .Err;
    
        surface = compositor.CreateSurface();
        if(!surface.IsBound) return .Err;

        wm.AddListener(&wm_listener, null);

        xdgSurface = wm.GetXdgSurface(surface);
        xdgSurface.AddListener(&surface_listener, null);

        toplevel = xdgSurface.GetToplevel();
        toplevel.AddListener(&toplevel_listener, null);

        surface.Commit();
        return .Ok;
    }
}