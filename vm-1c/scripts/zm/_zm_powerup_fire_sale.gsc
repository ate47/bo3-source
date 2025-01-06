#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_bgb_machine;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;

#namespace zm_powerup_fire_sale;

// Namespace zm_powerup_fire_sale
// Params 0, eflags: 0x2
// Checksum 0xaca6cfdb, Offset: 0x368
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_fire_sale", &__init__, undefined, undefined);
}

// Namespace zm_powerup_fire_sale
// Params 0, eflags: 0x0
// Checksum 0x9cf0a5d, Offset: 0x3a8
// Size: 0xbc
function __init__() {
    zm_powerups::register_powerup("fire_sale", &grab_fire_sale);
    if (tolower(getdvarstring("g_gametype")) != "zcleansed") {
        zm_powerups::add_zombie_powerup("fire_sale", "p7_zm_power_up_firesale", %ZOMBIE_POWERUP_MAX_AMMO, &func_should_drop_fire_sale, 0, 0, 0, undefined, "powerup_fire_sale", "zombie_powerup_fire_sale_time", "zombie_powerup_fire_sale_on");
    }
}

// Namespace zm_powerup_fire_sale
// Params 1, eflags: 0x0
// Checksum 0x51d6a936, Offset: 0x470
// Size: 0x44
function grab_fire_sale(player) {
    level thread start_fire_sale(self);
    player thread zm_powerups::powerup_vo("firesale");
}

