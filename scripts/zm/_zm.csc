#using scripts/zm/_zm_powerup_bonus_points_player;
#using scripts/zm/bgbs/_zm_bgb_tone_death;
#using scripts/zm/bgbs/_zm_bgb_soda_fountain;
#using scripts/zm/bgbs/_zm_bgb_reign_drops;
#using scripts/zm/bgbs/_zm_bgb_power_vacuum;
#using scripts/zm/bgbs/_zm_bgb_idle_eyes;
#using scripts/zm/bgbs/_zm_bgb_flavor_hexed;
#using scripts/zm/bgbs/_zm_bgb_eye_candy;
#using scripts/zm/bgbs/_zm_bgb_extra_credit;
#using scripts/zm/bgbs/_zm_bgb_board_to_death;
#using scripts/zm/bgbs/_zm_bgb_board_games;
#using scripts/zm/bgbs/_zm_bgb_self_medication;
#using scripts/zm/bgbs/_zm_bgb_round_robbin;
#using scripts/zm/bgbs/_zm_bgb_profit_sharing;
#using scripts/zm/bgbs/_zm_bgb_newtonian_negation;
#using scripts/zm/bgbs/_zm_bgb_near_death_experience;
#using scripts/zm/bgbs/_zm_bgb_mind_blown;
#using scripts/zm/bgbs/_zm_bgb_bullet_boost;
#using scripts/zm/bgbs/_zm_bgb_slaughter_slide;
#using scripts/zm/bgbs/_zm_bgb_shopping_free;
#using scripts/zm/bgbs/_zm_bgb_projectile_vomiting;
#using scripts/zm/bgbs/_zm_bgb_disorderly_combat;
#using scripts/zm/bgbs/_zm_bgb_crate_power;
#using scripts/zm/bgbs/_zm_bgb_unbearable;
#using scripts/zm/bgbs/_zm_bgb_temporal_gift;
#using scripts/zm/bgbs/_zm_bgb_secret_shopper;
#using scripts/zm/bgbs/_zm_bgb_fear_in_headlights;
#using scripts/zm/bgbs/_zm_bgb_undead_man_walking;
#using scripts/zm/bgbs/_zm_bgb_head_drama;
#using scripts/zm/bgbs/_zm_bgb_fatal_contraption;
#using scripts/zm/bgbs/_zm_bgb_crawl_space;
#using scripts/zm/bgbs/_zm_bgb_whos_keeping_score;
#using scripts/zm/bgbs/_zm_bgb_wall_power;
#using scripts/zm/bgbs/_zm_bgb_unquenchable;
#using scripts/zm/bgbs/_zm_bgb_sword_flay;
#using scripts/zm/bgbs/_zm_bgb_stock_option;
#using scripts/zm/bgbs/_zm_bgb_respin_cycle;
#using scripts/zm/bgbs/_zm_bgb_pop_shocks;
#using scripts/zm/bgbs/_zm_bgb_phoenix_up;
#using scripts/zm/bgbs/_zm_bgb_perkaholic;
#using scripts/zm/bgbs/_zm_bgb_on_the_house;
#using scripts/zm/bgbs/_zm_bgb_now_you_see_me;
#using scripts/zm/bgbs/_zm_bgb_lucky_crit;
#using scripts/zm/bgbs/_zm_bgb_licensed_contractor;
#using scripts/zm/bgbs/_zm_bgb_killing_time;
#using scripts/zm/bgbs/_zm_bgb_kill_joy;
#using scripts/zm/bgbs/_zm_bgb_in_plain_sight;
#using scripts/zm/bgbs/_zm_bgb_impatient;
#using scripts/zm/bgbs/_zm_bgb_immolation_liquidation;
#using scripts/zm/bgbs/_zm_bgb_im_feelin_lucky;
#using scripts/zm/bgbs/_zm_bgb_firing_on_all_cylinders;
#using scripts/zm/bgbs/_zm_bgb_ephemeral_enhancement;
#using scripts/zm/bgbs/_zm_bgb_dead_of_nuclear_winter;
#using scripts/zm/bgbs/_zm_bgb_danger_closest;
#using scripts/zm/bgbs/_zm_bgb_coagulant;
#using scripts/zm/bgbs/_zm_bgb_cache_back;
#using scripts/zm/bgbs/_zm_bgb_burned_out;
#using scripts/zm/bgbs/_zm_bgb_arsenal_accelerator;
#using scripts/zm/bgbs/_zm_bgb_arms_grace;
#using scripts/zm/bgbs/_zm_bgb_armamental_accomplishment;
#using scripts/zm/bgbs/_zm_bgb_anywhere_but_here;
#using scripts/zm/bgbs/_zm_bgb_always_done_swiftly;
#using scripts/zm/bgbs/_zm_bgb_alchemical_antithesis;
#using scripts/zm/bgbs/_zm_bgb_aftertaste;
#using scripts/zm/aats/_zm_aat_turned;
#using scripts/zm/aats/_zm_aat_thunder_wall;
#using scripts/zm/aats/_zm_aat_fire_works;
#using scripts/zm/aats/_zm_aat_dead_wire;
#using scripts/zm/aats/_zm_aat_blast_furnace;
#using scripts/zm/_zm_zdraw;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_ffotd;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_demo;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_audio;
#using scripts/zm/_sticky_grenade;
#using scripts/zm/_load;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/archetype_shared/archetype_shared;
#using scripts/shared/aat_shared;
#using scripts/codescripts/struct;

#namespace zm;

