#using scripts/cp/_util;
#using scripts/shared/weapons/_heatseekingmissile;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace heatseekingmissile;

// Namespace heatseekingmissile
// Params 0, eflags: 0x2
// namespace_181a2aa3<file_0>::function_2dc19561
// Checksum 0x7a851b59, Offset: 0x178
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("heatseekingmissile", &__init__, undefined, undefined);
}

// Namespace heatseekingmissile
// Params 0, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_8c87d8eb
// Checksum 0x63714e04, Offset: 0x1b8
// Size: 0x14
function __init__() {
    init_shared();
}

