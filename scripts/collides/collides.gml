/// @param tetromino
/// @param position
var tetromino = argument0, position = argument1;

var map = o_game.map
var rows = o_game.rows
var cols = o_game.cols

var n = len(tetromino)
for (var i=0; i<n; i++) {
    for (var j=0; j<n; j++) {
        if get(tetromino, i, j) == 0 {
            continue
        }
        var r = i + position[0]
        var c = j + position[1]
        if r >= rows {
            return true
        }
        if c < 0 or c >= cols {
            return true
        }
        if get(map, r, c) != noone {
            return true
        }
    }
}

return false