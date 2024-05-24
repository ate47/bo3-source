#using scripts/zm/zm_island_util;
#using scripts/zm/zm_island_spider_ee_quest;
#using scripts/zm/zm_island_vo;
#using scripts/zm/zm_island_power;
#using scripts/zm/zm_island_craftables;
#using scripts/zm/_zm_weap_keeper_skull;
#using scripts/zm/_zm_hero_weapon;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_ai_spiders;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/vehicles/_raps;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_eaae7728;

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x9ff1f78d, Offset: 0x12e8
// Size: 0x224
function main() {
    level flag::init("ww_upgrade_spawned_from_plant");
    level flag::init("players_lost_ww");
    e_rock = getent("mdl_underwater_secretroom_rockwall", "targetname");
    e_rock clientfield::set("do_fade_material", 1);
    callback::on_spawned(&function_598781a4);
    foreach (player in level.players) {
        player thread function_598781a4();
    }
    struct::get("wonder_weapon_loc") thread function_11571878();
    struct::get("ww_up_pos") thread function_cc882a46();
    level thread function_c3efae8e();
    level thread function_6590511d();
    level thread function_7def4961();
    level flag::wait_till("ww_obtained");
    level thread function_e2b90d40();
    level thread function_b7685b2e();
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x6005d32d, Offset: 0x1518
// Size: 0x3fc
function init_quest() {
    register_clientfield();
    level flag::init("pool_filled");
    level flag::init("ww_obtained");
    level flag::init("ww1_found");
    level flag::init("ww2_found");
    level flag::init("ww3_venom_extractor_used");
    level flag::init("ww3_found");
    level flag::init("wwup1_found");
    level flag::init("wwup2_found");
    level flag::init("wwup3_found");
    level flag::init("wwup_wait");
    level flag::init("wwup_ready");
    level flag::init("wwup1_placed");
    level flag::init("wwup2_placed");
    level flag::init("wwup3_placed");
    level.var_622692a9 = 0;
    level.var_97c56c3c = getent("wonder_weapon_display", "targetname");
    level.var_97c56c3c hidepart("tag_liquid");
    level.var_7cb81d3c = getent("wonder_weapon_up_display", "targetname");
    level thread scene::add_scene_func("p7_fxanim_zm_island_cage_trap_tp_door_open_bundle", &function_c9d8bea4, "init");
    level thread scene::add_scene_func("p7_fxanim_zm_island_cage_trap_low_down_bundle", &function_fc6cea24, "play");
    level thread scene::add_scene_func("p7_fxanim_zm_island_cage_trap_low_up_bundle", &function_10877763, "play");
    level thread scene::add_scene_func("p7_fxanim_zm_island_cage_trap_hatch_open_bundle", &function_4ee53d8b, "init");
    level thread scene::init("p7_fxanim_zm_island_cage_trap_tp_door_open_bundle");
    level thread scene::init("p7_fxanim_zm_island_cage_trap_hatch_open_bundle");
    var_db6efb17 = getent("venom_extractor", "targetname");
    var_db6efb17 thread scene::init("p7_fxanim_zm_island_venom_extractor_bundle", var_db6efb17);
    var_db6efb17 setignorepauseworld(1);
    level thread function_961485f0();
    function_c5cd1083();
    /#
        function_982c97e5();
    #/
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x70d3fcaf, Offset: 0x1920
// Size: 0xf4
function register_clientfield() {
    clientfield::register("scriptmover", "play_underwater_plant_fx", 9000, 1, "int");
    clientfield::register("actor", "play_carrier_fx", 9000, 1, "int");
    clientfield::register("scriptmover", "play_vial_fx", 9000, 1, "int");
    clientfield::register("world", "add_ww_to_box", 9000, 4, "int");
    clientfield::register("scriptmover", "spider_bait", 9000, 1, "int");
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x7818f179, Offset: 0x1a20
// Size: 0x528
function function_11571878() {
    self.trigger = namespace_8aed53c9::function_d095318(self.origin, 50, 1, &function_5f3935a);
    var_85b2b1ab = getent("ww_station", "targetname");
    v_pos = var_85b2b1ab gettagorigin("mirg_cent_gun_tag_jnt");
    v_ang = var_85b2b1ab gettagangles("mirg_cent_gun_tag_jnt");
    var_85b2b1ab scene::init("p7_fxanim_zm_island_mirg_centrifuge_table_gun_up_bundle", var_85b2b1ab);
    var_218752f9 = getent("ww_station_funnel", "targetname");
    var_218752f9 hidepart("j_glow_green");
    var_218752f9 hidepart("j_glow_purple");
    var_218752f9 hidepart("j_glow_red");
    level.var_97c56c3c moveto(v_pos, 0.05);
    level.var_97c56c3c waittill(#"movedone");
    level.var_97c56c3c.angles = v_ang;
    level.var_97c56c3c linkto(var_85b2b1ab, "mirg_cent_gun_tag_jnt");
    while (true) {
        player = self.trigger waittill(#"trigger");
        if (zm_utility::is_player_valid(player)) {
            if (level flag::get("ww1_found") && !level flag::get("wwup1_placed")) {
                level flag::set("wwup1_placed");
                var_218752f9 showpart("j_glow_red");
                level.var_622692a9--;
            }
            if (level flag::get("ww2_found") && !level flag::get("wwup2_placed")) {
                level flag::set("wwup2_placed");
                var_218752f9 showpart("j_glow_green");
                level.var_622692a9--;
            }
            if (level flag::get("ww3_found") && !level flag::get("wwup3_placed")) {
                level flag::set("wwup3_placed");
                var_218752f9 showpart("j_glow_purple");
                level.var_622692a9--;
            }
            if (level flag::get("ww1_found") && level flag::get("ww2_found") && level flag::get("ww3_found")) {
                zm_unitrigger::unregister_unitrigger(self.trigger);
                self.trigger = undefined;
                level thread namespace_f333593c::function_3bf2d62a("kn4_ammo", 0, 1, 0);
                var_85b2b1ab scene::play("p7_fxanim_zm_island_mirg_centrifuge_table_gun_up_bundle", var_85b2b1ab);
                var_85b2b1ab scene::play("p7_fxanim_zm_island_mirg_centrifuge_table_turn_on_bundle", var_85b2b1ab);
                level.var_97c56c3c showpart("tag_liquid");
                var_85b2b1ab scene::play("p7_fxanim_zm_island_mirg_centrifuge_table_gun_down_bundle", var_85b2b1ab);
                self thread function_255b7efb();
                break;
            }
            if (zm_utility::is_player_valid(player)) {
                player notify(#"hash_f48612e4");
            }
        }
    }
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x4
// Checksum 0xd125d1e2, Offset: 0x1f50
// Size: 0x9c
function private function_5f3935a(e_player) {
    if (level flag::get("ww1_found") && level flag::get("ww2_found") && level flag::get("ww3_found")) {
        return %ZM_ISLAND_WONDERWEAPON_AMMO;
    }
    if (level.var_622692a9) {
        return %ZM_ISLAND_WONDERWEAPON_STATION;
    }
    return %ZOMBIE_BUILD_PIECE_MORE;
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x5bd0ff8f, Offset: 0x1ff8
// Size: 0x13c
function function_255b7efb() {
    self.trigger = namespace_8aed53c9::function_d095318(self.origin, 50, 1, &function_d23a4109);
    while (true) {
        player = self.trigger waittill(#"trigger");
        if (player zm_hero_weapon::function_f3451c9f()) {
            continue;
        }
        if (player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (player.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(player)) {
            continue;
        }
        if (player bgb::is_enabled("zm_bgb_disorderly_combat")) {
            continue;
        }
        zm_unitrigger::unregister_unitrigger(self.trigger);
        self.trigger = undefined;
        level thread function_9279976b(player);
        break;
    }
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x4
// Checksum 0xff991fdf, Offset: 0x2140
// Size: 0x64
function private function_d23a4109(e_player) {
    if (e_player bgb::is_enabled("zm_bgb_disorderly_combat")) {
        return "";
    }
    if (!e_player zm_hero_weapon::function_f3451c9f()) {
        return %ZM_ISLAND_WONDERWEAPON_PICKUP;
    }
    return "";
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0xc44496cc, Offset: 0x21b0
// Size: 0x138
function function_2578c564(str_flag) {
    self endon(#"death");
    while (true) {
        player = self.trigger waittill(#"trigger");
        if (zm_utility::is_player_valid(player)) {
            level.var_622692a9++;
            player notify(#"hash_f33f0d2a");
            zm_unitrigger::unregister_unitrigger(self.trigger);
            level flag::set(str_flag);
            if (str_flag == "ww3_found") {
                var_db6efb17 = getent("venom_extractor", "targetname");
                wait(0.5);
                var_db6efb17 thread function_3c6e89ad();
            }
            self.trigger = undefined;
            level thread function_ce9a171c(str_flag);
            self delete();
        }
    }
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x6a22cd5f, Offset: 0x22f0
// Size: 0x64
function function_3c6e89ad() {
    self scene::play("p7_fxanim_zm_island_venom_extractor_end_bundle", self);
    self setmodel("p7_fxanim_zm_island_venom_extractor_red_mod");
    self scene::init("p7_fxanim_zm_island_venom_extractor_red_bundle", self);
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0x7839add0, Offset: 0x2360
// Size: 0x1ac
function function_9279976b(player) {
    if (player function_f11b379d()) {
        w_currentweapon = player getcurrentweapon();
        player takeweapon(w_currentweapon);
    }
    level.var_97c56c3c unlink();
    level.var_97c56c3c hide();
    player giveweapon(level.var_5e75629a);
    player givemaxammo(level.var_5e75629a);
    player switchtoweapon(level.var_5e75629a);
    player notify(#"hash_f717c7f5");
    level clientfield::set("add_ww_to_box", 1);
    player.var_3599826c = 1;
    level.zombie_weapons[level.var_5e75629a].is_in_box = 1;
    level.customrandomweaponweights = &function_659c2324;
    level.var_2cb8e184 = 0;
    player thread function_9dd4723a();
    level flag::set("ww_obtained");
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x53fa1ca3, Offset: 0x2518
// Size: 0x72
function function_9dd4723a() {
    while (true) {
        self util::waittill_any("bled_out", "weapon_change", "disconnect");
        if (function_52193f1e() == 0) {
            level flag::set("players_lost_ww");
            return;
        }
    }
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0x17e00e36, Offset: 0x2598
// Size: 0x1f8
function function_659c2324(a_keys) {
    var_b45fbf8c = zm_pap_util::function_f925b7b9();
    if (level flag::get("players_lost_ww")) {
        level.var_2cb8e184++;
        switch (level.var_2cb8e184) {
        case 1:
            n_chance = 10;
            break;
        case 2:
            n_chance = 10;
            break;
        case 3:
            n_chance = 30;
            break;
        case 4:
            n_chance = 60;
            break;
        default:
            n_chance = 10;
            break;
        }
        if (randomint(100) <= n_chance && zm_magicbox::function_9821da97(self, level.var_5e75629a, var_b45fbf8c) && !self hasweapon(level.var_a4052592)) {
            arrayinsert(a_keys, level.var_5e75629a, 0);
            self thread function_97d5f905();
        } else {
            arrayremovevalue(a_keys, level.var_5e75629a);
        }
    } else if (self hasweapon(level.var_5e75629a) || self hasweapon(level.var_a4052592)) {
        arrayremovevalue(a_keys, level.var_5e75629a);
    }
    return a_keys;
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x5d7fcebc, Offset: 0x2798
// Size: 0x15c
function function_97d5f905() {
    self endon(#"disconnect");
    self endon(#"bled_out");
    var_1f4c3936 = undefined;
    foreach (e_chest in level.chests) {
        if (e_chest.chest_user === self) {
            var_1f4c3936 = e_chest;
            break;
        }
    }
    if (!isdefined(var_1f4c3936)) {
        return;
    }
    self util::waittill_any_ents(self, "user_grabbed_weapon", var_1f4c3936, "chest_accessed", self, "disconnect", self, "bled_out");
    if (function_52193f1e() == 1) {
        level flag::clear("players_lost_ww");
        level.var_2cb8e184 = 0;
        self thread function_9dd4723a();
    }
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0xd3d52a8a, Offset: 0x2900
// Size: 0xce
function function_52193f1e() {
    n_count = 0;
    foreach (player in level.players) {
        if (player hasweapon(level.var_5e75629a) || player hasweapon(level.var_a4052592)) {
            n_count++;
        }
    }
    return n_count;
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x85f38c19, Offset: 0x29d8
// Size: 0x9c
function function_f11b379d() {
    a_weapons = self getweaponslistprimaries();
    if (!self hasperk("specialty_additionalprimaryweapon") && a_weapons.size > 1) {
        return 1;
    }
    if (self hasperk("specialty_additionalprimaryweapon") && a_weapons.size > 2) {
        return 1;
    }
    return 0;
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x275b652b, Offset: 0x2a80
// Size: 0x17e
function function_6590511d() {
    level flag::wait_till("power_on");
    level waittill(#"start_of_round");
    wait(randomintrange(5, 8));
    while (true) {
        var_5103f616 = function_1c683357();
        if (isalive(var_5103f616)) {
            while (isalive(var_5103f616) && var_5103f616.completed_emerging_into_playable_area !== 1) {
                util::wait_network_frame();
            }
            if (isalive(var_5103f616) && zm_utility::check_point_in_playable_area(var_5103f616.origin)) {
                var_5103f616 clientfield::set("play_carrier_fx", 1);
                var_5103f616.var_5017aabf = 1;
                var_5103f616.no_powerups = 1;
                var_1a0512ba = var_5103f616 function_f5d430d7();
                if (var_1a0512ba) {
                    break;
                }
            }
        }
        wait(1);
    }
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x1156211a, Offset: 0x2c08
// Size: 0x2b2
function function_1c683357() {
    a_ai_zombies = getaiteamarray(level.zombie_team);
    var_2513c269 = [];
    foreach (ai_zombie in a_ai_zombies) {
        str_zone = ai_zombie zm_utility::get_current_zone();
        if (zm_zonemgr::any_player_in_zone("zone_meteor_site") || zm_zonemgr::any_player_in_zone("zone_meteor_site_2") || zm_zonemgr::any_player_in_zone("zone_swamp_lab_underneath") || zm_zonemgr::any_player_in_zone("zone_swamp_lab_underneath_2") || zm_zonemgr::any_player_in_zone("zone_swamp_lab")) {
            if (str_zone === "zone_meteor_site" || str_zone === "zone_meteor_site_2" || str_zone === "zone_swamp_lab_underneath" || str_zone === "zone_swamp_lab_underneath_2") {
                if (!isdefined(ai_zombie.completed_emerging_into_playable_area) && !(isdefined(ai_zombie.var_3940f450) && ai_zombie.var_3940f450) && !(isdefined(ai_zombie.var_61f7b3a0) && ai_zombie.var_61f7b3a0) && ai_zombie.archetype === "zombie") {
                    array::add(var_2513c269, ai_zombie);
                }
            }
        }
    }
    var_5103f616 = array::random(var_2513c269);
    if (isdefined(var_5103f616) && !namespace_8aed53c9::any_player_looking_at(var_5103f616 getcentroid(), 0.5, 1, var_5103f616)) {
        var_5103f616 setmodel("c_zom_dlc2_jpn_zombies3a");
        return var_5103f616;
    }
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x9055639e, Offset: 0x2ec8
// Size: 0x1a6
function function_f5d430d7() {
    str_notify = self util::waittill_any_return("enemy_cleaned_up", "death");
    if (str_notify == "enemy_cleaned_up") {
        return 0;
    }
    mdl_part = util::spawn_model("p7_cai_plant_sample_vial_01", self.origin + (0, 0, 16));
    mdl_part notsolid();
    mdl_part clientfield::set("play_vial_fx", 1);
    mdl_part playloopsound("zmb_vial_loop");
    mdl_part.trigger = namespace_8aed53c9::function_d095318(mdl_part.origin, 50, 1, &function_9bd3096f);
    mdl_part thread function_2578c564("ww1_found");
    mdl_part thread function_d7b19999();
    var_83e3a776 = level util::waittill_any_return("ww1_found", "ww1_timed_out");
    if (var_83e3a776 == "ww1_found") {
        return 1;
    }
    return 0;
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x59f837ad, Offset: 0x3078
// Size: 0x6c
function function_d7b19999() {
    self endon(#"death");
    wait(20);
    self function_2fe542aa();
    level notify(#"hash_53c9a941");
    zm_unitrigger::unregister_unitrigger(self.trigger);
    self delete();
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x9c81d89a, Offset: 0x30f0
// Size: 0xae
function function_2fe542aa() {
    self endon(#"death");
    for (i = 0; i < 40; i++) {
        if (i % 2) {
            self ghost();
        } else {
            self show();
        }
        if (i < 15) {
            wait(0.5);
            continue;
        }
        if (i < 25) {
            wait(0.25);
            continue;
        }
        wait(0.1);
    }
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x4
// Checksum 0x3e1af6d, Offset: 0x31a8
// Size: 0x3e
function private function_9bd3096f(player) {
    if (level flag::get("ww_obtained")) {
        return "";
    }
    return %ZOMBIE_BUILD_PIECE_GRAB;
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x73cc06d1, Offset: 0x31f0
// Size: 0xfc
function function_c3efae8e() {
    s_part = struct::get("ww_part_underwater", "script_noteworthy");
    mdl_part = util::spawn_model("p7_zm_isl_foliage_plant_underwater_01_red", s_part.origin);
    mdl_part clientfield::set("play_vial_fx", 1);
    mdl_part playloopsound("zmb_vial_loop");
    mdl_part.trigger = namespace_8aed53c9::function_d095318(mdl_part.origin, 50, 1, &function_9bd3096f);
    mdl_part thread function_2578c564("ww2_found");
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x8db34606, Offset: 0x32f8
// Size: 0x164
function function_7def4961() {
    level.var_1dbad94a = 0;
    level.var_90e478e7 = 0;
    level.var_67359403 = 0;
    level.var_48762d0c = 0;
    level thread scene::add_scene_func("p7_fxanim_zm_island_cage_trap_spid_tp_open_bundle", &function_2020490f, "init");
    level thread scene::init("p7_fxanim_zm_island_cage_trap_spid_tp_open_bundle");
    level thread scene::add_scene_func("p7_fxanim_zm_island_cage_trap_spid_hatch_open_bundle", &function_385c3ebb, "init");
    level thread scene::init("p7_fxanim_zm_island_cage_trap_spid_hatch_open_bundle");
    var_30c2448 = struct::get("vial_pos");
    var_f78dfee = struct::get("spider_cage_control");
    var_f78dfee thread function_9faff60c();
    while (!level.var_1dbad94a) {
        wait(0.1);
    }
    level thread function_ebbb27ae();
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0x8b1c5605, Offset: 0x3468
// Size: 0xf4
function function_2020490f(a_ents) {
    level.var_1a139831 = a_ents["fxanim_cage_trap_spid"];
    level.var_1a139831.var_272ec8a1 = 0;
    level.var_1a139831.mdl_clip = getent("clip_cage_jungle", "targetname");
    level.var_1a139831.mdl_clip linkto(level.var_1a139831);
    level.var_1a139831 setignorepauseworld(1);
    var_ccefca71 = getent("spider_bait", "targetname");
    var_ccefca71 linkto(level.var_1a139831);
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0x6eb19abb, Offset: 0x3568
// Size: 0x20
function function_385c3ebb(a_ents) {
    level.var_17e2756d = a_ents["cage_trap_spid_hatch"];
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0xfddbea2d, Offset: 0x3590
// Size: 0x550
function function_9faff60c() {
    self.trigger = namespace_8aed53c9::function_d095318(self.origin, 16, 1, &function_a50aa078);
    var_a78de5fc = getent("cage_entity", "targetname");
    var_c120c3f6 = getent("clip_jungle_door", "targetname");
    while (true) {
        self.trigger waittill(#"trigger");
        if (!level.var_1dbad94a && !level flag::get("power_on")) {
            continue;
        }
        if (level.var_1a139831.var_272ec8a1) {
            continue;
        }
        if (!level.var_90e478e7) {
            if (isdefined(level.var_1deeff56) && level.var_1deeff56) {
                level thread function_429e7f8a(1);
                str_scene = "p7_fxanim_zm_island_cage_trap_spid_low_down_bundle";
                n_height = -344;
                level.var_3ef945d6 = 1;
                if (isdefined(level.var_18ddef1f) && level.var_18ddef1f) {
                    level.var_f5ad590f = 1;
                }
            } else {
                str_scene = "p7_fxanim_zm_island_cage_trap_spid_down_bundle";
                n_height = -246;
            }
            b_state = 1;
            var_1cdfa0f4 = %ZM_ISLAND_CAGE_RAISE;
            level thread namespace_f333593c::function_3bf2d62a("lower_cage", 1, 0, 0);
            level thread function_baa845f4();
        } else {
            if (isdefined(level.var_1deeff56) && level.var_1deeff56) {
                level thread function_429e7f8a(0);
                str_scene = "p7_fxanim_zm_island_cage_trap_spid_low_up_bundle";
                n_height = 344;
                level.var_3ef945d6 = undefined;
            } else {
                str_scene = "p7_fxanim_zm_island_cage_trap_spid_up_bundle";
                n_height = -10;
            }
            b_state = 0;
            var_1cdfa0f4 = %ZM_ISLAND_CAGE_LOWER;
            level thread namespace_f333593c::function_3bf2d62a("raise_cage", 1, 0, 0);
        }
        level.var_48762d0c = 1;
        if (!b_state) {
            level.var_1a139831 stoploopsound(1);
            level.var_1a139831 clientfield::set("spider_bait", 0);
        }
        level.var_1a139831 scene::play(str_scene, level.var_1a139831);
        level.var_90e478e7 = b_state;
        level.var_48762d0c = 0;
        if (b_state) {
            if (!level flag::get("ww3_venom_extractor_used")) {
                level.var_1a139831 clientfield::set("spider_bait", 1);
            }
            level.var_1a139831.mdl_clip disconnectpaths();
            if (!(isdefined(level.var_1deeff56) && level.var_1deeff56)) {
                level.var_1a139831 scene::play("p7_fxanim_zm_island_cage_trap_spid_down_open_bundle", level.var_1a139831);
                var_c120c3f6 movez(-100, 0.05);
                var_c120c3f6 waittill(#"movedone");
                var_c120c3f6 solid();
                var_c120c3f6 disconnectpaths();
            }
        } else {
            level.var_1a139831.mdl_clip connectpaths();
            var_c120c3f6 movez(100, 0.05);
            var_c120c3f6 waittill(#"movedone");
            var_c120c3f6 connectpaths();
        }
        if (isdefined(level.var_1deeff56) && isdefined(level.var_90e478e7) && level.var_90e478e7 && level.var_1deeff56) {
            namespace_1aa6bd0c::function_69f5a9c5(var_1cdfa0f4);
        }
        if (isdefined(level.var_1deeff56) && !(isdefined(level.var_90e478e7) && level.var_90e478e7) && level.var_1deeff56) {
            namespace_1aa6bd0c::function_c9e92f7b();
        }
    }
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0x841cd70d, Offset: 0x3ae8
// Size: 0x74
function function_429e7f8a(b_state) {
    if (b_state) {
        wait(1.5);
    }
    level.var_17e2756d scene::play("p7_fxanim_zm_island_cage_trap_spid_hatch_open_bundle", level.var_17e2756d);
    wait(4);
    level.var_17e2756d scene::play("p7_fxanim_zm_island_cage_trap_spid_hatch_close_bundle", level.var_17e2756d);
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x4
// Checksum 0x5ca3bd2e, Offset: 0x3b68
// Size: 0xd4
function private function_a50aa078(player) {
    if (level.var_1a139831.var_272ec8a1) {
        return "";
    }
    if (isdefined(level.var_f5ad590f) && level.var_f5ad590f) {
        return "";
    }
    if (!level.var_1dbad94a && !level flag::get("power_on")) {
        return %ZOMBIE_NEED_POWER;
    }
    if (!level.var_90e478e7 && !level.var_48762d0c) {
        return %ZM_ISLAND_CAGE_LOWER;
    }
    if (level.var_90e478e7 && !level.var_48762d0c) {
        return %ZM_ISLAND_CAGE_RAISE;
    }
    return "";
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x299d043f, Offset: 0x3c48
// Size: 0x560
function function_ebbb27ae() {
    level endon(#"hash_d8d0f829");
    t_trap = getent("trigger_trap", "targetname");
    var_799520c1 = struct::get("trap_pos");
    while (true) {
        ai_zombie = t_trap waittill(#"trigger");
        if (!ai_zombie.var_3940f450) {
            continue;
        }
        if (level.var_67359403) {
            continue;
        }
        if (!level.var_90e478e7) {
            continue;
        }
        if (isdefined(level.var_3ef945d6) && level.var_3ef945d6) {
            continue;
        }
        if (!any_player_is_touching(getent("trigger_cage_proximity", "targetname"))) {
            continue;
        }
        if (level flag::get("ww3_venom_extractor_used") && !(isdefined(ai_zombie.var_f7522faa) && ai_zombie.var_f7522faa)) {
            continue;
        }
        if (isalive(ai_zombie)) {
            if (isdefined(ai_zombie.var_f7522faa) && ai_zombie.var_f7522faa) {
                t_trap thread namespace_1aa6bd0c::function_aa515242(ai_zombie);
            } else {
                ai_zombie thread function_cea70075();
            }
            ai_zombie.ignore_round_spawn_failsafe = 1;
            ai_zombie.var_41ff1b25 = 1;
            ai_zombie.allowdeath = 0;
            ai_zombie disableaimassist();
            ai_zombie.e_mover = util::spawn_model("tag_origin", ai_zombie.origin, ai_zombie.angles);
            ai_zombie.e_mover.targetname = "tag_align";
            ai_zombie linkto(ai_zombie.e_mover);
            ai_zombie.e_mover moveto(var_799520c1.origin, 1);
            ai_zombie.e_mover waittill(#"movedone");
            ai_zombie.e_mover linkto(level.var_1a139831);
            ai_zombie.e_mover thread scene::play("zm_dlc2_spider_trapped_in_cage_loop", ai_zombie);
            level.var_67359403 = 1;
            level.var_1a139831 scene::play("p7_fxanim_zm_island_cage_trap_spid_down_close_bundle", level.var_1a139831);
            var_c120c3f6 = getent("clip_jungle_door", "targetname");
            var_c120c3f6 notsolid();
            var_c120c3f6 connectpaths();
            while (level.var_90e478e7) {
                wait(0.1);
            }
            if (isalive(ai_zombie) && !(isdefined(ai_zombie.var_f7522faa) && ai_zombie.var_f7522faa)) {
                level.var_716fc13e = &function_cc8fe309;
                level.var_1a139831.var_272ec8a1 = 1;
                var_db6efb17 = getent("venom_extractor", "targetname");
                var_db6efb17 thread scene::play("p7_fxanim_zm_island_venom_extractor_bundle", var_db6efb17);
                level waittill(#"hash_e48828c5");
                ai_zombie.allowdeath = 1;
                ai_zombie dodamage(ai_zombie.health, ai_zombie.origin);
                var_ccefca71 = getent("spider_bait", "targetname");
                var_ccefca71 delete();
                level.var_1a139831 clientfield::set("spider_bait", 0);
                level.var_1a139831.var_272ec8a1 = 0;
                level flag::set("ww3_venom_extractor_used");
            }
        }
    }
}

// Namespace namespace_eaae7728
// Params 2, eflags: 0x0
// Checksum 0xb9e7e88, Offset: 0x41b0
// Size: 0x152
function function_cc8fe309(var_c79d3f71, var_18130313) {
    if (isdefined(var_c79d3f71.var_41ff1b25) && var_c79d3f71.var_41ff1b25) {
        level.var_f1e9e5aa = &namespace_1aa6bd0c::function_3321a018;
        e_linkto = util::spawn_model("tag_origin", level.var_1a139831.origin, level.var_1a139831.angles);
        e_linkto linkto(level.var_1a139831);
        e_powerup = zm_powerups::specific_powerup_drop("full_ammo", var_18130313 + (0, 0, -16));
        e_powerup linkto(e_linkto);
        level.var_f1e9e5aa = undefined;
    } else {
        e_powerup = zm_powerups::specific_powerup_drop("full_ammo", var_18130313 + (0, 0, -16));
    }
    level.var_716fc13e = undefined;
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0x56797a6d, Offset: 0x4310
// Size: 0x94
function function_23d17338(var_7afe5e99) {
    if (!isdefined(var_7afe5e99)) {
        var_7afe5e99 = 1;
    }
    var_a2176993 = getent("jungle_lab_ee_control_panel_elf", "targetname");
    if (var_7afe5e99) {
        var_a2176993 setmodel("p7_zm_isl_control_panel_cage");
        return;
    }
    var_a2176993 setmodel("p7_zm_isl_control_panel_cage_off");
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0xc75ef6d4, Offset: 0x43b0
// Size: 0xe0
function function_cea70075() {
    self util::waittill_notify_or_timeout("death", 90);
    if (isalive(self) && !level.var_1a139831.var_272ec8a1) {
        self util::stop_magic_bullet_shield();
        self dodamage(self.health, self.origin);
    }
    if (!level.var_90e478e7 && !level flag::get("ww3_found")) {
        level thread function_4a13e10b();
    }
    level.var_67359403 = 0;
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0xfe35170d, Offset: 0x4498
// Size: 0x114
function function_4a13e10b() {
    level flag::set("pool_filled");
    var_bbcd41a3 = struct::get("vial_pos").origin;
    mdl_part = util::spawn_model("tag_origin", var_bbcd41a3);
    mdl_part playloopsound("zmb_vial_loop");
    mdl_part.trigger = namespace_8aed53c9::function_d095318(mdl_part.origin, 50, 1, &function_9bd3096f);
    mdl_part thread function_2578c564("ww3_found");
    level thread namespace_f333593c::function_3bf2d62a("spider_venom", 1, 0, 0);
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0x788bea15, Offset: 0x45b8
// Size: 0xbc
function any_player_is_touching(ent) {
    foreach (player in level.players) {
        if (isalive(player) && player istouching(ent)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x4ffed459, Offset: 0x4680
// Size: 0xb4
function function_baa845f4() {
    n_radius = 24;
    n_height = 100;
    v_pos = (-1236, 368, -115);
    wait(0.5);
    var_66ee586a = spawn("trigger_radius", v_pos, 0, n_radius, n_height);
    var_66ee586a thread function_1228bd27();
    wait(0.5);
    var_66ee586a delete();
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x1359e518, Offset: 0x4740
// Size: 0x1a8
function function_1228bd27() {
    self endon(#"death");
    v_moveto = undefined;
    v_org = (-1135, 367, -115);
    e_linkto = getent("cage_linkto", "targetname");
    while (true) {
        foreach (player in level.activeplayers) {
            if (player istouching(self)) {
                while (!isdefined(v_moveto)) {
                    v_moveto = getclosestpointonnavmesh(v_org, 48);
                    wait(0.05);
                }
                player setorigin(v_moveto);
                player playrumbleonentity("damage_heavy");
                player dodamage(player.health, player.origin);
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x27ed3fd4, Offset: 0x48f0
// Size: 0x6c
function function_c5cd1083() {
    level.var_9fce15de = getent("trigger_inside_cage", "targetname");
    level.var_9fce15de setinvisibletoall();
    level.var_2ba557f2 = getent("clip_swamp_hatch", "targetname");
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x5152e65e, Offset: 0x4968
// Size: 0x4c0
function function_cc882a46() {
    var_85b2b1ab = getent("wwup_station", "targetname");
    var_85b2b1ab scene::init("p7_fxanim_zm_island_mirg_centrifuge_table_gun_up_bundle", var_85b2b1ab);
    var_218752f9 = getent("wwup_station_funnel", "targetname");
    var_218752f9 hidepart("j_glow_green");
    var_218752f9 hidepart("j_glow_purple");
    var_218752f9 hidepart("j_glow_red");
    level flag::wait_till("ww_obtained");
    self.trigger = namespace_8aed53c9::function_d095318(self.origin, 50, 1, &function_5521d6b5);
    while (true) {
        player = self.trigger waittill(#"trigger");
        if (level flag::get("wwup1_found")) {
            var_218752f9 showpart("j_glow_red");
        }
        if (level flag::get("wwup2_found")) {
            var_218752f9 showpart("j_glow_purple");
        }
        if (level flag::get("wwup3_found")) {
            var_218752f9 showpart("j_glow_green");
        }
        if (player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (player.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(player)) {
            continue;
        }
        if (!player hasweapon(level.var_5e75629a)) {
            continue;
        }
        if (player getcurrentweapon() != level.var_5e75629a) {
            continue;
        }
        if (player zm_hero_weapon::function_f3451c9f()) {
            continue;
        }
        if (level flag::get("wwup1_found") && level flag::get("wwup2_found") && level flag::get("wwup3_found")) {
            level flag::set("wwup_wait");
            player takeweapon(level.var_5e75629a);
            var_85b2b1ab attach(level.var_97c56c3c.model, "mirg_cent_gun_tag_jnt");
            var_85b2b1ab scene::play("p7_fxanim_zm_island_mirg_centrifuge_table_gun_up_bundle", var_85b2b1ab);
            var_85b2b1ab scene::play("p7_fxanim_zm_island_mirg_centrifuge_table_turn_on_bundle", var_85b2b1ab);
            var_85b2b1ab detach(level.var_97c56c3c.model, "mirg_cent_gun_tag_jnt");
            var_85b2b1ab attach(level.var_7cb81d3c.model, "mirg_cent_gun_tag_jnt");
            var_85b2b1ab scene::play("p7_fxanim_zm_island_mirg_centrifuge_table_gun_down_bundle", var_85b2b1ab);
            level flag::set("wwup_ready");
            self.trigger thread function_9f93c407(player);
            level flag::wait_till_clear("wwup_wait");
        }
    }
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x4
// Checksum 0xf2ea3058, Offset: 0x4e30
// Size: 0xe4
function private function_5521d6b5(player) {
    if (level flag::get("wwup_ready") && !player zm_hero_weapon::function_f3451c9f()) {
        return %ZM_ISLAND_WONDERWEAPON_UP_PICKUP;
    }
    if (level flag::get("wwup1_found") && level flag::get("wwup2_found") && level flag::get("wwup3_found") && player getcurrentweapon() == level.var_5e75629a) {
        return %ZM_ISLAND_WONDERWEAPON_AMMO;
    }
    return "";
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0x30d99c1d, Offset: 0x4f20
// Size: 0x250
function function_9f93c407(player) {
    player endon(#"hash_b874720a");
    while (true) {
        e_who = self waittill(#"trigger");
        if (e_who == player && !e_who zm_hero_weapon::function_f3451c9f()) {
            if (player zm_utility::in_revive_trigger()) {
                continue;
            }
            if (player.is_drinking > 0) {
                continue;
            }
            if (!zm_utility::is_player_valid(player)) {
                continue;
            }
            level flag::clear("wwup_wait");
            level flag::clear("wwup_ready");
            if (player hasweapon(level.var_5e75629a)) {
                player takeweapon(level.var_5e75629a);
            } else if (player function_f11b379d()) {
                w_currentweapon = player getcurrentweapon();
                player takeweapon(w_currentweapon);
            }
            player giveweapon(level.var_a4052592);
            player givemaxammo(level.var_a4052592);
            player switchtoweapon(level.var_a4052592);
            var_85b2b1ab = getent("wwup_station", "targetname");
            var_85b2b1ab detach(level.var_7cb81d3c.model, "mirg_cent_gun_tag_jnt");
            player notify(#"hash_b874720a");
        }
    }
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0xeba6ef59, Offset: 0x5178
// Size: 0x13a
function function_598781a4() {
    self endon(#"disconnect");
    level endon(#"hash_5d5bf177");
    level flag::wait_till("trilogy_released");
    var_537f25a1 = getent("ww_upgrade_cave_blocker", "targetname");
    self namespace_8aed53c9::function_7448e472(var_537f25a1);
    var_537f25a1 delete();
    e_rock = getent("mdl_underwater_secretroom_rockwall", "targetname");
    if (isdefined(e_rock)) {
        playsoundatposition("zmb_wpn_skullgun_discover", e_rock.origin);
        e_rock thread function_d5faaef8();
    }
    callback::remove_on_spawned(&function_598781a4);
    level notify(#"hash_5d5bf177");
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0xe3f8a8a2, Offset: 0x52c0
// Size: 0x74
function function_d5faaef8() {
    if (!(isdefined(self.var_7a022fa0) && self.var_7a022fa0)) {
        self.var_7a022fa0 = 1;
        self clientfield::set("do_fade_material", 0);
        exploder::exploder("fxexp_508");
        wait(1);
        self delete();
    }
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0xd3bfa599, Offset: 0x5340
// Size: 0x8c
function function_c9d8bea4(a_ents) {
    level.var_f353ae68 = a_ents["fxanim_cage_trap"];
    level.var_f353ae68.b_occupied = 0;
    level.var_f353ae68.is_moving = 0;
    level.var_f353ae68.var_e3ad0f90 = 0;
    level.var_f353ae68.var_243fddfd = 0;
    level.var_f353ae68 setignorepauseworld(1);
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0x276e1ae0, Offset: 0x53d8
// Size: 0x3c
function function_4ee53d8b(a_ents) {
    level.var_5be6626d = a_ents["cage_trap_hatch"];
    level.var_5be6626d setignorepauseworld(1);
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0xedacb5bd, Offset: 0x5420
// Size: 0xb4
function function_fc6cea24(a_ents) {
    level thread function_e3f30b83(1);
    level waittill(#"hash_7d174bae");
    function_6d23ca9e(0);
    level.var_5be6626d thread scene::play("p7_fxanim_zm_island_cage_trap_hatch_open_bundle", level.var_5be6626d);
    wait(3);
    level.var_5be6626d thread scene::play("p7_fxanim_zm_island_cage_trap_hatch_close_bundle", level.var_5be6626d);
    function_6d23ca9e(1);
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0x7e630a67, Offset: 0x54e0
// Size: 0x9c
function function_10877763(a_ents) {
    level waittill(#"hash_40a91595");
    function_6d23ca9e(0);
    level.var_5be6626d thread scene::play("p7_fxanim_zm_island_cage_trap_hatch_open_bundle", level.var_5be6626d);
    wait(3);
    level.var_5be6626d thread scene::play("p7_fxanim_zm_island_cage_trap_hatch_close_bundle", level.var_5be6626d);
    function_6d23ca9e(1);
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0x457a6203, Offset: 0x5588
// Size: 0xac
function function_6d23ca9e(var_46b6a64a) {
    if (var_46b6a64a) {
        n_dist = 100;
    } else {
        n_dist = -100;
    }
    level.var_2ba557f2 movez(n_dist, 0.05);
    level.var_2ba557f2 waittill(#"movedone");
    if (var_46b6a64a) {
        level.var_2ba557f2 connectpaths();
        return;
    }
    level.var_2ba557f2 disconnectpaths();
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0xca921888, Offset: 0x5640
// Size: 0x10c
function function_1dc42fdf(var_7afe5e99) {
    if (!isdefined(var_7afe5e99)) {
        var_7afe5e99 = 1;
    }
    var_a2176993 = getent("swamp_lab_ee_control_panel_elf", "targetname");
    if (var_7afe5e99) {
        var_a2176993 setmodel("p7_zm_isl_control_panel_cage");
        if (level.var_f353ae68.var_e3ad0f90) {
            level.var_e48a6587 sethintstring(%ZM_ISLAND_CAGE_RAISE);
        } else {
            level.var_e48a6587 sethintstring(%ZM_ISLAND_CAGE_LOWER);
        }
        return;
    }
    var_a2176993 setmodel("p7_zm_isl_control_panel_cage_off");
    level.var_e48a6587 sethintstring(%ZOMBIE_NEED_POWER);
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x8cd414a0, Offset: 0x5758
// Size: 0x410
function function_961485f0() {
    level.var_e48a6587 = getent("trigger_swamp_cage", "targetname");
    level.var_e48a6587 setcursorhint("HINT_NOICON");
    level.var_e48a6587 sethintstring(%ZOMBIE_NEED_POWER);
    level.var_e48a6587.is_charged = 0;
    level.var_2e16e689 = 0;
    var_964b337d = getent("clip_cage_control", "targetname");
    var_964b337d thread function_e2cd4141();
    level.var_326fd87 = getent("linkto_swamp_cage_door", "targetname");
    level.var_326fd87.is_open = 0;
    mdl_door = getent("swamp_lab_ee_gate_door", "targetname");
    mdl_door linkto(level.var_326fd87);
    level.var_ac769486 = getent("clip_swamp_cage_door", "targetname");
    var_9620cdae = getent("clip_cage_swamp", "targetname");
    var_ac769486 = getent("clip_cage_swamp_door", "targetname");
    while (!isdefined(level.var_f353ae68)) {
        wait(0.5);
    }
    var_9620cdae linkto(level.var_f353ae68);
    var_ac769486 linkto(level.var_f353ae68);
    level thread function_871dbb3a();
    while (!level.var_2e16e689) {
        wait(0.1);
    }
    level.var_e48a6587 sethintstring(%ZM_ISLAND_CAGE_LOWER);
    while (true) {
        while (level.var_f353ae68.is_moving) {
            util::wait_network_frame();
        }
        player = level.var_e48a6587 waittill(#"trigger");
        level notify(#"hash_9d1c8527");
        if (level.var_f353ae68.is_moving) {
            continue;
        }
        if (!level.var_2e16e689 && !level flag::get("power_on")) {
            continue;
        }
        while (isdefined(var_964b337d.var_3c8bdb5a) && var_964b337d.var_3c8bdb5a) {
            wait(0.05);
        }
        if (!level.var_f353ae68.var_e3ad0f90) {
            function_3cd05ecf("down");
            level thread function_1d3366a8();
            level thread namespace_f333593c::function_3bf2d62a("lower_cage", 0, 0, 1);
            continue;
        }
        function_3cd05ecf("up");
        level thread namespace_f333593c::function_3bf2d62a("raise_cage", 0, 0, 1);
    }
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x4fd136b4, Offset: 0x5b70
// Size: 0x54
function function_1d3366a8() {
    level endon(#"hash_9d1c8527");
    wait(60);
    if (level.var_f353ae68.var_e3ad0f90 && !level.var_f353ae68.is_moving) {
        function_3cd05ecf("up");
    }
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x3bf1c5ae, Offset: 0x5bd0
// Size: 0x1fc
function function_871dbb3a() {
    level flag::wait_till("power_on");
    level.var_9fce15de setvisibletoall();
    while (true) {
        player = level.var_9fce15de waittill(#"trigger");
        if (level.var_f353ae68.is_moving) {
            continue;
        }
        if (!level.var_f353ae68.b_occupied) {
            level.var_f353ae68.b_occupied = 1;
            level.var_9fce15de setinvisibletoall();
            if (level flag::get("solo_game")) {
                function_d452a2ca(player);
                wait(1);
                function_3cd05ecf("down");
                level thread namespace_f333593c::function_3bf2d62a("lower_cage", 0, 0, 1);
                wait(5);
                function_3cd05ecf("up");
                level thread namespace_f333593c::function_3bf2d62a("raise_cage", 0, 0, 1);
                player unlink();
            }
            while (player istouching(level.var_9fce15de)) {
                wait(0.1);
            }
            level.var_9fce15de setvisibletoall();
            level.var_f353ae68.b_occupied = 0;
        }
    }
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0x2a82efd6, Offset: 0x5dd8
// Size: 0x9c
function function_d452a2ca(player) {
    e_linkto = getent("cage_linkto", "targetname");
    e_linkto linkto(level.var_f353ae68);
    player setorigin(e_linkto.origin);
    util::wait_network_frame();
    player playerlinkto(e_linkto);
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0xec17ae4e, Offset: 0x5e80
// Size: 0x88
function function_e2cd4141() {
    self waittill(#"charged");
    level.var_e48a6587.is_charged = 1;
    if (!level.var_f353ae68.var_e3ad0f90 && !level.var_326fd87.is_open) {
        self.var_3c8bdb5a = 1;
        level.var_326fd87 function_953bec10("open");
        self.var_3c8bdb5a = 0;
    }
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0xe6294a61, Offset: 0x5f10
// Size: 0x194
function function_953bec10(str_state) {
    var_ac769486 = getent("clip_cage_swamp_door", "targetname");
    if (str_state == "close") {
        n_rotate = -45;
        level.var_ac769486 solid();
        var_ac769486 solid();
    } else {
        n_rotate = 45;
    }
    self rotateyaw(n_rotate, 2);
    self playsound("evt_spider_gate_move");
    self waittill(#"rotatedone");
    if (str_state == "close") {
        self.is_open = 0;
        level.var_f353ae68 scene::play("p7_fxanim_zm_island_cage_trap_tp_door_close_bundle", level.var_f353ae68);
        return;
    }
    self.is_open = 1;
    level.var_ac769486 notsolid();
    var_ac769486 notsolid();
    level.var_f353ae68 scene::play("p7_fxanim_zm_island_cage_trap_tp_door_open_bundle", level.var_f353ae68);
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0xfc7f169d, Offset: 0x60b0
// Size: 0x4da
function function_3cd05ecf(str_direction) {
    level thread function_46d3d1b0(1);
    level.var_f353ae68.is_moving = 1;
    if (!level flag::get("solo_game")) {
        for (i = 0; i < level.players.size; i++) {
            if (level.players[i] istouching(level.var_9fce15de)) {
                level.players[i].var_90f735f8 = 1;
                function_d452a2ca(level.players[i]);
                wait(0.25);
                break;
            }
        }
    }
    level.var_e48a6587 sethintstring("");
    if (str_direction == "down") {
        level.var_f353ae68.var_e3ad0f90 = 1;
        if (level.var_326fd87.is_open) {
            level.var_326fd87 function_953bec10("close");
        }
        if (level.var_e48a6587.is_charged) {
            level.var_f353ae68 scene::play("p7_fxanim_zm_island_cage_trap_low_down_bundle", level.var_f353ae68);
            level.var_f353ae68.var_243fddfd = 1;
        } else {
            function_6d23ca9e(0);
            level thread function_e3f30b83(0);
            level.var_f353ae68 scene::play("p7_fxanim_zm_island_cage_trap_mid_down_bundle", level.var_f353ae68);
        }
        wait(0.5);
        level.var_e48a6587 sethintstring(%ZM_ISLAND_CAGE_RAISE);
    } else {
        var_66ee586a = spawn("trigger_radius", (2591, 765, -475), 0, 20, 40);
        var_66ee586a thread function_6a47d3d7();
        level.var_f353ae68.var_e3ad0f90 = 0;
        if (level.var_e48a6587.is_charged && level.var_f353ae68.var_243fddfd) {
            level.var_f353ae68 scene::play("p7_fxanim_zm_island_cage_trap_low_up_bundle", level.var_f353ae68);
            level.var_f353ae68.var_243fddfd = 0;
        } else {
            function_6d23ca9e(1);
            level.var_f353ae68 scene::play("p7_fxanim_zm_island_cage_trap_mid_up_bundle", level.var_f353ae68);
        }
        if (!level.var_326fd87.is_open && level.var_e48a6587.is_charged) {
            level.var_326fd87 function_953bec10("open");
        }
        wait(0.5);
        level.var_e48a6587 sethintstring(%ZM_ISLAND_CAGE_LOWER);
        var_66ee586a delete();
    }
    level.var_f353ae68.is_moving = 0;
    if (!level.var_f353ae68.var_e3ad0f90) {
        level thread function_46d3d1b0(0);
        foreach (player in level.players) {
            if (isdefined(player.var_90f735f8) && player.var_90f735f8) {
                player.var_90f735f8 = 0;
                player unlink();
            }
        }
    }
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0x493d0179, Offset: 0x6598
// Size: 0x15a
function function_46d3d1b0(var_9330a364) {
    if (var_9330a364) {
        foreach (player in level.players) {
            if (player istouching(level.var_9fce15de)) {
                player.var_b0329be9 = 1;
            }
        }
        return;
    }
    foreach (player in level.players) {
        if (isdefined(player.var_b0329be9) && player.var_b0329be9) {
            player.var_b0329be9 = 0;
        }
    }
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0xba0801e5, Offset: 0x6700
// Size: 0xcc
function function_e3f30b83(b_charged) {
    n_radius = 25;
    n_height = 100;
    v_pos = (2591, 765, -687);
    if (b_charged) {
        wait(2);
    } else {
        wait(1.5);
    }
    var_66ee586a = spawn("trigger_radius", v_pos, 0, n_radius, n_height);
    var_66ee586a thread function_6a47d3d7();
    wait(0.5);
    var_66ee586a delete();
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0xb11f6cd3, Offset: 0x67d8
// Size: 0x1f8
function function_6a47d3d7() {
    self endon(#"death");
    v_moveto = undefined;
    v_org = (2671, 851, -687);
    e_linkto = getent("cage_linkto", "targetname");
    while (true) {
        foreach (player in level.activeplayers) {
            if (player istouching(self) && !player islinkedto(e_linkto)) {
                while (!isdefined(v_moveto)) {
                    v_moveto = getclosestpointonnavmesh(v_org, 48);
                    wait(0.05);
                }
                if (isdefined(player)) {
                    player setorigin(v_moveto);
                    player playrumbleonentity("damage_heavy");
                    player dodamage(player.health, player.origin);
                    player playlocalsound(level.zmb_laugh_alias);
                }
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x63c6619d, Offset: 0x69d8
// Size: 0x6c
function function_bc717528() {
    self.var_1da52e7e = namespace_8aed53c9::function_d095318(self gettagorigin("Tag_tooth_RI"), 50, 1, &function_2f27cb1);
    self thread function_72c5554a("wwup2_found");
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0x88bbde9b, Offset: 0x6a50
// Size: 0xd4
function function_72c5554a(str_flag) {
    while (true) {
        player = self.var_1da52e7e waittill(#"trigger");
        if (zm_utility::is_player_valid(player)) {
            player notify(#"hash_f33f0d2a");
            zm_unitrigger::unregister_unitrigger(self);
            level flag::set(str_flag);
            self.var_1da52e7e = undefined;
            self hidepart("Tag_tooth_RI");
            level thread function_ce9a171c(str_flag);
            break;
        }
    }
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x4
// Checksum 0x554a3654, Offset: 0x6b30
// Size: 0x12
function private function_2f27cb1(player) {
    return "";
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0xe0c304bd, Offset: 0x6b50
// Size: 0xe4
function function_b7685b2e() {
    var_f96ad154 = struct::get("ee_planting_spot", "script_noteworthy");
    var_4b9ce062 = util::spawn_model("tag_origin", var_f96ad154.origin);
    level flag::wait_till("ww_upgrade_spawned_from_plant");
    util::wait_network_frame();
    var_4b9ce062.trigger = namespace_8aed53c9::function_d095318(var_4b9ce062.origin, 50, 1, &function_9bd3096f);
    var_4b9ce062 thread function_2578c564("wwup3_found");
}

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0xd10dcca1, Offset: 0x6c40
// Size: 0xc4
function function_e2b90d40() {
    var_2c2cf2e6 = struct::get("wweapon_up_part_wwup1");
    var_babd6f9c = util::spawn_model("p7_zm_bgb_vial", var_2c2cf2e6.origin, var_2c2cf2e6.angles);
    var_babd6f9c.trigger = namespace_8aed53c9::function_d095318(var_babd6f9c.origin, 100, 1, &function_9bd3096f);
    var_babd6f9c thread function_2578c564("wwup1_found");
}

// Namespace namespace_eaae7728
// Params 1, eflags: 0x0
// Checksum 0x8dba6d1f, Offset: 0x6d10
// Size: 0x2b6
function function_ce9a171c(str_flag) {
    a_players = [];
    if (self == level) {
        a_players = level.players;
    } else if (isplayer(self)) {
        a_players = array(self);
    } else {
        return;
    }
    switch (str_flag) {
    case 9:
        foreach (player in a_players) {
            player clientfield::set_to_player("wonderweapon_part_wwi", 1);
            player thread namespace_f37770c8::function_97be99b3("zmInventory.wonderweapon_part_wwi", "zmInventory.widget_wonderweapon_parts", 0);
        }
        break;
    case 10:
        foreach (player in a_players) {
            player clientfield::set_to_player("wonderweapon_part_wwii", 1);
            player thread namespace_f37770c8::function_97be99b3("zmInventory.wonderweapon_part_wwii", "zmInventory.widget_wonderweapon_parts", 0);
        }
        break;
    case 12:
        foreach (player in a_players) {
            player clientfield::set_to_player("wonderweapon_part_wwiii", 1);
            player thread namespace_f37770c8::function_97be99b3("zmInventory.wonderweapon_part_wwiii", "zmInventory.widget_wonderweapon_parts", 0);
        }
        break;
    }
}

/#

    // Namespace namespace_eaae7728
    // Params 0, eflags: 0x0
    // Checksum 0x796117bd, Offset: 0x6fd0
    // Size: 0x104
    function function_982c97e5() {
        zm_devgui::add_custom_devgui_callback(&function_efbc0e1);
        adddebugcommand("spider_bait");
        adddebugcommand("clip_cage_swamp_door");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
    }

    // Namespace namespace_eaae7728
    // Params 1, eflags: 0x0
    // Checksum 0x9e79c1ce, Offset: 0x70e0
    // Size: 0x42e
    function function_efbc0e1(cmd) {
        switch (cmd) {
        case 0:
            level flag::set("<unknown string>");
            level.var_622692a9++;
            level thread function_ce9a171c("<unknown string>");
            return 1;
        case 0:
            level flag::set("<unknown string>");
            level.var_622692a9++;
            level thread function_ce9a171c("<unknown string>");
            return 1;
        case 0:
            level flag::set("<unknown string>");
            level.var_622692a9++;
            level thread function_ce9a171c("<unknown string>");
            return 1;
        case 0:
            level flag::set("<unknown string>");
            level flag::set("<unknown string>");
            level flag::set("<unknown string>");
            level.var_622692a9 = 3;
            level thread function_ce9a171c("<unknown string>");
            level thread function_ce9a171c("<unknown string>");
            level thread function_ce9a171c("<unknown string>");
            return 1;
        case 0:
            level flag::set("<unknown string>");
            level flag::set("<unknown string>");
            return 1;
        case 0:
            level flag::set("<unknown string>");
            level flag::set("<unknown string>");
            return 1;
        case 0:
            level flag::set("<unknown string>");
            level flag::set("<unknown string>");
            return 1;
        case 0:
            level flag::set("<unknown string>");
            level flag::set("<unknown string>");
            level flag::set("<unknown string>");
            level flag::set("<unknown string>");
            return 1;
        default:
            level flag::set("<unknown string>");
            level flag::set("<unknown string>");
            level flag::set("<unknown string>");
            level thread function_ce9a171c("<unknown string>");
            level thread function_ce9a171c("<unknown string>");
            level thread function_ce9a171c("<unknown string>");
            level thread function_9279976b(level.players[0]);
            return 1;
        }
        return 0;
    }

#/
