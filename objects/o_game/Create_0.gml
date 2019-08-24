rows = 15
cols = 10

level = 0
lines = 0
lines_in_level = min(level+1, max(10, level-5)) * 10
points = 0
points_table = [40, 100, 300, 1200]   // points_table[len(lines_cleared) - 1] * (level + 1)
stop_softdropping = false
cleared_lines = []

gravity_per_level = [48, 43, 38, 33, 28, 23, 18, 13, 8, 6, 5, 5, 5, 4, 4, 4, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1]
var l = min(level, len(gravity_per_level)-1)
delay_gravity = gravity_per_level[l]
delay_freeze = 96
delay_shift = [16, 6]             // the piece moves immediately, and again every 6 frames after an initial delay of 16
delay_softdrop = [3, 2]           // the piece moves every 2 frames after an initial delay of 3
delay_spawn = 10
delay_clear = 17

timer_freeze = 0                  // frames until gravity starts working (first piece only)
timer_gravity = delay_gravity     // frames until moving down due to gravity
timer_shift = 0                   // frames until moving to the side while holding left/right
timer_softdrop = 0                // frames until moving down while holding down
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
    // [tile_type, rotations] format
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

// nes palette
var palette = [$7C7C7C, $FC0000, $BC0000, $BC2844, $840094, $2000A8, $0010A8, $001488, $003050, $007800, $006800, $005800, $584000, $000000, $000000, $000000, $BCBCBC, $F87800, $F85800, $FC4468, $CC00D8, $5800E4, $0038F8, $105CE4, $007CAC, $00B800, $00A800, $44A800, $888800, $000000, $000000, $000000, $F8F8F8, $FCBC3C, $FC8868, $F87898, $F878F8, $9858F8, $5878F8, $44A0FC, $00B8F8, $18F8B8, $54D858, $98F858, $D8E800, $787878, $000000, $000000, $FCFCFC, $FCE4A4, $F8B8B8, $F8B8D8, $F8B8F8, $C0A4F8, $B0D0F0, $A8E0FC, $78D8F8, $78F8D8, $B8F8B8, $D8F8B8, $FCFC00, $F8D8F8, $000000, $000000]
colours = [
    [$0F, $30, $21, $12],   // [black, white, colour1, colour2] for level 0, 10..
    [$0F, $30, $29, $1A],   // [black, white, colour1, colour2] for level 1, 11..
    [$0F, $30, $24, $14],   // ...
    [$0F, $30, $2A, $12],
    [$0F, $30, $2B, $15],
    [$0F, $30, $22, $2B],
    [$0F, $30, $00, $16],
    [$0F, $30, $05, $13],
    [$0F, $30, $16, $12],
    [$0F, $30, $27, $16]    // [black, white, colour1, colour2] for level 9, 19..
]
var n = len(colours)
for (var i=0; i<n; i++) {
    var hexes = colours[i]
    colours[i] = [
        palette[hexes[0]], 
        palette[hexes[1]],
        palette[hexes[2]],
        palette[hexes[3]]
    ]
}