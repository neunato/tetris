/// @param cleared
var cleared = argument0;

var n = ds_list_size(cleared)
if n == 0 {
    return
}

with o_game {
    var at = n - 1
    var offset = 0
    for (var r=cleared[|at]; r>=0; r--) {
        // row cleared - increase offset for moving rows
        if cleared[|at] == r {
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

    // update lines/level/score
    global.lines += offset
    global.lines_in_level -= offset
    if global.lines_in_level <= 0 {
        global.level++
        global.lines_in_level += 10
        delay_gravity = get_level_gravity()
        timer_gravity = get_level_gravity()
    }
    global.points += scoring_table[offset - 1] * (global.level + 1)
}