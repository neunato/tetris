var delay_spawn = o_game.delay_spawn

with o_player {
    var pos = [position[0] + 1, position[1]]
    if collides(tetromino, pos) {
        cleared = lock()
        clear(cleared)
        spawn(delay_spawn)
    }
    else {
        position = pos
        redraw_player()
    }
}