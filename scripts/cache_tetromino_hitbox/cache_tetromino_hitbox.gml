/// @param tetrominoes
var tetrominoes = argument0;

var cache = ds_map_create()

var n = len(tetrominoes)
for (var i=0; i<n; i++) {
    var rotations = tetrominoes[i]
    rotations = rotations[1]
    var m = len(rotations)
    for (var j=0; j<m; j++) {
        var tetromino = rotations[j]
        var empty_top = 0
        var empty_bottom = 0
        var l = len(tetromino)
        for (var r=0; r<l; r++) {
            var c = 0
            while (c < l and get(tetromino, r, c) == 0) {
                c++
            }
            if c == l {
                empty_top++
            }
            else {
                break
            }
        }
        for (var r=l-1; r>=0; r--) {
            var c = 0
            while (c < l and get(tetromino, r, c) == 0) {
                c++
            }
            if c == l {
                empty_bottom++
            }
            else {
                break
            }
        }
    
        cache[? tetromino] = [empty_top, empty_bottom]
    }
}

return cache