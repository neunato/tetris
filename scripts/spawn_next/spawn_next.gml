
with o_game {
    // get random tetromino
    var r = irandom(len(tetrominoes) - 1)
    var tmp = tetrominoes[r]
    var tile_type = tmp[0]
    next_rotations = tmp[1]

    // create tiles
    next_tiles = array_create(4)
    for (var i=0; i<4; i++) {
        var tile = instance_create(o_tile, 0, 0)
        tile.tile_type = tile_type
        next_tiles[i] = tile
    }
}