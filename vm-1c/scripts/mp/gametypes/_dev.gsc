#using scripts/codescripts/struct;
#using scripts/mp/_teamops;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_dev_class;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_hud_message;
#using scripts/mp/gametypes/_killcam;
#using scripts/mp/killstreaks/_helicopter;
#using scripts/mp/killstreaks/_helicopter_gunner;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_supplydrop;
#using scripts/mp/killstreaks/_uav;
#using scripts/shared/array_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/callbacks_shared;
#using scripts/shared/dev_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace dev;

/#

    // Namespace dev
    // Params 0, eflags: 0x2
    // Checksum 0xc847bbc1, Offset: 0x3e0
    // Size: 0x3c
    function autoexec __init__sytem__() {
        system::register("<dev string:x28>", &__init__, undefined, "<dev string:x2c>");
    }

#/

// Namespace dev
// Params 0, eflags: 0x0
// Checksum 0x3577be2f, Offset: 0x428
// Size: 0x5c
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connected);
    level.devongetormakebot = &getormakebot;
}

// Namespace dev
// Params 0, eflags: 0x0
// Checksum 0x13be6343, Offset: 0x490
// Size: 0x4a0
function init() {
    /#
        if (getdvarstring("<dev string:x37>") == "<dev string:x46>") {
            setdvar("<dev string:x37>", "<dev string:x47>");
        }
        if (getdvarstring("<dev string:x49>") == "<dev string:x46>") {
            setdvar("<dev string:x49>", "<dev string:x47>");
        }
        if (getdvarstring("<dev string:x5d>") == "<dev string:x46>") {
            setdvar("<dev string:x5d>", "<dev string:x47>");
        }
        if (getdvarstring("<dev string:x75>") == "<dev string:x46>") {
            setdvar("<dev string:x75>", "<dev string:x47>");
        }
        if (getdvarstring("<dev string:x8a>") == "<dev string:x46>") {
            setdvar("<dev string:x8a>", "<dev string:x47>");
        }
        if (getdvarstring("<dev string:xa6>") == "<dev string:x46>") {
            setdvar("<dev string:xa6>", "<dev string:x46>");
        }
        if (getdvarstring("<dev string:xb9>") == "<dev string:x46>") {
            setdvar("<dev string:xb9>", "<dev string:x47>");
        }
        thread testscriptruntimeerror();
        thread testdvars();
        thread addenemyheli();
        thread addtestcarepackage();
        thread function_2f38b7bf();
        thread devhelipathdebugdraw();
        thread devstraferunpathdebugdraw();
        thread dev_class::dev_cac_init();
        thread globallogic_score::setplayermomentumdebug();
        setdvar("<dev string:xd4>", "<dev string:x46>");
        setdvar("<dev string:xe1>", "<dev string:x46>");
        setdvar("<dev string:xf0>", "<dev string:x47>");
        thread engagement_distance_debug_toggle();
        thread equipment_dev_gui();
        thread grenade_dev_gui();
        setdvar("<dev string:x102>", "<dev string:x47>");
        level.var_391ebc05 = 0;
        level.var_bbc3085f = 0;
        level.var_f1d22fe = 0;
        level.dem_spawns = [];
        if (level.gametype == "<dev string:x11c>") {
            extra_spawns = [];
            extra_spawns[0] = "<dev string:x120>";
            extra_spawns[1] = "<dev string:x138>";
            extra_spawns[2] = "<dev string:x150>";
            extra_spawns[3] = "<dev string:x168>";
            for (i = 0; i < extra_spawns.size; i++) {
                points = getentarray(extra_spawns[i], "<dev string:x180>");
                if (isdefined(points) && points.size > 0) {
                    level.dem_spawns = arraycombine(level.dem_spawns, points, 1, 0);
                }
            }
        }
        for (;;) {
            updatedevsettings();
            wait 0.5;
        }
    #/
}

// Namespace dev
// Params 0, eflags: 0x0
// Checksum 0xe27529ec, Offset: 0x938
// Size: 0x3c
function on_player_connected() {
    /#
        if (isdefined(level.devgui_unlimited_ammo) && level.devgui_unlimited_ammo) {
            wait 1;
            self thread devgui_unlimited_ammo();
        }
    #/
}

