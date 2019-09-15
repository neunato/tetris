gml_pragma("forceinline")

return o_game.delay_gravity_table[min(global.level, len(o_game.delay_gravity_table)-1)]