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

#namespace namespace_52c052b7;

// Namespace namespace_52c052b7
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x248
// Size: 0x4
function init() {
    
}

// Namespace namespace_52c052b7
// Params 0, eflags: 0x1 linked
// Checksum 0xab333ce6, Offset: 0x258
// Size: 0x9c
function main() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    cybercom_tacrig::function_8cb15f87("cybercom_multicore", 7);
    cybercom_tacrig::function_8b4ef058("cybercom_multicore", &function_cb139492, &function_ef8692ac);
}

// Namespace namespace_52c052b7
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x300
// Size: 0x4
function on_player_connect() {
    
}

// Namespace namespace_52c052b7
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x310
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace namespace_52c052b7
// Params 1, eflags: 0x1 linked
// Checksum 0x278a6cc2, Offset: 0x320
// Size: 0x24
function function_cb139492(type) {
    self thread cybercom_tacrig::function_de82b8b4(type);
}

// Namespace namespace_52c052b7
// Params 1, eflags: 0x1 linked
// Checksum 0xcd4df2ba, Offset: 0x350
// Size: 0x24
function function_ef8692ac(type) {
    self thread cybercom_tacrig::function_e7e75042(type);
}

