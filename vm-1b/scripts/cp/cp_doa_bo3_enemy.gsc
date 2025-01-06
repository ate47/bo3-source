#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/cp_doa_bo3_fx;
#using scripts/cp/cp_doa_bo3_sound;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_core;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_enemy_boss;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_hazard;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/util_shared;

#namespace namespace_51bd792;

// Namespace namespace_51bd792
// Params 0, eflags: 0x0
// Checksum 0xc43ab949, Offset: 0xbe0
// Size: 0x8a
function init() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("doaWarlordShouldSDoSpecial", &doaWarlordShouldSDoSpecial);
    behaviortreenetworkutility::registerbehaviortreeaction("doaWarlordSpecialAction", &function_c9e4e727, &function_c238a312, undefined);
    behaviortreenetworkutility::registerbehaviortreescriptapi("doaWarlordUpdateToGoal", &doaWarlordUpdateToGoal);
}

// Namespace namespace_51bd792
// Params 1, eflags: 0x0
// Checksum 0xc86abde0, Offset: 0xc78
// Size: 0x4aa
function function_3e45b9db(classname) {
    spawners = getspawnerarray();
    foreach (spawner in spawners) {
        if (isdefined(spawner.archetype) && spawner.archetype == classname || spawner.classname == "script_vehicle" && issubstr(spawner.vehicletype, classname)) {
            var_3a9f2119 = spawner;
            break;
        }
        if (spawner.classname == classname) {
            var_3a9f2119 = spawner;
            break;
        }
        if (isdefined(spawner.script_parameters)) {
            type = strtok(spawner.script_parameters, ":");
            if (classname == type[1]) {
                var_3a9f2119 = spawner;
                break;
            }
        }
    }
    if (isdefined(var_3a9f2119)) {
        def = spawnstruct();
        def.var_83bae1f8 = 4000;
        def.var_3eea3245 = 4000;
        loc = spawnstruct();
        loc.origin = namespace_49107f3a::function_308fa126(1)[0];
        loc.angles = (0, 0, 0);
        if (issubstr(classname, "smokeman")) {
            function_b9980eda(var_3a9f2119, loc, def);
            return;
        }
        if (issubstr(classname, "parasite_purple")) {
            function_33525e11(var_3a9f2119, loc, def);
            return;
        }
        if (issubstr(classname, "parasite")) {
            function_1631202b(var_3a9f2119, loc, def);
            return;
        }
        if (issubstr(classname, "meatball")) {
            function_fb051310(var_3a9f2119, loc, def);
            return;
        }
        if (issubstr(classname, "cellbreaker")) {
            function_5e86b6fa(var_3a9f2119, loc, def);
            return;
        }
        if (issubstr(classname, "riser")) {
            function_45849d81(var_3a9f2119, loc, def);
            return;
        }
        if (issubstr(classname, "skeleton")) {
            doa_enemy::function_a4e16560(getent("spawner_zombietron_skeleton", "targetname"), loc);
            return;
        }
        if (issubstr(classname, "collector")) {
            function_53b44cb7(spawner, loc, def, 1);
            return;
        }
        if (issubstr(classname, "basic")) {
            doa_enemy::function_a4e16560(getent("doa_basic_spawner", "targetname"), loc);
            return;
        }
        if (issubstr(classname, "warlord")) {
            function_a0d7d949(var_3a9f2119, loc, def);
            return;
        }
        if (issubstr(classname, "_dog")) {
            function_bb3b0416(var_3a9f2119, loc, def);
            return;
        }
        if (issubstr(classname, "_robot")) {
            function_4d2a4a76(var_3a9f2119, loc, def);
            return;
        }
        if (issubstr(classname, "silverback")) {
            function_36aa8b6c(loc);
            return;
        }
        if (issubstr(classname, "margwa")) {
            doa_enemy::function_a4e16560(getent("doa_margwa_spawner", "targetname"), loc);
        }
    }
}

