#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/shared/ai/archetype_apothicon_fury;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/system_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/aat_shared;
#using scripts/codescripts/struct;

#namespace namespace_c21dfba4;

// Namespace namespace_c21dfba4
// Params 0, eflags: 0x2
// Checksum 0xfb65af02, Offset: 0x5f8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_genesis_apothicon_fury", &__init__, undefined, undefined);
}

// Namespace namespace_c21dfba4
// Params 0, eflags: 0x1 linked
// Checksum 0x31d89297, Offset: 0x638
// Size: 0xfc
function __init__() {
    spawner::add_archetype_spawn_function("apothicon_fury", &function_2c871f46);
    spawner::add_archetype_spawn_function("apothicon_fury", &function_e5e94978);
    spawner::add_archetype_spawn_function("apothicon_fury", &function_1dcdd145);
    if (ai::shouldregisterclientfieldforarchetype("apothicon_fury")) {
        clientfield::register("scriptmover", "apothicon_fury_spawn_meteor", 15000, 2, "int");
    }
    /#
        execdevgui("fury");
        level thread function_bc2e7a98();
    #/
}

// Namespace namespace_c21dfba4
// Params 0, eflags: 0x1 linked
// Checksum 0x95908dfb, Offset: 0x740
// Size: 0x64
function function_51dd865c() {
    level thread aat::register_immunity("zm_aat_turned", "apothicon_fury", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_thunder_wall", "apothicon_fury", 1, 1, 1);
}

// Namespace namespace_c21dfba4
// Params 0, eflags: 0x1 linked
// Checksum 0x28527a94, Offset: 0x7b0
// Size: 0x74
function function_d7808406() {
    e_attacker = self waittill(#"death");
    if (isdefined(e_attacker) && isdefined(e_attacker.var_4d307aef)) {
        e_attacker.var_4d307aef++;
    }
    if (isdefined(e_attacker) && isdefined(e_attacker.var_8b5008fe)) {
        e_attacker.var_8b5008fe++;
    }
}

// Namespace namespace_c21dfba4
// Params 3, eflags: 0x1 linked
// Checksum 0x77605070, Offset: 0x830
// Size: 0x208
function function_21bbe70d(v_origin, v_angles, var_8d71b2b8) {
    e_boss = spawnactor("spawner_zm_genesis_apothicon_fury", v_origin, v_angles, undefined, 1, 1);
    if (isdefined(e_boss)) {
        e_boss endon(#"death");
        e_boss.spawn_time = gettime();
        e_boss.var_1cba9ac3 = 1;
        e_boss.heroweapon_kill_power = 2;
        e_boss.completed_emerging_into_playable_area = 1;
        e_boss thread function_d7808406();
        e_boss thread zm::update_zone_name();
        level thread zm_spawner::zombie_death_event(e_boss);
        e_boss thread zm_spawner::function_1612a0b8();
        e_boss thread function_7ba80ea7();
        e_boss thread function_1be68e3f();
        e_boss.voiceprefix = "fury";
        e_boss.animname = "fury";
        e_boss thread zm_spawner::play_ambient_zombie_vocals();
        e_boss thread zm_audio::zmbaivox_notifyconvert();
        e_boss playsound("zmb_vocals_fury_spawn");
        /#
            e_boss thread function_ab27e73a();
        #/
        if (isdefined(var_8d71b2b8) && var_8d71b2b8) {
            wait(1);
            e_boss.zombie_think_done = 1;
        }
        return e_boss;
    }
    return undefined;
}

// Namespace namespace_c21dfba4
// Params 0, eflags: 0x5 linked
// Checksum 0x6d3572c1, Offset: 0xa40
// Size: 0x124
function private function_7ba80ea7() {
    self.is_zombie = 1;
    zombiehealth = level.zombie_health;
    if (!isdefined(zombiehealth)) {
        zombiehealth = level.zombie_vars["zombie_health_start"];
    }
    if (level.round_number <= 20) {
        self.maxhealth = zombiehealth * 1.2;
    } else if (level.round_number <= 50) {
        self.maxhealth = zombiehealth * 1.5;
    } else {
        self.maxhealth = zombiehealth * 1.7;
    }
    if (!isdefined(self.maxhealth) || self.maxhealth <= 0 || self.maxhealth > 2147483647 || self.maxhealth != self.maxhealth) {
        self.maxhealth = zombiehealth;
    }
    self.health = int(self.maxhealth);
}

// Namespace namespace_c21dfba4
// Params 0, eflags: 0x5 linked
// Checksum 0x5408839c, Offset: 0xb70
// Size: 0xb8
function private function_1be68e3f() {
    self endon(#"death");
    while (true) {
        if (isdefined(self.zone_name)) {
            if (self.zone_name == "dark_arena_zone" || self.zone_name == "dark_arena2_zone") {
                if (!ispointonnavmesh(self.origin)) {
                    point = getclosestpointonnavmesh(self.origin, 256, 30);
                    self forceteleport(point);
                }
            }
        }
        wait(0.25);
    }
}

// Namespace namespace_c21dfba4
// Params 0, eflags: 0x1 linked
// Checksum 0x97e79d02, Offset: 0xc30
// Size: 0xa0
function function_ab27e73a() {
    self endon(#"death");
    if (isdefined(level.var_31c836af) && level.var_31c836af > 0) {
        self.health = level.var_31c836af;
    }
    while (true) {
        if (isdefined(level.var_2db0d4e8) && level.var_2db0d4e8) {
            /#
                print3d(self.origin, "fury" + self.health, (0, 0, 1), 1.2);
            #/
        }
        wait(0.05);
    }
}

// Namespace namespace_c21dfba4
// Params 6, eflags: 0x0
// Checksum 0xa0dc8d7a, Offset: 0xcd8
// Size: 0xa8
function function_16beb600(var_8cc26a7f, var_7ab4c34a, var_535f5919, var_13d4cd83, var_3988ba7b, var_8d71b2b8) {
    if (!isdefined(var_8d71b2b8)) {
        var_8d71b2b8 = 0;
    }
    function_b55fb314(var_8cc26a7f, var_7ab4c34a, var_535f5919, var_13d4cd83, var_3988ba7b);
    var_165d8ccd = function_21bbe70d(var_13d4cd83, var_3988ba7b, var_8d71b2b8);
    if (isdefined(var_165d8ccd)) {
        return var_165d8ccd;
    }
}

// Namespace namespace_c21dfba4
// Params 5, eflags: 0x1 linked
// Checksum 0x8ca681e2, Offset: 0xd88
// Size: 0x494
function function_b55fb314(var_8cc26a7f, var_7ab4c34a, var_535f5919, var_13d4cd83, var_3988ba7b) {
    var_7ae4bfa0 = var_535f5919;
    var_8a1358c0 = var_7ab4c34a[2] + var_7ae4bfa0 - var_13d4cd83[2];
    var_dfcea895 = (var_13d4cd83[0] - var_7ab4c34a[0], var_13d4cd83[1] - var_7ab4c34a[1], 0);
    var_30280c29 = var_7ab4c34a + var_dfcea895 * 0.5 + (0, 0, var_535f5919);
    var_be9b92b3 = spawn("script_model", var_7ab4c34a);
    var_be9b92b3 setmodel("tag_origin");
    var_be9b92b3 clientfield::set("apothicon_fury_spawn_meteor", 1);
    var_22077f2a = var_7ab4c34a + (0, 0, var_7ae4bfa0 * 0.5);
    var_be9b92b3.angles = vectortoangles(var_22077f2a - var_be9b92b3.origin);
    var_be9b92b3 moveto(var_22077f2a, var_8cc26a7f / 6);
    var_be9b92b3 waittill(#"movedone");
    var_22077f2a = var_be9b92b3.origin + (0, 0, var_7ae4bfa0 * 0.25) + var_dfcea895 * 0.25;
    var_be9b92b3.angles = vectortoangles(var_22077f2a - var_be9b92b3.origin);
    var_be9b92b3 moveto(var_22077f2a, var_8cc26a7f / 6);
    var_be9b92b3 waittill(#"movedone");
    var_22077f2a = var_30280c29;
    var_be9b92b3.angles = vectortoangles(var_22077f2a - var_be9b92b3.origin);
    var_be9b92b3 moveto(var_30280c29, var_8cc26a7f / 6);
    var_be9b92b3 waittill(#"movedone");
    var_22077f2a = var_be9b92b3.origin - (0, 0, var_8a1358c0 * 0.25) + var_dfcea895 * 0.25;
    var_be9b92b3.angles = vectortoangles(var_22077f2a - var_be9b92b3.origin);
    var_be9b92b3 moveto(var_22077f2a, var_8cc26a7f / 6);
    var_be9b92b3 waittill(#"movedone");
    var_22077f2a = var_13d4cd83 - (0, 0, var_8a1358c0 * 0.5);
    var_be9b92b3.angles = vectortoangles(var_22077f2a - var_be9b92b3.origin);
    var_be9b92b3 moveto(var_22077f2a, var_8cc26a7f / 6);
    var_be9b92b3 waittill(#"movedone");
    var_22077f2a = var_13d4cd83;
    var_be9b92b3.angles = vectortoangles(var_22077f2a - var_be9b92b3.origin);
    var_be9b92b3 moveto(var_13d4cd83, var_8cc26a7f / 6);
    var_be9b92b3 waittill(#"movedone");
    var_be9b92b3 clientfield::set("apothicon_fury_spawn_meteor", 2);
    var_be9b92b3 delete();
}

// Namespace namespace_c21dfba4
// Params 0, eflags: 0x1 linked
// Checksum 0x38900f55, Offset: 0x1228
// Size: 0x1c
function function_2c871f46() {
    self aat::aat_cooldown_init();
}

// Namespace namespace_c21dfba4
// Params 0, eflags: 0x1 linked
// Checksum 0x7858aadf, Offset: 0x1250
// Size: 0x118
function function_e5e94978() {
    self endon(#"death");
    while (isalive(self)) {
        self waittill(#"damage");
        if (isplayer(self.attacker)) {
            if (zm_spawner::player_using_hi_score_weapon(self.attacker)) {
                str_notify = "damage";
            } else {
                str_notify = "damage_light";
            }
            if (!(isdefined(self.deathpoints_already_given) && self.deathpoints_already_given)) {
                self.attacker zm_score::player_add_points(str_notify, self.damagemod, self.damagelocation, undefined, self.team, self.damageweapon);
            }
            if (isdefined(level.hero_power_update)) {
                [[ level.hero_power_update ]](self.attacker, self);
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_c21dfba4
// Params 0, eflags: 0x1 linked
// Checksum 0x3e2c8af1, Offset: 0x1370
// Size: 0xa8
function function_1dcdd145() {
    self waittill(#"death");
    if (isplayer(self.attacker)) {
        if (!(isdefined(self.deathpoints_already_given) && self.deathpoints_already_given)) {
            self.attacker zm_score::player_add_points("death", self.damagemod, self.damagelocation, undefined, self.team, self.damageweapon);
        }
        if (isdefined(level.hero_power_update)) {
            [[ level.hero_power_update ]](self.attacker, self);
        }
    }
}

/#

    // Namespace namespace_c21dfba4
    // Params 0, eflags: 0x5 linked
    // Checksum 0xfa5d2dc8, Offset: 0x1420
    // Size: 0x44
    function private function_bc2e7a98() {
        level flagsys::wait_till("fury");
        zm_devgui::add_custom_devgui_callback(&function_744725d0);
    }

#/

// Namespace namespace_c21dfba4
// Params 1, eflags: 0x5 linked
// Checksum 0xe7339969, Offset: 0x1470
// Size: 0x6c6
function private function_744725d0(cmd) {
    if (cmd == "apothicon_fury_spawn") {
        queryresult = positionquery_source_navigation(level.players[0].origin, -128, 256, -128, 20);
        if (isdefined(queryresult) && queryresult.data.size > 0) {
            origin = queryresult.data[0].origin;
            angles = level.players[0].angles;
            level thread function_21bbe70d(origin, angles, 1);
        }
    } else if (cmd == "apothicon_fury_walk") {
        ais = getaiarchetypearray("apothicon_fury");
        foreach (ai in ais) {
            ai ai::set_behavior_attribute("move_speed", "walk");
        }
    } else if (cmd == "apothicon_fury_sprint") {
        ais = getaiarchetypearray("apothicon_fury");
        foreach (ai in ais) {
            ai ai::set_behavior_attribute("move_speed", "sprint");
        }
    } else if (cmd == "apothicon_fury_run") {
        ais = getaiarchetypearray("apothicon_fury");
        foreach (ai in ais) {
            ai ai::set_behavior_attribute("move_speed", "run");
        }
    } else if (cmd == "apothicon_fury_disable_bamf") {
        ais = getaiarchetypearray("apothicon_fury");
        foreach (ai in ais) {
            ai ai::set_behavior_attribute("can_bamf", 0);
            ai ai::set_behavior_attribute("can_juke", 0);
        }
    } else if (cmd == "apothicon_fury_force_furious") {
        ais = getaiarchetypearray("apothicon_fury");
        foreach (ai in ais) {
            if (!(isdefined(ai.var_e78a1124) && ai.var_e78a1124)) {
                namespace_53429ee4::function_ee6717e6(ai);
            }
        }
    } else if (cmd == "apothicon_fury_debug_health") {
        if (isdefined(level.var_2db0d4e8) && level.var_2db0d4e8) {
            level.var_2db0d4e8 = 0;
        } else {
            level.var_2db0d4e8 = 1;
        }
    }
    if (getdvarint("zombie_apothicon_health") > 0) {
        level.var_31c836af = getdvarint("zombie_apothicon_health");
    } else {
        level.var_31c836af = 0;
    }
    if (getdvarint("zombie_apothicon_juke_min") > 0) {
        level.var_d43705fc = getdvarfloat("zombie_apothicon_juke_min") * 1000;
    } else {
        level.var_d43705fc = undefined;
    }
    if (getdvarint("zombie_apothicon_juke_max") > 0) {
        level.var_1437a42 = getdvarfloat("zombie_apothicon_juke_max") * 1000;
    } else {
        level.var_1437a42 = undefined;
    }
    if (getdvarint("zombie_apothicon_bamf_min") > 0) {
        level.var_6a4bce2d = getdvarfloat("zombie_apothicon_bamf_min") * 1000;
    } else {
        level.var_6a4bce2d = undefined;
    }
    if (getdvarint("zombie_apothicon_bamf_max") > 0) {
        level.var_a7afd943 = getdvarfloat("zombie_apothicon_bamf_max") * 1000;
        return;
    }
    level.var_a7afd943 = undefined;
}

