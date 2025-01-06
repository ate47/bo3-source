#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection3_sound;
#using scripts/cp/cp_mi_cairo_infection_accolades;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cp_mi_cairo_infection_zombies;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace namespace_6473bd03;

// Namespace namespace_6473bd03
// Params 0, eflags: 0x0
// Checksum 0xf84a8878, Offset: 0xb90
// Size: 0x5b
function main() {
    init_clientfields();
    level thread scene::init("p7_fxanim_cp_infection_house_ceiling_02_bundle");
    level flag::init("underwater_done");
    level._effect["nuke_fx"] = "explosions/fx_exp_nuke_full_inf";
}

// Namespace namespace_6473bd03
// Params 0, eflags: 0x0
// Checksum 0x4db442ed, Offset: 0xbf8
// Size: 0x1c2
function init_clientfields() {
    n_clientbits = getminbitcountfornum(4);
    clientfield::register("world", "infection_hideout_fx", 1, 1, "int");
    clientfield::register("world", "hideout_stretch", 1, 1, "int");
    clientfield::register("world", "stalingrad_rise_nuke", 1, 2, "int");
    clientfield::register("world", "stalingrand_nuke_fog_banks", 1, 1, "int");
    clientfield::register("world", "city_tree_passed", 1, 1, "int");
    clientfield::register("world", "stalingrad_tree_init", 1, 2, "int");
    clientfield::register("world", "stalingrad_city_ceilings", 1, n_clientbits, "int");
    clientfield::register("world", "infection_nuke_lights", 1, 1, "int");
    clientfield::register("toplayer", "ukko_toggling", 1, 1, "counter");
    clientfield::register("toplayer", "nuke_earth_quake", 1, getminbitcountfornum(8), "int");
}

