#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_oed;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/filter_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicles/_quadtank;
#using scripts/shared/weapons/spike_charge;

#namespace arena_defend;

// Namespace arena_defend
// Params 0, eflags: 0x2
// Checksum 0x636639ef, Offset: 0x340
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("arena_defend", &__init__, undefined, undefined);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x2791f26c, Offset: 0x378
// Size: 0x32
function __init__() {
    init_clientfields();
    callback::on_localclient_connect(&on_player_connect);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xd5765977, Offset: 0x3b8
// Size: 0xaa
function init_clientfields() {
    clientfield::register("scriptmover", "arena_defend_weak_point_keyline", 1, 1, "int", &function_a2296301, 0, 0);
    clientfield::register("world", "clear_all_dyn_ents", 1, 1, "counter", &function_37cf9477, 0, 0);
    clientfield::register("toplayer", "set_dedicated_shadow", 1, 1, "int", &function_a40e70b2, 0, 0);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x70dc5a7a, Offset: 0x470
// Size: 0x3a
function on_player_connect(localclientnum) {
    duplicate_render::set_dr_filter_offscreen("weakpoint_keyline", 100, "weakpoint_keyline_show_z", "weakpoint_keyline_hide_z", 2, "mc/hud_outline_model_z_orange", 1);
}

// Namespace arena_defend
// Params 7, eflags: 0x0
// Checksum 0x93a8d2b, Offset: 0x4b8
// Size: 0x122
function function_a2296301(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self duplicate_render::change_dr_flags(localclientnum, "weakpoint_keyline_show_z", "weakpoint_keyline_hide_z");
        self tmodesetflag(3);
        self weakpoint_enable(1);
        if (self.model == "wpn_t7_spike_launcher_projectile_var") {
            self thread function_cbf697f5(localclientnum);
        }
        return;
    }
    self duplicate_render::change_dr_flags(localclientnum, "weakpoint_keyline_hide_z", "weakpoint_keyline_show_z");
    self tmodeclearflag(3);
    self weakpoint_enable(0);
    if (self.model == "wpn_t7_spike_launcher_projectile_var") {
        self notify(#"light_disable");
        self stop_light_fx(localclientnum);
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xe307f514, Offset: 0x5e8
// Size: 0xc7
function function_cbf697f5(localclientnum) {
    self notify(#"light_disable");
    self endon(#"entityshutdown");
    self endon(#"light_disable");
    self util::waittill_dobj(localclientnum);
    for (n_interval = 0.3; ; n_interval = math::clamp(n_interval / 1.2, 0.08, 0.3)) {
        self stop_light_fx(localclientnum);
        self start_light_fx(localclientnum);
        util::server_wait(localclientnum, n_interval, 0.01, "player_switch");
        self util::waittill_dobj(localclientnum);
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x1781e558, Offset: 0x6b8
// Size: 0x62
function start_light_fx(localclientnum) {
    var_5c632d10 = self gettagorigin("tag_fx") + (0, 0, 4);
    self.fx = playfx(localclientnum, level._effect["spike_light"], var_5c632d10);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xe7b70296, Offset: 0x728
// Size: 0x41
function stop_light_fx(localclientnum) {
    if (isdefined(self.fx) && self.fx != 0) {
        stopfx(localclientnum, self.fx);
        self.fx = undefined;
    }
}

// Namespace arena_defend
// Params 7, eflags: 0x0
// Checksum 0xcb76cfd3, Offset: 0x778
// Size: 0xd3
function function_37cf9477(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        cleanupspawneddynents();
        var_f47aa4cf = getdynentarray("arena_defend_dyn_ents");
        foreach (ent in var_f47aa4cf) {
            setdynentenabled(ent, 0);
        }
    }
}

// Namespace arena_defend
// Params 7, eflags: 0x0
// Checksum 0x97ca6e21, Offset: 0x858
// Size: 0x6a
function function_a40e70b2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self setdedicatedshadow(1);
        return;
    }
    self setdedicatedshadow(0);
}

