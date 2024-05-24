#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_7d317a5e;

// Namespace namespace_7d317a5e
// Params 0, eflags: 0x2
// Checksum 0x2e1508cb, Offset: 0x168
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("mechtank", &__init__, undefined, undefined);
}

// Namespace namespace_7d317a5e
// Params 0, eflags: 0x0
// Checksum 0xa11dd81, Offset: 0x1a8
// Size: 0x2c
function __init__() {
    vehicle::add_vehicletype_callback("mechtank", &_setup_);
}

// Namespace namespace_7d317a5e
// Params 1, eflags: 0x0
// Checksum 0xd7e83fa3, Offset: 0x1e0
// Size: 0x3c
function _setup_(localclientnum) {
    self thread player_enter(localclientnum);
    self thread player_exit(localclientnum);
}

// Namespace namespace_7d317a5e
// Params 1, eflags: 0x0
// Checksum 0x6139cc55, Offset: 0x228
// Size: 0x80
function player_enter(localclientnum) {
    self endon(#"death");
    self endon(#"entityshutdown");
    while (true) {
        player = self waittill(#"enter_vehicle");
        if (self islocalclientdriver(localclientnum)) {
            self sethighdetail(1);
        }
        wait(0.016);
    }
}

// Namespace namespace_7d317a5e
// Params 1, eflags: 0x0
// Checksum 0x7036de4b, Offset: 0x2b0
// Size: 0x88
function player_exit(localclientnum) {
    self endon(#"death");
    self endon(#"entityshutdown");
    while (true) {
        player = self waittill(#"exit_vehicle");
        if (isdefined(player) && player islocalplayer()) {
            self sethighdetail(0);
        }
        wait(0.016);
    }
}

