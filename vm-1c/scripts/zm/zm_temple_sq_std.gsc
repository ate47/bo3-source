#using scripts/zm/zm_temple_sq_skits;
#using scripts/zm/zm_temple_sq_brock;
#using scripts/zm/zm_temple_sq;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_audio;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_7ea42b03;

// Namespace namespace_7ea42b03
// Params 0, eflags: 0x1 linked
// namespace_7ea42b03<file_0>::function_c35e6aab
// Checksum 0x592dc8db, Offset: 0x2f8
// Size: 0x154
function init() {
    namespace_6e97c459::function_5a90ed82("sq", "StD", &init_stage, &function_7747c56, &function_cc3f3f6a);
    namespace_6e97c459::function_b9676730("sq", "StD", 300);
    namespace_6e97c459::function_9a85e396("sq", "StD", "sq_sad_trig", &function_3ea85f63);
    level flag::init("std_target_1");
    level flag::init("std_target_2");
    level flag::init("std_target_3");
    level flag::init("std_target_4");
    level flag::init("std_plot_vo_done");
}

// Namespace namespace_7ea42b03
// Params 0, eflags: 0x1 linked
// namespace_7ea42b03<file_0>::function_bf888e64
// Checksum 0x115d0cac, Offset: 0x458
// Size: 0xfc
function init_stage() {
    util::clientnotify("SR");
    level flag::clear("std_target_1");
    level flag::clear("std_target_2");
    level flag::clear("std_target_3");
    level flag::clear("std_target_4");
    level flag::clear("std_plot_vo_done");
    level thread function_9873f186();
    level thread function_610191ea();
    namespace_abd6a8a5::function_ac4ad5b0();
}

// Namespace namespace_7ea42b03
// Params 0, eflags: 0x1 linked
// namespace_7ea42b03<file_0>::function_9873f186
// Checksum 0xb0791ac9, Offset: 0x560
// Size: 0x2c
function function_9873f186() {
    wait(0.5);
    level thread namespace_435c2400::function_acc79afb("tt5");
}

