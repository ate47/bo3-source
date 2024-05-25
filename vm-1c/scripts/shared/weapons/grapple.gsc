#using scripts/shared/abilities/_ability_util;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace grapple;

// Namespace grapple
// Params 0, eflags: 0x2
// Checksum 0x5f7cf6d5, Offset: 0x248
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("grapple", &__init__, &__main__, undefined);
}

// Namespace grapple
// Params 0, eflags: 0x1 linked
// Checksum 0xd8107be, Offset: 0x290
// Size: 0x24
function __init__() {
    callback::on_spawned(&function_80c05bda);
}

// Namespace grapple
// Params 0, eflags: 0x1 linked
// Checksum 0x2fafd7a3, Offset: 0x2c0
// Size: 0xd2
function __main__() {
    var_9e41b359 = getentarray("grapple_target", "targetname");
    foreach (target in var_9e41b359) {
        target.var_f9127ea5 = 1;
        target setgrapplabletype(target.var_f9127ea5);
    }
}

// Namespace grapple
// Params 2, eflags: 0x1 linked
// Checksum 0x9cfddfe, Offset: 0x3a0
// Size: 0x8a
function function_c83c076b(var_893b36f7, var_c508a51e) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"spawned_player");
    while (isdefined(self)) {
        param1, param2, param3 = self waittill(var_893b36f7);
        self notify(var_c508a51e, var_893b36f7, param1, param2, param3);
    }
}

