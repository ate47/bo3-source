#using scripts/codescripts/struct;
#using scripts/cp/_debug;
#using scripts/cp/_dialog;
#using scripts/cp/_hacking;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_aquifer;
#using scripts/cp/cp_mi_cairo_aquifer_interior;
#using scripts/cp/cp_mi_cairo_aquifer_objectives;
#using scripts/cp/cp_mi_cairo_aquifer_sound;
#using scripts/cp/cp_mi_cairo_aquifer_utility;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai_shared;
#using scripts/shared/ai_sniper_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace cp_mi_cairo_aquifer_boss;

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0x35061e4e, Offset: 0xd28
// Size: 0x5c
function start_boss() {
    thread function_510d0407();
    level flag::wait_till("start_battle");
    thread function_5358c20("hendricks");
    thread function_a54075c1();
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 1, eflags: 0x0
// Checksum 0xddd00107, Offset: 0xd90
// Size: 0x10c
function function_5f8efef1(ent) {
    ent endon(#"death");
    while (!level flag::get("end_battle")) {
        offset = (0, 0, 60);
        icon_type = "defend";
        if (isdefined(ent._laststand) && ent._laststand) {
            offset = (0, 0, 30);
            icon_type = "return";
        }
        level.var_5aa7773 = objectives::function_fe46cd6(icon_type, "ally_defend", ent.origin + offset);
        wait 0.05;
    }
    level.var_5aa7773 objectives::function_ac28ba8e();
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 1, eflags: 0x0
// Checksum 0xdd93b2f0, Offset: 0xea8
// Size: 0xd4
function function_5358c20(name) {
    guy = level.hendricks;
    level.var_a6529009 = guy;
    level.var_8781baf = 0;
    guy.var_be1d7b0d = 0;
    guy util::magic_bullet_shield();
    ai::createinterfaceforentity(guy);
    guy ai::set_behavior_attribute("sprint", 1);
    level.hendricks battlechatter::function_d9f49fba(1);
    thread function_567a5fa();
    thread function_7a57d63a();
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 1, eflags: 0x0
// Checksum 0xa5efc958, Offset: 0xf88
// Size: 0x56
function function_5dd0c951(arr) {
    for (i = 0; i < arr.size; i++) {
        level.var_a6529009 function_519d76bc(arr, i);
    }
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 2, eflags: 0x0
// Checksum 0xe1526964, Offset: 0xfe8
// Size: 0x56
function function_519d76bc(array, num) {
    self dialog::say(array[num]);
    num++;
    if (num >= array.size) {
        num = 0;
    }
    return num;
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 1, eflags: 0x0
// Checksum 0xc4556447, Offset: 0x1048
// Size: 0xec
function function_f9d87307(name) {
    var_52aea43b = struct::get(name, "targetname");
    points = [];
    start = var_52aea43b;
    while (isdefined(var_52aea43b)) {
        points[points.size] = var_52aea43b.origin;
        if (!isdefined(var_52aea43b.target)) {
            break;
        }
        var_52aea43b = struct::get(var_52aea43b.target, "targetname");
        if (isdefined(var_52aea43b) && var_52aea43b == start) {
            break;
        }
    }
    level.var_a86d0056 = points;
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0x14d9780e, Offset: 0x1140
// Size: 0x54
function function_7c54d87d() {
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self thread ai_sniper::function_6840179(level.var_a86d0056);
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0x2ba7f72e, Offset: 0x11a0
// Size: 0x830
function function_a54075c1() {
    level endon(#"start_finale");
    var_9024513d = [];
    var_9024513d[0] = "hend_we_ve_got_company_0";
    var_9024513d[1] = "hend_tangoes_on_the_floor_0";
    var_9024513d[2] = "hend_more_enemies_inbound_0";
    var_9024513d[3] = "hend_heads_up_more_tango_0";
    var_9024513d[4] = "hend_watch_those_doors_0";
    var_2a935cb6 = 0;
    level.turret = getent("veh_turret", "targetname");
    level.turret setmaxhealth(9999);
    level.turret vehicle::god_on();
    level.sniper_boss = spawner::simple_spawn_single("hyperion");
    level.sniper_boss util::magic_bullet_shield();
    level.sniper_boss cybercom::function_58c312f2();
    level.sniper_boss ai::set_ignoreall(1);
    level.sniper_boss disableaimassist();
    level.sniper_boss notsolid();
    level.sniper_boss.var_dfa3c2cb = 2;
    level.sniper_boss.baseaccuracy = 9999;
    level.sniper_boss.accuracy = 1;
    level.sniper_boss ai::disable_pain();
    level.var_6447d0d2 = 0;
    level.var_c987bca = 0;
    level.sniper_boss.var_dfa3c2cb = 0;
    level.sniper_boss.var_815502c4 = 1;
    level.sniper_boss.var_26c21ea3 = 10;
    level.sniper_boss.var_65de9253 = 0;
    level.var_7d7334f = [];
    level flag::set("sniper_boss_spawned");
    thread function_6800ac1d();
    thread function_80b6b7eb();
    level.var_ed93c81c = [];
    level.var_ed93c81c[0] = array("sniper_spot_1_1");
    level.var_b8219f59 = array("wave_a", "wave_b", "wave_c");
    level.var_f1ee7b0e = 0;
    level.var_d56cb109 = -1;
    var_a4d5f340 = 7;
    level.var_8f1f476d = "wave_a";
    new_spot = 0;
    level.sniper_boss show();
    level.turret turret::enable_laser(1, 0);
    level.var_c987bca = 1;
    level.sniper_boss function_479d0795(level.sniper_boss.origin);
    wait 2;
    var_66ab2260 = getentarray("1st_barrel", "script_noteworthy");
    foreach (sm in var_66ab2260) {
        if (sm.targetname == "destructible") {
            var_39c2c150 = sm;
        }
    }
    if (isdefined(var_39c2c150)) {
        level.sniper_boss.var_9eb700da notify(#"hash_5ee81302");
        level.sniper_boss.var_9eb700da thread ai_sniper::function_e57ea743(level.sniper_boss geteye(), var_39c2c150, 1, level.sniper_boss, 1, 0);
        thread function_60e39f29(var_39c2c150);
        var_39c2c150 waittill(#"broken");
        level.sniper_boss.var_9eb700da notify(#"hash_e57ea743");
        level.sniper_boss.var_9eb700da.var_8722cfb = undefined;
        exploder::exploder("bossceiling_smk_level1");
        exploder::exploder("lighting_turbine_boss_03");
        level.sniper_boss ai_sniper::function_782962c5();
        wait 0.05;
    }
    function_e9aa8887();
    thread function_6ea369f7();
    for (reset = 1; !level flag::get("end_battle"); reset = 0) {
        if (new_spot) {
            switch (level.var_f1ee7b0e) {
            case 1:
                break;
            case 2:
                break;
            case 3:
                guys = getaiteamarray("axis");
                vol = getent("boss_end_vol", "targetname");
                foreach (guy in guys) {
                    guy setgoalvolume(vol);
                }
                break;
            }
            new_spot = 0;
        }
        event = level.sniper_boss util::waittill_any_timeout(var_a4d5f340, "sniper_suppressed", "sniper_disabled", "fire");
        if (event == "fire") {
            foreach (player in level.players) {
                player playsoundtoplayer("prj_crack", player);
            }
            reset = function_329f82a0();
            continue;
        }
    }
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 1, eflags: 0x0
// Checksum 0xe0c6e4c0, Offset: 0x19d8
// Size: 0x4c
function function_60e39f29(var_39c2c150) {
    level.sniper_boss waittill(#"fire");
    var_39c2c150 kill(level.sniper_boss.origin, level.sniper_boss);
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 1, eflags: 0x0
// Checksum 0x76660800, Offset: 0x1a30
// Size: 0xfc
function function_479d0795(var_81c506ec) {
    if (!isdefined(self.var_9eb700da)) {
        self.var_9eb700da = spawn("script_model", var_81c506ec);
        self.var_9eb700da setmodel("tag_origin");
        self.var_9eb700da.velocity = (100, 0, 0);
        self thread util::delete_on_death(self.var_9eb700da);
    }
    if (self.var_9eb700da.health <= 0) {
        self.var_9eb700da.health = 1;
    }
    self thread ai::shoot_at_target("shoot_until_target_dead", self.var_9eb700da);
    self.holdfire = 0;
    self.blindaim = 1;
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0x6879d669, Offset: 0x1b38
// Size: 0xfc
function function_e9aa8887() {
    level.var_d56cb109++;
    spots = function_f1889e69();
    if (level.var_d56cb109 >= spots.size) {
        level.var_d56cb109 = 0;
    }
    loc = getnode(spots[level.var_d56cb109], "targetname");
    level.var_1d4f0308 = loc;
    level.sniper_boss forceteleport(loc.origin, loc.angles);
    if (isdefined(loc.target)) {
        function_f9d87307(loc.target);
    }
    level.sniper_boss thread function_7c54d87d();
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0xe0006fdf, Offset: 0x1c40
// Size: 0x14
function function_f1889e69() {
    return level.var_ed93c81c[level.var_f1ee7b0e];
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0x2297ad1b, Offset: 0x1c60
// Size: 0xec
function function_c0010c33() {
    targets = getaiteamarray("axis");
    new_targets = [];
    foreach (target in targets) {
        if (isai(target) && !isvehicle(target)) {
            new_targets[new_targets.size] = target;
        }
    }
    return new_targets;
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 1, eflags: 0x0
// Checksum 0x8a22405c, Offset: 0x1d58
// Size: 0x146
function function_2e7e3fc7(origin) {
    targets = util::function_1edbd8();
    targets = targets.a;
    var_edaf6251 = [];
    foreach (player in targets) {
        if (sighttracepassed(origin, player gettagorigin("tag_eye"), 1, level.turret)) {
            var_edaf6251[var_edaf6251.size] = player;
        }
    }
    if (var_edaf6251.size > 0) {
        target_num = randomintrange(0, var_edaf6251.size);
        return var_edaf6251[target_num];
    }
    return undefined;
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0x41c56035, Offset: 0x1ea8
// Size: 0xac
function function_5e9e2b2e() {
    loc = randomint(level.var_a40b1280.size);
    var_7b1be7eb = level.var_a40b1280[loc];
    if (!isdefined(level.var_5f912d03) || var_7b1be7eb == level.var_5f912d03) {
        loc += 1;
        if (loc >= level.var_a40b1280.size) {
            loc = 0;
        }
    }
    function_eea4755(loc);
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 1, eflags: 0x0
// Checksum 0x1a5f6f03, Offset: 0x1f60
// Size: 0xf4
function function_eea4755(index) {
    level notify(#"hash_7bb65964");
    level.sniper_target = level.var_a6529009;
    level.var_b9c6c6b1 = undefined;
    if (index >= 0 && index < level.var_a40b1280.size) {
        level.var_5f912d03 = level.var_a40b1280[index];
        level.var_19a4e0ef = getent(level.var_5f912d03.target, "targetname");
        level.turret.origin = level.var_5f912d03.origin - (0, 0, 32);
        if (!isdefined(level.var_19a4e0ef)) {
            assertmsg("<dev string:x28>");
        }
    }
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 1, eflags: 0x0
// Checksum 0x82df51de, Offset: 0x2060
// Size: 0x2a
function function_e4623bda(duration) {
    level endon(#"hash_2b459237");
    wait duration;
    level notify(#"hash_602b2f5b");
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0xc25f76a, Offset: 0x2098
// Size: 0x3a
function function_38600307() {
    level endon(#"hash_2b459237");
    level endon(#"hash_7bb65964");
    level.var_19a4e0ef waittill(#"damage");
    level notify(#"hash_2b459237");
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 2, eflags: 0x0
// Checksum 0x3effbb83, Offset: 0x20e0
// Size: 0x10e
function function_6485b136(player, delay) {
    if (!isdefined(delay)) {
        delay = 0;
    }
    if (!isdefined(level.sniper_boss.player_target) || !level.sniper_boss.var_65de9253 && level.sniper_boss.player_target != player) {
        var_833c5770 = level.sniper_boss.var_dfa3c2cb;
        level.sniper_boss.var_dfa3c2cb = delay;
        level.sniper_boss.var_9eb700da ai_sniper::function_e57ea743(level.sniper_boss geteye(), player, 1, level.sniper_boss, 1, 0);
        level.sniper_boss.var_dfa3c2cb = var_833c5770;
        level.sniper_boss.player_target = undefined;
    }
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0x3c3b2c59, Offset: 0x21f8
// Size: 0x58
function function_fe242426() {
    while (true) {
        debug::debug_sphere(level.sniper_boss.var_9eb700da.origin, 20, (255, 0, 255), 10, 10);
        wait 0.1;
    }
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 1, eflags: 0x0
// Checksum 0x1ba74d10, Offset: 0x2258
// Size: 0xda
function function_c6b25cd0(trigger) {
    var_31214672 = [];
    players = getplayers();
    foreach (player in players) {
        if (player istouching(trigger)) {
            var_31214672[var_31214672.size] = player;
        }
    }
    return var_31214672;
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 4, eflags: 0x0
// Checksum 0x329ed654, Offset: 0x2340
// Size: 0x44
function function_2dcd0b86(frompoint, topoint, color, durationframes) {
    as_debug::drawdebuglineinternal(frompoint, topoint, color, durationframes);
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 2, eflags: 0x0
// Checksum 0x12f6fcc4, Offset: 0x2390
// Size: 0x46
function function_c5ba7a9b(e1, e2) {
    a = [];
    a[0] = e1;
    a[1] = e2;
    return a;
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0xdc5c8742, Offset: 0x23e0
// Size: 0x154
function end_battle() {
    exploder::exploder("lighting_turbine_boss_emergency");
    level.hendricks dialog::say("hend_that_should_do_it_0");
    thread function_c3af0181();
    level flag::set("boss_finale_ready");
    trig = getent("boss_finale_trigger", "targetname");
    trig triggerenable(1);
    trig.var_611ccff1 = util::function_14518e76(trig, %cp_level_aquifer_capture_door, %CP_MI_CAIRO_AQUIFER_BREACH, &function_479374a3);
    trig.var_611ccff1 gameobjects::set_use_time(0.35);
    level waittill(#"start_finale");
    trig.var_611ccff1 gameobjects::disable_object();
    trig triggerenable(0);
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0xe2732c65, Offset: 0x2540
// Size: 0x534
function function_479374a3() {
    util::function_d8eaed3d(10);
    namespace_84eb777e::function_5ec99c19("cp_level_aquifer_boss");
    level notify(#"start_finale");
    level.sniper_boss show();
    level.sniper_boss util::stop_magic_bullet_shield();
    guys = getaiteamarray("axis");
    guys = array::exclude(guys, array(level.sniper_boss));
    if (isdefined(level.var_3e0291d0)) {
        [[ level.var_3e0291d0 ]]();
    }
    array::thread_all(guys, &aquifer_util::delete_me);
    struct = getent("hyperion_death_origin", "targetname");
    if (isdefined(level.var_1ff0137d)) {
        level thread [[ level.var_1ff0137d ]]();
    }
    ent = getent("control_window_shatter_01", "targetname");
    if (isdefined(ent)) {
        ent hide();
    }
    door = getent("boss_hideaway_door", "targetname");
    level thread namespace_71a63eac::function_e0e00797();
    a_ents = [];
    if (!isdefined(a_ents)) {
        a_ents = [];
    } else if (!isarray(a_ents)) {
        a_ents = array(a_ents);
    }
    a_ents[a_ents.size] = self.trigger.who;
    a_ents["hyperion"] = level.sniper_boss;
    scene::add_scene_func("cin_aqu_07_01_maretti_1st_dropit", &function_f3ee81ce, "skip_started");
    struct scene::play("cin_aqu_07_01_maretti_1st_dropit", a_ents);
    aquifer_util::function_2085bf94("boss_death_models", 1);
    thread function_2a39915e();
    level util::clientnotify("start_boss_tree");
    exploder::exploder("lgt_tree_glow_01");
    if (!level flag::get("sniper_boss_skipped")) {
        array::thread_all(level.activeplayers, &aquifer_util::function_89eaa1b3, 0.5);
    }
    if (isdefined(level.var_3e0291d0)) {
        [[ level.var_3e0291d0 ]]();
    }
    struct scene::play("cin_aqu_05_20_boss_3rd_death_sh010", level.sniper_boss);
    if (isdefined(level.var_3e0291d0)) {
        [[ level.var_3e0291d0 ]]();
    }
    level waittill(#"hash_94cdf46c");
    if (isdefined(level.var_3e0291d0)) {
        [[ level.var_3e0291d0 ]]();
    }
    thread util::screen_fade_out(0.75);
    exploder::stop_exploder("lgt_tree_glow_01");
    level waittill(#"hash_595107d2");
    if (isdefined(level.var_3e0291d0)) {
        [[ level.var_3e0291d0 ]]();
    }
    exploder::stop_exploder("lighting_turbine_boss_emergency");
    level clientfield::set("toggle_fog_banks", 0);
    thread cp_mi_cairo_aquifer_interior::function_1d5b05a();
    level.hendricks ai::set_behavior_attribute("cqb", 0);
    thread util::screen_fade_in(0.5);
    level flag::set("hyperion_start_tree_scene");
    aquifer_util::function_75ab4ede(1);
    util::clear_streamer_hint();
    level.sniper_boss kill();
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 1, eflags: 0x0
// Checksum 0x51f8085e, Offset: 0x2a80
// Size: 0x2c
function function_f3ee81ce(a_ents) {
    level flag::set("sniper_boss_skipped");
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0xaa422202, Offset: 0x2ab8
// Size: 0x5c
function function_2a39915e() {
    level waittill(#"hash_6f76bd0d");
    if (!level flag::get("sniper_boss_skipped")) {
        array::thread_all(level.activeplayers, &aquifer_util::function_89eaa1b3, 1);
    }
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0xdae8e5b1, Offset: 0x2b20
// Size: 0xc2
function function_510d0407() {
    ents = getentarray("fire_maker", "script_noteworthy");
    level.var_510d0407 = ents;
    foreach (ent in ents) {
        ent thread function_d1b143ce();
    }
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0x8e0965f0, Offset: 0x2bf0
// Size: 0x204
function function_d1b143ce() {
    var_e42db353 = undefined;
    if (isdefined(self.target)) {
        var_e42db353 = getent(self.target, "targetname");
        var_e42db353 triggerenable(0);
        self.target = undefined;
    }
    ent = spawnstruct();
    ent.origin = self.origin;
    ent.angles = self.angles;
    fx = "boss_fire";
    if (isdefined(self.script_parameters)) {
        fx = self.script_parameters;
    }
    self waittill(#"broken");
    arrayremovevalue(level.var_510d0407, self);
    if (isdefined(var_e42db353)) {
        var_e42db353 triggerenable(1);
        badplace_cylinder(var_e42db353.targetname, -1, ent.origin, 110, 64, "all");
    }
    if (fx == "boss_fire") {
        playfx(level._effect[fx], ent.origin, anglestoforward(ent.angles), anglestoup(ent.angles));
        return;
    }
    exploder::exploder(fx);
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0x58f76717, Offset: 0x2e00
// Size: 0x22c
function function_e146f6ef() {
    best_dist = 0;
    var_39c2c150 = undefined;
    eyepos = level.sniper_boss geteye();
    foreach (ent in level.var_510d0407) {
        if (isdefined(ent) && isalive(ent)) {
            dist = function_ca9c8f2b(ent.origin);
            if ((best_dist == 0 || level.var_c987bca && dist < best_dist) && sighttracepassed(eyepos, ent.origin, 0, undefined)) {
                best_dist = dist;
                var_39c2c150 = ent;
            }
        }
    }
    if (isdefined(var_39c2c150)) {
        level.sniper_boss.var_9eb700da notify(#"hash_565daac6");
        level.sniper_boss.var_9eb700da notify(#"hash_e57ea743");
        level.sniper_boss.var_9eb700da notify(#"hash_5ee81302");
        wait 0.1;
        if (isdefined(var_39c2c150)) {
            level.sniper_boss.var_9eb700da ai_sniper::function_e57ea743(level.sniper_boss geteye(), var_39c2c150, 1, level.sniper_boss, 1, 0);
            return true;
        }
    }
    return false;
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 1, eflags: 0x0
// Checksum 0x3675e211, Offset: 0x3038
// Size: 0xe6
function function_ca9c8f2b(org) {
    shortest = 0;
    foreach (guy in level.activeplayers) {
        dist = distancesquared(guy.origin, org);
        if (shortest == 0 || dist < shortest) {
            shortest = dist;
        }
    }
    return shortest;
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0xc06d7518, Offset: 0x3128
// Size: 0x1cc
function function_329f82a0() {
    if (isdefined(level.sniper_boss.var_9eb700da.var_8722cfb)) {
        target = level.sniper_boss.var_9eb700da.var_8722cfb;
        fwd = anglestoforward(level.sniper_boss.angles);
        target_org = target.origin + (0, 0, 10);
        if (isplayer(target)) {
            var_f769885c = (0, 0, 0);
            accuracy = target function_3375c23();
            accuracy *= 100;
            if (accuracy < randomfloat(100)) {
                var_f769885c = (randomfloat(100) - 50, 0, 16);
            }
            target_org = target geteye() + (0, 0, -6) + var_f769885c;
        }
        magicbullet(getweapon("sniper_hyperion"), level.sniper_boss geteye() + fwd * 20, target_org, level.sniper_boss);
        return true;
    }
    return false;
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0x9f2ad4a, Offset: 0x3300
// Size: 0xd4
function function_6ea369f7() {
    trig = getent("sniper_alley", "targetname");
    while (!level flag::get("end_battle")) {
        trig waittill(#"trigger", who);
        if (isplayer(who) && isalive(who)) {
            if (!isdefined(level.sniper_boss.player_target)) {
                function_6485b136(who, 2);
            }
        }
    }
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0x7e3aee9, Offset: 0x33e0
// Size: 0x2ec
function function_6800ac1d() {
    trig = getent("boss_hack1", "targetname");
    var_d8ef108f = getent("boss_hack2", "targetname");
    trig triggerenable(1);
    var_d8ef108f triggerenable(0);
    namespace_84eb777e::function_4d816f2c("cp_level_aquifer_boss");
    trig.var_611ccff1 = trig hacking::function_68df65d8(5, %cp_level_aquifer_boss_gen1, %CP_MI_CAIRO_AQUIFER_HOLD_OVERLOAD, &function_e9c4785f);
    thread function_a354fb63(1);
    level.var_fc9a3509 = 1;
    level waittill(#"hash_e9c4785f");
    thread savegame::checkpoint_save();
    trig.var_611ccff1 gameobjects::disable_object();
    var_d8ef108f.var_611ccff1 = var_d8ef108f hacking::function_68df65d8(5, %cp_level_aquifer_boss_gen2, %CP_MI_CAIRO_AQUIFER_HOLD_OVERLOAD, &function_e9c4785f);
    thread function_a354fb63(2);
    scene::init("cin_aqu_07_01_maretti_1st_dropit");
    level waittill(#"hash_e9c4785f");
    thread savegame::checkpoint_save();
    var_d8ef108f.var_611ccff1 gameobjects::disable_object();
    wait 1.5;
    struct = getent("hyperion_death_origin", "targetname");
    struct thread scene::play("cin_aqu_05_20_boss_3rd_death_debris");
    wait 2.5;
    var_e42db353 = getent("boss_debris_hurter", "targetname");
    var_e42db353 triggerenable(1);
    aquifer_util::function_2085bf94("debris_clip", 0);
    wait 0.25;
    var_e42db353 triggerenable(0);
    end_battle();
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 1, eflags: 0x0
// Checksum 0x668c82c7, Offset: 0x36d8
// Size: 0x1a
function function_e9c4785f(gameobj) {
    level notify(#"hash_e9c4785f");
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 1, eflags: 0x0
// Checksum 0x5065867, Offset: 0x3700
// Size: 0x142
function function_dae6fcbf(name) {
    level endon(#"hash_221e0b70");
    var_b22ea724 = getentarray(name, "targetname");
    for (delay = 3; true; delay /= 2) {
        wait delay;
        var_51863d1e = randomint(5) + 2;
        for (i = 0; i < var_51863d1e; i++) {
            array::run_all(var_b22ea724, &hide);
            wait randomfloatrange(0.05, 0.2);
            array::run_all(var_b22ea724, &show);
            wait randomfloatrange(0.05, 0.2);
        }
    }
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 1, eflags: 0x0
// Checksum 0x24f15820, Offset: 0x3850
// Size: 0x480
function function_a354fb63(num) {
    b_success = 0;
    trig = getent("boss_hack" + (isdefined(num) ? "" + num : ""), "targetname");
    while (!b_success) {
        level.hacking flag::wait_till("in_progress");
        thread function_41ca61ef(num);
        level waittill(#"hash_221e0b70", b_success);
        if (!b_success) {
            level notify(#"hash_90029dea");
        }
        surge = "surge0" + (isdefined(num) ? "" + num : "");
        if (b_success) {
            level notify(#"gen1_done");
            exploder::exploder(surge + "_stage05");
            earthquake(0.5, 2, trig.origin, 2000);
            level thread cp_mi_cairo_aquifer_sound::function_e76f158();
            wait 0.25;
            exploder::stop_exploder(surge + "_stage01");
            exploder::stop_exploder(surge + "_stage02");
            exploder::stop_exploder(surge + "_stage03");
            exploder::stop_exploder(surge + "_stage04");
            switch (num) {
            case 1:
                exploder::exploder("lighting_sniper_boss_off_set01");
                var_b22ea724 = getentarray("reactor_lights_01", "targetname");
                array::run_all(var_b22ea724, &hide);
                wait 1;
                function_339776e2("bossbarrel_right01");
                wait 1.5;
                function_339776e2("bossbarrel_right02");
                break;
            case 2:
                exploder::exploder("lighting_sniper_boss_off_set02");
                exploder::exploder("lighting_boss_fire_transition");
                clientfield::set("toggle_fog_banks", 1);
                clientfield::set("toggle_pbg_banks", 1);
                var_b22ea724 = getentarray("reactor_lights_02", "targetname");
                array::run_all(var_b22ea724, &hide);
                wait 1.5;
                function_339776e2("bossbarrel_left03");
                wait 1;
                function_339776e2("bossbarrel_left02");
                break;
            }
        } else {
            level thread cp_mi_cairo_aquifer_sound::function_1024da0a();
            exploder::stop_exploder(surge + "_stage01");
            exploder::stop_exploder(surge + "_stage02");
            exploder::stop_exploder(surge + "_stage03");
            exploder::stop_exploder(surge + "_stage04");
        }
        wait 0.1;
    }
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 1, eflags: 0x0
// Checksum 0xefbd91a2, Offset: 0x3cd8
// Size: 0x5c
function function_339776e2(name) {
    ent = getent(name, "script_parameters");
    if (isdefined(ent)) {
        ent kill();
    }
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 1, eflags: 0x0
// Checksum 0xf4bc9fb2, Offset: 0x3d40
// Size: 0x14e
function function_41ca61ef(num) {
    level endon(#"hash_90029dea");
    thread function_dae6fcbf("reactor_lights_0" + (isdefined(num) ? "" + num : ""));
    level thread cp_mi_cairo_aquifer_sound::function_ad15f6f5();
    surge = "surge0" + (isdefined(num) ? "" + num : "");
    exploder::exploder(surge + "_stage01");
    wait 1;
    exploder::exploder(surge + "_stage02");
    wait 1;
    exploder::exploder(surge + "_stage03");
    wait 2;
    exploder::exploder(surge + "_stage04");
    wait 3;
    level notify(#"hash_2891cea2");
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0x4e15c84c, Offset: 0x3e98
// Size: 0x54
function function_567a5fa() {
    level waittill(#"hash_cd553ae9");
    wait 0.25;
    level.hendricks dialog::say("hend_maretti_s_locked_him_0");
    wait 3;
    thread function_269260a3();
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0x84b478ef, Offset: 0x3ef8
// Size: 0xf4
function boss_taunt1() {
    level endon(#"start_finale");
    level flag::wait_till("boss_taunt1");
    wait 3;
    level flag::set("boss_convo");
    level.hendricks dialog::say("hend_maretti_0");
    level.hendricks dialog::say("hend_maretti_listen_to_0", 1);
    level dialog::remote("mare_you_haven_t_learned_0", 0.2);
    level.hendricks dialog::say("hend_diaz_and_hall_are_de_0", 0.2);
    function_5e1c1c41();
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0x4f9666b, Offset: 0x3ff8
// Size: 0x13c
function boss_taunt2() {
    level endon(#"start_finale");
    level flag::wait_till("boss_taunt2");
    level flag::set("boss_convo");
    level dialog::remote("mare_aren_t_you_worried_a_0");
    level.hendricks dialog::say("hend_maretti_you_know_me_0", 0.5);
    level dialog::remote("mare_you_d_better_get_you_1", 1);
    level.hendricks dialog::say("hend_please_i_give_you_0", 0.2);
    function_5e1c1c41();
    wait 5;
    level flag::set("boss_convo");
    level dialog::remote("mare_bullet_to_the_head_l_1", 2);
    function_5e1c1c41();
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0x85064da4, Offset: 0x4140
// Size: 0xc4
function function_80b6b7eb() {
    thread boss_taunt1();
    thread boss_taunt2();
    level flag::wait_till_timeout(10, "boss_wave1");
    wait 5;
    level flag::set("boss_taunt1");
    level flag::wait_till("boss_wave1");
    level flag::wait_till_timeout(40, "boss_wave2");
    wait 5;
    level flag::set("boss_taunt2");
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0xeb0d0fcb, Offset: 0x4210
// Size: 0x24
function function_5e1c1c41() {
    wait 1;
    level flag::clear("boss_convo");
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 2, eflags: 0x0
// Checksum 0xb26722a1, Offset: 0x4240
// Size: 0xc8
function boss_vo(str_line, n_timeout) {
    if (!isdefined(n_timeout)) {
        n_timeout = -1;
    }
    if (n_timeout < 0) {
        level flag::wait_till_clear("boss_convo");
    } else {
        if (n_timeout > 0) {
            level flag::wait_till_clear_timeout(n_timeout, "boss_convo");
        }
        if (level flag::get("boss_convo")) {
            return false;
        }
    }
    self dialog::say(str_line);
    return true;
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 4, eflags: 0x0
// Checksum 0xb064fa55, Offset: 0x4310
// Size: 0xb6
function function_4463326b(var_d44c15f4, var_aa750b18, n_timeout, str_endon_notify) {
    if (!isdefined(var_aa750b18)) {
        var_aa750b18 = 10;
    }
    level endon(str_endon_notify);
    n_waittime = var_aa750b18;
    n_line = 0;
    while (n_line < var_d44c15f4.size) {
        wait n_waittime;
        level.hendricks boss_vo(var_d44c15f4[n_line], n_timeout);
        n_line++;
        n_waittime += 5;
    }
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0xcad9a3bd, Offset: 0x43d0
// Size: 0x17c
function function_269260a3() {
    var_3d2aa310 = [];
    if (!isdefined(var_3d2aa310)) {
        var_3d2aa310 = [];
    } else if (!isarray(var_3d2aa310)) {
        var_3d2aa310 = array(var_3d2aa310);
    }
    var_3d2aa310[var_3d2aa310.size] = "hend_overload_that_genera_0";
    if (!isdefined(var_3d2aa310)) {
        var_3d2aa310 = [];
    } else if (!isarray(var_3d2aa310)) {
        var_3d2aa310 = array(var_3d2aa310);
    }
    var_3d2aa310[var_3d2aa310.size] = "hend_we_need_that_generat_0";
    if (!isdefined(var_3d2aa310)) {
        var_3d2aa310 = [];
    } else if (!isarray(var_3d2aa310)) {
        var_3d2aa310 = array(var_3d2aa310);
    }
    var_3d2aa310[var_3d2aa310.size] = "hend_i_ll_cover_you_over_0";
    thread function_4463326b(var_3d2aa310, undefined, -1, "gen1_done");
    level waittill(#"gen1_done");
    function_86fc21bb();
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0xad13c5bd, Offset: 0x4558
// Size: 0xfc
function function_86fc21bb() {
    var_3d2aa310 = [];
    if (!isdefined(var_3d2aa310)) {
        var_3d2aa310 = [];
    } else if (!isarray(var_3d2aa310)) {
        var_3d2aa310 = array(var_3d2aa310);
    }
    var_3d2aa310[var_3d2aa310.size] = "hend_one_down_2";
    if (!isdefined(var_3d2aa310)) {
        var_3d2aa310 = [];
    } else if (!isarray(var_3d2aa310)) {
        var_3d2aa310 = array(var_3d2aa310);
    }
    var_3d2aa310[var_3d2aa310.size] = "hend_move_to_the_next_gen_0";
    thread function_4463326b(var_3d2aa310, undefined, -1, "gen1_done");
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0x62d99b0d, Offset: 0x4660
// Size: 0xfc
function function_c3af0181() {
    var_3d2aa310 = [];
    if (!isdefined(var_3d2aa310)) {
        var_3d2aa310 = [];
    } else if (!isarray(var_3d2aa310)) {
        var_3d2aa310 = array(var_3d2aa310);
    }
    var_3d2aa310[var_3d2aa310.size] = "hend_get_up_there_and_sec_0";
    if (!isdefined(var_3d2aa310)) {
        var_3d2aa310 = [];
    } else if (!isarray(var_3d2aa310)) {
        var_3d2aa310 = array(var_3d2aa310);
    }
    var_3d2aa310[var_3d2aa310.size] = "hend_there_s_a_path_to_ma_0";
    thread function_4463326b(var_3d2aa310, undefined, -1, "start_finale");
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 1, eflags: 0x0
// Checksum 0xd437b39d, Offset: 0x4768
// Size: 0x148
function function_ae438739(var_ecd4dcd7) {
    level endon(#"start_finale");
    level endon(#"death");
    nags = [];
    nags[0] = "hend_keep_your_head_down_1";
    nags[1] = "hend_watch_it_1";
    nags[2] = "hend_watch_that_laser_1";
    while (level.var_6343f89f < nags.size) {
        self waittill(#"damage", amount, attacker, dir, point, mod);
        if (attacker == level.sniper_boss && gettime() > level.var_9ef3831c + var_ecd4dcd7 * 1000) {
            said_line = level.hendricks boss_vo(nags[level.var_6343f89f], 2);
            if (said_line) {
                level.var_9ef3831c = gettime();
                level.var_6343f89f++;
            }
        }
    }
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0x802e4abc, Offset: 0x48b8
// Size: 0xaa
function function_7a57d63a() {
    level.var_9ef3831c = 0;
    level.var_6343f89f = 0;
    foreach (player in level.players) {
        player thread function_ae438739(5);
    }
}

// Namespace cp_mi_cairo_aquifer_boss
// Params 0, eflags: 0x0
// Checksum 0xb34a7035, Offset: 0x4970
// Size: 0x15c
function function_3375c23() {
    accuracy = 1;
    if (self issprinting()) {
        accuracy -= 0.1;
    }
    if (self issliding()) {
        accuracy -= 0.1;
    }
    player_vec = self getvelocity();
    speed = length(player_vec);
    if (speed > 100) {
        player_vec = self getnormalizedmovement();
        var_8aeaad8d = anglestoforward(level.sniper_boss.angles);
        dot = abs(vectordot(player_vec, var_8aeaad8d));
        accuracy -= (1 - dot) * 0.1;
    }
    return accuracy;
}

