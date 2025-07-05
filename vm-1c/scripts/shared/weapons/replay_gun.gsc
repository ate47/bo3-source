#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace replay_gun;

// Namespace replay_gun
// Params 0, eflags: 0x2
// Checksum 0xe680f5db, Offset: 0x1d0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("replay_gun", &__init__, undefined, undefined);
}

// Namespace replay_gun
// Params 0, eflags: 0x0
// Checksum 0x8ae866dd, Offset: 0x210
// Size: 0x24
function __init__() {
    callback::on_spawned(&function_c0abd95b);
}

// Namespace replay_gun
// Params 0, eflags: 0x0
// Checksum 0xdd7341a9, Offset: 0x240
// Size: 0xb0
function function_c0abd95b() {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"spawned_player");
    self endon(#"hash_23671b0c");
    while (true) {
        self waittill(#"weapon_change_complete", weapon);
        self weaponlockfree();
        if (isdefined(weapon.var_c426fec0) && weapon.var_c426fec0) {
            self thread watch_lockon(weapon);
        }
    }
}

// Namespace replay_gun
// Params 1, eflags: 0x0
// Checksum 0x7b092f85, Offset: 0x2f8
// Size: 0xec
function watch_lockon(weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"spawned_player");
    self endon(#"weapon_change_complete");
    while (true) {
        wait 0.05;
        if (!isdefined(self.lockonentity)) {
            ads = self playerads() == 1;
            if (ads) {
                target = self function_43c5e4e9(weapon);
                if (is_valid_target(target)) {
                    self weaponlockfree();
                    self.lockonentity = target;
                }
            }
        }
    }
}

// Namespace replay_gun
// Params 1, eflags: 0x0
// Checksum 0x411a8683, Offset: 0x3f0
// Size: 0x2ea
function function_43c5e4e9(weapon) {
    origin = self getweaponmuzzlepoint();
    forward = self getweaponforwarddir();
    targets = self function_42a6831f();
    if (!isdefined(targets)) {
        return undefined;
    }
    if (!isdefined(weapon.lockonscreenradius) || weapon.lockonscreenradius < 1) {
        return undefined;
    }
    validtargets = [];
    should_wait = 0;
    for (i = 0; i < targets.size; i++) {
        if (should_wait) {
            wait 0.05;
            origin = self getweaponmuzzlepoint();
            forward = self getweaponforwarddir();
            should_wait = 0;
        }
        testtarget = targets[i];
        if (!is_valid_target(testtarget)) {
            continue;
        }
        testorigin = function_9a6421f8(testtarget);
        var_58ef943 = distance(origin, testorigin);
        if (var_58ef943 > weapon.lockonmaxrange || var_58ef943 < weapon.lockonminrange) {
            continue;
        }
        normal = vectornormalize(testorigin - origin);
        dot = vectordot(forward, normal);
        if (0 > dot) {
            continue;
        }
        if (!self function_891f41a2(testorigin, weapon)) {
            continue;
        }
        cansee = self function_e96cb1d5(testtarget, testorigin, origin, forward, var_58ef943);
        should_wait = 1;
        if (cansee) {
            validtargets[validtargets.size] = testtarget;
        }
    }
    return function_c0064c09(validtargets);
}

// Namespace replay_gun
// Params 0, eflags: 0x0
// Checksum 0xef543ee7, Offset: 0x6e8
// Size: 0xfe
function function_42a6831f() {
    var_ce588222 = "axis";
    if (self.team == "axis") {
        var_ce588222 = "allies";
    }
    potentialtargets = [];
    var_4174f437 = getaiteamarray(var_ce588222);
    if (var_4174f437.size > 0) {
        potentialtargets = arraycombine(potentialtargets, var_4174f437, 1, 0);
    }
    playertargets = self getenemies();
    if (playertargets.size > 0) {
        potentialtargets = arraycombine(potentialtargets, playertargets, 1, 0);
    }
    if (potentialtargets.size == 0) {
        return undefined;
    }
    return potentialtargets;
}

// Namespace replay_gun
// Params 1, eflags: 0x0
// Checksum 0x3e45cf2b, Offset: 0x7f0
// Size: 0x120
function function_c0064c09(targets) {
    if (!isdefined(targets)) {
        return undefined;
    }
    besttarget = undefined;
    var_3cc7953c = undefined;
    for (i = 0; i < targets.size; i++) {
        target = targets[i];
        if (is_valid_target(target)) {
            var_a9b83e1e = distancesquared(self.origin, target.origin);
            if (!isdefined(besttarget) || !isdefined(var_3cc7953c)) {
                besttarget = target;
                var_3cc7953c = var_a9b83e1e;
                continue;
            }
            if (var_a9b83e1e < var_3cc7953c) {
                besttarget = target;
                var_3cc7953c = var_a9b83e1e;
            }
        }
    }
    return besttarget;
}

// Namespace replay_gun
// Params 2, eflags: 0x0
// Checksum 0xde141c1c, Offset: 0x918
// Size: 0x3c
function trace(from, to) {
    return bullettrace(from, to, 0, self)["position"];
}

// Namespace replay_gun
// Params 5, eflags: 0x0
// Checksum 0x99ebe69d, Offset: 0x960
// Size: 0xec
function function_e96cb1d5(target, target_origin, player_origin, player_forward, distance) {
    crosshair = player_origin + player_forward * distance;
    var_ab69552f = target trace(target_origin, crosshair);
    if (distance2dsquared(crosshair, var_ab69552f) > 9) {
        return false;
    }
    var_ab69552f = self trace(player_origin, crosshair);
    if (distance2dsquared(crosshair, var_ab69552f) > 9) {
        return false;
    }
    return true;
}

// Namespace replay_gun
// Params 1, eflags: 0x0
// Checksum 0xe3d519d4, Offset: 0xa58
// Size: 0x2a
function is_valid_target(ent) {
    return isdefined(ent) && isalive(ent);
}

// Namespace replay_gun
// Params 2, eflags: 0x0
// Checksum 0x2857b355, Offset: 0xa90
// Size: 0x4a
function function_891f41a2(testorigin, weapon) {
    radius = weapon.lockonscreenradius;
    return self function_9814bbcd(testorigin, radius);
}

// Namespace replay_gun
// Params 1, eflags: 0x0
// Checksum 0xc419f5be, Offset: 0xae8
// Size: 0x4a
function function_2718edba(targetorigin) {
    radius = self getlockonradius();
    return self function_9814bbcd(targetorigin, radius);
}

// Namespace replay_gun
// Params 2, eflags: 0x0
// Checksum 0x3321cba0, Offset: 0xb40
// Size: 0x3a
function function_9814bbcd(targetorigin, radius) {
    return target_originisincircle(targetorigin, self, 65, radius);
}

// Namespace replay_gun
// Params 1, eflags: 0x0
// Checksum 0xda063c6e, Offset: 0xb88
// Size: 0x22
function function_9a6421f8(target) {
    return self getreplaygunlockonorigin(target);
}

