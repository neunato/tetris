/// @param dir
var dir = argument0;

if dir != 1 and dir != -1 {
    return
}

with o_player {
    var pos = [position[0], position[1] + dir]
    if collides(tetromino, pos) {
        o_game.timer_shift = 1
        return
    }

    position = pos
    redraw_player()
}