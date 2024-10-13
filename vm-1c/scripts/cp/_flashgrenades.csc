#using scripts/cp/_util;
#using scripts/shared/weapons/_flashgrenades;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace flashgrenades;

// Namespace flashgrenades
// Params 0, eflags: 0x2
// Checksum 0xbf4943dc, Offset: 0x190
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("flashgrenades", &__init__, undefined, undefined);
}

// Namespace flashgrenades
// Params 1, eflags: 0x1 linked
// Checksum 0xaf4299c5, Offset: 0x1d0
// Size: 0x1c
function __init__(localclientnum) {
    init_shared();
}

