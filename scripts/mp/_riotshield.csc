#using scripts/mp/_util;
#using scripts/shared/weapons/_riotshield;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace riotshield;

// Namespace riotshield
// Params 0, eflags: 0x2
// Checksum 0xd21c6231, Offset: 0x138
// Size: 0x34
function function_2dc19561() {
    system::register("riotshield", &__init__, undefined, undefined);
}

// Namespace riotshield
// Params 0, eflags: 0x1 linked
// Checksum 0xa0cc18b2, Offset: 0x178
// Size: 0x14
function __init__() {
    init_shared();
}

