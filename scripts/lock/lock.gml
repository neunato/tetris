var map = o_game.map
var cols = o_game.cols
var rows = o_game.rows

with o_player {
    var lines = []
    var lines_at = 0
    var tiles_at = 0
    var n = len(tetromino)
    for (var i=0; i<n; i++) {
        var r = i + position[0]

        // copy row to map
        for (var j=0; j<n; j++) {
            var c = j + position[1]
            if get(tetromino, i, j) == 1 {
                var tile = tiles[tiles_at]
                set(map, r, c, tile)
                tiles_at++
            }
        }

        // check if row got cleared
        if r >= 0 and r < rows {
             for (var c=0; c<cols; c++) {
                if get(map, r, c) == noone {
                    break
                }
            }
            if c == cols {
                lines[lines_at] = r
                lines_at++
            }   
        }
    }
    return lines
}