#using scripts/cp/_util;
#using scripts/shared/rat_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;

#namespace rat;

/#

    // Namespace rat
    // Params 0, eflags: 0x2
    // namespace_c7970376<file_0>::function_2dc19561
    // Checksum 0xc8065075, Offset: 0xd8
    // Size: 0x34
    function autoexec function_2dc19561() {
        system::register("<unknown string>", &__init__, undefined, undefined);
    }

    // Namespace rat
    // Params 0, eflags: 0x1 linked
    // namespace_c7970376<file_0>::function_8c87d8eb
    // Checksum 0xaa37bd14, Offset: 0x118
    // Size: 0x44
    function __init__() {
        rat_shared::init();
        level.rat.common.gethostplayer = &util::gethostplayer;
    }

#/
