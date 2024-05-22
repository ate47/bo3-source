#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_3a292d50;

// Namespace namespace_3a292d50
// Params 0, eflags: 0x2
// Checksum 0x17d41454, Offset: 0x2c8
// Size: 0x34
function function_2dc19561() {
    system::register("gadget_speed_burst", &__init__, undefined, undefined);
}

// Namespace namespace_3a292d50
// Params 0, eflags: 0x1 linked
// Checksum 0x93c543c5, Offset: 0x308
// Size: 0x16c
function __init__() {
    clientfield::register("toplayer", "speed_burst", 1, 1, "int");
    ability_player::register_gadget_activation_callbacks(13, &function_4471717e, &function_51b450f4);
    ability_player::register_gadget_possession_callbacks(13, &function_41c1ea5a, &function_65a0fef4);
    ability_player::register_gadget_flicker_callbacks(13, &function_70950c7);
    ability_player::register_gadget_is_inuse_callbacks(13, &function_15880b4e);
    ability_player::register_gadget_is_flickering_callbacks(13, &function_8386c640);
    if (!isdefined(level.var_6a6f3b04)) {
        level.var_6a6f3b04 = 60;
    }
    visionset_mgr::register_info("visionset", "speed_burst", 1, level.var_6a6f3b04, 9, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
    callback::on_connect(&function_bfafa469);
}

// Namespace namespace_3a292d50
// Params 1, eflags: 0x1 linked
// Checksum 0xdb301688, Offset: 0x480
// Size: 0x2a
function function_15880b4e(slot) {
    return self flagsys::get("gadget_speed_burst_on");
}

// Namespace namespace_3a292d50
// Params 1, eflags: 0x1 linked
// Checksum 0x4b9ce329, Offset: 0x4b8
// Size: 0x22
function function_8386c640(slot) {
    return self gadgetflickering(slot);
}

// Namespace namespace_3a292d50
// Params 2, eflags: 0x1 linked
// Checksum 0xde6b0911, Offset: 0x4e8
// Size: 0x34
function function_70950c7(slot, weapon) {
    self thread function_5b8d7647(slot, weapon);
}

// Namespace namespace_3a292d50
// Params 2, eflags: 0x1 linked
// Checksum 0x7c825f71, Offset: 0x528
// Size: 0x4c
function function_41c1ea5a(slot, weapon) {
    flagsys::set("speed_burst_on");
    self clientfield::set_to_player("speed_burst", 0);
}

// Namespace namespace_3a292d50
// Params 2, eflags: 0x1 linked
// Checksum 0x995c19e4, Offset: 0x580
// Size: 0x4c
function function_65a0fef4(slot, weapon) {
    flagsys::clear("speed_burst_on");
    self clientfield::set_to_player("speed_burst", 0);
}

// Namespace namespace_3a292d50
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x5d8
// Size: 0x4
function function_bfafa469() {
    
}

// Namespace namespace_3a292d50
// Params 2, eflags: 0x1 linked
// Checksum 0x81291a6a, Offset: 0x5e8
// Size: 0xc8
function function_4471717e(slot, weapon) {
    self flagsys::set("gadget_speed_burst_on");
    self gadgetsetactivatetime(slot, gettime());
    self clientfield::set_to_player("speed_burst", 1);
    visionset_mgr::activate("visionset", "speed_burst", self, 0.4, 0.1, 1.35);
    self.speedburstlastontime = gettime();
    self.speedburston = 1;
    self.speedburstkill = 0;
}

// Namespace namespace_3a292d50
// Params 2, eflags: 0x1 linked
// Checksum 0x76b9a15, Offset: 0x6b8
// Size: 0xd4
function function_51b450f4(slot, weapon) {
    self notify(#"hash_51b450f4");
    self flagsys::clear("gadget_speed_burst_on");
    self clientfield::set_to_player("speed_burst", 0);
    self.speedburstlastontime = gettime();
    self.speedburston = 0;
    if (isdefined(self.speedburstkill) && isalive(self) && self.speedburstkill && isdefined(level.playgadgetsuccess)) {
        self [[ level.playgadgetsuccess ]](weapon);
    }
    self.speedburstkill = 0;
}

// Namespace namespace_3a292d50
// Params 2, eflags: 0x1 linked
// Checksum 0x91476243, Offset: 0x798
// Size: 0xcc
function function_5b8d7647(slot, weapon) {
    self endon(#"disconnect");
    if (!self function_15880b4e(slot)) {
        return;
    }
    eventtime = self._gadgets_player[slot].gadget_flickertime;
    self function_39b1b87b("Flickering", eventtime);
    while (true) {
        if (!self gadgetflickering(slot)) {
            self function_39b1b87b("Normal");
            return;
        }
        wait(0.5);
    }
}

// Namespace namespace_3a292d50
// Params 2, eflags: 0x1 linked
// Checksum 0x948e74e, Offset: 0x870
// Size: 0x9c
function function_39b1b87b(status, time) {
    timestr = "";
    if (isdefined(time)) {
        timestr = "^3" + ", time: " + time;
    }
    if (getdvarint("scr_cpower_debug_prints") > 0) {
        self iprintlnbold("Vision Speed burst: " + status + timestr);
    }
}

