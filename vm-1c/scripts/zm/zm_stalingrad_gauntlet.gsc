#using scripts/zm/zm_stalingrad_util;
#using scripts/zm/_zm_ai_sentinel_drone;
#using scripts/shared/ai/zombie_utility;
#using scripts/zm/zm_stalingrad_vo;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_weap_dragon_gauntlet;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_audio;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_9d455fc7;

// Namespace namespace_9d455fc7
// Params 0, eflags: 0x1 linked
// Checksum 0xc3efc054, Offset: 0xb00
// Size: 0x6ac
function function_622ad391() {
    level flag::init("dragon_egg_acquired");
    level flag::init("egg_bathed_in_flame");
    level flag::init("egg_cooled_hazard");
    level flag::init("egg_awakened");
    level flag::init("gauntlet_step_2_complete");
    level flag::init("gauntlet_step_3_complete");
    level flag::init("gauntlet_step_4_complete");
    level flag::init("egg_placed_incubator");
    level flag::init("egg_cooled_incubator");
    level flag::init("egg_placed_in_hazard");
    level flag::init("basement_sentinel_wait");
    level flag::init("gauntlet_quest_complete");
    level.var_de98e3ce = struct::spawn();
    level.var_de98e3ce.var_d54b9ade = struct::spawn();
    level.var_de98e3ce.var_1467b926 = 1;
    level.var_de98e3ce.var_179b5b71 = 0;
    level thread function_fa149742();
    level flag::wait_till("dragon_egg_acquired");
    foreach (player in level.activeplayers) {
        player clientfield::set_player_uimodel("zmInventory.progress_egg", 0.2);
    }
    level thread function_5d1a6241();
    level flag::wait_till("egg_awakened");
    foreach (player in level.activeplayers) {
        player clientfield::set_player_uimodel("zmInventory.progress_egg", 0.4);
    }
    level.var_de98e3ce.var_44e7a938 = 3 + 2 * zm_utility::get_number_of_valid_players();
    level.var_de98e3ce.var_f22951fa = 0;
    level thread function_e8c061f7();
    level waittill(#"hash_68bf9f79");
    foreach (player in level.activeplayers) {
        player clientfield::set_player_uimodel("zmInventory.progress_egg", 0.6);
    }
    level.var_de98e3ce.var_661a78ea = 3 + 2 * zm_utility::get_number_of_valid_players();
    level.var_de98e3ce.var_56c226f4 = 0;
    level thread function_ba9bd748();
    level waittill(#"hash_b227a45b");
    foreach (player in level.activeplayers) {
        player clientfield::set_player_uimodel("zmInventory.progress_egg", 0.8);
    }
    level.var_de98e3ce.var_e97b0f0a = 3 + 2 * zm_utility::get_number_of_valid_players();
    level.var_de98e3ce.var_b57ab994 = 0;
    level thread function_cf16e2bc();
    level waittill(#"hash_9b46a273");
    foreach (player in level.activeplayers) {
        player clientfield::set_player_uimodel("zmInventory.progress_egg", 1);
    }
    var_e870a8ec = struct::get("gauntlet_incubation_start", "script_noteworthy");
    var_e870a8ec zm_unitrigger::create_unitrigger(undefined, 40, &function_cf2a342, &function_16907a63);
}

// Namespace namespace_9d455fc7
// Params 0, eflags: 0x1 linked
// Checksum 0xc7a827e7, Offset: 0x11b8
// Size: 0x172
function function_fa149742() {
    var_200dbf9d = getent("egg_drop_damage", "targetname");
    level flag::wait_till("dragon_pavlov_first_time");
    level scene::init("p7_fxanim_zm_stal_pavlov_boards_bundle");
    var_200dbf9d thread function_a3a149a9();
    level waittill(#"hash_698d88e1");
    var_9c840b49 = struct::get_array("dragon_egg_pickup", "targetname");
    foreach (var_21e43ff6 in var_9c840b49) {
        var_21e43ff6 zm_unitrigger::create_unitrigger(%ZM_STALINGRAD_EGG_PICKUP, 64, &function_61ab1070, &function_cee6cb2a);
    }
}

// Namespace namespace_9d455fc7
// Params 0, eflags: 0x1 linked
// Checksum 0xc3e5c081, Offset: 0x1338
// Size: 0x44
function function_a3a149a9() {
    self waittill(#"damage");
    level thread scene::play("p7_fxanim_zm_stal_pavlov_boards_bundle");
    self delete();
}

// Namespace namespace_9d455fc7
// Params 1, eflags: 0x1 linked
// Checksum 0xf0d671fa, Offset: 0x1388
// Size: 0x7a
function function_61ab1070(player) {
    if (level flag::get("dragon_egg_acquired")) {
        self sethintstring("");
        return 0;
    }
    self sethintstring(%ZM_STALINGRAD_EGG_PICKUP);
    return 1;
}

// Namespace namespace_9d455fc7
// Params 0, eflags: 0x1 linked
// Checksum 0xd46c2bc7, Offset: 0x1410
// Size: 0xa0
function function_cee6cb2a() {
    var_1b0f69b9 = 0;
    while (true) {
        self trigger::wait_till();
        if (!var_1b0f69b9) {
            var_1b0f69b9 = 1;
            self.who thread namespace_dcf9c464::function_44c4e12c();
        }
        level flag::set("dragon_egg_acquired");
        level thread function_9a76ebf9(self.stub);
    }
}

// Namespace namespace_9d455fc7
// Params 1, eflags: 0x1 linked
// Checksum 0xbf6e390e, Offset: 0x14b8
// Size: 0x13c
function function_9a76ebf9(s_stub) {
    var_e0c16f1a = getent("pavlov_boards_egg", "targetname");
    var_e0c16f1a delete();
    foreach (player in level.activeplayers) {
        player playsound("zmb_drag_egg_pickup");
        player clientfield::set_player_uimodel("zmInventory.piece_egg", 1);
        player thread namespace_f37770c8::function_97be99b3("zmInventory.piece_egg", "zmInventory.widget_egg", 0);
    }
    zm_unitrigger::unregister_unitrigger(s_stub);
}

// Namespace namespace_9d455fc7
// Params 0, eflags: 0x1 linked
// Checksum 0x5881c4e2, Offset: 0x1600
// Size: 0x13a
function function_5d1a6241() {
    level flag::wait_till("dragon_egg_acquired");
    level clientfield::set("force_stream_dragon_egg", 1);
    level.var_de98e3ce.var_9cd2418f = struct::get_array("egg_cook_loc");
    foreach (s_loc in level.var_de98e3ce.var_9cd2418f) {
        s_loc.var_a1914ebb = 0;
        s_loc zm_unitrigger::create_unitrigger(%ZM_STALINGRAD_EGG_PLACE, 32, &function_3e93cfea, &function_48a9eab7);
    }
}

// Namespace namespace_9d455fc7
// Params 1, eflags: 0x1 linked
// Checksum 0xc9f590f4, Offset: 0x1748
// Size: 0x1a0
function function_3e93cfea(e_player) {
    if (level flag::get("egg_awakened")) {
        self sethintstring("");
        return 0;
    }
    if (level flag::get("egg_cooled_hazard") && self.stub.related_parent.var_a1914ebb) {
        self sethintstring(%ZM_STALINGRAD_EGG_RETRIEVE);
        return 1;
    }
    if (level flag::get("egg_bathed_in_flame") && self.stub.related_parent.var_a1914ebb) {
        self sethintstring(%ZM_STALINGRAD_EGG_TOO_HOT);
        return 0;
    }
    if (level flag::get("dragon_egg_acquired") && !level flag::get("egg_placed_in_hazard")) {
        self sethintstring(%ZM_STALINGRAD_EGG_PLACE);
        return 1;
    }
    self sethintstring("");
    return 0;
}

// Namespace namespace_9d455fc7
// Params 0, eflags: 0x1 linked
// Checksum 0xa3f491dc, Offset: 0x18f0
// Size: 0x1b8
function function_48a9eab7() {
    while (true) {
        e_player = self waittill(#"trigger");
        if (!level flag::get("egg_placed_in_hazard")) {
            e_player clientfield::increment_to_player("interact_rumble");
            level flag::set("egg_placed_in_hazard");
            self.stub.related_parent.var_a1914ebb = 1;
            level.var_de98e3ce.var_d54b9ade.var_62ceb838 = util::spawn_model("p7_fxanim_zm_stal_dragon_incubator_egg_mod", self.stub.related_parent.origin + (0, 0, -40));
            level thread function_d0ba871e();
            level clientfield::set("force_stream_dragon_egg", 0);
            continue;
        }
        if (level flag::get("egg_cooled_hazard")) {
            e_player clientfield::increment_to_player("interact_rumble");
            level flag::set("egg_awakened");
            level thread function_2455dd71(self.stub);
        }
    }
}

// Namespace namespace_9d455fc7
// Params 0, eflags: 0x1 linked
// Checksum 0x133fc93, Offset: 0x1ab0
// Size: 0x14c
function function_d0ba871e() {
    foreach (player in level.activeplayers) {
        player clientfield::set_player_uimodel("zmInventory.piece_egg", 0);
    }
    level flag::wait_till("egg_bathed_in_flame");
    level.var_de98e3ce.var_d54b9ade.var_62ceb838 clientfield::set("dragon_egg_heat_fx", 1);
    level waittill(#"start_of_round");
    level waittill(#"end_of_round");
    level.var_de98e3ce.var_d54b9ade.var_62ceb838 clientfield::set("dragon_egg_heat_fx", 0);
    level flag::set("egg_cooled_hazard");
}

// Namespace namespace_9d455fc7
// Params 1, eflags: 0x1 linked
// Checksum 0xb3b89e02, Offset: 0x1c08
// Size: 0xdc
function function_2455dd71(s_stub) {
    level.var_de98e3ce.var_d54b9ade.var_62ceb838 delete();
    foreach (player in level.activeplayers) {
        player clientfield::set_player_uimodel("zmInventory.piece_egg", 1);
    }
    zm_unitrigger::unregister_unitrigger(s_stub);
}

// Namespace namespace_9d455fc7
// Params 0, eflags: 0x1 linked
// Checksum 0xe63357c5, Offset: 0x1cf0
// Size: 0x24
function function_e8c061f7() {
    zm_spawner::register_zombie_death_event_callback(&function_8d5fd156);
}

// Namespace namespace_9d455fc7
// Params 1, eflags: 0x1 linked
// Checksum 0x18837923, Offset: 0x1d20
// Size: 0x134
function function_8d5fd156(e_attacker) {
    if (!isdefined(self) || self.archetype === "sentinel_drone") {
        return;
    }
    if (!isplayer(e_attacker)) {
        if (isplayer(e_attacker.owner)) {
            e_attacker = e_attacker.owner;
        } else {
            return;
        }
    }
    if (self.var_9a02a614 === "napalm") {
        level.var_de98e3ce.var_f22951fa++;
        if (level.var_de98e3ce.var_f22951fa >= level.var_de98e3ce.var_44e7a938) {
            zm_spawner::deregister_zombie_death_event_callback(&function_8d5fd156);
            /#
                iprintlnbold("egg_cooled_incubator");
            #/
            level notify(#"hash_68bf9f79");
            level flag::set("gauntlet_step_2_complete");
        }
    }
}

// Namespace namespace_9d455fc7
// Params 0, eflags: 0x1 linked
// Checksum 0xf563c62d, Offset: 0x1e60
// Size: 0xcc
function function_ba9bd748() {
    foreach (player in level.players) {
        player function_5ae27dcc();
    }
    zm_spawner::register_zombie_death_event_callback(&function_4f6d5274);
    callback::on_connect(&function_5ae27dcc);
}

// Namespace namespace_9d455fc7
// Params 0, eflags: 0x1 linked
// Checksum 0xbdddfcec, Offset: 0x1f38
// Size: 0xe
function function_5ae27dcc() {
    self.var_da98b8a4 = undefined;
}

// Namespace namespace_9d455fc7
// Params 1, eflags: 0x1 linked
// Checksum 0x67db2dce, Offset: 0x1f50
// Size: 0x178
function function_4f6d5274(e_attacker) {
    if (!isdefined(self) || self.archetype === "sentinel_drone") {
        return;
    }
    if (isplayer(e_attacker)) {
        if (self.damagemod === "MOD_PISTOL_BULLET" || isdefined(self.damageweapon) && self.damagemod === "MOD_RIFLE_BULLET") {
            if (isdefined(e_attacker.var_da98b8a4)) {
                if (e_attacker.var_da98b8a4 == e_attacker._bbdata["shots"]) {
                    level.var_de98e3ce.var_56c226f4++;
                    if (level.var_de98e3ce.var_56c226f4 >= level.var_de98e3ce.var_661a78ea) {
                        /#
                            iprintlnbold("egg_cooled_incubator");
                        #/
                        zm_spawner::deregister_zombie_death_event_callback(&function_4f6d5274);
                        level notify(#"hash_b227a45b");
                        level flag::set("gauntlet_step_3_complete");
                    }
                }
            }
            e_attacker.var_da98b8a4 = e_attacker._bbdata["shots"];
        }
    }
}

// Namespace namespace_9d455fc7
// Params 0, eflags: 0x1 linked
// Checksum 0x9d016b3e, Offset: 0x20d0
// Size: 0x24
function function_cf16e2bc() {
    zm_spawner::register_zombie_death_event_callback(&function_f2988f0a);
}

// Namespace namespace_9d455fc7
// Params 0, eflags: 0x1 linked
// Checksum 0x8ff9fd4d, Offset: 0x2100
// Size: 0x11c
function function_f2988f0a() {
    if (!isdefined(self) || self.archetype === "sentinel_drone") {
        return;
    }
    e_attacker = self.attacker;
    if (isplayer(e_attacker)) {
        if (function_efaf3bd6(self.damageweapon, self.damagemod)) {
            level.var_de98e3ce.var_b57ab994++;
            if (level.var_de98e3ce.var_b57ab994 >= level.var_de98e3ce.var_e97b0f0a) {
                /#
                    iprintlnbold("egg_cooled_incubator");
                #/
                level notify(#"hash_9b46a273");
                zm_spawner::deregister_zombie_death_event_callback(&function_f2988f0a);
                level flag::set("gauntlet_step_4_complete");
            }
        }
    }
}

// Namespace namespace_9d455fc7
// Params 2, eflags: 0x1 linked
// Checksum 0xf65ad947, Offset: 0x2228
// Size: 0x72
function function_efaf3bd6(var_da90aa4c, str_damagemod) {
    if (str_damagemod === "MOD_MELEE") {
        return 1;
    }
    if (var_da90aa4c.name === "dragonshield" || var_da90aa4c.name === "dragonshield_upgraded") {
        return 1;
    }
    return 0;
}

// Namespace namespace_9d455fc7
// Params 1, eflags: 0x1 linked
// Checksum 0x300856db, Offset: 0x22a8
// Size: 0x98
function function_cf2a342(player) {
    if (!level flag::get("egg_placed_incubator") && !level flag::get("gauntlet_quest_complete")) {
        self sethintstring(%ZM_STALINGRAD_EGG_INCUBATE);
        return 1;
    }
    self sethintstring("");
    return 0;
}

// Namespace namespace_9d455fc7
// Params 0, eflags: 0x1 linked
// Checksum 0xad179b10, Offset: 0x2348
// Size: 0xc0
function function_16907a63() {
    var_ad33206 = 0;
    while (!level flag::get("lockdown_active")) {
        self trigger::wait_till();
        if (!var_ad33206) {
            var_ad33206 = 1;
            self.who thread namespace_dcf9c464::function_e068138();
        }
        level flag::set("egg_placed_incubator");
        level thread function_59a929b0(self.stub.related_parent);
    }
}

// Namespace namespace_9d455fc7
// Params 1, eflags: 0x1 linked
// Checksum 0x286bcbb9, Offset: 0x2410
// Size: 0x7b4
function function_59a929b0(s_stub) {
    var_734c1c5a = getent("dragon_incubator", "targetname");
    var_734c1c5a thread scene::play("p7_fxanim_zm_stal_dragon_incubator_bundle");
    level.var_de98e3ce.var_a6563820 = 7 + 6 * zm_utility::get_number_of_valid_players();
    level.var_c2c83bb6 = spawnstruct();
    level.var_de98e3ce.var_d54b9ade = s_stub;
    level.var_de98e3ce.var_312cd3bc = 1;
    var_2bf0ed11 = getentarray("pavlov_gate_collision", "targetname");
    var_50e0150f = getentarray("pavlov_gate_visual", "targetname");
    var_6f3f4356 = getnodearray("pavlovs_lockdown_stair_traverse", "targetname");
    foreach (e_collision in var_2bf0ed11) {
        e_collision solid();
        e_collision disconnectpaths();
    }
    foreach (e_gate in var_50e0150f) {
        e_gate movez(600, 0.25);
    }
    foreach (var_b0a376a4 in var_6f3f4356) {
        unlinktraversal(var_b0a376a4);
    }
    var_ff1b68c0 = getent("pavlovs_sewer_door", "targetname");
    var_ff1b68c0 movey(-84, 1);
    level thread namespace_48c05c81::function_2f621485();
    level thread scene::play("p7_fxanim_zm_stal_sewer_gate_down_bundle");
    level thread namespace_48c05c81::function_e7c75cf0();
    level flag::set("lockdown_active");
    util::wait_network_frame();
    level.var_de98e3ce.var_d54b9ade.var_62ceb838 = getent("dragon_incubator_egg", "targetname");
    level.var_de98e3ce.var_d54b9ade.var_62ceb838 clientfield::increment("dragon_egg_placed", 1);
    level.var_c2c83bb6.var_b372c418 = struct::get_array("pavlovs_B_spawn", "targetname");
    a_s_spawners = struct::get_array("pavlovs_A_spawn", "targetname");
    level.var_c2c83bb6.var_b372c418 = arraycombine(level.var_c2c83bb6.var_b372c418, a_s_spawners, 0, 0);
    level thread namespace_48c05c81::function_3804dbf1();
    namespace_48c05c81::function_adf4d1d0();
    level function_fd19472b();
    level thread namespace_dcf9c464::function_e4acaa37("vox_soph_whelp_quest_lockdown_end_0");
    var_734c1c5a scene::play("p7_fxanim_zm_stal_dragon_incubator_finish_bundle");
    foreach (e_collision in var_2bf0ed11) {
        e_collision notsolid();
        e_collision connectpaths();
    }
    foreach (e_gate in var_50e0150f) {
        e_gate movez(-600, 0.25);
    }
    foreach (var_b0a376a4 in var_6f3f4356) {
        linktraversal(var_b0a376a4);
    }
    var_ff1b68c0 movey(84, 1);
    var_21ce8765 = getent("sewer_gate", "targetname");
    var_21ce8765 thread scene::play("p7_fxanim_zm_stal_sewer_gate_up_bundle");
    level namespace_48c05c81::function_2f621485(0);
    wait(5);
    level thread namespace_48c05c81::function_3804dbf1(0);
    level flag::clear("lockdown_active");
}

// Namespace namespace_9d455fc7
// Params 0, eflags: 0x1 linked
// Checksum 0x1d3aa4ca, Offset: 0x2bd0
// Size: 0xbc
function function_91191904() {
    self endon(#"death");
    self setphysparams(15, 0, 72);
    self.ignore_enemy_count = 1;
    self.deathpoints_already_given = 1;
    self.exclude_cleanup_adding_to_total = 1;
    self.var_edfdda83 = 1;
    util::wait_network_frame();
    if (self.zombie_move_speed === "walk") {
        self zombie_utility::set_zombie_run_cycle("run");
    }
    self.nocrawler = 1;
    self thread function_dcc4fd22();
}

// Namespace namespace_9d455fc7
// Params 0, eflags: 0x1 linked
// Checksum 0x3dac35cd, Offset: 0x2c98
// Size: 0x1c4
function function_dcc4fd22() {
    level endon(#"hash_917b3ab2");
    self waittill(#"death");
    if (isdefined(self.var_4d11bb60) && self.var_4d11bb60) {
        return;
    }
    if (isplayer(self.attacker)) {
        e_player = self.attacker;
    } else {
        return;
    }
    if (isdefined(level.var_de98e3ce.var_d54b9ade)) {
        var_21e43ff6 = level.var_de98e3ce.var_d54b9ade;
    } else {
        return;
    }
    e_goal = getent("basement_lockdown_score", "targetname");
    if (self istouching(e_goal)) {
        self clientfield::increment("dragon_egg_score_beam_fx", 1);
        level.var_de98e3ce.var_179b5b71++;
        if (level.var_de98e3ce.var_179b5b71 >= level.var_de98e3ce.var_a6563820 && level.var_de98e3ce.var_312cd3bc) {
            level.var_de98e3ce.var_312cd3bc = 0;
            level thread function_77c54581();
        }
        println("egg_cooled_incubator" + level.var_de98e3ce.var_179b5b71 + "egg_cooled_incubator" + level.var_de98e3ce.var_a6563820);
    }
}

// Namespace namespace_9d455fc7
// Params 0, eflags: 0x1 linked
// Checksum 0xf304a90c, Offset: 0x2e68
// Size: 0x144
function function_77c54581() {
    var_21e43ff6 = level.var_de98e3ce.var_d54b9ade;
    level.var_de98e3ce.var_987fcd7a = 1;
    var_21e43ff6 zm_unitrigger::create_unitrigger(%ZM_STALINGRAD_EGG_RETRIEVE, 40, &function_86e242);
    level notify(#"hash_8c192d5a");
    level.var_de98e3ce.var_d54b9ade.var_62ceb838 clientfield::set("dragon_egg_heat_fx", 1);
    level waittill(#"start_of_round");
    level waittill(#"end_of_round");
    level.var_de98e3ce.var_d54b9ade.var_62ceb838 clientfield::set("dragon_egg_heat_fx", 0);
    level flag::set("egg_cooled_incubator");
    var_21e43ff6 thread function_d29c33e();
    level thread namespace_dcf9c464::function_e4acaa37("vox_soph_whelp_quest_incubation_complete_0");
}

// Namespace namespace_9d455fc7
// Params 0, eflags: 0x1 linked
// Checksum 0x7326402c, Offset: 0x2fb8
// Size: 0x57c
function function_fd19472b() {
    var_d98b610d = level.zombie_spawners[0];
    var_d9a44c63 = struct::get_array("basement_lockdown_spawn", "targetname");
    for (i = 0; i < var_d9a44c63.size; i++) {
        if (!isdefined(level.var_c2c83bb6.var_b372c418)) {
            level.var_c2c83bb6.var_b372c418 = [];
        } else if (!isarray(level.var_c2c83bb6.var_b372c418)) {
            level.var_c2c83bb6.var_b372c418 = array(level.var_c2c83bb6.var_b372c418);
        }
        level.var_c2c83bb6.var_b372c418[level.var_c2c83bb6.var_b372c418.size] = var_d9a44c63[i];
    }
    var_73844a4a = struct::get_array("pavlovs_A_spawn");
    for (i = 0; i < var_73844a4a.size; i++) {
        if (var_73844a4a[i].script_noteworthy == "sentinel_location") {
            if (!isdefined(level.var_c2c83bb6.var_73844a4a)) {
                level.var_c2c83bb6.var_73844a4a = [];
            } else if (!isarray(level.var_c2c83bb6.var_73844a4a)) {
                level.var_c2c83bb6.var_73844a4a = array(level.var_c2c83bb6.var_73844a4a);
            }
            level.var_c2c83bb6.var_73844a4a[level.var_c2c83bb6.var_73844a4a.size] = var_73844a4a[i];
        }
    }
    var_19494298 = [];
    for (i = 0; i < level.var_c2c83bb6.var_b372c418.size; i++) {
        if (level.var_c2c83bb6.var_b372c418[i].script_noteworthy == "spawn_location" || level.var_c2c83bb6.var_b372c418[i].script_noteworthy == "riser_location") {
            if (!isdefined(var_19494298)) {
                var_19494298 = [];
            } else if (!isarray(var_19494298)) {
                var_19494298 = array(var_19494298);
            }
            var_19494298[var_19494298.size] = level.var_c2c83bb6.var_b372c418[i];
        }
    }
    level.var_c2c83bb6.var_4eb67098 = 0;
    level.var_c2c83bb6.var_d5abe4af = 1;
    var_5c17f194 = level.zombie_vars["zombie_spawn_delay"];
    level thread function_f4ceb3f8();
    level thread function_1a7c9b89("basement");
    for (var_389695f2 = 1; var_389695f2; var_389695f2 = 0) {
        a_ai_zombies = getaiteamarray(level.zombie_team);
        if (a_ai_zombies.size >= level.zombie_ai_limit) {
            wait(0.1);
            continue;
        }
        s_spawn_point = array::random(var_19494298);
        ai = zombie_utility::spawn_zombie(var_d98b610d, "lockdown_zombie", s_spawn_point);
        if (isdefined(ai)) {
            ai thread function_91191904();
        }
        if (namespace_8bc21961::function_41375d48() < level.var_c2c83bb6.var_d5abe4af && !level flag::get("basement_sentinel_wait")) {
            wait(var_5c17f194);
            var_4bf80f4b = array::random(level.var_c2c83bb6.var_73844a4a);
            level namespace_8bc21961::function_19d0b055(undefined, undefined, 1, var_4bf80f4b);
            level thread function_f621bb41();
        }
        wait(var_5c17f194);
        if (level.var_de98e3ce.var_179b5b71 >= level.var_de98e3ce.var_a6563820) {
        }
    }
    level notify(#"hash_917b3ab2");
    namespace_48c05c81::function_adf4d1d0();
}

// Namespace namespace_9d455fc7
// Params 0, eflags: 0x1 linked
// Checksum 0x25307f43, Offset: 0x3540
// Size: 0x44
function function_f621bb41() {
    level flag::set("basement_sentinel_wait");
    wait(13);
    level flag::clear("basement_sentinel_wait");
}

// Namespace namespace_9d455fc7
// Params 1, eflags: 0x1 linked
// Checksum 0x19284137, Offset: 0x3590
// Size: 0x19a
function function_1a7c9b89(var_a48df19e) {
    var_604d90e0 = getentarray("lockdown_lights_" + var_a48df19e, "targetname");
    foreach (e_light in var_604d90e0) {
        e_light fx::play("pavlov_lockdown_light", e_light.origin, e_light.angles, "lockdown_complete", 1);
    }
    level flag::wait_till("lockdown_complete");
    foreach (e_light in var_604d90e0) {
        e_light notify(#"hash_1222c20a");
        e_light kill();
    }
}

// Namespace namespace_9d455fc7
// Params 0, eflags: 0x1 linked
// Checksum 0xc4c02568, Offset: 0x3738
// Size: 0x5c
function function_f4ceb3f8() {
    for (var_524f5a91 = 0; var_524f5a91 <= 3; var_524f5a91++) {
        playsoundatposition("evt_lockdown_alarm", (-159, 1959, 793));
        wait(1);
    }
}

// Namespace namespace_9d455fc7
// Params 1, eflags: 0x1 linked
// Checksum 0x29e38001, Offset: 0x37a0
// Size: 0x118
function function_86e242(e_player) {
    var_21e43ff6 = level.var_de98e3ce.var_d54b9ade;
    if (!isdefined(var_21e43ff6)) {
        self sethintstring("");
        return 0;
    }
    if (!level flag::get("egg_cooled_incubator")) {
        self sethintstring(%ZM_STALINGRAD_EGG_TOO_HOT);
        return 0;
    }
    if (level.var_de98e3ce.var_987fcd7a && !level flag::get("gauntlet_quest_complete")) {
        self sethintstring(%ZM_STALINGRAD_EGG_RETRIEVE);
        return 1;
    }
    self sethintstring("");
    return 0;
}

// Namespace namespace_9d455fc7
// Params 0, eflags: 0x1 linked
// Checksum 0x1853c2e0, Offset: 0x38c0
// Size: 0x144
function function_d29c33e() {
    self waittill(#"trigger_activated");
    self.var_62ceb838 delete();
    zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
    level flag::set("gauntlet_quest_complete");
    foreach (e_player in level.activeplayers) {
        e_player flag::set("flag_player_completed_challenge_4");
        level scoreevents::processscoreevent("team_challenge_stalingrad", e_player);
    }
    /#
        iprintlnbold("egg_cooled_incubator");
    #/
    self struct::delete();
}

