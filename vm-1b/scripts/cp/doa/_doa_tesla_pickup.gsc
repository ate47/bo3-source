#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_gibs;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;

#using_animtree("generic_human");

#namespace namespace_3f3eaecb;

// Namespace namespace_3f3eaecb
// Params 0, eflags: 0x0
// Checksum 0xc7a19744, Offset: 0x4d8
// Size: 0x173
function init() {
    level.var_168d703f = getweapon("tesla_gun");
    level.var_d22a87eb = getweapon("tesla_gun_upgraded");
    level.doa.rules.tesla_max_arcs = 5;
    level.doa.rules.tesla_max_enemies_killed = 20;
    level.doa.rules.tesla_radius_start = 300;
    level.doa.rules.tesla_radius_decay = 20;
    level.doa.rules.tesla_head_gib_chance = 50;
    level.doa.rules.var_37d05402 = 30;
    level.var_c58bb885 = [];
    level.var_c58bb885["zombie"] = array("ai_zombie_tesla_death_a", "ai_zombie_tesla_death_b", "ai_zombie_tesla_death_c", "ai_zombie_tesla_death_d", "ai_zombie_tesla_death_e");
    level.var_2a98be55 = [];
    level.var_2a98be55["zombie"] = array("ai_zombie_tesla_death_a", "ai_zombie_tesla_death_b", "ai_zombie_tesla_death_c", "ai_zombie_tesla_death_d", "ai_zombie_tesla_death_e");
}

