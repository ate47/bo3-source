#using scripts/mp/gametypes/_loadout;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/_challenges;
#using scripts/mp/_util;
#using scripts/shared/weapons/_weapon_utils;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/drown;
#using scripts/shared/challenges_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace contracts;

// Namespace contracts
// Params 0, eflags: 0x2
// Checksum 0x3249040e, Offset: 0x6a0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("contracts", &__init__, undefined, undefined);
}

// Namespace contracts
// Params 0, eflags: 0x1 linked
// Checksum 0x850aaa27, Offset: 0x6e0
// Size: 0x3c
function __init__() {
    callback::on_start_gametype(&start_gametype);
    /#
        level thread watch_contract_debug();
    #/
}

// Namespace contracts
// Params 0, eflags: 0x1 linked
// Checksum 0x89aa1d43, Offset: 0x728
// Size: 0x2a4
function start_gametype() {
    if (!isdefined(level.challengescallbacks)) {
        level.challengescallbacks = [];
    }
    util::init_player_contract_events();
    waittillframeend();
    if (can_process_contracts()) {
        /#
            execdevgui("killed_hero_ability_enemy");
        #/
        challenges::registerchallengescallback("playerKilled", &contract_kills);
        challenges::registerchallengescallback("gameEnd", &function_ed438349);
        globallogic_score::registercontractwinevent(&contract_win);
        scoreevents::register_hero_ability_kill_event(&on_hero_ability_kill);
        scoreevents::register_hero_ability_multikill_event(&function_40a4d808);
        scoreevents::register_hero_weapon_multikill_event(&function_a997af9a);
        util::register_player_contract_event("score", &on_player_score, 1);
        util::register_player_contract_event("killstreak_score", &function_2ef87fc8, 2);
        util::register_player_contract_event("offender_kill", &function_88a1d86d);
        util::register_player_contract_event("defender_kill", &function_f14de7eb);
        util::register_player_contract_event("headshot", &on_headshot_kill);
        util::register_player_contract_event("killed_hero_ability_enemy", &function_f4746d43);
        util::register_player_contract_event("killed_hero_weapon_enemy", &function_62a41cad);
        util::register_player_contract_event("earned_specialist_ability_medal", &function_97ca91fe);
    }
    callback::on_connect(&on_player_connect);
}

// Namespace contracts
// Params 0, eflags: 0x1 linked
// Checksum 0xa83d543f, Offset: 0x9d8
// Size: 0x1c
function function_f4746d43() {
    self function_159cc09f(1014);
}

// Namespace contracts
// Params 0, eflags: 0x1 linked
// Checksum 0x130e2875, Offset: 0xa00
// Size: 0x1c
function function_62a41cad() {
    self function_159cc09f(1014);
}

// Namespace contracts
// Params 0, eflags: 0x1 linked
// Checksum 0x6ed1c92c, Offset: 0xa28
// Size: 0x3c
function on_player_connect() {
    player = self;
    if (can_process_contracts()) {
        player setup_player_contracts();
    }
}

// Namespace contracts
// Params 0, eflags: 0x1 linked
// Checksum 0x160bbed6, Offset: 0xa70
// Size: 0x42
function can_process_contracts() {
    if (getdvarint("contracts_enabled_mp", 1) == 0) {
        return 0;
    }
    return challenges::canprocesschallenges();
}

