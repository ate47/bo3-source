#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_54bf13f5;

// Namespace namespace_54bf13f5
// Params 0, eflags: 0x2
// namespace_54bf13f5<file_0>::function_2dc19561
// Checksum 0x826f946, Offset: 0x188
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_zod_idgun_quest", &__init__, undefined, undefined);
}

// Namespace namespace_54bf13f5
// Params 0, eflags: 0x0
// namespace_54bf13f5<file_0>::function_8c87d8eb
// Checksum 0x57843b39, Offset: 0x1c8
// Size: 0x94
function __init__() {
    clientfield::register("world", "add_idgun_to_box", 1, 4, "int", &function_623d27f2, 0, 0);
    clientfield::register("world", "remove_idgun_from_box", 1, 4, "int", &function_5578fd14, 0, 0);
}

// Namespace namespace_54bf13f5
// Params 7, eflags: 0x0
// namespace_54bf13f5<file_0>::function_623d27f2
// Checksum 0x849db830, Offset: 0x268
// Size: 0x9c
function function_623d27f2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_3262a5f7 = getweapon("idgun" + "_" + newval);
    addzombieboxweapon(var_3262a5f7, var_3262a5f7.worldmodel, var_3262a5f7.isdualwield);
}

// Namespace namespace_54bf13f5
// Params 7, eflags: 0x0
// namespace_54bf13f5<file_0>::function_5578fd14
// Checksum 0xd392ff6, Offset: 0x310
// Size: 0x84
function function_5578fd14(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_3262a5f7 = getweapon("idgun" + "_" + newval);
    removezombieboxweapon(var_3262a5f7);
}