// Namespace grapple
// Params 0, eflags: 0x1 linked
// Checksum 0xb9edc697, Offset: 0x438
// Size: 0xfa
function function_80c05bda() {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"spawned_player");
    self endon(#"hash_23671b0c");
    self thread function_c83c076b("weapon_switch_started", "grapple_weapon_change");
    self thread function_c83c076b("weapon_change_complete", "grapple_weapon_change");
    while (true) {
        event, weapon = self waittill(#"hash_17cf4048");
        if (isdefined(weapon.grappleweapon) && weapon.grappleweapon) {
            self thread watch_lockon(weapon);
            continue;
        }
        self notify(#"hash_1e6c65f1");
    }
}

// Namespace grapple
// Params 1, eflags: 0x1 linked
// Checksum 0x6fb44ead, Offset: 0x540
// Size: 0x13c
function watch_lockon(weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"spawned_player");
    self endon(#"hash_1e6c65f1");
    self notify(#"watch_lockon");
    self endon(#"watch_lockon");
    self thread function_4f0d1ede(weapon);
    self thread function_525a420a(weapon);
    self.var_e3c5dfe4 = 1;
    while (true) {
        wait(0.05);
        if (!self isgrappling()) {
            target = self function_43c5e4e9(weapon);
            if (!self isgrappling() && !(target === self.lockonentity)) {
                self weaponlocknoclearance(!(target === self.dummy_target));
                self.lockonentity = target;
                wait(0.1);
            }
        }
    }
}

// Namespace grapple
// Params 1, eflags: 0x1 linked
// Checksum 0xc1854e2f, Offset: 0x688
// Size: 0xa4
function function_525a420a(weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"spawned_player");
    self endon(#"hash_1e6c65f1");
    self notify(#"hash_525a420a");
    self endon(#"hash_525a420a");
    while (true) {
        self util::waittill_any("grapple_pulled", "grapple_landed");
        if (isdefined(self.lockonentity)) {
            self.lockonentity = undefined;
            self.var_e3c5dfe4 = 1;
        }
    }
}

// Namespace grapple
// Params 1, eflags: 0x1 linked
// Checksum 0x614c00df, Offset: 0x738
// Size: 0x130
function function_4f0d1ede(weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"spawned_player");
    self endon(#"hash_1e6c65f1");
    self notify(#"hash_4f0d1ede");
    self endon(#"hash_4f0d1ede");
    while (true) {
        wait(0.05);
        if (!self isgrappling()) {
            if (isdefined(self.lockonentity)) {
                if (self.lockonentity === self.dummy_target) {
                    self weaponlocktargettooclose(0);
                    continue;
                }
                testorigin = function_9a6421f8(self.lockonentity);
                if (!self function_2aaab717(testorigin, weapon, 0)) {
                    self weaponlocktargettooclose(1);
                    continue;
                }
                self weaponlocktargettooclose(0);
            }
        }
    }
}

// Namespace grapple
// Params 3, eflags: 0x1 linked
// Checksum 0xc3f53ac0, Offset: 0x870
// Size: 0x186
function function_b0a2c4bd(origin, forward, weapon) {
    if (!isdefined(self.dummy_target)) {
        self.dummy_target = spawn("script_origin", origin);
    }
    self.dummy_target setgrapplabletype(3);
    start = origin;
    distance = weapon.lockonmaxrange * 0.9;
    if (isdefined(level.var_f8094267)) {
        distance = level.var_f8094267;
    }
    end = origin + forward * distance;
    if (!self isgrappling()) {
        self.dummy_target.origin = self trace(start, end, self.dummy_target);
    }
    var_5cba5221 = weapon.lockonminrange * weapon.lockonminrange;
    if (distancesquared(self.dummy_target.origin, origin) < var_5cba5221) {
        return undefined;
    }
    return self.dummy_target;
}

// Namespace grapple
// Params 1, eflags: 0x1 linked
// Checksum 0xb795839b, Offset: 0xa00
// Size: 0x3cc
function function_43c5e4e9(weapon) {
    origin = self geteye();
    forward = self getweaponforwarddir();
    targets = getgrappletargetarray();
    if (!isdefined(targets)) {
        return undefined;
    }
    if (!isdefined(weapon.lockonscreenradius) || weapon.lockonscreenradius < 1) {
        return undefined;
    }
    validtargets = [];
    var_827c64dc = 0;
    var_e5e6ca10 = 2;
    if (isdefined(self.var_e3c5dfe4) && self.var_e3c5dfe4) {
        var_e5e6ca10 = 4;
        self.var_e3c5dfe4 = 0;
    }
    for (i = 0; i < targets.size; i++) {
        if (var_827c64dc >= var_e5e6ca10) {
            wait(0.05);
            origin = self getweaponmuzzlepoint();
            forward = self getweaponforwarddir();
            var_827c64dc = 0;
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
        if (!self function_2aaab717(testorigin, weapon, !(testtarget === self.lockonentity))) {
            continue;
        }
        cansee = self can_see(testtarget, testorigin, origin, forward, 30);
        var_827c64dc++;
        if (cansee) {
            validtargets[validtargets.size] = testtarget;
        }
    }
    best = function_c0064c09(validtargets, origin, forward, weapon.lockonminrange, weapon.lockonmaxrange);
    if (isdefined(level.var_46473359) && level.var_46473359) {
        if (!isdefined(best) || best === self.dummy_target) {
            best = function_b0a2c4bd(origin, forward, weapon);
        }
    }
    return best;
}

// Namespace grapple
// Params 1, eflags: 0x1 linked
// Checksum 0x8caa6854, Offset: 0xdd8
// Size: 0xaa
function function_3fb56153(target) {
    if (!isdefined(target)) {
        return 0;
    }
    if (target === self.dummy_target) {
        return 0;
    }
    if (target.var_f9127ea5 === 1) {
        return 1;
    }
    if (target.var_f9127ea5 === 2) {
        return 0.985;
    }
    if (!isdefined(target.var_f9127ea5)) {
        return 0.9;
    }
    if (target.var_f9127ea5 === 3) {
        return 0.75;
    }
    return 0;
}

// Namespace grapple
// Params 5, eflags: 0x1 linked
// Checksum 0xd1c3b9c, Offset: 0xe90
// Size: 0x19a
function function_461aeeba(target, origin, forward, var_f2af12bd, max_range) {
    if (!isdefined(target)) {
        return -1;
    }
    if (target === self.dummy_target) {
        return 0;
    }
    if (is_valid_target(target)) {
        testorigin = function_9a6421f8(target);
        normal = vectornormalize(testorigin - origin);
        dot = vectordot(forward, normal);
        targetdistance = distance(self.origin, testorigin);
        var_98e190df = 1 - (targetdistance - var_f2af12bd) / (max_range - var_f2af12bd);
        var_cb06427e = function_3fb56153(target);
        return (var_cb06427e * pow(dot, 0.85) * pow(var_98e190df, 0.15));
    }
    return -1;
}

// Namespace grapple
// Params 5, eflags: 0x1 linked
// Checksum 0x86dbdecb, Offset: 0x1038
// Size: 0x140
function function_c0064c09(targets, origin, forward, var_f2af12bd, max_range) {
    if (!isdefined(targets)) {
        return undefined;
    }
    besttarget = undefined;
    bestscore = undefined;
    for (i = 0; i < targets.size; i++) {
        target = targets[i];
        if (is_valid_target(target)) {
            score = function_461aeeba(target, origin, forward, var_f2af12bd, max_range);
            if (!isdefined(besttarget) || !isdefined(bestscore)) {
                besttarget = target;
                bestscore = score;
                continue;
            }
            if (score > bestscore) {
                besttarget = target;
                bestscore = score;
            }
        }
    }
    return besttarget;
}

// Namespace grapple
// Params 3, eflags: 0x1 linked
// Checksum 0x1aebf85a, Offset: 0x1180
// Size: 0x5c
function trace(from, to, target) {
    trace = bullettrace(from, to, 0, self, 1, 0, target);
    return trace["position"];
}

// Namespace grapple
// Params 5, eflags: 0x1 linked
// Checksum 0x2fe8a7c0, Offset: 0x11e8
// Size: 0x178
function can_see(target, target_origin, player_origin, player_forward, distance) {
    start = player_origin + player_forward * distance;
    end = target_origin - player_forward * distance;
    var_ab69552f = self trace(start, end, target);
    if (distance2dsquared(end, var_ab69552f) > 9) {
        /#
            if (getdvarint("script_origin")) {
                line(start, var_ab69552f, (0, 0, 1), 1, 0, 50);
                line(var_ab69552f, end, (1, 0, 0), 1, 0, 50);
            }
        #/
        return false;
    }
    /#
        if (getdvarint("script_origin")) {
            line(start, end, (0, 1, 0), 1, 0, 30);
        }
    #/
    return true;
}

// Namespace grapple
// Params 1, eflags: 0x1 linked
// Checksum 0x63620f01, Offset: 0x1368
// Size: 0x74
function is_valid_target(ent) {
    if (isdefined(ent) && isdefined(level.var_f543d7da)) {
        if (![[ level.var_f543d7da ]](ent)) {
            return false;
        }
    }
    return isalive(ent) || isdefined(ent) && !issentient(ent);
}

// Namespace grapple
// Params 3, eflags: 0x1 linked
// Checksum 0x15deab00, Offset: 0x13e8
// Size: 0xf8
function function_2aaab717(testorigin, weapon, newtarget) {
    var_9396cce9 = weapon.lockonlossanglehorizontal;
    if (newtarget) {
        var_9396cce9 = weapon.lockonanglehorizontal;
    }
    var_28e6581f = weapon.lockonlossanglevertical;
    if (newtarget) {
        var_28e6581f = weapon.lockonanglevertical;
    }
    angles = self gettargetscreenangles(testorigin);
    return abs(angles[0]) < var_9396cce9 && abs(angles[1]) < var_28e6581f;
}

// Namespace grapple
// Params 2, eflags: 0x0
// Checksum 0xef02a434, Offset: 0x14e8
// Size: 0x4a
function function_891f41a2(testorigin, weapon) {
    radius = weapon.lockonscreenradius;
    return self function_9814bbcd(testorigin, radius);
}

// Namespace grapple
// Params 1, eflags: 0x0
// Checksum 0x3f7329be, Offset: 0x1540
// Size: 0x4a
function function_2718edba(targetorigin) {
    radius = self getlockonradius();
    return self function_9814bbcd(targetorigin, radius);
}

// Namespace grapple
// Params 2, eflags: 0x1 linked
// Checksum 0x3759731a, Offset: 0x1598
// Size: 0x3a
function function_9814bbcd(targetorigin, radius) {
    return target_originisincircle(targetorigin, self, 65, radius);
}

// Namespace grapple
// Params 1, eflags: 0x1 linked
// Checksum 0x36ef5584, Offset: 0x15e0
// Size: 0x22
function function_9a6421f8(target) {
    return self getlockonorigin(target);
}

