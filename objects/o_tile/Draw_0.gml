// o_tile contains three subsprites:
// 1. colour template,
// 2. pattern for "white" blocks,
// 3. pattern for other blocks
var offset
var white
var colour
var type = tile_type

with o_game {
    var tmp = colours[level % len(colours)]
    white = tmp[1]

    if type == 1 {
        offset = 1
        colour = tmp[3]
    }
    else if type == 2 {
        offset = 2
        colour = tmp[2]
    }
    else if type == 3 {
        offset = 2
        colour = tmp[3]
    }
    else {
        return
    }
}

draw_sprite_part_ext(sprite_index, image_index, 0, 0, sprite_height, sprite_height, x, y, 1, 1, colour, 1)
draw_sprite_part_ext(sprite_index, image_index, offset * sprite_height, 0, sprite_height, sprite_height, x, y, 1, 1, white, 1)