rows = 15
cols = 10
delay_gravity = 20
delay_automove = [16, 6]
delay_autodown = [3, 2]
delay_spawn = 10
delay_clear = 20
delay_opening = 96

timer_clear = 0                   // frames until active again after line clear
timer_spawn = 0                   // frames until active again before tetromino entry
timer_gravity = delay_gravity     // frames until moving down due to gravity
timer_das = 0                     // frames until moving to the side while holding left/right
timer_drop = 0                    // frames until moving down while holding down

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