// Namespace namespace_7ea42b03
// Params 0, eflags: 0x1 linked
// namespace_7ea42b03<file_0>::function_610191ea
// Checksum 0xadf62339, Offset: 0x598
// Size: 0xee
function function_610191ea() {
    level endon(#"hash_c511c0c0");
    struct = struct::get("sq_location_std", "targetname");
    if (!isdefined(struct)) {
        return;
    }
    level.var_fc91036b = spawn("script_origin", struct.origin);
    level.var_fc91036b playloopsound("evt_sq_std_waterthrash_loop", 2);
    level waittill(#"hash_77126d3d");
    level.var_fc91036b stoploopsound(5);
    wait(5);
    level.var_fc91036b delete();
    level.var_fc91036b = undefined;
}

// Namespace namespace_7ea42b03
// Params 0, eflags: 0x1 linked
// namespace_7ea42b03<file_0>::function_63d30912
// Checksum 0xdb4bc310, Offset: 0x690
// Size: 0x70
function function_63d30912() {
    /#
        self endon(#"death");
        self endon(#"hash_5d50fcb7");
        while (!(isdefined(level.disable_print3d_ent) && level.disable_print3d_ent)) {
            print3d(self.origin, "SR", (0, 255, 0), 1);
            wait(0.1);
        }
    #/
}

// Namespace namespace_7ea42b03
// Params 0, eflags: 0x1 linked
// namespace_7ea42b03<file_0>::function_3ea85f63
// Checksum 0x8f3a812, Offset: 0x708
// Size: 0x31c
function function_3ea85f63() {
    if (!isdefined(level.var_b19e3661)) {
        level.var_b19e3661 = 0;
    }
    level.var_68e59898 = 1;
    self thread function_63d30912();
    self thread function_19fed3e();
    self thread function_c62997df();
    self thread function_1d8712b1();
    self playsound("evt_sq_std_spray_start");
    self playloopsound("evt_sq_std_spray_loop", 1);
    trigger = spawn("trigger_damage", self.origin, 0, 32, 32);
    trigger.angles = self.angles + (0, 90, 90);
    var_a4ff74b9 = getweapon("bouncingbetty");
    attacker = undefined;
    while (true) {
        amount, attacker, dir, point, mod, tagname, modelname, partname, weaponname, dflags, inflictor, chargelevel = trigger waittill(#"damage");
        if (weaponname == var_a4ff74b9 && !level.var_b19e3661) {
            level.var_b19e3661 = 1;
            break;
        }
    }
    if (!isdefined(attacker)) {
        attacker = getplayers()[0];
    }
    self notify(#"hash_5d50fcb7", attacker);
    self stoploopsound(1);
    self playsound("evt_sq_std_spray_stop");
    level flag::set("std_target_" + self.script_int);
    util::clientnotify("S" + self.script_int);
    util::delay(0.1, undefined, &function_4fdfc508);
    trigger delete();
}

// Namespace namespace_7ea42b03
// Params 0, eflags: 0x1 linked
// namespace_7ea42b03<file_0>::function_4fdfc508
// Checksum 0x123e5142, Offset: 0xa30
// Size: 0x10
function function_4fdfc508() {
    level.var_b19e3661 = 0;
}

// Namespace namespace_7ea42b03
// Params 0, eflags: 0x1 linked
// namespace_7ea42b03<file_0>::function_1d8712b1
// Checksum 0xb7a882cc, Offset: 0xa48
// Size: 0x6a
function function_1d8712b1() {
    self endon(#"death");
    level endon(#"hash_21d222c8");
    who = self waittill(#"hash_5d50fcb7");
    who thread zm_audio::create_and_play_dialog("eggs", "quest5", 1);
    level notify(#"hash_21d222c8");
}

// Namespace namespace_7ea42b03
// Params 0, eflags: 0x1 linked
// namespace_7ea42b03<file_0>::function_c62997df
// Checksum 0x58e86079, Offset: 0xac0
// Size: 0x10c
function function_c62997df() {
    self endon(#"death");
    level endon(#"hash_44d6d8df");
    level waittill(#"hash_99d9566e");
    while (true) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (isdefined(self.origin) && distancesquared(self.origin, players[i].origin) <= 10000) {
                players[i] thread zm_audio::create_and_play_dialog("eggs", "quest5", 0);
                level notify(#"hash_44d6d8df");
                return;
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_7ea42b03
// Params 0, eflags: 0x1 linked
// namespace_7ea42b03<file_0>::function_19fed3e
// Checksum 0xcd7642dd, Offset: 0xbd8
// Size: 0xdc
function function_19fed3e() {
    self endon(#"death");
    level endon(#"hash_77126d3d");
    while (true) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (distancesquared(self.origin, players[i].origin) <= 10000) {
                level thread function_fd63e028(players[i]);
                level notify(#"hash_77126d3d");
                return;
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_7ea42b03
// Params 0, eflags: 0x1 linked
// namespace_7ea42b03<file_0>::function_7747c56
// Checksum 0xbde3fcb0, Offset: 0xcc0
// Size: 0x23c
function function_7747c56() {
    level flag::wait_till("std_target_1");
    level flag::wait_till("std_target_2");
    level flag::wait_till("std_target_3");
    level flag::wait_till("std_target_4");
    players = getplayers();
    players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("eggs", "quest5", 2);
    level waittill(#"waterfall");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i].var_b4fc5f8d) && players[i].var_b4fc5f8d == 1) {
            players[i] thread zm_audio::create_and_play_dialog("eggs", "quest5", 3);
        }
    }
    level notify(#"hash_bd6f486d");
    level notify(#"hash_15ab69d8");
    level notify(#"hash_87b2d913");
    level notify(#"hash_61b05eaa");
    level notify(#"hash_d3b7cde5");
    level notify(#"hash_adb5537c", 1);
    level waittill(#"hash_ccdffdea");
    level flag::wait_till("std_plot_vo_done");
    wait(5);
    namespace_6e97c459::function_2f3ced1f("sq", "StD");
}

// Namespace namespace_7ea42b03
// Params 1, eflags: 0x1 linked
// namespace_7ea42b03<file_0>::function_cc3f3f6a
// Checksum 0xec8ba215, Offset: 0xf08
// Size: 0x196
function function_cc3f3f6a(success) {
    var_cefa6d0 = getentarray("sq_sad", "targetname");
    util::clientnotify("ksd");
    level flag::clear("std_target_1");
    level flag::clear("std_target_2");
    level flag::clear("std_target_3");
    level flag::clear("std_target_4");
    if (success) {
        namespace_abd6a8a5::function_67e052f1(6);
        namespace_1e4bbaa5::function_439a6a14();
    } else {
        namespace_abd6a8a5::function_67e052f1(5);
        level thread namespace_435c2400::function_b6268f3d();
    }
    if (isdefined(level.var_e650672d)) {
        level.var_e650672d delete();
        level.var_e650672d = undefined;
    }
    if (isdefined(level.var_fc91036b)) {
        level.var_fc91036b delete();
        level.var_fc91036b = undefined;
    }
}

// Namespace namespace_7ea42b03
// Params 1, eflags: 0x1 linked
// namespace_7ea42b03<file_0>::function_fd63e028
// Checksum 0xe3c52305, Offset: 0x10a8
// Size: 0x152
function function_fd63e028(player) {
    level endon(#"hash_c511c0c0");
    struct = struct::get("sq_location_std", "targetname");
    if (!isdefined(struct)) {
        return;
    }
    level.var_e650672d = spawn("script_origin", struct.origin);
    level thread function_2a0eb416();
    level.var_e650672d playsoundwithnotify("vox_egg_story_4_0", "sounddone");
    level.var_e650672d waittill(#"sounddone");
    if (isdefined(player)) {
        level.var_c502e691 = 1;
        player playsoundwithnotify("vox_egg_story_4_1" + namespace_1e4bbaa5::function_26186755(player.characterindex), "vox_egg_sounddone");
        player waittill(#"hash_a1f549aa");
        level.var_c502e691 = 0;
    }
    level notify(#"hash_99d9566e");
}

// Namespace namespace_7ea42b03
// Params 0, eflags: 0x1 linked
// namespace_7ea42b03<file_0>::function_2a0eb416
// Checksum 0xad7b3bcb, Offset: 0x1208
// Size: 0x18e
function function_2a0eb416() {
    level endon(#"hash_c511c0c0");
    count = 0;
    while (true) {
        level waittill(#"waterfall");
        if (!level flag::get("std_target_1") || !level flag::get("std_target_2") || !level flag::get("std_target_3") || !level flag::get("std_target_4")) {
            if (count < 1) {
                level.var_e650672d playsoundwithnotify("vox_egg_story_4_2", "sounddone");
                level.var_e650672d waittill(#"sounddone");
                count++;
            }
            continue;
        }
        level.var_e650672d playsoundwithnotify("vox_egg_story_4_3", "sounddone");
        level.var_e650672d waittill(#"sounddone");
        break;
    }
    level flag::set("std_plot_vo_done");
    level.var_e650672d delete();
    level.var_e650672d = undefined;
}

