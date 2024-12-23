using System;
using System.Interop;
namespace Wayland;

public static
{
	public const uint32 WL_MARSHAL_FLAG_DESTROY = (1 << 0);
}

public struct wl_object;

[CRepr]
public struct wl_message
{
	public char8* name;
	public char8* signature;
	public wl_interface** types;
}

[CRepr]
public struct wl_interface
{
	public char8* name;
	public int version;
	public int method_count;
	public wl_message* methods;
	public int event_count;
	public wl_message* events;
}

[CRepr]
public struct wl_list
{
	public wl_list *prev;
	public wl_list *next;
}

[CRepr]
public struct wl_array
{
	public c_size size;
	public c_size alloc;
	public void* data;
}

typealias wl_fixed_t = int32;

[CRepr, Union]
public struct wl_argument
{
	int32 i;
	uint32 u;
	wl_fixed_t f;
	char8* s;
	wl_object* o;
	uint32 n;
	wl_array* a;
	int32 h;
}

typealias wl_dispatcher_func_t = function int(void* user_data, void* target, uint32 opcode, wl_message* msg, wl_argument* args);
typealias wl_log_func_t = function void(char8* fmt, void* args);

public enum wl_iterator_result
{
	WL_ITERATOR_STOP,
	WL_ITERATOR_CONTINUE
}

public struct wl_proxy;
public struct wl_display;
public struct wl_event_queue;


class Wayland
{
	// wl_link
	[Import("wayland-client.so"), CLink]
	public static extern void wl_list_init(wl_list *list);
	[Import("wayland-client.so"), CLink]
	public static extern void wl_list_insert(wl_list *list, wl_list *elm);
	[Import("wayland-client.so"), CLink]
	public static extern void wl_list_remove(wl_list *elm);
	[Import("wayland-client.so"), CLink]
	public static extern int wl_list_length(wl_list *list);
	[Import("wayland-client.so"), CLink]
	public static extern int wl_list_empty(wl_list *list);
	[Import("wayland-client.so"), CLink]
	public static extern void wl_list_insert_list(wl_list *list, wl_list *other);

	// wl_array
	[Import("wayland-client.so"), CLink]
	public static extern void wl_array_init(wl_array *array);
	[Import("wayland-client.so"), CLink]
	public static extern void wl_array_release(wl_array *array);
	[Import("wayland-client.so"), CLink]
	public static extern void* wl_array_add(wl_array *array, c_size size);
	[Import("wayland-client.so"), CLink]
	public static extern int wl_array_copy(wl_array *array, wl_array *source);

	// wl_proxy
	[Import("wayland-client.so"), CLink]
	public static extern wl_proxy* wl_proxy_marshal_flags(wl_proxy *proxy, uint32 opcode, wl_interface *iface, uint32 version, uint32 flags, ...);
	[Import("wayland-client.so"), CLink]
	public static extern wl_proxy* wl_proxy_marshal_array_flags(wl_proxy *proxy, uint32 opcode, wl_interface *iface, uint32 version, uint32 flags, wl_argument *args);
	[Import("wayland-client.so"), CLink]
	public static extern void wl_proxy_marshal(wl_proxy *p, uint32 opcode, ...);
	[Import("wayland-client.so"), CLink]
	public static extern void wl_proxy_marshal_array(wl_proxy *p, uint32 opcode, wl_argument *args);
	[Import("wayland-client.so"), CLink]
	public static extern wl_proxy* wl_proxy_create(wl_proxy *factory, wl_interface *iface);
	[Import("wayland-client.so"), CLink]
	public static extern void* wl_proxy_create_wrapper(void *proxy);
	[Import("wayland-client.so"), CLink]
	public static extern void wl_proxy_wrapper_destroy(void *proxy_wrapper);
	[Import("wayland-client.so"), CLink]
	public static extern wl_proxy* wl_proxy_marshal_constructor(wl_proxy *proxy, uint32 opcode, wl_interface *iface, ...);
	[Import("wayland-client.so"), CLink]
	public static extern wl_proxy* wl_proxy_marshal_constructor_versioned(wl_proxy *proxy, uint32 opcode, wl_interface *iface, uint32 version, ...);
	[Import("wayland-client.so"), CLink]
	public static extern wl_proxy* wl_proxy_marshal_array_constructor(wl_proxy *proxy, uint32 opcode, wl_argument *args, wl_interface *iface);
	[Import("wayland-client.so"), CLink]
	public static extern wl_proxy* wl_proxy_marshal_array_constructor_versioned(wl_proxy *proxy, uint32 opcode, wl_argument *args, wl_interface *iface, uint32 version);
	[Import("wayland-client.so"), CLink]
	public static extern void wl_proxy_destroy(wl_proxy *proxy);
	[Import("wayland-client.so"), CLink]
	public static extern int wl_proxy_add_listener(wl_proxy *proxy, function void(void)* implementation, void *data);
	[Import("wayland-client.so"), CLink]
	public static extern void * wl_proxy_get_listener(wl_proxy *proxy);
	[Import("wayland-client.so"), CLink]
	public static extern int wl_proxy_add_dispatcher(wl_proxy *proxy, wl_dispatcher_func_t dispatcher_func, void *dispatcher_data, void *data);
	[Import("wayland-client.so"), CLink]
	public static extern void wl_proxy_set_user_data(wl_proxy *proxy, void *user_data);
	[Import("wayland-client.so"), CLink]
	public static extern void* wl_proxy_get_user_data(wl_proxy *proxy);
	[Import("wayland-client.so"), CLink]
	public static extern uint32 wl_proxy_get_version(wl_proxy *proxy);
	[Import("wayland-client.so"), CLink]
	public static extern uint32 wl_proxy_get_id(wl_proxy *proxy);
	[Import("wayland-client.so"), CLink]
	public static extern void wl_proxy_set_tag(wl_proxy *proxy, char8 **tag);
	[Import("wayland-client.so"), CLink]
	public static extern char8** wl_proxy_get_tag(wl_proxy *proxy);
	[Import("wayland-client.so"), CLink]
	public static extern char8* wl_proxy_get_class(wl_proxy *proxy);
	[Import("wayland-client.so"), CLink]
	public static extern wl_display* wl_proxy_get_display(wl_proxy *proxy);
	[Import("wayland-client.so"), CLink]
	public static extern void wl_proxy_set_queue(wl_proxy *proxy, wl_event_queue *queue);
	[Import("wayland-client.so"), CLink]
	public static extern wl_event_queue* wl_proxy_get_queue(wl_proxy *proxy);

