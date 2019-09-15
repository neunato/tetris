if ds_list_empty(stack) {
    return
}

var key_escape = keyboard_check_pressed(vk_escape)

// open menu - close on escape
if key_escape and close_on_escape and ds_list_size(stack) == 1 and open_prev {
    menu_close(self)
    ds_list_clear(stack)
    open_prev = open
    return
}

open_prev = open

var stack_size = ds_list_size(stack) - 1
var menu = stack[|stack_size]
var items = menu[1]
var items_size = len(items)
var index = menu[2]
visible_items = menu[3]
visible_size = 0


// determine values of dynamic settings
var n = len(lookup_settings)
for (var i=0; i<n; i++) {
    var setting = lookup_settings[i]
    var name = setting[0]
    var global_var = setting[1]
    instance_set(self, name, global_get(global_var))
}

// determine visible menu items
for (var i=items_size-1; i>=0; i--) {
    var item = items[i]
    var global_var = len(item) > 3 ? item[3] : undefined
    if global_var == undefined or global_get(global_var) {
        visible_items[@i] = item
        visible_size++
    }
    else {
        visible_items[@i] = undefined
    }
}

// nothing visible - abort
if visible_size == 0 {
    return
}

// if selected item no longer visible, move to next one
var selected_item = visible_items[index]
if selected_item == undefined {
    for (var i=1; i<items_size; i++) {
        var j = (index + i) % items_size
        var item = visible_items[j]
        if item != undefined {
            index = j
            selected_item = visible_items[j]
            menu[@2] = j
            break
        }
    }
}


var key_escape = keyboard_check_pressed(vk_escape)
var key_enter  = keyboard_check_pressed(vk_enter)
var key_up     = keyboard_check_pressed(vk_up)
var key_down   = keyboard_check_pressed(vk_down)
var key_left   = keyboard_check_pressed(vk_left)
var key_right  = keyboard_check_pressed(vk_right)

var stack_size = ds_list_size(stack)
var menu = stack[|stack_size - 1]
var index = menu[2]
var items_size = len(visible_items)
var selected_item = visible_items[index]
var selected_type = selected_item[1]

// awaiting key input
if inputting {
    // abort on enter/escape
    if key_enter or key_escape {
        inputting = false
        return
    }

    // assign new key
    if keyboard_lastkey != vk_enter {
        var args = selected_item[2]
        global_set(args[0], keyboard_lastkey)
        inputting = false
    }

    // text blinking
    if alarm[0] == -1 {
        alarm[0] = 30
    }

    return
}

// escape - pop from stack
if key_escape and pop_on_escape and stack_size > 1 {
    ds_list_delete(stack, stack_size - 1)
    return
}

// navigation - up and down move to next visible element
var dir = key_down - key_up
if dir != 0 {
    for (var i=1; i<items_size; i++) {
        var j = (index + i * dir + items_size) % items_size
        var item = visible_items[j]
        if item != undefined {
            index = j
            break
        }
    }
    menu[@2] = index
}

// trigger select control (left, right or enter key)
if selected_type == menu_type.select and (key_enter or key_left or key_right) {
    var dir = (key_right or key_enter) - key_left
    if dir != 0 {
        var args = selected_item[2]
        var name = args[0]
        var options = args[1]
        var at = args[2]
        var n = len(options)
        at = (at + dir + n) % n
        args[@2] = at
        global_set(name, options[at])
    }
}

// trigger other controls (enter)
else if key_enter {
    switch selected_type {
        case menu_type.menu:
            //global.playing = true
            var title = selected_item[0]
            var menu_items = selected_item[2]
            ds_list_add(stack, [title, menu_items, 0, []])
        break

        case menu_type.trigger:
            var args = selected_item[2]
            var script = args[0]
            var pop_on_select = len(args) > 1 ? args[1] : false
            script_execute(script)
            if pop_on_select {
                ds_list_delete(stack, stack_size - 1)
            }
        break

        case menu_type.keybind:
            inputting = true
            blinking = true
        break

        case menu_type.fullscreen:
            var fullscreen = window_get_fullscreen()
            window_set_fullscreen(not fullscreen)
        break

        case menu_type.back:
            ds_list_delete(stack, stack_size - 1)
        break

        case menu_type.quit:
            game_end()
        break
    }
    
    // trigger and back can remove items from stack
    if ds_list_empty(stack) {
        menu_close(self)
    }
}
