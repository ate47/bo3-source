#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_bb;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_ai_astro;
#using scripts/zm/_zm_ai_dogs;
#using scripts/zm/_zm_ai_quad;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_audio_zhd;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_blockers;
#using scripts/zm/_zm_equip_gasmask;
#using scripts/zm/_zm_equip_hacker;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_hackables_boards;
#using scripts/zm/_zm_hackables_box;
#using scripts/zm/_zm_hackables_doors;
#using scripts/zm/_zm_hackables_packapunch;
#using scripts/zm/_zm_hackables_perks;
#using scripts/zm/_zm_hackables_powerups;
#using scripts/zm/_zm_hackables_wallbuys;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/_zm_perk_deadshot;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_staminup;
#using scripts/zm/_zm_perk_widows_wine;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_pers_upgrades_system;
#using scripts/zm/_zm_power;
#using scripts/zm/_zm_powerup_carpenter;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_powerup_fire_sale;
#using scripts/zm/_zm_powerup_free_perk;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_insta_kill;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_timer;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_annihilator;
#using scripts/zm/_zm_weap_black_hole_bomb;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_weap_bowie;
#using scripts/zm/_zm_weap_microwavegun;
#using scripts/zm/_zm_weap_quantum_bomb;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/bgbs/_zm_bgb_anywhere_but_here;
#using scripts/zm/zm_moon;
#using scripts/zm/zm_moon_achievement;
#using scripts/zm/zm_moon_ai_quad;
#using scripts/zm/zm_moon_amb;
#using scripts/zm/zm_moon_digger;
#using scripts/zm/zm_moon_ffotd;
#using scripts/zm/zm_moon_fx;
#using scripts/zm/zm_moon_gravity;
#using scripts/zm/zm_moon_jump_pad;
#using scripts/zm/zm_moon_sq;
#using scripts/zm/zm_moon_teleporter;
#using scripts/zm/zm_moon_utility;
#using scripts/zm/zm_moon_wasteland;
#using scripts/zm/zm_moon_zombie;
#using scripts/zm/zm_zmhd_cleanup_mgr;

#namespace zm_moon;

