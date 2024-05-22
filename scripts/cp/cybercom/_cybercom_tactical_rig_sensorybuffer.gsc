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

#namespace namespace_fc601b38;

// Namespace namespace_fc601b38
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x298
// Size: 0x4
function init() {
    
}

// Namespace namespace_fc601b38
// Params 0, eflags: 0x1 linked
// Checksum 0x887217cd, Offset: 0x2a8
// Size: 0xd4
function main() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    cybercom_tacrig::function_8cb15f87("cybercom_sensorybuffer", 4);
    cybercom_tacrig::function_8b4ef058("cybercom_sensorybuffer", &function_1efe17b1, &function_8841b07b);
    cybercom_tacrig::function_37a33686("cybercom_sensorybuffer", &function_e941faf9, &function_b5467750);
}

// Namespace namespace_fc601b38
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x388
// Size: 0x4
function on_player_connect() {
    
}

// Namespace namespace_fc601b38
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x398
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace namespace_fc601b38
// Params 1, eflags: 0x1 linked
// Checksum 0x46778232, Offset: 0x3a8
// Size: 0x24
function function_1efe17b1(type) {
    self thread cybercom_tacrig::function_de82b8b4(type);
}

// Namespace namespace_fc601b38
// Params 1, eflags: 0x1 linked
// Checksum 0x7bd3152, Offset: 0x3d8
// Size: 0x24
function function_8841b07b(type) {
    self thread cybercom_tacrig::function_e7e75042(type);
}

// Namespace namespace_fc601b38
// Params 1, eflags: 0x1 linked
// Checksum 0xee152609, Offset: 0x408
// Size: 0x8c
function function_e941faf9(type) {
    self setperk("specialty_bulletflinch");
    self setperk("specialty_flashprotection");
    if (self function_76f34311(type) == 2) {
        self setperk("specialty_flakjacket");
    }
}

// Namespace namespace_fc601b38
// Params 1, eflags: 0x1 linked
// Checksum 0x2b53e040, Offset: 0x4a0
// Size: 0x8c
function function_b5467750(type) {
    self unsetperk("specialty_bulletflinch");
    self unsetperk("specialty_flashprotection");
    if (self function_76f34311(type) == 2) {
        self unsetperk("specialty_flakjacket");
    }
}

