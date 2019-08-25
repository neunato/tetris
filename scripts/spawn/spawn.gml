/// @param delay = 0
var delay = argument_count > 0 ? argument[0] : 0;

if delay > 0 {
    with o_game {
        timer_spawn = delay
    }
    return
}

var cols = o_game.cols
var tetromino_hitboxes = o_game.tetromino_hitboxes

with o_player {
    if len(next_rotations) == 0 {
        spawn_next()
        spawn()
        return
    }

    // take next tetromino
    tiles = next_tiles
    rotations = next_rotations
    rotations_at = 0
    tetromino = rotations[0]

    // centre it
    var tmp = tetromino_hitboxes[? tetromino]
    var offset_top = tmp[0]
    position[0] = -offset_top
    position[1] = floor((cols - len(tetromino)) / 2)

    // spawn next random tetromino
    spawn_next()

    redraw_next()
    redraw_player()

    if collides(tetromino, position) {
        defeat()
    }
}