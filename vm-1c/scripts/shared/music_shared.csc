#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace music;

// Namespace music
// Params 0, eflags: 0x2
// Checksum 0xa392e30a, Offset: 0xc8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("music", &__init__, undefined, undefined);
}

// Namespace music
// Params 0, eflags: 0x0
// Checksum 0x6154177e, Offset: 0x108
// Size: 0x5c
function __init__() {
    level.activemusicstate = "";
    level.nextmusicstate = "";
    level.musicstates = [];
    util::register_system("musicCmd", &musiccmdhandler);
}

// Namespace music
// Params 3, eflags: 0x0
// Checksum 0x87e0bba1, Offset: 0x170
// Size: 0x64
function musiccmdhandler(clientnum, state, oldstate) {
    if (state != "death") {
        level._lastmusicstate = state;
    }
    state = tolower(state);
    soundsetmusicstate(state);
}

