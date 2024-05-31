#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_b1bc995c;

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x2
// namespace_b1bc995c<file_0>::function_2dc19561
// Checksum 0xf14fc4f9, Offset: 0xc88
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_castle_ee_bossfight", &__init__, undefined, undefined);
}

// Namespace namespace_b1bc995c
// Params 0, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_8c87d8eb
// Checksum 0x95c85f9a, Offset: 0xcc8
// Size: 0x82c
function __init__() {
    clientfield::register("toplayer", "player_snow_fx_off", 5000, 1, "counter", &function_45f17e5b, 0, 0);
    clientfield::register("actor", "boss_skeleton_eye_glow_fx_change", 5000, 1, "counter", &function_6bb3bdae, 0, 0);
    level._effect["boss_skeleton_eye_glow"] = "dlc1/castle/fx_glow_eye_orange_skeleton";
    clientfield::register("scriptmover", "boss_mpd_fx", 5000, 1, "int", &function_3847c737, 0, 0);
    level._effect["boss_mpd_mist"] = "dlc1/castle/fx_ee_keeper_small_mist_trail";
    level._effect["boss_mpd_mouth"] = "dlc1/castle/fx_ee_keeper_small_mouth_glow";
    clientfield::register("scriptmover", "boss_fx", 5000, 1, "int", &function_646d48a7, 0, 0);
    clientfield::register("scriptmover", "boss_weak_point_shader", 5000, 1, "int", &function_842bfcca, 0, 0);
    clientfield::register("actor", "boss_zombie_rise_fx", 1, 1, "int", &function_c5c4e352, 1, 1);
    level._effect["boss_mist"] = "dlc1/castle/fx_ee_keeper_mist_trail";
    level._effect["boss_mouth"] = "dlc1/castle/fx_ee_keeper_mouth_glow";
    level._effect["boss_rise_burst"] = "dlc1/castle/fx_ee_keeper_hand_burst_zmb";
    level._effect["boss_rise_billow"] = "dlc1/castle/fx_ee_keeper_body_billowing_zmb";
    clientfield::register("scriptmover", "boss_teleport_fx", 5000, 1, "counter", &function_b87abae5, 0, 0);
    level._effect["boss_teleport"] = "dlc1/castle/fx_ee_keeper_teleport";
    clientfield::register("scriptmover", "boss_elemental_storm_cast_fx", 5000, 1, "int", &function_8773a235, 0, 0);
    clientfield::register("scriptmover", "boss_elemental_storm_explode_fx", 5000, 1, "int", &function_22e3090d, 0, 0);
    clientfield::register("scriptmover", "boss_elemental_storm_stunned_keeper_fx", 5000, 1, "int", &function_c8f3c754, 0, 0);
    clientfield::register("scriptmover", "boss_elemental_storm_stunned_spikes_fx", 5000, 1, "int", &function_cffccd99, 0, 0);
    level._effect["boss_elemental_storm_cast"] = "dlc1/castle/fx_ee_keeper_storm_tell";
    level._effect["boss_elemental_storm_explode_loop"] = "dlc1/zmb_weapon/fx_bow_storm_funnel_loop_zmb";
    level._effect["boss_elemental_storm_explode_end"] = "dlc1/zmb_weapon/fx_bow_storm_funnel_end_zmb";
    level._effect["boss_elemental_storm_stunned_spikes"] = "dlc1/castle/fx_ee_keeper_beam_stunned_src";
    level._effect["boss_elemental_storm_stunned_keeper"] = "dlc1/castle/fx_ee_keeper_beam_stunned_tgt";
    clientfield::register("scriptmover", "boss_demongate_cast_fx", 5000, 1, "int", &function_f53d6e40, 0, 0);
    clientfield::register("scriptmover", "boss_demongate_chomper_fx", 5000, 1, "int", &function_4004ceb1, 0, 0);
    clientfield::register("scriptmover", "boss_demongate_chomper_bite_fx", 5000, 1, "counter", &function_7f03b7a2, 0, 0);
    level._effect["boss_demongate_portal_open"] = "dlc1/castle/fx_ee_keeper_demongate_portal_open";
    level._effect["boss_demongate_portal_loop"] = "dlc1/castle/fx_ee_keeper_demongate_portal_loop";
    level._effect["boss_demongate_portal_close"] = "dlc1/castle/fx_ee_keeper_demongate_portal_close";
    level._effect["boss_demongate_chomper_trail"] = "dlc1/castle/fx_ee_keeper_demonhead_trail";
    level._effect["boss_demongate_chomper_bite"] = "dlc1/castle/fx_ee_keeper_demonhead_despawn";
    level._effect["boss_demongate_chomper_despawn"] = "dlc1/castle/fx_ee_keeper_demonhead_despawn";
    clientfield::register("scriptmover", "boss_rune_prison_erupt_fx", 5000, 1, "int", &function_78f6d6a3, 0, 0);
    clientfield::register("scriptmover", "boss_rune_prison_rock_fx", 5000, 1, "int", &function_c5202764, 0, 0);
    clientfield::register("scriptmover", "boss_rune_prison_explode_fx", 5000, 1, "int", &function_5cf0ffb0, 0, 0);
    clientfield::register("allplayers", "boss_rune_prison_dot_fx", 5000, 1, "int", &function_8c589c72, 0, 0);
    clientfield::register("world", "sndBossBattle", 5000, 1, "int", &function_c5548517, 0, 0);
    level._effect["boss_rune_prison_erupt"] = "dlc1/castle/fx_ee_keeper_runeprison_glow";
    level._effect["boss_rune_prison_explode"] = "dlc1/castle/fx_ee_keeper_runeprison_fire";
    level._effect["boss_rune_prison_dot"] = "dlc1/zmb_weapon/fx_bow_rune_fire_torso_zmb";
    clientfield::register("world", "boss_wolf_howl_fx_change", 5000, 1, "int", &function_a20d2e82, 0, 0);
    clientfield::register("world", "boss_gravity_spike_fx_change", 5000, 1, "int", &function_c1ed35c2, 0, 0);
}

