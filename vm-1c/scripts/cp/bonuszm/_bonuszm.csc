#using scripts/cp/cybercom/_cybercom;
#using scripts/shared/weapons/multilockapguidance;
#using scripts/shared/weapons/antipersonnelguidance;
#using scripts/shared/weapons/_trophy_system;
#using scripts/shared/weapons/_tacticalinsertion;
#using scripts/shared/weapons/_satchel_charge;
#using scripts/shared/weapons/_riotshield;
#using scripts/shared/weapons/_proximity_grenade;
#using scripts/shared/weapons/_bouncingbetty;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/_oob;
#using scripts/shared/music_shared;
#using scripts/shared/load_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/shared/archetype_shared/archetype_shared;
#using scripts/codescripts/struct;

#namespace namespace_293e8aad;

// Namespace namespace_293e8aad
// Params 0, eflags: 0x2
// namespace_293e8aad<file_0>::function_2dc19561
// Checksum 0xaf343790, Offset: 0x1040
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("bonuszm", &__init__, undefined, undefined);
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_8c87d8eb
// Checksum 0x1932ff8, Offset: 0x1080
// Size: 0xdc
function __init__() {
    function_2b1e88f3();
    function_e6a554ef();
    if (!sessionmodeiscampaignzombiesgame()) {
        return;
    }
    register_clientfields();
    init_fx();
    setdvar("bg_friendlyFireMode", 0);
    level.setgibfxtoignorepause = 1;
    callback::on_spawned(&on_player_spawned);
    function_aea4686a();
    vehicle::add_vehicletype_callback("raps", &function_938d1a68);
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_938d1a68
// Checksum 0x657a316b, Offset: 0x1168
// Size: 0x34
function function_938d1a68(localclientnum) {
    self setanim("ai_zombie_zod_insanity_elemental_idle", 1);
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x2
// namespace_293e8aad<file_0>::function_4d5aa4f3
// Checksum 0x99ec1590, Offset: 0x11a8
// Size: 0x4
function autoexec function_4d5aa4f3() {
    
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x5 linked
// namespace_293e8aad<file_0>::function_aebcf025
// Checksum 0x991479e1, Offset: 0x11b8
// Size: 0x5c
function private on_player_spawned(localclientnum) {
    self tmodeenable(0);
    setdvar("r_bloomUseLutALT", 1);
    function_8cf4b0ee(localclientnum);
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_2b1e88f3
// Checksum 0x29a414af, Offset: 0x1220
// Size: 0xde
function function_2b1e88f3() {
    var_f0bd3ca = findstaticmodelindexarray("zombie_misc_model");
    if (!sessionmodeiscampaignzombiesgame() || !util::is_mature()) {
        foreach (var_3082faeb in var_f0bd3ca) {
            hidestaticmodel(var_3082faeb);
        }
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_e6a554ef
// Checksum 0x11c0a14, Offset: 0x1308
// Size: 0xde
function function_e6a554ef() {
    var_9302fbfc = findvolumedecalindexarray("zombie_volume_decal");
    if (!sessionmodeiscampaignzombiesgame() || !util::is_mature()) {
        foreach (var_da4e043d in var_9302fbfc) {
            hidevolumedecal(var_da4e043d);
        }
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x0
// namespace_293e8aad<file_0>::function_9f75e681
// Checksum 0xf5499ca2, Offset: 0x13f0
// Size: 0x64
function function_9f75e681() {
    mapname = getdvarstring("mapname");
    if (mapname != "cp_mi_sing_sgen" || mapname != "cp_mi_cairo_lotus2") {
        audio::playloopat("mus_bonuszm_underscore", (0, 0, 0));
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_4ece4a2f
// Checksum 0xaf630f02, Offset: 0x1460
// Size: 0x694
function register_clientfields() {
    clientfield::register("actor", "zombie_riser_fx", 1, 1, "int", &handle_zombie_risers, 0, 1);
    clientfield::register("actor", "bonus_zombie_eye_color", 1, 3, "int", &function_2bfd38ec, 0, 1);
    clientfield::register("actor", "zombie_has_eyes", 1, 1, "int", &zombie_eyes_clientfield_cb, 0, 1);
    clientfield::register("actor", "zombie_gut_explosion", 1, 1, "int", &zombie_gut_explosion_cb, 0, 1);
    clientfield::register("actor", "bonuszm_zombie_on_fire_fx", 1, getminbitcountfornum(3), "int", &function_f83377d6, 0, 1);
    clientfield::register("actor", "bonuszm_zombie_spark_fx", 1, getminbitcountfornum(2), "int", &function_4b335db, 0, 1);
    clientfield::register("actor", "bonuszm_zombie_deimos_fx", 1, getminbitcountfornum(1), "int", &function_225fae17, 0, 1);
    clientfield::register("vehicle", "bonuszm_meatball_death", 1, 1, "int", &function_1f4cd60d, 0, 1);
    clientfield::register("actor", "zombie_riser_fx", 1, 1, "int", &handle_zombie_risers, 0, 1);
    clientfield::register("actor", "bonuszm_zombie_death_fx", 1, getminbitcountfornum(5), "int", &function_e4d833e, 0, 1);
    clientfield::register("actor", "zombie_appear_vanish_fx", 1, getminbitcountfornum(3), "int", &function_7fc0e06, 0, 1);
    clientfield::register("scriptmover", "powerup_on_fx", 1, getminbitcountfornum(3), "int", &function_2ab2bfb0, 0, 0);
    clientfield::register("scriptmover", "powerup_grabbed_fx", 1, 1, "int", &function_50779600, 0, 0);
    clientfield::register("scriptmover", "weapon_disappear_fx", 1, 1, "int", &function_42f6f16e, 0, 0);
    clientfield::register("scriptmover", "sparky_trail_fx", 1, 1, "int", &function_ab68bae5, 0, 0);
    clientfield::register("scriptmover", "sparky_attack_fx", 1, 1, "counter", &function_14312cfd, 0, 0);
    clientfield::register("actor", "sparky_damaged_fx", 1, 1, "counter", &function_97590d4, 0, 0);
    clientfield::register("actor", "fire_damaged_fx", 1, 1, "counter", &function_780c0a4, 0, 0);
    clientfield::register("zbarrier", "magicbox_open_glow", 1, 1, "int", &function_f900ae76, 0, 0);
    clientfield::register("zbarrier", "magicbox_closed_glow", 1, 1, "int", &function_5eb1f58e, 0, 0);
    clientfield::register("toplayer", "bonuszm_player_instakill_active_fx", 1, 1, "int", &function_bba3723b, 0, 0);
    clientfield::register("world", "cpzm_song_suppression", 1, 1, "int", &function_2122d6fd, 0, 0);
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_f53e79d4
// Checksum 0xe875c8b8, Offset: 0x1b00
// Size: 0x32e
function init_fx() {
    level._effect["eye_glow_o"] = "zombie/fx_glow_eye_orange";
    level._effect["eye_glow_b"] = "zombie/fx_glow_eye_blue";
    level._effect["eye_glow_g"] = "zombie/fx_glow_eye_green";
    level._effect["eye_glow_r"] = "zombie/fx_glow_eye_red";
    level._effect["rise_burst"] = "zombie/fx_spawn_dirt_hand_burst_zmb";
    level._effect["rise_billow"] = "zombie/fx_spawn_dirt_body_billowing_zmb";
    level._effect["rise_dust"] = "zombie/fx_spawn_dirt_body_dustfalling_zmb";
    level._effect["powerup_on"] = "zombie/fx_powerup_on_solo_zmb";
    level._effect["powerup_on_upgraded"] = "zombie/fx_powerup_on_green_zmb";
    level._effect["powerup_on_upgraded_all"] = "zombie/fx_powerup_on_caution_zmb";
    level._effect["chest_light"] = "zombie/fx_weapon_box_open_glow_zmb";
    level._effect["chest_light_closed"] = "zombie/fx_weapon_box_closed_glow_zmb";
    level._effect["zombie_spawn"] = "zombie/fx_spawn_body_cp_zmb";
    level._effect["zombie_sparky"] = "electric/fx_ability_elec_surge_short_robot";
    level._effect["zombie_sparky_death"] = "explosions/fx_ability_exp_ravage_core";
    level._effect["zombie_sparky_trail"] = "electric/fx_ability_elec_strike_trail";
    level._effect["zombie_sparky_impact"] = "electric/fx_ability_elec_strike_impact";
    level._effect["zombie_sparky_attack_death"] = "electric/fx_ability_elec_strike_short_human";
    level._effect["zombie_sparky_left_hand"] = "weapon/fx_hero_lightning_gun_death_hands_lft";
    level._effect["zombie_sparky_right_hand"] = "weapon/fx_hero_lightning_gun_death_hands";
    level._effect["zombie_fire_damage"] = "fire/fx_embers_burst";
    level._effect["zombie_on_fire_suicide"] = "explosions/fx_exp_dest_barrel_concussion_sm";
    level._effect["zombie_fire_light"] = "light/fx_light_fire_chest_zombie";
    level._effect["zombie_spark_light"] = "light/fx_light_spark_chest_zombie";
    level._effect["electric_spark"] = "electric/fx_elec_sparks_burst_blue";
    level._effect["deimos_zombie"] = "player/fx_ai_corvus_torso_loop";
    level._effect["deimos_zombie_le"] = "player/fx_ai_raven_teleport_out_arm_le";
    level._effect["deimos_zombie_ri"] = "player/fx_ai_raven_teleport_out_arm_ri";
    level._effect["deimos_zombie_death"] = "player/fx_ai_raven_dissolve_torso";
}

// Namespace namespace_293e8aad
// Params 7, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_d9fa15ed
// Checksum 0x2cb9b567, Offset: 0x1e38
// Size: 0x174
function handle_zombie_risers(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level endon(#"demo_jump");
    self endon(#"entityshutdown");
    if (newval) {
        sound = "zmb_zombie_spawn";
        burst_fx = level._effect["rise_burst"];
        billow_fx = level._effect["rise_billow"];
        type = "dirt";
        if (isdefined(level.riser_type) && level.riser_type == "snow") {
            sound = "zmb_zombie_spawn";
            burst_fx = level._effect["rise_burst_snow"];
            billow_fx = level._effect["rise_billow_snow"];
            type = "snow";
        }
        playsound(0, sound, self.origin);
        self thread rise_dust_fx(localclientnum, type, billow_fx, burst_fx);
    }
}

// Namespace namespace_293e8aad
// Params 4, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_4d70c126
// Checksum 0x6b4c622d, Offset: 0x1fb8
// Size: 0x29e
function rise_dust_fx(localclientnum, type, billow_fx, burst_fx) {
    dust_tag = "J_SpineUpper";
    self endon(#"entityshutdown");
    level endon(#"demo_jump");
    if (isdefined(burst_fx)) {
        fx = playfx(localclientnum, burst_fx, self.origin + (0, 0, randomintrange(5, 10)));
        setfxignorepause(localclientnum, fx, 1);
    }
    wait(0.25);
    if (isdefined(billow_fx)) {
        fx = playfx(localclientnum, billow_fx, self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
        setfxignorepause(localclientnum, fx, 1);
    }
    wait(2);
    dust_time = 5.5;
    dust_interval = 0.3;
    player = level.localplayers[localclientnum];
    effect = level._effect["rise_dust"];
    if (type == "snow") {
        effect = level._effect["rise_dust_snow"];
    } else if (type == "none") {
        return;
    }
    self util::waittill_dobj(localclientnum);
    for (t = 0; t < dust_time; t += dust_interval) {
        fx = playfxontag(localclientnum, effect, self, dust_tag);
        setfxignorepause(localclientnum, fx, 1);
        wait(dust_interval);
    }
}

// Namespace namespace_293e8aad
// Params 7, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_2bfd38ec
// Checksum 0xd7db59f0, Offset: 0x2260
// Size: 0x54
function function_2bfd38ec(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(newval)) {
        return;
    }
    self.var_463f6b7e = newval;
}

// Namespace namespace_293e8aad
// Params 7, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_a340759a
// Checksum 0x59d70d3, Offset: 0x22c0
// Size: 0x17c
function zombie_eyes_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(newval)) {
        return;
    }
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
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

// Namespace namespace_293e8aad
// Params 1, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_255c0b26
// Checksum 0x67ddeb08, Offset: 0x2448
// Size: 0x1aa
function createzombieeyesinternal(localclientnum) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self._eyearray)) {
        self._eyearray = [];
    }
    if (!isdefined(self._eyearray[localclientnum])) {
        linktag = "j_eyeball_le";
        if (!isdefined(self.var_463f6b7e)) {
            return;
        }
        if (self.var_463f6b7e == 0) {
            effect = level._effect["eye_glow_o"];
        } else if (self.var_463f6b7e == 1) {
            effect = level._effect["eye_glow_b"];
        } else if (self.var_463f6b7e == 2) {
            effect = level._effect["eye_glow_g"];
        } else if (self.var_463f6b7e == 3) {
            effect = level._effect["eye_glow_r"];
        } else {
            return;
        }
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

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_d2a9f995
// Checksum 0x4e4fa3bb, Offset: 0x2600
// Size: 0x1c
function get_eyeball_on_luminance() {
    if (isdefined(level.eyeball_on_luminance_override)) {
        return level.eyeball_on_luminance_override;
    }
    return 1;
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_28ded1d3
// Checksum 0x4f1d99f2, Offset: 0x2628
// Size: 0x1a
function get_eyeball_off_luminance() {
    if (isdefined(level.eyeball_off_luminance_override)) {
        return level.eyeball_off_luminance_override;
    }
    return 0;
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_6b4bd44e
// Checksum 0xeee6b837, Offset: 0x2650
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

// Namespace namespace_293e8aad
// Params 1, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_232ddafc
// Checksum 0xcb39911e, Offset: 0x26a0
// Size: 0x60
function deletezombieeyes(localclientnum) {
    if (isdefined(self._eyearray)) {
        if (isdefined(self._eyearray[localclientnum])) {
            deletefx(localclientnum, self._eyearray[localclientnum], 1);
            self._eyearray[localclientnum] = undefined;
        }
    }
}

// Namespace namespace_293e8aad
// Params 7, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_2ab2bfb0
// Checksum 0x1718eb21, Offset: 0x2708
// Size: 0x2cc
function function_2ab2bfb0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(newval)) {
        return;
    }
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        if (newval == 3) {
            self.var_d9ae415 = playfxontag(localclientnum, level._effect["powerup_on_upgraded_all"], self, "tag_origin");
        } else if (newval == 2) {
            self.var_d9ae415 = playfxontag(localclientnum, level._effect["powerup_on_upgraded"], self, "tag_origin");
        } else {
            self.var_d9ae415 = playfxontag(localclientnum, level._effect["powerup_on"], self, "tag_origin");
        }
        setfxignorepause(localclientnum, self.var_d9ae415, 1);
        if (self.model === "p7_zm_teddybear_sitting") {
        } else {
            playsound(localclientnum, "zmb_spawn_powerup", self.origin);
            self playloopsound("zmb_spawn_powerup_loop", 0.5);
        }
        return;
    }
    if (isdefined(self.var_d9ae415)) {
        self stopallloopsounds();
        deletefx(localclientnum, self.var_d9ae415, 1);
        self.var_d9ae415 = undefined;
        fx = playfxontag(localclientnum, level._effect["electric_spark"], self, "tag_origin");
        setfxignorepause(localclientnum, fx, 1);
        playsound(localclientnum, "zmb_box_timeout_poof", self.origin);
        playrumbleonposition(localclientnum, "damage_light", self.origin);
    }
}

// Namespace namespace_293e8aad
// Params 7, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_50779600
// Checksum 0x501dd6e2, Offset: 0x29e0
// Size: 0x74
function function_50779600(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(newval)) {
        return;
    }
    if (newval) {
        playsound(localclientnum, "zmb_powerup_grabbed", self.origin);
    }
}

// Namespace namespace_293e8aad
// Params 7, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_f83377d6
// Checksum 0x3f7babf3, Offset: 0x2a60
// Size: 0x18c
function function_f83377d6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(newval)) {
        return;
    }
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval == 1 || newval == 2) {
        if (!isdefined(self.var_6044d98e)) {
            self.var_6044d98e = self playloopsound("zmb_fire_burn_loop", 0.2);
        }
        if (newval == 2) {
            fx = playfxontag(localclientnum, level._effect["zombie_fire_light"], self, "J_SpineUpper");
            setfxignorepause(localclientnum, fx, 1);
            self function_d8c8d819(localclientnum, "fire");
        }
        return;
    }
    if (newval == 3) {
        playsound(localclientnum, "zmb_fire_charge_up", self.origin);
    }
}

// Namespace namespace_293e8aad
// Params 7, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_780c0a4
// Checksum 0x3c26067e, Offset: 0x2bf8
// Size: 0x144
function function_780c0a4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        if (isdefined(level._effect["zombie_fire_damage"])) {
            playsound(localclientnum, "gdt_electro_bounce", self.origin);
            locs = array("j_wrist_le", "j_wrist_ri");
            fx = playfxontag(localclientnum, level._effect["zombie_fire_damage"], self, array::random(locs));
            setfxignorepause(localclientnum, fx, 1);
        }
    }
}

// Namespace namespace_293e8aad
// Params 7, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_4b335db
// Checksum 0xb85b9c29, Offset: 0x2d48
// Size: 0x194
function function_4b335db(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(newval)) {
        return;
    }
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval >= 1) {
        if (!isdefined(self.var_6044d98e)) {
            self.var_6044d98e = self playloopsound("zmb_electrozomb_lp", 0.2);
        }
        fx = playfxontag(localclientnum, level._effect["zombie_sparky"], self, "J_SpineUpper");
        setfxignorepause(localclientnum, fx, 1);
        if (newval == 2) {
            fx = playfxontag(localclientnum, level._effect["zombie_spark_light"], self, "J_SpineUpper");
            setfxignorepause(localclientnum, fx, 1);
            self function_d8c8d819(localclientnum, "sparky");
        }
    }
}

// Namespace namespace_293e8aad
// Params 7, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_225fae17
// Checksum 0x909a4f98, Offset: 0x2ee8
// Size: 0x1b4
function function_225fae17(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(newval)) {
        return;
    }
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        if (!isdefined(self.var_6044d98e)) {
            self.var_6044d98e = self playloopsound("zmb_deimoszomb_lp", 0.2);
        }
        fx = playfxontag(localclientnum, level._effect["deimos_zombie"], self, "J_SpineUpper");
        setfxignorepause(localclientnum, fx, 1);
        fx = playfxontag(localclientnum, level._effect["deimos_zombie_le"], self, "j_wrist_le");
        setfxignorepause(localclientnum, fx, 1);
        fx = playfxontag(localclientnum, level._effect["deimos_zombie_ri"], self, "j_wrist_ri");
        setfxignorepause(localclientnum, fx, 1);
    }
}

// Namespace namespace_293e8aad
// Params 7, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_1f4cd60d
// Checksum 0xbac70891, Offset: 0x30a8
// Size: 0x104
function function_1f4cd60d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(newval)) {
        return;
    }
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval == 1) {
        fx = playfxontag(localclientnum, level._effect["zombie_on_fire_suicide"], self, "tag_origin");
        setfxignorepause(localclientnum, fx, 1);
        playsound(localclientnum, "zmb_fire_explode", self.origin);
    }
}

