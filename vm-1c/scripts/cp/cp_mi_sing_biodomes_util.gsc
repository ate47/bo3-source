#using scripts/cp/_objectives;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/shared/ai/archetype_warlord_interface;
#using scripts/shared/ai/warlord;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/teamgather_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace cp_mi_sing_biodomes_util;

/#

    // Namespace cp_mi_sing_biodomes_util
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb1513ff6, Offset: 0x6d0
    // Size: 0x34
    function function_ddb0eeea(msg) {
        println("<dev string:x28>" + msg);
    }

#/

// Namespace cp_mi_sing_biodomes_util
// Params 1, eflags: 0x1 linked
// Checksum 0x5245256d, Offset: 0x710
// Size: 0x84
function function_bff1a867(str_objective) {
    level.var_2fd26037 = util::function_740f8516("hendricks");
    level.var_2fd26037 flag::init("hendricks_on_zipline");
    level.var_2fd26037 setthreatbiasgroup("heroes");
    skipto::teleport_ai(str_objective);
}

// Namespace cp_mi_sing_biodomes_util
// Params 1, eflags: 0x1 linked
// Checksum 0xf7cd0514, Offset: 0x7a0
// Size: 0x13c
function function_1c1462ee(var_2c617722) {
    if (!spawn_manager::is_killed(var_2c617722) && spawn_manager::is_enabled(var_2c617722)) {
        a_enemies = spawn_manager::function_423eae50(var_2c617722);
        if (isdefined(a_enemies)) {
            foreach (ai in a_enemies) {
                ai util::stop_magic_bullet_shield();
                ai kill();
            }
        }
        if (!spawn_manager::is_killed(var_2c617722)) {
            spawn_manager::kill(var_2c617722);
        }
    }
}

// Namespace cp_mi_sing_biodomes_util
// Params 2, eflags: 0x0
// Checksum 0xc6b11af8, Offset: 0x8e8
// Size: 0x102
function function_54d82960(str_group, b_enable) {
    a_triggers = getentarray(str_group, "script_noteworthy");
    assert(isdefined(a_triggers), str_group + "<dev string:x36>");
    if (isdefined(a_triggers)) {
        foreach (trigger in a_triggers) {
            trigger triggerenable(b_enable);
        }
    }
}

// Namespace cp_mi_sing_biodomes_util
// Params 3, eflags: 0x1 linked
// Checksum 0x1906a8a9, Offset: 0x9f8
// Size: 0xca
function function_a22e7052(b_enable, str_name, str_key) {
    var_c42a21af = getnodearray(str_name, str_key);
    foreach (node in var_c42a21af) {
        setenablenode(node, b_enable);
    }
}

// Namespace cp_mi_sing_biodomes_util
// Params 1, eflags: 0x1 linked
// Checksum 0x3355764b, Offset: 0xad0
// Size: 0x22
function function_7ff50323(var_2d3d7b7) {
    return array::random(var_2d3d7b7);
}

