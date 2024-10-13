#using scripts/cp/_challenges;
#using scripts/cp/cybercom/_cybercom_dev;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/_util;
#using scripts/shared/lui_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/gameskill_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/hud_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_d9c8cca1;

// Namespace namespace_d9c8cca1
// Params 0, eflags: 0x1 linked
// Checksum 0x7f7e2015, Offset: 0x5b0
// Size: 0x64
function init() {
    clientfield::register("toplayer", "misdirection_enable", 1, 1, "int");
    clientfield::register("scriptmover", "makedecoy", 1, 1, "int");
}

// Namespace namespace_d9c8cca1
// Params 0, eflags: 0x1 linked
// Checksum 0xb587b2a, Offset: 0x620
// Size: 0x184
function main() {
    namespace_d00ec32::function_36b56038(2, 32, 1);
    level.cybercom.misdirection = spawnstruct();
    level.cybercom.misdirection.var_875da84b = &function_875da84b;
    level.cybercom.misdirection.var_8d01efb6 = &function_8d01efb6;
    level.cybercom.misdirection.var_bdb47551 = &function_bdb47551;
    level.cybercom.misdirection.var_39ea6a1b = &function_39ea6a1b;
    level.cybercom.misdirection.var_5d2fec30 = &function_5d2fec30;
    level.cybercom.misdirection._on = &_on;
    level.cybercom.misdirection._off = &_off;
    level.cybercom.misdirection.var_4135a1c4 = &function_4135a1c4;
}

// Namespace namespace_d9c8cca1
// Params 1, eflags: 0x1 linked
// Checksum 0x6324ff93, Offset: 0x7b0
// Size: 0xc
function function_875da84b(slot) {
    
}

// Namespace namespace_d9c8cca1
// Params 2, eflags: 0x1 linked
// Checksum 0x93687036, Offset: 0x7c8
// Size: 0x14
function function_8d01efb6(slot, weapon) {
    
}

// Namespace namespace_d9c8cca1
// Params 2, eflags: 0x1 linked
// Checksum 0x3da85d42, Offset: 0x7e8
// Size: 0x194
function function_bdb47551(slot, weapon) {
    self.cybercom.var_6735c679 = getdvarfloat("scr_misdirection_lifetime", 4);
    self.cybercom.var_c0a69197 = getdvarint("scr_misdirection_target_count", 3);
    self.cybercom.var_e5260c29 = getdvarfloat("scr_misdirection_fov", 0.968);
    if (self function_1a9006bd("cybercom_misdirection") == 2) {
        self.cybercom.var_6735c679 = getdvarfloat("scr_misdirection_upgraded_lifetime", 5.5);
        self.cybercom.var_c0a69197 = getdvarint("scr_misdirection_target_count_upgraded", 5);
        self.cybercom.var_e5260c29 = getdvarfloat("scr_misdirection_upgraded_fov", 0.94);
    }
    clientfield::set_to_player("misdirection_enable", 1);
    self thread cybercom::function_b5f4e597(weapon);
}

// Namespace namespace_d9c8cca1
// Params 2, eflags: 0x1 linked
// Checksum 0x3ae22221, Offset: 0x988
// Size: 0x40
function function_39ea6a1b(slot, weapon) {
    clientfield::set_to_player("misdirection_enable", 0);
    self.cybercom.var_301030f7 = 0;
}

// Namespace namespace_d9c8cca1
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x9d0
// Size: 0x4
function function_5d2fec30() {
    
}

// Namespace namespace_d9c8cca1
// Params 2, eflags: 0x1 linked
// Checksum 0xd4e032bc, Offset: 0x9e0
// Size: 0x114
function _on(slot, weapon) {
    result = self function_12a86f2e(slot, weapon);
    if (!result) {
        self gadgetdeactivate(slot, weapon, 2);
    }
    cybercom::function_adc40f11(weapon, result);
    self.cybercom.var_301030f7 = 0;
    if (isplayer(self)) {
        itemindex = getitemindexfromref("cybercom_misdirection");
        if (isdefined(itemindex)) {
            self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
        }
    }
}

// Namespace namespace_d9c8cca1
// Params 2, eflags: 0x1 linked
// Checksum 0xb67e7e71, Offset: 0xb00
// Size: 0x28
function _off(slot, weapon) {
    self.cybercom.var_301030f7 = 0;
}

// Namespace namespace_d9c8cca1
// Params 2, eflags: 0x1 linked
// Checksum 0xa456af9a, Offset: 0xb30
// Size: 0x50
function function_4135a1c4(slot, weapon) {
    if (!(isdefined(self.cybercom.var_301030f7) && self.cybercom.var_301030f7)) {
        self.cybercom.var_301030f7 = 1;
    }
}