// Namespace namespace_293e8aad
// Params 7, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_bba3723b
// Checksum 0x79d741a7, Offset: 0x31b8
// Size: 0xf4
function function_bba3723b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_dedf9511 = self playloopsound("zmb_insta_kill_loop", 2);
        self thread function_69f683e7(localclientnum, 1);
        return;
    }
    self notify(#"hash_eb366021");
    playsound(localclientnum, "zmb_insta_kill_loop_off", (0, 0, 0));
    self stoploopsound(self.var_dedf9511);
    self thread function_69f683e7(localclientnum, 0);
}

// Namespace namespace_293e8aad
// Params 2, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_4778b020
// Checksum 0xc192107b, Offset: 0x32b8
// Size: 0x96
function function_4778b020(lo, hi) {
    color = (randomfloatrange(lo[0], hi[0]), randomfloatrange(lo[1], hi[1]), randomfloatrange(lo[2], hi[2]));
    return color;
}

// Namespace namespace_293e8aad
// Params 3, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_4b2bbece
// Checksum 0xb72a031b, Offset: 0x3358
// Size: 0xaa
function function_4b2bbece(var_3ae5c24, var_1bfa7cb7, frac) {
    var_8df9803f = 1 - frac;
    color = (var_8df9803f * var_3ae5c24[0] + frac * var_1bfa7cb7[0], var_8df9803f * var_3ae5c24[1] + frac * var_1bfa7cb7[1], var_8df9803f * var_3ae5c24[2] + frac * var_1bfa7cb7[2]);
    return color;
}

