with o_game {
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
        timer_das = delay_automove[0]
        move(-1)
    }
    else if keyboard_check(vk_left) {
        timer_das--
        if timer_das == 0 {
            timer_das = delay_automove[1]
            move(-1)
        }
    }

    if keyboard_check_pressed(vk_right) {
        timer_das = delay_automove[0]
        move(1)
    }
    else if keyboard_check(vk_right) {
        timer_das--
        if timer_das == 0 {
            timer_das = delay_automove[1]
            move(1)
        }
    }

    // down movement
    timer_gravity-- 
    if timer_gravity == 0 {
        timer_gravity = delay_gravity
        drop()
    }
    else if keyboard_check_pressed(vk_down) {
        timer_drop = delay_autodown[0]
    }
    else if keyboard_check(vk_down) {
        timer_drop--
        if timer_drop == 0 {
            timer_drop = delay_autodown[1]
            drop()
        }
    }

    // rotations
    if keyboard_check_pressed(ord("A")) {
        rotate(-1)
    }
    if keyboard_check_pressed(ord("D")) {
        rotate(1)
    }
}