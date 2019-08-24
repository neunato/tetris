
with o_player {
    var pos = [position[0] + 1, position[1]]
    if collides(tetromino, pos) {
        var cleared = lock()
        with o_game {
            if len(cleared) > 0 {
                cleared_lines = cleared
                timer_clear = delay_clear
            }
            else {
                spawn(delay_spawn)
            }
        }
    }
    else {
        position = pos
        redraw_player()
    }
}

with o_game {
    timer_gravity = delay_gravity
}