// Namespace namespace_b1bc995c
// Params 7, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_45f17e5b
// Checksum 0xe341df9d, Offset: 0x1500
// Size: 0x80
function function_45f17e5b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.var_18402cb[localclientnum])) {
        deletefx(localclientnum, level.var_18402cb[localclientnum], 1);
        level.var_18402cb[localclientnum] = undefined;
    }
}

// Namespace namespace_b1bc995c
// Params 7, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_6bb3bdae
// Checksum 0x6ce90da0, Offset: 0x1588
// Size: 0x54
function function_6bb3bdae(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self._eyeglow_fx_override = level._effect["boss_skeleton_eye_glow"];
}

// Namespace namespace_b1bc995c
// Params 7, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_3847c737
// Checksum 0xaa544299, Offset: 0x15e8
// Size: 0x196
function function_3847c737(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_3b5b8133 = playfxontag(localclientnum, level._effect["boss_mpd_mist"], self, "j_spinelower");
        self.var_20e08654 = playfxontag(localclientnum, level._effect["boss_mpd_mist"], self, "j_robe_front_03");
        self.var_40ad10ca = playfxontag(localclientnum, level._effect["boss_mpd_mouth"], self, "j_head");
        return;
    }
    if (isdefined(self.var_3b5b8133)) {
        deletefx(localclientnum, self.var_3b5b8133, 0);
        self.var_3b5b8133 = undefined;
    }
    if (isdefined(self.var_20e08654)) {
        deletefx(localclientnum, self.var_20e08654, 0);
        self.var_20e08654 = undefined;
    }
    if (isdefined(self.var_40ad10ca)) {
        deletefx(localclientnum, self.var_40ad10ca, 0);
        self.var_40ad10ca = undefined;
    }
}

// Namespace namespace_b1bc995c
// Params 7, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_646d48a7
// Checksum 0x65da8121, Offset: 0x1788
// Size: 0x196
function function_646d48a7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_3b5b8133 = playfxontag(localclientnum, level._effect["boss_mist"], self, "j_spinelower");
        self.var_20e08654 = playfxontag(localclientnum, level._effect["boss_mist"], self, "j_robe_front_03");
        self.var_40ad10ca = playfxontag(localclientnum, level._effect["boss_mouth"], self, "j_head");
        return;
    }
    if (isdefined(self.var_3b5b8133)) {
        deletefx(localclientnum, self.var_3b5b8133, 0);
        self.var_3b5b8133 = undefined;
    }
    if (isdefined(self.var_20e08654)) {
        deletefx(localclientnum, self.var_20e08654, 0);
        self.var_20e08654 = undefined;
    }
    if (isdefined(self.var_40ad10ca)) {
        deletefx(localclientnum, self.var_40ad10ca, 0);
        self.var_40ad10ca = undefined;
    }
}

