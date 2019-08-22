
with o_player {
    var n = len(tetromino) - 1
    for (var r=n; r>=0; r--) {
        for (var c=n; c>=0; c--) {
            var tile = get(tetromino, r, c)
            if tile != noone {
                move_sprite_to(tile, position[0] + r, position[1] + c)
            }
        }
    }
}