#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace clientids;

// Namespace clientids
// Params 0, eflags: 0x2
// Checksum 0x5ecd1f60, Offset: 0xe8
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("clientids", &__init__, undefined, undefined);
}

// Namespace clientids
// Params 0, eflags: 0x0
// Checksum 0x8d06520d, Offset: 0x120
// Size: 0x42
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
}

// Namespace clientids
// Params 0, eflags: 0x0
// Checksum 0xa5c679ff, Offset: 0x170
// Size: 0xa
function init() {
    level.clientid = 0;
}

// Namespace clientids
// Params 0, eflags: 0x0
// Checksum 0xff82b7ac, Offset: 0x188
// Size: 0x7a
function on_player_connect() {
    self.clientid = matchrecordnewplayer(self);
    if (!isdefined(self.clientid) || self.clientid == -1) {
        self.clientid = level.clientid;
        level.clientid++;
    }
    println("<dev string:x28>" + self.name + "<dev string:x31>" + self.clientid);
}

