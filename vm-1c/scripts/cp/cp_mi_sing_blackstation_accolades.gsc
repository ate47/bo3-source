#using scripts/codescripts/struct;
#using scripts/cp/_accolades;
#using scripts/shared/ai/systems/destructible_character;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace namespace_23567e72;

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x1f461bb, Offset: 0x6b8
// Size: 0x2a8
function function_4d39a2af() {
    accolades::register("MISSION_BLACKSTATION_CHALLENGE3", "micromissile_kill_challenge");
    accolades::register("MISSION_BLACKSTATION_CHALLENGE4", "technical_turret_challenge");
    accolades::register("MISSION_BLACKSTATION_CHALLENGE5", "warlord_pistol_challenge");
    accolades::register("MISSION_BLACKSTATION_CHALLENGE6", "speed_distance_challenge");
    accolades::register("MISSION_BLACKSTATION_CHALLENGE7", "rpg_kill_challenge");
    accolades::register("MISSION_BLACKSTATION_CHALLENGE8", "robot_human_challenge");
    accolades::register("MISSION_BLACKSTATION_CHALLENGE9", "powerstation_roof_challenge");
    accolades::register("MISSION_BLACKSTATION_CHALLENGE10", "headshot_breach_challenge");
    accolades::register("MISSION_BLACKSTATION_CHALLENGE11", "robot_powerup_challenge");
    accolades::register("MISSION_BLACKSTATION_CHALLENGE12", "warlord_turret_challenge");
    accolades::register("MISSION_BLACKSTATION_CHALLENGE13", "warlord_barrel_challenge");
    accolades::register("MISSION_BLACKSTATION_CHALLENGE14", "riotshield_melee_challenge");
    accolades::register("MISSION_BLACKSTATION_CHALLENGE15", "riotshield_headshot_challenge");
    callback::on_spawned(&function_3a6b5b3e);
    function_c6595cb5();
    function_86716d12();
    function_80f71baf();
    function_ed62e62f();
    function_be537152();
    function_fe5a0b6();
    level thread function_69b1ee49();
    level thread function_91fa5513();
    level thread function_29c337dd();
    level thread function_7d2dae0a();
    level.var_76663db9 = 1;
    level.var_8454c072 = 1;
    level.var_63855bec = 1;
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0xbf5317fc, Offset: 0x968
// Size: 0xac
function function_3a6b5b3e() {
    self function_806ef44e();
    self function_ba5f78c4();
    self function_ca5e3a6();
    self function_81a32f61();
    self function_91f0e7d2();
    self function_78f93084();
    self function_c169f275();
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x3b18db87, Offset: 0xa20
// Size: 0x1a
function function_806ef44e() {
    self.var_8477b47b = 0;
    self.var_3a4bbe6b = undefined;
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0xc07e71b7, Offset: 0xa48
// Size: 0x24
function function_c6595cb5() {
    callback::on_ai_killed(&function_e83f24);
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0x4bad4ea8, Offset: 0xa78
// Size: 0x50
function function_f673d34(params) {
    params.eattacker.var_3a4bbe6b = params.einflictor.birthtime;
    params.eattacker.var_8477b47b = 0;
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x8c9528f1, Offset: 0xad0
// Size: 0x46
function function_feac00a() {
    self notify(#"hash_dff0891a");
    self endon(#"hash_dff0891a");
    self endon(#"death");
    wait 3;
    self.var_8477b47b = 0;
    self.var_3a4bbe6b = undefined;
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0xc3dca349, Offset: 0xb20
// Size: 0x13c
function function_e83f24(params) {
    if (isplayer(params.eattacker) && params.weapon == getweapon("micromissile_launcher")) {
        params.eattacker thread function_feac00a();
        if (!isdefined(params.eattacker.var_3a4bbe6b)) {
            function_f673d34(params);
        }
        if (abs(params.eattacker.var_3a4bbe6b - params.einflictor.birthtime) <= 400) {
            params.eattacker.var_8477b47b++;
            if (params.eattacker.var_8477b47b == 5) {
                params.eattacker notify(#"micromissile_kill_challenge");
            }
        }
    }
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x553b7c46, Offset: 0xc68
// Size: 0x24
function function_86716d12() {
    callback::on_ai_killed(&function_2f913423);
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0x1cfbf7fa, Offset: 0xc98
// Size: 0x68
function function_2f913423(params) {
    if (isplayer(params.eattacker) && params.weapon.name == "turret_bo3_civ_truck_pickup_tech_54i") {
        params.eattacker notify(#"technical_turret_challenge");
    }
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0xcdf6fe5b, Offset: 0xd08
// Size: 0x2c
function function_80f71baf() {
    spawner::add_archetype_spawn_function("warlord", &function_41954f8f);
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x60ddbb58, Offset: 0xd40
// Size: 0x64
function function_41954f8f() {
    self endon(#"death");
    level flag::wait_till("warlord_fight");
    wait 1;
    self.overrideactordamage = &function_587c487b;
    self thread function_5d3711fa();
}

// Namespace namespace_23567e72
// Params 15, eflags: 0x0
// Checksum 0x6d0895b6, Offset: 0xdb0
// Size: 0xc0
function function_587c487b(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, vsurfacenormal) {
    if (isplayer(eattacker) && weapon.weapclass != "pistol") {
        level.var_76663db9 = 0;
    }
    return idamage;
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x492706a4, Offset: 0xe78
// Size: 0x138
function function_5d3711fa() {
    self waittill(#"death", eattacker, damagefromunderneath, weapon, point, dir);
    if (level.var_76663db9 && isplayer(eattacker)) {
        foreach (player in level.activeplayers) {
            player notify(#"warlord_pistol_challenge");
        }
        return;
    }
    if (isplayer(eattacker) && weapon.name == "turret_bo3_civ_truck_pickup_tech_54i") {
        eattacker notify(#"warlord_turret_challenge");
    }
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x60a435c9, Offset: 0xfb8
// Size: 0x2c
function function_ba5f78c4() {
    self.var_d7f34b97 = 0;
    self.s_timer = util::new_timer(3);
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0xe6243764, Offset: 0xff0
// Size: 0x24
function function_ed62e62f() {
    callback::on_ai_killed(&function_9cb470ce);
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0x808e4921, Offset: 0x1020
// Size: 0x194
function function_9cb470ce(params) {
    if (isplayer(params.eattacker) && distancesquared(params.eattacker.origin, self.origin) >= 3240000) {
        if (params.eattacker.var_d7f34b97 == 0) {
            params.eattacker.s_timer = util::new_timer(3);
            params.eattacker.var_d7f34b97++;
            return;
        }
        params.eattacker.var_d7f34b97++;
        if (params.eattacker.var_d7f34b97 >= 3 && params.eattacker.s_timer util::get_time_left() > 0) {
            params.eattacker notify(#"speed_distance_challenge");
            return;
        }
        if (params.eattacker.s_timer util::get_time_left() <= 0) {
            params.eattacker.var_d7f34b97 = 0;
        }
    }
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0xd008c9ee, Offset: 0x11c0
// Size: 0x2c
function function_ca5e3a6() {
    self.var_65338a8f = 0;
    self.s_timer = util::new_timer(1);
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x631548d9, Offset: 0x11f8
// Size: 0x24
function function_be537152() {
    callback::on_ai_killed(&function_55a74563);
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0x2433da37, Offset: 0x1228
// Size: 0x1a8
function function_55a74563(params) {
    if (isplayer(params.eattacker) && issubstr(self.classname, "rpg")) {
        if (params.eattacker.var_65338a8f == 0) {
            params.eattacker.s_timer = util::new_timer(1);
            params.eattacker.var_65338a8f++;
            return;
        }
        params.eattacker.var_65338a8f++;
        if (params.eattacker.var_65338a8f >= 2 && params.eattacker.s_timer util::get_time_left() > 0) {
            params.eattacker notify(#"rpg_kill_challenge");
            return;
        }
        if (params.eattacker.s_timer util::get_time_left() <= 0) {
            params.eattacker.var_65338a8f = 1;
            params.eattacker.s_timer = util::new_timer(1);
        }
    }
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0xb979a4fb, Offset: 0x13d8
// Size: 0x34
function function_81a32f61() {
    self.var_27d2276e = 0;
    self.var_6fd54591 = 0;
    self thread function_35dfc997();
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x4ecd3cb6, Offset: 0x1418
// Size: 0x40
function function_35dfc997() {
    self endon(#"death");
    while (true) {
        self waittill(#"reload");
        self.var_27d2276e = 0;
        self.var_6fd54591 = 0;
    }
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x78d4cb, Offset: 0x1460
// Size: 0x24
function function_fe5a0b6() {
    callback::on_ai_killed(&function_635e0947);
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0x704fe7fb, Offset: 0x1490
// Size: 0xdc
function function_635e0947(params) {
    if (isplayer(params.eattacker)) {
        if (self.archetype == "human") {
            params.eattacker.var_6fd54591++;
        } else if (self.archetype == "robot") {
            params.eattacker.var_27d2276e++;
        }
        if (params.eattacker.var_6fd54591 > 0 && params.eattacker.var_27d2276e > 0) {
            params.eattacker notify(#"robot_human_challenge");
        }
    }
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x70642a50, Offset: 0x1578
// Size: 0x40
function function_af8faf92() {
    self endon(#"death");
    trigger::wait_till("trigger_roof_escape", "targetname", self);
    level.var_8454c072 = 0;
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x72276a97, Offset: 0x15c0
// Size: 0xa6
function function_69b1ee49() {
    spawner::waittill_ai_group_cleared("group_roof_workers");
    if (level.var_8454c072) {
        foreach (player in level.activeplayers) {
            player notify(#"powerstation_roof_challenge");
        }
    }
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x60777f2c, Offset: 0x1670
// Size: 0x10
function function_91f0e7d2() {
    self.var_a7590ae5 = 0;
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0xc3ff44f5, Offset: 0x1688
// Size: 0x74
function function_91fa5513() {
    level waittill(#"wheelhouse_breached");
    callback::on_ai_killed(&function_92bc12da);
    level flag::wait_till("barge_breach_cleared");
    callback::remove_on_ai_killed(&function_92bc12da);
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0x6c1bcbb6, Offset: 0x1708
// Size: 0xd0
function function_92bc12da(params) {
    if (isplayer(params.eattacker)) {
        if (params.shitloc == "head" || params.shitloc == "helmet" || params.shitloc == "neck") {
            params.eattacker.var_a7590ae5++;
            if (params.eattacker.var_a7590ae5 >= 3) {
                params.eattacker notify(#"headshot_breach_challenge");
            }
        }
    }
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x17aa572b, Offset: 0x17e0
// Size: 0x10
function function_78f93084() {
    self.var_10276781 = 0;
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x503d9c7e, Offset: 0x17f8
// Size: 0x84
function function_29c337dd() {
    level flag::wait_till("comm_relay_engaged");
    callback::on_ai_killed(&function_8c9ce56);
    level flag::wait_till("relay_room_clear");
    callback::remove_on_ai_killed(&function_8c9ce56);
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0xdd177919, Offset: 0x1888
// Size: 0xac
function function_8c9ce56(params) {
    if (isplayer(params.eattacker)) {
        if (issubstr(self.targetname, "comm_relay_awaken_robot") && !isdefined(self.b_activated)) {
            params.eattacker.var_10276781++;
            if (params.eattacker.var_10276781 >= 4) {
                params.eattacker notify(#"robot_powerup_challenge");
            }
        }
    }
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0xdb0b55e7, Offset: 0x1940
// Size: 0x84
function function_f0b50148() {
    level flag::wait_till("warlord_fight");
    callback::on_ai_killed(&function_b82c8e7b);
    level flag::wait_till("drone_strike");
    callback::remove_on_ai_killed(&function_b82c8e7b);
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0xeb82c577, Offset: 0x19d0
// Size: 0x84
function function_26aa602b() {
    level flag::wait_till("flag_enter_police_station");
    callback::on_ai_killed(&function_b82c8e7b);
    level flag::wait_till("flag_kane_intro_complete");
    callback::remove_on_ai_killed(&function_b82c8e7b);
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x7b20594b, Offset: 0x1a60
// Size: 0x84
function function_328b2c47() {
    level flag::wait_till("blackstation_exterior_engaged");
    callback::on_ai_killed(&function_b82c8e7b);
    level flag::wait_till("warlord_dead");
    callback::remove_on_ai_killed(&function_b82c8e7b);
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0x9fb8b094, Offset: 0x1af0
// Size: 0x80
function function_b82c8e7b(params) {
    if (isplayer(params.eattacker) && self.archetype == "warlord") {
        if (params.einflictor.targetname === "destructible") {
            params.eattacker notify(#"warlord_barrel_challenge");
        }
    }
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0xbb855b1b, Offset: 0x1b78
// Size: 0x134
function function_92e8d6d8(a_ai) {
    foreach (ai in a_ai) {
        ai.overrideactordamage = &function_aa2360ca;
    }
    foreach (var_3f7c5c5d in a_ai) {
        var_3f7c5c5d thread function_9ff8b6fb();
    }
    level thread function_ccfcd136(a_ai);
}

// Namespace namespace_23567e72
// Params 15, eflags: 0x0
// Checksum 0x91bbace9, Offset: 0x1cb8
// Size: 0x148
function function_aa2360ca(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, vsurfacenormal) {
    if (!isdefined(weapon)) {
        return idamage;
    }
    str_weapon_name = weapon.rootweapon.name;
    if (isplayer(eattacker)) {
        if (smeansofdeath !== "MOD_MELEE" && smeansofdeath !== "MOD_MELEE_ASSASSINATE" && smeansofdeath !== "MOD_MELEE_WEAPON_BUTT" && str_weapon_name != "flash_grenade" && str_weapon_name != "gadget_es_strike" && str_weapon_name != "gadget_es_strike_upgraded" && str_weapon_name != "gadget_sensory_overload") {
            level.var_63855bec = 0;
        }
    }
    return idamage;
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0xf94ed75f, Offset: 0x1e08
// Size: 0xbe
function function_ccfcd136(a_ai) {
    array::wait_till(a_ai, "death");
    wait 1;
    if (level.var_63855bec) {
        foreach (player in level.activeplayers) {
            player notify(#"riotshield_melee_challenge");
        }
    }
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x9d086747, Offset: 0x1ed0
// Size: 0x70
function function_9ff8b6fb() {
    self waittill(#"death", eattacker, damagefromunderneath, weapon, point, dir);
    if (!isplayer(eattacker)) {
        level.var_63855bec = 0;
    }
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x1ec0b937, Offset: 0x1f48
// Size: 0x10
function function_c169f275() {
    self.var_a7590ae5 = 0;
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0xee41515d, Offset: 0x1f60
// Size: 0x84
function function_7d2dae0a() {
    level flag::wait_till("flag_enter_police_station");
    callback::on_ai_killed(&function_cdf3285b);
    level flag::wait_till("flag_kane_intro_complete");
    callback::remove_on_ai_killed(&function_cdf3285b);
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0xc0be881b, Offset: 0x1ff0
// Size: 0xc8
function function_cdf3285b(params) {
    if (isplayer(params.eattacker) && self.archetype == "human_riotshield") {
        if (params.shitloc == "head" || params.shitloc == "helmet" || params.shitloc == "neck") {
            params.eattacker.var_a7590ae5++;
            params.eattacker notify(#"riotshield_headshot_challenge");
        }
    }
}

