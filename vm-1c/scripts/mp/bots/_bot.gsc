#using scripts/mp/_util;
#using scripts/mp/teams/_teams;
#using scripts/mp/killstreaks/_emp;
#using scripts/mp/killstreaks/_satellite;
#using scripts/mp/killstreaks/_uav;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/bots/_bot_sd;
#using scripts/mp/bots/_bot_loadout;
#using scripts/mp/bots/_bot_koth;
#using scripts/mp/bots/_bot_hq;
#using scripts/mp/bots/_bot_escort;
#using scripts/mp/bots/_bot_dom;
#using scripts/mp/bots/_bot_dem;
#using scripts/mp/bots/_bot_ctf;
#using scripts/mp/bots/_bot_conf;
#using scripts/mp/bots/_bot_combat;
#using scripts/mp/bots/_bot_clean;
#using scripts/mp/bots/_bot_ball;
#using scripts/shared/bots/bot_buttons;
#using scripts/shared/bots/bot_traversals;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/bots/_bot;
#using scripts/shared/weapons/_weapons;
#using scripts/shared/weapons_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/math_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace bot;

// Namespace bot
// Params 0, eflags: 0x2
// Checksum 0xf459461a, Offset: 0x650
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("bot_mp", &__init__, undefined, undefined);
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0xd13cb7f0, Offset: 0x690
// Size: 0x15c
function __init__() {
    callback::on_start_gametype(&init);
    level.var_199a9d5d = &function_12cb2d73;
    level.onbotconnect = &on_bot_connect;
    level.onbotspawned = &on_bot_spawned;
    level.onbotkilled = &on_bot_killed;
    level.var_ce074aba = &function_eeb4665;
    level.var_1a85a65e = &namespace_5cd60c9f::function_2322b744;
    level.var_110e31eb = &namespace_5cd60c9f::function_aff9cbcb;
    level.var_66a90634 = &namespace_5cd60c9f::function_a859fd70;
    level.var_47854466 = &namespace_5cd60c9f::function_76d00bea;
    level.var_b27b0b06 = &namespace_5cd60c9f::function_975133a0;
    level.enemyempactive = &emp::enemyempactive;
    /#
        level.var_f61e96da = &function_682f20bc;
        level thread function_9342628b();
    #/
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x4e87f123, Offset: 0x7f8
// Size: 0x84
function init() {
    level endon(#"game_ended");
    level.botsoak = function_34e6a594();
    if (level.rankedmatch && !level.botsoak || !function_64c6bbf2()) {
        return;
    }
    function_43bf6297();
    level thread populate_bots();
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0xd544fa50, Offset: 0x888
// Size: 0x52
function function_34e6a594() {
    /#
        return getdvarint("<dev string:x28>", 0);
    #/
    return isdedicated() && getdvarint("sv_botsoak", 0);
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x92ca68db, Offset: 0x8e8
// Size: 0x64
function function_43bf6297() {
    level endon(#"game_ended");
    if (level.botsoak) {
        return;
    }
    for (host = util::gethostplayerforbots(); !isdefined(host); host = util::gethostplayerforbots()) {
        wait 0.25;
    }
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x6ed01a99, Offset: 0x958
// Size: 0x5e
function function_b6063908() {
    host = util::gethostplayerforbots();
    if (!isdefined(host) || host.team == "spectator") {
        return "allies";
    }
    return host.team;
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0xced4510b, Offset: 0x9c0
// Size: 0x6
function function_c0d531d9() {
    return false;
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x22a8233a, Offset: 0x9d0
// Size: 0x144
function on_bot_connect() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    if (isdefined(level.disableclassselection) && level.disableclassselection) {
        self set_rank();
        self bot_loadout::function_ad0db880();
        self bot_loadout::function_2169b982();
        return;
    }
    if (!(isdefined(self.pers["bot_loadout"]) && self.pers["bot_loadout"])) {
        self set_rank();
        self bot_loadout::function_1e1fb4f2();
        self bot_loadout::function_ad0db880();
        self bot_loadout::function_2169b982();
        self.pers["bot_loadout"] = 1;
    }
    self bot_loadout::function_ab35326f();
    self function_33d8423();
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0xe122225d, Offset: 0xb20
// Size: 0x18c
function on_bot_spawned() {
    self.bot.var_a0f31e50 = undefined;
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
// Params 0, eflags: 0x1 linked
// Checksum 0x153d5789, Offset: 0xcb8
// Size: 0x7c
function on_bot_killed() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self endon(#"spawned");
    self waittill(#"death_delay_finished");
    wait 0.1;
    if (self function_33d8423() && level.playerforcerespawn) {
        return;
    }
    self thread respawn();
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x117da822, Offset: 0xd40
// Size: 0x50
function respawn() {
    self endon(#"spawned");
    self endon(#"disconnect");
    level endon(#"game_ended");
    while (true) {
        self function_ec17d837();
        wait 0.1;
    }
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x9dc3a64b, Offset: 0xd98
// Size: 0x4c
function function_eeb4665() {
    if (self function_e433cd43()) {
        return;
    }
    self function_2e1b3e51();
    self sprint_to_goal();
}

// Namespace bot
// Params 1, eflags: 0x1 linked
// Checksum 0xa72d913b, Offset: 0xdf0
// Size: 0x334
function function_e433cd43(maxrange) {
    if (!isdefined(maxrange)) {
        maxrange = 1400;
    }
    crates = getentarray("care_package", "script_noteworthy");
    maxrangesq = maxrange * maxrange;
    var_ee611284 = 3844;
    var_c51988b = undefined;
    var_df5323a3 = undefined;
    foreach (crate in crates) {
        if (!crate isonground()) {
            continue;
        }
        var_cee2a97a = distance2dsquared(self.origin, crate.origin);
        if (var_cee2a97a > maxrangesq) {
            continue;
        }
        inuse = isdefined(crate.useent.inuse) && isdefined(crate.useent) && crate.useent.inuse;
        if (var_cee2a97a <= var_ee611284) {
            if (inuse && !self usebuttonpressed()) {
                continue;
            }
            self function_8fa389fd();
            return true;
        }
        if (!self function_4597ff7() && !self function_b2aab34a(crate)) {
            continue;
        }
        if (!isdefined(var_c51988b) || var_cee2a97a < var_df5323a3) {
            var_c51988b = crate;
            var_df5323a3 = var_cee2a97a;
        }
    }
    if (isdefined(var_c51988b)) {
        randomangle = (0, randomint(360), 0);
        var_bc3b836 = anglestoforward(randomangle);
        point = var_c51988b.origin + var_bc3b836 * 39;
        if (self function_b4a0b3c5(point)) {
            self thread function_429af6de(var_c51988b);
            return true;
        }
    }
    return false;
}

// Namespace bot
// Params 1, eflags: 0x1 linked
// Checksum 0xb0b37450, Offset: 0x1130
// Size: 0x84
function function_429af6de(crate) {
    self endon(#"death");
    self endon(#"bot_goal_reached");
    level endon(#"game_ended");
    while (isdefined(crate) && !self namespace_5cd60c9f::function_231137e6()) {
        wait level.botsettings.var_d74d136c;
    }
    self function_b4a0b3c5(self.origin);
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x4d85df5f, Offset: 0x11c0
// Size: 0xcc
function populate_bots() {
    level endon(#"game_ended");
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
// Params 2, eflags: 0x1 linked
// Checksum 0x379b3bc7, Offset: 0x1298
// Size: 0x148
function monitor_bot_team_population(maxallies, maxaxis) {
    level endon(#"game_ended");
    if (!maxallies && !maxaxis) {
        return;
    }
    fill_balanced_teams(maxallies, maxaxis);
    while (true) {
        wait 3;
        allies = getplayers("allies");
        axis = getplayers("axis");
        if (allies.size > maxallies && remove_best_bot(allies)) {
            continue;
        }
        if (axis.size > maxaxis && remove_best_bot(axis)) {
            continue;
        }
        if (allies.size < maxallies || axis.size < maxaxis) {
            add_balanced_bot(allies, maxallies, axis, maxaxis);
        }
    }
}

// Namespace bot
// Params 2, eflags: 0x1 linked
// Checksum 0x8eb8c4b9, Offset: 0x13e8
// Size: 0xf4
function fill_balanced_teams(maxallies, maxaxis) {
    allies = getplayers("allies");
    for (axis = getplayers("axis"); (allies.size < maxallies || axis.size < maxaxis) && add_balanced_bot(allies, maxallies, axis, maxaxis); axis = getplayers("axis")) {
        wait 0.05;
        allies = getplayers("allies");
    }
}

// Namespace bot
// Params 4, eflags: 0x1 linked
// Checksum 0xcc7d3217, Offset: 0x14e8
// Size: 0xb6
function add_balanced_bot(allies, maxallies, axis, maxaxis) {
    bot = undefined;
    if (allies.size <= axis.size || allies.size < maxallies && axis.size >= maxaxis) {
        bot = add_bot("allies");
    } else if (axis.size < maxaxis) {
        bot = add_bot("axis");
    }
    return isdefined(bot);
}

// Namespace bot
// Params 1, eflags: 0x1 linked
// Checksum 0xc6efe319, Offset: 0x15a8
// Size: 0xf8
function monitor_bot_population(maxfree) {
    level endon(#"game_ended");
    if (!maxfree) {
        return;
    }
    for (players = getplayers(); players.size < maxfree; players = getplayers()) {
        add_bot();
        wait 0.05;
    }
    while (true) {
        wait 3;
        players = getplayers();
        if (players.size < maxfree) {
            add_bot();
            continue;
        }
        if (players.size > maxfree) {
            remove_best_bot(players);
        }
    }
}

// Namespace bot
// Params 1, eflags: 0x1 linked
// Checksum 0x406e420c, Offset: 0x16a8
// Size: 0x198
function remove_best_bot(players) {
    bots = filter_bots(players);
    if (!bots.size) {
        return false;
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
    } else {
        remove_bot(bots[randomint(bots.size)]);
    }
    return true;
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0xa2746bc4, Offset: 0x1848
// Size: 0x116
function function_33d8423() {
    if (isdefined(level.disableclassselection) && level.disableclassselection) {
        return false;
    }
    var_962c078f = self bot_loadout::function_bef7ccf4();
    if (!isdefined(var_962c078f) || randomint(100) < (isdefined(level.botsettings.var_3edbf1a3) ? level.botsettings.var_3edbf1a3 : 0)) {
        classindex = randomint(self.var_c77c87c9.size);
        classname = self.var_c77c87c9[classindex].name;
    }
    if (!isdefined(classname) || classname === var_962c078f) {
        return false;
    }
    self notify(#"menuresponse", "ChooseClass_InGame", classname);
    return true;
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x1ce3024c, Offset: 0x1968
// Size: 0x1f6
function use_killstreak() {
    if (!level.loadoutkillstreaksenabled || self emp::enemyempactive()) {
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
// Params 0, eflags: 0x1 linked
// Checksum 0xf6389d03, Offset: 0x1b68
// Size: 0x6a
function function_a59fc9fa() {
    if (level.teambased) {
        return (uav::hasuav(self.team) || satellite::hassatellite(self.team));
    }
    return uav::hasuav(self.entnum) || satellite::hassatellite(self.entnum);
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0xb4c29a33, Offset: 0x1be0
// Size: 0x50
function function_4597ff7() {
    if (self isempjammed()) {
        return 0;
    }
    if (isdefined(level.hardcoremode) && level.hardcoremode) {
        return self function_a59fc9fa();
    }
    return 1;
}

// Namespace bot
// Params 1, eflags: 0x1 linked
// Checksum 0xe3bd3ca, Offset: 0x1c38
// Size: 0x1b0
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
// Params 0, eflags: 0x1 linked
// Checksum 0x4b60b0fd, Offset: 0x1df0
// Size: 0x324
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
    self.pers["rank"] = rank;
    self.pers["rankxp"] = rank::getrankinfominxp(rank);
    self setrank(rank);
    self rank::syncxpstat();
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0xb85cf2b0, Offset: 0x2120
// Size: 0x178
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
    case "infect":
        return true;
    case "gun":
        return true;
    case "koth":
        namespace_366cf615::init();
        return true;
    case "sd":
        namespace_8d1d9f92::init();
        return true;
    case "clean":
        namespace_934c83ce::init();
        return true;
    case "tdm":
        return true;
    }
    return false;
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0xd251c025, Offset: 0x22a0
// Size: 0xba
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
// Params 3, eflags: 0x1 linked
// Checksum 0xed3002fd, Offset: 0x2368
// Size: 0x1e
function function_aa6ecc02(goal_name, origin, radius) {
    return false;
}

// Namespace bot
// Params 3, eflags: 0x0
// Checksum 0xb6116329, Offset: 0x2390
// Size: 0x1e
function function_bd3d1236(goal_name, origin, radius) {
    return false;
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0xc902d934, Offset: 0x23b8
// Size: 0x6
function function_daeba505() {
    return [];
}

// Namespace bot
// Params 2, eflags: 0x1 linked
// Checksum 0x5b4f9f29, Offset: 0x23c8
// Size: 0x16
function function_838c3a3a(origin, var_745454c7) {
    return undefined;
}

// Namespace bot
// Params 1, eflags: 0x0
// Checksum 0x12b3937c, Offset: 0x23e8
// Size: 0xe
function function_91fa938d(weaponname) {
    return false;
}

// Namespace bot
// Params 2, eflags: 0x1 linked
// Checksum 0x79895444, Offset: 0x2400
// Size: 0x16
function function_632d277c(origin, point) {
    return false;
}

// Namespace bot
// Params 1, eflags: 0x0
// Checksum 0x2eed0321, Offset: 0x2420
// Size: 0xc
function function_2ab0a76e(var_61550980) {
    
}

/#

    // Namespace bot
    // Params 1, eflags: 0x1 linked
    // Checksum 0xd22845a2, Offset: 0x2438
    // Size: 0x38a
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
        case "<dev string:x93>":
            remove_bots(undefined, team);
            return 1;
        case "<dev string:xa3>":
            team = util::getotherteam(team);
        case "<dev string:xb5>":
            bot = function_9fda6f90(team);
            if (isdefined(bot)) {
                bot thread fixed_spawn_override();
            }
            return 1;
        case "<dev string:xca>":
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
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd5d02109, Offset: 0x27d0
    // Size: 0xb8
    function function_9342628b() {
        setdvar("<dev string:xd8>", "<dev string:x5d>");
        for (;;) {
            wait 1;
            gadget = getdvarstring("<dev string:xd8>");
            if (gadget != "<dev string:x5d>") {
                function_1d07d711(getweapon(gadget));
                setdvar("<dev string:xd8>", "<dev string:x5d>");
            }
        }
    }

    // Namespace bot
    // Params 1, eflags: 0x1 linked
    // Checksum 0x4458afcd, Offset: 0x2890
    // Size: 0x252
    function function_1d07d711(gadget) {
        players = getplayers();
        foreach (player in players) {
            if (!player util::is_bot()) {
                continue;
            }
            host = util::gethostplayer();
            weapon = host getcurrentweapon();
            if (!isdefined(weapon) || weapon == level.weaponnone || weapon == level.weaponnull) {
                weapon = getweapon("<dev string:xea>");
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
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd218870f, Offset: 0x2af0
    // Size: 0x88
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
