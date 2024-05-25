#using scripts/mp/mp_nuketown_x_sound;
#using scripts/mp/mp_nuketown_x_fx;
#using scripts/mp/_nuketown_mannequin;
#using scripts/mp/_destructible;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/lui_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/compass;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_e592ae9f;

// Namespace namespace_e592ae9f
// Params 0, eflags: 0x2
// Checksum 0x828b12da, Offset: 0x518
// Size: 0x10
function autoexec init() {
    level.var_248798c8 = 1;
}

// Namespace namespace_e592ae9f
// Params 0, eflags: 0x1 linked
// Checksum 0x638f48b7, Offset: 0x530
// Size: 0x44c
function main() {
    clientfield::register("scriptmover", "nuketown_population_ones", 1, 4, "int");
    clientfield::register("scriptmover", "nuketown_population_tens", 1, 4, "int");
    clientfield::register("world", "nuketown_endgame", 1, 1, "int");
    precache();
    namespace_6044bb60::main();
    namespace_4cda09f7::main();
    level.remotemissile_kill_z = -175 + 50;
    level.var_88bf1cef = 1;
    level.update_escort_robot_path = &update_escort_robot_path;
    load::main();
    compass::setupminimap("compass_map_mp_nuketown_x");
    setdvar("compassmaxrange", "2100");
    level.levelescortdisable = [];
    level.levelescortdisable[level.levelescortdisable.size] = spawn("trigger_radius", (749, 872, -112.5), 0, -106, -128);
    level.levelescortdisable[level.levelescortdisable.size] = spawn("trigger_radius", (868, 909.5, -112.5), 0, -106, -128);
    level.levelescortdisable[level.levelescortdisable.size] = spawn("trigger_radius", (968, 894.5, -112.5), 0, 100, -128);
    level.levelescortdisable[level.levelescortdisable.size] = spawn("trigger_radius", (1009, 902, -112.5), 0, 100, -128);
    level.end_game_video = spawnstruct();
    level.end_game_video.name = "mp_nuketown_fs_endingmovie";
    level.end_game_video.duration = 5;
    level.var_a2e7d6a9 = 0;
    level.var_ce9a2d1f = 0;
    level.destructible_callbacks["headless"] = &function_8603eab3;
    level.destructible_callbacks["right_arm_lower"] = &function_2b3d2035;
    level.destructible_callbacks["right_arm_upper"] = &function_33cfa2;
    level.destructible_callbacks["left_arm_lower"] = &function_576ab778;
    level.destructible_callbacks["left_arm_upper"] = &function_952db647;
    level thread function_33a60aeb();
    level.cleandepositpoints = array((21.4622, 133.075, -65.875), (976.601, 630.604, -56.875), (-787.35, 508.411, -59.875), (32.424, 952.018, -60.875));
    level thread function_8ad13f8c();
    level thread function_8d1f7bc9();
    /#
        level function_c2bbb7df();
    #/
}

// Namespace namespace_e592ae9f
// Params 0, eflags: 0x1 linked
// Checksum 0xd7221cd4, Offset: 0x988
// Size: 0x300
function function_8d1f7bc9() {
    var_3976bfdf = getentarray("counter_tens", "targetname");
    var_cdcdc7c6 = getentarray("counter_ones", "targetname");
    var_f91396f2 = var_3976bfdf[0];
    var_1ab267f1 = var_cdcdc7c6[0];
    level.var_3e9c9ee4 = 0;
    level.var_49ae1c91 = 0;
    while (true) {
        players = getplayers();
        actors = getactorarray();
        count = 0;
        foreach (player in players) {
            if (isalive(player)) {
                count++;
            }
        }
        foreach (actor in actors) {
            if (isalive(actor)) {
                count++;
            }
        }
        level.var_f8f449e5 = int(floor(count / 10));
        level.var_310f9038 = count % 10;
        if (level.var_3e9c9ee4 != level.var_f8f449e5) {
            var_f91396f2 clientfield::set("nuketown_population_tens", level.var_f8f449e5);
        }
        if (level.var_49ae1c91 != level.var_310f9038) {
            var_1ab267f1 clientfield::set("nuketown_population_ones", level.var_310f9038);
        }
        level.var_3e9c9ee4 = level.var_f8f449e5;
        level.var_49ae1c91 = level.var_310f9038;
        wait(0.05);
    }
}

// Namespace namespace_e592ae9f
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xc90
// Size: 0x4
function precache() {
    
}

