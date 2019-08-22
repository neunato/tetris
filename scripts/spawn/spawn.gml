/// @param delay = 0
var delay = argument_count > 0 ? argument[0] : 0;

if delay > 0 {
    with o_game {
        timer_spawn = delay
    }
    return
}

var shapes = o_game.shapes
var cols = o_game.cols

with o_player {
    // get random tetromino
    var r = irandom(len(shapes) - 1)
    var shape = shapes[r]
    var n = len(shape) - 1

    // centre it
    var offset = 0
    for (var r=0; r<=n; r++) {
        var c = n
        while c >= 0 and get(shape, r, c) == 0 {
            c--
        }
        if c == -1 {
            offset++
        }
        else {
            break
        }
    }

    position[0] = -offset
    position[1] = floor((cols - n) / 2)

    // create tiles
    tetromino = array_create(n + 1)
    var colour = choose(c_aqua, c_fuchsia, c_dkgray, c_olive)
    for (var r=n; r>=0; r--) {
        tetromino[r] = array_create(n + 1)
        for (var c=n; c>=0; c--) {
            if get(shape, r, c) == 1 {
                var xx = position[1] * sprite_width
                var yy = position[0] * sprite_height
                var tile = instance_create_layer(xx, yy, "Instances", o_tile)
                tile.image_blend = colour
                set(tetromino, r, c, tile)
            }
            else {
                set(tetromino, r, c, noone)
            }
        }
    }

    if collides(tetromino, position) {
        defeat()
    }

    redraw_player()
}
