// line clear delay
if timer_clear > 0 {
    timer_clear--
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
}
else if keyboard_check(vk_down) {
    timer_drop--
    if timer_drop == 0 {
        timer_drop = delay_drop[1]
        drop()
    }
}
