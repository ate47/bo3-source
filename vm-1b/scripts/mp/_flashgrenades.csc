#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/weapons/_flashgrenades;

#namespace flashgrenades;

// Namespace flashgrenades
// Params 0, eflags: 0x2
// Checksum 0xbd5fdc8b, Offset: 0x170
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("flashgrenades", &__init__, undefined, undefined);
}

// Namespace flashgrenades
// Params 1, eflags: 0x0
// Checksum 0xd7185c5a, Offset: 0x1a8
// Size: 0x1a
function __init__(localclientnum) {
    init_shared();
}

