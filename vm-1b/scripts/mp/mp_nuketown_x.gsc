#using scripts/codescripts/struct;
#using scripts/mp/_destructible;
#using scripts/mp/_load;
#using scripts/mp/_nuketown_mannequin;
#using scripts/mp/_util;
#using scripts/mp/mp_nuketown_x_fx;
#using scripts/mp/mp_nuketown_x_sound;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace mp_nuketown_x;

// Namespace mp_nuketown_x
// Params 0, eflags: 0x2
// Checksum 0x541c276, Offset: 0x4b8
// Size: 0xa
function autoexec init() {
    level.var_248798c8 = 1;
}

// Namespace mp_nuketown_x
// Params 0, eflags: 0x0
// Checksum 0x347705aa, Offset: 0x4d0
// Size: 0x21a
function main() {
    clientfield::register("scriptmover", "nuketown_population_ones", 1, 4, "int");
    clientfield::register("scriptmover", "nuketown_population_tens", 1, 4, "int");
    clientfield::register("world", "nuketown_endgame", 1, 1, "int");
    precache();
    mp_nuketown_x_fx::main();
    mp_nuketown_x_sound::main();
    level.remotemissile_kill_z = -175 + 50;
    level.var_88bf1cef = 1;
    load::main();
    compass::setupminimap("compass_map_mp_nuketown_x");
    setdvar("compassmaxrange", "2100");
    level.end_game_video = spawnstruct();
    level.end_game_video.name = "mp_nuketown_fs_endingmovie";
    level.end_game_video.duration = 5;
    level.var_a2e7d6a9 = 0;
    level.destructible_callbacks["headless"] = &function_8603eab3;
    level.destructible_callbacks["right_arm_lower"] = &function_2b3d2035;
    level.destructible_callbacks["right_arm_upper"] = &function_33cfa2;
    level.destructible_callbacks["left_arm_lower"] = &function_576ab778;
    level.destructible_callbacks["left_arm_upper"] = &function_952db647;
    level thread function_8ad13f8c();
    level thread function_8d1f7bc9();
    /#
        level function_c2bbb7df();
    #/
}

// Namespace mp_nuketown_x
// Params 0, eflags: 0x0
// Checksum 0xd555e40a, Offset: 0x6f8
// Size: 0x255
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
        wait 0.05;
    }
}

// Namespace mp_nuketown_x
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x958
// Size: 0x2
function precache() {
    
}

/#

    // Namespace mp_nuketown_x
    // Params 0, eflags: 0x0
    // Checksum 0xffba1a6, Offset: 0x968
    // Size: 0x92
    function function_c2bbb7df() {
        mapname = getdvarstring("<dev string:x28>");
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x3e>");
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x96>");
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:xee>");
        level thread function_eaf0b837();
    }

#/

// Namespace mp_nuketown_x
// Params 0, eflags: 0x0
// Checksum 0x2e4aa6e8, Offset: 0xa08
// Size: 0x55
function function_cadef408() {
    while (true) {
        level waittill(#"hash_cadef408");
        if (isdefined(level.end_game_video)) {
            level lui::function_be38d8cd(level.end_game_video.name, "fullscreen", level.end_game_video.duration, 1);
        }
    }
}

// Namespace mp_nuketown_x
// Params 0, eflags: 0x0
// Checksum 0x632ffee7, Offset: 0xa68
// Size: 0x32
function function_eaf0b837() {
    level thread function_9071119b();
    level thread function_38b51a9e();
    level thread function_cadef408();
}

// Namespace mp_nuketown_x
// Params 0, eflags: 0x0
// Checksum 0x6094c28a, Offset: 0xaa8
// Size: 0x275
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
        wait 2;
        exploder::exploder("nuketown_derez_explosion");
        level thread run_scene("p7_fxanim_mp_nukex_derez_bridge_bundle");
        level thread run_scene("p7_fxanim_mp_nukex_end_derezzing_tree_bundle");
    }
}

// Namespace mp_nuketown_x
// Params 0, eflags: 0x0
// Checksum 0xe3d761d6, Offset: 0xd28
// Size: 0xf5
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

