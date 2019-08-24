var tile_width = o_tile.sprite_height
var xx = (cols + 0.5) * tile_width
var yy = 5 * tile_width
draw_set_font(f_main)
draw_text(xx, yy, "LEVEL")
yy += 30
draw_text(xx, yy, level)
yy += 50
draw_text(xx, yy, "LINES")
yy += 30
draw_text(xx, yy, lines)
yy += 50
draw_text(xx, yy, "SCORE")
yy += 30
draw_text(xx, yy, points)
