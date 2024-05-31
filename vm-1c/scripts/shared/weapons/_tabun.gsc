#using scripts/shared/util_shared;
#using scripts/shared/sound_shared;
#using scripts/codescripts/struct;

#namespace tabun;

// Namespace tabun
// Params 0, eflags: 0x1 linked
// namespace_f5ebf79f<file_0>::function_1463e4e5
// Checksum 0x6be7c8be, Offset: 0x390
// Size: 0x2fc
function init_shared() {
    level.tabuninitialgasshockduration = getdvarint("scr_tabunInitialGasShockDuration", "7");
    level.tabunwalkingasshockduration = getdvarint("scr_tabunWalkInGasShockDuration", "4");
    level.tabungasshockradius = getdvarint("scr_tabun_shock_radius", "185");
    level.tabungasshockheight = getdvarint("scr_tabun_shock_height", "20");
    level.tabungaspoisonradius = getdvarint("scr_tabun_effect_radius", "185");
    level.tabungaspoisonheight = getdvarint("scr_tabun_shock_height", "20");
    level.tabungasduration = getdvarint("scr_tabunGasDuration", "8");
    level.poisonduration = getdvarint("scr_poisonDuration", "8");
    level.poisondamage = getdvarint("scr_poisonDamage", "13");
    level.poisondamagehardcore = getdvarint("scr_poisonDamageHardcore", "5");
    level.fx_tabun_0 = "tabun_tiny_mp";
    level.fx_tabun_1 = "tabun_small_mp";
    level.fx_tabun_2 = "tabun_medium_mp";
    level.fx_tabun_3 = "tabun_large_mp";
    level.fx_tabun_single = "tabun_center_mp";
    level.fx_tabun_radius0 = getdvarint("scr_fx_tabun_radius0", 55);
    level.fx_tabun_radius1 = getdvarint("scr_fx_tabun_radius1", 55);
    level.fx_tabun_radius2 = getdvarint("scr_fx_tabun_radius2", 50);
    level.fx_tabun_radius3 = getdvarint("scr_fx_tabun_radius3", 25);
    level.sound_tabun_start = "wpn_gas_hiss_start";
    level.sound_tabun_loop = "wpn_gas_hiss_lp";
    level.sound_tabun_stop = "wpn_gas_hiss_end";
    level.sound_shock_tabun_start = "";
    level.sound_shock_tabun_loop = "";
    level.sound_shock_tabun_stop = "";
    /#
        level thread checkdvarupdates();
    #/
}

// Namespace tabun
// Params 0, eflags: 0x1 linked
// namespace_f5ebf79f<file_0>::function_261a8166
// Checksum 0x6943bd01, Offset: 0x698
// Size: 0x248
function checkdvarupdates() {
    while (true) {
        level.tabungaspoisonradius = getdvarint("scr_tabun_effect_radius", level.tabungaspoisonradius);
        level.tabungaspoisonheight = getdvarint("scr_tabun_shock_height", level.tabungaspoisonheight);
        level.tabungasshockradius = getdvarint("scr_tabun_shock_radius", level.tabungasshockradius);
        level.tabungasshockheight = getdvarint("scr_tabun_shock_height", level.tabungasshockheight);
        level.tabuninitialgasshockduration = getdvarint("scr_tabunInitialGasShockDuration", level.tabuninitialgasshockduration);
        level.tabunwalkingasshockduration = getdvarint("scr_tabunWalkInGasShockDuration", level.tabunwalkingasshockduration);
        level.tabungasduration = getdvarint("scr_tabunGasDuration", level.tabungasduration);
        level.poisonduration = getdvarint("scr_poisonDuration", level.poisonduration);
        level.poisondamage = getdvarint("scr_poisonDamage", level.poisondamage);
        level.poisondamagehardcore = getdvarint("scr_poisonDamageHardcore", level.poisondamagehardcore);
        level.fx_tabun_radius0 = getdvarint("scr_fx_tabun_radius0", level.fx_tabun_radius0);
        level.fx_tabun_radius1 = getdvarint("scr_fx_tabun_radius1", level.fx_tabun_radius1);
        level.fx_tabun_radius2 = getdvarint("scr_fx_tabun_radius2", level.fx_tabun_radius2);
        level.fx_tabun_radius3 = getdvarint("scr_fx_tabun_radius3", level.fx_tabun_radius3);
        wait(1);
    }
}

