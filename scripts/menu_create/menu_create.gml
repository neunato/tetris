/// @param menu_root
/// @param settings = []
/// @param open = false
var menu_root = argument[0];
var settings = argument_count > 1 ? argument[1] : [];
var open = argument_count > 2 ? argument[2] : false;

var menu = instance_create(o_menu)
menu.root = menu_root
menu.lookup_settings = settings

if open {
    menu_open(menu)
}
else {
    instance_deactivate_object(menu)
}

return menu