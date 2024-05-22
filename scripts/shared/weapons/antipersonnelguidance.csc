#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace antipersonnel_guidance;

// Namespace antipersonnel_guidance
// Params 0, eflags: 0x2
// Checksum 0x391d5cdf, Offset: 0x1d0
// Size: 0x34
function function_2dc19561() {
    system::register("antipersonnel_guidance", &__init__, undefined, undefined);
}

// Namespace antipersonnel_guidance
// Params 0, eflags: 0x1 linked
// Checksum 0xf734480, Offset: 0x210
// Size: 0x4c
function __init__() {
    level thread player_init();
    duplicate_render::set_dr_filter_offscreen("ap", 75, "ap_locked", undefined, 2, "mc/hud_outline_model_red", 0);
}

// Namespace antipersonnel_guidance
// Params 0, eflags: 0x1 linked
// Checksum 0x3d39523a, Offset: 0x268
// Size: 0xc2
function player_init() {
    util::waitforclient(0);
    players = getlocalplayers();
    foreach (player in players) {
        player thread watch_lockon(0);
    }
}

// Namespace antipersonnel_guidance
// Params 1, eflags: 0x1 linked
// Checksum 0x52dee59b, Offset: 0x338
// Size: 0x126
function watch_lockon(localclientnum) {
    while (true) {
        state, target = self waittill(#"lockon_changed");
        if (!isdefined(target) || isdefined(self.replay_lock) && self.replay_lock != target) {
            self.ap_lock duplicate_render::change_dr_flags(localclientnum, undefined, "ap_locked");
            self.ap_lock = undefined;
        }
        switch (state) {
        case 0:
        case 1:
        case 3:
            target duplicate_render::change_dr_flags(localclientnum, undefined, "ap_locked");
            break;
        case 2:
        case 4:
            target duplicate_render::change_dr_flags(localclientnum, "ap_locked", undefined);
            self.ap_lock = target;
            break;
        }
    }
}

