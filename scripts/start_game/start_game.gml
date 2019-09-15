/// @param level = global.menu_level
var level = argument_count > 0 ? argument[0] : global.menu_level;

global.level = level
global.lines = 0
global.lines_in_level = min(level+1, max(10, level-5)) * 10
global.points = 0
global.playing = true

with o_game {
    // destroy tiles
    instance_destroy(o_tile)
    
    // destroy map
    for (var r=0; r<rows; r++) {
        var row = map[r]
        for (var c=0; c<cols; c++) {
            row[@c] = noone
        }
    }

    // reset player stuff
    player_rotations = []
    player_tiles = []
    next_rotations = []
    next_tiles = []
    tetromino = undefined

    // reset timers
    timer = 0
    timer_freeze = 0
    timer_gravity = 0
    timer_entry = 0
    timer_clear = 0
    timer_end = 0
    timer_shift = 0
    timer_softdrop = 0

    // spawn and delay tetromino
    delay_gravity = get_level_gravity()
    timer_gravity = delay_gravity
    timer_freeze = delay_freeze
    spawn(0)
}