// Namespace mp_nuketown_x
// Params 1, eflags: 0x0
// Checksum 0xb34c847d, Offset: 0xe28
// Size: 0x16b
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

// Namespace mp_nuketown_x
// Params 1, eflags: 0x0
// Checksum 0xe66f74fc, Offset: 0xfa0
// Size: 0x102
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

// Namespace mp_nuketown_x
// Params 0, eflags: 0x0
// Checksum 0x4bab4721, Offset: 0x10b0
// Size: 0x192
function function_8ad13f8c() {
    var_71a3dea6 = 28;
    level.var_ebaa0197 = 0;
    destructibles = getentarray("destructible", "targetname");
    mannequins = function_6b1120e8(destructibles);
    if (mannequins.size <= 0) {
        return;
    }
    var_9e410dc1 = mannequins.size - var_71a3dea6;
    var_9e410dc1 = math::clamp(var_9e410dc1, 0, var_9e410dc1);
    mannequins = array::randomize(mannequins);
    for (i = 0; i < var_9e410dc1; i++) {
        assert(isdefined(mannequins[i].target));
        collision = getent(mannequins[i].target, "targetname");
        assert(isdefined(collision));
        collision delete();
        mannequins[i] delete();
        level.var_ebaa0197--;
    }
    level waittill(#"prematch_over");
    level.mannequin_time = gettime();
    function_5fdaba50();
    if (getdvarint("nuketown_mannequin", 0)) {
        level thread function_3c0e90cb(0);
    }
}

// Namespace mp_nuketown_x
// Params 0, eflags: 0x0
// Checksum 0xbf4b553a, Offset: 0x1250
// Size: 0x1aa
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
        setdvar("<dev string:x13a>", 0);
        setdvar("<dev string:x150>", 0);
        mapname = getdvarstring("<dev string:x28>");
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x168>");
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x1b1>");
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x1fa>");
        level thread function_d77bb766();
        level thread function_f7eb5db3();
    #/
}

// Namespace mp_nuketown_x
// Params 0, eflags: 0x4
// Checksum 0x8e68c189, Offset: 0x1408
// Size: 0xd3
function private function_66d1dfaa() {
    destructibles = getentarray("destructible", "targetname");
    mannequins = function_6b1120e8(destructibles);
    foreach (mannequin in mannequins) {
        collision = getent(mannequin.target, "targetname");
        collision delete();
        mannequin delete();
    }
}

// Namespace mp_nuketown_x
// Params 0, eflags: 0x4
// Checksum 0x767f768b, Offset: 0x14e8
// Size: 0x83
function private function_6ac7b21() {
    mannequins = getaiarchetypearray("mannequin");
    foreach (mannequin in mannequins) {
        mannequin kill();
    }
}

// Namespace mp_nuketown_x
// Params 1, eflags: 0x4
// Checksum 0xb1ed2d4f, Offset: 0x1578
// Size: 0xe2
function private function_e20b8430(var_5f10cc59) {
    if (isdefined(level.var_fd975a01)) {
        function_66d1dfaa();
        for (index = 0; index < level.var_fd975a01.size; index++) {
            origin = level.var_fd975a01[index];
            angles = level.var_b8fc7cc7[index];
            gender = randomint(2) ? "male" : "female";
            mannequin = namespace_723e3352::function_f3d9376a(origin, angles, gender, undefined, var_5f10cc59);
            wait 0.05;
        }
    }
    if (var_5f10cc59) {
        level thread namespace_723e3352::function_deaff58c();
    }
}

// Namespace mp_nuketown_x
// Params 1, eflags: 0x4
// Checksum 0xb7dfbb2c, Offset: 0x1668
// Size: 0x105
function private function_3c0e90cb(var_5f10cc59) {
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
        wait 0.1;
    }
}

