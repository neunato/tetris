
with o_player {
    var at = 0
    var n = len(tetromino)
    for (var r=0; r<n; r++) {
        for (var c=0; c<n; c++) {
            if get(tetromino, r, c) == 1 {
                var rr = position[0] + r
                var cc = position[1] + c
                var tile = tiles[at]
                move_sprite_to(tile, rr, cc)
                at++
            }
        }
    }
}