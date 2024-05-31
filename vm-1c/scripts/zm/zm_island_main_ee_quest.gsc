#using scripts/zm/zm_island_bgb;
#using scripts/zm/zm_island_vo;
#using scripts/zm/zm_island_util;
#using scripts/zm/zm_island_perks;
#using scripts/zm/bgbs/_zm_bgb_pop_shocks;
#using scripts/zm/bgbs/_zm_bgb_anywhere_but_here;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_weap_keeper_skull;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_ai_spiders;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/lui_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace main_quest;

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_d290ebfa
// Checksum 0x88f53e29, Offset: 0x16c8
// Size: 0x124
function main() {
    var_e66037d6 = getent("main_ee_elevator_wall_metal", "targetname");
    var_ed315f0 = getent("main_ee_elevator_wall_decal", "targetname");
    var_e66037d6 clientfield::set("do_fade_material", 1);
    var_ed315f0 clientfield::set("do_fade_material", 0.5);
    level thread function_6e38e085();
    level thread function_8221532d();
    level thread function_9f26e724();
    level thread function_dcc18c22();
    level thread function_7910f0c2();
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_30d4f164
// Checksum 0x696accb0, Offset: 0x17f8
// Size: 0x3c4
function init_quest() {
    register_clientfields();
    level flag::init("player_has_aa_gun_ammo");
    level flag::init("aa_gun_ammo_loaded");
    level flag::init("aa_gun_ee_complete");
    level flag::init("flag_play_outro_cutscene");
    level flag::init("elevator_part_gear1_found");
    level flag::init("elevator_part_gear2_found");
    level flag::init("elevator_part_gear3_found");
    level flag::init("elevator_part_gear1_placed");
    level flag::init("elevator_part_gear2_placed");
    level flag::init("elevator_part_gear3_placed");
    level flag::init("elevator_in_use");
    level flag::init("elevator_at_bottom");
    level flag::init("elevator_cooldown");
    level flag::init("flag_hide_outro_water");
    level flag::init("flag_show_outro_water");
    level flag::init("elevator_door_closed");
    level flag::set("elevator_door_closed");
    level flag::init("prison_vines_cleared");
    if (getdvarint("splitscreen_playerCount") < 3) {
        callback::on_spawned(&function_85773a07);
    }
    callback::on_spawned(&function_aeef1178);
    callback::on_spawned(&function_df4d1d4);
    level thread function_75e5527f();
    function_8099bad0();
    function_5d0980ef();
    function_62dfc4c7();
    function_af46160f();
    level thread function_f818f5b5();
    level thread function_a5968b41();
    level thread function_19cfd507();
    level thread function_e509082();
    /#
        if (getdvarint("elevator_part_gear1_found") > 0) {
            function_12d043ed();
        }
    #/
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_4ece4a2f
// Checksum 0x4d6e9fad, Offset: 0x1bc8
// Size: 0x194
function register_clientfields() {
    clientfield::register("scriptmover", "zipline_lightning_fx", 9000, 1, "int");
    clientfield::register("vehicle", "plane_hit_by_aa_gun", 9000, 1, "int");
    clientfield::register("allplayers", "lightning_shield_fx", 9000, 1, "int");
    clientfield::register("scriptmover", "smoke_trail_fx", 9000, 1, "int");
    clientfield::register("scriptmover", "smoke_smolder_fx", 9000, 1, "int");
    clientfield::register("scriptmover", "perk_lightning_fx", 9000, getminbitcountfornum(6), "int");
    clientfield::register("zbarrier", "bgb_lightning_fx", 9000, 1, "int");
    clientfield::register("world", "umbra_tome_outro_igc", 9000, 1, "int");
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_85773a07
// Checksum 0xeb281450, Offset: 0x1d68
// Size: 0x6c
function function_85773a07() {
    self endon(#"death");
    var_af4d7f99 = getent("mdl_main_ee_map", "targetname");
    self namespace_8aed53c9::function_7448e472(var_af4d7f99);
    level thread function_85b23415();
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_85b23415
// Checksum 0xa854e6e8, Offset: 0x1de0
// Size: 0x8c
function function_85b23415() {
    var_af4d7f99 = getent("mdl_main_ee_map", "targetname");
    var_af4d7f99 clientfield::set("do_fade_material", 1);
    level flag::set("trilogy_released");
    exploder::exploder("lgt_elevator");
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_7910f0c2
// Checksum 0xc4bfbf8c, Offset: 0x1e78
// Size: 0xb6
function function_7910f0c2() {
    level flag::wait_till("trilogy_released");
    level.var_6f17d9e9 = 0;
    for (i = 1; i < 4; i++) {
        var_f34dc519 = getent("takeo_arm_gate" + i, "targetname");
        var_f34dc519 thread function_d9de7eb6(i);
        level.var_6f17d9e9++;
    }
}

// Namespace main_quest
// Params 1, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_d9de7eb6
// Checksum 0xa94bf1fb, Offset: 0x1f38
// Size: 0x468
function function_d9de7eb6(var_a3612ddd) {
    e_clip = getent(self.target, "targetname");
    e_clip setcandamage(1);
    e_clip.health = 10000;
    var_75f5a225 = getent("clip_player_" + var_a3612ddd, "targetname");
    self thread scene::play("p7_fxanim_zm_island_takeo_arm_gate" + var_a3612ddd + "_bundle", self);
    var_2b128827 = 1;
    var_b538c87 = 0;
    while (isdefined(var_2b128827) && var_2b128827) {
        n_damage, e_attacker, v_direction, v_point, str_mod, str_tag_name, str_model_name, var_829b9480, w_weapon = e_clip waittill(#"damage");
        if (w_weapon === level.var_5e75629a) {
            self playrumbleonentity("tank_damage_heavy_mp");
            self scene::play("p7_fxanim_zm_island_takeo_arm_gate" + var_a3612ddd + "_close_bundle", self);
            self thread scene::play("p7_fxanim_zm_island_takeo_arm_gate" + var_a3612ddd + "_bundle", self);
            if (var_a3612ddd == 1 && !var_b538c87) {
                var_b538c87 = 1;
                str_vo = "vox_plr_" + e_attacker.characterindex + "_mq_ee_3_1_0";
                e_attacker thread namespace_f333593c::vo_say(str_vo, 0, 1);
            }
            continue;
        }
        if (w_weapon === level.var_a4052592) {
            self playrumbleonentity("zm_island_rumble_takeo_hall_vine_hit");
            earthquake(0.35, 0.5, self.origin, 325);
            self playsound("zmb_takeo_vox_roar_amrgate");
            self hidepart("eye1_side_jnt");
            wait(1.5);
            self scene::play("p7_fxanim_zm_island_takeo_arm_gate" + var_a3612ddd + "_retract_bundle", self);
            e_clip delete();
            var_75f5a225 delete();
            level.var_6f17d9e9--;
            if (level.var_6f17d9e9 == 0) {
                level notify(#"hash_add73e69");
                level util::delay(2, undefined, &flag::set, "prison_vines_cleared");
                level.var_6f17d9e9 = undefined;
            }
            wait(5);
            struct::function_368120a1("scene", "p7_fxanim_zm_island_takeo_arm_gate" + var_a3612ddd + "_bundle");
            struct::function_368120a1("scene", "p7_fxanim_zm_island_takeo_arm_gate" + var_a3612ddd + "_close_bundle");
            struct::function_368120a1("scene", "p7_fxanim_zm_island_takeo_arm_gate" + var_a3612ddd + "_retract_bundle");
            var_2b128827 = 0;
        }
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_df4d1d4
// Checksum 0xce38367a, Offset: 0x23a8
// Size: 0xd8
function function_df4d1d4() {
    self endon(#"death");
    level endon(#"hash_1f9f4017");
    level flag::wait_till("trilogy_released");
    var_af8f5b69 = getent("trigger_gas_hurt", "targetname");
    while (true) {
        trigger::wait_till("trigger_gas_hurt", "targetname", self);
        if (!self.var_df4182b1 && zm_utility::is_player_valid(self)) {
            self dodamage(5, self.origin);
        }
        wait(0.5);
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_75e5527f
// Checksum 0xbd8bd71, Offset: 0x2488
// Size: 0x1be
function function_75e5527f() {
    level endon(#"hash_5790f552");
    var_af8f5b69 = getent("trigger_gas_chamber", "targetname");
    while (true) {
        var_af8f5b69 waittill(#"trigger");
        var_b2c5aa85 = [];
        foreach (player in level.players) {
            if (player istouching(var_af8f5b69) && !player.var_df4182b1 && zm_utility::is_player_valid(player)) {
                array::add(var_b2c5aa85, player);
            }
        }
        var_9609e73e = array::random(var_b2c5aa85);
        if (isdefined(var_9609e73e)) {
            str_vo = "vox_plr_" + var_9609e73e.characterindex + "_mq_ee_3_0_0";
            var_9609e73e thread namespace_f333593c::vo_say(str_vo, 0, 1);
            level notify(#"hash_5790f552");
        }
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_19cfd507
// Checksum 0x19396796, Offset: 0x2650
// Size: 0x8c
function function_19cfd507() {
    level flag::wait_till("trilogy_released");
    level thread function_d6bb2a6c();
    level.var_2c12d9a6 = &function_2fae2796;
    level flag::wait_till("elevator_part_gear1_found");
    level.var_2c12d9a6 = &namespace_f694d9ca::function_fa778ca4;
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_d6bb2a6c
// Checksum 0xabebb493, Offset: 0x26e8
// Size: 0xc4
function function_d6bb2a6c() {
    s_part = struct::get("elevator_part_gear1");
    mdl_part = util::spawn_model("p7_zm_bgb_gear_01", s_part.origin, s_part.angles);
    mdl_part.trigger = namespace_8aed53c9::function_d095318(mdl_part.origin, 50, 1, &function_9bd3096f);
    mdl_part thread function_d81e5824("elevator_part_gear1_found");
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_2fae2796
// Checksum 0x67ea036, Offset: 0x27b8
// Size: 0xd8
function function_2fae2796() {
    a_s_spot = struct::get_array("ee_gear_teleport_spot", "targetname");
    while (true) {
        foreach (s_spot in a_s_spot) {
            if (!positionwouldtelefrag(s_spot.origin)) {
                return s_spot;
            }
        }
        wait(0.05);
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_8099bad0
// Checksum 0xc2c4f503, Offset: 0x2898
// Size: 0x5c
function function_8099bad0() {
    array::thread_all(getentarray("clip_zipline_zap", "targetname"), &function_5b0b2b3d);
    level thread function_53246bea();
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_5b0b2b3d
// Checksum 0xb9b611e, Offset: 0x2900
// Size: 0x430
function function_5b0b2b3d() {
    level flag::wait_till("all_challenges_completed");
    self setcandamage(1);
    self.health = 100000;
    a_s_loc = struct::get_array("transport_zip_line", "targetname");
    while (true) {
        n_damage, e_attacker, v_direction, v_point, str_mod, str_tag_name, str_model_name, var_829b9480, w_weapon = self waittill(#"damage");
        if (isdefined(e_attacker.var_36c3d64a) && w_weapon.name === "island_riotshield" && e_attacker.var_36c3d64a) {
            level flag::set("zipline_lightning_charge");
            e_attacker notify(#"hash_6bef9736");
            self playsound("zmb_lightning_shield_activate");
            foreach (s_loc in a_s_loc) {
                s_loc.var_1cdf0f7a clientfield::set("zipline_lightning_fx", 1);
            }
            exploder::exploder("fxexp_504");
            level util::delay(5, undefined, &exploder::exploder_stop, "fxexp_504");
            if (level flag::get("flag_zipline_in_use")) {
                foreach (player in level.players) {
                    if (isdefined(player.is_ziplining) && player.is_ziplining) {
                        player.var_53539670 notify(#"reached_end_node");
                        break;
                    }
                }
            } else if (level.players.size == 1) {
                level.players[0] thread function_426caba9();
            }
            foreach (s_loc in a_s_loc) {
                s_loc.var_1cdf0f7a util::delay(5, undefined, &clientfield::set, "zipline_lightning_fx", 0);
            }
            wait(5);
            level flag::clear("zipline_lightning_charge");
        }
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_62dfc4c7
// Checksum 0x70f6a3ca, Offset: 0x2d38
// Size: 0x44
function function_62dfc4c7() {
    array::thread_all(getentarray("clip_sewer_panel_zap", "targetname"), &function_e9ec0fdf);
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_e9ec0fdf
// Checksum 0xd08f8357, Offset: 0x2d88
// Size: 0x228
function function_e9ec0fdf() {
    self endon(#"death");
    level flag::wait_till("all_challenges_completed");
    self setcandamage(1);
    self.health = 100000;
    s_loc = struct::get("transport_sewer_" + self.script_noteworthy);
    while (true) {
        n_damage, e_attacker, v_direction, v_point, str_mod, str_tag_name, str_model_name, var_829b9480, w_weapon = self waittill(#"damage");
        if (isdefined(e_attacker.var_36c3d64a) && isdefined(w_weapon.isriotshield) && w_weapon.isriotshield && e_attacker.var_36c3d64a) {
            level flag::set("sewer_lightning_charge_" + self.script_noteworthy);
            e_attacker notify(#"hash_6bef9736");
            self playsound("zmb_lightning_shield_activate");
            s_loc.var_1cdf0f7a clientfield::set("zipline_lightning_fx", 1);
            wait(5);
            s_loc.var_1cdf0f7a clientfield::set("zipline_lightning_fx", 0);
            level flag::clear("sewer_lightning_charge_" + self.script_noteworthy);
        }
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_af46160f
// Checksum 0xbeccf1d1, Offset: 0x2fb8
// Size: 0x8c
function function_af46160f() {
    var_f7d59b95 = getent("clip_cage_control", "targetname");
    var_a398a1e1 = struct::get(var_f7d59b95.target, "targetname");
    var_f7d59b95 thread function_4d23baa6(var_a398a1e1.origin, var_a398a1e1.angles);
}

// Namespace main_quest
// Params 4, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_4d23baa6
// Checksum 0xb714bb70, Offset: 0x3050
// Size: 0x238
function function_4d23baa6(v_origin, v_angles, n_cooldown, var_5588387b) {
    if (!isdefined(n_cooldown)) {
        n_cooldown = 5;
    }
    self endon(#"death");
    self setcandamage(1);
    self.health = 100000;
    while (true) {
        n_damage, e_attacker, v_direction, v_point, str_mod, str_tag_name, str_model_name, var_829b9480, w_weapon = self waittill(#"damage");
        if (isdefined(e_attacker.var_36c3d64a) && isdefined(w_weapon.isriotshield) && w_weapon.isriotshield && e_attacker.var_36c3d64a) {
            self notify(#"charged");
            e_attacker notify(#"hash_6bef9736");
            self playsound("zmb_lightning_shield_activate");
            var_752908f7 = util::spawn_model("tag_origin", v_origin, v_angles);
            var_752908f7 clientfield::set("zipline_lightning_fx", 1);
            if (isdefined(var_5588387b)) {
                var_752908f7 thread [[ var_5588387b ]]();
            }
            wait(n_cooldown);
            var_752908f7 notify(#"hash_48ec464");
            var_752908f7 clientfield::set("zipline_lightning_fx", 0);
            util::wait_network_frame();
            var_752908f7 delete();
        }
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_426caba9
// Checksum 0xfb410d88, Offset: 0x3290
// Size: 0xdc
function function_426caba9() {
    self endon(#"disconnect");
    if (isdefined(5)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(5, "timeout");
    }
    level flag::wait_till("flag_zipline_in_use");
    self waittill(#"zipline_start");
    while (!self meleebuttonpressed()) {
        wait(0.05);
    }
    if (isdefined(self.var_53539670)) {
        self.var_53539670 notify(#"reached_end_node");
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_6e38e085
// Checksum 0xe17eceda, Offset: 0x3378
// Size: 0x128
function function_6e38e085() {
    var_d93f9cb8 = getent("boat_death", "targetname");
    while (true) {
        e_who = var_d93f9cb8 waittill(#"trigger");
        if (isplayer(e_who) && !(isdefined(e_who.var_a98632dd) && e_who.var_a98632dd)) {
            e_who.var_a98632dd = 1;
            e_who thread function_1bbe32e1();
            if (!level flag::get("solo_game")) {
                e_who.no_revive_trigger = 1;
            }
            e_who dodamage(e_who.health + 1000, e_who.origin);
        }
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_1bbe32e1
// Checksum 0xfa1808ec, Offset: 0x34a8
// Size: 0xa6
function function_1bbe32e1() {
    self endon(#"disconnect");
    if (self hasperk("specialty_quickrevive") && level flag::get("solo_game")) {
        self setorigin(self.var_5eb06498);
    }
    self util::waittill_any("player_revived", "spawned");
    self.no_revive_trigger = undefined;
    self.var_a98632dd = undefined;
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_53246bea
// Checksum 0xaf0ea04b, Offset: 0x3558
// Size: 0xe4
function function_53246bea() {
    level flag::wait_till("trilogy_released");
    s_part = struct::get("elevator_part_gear2");
    mdl_part = util::spawn_model("p7_zm_bgb_gear_01", s_part.origin, s_part.angles);
    mdl_part.trigger = namespace_8aed53c9::function_d095318(mdl_part.origin, 50, 1, &function_9bd3096f);
    mdl_part thread function_d81e5824("elevator_part_gear2_found");
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_1f4e6abd
// Checksum 0xe9cc0dcf, Offset: 0x3648
// Size: 0x1c4
function function_1f4e6abd() {
    var_ff4420b1 = util::spawn_model("p7_zm_ctl_ammo_flak_bullet_01", self.origin + (0, 0, 36), self.angles);
    var_ff4420b1 setscale(5);
    var_4f2d91b3 = spawnstruct();
    var_4f2d91b3.origin = var_ff4420b1.origin;
    var_4f2d91b3.angles = var_ff4420b1.angles;
    var_4f2d91b3.e_parent = var_ff4420b1;
    var_4f2d91b3.script_unitrigger_type = "unitrigger_box_use";
    var_4f2d91b3.cursor_hint = "HINT_NOICON";
    var_4f2d91b3.require_look_at = 1;
    var_4f2d91b3.script_width = -128;
    var_4f2d91b3.script_length = -126;
    var_4f2d91b3.script_height = 100;
    var_4f2d91b3.prompt_and_visibility_func = &function_ca475941;
    zm_unitrigger::register_static_unitrigger(var_4f2d91b3, &function_545006a5);
    var_ff4420b1 waittill(#"hash_639abf38");
    var_ff4420b1 delete();
    zm_unitrigger::unregister_unitrigger(var_4f2d91b3);
}

// Namespace main_quest
// Params 1, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_ca475941
// Checksum 0xd32e6b17, Offset: 0x3818
// Size: 0x30
function function_ca475941(player) {
    self sethintstring("");
    return true;
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_545006a5
// Checksum 0x62875409, Offset: 0x3850
// Size: 0xba
function function_545006a5() {
    while (true) {
        e_who = self waittill(#"trigger");
        if (e_who zm_utility::in_revive_trigger()) {
            continue;
        }
        if (e_who.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(e_who)) {
            continue;
        }
        self.stub.e_parent notify(#"hash_639abf38");
        level flag::set("player_has_aa_gun_ammo");
        return;
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_a5968b41
// Checksum 0x1370dfba, Offset: 0x3918
// Size: 0x1c6
function function_a5968b41() {
    level flag::wait_till("trilogy_released");
    level thread function_35340bf6();
    level flag::wait_till("player_has_aa_gun_ammo");
    var_16bdbe0a = struct::get("aa_gun_trigger", "targetname");
    var_16bdbe0a.script_unitrigger_type = "unitrigger_box_use";
    var_16bdbe0a.radius = 64;
    var_16bdbe0a.cursor_hint = "HINT_NOICON";
    var_16bdbe0a.require_look_at = 1;
    while (!level flag::get("aa_gun_ee_complete")) {
        var_16bdbe0a.prompt_and_visibility_func = &function_9c02ad1;
        zm_unitrigger::register_static_unitrigger(var_16bdbe0a, &function_408069b5);
        level waittill(#"hash_e7ebaf47");
        zm_unitrigger::unregister_unitrigger(var_16bdbe0a);
        wait(1);
        var_16bdbe0a.prompt_and_visibility_func = &function_97bdb2f5;
        zm_unitrigger::register_static_unitrigger(var_16bdbe0a, &function_c0946f91);
        level waittill(#"hash_248f6385");
        zm_unitrigger::unregister_unitrigger(var_16bdbe0a);
        wait(1);
    }
}

// Namespace main_quest
// Params 1, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_9c02ad1
// Checksum 0x5ba135db, Offset: 0x3ae8
// Size: 0x98
function function_9c02ad1(player) {
    if (!player zm_utility::is_player_looking_at(self.origin, 0.5, 0) || !level flag::get("player_has_aa_gun_ammo")) {
        self sethintstring("");
        return false;
    }
    self sethintstring("");
    return true;
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_408069b5
// Checksum 0xca37c739, Offset: 0x3b88
// Size: 0x114
function function_408069b5() {
    while (!level flag::get("aa_gun_ammo_loaded")) {
        e_who = self waittill(#"trigger");
        if (e_who zm_utility::in_revive_trigger()) {
            continue;
        }
        if (e_who.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(e_who)) {
            continue;
        }
        if (level flag::get("player_has_aa_gun_ammo")) {
            level flag::set("aa_gun_ammo_loaded");
            level flag::clear("player_has_aa_gun_ammo");
            playsoundatposition("zmb_aa_gun_load", self.origin);
            break;
        }
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_c0946f91
// Checksum 0x7ac2c835, Offset: 0x3ca8
// Size: 0xcc
function function_c0946f91() {
    while (level flag::get("aa_gun_ammo_loaded")) {
        e_who = self waittill(#"trigger");
        if (e_who zm_utility::in_revive_trigger()) {
            continue;
        }
        if (e_who.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(e_who)) {
            continue;
        }
        level thread function_248f6385();
        playsoundatposition("wpn_aa_fire", self.origin);
        break;
    }
}

// Namespace main_quest
// Params 1, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_97bdb2f5
// Checksum 0x5ce16f0b, Offset: 0x3d80
// Size: 0x78
function function_97bdb2f5(player) {
    if (!player zm_utility::is_player_looking_at(self.origin, 0.5, 0)) {
        self sethintstring("");
        return false;
    }
    self sethintstring("");
    return true;
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_248f6385
// Checksum 0xac4b36a3, Offset: 0x3e00
// Size: 0x124
function function_248f6385() {
    level notify(#"hash_248f6385");
    level flag::clear("aa_gun_ammo_loaded");
    var_8cad0c4d = getent("aa_gun", "targetname");
    var_8cad0c4d thread scene::play("p7_fxanim_zm_island_flak_88_bundle", var_8cad0c4d);
    exploder::exploder("fxexp_810");
    var_16bdbe0a = struct::get("aa_gun_trigger", "targetname");
    playrumbleonposition("zm_island_aa_gun_fired", var_16bdbe0a.origin);
    if (level flag::get("ee_gun_plane_in_range")) {
        level flag::set("aa_gun_ee_complete");
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_35340bf6
// Checksum 0xdfaeead8, Offset: 0x3f30
// Size: 0xd8
function function_35340bf6() {
    while (!flag::get("aa_gun_ee_complete")) {
        e_vehicle = vehicle::simple_spawn_single("main_ee_aa_gun_plane");
        e_vehicle setforcenocull();
        e_vehicle thread function_45e9f465();
        e_vehicle thread namespace_c8222934::function_235019b6("main_ee_aa_gun_plane_path");
        e_vehicle waittill(#"reached_end_node");
        e_vehicle clientfield::set("plane_hit_by_aa_gun", 0);
        wait(randomintrange(60, 120));
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_45e9f465
// Checksum 0x330273c9, Offset: 0x4010
// Size: 0x494
function function_45e9f465() {
    self endon(#"reached_end_node");
    level flag::wait_till("aa_gun_ee_complete");
    wait(0.3);
    self clientfield::set("plane_hit_by_aa_gun", 1);
    self playsound("evt_b17_explode");
    var_f7fded02 = struct::get_array("aa_gun_elevator_part_landing", "targetname");
    s_end = array::random(var_f7fded02);
    var_569bb3f4 = spawnstruct();
    var_569bb3f4.origin = self.origin;
    var_569bb3f4.angles = self.angles;
    var_569bb3f4 thread scene::play("p7_fxanim_zm_island_b17_explode_bundle");
    self.delete_on_death = 1;
    self notify(#"death");
    if (!isalive(self)) {
        self delete();
    }
    wait(0.05);
    if (s_end.script_noteworthy == "gear_meteor") {
        nd_path_start = getvehiclenode("meteor_start", "targetname");
    } else if (s_end.script_noteworthy == "gear_bunker") {
        nd_path_start = getvehiclenode("bunker_start", "targetname");
    } else {
        nd_path_start = getvehiclenode("lab_start", "targetname");
    }
    var_6549ae27 = spawner::simple_spawn_single("gear_vehicle");
    mdl_part = util::spawn_model("p7_zm_bgb_gear_01", var_6549ae27.origin, s_end.angles);
    mdl_part linkto(var_6549ae27);
    mdl_part playloopsound("evt_b17_piece_lp");
    util::wait_network_frame();
    mdl_part clientfield::set("smoke_trail_fx", 1);
    var_6549ae27 vehicle::get_on_and_go_path(nd_path_start);
    var_6549ae27 waittill(#"reached_end_node");
    var_6549ae27.delete_on_death = 1;
    var_6549ae27 notify(#"death");
    if (!isalive(var_6549ae27)) {
        var_6549ae27 delete();
    }
    mdl_part moveto(s_end.origin, 0.1);
    mdl_part waittill(#"movedone");
    mdl_part clientfield::set("smoke_trail_fx", 0);
    mdl_part clientfield::set("smoke_smolder_fx", 1);
    mdl_part playsound("evt_b17_piece_impact");
    mdl_part stoploopsound(0.25);
    mdl_part.trigger = namespace_8aed53c9::function_d095318(mdl_part.origin, 50, 1, &function_9bd3096f);
    mdl_part thread function_d81e5824("elevator_part_gear3_found");
    var_569bb3f4 = undefined;
}

// Namespace main_quest
// Params 0, eflags: 0x0
// namespace_b3c23ec9<file_0>::function_4280e890
// Checksum 0xa4e25f63, Offset: 0x44b0
// Size: 0x54
function function_4280e890() {
    level flag::wait_till("ee_gun_plane_in_range");
    wait(0.1);
    level flag::wait_till_clear("ee_gun_plane_in_range");
    wait(0.1);
}

// Namespace main_quest
// Params 1, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_d81e5824
// Checksum 0xa03fbde9, Offset: 0x4510
// Size: 0xc4
function function_d81e5824(str_flag) {
    while (true) {
        player = self.trigger waittill(#"trigger");
        if (zm_utility::is_player_valid(player)) {
            zm_unitrigger::unregister_unitrigger(self.trigger);
            level flag::set(str_flag);
            self.trigger = undefined;
            player playsound("zmb_item_pickup");
            self delete();
            break;
        }
    }
}

// Namespace main_quest
// Params 1, eflags: 0x5 linked
// namespace_b3c23ec9<file_0>::function_9bd3096f
// Checksum 0x9b77b392, Offset: 0x45e0
// Size: 0x12
function private function_9bd3096f(player) {
    return "";
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_5d0980ef
// Checksum 0x1ea23172, Offset: 0x4600
// Size: 0xa4
function function_5d0980ef() {
    var_66bf6df = getent("elevator_gears", "targetname");
    var_66bf6df hidepart("wheel_01_jnt");
    var_66bf6df hidepart("wheel_02_jnt");
    var_66bf6df hidepart("wheel_03_jnt");
    level thread function_a06630fc();
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_aeef1178
// Checksum 0x92c725fb, Offset: 0x46b0
// Size: 0x1da
function function_aeef1178() {
    self endon(#"disconnect");
    self endon(#"hash_51d9edd8");
    level endon(#"hash_b165a75b");
    level flag::wait_till("trilogy_released");
    var_e66037d6 = getent("main_ee_elevator_wall_metal", "targetname");
    var_ed315f0 = getent("main_ee_elevator_wall_decal", "targetname");
    self namespace_8aed53c9::function_7448e472(var_e66037d6);
    callback::remove_on_spawned(&function_aeef1178);
    foreach (player in level.players) {
        if (player !== self) {
            player notify(#"hash_51d9edd8");
        }
    }
    exploder::exploder("fxexp_509");
    level thread namespace_8aed53c9::function_925aa63a(array(var_e66037d6, var_ed315f0), 0.25, 0, 1);
    level thread function_6cc2e374();
    level notify(#"hash_b165a75b");
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_a06630fc
// Checksum 0x89a60a85, Offset: 0x4898
// Size: 0x44
function function_a06630fc() {
    trigger::wait_till("trigger_see_gears");
    array::thread_all(level.players, &function_77f4b1ca);
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_77f4b1ca
// Checksum 0xa23b9e19, Offset: 0x48e8
// Size: 0x12c
function function_77f4b1ca() {
    self endon(#"disconnect");
    self endon(#"hash_87b9e813");
    var_66bf6df = getent("elevator_gears", "targetname");
    self util::waittill_player_looking_at(var_66bf6df.origin);
    foreach (player in level.players) {
        if (player != self) {
            player notify(#"hash_87b9e813");
        }
    }
    if (zm_utility::is_player_valid(self)) {
        self thread namespace_f333593c::function_d258c672("2");
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_6cc2e374
// Checksum 0x4bcdbb2a, Offset: 0x4a20
// Size: 0x484
function function_6cc2e374() {
    var_f022cb65 = getent("trigger_elevator_gears", "targetname");
    var_f022cb65 setcursorhint("HINT_NOICON");
    var_f022cb65 sethintstring("");
    var_66bf6df = getent("elevator_gears", "targetname");
    var_66bf6df thread function_46d7f262();
    while (true) {
        e_who = var_f022cb65 waittill(#"trigger");
        if (level flag::get("elevator_part_gear1_found") && !level flag::get("elevator_part_gear1_placed")) {
            level flag::set("elevator_part_gear1_placed");
            var_f022cb65 playsound("zmb_item_pickup");
            var_66bf6df.var_df281e84 = util::spawn_model("p7_zm_isl_elevator_gears_wheel", var_66bf6df gettagorigin("wheel_01_jnt") + (1, 2, 0), var_66bf6df gettagangles("wheel_01_jnt"));
        }
        if (level flag::get("elevator_part_gear2_found") && !level flag::get("elevator_part_gear2_placed")) {
            level flag::set("elevator_part_gear2_placed");
            var_f022cb65 playsound("zmb_item_pickup");
            var_66bf6df.var_e882d83c = util::spawn_model("p7_zm_isl_elevator_gears_wheel_small", var_66bf6df gettagorigin("wheel_02_jnt") + (0.525, 2, -0.075), var_66bf6df gettagangles("wheel_02_jnt"));
        }
        if (level flag::get("elevator_part_gear3_found") && !level flag::get("elevator_part_gear3_placed")) {
            level flag::set("elevator_part_gear3_placed");
            var_f022cb65 playsound("zmb_item_pickup");
            var_66bf6df.var_aab7a6d1 = util::spawn_model("p7_zm_isl_elevator_gears_wheel_small", var_66bf6df gettagorigin("wheel_03_jnt") + (0, 2, 0), var_66bf6df gettagangles("wheel_03_jnt"));
        }
        if (level flag::get("elevator_part_gear1_found") && level flag::get("elevator_part_gear2_found") && level flag::get("elevator_part_gear3_found")) {
            var_f022cb65 playsound("zmb_elevator_fix");
            level thread namespace_f333593c::function_3bf2d62a("elevator", 0, 1, 0);
            if (zm_utility::is_player_valid(e_who)) {
                e_who thread namespace_f333593c::function_d258c672("elevator");
            }
            level thread elevator_init();
            break;
        }
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_46d7f262
// Checksum 0xb5292584, Offset: 0x4eb0
// Size: 0x1d8
function function_46d7f262() {
    a_e_elevator = getentarray("easter_egg_elevator_cage", "targetname");
    while (true) {
        level flag::wait_till("elevator_in_use");
        wait(0.1);
        while (!isdefined(a_e_elevator[0].is_moving)) {
            wait(0.05);
        }
        while (a_e_elevator[0].is_moving) {
            if (level flag::get("elevator_at_bottom")) {
                n_rot = -90;
            } else {
                n_rot = 90;
            }
            self.var_df281e84 rotateroll(n_rot, 1);
            self.var_e882d83c rotateroll(n_rot, 1);
            self.var_aab7a6d1 rotateroll(n_rot * -1, 1);
            wait(0.9);
        }
        self.var_df281e84 rotateroll(n_rot * 0.01, 0.1);
        self.var_e882d83c rotateroll(n_rot * 0.01, 0.1);
        self.var_aab7a6d1 rotateroll(n_rot * -1 * 0.01, 0.1);
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_e2cd4ac4
// Checksum 0x6667ef91, Offset: 0x5090
// Size: 0x49c
function elevator_init() {
    n_width = 64;
    n_height = -128;
    n_length = 64;
    var_37f7b157 = struct::get_array("s_elevator_trigger", "targetname");
    foreach (s_org in var_37f7b157) {
        s_org.script_unitrigger_type = "unitrigger_box_use";
        s_org.cursor_hint = "HINT_NOICON";
        s_org.script_width = n_width;
        s_org.script_height = n_height;
        s_org.script_length = n_length;
        s_org.require_look_at = 1;
        s_org.prompt_and_visibility_func = &function_d93c8e95;
        zm_unitrigger::register_static_unitrigger(s_org, &function_8f599d4f);
    }
    var_37f7b157 = struct::get_array("s_elevator_call_trigger", "targetname");
    foreach (s_org in var_37f7b157) {
        s_org.script_unitrigger_type = "unitrigger_box_use";
        s_org.cursor_hint = "HINT_NOICON";
        s_org.script_width = n_width;
        s_org.script_height = n_height;
        s_org.script_length = n_length;
        s_org.require_look_at = 1;
        if (s_org.script_noteworthy == "bottom") {
            s_org.var_db67c127 = 1;
        } else {
            s_org.var_db67c127 = 0;
        }
        s_org.prompt_and_visibility_func = &function_ee748266;
        zm_unitrigger::register_static_unitrigger(s_org, &function_66070c12);
    }
    e_elevator = getent("easter_egg_elevator_cage", "targetname");
    e_elevator setmovingplatformenabled(1);
    var_dd1bd705 = getentarray("elevator_panel_lights", "script_noteworthy");
    foreach (e_light in var_dd1bd705) {
        e_light linkto(e_elevator);
    }
    exploder::exploder("ex_elevator_panel_green");
    exploder::exploder("ex_elevator_switch_top_red");
    exploder::exploder("ex_elevator_switch_bottom_green");
    exploder::exploder("ex_elevator_overlight");
    exploder::exploder("ex_elevator_repaired");
    function_574812fe();
}

// Namespace main_quest
// Params 1, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_d93c8e95
// Checksum 0x7863a7de, Offset: 0x5538
// Size: 0xc2
function function_d93c8e95(player) {
    if (level flag::get("elevator_in_use")) {
        self sethintstring("");
        return 0;
    }
    if (level flag::get("elevator_cooldown")) {
        self sethintstring(%ZM_ISLAND_ELEVATOR_RECHARGING);
        return 1;
    }
    self sethintstring(%ZM_ISLAND_USE_ELEVATOR);
    return 1;
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_8f599d4f
// Checksum 0xbdbf59b5, Offset: 0x5608
// Size: 0xd8
function function_8f599d4f() {
    while (true) {
        player = self waittill(#"trigger");
        if (player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (player.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(player)) {
            continue;
        }
        if (level flag::get("elevator_in_use") || level flag::get("elevator_cooldown")) {
            continue;
        }
        level thread function_46201613(self, player);
    }
}

// Namespace main_quest
// Params 1, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_ee748266
// Checksum 0x9045da8d, Offset: 0x56e8
// Size: 0x118
function function_ee748266(player) {
    if (level flag::get("elevator_in_use")) {
        self sethintstring(%ZM_ISLAND_ELEVATOR_IN_USE);
        return 0;
    }
    if (level flag::get("elevator_cooldown")) {
        self sethintstring(%ZM_ISLAND_ELEVATOR_RECHARGING);
        return 1;
    }
    if (self.stub.var_db67c127 != level flag::get("elevator_at_bottom")) {
        self sethintstring(%ZM_ISLAND_CALL_ELEVATOR);
        return 1;
    }
    self sethintstring("");
    return 0;
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_66070c12
// Checksum 0x9272236e, Offset: 0x5808
// Size: 0x108
function function_66070c12() {
    while (true) {
        player = self waittill(#"trigger");
        if (player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (player.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(player)) {
            continue;
        }
        if (level flag::get("elevator_in_use") || level flag::get("elevator_cooldown")) {
            continue;
        }
        if (self.stub.var_db67c127 != level flag::get("elevator_at_bottom")) {
            level thread function_46201613(self, player);
        }
    }
}

// Namespace main_quest
// Params 2, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_46201613
// Checksum 0xc49275fa, Offset: 0x5918
// Size: 0x21c
function function_46201613(var_91089b66, player) {
    level flag::set("elevator_in_use");
    exploder::exploder_stop("ex_elevator_panel_green");
    exploder::exploder_stop("ex_elevator_switch_top_green");
    exploder::exploder_stop("ex_elevator_switch_bottom_green");
    exploder::exploder("ex_elevator_panel_red");
    exploder::exploder("ex_elevator_switch_top_red");
    exploder::exploder("ex_elevator_switch_bottom_red");
    function_574812fe(0);
    elevator_move();
    function_574812fe();
    level flag::clear("elevator_in_use");
    level flag::set("elevator_cooldown");
    wait(5);
    level flag::clear("elevator_cooldown");
    exploder::exploder_stop("ex_elevator_panel_red");
    exploder::exploder("ex_elevator_panel_green");
    if (level flag::get("elevator_at_bottom")) {
        exploder::exploder_stop("ex_elevator_switch_top_red");
        exploder::exploder("ex_elevator_switch_top_green");
        return;
    }
    exploder::exploder_stop("ex_elevator_switch_bottom_red");
    exploder::exploder("ex_elevator_switch_bottom_green");
}

// Namespace main_quest
// Params 1, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_574812fe
// Checksum 0xaaed1450, Offset: 0x5b40
// Size: 0x61a
function function_574812fe(b_open) {
    if (!isdefined(b_open)) {
        b_open = 1;
    }
    if (level flag::get("elevator_at_bottom")) {
        var_8c7e827f = getent("easter_egg_elevator_door_bottom_left", "targetname");
        var_5548791a = getent("easter_egg_elevator_door_bottom_right", "targetname");
        var_28bca224 = getent("easter_egg_elevator_door_inner_bottom_left", "targetname");
        var_70426c1b = getent("easter_egg_elevator_door_inner_bottom_right", "targetname");
        var_2e25ac99 = getnodearray("elevator_bottom_begin_node", "targetname");
    } else {
        var_8c7e827f = getent("easter_egg_elevator_door_top_left", "targetname");
        var_5548791a = getent("easter_egg_elevator_door_top_right", "targetname");
        var_28bca224 = getent("easter_egg_elevator_door_inner_top_left", "targetname");
        var_70426c1b = getent("easter_egg_elevator_door_inner_top_right", "targetname");
        var_2e25ac99 = getnodearray("elevator_top_begin_node", "targetname");
    }
    if (isdefined(b_open) && b_open) {
        var_8c7e827f notsolid();
        var_5548791a notsolid();
        var_28bca224 notsolid();
        var_70426c1b notsolid();
        var_8c7e827f connectpaths();
        var_5548791a connectpaths();
        var_28bca224 connectpaths();
        var_70426c1b connectpaths();
        foreach (var_49686839 in var_2e25ac99) {
            linktraversal(var_49686839);
        }
        var_8c7e827f movey(-40, 1);
        var_5548791a movey(40, 1);
        var_28bca224 movey(-40, 1);
        var_70426c1b movey(40, 1);
        var_28bca224 playsound("zmb_elevator_door_open");
        level flag::clear("elevator_door_closed");
    } else {
        foreach (var_49686839 in var_2e25ac99) {
            unlinktraversal(var_49686839);
        }
        var_8c7e827f solid();
        var_5548791a solid();
        var_28bca224 solid();
        var_70426c1b solid();
        var_8c7e827f disconnectpaths();
        var_5548791a disconnectpaths();
        var_28bca224 disconnectpaths();
        var_70426c1b disconnectpaths();
        var_8c7e827f movey(40, 1);
        var_5548791a movey(-40, 1);
        var_28bca224 movey(40, 1);
        var_70426c1b movey(-40, 1);
        var_28bca224 playsound("zmb_elevator_door_close");
        level flag::set("elevator_door_closed");
    }
    var_8c7e827f waittill(#"movedone");
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_5107c299
// Checksum 0x65a4b9c0, Offset: 0x6168
// Size: 0x4c4
function elevator_move() {
    a_e_elevator = getentarray("easter_egg_elevator_cage", "targetname");
    var_1fac16fe = getent("easter_egg_elevator_door_inner_top_left", "targetname");
    var_1fac16fe linkto(a_e_elevator[0]);
    var_adbea363 = getent("easter_egg_elevator_door_inner_top_right", "targetname");
    var_adbea363 linkto(a_e_elevator[0]);
    var_46ebdf14 = getent("easter_egg_elevator_door_inner_bottom_left", "targetname");
    var_46ebdf14 linkto(a_e_elevator[0]);
    var_ddc6ba27 = getent("easter_egg_elevator_door_inner_bottom_right", "targetname");
    var_ddc6ba27 linkto(a_e_elevator[0]);
    if (level flag::get("elevator_at_bottom")) {
        foreach (e_elevator in a_e_elevator) {
            e_elevator movez(1280, 20);
        }
    } else {
        foreach (e_elevator in a_e_elevator) {
            e_elevator movez(-1280, 20);
        }
    }
    a_e_elevator[0].is_moving = 1;
    a_e_elevator[0] playsound("zmb_elevator_start");
    a_e_elevator[0] playloopsound("zmb_elevator_loop");
    a_e_elevator[0] thread function_7b8e6e93();
    a_e_elevator[0] waittill(#"movedone");
    a_e_elevator[0] thread function_e35db912();
    a_e_elevator[0].is_moving = 0;
    a_e_elevator[0] playsound("zmb_elevator_stop");
    a_e_elevator[0] stoploopsound(0.5);
    var_1fac16fe = getent("easter_egg_elevator_door_inner_top_left", "targetname");
    var_1fac16fe unlink();
    var_adbea363 = getent("easter_egg_elevator_door_inner_top_right", "targetname");
    var_adbea363 unlink();
    var_46ebdf14 = getent("easter_egg_elevator_door_inner_bottom_left", "targetname");
    var_46ebdf14 unlink();
    var_ddc6ba27 = getent("easter_egg_elevator_door_inner_bottom_right", "targetname");
    var_ddc6ba27 unlink();
    if (level flag::get("elevator_at_bottom")) {
        level flag::clear("elevator_at_bottom");
        return;
    }
    level flag::set("elevator_at_bottom");
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_7b8e6e93
// Checksum 0x54252ac6, Offset: 0x6638
// Size: 0x1c6
function function_7b8e6e93() {
    self endon(#"movedone");
    while (true) {
        foreach (player in level.players) {
            if (player istouching(self)) {
                player.var_af5a4a9 = 1;
            }
        }
        wait(0.05);
        foreach (player in level.players) {
            if (player.origin[2] > self.origin[2] + 60 || player.var_af5a4a9 === 1 && player.origin[2] < self.origin[2] - 20) {
                player setorigin(self.origin + (0, 0, 20));
            }
        }
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_e35db912
// Checksum 0xe83f25f5, Offset: 0x6808
// Size: 0x8e
function function_e35db912() {
    wait(0.1);
    foreach (player in level.players) {
        player.var_af5a4a9 = 0;
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_f818f5b5
// Checksum 0x91097daa, Offset: 0x68a0
// Size: 0x298
function function_f818f5b5() {
    level flag::wait_till("all_challenges_completed");
    zm::register_actor_damage_callback(&function_16155679);
    zm::register_vehicle_damage_callback(&function_a7a11020);
    var_8d943e64 = getent("ruins_lightning_trigger", "targetname");
    while (true) {
        wait(randomfloatrange(60, 90));
        exploder::exploder("fxexp_510");
        exploder::exploder("fxexp_511");
        exploder::exploder("fxexp_512");
        exploder::exploder("fxexp_513");
        exploder::exploder("fxexp_514");
        exploder::exploder("fxexp_820");
        exploder::exploder("fxexp_821");
        exploder::exploder("fxexp_822");
        exploder::exploder("fxexp_823");
        level thread function_51f6829f(var_8d943e64);
        wait(5);
        level notify(#"hash_6d764fa3");
        exploder::exploder_stop("fxexp_510");
        exploder::exploder_stop("fxexp_511");
        exploder::exploder_stop("fxexp_512");
        exploder::exploder_stop("fxexp_513");
        exploder::exploder_stop("fxexp_514");
        exploder::exploder_stop("fxexp_820");
        exploder::exploder_stop("fxexp_821");
        exploder::exploder_stop("fxexp_822");
        exploder::exploder_stop("fxexp_823");
    }
}

// Namespace main_quest
// Params 1, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_51f6829f
// Checksum 0x8d94ece9, Offset: 0x6b40
// Size: 0x228
function function_51f6829f(var_8d943e64) {
    level endon(#"hash_6d764fa3");
    wait(1);
    while (true) {
        foreach (player in level.players) {
            if (player istouching(var_8d943e64)) {
                w_current = player getcurrentweapon();
                if (isdefined(zm_utility::is_player_valid(player)) && w_current.isriotshield === 1 && !(isdefined(player zm_laststand::is_reviving_any()) && player zm_laststand::is_reviving_any()) && zm_utility::is_player_valid(player)) {
                    if (!(isdefined(player.var_36c3d64a) && player.var_36c3d64a)) {
                        player thread function_8f34e78f();
                        player notify(#"hash_df77d4a");
                    }
                    continue;
                }
                if (!(isdefined(player.var_bd2718b6) && player.var_bd2718b6)) {
                    player dodamage(player.maxhealth * 0.5, player.origin);
                    player thread function_69b5fce9();
                }
            }
        }
        wait(0.1);
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_69b5fce9
// Checksum 0xc8a8e2f8, Offset: 0x6d70
// Size: 0x30
function function_69b5fce9() {
    self endon(#"disconnect");
    self.var_bd2718b6 = 1;
    wait(3);
    self.var_bd2718b6 = 0;
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_8f34e78f
// Checksum 0x1f19bc0e, Offset: 0x6da8
// Size: 0x5c
function function_8f34e78f() {
    self.var_36c3d64a = 1;
    self.riotshield_damage_absorb_callback = &function_d68f2492;
    self thread function_e7cf715();
    self clientfield::set("lightning_shield_fx", 1);
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_e7cf715
// Checksum 0xcf85b17c, Offset: 0x6e10
// Size: 0x74
function function_e7cf715() {
    self endon(#"disconnect");
    self util::waittill_any("destroy_riotshield", "riotshield_lost_lightning", "bled_out");
    self.var_36c3d64a = 0;
    self.riotshield_damage_absorb_callback = undefined;
    self clientfield::set("lightning_shield_fx", 0);
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_9f26e724
// Checksum 0x22c0c230, Offset: 0x6e90
// Size: 0xd2
function function_9f26e724() {
    foreach (var_c9340b8 in level.var_961b3545) {
        if (level.activeplayers.size > 1 && (var_c9340b8.script_string != "revive_perk" || var_c9340b8.script_string == "revive_perk")) {
            var_c9340b8 thread function_f295a467();
        }
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_f295a467
// Checksum 0x1bb1b2b6, Offset: 0x6f70
// Size: 0x298
function function_f295a467() {
    self endon(#"death");
    self.var_bf47c5ef = 0;
    self.machine setcandamage(1);
    while (true) {
        n_damage, e_attacker, v_direction, v_point, str_mod, str_tag_name, str_model_name, var_829b9480, w_weapon = self.machine waittill(#"damage");
        n_damage = 0;
        if (isdefined(e_attacker.var_36c3d64a) && isdefined(w_weapon.isriotshield) && w_weapon.isriotshield && e_attacker.var_36c3d64a && !self.var_bf47c5ef) {
            e_attacker notify(#"hash_6bef9736");
            self.var_bf47c5ef = 1;
            self.var_a62a0fde = self.cost;
            self playsound("zmb_lightning_shield_activate");
            str_perk = self.script_noteworthy;
            if (isdefined(level._custom_perks) && isdefined(level._custom_perks[str_perk])) {
                self.cost = int(self.cost * 0.5);
                level._custom_perks[str_perk].cost = self.cost;
                self.machine thread function_b83e4b61(str_perk, 1);
                self zm_perks::reset_vending_hint_string();
                wait(30);
                self.machine thread function_b83e4b61(str_perk, 0);
                self.var_bf47c5ef = 0;
                self.cost = self.var_a62a0fde;
                level._custom_perks[str_perk].cost = self.cost;
                self zm_perks::reset_vending_hint_string();
            }
        }
    }
}

// Namespace main_quest
// Params 2, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_b83e4b61
// Checksum 0x46765314, Offset: 0x7210
// Size: 0x19c
function function_b83e4b61(str_perk, b_on) {
    if (b_on) {
        switch (str_perk) {
        case 165:
            self clientfield::set("perk_lightning_fx", 1);
            break;
        case 164:
            self clientfield::set("perk_lightning_fx", 2);
            break;
        case 74:
            self clientfield::set("perk_lightning_fx", 3);
            break;
        case 166:
            self clientfield::set("perk_lightning_fx", 4);
            break;
        case 167:
            self clientfield::set("perk_lightning_fx", 5);
            break;
        case 163:
            self clientfield::set("perk_lightning_fx", 6);
            break;
        default:
            self clientfield::set("perk_lightning_fx", 1);
            break;
        }
        return;
    }
    self clientfield::set("perk_lightning_fx", 0);
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_8221532d
// Checksum 0x22ef690c, Offset: 0x73b8
// Size: 0x154
function function_8221532d() {
    var_d3ed310f = getentarray("bgb_damage_clip", "script_noteworthy");
    foreach (var_a27ff52f in var_d3ed310f) {
        foreach (var_4770ddb4 in level.var_5081bd63) {
            if (var_4770ddb4 istouching(var_a27ff52f)) {
                var_4770ddb4.var_9e209773 = var_a27ff52f;
                var_4770ddb4 thread function_e20ecfa4();
                break;
            }
        }
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_e20ecfa4
// Checksum 0x529b2646, Offset: 0x7518
// Size: 0x284
function function_e20ecfa4() {
    self endon(#"death");
    self.var_bf47c5ef = 0;
    self.var_9e209773 setcandamage(1);
    self.var_9e209773.health = 99999;
    while (true) {
        n_damage, e_attacker, v_direction, v_point, str_mod, str_tag_name, str_model_name, var_829b9480, w_weapon = self.var_9e209773 waittill(#"damage");
        n_damage = 0;
        if (isdefined(e_attacker.var_36c3d64a) && isdefined(w_weapon.isriotshield) && w_weapon.isriotshield && e_attacker.var_36c3d64a && !self.var_bf47c5ef) {
            if (isdefined(level.zombie_vars["zombie_powerup_fire_sale_on"]) && level.zombie_vars["zombie_powerup_fire_sale_on"]) {
                continue;
            }
            self.var_9e209773 playsound("zmb_lightning_shield_activate");
            e_attacker notify(#"hash_6bef9736");
            self.var_bf47c5ef = 1;
            self.var_a62a0fde = self.var_11e155aa;
            self.var_11e155aa = int(self.var_11e155aa * 0.5);
            self clientfield::set("bgb_lightning_fx", 1);
            wait(30);
            if (isdefined(level.zombie_vars["zombie_powerup_fire_sale_on"]) && level.zombie_vars["zombie_powerup_fire_sale_on"]) {
                level waittill(#"fire_sale_off");
                wait(0.5);
            }
            self clientfield::set("bgb_lightning_fx", 0);
            self.var_bf47c5ef = 0;
            self.var_11e155aa = self.var_a62a0fde;
        }
    }
}

// Namespace main_quest
// Params 12, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_16155679
// Checksum 0x287f4863, Offset: 0x77a8
// Size: 0x120
function function_16155679(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (isdefined(attacker.var_36c3d64a) && isdefined(weapon.isriotshield) && weapon.isriotshield && attacker.var_36c3d64a && !isplayer(self)) {
        attacker zm_bgb_pop_shocks::electrocute_actor(self);
        attacker notify(#"hash_aacf862e");
        attacker namespace_f333593c::function_1881817("kill", "shield_electric");
    }
    return -1;
}

// Namespace main_quest
// Params 15, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_a7a11020
// Checksum 0xa692d776, Offset: 0x78d0
// Size: 0x158
function function_a7a11020(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (isdefined(eattacker.var_36c3d64a) && isdefined(weapon.isriotshield) && weapon.isriotshield && eattacker.var_36c3d64a && !isplayer(self)) {
        if (level.var_335f95e4 === self && level flag::get("spider_from_mars_trapped_in_raised_cage")) {
            return 0;
        }
        eattacker zm_bgb_pop_shocks::electrocute_actor(self);
        eattacker namespace_f333593c::function_1881817("kill", "shield_electric");
    }
    return idamage;
}

// Namespace main_quest
// Params 4, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_d68f2492
// Checksum 0x125b4ff4, Offset: 0x7a30
// Size: 0x74
function function_d68f2492(eattacker, idamage, shitloc, smeansofdeath) {
    if (isdefined(self.var_36c3d64a) && self.var_36c3d64a && !isplayer(eattacker)) {
        self zm_bgb_pop_shocks::electrocute_actor(eattacker);
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_e509082
// Checksum 0xeaa57092, Offset: 0x7ab0
// Size: 0x31c
function function_e509082() {
    level flag::wait_till("flag_play_outro_cutscene");
    foreach (player in level.activeplayers) {
        player thread namespace_f333593c::function_cf763858();
    }
    level lui::screen_fade_out(0, "black");
    level util::function_7d553ac6();
    scene::add_scene_func("cin_isl_outro_3rd_sh140", &function_c93cd104, "play");
    scene::add_scene_func("cin_isl_outro_3rd_sh240", &function_c5001569, "play");
    scene::add_scene_func("cin_isl_outro_3rd_sh240", &function_dad4e4f3, "done");
    scene::add_scene_func("cin_isl_outro_3rd_sh250", &function_1f3b8e3c, "play");
    scene::add_scene_func("cin_isl_outro_3rd_sh250", &function_da7a6f36, "done");
    wait(0.25);
    getent("mdl_alttakeo", "targetname") hide();
    level thread function_dcf88974();
    level flag::set("flag_show_outro_water");
    wait(0.25);
    level lui::screen_fade_in(0, "black");
    level scene::play("cin_isl_outro_3rd_sh010");
    array::thread_all(level.activeplayers, &zm_utility::function_82a5cc4);
    array::thread_all(level.players, &function_d875b253);
    array::thread_all(level.players, &function_d2e1a913);
    level flag::set("flag_outro_cutscene_done");
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_d2e1a913
// Checksum 0x8f0d33b2, Offset: 0x7dd8
// Size: 0x64
function function_d2e1a913() {
    level scoreevents::processscoreevent("main_EE_quest_island", self);
    self zm_stats::increment_global_stat("DARKOPS_ISLAND_EE");
    self zm_stats::increment_global_stat("DARKOPS_ISLAND_SUPER_EE");
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_d875b253
// Checksum 0x7e215c50, Offset: 0x7e48
// Size: 0x4c
function function_d875b253() {
    if (isalive(self) && self.characterindex != 2) {
        self setcharacterbodystyle(1);
    }
}

// Namespace main_quest
// Params 1, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_c93cd104
// Checksum 0xf2ea75c2, Offset: 0x7ea0
// Size: 0x94
function function_c93cd104(a_ents) {
    var_722023b5 = a_ents["old_takeo"];
    var_722023b5 waittill(#"hash_a00e5555");
    if (level.var_7ccadaab === 11) {
        var_722023b5 playsoundontag("vox_tak1_outro_igc_japalt_13", "J_Head");
        return;
    }
    var_722023b5 playsoundontag("vox_tak1_outro_igc_13", "J_Head");
}

// Namespace main_quest
// Params 1, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_c5001569
// Checksum 0x72dbfd27, Offset: 0x7f40
// Size: 0x34
function function_c5001569(a_ents) {
    level waittill(#"hash_83582d4d");
    level lui::screen_fade_out(0, "black");
}

// Namespace main_quest
// Params 1, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_dad4e4f3
// Checksum 0x37f0a551, Offset: 0x7f80
// Size: 0x2c
function function_dad4e4f3(a_ents) {
    level lui::screen_fade_in(0, "black");
}

// Namespace main_quest
// Params 1, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_1f3b8e3c
// Checksum 0x14ada020, Offset: 0x7fb8
// Size: 0x1a4
function function_1f3b8e3c(a_ents) {
    if (!isdefined(a_ents)) {
        a_ents = undefined;
    }
    var_f852acf0 = a_ents["summoning_key"];
    s_org = struct::get("tag_align_end_cinematic");
    var_2c3a4ffd = spawn("script_model", s_org.origin);
    if (isdefined(a_ents)) {
        level waittill(#"hash_f2d5d1f");
    }
    level lui::screen_fade_out(0, "white");
    level waittill(#"hash_71fdf829");
    var_2c3a4ffd playsoundwithnotify("vox_plr_0_outro_igc_28");
    var_f852acf0 hide();
    level waittill(#"hash_4bfb7dc0");
    var_2c3a4ffd playsoundwithnotify("vox_plr_2_outro_igc_29");
    level waittill(#"hash_80a2e709");
    array::thread_all(level.players, &function_449f0778);
    level lui::screen_fade_in(0.5, "white");
    var_2c3a4ffd delete();
}

// Namespace main_quest
// Params 1, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_da7a6f36
// Checksum 0x2bd30701, Offset: 0x8168
// Size: 0x64
function function_da7a6f36(a_ents) {
    level thread function_f714fcfa();
    level thread scene::play("cin_isl_outro_1st_old_takeo_corpse");
    level flag::set("flag_hide_outro_water");
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_f714fcfa
// Checksum 0x15440b97, Offset: 0x81d8
// Size: 0x36c
function function_f714fcfa() {
    wait(5);
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh010");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh020");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh030");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh040");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh060");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh070");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh080");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh090");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh100");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh120");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh130");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh140");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh150");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh160");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh170");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh175");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh180");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh190");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh190");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh195");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh196");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh200");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh210");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh220");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh230");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh240");
    struct::function_368120a1("scene", "cin_isl_outro_3rd_sh250");
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_dcf88974
// Checksum 0xbe992078, Offset: 0x8550
// Size: 0x21a
function function_dcf88974() {
    foreach (player in level.players) {
        n_player_index = player.characterindex;
        s_org = struct::get("ending_igc_exit_" + n_player_index);
        player setorigin(s_org.origin);
        player setplayerangles(s_org.angles);
        player freezecontrolsallowlook(1);
        player allowsprint(0);
        player allowjump(0);
        player enableinvulnerability();
        player setclientuivisibilityflag("hud_visible", 0);
        player setclientuivisibilityflag("weapon_hud_visible", 0);
        player disableweapons();
        player.var_d07c64b6 = 0;
        player notify(#"hash_dd8e5266");
        player clientfield::set("spore_trail_player_fx", 0);
        player clientfield::set_to_player("spore_camera_fx", 0);
    }
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_449f0778
// Checksum 0x61a9a606, Offset: 0x8778
// Size: 0x210
function function_449f0778() {
    self endon(#"disconnect");
    self clientfield::set_to_player("player_stargate_fx", 1);
    n_player_index = self.characterindex;
    level clientfield::set("portal_state_ending_" + n_player_index, 1);
    s_org = struct::get("ending_igc_exit_" + n_player_index);
    self playsound("zmb_outro_teleport");
    wait(3);
    self clientfield::set_to_player("player_stargate_fx", 0);
    wait(1.5);
    level util::function_f7beb173();
    self enableweapons();
    self freezecontrolsallowlook(0);
    self allowsprint(1);
    self allowjump(1);
    self disableinvulnerability();
    self setclientuivisibilityflag("hud_visible", 1);
    self setclientuivisibilityflag("weapon_hud_visible", 1);
    level clientfield::set("portal_state_ending_" + n_player_index, 0);
    level thread namespace_f333593c::function_b83e53a5();
    level flag::set("spawn_zombies");
    level.disable_nuke_delay_spawning = 0;
}

// Namespace main_quest
// Params 0, eflags: 0x1 linked
// namespace_b3c23ec9<file_0>::function_dcc18c22
// Checksum 0x5fb9d8aa, Offset: 0x8990
// Size: 0xb4
function function_dcc18c22() {
    e_water = getent("main_ee_outro_water", "targetname");
    e_water hide();
    level flag::wait_till("flag_show_outro_water");
    e_water show();
    level flag::wait_till("flag_hide_outro_water");
    e_water hide();
}

/#

    // Namespace main_quest
    // Params 0, eflags: 0x1 linked
    // namespace_b3c23ec9<file_0>::function_12d043ed
    // Checksum 0x4941f329, Offset: 0x8a50
    // Size: 0xec
    function function_12d043ed() {
        level flag::set("elevator_part_gear1_found");
        zm_devgui::add_custom_devgui_callback(&function_efbc0e1);
        adddebugcommand("elevator_part_gear1_found");
        adddebugcommand("elevator_part_gear1_found");
        adddebugcommand("elevator_part_gear1_found");
        adddebugcommand("elevator_part_gear1_found");
        adddebugcommand("elevator_part_gear1_found");
        adddebugcommand("elevator_part_gear1_found");
        adddebugcommand("elevator_part_gear1_found");
    }

    // Namespace main_quest
    // Params 1, eflags: 0x1 linked
    // namespace_b3c23ec9<file_0>::function_efbc0e1
    // Checksum 0xe3bd4288, Offset: 0x8b48
    // Size: 0x2fe
    function function_efbc0e1(cmd) {
        switch (cmd) {
        case 8:
            level flag::set("elevator_part_gear1_found");
            return 1;
        case 8:
            level thread function_85b23415();
            level flag::set("elevator_part_gear1_found");
            level flag::set("elevator_part_gear1_found");
            level flag::set("elevator_part_gear1_found");
            level flag::set("elevator_part_gear1_found");
            return 1;
        case 8:
            foreach (player in level.players) {
                w_current = player getcurrentweapon();
                if (w_current.isriotshield === 1) {
                    player thread function_8f34e78f();
                }
            }
            return 1;
        case 8:
            elevator_init();
            return 1;
        case 8:
            level flag::set("elevator_part_gear1_found");
            level flag::set("elevator_part_gear1_found");
            level flag::set("elevator_part_gear1_found");
            return 1;
        case 8:
            clientfield::set("elevator_part_gear1_found", 1);
            level scene::init("elevator_part_gear1_found");
            while (!level scene::is_ready("elevator_part_gear1_found")) {
                wait(0.05);
            }
            wait(5);
            level flag::set("elevator_part_gear1_found");
            return 1;
        case 8:
            level thread function_1f3b8e3c();
            return 1;
        }
        return 0;
    }

#/
