#using scripts/cp/gametypes/_globallogic;
#using scripts/shared/array_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace battlechatter;

// Namespace battlechatter
// Params 0, eflags: 0x2
// Checksum 0x46335fe9, Offset: 0x858
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("battlechatter", &__init__, undefined, undefined);
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0x49ce9f9b, Offset: 0x898
// Size: 0x64
function __init__() {
    callback::on_start_gametype(&init);
    var_eee9d0c8 = getactorspawnerarray();
    callback::on_ai_spawned(&function_53474d87);
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0xb8adf613, Offset: 0x908
// Size: 0x64
function init() {
    callback::on_spawned(&on_player_spawned);
    level.battlechatter_init = 1;
    level.allowbattlechatter = [];
    level.allowbattlechatter["bc"] = 1;
    level thread function_ec97233e();
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0xa863678f, Offset: 0x978
// Size: 0x138
function function_ec97233e() {
    while (true) {
        clone, vehentnum = level waittill(#"clonedentity");
        if (isdefined(clone) && isdefined(clone.archetype)) {
            vehiclename = clone.archetype;
            if (vehiclename == "wasp") {
                alias = "hijack_wasps";
            } else if (vehiclename == "raps") {
                alias = "hijack_raps";
            } else if (vehiclename == "quadtank") {
                alias = "hijack_quad";
            } else {
                alias = undefined;
            }
            var_6aa12504 = function_5c9a0c2("axis", clone);
            if (isdefined(var_6aa12504) && isdefined(alias)) {
                level thread function_f3de557b(var_6aa12504, alias);
            }
        }
    }
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0x874e044c, Offset: 0xab8
// Size: 0x2f4
function function_53474d87() {
    self endon(#"disconnect");
    if (isdefined(level.var_f0ca204d) && level.var_f0ca204d) {
        return;
    }
    if (isvehicle(self)) {
        return;
    }
    if (isdefined(self.archetype) && self.archetype == "zombie") {
        return;
    }
    if (isdefined(self.archetype) && self.archetype == "direwolf") {
        return;
    }
    if (!isdefined(self.voiceprefix)) {
        self.voiceprefix = "vox_ax";
    }
    if (self.voiceprefix == "vox_hend" || self.voiceprefix == "vox_khal" || self.voiceprefix == "vox_kane" || self.voiceprefix == "vox_hall" || self.voiceprefix == "vox_mare" || isdefined(self.voiceprefix) && self.voiceprefix == "vox_diaz") {
        self.var_273d3e89 = "";
    } else if (self.voiceprefix == "vox_term") {
        self.var_273d3e89 = randomintrange(0, 3);
    } else {
        self.var_273d3e89 = randomintrange(0, 4);
    }
    if (isdefined(self.archetype) && self.archetype == "warlord") {
        self thread function_c8397d24();
    }
    self.isspeaking = 0;
    self.soundmod = "player";
    self thread function_9f9445a7();
    self thread function_5980aba1();
    self thread function_3920250c();
    if (!(isdefined(self.archetype) && self.archetype == "robot")) {
        self thread function_f921f5a3();
        self thread function_73f2f03f();
        if (isdefined(self.voiceprefix) && getsubstr(self.voiceprefix, 7) == "f") {
            self.var_273d3e89 = randomintrange(0, 2);
        }
        return;
    }
    self thread function_897d1130();
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0xcffdf2c7, Offset: 0xdb8
// Size: 0xd8
function function_c8397d24() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    while (true) {
        wait(randomintrange(6, 14));
        if (isdefined(self)) {
            var_49f3ceea = array("action_peek", "action_moving", "enemy_contact");
            line = var_49f3ceea[randomintrange(0, var_49f3ceea.size)];
            level thread function_f3de557b(self, line);
        }
    }
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0x9db3b3dd, Offset: 0xe98
// Size: 0xd7e
function function_9f9445a7() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    while (true) {
        notify_string = self waittill(#"bhtn_action_notify");
        switch (notify_string) {
        case 78:
            if (!(isdefined(self.archetype) && self.archetype == "robot")) {
                level thread function_f3de557b(self, "exert_pain");
            }
            break;
        case 62:
            if (!(isdefined(self.archetype) && self.archetype == "robot")) {
                level thread function_f3de557b(self, "exert_cough", undefined, undefined, 1);
            }
            break;
        case 66:
            if (!(isdefined(self.archetype) && self.archetype == "robot") && !(self.voiceprefix == "vox_germ" || isdefined(self.voiceprefix) && self.voiceprefix == "vox_usa")) {
                if (randomintrange(0, 100) <= 50) {
                    level thread function_f3de557b(self, "enemy_kill");
                }
            }
            break;
        case 75:
            if (!(isdefined(self.archetype) && self.archetype == "robot") && !(self.voiceprefix == "vox_germ" || isdefined(self.voiceprefix) && self.voiceprefix == "vox_usa")) {
                if (randomintrange(0, 100) <= 50) {
                    level thread function_f3de557b(self, "melee_kill");
                }
            }
            break;
        case 58:
        case 96:
        case 83:
        case 73:
        case 74:
        case 77:
        case 101:
        case 102:
            if (!(isdefined(self.archetype) && self.archetype == "robot") && !(self.voiceprefix == "vox_germ" || isdefined(self.voiceprefix) && self.voiceprefix == "vox_usa")) {
                level thread function_f3de557b(self, notify_string);
            }
            break;
        case 65:
        case 81:
            if (!(isdefined(self.archetype) && self.archetype == "robot")) {
                level thread function_f3de557b(self, "exert_electrocution", undefined, undefined, 1);
            }
            break;
        case 80:
            if (!(isdefined(self.archetype) && self.archetype == "robot")) {
                level thread function_f3de557b(self, "exert_sonic", undefined, undefined, 1);
            }
            break;
        case 98:
            if (!(isdefined(self.archetype) && self.archetype == "robot")) {
                level thread function_f3de557b(self, "exert_scream");
            }
            break;
        case 99:
            if (isdefined(self.archetype) && self.archetype == "robot") {
                level thread function_f3de557b(self, "action_intocover");
            }
            break;
        case 95:
            if (randomintrange(0, 100) <= 20) {
                level thread function_f3de557b(self, "action_reloading", 1);
            }
            break;
        case 67:
            self thread function_bf2c3663();
            break;
        case 63:
            if (randomintrange(0, 100) <= 10) {
                level thread function_f3de557b(self, "enemy_contact");
            }
            break;
        case 64:
            if (randomintrange(0, 100) <= 45) {
                level thread function_f3de557b(self, "action_intocover");
            }
            break;
        case 61:
            if (!(isdefined(self.archetype) && self.archetype == "robot")) {
                if (!(self.voiceprefix == "vox_hend" || self.voiceprefix == "vox_khal" || self.voiceprefix == "vox_kane" || self.voiceprefix == "vox_hall" || self.voiceprefix == "vox_mare" || isdefined(self.voiceprefix) && self.voiceprefix == "vox_diaz")) {
                    soundalias = "vox_generic_exert_charge_male";
                    if (isdefined(self.voiceprefix) && getsubstr(self.voiceprefix, 7) == "f") {
                        soundalias = "vox_generic_exert_charge_female";
                    }
                    self thread function_81d8fcf2(soundalias, 1);
                } else {
                    level thread function_f3de557b(self, "exert_charge");
                }
            }
            break;
        case 59:
            if (!(isdefined(self.archetype) && self.archetype == "robot")) {
                if (!(self.voiceprefix == "vox_hend" || self.voiceprefix == "vox_khal" || self.voiceprefix == "vox_kane" || self.voiceprefix == "vox_hall" || self.voiceprefix == "vox_mare" || isdefined(self.voiceprefix) && self.voiceprefix == "vox_diaz")) {
                    soundalias = "vox_generic_exert_melee_male";
                    if (isdefined(self.voiceprefix) && getsubstr(self.voiceprefix, 7) == "f") {
                        soundalias = "vox_generic_exert_melee_female";
                    }
                    self thread function_81d8fcf2(soundalias, 1);
                } else {
                    level thread function_f3de557b(self, "exert_melee");
                }
            }
            break;
        case 60:
            level thread function_f3de557b(self, "action_blindfire");
            break;
        case 72:
            level thread function_f3de557b(self, "action_flanked");
            break;
        case 79:
        case 97:
            if (randomintrange(0, 100) <= 25) {
                level thread function_f3de557b(self, "action_peek");
            }
            break;
        case 68:
            level thread function_f3de557b(self, "action_exposed");
            break;
        case 100:
            if (randomintrange(0, 100) <= 75) {
                level thread function_f3de557b(self, "action_intocover");
            }
            break;
        case 76:
            if (randomintrange(0, 100) <= 6) {
                level thread function_f3de557b(self, "action_moving");
            }
            break;
        case 84:
        case 85:
        case 87:
        case 88:
            level thread function_f3de557b(self, "action_exposed");
            break;
        case 86:
            if (randomintrange(0, 100) <= 30) {
                level thread function_f3de557b(self, "action_moving");
            }
            break;
        case 71:
            if (randomintrange(0, 100) <= 50) {
                level thread function_f3de557b(self, "firefly_response");
            }
            if (randomintrange(0, 100) <= 50) {
                var_c4d1d000 = function_5c9a0c2("allies", self);
                if (isdefined(var_c4d1d000)) {
                    level util::delay(1, undefined, &function_f3de557b, var_c4d1d000, "firefly_response");
                }
            }
            break;
        case 49:
            if (randomintrange(0, 100) <= 50) {
                teammate = function_c0d9abd6(self);
                if (isdefined(teammate)) {
                    level thread function_f3de557b(teammate, "firefly_explode");
                }
            }
            break;
        case 69:
            level thread function_f3de557b(self, "exert_firefly", undefined, undefined, 1);
            break;
        case 70:
            level thread function_f3de557b(self, "exert_firefly_burning", undefined, undefined, 1);
            break;
        case 82:
            level thread function_f3de557b(self, "rapidstrike_response");
            break;
        case 103:
        case 104:
            var_49f3ceea = array("action_peek", "action_moving", "enemy_contact");
            line = var_49f3ceea[randomintrange(0, var_49f3ceea.size)];
            level thread function_f3de557b(self, line);
            break;
        case 91:
            level thread function_f3de557b(self, "exert_immolation", undefined, undefined, 1);
            break;
        case 92:
            level thread function_f3de557b(self, "exert_immolation", undefined, undefined, 1);
            break;
        case 94:
            level thread function_f3de557b(self, "exert_screaming", undefined, undefined, 1);
            break;
        case 105:
            level thread function_f3de557b(self, "exert_malfunction", undefined, undefined, 1);
            break;
        case 90:
            level thread function_f3de557b(self, "exert_breakdown", undefined, undefined, 1);
            break;
        case 93:
            break;
        case 89:
            level thread function_f3de557b(self, "exert_body_blow", undefined, undefined, 1);
            break;
        default:
            break;
        }
    }
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0xce7dfc51, Offset: 0x1c20
// Size: 0x68
function function_73f2f03f() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    while (true) {
        var_daeabe55 = self waittill(#"hash_2605e152");
        level thread function_f3de557b(self, var_daeabe55);
    }
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0x484cc03e, Offset: 0x1c90
// Size: 0x84
function function_bf2c3663() {
    self endon(#"death");
    self endon(#"disconnect");
    if (randomintrange(0, 100) <= 35) {
        if (!(isdefined(level.var_bf2c3663) && level.var_bf2c3663)) {
            level thread function_f3de557b(self, "enemy_contact");
            level thread function_23b803bd();
        }
    }
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0x93b2f612, Offset: 0x1d20
// Size: 0x20
function function_23b803bd() {
    level.var_bf2c3663 = 1;
    wait(15);
    level.var_bf2c3663 = 0;
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0x366e049d, Offset: 0x1d48
// Size: 0xf8
function function_5980aba1() {
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        grenade, weapon = self waittill(#"grenade_fire");
        if (weapon.name == "frag_grenade" || weapon.name == "frag_grenade_invisible") {
            if (randomintrange(0, 100) <= 80 && !isplayer(self)) {
                level thread function_f3de557b(self, "grenade_toss");
            }
            level thread function_e94dcde5(self, grenade);
        }
    }
}

// Namespace battlechatter
// Params 2, eflags: 0x1 linked
// Checksum 0x688ae3fc, Offset: 0x1e48
// Size: 0xf4
function function_e94dcde5(thrower, grenade) {
    if (randomintrange(0, 100) <= 95) {
        wait(1);
        if (!isdefined(thrower) || !isdefined(grenade)) {
            return;
        }
        team = "axis";
        if (isdefined(thrower.team) && team == thrower.team) {
            team = "allies";
        }
        ai = function_5c9a0c2(team, grenade);
        if (isdefined(ai)) {
            level thread function_f3de557b(ai, "grenade_incoming", 1);
        }
    }
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0x995f7d5, Offset: 0x1f48
// Size: 0xa4
function function_3920250c() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"hash_7985ffa");
    while (true) {
        grenade = self waittill(#"grenade_stuck");
        if (isdefined(grenade)) {
            grenade.stucktoplayer = self;
        }
        if (isalive(self)) {
            level thread function_f3de557b(self, "grenade_sticky");
        }
        break;
    }
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0x6dda1d1c, Offset: 0x1ff8
// Size: 0x9c
function function_897d1130() {
    self endon(#"disconnect");
    attacker, meansofdeath = self waittill(#"death");
    if (isdefined(attacker) && !isplayer(attacker)) {
        if (meansofdeath == "MOD_MELEE") {
            attacker notify(#"bhtn_action_notify", "meleeKill");
            return;
        }
        attacker notify(#"bhtn_action_notify", "enemyKill");
    }
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0xd0b1a4f0, Offset: 0x20a0
// Size: 0x38c
function function_f921f5a3() {
    self endon(#"disconnect");
    attacker, meansofdeath = self waittill(#"death");
    if (isdefined(self)) {
        meleeassassinate = isdefined(meansofdeath) && meansofdeath == "MOD_MELEE_ASSASSINATE";
        if (isdefined(self.archetype) && self.archetype == "warlord") {
            self playsound("chr_warlord_death");
        }
        if (!(isdefined(self.var_801fa77c) && self.var_801fa77c) && !meleeassassinate && isdefined(attacker)) {
            if (meansofdeath == "MOD_ELECTROCUTED") {
                soundalias = self.voiceprefix + self.var_273d3e89 + "_" + "exert_electrocution";
            } else if (meansofdeath == "MOD_BURNED") {
                soundalias = self.voiceprefix + self.var_273d3e89 + "_" + "exert_firefly_burning";
            } else {
                soundalias = self.voiceprefix + self.var_273d3e89 + "_" + "exert_death";
            }
            self thread function_81d8fcf2(soundalias, 1);
        }
        if (isdefined(self.var_77b7027b) && self.var_77b7027b && isdefined(attacker) && !isplayer(attacker)) {
            level thread function_f3de557b(attacker, "sniper_kill");
            return;
        }
        if (isdefined(attacker) && !isplayer(attacker)) {
            if (meansofdeath == "MOD_MELEE") {
                attacker notify(#"bhtn_action_notify", "meleeKill");
            } else {
                attacker notify(#"bhtn_action_notify", "enemyKill");
            }
        }
        sniper = isdefined(attacker) && isdefined(attacker.scoretype) && attacker.scoretype == "_sniper";
        if (sniper || !meleeassassinate && randomintrange(0, 100) <= 35) {
            close_ai = function_c0d9abd6(self);
            if (isdefined(close_ai) && !(isdefined(close_ai.var_801fa77c) && close_ai.var_801fa77c)) {
                if (sniper) {
                    attacker.var_77b7027b = 1;
                    level thread function_f3de557b(close_ai, "sniper_threat");
                    return;
                }
                level thread function_f3de557b(close_ai, "friendly_down");
            }
        }
    }
}

// Namespace battlechatter
// Params 2, eflags: 0x1 linked
// Checksum 0x506c278f, Offset: 0x2438
// Size: 0xc4
function function_bf5d6349(object, type) {
    wait(randomfloatrange(0.1, 0.4));
    ai = function_5c9a0c2("both", object, 500);
    if (isdefined(ai)) {
        if (type == "car") {
            level thread function_f3de557b(ai, "destructible_car");
            return;
        }
        level thread function_f3de557b(ai, "destructible_barrel");
    }
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0x80159f15, Offset: 0x2508
// Size: 0x4b2
function function_66309b54() {
    level endon(#"unloaded");
    self endon(#"hash_3f7b661c");
    self endon(#"hash_f8c5dd60");
    if (!isdefined(level.var_218d7320)) {
        level.var_218d7320 = 0;
        enemies = getaiteamarray("axis", "team3");
        level.var_90fd62cb = array();
        foreach (enemy in enemies) {
            if (isdefined(enemy.archetype) && enemy.archetype == "robot") {
                array::add(level.var_90fd62cb, enemy, 0);
            }
        }
    }
    while (true) {
        wait(1);
        t = gettime();
        if (t > level.var_218d7320 + 1000) {
            level.var_218d7320 = t;
            enemies = getaiteamarray("axis", "team3");
            array::remove_dead(level.var_90fd62cb);
            array::remove_undefined(level.var_90fd62cb);
            foreach (enemy in enemies) {
                if (isdefined(enemy.archetype) && enemy.archetype == "robot") {
                    array::add(level.var_90fd62cb, enemy, 0);
                }
            }
        }
        if (level.var_90fd62cb.size <= 0) {
            continue;
        }
        played_sound = 0;
        foreach (robot in level.var_90fd62cb) {
            if (!isdefined(robot)) {
                continue;
            }
            if (distancesquared(robot.origin, self.origin) < 90000) {
                if (isdefined(robot.current_scene)) {
                    continue;
                }
                if (isdefined(robot.health) && robot.health <= 0) {
                    continue;
                }
                if (isdefined(level.scenes) && level.scenes.size >= 1) {
                    continue;
                }
                yaw = self getyawtospot(robot.origin);
                diff = self.origin[2] - robot.origin[2];
                if ((yaw < -95 || yaw > 95) && abs(diff) < -56) {
                    robot playsound("chr_robot_behind");
                    played_sound = 1;
                    break;
                }
            }
        }
        if (played_sound) {
            wait(5);
        }
    }
}

// Namespace battlechatter
// Params 1, eflags: 0x1 linked
// Checksum 0xbad40e49, Offset: 0x29c8
// Size: 0x74
function getyawtospot(spot) {
    pos = spot;
    yaw = self.angles[1] - getyaw(pos);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace battlechatter
// Params 1, eflags: 0x1 linked
// Checksum 0x6b19c29c, Offset: 0x2a48
// Size: 0x42
function getyaw(org) {
    angles = vectortoangles(org - self.origin);
    return angles[1];
}

// Namespace battlechatter
// Params 5, eflags: 0x1 linked
// Checksum 0x4bcd9115, Offset: 0x2a98
// Size: 0x16c
function function_f3de557b(ai, line, var_25c2125b, category, var_9d50be70) {
    if (!isdefined(ai)) {
        return;
    }
    ai endon(#"death");
    ai endon(#"disconnect");
    response = undefined;
    if (isdefined(var_25c2125b)) {
        response = line + "_response";
    }
    if (!isdefined(ai.voiceprefix) || !isdefined(ai.var_273d3e89)) {
        return;
    }
    if (isdefined(ai.archetype) && ai.archetype == "robot") {
        soundalias = ai.voiceprefix + ai.var_273d3e89 + "_" + "chatter";
    } else {
        soundalias = ai.voiceprefix + ai.var_273d3e89 + "_" + line;
    }
    ai thread function_81d8fcf2(soundalias, var_9d50be70, response, category);
}

// Namespace battlechatter
// Params 4, eflags: 0x1 linked
// Checksum 0x418de78f, Offset: 0x2c10
// Size: 0x21c
function function_81d8fcf2(soundalias, var_9d50be70, response, category) {
    if (!isdefined(soundalias)) {
        return;
    }
    if (!isdefined(var_9d50be70)) {
        var_9d50be70 = 0;
    }
    if (!(isdefined(self.isspeaking) && self.isspeaking) || self function_710804d(category) && var_9d50be70) {
        if (!isdefined(self.enemy) && !var_9d50be70) {
            return;
        }
        function_20dcacc5();
        if (!isdefined(self)) {
            return;
        }
        if (isdefined(self.istalking) && self.istalking) {
            return;
        }
        if (isdefined(self.isspeaking) && self.isspeaking) {
            self notify(#"bc_interrupt");
        }
        if (isalive(self)) {
            self playsoundontag(soundalias, "J_neck");
        } else {
            self playsound(soundalias);
        }
        self thread wait_playback_time(soundalias);
        result = self util::waittill_any_return(soundalias, "death", "disconnect", "bc_interrupt");
        if (result == soundalias) {
            if (isdefined(response)) {
                ai = function_c0d9abd6(self);
                if (isdefined(ai)) {
                    level thread function_f3de557b(ai, response);
                }
            }
            return;
        }
        if (isdefined(self)) {
            self stopsound(soundalias);
        }
    }
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0x8115231e, Offset: 0x2e38
// Size: 0x50
function function_20dcacc5() {
    if (!isdefined(level.var_769cc2b1)) {
        level thread function_1af43712();
    }
    while (level.var_769cc2b1 != 0) {
        util::wait_network_frame();
    }
    level.var_769cc2b1++;
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0xfc78a1dc, Offset: 0x2e90
// Size: 0x30
function function_1af43712() {
    while (true) {
        level.var_769cc2b1 = 0;
        util::wait_network_frame();
    }
}

// Namespace battlechatter
// Params 1, eflags: 0x1 linked
// Checksum 0xa3be1cc8, Offset: 0x2ec8
// Size: 0x96
function function_710804d(str_category) {
    if (!isdefined(str_category)) {
        str_category = "bc";
    }
    if (isdefined(level.allowbattlechatter) && !(isdefined(level.allowbattlechatter[str_category]) && level.allowbattlechatter[str_category])) {
        return false;
    }
    if (isdefined(self.allowbattlechatter) && !(isdefined(self.allowbattlechatter[str_category]) && self.allowbattlechatter[str_category])) {
        return false;
    }
    return true;
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0x9705872b, Offset: 0x2f68
// Size: 0xbc
function on_player_spawned() {
    self endon(#"disconnect");
    self.soundmod = "player";
    self.var_9fcbfcc0 = 0;
    self.var_54d33b1a = 1;
    self.isspeaking = 0;
    self thread pain_vox();
    self thread function_5980aba1();
    self thread function_66309b54();
    self thread function_a19a4a61();
    self thread function_a01d72bd();
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0x3964d763, Offset: 0x3030
// Size: 0x82
function function_a19a4a61() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    while (true) {
        notify_string = self waittill(#"bhtn_action_notify");
        switch (notify_string) {
        case 134:
            break;
        case 135:
            break;
        default:
            break;
        }
    }
}

// Namespace battlechatter
// Params 1, eflags: 0x0
// Checksum 0xebb7a07c, Offset: 0x30c0
// Size: 0xa4
function function_e6d1a282(suffix) {
    soundalias = "vox_plyr_" + suffix;
    if (self function_710804d() && !(isdefined(self.istalking) && self.istalking) && !(isdefined(self.isspeaking) && self.isspeaking)) {
        self playsoundtoplayer(soundalias, self);
        self thread wait_playback_time(soundalias);
    }
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0x25938fe3, Offset: 0x3170
// Size: 0x100
function pain_vox() {
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        meansofdeath = self waittill(#"hash_b6c93e47");
        if (randomintrange(0, 100) <= 100) {
            if (isalive(self)) {
                if (meansofdeath == "MOD_DROWN") {
                    soundalias = "chr_swimming_drown";
                    self.var_9fcbfcc0 = 1;
                    if (self.var_54d33b1a) {
                        self thread function_7c4151cc();
                    }
                }
                soundalias = "vox_plyr_exert_pain";
                self thread function_81d8fcf2(soundalias, 1);
            }
        }
        wait(0.5);
    }
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0xa6ccc3fa, Offset: 0x3278
// Size: 0xc0
function function_7c4151cc() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"hash_d1d64fcc");
    level endon(#"game_ended");
    self.var_54d33b1a = 0;
    while (true) {
        if (!self isplayerunderwater() && self.var_9fcbfcc0) {
            self.var_9fcbfcc0 = 0;
            self.var_54d33b1a = 1;
            self thread function_81d8fcf2("vox_pm1_gas_gasp", 1);
            self notify(#"hash_d1d64fcc");
        }
        wait(0.5);
    }
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0xa05d64ed, Offset: 0x3340
// Size: 0x58
function function_a01d72bd() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    while (true) {
        self waittill(#"melee_cybercom");
        self thread function_7e9c7abd();
    }
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0x9e652fe, Offset: 0x33a0
// Size: 0x68
function function_7e9c7abd() {
    self endon(#"melee_cybercom");
    wait(2);
    if (isdefined(self)) {
        ai = level function_5c9a0c2("axis", self, 700);
        if (isdefined(ai)) {
            ai notify(#"bhtn_action_notify", "rapidstrike");
        }
    }
}

// Namespace battlechatter
// Params 2, eflags: 0x1 linked
// Checksum 0x5f424b52, Offset: 0x3410
// Size: 0xa8
function wait_playback_time(soundalias, timeout) {
    self endon(#"death");
    self endon(#"disconnect");
    playbacktime = soundgetplaybacktime(soundalias);
    self.isspeaking = 1;
    if (playbacktime >= 0) {
        waittime = playbacktime * 0.001;
        wait(waittime);
    } else {
        wait(1);
    }
    self notify(soundalias);
    self.isspeaking = 0;
}

// Namespace battlechatter
// Params 2, eflags: 0x1 linked
// Checksum 0xddf5be60, Offset: 0x34c0
// Size: 0x37e
function function_c0d9abd6(var_77415466, maxdist) {
    if (isdefined(var_77415466)) {
        aiarray = getaiteamarray(var_77415466.team);
        aiarray = arraysort(aiarray, var_77415466.origin);
        if (!isdefined(maxdist)) {
            maxdist = 1000;
        }
        foreach (dude in aiarray) {
            if (!isdefined(var_77415466)) {
                return undefined;
            }
            if (!isdefined(dude) || !isalive(dude) || !isdefined(dude.var_273d3e89)) {
                continue;
            }
            if (dude == var_77415466) {
                continue;
            }
            if (isvehicle(dude)) {
                continue;
            }
            if (isdefined(dude.archetype) && dude.archetype == "robot") {
                continue;
            }
            if (!(dude.voiceprefix == "vox_hend" || dude.voiceprefix == "vox_khal" || dude.voiceprefix == "vox_kane" || dude.voiceprefix == "vox_hall" || dude.voiceprefix == "vox_mare" || isdefined(dude.voiceprefix) && dude.voiceprefix == "vox_diaz") && !(var_77415466.voiceprefix == "vox_hend" || var_77415466.voiceprefix == "vox_khal" || var_77415466.voiceprefix == "vox_kane" || var_77415466.voiceprefix == "vox_hall" || var_77415466.voiceprefix == "vox_mare" || isdefined(var_77415466.voiceprefix) && var_77415466.voiceprefix == "vox_diaz")) {
                if (dude.var_273d3e89 == var_77415466.var_273d3e89) {
                    continue;
                }
            }
            if (distance(var_77415466.origin, dude.origin) > maxdist) {
                continue;
            }
            return dude;
        }
    }
    return undefined;
}

// Namespace battlechatter
// Params 3, eflags: 0x1 linked
// Checksum 0xf3730a1a, Offset: 0x3848
// Size: 0x216
function function_5c9a0c2(team, object, maxdist) {
    if (!isdefined(object)) {
        return;
    }
    if (team == "both") {
        aiarray = getaiteamarray("axis", "allies");
    } else {
        aiarray = getaiteamarray(team);
    }
    aiarray = arraysort(aiarray, object.origin);
    if (!isdefined(maxdist)) {
        maxdist = 1000;
    }
    foreach (dude in aiarray) {
        if (!isdefined(dude) || !isalive(dude)) {
            continue;
        }
        if (isvehicle(dude)) {
            continue;
        }
        if (isdefined(dude.archetype) && dude.archetype == "robot") {
            continue;
        }
        if (!isdefined(dude.voiceprefix) || !isdefined(dude.var_273d3e89)) {
            continue;
        }
        if (distance(dude.origin, object.origin) > maxdist) {
            continue;
        }
        return dude;
    }
    return undefined;
}

// Namespace battlechatter
// Params 2, eflags: 0x1 linked
// Checksum 0xb9e6b090, Offset: 0x3a68
// Size: 0x66
function function_d9f49fba(b_allow, str_category) {
    if (!isdefined(str_category)) {
        str_category = "bc";
    }
    assert(isdefined(b_allow), "axis");
    level.allowbattlechatter[str_category] = b_allow;
}

