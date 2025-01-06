#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/cp_mi_cairo_infection_hideout_outro;
#using scripts/shared/clientfield_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace namespace_b0a87e94;

// Namespace namespace_b0a87e94
// Params 0, eflags: 0x0
// Checksum 0x46a547ec, Offset: 0x568
// Size: 0x34
function main() {
    level.var_f2a478d8 = -106;
    init_clientfields();
    init_fx();
}

// Namespace namespace_b0a87e94
// Params 0, eflags: 0x0
// Checksum 0x8800ec29, Offset: 0x5a8
// Size: 0xe2
function init_fx() {
    level._effect["eye_glow"] = "zombie/fx_glow_eye_orange";
    level._effect["rise_burst"] = "zombie/fx_spawn_dirt_hand_burst_zmb";
    level._effect["rise_billow"] = "zombie/fx_spawn_dirt_body_billowing_zmb";
    level._effect["rise_dust"] = "zombie/fx_spawn_dirt_body_dustfalling_zmb";
    level._effect["zombie_firewall_fx"] = "fire/fx_fire_wall_moving_infection_city";
    level._effect["zombie_guts_explosion"] = "zombie/fx_blood_torso_explo_zmb";
    level._effect["zombie_backdraft_md"] = "fire/fx_fire_backdraft_md";
    level._effect["zombie_backdraft_sm"] = "fire/fx_fire_backdraft_sm";
}

// Namespace namespace_b0a87e94
// Params 0, eflags: 0x0
// Checksum 0x68df7e48, Offset: 0x698
// Size: 0x2bc
function init_clientfields() {
    println("<dev string:x28>");
    if (!sessionmodeiscampaignzombiesgame()) {
        clientfield::register("actor", "zombie_riser_fx", 1, 1, "int", &handle_zombie_risers, 1, 1);
        clientfield::register("actor", "zombie_has_eyes", 1, 1, "int", &zombie_eyes_clientfield_cb, 0, 1);
        clientfield::register("actor", "zombie_gut_explosion", 1, 1, "int", &zombie_gut_explosion_cb, 0, 1);
        clientfield::register("actor", "zombie_tac_mode_disable", 1, 1, "int", &zombie_tac_mode_disable, 0, 0);
    }
    clientfield::register("scriptmover", "zombie_fire_wall_fx", 1, 1, "int", &function_92a91bd2, 1, 0);
    clientfield::register("scriptmover", "zombie_fire_backdraft_fx", 1, 1, "int", &function_2ef010d2, 1, 0);
    clientfield::register("toplayer", "zombie_fire_overlay_init", 1, 1, "int", &function_449961e9, 1, 1);
    clientfield::register("toplayer", "zombie_fire_overlay", 1, 7, "float", &function_760de3ec, 1, 1);
    clientfield::register("world", "zombie_root_grow", 1, 1, "int", &function_9551b3d5, 0, 0);
}

