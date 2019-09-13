
with o_game {
    var at = 0
    var n = len(tetromino)
    for (var r=0; r<n; r++) {
        for (var c=0; c<n; c++) {
            if get(tetromino, r, c) == 1 {
                var rr = player_position[0] + r
                var cc = player_position[1] + c
                var tile = player_tiles[at]
                move_sprite_to(tile, rr, cc)
                at++
            }
        }
    }
}