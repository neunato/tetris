with o_game {
    for (var r=0; r<rows; r++) {
        var row = map[r]
        for (var c=0; c<cols; c++) {
            instance_destroy(row[c])
            row[@c] = noone
        }
    }

    for (var i=0; i<4; i++) {
        instance_destroy(player_tiles[i])
        instance_destroy(next_tiles[i])
    }

    player_rotations = []
    player_tiles = []
    next_rotations = []
    next_tiles = []
    tetromino = undefined
}

global.playing = false