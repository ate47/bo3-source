#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;

#namespace player;

// Namespace player
// Params 0, eflags: 0x2
// namespace_5dc5e20a<file_0>::function_2dc19561
// Checksum 0xdc7a9049, Offset: 0xf0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("player", &__init__, undefined, undefined);
}

// Namespace player
// Params 0, eflags: 0x1 linked
// namespace_5dc5e20a<file_0>::function_8c87d8eb
// Checksum 0xac5b2152, Offset: 0x130
// Size: 0x4c
function __init__() {
    clientfield::register("world", "gameplay_started", 4000, 1, "int", &gameplay_started_callback, 0, 1);
}

// Namespace player
// Params 7, eflags: 0x1 linked
// namespace_5dc5e20a<file_0>::function_39cecb3f
// Checksum 0x5e2ea3c, Offset: 0x188
// Size: 0x5c
function gameplay_started_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setdvar("cg_isGameplayActive", newval);
}

