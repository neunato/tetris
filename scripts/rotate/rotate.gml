/// @param dir
var dir = argument0;

if dir != 1 and dir != -1 {
    return
}

with o_game {
    var n = len(player_rotations)
    var at = (player_rotations_at + dir + n) % n
    var rotated = player_rotations[at]
    if collides(rotated, player_position) {
        return
    }

    tetromino = rotated
    player_rotations_at = at
    redraw_player()
}