// Namespace zm
// Params 0, eflags: 0x2
// Checksum 0x74c9e6e2, Offset: 0x1900
// Size: 0x3b4
function ignore_systems() {
    system::ignore("gadget_clone");
    system::ignore("gadget_heat_wave");
    system::ignore("gadget_resurrect");
    system::ignore("gadget_shock_field");
    system::ignore("gadget_es_strike");
    system::ignore("gadget_misdirection");
    system::ignore("gadget_smokescreen");
    system::ignore("gadget_firefly_swarm");
    system::ignore("gadget_immolation");
    system::ignore("gadget_forced_malfunction");
    system::ignore("gadget_sensory_overload");
    system::ignore("gadget_rapid_strike");
    system::ignore("gadget_camo_render");
    system::ignore("gadget_unstoppable_force");
    system::ignore("gadget_overdrive");
    system::ignore("gadget_concussive_wave");
    system::ignore("gadget_ravage_core");
    system::ignore("gadget_cacophany");
    system::ignore("gadget_iff_override");
    system::ignore("gadget_security_breach");
    system::ignore("gadget_surge");
    system::ignore("gadget_exo_breakdown");
    system::ignore("gadget_servo_shortout");
    system::ignore("gadget_system_overload");
    system::ignore("gadget_cleanse");
    system::ignore("gadget_flashback");
    system::ignore("gadget_combat_efficiency");
    system::ignore("gadget_other");
    system::ignore("gadget_vision_pulse");
    system::ignore("gadget_camo");
    system::ignore("gadget_speed_burst");
    system::ignore("gadget_armor");
    system::ignore("gadget_thief");
    system::ignore("replay_gun");
    system::ignore("spike_charge_siegebot");
    system::ignore("end_game_taunts");
    if (getdvarint("splitscreen_playerCount") > 2) {
        system::ignore("footsteps");
        system::ignore("ambient");
    }
}

