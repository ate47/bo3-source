#using scripts/zm/zm_tomb_ee_main_step_8;
#using scripts/zm/zm_tomb_ee_main_step_7;
#using scripts/zm/zm_tomb_ee_main_step_6;
#using scripts/zm/zm_tomb_ee_main_step_5;
#using scripts/zm/zm_tomb_ee_main_step_4;
#using scripts/zm/zm_tomb_ee_main_step_3;
#using scripts/zm/zm_tomb_ee_main_step_2;
#using scripts/zm/zm_tomb_ee_main_step_1;
#using scripts/zm/zm_tomb_vo;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_ee_main;
#using scripts/zm/zm_tomb_craftables;
#using scripts/zm/zm_tomb_amb;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/util_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace zm_tomb_ee_main;

// Namespace zm_tomb_ee_main
// Params 0, eflags: 0x1 linked
// Checksum 0xafea48ff, Offset: 0x8d0
// Size: 0x374
function init() {
    clientfield::register("actor", "ee_zombie_fist_fx", 21000, 1, "int");
    clientfield::register("actor", "ee_zombie_soul_portal", 21000, 1, "int");
    clientfield::register("world", "ee_sam_portal", 21000, 2, "int");
    clientfield::register("vehicle", "ee_plane_fx", 21000, 1, "int");
    clientfield::register("world", "TombEndGameBlackScreen", 21000, 1, "int");
    level flag::init("ee_all_staffs_crafted");
    level flag::init("ee_all_staffs_upgraded");
    level flag::init("ee_all_staffs_placed");
    level flag::init("ee_mech_zombie_hole_opened");
    level flag::init("ee_mech_zombie_fight_completed");
    level flag::init("ee_maxis_drone_retrieved");
    level flag::init("ee_all_players_upgraded_punch");
    level flag::init("ee_souls_absorbed");
    level flag::init("ee_samantha_released");
    level flag::init("ee_quadrotor_disabled");
    level flag::init("ee_sam_portal_active");
    if (!namespace_6e97c459::function_1337b040("zclassic")) {
        return;
    }
    /#
        level thread function_670b87e0();
    #/
    namespace_6e97c459::function_f59cfc65("little_girl_lost", &function_bb41e83b, &function_9b08126d, &function_e4eeb8b4, &function_c1d310ea, &function_cbdd7a61);
    zm_tomb_ee_main_step_1::init();
    zm_tomb_ee_main_step_2::init();
    zm_tomb_ee_main_step_3::init();
    zm_tomb_ee_main_step_4::init();
    zm_tomb_ee_main_step_5::init();
    zm_tomb_ee_main_step_6::init();
    zm_tomb_ee_main_step_7::init();
    zm_tomb_ee_main_step_8::init();
}

// Namespace zm_tomb_ee_main
// Params 0, eflags: 0x1 linked
// Checksum 0x4bdea872, Offset: 0xc50
// Size: 0x3c
function main() {
    level flag::wait_till("start_zombie_round_logic");
    namespace_6e97c459::function_d9be8a5b("little_girl_lost");
}

// Namespace zm_tomb_ee_main
// Params 0, eflags: 0x1 linked
// Checksum 0xa387ee0f, Offset: 0xc98
// Size: 0x1c
function function_bb41e83b() {
    level.var_102fa6cf = 0;
    level.var_5ec263fe = 0;
}

