global.paused = true
global.level = undefined
global.lines = undefined
global.lines_in_level = undefined
global.points = undefined

instance_create(o_game)
instance_create(o_player)
instance_create(o_controls)

start(0)