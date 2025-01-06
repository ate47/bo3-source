#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_riotshield;

#namespace riotshield;

// Namespace riotshield
// Params 0, eflags: 0x2
// Checksum 0x20440823, Offset: 0x1a8
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("riotshield", &__init__, undefined, undefined);
}

// Namespace riotshield
// Params 0, eflags: 0x0
// Checksum 0xffcb801f, Offset: 0x1e0
// Size: 0x12
function __init__() {
    init_shared();
}

