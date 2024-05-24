#using scripts/zm/zm_theater_teleporter;
#using scripts/zm/zm_theater_fx;
#using scripts/zm/zm_theater_ffotd;
#using scripts/zm/zm_theater_amb;
#using scripts/zm/_zm_audio_zhd;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_trap_fire;
#using scripts/zm/_zm_trap_electric;
#using scripts/zm/_zm_weap_thundergun;
#using scripts/zm/_zm_weap_cymbal_monkey;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerup_insta_kill;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_free_perk;
#using scripts/zm/_zm_powerup_fire_sale;
#using scripts/zm/_zm_powerup_carpenter;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_perk_deadshot;
#using scripts/zm/_zm_perk_staminup;
#using scripts/zm/_zm_perk_widows_wine;
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/_zm_perk_random;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_ai_quad;
#using scripts/zm/_zm_ai_dogs;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_aed37ba8;

// Namespace namespace_aed37ba8
// Params 0, eflags: 0x2
// Checksum 0x341b7d08, Offset: 0x920
// Size: 0x1c
function autoexec opt_in() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
}

// Namespace namespace_aed37ba8
// Params 0, eflags: 0x1 linked
// Checksum 0x795593a6, Offset: 0x948
// Size: 0x22c
function main() {
    namespace_16a77fe2::main_start();
    include_weapons();
    level.default_game_mode = "zclassic";
    level.default_start_location = "default";
    visionset_mgr::register_visionset_info("flare", 21000, 1, "flare", "flare");
    visionset_mgr::register_visionset_info("cheat_bw_contrast", 21000, 1, "cheat_bw_contrast", "cheat_bw_invert_contrast");
    visionset_mgr::register_visionset_info("cheat_bw_invert_contrast", 21000, 1, "cheat_bw_invert_contrast", "cheat_bw_invert_contrast");
    visionset_mgr::register_visionset_info("zombie_turned", 21000, 1, "zombie_turned", "zombie_turned");
    register_clientfields();
    namespace_8847920b::main();
    namespace_265ae7e9::main();
    namespace_6d4f3e39::main();
    level.var_21469639 = 98;
    function_4362fcc1();
    load::main();
    namespace_570c8452::init();
    thread util::waitforclient(0);
    level._power_on = 0;
    level thread function_3825d415();
    level thread function_6ac83719();
    level thread function_dcf14adc();
    level thread function_d87a7dcc();
    level thread startzmbspawnersoundloops();
    namespace_16a77fe2::main_end();
}

// Namespace namespace_aed37ba8
// Params 0, eflags: 0x1 linked
// Checksum 0x248fcae, Offset: 0xb80
// Size: 0xd4
function function_6ac83719() {
    visionset_mgr::function_980ca37e("zm_theater", 0);
    visionset_mgr::function_a95252c1("");
    visionset_mgr::function_3aea3c1a(0, "zm_theater");
    visionset_mgr::function_3aea3c1a(1, "zombie_theater_erooms_pentagon");
    visionset_mgr::function_3aea3c1a(2, "zombie_theater_eroom_asylum");
    visionset_mgr::function_3aea3c1a(3, "zombie_theater_eroom_girlold");
    visionset_mgr::function_3aea3c1a(4, "zombie_theater_eroom_girlnew");
}

