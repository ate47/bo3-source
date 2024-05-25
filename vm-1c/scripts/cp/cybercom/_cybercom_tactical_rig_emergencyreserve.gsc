#using scripts/cp/gametypes/_save;
#using scripts/cp/cybercom/_cybercom_tactical_rig_proximitydeterrent;
#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_dev;
#using scripts/shared/clientfield_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;
#using scripts/shared/math_shared;

#namespace namespace_e3074452;

// Namespace namespace_e3074452
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x3b0
// Size: 0x4
function init() {
    
}

// Namespace namespace_e3074452
// Params 0, eflags: 0x1 linked
// Checksum 0x7cde4f48, Offset: 0x3c0
// Size: 0x114
function main() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    setdvar("scr_emergency_reserve_timer", 5);
    setdvar("scr_emergency_reserve_timer_upgraded", 8);
    cybercom_tacrig::function_8cb15f87("cybercom_emergencyreserve", 3);
    cybercom_tacrig::function_8b4ef058("cybercom_emergencyreserve", &function_a7861293, &function_5f9e76f1);
    cybercom_tacrig::function_37a33686("cybercom_emergencyreserve", &function_306198fb, &function_18e4af4a);
}

// Namespace namespace_e3074452
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x4e0
// Size: 0x4
function on_player_connect() {
    
}

// Namespace namespace_e3074452
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x4f0
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace namespace_e3074452
// Params 1, eflags: 0x1 linked
// Checksum 0xf0f22155, Offset: 0x500
// Size: 0x54
function function_a7861293(type) {
    self.lives = self savegame::function_36adbb9c("lives", 1);
    self clientfield::set_to_player("sndTacRig", 1);
}

// Namespace namespace_e3074452
// Params 1, eflags: 0x1 linked
// Checksum 0x788928ab, Offset: 0x560
// Size: 0x34
function function_5f9e76f1(type) {
    self.lives = 0;
    self clientfield::set_to_player("sndTacRig", 0);
}

// Namespace namespace_e3074452
// Params 1, eflags: 0x1 linked
// Checksum 0x896ea942, Offset: 0x5a0
// Size: 0xbc
function function_306198fb(type) {
    if (self.lives < 1) {
        return;
    }
    if (self function_76f34311("cybercom_emergencyreserve") == 2) {
        level thread namespace_d1c4e441::function_c0ba5acc(self);
    }
    self cybercom_tacrig::function_e7e75042("cybercom_emergencyreserve");
    self playlocalsound("gdt_cybercore_regen_godown");
    playfx("player/fx_plyr_ability_emergency_reserve_1p", self.origin);
}

// Namespace namespace_e3074452
// Params 1, eflags: 0x1 linked
// Checksum 0xe9eee012, Offset: 0x668
// Size: 0xc
function function_18e4af4a(type) {
    
}

// Namespace namespace_e3074452
// Params 1, eflags: 0x1 linked
// Checksum 0xe549a3da, Offset: 0x680
// Size: 0xa8
function function_9248cfb4(smeansofdeath) {
    if (isdefined(smeansofdeath)) {
        return (issubstr(smeansofdeath, "_BULLET") || issubstr(smeansofdeath, "_GRENADE") || issubstr(smeansofdeath, "_MELEE") || smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_SUICIDE" || smeansofdeath == "MOD_HEAD_SHOT");
    }
    return false;
}

