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
// Checksum 0x2e892ca6, Offset: 0x568
// Size: 0x2a
function main() {
    level.var_f2a478d8 = -106;
    init_clientfields();
    init_fx();
}

// Namespace namespace_b0a87e94
// Params 0, eflags: 0x0
// Checksum 0xed9fa6d5, Offset: 0x5a0
// Size: 0xc3
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
// Checksum 0xcccf1701, Offset: 0x670
// Size: 0x22a
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
// Checksum 0xac90c689, Offset: 0x8a8
// Size: 0x169
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
// Checksum 0xcb132eb9, Offset: 0xa20
// Size: 0x191
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
// Checksum 0x3db7a535, Offset: 0xbc0
// Size: 0x1f2
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
// Checksum 0x6780ca6f, Offset: 0xdc0
// Size: 0x63
function function_a24844d7(a_ents) {
    foreach (var_d6f141bd in a_ents) {
        var_d6f141bd thread namespace_6473bd03::function_9cf7347d();
    }
}

// Namespace namespace_b0a87e94
// Params 7, eflags: 0x0
// Checksum 0x5e783861, Offset: 0xe30
// Size: 0x108
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
// Checksum 0xdbcfe865, Offset: 0xf40
// Size: 0xcb
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
// Checksum 0x362ec6bf, Offset: 0x1018
// Size: 0x18
function get_eyeball_on_luminance() {
    if (isdefined(level.eyeball_on_luminance_override)) {
        return level.eyeball_on_luminance_override;
    }
    return 1;
}

// Namespace namespace_b0a87e94
// Params 0, eflags: 0x0
// Checksum 0xcadf05ec, Offset: 0x1038
// Size: 0x17
function get_eyeball_off_luminance() {
    if (isdefined(level.eyeball_off_luminance_override)) {
        return level.eyeball_off_luminance_override;
    }
    return 0;
}

// Namespace namespace_b0a87e94
// Params 0, eflags: 0x0
// Checksum 0xf96f3365, Offset: 0x1058
// Size: 0x3a
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
// Checksum 0x9f96d8fb, Offset: 0x10a0
// Size: 0x4a
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
// Checksum 0x93f0b3a9, Offset: 0x10f8
// Size: 0xa2
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
// Checksum 0x24d08bb3, Offset: 0x11a8
// Size: 0x6a
function zombie_tac_mode_disable(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self tmodesetflag(9);
        return;
    }
    self tmodeclearflag(9);
}

// Namespace namespace_b0a87e94
// Params 7, eflags: 0x0
// Checksum 0x5120b089, Offset: 0x1220
// Size: 0x91
function function_92a91bd2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_9ddfd913 = playfxontag(localclientnum, level._effect["zombie_firewall_fx"], self, "tag_origin");
        return;
    }
    deletefx(localclientnum, self.var_9ddfd913, 0);
    self.var_9ddfd913 = undefined;
}

// Namespace namespace_b0a87e94
// Params 7, eflags: 0x0
// Checksum 0xe3d9be5b, Offset: 0x12c0
// Size: 0xc3
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
// Checksum 0xeafe168a, Offset: 0x1390
// Size: 0x12a
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
// Checksum 0x6366b2cf, Offset: 0x14c8
// Size: 0x72
function function_449961e9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setdvar("r_radioactiveFX_enable", newval);
    if (newval != oldval) {
        setdvar("r_radioactiveIntensity", 0);
    }
}

// Namespace namespace_b0a87e94
// Params 7, eflags: 0x0
// Checksum 0x46ce8211, Offset: 0x1548
// Size: 0x8a
function function_760de3ec(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_2aa20526 = math::linear_map(newval, 0, 1, 0, 4);
    setdvar("r_radioactiveIntensity", var_2aa20526);
}