// Namespace cp_mi_sing_biodomes_util
// Params 1, eflags: 0x1 linked
// Checksum 0xcd8776db, Offset: 0xb00
// Size: 0x22c
function function_7aa89143(n_duration) {
    if (!isdefined(n_duration)) {
        n_duration = 1;
    }
    self endon(#"death");
    var_5dc93b8f = self getcurrentweapon();
    var_bd901adc = getweapon("syrette");
    self giveweapon(var_bd901adc);
    self switchtoweapon(var_bd901adc);
    self setweaponammostock(var_bd901adc, 1);
    self disableweaponfire();
    self disableweaponcycling();
    self disableusability();
    self disableoffhandweapons();
    wait n_duration;
    self takeweapon(var_bd901adc);
    self enableweaponfire();
    self enableweaponcycling();
    self enableusability();
    self enableoffhandweapons();
    if (self hasweapon(var_5dc93b8f)) {
        self switchtoweapon(var_5dc93b8f);
        return;
    }
    primaryweapons = self getweaponslistprimaries();
    if (isdefined(primaryweapons) && primaryweapons.size > 0) {
        self switchtoweapon(primaryweapons[0]);
    }
}

// Namespace cp_mi_sing_biodomes_util
// Params 3, eflags: 0x1 linked
// Checksum 0x71a266a1, Offset: 0xd38
// Size: 0xea
function function_f61c0df8(var_e39815ad, n_time_min, n_time_max) {
    var_91efa0da = getnodearray(var_e39815ad, "targetname");
    foreach (node in var_91efa0da) {
        self namespace_69ee7109::function_da308a83(node.origin, n_time_min * 1000, n_time_max * 1000);
    }
}

// Namespace cp_mi_sing_biodomes_util
// Params 4, eflags: 0x1 linked
// Checksum 0xef2aab5a, Offset: 0xe30
// Size: 0x94
function function_a1669688(str_aigroup, str_volume, n_delay_min, n_delay_max) {
    if (!isdefined(n_delay_min)) {
        n_delay_min = 0;
    }
    if (!isdefined(n_delay_max)) {
        n_delay_max = 0;
    }
    a_enemies = spawner::get_ai_group_ai(str_aigroup);
    if (isdefined(a_enemies)) {
        a_enemies function_5f83cbd0(str_volume, n_delay_min, n_delay_max);
    }
}

// Namespace cp_mi_sing_biodomes_util
// Params 3, eflags: 0x1 linked
// Checksum 0x99be592e, Offset: 0xed0
// Size: 0x172
function function_5f83cbd0(str_volume, n_delay_min, n_delay_max) {
    if (!isdefined(n_delay_min)) {
        n_delay_min = 0;
    }
    if (!isdefined(n_delay_max)) {
        n_delay_max = 0;
    }
    volume = getent(str_volume, "targetname");
    assert(isdefined(volume), "<dev string:x72>" + str_volume + "<dev string:x7f>");
    if (isdefined(volume)) {
        foreach (ai in self) {
            if (isalive(ai)) {
                ai setgoal(volume, 1);
            }
            if (n_delay_max > n_delay_min) {
                wait randomfloatrange(n_delay_min, n_delay_max);
            }
        }
    }
}

// Namespace cp_mi_sing_biodomes_util
// Params 1, eflags: 0x1 linked
// Checksum 0x43e12498, Offset: 0x1050
// Size: 0x49e
function function_753a859(str_objective) {
    switch (str_objective) {
    case "objective_igc":
        hidemiscmodels("fxanim_nursery");
        hidemiscmodels("fxanim_markets2");
        hidemiscmodels("fxanim_warehouse");
        hidemiscmodels("fxanim_cloud_mountain");
        break;
    case "objective_markets_start":
        hidemiscmodels("fxanim_nursery");
        hidemiscmodels("fxanim_markets2");
        hidemiscmodels("fxanim_warehouse");
        hidemiscmodels("fxanim_cloud_mountain");
        break;
    case "objective_markets_rpg":
        hidemiscmodels("fxanim_warehouse");
        hidemiscmodels("fxanim_cloud_mountain");
        break;
    case "objective_markets2_start":
        hidemiscmodels("fxanim_cloud_mountain");
        break;
    case "objective_warehouse":
        hidemiscmodels("fxanim_party_house");
        break;
    case "objective_cloudmountain":
        hidemiscmodels("fxanim_party_house");
        hidemiscmodels("fxanim_markets1");
        hidemiscmodels("fxanim_nursery");
        break;
    case "objective_cloudmountain_level_2":
        hidemiscmodels("fxanim_party_house");
        hidemiscmodels("fxanim_markets1");
        hidemiscmodels("fxanim_nursery");
        hidemiscmodels("fxanim_markets2");
        hidemiscmodels("fxanim_warehouse");
        break;
    case "objective_turret_hallway":
        hidemiscmodels("fxanim_party_house");
        hidemiscmodels("fxanim_markets1");
        hidemiscmodels("fxanim_nursery");
        hidemiscmodels("fxanim_markets2");
        hidemiscmodels("fxanim_warehouse");
        break;
    case "objective_xiulan_vignette":
        hidemiscmodels("fxanim_party_house");
        hidemiscmodels("fxanim_markets1");
        hidemiscmodels("fxanim_nursery");
        hidemiscmodels("fxanim_markets2");
        hidemiscmodels("fxanim_warehouse");
        break;
    case "objective_server_room_defend":
        hidemiscmodels("fxanim_party_house");
        hidemiscmodels("fxanim_markets1");
        hidemiscmodels("fxanim_nursery");
        hidemiscmodels("fxanim_markets2");
        hidemiscmodels("fxanim_warehouse");
        break;
    case "objective_fighttothedome":
        hidemiscmodels("fxanim_party_house");
        hidemiscmodels("fxanim_markets1");
        hidemiscmodels("fxanim_nursery");
        hidemiscmodels("fxanim_markets2");
        hidemiscmodels("fxanim_warehouse");
        hidemiscmodels("fxanim_cloud_mountain");
        break;
    }
}

// Namespace cp_mi_sing_biodomes_util
// Params 0, eflags: 0x1 linked
// Checksum 0xd3e8b52c, Offset: 0x14f8
// Size: 0xf4
function function_d28654c9() {
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    }
    var_e1e06c8 = getcharacterbodystyleindex(0, "CPUI_OUTFIT_BIODOMES");
    if (self ishost()) {
        if (self getdstat("highestMapReached") <= getmaporder("cp_mi_sing_biodomes")) {
            self setcharacterbodystyle(var_e1e06c8);
        }
        return;
    }
    if (!self getdstat("PlayerStatsByMap", "cp_mi_sing_biodomes", "hasBeenCompleted")) {
        self setcharacterbodystyle(var_e1e06c8);
    }
}

// Namespace cp_mi_sing_biodomes_util
// Params 2, eflags: 0x1 linked
// Checksum 0x447e3411, Offset: 0x15f8
// Size: 0x144
function function_cc20e187(str_area, var_da49671a) {
    if (!isdefined(var_da49671a)) {
        var_da49671a = 0;
    }
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    }
    var_9108873 = getent("trig_out_of_bound_" + str_area, "targetname");
    e_clip = getent("player_clip_" + str_area, "targetname");
    if (var_da49671a) {
        var_9108873 triggerenable(0);
        e_clip notsolid();
        trigger::wait_till("trig_regroup_" + str_area, "script_noteworthy");
    }
    var_9108873 triggerenable(1);
    e_clip solid();
}

