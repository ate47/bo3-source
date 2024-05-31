#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_sword_flay;

// Namespace zm_bgb_sword_flay
// Params 0, eflags: 0x2
// namespace_6caa802f<file_0>::function_2dc19561
// Checksum 0xc0c4313b, Offset: 0x198
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_sword_flay", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_sword_flay
// Params 0, eflags: 0x1 linked
// namespace_6caa802f<file_0>::function_8c87d8eb
// Checksum 0xc10f4d85, Offset: 0x1d8
// Size: 0xac
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_sword_flay", "time", -106, &enable, &disable, undefined);
    bgb::register_actor_damage_override("zm_bgb_sword_flay", &actor_damage_override);
    bgb::register_vehicle_damage_override("zm_bgb_sword_flay", &vehicle_damage_override);
}

// Namespace zm_bgb_sword_flay
// Params 0, eflags: 0x1 linked
// namespace_6caa802f<file_0>::function_bae40a28
// Checksum 0x99ec1590, Offset: 0x290
// Size: 0x4
function enable() {
    
}

// Namespace zm_bgb_sword_flay
// Params 0, eflags: 0x1 linked
// namespace_6caa802f<file_0>::function_54bdb053
// Checksum 0x99ec1590, Offset: 0x2a0
// Size: 0x4
function disable() {
    
}

// Namespace zm_bgb_sword_flay
// Params 12, eflags: 0x1 linked
// namespace_6caa802f<file_0>::function_33cecf53
// Checksum 0xcd14acee, Offset: 0x2b0
// Size: 0xe0
function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (meansofdeath === "MOD_MELEE") {
        damage *= 5;
        if (self.health - damage <= 0 && isdefined(attacker) && isplayer(attacker)) {
            attacker zm_stats::increment_challenge_stat("GUM_GOBBLER_SWORD_FLAY");
        }
    }
    return damage;
}

// Namespace zm_bgb_sword_flay
// Params 15, eflags: 0x1 linked
// namespace_6caa802f<file_0>::function_cde5d14c
// Checksum 0xc12369cb, Offset: 0x398
// Size: 0xa2
function vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (smeansofdeath === "MOD_MELEE") {
        idamage *= 5;
    }
    return idamage;
}

