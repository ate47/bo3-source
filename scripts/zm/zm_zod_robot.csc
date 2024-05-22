#using scripts/shared/system_shared;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_2cce1885;

// Namespace namespace_2cce1885
// Params 0, eflags: 0x2
// Checksum 0x34716b07, Offset: 0x2c0
// Size: 0x34
function function_2dc19561() {
    system::register("zm_zod_robot", &__init__, undefined, undefined);
}

// Namespace namespace_2cce1885
// Params 0, eflags: 0x1 linked
// Checksum 0xe94728a4, Offset: 0x300
// Size: 0xbc
function __init__() {
    clientfield::register("scriptmover", "robot_switch", 1, 1, "int", &function_16e00222, 0, 0);
    clientfield::register("world", "robot_lights", 1, 2, "int", &robot_lights, 0, 0);
    ai::add_archetype_spawn_function("zod_companion", &function_a0b7ccbf);
}

// Namespace namespace_2cce1885
// Params 1, eflags: 0x5 linked
// Checksum 0x25ba1c5c, Offset: 0x3c8
// Size: 0x3c
function function_a0b7ccbf(localclientnum) {
    entity = self;
    entity setdrawname(%ZM_ZOD_ROBOT_NAME);
}

// Namespace namespace_2cce1885
// Params 7, eflags: 0x1 linked
// Checksum 0x82129aed, Offset: 0x410
// Size: 0x64
function function_16e00222(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfx(localclientnum, "zombie/fx_fuse_master_switch_on_zod_zmb", self.origin);
}

// Namespace namespace_2cce1885
// Params 7, eflags: 0x1 linked
// Checksum 0xcc0e75ea, Offset: 0x480
// Size: 0x1a6
function robot_lights(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 1:
        exploder::exploder("lgt_robot_callbox_green");
        exploder::stop_exploder("lgt_robot_callbox_red");
        exploder::stop_exploder("lgt_robot_callbox_yellow");
        break;
    case 2:
        exploder::stop_exploder("lgt_robot_callbox_green");
        exploder::exploder("lgt_robot_callbox_red");
        exploder::stop_exploder("lgt_robot_callbox_yellow");
        break;
    case 3:
        exploder::stop_exploder("lgt_robot_callbox_green");
        exploder::stop_exploder("lgt_robot_callbox_red");
        exploder::exploder("lgt_robot_callbox_yellow");
        break;
    default:
        exploder::stop_exploder("lgt_robot_callbox_green");
        exploder::stop_exploder("lgt_robot_callbox_red");
        exploder::stop_exploder("lgt_robot_callbox_yellow");
        break;
    }
}

