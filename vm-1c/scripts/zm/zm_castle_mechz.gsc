#using scripts/codescripts/struct;
#using scripts/shared/ai/mechz;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_ai_mechz;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_elemental_bow;
#using scripts/zm/zm_castle;
#using scripts/zm/zm_castle_ee_side;
#using scripts/zm/zm_castle_vo;

#namespace zm_castle_mechz;

// Namespace zm_castle_mechz
// Params 0, eflags: 0x2
// Checksum 0xe8fa6c22, Offset: 0x578
// Size: 0xd4
function autoexec init() {
    function_dd3133f7();
    level flag::init("can_spawn_mechz", 1);
    spawner::add_archetype_spawn_function("mechz", &function_d8d01032);
    level thread function_76e7495b();
    level.var_eabb03e4 = &function_f517cdd6;
    level.var_cc79df2f = &function_bddef31c;
    level.var_7f2a926d = &function_6367c303;
    /#
        level thread function_78e44cda();
    #/
}

// Namespace zm_castle_mechz
// Params 0, eflags: 0x4
// Checksum 0xa07673bb, Offset: 0x658
// Size: 0x12c
function private function_dd3133f7() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("castleMechzTrapService", &function_78c0d00b);
    behaviortreenetworkutility::registerbehaviortreescriptapi("castleMechzShouldMoveToTrap", &function_697928b7);
    behaviortreenetworkutility::registerbehaviortreescriptapi("castleMechzIsAtTrap", &function_829fa81c);
    behaviortreenetworkutility::registerbehaviortreescriptapi("castleMechzShouldAttackTrap", &function_e4f26ac8);
    behaviortreenetworkutility::registerbehaviortreescriptapi("casteMechzTrapMoveTerminate", &function_cf4879ad);
    behaviortreenetworkutility::registerbehaviortreescriptapi("casteMechzTrapAttackTerminate", &function_7c295452);
    animationstatenetwork::registeranimationmocomp("mocomp_trap_attack@mechz", &function_f467e83, undefined, &function_e37c4112);
}

// Namespace zm_castle_mechz
// Params 0, eflags: 0x4
// Checksum 0x6d594467, Offset: 0x790
// Size: 0xce
function private function_76e7495b() {
    wait 0.5;
    traps = getentarray("zombie_trap", "targetname");
    foreach (trap in traps) {
        if (trap.script_noteworthy == "electric") {
            level.electric_trap = trap;
        }
    }
}

