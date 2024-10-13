#using scripts/zm/zm_stalingrad_dragon;
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

#namespace zm_stalingrad_audio;

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x2
// Checksum 0x7aff6e3c, Offset: 0x600
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_stalingrad_audio", &__init__, undefined, undefined);
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x72913155, Offset: 0x640
// Size: 0xb4
function __init__() {
    clientfield::register("scriptmover", "ee_anthem_pa", 12000, 1, "int");
    clientfield::register("scriptmover", "ee_ballerina", 12000, 2, "int");
    level flag::init("ballerina_ready");
    level.var_bf88fef7 = 0;
    level.var_a31a784f = [];
    level.var_a56f5145 = &function_24ff7a78;
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x3366125f, Offset: 0x700
// Size: 0x94
function main() {
    level thread function_af4c67d();
    level thread function_41f49ee8();
    level thread function_5c7f73da();
    level thread function_7584d453();
    level thread function_663128e3();
    level thread function_ae93bb6d();
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x7a0
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xd965837f, Offset: 0x7b0
// Size: 0xb4
function function_af4c67d() {
    level.var_c128c3f5 = 0;
    level.var_9d74f1a7 = struct::get_array("side_ee_song_vodka", "targetname");
    array::thread_all(level.var_9d74f1a7, &function_5583a127);
    while (true) {
        level waittill(#"hash_9727ab41");
        if (level.var_c128c3f5 == level.var_9d74f1a7.size) {
            break;
        }
    }
    level thread zm_audio::sndmusicsystem_playstate("dead_ended");
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x8026e513, Offset: 0x870
// Size: 0x164
function function_5583a127() {
    e_origin = spawn("script_origin", self.origin);
    e_origin zm_unitrigger::create_unitrigger();
    e_origin playloopsound("zmb_ee_mus_lp", 1);
    /#
        e_origin thread function_8faf1d24((0, 0, 255), "<dev string:x28>");
    #/
    while (!(isdefined(e_origin.b_activated) && e_origin.b_activated)) {
        e_origin waittill(#"trigger_activated");
        if (isdefined(level.musicsystemoverride) && (isdefined(level.musicsystem.currentplaytype) && level.musicsystem.currentplaytype >= 4 || level.musicsystemoverride)) {
            continue;
        }
        e_origin function_81b46338();
    }
    zm_unitrigger::unregister_unitrigger(e_origin.s_unitrigger);
    e_origin delete();
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x55c80692, Offset: 0x9e0
// Size: 0x7c
function function_81b46338() {
    if (!(isdefined(self.b_activated) && self.b_activated)) {
        self.b_activated = 1;
        level.var_c128c3f5++;
        level notify(#"hash_9727ab41");
        self stoploopsound(0.2);
    }
    self playsound("zmb_ee_mus_activate");
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x830aaaa4, Offset: 0xa68
// Size: 0xb4
function function_41f49ee8() {
    level.var_62e63d78 = 0;
    level.var_68982832 = struct::get_array("side_ee_song_card", "targetname");
    array::thread_all(level.var_68982832, &function_f021c688);
    while (true) {
        level waittill(#"hash_ce64d360");
        if (level.var_62e63d78 == level.var_68982832.size) {
            break;
        }
    }
    level thread zm_audio::sndmusicsystem_playstate("ace_of_spades");
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x5c9a900a, Offset: 0xb28
// Size: 0x11c
function function_f021c688() {
    self zm_unitrigger::create_unitrigger();
    /#
        self thread function_8faf1d24((0, 0, 255), "<dev string:x2c>");
    #/
    while (!(isdefined(self.b_activated) && self.b_activated)) {
        self waittill(#"trigger_activated");
        if (isdefined(level.musicsystemoverride) && (isdefined(level.musicsystem.currentplaytype) && level.musicsystem.currentplaytype >= 4 || level.musicsystemoverride)) {
            continue;
        }
        self.b_activated = 1;
        level.var_62e63d78++;
        level notify(#"hash_ce64d360");
        playsoundatposition("zmb_card_activate", self.origin);
    }
    zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
}

/#

    // Namespace zm_stalingrad_audio
    // Params 4, eflags: 0x1 linked
    // Checksum 0x566fd8dd, Offset: 0xc50
    // Size: 0x108
    function function_8faf1d24(v_color, var_8882142e, n_scale, str_endon) {
        if (!isdefined(v_color)) {
            v_color = (0, 0, 255);
        }
        if (!isdefined(var_8882142e)) {
            var_8882142e = "<dev string:x30>";
        }
        if (!isdefined(n_scale)) {
            n_scale = 0.25;
        }
        if (!isdefined(str_endon)) {
            str_endon = "<dev string:x32>";
        }
        if (getdvarint("<dev string:x44>") == 0) {
            return;
        }
        if (isdefined(str_endon)) {
            self endon(str_endon);
        }
        origin = self.origin;
        while (true) {
            print3d(origin, var_8882142e, v_color, n_scale);
            wait 0.1;
        }
    }

#/

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xc396d92e, Offset: 0xd60
// Size: 0x5c
function function_ae93bb6d() {
    var_8e47507d = struct::get_array("creepyyuse", "targetname");
    if (!isdefined(var_8e47507d)) {
        return;
    }
    array::thread_all(var_8e47507d, &function_d75eac4e);
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xc29eaa49, Offset: 0xdc8
// Size: 0x5e
function function_d75eac4e() {
    self zm_unitrigger::create_unitrigger(undefined, 50);
    while (true) {
        self waittill(#"trigger_activated");
        playsoundatposition(self.script_sound, self.origin);
        wait -56;
    }
}

// Namespace zm_stalingrad_audio
// Params 1, eflags: 0x0
// Checksum 0x1371cedf, Offset: 0xe30
// Size: 0xee
function function_e01c1b04(var_99ad39b9) {
    if (var_99ad39b9.size <= 0) {
        return;
    }
    while (true) {
        var_4237d65e = randomintrange(0, var_99ad39b9.size);
        var_99ad39b9[var_4237d65e] zm_unitrigger::create_unitrigger(undefined, 24);
        var_99ad39b9[var_4237d65e] waittill(#"trigger_activated");
        playsoundatposition(var_99ad39b9[var_4237d65e].script_sound, var_99ad39b9[var_4237d65e].origin);
        zm_unitrigger::unregister_unitrigger(var_99ad39b9[var_4237d65e].unitrigger);
        wait -106;
    }
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x2662e74e, Offset: 0xf28
// Size: 0x19e
function function_5c7f73da() {
    for (i = 1; i < 6; i++) {
        var_2de8cf5e = struct::get_array("ee_sophia_reels_" + i, "targetname");
        if (var_2de8cf5e.size <= 0) {
            return;
        }
        foreach (s_reel in var_2de8cf5e) {
            var_de6d4fc0 = util::spawn_model(s_reel.model, s_reel.origin, s_reel.angles);
            s_reel.var_de6d4fc0 = var_de6d4fc0;
            s_reel.var_de6d4fc0 thread function_e464aa51();
        }
        if (i == 5) {
            level thread function_8c75c164(var_2de8cf5e, i);
            continue;
        }
        level thread function_ab32c346(var_2de8cf5e, i);
    }
}

// Namespace zm_stalingrad_audio
// Params 2, eflags: 0x1 linked
// Checksum 0xbb3fc38, Offset: 0x10d0
// Size: 0xe0
function function_ab32c346(var_2de8cf5e, var_bee8e45) {
    var_2de8cf5e[0] zm_unitrigger::create_unitrigger();
    while (true) {
        who = var_2de8cf5e[0] waittill(#"trigger_activated");
        if (!who zm_utility::is_player_looking_at(var_2de8cf5e[0].origin)) {
            continue;
        }
        function_ccdb680e(var_2de8cf5e, 1);
        var_2de8cf5e[0].var_de6d4fc0 function_8e130ce5(var_bee8e45);
        function_ccdb680e(var_2de8cf5e, 0);
    }
}

// Namespace zm_stalingrad_audio
// Params 2, eflags: 0x1 linked
// Checksum 0x58fbbaaa, Offset: 0x11b8
// Size: 0x180
function function_8c75c164(var_2de8cf5e, var_bee8e45) {
    var_2de8cf5e[0].var_de6d4fc0 setcandamage(1);
    while (true) {
        var_2de8cf5e[0].var_de6d4fc0.health = 1000000;
        damage, attacker, dir, loc, type, model, tag, part, weapon, flags = var_2de8cf5e[0].var_de6d4fc0 waittill(#"damage");
        if (!isdefined(attacker) || !isplayer(attacker)) {
            continue;
        }
        function_ccdb680e(var_2de8cf5e, 1);
        var_2de8cf5e[0].var_de6d4fc0 function_8e130ce5(var_bee8e45);
        function_ccdb680e(var_2de8cf5e, 0);
    }
}

// Namespace zm_stalingrad_audio
// Params 1, eflags: 0x1 linked
// Checksum 0xe4bdf452, Offset: 0x1340
// Size: 0x68
function function_8e130ce5(var_bee8e45) {
    self playsoundwithnotify("vox_soph_sophia_log_" + var_bee8e45, "sounddone");
    if (var_bee8e45 == 2) {
        self playsound("zmb_sophia_log_2_sfx");
    }
    self waittill(#"sounddone");
}

// Namespace zm_stalingrad_audio
// Params 2, eflags: 0x1 linked
// Checksum 0xf25fdbe1, Offset: 0x13b0
// Size: 0xb2
function function_ccdb680e(var_2de8cf5e, b_on) {
    foreach (s_reel in var_2de8cf5e) {
        if (isdefined(s_reel.var_de6d4fc0)) {
            s_reel.var_de6d4fc0.var_a02b0d5a = b_on;
        }
    }
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xf8c30b1a, Offset: 0x1470
// Size: 0x50
function function_e464aa51() {
    while (true) {
        if (isdefined(self.var_a02b0d5a) && self.var_a02b0d5a) {
            self rotateroll(-30, 0.2);
        }
        wait 0.2;
    }
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x95ea34cb, Offset: 0x14c8
// Size: 0x9c
function function_7584d453() {
    level waittill(#"hash_9b1cee4c");
    var_18b908ea = spawn("script_origin", (0, 0, 0));
    var_18b908ea playloopsound("zmb_outro_battle_bg", 1);
    level waittill(#"hash_846351df");
    var_18b908ea stoploopsound(1);
    var_18b908ea delete();
}

// Namespace zm_stalingrad_audio
// Params 1, eflags: 0x1 linked
// Checksum 0xd231f800, Offset: 0x1570
// Size: 0x152
function function_f1ce2a9a(state) {
    if (!isdefined(state)) {
        state = 0;
    }
    level endon(#"end_game");
    switch (state) {
    case 1:
        level.musicsystemoverride = 1;
        music::setmusicstate("none");
        level thread function_61c5cb4e();
        break;
    case 2:
        level thread function_9fa22cf7();
        music::setmusicstate("ace_of_spades");
        level thread function_d0e8b85d();
        break;
    case 3:
        level thread function_9fa22cf7();
        music::setmusicstate("nikolai_fight");
        break;
    case 4:
        level thread function_9fa22cf7();
        music::setmusicstate("none");
        level.musicsystemoverride = 0;
        break;
    }
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x915ae2eb, Offset: 0x16d0
// Size: 0xfc
function function_61c5cb4e() {
    level endon(#"hash_787a404e");
    var_4540293a = struct::get_array("s_anthem_array", "targetname");
    level.var_96d76bfc = 0;
    level.var_c9c5dfcc = var_4540293a.size;
    foreach (var_71f55e40 in var_4540293a) {
        var_71f55e40 thread function_3b8ba4e9();
    }
    wait 68.7;
    level thread function_f1ce2a9a(3);
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xcadcec43, Offset: 0x17d8
// Size: 0x20a
function function_3b8ba4e9() {
    level endon(#"hash_787a404e");
    self.var_1431218c = util::spawn_model(self.model, self.origin, self.angles);
    self.var_1431218c clientfield::set("ee_anthem_pa", 1);
    self.var_1431218c setcandamage(1);
    while (true) {
        self.var_1431218c.health = 1000000;
        damage, attacker, dir, loc, type, model, tag, part, weapon, flags = self.var_1431218c waittill(#"damage");
        if (!isdefined(attacker) || !isplayer(attacker)) {
            continue;
        }
        self.var_1431218c clientfield::set("ee_anthem_pa", 0);
        self.var_1431218c playsound("zmb_nikolai_mus_pa_destruct");
        util::wait_network_frame();
        self.var_1431218c delete();
        self.var_1431218c = undefined;
        level.var_96d76bfc++;
        if (level.var_96d76bfc >= level.var_c9c5dfcc) {
            level thread function_f1ce2a9a(2);
        }
        return;
    }
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x425d82af, Offset: 0x19f0
// Size: 0x128
function function_9fa22cf7() {
    level notify(#"hash_787a404e");
    var_4540293a = struct::get_array("s_anthem_array", "targetname");
    foreach (var_71f55e40 in var_4540293a) {
        if (isdefined(var_71f55e40.var_1431218c)) {
            var_71f55e40.var_1431218c clientfield::set("ee_anthem_pa", 0);
            util::wait_network_frame();
            var_71f55e40.var_1431218c delete();
            var_71f55e40.var_1431218c = undefined;
        }
    }
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x5c143296, Offset: 0x1b20
// Size: 0x3c
function function_d0e8b85d() {
    level endon(#"hash_787a404e");
    level endon(#"end_game");
    wait -86;
    music::setmusicstate("nikolai_fight");
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x5073de6b, Offset: 0x1b68
// Size: 0xd4
function function_663128e3() {
    level flag::wait_till("ballerina_ready");
    wait 8;
    level function_6b495bd6();
    while (true) {
        success = level function_4c503dc7();
        if (!(isdefined(success) && success)) {
            level function_6b495bd6(1);
            continue;
        }
        level function_d64d6d35();
        break;
    }
    level thread zm_audio::sndmusicsystem_playstate("sam");
}

// Namespace zm_stalingrad_audio
// Params 1, eflags: 0x1 linked
// Checksum 0x1238579d, Offset: 0x1c48
// Size: 0x23c
function function_6b495bd6(restart) {
    if (!isdefined(restart)) {
        restart = 0;
    }
    s_ballerina_start = struct::get("s_ballerina_start", "targetname");
    if (!(isdefined(restart) && restart)) {
        playsoundatposition("zmb_sam_egg_success", (0, 0, 0));
        var_ac086ffb = util::spawn_model(s_ballerina_start.model, s_ballerina_start.origin - (0, 0, 20), s_ballerina_start.angles);
        var_ac086ffb clientfield::set("ee_ballerina", 2);
        var_ac086ffb moveto(s_ballerina_start.origin, 2);
        var_ac086ffb waittill(#"movedone");
    } else {
        playsoundatposition("zmb_sam_egg_fail", (0, 0, 0));
        var_ac086ffb = util::spawn_model(s_ballerina_start.model, s_ballerina_start.origin, s_ballerina_start.angles);
        var_ac086ffb clientfield::set("ee_ballerina", 1);
    }
    s_ballerina_start zm_unitrigger::create_unitrigger(undefined, 24);
    s_ballerina_start waittill(#"trigger_activated");
    zm_unitrigger::unregister_unitrigger(s_ballerina_start.unitrigger);
    var_ac086ffb clientfield::set("ee_ballerina", 0);
    util::wait_network_frame();
    var_ac086ffb delete();
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xab83c220, Offset: 0x1e90
// Size: 0xb4
function function_4c503dc7() {
    var_d1f154fd = struct::get_array("s_ballerina_timed", "targetname");
    var_d1f154fd = array::randomize(var_d1f154fd);
    for (i = 0; i < 5; i++) {
        success = var_d1f154fd[i] function_dc391fc3();
        if (!(isdefined(success) && success)) {
            return false;
        }
    }
    return true;
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x5121dec4, Offset: 0x1f50
// Size: 0x19a
function function_dc391fc3() {
    self.var_ac086ffb = util::spawn_model(self.model, self.origin, self.angles);
    self.var_ac086ffb clientfield::set("ee_ballerina", 1);
    self.var_ac086ffb playloopsound("mus_stalingrad_musicbox_lp", 2);
    self.success = 0;
    self thread function_631d8c1();
    self thread function_75442852();
    self thread function_db914e();
    /#
        self.var_ac086ffb thread zm_utility::print3d_ent("<dev string:x51>", (0, 1, 0), 3, (0, 0, 24));
    #/
    self util::waittill_any("ballerina_destroyed", "ballerina_timeout");
    /#
        self.var_ac086ffb notify(#"end_print3d");
    #/
    self.var_ac086ffb clientfield::set("ee_ballerina", 0);
    util::wait_network_frame();
    self.var_ac086ffb delete();
    return self.success;
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x19790812, Offset: 0x20f8
// Size: 0x66
function function_631d8c1() {
    self.var_ac086ffb endon(#"death");
    self endon(#"hash_636d801f");
    self endon(#"ballerina_destroyed");
    self endon(#"ballerina_timeout");
    while (true) {
        self.var_ac086ffb rotateyaw(360, 4);
        wait 4;
    }
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x2a5ea599, Offset: 0x2168
// Size: 0x126
function function_75442852() {
    self endon(#"ballerina_timeout");
    self.var_ac086ffb setcandamage(1);
    self.var_ac086ffb.health = 1000000;
    while (true) {
        damage, attacker, dir, loc, type, model, tag, part, weapon, flags = self.var_ac086ffb waittill(#"damage");
        if (!isdefined(attacker) || !isplayer(attacker)) {
            continue;
        }
        self.success = 1;
        self notify(#"ballerina_destroyed");
        break;
    }
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xcf26ef3f, Offset: 0x2298
// Size: 0x52
function function_db914e() {
    self endon(#"ballerina_destroyed");
    if (level.players.size > 1) {
        wait 90 - 15 * level.players.size;
    } else {
        wait 90;
    }
    self notify(#"ballerina_timeout");
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xfebb029, Offset: 0x22f8
// Size: 0x534
function function_d64d6d35() {
    playsoundatposition("zmb_sam_egg_success", (0, 0, 0));
    s_ballerina_end = struct::get("s_ballerina_end", "targetname");
    s_ballerina_end.var_ac086ffb = util::spawn_model(s_ballerina_end.model, s_ballerina_end.origin, s_ballerina_end.angles);
    s_ballerina_end.var_ac086ffb clientfield::set("ee_ballerina", 1);
    s_ballerina_end.var_ac086ffb playloopsound("mus_stalingrad_musicbox_lp", 2);
    s_ballerina_end thread function_631d8c1();
    s_ballerina_end zm_unitrigger::create_unitrigger(undefined, 65);
    s_ballerina_end waittill(#"trigger_activated");
    zm_unitrigger::unregister_unitrigger(s_ballerina_end.unitrigger);
    s_ballerina_end notify(#"hash_636d801f");
    s_ballerina_end.var_ac086ffb stoploopsound(0.5);
    s_ballerina_end.var_ac086ffb playsound("zmb_challenge_skel_arm_up");
    var_f6c28cea = (2, 0, -6.5);
    var_e97ebb83 = (3.5, 0, -18.5);
    s_ballerina_end.mdl_hand = util::spawn_model("c_zom_dlc1_skeleton_zombie_body_s_rarm", s_ballerina_end.origin, s_ballerina_end.angles);
    s_ballerina_end.var_2a9b65c7 = util::spawn_model("p7_skulls_bones_arm_lower", s_ballerina_end.origin + var_f6c28cea, (180, 0, 0));
    s_ballerina_end.var_79dc7980 = util::spawn_model("p7_skulls_bones_arm_lower", s_ballerina_end.origin + var_e97ebb83, (180, 0, 0));
    s_ballerina_end.var_ac086ffb movez(20, 0.5);
    s_ballerina_end.mdl_hand movez(20, 0.5);
    s_ballerina_end.var_2a9b65c7 movez(20, 0.5);
    s_ballerina_end.var_79dc7980 movez(20, 0.5);
    wait 0.05;
    s_ballerina_end.mdl_hand clientfield::increment("challenge_arm_reveal");
    s_ballerina_end.mdl_hand waittill(#"movedone");
    wait 1;
    s_ballerina_end.var_ac086ffb playloopsound("zmb_challenge_skel_arm_lp", 0.25);
    s_ballerina_end.var_ac086ffb movez(-30, 1.5);
    s_ballerina_end.mdl_hand movez(-30, 1.5);
    s_ballerina_end.var_2a9b65c7 movez(-30, 1.5);
    s_ballerina_end.var_79dc7980 movez(-30, 1.5);
    s_ballerina_end.var_ac086ffb waittill(#"movedone");
    zm_powerups::specific_powerup_drop("full_ammo", s_ballerina_end.origin);
    s_ballerina_end.var_ac086ffb delete();
    s_ballerina_end.mdl_hand delete();
    s_ballerina_end.var_2a9b65c7 delete();
    s_ballerina_end.var_79dc7980 delete();
}

// Namespace zm_stalingrad_audio
// Params 2, eflags: 0x1 linked
// Checksum 0x842c09e2, Offset: 0x2838
// Size: 0x13c
function function_24ff7a78(owner, weapon) {
    var_c4311d6f = dragon::function_69a0541c();
    if (isdefined(var_c4311d6f)) {
        if (array::contains(level.var_a31a784f, var_c4311d6f)) {
            return false;
        }
        var_12bd8497 = getent(var_c4311d6f + "_1_damage", "targetname");
        if (isdefined(var_12bd8497.var_3eb19318) && var_12bd8497.var_3eb19318 && self istouching(var_12bd8497)) {
            array::add(level.var_a31a784f, var_c4311d6f);
            level.var_bf88fef7++;
            if (level.var_bf88fef7 >= 3) {
                level flag::set("ballerina_ready");
                level.var_a56f5145 = undefined;
                return true;
            }
            return true;
        }
    }
    return false;
}

