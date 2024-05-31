#using scripts/zm/zm_tomb_vo;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_ee_lights;
#using scripts/zm/zm_tomb_amb;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_audio_zhd;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_8d777412;

// Namespace namespace_8d777412
// Params 0, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_c35e6aab
// Checksum 0x3f7a2b86, Offset: 0x868
// Size: 0x19c
function init() {
    clientfield::register("world", "wagon_1_fire", 21000, 1, "int");
    clientfield::register("world", "wagon_2_fire", 21000, 1, "int");
    clientfield::register("world", "wagon_3_fire", 21000, 1, "int");
    clientfield::register("actor", "ee_zombie_tablet_fx", 21000, 1, "int");
    clientfield::register("toplayer", "ee_beacon_reward", 21000, 1, "int");
    callback::on_connect(&on_player_connect);
    function_7154a7d2();
    level thread function_e90e9a0();
    level thread function_84fbb8c2();
    level thread function_a1a0a601();
    level thread namespace_66d26454::main();
    level thread function_8bb9def9();
}

// Namespace namespace_8d777412
// Params 0, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_fb4f96b5
// Checksum 0x14736736, Offset: 0xa10
// Size: 0x34
function on_player_connect() {
    self thread function_e5597de0();
    self thread function_1655fa4d();
}