// Namespace zm
// Params 0, eflags: 0x1 linked
// Checksum 0x30efbc66, Offset: 0x1cc0
// Size: 0x3f4
function init() {
    /#
        println("gadget_immolation");
    #/
    level thread zm_ffotd::main_start();
    level.onlinegame = sessionmodeisonlinegame();
    level.swimmingfeature = 0;
    level.scr_zm_ui_gametype = getdvarstring("ui_gametype");
    level.scr_zm_map_start_location = "";
    level.gamedifficulty = getgametypesetting("zmDifficulty");
    level.enable_magic = getgametypesetting("magic");
    level.headshots_only = getgametypesetting("headshotsonly");
    level.disable_equipment_team_object = 1;
    util::register_system("lsm", &last_stand_monitor);
    level.clientvoicesetup = &zm_audio::clientvoicesetup;
    level.playerfalldamagesound = &zm_audio::playerfalldamagesound;
    /#
        println("gadget_immolation");
    #/
    init_clientfields();
    zm_perks::init();
    zm_powerups::init();
    zm_weapons::init();
    init_blocker_fx();
    init_riser_fx();
    init_zombie_explode_fx();
    level.gibresettime = 0.5;
    level.gibmaxcount = 3;
    level.gibtimer = 0;
    level.gibcount = 0;
    level._gibeventcbfunc = &on_gib_event;
    level thread resetgibcounter();
    level thread zpo_listener();
    level thread zpoff_listener();
    level._box_indicator_no_lights = -1;
    level._box_indicator_flash_lights_moving = 99;
    level._box_indicator = level._box_indicator_no_lights;
    util::register_system("box_indicator", &box_monitor);
    level._zombie_gib_piece_index_all = 0;
    level._zombie_gib_piece_index_right_arm = 1;
    level._zombie_gib_piece_index_left_arm = 2;
    level._zombie_gib_piece_index_right_leg = 3;
    level._zombie_gib_piece_index_left_leg = 4;
    level._zombie_gib_piece_index_head = 5;
    level._zombie_gib_piece_index_guts = 6;
    level._zombie_gib_piece_index_hat = 7;
    callback::add_callback(#"hash_da8d7d74", &basic_player_connect);
    callback::on_spawned(&function_27d0e46c);
    callback::on_spawned(&player_umbrahotfixes);
    level.update_aat_hud = &update_aat_hud;
    if (isdefined(level.setupcustomcharacterexerts)) {
        [[ level.setupcustomcharacterexerts ]]();
    }
    level thread zm_ffotd::main_end();
    /#
        level thread function_9fee0219();
    #/
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0xbe7cc57b, Offset: 0x20c0
// Size: 0x96
function delay_for_clients_then_execute(func) {
    wait(0.1);
    players = getlocalplayers();
    for (x = 0; x < players.size; x++) {
        while (!clienthassnapshot(x)) {
            wait(0.05);
        }
    }
    wait(0.1);
    level thread [[ func ]]();
}

/#

    // Namespace zm
    // Params 0, eflags: 0x1 linked
    // Checksum 0xbdf70b76, Offset: 0x2160
    // Size: 0x1b6
    function function_9fee0219() {
        wait(0.1);
        players = getlocalplayers();
        for (x = 0; x < players.size; x++) {
            while (!clienthassnapshot(x)) {
                wait(0.05);
            }
        }
        wait(0.1);
        if (!isdefined(level.var_478e3c32)) {
            level.var_478e3c32 = [];
        }
        var_d38a76f6 = 0;
        while (true) {
            dvar_value = getdvarint("gadget_immolation");
            if (dvar_value != var_d38a76f6) {
                players = level.var_478e3c32;
                foreach (player in players) {
                    player duplicate_render::set_dr_flag("gadget_immolation", !dvar_value);
                    player duplicate_render::update_dr_filters(0);
                }
            }
            var_d38a76f6 = dvar_value;
            wait(1);
        }
    }

#/

// Namespace zm
// Params 0, eflags: 0x1 linked
// Checksum 0x3b978554, Offset: 0x2320
// Size: 0x11c
function function_74cb963f() {
    self oed_sitrepscan_enable(4);
    self oed_sitrepscan_setoutline(1);
    self oed_sitrepscan_setlinewidth(2);
    self oed_sitrepscan_setsolid(1);
    self oed_sitrepscan_setradius(800);
    self oed_sitrepscan_setfalloff(0.1);
    duplicate_render::set_dr_filter_offscreen("player_keyline", 25, "keyline_active", "keyline_disabled", 2, "mc/hud_keyline_zm_player", 1);
    duplicate_render::set_dr_filter_offscreen("player_keyline_ls", 30, "keyline_active,keyline_ls", "keyline_disabled", 2, "mc/hud_keyline_zm_player_ls", 1);
}

// Namespace zm
// Params 1, eflags: 0x1 linked
// Checksum 0x269e5211, Offset: 0x2448
// Size: 0x1ac
function function_27d0e46c(localclientnum) {
    /#
        if (!isdefined(level.var_478e3c32)) {
            level.var_478e3c32 = [];
        }
        if (!isdefined(level.var_478e3c32)) {
            level.var_478e3c32 = [];
        } else if (!isarray(level.var_478e3c32)) {
            level.var_478e3c32 = array(level.var_478e3c32);
        }
        level.var_478e3c32[level.var_478e3c32.size] = self;
    #/
    if (self == getlocalplayer(localclientnum)) {
        self function_74cb963f();
        self thread force_update_player_clientfields(localclientnum);
    }
    if (self isplayer() && self islocalplayer()) {
        if (!isdefined(self getlocalclientnumber()) || localclientnum == self getlocalclientnumber()) {
            return;
        }
    }
    dvar_value = getdvarint("scr_hide_player_keyline");
    self duplicate_render::set_dr_flag("keyline_active", !dvar_value);
    self duplicate_render::update_dr_filters(localclientnum);
}

// Namespace zm
// Params 1, eflags: 0x1 linked
// Checksum 0x6ba54b0d, Offset: 0x2600
// Size: 0x7c
function player_umbrahotfixes(localclientnum) {
    if (!self islocalplayer() || !isdefined(self getlocalclientnumber()) || localclientnum != self getlocalclientnumber()) {
        return;
    }
    self thread zm_utility::umbra_fix_logic(localclientnum);
}

// Namespace zm
// Params 1, eflags: 0x1 linked
// Checksum 0xaaa20ab6, Offset: 0x2688
// Size: 0x36
function basic_player_connect(localclientnum) {
    if (!isdefined(level._laststand)) {
        level._laststand = [];
    }
    level._laststand[localclientnum] = 0;
}

// Namespace zm
// Params 1, eflags: 0x1 linked
// Checksum 0x78fe4a60, Offset: 0x26c8
// Size: 0x5c
function force_update_player_clientfields(localclientnum) {
    self endon(#"entityshutdown");
    while (!clienthassnapshot(localclientnum)) {
        wait(0.25);
    }
    wait(0.25);
    self processclientfieldsasifnew();
}

// Namespace zm
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x2730
// Size: 0x4
function init_blocker_fx() {
    
}

// Namespace zm
// Params 0, eflags: 0x1 linked
// Checksum 0x585b51c4, Offset: 0x2740
// Size: 0x136
function init_riser_fx() {
    if (isdefined(level.var_f409c3b7) && level.var_f409c3b7) {
        level._effect["rise_burst_water"] = "_t6/maps/zombie/fx_mp_zombie_hand_water_burst";
        level._effect["rise_billow_water"] = "_t6/maps/zombie/fx_mp_zombie_body_water_billowing";
        level._effect["rise_dust_water"] = "_t6/maps/zombie/fx_zombie_body_wtr_falling";
    }
    level._effect["rise_burst"] = "zombie/fx_spawn_dirt_hand_burst_zmb";
    level._effect["rise_billow"] = "zombie/fx_spawn_dirt_body_billowing_zmb";
    level._effect["rise_dust"] = "zombie/fx_spawn_dirt_body_dustfalling_zmb";
    if (isdefined(level.riser_type) && level.riser_type == "snow") {
        level._effect["rise_burst_snow"] = "_t6/maps/zombie/fx_mp_zombie_hand_snow_burst";
        level._effect["rise_billow_snow"] = "_t6/maps/zombie/fx_mp_zombie_body_snow_billowing";
        level._effect["rise_dust_snow"] = "_t6/maps/zombie/fx_mp_zombie_body_snow_falling";
    }
}

// Namespace zm
// Params 0, eflags: 0x1 linked
// Checksum 0xd5279033, Offset: 0x2880
// Size: 0x55c
function init_clientfields() {
    /#
        println("gadget_immolation");
    #/
    clientfield::register("actor", "zombie_riser_fx", 1, 1, "int", &handle_zombie_risers, 1, 1);
    if (isdefined(level.use_water_risers) && level.use_water_risers) {
        clientfield::register("actor", "zombie_riser_fx_water", 1, 1, "int", &handle_zombie_risers_water, 1, 1);
    }
    if (isdefined(level.use_foliage_risers) && level.use_foliage_risers) {
        clientfield::register("actor", "zombie_riser_fx_foliage", 1, 1, "int", &handle_zombie_risers_foliage, 1, 1);
    }
    if (isdefined(level.use_low_gravity_risers) && level.use_low_gravity_risers) {
        clientfield::register("actor", "zombie_riser_fx_lowg", 1, 1, "int", &handle_zombie_risers_lowg, 1, 1);
    }
    clientfield::register("actor", "zombie_has_eyes", 1, 1, "int", &zombie_eyes_clientfield_cb, 0, 1);
    clientfield::register("actor", "zombie_ragdoll_explode", 1, 1, "int", &zombie_ragdoll_explode_cb, 0, 1);
    clientfield::register("actor", "zombie_gut_explosion", 1, 1, "int", &zombie_gut_explosion_cb, 0, 1);
    clientfield::register("actor", "sndZombieContext", -1, 1, "int", &zm_audio::function_790b3d9d, 0, 1);
    clientfield::register("actor", "zombie_keyline_render", 1, 1, "int", &zombie_zombie_keyline_render_clientfield_cb, 0, 1);
    bits = 4;
    power = struct::get_array("elec_switch_fx", "script_noteworthy");
    if (isdefined(power)) {
        bits = getminbitcountfornum(power.size + 1);
    }
    clientfield::register("world", "zombie_power_on", 1, bits, "int", &zombie_power_clientfield_on, 1, 1);
    clientfield::register("world", "zombie_power_off", 1, bits, "int", &zombie_power_clientfield_off, 1, 1);
    clientfield::register("world", "round_complete_time", 1, 20, "int", &round_complete_time, 0, 1);
    clientfield::register("world", "round_complete_num", 1, 8, "int", &round_complete_num, 0, 1);
    clientfield::register("world", "game_end_time", 1, 20, "int", &game_end_time, 0, 1);
    clientfield::register("world", "quest_complete_time", 1, 20, "int", &quest_complete_time, 0, 1);
    clientfield::register("world", "game_start_time", 15001, 20, "int", &game_start_time, 0, 1);
}

// Namespace zm
// Params 3, eflags: 0x1 linked
// Checksum 0x4980c0b4, Offset: 0x2de8
// Size: 0x44
function box_monitor(clientnum, state, oldstate) {
    if (isdefined(level._custom_box_monitor)) {
        [[ level._custom_box_monitor ]](clientnum, state, oldstate);
    }
}

// Namespace zm
// Params 0, eflags: 0x1 linked
// Checksum 0xe4e3f2c4, Offset: 0x2e38
// Size: 0x5a
function zpo_listener() {
    while (true) {
        int = undefined;
        int = level waittill(#"zpo");
        if (isdefined(int)) {
            level notify(#"power_on", int);
            continue;
        }
        level notify(#"power_on");
    }
}

// Namespace zm
// Params 0, eflags: 0x1 linked
// Checksum 0xfed6339a, Offset: 0x2ea0
// Size: 0x5a
function zpoff_listener() {
    while (true) {
        int = undefined;
        int = level waittill(#"zpoff");
        if (isdefined(int)) {
            level notify(#"power_off", int);
            continue;
        }
        level notify(#"power_off");
    }
}

// Namespace zm
// Params 7, eflags: 0x1 linked
// Checksum 0xff682800, Offset: 0x2f08
// Size: 0x56
function zombie_power_clientfield_on(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level notify(#"zpo", newval);
    }
}

// Namespace zm
// Params 7, eflags: 0x1 linked
// Checksum 0x65cae13c, Offset: 0x2f68
// Size: 0x56
function zombie_power_clientfield_off(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level notify(#"zpoff", newval);
    }
}

// Namespace zm
// Params 7, eflags: 0x1 linked
// Checksum 0x8fd681ea, Offset: 0x2fc8
// Size: 0x94
function round_complete_time(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    model = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.time.round_complete_time");
    setuimodelvalue(model, newval);
}

// Namespace zm
// Params 7, eflags: 0x1 linked
// Checksum 0x51bb72f1, Offset: 0x3068
// Size: 0x94
function round_complete_num(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    model = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.time.round_complete_num");
    setuimodelvalue(model, newval);
}

// Namespace zm
// Params 7, eflags: 0x1 linked
// Checksum 0xf3d61731, Offset: 0x3108
// Size: 0x94
function game_end_time(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    model = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.time.game_end_time");
    setuimodelvalue(model, newval);
}

// Namespace zm
// Params 7, eflags: 0x1 linked
// Checksum 0x3bb9a4a2, Offset: 0x31a8
// Size: 0x94
function quest_complete_time(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    model = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.time.quest_complete_time");
    setuimodelvalue(model, newval);
}

// Namespace zm
// Params 7, eflags: 0x1 linked
// Checksum 0x24df764d, Offset: 0x3248
// Size: 0x94
function game_start_time(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    model = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.time.game_start_time");
    setuimodelvalue(model, newval);
}

// Namespace zm
// Params 1, eflags: 0x1 linked
// Checksum 0xecb384b5, Offset: 0x32e8
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

// Namespace zm
// Params 1, eflags: 0x1 linked
// Checksum 0xf36f93b, Offset: 0x33f8
// Size: 0x24
function createzombieeyes(localclientnum) {
    self thread createzombieeyesinternal(localclientnum);
}

// Namespace zm
// Params 1, eflags: 0x1 linked
// Checksum 0x13f963a9, Offset: 0x3428
// Size: 0x60
function deletezombieeyes(localclientnum) {
    if (isdefined(self._eyearray)) {
        if (isdefined(self._eyearray[localclientnum])) {
            deletefx(localclientnum, self._eyearray[localclientnum], 1);
            self._eyearray[localclientnum] = undefined;
        }
    }
}

// Namespace zm
// Params 7, eflags: 0x0
// Checksum 0x8fca5312, Offset: 0x3490
// Size: 0x174
function function_52d3df9b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self isplayer()) {
        self.var_31f43265 = newval;
        self notify(#"face", "face_advance");
        if (isdefined(self.var_e7bd5df7) && self.var_e7bd5df7) {
        }
    }
    if (self isplayer() && self islocalplayer() && !isdemoplaying()) {
        if (localclientnum == self getlocalclientnumber()) {
            return;
        }
    }
    if (!isdemoplaying()) {
        zombie_eyes_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
        return;
    }
    function_a67fb0bc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

// Namespace zm
// Params 7, eflags: 0x0
// Checksum 0xc5ae85d2, Offset: 0x3610
// Size: 0x1b4
function function_55e6ff0a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self isplayer() && self islocalplayer() && !isdemoplaying()) {
        if (localclientnum == self getlocalclientnumber()) {
            return;
        }
    }
    if (!isdefined(self.var_e7bd5df7) || self.var_e7bd5df7 != newval) {
        self.var_e7bd5df7 = newval;
        if (isdefined(self.var_e7bd5df7) && self.var_e7bd5df7) {
            self._eyeglow_fx_override = level._effect["player_eye_glow_blue"];
        } else {
            self._eyeglow_fx_override = level._effect["player_eye_glow_orng"];
        }
        if (!isdemoplaying()) {
            zombie_eyes_clientfield_cb(localclientnum, 0, isdefined(self.var_31f43265) && self.var_31f43265, bnewent, binitialsnap, fieldname, bwastimejump);
            return;
        }
        function_a67fb0bc(localclientnum, 0, isdefined(self.var_31f43265) && self.var_31f43265, bnewent, binitialsnap, fieldname, bwastimejump);
    }
}

// Namespace zm
// Params 1, eflags: 0x1 linked
// Checksum 0x9a4af5ed, Offset: 0x37d0
// Size: 0xcc
function function_189bc7b4(localclientnum) {
    self endon(#"entityshutdown");
    self endon(#"hash_3f7b661c");
    self endon(#"hash_e5c01d40");
    while (true) {
        level util::waittill_any("demo_jump", "demo_player_switch");
        self deletezombieeyes(localclientnum);
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, get_eyeball_off_luminance(), self get_eyeball_color());
        self.var_900fec00 = 0;
    }
}

// Namespace zm
// Params 7, eflags: 0x1 linked
// Checksum 0xd44a2b10, Offset: 0x38a8
// Size: 0x260
function function_47cf4ac3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self endon(#"hash_3f7b661c");
    self endon(#"hash_e5c01d40");
    self thread function_189bc7b4(localclientnum);
    if (newval) {
        while (true) {
            if (!self islocalplayer() || isspectating(localclientnum, 1) || localclientnum != self getlocalclientnumber()) {
                if (!(isdefined(self.var_900fec00) && self.var_900fec00)) {
                    self createzombieeyes(localclientnum);
                    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, get_eyeball_on_luminance(), self get_eyeball_color());
                    self.var_900fec00 = 1;
                }
            } else if (isdefined(self.var_900fec00) && self.var_900fec00) {
                self deletezombieeyes(localclientnum);
                self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, get_eyeball_off_luminance(), self get_eyeball_color());
                self.var_900fec00 = 0;
            }
            wait(0.016);
        }
        return;
    }
    self deletezombieeyes(localclientnum);
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, get_eyeball_off_luminance(), self get_eyeball_color());
    self.var_900fec00 = 0;
}

// Namespace zm
// Params 7, eflags: 0x1 linked
// Checksum 0x4e7a70f1, Offset: 0x3b10
// Size: 0x7c
function function_a67fb0bc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_e5c01d40");
    self thread function_47cf4ac3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

// Namespace zm
// Params 7, eflags: 0x1 linked
// Checksum 0x87cc82e5, Offset: 0x3b98
// Size: 0x154
function zombie_eyes_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(newval)) {
        return;
    }
    if (newval) {
        self createzombieeyes(localclientnum);
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, get_eyeball_on_luminance(), self get_eyeball_color());
    } else {
        self deletezombieeyes(localclientnum);
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, get_eyeball_off_luminance(), self get_eyeball_color());
    }
    if (isdefined(level.var_3ae99156)) {
        self [[ level.var_3ae99156 ]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    }
}

// Namespace zm
// Params 7, eflags: 0x1 linked
// Checksum 0xb6e6aa2c, Offset: 0x3cf8
// Size: 0xd4
function zombie_zombie_keyline_render_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(newval)) {
        return;
    }
    if (isdefined(level.debug_keyline_zombies) && level.debug_keyline_zombies) {
        if (newval) {
            self duplicate_render::set_dr_flag("keyline_active", 1);
            self duplicate_render::update_dr_filters(localclientnum);
            return;
        }
        self duplicate_render::set_dr_flag("keyline_active", 0);
        self duplicate_render::update_dr_filters(localclientnum);
    }
}

// Namespace zm
// Params 0, eflags: 0x1 linked
// Checksum 0xa327895a, Offset: 0x3dd8
// Size: 0x1c
function get_eyeball_on_luminance() {
    if (isdefined(level.eyeball_on_luminance_override)) {
        return level.eyeball_on_luminance_override;
    }
    return 1;
}

// Namespace zm
// Params 0, eflags: 0x1 linked
// Checksum 0x4d816df3, Offset: 0x3e00
// Size: 0x1a
function get_eyeball_off_luminance() {
    if (isdefined(level.eyeball_off_luminance_override)) {
        return level.eyeball_off_luminance_override;
    }
    return 0;
}

// Namespace zm
// Params 0, eflags: 0x1 linked
// Checksum 0x3bfa785e, Offset: 0x3e28
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

// Namespace zm
// Params 7, eflags: 0x1 linked
// Checksum 0xc9c33d0b, Offset: 0x3e78
// Size: 0x5c
function zombie_ragdoll_explode_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self zombie_wait_explode(localclientnum);
    }
}

