#using scripts/codescripts/struct;
#using scripts/cp/cp_doa_bo3_enemy;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_chicken_pickup;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_enemy_boss;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_hazard;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_shield_pickup;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;

#namespace namespace_23f188a4;

// Namespace namespace_23f188a4
// Params 0, eflags: 0x0
// Checksum 0xef3322df, Offset: 0xa60
// Size: 0x6b1
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
// Params 1, eflags: 0x4
// Checksum 0xaa550575, Offset: 0x1120
// Size: 0x177
function private function_6162a853(var_26fc4461) {
    if (!isdefined(var_26fc4461)) {
        var_26fc4461 = 0;
    }
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
        wait 0.1;
    }
    level notify(#"hash_7b036079");
}

// Namespace namespace_23f188a4
// Params 3, eflags: 0x0
// Checksum 0xbb2a6122, Offset: 0x12a0
// Size: 0x13e
function function_fd0b8976(text, holdtime, color) {
    if (!isdefined(holdtime)) {
        holdtime = 4;
    }
    if (!isdefined(color)) {
        color = (1, 0, 0);
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
    wait holdtime;
    msg fadeovertime(1);
    msg.alpha = 0;
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x0
// Checksum 0x23ae8ef7, Offset: 0x13e8
// Size: 0x562
function function_77ed1bae() {
    level notify(#"hash_e2918623");
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
        rock.angles = (0, randomint(360), 0);
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
    wait 1;
    level thread namespace_49107f3a::function_37fb5c23(%DOA_FATE_ROOM_CHOOSE);
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] freezecontrols(0);
    }
    level notify(#"hash_4213cffb");
    level thread function_6162a853();
    wait 3;
    level thread namespace_3ca3c537::function_a50a72db();
    level notify(#"hash_3b6e1e2");
    level waittill(#"hash_7b036079");
    wait 1;
    level thread namespace_49107f3a::function_c5f3ece8(%DOA_FATE_ROOM_DONE);
    wait 5;
    namespace_49107f3a::function_44eb090b();
    level.doa.var_5effb8dd = 1;
    level.doa.var_b1698a42.var_cadf4b04 = [];
    guardian.origin += (0, 0, 1000);
    var_526b2f85.origin += (0, 0, 1000);
    level thread namespace_49107f3a::set_lighting_state(level.doa.var_458c27d);
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x4
// Checksum 0x7374c035, Offset: 0x1958
// Size: 0x16a
function private function_524284e0() {
    self endon(#"death");
    self endon(#"delete");
    note = self util::waittill_any_return("trigger_wrong_match", "trigger_right_match", "trigger_fated");
    self triggerenable(0);
    switch (note) {
    case "trigger_fated":
        self.rock thread namespace_eaa992c::function_285a2999("fate_impact");
        self.rock thread namespace_eaa992c::function_285a2999("fate_trigger");
        self.rock thread namespace_eaa992c::function_285a2999("fate_impact");
        break;
    case "trigger_right_match":
        self.rock thread namespace_eaa992c::function_285a2999("fate_impact");
        self.rock thread namespace_eaa992c::function_285a2999("fate_trigger");
        break;
    case "trigger_wrong_match":
        self.rock thread namespace_eaa992c::function_285a2999("fate_impact");
        break;
    }
    self.rock thread namespace_49107f3a::function_a98c85b2(self.rock.var_103432a2, 1.5);
}

// Namespace namespace_23f188a4
// Params 1, eflags: 0x4
// Checksum 0x4c94d6e5, Offset: 0x1ad0
// Size: 0x553
function private function_271ba816(var_26fc4461) {
    if (!isdefined(var_26fc4461)) {
        var_26fc4461 = 0;
    }
    level endon(#"hash_7b036079");
    self thread function_46575fe6();
    self thread function_524284e0();
    self.rock thread namespace_eaa992c::function_285a2999("glow_blue");
    level waittill(#"hash_4213cffb");
    wait randomfloatrange(1, 2.5);
    self.rock thread namespace_49107f3a::function_a98c85b2(self.rock.var_e35d13, 1.5);
    self.rock thread namespace_1a381543::function_90118d8c("zmb_fate_rock_spawn");
    wait 1.5;
    self.rock thread namespace_eaa992c::function_285a2999("fate_impact");
    self.rock thread namespace_1a381543::function_90118d8c("zmb_fate_rock_imp");
    objective_add(self.id, "active", self.origin);
    function_4ccbe3a6(self.id, 1, "default", "*");
    while (true) {
        self waittill(#"trigger", guy);
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
            self notify(#"trigger_fated");
            break;
        }
        guy.doa.p8_food_beer_bottle_02 = 1;
        if (guy.doa.fate == 0) {
            players = namespace_831a4a7c::function_5eb6e4d1();
            var_16147667 = [];
            foreach (player in players) {
                if (player == guy) {
                    continue;
                }
                if (player.doa.fate != 0) {
                    var_16147667[var_16147667.size] = player.doa.fate;
                }
            }
            avail = level.doa.var_b1698a42.types;
            foreach (type in var_16147667) {
                arrayremovevalue(avail, type, 0);
            }
            assert(avail.size > 0);
            if (avail.size == 1) {
                fate = avail[0];
            } else {
                fate = avail[randomint(avail.size)];
            }
            guy function_194ede2e(fate, self.rock);
            self notify(#"trigger_fated");
            continue;
        }
        if (self.type == 10 && guy.doa.fate == 1) {
            guy function_194ede2e(self.type, self.rock);
            self notify(#"trigger_right_match");
            break;
        }
        if (self.type == 11 && guy.doa.fate == 2) {
            guy function_194ede2e(self.type, self.rock);
            self notify(#"trigger_right_match");
            break;
        }
        if (self.type == 12 && guy.doa.fate == 3) {
            guy function_194ede2e(self.type, self.rock);
            self notify(#"trigger_right_match");
            break;
        }
        if (self.type == 13 && guy.doa.fate == 4) {
            guy function_194ede2e(self.type, self.rock);
            self notify(#"trigger_right_match");
            break;
        }
        self thread function_78f27983(guy);
        self notify(#"trigger_wrong_match");
        break;
    }
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x0
// Checksum 0xcafbe276, Offset: 0x2030
// Size: 0xaa
function function_b6841741() {
    level thread function_fd0b8976(%DOA_FATE_FIREPOWER, 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
    self.doa.var_ca0a87c8 = getweapon("zombietron_deathmachine");
    self takeallweapons();
    self giveweapon(self.doa.var_ca0a87c8);
    self switchtoweaponimmediate(self.doa.var_ca0a87c8);
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x0
// Checksum 0x73f870e, Offset: 0x20e8
// Size: 0x5a
function function_d30f9791() {
    level thread function_fd0b8976(%DOA_FATE_FORTUNE, 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
    if (self.doa.multiplier < 2) {
        self.doa.multiplier = 2;
    }
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x0
// Checksum 0x7c6a481a, Offset: 0x2150
// Size: 0x9a
function function_2a2ab6f9() {
    level thread function_fd0b8976(%DOA_FATE_FEET, 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
    self.doa.var_1c03b6ad = level.doa.rules.var_b92b82b;
    self setmovespeedscale(level.doa.rules.var_b92b82b);
    self thread namespace_eaa992c::function_285a2999("fast_feet");
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x0
// Checksum 0xb7ddd6c9, Offset: 0x21f8
// Size: 0x52
function function_4c552db8() {
    level thread function_fd0b8976(%DOA_FATE_FRIENDSHIP, 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
    self thread namespace_5e6c5d1f::function_d35a405a(level.doa.var_a7cfb7eb, 1);
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x0
// Checksum 0x42eb9fbf, Offset: 0x2258
// Size: 0x72
function function_c8508847() {
    level thread function_fd0b8976(%DOA_FATE_FORCE, 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
    if (self.doa.var_c5e98ad6 < 4) {
        self.doa.var_c5e98ad6 = 4;
    }
    self thread namespace_eaa992c::function_285a2999("fate2_awarded");
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x0
// Checksum 0xfda03949, Offset: 0x22d8
// Size: 0x82
function function_47b8a2a2() {
    level thread function_fd0b8976(%DOA_FATE_FORTITUDE, 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
    if (self.doa.multiplier < 3) {
        self.doa.multiplier = 3;
    }
    self thread namespace_6df66aa5::magnet_update();
    self thread namespace_eaa992c::function_285a2999("fate2_awarded");
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x0
// Checksum 0x2cb7281d, Offset: 0x2368
// Size: 0x72
function function_78c32d42() {
    level thread function_fd0b8976(%DOA_FATE_FAVOR, 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
    self thread namespace_5e6c5d1f::function_d35a405a(level.doa.var_9505395a, 2, 1.5);
    self thread namespace_eaa992c::function_285a2999("fate2_awarded");
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x0
// Checksum 0x65770322, Offset: 0x23e8
// Size: 0xe2
function function_8c9288de() {
    level thread function_fd0b8976(%DOA_FATE_FURY, 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
    if (self.doa.bombs < 1) {
        self.doa.bombs = 1;
    }
    self.doa.var_ca0a87c8 = level.doa.var_69899304;
    self takeallweapons();
    self giveweapon(self.doa.var_ca0a87c8);
    self switchtoweaponimmediate(self.doa.var_ca0a87c8);
    self thread namespace_eaa992c::function_285a2999("fate2_awarded");
}

// Namespace namespace_23f188a4
// Params 1, eflags: 0x4
// Checksum 0x9e7ddafd, Offset: 0x24d8
// Size: 0x116
function private function_78f27983(player) {
    level thread function_fd0b8976(%DOA_FATE_BOOBY_PRIZE, 4, namespace_831a4a7c::function_fea7ed75(self.entnum));
    if (isdefined(player.doa.boss_damage)) {
        player thread namespace_a7e6beb5::function_ab651d00(player, "zombietron_extra_life");
        var_a72e62b4 = int(player.doa.boss_damage / 75000);
        if (var_a72e62b4 < 3) {
            var_a72e62b4 = 3;
        }
        if (var_a72e62b4 > 12) {
            var_a72e62b4 = 12;
        }
        items = namespace_a7e6beb5::function_16237a19(player.origin + (0, 0, 1000), 1, 75, 0, 0, var_a72e62b4);
        items[0] thread namespace_a7e6beb5::function_53347911(player);
        player.doa.boss_damage = 0;
    }
}

// Namespace namespace_23f188a4
// Params 2, eflags: 0x0
// Checksum 0xf0a450ef, Offset: 0x25f8
// Size: 0x245
function function_194ede2e(type, rock) {
    if (isdefined(rock)) {
        rock thread namespace_eaa992c::function_285a2999("fate_trigger");
        rock thread namespace_1a381543::function_90118d8c("zmb_fate_choose");
    }
    self.doa.fate = type;
    switch (type) {
    case 1:
        level thread directedFate(self, getweaponworldmodel(getweapon("zombietron_deathmachine")), 2.1, &function_b6841741);
        break;
    case 2:
        level thread directedFate(self, "zombietron_ruby", 4, &function_d30f9791);
        break;
    case 4:
        level thread directedFate(self, level.doa.var_f7277ad6, 4, &function_2a2ab6f9);
        break;
    case 3:
        level thread directedFate(self, level.doa.var_a7cfb7eb, 4, &function_4c552db8);
        break;
    case 10:
        level thread directedFate(self, "zombietron_statue_fury", 1, &function_8c9288de);
        break;
    case 11:
        level thread directedFate(self, "zombietron_statue_fortitude", 1, &function_47b8a2a2);
        break;
    case 12:
        level thread directedFate(self, "zombietron_statue_favor", 1, &function_78c32d42);
        break;
    case 13:
        level thread directedFate(self, "zombietron_statue_force", 1, &function_c8508847);
        break;
    default:
        assert(0);
        break;
    }
}

// Namespace namespace_23f188a4
// Params 4, eflags: 0x0
// Checksum 0x6d2ef513, Offset: 0x2848
// Size: 0x20a
function directedFate(player, model, modelscale, var_cb7e0a61) {
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
    object thread namespace_49107f3a::function_75e76155(player, "disconnect");
    while (isplayer(player)) {
        if (object.origin[2] < player.origin[2]) {
            object.origin = player.origin;
            break;
        }
        var_d305e57f = (player.origin[0], player.origin[1], object.origin[2] - 32);
        object.origin = var_d305e57f;
        wait 0.05;
    }
    if (isplayer(player)) {
        object thread namespace_eaa992c::function_285a2999("fate_explode");
        player playrumbleonentity("artillery_rumble");
        player playsoundtoplayer("zmb_doa_receive_fate", player);
        player [[ var_cb7e0a61 ]]();
    }
    object delete();
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x4
// Checksum 0xc034174, Offset: 0x2a60
// Size: 0x7a
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
// Params 0, eflags: 0x0
// Checksum 0x956d6854, Offset: 0x2ae8
// Size: 0x672
function doRoomOfJudgement() {
    level notify(#"hash_e2918623");
    level endon(#"player_challenge_failure");
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
    level.doa.var_b1698a42.var_1bcf76cc = 1;
    flag::set("doa_round_active");
    level thread function_b6a1fab3();
    for (i = 0; i < level.doa.var_b1698a42.var_9c35e18e.size; i++) {
        type = level.doa.var_b1698a42.var_9c35e18e[i];
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
    namespace_49107f3a::function_390adefe(0);
    level thread namespace_49107f3a::function_c5f3ece8(%DOA_TRIAL_OF_JUDGEMENT, undefined, 6);
    wait 1;
    level thread namespace_49107f3a::function_37fb5c23(%DOA_RIGHTEOUS_ROOM_BATTLE);
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] freezecontrols(0);
    }
    wait 3;
    level clientfield::set("activateBanner", 1);
    wait 4;
    level thread namespace_3ca3c537::function_a50a72db();
    level notify(#"hash_3b6e1e2");
    level waittill(#"boss_of_justice_died");
    level clientfield::set("activateBanner", 0);
    flag::clear("doa_round_active");
    level thread namespace_49107f3a::function_1ced251e();
    level waittill(#"hash_852a9fcd");
    namespace_49107f3a::function_44eb090b();
    level thread namespace_a7e6beb5::function_c1869ec8();
    level thread namespace_49107f3a::clearallcorpses();
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
    namespace_49107f3a::function_390adefe();
    level thread namespace_49107f3a::function_c5f3ece8(%DOA_RIGHTEOUS_ROOM, undefined, 6);
    level thread namespace_49107f3a::function_37fb5c23(%DOA_RIGHTEOUS_ROOM_CHOOSE);
    level notify(#"hash_4213cffb");
    level thread function_6162a853(1);
    level waittill(#"hash_7b036079");
    level thread namespace_49107f3a::function_c5f3ece8(%DOA_RIGHTEOUS_ROOM_DONE);
    wait 5;
    level notify(#"graveofJusticeDone");
    namespace_49107f3a::function_44eb090b();
}

// Namespace namespace_23f188a4
// Params 2, eflags: 0x0
// Checksum 0x6118f999, Offset: 0x3168
// Size: 0x162
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
// Params 1, eflags: 0x4
// Checksum 0x96d08283, Offset: 0x32d8
// Size: 0x115
function private function_5aaa5a64(shield) {
    self endon(#"death");
    level endon(#"boss_of_justice_died");
    while (true) {
        self waittill(#"trigger", guy);
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
// Params 0, eflags: 0x4
// Checksum 0x9e601254, Offset: 0x33f8
// Size: 0xca
function private function_d654dcd9() {
    self endon(#"death");
    level util::waittill_any("boss_of_justice_died", "player_challenge_failure");
    if (isdefined(self)) {
        if (isdefined(self.shield)) {
            if (isdefined(self.shield.trigger)) {
                self.shield.trigger delete();
            }
            self.shield thread namespace_eaa992c::function_285a2999("stoneboss_shield_explode");
            util::wait_network_frame();
            if (isdefined(self.shield)) {
                self.shield delete();
            }
        }
        self delete();
    }
}

// Namespace namespace_23f188a4
// Params 1, eflags: 0x4
// Checksum 0x73298803, Offset: 0x34d0
// Size: 0x51
function private function_60a14daa(boss) {
    self.boss = boss;
    self endon(#"death");
    while (true) {
        self rotateto(self.angles + (0, 180, 0), 2);
        wait 2;
    }
}

// Namespace namespace_23f188a4
// Params 1, eflags: 0x4
// Checksum 0xec4f0e02, Offset: 0x3530
// Size: 0x35a
function private function_b1d23a45(boss) {
    level endon(#"player_challenge_failure");
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
        self waittill(#"damage", damage);
        if (isdefined(self.var_e34a8df9)) {
            self thread namespace_eaa992c::function_285a2999("stoneboss_shield_explode");
            loc = spawnstruct();
            loc.origin = self.origin;
            loc.angles = self.angles;
            ai = namespace_51bd792::function_fb051310(self.var_e34a8df9, loc, undefined, 0);
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
        self.health = self.health - damage;
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
    boss notify(#"hash_d57cf5a3", self.org);
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_23f188a4
// Params 1, eflags: 0x4
// Checksum 0x79bcebf3, Offset: 0x3898
// Size: 0x23f
function private _shieldRegenerate(org) {
    level endon(#"player_challenge_failure");
    level endon(#"boss_of_justice_died");
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
    wait 12 - getplayers().size * 2;
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
// Params 0, eflags: 0x4
// Checksum 0x76313a8d, Offset: 0x3ae0
// Size: 0x22d
function private _bossShield() {
    level endon(#"player_challenge_failure");
    level endon(#"boss_of_justice_died");
    var_3fb52dd3 = 20;
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
        if (i != 0) {
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
        wait 0.2;
    }
    while (true) {
        self waittill(#"hash_d57cf5a3", org);
        self thread _shieldRegenerate(org);
    }
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x4
// Checksum 0xf59eeadb, Offset: 0x3d18
// Size: 0xcf
function private function_cb98790d() {
    level endon(#"player_challenge_failure");
    level endon(#"boss_of_justice_died");
    while (true) {
        level waittill(#"hash_8817f58");
        foreach (ball in self.var_a49abda5) {
            if (isdefined(ball)) {
                ball thread namespace_eaa992c::function_285a2999("stoneboss_shield_explode");
                util::wait_network_frame();
                if (isdefined(ball)) {
                    ball dodamage(ball.maxhealth, ball.origin);
                }
                wait 0.05;
            }
        }
    }
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x4
// Checksum 0x21020b6, Offset: 0x3df0
// Size: 0x487
function private function_c492e72d() {
    level endon(#"player_challenge_failure");
    self.takedamage = 1;
    self.health = 1000000 + getplayers().size * 250000;
    self.maxhealth = self.health;
    self.boss = 1;
    self.var_a49abda5 = [];
    self thread _bossShield();
    self thread function_cb98790d();
    self thread function_ae21464b();
    self thread function_5c819284();
    stage1 = int(self.health * 0.85);
    var_4c0a8371 = int(self.health * 0.7);
    var_26080908 = int(self.health * 0.55);
    var_301961e7 = int(self.health * 0.4);
    var_a16e77e = int(self.health * 0.2);
    /#
        if (isdefined(level.doa.var_33749c8)) {
            self thread DOA_BOSS::function_76b30cc1();
        }
    #/
    while (self.health > 0) {
        lasthealth = self.health;
        self waittill(#"damage", damage, attacker);
        data = namespace_49107f3a::clamp(self.health / self.maxhealth, 0, 1);
        level clientfield::set("pumpBannerBar", data);
        if (isdefined(attacker) && isplayer(attacker)) {
            if (!isdefined(attacker.doa.boss_damage)) {
                attacker.doa.boss_damage = 0;
            }
            attacker.doa.boss_damage += damage;
            attacker namespace_64c6b720::function_80eb303(damage, 1);
        }
        self.health = self.health - damage;
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
        namespace_49107f3a::debugmsg("BossHealth: " + self.health);
    }
    self thread namespace_eaa992c::function_285a2999("stoneboss_death");
    self thread namespace_1a381543::function_90118d8c("zmb_stoneboss_died");
    self notify(#"defeated");
    level notify(#"defeated", self);
    level notify(#"boss_of_justice_died");
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x4
// Checksum 0x369ce920, Offset: 0x4280
// Size: 0xbd
function private function_ae21464b() {
    level endon(#"player_challenge_failure");
    level endon(#"boss_of_justice_died");
    while (true) {
        wait randomintrange(10, 20) - getplayers().size * 1.2;
        self thread namespace_1a381543::function_90118d8c("zmb_boss_sound_minion_summon");
        level notify(#"hash_55acdab7");
        /#
            if (getdvarint("<dev string:x28>", 0)) {
                self dodamage(int(self.maxhealth * 0.1), self.origin);
            }
        #/
    }
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x4
// Checksum 0x1dcf93c9, Offset: 0x4348
// Size: 0x129
function private function_5c819284() {
    level endon(#"player_challenge_failure");
    level endon(#"boss_of_justice_died");
    spawn_set = level.doa.arenas[level.doa.var_90873830].name + "_enemy_spawn";
    level.doa.var_c984ad24 = level.doa.spawners[spawn_set];
    level.doa.var_19563cb8 = 0;
    for (wave = 0; wave < level.doa.var_d9933f22.size; wave++) {
        level waittill(#"hash_55acdab7");
        if (level flag::get("doa_game_is_over")) {
            return;
        }
        if (!level flag::get("doa_round_active")) {
            return;
        }
        level.doa.current_wave = level.doa.var_d9933f22[wave];
        level thread namespace_cdb9a8fe::function_21a582ff(level.doa.current_wave, "boss_of_justice_died");
    }
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x4
// Checksum 0x767322d6, Offset: 0x4480
// Size: 0x702
function private function_b6a1fab3() {
    level endon(#"player_challenge_failure");
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
    fury = spawn("script_model", loc.origin);
    fury.targetname = "fury";
    fury setmodel("zombietron_statue_fury");
    fury.angles = loc.angles + (0, 90, 0);
    fury thread namespace_49107f3a::function_783519c1("player_challenge_failure", 1);
    loc = level.doa.var_b1698a42.locations[1];
    force = spawn("script_model", loc.origin);
    force.targetname = "force";
    force setmodel("zombietron_statue_force");
    force.angles = loc.angles + (0, 90, 0);
    force thread namespace_49107f3a::function_783519c1("player_challenge_failure", 1);
    loc = level.doa.var_b1698a42.locations[2];
    fortitude = spawn("script_model", loc.origin);
    fortitude.targetname = "fortitude";
    fortitude setmodel("zombietron_statue_fortitude");
    fortitude.angles = loc.angles + (0, 90, 0);
    fortitude thread namespace_49107f3a::function_783519c1("player_challenge_failure", 1);
    loc = level.doa.var_b1698a42.locations[3];
    favor = spawn("script_model", loc.origin);
    favor.targetname = "favor";
    favor setmodel("zombietron_statue_favor");
    favor.angles = loc.angles + (0, 90, 0);
    favor thread namespace_49107f3a::function_783519c1("player_challenge_failure", 1);
    level waittill(#"boss_of_justice_died");
    level.doa.boss = undefined;
    badplace_delete("bossJustice");
    playfx(level._effect["def_explode"], boss.origin + (randomint(120), randomint(120), randomint(120)));
    wait 1;
    level thread namespace_49107f3a::function_c5f3ece8(%DOA_RIGHTEOUS_ROOM_BATTLE_WON);
    for (i = 0; i < 6; i++) {
        playfx(level._effect["def_explode"], boss.origin + (randomint(120), randomint(120), randomint(120)));
        wait randomfloatrange(0.25, 1.2);
    }
    boss thread namespace_49107f3a::function_a98c85b2(boss.origin + (0, 0, 2000), 1.75);
    boss thread namespace_eaa992c::function_285a2999("fate_impact");
    boss thread namespace_eaa992c::function_285a2999("stoneboss_death");
    wait 4;
    fury thread namespace_49107f3a::function_a98c85b2(fury.origin + (0, 0, 2000), 1.75);
    fury thread namespace_eaa992c::function_285a2999("fate_impact");
    fury thread namespace_eaa992c::function_285a2999("fate_launch");
    wait 1;
    force thread namespace_49107f3a::function_a98c85b2(force.origin + (0, 0, 2000), 1.75);
    force thread namespace_eaa992c::function_285a2999("fate_impact");
    force thread namespace_eaa992c::function_285a2999("fate_launch");
    wait 1;
    fortitude thread namespace_49107f3a::function_a98c85b2(fortitude.origin + (0, 0, 2000), 1.75);
    fortitude thread namespace_eaa992c::function_285a2999("fate_impact");
    fortitude thread namespace_eaa992c::function_285a2999("fate_launch");
    wait 1;
    favor thread namespace_49107f3a::function_a98c85b2(favor.origin + (0, 0, 2000), 1.75);
    favor thread namespace_eaa992c::function_285a2999("fate_impact");
    favor thread namespace_eaa992c::function_285a2999("fate_launch");
    wait 2;
    level notify(#"hash_852a9fcd");
    boss delete();
    fortitude delete();
    force delete();
    fury delete();
    favor delete();
}

// Namespace namespace_23f188a4
// Params 2, eflags: 0x0
// Checksum 0x7a9b065f, Offset: 0x4b90
// Size: 0x6a
function function_a1b1e361(player, note) {
    self notify(#"hash_a1b1e361");
    self endon(#"hash_a1b1e361");
    self endon(#"death");
    if (isdefined(note)) {
        player util::waittill_any(note, "disconnect");
    } else {
        player waittill(#"disconnect");
    }
    self delete();
}

// Namespace namespace_23f188a4
// Params 1, eflags: 0x0
// Checksum 0xf53d700c, Offset: 0x4c08
// Size: 0x143
function function_3caf8e2(endtime) {
    self endon(#"disconnect");
    lastposition = self.origin;
    stepsize = 20;
    self clientfield::set("fated_boost", 1);
    while (gettime() < endtime) {
        wait 0.2;
        normal = vectornormalize(self.origin - lastposition);
        step = normal * stepsize;
        dist = distance(self.origin, lastposition);
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
// Params 1, eflags: 0x4
// Checksum 0x645b3c6c, Offset: 0x4d58
// Size: 0x21d
function private function_69ae5d15(loc) {
    if (!mayspawnentity()) {
        return;
    }
    trigger = spawn("trigger_radius", loc, 9, 36, 64);
    trigger.targetname = "furyhotspot";
    trigger thread function_a1b1e361(self);
    physicsexplosionsphere(loc, 100, 100, 3);
    variance = randomfloatrange(0, 3);
    trigger thread namespace_49107f3a::function_1bd67aef(10 + variance);
    trigger endon(#"death");
    timeleft = gettime() + 10000;
    while (gettime() < timeleft) {
        trigger waittill(#"trigger", guy);
        if (isplayer(guy)) {
            continue;
        }
        if (!(isdefined(guy.takedamage) && guy.takedamage)) {
            continue;
        }
        if (isdefined(guy.boss) && guy.boss) {
            continue;
        }
        time = gettime();
        if (isdefined(guy.var_4c8b5b70) && guy.var_4c8b5b70 == time) {
            continue;
        }
        guy asmsetanimationrate(0.75);
        if (!(isdefined(guy.var_52b0b328) && guy.var_52b0b328)) {
            guy thread function_9fc6e261();
            guy clientfield::set("burnType", 3);
            guy clientfield::increment("burnZombie");
        }
        guy.var_4c8b5b70 = time;
        guy dodamage(int(guy.maxhealth * 0.015), guy.origin, self);
    }
}

// Namespace namespace_23f188a4
// Params 0, eflags: 0x4
// Checksum 0x7311706, Offset: 0x4f80
// Size: 0x8a
function private function_9fc6e261() {
    self waittill(#"actor_corpse", corpse);
    wait 0.05;
    if (isdefined(corpse)) {
        corpse clientfield::set("burnType", 3);
        wait 0.05;
        corpse clientfield::increment("burnCorpse");
        if (randomint(100) < 50) {
            corpse clientfield::set("enemy_ragdoll_explode", 1);
        }
    }
}

