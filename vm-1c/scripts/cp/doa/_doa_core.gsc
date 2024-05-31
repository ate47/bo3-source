#using scripts/cp/doa/_doa_player_challenge_room;
#using scripts/cp/doa/_doa_outro;
#using scripts/cp/doa/_doa_gibs;
#using scripts/cp/doa/_doa_fate;
#using scripts/cp/doa/_doa_hazard;
#using scripts/cp/doa/_doa_tesla_pickup;
#using scripts/cp/doa/_doa_vehicle_pickup;
#using scripts/cp/doa/_doa_turret_pickup;
#using scripts/cp/doa/_doa_audio;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_enemy_boss;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_utility;
#using scripts/cp/gametypes/_globallogic_score;
#using scripts/shared/array_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/system_shared;
#using scripts/shared/player_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_693feb87;

// Namespace namespace_693feb87
// Params 0, eflags: 0x1 linked
// Checksum 0xdb6e71f, Offset: 0xde8
// Size: 0x178
function main() {
    level.var_cc93e6eb = 1;
    level.gameskill = 0;
    level.var_f0ca204d = 1;
    init();
    level flagsys::wait_till("start_coop_logic");
    firsttime = 1;
    while (isloadingcinematicplaying()) {
        wait(0.05);
    }
    level.var_de693c3 = 1;
    foreach (player in getplayers()) {
        player.var_dba6f33e = undefined;
    }
    while (true) {
        level thread function_3e351f83(firsttime);
        level waittill(#"hash_24d3a44");
        util::wait_network_frame();
        firsttime = 0;
    }
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x5 linked
// Checksum 0xd083c13b, Offset: 0xf68
// Size: 0x32c
function private _load() {
    timeout = gettime() + 5000;
    while (getnumexpectedplayers() == 0 && gettime() < timeout) {
        wait(0.05);
    }
    var_8acfab2a = 0;
    do {
        wait(0.05);
        var_f862b7b1 = getnumconnectedplayers(0);
        var_91f98264 = getnumexpectedplayers();
        player_count_actual = 0;
        var_a349db66 = 0;
        for (i = 0; i < level.players.size; i++) {
            if (level.players[i].sessionstate == "playing" || level.players[i].sessionstate == "spectator") {
                player_count_actual++;
            } else if (isdefined(level.players[i].var_dba6f33e) && level.players[i].var_dba6f33e) {
                var_a349db66++;
            }
            if (level.players[0] isplayeronsamemachine(level.players[i])) {
                var_8acfab2a++;
            }
        }
        /#
            namespace_49107f3a::debugmsg("load_main_complete" + getnumconnectedplayers() + "load_main_complete" + getnumexpectedplayers() + "load_main_complete" + var_a349db66);
        #/
    } while (var_f862b7b1 < var_91f98264 && player_count_actual + var_a349db66 < var_91f98264);
    setinitialplayersconnected();
    level flag::set("all_players_connected");
    setdvar("all_players_are_connected", "1");
    level util::streamer_wait();
    if (var_8acfab2a > 1) {
        level.players[0] thread lui::screen_fade_out(0);
    } else {
        level thread lui::screen_fade_out(0);
    }
    setdvar("ui_allowDisplayContinue", 1);
    level flag::set("start_coop_logic");
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x1 linked
// Checksum 0x6db21511, Offset: 0x12a0
// Size: 0x94
function load() {
    level thread _load();
    system::wait_till("all");
    level flagsys::set("load_main_complete");
    while (!aretexturesloaded()) {
        wait(0.05);
    }
    level flag::set("doa_load_complete");
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x1340
// Size: 0x4
function donothing() {
    
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x1 linked
// Checksum 0x75409e9c, Offset: 0x1350
// Size: 0xdf6
function registerclientfields() {
    clientfield::register("world", "podiumEvent", 1, 1, "int");
    clientfield::register("world", "overworld", 1, 1, "int");
    clientfield::register("world", "scoreMenu", 1, 1, "int");
    clientfield::register("world", "overworldlevel", 1, 5, "int");
    clientfield::register("world", "roundnumber", 1, 10, "int");
    clientfield::register("world", "roundMenu", 1, 1, "int");
    clientfield::register("world", "teleportMenu", 1, 1, "int");
    clientfield::register("world", "numexits", 1, 3, "int");
    clientfield::register("world", "gameover", 1, 1, "int");
    clientfield::register("world", "doafps", 1, 1, "int");
    clientfield::register("allplayers", "play_fx", 1, 7, "int");
    clientfield::register("scriptmover", "play_fx", 1, 7, "int");
    clientfield::register("actor", "play_fx", 1, 7, "int");
    clientfield::register("vehicle", "play_fx", 1, 7, "int");
    clientfield::register("scriptmover", "off_fx", 1, 7, "int");
    clientfield::register("allplayers", "off_fx", 1, 7, "int");
    clientfield::register("actor", "off_fx", 1, 7, "int");
    clientfield::register("vehicle", "off_fx", 1, 7, "int");
    clientfield::register("allplayers", "play_sfx", 1, 7, "int");
    clientfield::register("scriptmover", "play_sfx", 1, 7, "int");
    clientfield::register("actor", "play_sfx", 1, 7, "int");
    clientfield::register("vehicle", "play_sfx", 1, 7, "int");
    clientfield::register("scriptmover", "off_sfx", 1, 7, "int");
    clientfield::register("allplayers", "off_sfx", 1, 7, "int");
    clientfield::register("actor", "off_sfx", 1, 7, "int");
    clientfield::register("vehicle", "off_sfx", 1, 7, "int");
    clientfield::register("allplayers", "fated_boost", 1, 1, "int");
    clientfield::register("toplayer", "sndHealth", 1, 2, "int");
    clientfield::register("allplayers", "bombDrop", 1, 1, "int");
    clientfield::register("toplayer", "changeCamera", 1, 1, "counter");
    clientfield::register("toplayer", "controlBinding", 1, 1, "counter");
    clientfield::register("toplayer", "goFPS", 1, 1, "counter");
    clientfield::register("toplayer", "exitFPS", 1, 1, "counter");
    clientfield::register("world", "cleanUpGibs", 1, 1, "counter");
    clientfield::register("world", "killweather", 1, 1, "counter");
    clientfield::register("world", "killfog", 1, 1, "counter");
    clientfield::register("world", "flipCamera", 1, 2, "int");
    clientfield::register("world", "arenaUpdate", 1, 8, "int");
    clientfield::register("world", "arenaRound", 1, 3, "int");
    clientfield::register("world", "startCountdown", 1, 3, "int");
    clientfield::register("actor", "zombie_gut_explosion", 1, 1, "int");
    clientfield::register("actor", "enemy_ragdoll_explode", 1, 1, "int");
    clientfield::register("actor", "zombie_saw_explosion", 1, 1, "int");
    clientfield::register("actor", "zombie_chunk", 1, 1, "counter");
    clientfield::register("actor", "zombie_rhino_explosion", 1, 1, "int");
    clientfield::register("world", "restart_doa", 1, 1, "counter");
    clientfield::register("world", "set_scoreHidden", 1, 1, "int");
    clientfield::register("scriptmover", "hazard_type", 1, 4, "int");
    clientfield::register("scriptmover", "hazard_activated", 1, 4, "int");
    clientfield::register("actor", "zombie_riser_fx", 1, 1, "int");
    clientfield::register("actor", "zombie_bloodriser_fx", 1, 1, "int");
    clientfield::register("scriptmover", "heartbeat", 1, 3, "int");
    clientfield::register("actor", "zombie_has_eyes", 1, 1, "int");
    clientfield::register("scriptmover", "pickuptype", 1, 10, "int");
    clientfield::register("scriptmover", "pickupwobble", 1, 1, "int");
    clientfield::register("scriptmover", "pickuprotate", 1, 1, "int");
    clientfield::register("scriptmover", "pickupscale", 1, 8, "int");
    clientfield::register("scriptmover", "pickupvisibility", 1, 1, "int");
    clientfield::register("scriptmover", "pickupmoveto", 1, 4, "int");
    clientfield::register("actor", "burnType", 1, 2, "int");
    clientfield::register("actor", "burnZombie", 1, 1, "counter");
    clientfield::register("actor", "burnCorpse", 1, 1, "counter");
    clientfield::register("world", "cameraHeight", 1, 3, "int");
    clientfield::register("world", "cleanupGiblets", 1, 1, "int");
    clientfield::register("scriptmover", "camera_focus_item", 1, 1, "int");
    clientfield::register("actor", "camera_focus_item", 1, 1, "int");
    clientfield::register("vehicle", "camera_focus_item", 1, 1, "int");
    /#
        clientfield::register("load_main_complete", "load_main_complete", 1, 2, "load_main_complete");
        clientfield::register("load_main_complete", "load_main_complete", 1, 30, "load_main_complete");
        clientfield::register("load_main_complete", "load_main_complete", 1, 1, "load_main_complete");
    #/
    for (i = 0; i < 4; i++) {
        clientfield::register("world", "set_ui_gprDOA" + i, 1, 30, "int");
        clientfield::register("world", "set_ui_gpr2DOA" + i, 1, 30, "int");
        clientfield::register("world", "set_ui_GlobalGPR" + i, 1, 30, "int");
    }
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x1 linked
// Checksum 0xa6a982a5, Offset: 0x2150
// Size: 0xac
function on_player_connect() {
    /#
        namespace_49107f3a::debugmsg("load_main_complete" + (isdefined(self.name) ? self.name : "load_main_complete"));
    #/
    self.ignoreme = 1;
    self.topdowncamera = 1;
    self.var_63830602 = gettime();
    self setclientscriptmainmenu(game["menu_class"]);
    self.var_dba6f33e = getdvarint("all_players_are_connected");
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x1 linked
// Checksum 0x71d7339, Offset: 0x2208
// Size: 0x94
function initialblack(time) {
    if (!isdefined(time)) {
        time = 12;
    }
    self endon(#"disconnect");
    self openmenu("InitialBlack");
    self util::waittill_any_timeout(time, "killInitialBlack", "disconnect");
    if (isdefined(self)) {
        self closemenu("InitialBlack");
    }
}

// Namespace namespace_693feb87
// Params 2, eflags: 0x4
// Checksum 0x6dac3bea, Offset: 0x22a8
// Size: 0x74
function private function_154ab047(currentround, idx) {
    self endon(#"hash_437a340d");
    while (isdefined(self) && isdefined(idx)) {
        if (level.doa.round_number != currentround) {
            break;
        }
        wait(0.05);
    }
    namespace_49107f3a::function_11f3f381(idx, 1);
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x1 linked
// Checksum 0x26fb27c1, Offset: 0x2328
// Size: 0xb8
function function_57863b20() {
    self notify(#"hash_57863b20");
    self endon(#"hash_57863b20");
    while (true) {
        level waittill(#"host_migration_begin");
        level waittill(#"host_migration_end");
        namespace_2f63e553::setupdevgui();
        if (isdefined(level.doa.var_52cccfb6)) {
            if (isdefined(level.doa.var_52cccfb6.host_migration)) {
                [[ level.doa.var_52cccfb6.host_migration ]](level.doa.var_52cccfb6);
            }
        }
    }
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x1 linked
// Checksum 0xf2064750, Offset: 0x23e8
// Size: 0x418
function function_437a340d(var_73419762) {
    if (isdefined(self.bot)) {
        return;
    }
    foreach (player in getplayers()) {
        if (!isdefined(player)) {
            continue;
        }
        if (player == self) {
            continue;
        }
        if (self isplayeronsamemachine(player)) {
            return;
        }
    }
    if (isdefined(self.var_744a3931)) {
        self closeluimenu(self.var_744a3931);
    }
    if (isdefined(self.var_4777f621)) {
        namespace_49107f3a::function_11f3f381(self.var_4777f621, 1);
    }
    self notify(#"hash_437a340d");
    self endon(#"disconnect");
    self endon(#"hash_437a340d");
    self.var_744a3931 = self openluimenu("DOA_PlayerReady");
    currentround = level.doa.round_number;
    timestart = gettime();
    while (level.doa.round_number == currentround) {
        self.takedamage = 0;
        self.ignoreme = 1;
        self freezecontrols(1);
        self thread namespace_49107f3a::function_d1686f4c("menuresponse", 2, "menuresponse", "notarealmenu", "notarealresponse");
        menu, response = self waittill(#"menuresponse");
        /#
            namespace_49107f3a::debugmsg("load_main_complete" + menu + "load_main_complete" + response);
        #/
        timenow = gettime();
        if (timenow - timestart > 3 * 60000) {
            break;
        }
        if (menu == "DOA_PlayerReady" && response == "MENU_READY") {
            break;
        }
    }
    if (isdefined(self.var_4777f621)) {
        namespace_49107f3a::function_11f3f381(self.var_4777f621, 1);
    }
    self.var_4777f621 = undefined;
    self closeluimenu(self.var_744a3931);
    self.var_744a3931 = undefined;
    self namespace_831a4a7c::function_d5f89a15(level.doa.rules.default_weapon);
    self thread lui::screen_fade_in(1.5);
    self freezecontrols(0);
    self.takedamage = 1;
    self.ignoreme = 0;
    self thread namespace_831a4a7c::turnplayershieldon();
    self thread namespace_831a4a7c::function_b5843d4f(level.doa.var_458c27d == 3);
    self.var_dba6f33e = undefined;
    self notify(#"hash_437a340d");
    self.doa.var_80ffe475 = var_73419762;
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x1 linked
// Checksum 0x2d8a7b6e, Offset: 0x2808
// Size: 0x254
function on_player_spawned() {
    /#
        namespace_49107f3a::debugmsg("load_main_complete" + (isdefined(self.name) ? self.name : "load_main_complete"));
    #/
    self.topdowncamera = 1;
    self thread namespace_831a4a7c::function_138c35de();
    self namespace_831a4a7c::function_7d7a7fde();
    self namespace_831a4a7c::function_60123d1c();
    self util::set_lighting_state();
    self notify(#"hash_52c9c74a", "CP_UNLOCK_DOA");
    var_9774756a = 0;
    if (isdefined(level.doa.var_e6653624)) {
        if (!isinarray(level.doa.var_e6653624, self.name)) {
            level.doa.var_e6653624[level.doa.var_e6653624.size] = self.name;
            level.doa.var_a9ba4ffb[self.name] = gettime();
        } else if (isdefined(level.doa.var_a9ba4ffb[self.name])) {
            if (gettime() - level.doa.var_a9ba4ffb[self.name] <= 5 * 60000) {
                var_9774756a = 1;
            }
        }
    }
    if (isdefined(level.doa) && level.doa.round_number >= 9) {
        self.doa.lives = 0;
        if (!(isdefined(var_9774756a) && var_9774756a)) {
            self.doa.var_80ffe475 = 1;
        }
    }
    if (isdefined(level.var_de693c3) && level.var_de693c3) {
        self thread function_437a340d(self.doa.var_80ffe475);
    }
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x1 linked
// Checksum 0x33bc4816, Offset: 0x2a68
// Size: 0x44
function on_player_disconnect() {
    if (isdefined(self.doa) && isdefined(self.doa.vehicle)) {
        self.doa.vehicle delete();
    }
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x1 linked
// Checksum 0x4e836621, Offset: 0x2ab8
// Size: 0x524
function init() {
    setgametypesetting("characterCustomization", 1);
    invalidatematchrecord();
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    callback::on_disconnect(&on_player_disconnect);
    callback::on_start_gametype(&function_53b7b84f);
    setdvar("doublejump_enabled", 0);
    setdvar("ai_instantNoSolidOnDeath", 1);
    setdvar("mantle_enable", 0);
    setdvar("trm_enable", 0);
    setdvar("ik_enable_ai_terrain", 0);
    setdvar("r_newLensFlares", 0);
    level flag::init("start_coop_logic");
    level flag::init("doa_load_complete");
    level flag::init("doa_round_active");
    level flag::init("doa_round_abort");
    level flag::init("doa_bonusroom_active");
    level flag::init("doa_round_paused");
    level flag::init("doa_game_is_over");
    level flag::init("doa_game_is_running");
    level flag::init("doa_round_spawning");
    level flag::init("doa_init_complete");
    level flag::init("doa_challenge_ready");
    level flag::init("doa_challenge_running");
    level flag::init("doa_screen_faded_out");
    level flag::init("doa_game_is_completed");
    level flag::init("doa_game_silverback_round");
    registerclientfields();
    level thread load();
    level flag::wait_till("doa_load_complete");
    level thread namespace_49107f3a::function_44eb090b(0);
    function_555fb805();
    if (isdefined(level.var_7ed6996d)) {
        [[ level.var_7ed6996d ]]();
    }
    namespace_64c6b720::init();
    namespace_eaa992c::init();
    namespace_1a381543::init();
    namespace_fba031c8::init();
    namespace_a7e6beb5::init();
    namespace_3f3eaecb::init();
    namespace_4973e019::init();
    doa_enemy::init();
    namespace_3ca3c537::init();
    namespace_aa4730ec::init();
    namespace_d88e3a06::init();
    namespace_2848f8c2::init();
    namespace_23f188a4::init();
    namespace_b5c133c::init();
    namespace_74ae326f::init();
    level thread function_57863b20();
    namespace_2f63e553::setupdevgui();
    level flag::set("doa_init_complete");
    if (!isdefined(level.voice)) {
        level.voice = spawn("script_model", (0, 0, 0));
    }
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x1 linked
// Checksum 0xc5bd80c5, Offset: 0x2fe8
// Size: 0x594
function function_c7f824a() {
    level.doa.round_number = 1;
    level.doa.var_458c27d = 0;
    level.doa.var_b351e5fb = 0;
    level.doa.total_kills = 0;
    level.doa.var_90873830 = 0;
    level.lighting_state = 0;
    level.doa.var_da96f13c = 0;
    level.doa.var_2836c8ee = undefined;
    level.doa.var_5890c17b = 0;
    level.doa.flipped = 0;
    namespace_3ca3c537::function_ba9c838e(1);
    level.doa.var_2d09b979 = 1;
    level.doa.var_53d0f8a7 = 0;
    level.doa.var_f2108348 = 0;
    level.doa.var_6f2c52d8 = undefined;
    level.doa.var_3f3f577d = "";
    level.doa.var_d9933f22 = [];
    level.doa.var_c838db72 = [];
    level.doa.var_f5e35752 = [];
    level.doa.var_53d0f8a7 = [];
    level.doa.var_d0cde02c = undefined;
    level.doa.var_bc9b7c71 = &namespace_cdb9a8fe::function_fe0946ac;
    level.doa.var_c061227e = 1;
    level.doa.zombie_move_speed = level.doa.rules.var_e626be31;
    level.doa.zombie_health = level.doa.rules.var_6fa02512;
    level.doa.var_5bd7f25a = level.doa.rules.var_72d934b2;
    level.doa.var_9a1cbf58 = 1;
    level.doa.var_7808fc8c = [];
    level.doa.var_7808fc8c["zombietron_rpg"] = &namespace_eaa992c::function_2c0f7946;
    level.doa.var_7808fc8c["zombietron_rpg_1"] = &namespace_eaa992c::function_2c0f7946;
    level.doa.var_7808fc8c["zombietron_rpg_2"] = &namespace_eaa992c::function_2c0f7946;
    level.doa.var_7808fc8c["zombietron_ray_gun"] = &namespace_eaa992c::function_2fc7e62f;
    level.doa.var_7808fc8c["zombietron_ray_gun_1"] = &namespace_eaa992c::function_2fc7e62f;
    level.doa.var_7808fc8c["zombietron_ray_gun_2"] = &namespace_eaa992c::function_2fc7e62f;
    level.doa.var_7808fc8c["zombietron_launcher"] = &namespace_eaa992c::function_4f66d2fb;
    level.doa.var_7808fc8c["zombietron_launcher_1"] = &namespace_eaa992c::function_4f66d2fb;
    level.doa.var_7808fc8c["zombietron_launcher_2"] = &namespace_eaa992c::function_4f66d2fb;
    level.doa.var_7808fc8c["zombietron_flamethrower"] = &namespace_eaa992c::function_2aa1c0b3;
    level.doa.var_7808fc8c["zombietron_flamethrower_1"] = &namespace_eaa992c::function_2aa1c0b3;
    level.doa.var_7808fc8c["zombietron_flamethrower_2"] = &namespace_eaa992c::function_2aa1c0b3;
    level.doa.var_7808fc8c["launcher_zombietron_robosatan_ai"] = &namespace_eaa992c::function_f51d2b7e;
    visionsetlaststand("");
    level thread namespace_49107f3a::set_lighting_state(0);
    level thread namespace_49107f3a::function_13fbad22();
    level flag::clear("doa_game_is_over");
    level flag::clear("doa_game_is_completed");
    level flag::clear("doa_game_silverback_round");
    level clientfield::set("roundMenu", 0);
    level clientfield::set("teleportMenu", 0);
    level clientfield::set("numexits", 0);
    level clientfield::set("gameover", 0);
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x1 linked
// Checksum 0x25f17176, Offset: 0x3588
// Size: 0x8ec
function function_555fb805() {
    assert(!isdefined(level.doa));
    if (!isdefined(level.doa)) {
        level.doa = spawnstruct();
        function_53bcdb30();
    }
    if (!isdefined(level.doa.var_4bc31566)) {
        level.doa.var_4bc31566 = newhudelem();
        level.doa.var_4bc31566.alignx = "center";
        level.doa.var_4bc31566.aligny = "middle";
        level.doa.var_4bc31566.horzalign = "center";
        level.doa.var_4bc31566.vertalign = "middle";
        level.doa.var_4bc31566.y -= -126;
        level.doa.var_4bc31566.foreground = 1;
        level.doa.var_4bc31566.fontscale = 4;
        level.doa.var_4bc31566.color = (1, 0, 0);
        level.doa.var_4bc31566.hidewheninmenu = 1;
        level.doa.var_4bc31566.sort = 1;
        level.doa.var_25c09afd = newhudelem();
        level.doa.var_25c09afd.alignx = "center";
        level.doa.var_25c09afd.aligny = "middle";
        level.doa.var_25c09afd.horzalign = "center";
        level.doa.var_25c09afd.vertalign = "middle";
        level.doa.var_25c09afd.y -= 100;
        level.doa.var_25c09afd.foreground = 1;
        level.doa.var_25c09afd.fontscale = 2.5;
        level.doa.var_25c09afd.color = (1, 0.5, 0);
        level.doa.var_25c09afd.hidewheninmenu = 1;
        level.doa.var_25c09afd.sort = 1;
    }
    level.weaponnone = getweapon("none");
    level.var_5890c17b = 0;
    level.spawnspectator = &function_688245f1;
    level.givecustomloadout = &function_a90bdb51;
    level.callbackplayerkilled = &namespace_831a4a7c::function_3682cfe4;
    level.callbackplayerdamage = &namespace_831a4a7c::function_bfbc53f4;
    level.callbackplayerlaststand = &namespace_831a4a7c::function_f847ee8c;
    level.var_a6179873 = &namespace_831a4a7c::function_f847ee8c;
    level.callbackactordamage = &doa_enemy::function_2241fc21;
    level.callbackactorkilled = &doa_enemy::function_ff217d39;
    level.callbackvehicledamage = &doa_enemy::function_c26b6656;
    level.callbackvehiclekilled = &doa_enemy::function_90772ac6;
    level.var_a753e7a8 = &namespace_aa4730ec::turret_fire;
    level.player_stats_init = &donothing;
    level.doa.var_e6653624 = [];
    level.doa.var_a9ba4ffb = [];
    level.disableclassselection = 1;
    level.var_eafffb33 = 1;
    level.var_a250f238 = 1;
    level.doa.var_ab5c3535 = getweapon("zombietron_launcher_magic_bullet");
    level.doa.var_5706a235 = getweapon("zombietron_launcher_1_magic_bullet");
    level.doa.var_7d091c9e = getweapon("zombietron_launcher_2_magic_bullet");
    level.doa.var_e6a7c945 = getweapon("zombietron_rpg");
    level.doa.rpg = getweapon("zombietron_rpg");
    level.doa.var_d2759018 = getweapon("zombietron_rpg_1");
    level.doa.var_ccb54987 = getweapon("zombietron_rpg_2");
    level.doa.var_c1b50f26 = getweapon("zombietron_ray_gun");
    level.doa.var_1f6dff3d = getweapon("zombietron_lmg_1");
    level.doa.var_b6808b5a = getweapon("zombietron_lmg_2");
    level.doa.var_69899304 = getweapon("zombietron_nightfury");
    level.doa.var_d2759018 = getweapon("zombietron_rpg_1");
    level.doa.var_ccb54987 = getweapon("zombietron_rpg_2");
    level.doa.var_f5fcdb51 = getweapon("zombietron_ray_gun_1");
    level.doa.var_e30c10ec = getweapon("zombietron_ray_gun_2");
    level.doa.var_dce7830f = getweapon("zombietron_shotgun_1");
    level.doa.var_a9c9b20 = getweapon("zombietron_shotgun_2");
    level.doa.var_416914d0 = getweapon("zombietron_deathmachine");
    level.doa.var_eb58a672 = getweapon("zombietron_deathmachine_1");
    level.doa.var_e00fcc77 = getweapon("zombietron_deathmachine_2");
    level.doa.var_362a104d = getweapon(level.doa.rules.default_weapon);
    level.doa.var_4a3223bd = level.doa.var_b6808b5a;
    level.doa.var_d2b5415f = 0;
    level.doa.var_aaefc0f3 = 0;
    createthreatbiasgroup("zombies");
    createthreatbiasgroup("players");
    setthreatbias("players", "zombies", 1500);
    function_c7f824a();
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x1 linked
// Checksum 0x84fb060, Offset: 0x3e80
// Size: 0xa80
function function_53bcdb30() {
    assert(isdefined(level.doa));
    assert(!isdefined(level.doa.rules));
    level.doa.rules = spawnstruct();
    level.doa.rules.var_812a15ac = 1;
    level.doa.rules.var_ec21c11e = 2;
    level.doa.rules.var_1a69346e = 3;
    level.doa.rules.var_fd29bc1 = 9;
    level.doa.rules.var_42117843 = 9;
    level.doa.rules.var_376b21db = 9;
    level.doa.rules.var_385b385d = 9;
    level.doa.rules.default_weapon = "zombietron_lmg";
    level.doa.rules.var_61b88ecb = 200000;
    level.doa.rules.powerup_timeout = 10;
    level.doa.rules.var_f5a9d2d9 = 10;
    level.doa.rules.var_d55e6679 = 512;
    level.doa.rules.var_b92b82b = 1.5;
    level.doa.rules.var_ee067ec = 0.6;
    level.doa.rules.var_ef812b7e = 10;
    level.doa.rules.var_353018d2 = 4;
    level.doa.rules.var_dec839f3 = 4;
    level.doa.rules.var_be9a9995 = -16;
    level.doa.rules.var_ab729583 = 540;
    level.doa.rules.var_a9114441 = 20;
    level.doa.rules.var_378eec79 = 60;
    level.doa.rules.var_575e919f = 60;
    level.doa.rules.var_da7e08a6 = 40;
    level.doa.rules.var_b8f1a3ce = 10;
    level.doa.rules.var_ecfc4359 = 14;
    level.doa.rules.var_942b8706 = -12;
    level.doa.rules.var_187f2874 = 256;
    level.doa.rules.var_92fcc00c = level.doa.rules.var_187f2874 * level.doa.rules.var_187f2874;
    level.doa.var_b351e5fb = 0;
    level.doa.rules.max_enemy_count = 40;
    level.doa.rules.var_f53cdb6e = 20;
    level.doa.rules.var_6a4387bb = -96 * -96;
    level.doa.rules.var_109b458d = 120;
    level.doa.rules.var_213b65db = 10;
    level.doa.rules.var_83dda8f2 = 8;
    level.doa.rules.var_4f139db6 = 20;
    level.doa.rules.var_fb13151a = 30;
    level.doa.rules.var_7daebb69 = 30;
    level.doa.rules.var_2a59d58f = 30;
    level.doa.rules.var_3c441789 = 60;
    level.doa.rules.var_cd899ae7 = 20;
    level.doa.rules.var_91e6add5 = 40;
    level.doa.rules.var_13276655 = 30;
    level.doa.rules.var_7196fe3d = 40;
    level.doa.rules.var_c05a9a3f = 8;
    level.doa.rules.var_8b15034d = 30;
    level.doa.rules.var_5e3c9766 = 25000;
    level.doa.rules.var_a29b8bda = 30;
    level.doa.rules.var_eb81beeb = 202500;
    level.doa.rules.var_ae8d90d5 = 18;
    level.doa.rules.var_996ee93b = 18;
    level.doa.rules.var_b100d33 = 100;
    level.doa.rules.var_836e7aed = 30;
    level.doa.rules.var_9ff6711d = 26;
    level.doa.rules.parentpiece59 = 36;
    level.doa.rules.var_f5691d9b = 10;
    level.doa.rules.var_65fbf7bd = 300;
    level.doa.rules.var_a36002d3 = 120;
    level.doa.rules.var_2a16e124 = 50;
    level.doa.rules.var_5a47287b = 10;
    level.doa.rules.var_f2d5f54d = 1.4;
    level.doa.rules.var_b3d39edc = 1.8;
    level.doa.rules.var_ef3d9a29 = 3;
    level.doa.rules.var_57cac10a = 30;
    level.doa.rules.var_88c0b67b = 4;
    level.doa.rules.var_6fa02512 = 1000;
    level.doa.rules.var_e626be31 = 20;
    level.doa.rules.ignore_enemy_timer = 0.4;
    level.doa.rules.var_c7b07ba9 = 100;
    level.doa.rules.var_c53b19d1 = 0.1;
    level.doa.rules.var_1faeb8d5 = 10;
    level.doa.rules.var_466591b1 = 2000;
    level.doa.rules.var_72d934b2 = 10000;
    level.doa.rules.var_cd6c242e = 4;
    level.doa.rules.var_ca8dc008 = 25;
    level.doa.rules.var_8c016b75 = 9;
    level.doa.rules.var_4a5eec4 = 1;
    level.doa.rules.var_d82df3d5 = 500;
    level.doa.rules.var_6e5d36ba = 300;
    level.doa.rules.var_3210f224 = 2;
    level.doa.var_f953d785 = [];
    level.doa.zombie_move_speed = level.doa.rules.var_e626be31;
    level.doa.zombie_health = level.doa.rules.var_6fa02512;
    level.doa.var_5bd7f25a = level.doa.rules.var_72d934b2;
    level.doa.var_c9e1c854 = 2;
    level.doa.var_792b9741 = -106;
    level.doa.var_4481ad9 = 0;
    level.doa.var_4714c375 = 100;
    level.var_4d1566d9 = 70;
    if (isdefined(level.var_4be54644)) {
        [[ level.var_4be54644 ]]();
    }
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x1 linked
// Checksum 0x3c5e812c, Offset: 0x4908
// Size: 0x30
function function_53b7b84f() {
    waittillframeend();
    game["menu_start_menu"] = "DOA_INGAME_PAUSE";
    game["menu_class"] = "DOA_INGAME_PAUSE";
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x1 linked
// Checksum 0x8a51c744, Offset: 0x4940
// Size: 0x1ec
function function_3e351f83(firsttime) {
    util::wait_network_frame();
    level clientfield::set("gameplay_started", 1);
    level namespace_917e49b3::function_d4766377();
    level flag::set("doa_game_is_running");
    level thread function_dc4ffe5c();
    namespace_49107f3a::function_f798b582();
    function_c7f824a();
    namespace_3ca3c537::init();
    namespace_a7e6beb5::init();
    namespace_3ca3c537::function_5af67667(level.doa.var_90873830);
    namespace_831a4a7c::function_4db260cb();
    namespace_cdb9a8fe::function_55762a85();
    namespace_d88e3a06::function_7a8a936b();
    namespace_3ca3c537::function_1c812a03();
    level clientfield::set("activateBanner", 0);
    level clientfield::increment("restart_doa");
    level thread namespace_49107f3a::function_390adefe();
    level namespace_49107f3a::function_d0e32ad0(0);
    level clientfield::set("set_scoreHidden", 0);
    level thread namespace_cdb9a8fe::main();
    level thread function_64a5cd5e();
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x1 linked
// Checksum 0xa2dadac8, Offset: 0x4b38
// Size: 0x178
function function_dc4ffe5c() {
    wait(1);
    self notify(#"hash_dc4ffe5c");
    self endon(#"hash_dc4ffe5c");
    for (var_97e9dd7 = 0; true; var_97e9dd7 = curcount) {
        wait(0.05);
        if (!level flag::get("doa_game_is_running")) {
            continue;
        }
        players = namespace_831a4a7c::function_5eb6e4d1();
        curcount = players.size;
        if (curcount != var_97e9dd7) {
            /#
                namespace_49107f3a::debugmsg("load_main_complete" + curcount);
            #/
        }
        foreach (player in players) {
            player thread namespace_64c6b720::function_676edeb7();
            player thread namespace_831a4a7c::updateweapon();
        }
    }
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x1 linked
// Checksum 0x85861a46, Offset: 0x4cb8
// Size: 0x5e4
function function_64a5cd5e() {
    level flag::wait_till("doa_game_is_over");
    level flag::clear("doa_round_active");
    level flag::clear("doa_round_abort");
    level notify(#"hash_3b432f18");
    level notify(#"hash_d1f5acf7");
    level flag::clear("doa_game_is_running");
    level notify(#"hash_ba37290e", "gameover");
    level clientfield::set("gameplay_started", 0);
    namespace_49107f3a::function_44eb090b();
    if (isdefined(level.doa.teleporter)) {
        if (isdefined(level.doa.teleporter.trigger)) {
            level.doa.teleporter.trigger delete();
        }
        level.doa.teleporter delete();
    }
    foreach (player in getplayers()) {
        self.doa.respawning = 0;
        self.var_9ea856f6 = 0;
    }
    level notify(#"hash_b96c96ac");
    level notify(#"hash_97276c43");
    wait(1);
    namespace_a7e6beb5::function_c1869ec8();
    namespace_49107f3a::clearallcorpses();
    namespace_d88e3a06::function_116bb43();
    namespace_49107f3a::function_1ced251e(1);
    foreach (player in getplayers()) {
        player.doa.var_af875fb7 = [];
        player namespace_831a4a7c::function_7f33210a();
    }
    level clientfield::set("set_scoreHidden", 1);
    level clientfield::set("activateBanner", 0);
    namespace_917e49b3::function_e2d6beb9();
    level thread namespace_49107f3a::function_390adefe(0);
    level namespace_49107f3a::function_d0e32ad0(0);
    level thread namespace_49107f3a::function_c5f3ece8(%DOA_GAMEOVER, undefined, 6);
    level clientfield::set("scoreMenu", 1);
    level clientfield::set("gameover", 1);
    foreach (player in getplayers()) {
        if (!(isdefined(player.doa.var_80ffe475) && player.doa.var_80ffe475)) {
            player function_9ac615ee(1);
            continue;
        }
        /#
            namespace_49107f3a::debugmsg("load_main_complete" + (isdefined(self.name) ? self.name : "load_main_complete"));
        #/
    }
    wait(4);
    upload_leaderboards();
    wait(2);
    namespace_49107f3a::function_44eb090b();
    level clientfield::set("set_scoreHidden", 0);
    level clientfield::set("scoreMenu", 0);
    level notify(#"hash_b96c96ac");
    level notify(#"hash_97276c43");
    namespace_a7e6beb5::function_c1869ec8();
    namespace_49107f3a::clearallcorpses();
    namespace_d88e3a06::function_116bb43();
    wait(1);
    level notify(#"doa_game_is_over");
    level notify(#"hash_24d3a44");
    util::wait_network_frame();
    missionrestart();
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x1 linked
// Checksum 0x63490a9c, Offset: 0x52a8
// Size: 0xfa
function upload_leaderboards() {
    players = getplayers();
    foreach (player in players) {
        if (!isdefined(player.doa)) {
            continue;
        }
        if (isdefined(player.doa.var_80ffe475) && player.doa.var_80ffe475) {
            continue;
        }
        player uploadleaderboards();
    }
}

// Namespace namespace_693feb87
// Params 2, eflags: 0x1 linked
// Checksum 0x223ae341, Offset: 0x53b0
// Size: 0x694
function function_9ac615ee(gameover, round) {
    if (!isdefined(round)) {
        round = level.doa.round_number;
    }
    if (sessionmodeisonlinegame()) {
        self setdstat("deadOpsArcade", "skullsEarnedRound", self.doa.var_fda5a6e5);
        self setdstat("deadOpsArcade", "gemsEarnedRound", self.doa.var_6946711f);
        self setdstat("deadOpsArcade", "silverbackKillsRound", self.doa.var_52e89a72);
        /#
            namespace_49107f3a::debugmsg("load_main_complete" + self getdstat("load_main_complete", "load_main_complete"));
            namespace_49107f3a::debugmsg("load_main_complete" + self getdstat("load_main_complete", "load_main_complete"));
            namespace_49107f3a::debugmsg("load_main_complete" + self getdstat("load_main_complete", "load_main_complete"));
        #/
        self.doa.var_fda5a6e5 = 0;
        self.doa.var_6946711f = 0;
        self.doa.var_52e89a72 = 0;
        self setdstat("deadOpsArcade", "numPlayers", math::clamp(level.doa.var_e6653624.size, 1, 4));
        self setdstat("deadOpsArcade", "silverbackKills", self.doa.var_53bd6cfa);
        self setdstat("deadOpsArcade", "gemsEarned", self.doa.gems);
        self setdstat("deadOpsArcade", "skullsEarned", self.doa.skulls);
        self setdstat("deadOpsArcade", "scoreAchieved", self namespace_64c6b720::getplayerscore());
        self setdstat("deadOpsArcade", "roundAchieved", round);
        /#
            namespace_49107f3a::debugmsg("load_main_complete" + self getdstat("load_main_complete", "load_main_complete"));
            namespace_49107f3a::debugmsg("load_main_complete" + self getdstat("load_main_complete", "load_main_complete"));
            namespace_49107f3a::debugmsg("load_main_complete" + self getdstat("load_main_complete", "load_main_complete"));
        #/
        if (isdefined(gameover) && gameover) {
            var_be452d64 = self getdstat("deadOpsArcade", "totalGamesPlayed");
            self setdstat("deadOpsArcade", "totalGamesPlayed", var_be452d64 + 1);
            kills = self getdstat("deadOpsArcade", "enemyKills");
            self setdstat("deadOpsArcade", "enemyKills", self.doa.kills + kills);
            wins = self getdstat("deadOpsArcade", "redinsWins");
            self setdstat("deadOpsArcade", "redinsWins", self.doa.var_74c73153 + wins);
            chickens = self getdstat("deadOpsArcade", "chickensTamed");
            self setdstat("deadOpsArcade", "chickensTamed", self.doa.var_d92a8d3e + chickens);
            var_b5d121c9 = self getdstat("deadOpsArcade", "cowsExploded");
            self setdstat("deadOpsArcade", "cowsExploded", self.doa.var_ec573900 + var_b5d121c9);
            var_b5d121c9 = self getdstat("deadOpsArcade", "goldenCowsExploded");
            self setdstat("deadOpsArcade", "goldenCowsExploded", self.doa.var_130471f + var_b5d121c9);
        }
    }
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x1 linked
// Checksum 0x706ca742, Offset: 0x5a50
// Size: 0x164
function function_780f83fd(round) {
    if (!sessionmodeisonlinegame()) {
        return;
    }
    if (!isdefined(self) || !isplayer(self) || !isdefined(self.doa)) {
        return;
    }
    if (isdefined(self.doa.var_80ffe475) && self.doa.var_80ffe475) {
        return;
    }
    /#
        namespace_49107f3a::debugmsg("load_main_complete" + (isdefined(self.name) ? self.name : "load_main_complete") + "load_main_complete" + round + "load_main_complete" + self namespace_64c6b720::getplayerscore());
    #/
    self function_9ac615ee(0, round);
    wait(4);
    if (isdefined(self)) {
        /#
            namespace_49107f3a::debugmsg("load_main_complete");
        #/
        self uploadleaderboards();
        self.doa.var_a483af0a = gettime();
        self.doa.var_b55a8647 = round;
    }
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x1 linked
// Checksum 0xc4e1cef, Offset: 0x5bc0
// Size: 0x17c
function function_688245f1() {
    resettimeout();
    /#
        namespace_49107f3a::debugmsg("load_main_complete" + (isdefined(self.name) ? self.name : "load_main_complete"));
    #/
    self stopshellshock();
    self stoprumble("damage_heavy");
    self.sessionstate = "spectator";
    self.spectatorclient = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.friendlydamage = undefined;
    self.statusicon = "";
    self namespace_831a4a7c::function_60123d1c();
    spawnpoint = namespace_831a4a7c::function_68ece679();
    self spawn(self.origin, self.angles);
    self thread namespace_cdb9a8fe::function_fe0946ac();
    self ghost();
    self thread function_d2450010();
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x1 linked
// Checksum 0x12ea1d2, Offset: 0x5d48
// Size: 0xdc
function function_d2450010() {
    self endon(#"disconnect");
    self waittill(#"loadout_given");
    /#
        namespace_49107f3a::debugmsg("load_main_complete" + (isdefined(self.name) ? self.name : "load_main_complete"));
    #/
    weapon = getweapon("zombietron_lmg");
    self takeallweapons();
    self giveweapon(weapon);
    self switchtoweaponimmediate(weapon);
    self seteverhadweaponall(1);
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x1 linked
// Checksum 0x24f44ec4, Offset: 0x5e30
// Size: 0xb0
function function_a90bdb51() {
    /#
        namespace_49107f3a::debugmsg("load_main_complete" + (isdefined(self.name) ? self.name : "load_main_complete"));
    #/
    weapon = getweapon("zombietron_lmg");
    self takeallweapons();
    self giveweapon(weapon);
    self switchtoweaponimmediate(weapon);
    return weapon;
}