// Namespace namespace_b0a87e94
// Params 7, eflags: 0x0
// Checksum 0x9456ae05, Offset: 0x960
// Size: 0x1be
function handle_zombie_risers(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level endon(#"demo_jump");
    self endon(#"entityshutdown");
    if (!oldval && newval) {
        localplayers = level.localplayers;
        sound = "zmb_zombie_spawn";
        burst_fx = level._effect["rise_burst"];
        billow_fx = level._effect["rise_billow"];
        type = "dirt";
        if (isdefined(level.riser_type) && level.riser_type == "snow") {
            sound = "zmb_zombie_spawn_snow";
            burst_fx = level._effect["rise_burst_snow"];
            billow_fx = level._effect["rise_billow_snow"];
            type = "snow";
        }
        playsound(0, sound, self.origin);
        for (i = 0; i < localplayers.size; i++) {
            self thread rise_dust_fx(i, type, billow_fx, burst_fx);
        }
    }
}

// Namespace namespace_b0a87e94
// Params 4, eflags: 0x0
// Checksum 0xb58839e8, Offset: 0xb28
// Size: 0x21e
function rise_dust_fx(clientnum, type, billow_fx, burst_fx) {
    dust_tag = "J_SpineUpper";
    self endon(#"entityshutdown");
    level endon(#"demo_jump");
    if (isdefined(burst_fx)) {
        playfx(clientnum, burst_fx, self.origin + (0, 0, randomintrange(5, 10)));
    }
    wait 0.25;
    if (isdefined(billow_fx)) {
        playfx(clientnum, billow_fx, self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
    }
    wait 2;
    dust_time = 5.5;
    dust_interval = 0.3;
    player = level.localplayers[clientnum];
    effect = level._effect["rise_dust"];
    if (type == "snow") {
        effect = level._effect["rise_dust_snow"];
    } else if (type == "none") {
        return;
    }
    for (t = 0; t < dust_time; t += dust_interval) {
        playfxontag(clientnum, effect, self, dust_tag);
        wait dust_interval;
    }
}

// Namespace namespace_b0a87e94
// Params 7, eflags: 0x0
// Checksum 0xe248cc79, Offset: 0xd50
// Size: 0x234
function function_9551b3d5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        scene::add_scene_func("p7_fxanim_cp_infection_house_roots_left_bundle", &function_a24844d7, "init");
        scene::add_scene_func("p7_fxanim_cp_infection_house_roots_middle_bundle", &function_a24844d7, "init");
        scene::add_scene_func("p7_fxanim_cp_infection_house_roots_right_bundle", &function_a24844d7, "init");
        level thread scene::init("p7_fxanim_cp_infection_house_roots_left_bundle");
        level thread scene::init("p7_fxanim_cp_infection_house_roots_middle_bundle");
        level thread scene::init("p7_fxanim_cp_infection_house_roots_right_bundle");
        return;
    }
    scene::add_scene_func("p7_fxanim_cp_infection_house_roots_left_bundle", &function_a24844d7, "play");
    scene::add_scene_func("p7_fxanim_cp_infection_house_roots_middle_bundle", &function_a24844d7, "play");
    scene::add_scene_func("p7_fxanim_cp_infection_house_roots_right_bundle", &function_a24844d7, "play");
    level thread scene::play("p7_fxanim_cp_infection_house_roots_left_bundle");
    level thread scene::play("p7_fxanim_cp_infection_house_roots_middle_bundle");
    level thread scene::play("p7_fxanim_cp_infection_house_roots_right_bundle");
}

// Namespace namespace_b0a87e94
// Params 1, eflags: 0x0
// Checksum 0x89b29c00, Offset: 0xf90
// Size: 0x92
function function_a24844d7(a_ents) {
    foreach (var_d6f141bd in a_ents) {
        var_d6f141bd thread namespace_6473bd03::function_9cf7347d();
    }
}

// Namespace namespace_b0a87e94
// Params 7, eflags: 0x0
// Checksum 0x802acbbf, Offset: 0x1030
// Size: 0x154
function zombie_eyes_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(newval)) {
        return;
    }
    if (newval) {
        self createzombieeyesinternal(localclientnum);
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, get_eyeball_on_luminance(), self get_eyeball_color());
    } else {
        self deletezombieeyes(localclientnum);
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, get_eyeball_off_luminance(), self get_eyeball_color());
    }
    if (isdefined(level.var_3ae99156)) {
        self [[ level.var_3ae99156 ]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    }
}

// Namespace namespace_b0a87e94
// Params 1, eflags: 0x0
// Checksum 0x6118af87, Offset: 0x1190
// Size: 0x102
function createzombieeyesinternal(localclientnum) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self._eyearray)) {
        self._eyearray = [];
    }
    if (!isdefined(self._eyearray[localclientnum])) {
        linktag = "j_eyeball_le";
        effect = level._effect["eye_glow"];
        if (isdefined(level._override_eye_fx)) {
            effect = level._override_eye_fx;
        }
        if (isdefined(self._eyeglow_fx_override)) {
            effect = self._eyeglow_fx_override;
        }
        if (isdefined(self._eyeglow_tag_override)) {
            linktag = self._eyeglow_tag_override;
        }
        self._eyearray[localclientnum] = playfxontag(localclientnum, effect, self, linktag);
    }
}

// Namespace namespace_b0a87e94
// Params 0, eflags: 0x0
// Checksum 0x2e710665, Offset: 0x12a0
// Size: 0x1c
function get_eyeball_on_luminance() {
    if (isdefined(level.eyeball_on_luminance_override)) {
        return level.eyeball_on_luminance_override;
    }
    return 1;
}

// Namespace namespace_b0a87e94
// Params 0, eflags: 0x0
// Checksum 0xce1fdb23, Offset: 0x12c8
// Size: 0x1a
function get_eyeball_off_luminance() {
    if (isdefined(level.eyeball_off_luminance_override)) {
        return level.eyeball_off_luminance_override;
    }
    return 0;
}

