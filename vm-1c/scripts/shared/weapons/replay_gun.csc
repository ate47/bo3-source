#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_6ba28cbf;

// Namespace namespace_6ba28cbf
// Params 0, eflags: 0x2
// namespace_6ba28cbf<file_0>::function_2dc19561
// Checksum 0x2fa347fc, Offset: 0x1c0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("replay_gun", &__init__, undefined, undefined);
}

// Namespace namespace_6ba28cbf
// Params 0, eflags: 0x1 linked
// namespace_6ba28cbf<file_0>::function_8c87d8eb
// Checksum 0xc7683596, Offset: 0x200
// Size: 0x4c
function __init__() {
    level thread player_init();
    duplicate_render::set_dr_filter_offscreen("replay", 75, "replay_locked", undefined, 2, "mc/hud_outline_model_red", 0);
}

// Namespace namespace_6ba28cbf
// Params 0, eflags: 0x1 linked
// namespace_6ba28cbf<file_0>::function_536049a7
// Checksum 0x22f3e668, Offset: 0x258
// Size: 0xc2
function player_init() {
    util::waitforclient(0);
    players = getlocalplayers();
    foreach (player in players) {
        player thread watch_lockon(0);
    }
}

// Namespace namespace_6ba28cbf
// Params 1, eflags: 0x1 linked
// namespace_6ba28cbf<file_0>::function_3a723e07
// Checksum 0xd0edc5dc, Offset: 0x328
// Size: 0x176
function watch_lockon(localclientnum) {
    while (true) {
        state, target = self waittill(#"lockon_changed");
        if (!isdefined(target) || isdefined(self.replay_lock) && self.replay_lock != target) {
            self.replay_lock duplicate_render::change_dr_flags(localclientnum, undefined, "replay_locked");
            self.replay_lock = undefined;
        }
        if ((target isplayer() || isdefined(target) && target isai()) && isalive(target)) {
            switch (state) {
            case 0:
            case 1:
            case 3:
                target duplicate_render::change_dr_flags(localclientnum, undefined, "replay_locked");
                break;
            case 2:
            case 4:
                target duplicate_render::change_dr_flags(localclientnum, "replay_locked", undefined);
                self.replay_lock = target;
                break;
            }
        }
    }
}

