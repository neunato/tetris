/// @param level = global.menu_level
var level = argument_count > 0 ? argument[0] : global.menu_level;

global.level = level
global.lines = 0
global.lines_in_level = min(level+1, max(10, level-5)) * 10
global.points = 0
global.playing = true

with o_game {
    delay_gravity = get_level_gravity()
    timer_gravity = delay_gravity
    timer_freeze = delay_freeze

    // not the first game we're starting, reset values
    if tetromino != undefined {
        for (var r=0; r<rows; r++) {
            var row = map[r]
            for (var c=0; c<cols; c++) {
                instance_destroy(row[c])
                row[@c] = noone
            }
        }
        
        for (var i=0; i<4; i++) {
            instance_destroy(player_tiles[i])
            instance_destroy(next_tiles[i])
        }
        
        player_rotations = []
        player_tiles = []
        next_rotations = []
        next_tiles = []
        tetromino = undefined
    }
}

spawn(0)