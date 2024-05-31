#using scripts/zm/zm_zod_vo;
#using scripts/zm/zm_zod_util;
#using scripts/zm/zm_zod_sword_quest;
#using scripts/zm/zm_zod_smashables;
#using scripts/zm/_zm_weap_idgun;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_timer;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_ai_raps;
#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_54bf13f5;

// Namespace namespace_54bf13f5
// Params 0, eflags: 0x2
// Checksum 0xc1ddeec0, Offset: 0x600
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_zod_idgun_quest", &__init__, &__main__, undefined);
}

// Namespace namespace_54bf13f5
// Params 0, eflags: 0x1 linked
// Checksum 0x5d65e931, Offset: 0x648
// Size: 0x144
function __init__() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    clientfield::register("world", "add_idgun_to_box", 1, 4, "int");
    clientfield::register("world", "remove_idgun_from_box", 1, 4, "int");
    level flag::init("second_idgun_time");
    for (i = 0; i < 3; i++) {
        level flag::init("idgun_cocoon_" + i + "_found");
    }
    /#
        level thread function_1c946455();
        level thread function_e4e5cd30();
    #/
}

// Namespace namespace_54bf13f5
// Params 0, eflags: 0x1 linked
// Checksum 0xb38d215e, Offset: 0x798
// Size: 0x1f0
function __main__() {
    var_fd261f68 = array("idgun_0", "idgun_1", "idgun_2", "idgun_3");
    level function_436486f7();
    zm_spawner::register_zombie_death_event_callback(&function_101cc4e2);
    for (i = 0; i < 2; i++) {
        level.var_42517170[i] = spawnstruct();
        level.var_42517170[i].kill_count = 0;
        level.var_42517170[i].var_356fbd8b = i;
        var_fd261f68 = array::randomize(var_fd261f68);
        level.var_42517170[i].var_e4be281f = array::pop_front(var_fd261f68);
        zm_weapons::add_limited_weapon(level.var_42517170[i].var_e4be281f, 1);
        for (j = 0; j < level.idgun_weapons.size; j++) {
            if (level.var_42517170[i].var_e4be281f == level.idgun_weapons[j].name) {
                level.var_42517170[i].var_e787e99a = j;
                break;
            }
        }
    }
    wait(0.5);
}

// Namespace namespace_54bf13f5
// Params 1, eflags: 0x1 linked
// Checksum 0x8b83f51f, Offset: 0x990
// Size: 0x8a
function function_e1efbc50(var_9727e47e) {
    if (var_9727e47e != level.weaponnone) {
        if (!isdefined(level.idgun_weapons)) {
            level.idgun_weapons = [];
        } else if (!isarray(level.idgun_weapons)) {
            level.idgun_weapons = array(level.idgun_weapons);
        }
        level.idgun_weapons[level.idgun_weapons.size] = var_9727e47e;
    }
}

// Namespace namespace_54bf13f5
// Params 0, eflags: 0x1 linked
// Checksum 0x283cfe5b, Offset: 0xa28
// Size: 0x154
function function_436486f7() {
    level.idgun_weapons = [];
    function_e1efbc50(getweapon("idgun_0"));
    function_e1efbc50(getweapon("idgun_1"));
    function_e1efbc50(getweapon("idgun_2"));
    function_e1efbc50(getweapon("idgun_3"));
    function_e1efbc50(getweapon("idgun_upgraded_0"));
    function_e1efbc50(getweapon("idgun_upgraded_1"));
    function_e1efbc50(getweapon("idgun_upgraded_2"));
    function_e1efbc50(getweapon("idgun_upgraded_3"));
}

// Namespace namespace_54bf13f5
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xb88
// Size: 0x4
function on_player_connect() {
    
}

