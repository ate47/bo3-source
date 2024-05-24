#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_d5190444;

// Namespace namespace_d5190444
// Params 0, eflags: 0x2
// Checksum 0xf41d3d08, Offset: 0x228
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_idle_eyes", &__init__, undefined, "bgb");
}

// Namespace namespace_d5190444
// Params 0, eflags: 0x1 linked
// Checksum 0x694762a0, Offset: 0x268
// Size: 0x144
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_idle_eyes", "activated", 3, undefined, undefined, &validation, &activation);
    bgb::function_4cda71bf("zm_bgb_idle_eyes", 1);
    bgb::function_336ffc4e("zm_bgb_idle_eyes");
    if (!isdefined(level.var_c2d3ebc0)) {
        level.var_c2d3ebc0 = 112;
    }
    visionset_mgr::register_info("visionset", "zm_bgb_idle_eyes", 1, level.var_c2d3ebc0, 31, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
    if (!isdefined(level.var_384c0a48)) {
        level.var_384c0a48 = 112;
    }
    visionset_mgr::register_info("overlay", "zm_bgb_idle_eyes", 1, level.var_384c0a48, 1, 1);
}

// Namespace namespace_d5190444
// Params 0, eflags: 0x1 linked
// Checksum 0x1689cc01, Offset: 0x3b8
// Size: 0x34
function validation() {
    return !(isdefined(self bgb::get_active()) && self bgb::get_active());
}

// Namespace namespace_d5190444
// Params 0, eflags: 0x1 linked
// Checksum 0xd30de441, Offset: 0x3f8
// Size: 0x29c
function activation() {
    self endon(#"disconnect");
    var_7092e170 = arraycopy(level.activeplayers);
    array::thread_all(var_7092e170, &zm_utility::function_139befeb);
    self.var_ebe6eb3d = 1;
    if (!bgb::increment_ref_count("zm_bgb_idle_eyes")) {
        if (isdefined(level.no_target_override)) {
            if (!isdefined(level.var_4effcea9)) {
                level.var_4effcea9 = level.no_target_override;
            }
            level.no_target_override = undefined;
        }
    }
    level thread function_1f57344e(self, var_7092e170);
    self playsound("zmb_bgb_idleeyes_start");
    self playloopsound("zmb_bgb_idleeyes_loop", 1);
    self thread bgb::run_timer(31);
    visionset_mgr::activate("visionset", "zm_bgb_idle_eyes", self, 0.5, 30, 0.5);
    visionset_mgr::activate("overlay", "zm_bgb_idle_eyes", self);
    ret = self util::waittill_any_timeout(30.5, "bgb_about_to_take_on_bled_out", "end_game", "bgb_update", "disconnect");
    self stoploopsound(1);
    self playsound("zmb_bgb_idleeyes_end");
    if ("timeout" != ret) {
        visionset_mgr::deactivate("visionset", "zm_bgb_idle_eyes", self);
    } else {
        wait(0.5);
    }
    visionset_mgr::deactivate("overlay", "zm_bgb_idle_eyes", self);
    self.var_ebe6eb3d = undefined;
    self notify(#"hash_16ab3604");
    deactivate(var_7092e170);
}

// Namespace namespace_d5190444
// Params 2, eflags: 0x1 linked
// Checksum 0xbff2a7b7, Offset: 0x6a0
// Size: 0x44
function function_1f57344e(var_e04844d6, var_7092e170) {
    var_e04844d6 endon(#"hash_16ab3604");
    var_e04844d6 waittill(#"disconnect");
    deactivate(var_7092e170);
}

// Namespace namespace_d5190444
// Params 1, eflags: 0x1 linked
// Checksum 0x709c25e3, Offset: 0x6f0
// Size: 0x8e
function deactivate(var_7092e170) {
    var_7092e170 = array::remove_undefined(var_7092e170);
    array::thread_all(var_7092e170, &zm_utility::function_36f941b3);
    if (bgb::decrement_ref_count("zm_bgb_idle_eyes")) {
        return;
    }
    if (isdefined(level.var_4effcea9)) {
        level.no_target_override = level.var_4effcea9;
        level.var_4effcea9 = undefined;
    }
}

