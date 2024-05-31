#using scripts/cp/cp_mi_sing_vengeance_sound;
#using scripts/cp/cp_mi_sing_vengeance_accolades;
#using scripts/cp/cp_mi_sing_vengeance_util;
#using scripts/shared/exploder_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/ai/archetype_warlord_interface;
#using scripts/cp/gametypes/_save;
#using scripts/shared/animation_shared;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/ai_sniper_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/stealth;
#using scripts/shared/stealth_vo;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth_status;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_628b256b;

// Namespace namespace_628b256b
// Params 2, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_80032d7e
// Checksum 0xfb15e3dc, Offset: 0x13e0
// Size: 0x13c
function function_80032d7e(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_63b4601c::function_b87f9c13(str_objective, var_74cd64bc);
        callback::on_spawned(&namespace_63b4601c::give_hero_weapon);
        namespace_63b4601c::function_66773296("hendricks", str_objective);
        level thread namespace_63b4601c::function_cc6f3598();
        level thread namespace_63b4601c::function_3f34106b();
        level thread namespace_9fd035::function_dad71f51();
        load::function_a2995f22();
        objectives::set("cp_level_vengeance_rescue_kane");
        objectives::set("cp_level_vengeance_go_to_safehouse");
        objectives::hide("cp_level_vengeance_go_to_safehouse");
    }
    function_88933a86(str_objective);
}

