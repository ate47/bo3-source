#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/aat_shared;
#using scripts/codescripts/struct;

#namespace namespace_8fb880d9;

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x2
// Checksum 0xd94cca93, Offset: 0x12f0
// Size: 0x254
function autoexec init() {
    function_1444ad65();
    spawner::add_archetype_spawn_function("monkey", &function_23a486c);
    spawner::add_archetype_spawn_function("monkey", &function_31560902);
    animationstatenetwork::registernotetrackhandlerfunction("monkey_melee", &function_57e144e9);
    animationstatenetwork::registernotetrackhandlerfunction("monkey_groundpound", &function_f7725aa8);
    animationstatenetwork::registernotetrackhandlerfunction("grenade_pickup", &function_fcdc0829);
    level thread aat::register_immunity("zm_aat_blast_furnace", "monkey", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_dead_wire", "monkey", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_fire_works", "monkey", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_thunder_wall", "monkey", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_turned", "monkey", 1, 1, 1);
    clientfield::register("actor", "monkey_eye_glow", 21000, 1, "int");
    level.var_45abf882 = [];
    for (i = 0; i < 4; i++) {
        level.var_45abf882[i] = "rtrg_ai_zm_dlc5_monkey_thundergun_roll_0" + i + 1;
    }
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0xef0ffd2f, Offset: 0x1550
// Size: 0x5c
function function_57e144e9(entity) {
    entity melee();
    /#
        record3dtext("zm_aat_turned", self.origin, (1, 0, 0), "zm_aat_turned", entity);
    #/
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0x6cdf5a55, Offset: 0x15b8
// Size: 0x4d6
function function_f7725aa8(entity) {
    playfxontag(level._effect["monkey_groundhit"], entity, "tag_origin");
    entity playsound("zmb_monkey_groundpound");
    origin = entity.origin + (0, 0, 40);
    zombies = array::get_all_closest(origin, getaispeciesarray(level.zombie_team, "all"), undefined, undefined, level.var_9151fd0b);
    if (isdefined(zombies)) {
        for (i = 0; i < zombies.size; i++) {
            if (!isdefined(zombies[i])) {
                continue;
            }
            if (zm_utility::is_magic_bullet_shield_enabled(zombies[i])) {
                continue;
            }
            test_origin = zombies[i] geteye();
            if (!bullettracepassed(origin, test_origin, 0, undefined)) {
                continue;
            }
            if (zombies[i] == entity) {
                continue;
            }
            if (zombies[i].animname == "monkey_zombie") {
                continue;
            }
            zombies[i] zombie_utility::gib_random_parts();
            gibserverutils::annihilate(zombies[i]);
            zombies[i] dodamage(zombies[i].health * 10, entity.origin, entity);
        }
    }
    players = getplayers();
    affected_players = [];
    for (i = 0; i < players.size; i++) {
        if (!zombie_utility::is_player_valid(players[i])) {
            continue;
        }
        test_origin = players[i] geteye();
        if (distancesquared(origin, test_origin) > level.var_9151fd0b * level.var_9151fd0b) {
            continue;
        }
        if (!bullettracepassed(origin, test_origin, 0, undefined)) {
            continue;
        }
        if (!isdefined(affected_players)) {
            affected_players = [];
        } else if (!isarray(affected_players)) {
            affected_players = array(affected_players);
        }
        affected_players[affected_players.size] = players[i];
    }
    entity.var_35ec949b = 0;
    for (i = 0; i < affected_players.size; i++) {
        entity.var_35ec949b = 1;
        player = affected_players[i];
        if (player isonground()) {
            damage = player.maxhealth * 0.5;
            player dodamage(damage, entity.origin, entity);
        }
    }
    if (isdefined(entity.var_2da34b1)) {
        for (i = 0; i < entity.var_2da34b1.size; i++) {
            if (isdefined(entity.var_2da34b1[i])) {
                entity.var_2da34b1[i] detonate(undefined);
            }
        }
    }
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0x7aed13dd, Offset: 0x1a98
// Size: 0x194
function function_fcdc0829(entity) {
    target = self.var_f9b8c18a;
    var_1e8168cb = randomintrange(20, 30);
    dir = vectortoangles(target.origin - entity.origin);
    dir = (dir[0] - var_1e8168cb, dir[1], dir[2]);
    dir = anglestoforward(dir);
    velocity = dir * 550;
    fuse = randomfloatrange(1, 2);
    var_d2580f11 = entity gettagorigin("J_Thumb_RI_1");
    if (!isdefined(var_d2580f11)) {
        var_d2580f11 = entity.origin;
    }
    grenade_type = target zm_utility::get_player_lethal_grenade();
    entity magicgrenadetype(grenade_type, var_d2580f11, velocity, fuse);
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xce00a650, Offset: 0x1c38
// Size: 0xe4
function function_23a486c() {
    blackboard::createblackboardforentity(self);
    self aiutility::function_89e1fc16();
    ai::createinterfaceforentity(self);
    blackboard::registerblackboardattribute(self, "_locomotion_speed", "locomotion_speed_walk", &zombiebehavior::function_f8ae4008);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("zm_aat_turned");
        #/
    }
    self.___archetypeonanimscriptedcallback = &function_fbae5ec2;
    /#
        self finalizetrackedblackboardattributes();
    #/
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x5 linked
// Checksum 0x2f63bb4c, Offset: 0x1d28
// Size: 0x34
function private function_31560902() {
    self setpitchorient();
    self function_fd927951();
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x5 linked
// Checksum 0xd18ec506, Offset: 0x1d68
// Size: 0x34
function private function_fbae5ec2(entity) {
    entity.__blackboard = undefined;
    entity function_23a486c();
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x5 linked
// Checksum 0x667ee8ce, Offset: 0x1da8
// Size: 0x144
function private function_1444ad65() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("monkeyTargetService", &function_f6d7dbae);
    behaviortreenetworkutility::registerbehaviortreescriptapi("monkeyShouldGroundHit", &function_5403fe31);
    behaviortreenetworkutility::registerbehaviortreescriptapi("monkeyShouldThrowBackRun", &function_38a521eb);
    behaviortreenetworkutility::registerbehaviortreescriptapi("monkeyShouldThrowBackStill", &function_25709832);
    behaviortreenetworkutility::registerbehaviortreescriptapi("monkeyGroundHitStart", &function_6612416a);
    behaviortreenetworkutility::registerbehaviortreescriptapi("monkeyGroundHitTerminate", &function_2f7de18b);
    behaviortreenetworkutility::registerbehaviortreescriptapi("monkeyThrowBackTerminate", &function_a03001bc);
    behaviortreenetworkutility::registerbehaviortreescriptapi("monkeyGrenadeTauntTerminate", &function_1519af55);
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0xddf963dd, Offset: 0x1ef8
// Size: 0x330
function function_f6d7dbae(entity) {
    if (isdefined(entity.ignoreall) && entity.ignoreall) {
        return 0;
    }
    if (!(isdefined(entity.following_player) && entity.following_player)) {
        return 0;
    }
    if (isdefined(entity.var_24971ab5)) {
        return 0;
    }
    player = zm_utility::get_closest_valid_player(self.origin, self.ignore_player);
    entity.favoriteenemy = player;
    if (isdefined(entity.pack) && isdefined(entity.pack.enemy)) {
        if (!isdefined(entity.favoriteenemy) || entity.favoriteenemy != entity.pack.enemy) {
            entity.favoriteenemy = entity.pack.enemy;
        }
    }
    if (!isdefined(player) || player isnotarget()) {
        if (isdefined(entity.ignore_player)) {
            if (isdefined(level._should_skip_ignore_player_logic) && [[ level._should_skip_ignore_player_logic ]]()) {
                return;
            }
            entity.ignore_player = [];
        }
        if (isdefined(level.no_target_override)) {
            [[ level.no_target_override ]](entity);
        } else {
            entity setgoal(entity.origin);
        }
        return 0;
    }
    if (isdefined(level.enemy_location_override_func)) {
        var_d1bd0948 = [[ level.enemy_location_override_func ]](entity, player);
        if (isdefined(var_d1bd0948)) {
            entity setgoal(var_d1bd0948);
            return 1;
        }
    }
    targetpos = getclosestpointonnavmesh(entity.favoriteenemy.origin, 15, 15);
    if (isdefined(targetpos)) {
        entity setgoal(targetpos);
        return 1;
    }
    if (isdefined(entity.favoriteenemy.last_valid_position)) {
        entity setgoal(entity.favoriteenemy.last_valid_position);
        return 1;
    }
    entity setgoal(entity.origin);
    return 0;
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0x3c913bc2, Offset: 0x2230
// Size: 0x3a
function function_5403fe31(entity) {
    if (isdefined(entity.var_aa9937) && entity.var_aa9937) {
        return true;
    }
    return false;
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0x6bb0d8b3, Offset: 0x2278
// Size: 0x38
function function_6612416a(entity) {
    self function_d9b855a8("ground_pound");
    self.var_74ee5186 = 1;
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0x295d1048, Offset: 0x22b8
// Size: 0x54
function function_2f7de18b(entity) {
    self.var_74ee5186 = 0;
    self function_d9b855a8("ground_pound_done");
    self.var_51a4be2 = gettime() + level.var_6916b2bf;
    self.var_aa9937 = 0;
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0x7d60200e, Offset: 0x2318
// Size: 0x3a
function function_38a521eb(entity) {
    if (isdefined(entity.var_cf51d24) && entity.var_cf51d24) {
        return true;
    }
    return false;
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0xf10193f6, Offset: 0x2360
// Size: 0x3a
function function_25709832(entity) {
    if (isdefined(entity.var_6602f0c5) && entity.var_6602f0c5) {
        return true;
    }
    return false;
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0x4aed68e4, Offset: 0x23a8
// Size: 0x2c
function function_a03001bc(entity) {
    entity.var_cf51d24 = 0;
    entity.var_6602f0c5 = 0;
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0x565320e, Offset: 0x23e0
// Size: 0x1c
function function_1519af55(entity) {
    entity notify(#"hash_8c6afaf6");
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x0
// Checksum 0x53cab70f, Offset: 0x2408
// Size: 0x37c
function function_4c8046f8() {
    function_dd79f3a8();
    level._effect["monkey_groundhit"] = "dlc5/zmhd/fx_zmb_monkey_ground_hit";
    level._effect["monkey_death"] = "dlc5/cosmo/fx_zmb_monkey_death";
    level._effect["monkey_spawn"] = "dlc5/cosmo/fx_zombie_ape_spawn_dust";
    if (!isdefined(level.var_1643e9c6)) {
        level.var_1643e9c6 = &function_bed58958;
    }
    if (!isdefined(level.var_7deb01db)) {
        level.var_7deb01db = &function_7d9e6c11;
    }
    level.var_3d1f9aed = 0;
    level.var_7e34a7d9 = getentarray("monkey_zombie_spawner", "targetname");
    if (!isdefined(level.var_114d8513)) {
        level.var_114d8513 = 1;
    }
    if (!isdefined(level.var_27c3e797)) {
        level.var_27c3e797 = -106;
    }
    if (!isdefined(level.var_281c5d62)) {
        level.var_281c5d62 = 100;
    }
    if (!isdefined(level.var_16b3fbc0)) {
        level.var_16b3fbc0 = 96;
    }
    if (!isdefined(level.var_9151fd0b)) {
        level.var_9151fd0b = 280;
    }
    if (!isdefined(level.var_6916b2bf)) {
        level.var_6916b2bf = 5000;
    }
    if (!isdefined(level.var_9e310f9b)) {
        level.var_9e310f9b = 3;
    }
    if (!isdefined(level.var_3bf8b909)) {
        level.var_3bf8b909 = 1;
    }
    if (!isdefined(level.var_ecb65a32)) {
        level.var_ecb65a32 = [];
    }
    if (!isdefined(level.var_6b0bbc7e)) {
        level.var_6b0bbc7e = 100;
    }
    if (!isdefined(level.var_b745bb11)) {
        level.var_b745bb11 = 1;
    }
    if (!isdefined(level.var_2243306f)) {
        level.var_2243306f = 8;
    }
    if (!isdefined(level.var_7c4a5d82)) {
        level.var_7c4a5d82 = randomfloatrange(4.5, 6.5) * 1000;
    }
    level.var_90c5919d = 0;
    level.var_8757475e = 0;
    level.var_e810cac3 = 0;
    level.var_b63dbbcb = 1;
    level.var_b20b6949 = 0;
    level flag::init("monkey_round");
    level flag::init("last_monkey_down");
    level flag::init("monkey_pack_down");
    level flag::init("perk_bought");
    level flag::init("monkey_free_perk");
    level thread function_ef9c7c76();
    level.var_a72d0823 = &function_85994fd6;
    level.var_7b162f9e = &function_57ee756d;
    level.var_2b07e0c2 = &function_67695f31;
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xe8943b49, Offset: 0x2790
// Size: 0x2de
function function_fd927951() {
    self.animname = "monkey_zombie";
    self function_1762804b(1);
    self.b_ignore_cleanup = 1;
    self.var_ceb0ee4e = 1;
    self.ignoreall = 1;
    self.allowdeath = 1;
    self.is_zombie = 1;
    self.missinglegs = 0;
    self allowedstances("stand");
    self.gibbed = 0;
    self.head_gibbed = 0;
    self.var_65eda69a = 1;
    self.disablearrivals = 1;
    self.disableexits = 1;
    self.grenadeawareness = 0;
    self.badplaceawareness = 0;
    self.ignoresuppression = 1;
    self.suppressionthreshold = 1;
    self.nododgemove = 1;
    self.dontshootwhilemoving = 1;
    self.pathenemylookahead = 0;
    self.badplaceawareness = 0;
    self.chatinitialized = 0;
    self.a.disablepain = 1;
    self zm_utility::disable_react();
    self.freezegun_damage = 0;
    self thread zm_spawner::zombie_damage_failsafe();
    self.flame_damage_time = 0;
    self.meleedamage = 40;
    self.no_powerups = 1;
    self.no_gib = 1;
    self.custom_damage_func = &function_f501d50;
    self.var_35ec949b = 0;
    self.var_61aabb9c = level.var_b745bb11;
    self.dropped = 1;
    self allowpitchangle(1);
    self.var_c8806297 = &function_1d77501d;
    self function_d9b855a8("default");
    self.var_f03e855 = 1;
    if (isdefined(level.var_fd927951)) {
        self [[ level.var_fd927951 ]]();
    }
    self.zombie_move_speed = "walk";
    self zombie_utility::set_zombie_run_cycle();
    self thread zm_spawner::play_ambient_zombie_vocals();
    self thread zm_audio::zmbaivox_notifyconvert();
    self.var_ef2f46e2 = gettime();
    self notify(#"zombie_init_done");
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x2bf7727b, Offset: 0x2a78
// Size: 0x4b0
function function_dd79f3a8() {
    level.var_99568ae3[0] = "rtrg_ai_zm_dlc5_monkey_attack_perks_front";
    level.var_99568ae3[1] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left";
    level.var_99568ae3[2] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_top";
    level.var_99568ae3[3] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right";
    level.var_99568ae3[4] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_top";
    level.var_99568ae3["specialty_armorvest"]["front"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_front_jugg";
    level.var_99568ae3["specialty_armorvest"]["left"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_jugg";
    level.var_99568ae3["specialty_armorvest"]["left_top"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_top_jugg";
    level.var_99568ae3["specialty_armorvest"]["right"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_jugg";
    level.var_99568ae3["specialty_armorvest"]["right_top"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_top_jugg";
    level.var_99568ae3["specialty_staminup"]["front"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_front_marathon";
    level.var_99568ae3["specialty_staminup"]["left"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_marathon";
    level.var_99568ae3["specialty_staminup"]["left_top"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_top_marathon";
    level.var_99568ae3["specialty_staminup"]["right"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_marathon";
    level.var_99568ae3["specialty_staminup"]["right_top"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_top_marathon";
    level.var_99568ae3["specialty_quickrevive"]["front"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_front_revive";
    level.var_99568ae3["specialty_quickrevive"]["left"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_revive";
    level.var_99568ae3["specialty_quickrevive"]["left_top"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_top_revive";
    level.var_99568ae3["specialty_quickrevive"]["right"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_revive";
    level.var_99568ae3["specialty_quickrevive"]["right_top"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_top_revive";
    level.var_99568ae3["specialty_fastreload"]["front"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_front_speed";
    level.var_99568ae3["specialty_fastreload"]["left"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_speed";
    level.var_99568ae3["specialty_fastreload"]["left_top"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_top_speed";
    level.var_99568ae3["specialty_fastreload"]["right"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_speed";
    level.var_99568ae3["specialty_fastreload"]["right_top"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_top_speed";
    level.var_99568ae3["specialty_additionalprimaryweapon"]["front"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_front_mulekick";
    level.var_99568ae3["specialty_additionalprimaryweapon"]["left"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_mulekick";
    level.var_99568ae3["specialty_additionalprimaryweapon"]["left_top"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_top_mulekick";
    level.var_99568ae3["specialty_additionalprimaryweapon"]["right"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_mulekick";
    level.var_99568ae3["specialty_additionalprimaryweapon"]["right_top"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_top_mulekick";
    level.var_99568ae3["specialty_widowswine"]["front"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_front_widows_vine";
    level.var_99568ae3["specialty_widowswine"]["left"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_widows_vine";
    level.var_99568ae3["specialty_widowswine"]["left_top"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_top_widows_vine";
    level.var_99568ae3["specialty_widowswine"]["right"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_widows_vine";
    level.var_99568ae3["specialty_widowswine"]["right_top"] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_top_widows_vine";
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0xfd8eaa10, Offset: 0x2f30
// Size: 0x1e8
function function_d42b656b(pack) {
    self.script_moveoverride = 1;
    if (!isdefined(level.var_3d1f9aed)) {
        level.var_3d1f9aed = 0;
    }
    level.var_3d1f9aed++;
    var_8e9070eb = zombie_utility::spawn_zombie(self);
    self.count = 666;
    self.last_spawn_time = gettime();
    if (isdefined(var_8e9070eb)) {
        var_8e9070eb.script_noteworthy = self.script_noteworthy;
        var_8e9070eb.targetname = self.targetname;
        var_8e9070eb.target = self.target;
        var_8e9070eb.deathfunction = &function_d355c044;
        var_8e9070eb.animname = "monkey_zombie";
        var_8e9070eb.pack = pack;
        var_8e9070eb.perk = pack.perk;
        var_8e9070eb.var_ef2f46e2 = pack.var_ef2f46e2;
        var_8e9070eb.spawn_origin = self.origin;
        var_8e9070eb.spawn_angles = self.angles;
        var_8e9070eb clientfield::set("monkey_eye_glow", 1);
        var_8e9070eb thread watch_for_death();
        var_8e9070eb thread function_b2a7147a();
        var_8e9070eb.zombie_think_done = 1;
    } else {
        level.var_3d1f9aed--;
    }
    var_8e9070eb thread function_61eb8fd6();
    return var_8e9070eb;
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x3782236b, Offset: 0x3120
// Size: 0xd0
function function_61eb8fd6() {
    self endon(#"death");
    while (true) {
        n_amount, e_attacker, v_direction, v_point, str_type = self waittill(#"damage");
        if (e_attacker zm_utility::is_player()) {
            e_attacker zm_score::player_add_points("damage");
            e_attacker.var_1f20fd1c = str_type;
            self thread zm_powerups::function_3308d17f(e_attacker, str_type, v_point);
        }
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x31f8
// Size: 0x4
function watch_for_death() {
    
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xe03ecb8a, Offset: 0x3208
// Size: 0x140
function function_9a0a813d() {
    level endon(#"intermission");
    level endon(#"end_of_round");
    level endon(#"restart_round");
    /#
        level endon(#"kill_round");
        if (getdvarint("zm_aat_turned") == 2 || getdvarint("zm_aat_turned") >= 4) {
            return;
        }
    #/
    if (level.intermission) {
        return;
    }
    level.var_b20b6949 = 1;
    level thread function_3200962a();
    var_76cce6ca = 0;
    while (true) {
        level function_b589f39a();
        var_76cce6ca++;
        if (var_76cce6ca >= level.var_3bf8b909) {
            break;
        }
        time = randomfloatrange(3.2, 4.4);
        wait(time);
        util::wait_network_frame();
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x4ee1abb9, Offset: 0x3350
// Size: 0x7c
function function_f690ea5f() {
    level.var_e810cac3 = 0;
    players = getplayers();
    if (players.size > level.var_b63dbbcb) {
        level.var_3bf8b909 = players.size + level.var_b63dbbcb;
    } else {
        level.var_3bf8b909 = players.size * 2;
    }
    level.var_b63dbbcb++;
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xdd830aec, Offset: 0x33d8
// Size: 0xe4
function function_92f9a6d1() {
    switch (level.var_b63dbbcb) {
    case 1:
        level.var_a6670dd8 = level.zombie_health * 0.25;
        break;
    case 2:
        level.var_a6670dd8 = level.zombie_health * 0.5;
        break;
    case 3:
        level.var_a6670dd8 = level.zombie_health * 0.75;
        break;
    default:
        level.var_a6670dd8 = level.zombie_health;
        break;
    }
    if (level.zombie_health > 1600) {
        level.zombie_health = 1600;
    }
    function_aae19d1e("monkey health = " + level.var_a6670dd8);
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x80f070d1, Offset: 0x34c8
// Size: 0xb8
function function_b8287220() {
    level.var_5d7bed84 = [];
    for (i = 0; i < level.var_7e34a7d9.size; i++) {
        if (level.zones[level.var_7e34a7d9[i].script_noteworthy].is_enabled) {
            level.var_5d7bed84[level.var_5d7bed84.size] = level.var_7e34a7d9[i];
        }
    }
    level.var_5d7bed84 = randomize_array(level.var_5d7bed84);
    level.var_5d91ccf = 0;
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0x94f409ca, Offset: 0x3588
// Size: 0x9c
function randomize_array(array) {
    for (i = 0; i < array.size; i++) {
        j = randomint(array.size);
        temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
    return array;
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xfc4f15, Offset: 0x3630
// Size: 0x60
function function_a68db908() {
    spawner = level.var_5d7bed84[level.var_5d91ccf];
    if (isdefined(spawner)) {
        level.var_5d91ccf++;
        if (level.var_5d91ccf == level.var_5d7bed84.size) {
            level function_b8287220();
        }
    }
    return spawner;
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x0
// Checksum 0xb845551, Offset: 0x3698
// Size: 0xac
function function_f61ce2c5() {
    spawners = [];
    for (i = 0; i < level.var_7e34a7d9.size; i++) {
        if (level.zones[level.var_7e34a7d9[i].script_noteworthy].is_enabled) {
            spawners[spawners.size] = level.var_7e34a7d9[i];
        }
    }
    spawners = array::randomize(spawners);
    return spawners;
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x66f411a, Offset: 0x3750
// Size: 0x1e8
function function_78426a43() {
    level.var_4a8855e0 = [];
    var_3be8a3b8 = function_5b9c3e11();
    for (i = 0; i < var_3be8a3b8.size; i++) {
        if (var_3be8a3b8[i].targeted) {
            continue;
        }
        players = getplayers();
        for (j = 0; j < players.size; j++) {
            perk = var_3be8a3b8[i].script_noteworthy;
            org = var_3be8a3b8[i].origin;
            if (isdefined(var_3be8a3b8[i].realorigin)) {
                org = var_3be8a3b8[i].realorigin;
            }
            var_a2e716e9 = zm_zonemgr::get_zone_from_position(org, 0);
            if (players[j] hasperk(perk) && isdefined(var_a2e716e9)) {
                level.var_4a8855e0[level.var_4a8855e0.size] = var_3be8a3b8[i];
                break;
            }
        }
    }
    if (level.var_4a8855e0.size > 1) {
        level.var_4a8855e0 = array::randomize(level.var_4a8855e0);
    }
    level.var_b4e003b9 = 0;
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xcc2cab68, Offset: 0x3940
// Size: 0xee
function function_5b9c3e11() {
    vending_machines = [];
    var_560b7d8d = getentarray("zombie_vending", "targetname");
    for (i = 0; i < var_560b7d8d.size; i++) {
        if (var_560b7d8d[i].script_noteworthy != "specialty_weapupgrade") {
            if (!isdefined(vending_machines)) {
                vending_machines = [];
            } else if (!isarray(vending_machines)) {
                vending_machines = array(vending_machines);
            }
            vending_machines[vending_machines.size] = var_560b7d8d[i];
        }
    }
    return vending_machines;
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xd1bec8aa, Offset: 0x3a38
// Size: 0x90
function function_c0fc1751() {
    if (level.var_4a8855e0.size == 0) {
        self.perk = undefined;
        return;
    }
    perk = level.var_4a8855e0[level.var_b4e003b9];
    perk.targeted = 1;
    level.var_b4e003b9++;
    if (level.var_b4e003b9 == level.var_4a8855e0.size) {
        level function_78426a43();
    }
    self.perk = perk;
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xc20737e2, Offset: 0x3ad0
// Size: 0x94
function function_b589f39a() {
    function_aae19d1e("spawning pack");
    pack = spawnstruct();
    pack.monkeys = [];
    pack.attack = [];
    pack.target = undefined;
    level.var_ecb65a32[level.var_ecb65a32.size] = pack;
    pack thread function_c03b15f7();
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x5af246f7, Offset: 0x3b70
// Size: 0x174
function function_c03b15f7() {
    self.var_ef2f46e2 = gettime();
    self function_c0fc1751();
    self function_ac8bf991();
    self function_847ba2ab();
    self.var_9d1c9c35 = 0;
    for (i = 0; i < level.var_9e310f9b; i++) {
        spawner = function_a68db908();
        if (isdefined(spawner)) {
            monkey = spawner function_d42b656b(self);
            self.monkeys[self.monkeys.size] = monkey;
        }
        if (i < level.var_9e310f9b - 1) {
            time = randomfloatrange(2.2, 4.4);
            wait(time);
        }
    }
    self.var_9d1c9c35 = 1;
    self thread function_7f749e47();
    self thread function_f932e98d();
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xcad38b14, Offset: 0x3cf0
// Size: 0x168
function function_f932e98d() {
    while (true) {
        if (!isdefined(self.perk)) {
            break;
        }
        if (self.machine.var_e91fc987 == 0) {
            function_aae19d1e("pack destroyed " + self.machine.targetname);
            self function_e0d1a467();
            util::wait_network_frame();
            self function_d1c1e2a0();
            self function_c0fc1751();
            self function_ac8bf991();
            for (i = 0; i < self.monkeys.size; i++) {
                if (!self.monkeys[i].var_87a956ff) {
                    self.monkeys[i].perk = self.perk;
                    self.monkeys[i] notify(#"hash_b8e59c03");
                }
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x0
// Checksum 0x71597bd5, Offset: 0x3e60
// Size: 0x138
function j_front_pouch_le() {
    perk = undefined;
    var_4963175d = -1;
    num_perks = 0;
    keys = getarraykeys(level.var_4a8855e0);
    for (i = 0; i < keys.size; i++) {
        if (level.var_4a8855e0[keys[i]] > num_perks) {
            num_perks = level.var_4a8855e0[keys[i]];
            var_4963175d = i;
        }
    }
    if (var_4963175d >= 0) {
        perk = keys[var_4963175d];
    }
    if (isdefined(perk)) {
        function_aae19d1e("perk is " + perk);
    } else {
        function_aae19d1e("no more perks");
    }
    self.perk = perk;
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x6591d3fd, Offset: 0x3fa0
// Size: 0xae
function function_ac8bf991() {
    self.machine = undefined;
    if (!isdefined(self.perk)) {
        return;
    }
    targets = getentarray(self.perk.target, "targetname");
    for (j = 0; j < targets.size; j++) {
        if (targets[j].classname == "script_model") {
            self.machine = targets[j];
        }
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x25b64583, Offset: 0x4058
// Size: 0xe4
function function_847ba2ab() {
    var_5fa1bd33 = [];
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (!zombie_utility::is_player_valid(players[i])) {
            continue;
        }
        var_5fa1bd33[var_5fa1bd33.size] = players[i];
    }
    var_5fa1bd33 = array::randomize(var_5fa1bd33);
    if (var_5fa1bd33.size > 0) {
        self.enemy = var_5fa1bd33[0];
        return;
    }
    self.enemy = players[0];
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x21ee093e, Offset: 0x4148
// Size: 0x24c
function function_7f749e47() {
    while (self.monkeys.size > 0) {
        players = getplayers();
        total_dist = 1000000;
        var_3d64f026 = 0;
        for (i = 0; i < players.size; i++) {
            if (!zombie_utility::is_player_valid(players[i])) {
                continue;
            }
            dist = 0;
            for (j = 0; j < self.monkeys.size; j++) {
                if (!isdefined(self.monkeys[j])) {
                    continue;
                }
                dist += distance(players[i].origin, self.monkeys[j].origin);
            }
            if (dist < total_dist) {
                total_dist = dist;
                var_3d64f026 = i;
            }
            if (isdefined(players[i].b_is_designated_target) && players[i].b_is_designated_target) {
                var_3d64f026 = i;
            }
        }
        if (isdefined(players)) {
            if (isdefined(self.enemy)) {
                if (self.enemy != players[var_3d64f026]) {
                    function_aae19d1e("pack enemy is " + self.enemy.name);
                }
            } else {
                function_aae19d1e("pack enemy is " + players[var_3d64f026].name);
            }
            self.enemy = players[var_3d64f026];
        }
        wait(0.2);
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x8a647d5f, Offset: 0x43a0
// Size: 0x1c
function function_2a8f005e() {
    if (gettime() >= self.var_ef2f46e2) {
        return true;
    }
    return false;
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0x15e5fcab, Offset: 0x43c8
// Size: 0x22c
function function_d2f3f336(var_52c54b81) {
    self.var_ef2f46e2 = gettime() + level.var_7c4a5d82;
    level.var_7c4a5d82 = randomfloatrange(4.5, 6.5) * 1000;
    for (i = 0; i < self.monkeys.size; i++) {
        if (isdefined(self.monkeys[i])) {
            self.monkeys[i].var_ef2f46e2 = self.var_ef2f46e2;
        }
    }
    var_d5bdd692 = level.var_16b3fbc0 * 2;
    var_9e4d7e51 = var_d5bdd692 * var_d5bdd692;
    for (i = 0; i < level.var_ecb65a32.size; i++) {
        pack = level.var_ecb65a32[i];
        if (self == pack) {
            continue;
        }
        for (j = 0; j < pack.monkeys.size; j++) {
            monkey = pack.monkeys[j];
            if (!isdefined(monkey)) {
                continue;
            }
            if (var_52c54b81 == monkey) {
                continue;
            }
            dist_sq = distancesquared(var_52c54b81.origin, monkey.origin);
            if (dist_sq <= var_9e4d7e51) {
                monkey.var_ef2f46e2 = self.var_ef2f46e2;
            }
        }
    }
    function_aae19d1e("next ground hit in " + level.var_7c4a5d82);
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xd156752a, Offset: 0x4600
// Size: 0x9c
function function_bf9c5bbd() {
    /#
        if (getdvarint("zm_aat_turned") == 2 || getdvarint("zm_aat_turned") >= 4) {
            level waittill(#"forever");
        }
    #/
    wait(1);
    if (level flag::get("monkey_round")) {
        wait(7);
        while (level.var_b20b6949) {
            wait(0.5);
        }
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xb4a5e22c, Offset: 0x46a8
// Size: 0x80
function function_3200962a() {
    level flag::wait_till("last_monkey_down");
    level thread zm_audio::sndmusicsystem_playstate("monkey_round_end");
    level.round_spawn_func = level.var_8f91730b;
    level.round_wait_func = level.var_dffdc35f;
    wait(6);
    level.var_1b7d7bb8 = 0;
    level.var_b20b6949 = 0;
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xa5ec379e, Offset: 0x4730
// Size: 0x230
function function_ef9c7c76() {
    level flag::wait_till("power_on");
    level flag::wait_till("perk_bought");
    level.var_8f91730b = level.round_spawn_func;
    level.var_dffdc35f = level.round_wait_func;
    level.var_175c18a7 = level.round_number + randomintrange(1, 4);
    level.var_626bf0e3 = level.var_175c18a7;
    while (true) {
        level waittill(#"between_round_over");
        if (level.round_number == level.var_175c18a7) {
            if (!function_8fa57ade()) {
                level.var_175c18a7++;
                function_aae19d1e("next monkey round at " + level.var_175c18a7);
                continue;
            }
            level.var_1b7d7bb8 = 1;
            level.var_8f91730b = level.round_spawn_func;
            level.var_dffdc35f = level.round_wait_func;
            level thread zm_audio::sndmusicsystem_playstate("monkey_round_start");
            function_15768556();
            level.round_spawn_func = &function_9a0a813d;
            level.round_wait_func = &function_bf9c5bbd;
            level.var_626bf0e3 = level.var_175c18a7;
            level.var_175c18a7 = level.round_number + randomintrange(4, 6);
            function_aae19d1e("next monkey round at " + level.var_175c18a7);
            continue;
        }
        if (level flag::get("monkey_round")) {
            function_724fe496();
        }
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x5e33979a, Offset: 0x4968
// Size: 0x13c
function function_15768556() {
    level flag::set("monkey_round");
    level flag::set("monkey_free_perk");
    if (isdefined(level.var_15768556)) {
        level thread [[ level.var_15768556 ]]();
    }
    level thread function_d8ac7d7f();
    level function_92f9a6d1();
    level function_b8287220();
    level function_f690ea5f();
    level function_78426a43();
    level thread function_ca38df4c();
    util::clientnotify("monkey_start");
    playsoundatposition("zmb_ape_intro_sonicboom_fnt", (0, 0, 0));
    level thread function_5e2e012a();
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x19b4fca0, Offset: 0x4ab0
// Size: 0x6c
function function_5e2e012a() {
    wait(8);
    players = getplayers();
    players[randomintrange(0, players.size)] zm_audio::create_and_play_dialog("general", "monkey_spawn");
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x74e0c9a6, Offset: 0x4b28
// Size: 0x120
function function_724fe496() {
    level flag::clear("monkey_round");
    level flag::clear("last_monkey_down");
    if (isdefined(level.var_724fe496)) {
        level thread [[ level.var_724fe496 ]]();
    }
    util::clientnotify("monkey_stop");
    level notify(#"hash_6a70071f");
    players = getplayers();
    foreach (player in players) {
        self.var_3fc45df8 = undefined;
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x685251c5, Offset: 0x4c50
// Size: 0x164
function function_8fa57ade() {
    var_3be8a3b8 = function_5b9c3e11();
    for (i = 0; i < var_3be8a3b8.size; i++) {
        players = getplayers();
        for (j = 0; j < players.size; j++) {
            perk = var_3be8a3b8[i].script_noteworthy;
            org = var_3be8a3b8[i].origin;
            if (isdefined(var_3be8a3b8[i].realorigin)) {
                org = var_3be8a3b8[i].realorigin;
            }
            var_a2e716e9 = zm_zonemgr::get_zone_from_position(org, 0);
            if (players[j] hasperk(perk) && isdefined(var_a2e716e9)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x0
// Checksum 0x46b62980, Offset: 0x4dc0
// Size: 0x78
function function_e2b3b2bb() {
    while (true) {
        while (level.var_3d1f9aed < level.var_114d8513) {
            spawner = function_84a33c9f();
            if (isdefined(spawner)) {
                spawner function_d42b656b();
            }
            wait(10);
        }
        wait(10);
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x8476fe25, Offset: 0x4e40
// Size: 0xaa
function function_84a33c9f() {
    var_16c8e69e = undefined;
    best_score = -1;
    for (i = 0; i < level.var_7e34a7d9.size; i++) {
        score = [[ level.var_1643e9c6 ]](level.var_7e34a7d9[i]);
        if (score > best_score) {
            var_16c8e69e = level.var_7e34a7d9[i];
            best_score = score;
        }
    }
    return var_16c8e69e;
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x1607a352, Offset: 0x4ef8
// Size: 0x3c
function function_602b3d53() {
    self endon(#"death");
    self.zombie_move_speed = "run";
    self waittill(#"speed_up");
    self.zombie_move_speed = "sprint";
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x52f88196, Offset: 0x4f40
// Size: 0x1f0
function function_b2a7147a() {
    self endon(#"death");
    self thread function_f9850a27();
    self.goalradius = 32;
    self.meleeattackdist = 64;
    self.var_87a956ff = 0;
    level.var_27c3e797 = int(level.var_a6670dd8);
    if (!isdefined(self.maxhealth) || self.maxhealth < level.var_27c3e797) {
        self.maxhealth = level.var_27c3e797;
        self.health = level.var_27c3e797;
    }
    if (isdefined(level.var_83c53db8)) {
        self.maxhealth = 1;
        self.health = 1;
    }
    self thread function_602b3d53();
    self.maxsightdistsqrd = 9216;
    self [[ level.var_7deb01db ]]();
    if (isdefined(level.var_8995237a)) {
        self thread [[ level.var_8995237a ]]();
    }
    self.ignoreall = 0;
    self thread function_5ea57e90();
    self thread function_5b3f15dd();
    self thread function_5cbf8fcf();
    self thread function_e8496e8a();
    self thread function_44d16f7d();
    self thread function_bf09b321();
    self thread function_f0891021();
    if (isdefined(level.var_1498342d)) {
        self thread [[ level.var_1498342d ]]();
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x0
// Checksum 0x8568cc85, Offset: 0x5138
// Size: 0x88
function function_ac26e17f() {
    self endon(#"death");
    while (true) {
        forward = vectornormalize(anglestoforward(self.angles));
        end_pos = self.origin - vectorscale(forward, 120);
        util::wait_network_frame();
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x9239bf78, Offset: 0x51c8
// Size: 0x186
function function_bf09b321() {
    self endon(#"death");
    self endon(#"hash_68892e65");
    self animmode("none");
    while (true) {
        if (isdefined(self.var_75eca6b5) && self.var_75eca6b5) {
            util::wait_network_frame();
            continue;
        } else if (self.state == "bhb_response" || isdefined(self.state) && self.state == "grenade_response") {
            util::wait_network_frame();
            continue;
        } else if (isdefined(self.perk)) {
            self thread function_4305214b();
            self waittill(#"hash_b8e59c03");
            util::wait_network_frame();
            continue;
        } else if (isdefined(self.var_74ee5186) && self.var_74ee5186) {
            util::wait_network_frame();
            continue;
        } else if (!isdefined(self.following_player) || !self.following_player) {
            self.following_player = 1;
            self function_d9b855a8("charge_player");
        }
        wait(1);
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x1b18c1ff, Offset: 0x5358
// Size: 0x116
function function_f0891021() {
    self endon(#"death");
    while (true) {
        dist_sq = 0;
        start_pos = self.origin;
        wait(1);
        dist_sq = distancesquared(start_pos, self.origin);
        start_pos = self.origin;
        wait(1);
        dist_sq += distancesquared(start_pos, self.origin);
        start_pos = self.origin;
        wait(1);
        dist_sq += distancesquared(start_pos, self.origin);
        if (dist_sq < -112) {
            self.following_player = 1;
            self function_d9b855a8("charge_player");
        }
        wait(3);
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xb31c0b0b, Offset: 0x5478
// Size: 0xda
function function_96c9d732() {
    a_s_points = struct::get_array(self.pack.machine.target, "targetname");
    for (i = 0; i < a_s_points.size; i++) {
        if (a_s_points[i].script_noteworthy !== "attack_spot") {
            continue;
        }
        if (isdefined(self.pack.attack[i])) {
            continue;
        }
        self.pack.attack[i] = self;
        self.attack = a_s_points[i];
        break;
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xa990b30d, Offset: 0x5560
// Size: 0x10
function function_d1c1e2a0() {
    self.attack = [];
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x3773dca3, Offset: 0x5578
// Size: 0xc8
function function_f9b5859d() {
    self endon(#"death");
    var_61150253 = self.health * 0.75;
    while (true) {
        if (self.health <= var_61150253) {
            self stopanimscripted();
            util::wait_network_frame();
            self notify(#"hash_b8e59c03");
            self function_d9b855a8("charge_player");
            self.var_87a956ff = 1;
            self.perk = undefined;
            break;
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x5dc087a6, Offset: 0x5648
// Size: 0x70
function function_44d16f7d() {
    self endon(#"death");
    var_d0ad1853 = level.var_a6670dd8 * 0.5;
    while (true) {
        if (self.health <= var_d0ad1853) {
            self.var_c8806297 = undefined;
            break;
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x88312af, Offset: 0x56c0
// Size: 0x56
function function_e8496e8a() {
    self endon(#"death");
    while (true) {
        if (self.health < self.maxhealth) {
            break;
        }
        util::wait_network_frame();
    }
    self notify(#"speed_up");
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x909ca565, Offset: 0x5720
// Size: 0x86
function function_ca38df4c() {
    self endon(#"death");
    level.var_d6a3cc98 = [];
    level.var_35b3c712 = [];
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] thread function_ed0e3d5d();
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xc8fc086d, Offset: 0x57b0
// Size: 0x108
function function_ed0e3d5d() {
    self endon(#"death");
    level endon(#"hash_6a70071f");
    while (true) {
        grenade, weapon = self waittill(#"grenade_fire");
        if (zm_utility::is_lethal_grenade(weapon)) {
            grenade thread function_cc5f3e87();
            grenade.thrower = self;
            level.var_d6a3cc98[level.var_d6a3cc98.size] = grenade;
        }
        if (weapon === level.w_black_hole_bomb) {
            grenade thread function_9014347d();
            level.var_35b3c712[level.var_35b3c712.size] = grenade;
        }
        function_aae19d1e("thrown from " + weapon.name);
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x3e7cedd4, Offset: 0x58c0
// Size: 0x44
function function_cc5f3e87() {
    self waittill(#"death");
    arrayremovevalue(level.var_d6a3cc98, self);
    function_aae19d1e("remove grenade from level");
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x845c0196, Offset: 0x5910
// Size: 0x44
function function_9014347d() {
    self waittill(#"death");
    arrayremovevalue(level.var_35b3c712, self);
    function_aae19d1e("remove bhb from level");
}

// Namespace namespace_8fb880d9
// Params 2, eflags: 0x0
// Checksum 0x10ffc453, Offset: 0x5960
// Size: 0x184
function function_4334c398(target, animname) {
    self endon(#"death");
    self waittillmatch(animname, "grenade_throw");
    var_1e8168cb = randomintrange(20, 30);
    dir = vectortoangles(target.origin - self.origin);
    dir = (dir[0] - var_1e8168cb, dir[1], dir[2]);
    dir = anglestoforward(dir);
    velocity = dir * 550;
    fuse = randomfloatrange(1, 2);
    var_d2580f11 = self gettagorigin("TAG_WEAPON_RIGHT");
    grenade_type = target zm_utility::get_player_lethal_grenade();
    self magicgrenadetype(grenade_type, var_d2580f11, velocity, fuse);
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0xf605b5bf, Offset: 0x5af0
// Size: 0xc4
function function_536415cd(target) {
    self endon(#"death");
    forward = vectornormalize(anglestoforward(self.angles));
    end_pos = self.origin + function_74e6bf87(forward, 96);
    if (bullettracepassed(self.origin, end_pos, 0, undefined)) {
        self.var_cf51d24 = 1;
        return;
    }
    self.var_6602f0c5 = 1;
}

// Namespace namespace_8fb880d9
// Params 2, eflags: 0x1 linked
// Checksum 0x99271010, Offset: 0x5bc0
// Size: 0x4e
function function_74e6bf87(vec, scale) {
    vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
    return vec;
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x68330dc1, Offset: 0x5c18
// Size: 0xd8
function function_34504f07() {
    self endon(#"death");
    self endon(#"hash_b8e59c03");
    self endon(#"hash_ca94520f");
    var_9a27be81 = self.health;
    while (true) {
        var_7c7a2243 = self function_c23c2dd0();
        if (isdefined(var_7c7a2243)) {
            if (var_7c7a2243.is_occupied || self.health < var_9a27be81) {
                function_aae19d1e("player is here, go crazy");
                self.var_61aabb9c = level.var_2243306f;
                break;
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0xddbb2f40, Offset: 0x5cf8
// Size: 0xac
function function_d9b855a8(state) {
    self.state = state;
    function_aae19d1e("set state to " + state);
    /#
        if (!isdefined(self.var_ee277195)) {
            self.var_ee277195 = [];
        }
        if (!isdefined(self.var_d82deb25)) {
            self.var_d82deb25 = 0;
        }
        self.var_ee277195[self.var_d82deb25] = state;
        self.var_d82deb25++;
        if (self.var_d82deb25 > 100) {
            self.var_d82deb25 = 0;
        }
    #/
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x0
// Checksum 0xf6ab2199, Offset: 0x5db0
// Size: 0x1a
function function_aa171d7c() {
    if (isdefined(self.state)) {
        return self.state;
    }
    return undefined;
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x700b4a01, Offset: 0x5dd8
// Size: 0x4b4
function function_4afc4cb1() {
    self endon(#"death");
    self endon(#"hash_b8e59c03");
    self endon(#"hash_cce726d1");
    if (!isdefined(self.perk)) {
        return;
    }
    level flag::clear("monkey_free_perk");
    self.following_player = 0;
    self thread function_f9b5859d();
    self function_d9b855a8("attack_perk");
    level thread function_e1503bfc(self.perk.script_noteworthy, self);
    spot = self.attack.script_int;
    self teleport(self.attack.origin, self.attack.angles);
    function_aae19d1e("attack " + self.perk.script_noteworthy + " from " + spot);
    choose = 0;
    if (spot == 1) {
        choose = randomintrange(1, 3);
    } else if (spot == 3) {
        choose = randomintrange(3, 5);
    }
    var_2c6930fc = undefined;
    if (choose == 0) {
        if (isdefined(level.var_99568ae3[self.perk.script_noteworthy])) {
            var_2c6930fc = level.var_99568ae3[self.perk.script_noteworthy]["front"];
        }
    } else if (choose == 1) {
        if (isdefined(level.var_99568ae3[self.perk.script_noteworthy])) {
            var_2c6930fc = level.var_99568ae3[self.perk.script_noteworthy]["left"];
        }
    } else if (choose == 2) {
        if (isdefined(level.var_99568ae3[self.perk.script_noteworthy])) {
            var_2c6930fc = level.var_99568ae3[self.perk.script_noteworthy]["left_top"];
        }
    } else if (choose == 3) {
        if (isdefined(level.var_99568ae3[self.perk.script_noteworthy])) {
            var_2c6930fc = level.var_99568ae3[self.perk.script_noteworthy]["right"];
        }
    } else if (choose == 4) {
        if (isdefined(level.var_99568ae3[self.perk.script_noteworthy])) {
            var_2c6930fc = level.var_99568ae3[self.perk.script_noteworthy]["right_top"];
        }
    }
    if (!isdefined(var_2c6930fc)) {
        var_2c6930fc = level.var_99568ae3[choose];
    }
    self thread function_c776714a();
    time = getanimlength(var_2c6930fc);
    while (true) {
        function_b1050070(self.perk.script_noteworthy);
        self thread function_75ae4f3e(time);
        self animscripted("attack_perk_anim", self.attack.origin, self.attack.angles, var_2c6930fc);
        if (self function_a66da986(self.var_61aabb9c)) {
            break;
        }
        wait(time);
    }
    self notify(#"hash_ca94520f");
    self function_d9b855a8("attack_perk_done");
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xcc6f2964, Offset: 0x6298
// Size: 0xcc
function function_c776714a() {
    self endon(#"death");
    wait(0.2);
    self.dropped = 0;
    self.var_f4c4ea1 = self.attack.origin;
    while (true) {
        diff = abs(self.var_f4c4ea1[2] - self.origin[2]);
        if (diff < 8) {
            break;
        }
        util::wait_network_frame();
    }
    self.dropped = 1;
    function_aae19d1e("close to ground");
}

// Namespace namespace_8fb880d9
// Params 2, eflags: 0x1 linked
// Checksum 0x751ed1a5, Offset: 0x6370
// Size: 0x21a
function function_e1503bfc(perk, monkey) {
    var_ea5385f8 = 0;
    if (!isdefined(level.var_63ce4aa9)) {
        level.var_63ce4aa9 = [];
    }
    if (!isdefined(level.var_63ce4aa9[perk])) {
        level.var_63ce4aa9[perk] = 0;
    }
    if (level.var_63ce4aa9[perk]) {
        return;
    }
    level.var_63ce4aa9[perk] = 1;
    while (true) {
        player = getplayers();
        rand = randomintrange(0, player.size);
        if (monkey function_a66da986(monkey.var_61aabb9c)) {
            level.var_63ce4aa9[perk] = 0;
            return;
        }
        if (isalive(player[rand]) && !player[rand] laststand::player_is_in_laststand() && player[rand] hasperk(perk)) {
            player[rand] zm_audio::create_and_play_dialog("perk", "steal_" + perk);
            break;
        } else if (var_ea5385f8 >= 6) {
            break;
        }
        var_ea5385f8++;
        wait(0.05);
    }
    while (isdefined(monkey) && !monkey function_a66da986(monkey.var_61aabb9c)) {
        wait(1);
    }
    level.var_63ce4aa9[perk] = 0;
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0xda69def6, Offset: 0x6598
// Size: 0x9e
function function_75ae4f3e(time) {
    self endon(#"death");
    for (i = 0; i < time; i++) {
        if (randomintrange(0, 100) >= 41) {
            self playsound("zmb_monkey_attack_machine");
        }
        wait(randomfloatrange(0.7, 1.1));
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x258135b, Offset: 0x6640
// Size: 0x114
function function_4305214b() {
    self endon(#"death");
    self endon(#"hash_b8e59c03");
    if (isdefined(self.perk)) {
        self function_d9b855a8("destroy_perk");
        function_aae19d1e("goto " + self.perk.script_noteworthy);
        self function_96c9d732();
        if (isdefined(self.attack)) {
            self setgoalpos(self.attack.origin);
            self waittill(#"goal");
            self setgoalpos(self.origin);
            self thread function_34504f07();
            self thread function_4afc4cb1();
        }
    }
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0x75f523c5, Offset: 0x6760
// Size: 0x126
function function_bed58958(spawner) {
    if (!isdefined(spawner.script_noteworthy)) {
        return -1;
    }
    if (!isdefined(level.zones) || !isdefined(level.zones[spawner.script_noteworthy]) || !level.zones[spawner.script_noteworthy].is_enabled) {
        return -1;
    }
    score = 0;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        score = int(distancesquared(spawner.origin, players[i].origin));
    }
    return score;
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x0
// Checksum 0xa41bf98e, Offset: 0x6890
// Size: 0xf0
function function_d925dbf5() {
    self endon(#"death");
    if (self.var_74ee5186) {
        return;
    }
    self function_d9b855a8("ground_pound");
    self.var_74ee5186 = 1;
    self thread function_2209aaa("ground_pound");
    self zombie_shared::donotetracks("ground_pound");
    self.var_74ee5186 = 0;
    self function_d9b855a8("ground_pound_done");
    self.var_51a4be2 = gettime() + level.var_6916b2bf;
    if (self.var_35ec949b) {
        self zombie_shared::donotetracks("board_taunt");
        self.var_35ec949b = 0;
    }
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0xd5748c80, Offset: 0x6988
// Size: 0xc6
function function_db9ebbd9(claymore) {
    for (i = 0; i < self.monkeys.size; i++) {
        if (self.monkeys[i] == self) {
            continue;
        }
        ready = self.monkeys[i].var_2da34b1;
        if (isdefined(ready)) {
            for (j = 0; j < ready.size; j++) {
                if (claymore == ready[j]) {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x97d7dc1d, Offset: 0x6a58
// Size: 0x150
function function_1034cff6() {
    if (!isdefined(level.var_53daeeb4)) {
        return false;
    }
    var_36adf538 = 46656;
    height_max = 12;
    self.var_2da34b1 = [];
    for (i = 0; i < level.var_53daeeb4.size; i++) {
        if (self.pack function_db9ebbd9(level.var_53daeeb4[i])) {
            continue;
        }
        height_diff = abs(self.origin[2] - level.var_53daeeb4[i].origin[2]);
        if (height_diff < height_max) {
            if (distancesquared(self.origin, level.var_53daeeb4[i].origin) < var_36adf538) {
                self.var_2da34b1[self.var_2da34b1.size] = level.var_53daeeb4[i];
            }
        }
    }
    return self.var_2da34b1.size > 0;
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xa6cdfa3b, Offset: 0x6bb0
// Size: 0x280
function function_5ea57e90() {
    self endon(#"death");
    self.var_74ee5186 = 0;
    self.var_51a4be2 = gettime() + level.var_6916b2bf;
    while (true) {
        if (isdefined(self.state) && self.state == "attack_perk") {
            util::wait_network_frame();
            continue;
        }
        if (isdefined(self.dropped) && !self.dropped) {
            wait(1);
            continue;
        }
        if (!self.var_74ee5186 && self function_1034cff6()) {
            self.pack function_d2f3f336(self);
            self.var_aa9937 = 1;
        } else if (!self.var_74ee5186 && self function_2a8f005e()) {
            players = getplayers();
            closeenough = 0;
            origin = self geteye();
            for (i = 0; i < players.size; i++) {
                if (players[i] laststand::player_is_in_laststand()) {
                    continue;
                }
                test_origin = players[i] geteye();
                d = distancesquared(origin, test_origin);
                if (d > level.var_16b3fbc0 * level.var_16b3fbc0) {
                    continue;
                }
                if (!bullettracepassed(origin, test_origin, 0, undefined)) {
                    continue;
                }
                closeenough = 1;
                break;
            }
            if (closeenough) {
                self.pack function_d2f3f336(self);
                self.var_aa9937 = 1;
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0xad4230f5, Offset: 0x6e38
// Size: 0x4ae
function function_2209aaa(animname) {
    self endon(#"death");
    self waittillmatch(animname, "fire");
    playfxontag(level._effect["monkey_groundhit"], self, "tag_origin");
    self playsound("zmb_monkey_groundpound");
    origin = self.origin + (0, 0, 40);
    zombies = array::get_all_closest(origin, getaispeciesarray(level.zombie_team, "all"), undefined, undefined, level.var_9151fd0b);
    if (isdefined(zombies)) {
        for (i = 0; i < zombies.size; i++) {
            if (!isdefined(zombies[i])) {
                continue;
            }
            if (zm_utility::is_magic_bullet_shield_enabled(zombies[i])) {
                continue;
            }
            test_origin = zombies[i] geteye();
            if (!bullettracepassed(origin, test_origin, 0, undefined)) {
                continue;
            }
            if (zombies[i] == self) {
                continue;
            }
            if (zombies[i].animname == "monkey_zombie") {
                continue;
            }
            zombies[i] zombie_utility::gib_random_parts();
            gibserverutils::annihilate(zombies[i]);
            zombies[i] dodamage(zombies[i].health * 10, self.origin, self);
        }
    }
    players = getplayers();
    affected_players = [];
    for (i = 0; i < players.size; i++) {
        if (!zombie_utility::is_player_valid(players[i])) {
            continue;
        }
        test_origin = players[i] geteye();
        if (distancesquared(origin, test_origin) > level.var_9151fd0b * level.var_9151fd0b) {
            continue;
        }
        if (!bullettracepassed(origin, test_origin, 0, undefined)) {
            continue;
        }
        if (!isdefined(affected_players)) {
            affected_players = [];
        } else if (!isarray(affected_players)) {
            affected_players = array(affected_players);
        }
        affected_players[affected_players.size] = players[i];
    }
    self.var_35ec949b = 0;
    for (i = 0; i < affected_players.size; i++) {
        self.var_35ec949b = 1;
        player = affected_players[i];
        if (player isonground()) {
            damage = player.maxhealth * 0.5;
            player dodamage(damage, self.origin, self);
        }
    }
    if (isdefined(self.var_2da34b1)) {
        for (i = 0; i < self.var_2da34b1.size; i++) {
            if (isdefined(self.var_2da34b1[i])) {
                self.var_2da34b1[i] detonate(undefined);
            }
        }
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x2d0925d3, Offset: 0x72f0
// Size: 0x240
function function_9924e38f() {
    self endon(#"death");
    var_e133e973 = 1024;
    picked_up = 0;
    while (isdefined(self.var_6f24f931)) {
        self setgoalpos(self.var_6f24f931.origin);
        var_fc2c29a3 = distancesquared(self.origin, self.var_6f24f931.origin);
        if (var_fc2c29a3 <= var_e133e973) {
            self.var_f9b8c18a = self.var_6f24f931.thrower;
            self.var_6f24f931 delete();
            self.var_6f24f931 = undefined;
            picked_up = 1;
            function_aae19d1e("deleting grenade");
        }
        util::wait_network_frame();
    }
    if (picked_up) {
        while (true) {
            self setgoalpos(self.var_f9b8c18a.origin);
            target_dir = self.var_f9b8c18a.origin - self.origin;
            var_bf9b3d0e = anglestoforward(self.angles);
            dot = vectordot(vectornormalize(target_dir), vectornormalize(var_bf9b3d0e));
            if (dot >= 0.5) {
                break;
            }
            util::wait_network_frame();
        }
        self thread function_536415cd(self.var_f9b8c18a);
        self waittill(#"hash_8c6afaf6");
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xd32bf357, Offset: 0x7538
// Size: 0xdc
function function_9ca2294a() {
    self endon(#"death");
    function_aae19d1e("go for grenade");
    self notify(#"stop_find_flesh");
    self notify(#"hash_68892e65");
    self notify(#"hash_b8e59c03");
    self.following_player = 0;
    self function_d9b855a8("grenade_response");
    self function_b486d16b();
    self function_9924e38f();
    self thread function_bf09b321();
    self function_d9b855a8("grenade_response_done");
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x6c37bd49, Offset: 0x7620
// Size: 0x1c8
function function_5b3f15dd() {
    self endon(#"death");
    var_c52d1105 = 14400;
    while (true) {
        if (self.state == "default") {
            util::wait_network_frame();
            continue;
        }
        if (isdefined(self.var_74ee5186) && self.var_74ee5186) {
            util::wait_network_frame();
            continue;
        }
        if (isdefined(self.var_6f24f931) && self.var_6f24f931) {
            util::wait_network_frame();
            continue;
        }
        if (level.var_d6a3cc98.size > 0) {
            for (i = 0; i < level.var_d6a3cc98.size; i++) {
                grenade = level.var_d6a3cc98[i];
                if (!isdefined(grenade) || isdefined(grenade.monkey)) {
                    util::wait_network_frame();
                    continue;
                }
                var_fc2c29a3 = distancesquared(self.origin, grenade.origin);
                if (var_fc2c29a3 <= var_c52d1105) {
                    grenade.monkey = self;
                    self.var_6f24f931 = grenade;
                    self function_9ca2294a();
                    break;
                }
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x645db1aa, Offset: 0x77f0
// Size: 0x284
function function_7c76fa54() {
    self endon(#"death");
    function_aae19d1e("bhb teleport");
    var_9c0b0e0b = struct::get_array("struct_black_hole_teleport", "targetname");
    zone_name = self zm_utility::get_current_zone();
    locations = [];
    for (i = 0; i < var_9c0b0e0b.size; i++) {
        var_43372222 = var_9c0b0e0b[i].script_string;
        if (!isdefined(var_43372222) || !isdefined(zone_name)) {
            continue;
        }
        if (var_43372222 == zone_name) {
            continue;
        }
        if (!level.zones[var_43372222].is_enabled) {
            continue;
        }
        locations[locations.size] = var_9c0b0e0b[i];
    }
    self stopanimscripted();
    util::wait_network_frame();
    var_5d0ed4b3 = spawn("script_origin", self.origin);
    var_5d0ed4b3.angles = self.angles;
    self linkto(var_5d0ed4b3);
    if (locations.size > 0) {
        locations = array::randomize(locations);
        var_5d0ed4b3.origin = locations[0].origin;
        var_5d0ed4b3.angles = locations[0].angles;
    } else {
        var_5d0ed4b3.origin = self.spawn_origin;
        var_5d0ed4b3.angles = self.spawn_angles;
    }
    util::wait_network_frame();
    self unlink();
    var_5d0ed4b3 delete();
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x52d4a7d9, Offset: 0x7a80
// Size: 0xdc
function function_ed69ccce() {
    self endon(#"death");
    self endon(#"hash_64ba5cff");
    prev_origin = self.origin;
    var_93f1e3f9 = 256;
    while (true) {
        wait(1);
        dist = distancesquared(prev_origin, self.origin);
        if (dist < var_93f1e3f9) {
            break;
        }
        prev_origin = self.origin;
    }
    if (self.state == "ground_pound") {
        return;
    }
    self.safetochangescript = 1;
    self animmode("none");
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x745a55d8, Offset: 0x7b68
// Size: 0x1c4
function function_726cf50c() {
    self endon(#"death");
    var_37636677 = 4096;
    jump = 0;
    util::wait_network_frame();
    if (!isdefined(self.var_3cb23523) || !isdefined(self.var_3cb23523.origin)) {
        return;
    }
    self.safetochangescript = 0;
    self setgoalpos(self.var_3cb23523.origin);
    while (isdefined(self.var_3cb23523)) {
        var_2c3a2d7d = distancesquared(self.origin, self.var_3cb23523.origin);
        if (var_2c3a2d7d <= var_37636677) {
            jump = 1;
            break;
        }
        util::wait_network_frame();
    }
    if (jump) {
        self function_7c76fa54();
    }
    util::wait_network_frame();
    self.safetochangescript = 1;
    self setgoalpos(self.origin);
    self util::waittill_notify_or_timeout("goal", 0.5);
    self notify(#"hash_64ba5cff");
    util::wait_network_frame();
    self thread function_ed69ccce();
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x75231cd4, Offset: 0x7d38
// Size: 0xa2
function function_b486d16b() {
    if (isdefined(self.attack)) {
        if (isdefined(self.pack.attack)) {
            for (i = 0; i < self.pack.attack.size; i++) {
                if (self == self.pack.attack[i]) {
                    arrayremovevalue(self.pack.attack, self);
                    self.attack = undefined;
                    return;
                }
            }
        }
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x43c0639e, Offset: 0x7de8
// Size: 0xdc
function function_764d3d90() {
    self endon(#"death");
    function_aae19d1e("bhb response");
    self notify(#"stop_find_flesh");
    self notify(#"hash_68892e65");
    self notify(#"hash_b8e59c03");
    self.following_player = 0;
    self function_d9b855a8("bhb_response");
    self function_b486d16b();
    self function_726cf50c();
    self thread function_bf09b321();
    self function_d9b855a8("bhb_response_done");
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x8b561b09, Offset: 0x7ed0
// Size: 0x200
function function_5cbf8fcf() {
    self endon(#"death");
    var_49535fb3 = 262144;
    while (true) {
        if (self.state == "default" || self.state == "ground_pound" || self.state == "ground_pound_taunt" || self.state == "grenade_reponse" || self.state == "bhb_response" || self.state == "attack_perk" || !(isdefined(self.dropped) && self.dropped)) {
            util::wait_network_frame();
            continue;
        }
        if (level.var_35b3c712.size > 0) {
            for (i = 0; i < level.var_35b3c712.size; i++) {
                var_4478607 = level.var_35b3c712[i];
                if (isdefined(var_4478607.is_valid) && var_4478607.is_valid) {
                    if (!isdefined(var_4478607) || !isdefined(var_4478607.origin) || !isdefined(self.origin)) {
                        continue;
                    }
                    var_2c3a2d7d = distancesquared(self.origin, var_4478607.origin);
                    if (var_2c3a2d7d <= var_49535fb3) {
                        self.var_3cb23523 = var_4478607;
                        self function_764d3d90();
                    }
                }
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xfca8bab1, Offset: 0x80d8
// Size: 0x284
function function_d5e87ee0() {
    for (i = 0; i < level.var_ecb65a32.size; i++) {
        pack = level.var_ecb65a32[i];
        for (j = 0; j < pack.monkeys.size; j++) {
            if (self == pack.monkeys[j]) {
                arrayremovevalue(pack.monkeys, self);
                if (pack.monkeys.size == 0 && pack.var_9d1c9c35) {
                    if (isdefined(pack.perk)) {
                        pack.perk.targeted = 0;
                    }
                    level.var_e810cac3++;
                    level flag::set("monkey_pack_down");
                    arrayremovevalue(level.var_ecb65a32, pack);
                }
            }
        }
    }
    if (level.var_e810cac3 >= level.var_3bf8b909) {
        level flag::set("last_monkey_down");
        if (self function_5d83da34()) {
            forward = vectornormalize(anglestoforward(self.angles));
            end_pos = self.origin - vectorscale(forward, 32);
            level thread zm_powerups::specific_powerup_drop("free_perk", end_pos);
        }
        drop_pos = self.origin;
        if (self.state == "attack_perk" || !self.dropped) {
            drop_pos = self.attack.origin;
        }
        level thread zm_powerups::specific_powerup_drop("full_ammo", drop_pos);
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xbf434c46, Offset: 0x8368
// Size: 0x1f6
function function_5d83da34() {
    if (!level flag::get("monkey_free_perk")) {
        return false;
    }
    var_a854d307 = 0;
    if (!isdefined(level.var_a854d307)) {
        println("zm_aat_turned");
        var_a854d307 = 4;
    } else {
        var_a854d307 = level.var_a854d307;
    }
    if (level flag::get("solo_game")) {
        if (level.solo_lives_given >= level.var_8e7446c1) {
            players = getplayers();
            if (!players[0] hasperk("specialty_quickrevive")) {
                var_a854d307--;
            }
        }
    }
    players = getplayers();
    var_3be8a3b8 = function_5b9c3e11();
    for (i = 0; i < players.size; i++) {
        num_perks = 0;
        for (j = 0; j < var_3be8a3b8.size; j++) {
            perk = var_3be8a3b8[j].script_noteworthy;
            if (players[i] hasperk(perk)) {
                num_perks++;
            }
        }
        if (num_perks < var_a854d307) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_8fb880d9
// Params 8, eflags: 0x1 linked
// Checksum 0xdc3973f0, Offset: 0x8568
// Size: 0x1e6
function function_d355c044(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    self zombie_utility::reset_attack_spot();
    self clientfield::set("monkey_eye_glow", 0);
    self.grenadeammo = 0;
    playfx(level._effect["monkey_death"], self.origin);
    playsoundatposition("zmb_monkey_explode", self.origin);
    level zm_spawner::zombie_death_points(self.origin, self.damagemod, self.damagelocation, self.attacker, self);
    if (randomintrange(0, 100) >= 75) {
        if (isdefined(self.attacker) && isplayer(self.attacker)) {
            self.attacker zm_audio::create_and_play_dialog("kill", "space_monkey");
        }
    }
    if (self.damagemod == "MOD_BURNED") {
        self thread zombie_death::flame_death_fx();
    }
    level.var_90c5919d++;
    level.var_8757475e++;
    self function_d5e87ee0();
    self bgb::actor_death_override(attacker);
    return false;
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0x2ea0df68, Offset: 0x8758
// Size: 0x74
function function_f501d50(player) {
    self endon(#"death");
    damage = self.meleedamage;
    if (isdefined(self.var_74ee5186) && self.var_74ee5186) {
        damage = int(player.maxhealth * 0.25);
    }
    return damage;
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x3f8cecaf, Offset: 0x87d8
// Size: 0x54
function function_7d9e6c11() {
    playfx(level._effect["monkey_spawn"], self.origin);
    playsoundatposition("zmb_ape_intro_land", self.origin);
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x6fdcfc3, Offset: 0x8838
// Size: 0x88
function function_8eae2284() {
    self endon(#"death");
    while (true) {
        if (isdefined(self.favoriteenemy)) {
            self.ignoreall = 0;
            self orientmode("face default");
            self setgoalpos(self.favoriteenemy.origin);
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x0
// Checksum 0x907fd406, Offset: 0x88c8
// Size: 0x1b0
function function_8ef4eaf7() {
    self endon(#"death");
    level endon(#"intermission");
    self endon(#"stop_find_flesh");
    if (level.intermission) {
        return;
    }
    self zm_spawner::zombie_history("monkey find flesh -> start");
    self.goalradius = 48;
    players = getplayers();
    self.ignore_player = [];
    player = zm_utility::get_closest_valid_player(self.origin, self.ignore_player);
    if (!isdefined(player)) {
        self zm_spawner::zombie_history("monkey find flesh -> can't find player, continue");
    }
    self.favoriteenemy = player;
    while (true) {
        if (isdefined(self.pack) && isdefined(self.pack.enemy)) {
            if (!isdefined(self.favoriteenemy) || self.favoriteenemy != self.pack.enemy) {
                self.favoriteenemy = self.pack.enemy;
            }
        }
        if (isdefined(level.var_66fdee6d)) {
            self thread function_8eae2284();
        } else {
            self.ignoreall = 0;
            self orientmode("face default");
        }
        wait(0.1);
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xf7573bf2, Offset: 0x8a80
// Size: 0x66
function function_d8ac7d7f() {
    var_3be8a3b8 = function_5b9c3e11();
    for (i = 0; i < var_3be8a3b8.size; i++) {
        var_3be8a3b8[i] function_dbcd70d7();
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x6d4739ec, Offset: 0x8af0
// Size: 0xcc
function function_dbcd70d7() {
    self.targeted = 0;
    machine = undefined;
    targets = getentarray(self.target, "targetname");
    for (i = 0; i < targets.size; i++) {
        if (targets[i].classname == "script_model") {
            machine = targets[i];
            break;
        }
    }
    if (isdefined(machine)) {
        machine.var_e91fc987 = 100;
    }
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0x31c61ccb, Offset: 0x8bc8
// Size: 0x9a
function function_a66da986(amount) {
    if (!isdefined(self.perk)) {
        return true;
    }
    machine = self.pack.machine;
    machine.var_e91fc987 -= amount;
    if (machine.var_e91fc987 < 0) {
        machine.var_e91fc987 = 0;
    }
    return machine.var_e91fc987 == 0;
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x845a1969, Offset: 0x8c70
// Size: 0x116
function function_e0d1a467() {
    players = getplayers();
    self.perk.targeted = 0;
    perk = self.perk.script_noteworthy;
    for (i = 0; i < players.size; i++) {
        if (players[i] hasperk(perk)) {
            perk_str = perk + "_stop";
            players[i] notify(perk_str);
            if (level flag::get("solo_game") && perk == "specialty_quickrevive") {
                players[i].lives--;
            }
        }
    }
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0xe68601d9, Offset: 0x8d90
// Size: 0x40
function function_85994fd6(perk) {
    if (perk == "specialty_armorvest") {
        if (self.health > self.maxhealth) {
            self.health = self.maxhealth;
        }
    }
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0xffe5c26a, Offset: 0x8dd8
// Size: 0x36
function function_57ee756d(perk) {
    level flag::set("perk_bought");
    level.var_7b162f9e = undefined;
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0xb7dfb427, Offset: 0x8e18
// Size: 0xa6
function function_b1050070(perk) {
    if (!isdefined(perk)) {
        return;
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (players[i] hasperk(perk)) {
            players[i] thread function_7acaa6b4(perk);
        }
    }
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0x245191a7, Offset: 0x8ec8
// Size: 0xb4
function function_7acaa6b4(perk) {
    self endon(#"disconnect");
    if (!isdefined(self.var_3fc45df8) || self.var_3fc45df8 != perk) {
        self.var_3fc45df8 = perk;
        self zm_perks::set_perk_clientfield(perk, 2);
        wait(0.3);
        if (self hasperk(perk)) {
            self zm_perks::set_perk_clientfield(perk, 1);
        }
        self.var_3fc45df8 = "none";
    }
}

// Namespace namespace_8fb880d9
// Params 2, eflags: 0x0
// Checksum 0x77c55f48, Offset: 0x8f88
// Size: 0x5a
function function_9a616a62(perk, taken) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
    }
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x400a3476, Offset: 0x8ff0
// Size: 0xe4
function function_c23c2dd0() {
    zone = undefined;
    keys = getarraykeys(level.zones);
    for (i = 0; i < keys.size; i++) {
        zone = level.zones[keys[i]];
        for (j = 0; j < zone.volumes.size; j++) {
            if (self istouching(zone.volumes[j])) {
                return zone;
            }
        }
    }
    return zone;
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0x7b7b6ae9, Offset: 0x90e0
// Size: 0x1ea
function function_1d77501d(player) {
    function_aae19d1e("fling monkey damage");
    damage = int(level.var_a6670dd8 * 0.5);
    self dodamage(damage, self.origin, self);
    forward = vectornormalize(anglestoforward(self.angles));
    var_4d497f8d = vectornormalize(self.origin - player.origin);
    dot = vectordot(var_4d497f8d, forward);
    if (dot < 0) {
        end_pos = self.origin - vectorscale(forward, 120);
        if (sighttracepassed(self.origin, end_pos, 0, self)) {
            var_b949ee08 = array::randomize(level.var_45abf882);
            length = getanimlength(var_b949ee08[0]);
            self animscripted("fling_anim", self.origin, self.angles, var_b949ee08[0]);
            wait(length);
        }
    }
    self.var_c8806297 = undefined;
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0x58499b0d, Offset: 0x92d8
// Size: 0x9a
function function_67695f31() {
    var_3be8a3b8 = getentarray("zombie_vending", "targetname");
    for (i = 0; i < var_3be8a3b8.size; i++) {
        if (var_3be8a3b8[i].script_noteworthy == "specialty_quickrevive") {
            var_3be8a3b8[i] delete();
            break;
        }
    }
}

// Namespace namespace_8fb880d9
// Params 1, eflags: 0x1 linked
// Checksum 0xa9b6ec9a, Offset: 0x9380
// Size: 0x44
function function_aae19d1e(str) {
    /#
        if (isdefined(level.var_ce37864e) && level.var_ce37864e) {
            iprintln(str + "zm_aat_turned");
        }
    #/
}

// Namespace namespace_8fb880d9
// Params 0, eflags: 0x1 linked
// Checksum 0xdc91446e, Offset: 0x93d0
// Size: 0x38
function function_f9850a27() {
    self endon(#"death");
    while (true) {
        wait(randomfloatrange(1.25, 3));
    }
}

