var map = o_game.map
var cols = o_game.cols
var rows = o_game.rows

with o_player {
    var lines = []
    var at = 0
    var n = len(tetromino)
    for (var i=0; i<n; i++) {
        var r = i + position[0]

        // copy tiles to map
        for (var j=0; j<n; j++) {
            var c = j + position[1]
            var tile = get(tetromino, i, j)
            if tile != noone {
                set(map, r, c, tile)
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
                lines[at] = r
                at++
            }   
        }
    }

    tetromino = undefined
    return lines
}