// Namespace namespace_293e8aad
// Params 2, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_69f683e7
// Checksum 0x3880a36a, Offset: 0x3410
// Size: 0x1ae
function function_69f683e7(localclientnum, onoff) {
    self notify(#"hash_bc7b7772");
    self endon(#"hash_bc7b7772");
    if (!onoff) {
        self setcontrollerlightbarcolor(localclientnum);
        return;
    }
    var_781fc232 = (63, 103, 4) / -1;
    var_27745be8 = (105, -108, 24) / -1;
    var_d7805253 = 2;
    var_ec055171 = 0.25;
    var_c051243b = var_d7805253;
    old_color = function_4778b020(var_781fc232, var_27745be8);
    new_color = old_color;
    while (isdefined(self)) {
        if (var_c051243b >= var_d7805253) {
            old_color = new_color;
            new_color = function_4778b020(var_781fc232, var_27745be8);
            var_c051243b = 0;
        }
        color = function_4b2bbece(old_color, new_color, var_c051243b / var_d7805253);
        self setcontrollerlightbarcolor(localclientnum, color);
        var_c051243b += var_ec055171;
        wait(var_ec055171);
    }
}

// Namespace namespace_293e8aad
// Params 2, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_d8c8d819
// Checksum 0x7ef3272b, Offset: 0x35c8
// Size: 0x1f4
function function_d8c8d819(localclientnum, overlaytype) {
    self endon(#"entityshutdown");
    self.var_13f5905e = 1;
    self duplicate_render::set_dr_flag("armor_on", 1);
    self duplicate_render::update_dr_filters(localclientnum);
    var_aa5d763a = "scriptVector3";
    var_fc81e73c = 0.1;
    var_f37ae0c5 = 0.56;
    var_197d5b2e = 0.92;
    var_776218ab = 1;
    var_93429fd9 = 0.2;
    if (overlaytype == "sparky") {
        var_754d7044 = 0.15;
        var_e754df7f = 0.5;
        var_595c4eba = 0.4;
        var_93429fd9 = 0.2;
    }
    if (overlaytype == "fire") {
        var_754d7044 = 0.6;
        var_e754df7f = 0.45;
        var_595c4eba = 0;
        var_93429fd9 = 0.2;
    }
    var_6c5c3132 = "scriptVector4";
    self mapshaderconstant(localclientnum, 0, var_aa5d763a, var_fc81e73c, var_754d7044, var_e754df7f, var_595c4eba);
    self mapshaderconstant(localclientnum, 0, var_6c5c3132, var_93429fd9, 0, 0, 0);
    self tmodesetflag(10);
}

// Namespace namespace_293e8aad
// Params 7, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_e4d833e
// Checksum 0xb848d41, Offset: 0x37c8
// Size: 0x4c4
function function_e4d833e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(newval)) {
        return;
    }
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval == 5) {
        if (getdvarstring("mapname") != "cp_mi_zurich_coalescence") {
            self stopallloopsounds(1);
            fx = playfx(localclientnum, level._effect["deimos_zombie_death"], self.origin + (0, 0, 35));
            setfxignorepause(localclientnum, fx, 1);
            fx = playfx(localclientnum, level._effect["zombie_sparky_death"], self.origin + (0, 0, 35));
            setfxignorepause(localclientnum, fx, 1);
            playsound(localclientnum, "zmb_deimoszomb_explo", self.origin);
            playrumbleonposition(localclientnum, "damage_light", self.origin);
        }
    }
    if (newval == 4) {
        self stopallloopsounds(1);
        fx = playfx(localclientnum, level._effect["zombie_sparky_attack_death"], self.origin + (0, 0, 35));
        setfxignorepause(localclientnum, fx, 1);
        playsound(localclientnum, "zmb_electrozomb_explo_small", self.origin);
        playrumbleonposition(localclientnum, "damage_light", self.origin);
    }
    if (newval == 3) {
        self stopallloopsounds(1);
        fx = playfx(localclientnum, level._effect["zombie_sparky_death"], self.origin + (0, 0, 35));
        setfxignorepause(localclientnum, fx, 1);
        playsound(localclientnum, "zmb_electrozomb_explo_large", self.origin);
        playrumbleonposition(localclientnum, "damage_light", self.origin);
    }
    if (newval == 2) {
        self stopallloopsounds(1);
        fx = playfx(localclientnum, level._effect["zombie_on_fire_suicide"], self.origin + (0, 0, 35));
        setfxignorepause(localclientnum, fx, 1);
        playsound(localclientnum, "zmb_fire_explode", self.origin);
        playrumbleonposition(localclientnum, "damage_light", self.origin);
    }
    if (newval > 0) {
        fxobj = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
        fxobj thread function_10dcbf51(localclientnum, fxobj);
    }
}

