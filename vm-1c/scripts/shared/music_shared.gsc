#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace music;

// Namespace music
// Params 0, eflags: 0x2
// Checksum 0x77f7b329, Offset: 0xf0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("music", &__init__, undefined, undefined);
}

// Namespace music
// Params 0, eflags: 0x0
// Checksum 0x8bb88893, Offset: 0x130
// Size: 0x5c
function __init__() {
    level.musicstate = "";
    util::registerclientsys("musicCmd");
    if (sessionmodeiscampaigngame()) {
        callback::on_spawned(&on_player_spawned);
    }
}

// Namespace music
// Params 2, eflags: 0x0
// Checksum 0xa2eaa94d, Offset: 0x198
// Size: 0xa8
function setmusicstate(state, player) {
    if (isdefined(level.musicstate)) {
        if (isdefined(level.var_effda531) && level.var_effda531) {
            return;
        }
        if (isdefined(player)) {
            util::setclientsysstate("musicCmd", state, player);
            return;
        } else if (level.musicstate != state) {
            util::setclientsysstate("musicCmd", state);
        }
    }
    level.musicstate = state;
}

// Namespace music
// Params 0, eflags: 0x0
// Checksum 0x201531c3, Offset: 0x248
// Size: 0x9c
function on_player_spawned() {
    if (isdefined(level.musicstate)) {
        if (issubstr(level.musicstate, "_igc") || issubstr(level.musicstate, "igc_")) {
            return;
        }
        if (isdefined(self)) {
            setmusicstate(level.musicstate, self);
            return;
        }
        setmusicstate(level.musicstate);
    }
}

