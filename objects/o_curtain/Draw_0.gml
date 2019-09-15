var level = global.level
var colours = o_game.colours
var cols = o_game.cols
var game_padding_cols = o_main.game_padding_cols
var game_padding_rows = o_main.game_padding_rows

var tile_height = sprite_get_height(s_tile)
var tmp = colours[level % len(colours)]
var white = tmp[0]
var colour1 = tmp[1]
var colour2 = tmp[2]
var xx = game_padding_cols * tile_height
var offset_y = game_padding_rows * tile_height
var width = (cols - 0.25) * tile_height

for (var i=0; i<length; i++) {
    var yy = offset_y + i * tile_height
    draw_rectangle_color(xx, yy + 0, xx + width, yy + 1, colour1, colour1, colour1, colour1, false)
    draw_rectangle_color(xx, yy + 2, xx + width, yy + 4, white, white, white, white, false)
    draw_rectangle_color(xx, yy + 5, xx + width, yy + 6, colour2, colour2, colour2, colour2, false)
    draw_rectangle_color(xx, yy + 7, xx + width, yy + 7, c_black, c_black, c_black, c_black, false)
}