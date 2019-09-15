with o_game {
    var tile_width = sprite_get_height(s_tile)
    var next = next_rotations[0]
    var n = len(next)
    var tmp = tetromino_hitboxes[? next]
    var top = tmp[0]
    var bottom = tmp[1]
    var left = tmp[2]
    var right = tmp[3]
    var height = n - top - bottom
    var width = n - left - right
    var offset_r = 62 / tile_width + (4 - height) / 2 - top - 1
    var offset_c = cols + 1.125 + (4 - width) / 2

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