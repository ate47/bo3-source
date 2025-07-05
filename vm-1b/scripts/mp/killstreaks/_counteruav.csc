#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace counteruav;

// Namespace counteruav
// Params 0, eflags: 0x2
// Checksum 0x52a98355, Offset: 0x118
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("counteruav", &__init__, undefined, undefined);
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0x535b067a, Offset: 0x150
// Size: 0x3a
function __init__() {
    clientfield::register("toplayer", "counteruav", 1, 1, "int", &counteruavchanged, 0, 1);
}

// Namespace counteruav
// Params 7, eflags: 0x0
// Checksum 0x418d69ce, Offset: 0x198
// Size: 0x7a
function counteruavchanged(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    assert(isdefined(player));
    player setenemyglobalscrambler(newval);
}