// Namespace contracts
// Params 0, eflags: 0x1 linked
// Checksum 0xb6c88943, Offset: 0xac0
// Size: 0x2b2
function setup_player_contracts() {
    player = self;
    player.pers["contracts"] = [];
    if (player util::is_bot()) {
        return;
    }
    for (slot = 0; slot < 10; slot++) {
        if (get_contract_stat(slot, "active") && !get_contract_stat(slot, "award_given")) {
            var_62d51442 = get_contract_stat(slot, "index");
            player.pers["contracts"][var_62d51442] = spawnstruct();
            player.pers["contracts"][var_62d51442].slot = slot;
            var_63cc7b72 = tablelookuprownum("gamedata/tables/mp/mp_contractTable.csv", 0, var_62d51442);
            player.pers["contracts"][var_62d51442].var_63cc7b72 = var_63cc7b72;
            player.pers["contracts"][var_62d51442].target_value = int(tablelookupcolumnforrow("gamedata/tables/mp/mp_contractTable.csv", var_63cc7b72, 2));
            player.pers["contracts"][var_62d51442].var_68236ba5 = tablelookupcolumnforrow("gamedata/tables/mp/mp_contractTable.csv", var_63cc7b72, 7);
            player.pers["contracts"][var_62d51442].var_5997074d = tablelookupcolumnforrow("gamedata/tables/mp/mp_contractTable.csv", var_63cc7b72, 8);
            player.pers["contracts"][var_62d51442].var_21b1fd57 = tablelookupcolumnforrow("gamedata/tables/mp/mp_contractTable.csv", var_63cc7b72, 9);
        }
    }
}