// Namespace namespace_b1bc995c
// Params 7, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_842bfcca
// Checksum 0x19cb9426, Offset: 0x1928
// Size: 0x104
function function_842bfcca(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        var_79974a0f = 0;
        if (isdefined(self.var_dde7199)) {
            self stoploopsound(self.var_dde7199, 1);
            self.var_dde7199 = undefined;
        }
    } else {
        var_79974a0f = 1;
        if (!isdefined(self.var_dde7199)) {
            self.var_dde7199 = self playloopsound("zmb_keeper_downed_lp", 1);
        }
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector3", 0, var_79974a0f, 0, 0);
}

// Namespace namespace_b1bc995c
// Params 7, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_c5c4e352
// Checksum 0xa895a8d0, Offset: 0x1a38
// Size: 0x12e
function function_c5c4e352(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level endon(#"demo_jump");
    self endon(#"entityshutdown");
    if (newval) {
        localplayers = level.localplayers;
        var_f7130542 = "zmb_zombie_spawn";
        var_7bc37da8 = level._effect["boss_rise_burst"];
        var_ee65ea53 = level._effect["boss_rise_billow"];
        playsound(0, var_f7130542, self.origin);
        for (i = 0; i < localplayers.size; i++) {
            self thread function_200d4bd2(i, var_ee65ea53, var_7bc37da8);
        }
    }
}

// Namespace namespace_b1bc995c
// Params 3, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_200d4bd2
// Checksum 0xcad8435d, Offset: 0x1b70
// Size: 0xec
function function_200d4bd2(localclientnum, var_ee65ea53, var_7bc37da8) {
    self endon(#"entityshutdown");
    level endon(#"demo_jump");
    playfx(localclientnum, var_7bc37da8, self.origin + (0, 0, randomintrange(5, 10)));
    wait(0.25);
    playfx(localclientnum, var_ee65ea53, self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
}

// Namespace namespace_b1bc995c
// Params 7, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_b87abae5
// Checksum 0x3f7dcdfd, Offset: 0x1c68
// Size: 0xae
function function_b87abae5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.var_b1fe1ee = playfxontag(localclientnum, level._effect["boss_teleport"], self, "j_mainroot");
    wait(0.5);
    if (isdefined(self.var_b1fe1ee)) {
        deletefx(localclientnum, self.var_b1fe1ee, 0);
        self.var_b1fe1ee = undefined;
    }
}

// Namespace namespace_b1bc995c
// Params 7, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_8773a235
// Checksum 0xa9c485a0, Offset: 0x1d20
// Size: 0xfe
function function_8773a235(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self playsound(0, "zmb_keeper_storm_cast");
        self function_4278d80d(localclientnum);
        return;
    }
    self notify(#"hash_1c2dfa5e");
    if (isdefined(self.var_b1fe1ee)) {
        deletefx(localclientnum, self.var_b1fe1ee, 0);
        self.var_b1fe1ee = undefined;
    }
    if (isdefined(self.var_64741ec0)) {
        self stoploopsound(self.var_64741ec0, 4);
        self.var_64741ec0 = undefined;
    }
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_4278d80d
// Checksum 0x43b4cd7f, Offset: 0x1e28
// Size: 0xd8
function function_4278d80d(localclientnum) {
    self endon(#"hash_1c2dfa5e");
    while (isdefined(self)) {
        if (isdefined(self.var_b1fe1ee)) {
            deletefx(localclientnum, self.var_b1fe1ee, 0);
            self.var_b1fe1ee = undefined;
        }
        if (!isdefined(self.var_64741ec0)) {
            self.var_64741ec0 = self playloopsound("zmb_keeper_storm_cast_lp", 0.5);
        }
        self.var_b1fe1ee = playfxontag(localclientnum, level._effect["boss_elemental_storm_cast"], self, "tag_origin");
        wait(0.5);
    }
}

// Namespace namespace_b1bc995c
// Params 7, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_22e3090d
// Checksum 0x62b08e19, Offset: 0x1f08
// Size: 0x12c
function function_22e3090d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (isdefined(self.var_b1fe1ee)) {
            deletefx(localclientnum, self.var_b1fe1ee, 0);
            self.var_53f7dac0 = undefined;
        }
        self.var_b1fe1ee = playfxontag(localclientnum, level._effect["boss_elemental_storm_explode_loop"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_b1fe1ee)) {
        deletefx(localclientnum, self.var_b1fe1ee, 0);
        self.var_53f7dac0 = undefined;
    }
    wait(0.4);
    self.var_53f7dac0 = playfxontag(localclientnum, level._effect["boss_elemental_storm_explode_end"], self, "tag_origin");
}

// Namespace namespace_b1bc995c
// Params 7, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_cffccd99
// Checksum 0x2c87f867, Offset: 0x2040
// Size: 0xb6
function function_cffccd99(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_ee45d30a = playfxontag(localclientnum, level._effect["boss_elemental_storm_stunned_spikes"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_ee45d30a)) {
        deletefx(localclientnum, self.var_ee45d30a, 0);
        self.var_b1fe1ee = undefined;
    }
}

// Namespace namespace_b1bc995c
// Params 7, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_c8f3c754
// Checksum 0xa8ffb5d8, Offset: 0x2100
// Size: 0xb6
function function_c8f3c754(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_ee45d30a = playfxontag(localclientnum, level._effect["boss_elemental_storm_stunned_keeper"], self, "j_spinelower");
        return;
    }
    if (isdefined(self.var_ee45d30a)) {
        deletefx(localclientnum, self.var_ee45d30a, 0);
        self.var_b1fe1ee = undefined;
    }
}

// Namespace namespace_b1bc995c
// Params 7, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_f53d6e40
// Checksum 0x9130bdfa, Offset: 0x21c0
// Size: 0x1a6
function function_f53d6e40(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_fd0edd83 = playfxontag(localclientnum, level._effect["boss_demongate_portal_open"], self, "tag_weapon_right");
        self.var_4b6fd850 = self playloopsound("zmb_keeper_demongate_portal_lp", 1);
        wait(0.45);
        self.var_fd0edd83 = playfxontag(localclientnum, level._effect["boss_demongate_portal_loop"], self, "tag_weapon_right");
        return;
    }
    if (isdefined(self.var_fd0edd83)) {
        playfx(localclientnum, level._effect["boss_demongate_portal_close"], self.origin, anglestoforward(self.angles));
    }
    if (isdefined(self.var_4b6fd850)) {
        self stoploopsound(self.var_4b6fd850, 1);
        self.var_4b6fd850 = undefined;
    }
    wait(0.45);
    deletefx(localclientnum, self.var_fd0edd83, 0);
    self.var_fd0edd83 = undefined;
}

// Namespace namespace_b1bc995c
// Params 7, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_4004ceb1
// Checksum 0x7447692f, Offset: 0x2370
// Size: 0x1a4
function function_4004ceb1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    if (newval) {
        if (isdefined(self.var_a581816a)) {
            deletefx(localclientnum, self.var_a581816a, 1);
        }
        self.var_a581816a = playfxontag(localclientnum, level._effect["boss_demongate_chomper_trail"], self, "tag_fx");
        self.var_965cdbdb = self playloopsound("zmb_keeper_demongate_chomper_lp", 1);
        return;
    }
    if (isdefined(self.var_a581816a)) {
        deletefx(localclientnum, self.var_a581816a, 0);
        self.var_a581816a = undefined;
    }
    if (isdefined(self.var_965cdbdb)) {
        self stoploopsound(self.var_965cdbdb, 0.5);
        self.var_965cdbdb = undefined;
    }
    self playsound(0, "zmb_keeper_demongate_chomper_disappear");
    playfxontag(localclientnum, level._effect["boss_demongate_chomper_despawn"], self, "tag_fx");
}

// Namespace namespace_b1bc995c
// Params 7, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_7f03b7a2
// Checksum 0x99bf320e, Offset: 0x2520
// Size: 0xbc
function function_7f03b7a2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.var_64b4f506 = playfx(localclientnum, level._effect["boss_demongate_chomper_bite"], self.origin);
    self playsound(0, "zmb_keeper_demongate_chomper_bite");
    wait(0.1);
    stopfx(localclientnum, self.var_64b4f506);
}

// Namespace namespace_b1bc995c
// Params 7, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_78f6d6a3
// Checksum 0x7f38b183, Offset: 0x25e8
// Size: 0xa6
function function_78f6d6a3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread function_92f90eb7(localclientnum);
        return;
    }
    self notify(#"hash_f40e20dc");
    if (isdefined(self.var_b1fe1ee)) {
        deletefx(localclientnum, self.var_b1fe1ee, 1);
        self.var_b1fe1ee = undefined;
    }
}

