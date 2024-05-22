#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/music_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_52adc03e;

// Namespace namespace_52adc03e
// Params 0, eflags: 0x2
// Checksum 0xfd484e66, Offset: 0x728
// Size: 0x34
function function_2dc19561() {
    system::register("zm_audio_zhd", &__init__, undefined, undefined);
}

// Namespace namespace_52adc03e
// Params 0, eflags: 0x0
// Checksum 0x5f5830f0, Offset: 0x768
// Size: 0x114
function __init__() {
    level flag::init("snd_zhdegg_activate");
    level flag::init("snd_zhdegg_completed");
    level flag::init("snd_song_completed");
    clientfield::register("scriptmover", "snd_zhdegg", 21000, 2, "int");
    clientfield::register("scriptmover", "snd_zhdegg_arm", 21000, 1, "counter");
    level.var_252a085b = 0;
    level thread function_f9e823ac();
    level thread function_e1e44e18();
    level thread setup_personality_character_exerts();
}

// Namespace namespace_52adc03e
// Params 0, eflags: 0x0
// Checksum 0xbe35ad5a, Offset: 0x888
// Size: 0x114
function function_f9e823ac() {
    level flag::wait_till("snd_zhdegg_activate");
    level function_513f51e1();
    while (true) {
        if (isdefined(level.var_61f315ab)) {
            success = [[ level.var_61f315ab ]]();
        } else {
            success = level function_cf1b154();
        }
        if (!(isdefined(success) && success)) {
            level function_513f51e1(1);
            continue;
        }
        if (isdefined(level.var_8229c449)) {
            level [[ level.var_8229c449 ]]();
        } else {
            level function_5b2770da();
        }
        break;
    }
    level thread zm_audio::sndmusicsystem_playstate("sam");
}

