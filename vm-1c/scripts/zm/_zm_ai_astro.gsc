#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/archetype_robot;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_c0afbdaf;

// Namespace namespace_c0afbdaf
// Params 0, eflags: 0x2
// namespace_c0afbdaf<file_0>::function_c35e6aab
// Checksum 0xdb52656a, Offset: 0x688
// Size: 0x284
function autoexec init() {
    function_ecd296a1();
    spawner::add_archetype_spawn_function("astronaut", &function_c1d5663e);
    spawner::add_archetype_spawn_function("astronaut", &function_608d24f2);
    animationstatenetwork::registernotetrackhandlerfunction("headbutt_start", &function_381fe28d);
    animationstatenetwork::registernotetrackhandlerfunction("astro_melee", &function_784f7bb7);
    function_573f0339();
    if (!isdefined(level.var_43c494eb)) {
        level.var_43c494eb = &function_bb91c981;
    }
    level.var_107ab7d7 = 0;
    level.var_d5ac3d29 = getentarray("astronaut_zombie", "targetname");
    level.var_dfd7bfe1 = 1;
    level.var_59fca61d = 4;
    level.var_d2761852 = 1;
    level.var_d5f518b8 = 2;
    level.var_adbb5666 = 1;
    level.var_466cb1bf = level.var_adbb5666 + randomintrange(0, level.var_d5f518b8 + 1);
    level.var_d89d2e38 = 1;
    level.var_73a54e75 = 0;
    level.var_bd4df085 = 400;
    level.var_2cb6f804 = -106;
    level.var_4c24743 = 100;
    level.var_87ad894d = 300;
    level.var_ce54f4d4 = 2000;
    level.var_a781f972 = 4096;
    level.var_38514564 = 0;
    level.zombie_total_set_func = &function_b4471748;
    zm_spawner::register_zombie_damage_callback(&function_3d0b0628);
    while (!isdefined(level.custom_ai_spawn_check_funcs)) {
        wait(0.05);
    }
    zm::register_custom_ai_spawn_check("astro", &function_64229c1f, &function_870ce941, &function_13189f7a);
}

// Namespace namespace_c0afbdaf
// Params 0, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_c1d5663e
// Checksum 0x92a55608, Offset: 0x918
// Size: 0xe4
function function_c1d5663e() {
    blackboard::createblackboardforentity(self);
    self aiutility::function_89e1fc16();
    ai::createinterfaceforentity(self);
    blackboard::registerblackboardattribute(self, "_locomotion_speed", "locomotion_speed_walk", &zombiebehavior::function_f8ae4008);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("astroTargetService");
        #/
    }
    self.___archetypeonanimscriptedcallback = &function_11b12c90;
    /#
        self finalizetrackedblackboardattributes();
    #/
}

// Namespace namespace_c0afbdaf
// Params 1, eflags: 0x5 linked
// namespace_c0afbdaf<file_0>::function_11b12c90
// Checksum 0xcb9a2df6, Offset: 0xa08
// Size: 0x34
function private function_11b12c90(entity) {
    entity.__blackboard = undefined;
    entity function_c1d5663e();
}

// Namespace namespace_c0afbdaf
// Params 0, eflags: 0x5 linked
// namespace_c0afbdaf<file_0>::function_ecd296a1
// Checksum 0x664e962, Offset: 0xa48
// Size: 0x74
function private function_ecd296a1() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("astroTargetService", &function_fa8c98de);
    behaviortreenetworkutility::registerbehaviortreeaction("moonAstroProceduralTraversal", &function_1dd16458, &robotsoldierbehavior::robotproceduraltraversalupdate, &function_da0d7bfb);
}

// Namespace namespace_c0afbdaf
// Params 0, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_608d24f2
// Checksum 0x1f5d5de0, Offset: 0xac8
// Size: 0x34
function function_608d24f2() {
    self function_3ba0e201();
    self thread function_396473db(self);
}

