var cols = o_game.cols
var tetromino_hitboxes = o_game.tetromino_hitboxes

with o_player {
    var next = next_rotations[0]
    var tmp = tetromino_hitboxes[? next]
    var top = tmp[0]
    var bottom = tmp[1]
    var n = len(next)

    var offset_r = (3 - (n - top - bottom)) / 2 - top          + 1
    var offset_c = (room_width / 64 - cols - n) / 2            + cols + 0.125

    var at = 0
    for (var r=0; r<n; r++) {
        for (var c=0; c<n; c++) {
            if get(next, r, c) == 1 {
                var rr = r + offset_r
                var cc = c + offset_c
                var tile = next_tiles[at]
                move_sprite_to(tile, rr, cc)
                at++
            }
        }
    }
}