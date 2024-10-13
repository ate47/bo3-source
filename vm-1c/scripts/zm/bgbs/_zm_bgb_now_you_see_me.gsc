#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_bgb;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/aat_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_now_you_see_me;

// Namespace zm_bgb_now_you_see_me
// Params 0, eflags: 0x2
// Checksum 0xb21c2874, Offset: 0x280
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_now_you_see_me", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_now_you_see_me
// Params 0, eflags: 0x1 linked
// Checksum 0xf98b2aa8, Offset: 0x2c0
// Size: 0x124
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_now_you_see_me", "activated", 2, undefined, undefined, &validation, &activation);
    bgb::function_336ffc4e("zm_bgb_now_you_see_me");
    if (!isdefined(level.vsmgr_prio_visionset_zm_bgb_now_you_see_me)) {
        level.vsmgr_prio_visionset_zm_bgb_now_you_see_me = 111;
    }
    visionset_mgr::register_info("visionset", "zm_bgb_now_you_see_me", 1, level.vsmgr_prio_visionset_zm_bgb_now_you_see_me, 31, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
    if (!isdefined(level.var_9cfc6d54)) {
        level.var_9cfc6d54 = 111;
    }
    visionset_mgr::register_info("overlay", "zm_bgb_now_you_see_me", 1, level.var_9cfc6d54, 1, 1);
}

// Namespace zm_bgb_now_you_see_me
// Params 0, eflags: 0x1 linked
// Checksum 0xc8dca0e6, Offset: 0x3f0
// Size: 0x34
function validation() {
    return !(isdefined(self bgb::get_active()) && self bgb::get_active());
}

// Namespace zm_bgb_now_you_see_me
// Params 0, eflags: 0x1 linked
// Checksum 0x6a0e9869, Offset: 0x430
// Size: 0x1c8
function activation() {
    self endon(#"disconnect");
    self.b_is_designated_target = 1;
    self thread bgb::run_timer(10);
    self playsound("zmb_bgb_nysm_start");
    self playloopsound("zmb_bgb_nysm_loop", 1);
    visionset_mgr::activate("visionset", "zm_bgb_now_you_see_me", self, 0.5, 9, 0.5);
    visionset_mgr::activate("overlay", "zm_bgb_now_you_see_me", self);
    ret = self util::waittill_any_timeout(9.5, "bgb_about_to_take_on_bled_out", "end_game", "bgb_update", "disconnect");
    self stoploopsound(1);
    self playsound("zmb_bgb_nysm_end");
    if ("timeout" != ret) {
        visionset_mgr::deactivate("visionset", "zm_bgb_now_you_see_me", self);
    } else {
        wait 0.5;
    }
    visionset_mgr::deactivate("overlay", "zm_bgb_now_you_see_me", self);
    self.b_is_designated_target = 0;
}