// Namespace namespace_c0afbdaf
// Params 1, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_fa8c98de
// Checksum 0xb6672acb, Offset: 0xb08
// Size: 0x248
function function_fa8c98de(entity) {
    if (isdefined(entity.ignoreall) && entity.ignoreall) {
        return 0;
    }
    player = zombie_utility::get_closest_valid_player(self.origin, self.ignore_player);
    entity.favoriteenemy = player;
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
    targetpos = getclosestpointonnavmesh(player.origin, 15, 15);
    if (isdefined(targetpos)) {
        entity setgoal(targetpos);
        return 1;
    }
    if (isdefined(player.last_valid_position)) {
        entity setgoal(player.last_valid_position);
        return 1;
    }
    entity setgoal(entity.origin);
    return 0;
}

// Namespace namespace_c0afbdaf
// Params 0, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_64229c1f
// Checksum 0x8f2f877f, Offset: 0xd58
// Size: 0xbc
function function_64229c1f() {
    if (isdefined(level.zm_loc_types["astro_location"]) && level.zm_loc_types["astro_location"].size <= 0) {
        return false;
    }
    if (!(level.round_number >= level.var_466cb1bf && level.var_107ab7d7 < level.var_dfd7bfe1)) {
        return false;
    }
    if (!(isdefined(level.var_5f225972) && level.var_5f225972)) {
        return false;
    }
    if (!(isdefined(level.var_38514564) && level.var_38514564)) {
        return false;
    }
    if (level.zombie_total > level.var_d89d2e38) {
        return false;
    }
    return true;
}

// Namespace namespace_c0afbdaf
// Params 0, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_870ce941
// Checksum 0x3162aa02, Offset: 0xe20
// Size: 0xa
function function_870ce941() {
    return level.var_d5ac3d29;
}

// Namespace namespace_c0afbdaf
// Params 0, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_13189f7a
// Checksum 0x772d6893, Offset: 0xe38
// Size: 0x14
function function_13189f7a() {
    return level.zm_loc_types["astro_location"];
}

