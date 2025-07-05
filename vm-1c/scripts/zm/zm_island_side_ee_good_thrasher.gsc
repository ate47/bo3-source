#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/drown;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/zm/_zm_ai_thrasher;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_keeper_skull;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_island_spores;
#using scripts/zm/zm_island_util;

#namespace zm_island_side_ee_good_thrasher;

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x2
// Checksum 0x41cb140a, Offset: 0x788
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_island_side_ee_good_thrasher", &__init__, undefined, undefined);
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0x20ee8f39, Offset: 0x7c8
// Size: 0x384
function __init__() {
    level.var_564761a3 = spawnstruct();
    level.var_564761a3.var_69299ec6 = getent("mdl_side_ee_gt_vine", "targetname");
    level.var_564761a3.var_978adea0 = getentarray("mdl_good_thrasher_vines", "targetname");
    level.var_564761a3.var_11c98268 = struct::get("s_side_ee_gt_spore_pos", "targetname");
    level.var_564761a3.var_ff07b157 = getent("mdl_side_ee_gt_sporeplant", "targetname");
    level.var_564761a3.var_ff07b157.var_7117876c = level.var_564761a3.var_ff07b157.origin;
    level.var_564761a3.var_ff07b157.var_c780fb80 = level.var_564761a3.var_ff07b157.origin - (0, 0, 50);
    level.var_564761a3.var_ff07b157.var_baeb5712 = 1;
    level.var_564761a3.var_ff07b157 setscale(0.1);
    v_pos = level.var_564761a3.var_ff07b157.origin + (-16, -48, 0);
    level.var_564761a3.var_480b39a3 = util::spawn_model("tag_origin", v_pos, level.var_564761a3.var_ff07b157.angles);
    callback::on_spawned(&on_player_spawned);
    callback::on_connect(&on_player_connected);
    var_d1cfa380 = getminbitcountfornum(7);
    var_a15256dd = getminbitcountfornum(3);
    clientfield::register("scriptmover", "side_ee_gt_spore_glow_fx", 9000, 1, "int");
    clientfield::register("scriptmover", "side_ee_gt_spore_cloud_fx", 9000, var_d1cfa380, "int");
    clientfield::register("actor", "side_ee_gt_spore_trail_enemy_fx", 9000, 1, "int");
    clientfield::register("allplayers", "side_ee_gt_spore_trail_player_fx", 9000, var_a15256dd, "int");
    clientfield::register("actor", "good_thrasher_fx", 9000, 1, "int");
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0x8e165141, Offset: 0xb58
// Size: 0xcc
function main() {
    /#
        level thread function_a0e0b4c2();
    #/
    mdl_goodthrasher_wall_decal = getent("mdl_goodthrasher_wall_decal", "targetname");
    mdl_goodthrasher_wall_decal clientfield::set("do_fade_material", 0.5);
    var_199cfb62 = getentarray("mdl_good_thrasher_wall", "targetname");
    var_c047302 = var_199cfb62[0];
    var_c047302 clientfield::set("do_fade_material", 1);
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0x43f17568, Offset: 0xc30
// Size: 0x1c
function on_player_spawned() {
    self thread function_4aee2763();
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0xc58
// Size: 0x4
function on_player_connected() {
    
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0xf4c8db3f, Offset: 0xc68
// Size: 0x94
function function_4aee2763() {
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"hash_9fe92074");
    var_199cfb62 = getentarray("mdl_good_thrasher_wall", "targetname");
    var_c047302 = var_199cfb62[0];
    self zm_island_util::function_7448e472(var_c047302);
    level thread function_ad9a2050();
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0xe80fcfda, Offset: 0xd08
// Size: 0x17c
function function_ad9a2050() {
    callback::remove_on_spawned(&on_player_spawned);
    level notify(#"hash_9fe92074");
    var_199cfb62 = getentarray("mdl_good_thrasher_wall", "targetname");
    var_c047302 = var_199cfb62[0];
    if (isdefined(var_c047302)) {
        exploder::exploder("fxexp_506");
        mdl_goodthrasher_wall_decal = getent("mdl_goodthrasher_wall_decal", "targetname");
        var_c047302 clientfield::set("do_fade_material", 0);
        wait 0.25;
        mdl_goodthrasher_wall_decal clientfield::set("do_fade_material", 0);
        wait 0.25;
        var_c047302 delete();
        mdl_goodthrasher_wall_decal delete();
        exploder::exploder("ex_goodthrasher");
        level.var_564761a3.var_69299ec6 thread function_f3ed4502();
    }
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0xf6d34b68, Offset: 0xe90
// Size: 0x130
function function_f3ed4502() {
    self setcandamage(1);
    var_f7ecb00a = 0;
    level.var_564761a3.var_480b39a3 clientfield::set("spore_grows", 3);
    while (!(isdefined(var_f7ecb00a) && var_f7ecb00a)) {
        self waittill(#"damage", n_damage, e_attacker, var_a3382de1, v_point, str_means_of_death, var_c4fe462, var_e64d69f9, var_c04aef90, w_weapon);
        self.health = 10000;
        if (w_weapon.name === "hero_mirg2000_upgraded") {
            var_f7ecb00a = 1;
            self thread function_302fe6aa();
        }
    }
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0xc2f1cdc4, Offset: 0xfc8
// Size: 0xfc
function function_302fe6aa() {
    self hide();
    self setcandamage(0);
    self notsolid();
    foreach (var_4165e349 in level.var_564761a3.var_978adea0) {
        if (isdefined(var_4165e349)) {
            var_4165e349 delete();
        }
    }
    wait 1;
    level thread function_95caef47();
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0x844c81c7, Offset: 0x10d0
// Size: 0x24
function function_95caef47() {
    level thread function_4724011d("ready");
}

// Namespace zm_island_side_ee_good_thrasher
// Params 1, eflags: 0x0
// Checksum 0x21d58bf4, Offset: 0x1100
// Size: 0xc6
function function_4724011d(str_state) {
    var_db03d856 = level.var_564761a3.var_ff07b157;
    if (var_db03d856.str_state !== str_state) {
        var_db03d856.str_state = str_state;
        switch (str_state) {
        case "ready":
            var_db03d856 thread function_c8310977();
            break;
        case "exploded":
            var_db03d856 thread function_19f54a6f();
            break;
        case "dormant":
            var_db03d856 thread function_784ed421();
            break;
        }
    }
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0x330c5244, Offset: 0x11d0
// Size: 0x1f4
function function_c8310977() {
    self endon(#"hash_593bd276");
    self endon(#"hash_101ca32e");
    self endon(#"death");
    self notify(#"hash_1fb62748");
    if (self.origin !== self.var_7117876c) {
        self moveto(self.var_7117876c, 1);
        self waittill(#"movedone");
    }
    level.var_564761a3.var_480b39a3 clientfield::set("spore_grows", 3);
    mdl_mushroom_clip = getent("mdl_mushroom_clip", "targetname");
    mdl_mushroom_clip setcandamage(1);
    mdl_mushroom_clip thread function_ecaf0cc6();
    while (true) {
        mdl_mushroom_clip.health = 10000;
        mdl_mushroom_clip waittill(#"damage", n_damage, e_attacker, var_a3382de1, v_point, str_means_of_death, var_c4fe462, var_e64d69f9, var_c04aef90, w_weapon);
        if (zm_utility::is_player_valid(e_attacker)) {
            mdl_mushroom_clip setcandamage(0);
            level thread function_4724011d("exploded");
            break;
        }
    }
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0xc2b8384f, Offset: 0x13d0
// Size: 0x130
function function_ecaf0cc6() {
    self endon(#"hash_593bd276");
    self endon(#"hash_101ca32e");
    self endon(#"death");
    b_exploded = 0;
    while (!(isdefined(b_exploded) && b_exploded)) {
        foreach (player in level.activeplayers) {
            n_dist = distancesquared(self.origin, player.origin);
            if (n_dist <= 6000) {
                level thread function_4724011d("exploded");
                b_exploded = 1;
            }
        }
        wait 0.5;
    }
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0xb738836c, Offset: 0x1508
// Size: 0xa4
function function_19f54a6f() {
    self endon(#"hash_1fb62748");
    self endon(#"hash_101ca32e");
    self notify(#"hash_593bd276");
    self setcandamage(0);
    self thread function_4c6beece(4, 1);
    level.var_564761a3.var_480b39a3 clientfield::set("spore_grows", 0);
    level thread function_4724011d("dormant");
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0xc90b3ccb, Offset: 0x15b8
// Size: 0x134
function function_784ed421() {
    self endon(#"hash_1fb62748");
    self endon(#"hash_593bd276");
    self endon(#"death");
    self notify(#"hash_101ca32e");
    self setcandamage(0);
    if (self.origin !== self.var_c780fb80) {
        self moveto(self.var_c780fb80, 1);
        self waittill(#"movedone");
    }
    var_5cddf7a = level.var_564761a3.var_1cd02afb;
    if (isdefined(var_5cddf7a)) {
        while (isalive(var_5cddf7a)) {
            wait 1;
        }
        level.var_564761a3.var_1cd02afb = undefined;
    }
    for (var_3c249619 = 3; var_3c249619 > 0; var_3c249619--) {
        level waittill(#"start_of_round");
    }
    level thread function_4724011d("ready");
}

// Namespace zm_island_side_ee_good_thrasher
// Params 3, eflags: 0x0
// Checksum 0xf48b5fd4, Offset: 0x16f8
// Size: 0x29a
function function_4c6beece(var_f9f788a6, b_hero_weapon, e_attacker) {
    if (var_f9f788a6 == 1) {
        self.var_d7bb540a = 5;
        self.var_66bbb0c0 = 44;
    } else if (var_f9f788a6 == 2) {
        self.var_d7bb540a = 10;
        self.var_66bbb0c0 = 60;
    } else if (var_f9f788a6 == 3) {
        self.var_d7bb540a = 15;
        self.var_66bbb0c0 = 76;
    } else {
        self.var_d7bb540a = 45;
        self.var_66bbb0c0 = 76;
    }
    s_org = level.var_564761a3.var_11c98268;
    self thread spore_cloud_fx(b_hero_weapon, s_org, var_f9f788a6);
    playsoundatposition("zmb_spore_eject", self.origin);
    var_88c0f006 = self function_cc07e4ad(self.var_66bbb0c0, s_org);
    while (!isdefined(level.var_564761a3.var_1cd02afb) || self.var_d7bb540a > 0 && !isalive(level.var_564761a3.var_1cd02afb)) {
        self.var_d7bb540a -= 1;
        a_e_enemies = var_88c0f006 array::get_touching(getaiteamarray("axis"));
        a_e_players = var_88c0f006 array::get_touching(level.players);
        array::thread_all(a_e_enemies, &function_c6cec92d, 1, b_hero_weapon, e_attacker);
        array::thread_all(a_e_players, &function_c6cec92d, 1, b_hero_weapon, undefined);
        wait 1;
    }
    self clientfield::set("side_ee_gt_spore_cloud_fx", 0);
    var_88c0f006 delete();
    self notify(#"hash_91dd564f");
}

// Namespace zm_island_side_ee_good_thrasher
// Params 3, eflags: 0x0
// Checksum 0x8f515c99, Offset: 0x19a0
// Size: 0x134
function spore_cloud_fx(b_hero_weapon, s_org, var_f9f788a6) {
    if (b_hero_weapon) {
        if (var_f9f788a6 == 1) {
            self clientfield::set("side_ee_gt_spore_cloud_fx", 1);
        } else if (var_f9f788a6 == 2) {
            self clientfield::set("side_ee_gt_spore_cloud_fx", 2);
        } else {
            self clientfield::set("side_ee_gt_spore_cloud_fx", 3);
        }
        return;
    }
    if (var_f9f788a6 == 1) {
        self clientfield::set("side_ee_gt_spore_cloud_fx", 4);
        return;
    }
    if (var_f9f788a6 == 2) {
        self clientfield::set("side_ee_gt_spore_cloud_fx", 5);
        return;
    }
    self clientfield::set("side_ee_gt_spore_cloud_fx", 6);
}

// Namespace zm_island_side_ee_good_thrasher
// Params 2, eflags: 0x0
// Checksum 0x451e8327, Offset: 0x1ae0
// Size: 0x80
function function_cc07e4ad(var_66bbb0c0, s_org) {
    var_9f786393 = 90;
    t_trig = spawn("trigger_radius", s_org.origin, 0, var_66bbb0c0, var_9f786393);
    t_trig.angles = s_org.angles;
    return t_trig;
}

// Namespace zm_island_side_ee_good_thrasher
// Params 3, eflags: 0x0
// Checksum 0xa0237cee, Offset: 0x1b68
// Size: 0x4ec
function function_c6cec92d(var_2cfe5148, b_hero_weapon, e_attacker) {
    self endon(#"death");
    self endon(#"disconnect");
    if (!isdefined(self.var_d07c64b6)) {
        self.var_d07c64b6 = 0;
    }
    if (var_2cfe5148) {
        if (isdefined(self.targetname) && self.targetname == "zombie") {
            if (!self.var_d07c64b6) {
                self.var_d07c64b6 = 1;
                if (isdefined(level.var_564761a3.var_2d3405bf) && level.var_564761a3.var_2d3405bf || isalive(level.var_564761a3.var_1cd02afb)) {
                    self clientfield::set("side_ee_gt_spore_trail_enemy_fx", 1);
                    self thread function_20ca7e14();
                    wait 10;
                    self.var_d07c64b6 = 0;
                    self notify(#"hash_36dceca1");
                    self clientfield::set("side_ee_gt_spore_trail_enemy_fx", 0);
                } else {
                    self clientfield::set("side_ee_gt_spore_trail_enemy_fx", 1);
                    if (!(isdefined(level.var_564761a3.var_2d3405bf) && level.var_564761a3.var_2d3405bf) && !isalive(level.var_564761a3.var_1cd02afb)) {
                        self thread function_5115d0a7();
                    } else {
                        self.var_317d58a6 = self.zombie_move_speed;
                        self zombie_utility::set_zombie_run_cycle("walk");
                        wait 10;
                        self zombie_utility::set_zombie_run_cycle(self.var_317d58a6);
                        self.var_d07c64b6 = 0;
                        self clientfield::set("side_ee_gt_spore_trail_enemy_fx", 0);
                    }
                }
            }
        } else if (isdefined(self.var_3940f450) && self.var_3940f450) {
            if (!self.var_d07c64b6) {
                self.var_d07c64b6 = 1;
                if (isdefined(e_attacker)) {
                    e_attacker notify(#"update_challenge_3_1");
                }
                if (b_hero_weapon) {
                    radiusdamage(self.origin, -128, 1000, 1000);
                } else {
                    self kill();
                }
            }
        } else if (isdefined(self.var_61f7b3a0) && self.var_61f7b3a0 && !(isdefined(self.var_60cb45e5) && self.var_60cb45e5)) {
            if (!self.var_d07c64b6) {
                if (b_hero_weapon) {
                    self.var_d07c64b6 = 1;
                    self dodamage(self.health / 2, self.origin);
                    wait 10;
                    self.var_d07c64b6 = 0;
                }
            }
        }
        return;
    }
    if (!self.var_d07c64b6) {
        self.var_d07c64b6 = 1;
        self notify(#"hash_ece519d9");
        if (self isplayerunderwater()) {
            self thread function_703ef5e8();
        }
        if (b_hero_weapon) {
            self clientfield::set("side_ee_gt_spore_trail_player_fx", 1);
            self thread function_365b46bb();
            wait 30;
        } else if (self.var_df4182b1) {
            self notify(#"hash_b56a74a8");
            wait 5;
        } else {
            self clientfield::set("side_ee_gt_spore_trail_player_fx", 2);
            if (!self isplayerunderwater()) {
                self thread function_36f14fa1();
                self thread function_7fa4a0dd();
                self waittill(#"coughing_complete");
            } else {
                wait 3;
            }
        }
        self.var_d07c64b6 = 0;
        self notify(#"hash_dd8e5266");
        self clientfield::set("side_ee_gt_spore_trail_player_fx", 0);
    }
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0xaccebbf3, Offset: 0x2060
// Size: 0x2b4
function function_5115d0a7() {
    if (!(isdefined(level.var_564761a3.var_2d3405bf) && level.var_564761a3.var_2d3405bf) && !isalive(level.var_564761a3.var_1cd02afb)) {
        level.var_564761a3.var_2d3405bf = 1;
        level.var_564761a3.var_1cd02afb = zm_ai_thrasher::function_8b323113(self, 0, 0);
        for (n_wait = 5; n_wait > 0 && !isdefined(level.var_564761a3.var_1cd02afb); n_wait--) {
            wait 1;
        }
        if (isdefined(level.var_564761a3.var_1cd02afb)) {
            level.var_564761a3.var_1cd02afb.var_60cb45e5 = 1;
            level.var_564761a3.var_1cd02afb setteam("allies");
            level.var_564761a3.var_1cd02afb util::magic_bullet_shield();
            level.var_564761a3.var_1cd02afb ai::set_behavior_attribute("move_mode", "friendly");
            level.var_564761a3.var_1cd02afb thread function_8870fa6e();
            var_ab3b4634 = arraygetclosest(level.var_564761a3.var_1cd02afb.origin, level.activeplayers);
            level.var_564761a3.var_1cd02afb setowner(var_ab3b4634);
            if (zm_utility::is_player_valid(var_ab3b4634) && !level flag::exists("side_ee_good_thrasher_seen")) {
                level flag::init("side_ee_good_thrasher_seen");
                level flag::set("side_ee_good_thrasher_seen");
                var_ab3b4634 notify(#"player_saw_good_thrasher_creation");
            }
            level.var_564761a3.var_ff07b157.var_d7bb540a = 0;
        }
        level.var_564761a3.var_2d3405bf = 0;
    }
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0xb97a7bf2, Offset: 0x2320
// Size: 0x134
function function_8870fa6e() {
    self thread function_2b2a9b70();
    self thread function_d3e5e5f4();
    self clientfield::set("good_thrasher_fx", 1);
    self util::waittill_any_timeout(300, "death", "gassed");
    self clientfield::set("good_thrasher_fx", 0);
    var_3cec36e5 = arraygetclosest(self.origin, level.activeplayers);
    if (zm_utility::is_player_valid(var_3cec36e5)) {
        var_3cec36e5 notify(#"player_saw_good_thrasher_death");
    }
    if (isalive(self)) {
        self util::stop_magic_bullet_shield();
        self kill();
    }
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0x8bec53c2, Offset: 0x2460
// Size: 0x46
function function_2b2a9b70() {
    self endon(#"death");
    trigger::wait_till("trigger_gas_hurt", "targetname", self);
    wait 2;
    self notify(#"gassed");
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0xd9220a20, Offset: 0x24b0
// Size: 0x70
function function_d3e5e5f4() {
    self endon(#"death");
    while (true) {
        str_zone = self zm_utility::get_current_zone();
        if (str_zone === "zone_bunker_prison" && level.var_5258ba34) {
            wait 3;
            self notify(#"gassed");
        }
        wait 1;
    }
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0x2f7c7e10, Offset: 0x2528
// Size: 0x14c
function function_365b46bb() {
    self endon(#"disconnect");
    self endon(#"death");
    self setmovespeedscale(1.3);
    self function_ba25e637(60);
    self clientfield::set_to_player("speed_burst", 1);
    self playsound("zmb_spore_power_start");
    self playloopsound("zmb_spore_power_loop", 0.5);
    self waittill(#"hash_dd8e5266");
    self playsound("zmb_spore_power_stop");
    self stoploopsound(1);
    self setmovespeedscale(1);
    self function_ba25e637(4);
    self clientfield::set_to_player("speed_burst", 0);
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0x62d7ed9f, Offset: 0x2680
// Size: 0x48
function function_97e9942() {
    self endon(#"hash_dd8e5266");
    self endon(#"disconnect");
    while (true) {
        self clientfield::increment_to_player("postfx_futz_mild");
        wait 2.7;
    }
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0x73f4d10c, Offset: 0x26d0
// Size: 0x94
function function_6001fb15() {
    self endon(#"disconnect");
    self endon(#"death");
    self disableweapons();
    self disableusability();
    self thread function_36f14fa1();
    self waittill(#"hash_dd8e5266");
    self enableweapons();
    self enableusability();
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0x46925df1, Offset: 0x2770
// Size: 0x5c
function function_703ef5e8() {
    self notify(#"update_challenge_1_2");
    self.drownstage = 0;
    self clientfield::set_to_player("drown_stage", 0);
    self.lastwaterdamagetime = gettime();
    self drown::deactivate_player_health_visionset();
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0x9631c9ba, Offset: 0x27d8
// Size: 0x56
function function_20ca7e14() {
    self endon(#"hash_36dceca1");
    self endon(#"death");
    while (true) {
        self dodamage(self.health / 10, self.origin);
        wait 1;
    }
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0xa6ff9fec, Offset: 0x2838
// Size: 0x66
function function_36f14fa1() {
    self endon(#"death");
    self endon(#"hash_dd8e5266");
    if (self isinvehicle()) {
        return;
    }
    while (true) {
        self thread zm_audio::playerexert("cough", 1);
        wait 1;
    }
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0x6529de3a, Offset: 0x28a8
// Size: 0x9a
function function_7fa4a0dd() {
    self endon(#"disconnect");
    if (self isinvehicle()) {
        return;
    }
    self function_2ce1c95f();
    self util::waittill_any("fake_death", "death", "player_downed", "weapon_change_complete");
    self function_909c515f();
    self notify(#"coughing_complete");
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0x93fc057f, Offset: 0x2950
// Size: 0x104
function function_2ce1c95f() {
    self zm_utility::increment_is_drinking();
    self zm_utility::disable_player_move_states(1);
    original_weapon = self getcurrentweapon();
    weapon = getweapon("zombie_cough");
    if (original_weapon != level.weaponnone && !zm_utility::is_placeable_mine(original_weapon) && !zm_equipment::is_equipment(original_weapon)) {
        self.original_weapon = original_weapon;
    } else {
        return;
    }
    self giveweapon(weapon);
    self switchtoweapon(weapon);
}

// Namespace zm_island_side_ee_good_thrasher
// Params 0, eflags: 0x0
// Checksum 0x5ce2fe98, Offset: 0x2a60
// Size: 0x1ac
function function_909c515f() {
    self zm_utility::enable_player_move_states();
    weapon = getweapon("zombie_cough");
    if (isdefined(self.intermission) && (self laststand::player_is_in_laststand() || self.intermission)) {
        self takeweapon(weapon);
        return;
    }
    self zm_utility::decrement_is_drinking();
    a_primaries = self getweaponslistprimaries();
    self takeweapon(weapon);
    if (self.is_drinking > 0) {
        return;
    }
    if (isdefined(self.original_weapon)) {
        self switchtoweapon(self.original_weapon);
        return;
    }
    if (isdefined(a_primaries) && a_primaries.size > 0) {
        self switchtoweapon(a_primaries[0]);
        return;
    }
    if (self hasweapon(level.laststandpistol)) {
        self switchtoweapon(level.laststandpistol);
        return;
    }
    self zm_weapons::give_fallback_weapon();
}

/#

    // Namespace zm_island_side_ee_good_thrasher
    // Params 0, eflags: 0x0
    // Checksum 0x2734e4d, Offset: 0x2c18
    // Size: 0x5c
    function function_a0e0b4c2() {
        zm_devgui::add_custom_devgui_callback(&function_9eaf14a2);
        adddebugcommand("<dev string:x28>");
        adddebugcommand("<dev string:x80>");
    }

    // Namespace zm_island_side_ee_good_thrasher
    // Params 1, eflags: 0x0
    // Checksum 0xd50d729a, Offset: 0x2c80
    // Size: 0x76
    function function_9eaf14a2(cmd) {
        switch (cmd) {
        case "<dev string:xd9>":
            level thread function_ad9a2050();
            return 1;
        case "<dev string:xe9>":
            level.var_564761a3.var_69299ec6 thread function_302fe6aa();
            return 1;
        }
        return 0;
    }

#/