// Namespace namespace_628b256b
// Params 1, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_88933a86
// Checksum 0x245311a1, Offset: 0x1528
// Size: 0x802
function function_88933a86(str_objective) {
    stealth::reset();
    level.var_67e1f60e[level.var_67e1f60e.size] = &function_591ead63;
    level flag::set("temple_begin");
    setdvar("scr_security_breach_lose_contact_distance", 36000);
    setdvar("scr_security_breach_lost_contact_distance", 72000);
    level thread namespace_523da15d::function_a6fadcaa();
    level thread function_899bbe30();
    level.var_2fd26037 thread function_a0ef55a8();
    spawner::add_spawn_function_group("temple_ambient_civilian", "script_noteworthy", &function_8e6475bd);
    level thread function_47dc557f();
    level thread function_a86ac59d();
    level thread function_7ee71c12();
    namespace_63b4601c::function_e00864bd("office_umbra_gate", 0, "office_gate");
    level.var_216db1b0 = spawner::simple_spawn("temple_patroller_spawners", &function_e8f0e2bd);
    level thread function_f8f4e73e();
    level thread namespace_63b4601c::function_e3420328("temple_ambient_anims", "dogleg_2_at_end");
    level thread scene::play("cin_ven_05_20_pond_floaters_vign");
    spawner::add_spawn_function_group("drowncivilian_enemy", "targetname", &function_558af5fd, undefined, "cin_ven_05_22_drowncivilian_civdeath_vign", "cin_ven_05_22_drowncivilian_enemyreact_vign", undefined);
    level thread scene::play("cin_ven_05_22_drowncivilian_vign");
    spawner::add_spawn_function_group("rocksmash_enemy", "targetname", &function_558af5fd, undefined, "cin_ven_05_21_rocksmash_civdeath_vign", "cin_ven_05_21_rocksmash_enemyreact_vign", "rocksmash_boulder");
    var_6a07eb6c = [];
    var_6a07eb6c[0] = "rocksmash_civilian";
    scene::add_scene_func("cin_ven_05_21_rocksmash_vign", &namespace_63b4601c::function_65a61b78, "play", var_6a07eb6c);
    level thread scene::play("cin_ven_05_21_rocksmash_vign");
    spawner::add_spawn_function_group("slicendice_enemy", "targetname", &function_558af5fd, undefined, "cin_ven_05_23_slicendice_civdeath_vign", undefined, "slicendice_machete");
    var_6a07eb6c = [];
    var_6a07eb6c[0] = "slicendice_civilian";
    scene::add_scene_func("cin_ven_05_23_slicendice_vign", &namespace_63b4601c::function_65a61b78, "play", var_6a07eb6c);
    level thread scene::play("cin_ven_05_23_slicendice_vign");
    spawner::add_spawn_function_group("beatdown_enemy", "targetname", &function_558af5fd, undefined, "cin_ven_05_26_beatdown_civdeath_vign", undefined, undefined);
    level thread scene::play("cin_ven_05_26_beatdown_vign");
    spawner::add_spawn_function_group("execution_lineup_enemy", "targetname", &function_558af5fd, undefined, "cin_ven_05_24_execution_lineup_civdeath_vign", undefined, undefined);
    level thread scene::play("cin_ven_05_24_execution_lineup_vign");
    spawner::add_spawn_function_group("ammorestock_en3", "targetname", &function_558af5fd, undefined, undefined, "cin_ven_05_27_ammorestock_enemyreact_vign", undefined);
    level thread scene::play("cin_ven_05_27_ammorestock_vign");
    spawner::add_spawn_function_group("grassstomp_enemy", "targetname", &function_558af5fd, undefined, "cin_ven_05_28_grassstomp_civdeath_vign", undefined, undefined);
    level thread scene::play("cin_ven_05_28_grassstomp_vign");
    spawner::add_spawn_function_group("railbeatdown_enemy", "targetname", &function_558af5fd, undefined, "cin_ven_05_29_rail_beatdown_civdeath_vign", "cin_ven_05_29_rail_beatdown_enemyreact_vign", undefined);
    var_6a07eb6c = [];
    var_6a07eb6c[0] = "railbeatdown_civ";
    scene::add_scene_func("cin_ven_05_29_rail_beatdown_vign", &namespace_63b4601c::function_65a61b78, "play", var_6a07eb6c);
    level thread scene::play("cin_ven_05_29_rail_beatdown_vign");
    spawner::add_spawn_function_group("wallbeatdown_enemy1", "targetname", &function_558af5fd, undefined, "cin_ven_05_32_wall_beatdown_civdeath_vign", "cin_ven_05_32_wall_beatdown_enemyreact_vign", undefined);
    level thread scene::play("cin_ven_05_32_wall_beatdown_vign");
    level thread function_ea758541("temple_rooftop_sniper_trigger", "targetname");
    triggers = getentarray("temple_stealth_checkpoint_trigger", "targetname");
    foreach (trigger in triggers) {
        trigger thread namespace_63b4601c::function_f9c94344();
    }
    level thread function_68be9dc2();
    clips = getentarray("temple_spawn_closet_door_pathing_clip", "targetname");
    foreach (clip in clips) {
        clip disconnectpaths();
    }
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_68be9dc2
// Checksum 0x77a65954, Offset: 0x1d38
// Size: 0x260
function function_68be9dc2() {
    wait(0.25);
    var_dd48cfe3 = [];
    var_dd48cfe3[var_dd48cfe3.size] = "drowncivilian_civilian";
    var_dd48cfe3[var_dd48cfe3.size] = "rocksmash_civilian";
    var_dd48cfe3[var_dd48cfe3.size] = "slicendice_civilian";
    var_dd48cfe3[var_dd48cfe3.size] = "beatdown_civilian";
    var_dd48cfe3[var_dd48cfe3.size] = "execution_lineup_civ1";
    var_dd48cfe3[var_dd48cfe3.size] = "execution_lineup_civ2";
    var_dd48cfe3[var_dd48cfe3.size] = "execution_lineup_civ3";
    var_dd48cfe3[var_dd48cfe3.size] = "execution_lineup_civ4";
    var_dd48cfe3[var_dd48cfe3.size] = "execution_lineup_civ5";
    var_dd48cfe3[var_dd48cfe3.size] = "execution_lineup_civ6";
    var_dd48cfe3[var_dd48cfe3.size] = "temple_butcher_civilian";
    var_dd48cfe3[var_dd48cfe3.size] = "gateroughup_civilian";
    var_dd48cfe3[var_dd48cfe3.size] = "grassstomp_civ";
    var_dd48cfe3[var_dd48cfe3.size] = "railbeatdown_civ";
    var_dd48cfe3[var_dd48cfe3.size] = "wallbeatdown_civilian";
    foreach (var_aca1a7c8 in var_dd48cfe3) {
        var_ad10cf41 = getentarray(var_aca1a7c8, "targetname");
        foreach (civ in var_ad10cf41) {
            civ thread namespace_63b4601c::function_f832e2fa();
        }
    }
}

// Namespace namespace_628b256b
// Params 4, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_558af5fd
// Checksum 0xa50a4b90, Offset: 0x1fa0
// Size: 0x1dc
function function_558af5fd(var_7131db57, var_1f486a3b, var_90fb7f8f, drop_object) {
    self endon(#"death");
    if (isdefined(var_7131db57)) {
        self namespace_234a4910::function_4970c8b8(var_7131db57);
    }
    self thread function_c2627018(var_1f486a3b, drop_object);
    self util::waittill_any("alert", "damage");
    if (isdefined(self.script_aigroup)) {
        group = getaiarray(self.script_aigroup, "script_aigroup");
        foreach (guy in group) {
            if (isalive(guy) && guy != self) {
                guy notify(#"alert", "combat");
            }
        }
    }
    if (isdefined(drop_object)) {
        level thread function_54c1902c(drop_object);
    }
    if (isdefined(var_90fb7f8f)) {
        self stopanimscripted();
        level thread scene::play(var_90fb7f8f);
    }
}

// Namespace namespace_628b256b
// Params 2, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_c2627018
// Checksum 0x4b290fd7, Offset: 0x2188
// Size: 0x84
function function_c2627018(var_1f486a3b, drop_object) {
    self util::waittill_any("death", "alert", "damage");
    if (isdefined(drop_object)) {
        level thread function_54c1902c(drop_object);
    }
    if (isdefined(var_1f486a3b)) {
        level thread scene::play(var_1f486a3b);
    }
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x0
// namespace_628b256b<file_0>::function_e0d6af75
// Checksum 0x594bfdea, Offset: 0x2218
// Size: 0x114
function function_e0d6af75() {
    self endon(#"death");
    self ai::set_ignoreme(1);
    self thread function_64cea510();
    self util::waittill_any("alert", "fake_alert");
    self animation::fire_weapon();
    self stopanimscripted();
    civ = getent("gunpoint_civilian_ai", "targetname");
    if (isdefined(civ) && isalive(civ)) {
        civ notify(#"fake_death");
    }
    wait(0.1);
    self ai::set_ignoreme(0);
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_64cea510
// Checksum 0xc8542168, Offset: 0x2338
// Size: 0x148
function function_64cea510() {
    self waittill(#"death");
    civ = getent("gunpoint_civilian_ai", "targetname");
    if (isdefined(civ) && isalive(civ)) {
        civ notify(#"fake_death");
    }
    if (isdefined(self)) {
        start_origin = self gettagorigin("tag_flash");
        if (isdefined(start_origin)) {
            end_origin = start_origin + anglestoforward(self gettagangles("tag_flash")) * 120;
            if (isdefined(start_origin) && isdefined(end_origin)) {
                shot = magicbullet(getweapon("shotgun_pump"), start_origin, end_origin);
            }
        }
    }
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x0
// namespace_628b256b<file_0>::function_bddcb39c
// Checksum 0xab435ee5, Offset: 0x2488
// Size: 0x17c
function function_bddcb39c() {
    self endon(#"death");
    self.team = "allies";
    self.civilian = 1;
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    self ai::set_behavior_attribute("panic", 0);
    self.health = 1;
    self util::waittill_any("damage", "alert", "fake_death");
    guy = getent("gunpoint_enemy_ai", "targetname");
    if (isdefined(guy) && isalive(guy)) {
        guy notify(#"hash_da6a4775");
    }
    if (isdefined(self.magic_bullet_shield)) {
        util::stop_magic_bullet_shield(self);
    }
    self.takedamage = 1;
    self.allowdeath = 1;
    self kill();
    self startragdoll();
}

// Namespace namespace_628b256b
// Params 1, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_54c1902c
// Checksum 0x9e622472, Offset: 0x2610
// Size: 0x8c
function function_54c1902c(e_obj) {
    if (isdefined(e_obj)) {
        e_obj = getent(e_obj, "targetname");
        if (isdefined(e_obj)) {
            e_obj stopanimscripted();
            e_obj physicslaunch(e_obj.origin, (0, 0, 0.1));
        }
    }
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_8e6475bd
// Checksum 0x5b05475d, Offset: 0x26a8
// Size: 0x88
function function_8e6475bd() {
    self endon(#"death");
    self.team = "allies";
    self.civilian = 1;
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    self ai::set_behavior_attribute("panic", 0);
    self.health = 1;
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_e8f0e2bd
// Checksum 0xe6499894, Offset: 0x2738
// Size: 0x54
function function_e8f0e2bd() {
    self thread namespace_63b4601c::function_b62b56ba();
    self playloopsound("amb_patrol_walla");
    self thread ai_sniper::agent_init();
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_47dc557f
// Checksum 0x8bf68457, Offset: 0x2798
// Size: 0x34
function function_47dc557f() {
    level.var_47dc557f = spawner::simple_spawn("temple_wasps", &function_a044ee0);
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_a044ee0
// Checksum 0x5f66f194, Offset: 0x27d8
// Size: 0x7c
function function_a044ee0() {
    var_850a4b14 = getent("temple_wasp_gv", "targetname");
    if (isdefined(var_850a4b14)) {
        self clearforcedgoal();
        self cleargoalvolume();
        self setgoal(var_850a4b14);
    }
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_a0ef55a8
// Checksum 0x56ceed60, Offset: 0x2860
// Size: 0x164
function function_a0ef55a8() {
    level endon(#"hash_8a3b89d3");
    self endon(#"death");
    self thread function_f6b53854();
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self colors::disable();
    self ai::set_behavior_attribute("cqb", 1);
    self.holdfire = 1;
    self battlechatter::function_d9f49fba(0);
    level scene::play("cin_ven_05_10_templearrival_vign");
    self.disablearrivals = 1;
    self.disableexits = 1;
    node = getnode("temple_hendricks_node_05", "targetname");
    self setgoal(node, 1);
    level notify(#"hash_899bbe30");
    wait(1);
    self.disablearrivals = 0;
    self.disableexits = 0;
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_f6b53854
// Checksum 0xe855e725, Offset: 0x29d0
// Size: 0x2d4
function function_f6b53854() {
    level flag::wait_till("stealth_discovered");
    level flag::set("temple_stealth_broken");
    self.disablearrivals = 0;
    self.disableexits = 0;
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
    self.fixednode = 0;
    self clearforcedgoal();
    self ai::set_behavior_attribute("cqb", 0);
    self.holdfire = 0;
    self.var_df53bc6 = self.script_accuracy;
    self.script_accuracy = 0.1;
    objectives::set("cp_level_vengeance_support", self);
    self thread namespace_63b4601c::function_5a886ae0();
    level flag::wait_till_clear("stealth_discovered");
    self notify(#"hash_90a20e6d");
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self.holdfire = 1;
    self battlechatter::function_d9f49fba(0);
    self.script_accuracy = self.var_df53bc6;
    self clearforcedgoal();
    self cleargoalvolume();
    self colors::disable();
    var_d7b9ba9b = getnode("temple_end_hendricks_node", "targetname");
    self.forcegoal = 1;
    self.fixednode = 1;
    self.goalradius = 32;
    self setgoalnode(var_d7b9ba9b, 1);
    level flag::clear("stealth_combat");
    self waittill(#"goal");
    self.forcegoal = 0;
    self.fixednode = 0;
    level flag::set("temple_hendricks_done");
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x0
// namespace_628b256b<file_0>::function_4002969a
// Checksum 0xa6d4bac4, Offset: 0x2cb0
// Size: 0x19c
function function_4002969a() {
    level flag::wait_till("all_players_at_temple_exit");
    if (!level flag::get("hendricks_near_dogleg_2")) {
        nodes = getnodearray("hendricks_temple_end_teleport_node", "targetname");
        node = arraygetclosest(level.var_2fd26037.origin, nodes);
        var_e52b590a = 0.75;
        if (namespace_63b4601c::any_player_looking_at(level.var_2fd26037.origin + (0, 0, 48), var_e52b590a, 1)) {
            level.var_2fd26037 forceteleport(node.origin, node.angles);
            wait(0.1);
            var_d7b9ba9b = getnode("temple_end_hendricks_node", "targetname");
            self.forcegoal = 1;
            self.fixednode = 1;
            self.goalradius = 32;
            self setgoalnode(var_d7b9ba9b, 1);
        }
    }
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_578145a3
// Checksum 0xcbe0d6da, Offset: 0x2e58
// Size: 0xbbc
function function_578145a3() {
    var_1044cded = 0;
    i = 3;
    for (i = 3; i >= 2; i--) {
        var_26b3981a = getent("temple_axis_gv_0" + i, "targetname");
        var_42cc32ad = function_f1c7b73f(var_26b3981a);
        if (isdefined(var_42cc32ad) && var_42cc32ad) {
            var_1044cded = 1;
            break;
        }
    }
    var_17994622 = getaiteamarray("axis");
    if (isdefined(var_1044cded) && var_1044cded) {
        ally_volume = getent("temple_ally_gv_0" + i, "targetname");
        var_a2d2b3b = getent("temple_axis_gv_0" + i, "targetname");
        var_fcf2483c = getent("temple_axis_cleanup_volume_0" + i, "targetname");
        level thread function_620fbb8a(var_17994622, var_fcf2483c);
    } else {
        ally_volume = getent("temple_ally_gv_01", "targetname");
        var_a2d2b3b = getent("temple_axis_gv_01", "targetname");
    }
    foreach (guy in var_17994622) {
        if (isalive(guy)) {
            guy clearforcedgoal();
            guy cleargoalvolume();
            guy setgoal(var_a2d2b3b);
        }
    }
    if (isdefined(var_1044cded) && var_1044cded) {
        nodes = getnodearray("hendircks_forced_advance_0" + i, "targetname");
        node = array::random(nodes);
        level.var_2fd26037 forceteleport(node.origin, node.angles);
        wait(0.1);
    }
    level.var_2fd26037 clearforcedgoal();
    level.var_2fd26037 cleargoalvolume();
    level.var_2fd26037 setgoal(ally_volume);
    ally_volume = getent("temple_ally_gv_02", "targetname");
    var_a2d2b3b = getent("temple_axis_gv_02", "targetname");
    while (true) {
        if (isdefined(var_1044cded) && var_1044cded && i >= 2) {
            break;
        }
        var_457b0e7 = getaiteamarray("axis");
        if (isdefined(var_457b0e7) && var_457b0e7.size <= var_17994622.size * 0.8) {
            foreach (guy in var_457b0e7) {
                if (isalive(guy)) {
                    guy clearforcedgoal();
                    guy cleargoalvolume();
                    guy setgoal(var_a2d2b3b);
                }
            }
            level.var_2fd26037 clearforcedgoal();
            level.var_2fd26037 cleargoalvolume();
            level.var_2fd26037 setgoal(ally_volume);
            break;
        }
        wait(0.1);
    }
    ally_volume = getent("temple_ally_gv_03", "targetname");
    var_a2d2b3b = getent("temple_axis_gv_03", "targetname");
    while (true) {
        if (isdefined(var_1044cded) && var_1044cded && i >= 3) {
            break;
        }
        var_457b0e7 = getaiteamarray("axis");
        if (isdefined(var_457b0e7) && var_457b0e7.size <= var_17994622.size * 0.6) {
            foreach (guy in var_457b0e7) {
                if (isalive(guy)) {
                    guy clearforcedgoal();
                    guy cleargoalvolume();
                    guy setgoal(var_a2d2b3b);
                }
            }
            level.var_2fd26037 clearforcedgoal();
            level.var_2fd26037 cleargoalvolume();
            level.var_2fd26037 setgoal(ally_volume);
            break;
        }
        wait(0.1);
    }
    ally_volume = getent("temple_ally_gv_04", "targetname");
    var_a2d2b3b = getent("temple_axis_gv_04", "targetname");
    while (true) {
        var_457b0e7 = getaiteamarray("axis");
        if (isdefined(var_457b0e7) && var_457b0e7.size <= var_17994622.size * 0.4) {
            foreach (guy in var_457b0e7) {
                if (isalive(guy)) {
                    guy clearforcedgoal();
                    guy cleargoalvolume();
                    guy setgoal(var_a2d2b3b);
                }
            }
            level.var_2fd26037 clearforcedgoal();
            level.var_2fd26037 cleargoalvolume();
            level.var_2fd26037 setgoal(ally_volume);
            break;
        }
        wait(0.1);
    }
    while (true) {
        var_457b0e7 = getaiteamarray("axis");
        if (isdefined(var_457b0e7) && var_457b0e7.size <= var_17994622.size * 0.2) {
            foreach (guy in var_457b0e7) {
                if (isdefined(guy) && isalive(guy)) {
                    if (isvehicle(guy)) {
                        var_c1cd872a = struct::get_array("temple_wasp_retreat_nodes", "targetname");
                        node = array::random(var_c1cd872a);
                        guy thread namespace_63b4601c::function_3d5f97bd(node);
                    }
                    node = getnodearraysorted("temple_retreat_nodes", "targetname", guy.origin, 4096);
                    if (isdefined(node[0])) {
                        if (guy ai::has_behavior_attribute("sprint")) {
                            guy ai::set_behavior_attribute("sprint", 1);
                        }
                        guy thread namespace_63b4601c::function_3d5f97bd(node[0]);
                        continue;
                    }
                    a_ai = array(guy);
                    level thread namespace_63b4601c::function_ff5f379(a_ai, 1024);
                }
            }
            level flag::set("combat_enemies_retreating");
            level flag::set("disable_temple_robot_triggers");
            break;
        }
        wait(0.1);
    }
}

// Namespace namespace_628b256b
// Params 1, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_f1c7b73f
// Checksum 0x4cea7c11, Offset: 0x3a20
// Size: 0xac
function function_f1c7b73f(trigger) {
    foreach (player in getplayers()) {
        if (!player istouching(trigger)) {
            return false;
        }
    }
    return true;
}

// Namespace namespace_628b256b
// Params 2, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_620fbb8a
// Checksum 0xeaa41b3d, Offset: 0x3ad8
// Size: 0x14c
function function_620fbb8a(var_7cd99f10, e_volume) {
    a_ai = [];
    foreach (ai in var_7cd99f10) {
        if (isdefined(ai) && isalive(ai) && ai istouching(e_volume)) {
            if (!isdefined(a_ai)) {
                a_ai = [];
            } else if (!isarray(a_ai)) {
                a_ai = array(a_ai);
            }
            a_ai[a_ai.size] = ai;
        }
    }
    level thread namespace_63b4601c::function_ff5f379(a_ai, 512);
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_899bbe30
// Checksum 0x89177b15, Offset: 0x3c30
// Size: 0x17c
function function_899bbe30() {
    level endon(#"hash_8a3b89d3");
    level.var_2fd26037 endon(#"death");
    level waittill(#"hash_899bbe30");
    foreach (player in level.activeplayers) {
        player thread namespace_63b4601c::function_51caee84("temple_end");
    }
    level flag::set("show_temple_gather");
    stealth::function_26f24c93(1);
    flag::wait_till("tmeple_stealth_motivator_01");
    namespace_63b4601c::function_ee75acde("hend_stick_to_the_shadows_0");
    flag::wait_till("tmeple_stealth_motivator_02");
    namespace_63b4601c::function_ee75acde("hend_lots_of_movement_dow_1");
    flag::wait_till("tmeple_stealth_motivator_03");
    namespace_63b4601c::function_ee75acde("hend_keep_moving_they_ha_0");
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_a86ac59d
// Checksum 0x46002196, Offset: 0x3db8
// Size: 0x1fc
function function_a86ac59d() {
    level endon(#"hash_29964e40");
    level flag::wait_till("stealth_discovered");
    array::thread_all(getaiteamarray("axis"), &function_329c89f);
    level thread namespace_63b4601c::function_e6399870("temple_molotov_trigger", "script_noteworthy", 2);
    level flag::set("enable_temple_robot_triggers");
    var_b264f09 = getentarray("temple_robot_trigger", "targetname");
    array::thread_all(var_b264f09, &function_dd797045);
    stealth::function_26f24c93(0);
    level thread namespace_63b4601c::function_80840124(&function_e4612dd6);
    level thread function_578145a3();
    while (true) {
        guys = getaiteamarray("axis");
        if (isdefined(guys) && guys.size <= 0 || !isdefined(guys)) {
            break;
        }
        wait(0.1);
    }
    objectives::complete("cp_level_vengeance_support", level.var_2fd26037);
    level flag::clear("stealth_discovered");
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_329c89f
// Checksum 0x838fbe86, Offset: 0x3fc0
// Size: 0x1c
function function_329c89f() {
    self stopsounds();
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_dd797045
// Checksum 0x48d27cae, Offset: 0x3fe8
// Size: 0x5e4
function function_dd797045() {
    level endon(#"hash_29964e40");
    level endon(#"hash_fecd096c");
    self endon(#"death");
    while (true) {
        self waittill(#"trigger");
        guys = getaiteamarray("axis");
        guys = array::remove_dead(guys);
        if (guys.size > 37) {
            wait(2);
            continue;
        }
        volume = getent(self.target + "_volume", "targetname");
        if (isdefined(volume)) {
            robots = getentarray(self.target, "targetname");
            foreach (robot in robots) {
                robot.ignoreall = 1;
                robot.ignoreme = 1;
            }
            doors = getentarray("temple_spawn_closet_door", "targetname");
            foreach (door in doors) {
                var_6c37ffe1 = self.target + "_closet";
                if (isdefined(door.script_noteworthy) && door.script_noteworthy == var_6c37ffe1) {
                    var_8b006810 = door;
                    break;
                }
            }
            var_d17d5da5 = getentarray("temple_spawn_closet_door_clip", "targetname");
            foreach (clip in var_d17d5da5) {
                var_35f2b287 = self.target + "_closet";
                if (isdefined(clip.script_noteworthy) && clip.script_noteworthy == var_35f2b287) {
                    var_17c44fc9 = clip;
                    break;
                }
            }
            var_6e15ff70 = getentarray("temple_spawn_closet_door_pathing_clip", "targetname");
            foreach (clip in var_6e15ff70) {
                var_35f2b287 = self.target + "_closet";
                if (isdefined(clip.script_noteworthy) && clip.script_noteworthy == var_35f2b287) {
                    var_3cdd15e3 = clip;
                    break;
                }
            }
            if (isdefined(var_8b006810) && isdefined(var_17c44fc9)) {
                var_17c44fc9 linkto(var_8b006810);
            }
            if (isdefined(var_8b006810)) {
                var_8b006810 rotateto(var_8b006810.angles + (0, 90, 0), 1);
            }
            wait(0.5);
            if (isdefined(var_3cdd15e3)) {
                var_3cdd15e3 notsolid();
                wait(0.05);
                var_3cdd15e3 connectpaths();
            }
            foreach (robot in robots) {
                if (isalive(robot)) {
                    robot.ignoreall = 0;
                    robot.ignoreme = 0;
                }
            }
            self triggerenable(0);
            break;
        }
    }
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_e4612dd6
// Checksum 0xd6c6271c, Offset: 0x45d8
// Size: 0xec
function function_e4612dd6() {
    level endon(#"hash_29964e40");
    level.var_2fd26037 battlechatter::function_d9f49fba(0);
    var_eb6e35ef = [];
    var_eb6e35ef[0] = "hend_shifting_positions_0";
    var_eb6e35ef[1] = "hend_i_m_dropping_down_to_0";
    line = array::random(var_eb6e35ef);
    namespace_63b4601c::function_ee75acde(line);
    namespace_63b4601c::function_ee75acde("hend_if_we_can_clear_the_0", 4);
    level thread namespace_9fd035::function_14592f48();
    level.var_2fd26037 battlechatter::function_d9f49fba(1);
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x0
// namespace_628b256b<file_0>::function_1a289333
// Checksum 0x99ec1590, Offset: 0x46d0
// Size: 0x4
function function_1a289333() {
    
}

// Namespace namespace_628b256b
// Params 4, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_299dec58
// Checksum 0x911f34c1, Offset: 0x46e0
// Size: 0x84
function function_299dec58(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level flag::set("temple_end");
    level thread function_c5b8e111();
    level struct::function_368120a1("scene", "cin_ven_hanging_body_loop_vign_civ07_ropeshort");
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_c5b8e111
// Checksum 0x8f9585a2, Offset: 0x4770
// Size: 0x152
function function_c5b8e111() {
    if (isdefined(level.var_216db1b0)) {
        foreach (enemy in level.var_216db1b0) {
            if (isdefined(enemy)) {
                enemy namespace_8312dbf::function_180adb28();
                enemy delete();
            }
        }
    }
    if (isdefined(level.var_47dc557f)) {
        foreach (enemy in level.var_47dc557f) {
            if (isdefined(enemy)) {
                enemy delete();
            }
        }
    }
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_7ee71c12
// Checksum 0xd0a187dc, Offset: 0x48d0
// Size: 0x54
function function_7ee71c12() {
    var_3f199d98 = getentarray("breakable_garden_window", "targetname");
    array::thread_all(var_3f199d98, &function_f1d8ca4c);
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_f1d8ca4c
// Checksum 0x87033ebd, Offset: 0x4930
// Size: 0xbc
function function_f1d8ca4c() {
    self setcandamage(1);
    self.health = 10;
    while (true) {
        damage, attacker = self waittill(#"damage");
        if (isdefined(attacker) && isplayer(attacker) && isdefined(damage)) {
            self.health -= damage;
            if (self.health <= 0) {
                self delete();
                break;
            }
        }
    }
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_f8f4e73e
// Checksum 0xa384a0fe, Offset: 0x49f8
// Size: 0x30c
function function_f8f4e73e() {
    var_cd0466c3 = struct::get("dogleg_2_intro_obj_struct");
    if (isdefined(var_cd0466c3)) {
        objectives::set("cp_level_vengeance_goto_dogleg_2", var_cd0466c3);
    }
    objectives::hide("cp_level_vengeance_goto_dogleg_2");
    level flag::wait_till_any(array("show_temple_gather", "stealth_discovered"));
    objectives::show("cp_level_vengeance_goto_dogleg_2");
    var_f8f4e73e = getent("dogleg_2_intro_trigger", "script_noteworthy");
    if (isdefined(var_f8f4e73e)) {
        level thread namespace_63b4601c::function_8a63fd6b(var_f8f4e73e, "cp_level_vengeance_goto_dogleg_2", undefined, "all_players_at_temple_exit", "cp_level_vengeance_clear_area");
    }
    level flag::wait_till("all_players_at_temple_exit");
    objectives::hide("cp_level_vengeance_goto_dogleg_2");
    if (level flag::get("temple_stealth_broken")) {
        level flag::wait_till("temple_hendricks_done");
    }
    level.var_2fd26037 thread namespace_63b4601c::function_5fbec645("hend_open_it_up_i_ll_cov_0");
    level thread function_cf782b84();
    var_70f21d83 = struct::get("tag_align_dogleg_2", "targetname");
    var_70f21d83 thread scene::play("cin_ven_05_65_deadcivilians_vign");
    n_node = getnode("hendricks_dogleg_2_stairs", "targetname");
    level waittill(#"hash_ad75a4f1");
    level thread function_29e96a35();
    if (level flag::get("temple_stealth_broken")) {
        level waittill(#"hash_9fb1ff75");
        level.var_2fd26037 setgoal(n_node, 1);
    } else {
        wait(1.5);
        level thread function_37d4d605();
        var_70f21d83 scene::init("cin_ven_05_70_dogleg2_takedown_vign");
    }
    level flag::set("dogleg_2_begin");
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_29e96a35
// Checksum 0xcdd34a40, Offset: 0x4d10
// Size: 0xd4
function function_29e96a35() {
    level.var_2fd26037 notify(#"hash_6f33cd57");
    level.var_2fd26037.var_5d9fbd2d = 0;
    if (level flag::get("temple_stealth_broken")) {
        level waittill(#"hash_9fb1ff75");
        level.var_2fd26037 dialog::say("hend_you_sure_you_don_t_w_0");
    } else {
        level waittill(#"hash_132639c7");
        level.var_2fd26037 dialog::say("hend_you_sure_you_don_t_w_0", 1);
    }
    level dialog::function_13b3b16a("plyr_not_a_chance_hendri_0");
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_38bcd0
// Checksum 0x34c60f6d, Offset: 0x4df0
// Size: 0x174
function function_38bcd0() {
    e_trigger = getent("dogleg_2_door_entry_trigger", "targetname");
    e_trigger triggerenable(0);
    var_71678477 = getent("dogleg_2_entry_door_lf", "targetname");
    var_1d746940 = getent(var_71678477.target, "targetname");
    var_1d746940 disconnectpaths();
    var_b8e4988b = getent("dogleg_2_entry_door_rt", "targetname");
    var_4a669fbc = getent(var_b8e4988b.target, "targetname");
    var_4a669fbc disconnectpaths();
    var_35a1e4f8 = struct::get("tag_align_dogleg_2_door", "targetname");
    var_35a1e4f8 thread scene::init("cin_ven_05_60_officedoor_1st");
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_cf782b84
// Checksum 0xda8c4721, Offset: 0x4f70
// Size: 0x39c
function function_cf782b84() {
    e_trigger = getent("dogleg_2_door_entry_trigger", "targetname");
    e_trigger triggerenable(1);
    var_ca0e9b65 = util::function_14518e76(e_trigger, %cp_prompt_enter_ven_doors, %CP_MI_SING_VENGEANCE_HINT_OPEN, &function_863781f2);
    objectives::set("cp_level_vengeance_open_dogleg_2_menu");
    level notify(#"hash_479fadce");
    var_71678477 = getent("dogleg_2_entry_door_lf", "targetname");
    var_1d746940 = getent(var_71678477.target, "targetname");
    var_71678477.animname = "dogleg_2_entry_door_lf";
    var_71678477.old_angles = var_71678477.angles;
    var_71678477.old_origin = var_71678477.origin;
    var_b8e4988b = getent("dogleg_2_entry_door_rt", "targetname");
    var_4a669fbc = getent(var_b8e4988b.target, "targetname");
    var_b8e4988b.animname = "dogleg_2_entry_door_rt";
    var_b8e4988b.old_angles = var_b8e4988b.angles;
    var_b8e4988b.old_origin = var_b8e4988b.origin;
    var_1d746940 linkto(var_71678477);
    var_4a669fbc linkto(var_b8e4988b);
    level thread namespace_63b4601c::function_8a63fd6b(e_trigger, undefined, "cp_level_vengeance_open_dogleg_2_menu", "dogleg_2_entry_door_opening", "cp_level_vengeance_clear_area", var_ca0e9b65);
    level waittill(#"hash_ad75a4f1");
    var_ca0e9b65 gameobjects::disable_object();
    objectives::hide("cp_level_vengeance_open_dogleg_2_menu");
    level waittill(#"hash_c4bb0520");
    if (!level flag::get("temple_stealth_broken")) {
        var_71678477 stopanimscripted();
        var_71678477.angles = var_71678477.old_angles;
        var_71678477.origin = var_71678477.old_origin;
        var_b8e4988b stopanimscripted();
        var_b8e4988b.angles = var_b8e4988b.old_angles;
        var_b8e4988b.origin = var_b8e4988b.old_origin;
        return;
    }
    var_1d746940 connectpaths();
    var_4a669fbc connectpaths();
}

// Namespace namespace_628b256b
// Params 1, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_863781f2
// Checksum 0x48d0f0a2, Offset: 0x5318
// Size: 0x19e
function function_863781f2(e_player) {
    level.var_67e1f60e = undefined;
    foreach (player in level.activeplayers) {
        if (isdefined(player.var_b9e5210f)) {
            player.var_b9e5210f = undefined;
        }
    }
    skipto::function_be8adfb8("temple");
    var_35a1e4f8 = struct::get("tag_align_dogleg_2_door", "targetname");
    if (level flag::get("temple_stealth_broken")) {
        var_35a1e4f8 thread scene::play("cin_ven_05_60_officedoor_1st", e_player);
    } else {
        namespace_63b4601c::function_ac2b4535("cin_ven_05_60_officedoor_1st_shared", "dogleg_2_entrance_teleport");
        var_35a1e4f8 thread scene::play("cin_ven_05_60_officedoor_1st_shared", e_player);
    }
    level notify(#"hash_ad75a4f1");
    var_35a1e4f8 waittill(#"scene_done");
    level notify(#"hash_9fb1ff75");
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_37d4d605
// Checksum 0x4010ae1e, Offset: 0x54c0
// Size: 0xf2
function function_37d4d605() {
    level waittill(#"hash_132639c7");
    var_c13b7e2a = struct::get_array("dogleg_2_glass_break", "targetname");
    exploder::exploder("dogleg_2_railing_break");
    foreach (var_d64f5bac in var_c13b7e2a) {
        glassradiusdamage(var_d64f5bac.origin, 38, -56, -81);
    }
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x0
// namespace_628b256b<file_0>::function_ca660ef7
// Checksum 0xa0bdf0ba, Offset: 0x55c0
// Size: 0x102
function function_ca660ef7() {
    self endon(#"death");
    level flag::wait_till("stealth_discovered");
    self.goalheight = 512;
    var_eaf20b66 = getnodearray(self.script_noteworthy, "targetname");
    foreach (node in var_eaf20b66) {
        self namespace_69ee7109::function_da308a83(node.origin, 4000, 8000);
    }
}

// Namespace namespace_628b256b
// Params 2, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_ea758541
// Checksum 0x2215acf5, Offset: 0x56d0
// Size: 0x5c
function function_ea758541(name, key) {
    var_fc0a0636 = getentarray(name, key);
    array::thread_all(var_fc0a0636, &function_8f9d056c);
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_3bb1295b
// Checksum 0x4f35c107, Offset: 0x5738
// Size: 0xf4
function function_3bb1295b() {
    guys = getaiteamarray("axis");
    guys = arraysortclosest(guys, self.origin);
    foreach (guy in guys) {
        if (isdefined(guy) && isalive(guy) && isdefined(guy.var_9eb700da)) {
            return guy;
        }
    }
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_8f9d056c
// Checksum 0xabf12506, Offset: 0x5838
// Size: 0x70
function function_8f9d056c() {
    self endon(#"death");
    level endon(#"hash_8a3b89d3");
    while (true) {
        player = self waittill(#"trigger");
        if (isplayer(player)) {
            self function_a1a65fdc(player);
        }
    }
}

// Namespace namespace_628b256b
// Params 1, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_a1a65fdc
// Checksum 0xcd132f91, Offset: 0x58b0
// Size: 0x2b8
function function_a1a65fdc(player) {
    player endon(#"hash_3f7b661c");
    if (isdefined(player.var_15f789fb) && player.var_15f789fb == self) {
        return;
    }
    var_c2918075 = gettime();
    if (isdefined(player.var_496772e9)) {
        var_c2918075 = gettime() - player.var_496772e9;
    }
    var_d3e8dab = -1;
    if (isdefined(player.var_18091778)) {
        var_d3e8dab = distancesquared(player.origin, player.var_18091778);
    }
    player.var_15f789fb = self;
    player.var_496772e9 = gettime();
    player thread function_b321fac9(self);
    if (var_c2918075 < 5000 && var_d3e8dab > 0 && var_d3e8dab > 10000) {
        if (!(isdefined(player.var_b9e5210f) && player.var_b9e5210f)) {
            var_2dd18bed = [];
            var_2dd18bed[0] = "hend_get_off_the_rooftops_0";
            var_2dd18bed[1] = "hend_stay_off_the_rooftop_0";
            var_2dd18bed[2] = "hend_they_re_going_to_spo_0";
            player thread namespace_63b4601c::function_ee75acde(array::random(var_2dd18bed), 0, undefined, player);
        }
        player.var_b9e5210f = 1;
        wait(4);
        if (isdefined(player.var_15f789fb) && !player istouching(player.var_15f789fb)) {
            player.var_b9e5210f = 0;
            return;
        }
        guy = player function_3bb1295b();
        if (isdefined(guy) && isdefined(guy.var_9eb700da)) {
            guy.var_9eb700da ai_sniper::function_b77b41d1(guy geteye(), player, guy);
        }
    }
}

// Namespace namespace_628b256b
// Params 1, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_b321fac9
// Checksum 0x68223329, Offset: 0x5b70
// Size: 0x84
function function_b321fac9(trigger) {
    self notify(#"hash_b321fac9");
    self endon(#"hash_b321fac9");
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        if (self istouching(trigger)) {
            self.var_18091778 = self.origin;
        } else {
            return;
        }
        wait(0.05);
    }
}

// Namespace namespace_628b256b
// Params 0, eflags: 0x1 linked
// namespace_628b256b<file_0>::function_591ead63
// Checksum 0x9968d547, Offset: 0x5c00
// Size: 0xa0
function function_591ead63() {
    foreach (player in level.activeplayers) {
        if (isdefined(player.var_b9e5210f) && player.var_b9e5210f) {
            return false;
        }
    }
    return true;
}

