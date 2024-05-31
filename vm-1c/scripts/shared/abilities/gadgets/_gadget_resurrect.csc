#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/postfx_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/system_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_755d6e1c;

// Namespace namespace_755d6e1c
// Params 0, eflags: 0x2
// namespace_755d6e1c<file_0>::function_2dc19561
// Checksum 0xdff43c91, Offset: 0x2f0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_resurrect", &__init__, undefined, undefined);
}

// Namespace namespace_755d6e1c
// Params 0, eflags: 0x1 linked
// namespace_755d6e1c<file_0>::function_8c87d8eb
// Checksum 0x49398cdb, Offset: 0x330
// Size: 0x114
function __init__() {
    clientfield::register("allplayers", "resurrecting", 1, 1, "int", &function_5563c64b, 0, 1);
    clientfield::register("toplayer", "resurrect_state", 1, 2, "int", &function_294dfc4d, 0, 1);
    duplicate_render::set_dr_filter_offscreen("resurrecting", 99, "resurrecting", undefined, 2, "mc/hud_keyline_resurrect", 0);
    visionset_mgr::register_visionset_info("resurrect", 1, 16, undefined, "mp_ability_resurrection");
    visionset_mgr::register_visionset_info("resurrect_up", 1, 16, undefined, "mp_ability_wakeup");
}

// Namespace namespace_755d6e1c
// Params 7, eflags: 0x1 linked
// namespace_755d6e1c<file_0>::function_5563c64b
// Checksum 0x6589ad80, Offset: 0x450
// Size: 0x64
function function_5563c64b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self duplicate_render::update_dr_flag(localclientnum, "resurrecting", newval);
}

// Namespace namespace_755d6e1c
// Params 1, eflags: 0x1 linked
// namespace_755d6e1c<file_0>::function_e4115bce
// Checksum 0x9c7b59f, Offset: 0x4c0
// Size: 0x64
function function_e4115bce(localclientnum) {
    self endon(#"entityshutdown");
    self endon(#"hash_26d531a9");
    self thread postfx::playpostfxbundle("pstfx_resurrection_close");
    wait(0.5);
    self thread postfx::playpostfxbundle("pstfx_resurrection_pus");
}

// Namespace namespace_755d6e1c
// Params 1, eflags: 0x1 linked
// namespace_755d6e1c<file_0>::function_ec525b13
// Checksum 0xf86bbc03, Offset: 0x530
// Size: 0x3c
function function_ec525b13(localclientnum) {
    self endon(#"entityshutdown");
    self notify(#"hash_26d531a9");
    self thread postfx::playpostfxbundle("pstfx_resurrection_open");
}

// Namespace namespace_755d6e1c
// Params 7, eflags: 0x1 linked
// namespace_755d6e1c<file_0>::function_294dfc4d
// Checksum 0xd1e9cc35, Offset: 0x578
// Size: 0xa4
function function_294dfc4d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self thread function_e4115bce(localclientnum);
        return;
    }
    if (newval == 2) {
        self thread function_ec525b13(localclientnum);
        return;
    }
    self thread postfx::stoppostfxbundle();
}