// Namespace zm
// Params 7, eflags: 0x1 linked
// Checksum 0x503b4312, Offset: 0x3ee0
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

// Namespace zm
// Params 0, eflags: 0x1 linked
// Checksum 0x2c45cc35, Offset: 0x3fa0
// Size: 0x1e
function init_zombie_explode_fx() {
    level._effect["zombie_guts_explosion"] = "zombie/fx_blood_torso_explo_lg_zmb";
}

// Namespace zm
// Params 1, eflags: 0x1 linked
// Checksum 0xbbf4ebf6, Offset: 0x3fc8
// Size: 0x114
function zombie_wait_explode(localclientnum) {
    where = self gettagorigin("J_SpineLower");
    if (!isdefined(where)) {
        where = self.origin;
    }
    start = gettime();
    while (gettime() - start < 2000) {
        if (isdefined(self)) {
            where = self gettagorigin("J_SpineLower");
            if (!isdefined(where)) {
                where = self.origin;
            }
        }
        wait(0.05);
    }
    if (isdefined(level._effect["zombie_guts_explosion"]) && util::is_mature()) {
        playfx(localclientnum, level._effect["zombie_guts_explosion"], where);
    }
}

// Namespace zm
// Params 1, eflags: 0x1 linked
// Checksum 0x966d6779, Offset: 0x40e8
// Size: 0x3a
function mark_piece_gibbed(piece_index) {
    if (!isdefined(self.gibbed_pieces)) {
        self.gibbed_pieces = [];
    }
    self.gibbed_pieces[self.gibbed_pieces.size] = piece_index;
}

