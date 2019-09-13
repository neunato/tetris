enum menu_type {
    menu,
    back,
    trigger,          // ["title", menu_type.trigger, [script, ?close_on_trigger], ?"global_var_condition"]
    select,           // ["title", menu_type.select, [script, ["a", "b"], 0]],
    keybind,          // ["left", menu_type.keybind, ["key_left"]],
    fullscreen,       // ["fullscreen", menu_type.fullscreen]
    quit,             // ["quit", menu_type.quit]
    padding
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
