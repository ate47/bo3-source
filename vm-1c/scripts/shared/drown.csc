#using scripts/shared/math_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace drown;

// Namespace drown
// Params 0, eflags: 0x2
// Checksum 0xa963c19b, Offset: 0x220
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("drown", &__init__, undefined, undefined);
}

// Namespace drown
// Params 0, eflags: 0x1 linked
// Checksum 0x840f6871, Offset: 0x260
// Size: 0x17c
function __init__() {
    clientfield::register("toplayer", "drown_stage", 1, 3, "int", &drown_stage_callback, 0, 0);
    callback::on_localplayer_spawned(&player_spawned);
    level.playermaxhealth = getgametypesetting("playerMaxHealth");
    level.var_f9e80709 = getdvarfloat("player_swimDamagerInterval", 5000) * 1000;
    level.var_fa013947 = getdvarfloat("player_swimDamage", 5000);
    level.var_e7798ae7 = getdvarfloat("player_swimTime", 5000) * 1000;
    level.var_7100629e = level.playermaxhealth / level.var_fa013947 * level.var_f9e80709 + 2000;
    visionset_mgr::register_overlay_info_style_speed_blur("drown_blur", 1, 1, 0.04, 1, 1, 0, 0, 125, 125, 0);
    setup_radius_values();
}

// Namespace drown
// Params 0, eflags: 0x1 linked
// Checksum 0x78e0d25, Offset: 0x3e8
// Size: 0x3c0
function setup_radius_values() {
    level.drown_radius["inner"]["begin"][1] = 0.8;
    level.drown_radius["inner"]["begin"][2] = 0.6;
    level.drown_radius["inner"]["begin"][3] = 0.6;
    level.drown_radius["inner"]["begin"][4] = 0.5;
    level.drown_radius["inner"]["end"][1] = 0.5;
    level.drown_radius["inner"]["end"][2] = 0.3;
    level.drown_radius["inner"]["end"][3] = 0.3;
    level.drown_radius["inner"]["end"][4] = 0.2;
    level.drown_radius["outer"]["begin"][1] = 1;
    level.drown_radius["outer"]["begin"][2] = 0.8;
    level.drown_radius["outer"]["begin"][3] = 0.8;
    level.drown_radius["outer"]["begin"][4] = 0.7;
    level.drown_radius["outer"]["end"][1] = 0.8;
    level.drown_radius["outer"]["end"][2] = 0.6;
    level.drown_radius["outer"]["end"][3] = 0.6;
    level.drown_radius["outer"]["end"][4] = 0.5;
    level.opacity["begin"][1] = 0.4;
    level.opacity["begin"][2] = 0.5;
    level.opacity["begin"][3] = 0.6;
    level.opacity["begin"][4] = 0.6;
    level.opacity["end"][1] = 0.5;
    level.opacity["end"][2] = 0.6;
    level.opacity["end"][3] = 0.7;
    level.opacity["end"][4] = 0.7;
}

// Namespace drown
// Params 1, eflags: 0x1 linked
// Checksum 0x526a1f7f, Offset: 0x7b0
// Size: 0x54
function player_spawned(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    self player_init_drown_values();
    self thread player_watch_drown_shutdown(localclientnum);
}

// Namespace drown
// Params 0, eflags: 0x1 linked
// Checksum 0x39402047, Offset: 0x810
// Size: 0x40
function player_init_drown_values() {
    if (!isdefined(self.drown_start_time)) {
        self.drown_start_time = 0;
        self.drown_outerradius = 0;
        self.drown_innerradius = 0;
        self.drown_opacity = 0;
    }
}

// Namespace drown
// Params 1, eflags: 0x1 linked
// Checksum 0x87be34c2, Offset: 0x858
// Size: 0x4c
function player_watch_drown_shutdown(localclientnum) {
    self util::waittill_any("entityshutdown", "death");
    self disable_drown(localclientnum);
}

