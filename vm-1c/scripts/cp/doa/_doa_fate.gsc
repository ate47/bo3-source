#using scripts/cp/doa/_doa_enemy_boss;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_hazard;
#using scripts/cp/doa/_doa_shield_pickup;
#using scripts/cp/doa/_doa_chicken_pickup;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_utility;
#using scripts/cp/cp_doa_bo3_enemy;
#using scripts/shared/flag_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_23f188a4;

// Namespace namespace_23f188a4
// Params 0, eflags: 0x1 linked
// Checksum 0xb9dcfc6c, Offset: 0xa60
// Size: 0x772
function init() {
    if (!isdefined(level.doa.var_b1698a42)) {
        level.doa.var_b1698a42 = spawnstruct();
        level.doa.var_b1698a42.types = [];
        level.doa.var_b1698a42.var_9c35e18e = [];
        level.doa.var_b1698a42.arena = "temple";
        level.doa.var_b1698a42.var_64e3261c = "temple";
        level.doa.var_b1698a42.var_f485e213 = "p7_sin_rock_park_07_blue";
        level.doa.var_b1698a42.var_6e3ecc6b = "zombietron_stoneboss";
        level.doa.var_b1698a42.types[level.doa.var_b1698a42.types.size] = 1;
        level.doa.var_b1698a42.types[level.doa.var_b1698a42.types.size] = 2;
        level.doa.var_b1698a42.types[level.doa.var_b1698a42.types.size] = 3;
        level.doa.var_b1698a42.types[level.doa.var_b1698a42.types.size] = 4;
        level.doa.var_b1698a42.var_9c35e18e[level.doa.var_b1698a42.var_9c35e18e.size] = 10;
        level.doa.var_b1698a42.var_9c35e18e[level.doa.var_b1698a42.var_9c35e18e.size] = 11;
        level.doa.var_b1698a42.var_9c35e18e[level.doa.var_b1698a42.var_9c35e18e.size] = 12;
        level.doa.var_b1698a42.var_9c35e18e[level.doa.var_b1698a42.var_9c35e18e.size] = 13;
        level.doa.var_b1698a42.locations = namespace_49107f3a::function_4e9a23a9(struct::get_array("doa_fate_loc", "targetname"));
        level.doa.var_b1698a42.var_70a33a0b = namespace_49107f3a::function_4e9a23a9(struct::get_array("doa_fate2_loc", "targetname"));
        level.doa.var_b1698a42.types = namespace_49107f3a::function_4e9a23a9(level.doa.var_b1698a42.types);
        level.doa.var_b1698a42.var_9c35e18e = namespace_49107f3a::function_4e9a23a9(level.doa.var_b1698a42.var_9c35e18e);
        level.doa.var_b1698a42.var_7190e0c3 = [];
        level.doa.var_b1698a42.var_33d94cd7 = 0;
        level.doa.var_b1698a42.var_7190e0c3[level.doa.var_b1698a42.var_7190e0c3.size] = newhudelem();
        level.doa.var_b1698a42.var_7190e0c3[level.doa.var_b1698a42.var_7190e0c3.size] = newhudelem();
        level.doa.var_b1698a42.var_7190e0c3[level.doa.var_b1698a42.var_7190e0c3.size] = newhudelem();
        level.doa.var_b1698a42.var_7190e0c3[level.doa.var_b1698a42.var_7190e0c3.size] = newhudelem();
        level.doa.var_b1698a42.var_cadf4b04 = [];
        level.doa.var_b1698a42.var_1bcf76cc = 0;
        for (i = 0; i < level.doa.var_b1698a42.var_7190e0c3.size; i++) {
            level.doa.var_b1698a42.var_7190e0c3[i].alignx = "center";
            level.doa.var_b1698a42.var_7190e0c3[i].aligny = "middle";
            level.doa.var_b1698a42.var_7190e0c3[i].horzalign = "center";
            level.doa.var_b1698a42.var_7190e0c3[i].vertalign = "middle";
            level.doa.var_b1698a42.var_7190e0c3[i].y = level.doa.var_b1698a42.var_7190e0c3[i].y - 80 - i * 20;
            level.doa.var_b1698a42.var_7190e0c3[i].foreground = 1;
            level.doa.var_b1698a42.var_7190e0c3[i].fontscale = 2.5;
            level.doa.var_b1698a42.var_7190e0c3[i].color = (1, 0.2, 0);
            level.doa.var_b1698a42.var_7190e0c3[i].hidewheninmenu = 1;
        }
    }
}

