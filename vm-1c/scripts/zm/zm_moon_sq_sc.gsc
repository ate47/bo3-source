#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/zm_moon_amb;
#using scripts/zm/zm_moon_sq;

#namespace zm_moon_sq_sc;

// Namespace zm_moon_sq_sc
// Params 0, eflags: 0x0
// Checksum 0x3caf7f9d, Offset: 0x4c0
// Size: 0xb4
function init() {
    level.var_69d1c4b0 = [];
    level flag::init("sam_switch_thrown");
    namespace_6e97c459::function_5a90ed82("sq", "sc", &init_stage, &function_7747c56, &function_cc3f3f6a);
    namespace_6e97c459::function_ff87971b("sq", "sc", "sq_knife_switch", &function_30a9619);
}

// Namespace zm_moon_sq_sc
// Params 0, eflags: 0x0
// Checksum 0x4f86963a, Offset: 0x580
// Size: 0x74
function init_2() {
    level flag::init("cvg_placed");
    namespace_6e97c459::function_5a90ed82("sq", "sc2", &function_f57f1713, &function_6163650d, &function_ef31d7b9);
}

// Namespace zm_moon_sq_sc
// Params 0, eflags: 0x0
// Checksum 0xe2f72fd4, Offset: 0x600
// Size: 0x1c
function function_f57f1713() {
    level thread function_8cd1f5d();
}

// Namespace zm_moon_sq_sc
// Params 0, eflags: 0x0
// Checksum 0xf6bfc837, Offset: 0x628
// Size: 0x6c
function function_6163650d() {
    level flag::wait_till("second_tanks_drained");
    level flag::wait_till("soul_swap_done");
    wait 1;
    namespace_6e97c459::function_2f3ced1f("sq", "sc2");
}

// Namespace zm_moon_sq_sc
// Params 1, eflags: 0x0
// Checksum 0xd3065c11, Offset: 0x6a0
// Size: 0xc
function function_ef31d7b9(success) {
    
}

// Namespace zm_moon_sq_sc
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x6b8
// Size: 0x4
function init_stage() {
    
}

