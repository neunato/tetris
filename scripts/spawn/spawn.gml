/// @param delay = 0
var delay = argument_count > 0 ? argument[0] : 0;

if delay > 0 {
    with o_game {
        timer_spawn = delay
    }
    return
}

var tetrominoes = o_game.tetrominoes
var cols = o_game.cols

with o_player {
    // get random tetromino
    var r = irandom(len(tetrominoes) - 1)
    var tmp = tetrominoes[r]
    var colour_index = tmp[0]
    rotations = tmp[1]
    rotations_at = 0
    tetromino = rotations[0]

    // centre it
    var n = len(tetromino)
    var offset = 0
    for (var r=0; r<n; r++) {
        var c = 0
        while (c < n and get(tetromino, r, c) == 0) {
            c++
        }
        if c == n {
            offset++
        }
        else {
            break
        }
    }

    position[0] = -offset
    position[1] = floor((cols - n) / 2)

    // create tiles
    var colour = choose(c_aqua, c_fuchsia, c_dkgray, c_olive)
    tiles = array_create(4)
    for (var i=0; i<4; i++) {
        var tile = instance_create_layer(0, 0, "Instances", o_tile)
        tiles[i] = tile
        tile.colour_index = colour_index
    }

    if collides(tetromino, position) {
        defeat()
    }

    redraw_player()
}
