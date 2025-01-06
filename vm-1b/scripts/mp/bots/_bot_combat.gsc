#using scripts/mp/_util;
#using scripts/mp/bots/_bot;
#using scripts/shared/array_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weapon_utils;
#using scripts/shared/weapons/_weapons;
#using scripts/shared/weapons_shared;

#namespace namespace_5cd60c9f;

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x0
// Checksum 0x30c37fd2, Offset: 0x1d8
// Size: 0x30
function function_975133a0(entity) {
    if (function_9d54f045(entity) && !self bot::has_launcher()) {
        return false;
    }
    return false;
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x0
// Checksum 0xb6594a66, Offset: 0x210
// Size: 0x8a
function function_9fd498fd() {
    if (self isreloading() || self isswitchingweapons() || self isthrowinggrenade()) {
        return;
    }
    if (self function_231137e6()) {
        self function_e891ab0f();
        return;
    }
    self switch_weapon();
    self reload_weapon();
    self bot::use_killstreak();
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x0
// Checksum 0xac342689, Offset: 0x2a8
// Size: 0x5d
function function_9d54f045(enemy) {
    if (!isdefined(enemy) || isplayer(enemy)) {
        return false;
    }
    if (isdefined(enemy.killstreaktype)) {
        return true;
    }
    if (isdefined(enemy.parentstruct) && isdefined(enemy.parentstruct.killstreaktype)) {
        return true;
    }
    return false;
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x0
// Checksum 0xc669db70, Offset: 0x310
// Size: 0xa
function function_3898a2e(origin) {
    
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x0
// Checksum 0x4e1430ac, Offset: 0x328
// Size: 0xa
function function_5b3d70aa(origin) {
    
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x0
// Checksum 0x5ac13d85, Offset: 0x340
// Size: 0xa
function function_bcc19909(origin) {
    
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x0
// Checksum 0xd7d36db0, Offset: 0x358
// Size: 0xa
function function_2bbe6c14(origin) {
    
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x0
// Checksum 0x24864965, Offset: 0x370
// Size: 0xa
function function_47da49a4(origin) {
    
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x0
// Checksum 0x2ea69fd6, Offset: 0x388
// Size: 0xa
function function_4e67699e(origin) {
    
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x0
// Checksum 0x24af8143, Offset: 0x3a0
// Size: 0xb
function function_f7a55431(origin) {
    return false;
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x0
// Checksum 0x9fc6aff7, Offset: 0x3b8
// Size: 0xb
function nearest_node(origin) {
    return undefined;
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x0
// Checksum 0xdf921377, Offset: 0x3d0
// Size: 0x19
function function_fbd9ba9a(origin) {
    return bot::fwd_dot(origin);
}

