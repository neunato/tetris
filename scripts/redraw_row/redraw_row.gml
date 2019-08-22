/// @param r
var r = argument0;

var map = o_game.map
var cols = o_game.cols

for (var c=0; c<cols; c++) {
    var tile = get(map, r, c)
    if tile != noone {
        move_sprite_to(tile, r, c)
    }
}