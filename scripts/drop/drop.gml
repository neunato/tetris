
with o_game {
    timer_gravity = delay_gravity

    // no collision - drop tetromino
    var position = [player_position[0] + 1, player_position[1]]
    if not collides(tetromino, position) {
        player_position = position
        redraw_player()
        return
    }

    // collision - lock tetromino and track cleared lines
    ds_list_clear(cleared_rows)
    var tiles_at = 0
    var n = len(tetromino)
    for (var i=0; i<n; i++) {
        var r = i + player_position[0]

        // copy row of tetromino to map
        for (var j=0; j<n; j++) {
            var c = j + player_position[1]
            if get(tetromino, i, j) == 1 {
                var tile = player_tiles[tiles_at]
                set(map, r, c, tile)
                tiles_at++
            }
        }

        // check if row got cleared
        if r >= 0 and r < rows {
             for (var c=0; c<cols; c++) {
                if get(map, r, c) == noone {
                    break
                }
            }
            if c == cols {
                ds_list_add(cleared_rows, r)
            }   
        }
    }


    // spawn the next piece or trigger line clear animation (which ultimately spawns the next piece)
    var tmp = tetromino_hitboxes[? tetromino]
    var r = player_position[0] + len(tetromino) - 1 - tmp[1]   // row (lowest) tetromino was locked in
    with o_game {
        stop_softdropping = true
        delay_entry = delay_entry_table[r]
        if not ds_list_empty(cleared_rows) {
            timer_clear = delay_clear
        }
        else {
            spawn(delay_entry)
        }
    }
}