// Namespace namespace_b0a87e94
// Params 0, eflags: 0x0
// Checksum 0xfa2527d7, Offset: 0x12f0
// Size: 0x48
function get_eyeball_color() {
    val = 0;
    if (isdefined(level.zombie_eyeball_color_override)) {
        val = level.zombie_eyeball_color_override;
    }
    if (isdefined(self.zombie_eyeball_color_override)) {
        val = self.zombie_eyeball_color_override;
    }
    return val;
}

// Namespace namespace_b0a87e94
// Params 1, eflags: 0x0
// Checksum 0xf0d79b31, Offset: 0x1340
// Size: 0x60
function deletezombieeyes(localclientnum) {
    if (isdefined(self._eyearray)) {
        if (isdefined(self._eyearray[localclientnum])) {
            deletefx(localclientnum, self._eyearray[localclientnum], 1);
            self._eyearray[localclientnum] = undefined;
        }
    }
}

// Namespace namespace_b0a87e94
// Params 7, eflags: 0x0
// Checksum 0x6995079e, Offset: 0x13a8
// Size: 0xb4
function zombie_gut_explosion_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (isdefined(level._effect["zombie_guts_explosion"])) {
            org = self gettagorigin("J_SpineLower");
            if (isdefined(org)) {
                playfx(localclientnum, level._effect["zombie_guts_explosion"], org);
            }
        }
    }
}

// Namespace namespace_b0a87e94
// Params 7, eflags: 0x0
// Checksum 0xa18bb264, Offset: 0x1468
// Size: 0x7c
function zombie_tac_mode_disable(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self tmodesetflag(9);
        return;
    }
    self tmodeclearflag(9);
}

// Namespace namespace_b0a87e94
// Params 7, eflags: 0x0
// Checksum 0x92c1815b, Offset: 0x14f0
// Size: 0x20e
function function_92a91bd2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    a_players = getlocalplayers();
    if (!isdefined(a_players)) {
        return;
    }
    if (newval) {
        foreach (player in a_players) {
            var_ae6a34c0 = player getlocalclientnumber();
            self util::waittill_dobj(var_ae6a34c0);
            self.var_9ddfd913[var_ae6a34c0] = playfxontag(var_ae6a34c0, level._effect["zombie_firewall_fx"], self, "tag_origin");
        }
        return;
    }
    foreach (player in a_players) {
        var_ae6a34c0 = player getlocalclientnumber();
        deletefx(var_ae6a34c0, self.var_9ddfd913[var_ae6a34c0], 0);
        self.var_9ddfd913[var_ae6a34c0] = undefined;
    }
}

// Namespace namespace_b0a87e94
// Params 7, eflags: 0x0
// Checksum 0xf36772c5, Offset: 0x1708
// Size: 0xfa
function function_2ef010d2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        var_d894d2f4 = struct::get_array("backdraft_fire", "targetname");
        foreach (struct in var_d894d2f4) {
            struct thread function_bd533269(localclientnum, self);
        }
    }
}

// Namespace namespace_b0a87e94
// Params 2, eflags: 0x0
// Checksum 0x4d0e98db, Offset: 0x1810
// Size: 0x17c
function function_bd533269(localclientnum, var_7c15369c) {
    var_7c15369c endon(#"entityshutdown");
    for (var_169b6893 = var_7c15369c.origin; self.origin[0] < var_169b6893[0]; var_169b6893 = var_7c15369c.origin) {
        wait 0.1;
    }
    forward = anglestoforward(self.angles);
    if (randomint(100) > 50) {
        playfx(localclientnum, level._effect["zombie_backdraft_md"], self.origin, forward);
        playsound(0, "pfx_backdraft", self.origin);
        return;
    }
    playfx(localclientnum, level._effect["zombie_backdraft_sm"], self.origin, forward);
    playsound(0, "pfx_backdraft", self.origin);
}

// Namespace namespace_b0a87e94
// Params 7, eflags: 0x0
// Checksum 0x720ab0a7, Offset: 0x1998
// Size: 0x84
function function_449961e9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setdvar("r_radioactiveFX_enable", newval);
    if (newval != oldval) {
        setdvar("r_radioactiveIntensity", 0);
    }
}

// Namespace namespace_b0a87e94
// Params 7, eflags: 0x0
// Checksum 0xd051b530, Offset: 0x1a28
// Size: 0x9c
function function_760de3ec(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_2aa20526 = math::linear_map(newval, 0, 1, 0, 4);
    setdvar("r_radioactiveIntensity", var_2aa20526);
}