// Namespace namespace_23f188a4
// Params 1, eflags: 0x5 linked
// Checksum 0xab307a80, Offset: 0x11e0
// Size: 0x20a
function private function_6162a853(var_26fc4461) {
    if (!isdefined(var_26fc4461)) {
        var_26fc4461 = 0;
    }
    level endon(#"hash_7b036079");
    time_left = gettime() + level.doa.rules.var_836e7aed * 1000 + 10000;
    diff = time_left - gettime();
    var_4af4d74c = 0;
    while (diff > 0) {
        if (diff < 8000 && !var_4af4d74c) {
            var_4af4d74c = 1;
            if (!var_26fc4461) {
                level thread namespace_49107f3a::function_37fb5c23(%DOA_FATE_ROOM_CHOOSE_HURRY);
            } else {
                level thread namespace_49107f3a::function_37fb5c23(%DOA_RIGHTEOUS_ROOM_CHOOSE_HURRY);
            }
        }
        players = getplayers();
        var_f91b96e8 = 1;
        for (i = 0; i < players.size; i++) {
            if (!var_26fc4461) {
                if (players[i].doa.fate == 0) {
                    var_f91b96e8 = 0;
                    break;
                }
                continue;
            }
            if (!(isdefined(players[i].doa.p8_food_beer_bottle_02) && players[i].doa.p8_food_beer_bottle_02)) {
                var_f91b96e8 = 0;
                break;
            }
        }
        if (var_f91b96e8) {
            break;
        }
        diff = time_left - gettime();
        wait(0.1);
    }
    level notify(#"hash_7b036079");
}

// Namespace namespace_23f188a4
// Params 4, eflags: 0x1 linked
// Checksum 0x7591ca9a, Offset: 0x13f8
// Size: 0x1d0
function function_fd0b8976(text, holdtime, color, reset) {
    if (!isdefined(holdtime)) {
        holdtime = 4;
    }
    if (!isdefined(color)) {
        color = (1, 0, 0);
    }
    if (!isdefined(reset)) {
        reset = 0;
    }
    msg = level.doa.var_b1698a42.var_7190e0c3[level.doa.var_b1698a42.var_33d94cd7];
    level.doa.var_b1698a42.var_33d94cd7++;
    if (level.doa.var_b1698a42.var_33d94cd7 >= level.doa.var_b1698a42.var_7190e0c3.size) {
        level.doa.var_b1698a42.var_33d94cd7 = 0;
    }
    msg.alpha = 0;
    msg settext(text);
    msg.color = color;
    msg fadeovertime(1);
    msg.alpha = 1;
    wait(holdtime);
    msg fadeovertime(1);
    msg.alpha = 0;
    if (reset) {
        level.doa.var_b1698a42.var_33d94cd7 = 0;
    }
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x1 linked
// Checksum 0x71e0eaa6, Offset: 0x15d0
// Size: 0x76c
function function_77ed1bae() {
    level notify(#"hash_e2918623");
    level.doa.var_5effb8dd = 0;
    guardian = getent("temple_guardian", "targetname");
    var_526b2f85 = getent("temple_guardian_clip", "targetname");
    guardian.origin += (0, 0, -1000);
    var_526b2f85.origin += (0, 0, -1000);
    level thread namespace_a7e6beb5::function_c1869ec8();
    level thread namespace_49107f3a::clearallcorpses();
    level thread namespace_d88e3a06::function_116bb43();
    level notify(#"hash_a50a72db");
    locs = struct::get_array("fate_player_spawn", "targetname");
    if (isdefined(locs) && locs.size == 4) {
        foreach (player in getplayers()) {
            spot = locs[player.entnum];
            player namespace_cdb9a8fe::function_fe0946ac(spot.origin);
            player setplayerangles((0, spot.angles[1], 0));
        }
    } else {
        namespace_cdb9a8fe::function_55762a85(namespace_3ca3c537::function_61d60e0b());
    }
    level thread namespace_49107f3a::set_lighting_state(3);
    for (i = 0; i < level.doa.var_b1698a42.types.size; i++) {
        type = level.doa.var_b1698a42.types[i];
        loc = level.doa.var_b1698a42.locations[i];
        rock = spawn("script_model", loc.origin + (0, 0, 2000));
        rock.targetname = "fate_rock";
        rock.var_103432a2 = rock.origin;
        rock.var_e35d13 = loc.origin;
        rock setmodel(level.doa.var_b1698a42.var_f485e213);
        rock.angles = (0, type * 90, 0);
        rock setscale(0.9 + type * 0.05);
        trigger = spawn("trigger_radius", rock.origin, 0, loc.radius, -128);
        trigger.targetname = "fateTrigger";
        trigger.type = type;
        trigger.rock = rock;
        trigger.id = i;
        trigger thread function_271ba816();
        level.doa.var_b1698a42.var_cadf4b04[level.doa.var_b1698a42.var_cadf4b04.size] = trigger;
        trigger enablelinkto();
        trigger linkto(rock);
    }
    namespace_49107f3a::function_390adefe(0);
    level thread namespace_49107f3a::function_c5f3ece8(%DOA_FATE_ROOM, undefined, 6);
    level notify(#"hash_ba37290e", "fate");
    wait(1);
    level thread namespace_49107f3a::function_37fb5c23(%DOA_FATE_ROOM_CHOOSE);
    level notify(#"hash_4213cffb");
    wait(4);
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] freezecontrols(0);
    }
    level thread function_6162a853();
    level thread namespace_3ca3c537::function_a50a72db();
    level notify(#"hash_3b6e1e2");
    level waittill(#"hash_7b036079");
    wait(1);
    level thread namespace_49107f3a::function_c5f3ece8(%DOA_FATE_ROOM_DONE);
    wait(5);
    namespace_49107f3a::function_44eb090b();
    level.doa.var_5effb8dd = 1;
    level.doa.var_b1698a42.var_cadf4b04 = [];
    guardian.origin += (0, 0, 1000);
    var_526b2f85.origin += (0, 0, 1000);
    level thread namespace_49107f3a::set_lighting_state(level.doa.var_458c27d);
}

// Namespace namespace_23f188a4
// Params 1, eflags: 0x5 linked
// Checksum 0xa14aca4e, Offset: 0x1d48
// Size: 0x34
function private function_7882f69e(trigger) {
    self endon(#"death");
    level waittill(#"hash_7b036079");
    trigger notify(#"hash_fad6c90b");
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x5 linked
// Checksum 0xd3baca9b, Offset: 0x1d88
// Size: 0x1a4
function private function_524284e0() {
    self endon(#"death");
    level thread function_7882f69e(self);
    note = self util::waittill_any_return("trigger_wrong_match", "trigger_right_match", "trigger_fated", "death");
    self triggerenable(0);
    switch (note) {
    case 22:
        self.rock thread namespace_eaa992c::function_285a2999("fate_impact");
        self.rock thread namespace_eaa992c::function_285a2999("fate_trigger");
        self.rock thread namespace_eaa992c::function_285a2999("fate_impact");
        break;
    case 23:
        self.rock thread namespace_eaa992c::function_285a2999("fate_impact");
        self.rock thread namespace_eaa992c::function_285a2999("fate_trigger");
        break;
    case 24:
        self.rock thread namespace_eaa992c::function_285a2999("fate_impact");
        break;
    }
    self.rock thread namespace_49107f3a::function_a98c85b2(self.rock.var_103432a2, 1.5);
}

// Namespace namespace_23f188a4
// Params 1, eflags: 0x5 linked
// Checksum 0xf1b9362b, Offset: 0x1f38
// Size: 0xa02
function private function_271ba816(var_26fc4461) {
    if (!isdefined(var_26fc4461)) {
        var_26fc4461 = 0;
    }
    level endon(#"hash_7b036079");
    self thread function_46575fe6();
    self thread function_524284e0();
    self.rock thread namespace_eaa992c::function_285a2999("glow_blue");
    level waittill(#"hash_4213cffb");
    wait(randomfloatrange(1, 2.5));
    self.rock thread namespace_49107f3a::function_a98c85b2(self.rock.var_e35d13, 1.5);
    self.rock thread namespace_1a381543::function_90118d8c("zmb_fate_rock_spawn");
    wait(1.5);
    self.rock thread namespace_eaa992c::function_285a2999("fate_impact");
    self.rock thread namespace_1a381543::function_90118d8c("zmb_fate_rock_imp");
    objective_add(self.id, "active", self.origin);
    function_4ccbe3a6(self.id, 1, "default", "*");
    while (true) {
        guy = self waittill(#"trigger");
        objective_state(self.id, "done");
        if (!isplayer(guy)) {
            continue;
        }
        if (!var_26fc4461) {
            if (guy.doa.fate != 0) {
                continue;
            }
        } else if (isdefined(guy.doa.p8_food_beer_bottle_02) && guy.doa.p8_food_beer_bottle_02) {
            continue;
        }
        if (!var_26fc4461) {
            guy function_194ede2e(self.type, self.rock);
            self notify(#"hash_9075e98");
            break;
        }
        guy.doa.p8_food_beer_bottle_02 = 1;
        if (guy.doa.fate == 0) {
            avail = level.doa.var_b1698a42.types;
            players = namespace_831a4a7c::function_5eb6e4d1();
            foreach (player in players) {
                if (player == guy) {
                    continue;
                }
                if (player.doa.fate == 0) {
                    continue;
                }
                if (player.doa.fate == 10 || player.doa.fate == 1) {
                    arrayremovevalue(avail, 1, 0);
                }
                if (player.doa.fate == 11 || player.doa.fate == 2) {
                    arrayremovevalue(avail, 2, 0);
                }
                if (player.doa.fate == 12 || player.doa.fate == 3) {
                    arrayremovevalue(avail, 3, 0);
                }
                if (player.doa.fate == 13 || player.doa.fate == 4) {
                    arrayremovevalue(avail, 4, 0);
                }
            }
            assert(avail.size > 0);
            if (avail.size == 1) {
                fate = avail[0];
            } else {
                fate = avail[randomint(avail.size)];
            }
            guy function_194ede2e(fate, self.rock);
            self notify(#"hash_9075e98");
            continue;
        }
        if (isdefined(level.doa.var_aaefc0f3) && level.doa.var_aaefc0f3) {
            if (guy.doa.fate == 1) {
                type = 10;
            } else if (guy.doa.fate == 2) {
                type = 11;
            } else if (guy.doa.fate == 3) {
                type = 12;
            } else if (guy.doa.fate == 4) {
                type = 13;
            }
            if (isdefined(type)) {
                guy function_194ede2e(type, self.rock);
                self notify(#"hash_14fdf5a2");
            } else {
                self thread function_78f27983(guy);
                self notify(#"hash_fad6c90b");
            }
            var_f91b96e8 = 1;
            foreach (player in getplayers()) {
                if (!isdefined(player.doa) || !(isdefined(player.doa.p8_food_beer_bottle_02) && player.doa.p8_food_beer_bottle_02)) {
                    var_f91b96e8 = 0;
                    break;
                }
            }
            if (var_f91b96e8) {
                level notify(#"hash_7b036079");
            }
            continue;
        }
        if (self.type == 10 && guy.doa.fate == 1) {
            guy function_194ede2e(self.type, self.rock);
            self notify(#"hash_14fdf5a2");
            level notify(#"hash_7b036079");
            break;
        }
        if (self.type == 11 && guy.doa.fate == 2) {
            guy function_194ede2e(self.type, self.rock);
            self notify(#"hash_14fdf5a2");
            level notify(#"hash_7b036079");
            break;
        }
        if (self.type == 12 && guy.doa.fate == 3) {
            guy function_194ede2e(self.type, self.rock);
            self notify(#"hash_14fdf5a2");
            level notify(#"hash_7b036079");
            break;
        }
        if (self.type == 13 && guy.doa.fate == 4) {
            guy function_194ede2e(self.type, self.rock);
            self notify(#"hash_14fdf5a2");
            level notify(#"hash_7b036079");
            break;
        }
        self thread function_78f27983(guy);
        self notify(#"hash_fad6c90b");
        break;
    }
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x1 linked
// Checksum 0xf69bc857, Offset: 0x2948
// Size: 0x94
function function_b6841741() {
    level thread function_fd0b8976(%DOA_FATE_FIREPOWER, 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
    self.doa.var_ca0a87c8 = level.doa.var_416914d0;
    self.doa.var_1b58e8ba = 1;
    self namespace_831a4a7c::function_baa7411e(self.doa.var_ca0a87c8);
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x1 linked
// Checksum 0x9932690f, Offset: 0x29e8
// Size: 0x6c
function function_d30f9791() {
    level thread function_fd0b8976(%DOA_FATE_FORTUNE, 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
    if (self.doa.multiplier < 2) {
        self namespace_64c6b720::function_126dc996(2);
    }
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x1 linked
// Checksum 0x50ff902a, Offset: 0x2a60
// Size: 0xb4
function function_2a2ab6f9() {
    level thread function_fd0b8976(%DOA_FATE_FEET, 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
    self.doa.var_1c03b6ad = level.doa.rules.var_b92b82b;
    self setmovespeedscale(level.doa.rules.var_b92b82b);
    self thread namespace_eaa992c::function_285a2999("fast_feet");
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x1 linked
// Checksum 0x28159395, Offset: 0x2b20
// Size: 0x7c
function function_4c552db8() {
    self.doa.var_1b58e8ba = 2;
    level thread function_fd0b8976(%DOA_FATE_FRIENDSHIP, 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
    self thread namespace_5e6c5d1f::function_d35a405a(level.doa.var_a7cfb7eb, 1);
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x1 linked
// Checksum 0x3da72faf, Offset: 0x2ba8
// Size: 0x84
function function_c8508847() {
    level thread function_fd0b8976(%DOA_FATE_FORCE, 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
    if (self.doa.var_c5e98ad6 < 4) {
        self.doa.var_c5e98ad6 = 4;
    }
    self thread namespace_eaa992c::function_285a2999("fate2_awarded");
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x1 linked
// Checksum 0x80f1536a, Offset: 0x2c38
// Size: 0xa4
function function_47b8a2a2() {
    level thread function_fd0b8976(%DOA_FATE_FORTITUDE, 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
    if (self.doa.multiplier < 3) {
        self namespace_64c6b720::function_126dc996(3);
    }
    self thread namespace_6df66aa5::function_2016b381();
    self thread namespace_eaa992c::function_285a2999("fate2_awarded");
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x1 linked
// Checksum 0x18ece69c, Offset: 0x2ce8
// Size: 0x8c
function function_78c32d42() {
    level thread function_fd0b8976(%DOA_FATE_FAVOR, 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
    self thread namespace_5e6c5d1f::function_d35a405a(level.doa.var_9505395a, 2, 1.5);
    self thread namespace_eaa992c::function_285a2999("fate2_awarded");
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x1 linked
// Checksum 0x9f91963c, Offset: 0x2d80
// Size: 0xcc
function function_8c9288de() {
    level thread function_fd0b8976(%DOA_FATE_FURY, 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
    if (self.doa.bombs < 1) {
        self.doa.bombs = 1;
    }
    self.doa.var_ca0a87c8 = level.doa.var_69899304;
    self namespace_831a4a7c::function_baa7411e(self.doa.var_ca0a87c8);
    self thread namespace_eaa992c::function_285a2999("fate2_awarded");
}

// Namespace namespace_23f188a4
// Params 1, eflags: 0x5 linked
// Checksum 0xe99dbb9b, Offset: 0x2e58
// Size: 0x16c
function private function_78f27983(player) {
    level thread function_fd0b8976(%DOA_FATE_BOOBY_PRIZE, 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
    if (isdefined(player.doa.var_eb1cd159)) {
        player thread namespace_a7e6beb5::function_ab651d00(player, "zombietron_extra_life");
        var_a72e62b4 = int(player.doa.var_eb1cd159 / 75000);
        if (var_a72e62b4 < 3) {
            var_a72e62b4 = 3;
        }
        if (var_a72e62b4 > 12) {
            var_a72e62b4 = 12;
        }
        items = namespace_a7e6beb5::function_16237a19(player.origin + (0, 0, 1000), 1, 75, 0, 0, var_a72e62b4);
        items[0] thread namespace_a7e6beb5::function_53347911(player);
        player.doa.var_eb1cd159 = 0;
    }
}

// Namespace namespace_23f188a4
// Params 2, eflags: 0x1 linked
// Checksum 0x290e730f, Offset: 0x2fd0
// Size: 0x2ce
function function_194ede2e(type, rock) {
    if (isdefined(rock)) {
        rock thread namespace_eaa992c::function_285a2999("fate_trigger");
        rock thread namespace_1a381543::function_90118d8c("zmb_fate_choose");
    }
    self.doa.fate = type;
    switch (type) {
    case 1:
        level thread function_17fb777b(self, getweaponworldmodel(level.doa.var_e00fcc77), 2.1, &function_b6841741);
        break;
    case 2:
        level thread function_17fb777b(self, "zombietron_ruby", 4, &function_d30f9791);
        break;
    case 4:
        level thread function_17fb777b(self, level.doa.var_f7277ad6, 4, &function_2a2ab6f9);
        break;
    case 3:
        level thread function_17fb777b(self, level.doa.var_a7cfb7eb, 4, &function_4c552db8);
        break;
    case 10:
        level thread function_17fb777b(self, "zombietron_statue_fury", 1, &function_8c9288de);
        break;
    case 11:
        level thread function_17fb777b(self, "zombietron_statue_fortitude", 1, &function_47b8a2a2);
        break;
    case 12:
        level thread function_17fb777b(self, "zombietron_statue_favor", 1, &function_78c32d42);
        break;
    case 13:
        level thread function_17fb777b(self, "zombietron_statue_force", 1, &function_c8508847);
        break;
    default:
        assert(0);
        break;
    }
}

// Namespace namespace_23f188a4
// Params 4, eflags: 0x1 linked
// Checksum 0x6be27e5, Offset: 0x32a8
// Size: 0x2cc
function function_17fb777b(player, model, modelscale, var_cb7e0a61) {
    player endon(#"disconnect");
    if (!isdefined(modelscale)) {
        modelscale = 1;
    }
    origin = player.origin + (0, 0, 800);
    object = spawn("script_model", origin);
    object.targetname = "directedFate";
    yaw = randomint(360);
    object.angles = (0, yaw, 25);
    object setmodel(model);
    object setscale(modelscale);
    object setplayercollision(0);
    object thread namespace_49107f3a::function_a625b5d3(player);
    while (isplayer(player)) {
        if (object.origin[2] < player.origin[2]) {
            object.origin = player.origin;
            break;
        }
        var_d305e57f = (player.origin[0], player.origin[1], object.origin[2] - 32);
        object.origin = var_d305e57f;
        wait(0.05);
    }
    if (isplayer(player)) {
        object thread namespace_eaa992c::function_285a2999("fate_explode");
        player playrumbleonentity("artillery_rumble");
        if (mayspawnentity()) {
            player playsoundtoplayer("zmb_doa_receive_fate", player);
        }
        player [[ var_cb7e0a61 ]]();
    }
    object delete();
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x5 linked
// Checksum 0xb23b1bde, Offset: 0x3580
// Size: 0xa4
function private function_46575fe6() {
    level waittill(#"hash_7b036079");
    if (isdefined(self)) {
        objective_delete(self.id);
        self triggerenable(0);
        level namespace_49107f3a::function_d0e32ad0(1);
        if (isdefined(self.rock)) {
            self.rock delete();
        }
        self delete();
    }
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x1 linked
// Checksum 0xac197328, Offset: 0x3630
// Size: 0x500
function function_c631d045() {
    var_de2c598 = undefined;
    candidates = [];
    foreach (player in getplayers()) {
        if (!isdefined(player.doa)) {
            continue;
        }
        if (player.doa.fate == 10) {
            /#
                namespace_49107f3a::debugmsg("DOA_FATE_ROOM_CHOOSE_HURRY" + (isdefined(player.name) ? player.name : player getentitynumber()) + "DOA_FATE_ROOM_CHOOSE_HURRY");
            #/
            continue;
        }
        if (player.doa.fate == 11) {
            /#
                namespace_49107f3a::debugmsg("DOA_FATE_ROOM_CHOOSE_HURRY" + (isdefined(player.name) ? player.name : player getentitynumber()) + "DOA_FATE_ROOM_CHOOSE_HURRY");
            #/
            continue;
        }
        if (player.doa.fate == 12) {
            /#
                namespace_49107f3a::debugmsg("DOA_FATE_ROOM_CHOOSE_HURRY" + (isdefined(player.name) ? player.name : player getentitynumber()) + "DOA_FATE_ROOM_CHOOSE_HURRY");
            #/
            continue;
        }
        if (player.doa.fate == 13) {
            /#
                namespace_49107f3a::debugmsg("DOA_FATE_ROOM_CHOOSE_HURRY" + (isdefined(player.name) ? player.name : player getentitynumber()) + "DOA_FATE_ROOM_CHOOSE_HURRY");
            #/
            continue;
        }
        candidates[candidates.size] = player;
    }
    foreach (candidate in candidates) {
        damage = isdefined(candidate.doa.var_eb1cd159) ? candidate.doa.var_eb1cd159 : randomint(100);
        karma = candidate.doa.var_faf30682 * 8000;
        candidate.doa.var_e5be00e0 = damage + karma;
        /#
            namespace_49107f3a::debugmsg("DOA_FATE_ROOM_CHOOSE_HURRY" + (isdefined(candidate.name) ? candidate.name : candidate getentitynumber()) + "DOA_FATE_ROOM_CHOOSE_HURRY" + candidate.doa.var_e5be00e0);
            namespace_49107f3a::debugmsg("DOA_FATE_ROOM_CHOOSE_HURRY" + damage);
            namespace_49107f3a::debugmsg("DOA_FATE_ROOM_CHOOSE_HURRY" + karma);
        #/
        if (!isdefined(var_de2c598)) {
            var_de2c598 = candidate;
            continue;
        }
        if (var_de2c598.doa.var_e5be00e0 < candidate.doa.var_e5be00e0) {
            var_de2c598 = candidate;
        }
    }
    return var_de2c598;
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x1 linked
// Checksum 0xad4698a, Offset: 0x3b38
// Size: 0xb6c
function function_833dad0d() {
    level notify(#"hash_e2918623");
    level endon(#"hash_d1f5acf7");
    guardian = getent("temple_guardian", "targetname");
    var_526b2f85 = getent("temple_guardian_clip", "targetname");
    guardian.origin += (0, 0, -1000);
    var_526b2f85.origin += (0, 0, -1000);
    level thread function_be1e2cfc(guardian, var_526b2f85);
    level.doa.rules.max_enemy_count = 20;
    level thread namespace_a7e6beb5::function_c1869ec8();
    level thread namespace_49107f3a::clearallcorpses();
    level thread namespace_d88e3a06::function_116bb43();
    level notify(#"hash_a50a72db");
    level thread namespace_49107f3a::set_lighting_state(3);
    namespace_cdb9a8fe::function_691ef36b();
    namespace_cdb9a8fe::function_703bb8b2(30);
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i].doa.var_eb1cd159 = 0;
        players[i].doa.p8_food_beer_bottle_02 = undefined;
    }
    level.doa.var_b1698a42.var_1bcf76cc = 1;
    flag::set("doa_round_active");
    level thread function_b6a1fab3();
    /#
        namespace_49107f3a::debugmsg("DOA_FATE_ROOM_CHOOSE_HURRY");
    #/
    namespace_49107f3a::function_390adefe(0);
    level thread namespace_49107f3a::function_c5f3ece8(%DOA_TRIAL_OF_JUDGEMENT, undefined, 6);
    wait(1);
    level thread namespace_49107f3a::function_37fb5c23(%DOA_RIGHTEOUS_ROOM_BATTLE);
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] freezecontrols(0);
    }
    wait(3);
    level clientfield::set("activateBanner", 1);
    wait(4);
    level thread namespace_3ca3c537::function_a50a72db();
    level notify(#"hash_3b6e1e2");
    /#
        namespace_49107f3a::debugmsg("DOA_FATE_ROOM_CHOOSE_HURRY");
    #/
    level waittill(#"hash_cb54277d");
    /#
        namespace_49107f3a::debugmsg("DOA_FATE_ROOM_CHOOSE_HURRY");
    #/
    level clientfield::set("activateBanner", 0);
    flag::clear("doa_round_active");
    level thread namespace_49107f3a::function_1ced251e();
    level waittill(#"hash_852a9fcd");
    /#
        namespace_49107f3a::debugmsg("DOA_FATE_ROOM_CHOOSE_HURRY");
    #/
    namespace_49107f3a::function_44eb090b();
    level thread namespace_a7e6beb5::function_c1869ec8();
    level thread namespace_49107f3a::clearallcorpses();
    var_de2c598 = function_c631d045();
    if (!isdefined(var_de2c598)) {
        level notify(#"hash_43593ce6");
        return;
    }
    /#
        namespace_49107f3a::debugmsg("DOA_FATE_ROOM_CHOOSE_HURRY" + (isdefined(var_de2c598.name) ? var_de2c598.name : var_de2c598 getentitynumber()) + "DOA_FATE_ROOM_CHOOSE_HURRY" + var_de2c598.doa.var_e5be00e0);
    #/
    for (i = 0; i < level.doa.var_b1698a42.var_9c35e18e.size; i++) {
        type = 10 + var_de2c598.doa.fate - 1;
        loc = level.doa.var_b1698a42.var_70a33a0b[i];
        rock = spawn("script_model", loc.origin + (0, 0, 2000));
        rock.targetname = "doRoomOfJudgement";
        rock.var_e35d13 = loc.origin;
        rock.var_103432a2 = rock.origin;
        rock.angles = loc.angles + (0, 90, 0);
        rock setmodel(level.doa.var_b1698a42.var_f485e213);
        trigger = spawn("trigger_radius", rock.origin, 0, loc.radius, -128);
        trigger.targetname = "fate2trigger";
        trigger.type = type;
        trigger.rock = rock;
        trigger.id = i;
        trigger thread function_271ba816(1);
        trigger enablelinkto();
        trigger linkto(rock);
        level.doa.var_b1698a42.var_cadf4b04[level.doa.var_b1698a42.var_cadf4b04.size] = trigger;
    }
    locs = struct::get_array("fate_player_spawn", "targetname");
    if (isdefined(locs) && locs.size == 4) {
        foreach (player in getplayers()) {
            spot = locs[player.entnum];
            player namespace_cdb9a8fe::function_fe0946ac(spot.origin);
            player setplayerangles((0, spot.angles[1], 0));
        }
    } else {
        namespace_cdb9a8fe::function_55762a85(namespace_3ca3c537::function_61d60e0b());
    }
    level thread namespace_49107f3a::set_lighting_state(3);
    namespace_831a4a7c::function_82e3b1cb();
    /#
        namespace_49107f3a::debugmsg("DOA_FATE_ROOM_CHOOSE_HURRY");
    #/
    namespace_49107f3a::function_390adefe(0);
    level thread namespace_49107f3a::function_c5f3ece8(%DOA_RIGHTEOUS_ROOM, undefined, 6);
    if (!(isdefined(level.doa.var_aaefc0f3) && level.doa.var_aaefc0f3)) {
        level thread namespace_49107f3a::function_37fb5c23(%DOA_FATE_ONLY_ONE);
    } else {
        level thread namespace_49107f3a::function_37fb5c23(%DOA_FATE_ALL_WORTHY);
    }
    level notify(#"hash_4213cffb");
    wait(4);
    foreach (player in getplayers()) {
        player freezecontrols(0);
        player thread namespace_831a4a7c::function_4519b17(0);
    }
    level thread function_6162a853(1);
    /#
        namespace_49107f3a::debugmsg("DOA_FATE_ROOM_CHOOSE_HURRY");
    #/
    level waittill(#"hash_7b036079");
    /#
        namespace_49107f3a::debugmsg("DOA_FATE_ROOM_CHOOSE_HURRY");
    #/
    level thread namespace_49107f3a::function_c5f3ece8(%DOA_RIGHTEOUS_ROOM_DONE);
    wait(5);
    namespace_49107f3a::debugmsg("ROJ Complete");
    level notify(#"hash_43593ce6");
    namespace_49107f3a::function_44eb090b();
}

// Namespace namespace_23f188a4
// Params 2, eflags: 0x1 linked
// Checksum 0x643e0491, Offset: 0x46b0
// Size: 0x1ac
function function_be1e2cfc(guardian, var_526b2f85) {
    msg = level util::waittill_any("graveofJusticeDone", "player_challenge_failure");
    level clientfield::set("activateBanner", 0);
    level waittill(#"hash_96377490");
    if (isdefined(level.doa.boss)) {
        level.doa.boss delete();
    }
    level thread namespace_49107f3a::set_lighting_state(level.doa.var_458c27d);
    level.doa.var_aaefc0f3 = 1;
    level.doa.var_b1698a42.var_cadf4b04 = [];
    guardian.origin += (0, 0, 1000);
    var_526b2f85.origin += (0, 0, 1000);
    level.doa.var_b1698a42.var_1bcf76cc = 0;
    level.doa.rules.max_enemy_count = namespace_3ca3c537::function_b0e9983(namespace_3ca3c537::function_d2d75f5d());
}

// Namespace namespace_23f188a4
// Params 1, eflags: 0x5 linked
// Checksum 0x892cf81b, Offset: 0x4868
// Size: 0x168
function private function_5aaa5a64(shield) {
    self endon(#"death");
    level endon(#"hash_cb54277d");
    while (true) {
        guy = self waittill(#"trigger");
        if (!isalive(guy)) {
            continue;
        }
        if (!isdefined(guy.doa)) {
            continue;
        }
        if (!isdefined(guy.doa.var_d6d294af)) {
            guy.doa.var_d6d294af = 0;
        }
        if (gettime() < guy.doa.var_d6d294af) {
            continue;
        }
        guy.doa.var_d6d294af = gettime() + 3000;
        guy thread namespace_eaa992c::function_285a2999("stoneboss_shield_death");
        shield thread namespace_1a381543::function_90118d8c("zmb_boss_shield_death");
        guy dodamage(guy.health + 500, guy.origin);
    }
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x5 linked
// Checksum 0xfbc9936c, Offset: 0x49d8
// Size: 0xf4
function private function_d654dcd9() {
    level util::waittill_any("boss_of_justice_died", "player_challenge_failure");
    if (isdefined(self)) {
        if (isdefined(self.shield)) {
            if (isdefined(self.shield.trigger)) {
                self.shield.trigger delete();
            }
            self.shield thread namespace_eaa992c::function_285a2999("stoneboss_shield_explode");
            util::wait_network_frame();
            if (isdefined(self) && isdefined(self.shield)) {
                self.shield delete();
            }
        }
        if (isdefined(self)) {
            self delete();
        }
    }
}

// Namespace namespace_23f188a4
// Params 1, eflags: 0x5 linked
// Checksum 0x3369f0f, Offset: 0x4ad8
// Size: 0x66
function private function_60a14daa(boss) {
    self.boss = boss;
    self endon(#"death");
    while (true) {
        self rotateto(self.angles + (0, 180, 0), 2);
        wait(2);
    }
}

// Namespace namespace_23f188a4
// Params 1, eflags: 0x5 linked
// Checksum 0x4b55687b, Offset: 0x4b48
// Size: 0x47c
function private function_b1d23a45(boss) {
    level endon(#"hash_d1f5acf7");
    self thread namespace_eaa992c::function_285a2999("tesla_trail");
    self.angles = (0, 0, 180);
    self.trigger = spawn("trigger_radius", self.origin, 0, 30, 50);
    self.trigger.targetname = "boss_shieldThink";
    self.trigger enablelinkto();
    self.trigger linkto(self);
    self.trigger thread function_5aaa5a64(self);
    self.health = 100000;
    self.maxhealth = self.health;
    self.takedamage = 1;
    stage1 = int(self.maxhealth * 0.75);
    var_4c0a8371 = int(self.maxhealth * 0.25);
    while (self.health > 0) {
        lasthealth = self.health;
        damage = self waittill(#"damage");
        if (isdefined(self.var_e34a8df9)) {
            self thread namespace_eaa992c::function_285a2999("stoneboss_shield_explode");
            loc = spawnstruct();
            loc.origin = self.origin;
            loc.angles = self.angles;
            if (level.doa.var_b351e5fb >= level.doa.rules.max_enemy_count) {
                namespace_49107f3a::function_fe180f6f(3);
                wait(0.05);
            }
            ai = namespace_51bd792::function_fb051310(self.var_e34a8df9, loc, undefined, 0, 1);
            if (isdefined(ai)) {
                ai.spawner = self.var_e34a8df9;
                ai.team = "axis";
                ai.health = 5000;
                ai.maxhealth = ai.health;
                ai.var_2d8174e3 = 1;
                ai thread namespace_49107f3a::function_dbcf48a0();
            }
            break;
        }
        self.health -= damage;
        if (lasthealth > stage1 && self.health < stage1) {
            self setmodel("zombietron_boss_shield_damage_size" + self.org.var_67b66425);
            self thread namespace_eaa992c::function_285a2999("stoneboss_shield_explode");
            continue;
        }
        if (lasthealth > var_4c0a8371 && self.health < var_4c0a8371) {
            self setmodel("zombietron_boss_shield_destroyed_size" + self.org.var_67b66425);
            self thread namespace_eaa992c::function_285a2999("stoneboss_shield_explode");
        }
    }
    if (isdefined(self.trigger)) {
        self.trigger delete();
    }
    if (isdefined(boss)) {
        boss notify(#"hash_d57cf5a3", self.org);
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_23f188a4
// Params 1, eflags: 0x5 linked
// Checksum 0x97bd382d, Offset: 0x4fd0
// Size: 0x326
function private function_4d69c061(org) {
    level endon(#"hash_d1f5acf7");
    level endon(#"hash_cb54277d");
    if (!isdefined(org)) {
        return;
    }
    org.var_67b66425++;
    if (isdefined(org.var_e34a8df9) && org.var_67b66425 > 4) {
        org.var_67b66425 = 4;
    }
    if (org.var_67b66425 > 4) {
        org delete();
        return;
    }
    wait(12 - getplayers().size * 2);
    shield = spawn("script_model", self.origin);
    shield.targetname = "_shieldRegenerate";
    shield.org = org;
    if (isdefined(org.shield)) {
        if (isdefined(org.shield.trigger)) {
            org.shield.trigger delete();
        }
        org.shield delete();
    }
    org.shield = shield;
    if (isdefined(org.var_e34a8df9)) {
        shield setmodel("veh_t7_drone_insanity_elemental");
        shield.var_e34a8df9 = org.var_e34a8df9;
        shield linkto(shield.org, "tag_origin", (0, -92 - org.var_67b66425 * 8, 60), (0, 0, 180));
    } else {
        shield setmodel("zombietron_boss_shield_full_size" + org.var_67b66425);
        shield linkto(shield.org, "tag_origin", (0, -92 - org.var_67b66425 * 8, 30), (0, 0, 180));
    }
    shield thread function_b1d23a45(org.boss);
    org.boss.var_a49abda5[org.index] = shield;
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x5 linked
// Checksum 0x4b02007, Offset: 0x5300
// Size: 0x3a8
function private function_51f0dd2c() {
    level endon(#"hash_d1f5acf7");
    level endon(#"hash_cb54277d");
    var_3fb52dd3 = 20;
    var_7383e7dd = [];
    var_7383e7dd[var_7383e7dd.size] = 0;
    if (level.doa.round_number > 64) {
        var_7383e7dd[var_7383e7dd.size] = 9;
    }
    if (level.doa.round_number > -128) {
        var_7383e7dd[var_7383e7dd.size] = 14;
    }
    if (level.doa.round_number > -64) {
        var_7383e7dd[var_7383e7dd.size] = 4;
    }
    for (i = 0; i < var_3fb52dd3; i++) {
        org = spawn("script_model", self.origin);
        org.targetname = "_bossShield";
        org setmodel("tag_origin");
        org thread function_60a14daa(self);
        org thread function_d654dcd9();
        org.index = i;
        org.var_67b66425 = 1;
        shield = spawn("script_model", self.origin);
        shield.targetname = "shield";
        shield.org = org;
        org.shield = shield;
        if (!isinarray(var_7383e7dd, i)) {
            shield setmodel("zombietron_boss_shield_full_size1");
            shield linkto(shield.org, "tag_origin", (0, -92, 30), (0, 0, 180));
        } else {
            shield setmodel("veh_t7_drone_insanity_elemental");
            org.var_e34a8df9 = getent("spawner_meatball", "targetname");
            shield.var_e34a8df9 = org.var_e34a8df9;
            shield linkto(shield.org, "tag_origin", (0, -92, 60), (0, 0, 180));
        }
        shield thread function_b1d23a45(self);
        self.var_a49abda5[self.var_a49abda5.size] = shield;
        wait(0.2);
    }
    while (true) {
        org = self waittill(#"hash_d57cf5a3");
        self thread function_4d69c061(org);
    }
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x5 linked
// Checksum 0x765898a4, Offset: 0x56b0
// Size: 0x11e
function private function_cb98790d() {
    level endon(#"hash_d1f5acf7");
    level endon(#"hash_cb54277d");
    while (true) {
        level waittill(#"hash_8817f58");
        foreach (ball in self.var_a49abda5) {
            if (isdefined(ball)) {
                ball thread namespace_eaa992c::function_285a2999("stoneboss_shield_explode");
                util::wait_network_frame();
                if (isdefined(ball)) {
                    ball dodamage(ball.maxhealth, ball.origin);
                }
                wait(0.05);
            }
        }
    }
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x5 linked
// Checksum 0xb75d50e3, Offset: 0x57d8
// Size: 0x6be
function private function_c492e72d() {
    level endon(#"hash_d1f5acf7");
    self.health = namespace_49107f3a::clamp(level.doa.round_number * 20000 + getplayers().size * 250000, 250000, 2250000);
    self.maxhealth = self.health;
    self.boss = 1;
    self.takedamage = 0;
    self.var_a49abda5 = [];
    self thread function_51f0dd2c();
    self thread function_cb98790d();
    self thread function_ae21464b();
    self thread function_5c819284();
    level waittill(#"hash_3b6e1e2");
    self.takedamage = 1;
    stage1 = int(self.health * 0.85);
    var_4c0a8371 = int(self.health * 0.7);
    var_26080908 = int(self.health * 0.55);
    var_301961e7 = int(self.health * 0.4);
    var_a16e77e = int(self.health * 0.2);
    /#
        if (isdefined(level.doa.var_33749c8)) {
            self thread namespace_4973e019::function_76b30cc1();
        }
    #/
    while (self.health > 0) {
        lasthealth = self.health;
        damage, attacker = self waittill(#"damage");
        data = namespace_49107f3a::clamp(self.health / self.maxhealth, 0, 1);
        level clientfield::set("pumpBannerBar", data);
        if (isdefined(attacker)) {
            if (!isplayer(attacker)) {
                if (isdefined(attacker.owner) && isplayer(attacker.owner)) {
                    attacker = attacker.owner;
                }
            }
            if (isdefined(attacker.doa) && isplayer(attacker)) {
                if (!isdefined(attacker.doa.var_eb1cd159)) {
                    attacker.doa.var_eb1cd159 = 0;
                }
                attacker.doa.var_eb1cd159 += damage;
                attacker namespace_64c6b720::function_80eb303(int(damage * 0.25), 1);
            }
        }
        if (lasthealth > stage1 && self.health < stage1) {
            self thread namespace_eaa992c::function_285a2999("stoneboss_dmg1");
            self thread namespace_1a381543::function_90118d8c("zmb_stoneboss_damaged");
            level notify(#"hash_55acdab7");
        } else if (lasthealth > var_4c0a8371 && self.health < var_4c0a8371) {
            self thread namespace_eaa992c::function_285a2999("stoneboss_dmg2");
            self thread namespace_1a381543::function_90118d8c("zmb_stoneboss_damaged");
            level notify(#"hash_55acdab7");
        } else if (lasthealth > var_26080908 && self.health < var_26080908) {
            self thread namespace_eaa992c::function_285a2999("stoneboss_dmg3");
            self thread namespace_1a381543::function_90118d8c("zmb_stoneboss_damaged");
            level notify(#"hash_55acdab7");
        } else if (lasthealth > var_301961e7 && self.health < var_301961e7) {
            self thread namespace_eaa992c::function_285a2999("stoneboss_dmg4");
            self thread namespace_1a381543::function_90118d8c("zmb_stoneboss_damaged");
            level notify(#"hash_55acdab7");
        } else if (lasthealth > var_a16e77e && self.health < var_a16e77e) {
            self thread namespace_eaa992c::function_285a2999("stoneboss_dmg5");
            self thread namespace_1a381543::function_90118d8c("zmb_stoneboss_damaged");
            level notify(#"hash_55acdab7");
        }
        /#
            namespace_49107f3a::debugmsg("DOA_FATE_ROOM_CHOOSE_HURRY" + self.health);
        #/
    }
    self thread namespace_eaa992c::function_285a2999("stoneboss_death");
    self thread namespace_1a381543::function_90118d8c("zmb_stoneboss_died");
    self notify(#"defeated");
    level notify(#"defeated", self);
    level notify(#"hash_cb54277d");
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x5 linked
// Checksum 0x5fe2339f, Offset: 0x5ea0
// Size: 0xe8
function private function_ae21464b() {
    level endon(#"hash_d1f5acf7");
    level endon(#"hash_cb54277d");
    while (true) {
        wait(randomintrange(10, 20) - getplayers().size * 1.2);
        self thread namespace_1a381543::function_90118d8c("zmb_boss_sound_minion_summon");
        level notify(#"hash_55acdab7");
        /#
            if (getdvarint("DOA_FATE_ROOM_CHOOSE_HURRY", 0)) {
                self dodamage(int(self.maxhealth * 0.1), self.origin);
            }
        #/
    }
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x5 linked
// Checksum 0xd8412865, Offset: 0x5f90
// Size: 0x17a
function private function_5c819284() {
    level endon(#"hash_d1f5acf7");
    level endon(#"hash_cb54277d");
    var_a47b1f6f = level.doa.arenas[level.doa.var_90873830].name + "_enemy_spawn";
    level.doa.var_c984ad24 = level.doa.spawners[var_a47b1f6f];
    level.doa.var_3706f843 = [];
    while (true) {
        for (wave = 0; wave < level.doa.var_d9933f22.size; wave++) {
            level waittill(#"hash_55acdab7");
            if (level flag::get("doa_game_is_over")) {
                return;
            }
            if (!level flag::get("doa_round_active")) {
                return;
            }
            level.doa.var_6808cc14 = level.doa.var_d9933f22[wave];
            level thread namespace_cdb9a8fe::function_21a582ff(level.doa.var_6808cc14, "boss_of_justice_died");
        }
    }
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x5 linked
// Checksum 0x9e1a81fc, Offset: 0x6118
// Size: 0x924
function private function_b6a1fab3() {
    level endon(#"hash_d1f5acf7");
    level.doa.var_d0cde02c = undefined;
    arenacenter = namespace_3ca3c537::function_61d60e0b();
    var_9a550361 = arenacenter;
    boss = spawn("script_model", var_9a550361);
    boss.targetname = "stoneguardian";
    boss setmodel(level.doa.var_b1698a42.var_6e3ecc6b);
    boss thread function_c492e72d();
    level.doa.boss = boss;
    badplace_cylinder("bossJustice", -1, boss.origin, -76, 64, "all");
    loc = level.doa.var_b1698a42.locations[0];
    var_3686ea09 = spawn("script_model", loc.origin);
    var_3686ea09.targetname = "fury";
    var_3686ea09 setmodel("zombietron_statue_fury");
    var_3686ea09.angles = loc.angles + (0, 90, 0);
    var_3686ea09 thread namespace_49107f3a::function_783519c1("player_challenge_failure", 1);
    loc = level.doa.var_b1698a42.locations[1];
    force = spawn("script_model", loc.origin);
    force.targetname = "force";
    force setmodel("zombietron_statue_force");
    force.angles = loc.angles + (0, 90, 0);
    force thread namespace_49107f3a::function_783519c1("player_challenge_failure", 1);
    loc = level.doa.var_b1698a42.locations[2];
    var_47bba3bb = spawn("script_model", loc.origin);
    var_47bba3bb.targetname = "fortitude";
    var_47bba3bb setmodel("zombietron_statue_fortitude");
    var_47bba3bb.angles = loc.angles + (0, 90, 0);
    var_47bba3bb thread namespace_49107f3a::function_783519c1("player_challenge_failure", 1);
    loc = level.doa.var_b1698a42.locations[3];
    var_ae3e72bf = spawn("script_model", loc.origin);
    var_ae3e72bf.targetname = "favor";
    var_ae3e72bf setmodel("zombietron_statue_favor");
    var_ae3e72bf.angles = loc.angles + (0, 90, 0);
    var_ae3e72bf thread namespace_49107f3a::function_783519c1("player_challenge_failure", 1);
    level waittill(#"hash_cb54277d");
    level.doa.boss = undefined;
    badplace_delete("bossJustice");
    playfx(level._effect["def_explode"], boss.origin + (randomint(120), randomint(120), randomint(120)));
    wait(1);
    level thread namespace_49107f3a::function_c5f3ece8(%DOA_RIGHTEOUS_ROOM_BATTLE_WON);
    for (i = 0; i < 6; i++) {
        playfx(level._effect["def_explode"], boss.origin + (randomint(120), randomint(120), randomint(120)));
        wait(randomfloatrange(0.25, 1.2));
    }
    boss thread namespace_49107f3a::function_a98c85b2(boss.origin + (0, 0, 2000), 1.75);
    boss thread namespace_eaa992c::function_285a2999("fate_impact");
    boss thread namespace_eaa992c::function_285a2999("stoneboss_death");
    wait(4);
    var_3686ea09 thread namespace_49107f3a::function_a98c85b2(var_3686ea09.origin + (0, 0, 2000), 1.75);
    var_3686ea09 thread namespace_eaa992c::function_285a2999("fate_impact");
    var_3686ea09 thread namespace_eaa992c::function_285a2999("fate_launch");
    wait(1);
    force thread namespace_49107f3a::function_a98c85b2(force.origin + (0, 0, 2000), 1.75);
    force thread namespace_eaa992c::function_285a2999("fate_impact");
    force thread namespace_eaa992c::function_285a2999("fate_launch");
    wait(1);
    var_47bba3bb thread namespace_49107f3a::function_a98c85b2(var_47bba3bb.origin + (0, 0, 2000), 1.75);
    var_47bba3bb thread namespace_eaa992c::function_285a2999("fate_impact");
    var_47bba3bb thread namespace_eaa992c::function_285a2999("fate_launch");
    wait(1);
    var_ae3e72bf thread namespace_49107f3a::function_a98c85b2(var_ae3e72bf.origin + (0, 0, 2000), 1.75);
    var_ae3e72bf thread namespace_eaa992c::function_285a2999("fate_impact");
    var_ae3e72bf thread namespace_eaa992c::function_285a2999("fate_launch");
    wait(2);
    level notify(#"hash_852a9fcd");
    boss delete();
    var_47bba3bb delete();
    force delete();
    var_3686ea09 delete();
    var_ae3e72bf delete();
}

// Namespace namespace_23f188a4
// Params 1, eflags: 0x1 linked
// Checksum 0x46e87a85, Offset: 0x6a48
// Size: 0x1ba
function function_3caf8e2(endtime) {
    self endon(#"disconnect");
    lastposition = self.origin;
    stepsize = 20;
    self clientfield::set("fated_boost", 1);
    while (gettime() < endtime) {
        wait(0.2);
        normal = vectornormalize(self.origin - lastposition);
        step = normal * stepsize;
        dist = distance(self.origin, lastposition);
        if (dist < 10) {
            continue;
        }
        steps = int(dist / stepsize + 0.5);
        for (i = 0; i < steps; i++) {
            self thread function_69ae5d15(lastposition);
            lastposition += step;
        }
        var_d4961e33 = self.origin;
    }
    self clientfield::set("fated_boost", 0);
    self notify(#"hash_c6e7fa2c");
}

// Namespace namespace_23f188a4
// Params 1, eflags: 0x5 linked
// Checksum 0x5807a50f, Offset: 0x6c10
// Size: 0x35c
function private function_69ae5d15(loc) {
    if (!self isonground()) {
        return;
    }
    if (isdefined(self.doa.vehicle)) {
        return;
    }
    if (!mayspawnfakeentity()) {
        return;
    }
    trigger = spawn("trigger_radius", loc, 9, 36, 64);
    if (!isdefined(trigger)) {
        return;
    }
    trigger endon(#"death");
    trigger.targetname = "furyhotspot";
    trigger thread namespace_49107f3a::function_a625b5d3(self);
    variance = randomfloatrange(0, 3);
    time = 10 + variance;
    trigger thread namespace_49107f3a::function_1bd67aef(time);
    timeleft = gettime() + time * 1000;
    while (gettime() < timeleft) {
        wait(0.05);
        guy = trigger waittill(#"trigger");
        if (isplayer(guy)) {
            continue;
        }
        if (!(isdefined(guy.takedamage) && guy.takedamage)) {
            continue;
        }
        if (isdefined(guy.boss) && guy.boss) {
            continue;
        }
        if (isdefined(guy.var_dd70dacd) && guy.var_dd70dacd) {
            continue;
        }
        time = gettime();
        if (isdefined(guy.var_4c8b5b70) && time - guy.var_4c8b5b70 < 1000) {
            continue;
        }
        guy asmsetanimationrate(0.75);
        guy dodamage(int(guy.maxhealth * 0.3), guy.origin, self, undefined, "none", "MOD_BURNED");
        if (!(isdefined(guy.var_52b0b328) && guy.var_52b0b328)) {
            guy thread function_9fc6e261();
            guy clientfield::set("burnType", 3);
            guy clientfield::increment("burnZombie");
        }
        guy.var_4c8b5b70 = time;
    }
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x5 linked
// Checksum 0x2d6f4b45, Offset: 0x6f78
// Size: 0xdc
function private function_9fc6e261() {
    self notify(#"hash_9fc6e261");
    self endon(#"hash_9fc6e261");
    corpse = self waittill(#"actor_corpse");
    wait(0.05);
    if (isdefined(corpse)) {
        corpse clientfield::set("burnType", 3);
        wait(0.05);
        if (isdefined(corpse)) {
            corpse clientfield::increment("burnCorpse");
            if (randomint(100) < 50) {
                corpse clientfield::set("enemy_ragdoll_explode", 1);
            }
        }
    }
}