// Namespace namespace_54bf13f5
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xb98
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace namespace_54bf13f5
// Params 1, eflags: 0x1 linked
// Checksum 0xf6c8b2d9, Offset: 0xba8
// Size: 0x248
function function_14e2eca6(params) {
    if (level.round_number < 12) {
        return;
    }
    if (self.var_a3c425d1 === 1) {
        return;
    }
    if (level flag::get("part_xenomatter" + "_found")) {
        return;
    }
    if (isdefined(level.var_689ff92e) && level.var_689ff92e) {
        return;
    }
    if (!isplayer(params.eattacker)) {
        return;
    }
    n_rand = randomfloatrange(0, 1);
    if (n_rand >= 0.1) {
        return;
    }
    level.var_689ff92e = 1;
    var_dad4b542 = self getorigin();
    var_72cd7c0a = getclosestpointonnavmesh(var_dad4b542, 500, 0);
    var_ca79e2ce = (var_dad4b542[0], var_dad4b542[1], 0);
    var_dcaa8f8e = (var_72cd7c0a[0], var_72cd7c0a[1], 0);
    if (var_ca79e2ce == var_dcaa8f8e) {
        function_f5469e1(var_72cd7c0a, "part_xenomatter");
    }
    if (!level flag::get("part_xenomatter" + "_found")) {
        mdl_part = level namespace_f37770c8::function_1f5d26ed("idgun", "part_xenomatter");
        var_55d0f940 = struct::get("safe_place_for_items", "targetname");
        mdl_part.origin = var_55d0f940.origin;
        level.var_689ff92e = 0;
    }
}

// Namespace namespace_54bf13f5
// Params 0, eflags: 0x1 linked
// Checksum 0x885cfa7e, Offset: 0xdf8
// Size: 0x64
function function_c3ffc175() {
    if (level clientfield::get("bm_superbeast")) {
        function_6baaa92e();
        return;
    }
    if (self.var_89905c65 !== 1) {
        function_44e0f6b4();
    }
}

// Namespace namespace_54bf13f5
// Params 0, eflags: 0x1 linked
// Checksum 0xb1e0cc54, Offset: 0xe68
// Size: 0x180
function function_44e0f6b4() {
    if (getdvarint("splitscreen_playerCount") > 2 && !(isdefined(level.var_5fadf2ff) && level.var_5fadf2ff)) {
        function_6893c200();
        return;
    }
    if (isdefined(level.var_359f6a1d) && level.var_359f6a1d) {
        return;
    }
    level.var_359f6a1d = 1;
    drop_point = self getorigin();
    drop_point += (0, 0, 30);
    function_f5469e1(drop_point, "part_heart");
    if (!level flag::get("part_heart" + "_found")) {
        mdl_part = level namespace_f37770c8::function_1f5d26ed("idgun", "part_heart");
        var_55d0f940 = struct::get("safe_place_for_items", "targetname");
        mdl_part.origin = var_55d0f940.origin;
        level.var_359f6a1d = 0;
    }
}

// Namespace namespace_54bf13f5
// Params 0, eflags: 0x1 linked
// Checksum 0xaa00d251, Offset: 0xff0
// Size: 0x118
function function_6893c200() {
    level.var_5fadf2ff = 1;
    drop_point = self getorigin();
    drop_point += (0, 0, 30);
    function_f5469e1(drop_point, "part_skeleton");
    if (!level flag::get("part_skeleton" + "_found")) {
        mdl_part = level namespace_f37770c8::function_1f5d26ed("idgun", "part_skeleton");
        var_55d0f940 = struct::get("safe_place_for_items", "targetname");
        mdl_part.origin = var_55d0f940.origin;
        level.var_5fadf2ff = 0;
    }
}

// Namespace namespace_54bf13f5
// Params 0, eflags: 0x1 linked
// Checksum 0xbde7df9, Offset: 0x1110
// Size: 0x9c
function function_6baaa92e() {
    drop_point = self getorigin();
    drop_point += (0, 0, 30);
    var_5404ad23 = spawn("script_model", drop_point);
    var_5404ad23 setmodel("p7_zm_zod_margwa_heart");
    function_a3712047(var_5404ad23);
}

// Namespace namespace_54bf13f5
// Params 1, eflags: 0x1 linked
// Checksum 0x84d2ff7f, Offset: 0x11b8
// Size: 0x194
function function_a3712047(var_5404ad23) {
    width = -128;
    height = -128;
    length = -128;
    var_5404ad23.unitrigger_stub = spawnstruct();
    var_5404ad23.unitrigger_stub.origin = var_5404ad23.origin;
    var_5404ad23.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    var_5404ad23.unitrigger_stub.cursor_hint = "HINT_NOICON";
    var_5404ad23.unitrigger_stub.script_width = width;
    var_5404ad23.unitrigger_stub.script_height = height;
    var_5404ad23.unitrigger_stub.script_length = length;
    var_5404ad23.unitrigger_stub.require_look_at = 0;
    var_5404ad23.unitrigger_stub.prompt_and_visibility_func = &function_12fffd19;
    zm_unitrigger::register_static_unitrigger(var_5404ad23.unitrigger_stub, &function_dd2f6fe3);
    wait(5);
    var_5404ad23 delete();
}

