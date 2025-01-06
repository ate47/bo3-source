#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_equip_hacker;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace namespace_bcde73b7;

// Namespace namespace_bcde73b7
// Params 0, eflags: 0x0
// Checksum 0x652e047d, Offset: 0x2b0
// Size: 0x18c
function box_hacks() {
    level flag::wait_till("start_zombie_round_logic");
    boxes = struct::get_array("treasure_chest_use", "targetname");
    for (i = 0; i < boxes.size; i++) {
        box = boxes[i];
        box.box_hacks["respin"] = &function_8dd9f05f;
        box.box_hacks["respin_respin"] = &function_ebd3992d;
        box.box_hacks["summon_box"] = &function_fcdcbf3d;
        box.var_69fde2c9 = 0;
    }
    level.var_3e719d28 = &function_2c13f75d;
    level._zombiemode_custom_box_move_logic = &function_2ee71e1;
    level._zombiemode_check_firesale_loc_valid_func = &function_3ac0f8de;
    level flag::init("override_magicbox_trigger_use");
    function_a464ab90();
}

// Namespace namespace_bcde73b7
// Params 0, eflags: 0x0
// Checksum 0xa557a71d, Offset: 0x448
// Size: 0x90
function function_3ac0f8de() {
    if (isdefined(self.unitrigger_stub)) {
        box = self.unitrigger_stub.trigger_target;
    } else if (isdefined(self.stub)) {
        box = self.stub.trigger_target;
    } else if (isdefined(self.owner)) {
        box = self.owner;
    }
    if (box.var_69fde2c9 >= level.round_number) {
        return false;
    }
    return true;
}

// Namespace namespace_bcde73b7
// Params 0, eflags: 0x0
// Checksum 0x585c6d2d, Offset: 0x4e0
// Size: 0x12e
function function_2ee71e1() {
    var_b85b95d4 = 0;
    for (i = 0; i < level.chests.size; i++) {
        if (level.chests[i].var_69fde2c9 >= level.round_number) {
            var_b85b95d4++;
        }
    }
    if (var_b85b95d4 == 0) {
        zm_magicbox::default_box_move_logic();
        return;
    }
    var_36043aa4 = 0;
    var_e436cb8b = level.chest_index;
    while (!var_36043aa4) {
        level.chest_index++;
        if (var_e436cb8b == level.chest_index) {
            level.chest_index++;
        }
        level.chest_index %= level.chests.size;
        if (level.chests[level.chest_index].var_69fde2c9 < level.round_number) {
            var_36043aa4 = 1;
        }
    }
}

// Namespace namespace_bcde73b7
// Params 1, eflags: 0x0
// Checksum 0x2b0bba81, Offset: 0x618
// Size: 0xac
function function_2c13f75d(chance) {
    boxes = level.chests;
    var_c7a14f87 = chance;
    chance = -1;
    for (i = 0; i < boxes.size; i++) {
        if (i == level.chest_index) {
            continue;
        }
        if (boxes[i].var_69fde2c9 < level.round_number) {
            chance = var_c7a14f87;
            break;
        }
    }
    return chance;
}

// Namespace namespace_bcde73b7
// Params 2, eflags: 0x0
// Checksum 0x7b64e692, Offset: 0x6d0
// Size: 0x34
function function_8dd9f05f(chest, player) {
    self thread function_df3b7399(chest, player);
}

// Namespace namespace_bcde73b7
// Params 2, eflags: 0x0
// Checksum 0xa48e1934, Offset: 0x710
// Size: 0x154
function function_df3b7399(chest, player) {
    var_d804affa = spawnstruct();
    var_d804affa.origin = self.origin + (0, 0, 24);
    var_d804affa.radius = 48;
    var_d804affa.height = 72;
    var_d804affa.script_int = 600;
    var_d804affa.script_float = 1.5;
    var_d804affa.player = player;
    var_d804affa.var_39787651 = 1;
    var_d804affa.chest = chest;
    zm_equip_hacker::function_66764564(var_d804affa, &function_bf34b3e4, &function_b9f3574d);
    self.weapon_model util::waittill_either("death", "kill_respin_think_thread");
    zm_equip_hacker::function_fcbe2f17(var_d804affa);
}