/#

    // Namespace mp_nuketown_x
    // Params 0, eflags: 0x4
    // Checksum 0x5840a802, Offset: 0x1778
    // Size: 0x65
    function private function_d77bb766() {
        while (true) {
            if (getdvarstring("<dev string:x150>") == "<dev string:x243>") {
                function_6ac7b21();
                level notify(#"hash_4608fd9a");
                setdvar("<dev string:x150>", 0);
            }
            wait 0.05;
        }
    }

    // Namespace mp_nuketown_x
    // Params 0, eflags: 0x4
    // Checksum 0x204d8f3, Offset: 0x17e8
    // Size: 0xc5
    function private function_f7eb5db3() {
        while (true) {
            if (getdvarstring("<dev string:x13a>") == "<dev string:x243>") {
                function_6ac7b21();
                function_e20b8430(0);
                setdvar("<dev string:x13a>", 0);
            } else if (getdvarstring("<dev string:x13a>") == "<dev string:x245>") {
                function_6ac7b21();
                function_e20b8430(1);
                setdvar("<dev string:x13a>", 0);
            }
            wait 0.05;
        }
    }

#/

// Namespace mp_nuketown_x
// Params 1, eflags: 0x0
// Checksum 0x4431775a, Offset: 0x18b8
// Size: 0x77
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

// Namespace mp_nuketown_x
// Params 3, eflags: 0x0
// Checksum 0x54e99220, Offset: 0x1938
// Size: 0x7a
function function_8603eab3(notifytype, attacker, weapon) {
    if (gettime() < level.mannequin_time + getdvarint("mannequin_timelimit", 120) * 1000) {
        level.var_a2e7d6a9++;
        if (level.var_a2e7d6a9 == getdvarint("mannequin_headless_count", 28)) {
            level thread function_58872b81();
        }
    }
}

// Namespace mp_nuketown_x
// Params 0, eflags: 0x0
// Checksum 0xdf545e6d, Offset: 0x19c0
// Size: 0x49
function function_2f2fa868() {
    if (!getdvarint("nuketown_mannequin", 1)) {
        return false;
    }
    if (sessionmodeisonlinegame() && !sessionmodeisprivateonlinegame()) {
        return false;
    }
    return true;
}

// Namespace mp_nuketown_x
// Params 0, eflags: 0x0
// Checksum 0x2620e41a, Offset: 0x1a18
// Size: 0x2a
function function_58872b81() {
    wait 1;
    if (!function_2f2fa868()) {
        return;
    }
    level thread function_3c0e90cb(0);
}

// Namespace mp_nuketown_x
// Params 3, eflags: 0x0
// Checksum 0x93bb6b36, Offset: 0x1a50
// Size: 0x1a
function function_576ab778(notifytype, attacker, weapon) {
    
}

// Namespace mp_nuketown_x
// Params 3, eflags: 0x0
// Checksum 0xbad6895f, Offset: 0x1a78
// Size: 0x32
function function_952db647(notifytype, attacker, weapon) {
    function_240b22bd(notifytype, attacker, weapon);
}

// Namespace mp_nuketown_x
// Params 3, eflags: 0x0
// Checksum 0xef3d5a18, Offset: 0x1ab8
// Size: 0x1a
function function_2b3d2035(notifytype, attacker, weapon) {
    
}

// Namespace mp_nuketown_x
// Params 3, eflags: 0x0
// Checksum 0x8d93f948, Offset: 0x1ae0
// Size: 0x32
function function_33cfa2(notifytype, attacker, weapon) {
    function_240b22bd(notifytype, attacker, weapon);
}

// Namespace mp_nuketown_x
// Params 3, eflags: 0x0
// Checksum 0x3b7b9690, Offset: 0x1b20
// Size: 0x7a
function function_240b22bd(notifytype, attacker, weapon) {
    if (gettime() < level.mannequin_time + getdvarint("mannequin_timelimit", 120) * 1000) {
        level.var_a2e7d6a9++;
        if (level.var_a2e7d6a9 == getdvarint("mannequin_limbless_count", 56)) {
            level thread function_21402507();
        }
    }
}

// Namespace mp_nuketown_x
// Params 0, eflags: 0x0
// Checksum 0x7c0b38bf, Offset: 0x1ba8
// Size: 0x2a
function function_21402507() {
    wait 1;
    if (!function_2f2fa868()) {
        return;
    }
    level thread function_3c0e90cb(1);
}