// Namespace namespace_52adc03e
// Params 1, eflags: 0x0
// Checksum 0x345b4a4, Offset: 0x9a8
// Size: 0x24c
function function_513f51e1(restart) {
    if (!isdefined(restart)) {
        restart = 0;
    }
    var_6175d76c = struct::get("s_ballerina_start", "targetname");
    if (!isdefined(var_6175d76c)) {
        return;
    }
    if (!(isdefined(restart) && restart)) {
        playsoundatposition("zmb_sam_egg_success", (0, 0, 0));
        var_ac086ffb = util::spawn_model(var_6175d76c.model, var_6175d76c.origin - (0, 0, 20), var_6175d76c.angles);
        var_ac086ffb clientfield::set("snd_zhdegg", 2);
        var_ac086ffb moveto(var_6175d76c.origin, 2);
        var_ac086ffb waittill(#"movedone");
    } else {
        playsoundatposition("zmb_sam_egg_fail", (0, 0, 0));
        var_ac086ffb = util::spawn_model(var_6175d76c.model, var_6175d76c.origin, var_6175d76c.angles);
        var_ac086ffb clientfield::set("snd_zhdegg", 1);
    }
    var_6175d76c zm_unitrigger::create_unitrigger(undefined, 80);
    var_6175d76c waittill(#"trigger_activated");
    zm_unitrigger::unregister_unitrigger(var_6175d76c.s_unitrigger);
    var_ac086ffb clientfield::set("snd_zhdegg", 0);
    util::wait_network_frame();
    var_ac086ffb delete();
}

// Namespace namespace_52adc03e
// Params 0, eflags: 0x0
// Checksum 0x74e3f3c0, Offset: 0xc00
// Size: 0x114
function function_cf1b154() {
    var_d1f154fd = struct::get_array("s_ballerina_timed", "targetname");
    var_d1f154fd = array::randomize(var_d1f154fd);
    if (isdefined(var_d1f154fd[0].script_int)) {
        var_d1f154fd = array::sort_by_script_int(var_d1f154fd, 1);
    }
    n_amount = var_d1f154fd.size;
    if (n_amount >= 5) {
        n_amount = 5;
    }
    for (i = 0; i < n_amount; i++) {
        success = var_d1f154fd[i] function_3cf3ba48();
        if (!(isdefined(success) && success)) {
            return false;
        }
    }
    return true;
}

// Namespace namespace_52adc03e
// Params 0, eflags: 0x0
// Checksum 0x371b26d3, Offset: 0xd20
// Size: 0x19a
function function_3cf3ba48() {
    self.var_ac086ffb = util::spawn_model(self.model, self.origin, self.angles);
    self.var_ac086ffb clientfield::set("snd_zhdegg", 1);
    self.var_ac086ffb playloopsound("mus_musicbox_lp", 2);
    self.success = 0;
    self thread function_9d55fd08();
    self thread function_2fdaabf3();
    self thread function_a9a34039();
    /#
        self.var_ac086ffb thread zm_utility::print3d_ent("vox_plr_1_exert_pain_0", (0, 1, 0), 3, (0, 0, 24));
    #/
    self util::waittill_any("ballerina_destroyed", "ballerina_timeout");
    /#
        self.var_ac086ffb notify(#"end_print3d");
    #/
    self.var_ac086ffb clientfield::set("snd_zhdegg", 0);
    util::wait_network_frame();
    self.var_ac086ffb delete();
    return self.success;
}

// Namespace namespace_52adc03e
// Params 0, eflags: 0x0
// Checksum 0xa88a6c4b, Offset: 0xec8
// Size: 0x66
function function_9d55fd08() {
    self.var_ac086ffb endon(#"death");
    self endon(#"hash_636d801f");
    self endon(#"hash_72624b2b");
    self endon(#"hash_874b5073");
    while (true) {
        self.var_ac086ffb rotateyaw(360, 4);
        wait(4);
    }
}

// Namespace namespace_52adc03e
// Params 0, eflags: 0x0
// Checksum 0x2419c4f8, Offset: 0xf38
// Size: 0x1a4
function function_2fdaabf3() {
    self endon(#"hash_874b5073");
    self.var_ac086ffb setcandamage(1);
    self.var_ac086ffb.health = 1000000;
    while (true) {
        damage, attacker, dir, loc, type, model, tag, part, weapon, flags = self.var_ac086ffb waittill(#"damage");
        if (isdefined(level.var_252a085b) && level.var_252a085b) {
            continue;
        }
        if (!isdefined(attacker) || !isplayer(attacker)) {
            continue;
        }
        if (type == "MOD_PROJECTILE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_GRENADE" || type == "MOD_EXPLOSIVE") {
            continue;
        }
        self.success = 1;
        self notify(#"hash_72624b2b");
        level.var_252a085b = 1;
        wait(0.1);
        level.var_252a085b = 0;
        break;
    }
}

// Namespace namespace_52adc03e
// Params 0, eflags: 0x0
// Checksum 0x3a2a1d7e, Offset: 0x10e8
// Size: 0x52
function function_a9a34039() {
    self endon(#"hash_72624b2b");
    if (level.players.size > 1) {
        wait(90 - 15 * level.players.size);
    } else {
        wait(90);
    }
    self notify(#"hash_874b5073");
}

// Namespace namespace_52adc03e
// Params 0, eflags: 0x0
// Checksum 0x4c7a9c8d, Offset: 0x1148
// Size: 0x554
function function_5b2770da() {
    playsoundatposition("zmb_sam_egg_success", (0, 0, 0));
    var_2ba18547 = struct::get("s_ballerina_end", "targetname");
    var_2ba18547.var_ac086ffb = util::spawn_model(var_2ba18547.model, var_2ba18547.origin, var_2ba18547.angles);
    var_2ba18547.var_ac086ffb clientfield::set("snd_zhdegg", 1);
    var_2ba18547.var_ac086ffb playloopsound("mus_musicbox_lp", 2);
    var_2ba18547 thread function_9d55fd08();
    var_2ba18547 zm_unitrigger::create_unitrigger(undefined, 65);
    var_2ba18547 waittill(#"trigger_activated");
    zm_unitrigger::unregister_unitrigger(var_2ba18547.s_unitrigger);
    var_2ba18547 notify(#"hash_636d801f");
    var_2ba18547.var_ac086ffb stoploopsound(0.5);
    var_2ba18547.var_ac086ffb playsound("zmb_challenge_skel_arm_up");
    var_f6c28cea = (2, 0, -6.5);
    var_e97ebb83 = (3.5, 0, -18.5);
    var_2ba18547.mdl_hand = util::spawn_model("c_zom_dlc1_skeleton_zombie_body_s_rarm", var_2ba18547.origin, var_2ba18547.angles);
    var_2ba18547.var_2a9b65c7 = util::spawn_model("p7_skulls_bones_arm_lower", var_2ba18547.origin + var_f6c28cea, (180, 0, 0));
    var_2ba18547.var_79dc7980 = util::spawn_model("p7_skulls_bones_arm_lower", var_2ba18547.origin + var_e97ebb83, (180, 0, 0));
    var_2ba18547.var_ac086ffb movez(20, 0.5);
    var_2ba18547.mdl_hand movez(20, 0.5);
    var_2ba18547.var_2a9b65c7 movez(20, 0.5);
    var_2ba18547.var_79dc7980 movez(20, 0.5);
    wait(0.05);
    var_2ba18547.mdl_hand clientfield::increment("snd_zhdegg_arm");
    var_2ba18547.mdl_hand waittill(#"movedone");
    wait(1);
    var_2ba18547.var_ac086ffb playloopsound("zmb_challenge_skel_arm_lp", 0.25);
    var_2ba18547.var_ac086ffb movez(-40, 1.5);
    var_2ba18547.mdl_hand movez(-40, 1.5);
    var_2ba18547.var_2a9b65c7 movez(-40, 1.5);
    var_2ba18547.var_79dc7980 movez(-40, 1.5);
    var_2ba18547.var_ac086ffb waittill(#"movedone");
    zm_powerups::specific_powerup_drop("full_ammo", var_2ba18547.origin);
    var_2ba18547.var_ac086ffb delete();
    var_2ba18547.mdl_hand delete();
    var_2ba18547.var_2a9b65c7 delete();
    var_2ba18547.var_79dc7980 delete();
    level flag::set("snd_zhdegg_completed");
}

// Namespace namespace_52adc03e
// Params 0, eflags: 0x0
// Checksum 0xf3d55119, Offset: 0x16a8
// Size: 0xac
function function_e753d4f() {
    level.var_2a0600f = 0;
    var_8bd44282 = struct::get_array("songstructs", "targetname");
    array::thread_all(var_8bd44282, &function_929c4dba);
    while (true) {
        level waittill(#"hash_9b53c751");
        if (level.var_2a0600f == var_8bd44282.size) {
            break;
        }
    }
    level flag::set("snd_song_completed");
}

// Namespace namespace_52adc03e
// Params 0, eflags: 0x0
// Checksum 0xbab9e1df, Offset: 0x1760
// Size: 0x174
function function_929c4dba() {
    e_origin = spawn("script_origin", self.origin);
    e_origin zm_unitrigger::create_unitrigger();
    e_origin playloopsound("zmb_ee_mus_lp", 1);
    /#
        e_origin thread zm_utility::print3d_ent("vox_plr_1_exert_pain_2", (1, 1, 0), 3, (0, 0, 24));
    #/
    while (!(isdefined(e_origin.b_activated) && e_origin.b_activated)) {
        who = e_origin waittill(#"trigger_activated");
        if (!function_8090042c()) {
            continue;
        }
        who notify(#"hash_9b53c751");
        e_origin function_bd90259b(who);
    }
    /#
        e_origin notify(#"end_print3d");
    #/
    zm_unitrigger::unregister_unitrigger(e_origin.s_unitrigger);
    e_origin delete();
}

// Namespace namespace_52adc03e
// Params 0, eflags: 0x0
// Checksum 0xb17885cf, Offset: 0x18e0
// Size: 0x4e
function function_8090042c() {
    if (isdefined(level.musicsystemoverride) && (isdefined(level.musicsystem.currentplaytype) && level.musicsystem.currentplaytype >= 4 || level.musicsystemoverride)) {
        return false;
    }
    return true;
}

// Namespace namespace_52adc03e
// Params 1, eflags: 0x0
// Checksum 0x358518c3, Offset: 0x1938
// Size: 0x84
function function_bd90259b(e_player) {
    if (!(isdefined(self.b_activated) && self.b_activated)) {
        self.b_activated = 1;
        level.var_2a0600f++;
        level notify(#"hash_9b53c751", e_player);
        self stoploopsound(0.2);
    }
    self playsound("zmb_ee_mus_activate");
}

// Namespace namespace_52adc03e
// Params 0, eflags: 0x0
// Checksum 0x4d77fc2e, Offset: 0x19c8
// Size: 0xc4
function function_e1e44e18() {
    player = level waittill(#"connected");
    var_77754758 = struct::get("snd_monty_radio", "targetname");
    if (!isdefined(var_77754758)) {
        return;
    }
    var_77754758 zm_unitrigger::create_unitrigger();
    var_77754758 waittill(#"trigger_activated");
    playsoundatposition("vox_abcd_radio", var_77754758.origin);
    zm_unitrigger::unregister_unitrigger(var_77754758.s_unitrigger);
}

// Namespace namespace_52adc03e
// Params 0, eflags: 0x0
// Checksum 0x40607143, Offset: 0x1a98
// Size: 0x622
function setup_personality_character_exerts() {
    level.exert_sounds[1]["hitmed"][0] = "vox_plr_0_exert_pain_0";
    level.exert_sounds[1]["hitmed"][1] = "vox_plr_0_exert_pain_1";
    level.exert_sounds[1]["hitmed"][2] = "vox_plr_0_exert_pain_2";
    level.exert_sounds[1]["hitmed"][3] = "vox_plr_0_exert_pain_3";
    level.exert_sounds[1]["hitmed"][4] = "vox_plr_0_exert_pain_4";
    level.exert_sounds[2]["hitmed"][0] = "vox_plr_1_exert_pain_0";
    level.exert_sounds[2]["hitmed"][1] = "vox_plr_1_exert_pain_1";
    level.exert_sounds[2]["hitmed"][2] = "vox_plr_1_exert_pain_2";
    level.exert_sounds[2]["hitmed"][3] = "vox_plr_1_exert_pain_3";
    level.exert_sounds[2]["hitmed"][4] = "vox_plr_1_exert_pain_4";
    level.exert_sounds[3]["hitmed"][0] = "vox_plr_2_exert_pain_0";
    level.exert_sounds[3]["hitmed"][1] = "vox_plr_2_exert_pain_1";
    level.exert_sounds[3]["hitmed"][2] = "vox_plr_2_exert_pain_2";
    level.exert_sounds[3]["hitmed"][3] = "vox_plr_2_exert_pain_3";
    level.exert_sounds[3]["hitmed"][4] = "vox_plr_2_exert_pain_4";
    level.exert_sounds[4]["hitmed"][0] = "vox_plr_3_exert_pain_0";
    level.exert_sounds[4]["hitmed"][1] = "vox_plr_3_exert_pain_1";
    level.exert_sounds[4]["hitmed"][2] = "vox_plr_3_exert_pain_2";
    level.exert_sounds[4]["hitmed"][3] = "vox_plr_3_exert_pain_3";
    level.exert_sounds[4]["hitmed"][3] = "vox_plr_3_exert_pain_4";
    level.exert_sounds[1]["hitlrg"][0] = "vox_plr_0_exert_pain_0";
    level.exert_sounds[1]["hitlrg"][1] = "vox_plr_0_exert_pain_1";
    level.exert_sounds[1]["hitlrg"][2] = "vox_plr_0_exert_pain_2";
    level.exert_sounds[1]["hitlrg"][3] = "vox_plr_0_exert_pain_3";
    level.exert_sounds[1]["hitlrg"][4] = "vox_plr_0_exert_pain_4";
    level.exert_sounds[2]["hitlrg"][0] = "vox_plr_1_exert_pain_0";
    level.exert_sounds[2]["hitlrg"][1] = "vox_plr_1_exert_pain_1";
    level.exert_sounds[2]["hitlrg"][2] = "vox_plr_1_exert_pain_2";
    level.exert_sounds[2]["hitlrg"][3] = "vox_plr_1_exert_pain_3";
    level.exert_sounds[2]["hitlrg"][4] = "vox_plr_1_exert_pain_4";
    level.exert_sounds[3]["hitlrg"][0] = "vox_plr_2_exert_pain_0";
    level.exert_sounds[3]["hitlrg"][1] = "vox_plr_2_exert_pain_1";
    level.exert_sounds[3]["hitlrg"][2] = "vox_plr_2_exert_pain_2";
    level.exert_sounds[3]["hitlrg"][3] = "vox_plr_2_exert_pain_3";
    level.exert_sounds[3]["hitlrg"][4] = "vox_plr_2_exert_pain_4";
    level.exert_sounds[4]["hitlrg"][0] = "vox_plr_3_exert_pain_0";
    level.exert_sounds[4]["hitlrg"][1] = "vox_plr_3_exert_pain_1";
    level.exert_sounds[4]["hitlrg"][2] = "vox_plr_3_exert_pain_2";
    level.exert_sounds[4]["hitlrg"][3] = "vox_plr_3_exert_pain_3";
    level.exert_sounds[4]["hitlrg"][4] = "vox_plr_3_exert_pain_4";
}

// Namespace namespace_52adc03e
// Params 0, eflags: 0x0
// Checksum 0xdf1471f5, Offset: 0x20c8
// Size: 0x54
function set_exert_id() {
    self endon(#"disconnect");
    util::wait_network_frame();
    util::wait_network_frame();
    self zm_audio::setexertvoice(self.characterindex + 1);
}

