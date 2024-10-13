#using scripts/mp/_util;
#using scripts/shared/weapons/_flashgrenades;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace flashgrenades;

// Namespace flashgrenades
// Params 0, eflags: 0x2
// Checksum 0xae199f8b, Offset: 0x170
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("flashgrenades", &__init__, undefined, undefined);
}

// Namespace flashgrenades
// Params 1, eflags: 0x1 linked
// Checksum 0xf0ccf5e3, Offset: 0x1b0
// Size: 0x1c
function __init__(localclientnum) {
    init_shared();
}

