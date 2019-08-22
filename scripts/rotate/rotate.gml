/// @param dir
var dir = argument0;

if dir != 1 and dir != -1 {
    return
}

with o_player {
    var rotated = rotate_matrix(tetromino, dir)
    if collides(rotated, position) {
        return
    }

    tetromino = rotated
    redraw_player()
}