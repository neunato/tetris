/// @param level
var level = argument0;

global.level = level
global.lines = 0
global.lines_in_level = min(level+1, max(10, level-5)) * 10
global.points = 0
global.paused = false
o_game.delay_gravity = level_gravity
o_game.timer_gravity = level_gravity
o_game.timer_freeze = o_game.delay_freeze
spawn(0)