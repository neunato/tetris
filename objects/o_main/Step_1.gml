// upscale to the highest integer value that fits the screen
var window_width = window_get_width()
var window_height = window_get_height()
var scale_x = window_width / room_width
var scale_y = window_height / room_height
var scale = floor(min(scale_x, scale_y))
var game_width = room_width * scale
var game_height = room_height * scale

// window size changed
if window_width != global.window_width or window_height != global.window_height {
    global.window_width = window_width
    global.window_height = window_height
}

// game size changed, resize surface
if game_width != global.game_width or game_height != global.game_height {
    global.game_width = game_width
    global.game_height = game_height
    if game_width > 0 and game_height > 0 {
        surface_resize(application_surface, game_width, game_height)
    }
}