// Namespace namespace_293e8aad
// Params 2, eflags: 0x5 linked
// namespace_293e8aad<file_0>::function_10dcbf51
// Checksum 0xfe64b1bd, Offset: 0x3c98
// Size: 0x54
function private function_10dcbf51(localclientnum, fxobj) {
    fxobj playsound(localclientnum, "evt_ai_insta_explode");
    wait(1);
    fxobj delete();
}

// Namespace namespace_293e8aad
// Params 7, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_fe38007a
// Checksum 0x817d02bd, Offset: 0x3cf8
// Size: 0x10c
function zombie_gut_explosion_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        if (isdefined(level._effect["zombie_guts_explosion"])) {
            org = self gettagorigin("J_SpineLower");
            if (isdefined(org)) {
                fx = playfx(localclientnum, level._effect["zombie_guts_explosion"], org);
                setfxignorepause(localclientnum, fx, 1);
            }
        }
    }
}

// Namespace namespace_293e8aad
// Params 7, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_ab68bae5
// Checksum 0x34dd33e1, Offset: 0x3e10
// Size: 0x104
function function_ab68bae5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        if (isdefined(level._effect["zombie_sparky_trail"])) {
            self playloopsound("zmb_fire_burn_loop", 0.1);
            fx = playfxontag(localclientnum, level._effect["zombie_sparky_trail"], self, "tag_origin");
            setfxignorepause(localclientnum, fx, 1);
        }
    }
}