// Namespace namespace_54bf13f5
// Params 1, eflags: 0x1 linked
// Checksum 0x48a555f6, Offset: 0x1358
// Size: 0x62
function function_12fffd19(player) {
    b_is_invis = isdefined(player.beastmode) && player.beastmode;
    self setinvisibletoplayer(player, b_is_invis);
    return !b_is_invis;
}

// Namespace namespace_54bf13f5
// Params 0, eflags: 0x1 linked
// Checksum 0xe5974a5a, Offset: 0x13c8
// Size: 0xba
function function_dd2f6fe3() {
    while (true) {
        player = self waittill(#"trigger");
        if (player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (player.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(player)) {
            continue;
        }
        player thread zm_audio::create_and_play_dialog("margwa", "heart_pickup");
        level thread function_32d36516(self);
        return;
    }
}

// Namespace namespace_54bf13f5
// Params 1, eflags: 0x1 linked
// Checksum 0x5ba6e2f2, Offset: 0x1490
// Size: 0xac
function function_32d36516(var_5404ad23) {
    foreach (player in level.activeplayers) {
        player reviveplayer();
    }
    var_5404ad23 delete();
}

// Namespace namespace_54bf13f5
// Params 4, eflags: 0x1 linked
// Checksum 0x32c4dbc8, Offset: 0x1548
// Size: 0x1ea
function function_f5469e1(v_origin, str_part, var_1907d45e, var_6a2f1c3a) {
    if (!isdefined(var_1907d45e)) {
        var_1907d45e = 1;
    }
    if (!isdefined(var_6a2f1c3a)) {
        var_6a2f1c3a = 0;
    }
    level endon(#"hash_14edc619");
    if (!var_6a2f1c3a) {
        mdl_part = level namespace_f37770c8::function_1f5d26ed("idgun", str_part);
    } else {
        mdl_part = level namespace_f37770c8::function_1f5d26ed("second_idgun", str_part);
    }
    mdl_part.origin = v_origin;
    playable_area = getentarray("player_volume", "script_noteworthy");
    valid_drop = 0;
    for (i = 0; i < playable_area.size; i++) {
        if (mdl_part istouching(playable_area[i])) {
            valid_drop = 1;
        }
    }
    if (!valid_drop) {
        mdl_part setinvisibletoall();
        return;
    }
    mdl_part setvisibletoall();
    if (!var_1907d45e) {
        return;
    }
    wait(10);
    level thread function_21ad8866(mdl_part);
    wait(10);
    mdl_part setinvisibletoall();
    level notify(#"hash_21ad8866");
}

// Namespace namespace_54bf13f5
// Params 1, eflags: 0x1 linked
// Checksum 0x349e75f1, Offset: 0x1740
// Size: 0x80
function function_21ad8866(mdl_part) {
    level notify(#"hash_21ad8866");
    level endon(#"hash_21ad8866");
    level endon(#"hash_14edc619");
    while (true) {
        mdl_part setinvisibletoall();
        wait(0.5);
        mdl_part setvisibletoall();
        wait(0.5);
    }
}

// Namespace namespace_54bf13f5
// Params 1, eflags: 0x0
// Checksum 0x7ef2e29e, Offset: 0x17c8
// Size: 0x34
function function_e70e794e(var_bd705d9a) {
    if (isdefined(var_bd705d9a.is_speaking) && var_bd705d9a.is_speaking) {
        return;
    }
}

// Namespace namespace_54bf13f5
// Params 1, eflags: 0x1 linked
// Checksum 0xe6dc09aa, Offset: 0x1808
// Size: 0x12e
function function_101cc4e2(attacker) {
    for (i = 0; i < level.idgun_weapons.size; i++) {
        wpn = level.idgun_weapons[i];
        if (!isdefined(self)) {
            return;
        }
        if (self.damageweapon === wpn) {
            var_42517170 = function_b9729f28(self.attacker);
            if (!isdefined(var_42517170)) {
                return;
            }
            var_42517170.kill_count++;
            if (level flag::get("second_idgun_time")) {
                return;
            }
            if (var_42517170.kill_count > 10) {
                level flag::set("second_idgun_time");
                var_42517170.owner namespace_b8707f8e::function_1a180bd3("vox_idgun_upgrade_ready");
            }
        }
    }
}

// Namespace namespace_54bf13f5
// Params 1, eflags: 0x1 linked
// Checksum 0x7114ff0d, Offset: 0x1940
// Size: 0x64
function function_b9729f28(player) {
    for (i = 0; i < 2; i++) {
        if (level.var_42517170[i].owner === player) {
            return level.var_42517170[i];
        }
    }
}

// Namespace namespace_54bf13f5
// Params 0, eflags: 0x0
// Checksum 0x78a12db5, Offset: 0x19b0
// Size: 0x256
function function_b4c3b798() {
    level flag::wait_till("second_idgun_time");
    var_ffcd34fb = struct::get_array("idgun_cocoon_point", "targetname");
    if (!isdefined(level.var_a26610f1)) {
        level.var_a26610f1 = [];
    }
    for (i = 0; i < 3; i++) {
        switch (i) {
        case 0:
            var_d42f02cf = "theater";
            str_part = "part_heart";
            break;
        case 1:
            var_d42f02cf = "slums";
            str_part = "part_skeleton";
            break;
        case 2:
            var_d42f02cf = "canal";
            str_part = "part_xenomatter";
            break;
        }
        var_c6a8002 = array::filter(var_ffcd34fb, 0, &function_1bfbfa4c, var_d42f02cf);
        level.var_a26610f1[i] = array::random(var_c6a8002);
        var_e6d966e = spawn("script_model", level.var_a26610f1[i].origin);
        var_e6d966e setmodel("p7_zm_zod_cocoon");
        var_e6d966e setcandamage(1);
        var_e6d966e thread function_47867b41(i, str_part);
        if (isdefined(level.var_42517170[0].owner)) {
            level.var_42517170[0].owner thread function_538643a3(i);
        }
    }
}

// Namespace namespace_54bf13f5
// Params 2, eflags: 0x1 linked
// Checksum 0xc809a9e1, Offset: 0x1c10
// Size: 0x48
function function_1bfbfa4c(e_entity, var_d42f02cf) {
    if (!isdefined(e_entity.script_string) || e_entity.script_string != var_d42f02cf) {
        return false;
    }
    return true;
}

// Namespace namespace_54bf13f5
// Params 2, eflags: 0x1 linked
// Checksum 0x6fb988f5, Offset: 0x1c60
// Size: 0x27a
function function_47867b41(var_3fbc06aa, str_part) {
    while (true) {
        amount, attacker, direction_vec, point, type, tagname, modelname, partname, weapon = self waittill(#"damage");
        level flag::set("idgun_cocoon_" + var_3fbc06aa + "_found");
        if ((isdefined(zm::is_idgun_damage(weapon)) && zm::is_idgun_damage(weapon)) === 0) {
            return;
        }
        self show();
        v_origin = self getorigin();
        direction_vec = (0, 0, -1);
        scale = 8000;
        direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
        trace = bullettrace(v_origin, v_origin + direction_vec, 0, undefined);
        drop_point = trace["position"];
        drop_point += (0, 0, 10);
        self moveto(drop_point, 1);
        wait(1);
        self hide();
        playfx(level._effect["idgun_cocoon_off"], self.origin);
        function_f5469e1(drop_point, str_part, 0, 1);
        return;
    }
}

// Namespace namespace_54bf13f5
// Params 1, eflags: 0x1 linked
// Checksum 0xe68dd99b, Offset: 0x1ee8
// Size: 0x3e4
function function_538643a3(var_3fbc06aa) {
    self endon(#"bleed_out");
    self endon(#"death");
    self endon(#"disconnect");
    var_e610614b = level.var_a26610f1[var_3fbc06aa].origin;
    var_76cf6eef = 262144;
    var_9d192e2d = 4096;
    var_2509d2fc = var_76cf6eef - var_9d192e2d;
    var_4a166ae5 = 0.7;
    var_f6b0cbe4 = undefined;
    var_ac3d0ec3 = undefined;
    n_scale = undefined;
    var_887c2fcb = undefined;
    while (true) {
        var_5cc8da3f = self getcurrentweapon();
        var_3262a5f7 = getweapon(level.var_42517170[0].var_e4be281f);
        if (var_5cc8da3f !== var_3262a5f7) {
            wait(0.1);
            break;
        }
        var_888da1cf = (var_e610614b[0], var_e610614b[1], self.origin[2]);
        var_30c97f9b = distancesquared(self.origin, var_888da1cf);
        if (var_30c97f9b <= var_76cf6eef) {
            var_ac3d0ec3 = 1;
            var_b9f3ddcc = self getplayercamerapos();
            var_bff77cb5 = anglestoforward(self getplayerangles());
            var_744d3805 = vectornormalize(var_e610614b - var_b9f3ddcc);
            n_dot = vectordot(var_744d3805, var_bff77cb5);
            if (n_dot > 0.9) {
                var_ac3d0ec3 = 0.3;
                n_scale = 1;
                var_887c2fcb = 2;
            } else if (n_dot <= 0.5) {
                n_dot = 0.5;
                n_scale = n_dot / 0.9;
                var_f6b0cbe4 = n_scale * var_4a166ae5;
                var_ac3d0ec3 = 0.3 + var_f6b0cbe4;
                var_887c2fcb = 1;
            } else {
                n_scale = n_dot / 0.9;
                var_f6b0cbe4 = n_scale * var_4a166ae5;
                var_ac3d0ec3 = 0.3 + var_f6b0cbe4;
                var_887c2fcb = 1;
            }
        } else {
            var_ac3d0ec3 = undefined;
        }
        if (level flag::get("idgun_cocoon_" + var_3fbc06aa + "_found")) {
            return;
        }
        if (isdefined(var_ac3d0ec3)) {
            wait(var_ac3d0ec3);
            self namespace_8e578893::function_6edf48d5(2);
            util::wait_network_frame();
            self namespace_8e578893::function_6edf48d5(0);
            continue;
        }
        wait(0.05);
    }
}

// Namespace namespace_54bf13f5
// Params 1, eflags: 0x1 linked
// Checksum 0xdb675b88, Offset: 0x22d8
// Size: 0x17c
function function_eaadff84(var_f7cef040) {
    if (var_f7cef040 == 0) {
        var_566556d8 = getweapon(level.var_42517170[0].var_e4be281f);
    } else {
        var_566556d8 = getweapon(level.var_42517170[0].var_e4be281f);
        var_566556d8 = zm_weapons::get_upgrade_weapon(var_566556d8, 0);
    }
    assert(isdefined(var_566556d8));
    self zm_weapons::weapon_give(var_566556d8, 0, 0);
    self switchtoweapon(var_566556d8);
    if (!isdefined(level.var_42517170[0].owner)) {
        var_6aa62cd2 = 0;
    } else if (!isdefined(level.var_42517170[1].owner)) {
        var_6aa62cd2 = 1;
    } else {
        return;
    }
    level.var_42517170[var_6aa62cd2].owner = self;
    self namespace_b8707f8e::function_aca1bc0c(0);
}

/#

    // Namespace namespace_54bf13f5
    // Params 0, eflags: 0x1 linked
    // Checksum 0xea757c4e, Offset: 0x2460
    // Size: 0xac
    function function_1c946455() {
        level thread namespace_8e578893::function_72260d3a("idgun_3", "idgun_3", 0, &function_9e990d87);
        level thread namespace_8e578893::function_72260d3a("idgun_3", "idgun_3", 1, &function_9e990d87);
        level thread namespace_8e578893::function_72260d3a("idgun_3", "idgun_3", 1, &function_8c7ac1b9);
    }

    // Namespace namespace_54bf13f5
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8ad5c04e, Offset: 0x2518
    // Size: 0x3c
    function function_e4e5cd30() {
        level thread namespace_8e578893::function_72260d3a("idgun_3", "idgun_3", 0, &function_1f7b4ebf);
    }

    // Namespace namespace_54bf13f5
    // Params 1, eflags: 0x1 linked
    // Checksum 0xf26f30e3, Offset: 0x2560
    // Size: 0xaa
    function function_9e990d87(n_value) {
        foreach (e_player in level.players) {
            e_player function_eaadff84(n_value);
            util::wait_network_frame();
        }
    }

    // Namespace namespace_54bf13f5
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb3198b8e, Offset: 0x2618
    // Size: 0x2c
    function function_1f7b4ebf(n_val) {
        level flag::set("idgun_3");
    }

    // Namespace namespace_54bf13f5
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3ccd0851, Offset: 0x2650
    // Size: 0x3c
    function function_8c7ac1b9(n_value) {
        if (isdefined(level.idgun_draw_debug)) {
            level.idgun_draw_debug = !level.idgun_draw_debug;
            return;
        }
        level.idgun_draw_debug = 1;
    }

#/
