#using scripts/mp/_teamops;
#using scripts/mp/killstreaks/_supplydrop;
#using scripts/mp/killstreaks/_uav;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_helicopter_gunner;
#using scripts/mp/killstreaks/_helicopter;
#using scripts/shared/bots/_bot;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_killcam;
#using scripts/mp/gametypes/_hud_message;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_dev_class;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/dev_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace dev;

/#

    // Namespace dev
    // Params 0, eflags: 0x2
    // namespace_eae8c9fa<file_0>::function_2dc19561
    // Checksum 0xc847bbc1, Offset: 0x3e0
    // Size: 0x3c
    function autoexec function_2dc19561() {
        system::register("<unknown string>", &__init__, undefined, "<unknown string>");
    }

#/

// Namespace dev
// Params 0, eflags: 0x1 linked
// namespace_eae8c9fa<file_0>::function_8c87d8eb
// Checksum 0x3577be2f, Offset: 0x428
// Size: 0x5c
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connected);
    level.devongetormakebot = &getormakebot;
}

// Namespace dev
// Params 0, eflags: 0x1 linked
// namespace_eae8c9fa<file_0>::function_c35e6aab
// Checksum 0x13be6343, Offset: 0x490
// Size: 0x4a0
function init() {
    /#
        if (getdvarstring("<unknown string>") == "<unknown string>") {
            setdvar("<unknown string>", "<unknown string>");
        }
        if (getdvarstring("<unknown string>") == "<unknown string>") {
            setdvar("<unknown string>", "<unknown string>");
        }
        if (getdvarstring("<unknown string>") == "<unknown string>") {
            setdvar("<unknown string>", "<unknown string>");
        }
        if (getdvarstring("<unknown string>") == "<unknown string>") {
            setdvar("<unknown string>", "<unknown string>");
        }
        if (getdvarstring("<unknown string>") == "<unknown string>") {
            setdvar("<unknown string>", "<unknown string>");
        }
        if (getdvarstring("<unknown string>") == "<unknown string>") {
            setdvar("<unknown string>", "<unknown string>");
        }
        if (getdvarstring("<unknown string>") == "<unknown string>") {
            setdvar("<unknown string>", "<unknown string>");
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
        setdvar("<unknown string>", "<unknown string>");
        setdvar("<unknown string>", "<unknown string>");
        setdvar("<unknown string>", "<unknown string>");
        thread engagement_distance_debug_toggle();
        thread equipment_dev_gui();
        thread grenade_dev_gui();
        setdvar("<unknown string>", "<unknown string>");
        level.var_391ebc05 = 0;
        level.var_bbc3085f = 0;
        level.var_f1d22fe = 0;
        level.dem_spawns = [];
        if (level.gametype == "<unknown string>") {
            extra_spawns = [];
            extra_spawns[0] = "<unknown string>";
            extra_spawns[1] = "<unknown string>";
            extra_spawns[2] = "<unknown string>";
            extra_spawns[3] = "<unknown string>";
            for (i = 0; i < extra_spawns.size; i++) {
                points = getentarray(extra_spawns[i], "<unknown string>");
                if (isdefined(points) && points.size > 0) {
                    level.dem_spawns = arraycombine(level.dem_spawns, points, 1, 0);
                }
            }
        }
        for (;;) {
            updatedevsettings();
            wait(0.5);
        }
    #/
}

// Namespace dev
// Params 0, eflags: 0x1 linked
// namespace_eae8c9fa<file_0>::function_8feafce2
// Checksum 0xe27529ec, Offset: 0x938
// Size: 0x3c
function on_player_connected() {
    /#
        if (isdefined(level.devgui_unlimited_ammo) && level.devgui_unlimited_ammo) {
            wait(1);
            self thread devgui_unlimited_ammo();
        }
    #/
}

/#

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_127c3b74
    // Checksum 0x11700fd3, Offset: 0x980
    // Size: 0x46e
    function updatehardpoints() {
        keys = getarraykeys(level.killstreaks);
        for (i = 0; i < keys.size; i++) {
            dvar = level.killstreaks[keys[i]].devdvar;
            enemydvar = level.killstreaks[keys[i]].devenemydvar;
            host = util::gethostplayer();
            if (isdefined(dvar) && getdvarint(dvar) == 1) {
                if (keys[i] == "<unknown string>") {
                    if (isdefined(level.vtol)) {
                        iprintln("<unknown string>");
                    } else {
                        host killstreaks::give("<unknown string>" + keys[i]);
                    }
                } else {
                    foreach (player in level.players) {
                        if (isdefined(level.usingscorestreaks) && isdefined(level.usingmomentum) && level.usingmomentum && level.usingscorestreaks) {
                            player killstreaks::give("<unknown string>" + keys[i]);
                            continue;
                        }
                        if (player util::is_bot()) {
                            player.bot["<unknown string>"] = [];
                            player.bot["<unknown string>"][0] = killstreaks::get_menu_name(keys[i]);
                            killstreakweapon = killstreaks::get_killstreak_weapon(keys[i]);
                            player killstreaks::give_weapon(killstreakweapon, 1);
                            globallogic_score::_setplayermomentum(player, 2000);
                            continue;
                        }
                        player killstreaks::give("<unknown string>" + keys[i]);
                    }
                }
                setdvar(dvar, "<unknown string>");
            }
            if (isdefined(enemydvar) && getdvarint(enemydvar) == 1) {
                team = "<unknown string>";
                player = util::gethostplayer();
                if (isdefined(player.team)) {
                    team = util::getotherteam(player.team);
                }
                ent = getormakebot(team);
                if (!isdefined(ent)) {
                    println("<unknown string>");
                    continue;
                }
                wait(1);
                ent killstreaks::give("<unknown string>" + keys[i]);
                setdvar(enemydvar, "<unknown string>");
            }
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_3d345413
    // Checksum 0x94df881f, Offset: 0xdf8
    // Size: 0x8c
    function function_3d345413() {
        var_e21b687a = getdvarstring(level.var_60c4492a);
        if (getdvarstring(level.var_60c4492a) != "<unknown string>") {
            namespace_e21b687a::function_a2630ab8(var_e21b687a);
            setdvar(level.var_60c4492a, "<unknown string>");
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_277100a1
    // Checksum 0xa451eab2, Offset: 0xe90
    // Size: 0x54
    function warpalltohost(team) {
        host = util::gethostplayer();
        warpalltoplayer(team, host.name);
    }

    // Namespace dev
    // Params 2, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_93f46504
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
            nodes = getnodesinradius(origin, -128, 32, -128, "<unknown string>");
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
                    if (strstartswith(team, "<unknown string>") && target.team == players[i].team) {
                        continue;
                    }
                    if (strstartswith(team, "<unknown string>") && target.team != players[i].team) {
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
        setdvar("<unknown string>", "<unknown string>");
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // namespace_eae8c9fa<file_0>::function_f755c633
    // Checksum 0x8c070c5, Offset: 0x1270
    // Size: 0x454
    function updatedevsettingszm() {
        if (level.players.size > 0) {
            if (getdvarstring("<unknown string>") == "<unknown string>") {
                if (!isdefined(level.streamdumpteamindex)) {
                    level.streamdumpteamindex = 0;
                } else {
                    level.streamdumpteamindex++;
                }
                numpoints = 0;
                spawnpoints = [];
                location = level.scr_zm_map_start_location;
                if ((location == "<unknown string>" || location == "<unknown string>") && isdefined(level.default_start_location)) {
                    location = level.default_start_location;
                }
                match_string = level.scr_zm_ui_gametype + "<unknown string>" + location;
                if (level.streamdumpteamindex < level.teams.size) {
                    structs = struct::get_array("<unknown string>", "<unknown string>");
                    if (isdefined(structs)) {
                        foreach (struct in structs) {
                            if (isdefined(struct.script_string)) {
                                tokens = strtok(struct.script_string, "<unknown string>");
                                foreach (token in tokens) {
                                    if (token == match_string) {
                                        spawnpoints[spawnpoints.size] = struct;
                                    }
                                }
                            }
                        }
                    }
                    if (!isdefined(spawnpoints) || spawnpoints.size == 0) {
                        spawnpoints = struct::get_array("<unknown string>", "<unknown string>");
                    }
                    if (isdefined(spawnpoints)) {
                        numpoints = spawnpoints.size;
                    }
                }
                if (numpoints == 0) {
                    setdvar("<unknown string>", "<unknown string>");
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
                wait(5);
                setdvar("<unknown string>", "<unknown string>");
            }
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_f49597b8
    // Checksum 0xe5697c3c, Offset: 0x16d0
    // Size: 0x24de
    function updatedevsettings() {
        show_spawns = getdvarint("<unknown string>");
        show_start_spawns = getdvarint("<unknown string>");
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
            setdvar("<unknown string>", level.show_spawns);
            if (level.show_spawns) {
                showspawnpoints();
            } else {
                hidespawnpoints();
            }
        }
        if (!isdefined(level.show_start_spawns) || level.show_start_spawns != show_start_spawns) {
            level.show_start_spawns = show_start_spawns;
            setdvar("<unknown string>", level.show_start_spawns);
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
            playerwarp_string = getdvarstring("<unknown string>");
            if (playerwarp_string == "<unknown string>") {
                warpalltohost();
            } else if (playerwarp_string == "<unknown string>") {
                warpalltohost(playerwarp_string);
            } else if (playerwarp_string == "<unknown string>") {
                warpalltohost(playerwarp_string);
            } else if (strstartswith(playerwarp_string, "<unknown string>")) {
                name = getsubstr(playerwarp_string, 8);
                warpalltoplayer(playerwarp_string, name);
            } else if (strstartswith(playerwarp_string, "<unknown string>")) {
                name = getsubstr(playerwarp_string, 11);
                warpalltoplayer(playerwarp_string, name);
            } else if (strstartswith(playerwarp_string, "<unknown string>")) {
                name = getsubstr(playerwarp_string, 4);
                warpalltoplayer(undefined, name);
            } else if (playerwarp_string == "<unknown string>") {
                players = getplayers();
                setdvar("<unknown string>", "<unknown string>");
                if (!isdefined(level.devgui_start_spawn_index)) {
                    level.devgui_start_spawn_index = 0;
                }
                player = util::gethostplayer();
                spawns = level.spawn_start[player.pers["<unknown string>"]];
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
            } else if (playerwarp_string == "<unknown string>") {
                players = getplayers();
                setdvar("<unknown string>", "<unknown string>");
                if (!isdefined(level.devgui_start_spawn_index)) {
                    level.devgui_start_spawn_index = 0;
                }
                player = util::gethostplayer();
                spawns = level.spawn_start[player.pers["<unknown string>"]];
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
            } else if (playerwarp_string == "<unknown string>") {
                players = getplayers();
                setdvar("<unknown string>", "<unknown string>");
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
            } else if (playerwarp_string == "<unknown string>") {
                players = getplayers();
                setdvar("<unknown string>", "<unknown string>");
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
            } else if (getdvarstring("<unknown string>") != "<unknown string>") {
                player = util::gethostplayer();
                if (!isdefined(player.devgui_spawn_active)) {
                    player.devgui_spawn_active = 0;
                }
                if (!player.devgui_spawn_active) {
                    iprintln("<unknown string>");
                    iprintln("<unknown string>");
                    player.devgui_spawn_active = 1;
                    player thread devgui_spawn_think();
                } else {
                    player notify(#"devgui_spawn_think");
                    player.devgui_spawn_active = 0;
                    player setactionslot(3, "<unknown string>");
                }
                setdvar("<unknown string>", "<unknown string>");
            } else if (getdvarstring("<unknown string>") != "<unknown string>") {
                players = getplayers();
                if (!isdefined(level.devgui_unlimited_ammo)) {
                    level.devgui_unlimited_ammo = 1;
                } else {
                    level.devgui_unlimited_ammo = !level.devgui_unlimited_ammo;
                }
                if (level.devgui_unlimited_ammo) {
                    iprintln("<unknown string>");
                } else {
                    iprintln("<unknown string>");
                }
                for (i = 0; i < players.size; i++) {
                    if (level.devgui_unlimited_ammo) {
                        players[i] thread devgui_unlimited_ammo();
                        continue;
                    }
                    players[i] notify(#"devgui_unlimited_ammo");
                }
                setdvar("<unknown string>", "<unknown string>");
            } else if (getdvarstring("<unknown string>") != "<unknown string>") {
                if (!isdefined(level.devgui_unlimited_momentum)) {
                    level.devgui_unlimited_momentum = 1;
                } else {
                    level.devgui_unlimited_momentum = !level.devgui_unlimited_momentum;
                }
                if (level.devgui_unlimited_momentum) {
                    iprintln("<unknown string>");
                    level thread devgui_unlimited_momentum();
                } else {
                    iprintln("<unknown string>");
                    level notify(#"devgui_unlimited_momentum");
                }
                setdvar("<unknown string>", "<unknown string>");
            } else if (getdvarstring("<unknown string>") != "<unknown string>") {
                level thread devgui_increase_momentum(getdvarint("<unknown string>"));
                setdvar("<unknown string>", "<unknown string>");
            } else if (getdvarstring("<unknown string>") != "<unknown string>") {
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
                setdvar("<unknown string>", "<unknown string>");
            } else if (getdvarstring("<unknown string>") != "<unknown string>") {
                players = getplayers();
                for (i = 0; i < players.size; i++) {
                    player = players[i];
                    if (getdvarstring("<unknown string>") == "<unknown string>") {
                        player setempjammed(0);
                        continue;
                    }
                    player setempjammed(1);
                }
                setdvar("<unknown string>", "<unknown string>");
            } else if (getdvarstring("<unknown string>") != "<unknown string>") {
                if (!level.timerstopped) {
                    iprintln("<unknown string>");
                    globallogic_utils::pausetimer();
                } else {
                    iprintln("<unknown string>");
                    globallogic_utils::resumetimer();
                }
                setdvar("<unknown string>", "<unknown string>");
            } else if (getdvarstring("<unknown string>") != "<unknown string>") {
                level globallogic::forceend();
                setdvar("<unknown string>", "<unknown string>");
            } else if (getdvarstring("<unknown string>") != "<unknown string>") {
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
                setdvar("<unknown string>", "<unknown string>");
            } else if (getdvarstring("<unknown string>") != "<unknown string>") {
                if (!isdefined(level.devgui_show_hq)) {
                    level.devgui_show_hq = 0;
                }
                if (level.gametype == "<unknown string>" && isdefined(level.radios)) {
                    if (!level.devgui_show_hq) {
                        for (i = 0; i < level.radios.size; i++) {
                            color = (1, 0, 0);
                            level showonespawnpoint(level.radios[i], color, "<unknown string>", 32, "<unknown string>");
                        }
                    } else {
                        level notify(#"hide_hq_points");
                    }
                    level.devgui_show_hq = !level.devgui_show_hq;
                }
                setdvar("<unknown string>", "<unknown string>");
            }
            if (getdvarstring("<unknown string>") == "<unknown string>") {
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
                    setdvar("<unknown string>", "<unknown string>");
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
                    wait(5);
                    setdvar("<unknown string>", "<unknown string>");
                }
            }
        }
        if (getdvarstring("<unknown string>") == "<unknown string>") {
            players = getplayers();
            iprintln("<unknown string>");
            for (i = 0; i < players.size; i++) {
                players[i] clearperks();
            }
            setdvar("<unknown string>", "<unknown string>");
        }
        if (getdvarstring("<unknown string>") != "<unknown string>") {
            perk = getdvarstring("<unknown string>");
            specialties = strtok(perk, "<unknown string>");
            players = getplayers();
            iprintln("<unknown string>" + perk + "<unknown string>");
            for (i = 0; i < players.size; i++) {
                for (j = 0; j < specialties.size; j++) {
                    players[i] setperk(specialties[j]);
                    players[i].extraperks[specialties[j]] = 1;
                }
            }
            setdvar("<unknown string>", "<unknown string>");
        }
        if (getdvarstring("<unknown string>") != "<unknown string>") {
            force_grenade_throw(getweapon(getdvarstring("<unknown string>")));
            setdvar("<unknown string>", "<unknown string>");
        }
        if (getdvarstring("<unknown string>") != "<unknown string>") {
            event = getdvarstring("<unknown string>");
            player = util::gethostplayer();
            forward = anglestoforward(player.angles);
            right = anglestoright(player.angles);
            if (event == "<unknown string>") {
                player dodamage(1, player.origin + forward);
            } else if (event == "<unknown string>") {
                player dodamage(1, player.origin - forward);
            } else if (event == "<unknown string>") {
                player dodamage(1, player.origin - right);
            } else if (event == "<unknown string>") {
                player dodamage(1, player.origin + right);
            }
            setdvar("<unknown string>", "<unknown string>");
        }
        if (getdvarstring("<unknown string>") != "<unknown string>") {
            perk = getdvarstring("<unknown string>");
            for (i = 0; i < level.players.size; i++) {
                level.players[i] unsetperk(perk);
                level.players[i].extraperks[perk] = undefined;
            }
            setdvar("<unknown string>", "<unknown string>");
        }
        if (getdvarstring("<unknown string>") != "<unknown string>") {
            nametokens = strtok(getdvarstring("<unknown string>"), "<unknown string>");
            if (nametokens.size > 1) {
                thread xkillsy(nametokens[0], nametokens[1]);
            }
            setdvar("<unknown string>", "<unknown string>");
        }
        if (getdvarstring("<unknown string>") != "<unknown string>") {
            ownername = getdvarstring("<unknown string>");
            setdvar("<unknown string>", "<unknown string>");
            owner = undefined;
            for (index = 0; index < level.players.size; index++) {
                if (level.players[index].name == ownername) {
                    owner = level.players[index];
                }
            }
            if (isdefined(owner)) {
                owner killstreaks::trigger_killstreak("<unknown string>");
            }
        }
        if (getdvarstring("<unknown string>") != "<unknown string>") {
            player.pers["<unknown string>"] = 0;
            player.pers["<unknown string>"] = 0;
            newrank = min(getdvarint("<unknown string>"), 54);
            newrank = max(newrank, 1);
            setdvar("<unknown string>", "<unknown string>");
            lastxp = 0;
            for (index = 0; index <= newrank; index++) {
                newxp = rank::getrankinfominxp(index);
                player thread rank::giverankxp("<unknown string>", newxp - lastxp);
                lastxp = newxp;
                wait(0.25);
                self notify(#"hash_aa6f899d");
            }
        }
        if (getdvarstring("<unknown string>") != "<unknown string>") {
            player thread rank::giverankxp("<unknown string>", getdvarint("<unknown string>"), 1);
            setdvar("<unknown string>", "<unknown string>");
        }
        if (getdvarstring("<unknown string>") != "<unknown string>") {
            for (i = 0; i < level.players.size; i++) {
                level.players[i] hud_message::function_2bb1fc0(getdvarstring("<unknown string>"), getdvarstring("<unknown string>"), game["<unknown string>"]["<unknown string>"]);
            }
            announcement(getdvarstring("<unknown string>"), 0);
            setdvar("<unknown string>", "<unknown string>");
        }
        if (getdvarstring("<unknown string>") != "<unknown string>") {
            ents = getentarray();
            level.entarray = [];
            level.entcounts = [];
            level.entgroups = [];
            for (index = 0; index < ents.size; index++) {
                classname = ents[index].classname;
                if (!issubstr(classname, "<unknown string>")) {
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
        if (getdvarstring("<unknown string>") == "<unknown string>" && !isdefined(level.larry)) {
            thread larry_thread();
        } else if (getdvarstring("<unknown string>") == "<unknown string>") {
            level notify(#"kill_larry");
        }
        if (level.var_391ebc05 == 0 && getdvarint("<unknown string>") == 1) {
            level thread function_fdfd1b20();
            level.var_391ebc05 = 1;
        } else if (level.var_391ebc05 == 1 && getdvarint("<unknown string>") == 0) {
            level function_7e05f110();
            level.var_391ebc05 = 0;
        }
        if (level.var_bbc3085f == 0 && getdvarint("<unknown string>") == 1) {
            level thread function_97fd4406();
            level.var_bbc3085f = 1;
        } else if (level.var_bbc3085f == 1 && getdvarint("<unknown string>") == 0) {
            level function_b4aa652();
            level.var_bbc3085f = 0;
        }
        if (level.var_f1d22fe == 0 && getdvarint("<unknown string>") == 1) {
            level thread function_194def6b();
            level.var_f1d22fe = 1;
        } else if (level.var_f1d22fe == 1 && getdvarint("<unknown string>") == 0) {
            level function_aab0cfd5();
            level.var_f1d22fe = 0;
        }
        if (getdvarint("<unknown string>") == 1) {
            level thread killcam::do_final_killcam();
            level thread waitthennotifyfinalkillcam();
        }
        if (getdvarint("<unknown string>") == 1) {
            level thread killcam::do_final_killcam();
            level thread waitthennotifyroundkillcam();
        }
        if (!level.var_391ebc05 && !level.var_bbc3085f && !level.var_f1d22fe) {
            level notify(#"hash_7c01e4c4");
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_41388f05
    // Checksum 0xaa2f7617, Offset: 0x3bb8
    // Size: 0x3c
    function waitthennotifyroundkillcam() {
        wait(0.05);
        level notify(#"play_final_killcam");
        setdvar("<unknown string>", 0);
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_834a6315
    // Checksum 0xdadd415a, Offset: 0x3c00
    // Size: 0x44
    function waitthennotifyfinalkillcam() {
        wait(0.05);
        level notify(#"play_final_killcam");
        wait(0.05);
        setdvar("<unknown string>", 0);
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_1870c86a
    // Checksum 0x2b40e928, Offset: 0x3c50
    // Size: 0x18c
    function devgui_spawn_think() {
        self notify(#"devgui_spawn_think");
        self endon(#"devgui_spawn_think");
        self endon(#"disconnect");
        dpad_left = 0;
        dpad_right = 0;
        for (;;) {
            self setactionslot(3, "<unknown string>");
            self setactionslot(4, "<unknown string>");
            if (!dpad_left && self buttonpressed("<unknown string>")) {
                setdvar("<unknown string>", "<unknown string>");
                dpad_left = 1;
            } else if (!self buttonpressed("<unknown string>")) {
                dpad_left = 0;
            }
            if (!dpad_right && self buttonpressed("<unknown string>")) {
                setdvar("<unknown string>", "<unknown string>");
                dpad_right = 1;
            } else if (!self buttonpressed("<unknown string>")) {
                dpad_right = 0;
            }
            wait(0.05);
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_1fefb654
    // Checksum 0x27a030a3, Offset: 0x3de8
    // Size: 0x162
    function devgui_unlimited_ammo() {
        self notify(#"devgui_unlimited_ammo");
        self endon(#"devgui_unlimited_ammo");
        self endon(#"disconnect");
        for (;;) {
            wait(1);
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
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_d4757f3c
    // Checksum 0x71b2d8b6, Offset: 0x3f58
    // Size: 0x11e
    function devgui_unlimited_momentum() {
        level notify(#"devgui_unlimited_momentum");
        level endon(#"devgui_unlimited_momentum");
        for (;;) {
            wait(1);
            players = getplayers();
            foreach (player in players) {
                if (!isdefined(player)) {
                    continue;
                }
                if (!isalive(player)) {
                    continue;
                }
                if (player.sessionstate != "<unknown string>") {
                    continue;
                }
                globallogic_score::_setplayermomentum(player, 5000);
            }
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_289ca173
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
            if (player.sessionstate != "<unknown string>") {
                continue;
            }
            player globallogic_score::giveplayermomentumnotification(score, %"<unknown string>", "<unknown string>");
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_a72d8be8
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
        self.debug_health_bar.alignx = "<unknown string>";
        self.debug_health_bar.aligny = "<unknown string>";
        self.debug_health_bar.horzalign = "<unknown string>";
        self.debug_health_bar.vertalign = "<unknown string>";
        self.debug_health_bar.alpha = 1;
        self.debug_health_bar.foreground = 1;
        self.debug_health_bar setshader("<unknown string>", 1, 8);
        self.debug_health_text = newclienthudelem(self);
        self.debug_health_text.x = x + 80;
        self.debug_health_text.y = y;
        self.debug_health_text.alignx = "<unknown string>";
        self.debug_health_text.aligny = "<unknown string>";
        self.debug_health_text.horzalign = "<unknown string>";
        self.debug_health_text.vertalign = "<unknown string>";
        self.debug_health_text.alpha = 1;
        self.debug_health_text.fontscale = 1;
        self.debug_health_text.foreground = 1;
        if (!isdefined(self.maxhealth) || self.maxhealth <= 0) {
            self.maxhealth = 100;
        }
        for (;;) {
            wait(0.05);
            width = self.health / self.maxhealth * 300;
            width = int(max(width, 1));
            self.debug_health_bar setshader("<unknown string>", width, 8);
            self.debug_health_text setvalue(self.health);
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_91e82e7b
    // Checksum 0xe50d0b39, Offset: 0x44c0
    // Size: 0xc6
    function giveextraperks() {
        if (!isdefined(self.extraperks)) {
            return;
        }
        perks = getarraykeys(self.extraperks);
        for (i = 0; i < perks.size; i++) {
            println("<unknown string>" + self.name + "<unknown string>" + perks[i] + "<unknown string>");
            self setperk(perks[i]);
        }
    }

    // Namespace dev
    // Params 2, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_3a8a644f
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
        victim thread [[ level.callbackplayerdamage ]](attacker, attacker, 1000, 0, "<unknown string>", level.weaponnone, (0, 0, 0), (0, 0, 0), "<unknown string>", (0, 0, 0), 0, 0, (1, 0, 0));
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_efe63614
    // Checksum 0x23fc05b7, Offset: 0x46e8
    // Size: 0x24
    function testscriptruntimeerrorassert() {
        wait(1);
        assert(0);
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_b973d78b
    // Checksum 0xf0d6b813, Offset: 0x4718
    // Size: 0x2c
    function testscriptruntimeassertmsgassert() {
        wait(1);
        assertmsg("<unknown string>");
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_256f48df
    // Checksum 0x6ab82f7, Offset: 0x4750
    // Size: 0x2c
    function testscriptruntimeerrormsgassert() {
        wait(1);
        errormsg("<unknown string>");
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_d6c7ab4
    // Checksum 0x967402eb, Offset: 0x4788
    // Size: 0x44
    function testscriptruntimeerror2() {
        myundefined = "<unknown string>";
        if (myundefined == 1) {
            println("<unknown string>");
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_7f73e9ef
    // Checksum 0x99f770e5, Offset: 0x47d8
    // Size: 0x1c
    function testscriptruntimeerror1() {
        testscriptruntimeerror2();
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_cf63752
    // Checksum 0x8f8af74d, Offset: 0x4800
    // Size: 0x11c
    function testscriptruntimeerror() {
        wait(5);
        for (;;) {
            if (getdvarstring("<unknown string>") != "<unknown string>") {
                break;
            }
            wait(1);
        }
        myerror = getdvarstring("<unknown string>");
        setdvar("<unknown string>", "<unknown string>");
        if (myerror == "<unknown string>") {
            testscriptruntimeerrorassert();
        } else if (myerror == "<unknown string>") {
            testscriptruntimeassertmsgassert();
        } else if (myerror == "<unknown string>") {
            testscriptruntimeerrormsgassert();
        } else {
            testscriptruntimeerror1();
        }
        thread testscriptruntimeerror();
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_92600b0d
    // Checksum 0x85eef04e, Offset: 0x4928
    // Size: 0xf4
    function testdvars() {
        wait(5);
        for (;;) {
            if (getdvarstring("<unknown string>") != "<unknown string>") {
                break;
            }
            wait(1);
        }
        tokens = strtok(getdvarstring("<unknown string>"), "<unknown string>");
        dvarname = tokens[0];
        dvarvalue = tokens[1];
        setdvar(dvarname, dvarvalue);
        setdvar("<unknown string>", "<unknown string>");
        thread testdvars();
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_43d8ad0a
    // Checksum 0x953b8ad6, Offset: 0x4a28
    // Size: 0x1e4
    function addenemyheli() {
        wait(5);
        for (;;) {
            if (getdvarint("<unknown string>") > 0) {
                break;
            }
            wait(1);
        }
        enemyheli = getdvarint("<unknown string>");
        setdvar("<unknown string>", 0);
        team = "<unknown string>";
        player = util::gethostplayer();
        if (isdefined(player.pers["<unknown string>"])) {
            team = util::getotherteam(player.pers["<unknown string>"]);
        }
        ent = getormakebot(team);
        if (!isdefined(ent)) {
            println("<unknown string>");
            wait(1);
            thread addenemyheli();
            return;
        }
        switch (enemyheli) {
        case 1:
            level.helilocation = ent.origin;
            ent thread helicopter::usekillstreakhelicopter("<unknown string>");
            wait(0.5);
            ent notify(#"confirm_location", level.helilocation);
            break;
        case 2:
            break;
        }
        thread addenemyheli();
    }

#/

// Namespace dev
// Params 1, eflags: 0x1 linked
// namespace_eae8c9fa<file_0>::function_28e07f29
// Checksum 0xaed7c259, Offset: 0x4c18
// Size: 0x108
function getormakebot(team) {
    /#
        for (i = 0; i < level.players.size; i++) {
            if (level.players[i].team == team) {
                if (isdefined(level.players[i].pers["<unknown string>"]) && level.players[i].pers["<unknown string>"]) {
                    return level.players[i];
                }
            }
        }
        ent = bot::add_bot(team);
        if (isdefined(ent)) {
            sound::play_on_players("<unknown string>");
            wait(1);
        }
        return ent;
    #/
}

/#

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_cd0896a3
    // Checksum 0xd723e670, Offset: 0x4d28
    // Size: 0x20c
    function addtestcarepackage() {
        wait(5);
        for (;;) {
            if (getdvarint("<unknown string>") > 0) {
                break;
            }
            wait(1);
        }
        supplydrop = getdvarint("<unknown string>");
        team = "<unknown string>";
        player = util::gethostplayer();
        if (isdefined(player.pers["<unknown string>"])) {
            switch (supplydrop) {
            case 2:
                team = util::getotherteam(player.pers["<unknown string>"]);
                break;
            case 1:
            default:
                team = player.pers["<unknown string>"];
                break;
            }
        }
        setdvar("<unknown string>", 0);
        ent = getormakebot(team);
        if (!isdefined(ent)) {
            println("<unknown string>");
            wait(1);
            thread addtestcarepackage();
            return;
        }
        ent killstreakrules::killstreakstart("<unknown string>", team);
        ent thread supplydrop::helidelivercrate(ent.origin, getweapon("<unknown string>"), ent, team);
        thread addtestcarepackage();
    }

    // Namespace dev
    // Params 5, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_2bacd307
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
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_7d9b2146
    // Checksum 0x873925cd, Offset: 0x5500
    // Size: 0xe8
    function showspawnpoints() {
        if (isdefined(level.spawnpoints)) {
            color = (1, 1, 1);
            for (spawn_point_index = 0; spawn_point_index < level.spawnpoints.size; spawn_point_index++) {
                showonespawnpoint(level.spawnpoints[spawn_point_index], color, "<unknown string>");
            }
        }
        for (i = 0; i < level.dem_spawns.size; i++) {
            color = (0, 1, 0);
            showonespawnpoint(level.dem_spawns[i], color, "<unknown string>");
        }
        return;
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_af174d97
    // Checksum 0x8f477cda, Offset: 0x55f0
    // Size: 0x18
    function hidespawnpoints() {
        level notify(#"hide_spawnpoints");
        return;
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_87ae141e
    // Checksum 0x19da8736, Offset: 0x5610
    // Size: 0x2bc
    function showstartspawnpoints() {
        if (!isdefined(level.spawn_start)) {
            return;
        }
        if (level.teambased) {
            team_colors = [];
            team_colors["<unknown string>"] = (1, 0, 1);
            team_colors["<unknown string>"] = (0, 1, 1);
            team_colors["<unknown string>"] = (1, 1, 0);
            team_colors["<unknown string>"] = (0, 1, 0);
            team_colors["<unknown string>"] = (0, 0, 1);
            team_colors["<unknown string>"] = (1, 0.7, 0);
            team_colors["<unknown string>"] = (0.25, 0.25, 1);
            team_colors["<unknown string>"] = (0.88, 0, 1);
            foreach (key, color in team_colors) {
                if (!isdefined(level.spawn_start[key])) {
                    continue;
                }
                foreach (spawnpoint in level.spawn_start[key]) {
                    showonespawnpoint(spawnpoint, color, "<unknown string>");
                }
            }
            return;
        }
        color = (1, 0, 1);
        foreach (spawnpoint in level.spawn_start) {
            showonespawnpoint(spawnpoint, color, "<unknown string>");
        }
        return;
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_45d39795
    // Checksum 0x8bac8a46, Offset: 0x58d8
    // Size: 0x18
    function hidestartspawnpoints() {
        level notify(#"hide_startspawnpoints");
        return;
    }

    // Namespace dev
    // Params 6, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_f573927d
    // Checksum 0xdc31652c, Offset: 0x58f8
    // Size: 0x70
    function print3duntilnotified(origin, text, color, alpha, scale, notification) {
        level endon(notification);
        for (;;) {
            print3d(origin, text, color, alpha, scale);
            wait(0.05);
        }
    }

    // Namespace dev
    // Params 5, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_fb4b2169
    // Checksum 0xf629061e, Offset: 0x5970
    // Size: 0x68
    function lineuntilnotified(start, end, color, depthtest, notification) {
        level endon(notification);
        for (;;) {
            line(start, end, color, depthtest);
            wait(0.05);
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_d6bb5795
    // Checksum 0xfa58c923, Offset: 0x59e0
    // Size: 0x160
    function engagement_distance_debug_toggle() {
        level endon(#"kill_engage_dist_debug_toggle_watcher");
        if (!isdefined(getdvarint("<unknown string>"))) {
            setdvar("<unknown string>", "<unknown string>");
        }
        laststate = getdvarint("<unknown string>", 0);
        while (true) {
            currentstate = getdvarint("<unknown string>", 0);
            if (dvar_turned_on(currentstate) && !dvar_turned_on(laststate)) {
                weapon_engage_dists_init();
                thread debug_realtime_engage_dist();
                laststate = currentstate;
            } else if (!dvar_turned_on(currentstate) && dvar_turned_on(laststate)) {
                level notify(#"kill_all_engage_dist_debug");
                laststate = currentstate;
            }
            wait(0.3);
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_9019491d
    // Checksum 0x5aec9da2, Offset: 0x5b48
    // Size: 0x2a
    function dvar_turned_on(val) {
        if (val <= 0) {
            return 0;
        }
        return 1;
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_e74609d7
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
        level.realtimeengagedist.alignx = "<unknown string>";
        level.realtimeengagedist.fontscale = level.debug_fontscale;
        level.realtimeengagedist.x = level.debug_xpos;
        level.realtimeengagedist.y = level.debug_ypos;
        level.realtimeengagedist.color = level.white;
        level.realtimeengagedist settext("<unknown string>");
        xpos = level.debug_xpos + -49;
        level.realtimeengagedist_value = newhudelem();
        level.realtimeengagedist_value.alignx = "<unknown string>";
        level.realtimeengagedist_value.fontscale = level.debug_fontscale;
        level.realtimeengagedist_value.x = xpos;
        level.realtimeengagedist_value.y = level.debug_ypos;
        level.realtimeengagedist_value.color = level.white;
        level.realtimeengagedist_value setvalue(0);
        xpos += 37;
        level.realtimeengagedist_middle = newhudelem();
        level.realtimeengagedist_middle.alignx = "<unknown string>";
        level.realtimeengagedist_middle.fontscale = level.debug_fontscale;
        level.realtimeengagedist_middle.x = xpos;
        level.realtimeengagedist_middle.y = level.debug_ypos;
        level.realtimeengagedist_middle.color = level.white;
        level.realtimeengagedist_middle settext("<unknown string>");
        xpos += 105;
        level.realtimeengagedist_offvalue = newhudelem();
        level.realtimeengagedist_offvalue.alignx = "<unknown string>";
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
    // Params 2, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_856a5846
    // Checksum 0x6d743a90, Offset: 0x5f48
    // Size: 0x66
    function engage_dist_debug_hud_destroy(hudarray, killnotify) {
        level waittill(killnotify);
        for (i = 0; i < hudarray.size; i++) {
            hudarray[i] destroy();
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_fbd4f508
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
        engage_dists_add("<unknown string>", genericpistol);
        engage_dists_add("<unknown string>", genericpistol);
        engage_dists_add("<unknown string>", genericpistol);
        engage_dists_add("<unknown string>", genericpistol);
        engage_dists_add("<unknown string>", genericsmg);
        engage_dists_add("<unknown string>", genericsmg);
        engage_dists_add("<unknown string>", genericsmg);
        engage_dists_add("<unknown string>", genericsmg);
        engage_dists_add("<unknown string>", genericsmg);
        engage_dists_add("<unknown string>", genericsmg);
        engage_dists_add("<unknown string>", genericsmg);
        engage_dists_add("<unknown string>", shotty);
        engage_dists_add("<unknown string>", genericlmg);
        engage_dists_add("<unknown string>", genericlmg);
        engage_dists_add("<unknown string>", genericlmg);
        engage_dists_add("<unknown string>", genericlmg);
        engage_dists_add("<unknown string>", genericlmg);
        engage_dists_add("<unknown string>", genericlmg);
        engage_dists_add("<unknown string>", genericlmg);
        engage_dists_add("<unknown string>", genericlmg);
        engage_dists_add("<unknown string>", genericlmg);
        engage_dists_add("<unknown string>", genericlmg);
        engage_dists_add("<unknown string>", genericriflesa);
        engage_dists_add("<unknown string>", genericriflesa);
        engage_dists_add("<unknown string>", genericriflesa);
        engage_dists_add("<unknown string>", genericriflesa);
        engage_dists_add("<unknown string>", genericriflebolt);
        engage_dists_add("<unknown string>", genericriflebolt);
        engage_dists_add("<unknown string>", genericriflebolt);
        engage_dists_add("<unknown string>", genericriflebolt);
        engage_dists_add("<unknown string>", genericriflebolt);
        engage_dists_add("<unknown string>", generichmg);
        engage_dists_add("<unknown string>", generichmg);
        engage_dists_add("<unknown string>", generichmg);
        engage_dists_add("<unknown string>", generichmg);
        engage_dists_add("<unknown string>", genericsniper);
        engage_dists_add("<unknown string>", genericsniper);
        engage_dists_add("<unknown string>", genericsniper);
        engage_dists_add("<unknown string>", genericsniper);
        engage_dists_add("<unknown string>", genericsniper);
        engage_dists_add("<unknown string>", genericsniper);
        level thread engage_dists_watcher();
    }

    // Namespace dev
    // Params 2, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_88b8378e
    // Checksum 0xd0850ea4, Offset: 0x6888
    // Size: 0x3e
    function engage_dists_add(weaponname, values) {
        level.engagedists[getweapon(weaponname)] = values;
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_4f30f381
    // Checksum 0xa8b80d86, Offset: 0x68d0
    // Size: 0x3a
    function get_engage_dists(weapon) {
        if (isdefined(level.engagedists[weapon])) {
            return level.engagedists[weapon];
        }
        return undefined;
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_1be47913
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
                wait(0.05);
                continue;
            }
            values = get_engage_dists(playerweapon);
            if (isdefined(values)) {
                level.weaponengagedistvalues = values;
            } else {
                level.weaponengagedistvalues = undefined;
            }
            player.lastweapon = playerweapon;
            wait(0.05);
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_38935ccb
    // Checksum 0xe6fc00d7, Offset: 0x6a40
    // Size: 0x498
    function debug_realtime_engage_dist() {
        level endon(#"kill_all_engage_dist_debug");
        level endon(#"kill_realtime_engagement_distance_debug");
        hudobjarray = engagement_distance_debug_init();
        level thread engage_dist_debug_hud_destroy(hudobjarray, "<unknown string>");
        level.debugrtengagedistcolor = level.green;
        player = util::gethostplayer();
        while (true) {
            lasttracepos = (0, 0, 0);
            direction = player getplayerangles();
            direction_vec = anglestoforward(direction);
            eye = player geteye();
            eye = (eye[0], eye[1], eye[2] + 20);
            trace = bullettrace(eye, eye + vectorscale(direction_vec, 10000), 1, player);
            tracepoint = trace["<unknown string>"];
            tracenormal = trace["<unknown string>"];
            tracedist = int(distance(eye, tracepoint));
            if (tracepoint != lasttracepos) {
                lasttracepos = tracepoint;
                if (!isdefined(level.weaponengagedistvalues)) {
                    hudobj_changecolor(hudobjarray, level.white);
                    hudobjarray engagedist_hud_changetext("<unknown string>", tracedist);
                } else {
                    engagedistmin = level.weaponengagedistvalues.engagedistmin;
                    engagedistoptimal = level.weaponengagedistvalues.engagedistoptimal;
                    engagedistmulligan = level.weaponengagedistvalues.engagedistmulligan;
                    engagedistmax = level.weaponengagedistvalues.engagedistmax;
                    if (tracedist >= engagedistmin && tracedist <= engagedistmax) {
                        if (tracedist >= engagedistoptimal - engagedistmulligan && tracedist <= engagedistoptimal + engagedistmulligan) {
                            hudobjarray engagedist_hud_changetext("<unknown string>", tracedist);
                            hudobj_changecolor(hudobjarray, level.green);
                        } else {
                            hudobjarray engagedist_hud_changetext("<unknown string>", tracedist);
                            hudobj_changecolor(hudobjarray, level.yellow);
                        }
                    } else if (tracedist < engagedistmin) {
                        hudobj_changecolor(hudobjarray, level.red);
                        hudobjarray engagedist_hud_changetext("<unknown string>", tracedist);
                    } else if (tracedist > engagedistmax) {
                        hudobj_changecolor(hudobjarray, level.red);
                        hudobjarray engagedist_hud_changetext("<unknown string>", tracedist);
                    }
                }
            }
            thread function_57e53630(1, 5, 0.05, level.debugrtengagedistcolor, tracepoint, tracenormal);
            thread function_57e53630(1, 1, 0.05, level.debugrtengagedistcolor, tracepoint, tracenormal);
            wait(0.05);
        }
    }

    // Namespace dev
    // Params 2, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_45ac76e3
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
    // Params 2, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_28798e2c
    // Checksum 0xd73a623a, Offset: 0x6f80
    // Size: 0x2ec
    function engagedist_hud_changetext(engagedisttype, units) {
        if (!isdefined(level.lastdisttype)) {
            level.lastdisttype = "<unknown string>";
        }
        if (engagedisttype == "<unknown string>") {
            self[1] setvalue(units);
            self[2] settext("<unknown string>");
            self[3].alpha = 0;
        } else if (engagedisttype == "<unknown string>") {
            self[1] setvalue(units);
            self[2] settext("<unknown string>");
            self[3].alpha = 0;
        } else if (engagedisttype == "<unknown string>") {
            amountunder = level.weaponengagedistvalues.engagedistmin - units;
            self[1] setvalue(units);
            self[3] setvalue(amountunder);
            self[3].alpha = 1;
            if (level.lastdisttype != engagedisttype) {
                self[2] settext("<unknown string>");
            }
        } else if (engagedisttype == "<unknown string>") {
            amountover = units - level.weaponengagedistvalues.engagedistmax;
            self[1] setvalue(units);
            self[3] setvalue(amountover);
            self[3].alpha = 1;
            if (level.lastdisttype != engagedisttype) {
                self[2] settext("<unknown string>");
            }
        } else if (engagedisttype == "<unknown string>") {
            self[1] setvalue(units);
            self[2] settext("<unknown string>");
            self[3].alpha = 0;
        }
        level.lastdisttype = engagedisttype;
    }

    // Namespace dev
    // Params 6, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_57e53630
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
            wait(var_9f8f8bbe);
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_de893d08
    // Checksum 0xb6977d03, Offset: 0x7470
    // Size: 0x1c6
    function larry_thread() {
        setdvar("<unknown string>", "<unknown string>");
        setdvar("<unknown string>", "<unknown string>");
        setdvar("<unknown string>", "<unknown string>");
        setdvar("<unknown string>", "<unknown string>");
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
    // Params 1, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_64afd89e
    // Checksum 0x5110f, Offset: 0x7640
    // Size: 0x270
    function larry_init(larry) {
        level endon(#"kill_larry");
        larry_hud_init(larry);
        larry.model = spawn("<unknown string>", (0, 0, 0));
        larry.model setmodel("<unknown string>");
        larry.ai = [];
        wait(0.1);
        for (;;) {
            wait(0.05);
            if (larry.ai.size > 0) {
                larry.model hide();
                continue;
            }
            direction = self getplayerangles();
            direction_vec = anglestoforward(direction);
            eye = self geteye();
            trace = bullettrace(eye, eye + vectorscale(direction_vec, 8000), 0, undefined);
            dist = distance(eye, trace["<unknown string>"]);
            position = eye + vectorscale(direction_vec, dist - 64);
            larry.model.origin = position;
            larry.model.angles = self.angles + (0, 180, 0);
            if (self usebuttonpressed()) {
                self larry_ai(larry);
                while (self usebuttonpressed()) {
                    wait(0.05);
                }
            }
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_eee8ff82
    // Checksum 0x21e6aabb, Offset: 0x78b8
    // Size: 0x10c
    function larry_ai(larry) {
        larry.ai[larry.ai.size] = bot::add_bot("<unknown string>");
        i = larry.ai.size - 1;
        larry.ai[i] thread larry_ai_thread(larry, larry.model.origin, larry.model.angles);
        larry.ai[i] thread larry_ai_damage(larry);
        larry.ai[i] thread larry_ai_health(larry);
    }

    // Namespace dev
    // Params 3, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_de3f36b9
    // Checksum 0x3b01a55c, Offset: 0x79d0
    // Size: 0x1d0
    function larry_ai_thread(larry, origin, angles) {
        level endon(#"kill_larry");
        for (;;) {
            self waittill(#"spawned_player");
            larry.menu[larry.menu_health] setvalue(self.health);
            larry.menu[larry.menu_damage] settext("<unknown string>");
            larry.menu[larry.menu_range] settext("<unknown string>");
            larry.menu[larry.menu_hitloc] settext("<unknown string>");
            larry.menu[larry.menu_weapon] settext("<unknown string>");
            larry.menu[larry.menu_perks] settext("<unknown string>");
            self setorigin(origin);
            self setplayerangles(angles);
            self clearperks();
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_5d79797e
    // Checksum 0xd3629016, Offset: 0x7ba8
    // Size: 0x288
    function larry_ai_damage(larry) {
        level endon(#"kill_larry");
        for (;;) {
            damage, attacker, dir, point = self waittill(#"damage");
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
                larry.menu[larry.menu_hitloc] settext("<unknown string>");
            }
            if (isdefined(self.cac_debug_weapon)) {
                larry.menu[larry.menu_weapon] settext(self.cac_debug_weapon);
                continue;
            }
            larry.menu[larry.menu_weapon] settext("<unknown string>");
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_a3678697
    // Checksum 0x4ca61d9e, Offset: 0x7e38
    // Size: 0x60
    function larry_ai_health(larry) {
        level endon(#"kill_larry");
        for (;;) {
            wait(0.05);
            larry.menu[larry.menu_health] setvalue(self.health);
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_28dee610
    // Checksum 0x37d24781, Offset: 0x7ea0
    // Size: 0x5c6
    function larry_hud_init(larry) {
        /#
            x = -45;
            y = 275;
            menu_name = "<unknown string>";
            larry.hud = new_hud(menu_name, undefined, x, y, 1);
            larry.hud setshader("<unknown string>", -121, 65);
            larry.hud.alignx = "<unknown string>";
            larry.hud.aligny = "<unknown string>";
            larry.hud.sort = 10;
            larry.hud.alpha = 0.6;
            larry.hud.color = (0, 0, 0.5);
            larry.menu[0] = new_hud(menu_name, "<unknown string>", x + 5, y + 10, 1);
            larry.menu[1] = new_hud(menu_name, "<unknown string>", x + 5, y + 20, 1);
            larry.menu[2] = new_hud(menu_name, "<unknown string>", x + 5, y + 30, 1);
            larry.menu[3] = new_hud(menu_name, "<unknown string>", x + 5, y + 40, 1);
            larry.menu[4] = new_hud(menu_name, "<unknown string>", x + 5, y + 50, 1);
            larry.cleartextmarker = newdebughudelem();
            larry.cleartextmarker.alpha = 0;
            larry.cleartextmarker settext("<unknown string>");
            larry.menu_health = larry.menu.size;
            larry.menu_damage = larry.menu.size + 1;
            larry.menu_range = larry.menu.size + 2;
            larry.menu_hitloc = larry.menu.size + 3;
            larry.menu_weapon = larry.menu.size + 4;
            larry.menu_perks = larry.menu.size + 5;
            x_offset = 70;
            larry.menu[larry.menu_health] = new_hud(menu_name, "<unknown string>", x + x_offset, y + 10, 1);
            larry.menu[larry.menu_damage] = new_hud(menu_name, "<unknown string>", x + x_offset, y + 20, 1);
            larry.menu[larry.menu_range] = new_hud(menu_name, "<unknown string>", x + x_offset, y + 30, 1);
            larry.menu[larry.menu_hitloc] = new_hud(menu_name, "<unknown string>", x + x_offset, y + 40, 1);
            larry.menu[larry.menu_weapon] = new_hud(menu_name, "<unknown string>", x + x_offset, y + 50, 1);
            larry.menu[larry.menu_perks] = new_hud(menu_name, "<unknown string>", x + x_offset, y + 60, 1);
        #/
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_36cb859c
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
    // Params 5, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_fb312e3b
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
    // Params 7, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_8bd98a60
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
            hud.alignx = "<unknown string>";
            hud.aligny = "<unknown string>";
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
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_2f38b7bf
    // Checksum 0x6dcdba09, Offset: 0x87b8
    // Size: 0x228
    function function_2f38b7bf() {
        var_22c33e2b = getdvarint("<unknown string>");
        var_424556b9 = getdvarint("<unknown string>");
        var_d451495d = getdvarint("<unknown string>");
        while (true) {
            if (var_22c33e2b != getdvarint("<unknown string>")) {
                var_22c33e2b = getdvarint("<unknown string>");
                if (var_22c33e2b) {
                    iprintlnbold("<unknown string>");
                } else {
                    iprintlnbold("<unknown string>");
                }
            }
            if (var_424556b9 != getdvarint("<unknown string>")) {
                var_424556b9 = getdvarint("<unknown string>");
                if (var_424556b9) {
                    iprintlnbold("<unknown string>");
                } else {
                    iprintlnbold("<unknown string>");
                }
            }
            if (var_d451495d != getdvarint("<unknown string>")) {
                var_d451495d = getdvarint("<unknown string>");
                if (var_d451495d) {
                    iprintlnbold("<unknown string>");
                } else {
                    iprintlnbold("<unknown string>");
                }
            }
            wait(1);
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_d99660db
    // Checksum 0xf5afdbaf, Offset: 0x89e8
    // Size: 0x10
    function function_d99660db() {
        return "<unknown string>";
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // namespace_eae8c9fa<file_0>::function_c5833485
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
                if (!dpad_left && self buttonpressed("<unknown string>")) {
                    self giveweaponnextattachment("<unknown string>");
                    dpad_left = 1;
                    self thread print_weapon_name();
                }
                if (!dpad_right && self buttonpressed("<unknown string>")) {
                    self giveweaponnextattachment("<unknown string>");
                    dpad_right = 1;
                    self thread print_weapon_name();
                }
                if (!dpad_up && self buttonpressed("<unknown string>")) {
                    self giveweaponnextattachment("<unknown string>");
                    dpad_up = 1;
                    self thread print_weapon_name();
                }
                if (!dpad_down && self buttonpressed("<unknown string>")) {
                    self giveweaponnextattachment("<unknown string>");
                    dpad_down = 1;
                    self thread print_weapon_name();
                }
                if (!var_96f03d58 && self buttonpressed("<unknown string>")) {
                    self giveweaponnextattachment("<unknown string>");
                    var_96f03d58 = 1;
                    self thread print_weapon_name();
                }
            }
            if (!self buttonpressed("<unknown string>")) {
                dpad_left = 0;
            }
            if (!self buttonpressed("<unknown string>")) {
                dpad_right = 0;
            }
            if (!self buttonpressed("<unknown string>")) {
                dpad_up = 0;
            }
            if (!self buttonpressed("<unknown string>")) {
                dpad_down = 0;
            }
            if (!self buttonpressed("<unknown string>")) {
                var_96f03d58 = 0;
            }
            wait(0.05);
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_142688a5
    // Checksum 0x4b66c4c8, Offset: 0x8db8
    // Size: 0x11c
    function print_weapon_name() {
        self notify(#"print_weapon_name");
        self endon(#"print_weapon_name");
        wait(0.2);
        if (self isswitchingweapons()) {
            weapon = self waittill(#"weapon_change_complete");
            fail_safe = 0;
            while (weapon == level.weaponnone) {
                weapon = self waittill(#"weapon_change_complete");
                wait(0.05);
                fail_safe++;
                if (fail_safe > 120) {
                    break;
                }
            }
        } else {
            weapon = self getcurrentweapon();
        }
        printweaponname = getdvarint("<unknown string>", 1);
        if (printweaponname) {
            iprintlnbold(weapon.name);
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_5bd29d09
    // Checksum 0x6b3b6a44, Offset: 0x8ee0
    // Size: 0x1b2
    function set_equipment_list() {
        if (isdefined(level.dev_equipment)) {
            return;
        }
        level.dev_equipment = [];
        level.dev_equipment[1] = getweapon("<unknown string>");
        level.dev_equipment[2] = getweapon("<unknown string>");
        level.dev_equipment[3] = getweapon("<unknown string>");
        level.dev_equipment[4] = getweapon("<unknown string>");
        level.dev_equipment[5] = getweapon("<unknown string>");
        level.dev_equipment[6] = getweapon("<unknown string>");
        level.dev_equipment[7] = getweapon("<unknown string>");
        level.dev_equipment[8] = getweapon("<unknown string>");
        level.dev_equipment[9] = getweapon("<unknown string>");
        level.dev_equipment[10] = getweapon("<unknown string>");
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_bf6932f7
    // Checksum 0xe8d5e3a2, Offset: 0x90a0
    // Size: 0x1da
    function set_grenade_list() {
        if (isdefined(level.dev_grenade)) {
            return;
        }
        level.dev_grenade = [];
        level.dev_grenade[1] = getweapon("<unknown string>");
        level.dev_grenade[2] = getweapon("<unknown string>");
        level.dev_grenade[3] = getweapon("<unknown string>");
        level.dev_grenade[4] = getweapon("<unknown string>");
        level.dev_grenade[5] = getweapon("<unknown string>");
        level.dev_grenade[6] = getweapon("<unknown string>");
        level.dev_grenade[7] = getweapon("<unknown string>");
        level.dev_grenade[8] = getweapon("<unknown string>");
        level.dev_grenade[9] = getweapon("<unknown string>");
        level.dev_grenade[10] = getweapon("<unknown string>");
        level.dev_grenade[11] = getweapon("<unknown string>");
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_498ac57d
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
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_660b1787
    // Checksum 0xe5eee73f, Offset: 0x9348
    // Size: 0x128
    function equipment_dev_gui() {
        set_equipment_list();
        set_grenade_list();
        setdvar("<unknown string>", "<unknown string>");
        while (true) {
            wait(0.5);
            devgui_int = getdvarint("<unknown string>");
            if (devgui_int != 0) {
                for (i = 0; i < level.players.size; i++) {
                    take_all_grenades_and_equipment(level.players[i]);
                    level.players[i] giveweapon(level.dev_equipment[devgui_int]);
                }
                setdvar("<unknown string>", "<unknown string>");
            }
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_4ebc24c9
    // Checksum 0x46d7c44d, Offset: 0x9478
    // Size: 0x128
    function grenade_dev_gui() {
        set_equipment_list();
        set_grenade_list();
        setdvar("<unknown string>", "<unknown string>");
        while (true) {
            wait(0.5);
            devgui_int = getdvarint("<unknown string>");
            if (devgui_int != 0) {
                for (i = 0; i < level.players.size; i++) {
                    take_all_grenades_and_equipment(level.players[i]);
                    level.players[i] giveweapon(level.dev_grenade[devgui_int]);
                }
                setdvar("<unknown string>", "<unknown string>");
            }
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_1b69fde8
    // Checksum 0x84e4d854, Offset: 0x95a8
    // Size: 0x28c
    function force_grenade_throw(weapon) {
        if (weapon == level.weaponnone) {
            return;
        }
        setdvar("<unknown string>", "<unknown string>");
        setdvar("<unknown string>", "<unknown string>");
        setdvar("<unknown string>", "<unknown string>");
        setdvar("<unknown string>", "<unknown string>");
        setdvar("<unknown string>", "<unknown string>");
        host = util::gethostplayer();
        if (!isdefined(host.team)) {
            iprintln("<unknown string>");
            return;
        }
        bot = getormakebot(util::getotherteam(host.team));
        if (!isdefined(bot)) {
            iprintln("<unknown string>");
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
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_7f9e1229
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
            wait(0.5);
            host = util::gethostplayer();
            level.var_b70561a5 = 0;
        }
        dpad_left = 0;
        dpad_right = 0;
        for (;;) {
            wait(0.05);
            host setactionslot(3, "<unknown string>");
            host setactionslot(4, "<unknown string>");
            players = getplayers();
            max = players.size;
            if (!dpad_left && host buttonpressed("<unknown string>")) {
                level.var_b70561a5--;
                if (level.var_b70561a5 < 0) {
                    level.var_b70561a5 = max - 1;
                }
                if (!players[level.var_b70561a5] util::is_bot()) {
                    continue;
                }
                dpad_left = 1;
            } else if (!host buttonpressed("<unknown string>")) {
                dpad_left = 0;
            }
            if (!dpad_right && host buttonpressed("<unknown string>")) {
                level.var_b70561a5++;
                if (level.var_b70561a5 >= max) {
                    level.var_b70561a5 = 0;
                }
                if (!players[level.var_b70561a5] util::is_bot()) {
                    continue;
                }
                dpad_right = 1;
            } else if (!host buttonpressed("<unknown string>")) {
                dpad_right = 0;
            }
            level notify(#"hash_357e4644");
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_fdfd1b20
    // Checksum 0x122dce78, Offset: 0x9af0
    // Size: 0xac
    function function_fdfd1b20() {
        level endon(#"hash_7e05f110");
        level thread function_7f9e1229();
        iprintln("<unknown string>");
        iprintln("<unknown string>");
        for (;;) {
            if (getdvarint("<unknown string>") != level.var_b70561a5) {
                setdvar("<unknown string>", level.var_b70561a5);
            }
            level waittill(#"hash_357e4644");
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_97fd4406
    // Checksum 0x4bb85f63, Offset: 0x9ba8
    // Size: 0xac
    function function_97fd4406() {
        level endon(#"hash_b4aa652");
        level thread function_7f9e1229();
        iprintln("<unknown string>");
        iprintln("<unknown string>");
        for (;;) {
            if (getdvarint("<unknown string>") != level.var_b70561a5) {
                setdvar("<unknown string>", level.var_b70561a5);
            }
            level waittill(#"hash_357e4644");
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_194def6b
    // Checksum 0x6b4a398c, Offset: 0x9c60
    // Size: 0xac
    function function_194def6b() {
        level endon(#"hash_aab0cfd5");
        level thread function_7f9e1229();
        iprintln("<unknown string>");
        iprintln("<unknown string>");
        for (;;) {
            if (getdvarint("<unknown string>") != level.var_b70561a5) {
                setdvar("<unknown string>", level.var_b70561a5);
            }
            level waittill(#"hash_357e4644");
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_7e05f110
    // Checksum 0x4870abd, Offset: 0x9d18
    // Size: 0x34
    function function_7e05f110() {
        level notify(#"hash_7e05f110");
        setdvar("<unknown string>", "<unknown string>");
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_aab0cfd5
    // Checksum 0x56cf9897, Offset: 0x9d58
    // Size: 0x34
    function function_aab0cfd5() {
        level notify(#"hash_aab0cfd5");
        setdvar("<unknown string>", "<unknown string>");
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_b4aa652
    // Checksum 0x8d38dd0c, Offset: 0x9d98
    // Size: 0x34
    function function_b4aa652() {
        level notify(#"hash_b4aa652");
        setdvar("<unknown string>", "<unknown string>");
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_5528f222
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
        endonmsg = "<unknown string>";
        while (true) {
            if (killstreaks::should_draw_debug("<unknown string>") > 0) {
                nodes = [];
                end = 0;
                node = getvehiclenode("<unknown string>", "<unknown string>");
                if (!isdefined(node)) {
                    println("<unknown string>");
                    setdvar("<unknown string>", "<unknown string>");
                    continue;
                }
                while (isdefined(node.target)) {
                    new_node = getvehiclenode(node.target, "<unknown string>");
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
                        case 8:
                            textcolor = green;
                            textalpha = 1;
                            break;
                        case 8:
                            textcolor = red;
                            textalpha = 1;
                            break;
                        case 8:
                            textcolor = white;
                            textalpha = 1;
                            break;
                        }
                        switch (node.script_noteworthy) {
                        case 8:
                        case 8:
                        case 8:
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
                wait(0.05);
                continue;
            }
            wait(1);
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_eace8596
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
        endonmsg = "<unknown string>";
        while (true) {
            if (getdvarint("<unknown string>") > 0) {
                script_origins = getentarray("<unknown string>", "<unknown string>");
                foreach (ent in script_origins) {
                    if (isdefined(ent.targetname)) {
                        switch (ent.targetname) {
                        case 8:
                            textcolor = blue;
                            textalpha = 1;
                            textscale = 3;
                            break;
                        case 8:
                            textcolor = green;
                            textalpha = 1;
                            textscale = 3;
                            break;
                        case 8:
                            textcolor = red;
                            textalpha = 1;
                            textscale = 3;
                            break;
                        case 8:
                            textcolor = white;
                            textalpha = 1;
                            textscale = 3;
                            break;
                        }
                        switch (ent.targetname) {
                        case 8:
                        case 8:
                        case 8:
                        case 8:
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
            if (getdvarint("<unknown string>") == 0) {
                level notify(endonmsg);
                drawtime = maxdrawtime;
                wait(1);
            }
            wait(0.05);
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_a1b4a9e6
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
    // Params 4, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_9c8f13fc
    // Checksum 0xa3935e6c, Offset: 0xa768
    // Size: 0x74
    function drawtargetnametext(textcolor, textalpha, textscale, textoffset) {
        if (!isdefined(textoffset)) {
            textoffset = (0, 0, 0);
        }
        print3d(self.origin + textoffset, self.targetname, textcolor, textalpha, textscale);
    }

    // Namespace dev
    // Params 4, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_4c38993b
    // Checksum 0x42e4ccd3, Offset: 0xa7e8
    // Size: 0x74
    function drawnoteworthytext(textcolor, textalpha, textscale, textoffset) {
        if (!isdefined(textoffset)) {
            textoffset = (0, 0, 0);
        }
        print3d(self.origin + textoffset, self.script_noteworthy, textcolor, textalpha, textscale);
    }

    // Namespace dev
    // Params 4, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_6d6b630
    // Checksum 0x85c30ab3, Offset: 0xa868
    // Size: 0xc4
    function draworigintext(textcolor, textalpha, textscale, textoffset) {
        if (!isdefined(textoffset)) {
            textoffset = (0, 0, 0);
        }
        originstring = "<unknown string>" + self.origin[0] + "<unknown string>" + self.origin[1] + "<unknown string>" + self.origin[2] + "<unknown string>";
        print3d(self.origin + textoffset, originstring, textcolor, textalpha, textscale);
    }

    // Namespace dev
    // Params 4, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_d02a2e25
    // Checksum 0xd9e111a9, Offset: 0xa938
    // Size: 0xdc
    function drawspeedacceltext(textcolor, textalpha, textscale, textoffset) {
        if (isdefined(self.script_airspeed)) {
            print3d(self.origin + (0, 0, textoffset[2] * 2), "<unknown string>" + self.script_airspeed, textcolor, textalpha, textscale);
        }
        if (isdefined(self.script_accel)) {
            print3d(self.origin + (0, 0, textoffset[2] * 3), "<unknown string>" + self.script_accel, textcolor, textalpha, textscale);
        }
    }

    // Namespace dev
    // Params 7, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_2302cd4a
    // Checksum 0xdab997ed, Offset: 0xaa20
    // Size: 0x154
    function drawpath(linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg) {
        level endon(endonmsg);
        ent = self;
        entfirsttarget = ent.targetname;
        while (isdefined(ent.target)) {
            enttarget = getent(ent.target, "<unknown string>");
            ent thread drawpathsegment(enttarget, linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg);
            if (ent.targetname == "<unknown string>") {
                entfirsttarget = ent.target;
            } else if (ent.target == entfirsttarget) {
                break;
            }
            ent = enttarget;
            wait(0.05);
        }
    }

    // Namespace dev
    // Params 8, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_2f793f75
    // Checksum 0xb6f3ecbc, Offset: 0xab80
    // Size: 0x124
    function drawpathsegment(enttarget, linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg) {
        level endon(endonmsg);
        while (drawtime > 0) {
            if (isdefined(self.targetname) && self.targetname == "<unknown string>") {
                print3d(self.origin + textoffset, self.targetname, textcolor, textalpha, textscale);
            }
            line(self.origin, enttarget.origin, linecolor);
            self drawspeedacceltext(textcolor, textalpha, textscale, textoffset);
            drawtime -= 0.05;
            wait(0.05);
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_2c520d1
    // Checksum 0xd9794609, Offset: 0xacb0
    // Size: 0xc6
    function get_lookat_origin(player) {
        angles = player getplayerangles();
        forward = anglestoforward(angles);
        dir = vectorscale(forward, 8000);
        eye = player geteye();
        trace = bullettrace(eye, eye + dir, 0, undefined);
        return trace["<unknown string>"];
    }

    // Namespace dev
    // Params 2, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_71fc369f
    // Checksum 0x2065d9e6, Offset: 0xad80
    // Size: 0x74
    function draw_pathnode(node, color) {
        if (!isdefined(color)) {
            color = (1, 0, 1);
        }
        box(node.origin, (-16, -16, 0), (16, 16, 16), 0, color, 1, 0, 1);
    }

    // Namespace dev
    // Params 2, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_11a3f646
    // Checksum 0xb08a4281, Offset: 0xae00
    // Size: 0x48
    function draw_pathnode_think(node, color) {
        level endon(#"draw_pathnode_stop");
        for (;;) {
            draw_pathnode(node, color);
            wait(0.05);
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_7a3af9ad
    // Checksum 0x785cc348, Offset: 0xae50
    // Size: 0x1a
    function draw_pathnodes_stop() {
        wait(5);
        level notify(#"draw_pathnode_stop");
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_dfff46e4
    // Checksum 0x2d6353b9, Offset: 0xae78
    // Size: 0x120
    function node_get(player) {
        for (;;) {
            wait(0.05);
            origin = get_lookat_origin(player);
            node = getnearestnode(origin);
            if (!isdefined(node)) {
                continue;
            }
            if (player buttonpressed("<unknown string>")) {
                return node;
            } else if (player buttonpressed("<unknown string>")) {
                return undefined;
            }
            if (node.type == "<unknown string>") {
                draw_pathnode(node, (1, 0, 1));
                continue;
            }
            draw_pathnode(node, (0.85, 0.85, 0.1));
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_fe53bfd5
    // Checksum 0x6aba584, Offset: 0xafa0
    // Size: 0x1a8
    function dev_get_node_pair() {
        player = util::gethostplayer();
        start = undefined;
        while (!isdefined(start)) {
            start = node_get(player);
            if (player buttonpressed("<unknown string>")) {
                level notify(#"draw_pathnode_stop");
                return undefined;
            }
        }
        level thread draw_pathnode_think(start, (0, 1, 0));
        while (player buttonpressed("<unknown string>")) {
            wait(0.05);
        }
        end = undefined;
        while (!isdefined(end)) {
            end = node_get(player);
            if (player buttonpressed("<unknown string>")) {
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
    // Params 2, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_348d62f8
    // Checksum 0xf5c55329, Offset: 0xb150
    // Size: 0x5c
    function draw_point(origin, color) {
        if (!isdefined(color)) {
            color = (1, 0, 1);
        }
        sphere(origin, 16, color, 0.25, 0, 16, 1);
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // namespace_eae8c9fa<file_0>::function_7a7785fc
    // Checksum 0x5272ed8d, Offset: 0xb1b8
    // Size: 0xa0
    function point_get(player) {
        for (;;) {
            wait(0.05);
            origin = get_lookat_origin(player);
            if (player buttonpressed("<unknown string>")) {
                return origin;
            } else if (player buttonpressed("<unknown string>")) {
                return undefined;
            }
            draw_point(origin, (1, 0, 1));
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // namespace_eae8c9fa<file_0>::function_2258c623
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
        while (player buttonpressed("<unknown string>")) {
            wait(0.05);
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