// Namespace namespace_aed37ba8
// Params 0, eflags: 0x1 linked
// Checksum 0x5cc94bdc, Offset: 0xc60
// Size: 0xe2
function function_d87a7dcc() {
    if (isdefined(level.createfx_enabled) && level.createfx_enabled) {
        return;
    }
    for (var_bd7ba30 = 0; true; var_bd7ba30 = 1) {
        if (!level clientfield::get("zombie_power_on")) {
            level.power_on = 0;
            if (var_bd7ba30) {
                level notify(#"hash_dc853f6c");
            }
            level util::waittill_any("power_on", "pwr", "ZPO");
        }
        level notify(#"hash_dc853f6c");
        level util::waittill_any("pwo", "ZPOff");
    }
}

// Namespace namespace_aed37ba8
// Params 0, eflags: 0x1 linked
// Checksum 0xb0a4e944, Offset: 0xd50
// Size: 0x24
function include_weapons() {
    zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_theater_weapons.csv", 1);
}

// Namespace namespace_aed37ba8
// Params 0, eflags: 0x1 linked
// Checksum 0x18683985, Offset: 0xd80
// Size: 0x9c
function function_4362fcc1() {
    level._custom_box_monitor = &function_5cd605a9;
    level.var_bea700d2 = array("start_chest_loc", "foyer_chest_loc", "crematorium_chest_loc", "alleyway_chest_loc", "control_chest_loc", "stage_chest_loc", "dressing_chest_loc", "dining_chest_loc", "theater_chest_loc");
    callback::on_localclient_connect(&function_eff8a342);
}

// Namespace namespace_aed37ba8
// Params 1, eflags: 0x1 linked
// Checksum 0x872138a, Offset: 0xe28
// Size: 0x1a8
function function_eff8a342(clientnum) {
    structs = struct::get_array("magic_box_loc_light", "targetname");
    for (j = 0; j < structs.size; j++) {
        s = structs[j];
        if (!isdefined(s.lights)) {
            s.lights = [];
        }
        if (isdefined(s.lights[clientnum])) {
            if (isdefined(s.lights[clientnum].fx)) {
                s.lights[clientnum].fx delete();
                s.lights[clientnum].fx = undefined;
            }
            s.lights[clientnum] delete();
            s.lights[clientnum] = undefined;
        }
        s.lights[clientnum] = util::spawn_model(clientnum, "p7_zm_nac_cagelight", s.origin, s.angles);
    }
}

// Namespace namespace_aed37ba8
// Params 2, eflags: 0x0
// Checksum 0x1d0af62b, Offset: 0xfd8
// Size: 0xf6
function function_ac2087dd(clientnum, name) {
    structs = struct::get_array(name, "script_noteworthy");
    lights = [];
    for (i = 0; i < structs.size; i++) {
        lights[lights.size] = structs[i].lights[clientnum];
        if (structs[i].script_string === "move_fx") {
            lights[lights.size - 1].script_string = structs[i].script_string;
        }
    }
    return lights;
}

// Namespace namespace_aed37ba8
// Params 1, eflags: 0x1 linked
// Checksum 0x4351c4a7, Offset: 0x10d8
// Size: 0x66
function function_cd14d250(clientnum) {
    level notify("kill_box_light_threads_" + clientnum);
    for (i = 0; i < level.var_bea700d2.size; i++) {
        function_e2daf77(clientnum, i);
    }
}

// Namespace namespace_aed37ba8
// Params 2, eflags: 0x1 linked
// Checksum 0xa118788a, Offset: 0x1148
// Size: 0xda
function function_df3c225f(clientnum, period) {
    level notify("kill_box_light_threads_" + clientnum);
    level endon("kill_box_light_threads_" + clientnum);
    while (true) {
        wait(period);
        for (i = 0; i < level.var_bea700d2.size; i++) {
            function_e2275c1d(clientnum, i);
        }
        wait(period);
        for (i = 0; i < level.var_bea700d2.size; i++) {
            function_e2daf77(clientnum, i, 1);
        }
    }
}

// Namespace namespace_aed37ba8
// Params 3, eflags: 0x1 linked
// Checksum 0xcb63c5, Offset: 0x1230
// Size: 0x7c
function function_e2275c1d(clientnum, var_307e89fe, play_fx) {
    if (!isdefined(play_fx)) {
        play_fx = 0;
    }
    if (var_307e89fe == level._box_indicator_no_lights) {
        return;
    }
    name = level.var_bea700d2[var_307e89fe] + "_lgt";
    exploder::exploder(name);
}

// Namespace namespace_aed37ba8
// Params 3, eflags: 0x1 linked
// Checksum 0xdc3fb92a, Offset: 0x12b8
// Size: 0x84
function function_e2daf77(clientnum, var_307e89fe, var_a5e484fd) {
    if (!isdefined(var_a5e484fd)) {
        level notify("kill_box_light_threads_" + clientnum);
    }
    if (var_307e89fe == level._box_indicator_no_lights) {
        return;
    }
    name = level.var_bea700d2[var_307e89fe] + "_lgt";
    exploder::stop_exploder(name);
}

// Namespace namespace_aed37ba8
// Params 3, eflags: 0x1 linked
// Checksum 0xea5b77c0, Offset: 0x1348
// Size: 0x16c
function function_5cd605a9(clientnum, state, oldstate) {
    s = int(state);
    if (s == level._box_indicator_no_lights) {
        function_cd14d250(clientnum);
        return;
    }
    if (s == level._box_indicator_flash_lights_moving) {
        level thread function_df3c225f(clientnum, 0.25);
        return;
    }
    if (s == level.var_21469639) {
        level thread function_df3c225f(clientnum, 0.3);
        return;
    }
    if (s < 0 || s > level.var_bea700d2.size) {
        return;
    }
    level notify("kill_box_light_threads_" + clientnum);
    function_cd14d250(clientnum);
    level._box_indicator = s;
    if (level clientfield::get("zombie_power_on")) {
        function_e2275c1d(clientnum, level._box_indicator, 1);
    }
}

// Namespace namespace_aed37ba8
// Params 0, eflags: 0x1 linked
// Checksum 0x735b9afc, Offset: 0x14c0
// Size: 0xe0
function function_3825d415() {
    wait(0.016);
    if (!level clientfield::get("zombie_power_on")) {
        level waittill(#"zpo");
    }
    while (true) {
        level._power_on = 1;
        if (level._box_indicator != level._box_indicator_no_lights) {
            for (i = 0; i < getlocalplayers().size; i++) {
                function_5cd605a9(i, level._box_indicator);
            }
        }
        level notify(#"hash_9f91944d");
        level notify(#"hash_a39e7bd2");
        level waittill(#"zpo");
    }
}

// Namespace namespace_aed37ba8
// Params 0, eflags: 0x1 linked
// Checksum 0xfd275f47, Offset: 0x15a8
// Size: 0xbe
function function_dcf14adc() {
    wait(0.016);
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        var_3e0fbdba = getentarray(i, "model_lights_on", "targetname");
        if (isdefined(var_3e0fbdba) && var_3e0fbdba.size > 0) {
            array::thread_all(var_3e0fbdba, &function_7414b0df);
        }
    }
}

// Namespace namespace_aed37ba8
// Params 0, eflags: 0x1 linked
// Checksum 0x23d312ce, Offset: 0x1670
// Size: 0xa4
function function_7414b0df() {
    wait(0.016);
    if (!level clientfield::get("zombie_power_on")) {
        level waittill(#"zpo");
    }
    if (self.model == "lights_hang_single") {
        self setmodel("lights_hang_single_on_nonflkr");
        return;
    }
    if (self.model == "zombie_zapper_cagelight") {
        self setmodel("zombie_zapper_cagelight_on");
    }
}

// Namespace namespace_aed37ba8
// Params 0, eflags: 0x1 linked
// Checksum 0x218c80ba, Offset: 0x1720
// Size: 0xfc
function register_clientfields() {
    clientfield::register("world", "zm_theater_screen_in_place", 21000, 1, "int", &function_17e9c62f, 0, 0);
    clientfield::register("scriptmover", "zombie_has_eyes", 21000, 1, "int", &zm::zombie_eyes_clientfield_cb, 0, 0);
    clientfield::register("world", "zm_theater_movie_reel_playing", 21000, 2, "int", &namespace_265ae7e9::function_e4b3e1ca, 0, 0);
    namespace_6e97c459::function_225a92d6("movieReel", 21000);
}

// Namespace namespace_aed37ba8
// Params 7, eflags: 0x0
// Checksum 0xa483ad33, Offset: 0x1828
// Size: 0x3c
function function_ce6ee03b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    
}

// Namespace namespace_aed37ba8
// Params 7, eflags: 0x1 linked
// Checksum 0xe04babdf, Offset: 0x1870
// Size: 0x3c
function function_17e9c62f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    
}

// Namespace namespace_aed37ba8
// Params 0, eflags: 0x1 linked
// Checksum 0x84187b56, Offset: 0x18b8
// Size: 0x15c
function startzmbspawnersoundloops() {
    loopers = struct::get_array("exterior_goal", "targetname");
    if (isdefined(loopers) && loopers.size > 0) {
        delay = 0;
        /#
            if (getdvarint("zombie_theater_erooms_pentagon") > 0) {
                println("zombie_theater_erooms_pentagon" + loopers.size + "zombie_theater_erooms_pentagon");
            }
        #/
        for (i = 0; i < loopers.size; i++) {
            loopers[i] thread soundloopthink();
            delay += 1;
            if (delay % 20 == 0) {
                wait(0.016);
            }
        }
        return;
    }
    /#
        if (getdvarint("zombie_theater_erooms_pentagon") > 0) {
            println("zombie_theater_erooms_pentagon");
        }
    #/
}

// Namespace namespace_aed37ba8
// Params 0, eflags: 0x1 linked
// Checksum 0x1cfd44db, Offset: 0x1a20
// Size: 0x16c
function soundloopthink() {
    if (!isdefined(self.origin)) {
        return;
    }
    if (!isdefined(self.script_sound)) {
        self.script_sound = "zmb_spawn_walla";
    }
    notifyname = "";
    /#
        assert(isdefined(notifyname));
    #/
    if (isdefined(self.script_string)) {
        notifyname = self.script_string;
    }
    /#
        assert(isdefined(notifyname));
    #/
    started = 1;
    if (isdefined(self.script_int)) {
        started = self.script_int != 0;
    }
    if (started) {
        soundloopemitter(self.script_sound, self.origin);
    }
    if (notifyname != "") {
        for (;;) {
            level waittill(notifyname);
            if (started) {
                soundstoploopemitter(self.script_sound, self.origin);
            } else {
                soundloopemitter(self.script_sound, self.origin);
            }
            started = !started;
        }
    }
}

