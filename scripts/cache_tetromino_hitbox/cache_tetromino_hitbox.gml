/// @param tetrominoes
var tetrominoes = argument0;

var cache = ds_map_create()

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

    cache[? tetromino] = [empty_top, empty_bottom]
}

return cache