#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace zm_theater_teleporter;

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x2
// Checksum 0xbb6d6fbd, Offset: 0x380
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_theater_teleporter", &__init__, undefined, undefined);
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0xceecf62e, Offset: 0x3c0
// Size: 0x1dc
function __init__() {
    visionset_mgr::register_overlay_info_style_postfx_bundle("zm_theater_teleport", 21000, 1, "pstfx_zm_kino_teleport");
    clientfield::register("scriptmover", "extra_screen", 21000, 1, "int", &function_667aa0b4, 0, 0);
    clientfield::register("scriptmover", "teleporter_fx", 21000, 1, "counter", &function_a8255fab, 0, 0);
    clientfield::register("allplayers", "player_teleport_fx", 21000, 1, "counter", &function_2b23adc9, 0, 0);
    clientfield::register("scriptmover", "play_fly_me_to_the_moon_fx", 21000, 1, "int", &play_fly_me_to_the_moon_fx, 0, 0);
    clientfield::register("world", "teleporter_initiate_fx", 21000, 1, "counter", &function_6776dea9, 0, 0);
    clientfield::register("scriptmover", "teleporter_link_cable_mtl", 21000, 1, "int", &teleporter_link_cable_mtl, 0, 0);
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0x5f4cceec, Offset: 0x5a8
// Size: 0x34
function main() {
    level thread function_f03654b2();
    level thread function_7de9450a();
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0x463b6e93, Offset: 0x5e8
// Size: 0x4c
function function_f03654b2() {
    level waittill(#"power_on");
    for (i = 0; i < level.localplayers.size; i++) {
        level.var_2c3bd034[i] = 0;
    }
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0x56ef38d0, Offset: 0x640
// Size: 0x24c
function function_7de9450a() {
    level waittill(#"pack_clock_start", clientnum);
    curr_time = getsystemtime();
    hours = curr_time[0];
    if (hours > 12) {
        hours -= 12;
    }
    if (hours == 0) {
        hours = 12;
    }
    minutes = curr_time[1];
    seconds = curr_time[2];
    hour_hand = getent(clientnum, "zom_clock_hour_hand", "targetname");
    hour_values = [];
    hour_values["hand_time"] = hours;
    hour_values["rotate"] = 30;
    hour_values["rotate_bit"] = 0.00833333;
    hour_values["first_rotate"] = (minutes * 60 + seconds) * hour_values["rotate_bit"];
    minute_hand = getent(clientnum, "zom_clock_minute_hand", "targetname");
    minute_values = [];
    minute_values["hand_time"] = minutes;
    minute_values["rotate"] = 6;
    minute_values["rotate_bit"] = 0.1;
    minute_values["first_rotate"] = seconds * minute_values["rotate_bit"];
    if (isdefined(hour_hand)) {
        hour_hand thread function_cb983f5b(hour_values);
    }
    if (isdefined(minute_hand)) {
        minute_hand thread function_cb983f5b(minute_values);
    }
}

// Namespace zm_theater_teleporter
// Params 1, eflags: 0x0
// Checksum 0x9ecd1a5b, Offset: 0x898
// Size: 0x14c
function function_cb983f5b(time_values) {
    self endon(#"entityshutdown");
    self rotatepitch(time_values["hand_time"] * time_values["rotate"] * -1, 0.05);
    self waittill(#"rotatedone");
    if (isdefined(time_values["first_rotate"])) {
        self rotatepitch(time_values["first_rotate"] * -1, 0.05);
        self waittill(#"rotatedone");
    }
    prev_time = getsystemtime();
    while (true) {
        curr_time = getsystemtime();
        if (prev_time != curr_time) {
            self rotatepitch(time_values["rotate_bit"] * -1, 0.05);
            prev_time = curr_time;
        }
        wait 1;
    }
}

// Namespace zm_theater_teleporter
// Params 7, eflags: 0x0
// Checksum 0x24325f55, Offset: 0x9f0
// Size: 0x2e2
function function_667aa0b4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level.cameraent = getent(localclientnum, "theater_extracam_eye", "targetname");
        level.var_6725ded9 = util::spawn_model(localclientnum, "tag_origin", level.cameraent.origin, level.cameraent.angles);
        level.var_6725ded9.var_e39fd443 = playfxontag(localclientnum, level._effect["fx_mp_light_lamp"], level.var_6725ded9, "tag_origin");
        if (level.var_2c3bd034[localclientnum] == 0 && level.localplayers.size < 3) {
            if (isdefined(level.var_3cb13a71[localclientnum])) {
                killfx(localclientnum, level.var_3cb13a71[localclientnum]);
            }
            level.var_2c3bd034[localclientnum] = 1;
            level.cameraent setextracam(0, 320, -16);
        }
        return;
    }
    if (isdefined(level.var_6725ded9)) {
        stopfx(localclientnum, level.var_6725ded9.var_e39fd443);
        level.var_6725ded9 delete();
    }
    if (level.var_2c3bd034[localclientnum] == 1 && isdefined(level.cameraent)) {
        level.var_2c3bd034[localclientnum] = 0;
        level.cameraent clearextracam();
        var_78113405 = struct::get("struct_theater_projector_beam", "targetname");
        if (isdefined(level.var_3cb13a71[localclientnum]) && isdefined(var_78113405.var_eccab862[localclientnum])) {
            level.var_3cb13a71[localclientnum] = playfxontag(localclientnum, level._effect[level.var_bcdc3660[localclientnum]], var_78113405.var_eccab862[localclientnum], "tag_origin");
        }
    }
}

// Namespace zm_theater_teleporter
// Params 7, eflags: 0x0
// Checksum 0x385109b8, Offset: 0xce0
// Size: 0xfc
function function_a8255fab(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self endon(#"entityshutdown");
    if (newval) {
        n_fx_id = playfxontag(localclientnum, level._effect["teleport_player_kino"], self, "tag_fx_wormhole");
        setfxignorepause(localclientnum, n_fx_id, 1);
        var_3d144b40 = playfxontag(localclientnum, level._effect["teleport_player_kino_cover"], self, "tag_fx_wormhole");
        setfxignorepause(localclientnum, var_3d144b40, 1);
    }
}

// Namespace zm_theater_teleporter
// Params 7, eflags: 0x0
// Checksum 0x503edeef, Offset: 0xde8
// Size: 0x13a
function function_2b23adc9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    a_e_players = getlocalplayers();
    foreach (e_player in a_e_players) {
        e_player.var_5c4ad807 = playfxontag(e_player.localclientnum, level._effect["teleport_player_flash"], self, "j_spinelower");
        setfxignorepause(e_player.localclientnum, e_player.var_5c4ad807, 1);
    }
}

// Namespace zm_theater_teleporter
// Params 7, eflags: 0x0
// Checksum 0x98cfce89, Offset: 0xf30
// Size: 0x27a
function function_6776dea9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_33e4acb6 = (-306.684, 1116.25, 117.056);
    var_a1844610 = (0, 0, 0);
    v_origin = (-306.75, 1116.25, 0.0660095);
    v_angles = (270, 0, 0);
    a_e_players = getlocalplayers();
    foreach (e_player in a_e_players) {
        e_player.var_a0a2d27 = playfx(e_player.localclientnum, level._effect["teleport_initiate"], v_origin, anglestoforward(v_angles), anglestoup(v_angles));
        setfxignorepause(e_player.localclientnum, e_player.var_a0a2d27, 1);
        e_player.var_d4770e93 = playfx(e_player.localclientnum, level._effect["teleport_initiate_top"], var_33e4acb6, anglestoforward(var_a1844610), anglestoup(var_a1844610));
        setfxignorepause(e_player.localclientnum, e_player.var_d4770e93, 1);
    }
}

// Namespace zm_theater_teleporter
// Params 7, eflags: 0x0
// Checksum 0x3fd1e314, Offset: 0x11b8
// Size: 0x174
function play_fly_me_to_the_moon_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_d623bf76 = util::spawn_model(localclientnum, "tag_origin", self.origin + (0, 0, -19), (90, 0, 0));
        self.var_d623bf76 linkto(self);
        n_fx_id = playfxontag(localclientnum, level._effect["fx_mp_pipe_steam"], self.var_d623bf76, "tag_origin");
        setfxignorepause(localclientnum, n_fx_id, 1);
        return;
    }
    if (isdefined(self) && isdefined(self.var_d623bf76)) {
        deletefx(localclientnum, level._effect["fx_mp_pipe_steam"]);
        self.var_d623bf76 unlink();
        self.var_d623bf76 delete();
    }
}

// Namespace zm_theater_teleporter
// Params 7, eflags: 0x0
// Checksum 0x70a23f31, Offset: 0x1338
// Size: 0x9c
function teleporter_link_cable_mtl(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 1, 0, 0, 0);
        return;
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0, 0);
}

