#using scripts/cp/cp_mi_sing_vengeance_sound;
#using scripts/cp/cp_mi_sing_vengeance_util;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/turret_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicles/_quadtank;
#using scripts/shared/stealth_status;
#using scripts/shared/stealth;
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
#using scripts/shared/colors_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_6f44bbbf;

// Namespace namespace_6f44bbbf
// Params 2, eflags: 0x1 linked
// Checksum 0x36fa57e4, Offset: 0x9f0
// Size: 0x1f4
function function_f9314d0e(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_63b4601c::function_b87f9c13(str_objective, var_74cd64bc);
        namespace_63b4601c::function_66773296("hendricks", str_objective);
        callback::on_spawned(&namespace_63b4601c::give_hero_weapon);
        level.quadtank_alley_intro_org = struct::get("quadtank_alley_intro_org");
        level.quadtank_alley_intro_org thread scene::skipto_end("cin_ven_04_30_quadalleydoor_1st");
        spawner::add_spawn_function_group("quadteaser_qt", "script_noteworthy", &function_5c60b4ee);
        level thread function_32620a97();
        namespace_63b4601c::function_e00864bd("dogleg_1_umbra_gate", 1, "dogleg_1_gate");
        objectives::set("cp_level_vengeance_rescue_kane");
        objectives::set("cp_level_vengeance_go_to_safehouse");
        objectives::hide("cp_level_vengeance_go_to_safehouse");
        level thread objectives::breadcrumb("trig_quadtank_alley_obj");
        load::function_a2995f22();
    }
    level thread namespace_63b4601c::function_cc6f3598();
    level thread namespace_63b4601c::function_3f34106b();
    function_3e0e217e(str_objective, var_74cd64bc);
}

// Namespace namespace_6f44bbbf
// Params 2, eflags: 0x1 linked
// Checksum 0x91cf7fbf, Offset: 0xbf0
// Size: 0x84
function function_3e0e217e(str_objective, var_74cd64bc) {
    level flag::set("quadtank_alley_begin");
    level thread function_c231d685();
    level thread function_c58f9e9a();
    level.var_2fd26037 thread function_cad683c(var_74cd64bc);
}

// Namespace namespace_6f44bbbf
// Params 0, eflags: 0x1 linked
// Checksum 0x36f9336b, Offset: 0xc80
// Size: 0xb4
function function_c231d685() {
    level flag::wait_till("move_quadtank_alley_hendricks_node_10");
    savegame::checkpoint_save();
    wait 2;
    level.var_9c196273 = struct::get("quadtank_alley_breadcrumb_02");
    objectives::set("cp_level_vengeance_goto_quadtank_alley_rooftop", level.var_9c196273);
    level flag::wait_till("quadtank_alley_rooftop");
    objectives::hide("cp_level_vengeance_goto_quadtank_alley_rooftop");
}

// Namespace namespace_6f44bbbf
// Params 0, eflags: 0x1 linked
// Checksum 0x521a6c4b, Offset: 0xd40
// Size: 0xe4
function function_32620a97() {
    var_35a1e4f8 = struct::get("quadteaser_org", "targetname");
    trigger::wait_till("qt_alley_init");
    var_35a1e4f8 thread scene::init("cin_ven_04_40_quadteaser_vign_start");
    trigger::wait_till("qt_alley_play");
    var_35a1e4f8 thread scene::play("cin_ven_04_40_quadteaser_vign_start");
    e_trigger = getent("qt_alley_init", "targetname");
    e_trigger delete();
}

// Namespace namespace_6f44bbbf
// Params 0, eflags: 0x1 linked
// Checksum 0x18742f7, Offset: 0xe30
// Size: 0x1b4
function function_5c60b4ee() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self vehicle_ai::start_scripted(1);
    self util::magic_bullet_shield();
    self.var_4e5b312b = 0;
    self quadtank::function_4c6ee4cc(0);
    vehicle_ai::turnoffalllightsandlaser();
    vehicle_ai::turnoffallambientanims();
    self vehicle::toggle_tread_fx(0);
    self vehicle::toggle_exhaust_fx(0);
    angles = self gettagangles("tag_flash");
    target_vec = self.origin + anglestoforward((0, angles[1], 0)) * 1000;
    target_vec += (0, 0, -500);
    self function_63f13a8e(target_vec);
    if (!isdefined(self.emped)) {
        self disableaimassist();
    }
    self thread function_5b72d473();
}

