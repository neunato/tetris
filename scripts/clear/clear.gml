/// @param cleared
var cleared = argument0;

if len(cleared) == 0 {
    return
}


with o_game {
    var offset = 0
    for (var r=cleared[0]; r>=0; r--) {
        if contains(cleared, r) {
            offset++
            for (var c=0; c<cols; c++) {
                var tile = get(map, r, c)
                instance_destroy(tile)
            }
        }
        for (var c=0; c<cols; c++) {
            var tile = get(map, r - offset, c)
            set(map, r, c, tile)
            move_sprite_to(tile, r, c)
        }
    }
    
    for (var r=0; r<offset; r++) {
        for (var c=0; c<cols; c++) {
            set(map, r, c, noone)
        }
    }

    timer_clear = delay_clear
}