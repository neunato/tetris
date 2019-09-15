// game stuff
global.playing        = false
global.level          = undefined
global.lines          = undefined
global.lines_in_level = undefined
global.points         = undefined

// scaling stuff
global.game_width    = 0
global.game_height   = 0
global.window_width  = 0
global.window_height = 0

// key bindings
global.key_left         = vk_left
global.key_right        = vk_right
global.key_down         = vk_down
global.key_rotate_left  = ord("A")
global.key_rotate_right = ord("D")
global.menu_level       = 18

// controller objects
instance_create(o_game)


// menu
var menu_root = ["", menu_type.menu, [
    ["resume", menu_type.trigger, [menu_close, true], "playing"],
    ["new game", menu_type.trigger, [start_game, true]],
    ["level", menu_type.select, ["menu_level", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19], global.menu_level]],
    ["settings", menu_type.menu, [
        ["fullscreen", menu_type.fullscreen],
        ["left", menu_type.keybind, ["key_left"]],
        ["right", menu_type.keybind, ["key_right"]],
        ["down", menu_type.keybind, ["key_down"]],
        ["rotate cw", menu_type.keybind, ["key_rotate_right"]],
        ["rotate ccw", menu_type.keybind, ["key_rotate_left"]],
        ["back", menu_type.back]
    ]],
    ["quit", menu_type.quit],
]]
var menu_settings = [
    ["close_on_escape", "playing"]
]
global.menu = menu_create(menu_root, menu_settings, true)


// upscale the window up to four times
var tile_width = sprite_get_height(s_tile)

room_width = 19 * tile_width
room_height = 21 * tile_width

game_padding_rows = (21 - o_game.rows) / 2
game_padding_cols = (19 - o_game.cols - 1 - 5) / 2

var display_width = display_get_width()
var display_height = display_get_height()
var scale_x = display_width / room_width
var scale_y = display_height / room_height
scale = min(4, floor(min(scale_x, scale_y)))

if scale > 1 {
    var window_width = room_width * scale
    var window_height = room_height * scale
    window_set_size(window_width, window_height)
    alarm[0] = 1
}
application_surface_draw_enable(false)
