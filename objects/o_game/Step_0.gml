// line clear animation
var layer_id = layer_get_id("Background")
var background_id = layer_background_get_id(layer_id)
layer_background_blend(background_id, c_black)

if timer_clear > 0 {
    timer_clear--
    if timer_clear % 4 == 0 {
        var c = timer_clear div 4
        var n = len(cleared_lines)
        for (var i=0; i<n; i++) {
            var r = cleared_lines[i]
            instance_destroy(get(map, r, c))
            instance_destroy(get(map, r, (cols - 1 - c)))
        }
        if c == 0 {
            clear(cleared_lines)
            spawn(delay_spawn)
        }
        if n == 4 {
            layer_background_blend(background_id, c_white)
        }
    }
    return
}

// tetromino entry delay
if timer_spawn > 0 {
    timer_spawn--
    if timer_spawn == 0 {
        spawn()
    }
    return
}


var left = pressed(vk_left)
var left_held = held(vk_left)
var right = pressed(vk_right)
var right_held = held(vk_right)
var down = pressed(vk_down)
var down_held = held(vk_down)
var a = pressed(ord("A"))
var b = pressed(ord("D"))

// SHIFTING
// not allowed when down is pressed
// not allowed when both left and right are pressed
if not down_held and (left_held xor right_held) {
    if left {
        timer_shift = delay_shift[0]
        shift(-1)
    }
    else if left_held {
        timer_shift--
        if timer_shift == 0 {
            timer_shift = delay_shift[1]
            shift(-1)
        }
    }
    else if right {
        timer_shift = delay_shift[0]
        shift(1)
    }
    else if right_held {
        timer_shift--
        if timer_shift == 0 {
            timer_shift = delay_shift[1]
            shift(1)
        }
    }
}


// ROTATING
if a {
    rotate(-1)
}
else if b {
    rotate(1)
}


// GRAVITY DROP
// does not stack with soft drop
if timer_freeze > 0 {
    timer_freeze--
    if timer_freeze == 0 {
        drop()
        return
    }
}
else {
    timer_gravity--
    if timer_gravity == 0 {
        drop()
        return
    }
}


// SOFT DROP
// not allowed when left or right is pressed
if not (left_held xor right_held) {
    if down {
        timer_softdrop = delay_softdrop[0]
        timer_freeze = 0
        stop_softdropping = false
    }
    else if down_held and not stop_softdropping {
        timer_softdrop--
        if timer_softdrop == 0 {
            timer_softdrop = delay_softdrop[1]
            drop()
        }
    }
}