// Namespace namespace_b1bc995c
// Params 1, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_92f90eb7
// Checksum 0x50ec4b39, Offset: 0x2698
// Size: 0xb8
function function_92f90eb7(localclientnum) {
    self endon(#"hash_f40e20dc");
    self endon(#"entityshutdown");
    while (true) {
        self.var_b1fe1ee = playfx(localclientnum, level._effect["boss_rune_prison_erupt"], self.origin);
        wait(1);
        if (isdefined(self) && isdefined(self.var_b1fe1ee)) {
            deletefx(localclientnum, self.var_b1fe1ee, 0);
            self.var_b1fe1ee = undefined;
            continue;
        }
        if (!isdefined(self)) {
            return;
        }
    }
}

// Namespace namespace_b1bc995c
// Params 7, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_c5202764
// Checksum 0xac2be47c, Offset: 0x2758
// Size: 0xb6
function function_c5202764(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 0:
        self scene::play("p7_fxanim_zm_bow_rune_prison_red_01_bundle");
        self scene::stop(1);
        break;
    case 1:
        self thread scene::init("p7_fxanim_zm_bow_rune_prison_red_01_bundle");
        break;
    }
}

// Namespace namespace_b1bc995c
// Params 7, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_5cf0ffb0
// Checksum 0x71c84a4c, Offset: 0x2818
// Size: 0x7c
function function_5cf0ffb0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfx(localclientnum, level._effect["boss_rune_prison_explode"], self.origin, (0, 0, 1), (1, 0, 0));
    }
}

