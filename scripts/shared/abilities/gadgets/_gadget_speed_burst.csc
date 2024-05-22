#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/postfx_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/system_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_8dc900d7;

// Namespace namespace_8dc900d7
// Params 0, eflags: 0x2
// Checksum 0x820f1323, Offset: 0x248
// Size: 0x34
function function_2dc19561() {
    system::register("gadget_speed_burst", &__init__, undefined, undefined);
}

// Namespace namespace_8dc900d7
// Params 0, eflags: 0x1 linked
// Checksum 0xcc6c3066, Offset: 0x288
// Size: 0x94
function __init__() {
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    clientfield::register("toplayer", "speed_burst", 1, 1, "int", &function_d6b43cb, 0, 1);
    visionset_mgr::register_visionset_info("speed_burst", 1, 9, undefined, "speed_burst_initialize");
}

// Namespace namespace_8dc900d7
// Params 1, eflags: 0x1 linked
// Checksum 0xb7e83340, Offset: 0x328
// Size: 0x54
function on_localplayer_spawned(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    filter::init_filter_speed_burst(self);
    filter::disable_filter_speed_burst(self, 3);
}

// Namespace namespace_8dc900d7
// Params 7, eflags: 0x1 linked
// Checksum 0x5dac8861, Offset: 0x388
// Size: 0xbc
function function_d6b43cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (self == getlocalplayer(localclientnum)) {
            filter::enable_filter_speed_burst(self, 3);
        }
        return;
    }
    if (self == getlocalplayer(localclientnum)) {
        filter::disable_filter_speed_burst(self, 3);
    }
}

