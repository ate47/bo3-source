#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_7c57d7e6;

// Namespace namespace_7c57d7e6
// Params 0, eflags: 0x0
// Checksum 0xa2d7d7cb, Offset: 0x318
// Size: 0x54
function init() {
    level thread function_655a4c66();
    level thread function_42b8c382();
    callback::on_connect(&onplayerconnect);
}

// Namespace namespace_7c57d7e6
// Params 0, eflags: 0x0
// Checksum 0x493b2ea8, Offset: 0x378
// Size: 0x64
function onplayerconnect() {
    self thread function_f22b525d();
    self thread function_885001e();
    self thread function_6d544bc9();
    self thread function_b8ed20bf();
}

// Namespace namespace_7c57d7e6
// Params 1, eflags: 0x0
// Checksum 0x358a2d20, Offset: 0x3e8
// Size: 0xb6
function function_e0fadbfc(stat_name) {
    if (level.systemlink) {
        return;
    }
    if (getdvarint("splitscreen_playerCount") == getplayers().size) {
        return;
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] zm_stats::add_global_stat(stat_name, 1);
    }
}

// Namespace namespace_7c57d7e6
// Params 0, eflags: 0x0
// Checksum 0x6da61b3d, Offset: 0x4a8
// Size: 0xbc
function function_655a4c66() {
    level endon(#"end_game");
    level waittill(#"hash_120cf7be");
    level function_e0fadbfc("ZOMBIE_MOON_SIDEQUEST");
    level zm_utility::giveachievement_wrapper("DLC5_ZOM_CRYOGENIC_PARTY", 1);
    level waittill(#"hash_452ade48");
    level waittill(#"hash_8afea16");
    level thread zm::set_sidequest_completed("MOON");
    if (level.xenon) {
        level zm_utility::giveachievement_wrapper("DLC5_ZOM_BIG_BANG_THEORY", 1);
    }
}

// Namespace namespace_7c57d7e6
// Params 0, eflags: 0x0
// Checksum 0xa10f1c60, Offset: 0x570
// Size: 0x94
function function_42b8c382() {
    level endon(#"end_game");
    level flag::wait_till("teleporter_digger_hacked_before_breached");
    level flag::wait_till("hangar_digger_hacked_before_breached");
    level flag::wait_till("biodome_digger_hacked_before_breached");
    /#
    #/
    level zm_utility::giveachievement_wrapper("DLC5_ZOM_GROUND_CONTROL", 1);
}

// Namespace namespace_7c57d7e6
// Params 0, eflags: 0x0
// Checksum 0x325f264d, Offset: 0x610
// Size: 0x2c
function function_f22b525d() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self waittill(#"hash_33f8465d");
    /#
    #/
}

// Namespace namespace_7c57d7e6
// Params 0, eflags: 0x0
// Checksum 0x3b2a44d8, Offset: 0x648
// Size: 0x68
function function_885001e() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self waittill(#"hash_c36d2b1e");
    /#
    #/
    if (!(isdefined(level.var_8f0e8eec) && level.var_8f0e8eec)) {
        level thread zm_audio::sndmusicsystem_playstate("nightmare");
        level.var_8f0e8eec = 1;
    }
}

// Namespace namespace_7c57d7e6
// Params 0, eflags: 0x0
// Checksum 0xd60cb6, Offset: 0x6b8
// Size: 0x15c
function function_6d544bc9() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self.var_babaee44 = [];
    var_3be8a3b8 = getentarray("zombie_vending", "targetname");
    for (i = 0; i < var_3be8a3b8.size; i++) {
        self.var_a375f562[var_3be8a3b8[i].script_noteworthy + "_purchased"] = 0;
    }
    while (true) {
        perk = self waittill(#"perk_bought");
        self.var_a375f562[perk + "_purchased"] = 1;
        keys = getarraykeys(self.var_a375f562);
        for (i = 0; i < keys.size; i++) {
            if (!self.var_a375f562[keys[i]]) {
                break;
            }
        }
        if (i == self.var_a375f562.size) {
            /#
            #/
            return;
        }
    }
}

// Namespace namespace_7c57d7e6
// Params 0, eflags: 0x0
// Checksum 0x97b8f5c3, Offset: 0x820
// Size: 0xf6
function function_b8ed20bf() {
    level endon(#"end_game");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"pap_taken");
        if (!self hasperk("specialty_additionalprimaryweapon")) {
            continue;
        }
        primaries = self getweaponslistprimaries();
        if (!isdefined(primaries) || primaries.size != 3) {
            continue;
        }
        for (i = 0; i < primaries.size; i++) {
            if (!zm_weapons::is_weapon_upgraded(primaries[i])) {
                break;
            }
        }
        if (i == primaries.size) {
            /#
            #/
            return;
        }
    }
}