// Namespace zm_castle_mechz
// Params 1, eflags: 0x4
// Checksum 0xa8a9dc3a, Offset: 0x868
// Size: 0x126
function private function_78c0d00b(entity) {
    if (isdefined(entity.var_8993e21) && (isdefined(entity.var_7c963fc4) && entity.var_7c963fc4 || entity.var_8993e21)) {
        return true;
    }
    if (level flag::get("masher_on")) {
        if (entity function_ced5d8b0("masher_trap_switch")) {
            return true;
        }
    }
    if (isdefined(level.electric_trap)) {
        if (isdefined(level.electric_trap._trap_in_use) && level.electric_trap._trap_in_use && !(isdefined(level.electric_trap.var_58acf3b0) && level.electric_trap.var_58acf3b0)) {
            if (entity function_ced5d8b0("elec_trap_switch")) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_castle_mechz
// Params 1, eflags: 0x4
// Checksum 0xd4a5bb50, Offset: 0x998
// Size: 0x184
function private function_ced5d8b0(var_2dba2212) {
    traps = struct::get_array(var_2dba2212, "script_noteworthy");
    self.trap_struct = undefined;
    closest_dist_sq = 57600;
    foreach (trap in traps) {
        dist_sq = distancesquared(trap.origin, self.origin);
        if (dist_sq < closest_dist_sq) {
            closest_dist_sq = dist_sq;
            self.trap_struct = trap;
        }
    }
    if (isdefined(self.trap_struct)) {
        self.var_7c963fc4 = 1;
        self.ignoreall = 1;
        self setgoal(self.trap_struct.origin);
        self thread function_216e21ed();
        return true;
    }
    return false;
}

// Namespace zm_castle_mechz
// Params 0, eflags: 0x0
// Checksum 0x32355299, Offset: 0xb28
// Size: 0x94
function function_216e21ed() {
    self endon(#"death");
    wait 60;
    if (isdefined(self.ignoreall) && (isdefined(self.var_8993e21) && (isdefined(self.var_7c963fc4) && self.var_7c963fc4 || self.var_8993e21) || self.ignoreall)) {
        self.var_7c963fc4 = 0;
        self.var_8993e21 = 0;
        self.ignoreall = 0;
        namespace_648c84b6::mechztargetservice(self);
    }
}

// Namespace zm_castle_mechz
// Params 1, eflags: 0x0
// Checksum 0xe2c011fd, Offset: 0xbc8
// Size: 0x3a
function function_697928b7(entity) {
    if (isdefined(entity.var_7c963fc4) && entity.var_7c963fc4) {
        return true;
    }
    return false;
}

// Namespace zm_castle_mechz
// Params 1, eflags: 0x0
// Checksum 0xc965d4a1, Offset: 0xc10
// Size: 0x2e
function function_829fa81c(entity) {
    if (entity isatgoal()) {
        return true;
    }
    return false;
}

// Namespace zm_castle_mechz
// Params 1, eflags: 0x0
// Checksum 0x9f07a3e7, Offset: 0xc48
// Size: 0x3a
function function_e4f26ac8(entity) {
    if (isdefined(entity.var_8993e21) && entity.var_8993e21) {
        return true;
    }
    return false;
}

// Namespace zm_castle_mechz
// Params 1, eflags: 0x0
// Checksum 0xb1d25d7f, Offset: 0xc90
// Size: 0x30
function function_cf4879ad(entity) {
    entity.var_7c963fc4 = 0;
    entity.var_8993e21 = 1;
}

// Namespace zm_castle_mechz
// Params 1, eflags: 0x0
// Checksum 0x13df757e, Offset: 0xcc8
// Size: 0xb4
function function_7c295452(entity) {
    entity.var_8993e21 = 0;
    entity.ignoreall = 0;
    if (isdefined(entity.trap_struct)) {
        if (entity.trap_struct.script_noteworthy == "masher_trap_switch") {
            level flag::clear("masher_on");
        } else {
            level.electric_trap notify(#"trap_deactivate");
        }
    }
    namespace_648c84b6::mechztargetservice(entity);
}

// Namespace zm_castle_mechz
// Params 5, eflags: 0x0
// Checksum 0xe5b8bd5e, Offset: 0xd88
// Size: 0x84
function function_f467e83(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.trap_struct.angles[1]);
    entity animmode("normal");
}

// Namespace zm_castle_mechz
// Params 5, eflags: 0x0
// Checksum 0xac0d896e, Offset: 0xe18
// Size: 0x4c
function function_e37c4112(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face default");
}

// Namespace zm_castle_mechz
// Params 0, eflags: 0x0
// Checksum 0x530be3d1, Offset: 0xe70
// Size: 0xa4
function function_24025db6() {
    /#
        if (getdvarint("<dev string:x28>") >= 2) {
            return;
        }
    #/
    level.var_76df55d3 = 1;
    level.var_28066209 = 0;
    level.var_f4dc2834 = 3062.5;
    level.var_c1f907b2 = 1750;
    level.var_42fd61f0 = 3500;
    level.var_42ee1b54 = level.var_42fd61f0 - level.var_c1f907b2;
    level thread function_5639dba0();
}

// Namespace zm_castle_mechz
// Params 0, eflags: 0x0
// Checksum 0x6ba7471c, Offset: 0xf20
// Size: 0x2ec
function function_6367c303() {
    if (!isdefined(level.var_44bca3d6) || level.round_number > level.var_44bca3d6) {
        a_players = getplayers();
        n_player_modifier = 1;
        switch (a_players.size) {
        case 0:
        case 1:
            n_player_modifier = 1;
            break;
        case 2:
            n_player_modifier = 1.33;
            break;
        case 3:
            n_player_modifier = 1.66;
            break;
        case 4:
            n_player_modifier = 2;
            break;
        }
        var_485a2c2c = level.zombie_health / level.zombie_vars["zombie_health_start"];
        level.var_53cc405d = int(n_player_modifier * (level.var_f1419b9d + level.var_a1748a68 * var_485a2c2c));
        level.var_df387ccd = int(n_player_modifier * (level.var_fa14536d + level.var_1a5bb9d8 * var_485a2c2c));
        level.var_79d56f1b = int(n_player_modifier * (level.var_79d56f1b + level.var_a1943286 * var_485a2c2c));
        level.var_c31f5c1f = int(n_player_modifier * (level.var_c31f5c1f + level.var_9684c99e * var_485a2c2c));
        level.var_2cbc5b59 = int(n_player_modifier * (level.var_3f1bf221 + level.var_158234c * var_485a2c2c));
        level.var_53cc405d = function_26beb37e(level.var_53cc405d, 17500, n_player_modifier);
        level.var_df387ccd = function_26beb37e(level.var_df387ccd, 16000, n_player_modifier);
        level.var_79d56f1b = function_26beb37e(level.var_79d56f1b, 7500, n_player_modifier);
        level.var_c31f5c1f = function_26beb37e(level.var_c31f5c1f, 5000, n_player_modifier);
        level.var_2cbc5b59 = function_26beb37e(level.var_2cbc5b59, 3500, n_player_modifier);
        level.var_44bca3d6 = level.round_number;
    }
}

// Namespace zm_castle_mechz
// Params 3, eflags: 0x0
// Checksum 0xacb1259e, Offset: 0x1218
// Size: 0x54
function function_26beb37e(value, limit, var_69de4866) {
    if (value >= limit * var_69de4866) {
        value = int(limit * var_69de4866);
    }
    return value;
}

// Namespace zm_castle_mechz
// Params 0, eflags: 0x0
// Checksum 0xf3253f50, Offset: 0x1278
// Size: 0xfc
function function_5639dba0() {
    level.var_b20dd348 = randomintrange(12, 13);
    level.var_2f0a5661 = 0;
    while (true) {
        while (level.round_number < level.var_b20dd348) {
            level waittill(#"between_round_over");
            /#
                if (level.round_number > level.var_b20dd348) {
                    level.var_b20dd348 = level.round_number + 1;
                }
            #/
        }
        if (level flag::get("dog_round") && level.dog_round_count == 1) {
            level.var_b20dd348++;
        } else if (level.var_b20dd348 >= level.round_number) {
            function_6592b947();
        }
        level waittill(#"start_of_round");
    }
}

// Namespace zm_castle_mechz
// Params 0, eflags: 0x0
// Checksum 0xd40561cd, Offset: 0x1380
// Size: 0x11c
function function_6592b947() {
    var_b29defde = function_c7730c11();
    wait 5;
    while (var_b29defde > 0) {
        while (!function_b1a145c4()) {
            wait 1;
        }
        var_99c3dd59 = function_314d744b(1);
        if (isdefined(var_99c3dd59)) {
            var_b29defde--;
            var_99c3dd59 thread zm_castle_vo::function_5e426b67();
            var_99c3dd59 thread zm_castle_vo::function_e8a09e6e();
        }
        if (var_b29defde > 0) {
            wait randomfloatrange(5, 10);
        }
    }
    level.var_b20dd348 = level.round_number + randomintrange(5, 7);
    level.var_65863f29++;
}

// Namespace zm_castle_mechz
// Params 0, eflags: 0x0
// Checksum 0x283e7125, Offset: 0x14a8
// Size: 0x78
function function_b1a145c4() {
    var_f52ee0b1 = zombie_utility::get_current_zombie_count() >= level.zombie_ai_limit;
    if (var_f52ee0b1 || !level flag::get("spawn_zombies") || !level flag::get("can_spawn_mechz")) {
        return false;
    }
    return true;
}

// Namespace zm_castle_mechz
// Params 0, eflags: 0x0
// Checksum 0xd63fd880, Offset: 0x1528
// Size: 0xb0
function function_c7730c11() {
    level.var_28066209++;
    if (level.players.size == 1) {
        if (level.var_28066209 == 1 || level.var_28066209 == 2) {
            return 1;
        } else {
            return 1;
        }
        return;
    }
    if (level.var_28066209 == 1 || level.var_28066209 == 2) {
        return 1;
    }
    if (level.var_28066209 == 3 || level.var_28066209 == 4) {
        return 2;
    }
    return 3;
}

// Namespace zm_castle_mechz
// Params 0, eflags: 0x0
// Checksum 0x137f0305, Offset: 0x15e0
// Size: 0x102
function function_d8d01032() {
    level.var_2f0a5661++;
    level.zombie_ai_limit--;
    level thread achievement_watcher(self);
    self thread function_b2a1b297();
    self waittill(#"death");
    self thread function_2a2bfc25();
    if (isdefined(self.attacker) && isplayer(self.attacker) && self.attacker hasweapon(getweapon("knife_plunger"))) {
        level thread zm_castle_ee_side::function_c7bb86e5(self.attacker);
    }
    level.var_2f0a5661--;
    level.zombie_ai_limit++;
    level notify(#"hash_8f65ad3d");
}

// Namespace zm_castle_mechz
// Params 0, eflags: 0x0
// Checksum 0x11d6f9fe, Offset: 0x16f0
// Size: 0x44
function function_b2a1b297() {
    self waittill(#"actor_corpse", mechz);
    wait 60;
    if (isdefined(mechz)) {
        mechz delete();
    }
}

// Namespace zm_castle_mechz
// Params 0, eflags: 0x0
// Checksum 0x17454dbf, Offset: 0x1740
// Size: 0xfe
function function_2a2bfc25() {
    self waittill(#"hash_46c1e51d");
    if (level flag::get("gravityspike_part_body_found")) {
        if (level flag::get("zombie_drop_powerups") && !(isdefined(self.no_powerups) && self.no_powerups)) {
            var_d54b1ec = array("double_points", "insta_kill", "full_ammo", "nuke");
            str_type = array::random(var_d54b1ec);
            zm_powerups::specific_powerup_drop(str_type, self.origin);
        }
        return;
    }
    level notify(#"hash_b650259c", self.origin);
}

// Namespace zm_castle_mechz
// Params 3, eflags: 0x0
// Checksum 0x1f1a0f2b, Offset: 0x1848
// Size: 0x208
function function_314d744b(var_2533389a, s_loc, var_4211ee1f) {
    if (!isdefined(var_4211ee1f)) {
        var_4211ee1f = 1;
    }
    if (!isdefined(s_loc)) {
        if (level.zm_loc_types["mechz_location"].size == 0) {
            var_79ed5347 = struct::get_array("mechz_location", "script_noteworthy");
            foreach (var_6000fab5 in var_79ed5347) {
                if (var_6000fab5.targetname == "zone_start_spawners") {
                    s_loc = var_6000fab5;
                }
            }
        } else {
            s_loc = array::random(level.zm_loc_types["mechz_location"]);
        }
    }
    level thread zm_castle_vo::function_894d806e(s_loc);
    function_6367c303();
    var_99c3dd59 = zm_ai_mechz::function_53c37648(s_loc, var_4211ee1f);
    level.var_9618f5be = var_99c3dd59;
    level notify(#"hash_b4c3cb33");
    if (isdefined(var_99c3dd59)) {
        var_99c3dd59.b_ignore_cleanup = 1;
    }
    if (!(isdefined(var_2533389a) && var_2533389a)) {
        level.var_b20dd348 = level.round_number + randomintrange(4, 6);
    }
    return var_99c3dd59;
}

// Namespace zm_castle_mechz
// Params 1, eflags: 0x0
// Checksum 0x2134ea30, Offset: 0x1a58
// Size: 0xc8
function achievement_watcher(var_99c3dd59) {
    var_99c3dd59 waittill(#"death", attacker, meansofdeath);
    if (isdefined(attacker.currentweapon) && attacker.currentweapon.name === "minigun") {
        arrayremovevalue(attacker.var_544cf8c7, var_99c3dd59.archetype);
    }
    if (isdefined(var_99c3dd59.var_bcecff1d) && var_99c3dd59.var_bcecff1d) {
        attacker notify(#"hash_a72ebab5");
    }
}

// Namespace zm_castle_mechz
// Params 12, eflags: 0x0
// Checksum 0x12b23dd1, Offset: 0x1b28
// Size: 0xfe
function function_f517cdd6(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    switch (weapon.name) {
    case "elemental_bow_demongate4":
    case "elemental_bow_rune_prison4":
    case "elemental_bow_wolf_howl4":
        if (!(isdefined(self.var_98056717) && self.var_98056717)) {
            self.stun = 1;
        }
        break;
    case "elemental_bow_demongate":
        if (isdefined(inflictor) && inflictor.classname != "rocket") {
            self.stun = 1;
        }
        break;
    }
}

// Namespace zm_castle_mechz
// Params 12, eflags: 0x0
// Checksum 0x3e3c694c, Offset: 0x1c30
// Size: 0x114
function function_bddef31c(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    if (issubstr(weapon.name, "elemental_bow")) {
        var_45d7f4c0 = self.health - damage * 0.2;
        var_be912ff6 = var_45d7f4c0 / level.var_53cc405d;
        if (self.var_aba6456b == 1 && var_be912ff6 < 0.5) {
            self namespace_e907cf54::function_b024a4c(self.var_b087942f + 100);
        }
    }
}

/#

    // Namespace zm_castle_mechz
    // Params 0, eflags: 0x0
    // Checksum 0x58d67077, Offset: 0x1d50
    // Size: 0xb8
    function function_78e44cda() {
        wait 0.05;
        level waittill(#"start_zombie_round_logic");
        wait 0.05;
        setdvar("<dev string:x35>", 0);
        adddebugcommand("<dev string:x62>");
        while (true) {
            if (getdvarint("<dev string:x35>")) {
                setdvar("<dev string:x35>", 0);
                level thread function_eac1444a();
            }
            wait 0.5;
        }
    }

    // Namespace zm_castle_mechz
    // Params 0, eflags: 0x0
    // Checksum 0xcc7509e4, Offset: 0x1e10
    // Size: 0x282
    function function_eac1444a() {
        var_10b176f0 = getaiarchetypearray("<dev string:xc2>");
        foreach (var_99c3dd59 in var_10b176f0) {
            var_efe3c52f = level.activeplayers[0] gettagorigin("<dev string:xc8>") + (0, 0, 20);
            var_7ddc55f4 = level.activeplayers[0] gettagorigin("<dev string:xc8>") + (5, 0, 20);
            var_a3ded05d = level.activeplayers[0] gettagorigin("<dev string:xc8>") + (-5, 0, 20);
            var_31d76122 = level.activeplayers[0] gettagorigin("<dev string:xc8>") + (0, 0, 15);
            magicbullet(level.w_bow_demongate_charged, var_efe3c52f, var_99c3dd59 getcentroid(), level.activeplayers[0]);
            magicbullet(level.w_bow_rune_prison_charged, var_7ddc55f4, var_99c3dd59 getcentroid(), level.activeplayers[0]);
            magicbullet(level.w_bow_storm_charged, var_a3ded05d, var_99c3dd59 getcentroid(), level.activeplayers[0]);
            magicbullet(level.w_bow_wolf_howl_charged, var_31d76122, var_99c3dd59 getcentroid(), level.activeplayers[0]);
        }
    }

    // Namespace zm_castle_mechz
    // Params 3, eflags: 0x0
    // Checksum 0xee277c67, Offset: 0x20a0
    // Size: 0x5c
    function function_22cf3e9f(str_weapon_name, v_source, var_99c3dd59) {
        magicbullet(level.w_bow_rune_prison_charged, v_source, var_99c3dd59 getcentroid(), level.activeplayers[0]);
    }

#/
