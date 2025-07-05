#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_heatseekingmissile;

#namespace heatseekingmissile;

// Namespace heatseekingmissile
// Params 0, eflags: 0x2
// Checksum 0x7a851b59, Offset: 0x178
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("heatseekingmissile", &__init__, undefined, undefined);
}

// Namespace heatseekingmissile
// Params 0, eflags: 0x0
// Checksum 0x63714e04, Offset: 0x1b8
// Size: 0x14
function __init__() {
    init_shared();
}

