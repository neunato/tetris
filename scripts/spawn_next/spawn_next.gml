var tetrominoes = o_game.tetrominoes

with o_player {
    // get random tetromino
    var r = irandom(len(tetrominoes) - 1)
    var tmp = tetrominoes[r]
    var colour_index = tmp[0]
    next_rotations = tmp[1]

    // create tiles
    next_tiles = array_create(4)
    for (var i=0; i<4; i++) {
        var tile = instance_create_layer(0, 0, "Instances", o_tile)
        tile.colour_index = colour_index
        next_tiles[i] = tile
    }
}