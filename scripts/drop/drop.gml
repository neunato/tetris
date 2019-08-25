var map = o_game.map
var cols = o_game.cols
var rows = o_game.rows
var cleared = o_game.cleared_rows

with o_game {
    timer_gravity = delay_gravity
}

with o_player {
    // no collision - drop tetromino
    var pos = [position[0] + 1, position[1]]
    if not collides(tetromino, pos) {
        position = pos
        redraw_player()
        return
    }

    // collision - lock tetromino and track cleared lines
    ds_list_clear(cleared)
    var tiles_at = 0
    var n = len(tetromino)
    for (var i=0; i<n; i++) {
        var r = i + position[0]

        // copy row of tetromino to map
        for (var j=0; j<n; j++) {
            var c = j + position[1]
            if get(tetromino, i, j) == 1 {
                var tile = tiles[tiles_at]
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
                ds_list_add(cleared, r)
            }   
        }
    }

    // spawn the next piece or trigger line clear animation (which ultimately spawns the next piece)
    with o_game {
        if not ds_list_empty(cleared) {
            timer_clear = delay_clear
        }
        else {
            spawn(delay_spawn)
        }
        stop_softdropping = true
    }
}