/#

    // Namespace contracts
    // Params 0, eflags: 0x1 linked
    // Checksum 0x7858d105, Offset: 0xd80
    // Size: 0x658
    function watch_contract_debug() {
        level notify(#"watch_contract_debug_singleton");
        level endon(#"watch_contract_debug_singleton");
        level endon(#"game_ended");
        while (true) {
            if (getdvarint("killed_hero_ability_enemy") > 0) {
                if (isdefined(level.players)) {
                    new_index = getdvarint("killed_hero_ability_enemy", 0);
                    foreach (player in level.players) {
                        if (!isdefined(player)) {
                            continue;
                        }
                        if (player util::is_bot()) {
                            continue;
                        }
                        for (slot = 0; slot < 10; slot++) {
                            player function_4596db81(slot, "killed_hero_ability_enemy", 0);
                        }
                        iprintln("killed_hero_ability_enemy" + player.name);
                        player setup_player_contracts();
                    }
                }
                setdvar("killed_hero_ability_enemy", 0);
            }
            if (getdvarint("killed_hero_ability_enemy", 0) > 0) {
                if (isdefined(level.players)) {
                    new_index = getdvarint("killed_hero_ability_enemy", 0);
                    foreach (player in level.players) {
                        if (!isdefined(player)) {
                            continue;
                        }
                        if (player util::is_bot()) {
                            continue;
                        }
                        var_593adc20 = getdvarint("killed_hero_ability_enemy", 9);
                        player function_4596db81(var_593adc20, "killed_hero_ability_enemy", 1);
                        player function_4596db81(var_593adc20, "killed_hero_ability_enemy", new_index);
                        player function_4596db81(var_593adc20, "killed_hero_ability_enemy", 0);
                        player function_4596db81(var_593adc20, "killed_hero_ability_enemy", 0);
                        player setup_player_contracts();
                        iprintln("killed_hero_ability_enemy" + var_593adc20 + "killed_hero_ability_enemy" + new_index + "killed_hero_ability_enemy" + player.name + "killed_hero_ability_enemy");
                    }
                }
                setdvar("killed_hero_ability_enemy", 0);
            }
            if (getdvarint("killed_hero_ability_enemy", 0) > 0) {
                if (isdefined(level.players)) {
                    var_593adc20 = getdvarint("killed_hero_ability_enemy", 9);
                    iprintln("killed_hero_ability_enemy");
                    foreach (player in level.players) {
                        if (!isdefined(player)) {
                            continue;
                        }
                        if (player util::is_bot()) {
                            continue;
                        }
                        if (var_593adc20 >= 3) {
                            player function_4596db81(var_593adc20, "killed_hero_ability_enemy", 0);
                            player setup_player_contracts();
                            iprintln("killed_hero_ability_enemy" + var_593adc20 + "killed_hero_ability_enemy" + player.name);
                            continue;
                        }
                        iprintln("killed_hero_ability_enemy" + var_593adc20 + "killed_hero_ability_enemy" + player.name);
                    }
                }
                setdvar("killed_hero_ability_enemy", 0);
            }
            if (getdvarint("killed_hero_ability_enemy", 0) > 0) {
                iprintln("killed_hero_ability_enemy");
                setdvar("killed_hero_ability_enemy", 0);
            }
            if (getdvarint("killed_hero_ability_enemy", 0) > 0) {
                iprintln("killed_hero_ability_enemy");
                setdvar("killed_hero_ability_enemy", 0);
            }
            wait(0.5);
        }
    }

#/

// Namespace contracts
// Params 1, eflags: 0x1 linked
// Checksum 0x7f21c2af, Offset: 0x13e0
// Size: 0x98
function is_contract_active(challenge_index) {
    if (!isplayer(self)) {
        return false;
    }
    if (!isdefined(self.pers["contracts"])) {
        return false;
    }
    if (!isdefined(self.pers["contracts"][challenge_index])) {
        return false;
    }
    if (self.pers["contracts"][challenge_index].var_63cc7b72 == -1) {
        return false;
    }
    return true;
}

// Namespace contracts
// Params 2, eflags: 0x1 linked
// Checksum 0xeff8a2d9, Offset: 0x1480
// Size: 0x4a
function on_hero_ability_kill(ability, victimability) {
    player = self;
    if (!isdefined(player) || !isplayer(player)) {
        return;
    }
}

// Namespace contracts
// Params 0, eflags: 0x1 linked
// Checksum 0xab2a75b7, Offset: 0x14d8
// Size: 0x6c
function function_97ca91fe() {
    player = self;
    if (!isdefined(player) || !isplayer(player)) {
        return;
    }
    player function_159cc09f(1013);
    player function_159cc09f(3);
}

// Namespace contracts
// Params 2, eflags: 0x1 linked
// Checksum 0x807d2e7c, Offset: 0x1550
// Size: 0x4a
function function_40a4d808(killcount, ability) {
    player = self;
    if (!isdefined(player) || !isplayer(player)) {
        return;
    }
}

// Namespace contracts
// Params 2, eflags: 0x1 linked
// Checksum 0xbd1cce6, Offset: 0x15a8
// Size: 0x4a
function function_a997af9a(killcount, weapon) {
    player = self;
    if (!isdefined(player) || !isplayer(player)) {
        return;
    }
}

// Namespace contracts
// Params 1, eflags: 0x1 linked
// Checksum 0xa516d792, Offset: 0x1600
// Size: 0x4c
function on_player_score(delta_score) {
    self function_159cc09f(1009, delta_score);
    self function_159cc09f(5, delta_score);
}

// Namespace contracts
// Params 2, eflags: 0x1 linked
// Checksum 0x3e45fbfe, Offset: 0x1658
// Size: 0x3c
function function_2ef87fc8(delta_score, var_19f0ea25) {
    if (var_19f0ea25) {
        self function_159cc09f(1011, delta_score);
    }
}

// Namespace contracts
// Params 1, eflags: 0x1 linked
// Checksum 0x63ef2311, Offset: 0x16a0
// Size: 0x474
function contract_kills(data) {
    victim = data.victim;
    attacker = data.attacker;
    player = attacker;
    weapon = data.weapon;
    time = data.time;
    if (!isdefined(weapon) || weapon == level.weaponnone) {
        return;
    }
    if (!isdefined(player) || !isplayer(player)) {
        return;
    }
    player function_159cc09f(1015);
    player function_159cc09f(4);
    if (weapon.isheroweapon === 1) {
        player function_159cc09f(1012);
        player function_159cc09f(7);
        player function_159cc09f(3006);
    }
    iskillstreak = isdefined(data.einflictor) && isdefined(data.einflictor.killstreakid);
    if (!iskillstreak && isdefined(level.iskillstreakweapon)) {
        iskillstreakweapon = [[ level.iskillstreakweapon ]](weapon);
    }
    if (iskillstreak || iskillstreakweapon === 1) {
        player function_159cc09f(1010);
        player function_159cc09f(8);
    }
    var_aedadde = weapon.statindex;
    if (player isitempurchased(var_aedadde)) {
        weaponclass = util::getweaponclass(weapon);
        switch (weaponclass) {
        case 16:
            player function_159cc09f(1019);
            player function_159cc09f(3001);
            break;
        case 21:
            player function_159cc09f(1020);
            player function_159cc09f(3000);
            break;
        case 22:
            player function_159cc09f(1021);
            player function_159cc09f(3004);
            break;
        case 19:
            player function_159cc09f(1022);
            player function_159cc09f(3003);
            break;
        case 17:
            player function_159cc09f(1023);
            player function_159cc09f(3002);
            break;
        case 20:
            player function_159cc09f(1024);
            break;
        case 18:
            player function_159cc09f(3005);
            break;
        default:
            break;
        }
        var_ae1dbd9f = player gettotalunlockedweaponattachments(weapon);
        if (var_ae1dbd9f >= 4) {
            player function_159cc09f(1025);
        }
    }
}

// Namespace contracts
// Params 2, eflags: 0x1 linked
// Checksum 0x42b9b06f, Offset: 0x1b20
// Size: 0x4c
function function_159cc09f(var_62d51442, delta) {
    if (self is_contract_active(var_62d51442)) {
        self function_393b42c0(var_62d51442, delta);
    }
}

// Namespace contracts
// Params 2, eflags: 0x1 linked
// Checksum 0x2f24c64f, Offset: 0x1b78
// Size: 0x5fc
function function_393b42c0(var_62d51442, delta) {
    if (!isdefined(delta)) {
        delta = 1;
    }
    slot = self.pers["contracts"][var_62d51442].slot;
    target_value = self.pers["contracts"][var_62d51442].target_value;
    /#
        if (getdvarint("killed_hero_ability_enemy", 0) > 0) {
            delta *= getdvarint("killed_hero_ability_enemy", 1);
        }
    #/
    old_progress = get_contract_stat(slot, "progress");
    new_progress = old_progress + delta;
    if (new_progress > target_value) {
        new_progress = target_value;
    }
    if (new_progress != old_progress) {
        self function_4596db81(slot, "progress", new_progress);
    }
    var_24119685 = 0;
    if (old_progress < target_value && target_value <= new_progress) {
        var_24119685 = 1;
        event = %mp_weekly_challenge_complete;
        var_4836ff5c = 0;
        if (slot == 2) {
            event = %mp_daily_challenge_complete;
            var_4836ff5c = 1;
            self function_7f3b8f93(function_8020225b());
            self function_4596db81(2, "award_given", 1);
        } else if (slot == 0 || slot == 1) {
            var_33bbd9b0 = 1;
            if (slot == 1) {
                var_33bbd9b0 = 0;
            }
            foreach (var_38be1b03 in self.pers["contracts"]) {
                if (var_38be1b03.slot == var_33bbd9b0) {
                    if (var_38be1b03.target_value <= get_contract_stat(var_33bbd9b0, "progress")) {
                        var_4836ff5c = 1;
                        self function_7f3b8f93(function_ad00e83());
                        self function_4596db81(0, "award_given", 1);
                        self function_4596db81(1, "award_given", 1);
                    }
                    break;
                }
            }
        } else if (slot == 3) {
            event = %mp_special_contract_complete;
            var_4836ff5c = 1;
            var_21b1fd57 = self.pers["contracts"][var_62d51442].var_21b1fd57;
            if (var_21b1fd57 != "") {
                function_5e31a160(var_21b1fd57, 1);
            }
            var_68236ba5 = self.pers["contracts"][var_62d51442].var_68236ba5;
            if (var_68236ba5 != "") {
                function_76382237("calling_card", var_68236ba5);
            }
            var_5997074d = self.pers["contracts"][var_62d51442].var_5997074d;
            if (var_5997074d != "") {
                function_76382237("weapon_camo", var_5997074d);
            }
            self function_4596db81(3, "award_given", 1);
        }
        /#
            var_593adc20 = getdvarint("killed_hero_ability_enemy", 9);
            if (slot == var_593adc20) {
                if (var_62d51442 >= 1000 && var_62d51442 <= 2999) {
                    event = %killed_hero_ability_enemy;
                }
                var_4836ff5c = 1;
            }
        #/
        self luinotifyevent(event, 2, var_62d51442, var_4836ff5c);
    }
    /#
        if (getdvarint("killed_hero_ability_enemy", 0) > 0) {
            iprintln("killed_hero_ability_enemy" + slot + "killed_hero_ability_enemy" + var_62d51442 + "killed_hero_ability_enemy" + new_progress + "killed_hero_ability_enemy" + target_value);
        }
    #/
}

// Namespace contracts
// Params 2, eflags: 0x1 linked
// Checksum 0xafab6906, Offset: 0x2180
// Size: 0x3a
function get_contract_stat(slot, stat_name) {
    return self getdstat("contracts", slot, stat_name);
}

// Namespace contracts
// Params 3, eflags: 0x1 linked
// Checksum 0xaaced76d, Offset: 0x21c8
// Size: 0x42
function function_4596db81(slot, stat_name, stat_value) {
    return self setdstat("contracts", slot, stat_name, stat_value);
}

// Namespace contracts
// Params 3, eflags: 0x1 linked
// Checksum 0x3fc6fe7a, Offset: 0x2218
// Size: 0x4a
function function_76382237(var_85b07493, stat_name, stat_value) {
    if (!isdefined(stat_value)) {
        stat_value = 1;
    }
    return self addplayerstat(stat_name, stat_value);
}

// Namespace contracts
// Params 2, eflags: 0x1 linked
// Checksum 0xa578165b, Offset: 0x2270
// Size: 0x36e
function function_5e31a160(var_f059acbf, stat_value) {
    var_9a7d7935 = strtok(var_f059acbf, " ");
    var_c197d1f4 = "";
    var_339f412f = "";
    var_d9cc6c6 = "";
    var_4f9062b9 = "";
    var_298de850 = "";
    switch (var_9a7d7935.size) {
    case 5:
        var_298de850 = var_9a7d7935[4];
        if (strisnumber(var_298de850)) {
            var_298de850 = int(var_298de850);
        }
    case 4:
        var_4f9062b9 = var_9a7d7935[3];
        if (strisnumber(var_4f9062b9)) {
            var_4f9062b9 = int(var_4f9062b9);
        }
    case 3:
        var_d9cc6c6 = var_9a7d7935[2];
        if (strisnumber(var_d9cc6c6)) {
            var_d9cc6c6 = int(var_d9cc6c6);
        }
    case 2:
        var_339f412f = var_9a7d7935[1];
        if (strisnumber(var_339f412f)) {
            var_339f412f = int(var_339f412f);
        }
    case 1:
        var_c197d1f4 = var_9a7d7935[0];
        if (strisnumber(var_c197d1f4)) {
            var_c197d1f4 = int(var_c197d1f4);
        }
        break;
    }
    switch (var_9a7d7935.size) {
    case 1:
        return self setdstat(var_c197d1f4, stat_value);
    case 2:
        return self setdstat(var_c197d1f4, var_339f412f, stat_value);
    case 3:
        return self setdstat(var_c197d1f4, var_339f412f, var_d9cc6c6, stat_value);
    case 4:
        return self setdstat(var_c197d1f4, var_339f412f, var_d9cc6c6, var_4f9062b9, stat_value);
    case 5:
        return self setdstat(var_c197d1f4, var_339f412f, var_d9cc6c6, var_4f9062b9, var_298de850, stat_value);
    default:
        assertmsg("killed_hero_ability_enemy" + var_9a7d7935.size + "killed_hero_ability_enemy");
        break;
    }
}

// Namespace contracts
// Params 1, eflags: 0x1 linked
// Checksum 0xf17a2e27, Offset: 0x25e8
// Size: 0xac
function function_7f3b8f93(amount) {
    if (!isdefined(self)) {
        return;
    }
    if (amount <= 0) {
        return;
    }
    var_9d42efd3 = isdefined(self getdstat("mp_loot_xp_due")) ? self getdstat("mp_loot_xp_due") : 0;
    var_4a2e7664 = var_9d42efd3 + amount;
    self setdstat("mp_loot_xp_due", var_4a2e7664);
}

// Namespace contracts
// Params 2, eflags: 0x0
// Checksum 0x982bdd84, Offset: 0x26a0
// Size: 0x14e
function get_hero_weapon_mask(attacker, weapon) {
    if (!isdefined(weapon)) {
        return 0;
    }
    if (isdefined(weapon.isheroweapon) && !weapon.isheroweapon) {
        return 0;
    }
    switch (weapon.name) {
    case 44:
    case 45:
        return 1;
    case 40:
        return 2;
    case 42:
    case 43:
        return 4;
    case 38:
    case 39:
        return 8;
    case 46:
    case 47:
        return 16;
    case 33:
        return 32;
    case 34:
    case 35:
    case 36:
    case 37:
        return 64;
    case 41:
        return -128;
    case 32:
        return 256;
    default:
        return 0;
    }
}

// Namespace contracts
// Params 1, eflags: 0x0
// Checksum 0x9a4837af, Offset: 0x27f8
// Size: 0xe2
function get_hero_ability_mask(ability) {
    if (!isdefined(ability)) {
        return 0;
    }
    switch (ability.name) {
    case 50:
        return 1;
    case 53:
        return 2;
    case 52:
        return 4;
    case 54:
        return 8;
    case 48:
        return 16;
    case 49:
        return 32;
    case 56:
        return 64;
    case 55:
        return -128;
    case 51:
        return 256;
    default:
        return 0;
    }
}

// Namespace contracts
// Params 1, eflags: 0x1 linked
// Checksum 0x46c035a5, Offset: 0x28e8
// Size: 0xc
function function_ed438349(data) {
    
}

// Namespace contracts
// Params 1, eflags: 0x1 linked
// Checksum 0xe8179616, Offset: 0x2900
// Size: 0x2cc
function contract_win(winner) {
    winner function_159cc09f(1000);
    winner function_159cc09f(1);
    winner function_159cc09f(3007);
    winner function_159cc09f(3008);
    winner function_159cc09f(3009);
    winner function_159cc09f(3010);
    winner function_159cc09f(3011);
    winner function_159cc09f(3012);
    winner function_159cc09f(3013);
    winner function_159cc09f(3014);
    winner function_159cc09f(3015);
    winner function_159cc09f(3016);
    winner function_159cc09f(3017);
    winner function_159cc09f(3018);
    winner function_159cc09f(3019);
    winner function_159cc09f(3020);
    winner function_159cc09f(3021);
    winner function_159cc09f(3022);
    winner function_159cc09f(3023);
    winner function_159cc09f(3024);
    winner function_159cc09f(3025);
    winner function_159cc09f(3026);
    winner function_159cc09f(3027);
    winner function_159cc09f(3028);
    if (util::is_objective_game(level.gametype)) {
        winner function_159cc09f(2);
    }
    if (isarenamode()) {
        winner function_159cc09f(1001);
    }
    function_6bbf5440(winner);
}

// Namespace contracts
// Params 1, eflags: 0x1 linked
// Checksum 0x89b99d78, Offset: 0x2bd8
// Size: 0x1e2
function function_6bbf5440(winner) {
    switch (level.gametype) {
    case 67:
        winner function_159cc09f(1002);
        break;
    case 57:
        winner function_159cc09f(1003);
        break;
    case 64:
        winner function_159cc09f(1004);
        break;
    case 59:
        winner function_159cc09f(1005);
        break;
    case 66:
        winner function_159cc09f(1006);
        break;
    case 65:
        winner function_159cc09f(1007);
        break;
    case 63:
        winner function_159cc09f(1008);
        break;
    case 60:
        winner function_159cc09f(1026);
        break;
    case 61:
        winner function_159cc09f(1027);
        break;
    case 62:
        winner function_159cc09f(1028);
        break;
    case 58:
        winner function_159cc09f(1029);
        break;
    default:
        break;
    }
}

// Namespace contracts
// Params 0, eflags: 0x1 linked
// Checksum 0x6ff8581e, Offset: 0x2dc8
// Size: 0x34
function function_88a1d86d() {
    self function_159cc09f(1018);
    self function_159cc09f(6);
}

// Namespace contracts
// Params 0, eflags: 0x1 linked
// Checksum 0xea689751, Offset: 0x2e08
// Size: 0x34
function function_f14de7eb() {
    self function_159cc09f(1017);
    self function_159cc09f(6);
}

// Namespace contracts
// Params 0, eflags: 0x1 linked
// Checksum 0xbd3e0955, Offset: 0x2e48
// Size: 0x24
function on_headshot_kill() {
    self function_159cc09f(1016, 1);
}

// Namespace contracts
// Params 0, eflags: 0x0
// Checksum 0x3cb0b94f, Offset: 0x2e78
// Size: 0x238
function function_d27143cc() {
    player = self;
    if (!isdefined(player.pers["contracts"])) {
        return 0;
    }
    var_33894d1e = 0;
    var_fad2205f = 2;
    if (get_contract_stat(var_fad2205f, "active") && !get_contract_stat(var_fad2205f, "award_given")) {
        if (function_9771fff9(var_fad2205f)) {
            var_33894d1e += player function_8020225b();
            player function_4596db81(var_fad2205f, "award_given", 1);
        }
    }
    var_bfbff963 = 0;
    var_4db88a28 = 1;
    if (get_contract_stat(var_bfbff963, "active") && !get_contract_stat(var_bfbff963, "award_given") && get_contract_stat(var_4db88a28, "active") && !get_contract_stat(var_4db88a28, "award_given")) {
        if (function_9771fff9(var_bfbff963) && function_9771fff9(var_4db88a28)) {
            var_33894d1e += player function_ad00e83();
            player function_4596db81(var_bfbff963, "award_given", 1);
            player function_4596db81(var_4db88a28, "award_given", 1);
        }
    }
    return var_33894d1e;
}

// Namespace contracts
// Params 1, eflags: 0x1 linked
// Checksum 0xbb1c970b, Offset: 0x30b8
// Size: 0xd2
function function_9771fff9(slot) {
    player = self;
    var_62d51442 = get_contract_stat(slot, "index");
    if (!isdefined(player.pers["contracts"][var_62d51442])) {
        return false;
    }
    progress = player get_contract_stat(slot, "progress");
    target_value = player.pers["contracts"][var_62d51442].target_value;
    return progress >= target_value;
}

// Namespace contracts
// Params 0, eflags: 0x1 linked
// Checksum 0x8fa08bb7, Offset: 0x3198
// Size: 0x3c
function function_8020225b() {
    return getdvarint("daily_contract_cryptokey_reward_count", 10) * getdvarint("loot_cryptokeyCost", 100);
}

// Namespace contracts
// Params 0, eflags: 0x1 linked
// Checksum 0xf8853f7c, Offset: 0x31e0
// Size: 0x54
function function_ad00e83() {
    self function_84c79e8a();
    return getdvarint("weekly_contract_cryptokey_reward_count", 30) * getdvarint("loot_cryptokeyCost", 100);
}

// Namespace contracts
// Params 0, eflags: 0x1 linked
// Checksum 0x7c0478b8, Offset: 0x3240
// Size: 0x7c
function function_84c79e8a() {
    contract_count = self getdstat("blackjack_contract_count");
    var_4099d2ec = getdvarint("weekly_contract_blackjack_contract_reward_count", 1);
    self setdstat("blackjack_contract_count", contract_count + var_4099d2ec);
}

