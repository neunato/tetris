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

// left and right movement
if keyboard_check_pressed(vk_left) {
    timer_shift = delay_shift[0]
    move(-1)
}
else if keyboard_check(vk_left) {
    timer_shift--
    if timer_shift == 0 {
        timer_shift = delay_shift[1]
        move(-1)
    }
}

if keyboard_check_pressed(vk_right) {
    timer_shift = delay_shift[0]
    move(1)
}
else if keyboard_check(vk_right) {
    timer_shift--
    if timer_shift == 0 {
        timer_shift = delay_shift[1]
        move(1)
    }
}

// rotations
if keyboard_check_pressed(ord("A")) {
    rotate(-1)
}
else if keyboard_check_pressed(ord("D")) {
    rotate(1)
}

// down movement (drops don't stack)
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

if keyboard_check_pressed(vk_down) {
    timer_drop = delay_drop[0]
    timer_freeze = 0
    allow_autodrop = true
}
else if keyboard_check(vk_down) and allow_autodrop {
    timer_drop--
    if timer_drop == 0 {
        timer_drop = delay_drop[1]
        drop()
    }
}
