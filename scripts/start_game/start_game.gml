/// @param level = global.menu_level
var level = argument_count > 0 ? argument[0] : global.menu_level;

if global.playing {
    end_game()
}

global.level = level
global.lines = 0
global.lines_in_level = min(level+1, max(10, level-5)) * 10
global.points = 9999999
global.playing = true
o_game.delay_gravity = level_gravity
o_game.timer_gravity = level_gravity
o_game.timer_freeze = o_game.delay_freeze

spawn(0)