#using scripts/shared/abilities/_ability_player;
#using scripts/cp/gametypes/_weaponobjects;
#using scripts/cp/_trophy_system;
#using scripts/cp/_tacticalinsertion;
#using scripts/cp/_tabun;
#using scripts/cp/_smokegrenade;
#using scripts/cp/_sensor_grenade;
#using scripts/cp/_satchel_charge;
#using scripts/cp/_riotshield;
#using scripts/cp/_proximity_grenade;
#using scripts/cp/_incendiary;
#using scripts/cp/_heatseekingmissile;
#using scripts/cp/_hacker_tool;
#using scripts/cp/_flashgrenades;
#using scripts/cp/_explosive_bolt;
#using scripts/cp/_decoy;
#using scripts/cp/_bouncingbetty;
#using scripts/cp/bonuszm/_bonuszm;
#using scripts/cp/_ballistic_knife;
#using scripts/cp/bots/_bot;
#using scripts/cp/_mobile_armory;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_oed;
#using scripts/cp/_laststand;
#using scripts/cp/_devgui;
#using scripts/cp/_destructible;
#using scripts/cp/_debug;
#using scripts/cp/_challenges;
#using scripts/cp/_cache;
#using scripts/cp/_art;
#using scripts/cp/_ammo_cache;
#using scripts/cp/gametypes/_spawning;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/_util;
#using scripts/cp/_load;
#using scripts/shared/archetype_shared/archetype_shared;
#using scripts/shared/weapons/multilockapguidance;
#using scripts/shared/weapons/antipersonnelguidance;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/tweakables_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/system_shared;
#using scripts/shared/string_shared;
#using scripts/shared/serverfaceanim_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/_oob;
#using scripts/shared/music_shared;
#using scripts/shared/medals_shared;
#using scripts/shared/math_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/load_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/gameskill_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/containers_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/clientids_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace load;

// Namespace load
// Params 0, eflags: 0x0
// namespace_d7916d65<file_0>::function_d290ebfa
// Checksum 0x6c5e9934, Offset: 0xbd8
// Size: 0x2d4
function main() {
    assert(isdefined(level.first_frame), "instant_revive");
    if (isdefined(level._loadstarted) && level._loadstarted) {
        return;
    }
    function_13c5b077();
    level thread function_f063419c();
    level flag::init("bsp_swap_ready");
    level flag::init("initial_streamer_ready");
    level._loadstarted = 1;
    setdvar("playerEnenergy_enabled", 0);
    setdvar("r_waterFogTest", 0);
    setdvar("tu6_player_shallowWaterHeight", "0.0");
    setgametypesetting("trm_maxHeight", 144);
    level.aitriggerspawnflags = getaitriggerflags();
    level.vehicletriggerspawnflags = getvehicletriggerflags();
    level flag::init("wait_and_revive");
    level flag::init("instant_revive");
    util::registerclientsys("lsm");
    level thread register_clientfields();
    setup_traversals();
    level thread onallplayersready();
    footsteps();
    gameskill::setskill(undefined, level.var_4f8d5b23);
    system::wait_till("all");
    art_review();
    level flagsys::set("load_main_complete");
    level.var_732e9c7d = &function_13aa782f;
    if (isdefined(level.var_31aefea8) && isdefined(level.var_574eb415)) {
        if (level.var_31aefea8 == level.var_574eb415) {
            world.var_bf966ebd = undefined;
        }
    }
    level thread function_4dd1a4b();
}

// Namespace load
// Params 0, eflags: 0x1 linked
// namespace_d7916d65<file_0>::function_13c5b077
// Checksum 0x27453efe, Offset: 0xeb8
// Size: 0x1c
function function_13c5b077() {
    setdvar("ui_allowDisplayContinue", 0);
}

// Namespace load
// Params 0, eflags: 0x0
// namespace_d7916d65<file_0>::function_73adcefc
// Checksum 0x6543b33b, Offset: 0xee0
// Size: 0x1c
function function_73adcefc() {
    util::function_ab12ef82("level_is_go");
}

