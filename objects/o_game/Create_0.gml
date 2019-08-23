rows = 15
cols = 10
delay_freeze = 96
delay_gravity = 20
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