// Namespace zm_tomb_ee_main
// Params 0, eflags: 0x1 linked
// Checksum 0xa87c316, Offset: 0xcc0
// Size: 0x280
function function_9b08126d() {
    level.var_ca733eed = "step_0";
    level flag::wait_till("ee_all_staffs_crafted");
    level flag::wait_till("all_zones_captured");
    level.var_102fa6cf++;
    level thread function_de11f1ca();
    namespace_6e97c459::function_c09cb660("little_girl_lost", "step_1");
    level waittill(#"hash_e0898539");
    namespace_6e97c459::function_c09cb660("little_girl_lost", "step_2");
    level waittill(#"hash_dc144054");
    level thread zm_tomb_amb::function_23155012("ee_main_1");
    namespace_6e97c459::function_c09cb660("little_girl_lost", "step_3");
    level waittill(#"hash_972e03ef");
    level thread zm_tomb_amb::function_23155012("ee_main_2");
    namespace_6e97c459::function_c09cb660("little_girl_lost", "step_4");
    level waittill(#"hash_f397975a");
    level thread zm_tomb_amb::function_23155012("ee_main_3");
    namespace_6e97c459::function_c09cb660("little_girl_lost", "step_5");
    level waittill(#"hash_5fff9bfd");
    level thread zm_tomb_amb::function_23155012("ee_main_4");
    namespace_6e97c459::function_c09cb660("little_girl_lost", "step_6");
    level waittill(#"hash_9130e1d8");
    level thread zm_tomb_amb::function_23155012("ee_main_5");
    namespace_6e97c459::function_c09cb660("little_girl_lost", "step_7");
    level waittill(#"hash_26f53c83");
    level thread zm_tomb_amb::function_23155012("ee_main_6");
    namespace_6e97c459::function_c09cb660("little_girl_lost", "step_8");
    level waittill(#"hash_11477e");
}

// Namespace zm_tomb_ee_main
// Params 0, eflags: 0x1 linked
// Checksum 0x9543f944, Offset: 0xf48
// Size: 0x3e0
function function_de11f1ca() {
    var_ea2003d9 = level.var_102fa6cf;
    var_4e3c2af6[0] = 0;
    var_4e3c2af6[1] = 0;
    var_4e3c2af6[2] = 0;
    var_4e3c2af6[3] = 0;
    while (!level flag::get("ee_samantha_released")) {
        e_player = level waittill(#"player_zombie_blood");
        if (var_ea2003d9 != level.var_102fa6cf) {
            var_ea2003d9 = level.var_102fa6cf;
            for (i = 0; i < var_4e3c2af6.size; i++) {
                var_4e3c2af6[i] = 0;
            }
        }
        if (!var_4e3c2af6[e_player.characterindex]) {
            wait randomfloatrange(3, 7);
            if (isdefined(e_player.var_98401a1a) && e_player.var_98401a1a) {
                continue;
            }
            while (isdefined(level.var_8c80bd85) && level.var_8c80bd85) {
                wait 0.05;
            }
            if (isdefined(e_player) && isplayer(e_player) && e_player.zombie_vars["zombie_powerup_zombie_blood_on"]) {
                var_4e3c2af6[e_player.characterindex] = 1;
                zm_tomb_vo::function_eee384d4(1);
                level.var_8c80bd85 = 1;
                str_vox = function_5a1bf759();
                e_player playsoundtoplayer(str_vox, e_player);
                n_duration = soundgetplaybacktime(str_vox);
                wait n_duration / 1000;
                level.var_8c80bd85 = 0;
                zm_tomb_vo::function_eee384d4(0);
            }
            continue;
        }
        if (randomint(100) < 20) {
            wait randomfloatrange(3, 7);
            if (isdefined(e_player.var_98401a1a) && e_player.var_98401a1a) {
                continue;
            }
            while (isdefined(level.var_8c80bd85) && level.var_8c80bd85) {
                wait 0.05;
            }
            if (isdefined(e_player) && isplayer(e_player) && e_player.zombie_vars["zombie_powerup_zombie_blood_on"]) {
                str_vox = function_dd614043();
                if (isdefined(str_vox)) {
                    zm_tomb_vo::function_eee384d4(1);
                    level.var_8c80bd85 = 1;
                    e_player playsoundtoplayer(str_vox, e_player);
                    n_duration = soundgetplaybacktime(str_vox);
                    wait n_duration / 1000;
                    level.var_8c80bd85 = 0;
                    zm_tomb_vo::function_eee384d4(0);
                }
            }
        }
    }
}

// Namespace zm_tomb_ee_main
// Params 0, eflags: 0x1 linked
// Checksum 0xa1c5980f, Offset: 0x1330
// Size: 0x4e
function function_95a742c() {
    switch (level.var_102fa6cf) {
    case 1:
        return "vox_sam_all_staff_upgrade_key_0";
    case 2:
        return "vox_sam_all_staff_ascend_darkness_0";
    case 3:
        return "vox_sam_all_staff_rain_fire_0";
    case 4:
        return "vox_sam_all_staff_unleash_hoard_0";
    case 5:
        return "vox_sam_all_staff_skewer_beast_0";
    case 6:
        return "vox_sam_all_staff_fist_iron_0";
    case 7:
        return "vox_sam_all_staff_raise_hell_0";
    default:
        return undefined;
    }
}

// Namespace zm_tomb_ee_main
// Params 0, eflags: 0x1 linked
// Checksum 0xd702fb28, Offset: 0x13d0
// Size: 0x5c
function function_5a1bf759() {
    if (level flag::get("all_zones_captured")) {
        return ("vox_sam_upgrade_staff_clue_" + level.var_102fa6cf + "_0");
    }
    return "vox_sam_upgrade_staff_clue_" + level.var_102fa6cf + "_grbld_0";
}

// Namespace zm_tomb_ee_main
// Params 0, eflags: 0x1 linked
// Checksum 0xcdebaaa4, Offset: 0x1438
// Size: 0xd8
function function_dd614043() {
    if (!isdefined(level.var_699169f9)) {
        level.var_699169f9 = 0;
    }
    var_a7254166[0] = "vox_sam_heard_by_all_1_0";
    var_a7254166[1] = "vox_sam_heard_by_all_2_0";
    var_a7254166[2] = "vox_sam_heard_by_all_3_0";
    var_a7254166[3] = "vox_sam_slow_progress_0";
    var_a7254166[4] = "vox_sam_slow_progress_2";
    var_a7254166[5] = "vox_sam_slow_progress_3";
    if (level.var_699169f9 >= var_a7254166.size) {
        return undefined;
    }
    str_vo = var_a7254166[level.var_699169f9];
    level.var_699169f9++;
    return str_vo;
}

// Namespace zm_tomb_ee_main
// Params 0, eflags: 0x1 linked
// Checksum 0x32d747dd, Offset: 0x1518
// Size: 0x2ea
function function_e4eeb8b4() {
    level lui::prime_movie("zm_outro_tomb", 0, "");
    level.var_db35220f = "game_over_ee";
    a_players = getplayers();
    foreach (player in a_players) {
        player freezecontrols(1);
        player enableinvulnerability();
    }
    level flag::clear("spawn_zombies");
    level thread function_ab51bfd();
    playsoundatposition("zmb_squest_whiteout", (0, 0, 0));
    level lui::screen_fade_out(1, "white", "starting_ee_screen");
    util::delay(0.5, undefined, &function_126afda0);
    level thread lui::play_movie("zm_outro_tomb", "fullscreen", 0, 0, "");
    level lui::screen_fade_out(0, "black", "starting_ee_screen");
    level waittill(#"movie_done");
    level.custom_intermission = &function_94bc582e;
    level notify(#"end_game");
    level thread lui::screen_fade_in(2, "black", "starting_ee_screen");
    wait 1.5;
    foreach (player in a_players) {
        player freezecontrols(0);
        player disableinvulnerability();
    }
}

// Namespace zm_tomb_ee_main
// Params 1, eflags: 0x0
// Checksum 0x1fbca3d, Offset: 0x1810
// Size: 0x2c
function function_202bf99e(var_87423d00) {
    self endon(#"end_game");
    self lui::screen_fade_in(var_87423d00);
}

// Namespace zm_tomb_ee_main
// Params 0, eflags: 0x1 linked
// Checksum 0x18a1cb50, Offset: 0x1848
// Size: 0x2c
function function_126afda0() {
    if (isdefined(level.var_d53c56c8)) {
        level.var_d53c56c8 delete();
    }
}

// Namespace zm_tomb_ee_main
// Params 0, eflags: 0x1 linked
// Checksum 0xdd48341, Offset: 0x1880
// Size: 0x44
function function_c1d310ea() {
    str_vox = function_95a742c();
    if (isdefined(str_vox)) {
        level thread function_13f8b19b(str_vox);
    }
}

// Namespace zm_tomb_ee_main
// Params 0, eflags: 0x1 linked
// Checksum 0x2be560b1, Offset: 0x18d0
// Size: 0x5c
function function_cbdd7a61() {
    level.var_102fa6cf++;
    if (level.var_102fa6cf <= 6) {
        level flag::wait_till("all_zones_captured");
    }
    util::wait_network_frame();
    util::wait_network_frame();
}

// Namespace zm_tomb_ee_main
// Params 0, eflags: 0x1 linked
// Checksum 0xe989e181, Offset: 0x1938
// Size: 0xc6
function function_f8ba2e08() {
    var_c88bbd58 = 0;
    foreach (staff in level.var_b0d8f1fe) {
        if (staff.upgrade.var_43f3f5e5.var_2d46dee8) {
            var_c88bbd58++;
        }
    }
    if (var_c88bbd58 == 4) {
        return 1;
    }
    return 0;
}

// Namespace zm_tomb_ee_main
// Params 1, eflags: 0x1 linked
// Checksum 0xc5cb19d3, Offset: 0x1a08
// Size: 0xcc
function function_13f8b19b(str_vox) {
    level flag::wait_till_clear("story_vo_playing");
    level flag::set("story_vo_playing");
    zm_tomb_vo::function_eee384d4(1);
    zm_tomb_vo::function_10d15bb5(str_vox, getplayers()[0]);
    zm_tomb_vo::function_eee384d4(0);
    level flag::clear("story_vo_playing");
}

// Namespace zm_tomb_ee_main
// Params 0, eflags: 0x1 linked
// Checksum 0xde1d59b2, Offset: 0x1ae0
// Size: 0x622
function function_94bc582e() {
    self closeingamemenu();
    level endon(#"stop_intermission");
    self endon(#"disconnect");
    self endon(#"death");
    self notify(#"_zombie_game_over");
    self.score = self.score_total;
    self.sessionstate = "intermission";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.friendlydamage = undefined;
    points = struct::get_array("ee_cam", "targetname");
    if (!isdefined(points) || points.size == 0) {
        points = getentarray("info_intermission", "classname");
        if (points.size < 1) {
            println("<dev string:x28>");
            return;
        }
    }
    self.var_bff517de = newclienthudelem(self);
    self.var_bff517de.horzalign = "fullscreen";
    self.var_bff517de.vertalign = "fullscreen";
    self.var_bff517de setshader("black", 640, 480);
    self.var_bff517de.alpha = 1;
    visionsetnaked("cheat_bw", 0.05);
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
                wait time - var_57ae7e4a;
                self.var_bff517de fadeovertime(var_57ae7e4a);
                self.var_bff517de.alpha = 1;
                wait var_57ae7e4a;
                continue;
            }
            self.var_bff517de fadeovertime(1);
            self.var_bff517de.alpha = 0;
            wait 5;
            self.var_bff517de thread zm::fade_up_over_time(1);
        }
    }
}

/#

    // Namespace zm_tomb_ee_main
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf901b9c4, Offset: 0x2110
    // Size: 0x1ec
    function function_670b87e0() {
        wait 5;
        b_activated = 0;
        while (!b_activated) {
            foreach (player in getplayers()) {
                if (distance2d(player.origin, (2904, 5040, -336)) < 100 && player usebuttonpressed()) {
                    wait 2;
                    if (player usebuttonpressed()) {
                        b_activated = 1;
                    }
                }
            }
            wait 0.05;
        }
        setdvar("<dev string:x4b>", "<dev string:x5c>");
        setdvar("<dev string:x60>", "<dev string:x5c>");
        setdvar("<dev string:x72>", "<dev string:x5c>");
        adddebugcommand("<dev string:x84>");
        adddebugcommand("<dev string:xc4>");
        adddebugcommand("<dev string:x10a>");
        level thread function_6783db5c();
    }

    // Namespace zm_tomb_ee_main
    // Params 0, eflags: 0x1 linked
    // Checksum 0x19a833d3, Offset: 0x2308
    // Size: 0x478
    function function_6783db5c() {
        while (true) {
            if (getdvarstring("<dev string:x4b>") == "<dev string:x14b>") {
                setdvar("<dev string:x4b>", "<dev string:x5c>");
                level.var_89b873d7 = 1;
                level flag::set("<dev string:x14e>");
                switch (level.var_ca733eed) {
                case "<dev string:x162>":
                    level flag::set("<dev string:x169>");
                    level flag::set("<dev string:x17f>");
                    break;
                case "<dev string:x192>":
                    level flag::set("<dev string:x199>");
                    level waittill(#"hash_e0898539");
                    break;
                case "<dev string:x1b0>":
                    level flag::set("<dev string:x1b7>");
                    level waittill(#"hash_dc144054");
                    break;
                case "<dev string:x1cc>":
                    level flag::set("<dev string:x1d3>");
                    var_7bf7eda5 = getent("<dev string:x1ee>", "<dev string:x206>");
                    if (isdefined(var_7bf7eda5)) {
                        var_7bf7eda5 delete();
                    }
                    level waittill(#"hash_972e03ef");
                    break;
                case "<dev string:x211>":
                    level flag::set("<dev string:x218>");
                    level flag::set("<dev string:x237>");
                    level waittill(#"hash_f397975a");
                    break;
                case "<dev string:x24d>":
                    level flag::set("<dev string:x254>");
                    level flag::clear("<dev string:x237>");
                    level waittill(#"hash_5fff9bfd");
                    break;
                case "<dev string:x26d>":
                    level flag::set("<dev string:x274>");
                    level waittill(#"hash_9130e1d8");
                    break;
                case "<dev string:x292>":
                    level flag::set("<dev string:x299>");
                    level waittill(#"hash_26f53c83");
                    break;
                case "<dev string:x2ab>":
                    level flag::set("<dev string:x237>");
                    level waittill(#"hash_11477e");
                    break;
                default:
                    break;
                }
            }
            if (getdvarstring("<dev string:x60>") == "<dev string:x14b>") {
                setdvar("<dev string:x60>", "<dev string:x5c>");
                level clientfield::set("<dev string:x2b2>", 2);
                function_e4eeb8b4();
            }
            if (getdvarstring("<dev string:x72>") == "<dev string:x14b>") {
                setdvar("<dev string:x72>", "<dev string:x5c>");
                setdvar("<dev string:x2c0>", "<dev string:x14b>");
                level flag::set("<dev string:x2d8>");
                array::thread_all(getplayers(), &zm_weapons::weapon_give, "<dev string:x2ea>");
            }
            wait 0.05;
        }
    }

#/

// Namespace zm_tomb_ee_main
// Params 0, eflags: 0x1 linked
// Checksum 0xf95ea982, Offset: 0x2788
// Size: 0x1a2
function function_ab51bfd() {
    a_ai_enemies = getaiteamarray("axis");
    foreach (ai in a_ai_enemies) {
        if (isalive(ai)) {
            ai.marked_for_death = 1;
            ai ai::set_ignoreall(1);
        }
        util::wait_network_frame();
    }
    foreach (ai in a_ai_enemies) {
        if (isalive(ai)) {
            ai dodamage(ai.health + 666, ai.origin);
        }
    }
}