// Namespace zm_moon_sq_sc
// Params 0, eflags: 0x0
// Checksum 0x646b5c65, Offset: 0x6c8
// Size: 0x94
function function_ea60feeb() {
    level clientfield::set("sam_end_rumble", 1);
    scene::play("p7_fxanim_zmhd_moon_pyramid_bundle");
    level clientfield::set("sam_init", 1);
    wait 0.1;
    level notify(#"hash_81ef8dff");
    level clientfield::set("sam_end_rumble", 0);
}

// Namespace zm_moon_sq_sc
// Params 0, eflags: 0x0
// Checksum 0x59aa432f, Offset: 0x768
// Size: 0xec
function function_7747c56() {
    level flag::wait_till("first_tanks_drained");
    level thread function_ea60feeb();
    level thread zm_audio::sndmusicsystem_playstate("samantha_reveal");
    level thread function_159f49cd();
    level waittill(#"hash_81ef8dff");
    wait 1;
    players = getplayers();
    array::thread_all(players, &function_7a51bd90);
    namespace_6e97c459::function_2f3ced1f("sq", "sc");
}

// Namespace zm_moon_sq_sc
// Params 0, eflags: 0x0
// Checksum 0xffd46660, Offset: 0x860
// Size: 0xb6
function function_159f49cd() {
    wait 8;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        index = zm_utility::get_player_index(players[i]);
        if (index == 3) {
            players[i] thread zm_audio::create_and_play_dialog("eggs", "quest4", 3);
        }
    }
}

// Namespace zm_moon_sq_sc
// Params 0, eflags: 0x0
// Checksum 0xc6663c2, Offset: 0x920
// Size: 0x9a
function function_7a51bd90() {
    while (self usebuttonpressed() && (!zombie_utility::is_player_valid(self) || self zm_utility::in_revive_trigger())) {
        wait 1;
    }
    level thread zm_powerup_weapon_minigun::minigun_weapon_powerup(self, 90);
    level thread function_34e08484();
    level notify(#"hash_120cf7be");
}

// Namespace zm_moon_sq_sc
// Params 0, eflags: 0x0
// Checksum 0x8fbab29, Offset: 0x9c8
// Size: 0x4c
function function_34e08484() {
    wait 5;
    player = zm_moon_sq::function_9641563a(0);
    if (isdefined(player)) {
        player playsound("vox_plr_0_stupid_gersh");
    }
}

// Namespace zm_moon_sq_sc
// Params 1, eflags: 0x0
// Checksum 0x82cb718f, Offset: 0xa20
// Size: 0xc
function function_cc3f3f6a(success) {
    
}

// Namespace zm_moon_sq_sc
// Params 0, eflags: 0x0
// Checksum 0x719c2f6a, Offset: 0xa38
// Size: 0x104
function function_30a9619() {
    level flag::wait_till("first_tanks_charged");
    var_bf58ee19 = getent("use_tank_switch", "targetname");
    var_bf58ee19 waittill(#"trigger");
    self playsound("zmb_switch_flip_no2d");
    self scene::play("p7_fxanim_zmhd_power_switch_bundle", self);
    playfx(level._effect["switch_sparks"], struct::get("sq_knife_switch_fx", "targetname").origin);
    wait 1;
    level flag::set("sam_switch_thrown");
}

// Namespace zm_moon_sq_sc
// Params 1, eflags: 0x0
// Checksum 0xf8fcb0ca, Offset: 0xb48
// Size: 0x9a
function function_b96682e2(who) {
    zm_moon_amb::function_6acb7f9a();
    if (isdefined(who)) {
        who clientfield::set_to_player("soul_swap", 1);
        who zm_moon_sq::give_perk_reward();
    }
    wait 2;
    if (isdefined(who)) {
        who clientfield::set_to_player("soul_swap", 0);
    }
    level notify(#"hash_452ade48");
}

// Namespace zm_moon_sq_sc
// Params 0, eflags: 0x0
// Checksum 0xd49b392d, Offset: 0xbf0
// Size: 0x46
function function_b86d2843() {
    ent_num = self.characterindex;
    if (isdefined(self.var_62030aa3)) {
        ent_num = self.var_62030aa3;
    }
    if (ent_num == 2) {
        return true;
    }
    return false;
}

// Namespace zm_moon_sq_sc
// Params 0, eflags: 0x0
// Checksum 0xb4be765f, Offset: 0xc40
// Size: 0x1e4
function function_4f187653() {
    level endon(#"hash_274a9362");
    level.var_c502e691 = 1;
    players = getplayers();
    richtofen = undefined;
    for (i = 0; i < players.size; i++) {
        ent_num = players[i].characterindex;
        if (isdefined(players[i].var_62030aa3)) {
            ent_num = players[i].var_62030aa3;
        }
        if (ent_num == 2) {
            richtofen = players[i];
            break;
        }
    }
    if (!isdefined(richtofen)) {
        return;
    }
    richtofen playsoundwithnotify("vox_plr_2_quest_step6_7", "line_spoken");
    richtofen waittill(#"line_spoken");
    targ = struct::get("sq_sam", "targetname");
    targ = struct::get(targ.target, "targetname");
    sound::play_in_space("vox_plr_4_quest_step6_10", targ.origin);
    if (isdefined(richtofen)) {
        richtofen playsoundwithnotify("vox_plr_2_quest_step6_8", "line_spoken");
        richtofen waittill(#"line_spoken");
    }
    level.var_c502e691 = 0;
}

// Namespace zm_moon_sq_sc
// Params 0, eflags: 0x0
// Checksum 0x14b0fad5, Offset: 0xe30
// Size: 0x1a0
function function_8cd1f5d() {
    level flag::wait_till("second_tanks_charged");
    level thread function_4f187653();
    s = struct::get("sq_vg_final", "targetname");
    s thread namespace_6e97c459::function_dd92f786("placed_cvg", &function_b86d2843);
    s waittill(#"placed_cvg", who);
    level flag::set("cvg_placed");
    level clientfield::set("vril_generator", 4);
    who namespace_6e97c459::function_9f2411a3("sq", "cgenerator");
    level flag::wait_till("second_tanks_drained");
    level notify(#"hash_274a9362");
    level thread function_b96682e2(who);
    level flag::set("soul_swap_done");
    level thread function_343f8e54();
    level.var_c502e691 = 0;
}

// Namespace zm_moon_sq_sc
// Params 0, eflags: 0x0
// Checksum 0x403833eb, Offset: 0xfd8
// Size: 0x1e4
function function_343f8e54() {
    wait 1;
    sam = undefined;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        ent_num = players[i].characterindex;
        if (isdefined(players[i].var_62030aa3)) {
            ent_num = players[i].var_62030aa3;
        }
        if (ent_num == 2) {
            sam = players[i];
            break;
        }
    }
    sam playsoundwithnotify("vox_plr_4_quest_step6_12", "linedone");
    sam waittill(#"linedone");
    if (!isdefined(sam)) {
        return;
    }
    players = getplayers();
    player = [];
    for (i = 0; i < players.size; i++) {
        if (players[i] != sam) {
            player[player.size] = players[i];
        }
    }
    if (player.size <= 0) {
        return;
    }
    player[randomintrange(0, player.size)] thread zm_audio::create_and_play_dialog("eggs", "quest6", 13);
}

