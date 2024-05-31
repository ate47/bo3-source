#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_death;
#using scripts/zm/zm_castle_vo;
#using scripts/zm/zm_castle_util;
#using scripts/zm/zm_castle_mechz;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_weap_gravityspikes;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_ai_mechz;
#using scripts/zm/_zm_ai_dogs;
#using scripts/zm/_load;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/mechz;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/_burnplayer;
#using scripts/codescripts/struct;

#namespace namespace_b1bc995c;

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_c35e6aab
// Checksum 0x2adef490, Offset: 0x13f0
// Size: 0x808
function init() {
    clientfield::register("toplayer", "player_snow_fx_off", 5000, 1, "counter");
    clientfield::register("actor", "boss_skeleton_eye_glow_fx_change", 5000, 1, "counter");
    clientfield::register("scriptmover", "boss_mpd_fx", 5000, 1, "int");
    clientfield::register("scriptmover", "boss_fx", 5000, 1, "int");
    clientfield::register("scriptmover", "boss_weak_point_shader", 5000, 1, "int");
    clientfield::register("actor", "boss_zombie_rise_fx", 1, 1, "int");
    clientfield::register("scriptmover", "boss_teleport_fx", 5000, 1, "counter");
    clientfield::register("scriptmover", "boss_elemental_storm_cast_fx", 5000, 1, "int");
    clientfield::register("scriptmover", "boss_elemental_storm_explode_fx", 5000, 1, "int");
    clientfield::register("scriptmover", "boss_elemental_storm_stunned_keeper_fx", 5000, 1, "int");
    clientfield::register("scriptmover", "boss_elemental_storm_stunned_spikes_fx", 5000, 1, "int");
    clientfield::register("scriptmover", "boss_demongate_cast_fx", 5000, 1, "int");
    clientfield::register("scriptmover", "boss_demongate_chomper_fx", 5000, 1, "int");
    clientfield::register("scriptmover", "boss_demongate_chomper_bite_fx", 5000, 1, "counter");
    clientfield::register("scriptmover", "boss_rune_prison_erupt_fx", 5000, 1, "int");
    clientfield::register("scriptmover", "boss_rune_prison_rock_fx", 5000, 1, "int");
    clientfield::register("scriptmover", "boss_rune_prison_explode_fx", 5000, 1, "int");
    clientfield::register("allplayers", "boss_rune_prison_dot_fx", 5000, 1, "int");
    clientfield::register("world", "boss_wolf_howl_fx_change", 5000, 1, "int");
    clientfield::register("world", "boss_gravity_spike_fx_change", 5000, 1, "int");
    clientfield::register("world", "sndBossBattle", 5000, 1, "int");
    level flag::init("boss_fight_ready");
    level flag::init("boss_fight_begin");
    level flag::init("boss_elemental_storm_cast_in_progress");
    level flag::init("boss_stunned");
    level flag::init("boss_completed_early");
    level flag::init("boss_fight_completed");
    level.custom_spawner_entry["boss_riser"] = &function_77025eb5;
    level thread function_dc2735aa();
    /#
        level flag::init("boss_fx");
        level flag::init("boss_fx");
        level flag::init("boss_fx");
        if (getdvarint("boss_fx") > 0) {
            level thread function_fb4ac7ae();
        }
    #/
    level flag::wait_till("boss_fight_ready");
    level function_b18f59bf();
    level thread function_6f831a91();
    level flag::wait_till("boss_fight_begin");
    zm_zonemgr::enable_zone("zone_boss_arena");
    var_1af36687 = spawnstruct();
    var_1af36687 function_71130ea();
    foreach (player in level.players) {
        player thread function_4bea595();
    }
    callback::on_connect(&function_4bea595);
    level flag::clear("low_grav_on");
    exploder::stop_exploder("lgt_low_gravity_on");
    level clientfield::set("snd_low_gravity_state", 0);
    level flag::clear("spawn_zombies");
    level flag::clear("zombie_drop_powerups");
    if (level.var_6e2e91a0 !== 1) {
        level.var_6e2e91a0 = 1;
        var_67f16423 = 0;
    } else {
        var_67f16423 = 1;
    }
    var_1af36687 function_4f5e3970();
    var_1af36687 boss_fight_complete();
    var_1af36687 function_1690ddb0();
    if (!var_67f16423) {
        level.var_6e2e91a0 = 0;
    }
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_dc2735aa
// Checksum 0x1c4707d6, Offset: 0x1c00
// Size: 0x19c
function function_dc2735aa() {
    var_7ead9349 = getent("boss_skeleton_spawner", "targetname");
    var_7ead9349.script_noteworthy = "zombie_spawner";
    while (!isdefined(level.zombie_spawners)) {
        wait(0.05);
    }
    wait(0.05);
    for (i = 0; i < level.zombie_spawners.size; i++) {
        if (level.zombie_spawners[i].targetname === "boss_skeleton_spawner") {
            arrayremovevalue(level.zombie_spawners, level.zombie_spawners[i]);
        }
    }
    level.zombie_spawners = array::remove_undefined(level.zombie_spawners, 0);
    while (!isdefined(level.var_a70b4aef)) {
        wait(0.05);
    }
    wait(0.05);
    for (i = 0; i < level.var_a70b4aef.size; i++) {
        if (level.var_a70b4aef[i].targetname === "boss_skeleton_spawner") {
            level.var_a70b4aef[i] = undefined;
        }
    }
    level.var_a70b4aef = array::remove_undefined(level.var_a70b4aef, 0);
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_b18f59bf
// Checksum 0x51470824, Offset: 0x1da8
// Size: 0x45c
function function_b18f59bf() {
    level endon(#"hash_27340cf3");
    var_82a4f07b = struct::get("keeper_end_loc");
    var_82a4f07b fx::play("mpd_fx", var_82a4f07b.origin, var_82a4f07b.angles, "delete_fx", 0, undefined, 1);
    level.var_8ef26cd9 = 1;
    foreach (player in level.players) {
        player thread namespace_744abc1c::function_fa7da172();
    }
    callback::on_connect(&namespace_744abc1c::function_fa7da172);
    wait(4.5);
    level.var_513683a6 = 1;
    exploder::kill_exploder("fxexp_117");
    level thread lui::screen_flash(0.15, 1, 0.35, 0.95, "white");
    var_649d30e8 = struct::get("mpd_pos");
    var_293d02aa = util::spawn_model("p7_zm_ctl_undercroft_pyramid", var_649d30e8.origin, var_649d30e8.angles);
    var_293d02aa hidepart("tag_prestine_can");
    var_293d02aa.targetname = "undercroft_pyramid";
    var_293d02aa playsound("zmb_ee_mpd_spawn_pyramid");
    var_293d02aa disconnectpaths();
    var_82a4f07b notify(#"hash_629fd78d");
    callback::remove_on_connect(&namespace_744abc1c::function_fa7da172);
    level.var_8ef26cd9 = undefined;
    level thread function_1fd76e61(var_293d02aa);
    wait(0.15);
    var_293d02aa thread function_83ff2eda();
    exploder::exploder("lgt_MPD_exp");
    level thread namespace_97ddfc0d::function_698d2c6b();
    level waittill(#"hash_3921dbad");
    var_82a4f07b fx::play("mpd_fx", var_82a4f07b.origin + (0, 0, 32), var_82a4f07b.angles, "delete_fx", 0, undefined, 1);
    var_293d02aa playsound("zmb_ee_mpd_open");
    level.var_8ef26cd9 = 1;
    foreach (player in level.players) {
        player thread namespace_744abc1c::function_fa7da172();
    }
    callback::on_connect(&namespace_744abc1c::function_fa7da172);
    level thread function_91a378e3();
    scene::play("p7_fxanim_zm_castle_pyramid_bundle");
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_1fd76e61
// Checksum 0xb99232f0, Offset: 0x2210
// Size: 0x300
function function_1fd76e61(var_293d02aa) {
    var_5893159e = struct::get_array("boss_complete_tele_point");
    foreach (player in level.players) {
        if (player istouching(var_293d02aa)) {
            foreach (s_panel in var_5893159e) {
                if (!(isdefined(s_panel.b_occupied) && s_panel.b_occupied)) {
                    foreach (var_5e72aed6 in level.players) {
                        str_player_zone = var_5e72aed6 zm_zonemgr::get_player_zone();
                        if (str_player_zone === "zone_undercroft") {
                            if (distance2dsquared(var_5e72aed6.origin, s_panel.origin) > 16384) {
                                player setorigin(s_panel.origin);
                                s_panel.b_occupied = 1;
                                break;
                            }
                        }
                    }
                    if (isdefined(s_panel.b_occupied) && s_panel.b_occupied) {
                        break;
                    }
                }
            }
        }
    }
    foreach (s_panel in var_5893159e) {
        s_panel.b_occupied = undefined;
    }
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_83ff2eda
// Checksum 0xd1d9f708, Offset: 0x2518
// Size: 0x24a
function function_83ff2eda() {
    v_origin = self gettagorigin("tag_fx");
    v_angles = self gettagangles("tag_fx");
    self fx::play("dark_matter", v_origin, v_angles, "delete_fx", 0, "tag_fx", 1);
    level flag::wait_till("mpd_canister_replacement");
    s_canister = struct::get("canister_2");
    mdl_origin = util::spawn_model("tag_origin", s_canister.origin, s_canister.angles);
    mdl_origin playloopsound("zmb_ee_mpd_broken_canister_lp", 1);
    s_canister namespace_744abc1c::create_unitrigger(undefined, -128);
    s_canister waittill(#"trigger_activated");
    zm_unitrigger::unregister_unitrigger(s_canister.s_unitrigger);
    mdl_origin playsound("zmb_ee_mpd_broken_canister_replace");
    mdl_origin stoploopsound(1);
    self notify(#"hash_629fd78d");
    self hidepart("tag_broken_can");
    self showpart("tag_prestine_can");
    exploder::exploder("lgt_MPD_broken_exp");
    mdl_origin delete();
    level notify(#"hash_3921dbad");
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_91a378e3
// Checksum 0xcfa09557, Offset: 0x2770
// Size: 0x224
function function_91a378e3() {
    var_4fafa709 = struct::get("mpd_pos");
    var_da3dbbdf = util::spawn_anim_model("c_zom_dlc1_keeper_archon_small_fb", var_4fafa709.origin, (0, 90, 0));
    wait(0.05);
    var_da3dbbdf ghost();
    wait(0.05);
    var_da3dbbdf clientfield::set("boss_mpd_fx", 1);
    var_da3dbbdf show();
    var_da3dbbdf function_a1658f19("ai_zm_dlc1_corrupted_keeper_float_emerge", "ai_zm_dlc1_corrupted_keeper_float_idle");
    wait(0.05);
    var_da3dbbdf function_a1658f19("ai_zm_dlc1_corrupted_keeper_roar", "ai_zm_dlc1_corrupted_keeper_float_idle");
    var_da3dbbdf playloopsound("zmb_ee_resurrect_keeper_notghost_lp", 2);
    namespace_97ddfc0d::function_cbf21c9d();
    level flag::wait_till("boss_fight_begin");
    callback::remove_on_connect(&namespace_744abc1c::function_fa7da172);
    level.var_8ef26cd9 = undefined;
    var_da3dbbdf delete();
    var_82a4f07b = struct::get("keeper_end_loc");
    var_82a4f07b notify(#"hash_629fd78d");
    var_293d02aa = getent("undercroft_pyramid", "targetname");
    var_293d02aa delete();
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_735d5e85
// Checksum 0xf0049fff, Offset: 0x29a0
// Size: 0x12c
function function_735d5e85() {
    self endon(#"disconnect");
    w_gravityspikes = getweapon("hero_gravityspikes_melee");
    wait(3);
    while (!self.b_gravity_trap_spikes_in_ground) {
        wait(0.05);
    }
    wait(0.5);
    if (function_434db4ff()) {
        self gadgetpowerset(self gadgetgetslot(w_gravityspikes), 0.25);
    }
    while (!isdefined(self.var_817ff1ed)) {
        wait(0.05);
    }
    wait(0.5);
    if (function_434db4ff()) {
        zm_weap_gravityspikes::function_6a359e28(self.var_817ff1ed, self);
    }
    wait(0.5);
    if (!level flag::get("boss_fight_completed")) {
        zm_weap_gravityspikes::function_6b90b056(self);
    }
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_434db4ff
// Checksum 0xba1a292d, Offset: 0x2ad8
// Size: 0xc6
function function_434db4ff() {
    var_4b421e18 = 0;
    var_ca36f4cf = getent("zone_boss_arena", "targetname");
    if (self.mdl_gravity_trap_spikes[0] istouching(var_ca36f4cf)) {
        var_4b421e18 = 1;
    }
    if (!level flag::get("boss_fight_completed")) {
        return true;
    }
    if (level flag::get("boss_fight_completed") && var_4b421e18) {
        return true;
    }
    return false;
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_2777756a
// Checksum 0xfb5ea869, Offset: 0x2ba8
// Size: 0x5c
function function_2777756a() {
    ai_zombie = self;
    e_attacker = ai_zombie waittill(#"death");
    if (isplayer(e_attacker)) {
        [[ level.hero_power_update ]](e_attacker, ai_zombie);
    }
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_77025eb5
// Checksum 0x8691a650, Offset: 0x2c10
// Size: 0x42e
function function_77025eb5(spot) {
    self endon(#"death");
    self.in_the_ground = 1;
    if (isdefined(self.anchor)) {
        self.anchor delete();
    }
    self.anchor = spawn("script_origin", self.origin);
    self.anchor.angles = self.angles;
    self linkto(self.anchor);
    if (!isdefined(spot.angles)) {
        spot.angles = (0, 0, 0);
    }
    anim_org = spot.origin;
    anim_ang = spot.angles;
    anim_org += (0, 0, 0);
    self ghost();
    self.anchor moveto(anim_org, 0.05);
    self.anchor waittill(#"movedone");
    target_org = zombie_utility::get_desired_origin();
    if (isdefined(target_org)) {
        anim_ang = vectortoangles(target_org - self.origin);
        self.anchor rotateto((0, anim_ang[1], 0), 0.05);
        self.anchor waittill(#"rotatedone");
    }
    self unlink();
    if (isdefined(self.anchor)) {
        self.anchor delete();
    }
    self thread zombie_utility::hide_pop();
    level thread zombie_utility::zombie_rise_death(self, spot);
    self clientfield::set("boss_zombie_rise_fx", 1);
    substate = 0;
    if (self.zombie_move_speed == "walk") {
        substate = randomint(2);
    } else if (self.zombie_move_speed == "run") {
        substate = 2;
    } else if (self.zombie_move_speed == "sprint") {
        substate = 3;
    }
    self orientmode("face default");
    if (isdefined(level.custom_riseanim)) {
        self animscripted("rise_anim", self.origin, spot.angles, level.custom_riseanim);
    } else {
        self animscripted("rise_anim", self.origin, spot.angles, "ai_zombie_traverse_ground_climbout_fast");
    }
    self zombie_shared::donotetracks("rise_anim", &zombie_utility::handle_rise_notetracks, spot);
    self notify(#"rise_anim_finished");
    spot notify(#"stop_zombie_rise_fx");
    self.in_the_ground = 0;
    self notify(#"risen", spot.script_string);
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_4e3a8fa9
// Checksum 0x2e73ac3b, Offset: 0x3048
// Size: 0x102
function function_4e3a8fa9(b_on) {
    if (b_on) {
        level clientfield::set("boss_wolf_howl_fx_change", 1);
        level clientfield::set("boss_gravity_spike_fx_change", 1);
        level._effect["dog_gib"] = "dlc1/castle/fx_ee_keeper_dog_explosion_zmb";
        level._effect["lightning_dog_spawn"] = "dlc1/castle/fx_ee_keeper_dog_lightning_buildup_zmb";
        return;
    }
    level clientfield::set("boss_wolf_howl_fx_change", 0);
    level clientfield::set("boss_gravity_spike_fx_change", 0);
    level._effect["dog_gib"] = "zombie/fx_dog_explosion_zmb";
    level._effect["lightning_dog_spawn"] = "zombie/fx_dog_lightning_buildup_zmb";
}

// Namespace namespace_b1bc995c
// Params 2, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_8fbf0a59
// Checksum 0x74a684e1, Offset: 0x3158
// Size: 0x4c
function function_8fbf0a59(var_9fb46041, var_c5b6daaa) {
    level thread function_5db6ba34(var_9fb46041);
    if (isdefined(var_c5b6daaa)) {
        level thread function_5db6ba34(var_c5b6daaa);
    }
}

// Namespace namespace_b1bc995c
// Params 3, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_7e9f0faf
// Checksum 0xd65305db, Offset: 0x31b0
// Size: 0x200
function function_7e9f0faf(var_4a032429, var_f759b439, var_610499ec) {
    if (!isdefined(var_4a032429)) {
        var_4a032429 = 0;
    }
    if (!isdefined(var_f759b439)) {
        var_f759b439 = 0;
    }
    if (!isdefined(var_610499ec)) {
        var_610499ec = 0;
    }
    a_valid_spawn_points = [];
    var_a55896c4 = [];
    var_1bbdbab3 = 0;
    if (var_4a032429) {
        var_a55896c4 = self.var_f7afb996;
    } else if (var_f759b439) {
        var_a55896c4 = self.var_9680b225;
    } else if (var_610499ec) {
        var_a55896c4 = self.var_772c4512;
    } else {
        var_a55896c4 = self.var_828cb4c9;
    }
    while (!a_valid_spawn_points.size) {
        foreach (s_spawn_point in var_a55896c4) {
            if (!isdefined(s_spawn_point.var_dabf8ae2) || var_1bbdbab3) {
                s_spawn_point.var_dabf8ae2 = 0;
            }
            if (!s_spawn_point.var_dabf8ae2) {
                array::add(a_valid_spawn_points, s_spawn_point, 0);
            }
        }
        if (!a_valid_spawn_points.size) {
            var_1bbdbab3 = 1;
        }
        wait(0.05);
    }
    s_spawn_point = array::random(a_valid_spawn_points);
    s_spawn_point.var_dabf8ae2 = 1;
    return s_spawn_point;
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_6f831a91
// Checksum 0x1ac49eea, Offset: 0x33b8
// Size: 0x1a4
function function_6f831a91() {
    level endon(#"hash_27340cf3");
    level.var_b366f2dc = 0;
    var_23a96e18 = getentarray("boss_gravity_spike_start_area", "targetname");
    foreach (var_ad2fc56d in var_23a96e18) {
        var_ad2fc56d.b_claimed = 0;
        var_ad2fc56d thread function_1c249965();
    }
    while (level.var_b366f2dc < level.players.size) {
        wait(0.05);
    }
    wait(0.75);
    foreach (player in level.players) {
        player.var_d725b0f2 = undefined;
    }
    level flag::set("boss_fight_begin");
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_1c249965
// Checksum 0x8c946b1d, Offset: 0x3568
// Size: 0x164
function function_1c249965() {
    level endon(#"hash_27340cf3");
    while (true) {
        foreach (player in level.players) {
            if (player istouching(self) && !isdefined(player.var_d725b0f2) && !self.b_claimed) {
                player.var_d725b0f2 = self;
                self thread function_73c15b91(player);
            }
            if (!player istouching(self) && player.var_d725b0f2 === self && !self.b_claimed) {
                player.var_d725b0f2 = undefined;
                player notify("boss_fight_ready_gravity_trap_tracker_end" + self.script_int);
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_73c15b91
// Checksum 0xfe5e721a, Offset: 0x36d8
// Size: 0x90
function function_73c15b91(player) {
    player endon("boss_fight_ready_gravity_trap_tracker_end" + self.script_int);
    level endon(#"hash_27340cf3");
    while (true) {
        player waittill(#"hash_f392f058");
        /#
        #/
        if (!self.b_claimed) {
            self.b_claimed = 1;
            level.var_b366f2dc++;
            player waittill(#"hash_c34ebaf4");
            self.b_claimed = 0;
            level.var_b366f2dc--;
        }
    }
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_71130ea
// Checksum 0xac00aae8, Offset: 0x3770
// Size: 0xa6e
function function_71130ea() {
    if (getdvarint("splitscreen_playerCount") > 2) {
        level.var_1a4b8a19 = 1;
    } else {
        level.var_1a4b8a19 = 0;
    }
    self.var_7e383b58 = 0;
    level.var_2b421938 = level.players.size;
    self.n_health = 10000 * level.var_2b421938;
    self.var_4bd4bce6 = 5000 * level.var_2b421938;
    if (level.round_number < 25) {
        level.var_74b7ddca = level.zombie_vars["zombie_health_start"];
        for (i = 2; i <= 25; i++) {
            if (i >= 10) {
                old_health = level.var_74b7ddca;
                level.var_74b7ddca += int(level.var_74b7ddca * level.zombie_vars["zombie_health_increase_multiplier"]);
                if (level.var_74b7ddca < old_health) {
                    level.var_74b7ddca = old_health;
                    break;
                }
                continue;
            }
            level.var_74b7ddca = int(level.var_74b7ddca + level.zombie_vars["zombie_health_increase"]);
        }
    } else {
        level.var_74b7ddca = level.zombie_health;
    }
    if (level.var_1a4b8a19) {
        level.var_de21b83b = level.var_74b7ddca * 0.75;
    } else {
        level.var_de21b83b = level.var_74b7ddca * 0.25;
    }
    var_8880cc35 = struct::get("boss_keeper", "targetname");
    self.var_40b46e43 = util::spawn_anim_model("c_zom_dlc1_keeper_archon_fb", var_8880cc35.origin, var_8880cc35.angles);
    self.var_40b46e43 enablelinkto();
    var_b444c5cd = self.var_40b46e43 gettagorigin("tag_aim");
    var_9f10f5d3 = self.var_40b46e43 gettagangles("tag_aim");
    self.var_e3d9917e = getent("boss_weak_point", "targetname");
    self.var_e3d9917e.origin = var_b444c5cd;
    self.var_e3d9917e.angles = var_9f10f5d3;
    self.var_e3d9917e.takedamage = 1;
    self.var_e3d9917e linkto(self.var_40b46e43, "tag_aim", (-7, 0, -15));
    self.var_64274e35 = getent("boss_weak_point_blocker", "targetname");
    self.var_64274e35.origin = var_b444c5cd;
    self.var_64274e35.angles = var_9f10f5d3;
    self.var_64274e35 linkto(self.var_40b46e43, "tag_aim", (-17, 0, -15));
    self.var_a2e9e777 = getent("boss_player_collision", "targetname");
    self.var_a2e9e777 linkto(self.var_40b46e43);
    self.var_83296dfe = getent("boss_dot_area", "targetname");
    self.var_83296dfe notsolid();
    self.var_83296dfe linkto(self.var_40b46e43);
    self.var_40b46e43 ghost();
    self.var_1e4b92cb = [];
    self.var_1e4b92cb = struct::get_array("boss_teleport_point", "targetname");
    s_temp = struct::get("boss_cast_elemental_storm_start", "targetname");
    self.var_266e735f = s_temp.origin;
    s_temp = struct::get("boss_cast_elemental_storm_end", "targetname");
    self.var_c7117234 = s_temp.origin;
    self.var_ee000bfc = 0;
    self.var_20f219b1 = getentarray("boss_skeleton_spawner", "targetname");
    foreach (var_42513f6e in self.var_20f219b1) {
        if (!isdefined(level.zombie_spawners)) {
            level.zombie_spawners = [];
        } else if (!isarray(level.zombie_spawners)) {
            level.zombie_spawners = array(level.zombie_spawners);
        }
        level.zombie_spawners[level.zombie_spawners.size] = var_42513f6e;
    }
    self.var_828cb4c9 = struct::get_array("boss_zombie_spawn_point", "targetname");
    self.var_f7afb996 = struct::get_array("boss_zombie_spawn_point_central", "targetname");
    var_911ceae0 = struct::get_array("boss_zombie_spawn_point_crawl", "targetname");
    foreach (s_struct in var_911ceae0) {
        if (!isdefined(self.var_828cb4c9)) {
            self.var_828cb4c9 = [];
        } else if (!isarray(self.var_828cb4c9)) {
            self.var_828cb4c9 = array(self.var_828cb4c9);
        }
        self.var_828cb4c9[self.var_828cb4c9.size] = s_struct;
        if (!isdefined(self.var_f7afb996)) {
            self.var_f7afb996 = [];
        } else if (!isarray(self.var_f7afb996)) {
            self.var_f7afb996 = array(self.var_f7afb996);
        }
        self.var_f7afb996[self.var_f7afb996.size] = s_struct;
    }
    self.var_cbe1d929 = getentarray("special_dog_spawner", "targetname");
    self.var_9680b225 = struct::get_array("boss_direwolf_spawn_point", "targetname");
    self.var_9680b225 = array::sort_by_script_int(self.var_9680b225, 1);
    self.var_772c4512 = function_1466b3f1();
    self.var_92904d31 = [];
    if (level.var_1a4b8a19) {
        var_d7ca411c = 3;
    } else {
        var_d7ca411c = 16;
    }
    for (i = 0; i < var_d7ca411c; i++) {
        self.var_92904d31[i] = util::spawn_anim_model("p7_fxanim_zm_bow_rune_prison_red_mod", (-3008, 6976, -1215), (0, 0, 0));
        self.var_92904d31[i].takedamage = 1;
        self.var_92904d31[i].b_spawned = 0;
    }
    self.var_29204bf = [];
    self.var_77e69b0f = [];
    self.var_8016f006 = [];
    wait(0.05);
    self.var_40b46e43 clientfield::set("boss_fx", 1);
    self.var_40b46e43 clientfield::set("boss_weak_point_shader", 1);
    function_4e3a8fa9(1);
    self function_a86bf815();
    zm_spawner::register_zombie_death_event_callback(&function_369525ff);
    /#
        level notify(#"hash_7ba633bf");
    #/
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_a86bf815
// Checksum 0x148a9d5, Offset: 0x41e8
// Size: 0x2b4
function function_a86bf815() {
    a_players = getplayers();
    n_player_modifier = 1;
    switch (a_players.size) {
    case 0:
    case 1:
        n_player_modifier = 1;
        break;
    case 2:
        n_player_modifier = 1.33;
        break;
    case 3:
        n_player_modifier = 1.66;
        break;
    case 4:
        n_player_modifier = 2;
        break;
    }
    var_485a2c2c = level.var_74b7ddca / level.zombie_vars["zombie_health_start"];
    self.var_53cc405d = int(n_player_modifier * (level.var_f1419b9d + level.var_a1748a68 * var_485a2c2c));
    self.var_df387ccd = int(n_player_modifier * (level.var_fa14536d + level.var_1a5bb9d8 * var_485a2c2c));
    self.var_79d56f1b = int(n_player_modifier * (level.var_79d56f1b + level.var_a1943286 * var_485a2c2c));
    self.var_c31f5c1f = int(n_player_modifier * (level.var_c31f5c1f + level.var_9684c99e * var_485a2c2c));
    self.var_2cbc5b59 = int(n_player_modifier * (level.var_3f1bf221 + level.var_158234c * var_485a2c2c));
    self.var_53cc405d = namespace_48131a3f::function_26beb37e(self.var_53cc405d, 17500, n_player_modifier);
    self.var_df387ccd = namespace_48131a3f::function_26beb37e(self.var_df387ccd, 16000, n_player_modifier);
    self.var_79d56f1b = namespace_48131a3f::function_26beb37e(self.var_79d56f1b, 7500, n_player_modifier);
    self.var_c31f5c1f = namespace_48131a3f::function_26beb37e(self.var_c31f5c1f, 5000, n_player_modifier);
    self.var_2cbc5b59 = namespace_48131a3f::function_26beb37e(self.var_2cbc5b59, 3500, n_player_modifier);
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_1466b3f1
// Checksum 0xb09b6c50, Offset: 0x44a8
// Size: 0x774
function function_1466b3f1() {
    var_df15467c = struct::get_array("boss_mech_spawn_point", "targetname");
    for (i = 0; i < var_df15467c.size; i++) {
        switch (i) {
        case 0:
            var_df15467c[i].origin = getclosestpointonnavmesh((-2940, 7476, -255), -128);
            var_df15467c[i].origin = var_df15467c[i].origin + (0, 0, 7);
            break;
        case 1:
            var_df15467c[i].origin = getclosestpointonnavmesh((-2789, 7578, -255), -128);
            var_df15467c[i].origin = var_df15467c[i].origin + (0, 0, 7);
            break;
        case 2:
            var_df15467c[i].origin = getclosestpointonnavmesh((-2577, 7341, -255), -128);
            var_df15467c[i].origin = var_df15467c[i].origin + (0, 0, 7);
            break;
        case 3:
            var_df15467c[i].origin = getclosestpointonnavmesh((-2479, 7134, -255), -128);
            var_df15467c[i].origin = var_df15467c[i].origin + (0, 0, 7);
            break;
        case 4:
            var_df15467c[i].origin = getclosestpointonnavmesh((-2548, 6958, -255), -128);
            var_df15467c[i].origin = var_df15467c[i].origin + (0, 0, 7);
            break;
        case 5:
            var_df15467c[i].origin = getclosestpointonnavmesh((-2577, 6636, -255), -128);
            var_df15467c[i].origin = var_df15467c[i].origin + (0, 0, 7);
            break;
        case 6:
            var_df15467c[i].origin = getclosestpointonnavmesh((-2711, 6442, -255), -128);
            var_df15467c[i].origin = var_df15467c[i].origin + (0, 0, 7);
            break;
        case 7:
            var_df15467c[i].origin = getclosestpointonnavmesh((-3127, 6403, -255), -128);
            var_df15467c[i].origin = var_df15467c[i].origin + (0, 0, 7);
            break;
        case 8:
            var_df15467c[i].origin = getclosestpointonnavmesh((-3369, 6559, -255), -128);
            var_df15467c[i].origin = var_df15467c[i].origin + (0, 0, 7);
            break;
        case 9:
            var_df15467c[i].origin = getclosestpointonnavmesh((-3499, 6644, -255), -128);
            var_df15467c[i].origin = var_df15467c[i].origin + (0, 0, 7);
            break;
        case 10:
            var_df15467c[i].origin = getclosestpointonnavmesh((-3617, 6853, -255), -128);
            var_df15467c[i].origin = var_df15467c[i].origin + (0, 0, 7);
            break;
        case 11:
            var_df15467c[i].origin = getclosestpointonnavmesh((-3513, 7013, -255), -128);
            var_df15467c[i].origin = var_df15467c[i].origin + (0, 0, 7);
            break;
        case 12:
            var_df15467c[i].origin = getclosestpointonnavmesh((-3438, 7346, -255), -128);
            var_df15467c[i].origin = var_df15467c[i].origin + (0, 0, 7);
            break;
        case 13:
            var_df15467c[i].origin = getclosestpointonnavmesh((-3230, 7509, -255), -128);
            var_df15467c[i].origin = var_df15467c[i].origin + (0, 0, 7);
            break;
        default:
            break;
        }
    }
    return var_df15467c;
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_4bea595
// Checksum 0x37656d01, Offset: 0x4c28
// Size: 0xe0
function function_4bea595() {
    level endon(#"hash_e991baf");
    level endon(#"_zombie_game_over");
    self endon(#"bleed_out");
    self endon(#"disconnect");
    var_67f6c267 = getent("boss_dot_area", "targetname");
    while (!level flag::get("boss_fight_completed")) {
        if (self istouching(var_67f6c267) && !self laststand::player_is_in_laststand()) {
            self dodamage(5, self.origin);
        }
        wait(0.25);
    }
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_4f5e3970
// Checksum 0xf8b78d21, Offset: 0x4d10
// Size: 0x350
function function_4f5e3970() {
    level endon(#"hash_e991baf");
    level thread function_5db6ba34();
    a_s_temp = struct::get_array("boss_start_tele_point", "targetname");
    var_7fcbf214 = array::sort_by_script_int(a_s_temp, 1);
    foreach (player in level.players) {
        player thread function_735d5e85();
        v_pos = var_7fcbf214[player.characterindex].origin;
        v_angles = var_7fcbf214[player.characterindex].angles;
        player zm_utility::create_streamer_hint(v_pos, v_angles, 0.25);
        player playrumbleonentity("zm_castle_pulsing_rumble");
    }
    wait(0.5);
    level thread lui::screen_flash(0.5, 2, 1, 1, "white");
    level clientfield::set("sndBossBattle", 1);
    wait(1.5);
    foreach (player in level.players) {
        v_pos = var_7fcbf214[player.characterindex].origin;
        v_angles = var_7fcbf214[player.characterindex].angles;
        player setorigin(v_pos);
        player setplayerangles(v_angles);
        player clientfield::increment_to_player("player_snow_fx_off");
        player zm_utility::clear_streamer_hint();
    }
    var_64b78a2b = function_1261fd50();
    if (var_64b78a2b) {
    }
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_77b20649
// Checksum 0xa284f936, Offset: 0x5068
// Size: 0x48c
function boss_fight_complete() {
    a_s_temp = struct::get_array("boss_complete_tele_point", "targetname");
    var_7fcbf214 = array::sort_by_script_int(a_s_temp, 1);
    foreach (player in level.players) {
        v_pos = var_7fcbf214[player.characterindex].origin;
        v_angles = var_7fcbf214[player.characterindex].angles;
        player zm_utility::create_streamer_hint(v_pos, v_angles, 0.25);
    }
    self.var_40b46e43 thread function_a1658f19("ai_zm_dlc1_archon_float_cleanse_ending");
    level clientfield::set("sndBossBattle", 0);
    array::run_all(level.players, &playrumbleonentity, "zm_castle_boss_cleanse_ending");
    wait(8);
    level flag::clear("low_grav_on");
    exploder::stop_exploder("lgt_low_gravity_on");
    level clientfield::set("snd_low_gravity_state", 0);
    foreach (player in level.players) {
        player playrumbleonentity("zm_castle_pulsing_rumble");
    }
    level thread lui::screen_flash(1, 6, 3, 1, "white");
    wait(3);
    foreach (player in level.players) {
        v_pos = var_7fcbf214[player.characterindex].origin;
        v_angles = var_7fcbf214[player.characterindex].angles;
        player thread function_8ac50ad(v_pos, v_angles);
    }
    zm_spawner::deregister_zombie_death_event_callback(&function_369525ff);
    function_4e3a8fa9(0);
    wait(3);
    level thread namespace_97ddfc0d::function_64505195();
    level flag::set("boss_fight_completed");
    wait(25);
    level flag::set("zombie_drop_powerups");
    if (!level flag::get("sent_rockets_to_the_moon")) {
        level flag::set("spawn_zombies");
    }
}

// Namespace namespace_b1bc995c
// Params 2, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_8ac50ad
// Checksum 0x3214dd24, Offset: 0x5500
// Size: 0x9c
function function_8ac50ad(v_pos, v_angles) {
    wait(1);
    self clientfield::increment_to_player("player_snow_fx");
    self thread function_735d5e85();
    self setorigin(v_pos);
    self setplayerangles(v_angles);
    self zm_utility::clear_streamer_hint();
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_1690ddb0
// Checksum 0x8547f6f3, Offset: 0x55a8
// Size: 0x152
function function_1690ddb0() {
    self.var_40b46e43 delete();
    self.var_e3d9917e delete();
    foreach (var_b30aea81 in self.var_92904d31) {
        if (isdefined(var_b30aea81)) {
            var_b30aea81 delete();
        }
    }
    foreach (var_4a243bdd in self.var_29204bf) {
        if (isdefined(var_4a243bdd)) {
            var_4a243bdd delete();
        }
    }
}

// Namespace namespace_b1bc995c
// Params 2, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_a1658f19
// Checksum 0xe291ea4, Offset: 0x5708
// Size: 0x7c
function function_a1658f19(str_anim, var_be98b74b) {
    if (!isdefined(var_be98b74b)) {
        var_be98b74b = "ai_zm_dlc1_archon_float_idle";
    }
    self notify(#"hash_26fd8ff7");
    if (isdefined(str_anim)) {
        self animation::play(str_anim);
    }
    if (isdefined(self)) {
        self thread animation::play(var_be98b74b);
    }
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_5db6ba34
// Checksum 0x7d4f93f4, Offset: 0x5790
// Size: 0x3be
function function_5db6ba34(var_dcc4bd3d) {
    wait(0.5);
    a_ai_zombies = [];
    if (isdefined(var_dcc4bd3d)) {
        a_ai_zombies = var_dcc4bd3d;
    } else {
        a_ai_zombies = getaiteamarray(level.zombie_team);
    }
    var_6b1085eb = [];
    foreach (ai_zombie in a_ai_zombies) {
        if (!isdefined(ai_zombie)) {
            continue;
        }
        if (!isalive(ai_zombie)) {
            continue;
        }
        ai_zombie.no_powerups = 1;
        ai_zombie.deathpoints_already_given = 1;
        if (isdefined(ai_zombie.ignore_nuke) && ai_zombie.ignore_nuke) {
            continue;
        }
        if (isdefined(ai_zombie.marked_for_death) && ai_zombie.marked_for_death) {
            continue;
        }
        if (isdefined(ai_zombie.nuke_damage_func)) {
            ai_zombie thread [[ ai_zombie.nuke_damage_func ]]();
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(ai_zombie)) {
            continue;
        }
        ai_zombie.marked_for_death = 1;
        ai_zombie.nuked = 1;
        var_6b1085eb[var_6b1085eb.size] = ai_zombie;
    }
    foreach (i, var_f92b3d80 in var_6b1085eb) {
        wait(randomfloatrange(0.1, 0.2));
        if (!isdefined(var_f92b3d80)) {
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(var_f92b3d80)) {
            continue;
        }
        if (i < 5 && !(isdefined(var_f92b3d80.isdog) && var_f92b3d80.isdog)) {
            var_f92b3d80 thread zombie_death::flame_death_fx();
        }
        if (!(isdefined(var_f92b3d80.isdog) && var_f92b3d80.isdog)) {
            if (!(isdefined(var_f92b3d80.no_gib) && var_f92b3d80.no_gib)) {
                var_f92b3d80 zombie_utility::zombie_head_gib();
            }
        }
        var_f92b3d80 dodamage(var_f92b3d80.health, var_f92b3d80.origin);
        if (!level flag::get("special_round")) {
            level.zombie_total++;
        }
    }
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_1261fd50
// Checksum 0xcfe9c4c, Offset: 0x5b58
// Size: 0x3da
function function_1261fd50() {
    level endon(#"_zombie_game_over");
    level endon(#"hash_e32fa83");
    var_1e84d44a = struct::get("boss_start_point", "targetname");
    self function_1b20ff86(var_1e84d44a.origin);
    wait(1);
    level thread namespace_97ddfc0d::function_6b44bc05();
    self thread function_e2f41bf2();
    wait(1);
    self notify(#"hash_ff6409a6");
    array::run_all(level.players, &playrumbleonentity, "zm_castle_boss_roar");
    self.var_40b46e43 function_a1658f19("ai_zm_dlc1_archon_float_roar");
    self.var_40b46e43 playsound("vox_keeper_round_1");
    self function_ca8445e1();
    wait(3);
    self.var_7e383b58 = 1;
    while (self.var_7e383b58 < 6) {
        /#
            if (level flag::get("boss_fx")) {
                self.var_7e383b58 = 3;
            }
            if (level flag::get("boss_fx")) {
                self.var_7e383b58 = 4;
            }
            if (level flag::get("boss_fx")) {
                self.var_7e383b58 = 5;
            }
        #/
        switch (self.var_7e383b58) {
        case 1:
            self thread function_96db213f();
            self function_28bb5727(0);
            level thread zm_powerups::specific_powerup_drop("full_ammo", self.var_c7117234);
            break;
        case 3:
            self thread function_96db213f();
            self function_28bb5727(1);
            level thread zm_powerups::specific_powerup_drop("full_ammo", self.var_c7117234);
            break;
        case 5:
            self thread function_96db213f();
            self function_28bb5727(0);
            break;
        case 2:
        case 4:
            self function_1dddcbf0();
            level thread zm_powerups::specific_powerup_drop("full_ammo", self.var_c7117234);
            break;
        }
        if (level flag::get("boss_completed_early")) {
            self notify(#"hash_ed87af95");
            return true;
        }
        self notify(#"hash_ed87af95");
        self.var_40b46e43 playsound("vox_keeper_round_" + self.var_7e383b58 + 1);
        wait(3);
        self.var_7e383b58++;
    }
    return false;
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_1b20ff86
// Checksum 0x871ccb28, Offset: 0x5f40
// Size: 0x17c
function function_1b20ff86(var_5ed78a5f) {
    self.var_a2e9e777 solid();
    self.var_40b46e43.origin = var_5ed78a5f;
    var_91930983 = array::random(level.activeplayers);
    angle = vectortoangles(var_91930983.origin - self.var_40b46e43.origin);
    self.var_40b46e43.angles = (self.var_40b46e43.angles[0], angle[1], self.var_40b46e43.angles[2]);
    self.var_40b46e43 clientfield::increment("boss_teleport_fx", 1);
    self.var_40b46e43 playsound("zmb_keeper_spawn_in");
    wait(0.5);
    self.var_40b46e43 show();
    self.var_e3d9917e solid();
    self.var_40b46e43 function_a1658f19();
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_ca8445e1
// Checksum 0xd5c492f6, Offset: 0x60c8
// Size: 0xe4
function function_ca8445e1() {
    self.var_a2e9e777 notsolid();
    self.var_e3d9917e notsolid();
    self.var_40b46e43 clientfield::increment("boss_teleport_fx", 1);
    self.var_40b46e43 playsound("zmb_keeper_spawn_out");
    wait(0.5);
    self.var_40b46e43 ghost();
    self.var_40b46e43 animation::stop();
    self.var_40b46e43.origin -= (0, 0, 500);
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_e3ea9055
// Checksum 0xdb63f155, Offset: 0x61b8
// Size: 0x2c
function function_e3ea9055(var_70f504b7) {
    if (!isdefined(var_70f504b7)) {
        var_70f504b7 = 0;
    }
    if (!var_70f504b7) {
        wait(6);
    }
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_28bb5727
// Checksum 0xfea45654, Offset: 0x61f0
// Size: 0x9d0
function function_28bb5727(var_4a14cd40) {
    level endon(#"_zombie_game_over");
    if (!isdefined(self.var_41c1a53f)) {
        self.var_41c1a53f = [];
    }
    switch (self.var_7e383b58) {
    case 1:
        var_e516b508 = 3;
        if (level.var_1a4b8a19) {
            self.var_41c1a53f[0] = &function_e3ea9055;
            self.var_41c1a53f[1] = &function_e3ea9055;
        } else {
            self.var_41c1a53f[0] = &function_74d4ae55;
            self.var_41c1a53f[1] = &function_f6b53f16;
        }
        break;
    case 3:
        self thread function_e2f41bf2();
        var_e516b508 = 4;
        if (level.var_1a4b8a19) {
            self.var_41c1a53f[2] = &function_e3ea9055;
        } else {
            self.var_41c1a53f[2] = &function_45988f28;
        }
        self.var_41c1a53f[3] = &function_db1c6f68;
        self.n_health += self.var_4bd4bce6;
        /#
            if (level flag::get("boss_fx")) {
                if (level.var_1a4b8a19) {
                    self.var_41c1a53f[0] = &function_e3ea9055;
                    self.var_41c1a53f[1] = &function_e3ea9055;
                } else {
                    self.var_41c1a53f[0] = &function_74d4ae55;
                    self.var_41c1a53f[1] = &function_f6b53f16;
                }
                level flag::clear("boss_fx");
            }
        #/
        break;
    case 5:
        var_e516b508 = 5;
        self thread function_e2f41bf2();
        self.n_health += self.var_4bd4bce6;
        /#
            if (level flag::get("boss_fx")) {
                if (level.var_1a4b8a19) {
                    self.var_41c1a53f[0] = &function_a77c2ade;
                    self.var_41c1a53f[1] = &function_93570bbc;
                    self.var_41c1a53f[2] = &function_93570bbc;
                } else {
                    self.var_41c1a53f[0] = &function_74d4ae55;
                    self.var_41c1a53f[1] = &function_f6b53f16;
                    self.var_41c1a53f[2] = &function_45988f28;
                }
                self.var_41c1a53f[3] = &function_db1c6f68;
                level flag::clear("boss_fx");
            }
        #/
        break;
    }
    if (self.var_7e383b58 == 5) {
        var_cfe6cb9 = [];
    }
    self.var_42433bc = 0;
    var_19427a0d = self.var_41c1a53f.size;
    var_bb2bcd1a = self.var_41c1a53f.size;
    var_48d25fcc = 0;
    while (!var_48d25fcc) {
        for (i = 0; i < var_e516b508; i++) {
            if (i == 3 && self.var_7e383b58 == 5 && !level.var_1a4b8a19 && level.var_2b421938 > 1) {
                var_cfe6cb9 = array::remove_dead(var_cfe6cb9, 0);
                var_cfe6cb9 = array::remove_undefined(var_cfe6cb9, 0);
                if (var_cfe6cb9.size < 1) {
                    ai_zombie = self function_8a46476();
                    if (!isdefined(var_cfe6cb9)) {
                        var_cfe6cb9 = [];
                    } else if (!isarray(var_cfe6cb9)) {
                        var_cfe6cb9 = array(var_cfe6cb9);
                    }
                    var_cfe6cb9[var_cfe6cb9.size] = ai_zombie;
                }
            }
            while (!isdefined(self.var_551d8fa5)) {
                n_rand = randomint(self.var_1e4b92cb.size);
                self.var_551d8fa5 = self.var_1e4b92cb[n_rand].origin;
                if (isdefined(self.var_c5bd1959)) {
                    if (self.var_c5bd1959 == self.var_551d8fa5 || distancesquared(self.var_c5bd1959, self.var_551d8fa5) < 40000) {
                        self.var_551d8fa5 = undefined;
                        continue;
                    }
                }
                foreach (player in level.players) {
                    if (distancesquared(self.var_551d8fa5, player.origin) < 40000) {
                        self.var_551d8fa5 = undefined;
                        break;
                    }
                }
            }
            self function_1b20ff86(self.var_551d8fa5);
            self.var_c5bd1959 = self.var_551d8fa5;
            self.var_551d8fa5 = undefined;
            if (self.var_7e383b58 == 5) {
                self function_5faafe36();
            } else {
                while (var_19427a0d == var_bb2bcd1a) {
                    var_19427a0d = randomint(self.var_41c1a53f.size);
                    if (var_19427a0d == 3) {
                        if (level.var_1a4b8a19) {
                            var_90aa6e9 = 4;
                        } else {
                            var_90aa6e9 = 8;
                        }
                        self.var_77e69b0f = array::remove_dead(self.var_77e69b0f, 0);
                        self.var_77e69b0f = array::remove_undefined(self.var_77e69b0f, 0);
                        if (self.var_77e69b0f.size >= var_90aa6e9) {
                            var_19427a0d = var_bb2bcd1a;
                            continue;
                        }
                    }
                }
                self [[ self.var_41c1a53f[var_19427a0d] ]](0);
                var_bb2bcd1a = var_19427a0d;
            }
            wait(1);
            self function_ca8445e1();
            wait(2);
        }
        var_48d25fcc = self function_abdb4498();
        if (!var_48d25fcc) {
            self function_ca8445e1();
            if (self.n_health < 5000) {
                self.n_health = 5000;
            }
            continue;
        }
        level notify(#"hash_cd6f3cf8");
        if (isdefined(var_cfe6cb9)) {
            foreach (var_24c17812 in var_cfe6cb9) {
                if (isdefined(var_24c17812) && isalive(var_24c17812)) {
                    var_24c17812 kill();
                }
            }
        }
        level thread function_8fbf0a59(self.var_8016f006, self.var_77e69b0f);
        array::run_all(level.players, &playrumbleonentity, "zm_castle_boss_roar_pain");
        if (self.var_7e383b58 != 5) {
            self.var_40b46e43 function_a1658f19("ai_zm_dlc1_archon_float_roar", "ai_zm_dlc1_archon_float_idle");
        }
        wait(1);
    }
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_96db213f
// Checksum 0xe9e32caa, Offset: 0x6bc8
// Size: 0x80
function function_96db213f() {
    self endon(#"hash_ed87af95");
    self.var_40b46e43 endon(#"death");
    wait(randomintrange(7, 20));
    while (true) {
        self.var_40b46e43 playsound("vox_keeper_amb");
        wait(randomintrange(18, 40));
    }
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_e2f41bf2
// Checksum 0x76d23043, Offset: 0x6c50
// Size: 0x250
function function_e2f41bf2() {
    level endon(#"_zombie_game_over");
    level endon(#"hash_e991baf");
    level endon(#"hash_cd6f3cf8");
    switch (self.var_7e383b58) {
    case 0:
    case 1:
        var_67536a25 = 8 + level.var_2b421938;
        var_830f8197 = 3;
        break;
    case 3:
        var_67536a25 = 12 + level.var_2b421938;
        if (level.var_2b421938 == 1) {
            var_67536a25 -= 3;
        }
        var_830f8197 = 2.75;
        break;
    case 5:
        var_67536a25 = 14 + level.var_2b421938;
        if (level.var_2b421938 == 1) {
            var_67536a25 -= 3;
        }
        var_830f8197 = 2.5;
        break;
    }
    while (true) {
        self.var_8016f006 = array::remove_dead(self.var_8016f006, 0);
        self.var_8016f006 = array::remove_undefined(self.var_8016f006, 0);
        while (self.var_8016f006.size < var_67536a25) {
            s_spawn_point = self function_7e9f0faf(1);
            ai_zombie = function_20559b9e(s_spawn_point, self.var_20f219b1);
            if (isdefined(ai_zombie)) {
                array::add(self.var_8016f006, ai_zombie, 0);
            }
            self.var_8016f006 = array::remove_dead(self.var_8016f006, 0);
            self.var_8016f006 = array::remove_undefined(self.var_8016f006, 0);
        }
        self function_5e437060(var_830f8197);
    }
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_5e437060
// Checksum 0xf20cf886, Offset: 0x6ea8
// Size: 0x1c
function function_5e437060(n_time) {
    self endon(#"hash_ff6409a6");
    wait(n_time);
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_5faafe36
// Checksum 0x3fcade05, Offset: 0x6ed0
// Size: 0xda
function function_5faafe36() {
    var_731b9e03 = randomint(self.var_41c1a53f.size);
    for (var_fc76d161 = var_731b9e03; var_fc76d161 == 1 && (var_731b9e03 == 1 && (var_fc76d161 == var_731b9e03 || var_fc76d161 == 2) || var_731b9e03 == 2); var_fc76d161 = randomint(self.var_41c1a53f.size)) {
    }
    self thread function_be0acb1a(var_fc76d161);
    self [[ self.var_41c1a53f[var_731b9e03] ]]();
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_be0acb1a
// Checksum 0xe8a876fc, Offset: 0x6fb8
// Size: 0x2e
function function_be0acb1a(n_index) {
    wait(0.75);
    self thread [[ self.var_41c1a53f[n_index] ]](1);
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_1dddcbf0
// Checksum 0x2cff0706, Offset: 0x6ff0
// Size: 0x3f4
function function_1dddcbf0() {
    level endon(#"_zombie_game_over");
    level endon(#"hash_e991baf");
    /#
        if (level flag::get("boss_fx")) {
            if (level.var_1a4b8a19) {
                self.var_41c1a53f[0] = &function_e3ea9055;
                self.var_41c1a53f[1] = &function_e3ea9055;
            } else {
                self.var_41c1a53f[0] = &function_74d4ae55;
                self.var_41c1a53f[1] = &function_f6b53f16;
            }
            level flag::clear("boss_fx");
        }
    #/
    self function_ca8445e1();
    var_bc61c0c2 = [];
    var_c0fca9d = 0;
    var_ee22b3cb = 0;
    if (self.var_7e383b58 == 2) {
        var_466a9f43 = 3;
        var_740f7270 = 2;
        var_39253c05 = 2 + level.var_2b421938;
    } else {
        var_466a9f43 = 2;
        var_740f7270 = 2;
        var_39253c05 = 4 + level.var_2b421938;
        if (level.var_2b421938 == 1) {
            var_39253c05 -= 1;
        }
    }
    self thread function_10739686(var_466a9f43);
    var_bd3370a1 = gettime() / 1000;
    var_5f67a965 = 0;
    while (true) {
        n_time_current = gettime() / 1000;
        var_5f67a965 = n_time_current - var_bd3370a1;
        var_bc61c0c2 = array::remove_dead(var_bc61c0c2, 0);
        var_bc61c0c2 = array::remove_undefined(var_bc61c0c2, 0);
        if (var_c0fca9d >= var_39253c05 && var_bc61c0c2.size <= 0) {
            break;
        }
        if (!var_ee22b3cb && var_c0fca9d >= int(var_39253c05 / 2) && var_bc61c0c2.size <= int(var_740f7270 / 2)) {
            level thread zm_powerups::specific_powerup_drop("full_ammo", self.var_c7117234);
            var_ee22b3cb = 1;
        }
        if (var_5f67a965 >= 8) {
            while (var_c0fca9d < var_39253c05 && var_bc61c0c2.size < var_740f7270) {
                ai_zombie = self function_8a46476();
                array::add(var_bc61c0c2, ai_zombie, 0);
                var_c0fca9d++;
                wait(randomfloatrange(0.25, 0.5));
            }
            var_5f67a965 = 0;
        }
        wait(0.05);
    }
    level notify(#"hash_c1965039");
    level thread function_8fbf0a59(self.var_c660deed);
    wait(3);
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_10739686
// Checksum 0x11a5bc0d, Offset: 0x73f0
// Size: 0x162
function function_10739686(var_466a9f43) {
    level endon(#"hash_c1965039");
    level endon(#"_zombie_game_over");
    if (!isdefined(self.var_c660deed)) {
        self.var_c660deed = [];
    }
    var_f9b87179 = 18 + level.var_2b421938;
    if (level.var_2b421938 == 1) {
        var_f9b87179 -= 3;
    }
    while (true) {
        self.var_c660deed = array::remove_dead(self.var_c660deed, 0);
        self.var_c660deed = array::remove_undefined(self.var_c660deed, 0);
        while (self.var_c660deed.size < var_f9b87179) {
            s_spawn_point = self function_7e9f0faf();
            ai_zombie = function_20559b9e(s_spawn_point, self.var_20f219b1);
            if (isdefined(ai_zombie)) {
                array::add(self.var_c660deed, ai_zombie, 0);
            }
            wait(0.05);
        }
        wait(var_466a9f43);
    }
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_abdb4498
// Checksum 0x7d785874, Offset: 0x7560
// Size: 0x3c0
function function_abdb4498() {
    /#
    #/
    level flag::set("boss_elemental_storm_cast_in_progress");
    self.var_cc5c4782 = 0;
    var_a7ddd99 = getent("boss_gravity_spike_stun_area", "targetname");
    foreach (player in level.players) {
        player.var_7b3316ec = 0;
        self thread function_e20da5e0(player, var_a7ddd99);
    }
    self function_1b20ff86(self.var_266e735f);
    self.var_40b46e43 thread clientfield::set("boss_elemental_storm_cast_fx", 1);
    self.var_a2e9e777 notsolid();
    self notify(#"hash_ff6409a6");
    self.var_40b46e43 function_a1658f19("ai_zm_dlc1_archon_float_spell_elemental_charge_intro", "ai_zm_dlc1_archon_float_spell_elemental_charge_loop");
    self.var_40b46e43 thread clientfield::set("boss_elemental_storm_cast_fx", 0);
    level flag::clear("boss_elemental_storm_cast_in_progress");
    level notify(#"hash_adcabea1");
    if (self.var_cc5c4782 > 0) {
        var_12b659e0 = [];
        foreach (player in level.players) {
            if (!isdefined(var_12b659e0)) {
                var_12b659e0 = [];
            } else if (!isarray(var_12b659e0)) {
                var_12b659e0 = array(var_12b659e0);
            }
            var_12b659e0[var_12b659e0.size] = player.mdl_gravity_trap_fx_source;
            if (player.var_7b3316ec) {
                player gadgetpowerset(0, 0);
            }
        }
        n_index = randomint(var_12b659e0.size);
        var_12b659e0[n_index] clientfield::set("boss_elemental_storm_stunned_spikes_fx", 1);
        var_48d25fcc = self boss_stunned();
        var_12b659e0[n_index] clientfield::set("boss_elemental_storm_stunned_spikes_fx", 0);
    } else {
        self function_39a8c4bd();
        var_48d25fcc = 0;
    }
    return var_48d25fcc;
}

// Namespace namespace_b1bc995c
// Params 2, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_e20da5e0
// Checksum 0xcd477264, Offset: 0x7928
// Size: 0xd4
function function_e20da5e0(player, var_a7ddd99) {
    level endon(#"hash_adcabea1");
    player waittill(#"hash_f392f058");
    if (player istouching(var_a7ddd99)) {
        /#
        #/
        self.var_cc5c4782++;
        player.var_7b3316ec = 1;
        player waittill(#"destroy_ground_spikes");
        self.var_cc5c4782--;
        player.var_7b3316ec = 0;
    }
    if (level flag::get("boss_elemental_storm_cast_in_progress")) {
        self thread function_e20da5e0(player, var_a7ddd99);
    }
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_dc38a37e
// Checksum 0xd157b9c3, Offset: 0x7a08
// Size: 0x37e
function boss_stunned() {
    /#
    #/
    n_wait = getanimlength("ai_zm_dlc1_archon_float_spell_elemental_pain_hitspike");
    self.var_40b46e43 function_a1658f19("ai_zm_dlc1_archon_float_spell_elemental_pain_hitspike", "ai_zm_dlc1_archon_float_spell_elemental_pain_hitspike_idle");
    self.var_40b46e43 clientfield::set("boss_elemental_storm_stunned_keeper_fx", 1);
    self.var_40b46e43 clientfield::set("boss_weak_point_shader", 0);
    level flag::set("boss_stunned");
    self.var_e3d9917e solid();
    self thread function_eda57e8b();
    n_time_started = gettime() / 1000;
    n_time_elapsed = 0;
    while (level flag::exists("world_is_paused") && (n_time_elapsed < 8 || level flag::get("world_is_paused"))) {
        n_time_current = gettime() / 1000;
        n_time_elapsed = n_time_current - n_time_started;
        if (self.var_42433bc >= self.n_health) {
            /#
            #/
            if (level flag::exists("world_is_paused")) {
                if (level flag::get("world_is_paused")) {
                    level flag::wait_till_clear("world_is_paused");
                }
            }
            if (self.var_ee000bfc >= 1000000) {
                level flag::set("boss_completed_early");
            }
            level flag::clear("boss_stunned");
            self.var_40b46e43 clientfield::set("boss_elemental_storm_stunned_keeper_fx", 0);
            self.var_40b46e43 clientfield::set("boss_weak_point_shader", 1);
            self.var_40b46e43 playsound("zmb_keeper_damaged");
            return true;
        }
        wait(0.05);
    }
    level flag::clear("boss_stunned");
    self.var_40b46e43 function_a1658f19("ai_zm_dlc1_archon_float_spell_elemental_pain_hitspike_2_float");
    self.var_ee000bfc -= self.var_42433bc;
    wait(0.1);
    self.var_40b46e43 clientfield::set("boss_elemental_storm_stunned_keeper_fx", 0);
    self.var_40b46e43 clientfield::set("boss_weak_point_shader", 1);
    return false;
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_eda57e8b
// Checksum 0xe959a956, Offset: 0x7d90
// Size: 0x80
function function_eda57e8b() {
    while (level flag::get("boss_stunned")) {
        n_damage, e_attacker = self.var_e3d9917e waittill(#"damage");
        self.var_42433bc += n_damage;
        self.var_ee000bfc += n_damage;
    }
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_39a8c4bd
// Checksum 0x42d1d092, Offset: 0x7e18
// Size: 0x2f4
function function_39a8c4bd() {
    level endon(#"hash_e991baf");
    /#
    #/
    self.var_40b46e43 thread function_a1658f19("ai_zm_dlc1_archon_float_spell_elemental_charge_outro");
    wait(1);
    exploder::exploder("fxexp_605");
    exploder::exploder("fxexp_606");
    self.var_40b46e43 playsound("zmb_keeper_storm_explo");
    var_9a7102d5 = getentarray("boss_elemental_storm_safe_area", "targetname");
    n_time_started = gettime() / 1000;
    n_time_elapsed = 0;
    while (n_time_elapsed < 2) {
        n_time_current = gettime() / 1000;
        n_time_elapsed = n_time_current - n_time_started;
        foreach (player in level.players) {
            var_e9696e99 = 0;
            foreach (var_9b5a3c3a in var_9a7102d5) {
                if (player istouching(var_9b5a3c3a)) {
                    var_e9696e99 = 1;
                    break;
                }
            }
            if (!var_e9696e99 && !player laststand::player_is_in_laststand()) {
                player dodamage(player.health + 666, player.origin);
            }
        }
        wait(0.05);
    }
    exploder::exploder_stop("fxexp_606");
    self.var_40b46e43 function_a1658f19();
    wait(0.5);
    self function_ca8445e1();
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_1b1fe540
// Checksum 0xcbd3e0a4, Offset: 0x8118
// Size: 0x64
function function_1b1fe540(var_70f504b7) {
    if (!var_70f504b7) {
        self.var_40b46e43 function_a1658f19("ai_zm_dlc1_archon_float_spell_demongate_charge_intro", "ai_zm_dlc1_archon_float_spell_demongate_charge_loop");
        self.var_40b46e43 clientfield::set("boss_demongate_cast_fx", 1);
    }
}

// Namespace namespace_b1bc995c
// Params 2, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_624b877f
// Checksum 0xc20ae433, Offset: 0x8188
// Size: 0xb2
function function_624b877f(var_70f504b7, var_39f71e77) {
    if (!var_70f504b7) {
        wait(var_39f71e77);
        self.var_40b46e43 clientfield::set("boss_demongate_cast_fx", 0);
        level notify(#"hash_152946de");
        self.var_40b46e43 function_a1658f19("ai_zm_dlc1_archon_float_spell_demongate_deploy");
        return;
    }
    var_d0d6e681 = getanimlength("ai_zm_dlc1_archon_float_spell_demongate_charge_intro");
    wait(var_d0d6e681);
    level notify(#"hash_152946de");
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_74d4ae55
// Checksum 0x8163126a, Offset: 0x8248
// Size: 0x214
function function_74d4ae55(var_70f504b7) {
    if (!isdefined(var_70f504b7)) {
        var_70f504b7 = 0;
    }
    /#
    #/
    self function_1b1fe540(var_70f504b7);
    switch (self.var_7e383b58) {
    case 1:
        var_33efb6fa = 2;
        var_39f71e77 = 1.5;
        break;
    case 3:
    case 5:
        var_33efb6fa = 3;
        var_39f71e77 = 1.25;
        break;
    }
    var_c4ceda7e = self.var_40b46e43 gettagorigin("tag_weapon_right");
    var_ea42537d = 0;
    for (i = 0; i < level.activeplayers.size; i++) {
        var_76ecb142 = 0;
        while (var_76ecb142 < var_33efb6fa) {
            if (!isdefined(self.var_29204bf[var_ea42537d])) {
                self thread function_36927923(var_c4ceda7e, level.activeplayers[i], var_ea42537d, undefined);
                var_76ecb142++;
            } else if (self.var_29204bf[var_ea42537d].b_spawned === 0) {
                self thread function_36927923(var_c4ceda7e, level.activeplayers[i], var_ea42537d, self.var_29204bf[var_ea42537d]);
                var_76ecb142++;
            }
            var_ea42537d++;
            if (var_ea42537d >= 24) {
                break;
            }
            wait(0.05);
        }
    }
    self function_624b877f(var_70f504b7, var_39f71e77);
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_a77c2ade
// Checksum 0x98142a31, Offset: 0x8468
// Size: 0x204
function function_a77c2ade(var_70f504b7) {
    if (!isdefined(var_70f504b7)) {
        var_70f504b7 = 0;
    }
    /#
    #/
    self function_1b1fe540(var_70f504b7);
    switch (self.var_7e383b58) {
    case 1:
        var_33efb6fa = 1;
        var_39f71e77 = 1.5;
        break;
    case 3:
    case 5:
        var_33efb6fa = 2;
        var_39f71e77 = 1.25;
        break;
    }
    var_c4ceda7e = self.var_40b46e43 gettagorigin("tag_weapon_right");
    var_ea42537d = 0;
    var_76ecb142 = 0;
    var_91930983 = array::random(level.activeplayers);
    while (var_76ecb142 < var_33efb6fa) {
        if (!isdefined(self.var_29204bf[var_ea42537d])) {
            self thread function_36927923(var_c4ceda7e, var_91930983, var_ea42537d, undefined);
            var_76ecb142++;
        } else if (self.var_29204bf[var_ea42537d].b_spawned === 0) {
            self thread function_36927923(var_c4ceda7e, var_91930983, var_ea42537d, self.var_29204bf[var_ea42537d]);
            var_76ecb142++;
        }
        var_ea42537d++;
        if (var_ea42537d >= 4) {
            break;
        }
        wait(0.05);
    }
    self function_624b877f(var_70f504b7, var_39f71e77);
}

// Namespace namespace_b1bc995c
// Params 4, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_36927923
// Checksum 0x7bea6aac, Offset: 0x8678
// Size: 0x39c
function function_36927923(var_67eb721b, var_ef983cc5, var_ea42537d, var_4a243bdd) {
    level waittill(#"hash_152946de");
    if (!isdefined(var_4a243bdd)) {
        var_ba9ce66e = util::spawn_anim_model("c_zom_chomper_boss", var_67eb721b, self.var_40b46e43.angles);
        var_ba9ce66e.e_mover = util::spawn_model("tag_origin", var_67eb721b, self.var_40b46e43.angles);
        var_ba9ce66e.e_mover enablelinkto();
        var_ba9ce66e linkto(var_ba9ce66e.e_mover);
        var_ba9ce66e.takedamage = 1;
        self.var_29204bf[var_ea42537d] = var_ba9ce66e;
    } else {
        var_ba9ce66e = var_4a243bdd;
        var_ba9ce66e.e_mover.origin = var_67eb721b;
        var_ba9ce66e show();
    }
    wait(0.05);
    var_ba9ce66e.e_mover thread scene::play("ai_zm_dlc1_chomper_boss_locomotion", var_ba9ce66e);
    var_ba9ce66e.b_spawned = 1;
    var_ba9ce66e solid();
    var_ba9ce66e clientfield::set("boss_demongate_chomper_fx", 1);
    var_ba9ce66e thread function_2cef3631();
    var_ba9ce66e.e_mover.origin += (0, 0, randomintrange(int(-51.2), int(51.2)));
    var_ba9ce66e.e_mover.angles = (var_ba9ce66e.e_mover.angles[0] + randomintrange(-30, 30), var_ba9ce66e.e_mover.angles[1] + randomintrange(-45, 45), var_ba9ce66e.e_mover.angles[2]);
    var_69a783ad = var_ba9ce66e.e_mover.origin + anglestoforward(var_ba9ce66e.e_mover.angles) * -128;
    var_ba9ce66e.e_mover moveto(var_69a783ad, 0.6, 0.36, 0.12);
    wait(0.6);
    var_ba9ce66e function_30e15c1e(var_ef983cc5);
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_e5dafbe3
// Checksum 0x69bf54b1, Offset: 0x8a20
// Size: 0xca
function function_e5dafbe3() {
    self.b_spawned = 0;
    self clientfield::set("boss_demongate_chomper_fx", 0);
    wait(0.25);
    self.e_mover moveto(self.origin, 0.1);
    wait(0.15);
    self.e_mover.origin = self.origin - (0, 0, 1000);
    self.e_mover scene::stop();
    self notsolid();
    self notify(#"hash_38c87755");
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_30e15c1e
// Checksum 0x8709749d, Offset: 0x8af8
// Size: 0xac
function function_30e15c1e(var_ef983cc5) {
    self endon(#"hash_38c87755");
    if (isdefined(var_ef983cc5) && !(isdefined(var_ef983cc5 laststand::player_is_in_laststand()) && var_ef983cc5 laststand::player_is_in_laststand())) {
        self.target_enemy = var_ef983cc5;
    } else {
        self function_7574c93e();
    }
    if (isdefined(self.target_enemy)) {
        self function_7398c59d();
        return;
    }
    self function_e5dafbe3();
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_7574c93e
// Checksum 0x41abbc93, Offset: 0x8bb0
// Size: 0x122
function function_7574c93e() {
    self endon(#"hash_38c87755");
    self.target_enemy = undefined;
    var_237d778f = arraysortclosest(level.players, self.origin, level.players.size);
    if (var_237d778f.size) {
        for (n_index = 0; !isdefined(self.target_enemy) && n_index < var_237d778f.size; n_index++) {
            if (isdefined(var_237d778f[n_index]) && !(isdefined(var_237d778f[n_index] laststand::player_is_in_laststand()) && var_237d778f[n_index] laststand::player_is_in_laststand()) && isalive(var_237d778f[n_index])) {
                var_9183256c = var_237d778f[n_index];
                self.target_enemy = var_9183256c;
                continue;
            }
        }
    }
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_7398c59d
// Checksum 0xbfdb0e2a, Offset: 0x8ce0
// Size: 0x12c
function function_7398c59d() {
    self endon(#"hash_38c87755");
    self function_9a0bf5f4();
    if (isdefined(self.target_enemy) && isalive(self.target_enemy) && !(isdefined(self.target_enemy laststand::player_is_in_laststand()) && self.target_enemy laststand::player_is_in_laststand())) {
        self clientfield::increment("boss_demongate_chomper_bite_fx", 1);
        if (level.var_1a4b8a19) {
            n_damage = 50;
        } else {
            n_damage = 25;
        }
        self.target_enemy dodamage(n_damage, self.origin, self);
    } else {
        self thread function_30e15c1e();
        return;
    }
    self function_e5dafbe3();
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_9a0bf5f4
// Checksum 0x97570d74, Offset: 0x8e18
// Size: 0x384
function function_9a0bf5f4() {
    self endon(#"hash_38c87755");
    var_b710c4e5 = self.target_enemy geteye();
    n_dist = distancesquared(self.origin, var_b710c4e5);
    var_e5e24312 = 1;
    var_4e26e12a = math::cointoss() ? 1 : -1;
    var_ba9ce66e = self.e_mover;
    while (n_dist > 2304 && isdefined(self.target_enemy) && isalive(self.target_enemy) && !(isdefined(self.target_enemy laststand::player_is_in_laststand()) && self.target_enemy laststand::player_is_in_laststand())) {
        var_b710c4e5 = self.target_enemy geteye();
        n_time = sqrt(n_dist) / -60;
        var_5d76b65c = 1 / var_e5e24312;
        var_ef096040 = (0, 0, 160) * var_5d76b65c;
        var_c5a0d28e = anglestoright(vectortoangles(var_b710c4e5 - var_ba9ce66e.origin)) * 256;
        var_c5a0d28e *= var_5d76b65c;
        var_c5a0d28e *= var_4e26e12a;
        var_74490e48 = var_b710c4e5 + var_c5a0d28e + var_ef096040;
        var_ba9ce66e moveto(var_74490e48, n_time, 0, 0);
        var_ba9ce66e rotateto(vectortoangles(var_74490e48 - var_ba9ce66e.origin), n_time * 0.5, n_time * 0.5);
        n_time *= 0.3;
        n_time = n_time < 0.1 ? 0.1 : n_time;
        wait(n_time);
        var_e5e24312++;
        n_dist = distancesquared(var_ba9ce66e.origin, var_b710c4e5);
    }
    if (isdefined(self.target_enemy) && isalive(self.target_enemy) && !(isdefined(self.target_enemy laststand::player_is_in_laststand()) && self.target_enemy laststand::player_is_in_laststand())) {
        var_ba9ce66e.origin = var_b710c4e5;
    }
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_2cef3631
// Checksum 0x40d2f7a9, Offset: 0x91a8
// Size: 0x8c
function function_2cef3631() {
    level endon(#"_zombie_game_over");
    self endon(#"hash_38c87755");
    for (var_b5f846f3 = 0; var_b5f846f3 < level.var_de21b83b; var_b5f846f3 += n_damage) {
        n_damage, e_attacker = self waittill(#"damage");
    }
    self function_e5dafbe3();
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_379868a6
// Checksum 0x87082a9c, Offset: 0x9240
// Size: 0x6e
function function_379868a6(var_70f504b7) {
    if (!var_70f504b7) {
        self.var_40b46e43 function_a1658f19("ai_zm_dlc1_archon_float_spell_runeprison_charge_intro", "ai_zm_dlc1_archon_float_spell_runeprison_charge_loop");
        return;
    }
    var_ab274f52 = getanimlength("ai_zm_dlc1_archon_float_spell_runeprison_charge_intro");
    wait(var_ab274f52);
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_78d09fbd
// Checksum 0xbe303c86, Offset: 0x92b8
// Size: 0xc2
function function_78d09fbd(var_70f504b7) {
    if (!var_70f504b7) {
        switch (self.var_7e383b58) {
        case 1:
            wait(1.5);
            break;
        case 3:
        case 5:
            wait(1.25);
            break;
        }
        self.var_40b46e43 function_a1658f19("ai_zm_dlc1_archon_float_spell_runeprison_deploy");
        level notify(#"hash_2d0d7f9c");
        return;
    }
    var_e6e938b9 = getanimlength("ai_zm_dlc1_archon_float_spell_runeprison_deploy");
    wait(var_e6e938b9);
    level notify(#"hash_2d0d7f9c");
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_f6b53f16
// Checksum 0x23fdec5f, Offset: 0x9388
// Size: 0x41c
function function_f6b53f16(var_70f504b7) {
    if (!isdefined(var_70f504b7)) {
        var_70f504b7 = 0;
    }
    /#
    #/
    self function_379868a6(var_70f504b7);
    var_eafe595f = 0;
    for (i = 0; i < level.players.size; i++) {
        v_target = getclosestpointonnavmesh(level.players[i].origin + (128, 128, 0), 384);
        if (isdefined(v_target)) {
            if (!self.var_92904d31[var_eafe595f].b_spawned) {
                self.var_92904d31[var_eafe595f].origin = v_target;
                self.var_92904d31[var_eafe595f] function_704217d1();
                self.var_92904d31[var_eafe595f] thread function_ad721cc0();
            }
        }
        v_target = getclosestpointonnavmesh(level.players[i].origin + (192, 0, 0), 384);
        if (isdefined(v_target)) {
            if (!self.var_92904d31[var_eafe595f + 1].b_spawned) {
                self.var_92904d31[var_eafe595f + 1].origin = v_target;
                self.var_92904d31[var_eafe595f + 1] function_704217d1();
                self.var_92904d31[var_eafe595f + 1] thread function_ad721cc0();
            }
        }
        v_target = getclosestpointonnavmesh(level.players[i].origin + (128, -128, 0), 384);
        if (isdefined(v_target)) {
            if (!self.var_92904d31[var_eafe595f + 2].b_spawned) {
                self.var_92904d31[var_eafe595f + 2].origin = v_target;
                self.var_92904d31[var_eafe595f + 2] function_704217d1();
                self.var_92904d31[var_eafe595f + 2] thread function_ad721cc0();
            }
        }
        v_target = getclosestpointonnavmesh(level.players[i].origin + (-128, -96, 0), 384);
        if (isdefined(v_target)) {
            if (!self.var_92904d31[var_eafe595f + 3].b_spawned) {
                self.var_92904d31[var_eafe595f + 3].origin = v_target;
                self.var_92904d31[var_eafe595f + 3] function_704217d1();
                self.var_92904d31[var_eafe595f + 3] thread function_ad721cc0();
            }
        }
        var_eafe595f += 4;
    }
    wait(0.05);
    self function_78d09fbd(var_70f504b7);
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_93570bbc
// Checksum 0xdedfa94a, Offset: 0x97b0
// Size: 0x2f4
function function_93570bbc(var_70f504b7) {
    if (!isdefined(var_70f504b7)) {
        var_70f504b7 = 0;
    }
    /#
    #/
    self function_379868a6(var_70f504b7);
    var_eafe595f = 0;
    var_91930983 = array::random(level.activeplayers);
    v_target = getclosestpointonnavmesh(var_91930983.origin + (128, 128, 0), 384);
    if (isdefined(v_target)) {
        if (!self.var_92904d31[var_eafe595f].b_spawned) {
            self.var_92904d31[var_eafe595f].origin = v_target;
            self.var_92904d31[var_eafe595f] function_704217d1();
            self.var_92904d31[var_eafe595f] thread function_ad721cc0();
        }
    }
    v_target = getclosestpointonnavmesh(var_91930983.origin + (192, 0, 0), 384);
    if (isdefined(v_target)) {
        if (!self.var_92904d31[var_eafe595f + 1].b_spawned) {
            self.var_92904d31[var_eafe595f + 1].origin = v_target;
            self.var_92904d31[var_eafe595f + 1] function_704217d1();
            self.var_92904d31[var_eafe595f + 1] thread function_ad721cc0();
        }
    }
    v_target = getclosestpointonnavmesh(var_91930983.origin + (128, -128, 0), 384);
    if (isdefined(v_target)) {
        if (!self.var_92904d31[var_eafe595f + 2].b_spawned) {
            self.var_92904d31[var_eafe595f + 2].origin = v_target;
            self.var_92904d31[var_eafe595f + 2] function_704217d1();
            self.var_92904d31[var_eafe595f + 2] thread function_ad721cc0();
        }
    }
    wait(0.05);
    self function_78d09fbd(var_70f504b7);
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_45988f28
// Checksum 0x3d06db9, Offset: 0x9ab0
// Size: 0x63c
function function_45988f28(var_70f504b7) {
    if (!isdefined(var_70f504b7)) {
        var_70f504b7 = 0;
    }
    /#
    #/
    self function_379868a6(var_70f504b7);
    self.var_92904d31[0].origin = getclosestpointonnavmesh((-2616, 6976, -255), 384);
    self.var_92904d31[0] function_704217d1();
    self.var_92904d31[1].origin = getclosestpointonnavmesh((-2688, 6720, -255), 384);
    self.var_92904d31[1] function_704217d1();
    self.var_92904d31[2].origin = getclosestpointonnavmesh((-2880, 6592, -255), 384);
    self.var_92904d31[2] function_704217d1();
    self.var_92904d31[3].origin = getclosestpointonnavmesh((-3136, 6592, -255), 384);
    self.var_92904d31[3] function_704217d1();
    self.var_92904d31[4].origin = getclosestpointonnavmesh((-3328, 6720, -255), 384);
    self.var_92904d31[4] function_704217d1();
    self.var_92904d31[5].origin = getclosestpointonnavmesh((-3400, 6976, -255), 384);
    self.var_92904d31[5] function_704217d1();
    self.var_92904d31[6].origin = getclosestpointonnavmesh((-3328, 7232, -255), 384);
    self.var_92904d31[6] function_704217d1();
    self.var_92904d31[7].origin = getclosestpointonnavmesh((-3072, 7400, -255), 384);
    self.var_92904d31[7] function_704217d1();
    self.var_92904d31[8].origin = getclosestpointonnavmesh((-2944, 7400, -255), 384);
    self.var_92904d31[8] function_704217d1();
    self.var_92904d31[9].origin = getclosestpointonnavmesh((-2688, 7232, -255), 384);
    self.var_92904d31[9] function_704217d1();
    self.var_92904d31[10].origin = getclosestpointonnavmesh((-2616, 6824, -255), 384);
    self.var_92904d31[10] function_704217d1();
    self.var_92904d31[11].origin = getclosestpointonnavmesh((-3008, 6512, -255), 384);
    self.var_92904d31[11] function_704217d1();
    self.var_92904d31[12].origin = getclosestpointonnavmesh((-3432, 6816, -255), 384);
    self.var_92904d31[12] function_704217d1();
    self.var_92904d31[13].origin = getclosestpointonnavmesh((-3264, 7360, -255), 384);
    self.var_92904d31[13] function_704217d1();
    self.var_92904d31[14].origin = getclosestpointonnavmesh((-2752, 7360, -255), 384);
    self.var_92904d31[14] function_704217d1();
    wait(0.05);
    for (i = 0; i < self.var_92904d31.size; i++) {
        self.var_92904d31[i] thread function_ad721cc0();
    }
    self function_78d09fbd(var_70f504b7);
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_ad721cc0
// Checksum 0x519d728b, Offset: 0xa0f8
// Size: 0x254
function function_ad721cc0() {
    self thread clientfield::set("boss_rune_prison_erupt_fx", 1);
    level waittill(#"hash_2d0d7f9c");
    self thread clientfield::set("boss_rune_prison_erupt_fx", 0);
    self.b_spawned = 1;
    self solid();
    wait(0.05);
    self thread clientfield::set("boss_rune_prison_rock_fx", 1);
    self thread function_49bf49de();
    wait(0.2);
    n_time_started = gettime() / 1000;
    n_time_elapsed = 0;
    while (n_time_elapsed < 5) {
        n_time_current = gettime() / 1000;
        n_time_elapsed = n_time_current - n_time_started;
        foreach (player in level.players) {
            var_6e2679f8 = (player.origin[0], player.origin[1], 0);
            var_75f2c6b7 = (self.origin[0], self.origin[1], 0);
            if (distancesquared(var_6e2679f8, var_75f2c6b7) < 2304) {
                self thread function_3995b832(player);
                return;
            }
        }
        if (self.is_destroyed) {
            break;
        }
        wait(0.05);
    }
    self function_c20e4083();
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_3995b832
// Checksum 0x748fdac3, Offset: 0xa358
// Size: 0x12a
function function_3995b832(player) {
    level endon(#"_zombie_game_over");
    self clientfield::set("boss_rune_prison_explode_fx", 1);
    player thread burnplayer::setplayerburning(0.5, 0.25, 12.5, player, undefined);
    if (level.var_1a4b8a19) {
        n_damage = 50;
    } else {
        n_damage = 25;
    }
    player dodamage(n_damage, player.origin, player);
    player clientfield::set("boss_rune_prison_dot_fx", 1);
    wait(0.5);
    player clientfield::set("boss_rune_prison_dot_fx", 0);
    self function_c20e4083();
    self notify(#"hash_a2b2e823");
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_49bf49de
// Checksum 0x428919e, Offset: 0xa490
// Size: 0x88
function function_49bf49de() {
    level endon(#"_zombie_game_over");
    self endon(#"hash_a2b2e823");
    self.is_destroyed = 0;
    for (var_b5f846f3 = 0; var_b5f846f3 < level.var_de21b83b; var_b5f846f3 += n_damage) {
        n_damage, e_attacker = self waittill(#"damage");
    }
    self.is_destroyed = 1;
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_c20e4083
// Checksum 0x985a52dd, Offset: 0xa520
// Size: 0x7a
function function_c20e4083() {
    self thread clientfield::set("boss_rune_prison_rock_fx", 0);
    wait(0.75);
    self.b_spawned = 0;
    self notsolid();
    self.origin += (0, 0, -1000);
    self notify(#"hash_a2b2e823");
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_db1c6f68
// Checksum 0x64eb88d3, Offset: 0xa5a8
// Size: 0x4a4
function function_db1c6f68(var_70f504b7) {
    if (!isdefined(var_70f504b7)) {
        var_70f504b7 = 0;
    }
    level endon(#"hash_e991baf");
    /#
    #/
    if (!var_70f504b7) {
        self.var_40b46e43 function_a1658f19("ai_zm_dlc1_archon_float_spell_wolfhowl_charge_intro", "ai_zm_dlc1_archon_float_spell_wolfhowl_charge_loop");
    }
    var_85436420 = self.var_40b46e43.origin;
    for (i = 0; i < 2; i++) {
        switch (i) {
        case 0:
            var_15e88aa5 = var_85436420 + (32, 32, 0);
            break;
        case 1:
            var_15e88aa5 = var_85436420 + (32, -32, 0);
            break;
        }
        if (i < 2) {
            var_15e88aa5 = getclosestpointonnavmesh(var_15e88aa5, -56);
            self.var_9680b225[i].origin = var_15e88aa5;
            self.var_9680b225[i] function_704217d1();
        }
    }
    var_ab34fc8e = 0;
    if (self.var_7e383b58 == 3) {
        var_3cf40dd7 = 8;
        var_90aa6e9 = 8;
    } else {
        var_3cf40dd7 = 6;
        var_90aa6e9 = 8;
    }
    if (level.var_1a4b8a19 || level.var_2b421938 == 1) {
        var_3cf40dd7 -= 2;
        var_90aa6e9 = 6;
    }
    if (!var_70f504b7) {
        wait(1.5);
        self.var_40b46e43 function_a1658f19("ai_zm_dlc1_archon_float_spell_wolfhowl_deploy");
    }
    self.var_77e69b0f = array::remove_dead(self.var_77e69b0f, 0);
    self.var_77e69b0f = array::remove_undefined(self.var_77e69b0f, 0);
    while (var_ab34fc8e < var_3cf40dd7 && self.var_77e69b0f.size < var_90aa6e9) {
        self.var_77e69b0f = array::remove_dead(self.var_77e69b0f, 0);
        self.var_77e69b0f = array::remove_undefined(self.var_77e69b0f, 0);
        var_eabadcb5 = 0;
        while (var_eabadcb5 < 4 && self.var_77e69b0f.size < var_90aa6e9) {
            self.var_77e69b0f = array::remove_dead(self.var_77e69b0f, 0);
            self.var_77e69b0f = array::remove_undefined(self.var_77e69b0f, 0);
            s_spawn_point = self function_7e9f0faf(0, 1);
            if (level.round_number < 25) {
                var_588c918c = zombie_utility::spawn_zombie(self.var_cbe1d929[0], "spell_stage_direwolf", s_spawn_point, 25);
            } else {
                var_588c918c = zombie_utility::spawn_zombie(self.var_cbe1d929[0], "spell_stage_direwolf", s_spawn_point, level.round_number);
            }
            if (isdefined(var_588c918c)) {
                array::add(self.var_77e69b0f, var_588c918c, 0);
                s_spawn_point thread namespace_cc5bac97::dog_spawn_fx(var_588c918c, s_spawn_point);
                var_588c918c teleport(s_spawn_point.origin, s_spawn_point.angles);
                var_eabadcb5++;
            }
            wait(0.05);
        }
        wait(3);
        var_ab34fc8e += var_eabadcb5;
    }
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_704217d1
// Checksum 0x6b5aadb0, Offset: 0xaa58
// Size: 0x162
function function_704217d1() {
    v_orig = self.origin;
    var_88f4c2cc = self.angles;
    queryresult = positionquery_source_navigation(self.origin, 0, -56, 100, 2, 26);
    if (queryresult.data.size) {
        foreach (point in queryresult.data) {
            if (bullettracepassed(point.origin + (0, 0, 20), v_orig + (0, 0, 20), 0, self, undefined, 0, 0)) {
                self.origin = point.origin;
                self.angles = var_88f4c2cc;
                break;
            }
        }
    }
}

// Namespace namespace_b1bc995c
// Params 2, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_20559b9e
// Checksum 0xc4a58965, Offset: 0xabc8
// Size: 0x374
function function_20559b9e(s_spawn_point, var_f328e82) {
    if (level.round_number < 25) {
        ai_zombie = zombie_utility::spawn_zombie(var_f328e82[0], "spell_stage_zombie", s_spawn_point, 25);
    } else {
        ai_zombie = zombie_utility::spawn_zombie(var_f328e82[0], "spell_stage_zombie", s_spawn_point, level.round_number);
    }
    if (isdefined(ai_zombie)) {
        ai_zombie thread function_2777756a();
        ai_zombie setgoal(ai_zombie.origin);
        ai_zombie pathmode("move allowed");
        ai_zombie.script_string = "find_flesh";
        ai_zombie.zombie_think_done = 1;
        ai_zombie.var_6c653628 = 1;
        ai_zombie.no_gib = 1;
        ai_zombie.candamage = 1;
        ai_zombie.is_zombie = 1;
        ai_zombie.deathpoints_already_given = 1;
        ai_zombie.no_damage_points = 1;
        ai_zombie.var_8ac75273 = 1;
        ai_zombie.exclude_cleanup_adding_to_total = 1;
        ai_zombie.heroweapon_kill_power = 4;
        ai_zombie.sword_kill_power = 4;
        ai_zombie.no_powerups = 1;
        util::wait_network_frame();
        ai_zombie.maxhealth = int(level.var_74b7ddca);
        ai_zombie.health = ai_zombie.maxhealth;
        n_roll = randomint(10);
        if (n_roll <= 6) {
            ai_zombie zombie_utility::set_zombie_run_cycle("sprint");
        } else {
            ai_zombie zombie_utility::set_zombie_run_cycle("run");
        }
        if (isdefined(ai_zombie) && ai_zombie.archetype === "zombie") {
            ai_zombie clientfield::increment("boss_skeleton_eye_glow_fx_change", 1);
            ai_zombie.animname = "zombie";
            ai_zombie thread zm_spawner::play_ambient_zombie_vocals();
            ai_zombie thread zm_audio::zmbaivox_notifyconvert();
            ai_zombie.zmb_vocals_attack = "zmb_vocals_zombie_attack";
            ai_zombie zombie_utility::delayed_zombie_eye_glow();
        }
        return ai_zombie;
    }
    return undefined;
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_369525ff
// Checksum 0xf838ef8e, Offset: 0xaf48
// Size: 0x9c
function function_369525ff() {
    ai_zombie = self;
    if (!isdefined(ai_zombie) || ai_zombie.nuked === 1 || ai_zombie.archetype !== "zombie") {
        return;
    }
    if (isactor(ai_zombie)) {
        ai_zombie zombie_utility::zombie_eye_glow_stop();
        gibserverutils::annihilate(ai_zombie);
    }
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_8a46476
// Checksum 0x41d72d8, Offset: 0xaff0
// Size: 0x41c
function function_8a46476() {
    s_location = self function_7e9f0faf(0, 0, 1);
    if (isdefined(level.var_6c15f1bc[0])) {
        level.var_6c15f1bc[0].script_forcespawn = 1;
        ai = zombie_utility::spawn_zombie(level.var_6c15f1bc[0], "mechz", s_location);
        ai thread namespace_ef567265::function_ef1ba7e5();
        ai disableaimassist();
        /#
            ai thread namespace_ef567265::function_75a79bb5();
        #/
        ai.actor_damage_func = &namespace_e907cf54::function_2670d89e;
        ai.var_fc8ce4cb = &namespace_ef567265::function_b03abc02;
        ai.var_6f76d887 = &namespace_ef567265::function_55483494;
        ai.health = self.var_53cc405d;
        ai.var_b087942f = self.var_df387ccd;
        ai.var_a59d71f5 = self.var_79d56f1b;
        ai.var_88b6008d = self.var_c31f5c1f;
        ai.var_ec94e7b9 = self.var_2cbc5b59;
        ai.var_bf2b21ce = self.var_2cbc5b59;
        ai.var_51a5fb0a = self.var_2cbc5b59;
        ai.var_88897a65 = self.var_2cbc5b59;
        ai.heroweapon_kill_power = 20;
        ai.deathpoints_already_given = 1;
        ai.no_damage_points = 1;
        ai.exclude_cleanup_adding_to_total = 1;
        e_player = zm_utility::get_closest_player(s_location.origin);
        v_dir = e_player.origin - s_location.origin;
        v_dir = vectornormalize(v_dir);
        v_angles = vectortoangles(v_dir);
        s_spawn_location = s_location;
        trace = bullettrace(s_spawn_location.origin, s_spawn_location.origin + (0, 0, -256), 0, s_location);
        var_80f08819 = trace["position"];
        var_1750e965 = var_80f08819;
        ai forceteleport(var_1750e965, v_angles);
        ai thread scene::play("cin_zm_castle_mechz_entrance", ai);
        ai thread namespace_ef567265::function_c441eaba(var_1750e965);
        ai thread namespace_ef567265::function_bbdc1f34(var_1750e965);
        ai thread namespace_ef567265::function_bb048b27();
        ai.var_833cfbae = 1;
        /#
            ai.ignore_devgui_death = 1;
        #/
        ai.no_powerups = 1;
        if (isdefined(ai)) {
            ai thread function_512742d3();
        }
        return ai;
    }
    return undefined;
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_512742d3
// Checksum 0xc09969d8, Offset: 0xb418
// Size: 0x68
function function_512742d3() {
    self endon(#"death");
    level endon(#"_zombie_game_over");
    while (true) {
        wait(7.5);
        if (self zm_zonemgr::entity_in_zone("zone_boss_arena", 0) == 0) {
            self kill();
        }
    }
}

/#

    // Namespace namespace_b1bc995c
    // Params 0, eflags: 0x1 linked
    // namespace_b1bc995c<file_0>::function_fb4ac7ae
    // Checksum 0x323ba86c, Offset: 0xb488
    // Size: 0xe4
    function function_fb4ac7ae() {
        level waittill(#"start_zombie_round_logic");
        wait(1);
        zm_devgui::add_custom_devgui_callback(&function_b68d06ec);
        adddebugcommand("boss_fx");
        adddebugcommand("boss_fx");
        adddebugcommand("boss_fx");
        adddebugcommand("boss_fx");
        adddebugcommand("boss_fx");
        adddebugcommand("boss_fx");
        adddebugcommand("boss_fx");
    }

    // Namespace namespace_b1bc995c
    // Params 1, eflags: 0x1 linked
    // namespace_b1bc995c<file_0>::function_b68d06ec
    // Checksum 0x28bb4f5c, Offset: 0xb578
    // Size: 0x3be
    function function_b68d06ec(cmd) {
        switch (cmd) {
        case 8:
            level flag::set("boss_fx");
            wait(1);
            level flag::set("boss_fx");
            break;
        case 8:
            level flag::set("boss_fx");
            wait(1);
            level flag::set("boss_fx");
            wait(1.5);
            level notify(#"hash_3921dbad");
            break;
        case 8:
            level flag::set("boss_fx");
            break;
        case 8:
            level flag::set("boss_fx");
            level flag::set("boss_fx");
            level flag::set("boss_fx");
            wait(1.5);
            level notify(#"hash_3921dbad");
            level flag::set("boss_fx");
            break;
        case 8:
            level flag::set("boss_fx");
            level flag::set("boss_fx");
            level flag::set("boss_fx");
            level flag::set("boss_fx");
            wait(1.5);
            level notify(#"hash_3921dbad");
            level flag::set("boss_fx");
            break;
        case 8:
            level flag::set("boss_fx");
            level flag::set("boss_fx");
            level flag::set("boss_fx");
            level flag::set("boss_fx");
            wait(1.5);
            level notify(#"hash_3921dbad");
            level flag::set("boss_fx");
            break;
        case 8:
            level flag::set("boss_fx");
            level flag::set("boss_fx");
            level flag::set("boss_fx");
            level flag::set("boss_fx");
            wait(1.5);
            level notify(#"hash_3921dbad");
            level flag::set("boss_fx");
            break;
        }
    }

#/