// Namespace zm
// Params 1, eflags: 0x0
// Checksum 0x69f97b7, Offset: 0x4130
// Size: 0x68
function has_gibbed_piece(piece_index) {
    if (!isdefined(self.gibbed_pieces)) {
        return false;
    }
    for (i = 0; i < self.gibbed_pieces.size; i++) {
        if (self.gibbed_pieces[i] == piece_index) {
            return true;
        }
    }
    return false;
}

// Namespace zm
// Params 0, eflags: 0x1 linked
// Checksum 0xb0987d6a, Offset: 0x41a0
// Size: 0x1e6
function do_headshot_gib_fx() {
    fxtag = "j_neck";
    fxorigin = self gettagorigin(fxtag);
    upvec = anglestoup(self gettagangles(fxtag));
    forwardvec = anglestoforward(self gettagangles(fxtag));
    players = level.localplayers;
    for (i = 0; i < players.size; i++) {
        playfx(i, level._effect["headshot"], fxorigin, forwardvec, upvec);
        playfx(i, level._effect["headshot_nochunks"], fxorigin, forwardvec, upvec);
    }
    playsound(0, "zmb_zombie_head_gib", fxorigin);
    wait(0.3);
    if (isdefined(self)) {
        players = level.localplayers;
        for (i = 0; i < players.size; i++) {
            playfxontag(i, level._effect["bloodspurt"], self, fxtag);
        }
    }
}

