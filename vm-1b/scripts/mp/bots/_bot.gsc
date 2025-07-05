#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/bots/_bot_ball;
#using scripts/mp/bots/_bot_combat;
#using scripts/mp/bots/_bot_conf;
#using scripts/mp/bots/_bot_ctf;
#using scripts/mp/bots/_bot_dem;
#using scripts/mp/bots/_bot_dom;
#using scripts/mp/bots/_bot_escort;
#using scripts/mp/bots/_bot_hq;
#using scripts/mp/bots/_bot_koth;
#using scripts/mp/bots/_bot_loadout;
#using scripts/mp/bots/_bot_sd;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_satellite;
#using scripts/mp/killstreaks/_uav;
#using scripts/mp/teams/_teams;
#using scripts/shared/array_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/bots/bot_buttons;
#using scripts/shared/bots/bot_traversals;
#using scripts/shared/callbacks_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weapons;
#using scripts/shared/weapons_shared;

#namespace bot;

// Namespace bot
// Params 0, eflags: 0x2
// Checksum 0x1526e1d5, Offset: 0x5e8
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("bot_mp", &__init__, undefined, undefined);
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0x3f9c0c2b, Offset: 0x620
// Size: 0x132
function __init__() {
    callback::on_start_gametype(&init);
    level.var_199a9d5d = &function_12cb2d73;
    level.onbotconnect = &on_bot_connect;
    level.onbotspawned = &on_bot_spawned;
    level.onbotkilled = &on_bot_killed;
    level.var_ce074aba = &function_eeb4665;
    level.var_1a85a65e = &namespace_5cd60c9f::function_2322b744;
    level.var_110e31eb = &namespace_5cd60c9f::function_9fd498fd;
    level.var_47854466 = &namespace_5cd60c9f::function_b5eda34;
    level.var_b27b0b06 = &namespace_5cd60c9f::function_975133a0;
    bot_loadout::function_59ea1bbf();
    /#
        level.var_f61e96da = &function_682f20bc;
        level thread function_9342628b();
    #/
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0xfa8cbe4b, Offset: 0x760
// Size: 0x62
function init() {
    level.botsoak = function_34e6a594();
    if (level.rankedmatch && !level.botsoak || !function_64c6bbf2()) {
        return;
    }
    function_43bf6297();
    level thread populate_bots();
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0x880e3825, Offset: 0x7d0
// Size: 0x41
function function_34e6a594() {
    /#
        return getdvarint("<dev string:x28>", 0);
    #/
    return isdedicated() && getdvarint("sv_botsoak", 0);
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0xea560352, Offset: 0x820
// Size: 0x47
function function_43bf6297() {
    if (level.botsoak) {
        return;
    }
    for (host = util::gethostplayerforbots(); !isdefined(host); host = util::gethostplayerforbots()) {
        wait 0.25;
    }
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0x1fb688c7, Offset: 0x870
// Size: 0x4d
function function_b6063908() {
    host = util::gethostplayerforbots();
    if (!isdefined(host) || host.team == "spectator") {
        return "allies";
    }
    return host.team;
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0x1a98afb5, Offset: 0x8c8
// Size: 0x3
function function_c0d531d9() {
    return false;
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0x51340788, Offset: 0x8d8
// Size: 0x112
function on_bot_connect() {
    self endon(#"disconnect");
    if (isdefined(level.disableclassselection) && level.disableclassselection) {
        self set_rank();
        self botsetrandomcharactercustomization();
        self.pers["class"] = level.defaultclass;
        self.curclass = level.defaultclass;
        return;
    }
    if (!(isdefined(self.pers["bot_loadout"]) && self.pers["bot_loadout"])) {
        self set_rank();
        self bot_loadout::function_1e1fb4f2();
        self bot_loadout::function_2169b982();
        self botsetrandomcharactercustomization();
        self bot_loadout::function_ad0db880();
        self.pers["bot_loadout"] = 1;
    }
    self bot_loadout::function_ab35326f();
    self function_33d8423();
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0xd429e5f2, Offset: 0x9f8
// Size: 0x12a
function on_bot_spawned() {
    /#
        weapon = undefined;
        if (getdvarint("<dev string:x33>") != 0) {
            player = util::gethostplayer();
            weapon = player getcurrentweapon();
        }
        if (getdvarstring("<dev string:x4b>", "<dev string:x5d>") != "<dev string:x5d>") {
            weapon = getweapon(getdvarstring("<dev string:x4b>"));
        }
        if (isdefined(weapon) && level.weaponnone != weapon) {
            self weapons::detach_all_weapons();
            self takeallweapons();
            self giveweapon(weapon);
            self switchtoweapon(weapon);
            self setspawnweapon(weapon);
            self teams::function_37fd0a0f(self.team, weapon);
        }
    #/
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0x8071ac3a, Offset: 0xb30
// Size: 0x32
function on_bot_killed() {
    self endon(#"disconnect");
    self waittill(#"death_delay_finished");
    self function_33d8423();
    self thread respawn();
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0x85fd7fcc, Offset: 0xb70
// Size: 0x22
function respawn() {
    self endon(#"spawned");
    wait 0.1;
    self function_ec17d837();
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0x761a6ee1, Offset: 0xba0
// Size: 0x22
function function_eeb4665() {
    self function_2e1b3e51();
    self sprint_to_goal();
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0x3fbf92d4, Offset: 0xbd0
// Size: 0xa2
function populate_bots() {
    wait 1;
    if (level.teambased) {
        maxallies = getdvarint("bot_maxAllies", 0);
        maxaxis = getdvarint("bot_maxAxis", 0);
        level thread monitor_bot_team_population(maxallies, maxaxis);
        return;
    }
    maxfree = getdvarint("bot_maxFree", 0);
    level thread monitor_bot_population(maxfree);
}

// Namespace bot
// Params 2, eflags: 0x0
// Checksum 0x79e5ac78, Offset: 0xc80
// Size: 0x123
function monitor_bot_team_population(maxallies, maxaxis) {
    level endon(#"game_ended");
    if (!maxallies && !maxaxis) {
        return;
    }
    while (true) {
        allies = getplayers("allies");
        if (allies.size < maxallies) {
            add_bot("allies");
            wait 0.5;
        } else if (allies.size > maxallies) {
            remove_best_bot(allies);
            wait 0.5;
        }
        axis = getplayers("axis");
        if (axis.size < maxaxis) {
            add_bot("axis");
            wait 0.5;
        } else if (axis.size > maxaxis) {
            remove_best_bot(axis);
            wait 0.5;
        }
        if (allies.size == maxallies && axis.size == maxaxis) {
            wait 3;
        }
    }
}

// Namespace bot
// Params 1, eflags: 0x0
// Checksum 0x7266c1ca, Offset: 0xdb0
// Size: 0x91
function monitor_bot_population(maxfree) {
    level endon(#"game_ended");
    if (!maxfree) {
        return;
    }
    while (true) {
        players = getplayers();
        if (players.size < maxfree) {
            add_bot();
            wait 0.5;
        } else if (players.size > maxfree) {
            remove_best_bot(players);
            wait 0.5;
        }
        if (players.size == maxfree) {
            wait 3;
        }
    }
}

// Namespace bot
// Params 1, eflags: 0x0
// Checksum 0x6027eb3b, Offset: 0xe50
// Size: 0x122
function remove_best_bot(players) {
    bots = filter_bots(players);
    if (!bots.size) {
        return;
    }
    bestbots = [];
    foreach (bot in bots) {
        if (bot.sessionstate == "spectator") {
            continue;
        }
        if (bot.sessionstate == "dead" || !bot namespace_5cd60c9f::function_231137e6()) {
            bestbots[bestbots.size] = bot;
        }
    }
    if (bestbots.size) {
        remove_bot(bestbots[randomint(bestbots.size)]);
        return;
    }
    remove_bot(bots[randomint(bots.size)]);
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0xa8659164, Offset: 0xf80
// Size: 0x157
function function_33d8423() {
    if (isdefined(level.disableclassselection) && level.disableclassselection) {
        return;
    }
    var_962c078f = self bot_loadout::function_bef7ccf4();
    if (self namespace_5cd60c9f::function_9d54f045(self.bot.attacker) && self.var_7b3583d0 && randomint(100) < 75) {
        classindex = randomint(self.var_7b3583d0);
        for (i = 0; i < classindex; i++) {
            if (self.var_c77c87c9[i].secondary.isrocketlauncher) {
                classname = self.var_c77c87c9[i].name;
            }
        }
        self notify(#"menuresponse", "ChooseClass_InGame", classname);
        return;
    }
    if (!isdefined(var_962c078f) || randomint(100) < 100) {
        classindex = randomint(self.var_c77c87c9.size);
        self notify(#"menuresponse", "ChooseClass_InGame", self.var_c77c87c9[classindex].name);
    }
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0x48fb7ce9, Offset: 0x10e0
// Size: 0x17d
function use_killstreak() {
    if (!level.loadoutkillstreaksenabled) {
        return;
    }
    weapons = self getweaponslist();
    inventoryweapon = self getinventoryweapon();
    foreach (weapon in weapons) {
        killstreak = killstreaks::get_killstreak_for_weapon(weapon);
        if (!isdefined(killstreak)) {
            continue;
        }
        if (weapon != inventoryweapon && !self getweaponammoclip(weapon)) {
            continue;
        }
        if (self killstreakrules::iskillstreakallowed(killstreak, self.team)) {
            useweapon = weapon;
            break;
        }
    }
    if (!isdefined(useweapon)) {
        return;
    }
    killstreak_ref = killstreaks::get_menu_name(killstreak);
    switch (killstreak_ref) {
    case "killstreak_counteruav":
    case "killstreak_helicopter_player_gunner":
    case "killstreak_raps":
    case "killstreak_satellite":
    case "killstreak_sentinel":
    case "killstreak_uav":
        self switchtoweapon(useweapon);
        break;
    }
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0x4f2c6df7, Offset: 0x1268
// Size: 0x69
function function_a59fc9fa() {
    if (level.teambased) {
        return (uav::hasuav(self.team) || satellite::hassatellite(self.team));
    }
    return uav::hasuav(self.entnum) || satellite::hassatellite(self.entnum);
}

// Namespace bot
// Params 1, eflags: 0x0
// Checksum 0x4ba69375, Offset: 0x12e0
// Size: 0x12d
function function_22f478a2(var_f9e0a43) {
    if (!isdefined(var_f9e0a43)) {
        var_f9e0a43 = 0;
    }
    enemies = self getenemies();
    /#
        for (i = 0; i < enemies.size; i++) {
            if (isplayer(enemies[i]) && enemies[i] isinmovemode("<dev string:x5e>", "<dev string:x62>")) {
                arrayremoveindex(enemies, i);
                i--;
            }
        }
    #/
    if (var_f9e0a43 && !self function_a59fc9fa()) {
        for (i = 0; i < enemies.size; i++) {
            if (!isdefined(enemies[i].lastfiretime)) {
                arrayremoveindex(enemies, i);
                i--;
                continue;
            }
            if (gettime() - enemies[i].lastfiretime > 2000) {
                arrayremoveindex(enemies, i);
                i--;
            }
        }
    }
    return enemies;
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0xc3d0d7d1, Offset: 0x1418
// Size: 0x262
function set_rank() {
    players = getplayers();
    ranks = [];
    bot_ranks = [];
    human_ranks = [];
    for (i = 0; i < players.size; i++) {
        if (players[i] == self) {
            continue;
        }
        if (isdefined(players[i].pers["rank"])) {
            if (players[i] util::is_bot()) {
                bot_ranks[bot_ranks.size] = players[i].pers["rank"];
                continue;
            }
            human_ranks[human_ranks.size] = players[i].pers["rank"];
        }
    }
    if (!human_ranks.size) {
        human_ranks[human_ranks.size] = 10;
    }
    human_avg = math::array_average(human_ranks);
    while (bot_ranks.size + human_ranks.size < 5) {
        r = human_avg + randomintrange(-5, 5);
        rank = math::clamp(r, 0, level.maxrank);
        human_ranks[human_ranks.size] = rank;
    }
    ranks = arraycombine(human_ranks, bot_ranks, 1, 0);
    avg = math::array_average(ranks);
    s = math::array_std_deviation(ranks, avg);
    rank = int(math::random_normal_distribution(avg, s, 0, level.maxrank));
    while (!isdefined(self.pers["codpoints"])) {
        wait 0.1;
    }
    /#
        rank = 54;
    #/
    self.pers["rank"] = rank;
    self.pers["rankxp"] = rank::getrankinfominxp(rank);
    self setrank(rank);
    self rank::syncxpstat();
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0x57e1e8ff, Offset: 0x1688
// Size: 0x106
function function_64c6bbf2() {
    switch (level.gametype) {
    case "ball":
        namespace_898f98f0::init();
        return true;
    case "conf":
        namespace_3a008251::init();
        return true;
    case "ctf":
        namespace_6f2d2560::init();
        return true;
    case "dem":
        namespace_c34670eb::init();
        return true;
    case "dm":
        return true;
    case "dom":
        namespace_5f1d8415::init();
        return true;
    case "escort":
        namespace_ebd80b8b::init();
        return true;
    case "gun":
        return true;
    case "koth":
        namespace_366cf615::init();
        return true;
    case "sd":
        namespace_8d1d9f92::init();
        return true;
    case "tdm":
        return true;
    }
    return false;
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0x356377d2, Offset: 0x1798
// Size: 0xa1
function function_12cb2d73() {
    switch (getdvarint("bot_difficulty", 1)) {
    case 0:
        bundlename = "bot_mp_easy";
        break;
    case 1:
        bundlename = "bot_mp_normal";
        break;
    case 2:
        bundlename = "bot_mp_hard";
        break;
    case 3:
    default:
        bundlename = "bot_mp_veteran";
        break;
    }
    return struct::get_script_bundle("botsettings", bundlename);
}

// Namespace bot
// Params 3, eflags: 0x0
// Checksum 0x81e5c3f3, Offset: 0x1848
// Size: 0x1b
function function_aa6ecc02(goal_name, origin, radius) {
    return false;
}

// Namespace bot
// Params 3, eflags: 0x0
// Checksum 0x223fe7b6, Offset: 0x1870
// Size: 0x1b
function function_bd3d1236(goal_name, origin, radius) {
    return false;
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0x858a2c98, Offset: 0x1898
// Size: 0x3
function function_daeba505() {
    return [];
}

// Namespace bot
// Params 2, eflags: 0x0
// Checksum 0x6cae5eaa, Offset: 0x18a8
// Size: 0x13
function function_838c3a3a(origin, var_745454c7) {
    return undefined;
}

// Namespace bot
// Params 1, eflags: 0x0
// Checksum 0xc6b29ba9, Offset: 0x18c8
// Size: 0xb
function function_91fa938d(weaponname) {
    return false;
}

// Namespace bot
// Params 2, eflags: 0x0
// Checksum 0xd35907f1, Offset: 0x18e0
// Size: 0x13
function function_632d277c(origin, point) {
    return false;
}

// Namespace bot
// Params 1, eflags: 0x0
// Checksum 0x3214bbc, Offset: 0x1900
// Size: 0xa
function function_2ab0a76e(var_61550980) {
    
}

/#

    // Namespace bot
    // Params 1, eflags: 0x0
    // Checksum 0x5da9c18f, Offset: 0x1918
    // Size: 0x257
    function function_682f20bc(cmd) {
        var_d03a6f21 = strtok(cmd, "<dev string:x69>");
        if (var_d03a6f21.size == 0) {
            return 0;
        }
        host = util::gethostplayerforbots();
        team = function_b6063908();
        switch (var_d03a6f21[0]) {
        case "<dev string:x6b>":
            team = util::getotherteam(team);
        case "<dev string:x77>":
            count = 1;
            if (var_d03a6f21.size > 1) {
                count = int(var_d03a6f21[1]);
            }
            for (i = 0; i < count; i++) {
                add_bot(team);
            }
            return 1;
        case "<dev string:x86>":
            team = util::getotherteam(team);
        case "<dev string:x98>":
            bot = function_9fda6f90(team);
            bot thread fixed_spawn_override();
            return 1;
        case "<dev string:xad>":
            players = getplayers();
            foreach (player in players) {
                if (!player util::is_bot()) {
                    continue;
                }
                weapon = host getcurrentweapon();
                player weapons::detach_all_weapons();
                player takeallweapons();
                player giveweapon(weapon);
                player switchtoweapon(weapon);
                player setspawnweapon(weapon);
                player teams::function_37fd0a0f(player.team, weapon);
            }
            return 1;
        }
        return 0;
    }

    // Namespace bot
    // Params 0, eflags: 0x0
    // Checksum 0x7ada58bf, Offset: 0x1b78
    // Size: 0x95
    function function_9342628b() {
        setdvar("<dev string:xbb>", "<dev string:x5d>");
        for (;;) {
            wait 1;
            gadget = getdvarstring("<dev string:xbb>");
            if (gadget != "<dev string:x5d>") {
                function_1d07d711(getweapon(gadget));
                setdvar("<dev string:xbb>", "<dev string:x5d>");
            }
        }
    }

    // Namespace bot
    // Params 1, eflags: 0x0
    // Checksum 0x9570861c, Offset: 0x1c18
    // Size: 0x1b3
    function function_1d07d711(gadget) {
        players = getplayers();
        foreach (player in players) {
            if (!player util::is_bot()) {
                continue;
            }
            host = util::gethostplayer();
            weapon = host getcurrentweapon();
            if (!isdefined(weapon) || weapon == level.weaponnone || weapon == level.weaponnull) {
                weapon = getweapon("<dev string:xcd>");
            }
            player weapons::detach_all_weapons();
            player takeallweapons();
            player giveweapon(weapon);
            player switchtoweapon(weapon);
            player setspawnweapon(weapon);
            player teams::function_37fd0a0f(player.team, weapon);
            player giveweapon(gadget);
            slot = player gadgetgetslot(gadget);
            player gadgetpowerset(slot, 100);
            player botpressbuttonforgadget(gadget);
        }
    }

    // Namespace bot
    // Params 0, eflags: 0x0
    // Checksum 0xb73bf2fa, Offset: 0x1dd8
    // Size: 0x65
    function fixed_spawn_override() {
        self endon(#"disconnect");
        spawnorigin = self.origin;
        spawnangles = self.angles;
        while (true) {
            self waittill(#"spawned_player");
            self setorigin(spawnorigin);
            self setplayerangles(spawnangles);
        }
    }

#/
