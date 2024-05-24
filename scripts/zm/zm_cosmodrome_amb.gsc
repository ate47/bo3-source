#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_audio_zhd;
#using scripts/zm/_zm_audio;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_9dd378ec;

// Namespace namespace_9dd378ec
// Params 0, eflags: 0x1 linked
// Checksum 0x55b4a5a8, Offset: 0x3c0
// Size: 0xdc
function main() {
    level.var_605ba2da = &function_a0f14d15;
    level thread function_5b4692c9();
    level thread function_e32302e3();
    level thread function_f90a04e4();
    level thread function_7624a208();
    level thread function_4947258a();
    level thread function_337aada8();
    level thread function_ba0eb696();
    level thread function_3757c044();
}

// Namespace namespace_9dd378ec
// Params 0, eflags: 0x1 linked
// Checksum 0xdbd49cf6, Offset: 0x4a8
// Size: 0x2c
function function_3757c044() {
    level waittill(#"hash_fd9adc1e");
    level thread zm_audio::sndmusicsystem_playstate("round_start_first_lander");
}

// Namespace namespace_9dd378ec
// Params 0, eflags: 0x1 linked
// Checksum 0x41c9abc6, Offset: 0x4e0
// Size: 0xae
function function_85f659bd() {
    var_47bb83 = struct::get_array("amb_power_clang", "targetname");
    if (var_47bb83.size) {
    }
    for (i = 0; i < var_47bb83.size; i++) {
        playsoundatposition("zmb_circuit", var_47bb83[i].origin);
        wait(randomfloatrange(0.25, 0.7));
    }
}

// Namespace namespace_9dd378ec
// Params 3, eflags: 0x1 linked
// Checksum 0xafae44f0, Offset: 0x598
// Size: 0xfc
function function_3cf7b8c9(alias, var_33dae1e3, var_9dd37d09) {
    if (!isdefined(alias)) {
        return;
    }
    if (!isdefined(level.var_93826d64)) {
        level.var_93826d64 = 0;
    }
    if (!isdefined(var_33dae1e3)) {
        var_33dae1e3 = 0;
    }
    if (!isdefined(var_9dd37d09)) {
        var_9dd37d09 = 0;
    }
    if (level.var_93826d64 == 0 && var_9dd37d09 == 0) {
        level.var_93826d64 = 1;
        if (!var_33dae1e3) {
            level function_b50a3ab4();
        }
        level zm_utility::function_dce51c76(alias);
        level.var_93826d64 = 0;
        return;
    }
    if (var_9dd37d09 == 1) {
        level zm_utility::function_dce51c76(alias);
    }
}

// Namespace namespace_9dd378ec
// Params 1, eflags: 0x1 linked
// Checksum 0x49b769ba, Offset: 0x6a0
// Size: 0x70
function function_524d0ceb(alias) {
    if (!isdefined(alias)) {
        return;
    }
    if (!isdefined(level.var_b81d5aac)) {
        level.var_b81d5aac = 0;
    }
    if (level.var_b81d5aac == 0) {
        level.var_b81d5aac = 1;
        level zm_utility::function_dce51c76(alias);
        level.var_b81d5aac = 0;
    }
}

// Namespace namespace_9dd378ec
// Params 0, eflags: 0x1 linked
// Checksum 0xb23ebe59, Offset: 0x718
// Size: 0x98
function function_b50a3ab4() {
    structs = struct::get_array("amb_warning_siren", "targetname");
    wait(1);
    for (i = 0; i < structs.size; i++) {
        playsoundatposition("evt_cosmo_alarm_single", structs[i].origin);
    }
    wait(0.5);
}

// Namespace namespace_9dd378ec
// Params 0, eflags: 0x1 linked
// Checksum 0xefff50e0, Offset: 0x7b8
// Size: 0x7e
function function_e32302e3() {
    wait(3);
    while (true) {
        level flag::wait_till("monkey_round");
        level thread function_3cf7b8c9("vox_ann_monkey_begin");
        level waittill(#"between_round_over");
        level thread function_3cf7b8c9("vox_ann_monkey_end");
        wait(10);
    }
}

// Namespace namespace_9dd378ec
// Params 0, eflags: 0x1 linked
// Checksum 0xd5c51a1, Offset: 0x840
// Size: 0x54
function function_f90a04e4() {
    var_385d0c76 = struct::get_array("radio_egg", "targetname");
    array::thread_all(var_385d0c76, &function_5fd10b57);
}

// Namespace namespace_9dd378ec
// Params 0, eflags: 0x1 linked
// Checksum 0xc71c7d78, Offset: 0x8a0
// Size: 0x54
function function_5fd10b57() {
    self zm_unitrigger::create_unitrigger();
    self waittill(#"trigger_activated");
    playsoundatposition("vox_radio_egg_" + self.script_int, self.origin);
}

// Namespace namespace_9dd378ec
// Params 0, eflags: 0x1 linked
// Checksum 0xba8e27ef, Offset: 0x900
// Size: 0x5c
function function_7624a208() {
    level thread namespace_52adc03e::function_e753d4f();
    level flag::wait_till("snd_song_completed");
    level thread zm_audio::sndmusicsystem_playstate("abracadavre");
}

// Namespace namespace_9dd378ec
// Params 0, eflags: 0x1 linked
// Checksum 0x17f13715, Offset: 0x968
// Size: 0x9c
function function_337aada8() {
    level.var_568da27 = 0;
    var_85d06ae4 = struct::get_array("egg_phone", "targetname");
    while (true) {
        level waittill(#"hash_b524a8eb");
        level.var_568da27++;
        if (level.var_568da27 == var_85d06ae4.size) {
            break;
        }
    }
    level notify(#"hash_2d7a77fa");
    level thread zm_audio::sndmusicsystem_playstate("not_ready_to_die");
}

// Namespace namespace_9dd378ec
// Params 0, eflags: 0x1 linked
// Checksum 0xf0f7873, Offset: 0xa10
// Size: 0x1b4
function function_10544d8() {
    self endon(#"hash_58b9d0eb");
    self endon(#"timeout");
    self.t_damage = spawn("trigger_damage", self.origin, 0, 5, 5);
    while (true) {
        n_amount, e_attacker, dir, point, str_means_of_death = self.t_damage waittill(#"damage");
        if (!namespace_52adc03e::function_8090042c()) {
            continue;
        }
        if (!isplayer(e_attacker)) {
            continue;
        }
        if (str_means_of_death != "MOD_MELEE") {
            continue;
        }
        if (distancesquared(e_attacker.origin, self.origin) > 4225) {
            continue;
        }
        break;
    }
    self.broken = 1;
    self notify(#"hash_b524a8eb");
    if (isdefined(self.var_48df29fd)) {
        self.var_48df29fd delete();
    }
    level notify(#"hash_b524a8eb");
    playsoundatposition("zmb_redphone_destroy", self.origin);
    self.t_damage delete();
}

// Namespace namespace_9dd378ec
// Params 0, eflags: 0x1 linked
// Checksum 0xd73fe40a, Offset: 0xbd0
// Size: 0x268
function function_4947258a() {
    level endon(#"hash_2d7a77fa");
    var_85d06ae4 = struct::get_array("egg_phone", "targetname");
    var_a008170d = array(0, 1, 2, 3, 4, 5, 6, 7, 8);
    if (var_85d06ae4.size <= 0) {
        return;
    }
    var_693fabd9 = undefined;
    while (true) {
        wait(randomintrange(90, -16));
        while (true) {
            var_9d999891 = array::random(var_85d06ae4);
            arrayremovevalue(var_85d06ae4, var_9d999891);
            if (var_85d06ae4.size <= 0) {
                var_85d06ae4 = struct::get_array("egg_phone", "targetname");
            }
            if (isdefined(var_9d999891.broken) && var_9d999891.broken) {
                continue;
            }
            break;
        }
        activation = var_9d999891 function_de8ef595();
        if (isdefined(activation) && activation) {
            var_f1b4932d = array::random(var_a008170d);
            arrayremovevalue(var_a008170d, var_f1b4932d);
            if (var_a008170d.size <= 0) {
                var_a008170d = array(0, 1, 2, 3, 4, 5, 6, 7, 8);
            }
            playsoundatposition("vox_egg_redphone_" + var_f1b4932d, var_9d999891.origin);
            var_693fabd9 = var_f1b4932d;
            wait(30);
        }
    }
}

// Namespace namespace_9dd378ec
// Params 0, eflags: 0x1 linked
// Checksum 0x55be04c, Offset: 0xe40
// Size: 0xe4
function function_de8ef595() {
    level endon(#"hash_2d7a77fa");
    self endon(#"hash_b524a8eb");
    self thread function_99199901();
    self thread function_d772340();
    self thread function_10544d8();
    self.var_a3f075d6 = 1;
    str_notify = self util::waittill_any_return("phone_activated", "timeout");
    self.var_a3f075d6 = 0;
    if (isdefined(self.t_damage)) {
        self.t_damage delete();
    }
    if (str_notify === "timeout") {
        return false;
    }
    return true;
}

// Namespace namespace_9dd378ec
// Params 0, eflags: 0x1 linked
// Checksum 0x30ecc7a6, Offset: 0xf30
// Size: 0x198
function function_99199901() {
    level endon(#"hash_2d7a77fa");
    self endon(#"timeout");
    self endon(#"hash_b524a8eb");
    self.var_7f6e3a35 = spawn("trigger_radius", self.origin - (0, 0, 200), 0, 75, 400);
    self.var_48df29fd = spawn("script_origin", self.origin);
    self.var_48df29fd playloopsound("zmb_egg_phone_loop", 0.05);
    while (true) {
        who = self.var_7f6e3a35 waittill(#"trigger");
        if (!isplayer(who)) {
            wait(0.05);
            continue;
        }
        while (who istouching(self.var_7f6e3a35)) {
            if (who usebuttonpressed()) {
                self notify(#"hash_58b9d0eb");
                self.var_7f6e3a35 delete();
                self.var_48df29fd delete();
                return;
            }
            wait(0.05);
        }
    }
}

// Namespace namespace_9dd378ec
// Params 0, eflags: 0x1 linked
// Checksum 0x82ceb9d8, Offset: 0x10d0
// Size: 0x6c
function function_d772340() {
    level endon(#"hash_2d7a77fa");
    self endon(#"hash_58b9d0eb");
    self endon(#"hash_b524a8eb");
    wait(10);
    self notify(#"timeout");
    self.var_7f6e3a35 delete();
    self.var_48df29fd delete();
}

// Namespace namespace_9dd378ec
// Params 0, eflags: 0x1 linked
// Checksum 0xc2b93900, Offset: 0x1148
// Size: 0x8e
function function_ba0eb696() {
    wait(10);
    for (i = 0; i < 4; i++) {
        ent = getent("doll_egg_" + i, "targetname");
        if (!isdefined(ent)) {
            return;
        }
        ent thread function_25d6399c(i);
    }
}

// Namespace namespace_9dd378ec
// Params 1, eflags: 0x1 linked
// Checksum 0x984750, Offset: 0x11e0
// Size: 0x1b6
function function_25d6399c(num) {
    if (!isdefined(self)) {
        return;
    }
    self usetriggerrequirelookat();
    self setcursorhint("HINT_NOICON");
    alias = undefined;
    while (true) {
        player = self waittill(#"trigger");
        index = zm_utility::get_player_index(player);
        switch (index) {
        case 0:
            alias = "vox_egg_doll_response_" + num + "_0";
            break;
        case 1:
            alias = "vox_egg_doll_response_" + num + "_1";
            break;
        case 3:
            alias = "vox_egg_doll_response_" + num + "_2";
            break;
        case 2:
            alias = "vox_egg_doll_response_" + num + "_3";
            break;
        }
        self playsoundwithnotify(alias, "sounddone" + alias);
        self waittill("sounddone" + alias);
        player zm_audio::create_and_play_dialog("weapon_pickup", "dolls");
        wait(8);
    }
}

// Namespace namespace_9dd378ec
// Params 3, eflags: 0x1 linked
// Checksum 0xb0d56239, Offset: 0x13a0
// Size: 0xbc
function function_a0f14d15(grenade, model, player) {
    var_7d5605b7 = getent("sndzhdeggtrig", "targetname");
    if (!isdefined(var_7d5605b7)) {
        return false;
    }
    if (model istouching(var_7d5605b7)) {
        model clientfield::set("toggle_black_hole_deployed", 1);
        level thread function_61c7f9a3(grenade, model, var_7d5605b7);
        return true;
    }
    return false;
}

// Namespace namespace_9dd378ec
// Params 0, eflags: 0x1 linked
// Checksum 0xf346de0a, Offset: 0x1468
// Size: 0x10e
function function_5b4692c9() {
    a_s_temp = struct::get_array("s_ballerina_bhb", "targetname");
    if (a_s_temp.size <= 0) {
        return;
    }
    var_ead6e450 = array::sort_by_script_int(a_s_temp, 1);
    foreach (var_6d450235 in var_ead6e450) {
        var_6d450235 function_2e4843da();
    }
    level flag::set("snd_zhdegg_activate");
    level.var_605ba2da = undefined;
}

// Namespace namespace_9dd378ec
// Params 0, eflags: 0x1 linked
// Checksum 0xe2e95507, Offset: 0x1580
// Size: 0xdc
function function_2e4843da() {
    self.var_ac086ffb = util::spawn_model(self.model, self.origin, self.angles);
    e_trig = spawn("trigger_radius", self.origin + (0, 0, -120), 0, -81, -56);
    e_trig.targetname = "sndzhdeggtrig";
    e_trig.s_target = self;
    e_trig waittill(#"hash_de264026");
    self.var_ac086ffb delete();
    e_trig delete();
}

// Namespace namespace_9dd378ec
// Params 3, eflags: 0x1 linked
// Checksum 0x264a5d9e, Offset: 0x1668
// Size: 0xf4
function function_61c7f9a3(grenade, model, var_7d5605b7) {
    wait(1);
    time = 3;
    var_7d5605b7.s_target.var_ac086ffb moveto(grenade.origin + (0, 0, 50), time, time - 0.05);
    wait(time);
    playsoundatposition("zmb_gersh_teleporter_out", grenade.origin + (0, 0, 50));
    model delete();
    var_7d5605b7 notify(#"hash_de264026");
}

