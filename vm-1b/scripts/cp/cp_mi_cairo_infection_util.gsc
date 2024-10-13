#using scripts/cp/_objectives;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_dialog;
#using scripts/shared/lui_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace infection_util;

// Namespace infection_util
// Params 0, eflags: 0x2
// Checksum 0x6adaa2d6, Offset: 0xd48
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("infection_util", &__init__, undefined, undefined);
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xb8efecd1, Offset: 0xd80
// Size: 0x14a
function __init__() {
    var_63dbb8fc = getent("sarah", "targetname");
    if (isdefined(var_63dbb8fc)) {
        var_63dbb8fc spawner::add_spawn_function(&function_e7ce686c);
    }
    level.lighting_state = 0;
    callback::on_spawned(&on_player_spawned);
    callback::on_disconnect(&on_player_disconnect);
    callback::on_spawned(&function_72e40406);
    callback::on_actor_killed(&function_c3e494e3);
    callback::on_actor_killed(&function_1cbdd501);
    callback::on_ai_spawned(&function_796d4d97);
    init_client_field_callback_funcs();
    init_flags();
    level thread function_5f6e4092();
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xf469263a, Offset: 0xed8
// Size: 0x32
function init_flags() {
    level flag::init("sarah_anchor_prep_scene_done");
    level flag::init("sarah_anchor_post_scene_done");
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x3bb01302, Offset: 0xf18
// Size: 0x232
function init_client_field_callback_funcs() {
    clientfield::register("toplayer", "snow_fx", 1, 2, "int");
    clientfield::register("actor", "sarah_objective_light", 1, 1, "int");
    clientfield::register("actor", "sarah_body_light", 1, 1, "int");
    clientfield::register("actor", "reverse_arrival_snow_fx", 1, 1, "int");
    clientfield::register("actor", "reverse_arrival_dmg_fx", 1, 1, "int");
    clientfield::register("actor", "exploding_ai_deaths", 1, 1, "int");
    clientfield::register("actor", "reverse_arrival_explosion_fx", 1, 1, "int");
    clientfield::register("allplayers", "player_spawn_fx", 1, 1, "int");
    clientfield::register("toplayer", "stop_post_fx", 1, 1, "counter");
    clientfield::register("actor", "ai_dni_rez_in", 1, 1, "int");
    clientfield::register("actor", "ai_dni_rez_out", 1, 1, "counter");
    clientfield::register("toplayer", "postfx_dni_interrupt", 1, 1, "counter");
    clientfield::register("toplayer", "postfx_futz", 1, 1, "counter");
    clientfield::register("actor", "sarah_camo_shader", 1, 3, "int");
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x1158
// Size: 0x2
function on_player_spawned() {
    
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x1168
// Size: 0x2
function on_player_disconnect() {
    
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0xa775df15, Offset: 0x1178
// Size: 0xf4
function function_2c4ff2b1(var_862f45fa) {
    a_structs = struct::get_array("cp_coop_spawn", "targetname");
    assert(a_structs.size, "<dev string:x28>");
    var_2d4a0ac3 = [];
    for (i = 0; i < a_structs.size; i++) {
        if (a_structs[i].script_objective === var_862f45fa) {
            if (!isdefined(var_2d4a0ac3)) {
                var_2d4a0ac3 = [];
            } else if (!isarray(var_2d4a0ac3)) {
                var_2d4a0ac3 = array(var_2d4a0ac3);
            }
            var_2d4a0ac3[var_2d4a0ac3.size] = a_structs[i];
        }
    }
    assert(var_2d4a0ac3.size, "<dev string:x44>" + var_862f45fa);
    return var_2d4a0ac3;
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x4531e236, Offset: 0x1278
// Size: 0xa1
function function_1b6646d6() {
    level flag::wait_till("all_players_connected");
    do {
        wait 0.05;
        var_801b9e15 = 0;
        foreach (player in getplayers()) {
            if (player.sessionstate == "playing") {
                var_801b9e15++;
            }
        }
    } while (var_801b9e15 == 0);
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0x5d9408a7, Offset: 0x1328
// Size: 0x1b3
function function_54142bd3(var_434bda67, str_key) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    assert(isdefined(var_434bda67), "<dev string:x9e>");
    e_volume = getent(var_434bda67, str_key);
    assert(isdefined(e_volume), "<dev string:xd8>" + str_key + "<dev string:x108>" + var_434bda67 + "<dev string:x10e>");
    assert(isdefined(e_volume.target), "<dev string:x11b>" + var_434bda67 + "<dev string:x13a>");
    var_af84f8f = struct::get_array(e_volume.target, "targetname");
    assert(var_af84f8f.size >= 4, "<dev string:x11b>" + var_434bda67 + "<dev string:x171>" + var_af84f8f.size);
    foreach (i, player in level.players) {
        if (!player istouching(e_volume)) {
            player setorigin(var_af84f8f[i].origin);
            player setplayerangles(var_af84f8f[i].angles);
        }
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x8f5cd3ad, Offset: 0x14e8
// Size: 0x4d
function function_e7ce686c() {
    self endon(#"death");
    while (true) {
        self waittill(#"hash_31cb28ed");
        self function_db9a227f(1);
        self waittill(#"hash_f20d0edf");
        self function_db9a227f(0);
    }
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0xccaeee6e, Offset: 0x1540
// Size: 0x32
function function_db9a227f(b_show) {
    if (!isdefined(b_show)) {
        b_show = 1;
    }
    self clientfield::set("sarah_objective_light", b_show);
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xbf4ea99e, Offset: 0x1580
// Size: 0x1a
function function_dafed344() {
    self function_dbe72c95("village");
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xe66a19c5, Offset: 0x15a8
// Size: 0x1a
function function_2f6bf570() {
    self function_dbe72c95("village_inception");
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0x5acc1f09, Offset: 0x15d0
// Size: 0x52
function function_dbe72c95(str_objective) {
    self endon(#"death");
    self.script_objective = str_objective;
    if (isdefined(self.animname)) {
        return;
    }
    self.overrideactordamage = &function_cf59d5a0;
    self function_c54bce75();
}

// Namespace infection_util
// Params 12, eflags: 0x0
// Checksum 0xcaf16855, Offset: 0x1630
// Size: 0xa6
function function_cf59d5a0(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
    if (!isplayer(eattacker)) {
        idamage = int(abs(idamage * 0.75));
    }
    return idamage;
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0x8ab80e89, Offset: 0x16e0
// Size: 0xd6
function function_c54bce75(str_target, str_script_noteworthy) {
    if (!isdefined(str_target)) {
        str_target = undefined;
    }
    if (!isdefined(str_script_noteworthy)) {
        str_script_noteworthy = undefined;
    }
    self endon(#"death");
    while (true) {
        if (!isdefined(self.current_scene)) {
            break;
        }
        wait 0.05;
    }
    if (!isdefined(str_target)) {
        if (isdefined(self.target)) {
            str_target = self.target;
        }
    }
    if (!isdefined(str_script_noteworthy)) {
        if (isdefined(self.script_noteworthy)) {
            str_script_noteworthy = self.script_noteworthy;
        }
    }
    if (isdefined(str_target)) {
        e_target = getnode(str_target, "targetname");
        self setgoal(e_target);
        self waittill(#"goal");
        self.goalradius = 64;
    }
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0x4363876e, Offset: 0x17c0
// Size: 0xba
function function_b86426b1(n_goal_radius) {
    self endon(#"death");
    if (isdefined(self.target)) {
        e_target = getent(self.target, "targetname");
        if (!isdefined(e_target)) {
            e_target = getnode(self.target, "targetname");
        }
        if (isdefined(e_target)) {
            self setgoal(e_target);
        }
        if (isdefined(n_goal_radius)) {
            var_6933f6c4 = self.goalradius;
            self.goalradius = n_goal_radius;
            self waittill(#"goal");
            self.goalradius = var_6933f6c4;
        }
    }
}

// Namespace infection_util
// Params 5, eflags: 0x0
// Checksum 0x320463e5, Offset: 0x1888
// Size: 0x12c
function function_5ec7eb7d(v_position, n_radius, n_height, var_9a868e4d, var_694b7da) {
    if (!isdefined(var_9a868e4d)) {
        var_9a868e4d = 0;
    }
    if (!isdefined(var_694b7da)) {
        var_694b7da = "trigger_radius";
    }
    assert(isdefined(v_position), "<dev string:x1a5>");
    assert(isdefined(n_radius), "<dev string:x1db>");
    assert(isdefined(n_height), "<dev string:x20f>");
    t_use = spawn(var_694b7da, v_position, var_9a868e4d, n_radius, n_height);
    t_use triggerignoreteam();
    t_use setvisibletoall();
    t_use setteamfortrigger("none");
    t_use usetriggerrequirelookat();
    if (var_694b7da == "trigger_radius_use") {
        t_use setcursorhint("HINT_NOICON");
    }
    return t_use;
}

// Namespace infection_util
// Params 5, eflags: 0x0
// Checksum 0xc27f573a, Offset: 0x19c0
// Size: 0x91
function function_7ad4dc15(var_5152e048, var_a72c5e19, n_duration, n_loop_time, n_timeout) {
    if (!isdefined(n_duration)) {
        n_duration = 2;
    }
    if (!isdefined(n_loop_time)) {
        n_loop_time = 0.25;
    }
    if (!isdefined(n_timeout)) {
        n_timeout = 2;
    }
    for (n_time = 0; n_time < n_duration; n_time += n_loop_time) {
        function_7b8c138f(var_5152e048, var_a72c5e19, n_timeout);
        wait n_loop_time;
    }
}

// Namespace infection_util
// Params 3, eflags: 0x0
// Checksum 0x5a79920, Offset: 0x1a60
// Size: 0x83
function function_7b8c138f(var_5152e048, var_a72c5e19, n_timeout) {
    foreach (player in level.players) {
        player thread function_f0b927ee(var_5152e048, var_a72c5e19, n_timeout);
    }
}

// Namespace infection_util
// Params 3, eflags: 0x0
// Checksum 0x8af10744, Offset: 0x1af0
// Size: 0x162
function function_f0b927ee(var_5152e048, var_a72c5e19, n_timeout) {
    if (!isdefined(n_timeout)) {
        n_timeout = 1;
    }
    self endon(#"death");
    n_current_distance = distance(self.origin, var_5152e048.origin);
    self.var_c4423f55 = mapfloat(0, var_a72c5e19, 0.1, 1, n_current_distance);
    self setmovespeedscale(self.var_c4423f55);
    if (!isdefined(self.var_2099a327)) {
        self.var_2099a327 = 0;
    }
    self.var_8046f8b5 = gettime() + (n_timeout - 1) * 1000;
    if (!self.var_2099a327) {
        self.var_2099a327 = 1;
        while (gettime() < self.var_8046f8b5) {
            wait 0.1;
        }
        while (self.var_c4423f55 < 1) {
            self.var_c4423f55 = math::clamp(self.var_c4423f55 + 0.1, 0, 1);
            self setmovespeedscale(self.var_c4423f55);
            wait 0.1;
        }
        self setmovespeedscale(1);
        self.var_2099a327 = 0;
    }
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0xb34a7eef, Offset: 0x1c60
// Size: 0x32
function function_15ca1b68(n_id) {
    assert(isdefined(n_id), "<dev string:x243>");
    level.var_28791de7 = n_id;
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xcaf2c336, Offset: 0x1ca0
// Size: 0x1d
function function_ae5eefe4() {
    if (!isdefined(level.var_28791de7)) {
        level.var_28791de7 = 0;
    }
    return level.var_28791de7;
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0xdc6e38fd, Offset: 0x1cc8
// Size: 0x8b
function function_1cdb9014(n_id) {
    if (!isdefined(n_id)) {
        n_id = 2;
    }
    function_15ca1b68(n_id);
    foreach (player in level.players) {
        player function_72e40406(n_id);
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xfc59b639, Offset: 0x1d60
// Size: 0x73
function function_3ea445de() {
    function_15ca1b68(0);
    foreach (player in level.players) {
        player function_822eb8e8();
    }
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0xae65d077, Offset: 0x1de0
// Size: 0x62
function function_72e40406(n_id) {
    assert(isplayer(self), "<dev string:x269>");
    if (!isdefined(n_id)) {
        n_id = function_ae5eefe4();
    }
    self clientfield::set_to_player("snow_fx", n_id);
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0x2bd37169, Offset: 0x1e50
// Size: 0x6e
function function_822eb8e8(b_pause) {
    if (!isdefined(b_pause)) {
        b_pause = 0;
    }
    assert(isplayer(self), "<dev string:x29a>");
    self clientfield::set_to_player("snow_fx", 0);
    if (!b_pause) {
        self notify(#"hash_a7385d98");
        self.var_afac15ca = 0;
    }
}

// Namespace infection_util
// Params 3, eflags: 0x0
// Checksum 0x547b224f, Offset: 0x1ec8
// Size: 0xc3
function function_8bf0b925(str_value, str_key, b_enable) {
    a_nodes = getnodearray(str_value, str_key);
    foreach (node in a_nodes) {
        if (node function_e24ece7b()) {
            if (b_enable) {
                linktraversal(node);
                continue;
            }
            unlinktraversal(node);
        }
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xfcd63fde, Offset: 0x1f98
// Size: 0x12
function function_e24ece7b() {
    return self.type === "Begin";
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xfe1502d, Offset: 0x1fb8
// Size: 0x3d
function function_574d968f() {
    self endon(#"death");
    while (true) {
        player = self waittill(#"trigger");
        self thread function_827b9378(player);
    }
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0x7fa54886, Offset: 0x2000
// Size: 0xca
function function_827b9378(player) {
    player endon(#"death");
    player endon(#"hash_a7385d98");
    if (!isdefined(player.var_afac15ca)) {
        player.var_afac15ca = 0;
    }
    if (!player.var_afac15ca) {
        player.var_afac15ca = 1;
        var_eb8c03f1 = player clientfield::get_to_player("snow_fx");
        player function_822eb8e8(1);
        while (player istouching(self)) {
            wait 0.25;
        }
        player.var_afac15ca = 0;
        player function_72e40406(var_eb8c03f1);
    }
}

/#

    // Namespace infection_util
    // Params 1, eflags: 0x0
    // Checksum 0x901ae499, Offset: 0x20d8
    // Size: 0x22
    function play_dialog(str_line) {
        iprintlnbold(str_line);
    }

#/

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0xae27dff1, Offset: 0x2108
// Size: 0xe3
function function_efa09886(a_ents) {
    if (level.players.size > 1) {
        level thread util::screen_fade_in(1, "white");
        earthquake(0.5, 0.5, level.players[0].origin, 500);
        util::function_93831e79(level.var_31aefea8);
        foreach (player in level.players) {
            player playrumbleonentity("damage_heavy");
        }
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x981a70b8, Offset: 0x21f8
// Size: 0x92
function function_1d387f5d() {
    scene::add_scene_func("cin_inf_00_00_sarah_vign_move_idle", &function_c32dc5f6, "play");
    scene::add_scene_func("cin_inf_06_03_bastogne_aie_reversemg42", &function_3a407187, "init");
    scene::add_scene_func("cin_inf_06_03_bastogne_aie_reversemg42", &function_8f4d515b, "play");
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0xaa1ee12a, Offset: 0x2298
// Size: 0x72
function function_c8d7e76(str_group) {
    var_c917e48d = struct::get_array(str_group, "targetname");
    assert(var_c917e48d.size, "<dev string:x2cb>" + str_group + "<dev string:x312>");
    level thread array::spread_all(var_c917e48d, &function_12a71229);
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xce229d05, Offset: 0x2318
// Size: 0x715
function function_12a71229() {
    if (!isdefined(self.script_minplayers) || self.script_minplayers <= level.players.size) {
        scene::add_scene_func(self.scriptbundlename, &function_4a8094c1, "init");
        scene::add_scene_func(self.scriptbundlename, &function_c215024b, "done");
        scene::init(self.scriptbundlename);
        if (!isdefined(self.radius)) {
            self.radius = 1300;
        }
        if (!isdefined(self.height)) {
            self.height = 512;
        }
        if (!isdefined(self.script_int)) {
            self.script_int = 0;
        }
        v_origin_offset = (0, 0, self.script_int);
        if (isdefined(self.target)) {
            var_8b856a66 = getent(self.target, "targetname");
            if (!isdefined(var_8b856a66)) {
                var_8b856a66 = function_5ec7eb7d(self.origin + v_origin_offset, self.radius, self.height);
            }
        } else {
            var_8b856a66 = function_5ec7eb7d(self.origin + v_origin_offset, self.radius, self.height);
        }
        var_8b856a66.script_noteworthy = "reverse_anim_trigger";
        if (!isdefined(var_8b856a66.var_a40180b5)) {
            var_8b856a66.var_a40180b5 = 0;
        }
        var_8b856a66.var_a40180b5++;
        switch (self.scriptbundlename) {
        case "cin_inf_06_03_bastogne_aie_reversemortar":
            self thread function_2f9ccb03(var_8b856a66, "target", 1, 2.2, 1, 2);
            break;
        case "cin_inf_06_03_bastogne_aie_reversehalftrack":
            self thread function_2f9ccb03(var_8b856a66, "target", 0, 0, 1, 1.5);
            break;
        case "cin_inf_06_03_bastogne_vign_reverseforwardroll":
            self thread function_2f9ccb03(var_8b856a66, "target", 1, 0.7, 1, 2);
            break;
        case "cin_inf_06_03_bastogne_vign_reverseforwardroll02":
            self thread function_2f9ccb03(var_8b856a66, "target", 1, 2.8, 1, 2.5);
            break;
        case "cin_inf_06_03_bastogne_vign_reversebackroll":
            self thread function_2f9ccb03(var_8b856a66, "target", 1, 0.65, 1, 2.5);
            break;
        case "cin_inf_06_03_bastogne_vign_reversebackroll02":
            self thread function_2f9ccb03(var_8b856a66, "target", 1, 2.1, 1, 2);
            break;
        case "cin_inf_06_03_bastogne_vign_reversebackroll03":
            self thread function_2f9ccb03(var_8b856a66, "target", 1, 1.8, 1, 1);
            break;
        case "cin_inf_06_03_bastogne_aie_reverselandmine":
            self thread function_2f9ccb03(var_8b856a66, "target", 1, 1.3, 1, 1.5);
            break;
        case "cin_inf_06_03_bastogne_aie_reversemg42":
            self thread function_2f9ccb03(var_8b856a66, "script_label", 1, 1.95, 1, 2);
            break;
        case "cin_inf_10_02_foy_aie_reversetankshell_soldier01_suppressor":
            self thread function_2f9ccb03(var_8b856a66, "script_label", 1, 3.5, 0, 0);
            break;
        case "cin_inf_06_03_bastogne_vign_reversedance":
            self thread function_2f9ccb03(var_8b856a66, "script_label", 1, 1.9, 1, 2);
            break;
        case "cin_inf_10_02_bastogne_vign_reversemortar2floor_sniper":
            self thread function_2f9ccb03(var_8b856a66, "script_label", 1, 2.8, 0, 0);
            break;
        case "cin_inf_06_03_bastogne_aie_reverse_soldier01hipshot":
            self thread function_23bbf7f6(var_8b856a66, 1.15);
            break;
        case "cin_inf_06_03_bastogne_aie_reverse_soldier01hipshot_suppressor":
            self thread function_23bbf7f6(var_8b856a66, 1.15);
            break;
        case "cin_inf_06_03_bastogne_aie_reverse_soldier02headshot":
            self thread function_23bbf7f6(var_8b856a66, 1.25);
            break;
        case "cin_inf_06_03_bastogne_aie_reverse_soldier02headshot_sniper":
            self thread function_23bbf7f6(var_8b856a66, 1.25);
            break;
        case "cin_inf_06_03_bastogne_aie_reverse_soldier02headshot_suppressor":
            self thread function_23bbf7f6(var_8b856a66, 1.25);
            break;
        case "cin_inf_11_02_fold_aie_reverse_1":
            self thread function_23bbf7f6(var_8b856a66, 4.25);
            break;
        case "cin_inf_11_02_fold_aie_reverse_2":
            self thread function_23bbf7f6(var_8b856a66, 4.25);
            break;
        case "cin_inf_11_02_fold_aie_reverse_3":
            self thread function_23bbf7f6(var_8b856a66, 4.25);
            break;
        case "cin_inf_11_03_fold_vign_reverse_sniper":
            self thread function_23bbf7f6(var_8b856a66, 1.55);
            break;
        case "cin_inf_10_02_foy_aie_reverseshot_1_suppressor":
            self thread function_23bbf7f6(var_8b856a66, 5.45);
            break;
        case "cin_inf_10_02_foy_aie_reverseshot_5_sniper":
            self thread function_23bbf7f6(var_8b856a66, 5.45);
            break;
        case "cin_inf_10_02_bastogne_vign_reversefall2floor_suppressor":
            self thread function_23bbf7f6(var_8b856a66, 0.85);
            break;
        case "cin_inf_07_02_worldfallsaway_vign_direwolf_reverse_dth_1":
            self thread function_23bbf7f6(var_8b856a66, 2.45);
            break;
        case "cin_inf_07_02_worldfallsaway_vign_direwolf_reverse_dth_2":
            self thread function_23bbf7f6(var_8b856a66, 1.95);
            break;
        case "cin_inf_07_02_worldfallsaway_vign_direwolf_reverse_dth_3":
            self thread function_23bbf7f6(var_8b856a66, 1.95);
            break;
        case "cin_inf_07_02_worldfallsaway_vign_direwolf_reverse_dth_4":
            self thread function_23bbf7f6(var_8b856a66, 1.95);
            break;
        default:
            var_8b856a66 waittill(#"trigger");
            var_8b856a66.var_a40180b5--;
            if (var_8b856a66.var_a40180b5 == 0) {
                var_8b856a66 delete();
            }
            if (isdefined(self.script_delay)) {
                wait self.script_delay;
            }
            scene::play(self.scriptbundlename);
            break;
        }
    }
}

// Namespace infection_util
// Params 6, eflags: 0x0
// Checksum 0xb9d26213, Offset: 0x2a38
// Size: 0x24a
function function_2f9ccb03(var_8b856a66, var_151e15ca, var_c69a4c6, var_68d91705, var_8593df01, var_a35c8512) {
    if (!isdefined(var_151e15ca)) {
        var_151e15ca = "target";
    }
    if (!isdefined(var_c69a4c6)) {
        var_c69a4c6 = 1;
    }
    if (!isdefined(var_68d91705)) {
        var_68d91705 = 2;
    }
    if (!isdefined(var_8593df01)) {
        var_8593df01 = 1;
    }
    if (!isdefined(var_a35c8512)) {
        var_a35c8512 = 2;
    }
    var_8b856a66 waittill(#"trigger");
    var_8b856a66.var_a40180b5--;
    if (var_8b856a66.var_a40180b5 == 0) {
        var_8b856a66 delete();
    }
    if (isdefined(self.script_delay)) {
        wait self.script_delay;
    }
    if (var_c69a4c6) {
        if (var_151e15ca == "target") {
            if (isdefined(self.target)) {
                s_loc = struct::get(self.target, "targetname");
                playfx(level._effect["reverse_mortar"], s_loc.origin);
                wait var_68d91705;
            }
        } else if (var_151e15ca == "script_label") {
            if (isdefined(self.script_label)) {
                s_loc = struct::get(self.script_label, "targetname");
                playfx(level._effect["reverse_mortar"], s_loc.origin);
                wait var_68d91705;
            }
        }
    }
    if (var_8593df01) {
        if (isdefined(self.scenes)) {
            var_8060ff07 = [[ self.scenes[0] ]]->get_ents();
            foreach (actor in var_8060ff07) {
                if (isactor(actor)) {
                    actor clientfield::set("reverse_arrival_snow_fx", 1);
                }
            }
        }
        wait var_a35c8512;
    }
    scene::play(self.scriptbundlename);
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0xeb5d4b92, Offset: 0x2c90
// Size: 0xf2
function function_23bbf7f6(var_8b856a66, var_ecd15ef7) {
    if (!isdefined(var_ecd15ef7)) {
        var_ecd15ef7 = 2;
    }
    var_8b856a66 waittill(#"trigger");
    var_8b856a66.var_a40180b5--;
    if (var_8b856a66.var_a40180b5 == 0) {
        var_8b856a66 delete();
    }
    if (isdefined(self.script_delay)) {
        wait self.script_delay;
    }
    if (isdefined(self.script_label)) {
        s_loc = struct::get(self.script_label, "targetname");
        var_cf340ccb = s_loc.origin;
    }
    self thread scene::play(self.scriptbundlename);
    wait var_ecd15ef7;
    if (isdefined(var_cf340ccb)) {
        playfx(level._effect["bullet_impact"], var_cf340ccb);
    }
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0xa1df48fb, Offset: 0x2d90
// Size: 0xb3
function function_4a8094c1(a_ents) {
    foreach (ent in a_ents) {
        if (isactor(ent)) {
            if (isdefined(level.var_4aa3708c) && level.var_4aa3708c) {
                ent.script_accuracy = level.var_52b1f753;
            }
            ent function_dc649ed7(1);
            ent thread function_79c868c4(self);
        }
    }
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0x56360862, Offset: 0x2e50
// Size: 0x7b
function function_c215024b(a_ents) {
    foreach (ent in a_ents) {
        if (isactor(ent)) {
            ent function_dc649ed7(0);
        }
    }
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0x8c587008, Offset: 0x2ed8
// Size: 0xdb
function function_2a5e3b2a(a_ents) {
    str_target = undefined;
    str_script_noteworthy = undefined;
    if (isdefined(self.target)) {
        str_target = self.target;
    }
    if (isdefined(self.script_noteworthy)) {
        str_script_noteworthy = self.script_noteworthy;
    }
    foreach (ent in a_ents) {
        if (isactor(ent)) {
            ent function_dc649ed7(0);
            ent thread function_c54bce75(str_target, str_script_noteworthy);
        }
    }
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0x81d73985, Offset: 0x2fc0
// Size: 0x52
function function_dc649ed7(b_set) {
    self ai::set_ignoreall(b_set);
    self ai::set_ignoreme(b_set);
    if (b_set) {
        self disableaimassist();
        return;
    }
    self enableaimassist();
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0x98761c49, Offset: 0x3020
// Size: 0x22
function function_586b8f7b(v_position) {
    return arraysort(level.players, v_position, 1)[0];
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0xe8d404dd, Offset: 0x3050
// Size: 0x9a
function function_79c868c4(s_bundle) {
    if (isdefined(s_bundle.script_string)) {
        radius = 1024;
        if (isdefined(s_bundle.script_float)) {
            radius = s_bundle.script_float;
        }
        var_a4652398 = 0;
        if (isdefined(s_bundle.script_noteworthy) && s_bundle.script_noteworthy == "no_fallback") {
            var_a4652398 = 1;
        }
        self thread function_73dd6d57(s_bundle.script_string, s_bundle.scriptbundlename, radius, var_a4652398);
    }
}

// Namespace infection_util
// Params 4, eflags: 0x0
// Checksum 0xf523dfaf, Offset: 0x30f8
// Size: 0x196
function function_73dd6d57(str_target, var_a14dc535, var_84fffedf, var_a4652398) {
    self endon(#"death");
    wait 1;
    while (true) {
        if (!isdefined(self.current_scene)) {
            break;
        }
        wait 0.05;
    }
    self.goalradius = 64;
    if (isdefined(var_a4652398) && var_a4652398) {
        self.var_a4652398 = 1;
    }
    if (issubstr(str_target, "volume")) {
        e_target = getent(str_target, "targetname");
        self setgoal(e_target);
    } else if (issubstr(str_target, "nd_array")) {
        a_nd_targets = getnodearray(str_target, "targetname");
        nd_closest = arraygetclosest(self.origin, a_nd_targets);
        if (!isnodeoccupied(nd_closest)) {
            self setgoal(nd_closest);
        } else {
            self.goalradius = var_84fffedf;
            return;
        }
    } else {
        nd_target = getnode(str_target, "targetname");
        self setgoal(nd_target.origin);
    }
    self waittill(#"goal");
    self.goalradius = var_84fffedf;
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0x1dc1e4ef, Offset: 0x3298
// Size: 0xa
function function_3a407187(a_ents) {
    
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0x97d77a87, Offset: 0x32b0
// Size: 0xa
function function_8f4d515b(a_ents) {
    
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0xc5b7bf96, Offset: 0x32c8
// Size: 0x5a
function function_23e59afd(a_ents) {
    if (!isdefined(level.var_340fac2e)) {
        level.var_340fac2e = vehicle::simple_spawn_single("veh_sarah_mover");
        level.var_340fac2e.drivepath = 1;
    }
    level flag::set("sarah_anchor_prep_scene_done");
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0x75d07a9, Offset: 0x3330
// Size: 0x14a
function function_e2eba6da(a_ents) {
    level flag::wait_till("sarah_anchor_prep_scene_done");
    assert(isdefined(level.var_340fac2e), "<dev string:x315>");
    var_e9020a33 = a_ents["sarah"];
    var_e9020a33 ai::set_ignoreall(1);
    var_e9020a33 ai::set_ignoreme(1);
    level.var_340fac2e.origin = var_e9020a33.origin;
    level.var_340fac2e.angles = var_e9020a33.angles;
    var_e9020a33.anchor = level.var_340fac2e;
    var_e9020a33.anchor.targetname = "sarah_objective_align";
    var_e9020a33 linkto(var_e9020a33.anchor);
    var_e9020a33 thread function_6987653b();
    var_e9020a33 thread function_12efefe3();
    var_e9020a33 thread function_8739c05f();
    var_e9020a33 thread function_1b0b83dc();
    level flag::set("sarah_anchor_post_scene_done");
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x38c162d5, Offset: 0x3488
// Size: 0x54
function function_cbc167() {
    level.var_340fac2e = vehicle::simple_spawn_single("veh_sarah_mover");
    level.var_340fac2e.drivepath = 1;
    var_e9020a33 = util::function_740f8516("sarah");
}

// Namespace infection_util
// Params 3, eflags: 0x0
// Checksum 0x937e745c, Offset: 0x34e8
// Size: 0x3ea
function function_3fe1f72(str_start_trigger, n_start, var_4477da45) {
    level endon(#"hash_afb79ff0");
    if (!isdefined(level.var_340fac2e)) {
        level.var_340fac2e = vehicle::simple_spawn_single("veh_sarah_mover");
    }
    if (isdefined(n_start)) {
        var_addcf1f5 = getent(str_start_trigger + n_start, "targetname");
        level.var_7f8b5d18 = function_1ed270eb(str_start_trigger, n_start);
        array::thread_all(level.var_7f8b5d18, &function_81b715e, level.var_7f8b5d18);
        if (n_start > 0) {
            for (i = 0; i < n_start - 1; i++) {
                var_e264aa0a = getent(str_start_trigger + i, "targetname");
                var_e264aa0a delete();
            }
        }
    }
    var_c66ffe01 = getvehiclenode(var_addcf1f5.target, "targetname");
    var_e9020a33 = util::function_740f8516("sarah");
    if (!var_e9020a33 islinkedto(level.var_340fac2e)) {
        var_e9020a33 forceteleport(var_c66ffe01.origin, var_c66ffe01.angles);
        var_e9020a33 ai::set_ignoreall(1);
        var_e9020a33 ai::set_ignoreme(1);
        var_e9020a33.anchor = level.var_340fac2e;
        var_e9020a33.anchor.targetname = "sarah_objective_align";
        var_e9020a33 linkto(var_e9020a33.anchor);
        var_e9020a33.anchor thread scene::play("cin_inf_00_00_sarah_vign_move_idle", var_e9020a33);
        level.var_340fac2e.origin = var_c66ffe01.origin;
        level.var_340fac2e.angles = var_c66ffe01.angles;
        level.var_340fac2e.drivepath = 1;
        var_e9020a33 thread function_6987653b();
        var_e9020a33 thread function_12efefe3();
        var_e9020a33 thread function_8739c05f();
        var_e9020a33 thread function_1b0b83dc();
    }
    var_782c4804 = 0;
    var_255c21d = undefined;
    level thread function_1a5bb539(var_e9020a33, var_4477da45);
    while (isdefined(var_addcf1f5)) {
        var_255c21d = var_addcf1f5;
        var_addcf1f5 waittill(#"trigger");
        arrayremovevalue(level.var_7f8b5d18, var_addcf1f5);
        n_start++;
        var_addcf1f5 = getent(str_start_trigger + n_start, "targetname");
        if (!isdefined(var_addcf1f5)) {
            continue;
        }
        if (!var_782c4804) {
            var_e9020a33.anchor vehicle::get_on_path(var_c66ffe01);
            var_e9020a33.anchor thread vehicle::go_path();
            var_782c4804 = 1;
        }
        if (isdefined(var_255c21d.script_flag_set) && !flag::get(var_255c21d.script_flag_set)) {
            var_e9020a33.anchor flag::wait_till("waiting_for_flag");
        }
    }
    var_e9020a33.anchor waittill(#"reached_end_node");
    function_73c28a85(var_e9020a33, var_4477da45);
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0x69e27959, Offset: 0x38e0
// Size: 0x129
function function_73c28a85(var_e9020a33, var_4477da45) {
    if (var_e9020a33.anchor scene::is_playing("cin_inf_00_00_sarah_vign_move_idle") || var_e9020a33.anchor scene::is_playing("cin_inf_00_00_sarah_vign_move_enter") || var_e9020a33.anchor scene::is_playing("cin_inf_00_00_sarah_vign_move_leave") || var_e9020a33.anchor scene::is_playing("cin_inf_00_00_sarah_vign_move_idle_talk")) {
        var_e9020a33.anchor scene::stop();
    }
    var_e9020a33 clientfield::set("sarah_objective_light", 0);
    var_e9020a33 unlink();
    var_e9020a33.anchor delete();
    if (isdefined(var_e9020a33.var_5d21e1c9)) {
        var_e9020a33.var_5d21e1c9 = 0;
    }
    util::wait_network_frame();
    if (isdefined(var_4477da45)) {
        var_e9020a33 thread [[ var_4477da45 ]]();
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x904b83a7, Offset: 0x3a18
// Size: 0x95
function function_6987653b() {
    self endon(#"death");
    self.anchor endon(#"death");
    while (true) {
        self.var_f11a8dcd = 1;
        self function_84a3b11a();
        self.anchor flag::wait_till("waiting_for_flag");
        self.var_f11a8dcd = 0;
        self function_42cc1832();
        self.anchor flag::wait_till_clear("waiting_for_flag");
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x232c3e93, Offset: 0x3ab8
// Size: 0x3a
function function_1b0b83dc() {
    self endon(#"death");
    self.anchor endon(#"death");
    level waittill(#"hash_8b5ed1cb");
    self.anchor resumespeed();
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0x9482a9be, Offset: 0x3b00
// Size: 0x8a
function function_1a5bb539(var_e9020a33, var_4477da45) {
    var_e9020a33 endon(#"reached_end_node");
    var_e9020a33 endon(#"death");
    level waittill(#"hash_afb79ff0");
    if (isdefined(var_e9020a33.anchor)) {
        var_e9020a33.anchor setspeed(0, 99999, 99999);
        var_e9020a33.anchor vehicle::get_off_path();
    }
    function_73c28a85(var_e9020a33, var_4477da45);
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xd660741b, Offset: 0x3b98
// Size: 0x195
function function_8739c05f() {
    level endon(#"hash_8b5ed1cb");
    self endon(#"death");
    self.anchor endon(#"death");
    wait 3;
    while (true) {
        var_e243bf54 = [];
        foreach (player in level.activeplayers) {
            if (!isdefined(var_e243bf54)) {
                var_e243bf54 = [];
            } else if (!isarray(var_e243bf54)) {
                var_e243bf54 = array(var_e243bf54);
            }
            var_e243bf54[var_e243bf54.size] = player.origin;
        }
        var_e243bf54 = arraysortclosest(var_e243bf54, self.anchor.origin);
        if (isdefined(var_e243bf54[0]) && self.var_f11a8dcd) {
            if (distance2d(self.anchor.origin, var_e243bf54[0]) < 550) {
                self.anchor setspeed(300, 30, 600);
            } else {
                self.anchor resumespeed();
            }
        }
        wait 0.1;
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x841e3065, Offset: 0x3d38
// Size: 0x3a
function function_84a3b11a() {
    self endon(#"death");
    self.anchor endon(#"death");
    self.anchor scene::play("cin_inf_00_00_sarah_vign_move_leave", self);
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0xdf2e2646, Offset: 0x3d80
// Size: 0x7a
function function_42cc1832(final_pos) {
    self endon(#"death");
    self.anchor endon(#"death");
    if (isdefined(final_pos)) {
        while (distance(self.origin, final_pos.origin) > 512) {
            wait 0.1;
        }
    }
    self.anchor scene::play("cin_inf_00_00_sarah_vign_move_enter", self);
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x4ede5a82, Offset: 0x3e08
// Size: 0x52
function function_637cd603() {
    var_42189297 = util::function_740f8516("sarah");
    if (isdefined(var_42189297.anchor)) {
        var_42189297.anchor thread scene::play("cin_inf_00_00_sarah_vign_move_idle_talk", var_42189297);
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x28e9df4, Offset: 0x3e68
// Size: 0xc9
function function_12efefe3() {
    self endon(#"death");
    self.var_5d21e1c9 = 1;
    while (isdefined(self)) {
        if (self.var_5d21e1c9) {
            if (self function_6fcf2df7() > 3000 || !self.var_f11a8dcd) {
                objectives::set("cp_level_infection_sarah_goto", self);
                while ((distance(level.players[0].origin, self.origin) > 3000 || !self.var_f11a8dcd) && self.var_5d21e1c9) {
                    wait 0.1;
                }
                objectives::complete("cp_level_infection_sarah_goto", self);
            }
        }
        wait 1;
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xfe6abb0b, Offset: 0x3f40
// Size: 0x73
function function_6fcf2df7() {
    n_dist = 10000;
    for (i = 0; i < level.players.size; i++) {
        var_cacbf7e2 = distance(level.players[i].origin, self.origin);
        if (var_cacbf7e2 < n_dist) {
            n_dist = var_cacbf7e2;
        }
    }
    return n_dist;
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0xe58059ab, Offset: 0x3fc0
// Size: 0x77
function function_1ed270eb(str_start_trigger, n_start) {
    var_d7faa155 = [];
    while (true) {
        var_addcf1f5 = getent(str_start_trigger + n_start, "targetname");
        if (isdefined(var_addcf1f5)) {
            var_addcf1f5.var_ad3feaf6 = n_start;
            array::add(var_d7faa155, var_addcf1f5);
            n_start++;
            continue;
        }
        return var_d7faa155;
    }
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0x1c3c66d2, Offset: 0x4040
// Size: 0xa5
function function_81b715e(a_trigs) {
    self endon(#"death");
    while (true) {
        who = self waittill(#"trigger");
        if (isplayer(who)) {
            for (i = 0; i < a_trigs.size; i++) {
                if (isdefined(a_trigs[i]) && a_trigs[i].var_ad3feaf6 < self.var_ad3feaf6) {
                    a_trigs[i] notify(#"trigger");
                    util::wait_network_frame();
                }
            }
            return;
        }
    }
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0x85d27b1a, Offset: 0x40f0
// Size: 0x42
function function_aa0ddbc3(b_enabled, n_delay_time) {
    if (!isdefined(b_enabled)) {
        b_enabled = 1;
    }
    if (!isdefined(n_delay_time)) {
        n_delay_time = 0.1;
    }
    level.var_a5596f65 = b_enabled;
    level.var_56f93473 = n_delay_time;
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x6d7c6a7f, Offset: 0x4140
// Size: 0x1d
function function_a45331fb() {
    if (!isdefined(level.var_a5596f65)) {
        level.var_a5596f65 = 0;
    }
    return level.var_a5596f65;
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x171ed7f7, Offset: 0x4168
// Size: 0x73
function function_cd11e6ad() {
    self endon(#"hash_b1975c04");
    if (isdefined(self.var_4227b8a9) && self.var_4227b8a9) {
        return;
    }
    function_151fb8bf();
    if (isdefined(self)) {
        self clientfield::increment("ai_dni_rez_out");
    }
    wait 0.5;
    if (isdefined(self)) {
        self delete();
        self notify(#"hash_b1975c04");
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xd409fcbc, Offset: 0x41e8
// Size: 0x8f
function function_1f77a211() {
    self endon(#"hash_b1975c04");
    if (isdefined(self.var_4227b8a9) && self.var_4227b8a9) {
        return;
    }
    e_corpse = self waittill(#"actor_corpse");
    function_151fb8bf();
    if (isdefined(e_corpse)) {
        e_corpse clientfield::increment("ai_dni_rez_out");
    }
    wait 0.5;
    if (isdefined(e_corpse)) {
        e_corpse delete();
    }
    if (isdefined(self)) {
        self notify(#"hash_b1975c04");
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xb23fb176, Offset: 0x4280
// Size: 0x12a
function function_796d4d97() {
    if (!self function_b0896729() || isvehicle(self)) {
        return;
    }
    var_fdb28cb6 = getweapon("gadget_exo_breakdown");
    var_1391f610 = getweapon("gadget_mrpukey");
    var_e0871753 = getweapon("gadget_mrpukey_upgraded");
    weapon, eattacker = self waittill(#"hash_f8c5dd60");
    if (weapon === var_fdb28cb6 || weapon === var_1391f610 || weapon === var_e0871753) {
        if (isdefined(self)) {
            self.var_4227b8a9 = 1;
            self notify(#"hash_b1975c04");
        }
        e_corpse = self waittill(#"actor_corpse");
        if (isdefined(e_corpse)) {
            e_corpse clientfield::set("exploding_ai_deaths", 1);
        }
        util::wait_network_frame();
        if (isdefined(e_corpse)) {
            e_corpse delete();
        }
    }
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0xf4aae3df, Offset: 0x43b8
// Size: 0x5a
function function_151fb8bf(n_min, n_max) {
    if (!isdefined(n_min)) {
        n_min = 0.1;
    }
    if (!isdefined(n_max)) {
        n_max = 0.3;
    }
    if (isdefined(level.var_56f93473)) {
        wait level.var_56f93473;
        return;
    }
    wait randomfloatrange(n_min, n_max);
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xb03de57, Offset: 0x4420
// Size: 0x7f
function function_dd8ade86() {
    self endon(#"hash_b1975c04");
    if (isdefined(self.var_4227b8a9) && self.var_4227b8a9) {
        return;
    }
    e_corpse = self waittill(#"actor_corpse");
    if (isdefined(e_corpse)) {
        e_corpse clientfield::increment("ai_dni_rez_out");
    }
    wait 0.5;
    if (isdefined(e_corpse)) {
        e_corpse delete();
    }
    if (isdefined(self)) {
        self notify(#"hash_b1975c04");
    }
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0x21b9eba1, Offset: 0x44a8
// Size: 0x82
function function_c3e494e3(params) {
    var_4b570327 = 0;
    if (isdefined(self.targetname)) {
        if (self.targetname == "sp_tank_gunner_ai") {
            var_4b570327 = 1;
            self thread function_dd8ade86();
        }
    }
    if (!var_4b570327) {
        if (self function_b0896729()) {
            self thread function_1f77a211();
            self thread function_cd11e6ad();
        }
    }
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0xa2ea392c, Offset: 0x4538
// Size: 0x62
function function_1cbdd501(params) {
    self endon(#"hash_b1975c04");
    if (isdefined(level.var_74bd7d24) && level.var_74bd7d24) {
        if (randomintrange(0, 101) < 60) {
            wait 0.75;
            if (isdefined(self)) {
                self playsound("vox_ai_falldeath_scream_male");
            }
        }
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xf450abfd, Offset: 0x45a8
// Size: 0x36
function function_b0896729() {
    return !isvehicle(self) && function_a45331fb() && self.team != "allies";
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x840c474c, Offset: 0x45e8
// Size: 0x4a
function function_674ecd85() {
    a_ai = getaiteamarray("axis", "allies");
    array::spread_all(a_ai, &function_52b9aea3);
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x92cd8e73, Offset: 0x4640
// Size: 0x1a
function function_52b9aea3() {
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0x68f4d85b, Offset: 0x4668
// Size: 0x62
function function_b32291d7(str_targetname, str_key) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    a_ents = getentarray(str_targetname, str_key);
    array::spread_all(a_ents, &function_52b9aea3);
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x5ba3912e, Offset: 0x46d8
// Size: 0x22
function function_e66c8377() {
    self util::stop_magic_bullet_shield();
    self kill();
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xf062ca27, Offset: 0x4708
// Size: 0x3a
function function_5e78ab8c() {
    self endon(#"death");
    self clientfield::increment("ai_dni_rez_out");
    wait 0.5;
    self delete();
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0x3578ade4, Offset: 0x4750
// Size: 0x1a
function function_c32dc5f6(a_ents) {
    function_3bca22f1(a_ents, 1);
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0xe583d665, Offset: 0x4778
// Size: 0x1a
function function_368baff9(a_ents) {
    function_3bca22f1(a_ents, 0);
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0xa6ea927d, Offset: 0x47a0
// Size: 0xaa
function function_b38b2335(a_ents) {
    function_3bca22f1(a_ents, 0);
    foreach (ent in a_ents) {
        if (issubstr(ent.targetname, "sarah")) {
            var_e9020a33 = ent;
        }
    }
    if (isdefined(var_e9020a33)) {
        var_e9020a33 thread function_cd950c1a();
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x307ac1b9, Offset: 0x4858
// Size: 0x32
function function_cd950c1a() {
    self ai::set_ignoreall(1);
    util::wait_network_frame();
    self util::self_delete();
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0xd95f3354, Offset: 0x4898
// Size: 0x10a
function function_3bca22f1(a_ents, b_show) {
    foreach (ent in a_ents) {
        if (isdefined(ent.targetname)) {
            if (issubstr(ent.targetname, "sarah")) {
                var_e9020a33 = ent;
            }
        }
    }
    if (isdefined(var_e9020a33)) {
        if (isai(var_e9020a33)) {
            var_e9020a33 ai::set_ignoreme(1);
        }
        if (isdefined(b_show) && b_show) {
            var_e9020a33 clientfield::set("sarah_objective_light", 1);
            return;
        }
        var_e9020a33 clientfield::set("sarah_objective_light", 0);
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xdfa693f5, Offset: 0x49b0
// Size: 0x42
function function_5f6e4092() {
    array::spread_all(getentarray("snow_disable", "script_noteworthy"), &function_574d968f);
}

// Namespace infection_util
// Params 4, eflags: 0x0
// Checksum 0xe12eeb11, Offset: 0x4a00
// Size: 0x92
function function_a3f21cef(str_scene, var_d5a2e6ed, var_5a248c3f, var_ed131f0f) {
    if (!isdefined(var_5a248c3f)) {
        var_5a248c3f = "targetname";
    }
    if (!isdefined(var_ed131f0f)) {
        var_ed131f0f = 1;
    }
    assert(isdefined(str_scene), "<dev string:x357>");
    assert(isdefined(var_d5a2e6ed), "<dev string:x384>");
    self thread function_62c5971c(str_scene, var_d5a2e6ed, var_5a248c3f, var_ed131f0f);
}

// Namespace infection_util
// Params 4, eflags: 0x0
// Checksum 0xb372be8b, Offset: 0x4aa0
// Size: 0x62
function function_62c5971c(str_scene, var_d5a2e6ed, var_5a248c3f, var_ed131f0f) {
    if (var_ed131f0f) {
        self scene::init(str_scene);
    }
    trigger::wait_till(var_d5a2e6ed, var_5a248c3f, undefined, 1);
    self scene::play(str_scene);
}

// Namespace infection_util
// Params 5, eflags: 0x0
// Checksum 0x92d74bc0, Offset: 0x4b10
// Size: 0x62
function function_1926d38d(str_scene, var_df0a8127, var_5430298a, var_e280766f, var_ed131f0f) {
    if (!isdefined(var_ed131f0f)) {
        var_ed131f0f = 1;
    }
    if (var_ed131f0f) {
        self scene::init(str_scene);
    }
    self thread function_14c6806e(str_scene, var_df0a8127, var_5430298a, var_e280766f, var_ed131f0f);
}

// Namespace infection_util
// Params 5, eflags: 0x0
// Checksum 0x9bdac868, Offset: 0x4b80
// Size: 0x17d
function function_14c6806e(str_scene, var_df0a8127, var_5430298a, var_e280766f, var_ed131f0f) {
    var_568fff7e = getent(var_5430298a, "targetname");
    var_fb0d257b = getent(var_e280766f, "targetname");
    s_lookat = struct::get(var_df0a8127, "targetname");
    while (true) {
        trigger::wait_till(var_e280766f, "targetname");
        if (level.players.size == 1) {
            if (level.players[0] function_f9baa5f4(s_lookat, var_568fff7e, var_fb0d257b, 1) || level.players[0] istouching(var_568fff7e)) {
                self thread scene::play(str_scene);
                var_568fff7e delete();
                var_fb0d257b delete();
                break;
            }
        } else {
            self thread scene::play(str_scene);
            var_568fff7e delete();
            var_fb0d257b delete();
            break;
        }
        util::wait_network_frame();
    }
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0xf319a9da, Offset: 0x4d08
// Size: 0x45
function function_951577ac(var_568fff7e, var_fb0d257b) {
    if (self istouching(var_fb0d257b) && !self istouching(var_568fff7e)) {
        return 1;
    }
    return 0;
}

// Namespace infection_util
// Params 3, eflags: 0x0
// Checksum 0x83986695, Offset: 0x4d58
// Size: 0x7d
function function_a84dcdf8(s_lookat, n_dot_range, var_8703edc3) {
    if (!isdefined(n_dot_range)) {
        n_dot_range = 0.9;
    }
    if (!isdefined(var_8703edc3)) {
        var_8703edc3 = 0;
    }
    self endon(#"death");
    self endon(#"disconnect");
    if (!isdefined(self) || !isdefined(s_lookat)) {
        return 0;
    }
    if (self util::is_looking_at(s_lookat.origin, n_dot_range, var_8703edc3)) {
        return 1;
    }
    return 0;
}

// Namespace infection_util
// Params 4, eflags: 0x0
// Checksum 0x24083950, Offset: 0x4de0
// Size: 0xdd
function function_f9baa5f4(s_lookat, var_568fff7e, var_fb0d257b, n_duration) {
    self endon(#"death");
    self endon(#"disconnect");
    n_time = 0;
    var_fc1c9f = function_951577ac(var_568fff7e, var_fb0d257b);
    b_lookat_check = function_a84dcdf8(s_lookat);
    while (var_fc1c9f && b_lookat_check && n_time < n_duration) {
        var_fc1c9f = function_951577ac(var_568fff7e, var_fb0d257b);
        b_lookat_check = function_a84dcdf8(s_lookat);
        wait 0.1;
        n_time += 0.1;
    }
    if (var_fc1c9f && b_lookat_check && n_time >= n_duration) {
        return 1;
    }
    return 0;
}

// Namespace infection_util
// Params 4, eflags: 0x0
// Checksum 0xe80b3633, Offset: 0x4ec8
// Size: 0x95
function function_c6e0527c(var_df0a8127, n_duration, var_119a2aac, n_max_distance) {
    if (!isdefined(n_max_distance)) {
        n_max_distance = undefined;
    }
    self endon(#"death");
    self endon(#"disconnect");
    s_lookat = struct::get(var_df0a8127, "targetname");
    while (true) {
        if (self function_72268bc2(s_lookat, n_duration, n_max_distance)) {
            level notify(var_119a2aac);
            break;
        }
        util::wait_network_frame();
    }
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0x76193c54, Offset: 0x4f68
// Size: 0x4e
function function_17062d77(s_lookat, n_max_distance) {
    if (isdefined(n_max_distance)) {
        if (distance2d(self.origin, s_lookat.origin) < n_max_distance) {
            return 1;
        } else {
            return 0;
        }
        return;
    }
    return 1;
}

// Namespace infection_util
// Params 3, eflags: 0x0
// Checksum 0x4a934064, Offset: 0x4fc0
// Size: 0xfd
function function_72268bc2(s_lookat, n_duration, n_max_distance) {
    self endon(#"death");
    self endon(#"disconnect");
    n_time = 0;
    if (isdefined(s_lookat.radius)) {
        n_max_distance = s_lookat.radius;
    }
    b_lookat_check = function_a84dcdf8(s_lookat);
    var_1cc80e84 = function_17062d77(s_lookat, n_max_distance);
    while (b_lookat_check && b_lookat_check && n_time < n_duration) {
        b_lookat_check = function_a84dcdf8(s_lookat);
        var_1cc80e84 = function_17062d77(s_lookat, n_max_distance);
        wait 0.1;
        n_time += 0.1;
    }
    if (b_lookat_check && var_1cc80e84 && n_time >= n_duration) {
        return 1;
    }
    return 0;
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xbc01e3e6, Offset: 0x50c8
// Size: 0x92
function function_7a4e1da3() {
    if (isdefined(self.lastactiveweapon) && self.lastactiveweapon != level.weaponnone && self hasweapon(self.lastactiveweapon)) {
        self switchtoweapon(self.lastactiveweapon);
        return;
    }
    primaryweapons = self getweaponslistprimaries();
    if (isdefined(primaryweapons) && primaryweapons.size > 0) {
        self switchtoweapon(primaryweapons[0]);
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x1b39e00f, Offset: 0x5168
// Size: 0x22
function function_9f10c537() {
    self util::function_16c71b8(1);
    self enableinvulnerability();
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xaca01040, Offset: 0x5198
// Size: 0x22
function function_e905c73c() {
    self util::function_16c71b8(0);
    self disableinvulnerability();
}

// Namespace infection_util
// Params 5, eflags: 0x0
// Checksum 0x8cec759b, Offset: 0x51c8
// Size: 0x6d
function function_e14494e9(var_a775367d, var_88c789f5, str_volume, n_wait, n_count) {
    while (true) {
        if (spawn_manager::is_enabled(var_a775367d)) {
            wait n_wait;
            function_903e442f(var_88c789f5, str_volume, n_count);
            break;
        }
        util::wait_network_frame();
    }
}

// Namespace infection_util
// Params 3, eflags: 0x0
// Checksum 0xc07e4932, Offset: 0x5240
// Size: 0x10d
function function_903e442f(str_spawner, str_volume, n_count) {
    while (true) {
        a_ai = getaiteamarray("axis");
        e_volume = getent(str_volume, "targetname");
        var_60db32a8 = [];
        if (isdefined(e_volume)) {
            if (a_ai.size > 0) {
                foreach (ai in a_ai) {
                    if (ai istouching(e_volume)) {
                        var_60db32a8[var_60db32a8.size] = ai;
                    }
                }
            }
        }
        if (var_60db32a8.size <= n_count) {
            spawn_manager::enable(str_spawner);
            break;
        }
        util::wait_network_frame();
    }
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0x66666da3, Offset: 0x5358
// Size: 0x46
function function_e62729fb(e_volume) {
    self endon(#"death");
    self.goalradius = -128;
    self setgoal(e_volume);
    self waittill(#"goal");
    self.goalradius = 1024;
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0x991a0086, Offset: 0x53a8
// Size: 0xdb
function function_642da963(var_525ec887, var_9ecf6f45) {
    var_62666705 = getent(var_9ecf6f45, "targetname");
    a_enemies = getaiarray(var_525ec887, "targetname");
    foreach (e_enemy in a_enemies) {
        if (isalive(e_enemy)) {
            e_enemy thread function_e62729fb(var_62666705);
        }
        util::wait_network_frame();
    }
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0x2d753f6, Offset: 0x5490
// Size: 0x11b
function function_810ccf7(var_ff2595a1, var_ca15af83) {
    a_enemies = getaiteamarray("axis");
    var_1e28a049 = getent(var_ff2595a1, "targetname");
    var_901a3e4b = getent(var_ca15af83, "targetname");
    if (isdefined(var_1e28a049) && isdefined(var_901a3e4b)) {
        foreach (e_enemy in a_enemies) {
            if (isalive(e_enemy)) {
                if (e_enemy istouching(var_1e28a049)) {
                    e_enemy thread function_e62729fb(var_901a3e4b);
                }
            }
            util::wait_network_frame();
        }
    }
}

/#

    // Namespace infection_util
    // Params 5, eflags: 0x0
    // Checksum 0x1e01ca36, Offset: 0x55b8
    // Size: 0x7f
    function function_e02dee76(e_player, str_message, var_9bce0ee1, var_9d21dc7c, font_scale) {
        var_37a329de = (1, 1, 1);
        hud_elem = e_player function_4e1991e7("<dev string:x3b9>", "<dev string:x3c0>", "<dev string:x3b9>", "<dev string:x3c7>", var_9bce0ee1, var_9d21dc7c, font_scale, var_37a329de, str_message);
        return hud_elem;
    }

    // Namespace infection_util
    // Params 9, eflags: 0x0
    // Checksum 0xe14d0ef5, Offset: 0x5640
    // Size: 0x135
    function function_4e1991e7(alignx, aligny, horzalign, vertalign, xoffset, yoffset, fontscale, color, str_text) {
        hud_elem = newclienthudelem(self);
        hud_elem.elemtype = "<dev string:x3cb>";
        hud_elem.font = "<dev string:x3d0>";
        hud_elem.alignx = alignx;
        hud_elem.aligny = aligny;
        hud_elem.horzalign = horzalign;
        hud_elem.vertalign = vertalign;
        hud_elem.x += xoffset;
        hud_elem.y += yoffset;
        hud_elem.foreground = 1;
        hud_elem.fontscale = fontscale;
        hud_elem.alpha = 1;
        hud_elem.color = color;
        hud_elem.hidewheninmenu = 1;
        hud_elem settext(str_text);
        return hud_elem;
    }

#/

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0xce58d7dc, Offset: 0x5780
// Size: 0x20a
function player_can_see_me(dist) {
    if (!isdefined(dist)) {
        dist = 512;
    }
    for (i = 0; i < level.players.size; i++) {
        if (!isdefined(self)) {
            return false;
        }
        if (!isdefined(level.players[i])) {
            continue;
        }
        playerangles = level.players[i] getplayerangles();
        playerforwardvec = anglestoforward(playerangles);
        playerunitforwardvec = vectornormalize(playerforwardvec);
        banzaipos = self.origin;
        playerpos = level.players[i] getorigin();
        playertobanzaivec = banzaipos - playerpos;
        playertobanzaiunitvec = vectornormalize(playertobanzaivec);
        forwarddotbanzai = vectordot(playerunitforwardvec, playertobanzaiunitvec);
        if (forwarddotbanzai >= 1) {
            anglefromcenter = 0;
        } else if (forwarddotbanzai <= -1) {
            anglefromcenter = -76;
        } else {
            anglefromcenter = acos(forwarddotbanzai);
        }
        playerfov = getdvarfloat("cg_fov");
        banzaivsplayerfovbuffer = getdvarfloat("g_banzai_player_fov_buffer");
        if (banzaivsplayerfovbuffer <= 0) {
            banzaivsplayerfovbuffer = 0.2;
        }
        var_ad758dfb = anglefromcenter <= playerfov * 0.5 * (1 - banzaivsplayerfovbuffer);
        if (isdefined(var_ad758dfb) && var_ad758dfb || distance(level.players[i].origin, self.origin) < dist) {
            return true;
        }
    }
    return false;
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0x8c1a2eb6, Offset: 0x5998
// Size: 0x63
function function_9d8bcc37(a_models) {
    foreach (model in a_models) {
        model ghost();
    }
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0xe0c4b659, Offset: 0x5a08
// Size: 0x63
function function_bdea6c61(a_models) {
    foreach (model in a_models) {
        model show();
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x29bf809f, Offset: 0x5a78
// Size: 0x2a
function function_b8670a1c() {
    level.var_ac69c49c = level.sun_shadow_split_distance;
    level util::set_sun_shadow_split_distance(5000);
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xc43c4c1c, Offset: 0x5ab0
// Size: 0x22
function function_ed468ba2() {
    if (isdefined(level.var_ac69c49c)) {
        level util::set_sun_shadow_split_distance(level.var_ac69c49c);
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x22e9099e, Offset: 0x5ae0
// Size: 0x121
function zmbaivox_notifyconvert() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    self thread function_9fc02a8();
    self thread zmbaivox_playdeath();
    while (true) {
        notify_string = self waittill(#"bhtn_action_notify");
        switch (notify_string) {
        case "attack_melee":
        case "behind":
        case "close":
        case "death":
        case "electrocute":
            level thread zmbaivox_playvox(self, notify_string, 1);
            break;
        case "ambient":
        case "crawler":
        case "sprint":
        case "taunt":
        case "teardown":
            level thread zmbaivox_playvox(self, notify_string, 0);
            break;
        default:
            if (isdefined(level.var_6bda12f0)) {
                if (isdefined(level.var_6bda12f0[notify_string])) {
                    level thread zmbaivox_playvox(self, notify_string, 0);
                }
            }
            break;
        }
    }
}

// Namespace infection_util
// Params 3, eflags: 0x0
// Checksum 0xcb8fa2aa, Offset: 0x5c10
// Size: 0x122
function zmbaivox_playvox(zombie, type, override) {
    zombie endon(#"death");
    if (!isdefined(zombie)) {
        return;
    }
    if (!isdefined(zombie.voiceprefix)) {
        return;
    }
    alias = "zmb_vocals_" + zombie.voiceprefix + "_" + type;
    if (sndisnetworksafe()) {
        if (isdefined(override) && override) {
            if (type == "death") {
                zombie playsound(alias);
            } else {
                zombie playsoundontag(alias, "j_head");
            }
            return;
        }
        if (!(isdefined(zombie.talking) && zombie.talking)) {
            zombie.talking = 1;
            zombie playsoundwithnotify(alias, "sounddone", "j_head");
            zombie waittill(#"sounddone");
            zombie.talking = 0;
        }
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x988e37ca, Offset: 0x5d40
// Size: 0xe5
function function_9fc02a8() {
    self endon(#"death");
    wait randomfloatrange(1, 3);
    while (true) {
        type = "ambient";
        if (!isdefined(self.zombie_move_speed)) {
            wait 0.5;
            continue;
        }
        switch (self.zombie_move_speed) {
        case "walk":
            type = "ambient";
            break;
        case "run":
            type = "sprint";
            break;
        case "sprint":
            type = "sprint";
            break;
        }
        if (isdefined(self.missinglegs) && self.missinglegs) {
            type = "crawler";
        }
        self notify(#"bhtn_action_notify", type);
        wait randomfloatrange(1, 4);
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x7c8554a8, Offset: 0x5e30
// Size: 0x42
function zmbaivox_playdeath() {
    self endon(#"disconnect");
    attacker, meansofdeath = self waittill(#"death");
    if (isdefined(self)) {
        level thread zmbaivox_playvox(self, "death", 1);
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x792d6506, Offset: 0x5e80
// Size: 0x1d
function networksafereset() {
    while (true) {
        level._numzmbaivox = 0;
        util::wait_network_frame();
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xd34de7e3, Offset: 0x5ea8
// Size: 0x34
function sndisnetworksafe() {
    if (!isdefined(level._numzmbaivox)) {
        level thread networksafereset();
    }
    if (level._numzmbaivox >= 2) {
        return false;
    }
    level._numzmbaivox++;
    return true;
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x269fd66e, Offset: 0x5ee8
// Size: 0x1a5
function zombie_behind_vox() {
    level endon(#"hash_25601ed0");
    self endon(#"death_or_disconnect");
    level waittill(#"hash_ee152b14");
    if (!isdefined(level._zbv_vox_last_update_time)) {
        level._zbv_vox_last_update_time = 0;
        level._audio_zbv_shared_ent_list = getaiteamarray("axis");
    }
    while (true) {
        wait 1;
        t = gettime();
        if (t > level._zbv_vox_last_update_time + 1000) {
            level._zbv_vox_last_update_time = t;
            level._audio_zbv_shared_ent_list = getaiteamarray("axis");
        }
        zombs = level._audio_zbv_shared_ent_list;
        played_sound = 0;
        for (i = 0; i < zombs.size; i++) {
            if (!isdefined(zombs[i])) {
                continue;
            }
            if (distancesquared(zombs[i].origin, self.origin) < 62500) {
                yaw = self getyawtospot(zombs[i].origin);
                z_diff = self.origin[2] - zombs[i].origin[2];
                if ((yaw < -95 || yaw > 95) && abs(z_diff) < 50) {
                    zombs[i] notify(#"bhtn_action_notify", "behind");
                    played_sound = 1;
                    break;
                }
            }
        }
        if (played_sound) {
            wait 5;
        }
    }
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0xd3ff226d, Offset: 0x6098
// Size: 0x56
function getyawtospot(spot) {
    pos = spot;
    yaw = self.angles[1] - getyaw(pos);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0x2f37abb5, Offset: 0x60f8
// Size: 0x31
function getyaw(org) {
    angles = vectortoangles(org - self.origin);
    return angles[1];
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0xb7835bd1, Offset: 0x6138
// Size: 0x8b
function function_9f0ad974(pos) {
    closest_dist = 99999.9;
    a_players = getplayers();
    for (i = 0; i < a_players.size; i++) {
        dist = distance(a_players[i].origin, pos);
        if (dist < closest_dist) {
            closest_dist = dist;
        }
    }
    return closest_dist;
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0x5eb25dde, Offset: 0x61d0
// Size: 0x42
function function_eaf9c027(var_6d8a08b3, var_e0017db3) {
    if (!isdefined(var_e0017db3)) {
        var_e0017db3 = "fullscreen_additive";
    }
    level function_dd048f8d("dni_futz", var_6d8a08b3, var_e0017db3);
}

// Namespace infection_util
// Params 5, eflags: 0x0
// Checksum 0xad8d12a6, Offset: 0x6220
// Size: 0x17b
function function_dd048f8d(var_8907c2b8, var_6d8a08b3, var_e0017db3, var_28856194, var_ecc70d4b) {
    if (!isdefined(var_28856194)) {
        var_28856194 = 0;
    }
    if (!isdefined(var_ecc70d4b)) {
        var_ecc70d4b = 0;
    }
    var_b14c1a2c = [];
    var_b14c1a2c["dni_interrupt"] = "postfx_dni_interrupt";
    var_b14c1a2c["dni_futz"] = "postfx_futz";
    assert(isdefined(var_b14c1a2c[var_8907c2b8]), "<dev string:x3da>" + var_8907c2b8);
    if (var_28856194) {
        foreach (player in level.players) {
            player clientfield::increment_to_player(var_b14c1a2c[var_8907c2b8], 1);
        }
        wait 1;
    }
    if (isdefined(var_6d8a08b3)) {
        lui::play_movie(var_6d8a08b3, var_e0017db3);
        if (var_ecc70d4b) {
            foreach (player in level.players) {
                player clientfield::increment_to_player(var_b14c1a2c[var_8907c2b8], 1);
            }
        }
    }
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0xa99654f6, Offset: 0x63a8
// Size: 0xb3
function function_6ff4aa0e(var_e33a0786, b_use_spawn_fx) {
    if (!isdefined(b_use_spawn_fx)) {
        b_use_spawn_fx = 1;
    }
    self endon(#"death");
    if (isdefined(b_use_spawn_fx) && b_use_spawn_fx) {
        self clientfield::set("sarah_camo_shader", 2);
        self clientfield::set("ai_dni_rez_in", 1);
        wait 1;
    }
    self clientfield::set("sarah_camo_shader", var_e33a0786);
    if (var_e33a0786 == 1) {
        self ai::set_ignoreme(1);
        return;
    }
    self ai::set_ignoreme(0);
    self notify(#"hash_a6476729");
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0x47a98bf4, Offset: 0x6468
// Size: 0x10a
function function_9110a277(var_e33a0786, b_use_spawn_fx) {
    if (!isdefined(b_use_spawn_fx)) {
        b_use_spawn_fx = 1;
    }
    self endon(#"death");
    if (isdefined(b_use_spawn_fx) && b_use_spawn_fx) {
        self clientfield::set("sarah_camo_shader", 2);
        if (var_e33a0786 == 1) {
            self clientfield::increment("ai_dni_rez_out", 1);
        } else {
            self util::delay(0.5, undefined, &clientfield::set, "ai_dni_rez_in", 1);
        }
        wait 1;
    }
    self clientfield::set("sarah_camo_shader", var_e33a0786);
    if (var_e33a0786 == 1) {
        self ai::set_ignoreme(1);
        self ghost();
        return;
    }
    self ai::set_ignoreme(0);
    self notify(#"hash_a6476729");
    self show();
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0xa0af58f0, Offset: 0x6580
// Size: 0x109
function function_8420d8cd(str_struct) {
    s_struct = struct::get(str_struct, "targetname");
    var_d91de807 = anglestoforward(s_struct.angles);
    player_close = 0;
    while (!player_close) {
        a_players = getplayers();
        for (i = 0; i < a_players.size; i++) {
            e_player = a_players[i];
            v_dir = vectornormalize(e_player.origin - s_struct.origin);
            dp = vectordot(v_dir, var_d91de807);
            if (dp > 0) {
                player_close = 1;
                break;
            }
        }
        wait 0.05;
    }
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0x20ba8427, Offset: 0x6698
// Size: 0x115
function function_9d611fab(str_struct) {
    s_struct = struct::get(str_struct, "targetname");
    var_d91de807 = anglestoforward(s_struct.angles);
    while (true) {
        var_226231f3 = 0;
        a_players = getplayers();
        for (i = 0; i < a_players.size; i++) {
            e_player = a_players[i];
            v_dir = vectornormalize(e_player.origin - s_struct.origin);
            dp = vectordot(v_dir, var_d91de807);
            if (dp > 0) {
                var_226231f3++;
            }
        }
        if (var_226231f3 == a_players.size) {
            break;
        }
        wait 0.05;
    }
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0xad39f0af, Offset: 0x67b8
// Size: 0x1e
function function_426fde37(e_ent, var_686b9aeb) {
    e_ent.var_8c3e4f1f = var_686b9aeb;
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0x276b0f4e, Offset: 0x67e0
// Size: 0xa9
function function_b016b536(var_686b9aeb, var_5ea5c7d9) {
    a_ai = getaiarray();
    if (isdefined(a_ai)) {
        for (i = 0; i < a_ai.size; i++) {
            e_ent = a_ai[i];
            if (isdefined(e_ent.var_8c3e4f1f) && e_ent.var_8c3e4f1f == var_686b9aeb) {
                if (var_5ea5c7d9) {
                    e_ent kill();
                    continue;
                }
                e_ent delete();
            }
        }
    }
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0x90a3eb47, Offset: 0x6898
// Size: 0x117
function function_9e5ed1ac(a_ents) {
    var_3c3f5d83 = [];
    a_players = getplayers();
    while (a_ents.size > 0) {
        e_closest = undefined;
        n_closest = 1e+06;
        for (i = 0; i < a_ents.size; i++) {
            var_cacbf7e2 = 1e+06;
            for (var_5080ec5b = 0; var_5080ec5b < a_players.size; var_5080ec5b++) {
                dist = distance(a_players[var_5080ec5b].origin, a_ents[i].origin);
                if (dist < var_cacbf7e2) {
                    var_cacbf7e2 = dist;
                }
            }
            if (var_cacbf7e2 < n_closest) {
                n_closest = var_cacbf7e2;
                e_closest = a_ents[i];
            }
        }
        var_3c3f5d83[var_3c3f5d83.size] = e_closest;
        arrayremovevalue(a_ents, e_closest);
    }
    return var_3c3f5d83;
}

// Namespace infection_util
// Params 1, eflags: 0x0
// Checksum 0xe50bd951, Offset: 0x69b8
// Size: 0x80
function function_3c363cb3(var_7edf627d) {
    var_7b3a5649 = getaiteamarray("allies");
    var_7b3a5649 = array::exclude(var_7b3a5649, level.heroes);
    var_58c5eb41 = arraygetclosest(level.players[0].origin, var_7b3a5649);
    if (isdefined(var_58c5eb41)) {
        var_58c5eb41 notify(#"hash_2605e152", var_7edf627d);
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xe87e6e5a, Offset: 0x6a40
// Size: 0x8b
function function_67137b13() {
    var_8db36247 = getentarray("fold_plane", "targetname");
    foreach (var_e1427d74 in var_8db36247) {
        var_e1427d74 show();
    }
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0xc21710c8, Offset: 0x6ad8
// Size: 0x8b
function function_4f66eed6() {
    var_8db36247 = getentarray("fold_plane", "targetname");
    foreach (var_e1427d74 in var_8db36247) {
        var_e1427d74 ghost();
    }
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0xf9fa743d, Offset: 0x6b70
// Size: 0xdb
function function_9f64d290(a_ents, b_enable) {
    foreach (ent in a_ents) {
        if (b_enable) {
            if (isactor(ent) && isdefined(ent.var_68dd6b84)) {
                ent.propername = ent.var_68dd6b84;
            }
            continue;
        }
        if (isactor(ent) && isdefined(ent.propername)) {
            ent.var_68dd6b84 = ent.propername;
            ent.propername = "";
        }
    }
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0xce8b9a09, Offset: 0x6c58
// Size: 0x52
function function_7aca917c(var_920aba92, var_8182276a) {
    if (!isdefined(var_8182276a)) {
        var_8182276a = 0;
    }
    level.var_1b3f87f7 = createstreamerhint(var_920aba92, 1, var_8182276a);
    level.var_1b3f87f7 setlightingonly(1);
}

// Namespace infection_util
// Params 3, eflags: 0x0
// Checksum 0xa94d19c4, Offset: 0x6cb8
// Size: 0x151
function function_f6d49772(str_trig_name, str_dialog, var_3642df18) {
    level endon(var_3642df18);
    while (true) {
        trig = getent(str_trig_name, "targetname");
        who = trig waittill(#"trigger");
        if (!isdefined(who.var_a2496e3e)) {
            who.var_a2496e3e = [];
            who.var_a2496e3e[str_dialog] = 1;
            while (isdefined(who.var_5441261b) && who.var_5441261b) {
                wait 0.5;
            }
            who.var_5441261b = 1;
            level dialog::say(str_dialog, 0, 1, who);
            who.var_5441261b = 0;
            continue;
        }
        if (!isdefined(who.var_a2496e3e[str_dialog])) {
            who.var_a2496e3e[str_dialog] = 1;
            while (isdefined(who.var_5441261b) && who.var_5441261b) {
                wait 0.5;
            }
            who.var_5441261b = 1;
            level dialog::say(str_dialog, 0, 1, who);
            who.var_5441261b = 0;
        }
    }
}

