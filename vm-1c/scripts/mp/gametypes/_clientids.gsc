#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace clientids;

// Namespace clientids
// Params 0, eflags: 0x2
// Checksum 0x48f8f4f2, Offset: 0xe8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("clientids", &__init__, undefined, undefined);
}

// Namespace clientids
// Params 0, eflags: 0x0
// Checksum 0xfc100e92, Offset: 0x128
// Size: 0x44
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
}

// Namespace clientids
// Params 0, eflags: 0x0
// Checksum 0x299c87a8, Offset: 0x178
// Size: 0x10
function init() {
    level.clientid = 0;
}

// Namespace clientids
// Params 0, eflags: 0x0
// Checksum 0xa21fbb69, Offset: 0x190
// Size: 0x94
function on_player_connect() {
    self.clientid = matchrecordnewplayer(self);
    if (!isdefined(self.clientid) || self.clientid == -1) {
        self.clientid = level.clientid;
        level.clientid++;
    }
    println("<dev string:x28>" + self.name + "<dev string:x31>" + self.clientid);
}