// Namespace zm_powerup_fire_sale
// Params 1, eflags: 0x0
// Checksum 0x56b6050, Offset: 0x4c0
// Size: 0x206
function start_fire_sale(item) {
    if (isdefined(level.custom_firesale_box_leave) && level.custom_firesale_box_leave) {
        while (firesale_chest_is_leaving()) {
            wait 0.05;
        }
    }
    if (isdefined(level.zombie_vars["zombie_powerup_fire_sale_on"]) && level.zombie_vars["zombie_powerup_fire_sale_time"] > 0 && level.zombie_vars["zombie_powerup_fire_sale_on"]) {
        level.zombie_vars["zombie_powerup_fire_sale_time"] = level.zombie_vars["zombie_powerup_fire_sale_time"] + 30;
        return;
    }
    level notify(#"hash_3b3c2756");
    level endon(#"hash_3b3c2756");
    level thread zm_audio::sndannouncerplayvox("fire_sale");
    level.zombie_vars["zombie_powerup_fire_sale_on"] = 1;
    level.disable_firesale_drop = 1;
    level thread toggle_fire_sale_on();
    level.zombie_vars["zombie_powerup_fire_sale_time"] = 30;
    if (bgb::is_team_enabled("zm_bgb_temporal_gift")) {
        level.zombie_vars["zombie_powerup_fire_sale_time"] = level.zombie_vars["zombie_powerup_fire_sale_time"] + 30;
    }
    while (level.zombie_vars["zombie_powerup_fire_sale_time"] > 0) {
        wait 0.05;
        level.zombie_vars["zombie_powerup_fire_sale_time"] = level.zombie_vars["zombie_powerup_fire_sale_time"] - 0.05;
    }
    level thread check_to_clear_fire_sale();
    level.zombie_vars["zombie_powerup_fire_sale_on"] = 0;
    level notify(#"fire_sale_off");
}

// Namespace zm_powerup_fire_sale
// Params 0, eflags: 0x0
// Checksum 0x1606a2e9, Offset: 0x6d0
// Size: 0x2e
function check_to_clear_fire_sale() {
    while (firesale_chest_is_leaving()) {
        wait 0.05;
    }
    level.disable_firesale_drop = undefined;
}

// Namespace zm_powerup_fire_sale
// Params 0, eflags: 0x0
// Checksum 0xd6f1978, Offset: 0x708
// Size: 0xfa
function firesale_chest_is_leaving() {
    for (i = 0; i < level.chests.size; i++) {
        if (i !== level.chest_index) {
            if (level.chests[i].zbarrier.state === "leaving" || level.chests[i].zbarrier.state === "open" || level.chests[i].zbarrier.state === "close" || level.chests[i].zbarrier.state === "closing") {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_powerup_fire_sale
// Params 0, eflags: 0x0
// Checksum 0x1e45df47, Offset: 0x810
// Size: 0x256
function toggle_fire_sale_on() {
    level endon(#"hash_3b3c2756");
    if (!isdefined(level.zombie_vars["zombie_powerup_fire_sale_on"])) {
        return;
    }
    level thread sndfiresalemusic_start();
    bgb_machine::function_38b2a067();
    for (i = 0; i < level.chests.size; i++) {
        show_firesale_box = level.chests[i] [[ level._zombiemode_check_firesale_loc_valid_func ]]();
        if (show_firesale_box) {
            level.chests[i].zombie_cost = 10;
            if (level.chest_index != i) {
                level.chests[i].was_temp = 1;
                if (isdefined(level.chests[i].hidden) && level.chests[i].hidden) {
                    level.chests[i] thread apply_fire_sale_to_chest();
                }
            }
        }
    }
    level notify(#"fire_sale_on");
    level waittill(#"fire_sale_off");
    waittillframeend();
    level thread sndfiresalemusic_stop();
    bgb_machine::function_3364cc51();
    for (i = 0; i < level.chests.size; i++) {
        show_firesale_box = level.chests[i] [[ level._zombiemode_check_firesale_loc_valid_func ]]();
        if (show_firesale_box) {
            if (level.chest_index != i && isdefined(level.chests[i].was_temp)) {
                level.chests[i].was_temp = undefined;
                level thread remove_temp_chest(i);
            }
            level.chests[i].zombie_cost = level.chests[i].old_cost;
        }
    }
}

// Namespace zm_powerup_fire_sale
// Params 0, eflags: 0x0
// Checksum 0xade849fe, Offset: 0xa70
// Size: 0x94
function apply_fire_sale_to_chest() {
    if (self.zbarrier getzbarrierpiecestate(1) == "closing") {
        while (self.zbarrier getzbarrierpiecestate(1) == "closing") {
            wait 0.1;
        }
        self.zbarrier waittill(#"left");
    }
    wait 0.1;
    self thread zm_magicbox::show_chest();
}

// Namespace zm_powerup_fire_sale
// Params 1, eflags: 0x0
// Checksum 0x3cd4b4a4, Offset: 0xb10
// Size: 0x268
function remove_temp_chest(chest_index) {
    level.chests[chest_index].being_removed = 1;
    while (isdefined(level.chests[chest_index]._box_open) && (isdefined(level.chests[chest_index].chest_user) || level.chests[chest_index]._box_open == 1)) {
        util::wait_network_frame();
    }
    if (level.zombie_vars["zombie_powerup_fire_sale_on"]) {
        level.chests[chest_index].was_temp = 1;
        level.chests[chest_index].zombie_cost = 10;
        level.chests[chest_index].being_removed = 0;
        return;
    }
    for (i = 0; i < chest_index; i++) {
        util::wait_network_frame();
    }
    playfx(level._effect["poltergeist"], level.chests[chest_index].orig_origin);
    level.chests[chest_index].zbarrier playsound("zmb_box_poof_land");
    level.chests[chest_index].zbarrier playsound("zmb_couch_slam");
    util::wait_network_frame();
    if (isdefined(level.custom_firesale_box_leave) && level.custom_firesale_box_leave) {
        level.chests[chest_index] zm_magicbox::hide_chest(1);
    } else {
        level.chests[chest_index] zm_magicbox::hide_chest();
    }
    level.chests[chest_index].being_removed = 0;
}

// Namespace zm_powerup_fire_sale
// Params 0, eflags: 0x0
// Checksum 0xc552f6b, Offset: 0xd80
// Size: 0x4e
function func_should_drop_fire_sale() {
    if (isdefined(level.disable_firesale_drop) && (level.zombie_vars["zombie_powerup_fire_sale_on"] == 1 || level.chest_moves < 1 || level.disable_firesale_drop)) {
        return false;
    }
    return true;
}

// Namespace zm_powerup_fire_sale
// Params 0, eflags: 0x0
// Checksum 0xb3e2265d, Offset: 0xdd8
// Size: 0x14a
function sndfiresalemusic_start() {
    array = level.chests;
    foreach (struct in array) {
        if (!isdefined(struct.sndent)) {
            struct.sndent = spawn("script_origin", struct.origin + (0, 0, 100));
        }
        if (isdefined(level.player_4_vox_override) && level.player_4_vox_override) {
            struct.sndent playloopsound("mus_fire_sale_rich", 1);
            continue;
        }
        struct.sndent playloopsound("mus_fire_sale", 1);
    }
}

// Namespace zm_powerup_fire_sale
// Params 0, eflags: 0x0
// Checksum 0x593f4482, Offset: 0xf30
// Size: 0xc8
function sndfiresalemusic_stop() {
    array = level.chests;
    foreach (struct in array) {
        if (isdefined(struct.sndent)) {
            struct.sndent delete();
            struct.sndent = undefined;
        }
    }
}