// Namespace namespace_d9c8cca1
// Params 1, eflags: 0x5 linked
// Checksum 0x3ef02424, Offset: 0xb88
// Size: 0x33e
function private function_8aac802c(weapon) {
    playerforward = anglestoforward(self getplayerangles());
    enemies = arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
    enemies = arraysort(enemies, self.origin, 1);
    valid = [];
    foreach (guy in enemies) {
        if (isvehicle(guy)) {
            continue;
        }
        if (!isactor(guy)) {
            continue;
        }
        if (!isdefined(guy.archetype) || guy.archetype == "direwolf" || guy.archetype == "zombie") {
            continue;
        }
        distsq = distancesquared(self.origin, guy.origin);
        if (distsq < getdvarint("scr_misdirection_min_distanceSQR", getdvarint("scr_misdirection_min_distance", -56) * getdvarint("scr_misdirection_min_distance", -56))) {
            continue;
        }
        if (distsq > getdvarint("scr_misdirection_max_distanceSQR", getdvarint("scr_misdirection_max_distance", 1750) * getdvarint("scr_misdirection_max_distance", 1750))) {
            continue;
        }
        dot = vectordot(playerforward, vectornormalize(guy.origin - self.origin));
        if (dot < self.cybercom.var_e5260c29) {
            continue;
        }
        valid[valid.size] = guy;
        self thread challenges::function_96ed590f("cybercom_uses_chaos");
    }
    return valid;
}

// Namespace namespace_d9c8cca1
// Params 2, eflags: 0x5 linked
// Checksum 0x9f743a02, Offset: 0xed0
// Size: 0x186
function private function_12a86f2e(slot, weapon) {
    targets = function_8aac802c(weapon);
    self.cybercom.var_1beb8e5f = [];
    for (i = 0; i < self.cybercom.var_c0a69197; i++) {
        decoy = self function_4adc7dc8(targets);
        if (isdefined(decoy)) {
            self.cybercom.var_1beb8e5f[self.cybercom.var_1beb8e5f.size] = decoy;
            util::wait_network_frame();
        }
    }
    foreach (decoy in self.cybercom.var_1beb8e5f) {
        decoy thread function_7ca046a9(self.cybercom.var_6735c679, self);
    }
    return true;
}

// Namespace namespace_d9c8cca1
// Params 1, eflags: 0x1 linked
// Checksum 0x81231ad7, Offset: 0x1060
// Size: 0x116
function function_7074260(point) {
    foreach (var_d3c532e6 in self.cybercom.var_1beb8e5f) {
        distsq = distance2dsquared(point, var_d3c532e6.origin);
        if (distsq < getdvarint("scr_misdirection_decoy_spacingSQR", getdvarint("scr_misdirection_decoy_spacing", 90) * getdvarint("scr_misdirection_decoy_spacing", 90))) {
            return false;
        }
    }
    return true;
}

// Namespace namespace_d9c8cca1
// Params 2, eflags: 0x1 linked
// Checksum 0x4a6a2932, Offset: 0x1180
// Size: 0x6b8
function function_10cd71b(decoy, &potentialtargets) {
    mins = (1e+06, 1e+06, 1e+06);
    maxs = (-1e+06, -1e+06, -1e+06);
    playerforward = anglestoforward(self getplayerangles());
    playerforward = (playerforward[0], playerforward[1], 0);
    playerright = anglestoright(self getplayerangles());
    playerright = (playerright[0], playerright[1], 0);
    foreach (target in potentialtargets) {
        origin = target.origin;
        mins = function_44a2ae85(origin, mins);
        maxs = function_b72ba417(origin, maxs);
    }
    rangemax = self.origin + playerforward * getdvarint("scr_misdirection_no_target_max_distance", 675);
    maxs = function_b72ba417(rangemax, maxs);
    rangemin = self.origin + playerforward * getdvarint("scr_misdirection_min_distance", -56);
    mins = function_44a2ae85(rangemin, mins);
    center = (maxs + mins) * 0.5;
    var_412aa3ee = distance(center, self.origin);
    var_eec44088 = vectornormalize(center - self.origin);
    var_b333c85b = self.origin + var_eec44088 * var_412aa3ee;
    var_6a0945f2 = var_b333c85b;
    maxtries = 6;
    var_539aaa1a = 0;
    step = playerright * getdvarint("scr_misdirection_decoy_spacing", 90);
    while (maxtries > 0) {
        left = var_6a0945f2 + (6 - maxtries) * step;
        v_ground = bullettrace(left + (0, 0, 72), left + (0, 0, -2048), 0, undefined, 1)["position"];
        left = (left[0], left[1], v_ground[2]);
        v_trace = bullettrace(self.origin + (0, 0, 24), left + (0, 0, 24), 1, self)["position"];
        dir = vectornormalize(v_trace - self.origin);
        v_trace += -48 * dir;
        v_ground = bullettrace(v_trace, v_trace + (0, 0, -2048), 0, undefined, 1)["position"];
        if (self function_7074260(v_ground)) {
            var_b333c85b = v_ground;
            break;
        }
        right = var_6a0945f2 - (6 - maxtries) * step;
        v_ground = bullettrace(right + (0, 0, 72), right + (0, 0, -2048), 0, undefined, 1)["position"];
        right = (right[0], right[1], v_ground[2]);
        v_trace = bullettrace(self.origin + (0, 0, 24), right + (0, 0, 24), 1, self)["position"];
        dir = vectornormalize(v_trace - self.origin);
        v_trace += -48 * dir;
        v_ground = bullettrace(v_trace, v_trace + (0, 0, -2048), 0, undefined, 1)["position"];
        if (self function_7074260(v_ground)) {
            var_b333c85b = v_ground;
            break;
        }
        maxtries--;
    }
    decoy.origin = var_b333c85b + (0, 0, 64);
}

