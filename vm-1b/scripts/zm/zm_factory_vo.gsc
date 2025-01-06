#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_utility;

#namespace zm_factory_vo;

// Namespace zm_factory_vo
// Params 0, eflags: 0x2
// Checksum 0x1a1db8be, Offset: 0xa38
// Size: 0x3a
function autoexec function_2dc19561() {
    system::register("zm_factory_vo", &__init__, &__main__, undefined);
}

// Namespace zm_factory_vo
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0xa80
// Size: 0x2
function __init__() {
    
}

// Namespace zm_factory_vo
// Params 0, eflags: 0x0
// Checksum 0x4f771929, Offset: 0xa90
// Size: 0x12
function __main__() {
    level thread function_7884e6b8();
}

// Namespace zm_factory_vo
// Params 0, eflags: 0x0
// Checksum 0x86e006a6, Offset: 0xab0
// Size: 0x9f1
function function_7884e6b8() {
    self endon(#"_zombie_game_over");
    level.var_5db32b5b = [];
    var_f01f6eb2 = [];
    array::add(var_f01f6eb2, array("vox_plr_3_interaction_takeo_rich_1_0", "vox_plr_2_interaction_takeo_rich_1_0"));
    array::add(var_f01f6eb2, array("vox_plr_2_interaction_takeo_rich_2_0", "vox_plr_3_interaction_takeo_rich_2_0"));
    array::add(var_f01f6eb2, array("vox_plr_2_interaction_takeo_rich_3_0", "vox_plr_3_interaction_takeo_rich_3_0"));
    array::add(var_f01f6eb2, array("vox_plr_2_interaction_takeo_rich_4_0", "vox_plr_3_interaction_takeo_rich_4_0"));
    array::add(var_f01f6eb2, array("vox_plr_2_interaction_takeo_rich_5_0", "vox_plr_3_interaction_takeo_rich_5_0"));
    var_e140097c = 0;
    var_5fda2472 = [];
    array::add(var_5fda2472, array("vox_plr_0_interaction_takeo_demp_1_0", "vox_plr_3_interaction_takeo_demp_1_0"));
    array::add(var_5fda2472, array("vox_plr_0_interaction_takeo_demp_2_0", "vox_plr_3_interaction_takeo_demp_2_0"));
    array::add(var_5fda2472, array("vox_plr_0_interaction_takeo_demp_3_0", "vox_plr_3_interaction_takeo_demp_3_0"));
    array::add(var_5fda2472, array("vox_plr_0_interaction_takeo_demp_4_0", "vox_plr_3_interaction_takeo_demp_4_0"));
    array::add(var_5fda2472, array("vox_plr_0_interaction_takeo_demp_5_0", "vox_plr_3_interaction_takeo_demp_5_0"));
    var_b7adf76 = 0;
    var_aeae7aa1 = [];
    array::add(var_aeae7aa1, array("vox_plr_3_interaction_niko_takeo_1_0", "vox_plr_1_interaction_niko_takeo_1_0"));
    array::add(var_aeae7aa1, array("vox_plr_3_interaction_niko_takeo_2_0", "vox_plr_1_interaction_niko_takeo_2_0"));
    array::add(var_aeae7aa1, array("vox_plr_1_interaction_niko_takeo_3_0", "vox_plr_3_interaction_niko_takeo_3_0"));
    array::add(var_aeae7aa1, array("vox_plr_3_interaction_niko_takeo_4_0", "vox_plr_1_interaction_niko_takeo_4_0"));
    array::add(var_aeae7aa1, array("vox_plr_3_interaction_niko_takeo_5_0", "vox_plr_1_interaction_niko_takeo_5_0"));
    var_e60d01d = 0;
    var_db90c17b = [];
    array::add(var_db90c17b, array("vox_plr_0_interaction_demp_rich_1_0", "vox_plr_2_interaction_demp_rich_1_0"));
    array::add(var_db90c17b, array("vox_plr_0_interaction_demp_rich_2_0", "vox_plr_2_interaction_demp_rich_2_0"));
    array::add(var_db90c17b, array("vox_plr_0_interaction_demp_rich_3_0", "vox_plr_2_interaction_demp_rich_3_0"));
    array::add(var_db90c17b, array("vox_plr_0_interaction_demp_rich_4_0", "vox_plr_2_interaction_demp_rich_4_0"));
    array::add(var_db90c17b, array("vox_plr_0_interaction_demp_rich_5_0", "vox_plr_2_interaction_demp_rich_5_0"));
    var_93378973 = 0;
    var_e341729a = [];
    array::add(var_e341729a, array("vox_plr_1_interaction_niko_rich_1_0", "vox_plr_2_interaction_niko_rich_1_0"));
    array::add(var_e341729a, array("vox_plr_1_interaction_niko_rich_2_0", "vox_plr_2_interaction_niko_rich_2_0"));
    array::add(var_e341729a, array("vox_plr_1_interaction_niko_rich_3_0", "vox_plr_2_interaction_niko_rich_3_0"));
    array::add(var_e341729a, array("vox_plr_1_interaction_niko_rich_4_0", "vox_plr_2_interaction_niko_rich_4_0"));
    array::add(var_e341729a, array("vox_plr_2_interaction_niko_rich_5_0", "vox_plr_1_interaction_niko_rich_5_0"));
    var_94078d12 = 0;
    var_4c7aad4a = [];
    array::add(var_4c7aad4a, array("vox_plr_0_interaction_niko_demp_1_0", "vox_plr_1_interaction_niko_demp_1_0"));
    array::add(var_4c7aad4a, array("vox_plr_1_interaction_niko_demp_2_0", "vox_plr_0_interaction_niko_demp_2_0"));
    array::add(var_4c7aad4a, array("vox_plr_1_interaction_niko_demp_3_0", "vox_plr_0_interaction_niko_demp_3_0"));
    array::add(var_4c7aad4a, array("vox_plr_1_interaction_niko_demp_4_0", "vox_plr_0_interaction_niko_demp_4_0"));
    array::add(var_4c7aad4a, array("vox_plr_1_interaction_niko_demp_5_0", "vox_plr_0_interaction_niko_demp_5_0"));
    var_22f40782 = 0;
    level waittill(#"all_players_spawned");
    wait 1;
    while (true) {
        if (level.round_number > 4) {
            level waittill(#"end_of_round");
            if (level.activeplayers.size > 1 && !level flag::get("flytrap")) {
                n_player_index = randomint(level.activeplayers.size);
                var_e8669 = level.activeplayers[n_player_index];
                var_a68de872 = array::remove_index(level.activeplayers, n_player_index);
                var_261100d2 = arraygetclosest(var_e8669.origin, var_a68de872);
                if (zm_utility::is_player_valid(var_e8669) && zm_utility::is_player_valid(var_261100d2) && distance(var_e8669.origin, var_261100d2.origin) <= 900) {
                    var_3b5e4c24 = undefined;
                    if (var_261100d2.characterindex == 3 && (var_e8669.characterindex == 3 && var_261100d2.characterindex == 2 || var_e8669.characterindex == 2)) {
                        if (var_e140097c < var_f01f6eb2.size) {
                            function_c23e3a71(var_f01f6eb2, var_e140097c, 1);
                            var_e140097c++;
                        }
                    } else if (var_261100d2.characterindex == 3 && (var_e8669.characterindex == 3 && var_261100d2.characterindex == 0 || var_e8669.characterindex == 0)) {
                        if (var_b7adf76 < var_5fda2472.size) {
                            function_c23e3a71(var_5fda2472, var_b7adf76, 1);
                            var_b7adf76++;
                        }
                    } else if (var_261100d2.characterindex == 3 && (var_e8669.characterindex == 3 && var_261100d2.characterindex == 1 || var_e8669.characterindex == 1)) {
                        if (var_e60d01d < var_aeae7aa1.size) {
                            function_c23e3a71(var_aeae7aa1, var_e60d01d, 1);
                            var_e60d01d++;
                        }
                    } else if (var_261100d2.characterindex == 2 && (var_e8669.characterindex == 2 && var_261100d2.characterindex == 0 || var_e8669.characterindex == 0)) {
                        if (var_93378973 < var_db90c17b.size) {
                            function_c23e3a71(var_db90c17b, var_93378973, 1);
                            var_93378973++;
                        }
                    } else if (var_261100d2.characterindex == 2 && (var_e8669.characterindex == 2 && var_261100d2.characterindex == 1 || var_e8669.characterindex == 1)) {
                        if (var_94078d12 < var_e341729a.size) {
                            function_c23e3a71(var_e341729a, var_94078d12, 1);
                            var_94078d12++;
                        }
                    } else if (var_261100d2.characterindex == 0 && (var_e8669.characterindex == 0 && var_261100d2.characterindex == 1 || var_e8669.characterindex == 1)) {
                        if (var_22f40782 < var_4c7aad4a.size) {
                            function_c23e3a71(var_4c7aad4a, var_22f40782, 1);
                            var_22f40782++;
                        }
                    }
                }
            }
        }
        wait 0.05;
    }
}

// Namespace zm_factory_vo
// Params 5, eflags: 0x0
// Checksum 0xe836eed0, Offset: 0x14b0
// Size: 0xb2
function function_c23e3a71(var_49fefccd, n_index, b_wait_if_busy, var_7e649f23, var_d1295208) {
    if (!isdefined(b_wait_if_busy)) {
        b_wait_if_busy = 0;
    }
    if (!isdefined(var_7e649f23)) {
        var_7e649f23 = 0;
    }
    if (!isdefined(var_d1295208)) {
        var_d1295208 = 0;
    }
    assert(isdefined(var_49fefccd), "<dev string:x28>");
    assert(n_index < var_49fefccd.size, "<dev string:x61>");
    var_3b5e4c24 = var_49fefccd[n_index];
    function_7aa5324a(var_3b5e4c24, b_wait_if_busy, var_7e649f23, var_d1295208);
}

// Namespace zm_factory_vo
// Params 4, eflags: 0x0
// Checksum 0xfa1d5652, Offset: 0x1570
// Size: 0xba
function function_7aa5324a(a_str_vo, b_wait_if_busy, n_priority, var_d1295208) {
    if (!isdefined(b_wait_if_busy)) {
        b_wait_if_busy = 0;
    }
    if (!isdefined(n_priority)) {
        n_priority = 0;
    }
    if (!isdefined(var_d1295208)) {
        var_d1295208 = 0;
    }
    function_218256bd(1);
    for (i = 0; i < a_str_vo.size; i++) {
        if (i == 0) {
            var_e27770b1 = 0;
        } else {
            var_e27770b1 = 0.5;
        }
        function_897246e4(a_str_vo[i], var_e27770b1, b_wait_if_busy, n_priority, var_d1295208);
    }
    function_218256bd(0);
}

// Namespace zm_factory_vo
// Params 1, eflags: 0x0
// Checksum 0x75c02b3c, Offset: 0x1638
// Size: 0xfd
function function_218256bd(var_eca8128e) {
    foreach (player in level.activeplayers) {
        if (isdefined(player)) {
            player.dontspeak = var_eca8128e;
            player clientfield::set_to_player("isspeaking", var_eca8128e);
        }
    }
    if (var_eca8128e) {
        foreach (player in level.activeplayers) {
            while (isdefined(player.isspeaking) && isdefined(player) && player.isspeaking) {
                wait 0.1;
            }
        }
    }
}

// Namespace zm_factory_vo
// Params 5, eflags: 0x0
// Checksum 0x91dfd3b9, Offset: 0x1740
// Size: 0x112
function function_897246e4(str_vo_alias, n_wait, b_wait_if_busy, n_priority, var_d1295208) {
    if (!isdefined(n_wait)) {
        n_wait = 0;
    }
    if (!isdefined(b_wait_if_busy)) {
        b_wait_if_busy = 0;
    }
    if (!isdefined(n_priority)) {
        n_priority = 0;
    }
    if (!isdefined(var_d1295208)) {
        var_d1295208 = 0;
    }
    var_81132431 = strtok(str_vo_alias, "_");
    if (var_81132431[1] === "plr") {
        var_edf0b06 = int(var_81132431[2]);
        e_speaker = zm_utility::function_a157d632(var_edf0b06);
    } else {
        e_speaker = undefined;
        assert(0, "<dev string:xb2>" + str_vo_alias + "<dev string:xcf>");
    }
    if (zm_utility::is_player_valid(e_speaker)) {
        e_speaker vo_say(str_vo_alias, n_wait, b_wait_if_busy, n_priority);
    }
}

// Namespace zm_factory_vo
// Params 5, eflags: 0x0
// Checksum 0x63eb35b1, Offset: 0x1860
// Size: 0x282
function vo_say(str_vo_alias, n_delay, b_wait_if_busy, n_priority, var_d1295208) {
    if (!isdefined(n_delay)) {
        n_delay = 0;
    }
    if (!isdefined(b_wait_if_busy)) {
        b_wait_if_busy = 0;
    }
    if (!isdefined(n_priority)) {
        n_priority = 0;
    }
    if (!isdefined(var_d1295208)) {
        var_d1295208 = 0;
    }
    self endon(#"death");
    self endon(#"disconnect");
    if (!self flag::exists("in_beastmode") || !self flag::get("in_beastmode")) {
        if (zm_audio::function_bbc477e0(10000) && !(isdefined(var_d1295208) && var_d1295208)) {
            return;
        }
        if (isdefined(level.sndvoxoverride) && (isdefined(self.isspeaking) && self.isspeaking || level.sndvoxoverride)) {
            if (isdefined(b_wait_if_busy) && b_wait_if_busy) {
                while (isdefined(level.sndvoxoverride) && (self.isspeaking || level.sndvoxoverride)) {
                    wait 0.1;
                }
                wait 0.35;
            } else {
                return;
            }
        }
        if (n_delay > 0) {
            wait n_delay;
        }
        if (isdefined(self.b_wait_if_busy) && isdefined(self.isspeaking) && self.isspeaking && self.b_wait_if_busy) {
            while (self.isspeaking) {
                wait 0.1;
            }
        } else if (isdefined(level.sndvoxoverride) && (isdefined(self.isspeaking) && self.isspeaking && !(isdefined(self.b_wait_if_busy) && self.b_wait_if_busy) || level.sndvoxoverride)) {
            return;
        }
        self.isspeaking = 1;
        self.n_vo_priority = n_priority;
        self.str_vo_being_spoken = str_vo_alias;
        array::add(level.var_5db32b5b, self, 1);
        var_2df3d133 = str_vo_alias + "_vo_done";
        if (isactor(self) || isplayer(self)) {
            self playsoundwithnotify(str_vo_alias, var_2df3d133, "J_head");
        } else {
            self playsoundwithnotify(str_vo_alias, var_2df3d133);
        }
        self waittill(var_2df3d133);
        self vo_clear();
    }
}

// Namespace zm_factory_vo
// Params 0, eflags: 0x0
// Checksum 0x8a33254d, Offset: 0x1af0
// Size: 0xb2
function vo_clear() {
    self.str_vo_being_spoken = "";
    self.n_vo_priority = 0;
    self.isspeaking = 0;
    var_22677cee = 0;
    foreach (var_a3ddaa95 in level.var_5db32b5b) {
        if (var_a3ddaa95 == self) {
            var_22677cee = 1;
            break;
        }
    }
    if (isdefined(var_22677cee) && var_22677cee) {
        arrayremovevalue(level.var_5db32b5b, self);
    }
}

