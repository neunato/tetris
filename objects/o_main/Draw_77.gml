var window_width = global.window_width
var window_height = global.window_height
var game_width = global.game_width
var game_height = global.game_height

if window_width < game_width or window_height < game_height {
    return       // black background
}
var offset_x = (window_width - game_width) / 2
var offset_y = (window_height - game_height) / 2
draw_surface_ext(application_surface, offset_x, offset_y, 1, 1, 0, c_white, 1)