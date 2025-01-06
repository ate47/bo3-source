#using scripts/codescripts/struct;
#using scripts/shared/aat_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;

#namespace zm_ai_raz;

// Namespace zm_ai_raz
// Params 0, eflags: 0x2
// Checksum 0x4b28842d, Offset: 0x550
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_ai_raz", &__init__, &__main__, undefined);
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x7ec096df, Offset: 0x598
// Size: 0x14
function __init__() {
    init();
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x56529fb6, Offset: 0x5b8
// Size: 0x44
function __main__() {
    register_clientfields();
    /#
        execdevgui("<dev string:x28>");
        thread function_fbcfe4b6();
    #/
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x608
// Size: 0x4
function register_clientfields() {
    
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x978ed1d9, Offset: 0x618
// Size: 0x1ec
function init() {
    zm::register_player_damage_callback(&function_94372a17);
    level.var_2e815d61 = 1;
    level.var_629d0743 = 0;
    level.var_d4fa016a = 1;
    level.var_b9ce6312 = 0;
    level.var_6bca5baa = [];
    level.var_f95eaac8 = 5500;
    zm_score::register_score_event("death_raz", &function_6fdcefe3);
    level flag::init("raz_round");
    level flag::init("raz_round_in_progress");
    level thread aat::register_immunity("zm_aat_blast_furnace", "raz", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_dead_wire", "raz", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_fire_works", "raz", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_thunder_wall", "raz", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_turned", "raz", 1, 1, 1);
    function_e099c556();
    level thread function_ff9b21c4();
}

// Namespace zm_ai_raz
// Params 5, eflags: 0x0
// Checksum 0x26f0e4ff, Offset: 0x810
// Size: 0x124
function function_6fdcefe3(str_event, str_mod, var_5afff096, var_48d0b2fe, var_2f7fd5db) {
    if (str_event === "death_raz") {
        var_1fdfc3ef = zm_score::function_b2baf1b5();
        var_2d175949 = self zm_score::player_add_points_kill_bonus(str_mod, var_5afff096, var_2f7fd5db);
        var_1fdfc3ef = (var_1fdfc3ef + var_2d175949) * 2;
        if (str_mod == "MOD_GRENADE" || str_mod == "MOD_GRENADE_SPLASH") {
            self zm_stats::increment_client_stat("grenade_kills");
            self zm_stats::increment_player_stat("grenade_kills");
        }
        scoreevents::processscoreevent("kill_raz", self, undefined, var_2f7fd5db);
        return var_1fdfc3ef;
    }
    return 0;
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x128a22b3, Offset: 0x940
// Size: 0x44
function function_7dfa7ca6() {
    level.var_629d0743 = 1;
    if (!isdefined(level.var_c810e243)) {
        level.var_c810e243 = &function_684ce0;
    }
    level thread [[ level.var_c810e243 ]]();
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x7f78b32b, Offset: 0x990
// Size: 0x11a
function function_e099c556() {
    level.var_6bca5baa = getentarray("zombie_raz_spawner", "script_noteworthy");
    if (level.var_6bca5baa.size == 0) {
        assertmsg("<dev string:x43>");
        return;
    }
    foreach (var_ad58b9ca in level.var_6bca5baa) {
        var_ad58b9ca.is_enabled = 1;
        var_ad58b9ca.script_forcespawn = 1;
        var_ad58b9ca spawner::add_spawn_function(&function_4749ab89);
    }
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x9b33bf7a, Offset: 0xab8
// Size: 0x50
function function_ff9b21c4() {
    /#
        level waittill(#"start_of_round");
        function_a67ada8();
    #/
    while (true) {
        level waittill(#"between_round_over");
        function_a67ada8();
    }
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x7d2b7d3a, Offset: 0xb10
// Size: 0x240
function function_684ce0() {
    level.var_d4fa016a = 1;
    level.var_51a5abd0 = randomintrange(5, 8);
    /#
        if (getdvarint("<dev string:x85>") > 0) {
            level.var_51a5abd0 = 5;
        }
    #/
    old_spawn_func = level.round_spawn_func;
    old_wait_func = level.round_wait_func;
    while (true) {
        level waittill(#"between_round_over");
        /#
            if (getdvarint("<dev string:x92>") > 0) {
                level.var_51a5abd0 = level.round_number;
            }
        #/
        if (level.round_number == level.var_51a5abd0) {
            level.var_1b7d7bb8 = 1;
            old_spawn_func = level.round_spawn_func;
            old_wait_func = level.round_wait_func;
            function_77ff30a0();
            level.round_spawn_func = &function_a33bc00f;
            level.round_wait_func = &function_692370a0;
            if (isdefined(level.var_95444cb4)) {
                level.var_51a5abd0 = [[ level.var_95444cb4 ]]();
            } else {
                level.var_51a5abd0 += randomintrange(5, 8);
            }
            /#
                getplayers()[0] iprintln("<dev string:x9c>" + level.var_51a5abd0);
            #/
            continue;
        }
        if (level flag::get("raz_round")) {
            function_783ab6ac();
            level.round_spawn_func = old_spawn_func;
            level.round_wait_func = old_wait_func;
            level.var_d4fa016a++;
        }
    }
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0xed463214, Offset: 0xd58
// Size: 0x7c
function function_77ff30a0() {
    level flag::set("raz_round");
    level flag::set("special_round");
    level.var_b9ce6312 = 1;
    level notify(#"hash_61c47438");
    level thread zm_audio::sndmusicsystem_playstate("raz_start");
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x8c6d8007, Offset: 0xde0
// Size: 0x5e
function function_783ab6ac() {
    level flag::clear("raz_round");
    level flag::clear("special_round");
    level.var_b9ce6312 = 0;
    level notify(#"hash_22aa6eed");
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0xed2e6c48, Offset: 0xe48
// Size: 0x2c0
function function_a33bc00f() {
    level endon(#"intermission");
    level endon(#"raz_round");
    level.var_bc3f44bf = getplayers();
    for (i = 0; i < level.var_bc3f44bf.size; i++) {
        level.var_bc3f44bf[i].hunted_by = 0;
    }
    level endon(#"restart_round");
    /#
        level endon(#"kill_round");
        if (getdvarint("<dev string:x85>") == 2 || getdvarint("<dev string:x85>") >= 4) {
            return;
        }
    #/
    if (level.intermission) {
        return;
    }
    array::thread_all(level.players, &function_bdf13070);
    var_4fc9044f = function_852019c2();
    function_a67ada8();
    level.zombie_total = int(var_4fc9044f);
    /#
        if (getdvarstring("<dev string:x92>") != "<dev string:xad>" && getdvarint("<dev string:x92>") > 0) {
            level.zombie_total = getdvarint("<dev string:x92>");
            setdvar("<dev string:x92>", 0);
        }
    #/
    wait 1;
    wait 6;
    var_c55cf881 = 0;
    level flag::set("raz_round_in_progress");
    level endon(#"last_ai_down");
    level thread function_25561504();
    while (true) {
        while (level.zombie_total > 0) {
            if (isdefined(level.bzm_worldpaused) && level.bzm_worldpaused) {
                util::wait_network_frame();
                continue;
            }
            function_45bace88();
            util::wait_network_frame();
        }
        util::wait_network_frame();
    }
}

// Namespace zm_ai_raz
// Params 2, eflags: 0x0
// Checksum 0xbb36e861, Offset: 0x1110
// Size: 0xa0
function function_665a13cd(spawner, s_spot) {
    var_a09c80cd = zombie_utility::spawn_zombie(level.var_6bca5baa[0], "raz", s_spot);
    if (isdefined(var_a09c80cd)) {
        var_a09c80cd.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
        var_a09c80cd thread zombie_utility::round_spawn_failsafe();
        var_a09c80cd thread function_b8671cc0(s_spot);
    }
    return var_a09c80cd;
}

// Namespace zm_ai_raz
// Params 1, eflags: 0x0
// Checksum 0x73307d7d, Offset: 0x11b8
// Size: 0x48
function function_b8671cc0(s_spot) {
    if (isdefined(level.var_71ab2462)) {
        self thread [[ level.var_71ab2462 ]](s_spot);
    }
    if (isdefined(level.var_ae95a175)) {
        self thread [[ level.var_ae95a175 ]]();
    }
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x937cfa31, Offset: 0x1208
// Size: 0x204
function function_45bace88() {
    while (!function_ea911683()) {
        wait 0.1;
    }
    s_spawn_loc = undefined;
    var_19764360 = get_favorite_enemy();
    if (!isdefined(var_19764360)) {
        wait randomfloatrange(0.333333, 0.666667);
        return;
    }
    if (isdefined(level.var_e80c1065)) {
        s_spawn_loc = [[ level.var_e80c1065 ]](var_19764360);
    } else {
        /#
            if (level.zm_loc_types["<dev string:xae>"].size == 0) {
                iprintlnbold("<dev string:xbb>");
            }
        #/
        s_spawn_loc = array::random(level.zm_loc_types["raz_location"]);
    }
    if (!isdefined(s_spawn_loc)) {
        wait randomfloatrange(0.333333, 0.666667);
        return;
    }
    ai = function_665a13cd(level.var_6bca5baa[0]);
    if (isdefined(ai)) {
        ai thread function_b8671cc0(s_spawn_loc);
        ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
        if (isdefined(var_19764360)) {
            ai.favoriteenemy = var_19764360;
            ai.favoriteenemy.hunted_by++;
        }
        level.zombie_total--;
        function_a74c2884();
    }
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x9a8ff8b, Offset: 0x1418
// Size: 0x86
function function_852019c2() {
    switch (level.players.size) {
    case 1:
        var_4fc9044f = 6;
        break;
    case 2:
        var_4fc9044f = 10;
        break;
    case 3:
        var_4fc9044f = 14;
        break;
    case 4:
    default:
        var_4fc9044f = 16;
        break;
    }
    return var_4fc9044f;
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x1e8870c6, Offset: 0x14a8
// Size: 0x88
function function_692370a0() {
    level endon(#"restart_round");
    /#
        level endon(#"kill_round");
    #/
    if (level flag::get("raz_round")) {
        level flag::wait_till("raz_round_in_progress");
        level flag::wait_till_clear("raz_round_in_progress");
    }
    level.var_1b7d7bb8 = 0;
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0xf4b64643, Offset: 0x1538
// Size: 0xd6
function function_a1d75eeb() {
    a_ai_raz = getentarray("zombie_raz", "targetname");
    var_c55cf881 = a_ai_raz.size;
    foreach (ai_raz in a_ai_raz) {
        if (!isalive(ai_raz)) {
            var_c55cf881--;
        }
    }
    return var_c55cf881;
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0xcda1bf95, Offset: 0x1618
// Size: 0x62
function function_bcbbda54() {
    switch (level.players.size) {
    case 1:
        return 2;
    case 2:
        return 3;
    case 3:
        return 4;
    case 4:
        return 4;
    }
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x2e506707, Offset: 0x1688
// Size: 0x78
function function_ea911683() {
    var_c55cf881 = function_a1d75eeb();
    var_f0ab435a = function_bcbbda54();
    if (var_c55cf881 >= var_f0ab435a || !level flag::get("spawn_zombies")) {
        return false;
    }
    return true;
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x262d82db, Offset: 0x1708
// Size: 0x88
function function_a74c2884() {
    switch (level.players.size) {
    case 1:
        n_default_wait = 2.25;
        break;
    case 2:
        n_default_wait = 1.75;
        break;
    case 3:
        n_default_wait = 1.25;
        break;
    default:
        n_default_wait = 0.75;
        break;
    }
    wait n_default_wait;
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x1b0a7eb7, Offset: 0x1798
// Size: 0x134
function function_25561504() {
    level waittill(#"last_ai_down", var_100f3800);
    level thread zm_audio::sndmusicsystem_playstate("raz_over");
    if (isdefined(level.var_716fc13e)) {
        [[ level.var_716fc13e ]](var_100f3800, level.var_6a6f912a);
    } else {
        var_4a50cb2a = level.var_6a6f912a;
        trace = groundtrace(var_4a50cb2a + (0, 0, 100), var_4a50cb2a + (0, 0, -1000), 0, undefined);
        var_4a50cb2a = trace["position"];
        if (isdefined(var_4a50cb2a)) {
            level thread zm_powerups::specific_powerup_drop("full_ammo", var_4a50cb2a);
        }
    }
    wait 2;
    level.var_1b7d7bb8 = 0;
    wait 6;
    level flag::clear("raz_round_in_progress");
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x9189e45f, Offset: 0x18d8
// Size: 0x150
function get_favorite_enemy() {
    var_bc3f44bf = getplayers();
    e_least_hunted = undefined;
    foreach (e_target in var_bc3f44bf) {
        if (!isdefined(e_target.hunted_by)) {
            e_target.hunted_by = 0;
        }
        if (!zm_utility::is_player_valid(e_target)) {
            continue;
        }
        if (isdefined(level.var_3fded92e) && ![[ level.var_3fded92e ]](e_target)) {
            continue;
        }
        if (!isdefined(e_least_hunted)) {
            e_least_hunted = e_target;
            continue;
        }
        if (e_target.hunted_by < e_least_hunted.hunted_by) {
            e_least_hunted = e_target;
        }
    }
    return e_least_hunted;
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x50af8ece, Offset: 0x1a30
// Size: 0x11c
function function_a67ada8() {
    level.var_f95eaac8 = 5500 + level.round_number * 100;
    if (level.var_f95eaac8 < 5500) {
        level.var_f95eaac8 = 5500;
    } else if (level.var_f95eaac8 > 15000) {
        level.var_f95eaac8 = 15000;
    }
    level.var_f95eaac8 = int(level.var_f95eaac8 * (1 + 0.15 * (level.players.size - 1)));
    level.var_52e55d88 = level.var_f95eaac8 * 0.15;
    level.var_1f5dd695 = level.var_f95eaac8 * 0.3;
    level.var_be1fdc52 = level.var_f95eaac8 * 0.25;
    level.var_87ab7c6e = level.var_f95eaac8 * 0.4;
    level.var_1b1e6d7b = level.var_f95eaac8 * 0.25;
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x164c9d33, Offset: 0x1b58
// Size: 0xb4
function function_bdf13070() {
    self playlocalsound("zmb_raz_round_start");
    variation_count = 5;
    wait 4.5;
    players = getplayers();
    num = randomintrange(0, players.size);
    players[num] zm_audio::create_and_play_dialog("general", "raz_spawn");
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x4b0dd4ec, Offset: 0x1c18
// Size: 0x2b0
function function_4749ab89() {
    self.targetname = "zombie_raz";
    self.script_noteworthy = undefined;
    self.animname = "zombie_raz";
    self.allowdeath = 1;
    self.allowpain = 1;
    self.force_gib = 1;
    self.is_zombie = 1;
    self.gibbed = 0;
    self.head_gibbed = 0;
    self.default_goalheight = 40;
    self.ignore_inert = 1;
    self.lightning_chain_immune = 1;
    self.holdfire = 1;
    self.grenadeawareness = 0;
    self.badplaceawareness = 0;
    self.ignoresuppression = 1;
    self.suppressionthreshold = 1;
    self.nododgemove = 1;
    self.dontshootwhilemoving = 1;
    self.pathenemylookahead = 0;
    self.chatinitialized = 0;
    self.missinglegs = 0;
    self.team = level.zombie_team;
    self.sword_kill_power = 4;
    self.instakill_func = &function_a59f11f9;
    self thread zombie_utility::zombie_eye_glow();
    if (isdefined(level.var_c7da0559)) {
        self.var_c3cb9d57 = level.var_c7da0559;
    }
    self.maxhealth = level.var_f95eaac8;
    if (isdefined(level.var_5a487977[self.archetype]) && level.var_5a487977[self.archetype].size > 0) {
        self.health = level.var_5a487977[self.archetype][0];
        arrayremovevalue(level.var_5a487977[self.archetype], level.var_5a487977[self.archetype][0]);
    } else {
        self.health = self.maxhealth;
    }
    self thread function_f8080b7();
    level thread zm_spawner::zombie_death_event(self);
    self thread zm_spawner::function_1612a0b8();
    self zm_spawner::zombie_history("zombie_raz_spawn_init -> Spawned = " + self.origin);
    if (isdefined(level.var_9aca36e2)) {
        self thread [[ level.var_9aca36e2 ]]();
    }
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x39f6a300, Offset: 0x1ed0
// Size: 0x1f4
function function_f8080b7() {
    self waittill(#"death", attacker);
    self thread zombie_utility::zombie_eye_glow_stop();
    if (function_a1d75eeb() == 0 && level.zombie_total == 0) {
        if (!isdefined(level.var_30b36b7b) || [[ level.var_30b36b7b ]]()) {
            level.var_6a6f912a = self.origin;
            level notify(#"last_ai_down", self);
        }
    }
    if (isplayer(attacker)) {
        if (!(isdefined(self.deathpoints_already_given) && self.deathpoints_already_given)) {
            attacker zm_score::player_add_points("death_raz", self.damagemod, self.damagelocation);
        }
        if (isdefined(level.hero_power_update)) {
            [[ level.hero_power_update ]](attacker, self);
        }
        attacker zm_audio::create_and_play_dialog("kill", "raz");
        attacker zm_stats::increment_client_stat("zraz_killed");
        attacker zm_stats::increment_player_stat("zraz_killed");
    }
    if (isdefined(attacker) && isai(attacker)) {
        attacker notify(#"killed", self);
    }
    if (isdefined(self)) {
        self stoploopsound();
        self thread function_b1f85217(self.origin);
    }
}

// Namespace zm_ai_raz
// Params 1, eflags: 0x0
// Checksum 0x7b764799, Offset: 0x20d0
// Size: 0xc
function function_b1f85217(origin) {
    
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0xf9b73238, Offset: 0x20e8
// Size: 0x54
function function_b4cd74ca() {
    self zm_spawner::zombie_history("zombie_setup_attack_properties()");
    self.ignoreall = 0;
    self.meleeattackdist = 64;
    self.disablearrivals = 1;
    self.disableexits = 1;
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0xb82979d6, Offset: 0x2148
// Size: 0x24
function function_7b5bfac6() {
    self waittill(#"death");
    self stopsounds();
}

// Namespace zm_ai_raz
// Params 4, eflags: 0x0
// Checksum 0x35ffac78, Offset: 0x2178
// Size: 0x2ac
function function_7ed6c714(n_to_spawn, var_e41e673a, b_force_spawn, var_b7959229) {
    if (!isdefined(n_to_spawn)) {
        n_to_spawn = 1;
    }
    if (!isdefined(b_force_spawn)) {
        b_force_spawn = 0;
    }
    if (!isdefined(var_b7959229)) {
        var_b7959229 = undefined;
    }
    n_spawned = 0;
    while (n_spawned < n_to_spawn) {
        if (!b_force_spawn && !function_ea911683()) {
            return n_spawned;
        }
        players = getplayers();
        var_19764360 = get_favorite_enemy();
        if (isdefined(var_b7959229)) {
            s_spawn_loc = var_b7959229;
        } else if (isdefined(level.var_a3559c05)) {
            s_spawn_loc = [[ level.var_a3559c05 ]](level.var_6bca5baa, var_19764360);
        } else if (level.zm_loc_types["raz_location"].size > 0) {
            s_spawn_loc = array::random(level.zm_loc_types["raz_location"]);
        }
        if (!isdefined(s_spawn_loc)) {
            return 0;
        }
        ai = function_665a13cd(level.var_6bca5baa[0]);
        if (isdefined(ai)) {
            ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
            ai.script_string = s_spawn_loc.script_string;
            ai.find_flesh_struct_string = ai.script_string;
            if (isdefined(var_19764360)) {
                ai.favoriteenemy = var_19764360;
                ai.favoriteenemy.hunted_by++;
            }
            n_spawned++;
            if (isdefined(var_e41e673a)) {
                ai thread [[ var_e41e673a ]]();
            }
            playsoundatposition("zmb_raz_spawn", s_spawn_loc.origin);
        }
        function_a74c2884();
    }
    return 1;
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x4529fdd9, Offset: 0x2430
// Size: 0x50
function function_175052a7() {
    self endon(#"death");
    while (true) {
        self playsound("zmb_hellhound_vocals_amb");
        wait randomfloatrange(3, 6);
    }
}

// Namespace zm_ai_raz
// Params 2, eflags: 0x0
// Checksum 0x652f53ac, Offset: 0x2488
// Size: 0x8c
function function_d1fed7c2(player, gib) {
    self endon(#"death");
    damage = int(self.maxhealth * 0.5);
    self dodamage(damage, player.origin, player, undefined, "none", "MOD_UNKNOWN");
}

// Namespace zm_ai_raz
// Params 10, eflags: 0x0
// Checksum 0xd5dd9ad7, Offset: 0x2520
// Size: 0x192
function function_94372a17(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime) {
    player = self;
    if (isdefined(attacker) && attacker.archetype === "raz" && mod === "MOD_PROJECTILE_SPLASH" && isdefined(weapon) && issubstr("raz_melee", weapon.name)) {
        dist_sq = distancesquared(attacker.origin, player.origin);
        var_bfa346a2 = 16384;
        damage_ratio = 1 - dist_sq / var_bfa346a2;
        var_2882f9d = 35;
        damage = var_2882f9d * damage_ratio;
        damage = int(damage);
        damage += 15;
        return damage;
    }
    return -1;
}

// Namespace zm_ai_raz
// Params 3, eflags: 0x0
// Checksum 0x9f3db170, Offset: 0x26c0
// Size: 0xdc
function function_a59f11f9(e_player, var_3ca8546d, var_9908b5f4) {
    if (var_9908b5f4 == "right_arm_lower" || var_9908b5f4 == "right_hand") {
        return 1;
    }
    if (var_9908b5f4 == "right_arm_upper" && self.var_827ce236 == 1) {
        self.var_52e55d88 = 1;
        self dodamage(1, e_player.origin, e_player, e_player, "right_arm_upper");
        return 1;
    }
    if (isdefined(self.var_e440b4d1) && self.var_e440b4d1) {
        return 1;
    }
    return 0;
}

/#

    // Namespace zm_ai_raz
    // Params 0, eflags: 0x0
    // Checksum 0x74c14e5e, Offset: 0x27a8
    // Size: 0x44
    function function_fbcfe4b6() {
        level flag::wait_till("<dev string:xdc>");
        zm_devgui::add_custom_devgui_callback(&function_3626e3d1);
    }

    // Namespace zm_ai_raz
    // Params 1, eflags: 0x0
    // Checksum 0x3154a13f, Offset: 0x27f8
    // Size: 0xce
    function function_3626e3d1(cmd) {
        switch (cmd) {
        case "<dev string:xf5>":
            function_39a724b1();
            break;
        case "<dev string:xff>":
            function_9a80ee5f();
            break;
        case "<dev string:x11b>":
            function_e115a394(getdvarint("<dev string:x125>"));
            break;
        case "<dev string:x134>":
            function_70864ef2(getdvarint("<dev string:x125>"));
            break;
        }
    }

    // Namespace zm_ai_raz
    // Params 0, eflags: 0x0
    // Checksum 0xf3a15ba5, Offset: 0x28d0
    // Size: 0x1d2
    function function_39a724b1() {
        player = level.players[0];
        v_direction = player getplayerangles();
        v_direction = anglestoforward(v_direction) * 8000;
        eye = player geteye();
        trace = bullettrace(eye, eye + v_direction, 0, undefined);
        var_feba5c63 = positionquery_source_navigation(trace["<dev string:x143>"], -128, 256, -128, 20);
        s_spot = spawnstruct();
        if (isdefined(var_feba5c63) && var_feba5c63.data.size > 0) {
            s_spot.origin = var_feba5c63.data[0].origin;
        } else {
            s_spot.origin = player.origin;
        }
        s_spot.angles = (0, player.angles[1] - -76, 0);
        function_7ed6c714(1, undefined, 1, s_spot);
        return 1;
    }

    // Namespace zm_ai_raz
    // Params 0, eflags: 0x0
    // Checksum 0x71388c7f, Offset: 0x2ab0
    // Size: 0x3a
    function function_9a80ee5f() {
        if (!(isdefined(level.var_4c5a7c47) && level.var_4c5a7c47)) {
            level.var_4c5a7c47 = 1;
            return;
        }
        level.var_4c5a7c47 = undefined;
    }

    // Namespace zm_ai_raz
    // Params 1, eflags: 0x0
    // Checksum 0xf8b90c2a, Offset: 0x2af8
    // Size: 0xa0
    function function_e115a394(var_eee0e63b) {
        if (!isdefined(level.var_2e815d61) || !level.var_2e815d61) {
            return;
        }
        if (!isdefined(level.var_629d0743) || !level.var_629d0743) {
            return;
        }
        if (!isdefined(level.var_6bca5baa) || level.var_6bca5baa.size < 1) {
            return;
        }
        function_d8afb0d4(var_eee0e63b);
        level.var_51a5abd0 = level.round_number + 1;
    }

    // Namespace zm_ai_raz
    // Params 1, eflags: 0x0
    // Checksum 0xad68602b, Offset: 0x2ba0
    // Size: 0x4c
    function function_70864ef2(var_eee0e63b) {
        if (isdefined(level.var_51a5abd0)) {
            function_d8afb0d4(var_eee0e63b);
            zm_devgui::zombie_devgui_goto_round(level.var_51a5abd0);
        }
    }

    // Namespace zm_ai_raz
    // Params 1, eflags: 0x0
    // Checksum 0x6ce71be8, Offset: 0x2bf8
    // Size: 0x6c
    function function_d8afb0d4(var_eee0e63b) {
        if (isdefined(var_eee0e63b) && var_eee0e63b > 0) {
            setdvar("<dev string:x92>", var_eee0e63b);
            return;
        }
        setdvar("<dev string:x92>", "<dev string:xad>");
    }

#/
