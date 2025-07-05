#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_quantum_bomb;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;

#namespace zm_weap_quantum_bomb;

// Namespace zm_weap_quantum_bomb
// Params 0, eflags: 0x2
// Checksum 0xdaf2b833, Offset: 0x718
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_weap_quantum_bomb", &__init__, undefined, undefined);
}

// Namespace zm_weap_quantum_bomb
// Params 0, eflags: 0x0
// Checksum 0x30e25d27, Offset: 0x758
// Size: 0x7c
function __init__() {
    level.quantum_bomb_register_result_func = &function_f2df781b;
    level.var_833bf1fd = &function_f94f76f0;
    level.var_2b504027 = &function_c5bcb16e;
    level.w_quantum_bomb = getweapon("quantum_bomb");
    init();
}

// Namespace zm_weap_quantum_bomb
// Params 0, eflags: 0x0
// Checksum 0x81e73f90, Offset: 0x7e0
// Size: 0x2cc
function init() {
    /#
        level.var_3cddfdc = &function_43dfe2f7;
    #/
    function_f2df781b("random_lethal_grenade", &function_aad5d1b5, 50);
    function_f2df781b("random_weapon_starburst", &function_5e612cf3, 75);
    function_f2df781b("pack_or_unpack_current_weapon", &function_209ed8d3, 10, &function_33303fa1);
    function_f2df781b("auto_revive", &function_c2ad867b, 60, &function_21454729);
    function_f2df781b("player_teleport", &function_c56f285f, 20);
    function_f2df781b("zombie_speed_buff", &function_747fd3f4, 2);
    function_f2df781b("zombie_add_to_total", &function_57011e91, 70, &function_ce0a1513);
    level._effect["zombie_fling_result"] = "dlc5/moon/fx_moon_qbomb_explo_distort";
    function_f2df781b("zombie_fling", &function_bab27d85);
    level._effect["quantum_bomb_viewmodel_twist"] = "dlc5/zmb_weapon/fx_twist";
    level._effect["quantum_bomb_viewmodel_press"] = "dlc5/zmb_weapon/fx_press";
    level._effect["quantum_bomb_area_effect"] = "dlc5/zmb_weapon/fx_area_effect";
    level._effect["quantum_bomb_player_effect"] = "dlc5/zmb_weapon/fx_player_effect";
    level._effect["quantum_bomb_player_position_effect"] = "dlc5/zmb_weapon/fx_player_position_effect";
    level._effect["quantum_bomb_mystery_effect"] = "dlc5/zmb_weapon/fx_mystery_effect";
    level.var_9acc1b55 = &function_30750878;
    level.var_e09b9d69 = &function_a2dcf424;
    level.var_a2cecae3 = &function_3bddb4f2;
    level.var_c5e1e17b = &function_e468bada;
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0x8ed76024, Offset: 0xab8
// Size: 0x44
function function_38e7d20(msg) {
    /#
        if (!getdvarint("<dev string:x28>")) {
            return;
        }
        iprintlnbold(msg);
    #/
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0xf8f23a85, Offset: 0xb08
// Size: 0x44
function function_50184bd3(msg) {
    /#
        if (!getdvarint("<dev string:x28>")) {
            return;
        }
        iprintlnbold(msg);
    #/
}

/#

    // Namespace zm_weap_quantum_bomb
    // Params 2, eflags: 0x0
    // Checksum 0x35dd8a68, Offset: 0xb58
    // Size: 0x8c
    function function_8fc8c893(msg, color) {
        if (!getdvarint("<dev string:x28>")) {
            return;
        }
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        print3d(self.origin + (0, 0, 60), msg, color, 1, 1, 40);
    }

#/

// Namespace zm_weap_quantum_bomb
// Params 4, eflags: 0x0
// Checksum 0xec7e7c30, Offset: 0xbf0
// Size: 0x15a
function function_f2df781b(name, result_func, chance, validation_func) {
    if (!isdefined(level.var_f8aafd4c)) {
        level.var_f8aafd4c = [];
    }
    if (isdefined(level.var_f8aafd4c[name])) {
        function_38e7d20("quantum_bomb_register_result(): '" + name + "' is already registered as a quantum bomb result.\n");
        return;
    }
    result = spawnstruct();
    result.name = name;
    result.result_func = result_func;
    if (!isdefined(chance)) {
        result.chance = 100;
    } else {
        result.chance = math::clamp(chance, 1, 100);
    }
    if (!isdefined(validation_func)) {
        result.validation_func = &function_771fa9cd;
    } else {
        result.validation_func = validation_func;
    }
    level.var_f8aafd4c[name] = result;
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0x2801f3b5, Offset: 0xd58
// Size: 0x6c
function function_f94f76f0(name) {
    if (!isdefined(level.var_f8aafd4c)) {
        level.var_f8aafd4c = [];
    }
    if (!isdefined(level.var_f8aafd4c[name])) {
        function_38e7d20("quantum_bomb_deregister_result(): '" + name + "' is not registered as a quantum bomb result.\n");
        return;
    }
    level.var_f8aafd4c[name] = undefined;
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0x8cf37f30, Offset: 0xdd0
// Size: 0x34
function function_30750878(position) {
    playfx(level._effect["quantum_bomb_area_effect"], position);
}

// Namespace zm_weap_quantum_bomb
// Params 0, eflags: 0x0
// Checksum 0x55443b79, Offset: 0xe10
// Size: 0x34
function function_a2dcf424() {
    playfxontag(level._effect["quantum_bomb_player_effect"], self, "tag_origin");
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0x1ed6ff0d, Offset: 0xe50
// Size: 0x34
function function_3bddb4f2(position) {
    playfx(level._effect["quantum_bomb_player_position_effect"], position);
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0x2cd50a4b, Offset: 0xe90
// Size: 0x34
function function_e468bada(position) {
    playfx(level._effect["quantum_bomb_mystery_effect"], position);
}

// Namespace zm_weap_quantum_bomb
// Params 0, eflags: 0x0
// Checksum 0xb9063a63, Offset: 0xed0
// Size: 0x16
function function_439bf2cd() {
    level.var_4375af8d = undefined;
    level.var_2c393010 = undefined;
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0xdf9bcdc4, Offset: 0xef0
// Size: 0x198
function function_edfec8be(position) {
    function_439bf2cd();
    /#
        var_ef89a210 = getdvarstring("<dev string:x3f>");
        if (var_ef89a210 != "<dev string:x5d>" && isdefined(level.var_f8aafd4c[var_ef89a210])) {
            return level.var_f8aafd4c[var_ef89a210];
        }
    #/
    var_a0bc5d5d = [];
    chance = randomint(100);
    keys = getarraykeys(level.var_f8aafd4c);
    for (i = 0; i < keys.size; i++) {
        result = level.var_f8aafd4c[keys[i]];
        if (result.chance > chance && self [[ result.validation_func ]](position)) {
            var_a0bc5d5d[var_a0bc5d5d.size] = result.name;
        }
    }
    return level.var_f8aafd4c[var_a0bc5d5d[randomint(var_a0bc5d5d.size)]];
}

// Namespace zm_weap_quantum_bomb
// Params 0, eflags: 0x0
// Checksum 0xd32aa7ca, Offset: 0x1090
// Size: 0x5c
function function_43dfe2f7() {
    self giveweapon(level.w_quantum_bomb);
    self zm_utility::set_player_tactical_grenade(level.w_quantum_bomb);
    self thread function_d6eb881c();
}

// Namespace zm_weap_quantum_bomb
// Params 0, eflags: 0x0
// Checksum 0x126e7c45, Offset: 0x10f8
// Size: 0x158
function function_d6eb881c() {
    self notify(#"hash_769d1dd2");
    self endon(#"disconnect");
    self endon(#"hash_769d1dd2");
    level endon(#"end_game");
    while (true) {
        grenade = self function_64f31ff1();
        if (isdefined(grenade)) {
            if (self laststand::player_is_in_laststand()) {
                grenade delete();
                continue;
            }
            grenade waittill(#"explode", position);
            playsoundatposition("wpn_quantum_exp", position);
            result = self function_edfec8be(position);
            self thread [[ result.result_func ]](position);
            function_50184bd3("quantum_bomb exploded at " + position + ", result: '" + result.name + "'.\n");
        }
        wait 0.05;
    }
}

// Namespace zm_weap_quantum_bomb
// Params 0, eflags: 0x0
// Checksum 0x9aaa88e8, Offset: 0x1258
// Size: 0x16
function function_60e1d81a() {
    return isdefined(level.zombie_weapons["quantum_bomb"]);
}

// Namespace zm_weap_quantum_bomb
// Params 0, eflags: 0x0
// Checksum 0x93d0bf86, Offset: 0x1278
// Size: 0x6c
function function_64f31ff1() {
    self endon(#"disconnect");
    self endon(#"hash_769d1dd2");
    while (true) {
        self waittill(#"grenade_fire", grenade, weapname);
        if (weapname == level.w_quantum_bomb) {
            return grenade;
        }
        wait 0.05;
    }
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0x90e2d0b6, Offset: 0x12f0
// Size: 0x10
function function_771fa9cd(position) {
    return true;
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0x590205c6, Offset: 0x1308
// Size: 0x4a
function function_f595292f(position) {
    if (!isdefined(level.var_2c393010)) {
        level.var_2c393010 = util::get_array_of_closest(position, zombie_utility::get_round_enemy_array());
    }
    return level.var_2c393010;
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0x75eed8ee, Offset: 0x1360
// Size: 0x3a
function function_20f748d8(position) {
    if (!isdefined(level.var_4375af8d)) {
        level.var_4375af8d = zm_utility::check_point_in_playable_area(position);
    }
    return level.var_4375af8d;
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0x4f51df2a, Offset: 0x13a8
// Size: 0x22
function function_c5bcb16e(position) {
    return function_20f748d8(position);
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0xac5a8a34, Offset: 0x13d8
// Size: 0xa4
function function_aad5d1b5(position) {
    self thread zm_audio::create_and_play_dialog("kill", "quant_good");
    a_keys = getarraykeys(level.var_b8a74746);
    self magicgrenadetype(level.var_b8a74746[a_keys[randomint(a_keys.size)]], position, (0, 0, 0), 0.35);
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0x210c017d, Offset: 0x1488
// Size: 0x80
function function_29e8b3fc(w_weapon) {
    if (w_weapon == level.weaponnone) {
        return true;
    }
    if (w_weapon.type == "projectile") {
        if (w_weapon.weapclass == "pistol" || w_weapon.weapclass == "pistol spread") {
            return false;
        }
        return true;
    }
    return false;
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0xe9ac8c50, Offset: 0x1510
// Size: 0x414
function function_5e612cf3(position) {
    self thread zm_audio::create_and_play_dialog("kill", "quant_good");
    /#
        var_6180515d = getdvarint("<dev string:x5e>");
        if (var_6180515d) {
            rand = var_6180515d;
        }
    #/
    var_4f64ee67 = [];
    var_dd341085 = getarraykeys(level.zombie_weapons);
    foreach (w_player in var_dd341085) {
        if (!w_player.ismeleeweapon && !w_player.isgrenadeweapon && !w_player.islauncher && !function_29e8b3fc(w_player)) {
            array::add(var_4f64ee67, w_player, 0);
        }
    }
    weapon = array::random(var_4f64ee67);
    var_46d0740e = zm_weapons::get_upgrade_weapon(weapon);
    if (!function_29e8b3fc(var_46d0740e)) {
        weapon = var_46d0740e;
    }
    println("<dev string:x86>" + weapon.name);
    function_3bddb4f2(position);
    var_6777f4f5 = position + (0, 0, 40);
    start_yaw = vectortoangles(var_6777f4f5 - self.origin);
    start_yaw = (0, start_yaw[1], 0);
    weapon_model = zm_utility::spawn_weapon_model(weapon, undefined, position, start_yaw);
    weapon_model moveto(var_6777f4f5, 1, 0.25, 0.25);
    weapon_model waittill(#"movedone");
    for (i = 0; i < 36; i++) {
        yaw = start_yaw + (randomintrange(-3, 3), i * 10, 0);
        weapon_model.angles = yaw;
        var_b9c4f76e = weapon_model gettagorigin("tag_flash");
        target_pos = var_b9c4f76e + vectorscale(anglestoforward(yaw), 40);
        magicbullet(weapon, var_b9c4f76e, target_pos, undefined);
        util::wait_network_frame();
    }
    weapon_model delete();
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0x1b2c46a3, Offset: 0x1930
// Size: 0xe4
function function_33303fa1(position) {
    if (!function_20f748d8(position)) {
        return false;
    }
    var_c7cfd72 = getentarray("specialty_weapupgrade", "script_noteworthy");
    range_squared = 32400;
    for (i = 0; i < var_c7cfd72.size; i++) {
        if (distancesquared(var_c7cfd72[i].origin, position) < range_squared) {
            return true;
        }
    }
    return !randomint(5);
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0x62a3113d, Offset: 0x1a20
// Size: 0x38e
function function_209ed8d3(position) {
    function_e468bada(position);
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (player.sessionstate == "spectator" || player laststand::player_is_in_laststand()) {
            continue;
        }
        weapon = player getcurrentweapon();
        if (!weapon.isprimary || !isdefined(level.zombie_weapons[weapon])) {
            continue;
        }
        if (zm_weapons::is_weapon_upgraded(weapon)) {
            if (randomint(5)) {
                continue;
            }
            var_f6f691ec = getarraykeys(level.zombie_weapons);
            for (weaponindex = 0; weaponindex < level.zombie_weapons.size; weaponindex++) {
                if (isdefined(level.zombie_weapons[var_f6f691ec[weaponindex]].upgrade_name) && level.zombie_weapons[var_f6f691ec[weaponindex]].upgrade_name == weapon) {
                    if (player == self) {
                        self thread zm_audio::create_and_play_dialog("kill", "quant_bad");
                    }
                    player thread zm_weapons::weapon_give(var_f6f691ec[weaponindex]);
                    player function_a2dcf424();
                    break;
                }
            }
            continue;
        }
        if (zm_weapons::can_upgrade_weapon(weapon)) {
            if (!randomint(4)) {
                continue;
            }
            weapon_limit = 2;
            if (player hasperk("specialty_additionalprimaryweapon")) {
                weapon_limit = 3;
            }
            primaries = player getweaponslistprimaries();
            if (isdefined(primaries) && primaries.size < weapon_limit) {
                player takeweapon(weapon);
            }
            if (player == self) {
                player thread zm_audio::create_and_play_dialog("kill", "quant_good");
            }
            player thread zm_weapons::weapon_give(level.zombie_weapons[weapon].upgrade);
            player function_a2dcf424();
        }
    }
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0xce50ba47, Offset: 0x1db8
// Size: 0xb0
function function_21454729(position) {
    if (level flag::get("solo_game")) {
        return false;
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (player laststand::player_is_in_laststand()) {
            return true;
        }
    }
    return false;
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0x70d4cf2c, Offset: 0x1e70
// Size: 0xde
function function_c2ad867b(position) {
    function_e468bada(position);
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (player laststand::player_is_in_laststand() && randomint(3)) {
            player zm_laststand::auto_revive(self);
            player function_a2dcf424();
        }
    }
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0xe75ef138, Offset: 0x1f58
// Size: 0x196
function function_c56f285f(position) {
    function_e468bada(position);
    players = getplayers();
    var_3ae5e627 = [];
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (player.sessionstate == "spectator" || player laststand::player_is_in_laststand()) {
            continue;
        }
        if (isdefined(level.var_4ac5afce) && player [[ level.var_4ac5afce ]](position)) {
            continue;
        }
        var_3ae5e627[var_3ae5e627.size] = player;
    }
    var_3ae5e627 = array::randomize(var_3ae5e627);
    for (i = 0; i < var_3ae5e627.size; i++) {
        player = var_3ae5e627[i];
        if (i && randomint(5)) {
            continue;
        }
        level thread function_76c682d1(player);
    }
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0xa277764b, Offset: 0x20f8
// Size: 0x194
function function_76c682d1(player) {
    var_3bc48314 = struct::get_array("struct_black_hole_teleport", "targetname");
    var_b9ca37a = undefined;
    if (isdefined(level.var_c9271e19)) {
        var_3bc48314 = [[ level.var_c9271e19 ]]();
    }
    var_846af699 = player zm_utility::get_current_zone();
    if (!isdefined(var_3bc48314) || var_3bc48314.size == 0 || !isdefined(var_846af699)) {
        return;
    }
    var_3bc48314 = array::randomize(var_3bc48314);
    if (isdefined(level.var_e608f920)) {
        var_b9ca37a = [[ level.var_e608f920 ]](var_3bc48314, player);
    } else {
        for (i = 0; i < var_3bc48314.size; i++) {
            if (var_3bc48314[i] zm_zonemgr::entity_in_active_zone() && var_846af699 != var_3bc48314[i].script_string) {
                var_b9ca37a = var_3bc48314[i];
                break;
            }
        }
    }
    if (isdefined(var_b9ca37a)) {
        player thread function_a2889ebb(var_b9ca37a);
    }
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0x9664512e, Offset: 0x2298
// Size: 0x284
function function_a2889ebb(var_ff042d85) {
    self endon(#"death");
    if (!isdefined(var_ff042d85)) {
        return;
    }
    prone_offset = (0, 0, 49);
    crouch_offset = (0, 0, 20);
    var_7cac5f2f = (0, 0, 0);
    destination = undefined;
    if (self getstance() == "prone") {
        destination = var_ff042d85.origin + prone_offset;
    } else if (self getstance() == "crouch") {
        destination = var_ff042d85.origin + crouch_offset;
    } else {
        destination = var_ff042d85.origin + var_7cac5f2f;
    }
    if (isdefined(level.var_563d5383)) {
        level [[ level.var_563d5383 ]](self);
    }
    function_3bddb4f2(self.origin);
    self freezecontrols(1);
    self disableoffhandweapons();
    self disableweapons();
    self playsoundtoplayer("zmb_gersh_teleporter_go_2d", self);
    self dontinterpolate();
    self setorigin(destination);
    self setplayerangles(var_ff042d85.angles);
    self enableoffhandweapons();
    self enableweapons();
    self freezecontrols(0);
    self function_a2dcf424();
    self thread function_b980d19b();
}

// Namespace zm_weap_quantum_bomb
// Params 0, eflags: 0x0
// Checksum 0x4ef43eab, Offset: 0x2528
// Size: 0x2c
function function_b980d19b() {
    wait 1;
    self zm_audio::create_and_play_dialog("general", "teleport_gersh");
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0x78128dc, Offset: 0x2560
// Size: 0x196
function function_747fd3f4(position) {
    function_e468bada(position);
    self thread zm_audio::create_and_play_dialog("kill", "quant_bad");
    zombies = function_f595292f(position);
    for (i = 0; i < zombies.size; i++) {
        zombie = zombies[i];
        if (isdefined(zombie.var_1562ef49)) {
            var_efce1376 = zombie [[ zombie.var_1562ef49 ]]();
        } else if (isdefined(zombie.var_98905394) && zombie.var_98905394) {
            if (zombie.missinglegs) {
                var_efce1376 = "crawl_low_g_super_sprint";
            } else {
                var_efce1376 = "low_g_super_sprint";
            }
        } else if (zombie.missinglegs) {
            var_efce1376 = "crawl_super_sprint";
        }
        if (zombie.isdog) {
            continue;
        }
        zombie zombie_utility::set_zombie_run_cycle("super_sprint");
    }
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0x9a08eb4, Offset: 0x2700
// Size: 0x276
function function_bab27d85(position) {
    playfx(level._effect["zombie_fling_result"], position);
    self thread zm_audio::create_and_play_dialog("kill", "quant_good");
    range = 300;
    range_squared = range * range;
    zombies = function_f595292f(position);
    for (i = 0; i < zombies.size; i++) {
        zombie = zombies[i];
        if (!isdefined(zombie) || !isalive(zombie)) {
            continue;
        }
        test_origin = zombie.origin + (0, 0, 40);
        var_e33ee590 = distancesquared(position, test_origin);
        if (var_e33ee590 > range_squared) {
            break;
        }
        dist_mult = (range_squared - var_e33ee590) / range_squared;
        fling_vec = vectornormalize(test_origin - position);
        fling_vec = (fling_vec[0], fling_vec[1], abs(fling_vec[2]));
        fling_vec = vectorscale(fling_vec, 100 + 100 * dist_mult);
        zombie function_8913b6e9(self, fling_vec);
        if (i && !(i % 10)) {
            util::wait_network_frame();
            util::wait_network_frame();
            util::wait_network_frame();
        }
    }
}

// Namespace zm_weap_quantum_bomb
// Params 2, eflags: 0x0
// Checksum 0xaed1575a, Offset: 0x2980
// Size: 0xbc
function function_8913b6e9(player, fling_vec) {
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    self dodamage(self.health + 666, player.origin, player, player, 0, "MOD_UNKNOWN", 0, level.w_quantum_bomb);
    if (self.health <= 0) {
        self startragdoll();
        self launchragdoll(fling_vec);
    }
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0x87932d93, Offset: 0x2a48
// Size: 0x50
function function_ce0a1513(position) {
    if (level.zombie_total) {
        return false;
    }
    zombies = function_f595292f(position);
    return zombies.size < level.zombie_ai_limit;
}

// Namespace zm_weap_quantum_bomb
// Params 1, eflags: 0x0
// Checksum 0xc3e35d6e, Offset: 0x2aa0
// Size: 0x64
function function_57011e91(position) {
    function_e468bada(position);
    self thread zm_audio::create_and_play_dialog("kill", "quant_bad");
    level.zombie_total += level.zombie_ai_limit;
}

// Namespace zm_weap_quantum_bomb
// Params 0, eflags: 0x0
// Checksum 0xe897a9ea, Offset: 0x2b10
// Size: 0x176
function function_61f28336() {
    level.var_f8aafd4c["player_teleport"] = undefined;
    origin = self.origin;
    while (isdefined(self)) {
        direction = self getplayerangles();
        direction_vec = anglestoforward(direction);
        eye = self geteye();
        scale = 8000;
        direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
        trace = bullettrace(eye, eye + direction_vec, 0, undefined);
        if (isdefined(trace["position"])) {
            origin = trace["position"];
        }
        result = self function_edfec8be(origin);
        self thread [[ result.result_func ]](origin);
        wait 5;
    }
}

