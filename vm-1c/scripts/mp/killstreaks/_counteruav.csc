#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace counteruav;

// Namespace counteruav
// Params 0, eflags: 0x2
// namespace_65ee1df9<file_0>::function_2dc19561
// Checksum 0xc6d99269, Offset: 0x118
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("counteruav", &__init__, undefined, undefined);
}

// Namespace counteruav
// Params 0, eflags: 0x1 linked
// namespace_65ee1df9<file_0>::function_8c87d8eb
// Checksum 0xbe17d2d8, Offset: 0x158
// Size: 0x4c
function __init__() {
    clientfield::register("toplayer", "counteruav", 1, 1, "int", &counteruavchanged, 0, 1);
}

// Namespace counteruav
// Params 7, eflags: 0x1 linked
// namespace_65ee1df9<file_0>::function_dcf04abb
// Checksum 0x7efa007c, Offset: 0x1b0
// Size: 0x94
function counteruavchanged(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    assert(isdefined(player));
    player setenemyglobalscrambler(newval);
}

