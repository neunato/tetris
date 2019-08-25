// game grid
rows = 15
cols = 10
map = []
for (var i=rows-1; i>=0; i--) {
    map[i] = array_create(cols, noone)
}

// gravity per level, exceeding levels use last entry
gravity_table = [48, 43, 38, 33, 28, 23, 18, 13, 8, 6, 5, 5, 5, 4, 4, 4, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1]

// line clear points multipliers: points_table[len(lines_cleared)-1] * (global.level+1)
points_table = [40, 100, 300, 1200]

// tetrominoes stored as [tile_type, rotations]
tetrominoes = [
    [1, [[[1,1],
          [1,1]]]],
    [1, [[[0,0,0],
          [1,1,1],
          [0,1,0]],
         [[0,1,0],
          [1,1,0],
          [0,1,0]],
         [[0,1,0],
          [1,1,1],
          [0,0,0]],
         [[0,1,0],
          [0,1,1],
          [0,1,0]]]],
    [3, [[[0,0,0],
          [1,1,0],
          [0,1,1]],
         [[0,0,1],
          [0,1,1],
          [0,1,0]]]],
    [2, [[[0,0,0],
          [0,1,1],
          [1,1,0]],
         [[0,1,0],
          [0,1,1],
          [0,0,1]]]],
    [3, [[[0,0,0],
          [1,1,1],
          [1,0,0]],
         [[1,1,0],
          [0,1,0],
          [0,1,0]],
         [[0,0,1],
          [1,1,1],
          [0,0,0]],
          [[0,1,0],
          [0,1,0],
          [0,1,1]]]],
    [2, [[[0,0,0],
          [1,1,1],
          [0,0,1]],
         [[0,1,0],
          [0,1,0],
          [1,1,0]],
         [[1,0,0],
          [1,1,1],
          [0,0,0]],
         [[0,1,1],
          [0,1,0],
          [0,1,0]]]],
    [1, [[[0,0,0,0],
          [0,0,0,0],
          [1,1,1,1],
          [0,0,0,0]],
         [[0,0,1,0],
          [0,0,1,0],
          [0,0,1,0],
          [0,0,1,0]]]]
]

// the initial rotation's empty lines (on top and bottom) are checked for when
// spawning and drawing the next piece, so we cache the computation
tetromino_hitboxes = cache_tetromino_hitbox(tetrominoes)

// colours per level stored as [black, white, colour1, colour2]
colours = [
    [$fcfcfc, $fcbc3c, $f85800],   // level 0, 10, 20..
    [$fcfcfc, $18f8b8, $00a800],   // level 1, 11, 21..
    [$fcfcfc, $f878f8, $cc00d8],
    [$fcfcfc, $54d858, $f85800],
    [$fcfcfc, $98f858, $5800e4],
    [$fcfcfc, $fc8868, $98f858],
    [$fcfcfc, $7c7c7c, $0038f8],
    [$fcfcfc, $2000a8, $fc4468],
    [$fcfcfc, $0038f8, $f85800],
    [$fcfcfc, $44a0fc, $0038f8]
]

// game mechanics frame durations and the countdown timers used to track them
delay_gravity = undefined         // depends on level, assigned on game start and level ups
delay_freeze = 96
delay_shift = [16, 6]             // the piece moves immediately, and again every 6 frames after an initial delay of 16
delay_softdrop = [3, 2]           // the piece moves every 2 frames after an initial delay of 3
delay_spawn = 10
delay_clear = 17

timer_gravity = 0                 // frames until moving down due to gravity
timer_freeze = 0                  // frames until gravity starts working (first piece only)
timer_shift = 0                   // frames until moving to the side while holding left/right
timer_softdrop = 0                // frames until moving down while holding down
timer_spawn = 0                   // frames until active again before tetromino entry
timer_clear = 0                   // frames until active again after line clear

// flag used to prevent autodrop to transfer to the next piece
stop_softdropping = false

// list of lines cleared with last lock, needed for the line clear animation
cleared_rows = ds_list_create()

// background cache
background = layer_background_get_id(layer_get_id("Background"))
