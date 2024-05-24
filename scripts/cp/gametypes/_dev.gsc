#using scripts/cp/_util;
#using scripts/cp/gametypes/_globallogic_utils;
#using scripts/cp/gametypes/_globallogic_score;
#using scripts/cp/gametypes/_globallogic;
#using scripts/cp/gametypes/_dev_class;
#using scripts/shared/bots/_bot;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/dev_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace dev;

/#

    // Namespace dev
    // Params 0, eflags: 0x2
    // Checksum 0xe20e768c, Offset: 0x268
    // Size: 0x3c
    function autoexec function_2dc19561() {
        system::register("<unknown string>", &__init__, undefined, "<unknown string>");
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9270c289, Offset: 0x2b0
    // Size: 0x2c
    function __init__() {
        callback::on_start_gametype(&init);
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // Checksum 0x2209a918, Offset: 0x2e8
    // Size: 0x360
    function init() {
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
        thread devhelipathdebugdraw();
        thread devstraferunpathdebugdraw();
        setdvar("<unknown string>", "<unknown string>");
        setdvar("<unknown string>", "<unknown string>");
        setdvar("<unknown string>", "<unknown string>");
        thread equipment_dev_gui();
        thread grenade_dev_gui();
        setdvar("<unknown string>", "<unknown string>");
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
        callback::on_connect(&on_player_connect);
        for (;;) {
            updatedevsettings();
            wait(0.5);
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1e134ad4, Offset: 0x650
    // Size: 0x8
    function on_player_connect() {
        
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb3cfe920, Offset: 0x660
    // Size: 0x54
    function warpalltohost(team) {
        host = util::gethostplayer();
        warpalltoplayer(team, host.name);
    }

    // Namespace dev
    // Params 2, eflags: 0x1 linked
    // Checksum 0x734abc16, Offset: 0x6c0
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
    // Checksum 0xbbf0471c, Offset: 0xa40
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
                wait(0.05);
                setdvar("<unknown string>", "<unknown string>");
            }
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // Checksum 0x71897e1c, Offset: 0xea0
    // Size: 0x18be
    function updatedevsettings() {
        show_spawns = getdvarint("<unknown string>");
        show_start_spawns = getdvarint("<unknown string>");
        player = util::gethostplayer();
        updateminimapsetting();
        if (level.players.size > 0) {
            if (getdvarstring("<unknown string>") == "<unknown string>") {
                warpalltohost();
            } else if (getdvarstring("<unknown string>") == "<unknown string>") {
                warpalltohost(getdvarstring("<unknown string>"));
            } else if (getdvarstring("<unknown string>") == "<unknown string>") {
                warpalltohost(getdvarstring("<unknown string>"));
            } else if (strstartswith(getdvarstring("<unknown string>"), "<unknown string>")) {
                name = getsubstr(getdvarstring("<unknown string>"), 8);
                warpalltoplayer(getdvarstring("<unknown string>"), name);
            } else if (strstartswith(getdvarstring("<unknown string>"), "<unknown string>")) {
                name = getsubstr(getdvarstring("<unknown string>"), 11);
                warpalltoplayer(getdvarstring("<unknown string>"), name);
            } else if (strstartswith(getdvarstring("<unknown string>"), "<unknown string>")) {
                name = getsubstr(getdvarstring("<unknown string>"), 4);
                warpalltoplayer(undefined, name);
            } else if (getdvarstring("<unknown string>") == "<unknown string>") {
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
            } else if (getdvarstring("<unknown string>") == "<unknown string>") {
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
            } else if (getdvarstring("<unknown string>") == "<unknown string>") {
                players = getplayers();
                setdvar("<unknown string>", "<unknown string>");
                spawns = level.spawnpoints;
                spawns = arraycombine(spawns, level.dem_spawns, 1, 0);
                if (!isdefined(level.devgui_spawn_index)) {
                    level.devgui_spawn_index = 0;
                } else {
                    level.devgui_spawn_index++;
                    if (level.devgui_spawn_index >= spawns.size) {
                        level.devgui_spawn_index = 0;
                    }
                }
                if (!isdefined(spawns) || spawns.size <= 0) {
                    return;
                }
                for (i = 0; i < players.size; i++) {
                    players[i] setorigin(spawns[level.devgui_spawn_index].origin);
                    players[i] setplayerangles(spawns[level.devgui_spawn_index].angles);
                }
            } else if (getdvarstring("<unknown string>") == "<unknown string>") {
                players = getplayers();
                setdvar("<unknown string>", "<unknown string>");
                spawns = level.spawnpoints;
                spawns = arraycombine(spawns, level.dem_spawns, 1, 0);
                if (!isdefined(level.devgui_spawn_index)) {
                    level.devgui_spawn_index = 0;
                } else {
                    level.devgui_spawn_index--;
                    if (level.devgui_spawn_index < 0) {
                        level.devgui_spawn_index = spawns.size - 1;
                    }
                }
                if (!isdefined(spawns) || spawns.size <= 0) {
                    return;
                }
                for (i = 0; i < players.size; i++) {
                    players[i] setorigin(spawns[level.devgui_spawn_index].origin);
                    players[i] setplayerangles(spawns[level.devgui_spawn_index].angles);
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
                    wait(0.05);
                    setdvar("<unknown string>", "<unknown string>");
                }
            }
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
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa345a04f, Offset: 0x2768
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
    // Checksum 0x563f228f, Offset: 0x2900
    // Size: 0x14a
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
                self givemaxammo(weapon);
            }
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0x95250b68, Offset: 0x2a58
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
    // Checksum 0xc7fa43d0, Offset: 0x2d78
    // Size: 0xc6
    function giveextraperks() {
        if (!isdefined(self.extraperks)) {
            return;
        }
        perks = getarraykeys(self.extraperks);
        for (i = 0; i < perks.size; i++) {
            /#
                println("<unknown string>" + self.name + "<unknown string>" + perks[i] + "<unknown string>");
            #/
            self setperk(perks[i]);
        }
    }

    // Namespace dev
    // Params 2, eflags: 0x1 linked
    // Checksum 0x1c9d1429, Offset: 0x2e48
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
    // Checksum 0xb430d3b, Offset: 0x2fa0
    // Size: 0x24
    function testscriptruntimeerrorassert() {
        wait(1);
        /#
            assert(0);
        #/
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // Checksum 0x495f3ec9, Offset: 0x2fd0
    // Size: 0x44
    function testscriptruntimeerror2() {
        myundefined = "<unknown string>";
        if (myundefined == 1) {
            println("<unknown string>");
        }
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8f9b8d47, Offset: 0x3020
    // Size: 0x1c
    function testscriptruntimeerror1() {
        testscriptruntimeerror2();
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa55889d4, Offset: 0x3048
    // Size: 0xcc
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
        } else {
            testscriptruntimeerror1();
        }
        thread testscriptruntimeerror();
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd7d2bb8f, Offset: 0x3120
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
    // Params 5, eflags: 0x0
    // Checksum 0x8e440970, Offset: 0x3220
    // Size: 0x58e
    function showonespawnpoint(spawn_point, color, notification, height, print) {
        if (!isdefined(height) || height <= 0) {
            height = util::get_player_height();
        }
        if (!isdefined(print)) {
            print = spawn_point.classname;
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
    // Params 6, eflags: 0x1 linked
    // Checksum 0xe04b8c8f, Offset: 0x37b8
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
    // Checksum 0x4fbd31a7, Offset: 0x3830
    // Size: 0x68
    function lineuntilnotified(start, end, color, depthtest, notification) {
        level endon(notification);
        for (;;) {
            line(start, end, color, depthtest);
            wait(0.05);
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x0
    // Checksum 0x96d21c6b, Offset: 0x38a0
    // Size: 0x2a
    function dvar_turned_on(val) {
        if (val <= 0) {
            return 0;
        }
        return 1;
    }

    // Namespace dev
    // Params 5, eflags: 0x1 linked
    // Checksum 0x6c24969e, Offset: 0x38d8
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
    // Checksum 0x706ad4fa, Offset: 0x39a8
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
    // Checksum 0x32172257, Offset: 0x3b58
    // Size: 0x10
    function function_d99660db() {
        return "<unknown string>";
    }

    // Namespace dev
    // Params 0, eflags: 0x0
    // Checksum 0xc2e840b, Offset: 0x3b70
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
    // Checksum 0x602eb61a, Offset: 0x3f28
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
    // Checksum 0xd6345ba, Offset: 0x4050
    // Size: 0x18a
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
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // Checksum 0xdfce22f0, Offset: 0x41e8
    // Size: 0x1b2
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
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // Checksum 0xfda9360f, Offset: 0x43a8
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
    // Checksum 0xd8f24030, Offset: 0x4468
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
    // Checksum 0x3ea2d3af, Offset: 0x4598
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
    // Params 0, eflags: 0x1 linked
    // Checksum 0x35d27dca, Offset: 0x46c8
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
            if (getdvarint("<unknown string>") > 0) {
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
    // Checksum 0x5a438bfa, Offset: 0x4b70
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
    // Checksum 0xedd3418f, Offset: 0x4f38
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
    // Checksum 0x1969d55, Offset: 0x5058
    // Size: 0x74
    function drawtargetnametext(textcolor, textalpha, textscale, textoffset) {
        if (!isdefined(textoffset)) {
            textoffset = (0, 0, 0);
        }
        print3d(self.origin + textoffset, self.targetname, textcolor, textalpha, textscale);
    }

    // Namespace dev
    // Params 4, eflags: 0x1 linked
    // Checksum 0xb62b37cc, Offset: 0x50d8
    // Size: 0x74
    function drawnoteworthytext(textcolor, textalpha, textscale, textoffset) {
        if (!isdefined(textoffset)) {
            textoffset = (0, 0, 0);
        }
        print3d(self.origin + textoffset, self.script_noteworthy, textcolor, textalpha, textscale);
    }

    // Namespace dev
    // Params 4, eflags: 0x1 linked
    // Checksum 0x2163031b, Offset: 0x5158
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
    // Checksum 0x9f3838d7, Offset: 0x5228
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
    // Checksum 0x8a673efb, Offset: 0x5310
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
    // Checksum 0x31bfe0b9, Offset: 0x5470
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
    // Checksum 0xacee10d5, Offset: 0x55a0
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
    // Checksum 0x90f6f6a8, Offset: 0x5670
    // Size: 0x74
    function draw_pathnode(node, color) {
        if (!isdefined(color)) {
            color = (1, 0, 1);
        }
        box(node.origin, (-16, -16, 0), (16, 16, 16), 0, color, 1, 0, 1);
    }

    // Namespace dev
    // Params 2, eflags: 0x1 linked
    // Checksum 0xae81bc87, Offset: 0x56f0
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
    // Checksum 0x5a16418b, Offset: 0x5740
    // Size: 0x1a
    function draw_pathnodes_stop() {
        wait(5);
        level notify(#"draw_pathnode_stop");
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // Checksum 0xddccdfdb, Offset: 0x5768
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
    // Params 0, eflags: 0x0
    // Checksum 0xe203db97, Offset: 0x5890
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
    // Checksum 0x5fe65e0e, Offset: 0x5a40
    // Size: 0x5c
    function draw_point(origin, color) {
        if (!isdefined(color)) {
            color = (1, 0, 1);
        }
        sphere(origin, 16, color, 0.25, 0, 16, 1);
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // Checksum 0xdf6afad9, Offset: 0x5aa8
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
    // Checksum 0x53bb7461, Offset: 0x5b50
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