// Namespace namespace_bcde73b7
// Params 1, eflags: 0x0
// Checksum 0x78d59b9b, Offset: 0x870
// Size: 0x1ec
function function_1358747(hacker) {
    if (isdefined(self.chest.zbarrier.weapon_model)) {
        self.chest.zbarrier.weapon_model notify(#"kill_respin_think_thread");
    }
    self.chest.no_fly_away = 1;
    self.chest.zbarrier notify(#"box_hacked_respin");
    level flag::set("override_magicbox_trigger_use");
    zm_utility::play_sound_at_pos("open_chest", self.chest.zbarrier.origin);
    zm_utility::play_sound_at_pos("music_chest", self.chest.zbarrier.origin);
    self.chest.zbarrier thread zm_magicbox::treasure_chest_weapon_spawn(self.chest, hacker, 1);
    self.chest.zbarrier waittill(#"randomization_done");
    self.chest.no_fly_away = undefined;
    if (!level flag::get("moving_chest_now")) {
        self.chest.grab_weapon_hint = 1;
        self.chest.grab_weapon = self.chest.zbarrier.weapon;
        level flag::clear("override_magicbox_trigger_use");
        self.chest thread zm_magicbox::treasure_chest_timeout();
    }
}

// Namespace namespace_bcde73b7
// Params 1, eflags: 0x0
// Checksum 0x9b8e2cc8, Offset: 0xa68
// Size: 0x24
function function_bf34b3e4(hacker) {
    self thread function_1358747(hacker);
}

// Namespace namespace_bcde73b7
// Params 1, eflags: 0x0
// Checksum 0x8c0d3e9, Offset: 0xa98
// Size: 0x40
function function_b9f3574d(player) {
    if (player == self.chest.chest_user && isdefined(self.chest.weapon_out)) {
        return true;
    }
    return false;
}

// Namespace namespace_bcde73b7
// Params 2, eflags: 0x0
// Checksum 0x2bfa7a76, Offset: 0xae0
// Size: 0x34
function function_ebd3992d(chest, player) {
    self thread function_a624f359(chest, player);
}

// Namespace namespace_bcde73b7
// Params 2, eflags: 0x0
// Checksum 0x781a6c5, Offset: 0xb20
// Size: 0x154
function function_a624f359(chest, player) {
    var_d804affa = spawnstruct();
    var_d804affa.origin = self.origin + (0, 0, 24);
    var_d804affa.radius = 48;
    var_d804affa.height = 72;
    var_d804affa.script_int = -950;
    var_d804affa.script_float = 1.5;
    var_d804affa.player = player;
    var_d804affa.var_39787651 = 1;
    var_d804affa.chest = chest;
    zm_equip_hacker::function_66764564(var_d804affa, &function_a7222c18, &function_b9f3574d);
    self.weapon_model util::waittill_either("death", "kill_respin_respin_think_thread");
    zm_equip_hacker::function_fcbe2f17(var_d804affa);
}

// Namespace namespace_bcde73b7
// Params 1, eflags: 0x0
// Checksum 0xb56e1aac, Offset: 0xc80
// Size: 0x1ec
function function_a7222c18(hacker) {
    org = self.chest.zbarrier.origin;
    if (isdefined(self.chest.zbarrier.weapon_model)) {
        self.chest.zbarrier.weapon_model notify(#"kill_respin_respin_think_thread");
        self.chest.zbarrier.weapon_model notify(#"kill_weapon_movement");
        self.chest.zbarrier.weapon_model moveto(org + (0, 0, 40), 0.5);
    }
    if (isdefined(self.chest.zbarrier.weapon_model_dw)) {
        self.chest.zbarrier.weapon_model_dw notify(#"kill_weapon_movement");
        self.chest.zbarrier.weapon_model_dw moveto(org + (0, 0, 40) - (3, 3, 3), 0.5);
    }
    self.chest.zbarrier notify(#"box_hacked_rerespin");
    self.chest.box_rerespun = 1;
    self thread function_71eaab63(self.chest.zbarrier.weapon_model, self.chest.zbarrier.weapon_model_dw);
}

// Namespace namespace_bcde73b7
// Params 2, eflags: 0x0
// Checksum 0xa7fbca3f, Offset: 0xe78
// Size: 0x270
function function_71eaab63(weapon1, weapon2) {
    weapon1 endon(#"death");
    playfxontag(level._effect["powerup_on_solo"], weapon1, "tag_origin");
    playsoundatposition("zmb_spawn_powerup", weapon1.origin);
    weapon1 playloopsound("zmb_spawn_powerup_loop");
    self thread function_4dccfd98(weapon1, weapon2);
    while (isdefined(weapon1)) {
        waittime = randomfloatrange(2.5, 5);
        yaw = randomint(360);
        if (yaw > 300) {
            yaw = 300;
        } else if (yaw < 60) {
            yaw = 60;
        }
        yaw = weapon1.angles[1] + yaw;
        weapon1 rotateto((-60 + randomint(120), yaw, -45 + randomint(90)), waittime, waittime * 0.5, waittime * 0.5);
        if (isdefined(weapon2)) {
            weapon2 rotateto((-60 + randomint(120), yaw, -45 + randomint(90)), waittime, waittime * 0.5, waittime * 0.5);
        }
        wait randomfloat(waittime - 0.1);
    }
}

// Namespace namespace_bcde73b7
// Params 2, eflags: 0x0
// Checksum 0x1d842d09, Offset: 0x10f0
// Size: 0x164
function function_4dccfd98(weapon1, weapon2) {
    weapon1 endon(#"death");
    wait 15;
    for (i = 0; i < 40; i++) {
        if (i % 2) {
            weapon1 hide();
            if (isdefined(weapon2)) {
                weapon2 hide();
            }
        } else {
            weapon1 show();
            if (isdefined(weapon2)) {
                weapon2 hide();
            }
        }
        if (i < 15) {
            wait 0.5;
            continue;
        }
        if (i < 25) {
            wait 0.25;
            continue;
        }
        wait 0.1;
    }
    self.chest notify(#"trigger", level);
    if (isdefined(weapon1)) {
        weapon1 delete();
    }
    if (isdefined(weapon2)) {
        weapon2 delete();
    }
}

// Namespace namespace_bcde73b7
// Params 0, eflags: 0x0
// Checksum 0xfc9f3c41, Offset: 0x1260
// Size: 0x96
function function_a464ab90() {
    chests = struct::get_array("treasure_chest_use", "targetname");
    for (i = 0; i < chests.size; i++) {
        chest = chests[i];
        chest function_fcdcbf3d(chest.hidden);
    }
}

// Namespace namespace_bcde73b7
// Params 1, eflags: 0x0
// Checksum 0x92091288, Offset: 0x1300
// Size: 0x176
function function_fcdcbf3d(create) {
    if (create) {
        if (isdefined(self.var_7c58c5e1)) {
            zm_equip_hacker::function_fcbe2f17(self.var_7c58c5e1);
            self.var_7c58c5e1 = undefined;
        }
        struct = spawnstruct();
        struct.origin = self.chest_box.origin + (0, 0, 24);
        struct.radius = 48;
        struct.height = 72;
        struct.script_int = 1200;
        struct.script_float = 5;
        struct.var_39787651 = 1;
        struct.chest = self;
        self.var_7c58c5e1 = struct;
        zm_equip_hacker::function_66764564(struct, &summon_box, &function_163fb8bf);
        return;
    }
    if (isdefined(self.var_7c58c5e1)) {
        zm_equip_hacker::function_fcbe2f17(self.var_7c58c5e1);
        self.var_7c58c5e1 = undefined;
    }
}

// Namespace namespace_bcde73b7
// Params 1, eflags: 0x0
// Checksum 0xb9e7d356, Offset: 0x1480
// Size: 0x15c
function function_35ff58ad(hacker) {
    self.chest.var_69fde2c9 = level.round_number + randomintrange(2, 5);
    zm_equip_hacker::function_fcbe2f17(self);
    self.chest thread zm_magicbox::show_chest();
    self.chest notify(#"kill_chest_think");
    self.chest.auto_open = 1;
    self.chest.var_c20f8a07 = 1;
    self.chest.no_fly_away = 1;
    self.chest.forced_user = hacker;
    self.chest thread zm_magicbox::treasure_chest_think();
    self.chest.zbarrier waittill(#"closed");
    self.chest.forced_user = undefined;
    self.chest.auto_open = undefined;
    self.chest.var_c20f8a07 = undefined;
    self.chest.no_fly_away = undefined;
    self.chest thread zm_magicbox::hide_chest();
}

// Namespace namespace_bcde73b7
// Params 1, eflags: 0x0
// Checksum 0x5d81b593, Offset: 0x15e8
// Size: 0x54
function summon_box(hacker) {
    self thread function_35ff58ad(hacker);
    if (isdefined(hacker)) {
        hacker thread zm_audio::create_and_play_dialog("general", "hack_box");
    }
}

// Namespace namespace_bcde73b7
// Params 1, eflags: 0x0
// Checksum 0x71eb61ef, Offset: 0x1648
// Size: 0x6a
function function_163fb8bf(player) {
    if (self.chest.var_69fde2c9 > level.round_number) {
        return false;
    }
    if (isdefined(self.chest.zbarrier.chest_moving) && self.chest.zbarrier.chest_moving) {
        return false;
    }
    return true;
}

