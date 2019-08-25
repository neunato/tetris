// game stuff
global.paused = true
global.level = undefined
global.lines = undefined
global.lines_in_level = undefined
global.points = undefined

// scaling stuff
global.game_width = 0
global.game_height = 0
global.window_width = 0
global.window_height = 0

// controller objects
instance_create(o_game)
instance_create(o_player)
instance_create(o_controls)

// upscale the window up to four times
var display_width = display_get_width()
var display_height = display_get_height()
var scale_x = display_width / room_width
var scale_y = display_height / room_height
var scale = min(4, floor(min(scale_x, scale_y)))
if scale > 1 {
    var window_width = room_width * scale
    var window_height = room_height * scale
    window_set_size(window_width, window_height)
    alarm[0] = 1
}
application_surface_draw_enable(false)


// game start
start(0)