// Namespace namespace_8d777412
// Params 0, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_a1a0a601
// Checksum 0x60351e0c, Offset: 0xa50
// Size: 0x2a4
function function_a1a0a601() {
    level flag::init("ee_medallions_collected");
    level thread function_420e2949();
    level.var_65b9544f = 4;
    level flag::wait_till("ee_medallions_collected");
    level thread namespace_54a425fe::function_5f9c184e("side_sting_4");
    var_94325f0b = struct::get("mgspawn", "targetname");
    v_spawnpt = var_94325f0b.origin;
    var_f8c6b1d7 = var_94325f0b.angles;
    player = getplayers()[0];
    var_67f03e82 = getweapon("lmg_mg08_upgraded");
    options = player zm_weapons::get_pack_a_punch_weapon_options(var_67f03e82);
    var_c91432f = zm_utility::spawn_weapon_model(var_67f03e82, undefined, v_spawnpt, var_f8c6b1d7, options);
    playfxontag(level._effect["special_glow"], var_c91432f, "tag_origin");
    var_459b3a28 = namespace_d7c0ce12::function_52854313(v_spawnpt, 100, 1);
    var_459b3a28.require_look_at = 1;
    var_459b3a28.cursor_hint = "HINT_WEAPON";
    var_459b3a28.cursor_hint_weapon = var_67f03e82;
    for (var_3a5ee738 = 0; !var_3a5ee738; var_3a5ee738 = function_e5c03b87(e_player)) {
        e_player = var_459b3a28 waittill(#"trigger");
    }
    var_459b3a28 namespace_d7c0ce12::function_bd611266();
    var_c91432f delete();
}

// Namespace namespace_8d777412
// Params 0, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_420e2949
// Checksum 0xd049722e, Offset: 0xd00
// Size: 0xd0
function function_420e2949() {
    var_cb545630 = 0;
    while (var_cb545630 < 4) {
        var_a94bd457 = level waittill(#"hash_409f85a3");
        var_a94bd457 playsound("zmb_medallion_pickup");
        if (isdefined(var_a94bd457)) {
            namespace_ad52727b::function_7dc74a72("vox_maxi_drone_pickups_" + var_cb545630, var_a94bd457);
            var_cb545630++;
            if (isdefined(var_a94bd457) && var_cb545630 == 4) {
                namespace_ad52727b::function_7dc74a72("vox_maxi_drone_pickups_" + var_cb545630, var_a94bd457);
            }
        }
    }
}

// Namespace namespace_8d777412
// Params 1, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_e5c03b87
// Checksum 0x9a0bbf74, Offset: 0xdd8
// Size: 0x242
function function_e5c03b87(e_player) {
    w_current_weapon = e_player getcurrentweapon();
    var_4caca97d = getweapon("lmg_mg08_upgraded");
    if (isdefined(level.var_670d761f) && (!isdefined(level.var_670d761f) || zombie_utility::is_player_valid(e_player) && !e_player.is_drinking && !e_player bgb::is_enabled("zm_bgb_disorderly_combat") && !zm_utility::is_placeable_mine(w_current_weapon) && !zm_equipment::is_equipment(w_current_weapon) && "none" != w_current_weapon.name && !e_player zm_equipment::hacker_active() && level.var_670d761f != w_current_weapon)) {
        if (e_player hasweapon(var_4caca97d)) {
            e_player givemaxammo(var_4caca97d);
        } else {
            a_weapons = e_player getweaponslistprimaries();
            if (isdefined(a_weapons) && a_weapons.size >= zm_utility::get_player_weapon_limit(e_player)) {
                e_player takeweapon(w_current_weapon);
            }
            e_player giveweapon(var_4caca97d, e_player zm_weapons::get_pack_a_punch_weapon_options(var_4caca97d), 0);
            e_player givestartammo(var_4caca97d);
            e_player switchtoweapon(var_4caca97d);
        }
        return 1;
    }
    return 0;
}

// Namespace namespace_8d777412
// Params 0, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_84fbb8c2
// Checksum 0x1fd90d20, Offset: 0x1028
// Size: 0xd0
function function_84fbb8c2() {
    var_d8d444fa = getent("hole_poster", "targetname");
    var_d8d444fa setcandamage(1);
    var_d8d444fa.health = 1000;
    var_d8d444fa.maxhealth = var_d8d444fa.health;
    while (true) {
        var_d8d444fa waittill(#"damage");
        if (var_d8d444fa.health <= 0) {
            var_d8d444fa physicslaunch(var_d8d444fa.origin, (0, 0, 0));
        }
    }
}

// Namespace namespace_8d777412
// Params 0, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_e90e9a0
// Checksum 0x8f05c8d1, Offset: 0x1100
// Size: 0x228
function function_e90e9a0() {
    level flag::init("ee_wagon_timer_start");
    level flag::init("ee_wagon_challenge_complete");
    s_powerup = struct::get("wagon_powerup", "targetname");
    while (!level flag::exists("start_zombie_round_logic")) {
        wait(0.5);
    }
    level flag::wait_till("start_zombie_round_logic");
    function_1203717f();
    while (true) {
        level flag::wait_till("ee_wagon_timer_start");
        level flag::wait_till_timeout(30, "ee_wagon_challenge_complete");
        if (!level flag::get("ee_wagon_challenge_complete")) {
            function_1203717f();
            level flag::clear("ee_wagon_timer_start");
            continue;
        }
        zm_powerups::specific_powerup_drop("zombie_blood", s_powerup.origin);
        level waittill(#"end_of_round");
        waittillframeend();
        while (level.var_aa00c190 > 0) {
            level waittill(#"end_of_round");
            waittillframeend();
        }
        function_1203717f();
        level flag::clear("ee_wagon_timer_start");
        level flag::clear("ee_wagon_challenge_complete");
    }
}

// Namespace namespace_8d777412
// Params 0, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_1203717f
// Checksum 0x548d6783, Offset: 0x1330
// Size: 0xea
function function_1203717f() {
    level.var_a5658bff = 0;
    a_triggers = getentarray("wagon_damage_trigger", "targetname");
    foreach (trigger in a_triggers) {
        trigger thread function_bebdf483();
        level clientfield::set(trigger.script_noteworthy, 1);
    }
}

// Namespace namespace_8d777412
// Params 0, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_bebdf483
// Checksum 0x6d87a55b, Offset: 0x1428
// Size: 0x1e2
function function_bebdf483() {
    self notify(#"hash_5c7a1d1e");
    self endon(#"hash_5c7a1d1e");
    var_83560def = level.var_b0d8f1fe["staff_water"].w_weapon;
    var_2499bc6a = level.var_66561721["staff_water_upgraded"].w_weapon;
    while (true) {
        damage, attacker, direction, point, type, tagname, modelname, partname, weapon = self waittill(#"damage");
        if (weapon == var_83560def || isplayer(attacker) && weapon == var_2499bc6a) {
            level.var_a5658bff++;
            if (!level flag::get("ee_wagon_timer_start")) {
                level flag::set("ee_wagon_timer_start");
            }
            level clientfield::set(self.script_noteworthy, 0);
            if (level.var_a5658bff == 3) {
                level flag::set("ee_wagon_challenge_complete");
                level thread namespace_54a425fe::function_5f9c184e("side_sting_1");
            }
            return;
        }
    }
}

// Namespace namespace_8d777412
// Params 0, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_e5597de0
// Checksum 0x1b714e1e, Offset: 0x1618
// Size: 0x204
function function_e5597de0() {
    self endon(#"disconnect");
    if (!isdefined(level.var_ccb9edb2)) {
        level.var_ccb9edb2 = struct::get("struct_gg_look", "targetname");
    }
    if (!isdefined(level.var_5423e21b)) {
        level.var_5423e21b = 0;
    }
    while (!level.var_5423e21b) {
        n_time = 0;
        while (self adsbuttonpressed() && n_time < 25) {
            n_time++;
            wait(0.05);
        }
        if (n_time >= 25 && self adsbuttonpressed() && self getcurrentweapon().issniperweapon && self zm_zonemgr::entity_in_zone("zone_nml_18") && zm_utility::is_player_looking_at(level.var_ccb9edb2.origin, 0.998, 0, undefined)) {
            self playsoundtoplayer("zmb_easteregg_scarydog", self);
            self.var_92fcfed8 = self openluimenu("JumpScare-Tomb");
            n_time = 0;
            while (self adsbuttonpressed() && n_time < 5) {
                n_time++;
                wait(0.05);
            }
            self closeluimenu(self.var_92fcfed8);
            level.var_5423e21b = 1;
        }
        wait(0.05);
    }
}

// Namespace namespace_8d777412
// Params 0, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_1655fa4d
// Checksum 0xb7b7d374, Offset: 0x1828
// Size: 0x1c
function function_1655fa4d() {
    self.var_359dfef5 = 0;
    self.var_7511d08 = 0;
}

// Namespace namespace_8d777412
// Params 0, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_311438f3
// Checksum 0x5860ab92, Offset: 0x1850
// Size: 0x64
function function_311438f3() {
    self waittill(#"disconnect");
    if (isdefined(self.var_6e54f5f1)) {
        self.var_6e54f5f1 delete();
    }
    function_550a6e27(self.var_af20afb4, "bunker", "muddy");
    level.var_6e8b3eda++;
}

// Namespace namespace_8d777412
// Params 0, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_16e5d581
// Checksum 0x136c94f9, Offset: 0x18c0
// Size: 0x9c
function function_16e5d581() {
    self endon(#"disconnect");
    self waittill(#"bled_out");
    if (self.var_359dfef5 < 6) {
        self.var_359dfef5 = 0;
        self.var_7511d08 = 0;
        if (isdefined(self.var_6e54f5f1)) {
            self.var_6e54f5f1 delete();
        }
        function_550a6e27(self.var_af20afb4, "bunker", "muddy");
        level.var_6e8b3eda++;
    }
}

// Namespace namespace_8d777412
// Params 0, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_7154a7d2
// Checksum 0xbc40b53a, Offset: 0x1968
// Size: 0x184
function function_7154a7d2() {
    zm_spawner::add_custom_zombie_spawn_logic(&function_f126dfa5);
    zm_spawner::add_custom_zombie_spawn_logic(&function_3044891b);
    level.var_6e8b3eda = 4;
    var_613bfbdc = [];
    for (var_ca8f84cd = 0; var_ca8f84cd < level.var_6e8b3eda; var_ca8f84cd++) {
        var_613bfbdc[var_ca8f84cd] = function_550a6e27(var_ca8f84cd + 1, "bunker", "muddy");
    }
    var_577916b5 = getent("trigger_oneinchpunch_bunker_table", "targetname");
    var_577916b5 thread function_856fdc82();
    var_577916b5 setcursorhint("HINT_NOICON");
    var_e1c84c10 = getent("trigger_oneinchpunch_church_birdbath", "targetname");
    var_e1c84c10 thread function_c2507f81();
    var_e1c84c10 setcursorhint("HINT_NOICON");
}

// Namespace namespace_8d777412
// Params 0, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_856fdc82
// Checksum 0x5de293dd, Offset: 0x1af8
// Size: 0x370
function function_856fdc82() {
    while (true) {
        player = self waittill(#"trigger");
        if (player.var_359dfef5 == 0) {
            player.var_359dfef5++;
            player.var_af20afb4 = level.var_6e8b3eda;
            player clientfield::set_to_player("player_tablet_state", 2);
            player playsound("zmb_squest_oiptablet_pickup");
            player thread function_311438f3();
            player thread function_16e5d581();
            var_8365f931 = getent("tablet_bunker_" + level.var_6e8b3eda, "targetname");
            var_8365f931 delete();
            level.var_6e8b3eda--;
            /#
                iprintln("toplayer");
            #/
        }
        if (player.var_359dfef5 == 4) {
            player.var_6e54f5f1 = function_550a6e27(player.var_af20afb4, "bunker", "clean");
            player.var_359dfef5++;
            player clientfield::set_to_player("player_tablet_state", 0);
            player playsound("zmb_squest_oiptablet_place_table");
            /#
                iprintln("toplayer");
            #/
            continue;
        }
        if (isdefined(player.var_4249da41) && player.var_359dfef5 == 6 && player.var_4249da41) {
            player clientfield::set_to_player("ee_beacon_reward", 0);
            w_beacon = getweapon("beacon");
            player zm_weapons::weapon_give(w_beacon);
            player thread namespace_ad52727b::function_92121c7d("get_beacon");
            if (isdefined(level.zombie_include_weapons[w_beacon]) && !level.zombie_include_weapons[w_beacon]) {
                level.zombie_include_weapons[w_beacon] = 1;
                level.zombie_weapons[w_beacon].is_in_box = 1;
            }
            player playsound("zmb_squest_oiptablet_get_reward");
            player.var_359dfef5++;
            /#
                iprintln("toplayer");
            #/
        }
    }
}

// Namespace namespace_8d777412
// Params 0, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_c2507f81
// Checksum 0x7ebc66b5, Offset: 0x1e70
// Size: 0x240
function function_c2507f81() {
    while (true) {
        player = self waittill(#"trigger");
        if (player.var_359dfef5 == 1) {
            if (isdefined(player.var_32971ce5)) {
                player.var_32971ce5 = undefined;
                player.var_359dfef5++;
                player.var_6e54f5f1 = function_550a6e27(player.var_af20afb4, "church", "clean");
                level thread function_f15a36ce(player, 1);
            } else {
                player.var_6e54f5f1 = function_550a6e27(player.var_af20afb4, "church", "muddy");
            }
            player playsound("zmb_squest_oiptablet_bathe");
            player clientfield::set_to_player("player_tablet_state", 0);
            player.var_359dfef5++;
            /#
                iprintln("toplayer");
            #/
        }
        if (player.var_359dfef5 == 3) {
            player clientfield::set_to_player("player_tablet_state", 1);
            player.var_359dfef5++;
            if (isdefined(player.var_6e54f5f1)) {
                player.var_6e54f5f1 delete();
            }
            player playsound("zmb_squest_oiptablet_pickup_clean");
            player thread function_76de2f82();
            /#
                iprintln("toplayer");
            #/
        }
    }
}

// Namespace namespace_8d777412
// Params 0, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_76de2f82
// Checksum 0x2d5db34c, Offset: 0x20b8
// Size: 0xc6
function function_76de2f82() {
    self endon(#"hash_3f7b661c");
    while (self.var_359dfef5 == 4) {
        if (self.var_262a5e46) {
            self clientfield::set_to_player("player_tablet_state", 2);
            self playsoundtoplayer("zmb_squest_oiptablet_dirtied", self);
            self.var_359dfef5 = 1;
            self.var_32971ce5 = 1;
            level thread function_f15a36ce(self);
            /#
                iprintln("toplayer");
            #/
        }
        wait(1);
    }
}

// Namespace namespace_8d777412
// Params 2, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_f15a36ce
// Checksum 0x5383f31d, Offset: 0x2188
// Size: 0x174
function function_f15a36ce(e_player, var_97f6fbc8) {
    if (!isdefined(var_97f6fbc8)) {
        var_97f6fbc8 = 0;
    }
    if (isdefined(level.var_8c80bd85) && (!isdefined(e_player) || level.var_8c80bd85) || level flag::get("story_vo_playing")) {
        return;
    }
    level flag::set("story_vo_playing");
    e_player namespace_ad52727b::function_c502e741(1);
    level.var_8c80bd85 = 1;
    str_line = "vox_sam_generic_chastise_7";
    if (var_97f6fbc8) {
        str_line = "vox_sam_generic_chastise_8";
    }
    if (isdefined(e_player)) {
        e_player playsoundtoplayer(str_line, e_player);
    }
    n_duration = soundgetplaybacktime(str_line);
    wait(n_duration / 1000);
    level.var_8c80bd85 = 0;
    level flag::clear("story_vo_playing");
    if (isdefined(e_player)) {
        e_player namespace_ad52727b::function_c502e741(0);
    }
}

// Namespace namespace_8d777412
// Params 0, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_f126dfa5
// Checksum 0x6d5cbbda, Offset: 0x2308
// Size: 0x1fc
function function_f126dfa5() {
    self waittill(#"death");
    if (!isdefined(self)) {
        return;
    }
    var_a99fd30b = "oneinchpunch_bunker_volume";
    volume = getent(var_a99fd30b, "targetname");
    assert(isdefined(volume), var_a99fd30b + "toplayer");
    attacker = self.attacker;
    if (isdefined(attacker) && isplayer(attacker)) {
        if (self.damagemod == "MOD_MELEE" || attacker.var_359dfef5 == 5 && self.damageweapon.name == "tomb_shield") {
            if (self istouching(volume)) {
                self clientfield::set("ee_zombie_tablet_fx", 1);
                attacker.var_7511d08++;
                /#
                    iprintln("toplayer" + attacker.var_7511d08);
                #/
                if (attacker.var_7511d08 >= 20) {
                    attacker thread function_bf6f3000();
                    attacker.var_359dfef5++;
                    level thread namespace_54a425fe::function_5f9c184e("side_sting_3");
                    /#
                        iprintln("toplayer");
                    #/
                }
            }
        }
    }
}

// Namespace namespace_8d777412
// Params 0, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_bf6f3000
// Checksum 0xfa2e147d, Offset: 0x2510
// Size: 0x48
function function_bf6f3000() {
    self endon(#"disconnect");
    wait(2);
    self clientfield::set_to_player("ee_beacon_reward", 1);
    wait(2);
    self.var_4249da41 = 1;
}

// Namespace namespace_8d777412
// Params 0, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_3044891b
// Checksum 0x2d815139, Offset: 0x2560
// Size: 0x24c
function function_3044891b() {
    self waittill(#"death");
    if (!isdefined(self)) {
        return;
    }
    var_a99fd30b = "oneinchpunch_church_volume";
    volume = getent(var_a99fd30b, "targetname");
    assert(isdefined(volume), var_a99fd30b + "toplayer");
    attacker = self.attacker;
    if (isdefined(attacker) && isplayer(attacker)) {
        if (self.damagemod == "MOD_MELEE" || attacker.var_359dfef5 == 2 && self.damageweapon.name == "tomb_shield") {
            if (self istouching(volume)) {
                self clientfield::set("ee_zombie_tablet_fx", 1);
                attacker.var_7511d08++;
                /#
                    iprintln("toplayer" + attacker.var_7511d08);
                #/
                if (attacker.var_7511d08 >= 20) {
                    attacker.var_359dfef5++;
                    attacker.var_7511d08 = 0;
                    attacker.var_6e54f5f1 delete();
                    attacker.var_6e54f5f1 = function_550a6e27(attacker.var_af20afb4, "church", "clean");
                    level thread namespace_54a425fe::function_5f9c184e("side_sting_6");
                    /#
                        iprintln("toplayer");
                    #/
                }
            }
        }
    }
}

// Namespace namespace_8d777412
// Params 3, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_550a6e27
// Checksum 0x356e3f77, Offset: 0x27b8
// Size: 0x180
function function_550a6e27(var_ca8f84cd, str_location, str_state) {
    var_6b34ef2f = struct::get("oneinchpunch_" + str_location + "_tablet_" + var_ca8f84cd, "targetname");
    v_spawnpt = var_6b34ef2f.origin;
    var_f8c6b1d7 = var_6b34ef2f.angles;
    var_8365f931 = spawn("script_model", v_spawnpt);
    var_8365f931.angles = var_f8c6b1d7;
    if (str_state == "clean") {
        var_8365f931 setmodel("p7_zm_ori_tablet_stone");
        if (str_location == "church") {
            var_8365f931 playsound("zmb_squest_oiptablet_charged");
        }
    } else {
        var_8365f931 setmodel("p7_zm_ori_tablet_stone_muddy");
    }
    var_8365f931.targetname = "tablet_" + str_location + "_" + var_ca8f84cd;
    return var_8365f931;
}

// Namespace namespace_8d777412
// Params 0, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_8bb9def9
// Checksum 0x600e9bca, Offset: 0x2940
// Size: 0x1f2
function function_8bb9def9() {
    level.var_7446ace8 = 0;
    wait(3);
    a_structs = struct::get_array("ee_radio_pos", "targetname");
    foreach (unitrigger_stub in a_structs) {
        unitrigger_stub.radius = 50;
        unitrigger_stub.height = -128;
        unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
        unitrigger_stub.cursor_hint = "HINT_NOICON";
        unitrigger_stub.require_look_at = 1;
        var_dec9a3a = spawn("script_model", unitrigger_stub.origin);
        var_dec9a3a.angles = unitrigger_stub.angles;
        var_dec9a3a setmodel("p7_zm_ori_radio_01");
        var_dec9a3a attach("p7_zm_ori_radio_01_panel_02", "tag_j_cover");
        zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_632cca62);
        /#
            unitrigger_stub thread function_26782b67();
        #/
        util::wait_network_frame();
    }
}

/#

    // Namespace namespace_8d777412
    // Params 0, eflags: 0x1 linked
    // namespace_8d777412<file_0>::function_26782b67
    // Checksum 0x63344d39, Offset: 0x2b40
    // Size: 0x58
    function function_26782b67() {
        self endon(#"hash_b5006e12");
        while (true) {
            print3d(self.origin, "toplayer", (255, 0, 255), 1);
            wait(0.05);
        }
    }

#/

// Namespace namespace_8d777412
// Params 0, eflags: 0x1 linked
// namespace_8d777412<file_0>::function_632cca62
// Checksum 0x590bade5, Offset: 0x2ba0
// Size: 0xfa
function function_632cca62() {
    self endon(#"kill_trigger");
    while (true) {
        player = self waittill(#"trigger");
        if (!namespace_52adc03e::function_8090042c()) {
            continue;
        }
        if (zombie_utility::is_player_valid(player)) {
            level.var_7446ace8++;
            playsoundatposition("zmb_ee_mus_activate", self.origin);
            if (level.var_7446ace8 == 3) {
                level thread zm_audio::sndmusicsystem_playstate("shepherd_of_fire");
            }
            /#
                self.stub notify(#"hash_b5006e12");
            #/
            zm_unitrigger::unregister_unitrigger(self.stub);
            return;
        }
    }
}

