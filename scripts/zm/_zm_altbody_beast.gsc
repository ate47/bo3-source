#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_lightning_chain;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_bb;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_altbody;
#using scripts/zm/_zm;
#using scripts/zm/_util;
#using scripts/zm/zm_zod_util;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/weapons/grapple;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_215602b6;

// Namespace namespace_215602b6
// Params 0, eflags: 0x2
// Checksum 0x5f3c5e87, Offset: 0xb18
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_altbody_beast", &__init__, &__main__, undefined);
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0x4daa56fe, Offset: 0xb60
// Size: 0x5b2
function __init__() {
    clientfield::register("missile", "bminteract", 1, 2, "int");
    clientfield::register("scriptmover", "bminteract", 1, 2, "int");
    clientfield::register("actor", "bm_zombie_melee_kill", 1, 1, "int");
    clientfield::register("actor", "bm_zombie_grapple_kill", 1, 1, "int");
    clientfield::register("toplayer", "beast_blood_on_player", 1, 1, "counter");
    clientfield::register("world", "bm_superbeast", 1, 1, "int");
    level thread function_10dcd1d5("beast_mode_kiosk");
    loadout = array("zombie_beast_grapple_dwr", "zombie_beast_lightning_dwl", "zombie_beast_lightning_dwl2", "zombie_beast_lightning_dwl3");
    var_5a9f87fa = zm_weapons::create_loadout(loadout);
    var_55affbc1 = array("zm_bgb_disorderly_combat");
    zm_altbody::init("beast_mode", "beast_mode_kiosk", %ZM_ZOD_ENTER_BEAST_MODE, "zombie_beast_2", 123, var_5a9f87fa, 4, &function_1699b690, &function_b2631b3c, &function_ee30fba9, %ZM_ZOD_CANT_ENTER_BEAST_MODE, var_55affbc1);
    callback::on_connect(&player_on_connect);
    callback::on_spawned(&player_on_spawned);
    callback::on_player_killed(&function_fc79a296);
    level.var_87ee6f27 = 4;
    level._effect["human_disappears"] = "zombie/fx_bmode_transition_zmb";
    level._effect["zombie_disappears"] = "zombie/fx_bmode_transition_zmb";
    level._effect["beast_shock"] = "zombie/fx_tesla_shock_zmb";
    level._effect["beast_shock_box"] = "zombie/fx_bmode_dest_pwrbox_zod_zmb";
    level._effect["beast_melee_kill"] = "zombie/fx_bmode_attack_grapple_zod_zmb";
    level._effect["beast_grapple_kill"] = "zombie/fx_bmode_attack_grapple_zod_zmb";
    level._effect["beast_return_aoe"] = "zombie/fx_bmode_attack_grapple_zod_zmb";
    level._effect["beast_return_aoe_kill"] = "zombie/fx_bmode_attack_grapple_zod_zmb";
    level._effect["beast_shock_aoe"] = "zombie/fx_bmode_shock_lvl3_zod_zmb";
    level._effect["beast_3p_trail"] = "zombie/fx_bmode_trail_3p_zod_zmb";
    level.var_f543d7da = &function_f543d7da;
    level.var_8a41ce54 = &function_8a41ce54;
    level.var_f8094267 = 120;
    level.var_46473359 = 0;
    zm_spawner::register_zombie_damage_callback(&function_f4ee06b4);
    zm_spawner::register_zombie_death_event_callback(&function_d166ff57);
    /#
        thread function_ae9ea3e4();
    #/
    triggers = getentarray("trig_beast_mode_kiosk", "targetname");
    foreach (trigger in triggers) {
        trigger delete();
    }
    triggers = getentarray("trig_beast_mode_kiosk_unavailable", "targetname");
    foreach (trigger in triggers) {
        trigger delete();
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0x9f6a4b4c, Offset: 0x1120
// Size: 0x94
function __main__() {
    thread function_31a1c2c8();
    thread function_d0eeb393();
    thread function_feaada2a();
    thread function_7de05274();
    zm_spawner::add_custom_zombie_spawn_logic(&function_a51e085);
    create_lightning_params();
    level.var_f68f0aeb = getweapon("syrette_zod_beast");
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0x6948187d, Offset: 0x11c0
// Size: 0x1e
function function_5613b340(extra_time) {
    if (!isdefined(extra_time)) {
        extra_time = 0;
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0x23858842, Offset: 0x11e8
// Size: 0x24
function function_9f177855(washuman) {
    self ghost();
}

// Namespace namespace_215602b6
// Params 2, eflags: 0x0
// Checksum 0x951f79e5, Offset: 0x1218
// Size: 0x5c4
function function_1699b690(name, trigger) {
    /#
        assert(!(isdefined(self.beastmode) && self.beastmode));
    #/
    self notify(#"clear_red_flashing_overlay");
    self disableoffhandweapons();
    self zm_weapons::suppress_stowed_weapon(1);
    self function_d60ab790(1);
    self function_cf361e94(1);
    self.var_e98bf35e = self.var_b2356a6c;
    self.var_806d7078 = self.var_227fe352;
    self zm_utility::create_streamer_hint(self.origin, self.angles + (0, 180, 0), 0.25);
    self thread function_5613b340();
    self playsound("evt_beastmode_enter");
    if (!isdefined(self.firsttime)) {
        self.firsttime = 1;
        level.var_9ecbc81 = self.characterindex;
        level notify(#"hash_571c8e3c");
    }
    self function_9f177855(1);
    self.var_a1e8a771 = self.overrideplayerdamage;
    self.overrideplayerdamage = &function_2ff8ae81;
    self.weaponrevivetool = level.var_f68f0aeb;
    self.get_revive_time = &function_5b552caf;
    self zm_utility::function_139befeb();
    self.beastmode = 1;
    self.inhibit_scoring_from_zombies = 1;
    self flag::set("in_beastmode");
    bb::logplayerevent(self, "enter_beast_mode");
    self recordmapevent(1, gettime(), self.origin, level.round_number);
    self allowstand(1);
    self allowprone(0);
    self allowcrouch(0);
    self allowads(0);
    self allowjump(1);
    self allowslide(0);
    self setmovespeedscale(1);
    self function_ba25e637(4);
    self function_e67885f8(0);
    self function_a1b60d91(1);
    self zm_utility::increment_is_drinking();
    self stopshellshock();
    self setperk("specialty_unlimitedsprint");
    self setperk("specialty_fallheight");
    self setperk("specialty_lowgravity");
    wait(0.1);
    self show();
    self thread function_d52a054b();
    self thread function_568f6019();
    self thread function_85f2cde9();
    self thread function_e8aacc36();
    self thread function_8b382e19();
    self thread function_89419316();
    self thread function_5e1ffae();
    self thread function_ce0d3f8c();
    self thread function_f893b14f();
    self thread function_126b475f();
    self thread function_19356f33();
    self thread function_92acebd3();
    if (level clientfield::get("bm_superbeast")) {
        self function_5c185b9f();
    }
    /#
        var_1ee18766 = getdvarint("trig_beast_mode_kiosk") > 0;
        self thread function_5d7a94fa();
    #/
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0xac0b168c, Offset: 0x17e8
// Size: 0x18a
function function_5d7a94fa(localclientnum) {
    self endon(#"hash_b2631b3c");
    var_3f39d2cc = 0;
    while (isdefined(self)) {
        var_1ee18766 = getdvarint("scr_beast_no_visionset") > 0;
        if (var_1ee18766 != var_3f39d2cc) {
            name = "beast_mode";
            visionset = "zombie_beast_2";
            if (var_1ee18766) {
                if (isdefined(visionset)) {
                    visionset_mgr::deactivate("visionset", visionset, self);
                    self.altbody_visionset[name] = 0;
                }
            } else if (isdefined(visionset)) {
                if (isdefined(self.altbody_visionset[name]) && self.altbody_visionset[name]) {
                    visionset_mgr::deactivate("visionset", visionset, self);
                    util::wait_network_frame();
                    util::wait_network_frame();
                    if (!isdefined(self)) {
                        return;
                    }
                }
                visionset_mgr::activate("visionset", visionset, self);
                self.altbody_visionset[name] = 1;
            }
        }
        var_3f39d2cc = var_1ee18766;
        wait(1);
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xd776b18, Offset: 0x1980
// Size: 0xd4
function function_5c185b9f() {
    self zm_utility::function_36f941b3();
    self.var_e3e3d706 = 1;
    self.see_kiosks_in_altbody = 1;
    self.trigger_kiosks_in_altbody = 1;
    self.custom_altbody_callback = &function_57c301a6;
    self disableinvulnerability();
    self thread function_f3cafba8();
    bb::logplayerevent(self, "enter_superbeast_mode");
    self recordmapevent(2, gettime(), self.origin, level.round_number);
}

// Namespace namespace_215602b6
// Params 2, eflags: 0x0
// Checksum 0x889b4317, Offset: 0x1a60
// Size: 0x5c
function function_57c301a6(trigger, name) {
    level notify(#"kiosk_used", trigger.kiosk);
    self.var_e3e3d706 = 1;
    self function_a1b60d91(1);
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xee3daed4, Offset: 0x1ac8
// Size: 0x34
function function_f3cafba8() {
    self endon(#"hash_b2631b3c");
    while (isdefined(self)) {
        self.var_39f3c137 = self.var_e3e3d706;
        wait(0.05);
    }
}

// Namespace namespace_215602b6
// Params 2, eflags: 0x0
// Checksum 0xc48b8418, Offset: 0x1b08
// Size: 0x3a4
function function_b2631b3c(name, trigger) {
    /#
        assert(isdefined(self.beastmode) && self.beastmode);
    #/
    self notify(#"clear_red_flashing_overlay");
    self thread function_5613b340(0);
    self function_9f177855(0);
    self function_a1b60d91(0);
    if (self isthrowinggrenade()) {
        self forcegrenadethrow();
    }
    if (false) {
        wait(0);
    }
    self notify(#"hash_b2631b3c");
    bb::logplayerevent(self, "exit_beast_mode");
    self thread function_2d0dc9ac(2);
    self thread function_a8f77c9b(3);
    while (isdefined(self.teleporting) && (self isthrowinggrenade() || self isgrappling() || self.teleporting)) {
        wait(0.05);
    }
    self unsetperk("specialty_unlimitedsprint");
    self unsetperk("specialty_fallheight");
    self unsetperk("specialty_lowgravity");
    self setmovespeedscale(1);
    self allowstand(1);
    self allowprone(1);
    self allowcrouch(1);
    self allowads(1);
    self allowjump(1);
    self allowdoublejump(0);
    self allowslide(1);
    self stopshellshock();
    self.inhibit_scoring_from_zombies = 0;
    self.beastmode = 0;
    self flag::clear("in_beastmode");
    self.get_revive_time = undefined;
    self.weaponrevivetool = undefined;
    self.overrideplayerdamage = self.var_a1e8a771;
    self.var_a1e8a771 = undefined;
    if (level clientfield::get("bm_superbeast")) {
        var_66a6ef71 = 1;
        self.var_e3e3d706 = 0;
        self.see_kiosks_in_altbody = 0;
        self.trigger_kiosks_in_altbody = 0;
        self.custom_altbody_callback = undefined;
    } else {
        var_66a6ef71 = 0;
    }
    self thread function_2af409b0(var_66a6ef71);
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0x1617416e, Offset: 0x1eb8
// Size: 0x644
function function_2af409b0(var_ee3c4cad) {
    self setorigin(self.var_e98bf35e);
    self freezecontrols(1);
    v_return_pos = self.var_e98bf35e + (0, 0, 60);
    a_ai = getaiteamarray(level.zombie_team);
    a_closest = [];
    ai_closest = undefined;
    if (a_ai.size) {
        a_closest = arraysortclosest(a_ai, self.var_e98bf35e);
        foreach (ai in a_closest) {
            n_trace_val = ai sightconetrace(v_return_pos, self);
            if (n_trace_val > 0.2) {
                ai_closest = ai;
                break;
            }
        }
        if (isdefined(ai_closest)) {
            self setplayerangles(vectortoangles(ai_closest getcentroid() - v_return_pos));
        }
    }
    /#
        if (getdvarint("beast_hint_shown") > 1) {
            ai_closest = self;
            self enableinvulnerability();
        }
    #/
    if (!isdefined(ai_closest)) {
        self setplayerangles(self.var_806d7078 + (0, 180, 0));
    }
    wait(0.5);
    self zm_utility::decrement_is_drinking();
    self zm_weapons::suppress_stowed_weapon(0);
    self show();
    self playsound("evt_beastmode_exit");
    self zm_utility::clear_streamer_hint();
    playfx(level._effect["human_disappears"], self.var_e98bf35e);
    playfx(level._effect["beast_return_aoe"], self.var_e98bf35e);
    a_ai = getaiarray();
    a_aoe_ai = arraysortclosest(a_ai, self.var_e98bf35e, a_ai.size, 0, -56);
    foreach (ai in a_aoe_ai) {
        if (isactor(ai)) {
            if (ai.archetype === "zombie") {
                playfx(level._effect["beast_return_aoe_kill"], ai gettagorigin("j_spineupper"));
            } else {
                playfx(level._effect["beast_return_aoe_kill"], ai.origin);
            }
            ai.no_powerups = 1;
            ai.marked_for_recycle = 1;
            ai.has_been_damaged_by_player = 0;
            ai.deathpoints_already_given = 1;
            ai dodamage(ai.health + 1000, self.var_e98bf35e, self);
        }
    }
    wait(0.2);
    if (self zm::in_kill_brush() || !self zm::in_life_brush() && !self zm::in_enabled_playable_area()) {
        wait(3);
    }
    if (isdefined(self.firsttime) && self.firsttime) {
        self.firsttime = 0;
    }
    if (!level.intermission) {
        self freezecontrols(0);
    }
    wait(3);
    var_a315b31f = level clientfield::get("bm_superbeast");
    if (!var_ee3c4cad && !var_a315b31f) {
        self zm_utility::function_36f941b3();
    }
    level notify(#"hash_43352218", self);
    self thread zm_audio::create_and_play_dialog("beastmode", "exit");
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0xc0a4ab60, Offset: 0x2508
// Size: 0x64
function function_2d0dc9ac(time) {
    var_8a32e9d8 = self enableinvulnerability();
    wait(time);
    if (isdefined(self) && !(isdefined(var_8a32e9d8) && var_8a32e9d8)) {
        self disableinvulnerability();
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0x3ecb7f90, Offset: 0x2578
// Size: 0x170
function function_a8f77c9b(time) {
    self disableoffhandweapons();
    wait(time);
    if (isdefined(self)) {
        self enableoffhandweapons();
    }
    if (isdefined(self.var_9fbddc54) && self.var_9fbddc54) {
        lethal_grenade = self zm_utility::get_player_lethal_grenade();
        if (!self hasweapon(lethal_grenade)) {
            self giveweapon(lethal_grenade);
            self setweaponammoclip(lethal_grenade, 0);
        }
        frac = self getfractionmaxammo(lethal_grenade);
        if (frac < 0.25) {
            self setweaponammoclip(lethal_grenade, 2);
        } else if (frac < 0.5) {
            self setweaponammoclip(lethal_grenade, 3);
        } else {
            self setweaponammoclip(lethal_grenade, 4);
        }
    }
    self.var_9fbddc54 = 0;
}

// Namespace namespace_215602b6
// Params 2, eflags: 0x0
// Checksum 0xd0755861, Offset: 0x26f0
// Size: 0xe8
function function_ee30fba9(name, kiosk) {
    var_a315b31f = level clientfield::get("bm_superbeast");
    if (!level flagsys::get("start_zombie_round_logic")) {
        return false;
    }
    if (isdefined(self.beastmode) && self.beastmode && !var_a315b31f) {
        return false;
    }
    if (isdefined(kiosk) && !function_de85da07(kiosk)) {
        return false;
    }
    if (level clientfield::get("bm_superbeast")) {
        return true;
    }
    return self.beastlives >= 1;
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0xedc001eb, Offset: 0x27e0
// Size: 0x30
function function_de85da07(kiosk) {
    return !(isdefined(kiosk.var_b55b4180) && kiosk.var_b55b4180);
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0x124c36e8, Offset: 0x2818
// Size: 0x24
function player_on_connect() {
    self flag::init("in_beastmode");
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xafa1d322, Offset: 0x2848
// Size: 0xbc
function player_on_spawned() {
    level flag::wait_till("initial_players_connected");
    self.var_39f3c137 = 1;
    if (level flag::get("solo_game")) {
        self.beastlives = 3;
    } else {
        self.beastlives = 1;
    }
    self thread function_437c4521();
    self thread function_5b1b9438();
    self function_a1b60d91(0);
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0x34c86644, Offset: 0x2910
// Size: 0x60
function function_7de05274() {
    while (true) {
        powerup = level waittill(#"powerup_dropped");
        powerup.var_f9127ea5 = 2;
        powerup setgrapplabletype(powerup.var_f9127ea5);
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0x2bf244e, Offset: 0x2978
// Size: 0x14a
function function_10dcd1d5(kiosk_name) {
    level.var_8ad0ec05 = struct::get_array(kiosk_name, "targetname");
    foreach (kiosk in level.var_8ad0ec05) {
        kiosk.var_80eeb471 = kiosk_name + "_plr_" + kiosk.origin;
        kiosk.var_39a60f4a = kiosk_name + "_crs_" + kiosk.origin;
        clientfield::register("world", kiosk.var_80eeb471, 1, 4, "int");
        kiosk thread function_7237145f();
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xe13fc731, Offset: 0x2ad0
// Size: 0x168
function function_437c4521() {
    self endon(#"death");
    while (isdefined(self)) {
        n_ent_num = self getentitynumber();
        foreach (kiosk in level.var_8ad0ec05) {
            var_7e9601ff = level clientfield::get(kiosk.var_80eeb471);
            if (function_de85da07(kiosk)) {
                var_7e9601ff |= 1 << n_ent_num;
            } else {
                var_7e9601ff &= ~(1 << n_ent_num);
            }
            level clientfield::set(kiosk.var_80eeb471, var_7e9601ff);
        }
        wait(randomfloatrange(0.2, 0.5));
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0x9c35d71a, Offset: 0x2c40
// Size: 0xa6
function function_61dc030a() {
    var_ff430db0 = 0;
    foreach (kiosk in level.var_8ad0ec05) {
        if (function_de85da07(kiosk)) {
            var_ff430db0++;
        }
    }
    return var_ff430db0;
}

// Namespace namespace_215602b6
// Params 2, eflags: 0x0
// Checksum 0x4abcec3b, Offset: 0x2cf0
// Size: 0xf6
function function_f6014f2c(v_origin, var_8ebf7724) {
    var_21d6ddcd = arraysortclosest(level.var_8ad0ec05, v_origin);
    var_21d6ddcd = array::filter(var_21d6ddcd, 0, &function_b7520b09);
    for (i = 0; i < var_21d6ddcd.size && i < var_8ebf7724; i++) {
        namespace_8e578893::function_5cc835d6(v_origin, var_21d6ddcd[i].origin, 1);
        var_21d6ddcd[i].var_b55b4180 = 0;
        wait(0.05);
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0xe9206972, Offset: 0x2df0
// Size: 0x48
function function_b7520b09(var_20fdcbbc) {
    if (!isdefined(var_20fdcbbc) || !isdefined(var_20fdcbbc.var_b55b4180) || !var_20fdcbbc.var_b55b4180) {
        return false;
    }
    return true;
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0x652dc63a, Offset: 0x2e40
// Size: 0x48
function function_feaada2a() {
    while (true) {
        var_a67f7e = level waittill(#"kiosk_used");
        if (isdefined(var_a67f7e)) {
            var_a67f7e thread function_7237145f();
        }
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0x3b7a2c2f, Offset: 0x2e90
// Size: 0x30
function round_number() {
    n_start_round = 0;
    if (isdefined(level.round_number)) {
        n_start_round = level.round_number;
    }
    return n_start_round;
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xa7e37804, Offset: 0x2ec8
// Size: 0x88
function function_7237145f() {
    self notify(#"hash_7237145f");
    self endon(#"hash_7237145f");
    self.var_b55b4180 = 1;
    n_start_round = round_number();
    while (round_number() - n_start_round < 1) {
        level waittill(#"start_of_round");
    }
    self.var_b55b4180 = 0;
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0x2af48d55, Offset: 0x2f58
// Size: 0x10e
function function_fd8fb00d(b_cooldown) {
    if (!isdefined(b_cooldown)) {
        b_cooldown = 1;
    }
    foreach (kiosk in level.var_8ad0ec05) {
        if (b_cooldown) {
            if (!(isdefined(kiosk.var_b55b4180) && kiosk.var_b55b4180)) {
                kiosk thread function_7237145f();
            }
            continue;
        }
        if (isdefined(kiosk.var_b55b4180) && kiosk.var_b55b4180) {
            kiosk.var_b55b4180 = 0;
        }
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xf193c9da, Offset: 0x3070
// Size: 0xe0
function function_19356f33() {
    self endon(#"hash_b2631b3c");
    self endon(#"death");
    if (!self flag::exists("beast_hint_shown")) {
        self flag::init("beast_hint_shown");
    }
    if (!self flag::get("beast_hint_shown")) {
        self thread function_cbcaefc5();
    }
    self.var_6f14dca1 = 0;
    while (isdefined(self)) {
        if (self stancebuttonpressed()) {
            self notify(#"hide_equipment_hint_text");
            self function_19b30216();
        }
        wait(0.05);
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xf6b53b9c, Offset: 0x3158
// Size: 0xbc
function function_cbcaefc5() {
    hint = %ZM_ZOD_EXIT_BEAST_MODE_HINT;
    y = 315;
    if (level.players.size > 1) {
        hint = %ZM_ZOD_EXIT_BEAST_MODE_HINT_COOP;
        y = 285;
    }
    self thread function_371979a2(12, 12.05);
    self thread function_59ecc704(12, 12.05);
    zm_equipment::show_hint_text(hint, 12.05, 1.5, y);
}

// Namespace namespace_215602b6
// Params 2, eflags: 0x0
// Checksum 0x36fdeceb, Offset: 0x3220
// Size: 0x74
function function_371979a2(mintime, maxtime) {
    self endon(#"disconnect");
    self util::waittill_any_timeout(maxtime, "smashable_smashed", "grapplable_grappled", "shockable_shocked", "disconnect");
    self flag::set("beast_hint_shown");
}

// Namespace namespace_215602b6
// Params 2, eflags: 0x0
// Checksum 0xd3825f44, Offset: 0x32a0
// Size: 0x62
function function_59ecc704(mintime, maxtime) {
    self endon(#"disconnect");
    wait(mintime);
    if (isdefined(self)) {
        self flag::wait_till_timeout(maxtime - mintime, "beast_hint_shown");
        self notify(#"hide_equipment_hint_text");
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xf3d55f35, Offset: 0x3310
// Size: 0x82
function function_19b30216() {
    self thread function_3236486a();
    retval = self util::waittill_any_return("exit_succeed", "exit_failed");
    if (retval == "exit_succeed") {
        self notify(#"altbody_end");
        return true;
    }
    self.var_6f14dca1 = 0;
    return false;
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0x2d958236, Offset: 0x33a0
// Size: 0x7a
function function_92acebd3() {
    self endon(#"hash_b2631b3c");
    self endon(#"death");
    self waittill(#"player_did_a_revive");
    self playrumbleonentity("damage_heavy");
    wait(1.5);
    self function_bd84f46(1);
    self notify(#"altbody_end");
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xe613f32b, Offset: 0x3428
// Size: 0x5a
function function_4c24c0fb() {
    if (self isthrowinggrenade()) {
        return false;
    }
    if (!self stancebuttonpressed()) {
        return false;
    }
    if (isdefined(self.teleporting) && self.teleporting) {
        return false;
    }
    return true;
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xee455655, Offset: 0x3490
// Size: 0xf6
function function_3236486a() {
    wait(0.05);
    if (!isdefined(self)) {
        self notify(#"hash_59d92a3f");
        return;
    }
    self.var_6f14dca1 = gettime();
    build_time = 1000;
    self thread function_bf841805(self.var_6f14dca1, build_time);
    while (isdefined(self) && self function_4c24c0fb() && gettime() - self.var_6f14dca1 < build_time) {
        wait(0.05);
    }
    if (isdefined(self) && self function_4c24c0fb() && gettime() - self.var_6f14dca1 >= build_time) {
        self notify(#"hash_a7925b74");
        return;
    }
    self notify(#"hash_59d92a3f");
}

// Namespace namespace_215602b6
// Params 2, eflags: 0x0
// Checksum 0x69cf82f1, Offset: 0x3590
// Size: 0xc4
function function_bf841805(start_time, build_time) {
    self.usebar = self hud::createprimaryprogressbar();
    self.var_6adb8298 = self hud::createprimaryprogressbartext();
    self.var_6adb8298 settext(%ZM_ZOD_EXIT_BEAST_MODE);
    self player_progress_bar_update(start_time, build_time);
    self.var_6adb8298 hud::destroyelem();
    self.usebar hud::destroyelem();
}

// Namespace namespace_215602b6
// Params 2, eflags: 0x0
// Checksum 0x1b7c2c19, Offset: 0x3660
// Size: 0xd0
function player_progress_bar_update(start_time, build_time) {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"hash_b2631b3c");
    self endon(#"hash_59d92a3f");
    while (isdefined(self) && gettime() - start_time < build_time) {
        progress = (gettime() - start_time) / build_time;
        if (progress < 0) {
            progress = 0;
        }
        if (progress > 1) {
            progress = 1;
        }
        self.usebar hud::updatebar(progress);
        wait(0.05);
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0xe16133d8, Offset: 0x3738
// Size: 0x52
function function_bd84f46(mana) {
    self.var_39f3c137 -= mana;
    if (self.var_39f3c137 <= 0) {
        self.var_39f3c137 = 0;
        self notify(#"altbody_end");
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0xdcf78a2c, Offset: 0x3798
// Size: 0x7c
function function_20873276(lives) {
    self.beastlives += lives;
    if (level flag::get("solo_game")) {
        if (self.beastlives > 3) {
            self.beastlives = 3;
        }
        return;
    }
    if (self.beastlives > 1) {
        self.beastlives = 1;
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0xc75e794e, Offset: 0x3820
// Size: 0x38
function function_cf361e94(lives) {
    self.beastlives -= lives;
    if (self.var_39f3c137 <= 0) {
        self.beastlives = 0;
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0x456c4fc5, Offset: 0x3860
// Size: 0x44
function function_d60ab790(mana) {
    self.var_39f3c137 += mana;
    if (self.var_39f3c137 > 1) {
        self.var_39f3c137 = 1;
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0x66739cd9, Offset: 0x38b0
// Size: 0x12
function function_5b552caf(player_being_revived) {
    return 0.75;
}

// Namespace namespace_215602b6
// Params 10, eflags: 0x0
// Checksum 0x338aec33, Offset: 0x38d0
// Size: 0x1fe
function function_2ff8ae81(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    if (isdefined(eattacker) && isplayer(eattacker)) {
        return false;
    }
    var_a315b31f = level clientfield::get("bm_superbeast");
    if (var_a315b31f) {
        var_cc3794d8 = idamage * 0.0005;
        if (var_cc3794d8 > 0.4) {
            var_cc3794d8 = 0.4;
            self thread namespace_8e578893::function_6edf48d5(3);
        } else {
            self thread namespace_8e578893::function_6edf48d5(2);
        }
        self.var_e3e3d706 -= var_cc3794d8;
        if (self.var_e3e3d706 <= 0) {
            self notify(#"altbody_end");
            self function_bd84f46(1);
            self.beastlives = 1;
        }
        return false;
    }
    if (isdefined(eattacker.is_zombie) && eattacker.is_zombie || isdefined(eattacker) && eattacker.team === level.zombie_team) {
        return false;
    }
    if (idamage < self.health) {
        return false;
    }
    self notify(#"altbody_end");
    self function_bd84f46(1);
    return false;
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0x31104357, Offset: 0x3ad8
// Size: 0x28
function function_c35feb1f() {
    if (isdefined(self.beastmode) && self.beastmode) {
        self.var_9fbddc54 = 1;
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0x9dd5268e, Offset: 0x3b08
// Size: 0x19e
function function_31a1c2c8() {
    level waittill(#"start_of_round");
    foreach (player in getplayers()) {
        player function_c35feb1f();
    }
    while (true) {
        level waittill(#"start_of_round");
        foreach (player in getplayers()) {
            if (!(isdefined(player.beastmode) && player.beastmode)) {
                player function_d60ab790(1);
            }
            player function_20873276(1);
            player function_c35feb1f();
        }
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0x7d4503f1, Offset: 0x3cb0
// Size: 0x1f8
function function_5b1b9438() {
    if (!isdefined(self.var_e3e3d706)) {
        self.var_e3e3d706 = 0;
    }
    self notify(#"hash_5b1b9438");
    self endon(#"hash_5b1b9438");
    while (isdefined(self)) {
        if (isdefined(level.hostmigrationtimer) && level.hostmigrationtimer) {
            wait(1);
            continue;
        }
        if (isdefined(self.beastmode) && self.beastmode && !(isdefined(self.teleporting) && self.teleporting)) {
            self function_bd84f46(1 / 500);
        }
        if (level clientfield::get("bm_superbeast")) {
            var_b779efbd = math::linear_map(self.var_e3e3d706, 0, 1, 0, 1);
        } else {
            var_b779efbd = math::linear_map(self.var_39f3c137, 0, 1, 0, 1);
        }
        self clientfield::set_player_uimodel("player_mana", var_b779efbd);
        lives = self.beastlives;
        if (lives != self clientfield::get_player_uimodel("player_lives")) {
            function_20873276(0);
            lives = self.beastlives;
            self clientfield::set_player_uimodel("player_lives", lives);
        }
        wait(0.05);
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0x12bfb3ad, Offset: 0x3eb0
// Size: 0x2c
function function_fc79a296() {
    self notify(#"altbody_end");
    self function_bd84f46(1);
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xf77787bb, Offset: 0x3ee8
// Size: 0x114
function function_d0eeb393() {
    level flagsys::wait_till("start_zombie_round_logic");
    var_80ae6062 = getentarray("ooze_only", "script_noteworthy");
    array::thread_all(var_80ae6062, &function_2438ef4);
    var_dd0c264 = getentarray("beast_melee_only", "script_noteworthy");
    array::thread_all(var_dd0c264, &function_bc086a4b);
    goo = getentarray("beast_grapple_only", "script_noteworthy");
    array::thread_all(goo, &function_815e92f8);
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0xb2db1481, Offset: 0x4008
// Size: 0x144
function function_a1b60d91(onoff) {
    var_f023f29 = getentarray("beast_mode", "script_noteworthy");
    if (isdefined(level.var_8e51f1a6)) {
        var_fcc5f199 = [[ level.var_8e51f1a6 ]]();
        var_f023f29 = arraycombine(var_f023f29, var_fcc5f199, 0, 0);
    }
    array::run_all(var_f023f29, &function_77fcc1c2, self, onoff);
    var_66757da5 = getentarray("not_beast_mode", "script_noteworthy");
    if (isdefined(level.var_692ed1bb)) {
        var_a225fe35 = [[ level.var_692ed1bb ]]();
        var_66757da5 = arraycombine(var_66757da5, var_a225fe35, 0, 0);
    }
    array::run_all(var_66757da5, &function_77fcc1c2, self, !onoff);
}

// Namespace namespace_215602b6
// Params 2, eflags: 0x0
// Checksum 0x83e9767, Offset: 0x4158
// Size: 0x54
function function_77fcc1c2(player, onoff) {
    if (onoff) {
        self setvisibletoplayer(player);
        return;
    }
    self setinvisibletoplayer(player);
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xcd3a3065, Offset: 0x41b8
// Size: 0x52
function function_e8aacc36() {
    self endon(#"hash_b2631b3c");
    self endon(#"death");
    while (isdefined(self)) {
        weapon = self waittill(#"weapon_melee_charge");
        self notify(#"weapon_melee", weapon);
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0x2612113f, Offset: 0x4218
// Size: 0x52
function function_85f2cde9() {
    self endon(#"hash_b2631b3c");
    self endon(#"death");
    while (isdefined(self)) {
        weapon = self waittill(#"weapon_melee_power");
        self notify(#"weapon_melee", weapon);
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xd92da702, Offset: 0x4278
// Size: 0x150
function function_d52a054b() {
    self endon(#"hash_b2631b3c");
    self endon(#"death");
    while (isdefined(self)) {
        weapon = self waittill(#"weapon_melee");
        if (weapon == getweapon("zombie_beast_grapple_dwr")) {
            self function_bd84f46(0.03);
            forward = anglestoforward(self getplayerangles());
            up = anglestoup(self getplayerangles());
            var_1a423f4f = self.origin + 15 * up + 30 * forward;
            level notify(#"hash_4841db", self, var_1a423f4f);
            self radiusdamage(var_1a423f4f, 48, 5000, 5000, self, "MOD_MELEE");
        }
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xa8e0104, Offset: 0x43d0
// Size: 0x78
function function_568f6019() {
    self endon(#"hash_b2631b3c");
    self endon(#"death");
    while (isdefined(self)) {
        weapon = self waittill(#"weapon_melee_juke");
        if (weapon == getweapon("zombie_beast_grapple_dwr")) {
            function_bbdbb11d(weapon);
        }
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0xd972a214, Offset: 0x4450
// Size: 0x78
function function_bbdbb11d(weapon) {
    self endon(#"weapon_melee");
    self endon(#"weapon_melee_power");
    self endon(#"weapon_melee_charge");
    start_time = gettime();
    while (start_time + 3000 > gettime()) {
        self playrumbleonentity("zod_beast_juke");
        wait(0.1);
    }
}

// Namespace namespace_215602b6
// Params 2, eflags: 0x0
// Checksum 0xb66ea038, Offset: 0x44d0
// Size: 0x7a
function function_b484a03e(var_1a423f4f, radius) {
    mins = (radius * -1, radius * -1, radius * -1);
    maxs = (radius, radius, radius);
    return self istouchingvolume(var_1a423f4f, mins, maxs);
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0x1b4878ed, Offset: 0x4558
// Size: 0x110
function function_bc086a4b() {
    self endon(#"death");
    level flagsys::wait_till("start_zombie_round_logic");
    if (isdefined(self.target)) {
        target = getent(self.target, "targetname");
        if (isdefined(target)) {
            target enableaimassist();
        }
    }
    self setinvisibletoall();
    while (isdefined(self)) {
        player, var_1a423f4f = level waittill(#"hash_4841db");
        if (isdefined(self) && self function_b484a03e(var_1a423f4f, 48)) {
            self useby(player);
        }
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0x7c1ed15, Offset: 0x4670
// Size: 0x80
function function_4c03fac9(weapon) {
    if (!isdefined(weapon)) {
        return false;
    }
    if (weapon == getweapon("zombie_beast_lightning_dwl") || weapon == getweapon("zombie_beast_lightning_dwl2") || weapon == getweapon("zombie_beast_lightning_dwl3")) {
        return true;
    }
    return false;
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0x52374b7b, Offset: 0x46f8
// Size: 0x90
function function_cebfc03f(weapon) {
    if (!isdefined(weapon)) {
        return 0;
    }
    if (weapon == getweapon("zombie_beast_lightning_dwl")) {
        return 1;
    }
    if (weapon == getweapon("zombie_beast_lightning_dwl2")) {
        return 2;
    }
    if (weapon == getweapon("zombie_beast_lightning_dwl3")) {
        return 3;
    }
    return 0;
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xb9ddc1d7, Offset: 0x4790
// Size: 0xa0
function function_8b382e19() {
    self endon(#"hash_b2631b3c");
    self endon(#"death");
    self.tesla_enemies = undefined;
    self.tesla_enemies_hit = 0;
    self.var_691298ec = 0;
    self.tesla_arc_count = 0;
    while (isdefined(self)) {
        weapon = self waittill(#"weapon_fired");
        if (function_4c03fac9(weapon)) {
            self function_bd84f46(0);
        }
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0x3f65ba91, Offset: 0x4838
// Size: 0x280
function function_8ee03bb5(weapon) {
    self endon(#"disconnect");
    self.tesla_enemies = undefined;
    self.tesla_enemies_hit = 0;
    self.var_691298ec = 0;
    self.tesla_arc_count = 0;
    shocklevel = function_cebfc03f(weapon);
    var_96f81bff = 36;
    switch (shocklevel) {
    case 2:
        var_96f81bff = 72;
        break;
    case 3:
        var_96f81bff = 108;
        break;
    }
    forward = anglestoforward(self getplayerangles());
    up = anglestoup(self getplayerangles());
    center = self.origin + 16 * up + 24 * forward;
    if (shocklevel > 1) {
        playfx(level._effect["beast_shock_aoe"], center);
    }
    zombies = array::get_all_closest(center, getaiteamarray(level.zombie_team), undefined, undefined, var_96f81bff);
    foreach (zombie in zombies) {
        zombie thread arc_damage_init(zombie.origin, center, self, shocklevel);
        zombie notify(#"bhtn_action_notify", "electrocute");
    }
    wait(0.05);
    self.tesla_enemies_hit = 0;
}

// Namespace namespace_215602b6
// Params 4, eflags: 0x0
// Checksum 0xccae80da, Offset: 0x4ac0
// Size: 0xdc
function arc_damage_init(hit_location, var_8a2b6fe5, player, shocklevel) {
    player endon(#"disconnect");
    if (isdefined(self.var_128cd975) && self.var_128cd975) {
        return;
    }
    if (shocklevel < 2) {
        self lightning_chain::arc_damage(self, player, 1, level.var_3a2dca1e);
        return;
    }
    if (shocklevel < 3) {
        self lightning_chain::arc_damage(self, player, 1, level.var_142b4fb5);
        return;
    }
    self lightning_chain::arc_damage(self, player, 1, level.var_ee28d54c);
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0x34dc2009, Offset: 0x4ba8
// Size: 0xc4
function create_lightning_params() {
    level.var_3a2dca1e = lightning_chain::create_lightning_chain_params(1);
    level.var_3a2dca1e.should_kill_enemies = 0;
    level.var_142b4fb5 = lightning_chain::create_lightning_chain_params(2);
    level.var_142b4fb5.should_kill_enemies = 0;
    level.var_142b4fb5.clientside_fx = 0;
    level.var_ee28d54c = lightning_chain::create_lightning_chain_params(3);
    level.var_ee28d54c.should_kill_enemies = 0;
    level.var_ee28d54c.clientside_fx = 0;
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xfcf77a8b, Offset: 0x4c78
// Size: 0x22
function function_8a41ce54() {
    if (!isdefined(level.var_701d7eb)) {
        level.var_701d7eb = [];
    }
    return level.var_701d7eb;
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xf36560dd, Offset: 0x4ca8
// Size: 0xb0
function function_815e92f8() {
    self endon(#"death");
    level flagsys::wait_till("start_zombie_round_logic");
    self setinvisibletoall();
    while (isdefined(self)) {
        target, player = level waittill(#"grapple_hit");
        if (isdefined(self) && target istouching(self)) {
            self useby(player);
        }
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0x504693ab, Offset: 0x4d60
// Size: 0x118
function function_89419316() {
    self endon(#"hash_b2631b3c");
    self endon(#"death");
    grapple = getweapon("zombie_beast_grapple_dwr");
    while (isdefined(self)) {
        weapon = self waittill(#"grapple_fired");
        if (weapon == grapple) {
            if (isdefined(self.pivotentity) && !isplayer(self.pivotentity)) {
            }
            if (isdefined(self.lockonentity)) {
                if (!self function_668dcfac(self.lockonentity)) {
                    self.lockonentity = undefined;
                }
            }
            self function_bd84f46(0);
            self thread function_77a9a8f6(weapon, "zod_beast_grapple_out", 0.4);
        }
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0x287b2fc2, Offset: 0x4e80
// Size: 0x68
function function_668dcfac(target) {
    if (isdefined(target.var_deccd0c8) && target.var_deccd0c8) {
        return false;
    }
    target.var_deccd0c8 = 1;
    self thread function_b8488073(target, 5);
    return true;
}

// Namespace namespace_215602b6
// Params 2, eflags: 0x0
// Checksum 0x5d4ed013, Offset: 0x4ef0
// Size: 0x104
function function_b8488073(target, time) {
    self util::waittill_any_timeout(time, "disconnect", "grapple_cancel", "player_exit_beastmode");
    if (isdefined(target)) {
        target.var_deccd0c8 = undefined;
        if (isdefined(target.is_zombie) && target.is_zombie) {
            target dodamage(target.health + 1000, target.origin);
            if (!isvehicle(target)) {
                target.no_powerups = 1;
                target.marked_for_recycle = 1;
                target.has_been_damaged_by_player = 0;
            }
        }
    }
}

// Namespace namespace_215602b6
// Params 3, eflags: 0x0
// Checksum 0xf4cbde7c, Offset: 0x5000
// Size: 0x8e
function function_77a9a8f6(weapon, rumble, length) {
    self endon(#"grapple_stick");
    self endon(#"grapple_pulled");
    self endon(#"grapple_landed");
    self endon(#"grapple_cancel");
    start_time = gettime();
    while (start_time + 3000 > gettime()) {
        self playrumbleonentity(rumble);
        wait(length);
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0xbda62c26, Offset: 0x5098
// Size: 0x76
function function_f543d7da(ent) {
    if (!isvehicle(ent)) {
        if (isdefined(ent.is_zombie) && ent.is_zombie) {
            if (!(isdefined(ent.completed_emerging_into_playable_area) && ent.completed_emerging_into_playable_area)) {
                return false;
            }
        }
    }
    return true;
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xe2a8f73a, Offset: 0x5118
// Size: 0x94
function function_a51e085() {
    self endon(#"death");
    self.var_f9127ea5 = 0;
    self setgrapplabletype(self.var_f9127ea5);
    if (!isvehicle(self)) {
        self waittill(#"completed_emerging_into_playable_area");
    }
    if (!isdefined(self)) {
        return;
    }
    self.var_f9127ea5 = 2;
    self setgrapplabletype(self.var_f9127ea5);
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xf61b4941, Offset: 0x51b8
// Size: 0x150
function function_ce0d3f8c() {
    self endon(#"hash_b2631b3c");
    self endon(#"death");
    grapple = getweapon("zombie_beast_grapple_dwr");
    while (isdefined(self)) {
        weapon, target = self waittill(#"grapple_stick");
        if (weapon == grapple) {
            self notify(#"hash_c5523e8b");
            self playrumbleonentity("zod_beast_grapple_hit");
            if (isdefined(self.pivotentity) && !isplayer(self.pivotentity)) {
            }
            if (isdefined(target)) {
                if (isdefined(target.is_zombie) && target.is_zombie) {
                    target function_97e0f416(self);
                }
            }
            level notify(#"grapple_hit", target, self);
            playsoundatposition("wpn_beastmode_grapple_imp", target.origin);
        }
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xbfdd6fb0, Offset: 0x5310
// Size: 0x100
function function_126b475f() {
    self endon(#"hash_b2631b3c");
    self endon(#"death");
    grapple = getweapon("zombie_beast_grapple_dwr");
    while (isdefined(self)) {
        weapon, target = self waittill(#"grapple_reelin");
        if (weapon == grapple) {
            origin = target.origin;
            self thread function_abdf7162(origin);
            self playsound("wpn_beastmode_grapple_pullin");
            wait(0.15);
            self thread function_77a9a8f6(weapon, "zod_beast_grapple_reel", 0.2);
        }
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0xcde95143, Offset: 0x5418
// Size: 0xac
function function_abdf7162(origin) {
    self endon(#"hash_b2631b3c");
    self endon(#"death");
    self notify(#"hash_abdf7162");
    self endon(#"hash_abdf7162");
    weapon, target = self waittill(#"grapple_landed");
    if (distance2dsquared(self.origin, origin) > 1024) {
        self setorigin(origin + (0, 0, -60));
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0x47d11806, Offset: 0x54d0
// Size: 0xb0
function function_5e1ffae() {
    self endon(#"hash_b2631b3c");
    self endon(#"death");
    grapple = getweapon("zombie_beast_grapple_dwr");
    while (isdefined(self)) {
        weapon, target = self waittill(#"grapple_pullin");
        if (weapon == grapple) {
            wait(0.15);
            self thread function_77a9a8f6(weapon, "zod_beast_grapple_pull", 0.2);
        }
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0x861e5bb1, Offset: 0x5588
// Size: 0xd8
function function_f893b14f() {
    self endon(#"hash_b2631b3c");
    self endon(#"death");
    grapple = getweapon("zombie_beast_grapple_dwr");
    while (isdefined(self)) {
        weapon, target = self waittill(#"grapple_pulled");
        if (weapon == grapple) {
            if (isdefined(target)) {
                if (isdefined(target.is_zombie) && target.is_zombie) {
                    continue;
                }
                if (isdefined(target.powerup_name)) {
                    target.origin = self.origin;
                }
            }
        }
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0xd22f52ef, Offset: 0x5668
// Size: 0x214
function function_97e0f416(player) {
    self.grapple_is_fatal = 1;
    var_4361c12b = player.origin - self.origin;
    var_168907b4 = vectornormalize((var_4361c12b[0], var_4361c12b[1], 0));
    zombie_forward = anglestoforward(self.angles);
    zombie_forward_2d = vectornormalize((zombie_forward[0], zombie_forward[1], 0));
    zombie_right = anglestoright(self.angles);
    zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
    dot = vectordot(var_168907b4, zombie_forward_2d);
    if (dot >= 0.5) {
        self.grapple_direction = "front";
    } else if (dot < 0.5 && dot > -0.5) {
        dot = vectordot(var_168907b4, zombie_right_2d);
        if (dot > 0) {
            self.grapple_direction = "right";
        } else {
            self.grapple_direction = "left";
        }
    } else {
        self.grapple_direction = "back";
    }
    self thread function_d4252c93(player);
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0x7978a822, Offset: 0x5888
// Size: 0x1ac
function function_d4252c93(player) {
    player util::waittill_any_timeout(2.5, "disconnect", "grapple_pulled", "altbody_end");
    wait(0.15);
    if (isdefined(self)) {
        if (isdefined(player)) {
            player playsound("wpn_beastmode_grapple_zombie_imp");
        }
        if (!(isdefined(self.grapple_is_fatal) && self.grapple_is_fatal)) {
            self dodamage(1000, player.origin, player);
            return;
        }
        if (isdefined(player)) {
            self dodamage(self.health + 1000, player.origin, player);
        } else {
            self dodamage(self.health + 1000, self.origin);
        }
        if (!isvehicle(self)) {
            self.no_powerups = 1;
            self.marked_for_recycle = 1;
            self.has_been_damaged_by_player = 0;
            self startragdoll();
            if (isdefined(player)) {
                player clientfield::increment_to_player("beast_blood_on_player");
            }
        }
    }
}

// Namespace namespace_215602b6
// Params 13, eflags: 0x0
// Checksum 0xd6208464, Offset: 0x5a40
// Size: 0x16c
function function_f4ee06b4(mod, hit_location, var_8a2b6fe5, player, amount, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel) {
    if (function_4c03fac9(weapon)) {
        shocklevel = function_cebfc03f(weapon);
        self.tesla_death = 0;
        self thread arc_damage_init(hit_location, var_8a2b6fe5, player, shocklevel);
        return true;
    }
    if (weapon === getweapon("zombie_beast_grapple_dwr")) {
        if (amount > 0 && isdefined(player)) {
            player playrumbleonentity("damage_heavy");
            earthquake(1, 0.75, player.origin, 100);
        }
        return true;
    }
    return false;
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0x67d0ebd9, Offset: 0x5bb8
// Size: 0x240
function function_c5c7aef3(triggers) {
    self endon(#"delete");
    self setcandamage(1);
    while (isdefined(triggers)) {
        amount, attacker, direction, point, mod, tagname, modelname, partname, weapon = self waittill(#"damage");
        if (function_4c03fac9(weapon) && isdefined(attacker) && amount > 0) {
            if (isdefined(attacker)) {
                attacker notify(#"hash_e22dab6d");
            }
            if (isdefined(level._effect["beast_shock_box"])) {
                forward = anglestoforward(self.angles);
                playfx(level._effect["beast_shock_box"], self.origin, forward);
            }
            if (!isdefined(triggers)) {
                return;
            }
            if (isarray(triggers)) {
                foreach (trigger in triggers) {
                    if (isdefined(trigger)) {
                        trigger useby(attacker);
                    }
                }
                continue;
            }
            triggers useby(attacker);
        }
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0x8f8ad0b0, Offset: 0x5e00
// Size: 0x25c
function function_d166ff57(attacker) {
    if (isdefined(self.attacker.beastmode) && isdefined(self.attacker) && self.attacker.beastmode) {
        self.no_powerups = 1;
        self.marked_for_recycle = 1;
        self.has_been_damaged_by_player = 0;
    }
    if (function_4c03fac9(self.damageweapon)) {
        self.no_powerups = 1;
        self.marked_for_recycle = 1;
        self.has_been_damaged_by_player = 0;
    }
    if (self.damageweapon === getweapon("zombie_beast_grapple_dwr")) {
        self.no_powerups = 1;
        self.marked_for_recycle = 1;
        self.has_been_damaged_by_player = 0;
        if (!isvehicle(self)) {
            if (self.damagemod === "MOD_MELEE") {
                player = self.attacker;
                if (isdefined(player)) {
                    player playrumbleonentity("damage_heavy");
                    earthquake(1, 0.75, player.origin, 100);
                }
                self clientfield::set("bm_zombie_grapple_kill", 1);
                gibserverutils::annihilate(self);
                return;
            }
            player = self.attacker;
            if (isdefined(player)) {
                player playrumbleonentity("damage_heavy");
                earthquake(1, 0.75, player.origin, 100);
            }
            self clientfield::set("bm_zombie_melee_kill", 1);
            gibserverutils::annihilate(self);
        }
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0x8d940540, Offset: 0x6068
// Size: 0xb8
function function_2438ef4() {
    self endon(#"death");
    level flagsys::wait_till("start_zombie_round_logic");
    self setinvisibletoall();
    while (isdefined(self)) {
        grenade, player = level waittill(#"hash_752282bb");
        if (isdefined(self) && isdefined(grenade) && grenade istouching(self)) {
            self useby(player);
        }
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xbda24db1, Offset: 0x6128
// Size: 0x86
function function_7fb730b3() {
    if (isdefined(self.barricade_enter) && self.barricade_enter) {
        return false;
    }
    if (isdefined(self.is_traversing) && self.is_traversing) {
        return false;
    }
    if (!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area) && !isdefined(self.first_node)) {
        return false;
    }
    if (isdefined(self.is_leaping) && self.is_leaping) {
        return false;
    }
    return true;
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0x572bf128, Offset: 0x61b8
// Size: 0x39c
function function_2264dd90(zombie) {
    zombie endon(#"death");
    zombie notify(#"hash_2264dd90");
    zombie endon(#"hash_2264dd90");
    if (!zombie function_7fb730b3()) {
        return;
    }
    num = zombie getentitynumber();
    if (!isdefined(zombie.var_6933bc56)) {
        zombie.var_6933bc56 = 0;
    }
    zombie.var_6933bc56++;
    if (!isdefined(zombie.animation_rate)) {
        zombie.animation_rate = 1;
    }
    zombie.var_ffa5f32a = 8;
    zombie thread function_73b14de1(zombie);
    while (isdefined(zombie) && isalive(zombie) && zombie.animation_rate > 0.03) {
        zombie.animation_rate -= 0.97 * 0.05;
        if (zombie.animation_rate < 0.03) {
            zombie.animation_rate = 0.03;
        }
        zombie asmsetanimationrate(zombie.animation_rate);
        zombie.var_ffa5f32a -= 0.05;
        wait(0.05);
    }
    while (isdefined(zombie) && isalive(zombie) && zombie.var_ffa5f32a > 0.5) {
        zombie.var_ffa5f32a -= 0.05;
        wait(0.05);
    }
    while (isdefined(zombie) && isalive(zombie) && zombie.animation_rate < 1) {
        zombie.animation_rate += 0.97 * 0.1;
        if (zombie.animation_rate > 1) {
            zombie.animation_rate = 1;
        }
        zombie asmsetanimationrate(zombie.animation_rate);
        zombie.var_ffa5f32a -= 0.05;
        wait(0.05);
    }
    zombie asmsetanimationrate(1);
    zombie.var_ffa5f32a = 0;
    if (isdefined(zombie)) {
        zombie.var_6933bc56--;
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// Checksum 0x301ba0f2, Offset: 0x6560
// Size: 0xde
function function_73b14de1(zombie) {
    tag = "J_SpineUpper";
    fx = "beast_shock";
    if (isdefined(zombie.isdog) && zombie.isdog) {
        tag = "J_Spine1";
    }
    while (isdefined(zombie) && isalive(zombie) && zombie.var_ffa5f32a > 0) {
        zombie zm_net::network_safe_play_fx_on_tag("beast_slow_fx", 2, level._effect[fx], zombie, tag);
        wait(1);
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0xa5becdc0, Offset: 0x6648
// Size: 0xba
function function_41cc3fc8() {
    players = level.activeplayers;
    foreach (player in players) {
        player thread function_a1b60d91(isdefined(player.beastmode) && player.beastmode);
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// Checksum 0x87674772, Offset: 0x6710
// Size: 0xd4
function function_d7b8b2f5() {
    self endon(#"hash_b2631b3c");
    self endon(#"altbody_end");
    n_start_time = undefined;
    while (true) {
        current_zone = self zm_utility::get_current_zone();
        if (!isdefined(current_zone)) {
            if (!isdefined(n_start_time)) {
                n_start_time = gettime();
            }
            n_current_time = gettime();
            n_time = (n_current_time - n_start_time) / 1000;
            if (n_time >= level.var_87ee6f27) {
                self notify(#"altbody_end");
                return;
            }
        } else {
            n_start_time = undefined;
        }
        wait(0.05);
    }
}

/#

    // Namespace namespace_215602b6
    // Params 0, eflags: 0x0
    // Checksum 0x646fb2fa, Offset: 0x67f0
    // Size: 0x1ce
    function function_ae9ea3e4() {
        level flagsys::wait_till("script_noteworthy");
        wait(1);
        zm_devgui::add_custom_devgui_callback(&function_de43aaee);
        adddebugcommand("beast_slow_fx");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            ip1 = i + 1;
            adddebugcommand("<unknown string>" + players[i].name + "<unknown string>" + ip1 + "<unknown string>");
            adddebugcommand("<unknown string>" + players[i].name + "<unknown string>" + ip1 + "<unknown string>");
        }
    }

    // Namespace namespace_215602b6
    // Params 1, eflags: 0x0
    // Checksum 0xec8a7a23, Offset: 0x69c8
    // Size: 0x5f0
    function function_de43aaee(cmd) {
        players = getplayers();
        retval = 0;
        switch (cmd) {
        case 0:
            zm_devgui::zombie_devgui_give_powerup(cmd, 1);
            break;
        case 0:
            zm_devgui::zombie_devgui_give_powerup(getsubstr(cmd, 5), 0);
            break;
        case 0:
            array::thread_all(players, &function_b71892de);
            retval = 1;
            break;
        default:
            array::thread_all(players, &function_d92721d1);
            retval = 1;
            break;
        case 0:
            a_trigs = getentarray("<unknown string>", "<unknown string>");
            foreach (e_trig in a_trigs) {
                e_trig useby(level.players[0]);
            }
            a_trigs = getentarray("<unknown string>", "<unknown string>");
            foreach (e_trig in a_trigs) {
                e_trig useby(level.players[0]);
            }
            var_4c4fcdb0 = array("<unknown string>", "<unknown string>", "<unknown string>", "<unknown string>");
            foreach (var_83f1459 in var_4c4fcdb0) {
                level flag::set(var_83f1459);
            }
            level flag::set("<unknown string>");
            level flag::set("<unknown string>");
            zm_devgui::zombie_devgui_open_sesame();
            break;
        case 0:
            if (players.size >= 1) {
                players[0] thread function_b71892de();
            }
            retval = 1;
            break;
        case 0:
            if (players.size >= 2) {
                players[1] thread function_b71892de();
            }
            retval = 1;
            break;
        case 0:
            if (players.size >= 3) {
                players[2] thread function_b71892de();
            }
            retval = 1;
            break;
        case 0:
            if (players.size >= 4) {
                players[3] thread function_b71892de();
            }
            retval = 1;
            break;
        case 0:
            array::thread_all(players, &function_a30c4879);
            retval = 1;
            break;
        case 0:
            if (players.size >= 1) {
                players[0] thread function_a30c4879();
            }
            retval = 1;
            break;
        case 0:
            if (players.size >= 2) {
                players[1] thread function_a30c4879();
            }
            retval = 1;
            break;
        case 0:
            if (players.size >= 3) {
                players[2] thread function_a30c4879();
            }
            retval = 1;
            break;
        case 0:
            if (players.size >= 4) {
                players[3] thread function_a30c4879();
            }
            retval = 1;
            break;
        }
        return retval;
    }

    // Namespace namespace_215602b6
    // Params 0, eflags: 0x0
    // Checksum 0x48c5b9db, Offset: 0x6fc0
    // Size: 0x9e
    function function_b71892de() {
        if (self function_2449723c()) {
            return;
        }
        level flagsys::wait_till("script_noteworthy");
        if (!(isdefined(self.beastmode) && self.beastmode)) {
            self function_d60ab790(1);
            self thread zm_altbody::devgui_start_altbody("<unknown string>");
            return;
        }
        self notify(#"altbody_end");
    }

    // Namespace namespace_215602b6
    // Params 0, eflags: 0x0
    // Checksum 0x1ceece13, Offset: 0x7068
    // Size: 0xd6
    function function_d92721d1() {
        if (self function_2449723c()) {
            return;
        }
        level flagsys::wait_till("script_noteworthy");
        var_a315b31f = level clientfield::get("<unknown string>");
        if (!(isdefined(self.beastmode) && self.beastmode) && !var_a315b31f) {
            self function_d60ab790(1);
            self thread zm_altbody::devgui_start_altbody("<unknown string>");
            return;
        }
        self notify(#"altbody_end");
    }

    // Namespace namespace_215602b6
    // Params 0, eflags: 0x0
    // Checksum 0x5b3bdff5, Offset: 0x7148
    // Size: 0x38
    function function_2449723c() {
        if (isdefined(self.var_9dc82bca)) {
            if (self.var_9dc82bca == gettime()) {
                return 1;
            }
        }
        self.var_9dc82bca = gettime();
        return 0;
    }

    // Namespace namespace_215602b6
    // Params 0, eflags: 0x0
    // Checksum 0xcefbd38e, Offset: 0x7188
    // Size: 0xc8
    function function_a30c4879() {
        if (self function_2449723c()) {
            return;
        }
        self notify(#"hash_57460045");
        self endon(#"hash_57460045");
        level flagsys::wait_till("script_noteworthy");
        self.var_bc3ea900 = !(isdefined(self.var_bc3ea900) && self.var_bc3ea900);
        if (self.var_bc3ea900) {
            while (isdefined(self)) {
                self function_20873276(3);
                self function_d60ab790(1);
                wait(0.05);
            }
        }
    }

#/