/#

    // Namespace namespace_e592ae9f
    // Params 0, eflags: 0x1 linked
    // Checksum 0x5db28354, Offset: 0xca0
    // Size: 0xc4
    function function_c2bbb7df() {
        mapname = getdvarstring("compassmaxrange");
        adddebugcommand("compassmaxrange" + mapname + "compassmaxrange");
        adddebugcommand("compassmaxrange" + mapname + "compassmaxrange");
        adddebugcommand("compassmaxrange" + mapname + "compassmaxrange");
        level thread function_eaf0b837();
    }

#/

// Namespace namespace_e592ae9f
// Params 0, eflags: 0x1 linked
// Checksum 0x20a5d6a0, Offset: 0xd70
// Size: 0x68
function function_cadef408() {
    while (true) {
        level waittill(#"hash_cadef408");
        if (isdefined(level.end_game_video)) {
            level lui::function_be38d8cd(level.end_game_video.name, "fullscreen", level.end_game_video.duration, 1);
        }
    }
}

// Namespace namespace_e592ae9f
// Params 0, eflags: 0x1 linked
// Checksum 0x51fadacb, Offset: 0xde0
// Size: 0x4c
function function_eaf0b837() {
    level thread function_9071119b();
    level thread function_38b51a9e();
    level thread function_cadef408();
}

// Namespace namespace_e592ae9f
// Params 0, eflags: 0x1 linked
// Checksum 0x5f70d32a, Offset: 0xe38
// Size: 0x348
function function_9071119b() {
    var_825f4dc3 = struct::get_array("endgame_camera");
    var_a6df4614 = var_825f4dc3[0];
    if (!isdefined(var_a6df4614)) {
        var_a6df4614 = spawnstruct();
        var_a6df4614.origin = (-200, -167, 15);
        var_a6df4614.angles = (0, -81, 0);
    }
    for (;;) {
        camera = spawn("script_model", var_a6df4614.origin);
        camera.angles = var_a6df4614.angles;
        camera setmodel("tag_origin");
        level waittill(#"hash_ba6eb569");
        var_2ef11df4 = getentarray("hide_end_game_sequence", "script_noteworthy");
        foreach (var_4c401d78 in var_2ef11df4) {
            var_4c401d78 hide();
        }
        clientfield::set("nuketown_endgame", 1);
        players = getplayers();
        foreach (player in players) {
            player camerasetposition(camera);
            player camerasetlookat();
            player cameraactivate(1);
            player setdepthoffield(0, -128, 7000, 10000, 6, 1.8);
        }
        wait(2);
        exploder::exploder("nuketown_derez_explosion");
        level thread run_scene("p7_fxanim_mp_nukex_derez_bridge_bundle");
        level thread run_scene("p7_fxanim_mp_nukex_end_derezzing_tree_bundle");
    }
}

// Namespace namespace_e592ae9f
// Params 0, eflags: 0x1 linked
// Checksum 0x9bcc7b12, Offset: 0x1188
// Size: 0x138
function function_38b51a9e() {
    for (;;) {
        level waittill(#"hash_71410924");
        var_2ef11df4 = getentarray("hide_end_game_sequence", "script_noteworthy");
        foreach (var_4c401d78 in var_2ef11df4) {
            var_4c401d78 show();
        }
        clientfield::set("nuketown_endgame", 0);
        exploder::stop_exploder("nuketown_derez_explosion");
        level thread init_scene("p7_fxanim_mp_nukex_derez_bridge_bundle");
        level thread init_scene("p7_fxanim_mp_nukex_end_derezzing_tree_bundle");
    }
}

// Namespace namespace_e592ae9f
// Params 1, eflags: 0x1 linked
// Checksum 0xae0fa503, Offset: 0x12c8
// Size: 0x1fa
function run_scene(str_scene) {
    b_found = 0;
    str_mode = tolower(getdvarstring("scene_menu_mode", "default"));
    a_scenes = struct::get_array(str_scene, "scriptbundlename");
    foreach (s_instance in a_scenes) {
        if (isdefined(s_instance)) {
            if (!isinarray(a_scenes, s_instance)) {
                b_found = 1;
                s_instance thread scene::play(undefined, undefined, undefined, 1, undefined, str_mode);
            }
        }
    }
    if (isdefined(level.active_scenes[str_scene])) {
        foreach (s_instance in level.active_scenes[str_scene]) {
            b_found = 1;
            s_instance thread scene::play(str_scene, undefined, undefined, 1, undefined, str_mode);
        }
    }
}

// Namespace namespace_e592ae9f
// Params 1, eflags: 0x1 linked
// Checksum 0x2bfd2a10, Offset: 0x14d0
// Size: 0x14c
function init_scene(str_scene) {
    str_mode = tolower(getdvarstring("scene_menu_mode", "default"));
    b_found = 0;
    a_scenes = struct::get_array(str_scene, "scriptbundlename");
    foreach (s_instance in a_scenes) {
        if (isdefined(s_instance)) {
            b_found = 1;
            s_instance thread scene::init(undefined, undefined, undefined, 1);
        }
    }
    if (!b_found) {
        level.scene_test_struct thread scene::init(str_scene, undefined, undefined, 1);
    }
}

// Namespace namespace_e592ae9f
// Params 0, eflags: 0x1 linked
// Checksum 0xfbfc302d, Offset: 0x1628
// Size: 0x4dc
function function_8ad13f8c() {
    var_71a3dea6 = 28;
    level.var_ebaa0197 = 0;
    destructibles = getentarray("destructible", "targetname");
    mannequins = function_6b1120e8(destructibles);
    if (mannequins.size <= 0) {
        return;
    }
    arrayremovevalue(mannequins, undefined);
    alreadyremoved = 0;
    for (i = 0; i < mannequins.size; i++) {
        if ("p7_dest_ntx_mannequin_female_04_purple_ddef" == mannequins[i].destructibledef) {
            collision = getent(mannequins[i].target, "targetname");
            assert(isdefined(collision));
            collision delete();
            mannequins[i] delete();
            level.var_ebaa0197--;
            alreadyremoved++;
        }
        if (!isdefined(mannequins[i])) {
            continue;
        }
        assert(isdefined(mannequins[i].target));
        if (level.gametype == "dem" || level.gametype == "dom") {
            if (mannequins[i].target == "pf1160_auto1" || mannequins[i].target == "pf1179_auto1") {
                collision = getent(mannequins[i].target, "targetname");
                assert(isdefined(collision));
                collision delete();
                mannequins[i] delete();
                level.var_ebaa0197--;
                alreadyremoved++;
            }
        }
    }
    level.var_ebaa0197 = mannequins.size;
    var_9e410dc1 = mannequins.size - var_71a3dea6 - alreadyremoved;
    var_9e410dc1 = math::clamp(var_9e410dc1, 0, var_9e410dc1);
    mannequins = array::randomize(mannequins);
    for (i = 0; i < mannequins.size; i++) {
        if (!isdefined(mannequins[i])) {
            continue;
        }
        assert(isdefined(mannequins[i].target));
        if (i < var_9e410dc1) {
            collision = getent(mannequins[i].target, "targetname");
            assert(isdefined(collision));
            collision delete();
            mannequins[i] delete();
            level.var_ebaa0197--;
            continue;
        }
        mannequins[i] disconnectpaths();
    }
    arrayremovevalue(mannequins, undefined);
    level.mannequins = mannequins;
    level waittill(#"prematch_over");
    level.mannequin_time = gettime();
    function_5fdaba50();
    if (getdvarint("nuketown_mannequin", 0)) {
        level thread function_3c0e90cb(0);
    }
}

// Namespace namespace_e592ae9f
// Params 0, eflags: 0x1 linked
// Checksum 0xba8d7741, Offset: 0x1b10
// Size: 0x204
function function_5fdaba50() {
    level.var_fd975a01 = [];
    level.var_b8fc7cc7 = [];
    destructibles = getentarray("destructible", "targetname");
    mannequins = function_6b1120e8(destructibles);
    foreach (mannequin in mannequins) {
        level.var_fd975a01[level.var_fd975a01.size] = mannequin.origin;
        level.var_b8fc7cc7[level.var_b8fc7cc7.size] = mannequin.angles;
    }
    /#
        mapname = getdvarstring("compassmaxrange");
        adddebugcommand("compassmaxrange" + mapname + "compassmaxrange");
        adddebugcommand("compassmaxrange" + mapname + "compassmaxrange");
        adddebugcommand("compassmaxrange" + mapname + "compassmaxrange");
        level thread function_339cd93d();
        level thread function_599f53a6();
        level thread function_d77bb766();
    #/
}

// Namespace namespace_e592ae9f
// Params 0, eflags: 0x5 linked
// Checksum 0x6f744728, Offset: 0x1d20
// Size: 0x132
function private function_66d1dfaa() {
    destructibles = getentarray("destructible", "targetname");
    mannequins = function_6b1120e8(destructibles);
    foreach (mannequin in mannequins) {
        mannequin connectpaths();
        collision = getent(mannequin.target, "targetname");
        collision delete();
        mannequin delete();
    }
}

// Namespace namespace_e592ae9f
// Params 0, eflags: 0x5 linked
// Checksum 0x72dc7c84, Offset: 0x1e60
// Size: 0xba
function private function_6ac7b21() {
    level notify(#"hash_d4fbdcde");
    mannequins = getaiarchetypearray("mannequin");
    foreach (mannequin in mannequins) {
        mannequin kill();
    }
}

// Namespace namespace_e592ae9f
// Params 0, eflags: 0x5 linked
// Checksum 0x712befe3, Offset: 0x1f28
// Size: 0x64
function private function_ad600192() {
    level notify(#"hash_ad600192");
    level endon(#"hash_ad600192");
    while (true) {
        if (!function_4b855423()) {
            function_6ac7b21();
            return;
        }
        wait(0.05);
    }
}

// Namespace namespace_e592ae9f
// Params 1, eflags: 0x5 linked
// Checksum 0xe9952935, Offset: 0x1f98
// Size: 0x13c
function private function_e20b8430(var_5f10cc59) {
    level endon(#"hash_d4fbdcde");
    level thread function_ad600192();
    if (isdefined(level.var_fd975a01)) {
        function_66d1dfaa();
        for (index = 0; index < level.var_fd975a01.size; index++) {
            origin = level.var_fd975a01[index];
            angles = level.var_b8fc7cc7[index];
            gender = randomint(2) ? "male" : "female";
            mannequin = namespace_723e3352::function_f3d9376a(origin, angles, gender, undefined, var_5f10cc59);
            wait(0.05);
        }
    }
    if (var_5f10cc59) {
        level thread namespace_723e3352::function_deaff58c();
    }
}

// Namespace namespace_e592ae9f
// Params 1, eflags: 0x5 linked
// Checksum 0xae1edc59, Offset: 0x20e0
// Size: 0x154
function private function_3c0e90cb(var_5f10cc59) {
    level endon(#"hash_d4fbdcde");
    function_e20b8430(var_5f10cc59);
    while (1 && isdefined(level.var_fd975a01)) {
        mannequins = getaiarchetypearray("mannequin");
        if (mannequins.size < level.var_fd975a01.size) {
            index = randomint(level.var_fd975a01.size);
            origin = level.var_fd975a01[index];
            angles = level.var_b8fc7cc7[index];
            gender = randomint(2) ? "male" : "female";
            mannequin = namespace_723e3352::function_f3d9376a(origin, angles, gender, undefined, var_5f10cc59);
        }
        wait(0.1);
    }
}

/#

    // Namespace namespace_e592ae9f
    // Params 0, eflags: 0x5 linked
    // Checksum 0x79b91b9c, Offset: 0x2240
    // Size: 0x48
    function private function_339cd93d() {
        while (true) {
            level waittill(#"hash_42cf0b29");
            function_6ac7b21();
            function_e20b8430(0);
        }
    }

    // Namespace namespace_e592ae9f
    // Params 0, eflags: 0x5 linked
    // Checksum 0xbf40480e, Offset: 0x2290
    // Size: 0x48
    function private function_599f53a6() {
        while (true) {
            level waittill(#"hash_68d18592");
            function_6ac7b21();
            function_e20b8430(1);
        }
    }

    // Namespace namespace_e592ae9f
    // Params 0, eflags: 0x5 linked
    // Checksum 0xae60b954, Offset: 0x22e0
    // Size: 0x30
    function private function_d77bb766() {
        while (true) {
            level waittill(#"hash_4608fd9a");
            function_6ac7b21();
        }
    }

#/

// Namespace namespace_e592ae9f
// Params 1, eflags: 0x1 linked
// Checksum 0x5ff3c639, Offset: 0x2318
// Size: 0xa6
function function_6b1120e8(destructibles) {
    mannequins = [];
    for (i = 0; i < destructibles.size; i++) {
        destructible = destructibles[i];
        if (issubstr(destructible.destructibledef, "male")) {
            mannequins[mannequins.size] = destructible;
            level.var_ebaa0197++;
        }
    }
    return mannequins;
}

// Namespace namespace_e592ae9f
// Params 3, eflags: 0x1 linked
// Checksum 0xd519cf9c, Offset: 0x23c8
// Size: 0x94
function function_8603eab3(notifytype, attacker, weapon) {
    if (gettime() < level.mannequin_time + getdvarint("mannequin_timelimit", 120) * 1000) {
        level.var_a2e7d6a9++;
        if (level.var_a2e7d6a9 == getdvarint("mannequin_headless_count", 28)) {
            level thread function_58872b81();
        }
    }
}

// Namespace namespace_e592ae9f
// Params 0, eflags: 0x1 linked
// Checksum 0x2dda3b87, Offset: 0x2468
// Size: 0x76
function function_2f2fa868() {
    if (!getdvarint("nuketown_mannequin", 1)) {
        return false;
    }
    if (sessionmodeisonlinegame() && !sessionmodeisprivateonlinegame()) {
        return false;
    }
    if (util::isprophuntgametype()) {
        return false;
    }
    return true;
}

// Namespace namespace_e592ae9f
// Params 0, eflags: 0x1 linked
// Checksum 0xf1a47a34, Offset: 0x24e8
// Size: 0x38
function function_4b855423() {
    players = getplayers();
    if (players.size > 12) {
        return false;
    }
    return true;
}

// Namespace namespace_e592ae9f
// Params 0, eflags: 0x1 linked
// Checksum 0xeb84475, Offset: 0x2528
// Size: 0x34
function function_58872b81() {
    wait(1);
    if (!function_2f2fa868()) {
        return;
    }
    level thread function_3c0e90cb(0);
}

// Namespace namespace_e592ae9f
// Params 3, eflags: 0x1 linked
// Checksum 0xcdbe8ec7, Offset: 0x2568
// Size: 0x1c
function function_576ab778(notifytype, attacker, weapon) {
    
}

// Namespace namespace_e592ae9f
// Params 3, eflags: 0x1 linked
// Checksum 0x5da9dfc, Offset: 0x2590
// Size: 0x3c
function function_952db647(notifytype, attacker, weapon) {
    function_240b22bd(notifytype, attacker, weapon);
}

// Namespace namespace_e592ae9f
// Params 3, eflags: 0x1 linked
// Checksum 0xfcb6cbf7, Offset: 0x25d8
// Size: 0x1c
function function_2b3d2035(notifytype, attacker, weapon) {
    
}

// Namespace namespace_e592ae9f
// Params 3, eflags: 0x1 linked
// Checksum 0x9b3526a3, Offset: 0x2600
// Size: 0x3c
function function_33cfa2(notifytype, attacker, weapon) {
    function_240b22bd(notifytype, attacker, weapon);
}

// Namespace namespace_e592ae9f
// Params 3, eflags: 0x1 linked
// Checksum 0xa5f6bcad, Offset: 0x2648
// Size: 0x94
function function_240b22bd(notifytype, attacker, weapon) {
    if (gettime() < level.mannequin_time + getdvarint("mannequin_timelimit", 120) * 1000) {
        level.var_ce9a2d1f++;
        if (level.var_ce9a2d1f == getdvarint("mannequin_limbless_count", 56)) {
            level thread function_21402507();
        }
    }
}

// Namespace namespace_e592ae9f
// Params 0, eflags: 0x1 linked
// Checksum 0x41a5972c, Offset: 0x26e8
// Size: 0x3c
function function_21402507() {
    wait(1);
    if (!function_2f2fa868()) {
        return;
    }
    level thread function_3c0e90cb(1);
}

// Namespace namespace_e592ae9f
// Params 0, eflags: 0x1 linked
// Checksum 0xe2f5af9d, Offset: 0x2730
// Size: 0x30c
function function_33a60aeb() {
    nodes = getnodesinradius((-765.225, 938.762, 7.377), 30, 0, 10, "End");
    setenablenode(nodes[0], 0);
    nodes = getnodesinradius((-1158.76, 1070.65, 7.377), 30, 0, 10, "End");
    setenablenode(nodes[0], 0);
    nodes = getnodesinradius((-926.372, -224.916, 7.376), 30, 0, 10, "End");
    setenablenode(nodes[0], 0);
    nodes = getnodesinradius((-1319.91, -93.028, 7.376), 30, 0, 10, "End");
    setenablenode(nodes[0], 0);
    nodes = getnodesinradius((918.81, -206.969, 7.376), 30, 0, 10, "End");
    setenablenode(nodes[0], 0);
    nodes = getnodesinradius((1313.93, -79.594, 7.376), 30, 0, 10, "End");
    setenablenode(nodes[0], 0);
    nodes = getnodesinradius((736.484, 925.845, 7.376), 30, 0, 10, "End");
    setenablenode(nodes[0], 0);
    nodes = getnodesinradius((1131.5, 1053.22, 7.376), 30, 0, 10, "End");
    setenablenode(nodes[0], 0);
}

// Namespace namespace_e592ae9f
// Params 1, eflags: 0x1 linked
// Checksum 0x5291c5fc, Offset: 0x2a48
// Size: 0x3c
function update_escort_robot_path(&patharray) {
    arrayinsert(patharray, (929, 626, -56.875), 10);
}

