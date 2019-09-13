/// @param menu
var menu = argument0;

var stack = menu.stack
var root = menu.root

if not ds_list_empty(stack) {
    ds_list_clear(stack)
}

var title = root[0]
var menu_items = root[2]
ds_list_add(stack, [title, menu_items, 0, []])

menu.open = true
menu.open_prev = false

instance_activate_object(menu)