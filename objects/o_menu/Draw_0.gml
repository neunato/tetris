if ds_list_empty(stack) {
    return
}

// draw background
draw_set_color(c_black)
draw_rectangle(0, 0, room_width, room_height, false)


if visible_size == 0 {
    return
}

var stack_size = ds_list_size(stack)
var menu = stack[|stack_size - 1]
var title = menu[0]
var index = menu[2]
var menu_size = len(visible_items)
var selected_item = visible_items[index]

if selected_item == undefined {
    return
}

var selected_type = selected_item[1]


// draw visible menu items
var font_size = font_get_size(f_main)
var menu_width = 150
var menu_item_height = font_size * 2
var offset_x = max(0, (room_width - menu_width) / 2)
var offset_y = max(0, (room_height - menu_item_height*visible_size) / 2)
var at = 0
for (var i=0; i<menu_size; i++) {
    var item = visible_items[i]
    if item == undefined {
        continue
    }

    var label_left = item[0]
    var label_right = undefined
    var type = item[1]

    switch type {
        case menu_type.select:
            var args = item[2]
            var options = args[1]
            var options_index = args[2]
            label_right = options[options_index]
        break

        case menu_type.keybind:
            if not (inputting and blinking and i == index) {
                var args = item[2]
                var name = args[0]
                var vk = global_get(name)
                switch vk {
                    //case vk_enter:        label_right = "enter" break
                    //case vk_escape:       label_right = "escape"      break
                    case vk_left:           label_right = "left key"    break
                    case vk_right:          label_right = "right key"   break
                    case vk_up:             label_right = "up key"      break
                    case vk_down:           label_right = "down key"    break
                    case vk_space:          label_right = "space"       break
                    //case vk_lshift:       label_right = "left shift"  break
                    //case vk_rshift:       label_right = "right shift" break
                    case vk_shift:          label_right = "shift"       break
                    case vk_lcontrol:       label_right = "left ctrl"   break
                    case vk_rcontrol:       label_right = "right ctrl"  break
                    //case vk_control:      label_right = "ctrl"        break
                    case vk_lalt:           label_right = "left alt"    break
                    case vk_ralt:           label_right = "right alt"   break
                    //case vk_alt:          label_right = "alt"         break
                    case vk_backspace:      label_right = "backspace"   break
                    case vk_tab:            label_right = "tab"         break
                    case vk_home:           label_right = "home"        break
                    case vk_end:            label_right = "end"         break
                    case vk_delete:         label_right = "delete"      break
                    case vk_insert:         label_right = "insert"      break
                    case vk_pageup:         label_right = "pageup"      break
                    case vk_pagedown:       label_right = "page down"   break
                    case vk_pause:          label_right = "break"       break
                    case vk_printscreen:    label_right = "printscreen" break
                    case vk_f1:             label_right = "f1"          break
                    case vk_f2:             label_right = "f2"          break
                    case vk_f3:             label_right = "f3"          break
                    case vk_f4:             label_right = "f4"          break
                    case vk_f5:             label_right = "f5"          break
                    case vk_f6:             label_right = "f6"          break
                    case vk_f7:             label_right = "f7"          break
                    case vk_f8:             label_right = "f8"          break
                    case vk_f9:             label_right = "f9"          break
                    case vk_f10:            label_right = "f10"         break
                    case vk_f11:            label_right = "f11"         break
                    case vk_f12:            label_right = "f12"         break
                    case vk_numpad0:        label_right = "numpad 0"    break
                    case vk_numpad1:        label_right = "numpad 1"    break
                    case vk_numpad2:        label_right = "numpad 2"    break
                    case vk_numpad3:        label_right = "numpad 3"    break
                    case vk_numpad4:        label_right = "numpad 4"    break
                    case vk_numpad5:        label_right = "numpad 5"    break
                    case vk_numpad6:        label_right = "numpad 6"    break
                    case vk_numpad7:        label_right = "numpad 7"    break
                    case vk_numpad8:        label_right = "numpad 8"    break
                    case vk_numpad9:        label_right = "numpad 9"    break
                    case vk_decimal:        label_right = "numpad ,"    break
                    case vk_multiply:       label_right = "*"           break
                    case vk_divide:         label_right = "/"           break
                    case vk_add:            label_right = "+"           break
                    case vk_subtract:       label_right = "-"           break
                    default:                label_right = chr(vk)
                }
            }
        break

        case menu_type.fullscreen:
            var fullscreen = window_get_fullscreen()
            label_right = fullscreen ? "on" : "off"
        break
    }

    var yy = at * menu_item_height + offset_y
    var colour = i == index ? c_orange : c_white
    draw_set_color(colour)
    draw_text(offset_x, yy, label_left)
    if label_right != undefined {
        draw_text(offset_x + menu_width/2, yy, label_right)
    }

    at++
}