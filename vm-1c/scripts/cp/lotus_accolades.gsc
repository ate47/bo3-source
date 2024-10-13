#using scripts/cp/_accolades;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace lotus_accolades;

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0x3235da01, Offset: 0x7f0
// Size: 0x244
function function_66df416f() {
    accolades::register("MISSION_LOTUS_UNTOUCHED");
    accolades::register("MISSION_LOTUS_SCORE");
    accolades::register("MISSION_LOTUS_COLLECTIBLE");
    accolades::register("MISSION_LOTUS_CHALLENGE3", "accolade_3_increment");
    accolades::register("MISSION_LOTUS_CHALLENGE4", "accolade_4_increment");
    accolades::register("MISSION_LOTUS_CHALLENGE5", "accolade_5_complete");
    accolades::register("MISSION_LOTUS_CHALLENGE6", "accolade_6_increment");
    accolades::register("MISSION_LOTUS_CHALLENGE7", "accolade_7_complete");
    accolades::register("MISSION_LOTUS_CHALLENGE9", "accolade_9_complete");
    accolades::register("MISSION_LOTUS_CHALLENGE8", "accolade_8_increment");
    accolades::register("MISSION_LOTUS_CHALLENGE10", "accolade_10_increment");
    accolades::register("MISSION_LOTUS_CHALLENGE11", "accolade_11_complete");
    accolades::register("MISSION_LOTUS_CHALLENGE12", "accolade_12_increment");
    accolades::register("MISSION_LOTUS_CHALLENGE13", "accolade_13_increment");
    accolades::register("MISSION_LOTUS_CHALLENGE14", "accolade_14_complete");
    accolades::register("MISSION_LOTUS_CHALLENGE15", "accolade_15_complete");
    level thread function_d657f93a();
    level thread function_b68ffa5d();
    level thread function_c6ba5108();
    function_f2c7746a();
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0xa956d313, Offset: 0xa40
// Size: 0x112
function function_f2c7746a() {
    switch (level.script) {
    case "cp_mi_cairo_lotus":
        level thread function_367835e3();
        function_8c0cbe3e();
        function_4815496();
        level thread function_75102c92();
        break;
    case "cp_mi_cairo_lotus2":
        level thread function_367835e3();
        function_4815496();
        level thread function_7c30e9e0();
        level thread function_8593adf4();
        break;
    case "cp_mi_cairo_lotus3":
        level thread function_9e965239();
        level thread function_8593adf4();
        break;
    default:
        break;
    }
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0xa77b0c08, Offset: 0xb60
// Size: 0xaa
function function_a2c4c634() {
    switch (level.var_c0e97bd) {
    case "detention_center":
        level thread function_12b1c299();
        break;
    case "boss_battle":
        level thread function_c20741bf();
        level thread function_fc480d54();
        level thread function_f53b652e();
        level thread function_aff09c5b();
        break;
    default:
        break;
    }
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0x39d39d38, Offset: 0xc18
// Size: 0x24
function function_d657f93a() {
    callback::on_actor_killed(&function_8b3820b0);
}

// Namespace lotus_accolades
// Params 1, eflags: 0x1 linked
// Checksum 0x2e755a98, Offset: 0xc48
// Size: 0xb0
function function_8b3820b0(params) {
    if (self ai::has_behavior_attribute("rogue_control") && isplayer(params.eattacker)) {
        var_9bed3c76 = self ai::get_behavior_attribute("rogue_control");
        if (var_9bed3c76 == "level_3" || var_9bed3c76 == "forced_level_3") {
            params.eattacker notify(#"accolade_3_increment");
        }
    }
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0x3a7670fe, Offset: 0xd00
// Size: 0x24
function function_b68ffa5d() {
    callback::on_ai_killed(&function_6e45ce5d);
}

// Namespace lotus_accolades
// Params 1, eflags: 0x1 linked
// Checksum 0xf4f9735, Offset: 0xd30
// Size: 0x322
function function_6e45ce5d(params) {
    if (isplayer(params.eattacker)) {
        player = params.eattacker;
        if (isdefined(player.hijacked_vehicle_entity) && player.hijacked_vehicle_entity.archetype === "raps" && player.hijacked_vehicle_entity != self) {
            player notify(#"accolade_4_increment");
        } else if (isdefined(params.einflictor) && params.einflictor.archetype === "raps" && params.einflictor != self) {
            player notify(#"accolade_4_increment");
        }
        return;
    }
    if (isdefined(params.eattacker.var_6fb3bfc3) && params.eattacker.archetype === "raps" && isplayer(params.eattacker.var_6fb3bfc3)) {
        params.eattacker.var_6fb3bfc3 notify(#"accolade_4_increment");
        return;
    }
    if (self.archetype === "raps" && params.eattacker === self) {
        foreach (player in level.activeplayers) {
            if (isdefined(player.hijacked_vehicle_entity)) {
                if (player.hijacked_vehicle_entity.archetype === "raps") {
                    if (self !== player.hijacked_vehicle_entity) {
                        n_speed = length(player.hijacked_vehicle_entity getvelocity());
                        if (n_speed >= 50) {
                            n_distance_sq = distancesquared(self.origin, player.hijacked_vehicle_entity.origin);
                            if (n_distance_sq < 14400) {
                                player notify(#"accolade_4_increment");
                            }
                        }
                    }
                }
            }
        }
    }
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0x377f2d1e, Offset: 0x1060
// Size: 0x24
function function_c6ba5108() {
    callback::on_actor_killed(&function_8eb61d56);
}

// Namespace lotus_accolades
// Params 1, eflags: 0x1 linked
// Checksum 0x3c6a9bf6, Offset: 0x1090
// Size: 0xec
function function_8eb61d56(params) {
    if (isdefined(self.traversestartnode) && isdefined(self.traversestartnode.animscript) && (isdefined(self.current_scene) && issubstr(self.current_scene, "cin_lot_10_01_skybridge_vign_jump_robot") || isplayer(params.eattacker) && self.archetype == "robot" && issubstr(tolower(self.traversestartnode.animscript), "jump"))) {
        params.eattacker notify(#"accolade_5_complete");
    }
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0x5754643a, Offset: 0x1188
// Size: 0x24
function function_367835e3() {
    callback::on_ai_spawned(&function_109e560b);
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0x2957958e, Offset: 0x11b8
// Size: 0xe8
function function_109e560b() {
    self endon(#"death");
    if (self.archetype === "human_riotshield") {
        self thread function_d48890bb();
        while (!isdefined(self.var_66202c1f)) {
            n_damage, e_attacker, v_direction, v_point, var_4ae4f03b = self waittill(#"damage");
            if (var_4ae4f03b === "MOD_RIFLE_BULLET" || var_4ae4f03b === "MOD_PISTOL_BULLET" || isplayer(e_attacker) && var_4ae4f03b === "MOD_HEAD_SHOT") {
                self.var_66202c1f = 1;
            }
        }
    }
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0xe9570bc0, Offset: 0x12a8
// Size: 0x58
function function_d48890bb() {
    attacker = self waittill(#"death");
    if (isplayer(attacker) && self.var_66202c1f !== 1) {
        attacker notify(#"accolade_6_increment");
    }
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0x571729d5, Offset: 0x1308
// Size: 0xae
function function_7c30e9e0() {
    level waittill(#"hash_c243f1de");
    if (isdefined(world.var_aaf25bba) && world.var_aaf25bba) {
        foreach (player in level.players) {
            player notify(#"accolade_7_complete");
        }
    }
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0xe69b9404, Offset: 0x13c0
// Size: 0x14
function function_8c0cbe3e() {
    world.var_aaf25bba = 1;
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0xcefd2ea7, Offset: 0x13e0
// Size: 0x24
function function_4815496() {
    callback::on_actor_killed(&function_b9a9c8d8);
}

// Namespace lotus_accolades
// Params 1, eflags: 0x1 linked
// Checksum 0x259dd1a6, Offset: 0x1410
// Size: 0x64
function function_b9a9c8d8(params) {
    if ((self.archetype == "civilian" || self.archetype == "allies") && isplayer(params.eattacker)) {
        world.var_aaf25bba = 0;
    }
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0xc6401a69, Offset: 0x1480
// Size: 0x24
function function_9e965239() {
    callback::on_actor_killed(&function_3bbd5251);
}

// Namespace lotus_accolades
// Params 1, eflags: 0x1 linked
// Checksum 0x4c0435cd, Offset: 0x14b0
// Size: 0x84
function function_3bbd5251(params) {
    if (self.archetype == "robot" && isplayer(params.eattacker) && isdefined(self.current_scene) && issubstr(self.current_scene, "cin_lotus_charging_station_awaken_robot")) {
        params.eattacker notify(#"accolade_8_increment");
    }
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0xb5aa7517, Offset: 0x1540
// Size: 0x24
function function_8593adf4() {
    callback::on_ai_killed(&function_e36c85d8);
}

// Namespace lotus_accolades
// Params 1, eflags: 0x1 linked
// Checksum 0x4b89ac64, Offset: 0x1570
// Size: 0x150
function function_e36c85d8(params) {
    if (isplayer(params.eattacker) && self.archetype == "robot") {
        player = params.eattacker;
        if (self clientfield::get("robot_EMP") || self clientfield::get("cybercom_sysoverload")) {
            if (!isdefined(player.var_cacfc33c)) {
                player thread function_8dc27487(5);
                return;
            }
            if (player.var_cacfc33c < 5) {
                player.var_29d01adc++;
                if (player.var_29d01adc >= 5) {
                    player notify(#"accolade_9_complete");
                }
                return;
            }
            player.var_cacfc33c = undefined;
            player notify(#"hash_ada946c0");
        }
    }
}

// Namespace lotus_accolades
// Params 1, eflags: 0x1 linked
// Checksum 0xf0ea6fee, Offset: 0x16c8
// Size: 0x5c
function function_8dc27487(n_max_time) {
    self endon(#"death");
    self endon(#"hash_ada946c0");
    self.var_cacfc33c = 0;
    self.var_29d01adc = 1;
    while (n_max_time > self.var_cacfc33c) {
        wait 1;
        self.var_cacfc33c++;
    }
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0x1ad67a44, Offset: 0x1730
// Size: 0x48c
function function_75102c92() {
    level.var_d97ef4e5 = [];
    if (!isdefined(level.var_d97ef4e5)) {
        level.var_d97ef4e5 = [];
    } else if (!isarray(level.var_d97ef4e5)) {
        level.var_d97ef4e5 = array(level.var_d97ef4e5);
    }
    level.var_d97ef4e5[level.var_d97ef4e5.size] = "cin_lot_02_01_startriots_vign_overwhelm_siege2nd";
    if (!isdefined(level.var_d97ef4e5)) {
        level.var_d97ef4e5 = [];
    } else if (!isarray(level.var_d97ef4e5)) {
        level.var_d97ef4e5 = array(level.var_d97ef4e5);
    }
    level.var_d97ef4e5[level.var_d97ef4e5.size] = "cin_lot_02_01_startriots_vign_overwhelm_siege1st";
    if (!isdefined(level.var_d97ef4e5)) {
        level.var_d97ef4e5 = [];
    } else if (!isarray(level.var_d97ef4e5)) {
        level.var_d97ef4e5 = array(level.var_d97ef4e5);
    }
    level.var_d97ef4e5[level.var_d97ef4e5.size] = "cin_lot_04_05_security_vign_melee_variation2";
    if (!isdefined(level.var_d97ef4e5)) {
        level.var_d97ef4e5 = [];
    } else if (!isarray(level.var_d97ef4e5)) {
        level.var_d97ef4e5 = array(level.var_d97ef4e5);
    }
    level.var_d97ef4e5[level.var_d97ef4e5.size] = "cin_lot_02_01_startriots_vign_overwhelm";
    if (!isdefined(level.var_d97ef4e5)) {
        level.var_d97ef4e5 = [];
    } else if (!isarray(level.var_d97ef4e5)) {
        level.var_d97ef4e5 = array(level.var_d97ef4e5);
    }
    level.var_d97ef4e5[level.var_d97ef4e5.size] = "cin_lot_02_01_startriots_vign_overwhelm_alt";
    if (!isdefined(level.var_d97ef4e5)) {
        level.var_d97ef4e5 = [];
    } else if (!isarray(level.var_d97ef4e5)) {
        level.var_d97ef4e5 = array(level.var_d97ef4e5);
    }
    level.var_d97ef4e5[level.var_d97ef4e5.size] = "cin_lot_02_01_startriots_vign_overwhelm_alt2";
    if (!isdefined(level.var_d97ef4e5)) {
        level.var_d97ef4e5 = [];
    } else if (!isarray(level.var_d97ef4e5)) {
        level.var_d97ef4e5 = array(level.var_d97ef4e5);
    }
    level.var_d97ef4e5[level.var_d97ef4e5.size] = "cin_lot_02_01_startriots_vign_overwhelm_end";
    if (!isdefined(level.var_d97ef4e5)) {
        level.var_d97ef4e5 = [];
    } else if (!isarray(level.var_d97ef4e5)) {
        level.var_d97ef4e5 = array(level.var_d97ef4e5);
    }
    level.var_d97ef4e5[level.var_d97ef4e5.size] = "cin_lot_02_01_startriots_vign_takeout_civkills";
    if (!isdefined(level.var_d97ef4e5)) {
        level.var_d97ef4e5 = [];
    } else if (!isarray(level.var_d97ef4e5)) {
        level.var_d97ef4e5 = array(level.var_d97ef4e5);
    }
    level.var_d97ef4e5[level.var_d97ef4e5.size] = "cin_lot_04_01_security_vign_holddown";
    if (!isdefined(level.var_d97ef4e5)) {
        level.var_d97ef4e5 = [];
    } else if (!isarray(level.var_d97ef4e5)) {
        level.var_d97ef4e5 = array(level.var_d97ef4e5);
    }
    level.var_d97ef4e5[level.var_d97ef4e5.size] = "cin_lot_04_01_security_vign_beaten_breakout_loop";
    callback::on_actor_killed(&function_f5ef0d83);
}

// Namespace lotus_accolades
// Params 1, eflags: 0x1 linked
// Checksum 0x96193fab, Offset: 0x1bc8
// Size: 0x8c
function function_f5ef0d83(params) {
    if (isplayer(params.eattacker) && self.team === "axis" && isdefined(self.current_scene) && array::contains(level.var_d97ef4e5, self.current_scene)) {
        params.eattacker notify(#"accolade_10_increment");
    }
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0xe56efb89, Offset: 0x1c60
// Size: 0xf2
function function_c20741bf() {
    level waittill(#"hash_a450f864");
    start_time = gettime();
    level waittill(#"hash_4c66c579");
    end_time = gettime();
    foreach (player in level.players) {
        if (end_time - start_time < 120000) {
            /#
                iprintln("<dev string:x28>");
            #/
            player notify(#"accolade_11_complete");
        }
    }
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0x77d19dbd, Offset: 0x1d60
// Size: 0x64
function function_fc480d54() {
    level waittill(#"hash_a450f864");
    callback::on_ai_killed(&function_e8cf8caa);
    level waittill(#"hash_65ad50c6");
    callback::remove_on_ai_killed(&function_e8cf8caa);
}

// Namespace lotus_accolades
// Params 1, eflags: 0x1 linked
// Checksum 0x124b1cb, Offset: 0x1dd0
// Size: 0x58
function function_e8cf8caa(params) {
    if (isplayer(params.eattacker) && self.var_2f8cff2 === 1) {
        params.eattacker notify(#"accolade_12_increment");
    }
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0xc7f3aa54, Offset: 0x1e30
// Size: 0x64
function function_12b1c299() {
    callback::on_ai_killed(&function_436940b1);
    level flag::wait_till("players_made_it_to_stand_down");
    callback::remove_on_ai_killed(&function_436940b1);
}

// Namespace lotus_accolades
// Params 1, eflags: 0x1 linked
// Checksum 0xdc8af3a7, Offset: 0x1ea0
// Size: 0x19c
function function_436940b1(params) {
    if (self.archetype === "robot") {
        if (isplayer(params.eattacker)) {
            player = params.eattacker;
            if (isdefined(player.hijacked_vehicle_entity) && player.hijacked_vehicle_entity.archetype === "amws" && player.hijacked_vehicle_entity != self) {
                player notify(#"accolade_13_increment");
            } else if (isdefined(params.einflictor) && params.einflictor.archetype === "amws" && params.einflictor != self) {
                player notify(#"accolade_13_increment");
            }
            return;
        }
        if (isdefined(params.eattacker.var_6fb3bfc3) && params.eattacker.archetype === "amws" && isplayer(params.eattacker.var_6fb3bfc3)) {
            params.eattacker.var_6fb3bfc3 notify(#"accolade_13_increment");
        }
    }
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0x8fcd3e58, Offset: 0x2048
// Size: 0x5c
function function_f53b652e() {
    level waittill(#"hash_a450f864");
    array::thread_all(level.players, &function_d57bb90f);
    callback::on_spawned(&function_d57bb90f);
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0xd5d8ae75, Offset: 0x20b0
// Size: 0x222
function function_d57bb90f() {
    self notify(#"hash_94e247a8");
    self endon(#"death");
    self endon(#"accolade_14_complete");
    self endon(#"hash_94e247a8");
    level endon(#"hash_4c66c579");
    var_cc018542 = getweapon("launcher_standard");
    w_minigun = getweapon("minigun_lotus");
    while (isdefined(level.var_38a4277e)) {
        damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags = level.var_38a4277e waittill(#"damage");
        if (attacker === self && damage > 0) {
            if (weapon === var_cc018542 && !isdefined(self.var_e1f9f377)) {
                self.var_e1f9f377 = 1;
            } else if (weapon === w_minigun && !isdefined(self.minigun_used)) {
                self.minigun_used = 1;
            } else if (isdefined(weapon) && !isdefined(self.var_9b4dd55d) && weapon != var_cc018542 && weapon != w_minigun) {
                self.var_9b4dd55d = 1;
            }
        }
        if (self.var_e1f9f377 === 1 && self.minigun_used === 1 && self.var_9b4dd55d === 1) {
            self notify(#"accolade_14_complete");
        }
    }
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0xf586e5e5, Offset: 0x22e0
// Size: 0x1a2
function function_aff09c5b() {
    level waittill(#"hash_a450f864");
    foreach (player in level.players) {
        player flag::init("accolade_15_failed");
    }
    callback::on_spawned(&function_428a25c7);
    array::thread_all(level.players, &function_3d0c6b79);
    level waittill(#"hash_4c66c579");
    foreach (player in level.players) {
        if (!player flag::get("accolade_15_failed")) {
            /#
                iprintln("<dev string:x3d>");
            #/
            player notify(#"accolade_15_complete");
        }
    }
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0xfd9ffa31, Offset: 0x2490
// Size: 0x5c
function function_428a25c7() {
    if (!self flag::exists("accolade_15_failed")) {
        self flag::init("accolade_15_failed");
    }
    self function_3d0c6b79();
}

// Namespace lotus_accolades
// Params 0, eflags: 0x1 linked
// Checksum 0x4bb85d05, Offset: 0x24f8
// Size: 0x11a
function function_3d0c6b79() {
    self endon(#"death");
    self endon(#"accolade_15_complete");
    var_429f87f7 = getweapon("gunship_cannon");
    while (true) {
        damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags = self waittill(#"damage");
        if (weapon === var_429f87f7) {
            /#
                iprintln("<dev string:x52>");
            #/
            self flag::set("accolade_15_failed");
            return;
        }
    }
}

