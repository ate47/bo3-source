#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace scoreboard;

// Namespace scoreboard
// Params 0, eflags: 0x2
// Checksum 0xfbf33d4c, Offset: 0xe8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("scoreboard", &__init__, undefined, undefined);
}

// Namespace scoreboard
// Params 0, eflags: 0x0
// Checksum 0x918c5e48, Offset: 0x128
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace scoreboard
// Params 0, eflags: 0x0
// Checksum 0xdf909af1, Offset: 0x158
// Size: 0x1a
function init() {
    if (sessionmodeiszombiesgame()) {
    }
}

