#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace clientids;

// Namespace clientids
// Params 0, eflags: 0x2
// Checksum 0xfa56725d, Offset: 0xe8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("clientids", &__init__, undefined, undefined);
}

// Namespace clientids
// Params 0, eflags: 0x0
// Checksum 0xe1e095dc, Offset: 0x128
// Size: 0x44
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
}

// Namespace clientids
// Params 0, eflags: 0x0
// Checksum 0x9337c0de, Offset: 0x178
// Size: 0x10
function init() {
    level.clientid = 0;
}

// Namespace clientids
// Params 0, eflags: 0x0
// Checksum 0x3af59814, Offset: 0x190
// Size: 0x94
function on_player_connect() {
    self.clientid = matchrecordnewplayer(self);
    if (!isdefined(self.clientid) || self.clientid == -1) {
        self.clientid = level.clientid;
        level.clientid++;
    }
    println("<dev string:x28>" + self.name + "<dev string:x31>" + self.clientid);
}