// Namespace namespace_3f3eaecb
// Params 0, eflags: 0x0
// Checksum 0x33a79520, Offset: 0x658
// Size: 0x45
function function_2f9ce7f8() {
    self endon(#"hash_2f9ce7f8");
    self notify(#"hash_2f9ce7f8");
    self endon(#"disconnect");
    while (true) {
        self.var_a954893b = 1;
        self waittill(#"hash_236d3ea5");
        self.var_a954893b = 0;
        wait 2;
    }
}

// Namespace namespace_3f3eaecb
// Params 1, eflags: 0x0
// Checksum 0xd9f0257a, Offset: 0x6a8
// Size: 0x2f
function function_398dc86c(player) {
    if (!isdefined(player.var_a954893b)) {
        return true;
    }
    if (player.var_a954893b == 0) {
        return false;
    }
    return true;
}

// Namespace namespace_3f3eaecb
// Params 1, eflags: 0x0
// Checksum 0xe50aeab7, Offset: 0x6e0
// Size: 0xc6
function function_51e87beb(player) {
    player endon(#"disconnect");
    player endon(#"death");
    waittillframeend();
    if (!function_398dc86c(player)) {
        return;
    }
    if (isdefined(self.var_128cd975) && self.var_128cd975) {
        return;
    }
    player.tesla_enemies = undefined;
    player.tesla_enemies_hit = 1;
    player.var_691298ec = 0;
    player notify(#"hash_236d3ea5");
    self thread namespace_eaa992c::function_285a2999("tesla_shock");
    if (!(isdefined(self.boss) && self.boss)) {
        self function_57a28e1(self, player, 0);
    }
    player.tesla_enemies_hit = 0;
}

// Namespace namespace_3f3eaecb
// Params 3, eflags: 0x0
// Checksum 0x307ac7, Offset: 0x7b0
// Size: 0x191
function function_57a28e1(source_enemy, player, arc_num) {
    player endon(#"disconnect");
    player endon(#"death");
    function_62bddefd(self, 1);
    radius_decay = level.doa.rules.tesla_radius_decay * arc_num;
    enemies = function_da0cecf0(self gettagorigin("j_head"), level.doa.rules.tesla_radius_start - radius_decay, player);
    function_62bddefd(enemies, 1);
    self thread function_55a2b33e(source_enemy, arc_num, player);
    for (i = 0; i < enemies.size; i++) {
        if (enemies[i] == self) {
            continue;
        }
        if (isdefined(enemies[i].boss) && enemies[i].boss == 1) {
            continue;
        }
        if (function_25febc97(arc_num + 1, player.tesla_enemies_hit)) {
            function_62bddefd(enemies[i], 0);
            continue;
        }
        player.tesla_enemies_hit++;
        enemies[i] thread function_57a28e1(self, player, arc_num + 1);
    }
}

// Namespace namespace_3f3eaecb
// Params 2, eflags: 0x0
// Checksum 0xafbf946e, Offset: 0x950
// Size: 0x95
function function_25febc97(arc_num, enemies_hit_num) {
    if (arc_num >= level.doa.rules.tesla_max_arcs) {
        return true;
    }
    if (enemies_hit_num >= level.doa.rules.tesla_max_enemies_killed) {
        return true;
    }
    radius_decay = level.doa.rules.tesla_radius_decay * arc_num;
    if (level.doa.rules.tesla_radius_start - radius_decay <= 0) {
        return true;
    }
    return false;
}

// Namespace namespace_3f3eaecb
// Params 3, eflags: 0x0
// Checksum 0xfcd2a288, Offset: 0x9f0
// Size: 0x165
function function_da0cecf0(origin, distance, player) {
    distance_squared = distance * distance;
    enemies = [];
    if (!isdefined(player.tesla_enemies)) {
        player.tesla_enemies = getaispeciesarray("axis", "all");
        player.tesla_enemies = util::get_array_of_closest(origin, player.tesla_enemies);
    }
    zombies = player.tesla_enemies;
    if (isdefined(zombies)) {
        for (i = 0; i < zombies.size; i++) {
            if (!isdefined(zombies[i])) {
                continue;
            }
            test_origin = zombies[i] gettagorigin("j_head");
            if (isdefined(zombies[i].var_128cd975) && zombies[i].var_128cd975 == 1) {
                continue;
            }
            if (distancesquared(origin, test_origin) > distance_squared) {
                continue;
            }
            if (!bullettracepassed(origin, test_origin, 0, undefined)) {
                continue;
            }
            enemies[enemies.size] = zombies[i];
        }
    }
    return enemies;
}

// Namespace namespace_3f3eaecb
// Params 2, eflags: 0x0
// Checksum 0xdd65bc6b, Offset: 0xb60
// Size: 0x6a
function function_62bddefd(enemy, hit) {
    if (!isdefined(enemy)) {
        return;
    }
    if (isarray(enemy)) {
        for (i = 0; i < enemy.size; i++) {
            enemy[i].var_128cd975 = hit;
        }
        return;
    }
    enemy.var_128cd975 = hit;
}

// Namespace namespace_3f3eaecb
// Params 3, eflags: 0x0
// Checksum 0x4200dd45, Offset: 0xbd8
// Size: 0x1f2
function function_55a2b33e(source_enemy, arc_num, player) {
    player endon(#"disconnect");
    timetowait = 0.2 * arc_num;
    if (timetowait > 0) {
        wait timetowait;
    }
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    if (!(isdefined(self.isdog) && self.isdog)) {
        if (isdefined(self.iscrawler) && (isdefined(self.missinglegs) && self.missinglegs || self.iscrawler)) {
            self.deathanim = array::random(level.var_2a98be55[self.animname]);
        } else {
            self.deathanim = array::random(level.var_c58bb885[self.animname]);
        }
    } else {
        self.a.nodeath = undefined;
    }
    if (isdefined(source_enemy) && source_enemy != self) {
        source_enemy tesla_play_arc_fx(self);
    }
    self.tesla_death = 1;
    self thread function_c80ea8b9(arc_num);
    origin = player.origin;
    if (isdefined(source_enemy) && source_enemy != self) {
        origin = source_enemy.origin;
    }
    if (self.archetype == "zombie") {
        self clientfield::set("zombie_gut_explosion", 1);
    }
    if (self.archetype == "robot") {
        self namespace_fba031c8::function_7b3e39cb();
    }
    if (isdefined(self.tesla_damage_func)) {
        self [[ self.tesla_damage_func ]](origin, player);
        return;
    }
    self dodamage(self.health + 666, origin, player, player);
}

// Namespace namespace_3f3eaecb
// Params 1, eflags: 0x0
// Checksum 0x5c435083, Offset: 0xdd8
// Size: 0x70
function function_c80ea8b9(arc_num) {
    if (arc_num > 1) {
        self thread namespace_eaa992c::function_285a2999("tesla_shock_eyes");
    }
    self thread namespace_eaa992c::function_285a2999("tesla_shock");
    self thread namespace_1a381543::function_90118d8c("zmb_pwup_coco_impact");
    if (isdefined(self.tesla_head_gib_func)) {
        [[ self.tesla_head_gib_func ]]();
    }
}

// Namespace namespace_3f3eaecb
// Params 1, eflags: 0x0
// Checksum 0xe579b9f5, Offset: 0xe50
// Size: 0x1fa
function tesla_play_arc_fx(target) {
    if (!isdefined(self) || !isdefined(target)) {
        wait getdvarfloat("scr_arc_travel_time", 0.05);
        return;
    }
    tag = "J_SpineUpper";
    if (self.isdog) {
        tag = "J_Spine1";
    }
    target_tag = "J_SpineUpper";
    if (target.isdog) {
        target_tag = "J_Spine1";
    }
    origin = self gettagorigin(tag);
    target_origin = target gettagorigin(target_tag);
    distsq = distancesquared(origin, target_origin);
    var_3d719a1d = distsq / -128 * -128;
    timemove = var_3d719a1d * getdvarfloat("scr_arc_travel_time", 0.05);
    if (timemove < 0.2) {
        timemove = 0.2;
    }
    fxorg = spawn("script_model", origin);
    fxorg.targetname = "tesla_trail";
    fxorg setmodel("tag_origin");
    fxorg thread namespace_eaa992c::function_285a2999("tesla_trail");
    fxorg thread namespace_1a381543::function_90118d8c("zmb_pwup_coco_bounce");
    fxorg moveto(target_origin, timemove);
    fxorg util::waittill_any_timeout(timemove + 1, "movedone");
    fxorg delete();
}

/#

    // Namespace namespace_3f3eaecb
    // Params 2, eflags: 0x0
    // Checksum 0xab1df309, Offset: 0x1058
    // Size: 0x55
    function function_acbdce5b(origin, distance) {
        if (getdvarint(#"hash_fa91ea91") != 3) {
            return;
        }
        start = gettime();
        while (gettime() < start + 3000) {
            wait 0.05;
        }
    }

#/

// Namespace namespace_3f3eaecb
// Params 0, eflags: 0x0
// Checksum 0xec337683, Offset: 0x10b8
// Size: 0x15
function function_88a72013() {
    return isdefined(self.tesla_death) && self.tesla_death;
}

// Namespace namespace_3f3eaecb
// Params 2, eflags: 0x0
// Checksum 0xe8da98c4, Offset: 0x10d8
// Size: 0xae
function function_395fdfb8(guy, attacker) {
    if (!isdefined(guy)) {
        return false;
    }
    if (isdefined(guy.boss) && guy.boss) {
        return false;
    }
    if (isdefined(guy.tesla_death) && (isdefined(guy.damagedby) && guy.damagedby == "tesla" || guy.tesla_death)) {
        return false;
    }
    if (function_398dc86c(attacker)) {
        guy.damagedby = "tesla";
        guy thread function_51e87beb(attacker);
        return true;
    }
    return false;
}

// Namespace namespace_3f3eaecb
// Params 2, eflags: 0x0
// Checksum 0xc0214556, Offset: 0x1190
// Size: 0x65
function function_8c768539(player, note) {
    player endon(note);
    player endon(#"disconnect");
    while (true) {
        self waittill(#"trigger", guy);
        if (level thread function_395fdfb8(guy, player)) {
            self.triggered = 1;
            break;
        }
    }
}

// Namespace namespace_3f3eaecb
// Params 2, eflags: 0x0
// Checksum 0x246051e1, Offset: 0x1200
// Size: 0xaf
function function_e3b41890(org, note) {
    self endon(note);
    self endon(#"disconnect");
    org playloopsound("zmb_pwup_coco_loop");
    level namespace_49107f3a::function_124b9a08();
    wait self namespace_49107f3a::function_1ded48e6(level.doa.rules.var_37d05402);
    org stopsounds();
    org stoploopsound(0.5);
    self thread namespace_1a381543::function_90118d8c("zmb_pwup_coco_end");
    self notify(note);
}

// Namespace namespace_3f3eaecb
// Params 2, eflags: 0x0
// Checksum 0x14800664, Offset: 0x12b8
// Size: 0x82
function function_ccf71744(org, vel) {
    self moveto(org.origin, 0.5);
    self util::waittill_any_timeout(1, "movedone");
    vel *= 0.4;
    self thread namespace_eaa992c::function_285a2999("tesla_launch");
    self physicslaunch(self.origin, vel);
}

// Namespace namespace_3f3eaecb
// Params 1, eflags: 0x0
// Checksum 0x5e2793d9, Offset: 0x1348
// Size: 0xe2
function function_89843a06(player) {
    self endon(#"death");
    player waittill(#"disconnect");
    for (i = 0; i < self.triggers.size; i++) {
        if (isdefined(self.triggers[i])) {
            self.triggers[i] delete();
            self.objects[i] unlink();
        }
    }
    wait 2;
    for (i = 0; i < self.objects.size; i++) {
        if (isdefined(self.objects[i])) {
            self.objects[i] delete();
        }
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_3f3eaecb
// Params 2, eflags: 0x0
// Checksum 0x480ae21d, Offset: 0x1438
// Size: 0x18a
function function_822f3ab1(org, note) {
    org endon(#"death");
    self util::waittill_any(note, "disconnect", "player_died", "kill_shield", "doa_playerVehiclePickup");
    if (isdefined(self)) {
        self notify(note);
    }
    for (i = 0; i < org.triggers.size; i++) {
        if (isdefined(org.triggers[i])) {
            org.triggers[i] delete();
            org.objects[i] unlink();
            if (isdefined(self)) {
                vel = org.objects[i].origin - self.origin;
                org.objects[i] thread function_ccf71744(org, vel);
            }
        }
    }
    wait 2;
    for (i = 0; i < org.objects.size; i++) {
        if (isdefined(org.objects[i])) {
            org.objects[i] delete();
        }
    }
    if (isdefined(self)) {
        self.doa.var_7f0b4e60 = undefined;
    }
    if (isdefined(org)) {
        org delete();
    }
}

// Namespace namespace_3f3eaecb
// Params 2, eflags: 0x0
// Checksum 0x45c5cf6d, Offset: 0x15d0
// Size: 0xdd
function function_50608835(org, note) {
    self endon(note);
    org endon(#"death");
    count = 0;
    while (true) {
        for (i = 0; i < org.objects.size; i++) {
            if (isdefined(org.triggers[i]) && isdefined(org.triggers[i].triggered)) {
                org.triggers[i] delete();
                org.objects[i] delete();
                count++;
                if (count >= 4) {
                    org stoploopsound(0.5);
                }
            }
        }
        wait 0.05;
    }
}

// Namespace namespace_3f3eaecb
// Params 2, eflags: 0x0
// Checksum 0xe7ccd22b, Offset: 0x16b8
// Size: 0x59
function function_be694794(org, note) {
    self endon(note);
    org endon(#"death");
    while (true) {
        org rotateto(org.angles + (0, 180, 0), 1);
        wait 1;
    }
}

// Namespace namespace_3f3eaecb
// Params 1, eflags: 0x0
// Checksum 0x8b18f904, Offset: 0x1720
// Size: 0x91
function function_8614ba51(org) {
    self endon(#"death");
    self endon(#"disconnect");
    for (i = 0; i < org.objects.size; i++) {
        if (isdefined(org.objects[i])) {
            org.objects[i] thread namespace_eaa992c::function_285a2999("tesla_trail");
            org.objects[i] thread namespace_eaa992c::function_285a2999("tesla_ball");
        }
    }
}

// Namespace namespace_3f3eaecb
// Params 0, eflags: 0x0
// Checksum 0x1b059fed, Offset: 0x17c0
// Size: 0x5e2
function tesla_blockers_update() {
    note = namespace_49107f3a::function_2ccf4b82("end_tesla_pickup");
    self endon(note);
    self thread function_2f9ce7f8();
    org = spawn("script_model", self.origin);
    org.targetname = "tesla_blockers_update";
    org.angles = (0, randomint(-76), 0);
    def = namespace_a7e6beb5::function_bac08508(6);
    self.doa.var_7f0b4e60 = org;
    org setmodel("tag_origin");
    org linkto(self, "tag_origin");
    tesla = spawn("script_model", self.origin);
    tesla.targetname = "teslaball1";
    tesla setmodel(level.doa.var_f6e22ab8);
    tesla setscale(def.scale);
    tesla linkto(org, "tag_origin", (0, 60, 50));
    trigger = spawn("trigger_radius", tesla.origin, 9, 18, 50);
    trigger.targetname = "tesla1";
    trigger enablelinkto();
    trigger linkto(tesla);
    trigger thread function_8c768539(self, note);
    org.objects[0] = tesla;
    org.triggers[0] = trigger;
    tesla = spawn("script_model", self.origin);
    tesla.targetname = "teslaball2";
    tesla setmodel(level.doa.var_f6e22ab8);
    tesla setscale(def.scale);
    tesla linkto(org, "tag_origin", (0, -60, 50));
    trigger = spawn("trigger_radius", tesla.origin, 9, 18, 50);
    trigger.targetname = "tesla2";
    trigger enablelinkto();
    trigger linkto(tesla);
    trigger thread function_8c768539(self, note);
    org.objects[1] = tesla;
    org.triggers[1] = trigger;
    tesla = spawn("script_model", self.origin);
    tesla.targetname = "teslaball3";
    tesla setmodel(level.doa.var_f6e22ab8);
    tesla setscale(def.scale);
    tesla linkto(org, "tag_origin", (60, 0, 50));
    trigger = spawn("trigger_radius", tesla.origin, 9, 18, 50);
    trigger.targetname = "tesla3";
    trigger enablelinkto();
    trigger linkto(tesla);
    trigger thread function_8c768539(self, note);
    org.objects[2] = tesla;
    org.triggers[2] = trigger;
    tesla = spawn("script_model", self.origin);
    tesla.targetname = "teslaball4";
    tesla setmodel(level.doa.var_f6e22ab8);
    tesla setscale(def.scale);
    tesla linkto(org, "tag_origin", (-60, 0, 50));
    trigger = spawn("trigger_radius", tesla.origin, 9, 18, 50);
    trigger.targetname = "tesla4";
    trigger enablelinkto();
    trigger linkto(tesla);
    trigger thread function_8c768539(self, note);
    org.objects[3] = tesla;
    org.triggers[3] = trigger;
    util::wait_network_frame();
    self thread function_be694794(org, note);
    self thread function_8614ba51(org);
    self thread function_50608835(org, note);
    self thread function_e3b41890(org, note);
    self thread function_822f3ab1(org, note);
    org thread function_89843a06(self);
}

