#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_riotshield;

#namespace riotshield;

// Namespace riotshield
// Params 0, eflags: 0x2
// Checksum 0x244dcbb1, Offset: 0x138
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("riotshield", &__init__, undefined, undefined);
}

// Namespace riotshield
// Params 0, eflags: 0x0
// Checksum 0xffcb801f, Offset: 0x170
// Size: 0x12
function __init__() {
    init_shared();
}

