#using scripts/codescripts/struct;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/ai/blackboard_vehicle;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;

#using_animtree("generic");

#namespace namespace_2848f8c2;

// Namespace namespace_2848f8c2
// Params 0, eflags: 0x0
// Checksum 0x246e4558, Offset: 0x368
// Size: 0xf2
function init() {
    level.doa.var_b3040642 = getent("doa_heli", "targetname");
    level.doa.var_37219336 = getent("doa_siegebot", "targetname");
    level.doa.var_1179f89e = getent("doa_tank", "targetname");
    level.doa.var_95dee038 = getent("doa_rapps", "targetname");
    level.doa.var_82433985 = getent("doa_quadtank", "targetname");
}

// Namespace namespace_2848f8c2
// Params 2, eflags: 0x0
// Checksum 0xf8bd42d3, Offset: 0x468
// Size: 0x48
function function_254eefd6(player, time) {
    self endon(#"death");
    player endon(#"disconnect");
    player endon(#"hash_d28ba89d");
    level namespace_49107f3a::function_124b9a08();
    wait time;
    player notify(#"hash_d28ba89d");
}

// Namespace namespace_2848f8c2
// Params 2, eflags: 0x0
// Checksum 0xf28988ff, Offset: 0x4b8
// Size: 0x2b2
function function_f27a22c8(player, origin) {
    if (isdefined(player.doa.var_52cb4fb9) && (isdefined(player.doa.vehicle) || player.doa.var_52cb4fb9)) {
        return;
    }
    player.doa.var_52cb4fb9 = 1;
    player function_d460de4b();
    level.doa.var_b3040642.count = 999999;
    heli = level.doa.var_b3040642 spawner::spawn(1);
    player.doa.var_52cb4fb9 = undefined;
    player.doa.vehicle = heli;
    heli.origin = origin + (0, 0, 70);
    heli.angles = player.angles;
    heli.vehaircraftcollisionenabled = 1;
    heli.health = 9999999;
    heli.team = player.team;
    heli setmodel("veh_t7_drone_hunter_zombietron_" + doa_player_utility::function_ee495f41(player.entnum));
    heli usevehicle(player, 0);
    heli makeunusable();
    heli setheliheightlock(1);
    heli.owner = player;
    heli.playercontrolled = 1;
    heli.var_aaffbea7 = 1;
    player doa_player_utility::function_4519b17(1);
    heli thread function_254eefd6(player, int(player namespace_49107f3a::function_1ded48e6(level.doa.rules.var_cd899ae7)));
    player waittill(#"hash_d28ba89d");
    player notify(#"doa_playerVehiclePickup");
    if (isdefined(heli)) {
        heli makeusable();
        var_85f85940 = heli.origin;
        if (isdefined(player)) {
            heli usevehicle(player, 0);
        }
        heli delete();
    }
    if (isdefined(player)) {
        player thread function_3b1b644d(var_85f85940);
    }
}

// Namespace namespace_2848f8c2
// Params 0, eflags: 0x0
// Checksum 0x9afb692d, Offset: 0x778
// Size: 0x4d
function function_db948b3() {
    self endon(#"death");
    while (true) {
        pos = self function_d24a7ea9(0);
        self function_6521eb5d(pos, 1);
        wait 0.05;
    }
}

// Namespace namespace_2848f8c2
// Params 0, eflags: 0x0
// Checksum 0x1270ea94, Offset: 0x7d0
// Size: 0x6d
function function_569d8fe3() {
    self endon(#"death");
    var_d22e1ab8 = self seatgetweapon(2);
    while (true) {
        if (self isgunnerfiring(0)) {
            self fireweapon(2);
            wait var_d22e1ab8.firetime;
            continue;
        }
        wait 0.05;
    }
}

// Namespace namespace_2848f8c2
// Params 2, eflags: 0x0
// Checksum 0x487f6584, Offset: 0x848
// Size: 0x29a
function function_21af9396(player, origin) {
    if (isdefined(player.doa.var_52cb4fb9) && (isdefined(player.doa.vehicle) || player.doa.var_52cb4fb9)) {
        return;
    }
    player.doa.var_52cb4fb9 = 1;
    player function_d460de4b();
    level.doa.var_37219336.count = 99999;
    siegebot = level.doa.var_37219336 spawner::spawn(1);
    player.doa.var_52cb4fb9 = undefined;
    player.doa.vehicle = siegebot;
    siegebot.origin = origin;
    siegebot.angles = player.angles;
    siegebot.team = player.team;
    siegebot.owner = player;
    siegebot.playercontrolled = 1;
    siegebot setmodel("zombietron_siegebot_mini_" + doa_player_utility::function_ee495f41(player.entnum));
    siegebot usevehicle(player, 0);
    siegebot makeunusable();
    siegebot.health = 9999999;
    player doa_player_utility::function_4519b17(1);
    siegebot thread function_db948b3();
    siegebot thread function_569d8fe3();
    player notify(#"doa_playerVehiclePickup");
    siegebot thread function_254eefd6(player, int(player namespace_49107f3a::function_1ded48e6(level.doa.rules.var_91e6add5)));
    player waittill(#"hash_d28ba89d");
    if (isdefined(siegebot)) {
        var_85f85940 = siegebot.origin;
        siegebot makeusable();
        if (isdefined(player)) {
            siegebot usevehicle(player, 0);
        }
        siegebot delete();
    }
    if (isdefined(player)) {
        player thread function_3b1b644d(var_85f85940);
    }
}

// Namespace namespace_2848f8c2
// Params 2, eflags: 0x0
// Checksum 0x2fd2d18b, Offset: 0xaf0
// Size: 0x262
function function_1e663abe(player, origin) {
    if (isdefined(player.doa.var_52cb4fb9) && (isdefined(player.doa.vehicle) || player.doa.var_52cb4fb9)) {
        return;
    }
    player.doa.var_52cb4fb9 = 1;
    player function_d460de4b();
    var_e34a8df9 = level.doa.var_95dee038 spawner::spawn(1);
    player.doa.var_52cb4fb9 = undefined;
    player.doa.vehicle = var_e34a8df9;
    var_e34a8df9.origin = origin;
    var_e34a8df9.angles = player.angles;
    var_e34a8df9.team = player.team;
    var_e34a8df9.playercontrolled = 1;
    var_e34a8df9 setmodel("veh_t7_drone_raps_zombietron_" + doa_player_utility::function_ee495f41(player.entnum));
    var_e34a8df9.owner = player;
    var_e34a8df9 usevehicle(player, 0);
    var_e34a8df9 makeunusable();
    var_e34a8df9.health = 9999999;
    player doa_player_utility::function_4519b17(1);
    player notify(#"doa_playerVehiclePickup");
    var_e34a8df9 thread function_254eefd6(player, int(player namespace_49107f3a::function_1ded48e6(level.doa.rules.var_7196fe3d)));
    player waittill(#"hash_d28ba89d");
    if (isdefined(var_e34a8df9)) {
        var_85f85940 = var_e34a8df9.origin;
        if (isdefined(player)) {
            origin = var_e34a8df9.origin;
            var_e34a8df9 makeusable();
            var_e34a8df9 usevehicle(player, 0);
        }
        var_e34a8df9 delete();
    }
    if (isdefined(player)) {
        player thread function_3b1b644d(var_85f85940);
    }
}

// Namespace namespace_2848f8c2
// Params 2, eflags: 0x0
// Checksum 0x27c9cfe, Offset: 0xd60
// Size: 0x26a
function function_e9f445ce(player, origin) {
    if (isdefined(player.doa.var_52cb4fb9) && (isdefined(player.doa.vehicle) || player.doa.var_52cb4fb9)) {
        return;
    }
    player.doa.var_52cb4fb9 = 1;
    player function_d460de4b();
    var_b22d6040 = level.doa.var_1179f89e spawner::spawn(1);
    player.doa.var_52cb4fb9 = undefined;
    player.doa.vehicle = var_b22d6040;
    var_b22d6040.origin = origin;
    var_b22d6040.angles = player.angles;
    var_b22d6040.team = player.team;
    var_b22d6040.playercontrolled = 1;
    var_b22d6040 setmodel("veh_t7_mil_tank_tiger_zombietron_" + doa_player_utility::function_ee495f41(player.entnum));
    var_b22d6040 usevehicle(player, 0);
    var_b22d6040 makeunusable();
    var_b22d6040.health = 9999999;
    player doa_player_utility::function_4519b17(1);
    player notify(#"doa_playerVehiclePickup");
    var_b22d6040.owner = player;
    var_b22d6040 thread function_254eefd6(player, int(player namespace_49107f3a::function_1ded48e6(level.doa.rules.var_8b15034d)));
    player waittill(#"hash_d28ba89d");
    if (isdefined(var_b22d6040)) {
        var_85f85940 = var_b22d6040.origin;
        if (isdefined(player)) {
            origin = var_b22d6040.origin;
            var_b22d6040 makeusable();
            var_b22d6040 usevehicle(player, 0);
        }
        var_b22d6040 delete();
    }
    if (isdefined(player)) {
        player thread function_3b1b644d(var_85f85940);
    }
}

// Namespace namespace_2848f8c2
// Params 0, eflags: 0x0
// Checksum 0xba2426f4, Offset: 0xfd8
// Size: 0x8b
function function_d460de4b() {
    if (!isdefined(self) || !isdefined(self.doa)) {
        return;
    }
    self thread doa_player_utility::function_7f33210a();
    self thread doa_player_utility::turnOnFlashlight(0);
    self thread namespace_eaa992c::turnofffx("boots");
    self thread namespace_eaa992c::turnofffx("slow_feet");
    self.doa.var_c2b9d7d0 = gettime();
    self notify(#"kill_shield");
    self notify(#"kill_chickens");
}

// Namespace namespace_2848f8c2
// Params 0, eflags: 0x0
// Checksum 0x789a9bac, Offset: 0x1070
// Size: 0xfa
function function_d41a4517() {
    self endon(#"disconnect");
    util::wait_network_frame();
    self thread doa_player_utility::turnplayershieldon();
    self thread doa_player_utility::turnOnFlashlight(level.doa.var_458c27d == 3);
    self thread doa_player_utility::function_b5843d4f(level.doa.var_458c27d == 3);
    if (isdefined(self.doa.slow_feet) && isdefined(self.doa) && self.doa.slow_feet) {
        self thread namespace_eaa992c::function_285a2999("slow_feet");
    }
    if (isdefined(self.doa.fast_feet) && isdefined(self.doa) && self.doa.fast_feet) {
        self thread namespace_eaa992c::function_285a2999("boots");
    }
}

// Namespace namespace_2848f8c2
// Params 1, eflags: 0x0
// Checksum 0x7dbbc9f3, Offset: 0x1178
// Size: 0xd2
function function_3b1b644d(var_85f85940) {
    self endon(#"disconnect");
    wait 0.05;
    spot = self namespace_49107f3a::function_5bca1086();
    if (isdefined(spot)) {
        trace = bullettrace(spot + (0, 0, 48), spot + (0, 0, -64), 0, undefined);
        spot = trace["position"];
        self setorigin(spot);
    } else {
        self setorigin(var_85f85940);
    }
    self doa_player_utility::function_4519b17(0);
    self.doa.vehicle = undefined;
    self thread function_d41a4517();
}

