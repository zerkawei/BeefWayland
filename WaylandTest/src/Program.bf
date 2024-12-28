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
            compositor = .((.)registry.Bind(id, &wl_compositor.Interface, version));
        }
    }

    static void RegistryGlobalRemoveHandler(void* data, wl_registry registry, uint32 id) {}

    static wl_registry.Listener registry_listener = .{
        Global = => RegistryGlobalHandler,
        GlobalRemove = => RegistryGlobalRemoveHandler
    };

    public static void Main()
    {
        display = wl_display.Connect(null);
        if(!display.IsBound)
        {
            Console.WriteLine("Failed to connect to display.");
            return;
        }

        registry = display.GetRegistry();
        registry.AddListener(&registry_listener, null);
        
        display.Dispatch();
        display.Roundtrip();
        
        if(!compositor.IsBound)
        {
            Console.WriteLine("Can't find compositor.");
        }

        display.Disconnect();
    }
}