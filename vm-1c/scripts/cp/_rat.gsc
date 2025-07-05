#using scripts/cp/_util;
#using scripts/shared/rat_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace rat;

/#

    // Namespace rat
    // Params 0, eflags: 0x2
    // Checksum 0xc8065075, Offset: 0xd8
    // Size: 0x34
    function autoexec __init__sytem__() {
        system::register("<dev string:x28>", &__init__, undefined, undefined);
    }

    // Namespace rat
    // Params 0, eflags: 0x0
    // Checksum 0xaa37bd14, Offset: 0x118
    // Size: 0x44
    function __init__() {
        rat_shared::init();
        level.rat.common.gethostplayer = &util::gethostplayer;
    }

#/