// Namespace tabun
// Params 1, eflags: 0x1 linked
// namespace_f5ebf79f<file_0>::function_34e6850f
// Checksum 0x319b862e, Offset: 0x8e8
// Size: 0xd4
function watchtabungrenadedetonation(owner) {
    self endon(#"trophy_destroyed");
    position, surface = self waittill(#"explode");
    if (!isdefined(level.water_duds) || level.water_duds == 1) {
        if (isdefined(surface) && surface == "water") {
            return;
        }
    }
    if (getdvarint("scr_enable_new_tabun", 1)) {
        generatelocations(position, owner);
        return;
    }
    singlelocation(position, owner);
}

// Namespace tabun
// Params 5, eflags: 0x1 linked
// namespace_f5ebf79f<file_0>::function_7c624c9a
// Checksum 0x50b3fa68, Offset: 0x9c8
// Size: 0x3f2
function damageeffectarea(owner, position, radius, height, killcament) {
    shockeffectarea = spawn("trigger_radius", position, 0, radius, height);
    gaseffectarea = spawn("trigger_radius", position, 0, radius, height);
    /#
        if (getdvarint("scr_tabun_effect_radius")) {
            level thread util::drawcylinder(position, radius, height, undefined, "scr_tabun_effect_radius");
        }
    #/
    if (isdefined(level.dogsonflashdogs)) {
        owner thread [[ level.dogsonflashdogs ]](shockeffectarea);
        owner thread [[ level.dogsonflashdogs ]](gaseffectarea);
    }
    loopwaittime = 0.5;
    for (durationoftabun = level.tabungasduration; durationoftabun > 0; durationoftabun -= loopwaittime) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (level.friendlyfire == 0) {
                if (players[i] != owner) {
                    if (!isdefined(owner) || !isdefined(owner.team)) {
                        continue;
                    }
                    if (level.teambased && players[i].team == owner.team) {
                        continue;
                    }
                }
            }
            if (!isdefined(players[i].inpoisonarea) || players[i].inpoisonarea == 0) {
                if (players[i] istouching(gaseffectarea) && players[i].sessionstate == "playing") {
                    if (!players[i] hasperk("specialty_proximityprotection")) {
                        trace = bullettrace(position, players[i].origin + (0, 0, 12), 0, players[i]);
                        if (trace["fraction"] == 1) {
                            players[i].lastpoisonedby = owner;
                            players[i] thread damageinpoisonarea(shockeffectarea, killcament, trace, position);
                        }
                    }
                }
            }
        }
        wait(loopwaittime);
    }
    if (level.tabungasduration < level.poisonduration) {
        wait(level.poisonduration - level.tabungasduration);
    }
    shockeffectarea delete();
    gaseffectarea delete();
    /#
        if (getdvarint("scr_tabun_effect_radius")) {
            level notify(#"tabun_draw_cylinder_stop");
        }
    #/
}

// Namespace tabun
// Params 4, eflags: 0x1 linked
// namespace_f5ebf79f<file_0>::function_7ae91d1c
// Checksum 0xae633b96, Offset: 0xdc8
// Size: 0x3b0
function damageinpoisonarea(gaseffectarea, killcament, trace, position) {
    self endon(#"disconnect");
    self endon(#"death");
    self thread watch_death();
    self.inpoisonarea = 1;
    self startpoisoning();
    tabunshocksound = spawn("script_origin", (0, 0, 1));
    tabunshocksound thread deleteentonownerdeath(self);
    tabunshocksound.origin = position;
    tabunshocksound playsound(level.sound_shock_tabun_start);
    tabunshocksound playloopsound(level.sound_shock_tabun_loop);
    timer = 0;
    while (trace["fraction"] == 1 && isdefined(gaseffectarea) && self istouching(gaseffectarea) && self.sessionstate == "playing" && isdefined(self.lastpoisonedby)) {
        damage = level.poisondamage;
        if (level.hardcoremode) {
            damage = level.poisondamagehardcore;
        }
        self dodamage(damage, gaseffectarea.origin, self.lastpoisonedby, killcament, "none", "MOD_GAS", 0, getweapon("tabun_gas"));
        if (self util::mayapplyscreeneffect()) {
            switch (timer) {
            case 0:
                self shellshock("tabun_gas_mp", 1);
                break;
            case 1:
                self shellshock("tabun_gas_nokick_mp", 1);
                break;
            default:
                break;
            }
            timer++;
            if (timer >= 2) {
                timer = 0;
            }
            self function_87a4a08b();
        }
        wait(1);
        trace = bullettrace(position, self.origin + (0, 0, 12), 0, self);
    }
    tabunshocksound stoploopsound(0.5);
    wait(0.5);
    thread sound::play_in_space(level.sound_shock_tabun_stop, position);
    wait(0.5);
    tabunshocksound notify(#"delete");
    tabunshocksound delete();
    self show_hud();
    self stoppoisoning();
    self.inpoisonarea = 0;
}

// Namespace tabun
// Params 1, eflags: 0x1 linked
// namespace_f5ebf79f<file_0>::function_b9e9934d
// Checksum 0x874b0fe4, Offset: 0x1180
// Size: 0x3c
function deleteentonownerdeath(owner) {
    self endon(#"delete");
    owner waittill(#"death");
    self delete();
}

// Namespace tabun
// Params 0, eflags: 0x1 linked
// namespace_f5ebf79f<file_0>::function_1a6dacfd
// Checksum 0xae128989, Offset: 0x11c8
// Size: 0x24
function watch_death() {
    self waittill(#"death");
    self show_hud();
}

// Namespace tabun
// Params 0, eflags: 0x1 linked
// namespace_f5ebf79f<file_0>::function_87a4a08b
// Checksum 0x5f3c9081, Offset: 0x11f8
// Size: 0x1c
function function_87a4a08b() {
    self util::show_hud(0);
}

// Namespace tabun
// Params 0, eflags: 0x1 linked
// namespace_f5ebf79f<file_0>::function_c72856fc
// Checksum 0x4323a513, Offset: 0x1220
// Size: 0x1c
function show_hud() {
    self util::show_hud(1);
}

// Namespace tabun
// Params 2, eflags: 0x1 linked
// namespace_f5ebf79f<file_0>::function_c3c997c
// Checksum 0xe0a0baa, Offset: 0x1248
// Size: 0xcc
function generatelocations(position, owner) {
    onefoot = (0, 0, 12);
    startpos = position + onefoot;
    /#
        level.tabun_debug = getdvarint("scr_tabun_effect_radius", 0);
        if (level.tabun_debug) {
            black = (0.2, 0.2, 0.2);
            debugstar(startpos, 2000, black);
        }
    #/
    spawnalllocs(owner, startpos);
}

// Namespace tabun
// Params 2, eflags: 0x1 linked
// namespace_f5ebf79f<file_0>::function_6098a370
// Checksum 0x75d904ff, Offset: 0x1320
// Size: 0xcc
function singlelocation(position, owner) {
    spawntimedfx(level.fx_tabun_single, position);
    killcament = spawn("script_model", position + (0, 0, 60));
    killcament util::deleteaftertime(15);
    killcament.starttime = gettime();
    damageeffectarea(owner, position, level.tabungaspoisonradius, level.tabungaspoisonheight, killcament);
}

// Namespace tabun
// Params 3, eflags: 0x1 linked
// namespace_f5ebf79f<file_0>::function_22c017de
// Checksum 0xa81e5806, Offset: 0x13f8
// Size: 0xd8
function hitpos(start, end, color) {
    trace = bullettrace(start, end, 0, undefined);
    /#
        level.tabun_debug = getdvarint("scr_tabun_effect_radius", 0);
        if (level.tabun_debug) {
            debugstar(trace["scr_tabun_effect_radius"], 2000, color);
        }
        thread tabun_debug_line(start, trace["scr_tabun_effect_radius"], color, 1, 80);
    #/
    return trace["position"];
}

// Namespace tabun
// Params 2, eflags: 0x1 linked
// namespace_f5ebf79f<file_0>::function_21bcade2
// Checksum 0x6533de4f, Offset: 0x14d8
// Size: 0x976
function spawnalllocs(owner, startpos) {
    defaultdistance = getdvarint("scr_defaultDistanceTabun", -36);
    cos45 = 0.707;
    negcos45 = -0.707;
    red = (0.9, 0.2, 0.2);
    blue = (0.2, 0.2, 0.9);
    green = (0.2, 0.9, 0.2);
    white = (0.9, 0.9, 0.9);
    north = startpos + (defaultdistance, 0, 0);
    south = startpos - (defaultdistance, 0, 0);
    east = startpos + (0, defaultdistance, 0);
    west = startpos - (0, defaultdistance, 0);
    nw = startpos + (cos45 * defaultdistance, negcos45 * defaultdistance, 0);
    ne = startpos + (cos45 * defaultdistance, cos45 * defaultdistance, 0);
    sw = startpos + (negcos45 * defaultdistance, negcos45 * defaultdistance, 0);
    se = startpos + (negcos45 * defaultdistance, cos45 * defaultdistance, 0);
    locations = [];
    locations["color"] = [];
    locations["loc"] = [];
    locations["tracePos"] = [];
    locations["distSqrd"] = [];
    locations["fxtoplay"] = [];
    locations["radius"] = [];
    locations["color"][0] = red;
    locations["color"][1] = red;
    locations["color"][2] = blue;
    locations["color"][3] = blue;
    locations["color"][4] = green;
    locations["color"][5] = green;
    locations["color"][6] = white;
    locations["color"][7] = white;
    locations["point"][0] = north;
    locations["point"][1] = ne;
    locations["point"][2] = east;
    locations["point"][3] = se;
    locations["point"][4] = south;
    locations["point"][5] = sw;
    locations["point"][6] = west;
    locations["point"][7] = nw;
    for (count = 0; count < 8; count++) {
        trace = hitpos(startpos, locations["point"][count], locations["color"][count]);
        locations["tracePos"][count] = trace;
        locations["loc"][count] = startpos / 2 + trace / 2;
        locations["loc"][count] = locations["loc"][count] - (0, 0, 12);
        locations["distSqrd"][count] = distancesquared(startpos, trace);
    }
    centroid = getcenteroflocations(locations);
    killcament = spawn("script_model", centroid + (0, 0, 60));
    killcament util::deleteaftertime(15);
    killcament.starttime = gettime();
    center = getcenter(locations);
    for (i = 0; i < 8; i++) {
        fxtoplay = setuptabunfx(owner, locations, i);
        switch (fxtoplay) {
        case 0:
            locations["fxtoplay"][i] = level.fx_tabun_0;
            locations["radius"][i] = level.fx_tabun_radius0;
            break;
        case 1:
            locations["fxtoplay"][i] = level.fx_tabun_1;
            locations["radius"][i] = level.fx_tabun_radius1;
            break;
        case 2:
            locations["fxtoplay"][i] = level.fx_tabun_2;
            locations["radius"][i] = level.fx_tabun_radius2;
            break;
        case 3:
            locations["fxtoplay"][i] = level.fx_tabun_3;
            locations["radius"][i] = level.fx_tabun_radius3;
            break;
        default:
            locations["fxtoplay"][i] = undefined;
            locations["radius"][i] = 0;
            break;
        }
    }
    singleeffect = 1;
    freepassused = 0;
    for (i = 0; i < 8; i++) {
        if (locations["radius"][i] != level.fx_tabun_radius0) {
            if (freepassused == 0 && locations["radius"][i] == level.fx_tabun_radius1) {
                freepassused = 1;
                continue;
            }
            singleeffect = 0;
        }
    }
    onefoot = (0, 0, 12);
    startpos -= onefoot;
    thread playtabunsound(startpos);
    if (singleeffect == 1) {
        singlelocation(startpos, owner);
        return;
    }
    spawntimedfx(level.fx_tabun_3, startpos);
    for (count = 0; count < 8; count++) {
        if (isdefined(locations["fxtoplay"][count])) {
            spawntimedfx(locations["fxtoplay"][count], locations["loc"][count]);
            thread damageeffectarea(owner, locations["loc"][count], locations["radius"][count], locations["radius"][count], killcament);
        }
    }
}

// Namespace tabun
// Params 1, eflags: 0x1 linked
// namespace_f5ebf79f<file_0>::function_f98e3f3a
// Checksum 0xac500c34, Offset: 0x1e58
// Size: 0xf4
function playtabunsound(position) {
    tabunsound = spawn("script_origin", (0, 0, 1));
    tabunsound.origin = position;
    tabunsound playsound(level.sound_tabun_start);
    tabunsound playloopsound(level.sound_tabun_loop);
    wait(level.tabungasduration);
    thread sound::play_in_space(level.sound_tabun_stop, position);
    tabunsound stoploopsound(0.5);
    wait(0.5);
    tabunsound delete();
}

// Namespace tabun
// Params 3, eflags: 0x1 linked
// namespace_f5ebf79f<file_0>::function_b5ff6f1a
// Checksum 0xfb735030, Offset: 0x1f58
// Size: 0x2e2
function setuptabunfx(owner, locations, count) {
    fxtoplay = undefined;
    previous = count - 1;
    if (previous < 0) {
        previous += locations["loc"].size;
    }
    next = count + 1;
    if (next >= locations["loc"].size) {
        next -= locations["loc"].size;
    }
    effect0dist = level.fx_tabun_radius0 * level.fx_tabun_radius0;
    effect1dist = level.fx_tabun_radius1 * level.fx_tabun_radius1;
    effect2dist = level.fx_tabun_radius2 * level.fx_tabun_radius2;
    effect3dist = level.fx_tabun_radius3 * level.fx_tabun_radius3;
    effect4dist = level.fx_tabun_radius3;
    fxtoplay = -1;
    if (locations["distSqrd"][count] > effect0dist && locations["distSqrd"][previous] > effect1dist && locations["distSqrd"][next] > effect1dist) {
        fxtoplay = 0;
    } else if (locations["distSqrd"][count] > effect1dist && locations["distSqrd"][previous] > effect2dist && locations["distSqrd"][next] > effect2dist) {
        fxtoplay = 1;
    } else if (locations["distSqrd"][count] > effect2dist && locations["distSqrd"][previous] > effect3dist && locations["distSqrd"][next] > effect3dist) {
        fxtoplay = 2;
    } else if (locations["distSqrd"][count] > effect3dist && locations["distSqrd"][previous] > effect4dist && locations["distSqrd"][next] > effect4dist) {
        fxtoplay = 3;
    }
    return fxtoplay;
}

// Namespace tabun
// Params 1, eflags: 0x1 linked
// namespace_f5ebf79f<file_0>::function_d0951719
// Checksum 0xe3929658, Offset: 0x2248
// Size: 0x100
function getcenteroflocations(locations) {
    centroid = (0, 0, 0);
    for (i = 0; i < locations["loc"].size; i++) {
        centroid += locations["loc"][i] / locations["loc"].size;
    }
    /#
        level.tabun_debug = getdvarint("scr_tabun_effect_radius", 0);
        if (level.tabun_debug) {
            purple = (0.9, 0.2, 0.9);
            debugstar(centroid, 2000, purple);
        }
    #/
    return centroid;
}

// Namespace tabun
// Params 1, eflags: 0x1 linked
// namespace_f5ebf79f<file_0>::function_f8892858
// Checksum 0x9192584c, Offset: 0x2350
// Size: 0x268
function getcenter(locations) {
    center = (0, 0, 0);
    curx = locations["tracePos"][0][0];
    cury = locations["tracePos"][0][1];
    minx = curx;
    maxx = curx;
    miny = cury;
    maxy = cury;
    for (i = 1; i < locations["tracePos"].size; i++) {
        curx = locations["tracePos"][i][0];
        cury = locations["tracePos"][i][1];
        if (curx > maxx) {
            maxx = curx;
        } else if (curx < minx) {
            minx = curx;
        }
        if (cury > maxy) {
            maxy = cury;
            continue;
        }
        if (cury < miny) {
            miny = cury;
        }
    }
    avgx = (maxx + minx) / 2;
    avgy = (maxy + miny) / 2;
    center = (avgx, avgy, locations["tracePos"][0][2]);
    /#
        level.tabun_debug = getdvarint("scr_tabun_effect_radius", 0);
        if (level.tabun_debug) {
            cyan = (0.2, 0.9, 0.9);
            debugstar(center, 2000, cyan);
        }
    #/
    return center;
}

/#

    // Namespace tabun
    // Params 5, eflags: 0x1 linked
    // namespace_f5ebf79f<file_0>::function_63abb1a0
    // Checksum 0x93c5b9bc, Offset: 0x25c0
    // Size: 0xbc
    function tabun_debug_line(from, to, color, depthtest, time) {
        debug_rcbomb = getdvarint("scr_tabun_effect_radius", 0);
        if (debug_rcbomb == "scr_tabun_effect_radius") {
            if (!isdefined(time)) {
                time = 100;
            }
            if (!isdefined(depthtest)) {
                depthtest = 1;
            }
            line(from, to, color, 1, depthtest, time);
        }
    }

#/
