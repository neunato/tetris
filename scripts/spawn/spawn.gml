/// @param delay = 0
var delay = argument_count > 0 ? argument[0] : 0;

with o_game {
    if delay > 0 {
        timer_entry = delay
        return
    }

    if len(next_rotations) == 0 {
        spawn_next()
        spawn()
        return
    }

    // take next tetromino
    player_tiles = next_tiles
    player_rotations = next_rotations
    player_rotations_at = 0
    tetromino = player_rotations[0]

    // centre it
    var tmp = tetromino_hitboxes[? tetromino]
    var offset_top = tmp[0]
    player_position[0] = -offset_top
    player_position[1] = ceil((cols - len(tetromino)) / 2)

    // spawn next random tetromino
    spawn_next()

    redraw_next()
    redraw_player()

    if collides(tetromino, player_position) {
        end_game()
    }
}