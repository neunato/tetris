/// @param dir
var dir = argument0;

if dir != 1 and dir != -1 {
    return
}

with o_player {
    var n = len(rotations)
    var at = (rotations_at + dir + n) % n
    var rotated = rotations[at]
    if collides(rotated, position) {
        return
    }

    tetromino = rotated
    rotations_at = at
    redraw_player()
}