// Namespace load
// Params 2, eflags: 0x1 linked
// namespace_d7916d65<file_0>::function_c32ba481
// Checksum 0x8419d32c, Offset: 0xf08
// Size: 0x1a4
function function_c32ba481(var_87423d00, v_color) {
    if (!isdefined(var_87423d00)) {
        var_87423d00 = 0.5;
    }
    if (!isdefined(v_color)) {
        v_color = (0, 0, 0);
    }
    level util::streamer_wait(undefined, undefined, undefined, 0);
    setdvar("ui_allowDisplayContinue", 1);
    if (isloadingcinematicplaying()) {
        do {
            wait(0.05);
        } while (isloadingcinematicplaying());
    } else {
        wait(1);
    }
    foreach (player in level.players) {
        player thread function_84454eb5();
    }
    level flag::wait_till("all_players_spawned");
    level util::streamer_wait(undefined, 0, 10);
    level notify(#"hash_c79c2551");
    level thread function_dbd0026c(var_87423d00, v_color);
}

// Namespace load
// Params 2, eflags: 0x0
// namespace_d7916d65<file_0>::function_a2995f22
// Checksum 0xa29b4711, Offset: 0x10b8
// Size: 0x7c
function function_a2995f22(var_87423d00, v_color) {
    if (!isdefined(var_87423d00)) {
        var_87423d00 = 0.5;
    }
    if (!isdefined(v_color)) {
        v_color = (0, 0, 0);
    }
    level clientfield::set("gameplay_started", 1);
    function_c32ba481(var_87423d00, v_color);
}

// Namespace load
// Params 0, eflags: 0x1 linked
// namespace_d7916d65<file_0>::function_84454eb5
// Checksum 0x92c113a3, Offset: 0x1140
// Size: 0xbc
function function_84454eb5() {
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    }
    self endon(#"disconnect");
    if (self flag::exists("loadout_given") && self flag::get("loadout_given")) {
        self openmenu("SpinnerFullscreenBlack");
        level flag::wait_till("all_players_spawned");
        self closemenu("SpinnerFullscreenBlack");
    }
}

// Namespace load
// Params 2, eflags: 0x1 linked
// namespace_d7916d65<file_0>::function_dbd0026c
// Checksum 0x32bc5d62, Offset: 0x1208
// Size: 0x104
function function_dbd0026c(var_87423d00, v_color) {
    level lui::screen_fade_out(0, "black", "go_fade");
    waittillframeend();
    if (level flagsys::get("chyron_active")) {
        level flagsys::wait_till_clear("chyron_active");
    } else {
        wait(1);
    }
    if (isdefined(level.var_75ba074a)) {
        wait(level.var_75ba074a);
    }
    level util::delay(0.3, undefined, &flag::set, level.var_d83bc14d);
    level util::delay(0.3, undefined, &lui::screen_fade_in, var_87423d00, v_color, "go_fade");
}

// Namespace load
// Params 0, eflags: 0x1 linked
// namespace_d7916d65<file_0>::function_f063419c
// Checksum 0x3928f756, Offset: 0x1318
// Size: 0x4a
function function_f063419c() {
    if (isloadingcinematicplaying()) {
        while (isloadingcinematicplaying()) {
            wait(0.05);
        }
        level notify(#"hash_b28e9639");
    }
}

// Namespace load
// Params 0, eflags: 0x1 linked
// namespace_d7916d65<file_0>::function_4dd1a4b
// Checksum 0x14fd15a2, Offset: 0x1370
// Size: 0x64
function function_4dd1a4b() {
    checkpointcreate();
    checkpointcommit();
    flag::wait_till("all_players_spawned");
    wait(0.5);
    checkpointcreate();
    checkpointcommit();
}

// Namespace load
// Params 3, eflags: 0x1 linked
// namespace_d7916d65<file_0>::function_13aa782f
// Checksum 0xc4c82d0, Offset: 0x13e0
// Size: 0x34
function function_13aa782f(player, target, weapon) {
    return !player oob::isoutofbounds();
}

// Namespace load
// Params 10, eflags: 0x0
// namespace_d7916d65<file_0>::function_37246a45
// Checksum 0x94ade954, Offset: 0x1420
// Size: 0x392
function player_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    finaldamage = idamage;
    if (isdefined(self.player_damage_override)) {
        self thread [[ self.player_damage_override ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
    }
    if (self laststand::player_is_in_laststand()) {
        return 0;
    }
    if (level.teambased && isplayer(eattacker) && self != eattacker && self.team == eattacker.team) {
        if (level.friendlyfire == 0) {
            return 0;
        }
    }
    if (idamage < self.health) {
        return finaldamage;
    }
    players = getplayers();
    count = 0;
    for (i = 0; i < players.size; i++) {
        if (players[i] == self || players[i] laststand::player_is_in_laststand() || players[i].sessionstate == "spectator") {
            count++;
        }
    }
    var_c47bf847 = players.size == 1 && self.lives == 0;
    var_af50710b = players.size > 1 && count == players.size;
    if (var_c47bf847 || var_af50710b) {
        level notify(#"stop_suicide_trigger");
        self thread laststand::playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
        if (!isdefined(vdir)) {
            vdir = (1, 0, 0);
        }
        level notify(#"last_player_died");
        self fakedamagefrom(vdir);
        self thread player_fake_death();
    }
    if (count == players.size) {
        if (players.size == 1) {
            if (self.lives == 0) {
                self.lives = 0;
                level notify(#"pre_end_game");
                util::wait_network_frame();
                level notify(#"end_game");
            } else {
                return finaldamage;
            }
        } else {
            level notify(#"pre_end_game");
            util::wait_network_frame();
            level notify(#"end_game");
        }
        return 0;
    }
    return finaldamage;
}

// Namespace load
// Params 0, eflags: 0x1 linked
// namespace_d7916d65<file_0>::function_cf62d8c1
// Checksum 0xac0adede, Offset: 0x17c0
// Size: 0xbc
function player_fake_death() {
    level notify(#"fake_death");
    self notify(#"fake_death");
    self takeallweapons();
    self allowstand(0);
    self allowcrouch(0);
    self allowprone(1);
    self.ignoreme = 1;
    self enableinvulnerability();
    wait(1);
    self freezecontrols(1);
}

// Namespace load
// Params 2, eflags: 0x1 linked
// namespace_d7916d65<file_0>::function_5aca2f62
// Checksum 0xc26c13a0, Offset: 0x1888
// Size: 0xba
function setfootstepeffect(name, fx) {
    assert(isdefined(name), "instant_revive");
    assert(isdefined(fx), "instant_revive");
    if (!isdefined(anim.optionalstepeffects)) {
        anim.optionalstepeffects = [];
    }
    anim.optionalstepeffects[anim.optionalstepeffects.size] = name;
    level._effect["step_" + name] = fx;
}

// Namespace load
// Params 0, eflags: 0x1 linked
// namespace_d7916d65<file_0>::function_cade3606
// Checksum 0x5d264170, Offset: 0x1950
// Size: 0x224
function footsteps() {
    setfootstepeffect("asphalt", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("brick", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("carpet", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("cloth", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("concrete", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("dirt", "_t6/bio/player/fx_footstep_sand");
    setfootstepeffect("foliage", "_t6/bio/player/fx_footstep_sand");
    setfootstepeffect("gravel", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("grass", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("metal", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("mud", "_t6/bio/player/fx_footstep_mud");
    setfootstepeffect("paper", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("plaster", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("rock", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("sand", "_t6/bio/player/fx_footstep_sand");
    setfootstepeffect("water", "_t6/bio/player/fx_footstep_water");
    setfootstepeffect("wood", "_t6/bio/player/fx_footstep_dust");
}

// Namespace load
// Params 0, eflags: 0x1 linked
// namespace_d7916d65<file_0>::function_a7781e10
// Checksum 0x11ce9b8e, Offset: 0x1b80
// Size: 0xbc
function init_traverse() {
    point = getent(self.target, "targetname");
    if (isdefined(point)) {
        self.traverse_height = point.origin[2];
        point delete();
        return;
    }
    point = struct::get(self.target, "targetname");
    if (isdefined(point)) {
        self.traverse_height = point.origin[2];
    }
}

// Namespace load
// Params 0, eflags: 0x1 linked
// namespace_d7916d65<file_0>::function_bc375eca
// Checksum 0xe6534e7f, Offset: 0x1c48
// Size: 0x96
function setup_traversals() {
    potential_traverse_nodes = getallnodes();
    for (i = 0; i < potential_traverse_nodes.size; i++) {
        node = potential_traverse_nodes[i];
        if (node.type == "Begin") {
            node init_traverse();
        }
    }
}

/#

    // Namespace load
    // Params 0, eflags: 0x0
    // namespace_d7916d65<file_0>::function_19d17757
    // Checksum 0xc8d2bded, Offset: 0x1ce8
    // Size: 0x24
    function function_19d17757() {
        assert(0, "instant_revive");
    }

#/

// Namespace load
// Params 0, eflags: 0x0
// namespace_d7916d65<file_0>::function_9b37c2bc
// Checksum 0x76675287, Offset: 0x1d18
// Size: 0x34
function function_9b37c2bc() {
    level flag::wait_till("bsp_swap_ready");
    switchmap_switch();
}

// Namespace load
// Params 0, eflags: 0x1 linked
// namespace_d7916d65<file_0>::function_e6e399a9
// Checksum 0xd23b6388, Offset: 0x1d58
// Size: 0x71a
function end_game() {
    level waittill(#"end_game");
    check_end_game_intermission_delay();
    println("instant_revive");
    util::clientnotify("zesn");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        util::setclientsysstate("lsm", "0", players[i]);
    }
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i].var_fca62492)) {
            players[i].var_fca62492 destroy();
        }
    }
    stopallrumbles();
    level.intermission = 1;
    wait(0.1);
    game_over = [];
    survived = [];
    players = getplayers();
    setmatchflag("disableIngameMenu", 1);
    foreach (player in players) {
        player closeingamemenu();
    }
    if (!isdefined(level.var_78a27045)) {
        for (i = 0; i < players.size; i++) {
            game_over[i] = newclienthudelem(players[i]);
            game_over[i].alignx = "center";
            game_over[i].aligny = "middle";
            game_over[i].horzalign = "center";
            game_over[i].vertalign = "middle";
            game_over[i].y = game_over[i].y - -126;
            game_over[i].foreground = 1;
            game_over[i].fontscale = 3;
            game_over[i].alpha = 0;
            game_over[i].color = (1, 1, 1);
            game_over[i].hidewheninmenu = 1;
            game_over[i] settext(%COOP_GAME_OVER);
            game_over[i] fadeovertime(1);
            game_over[i].alpha = 1;
            if (players[i] issplitscreen()) {
                game_over[i].fontscale = 2;
                game_over[i].y = game_over[i].y + 40;
            }
        }
    } else {
        level thread [[ level.var_78a27045 ]]("");
    }
    for (i = 0; i < players.size; i++) {
        players[i] setclientuivisibilityflag("weapon_hud_visible", 0);
        players[i] setclientminiscoreboardhide(1);
    }
    uploadstats();
    wait(1);
    wait(3.95);
    foreach (icon in survived) {
        icon destroy();
    }
    foreach (icon in game_over) {
        icon destroy();
    }
    level notify(#"round_end_done");
    if (isdefined(level.var_4c3d1a55)) {
        [[ level.var_4c3d1a55 ]]();
        level.var_4c3d1a55 = undefined;
    } else {
        intermission();
        wait(15);
        level notify(#"stop_intermission");
    }
    array::thread_all(getplayers(), &player_exit_level);
    wait(1.5);
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] cameraactivate(0);
    }
    exitlevel(0);
    wait(666);
}

// Namespace load
// Params 0, eflags: 0x1 linked
// namespace_d7916d65<file_0>::function_4b93af95
// Checksum 0x2c880e48, Offset: 0x2480
// Size: 0x19e
function intermission() {
    level.intermission = 1;
    level notify(#"intermission");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        util::setclientsysstate("levelNotify", "zi", players[i]);
        players[i] setclientthirdperson(0);
        players[i] resetfov();
        players[i].health = 100;
        players[i] thread player_intermission();
        players[i] stopsounds();
    }
    wait(0.25);
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        util::setclientsysstate("lsm", "0", players[i]);
    }
}

// Namespace load
// Params 0, eflags: 0x1 linked
// namespace_d7916d65<file_0>::function_333f42d1
// Checksum 0x6a205449, Offset: 0x2628
// Size: 0x5e2
function player_intermission() {
    self closeingamemenu();
    level endon(#"stop_intermission");
    self endon(#"disconnect");
    self endon(#"death");
    self notify(#"_zombie_game_over");
    self.sessionstate = "intermission";
    self.spectatorclient = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.friendlydamage = undefined;
    points = struct::get_array("intermission", "targetname");
    if (!isdefined(points) || points.size == 0) {
        points = getentarray("info_intermission", "classname");
        if (points.size < 1) {
            println("instant_revive");
            return;
        }
    }
    self.var_bff517de = newclienthudelem(self);
    self.var_bff517de.horzalign = "fullscreen";
    self.var_bff517de.vertalign = "fullscreen";
    self.var_bff517de setshader("black", 640, 480);
    self.var_bff517de.alpha = 1;
    org = undefined;
    while (true) {
        points = array::randomize(points);
        for (i = 0; i < points.size; i++) {
            point = points[i];
            if (!isdefined(org)) {
                self spawn(point.origin, point.angles);
            }
            if (isdefined(points[i].target)) {
                if (!isdefined(org)) {
                    org = spawn("script_model", self.origin + (0, 0, -60));
                    org setmodel("tag_origin");
                }
                org.origin = points[i].origin;
                org.angles = points[i].angles;
                for (j = 0; j < getplayers().size; j++) {
                    player = getplayers()[j];
                    player camerasetposition(org);
                    player camerasetlookat();
                    player cameraactivate(1);
                }
                speed = 20;
                if (isdefined(points[i].speed)) {
                    speed = points[i].speed;
                }
                target_point = struct::get(points[i].target, "targetname");
                dist = distance(points[i].origin, target_point.origin);
                time = dist / speed;
                var_57ae7e4a = time * 0.25;
                if (var_57ae7e4a > 1) {
                    var_57ae7e4a = 1;
                }
                self.var_bff517de fadeovertime(var_57ae7e4a);
                self.var_bff517de.alpha = 0;
                org moveto(target_point.origin, time, var_57ae7e4a, var_57ae7e4a);
                org rotateto(target_point.angles, time, var_57ae7e4a, var_57ae7e4a);
                wait(time - var_57ae7e4a);
                self.var_bff517de fadeovertime(var_57ae7e4a);
                self.var_bff517de.alpha = 1;
                wait(var_57ae7e4a);
                continue;
            }
            self.var_bff517de fadeovertime(1);
            self.var_bff517de.alpha = 0;
            wait(5);
            self.var_bff517de thread fade_up_over_time(1);
        }
    }
}

// Namespace load
// Params 1, eflags: 0x1 linked
// namespace_d7916d65<file_0>::function_8fd93042
// Checksum 0x1b94a42e, Offset: 0x2c18
// Size: 0x30
function fade_up_over_time(t) {
    self fadeovertime(t);
    self.alpha = 1;
}

// Namespace load
// Params 0, eflags: 0x1 linked
// namespace_d7916d65<file_0>::function_6117716e
// Checksum 0x9b173f37, Offset: 0x2c50
// Size: 0xb0
function player_exit_level() {
    self allowstand(1);
    self allowcrouch(0);
    self allowprone(0);
    if (isdefined(self.var_bff517de)) {
        self.var_bff517de.foreground = 1;
        self.var_bff517de.sort = 100;
        self.var_bff517de fadeovertime(1);
        self.var_bff517de.alpha = 1;
    }
}

// Namespace load
// Params 1, eflags: 0x0
// namespace_d7916d65<file_0>::function_30a0305
// Checksum 0xb4d8856f, Offset: 0x2d08
// Size: 0x26
function disable_end_game_intermission(delay) {
    level.disable_intermission = 1;
    wait(delay);
    level.disable_intermission = undefined;
}

// Namespace load
// Params 0, eflags: 0x1 linked
// namespace_d7916d65<file_0>::function_a04c8fe5
// Checksum 0x2648b2bb, Offset: 0x2d38
// Size: 0x34
function check_end_game_intermission_delay() {
    if (isdefined(level.disable_intermission)) {
        while (true) {
            if (!isdefined(level.disable_intermission)) {
                break;
            }
            wait(0.01);
        }
    }
}

// Namespace load
// Params 0, eflags: 0x1 linked
// namespace_d7916d65<file_0>::function_74ae7da4
// Checksum 0xac310b54, Offset: 0x2d78
// Size: 0x26c
function onallplayersready() {
    level flag::init("start_coop_logic");
    level thread end_game();
    println("instant_revive" + getnumexpectedplayers());
    do {
        wait(0.05);
        var_f862b7b1 = getnumconnectedplayers(0);
        var_91f98264 = getnumexpectedplayers();
        player_count_actual = 0;
        for (i = 0; i < level.players.size; i++) {
            if (level.players[i].sessionstate == "playing" || level.players[i].sessionstate == "spectator") {
                player_count_actual++;
            }
        }
        println("instant_revive" + getnumconnectedplayers() + "instant_revive" + getnumexpectedplayers());
    } while (var_f862b7b1 < var_91f98264 || player_count_actual < var_91f98264);
    setinitialplayersconnected();
    setdvar("all_players_are_connected", "1");
    /#
        printtoprightln("instant_revive", (1, 1, 1));
    #/
    disablegrenadesuicide();
    level flag::set("all_players_connected");
    level flag::set("initial_streamer_ready");
    level flag::set("start_coop_logic");
}

// Namespace load
// Params 0, eflags: 0x1 linked
// namespace_d7916d65<file_0>::function_4ece4a2f
// Checksum 0xa8492a77, Offset: 0x2ff0
// Size: 0x34
function register_clientfields() {
    clientfield::register("toplayer", "sndHealth", 1, 2, "int");
}

