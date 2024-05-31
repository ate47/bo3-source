#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace clientids;

// Namespace clientids
// Params 0, eflags: 0x2
// namespace_8c2d92de<file_0>::function_2dc19561
// Checksum 0xf44f4f79, Offset: 0xe8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("clientids", &__init__, undefined, undefined);
}

// Namespace clientids
// Params 0, eflags: 0x1 linked
// namespace_8c2d92de<file_0>::function_8c87d8eb
// Checksum 0x9015d925, Offset: 0x128
// Size: 0x44
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
}

// Namespace clientids
// Params 0, eflags: 0x1 linked
// namespace_8c2d92de<file_0>::function_c35e6aab
// Checksum 0xb3ca95f2, Offset: 0x178
// Size: 0x10
function init() {
    level.clientid = 0;
}

// Namespace clientids
// Params 0, eflags: 0x1 linked
// namespace_8c2d92de<file_0>::function_fb4f96b5
// Checksum 0x2ae1dc68, Offset: 0x190
// Size: 0x94
function on_player_connect() {
    self.clientid = matchrecordnewplayer(self);
    if (!isdefined(self.clientid) || self.clientid == -1) {
        self.clientid = level.clientid;
        level.clientid++;
    }
    println("<unknown string>" + self.name + "<unknown string>" + self.clientid);
}

