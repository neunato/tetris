if global.menu.open {
    return
}

// closed menu and not playing - game ended
if not global.playing {
    var key_enter = keyboard_check_pressed(vk_enter)
    var key_escape = keyboard_check_pressed(vk_escape)
    if key_enter {
        instance_destroy(o_curtain)
        start_game()
    }
    else if key_escape {
        instance_destroy(o_curtain)
        menu_open(global.menu)
    }
    return
}

// generic delay
if timer > 0 {
    timer--
    return
}

// end game curtain animation
if timer_end > 0 {
    timer_end--
    if timer_end % 4 == 0 {                    // every four frames the curtain advances
        o_curtain.length++
    }
    if timer_end == 0 {
        global.playing = false
    }
    return
}

// closed menu and playing - open menu on escape
var key_escape = keyboard_check_pressed(vk_escape)
if key_escape {
    menu_open(global.menu)
    return
}

// line clear animation
layer_background_blend(background, c_black)
if timer_clear > 0 {
    timer_clear--
    if timer_clear % 4 == 0 {                  // every four frames two tiles are removed
        var c = timer_clear div 4              // step of the animation
        var n = ds_list_size(cleared_rows)
        for (var i=0; i<n; i++) {
            var r = cleared_rows[|i]
            instance_destroy(get(map, r, c))
            instance_destroy(get(map, r, (cols - 1 - c)))
        }
        if c == 0 {
            clear(cleared_rows)
            spawn(delay_entry)
        }
        if n == 4 {
            layer_background_blend(background, c_white)
        }
    }
    return
}

// tetromino entry delay
if timer_entry > 0 {
    timer_entry--
    if timer_entry == 0 {
        spawn()
    }
    return
}


var left_held  = keyboard_check(global.key_left)
var right_held = keyboard_check(global.key_right)
var down_held  = keyboard_check(global.key_down)
var left       = keyboard_check_pressed(global.key_left)
var right      = keyboard_check_pressed(global.key_right)
var down       = keyboard_check_pressed(global.key_down)
var a          = keyboard_check_pressed(global.key_rotate_left)
var b          = keyboard_check_pressed(global.key_rotate_right)


// SHIFT
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


// ROTATE
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