	// wl_event_queue
	[Import("wayland-client.so"), CLink]
	public static extern void wl_event_queue_destroy(wl_event_queue *queue);
	[Import("wayland-client.so"), CLink]
	public static extern char8* wl_event_queue_get_name(wl_event_queue *queue);

	// wl_display
	[Import("wayland-client.so"), CLink]
	public static extern wl_display* wl_display_connect(char8 *name);
	[Import("wayland-client.so"), CLink]
	public static extern wl_display* wl_display_connect_to_fd(int fd);
	[Import("wayland-client.so"), CLink]
	public static extern void wl_display_disconnect(wl_display *display);
	[Import("wayland-client.so"), CLink]
	public static extern int wl_display_get_fd(wl_display *display);
	[Import("wayland-client.so"), CLink]
	public static extern int wl_display_dispatch(wl_display *display);
	[Import("wayland-client.so"), CLink]
	public static extern int wl_display_dispatch_queue(wl_display *display, wl_event_queue *queue);
	[Import("wayland-client.so"), CLink]
	public static extern int wl_display_dispatch_queue_pending(wl_display *display, wl_event_queue *queue);
	[Import("wayland-client.so"), CLink]
	public static extern int wl_display_dispatch_pending(wl_display *display);
	[Import("wayland-client.so"), CLink]
	public static extern int wl_display_get_error(wl_display *display);
	[Import("wayland-client.so"), CLink]
	public static extern uint32 wl_display_get_protocol_error(wl_display *display, wl_interface **iface, uint32 *id);
	[Import("wayland-client.so"), CLink]
	public static extern int wl_display_flush(wl_display *display);
	[Import("wayland-client.so"), CLink]
	public static extern int wl_display_roundtrip_queue(wl_display *display, wl_event_queue *queue);
	[Import("wayland-client.so"), CLink]
	public static extern int wl_display_roundtrip(wl_display *display);
	[Import("wayland-client.so"), CLink]
	public static extern wl_event_queue* wl_display_create_queue(wl_display *display);
	[Import("wayland-client.so"), CLink]
	public static extern wl_event_queue* wl_display_create_queue_with_name(wl_display *display, char8 *name);
	[Import("wayland-client.so"), CLink]
	public static extern int wl_display_prepare_read_queue(wl_display *display, wl_event_queue *queue);
	[Import("wayland-client.so"), CLink]
	public static extern int wl_display_prepare_read(wl_display *display);
	[Import("wayland-client.so"), CLink]
	public static extern void wl_display_cancel_read(wl_display *display);
	[Import("wayland-client.so"), CLink]
	public static extern int wl_display_read_events(wl_display *display);
	[Import("wayland-client.so"), CLink]
	public static extern void wl_display_set_max_buffer_size(wl_display *display, c_size max_buffer_size);

	// wl_log
	[Import("wayland-client.so"), CLink]
	public static extern void wl_log_set_handler_client(wl_log_func_t handler);

	// wl_fixed
	[Inline] static double wl_fixed_to_double(wl_fixed_t f) => f / 256.0;
	[Inline] static wl_fixed_t wl_fixed_from_double(double d) => (wl_fixed_t) (d * 256.0);
	[Inline] static int wl_fixed_to_int(wl_fixed_t f) => f / 256;
	[Inline] static wl_fixed_t wl_fixed_from_int(int i) => (.)i * 256;
}