// Namespace zm
// Params 1, eflags: 0x1 linked
// Checksum 0xc1e6a91b, Offset: 0x4390
// Size: 0xac
function do_gib_fx(tag) {
    players = level.localplayers;
    for (i = 0; i < players.size; i++) {
        playfxontag(i, level._effect["animscript_gib_fx"], self, tag);
    }
    playsound(0, "zmb_death_gibs", self gettagorigin(tag));
}

// Namespace zm
// Params 2, eflags: 0x1 linked
// Checksum 0x12003a1d, Offset: 0x4448
// Size: 0x22c
function do_gib(model, tag) {
    start_pos = self gettagorigin(tag);
    start_angles = self gettagangles(tag);
    wait(0.016);
    end_pos = undefined;
    angles = undefined;
    if (!isdefined(self)) {
        end_pos = start_pos + anglestoforward(start_angles) * 10;
        angles = start_angles;
    } else {
        end_pos = self gettagorigin(tag);
        angles = self gettagangles(tag);
    }
    if (isdefined(self._gib_vel)) {
        forward = self._gib_vel;
        self._gib_vel = undefined;
    } else {
        forward = vectornormalize(end_pos - start_pos);
        forward *= randomfloatrange(0.6, 1);
        forward += (0, 0, randomfloatrange(0.4, 0.7));
    }
    createdynentandlaunch(0, model, end_pos, angles, start_pos, forward, level._effect["animscript_gibtrail_fx"], 1);
    if (isdefined(self)) {
        self do_gib_fx(tag);
        return;
    }
    playsound(0, "zmb_death_gibs", end_pos);
}

// Namespace zm
// Params 2, eflags: 0x1 linked
// Checksum 0x53be97ef, Offset: 0x4680
// Size: 0xcc
function do_hat_gib(model, tag) {
    start_pos = self gettagorigin(tag);
    start_angles = self gettagangles(tag);
    up_angles = (0, 0, 1);
    force = (0, 0, randomfloatrange(1.4, 1.7));
    createdynentandlaunch(0, model, start_pos, up_angles, start_pos, force);
}

// Namespace zm
// Params 0, eflags: 0x1 linked
// Checksum 0x270f64be, Offset: 0x4758
// Size: 0x20
function check_should_gib() {
    if (level.gibcount <= level.gibmaxcount) {
        return true;
    }
    return false;
}

