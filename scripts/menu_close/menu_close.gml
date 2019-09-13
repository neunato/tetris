/// @param menu = o_menu
var menu = argument_count > 0 ? argument[0] : o_menu;

ds_list_clear(menu.stack)
menu.open = false
menu.open_prev = false
instance_deactivate_object(menu)