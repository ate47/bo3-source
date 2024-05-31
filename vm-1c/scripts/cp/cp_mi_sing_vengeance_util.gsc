#using scripts/cp/cybercom/_cybercom_gadget_security_breach;
#using scripts/cp/cybercom/_cybercom;
#using scripts/shared/turret_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/ai/systems/gib;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_sniper_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/hud_message_shared;
#using scripts/cp/_dialog;
#using scripts/cp/cp_mi_sing_vengeance_sound;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicles/_hunter;
#using scripts/shared/callbacks_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/stealth;
#using scripts/shared/animation_shared;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/shared/spawner_shared;
#using scripts/cp/_util;
#using scripts/shared/exploder_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_63b4601c;

// Namespace namespace_63b4601c
// Params 0, eflags: 0x2
// namespace_63b4601c<file_0>::function_2dc19561
// Checksum 0xac6901d, Offset: 0xdc8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("enemy_highlight", &function_c7e2a7f7, undefined, undefined);
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_c7e2a7f7
// Checksum 0x5044dc4c, Offset: 0xe08
// Size: 0x34
function function_c7e2a7f7() {
    clientfield::register("toplayer", "enemy_highlight", 1, 1, "int");
}

// Namespace namespace_63b4601c
// Params 3, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_66773296
// Checksum 0x2db2fb4e, Offset: 0xe48
// Size: 0x1ec
function function_66773296(str_hero, str_objective, var_c080912a) {
    hero = undefined;
    if (str_hero == "hendricks") {
        level.var_2fd26037 = util::function_740f8516("hendricks");
        hero = level.var_2fd26037;
        level.var_2fd26037 colors::set_force_color("r");
    } else if (str_hero == "rachel") {
        level.var_7a9855f3 = util::function_740f8516("rachel");
        hero = level.var_7a9855f3;
        level.var_7a9855f3 colors::set_force_color("b");
    } else {
        assertmsg("_");
    }
    if (isdefined(var_c080912a) && var_c080912a) {
        skipto::teleport_ai(str_objective);
        return;
    }
    s_start = struct::get(str_objective + "_" + str_hero, "targetname");
    if (!isdefined(s_start)) {
        assertmsg("_" + str_hero + "_" + str_objective + "_");
    }
    hero forceteleport(s_start.origin, s_start.angles, 1);
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x0
// namespace_63b4601c<file_0>::function_693245c6
// Checksum 0x116b57b1, Offset: 0x1040
// Size: 0x26
function player_count() {
    a_players = getplayers();
    return a_players.size;
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_b62b56ba
// Checksum 0x2b8a14fc, Offset: 0x1070
// Size: 0x124
function function_b62b56ba() {
    self endon(#"death");
    if (isdefined(self.target)) {
        var_5871af4 = getnode(self.target, "targetname");
    }
    if (!isdefined(var_5871af4)) {
        nodes = getnodesinradiussorted(self.origin, 1000, 1, 1000, "Path");
    }
    if (isdefined(nodes) && nodes.size > 0) {
        var_5871af4 = nodes[0];
    }
    if (isdefined(var_5871af4)) {
        self.var_5871af4 = var_5871af4;
    } else {
        assert(!isdefined(var_5871af4), "_");
    }
    self thread ai_sniper::agent_init();
    self thread ai::patrol(self.var_5871af4);
}

// Namespace namespace_63b4601c
// Params 3, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_b87f9c13
// Checksum 0x30179662, Offset: 0x11a0
// Size: 0xc4
function function_b87f9c13(str_objective, var_74cd64bc, var_6a8d0f35) {
    if (!isdefined(var_6a8d0f35)) {
        var_6a8d0f35 = 0;
    }
    if (!isdefined(str_objective)) {
        str_objective = "";
    }
    if (!isdefined(var_74cd64bc)) {
        var_74cd64bc = 1;
    }
    if (var_74cd64bc) {
        loadsentienteventparameters("sentientevents_vengeance_default");
        stealth::init();
        namespace_7c587e3e::function_47d9d5db();
        if (var_6a8d0f35) {
            callback::on_spawned(&function_51caee84);
        }
    }
}

// Namespace namespace_63b4601c
// Params 3, eflags: 0x0
// namespace_63b4601c<file_0>::function_3f4f84e
// Checksum 0x414d7736, Offset: 0x1270
// Size: 0xfa
function function_3f4f84e(str_key, str_val, b_enable) {
    if (!isdefined(str_val)) {
        str_val = "targetname";
    }
    if (!isdefined(b_enable)) {
        b_enable = 1;
    }
    a_nodes = getnodearray(str_key, str_val);
    foreach (var_22752fde in a_nodes) {
        setenablenode(var_22752fde, b_enable);
    }
}

// Namespace namespace_63b4601c
// Params 3, eflags: 0x0
// namespace_63b4601c<file_0>::function_258b9bad
// Checksum 0x130c7b65, Offset: 0x1378
// Size: 0x9c
function function_258b9bad(var_fcc15a0, var_1086d941, var_ed2ece1e) {
    self endon(#"death");
    util::magic_bullet_shield(self);
    if (var_1086d941) {
        self thread function_968476a4(var_fcc15a0, var_ed2ece1e);
    }
    util::waittill_any_ents(level, var_fcc15a0, self, var_fcc15a0);
    util::stop_magic_bullet_shield(self);
}

// Namespace namespace_63b4601c
// Params 2, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_968476a4
// Checksum 0xf849c537, Offset: 0x1420
// Size: 0xac
function function_968476a4(var_fcc15a0, var_ed2ece1e) {
    self endon(#"hash_9b484394");
    self endon(var_fcc15a0);
    level endon(var_fcc15a0);
    while (true) {
        amount, attacker = self waittill(#"damage");
        if (isplayer(attacker)) {
            if (isdefined(var_ed2ece1e)) {
                level notify(var_ed2ece1e);
                wait(0.05);
                level notify(var_fcc15a0);
            }
            self notify(var_fcc15a0);
        }
    }
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_60ce6396
// Checksum 0xc9f818be, Offset: 0x14d8
// Size: 0x11a
function function_60ce6396() {
    level._effect["civ_burn_j_elbow_le_loop"] = "fire/fx_fire_ai_human_arm_left_loop_mature";
    level._effect["civ_burn_j_elbow_ri_loop"] = "fire/fx_fire_ai_human_arm_right_loop_mature";
    level._effect["civ_burn_j_shoulder_le_loop"] = "fire/fx_fire_ai_human_arm_left_loop_mature";
    level._effect["civ_burn_j_shoulder_ri_loop"] = "fire/fx_fire_ai_human_arm_right_loop_mature";
    level._effect["civ_burn_j_spine4_loop"] = "fire/fx_fire_ai_human_torso_loop_mature";
    level._effect["civ_burn_j_hip_le_loop"] = "fire/fx_fire_ai_human_hip_left_loop_mature";
    level._effect["civ_burn_j_hip_ri_loop"] = "fire/fx_fire_ai_human_hip_right_loop_mature";
    level._effect["civ_burn_j_knee_le_loop"] = "fire/fx_fire_ai_human_leg_left_loop_mature";
    level._effect["civ_burn_j_knee_ri_loop"] = "fire/fx_fire_ai_human_leg_right_loop_mature";
    level._effect["civ_burn_j_head_loop"] = "fire/fx_fire_ai_human_head_loop_mature";
}

// Namespace namespace_63b4601c
// Params 1, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_f6af6062
// Checksum 0xec4b2c0d, Offset: 0x1600
// Size: 0x58c
function function_f6af6062(var_a35036a6) {
    if (!isdefined(var_a35036a6)) {
        var_a35036a6 = 1;
    }
    self endon(#"death");
    playfxontag(level._effect["civ_burn_j_spine4_loop"], self, "J_Spine4");
    if (isdefined(var_a35036a6) && var_a35036a6 == 0) {
        wait(0.5);
        playfxontag(level._effect["civ_burn_j_head_loop"], self, "J_Head");
        wait(randomfloatrange(0.1, 2));
        playfxontag(level._effect["civ_burn_j_shoulder_le_loop"], self, "J_Shoulder_LE");
        playfxontag(level._effect["civ_burn_j_shoulder_ri_loop"], self, "J_Shoulder_RI");
        wait(randomfloatrange(0.1, 2));
        playfxontag(level._effect["civ_burn_j_hip_le_loop"], self, "J_Hip_LE");
        playfxontag(level._effect["civ_burn_j_hip_ri_loop"], self, "J_Hip_RI");
        wait(randomfloatrange(0.1, 2));
        playfxontag(level._effect["civ_burn_j_elbow_le_loop"], self, "J_Elbow_LE");
        playfxontag(level._effect["civ_burn_j_elbow_ri_loop"], self, "J_Elbow_RI");
        wait(randomfloatrange(0.1, 2));
        playfxontag(level._effect["civ_burn_j_knee_le_loop"], self, "J_Knee_LE");
        playfxontag(level._effect["civ_burn_j_knee_ri_loop"], self, "J_Knee_RI");
        return;
    }
    wait(randomfloatrange(0.1, 2));
    if (math::cointoss()) {
        playfxontag(level._effect["civ_burn_j_elbow_le_loop"], self, "J_Elbow_LE");
    }
    if (math::cointoss()) {
        playfxontag(level._effect["civ_burn_j_elbow_ri_loop"], self, "J_Elbow_RI");
    }
    wait(randomfloatrange(0.1, 2));
    if (math::cointoss()) {
        playfxontag(level._effect["civ_burn_j_shoulder_le_loop"], self, "J_Shoulder_LE");
    }
    if (math::cointoss()) {
        playfxontag(level._effect["civ_burn_j_shoulder_ri_loop"], self, "J_Shoulder_RI");
    }
    wait(randomfloatrange(0.1, 2));
    if (math::cointoss()) {
        playfxontag(level._effect["civ_burn_j_hip_le_loop"], self, "J_Hip_LE");
    }
    if (math::cointoss()) {
        playfxontag(level._effect["civ_burn_j_hip_ri_loop"], self, "J_Hip_RI");
    }
    wait(randomfloatrange(0.1, 2));
    if (math::cointoss()) {
        playfxontag(level._effect["civ_burn_j_knee_le_loop"], self, "J_Knee_LE");
    }
    if (math::cointoss()) {
        playfxontag(level._effect["civ_burn_j_knee_ri_loop"], self, "J_Knee_RI");
    }
    wait(randomfloatrange(0.1, 2));
    if (math::cointoss()) {
        playfxontag(level._effect["civ_burn_j_head_loop"], self, "J_Head");
    }
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_3f34106b
// Checksum 0x7908904b, Offset: 0x1b98
// Size: 0x262
function function_3f34106b() {
    trigger::wait_till("sh_bridge_explosion", "targetname");
    var_d2d4d1ec = getentarray("sh_bridge_clean", "targetname");
    var_1c396b4f = struct::get("sh_missile_strike_start", "targetname");
    var_83e914f = struct::get("sh_missile_strike_end", "targetname");
    fx_model = util::spawn_model("tag_origin", var_1c396b4f.origin, var_1c396b4f.angles);
    fx_model fx::play("fx_trail_missile_vista_veng", fx_model.origin, fx_model.angles, undefined, 1, "tag_origin", 1);
    fx_model moveto(var_83e914f.origin, 0.75);
    wait(0.75);
    playsoundatposition("evt_bridge_explosion", fx_model.origin);
    fx_model delete();
    exploder::exploder("sh_vista_bridge_explosion");
    exploder::exploder("sh_vista_bridge_fire");
    foreach (e_ent in var_d2d4d1ec) {
        e_ent delete();
    }
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_936cf9d0
// Checksum 0x5ec9884d, Offset: 0x1e08
// Size: 0xd2
function function_936cf9d0() {
    var_d2d4d1ec = getentarray("sh_bridge_clean", "targetname");
    exploder::exploder("sh_vista_bridge_fire");
    foreach (e_ent in var_d2d4d1ec) {
        e_ent delete();
    }
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_ef909043
// Checksum 0x336fc9d0, Offset: 0x1ee8
// Size: 0x1ba
function function_ef909043() {
    var_9c327190 = getentarray("sh_corner_clean", "targetname");
    var_a4ff1499 = getentarray("sh_corner_destroy", "targetname");
    foreach (e_ent in var_a4ff1499) {
        e_ent hide();
    }
    trigger::wait_till("sh_corner_explosion", "targetname");
    exploder::exploder("sh_corner_plaza_explosion");
    wait(0.15);
    array::delete_all(var_9c327190);
    foreach (e_ent in var_a4ff1499) {
        e_ent show();
    }
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_6bd25628
// Checksum 0x5c52210a, Offset: 0x20b0
// Size: 0x44
function function_6bd25628() {
    var_9c327190 = getentarray("sh_corner_clean", "targetname");
    array::delete_all(var_9c327190);
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x0
// namespace_63b4601c<file_0>::function_1581b116
// Checksum 0xfa6b0502, Offset: 0x2100
// Size: 0xda
function refill_ammo() {
    a_w_weapons = self getweaponslist();
    foreach (w_weapon in a_w_weapons) {
        self givemaxammo(w_weapon);
        self setweaponammoclip(w_weapon, w_weapon.clipsize);
    }
}

// Namespace namespace_63b4601c
// Params 7, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_8a63fd6b
// Checksum 0x2383ce0b, Offset: 0x21e8
// Size: 0x254
function function_8a63fd6b(e_trigger, str_objective, var_ae801398, str_ender, var_65611d69, var_ca0e9b65, var_acbf687c) {
    e_trigger endon(#"death");
    if (isdefined(str_ender)) {
        level endon(str_ender);
    }
    level flag::wait_till("stealth_discovered");
    e_trigger triggerenable(0);
    if (isdefined(str_objective)) {
        objectives::hide(str_objective);
    }
    if (isdefined(var_ae801398)) {
        objectives::hide(var_ae801398);
    }
    if (isdefined(var_65611d69)) {
        objectives::set(var_65611d69);
    }
    if (isdefined(var_ca0e9b65)) {
        var_ca0e9b65 gameobjects::disable_object();
    }
    level flag::wait_till_clear("stealth_discovered");
    if (isdefined(var_ca0e9b65) && level.var_31aefea8 === "temple") {
        level flag::clear("all_players_at_temple_exit");
        objectives::show("cp_level_vengeance_goto_dogleg_2");
        level flag::wait_till("all_players_at_temple_exit");
        objectives::hide("cp_level_vengeance_goto_dogleg_2");
    }
    e_trigger triggerenable(1);
    if (isdefined(var_65611d69)) {
        objectives::hide(var_65611d69);
    }
    if (isdefined(str_objective)) {
        objectives::show(str_objective);
    }
    if (isdefined(var_ae801398)) {
        objectives::show(var_ae801398);
    }
    if (isdefined(var_ca0e9b65)) {
        var_ca0e9b65 gameobjects::enable_object();
    }
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_7c486b8c
// Checksum 0x56df57a1, Offset: 0x2448
// Size: 0x36
function function_7c486b8c() {
    self endon(#"death");
    self waittillmatch(#"hash_d501c77c");
    self.var_d501c77c = 1;
    self.var_2d1c9600 = undefined;
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_1095f52e
// Checksum 0xf7cd391, Offset: 0x2488
// Size: 0x2c
function function_1095f52e() {
    self endon(#"death");
    self waittillmatch(#"hash_7bbfb522");
    self.var_2d1c9600 = 1;
}

// Namespace namespace_63b4601c
// Params 1, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_1ed65aa
// Checksum 0x107e1685, Offset: 0x24c0
// Size: 0x202
function function_1ed65aa(a_objects) {
    foreach (e_obj in a_objects) {
        if (!isdefined(e_obj)) {
            continue;
        }
        e_obj thread function_7c486b8c();
        e_obj thread function_1095f52e();
    }
    self util::waittill_any("death");
    foreach (e_obj in a_objects) {
        if (!isdefined(e_obj)) {
            continue;
        }
        if (isdefined(e_obj.var_d501c77c) && e_obj.var_d501c77c == 1) {
            continue;
        }
        if (isdefined(e_obj.var_2d1c9600) && e_obj.var_2d1c9600 == 1) {
            e_obj stopanimscripted();
            e_obj physicslaunch(e_obj.origin, (0, 0, 0.1));
            continue;
        }
        e_obj delete();
    }
}

// Namespace namespace_63b4601c
// Params 1, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_7122594d
// Checksum 0x3f4e3a64, Offset: 0x26d0
// Size: 0x20a
function function_7122594d(a_objects) {
    foreach (e_obj in a_objects) {
        if (!isdefined(e_obj)) {
            continue;
        }
        e_obj thread function_7c486b8c();
        e_obj thread function_1095f52e();
    }
    self util::waittill_any("death", "alert");
    foreach (e_obj in a_objects) {
        if (!isdefined(e_obj)) {
            continue;
        }
        if (isdefined(e_obj.var_d501c77c) && e_obj.var_d501c77c == 1) {
            continue;
        }
        if (isdefined(e_obj.var_2d1c9600) && e_obj.var_2d1c9600 == 1) {
            e_obj stopanimscripted();
            e_obj physicslaunch(e_obj.origin, (0, 0, 0.1));
            continue;
        }
        e_obj delete();
    }
}

// Namespace namespace_63b4601c
// Params 3, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_57b69bd6
// Checksum 0x5c257548, Offset: 0x28e8
// Size: 0xb4
function function_57b69bd6(object, var_f0dc1d6d, var_a202d840) {
    if (isdefined(var_f0dc1d6d)) {
    }
    self util::waittill_any("alert", "death", "fake_alert");
    object unlink();
    if (isdefined(var_f0dc1d6d)) {
        wait(0.05);
    }
    object physicslaunch(object.origin, (0, 0, 0.1));
}

// Namespace namespace_63b4601c
// Params 1, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_394ba9b5
// Checksum 0xbfd95369, Offset: 0x29a8
// Size: 0x4c
function function_394ba9b5(var_1ea83c75) {
    self util::waittill_any("death", "alert");
    if (isdefined(var_1ea83c75)) {
        var_1ea83c75 notify(#"hash_da6a4775");
    }
}

// Namespace namespace_63b4601c
// Params 3, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_d468b73d
// Checksum 0x1267e359, Offset: 0x2a00
// Size: 0xaa
function function_d468b73d(var_3390909e, a_ents, var_36ebf819) {
    self waittill(var_3390909e);
    foreach (ent in a_ents) {
        if (isdefined(ent)) {
            ent notify(var_36ebf819);
        }
    }
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_8ffbd7bf
// Checksum 0x69907a22, Offset: 0x2ab8
// Size: 0x6c
function function_8ffbd7bf() {
    self endon(#"death");
    while (true) {
        state = self waittill(#"alert");
        if (isdefined(state) && state == "combat") {
            self ai::set_ignoreme(0);
            break;
        }
    }
}

// Namespace namespace_63b4601c
// Params 1, eflags: 0x0
// namespace_63b4601c<file_0>::function_75790dfc
// Checksum 0xeea42212, Offset: 0x2b30
// Size: 0x576
function function_75790dfc(str_objective) {
    self endon(#"death");
    self notify(#"end_movement_thread");
    self endon(#"end_movement_thread");
    self endon(#"alert");
    self thread function_8ffbd7bf();
    var_3c6e7674 = 120;
    var_6437cdb2 = 800;
    minsearchradius = math::clamp(var_3c6e7674, 0, self.goalradius);
    maxsearchradius = math::clamp(var_6437cdb2, var_3c6e7674, self.goalradius);
    halfheight = 400;
    innerspacing = 80;
    outerspacing = 50;
    var_fc9d1e61 = 10;
    var_3728fd9e = 2.5 + randomfloat(1);
    while (true) {
        target = array::random(level.var_e418a31d);
        var_4b68b086 = (self.origin[2] - target.origin[2]) / 2;
        origin = target.origin + (0, 0, var_4b68b086);
        queryresult = positionquery_source_navigation(origin, minsearchradius, maxsearchradius, halfheight, innerspacing, self, outerspacing);
        positionquery_filter_distancetogoal(queryresult, self);
        vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
        vehicle_ai::positionquery_filter_random(queryresult, 0, 10);
        vehicle_ai::positionquery_postprocess_sortscore(queryresult);
        var_9a745b6c = var_3728fd9e > 0.2;
        foundpath = 0;
        for (i = 0; i < queryresult.data.size && !foundpath; i++) {
            goalpos = queryresult.data[i].origin;
            foundpath = self setvehgoalpos(goalpos, var_9a745b6c, 1);
        }
        if (foundpath) {
            self setlookatent(target);
            self setturrettargetent(target);
            msg = self util::waittill_any_timeout(var_fc9d1e61, "near_goal", "force_goal", "reached_end_node", "goal");
            if (var_9a745b6c) {
                if (isdefined(target.script_noteworthy) && target.script_noteworthy == "scan_location") {
                    target.var_9ff2970a = getent(target.target, "targetname");
                    self function_18fb105e(target.var_9ff2970a);
                } else {
                    if (math::cointoss()) {
                        level.var_93287d84 = arraysortclosest(level.var_93287d84, self.origin, 999, 512);
                        if (isdefined(level.var_93287d84[0])) {
                            self function_120671d3(level.var_93287d84[0]);
                        }
                    } else {
                        level.var_93287d84 = arraysortclosest(level.var_93287d84, self.origin, 999, 512);
                        if (isdefined(level.var_93287d84[0])) {
                            self function_6a382ad5(level.var_93287d84[0]);
                        }
                    }
                    wait(randomfloatrange(0.5 * var_3728fd9e, var_3728fd9e));
                }
            }
            continue;
        }
        self clearturrettarget();
        self clearlookatent();
        wait(1);
    }
}

// Namespace namespace_63b4601c
// Params 1, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_120671d3
// Checksum 0x38f68707, Offset: 0x30b0
// Size: 0x16c
function function_120671d3(target) {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"end_attack_thread");
    self endon(#"alert");
    self setlookatent(target);
    self setturrettargetent(target);
    self util::waittill_any_timeout(2, "turret_on_target");
    fire_time = 1.5 + randomfloat(0.5);
    self vehicle_ai::fire_for_time(fire_time);
    wait(1);
    if (math::cointoss()) {
        fire_time = 1.5 + randomfloat(0.5);
        self vehicle_ai::fire_for_time(fire_time);
        wait(1);
    }
    self clearturrettarget();
    self clearlookatent();
}

// Namespace namespace_63b4601c
// Params 1, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_6a382ad5
// Checksum 0x646768a0, Offset: 0x3228
// Size: 0x1e4
function function_6a382ad5(target) {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"end_attack_thread");
    self endon(#"alert");
    self setlookatent(target);
    self setturrettargetent(target);
    self util::waittill_any_timeout(2, "turret_on_target");
    self hunter::function_45bbe5dd();
    wait(1);
    randomrange = 20;
    offset = [];
    for (i = 0; i < 2; i++) {
        offset[i] = (randomfloatrange(randomrange * -1, randomrange), randomfloatrange(randomrange * -1, randomrange), randomfloatrange(randomrange * -1, randomrange));
    }
    self hunter::function_ed543896(0, target, offset[0], 1, 0.8);
    wait(0.25);
    self hunter::function_ed543896(1, target, offset[1]);
    wait(1);
    self clearlookatent();
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_d92edef5
// Checksum 0xaf69426e, Offset: 0x3418
// Size: 0x15c
function function_d92edef5() {
    self.var_5772ae4 = spawn("script_model", self gettagorigin("tag_aim"));
    self.var_5772ae4 setmodel("tag_origin");
    self.var_5772ae4.angles = self gettagangles("tag_aim");
    self.var_5772ae4 linkto(self, "tag_aim");
    self.var_5772ae4.owner = self;
    self.var_5772ae4.var_f56360bf = 0;
    self.var_5772ae4.var_966f680a = spawn("script_origin", self.var_5772ae4.origin + anglestoforward(self.angles) * 1000);
    self.var_5772ae4.var_966f680a linkto(self.var_5772ae4);
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_45f7a75b
// Checksum 0xa11efa14, Offset: 0x3580
// Size: 0x74
function function_45f7a75b() {
    self function_b3df73a8();
    if (isdefined(self.var_5772ae4)) {
        if (isdefined(self.var_5772ae4.var_966f680a)) {
            self.var_5772ae4.var_966f680a delete();
        }
        self.var_5772ae4 delete();
    }
}

// Namespace namespace_63b4601c
// Params 2, eflags: 0x0
// namespace_63b4601c<file_0>::function_ff25493
// Checksum 0x3f38bd3c, Offset: 0x3600
// Size: 0x8c
function function_ff25493(targetent, offset) {
    if (!isdefined(offset)) {
        offset = (0, 0, 0);
    }
    if (isdefined(targetent)) {
        self.var_5772ae4.targetent = targetent;
        self.var_5772ae4.var_f56360bf = 1;
        self function_9af49228(self.var_5772ae4.targetent, offset, 2);
    }
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_b3df73a8
// Checksum 0xcdc66893, Offset: 0x3698
// Size: 0x34
function function_b3df73a8() {
    self.var_5772ae4.var_f56360bf = 0;
    self function_bb5f9faa(2);
}

// Namespace namespace_63b4601c
// Params 1, eflags: 0x0
// namespace_63b4601c<file_0>::function_4406e447
// Checksum 0xf479d6cf, Offset: 0x36d8
// Size: 0x54
function function_4406e447(targetpos) {
    if (isdefined(targetpos)) {
        self.var_5772ae4.targetpos = targetpos;
        self function_6521eb5d(self.var_5772ae4.targetpos, 2);
    }
}

// Namespace namespace_63b4601c
// Params 2, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_d16e8674
// Checksum 0xe56240b8, Offset: 0x3738
// Size: 0x134
function function_d16e8674(point, do_trace) {
    if (!isdefined(point)) {
        return 0;
    }
    scanner = self.var_5772ae4;
    var_e8663043 = point - scanner.origin;
    var_a641ce84 = lengthsquared(var_e8663043) <= 1024 * 1024;
    if (var_a641ce84) {
        var_a641ce84 = util::within_fov(scanner.origin, scanner.angles, point, cos(35));
    }
    if (isdefined(do_trace) && var_a641ce84 && do_trace && isdefined(self.enemy)) {
        var_a641ce84 = sighttracepassed(scanner.origin, point, 0, self.enemy);
    }
    return var_a641ce84;
}

// Namespace namespace_63b4601c
// Params 2, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_139e3a4a
// Checksum 0x6b36b447, Offset: 0x3878
// Size: 0x104
function is_valid_target(target, do_trace) {
    var_f230ef9a = 1;
    if (isdefined(target.ignoreme) && target.ignoreme || target.health <= 0) {
        var_f230ef9a = 0;
    } else if (target isnotarget() || issentient(target) && target ai::is_dead_sentient()) {
        var_f230ef9a = 0;
    } else if (isdefined(target.origin) && !function_d16e8674(target.origin, do_trace)) {
        var_f230ef9a = 0;
    }
    return var_f230ef9a;
}

// Namespace namespace_63b4601c
// Params 1, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_c35210a8
// Checksum 0xe7d1dbc2, Offset: 0x3988
// Size: 0x12c
function function_c35210a8(do_trace) {
    var_526bc7e = [];
    enemyarray = getenemyarray(1, 1);
    foreach (enemy in enemyarray) {
        if (is_valid_target(enemy, do_trace)) {
            if (!isdefined(var_526bc7e)) {
                var_526bc7e = [];
            } else if (!isarray(var_526bc7e)) {
                var_526bc7e = array(var_526bc7e);
            }
            var_526bc7e[var_526bc7e.size] = enemy;
        }
    }
    return var_526bc7e;
}

// Namespace namespace_63b4601c
// Params 2, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_cb35e6c
// Checksum 0xe4156b1d, Offset: 0x3ac0
// Size: 0xec
function getenemyarray(var_90f6a18c, var_c776eebd) {
    enemyarray = [];
    enemy_team = "allies";
    if (isdefined(var_90f6a18c) && var_90f6a18c) {
        aiarray = getaiteamarray(enemy_team);
        enemyarray = arraycombine(enemyarray, aiarray, 0, 0);
    }
    if (isdefined(var_c776eebd) && var_c776eebd) {
        playerarray = getplayers(enemy_team);
        enemyarray = arraycombine(enemyarray, playerarray, 0, 0);
    }
    return enemyarray;
}

// Namespace namespace_63b4601c
// Params 1, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_18fb105e
// Checksum 0x265f9972, Offset: 0x3bb8
// Size: 0x284
function function_18fb105e(var_3470f459) {
    self endon(#"hash_e9de6408");
    self endon(#"crash_done");
    self endon(#"death");
    self endon(#"end_movement_thread");
    self endon(#"alert");
    self function_d92edef5();
    var_c04ea392 = 0;
    var_161ae6a0 = 6;
    while (var_c04ea392 < var_161ae6a0) {
        if (!isdefined(self.enemy)) {
            self.var_5772ae4.var_966f680a playloopsound("veh_hunter_scanner_loop", 1);
            /#
                line(self gettagorigin("_"), var_3470f459.origin, (0, 1, 0), 1, 3);
            #/
            offset = var_3470f459.origin + (randomfloatrange(0, 40), randomfloatrange(0, 40), randomfloatrange(0, 40));
            enemies = function_c35210a8(1);
            if (enemies.size > 0) {
                closest_enemy = arraygetclosest(self.origin, enemies);
                self.favoriteenemy = closest_enemy;
            }
        } else {
            if (self hunter::function_d16e8674(self.enemy.origin, 1)) {
                self notify(#"hash_5176d091");
            } else {
                self notify(#"hash_5a14c09c");
            }
            self.var_5772ae4.var_966f680a stoploopsound(1);
        }
        wait(0.1);
        var_c04ea392 += 0.1;
    }
    self function_45f7a75b();
}

// Namespace namespace_63b4601c
// Params 3, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_ab876b5a
// Checksum 0x4ab7da98, Offset: 0x3e48
// Size: 0x90
function function_ab876b5a(video, var_2d0f3d61, var_199e0d00) {
    level endon(#"hash_92bd0e81");
    while (true) {
        level waittill(var_2d0f3d61);
        videostop(video);
        wait(3);
        videostart(video, 1);
        level waittill(var_199e0d00);
        videostop(video);
    }
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_cc6f3598
// Checksum 0x8bbdeba4, Offset: 0x3ee0
// Size: 0x7c
function function_cc6f3598() {
    trigger::wait_till("temple_video");
    videostop("cp_vengeance_env_sign_dragon01");
    wait(1);
    videostart("cp_vengeance_env_sign_dragon01", 1);
    level waittill(#"hash_42cabc57");
    videostop("cp_vengeance_env_sign_dragon01");
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_5dbf4126
// Checksum 0xec1110d6, Offset: 0x3f68
// Size: 0x74
function function_5dbf4126() {
    videostop("cp_vengeance_env_sign_parking01");
    wait(1);
    videostart("cp_vengeance_env_sign_parking01", 1);
    level flag::wait_till("plaza_cleared");
    videostop("cp_vengeance_env_sign_parking01");
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x0
// namespace_63b4601c<file_0>::function_6bdeeb80
// Checksum 0xa1b1902c, Offset: 0x3fe8
// Size: 0x124
function function_6bdeeb80() {
    a_players = [];
    if (isdefined(level.stealth.seek)) {
        foreach (ent in level.stealth.seek) {
            if (isplayer(ent)) {
                if (!isdefined(a_players)) {
                    a_players = [];
                } else if (!isarray(a_players)) {
                    a_players = array(a_players);
                }
                a_players[a_players.size] = ent;
            }
        }
    }
    return a_players.size >= 1;
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x0
// namespace_63b4601c<file_0>::function_76bdbf62
// Checksum 0xd0da7ae9, Offset: 0x4118
// Size: 0x194
function function_76bdbf62() {
    self endon(#"death");
    self.team = "allies";
    self.civilian = 1;
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    self ai::set_behavior_attribute("panic", 0);
    self.health = 1;
    if (isdefined(self.script_linkto)) {
        trigger = getent(self.script_linkto, "script_linkname");
        if (isdefined(trigger)) {
            trigger::wait_till(trigger);
        }
    }
    self ai::set_ignoreme(0);
    self ai::set_ignoreall(0);
    if (isdefined(self.target)) {
        node = getnode(self.target, "targetname");
        self setgoal(node, 0, node.radius);
    }
    self ai::set_behavior_attribute("panic", 1);
}

// Namespace namespace_63b4601c
// Params 4, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_3d5f97bd
// Checksum 0x747e36b5, Offset: 0x42b8
// Size: 0x184
function function_3d5f97bd(node, var_41178307, var_37730a64, distance) {
    self endon(#"death");
    self clearforcedgoal();
    self cleargoalvolume();
    self.goalradius = 32;
    self setgoal(node.origin, 1);
    if (isdefined(var_37730a64) && var_37730a64 == 1) {
        result = self util::waittill_any("goal", "near_goal", "bad_path");
    } else {
        result = self util::waittill_any_timeout(15, "goal", "near_goal", "bad_path");
    }
    if (result == "goal" || isdefined(result) && result == "near_goal") {
        delete_ai(self, var_41178307, distance);
        return;
    }
    delete_ai(self, undefined, distance);
}

// Namespace namespace_63b4601c
// Params 3, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_307b1179
// Checksum 0xa6213e48, Offset: 0x4448
// Size: 0x84
function delete_ai(ai, var_41178307, distance) {
    if (isdefined(var_41178307) && var_41178307) {
        ai kill();
        return;
    }
    a_ai = array(ai);
    level thread function_ff5f379(a_ai, distance);
}

// Namespace namespace_63b4601c
// Params 2, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_ff5f379
// Checksum 0xb750100b, Offset: 0x44d8
// Size: 0x1e0
function function_ff5f379(a_ai, n_dist) {
    if (!isdefined(a_ai)) {
        return;
    }
    var_e52b590a = 0.75;
    if (!isdefined(n_dist)) {
        n_dist = 512;
    }
    while (a_ai.size > 0) {
        for (i = 0; i < a_ai.size; i++) {
            if (!isdefined(a_ai[i]) || !isalive(a_ai[i])) {
                arrayremovevalue(a_ai, a_ai[i]);
                continue;
            }
            if (players_within_distance(n_dist, a_ai[i].origin)) {
                continue;
            }
            if (any_player_looking_at(a_ai[i].origin + (0, 0, 48), var_e52b590a, 1)) {
                continue;
            }
            if (!(isdefined(a_ai[i].allowdeath) && a_ai[i].allowdeath)) {
                a_ai[i] util::stop_magic_bullet_shield();
            }
            a_ai[i] delete();
            arrayremovevalue(a_ai, a_ai[i]);
        }
        wait(1);
    }
}

// Namespace namespace_63b4601c
// Params 2, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_719f06a1
// Checksum 0xb7a01cf8, Offset: 0x46c0
// Size: 0x96
function players_within_distance(n_dist, v_org) {
    n_dist_squared = n_dist * n_dist;
    for (i = 0; i < level.players.size; i++) {
        if (distancesquared(v_org, level.players[i].origin) < n_dist_squared) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_63b4601c
// Params 4, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_8c6350db
// Checksum 0x582f5697, Offset: 0x4760
// Size: 0x88
function any_player_looking_at(v_org, n_dot, var_2cd7fdc6, e_ignore) {
    for (i = 0; i < level.players.size; i++) {
        if (level.players[i] util::is_player_looking_at(v_org, n_dot, var_2cd7fdc6, e_ignore)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_63b4601c
// Params 1, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_80840124
// Checksum 0x2f0c6fdf, Offset: 0x47f0
// Size: 0x1a0
function function_80840124(var_f5d7a3f) {
    level notify(#"hash_bab8795");
    level endon(#"hash_bab8795");
    var_17994622 = getaiteamarray("axis");
    var_60aeac6b = [];
    var_60aeac6b[0] = "hend_damn_they_re_onto_u_1";
    var_60aeac6b[1] = "hend_damn_they_know_we_r_0";
    var_60aeac6b[2] = "hend_shit_go_hot_they_r_0";
    line = array::random(var_60aeac6b);
    level function_ee75acde(line);
    if (isdefined(var_f5d7a3f)) {
        [[ var_f5d7a3f ]]();
    }
    wait(3);
    while (true) {
        if (level flag::get("combat_enemies_retreating")) {
            level flag::clear("combat_enemies_retreating");
            break;
        }
        var_457b0e7 = getaiteamarray("axis");
        util::wait_endon(randomfloatrange(15, 20), "combat_enemies_retreating");
    }
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x0
// namespace_63b4601c<file_0>::function_ee78c834
// Checksum 0xcd2535c7, Offset: 0x4998
// Size: 0x48
function function_ee78c834() {
    while (true) {
        if (isdefined(self.crashing) && self.crashing == 1) {
            level notify(#"hash_fec3c49");
            break;
        }
        wait(1);
    }
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_12a1b6a0
// Checksum 0x844caa8e, Offset: 0x49e8
// Size: 0xac
function function_12a1b6a0() {
    self endon(#"death");
    self endon(#"disconnect");
    weap = getweapon("ar_marksman_veng_hero_weap");
    while (true) {
        if (self getcurrentweapon() == weap) {
            break;
        }
        wait(0.05);
    }
    w_current = self waittill(#"weapon_change_complete");
    self thread function_51caee84("dogleg_1_end");
}

// Namespace namespace_63b4601c
// Params 1, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_51caee84
// Checksum 0xda269ccd, Offset: 0x4aa0
// Size: 0xf4
function function_51caee84(var_6fbdf20) {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"hash_8a3b89d3");
    if (isdefined(var_6fbdf20)) {
        level endon(var_6fbdf20);
    }
    weap = getweapon("ar_marksman_veng_hero_weap");
    if (self getcurrentweapon() == weap) {
        while (true) {
            w_current = self waittill(#"weapon_change_complete");
            if (w_current == weap) {
                continue;
            }
            if (w_current != weap) {
                break;
            }
        }
    }
    self thread util::show_hint_text(%COOP_EQUIP_SHEIVASSW, undefined, undefined, 4);
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_b9785164
// Checksum 0x5ef50bbe, Offset: 0x4ba0
// Size: 0x7a
function function_b9785164() {
    self endon(#"disconnect");
    while (isdefined(self)) {
        w_current = self waittill(#"weapon_change_complete");
        if (w_current.name == "launcher_standard") {
            self thread function_fbd02062();
            self notify(#"hash_b8804640");
            break;
        }
    }
}

// Namespace namespace_63b4601c
// Params 1, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_b627f9ac
// Checksum 0xbc849d36, Offset: 0x4c28
// Size: 0x8c
function give_hero_weapon(var_75ab460c) {
    weap = getweapon("ar_marksman_veng_hero_weap");
    if (!self hasweapon(weap)) {
        self giveweapon(weap);
    }
    if (isdefined(var_75ab460c) && var_75ab460c) {
        self switchtoweapon(weap);
    }
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_fbd02062
// Checksum 0x2fa6ea8a, Offset: 0x4cc0
// Size: 0x5c
function function_fbd02062() {
    weap = getweapon("ar_marksman_veng_hero_weap");
    if (self hasweapon(weap)) {
        self takeweapon(weap);
    }
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_bce5a9e
// Checksum 0x106ad288, Offset: 0x4d28
// Size: 0xac
function function_bce5a9e() {
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self.var_fb7ce72a = &function_a7507be6;
    var_52b4a338, vehentnum = level waittill(#"clonedentity");
    if (var_52b4a338.targetname === "remote_snipers_ai") {
        var_52b4a338.owner thread function_749b8ef8();
    }
}

// Namespace namespace_63b4601c
// Params 2, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_a7507be6
// Checksum 0xf7edd040, Offset: 0x4de0
// Size: 0x44
function function_a7507be6(player, weapon) {
    if (issubstr(weapon.name, "hijack")) {
        return 1;
    }
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_749b8ef8
// Checksum 0xa00eca32, Offset: 0x4e30
// Size: 0xb4
function function_749b8ef8() {
    self endon(#"disconnect");
    self endon(#"death");
    self thread function_80d50798();
    self allowads(1);
    wait(1);
    self clientfield::set_to_player("enemy_highlight", 1);
    while (self isinvehicle()) {
        wait(0.05);
    }
    self clientfield::set_to_player("enemy_highlight", 0);
}

// Namespace namespace_63b4601c
// Params 1, eflags: 0x0
// namespace_63b4601c<file_0>::function_f4c1160
// Checksum 0x9aa06d9c, Offset: 0x4ef0
// Size: 0x3dc
function function_f4c1160(var_8c0019d7) {
    self endon(#"disconnect");
    self endon(#"death");
    if (!isvehicle(var_8c0019d7)) {
        return;
    }
    if (isdefined(self.var_3a92cc8f)) {
        return;
    }
    self thread function_bf611bcc(%CP_MI_SING_VENGEANCE_ACTIVATING_REMOTE_SNIPER, 2.5);
    self thread function_7a768ec("hijack_static_effect", 0, 1, 2);
    wait(2.5);
    var_8c0019d7.ignoreme = 1;
    playerstate = spawnstruct();
    self namespace_7cb6cd95::function_dc86efaa(playerstate, "begin");
    self namespace_7cb6cd95::function_dc86efaa(playerstate, "cloak");
    self namespace_7cb6cd95::function_dc86efaa(playerstate, "cloak_wait");
    self.var_3a92cc8f = self.origin;
    self.var_5b921246 = self getplayerangles();
    self setorigin(var_8c0019d7.origin);
    self setplayerangles(var_8c0019d7 gettagangles("tag_flash"));
    self thread function_7a768ec("hijack_static_effect", 1, 0, 1.5);
    wait(0.05);
    var_8c0019d7 usevehicle(self, 0);
    var_8c0019d7 function_2821bb42(0);
    self thread function_c7ca0bfb();
    self thread function_80d50798();
    self allowads(1);
    self namespace_7cb6cd95::function_dc86efaa(playerstate, "return_wait");
    if (self.var_39b8096c) {
        var_8c0019d7 usevehicle(self, 0);
    }
    self clientfield::set_to_player("enemy_highlight", 0);
    var_8c0019d7 function_2821bb42(1);
    self setorigin(self.var_3a92cc8f);
    self setplayerangles(self.var_5b921246);
    self.var_3a92cc8f = undefined;
    self.var_5b921246 = undefined;
    self.var_a71359f0 = undefined;
    self thread namespace_7cb6cd95::function_13f4170a(2);
    self thread function_7a768ec("hijack_static_effect", 0, 0, 0);
    self namespace_7cb6cd95::function_dc86efaa(playerstate, "finish");
    wait(0.05);
    visionset_mgr::deactivate("visionset", "hijack_vehicle", self);
    visionset_mgr::deactivate("visionset", "hijack_vehicle_blur", self);
}

// Namespace namespace_63b4601c
// Params 4, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_7a768ec
// Checksum 0x3b694752, Offset: 0x52d8
// Size: 0x19c
function function_7a768ec(fieldname, var_b67bfdce, var_2fcd0a39, timeseconds) {
    assert(isplayer(self));
    self notify("sniper_roost_trans_cf_" + fieldname);
    self endon("sniper_roost_trans_cf_" + fieldname);
    self endon(#"disconnect");
    self endon(#"death");
    timems = float(timeseconds * 1000);
    start = gettime();
    durationms = 0;
    var_b67bfdce = float(var_b67bfdce);
    var_2fcd0a39 = float(var_2fcd0a39);
    while (durationms <= timems) {
        value = var_2fcd0a39;
        if (durationms < timems) {
            value = var_b67bfdce + (var_2fcd0a39 - var_b67bfdce) * durationms / timems;
        }
        self clientfield::set_to_player(fieldname, value);
        wait(0.05);
        durationms = float(gettime() - start);
    }
}

// Namespace namespace_63b4601c
// Params 2, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_bf611bcc
// Checksum 0x657420a6, Offset: 0x5480
// Size: 0xb4
function function_bf611bcc(msg, duration) {
    self notify(#"hash_bf611bcc");
    self endon(#"hash_bf611bcc");
    self endon(#"disconnect");
    var_b444826e = spawnstruct();
    var_b444826e.var_2888112b = msg;
    var_b444826e.duration = duration;
    self hud_message::notifymessage(var_b444826e);
    wait(duration);
    self hud_message::resetnotify();
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_c7ca0bfb
// Checksum 0x60b2c737, Offset: 0x5540
// Size: 0x126
function function_c7ca0bfb() {
    self endon(#"disconnect");
    self.var_39b8096c = 0;
    endtime = gettime() + 45000;
    while (isdefined(self.usingvehicle) && self.usingvehicle && !self.var_39b8096c) {
        self clientfield::set_to_player("enemy_highlight", 1);
        wait(0.05);
        self.var_39b8096c = isdefined(self.usingvehicle) && self.usingvehicle && gettime() > endtime;
        if (endtime - gettime() < 3000) {
            self notify(#"hash_4efa2e41");
            if (!(isdefined(self.var_a71359f0) && self.var_a71359f0)) {
                self.var_a71359f0 = 1;
                self thread function_7a768ec("hijack_static_effect", 0, 1, 2);
            }
        }
    }
    self notify(#"hash_c68b15c8");
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_80d50798
// Checksum 0x7a47c2ce, Offset: 0x5670
// Size: 0x1e0
function function_80d50798() {
    self endon(#"hash_c68b15c8");
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        victim, smeansofdeath, weapon = self waittill(#"hash_c56ba9f7");
        if (isactor(victim)) {
            if (randomfloat(100) > 50) {
                gibserverutils::gibhead(victim);
            }
            if (randomfloat(100) > 50) {
                gibserverutils::gibleftleg(victim);
            }
            if (randomfloat(100) > 50) {
                gibserverutils::gibrightleg(victim);
            }
            if (randomfloat(100) > 50) {
                gibserverutils::gibleftarm(victim);
            } else {
                gibserverutils::gibrightarm(victim);
            }
        }
        if (isactor(victim)) {
            var_30f3afa7 = victim.origin - (0, 0, 50);
            wait(0.05);
            physicsexplosionsphere(var_30f3afa7, 100, 10, 5000);
        }
    }
}

// Namespace namespace_63b4601c
// Params 1, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_2821bb42
// Checksum 0x32d4d2c3, Offset: 0x5858
// Size: 0x182
function function_2821bb42(visible) {
    var_6e89a7da = [];
    var_6e89a7da[var_6e89a7da.size] = "tag_turret";
    var_6e89a7da[var_6e89a7da.size] = "tag_turret_animate";
    var_6e89a7da[var_6e89a7da.size] = "tag_barrel";
    var_6e89a7da[var_6e89a7da.size] = "tag_barrel_animate";
    var_6e89a7da[var_6e89a7da.size] = "tag_sensor_animate";
    var_6e89a7da[var_6e89a7da.size] = "tag_ammo_belt_animate";
    var_6e89a7da[var_6e89a7da.size] = "tag_ammo_can_animate";
    var_6e89a7da[var_6e89a7da.size] = "tag_barrel_spin";
    var_6e89a7da[var_6e89a7da.size] = "tag_barrel_spin_animate";
    foreach (part in var_6e89a7da) {
        if (visible) {
            self showpart(part);
            continue;
        }
        self hidepart(part);
    }
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_5a886ae0
// Checksum 0x437f9949, Offset: 0x59e8
// Size: 0x2f0
function function_5a886ae0() {
    self endon(#"death");
    self notify(#"hash_90a20e6d");
    self endon(#"hash_90a20e6d");
    while (true) {
        a_ai = [];
        var_dea76e58 = getaiteamarray("axis");
        foreach (ai in var_dea76e58) {
            if (!isdefined(ai)) {
                continue;
            }
            if (!isalive(ai)) {
                continue;
            }
            if (isvehicle(ai)) {
                continue;
            }
            if (stealth::function_437e9eec(ai)) {
                continue;
            }
            if (!isdefined(a_ai)) {
                a_ai = [];
            } else if (!isarray(a_ai)) {
                a_ai = array(a_ai);
            }
            a_ai[a_ai.size] = ai;
        }
        if (isdefined(a_ai) && a_ai.size > 0) {
            a_ai = arraysortclosest(a_ai, self.origin, 2, 64, 800);
            if (isdefined(a_ai) && a_ai.size > 0) {
                switch (randomint(4)) {
                case 0:
                    self thread cybercom::function_d240e350("cybercom_fireflyswarm", a_ai);
                    break;
                case 1:
                    self thread cybercom::function_d240e350("cybercom_concussive");
                    break;
                case 2:
                    self thread cybercom::function_d240e350("cybercom_systemoverload", a_ai);
                    break;
                case 3:
                    self thread cybercom::function_d240e350("cybercom_servoshortout", a_ai);
                    break;
                }
                wait(randomfloatrange(20, 30));
            }
        }
        wait(2);
    }
}

// Namespace namespace_63b4601c
// Params 3, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_e6399870
// Checksum 0x1facde79, Offset: 0x5ce0
// Size: 0x102
function function_e6399870(str_value, str_key, var_6971862e) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    assert(isdefined(var_6971862e));
    triggers = getentarray(str_value, str_key);
    foreach (trigger in triggers) {
        trigger thread function_b88d5e7(var_6971862e);
    }
}

// Namespace namespace_63b4601c
// Params 1, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_b88d5e7
// Checksum 0xfb4cd404, Offset: 0x5df0
// Size: 0x41a
function function_b88d5e7(var_6971862e) {
    targets = undefined;
    if (isdefined(self.target)) {
        targets = struct::get_array(self.target, "targetname");
    }
    if (!isdefined(targets) && isdefined(self.target)) {
        targets = getentarray(self.target, "targetname");
    }
    if (!isdefined(targets) || targets.size == 0) {
        /#
            iprintlnbold("_" + self.origin);
        #/
        return;
    }
    while (true) {
        player = self waittill(#"trigger");
        if (!isplayer(player)) {
            continue;
        }
        while (targets.size > 0) {
            aiarray = getaiteamarray("axis");
            aiarray = arraysortclosest(aiarray, self.origin, 64, 0, 1000);
            foreach (ai in aiarray) {
                if (targets.size <= 0) {
                    break;
                }
                if (!isdefined(ai) || !isactor(ai) || !isalive(ai)) {
                    continue;
                }
                if (!(ai.archetype == "human" || ai.archetype == "human_riotshield" || ai.archetype == "human_rpg" || isdefined(ai.archetype) && ai.archetype == "civilian")) {
                    continue;
                }
                if (isdefined(ai.var_25ce4365)) {
                    continue;
                }
                if (ai istouching(self)) {
                    continue;
                }
                foreach (index, var_daf22616 in targets) {
                    if (!isdefined(ai) || !isactor(ai) || !isalive(ai)) {
                        break;
                    }
                    molotov = ai function_25ce4365(var_daf22616.origin);
                    if (isdefined(molotov)) {
                        var_daf22616 thread function_9856bfc7(molotov);
                        targets[index] = undefined;
                        break;
                    }
                }
            }
            if (targets.size > 0) {
                wait(1);
            }
        }
    }
}

// Namespace namespace_63b4601c
// Params 1, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_9856bfc7
// Checksum 0xf1320def, Offset: 0x6218
// Size: 0x44
function function_9856bfc7(molotov) {
    molotov waittill(#"death");
    if (isdefined(self.script_parameters)) {
        exploder::exploder(self.script_parameters);
    }
}

// Namespace namespace_63b4601c
// Params 1, eflags: 0x0
// namespace_63b4601c<file_0>::function_c7b05b81
// Checksum 0x6a525560, Offset: 0x6268
// Size: 0x70
function function_c7b05b81(var_6971862e) {
    self endon(#"death");
    while (true) {
        player = self waittill(#"trigger");
        if (!isplayer(player)) {
            continue;
        }
        player thread function_18538df(self, var_6971862e);
    }
}

// Namespace namespace_63b4601c
// Params 2, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_18538df
// Checksum 0xeba167c5, Offset: 0x62e0
// Size: 0xf0
function function_18538df(trigger, var_6971862e) {
    self endon(#"death");
    self endon(#"disconnect");
    self notify("molotov_trigger_damage_thread_" + trigger getentitynumber());
    self endon("molotov_trigger_damage_thread_" + trigger getentitynumber());
    if (!isdefined(self.var_c8adaf48)) {
        self.var_c8adaf48 = 0;
    }
    while (self istouching(trigger)) {
        if (gettime() - self.var_c8adaf48 >= 1000) {
            self.var_c8adaf48 = gettime();
            self dodamage(var_6971862e, self.origin);
        }
        wait(0.05);
    }
}

// Namespace namespace_63b4601c
// Params 2, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_25ce4365
// Checksum 0x6acfd962, Offset: 0x63d8
// Size: 0x2ba
function function_25ce4365(targetposition, var_4ccd5cb0) {
    self endon(#"death");
    assert(isactor(self));
    assert(isdefined(targetposition));
    assert(isvec(targetposition));
    self.var_25ce4365 = 1;
    weap = getweapon("molotov_vengeance");
    grenadeent = undefined;
    if (isdefined(weap)) {
        grenadeent = self magicgrenade(self geteye(), targetposition, 10, weap);
        if (!isdefined(grenadeent)) {
            self.var_25ce4365 = undefined;
            return undefined;
        } else {
            grenadeent thread delayed_delete(0.05);
            grenadeent = undefined;
        }
        ents = [];
        ents[0] = self;
        var_521db653 = spawnstruct();
        var_521db653.origin = self.origin;
        var_521db653.angles = (0, vectortoangles(targetposition - self.origin)[1], 0);
        if (isalive(self)) {
            var_521db653 thread scene::play(ents, "cin_ven_gen_grenade_throw_a");
            self waittill(#"grenade_throw");
            frompoint = self gettagorigin("J_Thumb_RI_1");
            grenadeent = self magicgrenade(frompoint, targetposition, 10, weap);
            self.var_1fd9293d = grenadeent;
            if (isdefined(var_4ccd5cb0) && var_4ccd5cb0) {
                self thread function_85c2c12();
            }
        }
    }
    self.var_25ce4365 = undefined;
    return grenadeent;
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_85c2c12
// Checksum 0x34d37281, Offset: 0x66a0
// Size: 0x64
function function_85c2c12() {
    self endon(#"death");
    self ai::set_ignoreme(1);
    if (isdefined(self.var_1fd9293d)) {
        self.var_1fd9293d waittill(#"death");
        wait(0.5);
    }
    self ai::set_ignoreme(0);
}

// Namespace namespace_63b4601c
// Params 1, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_1a32c391
// Checksum 0xd5518401, Offset: 0x6710
// Size: 0x34
function delayed_delete(time) {
    self endon(#"death");
    wait(time);
    self delete();
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_f9c94344
// Checksum 0x52a7a8d9, Offset: 0x6750
// Size: 0x3c
function function_f9c94344() {
    level endon(#"hash_8a3b89d3");
    self endon(#"death");
    self waittill(#"trigger");
    stealth::function_9aa26b41();
}

// Namespace namespace_63b4601c
// Params 2, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_e3420328
// Checksum 0x777ad70a, Offset: 0x6798
// Size: 0x64
function function_e3420328(scene, var_6fbdf20) {
    level thread scene::play(scene);
    level flag::wait_till(var_6fbdf20);
    level thread scene::stop(scene, 1);
}

// Namespace namespace_63b4601c
// Params 2, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_65a61b78
// Checksum 0x8d93f120, Offset: 0x6808
// Size: 0x148
function function_65a61b78(a_ents, var_6a07eb6c) {
    level flag::wait_till("all_players_spawned");
    foreach (e_player in level.players) {
        foreach (var_806fd666 in var_6a07eb6c) {
            if (isdefined(a_ents[var_806fd666])) {
                a_ents[var_806fd666] clientfield::set("mature_hide", 1);
            }
        }
    }
}

// Namespace namespace_63b4601c
// Params 1, eflags: 0x0
// namespace_63b4601c<file_0>::function_638bf7ab
// Checksum 0x10602f6f, Offset: 0x6958
// Size: 0xfc
function function_638bf7ab(var_6fbdf20) {
    model = spawn("script_model", self.origin);
    model.angles = self.angles;
    model setmodel(self.model);
    model thread scene::play(self.script_noteworthy, model);
    wait(0.1);
    model animation::detach_weapon();
    level flag::wait_till(var_6fbdf20);
    if (isdefined(model)) {
        model stopanimscripted();
        model delete();
    }
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_a084a58f
// Checksum 0xff2643e9, Offset: 0x6a60
// Size: 0x14
function function_a084a58f() {
    savegame::checkpoint_save();
}

// Namespace namespace_63b4601c
// Params 3, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_ac2b4535
// Checksum 0x77866142, Offset: 0x6a80
// Size: 0xc4
function function_ac2b4535(str_scene, str_teleport_name, var_ddaacf8f) {
    if (!isdefined(var_ddaacf8f)) {
        var_ddaacf8f = 1;
    }
    assert(isdefined(str_scene), "_");
    assert(isdefined(str_teleport_name), "_");
    scene::add_scene_func(str_scene, &function_96861272, "players_done");
    level thread function_cb1e4146(str_scene, str_teleport_name, var_ddaacf8f);
}

// Namespace namespace_63b4601c
// Params 1, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_96861272
// Checksum 0x76905281, Offset: 0x6b50
// Size: 0x1a
function function_96861272(a_ents) {
    level notify(#"teleport_players");
}

// Namespace namespace_63b4601c
// Params 3, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_cb1e4146
// Checksum 0x22bff42a, Offset: 0x6b78
// Size: 0x174
function function_cb1e4146(str_scene, str_teleport_name, var_ddaacf8f) {
    level waittill(#"teleport_players");
    foreach (player in level.players) {
        player ghost();
    }
    util::function_93831e79(str_teleport_name);
    wait(0.5);
    foreach (player in level.players) {
        player show();
    }
    if (isdefined(var_ddaacf8f) && var_ddaacf8f) {
        savegame::checkpoint_save();
    }
}

// Namespace namespace_63b4601c
// Params 2, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_4e8207e9
// Checksum 0x5152f271, Offset: 0x6cf8
// Size: 0x4c
function function_4e8207e9(var_6194780b, b_enable) {
    if (!isdefined(b_enable)) {
        b_enable = 1;
    }
    level clientfield::set("fxanims_" + var_6194780b, b_enable);
}

// Namespace namespace_63b4601c
// Params 2, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_1c347e72
// Checksum 0x34af300e, Offset: 0x6d50
// Size: 0x6c
function function_1c347e72(str_targetname, var_bb76866b) {
    hidemiscmodels(str_targetname);
    a_models = getentarray(var_bb76866b, "targetname");
    array::delete_all(a_models);
}

// Namespace namespace_63b4601c
// Params 2, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_ba7c52d5
// Checksum 0x15416a69, Offset: 0x6dc8
// Size: 0x2c
function function_ba7c52d5(a_ents, str_targetname) {
    showmiscmodels(str_targetname);
}

// Namespace namespace_63b4601c
// Params 2, eflags: 0x0
// namespace_63b4601c<file_0>::function_a72c2dda
// Checksum 0xcd9fa4c7, Offset: 0x6e00
// Size: 0xd2
function function_a72c2dda(a_ents, str_targetname) {
    showmiscmodels(str_targetname);
    foreach (ent in a_ents) {
        if (isdefined(ent) && !issentient(ent)) {
            ent delete();
        }
    }
}

// Namespace namespace_63b4601c
// Params 0, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_f832e2fa
// Checksum 0x825d127, Offset: 0x6ee0
// Size: 0xbc
function function_f832e2fa() {
    if (isactor(self)) {
        return;
    }
    self.ignoreme = 1;
    self.ignoreall = 1;
    self.team = "allies";
    self clientfield::set("thermal_active", 1);
    self util::waittill_any("death", "cleanup");
    if (isdefined(self)) {
        self clientfield::set("thermal_active", 0);
    }
}

// Namespace namespace_63b4601c
// Params 4, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_5fbec645
// Checksum 0x31f24b6a, Offset: 0x6fa8
// Size: 0x4c
function function_5fbec645(str_vo_line, delay, priority, toplayer) {
    self function_6ac438(0, str_vo_line, delay, priority, toplayer);
}

// Namespace namespace_63b4601c
// Params 4, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_ee75acde
// Checksum 0xee24eba8, Offset: 0x7000
// Size: 0x4c
function function_ee75acde(str_vo_line, delay, priority, toplayer) {
    self function_6ac438(1, str_vo_line, delay, priority, toplayer);
}

// Namespace namespace_63b4601c
// Params 5, eflags: 0x5 linked
// namespace_63b4601c<file_0>::function_6ac438
// Checksum 0xeb3f4442, Offset: 0x7058
// Size: 0x25c
function private function_6ac438(remote, str_vo_line, delay, priority, toplayer) {
    var_8ef9b1c0 = strtok(str_vo_line, "_");
    character = var_8ef9b1c0[0];
    if (!isdefined(level.stealth) || character != "hend") {
        if (remote) {
            self dialog::remote(str_vo_line, delay, undefined, toplayer);
            return;
        }
        self dialog::say(str_vo_line, delay, undefined, toplayer);
        return;
    }
    var_1f09bc21 = [];
    foreach (player in level.players) {
        if (!isdefined(toplayer) || player == toplayer) {
            self thread function_cb760154(remote, str_vo_line, delay, priority, player);
            var_1f09bc21[var_1f09bc21.size] = player;
        }
    }
    while (var_1f09bc21.size) {
        for (i = var_1f09bc21.size - 1; i >= 0; i--) {
            if (!isdefined(var_1f09bc21[i]) || !isdefined(var_1f09bc21[i].var_90180902) || !isdefined(var_1f09bc21[i].var_90180902[character])) {
                var_1f09bc21[i] = undefined;
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_63b4601c
// Params 5, eflags: 0x5 linked
// namespace_63b4601c<file_0>::function_cb760154
// Checksum 0xdbec0878, Offset: 0x72c0
// Size: 0x1c0
function private function_cb760154(remote, str_vo_line, delay, priority, toplayer) {
    toplayer endon(#"disconnect");
    assert(isplayer(toplayer));
    var_8ef9b1c0 = strtok(str_vo_line, "_");
    character = var_8ef9b1c0[0];
    if (!isdefined(priority)) {
        priority = 0;
    }
    if (!isdefined(delay)) {
        delay = 0;
    }
    if (!isdefined(toplayer.var_90180902)) {
        toplayer.var_90180902 = [];
    }
    var_a5b0e2ce = -1;
    if (isdefined(toplayer.var_90180902[character])) {
        var_a5b0e2ce = toplayer.var_90180902[character];
    }
    if (var_a5b0e2ce > -1) {
        return;
    }
    toplayer.var_90180902[character] = priority;
    if (remote) {
        self dialog::remote(str_vo_line, delay, undefined, toplayer);
    } else {
        self dialog::say(str_vo_line, delay, undefined, toplayer);
    }
    toplayer.var_90180902[character] = undefined;
}

// Namespace namespace_63b4601c
// Params 3, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_e00864bd
// Checksum 0x49e334f3, Offset: 0x7488
// Size: 0x94
function function_e00864bd(gate, state, id) {
    var_50bda1f6 = getent(gate, "targetname");
    wait(0.1);
    var_50bda1f6 ghost();
    var_50bda1f6 notsolid();
    umbragate_set(id, state);
}

// Namespace namespace_63b4601c
// Params 4, eflags: 0x1 linked
// namespace_63b4601c<file_0>::function_ffaf4723
// Checksum 0x51c8cedb, Offset: 0x7528
// Size: 0x188
function function_ffaf4723(vol, gate, id, flag) {
    level endon(flag);
    var_88cf688e = getent(vol, "targetname");
    var_50bda1f6 = getent(gate, "targetname");
    var_50bda1f6 ghost();
    var_50bda1f6 notsolid();
    while (true) {
        var_2d00103e = 0;
        foreach (player in level.activeplayers) {
            if (player istouching(var_88cf688e)) {
                var_2d00103e = 1;
                break;
            }
        }
        umbragate_set(id, var_2d00103e);
        wait(0.1);
    }
}

