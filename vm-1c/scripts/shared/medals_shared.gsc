#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace medals;

// Namespace medals
// Params 0, eflags: 0x2
// Checksum 0xa3ec32e4, Offset: 0xf0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("medals", &__init__, undefined, undefined);
}

// Namespace medals
// Params 0, eflags: 0x1 linked
// Checksum 0xea18e637, Offset: 0x130
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace medals
// Params 0, eflags: 0x1 linked
// Checksum 0xef5e30a3, Offset: 0x160
// Size: 0x4c
function init() {
    level.medalinfo = [];
    level.medalcallbacks = [];
    level.numkills = 0;
    callback::on_connect(&on_player_connect);
}

// Namespace medals
// Params 0, eflags: 0x1 linked
// Checksum 0x49cb5fb7, Offset: 0x1b8
// Size: 0xe
function on_player_connect() {
    self.lastkilledby = undefined;
}

// Namespace medals
// Params 1, eflags: 0x1 linked
// Checksum 0xedd6078f, Offset: 0x1d0
// Size: 0x18
function setlastkilledby(attacker) {
    self.lastkilledby = attacker;
}

// Namespace medals
// Params 0, eflags: 0x0
// Checksum 0x58d37075, Offset: 0x1f0
// Size: 0xc
function offenseglobalcount() {
    level.globalteammedals++;
}

// Namespace medals
// Params 0, eflags: 0x0
// Checksum 0x136dd30f, Offset: 0x208
// Size: 0xc
function defenseglobalcount() {
    level.globalteammedals++;
}

// Namespace medals
// Params 1, eflags: 0x1 linked
// Checksum 0x55d469d2, Offset: 0x220
// Size: 0x5c
function codecallback_medal(medalindex) {
    self luinotifyevent(%medal_received, 1, medalindex);
    self luinotifyeventtospectators(%medal_received, 1, medalindex);
}

