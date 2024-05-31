#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_dev;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;
#using scripts/shared/math_shared;

#namespace namespace_941cddd7;

// Namespace namespace_941cddd7
// Params 0, eflags: 0x1 linked
// namespace_941cddd7<file_0>::function_c35e6aab
// Checksum 0x99ec1590, Offset: 0x258
// Size: 0x4
function init() {
    
}

// Namespace namespace_941cddd7
// Params 0, eflags: 0x1 linked
// namespace_941cddd7<file_0>::function_d290ebfa
// Checksum 0x47cfa095, Offset: 0x268
// Size: 0x9c
function main() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    cybercom_tacrig::function_8cb15f87("cybercom_playermovement", 5);
    cybercom_tacrig::function_8b4ef058("cybercom_playermovement", &function_dbad932a, &function_43c4eb6);
}

// Namespace namespace_941cddd7
// Params 0, eflags: 0x1 linked
// namespace_941cddd7<file_0>::function_fb4f96b5
// Checksum 0x99ec1590, Offset: 0x310
// Size: 0x4
function on_player_connect() {
    
}

// Namespace namespace_941cddd7
// Params 0, eflags: 0x1 linked
// namespace_941cddd7<file_0>::function_aebcf025
// Checksum 0x99ec1590, Offset: 0x320
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace namespace_941cddd7
// Params 1, eflags: 0x1 linked
// namespace_941cddd7<file_0>::function_dbad932a
// Checksum 0xc95200f3, Offset: 0x330
// Size: 0x24
function function_dbad932a(type) {
    self thread cybercom_tacrig::function_de82b8b4(type);
}

// Namespace namespace_941cddd7
// Params 1, eflags: 0x1 linked
// namespace_941cddd7<file_0>::function_43c4eb6
// Checksum 0x66625d90, Offset: 0x360
// Size: 0x24
function function_43c4eb6(type) {
    self thread cybercom_tacrig::function_e7e75042(type);
}

