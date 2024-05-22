#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_weap_octobomb;
#using scripts/zm/_zm_weap_ball;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/zm/zm_genesis_vo;
#using scripts/zm/zm_genesis_util;
#using scripts/zm/zm_genesis_teleporter;
#using scripts/zm/zm_genesis_minor_ee;
#using scripts/zm/zm_genesis_keeper_companion;
#using scripts/zm/zm_genesis_flingers;
#using scripts/zm/zm_genesis_boss;
#using scripts/zm/zm_genesis_arena;
#using scripts/zm/zm_genesis_apothican;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/music_shared;
#using scripts/shared/math_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;

#using_animtree("zm_genesis");

#namespace namespace_fdab22a5;

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x2
// Checksum 0xe8ed90d1, Offset: 0x1440
// Size: 0x34
function function_2dc19561() {
    system::register("zm_genesis_ee_quest", &__init__, undefined, undefined);
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xd3284092, Offset: 0x1480
// Size: 0x656
function __init__() {
    clientfield::register("world", "ee_quest_state", 15000, getminbitcountfornum(13), "int");
    clientfield::register("scriptmover", "ghost_entity", 15000, 1, "int");
    clientfield::register("scriptmover", "electric_charge", 15000, 1, "int");
    clientfield::register("scriptmover", "grand_tour_found_toy_fx", 15000, 1, "int");
    clientfield::register("scriptmover", "sophia_transition_fx", 15000, 1, "int");
    clientfield::register("allplayers", "sophia_follow", 15000, 3, "int");
    clientfield::register("scriptmover", "sophia_eye_on", 15000, 1, "int");
    clientfield::register("allplayers", "sophia_delete_local", 15000, 1, "int");
    clientfield::register("world", "GenesisEndGameEEScreen", 15000, 1, "int");
    level flag::init("character_stones_done");
    level flag::init("shards_done");
    level flag::init("extraction_ritual");
    level flag::init("acm_wave_in_progress");
    level flag::init("acm_done");
    level flag::init("b_targets_collected");
    level flag::init("b_target_flesh");
    level flag::init("b_target_done");
    level flag::init("got_audio1");
    level flag::init("got_audio2");
    level flag::init("got_audio3");
    level flag::init("placed_audio1");
    level flag::init("placed_audio2");
    level flag::init("placed_audio3");
    level flag::init("phased_sophia_start");
    level flag::init("sophia_beam_locked");
    level flag::init("sophia_activated");
    level flag::init("sophia_at_teleporter");
    level flag::init("teleporter_on");
    level flag::init("teleporter_cooldown");
    level flag::init("book_picked_up");
    level flag::init("book_placed");
    level flag::init("rune_circle_on");
    level flag::init("book_runes_in_progress");
    level flag::init("book_runes_success");
    level flag::init("book_runes_failed");
    level flag::init("boss_rush");
    level flag::init("grand_tour");
    level flag::init("toys_collected");
    level flag::init("boss_fight");
    level flag::init("ending_room");
    level flag::init("rocket_panel_opened");
    level flag::init("rocket_repaired");
    level flag::init("summoning_key_packed");
    level flag::init("summoning_key_in_rocket");
    /#
        level thread function_ea08fd1f();
    #/
    level._effect["lightning_dog_spawn"] = "zombie/fx_dog_lightning_buildup_zmb";
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x5ef955f0, Offset: 0x1ae0
// Size: 0x3c
function function_5b19179b() {
    if (!level flag::get("ending_room")) {
        self thread zm::player_intermission();
    }
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x3cece89a, Offset: 0x1b28
// Size: 0x1ac
function function_26bc55e3() {
    level waittill(#"start_zombie_round_logic");
    level.custom_intermission = &function_5b19179b;
    level thread function_a062344d();
    if (getdvarint("splitscreen_playerCount") > 2) {
        level thread function_c185c51f();
        return;
    }
    level thread function_3c2e817d();
    level flag::wait_till("character_stones_done");
    playsoundatposition("zmb_main_completion_thunder", (0, 0, 0));
    level thread function_b51d4ede();
    level flag::wait_till("phased_sophia_start");
    level thread function_1e3b5e00();
    level thread function_a969cc6();
    level thread function_81c1bd6d();
    level thread function_fd4d6a5a();
    level thread function_1057ea39();
    level thread function_af6d9a0b();
    level thread function_6f8c2ea3();
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xb9d30866, Offset: 0x1ce0
// Size: 0x27c
function function_c185c51f() {
    var_753f10ae = getentarray("tombstone", "targetname");
    array::run_all(var_753f10ae, &delete);
    var_4d97ef95 = struct::get_array("audio_reel_place", "targetname");
    array::run_all(var_4d97ef95, &struct::delete);
    var_4bf2a542 = getentarray("apothicon_spawn", "targetname");
    array::run_all(var_4bf2a542, &delete);
    var_2efcd138 = getentarray("b_target", "targetname");
    array::run_all(var_2efcd138, &delete);
    for (i = 0; i < 7; i++) {
        var_f03dd5b1 = struct::get("ee_grand_tour_toy_0" + i, "targetname");
        var_39018584 = getent(var_f03dd5b1.target, "targetname");
        var_39018584 delete();
    }
    var_22610f78 = getentarray("115_crystals", "script_noteworthy");
    array::run_all(var_22610f78, &delete);
    var_22610f78 = getentarray("115_crystal_decoy", "script_noteworthy");
    array::run_all(var_22610f78, &delete);
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xea6464, Offset: 0x1f68
// Size: 0x1c2
function function_3c2e817d() {
    level.var_753f10ae = getentarray("tombstone", "targetname");
    array::thread_all(level.var_753f10ae, &function_61eb8fd6);
    var_765a3ab1 = 1;
    while (var_765a3ab1 <= 4) {
        n_shot = level waittill(#"character");
        if (n_shot == var_765a3ab1) {
            var_765a3ab1++;
        } else if (n_shot == 1) {
            var_765a3ab1 = 2;
        } else {
            var_765a3ab1 = 1;
        }
        wait(0.1);
    }
    level flag::set("character_stones_done");
    foreach (var_7387f97 in level.var_753f10ae) {
        playfx(level._effect["portal_3p"], var_7387f97.origin);
        var_7387f97 delete();
        wait(0.5);
    }
    level.var_753f10ae = undefined;
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x845296c8, Offset: 0x2138
// Size: 0x54
function function_61eb8fd6() {
    level endon(#"hash_9901afa6");
    while (true) {
        self waittill(#"trigger");
        level notify(#"character", self.script_int);
    }
    self delete();
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xd844299, Offset: 0x2198
// Size: 0x134
function function_b51d4ede() {
    var_4d97ef95 = struct::get_array("audio_reel_place", "targetname");
    array::thread_all(var_4d97ef95, &function_7914cbc8);
    level thread function_be26578d(1);
    level flag::wait_till("placed_audio1");
    level thread function_37acb884(2);
    level flag::wait_till("placed_audio2");
    level thread function_21bfe3c8(3);
    level flag::wait_till("placed_audio3");
    level flag::set("phased_sophia_start");
    level thread namespace_c149ef1::function_dfe962f();
}

// Namespace namespace_fdab22a5
// Params 1, eflags: 0x1 linked
// Checksum 0x9ff37d43, Offset: 0x22d8
// Size: 0x284
function function_bde2ec4(var_f5e9fb6c) {
    playfx(level._effect["portal_3p"], self.origin);
    util::wait_network_frame();
    mdl_reel = util::spawn_model("p7_zm_ctl_radio_recorder_tape_01", self.origin, self.angles);
    if (isdefined(self.target)) {
        var_939c099 = struct::get(self.target, "targetname");
        n_time = mdl_reel zm_utility::fake_physicslaunch(var_939c099.origin, -106);
        mdl_reel rotatepitch(3600, n_time);
        wait(n_time - 0.2);
        mdl_reel rotateto(var_939c099.angles, 0.2);
        mdl_reel moveto(var_939c099.origin, 0.2);
        mdl_reel waittill(#"movedone");
        mdl_reel playsound("zmb_main_reel_land");
    }
    s_unitrigger = mdl_reel zm_unitrigger::create_unitrigger("", 100);
    s_unitrigger.require_look_at = 1;
    e_player = mdl_reel waittill(#"trigger_activated");
    e_player playsound("zmb_main_reel_pickup");
    level thread namespace_c149ef1::function_21783178(e_player);
    level flag::set("got_audio" + var_f5e9fb6c);
    zm_unitrigger::unregister_unitrigger(s_unitrigger);
    mdl_reel delete();
    self struct::delete();
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xd99d5110, Offset: 0x2568
// Size: 0x374
function function_7914cbc8() {
    level flag::wait_till("got_audio" + self.script_int);
    s_unitrigger = self zm_unitrigger::create_unitrigger("", 100);
    s_unitrigger.require_look_at = 1;
    e_player = self waittill(#"trigger_activated");
    level flag::set("placed_audio" + self.script_int);
    var_be748f8 = [];
    mdl_reel = util::spawn_model("p7_zm_ctl_radio_recorder_tape_01", self.origin, self.angles);
    var_15529fd8 = struct::get(self.target, "targetname");
    var_26a73a41 = util::spawn_model("p7_zm_ctl_radio_recorder_tape_02", var_15529fd8.origin, var_15529fd8.angles);
    mdl_reel playsound("zmb_main_reel_place");
    if (!isdefined(var_be748f8)) {
        var_be748f8 = [];
    } else if (!isarray(var_be748f8)) {
        var_be748f8 = array(var_be748f8);
    }
    var_be748f8[var_be748f8.size] = mdl_reel;
    if (!isdefined(var_be748f8)) {
        var_be748f8 = [];
    } else if (!isarray(var_be748f8)) {
        var_be748f8 = array(var_be748f8);
    }
    var_be748f8[var_be748f8.size] = var_26a73a41;
    array::thread_all(var_be748f8, &function_e464aa51);
    wait(0.5);
    function_ccdb680e(var_be748f8, 1);
    switch (self.script_int) {
    case 1:
        mdl_reel playsoundwithnotify("vox_soph_kino_log_1_0", "audio_log_complete");
        break;
    case 2:
        mdl_reel playsoundwithnotify("vox_sfx_radio_stem_kino_log_2_0", "audio_log_complete");
        break;
    case 3:
        mdl_reel playsoundwithnotify("vox_sfx_radio_stem_kino_log_3_0", "audio_log_complete");
        break;
    }
    zm_unitrigger::unregister_unitrigger(s_unitrigger);
    self struct::delete();
    mdl_reel waittill(#"hash_ef5f3d90");
    level notify(#"hash_ef5f3d90");
    function_ccdb680e(var_be748f8, 0);
}

// Namespace namespace_fdab22a5
// Params 2, eflags: 0x1 linked
// Checksum 0xdbc6924, Offset: 0x28e8
// Size: 0xb6
function function_ccdb680e(var_be748f8, b_on) {
    foreach (var_dda74d31 in var_be748f8) {
        if (isdefined(var_dda74d31)) {
            var_dda74d31.var_a02b0d5a = b_on;
            if (!b_on) {
                var_dda74d31 notify(#"hash_7aff9921");
            }
        }
    }
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x4419bf6a, Offset: 0x29a8
// Size: 0x58
function function_e464aa51() {
    self endon(#"hash_7aff9921");
    while (true) {
        if (isdefined(self.var_a02b0d5a) && self.var_a02b0d5a) {
            self rotateroll(-30, 0.2);
        }
        wait(0.2);
    }
}

// Namespace namespace_fdab22a5
// Params 1, eflags: 0x1 linked
// Checksum 0xad221ed4, Offset: 0x2a08
// Size: 0x34a
function function_be26578d(var_f5e9fb6c) {
    var_3a557c26 = struct::get_array("audio1_start", "targetname");
    var_4d544c7f = array::random(var_3a557c26);
    v_offset = (0, 0, 20);
    mdl_rock = util::spawn_model("p7_zm_gen_horror_shards_kit_03_h", var_4d544c7f.origin - v_offset, var_4d544c7f.angles);
    util::wait_network_frame();
    mdl_rock moveto(var_4d544c7f.origin, 15);
    mdl_rock waittill(#"movedone");
    while (true) {
        if (isdefined(level.var_e7aa252c) && isalive(level.var_bfd9ed83)) {
            if (level.var_e7aa252c.reviving_a_player === 1 || level.var_e7aa252c.b_teleporting === 1 || isdefined(level.var_e7aa252c.traversestartnode)) {
                wait(0.1);
                continue;
            }
            if (distancesquared(level.var_bfd9ed83.origin, mdl_rock.origin) < 2500 && distancesquared(level.var_e7aa252c.origin, mdl_rock.origin) < 40000) {
                b_success = level.var_e7aa252c function_3877f225(mdl_rock);
                if (b_success) {
                    break;
                }
            }
        }
        wait(0.5);
    }
    var_bbd61432 = struct::get(var_4d544c7f.target, "targetname");
    var_bbd61432 thread function_bde2ec4(var_f5e9fb6c);
    mdl_rock delete();
    level flag::wait_till("placed_audio" + var_f5e9fb6c);
    foreach (var_4d544c7f in var_3a557c26) {
        var_4d544c7f struct::delete();
    }
}

// Namespace namespace_fdab22a5
// Params 1, eflags: 0x1 linked
// Checksum 0x64361864, Offset: 0x2d60
// Size: 0x244
function function_3877f225(mdl_rock) {
    self.var_57376ff1 = 1;
    self.var_2fd11bbd = 1;
    self.ignoreme = 0;
    v_dir = mdl_rock.origin - self.origin;
    v_dir = (v_dir[0], v_dir[1], 0);
    v_angles = vectortoangles(v_dir);
    self orientmode("face angle", v_angles[1]);
    self playsoundontag("zmb_vocals_keeperprot_attack", "tag_eye");
    wait(0.5);
    self playsoundontag("zmb_keeperprot_attack", "tag_eye");
    self playloopsound("zmb_main_reel1_keeper_lp", 2);
    self thread scene::play("cin_zm_dlc4_keeper_prtctr_ee_idle", self);
    function_9045ea2a(1);
    self util::waittill_notify_or_timeout("death", -76);
    function_9045ea2a(0);
    self stoploopsound(2);
    if (isalive(self)) {
        self.var_57376ff1 = 0;
        self.var_2fd11bbd = 0;
        self scene::stop("cin_zm_dlc4_keeper_prtctr_ee_idle");
        self playsoundontag("zmb_keeperprot_attack_large", "tag_eye");
        return true;
    }
    return false;
}

// Namespace namespace_fdab22a5
// Params 1, eflags: 0x1 linked
// Checksum 0xf4a5912d, Offset: 0x2fb0
// Size: 0x9c
function function_9045ea2a(b_on) {
    if (b_on) {
        level.var_e7aa252c.ignoreme = 0;
        level.var_e7aa252c.allow_zombie_to_target_ai = 1;
        level.var_e7aa252c.takedamage = 1;
        return;
    }
    if (isdefined(level.var_e7aa252c)) {
        level.var_e7aa252c.ignoreme = 1;
        level.var_e7aa252c.allow_zombie_to_target_ai = 0;
        level.var_e7aa252c.takedamage = 0;
    }
}

// Namespace namespace_fdab22a5
// Params 1, eflags: 0x1 linked
// Checksum 0x3f0ef0ad, Offset: 0x3058
// Size: 0xec
function function_37acb884(var_f5e9fb6c) {
    level.var_4bf2a542 = getentarray("apothicon_spawn", "targetname");
    level.var_db16318c = 0;
    level.var_c15eb311 = 0;
    level.var_3b03b43a = &function_5516baeb;
    level flag::wait_till("acm_done");
    s_reel = struct::get("acm_reel", "targetname");
    if (isdefined(level.var_d29b5881)) {
        s_reel.origin = level.var_d29b5881;
    }
    s_reel thread function_bde2ec4(var_f5e9fb6c);
}

// Namespace namespace_fdab22a5
// Params 1, eflags: 0x1 linked
// Checksum 0x4ce5e7c7, Offset: 0x3150
// Size: 0x272
function function_5516baeb(var_d80ab647) {
    if (level flag::get("placed_audio1") && !level flag::get("acm_done")) {
        foreach (var_d72f41af in level.var_4bf2a542) {
            if (self istouching(var_d72f41af) && !(isdefined(var_d72f41af.var_b06a11e0) && var_d72f41af.var_b06a11e0)) {
                self.sndnosamlaugh = 1;
                var_d72f41af thread function_fcf0dc78();
                self playsound("zmb_main_reel2_arnie_swallow");
                switch (level.var_db16318c) {
                case 3:
                    n_wave = 1;
                    break;
                case 6:
                    n_wave = 2;
                    break;
                case 9:
                    n_wave = 3;
                    break;
                default:
                    n_wave = 0;
                    break;
                }
                if (n_wave > 0) {
                    level thread function_66b6f0e2(n_wave);
                }
            }
        }
    }
    if (level flag::get("lil_arnie_prereq_done") && !level flag::get("lil_arnie_done")) {
        var_d80ab647 = namespace_df27fee4::function_131a352c(var_d80ab647);
    }
    if (level flag::get("lil_arnie_done") && level flag::get("acm_done")) {
        level.var_3b03b43a = undefined;
    }
    return var_d80ab647;
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x82c3b422, Offset: 0x33d0
// Size: 0x58
function function_fcf0dc78() {
    level endon(#"hash_ee91de1d");
    self.var_b06a11e0 = 1;
    level.var_db16318c++;
    level flag::wait_till_clear("player_in_apothicon");
    self.var_b06a11e0 = 0;
    level.var_db16318c--;
}

// Namespace namespace_fdab22a5
// Params 1, eflags: 0x1 linked
// Checksum 0xfaca2920, Offset: 0x3430
// Size: 0x116
function function_66b6f0e2(n_wave) {
    level thread function_78469e71();
    switch (n_wave) {
    case 1:
        str_type = "plain";
        break;
    case 2:
        str_type = "fire";
        break;
    case 3:
        str_type = "shadow";
        break;
    }
    for (i = 0; i < 3; i++) {
        s_spawn = array::random(level.zones["apothicon_interior_zone"].a_loc_types["margwa_location"]);
        s_spawn thread namespace_a9c2433b::function_cc6165b0(str_type, 1);
        wait(1);
    }
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xde89a57b, Offset: 0x3550
// Size: 0xac
function function_78469e71() {
    if (level flag::get("acm_wave_in_progress")) {
        return;
    }
    level flag::set("acm_wave_in_progress");
    level endon(#"hash_ee91de1d");
    level flag::wait_till_clear("player_in_apothicon");
    wait(0.05);
    level flag::clear("acm_wave_in_progress");
    level notify(#"hash_ee91de1d");
    level.var_c15eb311 = 0;
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x9d43b622, Offset: 0x3608
// Size: 0x146
function function_a062344d() {
    level.b_allow_idgun_pap = 1;
    level.var_6aedbc8b = 0;
    var_700a627b = struct::get_array("shard_piece", "targetname");
    level.var_d6c2c8a7 = var_700a627b.size;
    array::thread_all(var_700a627b, &function_d0b9561c);
    /#
        if (getdvarint("sophia_transition_fx") > 0) {
            level flag::set("sophia_transition_fx");
        }
    #/
    level flag::wait_till("shards_done");
    level.zombie_weapons[level.var_9727e47e].upgrade = level.var_ed2646a1;
    level.zombie_weapons_upgraded[level.var_ed2646a1] = level.var_9727e47e;
    level.aat_exemptions[level.var_ed2646a1] = 1;
    level.var_c3c13940[level.var_ed2646a1] = 0;
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x56faa022, Offset: 0x3758
// Size: 0x1bc
function function_d0b9561c() {
    var_9f0eb8c7 = getent(self.target, "targetname");
    var_9f0eb8c7 setcandamage(1);
    v_position = function_4e44f01(var_9f0eb8c7.origin, 0);
    wait(1);
    var_9f0eb8c7 moveto(v_position, 3);
    wait(3);
    level.var_6aedbc8b++;
    if (level.var_6aedbc8b == level.var_d6c2c8a7) {
        level flag::set("shards_done");
    }
    var_9f0eb8c7 setscale(0.3);
    var_9f0eb8c7 ghost();
    level flag::wait_till("apotho_pack_freed");
    s_destination = struct::get(var_9f0eb8c7.target, "targetname");
    var_9f0eb8c7.origin = s_destination.origin;
    var_9f0eb8c7.angles = s_destination.angles;
    var_9f0eb8c7 show();
}

// Namespace namespace_fdab22a5
// Params 1, eflags: 0x1 linked
// Checksum 0xf838bd94, Offset: 0x3920
// Size: 0x1d4
function function_21bfe3c8(var_f5e9fb6c) {
    var_2efcd138 = getentarray("b_target", "targetname");
    array::thread_all(var_2efcd138, &function_24240140);
    level.var_4d6344fd = 0;
    level.var_96fb1d89 = var_2efcd138.size;
    level flag::wait_till("b_targets_collected");
    s_reel = struct::get("b_target_reel", "targetname");
    level.var_3848ad63 = function_4e44f01(s_reel.origin, 1);
    level flag::set("b_target_flesh");
    wait(5);
    var_db42e573 = struct::get("b_target_body", "targetname");
    var_db42e573 thread function_43106b81();
    level.var_3848ad63 = function_4e44f01(s_reel.origin, 1);
    wait(5);
    level flag::set("b_target_done");
    s_reel.origin = level.var_3848ad63;
    s_reel thread function_bde2ec4(var_f5e9fb6c);
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xc90ebdb1, Offset: 0x3b00
// Size: 0x25c
function function_24240140() {
    self setcandamage(1);
    while (true) {
        n_damage, e_attacker, v_dir, v_loc, str_type, str_model, str_tag, str_part, w_weapon, n_flags = self waittill(#"damage");
        if (isdefined(w_weapon) && w_weapon.name != "idgun_genesis_0_upgraded") {
            b_upgraded = zm_weapons::is_weapon_upgraded(w_weapon);
            if (b_upgraded) {
                break;
            }
        }
    }
    self playsound("zmb_main_reel3_bone_brick_smash");
    self setmodel(self.script_string);
    if (isdefined(self.script_int)) {
        self.angles += (0, self.script_int, 0);
    }
    self playloopsound("zmb_main_reel3_bone_lp", 1);
    self thread function_958fb16();
    v_position = function_4e44f01(self.origin, 1);
    self notify(#"hash_d940112c");
    wait(1);
    self moveto(v_position, 3);
    wait(3);
    playsoundatposition("zmb_main_reel3_bone_disappear", self.origin);
    self stoploopsound(2);
    self function_156b5313();
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xa23913f7, Offset: 0x3d68
// Size: 0x1ec
function function_156b5313() {
    self setmodel(self.script_string);
    level.var_4d6344fd++;
    if (level.var_4d6344fd == level.var_96fb1d89) {
        level flag::set("b_targets_collected");
    }
    self ghost();
    s_destination = struct::get(self.target, "targetname");
    self.origin = s_destination.origin;
    self.angles = s_destination.angles;
    level flag::wait_till("b_targets_collected");
    self show();
    self playsound("zmb_main_reel3_bone_appear");
    level flag::wait_till("b_target_flesh");
    wait(randomfloatrange(0.666667, 1.33333));
    self moveto(level.var_3848ad63, randomfloatrange(1, 3));
    self waittill(#"movedone");
    self playsound("zmb_main_reel3_bone_disappear_quiet");
    util::wait_network_frame();
    self delete();
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x918a39e8, Offset: 0x3f60
// Size: 0xf0
function function_958fb16() {
    self endon(#"hash_d940112c");
    if (self.script_string == "p7_zm_gen_horror_shards_kit_10") {
        self moveto(self.origin + (0, 30, 0), 2);
    } else {
        self moveto(self.origin + (0, 0, 30), 2);
    }
    while (true) {
        self rotateto(self.angles + (0, 180, 0), 1.5);
        wait(1.5);
    }
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x758bb9eb, Offset: 0x4058
// Size: 0x14c
function function_43106b81() {
    mdl_body = util::spawn_model(self.script_string, self.origin, (0, -90, 0));
    mdl_body playsound("zmb_main_reel3_body_appear");
    mdl_body attach("c_zom_dlc4_zombies_head2_fem", "", 1);
    mdl_body useanimtree(#zm_genesis);
    mdl_body thread animation::play("ai_zm_dlc4_sophia_death_pose");
    level flag::wait_till("b_target_done");
    playsoundatposition("vox_soph_sophia_scream_0", mdl_body.origin);
    playsoundatposition("zmb_main_reel3_body_disappear", mdl_body.origin);
    mdl_body delete();
}

// Namespace namespace_fdab22a5
// Params 2, eflags: 0x1 linked
// Checksum 0xe36266bf, Offset: 0x41b0
// Size: 0xb8
function function_4e44f01(v_target, var_7e879af8) {
    if (!isdefined(var_7e879af8)) {
        var_7e879af8 = 0;
    }
    while (true) {
        v_position, w_weapon, var_c73fc1db = level waittill(#"hash_2751215d");
        if (var_7e879af8 && w_weapon != level.var_ed2646a1) {
            continue;
        }
        n_dist_sq = distancesquared(v_position, v_target);
        if (n_dist_sq <= 10000) {
            return v_position;
        }
    }
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xe65a4889, Offset: 0x4270
// Size: 0x25c
function function_1e3b5e00() {
    function_ccaca679();
    level clientfield::set("ee_quest_state", 4);
    var_af8a18df = struct::get("ee_beam_sophia", "targetname");
    playfx(level._effect["lightning_dog_spawn"], var_af8a18df.origin);
    level.var_a090a655 = util::spawn_model("tag_origin", var_af8a18df.origin, var_af8a18df.angles);
    level.var_a090a655.targetname = "sophia_eye";
    level.var_a090a655 playsound("zmb_main_sophia_ghost_materialize");
    level.var_a090a655 playloopsound("zmb_main_sophia_ghost_lp", 3);
    level thread function_cde49635();
    var_af8a18df thread function_16d54ad3();
    level flag::wait_till("sophia_beam_locked");
    level clientfield::set("ee_quest_state", 5);
    var_af8a18df thread function_baf73d86();
    level flag::wait_till("sophia_activated");
    level.var_a090a655 thread function_9449053f();
    level flag::wait_till("sophia_at_teleporter");
    level clientfield::set("ee_quest_state", 6);
    level.var_a090a655 thread function_7389c635();
    level.var_a090a655 thread function_a3bddb7c();
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x655f40d3, Offset: 0x44d8
// Size: 0x14c
function function_ccaca679() {
    nd_start = getvehiclenode("sophia_flyin_start", "targetname");
    var_2309b03e = vehicle::spawn(undefined, "sophia_vehicle", "flinger_vehicle", nd_start.origin, nd_start.angles);
    var_2309b03e setspeed(100);
    var_a090a655 = util::spawn_model("p7_zm_gen_dark_arena_sphere", nd_start.origin, nd_start.angles);
    var_a090a655 linkto(var_2309b03e);
    var_2309b03e setignorepauseworld(1);
    var_2309b03e vehicle::get_on_and_go_path(nd_start);
    var_a090a655 delete();
    var_2309b03e delete();
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x289a917a, Offset: 0x4630
// Size: 0x4c
function function_16d54ad3() {
    /#
        if (level flag::get("sophia_transition_fx")) {
            return;
        }
    #/
    level.var_a090a655 thread function_7eefe596("sophia_activated");
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x6cda74c0, Offset: 0x4688
// Size: 0x124
function function_baf73d86() {
    /#
        if (level flag::get("sophia_transition_fx")) {
            return;
        }
    #/
    var_913a622d = struct::get("ee_sophia_activate", "targetname");
    s_unitrigger = var_913a622d zm_unitrigger::create_unitrigger("", 64);
    e_player = var_913a622d waittill(#"trigger_activated");
    level thread namespace_c149ef1::function_efdd99e2(e_player);
    playfx(level._effect["lightning_dog_spawn"], self.origin);
    level flag::set("sophia_activated");
    zm_unitrigger::unregister_unitrigger(s_unitrigger);
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x5b385bdf, Offset: 0x47b8
// Size: 0x42c
function function_9449053f() {
    /#
        if (level flag::get("sophia_transition_fx")) {
            return;
        }
    #/
    level notify(#"hash_deeb3634");
    foreach (player in level.players) {
        player clientfield::set("sophia_delete_local", 1);
    }
    level.var_2309b03e = vehicle::spawn(undefined, "sophia_vehicle", "flinger_vehicle", self.origin, self.angles);
    self linkto(level.var_2309b03e);
    level.var_2309b03e setignorepauseworld(1);
    self clientfield::set("sophia_transition_fx", 1);
    level function_e483fde2(1);
    self clientfield::set("sophia_transition_fx", 0);
    self thread function_b87c7e9a();
    self thread function_ab34209c();
    nd_start = getvehiclenode("sophia_portal_start", "targetname");
    level.var_2309b03e vehicle::get_on_and_go_path(nd_start);
    playsoundatposition("zmb_teleporter_teleport_out", self.origin);
    playfx(level._effect["portal_3p"], self.origin);
    util::wait_network_frame();
    self ghost();
    util::wait_network_frame();
    var_648aa72d = getvehiclenode("sophia_theater_start", "targetname");
    level.var_2309b03e attachpath(var_648aa72d);
    level.var_2309b03e setspeedimmediate(0);
    playfx(level._effect["portal_3p"], var_648aa72d.origin);
    self show();
    playsoundatposition("zmb_teleporter_teleport_in", self.origin);
    while (function_9594f10()) {
        util::wait_network_frame();
    }
    wait(1);
    level.var_2309b03e startpath();
    level.var_2309b03e resumespeed();
    level.var_2309b03e waittill(#"reached_end_node");
    self unlink();
    level.var_2309b03e delete();
    level flag::set("sophia_at_teleporter");
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x2f756c1a, Offset: 0x4bf0
// Size: 0x174
function function_ab34209c() {
    level endon(#"hash_a5c99c2");
    while (true) {
        nd_current = level.var_2309b03e waittill(#"reached_node");
        b_pause = 1;
        if (isdefined(nd_current)) {
            while (b_pause) {
                foreach (e_player in level.activeplayers) {
                    if (distancesquared(e_player.origin, nd_current.origin) < 640000) {
                        b_pause = 0;
                    }
                }
                if (b_pause) {
                    level.var_2309b03e setspeedimmediate(0);
                } else {
                    level.var_2309b03e resumespeed();
                }
                util::wait_network_frame();
            }
        }
    }
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xd6fbe726, Offset: 0x4d70
// Size: 0xc6
function function_9594f10() {
    n_dist = 400 * 400;
    var_648aa72d = getvehiclenode("sophia_theater_start", "targetname");
    for (i = 0; i < level.activeplayers.size; i++) {
        if (distancesquared(level.activeplayers[i].origin, var_648aa72d.origin) < n_dist) {
            return false;
        }
    }
    return true;
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x5496357f, Offset: 0x4e40
// Size: 0xac
function function_7389c635() {
    var_57cd6434 = struct::get("ee_teleporter_sophia_struct", "targetname");
    level.var_a090a655.origin = var_57cd6434.origin;
    level.var_a090a655.angles = var_57cd6434.angles;
    level function_e483fde2(1);
    level.var_a090a655 thread function_7eefe596("boss_fight");
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xe33b32d3, Offset: 0x4ef8
// Size: 0x1ac
function function_a3bddb7c() {
    /#
        if (level flag::get("sophia_transition_fx")) {
            return;
        }
    #/
    level flag::clear("teleporter_cooldown");
    level.var_a090a655 clientfield::set("electric_charge", 1);
    level.var_a090a655 playsound("zmb_main_sophia_connect_teleporter");
    wait(1);
    level.var_a090a655 playsound("zmb_main_sophia_energize_teleporter");
    level flag::set("teleporter_on");
    level thread namespace_c149ef1::function_ab35cb95();
    level flag::wait_till_clear("teleporter_on");
    level.var_a090a655 clientfield::set("electric_charge", 0);
    level.var_a090a655 playsound("zmb_main_sophia_deenergize_teleporter");
    if (!level flag::get("book_picked_up")) {
        level flag::set("teleporter_cooldown");
        level waittill(#"start_of_round");
        self thread function_a3bddb7c();
    }
}

// Namespace namespace_fdab22a5
// Params 1, eflags: 0x1 linked
// Checksum 0x72f99d1, Offset: 0x50b0
// Size: 0x1d4
function function_e483fde2(b_solid) {
    /#
        if (!isdefined(level.var_a090a655)) {
            return;
        }
    #/
    var_4e0cc636 = 0;
    level.var_a090a655 playsound("zmb_main_sophia_activate");
    while (var_4e0cc636 < 6) {
        level.var_a090a655 setmodel("p7_zm_gen_dark_arena_sphere");
        wait(0.15);
        level.var_a090a655 setmodel("p7_zm_gen_dark_arena_sphere_metal");
        level.var_a090a655 clientfield::set("sophia_eye_on", 1);
        wait(0.15);
        var_4e0cc636++;
    }
    level.var_a090a655 playsound("zmb_main_sophia_materialize");
    if (isdefined(b_solid) && b_solid) {
        level.var_a090a655 setmodel("p7_zm_gen_dark_arena_sphere_metal");
        level.var_a090a655 clientfield::set("sophia_eye_on", 1);
        level.var_a090a655 playloopsound("zmb_main_sophia_materialized_lp", 2);
        return;
    }
    level.var_a090a655 setmodel("p7_zm_gen_dark_arena_sphere");
    level.var_a090a655 playloopsound("zmb_main_sophia_ghost_lp", 2);
}

// Namespace namespace_fdab22a5
// Params 1, eflags: 0x1 linked
// Checksum 0x8e929e90, Offset: 0x5290
// Size: 0x1ce
function function_7eefe596(str_endon) {
    level endon(str_endon);
    self endon(#"death");
    v_origin_start = self.origin;
    v_angles_start = self.angles;
    while (true) {
        n_random = randomfloatrange(2, 4);
        self moveto(v_origin_start + (randomintrange(-5, 5), randomintrange(-5, 5), randomintrange(-5, 5)), n_random);
        self rotateto(v_angles_start + (randomintrange(-6, 6), randomintrange(-6, 6), randomintrange(-6, 6)), n_random);
        wait(n_random);
        n_random = randomfloatrange(2, 4);
        self moveto(v_origin_start, n_random);
        self rotateto(v_angles_start, n_random);
        wait(n_random);
    }
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x7402b09b, Offset: 0x5468
// Size: 0xae
function function_cde49635() {
    level endon(#"hash_deeb3634");
    level notify(#"hash_423907c1");
    callback::on_spawned(&function_c2ad8318);
    level thread function_a1369011();
    while (true) {
        e_player = arraygetclosest(level.var_a090a655.origin, level.activeplayers);
        e_player function_a9536aec();
        wait(4);
    }
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xc8075723, Offset: 0x5520
// Size: 0xfe
function function_a9536aec() {
    level endon(#"hash_deeb3634");
    self endon(#"death");
    b_first_loop = 1;
    while (zm_utility::is_player_valid(self) && function_86b1188c(750, level.var_a090a655, self)) {
        if (b_first_loop) {
            b_first_loop = 0;
            level.var_f4f5346d = self;
            n_clientfield_val = self getentitynumber() + 1;
            self clientfield::set("sophia_follow", n_clientfield_val);
        }
        wait(1);
    }
    self clientfield::set("sophia_follow", 0);
    level.var_f4f5346d = undefined;
}

// Namespace namespace_fdab22a5
// Params 3, eflags: 0x1 linked
// Checksum 0x89d6a10b, Offset: 0x5628
// Size: 0x7e
function function_86b1188c(n_distance, var_d21815c4, var_441f84ff) {
    var_31dc18aa = n_distance * n_distance;
    var_2931dc75 = distancesquared(var_d21815c4.origin, var_441f84ff.origin);
    if (var_2931dc75 <= var_31dc18aa) {
        return true;
    }
    return false;
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x114e5acc, Offset: 0x56b0
// Size: 0x1c
function function_c2ad8318() {
    level thread function_fa9b2a93();
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xcff6077d, Offset: 0x56d8
// Size: 0x64
function function_fa9b2a93() {
    if (isdefined(level.var_f4f5346d)) {
        n_clientfield_val = level.var_f4f5346d getentitynumber() + 1;
        level.var_f4f5346d clientfield::set("sophia_follow", n_clientfield_val);
    }
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x8d065b7f, Offset: 0x5748
// Size: 0x34
function function_a1369011() {
    level waittill(#"hash_deeb3634");
    callback::remove_on_spawned(&function_c2ad8318);
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xaf0d2289, Offset: 0x5788
// Size: 0x140
function function_b87c7e9a() {
    while (!level flag::get("sophia_at_teleporter")) {
        a_ai = getaiteamarray(level.zombie_team);
        var_20a550ba = arraysortclosest(a_ai, self.origin, a_ai.size, 0, 100);
        foreach (ai_zombie in var_20a550ba) {
            if (!(isdefined(ai_zombie.knockdown) && ai_zombie.knockdown)) {
                self thread namespace_d95aef6::zombie_slam_direction(ai_zombie);
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xb5bdda15, Offset: 0x58d0
// Size: 0x3c
function function_a969cc6() {
    level flag::wait_till("sophia_at_teleporter");
    level thread function_7796eb02();
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x4923e1fe, Offset: 0x5918
// Size: 0x10c
function function_7796eb02() {
    /#
        if (level flag::get("sophia_transition_fx")) {
            return;
        }
    #/
    var_d3f7546d = struct::get("ee_book_sams_room", "targetname");
    var_7357ec63 = util::spawn_model("p7_fxanim_zm_gen_book_zombie_mod", var_d3f7546d.origin, var_d3f7546d.angles);
    var_7357ec63 playloopsound("zmb_main_runey_book_lp", 2);
    var_d3f7546d thread function_11b415e8();
    level flag::wait_till("book_picked_up");
    var_7357ec63 delete();
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xe8acf5bb, Offset: 0x5a30
// Size: 0xcc
function function_11b415e8() {
    s_unitrigger = self zm_unitrigger::create_unitrigger("", 100);
    s_unitrigger.require_look_at = 1;
    e_player = self waittill(#"trigger_activated");
    e_player playsound("zmb_main_runey_book_pickup");
    level flag::set("book_picked_up");
    zm_unitrigger::unregister_unitrigger(s_unitrigger);
    self struct::delete();
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xe539839e, Offset: 0x5b08
// Size: 0x28c
function function_81c1bd6d() {
    var_22a9ac12 = struct::get("ee_book_theater", "targetname");
    var_f4f26dd4 = struct::get("ee_book_arena", "targetname");
    level flag::wait_till("book_picked_up");
    var_22a9ac12 thread function_83245b0e();
    level flag::wait_till("book_placed");
    var_22a9ac12.var_4011cc00 = util::spawn_model("p7_fxanim_zm_gen_book_zombie_mod", var_22a9ac12.origin, var_22a9ac12.angles);
    var_22a9ac12.var_4011cc00 playsound("zmb_main_runey_book_place");
    var_22a9ac12.var_4011cc00 playloopsound("zmb_main_runey_book_lp", 2);
    var_f4f26dd4 scene::init("p7_fxanim_zm_gen_book_zombie_open_01_bundle");
    level flag::wait_till("rune_circle_on");
    var_f4f26dd4 thread function_1b0994cb();
    level flag::wait_till("book_runes_success");
    playsoundatposition("zmb_main_completion_big", (0, 0, 0));
    wait(3);
    var_cf94f037 = struct::get("ee_book_runes_in_summoning_circle", "targetname");
    zm_powerups::specific_powerup_drop("full_ammo", bullettrace(var_cf94f037.origin, var_cf94f037.origin + (0, 0, -100000), 0, undefined)["position"]);
    wait(1);
    level flag::set("boss_rush");
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xcd80ab04, Offset: 0x5da0
// Size: 0x2a4
function function_83245b0e() {
    /#
        if (level flag::get("sophia_transition_fx")) {
            return;
        }
    #/
    s_unitrigger = self zm_unitrigger::create_unitrigger("", 100);
    s_unitrigger.require_look_at = 1;
    e_player = self waittill(#"trigger_activated");
    level flag::set("book_placed");
    level clientfield::set("ee_quest_state", 7);
    zm_unitrigger::unregister_unitrigger(s_unitrigger);
    wait(0.6);
    self.var_eee7ee77 = [];
    for (i = 0; i < 4; i++) {
        self.var_eee7ee77[i] = util::spawn_model("tag_origin", self.origin, self.angles);
        self.var_eee7ee77[i] clientfield::set("power_zombie_soul", 1);
        self.var_eee7ee77[i] thread function_cf63e7c4(self);
        wait(randomfloatrange(0.3, 0.6));
    }
    while (self.var_eee7ee77.size) {
        util::wait_network_frame();
    }
    var_d5467156 = util::spawn_model("tag_origin", (-467, -8200, -1270));
    var_d5467156 clientfield::set("grand_tour_found_toy_fx", 1);
    var_d5467156 playsound("zmb_main_runey_circle_grow");
    wait(5);
    var_d5467156 playsound("zmb_main_runey_circle_appear");
    var_d5467156 delete();
    level flag::set("rune_circle_on");
}

// Namespace namespace_fdab22a5
// Params 1, eflags: 0x1 linked
// Checksum 0x6928a0d1, Offset: 0x6050
// Size: 0xa4
function function_cf63e7c4(var_d3a0e40c) {
    self moveto((-467, -8200, -1270), 3.2, 1.2);
    self waittill(#"movedone");
    self playsound("zmb_ee_soul_impact");
    var_d3a0e40c.var_eee7ee77 = array::exclude(var_d3a0e40c.var_eee7ee77, self);
    self delete();
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x8af222f, Offset: 0x6100
// Size: 0x24c
function function_1b0994cb() {
    /#
        if (level flag::get("sophia_transition_fx")) {
            return;
        }
    #/
    level waittill(#"hash_78e9c51c");
    level flag::clear("arena_timer");
    level thread namespace_f153ce01::function_ae8e44d6();
    s_unitrigger = self zm_unitrigger::create_unitrigger("", 100);
    while (true) {
        e_player = self waittill(#"trigger_activated");
        level notify(#"hash_6760e3ae");
        level clientfield::set("arena_timeout_warning", 0);
        level flag::set("book_runes_in_progress");
        function_69f6c616();
        zm_unitrigger::unregister_unitrigger(s_unitrigger);
        self function_d3e3222b();
        s_unitrigger = self zm_unitrigger::create_unitrigger("", 100);
        self function_8f77d210();
        level flag::clear("book_runes_in_progress");
        if (level flag::get("book_runes_success")) {
            break;
        } else {
            thread [[ level.var_d90687be ]]->function_b4aac082();
            e_player thread function_54e04357();
            level waittill(#"start_of_round");
            level flag::clear("book_runes_failed");
        }
        level waittill(#"hash_78e9c51c");
        level thread namespace_f153ce01::function_32419cfe();
    }
    zm_unitrigger::unregister_unitrigger(s_unitrigger);
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x14b88523, Offset: 0x6358
// Size: 0x34
function function_8f77d210() {
    self thread function_71fa98ee();
    level function_fedceb8();
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xf26e6803, Offset: 0x6398
// Size: 0x5c
function function_69f6c616() {
    if (!isdefined(level.var_6000c357)) {
        level.var_6000c357 = array(0, 1, 2, 3);
    }
    level.var_6000c357 = array::randomize(level.var_6000c357);
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x7ce9695d, Offset: 0x6400
// Size: 0x39a
function function_d3e3222b() {
    var_183f2194 = getent("book_elder_page1", "targetname");
    var_8a4690cf = getent("book_elder_page2", "targetname");
    var_64441666 = getent("book_elder_page3", "targetname");
    var_a637b259 = getent("book_elder_page4", "targetname");
    var_a29f8103 = array(var_183f2194, var_8a4690cf, var_64441666, var_a637b259);
    for (i = 0; i < var_a29f8103.size; i++) {
        var_a29f8103[i] showpart("page" + i + 1 + "_" + level.var_6000c357[i] + "_jnt", var_a29f8103[i].model, 1);
        var_63727ec8 = array::exclude(level.var_6000c357, level.var_6000c357[i]);
        foreach (var_8b87b28 in var_63727ec8) {
            var_a29f8103[i] hidepart("page" + i + 1 + "_" + var_8b87b28 + "_jnt", var_a29f8103[i].model, 1);
        }
        self scene::play("p7_fxanim_zm_gen_book_zombie_open_0" + i + 1 + "_bundle");
        wait(3);
    }
    self scene::play("p7_fxanim_zm_gen_book_zombie_close_bundle");
    self scene::init("p7_fxanim_zm_gen_book_zombie_open_01_bundle");
    self notify(#"hash_5c016997");
    foreach (e_player in level.activeplayers) {
        e_player function_26801553();
    }
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x0
// Checksum 0x77989787, Offset: 0x67a8
// Size: 0x108
function function_ea1417b1() {
    self endon(#"hash_5c016997");
    while (true) {
        foreach (e_player in level.activeplayers) {
            if (distancesquared(self.origin, e_player.origin) < 10000) {
                e_player function_9b4faff6();
                continue;
            }
            e_player function_26801553();
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x406b35be, Offset: 0x68b8
// Size: 0x40
function function_9b4faff6() {
    if (!(isdefined(self.var_a40d1449) && self.var_a40d1449)) {
        self.var_a40d1449 = 1;
        self zm_utility::function_139befeb();
        /#
        #/
    }
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xf57af22d, Offset: 0x6900
// Size: 0x40
function function_26801553() {
    if (isdefined(self.var_a40d1449) && self.var_a40d1449) {
        self.var_a40d1449 = 0;
        self zm_utility::function_36f941b3();
        /#
        #/
    }
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x35d12d6b, Offset: 0x6948
// Size: 0x58
function function_71fa98ee() {
    level endon(#"hash_261a2198");
    level endon(#"hash_ca02f3d4");
    while (true) {
        e_player = self waittill(#"trigger_activated");
        self function_d3e3222b();
    }
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x3f29aee8, Offset: 0x69a8
// Size: 0xec
function function_fedceb8() {
    var_2fcf5550 = struct::get("ee_book_runes_in_summoning_circle", "targetname");
    var_7b98b639 = util::spawn_model("tag_origin", var_2fcf5550.origin, var_2fcf5550.angles);
    s_unitrigger = var_2fcf5550 zm_unitrigger::create_unitrigger("", 100);
    var_2fcf5550 function_cf9ae010(var_7b98b639);
    zm_unitrigger::unregister_unitrigger(s_unitrigger);
    var_7b98b639 delete();
}

// Namespace namespace_fdab22a5
// Params 1, eflags: 0x1 linked
// Checksum 0xca2be54e, Offset: 0x6aa0
// Size: 0x218
function function_cf9ae010(var_7b98b639) {
    level endon(#"hash_261a2198");
    level endon(#"hash_ca02f3d4");
    level.var_be50c24f = 0;
    level.var_5da45153 = array(0, 1, 2, 3, 4, 5);
    var_cad0573e = array::randomize(level.var_5da45153);
    self thread function_3d57dcdd();
    while (true) {
        level.var_63fa69fd = array::random(var_cad0573e);
        var_cad0573e = array::exclude(var_cad0573e, level.var_63fa69fd);
        if (!var_cad0573e.size) {
            var_cad0573e = array::randomize(level.var_5da45153);
        }
        if (isdefined(level.var_63fa69fd)) {
            var_7b98b639 setmodel("p7_zm_gen_rune_" + level.var_63fa69fd + 1 + "_purple");
            var_7b98b639 playsound("zmb_main_bookish_rune_show");
            var_7b98b639 playloopsound("zmb_main_bookish_rune_lp", 1);
            function_fde3e99f(3.6);
            level.var_63fa69fd = undefined;
            var_7b98b639 setmodel("tag_origin");
            var_7b98b639 stoploopsound(0.5);
            var_7b98b639 playsound("zmb_main_bookish_rune_disappear");
        }
        wait(0.8);
    }
}

// Namespace namespace_fdab22a5
// Params 1, eflags: 0x1 linked
// Checksum 0x31e28cfe, Offset: 0x6cc0
// Size: 0x70
function function_fde3e99f(n_time) {
    if (isdefined(n_time)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_time, "timeout");
    }
    level waittill(#"hash_ef87390a");
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x963d0774, Offset: 0x6d38
// Size: 0x31c
function function_3d57dcdd() {
    level endon(#"hash_261a2198");
    level endon(#"hash_ca02f3d4");
    var_bc16de8b = [];
    for (i = 0; i < level.var_6000c357.size; i++) {
        var_4cfecd69 = struct::get("ee_book_runes_correct_0" + i + 1, "targetname");
        var_a2875640 = util::spawn_model("tag_origin", var_4cfecd69.origin, var_4cfecd69.angles);
        if (!isdefined(var_bc16de8b)) {
            var_bc16de8b = [];
        } else if (!isarray(var_bc16de8b)) {
            var_bc16de8b = array(var_bc16de8b);
        }
        var_bc16de8b[var_bc16de8b.size] = var_a2875640;
        level thread util::delete_on_death_or_notify(var_a2875640, "book_runes_failed");
        level thread util::delete_on_death_or_notify(var_a2875640, "book_runes_success");
    }
    while (level.var_be50c24f < level.var_6000c357.size) {
        level thread namespace_f153ce01::function_e3fb6380();
        e_player = self waittill(#"trigger_activated");
        if (isdefined(level.var_63fa69fd)) {
            level notify(#"hash_6760e3ae");
            level clientfield::set("arena_timeout_warning", 0);
            if (level.var_63fa69fd == level.var_6000c357[level.var_be50c24f]) {
                var_bc16de8b[level.var_be50c24f] setmodel("p7_zm_gen_rune_" + level.var_63fa69fd + 1 + "_yellow");
                level.var_5da45153 = array::exclude(level.var_5da45153, level.var_63fa69fd);
                level.var_be50c24f++;
                e_player playsound("zmb_main_bookish_rune_choose_good");
                level notify(#"hash_ef87390a");
                continue;
            }
            e_player playsound("zmb_main_bookish_rune_choose_fail");
            wait(1.4);
            level flag::set("book_runes_failed");
        }
    }
    wait(1.4);
    level flag::set("book_runes_success");
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xa52e5dd8, Offset: 0x7060
// Size: 0x204
function function_54e04357() {
    var_edface0 = 3;
    var_5420f48f = array("castle", "sheffield", "prison", "verrucht");
    foreach (e_player in level.activeplayers) {
        var_7685fe6c = array::random(var_5420f48f);
        var_5420f48f = array::exclude(var_5420f48f, var_7685fe6c);
        var_6a5f0a7f = struct::get_array("apothican_exit_" + var_7685fe6c + "_pos", "targetname");
        playfx(level._effect["portal_3p"], e_player.origin);
        e_player playlocalsound("zmb_teleporter_teleport_2d");
        playsoundatposition("zmb_teleporter_teleport_out", e_player.origin);
        level thread namespace_f153ce01::function_14c1c18d(e_player, var_6a5f0a7f, var_edface0);
    }
    level flag::clear("arena_occupied_by_player");
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x722ff0a4, Offset: 0x7270
// Size: 0x9c
function function_fd4d6a5a() {
    level flag::wait_till("boss_rush");
    level clientfield::set("ee_quest_state", 8);
    level function_1bb1bf93();
    level flag::clear("boss_rush");
    level flag::set("grand_tour");
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x92d7c7d5, Offset: 0x7318
// Size: 0x60
function function_1bb1bf93() {
    /#
        if (level flag::get("sophia_transition_fx")) {
            return;
        }
    #/
    level thread namespace_f153ce01::function_655271b9();
    level thread namespace_c149ef1::function_273b3233();
    level waittill(#"hash_7af29ab");
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x46fa8b0a, Offset: 0x7380
// Size: 0xa4
function function_1057ea39() {
    level flag::wait_till("grand_tour");
    level clientfield::set("ee_quest_state", 9);
    function_513909b2();
    function_79fd9323();
    level flag::set("toys_collected");
    level clientfield::set("ee_quest_state", 10);
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xb6fdbd92, Offset: 0x7430
// Size: 0x44
function function_513909b2() {
    /#
        if (level flag::get("sophia_transition_fx")) {
            return;
        }
    #/
    level namespace_f153ce01::function_11a85c29(level.var_62552381);
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0xa8700990, Offset: 0x7480
// Size: 0x214
function function_79fd9323() {
    /#
        if (level flag::get("sophia_transition_fx")) {
            return;
        }
    #/
    level.idleflagreturntime = 5;
    level thread namespace_f153ce01::function_b1e065cd();
    level.var_6e907685 = [];
    for (i = 0; i < 7; i++) {
        var_f03dd5b1 = struct::get("ee_grand_tour_toy_0" + i, "targetname");
        if (!isdefined(level.var_6e907685)) {
            level.var_6e907685 = [];
        } else if (!isarray(level.var_6e907685)) {
            level.var_6e907685 = array(level.var_6e907685);
        }
        level.var_6e907685[level.var_6e907685.size] = var_f03dd5b1;
        var_39018584 = getent(var_f03dd5b1.target, "targetname");
        var_39018584 notsolid();
    }
    level thread function_27b96bc();
    util::waittill_multiple_ents(level.var_6e907685[0], "toy_found", level.var_6e907685[1], "toy_found", level.var_6e907685[2], "toy_found", level.var_6e907685[3], "toy_found", level.var_6e907685[4], "toy_found", level.var_6e907685[5], "toy_found", level.var_6e907685[6], "toy_found");
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x844b9bc4, Offset: 0x76a0
// Size: 0x650
function function_27b96bc() {
    level endon(#"hash_7aa78dfa");
    var_cb6acc3e = undefined;
    while (level.var_6e907685.size) {
        e_ball = level.ball;
        var_d6ba68c5 = e_ball.visuals[0];
        var_766335a0 = var_d6ba68c5.origin;
        if (isdefined(e_ball.isresetting) && (isdefined(e_ball.carrier) || e_ball.isresetting)) {
            util::wait_network_frame();
            continue;
        } else if (isdefined(var_cb6acc3e) && var_766335a0 != var_cb6acc3e && distancesquared(var_766335a0, var_cb6acc3e) < 40000) {
            foreach (var_f03dd5b1 in level.var_6e907685) {
                var_32769d76 = pointonsegmentnearesttopoint(var_766335a0, var_cb6acc3e, var_f03dd5b1.origin);
                var_7dac19aa = var_32769d76 - var_f03dd5b1.origin;
                n_length = length(var_7dac19aa);
                /#
                    assert(isdefined(var_f03dd5b1.radius), "sophia_transition_fx");
                #/
                if (n_length < var_f03dd5b1.radius) {
                    var_29c135aa = util::spawn_model(var_f03dd5b1.model, var_f03dd5b1.origin, var_f03dd5b1.angles);
                    var_29c135aa setscale(var_f03dd5b1.script_float);
                    var_29c135aa notsolid();
                    switch (var_f03dd5b1.script_string) {
                    case 181:
                        var_39815a1b = (0, 0, 160);
                        break;
                    case 180:
                        var_39815a1b = vectornormalize(e_ball.lastcarrier.origin - var_f03dd5b1.origin) * -96;
                        break;
                    default:
                        /#
                            assert("sophia_transition_fx");
                        #/
                        break;
                    }
                    var_29c135aa thread function_e2a94206(var_39815a1b);
                    level.var_6e907685 = array::exclude(level.var_6e907685, var_f03dd5b1);
                    e_ball thread ball::function_b8faebaf(5);
                    var_39018584 = getent(var_f03dd5b1.target, "targetname");
                    playsoundatposition("zmb_gen_ee_toy_found", var_f03dd5b1.origin);
                    wait(4.8);
                    var_39018584 delete();
                    level thread namespace_c149ef1::function_e644549c(e_ball.lastcarrier);
                    var_f03dd5b1 notify(#"hash_e259c52a");
                    /#
                        iprintlnbold("sophia_transition_fx");
                    #/
                    if (level.var_6e907685.size) {
                        if (var_f03dd5b1.target == "ee_grand_tour_origins") {
                            e_ball ball::function_98827162(1, e_ball.lastcarrier.origin, 1);
                        } else {
                            var_b99670e6 = distance2d(e_ball.lastcarrier.origin, var_f03dd5b1.origin);
                            var_43b88dc1 = var_b99670e6 * 0.3;
                            n_z_diff = abs(e_ball.lastcarrier.origin[2] - var_f03dd5b1.origin[2]);
                            var_43b88dc1 += n_z_diff * 0.5;
                            var_43b88dc1 += -106;
                            v_force = e_ball.lastcarrier.origin + (0, 0, var_43b88dc1) - var_766335a0;
                            e_ball thread ball::function_fed77788(var_766335a0, v_force);
                        }
                        continue;
                    }
                    e_ball ball::function_a41df27c();
                }
            }
        }
        var_cb6acc3e = var_766335a0;
        util::wait_network_frame();
    }
}

// Namespace namespace_fdab22a5
// Params 1, eflags: 0x1 linked
// Checksum 0xae48a2a3, Offset: 0x7cf8
// Size: 0x134
function function_e2a94206(var_39815a1b) {
    self clientfield::set("grand_tour_found_toy_fx", 1);
    self moveto(self.origin + var_39815a1b, 5);
    self thread function_7134f126();
    self waittill(#"movedone");
    var_ed98644e = vectornormalize((-6130, 390, -106) - self.origin);
    var_ed98644e = (var_ed98644e[0], var_ed98644e[1], 0);
    var_ed98644e *= 3072;
    var_ed98644e += self.origin;
    n_time = self zm_utility::fake_physicslaunch(var_ed98644e, 70);
    wait(n_time);
    self delete();
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x42eacf98, Offset: 0x7e38
// Size: 0x58
function function_7134f126() {
    self endon(#"movedone");
    while (true) {
        self rotateto(self.angles + (0, 180, 0), 0.83);
        wait(0.78);
    }
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x23eb74e6, Offset: 0x7e98
// Size: 0x64
function function_d86f4446() {
    self endon(#"reset");
    self endon(#"pickup_object");
    var_6c9f55e = self function_48e1990b();
    self ball::function_98827162(1, var_6c9f55e.origin, 1);
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x672c4f6c, Offset: 0x7f08
// Size: 0x158
function function_48e1990b() {
    self endon(#"reset");
    self endon(#"pickup_object");
    var_d6ba68c5 = self.visuals[0];
    wait(60);
    var_6c9f55e = self.lastcarrier;
    for (str_zone = var_6c9f55e zm_zonemgr::get_player_zone(); isdefined(var_6c9f55e.teleporting) && (isdefined(var_6c9f55e.is_flung) && (var_d6ba68c5 namespace_cb655c88::function_37a5b776() || !(isdefined(zm_utility::is_player_valid(var_6c9f55e)) && zm_utility::is_player_valid(var_6c9f55e)) || var_6c9f55e.is_flung) || var_6c9f55e.teleporting) || !isdefined(str_zone); str_zone = var_6c9f55e zm_zonemgr::get_player_zone()) {
        wait(2);
        var_6c9f55e array::random(level.players);
    }
    return var_6c9f55e;
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x6a0f56cc, Offset: 0x8068
// Size: 0x94
function function_af6d9a0b() {
    level flag::wait_till("toys_collected");
    level thread function_1661918a();
    level flag::wait_till("boss_fight");
    level clientfield::set("ee_quest_state", 11);
    wait(5);
    namespace_f153ce01::function_386f30f4();
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x6ce0c7e1, Offset: 0x8108
// Size: 0x12c
function function_1661918a() {
    /#
        if (level flag::get("sophia_transition_fx")) {
            return;
        }
    #/
    level flag::clear("teleporter_cooldown");
    level.var_a090a655 clientfield::set("electric_charge", 1);
    wait(1);
    level flag::set("teleporter_on");
    level flag::wait_till_clear("teleporter_on");
    level.var_a090a655 clientfield::set("electric_charge", 0);
    if (!level flag::get("boss_fight")) {
        level flag::set("teleporter_cooldown");
        level waittill(#"start_of_round");
        self thread function_1661918a();
    }
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x75a23ad2, Offset: 0x8240
// Size: 0x294
function function_6f8c2ea3() {
    level flag::wait_till("ending_room");
    foreach (player in level.players) {
        player.var_4870991a = 1;
    }
    scene::init("genesis_ee_sams_room");
    scene::add_scene_func("genesis_ee_sams_room", &function_1f70c707, "play");
    level clientfield::set("ee_quest_state", 12);
    var_221e828b = struct::get_array("sams_room_pos", "script_noteworthy");
    foreach (e_player in level.players) {
        e_player zm_utility::create_streamer_hint(var_221e828b[0].origin, var_221e828b[0].angles, 1);
    }
    wait(level.var_bcadbc9d);
    self notify(#"hash_d75099e");
    namespace_cb655c88::function_342295d8("samanthas_room_zone");
    level.var_7d7ca0ea namespace_b2e08b6c::teleport_players(var_221e828b, 1, 1, 1);
    music::setmusicstate("samroom");
    level thread scene::play("genesis_ee_sams_room");
    level waittill(#"hash_f468c531");
    level thread function_ec27cd4b(0);
}

// Namespace namespace_fdab22a5
// Params 1, eflags: 0x1 linked
// Checksum 0x316272e9, Offset: 0x84e0
// Size: 0xbe
function function_1f70c707(a_ents) {
    foreach (e_object in a_ents) {
        if (e_object.model === "p7_zm_gen_dark_arena_sphere_metal") {
            e_object clientfield::set("sophia_eye_on", 1);
            break;
        }
    }
}

// Namespace namespace_fdab22a5
// Params 2, eflags: 0x0
// Checksum 0x6764bcae, Offset: 0x85a8
// Size: 0x8e
function function_941e28ac(var_3a814173, var_b53c9eef) {
    self endon(#"hash_16c08c30");
    if (var_b53c9eef < 0.1) {
        var_b53c9eef = 0.1;
    }
    while (true) {
        var_3a814173 rotateto(var_3a814173.angles + (0, 180, 0), var_b53c9eef);
        wait(var_b53c9eef - 0.05);
    }
}

// Namespace namespace_fdab22a5
// Params 1, eflags: 0x1 linked
// Checksum 0x2ad0244, Offset: 0x8640
// Size: 0x144
function function_ec27cd4b(n_val) {
    lui::prime_movie("zm_genesis_outro", 0, "TDCIWGg1ckRAkdSa3Bip7lMzQhTp+sjnC8dDCTB0cSAAAAAAAAAAAA==");
    function_64e4c3ee(1);
    level thread lui::screen_fade_out(1);
    wait(0.95);
    level flag::clear("spawn_zombies");
    level thread namespace_f153ce01::function_ab51bfd();
    level lui::play_movie("zm_genesis_outro", "fullscreen", 0, 0, "TDCIWGg1ckRAkdSa3Bip7lMzQhTp+sjnC8dDCTB0cSAAAAAAAAAAAA==");
    level.custom_intermission = &function_43af724a;
    level clientfield::set("GenesisEndGameEEScreen", 1);
    level notify(#"end_game");
    level thread function_ac21a82d(1, 2);
    wait(10);
    function_64e4c3ee(0);
}

// Namespace namespace_fdab22a5
// Params 2, eflags: 0x1 linked
// Checksum 0xa458c80f, Offset: 0x8790
// Size: 0x34
function function_ac21a82d(n_wait_time, var_caadaee2) {
    wait(n_wait_time);
    lui::screen_fade_in(var_caadaee2);
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x87d0
// Size: 0x4
function function_43af724a() {
    
}

// Namespace namespace_fdab22a5
// Params 1, eflags: 0x1 linked
// Checksum 0x409b615c, Offset: 0x87e0
// Size: 0xe2
function function_64e4c3ee(var_a5efd39d) {
    if (!isdefined(var_a5efd39d)) {
        var_a5efd39d = 1;
    }
    foreach (e_player in level.activeplayers) {
        if (var_a5efd39d) {
            e_player enableinvulnerability();
        } else {
            e_player disableinvulnerability();
        }
        e_player util::freeze_player_controls(var_a5efd39d);
    }
}

// Namespace namespace_fdab22a5
// Params 2, eflags: 0x0
// Checksum 0x9ea5c29, Offset: 0x88d0
// Size: 0xb4
function pause_zombies(b_pause, var_9d3d4d3f) {
    if (!isdefined(b_pause)) {
        b_pause = 0;
    }
    if (!isdefined(var_9d3d4d3f)) {
        var_9d3d4d3f = 1;
    }
    if (b_pause) {
        level.disable_nuke_delay_spawning = 1;
        level flag::clear("spawn_zombies");
        function_5db6ba34(var_9d3d4d3f);
        return;
    }
    level.disable_nuke_delay_spawning = 0;
    level flag::set("spawn_zombies");
}

// Namespace namespace_fdab22a5
// Params 1, eflags: 0x1 linked
// Checksum 0xf305c856, Offset: 0x8990
// Size: 0x554
function function_5db6ba34(var_1a60ad71) {
    if (!isdefined(var_1a60ad71)) {
        var_1a60ad71 = 1;
    }
    if (var_1a60ad71) {
        level thread lui::screen_flash(0.2, 0.5, 1, 0.8, "white");
    }
    wait(0.5);
    a_ai_zombies = getaiteamarray(level.zombie_team);
    var_6b1085eb = [];
    foreach (ai_zombie in a_ai_zombies) {
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
    var_6cbdc65 = [];
    var_c94c86a8 = getentarray("mechz", "targetname");
    foreach (var_99c3dd59 in var_c94c86a8) {
        var_63b71acf = 0;
        if (isdefined(var_99c3dd59.no_damage_points) && var_99c3dd59.no_damage_points) {
            var_63b71acf = 1;
        }
        if (!isdefined(var_6cbdc65)) {
            var_6cbdc65 = [];
        } else if (!isarray(var_6cbdc65)) {
            var_6cbdc65 = array(var_6cbdc65);
        }
        var_6cbdc65[var_6cbdc65.size] = var_63b71acf;
        var_99c3dd59.no_powerups = 1;
        var_99c3dd59 kill();
    }
    level thread function_3fade785(var_6cbdc65);
}

// Namespace namespace_fdab22a5
// Params 1, eflags: 0x1 linked
// Checksum 0xd311e73, Offset: 0x8ef0
// Size: 0x104
function function_3fade785(var_6cbdc65) {
    level flag::wait_till("spawn_zombies");
    for (i = 0; i < var_6cbdc65.size; i++) {
        for (e_target = array::random(level.players); !zm_utility::is_player_valid(e_target); e_target = array::random(level.players)) {
            wait(0.05);
        }
        s_spawn_pos = arraygetclosest(e_target.origin, level.zm_loc_types["mechz_location"]);
        if (isdefined(s_spawn_pos)) {
        }
    }
}

/#

    // Namespace namespace_fdab22a5
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf0c35b88, Offset: 0x9000
    // Size: 0x3dc
    function function_ea08fd1f() {
        level thread namespace_cb655c88::function_72260d3a("sophia_transition_fx", "sophia_transition_fx", 1, &function_14d67389);
        level thread namespace_cb655c88::function_72260d3a("sophia_transition_fx", "sophia_transition_fx", 2, &function_14d67389);
        level thread namespace_cb655c88::function_72260d3a("sophia_transition_fx", "sophia_transition_fx", 3, &function_14d67389);
        level thread namespace_cb655c88::function_72260d3a("sophia_transition_fx", "sophia_transition_fx", 1, &function_b3e7fd04);
        level thread namespace_cb655c88::function_72260d3a("sophia_transition_fx", "sophia_transition_fx", 2, &function_b3e7fd04);
        level thread namespace_cb655c88::function_72260d3a("sophia_transition_fx", "sophia_transition_fx", 3, &function_b3e7fd04);
        level thread namespace_cb655c88::function_72260d3a("sophia_transition_fx", "sophia_transition_fx", 1, &function_2e1bc559);
        level thread namespace_cb655c88::function_72260d3a("sophia_transition_fx", "sophia_transition_fx", 4, &function_14d67389);
        level thread namespace_cb655c88::function_72260d3a("sophia_transition_fx", "sophia_transition_fx", 5, &function_14d67389);
        level thread namespace_cb655c88::function_72260d3a("sophia_transition_fx", "sophia_transition_fx", 6, &function_14d67389);
        level thread namespace_cb655c88::function_72260d3a("sophia_transition_fx", "sophia_transition_fx", 7, &function_14d67389);
        level thread namespace_cb655c88::function_72260d3a("sophia_transition_fx", "sophia_transition_fx", 8, &function_14d67389);
        level thread namespace_cb655c88::function_72260d3a("sophia_transition_fx", "sophia_transition_fx", 9, &function_14d67389);
        level thread namespace_cb655c88::function_72260d3a("sophia_transition_fx", "sophia_transition_fx", 10, &function_14d67389);
        level thread namespace_cb655c88::function_72260d3a("sophia_transition_fx", "sophia_transition_fx", 11, &function_14d67389);
        level thread namespace_cb655c88::function_72260d3a("sophia_transition_fx", "sophia_transition_fx", 12, &function_14d67389);
        level flag::init("sophia_transition_fx");
        level thread namespace_cb655c88::function_72260d3a("sophia_transition_fx", "sophia_transition_fx", 0, &function_ec27cd4b);
    }

    // Namespace namespace_fdab22a5
    // Params 1, eflags: 0x1 linked
    // Checksum 0x8580c3ed, Offset: 0x93e8
    // Size: 0x506
    function function_14d67389(n_val) {
        if (n_val >= 1) {
            level thread zm_devgui::zombie_devgui_open_sesame();
            level flag::set("sophia_transition_fx");
            namespace_bf6feb71::function_2fb1022e(1);
            namespace_bf6feb71::function_2fb1022e(2);
            namespace_bf6feb71::function_2fb1022e(3);
            level flag::set("sophia_transition_fx");
        }
        if (n_val >= 2) {
            level flag::set("sophia_transition_fx");
            level flag::set("sophia_transition_fx");
            level flag::set("sophia_transition_fx");
            foreach (e_player in level.activeplayers) {
                level thread namespace_ccb5d78d::function_e53a7954(e_player);
            }
        }
        if (n_val >= 3) {
            level flag::set("sophia_transition_fx");
            level flag::set("sophia_transition_fx");
        }
        if (n_val >= 4) {
            level flag::set("sophia_transition_fx");
            level flag::set("sophia_transition_fx");
            level flag::set("sophia_transition_fx");
        }
        if (n_val >= 5) {
            level flag::set("sophia_transition_fx");
        }
        if (n_val >= 6) {
            level flag::set("sophia_transition_fx");
            level flag::set("sophia_transition_fx");
            level flag::set("sophia_transition_fx");
        }
        if (n_val >= 7) {
            level flag::set("sophia_transition_fx");
            level flag::set("sophia_transition_fx");
            level flag::set("sophia_transition_fx");
        }
        if (n_val >= 8) {
            level.activeplayers[0] namespace_cb655c88::function_bb26d959(2);
            level.activeplayers[0] namespace_cb655c88::function_bb26d959(3);
            level.activeplayers[0] namespace_cb655c88::function_bb26d959(1);
            level.activeplayers[0] namespace_cb655c88::function_bb26d959(0);
            level flag::set("sophia_transition_fx");
            if (!isdefined(level.var_6000c357)) {
                function_69f6c616();
            }
            level flag::set("sophia_transition_fx");
        }
        if (n_val >= 9) {
            level.var_62552381 = 1;
            level flag::set("sophia_transition_fx");
        }
        if (n_val >= 10) {
            level flag::set("sophia_transition_fx");
        }
        if (n_val >= 11) {
            level flag::set("sophia_transition_fx");
        }
        if (n_val >= 12) {
            level flag::set("sophia_transition_fx");
        }
        wait(1);
        level notify(#"hash_38b4845b");
    }

    // Namespace namespace_fdab22a5
    // Params 1, eflags: 0x1 linked
    // Checksum 0x65b24ca, Offset: 0x98f8
    // Size: 0x34
    function function_b3e7fd04(n_val) {
        level flag::set("sophia_transition_fx" + n_val);
    }

    // Namespace namespace_fdab22a5
    // Params 1, eflags: 0x1 linked
    // Checksum 0xe09248c8, Offset: 0x9938
    // Size: 0xc2
    function function_2e1bc559(n_val) {
        var_2efcd138 = getentarray("sophia_transition_fx", "sophia_transition_fx");
        foreach (mdl_bone in var_2efcd138) {
            mdl_bone thread function_156b5313();
        }
    }

#/