// Namespace zm_moon
// Params 0, eflags: 0x2
// Checksum 0xc0dfa5f8, Offset: 0x1dc8
// Size: 0x28
function autoexec opt_in() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
    level.pack_a_punch_camo_index = -124;
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0xb9d2f50e, Offset: 0x1df8
// Size: 0xbb4
function main() {
    level thread zm_moon_ffotd::main_start();
    level.default_game_mode = "zclassic";
    level.default_start_location = "default";
    level.use_multiple_spawns = 1;
    level.use_low_gravity_risers = 1;
    level.var_9b27bea6 = 1;
    level.var_bbd4901d = getweapon("equip_hacker");
    level.var_771f29c4 = 0;
    level._use_choke_weapon_hints = 1;
    level._use_choke_blockers = 1;
    level.var_c9271e19 = &function_a5a65454;
    level._limited_equipment = [];
    level._limited_equipment[level._limited_equipment.size] = level.var_bbd4901d;
    level.var_e608f920 = &function_b43fe8f;
    level.var_605ba2da = &function_371653e5;
    level.var_4ac5afce = &function_65df3c5d;
    level.func_magicbox_update_prompt_use_override = &func_magicbox_update_prompt_use_override;
    level.var_e406dc3d = &zm_moon_jump_pad::function_d4f0f4fe;
    level.dont_unset_perk_when_machine_paused = 1;
    level._no_water_risers = 1;
    level.use_clientside_board_fx = 1;
    level.riser_fx_on_client = 1;
    level.var_73e65144 = 1;
    level.var_609027b6 = 1;
    level._round_start_func = &zm::round_start;
    callback::on_connect(&function_35a61719);
    callback::on_spawned(&on_player_spawned);
    zm_moon_fx::main();
    zm::init_fx();
    level.zombiemode = 1;
    zm_moon_amb::main();
    level thread setupmusic();
    init_sounds();
    if (getdvarint("artist") > 0) {
        return;
    }
    level.var_6225e4bb = tablelookuprowcount("gamedata/tables/zm/zm_astro_names.csv");
    register_clientfields();
    zm_moon_sq::init_clientfields();
    level.player_out_of_playable_area_monitor = 1;
    level.player_out_of_playable_area_monitor_callback = &function_bef9a31c;
    level thread function_219c9642();
    level.traps = [];
    level.round_think_func = &function_465aa1d3;
    level.random_pandora_box_start = 1;
    level.door_dialog_function = &zm::play_door_dialog;
    level.var_19f030fc = 35;
    level.var_eb9a1da = 1;
    level.var_61c54e76 = 1;
    level.custom_ai_type = [];
    if (!isdefined(level.custom_ai_type)) {
        level.custom_ai_type = [];
    } else if (!isarray(level.custom_ai_type)) {
        level.custom_ai_type = array(level.custom_ai_type);
    }
    level.custom_ai_type[level.custom_ai_type.size] = &zm_ai_dogs::init;
    spawner::add_archetype_spawn_function("zombie_dog", &function_6db62803);
    spawner::add_archetype_spawn_function("astronaut", &function_ff7d3b7);
    level thread zm_moon_utility::function_cf6d9b98();
    level.var_237b30e2 = &function_7837e42a;
    level.var_d244879e = &function_27d7eb16;
    level.var_7d233af = &function_6c901e2e;
    level.var_b8c1e53d = &function_daed1ad5;
    level.var_f04b2acd = &function_7bbd1025;
    level.var_35255f38 = &function_7628a380;
    level.var_f55453ea = &function_fdfa7af5;
    level.zombiemode_offhand_weapon_give_override = &offhand_weapon_give_override;
    level._allow_melee_weapon_switching = 1;
    level.var_e9ec1678 = &function_9f47ebff;
    level.givecustomcharacters = &givecustomcharacters;
    initcharacterstartindex();
    level.var_70f99d16 = 1;
    level.var_7468f0f = 1;
    level._zm_blocker_trigger_think_return_override = &function_d70e1ddb;
    level.var_29d862d9 = &function_89f86341;
    load::main();
    level.default_laststandpistol = getweapon("pistol_m1911");
    level.default_solo_laststandpistol = getweapon("pistol_m1911_upgraded");
    level.laststandpistol = level.default_laststandpistol;
    level.start_weapon = level.default_laststandpistol;
    level thread zm::function_e7cfa7b8();
    zm_ai_quad::function_5af423f4();
    level thread zm_moon_sq::function_5c3d70d5();
    level thread function_54bf648f();
    level.zm_bgb_anywhere_but_here_validation_override = &function_869d6f66;
    level.var_2d4e3645 = &function_d9e1ec4d;
    level.var_35efa94c = &function_f97e7fed;
    level.var_9f5c2c50 = &function_e36dbcf4;
    level.var_4824bb2d = &function_69e4bd99;
    level thread zm::register_sidequest("EOA", "ZOMBIE_TEMPLE_SIDEQUEST");
    level thread zm::register_sidequest("MOON", "ZOMBIE_MOON_SIDEQUEST_TOTAL");
    _zm_weap_bowie::init();
    level.zone_manager_init_func = &function_f382c360;
    init_zones[0] = "bridge_zone";
    init_zones[1] = "nml_zone";
    level thread zm_zonemgr::manage_zones(init_zones);
    level.zombie_ai_limit = 24;
    level zm_moon_digger::function_4ad5a124();
    level thread zm_moon_achievement::init();
    level thread electric_switch();
    zm_moon_wasteland::function_884440ef();
    level thread zm_moon_teleporter::function_b190610();
    level thread zm_moon_teleporter::function_a19db598("generator_teleporter");
    level thread zm_moon_teleporter::function_a19db598("nml_teleporter");
    level thread zm_moon_utility::function_88d6f543();
    level thread function_bd8a9ce6();
    zombie_utility::set_zombie_var("zombie_intermission_time", 15);
    zombie_utility::set_zombie_var("zombie_between_round_time", 10);
    level thread zm_moon_digger::function_583ec468();
    zm_moon_gravity::init();
    zm_moon_jump_pad::init();
    level thread zm_moon_gravity::function_c710beca();
    level thread zm_moon_gravity::function_f41db41e();
    level thread function_d466385c();
    /#
        execdevgui("<dev string:x28>");
        level.custom_devgui = &function_836f39e7;
    #/
    level.custom_intermission = &zm_moon_utility::function_62f051e9;
    level thread function_fef25c86();
    level thread cliff_fall_death();
    level thread function_97f23cdc();
    level.tunnel_6_destroyed = getent("tunnel_6_destroyed", "targetname");
    level.tunnel_6_destroyed hide();
    level.tunnel_11_destroyed = getent("tunnel_11_destroyed", "targetname");
    level.tunnel_11_destroyed hide();
    level.var_a72d0823 = &function_f38c9936;
    level.var_e6d722f = &function_d4687193;
    level.var_75eda423 = &function_761c17e6;
    level._zombiemode_post_respawn_callback = &function_2412214;
    level.var_67a73ecb = &function_2df5f66c;
    level.var_552a9606 = &function_4003badd;
    level.var_9d8e8d95 = &function_357aa92a;
    level.var_43f73d1d = &function_2757495;
    level thread spare_change();
    setdvar("dlc5_get_client_weapon_from_entitystate", 1);
    setdvar("hkai_pathfindIterationLimit", 900);
    scene::add_scene_func("cin_zmhd_sizzle_moon_cam", &cin_zmhd_sizzle_moon_cam, "play");
    level thread zm_moon_ffotd::main_end();
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x7462cac5, Offset: 0x29b8
// Size: 0x15c
function function_ff7d3b7() {
    do {
        var_1acd84fb = randomint(level.var_6225e4bb);
        var_1acd84fb += 1;
    } while (level.var_2c6ea600 === var_1acd84fb);
    level.var_2c6ea600 = var_1acd84fb;
    self clientfield::set("astro_name_index", var_1acd84fb);
    foreach (player in level.players) {
        if (zombie_utility::is_player_valid(player)) {
            owner = player;
            break;
        }
    }
    if (!isdefined(owner)) {
        owner = level.players[0];
    }
    self setentityowner(owner);
    self setclone();
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0xdf4a79c1, Offset: 0x2b20
// Size: 0x21a
function cin_zmhd_sizzle_moon_cam(a_ents) {
    level.disable_print3d_ent = 1;
    var_3aa9d35a = getentarray("airlock_bridge_zone", "script_parameters");
    foreach (var_1cec30db in var_3aa9d35a) {
        a_mdl_doors = getentarray(var_1cec30db.target, "targetname");
        foreach (mdl_door in a_mdl_doors) {
            mdl_door hide();
        }
    }
    foreach (var_6cae1ad0 in a_ents) {
        if (issubstr(var_6cae1ad0.model, "body")) {
            var_6cae1ad0 clientfield::set("zombie_has_eyes", 1);
        }
    }
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0xe4d9b161, Offset: 0x2d48
// Size: 0x10
function function_6db62803() {
    self.ignorevortices = 1;
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0x6335d701, Offset: 0x2d60
// Size: 0x2c
function function_2757495(position) {
    level.var_2c393010 = undefined;
    self thread zm_weap_quantum_bomb::function_bab27d85(position);
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x309cca86, Offset: 0x2d98
// Size: 0x40
function function_869d6f66() {
    if (!isdefined(self zm_bgb_anywhere_but_here::function_728dfe3())) {
        return false;
    }
    if (self.zone_name === "nml_zone") {
        return false;
    }
    return true;
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x81a43a53, Offset: 0x2de0
// Size: 0x20
function function_f97e7fed() {
    if (self.zone_name === "nml_zone") {
        return false;
    }
    return true;
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x7d7adf58, Offset: 0x2e08
// Size: 0x22
function function_e36dbcf4() {
    if (isdefined(level.var_d8417111) && level.var_d8417111) {
        return false;
    }
    return true;
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0xc7c1dac9, Offset: 0x2e38
// Size: 0x2e
function function_69e4bd99() {
    if (level flag::get("enter_nml")) {
        return false;
    }
    return true;
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0x2b2be5fb, Offset: 0x2e70
// Size: 0x58
function function_d9e1ec4d(a_s_valid_respawn_points) {
    var_7de051f = struct::get("nml_zone", "script_noteworthy");
    arrayremovevalue(a_s_valid_respawn_points, var_7de051f);
    return a_s_valid_respawn_points;
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0xed17e1c2, Offset: 0x2ed0
// Size: 0x9c
function function_2412214() {
    if (level flag::get("enter_nml")) {
        self clientfield::set_to_player("player_sky_transition", 1);
    } else {
        self clientfield::set_to_player("player_sky_transition", 0);
    }
    if (!zm_equipment::limited_in_use(level.var_bbd4901d)) {
        self zm_equipment::set_equipment_invisibility_to_player(level.var_bbd4901d, 0);
    }
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0xdb64fe0e, Offset: 0x2f78
// Size: 0x22c
function function_97f23cdc() {
    level flag::wait_till("power_on");
    exploder::exploder("fxexp_140");
    exploder::exploder("fxexp_1100");
    exploder::exploder("lgt_power_on");
    exploder::exploder("lgtexp_exc_powerOn");
    level.var_2f9ab492 = [];
    level.var_2f9ab492["enter_forest_east_zone"] = "fxexp_1010";
    level.var_2f9ab492["generator_exit_east_zone"] = "fxexp_1011";
    level.var_2f9ab492["cata_left_middle_zone"] = "fxexp_1012";
    level.var_2f9ab492["cata_right_middle_zone"] = "fxexp_1013";
    level.var_2f9ab492["bridge_zone"] = "fxexp_1014";
    foreach (str_zone, str_exploder in level.var_2f9ab492) {
        if (!isdefined(level.zones[str_zone].volumes[0].script_string) || level.zones[str_zone].volumes[0].script_string != "lowgravity") {
            exploder::exploder(level.var_2f9ab492[str_zone]);
        }
    }
    level clientfield::set("zombie_power_on", 1);
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x59298203, Offset: 0x31b0
// Size: 0x2a
function function_fef25c86() {
    level thread function_76c614a4();
    level notify(#"pack_a_punch_on");
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0xe60739f2, Offset: 0x31e8
// Size: 0x13a
function function_76c614a4() {
    wait 0.2;
    machine = getentarray("vending_sleight", "targetname");
    for (i = 0; i < machine.size; i++) {
        machine[i] setmodel("p7_zm_vending_sleight");
    }
    level notify(#"hash_90b23cf7");
    var_8973345e = getentarray("vending_jugg", "targetname");
    for (i = 0; i < var_8973345e.size; i++) {
        var_8973345e[i] setmodel("p7_zm_vending_jugg");
        var_8973345e[i] playsound("zmb_perks_power_on");
    }
    level notify(#"hash_d829c0f5");
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x4c6d59d, Offset: 0x3330
// Size: 0x104
function function_d466385c() {
    level thread namespace_359e846b::function_862bc532();
    level thread namespace_75cc53cb::function_4678364();
    level thread namespace_b03b0164::function_7add387d();
    level thread namespace_b1d3fbb7::function_22bc5906();
    level thread namespace_65fac977::function_96d11a0c("zombie_airlock_buy", &zm_moon_utility::function_cfd32447);
    level thread namespace_65fac977::function_96d11a0c();
    level thread namespace_27e18f93::function_5c836466();
    level thread namespace_bcde73b7::box_hacks();
    level thread function_d48fa212();
    level thread function_3e813e5a();
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0xf7e9f78e, Offset: 0x3440
// Size: 0x6a
function function_d70e1ddb(player) {
    if (player zm_equipment::is_active(level.var_bbd4901d)) {
        if (isdefined(self.unitrigger_stub.playertrigger)) {
            zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
        }
        return 1;
    }
    return 0;
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0x5ea24d39, Offset: 0x34b8
// Size: 0x60
function function_89f86341(player) {
    if (player zm_equipment::is_active(level.var_bbd4901d)) {
        if (isdefined(self.trigger_target)) {
            if (self.trigger_target.targetname == "exterior_goal") {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x1ec4b1db, Offset: 0x3520
// Size: 0x42
function function_bef9a31c() {
    if (isdefined(self._padded) && self._padded) {
        return false;
    } else if (isdefined(self.var_dd92caae) && self.var_dd92caae) {
        return false;
    }
    return true;
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x3570
// Size: 0x4
function function_219c9642() {
    
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x83d8ad63, Offset: 0x3580
// Size: 0x168
function function_d48fa212() {
    level flag::init("packapunch_hacked");
    time = 30;
    var_29d7a4f3 = getentarray("zombieland_gate", "targetname");
    for (i = 0; i < var_29d7a4f3.size; i++) {
        var_29d7a4f3[i].startpos = var_29d7a4f3[i].origin;
    }
    while (true) {
        level waittill(#"packapunch_hacked");
        level flag::clear("packapunch_hacked");
        array::thread_all(var_29d7a4f3, &function_be89c100);
        level thread function_2ae641f7(time);
        wait time;
        level flag::set("packapunch_hacked");
        zm_equip_hacker::function_66764564(level.var_515d4af7, &namespace_b03b0164::function_e9bec753);
    }
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x23d6e1d2, Offset: 0x36f0
// Size: 0xa6
function function_3e813e5a() {
    var_89fff8fd = getentarray("zombieland_poi", "targetname");
    for (i = 0; i < var_89fff8fd.size; i++) {
        var_89fff8fd[i] zm_utility::create_zombie_point_of_interest(undefined, 30, 0, 0);
        var_89fff8fd[i] thread zm_utility::create_zombie_point_of_interest_attractor_positions(4, 45);
    }
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0x54e42a9d, Offset: 0x37a0
// Size: 0x346
function function_2ae641f7(time) {
    pack_enclosure = getent("pack_enclosure", "targetname");
    var_89fff8fd = getentarray("zombieland_poi", "targetname");
    players = getplayers();
    var_15a6c4a3 = 0;
    for (i = 0; i < players.size; i++) {
        if (players[i] istouching(pack_enclosure)) {
            var_15a6c4a3++;
        }
    }
    if (var_15a6c4a3 != players.size) {
        return;
    }
    level thread function_d50ff000(time);
    level thread function_95985459(var_89fff8fd);
    while (!level flag::get("packapunch_hacked")) {
        zombies = getaiarray();
        for (i = 0; i < zombies.size; i++) {
            if (zombies[i] istouching(pack_enclosure)) {
                zombies[i].var_1475fd25 = 1;
                zombies[i] thread function_fef75520();
                continue;
            }
            if (!(isdefined(zombies[i].var_e70940c5) && zombies[i].var_e70940c5)) {
                zombies[i] thread function_b4f1a60d();
                zombies[i] thread function_e4ba5f07();
                zombies[i].var_e70940c5 = 1;
            }
        }
        wait 1;
    }
    level flag::wait_till("packapunch_hacked");
    level notify(#"hash_53c81bf2");
    zombies = getaiarray();
    for (i = 0; i < zombies.size; i++) {
        zombies[i].var_e70940c5 = 0;
    }
    for (i = 0; i < var_89fff8fd.size; i++) {
        var_89fff8fd[i] function_47f0ea80();
    }
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x2d9317cd, Offset: 0x3af0
// Size: 0x200
function function_b4f1a60d() {
    self endon(#"death");
    level endon(#"packapunch_hacked");
    self endon(#"nml_bhb");
    poi_array = getentarray("zombieland_poi", "targetname");
    for (x = 0; x < poi_array.size; x++) {
        if (isdefined(poi_array[x].poi_active) && poi_array[x].poi_active) {
            self zm_utility::add_poi_to_ignore_list(poi_array[x]);
        }
    }
    poi_array = array::randomize(poi_array);
    while (!level flag::get("packapunch_hacked")) {
        for (i = 0; i < poi_array.size; i++) {
            self zm_utility::remove_poi_from_ignore_list(poi_array[i]);
            self util::function_183e3618(randomintrange(2, 5), "goal", "bad_path", "death", "nml_bhb", level, "packapunch_hacked");
            self zm_utility::add_poi_to_ignore_list(poi_array[i]);
        }
        poi_array = array::randomize(poi_array);
        self zm_utility::remove_poi_from_ignore_list(poi_array[0]);
        wait 0.05;
    }
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0x328f9926, Offset: 0x3cf8
// Size: 0x78
function function_ea6da57b(poi_array) {
    self endon(#"death");
    level waittill(#"hash_53c81bf2");
    for (i = 0; i < poi_array.size; i++) {
        self zm_utility::remove_poi_from_ignore_list(poi_array[i]);
    }
    self.var_e70940c5 = 0;
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0xa2fe5502, Offset: 0x3d78
// Size: 0x96
function function_d50ff000(time) {
    level endon(#"hash_53c81bf2");
    var_89fff8fd = getentarray("zombieland_poi", "targetname");
    for (i = 0; i < var_89fff8fd.size; i++) {
        poi = var_89fff8fd[i];
        poi zm_utility::activate_zombie_point_of_interest();
    }
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0xad63d288, Offset: 0x3e18
// Size: 0x84
function function_47f0ea80() {
    if (self.script_noteworthy != "zombie_poi") {
        return;
    }
    for (i = 0; i < self.attractor_array.size; i++) {
        self.attractor_array[i] notify(#"kill_poi");
    }
    self.attractor_array = [];
    self.claimed_attractor_positions = [];
    self.poi_active = 0;
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0x2234d233, Offset: 0x3ea8
// Size: 0x9e
function function_95985459(poi_array) {
    while (function_ee0a7f49() && !level flag::get("packapunch_hacked")) {
        wait 0.1;
    }
    level notify(#"hash_53c81bf2");
    for (i = 0; i < poi_array.size; i++) {
        poi_array[i] function_47f0ea80();
    }
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x934caf82, Offset: 0x3f50
// Size: 0xce
function function_ee0a7f49() {
    pack_enclosure = getent("pack_enclosure", "targetname");
    players = getplayers();
    var_15a6c4a3 = 0;
    for (i = 0; i < players.size; i++) {
        if (players[i] istouching(pack_enclosure)) {
            var_15a6c4a3++;
        }
    }
    if (var_15a6c4a3 != players.size) {
        return false;
    }
    return true;
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x792d6024, Offset: 0x4028
// Size: 0x22
function function_d04fbe78() {
    if (isdefined(self.var_1475fd25) && self.var_1475fd25) {
        return true;
    }
    return false;
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x8323ba3f, Offset: 0x4058
// Size: 0x14c
function function_be89c100() {
    time = 1;
    self notsolid();
    if (isdefined(self.script_vector)) {
        self playsound("amb_teleporter_gate_start");
        self moveto(self.startpos + self.script_vector, time);
        self thread function_60eb630f();
        level flag::wait_till("packapunch_hacked");
        self notsolid();
        if (self.classname == "script_brushmodel") {
            self connectpaths();
        }
        self playsound("amb_teleporter_gate_start");
        self moveto(self.startpos, time);
        self thread zm_blockers::door_solid_thread();
    }
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x536bfad0, Offset: 0x41b0
// Size: 0xe8
function function_60eb630f() {
    self waittill(#"movedone");
    self.door_moving = undefined;
    while (true) {
        players = getplayers();
        player_touching = 0;
        for (i = 0; i < players.size; i++) {
            if (players[i] istouching(self)) {
                player_touching = 1;
                break;
            }
        }
        if (!player_touching) {
            self solid();
            self disconnectpaths();
            return;
        }
        wait 1;
    }
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x26ea021a, Offset: 0x42a0
// Size: 0x232
function function_e4ba5f07() {
    self endon(#"death");
    nml_bhb = undefined;
    var_89fff8fd = getentarray("zombieland_poi", "targetname");
    pack_enclosure = getent("pack_enclosure", "targetname");
    while (!level flag::get("packapunch_hacked")) {
        var_349fc8f9 = getentarray("zombie_poi", "script_noteworthy");
        for (i = 0; i < var_349fc8f9.size; i++) {
            if (isdefined(var_349fc8f9[i].targetname) && var_349fc8f9[i].targetname == "zm_bhb") {
                if (function_e5b5da3a(var_349fc8f9[i])) {
                    nml_bhb = var_349fc8f9[i];
                    self zm_utility::remove_poi_from_ignore_list(nml_bhb);
                    continue;
                }
                self zm_utility::add_poi_to_ignore_list(var_349fc8f9[i]);
            }
        }
        if (isdefined(nml_bhb)) {
            self notify(#"nml_bhb");
            for (j = 0; j < var_89fff8fd.size; j++) {
                self zm_utility::add_poi_to_ignore_list(var_89fff8fd[j]);
            }
        } else {
            wait 0.1;
            continue;
        }
        while (isdefined(nml_bhb)) {
            wait 0.1;
        }
        self thread function_b4f1a60d();
        wait 0.1;
    }
    return false;
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0x9733c27f, Offset: 0x44e0
// Size: 0xf0
function function_e5b5da3a(var_b6a0bac1) {
    self endon(#"death");
    if (!isdefined(var_b6a0bac1)) {
        return false;
    }
    var_d955a37f = getent("pack_enclosure", "targetname");
    if (self istouching(var_d955a37f) && isdefined(var_b6a0bac1) && var_b6a0bac1 istouching(var_d955a37f)) {
        return true;
    } else if (!self istouching(var_d955a37f) && isdefined(var_b6a0bac1) && !var_b6a0bac1 istouching(var_d955a37f)) {
        return true;
    }
    return false;
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0xe6e35dfc, Offset: 0x45d8
// Size: 0x1b6
function function_fef75520() {
    self endon(#"death");
    var_e5e0b495 = getentarray("zombieland_poi", "targetname");
    if (isdefined(self.var_c1934a9e) && self.var_c1934a9e) {
        return;
    }
    self.var_c1934a9e = 1;
    for (i = 0; i < var_e5e0b495.size; i++) {
        self zm_utility::add_poi_to_ignore_list(var_e5e0b495[i]);
    }
    while (!level flag::get("packapunch_hacked")) {
        var_f57952ce = getentarray("zm_bhb", "targetname");
        if (isdefined(var_f57952ce)) {
            for (w = 0; w < var_f57952ce.size; w++) {
                if (!function_e5b5da3a(var_f57952ce[w])) {
                    self zm_utility::add_poi_to_ignore_list(var_f57952ce[w]);
                }
            }
        }
        wait 0.1;
    }
    for (x = 0; x < var_e5e0b495.size; x++) {
        self zm_utility::remove_poi_from_ignore_list(var_e5e0b495[x]);
    }
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x4798
// Size: 0x4
function function_28fc6cb() {
    
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x47a8
// Size: 0x4
function function_1829268e() {
    
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x1efa7dce, Offset: 0x47b8
// Size: 0x754
function register_clientfields() {
    clientfield::register("scriptmover", "digger_moving", 21000, 1, "int");
    clientfield::register("scriptmover", "digger_digging", 21000, 1, "int");
    clientfield::register("scriptmover", "digger_arm_fx", 21000, 1, "int");
    clientfield::register("scriptmover", "dome_malfunction_pad", 21000, 1, "int");
    clientfield::register("toplayer", "player_sky_transition", 21000, 1, "int");
    clientfield::register("toplayer", "soul_swap", 21000, 1, "int");
    clientfield::register("toplayer", "gasp_rumble", 21000, 1, "int");
    clientfield::register("toplayer", "biodome_exploder", 21000, 1, "int");
    clientfield::register("toplayer", "snd_lowgravity", 21000, 1, "int");
    clientfield::register("actor", "low_gravity", 21000, 1, "int");
    clientfield::register("actor", "ctt", 21000, 1, "int");
    clientfield::register("actor", "sd", 21000, 1, "int");
    clientfield::register("world", "jump_pad_pulse", 21000, 3, "counter");
    clientfield::register("toplayer", "gas_mask_buy", 21000, 1, "counter");
    clientfield::register("toplayer", "gas_mask_on", 21000, 1, "counter");
    clientfield::register("world", "show_earth", 21000, 1, "counter");
    clientfield::register("world", "show_destroyed_earth", 21000, 1, "counter");
    clientfield::register("world", "hide_earth", 21000, 1, "counter");
    if (isdefined(level.var_6225e4bb) && level.var_6225e4bb > 0) {
        clientfield::register("actor", "astro_name_index", 21000, getminbitcountfornum(level.var_6225e4bb + 1), "int");
    }
    clientfield::register("clientuimodel", "player_lives", 1, 2, "int");
    clientfield::register("scriptmover", "zombie_has_eyes", 21000, 1, "int");
    clientfield::register("clientuimodel", "hudItems.showDpadDown_HackTool", 21000, 1, "int");
    for (i = 0; i < 4; i++) {
        clientfield::register("world", "player" + i + "wearableItem", 21000, 1, "int");
    }
    clientfield::register("world", "BIO", 21000, 1, "int");
    clientfield::register("world", "DH", 21000, 1, "int");
    clientfield::register("world", "TCA", 21000, 1, "int");
    clientfield::register("world", "HCA", 21000, 1, "int");
    clientfield::register("world", "BCA", 21000, 1, "int");
    clientfield::register("world", "Az1", 21000, 1, "counter");
    clientfield::register("world", "Az2a", 21000, 1, "counter");
    clientfield::register("world", "Az2b", 21000, 1, "counter");
    clientfield::register("world", "Az3a", 21000, 1, "counter");
    clientfield::register("world", "Az3b", 21000, 1, "counter");
    clientfield::register("world", "Az3c", 21000, 1, "counter");
    clientfield::register("world", "Az4a", 21000, 1, "counter");
    clientfield::register("world", "Az4b", 21000, 1, "counter");
    clientfield::register("world", "Az5", 21000, 1, "counter");
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0x40974846, Offset: 0x4f18
// Size: 0xcdc
function function_465aa1d3(restart) {
    if (!isdefined(restart)) {
        restart = 0;
    }
    println("<dev string:x3e>");
    level endon(#"end_round_think");
    if (!(isdefined(restart) && restart)) {
        if (isdefined(level.var_b31c6007)) {
            [[ level.var_b31c6007 ]]();
        }
        if (!(isdefined(level.host_ended_game) && level.host_ended_game)) {
            players = getplayers();
            foreach (player in players) {
                if (!(isdefined(player.hostmigrationcontrolsfrozen) && player.hostmigrationcontrolsfrozen)) {
                    player freezecontrols(0);
                    println("<dev string:x56>");
                }
                player zm_stats::set_global_stat("rounds", level.round_number);
            }
        }
    }
    setroundsplayed(level.round_number);
    for (;;) {
        var_40c45d40 = 50 * level.round_number;
        if (var_40c45d40 > 500) {
            var_40c45d40 = 500;
        }
        level.zombie_vars["rebuild_barrier_cap_per_round"] = var_40c45d40;
        level.pro_tips_start_time = gettime();
        level.zombie_last_run_time = gettime();
        if (level.var_7468f0f == 1) {
            level.var_7468f0f = 0;
            level thread zm::play_level_start_vox_delayed();
            wait 3;
        } else if (!(isdefined(level.var_d2b6176f) && level.var_d2b6176f)) {
            level.var_d2b6176f = 1;
        } else if (isdefined(level.var_5f225972) && level.var_5f225972) {
            if (level.round_number <= 5) {
                level thread zm_audio::sndmusicsystem_playstate("round_start");
            } else {
                level thread zm_audio::sndmusicsystem_playstate("round_start_short");
            }
        }
        zm::round_one_up();
        players = getplayers();
        array::thread_all(players, &zm_blockers::rebuild_barrier_reward_reset);
        if (!(isdefined(level.headshots_only) && level.headshots_only) && !(isdefined(restart) && restart)) {
            if (!level flag::get("teleporter_used") || level.first_round == 1) {
                level thread zm::award_grenades_for_survivors();
            }
        }
        println("<dev string:x6b>" + level.round_number + "<dev string:x85>" + players.size);
        level.round_start_time = gettime();
        while (level.zm_loc_types["zombie_location"].size <= 0) {
            wait 0.1;
        }
        /#
            zkeys = getarraykeys(level.zones);
            for (i = 0; i < zkeys.size; i++) {
                zonename = zkeys[i];
                level.zones[zonename].round_spawn_count = 0;
            }
        #/
        level thread [[ level.round_spawn_func ]]();
        level notify(#"start_of_round");
        recordzombieroundstart();
        bb::logroundevent("start_of_round");
        players = getplayers();
        for (index = 0; index < players.size; index++) {
            players[index] zm::recordroundstartstats();
        }
        if (isdefined(level.round_start_custom_func)) {
            [[ level.round_start_custom_func ]]();
        }
        if (level flag::get("teleporter_used")) {
            level flag::clear("teleporter_used");
            if (level.var_f128ba27 != 0) {
                level.zombie_total = level.var_f128ba27;
            }
        }
        [[ level.round_wait_func ]]();
        if (!(isdefined(level.var_49486970) && level.var_49486970) || level.var_5f225972 && level.first_round) {
            zm_powerups::powerup_round_start();
        }
        level.first_round = 0;
        level notify(#"end_of_round");
        level flag::set("between_rounds");
        bb::logroundevent("end_of_round");
        uploadstats();
        players = getplayers();
        if (!level flag::get("teleporter_used")) {
            if (isdefined(level.var_5f225972) && level.var_5f225972) {
                level thread zm_audio::sndmusicsystem_playstate("round_end");
            }
            if (isdefined(level.no_end_game_check) && level.no_end_game_check) {
                level thread zm::last_stand_revive();
                level thread zm::spectators_respawn();
            } else if (1 != players.size) {
                level thread zm::spectators_respawn();
            }
        }
        if (isdefined(level.round_end_custom_logic)) {
            [[ level.round_end_custom_logic ]]();
        }
        if (level flag::get("teleporter_used")) {
            if (level.var_f128ba27 != 0 && !level flag::get("enter_nml")) {
                zm::set_round_number(level.var_267b8fc0);
            }
        }
        players = getplayers();
        array::thread_all(players, &namespace_d93d7691::round_end);
        if (int(level.round_number / 5) * 5 == level.round_number) {
            level clientfield::set("round_complete_time", int((level.time - level.n_gameplay_start_time + 500) / 1000));
            level clientfield::set("round_complete_num", level.round_number);
        }
        if (level.gamedifficulty == 0) {
            level.zombie_move_speed = level.round_number * level.zombie_vars["zombie_move_speed_multiplier_easy"];
        } else {
            level.zombie_move_speed = level.round_number * level.zombie_vars["zombie_move_speed_multiplier"];
        }
        if (!level flag::get("teleporter_used")) {
            zm::set_round_number(1 + zm::get_round_number());
            setroundsplayed(zm::get_round_number());
        }
        level.round_number = zm::get_round_number();
        timer = level.zombie_vars["zombie_spawn_delay"];
        if (timer > 0.08) {
            level.zombie_vars["zombie_spawn_delay"] = timer * 0.95;
        } else if (timer < 0.08) {
            level.zombie_vars["zombie_spawn_delay"] = 0.08;
        }
        matchutctime = getutc();
        players = getplayers();
        foreach (player in players) {
            if (level.curr_gametype_affects_rank && zm::get_round_number() > 3 + level.start_round) {
                player zm_stats::add_client_stat("weighted_rounds_played", zm::get_round_number());
            }
            player zm_stats::set_global_stat("rounds", zm::get_round_number());
            player zm_stats::update_playing_utc_time(matchutctime);
            player zm_perks::function_78f42790("health_reboot", 1, 1);
            for (i = 0; i < 4; i++) {
                player.number_revives_per_round[i] = 0;
            }
            if (isalive(player) && player.sessionstate != "spectator" && !(isdefined(level.skip_alive_at_round_end_xp) && level.skip_alive_at_round_end_xp)) {
                player zm_stats::increment_challenge_stat("SURVIVALIST_SURVIVE_ROUNDS");
                score_number = zm::get_round_number() - 1;
                if (score_number < 1) {
                    score_number = 1;
                } else if (score_number > 20) {
                    score_number = 20;
                }
                scoreevents::processscoreevent("alive_at_round_end_" + score_number, player);
            }
        }
        if (isdefined(level.var_3dbc348c)) {
            [[ level.var_3dbc348c ]]();
        }
        level zm::round_over();
        level notify(#"between_round_over");
        level flag::clear("between_rounds");
        level.skip_alive_at_round_end_xp = 0;
        restart = 0;
    }
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x204072c1, Offset: 0x5c00
// Size: 0x4bc
function function_f382c360() {
    level flag::init("always_on");
    level flag::set("always_on");
    zm_zonemgr::add_adjacent_zone("airlock_bridge_zone", "bridge_zone", "receiving_exit");
    zm_zonemgr::add_adjacent_zone("airlock_bridge_zone", "water_zone", "receiving_exit");
    zm_zonemgr::add_adjacent_zone("bridge_zone", "water_zone", "receiving_exit");
    zm_zonemgr::add_adjacent_zone("airlock_west_zone", "water_zone", "catacombs_west");
    zm_zonemgr::add_adjacent_zone("airlock_west_zone", "cata_left_start_zone", "catacombs_west");
    zm_zonemgr::add_adjacent_zone("water_zone", "cata_left_start_zone", "catacombs_west");
    zm_zonemgr::add_adjacent_zone("cata_left_start_zone", "cata_left_middle_zone", "tunnel_6_door1");
    zm_zonemgr::add_adjacent_zone("airlock_east_zone", "water_zone", "catacombs_east");
    zm_zonemgr::add_adjacent_zone("airlock_east_zone", "cata_right_start_zone", "catacombs_east");
    zm_zonemgr::add_adjacent_zone("cata_right_start_zone", "water_zone", "catacombs_east");
    zm_zonemgr::add_adjacent_zone("airlock_east2_zone", "generator_zone", "catacombs_east4");
    zm_zonemgr::add_adjacent_zone("airlock_east2_zone", "cata_right_end_zone", "catacombs_east4");
    zm_zonemgr::add_adjacent_zone("airlock_west2_zone", "cata_left_middle_zone", "catacombs_west4");
    zm_zonemgr::add_adjacent_zone("airlock_west2_zone", "generator_zone", "catacombs_west4");
    zm_zonemgr::add_adjacent_zone("cata_right_start_zone", "cata_right_middle_zone", "tunnel_11_door1");
    zm_zonemgr::add_adjacent_zone("cata_right_middle_zone", "cata_right_end_zone", "tunnel_11_door2");
    zm_zonemgr::add_adjacent_zone("airlock_generator_zone", "generator_zone", "generator_exit_east");
    zm_zonemgr::add_adjacent_zone("airlock_generator_zone", "generator_exit_east_zone", "generator_exit_east");
    zm_zonemgr::add_adjacent_zone("airlock_digsite_zone", "enter_forest_east_zone", "exit_dig_east");
    zm_zonemgr::add_adjacent_zone("airlock_digsite_zone", "tower_zone_east", "exit_dig_east");
    zm_zonemgr::add_zone_flags("exit_dig_east", "digsite_group");
    zm_zonemgr::add_adjacent_zone("airlock_biodome_zone", "forest_zone", "forest_enter_digsite");
    zm_zonemgr::add_adjacent_zone("airlock_biodome_zone", "tower_zone_east2", "forest_enter_digsite");
    zm_zonemgr::add_adjacent_zone("forest_zone", "tower_zone_east2", "forest_enter_digsite");
    zm_zonemgr::add_zone_flags("forest_enter_digsite", "digsite_group");
    zm_zonemgr::add_adjacent_zone("tower_zone_east", "tower_zone_east2", "digsite_group");
    zm_zonemgr::add_adjacent_zone("airlock_labs_2_biodome", "enter_forest_east_zone", "enter_forest_east");
    zm_zonemgr::add_adjacent_zone("airlock_labs_2_biodome", "forest_zone", "enter_forest_east");
    zm_zonemgr::add_adjacent_zone("enter_forest_east_zone", "generator_exit_east_zone", "dig_enter_east");
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x63217cf4, Offset: 0x60c8
// Size: 0x24
function initcharacterstartindex() {
    level.characterstartindex = randomint(4);
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x3bb1fdfa, Offset: 0x60f8
// Size: 0x3e
function selectcharacterindextouse() {
    if (level.characterstartindex >= 4) {
        level.characterstartindex = 0;
    }
    self.characterindex = level.characterstartindex;
    level.characterstartindex++;
    return self.characterindex;
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0xb0e7e8f0, Offset: 0x6140
// Size: 0x2cc
function givecustomcharacters() {
    if (isdefined(level.var_dbfdd66c) && [[ level.var_dbfdd66c ]]("c_zom_farmgirl_viewhands")) {
        return;
    }
    self detachall();
    if (!isdefined(self.characterindex)) {
        self.characterindex = assign_lowest_unused_character_index();
    }
    self.favorite_wall_weapons_list = [];
    self.talks_in_danger = 0;
    /#
        if (getdvarstring("<dev string:x95>") != "<dev string:xa0>") {
            self.characterindex = getdvarint("<dev string:x95>");
        }
    #/
    self setcharacterbodytype(self.characterindex);
    self setcharacterbodystyle(0);
    self setcharacterhelmetstyle(0);
    switch (self.characterindex) {
    case 1:
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("870mcs");
        break;
    case 0:
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("frag_grenade");
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("bouncingbetty");
        break;
    case 3:
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("hk416");
        break;
    case 2:
        self.talks_in_danger = 1;
        level.rich_sq_player = self;
        level.var_b879b3b4 = self;
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("pistol_standard");
        break;
    }
    self setmovespeedscale(1);
    self function_ba25e637(4);
    self function_e67885f8(0);
    self thread set_exert_id();
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x8f771e27, Offset: 0x6418
// Size: 0x54
function set_exert_id() {
    self endon(#"disconnect");
    util::wait_network_frame();
    util::wait_network_frame();
    self zm_audio::setexertvoice(self.characterindex + 1);
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0xa49c4858, Offset: 0x6478
// Size: 0x19a
function assign_lowest_unused_character_index() {
    charindexarray = [];
    charindexarray[0] = 0;
    charindexarray[1] = 1;
    charindexarray[2] = 2;
    charindexarray[3] = 3;
    players = getplayers();
    if (players.size == 1) {
        return charindexarray[2];
    } else {
        if (!function_5c35365f(players)) {
            return charindexarray[2];
        }
        var_266da916 = 0;
        foreach (player in players) {
            if (isdefined(player.characterindex)) {
                arrayremovevalue(charindexarray, player.characterindex, 0);
                var_266da916++;
            }
        }
        if (charindexarray.size > 0) {
            return charindexarray[0];
        }
    }
    return 0;
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0xa7c062a0, Offset: 0x6620
// Size: 0xae
function function_5c35365f(players) {
    foreach (player in players) {
        if (isdefined(player.characterindex) && player.characterindex == 2) {
            return true;
        }
    }
    return false;
}

// Namespace zm_moon
// Params 2, eflags: 0x0
// Checksum 0xd26f9af5, Offset: 0x66d8
// Size: 0x76
function function_b1382b0c(entity_num, var_7dd87435) {
    if (var_7dd87435) {
        return "c_zom_moon_pressure_suit_helm";
    }
    switch (entity_num) {
    case 0:
        return "c_usa_dempsey_dlc5_head";
    case 1:
        return "c_rus_nikolai_dlc5_head_psuit";
    case 2:
        return "c_jap_takeo_dlc5_head";
    case 3:
        return "c_ger_richtofen_dlc5_head";
    }
}

// Namespace zm_moon
// Params 2, eflags: 0x0
// Checksum 0x58514150, Offset: 0x6758
// Size: 0x84
function function_daed1ad5(entity_num, var_7dd87435) {
    if (var_7dd87435) {
        self setcharacterhelmetstyle(1);
        self setcharacterbodystyle(2);
        return;
    }
    self setcharacterbodystyle(1);
    self setcharacterhelmetstyle(0);
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0x84d8f70, Offset: 0x67e8
// Size: 0x24
function function_7bbd1025(entity_num) {
    self setcharacterbodystyle(1);
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0x7309fe21, Offset: 0x6818
// Size: 0x2c
function function_7628a380(entity_num) {
    self clientfield::increment_to_player("gas_mask_buy");
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0x1831eff1, Offset: 0x6850
// Size: 0x24
function function_27d7eb16(entity_num) {
    self setcharacterbodystyle(0);
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0xd42e8af1, Offset: 0x6880
// Size: 0x74
function function_6c901e2e(entity_num) {
    function_daed1ad5(entity_num, 0);
    self setcharacterbodystyle(0);
    level clientfield::set("player" + self getentitynumber() + "wearableItem", 0);
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0xb2dfcfeb, Offset: 0x6900
// Size: 0x94
function on_player_spawned() {
    self notify(#"hash_2436f867");
    self endon(#"hash_2436f867");
    entnum = self getentitynumber();
    self util::waittill_any("disconnect", "bled_out", "death");
    level clientfield::set("player" + entnum + "wearableItem", 0);
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x11249cbe, Offset: 0x69a0
// Size: 0xbe
function function_fdfa7af5() {
    zm_utility::register_lethal_grenade_for_level("frag_grenade");
    level.zombie_lethal_grenade_player_init = getweapon("frag_grenade");
    zm_utility::register_tactical_grenade_for_level("black_hole_bomb");
    zm_utility::register_tactical_grenade_for_level("quantum_bomb");
    zm_utility::register_melee_weapon_for_level(level.weaponbasemelee.name);
    zm_utility::register_melee_weapon_for_level("bowie_knife");
    level.zombie_melee_weapon_player_init = level.weaponbasemelee;
    level.zombie_equipment_player_init = undefined;
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0xdd06462a, Offset: 0x6a68
// Size: 0x14c
function offhand_weapon_give_override(str_weapon) {
    self endon(#"death");
    if (zm_utility::is_tactical_grenade(str_weapon) && isdefined(self zm_utility::get_player_tactical_grenade()) && !self zm_utility::is_player_tactical_grenade(str_weapon)) {
        self setweaponammoclip(self zm_utility::get_player_tactical_grenade(), 0);
        self takeweapon(self zm_utility::get_player_tactical_grenade());
    }
    if (str_weapon == level.w_black_hole_bomb) {
        self zm_weap_black_hole_bomb::function_5ed4fd4e();
        self zm_weapons::play_weapon_vo(str_weapon);
        return true;
    }
    if (str_weapon == level.w_quantum_bomb) {
        self zm_weap_quantum_bomb::function_43dfe2f7();
        self zm_weapons::play_weapon_vo(str_weapon);
        return true;
    }
    return false;
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x586bb062, Offset: 0x6bc0
// Size: 0x40
function init_sounds() {
    level thread custom_add_vox();
    level thread function_30a8bcac();
    level.var_28d3a005 = 1;
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x49591872, Offset: 0x6c08
// Size: 0xb4
function electric_switch() {
    var_aa84840c = getent("use_elec_switch", "targetname");
    var_aa84840c sethintstring(%ZOMBIE_ELECTRIC_SWITCH);
    var_aa84840c setcursorhint("HINT_NOICON");
    level thread wait_for_power();
    var_aa84840c waittill(#"trigger", user);
    user thread function_6d46e376();
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x153384c9, Offset: 0x6cc8
// Size: 0x4c
function function_6d46e376() {
    self endon(#"death");
    self endon(#"disconnect");
    wait 4;
    if (isdefined(self)) {
        self thread zm_audio::create_and_play_dialog("general", "poweron");
    }
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0xdfbc57ee, Offset: 0x6d20
// Size: 0xec
function wait_for_power() {
    var_cf413835 = struct::get("power_switch", "targetname");
    level flag::wait_till("power_on");
    playsoundatposition("zmb_switch_flip", var_cf413835.origin);
    level notify(#"electric_door");
    level scene::play("power_switch", "targetname");
    playfx(level._effect["switch_sparks"], struct::get("elec_switch_fx", "targetname").origin);
}

/#

    // Namespace zm_moon
    // Params 1, eflags: 0x0
    // Checksum 0xa89cbcf9, Offset: 0x6e18
    // Size: 0x786
    function function_836f39e7(cmd) {
        var_98be8724 = strtok(cmd, "<dev string:xa1>");
        switch (var_98be8724[0]) {
        case "<dev string:xa3>":
            players = getplayers();
            for (i = 0; i < players.size; i++) {
                entnum = players[i].characterindex;
                if (isdefined(players[i].var_62030aa3)) {
                    entnum = players[i].var_62030aa3;
                }
                if (entnum == 2) {
                    players[i] namespace_6e97c459::function_f72f765e("<dev string:xb2>", "<dev string:xb5>");
                    level.var_538f4c7e = 1;
                }
            }
            break;
        case "<dev string:xbf>":
            players = getplayers();
            foreach (player in players) {
                if (player hasweapon(level.w_quantum_bomb)) {
                    player takeweapon(level.w_quantum_bomb);
                    player zm_utility::set_player_tactical_grenade("<dev string:xc8>");
                    player notify(#"hash_769d1dd2");
                }
            }
            array::thread_all(getplayers(), &zm_weap_black_hole_bomb::function_5ed4fd4e);
            break;
        case "<dev string:xcd>":
            players = getplayers();
            foreach (player in players) {
                if (player hasweapon(level.w_black_hole_bomb)) {
                    player takeweapon(level.w_black_hole_bomb);
                    player zm_utility::set_player_tactical_grenade("<dev string:xc8>");
                    player notify(#"hash_9b250665");
                }
            }
            array::thread_all(getplayers(), &zm_weap_quantum_bomb::function_43dfe2f7);
            break;
        case "<dev string:xda>":
            trigger = getent("<dev string:xe0>", "<dev string:xf0>");
            if (!isdefined(trigger)) {
                return;
            }
            iprintln("<dev string:xfb>");
            trigger notify(#"trigger", getplayers()[0]);
            break;
        case "<dev string:x10c>":
            players = getplayers();
            teleporter = getent("<dev string:x115>", "<dev string:xf0>");
            for (i = 0; i < players.size; i++) {
                players[i] setorigin(teleporter.origin);
            }
            break;
        case "<dev string:x12a>":
            zm_moon_digger::function_f257c559("<dev string:x138>");
            break;
        case "<dev string:x13f>":
            zm_moon_digger::function_f257c559("<dev string:x151>");
            break;
        case "<dev string:x15c>":
            zm_moon_digger::function_f257c559("<dev string:x16b>");
            break;
        case "<dev string:x173>":
            level.var_4b290403 = getdvarfloat("<dev string:x180>");
            iprintlnbold(level.var_4b290403);
            break;
        case "<dev string:x196>":
            player = getplayers()[0];
            spawnername = undefined;
            spawnername = "<dev string:x19c>";
            direction = player getplayerangles();
            direction_vec = anglestoforward(direction);
            eye = player geteye();
            scale = 8000;
            direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
            trace = bullettrace(eye, eye + direction_vec, 0, undefined);
            guy = undefined;
            spawners = getentarray(spawnername, "<dev string:x1ab>");
            spawner = spawners[0];
            if (isdefined(level.var_d5ac3d29)) {
                spawner = level.var_d5ac3d29[0];
            }
            guy = zombie_utility::spawn_zombie(spawner);
            if (isdefined(guy)) {
                guy.script_string = "<dev string:x1bd>";
                wait 0.5;
                guy forceteleport(trace["<dev string:x1c8>"], player.angles + (0, 180, 0));
            }
            break;
        }
    }

#/

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x33c6329e, Offset: 0x75a8
// Size: 0x24
function function_7837e42a() {
    zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_moon_weapons.csv", 1);
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x4ad4e333, Offset: 0x75d8
// Size: 0x1c
function custom_add_vox() {
    zm_audio::loadplayervoicecategories("gamedata/audio/zm/zm_moon_vox.csv");
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x6f28568b, Offset: 0x7600
// Size: 0x2de
function function_90b54b22() {
    self startragdoll();
    var_99ac24c8 = randomintrange(-50, 50);
    var_bfae9f31 = randomintrange(-50, 50);
    var_e5b1199a = randomintrange(25, 45);
    force_min = 75;
    force_max = 100;
    if (self.damagemod == "MOD_MELEE") {
        force_min = 40;
        force_max = 50;
        var_e5b1199a = 15;
    } else if (self.damageweapon == "m1911_zm") {
        force_min = 60;
        force_max = 75;
        var_e5b1199a = 20;
    } else if (self.damageweapon == "870mcs_zm" || self.damageweapon == "870mcs_upgraded_zm" || self.damageweapon == "ithaca_zm" || self.damageweapon == "ithaca_upgraded_zm" || self.damageweapon == "rottweil72_zm" || self.damageweapon == "rottweil72_upgraded_zm" || self.damageweapon == "srm1216_zm" || self.damageweapon == "srm1216_upgraded_zm" || self.damageweapon == "spas_zm" || self.damageweapon == "spas_upgraded_zm" || self.damageweapon == "hs10_zm" || self.damageweapon == "hs10_upgraded_zm" || self.damageweapon == "saiga12_zm" || self.damageweapon == "saiga12_upgraded_zm") {
        force_min = 100;
        force_max = -106;
    }
    scale = randomintrange(force_min, force_max);
    var_99ac24c8 = self.damagedir[0] * scale;
    var_bfae9f31 = self.damagedir[1] * scale;
    dir = (var_99ac24c8, var_bfae9f31, var_e5b1199a);
    self launchragdoll(dir);
    return false;
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x770b229b, Offset: 0x78e8
// Size: 0x44
function function_bd8a9ce6() {
    level flag::wait_till("start_zombie_round_logic");
    setdvar("phys_buoyancy", 1);
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0xcf777974, Offset: 0x7938
// Size: 0xa0
function cliff_fall_death() {
    trig = getent("cliff_fall_death", "targetname");
    if (isdefined(trig)) {
        while (true) {
            trig waittill(#"trigger", who);
            if (!(isdefined(who.var_dd92caae) && who.var_dd92caae)) {
                who thread function_8678e513();
            }
        }
    }
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x8ed1b35f, Offset: 0x79e0
// Size: 0x39c
function function_8678e513() {
    self endon(#"disconnect");
    if (isdefined(self.var_dd92caae) && self.var_dd92caae) {
        return;
    }
    if (function_467d0a9e(self)) {
        self.var_dd92caae = 1;
        var_c6255556 = 0;
        if (self laststand::player_is_in_laststand()) {
            var_c6255556 = 1;
        }
        if (level flag::get("solo_game")) {
            if (isdefined(self.lives) && self.lives > 0) {
                self.waiting_to_revive = 1;
                if (level flag::get("both_tunnels_breached")) {
                    point = function_1e86ce02(self);
                    if (!isdefined(point)) {
                        points = struct::get("bridge_zone", "script_noteworthy");
                        spawn_points = struct::get_array(points.target, "targetname");
                        num = self.characterindex;
                        point = spawn_points[num];
                    }
                } else {
                    points = struct::get("bridge_zone", "script_noteworthy");
                    spawn_points = struct::get_array(points.target, "targetname");
                    num = self.characterindex;
                    point = spawn_points[num];
                }
                self dodamage(self.health + 1000, (0, 0, 0));
                wait 1.5;
                self setorigin(point.origin + (0, 0, 20));
                self setplayerangles(point.angles);
                if (var_c6255556) {
                    level flag::set("instant_revive");
                    util::wait_network_frame();
                    level flag::clear("instant_revive");
                } else {
                    self thread zm_laststand::auto_revive(self);
                    self.waiting_to_revive = 0;
                    level.wait_and_revive = 0;
                    self.var_f9d593dd = 0;
                    self.lives = 0;
                }
            } else {
                self dodamage(self.health + 1000, (0, 0, 0));
            }
        } else {
            self dodamage(self.health + 1000, (0, 0, 0));
            util::wait_network_frame();
            self.bleedout_time = 0;
        }
        self.var_dd92caae = 0;
    }
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0xf980204e, Offset: 0x7d88
// Size: 0x76
function function_761c17e6(player) {
    if (level flag::get("both_tunnels_breached")) {
        point = function_1e86ce02(player);
        if (isdefined(point)) {
            self notify(#"hash_c36d2b1e");
            return point;
        }
    } else {
        return undefined;
    }
    return undefined;
}

// Namespace zm_moon
// Params 2, eflags: 0x0
// Checksum 0x22243e59, Offset: 0x7e08
// Size: 0xde
function function_467d0a9e(player, checkignoremeflag) {
    if (!isdefined(player)) {
        return false;
    }
    if (!isalive(player)) {
        return false;
    }
    if (!isplayer(player)) {
        return false;
    }
    if (player.sessionstate == "spectator") {
        return false;
    }
    if (player.sessionstate == "intermission") {
        return false;
    }
    if (player isnotarget()) {
        return false;
    }
    if (isdefined(checkignoremeflag) && player.ignoreme) {
        return false;
    }
    return true;
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0xf17beb95, Offset: 0x7ef0
// Size: 0x23e
function function_1e86ce02(revivee) {
    spawn_points = struct::get_array("player_respawn_point", "targetname");
    if (level.zones["airlock_west2_zone"].is_enabled) {
        for (i = 0; i < spawn_points.size; i++) {
            if (spawn_points[i].script_noteworthy == "airlock_west2_zone") {
                spawn_array = struct::get_array(spawn_points[i].target, "targetname");
                for (j = 0; j < spawn_array.size; j++) {
                    if (spawn_array[j].script_int == revivee.entity_num + 1) {
                        return spawn_array[j];
                    }
                }
                return spawn_array[0];
            }
        }
    } else if (level.zones["airlock_east2_zone"].is_enabled) {
        for (i = 0; i < spawn_points.size; i++) {
            if (spawn_points[i].script_noteworthy == "airlock_east2_zone") {
                spawn_array = struct::get_array(spawn_points[i].target, "targetname");
                for (j = 0; j < spawn_array.size; j++) {
                    if (spawn_array[j].script_int == revivee.entity_num + 1) {
                        return spawn_array[j];
                    }
                }
                return spawn_array[0];
            }
        }
    }
    return undefined;
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0xa086b1ac, Offset: 0x8138
// Size: 0x1a
function function_38a6761c() {
    level waittill(#"between_round_over");
    level.var_75eda423 = undefined;
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x800e7527, Offset: 0x8160
// Size: 0x410
function function_a5a65454() {
    var_3bc48314 = undefined;
    org = spawn("script_origin", (0, 0, 0));
    if (level flag::get("enter_nml")) {
        var_3bc48314 = struct::get_array("struct_black_hole_teleport_nml", "targetname");
    } else if (level flag::get("both_tunnels_blocked")) {
        var_3bc48314 = struct::get_array("struct_black_hole_teleport", "targetname");
        var_dcfe3a8 = 0;
        var_df7047d8 = var_3bc48314;
        var_22063b06 = [];
        all_players = getplayers();
        all_zones = getentarray("player_volume", "script_noteworthy");
        players_touching = 0;
        for (x = 0; x < all_zones.size; x++) {
            switch (all_zones[x].targetname) {
            case "airlock_bridge_zone":
            case "airlock_east_zone":
            case "airlock_west_zone":
            case "bridge_zone":
            case "cata_left_middle_zone":
            case "cata_left_start_zone":
            case "cata_right_start_zone":
            case "water_zone":
                var_22063b06[var_22063b06.size] = all_zones[x];
                for (i = 0; i < all_players.size; i++) {
                    player = all_players[i];
                    equipment = player zm_equipment::get_player_equipment();
                    if (isdefined(equipment) && equipment == "equip_hacker_zm") {
                        org delete();
                        return var_3bc48314;
                    }
                    if (player istouching(all_zones[x])) {
                        players_touching++;
                    }
                }
                break;
            default:
                break;
            }
        }
        if (players_touching == all_players.size) {
            var_dcfe3a8 = 1;
        }
        if (var_dcfe3a8) {
            for (i = 0; i < var_3bc48314.size; i++) {
                for (x = 0; x < var_22063b06.size; x++) {
                    org.origin = var_3bc48314[i].origin;
                    if (org istouching(var_22063b06[x])) {
                        arrayremovevalue(var_df7047d8, var_3bc48314[i]);
                    }
                }
            }
            var_3bc48314 = var_df7047d8;
        } else {
            var_3bc48314 = struct::get_array("struct_black_hole_teleport", "targetname");
        }
    } else {
        var_3bc48314 = struct::get_array("struct_black_hole_teleport", "targetname");
    }
    org delete();
    return var_3bc48314;
}

// Namespace zm_moon
// Params 2, eflags: 0x0
// Checksum 0x45e733c7, Offset: 0x8578
// Size: 0x276
function function_b43fe8f(var_3bc48314, ent_player) {
    player_zones = getentarray("player_volume", "script_noteworthy");
    var_80dd5c27 = undefined;
    var_fe76e4d4 = undefined;
    for (x = 0; x < var_3bc48314.size; x++) {
        if (!isdefined(var_fe76e4d4)) {
            var_fe76e4d4 = spawn("script_origin", var_3bc48314[x].origin + (0, 0, 40));
        } else {
            var_fe76e4d4.origin = var_3bc48314[x].origin + (0, 0, 40);
        }
        for (i = 0; i < player_zones.size; i++) {
            if (var_fe76e4d4 istouching(player_zones[i])) {
                if (isdefined(level.zones[player_zones[i].targetname].is_enabled) && isdefined(level.zones[player_zones[i].targetname]) && level.zones[player_zones[i].targetname].is_enabled) {
                    if (level flag::get("enter_nml")) {
                        var_80dd5c27 = var_3bc48314[x];
                        var_fe76e4d4 delete();
                        return var_80dd5c27;
                    }
                    if (ent_player zm_utility::get_current_zone() != player_zones[i].targetname) {
                        var_80dd5c27 = var_3bc48314[x];
                        var_fe76e4d4 delete();
                        return var_80dd5c27;
                    }
                }
            }
        }
    }
}

// Namespace zm_moon
// Params 3, eflags: 0x0
// Checksum 0xc6e6bf84, Offset: 0x87f8
// Size: 0x92
function function_371653e5(grenade, model, player) {
    var_56898f92 = getent("bhb_invalid_area", "targetname");
    if (model istouching(var_56898f92)) {
        level thread zm_weap_black_hole_bomb::function_18844f2c(player, model);
        return 1;
    }
    return 0;
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0xca119875, Offset: 0x8898
// Size: 0x2a
function function_65df3c5d(position) {
    if (isdefined(self._padded) && self._padded) {
        return true;
    }
    return false;
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0xe6d3bebc, Offset: 0x88d0
// Size: 0x24
function function_f38c9936(perk) {
    self zm_perks::function_3da729b7();
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x4c3ee082, Offset: 0x8900
// Size: 0x54
function function_d4687193() {
    astro = getent("astronaut_zombie_ai", "targetname");
    if (isdefined(astro)) {
        astro zm_utility::add_poi_to_ignore_list(self);
    }
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0xcf34e62a, Offset: 0x8960
// Size: 0x15e
function function_2df5f66c() {
    self endon(#"death");
    var_df33ecaa = getentarray("zombie_poi", "script_noteworthy");
    pack_enclosure = getent("pack_enclosure", "targetname");
    if (!isdefined(var_df33ecaa) || var_df33ecaa.size == 0) {
        return undefined;
    }
    for (i = 0; i < var_df33ecaa.size; i++) {
        if (isdefined(var_df33ecaa[i].targetname) && var_df33ecaa[i].targetname == "zm_bhb") {
            if (!level flag::get("packapunch_hacked")) {
                return undefined;
            }
            self.var_83cb27ea = 1;
            var_1bfaa4c3 = self function_8e51feb(var_df33ecaa[i]);
            return var_1bfaa4c3;
        }
    }
    self.var_83cb27ea = 0;
    return undefined;
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0x50001693, Offset: 0x8ac8
// Size: 0xc4
function function_8e51feb(ent_poi) {
    var_1bfaa4c3 = [];
    var_1bfaa4c3[0] = zm_utility::groundpos(ent_poi.origin + (0, 0, 100));
    var_1bfaa4c3[1] = self;
    if (isdefined(ent_poi.initial_attract_func)) {
        self thread [[ ent_poi.initial_attract_func ]](ent_poi);
    }
    if (isdefined(ent_poi.arrival_attract_func)) {
        self thread [[ ent_poi.arrival_attract_func ]](ent_poi);
    }
    return var_1bfaa4c3;
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0x30e8fcfe, Offset: 0x8b98
// Size: 0x48
function function_4003badd(quad) {
    if (isdefined(quad.var_98905394) && quad.var_98905394 == 1) {
        quad.can_explode = 0;
    }
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x8fa6f714, Offset: 0x8be8
// Size: 0x24
function function_357aa92a() {
    self zombie_utility::set_zombie_run_cycle("sprint");
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x23eb5ec4, Offset: 0x8c18
// Size: 0x6e4
function function_30a8bcac() {
    level.vox zm_audio::zmbvoxadd("general", "start", "start", 100, 0);
    level.vox zm_audio::zmbvoxadd("general", "door_deny", "nomoney", 100, 0);
    level.vox zm_audio::zmbvoxadd("general", "perk_deny", "nomoney", 100, 0);
    level.vox zm_audio::zmbvoxadd("general", "no_money_weapon", "nomoney", 100, 0);
    level.vox zm_audio::zmbvoxadd("general", "astro_spawn", "spawn_astro", 100, 0);
    level.vox zm_audio::zmbvoxadd("general", "biodome", "location_biodome", 100, 0);
    level.vox zm_audio::zmbvoxadd("general", "jumppad", "jumppad", 100, 0);
    level.vox zm_audio::zmbvoxadd("general", "teleporter", "teleporter", 100, 0);
    level.vox zm_audio::zmbvoxadd("general", "hack_plr", "hack_plr", 100, 0);
    level.vox zm_audio::zmbvoxadd("general", "hack_vox", "hack_vox", 100, 0);
    level.vox zm_audio::zmbvoxadd("general", "airless", "location_airless", 100, 0);
    level.vox zm_audio::zmbvoxadd("general", "moonjump", "moonjump", 100, 0);
    level.vox zm_audio::zmbvoxadd("eggs", "meteors", "egg_pedastool", 100, 0);
    level.vox zm_audio::zmbvoxadd("eggs", "music_activate", "secret", 100, 0);
    level.vox zm_audio::zmbvoxadd("weapon_pickup", "microwave", "wpck_microwave", 100, 0);
    level.vox zm_audio::zmbvoxadd("weapon_pickup", "quantum", "wpck_quantum", 100, 0);
    level.vox zm_audio::zmbvoxadd("weapon_pickup", "gasmask", "wpck_gasmask", 100, 0);
    level.vox zm_audio::zmbvoxadd("weapon_pickup", "hacker", "wpck_hacker", 100, 0);
    level.vox zm_audio::zmbvoxadd("weapon_pickup", "grenade", "wpck_launcher", 100, 0);
    level.vox zm_audio::zmbvoxadd("kill", "micro_dual", "kill_micro_dual", 100, 0, 120);
    level.vox zm_audio::zmbvoxadd("kill", "micro_single", "kill_micro_single", 100, 0);
    level.vox zm_audio::zmbvoxadd("kill", "quant_good", "kill_quant_good", 10, 0);
    level.vox zm_audio::zmbvoxadd("kill", "quant_bad", "kill_quant_bad", 10, 0);
    level.vox zm_audio::zmbvoxadd("kill", "astro", "kill_astro", 100, 0);
    level.vox zm_audio::zmbvoxadd("digger", "incoming", "digger_incoming", 100, 0);
    level.vox zm_audio::zmbvoxadd("digger", "breach", "digger_breach", 100, 0);
    level.vox zm_audio::zmbvoxadd("digger", "hacked", "digger_hacked", 100, 0);
    level.vox zm_audio::zmbvoxadd("perk", "specialty_additionalprimaryweapon", "perk_arsenal", 100, 0);
    level.vox zm_audio::zmbvoxadd("player", "powerup", "bonus_points_solo", "powerup_pts_solo", 100, 0);
    level.vox zm_audio::zmbvoxadd("player", "powerup", "bonus_points_team", "powerup_pts_team", 100, 0);
    level.vox zm_audio::zmbvoxadd("player", "powerup", "lose_points", "powerup_antipts_zmb", 100, 0);
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x4b358a9, Offset: 0x9308
// Size: 0x2e
function function_9f47ebff() {
    if (self.perk.script_noteworthy == "specialty_rof") {
        self.var_39787651 = 1;
    }
    return self;
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x1592845f, Offset: 0x9340
// Size: 0x34
function func_magicbox_update_prompt_use_override() {
    if (level flag::get("override_magicbox_trigger_use")) {
        return 1;
    }
    return 0;
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0xb978f307, Offset: 0x9380
// Size: 0x274
function setupmusic() {
    zm_audio::musicstate_create("round_start", 3, "round_start_moon_1", "round_start_moon_2", "round_start_moon_3", "round_start_moon_4");
    zm_audio::musicstate_create("round_start_short", 3, "round_start_moon_1", "round_start_moon_2", "round_start_moon_3", "round_start_moon_4");
    zm_audio::musicstate_create("round_start_first", 3, "round_start_moon_first");
    zm_audio::musicstate_create("round_end", 3, "round_end_moon_1", "round_end_moon_2", "round_end_moon_3");
    zm_audio::musicstate_create("game_over", 5, "game_over_zhd_moon");
    zm_audio::musicstate_create("nightmare", 4, "nightmare");
    zm_audio::musicstate_create("cominghome", 4, "cominghome");
    zm_audio::musicstate_create("8bit_cominghome", 4, "8bit_cominghome");
    zm_audio::musicstate_create("8bit_pareidolia", 4, "8bit_pareidolia");
    zm_audio::musicstate_create("8bit_redamned", 4, "8bit_redamned");
    zm_audio::musicstate_create("none", 4, "none");
    zm_audio::musicstate_create("sam", 4, "sam");
    zm_audio::musicstate_create("end_is_near", 4, "end_is_near");
    zm_audio::musicstate_create("samantha_reveal", 4, "samantha_reveal");
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x5270ce30, Offset: 0x9600
// Size: 0x154
function function_35a61719() {
    var_93997cd = getentarray("airlock_biodome_zone", "script_parameters");
    var_66cca975 = getentarray("airlock_labs_2_biodome", "script_parameters");
    var_93997cd = arraycombine(var_93997cd, var_66cca975, 0, 0);
    foreach (var_1cec30db in var_93997cd) {
        switch (var_1cec30db.script_int) {
        case 1:
            var_1cec30db thread function_cc87f235(self);
            break;
        case 0:
            var_1cec30db thread function_ff7d5f3b(self);
            break;
        }
    }
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0xa7c0157, Offset: 0x9760
// Size: 0x70
function function_cc87f235(player) {
    self endon(#"death");
    while (true) {
        self waittill(#"trigger", e_who);
        if (e_who == player) {
            player clientfield::set_to_player("biodome_exploder", 1);
        }
        wait 0.2;
    }
}

// Namespace zm_moon
// Params 1, eflags: 0x0
// Checksum 0xd720f8c2, Offset: 0x97d8
// Size: 0x70
function function_ff7d5f3b(player) {
    self endon(#"death");
    while (true) {
        self waittill(#"trigger", e_who);
        if (e_who == player) {
            player clientfield::set_to_player("biodome_exploder", 0);
        }
        wait 0.2;
    }
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x92f4e70, Offset: 0x9850
// Size: 0x34
function function_54bf648f() {
    level.use_multiple_spawns = 1;
    level.spawner_int = 1;
    level.fn_custom_zombie_spawner_selection = &function_54da140a;
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x737f7180, Offset: 0x9890
// Size: 0x24c
function function_54da140a() {
    var_6af221a2 = [];
    a_s_spots = level.zm_loc_types["zombie_location"];
    if (isdefined(level.zm_loc_types["quad_location"])) {
        a_s_spots = arraycombine(a_s_spots, level.zm_loc_types["quad_location"], 0, 0);
    }
    a_s_spots = array::randomize(a_s_spots);
    for (i = 0; i < a_s_spots.size; i++) {
        if (!isdefined(a_s_spots[i].script_int)) {
            var_343b1937 = 1;
        } else {
            var_343b1937 = a_s_spots[i].script_int;
        }
        a_sp_zombies = [];
        foreach (sp_zombie in level.zombie_spawners) {
            if (sp_zombie.script_int == var_343b1937) {
                if (!isdefined(a_sp_zombies)) {
                    a_sp_zombies = [];
                } else if (!isarray(a_sp_zombies)) {
                    a_sp_zombies = array(a_sp_zombies);
                }
                a_sp_zombies[a_sp_zombies.size] = sp_zombie;
            }
        }
        if (a_sp_zombies.size) {
            sp_zombie = array::random(a_sp_zombies);
            return sp_zombie;
        }
    }
    assert(isdefined(sp_zombie), "<dev string:x1d1>" + var_343b1937);
}

// Namespace zm_moon
// Params 0, eflags: 0x0
// Checksum 0x8fec4ba3, Offset: 0x9ae8
// Size: 0xea
function spare_change() {
    a_t_audio = getentarray("audio_bump_trigger", "targetname");
    foreach (t_audio_bump in a_t_audio) {
        if (t_audio_bump.script_sound === "zmb_perks_bump_bottle" && t_audio_bump.script_string != "speedcola_perk") {
            t_audio_bump thread zm_perks::check_for_change();
        }
    }
}

