#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_136a0c13;

// Namespace namespace_136a0c13
// Params 0, eflags: 0x1 linked
// Checksum 0xb4e22bc9, Offset: 0x220
// Size: 0xe4
function function_2a476331() {
    util::registerclientsys("box_indicator");
    level.var_89cc7a20 = "n";
    level.var_8f49e1f3 = "f";
    level.var_bea700d2 = array("start_chest", "chest1", "chest2", "base_entry_chest", "storage_area_chest", "chest5", "chest6", "warehouse_lander_chest");
    level thread magic_box_update();
    level thread function_dc03417c();
    setdvar("zombiemode_path_minz_bias", 28);
}

// Namespace namespace_136a0c13
// Params 1, eflags: 0x1 linked
// Checksum 0xa18d0f9a, Offset: 0x310
// Size: 0xb4
function get_location_from_chest_index(chest_index) {
    if (isdefined(level.chests[chest_index])) {
        chest_loc = level.chests[chest_index].script_noteworthy;
        for (i = 0; i < level.var_bea700d2.size; i++) {
            if (level.var_bea700d2[i] == chest_loc) {
                return i;
            }
        }
    }
    assertmsg("chest2" + chest_index);
}

// Namespace namespace_136a0c13
// Params 0, eflags: 0x1 linked
// Checksum 0x26ee666, Offset: 0x3d0
// Size: 0x2c4
function magic_box_update() {
    wait(2);
    util::setclientsysstate("box_indicator", level.var_89cc7a20);
    box_mode = "no_power";
    while (true) {
        if ((!level flag::get("power_on") || level flag::get("moving_chest_now")) && level.zombie_vars["zombie_powerup_fire_sale_on"] == 0) {
            box_mode = "no_power";
        } else if (isdefined(level.zombie_vars["zombie_powerup_fire_sale_on"]) && level.zombie_vars["zombie_powerup_fire_sale_on"] == 1) {
            box_mode = "fire_sale";
        } else {
            box_mode = "box_available";
        }
        switch (box_mode) {
        case 12:
            util::setclientsysstate("box_indicator", level.var_89cc7a20);
            while (!level flag::get("power_on") && level.zombie_vars["zombie_powerup_fire_sale_on"] == 0) {
                wait(0.1);
            }
            break;
        case 16:
            util::setclientsysstate("box_indicator", level.var_8f49e1f3);
            while (level.zombie_vars["zombie_powerup_fire_sale_on"] == 1) {
                wait(0.1);
            }
            break;
        case 17:
            util::setclientsysstate("box_indicator", get_location_from_chest_index(level.chest_index));
            while (!level flag::get("moving_chest_now") && level.zombie_vars["zombie_powerup_fire_sale_on"] == 0 && !level flag::get("launch_activated")) {
                wait(0.1);
            }
            break;
        default:
            util::setclientsysstate("box_indicator", level.var_89cc7a20);
            break;
        }
        wait(1);
    }
}

// Namespace namespace_136a0c13
// Params 0, eflags: 0x1 linked
// Checksum 0x5d5a895c, Offset: 0x6a0
// Size: 0x15c
function function_dc03417c() {
    var_a80cddab = struct::get_array("player_respawn_point", "targetname");
    for (i = 0; i < var_a80cddab.size; i++) {
        if (var_a80cddab[i].script_noteworthy == "storage_lander_zone") {
            var_c17a112a = struct::get_array(var_a80cddab[i].target, "targetname");
            for (j = 0; j < var_c17a112a.size; j++) {
                if (isdefined(var_c17a112a[j].script_int) && var_c17a112a[j].script_int == 1 && var_c17a112a[j].origin[0] == -159.5) {
                    var_c17a112a[j].origin = (-159.5, -1292.7, -119);
                }
            }
        }
    }
}