// Namespace namespace_293e8aad
// Params 7, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_14312cfd
// Checksum 0xbb5791e8, Offset: 0x3f20
// Size: 0xdc
function function_14312cfd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        if (isdefined(level._effect["zombie_sparky_impact"])) {
            fx = playfx(localclientnum, level._effect["zombie_sparky_impact"], self.origin);
            setfxignorepause(localclientnum, fx, 1);
        }
    }
}

// Namespace namespace_293e8aad
// Params 7, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_97590d4
// Checksum 0x6d6773bc, Offset: 0x4008
// Size: 0x154
function function_97590d4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        if (isdefined(level._effect["zombie_sparky_left_hand"])) {
            playsound(localclientnum, "gdt_electro_bounce", self.origin);
            fx = playfxontag(localclientnum, level._effect["zombie_sparky_left_hand"], self, "j_wrist_le");
            setfxignorepause(localclientnum, fx, 1);
            fx = playfxontag(localclientnum, level._effect["zombie_sparky_right_hand"], self, "j_wrist_ri");
            setfxignorepause(localclientnum, fx, 1);
        }
    }
}

// Namespace namespace_293e8aad
// Params 7, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_42f6f16e
// Checksum 0x5806b800, Offset: 0x4168
// Size: 0x104
function function_42f6f16e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        if (isdefined(level._effect["zombie_spawn"])) {
            playsound(localclientnum, "zmb_box_timeout_poof", self.origin);
            fx = playfx(localclientnum, level._effect["electric_spark"], self.origin);
            setfxignorepause(localclientnum, fx, 1);
        }
    }
}

