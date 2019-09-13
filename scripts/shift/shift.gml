/// @param dir
var dir = argument0;

if dir != 1 and dir != -1 {
    return
}

with o_game {
    var position = [player_position[0], player_position[1] + dir]
    if collides(tetromino, position) {
        o_game.timer_shift = 1
        return
    }

    player_position = position
    redraw_player()
}