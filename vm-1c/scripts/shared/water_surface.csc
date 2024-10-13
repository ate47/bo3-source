#using scripts/shared/util_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace water_surface;

// Namespace water_surface
// Params 0, eflags: 0x2
// Checksum 0xe5937b7, Offset: 0x1c8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("water_surface", &__init__, undefined, undefined);
}

// Namespace water_surface
// Params 0, eflags: 0x1 linked
// Checksum 0xf3d74054, Offset: 0x208
// Size: 0x7c
function __init__() {
    level._effect["water_player_jump_in"] = "player/fx_plyr_water_jump_in_bubbles_1p";
    level._effect["water_player_jump_out"] = "player/fx_plyr_water_jump_out_splash_1p";
    if (isdefined(level.disablewatersurfacefx) && level.disablewatersurfacefx == 1) {
        return;
    }
    callback::on_localplayer_spawned(&localplayer_spawned);
}

// Namespace water_surface
// Params 1, eflags: 0x1 linked
// Checksum 0xcab3eff, Offset: 0x290
// Size: 0xd4
function localplayer_spawned(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    if (isdefined(level.disablewatersurfacefx) && level.disablewatersurfacefx == 1) {
        return;
    }
    filter::init_filter_water_sheeting(self);
    filter::init_filter_water_dive(self);
    self thread underwaterwatchbegin();
    self thread underwaterwatchend();
    filter::disable_filter_water_sheeting(self, 1);
    stop_player_fx(self);
}

// Namespace water_surface
// Params 0, eflags: 0x1 linked
// Checksum 0x68b8f1f0, Offset: 0x370
// Size: 0xd0
function underwaterwatchbegin() {
    self notify(#"underwaterwatchbegin");
    self endon(#"underwaterwatchbegin");
    self endon(#"entityshutdown");
    while (true) {
        teleported = self waittill(#"underwater_begin");
        if (teleported) {
            filter::disable_filter_water_sheeting(self, 1);
            stop_player_fx(self);
            filter::disable_filter_water_dive(self, 1);
            stop_player_fx(self);
            continue;
        }
        self thread underwaterbegin();
    }
}

// Namespace water_surface
// Params 0, eflags: 0x1 linked
// Checksum 0xa38ac746, Offset: 0x448
// Size: 0xd0
function underwaterwatchend() {
    self notify(#"underwaterwatchend");
    self endon(#"underwaterwatchend");
    self endon(#"entityshutdown");
    while (true) {
        teleported = self waittill(#"underwater_end");
        if (teleported) {
            filter::disable_filter_water_sheeting(self, 1);
            stop_player_fx(self);
            filter::disable_filter_water_dive(self, 1);
            stop_player_fx(self);
            continue;
        }
        self thread underwaterend();
    }
}

// Namespace water_surface
// Params 0, eflags: 0x1 linked
// Checksum 0xf4984de9, Offset: 0x520
// Size: 0x114
function underwaterbegin() {
    self notify(#"water_surface_underwater_begin");
    self endon(#"water_surface_underwater_begin");
    self endon(#"entityshutdown");
    localclientnum = self getlocalclientnumber();
    filter::disable_filter_water_sheeting(self, 1);
    stop_player_fx(self);
    if (islocalclientdead(localclientnum) == 0) {
        self.firstperson_water_fx = playfxoncamera(localclientnum, level._effect["water_player_jump_in"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        if (!isdefined(self.playingpostfxbundle) || self.playingpostfxbundle != "pstfx_watertransition") {
            self thread postfx::playpostfxbundle("pstfx_watertransition");
        }
    }
}

// Namespace water_surface
// Params 0, eflags: 0x1 linked
// Checksum 0xd40a9332, Offset: 0x640
// Size: 0xa4
function underwaterend() {
    self notify(#"water_surface_underwater_end");
    self endon(#"water_surface_underwater_end");
    self endon(#"entityshutdown");
    localclientnum = self getlocalclientnumber();
    if (islocalclientdead(localclientnum) == 0) {
        if (!isdefined(self.playingpostfxbundle) || self.playingpostfxbundle != "pstfx_water_t_out") {
            self thread postfx::playpostfxbundle("pstfx_water_t_out");
        }
    }
}

// Namespace water_surface
// Params 0, eflags: 0x0
// Checksum 0x4f941d8d, Offset: 0x6f0
// Size: 0x24a
function startwaterdive() {
    filter::enable_filter_water_dive(self, 1);
    filter::set_filter_water_scuba_dive_speed(self, 1, 0.25);
    filter::set_filter_water_wash_color(self, 1, 0.16, 0.5, 0.9);
    filter::set_filter_water_wash_reveal_dir(self, 1, -1);
    for (i = 0; i < 0.05; i += 0.01) {
        filter::set_filter_water_dive_bubbles(self, 1, i / 0.05);
        wait 0.01;
    }
    filter::set_filter_water_dive_bubbles(self, 1, 1);
    filter::set_filter_water_scuba_bubble_attitude(self, 1, -1);
    filter::set_filter_water_scuba_bubbles(self, 1, 1);
    filter::set_filter_water_wash_reveal_dir(self, 1, 1);
    for (i = 0.2; i > 0; i -= 0.01) {
        filter::set_filter_water_dive_bubbles(self, 1, i / 0.2);
        wait 0.01;
    }
    filter::set_filter_water_dive_bubbles(self, 1, 0);
    wait 0.1;
    for (i = 0.2; i > 0; i -= 0.01) {
        filter::set_filter_water_scuba_bubbles(self, 1, i / 0.2);
        wait 0.01;
    }
}

// Namespace water_surface
// Params 0, eflags: 0x1 linked
// Checksum 0x8e79a9e6, Offset: 0x948
// Size: 0x214
function startwatersheeting() {
    self notify(#"startwatersheeting_singleton");
    self endon(#"startwatersheeting_singleton");
    self endon(#"entityshutdown");
    filter::enable_filter_water_sheeting(self, 1);
    filter::set_filter_water_sheet_reveal(self, 1, 1);
    filter::set_filter_water_sheet_speed(self, 1, 1);
    for (i = 2; i > 0; i -= 0.01) {
        filter::set_filter_water_sheet_reveal(self, 1, i / 2);
        filter::set_filter_water_sheet_speed(self, 1, i / 2);
        rivulet1 = i / 2 - 0.19;
        rivulet2 = i / 2 - 0.13;
        rivulet3 = i / 2 - 0.07;
        filter::set_filter_water_sheet_rivulet_reveal(self, 1, rivulet1, rivulet2, rivulet3);
        wait 0.01;
    }
    filter::set_filter_water_sheet_reveal(self, 1, 0);
    filter::set_filter_water_sheet_speed(self, 1, 0);
    filter::set_filter_water_sheet_rivulet_reveal(self, 1, 0, 0, 0);
}

// Namespace water_surface
// Params 1, eflags: 0x1 linked
// Checksum 0x3a588fe3, Offset: 0xb68
// Size: 0x72
function stop_player_fx(localclient) {
    if (isdefined(localclient.firstperson_water_fx)) {
        localclientnum = localclient getlocalclientnumber();
        stopfx(localclientnum, localclient.firstperson_water_fx);
        localclient.firstperson_water_fx = undefined;
    }
}

