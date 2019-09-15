enum menu_type {
    menu,             // ["label", menu_type.menu, [["label", menu_type.back]]
    back,             // ["label", menu_type.back]
    trigger,          // ["title", menu_type.trigger, [script, ?close_on_trigger]]
    select,           // ["title", menu_type.select, [script, ["a", "b"], 0]],
    keybind,          // ["left", menu_type.keybind, ["key_left"]],
    fullscreen,       // ["fullscreen", menu_type.fullscreen]
    quit              // ["quit", menu_type.quit]
}

depth = -1000

root = []
stack = ds_list_create()
lookup_settings = []
open = false
open_prev = false

visible_items = []
visible_size = 0
inputting = false
blinking = false

// settings
pop_on_escape = true
close_on_escape = false

draw_set_font(f_main)
