#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_unstoppable_force;

// Namespace _gadget_unstoppable_force
// Params 0, eflags: 0x2
// Checksum 0x8a3ac9eb, Offset: 0x400
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_unstoppable_force", &__init__, undefined, undefined);
}

// Namespace _gadget_unstoppable_force
// Params 0, eflags: 0x0
// Checksum 0x696b3347, Offset: 0x440
// Size: 0x6c
function __init__() {
    callback::on_localclient_shutdown(&on_localplayer_shutdown);
    clientfield::register("toplayer", "unstoppableforce_state", 1, 1, "int", &function_8f92edb4, 0, 1);
}

// Namespace _gadget_unstoppable_force
// Params 1, eflags: 0x0
// Checksum 0x4601b7b, Offset: 0x4b8
// Size: 0x24
function on_localplayer_shutdown(localclientnum) {
    function_26d7266e(localclientnum);
}

// Namespace _gadget_unstoppable_force
// Params 7, eflags: 0x0
// Checksum 0xd388cba4, Offset: 0x4e8
// Size: 0x202
function function_8f92edb4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.localplayers[localclientnum]) && (!self islocalplayer() || isspectating(localclientnum, 0) || self getentitynumber() != level.localplayers[localclientnum] getentitynumber())) {
        return;
    }
    if (newval != oldval && newval) {
        enablespeedblur(localclientnum, getdvarfloat("scr_unstoppableforce_amount", 0.15), getdvarfloat("scr_unstoppableforce_inner_radius", 0.6), getdvarfloat("scr_unstoppableforce_outer_radius", 1), getdvarint("scr_unstoppableforce_velShouldScale", 1), getdvarint("scr_unstoppableforce_velScale", -36));
        self thread function_435df4ae(localclientnum);
        self function_7f9030dd(localclientnum);
        return;
    }
    if (newval != oldval && !newval) {
        self function_26d7266e(localclientnum);
        disablespeedblur(localclientnum);
        self notify(#"hash_82017c20");
    }
}

// Namespace _gadget_unstoppable_force
// Params 1, eflags: 0x0
// Checksum 0x3f45a0ba, Offset: 0x6f8
// Size: 0x11c
function function_435df4ae(localclientnum) {
    self util::waittill_any_timeout(getdvarfloat("scr_unstoppableforce_activation_delay", 0.35), "unstoppableforce_arm_cross_end");
    lui::screen_fade(getdvarfloat("scr_unstoppableforce_flash_fade_in_time", 0.075), getdvarfloat("scr_unstoppableforce_flash_alpha", 0.6), 0, "white");
    wait getdvarfloat("scr_unstoppableforce_flash_fade_in_time", 0.075);
    lui::screen_fade(getdvarfloat("scr_unstoppableforce_flash_fade_out_time", 0.9), 0, getdvarfloat("scr_unstoppableforce_flash_alpha", 0.6), "white");
}

// Namespace _gadget_unstoppable_force
// Params 1, eflags: 0x0
// Checksum 0x36d6bd01, Offset: 0x820
// Size: 0x3c
function function_f8cd963(localclientnum) {
    self.var_5b712cc2 = playfxoncamera(localclientnum, "player/fx_plyr_ability_screen_blur_overdrive", (0, 0, 0), (1, 0, 0), (0, 0, 1));
}

// Namespace _gadget_unstoppable_force
// Params 1, eflags: 0x0
// Checksum 0xad92a861, Offset: 0x868
// Size: 0x3e
function function_26d7266e(localclientnum) {
    if (isdefined(self.var_5b712cc2)) {
        stopfx(localclientnum, self.var_5b712cc2);
        self.var_5b712cc2 = undefined;
    }
}

// Namespace _gadget_unstoppable_force
// Params 1, eflags: 0x0
// Checksum 0xd6d4fab3, Offset: 0x8b0
// Size: 0x62
function function_4ba988e2(localclientnum) {
    self endon(#"hash_82017c20");
    self util::waittill_any("disable_cybercom", "death");
    function_26d7266e(localclientnum);
    self notify(#"hash_82017c20");
}

// Namespace _gadget_unstoppable_force
// Params 1, eflags: 0x0
// Checksum 0xb760393a, Offset: 0x920
// Size: 0x190
function function_7f9030dd(localclientnum) {
    self endon(#"disable_cybercom");
    self endon(#"death");
    self endon(#"hash_82017c20");
    self endon(#"disconnect");
    self thread function_4ba988e2(localclientnum);
    while (isdefined(self)) {
        v_player_velocity = self getvelocity();
        v_player_forward = anglestoforward(self.angles);
        n_dot = vectordot(vectornormalize(v_player_velocity), v_player_forward);
        n_speed = length(v_player_velocity);
        if (n_speed >= getdvarint("scr_unstoppableforce_boost_speed_tol", 320) && n_dot > 0.8) {
            if (!isdefined(self.var_5b712cc2)) {
                self function_f8cd963(localclientnum);
            }
        } else if (isdefined(self.var_5b712cc2)) {
            self function_26d7266e(localclientnum);
        }
        wait 0.016;
    }
}