// Namespace namespace_6f44bbbf
// Params 0, eflags: 0x1 linked
// Checksum 0x8a1d8786, Offset: 0xff0
// Size: 0x3c
function function_5b72d473() {
    self endon(#"death");
    self thread function_958f5757();
    self thread function_cf5fc4c7();
}

// Namespace namespace_6f44bbbf
// Params 0, eflags: 0x1 linked
// Checksum 0xb2f15d44, Offset: 0x1038
// Size: 0x80
function function_958f5757() {
    self endon(#"death");
    while (true) {
        self waittillmatch(#"qt_fire_missile");
        level util::clientnotify("qt_fire_missile");
        thread cp_mi_sing_vengeance_sound::function_b3768e28();
        thread cp_mi_sing_vengeance_sound::function_2afbdce();
        self fireweapon(0);
    }
}

// Namespace namespace_6f44bbbf
// Params 0, eflags: 0x1 linked
// Checksum 0xa2a44df6, Offset: 0x10c0
// Size: 0x122
function function_cf5fc4c7() {
    self endon(#"death");
    while (true) {
        self waittillmatch(#"hash_870f582c");
        level util::clientnotify("qt_fire_mg");
        self playloopsound("wpn_qt_mg_loop");
        thread cp_mi_sing_vengeance_sound::function_2afbdce();
        self thread turret::fire_for_time(-1, 1);
        self thread turret::fire_for_time(-1, 2);
        self waittillmatch(#"hash_c6db257a");
        playsoundatposition("wpn_qt_mg_tail", self.origin);
        self stoploopsound(0.2);
        self notify(#"hash_c7d626");
        self notify(#"hash_dac55bbd");
    }
}

// Namespace namespace_6f44bbbf
// Params 1, eflags: 0x1 linked
// Checksum 0x60fb0eed, Offset: 0x11f0
// Size: 0x18c
function function_cad683c(var_74cd64bc) {
    self endon(#"death");
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self colors::disable();
    self ai::set_behavior_attribute("cqb", 1);
    self.goalradius = 32;
    self battlechatter::function_d9f49fba(0);
    level thread function_5a90d7e8(var_74cd64bc);
    node = getnode("quadtank_alley_hendricks_node_05", "targetname");
    self thread ai::force_goal(node, node.radius);
    level flag::wait_till("move_quadtank_alley_hendricks_node_10");
    self ai::set_behavior_attribute("cqb", 0);
    node = getnode("quadtank_alley_hendricks_node_10", "targetname");
    self thread ai::force_goal(node, node.radius);
}

// Namespace namespace_6f44bbbf
// Params 0, eflags: 0x1 linked
// Checksum 0xe065026a, Offset: 0x1388
// Size: 0x90
function function_c58f9e9a() {
    e_trigger = getent("kill_qt_alley_light", "targetname");
    while (isdefined(e_trigger)) {
        e_other = e_trigger waittill(#"trigger");
        if (isplayer(e_other)) {
            e_other clientfield::set_to_player("kill_qt_alley_light", 1);
        }
    }
}

// Namespace namespace_6f44bbbf
// Params 0, eflags: 0x1 linked
// Checksum 0xec9d3d07, Offset: 0x1420
// Size: 0x34
function function_323d0a39() {
    level.var_2fd26037 waittill(#"plyr_you_okay_hendricks_1");
    level dialog::function_13b3b16a("plyr_you_okay_hendricks_1");
}

// Namespace namespace_6f44bbbf
// Params 1, eflags: 0x1 linked
// Checksum 0x52936af5, Offset: 0x1460
// Size: 0x8c
function function_5a90d7e8(var_74cd64bc) {
    if (!isdefined(var_74cd64bc) || var_74cd64bc == 0) {
        level waittill(#"hash_ba467a50");
    }
    level flag::wait_till("move_quadtank_alley_hendricks_node_10");
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_something_big_headed_0");
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_quick_get_to_the_roo_0");
}

// Namespace namespace_6f44bbbf
// Params 4, eflags: 0x1 linked
// Checksum 0x6293f53, Offset: 0x14f8
// Size: 0x3c4
function function_1dc027c8(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level flag::set("quadtank_alley_end");
    level util::clientnotify("qt_alley_done");
    level thread function_bc3427d9();
    level struct::function_368120a1("scene", "cin_ven_03_20_storelineup_vign_start_doors_only");
    level struct::function_368120a1("scene", "cin_ven_03_20_storelineup_vign_exit");
    level struct::function_368120a1("scene", "cin_ven_03_20_storelineup_vign_exit_reach");
    level struct::function_368120a1("scene", "cin_ven_04_30_quadalleydoor_1st");
    level struct::function_368120a1("scene", "cin_ven_04_40_quadteaser_vign_start");
    level struct::function_368120a1("scene", "cin_ven_04_20_cafeexecution_vign_intro");
    level struct::function_368120a1("scene", "cin_ven_04_20_cafeexecution_vign_kill");
    level struct::function_368120a1("scene", "cin_ven_04_20_cafeexecution_vign_esc");
    level struct::function_368120a1("scene", "cin_ven_04_20_cafeburning_vign_esc_civ_01");
    level struct::function_368120a1("scene", "cin_ven_04_20_cafeburning_vign_esc_civ_02");
    level struct::function_368120a1("scene", "cin_ven_04_20_cafeburning_vign_esc_civ_03");
    level struct::function_368120a1("scene", "cin_ven_04_20_cafeburning_vign_loop");
    level struct::function_368120a1("scene", "cin_ven_04_20_cafeburning_vign_main");
    level struct::function_368120a1("scene", "cin_ven_04_20_cafemolotovflush_vign_intro");
    level struct::function_368120a1("scene", "cin_ven_04_20_cafemolotovflush_vign_civa");
    level struct::function_368120a1("scene", "cin_ven_04_20_cafemolotovflush_vign_civb");
    level struct::function_368120a1("scene", "cin_ven_04_20_cafemolotovflush_vign_civc");
    level struct::function_368120a1("scene", "cin_ven_04_20_cafemolotovflush_vign_civd");
    level struct::function_368120a1("scene", "cin_ven_04_20_cafemolotovflush_vign_cive");
    level struct::function_368120a1("scene", "cin_ven_04_20_cafemolotovflush_vign_civf");
    level struct::function_368120a1("scene", "cin_ven_04_20_cafemolotovflush_vign_civg");
}

// Namespace namespace_6f44bbbf
// Params 0, eflags: 0x1 linked
// Checksum 0x77f50388, Offset: 0x18c8
// Size: 0x34
function function_bc3427d9() {
    array::run_all(getcorpsearray(), &delete);
}

