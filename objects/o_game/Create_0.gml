rows = 15
cols = 10

level = 0
lines = 0
lines_in_level = min(level+1, max(10, level-5)) * 10

gravity_per_level = [48, 43, 38, 33, 28, 23, 18, 13, 8, 6, 5, 5, 5, 4, 4, 4, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1]
var l = min(level, len(gravity_per_level)-1)
delay_gravity = gravity_per_level[l]
delay_freeze = 96
delay_shift = [16, 6]             // the piece moves immediately, and again every 6 frames after an initial delay of 16
delay_drop = [3, 2]               // the piece moves every 2 frames after an initial delay of 3
delay_spawn = 10
delay_clear = 20

timer_freeze = 0                  // frames until gravity starts working (first piece only)
timer_gravity = delay_gravity     // frames until moving down due to gravity
timer_shift = 0                   // frames until moving to the side while holding left/right
timer_drop = 0                    // frames until moving down while holding down
timer_spawn = 0                   // frames until active again before tetromino entry
timer_clear = 0                   // frames until active again after line clear

map = []
for (var i=rows-1; i>=0; i--) {
    var row = []
    for (var j=cols-1; j>=0; j--) {
        row[j] = noone
    }
    map[i] = row
}

tetrominoes = [
    // [colour_index, rotations] format
    [0, [[[1,1],
          [1,1]]]],
    [0, [[[0,0,0],
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
    [2, [[[0,0,0],
          [1,1,0],
          [0,1,1]],
         [[0,0,1],
          [0,1,1],
          [0,1,0]]]],
    [1, [[[0,0,0],
          [0,1,1],
          [1,1,0]],
         [[0,1,0],
          [0,1,1],
          [0,0,1]]]],
    [2, [[[0,0,0],
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
    [1, [[[0,0,0],
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
    [0, [[[0,0,0,0],
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
empty_lines_cache = ds_map_create()
var n = len(tetrominoes)
var tmp
for (var i=0; i<n; i++) {
    tmp = tetrominoes[i]
    tmp = tmp[1]
    var tetromino = tmp[0]

    var empty_top = 0
    var empty_bottom = 0
    var m = len(tetromino)
    for (var r=0; r<m; r++) {
        var c = 0
        while (c < m and get(tetromino, r, c) == 0) {
            c++
        }
        if c == m {
            empty_top++
        }
        else {
            break
        }
    }

    for (var r=m-1; r>=0; r--) {
        var c = 0
        while (c < m and get(tetromino, r, c) == 0) {
            c++
        }
        if c == m {
            empty_bottom++
        }
        else {
            break
        }
    }

    empty_lines_cache[? tetromino] = [empty_top, empty_bottom]
}