/#

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x11700fd3, Offset: 0x980
    // Size: 0x46e
    function updatehardpoints() {
        keys = getarraykeys(level.killstreaks);
        for (i = 0; i < keys.size; i++) {
            dvar = level.killstreaks[keys[i]].devdvar;
            enemydvar = level.killstreaks[keys[i]].devenemydvar;
            host = util::gethostplayer();
            if (isdefined(dvar) && getdvarint(dvar) == 1) {
                if (keys[i] == "<dev string:x18a>") {
                    if (isdefined(level.vtol)) {
                        iprintln("<dev string:x19c>");
                    } else {
                        host killstreaks::give("<dev string:x1bd>" + keys[i]);
                    }
                } else {
                    foreach (player in level.players) {
                        if (isdefined(level.usingscorestreaks) && isdefined(level.usingmomentum) && level.usingmomentum && level.usingscorestreaks) {
                            player killstreaks::give("<dev string:x1bd>" + keys[i]);
                            continue;
                        }
                        if (player util::is_bot()) {
                            player.bot["<dev string:x1c8>"] = [];
                            player.bot["<dev string:x1c8>"][0] = killstreaks::get_menu_name(keys[i]);
                            killstreakweapon = killstreaks::get_killstreak_weapon(keys[i]);
                            player killstreaks::give_weapon(killstreakweapon, 1);
                            globallogic_score::_setplayermomentum(player, 2000);
                            continue;
                        }
                        player killstreaks::give("<dev string:x1bd>" + keys[i]);
                    }
                }
                setdvar(dvar, "<dev string:x47>");
            }
            if (isdefined(enemydvar) && getdvarint(enemydvar) == 1) {
                team = "<dev string:x1d4>";
                player = util::gethostplayer();
                if (isdefined(player.team)) {
                    team = util::getotherteam(player.team);
                }
                ent = getormakebot(team);
                if (!isdefined(ent)) {
                    println("<dev string:x1df>");
                    continue;
                }
                wait 1;
                ent killstreaks::give("<dev string:x1bd>" + keys[i]);
                setdvar(enemydvar, "<dev string:x47>");
            }
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x94df881f, Offset: 0xdf8
    // Size: 0x8c
    function function_3d345413() {
        teamops = getdvarstring(level.var_60c4492a);
        if (getdvarstring(level.var_60c4492a) != "<dev string:x46>") {
            teamops::function_a2630ab8(teamops);
            setdvar(level.var_60c4492a, "<dev string:x46>");
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x0
    // Checksum 0xa451eab2, Offset: 0xe90
    // Size: 0x54
    function warpalltohost(team) {
        host = util::gethostplayer();
        warpalltoplayer(team, host.name);
    }

    // Namespace dev
    // Params 2, eflags: 0x0
    // Checksum 0x6d1d1ea2, Offset: 0xef0
    // Size: 0x374
    function warpalltoplayer(team, player) {
        players = getplayers();
        target = undefined;
        for (i = 0; i < players.size; i++) {
            if (players[i].name == player) {
                target = players[i];
                break;
            }
        }
        if (isdefined(target)) {
            origin = target.origin;
            nodes = getnodesinradius(origin, -128, 32, -128, "<dev string:x1f9>");
            angles = target getplayerangles();
            yaw = (0, angles[1], 0);
            forward = anglestoforward(yaw);
            spawn_origin = origin + forward * -128 + (0, 0, 16);
            if (!bullettracepassed(target geteye(), spawn_origin, 0, target)) {
                spawn_origin = undefined;
            }
            for (i = 0; i < players.size; i++) {
                if (players[i] == target) {
                    continue;
                }
                if (isdefined(team)) {
                    if (strstartswith(team, "<dev string:x1fe>") && target.team == players[i].team) {
                        continue;
                    }
                    if (strstartswith(team, "<dev string:x207>") && target.team != players[i].team) {
                        continue;
                    }
                }
                if (isdefined(spawn_origin)) {
                    players[i] setorigin(spawn_origin);
                    continue;
                }
                if (nodes.size > 0) {
                    node = array::random(nodes);
                    players[i] setorigin(node.origin);
                    continue;
                }
                players[i] setorigin(origin);
            }
        }
        setdvar("<dev string:x213>", "<dev string:x46>");
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x8c070c5, Offset: 0x1270
    // Size: 0x454
    function updatedevsettingszm() {
        if (level.players.size > 0) {
            if (getdvarstring("<dev string:x222>") == "<dev string:x237>") {
                if (!isdefined(level.streamdumpteamindex)) {
                    level.streamdumpteamindex = 0;
                } else {
                    level.streamdumpteamindex++;
                }
                numpoints = 0;
                spawnpoints = [];
                location = level.scr_zm_map_start_location;
                if ((location == "<dev string:x239>" || location == "<dev string:x46>") && isdefined(level.default_start_location)) {
                    location = level.default_start_location;
                }
                match_string = level.scr_zm_ui_gametype + "<dev string:x241>" + location;
                if (level.streamdumpteamindex < level.teams.size) {
                    structs = struct::get_array("<dev string:x243>", "<dev string:x251>");
                    if (isdefined(structs)) {
                        foreach (struct in structs) {
                            if (isdefined(struct.script_string)) {
                                tokens = strtok(struct.script_string, "<dev string:x263>");
                                foreach (token in tokens) {
                                    if (token == match_string) {
                                        spawnpoints[spawnpoints.size] = struct;
                                    }
                                }
                            }
                        }
                    }
                    if (!isdefined(spawnpoints) || spawnpoints.size == 0) {
                        spawnpoints = struct::get_array("<dev string:x265>", "<dev string:x27a>");
                    }
                    if (isdefined(spawnpoints)) {
                        numpoints = spawnpoints.size;
                    }
                }
                if (numpoints == 0) {
                    setdvar("<dev string:x222>", "<dev string:x47>");
                    level.streamdumpteamindex = -1;
                    return;
                }
                averageorigin = (0, 0, 0);
                averageangles = (0, 0, 0);
                foreach (spawnpoint in spawnpoints) {
                    averageorigin += spawnpoint.origin / numpoints;
                    averageangles += spawnpoint.angles / numpoints;
                }
                level.players[0] setplayerangles(averageangles);
                level.players[0] setorigin(averageorigin);
                wait 5;
                setdvar("<dev string:x222>", "<dev string:x285>");
            }
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0xe5697c3c, Offset: 0x16d0
    // Size: 0x24de
    function updatedevsettings() {
        show_spawns = getdvarint("<dev string:x37>");
        show_start_spawns = getdvarint("<dev string:x49>");
        player = util::gethostplayer();
        if (show_spawns >= 1) {
            show_spawns = 1;
        } else {
            show_spawns = 0;
        }
        if (show_start_spawns >= 1) {
            show_start_spawns = 1;
        } else {
            show_start_spawns = 0;
        }
        if (!isdefined(level.show_spawns) || level.show_spawns != show_spawns) {
            level.show_spawns = show_spawns;
            setdvar("<dev string:x37>", level.show_spawns);
            if (level.show_spawns) {
                showspawnpoints();
            } else {
                hidespawnpoints();
            }
        }
        if (!isdefined(level.show_start_spawns) || level.show_start_spawns != show_start_spawns) {
            level.show_start_spawns = show_start_spawns;
            setdvar("<dev string:x49>", level.show_start_spawns);
            if (level.show_start_spawns) {
                showstartspawnpoints();
            } else {
                hidestartspawnpoints();
            }
        }
        updateminimapsetting();
        if (level.players.size > 0) {
            updatehardpoints();
            function_3d345413();
            playerwarp_string = getdvarstring("<dev string:x213>");
            if (playerwarp_string == "<dev string:x287>") {
                warpalltohost();
            } else if (playerwarp_string == "<dev string:x28c>") {
                warpalltohost(playerwarp_string);
            } else if (playerwarp_string == "<dev string:x299>") {
                warpalltohost(playerwarp_string);
            } else if (strstartswith(playerwarp_string, "<dev string:x1fe>")) {
                name = getsubstr(playerwarp_string, 8);
                warpalltoplayer(playerwarp_string, name);
            } else if (strstartswith(playerwarp_string, "<dev string:x207>")) {
                name = getsubstr(playerwarp_string, 11);
                warpalltoplayer(playerwarp_string, name);
            } else if (strstartswith(playerwarp_string, "<dev string:x2a9>")) {
                name = getsubstr(playerwarp_string, 4);
                warpalltoplayer(undefined, name);
            } else if (playerwarp_string == "<dev string:x2ae>") {
                players = getplayers();
                setdvar("<dev string:x213>", "<dev string:x46>");
                if (!isdefined(level.devgui_start_spawn_index)) {
                    level.devgui_start_spawn_index = 0;
                }
                player = util::gethostplayer();
                spawns = level.spawn_start[player.pers["<dev string:x2bf>"]];
                if (!isdefined(spawns) || spawns.size <= 0) {
                    return;
                }
                for (i = 0; i < players.size; i++) {
                    players[i] setorigin(spawns[level.devgui_start_spawn_index].origin);
                    players[i] setplayerangles(spawns[level.devgui_start_spawn_index].angles);
                }
                level.devgui_start_spawn_index++;
                if (level.devgui_start_spawn_index >= spawns.size) {
                    level.devgui_start_spawn_index = 0;
                }
            } else if (playerwarp_string == "<dev string:x2c4>") {
                players = getplayers();
                setdvar("<dev string:x213>", "<dev string:x46>");
                if (!isdefined(level.devgui_start_spawn_index)) {
                    level.devgui_start_spawn_index = 0;
                }
                player = util::gethostplayer();
                spawns = level.spawn_start[player.pers["<dev string:x2bf>"]];
                if (!isdefined(spawns) || spawns.size <= 0) {
                    return;
                }
                for (i = 0; i < players.size; i++) {
                    players[i] setorigin(spawns[level.devgui_start_spawn_index].origin);
                    players[i] setplayerangles(spawns[level.devgui_start_spawn_index].angles);
                }
                level.devgui_start_spawn_index--;
                if (level.devgui_start_spawn_index < 0) {
                    level.devgui_start_spawn_index = spawns.size - 1;
                }
            } else if (playerwarp_string == "<dev string:x2d5>") {
                players = getplayers();
                setdvar("<dev string:x213>", "<dev string:x46>");
                if (!isdefined(level.devgui_spawn_index)) {
                    level.devgui_spawn_index = 0;
                }
                spawns = level.spawnpoints;
                spawns = arraycombine(spawns, level.dem_spawns, 1, 0);
                if (!isdefined(spawns) || spawns.size <= 0) {
                    return;
                }
                for (i = 0; i < players.size; i++) {
                    players[i] setorigin(spawns[level.devgui_spawn_index].origin);
                    players[i] setplayerangles(spawns[level.devgui_spawn_index].angles);
                }
                level.devgui_spawn_index++;
                if (level.devgui_spawn_index >= spawns.size) {
                    level.devgui_spawn_index = 0;
                }
            } else if (playerwarp_string == "<dev string:x2e0>") {
                players = getplayers();
                setdvar("<dev string:x213>", "<dev string:x46>");
                if (!isdefined(level.devgui_spawn_index)) {
                    level.devgui_spawn_index = 0;
                }
                spawns = level.spawnpoints;
                spawns = arraycombine(spawns, level.dem_spawns, 1, 0);
                if (!isdefined(spawns) || spawns.size <= 0) {
                    return;
                }
                for (i = 0; i < players.size; i++) {
                    players[i] setorigin(spawns[level.devgui_spawn_index].origin);
                    players[i] setplayerangles(spawns[level.devgui_spawn_index].angles);
                }
                level.devgui_spawn_index--;
                if (level.devgui_spawn_index < 0) {
                    level.devgui_spawn_index = spawns.size - 1;
                }
            } else if (getdvarstring("<dev string:x2eb>") != "<dev string:x46>") {
                player = util::gethostplayer();
                if (!isdefined(player.devgui_spawn_active)) {
                    player.devgui_spawn_active = 0;
                }
                if (!player.devgui_spawn_active) {
                    iprintln("<dev string:x2fc>");
                    iprintln("<dev string:x31f>");
                    player.devgui_spawn_active = 1;
                    player thread devgui_spawn_think();
                } else {
                    player notify(#"devgui_spawn_think");
                    player.devgui_spawn_active = 0;
                    player setactionslot(3, "<dev string:x33f>");
                }
                setdvar("<dev string:x2eb>", "<dev string:x46>");
            } else if (getdvarstring("<dev string:x347>") != "<dev string:x46>") {
                players = getplayers();
                if (!isdefined(level.devgui_unlimited_ammo)) {
                    level.devgui_unlimited_ammo = 1;
                } else {
                    level.devgui_unlimited_ammo = !level.devgui_unlimited_ammo;
                }
                if (level.devgui_unlimited_ammo) {
                    iprintln("<dev string:x357>");
                } else {
                    iprintln("<dev string:x37c>");
                }
                for (i = 0; i < players.size; i++) {
                    if (level.devgui_unlimited_ammo) {
                        players[i] thread devgui_unlimited_ammo();
                        continue;
                    }
                    players[i] notify(#"devgui_unlimited_ammo");
                }
                setdvar("<dev string:x347>", "<dev string:x46>");
            } else if (getdvarstring("<dev string:x3a4>") != "<dev string:x46>") {
                if (!isdefined(level.devgui_unlimited_momentum)) {
                    level.devgui_unlimited_momentum = 1;
                } else {
                    level.devgui_unlimited_momentum = !level.devgui_unlimited_momentum;
                }
                if (level.devgui_unlimited_momentum) {
                    iprintln("<dev string:x3b8>");
                    level thread devgui_unlimited_momentum();
                } else {
                    iprintln("<dev string:x3e1>");
                    level notify(#"devgui_unlimited_momentum");
                }
                setdvar("<dev string:x3a4>", "<dev string:x46>");
            } else if (getdvarstring("<dev string:x40d>") != "<dev string:x46>") {
                level thread devgui_increase_momentum(getdvarint("<dev string:x40d>"));
                setdvar("<dev string:x40d>", "<dev string:x46>");
            } else if (getdvarstring("<dev string:x423>") != "<dev string:x46>") {
                players = getplayers();
                for (i = 0; i < players.size; i++) {
                    player = players[i];
                    weapons = player getweaponslist();
                    arrayremovevalue(weapons, level.weaponbasemelee);
                    for (j = 0; j < weapons.size; j++) {
                        if (weapons[j] == level.weaponnone) {
                            continue;
                        }
                        player setweaponammostock(weapons[j], 0);
                        player setweaponammoclip(weapons[j], 0);
                    }
                }
                setdvar("<dev string:x423>", "<dev string:x46>");
            } else if (getdvarstring("<dev string:x438>") != "<dev string:x46>") {
                players = getplayers();
                for (i = 0; i < players.size; i++) {
                    player = players[i];
                    if (getdvarstring("<dev string:x438>") == "<dev string:x47>") {
                        player setempjammed(0);
                        continue;
                    }
                    player setempjammed(1);
                }
                setdvar("<dev string:x438>", "<dev string:x46>");
            } else if (getdvarstring("<dev string:x447>") != "<dev string:x46>") {
                if (!level.timerstopped) {
                    iprintln("<dev string:x457>");
                    globallogic_utils::pausetimer();
                } else {
                    iprintln("<dev string:x46b>");
                    globallogic_utils::resumetimer();
                }
                setdvar("<dev string:x447>", "<dev string:x46>");
            } else if (getdvarstring("<dev string:x480>") != "<dev string:x46>") {
                level globallogic::forceend();
                setdvar("<dev string:x480>", "<dev string:x46>");
            } else if (getdvarstring("<dev string:x48e>") != "<dev string:x47>") {
                players = getplayers();
                host = util::gethostplayer();
                if (!isdefined(host.devgui_health_debug)) {
                    host.devgui_health_debug = 0;
                }
                if (host.devgui_health_debug) {
                    host.devgui_health_debug = 0;
                    for (i = 0; i < players.size; i++) {
                        players[i] notify(#"devgui_health_debug");
                        if (isdefined(players[i].debug_health_bar)) {
                            players[i].debug_health_bar destroy();
                            players[i].debug_health_text destroy();
                            players[i].debug_health_bar = undefined;
                            players[i].debug_health_text = undefined;
                        }
                    }
                } else {
                    host.devgui_health_debug = 1;
                    for (i = 0; i < players.size; i++) {
                        players[i] thread devgui_health_debug();
                    }
                }
                setdvar("<dev string:x48e>", "<dev string:x46>");
            } else if (getdvarstring("<dev string:xa6>") != "<dev string:x46>") {
                if (!isdefined(level.devgui_show_hq)) {
                    level.devgui_show_hq = 0;
                }
                if (level.gametype == "<dev string:x49f>" && isdefined(level.radios)) {
                    if (!level.devgui_show_hq) {
                        for (i = 0; i < level.radios.size; i++) {
                            color = (1, 0, 0);
                            level showonespawnpoint(level.radios[i], color, "<dev string:x4a4>", 32, "<dev string:x4b3>");
                        }
                    } else {
                        level notify(#"hide_hq_points");
                    }
                    level.devgui_show_hq = !level.devgui_show_hq;
                }
                setdvar("<dev string:xa6>", "<dev string:x46>");
            }
            if (getdvarstring("<dev string:x222>") == "<dev string:x237>") {
                if (!isdefined(level.streamdumpteamindex)) {
                    level.streamdumpteamindex = 0;
                } else {
                    level.streamdumpteamindex++;
                }
                numpoints = 0;
                if (level.streamdumpteamindex < level.teams.size) {
                    teamname = getarraykeys(level.teams)[level.streamdumpteamindex];
                    if (isdefined(level.spawn_start[teamname])) {
                        numpoints = level.spawn_start[teamname].size;
                    }
                }
                if (numpoints == 0) {
                    setdvar("<dev string:x222>", "<dev string:x47>");
                    level.streamdumpteamindex = -1;
                } else {
                    averageorigin = (0, 0, 0);
                    averageangles = (0, 0, 0);
                    foreach (spawnpoint in level.spawn_start[teamname]) {
                        averageorigin += spawnpoint.origin / numpoints;
                        averageangles += spawnpoint.angles / numpoints;
                    }
                    level.players[0] setplayerangles(averageangles);
                    level.players[0] setorigin(averageorigin);
                    wait 5;
                    setdvar("<dev string:x222>", "<dev string:x285>");
                }
            }
        }
        if (getdvarstring("<dev string:xd4>") == "<dev string:x47>") {
            players = getplayers();
            iprintln("<dev string:x4bc>");
            for (i = 0; i < players.size; i++) {
                players[i] clearperks();
            }
            setdvar("<dev string:xd4>", "<dev string:x46>");
        }
        if (getdvarstring("<dev string:xd4>") != "<dev string:x46>") {
            perk = getdvarstring("<dev string:xd4>");
            specialties = strtok(perk, "<dev string:x4de>");
            players = getplayers();
            iprintln("<dev string:x4e0>" + perk + "<dev string:x4fb>");
            for (i = 0; i < players.size; i++) {
                for (j = 0; j < specialties.size; j++) {
                    players[i] setperk(specialties[j]);
                    players[i].extraperks[specialties[j]] = 1;
                }
            }
            setdvar("<dev string:xd4>", "<dev string:x46>");
        }
        if (getdvarstring("<dev string:x4fd>") != "<dev string:x46>") {
            force_grenade_throw(getweapon(getdvarstring("<dev string:x4fd>")));
            setdvar("<dev string:x4fd>", "<dev string:x46>");
        }
        if (getdvarstring("<dev string:xe1>") != "<dev string:x46>") {
            event = getdvarstring("<dev string:xe1>");
            player = util::gethostplayer();
            forward = anglestoforward(player.angles);
            right = anglestoright(player.angles);
            if (event == "<dev string:x50e>") {
                player dodamage(1, player.origin + forward);
            } else if (event == "<dev string:x518>") {
                player dodamage(1, player.origin - forward);
            } else if (event == "<dev string:x521>") {
                player dodamage(1, player.origin - right);
            } else if (event == "<dev string:x52a>") {
                player dodamage(1, player.origin + right);
            }
            setdvar("<dev string:xe1>", "<dev string:x46>");
        }
        if (getdvarstring("<dev string:x534>") != "<dev string:x46>") {
            perk = getdvarstring("<dev string:x534>");
            for (i = 0; i < level.players.size; i++) {
                level.players[i] unsetperk(perk);
                level.players[i].extraperks[perk] = undefined;
            }
            setdvar("<dev string:x534>", "<dev string:x46>");
        }
        if (getdvarstring("<dev string:x541>") != "<dev string:x46>") {
            nametokens = strtok(getdvarstring("<dev string:x541>"), "<dev string:x263>");
            if (nametokens.size > 1) {
                thread xkillsy(nametokens[0], nametokens[1]);
            }
            setdvar("<dev string:x541>", "<dev string:x46>");
        }
        if (getdvarstring("<dev string:x54f>") != "<dev string:x46>") {
            ownername = getdvarstring("<dev string:x54f>");
            setdvar("<dev string:x54f>", "<dev string:x46>");
            owner = undefined;
            for (index = 0; index < level.players.size; index++) {
                if (level.players[index].name == ownername) {
                    owner = level.players[index];
                }
            }
            if (isdefined(owner)) {
                owner killstreaks::trigger_killstreak("<dev string:x55b>");
            }
        }
        if (getdvarstring("<dev string:x560>") != "<dev string:x46>") {
            player.pers["<dev string:x56e>"] = 0;
            player.pers["<dev string:x573>"] = 0;
            newrank = min(getdvarint("<dev string:x560>"), 54);
            newrank = max(newrank, 1);
            setdvar("<dev string:x560>", "<dev string:x46>");
            lastxp = 0;
            for (index = 0; index <= newrank; index++) {
                newxp = rank::getrankinfominxp(index);
                player thread rank::giverankxp("<dev string:x57a>", newxp - lastxp);
                lastxp = newxp;
                wait 0.25;
                self notify(#"cancel_notify");
            }
        }
        if (getdvarstring("<dev string:x57f>") != "<dev string:x46>") {
            player thread rank::giverankxp("<dev string:x58a>", getdvarint("<dev string:x57f>"), 1);
            setdvar("<dev string:x57f>", "<dev string:x46>");
        }
        if (getdvarstring("<dev string:x594>") != "<dev string:x46>") {
            for (i = 0; i < level.players.size; i++) {
                level.players[i] hud_message::function_2bb1fc0(getdvarstring("<dev string:x594>"), getdvarstring("<dev string:x594>"), game["<dev string:x5a2>"]["<dev string:x5a8>"]);
            }
            announcement(getdvarstring("<dev string:x594>"), 0);
            setdvar("<dev string:x594>", "<dev string:x46>");
        }
        if (getdvarstring("<dev string:x5af>") != "<dev string:x46>") {
            ents = getentarray();
            level.entarray = [];
            level.entcounts = [];
            level.entgroups = [];
            for (index = 0; index < ents.size; index++) {
                classname = ents[index].classname;
                if (!issubstr(classname, "<dev string:x5bc>")) {
                    curent = ents[index];
                    level.entarray[level.entarray.size] = curent;
                    if (!isdefined(level.entcounts[classname])) {
                        level.entcounts[classname] = 0;
                    }
                    level.entcounts[classname]++;
                    if (!isdefined(level.entgroups[classname])) {
                        level.entgroups[classname] = [];
                    }
                    level.entgroups[classname][level.entgroups[classname].size] = curent;
                }
            }
        }
        if (getdvarstring("<dev string:x102>") == "<dev string:x5c3>" && !isdefined(level.larry)) {
            thread larry_thread();
        } else if (getdvarstring("<dev string:x102>") == "<dev string:x47>") {
            level notify(#"kill_larry");
        }
        if (level.var_391ebc05 == 0 && getdvarint("<dev string:x5c5>") == 1) {
            level thread function_fdfd1b20();
            level.var_391ebc05 = 1;
        } else if (level.var_391ebc05 == 1 && getdvarint("<dev string:x5c5>") == 0) {
            level function_7e05f110();
            level.var_391ebc05 = 0;
        }
        if (level.var_bbc3085f == 0 && getdvarint("<dev string:x5d5>") == 1) {
            level thread function_97fd4406();
            level.var_bbc3085f = 1;
        } else if (level.var_bbc3085f == 1 && getdvarint("<dev string:x5d5>") == 0) {
            level function_b4aa652();
            level.var_bbc3085f = 0;
        }
        if (level.var_f1d22fe == 0 && getdvarint("<dev string:x5e4>") == 1) {
            level thread function_194def6b();
            level.var_f1d22fe = 1;
        } else if (level.var_f1d22fe == 1 && getdvarint("<dev string:x5e4>") == 0) {
            level function_aab0cfd5();
            level.var_f1d22fe = 0;
        }
        if (getdvarint("<dev string:x5f1>") == 1) {
            level thread killcam::do_final_killcam();
            level thread waitthennotifyfinalkillcam();
        }
        if (getdvarint("<dev string:x608>") == 1) {
            level thread killcam::do_final_killcam();
            level thread waitthennotifyroundkillcam();
        }
        if (!level.var_391ebc05 && !level.var_bbc3085f && !level.var_f1d22fe) {
            level notify(#"hash_7c01e4c4");
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0xaa2f7617, Offset: 0x3bb8
    // Size: 0x3c
    function waitthennotifyroundkillcam() {
        wait 0.05;
        level notify(#"play_final_killcam");
        setdvar("<dev string:x608>", 0);
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0xdadd415a, Offset: 0x3c00
    // Size: 0x44
    function waitthennotifyfinalkillcam() {
        wait 0.05;
        level notify(#"play_final_killcam");
        wait 0.05;
        setdvar("<dev string:x5f1>", 0);
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x2b40e928, Offset: 0x3c50
    // Size: 0x18c
    function devgui_spawn_think() {
        self notify(#"devgui_spawn_think");
        self endon(#"devgui_spawn_think");
        self endon(#"disconnect");
        dpad_left = 0;
        dpad_right = 0;
        for (;;) {
            self setactionslot(3, "<dev string:x46>");
            self setactionslot(4, "<dev string:x46>");
            if (!dpad_left && self buttonpressed("<dev string:x61f>")) {
                setdvar("<dev string:x213>", "<dev string:x2e0>");
                dpad_left = 1;
            } else if (!self buttonpressed("<dev string:x61f>")) {
                dpad_left = 0;
            }
            if (!dpad_right && self buttonpressed("<dev string:x629>")) {
                setdvar("<dev string:x213>", "<dev string:x2d5>");
                dpad_right = 1;
            } else if (!self buttonpressed("<dev string:x629>")) {
                dpad_right = 0;
            }
            wait 0.05;
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x27a030a3, Offset: 0x3de8
    // Size: 0x162
    function devgui_unlimited_ammo() {
        self notify(#"devgui_unlimited_ammo");
        self endon(#"devgui_unlimited_ammo");
        self endon(#"disconnect");
        for (;;) {
            wait 1;
            primary_weapons = self getweaponslistprimaries();
            offhand_weapons_and_alts = array::exclude(self getweaponslist(1), primary_weapons);
            weapons = arraycombine(primary_weapons, offhand_weapons_and_alts, 0, 0);
            arrayremovevalue(weapons, level.weaponbasemelee);
            for (i = 0; i < weapons.size; i++) {
                weapon = weapons[i];
                if (weapon == level.weaponnone) {
                    continue;
                }
                if (killstreaks::is_killstreak_weapon(weapon)) {
                    continue;
                }
                self givemaxammo(weapon);
            }
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x71b2d8b6, Offset: 0x3f58
    // Size: 0x11e
    function devgui_unlimited_momentum() {
        level notify(#"devgui_unlimited_momentum");
        level endon(#"devgui_unlimited_momentum");
        for (;;) {
            wait 1;
            players = getplayers();
            foreach (player in players) {
                if (!isdefined(player)) {
                    continue;
                }
                if (!isalive(player)) {
                    continue;
                }
                if (player.sessionstate != "<dev string:x634>") {
                    continue;
                }
                globallogic_score::_setplayermomentum(player, 5000);
            }
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x0
    // Checksum 0x50fb2a68, Offset: 0x4080
    // Size: 0x112
    function devgui_increase_momentum(score) {
        players = getplayers();
        foreach (player in players) {
            if (!isdefined(player)) {
                continue;
            }
            if (!isalive(player)) {
                continue;
            }
            if (player.sessionstate != "<dev string:x634>") {
                continue;
            }
            player globallogic_score::giveplayermomentumnotification(score, %"<dev string:x63c>", "<dev string:x652>");
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x156bcb9f, Offset: 0x41a0
    // Size: 0x318
    function devgui_health_debug() {
        self notify(#"devgui_health_debug");
        self endon(#"devgui_health_debug");
        self endon(#"disconnect");
        x = 80;
        y = 40;
        self.debug_health_bar = newclienthudelem(self);
        self.debug_health_bar.x = x + 80;
        self.debug_health_bar.y = y + 2;
        self.debug_health_bar.alignx = "<dev string:x65f>";
        self.debug_health_bar.aligny = "<dev string:x664>";
        self.debug_health_bar.horzalign = "<dev string:x668>";
        self.debug_health_bar.vertalign = "<dev string:x668>";
        self.debug_health_bar.alpha = 1;
        self.debug_health_bar.foreground = 1;
        self.debug_health_bar setshader("<dev string:x673>", 1, 8);
        self.debug_health_text = newclienthudelem(self);
        self.debug_health_text.x = x + 80;
        self.debug_health_text.y = y;
        self.debug_health_text.alignx = "<dev string:x65f>";
        self.debug_health_text.aligny = "<dev string:x664>";
        self.debug_health_text.horzalign = "<dev string:x668>";
        self.debug_health_text.vertalign = "<dev string:x668>";
        self.debug_health_text.alpha = 1;
        self.debug_health_text.fontscale = 1;
        self.debug_health_text.foreground = 1;
        if (!isdefined(self.maxhealth) || self.maxhealth <= 0) {
            self.maxhealth = 100;
        }
        for (;;) {
            wait 0.05;
            width = self.health / self.maxhealth * 300;
            width = int(max(width, 1));
            self.debug_health_bar setshader("<dev string:x673>", width, 8);
            self.debug_health_text setvalue(self.health);
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0xe50d0b39, Offset: 0x44c0
    // Size: 0xc6
    function giveextraperks() {
        if (!isdefined(self.extraperks)) {
            return;
        }
        perks = getarraykeys(self.extraperks);
        for (i = 0; i < perks.size; i++) {
            println("<dev string:x679>" + self.name + "<dev string:x684>" + perks[i] + "<dev string:x68f>");
            self setperk(perks[i]);
        }
    }

    // Namespace dev
    // Params 2, eflags: 0x0
    // Checksum 0xbc81e1ed, Offset: 0x4590
    // Size: 0x14c
    function xkillsy(attackername, victimname) {
        attacker = undefined;
        victim = undefined;
        for (index = 0; index < level.players.size; index++) {
            if (level.players[index].name == attackername) {
                attacker = level.players[index];
                continue;
            }
            if (level.players[index].name == victimname) {
                victim = level.players[index];
            }
        }
        if (!isalive(attacker) || !isalive(victim)) {
            return;
        }
        victim thread [[ level.callbackplayerdamage ]](attacker, attacker, 1000, 0, "<dev string:x69d>", level.weaponnone, (0, 0, 0), (0, 0, 0), "<dev string:x6ae>", (0, 0, 0), 0, 0, (1, 0, 0));
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x23fc05b7, Offset: 0x46e8
    // Size: 0x24
    function testscriptruntimeerrorassert() {
        wait 1;
        assert(0);
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0xf0d6b813, Offset: 0x4718
    // Size: 0x2c
    function testscriptruntimeassertmsgassert() {
        wait 1;
        assertmsg("<dev string:x6b3>");
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x6ab82f7, Offset: 0x4750
    // Size: 0x2c
    function testscriptruntimeerrormsgassert() {
        wait 1;
        errormsg("<dev string:x6ca>");
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x967402eb, Offset: 0x4788
    // Size: 0x44
    function testscriptruntimeerror2() {
        myundefined = "<dev string:x6e0>";
        if (myundefined == 1) {
            println("<dev string:x6e5>");
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x99f770e5, Offset: 0x47d8
    // Size: 0x1c
    function testscriptruntimeerror1() {
        testscriptruntimeerror2();
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x8f8af74d, Offset: 0x4800
    // Size: 0x11c
    function testscriptruntimeerror() {
        wait 5;
        for (;;) {
            if (getdvarstring("<dev string:xb9>") != "<dev string:x47>") {
                break;
            }
            wait 1;
        }
        myerror = getdvarstring("<dev string:xb9>");
        setdvar("<dev string:xb9>", "<dev string:x47>");
        if (myerror == "<dev string:x70b>") {
            testscriptruntimeerrorassert();
        } else if (myerror == "<dev string:x712>") {
            testscriptruntimeassertmsgassert();
        } else if (myerror == "<dev string:x71c>") {
            testscriptruntimeerrormsgassert();
        } else {
            testscriptruntimeerror1();
        }
        thread testscriptruntimeerror();
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x85eef04e, Offset: 0x4928
    // Size: 0xf4
    function testdvars() {
        wait 5;
        for (;;) {
            if (getdvarstring("<dev string:x725>") != "<dev string:x46>") {
                break;
            }
            wait 1;
        }
        tokens = strtok(getdvarstring("<dev string:x725>"), "<dev string:x263>");
        dvarname = tokens[0];
        dvarvalue = tokens[1];
        setdvar(dvarname, dvarvalue);
        setdvar("<dev string:x725>", "<dev string:x46>");
        thread testdvars();
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x953b8ad6, Offset: 0x4a28
    // Size: 0x1e4
    function addenemyheli() {
        wait 5;
        for (;;) {
            if (getdvarint("<dev string:x732>") > 0) {
                break;
            }
            wait 1;
        }
        enemyheli = getdvarint("<dev string:x732>");
        setdvar("<dev string:x732>", 0);
        team = "<dev string:x1d4>";
        player = util::gethostplayer();
        if (isdefined(player.pers["<dev string:x2bf>"])) {
            team = util::getotherteam(player.pers["<dev string:x2bf>"]);
        }
        ent = getormakebot(team);
        if (!isdefined(ent)) {
            println("<dev string:x1df>");
            wait 1;
            thread addenemyheli();
            return;
        }
        switch (enemyheli) {
        case 1:
            level.helilocation = ent.origin;
            ent thread helicopter::usekillstreakhelicopter("<dev string:x745>");
            wait 0.5;
            ent notify(#"confirm_location", level.helilocation);
            break;
        case 2:
            break;
        }
        thread addenemyheli();
    }

#/

// Namespace dev
// Params 1, eflags: 0x0
// Checksum 0xaed7c259, Offset: 0x4c18
// Size: 0x108
function getormakebot(team) {
    /#
        for (i = 0; i < level.players.size; i++) {
            if (level.players[i].team == team) {
                if (isdefined(level.players[i].pers["<dev string:x758>"]) && level.players[i].pers["<dev string:x758>"]) {
                    return level.players[i];
                }
            }
        }
        ent = bot::add_bot(team);
        if (isdefined(ent)) {
            sound::play_on_players("<dev string:x75e>");
            wait 1;
        }
        return ent;
    #/
}

/#

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0xd723e670, Offset: 0x4d28
    // Size: 0x20c
    function addtestcarepackage() {
        wait 5;
        for (;;) {
            if (getdvarint("<dev string:x770>") > 0) {
                break;
            }
            wait 1;
        }
        supplydrop = getdvarint("<dev string:x770>");
        team = "<dev string:x1d4>";
        player = util::gethostplayer();
        if (isdefined(player.pers["<dev string:x2bf>"])) {
            switch (supplydrop) {
            case 2:
                team = util::getotherteam(player.pers["<dev string:x2bf>"]);
                break;
            case 1:
            default:
                team = player.pers["<dev string:x2bf>"];
                break;
            }
        }
        setdvar("<dev string:x770>", 0);
        ent = getormakebot(team);
        if (!isdefined(ent)) {
            println("<dev string:x1df>");
            wait 1;
            thread addtestcarepackage();
            return;
        }
        ent killstreakrules::killstreakstart("<dev string:x787>", team);
        ent thread supplydrop::helidelivercrate(ent.origin, getweapon("<dev string:x793>"), ent, team);
        thread addtestcarepackage();
    }

    // Namespace dev
    // Params 5, eflags: 0x0
    // Checksum 0x5fa1b150, Offset: 0x4f40
    // Size: 0x5b6
    function showonespawnpoint(spawn_point, color, notification, height, print) {
        if (!isdefined(height) || height <= 0) {
            height = util::get_player_height();
        }
        if (!isdefined(print)) {
            if (level.convert_spawns_to_structs) {
                print = spawn_point.targetname;
            } else {
                print = spawn_point.classname;
            }
        }
        center = spawn_point.origin;
        forward = anglestoforward(spawn_point.angles);
        right = anglestoright(spawn_point.angles);
        forward = vectorscale(forward, 16);
        right = vectorscale(right, 16);
        a = center + forward - right;
        b = center + forward + right;
        c = center - forward + right;
        d = center - forward - right;
        thread lineuntilnotified(a, b, color, 0, notification);
        thread lineuntilnotified(b, c, color, 0, notification);
        thread lineuntilnotified(c, d, color, 0, notification);
        thread lineuntilnotified(d, a, color, 0, notification);
        thread lineuntilnotified(a, a + (0, 0, height), color, 0, notification);
        thread lineuntilnotified(b, b + (0, 0, height), color, 0, notification);
        thread lineuntilnotified(c, c + (0, 0, height), color, 0, notification);
        thread lineuntilnotified(d, d + (0, 0, height), color, 0, notification);
        a += (0, 0, height);
        b += (0, 0, height);
        c += (0, 0, height);
        d += (0, 0, height);
        thread lineuntilnotified(a, b, color, 0, notification);
        thread lineuntilnotified(b, c, color, 0, notification);
        thread lineuntilnotified(c, d, color, 0, notification);
        thread lineuntilnotified(d, a, color, 0, notification);
        center += (0, 0, height / 2);
        arrow_forward = anglestoforward(spawn_point.angles);
        arrowhead_forward = anglestoforward(spawn_point.angles);
        arrowhead_right = anglestoright(spawn_point.angles);
        arrow_forward = vectorscale(arrow_forward, 32);
        arrowhead_forward = vectorscale(arrowhead_forward, 24);
        arrowhead_right = vectorscale(arrowhead_right, 8);
        a = center + arrow_forward;
        b = center + arrowhead_forward - arrowhead_right;
        c = center + arrowhead_forward + arrowhead_right;
        thread lineuntilnotified(center, a, color, 0, notification);
        thread lineuntilnotified(a, b, color, 0, notification);
        thread lineuntilnotified(a, c, color, 0, notification);
        thread print3duntilnotified(spawn_point.origin + (0, 0, height), print, color, 1, 1, notification);
        return;
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x873925cd, Offset: 0x5500
    // Size: 0xe8
    function showspawnpoints() {
        if (isdefined(level.spawnpoints)) {
            color = (1, 1, 1);
            for (spawn_point_index = 0; spawn_point_index < level.spawnpoints.size; spawn_point_index++) {
                showonespawnpoint(level.spawnpoints[spawn_point_index], color, "<dev string:x79e>");
            }
        }
        for (i = 0; i < level.dem_spawns.size; i++) {
            color = (0, 1, 0);
            showonespawnpoint(level.dem_spawns[i], color, "<dev string:x79e>");
        }
        return;
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x8f477cda, Offset: 0x55f0
    // Size: 0x18
    function hidespawnpoints() {
        level notify(#"hide_spawnpoints");
        return;
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x19da8736, Offset: 0x5610
    // Size: 0x2bc
    function showstartspawnpoints() {
        if (!isdefined(level.spawn_start)) {
            return;
        }
        if (level.teambased) {
            team_colors = [];
            team_colors["<dev string:x7af>"] = (1, 0, 1);
            team_colors["<dev string:x5a8>"] = (0, 1, 1);
            team_colors["<dev string:x7b4>"] = (1, 1, 0);
            team_colors["<dev string:x7ba>"] = (0, 1, 0);
            team_colors["<dev string:x7c0>"] = (0, 0, 1);
            team_colors["<dev string:x7c6>"] = (1, 0.7, 0);
            team_colors["<dev string:x7cc>"] = (0.25, 0.25, 1);
            team_colors["<dev string:x7d2>"] = (0.88, 0, 1);
            foreach (key, color in team_colors) {
                if (!isdefined(level.spawn_start[key])) {
                    continue;
                }
                foreach (spawnpoint in level.spawn_start[key]) {
                    showonespawnpoint(spawnpoint, color, "<dev string:x7d8>");
                }
            }
            return;
        }
        color = (1, 0, 1);
        foreach (spawnpoint in level.spawn_start) {
            showonespawnpoint(spawnpoint, color, "<dev string:x7d8>");
        }
        return;
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x8bac8a46, Offset: 0x58d8
    // Size: 0x18
    function hidestartspawnpoints() {
        level notify(#"hide_startspawnpoints");
        return;
    }

    // Namespace dev
    // Params 6, eflags: 0x0
    // Checksum 0xdc31652c, Offset: 0x58f8
    // Size: 0x70
    function print3duntilnotified(origin, text, color, alpha, scale, notification) {
        level endon(notification);
        for (;;) {
            print3d(origin, text, color, alpha, scale);
            wait 0.05;
        }
    }

    // Namespace dev
    // Params 5, eflags: 0x0
    // Checksum 0xf629061e, Offset: 0x5970
    // Size: 0x68
    function lineuntilnotified(start, end, color, depthtest, notification) {
        level endon(notification);
        for (;;) {
            line(start, end, color, depthtest);
            wait 0.05;
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0xfa58c923, Offset: 0x59e0
    // Size: 0x160
    function engagement_distance_debug_toggle() {
        level endon(#"kill_engage_dist_debug_toggle_watcher");
        if (!isdefined(getdvarint("<dev string:x7ee>"))) {
            setdvar("<dev string:x7ee>", "<dev string:x47>");
        }
        laststate = getdvarint("<dev string:x7ee>", 0);
        while (true) {
            currentstate = getdvarint("<dev string:x7ee>", 0);
            if (dvar_turned_on(currentstate) && !dvar_turned_on(laststate)) {
                weapon_engage_dists_init();
                thread debug_realtime_engage_dist();
                laststate = currentstate;
            } else if (!dvar_turned_on(currentstate) && dvar_turned_on(laststate)) {
                level notify(#"kill_all_engage_dist_debug");
                laststate = currentstate;
            }
            wait 0.3;
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x0
    // Checksum 0x5aec9da2, Offset: 0x5b48
    // Size: 0x2a
    function dvar_turned_on(val) {
        if (val <= 0) {
            return 0;
        }
        return 1;
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x18123ce9, Offset: 0x5b80
    // Size: 0x3bc
    function engagement_distance_debug_init() {
        level.debug_xpos = -50;
        level.debug_ypos = -6;
        level.debug_yinc = 18;
        level.debug_fontscale = 1.5;
        level.white = (1, 1, 1);
        level.green = (0, 1, 0);
        level.yellow = (1, 1, 0);
        level.red = (1, 0, 0);
        level.realtimeengagedist = newhudelem();
        level.realtimeengagedist.alignx = "<dev string:x65f>";
        level.realtimeengagedist.fontscale = level.debug_fontscale;
        level.realtimeengagedist.x = level.debug_xpos;
        level.realtimeengagedist.y = level.debug_ypos;
        level.realtimeengagedist.color = level.white;
        level.realtimeengagedist settext("<dev string:x801>");
        xpos = level.debug_xpos + -49;
        level.realtimeengagedist_value = newhudelem();
        level.realtimeengagedist_value.alignx = "<dev string:x65f>";
        level.realtimeengagedist_value.fontscale = level.debug_fontscale;
        level.realtimeengagedist_value.x = xpos;
        level.realtimeengagedist_value.y = level.debug_ypos;
        level.realtimeengagedist_value.color = level.white;
        level.realtimeengagedist_value setvalue(0);
        xpos += 37;
        level.realtimeengagedist_middle = newhudelem();
        level.realtimeengagedist_middle.alignx = "<dev string:x65f>";
        level.realtimeengagedist_middle.fontscale = level.debug_fontscale;
        level.realtimeengagedist_middle.x = xpos;
        level.realtimeengagedist_middle.y = level.debug_ypos;
        level.realtimeengagedist_middle.color = level.white;
        level.realtimeengagedist_middle settext("<dev string:x81f>");
        xpos += 105;
        level.realtimeengagedist_offvalue = newhudelem();
        level.realtimeengagedist_offvalue.alignx = "<dev string:x65f>";
        level.realtimeengagedist_offvalue.fontscale = level.debug_fontscale;
        level.realtimeengagedist_offvalue.x = xpos;
        level.realtimeengagedist_offvalue.y = level.debug_ypos;
        level.realtimeengagedist_offvalue.color = level.white;
        level.realtimeengagedist_offvalue setvalue(0);
        hudobjarray = [];
        hudobjarray[0] = level.realtimeengagedist;
        hudobjarray[1] = level.realtimeengagedist_value;
        hudobjarray[2] = level.realtimeengagedist_middle;
        hudobjarray[3] = level.realtimeengagedist_offvalue;
        return hudobjarray;
    }

    // Namespace dev
    // Params 2, eflags: 0x0
    // Checksum 0x6d743a90, Offset: 0x5f48
    // Size: 0x66
    function engage_dist_debug_hud_destroy(hudarray, killnotify) {
        level waittill(killnotify);
        for (i = 0; i < hudarray.size; i++) {
            hudarray[i] destroy();
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x8ba9f94a, Offset: 0x5fb8
    // Size: 0x8c4
    function weapon_engage_dists_init() {
        level.engagedists = [];
        genericpistol = spawnstruct();
        genericpistol.engagedistmin = 125;
        genericpistol.engagedistoptimal = -31;
        genericpistol.engagedistmulligan = 50;
        genericpistol.engagedistmax = 400;
        shotty = spawnstruct();
        shotty.engagedistmin = 50;
        shotty.engagedistoptimal = -56;
        shotty.engagedistmulligan = 75;
        shotty.engagedistmax = 350;
        genericsmg = spawnstruct();
        genericsmg.engagedistmin = 100;
        genericsmg.engagedistoptimal = 275;
        genericsmg.engagedistmulligan = 100;
        genericsmg.engagedistmax = 500;
        genericlmg = spawnstruct();
        genericlmg.engagedistmin = 325;
        genericlmg.engagedistoptimal = 550;
        genericlmg.engagedistmulligan = -106;
        genericlmg.engagedistmax = 850;
        genericriflesa = spawnstruct();
        genericriflesa.engagedistmin = 325;
        genericriflesa.engagedistoptimal = 550;
        genericriflesa.engagedistmulligan = -106;
        genericriflesa.engagedistmax = 850;
        genericriflebolt = spawnstruct();
        genericriflebolt.engagedistmin = 350;
        genericriflebolt.engagedistoptimal = 600;
        genericriflebolt.engagedistmulligan = -106;
        genericriflebolt.engagedistmax = 900;
        generichmg = spawnstruct();
        generichmg.engagedistmin = 390;
        generichmg.engagedistoptimal = 600;
        generichmg.engagedistmulligan = 100;
        generichmg.engagedistmax = 900;
        genericsniper = spawnstruct();
        genericsniper.engagedistmin = 950;
        genericsniper.engagedistoptimal = 1700;
        genericsniper.engagedistmulligan = 300;
        genericsniper.engagedistmax = 3000;
        engage_dists_add("<dev string:x836>", genericpistol);
        engage_dists_add("<dev string:x83b>", genericpistol);
        engage_dists_add("<dev string:x841>", genericpistol);
        engage_dists_add("<dev string:x849>", genericpistol);
        engage_dists_add("<dev string:x851>", genericsmg);
        engage_dists_add("<dev string:x85a>", genericsmg);
        engage_dists_add("<dev string:x866>", genericsmg);
        engage_dists_add("<dev string:x86b>", genericsmg);
        engage_dists_add("<dev string:x870>", genericsmg);
        engage_dists_add("<dev string:x876>", genericsmg);
        engage_dists_add("<dev string:x87b>", genericsmg);
        engage_dists_add("<dev string:x889>", shotty);
        engage_dists_add("<dev string:x891>", genericlmg);
        engage_dists_add("<dev string:x895>", genericlmg);
        engage_dists_add("<dev string:x89f>", genericlmg);
        engage_dists_add("<dev string:x8aa>", genericlmg);
        engage_dists_add("<dev string:x8bb>", genericlmg);
        engage_dists_add("<dev string:x8c0>", genericlmg);
        engage_dists_add("<dev string:x8cb>", genericlmg);
        engage_dists_add("<dev string:x8d0>", genericlmg);
        engage_dists_add("<dev string:x8db>", genericlmg);
        engage_dists_add("<dev string:x8e0>", genericlmg);
        engage_dists_add("<dev string:x8eb>", genericriflesa);
        engage_dists_add("<dev string:x8f4>", genericriflesa);
        engage_dists_add("<dev string:x8fe>", genericriflesa);
        engage_dists_add("<dev string:x904>", genericriflesa);
        engage_dists_add("<dev string:x90d>", genericriflebolt);
        engage_dists_add("<dev string:x919>", genericriflebolt);
        engage_dists_add("<dev string:x926>", genericriflebolt);
        engage_dists_add("<dev string:x932>", genericriflebolt);
        engage_dists_add("<dev string:x939>", genericriflebolt);
        engage_dists_add("<dev string:x945>", generichmg);
        engage_dists_add("<dev string:x94b>", generichmg);
        engage_dists_add("<dev string:x957>", generichmg);
        engage_dists_add("<dev string:x95c>", generichmg);
        engage_dists_add("<dev string:x967>", genericsniper);
        engage_dists_add("<dev string:x97a>", genericsniper);
        engage_dists_add("<dev string:x98e>", genericsniper);
        engage_dists_add("<dev string:x9a1>", genericsniper);
        engage_dists_add("<dev string:x9af>", genericsniper);
        engage_dists_add("<dev string:x9bb>", genericsniper);
        level thread engage_dists_watcher();
    }

    // Namespace dev
    // Params 2, eflags: 0x0
    // Checksum 0xd0850ea4, Offset: 0x6888
    // Size: 0x3e
    function engage_dists_add(weaponname, values) {
        level.engagedists[getweapon(weaponname)] = values;
    }

    // Namespace dev
    // Params 1, eflags: 0x0
    // Checksum 0xa8b80d86, Offset: 0x68d0
    // Size: 0x3a
    function get_engage_dists(weapon) {
        if (isdefined(level.engagedists[weapon])) {
            return level.engagedists[weapon];
        }
        return undefined;
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x27f13cb3, Offset: 0x6918
    // Size: 0x11c
    function engage_dists_watcher() {
        level endon(#"kill_all_engage_dist_debug");
        level endon(#"kill_engage_dists_watcher");
        while (true) {
            player = util::gethostplayer();
            playerweapon = player getcurrentweapon();
            if (!isdefined(player.lastweapon)) {
                player.lastweapon = playerweapon;
            } else if (player.lastweapon == playerweapon) {
                wait 0.05;
                continue;
            }
            values = get_engage_dists(playerweapon);
            if (isdefined(values)) {
                level.weaponengagedistvalues = values;
            } else {
                level.weaponengagedistvalues = undefined;
            }
            player.lastweapon = playerweapon;
            wait 0.05;
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0xe6fc00d7, Offset: 0x6a40
    // Size: 0x498
    function debug_realtime_engage_dist() {
        level endon(#"kill_all_engage_dist_debug");
        level endon(#"kill_realtime_engagement_distance_debug");
        hudobjarray = engagement_distance_debug_init();
        level thread engage_dist_debug_hud_destroy(hudobjarray, "<dev string:x9ce>");
        level.debugrtengagedistcolor = level.green;
        player = util::gethostplayer();
        while (true) {
            lasttracepos = (0, 0, 0);
            direction = player getplayerangles();
            direction_vec = anglestoforward(direction);
            eye = player geteye();
            eye = (eye[0], eye[1], eye[2] + 20);
            trace = bullettrace(eye, eye + vectorscale(direction_vec, 10000), 1, player);
            tracepoint = trace["<dev string:x9e9>"];
            tracenormal = trace["<dev string:x9f2>"];
            tracedist = int(distance(eye, tracepoint));
            if (tracepoint != lasttracepos) {
                lasttracepos = tracepoint;
                if (!isdefined(level.weaponengagedistvalues)) {
                    hudobj_changecolor(hudobjarray, level.white);
                    hudobjarray engagedist_hud_changetext("<dev string:x9f9>", tracedist);
                } else {
                    engagedistmin = level.weaponengagedistvalues.engagedistmin;
                    engagedistoptimal = level.weaponengagedistvalues.engagedistoptimal;
                    engagedistmulligan = level.weaponengagedistvalues.engagedistmulligan;
                    engagedistmax = level.weaponengagedistvalues.engagedistmax;
                    if (tracedist >= engagedistmin && tracedist <= engagedistmax) {
                        if (tracedist >= engagedistoptimal - engagedistmulligan && tracedist <= engagedistoptimal + engagedistmulligan) {
                            hudobjarray engagedist_hud_changetext("<dev string:xa00>", tracedist);
                            hudobj_changecolor(hudobjarray, level.green);
                        } else {
                            hudobjarray engagedist_hud_changetext("<dev string:xa08>", tracedist);
                            hudobj_changecolor(hudobjarray, level.yellow);
                        }
                    } else if (tracedist < engagedistmin) {
                        hudobj_changecolor(hudobjarray, level.red);
                        hudobjarray engagedist_hud_changetext("<dev string:xa0b>", tracedist);
                    } else if (tracedist > engagedistmax) {
                        hudobj_changecolor(hudobjarray, level.red);
                        hudobjarray engagedist_hud_changetext("<dev string:xa11>", tracedist);
                    }
                }
            }
            thread function_57e53630(1, 5, 0.05, level.debugrtengagedistcolor, tracepoint, tracenormal);
            thread function_57e53630(1, 1, 0.05, level.debugrtengagedistcolor, tracepoint, tracenormal);
            wait 0.05;
        }
    }

    // Namespace dev
    // Params 2, eflags: 0x0
    // Checksum 0x193de1da, Offset: 0x6ee0
    // Size: 0x92
    function hudobj_changecolor(hudobjarray, newcolor) {
        for (i = 0; i < hudobjarray.size; i++) {
            hudobj = hudobjarray[i];
            if (hudobj.color != newcolor) {
                hudobj.color = newcolor;
                level.debugrtengagedistcolor = newcolor;
            }
        }
    }

    // Namespace dev
    // Params 2, eflags: 0x0
    // Checksum 0xd73a623a, Offset: 0x6f80
    // Size: 0x2ec
    function engagedist_hud_changetext(engagedisttype, units) {
        if (!isdefined(level.lastdisttype)) {
            level.lastdisttype = "<dev string:x6ae>";
        }
        if (engagedisttype == "<dev string:xa00>") {
            self[1] setvalue(units);
            self[2] settext("<dev string:xa16>");
            self[3].alpha = 0;
        } else if (engagedisttype == "<dev string:xa08>") {
            self[1] setvalue(units);
            self[2] settext("<dev string:xa26>");
            self[3].alpha = 0;
        } else if (engagedisttype == "<dev string:xa0b>") {
            amountunder = level.weaponengagedistvalues.engagedistmin - units;
            self[1] setvalue(units);
            self[3] setvalue(amountunder);
            self[3].alpha = 1;
            if (level.lastdisttype != engagedisttype) {
                self[2] settext("<dev string:xa31>");
            }
        } else if (engagedisttype == "<dev string:xa11>") {
            amountover = units - level.weaponengagedistvalues.engagedistmax;
            self[1] setvalue(units);
            self[3] setvalue(amountover);
            self[3].alpha = 1;
            if (level.lastdisttype != engagedisttype) {
                self[2] settext("<dev string:xa42>");
            }
        } else if (engagedisttype == "<dev string:x9f9>") {
            self[1] setvalue(units);
            self[2] settext("<dev string:xa52>");
            self[3].alpha = 0;
        }
        level.lastdisttype = engagedisttype;
    }

    // Namespace dev
    // Params 6, eflags: 0x0
    // Checksum 0x860109fd, Offset: 0x7278
    // Size: 0x1ee
    function function_57e53630(radius1, radius2, time, color, origin, normal) {
        if (!isdefined(color)) {
            color = (0, 1, 0);
        }
        var_9f8f8bbe = 0.05;
        circleres = 6;
        var_242ed014 = circleres / 2;
        circleinc = 360 / circleres;
        circleres++;
        plotpoints = [];
        rad = 0;
        timer = gettime() + time * 1000;
        radius = radius1;
        while (gettime() < timer) {
            radius = radius2;
            angletoplayer = vectortoangles(normal);
            for (i = 0; i < circleres; i++) {
                plotpoints[plotpoints.size] = origin + vectorscale(anglestoforward(angletoplayer + (rad, 90, 0)), radius);
                rad += circleinc;
            }
            util::plot_points(plotpoints, color[0], color[1], color[2], var_9f8f8bbe);
            plotpoints = [];
            wait var_9f8f8bbe;
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0xb6977d03, Offset: 0x7470
    // Size: 0x1c6
    function larry_thread() {
        setdvar("<dev string:xa75>", "<dev string:x47>");
        setdvar("<dev string:xa87>", "<dev string:x47>");
        setdvar("<dev string:xa97>", "<dev string:x47>");
        setdvar("<dev string:xaaa>", "<dev string:x47>");
        level.larry = spawnstruct();
        player = util::gethostplayer();
        player thread larry_init(level.larry);
        level waittill(#"kill_larry");
        larry_hud_destroy(level.larry);
        if (isdefined(level.larry.model)) {
            level.larry.model delete();
        }
        if (isdefined(level.larry.ai)) {
            for (i = 0; i < level.larry.ai.size; i++) {
                kick(level.larry.ai[i] getentitynumber());
            }
        }
        level.larry = undefined;
    }

    // Namespace dev
    // Params 1, eflags: 0x0
    // Checksum 0x5110f, Offset: 0x7640
    // Size: 0x270
    function larry_init(larry) {
        level endon(#"kill_larry");
        larry_hud_init(larry);
        larry.model = spawn("<dev string:xabc>", (0, 0, 0));
        larry.model setmodel("<dev string:xac9>");
        larry.ai = [];
        wait 0.1;
        for (;;) {
            wait 0.05;
            if (larry.ai.size > 0) {
                larry.model hide();
                continue;
            }
            direction = self getplayerangles();
            direction_vec = anglestoforward(direction);
            eye = self geteye();
            trace = bullettrace(eye, eye + vectorscale(direction_vec, 8000), 0, undefined);
            dist = distance(eye, trace["<dev string:x9e9>"]);
            position = eye + vectorscale(direction_vec, dist - 64);
            larry.model.origin = position;
            larry.model.angles = self.angles + (0, 180, 0);
            if (self usebuttonpressed()) {
                self larry_ai(larry);
                while (self usebuttonpressed()) {
                    wait 0.05;
                }
            }
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x0
    // Checksum 0x21e6aabb, Offset: 0x78b8
    // Size: 0x10c
    function larry_ai(larry) {
        larry.ai[larry.ai.size] = bot::add_bot("<dev string:x1d4>");
        i = larry.ai.size - 1;
        larry.ai[i] thread larry_ai_thread(larry, larry.model.origin, larry.model.angles);
        larry.ai[i] thread larry_ai_damage(larry);
        larry.ai[i] thread larry_ai_health(larry);
    }

    // Namespace dev
    // Params 3, eflags: 0x0
    // Checksum 0x3b01a55c, Offset: 0x79d0
    // Size: 0x1d0
    function larry_ai_thread(larry, origin, angles) {
        level endon(#"kill_larry");
        for (;;) {
            self waittill(#"spawned_player");
            larry.menu[larry.menu_health] setvalue(self.health);
            larry.menu[larry.menu_damage] settext("<dev string:x46>");
            larry.menu[larry.menu_range] settext("<dev string:x46>");
            larry.menu[larry.menu_hitloc] settext("<dev string:x46>");
            larry.menu[larry.menu_weapon] settext("<dev string:x46>");
            larry.menu[larry.menu_perks] settext("<dev string:x46>");
            self setorigin(origin);
            self setplayerangles(angles);
            self clearperks();
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x0
    // Checksum 0xd3629016, Offset: 0x7ba8
    // Size: 0x288
    function larry_ai_damage(larry) {
        level endon(#"kill_larry");
        for (;;) {
            self waittill(#"damage", damage, attacker, dir, point);
            if (!isdefined(attacker)) {
                continue;
            }
            player = util::gethostplayer();
            if (!isdefined(player)) {
                continue;
            }
            if (attacker != player) {
                continue;
            }
            eye = player geteye();
            range = int(distance(eye, point));
            larry.menu[larry.menu_health] setvalue(self.health);
            larry.menu[larry.menu_damage] setvalue(damage);
            larry.menu[larry.menu_range] setvalue(range);
            if (isdefined(self.cac_debug_location)) {
                larry.menu[larry.menu_hitloc] settext(self.cac_debug_location);
            } else {
                larry.menu[larry.menu_hitloc] settext("<dev string:xad6>");
            }
            if (isdefined(self.cac_debug_weapon)) {
                larry.menu[larry.menu_weapon] settext(self.cac_debug_weapon);
                continue;
            }
            larry.menu[larry.menu_weapon] settext("<dev string:xad6>");
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x0
    // Checksum 0x4ca61d9e, Offset: 0x7e38
    // Size: 0x60
    function larry_ai_health(larry) {
        level endon(#"kill_larry");
        for (;;) {
            wait 0.05;
            larry.menu[larry.menu_health] setvalue(self.health);
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x0
    // Checksum 0x37d24781, Offset: 0x7ea0
    // Size: 0x5c6
    function larry_hud_init(larry) {
        /#
            x = -45;
            y = 275;
            menu_name = "<dev string:xae0>";
            larry.hud = new_hud(menu_name, undefined, x, y, 1);
            larry.hud setshader("<dev string:xaeb>", -121, 65);
            larry.hud.alignx = "<dev string:x65f>";
            larry.hud.aligny = "<dev string:x664>";
            larry.hud.sort = 10;
            larry.hud.alpha = 0.6;
            larry.hud.color = (0, 0, 0.5);
            larry.menu[0] = new_hud(menu_name, "<dev string:xaf1>", x + 5, y + 10, 1);
            larry.menu[1] = new_hud(menu_name, "<dev string:xaff>", x + 5, y + 20, 1);
            larry.menu[2] = new_hud(menu_name, "<dev string:xb07>", x + 5, y + 30, 1);
            larry.menu[3] = new_hud(menu_name, "<dev string:xb0e>", x + 5, y + 40, 1);
            larry.menu[4] = new_hud(menu_name, "<dev string:xb1c>", x + 5, y + 50, 1);
            larry.cleartextmarker = newdebughudelem();
            larry.cleartextmarker.alpha = 0;
            larry.cleartextmarker settext("<dev string:xb24>");
            larry.menu_health = larry.menu.size;
            larry.menu_damage = larry.menu.size + 1;
            larry.menu_range = larry.menu.size + 2;
            larry.menu_hitloc = larry.menu.size + 3;
            larry.menu_weapon = larry.menu.size + 4;
            larry.menu_perks = larry.menu.size + 5;
            x_offset = 70;
            larry.menu[larry.menu_health] = new_hud(menu_name, "<dev string:x46>", x + x_offset, y + 10, 1);
            larry.menu[larry.menu_damage] = new_hud(menu_name, "<dev string:x46>", x + x_offset, y + 20, 1);
            larry.menu[larry.menu_range] = new_hud(menu_name, "<dev string:x46>", x + x_offset, y + 30, 1);
            larry.menu[larry.menu_hitloc] = new_hud(menu_name, "<dev string:x46>", x + x_offset, y + 40, 1);
            larry.menu[larry.menu_weapon] = new_hud(menu_name, "<dev string:x46>", x + x_offset, y + 50, 1);
            larry.menu[larry.menu_perks] = new_hud(menu_name, "<dev string:x46>", x + x_offset, y + 60, 1);
        #/
    }

    // Namespace dev
    // Params 1, eflags: 0x0
    // Checksum 0x1c98712b, Offset: 0x8470
    // Size: 0xbc
    function larry_hud_destroy(larry) {
        if (isdefined(larry.hud)) {
            larry.hud destroy();
            for (i = 0; i < larry.menu.size; i++) {
                larry.menu[i] destroy();
            }
            larry.cleartextmarker destroy();
        }
    }

    // Namespace dev
    // Params 5, eflags: 0x0
    // Checksum 0x144876f9, Offset: 0x8538
    // Size: 0xc2
    function new_hud(hud_name, msg, x, y, scale) {
        if (!isdefined(level.hud_array)) {
            level.hud_array = [];
        }
        if (!isdefined(level.hud_array[hud_name])) {
            level.hud_array[hud_name] = [];
        }
        hud = set_hudelem(msg, x, y, scale);
        level.hud_array[hud_name][level.hud_array[hud_name].size] = hud;
        return hud;
    }

    // Namespace dev
    // Params 7, eflags: 0x0
    // Checksum 0x7a6d5de1, Offset: 0x8608
    // Size: 0x1a2
    function set_hudelem(text, x, y, scale, alpha, sort, debug_hudelem) {
        /#
            if (!isdefined(alpha)) {
                alpha = 1;
            }
            if (!isdefined(scale)) {
                scale = 1;
            }
            if (!isdefined(sort)) {
                sort = 20;
            }
            hud = newdebughudelem();
            hud.debug_hudelem = 1;
            hud.location = 0;
            hud.alignx = "<dev string:x65f>";
            hud.aligny = "<dev string:xb2b>";
            hud.foreground = 1;
            hud.fontscale = scale;
            hud.sort = sort;
            hud.alpha = alpha;
            hud.x = x;
            hud.y = y;
            hud.og_scale = scale;
            if (isdefined(text)) {
                hud settext(text);
            }
            return hud;
        #/
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x6dcdba09, Offset: 0x87b8
    // Size: 0x228
    function function_2f38b7bf() {
        var_22c33e2b = getdvarint("<dev string:x5d>");
        var_424556b9 = getdvarint("<dev string:x75>");
        var_d451495d = getdvarint("<dev string:x8a>");
        while (true) {
            if (var_22c33e2b != getdvarint("<dev string:x5d>")) {
                var_22c33e2b = getdvarint("<dev string:x5d>");
                if (var_22c33e2b) {
                    iprintlnbold("<dev string:xb32>");
                } else {
                    iprintlnbold("<dev string:xb4e>");
                }
            }
            if (var_424556b9 != getdvarint("<dev string:x75>")) {
                var_424556b9 = getdvarint("<dev string:x75>");
                if (var_424556b9) {
                    iprintlnbold("<dev string:xb6b>");
                } else {
                    iprintlnbold("<dev string:xb89>");
                }
            }
            if (var_d451495d != getdvarint("<dev string:x8a>")) {
                var_d451495d = getdvarint("<dev string:x8a>");
                if (var_d451495d) {
                    iprintlnbold("<dev string:xba8>");
                } else {
                    iprintlnbold("<dev string:xbd0>");
                }
            }
            wait 1;
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0xf5afdbaf, Offset: 0x89e8
    // Size: 0x10
    function function_d99660db() {
        return "<dev string:xbf9>";
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x974eb8f2, Offset: 0x8a00
    // Size: 0x3ac
    function function_c5833485() {
        self endon(#"disconnect");
        clientnum = self getentitynumber();
        if (clientnum != 0) {
            return;
        }
        dpad_left = 0;
        dpad_right = 0;
        dpad_up = 0;
        dpad_down = 0;
        var_96f03d58 = 0;
        var_e90d1b0d = function_d99660db();
        for (;;) {
            if (self buttonpressed(var_e90d1b0d)) {
                if (!dpad_left && self buttonpressed("<dev string:x61f>")) {
                    self giveweaponnextattachment("<dev string:xc02>");
                    dpad_left = 1;
                    self thread print_weapon_name();
                }
                if (!dpad_right && self buttonpressed("<dev string:x629>")) {
                    self giveweaponnextattachment("<dev string:xc09>");
                    dpad_right = 1;
                    self thread print_weapon_name();
                }
                if (!dpad_up && self buttonpressed("<dev string:xc11>")) {
                    self giveweaponnextattachment("<dev string:x664>");
                    dpad_up = 1;
                    self thread print_weapon_name();
                }
                if (!dpad_down && self buttonpressed("<dev string:xc19>")) {
                    self giveweaponnextattachment("<dev string:xc23>");
                    dpad_down = 1;
                    self thread print_weapon_name();
                }
                if (!var_96f03d58 && self buttonpressed("<dev string:xc2a>")) {
                    self giveweaponnextattachment("<dev string:xc38>");
                    var_96f03d58 = 1;
                    self thread print_weapon_name();
                }
            }
            if (!self buttonpressed("<dev string:x61f>")) {
                dpad_left = 0;
            }
            if (!self buttonpressed("<dev string:x629>")) {
                dpad_right = 0;
            }
            if (!self buttonpressed("<dev string:xc11>")) {
                dpad_up = 0;
            }
            if (!self buttonpressed("<dev string:xc19>")) {
                dpad_down = 0;
            }
            if (!self buttonpressed("<dev string:xc2a>")) {
                var_96f03d58 = 0;
            }
            wait 0.05;
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x4b66c4c8, Offset: 0x8db8
    // Size: 0x11c
    function print_weapon_name() {
        self notify(#"print_weapon_name");
        self endon(#"print_weapon_name");
        wait 0.2;
        if (self isswitchingweapons()) {
            self waittill(#"weapon_change_complete", weapon);
            fail_safe = 0;
            while (weapon == level.weaponnone) {
                self waittill(#"weapon_change_complete", weapon);
                wait 0.05;
                fail_safe++;
                if (fail_safe > 120) {
                    break;
                }
            }
        } else {
            weapon = self getcurrentweapon();
        }
        printweaponname = getdvarint("<dev string:xc40>", 1);
        if (printweaponname) {
            iprintlnbold(weapon.name);
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x6b3b6a44, Offset: 0x8ee0
    // Size: 0x1b2
    function set_equipment_list() {
        if (isdefined(level.dev_equipment)) {
            return;
        }
        level.dev_equipment = [];
        level.dev_equipment[1] = getweapon("<dev string:xc56>");
        level.dev_equipment[2] = getweapon("<dev string:xc66>");
        level.dev_equipment[3] = getweapon("<dev string:xc73>");
        level.dev_equipment[4] = getweapon("<dev string:xc7c>");
        level.dev_equipment[5] = getweapon("<dev string:xc8b>");
        level.dev_equipment[6] = getweapon("<dev string:xc95>");
        level.dev_equipment[7] = getweapon("<dev string:xca8>");
        level.dev_equipment[8] = getweapon("<dev string:xcb6>");
        level.dev_equipment[9] = getweapon("<dev string:xcc4>");
        level.dev_equipment[10] = getweapon("<dev string:xccd>");
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0xe8d5e3a2, Offset: 0x90a0
    // Size: 0x1da
    function set_grenade_list() {
        if (isdefined(level.dev_grenade)) {
            return;
        }
        level.dev_grenade = [];
        level.dev_grenade[1] = getweapon("<dev string:xcdd>");
        level.dev_grenade[2] = getweapon("<dev string:xcea>");
        level.dev_grenade[3] = getweapon("<dev string:xcf9>");
        level.dev_grenade[4] = getweapon("<dev string:xd01>");
        level.dev_grenade[5] = getweapon("<dev string:xd0c>");
        level.dev_grenade[6] = getweapon("<dev string:xd1e>");
        level.dev_grenade[7] = getweapon("<dev string:xd2c>");
        level.dev_grenade[8] = getweapon("<dev string:xd3f>");
        level.dev_grenade[9] = getweapon("<dev string:xd4b>");
        level.dev_grenade[10] = getweapon("<dev string:xd57>");
        level.dev_grenade[11] = getweapon("<dev string:xd66>");
    }

    // Namespace dev
    // Params 1, eflags: 0x0
    // Checksum 0x511e34b6, Offset: 0x9288
    // Size: 0xb6
    function take_all_grenades_and_equipment(player) {
        for (i = 0; i < level.dev_equipment.size; i++) {
            player takeweapon(level.dev_equipment[i + 1]);
        }
        for (i = 0; i < level.dev_grenade.size; i++) {
            player takeweapon(level.dev_grenade[i + 1]);
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0xe5eee73f, Offset: 0x9348
    // Size: 0x128
    function equipment_dev_gui() {
        set_equipment_list();
        set_grenade_list();
        setdvar("<dev string:xd79>", "<dev string:x46>");
        while (true) {
            wait 0.5;
            devgui_int = getdvarint("<dev string:xd79>");
            if (devgui_int != 0) {
                for (i = 0; i < level.players.size; i++) {
                    take_all_grenades_and_equipment(level.players[i]);
                    level.players[i] giveweapon(level.dev_equipment[devgui_int]);
                }
                setdvar("<dev string:xd79>", "<dev string:x47>");
            }
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x46d7c44d, Offset: 0x9478
    // Size: 0x128
    function grenade_dev_gui() {
        set_equipment_list();
        set_grenade_list();
        setdvar("<dev string:xd8c>", "<dev string:x46>");
        while (true) {
            wait 0.5;
            devgui_int = getdvarint("<dev string:xd8c>");
            if (devgui_int != 0) {
                for (i = 0; i < level.players.size; i++) {
                    take_all_grenades_and_equipment(level.players[i]);
                    level.players[i] giveweapon(level.dev_grenade[devgui_int]);
                }
                setdvar("<dev string:xd8c>", "<dev string:x47>");
            }
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x0
    // Checksum 0x84e4d854, Offset: 0x95a8
    // Size: 0x28c
    function force_grenade_throw(weapon) {
        if (weapon == level.weaponnone) {
            return;
        }
        setdvar("<dev string:xa75>", "<dev string:x47>");
        setdvar("<dev string:xa87>", "<dev string:x47>");
        setdvar("<dev string:xa97>", "<dev string:x47>");
        setdvar("<dev string:xaaa>", "<dev string:x47>");
        setdvar("<dev string:xd9d>", "<dev string:x47>");
        host = util::gethostplayer();
        if (!isdefined(host.team)) {
            iprintln("<dev string:xdb6>");
            return;
        }
        bot = getormakebot(util::getotherteam(host.team));
        if (!isdefined(bot)) {
            iprintln("<dev string:x1df>");
            return;
        }
        angles = host getplayerangles();
        angles = (0, angles[1], 0);
        dir = anglestoforward(angles);
        dir = vectornormalize(dir);
        origin = host geteye() + vectorscale(dir, 256);
        velocity = vectorscale(dir, -1024);
        grenade = bot magicgrenadeplayer(weapon, origin, velocity);
        grenade setteam(bot.team);
        grenade setowner(bot);
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0xa5e9190c, Offset: 0x9840
    // Size: 0x2a6
    function function_7f9e1229() {
        level notify(#"hash_6a3a2dc7");
        level endon(#"hash_6a3a2dc7");
        level endon(#"hash_7c01e4c4");
        if (!isdefined(level.var_b70561a5)) {
            level.var_b70561a5 = 0;
        }
        host = util::gethostplayer();
        while (!isdefined(host)) {
            wait 0.5;
            host = util::gethostplayer();
            level.var_b70561a5 = 0;
        }
        dpad_left = 0;
        dpad_right = 0;
        for (;;) {
            wait 0.05;
            host setactionslot(3, "<dev string:x46>");
            host setactionslot(4, "<dev string:x46>");
            players = getplayers();
            max = players.size;
            if (!dpad_left && host buttonpressed("<dev string:x61f>")) {
                level.var_b70561a5--;
                if (level.var_b70561a5 < 0) {
                    level.var_b70561a5 = max - 1;
                }
                if (!players[level.var_b70561a5] util::is_bot()) {
                    continue;
                }
                dpad_left = 1;
            } else if (!host buttonpressed("<dev string:x61f>")) {
                dpad_left = 0;
            }
            if (!dpad_right && host buttonpressed("<dev string:x629>")) {
                level.var_b70561a5++;
                if (level.var_b70561a5 >= max) {
                    level.var_b70561a5 = 0;
                }
                if (!players[level.var_b70561a5] util::is_bot()) {
                    continue;
                }
                dpad_right = 1;
            } else if (!host buttonpressed("<dev string:x629>")) {
                dpad_right = 0;
            }
            level notify(#"hash_357e4644");
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x122dce78, Offset: 0x9af0
    // Size: 0xac
    function function_fdfd1b20() {
        level endon(#"hash_7e05f110");
        level thread function_7f9e1229();
        iprintln("<dev string:xddb>");
        iprintln("<dev string:xdfc>");
        for (;;) {
            if (getdvarint("<dev string:xe1a>") != level.var_b70561a5) {
                setdvar("<dev string:xe1a>", level.var_b70561a5);
            }
            level waittill(#"hash_357e4644");
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x4bb85f63, Offset: 0x9ba8
    // Size: 0xac
    function function_97fd4406() {
        level endon(#"hash_b4aa652");
        level thread function_7f9e1229();
        iprintln("<dev string:xddb>");
        iprintln("<dev string:xdfc>");
        for (;;) {
            if (getdvarint("<dev string:xe24>") != level.var_b70561a5) {
                setdvar("<dev string:xe24>", level.var_b70561a5);
            }
            level waittill(#"hash_357e4644");
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x6b4a398c, Offset: 0x9c60
    // Size: 0xac
    function function_194def6b() {
        level endon(#"hash_aab0cfd5");
        level thread function_7f9e1229();
        iprintln("<dev string:xddb>");
        iprintln("<dev string:xdfc>");
        for (;;) {
            if (getdvarint("<dev string:xe34>") != level.var_b70561a5) {
                setdvar("<dev string:xe34>", level.var_b70561a5);
            }
            level waittill(#"hash_357e4644");
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x4870abd, Offset: 0x9d18
    // Size: 0x34
    function function_7e05f110() {
        level notify(#"hash_7e05f110");
        setdvar("<dev string:xe1a>", "<dev string:xe43>");
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x56cf9897, Offset: 0x9d58
    // Size: 0x34
    function function_aab0cfd5() {
        level notify(#"hash_aab0cfd5");
        setdvar("<dev string:xe34>", "<dev string:xe43>");
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x8d38dd0c, Offset: 0x9d98
    // Size: 0x34
    function function_b4aa652() {
        level notify(#"hash_b4aa652");
        setdvar("<dev string:xe24>", "<dev string:xe43>");
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0xb5cb3734, Offset: 0x9dd8
    // Size: 0x49a
    function devstraferunpathdebugdraw() {
        white = (1, 1, 1);
        red = (1, 0, 0);
        green = (0, 1, 0);
        blue = (0, 0, 1);
        violet = (0.4, 0, 0.6);
        maxdrawtime = 10;
        drawtime = maxdrawtime;
        origintextoffset = (0, 0, -50);
        endonmsg = "<dev string:xe46>";
        while (true) {
            if (killstreaks::should_draw_debug("<dev string:xe64>") > 0) {
                nodes = [];
                end = 0;
                node = getvehiclenode("<dev string:xe70>", "<dev string:x27a>");
                if (!isdefined(node)) {
                    println("<dev string:xe7e>");
                    setdvar("<dev string:xe97>", "<dev string:x47>");
                    continue;
                }
                while (isdefined(node.target)) {
                    new_node = getvehiclenode(node.target, "<dev string:x27a>");
                    foreach (n in nodes) {
                        if (n == new_node) {
                            end = 1;
                        }
                    }
                    textscale = 30;
                    if (drawtime == maxdrawtime) {
                        node thread drawpathsegment(new_node, violet, violet, 1, textscale, origintextoffset, drawtime, endonmsg);
                    }
                    if (isdefined(node.script_noteworthy)) {
                        textscale = 10;
                        switch (node.script_noteworthy) {
                        case "<dev string:xeb5>":
                            textcolor = green;
                            textalpha = 1;
                            break;
                        case "<dev string:xec2>":
                            textcolor = red;
                            textalpha = 1;
                            break;
                        case "<dev string:xece>":
                            textcolor = white;
                            textalpha = 1;
                            break;
                        }
                        switch (node.script_noteworthy) {
                        case "<dev string:xece>":
                        case "<dev string:xeb5>":
                        case "<dev string:xec2>":
                            sides = 10;
                            radius = 100;
                            if (drawtime == maxdrawtime) {
                                sphere(node.origin, radius, textcolor, textalpha, 1, sides, drawtime * 1000);
                            }
                            node draworiginlines();
                            node drawnoteworthytext(textcolor, textalpha, textscale);
                            break;
                        }
                    }
                    if (end) {
                        break;
                    }
                    nodes[nodes.size] = new_node;
                    node = new_node;
                }
                drawtime -= 0.05;
                if (drawtime < 0) {
                    drawtime = maxdrawtime;
                }
                wait 0.05;
                continue;
            }
            wait 1;
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x7d199df4, Offset: 0xa280
    // Size: 0x3c0
    function devhelipathdebugdraw() {
        white = (1, 1, 1);
        red = (1, 0, 0);
        green = (0, 1, 0);
        blue = (0, 0, 1);
        textcolor = white;
        textalpha = 1;
        textscale = 1;
        maxdrawtime = 10;
        drawtime = maxdrawtime;
        origintextoffset = (0, 0, -50);
        endonmsg = "<dev string:xedb>";
        while (true) {
            if (getdvarint("<dev string:xef5>") > 0) {
                script_origins = getentarray("<dev string:xf0f>", "<dev string:x180>");
                foreach (ent in script_origins) {
                    if (isdefined(ent.targetname)) {
                        switch (ent.targetname) {
                        case "<dev string:xf1d>":
                            textcolor = blue;
                            textalpha = 1;
                            textscale = 3;
                            break;
                        case "<dev string:xf28>":
                            textcolor = green;
                            textalpha = 1;
                            textscale = 3;
                            break;
                        case "<dev string:xf38>":
                            textcolor = red;
                            textalpha = 1;
                            textscale = 3;
                            break;
                        case "<dev string:xf49>":
                            textcolor = white;
                            textalpha = 1;
                            textscale = 3;
                            break;
                        }
                        switch (ent.targetname) {
                        case "<dev string:xf38>":
                        case "<dev string:xf49>":
                        case "<dev string:xf28>":
                        case "<dev string:xf1d>":
                            if (drawtime == maxdrawtime) {
                                ent thread drawpath(textcolor, white, textalpha, textscale, origintextoffset, drawtime, endonmsg);
                            }
                            ent draworiginlines();
                            ent drawtargetnametext(textcolor, textalpha, textscale);
                            ent draworigintext(textcolor, textalpha, textscale, origintextoffset);
                            break;
                        }
                    }
                }
                drawtime -= 0.05;
                if (drawtime < 0) {
                    drawtime = maxdrawtime;
                }
            }
            if (getdvarint("<dev string:xef5>") == 0) {
                level notify(endonmsg);
                drawtime = maxdrawtime;
                wait 1;
            }
            wait 0.05;
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x6abfde4e, Offset: 0xa648
    // Size: 0x114
    function draworiginlines() {
        red = (1, 0, 0);
        green = (0, 1, 0);
        blue = (0, 0, 1);
        line(self.origin, self.origin + anglestoforward(self.angles) * 10, red);
        line(self.origin, self.origin + anglestoright(self.angles) * 10, green);
        line(self.origin, self.origin + anglestoup(self.angles) * 10, blue);
    }

    // Namespace dev
    // Params 4, eflags: 0x0
    // Checksum 0xa3935e6c, Offset: 0xa768
    // Size: 0x74
    function drawtargetnametext(textcolor, textalpha, textscale, textoffset) {
        if (!isdefined(textoffset)) {
            textoffset = (0, 0, 0);
        }
        print3d(self.origin + textoffset, self.targetname, textcolor, textalpha, textscale);
    }

    // Namespace dev
    // Params 4, eflags: 0x0
    // Checksum 0x42e4ccd3, Offset: 0xa7e8
    // Size: 0x74
    function drawnoteworthytext(textcolor, textalpha, textscale, textoffset) {
        if (!isdefined(textoffset)) {
            textoffset = (0, 0, 0);
        }
        print3d(self.origin + textoffset, self.script_noteworthy, textcolor, textalpha, textscale);
    }

    // Namespace dev
    // Params 4, eflags: 0x0
    // Checksum 0x85c30ab3, Offset: 0xa868
    // Size: 0xc4
    function draworigintext(textcolor, textalpha, textscale, textoffset) {
        if (!isdefined(textoffset)) {
            textoffset = (0, 0, 0);
        }
        originstring = "<dev string:xf54>" + self.origin[0] + "<dev string:xf56>" + self.origin[1] + "<dev string:xf56>" + self.origin[2] + "<dev string:xf59>";
        print3d(self.origin + textoffset, originstring, textcolor, textalpha, textscale);
    }

    // Namespace dev
    // Params 4, eflags: 0x0
    // Checksum 0xd9e111a9, Offset: 0xa938
    // Size: 0xdc
    function drawspeedacceltext(textcolor, textalpha, textscale, textoffset) {
        if (isdefined(self.script_airspeed)) {
            print3d(self.origin + (0, 0, textoffset[2] * 2), "<dev string:xf5b>" + self.script_airspeed, textcolor, textalpha, textscale);
        }
        if (isdefined(self.script_accel)) {
            print3d(self.origin + (0, 0, textoffset[2] * 3), "<dev string:xf6c>" + self.script_accel, textcolor, textalpha, textscale);
        }
    }

    // Namespace dev
    // Params 7, eflags: 0x0
    // Checksum 0xdab997ed, Offset: 0xaa20
    // Size: 0x154
    function drawpath(linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg) {
        level endon(endonmsg);
        ent = self;
        entfirsttarget = ent.targetname;
        while (isdefined(ent.target)) {
            enttarget = getent(ent.target, "<dev string:x27a>");
            ent thread drawpathsegment(enttarget, linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg);
            if (ent.targetname == "<dev string:xf28>") {
                entfirsttarget = ent.target;
            } else if (ent.target == entfirsttarget) {
                break;
            }
            ent = enttarget;
            wait 0.05;
        }
    }

    // Namespace dev
    // Params 8, eflags: 0x0
    // Checksum 0xb6f3ecbc, Offset: 0xab80
    // Size: 0x124
    function drawpathsegment(enttarget, linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg) {
        level endon(endonmsg);
        while (drawtime > 0) {
            if (isdefined(self.targetname) && self.targetname == "<dev string:xe70>") {
                print3d(self.origin + textoffset, self.targetname, textcolor, textalpha, textscale);
            }
            line(self.origin, enttarget.origin, linecolor);
            self drawspeedacceltext(textcolor, textalpha, textscale, textoffset);
            drawtime -= 0.05;
            wait 0.05;
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x0
    // Checksum 0xd9794609, Offset: 0xacb0
    // Size: 0xc6
    function get_lookat_origin(player) {
        angles = player getplayerangles();
        forward = anglestoforward(angles);
        dir = vectorscale(forward, 8000);
        eye = player geteye();
        trace = bullettrace(eye, eye + dir, 0, undefined);
        return trace["<dev string:x9e9>"];
    }

    // Namespace dev
    // Params 2, eflags: 0x0
    // Checksum 0x2065d9e6, Offset: 0xad80
    // Size: 0x74
    function draw_pathnode(node, color) {
        if (!isdefined(color)) {
            color = (1, 0, 1);
        }
        box(node.origin, (-16, -16, 0), (16, 16, 16), 0, color, 1, 0, 1);
    }

    // Namespace dev
    // Params 2, eflags: 0x0
    // Checksum 0xb08a4281, Offset: 0xae00
    // Size: 0x48
    function draw_pathnode_think(node, color) {
        level endon(#"draw_pathnode_stop");
        for (;;) {
            draw_pathnode(node, color);
            wait 0.05;
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x785cc348, Offset: 0xae50
    // Size: 0x1a
    function draw_pathnodes_stop() {
        wait 5;
        level notify(#"draw_pathnode_stop");
    }

    // Namespace dev
    // Params 1, eflags: 0x0
    // Checksum 0x2d6353b9, Offset: 0xae78
    // Size: 0x120
    function node_get(player) {
        for (;;) {
            wait 0.05;
            origin = get_lookat_origin(player);
            node = getnearestnode(origin);
            if (!isdefined(node)) {
                continue;
            }
            if (player buttonpressed("<dev string:xf7a>")) {
                return node;
            } else if (player buttonpressed("<dev string:xf83>")) {
                return undefined;
            }
            if (node.type == "<dev string:x1f9>") {
                draw_pathnode(node, (1, 0, 1));
                continue;
            }
            draw_pathnode(node, (0.85, 0.85, 0.1));
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x6aba584, Offset: 0xafa0
    // Size: 0x1a8
    function dev_get_node_pair() {
        player = util::gethostplayer();
        start = undefined;
        while (!isdefined(start)) {
            start = node_get(player);
            if (player buttonpressed("<dev string:xf83>")) {
                level notify(#"draw_pathnode_stop");
                return undefined;
            }
        }
        level thread draw_pathnode_think(start, (0, 1, 0));
        while (player buttonpressed("<dev string:xf7a>")) {
            wait 0.05;
        }
        end = undefined;
        while (!isdefined(end)) {
            end = node_get(player);
            if (player buttonpressed("<dev string:xf83>")) {
                level notify(#"draw_pathnode_stop");
                return undefined;
            }
        }
        level thread draw_pathnode_think(end, (0, 1, 0));
        level thread draw_pathnodes_stop();
        array = [];
        array[0] = start;
        array[1] = end;
        return array;
    }

    // Namespace dev
    // Params 2, eflags: 0x0
    // Checksum 0xf5c55329, Offset: 0xb150
    // Size: 0x5c
    function draw_point(origin, color) {
        if (!isdefined(color)) {
            color = (1, 0, 1);
        }
        sphere(origin, 16, color, 0.25, 0, 16, 1);
    }

    // Namespace dev
    // Params 1, eflags: 0x0
    // Checksum 0x5272ed8d, Offset: 0xb1b8
    // Size: 0xa0
    function point_get(player) {
        for (;;) {
            wait 0.05;
            origin = get_lookat_origin(player);
            if (player buttonpressed("<dev string:xf7a>")) {
                return origin;
            } else if (player buttonpressed("<dev string:xf83>")) {
                return undefined;
            }
            draw_point(origin, (1, 0, 1));
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x606626a1, Offset: 0xb260
    // Size: 0x120
    function dev_get_point_pair() {
        player = util::gethostplayer();
        start = undefined;
        points = [];
        while (!isdefined(start)) {
            start = point_get(player);
            if (!isdefined(start)) {
                return points;
            }
        }
        while (player buttonpressed("<dev string:xf7a>")) {
            wait 0.05;
        }
        end = undefined;
        while (!isdefined(end)) {
            end = point_get(player);
            if (!isdefined(end)) {
                return points;
            }
        }
        points[0] = start;
        points[1] = end;
        return points;
    }

#/
