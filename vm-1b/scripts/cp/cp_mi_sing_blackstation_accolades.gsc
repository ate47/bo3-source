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
// Checksum 0x1ef0c3d6, Offset: 0x668
// Size: 0x27a
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
// Checksum 0x6d5609af, Offset: 0x8f0
// Size: 0x72
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
// Checksum 0xb03492c, Offset: 0x970
// Size: 0x11
function function_806ef44e() {
    self.var_8477b47b = 0;
    self.var_3a4bbe6b = undefined;
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0xfa82f817, Offset: 0x990
// Size: 0x22
function function_c6595cb5() {
    callback::on_ai_killed(&function_e83f24);
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0xa9372a28, Offset: 0x9c0
// Size: 0x42
function function_f673d34(params) {
    params.eattacker.var_3a4bbe6b = params.einflictor.birthtime;
    params.eattacker.var_8477b47b = 0;
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x59691127, Offset: 0xa10
// Size: 0x2d
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
// Checksum 0xb8755c1d, Offset: 0xa48
// Size: 0xfa
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
// Checksum 0xe6c2ce5f, Offset: 0xb50
// Size: 0x22
function function_86716d12() {
    callback::on_ai_killed(&function_2f913423);
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0xf75aea69, Offset: 0xb80
// Size: 0x52
function function_2f913423(params) {
    if (isplayer(params.eattacker) && params.weapon.name == "turret_bo3_civ_truck_pickup_tech_54i") {
        params.eattacker notify(#"technical_turret_challenge");
    }
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0xdb27bd2a, Offset: 0xbe0
// Size: 0x2a
function function_80f71baf() {
    spawner::add_archetype_spawn_function("warlord", &function_41954f8f);
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0xce256bb5, Offset: 0xc18
// Size: 0x4a
function function_41954f8f() {
    self endon(#"death");
    level flag::wait_till("warlord_fight");
    wait 1;
    self.overrideactordamage = &function_587c487b;
    self thread function_5d3711fa();
}

// Namespace namespace_23567e72
// Params 15, eflags: 0x0
// Checksum 0x471ed3ba, Offset: 0xc70
// Size: 0xac
function function_587c487b(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, vsurfacenormal) {
    if (isplayer(eattacker) && weapon.weapclass != "pistol") {
        level.var_76663db9 = 0;
    }
    return idamage;
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0xf7e429a2, Offset: 0xd28
// Size: 0xf4
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
// Checksum 0x407940e, Offset: 0xe28
// Size: 0x22
function function_ba5f78c4() {
    self.var_d7f34b97 = 0;
    self.s_timer = util::new_timer(3);
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0xd501a0b5, Offset: 0xe58
// Size: 0x22
function function_ed62e62f() {
    callback::on_ai_killed(&function_9cb470ce);
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0x60be3b1c, Offset: 0xe88
// Size: 0x13a
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
// Checksum 0x7c889e55, Offset: 0xfd0
// Size: 0x22
function function_ca5e3a6() {
    self.var_65338a8f = 0;
    self.s_timer = util::new_timer(1);
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x3d2fc372, Offset: 0x1000
// Size: 0x22
function function_be537152() {
    callback::on_ai_killed(&function_55a74563);
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0x6ebc93db, Offset: 0x1030
// Size: 0x14a
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
// Checksum 0x9da85724, Offset: 0x1188
// Size: 0x22
function function_81a32f61() {
    self.var_27d2276e = 0;
    self.var_6fd54591 = 0;
    self thread function_35dfc997();
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0xc1b29eae, Offset: 0x11b8
// Size: 0x31
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
// Checksum 0xdfbdf28, Offset: 0x11f8
// Size: 0x22
function function_fe5a0b6() {
    callback::on_ai_killed(&function_635e0947);
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0x978ad260, Offset: 0x1228
// Size: 0xb2
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
// Checksum 0xb185d7af, Offset: 0x12e8
// Size: 0x32
function function_af8faf92() {
    self endon(#"death");
    trigger::wait_till("trigger_roof_escape", "targetname", self);
    level.var_8454c072 = 0;
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0xf14973ba, Offset: 0x1328
// Size: 0x81
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
// Checksum 0x6b2e6744, Offset: 0x13b8
// Size: 0xa
function function_91f0e7d2() {
    self.var_a7590ae5 = 0;
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0xc8309a14, Offset: 0x13d0
// Size: 0x62
function function_91fa5513() {
    level waittill(#"wheelhouse_breached");
    callback::on_ai_killed(&function_92bc12da);
    level flag::wait_till("barge_breach_cleared");
    callback::remove_on_ai_killed(&function_92bc12da);
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0x6137ca1f, Offset: 0x1440
// Size: 0x9a
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
// Checksum 0x57ba44cd, Offset: 0x14e8
// Size: 0xa
function function_78f93084() {
    self.var_10276781 = 0;
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0xa5f20941, Offset: 0x1500
// Size: 0x72
function function_29c337dd() {
    level flag::wait_till("comm_relay_engaged");
    callback::on_ai_killed(&function_8c9ce56);
    level flag::wait_till("relay_room_clear");
    callback::remove_on_ai_killed(&function_8c9ce56);
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0x520fe7cc, Offset: 0x1580
// Size: 0x8e
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
// Checksum 0x85d0fdfe, Offset: 0x1618
// Size: 0x72
function function_f0b50148() {
    level flag::wait_till("warlord_fight");
    callback::on_ai_killed(&function_b82c8e7b);
    level flag::wait_till("drone_strike");
    callback::remove_on_ai_killed(&function_b82c8e7b);
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x7b4f4474, Offset: 0x1698
// Size: 0x72
function function_26aa602b() {
    level flag::wait_till("flag_enter_police_station");
    callback::on_ai_killed(&function_b82c8e7b);
    level flag::wait_till("flag_kane_intro_complete");
    callback::remove_on_ai_killed(&function_b82c8e7b);
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x411f4a81, Offset: 0x1718
// Size: 0x72
function function_328b2c47() {
    level flag::wait_till("blackstation_exterior_engaged");
    callback::on_ai_killed(&function_b82c8e7b);
    level flag::wait_till("warlord_dead");
    callback::remove_on_ai_killed(&function_b82c8e7b);
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0x5290997e, Offset: 0x1798
// Size: 0x66
function function_b82c8e7b(params) {
    if (isplayer(params.eattacker) && self.archetype == "warlord") {
        if (params.einflictor.targetname === "destructible") {
            params.eattacker notify(#"warlord_barrel_challenge");
        }
    }
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0x304bebe7, Offset: 0x1808
// Size: 0x7a
function function_92e8d6d8(a_ai) {
    foreach (ai in a_ai) {
        ai.overrideactordamage = &function_aa2360ca;
    }
    level thread function_ccfcd136(a_ai);
}

// Namespace namespace_23567e72
// Params 15, eflags: 0x0
// Checksum 0x1b2eca6, Offset: 0x1890
// Size: 0xbc
function function_aa2360ca(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, vsurfacenormal) {
    if (smeansofdeath !== "MOD_MELEE" && smeansofdeath !== "MOD_MELEE_ASSASSINATE" && isplayer(eattacker) && smeansofdeath !== "MOD_MELEE_WEAPON_BUTT") {
        level.var_63855bec = 0;
    }
    return idamage;
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0x3f8781d1, Offset: 0x1958
// Size: 0x89
function function_ccfcd136(a_ai) {
    array::wait_till(a_ai, "death");
    if (level.var_63855bec) {
        foreach (player in level.activeplayers) {
            player notify(#"riotshield_melee_challenge");
        }
    }
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0xdf649fda, Offset: 0x19f0
// Size: 0xa
function function_c169f275() {
    self.var_a7590ae5 = 0;
}

// Namespace namespace_23567e72
// Params 0, eflags: 0x0
// Checksum 0x4b1dc1e2, Offset: 0x1a08
// Size: 0x72
function function_7d2dae0a() {
    level flag::wait_till("flag_enter_police_station");
    callback::on_ai_killed(&function_cdf3285b);
    level flag::wait_till("flag_kane_intro_complete");
    callback::remove_on_ai_killed(&function_cdf3285b);
}

// Namespace namespace_23567e72
// Params 1, eflags: 0x0
// Checksum 0x6b3c8201, Offset: 0x1a88
// Size: 0x96
function function_cdf3285b(params) {
    if (isplayer(params.eattacker) && self.archetype == "human_riotshield") {
        if (params.shitloc == "head" || params.shitloc == "helmet" || params.shitloc == "neck") {
            params.eattacker.var_a7590ae5++;
            params.eattacker notify(#"riotshield_headshot_challenge");
        }
    }
}