// Namespace namespace_51bd792
// Params 1, eflags: 0x0
// Checksum 0xe9f77aa9, Offset: 0x1130
// Size: 0x13e
function function_36aa8b6c(loc) {
    ai = doa_enemy::function_a4e16560(level.doa.var_55dddb3a, loc, 1);
    if (isdefined(ai)) {
        ai.spawner = level.doa.var_55dddb3a;
        ai.team = "axis";
        ai.boss = 1;
        ai.health = getdvarint("scr_boss_silverback_health", 2000000);
        ai.maxhealth = ai.health;
        ai.ignorevortices = 1;
        ai.var_2d8174e3 = 1;
        ai.takedamage = 0;
        ai namespace_eaa992c::function_285a2999("cyber_eye");
        ai forceteleport(loc.origin, loc.angles);
        ai notify(#"hash_10fd80ee");
        ai notify(#"hash_6e8326fc");
        ai notify(#"hash_6dcbb83e");
        ai notify(#"hash_d96c599c");
        ai notify(#"hash_67a97d62");
    }
    return ai;
}

// Namespace namespace_51bd792
// Params 3, eflags: 0x0
// Checksum 0x9a5ab960, Offset: 0x1278
// Size: 0x108
function function_a0d7d949(spawner, loc, def) {
    ai = doa_enemy::function_a4e16560(spawner, loc);
    if (isdefined(ai)) {
        ai.spawner = spawner;
        ai.team = "axis";
        ai.health = def.var_83bae1f8 + -106 * level.doa.round_number;
        if (isdefined(def.var_3eea3245) && ai.health > def.var_3eea3245) {
            ai.health = def.var_3eea3245;
        }
        ai.maxhealth = ai.health;
        ai.ignorevortices = 1;
        ai.var_2d8174e3 = 1;
        ai.var_55361ee6 = randomint(3);
        ai.var_bd88b697 = 0;
    }
    return ai;
}

// Namespace namespace_51bd792
// Params 3, eflags: 0x0
// Checksum 0x7690f0b1, Offset: 0x1388
// Size: 0x188
function function_bb3b0416(spawner, loc, def) {
    spawn_set = level.doa.arenas[level.doa.var_90873830].name + "_enemy_spawn";
    if (level.doa.spawners[spawn_set]["wolf"].size == 0) {
        return;
    }
    loc = level.doa.spawners[spawn_set]["wolf"][randomint(level.doa.spawners[spawn_set]["wolf"].size)];
    ai = doa_enemy::function_a4e16560(spawner, loc);
    if (isdefined(ai)) {
        ai.spawner = spawner;
        ai.team = "axis";
        ai.health = def.var_83bae1f8 + -106 * level.doa.round_number;
        ai.meleedamage = 50;
        if (isdefined(def.var_3eea3245) && ai.health > def.var_3eea3245) {
            ai.health = def.var_3eea3245;
        }
        ai.maxhealth = ai.health;
        ai.var_2d8174e3 = 1;
    }
    return ai;
}

// Namespace namespace_51bd792
// Params 3, eflags: 0x0
// Checksum 0x637d27ac, Offset: 0x1518
// Size: 0x10c
function function_5e86b6fa(spawner, loc, def) {
    ai = doa_enemy::function_a4e16560(spawner, loc);
    if (isdefined(ai)) {
        ai.spawner = spawner;
        ai.team = "axis";
        if (isdefined(def)) {
            ai.health = def.var_83bae1f8 + -106 * level.doa.round_number;
            if (isdefined(def.var_3eea3245) && ai.health > def.var_3eea3245) {
                ai.health = def.var_3eea3245;
            }
        }
        ai.zombie_move_speed = "walk";
        ai.ignorevortices = 1;
        ai.maxhealth = ai.health;
        ai thread droptoground();
        ai thread function_9a5d69ac();
    }
    return ai;
}

// Namespace namespace_51bd792
// Params 5, eflags: 0x0
// Checksum 0xf530bb76, Offset: 0x1630
// Size: 0x41a
function droptoground(origin, trailfx, impactfx, var_96214f04, var_7c5f2b05) {
    if (!isdefined(impactfx)) {
        impactfx = "turret_impact";
    }
    if (!isdefined(var_96214f04)) {
        var_96214f04 = 1;
    }
    if (!isdefined(var_7c5f2b05)) {
        var_7c5f2b05 = 1;
    }
    self endon(#"death");
    self.ignoreall = 1;
    if (!isdefined(origin)) {
        goalpoints = namespace_49107f3a::function_308fa126(10);
        goalpoint = goalpoints[randomint(goalpoints.size)];
    } else {
        goalpoint = origin;
    }
    if (var_7c5f2b05) {
        dst = spawn("script_model", goalpoint + (randomfloatrange(-100, 100), randomfloatrange(-100, 100), 0) + (0, 0, 12));
    } else {
        dst = spawn("script_model", goalpoint + (0, 0, 12));
    }
    dst.targetname = "dropToGround";
    dst setmodel("tag_origin");
    dst.angles = (0, randomint(-76), 0);
    if (isdefined(var_96214f04) && var_96214f04) {
        dst thread namespace_eaa992c::function_285a2999("incoming_impact");
    }
    dst thread namespace_49107f3a::function_1bd67aef(3);
    pos = dst.origin + (0, 0, 2000);
    if (isactor(self)) {
        self forceteleport(pos, dst.angles);
    } else {
        self.origin = pos;
    }
    org = spawn("script_model", pos);
    org.targetname = "dropToGroundOrg";
    org setmodel("tag_origin");
    if (isdefined(trailfx)) {
        org thread namespace_eaa992c::function_285a2999(trailfx);
    }
    org thread namespace_49107f3a::function_1bd67aef(2);
    self enablelinkto();
    org enablelinkto();
    self linkto(org, "tag_origin");
    org moveto(dst.origin, 1.2);
    org thread namespace_1a381543::function_90118d8c("zmb_enemy_incoming");
    org util::waittill_any_timeout(1.5, "movedone");
    org thread namespace_1a381543::function_90118d8c("zmb_enemy_impact");
    physicsexplosionsphere(dst.origin, -56, -128, 3);
    playrumbleonposition("grenade_rumble", dst.origin);
    self unlink();
    if (isactor(self)) {
        self forceteleport(dst.origin, dst.angles);
    } else {
        self.origin = dst.origin;
    }
    dst thread namespace_eaa992c::function_285a2999(impactfx);
    util::wait_network_frame();
    self.ignoreall = 0;
    if (isdefined(org)) {
        org delete();
    }
    if (isdefined(dst)) {
        dst delete();
    }
}

// Namespace namespace_51bd792
// Params 0, eflags: 0x4
// Checksum 0xc57abf42, Offset: 0x1a58
// Size: 0x32
function private function_9a5d69ac() {
    self endon(#"death");
    self.zombie_move_speed = "walk";
    self waittill(#"damage");
    self.zombie_move_speed = "sprint";
}

// Namespace namespace_51bd792
// Params 0, eflags: 0x0
// Checksum 0x5101415a, Offset: 0x1a98
// Size: 0x5a
function function_a1f1cd46() {
    self waittill(#"death");
    if (isdefined(self) && isdefined(self.origin)) {
        physicsexplosionsphere(self.origin, -128, -128, 2);
        radiusdamage(self.origin, 48, 100, 100);
    }
}

// Namespace namespace_51bd792
// Params 0, eflags: 0x0
// Checksum 0x77bd3f30, Offset: 0x1b00
// Size: 0x4
function function_d45df351() {
    return 125;
}

// Namespace namespace_51bd792
// Params 3, eflags: 0x0
// Checksum 0x191e9333, Offset: 0x1b10
// Size: 0x15c
function function_4d2a4a76(spawner, loc, def) {
    ai = doa_enemy::function_a4e16560(spawner, loc);
    if (isdefined(ai)) {
        ai ai::set_behavior_attribute("rogue_allow_pregib", 0);
        ai.spawner = spawner;
        ai.health = def.var_83bae1f8 + -106 * level.doa.round_number;
        if (isdefined(def.var_3eea3245) && ai.health > def.var_3eea3245) {
            ai.health = def.var_3eea3245;
        }
        ai.maxhealth = ai.health;
        ai.var_2d8174e3 = 1;
        ai.ignorevortices = 1;
        ai.custom_damage_func = &function_d45df351;
        ai ai::set_behavior_attribute("rogue_control", "forced_level_3");
        ai ai::set_behavior_attribute("rogue_control_speed", "sprint");
        ai.team = "axis";
        ai thread function_a1f1cd46();
    }
    return ai;
}

// Namespace namespace_51bd792
// Params 0, eflags: 0x0
// Checksum 0x77bd3f30, Offset: 0x1c78
// Size: 0x4
function function_d4213fbb() {
    return 125;
}

// Namespace namespace_51bd792
// Params 6, eflags: 0x0
// Checksum 0x291d2cfa, Offset: 0x1c88
// Size: 0x1e4
function function_fb051310(spawner, loc, def, droptoground, hp, force) {
    if (!isdefined(droptoground)) {
        droptoground = 1;
    }
    if (!isdefined(force)) {
        force = 0;
    }
    ai = doa_enemy::function_a4e16560(spawner, loc, force);
    if (isdefined(ai)) {
        ai.team = "axis";
        if (isdefined(def)) {
            ai.health = def.var_83bae1f8;
        } else {
            ai.health = 1000;
        }
        ai.health += -106 * level.doa.round_number;
        if (isdefined(hp)) {
            ai.health = hp;
        }
        if (isdefined(def) && isdefined(def.var_3eea3245) && ai.health > def.var_3eea3245) {
            ai.health = def.var_3eea3245;
        }
        ai.maxhealth = ai.health;
        ai.spawner = spawner;
        ai.var_2d8174e3 = 1;
        ai.def = def;
        ai.var_cb05ea19 = 1;
        ai.custom_damage_func = &function_d4213fbb;
        ai callback::add_callback(#"hash_acb66515", &function_7ebf419e);
        ai thread namespace_49107f3a::function_dbcf48a0();
        if (isdefined(droptoground) && droptoground) {
            ai thread droptoground(undefined, "meatball_trail", "meatball_impact");
        }
    }
    return ai;
}

// Namespace namespace_51bd792
// Params 0, eflags: 0x0
// Checksum 0xdac9108b, Offset: 0x1e78
// Size: 0x2aa
function function_7ebf419e() {
    if (!isdefined(level.doa.var_b2669ad0)) {
        level.doa.var_b2669ad0 = [];
        level.doa.var_b2669ad0["medium"] = getent("spawner_meatball_med", "targetname");
        level.doa.var_b2669ad0["small"] = getent("spawner_meatball_small", "targetname");
    }
    loc = spawnstruct();
    loc.angles = self.angles;
    loc.origin = self.origin;
    loc.def = self.def;
    level cp_doa_bo3_fx::function_977dfbe0(loc.origin);
    if (self.model == "veh_t7_drone_insanity_elemental_v2_large") {
        function_fb051310(level.doa.var_b2669ad0["medium"], loc, loc.def, 0, 600, 1);
        loc.origin += (randomfloatrange(-40, 40), randomfloatrange(-40, 40), 32);
        level cp_doa_bo3_fx::function_977dfbe0(loc.origin);
        function_fb051310(level.doa.var_b2669ad0["medium"], loc, loc.def, 0, 600, 1);
        return;
    }
    if (self.model == "veh_t7_drone_insanity_elemental_v2_med") {
        function_fb051310(level.doa.var_b2669ad0["small"], loc, loc.def, 0, 100, 1);
        loc.origin += (randomfloatrange(-40, 40), randomfloatrange(-40, 40), 32);
        level cp_doa_bo3_fx::function_977dfbe0(loc.origin);
        function_fb051310(level.doa.var_b2669ad0["small"], loc, loc.def, 0, 100, 1);
    }
}

// Namespace namespace_51bd792
// Params 0, eflags: 0x0
// Checksum 0xff609a3f, Offset: 0x2130
// Size: 0x3a
function function_307cc86e() {
    self endon(#"death");
    self waittill(#"goal");
    self setgoal(namespace_3ca3c537::function_2a9d778d() + (0, 0, 42), 0);
}

// Namespace namespace_51bd792
// Params 3, eflags: 0x0
// Checksum 0x379a7883, Offset: 0x2178
// Size: 0x284
function function_1631202b(spawner, loc, def) {
    if (isdefined(level.doa.arenas[level.doa.var_90873830].var_fe390b01) && level.doa.arenas[level.doa.var_90873830].var_fe390b01.size) {
        loc = level.doa.arenas[level.doa.var_90873830].var_fe390b01[randomint(level.doa.arenas[level.doa.var_90873830].var_fe390b01.size)];
    }
    ai = doa_enemy::function_a4e16560(spawner, loc);
    if (isdefined(ai)) {
        ai.team = "axis";
        if (isdefined(def)) {
            ai.health = def.var_83bae1f8 + -106 * level.doa.round_number;
            if (isdefined(def.var_3eea3245) && ai.health > def.var_3eea3245) {
                ai.health = def.var_3eea3245;
            }
        } else {
            ai.health = 100;
        }
        ai.maxhealth = ai.health;
        ai.spawner = spawner;
        ai.var_2d8174e3 = 1;
        ai.holdfire = 0;
        ai.var_b7e79322 = 1;
        ai.var_65e0af26 = 1;
        ai.meleedamage = 0;
        ai.var_7c26245 = 1;
        ai.goalradius = 512;
        goal = namespace_3ca3c537::function_2a9d778d();
        spots = namespace_49107f3a::function_308fa126();
        if (isdefined(spots) && spots.size) {
            goal = spots[randomint(spots.size)];
        }
        goal += (0, 0, 42);
        ai setgoal(goal, 1);
        ai.updatesight = 1;
        ai thread function_307cc86e();
    }
    return ai;
}

// Namespace namespace_51bd792
// Params 3, eflags: 0x0
// Checksum 0x292a0499, Offset: 0x2408
// Size: 0x280
function function_33525e11(spawner, loc, def) {
    if (isdefined(level.doa.arenas[level.doa.var_90873830].var_fe390b01) && level.doa.arenas[level.doa.var_90873830].var_fe390b01.size) {
        loc = level.doa.arenas[level.doa.var_90873830].var_fe390b01[randomint(level.doa.arenas[level.doa.var_90873830].var_fe390b01.size)];
    }
    ai = doa_enemy::function_a4e16560(spawner, loc);
    if (isdefined(ai)) {
        ai.team = "axis";
        if (isdefined(def)) {
            ai.health = def.var_83bae1f8 + -106 * level.doa.round_number;
            if (isdefined(def.var_3eea3245) && ai.health > def.var_3eea3245) {
                ai.health = def.var_3eea3245;
            }
        } else {
            ai.health = 100;
        }
        ai.maxhealth = ai.health;
        ai.spawner = spawner;
        ai.var_2d8174e3 = 1;
        ai.var_b7e79322 = 1;
        ai.var_dcdf7239 = 1;
        ai.holdfire = 0;
        ai.meleedamage = 0;
        ai.var_7c26245 = 1;
        ai.goalradius = 512;
        goal = namespace_3ca3c537::function_2a9d778d();
        spots = namespace_49107f3a::function_308fa126();
        if (isdefined(spots) && spots.size) {
            goal = spots[randomint(spots.size)];
        }
        goal += (0, 0, 42);
        ai setgoal(goal, 1);
        ai thread function_307cc86e();
        ai.updatesight = 1;
    }
    return ai;
}

// Namespace namespace_51bd792
// Params 3, eflags: 0x0
// Checksum 0x17ca2f2, Offset: 0x2690
// Size: 0xe0
function function_ce9bce16(spawner, loc, def) {
    ai = doa_enemy::function_a4e16560(spawner, loc);
    if (isdefined(ai)) {
        ai.team = "axis";
        ai.health = def.var_83bae1f8 + -106 * level.doa.round_number;
        if (isdefined(def.var_3eea3245) && ai.health > def.var_3eea3245) {
            ai.health = def.var_3eea3245;
        }
        ai.maxhealth = ai.health;
        ai.spawner = spawner;
        ai.var_7c26245 = 1;
        ai.goalradius = 64;
    }
    return ai;
}

// Namespace namespace_51bd792
// Params 3, eflags: 0x0
// Checksum 0x66af2a7d, Offset: 0x2778
// Size: 0x194
function function_b9980eda(spawner, loc, def) {
    ai = doa_enemy::function_a4e16560(spawner, loc);
    if (isdefined(ai)) {
        ai.team = "axis";
        ai.health = def.var_83bae1f8 + -106 * level.doa.round_number;
        if (isdefined(def.var_3eea3245) && ai.health > def.var_3eea3245) {
            ai.health = def.var_3eea3245;
        }
        ai.maxhealth = ai.health;
        ai.spawner = spawner;
        ai.var_7c26245 = 1;
        ai.goalradius = 64;
        ai.var_daa07413 = randomint(2) + 1;
        ai.var_2ea42113 = 20;
        ai.var_52b0b328 = 1;
        ai.var_2d8174e3 = 1;
        ai.allowdeath = 0;
        ai.zombie_move_speed = "sprint";
        ai.var_7ebc405c = 1;
        aiutility::addaioverridedamagecallback(ai, &function_c1b5c042);
        ai thread shadowteleportmenow(1);
        ai playloopsound("zmb_smokeman_looper");
    }
    return ai;
}

// Namespace namespace_51bd792
// Params 2, eflags: 0x0
// Checksum 0x4c9a329e, Offset: 0x2918
// Size: 0xb3
function function_ef4fa49d(&spots, mindist) {
    if (!isdefined(mindist)) {
        mindist = 300;
    }
    mindistsq = mindist * mindist;
    var_e383b1a4 = [];
    foreach (spot in spots) {
        if (distancesquared(spot.origin, self.origin) >= mindistsq) {
            var_e383b1a4[var_e383b1a4.size] = spot;
        }
    }
    return var_e383b1a4;
}

// Namespace namespace_51bd792
// Params 1, eflags: 0x0
// Checksum 0x3f8a9901, Offset: 0x29d8
// Size: 0x2d2
function shadowteleportmenow(initial) {
    if (!isdefined(initial)) {
        initial = 0;
    }
    self endon(#"death");
    if (!initial) {
        self.var_daa07413--;
    }
    spots = namespace_49107f3a::function_8fc4387a(16);
    var_5eccf055 = function_ef4fa49d(spots);
    if (var_5eccf055.size > 0) {
        if (var_5eccf055.size == 1) {
            goal = var_5eccf055[0];
        } else {
            goal = var_5eccf055[randomint(var_5eccf055.size)];
        }
    }
    if (!isdefined(goal)) {
        goal = arraygetfarthest(self.origin, spots);
    }
    self.ignoreall = 1;
    self.takedamage = 0;
    self thread namespace_eaa992c::function_285a2999("shadow_fade");
    wait 0.1;
    org = spawn("script_model", self.origin + (0, 0, 40));
    org.targetname = "shadowTeleportMeNow";
    org setmodel("tag_origin");
    org thread namespace_49107f3a::function_981c685d(self);
    org thread namespace_eaa992c::function_285a2999("shadow_move");
    org thread namespace_eaa992c::function_285a2999("shadow_glow");
    org thread namespace_1a381543::function_90118d8c("zmb_enemy_smokeman_poof");
    wait 0.3;
    self ghost();
    self notsolid();
    self linkto(org);
    org moveto(goal.origin + (0, 0, 40), 2);
    org util::waittill_any_timeout(2.1, "movedone");
    org thread namespace_eaa992c::function_285a2999("shadow_appear");
    wait 1;
    org thread namespace_1a381543::function_90118d8c("zmb_enemy_smokeman_wings");
    wait 1;
    self unlink();
    org thread namespace_1a381543::function_90118d8c("zmb_enemy_smokeman_poof");
    self forceteleport(org.origin);
    self.ignoreall = 0;
    self.takedamage = 1;
    self show();
    self solid();
    wait 1;
    org delete();
}

// Namespace namespace_51bd792
// Params 15, eflags: 0x0
// Checksum 0x2143a957, Offset: 0x2cb8
// Size: 0xfc
function function_c1b5c042(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal) {
    if (self.var_daa07413 > 0) {
        if (idamage > self.health) {
            idamage = self.health - 1;
        }
        self thread shadowteleportmenow();
    }
    if (self.health == 1) {
        self thread namespace_eaa992c::function_285a2999("shadow_die");
        self.takedamage = 0;
        self.aioverridedamage = undefined;
        self thread namespace_49107f3a::function_ba30b321(0.1, eattacker, smeansofdeath);
    }
    return idamage;
}

// Namespace namespace_51bd792
// Params 2, eflags: 0x0
// Checksum 0x6f857183, Offset: 0x2dc0
// Size: 0x36
function function_575e3933(spawner, loc) {
    ai = doa_enemy::function_a4e16560(spawner, loc, 1);
    return ai;
}

// Namespace namespace_51bd792
// Params 2, eflags: 0x0
// Checksum 0xec1659e5, Offset: 0x2e00
// Size: 0x4c
function function_862e15fa(spawner, loc) {
    ai = doa_enemy::function_a4e16560(spawner, loc, 1);
    ai thread function_b6d31d3a(loc);
    return ai;
}

// Namespace namespace_51bd792
// Params 3, eflags: 0x0
// Checksum 0xaedd4581, Offset: 0x2e58
// Size: 0x178
function function_17de14f1(spawner, loc, def) {
    if (!isdefined(level.doa.var_e0d67a74) || level.doa.var_e0d67a74.size == 0) {
        return;
    }
    loc = level.doa.var_e0d67a74[randomint(level.doa.var_e0d67a74.size)];
    ai = doa_enemy::function_a4e16560(spawner, loc);
    if (isdefined(ai)) {
        ai thread function_b6d31d3a(loc, 0, "zombie_bloodriser_fx");
        ai.spawner = spawner;
        ai.team = "axis";
        ai.var_ad61c13d = 1;
        if (isdefined(def)) {
            ai.health = def.var_83bae1f8 + -106 * level.doa.round_number;
            if (isdefined(def.var_3eea3245) && ai.health > def.var_3eea3245) {
                ai.health = def.var_3eea3245;
            }
        }
        ai.maxhealth = ai.health;
        if (ai.zombie_move_speed == "walk") {
            ai.zombie_move_speed = "run";
        }
    }
    return ai;
}

// Namespace namespace_51bd792
// Params 3, eflags: 0x0
// Checksum 0xf52be48a, Offset: 0x2fd8
// Size: 0x21c
function function_45849d81(spawner, loc, def) {
    if (!isdefined(loc) && level.doa.var_e0d67a74.size == 0) {
        return undefined;
    }
    if (isdefined(level.doa.var_d0cde02c) && isdefined(def) && level.doa.var_d0cde02c == def) {
        loc = undefined;
        if (!(isdefined(def.initialized) && def.initialized)) {
            level thread function_28cdab69(def);
        }
    }
    if (!isdefined(loc)) {
        loc = level.doa.var_e0d67a74[randomint(level.doa.var_e0d67a74.size)];
    }
    ai = doa_enemy::function_a4e16560(spawner, loc);
    if (isdefined(ai)) {
        var_8e0955df = 0;
        if (isdefined(level.doa.var_d0cde02c) && isdefined(def) && level.doa.var_d0cde02c == def) {
            level thread function_be745286(def, ai);
            var_8e0955df = 1;
        }
        ai thread function_b6d31d3a(loc, var_8e0955df);
        ai.spawner = spawner;
        ai.team = "axis";
        if (isdefined(def)) {
            ai.health = def.var_83bae1f8 + -106 * level.doa.round_number;
            if (isdefined(def.var_3eea3245) && ai.health > def.var_3eea3245) {
                ai.health = def.var_3eea3245;
            }
        }
        ai.maxhealth = ai.health;
        if (ai.zombie_move_speed == "walk") {
            ai.zombie_move_speed = "run";
        }
    }
    return ai;
}

// Namespace namespace_51bd792
// Params 1, eflags: 0x4
// Checksum 0xf5cde68e, Offset: 0x3200
// Size: 0x107
function private function_28cdab69(def) {
    def.initialized = 1;
    def.var_40c7a009 = 0;
    targetsize = level.doa.var_e0d67a74.size;
    while (level flag::get("doa_round_spawning") && !level flag::get("doa_game_is_over")) {
        maxwait = 10000 + gettime();
        while (gettime() < maxwait && def.var_40c7a009 < targetsize && !level flag::get("doa_game_is_over") && flag::get("doa_round_spawning")) {
            wait 0.1;
        }
        targetsize = int(targetsize * 0.9);
        level notify(#"hash_36d5bf57");
        wait 5;
    }
    level notify(#"hash_36d5bf57");
}

// Namespace namespace_51bd792
// Params 2, eflags: 0x4
// Checksum 0x1cd06178, Offset: 0x3310
// Size: 0x2e
function private function_1ee8b18c(def, ai) {
    ai endon(#"hash_9757351b");
    ai waittill(#"death");
    def.var_40c7a009--;
}

// Namespace namespace_51bd792
// Params 2, eflags: 0x4
// Checksum 0x3b01dd77, Offset: 0x3348
// Size: 0x7a
function private function_be745286(def, ai) {
    ai endon(#"death");
    ai thread function_1ee8b18c(def, ai);
    def.var_40c7a009++;
    ai.ignoreall = 1;
    level waittill(#"hash_36d5bf57");
    if (isdefined(ai)) {
        ai notify(#"hash_9757351b");
        ai.ignoreall = 0;
        def.var_40c7a009--;
    }
}

// Namespace namespace_51bd792
// Params 3, eflags: 0x4
// Checksum 0x5c5a1dc3, Offset: 0x33d0
// Size: 0x1f1
function private function_b6d31d3a(spot, hold, fx) {
    if (!isdefined(hold)) {
        hold = 0;
    }
    if (!isdefined(fx)) {
        fx = "zombie_riser_fx";
    }
    self endon(#"death");
    self.var_9da96e67 = 1;
    self.anchor = spawn("script_origin", self.origin);
    self.anchor thread namespace_49107f3a::function_981c685d(self);
    self.anchor.angles = self.angles;
    self linkto(self.anchor);
    if (!isdefined(spot.angles)) {
        spot.angles = (0, 0, 0);
    }
    self ghost();
    self notsolid();
    if (hold) {
        level waittill(#"hash_36d5bf57");
    }
    wait randomfloatrange(0, 0.25);
    self unlink();
    if (isdefined(self.anchor)) {
        self.anchor delete();
    }
    self thread function_2f0633b5();
    level thread function_7c9f5521(self, spot);
    self clientfield::set(fx, 1);
    self orientmode("face default");
    self animscripted("rise_anim", self.origin, self.angles, "ai_zombie_traverse_ground_climbout_fast");
    self waittill(#"end");
    self solid();
    self notify(#"rise_anim_finished");
    self.var_9da96e67 = undefined;
}

// Namespace namespace_51bd792
// Params 0, eflags: 0x4
// Checksum 0xb7165eaa, Offset: 0x35d0
// Size: 0x2a
function private function_2f0633b5() {
    self endon(#"death");
    wait 0.5;
    if (isdefined(self)) {
        self show();
    }
}

// Namespace namespace_51bd792
// Params 2, eflags: 0x4
// Checksum 0xb0d9bdb0, Offset: 0x3608
// Size: 0x82
function private function_7c9f5521(zombie, spot) {
    zombie endon(#"rise_anim_finished");
    while (isdefined(zombie) && isdefined(zombie.health) && zombie.health > 1) {
        zombie waittill(#"damage", amount);
    }
    if (isdefined(zombie)) {
        zombie.deathanim = "zm_rise_death_in";
        zombie stopanimscripted();
    }
}

// Namespace namespace_51bd792
// Params 1, eflags: 0x0
// Checksum 0xe737f835, Offset: 0x3698
// Size: 0x59
function doaWarlordShouldSDoSpecial(var_bbd280b0) {
    if (isdefined(var_bbd280b0.var_9aa7ba9b)) {
        return 1;
    }
    if (!isdefined(var_bbd280b0.var_55361ee6)) {
        return 0;
    }
    if (var_bbd280b0.var_55361ee6 <= 0) {
        return 0;
    }
    if (!isdefined(var_bbd280b0.var_8f12ed02)) {
        return 0;
    }
    return var_bbd280b0 isatgoal();
}

// Namespace namespace_51bd792
// Params 0, eflags: 0x0
// Checksum 0xf0f94e4f, Offset: 0x3700
// Size: 0x151
function doWarlordPlantAnimation() {
    self endon(#"death");
    waittillframeend();
    if (isalive(self) && !self isragdoll()) {
        self.var_30fc80e6 = 1;
        self animscripted("plant_anim", self.origin, self.angles, "ai_wrlrd_stn_combat_doa_plant_mine");
        self waittillmatch(#"plant_anim", "planted");
    }
    self.var_55361ee6 = self.var_55361ee6 - 1;
    bomb = spawn("script_model", self.origin);
    bomb.targetname = "doWarlordPlantAnimation";
    bomb setmodel("zombietron_Warlord_mine");
    bomb playsound("zmb_bomb_initialized");
    bomb playloopsound("zmb_bomb_looper", 1);
    bomb thread namespace_eaa992c::function_285a2999("explo_warning_light");
    bomb thread function_97fb783(5);
    bomb.takedamage = 1;
    self waittillmatch(#"plant_anim", "end");
    self.var_30fc80e6 = undefined;
}

// Namespace namespace_51bd792
// Params 2, eflags: 0x0
// Checksum 0xb6957813, Offset: 0x3860
// Size: 0x8c
function function_c9e4e727(var_bbd280b0, asmstatename) {
    if (isdefined(var_bbd280b0.var_30fc80e6)) {
        return 5;
    }
    if (var_bbd280b0.var_bd88b697 > gettime()) {
        return 5;
    }
    var_bbd280b0 thread doWarlordPlantAnimation();
    var_bbd280b0.var_8f12ed02 = undefined;
    var_bbd280b0.var_bd88b697 = gettime() + randomintrange(3, 8) * 1000;
    animationstatenetworkutility::requeststate(var_bbd280b0, asmstatename);
    return 5;
}

// Namespace namespace_51bd792
// Params 2, eflags: 0x0
// Checksum 0xbf8399cc, Offset: 0x38f8
// Size: 0x38
function function_c238a312(var_bbd280b0, asmstatename) {
    if (isdefined(var_bbd280b0.var_30fc80e6)) {
        return 5;
    }
    if (var_bbd280b0.var_bd88b697 > gettime()) {
        return 5;
    }
    return 4;
}

// Namespace namespace_51bd792
// Params 1, eflags: 0x0
// Checksum 0xa798e829, Offset: 0x3938
// Size: 0xa2
function function_97fb783(fusetime) {
    wait fusetime;
    self util::waittill_any_timeout(fusetime, "damage");
    radiusdamage(self.origin, 72, 10000, 0, undefined, "MOD_GAS");
    self playsound("zmb_bomb_explode");
    self thread namespace_eaa992c::function_285a2999("def_explode");
    util::wait_network_frame();
    self delete();
}

// Namespace namespace_51bd792
// Params 1, eflags: 0x0
// Checksum 0xcdf248f, Offset: 0x39e8
// Size: 0x1e3
function doaWarlordUpdateToGoal(behaviortreeentity) {
    if (level flag::get("doa_game_is_over")) {
        behaviortreeentity doa_enemy::function_d30fe558(behaviortreeentity.origin);
        return true;
    }
    if (isdefined(behaviortreeentity.var_55361ee6) && behaviortreeentity.var_55361ee6 > 0) {
        if (!isdefined(behaviortreeentity.var_8f12ed02)) {
            goalpoints = namespace_49107f3a::function_308fa126(30);
            goalpoint = goalpoints[randomint(goalpoints.size)];
            points = util::positionquery_pointarray(goalpoint, 0, 512, 70, 80, 64);
            if (points.size > 0) {
                behaviortreeentity.var_8f12ed02 = getclosestpointonnavmesh(points[randomint(points.size)], 20, 16);
                behaviortreeentity doa_enemy::function_d30fe558(behaviortreeentity.var_8f12ed02);
            }
        } else {
            behaviortreeentity doa_enemy::function_d30fe558(behaviortreeentity.var_8f12ed02);
            return true;
        }
    }
    if (isdefined(behaviortreeentity.enemy)) {
        behaviortreeentity.favoriteenemy = behaviortreeentity.enemy;
        point = getclosestpointonnavmesh(behaviortreeentity.favoriteenemy.origin, 20, 16);
        if (isdefined(point)) {
            behaviortreeentity.lastknownenemypos = point;
            behaviortreeentity doa_enemy::function_d30fe558(behaviortreeentity.lastknownenemypos);
        }
        return true;
    }
    behaviortreeentity doa_enemy::function_d30fe558(behaviortreeentity.origin);
    return false;
}

// Namespace namespace_51bd792
// Params 4, eflags: 0x0
// Checksum 0x6dfe75bb, Offset: 0x3bd8
// Size: 0x154
function function_53b44cb7(spawner, loc, def, forced) {
    if (!isdefined(forced)) {
        forced = 0;
    }
    if (isdefined(level.doa.var_d0cde02c) && level.doa.var_d0cde02c == def || forced) {
        canspawn = 1;
    } else {
        canspawn = function_c783bef2();
    }
    if (!canspawn) {
        return undefined;
    }
    ai = doa_enemy::function_a4e16560(spawner, loc);
    if (isdefined(ai)) {
        ai.spawner = spawner;
        ai.team = "axis";
        ai.health = def.var_83bae1f8 + -106 * level.doa.round_number;
        if (isdefined(def.var_3eea3245) && ai.health > def.var_3eea3245) {
            ai.health = def.var_3eea3245;
        }
        ai.maxhealth = ai.health;
        ai.var_2d8174e3 = 1;
        ai thread function_772a04fe();
    }
    return ai;
}

// Namespace namespace_51bd792
// Params 0, eflags: 0x0
// Checksum 0x122b93c, Offset: 0x3d38
// Size: 0x11
function function_c783bef2() {
    return namespace_d88e3a06::function_cda60edb();
}

// Namespace namespace_51bd792
// Params 0, eflags: 0x0
// Checksum 0xd8b97630, Offset: 0x3d58
// Size: 0x1b2
function function_772a04fe() {
    self endon(#"death");
    self.zombie_move_speed = "sprint";
    goalpoints = namespace_49107f3a::function_308fa126(10);
    goalpoint = goalpoints[randomint(goalpoints.size)] + (randomintrange(-80, 80), randomintrange(-80, 80), 0);
    self.var_8f12ed02 = getclosestpointonnavmesh(goalpoint, 20, 16);
    if (!isdefined(self.var_8f12ed02)) {
        return;
    }
    level.doa.var_932f9d4d = gettime();
    trashcan = spawn("script_model", self.origin);
    trashcan.targetname = "trashcan";
    trashcan setmodel("zombietron_trashcan");
    trashcan linkto(self, "tag_origin", (0, 0, 54));
    trashcan thread function_45f23318(self);
    self doa_enemy::function_d30fe558(self.var_8f12ed02, 1);
    trashcan thread namespace_d88e3a06::function_d8d20160();
    self waittill(#"goal");
    self.var_8f12ed02 = undefined;
    if (isdefined(trashcan)) {
        trashcan notify(#"dropped");
        trashcan unlink();
        trashcan.origin = self.origin + (0, 0, 32);
        trashcan.angles = (0, 0, 0);
    }
}

// Namespace namespace_51bd792
// Params 1, eflags: 0x4
// Checksum 0x132bfb59, Offset: 0x3f18
// Size: 0x3c
function private function_45f23318(ai) {
    self endon(#"death");
    ai endon(#"goal");
    ai waittill(#"death");
    if (isdefined(self.death_func)) {
        self [[ self.death_func ]]();
    }
}

// Namespace namespace_51bd792
// Params 0, eflags: 0x0
// Checksum 0x9d010bf9, Offset: 0x3f60
// Size: 0x7a
function function_7e51c1d2() {
    level util::waittill_any("margwaAllDone", "player_challenge_failure");
    level clientfield::set("activateBanner", 0);
    if (isdefined(level.doa.margwa)) {
        level waittill(#"hash_96377490");
        level.doa.margwa delete();
    }
}

// Namespace namespace_51bd792
// Params 0, eflags: 0x0
// Checksum 0xe017e3d8, Offset: 0x3fe8
// Size: 0x3db
function function_4ce6d0ea() {
    level endon(#"player_challenge_failure");
    level thread function_7e51c1d2();
    level notify(#"hash_e2918623");
    setdvar("scr_margwa_footstep_eq_radius", 0);
    foreach (player in namespace_831a4a7c::function_5eb6e4d1()) {
        player notify(#"hash_d28ba89d");
    }
    level thread namespace_49107f3a::function_c5f3ece8(%DOA_UNDERBOSS, undefined, 6, (1, 0, 0));
    level.voice playsound("vox_doaa_underboss_battle");
    level notify(#"hash_ba37290e", "bossbattle");
    wait 1;
    level thread namespace_49107f3a::function_37fb5c23(%CP_DOA_BO3_MARGWA_LAIR, undefined, 5, (1, 0, 0));
    arenacenter = namespace_3ca3c537::function_61d60e0b();
    loc = spawnstruct();
    loc.angles = (0, 0, 0);
    loc.origin = arenacenter + (0, 0, 3000);
    level.doa.margwa = doa_enemy::function_a4e16560(getent("doa_margwa_spawner", "targetname"), loc, 1);
    level.doa.margwa.ignorevortices = 1;
    level.doa.margwa.boss = 1;
    level.doa.margwa notify(#"hash_6e8326fc");
    level.doa.margwa notify(#"hash_d96c599c");
    level.doa.margwa droptoground(arenacenter, "fire_trail", "turret_impact", 1, 0);
    level.doa.margwa thread function_c0147a11();
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] freezecontrols(0);
    }
    level clientfield::set("activateBanner", 4);
    level.doa.margwa waittill(#"death");
    level clientfield::set("activateBanner", 0);
    level flag::set("doa_round_paused");
    namespace_49107f3a::function_1ced251e();
    level thread namespace_49107f3a::function_c5f3ece8(%CP_DOA_BO3_MARGWA_DEFEATED, undefined, 6, (1, 0, 0));
    wait 4;
    level thread namespace_49107f3a::function_37fb5c23(%CP_DOA_BO3_MARGWA_DEFEATED2, undefined, 5, (1, 0, 0));
    wait 6.5;
    level flag::clear("doa_round_paused");
    level flag::clear("doa_round_active");
    namespace_49107f3a::function_1ced251e();
    level thread namespace_a7e6beb5::function_22d0e830(0, 10, 0.1);
    level thread namespace_a7e6beb5::function_22d0e830(1, 2, randomfloatrange(2, 4));
    level notify(#"margwaAllDone");
}

// Namespace namespace_51bd792
// Params 0, eflags: 0x4
// Checksum 0x71ce6a50, Offset: 0x43d0
// Size: 0xbd
function private function_e8a17069() {
    self endon(#"death");
    while (true) {
        if (getdvarint("scr_doa_soak_think", 0)) {
            damage = int(self.maxhealth * randomfloatrange(0.1, 0.2));
            attacker = namespace_831a4a7c::function_35f36dec(self.origin);
            self dodamage(damage, self.origin, attacker, attacker);
        }
        wait randomint(10);
    }
}

// Namespace namespace_51bd792
// Params 0, eflags: 0x4
// Checksum 0xacd9c900, Offset: 0x4498
// Size: 0xe5
function private function_13109fad() {
    self endon(#"death");
    level.doa.var_d0cde02c = level.doa.var_83a65bc6;
    level.doa.var_d0cde02c.var_84aef63e = getdvarint("scr_doa_margwa_default_parasites", 0);
    while (true) {
        self waittill(#"hash_2f07c48c");
        level.doa.var_d0cde02c.var_84aef63e = getdvarint("scr_doa_margwa_default_parasites_enraged", 16);
        wait getdvarint("scr_doa_margwa_enraged_duration", 10);
        level.doa.var_d0cde02c.var_84aef63e = getdvarint("scr_doa_margwa_default_parasites", 0);
    }
}

// Namespace namespace_51bd792
// Params 0, eflags: 0x4
// Checksum 0xa4cc2fa9, Offset: 0x4588
// Size: 0x285
function private function_c0147a11() {
    self endon(#"death");
    self.takedamage = 1;
    self.health = 300000 + getplayers().size * 250000;
    self.maxhealth = self.health;
    self.var_d3627554 = int(self.health * 0.8);
    self.var_b220d777 = int(self.health * 0.5);
    self.var_e6ea564a = int(self.health * 0.2);
    self.goalradius = 16;
    self.goalheight = 256;
    self.overrideactordamage = &function_b59ae4e9;
    self.zombie_move_speed = "walk";
    self thread function_1c99c7cd();
    self thread function_e8a17069();
    self thread function_13109fad();
    /#
        if (isdefined(level.doa.var_33749c8)) {
            self thread DOA_BOSS::function_76b30cc1();
        }
    #/
    while (self.health > 0) {
        lasthealth = self.health;
        self waittill(#"damage", damage, attacker);
        data = namespace_49107f3a::clamp(self.health / self.maxhealth, 0, 1);
        level clientfield::set("pumpBannerBar", data);
        if (isdefined(attacker) && isplayer(attacker)) {
            if (!isdefined(attacker.doa.boss_damage)) {
                attacker.doa.boss_damage = 0;
            }
            attacker.doa.boss_damage += int(damage * 0.25);
            attacker namespace_64c6b720::function_80eb303(damage, 1);
        }
        namespace_49107f3a::debugmsg("BossHealth: " + self.health);
    }
}

// Namespace namespace_51bd792
// Params 12, eflags: 0x0
// Checksum 0x3b2c943, Offset: 0x4818
// Size: 0x374
function function_b59ae4e9(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    if (self.health >= self.var_d3627554 && self.health - damage < self.var_d3627554) {
        level.doa.var_d0cde02c.var_3ceda880 = undefined;
        self notify(#"hash_2f07c48c");
        var_9c967ca3 = "c_zom_margwa_chunks_le";
        level thread namespace_cdb9a8fe::function_691ef36b();
        level thread namespace_cdb9a8fe::function_703bb8b2(30);
        level thread namespace_cdb9a8fe::function_87703158(1);
        org = spawn("script_model", self gettagorigin("J_Head_LE"));
        org.targetname = "margwa1";
        org setmodel("tag_origin");
        level namespace_a7e6beb5::function_3238133b("zombietron_heart", self.origin, 1, 1, 90);
    } else if (self.health >= self.var_b220d777 && self.health - damage < self.var_b220d777) {
        self notify(#"hash_2f07c48c");
        var_9c967ca3 = "c_zom_margwa_chunks_ri";
        org = spawn("script_model", self gettagorigin("J_Head_RI"));
        org.targetname = "margwa1";
        org setmodel("tag_origin");
        level namespace_a7e6beb5::function_3238133b("zombietron_heart", self.origin, 1, 1, 90);
    } else if (self.health >= self.var_e6ea564a && self.health - damage < self.var_e6ea564a) {
        self notify(#"hash_2f07c48c");
        var_9c967ca3 = "c_zom_margwa_chunks_mid";
        org = spawn("script_model", self gettagorigin("J_Head"));
        org.targetname = "margwa1";
        org setmodel("tag_origin");
        level namespace_a7e6beb5::function_3238133b("zombietron_heart", self.origin, 1, 1, 90);
    }
    if (isdefined(var_9c967ca3)) {
        headinfo = self.head[var_9c967ca3];
        headinfo.health = 0;
        self function_3133a8cb();
        self detach(var_9c967ca3);
        self attach(headinfo.gore);
        self.var_a0c7c5f--;
        self.headdestroyed = var_9c967ca3;
        self thread function_7ee81ba4(org);
    }
    return damage;
}

// Namespace namespace_51bd792
// Params 1, eflags: 0x4
// Checksum 0xd182885b, Offset: 0x4b98
// Size: 0x3a
function private function_7ee81ba4(org) {
    org thread namespace_eaa992c::function_285a2999("margwa_head_explode");
    wait 1;
    org delete();
}

// Namespace namespace_51bd792
// Params 0, eflags: 0x4
// Checksum 0x673a8906, Offset: 0x4be0
// Size: 0xba
function private function_3133a8cb() {
    if (self.zombie_move_speed == "walk") {
        self.zombie_move_speed = "run";
        self asmsetanimationrate(0.8);
        blackboard::setblackboardattribute(self, "_locomotion_speed", "locomotion_speed_run");
        return;
    }
    if (self.zombie_move_speed == "run") {
        self.zombie_move_speed = "sprint";
        self asmsetanimationrate(1);
        blackboard::setblackboardattribute(self, "_locomotion_speed", "locomotion_speed_sprint");
    }
}

// Namespace namespace_51bd792
// Params 0, eflags: 0x4
// Checksum 0x4788b027, Offset: 0x4ca8
// Size: 0xdd
function private function_1c99c7cd() {
    trigger = spawn("trigger_radius", self.origin, 2, 40, 50);
    trigger.targetname = "margwaDamag";
    trigger enablelinkto();
    trigger linkto(self, "tag_origin");
    trigger endon(#"death");
    trigger thread namespace_49107f3a::function_783519c1("exit_taken", 1);
    trigger thread namespace_49107f3a::function_981c685d(self);
    while (isdefined(self)) {
        trigger waittill(#"trigger", guy);
        if (isdefined(self)) {
            guy dodamage(665, guy.origin, self, self);
        }
    }
}

