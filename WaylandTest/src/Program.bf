using System;
using Wayland;
namespace WaylandTest;

public class Program
{
    static wl_display display;
    static wl_registry registry;
    static wl_compositor compositor;
    
    static void RegistryGlobalHandler(void* data, wl_registry registry, uint32 id, char8* iface, uint32 version)
    {
        if(StringView(iface) == "wl_compositor")
        {
            compositor = .((.)registry.bind(id, &wl_compositor.Interface, version));
        }
    }

    static void RegistryGlobalRemoveHandler(void* data, wl_registry registry, uint32 id) {}

    static wl_registry.Listener registry_listener = .{
        global = => RegistryGlobalHandler,
        global_remove = => RegistryGlobalRemoveHandler
    };

    public static void Main()
    {
        display = Wayland.wl_display_connect(null);
        if(!display.IsBound)
        {
            Console.WriteLine("Failed to connect to display.");
            return;
        }

        registry = display.get_registry();
        registry.AddListener(&registry_listener, null);
        
        Wayland.wl_display_dispatch(display);
        Wayland.wl_display_roundtrip(display);
        
        if(!compositor.IsBound)
        {
            Console.WriteLine("Can't find compositor.");
        }

        Wayland.wl_display_disconnect(display);
    }
}