// Namespace zm
// Params 0, eflags: 0x1 linked
// Checksum 0xb04a2a36, Offset: 0x4780
// Size: 0x3c
function resetgibcounter() {
    self endon(#"disconnect");
    while (true) {
        wait(level.gibresettime);
        level.gibtimer = 0;
        level.gibcount = 0;
    }
}

// Namespace zm
// Params 3, eflags: 0x1 linked
// Checksum 0x15b437b9, Offset: 0x47c8
// Size: 0x6fc
function on_gib_event(localclientnum, type, locations) {
    if (localclientnum != 0) {
        return;
    }
    if (!util::is_mature()) {
        return;
    }
    if (!isdefined(self._gib_def)) {
        return;
    }
    if (isdefined(level._gib_overload_func)) {
        if (self [[ level._gib_overload_func ]](type, locations)) {
            return;
        }
    }
    if (!check_should_gib()) {
        return;
    }
    level.gibcount++;
    for (i = 0; i < locations.size; i++) {
        if (isdefined(self.gibbed) && level._zombie_gib_piece_index_head != locations[i]) {
            continue;
        }
        switch (locations[i]) {
        case 0:
            if (isdefined(self._gib_def.gibspawn1) && isdefined(self._gib_def.gibspawntag1)) {
                self thread do_gib(self._gib_def.gibspawn1, self._gib_def.gibspawntag1);
            }
            if (isdefined(self._gib_def.gibspawn2) && isdefined(self._gib_def.gibspawntag2)) {
                self thread do_gib(self._gib_def.gibspawn2, self._gib_def.gibspawntag2);
            }
            if (isdefined(self._gib_def.gibspawn3) && isdefined(self._gib_def.gibspawntag3)) {
                self thread do_gib(self._gib_def.gibspawn3, self._gib_def.gibspawntag3);
            }
            if (isdefined(self._gib_def.gibspawn4) && isdefined(self._gib_def.gibspawntag4)) {
                self thread do_gib(self._gib_def.gibspawn4, self._gib_def.gibspawntag4);
            }
            if (isdefined(self._gib_def.gibspawn5) && isdefined(self._gib_def.gibspawntag5)) {
                self thread do_hat_gib(self._gib_def.gibspawn5, self._gib_def.gibspawntag5);
            }
            self thread do_headshot_gib_fx();
            self thread do_gib_fx("J_SpineLower");
            mark_piece_gibbed(level._zombie_gib_piece_index_right_arm);
            mark_piece_gibbed(level._zombie_gib_piece_index_left_arm);
            mark_piece_gibbed(level._zombie_gib_piece_index_right_leg);
            mark_piece_gibbed(level._zombie_gib_piece_index_left_leg);
            mark_piece_gibbed(level._zombie_gib_piece_index_head);
            mark_piece_gibbed(level._zombie_gib_piece_index_hat);
            break;
        case 1:
            if (isdefined(self._gib_def.gibspawn1) && isdefined(self._gib_def.gibspawntag1)) {
                self thread do_gib(self._gib_def.gibspawn1, self._gib_def.gibspawntag1);
            } else {
                if (isdefined(self._gib_def.gibspawn1)) {
                }
                if (isdefined(self._gib_def.gibspawntag1)) {
                }
            }
            mark_piece_gibbed(level._zombie_gib_piece_index_right_arm);
            break;
        case 2:
            if (isdefined(self._gib_def.gibspawn2) && isdefined(self._gib_def.gibspawntag2)) {
                self thread do_gib(self._gib_def.gibspawn2, self._gib_def.gibspawntag2);
            } else {
                if (isdefined(self._gib_def.gibspawn2)) {
                }
                if (isdefined(self._gib_def.gibspawntag2)) {
                }
            }
            mark_piece_gibbed(level._zombie_gib_piece_index_left_arm);
            break;
        case 3:
            if (isdefined(self._gib_def.gibspawn3) && isdefined(self._gib_def.gibspawntag3)) {
                self thread do_gib(self._gib_def.gibspawn3, self._gib_def.gibspawntag3);
            }
            mark_piece_gibbed(level._zombie_gib_piece_index_right_leg);
            break;
        case 4:
            if (isdefined(self._gib_def.gibspawn4) && isdefined(self._gib_def.gibspawntag4)) {
                self thread do_gib(self._gib_def.gibspawn4, self._gib_def.gibspawntag4);
            }
            mark_piece_gibbed(level._zombie_gib_piece_index_left_leg);
            break;
        case 5:
            self thread do_headshot_gib_fx();
            mark_piece_gibbed(level._zombie_gib_piece_index_head);
            break;
        case 6:
            self thread do_gib_fx("J_SpineLower");
            break;
        case 7:
            if (isdefined(self._gib_def.gibspawn5) && isdefined(self._gib_def.gibspawntag5)) {
                self thread do_hat_gib(self._gib_def.gibspawn5, self._gib_def.gibspawntag5);
            }
            mark_piece_gibbed(level._zombie_gib_piece_index_hat);
            break;
        }
    }
    self.gibbed = 1;
}

// Namespace zm
// Params 4, eflags: 0x0
// Checksum 0x4b2dff80, Offset: 0x4ed0
// Size: 0x284
function zombie_vision_set_apply(str_visionset, int_priority, flt_transition_time, int_clientnum) {
    self endon(#"death");
    self endon(#"disconnect");
    if (!isdefined(self._zombie_visionset_list)) {
        self._zombie_visionset_list = [];
    }
    if (!isdefined(str_visionset) || !isdefined(int_priority)) {
        return;
    }
    if (!isdefined(flt_transition_time)) {
        flt_transition_time = 1;
    }
    if (!isdefined(int_clientnum)) {
        if (self islocalplayer()) {
            int_clientnum = self getlocalclientnumber();
        }
        if (!isdefined(int_clientnum)) {
            return;
        }
    }
    already_in_array = 0;
    if (self._zombie_visionset_list.size != 0) {
        for (i = 0; i < self._zombie_visionset_list.size; i++) {
            if (isdefined(self._zombie_visionset_list[i].vision_set) && self._zombie_visionset_list[i].vision_set == str_visionset) {
                already_in_array = 1;
                if (self._zombie_visionset_list[i].priority != int_priority) {
                    self._zombie_visionset_list[i].priority = int_priority;
                }
                break;
            }
        }
    }
    if (!already_in_array) {
        temp_struct = spawnstruct();
        temp_struct.vision_set = str_visionset;
        temp_struct.priority = int_priority;
        array::add(self._zombie_visionset_list, temp_struct, 0);
    }
    vision_to_set = self zombie_highest_vision_set_apply();
    if (isdefined(vision_to_set)) {
        visionsetnaked(int_clientnum, vision_to_set, flt_transition_time);
        return;
    }
    visionsetnaked(int_clientnum, "undefined", flt_transition_time);
}

// Namespace zm
// Params 3, eflags: 0x0
// Checksum 0x362d963e, Offset: 0x5160
// Size: 0x1dc
function zombie_vision_set_remove(str_visionset, flt_transition_time, int_clientnum) {
    self endon(#"death");
    self endon(#"disconnect");
    if (!isdefined(str_visionset)) {
        return;
    }
    if (!isdefined(flt_transition_time)) {
        flt_transition_time = 1;
    }
    if (!isdefined(self._zombie_visionset_list)) {
        self._zombie_visionset_list = [];
    }
    if (!isdefined(int_clientnum)) {
        if (self islocalplayer()) {
            int_clientnum = self getlocalclientnumber();
        }
        if (!isdefined(int_clientnum)) {
            return;
        }
    }
    temp_struct = undefined;
    for (i = 0; i < self._zombie_visionset_list.size; i++) {
        if (isdefined(self._zombie_visionset_list[i].vision_set) && self._zombie_visionset_list[i].vision_set == str_visionset) {
            temp_struct = self._zombie_visionset_list[i];
        }
    }
    if (isdefined(temp_struct)) {
        arrayremovevalue(self._zombie_visionset_list, temp_struct);
    }
    vision_to_set = self zombie_highest_vision_set_apply();
    if (isdefined(vision_to_set)) {
        visionsetnaked(int_clientnum, vision_to_set, flt_transition_time);
        return;
    }
    visionsetnaked(int_clientnum, "undefined", flt_transition_time);
}

// Namespace zm
// Params 0, eflags: 0x1 linked
// Checksum 0x60da8dfc, Offset: 0x5348
// Size: 0xda
function zombie_highest_vision_set_apply() {
    if (!isdefined(self._zombie_visionset_list)) {
        return;
    }
    highest_score = 0;
    highest_score_vision = undefined;
    for (i = 0; i < self._zombie_visionset_list.size; i++) {
        if (isdefined(self._zombie_visionset_list[i].priority) && self._zombie_visionset_list[i].priority > highest_score) {
            highest_score = self._zombie_visionset_list[i].priority;
            highest_score_vision = self._zombie_visionset_list[i].vision_set;
        }
    }
    return highest_score_vision;
}

// Namespace zm
// Params 7, eflags: 0x1 linked
// Checksum 0xe95875e5, Offset: 0x5430
// Size: 0x13e
function handle_zombie_risers_foliage(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level endon(#"demo_jump");
    self endon(#"entityshutdown");
    if (!oldval && newval) {
        localplayers = level.localplayers;
        playsound(0, "zmb_zombie_spawn", self.origin);
        burst_fx = level._effect["rise_burst_foliage"];
        billow_fx = level._effect["rise_billow_foliage"];
        type = "foliage";
        for (i = 0; i < localplayers.size; i++) {
            self thread rise_dust_fx(i, type, billow_fx, burst_fx);
        }
    }
}

// Namespace zm
// Params 7, eflags: 0x1 linked
// Checksum 0x7b816927, Offset: 0x5578
// Size: 0x13e
function handle_zombie_risers_water(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level endon(#"demo_jump");
    self endon(#"entityshutdown");
    if (!oldval && newval) {
        localplayers = level.localplayers;
        playsound(0, "zmb_zombie_spawn_water", self.origin);
        burst_fx = level._effect["rise_burst_water"];
        billow_fx = level._effect["rise_billow_water"];
        type = "water";
        for (i = 0; i < localplayers.size; i++) {
            self thread rise_dust_fx(i, type, billow_fx, burst_fx);
        }
    }
}

// Namespace zm
// Params 7, eflags: 0x1 linked
// Checksum 0x8df561fe, Offset: 0x56c0
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

// Namespace zm
// Params 7, eflags: 0x1 linked
// Checksum 0x18c23c07, Offset: 0x5888
// Size: 0x1be
function handle_zombie_risers_lowg(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level endon(#"demo_jump");
    self endon(#"entityshutdown");
    if (!oldval && newval) {
        localplayers = level.localplayers;
        sound = "zmb_zombie_spawn";
        burst_fx = level._effect["rise_burst_lg"];
        billow_fx = level._effect["rise_billow_lg"];
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

// Namespace zm
// Params 4, eflags: 0x1 linked
// Checksum 0x1b3b914, Offset: 0x5a50
// Size: 0x326
function rise_dust_fx(clientnum, type, billow_fx, burst_fx) {
    dust_tag = "J_SpineUpper";
    self endon(#"entityshutdown");
    level endon(#"demo_jump");
    if (isdefined(level.zombie_custom_riser_fx_handler)) {
        s_info = self [[ level.zombie_custom_riser_fx_handler ]]();
        if (isdefined(s_info)) {
            if (isdefined(s_info.burst_fx)) {
                burst_fx = s_info.burst_fx;
            }
            if (isdefined(s_info.billow_fx)) {
                billow_fx = s_info.billow_fx;
            }
            if (isdefined(s_info.type)) {
                type = s_info.type;
            }
        }
    }
    if (isdefined(burst_fx)) {
        playfx(clientnum, burst_fx, self.origin + (0, 0, randomintrange(5, 10)));
    }
    wait(0.25);
    if (isdefined(billow_fx)) {
        playfx(clientnum, billow_fx, self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
    }
    wait(2);
    dust_time = 5.5;
    dust_interval = 0.3;
    player = level.localplayers[clientnum];
    effect = level._effect["rise_dust"];
    if (type == "water") {
        effect = level._effect["rise_dust_water"];
    } else if (type == "snow") {
        effect = level._effect["rise_dust_snow"];
    } else if (type == "foliage") {
        effect = level._effect["rise_dust_foliage"];
    } else if (type == "none") {
        return;
    }
    for (t = 0; t < dust_time; t += dust_interval) {
        if (!isdefined(self)) {
            return;
        }
        playfxontag(clientnum, effect, self, dust_tag);
        wait(dust_interval);
    }
}

// Namespace zm
// Params 1, eflags: 0x1 linked
// Checksum 0x34aa64e8, Offset: 0x5d80
// Size: 0x84
function end_last_stand(clientnum) {
    self waittill(#"laststandend");
    /#
        println("gadget_immolation" + clientnum);
    #/
    wait(0.7);
    /#
        println("gadget_immolation");
    #/
    playsound(clientnum, "revive_gasp");
}

// Namespace zm
// Params 1, eflags: 0x1 linked
// Checksum 0xd875607, Offset: 0x5e10
// Size: 0x178
function last_stand_thread(clientnum) {
    self thread end_last_stand(clientnum);
    self endon(#"laststandend");
    /#
        println("gadget_immolation" + clientnum);
    #/
    pause = 0.5;
    for (vol = 0.5; true; vol = 1) {
        id = playsound(clientnum, "chr_heart_beat");
        setsoundvolume(id, vol);
        wait(pause);
        if (pause < 2) {
            pause *= 1.05;
            if (pause > 2) {
                pause = 2;
            }
        }
        if (vol < 1) {
            vol *= 1.05;
            if (vol > 1) {
            }
        }
    }
}

// Namespace zm
// Params 3, eflags: 0x1 linked
// Checksum 0x1839cdce, Offset: 0x5f90
// Size: 0x19e
function last_stand_monitor(clientnum, state, oldstate) {
    player = level.localplayers[clientnum];
    players = level.localplayers;
    if (!isdefined(player)) {
        return;
    }
    if (state == "1") {
        if (!level._laststand[clientnum]) {
            if (!isdefined(level.lslooper)) {
                level.lslooper = spawn(0, player.origin, "script.origin");
            }
            player thread last_stand_thread(clientnum);
            if (players.size <= 1) {
                level.lslooper playloopsound("evt_laststand_loop", 0.3);
            }
            level._laststand[clientnum] = 1;
        }
        return;
    }
    if (level._laststand[clientnum]) {
        if (isdefined(level.lslooper)) {
            level.lslooper stopallloopsounds(0.7);
            playsound(0, "evt_laststand_in", (0, 0, 0));
        }
        player notify(#"laststandend");
        level._laststand[clientnum] = 0;
    }
}

// Namespace zm
// Params 7, eflags: 0x1 linked
// Checksum 0x8ab02a33, Offset: 0x6138
// Size: 0x1b4
function laststand(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (!(self isplayer() && self islocalplayer() && isdemoplaying())) {
            self duplicate_render::set_dr_flag("keyline_ls", 1);
            self duplicate_render::update_dr_filters(localclientnum);
        }
    } else {
        self duplicate_render::set_dr_flag("keyline_ls", 0);
        self duplicate_render::update_dr_filters(localclientnum);
    }
    if (self isplayer() && self islocalplayer() && !isdemoplaying()) {
        if (isdefined(self getlocalclientnumber()) && localclientnum == self getlocalclientnumber()) {
            self zm_audio::sndzmblaststand(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
        }
    }
}

// Namespace zm
// Params 7, eflags: 0x1 linked
// Checksum 0xb29bd461, Offset: 0x62f8
// Size: 0x14c
function update_aat_hud(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    str_localized = aat::get_string(newval);
    icon = aat::get_icon(newval);
    if (str_localized == "none") {
        str_localized = "";
    }
    controllermodel = getuimodelforcontroller(localclientnum);
    aatmodel = createuimodel(controllermodel, "CurrentWeapon.aat");
    setuimodelvalue(aatmodel, str_localized);
    aaticonmodel = createuimodel(controllermodel, "CurrentWeapon.aatIcon");
    setuimodelvalue(aaticonmodel, icon);
}

