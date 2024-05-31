#using scripts/zm/_zm_net;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/callbacks_shared;

#namespace namespace_5daad52;

// Namespace namespace_5daad52
// Params 0, eflags: 0x1 linked
// namespace_5daad52<file_0>::function_2a476331
// Checksum 0x43a16d54, Offset: 0x1d0
// Size: 0xf4
function function_2a476331() {
    util::registerclientsys("box_indicator");
    level._box_indicator_no_lights = -1;
    level._box_indicator_flash_lights_moving = 99;
    level.var_21469639 = 98;
    level.var_bea700d2 = array("start_chest", "foyer_chest", "crematorium_chest", "alleyway_chest", "control_chest", "stage_chest", "dressing_chest", "dining_chest", "theater_chest");
    level thread magic_box_update();
    level thread function_87812219();
    callback::on_connect(&function_72feb26b);
}

// Namespace namespace_5daad52
// Params 0, eflags: 0x1 linked
// namespace_5daad52<file_0>::function_72feb26b
// Checksum 0x28e6571a, Offset: 0x2d0
// Size: 0x5c
function function_72feb26b() {
    if (level flag::get("power_on")) {
        util::setclientsysstate("box_indicator", get_location_from_chest_index(level.chest_index));
    }
}

// Namespace namespace_5daad52
// Params 1, eflags: 0x1 linked
// namespace_5daad52<file_0>::function_c95e41a1
// Checksum 0xbe7d5bf1, Offset: 0x338
// Size: 0x9c
function get_location_from_chest_index(chest_index) {
    chest_loc = level.chests[chest_index].script_noteworthy;
    for (i = 0; i < level.var_bea700d2.size; i++) {
        if (level.var_bea700d2[i] == chest_loc) {
            return i;
        }
    }
    assertmsg("foyer_chest" + chest_loc);
}

// Namespace namespace_5daad52
// Params 0, eflags: 0x1 linked
// namespace_5daad52<file_0>::function_145aa1f4
// Checksum 0x442c0b2b, Offset: 0x3e0
// Size: 0x160
function magic_box_update() {
    wait(2);
    level flag::wait_till("power_on");
    box_mode = "Box Available";
    util::setclientsysstate("box_indicator", get_location_from_chest_index(level.chest_index));
    while (true) {
        switch (box_mode) {
        case 11:
            if (level flag::get("moving_chest_now")) {
                util::setclientsysstate("box_indicator", level._box_indicator_flash_lights_moving);
                box_mode = "Box is Moving";
            }
            break;
        case 13:
            while (level flag::get("moving_chest_now")) {
                wait(0.1);
            }
            util::setclientsysstate("box_indicator", get_location_from_chest_index(level.chest_index));
            box_mode = "Box Available";
            break;
        }
        wait(0.5);
    }
}

// Namespace namespace_5daad52
// Params 0, eflags: 0x1 linked
// namespace_5daad52<file_0>::function_87812219
// Checksum 0xb5219cb, Offset: 0x548
// Size: 0x98
function function_87812219() {
    while (true) {
        level waittill(#"hash_3b3c2756");
        util::setclientsysstate("box_indicator", level.var_21469639);
        while (level.zombie_vars["zombie_powerup_fire_sale_time"] > 0) {
            wait(0.1);
        }
        util::setclientsysstate("box_indicator", get_location_from_chest_index(level.chest_index));
    }
}

