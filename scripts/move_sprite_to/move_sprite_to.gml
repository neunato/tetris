/// @param tile
/// @param r
/// @param c
var tile = argument0, r = argument1, c = argument2;

with tile {
    x = (c + o_main.game_padding_cols) * sprite_height
    y = (r + o_main.game_padding_rows) * sprite_height
    visible = r >= 0
}