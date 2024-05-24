#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace counteruav;

// Namespace counteruav
// Params 0, eflags: 0x2
// Checksum 0x9e244fdb, Offset: 0x130
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("counteruav", &__init__, undefined, undefined);
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0x50f4ce2e, Offset: 0x170
// Size: 0x4c
function __init__() {
    clientfield::register("scriptmover", "counteruav", 1, 1, "int", &spawned, 0, 0);
}

// Namespace counteruav
// Params 7, eflags: 0x0
// Checksum 0xe529a53b, Offset: 0x1c8
// Size: 0x10e
function spawned(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.counteruavs)) {
        level.counteruavs = [];
    }
    if (!isdefined(level.counteruavs[localclientnum])) {
        level.counteruavs[localclientnum] = 0;
    }
    player = getlocalplayer(localclientnum);
    /#
        assert(isdefined(player));
    #/
    if (newval) {
        level.counteruavs[localclientnum]++;
        self thread function_8752903c(localclientnum);
        player setenemyglobalscrambler(1);
        return;
    }
    self notify(#"hash_1d3810db");
}

// Namespace counteruav
// Params 1, eflags: 0x0
// Checksum 0x32428ae9, Offset: 0x2e0
// Size: 0xdc
function function_8752903c(localclientnum) {
    self util::waittill_any("entityshutdown", "counteruav_off");
    level.counteruavs[localclientnum]--;
    if (level.counteruavs[localclientnum] < 0) {
        level.counteruavs[localclientnum] = 0;
    }
    player = getlocalplayer(localclientnum);
    /#
        assert(isdefined(player));
    #/
    if (level.counteruavs[localclientnum] == 0) {
        player setenemyglobalscrambler(0);
    }
}