// Namespace namespace_6473bd03
// Params 2, eflags: 0x0
// Checksum 0xc23e6db, Offset: 0xdc8
// Size: 0x2d2
function function_206da579(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
    }
    scene::add_scene_func("cin_inf_13_01_hideout_vign_briefing", &function_a8f91bd1, "play");
    scene::add_scene_func("p7_fxanim_cp_infection_hideout_stretch_bundle", &function_392bb391, "play");
    scene::add_scene_func("cin_inf_12_01_underwater_1st_fall_hideout03", &infection_util::function_efa09886, "done");
    level scene::init("cin_inf_13_01_hideout_vign_briefing");
    playsoundatposition("evt_dream_vox", (-6893, 2203, 5962));
    if (var_74cd64bc) {
        load::function_a2995f22();
    }
    level notify(#"hash_7b06f432");
    level thread scene::play("cin_inf_12_01_underwater_1st_fall_hideout03");
    array::thread_all(level.players, &infection_util::function_9f10c537);
    level clientfield::set("infection_hideout_fx", 1);
    level thread namespace_99d8554b::function_63b34b78();
    if (isdefined(level.var_7635d765)) {
        level thread [[ level.var_7635d765 ]]();
    }
    level thread scene::play("cin_inf_13_01_hideout_vign_briefing");
    level waittill(#"hash_69a80734");
    level thread scene::play("p7_fxanim_cp_infection_hideout_stretch_bundle");
    level thread util::function_d8eaed3d(10);
    level waittill(#"hash_748dfeb3");
    level thread util::clear_streamer_hint();
    var_7d116593 = struct::get("s_interrogation_loc", "targetname");
    infection_util::function_7aca917c(var_7d116593.origin);
    foreach (player in level.players) {
        player playrumbleonentity("cp_infection_hideout_stretch");
    }
    level util::screen_fade_out(5, "black");
    level thread util::clear_streamer_hint();
    level thread function_a35499d1();
}

// Namespace namespace_6473bd03
// Params 1, eflags: 0x0
// Checksum 0x5c4e6cbb, Offset: 0x10a8
// Size: 0x52
function function_a35499d1(a_ents) {
    array::thread_all(level.players, &infection_util::function_e905c73c);
    level notify(#"hash_9c2ad976");
    level thread skipto::function_be8adfb8("hideout");
}

// Namespace namespace_6473bd03
// Params 1, eflags: 0x0
// Checksum 0x7503a489, Offset: 0x1108
// Size: 0x143
function function_392bb391(a_ents) {
    var_b1c83f96 = array("light_fx_01", "light_fx_02", "light_fx_03", "light_fx_04", "fx_light_1", "fx_light_2", "fx_light_3", "fx_light_5", "fx_light_6", "fx_light_7", "fx_light_9");
    foreach (string in var_b1c83f96) {
        a_e_lights = getentarray(string, "targetname");
        foreach (e_light in a_e_lights) {
            e_light thread function_f29981bc(a_ents);
        }
    }
}

// Namespace namespace_6473bd03
// Params 1, eflags: 0x0
// Checksum 0x823ceee1, Offset: 0x1258
// Size: 0x5a
function function_f29981bc(a_ents) {
    self linkto(a_ents["hideout_stretch"], self.targetname + "_jnt");
    level waittill(#"hash_9c2ad976");
    self unlink();
    self delete();
}

// Namespace namespace_6473bd03
// Params 1, eflags: 0x0
// Checksum 0xd177049e, Offset: 0x12c0
// Size: 0xa2
function function_a8f91bd1(a_ents) {
    wait 1;
    level dialog::function_13b3b16a("plyr_where_did_you_go_sa_0", 1);
    level dialog::say("hall_we_held_up_in_the_ol_0", 1, 1);
    level dialog::say("hall_and_made_our_pla_0", 0, 1);
    level dialog::function_13b3b16a("plyr_the_aquifers_you_0", 0);
    level dialog::function_13b3b16a("plyr_it_must_be_kane_sho_0", 3);
}

// Namespace namespace_6473bd03
// Params 4, eflags: 0x0
// Checksum 0x24eb4dac, Offset: 0x1370
// Size: 0x22
function function_299b5716(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_6473bd03
// Params 2, eflags: 0x0
// Checksum 0x56defa34, Offset: 0x13a0
// Size: 0x1ea
function interrogation_main(str_objective, var_74cd64bc) {
    level notify(#"hash_7b06f432");
    scene::add_scene_func("cin_inf_14_01_nasser_vign_interrogate", &function_70e2b47c, "init");
    scene::add_scene_func("cin_inf_14_01_nasser_vign_interrogate", &function_12d4e076, "done");
    skipto::teleport_players(str_objective, 0);
    if (var_74cd64bc) {
        load::function_73adcefc();
        level scene::init("cin_inf_14_01_nasser_vign_interrogate");
        load::function_a2995f22();
    }
    util::screen_fade_out(0, "black");
    level util::delay(0.25, undefined, &util::screen_fade_in, 2, "black");
    array::thread_all(level.players, &infection_util::function_9f10c537);
    level thread function_423ccbef();
    if (isdefined(level.var_adc064f2)) {
        level thread [[ level.var_adc064f2 ]]();
    }
    level thread scene::play("cin_inf_14_01_nasser_vign_interrogate");
    level thread util::function_d8eaed3d(4);
    level waittill(#"hash_3b77e704");
    exploder::exploder("exploder_interrogation_transition");
    level thread util::screen_fade_out(3, "white");
    wait 3;
    level thread util::clear_streamer_hint();
    level thread skipto::function_be8adfb8("interrogation");
}

// Namespace namespace_6473bd03
// Params 1, eflags: 0x0
// Checksum 0xd44ff1dc, Offset: 0x1598
// Size: 0xa
function function_70e2b47c(a_ents) {
    
}

// Namespace namespace_6473bd03
// Params 1, eflags: 0x0
// Checksum 0x85d48cd2, Offset: 0x15b0
// Size: 0x3b
function function_12d4e076(a_ents) {
    array::thread_all(level.players, &infection_util::function_e905c73c);
    level notify(#"hash_3dc7df2d");
}

// Namespace namespace_6473bd03
// Params 0, eflags: 0x0
// Checksum 0x681b87e, Offset: 0x15f8
// Size: 0x52
function function_423ccbef() {
    level waittill(#"hash_c71d58c6");
    playsoundatposition("evt_interrogation_vtol", (-7159, 17021, 5990));
    level waittill(#"hash_79fdda3d");
    playsoundatposition("evt_interrogation_vtol_fade", (0, 0, 0));
}

// Namespace namespace_6473bd03
// Params 4, eflags: 0x0
// Checksum 0x6d64f81b, Offset: 0x1658
// Size: 0x72
function function_3aef563f(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    exploder::exploder("city_lightning");
    if (var_74cd64bc) {
        exploder::exploder("exploder_interrogation_transition");
    }
    if (isdefined(level.var_a73e9330)) {
        level.var_a73e9330 delete();
    }
}

// Namespace namespace_6473bd03
// Params 2, eflags: 0x0
// Checksum 0x48b0b995, Offset: 0x16d8
// Size: 0x2fa
function function_607100ba(str_objective, var_74cd64bc) {
    level notify(#"hash_7b06f432");
    if (var_74cd64bc) {
        load::function_73adcefc();
        util::function_d8eaed3d(4);
    } else {
        util::screen_fade_out(0, "white");
    }
    scene::add_scene_func("cin_inf_16_01_zombies_vign_treemoment_intro", &function_a5128547, "play");
    scene::add_scene_func("cin_inf_16_01_zombies_vign_treemoment_intro", &function_801f28a1, "done");
    scene::add_scene_func("cin_inf_14_04_sarah_vign_05", &function_c5b11e32, "play");
    if (var_74cd64bc) {
        load::function_a2995f22();
        util::screen_fade_out(0);
        util::delay(1, undefined, &util::screen_fade_in, 1);
    } else {
        util::delay(1, undefined, &util::screen_fade_in, 1, "white");
    }
    skipto::teleport_players(str_objective, 1);
    if (isdefined(level.var_b15c12bf)) {
        level thread [[ level.var_b15c12bf ]]();
    }
    level scene::play("cin_inf_14_04_sarah_vign_05");
    if (var_74cd64bc) {
        level thread util::clear_streamer_hint();
    }
    var_7d116593 = struct::get("s_city_loc", "targetname");
    infection_util::function_7aca917c(var_7d116593.origin);
    util::delay(1, undefined, &util::screen_fade_in, 2.5, "white");
    level thread scene::play("cin_inf_16_01_zombies_vign_treemoment_intro");
    level thread function_579b7304();
    wait 5;
    if (isdefined(level.var_e8717a7c)) {
        level thread [[ level.var_e8717a7c ]]();
    }
    level thread function_136fcf00();
    wait 5;
    level thread function_8877c63f();
    foreach (player in level.players) {
        player playrumbleonentity("cp_infection_hideout_stretch");
    }
    level thread util::clear_streamer_hint();
}

// Namespace namespace_6473bd03
// Params 0, eflags: 0x0
// Checksum 0x9cc6fbf6, Offset: 0x19e0
// Size: 0x10a
function function_579b7304() {
    level.var_e6467acd = getent("sarah", "animname");
    if (!isdefined(level.var_e6467acd)) {
        level.var_e6467acd = spawner::simple_spawn_single("sarah");
    }
    level.var_e6467acd.goalradius = 32;
    level.var_e6467acd setteam("allies");
    level.var_e6467acd ai::set_ignoreall(1);
    level.var_e6467acd ai::set_ignoreme(1);
    level.var_e6467acd util::magic_bullet_shield();
    level.var_e6467acd ai::gun_remove();
    level.var_e6467acd.allowpain = 0;
    level thread scene::play("cin_inf_16_01_zombies_vign_treemoment_gameplay_loop");
}

// Namespace namespace_6473bd03
// Params 1, eflags: 0x0
// Checksum 0xdfc21895, Offset: 0x1af8
// Size: 0x32
function function_c5b11e32(a_ents) {
    level waittill(#"start_fade");
    level thread util::screen_fade_out(1, "white");
}

// Namespace namespace_6473bd03
// Params 1, eflags: 0x0
// Checksum 0x5f55fd52, Offset: 0x1b38
// Size: 0x32
function function_a5128547(a_ents) {
    a_ents["player 1"] waittill(#"hash_b18eeabf");
    level thread scene::play("p7_fxanim_cp_infection_reverse_stalingrad_house_bundle");
}

// Namespace namespace_6473bd03
// Params 1, eflags: 0x0
// Checksum 0x409dfef8, Offset: 0x1b78
// Size: 0x22
function function_801f28a1(a_ents) {
    level thread skipto::function_be8adfb8("city_barren");
}

// Namespace namespace_6473bd03
// Params 0, eflags: 0x0
// Checksum 0xf27f128a, Offset: 0x1ba8
// Size: 0x3a
function function_8877c63f() {
    level.players[0] playsound("evt_city_rise");
    level clientfield::set("stalingrad_rise_nuke", 1);
}

// Namespace namespace_6473bd03
// Params 4, eflags: 0x0
// Checksum 0x87a45cc3, Offset: 0x1bf0
// Size: 0x22
function function_eebf61b(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_6473bd03
// Params 0, eflags: 0x0
// Checksum 0x57f8eab1, Offset: 0x1c20
// Size: 0x3a
function function_136fcf00() {
    level clientfield::set("stalingrad_tree_init", 1);
    level.players[0] playsound("evt_tree_grow");
}

// Namespace namespace_6473bd03
// Params 2, eflags: 0x0
// Checksum 0xd80941b7, Offset: 0x1c68
// Size: 0x22a
function function_67c4a95f(str_objective, var_74cd64bc) {
    level notify(#"hash_7b06f432");
    spawner::add_global_spawn_function("axis", &function_40dc724e);
    namespace_f25bd8c8::function_6c777c8d();
    namespace_f25bd8c8::function_a0fb8ca9();
    namespace_f25bd8c8::function_70cafec1();
    if (var_74cd64bc) {
        load::function_73adcefc();
        level clientfield::set("stalingrad_tree_init", 1);
        level clientfield::set("stalingrad_rise_nuke", 1);
        level thread function_579b7304();
        load::function_a2995f22();
        level thread util::screen_fade_in(2, "black");
        skipto::teleport_players(str_objective, 1);
    } else {
        util::screen_fade_out(0.3, "white");
        skipto::teleport_players(str_objective, 1);
        level thread util::screen_fade_in(0.2, "white");
    }
    infection_util::function_aa0ddbc3(1);
    level thread function_bf049e87();
    level thread function_e595eb57();
    level flag::clear("spawn_zombies");
    level notify(#"hash_ee152b14");
    level thread function_33c4ce19();
    objectives::set("cp_level_infection_zombies");
    playsoundatposition("evt_inf_spawn", (27444, 554, -3252));
    level thread function_c4fe5f45();
    level flag::wait_till("sarah_tree");
    level thread skipto::function_be8adfb8("city");
}

// Namespace namespace_6473bd03
// Params 0, eflags: 0x0
// Checksum 0x3bde766, Offset: 0x1ea0
// Size: 0xc2
function function_33c4ce19() {
    ent1 = spawn("script_origin", (27559, -255, -3078));
    ent2 = spawn("script_origin", (27421, 1613, -2992));
    ent1 playloopsound("evt_zombies_walla", 2);
    wait 12;
    ent2 playloopsound("evt_zombies_walla", 2);
    level flag::wait_till("zombies_completed");
    ent1 delete();
    ent2 delete();
}

// Namespace namespace_6473bd03
// Params 0, eflags: 0x0
// Checksum 0x60bd296, Offset: 0x1f70
// Size: 0x32
function function_40dc724e() {
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    }
    self clientfield::set("zombie_tac_mode_disable", 1);
}

// Namespace namespace_6473bd03
// Params 0, eflags: 0x0
// Checksum 0xbc199338, Offset: 0x1fb0
// Size: 0x32
function function_c4fe5f45() {
    level dialog::function_13b3b16a("plyr_what_the_hell_is_tha_0", 3);
    level dialog::function_13b3b16a("plyr_sarah_these_monste_0", 8);
}

// Namespace namespace_6473bd03
// Params 0, eflags: 0x0
// Checksum 0x3661ed9d, Offset: 0x1ff0
// Size: 0x4a
function function_e595eb57() {
    var_ef5c86ba = getentarray("t_house_ceiling", "targetname");
    array::thread_all(var_ef5c86ba, &function_b951f4cb);
}

// Namespace namespace_6473bd03
// Params 0, eflags: 0x0
// Checksum 0x8a5b1956, Offset: 0x2048
// Size: 0x42
function function_545f4b96() {
    wait 2.5;
    var_115ce1e8 = getent("pavlovs_house_second_floor_railing_clip", "targetname");
    var_115ce1e8 delete();
}

// Namespace namespace_6473bd03
// Params 0, eflags: 0x0
// Checksum 0xa109daab, Offset: 0x2098
// Size: 0x127
function function_b951f4cb() {
    self endon(#"death");
    if (isdefined(self.target)) {
        s_target = struct::get(self.target, "targetname");
    }
    wait 3;
    while (true) {
        self trigger::wait_till();
        if (isplayer(self.who)) {
            player = self.who;
            if (isdefined(s_target)) {
                self thread function_216c9445(player, s_target);
                self waittill(#"hash_e8c77093");
                self notify(#"hash_77e1a075");
            }
            if (self.script_int == 2) {
                level thread scene::play("p7_fxanim_cp_infection_house_ceiling_02_bundle");
            } else {
                level clientfield::set("stalingrad_city_ceilings", self.script_int);
                if (self.script_int == 3) {
                    level thread function_545f4b96();
                }
            }
            self delete();
            return;
        }
    }
}

// Namespace namespace_6473bd03
// Params 2, eflags: 0x0
// Checksum 0x1c413a38, Offset: 0x21c8
// Size: 0x63
function function_216c9445(player, s_target) {
    self endon(#"hash_77e1a075");
    self endon(#"death");
    player endon(#"death");
    while (!player infection_util::function_72268bc2(s_target, 0.5, 400)) {
        wait 0.1;
    }
    self notify(#"hash_e8c77093");
}

// Namespace namespace_6473bd03
// Params 4, eflags: 0x0
// Checksum 0xc5e78d20, Offset: 0x2238
// Size: 0xe3
function function_36ff1cdc(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    namespace_f25bd8c8::function_bbb224b7();
    spawner::remove_global_spawn_function("axis", &function_40dc724e);
    var_ef5c86ba = getentarray("t_house_ceiling", "targetname");
    foreach (trig in var_ef5c86ba) {
        trig delete();
    }
}

// Namespace namespace_6473bd03
// Params 2, eflags: 0x0
// Checksum 0x73788c8d, Offset: 0x2328
// Size: 0x1da
function function_7bb61977(str_objective, var_74cd64bc) {
    level thread clientfield::set("city_tree_passed", 1);
    level.var_8ebdde9d = 1;
    if (var_74cd64bc) {
        load::function_73adcefc();
        level clientfield::set("stalingrad_rise_nuke", 1);
        level clientfield::set("stalingrad_tree_init", 1);
        level thread scene::skipto_end("p7_fxanim_cp_infection_house_ceiling_02_bundle");
        var_19a2b88 = 4;
        for (i = 0; i < var_19a2b88; i++) {
            level clientfield::set("stalingrad_city_ceilings", i);
        }
        level thread function_545f4b96();
        wait 3;
        infection_util::function_aa0ddbc3(1);
        level thread function_bf049e87();
        level flag::clear("spawn_zombies");
        level.round_number = 4;
        level notify(#"hash_ee152b14");
        level thread function_33c4ce19();
        objectives::set("cp_level_infection_zombies");
        level flag::set("zombies_final_round");
        level flag::set("spawn_zombies");
        load::function_a2995f22();
    }
    level flag::wait_till("zombies_completed");
    level thread skipto::function_be8adfb8("city_tree");
    infection_util::function_aa0ddbc3(0);
}

// Namespace namespace_6473bd03
// Params 4, eflags: 0x0
// Checksum 0xcbb994c7, Offset: 0x2510
// Size: 0x1fb
function function_7e8dc9e7(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level notify(#"zombies_completed");
    level flag::set("zombies_completed");
    zombies = getaispeciesarray(level.zombie_team, "all");
    if (isdefined(zombies)) {
        for (i = 0; i < zombies.size; i++) {
            zombies[i] delete();
        }
    }
    namespace_f25bd8c8::function_e9c21474();
    if (isdefined(level.var_e6467acd)) {
        level.var_e6467acd delete();
    }
    var_9b40c1cb = getent("pavlov_house_fire", "targetname");
    if (isdefined(var_9b40c1cb)) {
        var_9b40c1cb delete();
    }
    var_acc45090 = getent("pavlov_house_fire_warning", "targetname");
    if (isdefined(var_acc45090)) {
        var_acc45090 delete();
    }
    var_c9c77dfb = getentarray("firewall_firepos", "targetname");
    foreach (ent in var_c9c77dfb) {
        ent clientfield::set("zombie_fire_wall_fx", 0);
        util::wait_network_frame();
        ent delete();
    }
}

// Namespace namespace_6473bd03
// Params 0, eflags: 0x0
// Checksum 0xc07a8fe1, Offset: 0x2718
// Size: 0x62
function function_5be37ad8() {
    level endon(#"zombies_completed");
    self endon(#"death");
    if (!(isdefined(level.var_8ebdde9d) && level.var_8ebdde9d)) {
        level flag::set("spawn_zombies");
        self thread function_afd36cff();
        level thread function_8c3b0a86();
    }
}

// Namespace namespace_6473bd03
// Params 0, eflags: 0x0
// Checksum 0xaf596a5b, Offset: 0x2788
// Size: 0x9a
function function_afd36cff() {
    level endon(#"zombies_completed");
    self endon(#"death");
    self endon(#"hash_9ce403cf");
    level waittill(#"hash_c7d17793");
    wait 2;
    level thread namespace_b0a87e94::function_f83fb174(0);
    self scene::play("cin_inf_16_01_zombies_vign_treemoment_talk01", self);
    self thread scene::play("cin_inf_16_01_zombies_vign_treemoment_gameplay_loop", self);
    level flag::set("zombies_final_round");
    level flag::set("spawn_zombies");
}

// Namespace namespace_6473bd03
// Params 0, eflags: 0x0
// Checksum 0x5a92ed05, Offset: 0x2830
// Size: 0x82
function function_8c3b0a86() {
    while (level.round_number < 3) {
        level waittill(#"end_of_round");
    }
    level dialog::function_13b3b16a("plyr_hall_we_can_t_stay_0", 0);
    wait 2;
    level dialog::say("corv_let_her_go_0", 0);
    level dialog::function_13b3b16a("plyr_sarah_whoever_that_0", 1);
    level dialog::function_13b3b16a("plyr_who_are_you_what_0", 1);
}

// Namespace namespace_6473bd03
// Params 0, eflags: 0x0
// Checksum 0x8df60419, Offset: 0x28c0
// Size: 0xcd
function function_bf049e87() {
    while (!level flag::get("zombies_completed")) {
        level thread lui::screen_fade(0.2, 0.7, 1, "white");
        playsoundatposition("evt_infection_thunder_special", (0, 0, 0));
        wait 0.5;
        level thread lui::screen_fade(1, 0, 0.7, "white");
        wait randomfloatrange(0.3, 1.2);
        playsoundatposition("evt_infection_thunder_special", (0, 0, 0));
        wait randomfloatrange(6, 36);
    }
}

// Namespace namespace_6473bd03
// Params 0, eflags: 0x0
// Checksum 0x345f92df, Offset: 0x2998
// Size: 0x73
function function_5b6766b2() {
    foreach (player in getplayers()) {
        player thread clientfield::increment_to_player("ukko_toggling");
    }
}

// Namespace namespace_6473bd03
// Params 2, eflags: 0x0
// Checksum 0xe23198b6, Offset: 0x2a18
// Size: 0x1a2
function function_71d39006(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level clientfield::set("stalingrad_rise_nuke", 1);
        level clientfield::set("stalingrad_tree_init", 1);
        skipto::teleport_players(str_objective, 0);
        level flag::wait_till("all_players_spawned");
        level thread scene::skipto_end("p7_fxanim_cp_infection_house_ceiling_02_bundle");
        var_19a2b88 = 4;
        for (i = 0; i < var_19a2b88; i++) {
            level clientfield::set("stalingrad_city_ceilings", i);
        }
        wait 7;
        load::function_a2995f22();
    }
    scene::add_scene_func("cin_inf_18_outro_3rd_sh140", &function_9221432, "init");
    level scene::init("cin_inf_18_outro_3rd_sh010");
    level notify(#"hash_7b06f432");
    array::thread_all(level.players, &infection_util::function_9f10c537);
    level thread function_7f848c70();
    level thread function_788d360f();
    level waittill(#"hash_68898176");
    level thread skipto::function_be8adfb8("city_nuked");
}

// Namespace namespace_6473bd03
// Params 0, eflags: 0x0
// Checksum 0x1a52172a, Offset: 0x2bc8
// Size: 0x1bf
function function_788d360f() {
    var_71d5cd4d = struct::get("nuke_fx_pos", "targetname");
    forward = anglestoforward(var_71d5cd4d.angles);
    up = (0, 0, 1);
    var_4b24de52 = 4;
    var_649f4b27 = 4;
    array::thread_all(level.players, &clientfield::set_to_player, "nuke_earth_quake", 2);
    level clientfield::set("zombie_root_grow", 0);
    level clientfield::set("stalingrad_tree_init", 2);
    if (isdefined(level.var_4d547cd9)) {
        level thread [[ level.var_4d547cd9 ]]();
    }
    wait 4;
    level clientfield::set("infection_nuke_lights", 1);
    level clientfield::set("stalingrand_nuke_fog_banks", 1);
    wait 1;
    playfx(level._effect["nuke_fx"], var_71d5cd4d.origin, forward, up);
    array::thread_all(level.players, &clientfield::set_to_player, "nuke_earth_quake", var_4b24de52 + var_649f4b27);
    level clientfield::set("stalingrad_rise_nuke", 2);
    wait var_4b24de52;
    wait var_649f4b27;
    level thread util::screen_fade_out(0, "black");
    wait 2;
    level notify(#"hash_68898176");
}

// Namespace namespace_6473bd03
// Params 1, eflags: 0x0
// Checksum 0xa48d4e49, Offset: 0x2d90
// Size: 0xd9
function nuke_earth_quake(time) {
    start_time = gettime();
    time_passed = 0;
    scale = 0.1;
    self playrumbleonentity("tank_damage_heavy_mp");
    earthquake(0.3, 0.5, self.origin, 100);
    while (time_passed < time) {
        self playrumbleonentity("damage_heavy");
        earthquake(scale, 1, self.origin, 100);
        wait 0.25;
        scale += 0.015;
        time_passed = (gettime() - start_time) / 1000;
    }
}

// Namespace namespace_6473bd03
// Params 0, eflags: 0x0
// Checksum 0xd87a30cd, Offset: 0x2e78
// Size: 0x62
function function_7f848c70() {
    level dialog::say("corv_listen_only_to_the_s_1", 1, 1);
    level dialog::say("corv_let_your_mind_relax_1", 1, 1);
    level dialog::say("corv_imagine_yourself_in_1", 0, 1);
}

// Namespace namespace_6473bd03
// Params 4, eflags: 0x0
// Checksum 0x4326f38a, Offset: 0x2ee8
// Size: 0x3a
function function_567b48bf(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level clientfield::set("stalingrand_nuke_fog_banks", 0);
}

// Namespace namespace_6473bd03
// Params 2, eflags: 0x0
// Checksum 0xa715a5ac, Offset: 0x2f30
// Size: 0xfa
function outro_main(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        scene::add_scene_func("cin_inf_18_outro_3rd_sh140", &function_9221432, "init");
        level scene::init("cin_inf_18_outro_3rd_sh010");
        load::function_a2995f22();
    } else {
        util::streamer_wait();
    }
    level thread util::screen_fade_in(2);
    if (isdefined(level.var_354a0919)) {
        level thread [[ level.var_354a0919 ]]();
    }
    level thread namespace_99d8554b::function_a0a44ed9();
    level thread audio::unlockfrontendmusic("mus_infection_church_intro");
    level scene::play("cin_inf_18_outro_3rd_sh010");
}

// Namespace namespace_6473bd03
// Params 1, eflags: 0x0
// Checksum 0x8530c814, Offset: 0x3038
// Size: 0xfa
function function_9221432(a_ents) {
    level waittill(#"hash_6a87e7bc");
    level clientfield::set("sndIGCsnapshot", 4);
    if (scene::function_b1f75ee9()) {
        level util::screen_fade_out(0, "black", "end_level_fade");
    } else {
        level util::screen_fade_out(0.5, "black", "end_level_fade");
    }
    foreach (player in level.players) {
        player disableweapons();
    }
    level thread skipto::function_be8adfb8("outro");
}

// Namespace namespace_6473bd03
// Params 4, eflags: 0x0
// Checksum 0x5fac10d8, Offset: 0x3140
// Size: 0x22
function outro_cleanup(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

