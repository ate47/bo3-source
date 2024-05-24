#using scripts/shared/vehicles/_parasite;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_death;
#using scripts/zm/zm_genesis_wasp;
#using scripts/zm/zm_genesis_vo;
#using scripts/zm/zm_genesis_util;
#using scripts/zm/zm_genesis_spiders;
#using scripts/zm/zm_genesis_fx;
#using scripts/zm/zm_genesis_cleanup_mgr;
#using scripts/zm/zm_genesis_apothicon_fury;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_power;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_genesis_spiders;
#using scripts/zm/_zm_elemental_zombies;
#using scripts/zm/_zm_audio;
#using scripts/shared/scene_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_4c9147;

// Namespace namespace_4c9147
// Params 0, eflags: 0x2
// Checksum 0xbab742b8, Offset: 0x948
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_genesis_power", &__init__, &__main__, undefined);
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0xc9f7304e, Offset: 0x990
// Size: 0x15c
function __init__() {
    clientfield::register("scriptmover", "power_zombie_soul", 15000, 1, "int");
    clientfield::register("scriptmover", "power_cables_shader", 15000, 1, "int");
    for (i = 1; i <= 4; i++) {
        clientfield::register("world", "corruption_tower" + i, 15000, 7, "float");
    }
    level.var_63ceb0b2 = "power_on9";
    level flag::init(level.var_63ceb0b2);
    level thread function_62072a94();
    if (true) {
        zm_spawner::register_zombie_death_event_callback(&function_9cc9b090);
    }
    function_f29a5d3a();
    level thread function_bcac2659();
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0x868ace37, Offset: 0xaf8
// Size: 0x1c
function __main__() {
    level thread function_7d3242b1();
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0x68414e12, Offset: 0xb20
// Size: 0x3c
function function_62072a94() {
    wait(1);
    level thread function_d5b54fdc();
    level flag::set(level.var_63ceb0b2);
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0xef83d022, Offset: 0xb68
// Size: 0x9e
function function_f29a5d3a() {
    var_e6706bab = getentarray("power_volume", "targetname");
    level.var_eada0345 = 0;
    level thread function_79774b04();
    for (i = 0; i < var_e6706bab.size; i++) {
        var_e6706bab[i] thread function_fec7f142();
    }
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0x529bd032, Offset: 0xc10
// Size: 0x7c
function function_bcac2659() {
    level waittill(#"start_zombie_round_logic");
    var_5d7a99d0 = getentarray("power_grid_display", "targetname");
    array::thread_all(var_5d7a99d0, &function_11da2524);
    level thread function_28753fd1();
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0x21dc611c, Offset: 0xc98
// Size: 0x32a
function function_11da2524() {
    self hidepart("tag_light_01_green");
    self hidepart("tag_light_02_green");
    self hidepart("tag_light_03_green");
    self hidepart("tag_light_04_green");
    while (!level flag::get("all_power_on")) {
        str_result = level util::waittill_any_return("power_on1", "power_on2", "power_on3", "power_on4", "all_power_on");
        switch (str_result) {
        case 20:
            self hidepart("tag_light_01_red");
            self showpart("tag_light_01_green");
            break;
        case 19:
            self hidepart("tag_light_04_red");
            self showpart("tag_light_04_green");
            break;
        case 18:
            self hidepart("tag_light_03_red");
            self showpart("tag_light_03_green");
            break;
        case 17:
            self hidepart("tag_light_02_red");
            self showpart("tag_light_02_green");
            break;
        case 16:
            self hidepart("tag_light_01_red");
            self showpart("tag_light_01_green");
            self hidepart("tag_light_02_red");
            self showpart("tag_light_02_green");
            self hidepart("tag_light_03_red");
            self showpart("tag_light_03_green");
            self hidepart("tag_light_04_red");
            self showpart("tag_light_04_green");
            break;
        }
    }
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0xab78e1dd, Offset: 0xfd0
// Size: 0x622
function function_28753fd1() {
    var_329d83b2 = getent("tesla_trap_console", "targetname");
    var_33accfa3 = getentarray("power_cable_proto", "targetname");
    for (i = 0; i < var_33accfa3.size; i++) {
        switch (var_33accfa3[i].script_noteworthy) {
        case 28:
            var_7781bac2 = var_33accfa3[i];
            break;
        case 29:
            var_18c59005 = var_33accfa3[i];
            break;
        case 30:
            var_c3cc1994 = var_33accfa3[i];
            break;
        case 27:
            var_66f151c2 = var_33accfa3[i];
            break;
        }
    }
    for (i = 1; i <= 4; i++) {
        var_329d83b2 hidepart("j_flash_0" + i);
        var_329d83b2 hidepart("j_green_0" + i);
    }
    var_329d83b2 hidepart("j_flash_on");
    while (!level flag::get("all_power_on")) {
        str_result = level util::waittill_any_return("power_on1", "power_on2", "power_on3", "power_on4", "all_power_on");
        switch (str_result) {
        case 20:
            var_329d83b2 hidepart("j_red_02");
            var_329d83b2 showpart("j_green_02");
            level thread scene::play("power_meter_prison", "targetname");
            var_7781bac2 clientfield::set("power_cables_shader", 1);
            break;
        case 19:
            var_329d83b2 hidepart("j_red_04");
            var_329d83b2 showpart("j_green_04");
            level thread scene::play("power_meter_sheffield", "targetname");
            var_18c59005 clientfield::set("power_cables_shader", 1);
            break;
        case 18:
            var_329d83b2 hidepart("j_red_03");
            var_329d83b2 showpart("j_green_03");
            level thread scene::play("power_meter_temple", "targetname");
            var_c3cc1994 clientfield::set("power_cables_shader", 1);
            break;
        case 17:
            var_329d83b2 hidepart("j_red_01");
            var_329d83b2 showpart("j_green_01");
            level thread scene::play("power_meter_asylum", "targetname");
            var_66f151c2 clientfield::set("power_cables_shader", 1);
            break;
        case 16:
            var_329d83b2 hidepart("j_red_01");
            var_329d83b2 showpart("j_green_01");
            var_329d83b2 hidepart("j_red_02");
            var_329d83b2 showpart("j_green_02");
            var_329d83b2 hidepart("j_red_03");
            var_329d83b2 showpart("j_green_03");
            var_329d83b2 hidepart("j_red_04");
            var_329d83b2 showpart("j_green_04");
            foreach (var_37176f28 in var_33accfa3) {
                var_37176f28 clientfield::set("power_cables_shader", 1);
            }
            break;
        }
    }
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0xa3835bf3, Offset: 0x1600
// Size: 0x25c
function function_79774b04() {
    level endon(#"hash_fb60eed2");
    while (true) {
        var_e6706bab = getentarray("power_volume", "targetname");
        if (var_e6706bab.size == 0) {
            break;
        }
        a_players = getplayers();
        for (i = 0; i < a_players.size; i++) {
            e_player = a_players[i];
            var_cebeadd5 = 0;
            for (j = 0; j < var_e6706bab.size; j++) {
                var_f5f4e9cc = var_e6706bab[j];
                if (!(isdefined(var_f5f4e9cc.var_56e27fd0) && var_f5f4e9cc.var_56e27fd0)) {
                    var_cebeadd5 = var_f5f4e9cc function_8961cbdb(e_player);
                    if (var_cebeadd5) {
                        var_cebeadd5 = 1;
                        break;
                    }
                }
            }
            if (var_cebeadd5) {
                if (!isdefined(e_player.var_e3e6c76a)) {
                    e_player.var_e3e6c76a = namespace_cb655c88::function_89067abe(e_player, %ZM_GENESIS_POWER_COST, undefined, 100);
                }
            } else if (isdefined(e_player.var_e3e6c76a)) {
                e_player.var_e3e6c76a destroy();
                e_player.var_e3e6c76a = undefined;
            }
            if (isdefined(e_player.var_e3e6c76a)) {
                n_cost = function_fe2cf77b(var_f5f4e9cc);
                e_player.var_e3e6c76a settext(%ZM_GENESIS_POWER_COST, n_cost);
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_4c9147
// Params 1, eflags: 0x0
// Checksum 0x8ea4a5f8, Offset: 0x1868
// Size: 0x1fe
function function_19235352(facee) {
    var_e984946e = 0.8;
    orientation = self getplayerangles();
    forwardvec = anglestoforward(orientation);
    forwardvec2d = (forwardvec[0], forwardvec[1], 0);
    unitforwardvec2d = vectornormalize(forwardvec2d);
    tofaceevec = facee.origin - self.origin;
    tofaceevec2d = (tofaceevec[0], tofaceevec[1], 0);
    unittofaceevec2d = vectornormalize(tofaceevec2d);
    dotproduct = vectordot(unitforwardvec2d, unittofaceevec2d);
    if (dotproduct > var_e984946e) {
        var_270778cc = anglestoforward(facee.angles);
        var_ed409956 = (var_270778cc[0], var_270778cc[1], 0);
        var_2ecbb83c = vectornormalize(var_ed409956);
        var_64886733 = vectordot(var_2ecbb83c, unittofaceevec2d);
        if (var_64886733 > var_e984946e) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_4c9147
// Params 1, eflags: 0x0
// Checksum 0x3a70bb0c, Offset: 0x1a70
// Size: 0xce
function function_8961cbdb(e_player) {
    str_struct = "power_use" + self.script_int;
    s_struct = struct::get(str_struct, "targetname");
    var_7f914a34 = s_struct.origin;
    var_3fee7d85 = distance2d(e_player.origin, var_7f914a34);
    if (var_3fee7d85 <= 80) {
        if (e_player function_19235352(s_struct)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_4c9147
// Params 1, eflags: 0x0
// Checksum 0xbf461149, Offset: 0x1b48
// Size: 0x10
function function_fe2cf77b(var_f5f4e9cc) {
    return 500;
}

// Namespace namespace_4c9147
// Params 1, eflags: 0x0
// Checksum 0xf6dab26d, Offset: 0x1b60
// Size: 0xa2
function function_b8c60cae(var_f5f4e9cc) {
    n_num = 0;
    a_players = getplayers();
    for (i = 0; i < a_players.size; i++) {
        e_player = a_players[i];
        if (function_d46b0523(e_player, var_f5f4e9cc)) {
            n_num++;
        }
    }
    return n_num;
}

// Namespace namespace_4c9147
// Params 2, eflags: 0x0
// Checksum 0x8f4aed1b, Offset: 0x1c10
// Size: 0x5c
function function_d46b0523(e_player, var_f5f4e9cc) {
    if (e_player istouching(var_f5f4e9cc) && !(isdefined(e_player.laststand) && e_player.laststand)) {
        return true;
    }
    return false;
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0xd68c7c37, Offset: 0x1c78
// Size: 0x3fc
function function_fec7f142() {
    self endon(#"death");
    level endon(#"hash_fb60eed2");
    self thread function_7b3cac15();
    str_flag = "power_on" + self.script_int;
    level flag::init(str_flag);
    self.var_3c42ad63 = "abort_ritual" + self.script_int;
    self.var_8f4b8aaf = "kill_ritual" + self.script_int;
    wait(1);
    str_name = "power_spawn" + self.script_int + "_loc";
    var_1574e07 = struct::get_array(str_name, "script_label");
    for (i = 0; i < var_1574e07.size; i++) {
        var_1574e07[i].is_enabled = 0;
    }
    self.var_98e1d15 = 0;
    while (self.var_98e1d15 == 0) {
        self.var_a7dffe09 = 0;
        e_player = self function_8a3885f2();
        a_players = getplayers();
        for (i = 0; i < a_players.size; i++) {
            a_players[i].var_4d307aef = 0;
        }
        self thread function_b016efbe();
        level.zombie_ai_limit = 14;
        self thread function_9214a0b3(14);
        level.var_9bbfcb9 = 1;
        while (true) {
            if (isdefined(self.var_98e1d15) && self.var_98e1d15) {
                if (isplayer(e_player)) {
                    e_player notify(#"hash_e95dda8e");
                }
                break;
            } else if (isdefined(self.var_a7dffe09) && self.var_a7dffe09) {
                if (isplayer(e_player)) {
                    e_player notify(#"hash_6a24d908");
                }
                break;
            }
            wait(0.05);
        }
        level.var_9bbfcb9 = 0;
        self notify(#"hash_e9b136f1");
        a_players = getplayers();
        for (i = 0; i < a_players.size; i++) {
            if (isdefined(self.var_98e1d15) && a_players[i].var_4d307aef == 0 && self.var_98e1d15) {
                if (function_d46b0523(a_players[i], self)) {
                    level notify(#"hash_9a954bfc", a_players[i]);
                }
            }
            a_players[i].var_4d307aef = undefined;
        }
        level.zombie_ai_limit = level.zombie_vars["zombie_max_ai"];
    }
    if (true) {
        for (i = 0; i < var_1574e07.size; i++) {
            var_1574e07[i].is_enabled = 1;
        }
    }
    wait(1);
    self delete();
}

// Namespace namespace_4c9147
// Params 1, eflags: 0x0
// Checksum 0x2faf14fa, Offset: 0x2080
// Size: 0x88
function function_9214a0b3(n_limit) {
    self endon(#"hash_e9b136f1");
    while (true) {
        var_cecd0670 = zombie_utility::get_current_zombie_count();
        var_cecd0670 -= function_e793dedb();
        if (var_cecd0670 > n_limit) {
            function_5da9abb7();
        }
        wait(0.05);
    }
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0xc196619f, Offset: 0x2110
// Size: 0x1b0
function function_5da9abb7() {
    a_zombies = getaiarchetypearray("zombie");
    var_c580871a = [];
    for (i = 0; i < a_zombies.size; i++) {
        ai_zombie = a_zombies[i];
        foreach (e_player in level.players) {
            if (e_player.sessionstate == "spectator") {
                continue;
            }
            if (ai_zombie namespace_d5b9f994::player_can_see_me(e_player)) {
                continue;
            }
            if (isdefined(ai_zombie.var_170c70b6) && ai_zombie.var_170c70b6) {
                continue;
            }
            var_c580871a[var_c580871a.size] = ai_zombie;
        }
    }
    if (var_c580871a.size) {
        ai_zombie = var_c580871a[0];
        ai_zombie thread namespace_d5b9f994::delete_zombie_noone_looking();
        ai_zombie.var_170c70b6 = 1;
    }
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0xba1709f9, Offset: 0x22c8
// Size: 0x274
function function_8a3885f2() {
    level endon(#"hash_fb60eed2");
    var_93b2c080 = 0;
    while (!var_93b2c080) {
        if (!(isdefined(level.var_9bbfcb9) && level.var_9bbfcb9)) {
            a_players = getplayers();
            for (i = 0; i < a_players.size; i++) {
                e_player = a_players[i];
                var_2638ea5e = self function_8961cbdb(e_player);
                if (var_2638ea5e) {
                    n_cost = function_fe2cf77b(self);
                    if (e_player usebuttonpressed() && e_player zm_score::can_player_purchase(n_cost) && !(isdefined(e_player.laststand) && e_player.laststand) && !(isdefined(e_player.is_reviving_any) && e_player.is_reviving_any)) {
                        if (!isdefined(e_player.var_8e8c165c)) {
                            e_player.var_8e8c165c = gettime();
                        }
                        n_time = gettime();
                        var_43421314 = (n_time - e_player.var_8e8c165c) / 1000;
                        if (var_43421314 >= 0.5) {
                            e_player thread function_59bcf901(n_cost, self);
                            level thread namespace_c149ef1::function_5e81e3ff();
                            var_93b2c080 = 1;
                            playsoundatposition("zmb_apothicon_activate", e_player.origin);
                            break;
                        }
                        continue;
                    }
                    e_player.var_8e8c165c = undefined;
                }
            }
        }
        if (!var_93b2c080) {
            wait(0.05);
        }
    }
    return e_player;
}

// Namespace namespace_4c9147
// Params 2, eflags: 0x0
// Checksum 0xd4011ad2, Offset: 0x2548
// Size: 0x26c
function function_59bcf901(n_cost, var_f5f4e9cc) {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"hash_6a24d908");
    self zm_score::minus_to_player_score(n_cost);
    self waittill(#"hash_e95dda8e");
    if (true) {
        a_players = getplayers();
        for (i = 0; i < a_players.size; i++) {
            e_player = a_players[i];
            if (e_player istouching(var_f5f4e9cc) && !(isdefined(e_player.laststand) && e_player.laststand)) {
                e_player zm_score::add_to_player_score(500);
            }
        }
    }
    self zm_score::add_to_player_score(n_cost);
    str_struct = "power_pickup" + var_f5f4e9cc.script_int;
    s_struct = struct::get(str_struct, "targetname");
    wait(1.5);
    v_pos = s_struct.origin + (0, 0, -30);
    if (false) {
        if (level.var_eada0345 == 1) {
            zm_powerups::specific_powerup_drop("double_points", v_pos);
            return;
        }
        if (level.var_eada0345 == 2) {
            zm_powerups::specific_powerup_drop("full_ammo", v_pos);
            return;
        }
        if (level.var_eada0345 == 3) {
            zm_powerups::specific_powerup_drop("double_points", v_pos);
            return;
        }
        zm_powerups::specific_powerup_drop("full_ammo", v_pos);
    }
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0x1549019a, Offset: 0x27c0
// Size: 0x1b0
function function_b016efbe() {
    level notify(#"hash_661aa774");
    self thread function_d93bc7dc();
    self.var_56e27fd0 = 1;
    self thread function_5168ed24();
    wait(2.3);
    level.var_7b91fc17 = self;
    level.var_b780352b = &function_b780352b;
    self function_1d9b9b7b();
    level thread function_5003c1cd(1, 0);
    level thread function_7ab27924();
    level thread function_fbb9459a(self);
    if (self.var_a7dffe09) {
        level notify(#"hash_27ce2dd6");
        return;
    }
    level.var_7b91fc17 = undefined;
    level.var_b780352b = undefined;
    var_7e0a45c8 = self.script_int;
    level thread zm_power::turn_power_on_and_open_doors(var_7e0a45c8);
    level.var_eada0345++;
    self notify(self.var_8f4b8aaf);
    self.var_98e1d15 = 1;
    level notify(#"hash_49409ee8");
    level thread function_de2cddfc();
    if (getdvarint("splitscreen_playerCount") < 3) {
        level thread function_5f122d0d(self.script_int);
    }
    return 1;
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0xe65c5fc, Offset: 0x2978
// Size: 0xf2
function function_7ab27924() {
    a_zombies = getaiteamarray(level.zombie_team);
    foreach (e_zombie in a_zombies) {
        if (isdefined(e_zombie.var_8a1ad3bb) && e_zombie.var_8a1ad3bb) {
            e_zombie dodamage(e_zombie.health + 100, e_zombie.origin);
        }
    }
}

// Namespace namespace_4c9147
// Params 1, eflags: 0x0
// Checksum 0x3ff4797e, Offset: 0x2a78
// Size: 0x44
function function_5f122d0d(var_f76b5f17) {
    str_name = "power_teeth_" + var_f76b5f17;
    scene::play(str_name, "targetname");
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0x7c014b5e, Offset: 0x2ac8
// Size: 0x248
function function_1d9b9b7b() {
    self endon(self.var_8f4b8aaf);
    self endon(self.var_3c42ad63);
    ai_index = 0;
    var_c00049d4 = "power_spawn" + self.script_int;
    a_s_locations = struct::get_array(var_c00049d4, "targetname");
    a_s_locations = array::randomize(a_s_locations);
    self.var_b7d540e6 = gettime();
    self.var_9437e3b6 = 0;
    var_f2882ed8 = 0;
    var_13b0b925 = gettime();
    while (true) {
        var_23e2425 = self function_d93f3a3f();
        n_percent = var_23e2425 / 15;
        level clientfield::set("corruption_tower" + self.script_int, n_percent);
        if (var_23e2425 >= 15) {
            break;
        } else if (var_23e2425 < 0) {
            self function_63c8bd9();
            wait(0.05);
            return;
        }
        n_alive = function_e793dedb();
        if (n_alive >= 12) {
            var_13b0b925 += 100;
        } else if (gettime() >= var_13b0b925) {
            s_spawn_pos = a_s_locations[var_f2882ed8];
            var_f2882ed8++;
            if (var_f2882ed8 >= a_s_locations.size) {
                var_f2882ed8 = 0;
            }
            self thread function_e467fa8d(s_spawn_pos);
            var_13b0b925 = gettime() + get_spawn_delay() * 1000;
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0x6e7feea8, Offset: 0x2d18
// Size: 0x9e
function function_d93f3a3f() {
    n_time = gettime();
    n_time_delta = (n_time - self.var_b7d540e6) / 1000;
    self.var_b7d540e6 = n_time;
    var_157932a7 = function_b8c60cae(self);
    if (var_157932a7 > 0) {
        self.var_9437e3b6 += n_time_delta;
    } else {
        self.var_9437e3b6 -= n_time_delta;
    }
    return self.var_9437e3b6;
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0xc9109cf6, Offset: 0x2dc0
// Size: 0x42
function function_63c8bd9() {
    level thread function_5003c1cd(1, 0);
    self.var_a7dffe09 = 1;
    self.var_56e27fd0 = 0;
    self notify(self.var_3c42ad63);
}

// Namespace namespace_4c9147
// Params 1, eflags: 0x0
// Checksum 0x53f2b932, Offset: 0x2e10
// Size: 0x16c
function get_favorite_enemy(v_origin) {
    a_targets = getplayers();
    var_20a0668f = undefined;
    for (i = 0; i < a_targets.size; i++) {
        e_target = a_targets[i];
        dist = distance(e_target.origin, v_origin);
        if (dist >= 1000) {
            continue;
        }
        if (!isdefined(e_target.var_773a8dea)) {
            e_target.var_773a8dea = 0;
        }
        if (!zm_utility::is_player_valid(e_target)) {
            continue;
        }
        if (!isdefined(var_20a0668f)) {
            var_20a0668f = e_target;
            continue;
        }
        if (e_target.var_773a8dea < var_20a0668f.var_773a8dea) {
            e_least_hunted = e_target;
        }
    }
    if (!isdefined(e_least_hunted)) {
        e_least_hunted = array::random(a_targets);
    }
    return e_least_hunted;
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0x61f4074c, Offset: 0x2f88
// Size: 0x1a6
function function_5168ed24() {
    self endon(self.var_3c42ad63);
    self endon(self.var_8f4b8aaf);
    self thread function_c5b06d9d();
    b_rumble = 1;
    while (true) {
        foreach (player in level.activeplayers) {
            if (zombie_utility::is_player_valid(player) && function_d46b0523(player, self)) {
                if (b_rumble) {
                    player namespace_cb655c88::function_6edf48d5(5);
                    continue;
                }
                player namespace_cb655c88::function_6edf48d5(0);
            }
        }
        if (b_rumble) {
            b_rumble = 0;
        } else {
            b_rumble = 1;
        }
        var_157932a7 = function_b8c60cae(self);
        if (var_157932a7) {
            n_delay = 0.5;
        } else {
            n_delay = 0.25;
        }
        wait(n_delay);
    }
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0xaf28c406, Offset: 0x3138
// Size: 0xde
function function_de2cddfc() {
    for (i = 0; i < 6; i++) {
        foreach (player in level.activeplayers) {
            if (zombie_utility::is_player_valid(player)) {
                player namespace_cb655c88::function_6edf48d5(4);
            }
        }
        wait(0.4);
    }
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0x38999f05, Offset: 0x3220
// Size: 0xb2
function function_c5b06d9d() {
    self util::waittill_any(self.var_3c42ad63, self.var_8f4b8aaf);
    foreach (player in level.activeplayers) {
        player namespace_cb655c88::function_6edf48d5(0);
    }
}

// Namespace namespace_4c9147
// Params 2, eflags: 0x0
// Checksum 0xdb61f838, Offset: 0x32e0
// Size: 0x38e
function function_5003c1cd(var_21f1f59c, var_4c2039) {
    zombies = getaiteamarray(level.zombie_team);
    zombies_nuked = [];
    for (i = 0; i < zombies.size; i++) {
        if (var_21f1f59c && !(isdefined(zombies[i].var_17de041a) && zombies[i].var_17de041a)) {
            continue;
        }
        if (isdefined(zombies[i].var_953b581c) && zombies[i].var_953b581c && !(isdefined(var_4c2039) && var_4c2039)) {
            continue;
        }
        if (isdefined(zombies[i].marked_for_death) && zombies[i].marked_for_death) {
            continue;
        }
        if (isdefined(zombies[i].nuke_damage_func)) {
            zombies[i] thread [[ zombies[i].nuke_damage_func ]]();
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(zombies[i])) {
            continue;
        }
        zombies[i].marked_for_death = 1;
        zombies[i].nuked = 1;
        zombies_nuked[zombies_nuked.size] = zombies[i];
    }
    for (i = 0; i < zombies_nuked.size; i++) {
        wait(randomfloatrange(0.1, 0.2));
        if (!isdefined(zombies_nuked[i])) {
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(zombies_nuked[i])) {
            continue;
        }
        if (i < 5 && !(isdefined(zombies_nuked[i].isdog) && zombies_nuked[i].isdog)) {
            zombies_nuked[i] thread zombie_death::flame_death_fx();
        }
        if (!(isdefined(zombies_nuked[i].isdog) && zombies_nuked[i].isdog)) {
            if (!(isdefined(zombies_nuked[i].no_gib) && zombies_nuked[i].no_gib)) {
                zombies_nuked[i] zombie_utility::zombie_head_gib();
            }
            zombies_nuked[i] playsound("evt_nuked");
        }
        zombies_nuked[i] dodamage(zombies_nuked[i].health + 666, zombies_nuked[i].origin);
    }
}

// Namespace namespace_4c9147
// Params 1, eflags: 0x0
// Checksum 0xa1c011fa, Offset: 0x3678
// Size: 0x1a2
function function_fbb9459a(var_1f76a385) {
    zombies = getaiteamarray(level.zombie_team);
    var_71f91895 = var_1f76a385 array::get_touching(zombies);
    foreach (zombie in var_71f91895) {
        if (!isdefined(zombie)) {
            continue;
        }
        if (isdefined(zombie.var_953b581c) && (isdefined(zombie.nuked) && (isdefined(zombie.marked_for_death) && zombie.marked_for_death || zombie.nuked) || zombie.var_953b581c)) {
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(zombie)) {
            continue;
        }
        zombie kill();
        level.zombie_total++;
        wait(randomfloatrange(0.1, 0.2));
    }
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0xb3b82806, Offset: 0x3828
// Size: 0x9a
function function_e793dedb() {
    zombies = getaiteamarray(level.zombie_team);
    n_alive = 0;
    for (i = 0; i < zombies.size; i++) {
        if (isdefined(zombies[i].var_17de041a) && zombies[i].var_17de041a) {
            n_alive++;
        }
    }
    return n_alive;
}

// Namespace namespace_4c9147
// Params 4, eflags: 0x0
// Checksum 0x1e999a58, Offset: 0x38d0
// Size: 0xd4
function function_dfd0ecb2(v_origin, v_angles, var_408dd52f, time) {
    e_model = util::spawn_model("tag_origin", v_origin, v_angles);
    e_model clientfield::set("power_zombie_soul", 1);
    e_model moveto(var_408dd52f, time);
    e_model waittill(#"movedone");
    e_model playsound("zmb_ee_soul_impact");
    e_model delete();
}

// Namespace namespace_4c9147
// Params 2, eflags: 0x0
// Checksum 0xf2d20b43, Offset: 0x39b0
// Size: 0xc4
function function_6301de9e(v_pos, v_angles) {
    e_attacker = self waittill(#"death");
    if (isplayer(e_attacker)) {
        if (isdefined(level.var_7b91fc17)) {
            var_f5f4e9cc = level.var_7b91fc17;
            if (var_f5f4e9cc.var_3f80e7e8 < -56) {
                var_f5f4e9cc.var_3f80e7e8 += 10;
                e_attacker zm_score::player_add_points("bonus_points_powerup", 10);
            }
        }
    }
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0x12facb8f, Offset: 0x3a80
// Size: 0x3c
function function_7b3cac15() {
    self endon(#"death");
    self.var_3f80e7e8 = 0;
    while (true) {
        level waittill(#"between_round_over");
        self.var_3f80e7e8 = 0;
    }
}

// Namespace namespace_4c9147
// Params 1, eflags: 0x0
// Checksum 0x6f6ad853, Offset: 0x3ac8
// Size: 0x2ae
function function_e467fa8d(s_spawn_pos) {
    self endon(#"death");
    str_name = "power_soul" + self.script_int;
    s_struct = struct::get(str_name, "targetname");
    var_bb194a8c = 1;
    level thread namespace_c21dfba4::function_b55fb314(var_bb194a8c, s_struct.origin, -128, s_spawn_pos.origin, s_spawn_pos.angles);
    switch (level.var_eada0345) {
    case 0:
        function_779c1a49(s_spawn_pos, s_struct.origin);
        break;
    case 1:
        if (math::cointoss()) {
            function_779c1a49(s_spawn_pos, s_struct.origin);
        } else {
            function_f55d851b(s_spawn_pos, s_struct.origin);
        }
        break;
    case 2:
        n_random = randomint(1000);
        if (n_random <= 333) {
            function_b820d8(s_spawn_pos, s_struct.origin);
        } else {
            function_f55d851b(s_spawn_pos, s_struct.origin);
        }
        break;
    case 3:
    default:
        n_random = randomint(1000);
        if (n_random <= 333) {
            function_779c1a49(s_spawn_pos, s_struct.origin);
        } else if (n_random < 666) {
            function_b820d8(s_spawn_pos, s_struct.origin);
        } else {
            function_f55d851b(s_spawn_pos, s_struct.origin);
        }
        break;
    }
}

// Namespace namespace_4c9147
// Params 2, eflags: 0x0
// Checksum 0xbc024dfd, Offset: 0x3d80
// Size: 0x1ac
function function_779c1a49(s_spawn_pos, var_d24a63df) {
    var_ecb2c615 = namespace_c21dfba4::function_21bbe70d(s_spawn_pos.origin, s_spawn_pos.angles, 0);
    var_ecb2c615 ai::set_behavior_attribute("can_bamf", 0);
    var_ecb2c615 ai::set_behavior_attribute("can_juke", 0);
    var_ecb2c615.no_damage_points = 1;
    var_ecb2c615.deathpoints_already_given = 1;
    if (isdefined(var_ecb2c615)) {
        var_ecb2c615 endon(#"death");
        var_ecb2c615 function_da370997(var_d24a63df);
        wait(0.5);
        var_ecb2c615.zombie_think_done = 1;
        var_ecb2c615.no_powerups = 1;
        if (level.var_eada0345 == 0) {
            if (math::cointoss()) {
                var_ecb2c615 ai::set_behavior_attribute("move_speed", "walk");
            } else {
                var_ecb2c615 ai::set_behavior_attribute("move_speed", "run");
            }
            return;
        }
        var_ecb2c615 ai::set_behavior_attribute("move_speed", "run");
    }
}

// Namespace namespace_4c9147
// Params 3, eflags: 0x0
// Checksum 0x91c6c928, Offset: 0x3f38
// Size: 0xf4
function spawn_zombie(s_spawn_pos, var_d24a63df, var_eb452fee) {
    ai_zombie = zombie_utility::spawn_zombie(level.zombie_spawners[0], "power_zombie", s_spawn_pos);
    if (isdefined(ai_zombie)) {
        ai_zombie endon(#"death");
        ai_zombie function_da370997(var_d24a63df);
        ai_zombie.script_string = "find_flesh";
        ai_zombie waittill(#"completed_emerging_into_playable_area");
        ai_zombie.no_powerups = 1;
        ai_zombie zombie_utility::set_zombie_run_cycle("sprint");
        if (var_eb452fee) {
            ai_zombie namespace_57695b4d::function_1b1bb1b();
        }
    }
}

// Namespace namespace_4c9147
// Params 2, eflags: 0x0
// Checksum 0x61b47fb, Offset: 0x4038
// Size: 0x6c
function function_ee99f6ee(s_spawn_pos, var_d24a63df) {
    level.var_718361fb = namespace_35610d96::function_3f180afe();
    ai_zombie = namespace_27f8b154::function_f4bd92a2(1, s_spawn_pos);
    ai_zombie function_da370997(var_d24a63df);
}

// Namespace namespace_4c9147
// Params 2, eflags: 0x0
// Checksum 0x73597ee4, Offset: 0x40b0
// Size: 0x180
function function_f55d851b(s_spawn_pos, var_d24a63df) {
    var_d88e6f5f = spawnactor("spawner_zm_genesis_keeper", s_spawn_pos.origin, s_spawn_pos.angles, undefined, 1, 1);
    if (isdefined(var_d88e6f5f)) {
        var_d88e6f5f function_da370997(var_d24a63df);
        var_d88e6f5f endon(#"death");
        var_d88e6f5f.spawn_time = gettime();
        var_d88e6f5f.health = level.zombie_health;
        var_d88e6f5f.heroweapon_kill_power = 2;
        var_d88e6f5f.no_damage_points = 1;
        var_d88e6f5f.deathpoints_already_given = 1;
        level thread zm_spawner::zombie_death_event(var_d88e6f5f);
        var_d88e6f5f.voiceprefix = "keeper";
        var_d88e6f5f.animname = "keeper";
        var_d88e6f5f thread zm_spawner::play_ambient_zombie_vocals();
        var_d88e6f5f thread zm_audio::zmbaivox_notifyconvert();
        wait(1.3);
        var_d88e6f5f.zombie_think_done = 1;
    }
}

// Namespace namespace_4c9147
// Params 2, eflags: 0x0
// Checksum 0x8de07950, Offset: 0x4238
// Size: 0x118
function function_b820d8(s_spawn_pos, var_d24a63df) {
    var_e0a70843 = s_spawn_pos.origin;
    s_spawn_pos.origin = (s_spawn_pos.origin[0], s_spawn_pos.origin[1], s_spawn_pos.origin[2] + 70);
    var_dedf403c = namespace_3425d4b9::function_8aeb3564(1, s_spawn_pos, 32, 32, 1, 0, 1);
    if (isdefined(var_dedf403c)) {
        var_dedf403c.no_damage_points = 1;
        var_dedf403c.deathpoints_already_given = 1;
        var_dedf403c function_da370997(var_d24a63df);
    }
    s_spawn_pos.origin = var_e0a70843;
}

// Namespace namespace_4c9147
// Params 1, eflags: 0x0
// Checksum 0x5237147b, Offset: 0x4358
// Size: 0x40
function function_da370997(var_d24a63df) {
    self.health = level.zombie_health;
    self.var_17de041a = 1;
    self.no_powerups = 1;
    self.var_a6e673dd = var_d24a63df;
}

// Namespace namespace_4c9147
// Params 1, eflags: 0x0
// Checksum 0x617451b6, Offset: 0x43a0
// Size: 0x124
function function_9cc9b090(e_attacker) {
    if (isdefined(e_attacker) && isdefined(e_attacker.var_4d307aef)) {
        e_attacker.var_4d307aef++;
    }
    if (isdefined(e_attacker) && isdefined(e_attacker.var_8b5008fe)) {
        e_attacker.var_8b5008fe++;
    }
    if (isdefined(self.var_a6e673dd)) {
        level thread function_dfd0ecb2(self.origin + (0, 0, 60), self.angles, self.var_a6e673dd, 2);
    }
    if (isdefined(level.var_a6e673dd)) {
        level thread function_dfd0ecb2(self.origin + (0, 0, 60), self.angles, level.var_a6e673dd.origin, 2);
        level thread function_ca2ba8d0();
    }
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0xac33582c, Offset: 0x44d0
// Size: 0x20
function function_ca2ba8d0() {
    wait(2);
    level.var_40ffc71d += 1;
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0x55e0aab9, Offset: 0x44f8
// Size: 0x136
function get_spawn_delay() {
    n_delay = 1;
    a_players = getplayers();
    switch (a_players.size) {
    case 1:
        n_delay = randomfloatrange(1.4, 1.6);
        if (level.var_eada0345 == 0) {
            n_delay += 0.5;
        }
        break;
    case 2:
        n_delay = randomfloatrange(1.3, 1.4);
        break;
    case 3:
        n_delay = randomfloatrange(0.85, 1);
        break;
    case 4:
    default:
        n_delay = randomfloatrange(0.65, 0.75);
        break;
    }
    return n_delay;
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0xad3466d8, Offset: 0x4638
// Size: 0xec
function function_7d3242b1() {
    level flag::init("all_power_on");
    for (i = 1; i < 5; i++) {
        hidemiscmodels("apothicon_trap_power_on" + i);
        level thread function_578a47b0(i);
    }
    level flag::wait_till_all(array("power_on1", "power_on2", "power_on3", "power_on4"));
    level flag::set("all_power_on");
}

// Namespace namespace_4c9147
// Params 1, eflags: 0x0
// Checksum 0xcaf9d954, Offset: 0x4730
// Size: 0x6c
function function_578a47b0(var_7e0a45c8) {
    level flag::wait_till("power_on" + var_7e0a45c8);
    showmiscmodels("apothicon_trap_power_on" + var_7e0a45c8);
    hidemiscmodels("apothicon_trap_power_off" + var_7e0a45c8);
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0xe5c8a0a0, Offset: 0x47a8
// Size: 0xb2
function function_d5b54fdc() {
    level flag::wait_till("power_on");
    level flag::set("power_on1");
    level flag::set("power_on2");
    level flag::set("power_on3");
    level flag::set("power_on4");
    level notify(#"hash_fb60eed2");
}

// Namespace namespace_4c9147
// Params 1, eflags: 0x0
// Checksum 0xca5976c6, Offset: 0x4868
// Size: 0x144
function function_d93bc7dc(var_64e27e68) {
    self endon(#"death");
    switch (self.script_int) {
    case 1:
        var_6d1f1d11 = "fxexp_221";
        var_9885031b = "fxexp_224";
        break;
    case 2:
        var_6d1f1d11 = "fxexp_211";
        var_9885031b = "fxexp_214";
        break;
    case 3:
        var_6d1f1d11 = "fxexp_241";
        var_9885031b = "fxexp_244";
        break;
    case 4:
        var_6d1f1d11 = "fxexp_231";
        var_9885031b = "fxexp_234";
        break;
    }
    exploder::exploder(var_6d1f1d11);
    self util::waittill_any(self.var_8f4b8aaf, self.var_3c42ad63);
    exploder::stop_exploder(var_6d1f1d11);
    wait(1);
    exploder::exploder(var_9885031b);
}

// Namespace namespace_4c9147
// Params 0, eflags: 0x0
// Checksum 0xbe5d2886, Offset: 0x49b8
// Size: 0x102
function function_b780352b() {
    var_a0561c95 = getplayers();
    if (!(isdefined(self.var_17de041a) && self.var_17de041a)) {
        return var_a0561c95;
    }
    if (!isdefined(level.var_7b91fc17)) {
        return var_a0561c95;
    }
    a_closest = [];
    for (i = 0; i < var_a0561c95.size; i++) {
        e_player = var_a0561c95[i];
        if (zm_utility::is_player_valid(e_player) && e_player istouching(level.var_7b91fc17)) {
            a_closest[a_closest.size] = e_player;
        }
    }
    if (a_closest.size == 0) {
        return var_a0561c95;
    }
    return a_closest;
}