// Namespace drown
// Params 2, eflags: 0x1 linked
// Checksum 0xd41a63c, Offset: 0x8b0
// Size: 0x9c
function enable_drown(localclientnum, stage) {
    filter::init_filter_drowning_damage(localclientnum);
    filter::enable_filter_drowning_damage(localclientnum, 1);
    self.drown_start_time = getservertime(localclientnum) - (stage - 1) * level.var_f9e80709;
    self.drown_outerradius = 0;
    self.drown_innerradius = 0;
    self.drown_opacity = 0;
}

// Namespace drown
// Params 1, eflags: 0x1 linked
// Checksum 0x577fe723, Offset: 0x958
// Size: 0x24
function disable_drown(localclientnum) {
    filter::disable_filter_drowning_damage(localclientnum, 1);
}

// Namespace drown
// Params 2, eflags: 0x1 linked
// Checksum 0xf743e8f6, Offset: 0x988
// Size: 0x2c8
function player_drown_fx(localclientnum, stage) {
    self endon(#"death");
    self endon(#"entityshutdown");
    self endon(#"player_fade_out_drown_fx");
    self notify(#"player_drown_fx");
    self endon(#"player_drown_fx");
    self player_init_drown_values();
    lastoutwatertimestage = self.drown_start_time + (stage - 1) * level.var_f9e80709;
    stageduration = level.var_f9e80709;
    if (stage == 1) {
        stageduration = 2000;
    }
    while (true) {
        currenttime = getservertime(localclientnum);
        elapsedtime = currenttime - self.drown_start_time;
        stageratio = math::clamp((currenttime - lastoutwatertimestage) / stageduration, 0, 1);
        self.drown_outerradius = lerpfloat(level.drown_radius["outer"]["begin"][stage], level.drown_radius["outer"]["end"][stage], stageratio) * 1.41421;
        self.drown_innerradius = lerpfloat(level.drown_radius["inner"]["begin"][stage], level.drown_radius["inner"]["end"][stage], stageratio) * 1.41421;
        self.drown_opacity = lerpfloat(level.opacity["begin"][stage], level.opacity["end"][stage], stageratio);
        filter::set_filter_drowning_damage_inner_radius(localclientnum, 1, self.drown_innerradius);
        filter::set_filter_drowning_damage_outer_radius(localclientnum, 1, self.drown_outerradius);
        filter::set_filter_drowning_damage_opacity(localclientnum, 1, self.drown_opacity);
        wait 0.016;
    }
}

// Namespace drown
// Params 1, eflags: 0x1 linked
// Checksum 0xeba819f9, Offset: 0xc58
// Size: 0x1f4
function player_fade_out_drown_fx(localclientnum) {
    self endon(#"death");
    self endon(#"entityshutdown");
    self endon(#"player_drown_fx");
    self notify(#"player_fade_out_drown_fx");
    self endon(#"player_fade_out_drown_fx");
    self player_init_drown_values();
    fadestarttime = getservertime(localclientnum);
    for (currenttime = getservertime(localclientnum); currenttime - fadestarttime < -6; currenttime = getservertime(localclientnum)) {
        ratio = (currenttime - fadestarttime) / -6;
        outerradius = lerpfloat(self.drown_outerradius, 1.41421, ratio);
        innerradius = lerpfloat(self.drown_innerradius, 1.41421, ratio);
        opacity = lerpfloat(self.drown_opacity, 0, ratio);
        filter::set_filter_drowning_damage_outer_radius(localclientnum, 1, outerradius);
        filter::set_filter_drowning_damage_inner_radius(localclientnum, 1, innerradius);
        filter::set_filter_drowning_damage_opacity(localclientnum, 1, opacity);
        wait 0.016;
    }
    self disable_drown(localclientnum);
}

// Namespace drown
// Params 7, eflags: 0x1 linked
// Checksum 0x51b7e3d, Offset: 0xe58
// Size: 0xcc
function drown_stage_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval > 0) {
        self enable_drown(localclientnum, newval);
        self thread player_drown_fx(localclientnum, newval);
        return;
    }
    if (!bnewent) {
        self thread player_fade_out_drown_fx(localclientnum);
        return;
    }
    self disable_drown(localclientnum);
}