// Namespace namespace_293e8aad
// Params 7, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_f900ae76
// Checksum 0x28af7915, Offset: 0x4278
// Size: 0x1dc
function function_f900ae76(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_3b8fa4f3)) {
        self.var_3b8fa4f3 = [];
    }
    if (newval && !isdefined(self.var_3b8fa4f3[localclientnum])) {
        fx_obj = spawn(localclientnum, self.origin, "script_model");
        fx_obj setmodel("tag_origin");
        fx_obj.angles = self.angles;
        fx = playfxontag(localclientnum, level._effect["chest_light"], fx_obj, "tag_origin");
        setfxignorepause(localclientnum, fx, 1);
        playsound(localclientnum, "zmb_lid_open", self.origin);
        playsound(localclientnum, "zmb_music_box", self.origin);
        self.var_3b8fa4f3[localclientnum] = fx_obj;
        self function_35040b8b(localclientnum);
        return;
    }
    if (!newval && isdefined(self.var_3b8fa4f3[localclientnum])) {
        self function_885d1f20(localclientnum);
    }
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_35040b8b
// Checksum 0xbae9b0e7, Offset: 0x4460
// Size: 0x3c
function function_35040b8b(localclientnum) {
    self endon(#"end_demo_jump_listener");
    level waittill(#"demo_jump");
    self function_885d1f20(localclientnum);
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_885d1f20
// Checksum 0x14a01640, Offset: 0x44a8
// Size: 0x46
function function_885d1f20(localclientnum) {
    self.var_3b8fa4f3[localclientnum] delete();
    self.var_3b8fa4f3[localclientnum] = undefined;
    self notify(#"end_demo_jump_listener");
}

// Namespace namespace_293e8aad
// Params 7, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_5eb1f58e
// Checksum 0x13912f4b, Offset: 0x44f8
// Size: 0x1e4
function function_5eb1f58e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.var_1dfe04a3)) {
        self.var_1dfe04a3 = [];
    }
    if (newval && !isdefined(self.var_1dfe04a3[localclientnum])) {
        fx_obj = spawn(localclientnum, self.origin, "script_model");
        fx_obj setmodel("tag_origin");
        fx_obj.angles = self.angles;
        fx = playfxontag(localclientnum, level._effect["chest_light_closed"], fx_obj, "tag_origin");
        setfxignorepause(localclientnum, fx, 1);
        playsound(localclientnum, "zmb_lid_close", self.origin);
        self.var_1dfe04a3[localclientnum] = fx_obj;
        self function_dc77ba5b(localclientnum);
        return;
    }
    if (!newval && isdefined(self.var_1dfe04a3[localclientnum])) {
        self function_b4a832f0(localclientnum);
    }
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_dc77ba5b
// Checksum 0xac813d0c, Offset: 0x46e8
// Size: 0x3c
function function_dc77ba5b(localclientnum) {
    self endon(#"end_demo_jump_listener");
    level waittill(#"demo_jump");
    self function_b4a832f0(localclientnum);
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_b4a832f0
// Checksum 0x50ad788a, Offset: 0x4730
// Size: 0x46
function function_b4a832f0(localclientnum) {
    self.var_1dfe04a3[localclientnum] delete();
    self.var_1dfe04a3[localclientnum] = undefined;
    self notify(#"end_demo_jump_listener");
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_aea4686a
// Checksum 0xf6e308f2, Offset: 0x4780
// Size: 0x17e
function function_aea4686a() {
    var_6a173bd1 = "gamedata/tables/cpzm/" + "cpzm_weapons_sgen.csv";
    numweapons = tablelookuprowcount(var_6a173bd1);
    var_709de245 = [];
    for (i = 0; i < numweapons; i++) {
        weaponname = tablelookupcolumnforrow(var_6a173bd1, i, 0);
        array::add(var_709de245, weaponname);
    }
    var_709de245 = array::randomize(var_709de245);
    for (i = 0; i < var_709de245.size; i++) {
        if (i >= 30) {
            break;
        }
        weapon = getweapon(var_709de245[i]);
        if (!isdefined(weapon)) {
            continue;
        }
        if (isdefined(weapon.worldmodel)) {
            addzombieboxweapon(weapon, weapon.worldmodel, 0);
        }
    }
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_8cf4b0ee
// Checksum 0xf5112e3b, Offset: 0x4908
// Size: 0xcc
function function_8cf4b0ee(localclientnum) {
    filter::map_material_helper(self, "generic_zombie_bblend_vignette");
    setfilterpassmaterial(self.localclientnum, 7, 0, filter::mapped_material_id("generic_zombie_bblend_vignette"));
    setfilterpassenabled(self.localclientnum, 7, 0, 1);
    setfilterpassconstant(self.localclientnum, 7, 0, 0, 1);
    setfilterpassconstant(self.localclientnum, 7, 0, 1, 0);
}

// Namespace namespace_293e8aad
// Params 7, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_7fc0e06
// Checksum 0xa993f20a, Offset: 0x49e0
// Size: 0x1cc
function function_7fc0e06(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval == 1) {
        playsound(localclientnum, "zmb_flashback_disappear_npc", self.origin);
        playfx(localclientnum, level._effect["zombie_spawn"], self.origin + (0, 0, 35));
        return;
    }
    if (newval == 2) {
        playsound(localclientnum, "zmb_flashback_reappear_npc", self.origin);
        playfx(localclientnum, level._effect["zombie_spawn"], self.origin + (0, 0, 35));
        return;
    }
    if (newval == 3) {
        playsound(localclientnum, "zmb_flashback_reappear_npc", self.origin);
        playfx(localclientnum, level._effect["zombie_spawn"], self.origin + (0, 0, 35));
    }
}

// Namespace namespace_293e8aad
// Params 7, eflags: 0x1 linked
// namespace_293e8aad<file_0>::function_2122d6fd
// Checksum 0xa8abe6bb, Offset: 0x4bb8
// Size: 0xd4
function function_2122d6fd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_673a9a22)) {
        level.var_673a9a22 = spawn(0, (0, 0, 0), "script_origin");
    }
    if (newval) {
        level.var_ed1ec8bc = level.var_673a9a22 playloopsound("zmb_cp_song_suppress");
        return;
    }
    if (isdefined(level.var_ed1ec8bc)) {
        level.var_673a9a22 stoploopsound(level.var_ed1ec8bc);
    }
}

