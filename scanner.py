import sys
import xml.etree.ElementTree as ET
from xml.etree.ElementTree import Element

beef_type_of = {
    "int": "int32",
    "uint": "uint32",
    "fixed": "wl_fixed_t",
    "string": "char8*",
    "object": "wl_object*",
    "new_id": "uint32",
    "array": "wl_array*",
    "fd": "int32"
}

def char_type_of(arg : Element) -> str:
    type = "?" if arg.get("allow-null") == "true" else ""
    match arg.get("type"):
        case "int":
            type += 'i'
        case "uint":
            type += 'u'
        case "fixed":
            type += 'f'
        case "string":
            type += 's'
        case "object":
            type += 'o'
        case "new_id":
            type += 'n'
        case "array":
            type += 'a'
        case "fd":
            type += 'h'
    return type

def signature_of(message : Element) -> tuple[str, list[str | None]]:
    signature = ""
    types = []
    
    for arg in message.findall("arg"):
        signature += char_type_of(arg)
        types.append(arg.get("interface"))
        
    return (signature, types)
    

def beef_safe(str : str) -> str:
    if str == "interface":
        return "iface"
    elif str[0].isdigit():
        return "_"+str
    else:
        return str

def to_pascal(str) -> str:
    return str.replace("_", " ").title().replace(" ", "")

def build_enum(enum : Element) -> str:
    out_text = f'    public enum {enum.attrib["name"]}\n    {{\n'
    for entry in enum.findall("entry"):
        out_text += f'        {beef_safe(to_pascal(entry.attrib["name"]))} = {entry.attrib["value"]},\n'
    out_text += "    }\n"
    return out_text

def build_event(event : Element, iface : Element) -> str:
    out_text = f'       public function void(void* data, {iface.attrib["name"]}* {iface.attrib["name"]}'
    for arg in event.findall("arg"):
        out_text += f', {beef_type_of[arg.attrib["type"]]} {beef_safe(arg.attrib["name"])}'
    out_text += f') {event.attrib["name"]};\n'
    return out_text

def build_request(request : Element, opcode : int) -> str:
    args = request.findall("arg")
    
    out_text = '    public ' 
    constructed = next((arg for arg in args if arg.attrib["type"] == "new_id"), None)
    unspecified_constructor = False
    if constructed == None:
        out_text += 'void '
    elif constructed.get("interface") == None:
        out_text += 'void* '
        unspecified_constructor = True
    else:
        out_text += constructed.get("interface") + ' '
    out_text += request.get('name') + '('
    
    first = True
    for arg in args:
        if arg.get('type') == "new_id":
            continue
        if first:
            first = False
        else:
            out_text += ', '
        out_text += f'{beef_type_of[arg.attrib["type"]]} {beef_safe(arg.attrib["name"])}'
    if unspecified_constructor:
        out_text += ', wl_interface* iface, uint32 version'   
    
    out_text += ')\n    {\n'
    
    if constructed != None:
        out_text += '        wl_proxy* id;\n        id = '
        if unspecified_constructor:
            out_text += f'Wayland.wl_proxy_marshal_constructor_versioned(proxy, {opcode}, iface, version'
            for arg in args:
                if arg.get('type') == "new_id":
                    out_text += ', iface.name, version, null'
                else:
                    out_text += f', {beef_safe(arg.get("name"))}'
            out_text += ');\n'
            out_text += '        return (.)id;\n'
        else:
            out_text += f'Wayland.wl_proxy_marshal_constructor(proxy, {opcode}, &{constructed.get("interface")}.Interface'
            for arg in args:
                if arg.get('type') == "new_id":
                    out_text += ', null'
                else:
                    out_text += f', {beef_safe(arg.get("name"))}'
            out_text += ');\n'
            out_text += '        return .(id);\n'
    else:
        out_text += f'        Wayland.wl_proxy_marshal(proxy, {opcode}'
        for arg in args:
            out_text += f', {beef_safe(arg.get("name"))}'
        out_text += ');\n'
    
    if request.get("type") == "destructor":
        out_text += '        Wayland.wl_proxy_destroy(proxy);\n'
    
    out_text += '    }\n'
    return out_text

def build_message(message : Element) -> str:
    signature, types = signature_of(message)    
    return f'.("{message.get("name")}", "{signature}", &{message.get("name")}_message_types[0])' if len(types) > 0 else f'.("{message.get("name")}", "", null)'

def build_message_types(message : Element) -> str:
    signature, types = signature_of(message)    
    return f'    private static wl_interface*[{len(types)}] {message.get("name")}_message_types = .({", ".join(f"&{type}.Interface" if type != None else "null" for type in types)});\n' if len(types) > 0 else ''

def build_interface(iface : Element) -> str:
    events = iface.findall("event")
    requests = iface.findall("request")
    
    def address_of(list, name):
        return f'&{iface.attrib["name"]}_{name}[0]' if len(list) > 0 else "null"
    
    def definition_of(list, name):
        return f'private static wl_message[{len(list)}] {iface.attrib["name"]}_{name} = .({", ".join(build_message(msg) for msg in list)});'
    
    out_text = f'''\
[CRepr]
public struct {iface.attrib["name"]}
{{
    public static wl_interface Interface = .("{iface.attrib["name"]}", {iface.attrib["version"]}, {len(requests)}, {address_of(requests, "requests")}, {len(events)}, {address_of(events, "events")});
    
    {definition_of(requests, "requests")}
    {definition_of(events, "events")}
    
{"".join(build_message_types(msg) for msg in requests)}
{"".join(build_message_types(msg) for msg in events)}\
    wl_proxy* proxy;
    public this(wl_proxy* proxy)
    {{
        this.proxy = proxy;
    }}
    
    public void   SetUserData(void* userData) => Wayland.wl_proxy_set_user_data(proxy, userData);
    public void*  GetUserData()               => Wayland.wl_proxy_get_user_data(proxy);
    public uint32 GetVersion()                => Wayland.wl_proxy_get_version(proxy);
    public void   Destroy()                   => Wayland.wl_proxy_destroy(proxy);

'''
    if len(events) > 0:
        out_text += '''\
    public int AddListener(Listener* listener, void* data) => Wayland.wl_proxy_add_listener(proxy, (.)listener, data);      
    
    [CRepr]
    public struct Listener
    {
'''
        for event in events:
            out_text += build_event(event, iface)
        out_text += '    }\n\n'
        
    opcode = 0
    for request in requests:
        out_text += build_request(request, opcode)
        opcode += 1

    for enum in iface.findall("enum"):
        out_text += build_enum(enum) 
    out_text += '}\n'
    return out_text

def main() -> int:
    args = sys.argv[1:]
    
    if len(args) != 2:
        return 1
    
    in_path = args[0]
    out_path = args[1]
    
    protocol = ET.parse(in_path).getroot()
    out_text = f'''\
using System;
using Wayland;
namespace {to_pascal(protocol.attrib["name"])};
/*{protocol.find("copyright").text}*/
'''
    
    for iface in protocol.findall('interface'):
        out_text += build_interface(iface)
    
    with open(out_path, "w") as f:
        f.write(out_text)

if __name__ == '__main__':
    sys.exit(main())  # next section explains the use of sys.exit