// Namespace namespace_d9c8cca1
// Params 0, eflags: 0x1 linked
// Checksum 0x1e70faef, Offset: 0x1840
// Size: 0xd2
function function_a767f9b4() {
    aiarray = getaiarray();
    foreach (ai in aiarray) {
        if (ai === self) {
            continue;
        }
        if (ai.var_3a087745 === 1) {
            ai setpersonalignore(self);
        }
    }
}

// Namespace namespace_d9c8cca1
// Params 1, eflags: 0x1 linked
// Checksum 0xca2770ff, Offset: 0x1920
// Size: 0x388
function function_4adc7dc8(&potentialtargets) {
    decoy = spawn("script_model", self.origin);
    if (!isdefined(decoy)) {
        return undefined;
    }
    decoy.angles = self.angles;
    decoy setmodel("tag_origin");
    decoy makesentient();
    decoy.team = self.team;
    decoy.var_e42818a3 = 1;
    decoy ghost();
    decoy function_a767f9b4();
    foreach (target in potentialtargets) {
        v_trace = bullettrace(self.origin + (0, 0, 24), target.origin + (0, 0, 24), 1, self)["position"];
        dir = vectornormalize(v_trace - self.origin);
        v_trace += -48 * dir;
        v_ground = bullettrace(v_trace, v_trace + (0, 0, -2048), 0, target, 1)["position"];
        if (self function_7074260(v_ground) == 0) {
            continue;
        }
        decoy.origin = v_ground + (0, 0, 64);
        decoy.var_faa77c1d = target;
        break;
    }
    if (!isdefined(decoy.var_faa77c1d)) {
        self function_10cd71b(decoy, potentialtargets);
    }
    decoy notsolid();
    decoy.notsolid = 1;
    decoy notify(#"end_nudge_collision");
    decoy.ignoreall = 1;
    decoy.takedamage = 0;
    decoy.health = 10000;
    decoy.goalradius = 36;
    decoy.goalheight = 36;
    decoy.good_melee_target = 1;
    return decoy;
}

// Namespace namespace_d9c8cca1
// Params 2, eflags: 0x1 linked
// Checksum 0xcce458d8, Offset: 0x1cb0
// Size: 0x124
function function_7ca046a9(lifetime, player) {
    self notify(#"hash_7ca046a9");
    self endon(#"hash_7ca046a9");
    self show();
    self clientfield::set("makedecoy", 1);
    waittime = lifetime + randomfloatrange(1, 3);
    if (getdvarint("scr_misdirection_debug", 0)) {
        level thread namespace_afd2f70b::function_a0e51d80(self.origin, waittime, 20, (1, 0, 0));
    }
    wait waittime;
    self clientfield::set("makedecoy", 0);
    util::wait_network_frame();
    self delete();
}

// Namespace namespace_d9c8cca1
// Params 2, eflags: 0x1 linked
// Checksum 0xcb981dfc, Offset: 0x1de0
// Size: 0xce
function function_44a2ae85(vec, mins) {
    if (vec[0] < mins[0]) {
        mins = (vec[0], mins[1], mins[2]);
    }
    if (vec[1] < mins[1]) {
        mins = (mins[0], vec[1], mins[2]);
    }
    if (vec[2] < mins[2]) {
        mins = (mins[0], mins[1], vec[2]);
    }
    return mins;
}

// Namespace namespace_d9c8cca1
// Params 2, eflags: 0x1 linked
// Checksum 0x49acdf7b, Offset: 0x1eb8
// Size: 0xce
function function_b72ba417(vec, maxs) {
    if (vec[0] > maxs[0]) {
        maxs = (vec[0], maxs[1], maxs[2]);
    }
    if (vec[1] > maxs[1]) {
        maxs = (maxs[0], vec[1], maxs[2]);
    }
    if (vec[2] > maxs[2]) {
        maxs = (maxs[0], maxs[1], vec[2]);
    }
    return maxs;
}