// Namespace namespace_b1bc995c
// Params 7, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_8c589c72
// Checksum 0x6aaff86f, Offset: 0x28a0
// Size: 0x9c
function function_8c589c72(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_1892be10 = playfxontag(localclientnum, level._effect["boss_rune_prison_dot"], self, "j_spine4");
        return;
    }
    deletefx(localclientnum, self.var_1892be10, 0);
}

// Namespace namespace_b1bc995c
// Params 7, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_a20d2e82
// Checksum 0x83df4ef0, Offset: 0x2948
// Size: 0x7e
function function_a20d2e82(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level._effect["dog_trail_fire"] = "dlc1/castle/fx_ee_keeper_dog_fire_trail";
        return;
    }
    level._effect["dog_trail_fire"] = "zombie/fx_dog_fire_trail_zmb";
}

// Namespace namespace_b1bc995c
// Params 7, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_c1ed35c2
// Checksum 0x560b04c1, Offset: 0x29d0
// Size: 0xb6
function function_c1ed35c2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level._effect["gravityspikes_trap_start"] = "dlc1/castle/fx_ee_keeper_wpn_spike_trap_start";
        level._effect["gravityspikes_trap_loop"] = "dlc1/castle/fx_ee_keeper_wpn_spike_trap_loop";
        return;
    }
    level._effect["gravityspikes_trap_start"] = "dlc1/zmb_weapon/fx_wpn_spike_trap_start";
    level._effect["gravityspikes_trap_loop"] = "dlc1/zmb_weapon/fx_wpn_spike_trap_loop";
}

// Namespace namespace_b1bc995c
// Params 7, eflags: 0x1 linked
// namespace_b1bc995c<file_0>::function_c5548517
// Checksum 0x236f0dd4, Offset: 0x2a90
// Size: 0xe4
function function_c5548517(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level notify(#"hash_51d7bc7c", "bossbattle");
        audio::snd_set_snapshot("zmb_castle_bossbattle");
        playsound(0, "zmb_keeper_trans_into");
        return;
    }
    level notify(#"hash_51d7bc7c", "crypt");
    audio::snd_set_snapshot("default");
    playsound(0, "zmb_keeper_trans_outof");
}