// Namespace namespace_c0afbdaf
// Params 0, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_3ba0e201
// Checksum 0x4360516b, Offset: 0xe58
// Size: 0x2aa
function function_3ba0e201() {
    self.animname = "astro_zombie";
    self.ignoreall = 1;
    self.allowdeath = 1;
    self.is_zombie = 1;
    self.has_legs = 1;
    self allowedstances("stand");
    self.gibbed = 0;
    self.head_gibbed = 0;
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
    self thread zm_spawner::zombie_damage_failsafe();
    self thread zombie_utility::delayed_zombie_eye_glow();
    self.flame_damage_time = 0;
    self.meleedamage = 50;
    self.no_powerups = 1;
    self.no_gib = 1;
    self.var_ceb0ee4e = 1;
    self.actor_damage_func = &function_daaa8ee8;
    self.nuke_damage_func = &function_6ceb10c6;
    self.custom_damage_func = &function_5b578b80;
    self.var_bb3019d = &function_30b174f4;
    self.ignore_cleanup_mgr = 1;
    self.var_ae0a0c99 = 1;
    self.ignore_enemy_count = 1;
    self.var_a7d1d70c = 1;
    self.ignore_devgui_death = 1;
    self.var_e5e875ef = 1;
    self.ignore_round_spawn_failsafe = 1;
    self.ignore_poi_targetname = [];
    self.ignore_poi_targetname[self.ignore_poi_targetname.size] = "zm_bhb";
    self.zombie_move_speed = "walk";
    self zombie_utility::set_zombie_run_cycle();
    self.zombie_think_done = 1;
    self thread zm_spawner::play_ambient_zombie_vocals();
    self thread zm_audio::zmbaivox_notifyconvert();
    self notify(#"zombie_init_done");
}

// Namespace namespace_c0afbdaf
// Params 0, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_573f0339
// Checksum 0x11f370e6, Offset: 0x1110
// Size: 0x3a
function function_573f0339() {
    level._effect["astro_spawn"] = "dlc5/moon/fx_moon_qbomb_explo_distort";
    level._effect["astro_explosion"] = "dlc5/moon/fx_moon_qbomb_explo_distort";
}

// Namespace namespace_c0afbdaf
// Params 1, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_396473db
// Checksum 0xd785b6df, Offset: 0x1158
// Size: 0x100
function function_396473db(var_e44e9ddb) {
    self.script_moveoverride = 1;
    if (!isdefined(level.var_107ab7d7)) {
        level.var_107ab7d7 = 0;
    }
    level.var_107ab7d7++;
    var_e44e9ddb.has_legs = 1;
    self.count = 100;
    playsoundatposition("evt_astro_spawn", self.origin);
    var_e44e9ddb.deathfunction = &function_16a70fd4;
    var_e44e9ddb.animname = "astro_zombie";
    var_e44e9ddb.loopsound = "evt_astro_gasmask_loop";
    var_e44e9ddb thread function_63a252ea();
    function_9c51dcdd("astro spawned in " + level.round_number);
    return var_e44e9ddb;
}

// Namespace namespace_c0afbdaf
// Params 0, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_b4471748
// Checksum 0x4f05ba75, Offset: 0x1260
// Size: 0xe4
function function_b4471748() {
    level.var_38514564 = 1;
    level.var_d89d2e38 = 1;
    if (level.zombie_total > 1) {
        level.var_d89d2e38 = randomintrange(int(level.zombie_total * 0.25), int(level.zombie_total * 0.75));
    }
    function_9c51dcdd("next astro round = " + level.var_466cb1bf);
    function_9c51dcdd("zombies to kill = " + level.zombie_total - level.var_d89d2e38);
}

// Namespace namespace_c0afbdaf
// Params 0, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_63a252ea
// Checksum 0xf1d3017f, Offset: 0x1350
// Size: 0xdc
function function_63a252ea() {
    self endon(#"death");
    self.var_cf2628ad = 0;
    self.ignoreall = 0;
    self.maxhealth = level.zombie_health * getplayers().size * level.var_59fca61d;
    self.health = self.maxhealth;
    self.maxsightdistsqrd = 9216;
    self.zombie_move_speed = "walk";
    self thread [[ level.var_43c494eb ]]();
    if (isdefined(level.var_dc9bc60a)) {
        self thread [[ level.var_dc9bc60a ]]();
    }
    self thread function_26a9618e();
    self playloopsound(self.loopsound);
}

// Namespace namespace_c0afbdaf
// Params 0, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_26a9618e
// Checksum 0x8929caa, Offset: 0x1438
// Size: 0x26c
function function_26a9618e() {
    self endon(#"death");
    self.var_a2ffee41 = 0;
    self.var_8ee1d008 = gettime() + level.var_ce54f4d4;
    while (true) {
        if (!isdefined(self.enemy)) {
            wait(0.05);
            continue;
        }
        if (!self.var_a2ffee41 && gettime() > self.var_8ee1d008) {
            origin = self geteye();
            test_origin = self.enemy geteye();
            dist_sqr = distancesquared(origin, test_origin);
            if (dist_sqr > level.var_a781f972) {
                wait(0.05);
                continue;
            }
            yaw = zombie_utility::getyawtoorigin(self.enemy.origin);
            if (abs(yaw) > 45) {
                wait(0.05);
                continue;
            }
            if (!bullettracepassed(origin, test_origin, 0, undefined)) {
                wait(0.05);
                continue;
            }
            self.var_a2ffee41 = 1;
            self thread function_c08df578();
            var_d1086830 = self animmappingsearch(istring("anim_astro_headbutt"));
            time = getanimlength(var_d1086830);
            self.var_8d3d04ec thread function_c2e771ff(time);
            self animscripted("headbutt_anim", self.origin, self.angles, "ai_zm_dlc5_zombie_astro_headbutt");
            wait(time);
            self.var_8ee1d008 = gettime() + level.var_ce54f4d4;
            self.var_a2ffee41 = 0;
        }
        wait(0.05);
    }
}

// Namespace namespace_c0afbdaf
// Params 1, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_c2e771ff
// Checksum 0xf4311e76, Offset: 0x16b0
// Size: 0x7c
function function_c2e771ff(time) {
    self endon(#"disconnect");
    wait(time);
    self allowjump(1);
    self allowprone(1);
    self allowcrouch(1);
    self setmovespeedscale(1);
}

// Namespace namespace_c0afbdaf
// Params 2, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_1dd16458
// Checksum 0x6ec6884, Offset: 0x1738
// Size: 0x48
function function_1dd16458(entity, asmstatename) {
    robotsoldierbehavior::robotcalcproceduraltraversal(entity, asmstatename);
    robotsoldierbehavior::robottraversestart(entity, asmstatename);
    return 5;
}

// Namespace namespace_c0afbdaf
// Params 2, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_da0d7bfb
// Checksum 0xf3a1b7b1, Offset: 0x1788
// Size: 0x48
function function_da0d7bfb(entity, asmstatename) {
    robotsoldierbehavior::robotprocedurallandingupdate(entity, asmstatename);
    robotsoldierbehavior::robottraverseend(entity);
    return 4;
}

// Namespace namespace_c0afbdaf
// Params 0, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_c08df578
// Checksum 0x8b34e1bd, Offset: 0x17d8
// Size: 0x26c
function function_c08df578() {
    self endon(#"death");
    self.var_8d3d04ec = self.enemy;
    player = self.var_8d3d04ec;
    up = player.origin + (0, 0, 10);
    var_7aa0b3b = vectortoangles(self.origin - up);
    player thread function_ec52ceb(self);
    if (self.health > 0) {
        player freezecontrols(1);
    }
    lerp_time = 0.2;
    var_e78b4163 = vectornormalize(player.origin - self.origin);
    link_org = self.origin + 40 * var_e78b4163;
    player function_c396f2d4(link_org, var_7aa0b3b, lerp_time, 1);
    wait(lerp_time);
    player freezecontrols(0);
    player allowjump(0);
    player allowstand(1);
    player allowprone(0);
    player allowcrouch(0);
    player setmovespeedscale(0.1);
    player notify(#"released");
    dist = distance(self.origin, player.origin);
    function_9c51dcdd("grab dist = " + dist);
}

// Namespace namespace_c0afbdaf
// Params 9, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_c396f2d4
// Checksum 0xee061d7d, Offset: 0x1a50
// Size: 0x22c
function function_c396f2d4(origin, angles, lerptime, fraction, var_73e5663c, var_8d08894f, var_9e839db7, var_19104919, var_d45d870e) {
    if (isplayer(self)) {
        self endon(#"disconnect");
    }
    linker = spawn("script_origin", (0, 0, 0));
    linker.origin = self.origin;
    linker.angles = self getplayerangles();
    if (isdefined(var_d45d870e)) {
        self playerlinkto(linker, "", fraction, var_73e5663c, var_8d08894f, var_9e839db7, var_19104919, var_d45d870e);
    } else if (isdefined(var_73e5663c)) {
        self playerlinkto(linker, "", fraction, var_73e5663c, var_8d08894f, var_9e839db7, var_19104919);
    } else if (isdefined(fraction)) {
        self playerlinkto(linker, "", fraction);
    } else {
        self playerlinkto(linker);
    }
    linker moveto(origin, lerptime, lerptime * 0.25);
    linker rotateto(angles, lerptime, lerptime * 0.25);
    linker waittill(#"movedone");
    linker delete();
}

// Namespace namespace_c0afbdaf
// Params 1, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_ec52ceb
// Checksum 0xaa5f3417, Offset: 0x1c88
// Size: 0xa4
function function_ec52ceb(var_9061b3e2) {
    self endon(#"released");
    self endon(#"disconnect");
    animlen = var_9061b3e2 getanimlengthfromasd("zm_headbutt", 0);
    time = 0.5 + animlen;
    var_9061b3e2 util::waittill_notify_or_timeout("death", time);
    self freezecontrols(0);
}

// Namespace namespace_c0afbdaf
// Params 1, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_784f7bb7
// Checksum 0x2a5b9b59, Offset: 0x1d38
// Size: 0x7c
function function_784f7bb7(entity) {
    if (!isdefined(entity.var_8d3d04ec) || !zombie_utility::is_player_valid(entity.var_8d3d04ec)) {
        return;
    }
    entity thread function_44110cda();
    entity thread function_94fcd3b6();
}

// Namespace namespace_c0afbdaf
// Params 1, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_381fe28d
// Checksum 0xadf4a985, Offset: 0x1dc0
// Size: 0x16c
function function_381fe28d(entity) {
    var_406d853e = 59;
    player = entity.var_8d3d04ec;
    if (!isdefined(player) || !isalive(player)) {
        return;
    }
    dist = distance(player.origin, entity.origin);
    function_9c51dcdd("distance before headbutt = " + dist);
    if (dist < var_406d853e) {
        return;
    }
    player allowjump(1);
    player allowprone(1);
    player allowcrouch(1);
    player setmovespeedscale(1);
    self animscripted("headbutt_anim", entity.origin, entity.angles, "ai_zm_dlc5_zombie_astro_headbutt_release");
}

// Namespace namespace_c0afbdaf
// Params 0, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_44110cda
// Checksum 0x1b330221, Offset: 0x1f38
// Size: 0x22c
function function_44110cda() {
    self endon(#"death");
    if (!isdefined(self.var_8d3d04ec)) {
        return;
    }
    player = self.var_8d3d04ec;
    perk_list = [];
    var_3be8a3b8 = getentarray("zombie_vending", "targetname");
    for (i = 0; i < var_3be8a3b8.size; i++) {
        perk = var_3be8a3b8[i].script_noteworthy;
        if (player hasperk(perk)) {
            perk_list[perk_list.size] = perk;
        }
    }
    take_perk = 0;
    if (perk_list.size > 0 && !isdefined(player.var_7fceabe1)) {
        take_perk = 1;
        perk_list = array::randomize(perk_list);
        perk = perk_list[0];
        perk_str = perk + "_stop";
        player notify(perk_str);
        if (level flag::get("solo_game") && perk == "specialty_quickrevive") {
            player.lives--;
        }
        player thread function_e3c9f05c(self, self.origin);
    }
    if (!take_perk) {
        damage = player.health - 1;
        player dodamage(damage, self.origin, self);
    }
}

// Namespace namespace_c0afbdaf
// Params 2, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_e3c9f05c
// Checksum 0x69e4f563, Offset: 0x2170
// Size: 0x9c
function function_e3c9f05c(var_9061b3e2, org) {
    self endon(#"disconnect");
    self waittill(#"hash_3d708932");
    damage = self.health - 1;
    if (isdefined(var_9061b3e2)) {
        self dodamage(damage, var_9061b3e2.origin, var_9061b3e2);
        return;
    }
    self dodamage(damage, org);
}

// Namespace namespace_c0afbdaf
// Params 0, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_94fcd3b6
// Checksum 0xbcce0fae, Offset: 0x2218
// Size: 0x24c
function function_94fcd3b6() {
    self endon(#"death");
    player = self.var_8d3d04ec;
    var_3bc48314 = struct::get_array("struct_black_hole_teleport", "targetname");
    var_b9ca37a = undefined;
    if (isdefined(level.var_c9271e19)) {
        var_3bc48314 = [[ level.var_c9271e19 ]]();
    }
    var_846af699 = player zm_utility::get_current_zone();
    if (!isdefined(var_3bc48314) || var_3bc48314.size == 0 || !isdefined(var_846af699)) {
        return;
    }
    var_3bc48314 = array::randomize(var_3bc48314);
    for (i = 0; i < var_3bc48314.size; i++) {
        volume = level.zones[var_3bc48314[i].script_string].volumes[0];
        var_a2e716e9 = zm_zonemgr::get_zone_from_position(var_3bc48314[i].origin, 0);
        if (isdefined(var_a2e716e9) && var_846af699 != var_3bc48314[i].script_string) {
            if (!level flag::get("power_on") || volume.script_string == "lowgravity") {
                var_b9ca37a = var_3bc48314[i];
                break;
            } else {
                var_b9ca37a = var_3bc48314[i];
            }
            continue;
        }
        if (isdefined(var_a2e716e9)) {
            var_b9ca37a = var_3bc48314[i];
        }
    }
    if (isdefined(var_b9ca37a)) {
        player thread function_14e2ec4f(var_b9ca37a);
    }
}

// Namespace namespace_c0afbdaf
// Params 1, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_14e2ec4f
// Checksum 0xd2caabd5, Offset: 0x2470
// Size: 0x26c
function function_14e2ec4f(var_ff042d85) {
    self endon(#"death");
    if (!isdefined(var_ff042d85)) {
        return;
    }
    prone_offset = (0, 0, 49);
    crouch_offset = (0, 0, 20);
    var_7cac5f2f = (0, 0, 0);
    destination = undefined;
    if (self getstance() == "prone") {
        destination = var_ff042d85.origin + prone_offset;
    } else if (self getstance() == "crouch") {
        destination = var_ff042d85.origin + crouch_offset;
    } else {
        destination = var_ff042d85.origin + var_7cac5f2f;
    }
    if (isdefined(level.var_563d5383)) {
        level [[ level.var_563d5383 ]](self);
    }
    self freezecontrols(1);
    self disableoffhandweapons();
    self disableweapons();
    self dontinterpolate();
    self setorigin(destination);
    self setplayerangles(var_ff042d85.angles);
    self enableoffhandweapons();
    self enableweapons();
    self freezecontrols(0);
    earthquake(0.8, 0.75, self.origin, 1000, self);
    self playsoundtoplayer("zmb_gersh_teleporter_go_2d", self);
}

// Namespace namespace_c0afbdaf
// Params 8, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_16a70fd4
// Checksum 0x43f8e88d, Offset: 0x26e8
// Size: 0x15a
function function_16a70fd4(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    playfxontag(level._effect["astro_explosion"], self, "J_SpineLower");
    self stoploopsound(1);
    self playsound("evt_astro_zombie_explo");
    self thread function_df565004();
    self thread function_703ac718();
    level.var_107ab7d7--;
    level.var_466cb1bf = level.round_number + randomintrange(level.var_d2761852, level.var_d5f518b8 + 1);
    level.var_38514564 = 0;
    function_9c51dcdd("astro killed in " + level.round_number);
    return self zm_spawner::zombie_death_animscript();
}

// Namespace namespace_c0afbdaf
// Params 0, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_df565004
// Checksum 0xce5d524e, Offset: 0x2850
// Size: 0x7c
function function_df565004() {
    self endon(#"death");
    self setplayercollision(0);
    self thread zombie_utility::zombie_eye_glow_stop();
    wait(0.05);
    self ghost();
    wait(0.05);
    self delete();
}

// Namespace namespace_c0afbdaf
// Params 0, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_703ac718
// Checksum 0xcc2852e5, Offset: 0x28d8
// Size: 0x47a
function function_703ac718() {
    var_39c349d3 = self geteye();
    var_c90aa992 = self.origin + (0, 0, 8);
    var_601feca6 = (var_c90aa992[0], var_c90aa992[1], (var_c90aa992[2] + var_39c349d3[2]) / 2);
    var_750f1c85 = self.origin;
    if (isdefined(self.var_8d3d04ec)) {
        self.var_8d3d04ec allowjump(1);
        self.var_8d3d04ec allowprone(1);
        self.var_8d3d04ec allowcrouch(1);
        self.var_8d3d04ec unlink();
        wait(0.05);
        wait(0.05);
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (!zombie_utility::is_player_valid(player)) {
            continue;
        }
        var_1848d0a6 = player geteye();
        var_85312e91 = level.var_bd4df085;
        if (distancesquared(var_39c349d3, var_1848d0a6) > var_85312e91 * var_85312e91) {
            continue;
        }
        var_6cb4f7bd = player.origin + (0, 0, 8);
        var_8da9ff79 = (var_6cb4f7bd[0], var_6cb4f7bd[1], (var_6cb4f7bd[2] + var_1848d0a6[2]) / 2);
        if (!bullettracepassed(var_39c349d3, var_1848d0a6, 0, undefined)) {
            if (!bullettracepassed(var_601feca6, var_8da9ff79, 0, undefined)) {
                if (!bullettracepassed(var_c90aa992, var_6cb4f7bd, 0, undefined)) {
                    continue;
                }
            }
        }
        dist = distance(var_39c349d3, var_1848d0a6);
        scale = 1 - dist / var_85312e91;
        if (scale < 0) {
            scale = 0;
        }
        bonus = (level.var_87ad894d - level.var_4c24743) * scale;
        pulse = level.var_4c24743 + bonus;
        dir = (player.origin[0] - var_750f1c85[0], player.origin[1] - var_750f1c85[1], 0);
        dir = vectornormalize(dir);
        dir += (0, 0, 1);
        dir *= pulse;
        player setorigin(player.origin + (0, 0, 1));
        player_velocity = dir;
        player setvelocity(player_velocity);
        if (isdefined(level.var_43f73d1d)) {
            player thread [[ level.var_43f73d1d ]](var_601feca6);
        }
    }
}

// Namespace namespace_c0afbdaf
// Params 11, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_daaa8ee8
// Checksum 0xbe8352dd, Offset: 0x2d60
// Size: 0xa2
function function_daaa8ee8(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    self endon(#"death");
    switch (weapon.name) {
    case 46:
    case 47:
        damage = 0;
        break;
    }
    return damage;
}

// Namespace namespace_c0afbdaf
// Params 0, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_6ceb10c6
// Checksum 0x302aba93, Offset: 0x2e10
// Size: 0xe
function function_6ceb10c6() {
    self endon(#"death");
}

// Namespace namespace_c0afbdaf
// Params 1, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_5b578b80
// Checksum 0xef708f8b, Offset: 0x2e28
// Size: 0x68
function function_5b578b80(player) {
    damage = self.meleedamage;
    if (self.var_a2ffee41) {
        damage = player.health - 1;
    }
    function_9c51dcdd("astro damage = " + damage);
    return damage;
}

// Namespace namespace_c0afbdaf
// Params 1, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_30b174f4
// Checksum 0x86a399e4, Offset: 0x2e98
// Size: 0x24
function function_30b174f4(player) {
    function_9c51dcdd("astro sizzle");
}

// Namespace namespace_c0afbdaf
// Params 0, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_bb91c981
// Checksum 0xbafb1638, Offset: 0x2ec8
// Size: 0xc0
function function_bb91c981() {
    playfx(level._effect["astro_spawn"], self.origin);
    playsoundatposition("zmb_bolt", self.origin);
    players = getplayers();
    players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("general", "astro_spawn");
    self.var_cf2628ad = 1;
}

// Namespace namespace_c0afbdaf
// Params 13, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_3d0b0628
// Checksum 0xa21dfa10, Offset: 0x2f90
// Size: 0x94
function function_3d0b0628(mod, hit_location, var_8a2b6fe5, player, amount, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel) {
    if (isdefined(self.animname) && self.animname == "astro_zombie") {
        return true;
    }
    return false;
}

// Namespace namespace_c0afbdaf
// Params 0, eflags: 0x0
// namespace_c0afbdaf<file_0>::function_f1d8fe46
// Checksum 0xfac80027, Offset: 0x3030
// Size: 0x46
function function_f1d8fe46() {
    self endon(#"death");
    while (true) {
        /#
            iprintln("astroTargetService" + self.health);
        #/
        wait(1);
    }
}

// Namespace namespace_c0afbdaf
// Params 1, eflags: 0x1 linked
// namespace_c0afbdaf<file_0>::function_9c51dcdd
// Checksum 0xe3b652e1, Offset: 0x3080
// Size: 0x3c
function function_9c51dcdd(str) {
    /#
        if (isdefined(level.var_609027b6) && level.var_609027b6) {
            iprintln(str);
        }
    #/
}

