#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace _gadget_overdrive;

// Namespace _gadget_overdrive
// Params 0, eflags: 0x2
// Checksum 0xa4d5624, Offset: 0x3f8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_overdrive", &__init__, undefined, undefined);
}

// Namespace _gadget_overdrive
// Params 0, eflags: 0x0
// Checksum 0x6c8159d9, Offset: 0x438
// Size: 0xd4
function __init__() {
    callback::on_localclient_connect(&on_player_connect);
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    callback::on_localclient_shutdown(&on_localplayer_shutdown);
    clientfield::register("toplayer", "overdrive_state", 1, 1, "int", &function_6c1d8418, 0, 1);
    visionset_mgr::register_visionset_info("overdrive", 1, 15, undefined, "overdrive_initialize");
}

// Namespace _gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0x987d8de2, Offset: 0x518
// Size: 0x24
function on_localplayer_shutdown(localclientnum) {
    self function_8e10aa46(localclientnum);
}

// Namespace _gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0x1f8814c4, Offset: 0x548
// Size: 0x6c
function on_localplayer_spawned(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    filter::function_1f1af853(self);
    filter::function_d17703cb(self, 3);
    disablespeedblur(localclientnum);
}

// Namespace _gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0x47f48451, Offset: 0x5c0
// Size: 0xc
function on_player_connect(local_client_num) {
    
}

// Namespace _gadget_overdrive
// Params 7, eflags: 0x0
// Checksum 0x3a5806b7, Offset: 0x5d8
// Size: 0x20c
function function_6c1d8418(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.localplayers[localclientnum]) && (!self islocalplayer() || isspectating(localclientnum, 0) || self getentitynumber() != level.localplayers[localclientnum] getentitynumber())) {
        return;
    }
    if (newval != oldval && newval) {
        enablespeedblur(localclientnum, getdvarfloat("scr_overdrive_amount", 0.15), getdvarfloat("scr_overdrive_inner_radius", 0.6), getdvarfloat("scr_overdrive_outer_radius", 1), getdvarint("scr_overdrive_velShouldScale", 1), getdvarint("scr_overdrive_velScale", -36));
        filter::function_46839542(self, 3);
        self usealternateaimparams();
        self thread function_435df4ae(localclientnum);
        self function_7f9030dd(localclientnum);
        return;
    }
    if (newval != oldval && !newval) {
        self function_8e10aa46(localclientnum);
    }
}

// Namespace _gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0xd920f6e5, Offset: 0x7f0
// Size: 0x146
function function_435df4ae(localclientnum) {
    self notify(#"hash_435df4ae");
    self endon(#"hash_435df4ae");
    self endon(#"death");
    self endon(#"entityshutdown");
    self endon(#"stop_player_fx");
    self endon(#"disable_cybercom");
    self.var_e9fb6bcc = 1;
    lui::screen_fade(getdvarfloat("scr_overdrive_flash_fade_in_time", 0.075), getdvarfloat("scr_overdrive_flash_alpha", 0.7), 0, "white");
    wait getdvarfloat("scr_overdrive_flash_fade_in_time", 0.075);
    lui::screen_fade(getdvarfloat("scr_overdrive_flash_fade_out_time", 0.45), 0, getdvarfloat("scr_overdrive_flash_alpha", 0.7), "white");
    self.var_e9fb6bcc = undefined;
}

// Namespace _gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0xd6d4c26b, Offset: 0x940
// Size: 0x8c
function function_f8cd963(localclientnum) {
    if (isdefined(self.var_f913815c)) {
        stopfx(localclientnum, self.var_f913815c);
        self.var_f913815c = undefined;
    }
    self.var_f913815c = playfxoncamera(localclientnum, "player/fx_plyr_ability_screen_blur_overdrive", (0, 0, 0), (1, 0, 0), (0, 0, 1));
    self thread function_795d8024(localclientnum, self.var_f913815c);
}

// Namespace _gadget_overdrive
// Params 2, eflags: 0x0
// Checksum 0xeef4f843, Offset: 0x9d8
// Size: 0x96
function function_795d8024(localclientnum, fx) {
    self notify(#"hash_795d8024");
    self endon(#"hash_795d8024");
    self endon(#"entityshutdown");
    self util::waittill_any("stop_player_fx", "death", "disable_cybercom");
    if (isdefined(fx)) {
        stopfx(localclientnum, fx);
        self.var_f913815c = undefined;
    }
}

// Namespace _gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0x48452796, Offset: 0xa78
// Size: 0x8c
function function_26d7266e(localclientnum) {
    self notify(#"stop_player_fx");
    if (isdefined(self.var_e9fb6bcc) && self.var_e9fb6bcc) {
        lui::screen_fade(getdvarfloat("scr_overdrive_flash_fade_out_time", 0.45), 0, getdvarfloat("scr_overdrive_flash_alpha", 0.7), "white");
    }
}

// Namespace _gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0xa37afb7d, Offset: 0xb10
// Size: 0x6c
function function_2e0c658b(localclientnum) {
    self endon(#"hash_2e0c658b");
    self endon(#"hash_6cc6e004");
    self endon(#"entityshutdown");
    self util::waittill_any("death", "disable_cybercom");
    self function_8e10aa46(localclientnum);
}

// Namespace _gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0xc8707e66, Offset: 0xb88
// Size: 0x82
function function_8e10aa46(localclientnum) {
    if (isdefined(localclientnum)) {
        self function_26d7266e(localclientnum);
        self clearalternateaimparams();
        filter::function_d17703cb(self, 3);
        disablespeedblur(localclientnum);
        self notify(#"hash_6cc6e004");
    }
}

// Namespace _gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0x924a16ff, Offset: 0xc18
// Size: 0x1c8
function function_7f9030dd(localclientnum) {
    self endon(#"disable_cybercom");
    self endon(#"death");
    self endon(#"hash_6cc6e004");
    self endon(#"disconnect");
    self function_f8cd963(localclientnum);
    self thread function_2e0c658b(localclientnum);
    wait getdvarfloat("scr_overdrive_boost_fx_time", 0.75);
    while (isdefined(self)) {
        v_player_velocity = self getvelocity();
        v_player_forward = anglestoforward(self.angles);
        n_dot = vectordot(vectornormalize(v_player_velocity), v_player_forward);
        n_speed = length(v_player_velocity);
        if (n_speed >= getdvarint("scr_overdrive_boost_speed_tol", 280) && n_dot > 0.8) {
            if (!isdefined(self.var_f913815c)) {
                self function_f8cd963(localclientnum);
            }
        } else if (isdefined(self.var_f913815c)) {
            self function_26d7266e(localclientnum);
        }
        wait 0.016;
    }
}

