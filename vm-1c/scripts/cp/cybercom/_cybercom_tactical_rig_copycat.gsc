#using scripts/codescripts/struct;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_dev;
#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons_shared;

#namespace namespace_b854c5d0;

// Namespace namespace_b854c5d0
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x268
// Size: 0x4
function init() {
    
}

// Namespace namespace_b854c5d0
// Params 0, eflags: 0x0
// Checksum 0x82dfc26c, Offset: 0x278
// Size: 0x9c
function main() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    cybercom_tacrig::function_8cb15f87("cybercom_copycat", 6);
    cybercom_tacrig::function_8b4ef058("cybercom_copycat", &function_f32160f1, &function_6cdcecbb);
}

// Namespace namespace_b854c5d0
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x320
// Size: 0x4
function on_player_connect() {
    
}

// Namespace namespace_b854c5d0
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x330
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace namespace_b854c5d0
// Params 1, eflags: 0x0
// Checksum 0x2aa30e24, Offset: 0x340
// Size: 0x24
function function_f32160f1(type) {
    self thread cybercom_tacrig::function_de82b8b4(type);
}

// Namespace namespace_b854c5d0
// Params 1, eflags: 0x0
// Checksum 0x6c97d0a7, Offset: 0x370
// Size: 0x32
function function_6cdcecbb(type) {
    self thread cybercom_tacrig::function_e7e75042(type);
    self notify(#"hash_6cdcecbb");
}

