var game_padding_rows = o_main.game_padding_rows
var game_padding_cols = o_main.game_padding_cols

var tile_width = sprite_get_height(s_tile)
var font_size = font_get_size(f_main)

// draw border around playfield
var xx = (game_padding_cols - 0.25) * tile_width
var yy = (game_padding_rows - 0.25) * tile_width
var width = (cols + 0.125) * tile_width + 0.1           // 0.1 of a pixel (before scaling) pushes the border by one pixel
var height = (rows + 0.125) * tile_width + 0.1          // 0.1 of a pixel (before scaling) pushes the border by one pixel
draw_rectangle(xx, yy, xx + width, yy + height, true)

// draw ui texts
draw_set_font(f_main)
xx = (cols + game_padding_cols + 1) * tile_width
yy = 10
draw_text(xx, yy, "SCORE")
yy += 15
draw_text(xx, yy, global.points)
yy += 25
draw_text(xx, yy, "NEXT")
yy += 40
draw_text(xx, yy, "LINES")
yy += 15
draw_text(xx, yy, global.lines)
yy += 25
draw_text(xx, yy, "LEVEL")
yy += 15
draw_text(xx, yy, global.level)