/// @param cleared
var cleared = argument0;

if len(cleared) == 0 {
    return
}

with o_game {
    var at = len(cleared) - 1
    var offset = 0
    for (var r=cleared[at]; r>=0; r--) {
        // row cleared - destroy tiles and increase offset for moving rows
        if cleared[at] == r {
            for (var c=0; c<cols; c++) {
                var tile = get(map, r, c)
                instance_destroy(tile)
            }
            offset++
            if at > 0 {
                at--
            }
        }
        // row not cleared - move down by the amount of cleared rows
        else {
            var rr = r + offset
            map[rr] = map[r]
            redraw_row(rr)
        }
    }

    // replace cleared rows by adding new on top
    for (var r=0; r<offset; r++) {
        map[r] = array_create(cols, noone)
    }

    timer_clear = delay_clear
}