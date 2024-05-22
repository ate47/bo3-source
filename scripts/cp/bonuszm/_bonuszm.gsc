#using scripts/cp/bonuszm/_bonuszm_zurich;
#using scripts/cp/bonuszm/_bonuszm_vengeance;
#using scripts/cp/bonuszm/_bonuszm_aquifer;
#using scripts/cp/bonuszm/_bonuszm_blackstation;
#using scripts/cp/bonuszm/_bonuszm_infection;
#using scripts/cp/bonuszm/_bonuszm_ramses;
#using scripts/cp/bonuszm/_bonuszm_lotus;
#using scripts/cp/bonuszm/_bonuszm_newworld;
#using scripts/cp/bonuszm/_bonuszm_prologue;
#using scripts/cp/bonuszm/_bonuszm_biodomes1;
#using scripts/cp/bonuszm/_bonuszm_sgen;
#using scripts/cp/bonuszm/_bonuszm_zmsng;
#using scripts/cp/bonuszm/_bonuszm_weapons;
#using scripts/cp/bonuszm/_bonuszm_magicbox;
#using scripts/cp/bonuszm/_bonuszm_spawner_shared;
#using scripts/cp/bonuszm/_bonuszm_drops;
#using scripts/cp/bonuszm/_bonuszm_data;
#using scripts/cp/bonuszm/_bonuszm_util;
#using scripts/cp/bonuszm/_bonuszm_sound;
#using scripts/cp/bonuszm/_bonuszm_dev;
#using scripts/cp/bonuszm/_bonuszm_zombie;
#using scripts/cp/gametypes/_save;
#using scripts/cp/_laststand;
#using scripts/cp/_util;
#using scripts/cp/_oed;
#using scripts/cp/_load;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/gametypes/_globallogic_player;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/systems/shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/weapons_shared;
#using scripts/shared/util_shared;
#using scripts/shared/tweakables_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/_oob;
#using scripts/shared/music_shared;
#using scripts/shared/math_shared;
#using scripts/shared/load_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/gameskill_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/containers_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/clientids_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ammo_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/ai_shared;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/archetype_shared/archetype_shared;
#using scripts/codescripts/struct;

#namespace namespace_293e8aad;

// Namespace namespace_293e8aad
// Params 0, eflags: 0x2
// Checksum 0x3d6a879a, Offset: 0x11e0
// Size: 0x3c
function function_2dc19561() {
    system::register("bonuszm", &__init__, &__main__, undefined);
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x2f4de5e8, Offset: 0x1228
// Size: 0x574
function __init__() {
    function_5143a242();
    if (!sessionmodeiscampaignzombiesgame()) {
        return;
    }
    /#
        namespace_2e795785::function_6f199738();
    #/
    level.friendlyfiredisabled = 0;
    level.disableclassselection = 1;
    setdvar("ai_instantNoSolidOnDeath", 1);
    setdvar("bg_friendlyFireMode", 0);
    setdvar("scr_firefly_swarm_attack_radius", 96);
    setdvar("scr_concussive_wave_radius", 450);
    setdvar("scr_concussive_wave_upg_radius", 800);
    setdvar("scr_concussive_wave_kill_radius", 550);
    level.zm_variant_type_max = [];
    level.zm_variant_type_max["walk"] = [];
    level.zm_variant_type_max["run"] = [];
    level.zm_variant_type_max["sprint"] = [];
    level.zm_variant_type_max["walk"]["down"] = 14;
    level.zm_variant_type_max["walk"]["up"] = 16;
    level.zm_variant_type_max["run"]["down"] = 13;
    level.zm_variant_type_max["run"]["up"] = 12;
    level.zm_variant_type_max["sprint"]["down"] = 7;
    level.zm_variant_type_max["sprint"]["up"] = 6;
    level.zombieanhilationenabled = 1;
    setdvar("player_tmodeSightEnabled", 0);
    level.var_17ded976 = 0;
    level.zombie_use_zigzag_path = 1;
    level.aidisablegrenadethrows = 1;
    level thread function_44a35094();
    function_13eef9b9();
    function_6889d515();
    namespace_37cacec1::function_9cb5d4c9();
    level.zombie_team = "axis";
    callback::on_spawned(&function_36a89e89);
    callback::on_player_killed(&function_f98bc462);
    callback::on_finalize_initialization(&function_3550da52);
    callback::on_loadout(&function_fcf02f23);
    callback::on_vehicle_damage(&function_2bc18574);
    callback::on_vehicle_killed(&function_285b856c);
    callback::on_ai_spawned(&function_40f80ade);
    level.var_26b4fb80 = &function_96fc5f48;
    level.var_9a25f386 = [];
    level.zombielevelspecifictargetcallback = &function_3ca31ff8;
    level.var_9f14c2b8 = getentarray("zombie_spawner", "script_noteworthy");
    level.var_b1955bd6 = 0;
    level.var_d0e37460 = 0;
    level.var_c4dba52c = &function_c4dba52c;
    level.var_e8899224 = &function_11692fba;
    level.var_dc323706 = &function_88adb698;
    level.var_3e0291d0 = &function_3e0291d0;
    level.zombiemeleesuicidecallback = &function_2ffffb72;
    level.zombiemeleesuicidedonecallback = &function_26a65116;
    level.var_f22c67b = &function_f22c67b;
    level.var_652674d2 = &function_652674d2;
    level.var_203903e = &function_203903e;
    level flag::init("bzmObjectiveEnabled");
    level flag::init("bzmExtraZombieCleared", 1);
    level.var_31f73a8d = "";
    level.var_9e70dea1 = getweapon("micromissile_launcher_cpzm2");
    level.var_45cae8b1 = getweapon("hero_flamethrower_cpzm");
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x9860921d, Offset: 0x17a8
// Size: 0x18
function __main__() {
    if (!sessionmodeiscampaignzombiesgame()) {
        return;
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0xa82364e0, Offset: 0x17c8
// Size: 0x1f2
function function_6889d515() {
    nodes = getallnodes();
    foreach (node in nodes) {
        if (node.type == "Begin" || isdefined(node.animscript) && node.type == "End") {
            if (node.animscript == "stairs8x12" || node.animscript == "stairs8x8" || node.animscript == "stairs8x16") {
                setenablenode(node, 0);
            }
        }
    }
    nodes = getnodearray("cpzm_procedural", "script_noteworthy");
    foreach (node in nodes) {
        setenablenode(node, 1);
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0xf57404c0, Offset: 0x19c8
// Size: 0xba
function function_5143a242() {
    nodes = getnodearray("cpzm_procedural", "script_noteworthy");
    foreach (node in nodes) {
        setenablenode(node, 0);
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x5 linked
// Checksum 0xac5a375, Offset: 0x1a90
// Size: 0x30
function function_44a35094() {
    while (true) {
        battlechatter::function_d9f49fba(0);
        wait(0.2);
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x5 linked
// Checksum 0x1376206a, Offset: 0x1ac8
// Size: 0x394
function function_13eef9b9() {
    clientfield::register("actor", "zombie_riser_fx", 1, 1, "int");
    clientfield::register("actor", "bonus_zombie_eye_color", 1, 3, "int");
    clientfield::register("actor", "zombie_has_eyes", 1, 1, "int");
    clientfield::register("actor", "zombie_gut_explosion", 1, 1, "int");
    clientfield::register("actor", "bonuszm_zombie_death_fx", 1, getminbitcountfornum(5), "int");
    clientfield::register("actor", "zombie_appear_vanish_fx", 1, getminbitcountfornum(3), "int");
    clientfield::register("actor", "bonuszm_zombie_on_fire_fx", 1, getminbitcountfornum(3), "int");
    clientfield::register("actor", "bonuszm_zombie_spark_fx", 1, getminbitcountfornum(2), "int");
    clientfield::register("actor", "bonuszm_zombie_deimos_fx", 1, getminbitcountfornum(1), "int");
    clientfield::register("vehicle", "bonuszm_meatball_death", 1, 1, "int");
    clientfield::register("scriptmover", "powerup_on_fx", 1, getminbitcountfornum(3), "int");
    clientfield::register("scriptmover", "powerup_grabbed_fx", 1, 1, "int");
    clientfield::register("scriptmover", "sparky_trail_fx", 1, 1, "int");
    clientfield::register("scriptmover", "sparky_attack_fx", 1, 1, "counter");
    clientfield::register("actor", "sparky_damaged_fx", 1, 1, "counter");
    clientfield::register("actor", "fire_damaged_fx", 1, 1, "counter");
    clientfield::register("toplayer", "bonuszm_player_instakill_active_fx", 1, 1, "int");
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x4f09ad, Offset: 0x1e68
// Size: 0x64
function function_36a89e89() {
    self thread function_fa34e301();
    self thread namespace_36e5bc12::function_b80a73a4();
    self thread function_7ef5e890();
    self playerknockback(0);
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0xfbe2c7a5, Offset: 0x1ed8
// Size: 0x64
function function_40f80ade() {
    if (isactor(self) && self.archetype == "human") {
        self ai::set_behavior_attribute("useGrenades", 0);
        self.script_accuracy = 0.5;
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x1f48
// Size: 0x4
function function_3550da52() {
    
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x1 linked
// Checksum 0x190cb135, Offset: 0x1f58
// Size: 0x18
function function_96fc5f48(nextobjective) {
    level.var_31f73a8d = nextobjective;
}

// Namespace namespace_293e8aad
// Params 4, eflags: 0x1 linked
// Checksum 0xcbcdffab, Offset: 0x1f78
// Size: 0x84
function function_652674d2(weapon, eattacker, idamage, smeansofdeath) {
    if (smeansofdeath === "MOD_MELEE" || isdefined(eattacker) && eattacker.archetype === "zombie" && smeansofdeath === "MOD_MELEE_WEAPON_BUTT") {
        self playsoundtoplayer("evt_player_swiped", self);
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x3fd4c2c1, Offset: 0x2008
// Size: 0x14
function function_f98bc462() {
    function_3d7ae135();
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0xdce8478a, Offset: 0x2028
// Size: 0x312
function function_7ef5e890() {
    self endon(#"death");
    self endon(#"disconnect");
    self.var_5206d4b9 = 0;
    self.var_f4fa5cef = gettime() + 5000;
    waittime = 2;
    while (true) {
        if (!isdefined(level.var_a9e78bf7) || !level.var_a9e78bf7["zombifyenabled"]) {
            function_3d7ae135();
            wait(waittime);
            continue;
        }
        if (!level.var_a9e78bf7["maxreachabilitylevel"]) {
            function_3d7ae135();
            wait(waittime);
            continue;
        }
        if (isdefined(self.ignoreme) && (self isplayinganimscripted() || self.ignoreme)) {
            function_3d7ae135();
            wait(waittime);
            continue;
        }
        isonnavmesh = ispointonnavmesh(self.origin);
        var_bfa65c4c = 1;
        nearbyzombies = array::get_all_closest(self.origin, getactorteamarray("axis"), array(self), 1, 500);
        if (isdefined(nearbyzombies) && nearbyzombies.size) {
            var_dbbef32d = getclosestpointonnavmesh(self.origin, -106);
            if (self isdoublejumping()) {
                var_dbbef32d = getclosestpointonnavmesh(self.origin, -106);
            } else {
                var_dbbef32d = self.origin;
            }
            if (!isdefined(var_dbbef32d)) {
                var_bfa65c4c = 0;
            } else {
                pathsuccess = nearbyzombies[0] findpath(nearbyzombies[0].origin, var_dbbef32d, 1, 0);
                if (!pathsuccess) {
                    var_bfa65c4c = 0;
                }
            }
        }
        if (!isonnavmesh || !var_bfa65c4c) {
            /#
            #/
            if (self.var_5206d4b9 < level.var_a9e78bf7["maxreachabilitylevel"]) {
                self.var_5206d4b9++;
            }
        } else {
            function_3d7ae135();
            /#
            #/
        }
        if (self.var_5206d4b9 < 0) {
            self.var_5206d4b9 = 0;
        }
        wait(waittime);
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x8549ac03, Offset: 0x2348
// Size: 0x44
function function_3d7ae135() {
    /#
        assert(isplayer(self));
    #/
    self.var_5206d4b9 = 0;
    self.var_f4fa5cef = 0;
}

// Namespace namespace_293e8aad
// Params 2, eflags: 0x1 linked
// Checksum 0x53da59f0, Offset: 0x2398
// Size: 0x654
function function_11600557(zombie, player) {
    if (!isdefined(player)) {
        return;
    }
    /#
        assert(isdefined(player.var_5206d4b9));
    #/
    if (isdefined(level.bzm_worldpaused) && level.bzm_worldpaused) {
        return;
    }
    if (gettime() < player.var_f4fa5cef) {
        return;
    }
    if (!level.var_a9e78bf7["maxreachabilitylevel"]) {
        return;
    }
    if (player.var_5206d4b9 >= level.var_a9e78bf7["maxreachabilitylevel"]) {
        origin = zombie.origin;
        self.var_f4fa5cef = gettime() + level.var_a9e78bf7["reachabilityinterval"];
        vehicles = getaiarray();
        var_dc7611e0 = 0;
        foreach (vehicle in vehicles) {
            if (isdefined(vehicle.var_2585e9c3) && vehicle.archetype === "parasite" && vehicle.var_2585e9c3) {
                var_dc7611e0++;
            }
        }
        if (isdefined(level.var_8dfe3cfa) && level.var_8dfe3cfa || var_dc7611e0 > level.var_a9e78bf7["maxreachabilityparasites"]) {
            var_3b319f54 = 1;
        } else {
            var_3b319f54 = 0;
        }
        if (math::cointoss() || var_3b319f54) {
            var_a77b3c1f = origin + (0, 0, 80);
            if (distancesquared(player.origin, origin) > 40000) {
                var_7ed0fbf4 = player.origin + (0, 0, 35);
                var_b990e3ba = getactorteamarray("axis");
                if (isdefined(var_b990e3ba) && var_b990e3ba.size) {
                    rocket = magicbullet(level.var_9e70dea1, var_a77b3c1f, var_7ed0fbf4, undefined, array::random(var_b990e3ba));
                    if (isdefined(rocket)) {
                        rocket missile_settarget(player, (0, 0, 35));
                        rocket notsolid();
                        rocket function_2527b827();
                    }
                }
            }
            return;
        }
        closestplayer = player;
        playerforward = anglestoforward(closestplayer.angles);
        var_2d1236a = origin + (0, 0, 35);
        queryresult = positionquery_source_navigation(var_2d1236a, 100, 500, 70, 100);
        var_a6c6348c = [];
        if (isdefined(queryresult) && queryresult.data.size > 0) {
            foreach (data in queryresult.data) {
                array::add(var_a6c6348c, data.origin);
            }
        }
        if (var_a6c6348c.size) {
            var_7bc3009e = array::random(var_a6c6348c);
        }
        if (!isdefined(var_7bc3009e)) {
            return;
        }
        level.var_8dfe3cfa = 1;
        wait(randomintrange(3, 6));
        level.var_8dfe3cfa = 0;
        var_d99a3773 = spawnvehicle("spawner_zombietron_parasite_purple_cpzm", var_7bc3009e, closestplayer.angles, "unreachable_parasite");
        var_d99a3773.var_2585e9c3 = 1;
        var_d99a3773.health *= 2;
        if (isdefined(var_d99a3773)) {
            var_d99a3773.ignoreme = 1;
            var_d99a3773 ai::set_behavior_attribute("firing_rate", "fast");
            var_d99a3773 thread function_b039235(randomintrange(30, 60));
        }
    }
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x1 linked
// Checksum 0x50a48e2e, Offset: 0x29f8
// Size: 0x4c
function function_b039235(time) {
    self endon(#"death");
    level util::waittill_any_timeout(time, "BZM_kill_active_parasites_meatball_rocket");
    self kill();
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x39c8e8ea, Offset: 0x2a50
// Size: 0x34
function function_2527b827() {
    self endon(#"death");
    level waittill(#"hash_cf7497c1");
    self delete();
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x15c7930c, Offset: 0x2a90
// Size: 0x3a
function function_aaa07980() {
    if (level.var_a9e78bf7["zombifyenabled"]) {
        level.run_custom_function_on_ai = &function_aed40969;
        return;
    }
    level.run_custom_function_on_ai = undefined;
}

// Namespace namespace_293e8aad
// Params 3, eflags: 0x1 linked
// Checksum 0x146e677f, Offset: 0x2ad8
// Size: 0x584
function function_aed40969(var_c3afa726, str_targetname, force_spawn) {
    /#
        assert(level.var_a9e78bf7["run"]);
    #/
    if (!isactor(self)) {
        return;
    }
    if ((self.team == "allies" || self.archetype != "zombie") && !(isdefined(self.var_6ad7f3f8) && self.var_6ad7f3f8)) {
        if (self.archetype == "human") {
            self ai::set_behavior_attribute("useGrenades", 0);
        }
        return;
    }
    self.updatesight = 0;
    self.badplaceawareness = 0;
    self setrepairpaths(0);
    self.holdfire = 1;
    aiutility::addaioverridedamagecallback(self, &function_48cb1ad1);
    flag::init("bzm_zombie_attack");
    self.closest_player_override = &function_8421a595;
    self thread zombie_utility::zombie_gib_on_damage();
    self thread function_a608d09();
    self thread zombie_death_event(self);
    if (isdefined(self.var_b7a92141) && self.var_b7a92141) {
        self clientfield::set("bonuszm_zombie_deimos_fx", 1);
        self.forceanhilateondeath = 1;
        self.var_4e78d51b = 1;
    } else if (self.var_30e91c0d === "sparky_upgraded") {
        self ai::set_behavior_attribute("spark_behavior", 1);
        self ai::set_behavior_attribute("can_juke", 1);
        self clientfield::set("bonuszm_zombie_spark_fx", 2);
        self.forceanhilateondeath = 1;
        self.var_4e78d51b = 1;
        self.var_13f5905e = 1;
        self oed::disable_thermal();
        self.disable_head_gib = 1;
    } else if (self.var_30e91c0d === "sparky") {
        self ai::set_behavior_attribute("spark_behavior", 1);
        self ai::set_behavior_attribute("can_juke", 1);
        self clientfield::set("bonuszm_zombie_spark_fx", 1);
        self.forceanhilateondeath = 1;
        self.var_4e78d51b = 1;
    } else if (self.var_30e91c0d === "on_fire_upgraded" && self.allowdeath) {
        self ai::set_behavior_attribute("suicidal_behavior", 1);
        self clientfield::set("arch_actor_fire_fx", 1);
        self clientfield::set("bonuszm_zombie_on_fire_fx", 2);
        self.forceanhilateondeath = 1;
        self.var_4e78d51b = 1;
        self.var_3c60032f = 1;
        self oed::disable_thermal();
        self.disable_head_gib = 1;
    } else if (self.var_30e91c0d === "on_fire" && self.allowdeath) {
        self ai::set_behavior_attribute("suicidal_behavior", 1);
        self clientfield::set("arch_actor_fire_fx", 1);
        self clientfield::set("bonuszm_zombie_on_fire_fx", 1);
        self.forceanhilateondeath = 1;
        self.var_4e78d51b = 1;
    }
    if (isdefined(self.var_6ad7f3f8) && self.var_6ad7f3f8) {
        self.var_4e78d51b = 1;
        self.disable_head_gib = 1;
    }
    self thread function_745c9570();
    self thread namespace_36e5bc12::function_f46e57be();
    self thread function_d0d9ed35();
    self thread function_29e1570d();
    self thread function_9bc25e40();
    self thread function_48401071();
    self thread function_8347526a();
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x1 linked
// Checksum 0x557d56a2, Offset: 0x3068
// Size: 0xbc
function function_2ffffb72(entity) {
    entity endon(#"death");
    /#
        assert(isactor(entity));
    #/
    /#
        assert(entity.archetype == "run");
    #/
    self clientfield::set("bonuszm_zombie_on_fire_fx", 3);
    wait(4);
    self clientfield::set("bonuszm_zombie_on_fire_fx", 1);
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x1 linked
// Checksum 0x588570d3, Offset: 0x3130
// Size: 0x54
function function_26a65116(behaviortreeentity) {
    self endon(#"death");
    wait(0.05);
    if (isdefined(self) && isalive(self)) {
        self kill();
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x85f5ab06, Offset: 0x3190
// Size: 0xe4
function function_abc05be8() {
    self endon(#"death");
    self notify(#"hash_abc05be8");
    if (isdefined(self.var_11f7b644) && gettime() - self.var_11f7b644 > 2000) {
        self clientfield::set("zombie_appear_vanish_fx", 1);
    }
    self.var_be85d412 = 1;
    /#
        recordenttext("run", self, (0, 1, 0), "run");
    #/
    self ghost();
    self notsolid();
    self.ignoreme = 1;
    self thread function_55e64fc7();
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0xbe8591f8, Offset: 0x3280
// Size: 0xb4
function function_55e64fc7() {
    self endon(#"death");
    self endon(#"hash_d94c729a");
    self endon(#"hash_abc05be8");
    while (true) {
        if (isdefined(self.var_be85d412) && self.var_be85d412) {
            /#
                recordenttext("run", self, (1, 0, 0), "run");
            #/
            self ghost();
            self notsolid();
            self.ignoreme = 1;
        }
        wait(0.05);
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x888afcf7, Offset: 0x3340
// Size: 0xcc
function function_d94c729a() {
    self endon(#"death");
    self endon(#"hash_abc05be8");
    if (isdefined(self.var_be85d412) && self.var_be85d412) {
        self notify(#"hash_d94c729a");
        self.var_be85d412 = 0;
        self solid();
        self.ignoreme = 0;
        wait(1);
        self clientfield::set("zombie_appear_vanish_fx", 3);
        self show();
        /#
            recordenttext("run", self, (0, 1, 0), "run");
        #/
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x2c78a45c, Offset: 0x3418
// Size: 0xd6
function function_c1802d32() {
    if (self isinscriptedstate()) {
        return false;
    }
    if (isdefined(level.bzm_worldpaused) && level.bzm_worldpaused) {
        return false;
    }
    if (isdefined(self.traversestartnode)) {
        return false;
    }
    if (isdefined(self.var_be85d412) && self.var_be85d412) {
        return false;
    }
    if (!self flag::get("bzm_zombie_attack")) {
        return false;
    }
    if (isdefined(self.enemy) && isplayer(self.enemy) && self.enemy.var_5206d4b9 > 0) {
        return false;
    }
    return true;
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x29151af4, Offset: 0x34f8
// Size: 0x678
function function_8347526a() {
    self endon(#"death");
    wait(4);
    while (true) {
        if (!level.var_a9e78bf7["pathabilityenabled"]) {
            wait(4);
            continue;
        }
        if (!function_c1802d32()) {
            wait(4);
            continue;
        }
        if (!self haspath() && !self.lastpathtime && gettime() - self.var_11f7b644 >= 6000) {
            wait(12);
            if (!function_c1802d32()) {
                wait(4);
                continue;
            }
            if (self haspath() || self.lastpathtime) {
                wait(4);
                continue;
            }
            var_a6c6348c = [];
            var_b990e3ba = getactorteamarray("axis");
            var_b990e3ba = arraysortclosest(var_b990e3ba, self.origin, 15, 1000, 10000);
            foreach (zombie in var_b990e3ba) {
                if (isdefined(zombie) && zombie.archetype == "zombie" && zombie haspath()) {
                    closestplayer = arraygetclosest(zombie.origin, level.activeplayers);
                    if (!isdefined(closestplayer)) {
                        continue;
                    }
                    if (distancesquared(closestplayer.origin, zombie.origin) < 400 * 400) {
                        continue;
                    }
                    queryresult = positionquery_source_navigation(zombie.origin, 100, 500, 70, 100, zombie);
                    if (isdefined(queryresult) && queryresult.data.size > 0) {
                        foreach (data in queryresult.data) {
                            array::add(var_a6c6348c, data.origin);
                        }
                    }
                    if (var_a6c6348c.size) {
                        var_7bc3009e = array::random(var_a6c6348c);
                        /#
                            recordline(self.origin, var_7bc3009e, (1, 0, 0), "run");
                        #/
                        function_abc05be8();
                        self forceteleport(var_7bc3009e);
                        wait(2);
                        self thread function_d94c729a();
                        wait(2);
                    }
                }
            }
            closestplayer = arraygetclosest(self.origin, level.activeplayers);
            playerforward = anglestoforward(closestplayer.angles);
            var_2d1236a = closestplayer.origin;
            var_2d1236a = getclosestpointonnavmesh(var_2d1236a, 300);
            if (isdefined(var_2d1236a)) {
                queryresult = positionquery_source_navigation(var_2d1236a, 450, 1200, 70, 100, self);
            }
            if (!isdefined(queryresult)) {
                var_2d1236a = closestplayer.origin;
                if (isdefined(var_2d1236a)) {
                    queryresult = positionquery_source_navigation(var_2d1236a, -6, 1000, 70, 100, self);
                }
            }
            if (isdefined(queryresult) && queryresult.data.size > 0) {
                foreach (data in queryresult.data) {
                    array::add(var_a6c6348c, data.origin);
                }
            }
            if (var_a6c6348c.size) {
                var_7bc3009e = array::random(var_a6c6348c);
                /#
                    recordline(self.origin, var_7bc3009e, (1, 0, 0), "run");
                #/
                function_abc05be8();
                self forceteleport(var_7bc3009e);
                wait(2);
                self thread function_d94c729a();
                wait(2);
                continue;
            }
        }
        wait(4);
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x182342d2, Offset: 0x3b78
// Size: 0x200
function function_48401071() {
    self endon(#"death");
    if (!isdefined(self.var_2985e88a)) {
        return;
    }
    if (self.archetype != "zombie") {
        return;
    }
    while (true) {
        if (isdefined(self.var_506b9d18) && (isdefined(self.in_the_ground) && self.in_the_ground || self.var_506b9d18)) {
            wait(0.05);
            /#
                recordenttext("run", self, (0, 1, 0), "run");
            #/
            continue;
        }
        var_382bd177 = self.var_2985e88a == "robot";
        var_6fc198b2 = isdefined(self.var_be85d412) && self.var_be85d412 || namespace_37cacec1::function_51828ce6();
        if (!var_382bd177 && !var_6fc198b2) {
            wait(0.05);
            /#
                recordenttext("run", self, (0, 1, 0), "run");
            #/
            continue;
        }
        if (self isinscriptedstate()) {
            if (!(isdefined(self.var_be85d412) && self.var_be85d412)) {
                /#
                    recordenttext("run", self, (0, 1, 0), "run");
                #/
                function_abc05be8();
            }
        } else {
            /#
                recordenttext("run", self, (0, 1, 0), "run");
            #/
            self thread function_d94c729a();
        }
        wait(0.05);
    }
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x1 linked
// Checksum 0x2005e176, Offset: 0x3d80
// Size: 0x96
function set_zombie_run_cycle(new_move_speed) {
    if (isdefined(new_move_speed)) {
        if (self.zombie_move_speed === new_move_speed) {
            return;
        }
        self.zombie_move_speed = new_move_speed;
    }
    if (isdefined(level.zm_variant_type_max)) {
        self.variant_type = randomint(level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]);
    }
    self.needs_run_update = 1;
    self notify(#"needs_run_update");
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x407c075c, Offset: 0x3e20
// Size: 0x3b4
function function_d0d9ed35() {
    self endon(#"death");
    self set_zombie_run_cycle("walk");
    rand_num = randomint(100);
    if (rand_num > level.var_a9e78bf7["levelonezombies"] + level.var_a9e78bf7["leveltwozombies"]) {
        self.var_d23140ed = 2;
        newhealth = level.var_a9e78bf7["levelthreehealth"];
    } else if (rand_num > level.var_a9e78bf7["levelonezombies"]) {
        self.var_d23140ed = 1;
        newhealth = level.var_a9e78bf7["leveltwohealth"];
    } else {
        self.var_d23140ed = 0;
        newhealth = level.var_a9e78bf7["levelonehealth"];
    }
    if (!(isdefined(self.var_d4d290e) && self.var_d4d290e)) {
        newhealth = namespace_37cacec1::function_165bd27a(newhealth);
        if (newhealth > 0) {
            self.health = newhealth;
        }
    }
    if (isdefined(self.var_b7a92141) && self.var_b7a92141) {
        self.health *= 5;
    } else if (self.var_30e91c0d === "sparky_upgraded") {
        self.health *= 4;
    } else if (self.var_30e91c0d === "on_fire_upgraded" && self.allowdeath) {
        self.health *= 4;
    }
    if (self.var_30e91c0d != "sparky_upgraded" && (!isdefined(self.var_30e91c0d) || self.var_30e91c0d != "on_fire_upgraded")) {
        self clientfield::set("bonus_zombie_eye_color", self.var_d23140ed);
        self thread zombie_utility::delayed_zombie_eye_glow();
    }
    self flag::wait_till("bzm_zombie_attack");
    rand_num = randomint(100);
    if (rand_num > level.var_a9e78bf7["walkpercent"] + level.var_a9e78bf7["runpercent"]) {
        self set_zombie_run_cycle("sprint");
    } else if (rand_num > level.var_a9e78bf7["walkpercent"]) {
        self set_zombie_run_cycle("run");
    } else {
        self set_zombie_run_cycle("walk");
    }
    if (self ai::get_behavior_attribute("suicidal_behavior") || self ai::get_behavior_attribute("spark_behavior")) {
        self set_zombie_run_cycle("sprint");
    }
    self thread function_470f7d28();
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x5 linked
// Checksum 0x85c072cb, Offset: 0x41e0
// Size: 0xf6
function function_470f7d28() {
    self endon(#"death");
    var_8a7e27c8 = self.zombie_move_speed;
    if (var_8a7e27c8 == "sprint") {
        return;
    }
    var_f3b07235 = level.var_a9e78bf7["sprinttoplayerdistance"] * level.var_a9e78bf7["sprinttoplayerdistance"];
    while (true) {
        if (isdefined(self.enemy) && distancesquared(self.enemy.origin, self.origin) > var_f3b07235) {
            self set_zombie_run_cycle("sprint");
        } else {
            self set_zombie_run_cycle(var_8a7e27c8);
        }
        wait(1);
    }
}

// Namespace namespace_293e8aad
// Params 13, eflags: 0x5 linked
// Checksum 0xf7c61e3, Offset: 0x42e0
// Size: 0x3f6
function function_48cb1ad1(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
    /#
        assert(self.archetype == "run");
    #/
    var_56559957 = smeansofdeath === "MOD_BURNED" && weapon === level.var_45cae8b1;
    if (isdefined(weapon)) {
        if (weapon == level.var_9e70dea1) {
            return 0;
        }
    }
    if (isplayer(eattacker) && self ai::get_behavior_attribute("spark_behavior")) {
        if (randomint(100) < 20) {
            if (isdefined(self.var_11f7b644) && gettime() - self.var_11f7b644 > 1000) {
                self clientfield::increment("sparky_damaged_fx");
            }
        }
    }
    if (isplayer(eattacker) && self ai::get_behavior_attribute("suicidal_behavior")) {
        if (randomint(100) < 60) {
            if (isdefined(self.var_11f7b644) && gettime() - self.var_11f7b644 > 1000) {
                self clientfield::increment("fire_damaged_fx");
            }
        }
        if (var_56559957) {
            idamage = 1;
        }
    }
    if (var_56559957 && !self ai::get_behavior_attribute("suicidal_behavior") && !self ai::get_behavior_attribute("spark_behavior")) {
        self clientfield::set("arch_actor_fire_fx", 1);
    }
    if (isdefined(eattacker.forceanhilateondeath) && isplayer(eattacker) && eattacker.forceanhilateondeath) {
        if (isdefined(level.bzm_worldpaused) && level.bzm_worldpaused) {
            self setignorepauseworld(1);
        }
        self clientfield::set("bonuszm_zombie_death_fx", 1);
        return (self.health + 1);
    }
    self thread function_f10fd3d1(weapon);
    if (isdefined(eattacker) && eattacker.archetype === "raps" && eattacker.team === "allies") {
        if (isdefined(level.bzm_worldpaused) && level.bzm_worldpaused) {
            self.forceanhilateondeath = 1;
            self setignorepauseworld(1);
        }
        self clientfield::set("bonuszm_zombie_death_fx", 1);
        return (self.health + 1);
    }
    return idamage;
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x5 linked
// Checksum 0x49f5324b, Offset: 0x46e0
// Size: 0xf4
function function_f10fd3d1(weapon) {
    self endon(#"death");
    if (isdefined(self.var_82253adf) && self.var_82253adf) {
        return;
    }
    self notify(#"hash_f10fd3d1");
    self endon(#"hash_f10fd3d1");
    if ((weapon.name == "flash_grenade" || isdefined(weapon) && weapon.name == "flash_grenade+none") && self.archetype === "zombie") {
        self.var_82253adf = 1;
        self asmsetanimationrate(0.65);
        wait(6);
        self.var_82253adf = 0;
        self asmsetanimationrate(1);
    }
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x5 linked
// Checksum 0xd9c8164a, Offset: 0x47e0
// Size: 0x1fc
function function_2bc18574(params) {
    if (isdefined(params.eattacker.forceanhilateondeath) && isplayer(params.eattacker) && params.eattacker.forceanhilateondeath) {
        if (isdefined(level.bzm_worldpaused) && level.bzm_worldpaused) {
            self setignorepauseworld(1);
        }
    }
    if (isdefined(self.archetype) && self.archetype == "parasite" && isplayer(params.eattacker) && !(isdefined(params.var_2585e9c3) && params.var_2585e9c3)) {
        if (level.currentdifficulty === "easy" || level.currentdifficulty === "normal") {
            self dodamage(self.health + 100, params.eattacker.origin);
        }
    }
    if (level.currentdifficulty === "easy" || level.currentdifficulty === "normal") {
        if (isdefined(self.archetype) && self.archetype == "amws" && isplayer(params.eattacker)) {
            self dodamage(self.health + 100, params.eattacker.origin);
        }
    }
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x5 linked
// Checksum 0x212a79c4, Offset: 0x49e8
// Size: 0x64
function function_285b856c(params) {
    if (isdefined(self.archetype) && self.archetype == "raps" && self.team == "axis") {
        self clientfield::set("bonuszm_meatball_death", 1);
    }
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x1 linked
// Checksum 0xabb52156, Offset: 0x4a58
// Size: 0xf6
function function_7effc669(var_f85c1f6a) {
    if (level flag::get("bzmExtraZombieCleared")) {
        return false;
    }
    if (!level flag::get("bzmObjectiveEnabled")) {
        return false;
    }
    if (namespace_37cacec1::function_5f2c4513() <= 0) {
        return false;
    }
    if (isdefined(level.var_bcd51977) && level.var_bcd51977) {
        return false;
    }
    if (!isdefined(level.var_a9e78bf7) || !(isdefined(level.var_a9e78bf7["zombifyenabled"]) && level.var_a9e78bf7["zombifyenabled"])) {
        return false;
    }
    if (isdefined(self.var_4f1bf25e) && isdefined(var_f85c1f6a) && self.var_4f1bf25e) {
        return false;
    }
    return true;
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0xa2cd2c3, Offset: 0x4b58
// Size: 0x1dc
function function_9bc25e40() {
    level endon(#"hash_e9fca3a");
    /#
        assert(level.var_a9e78bf7["run"]);
    #/
    var_df4e4d0f = getnavfaceregion(self.origin, 64);
    attacker = self waittill(#"death");
    if (!isdefined(self)) {
        return;
    }
    if (!function_7effc669(self)) {
        return;
    }
    if (isdefined(attacker) && isplayer(attacker)) {
        attacker thread function_11600557(self, attacker);
    }
    var_14e6a7e9 = self.origin;
    var_5b43e537 = self.angles;
    while (getaiteamarray("axis").size >= 24) {
        wait(randomintrange(2, 4));
    }
    while (level.var_17ded976 == gettime()) {
        wait(0.05);
    }
    while (isdefined(level.bzm_worldpaused) && level.bzm_worldpaused) {
        wait(1);
    }
    wait(level.var_a9e78bf7["extraspawngapmin"]);
    if (!function_7effc669(undefined)) {
        return;
    }
    level.var_17ded976 = gettime();
    level thread function_7e75b892(var_14e6a7e9, var_5b43e537, var_df4e4d0f);
}

// Namespace namespace_293e8aad
// Params 3, eflags: 0x1 linked
// Checksum 0x76e48ec7, Offset: 0x4d40
// Size: 0x1e4
function function_7e75b892(var_14e6a7e9, var_5b43e537, var_df4e4d0f) {
    if (level.var_b1955bd6 >= namespace_37cacec1::function_5f2c4513()) {
        return;
    }
    var_28b84d73 = level.var_9f14c2b8[0] spawner::spawn(1);
    if (isdefined(var_28b84d73)) {
        var_c3afd9e9 = namespace_37cacec1::function_ec036ed3(var_28b84d73, var_14e6a7e9, var_df4e4d0f);
        /#
            if (isdefined(level.activeplayers) && level.activeplayers.size) {
                recordcircle(var_c3afd9e9, 8, (1, 0.5, 0), "run");
                recordline(var_c3afd9e9, level.activeplayers[0].origin, (1, 0.5, 0), "run");
                record3dtext("run", level.activeplayers[0].origin, (1, 0.5, 0), "run");
                iprintln("run" + gettime());
            }
        #/
        var_28b84d73 thread function_cc657250();
        level.var_b1955bd6++;
        var_28b84d73.var_c5bc032a = 1;
        var_28b84d73 function_d82d1ce3(var_c3afd9e9, var_5b43e537);
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x730f70d5, Offset: 0x4f30
// Size: 0x54
function function_cc657250() {
    self waittill(#"death");
    level.var_d0e37460++;
    if (level.var_d0e37460 >= namespace_37cacec1::function_5f2c4513()) {
        level flag::set("bzmExtraZombieCleared");
    }
}

// Namespace namespace_293e8aad
// Params 2, eflags: 0x1 linked
// Checksum 0x80919f19, Offset: 0x4f90
// Size: 0x1a0
function function_d82d1ce3(origin, angles) {
    self endon(#"death");
    self.in_the_ground = 1;
    var_44459b10 = self setcontents(0);
    self setcontents(8192);
    self thread zombie_utility::hide_pop();
    level thread zombie_utility::zombie_rise_death(self);
    self orientmode("face default");
    self clientfield::set("zombie_riser_fx", 1);
    newangles = (0, angles[1], 0);
    neworigin = function_e183aac0(origin, 72, self);
    self hide();
    self forceteleport(neworigin, newangles);
    wait(0.05);
    self scene::play("scene_zombie_rise", self);
    self setcontents(var_44459b10);
    self.in_the_ground = 0;
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0xc310b125, Offset: 0x5138
// Size: 0x1f0
function function_3ca31ff8() {
    level.var_9a25f386 = array::remove_undefined(level.var_9a25f386);
    level.var_9a25f386 = array::remove_dead(level.var_9a25f386);
    if (isdefined(self.var_6ed74a15) && isinarray(level.var_9a25f386, self.var_6ed74a15)) {
        return self.var_6ed74a15;
    }
    possibletargets = [];
    foreach (target in level.var_9a25f386) {
        if (!isdefined(target.var_e7b4863e)) {
            target.var_e7b4863e = [];
            continue;
        }
        if (target.var_e7b4863e.size < 4 && !isinarray(possibletargets, target)) {
            array::add(possibletargets, target);
        }
    }
    if (possibletargets.size) {
        var_f2007328 = arraygetclosest(self.origin, possibletargets, 512);
        if (isdefined(var_f2007328)) {
            array::add(var_f2007328.var_e7b4863e, var_f2007328);
            self.var_6ed74a15 = var_f2007328;
            return var_f2007328;
        }
    }
    return undefined;
}

// Namespace namespace_293e8aad
// Params 2, eflags: 0x1 linked
// Checksum 0x44443b2d, Offset: 0x5330
// Size: 0x600
function function_8421a595(origin, players) {
    pixbeginevent("BZM_ClosestPlayerOverride");
    if (isdefined(self.var_398570da) && gettime() < self.var_398570da) {
        if (isdefined(self.var_8f16146f) && self.var_8f16146f != self) {
            pixendevent();
            self.favoriteenemy = self.var_8f16146f;
            self setentitytarget(self.var_8f16146f);
            return self.var_8f16146f;
        }
    }
    var_e766219c = [];
    validplayers = [];
    foreach (player in players) {
        if (player.sessionstate == "spectator") {
            continue;
        }
        if (player.sessionstate != "playing") {
            continue;
        }
        if (level.var_a9e78bf7["maxreachabilitylevel"] && isdefined(player.var_5206d4b9) && player.var_5206d4b9 >= level.var_a9e78bf7["maxreachabilitylevel"]) {
            continue;
        }
        if (!(isdefined(player.ignoreme) && player.ignoreme) && !player isplayinganimscripted() && !player laststand::player_is_in_laststand() && !player isnotarget()) {
            validplayers[validplayers.size] = player;
        }
    }
    if (validplayers.size) {
        closestplayer = arraygetclosest(origin, validplayers);
        var_e766219c[var_e766219c.size] = closestplayer;
        target = closestplayer;
        var_e2841a72 = distancesquared(origin, closestplayer.origin);
    }
    if (!(isdefined(self.var_4e78d51b) && self.var_4e78d51b)) {
        var_5774d8bb = getactorteamarray("allies", "team3");
        zombies = getaiarchetypearray("zombie", "axis");
        foreach (var_334590d0 in var_5774d8bb) {
            if (isdefined(var_334590d0.ignoreme) && var_334590d0.ignoreme) {
                continue;
            }
            if (isdefined(var_334590d0.ignoreall) && var_334590d0.ignoreall) {
                continue;
            }
            if (var_334590d0 isinscriptedstate()) {
                continue;
            }
            if (var_334590d0 == self) {
                continue;
            }
            attackercount = 0;
            if (isdefined(var_334590d0.attackercount)) {
                attackercount = var_334590d0.attackercount;
            }
            if (attackercount < 2) {
                var_e766219c[var_e766219c.size] = var_334590d0;
            }
        }
        if (var_e766219c.size) {
            var_3432f284 = arraygetclosest(origin, var_e766219c);
            var_7fd6db7c = distancesquared(origin, var_3432f284.origin);
        }
        if (isdefined(var_e2841a72) && isdefined(var_7fd6db7c)) {
            if (var_7fd6db7c < var_e2841a72) {
                target = var_3432f284;
            }
        } else {
            target = var_3432f284;
        }
    }
    self.var_398570da = gettime() + randomintrange(2000, 3500);
    self.zombie_do_not_update_goal = 0;
    if (isdefined(target) && !isplayer(target) && ispointonnavmesh(target.origin)) {
        target.last_valid_position = target.origin;
    }
    self.favoriteenemy = target;
    self.var_8f16146f = target;
    if (isdefined(target)) {
        self setentitytarget(target);
    }
    pixendevent();
    return target;
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x74de3f89, Offset: 0x5938
// Size: 0x1a4
function function_29e1570d() {
    self endon(#"death");
    if (level.var_a9e78bf7["startunaware"] && !(isdefined(level.var_3004e0c8) && level.var_3004e0c8)) {
        self flag::clear("bzm_zombie_attack");
        self.disabletargetservice = 1;
        self.ignoreme = 1;
        self.updatesight = 1;
        self.maxsightdistsqrd = 160000;
        self.fovcosine = 0.574;
        self thread function_b04fbef3();
        self thread function_7428c0cf();
        self thread function_190da7c8();
        self waittill(#"hash_bf975558");
        self namespace_37cacec1::function_d68296ac();
        level.var_3004e0c8 = 1;
        self thread function_5e4284a5();
        self flag::set("bzm_zombie_attack");
        self.disabletargetservice = 0;
        self.ignoreme = 0;
        self.updatesight = 0;
        self.maxsightdistsqrd = 2250000;
        self.fovcosine = 0;
        return;
    }
    self flag::set("bzm_zombie_attack");
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x9a8002f9, Offset: 0x5ae8
// Size: 0x138
function function_5e4284a5() {
    self endon(#"death");
    if (self isplayinganimscripted()) {
        return;
    }
    self.var_506b9d18 = 1;
    var_548c1f68 = array("scene_zombie_alerted_v1", "scene_zombie_alerted_v2", "scene_zombie_alerted_v3", "scene_zombie_alerted_v4");
    self notify(#"bhtn_action_notify", "taunt");
    if (self ai::get_behavior_attribute("spark_behavior")) {
        if (isdefined(self.var_11f7b644) && gettime() - self.var_11f7b644 > 1000) {
            self clientfield::increment("sparky_damaged_fx");
        }
    }
    if (isalive(self)) {
        self scene::play(array::random(var_548c1f68), self);
    }
    self.var_506b9d18 = 0;
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x1 linked
// Checksum 0xffeac134, Offset: 0x5c28
// Size: 0x12a
function function_e840531c(origin) {
    var_f8735d55 = array::get_all_closest(origin, getaiarchetypearray("zombie", "axis"), array(self), 30, 800);
    foreach (var_fc70c85a in var_f8735d55) {
        if (isdefined(var_fc70c85a) && isalive(var_fc70c85a)) {
            wait(level.var_a9e78bf7["alertnessspreaddelay"]);
            if (isdefined(var_fc70c85a)) {
                var_fc70c85a notify(#"hash_bf975558");
            }
        }
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x491ed48e, Offset: 0x5d60
// Size: 0x6a
function function_190da7c8() {
    self endon(#"death");
    self endon(#"hash_bf975558");
    while (true) {
        if (isdefined(self.enemy)) {
            break;
        }
        wait(1);
    }
    level thread function_e840531c(self.origin);
    self notify(#"hash_bf975558");
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0xfef5ab61, Offset: 0x5dd8
// Size: 0x52
function function_7428c0cf() {
    self endon(#"death");
    self endon(#"hash_bf975558");
    self waittill(#"damage");
    function_e840531c(self.origin);
    self notify(#"hash_bf975558");
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x50ec1ada, Offset: 0x5e38
// Size: 0xf8
function function_b04fbef3() {
    self endon(#"death");
    self endon(#"hash_bf975558");
    while (true) {
        if (!self haspath()) {
            var_df4e4d0f = getnavfaceregion(self.origin, 16);
            if (!isdefined(var_df4e4d0f)) {
                wait(randomintrange(2, 3));
                continue;
            }
            gotonode = namespace_37cacec1::function_5e408c24(self.origin, var_df4e4d0f, 64, 1024);
            if (isdefined(gotonode)) {
                self setgoal(gotonode);
            }
        }
        wait(randomintrange(4, 5));
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0xa3773ba9, Offset: 0x5f38
// Size: 0x8e
function function_745c9570() {
    self endon(#"death");
    if (self.archetype != "zombie") {
        return;
    }
    while (true) {
        if (!isdefined(self)) {
            break;
        }
        self.goalradius = 8;
        self.ignoreall = 0;
        if (!(isdefined(self.var_be85d412) && self.var_be85d412)) {
            self.ignoreme = 0;
        }
        self.team = "axis";
        wait(1);
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0xe76fcff1, Offset: 0x5fd0
// Size: 0x2e0
function function_a608d09() {
    self endon(#"death");
    prevorigin = self.origin;
    var_7628680f = undefined;
    level flag::wait_till("all_players_connected");
    if (isdefined(level.var_a9e78bf7["disablefailsafelogic"]) && level.var_a9e78bf7["disablefailsafelogic"]) {
        return;
    }
    while (true) {
        level.failsafe_waittime = 30;
        wait(level.failsafe_waittime);
        if (self.missinglegs) {
            wait(10);
        }
        if (!self flag::get("bzm_zombie_attack")) {
            wait(1);
            continue;
        }
        if (self isinscriptedstate()) {
            wait(1);
            continue;
        }
        if (isdefined(level.activeplayers) && level.activeplayers.size && abs(self.origin[2] - level.activeplayers[0].origin[2]) < -5000) {
            self.var_4f1bf25e = 1;
            self dodamage(self.health + 100, (0, 0, 0));
            break;
        }
        if (isdefined(var_7628680f) && distancesquared(self.origin, prevorigin) < 65536) {
            if (isdefined(self.enemy)) {
                if (distancesquared(self.origin, self.enemy.origin) < 65536) {
                    wait(1);
                    continue;
                }
            }
            self.var_4f1bf25e = 1;
            self dodamage(self.health + 100, (0, 0, 0));
            break;
        }
        if (isdefined(self.allowdeath) && isdefined(self) && !self haspath() && !self.lastpathtime && isdefined(self.var_11f7b644) && self.allowdeath) {
            self.var_4f1bf25e = 1;
            self dodamage(self.health + 100, (0, 0, 0));
            break;
        }
        prevorigin = self.origin;
        var_7628680f = gettime();
    }
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x1 linked
// Checksum 0xce053a16, Offset: 0x62b8
// Size: 0x6c6
function zombie_death_event(zombie) {
    attacker = zombie waittill(#"death");
    time_of_death = gettime();
    if (isdefined(zombie)) {
        zombie stopsounds();
    }
    if (!isdefined(zombie.damagehit_origin) && isdefined(attacker) && isalive(attacker) && isactor(attacker)) {
        zombie.damagehit_origin = attacker.origin;
    }
    if (!isdefined(zombie)) {
        return;
    }
    name = zombie.animname;
    if (isdefined(zombie.sndname)) {
        name = zombie.sndname;
    }
    zombie thread zombie_utility::zombie_eye_glow_stop();
    if (isactor(zombie)) {
        if (isdefined(zombie.damagemod) && zombie.damagemod == "MOD_CRUSH") {
            if (isdefined(attacker) && isdefined(attacker.archetype) && attacker.archetype == "raps") {
                launchdir = vectornormalize(zombie.origin - attacker.origin);
                zombie startragdoll();
                zombie launchragdoll((launchdir[0] * 70, launchdir[1] * 70, 70));
            }
        }
        if (zombie.damagemod == "MOD_GRENADE" || zombie.damagemod == "MOD_GRENADE_SPLASH" || zombie.damagemod == "MOD_EXPLOSIVE") {
            var_d40de94d = -76;
            if (isdefined(zombie.damagehit_origin) && distancesquared(zombie.origin, zombie.damagehit_origin) < var_d40de94d * var_d40de94d) {
                if (!(isdefined(zombie.is_on_fire) && zombie.is_on_fire) && !(isdefined(zombie.guts_explosion) && zombie.guts_explosion)) {
                    zombie thread zombie_utility::zombie_gut_explosion();
                }
            }
        }
    }
    if (isdefined(zombie.var_b7a92141) && zombie.var_b7a92141) {
        if (isdefined(zombie.damagelocation) && isinarray(array("torso_upper", "torso_mid"), zombie.damagelocation)) {
            radiusdamage(zombie.origin + (0, 0, 35), -56, 70, 20, undefined, "MOD_EXPLOSIVE");
        }
        zombie clientfield::set("bonuszm_zombie_death_fx", 5);
    } else if (zombie ai::get_behavior_attribute("suicidal_behavior") || zombie ai::get_behavior_attribute("spark_behavior")) {
        radiusdamage(zombie.origin + (0, 0, 35), -56, 70, 20, undefined, "MOD_EXPLOSIVE");
        if (zombie ai::get_behavior_attribute("spark_behavior")) {
            zombie clientfield::set("bonuszm_zombie_death_fx", 3);
        } else {
            zombie clientfield::set("bonuszm_zombie_death_fx", 2);
        }
        physicsexplosionsphere(zombie.origin, -56, 32, 2);
        if (zombie ai::get_behavior_attribute("spark_behavior")) {
            if (zombie ai::get_behavior_attribute("spark_behavior")) {
                if (isdefined(zombie.var_11f7b644) && gettime() - zombie.var_11f7b644 > 1000) {
                    zombie clientfield::increment("sparky_damaged_fx");
                }
            }
            level thread function_254de6e5(zombie.origin);
        } else if (zombie ai::get_behavior_attribute("suicidal_behavior") && self.var_30e91c0d === "on_fire_upgraded") {
            level thread function_2983ed79(zombie.origin);
        }
        zombie clientfield::set("arch_actor_fire_fx", 3);
    }
    zombie thread namespace_fdfaa57d::function_b67e03f7();
    if (isdefined(zombie.attacker) && isplayer(zombie.attacker)) {
        zombie.attacker notify(#"zom_kill", zombie);
    }
    level notify(#"zom_kill");
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x1 linked
// Checksum 0xaa373082, Offset: 0x6988
// Size: 0x4dc
function function_2983ed79(startorigin) {
    if (isdefined(level.var_e8b3e9b3) && level.var_e8b3e9b3) {
        return;
    }
    if (!mayspawnentity()) {
        return;
    }
    level.var_e8b3e9b3 = 1;
    var_b990e3ba = getactorteamarray("axis");
    var_d075657f = [];
    foreach (zombie in var_b990e3ba) {
        if (!isdefined(zombie.var_30e91c0d)) {
            array::add(var_d075657f, zombie);
            continue;
        }
        if (zombie.var_30e91c0d != "sparky_upgraded" && zombie.var_30e91c0d != "on_fire_upgraded" && zombie.var_30e91c0d != "sparky" && zombie.var_30e91c0d != "on_fire") {
            array::add(var_d075657f, zombie);
        }
    }
    var_36a2aeee = arraygetclosest(startorigin, var_d075657f, 500);
    if (!isdefined(var_36a2aeee)) {
        return;
    }
    target = var_36a2aeee;
    if (isdefined(target) && isalive(target)) {
        if (isdefined(target) && isalive(target) && target.allowdeath) {
            target ai::set_behavior_attribute("suicidal_behavior", 1);
            target clientfield::set("arch_actor_fire_fx", 1);
            target clientfield::set("bonuszm_zombie_on_fire_fx", 1);
            target.var_4e78d51b = 1;
        }
    }
    foreach (zombie in var_b990e3ba) {
        if (!isdefined(zombie.var_30e91c0d)) {
            array::add(var_d075657f, zombie);
            continue;
        }
        if (zombie.var_30e91c0d != "sparky_upgraded" && zombie.var_30e91c0d != "on_fire_upgraded" && zombie.var_30e91c0d != "sparky" && zombie.var_30e91c0d != "on_fire") {
            array::add(var_d075657f, zombie);
        }
    }
    var_36a2aeee = arraygetclosest(startorigin, var_d075657f, 500);
    if (!isdefined(var_36a2aeee)) {
        return;
    }
    target = var_36a2aeee;
    if (isdefined(target) && isalive(target)) {
        if (isdefined(target) && isalive(target) && target.allowdeath) {
            target ai::set_behavior_attribute("suicidal_behavior", 1);
            target clientfield::set("arch_actor_fire_fx", 1);
            target clientfield::set("bonuszm_zombie_on_fire_fx", 1);
            target.var_4e78d51b = 1;
        }
    }
    level.var_e8b3e9b3 = 0;
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x1 linked
// Checksum 0x6910c59f, Offset: 0x6e70
// Size: 0x488
function function_254de6e5(startorigin) {
    if (isdefined(level.var_fd8eeb0b) && level.var_fd8eeb0b) {
        return;
    }
    if (!mayspawnentity()) {
        return;
    }
    if (isdefined(level.var_4b68a2b1) && gettime() < level.var_4b68a2b1) {
        return;
    }
    level.var_fd8eeb0b = 1;
    endtime = gettime() + 6000;
    fxorg = spawn("script_model", startorigin + (0, 0, 40));
    wait(0.5);
    if (!isdefined(fxorg)) {
        level.var_fd8eeb0b = 0;
        return;
    }
    fxorg setignorepauseworld(1);
    fxorg setmodel("tag_origin");
    var_40ab2807 = 0;
    var_69e07654 = 3;
    while (gettime() < endtime) {
        if (var_40ab2807 >= var_69e07654) {
            break;
        }
        var_b990e3ba = getactorteamarray("axis");
        var_d075657f = [];
        foreach (zombie in var_b990e3ba) {
            if (!isdefined(zombie.var_30e91c0d)) {
                array::add(var_d075657f, zombie);
                continue;
            }
            if (zombie.var_30e91c0d != "sparky_upgraded" && zombie.var_30e91c0d != "on_fire_upgraded" && zombie.var_30e91c0d != "sparky" && zombie.var_30e91c0d != "on_fire") {
                array::add(var_d075657f, zombie);
            }
        }
        var_36a2aeee = arraygetclosest(startorigin, var_d075657f, 600);
        if (!isdefined(var_36a2aeee)) {
            break;
        }
        target = var_36a2aeee;
        target_origin = target.origin + (0, 0, 40);
        fxorg clientfield::set("sparky_trail_fx", 1);
        fxorg moveto(target_origin, 0.1);
        fxorg util::waittill_any_timeout(3, "movedone");
        if (isdefined(target) && isalive(target)) {
            fxorg clientfield::increment("sparky_attack_fx");
            target clientfield::set("bonuszm_zombie_death_fx", 4);
            wait(0.2);
            if (isdefined(target) && isalive(target) && target.allowdeath) {
                target.forceanhilateondeath = 1;
                target kill();
                var_40ab2807++;
            }
        }
    }
    if (isdefined(fxorg)) {
        fxorg delete();
    }
    level.var_4b68a2b1 = gettime() + 6000;
    level.var_fd8eeb0b = 0;
}

// Namespace namespace_293e8aad
// Params 3, eflags: 0x1 linked
// Checksum 0xa4d4032c, Offset: 0x7300
// Size: 0x94
function function_e183aac0(var_8e25979b, dist, ignore) {
    start = var_8e25979b + (0, 0, dist);
    end = var_8e25979b - (0, 0, dist);
    a_trace = groundtrace(start, end, 0, ignore, 1);
    return a_trace["position"];
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x189c9074, Offset: 0x73a0
// Size: 0x134
function function_3e0291d0() {
    if (!sessionmodeiscampaignzombiesgame()) {
        return;
    }
    if (isdefined(level.var_a9e78bf7)) {
        level.var_b1955bd6 = 0;
        level.var_d0e37460 = 0;
        zombies = getaiarchetypearray("zombie", "axis");
        foreach (zombie in zombies) {
            if (isdefined(zombie.allowdeath) && zombie.allowdeath) {
                zombie kill();
                wait(0.05);
            }
        }
    }
    level flag::set("bzmExtraZombieCleared");
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x7d29a4ae, Offset: 0x74e0
// Size: 0x1fa
function function_c4dba52c() {
    if (!sessionmodeiscampaignzombiesgame()) {
        return;
    }
    if (isdefined(level.var_a9e78bf7) && level.var_a9e78bf7["forcecleanuponcompletion"]) {
        level.var_bcd51977 = 1;
        level.var_b1955bd6 = 0;
        level.var_d0e37460 = 0;
        zombies = getaiteamarray("axis");
        foreach (zombie in zombies) {
            if (isdefined(zombie.var_c5bc032a) && zombie.var_c5bc032a) {
                zombie kill();
                wait(0.05);
            }
        }
        return;
    }
    if (isdefined(level.var_a9e78bf7["skipobjectivewait"]) && level.var_a9e78bf7["skipobjectivewait"]) {
        return;
    }
    level thread function_9b15c7b();
    while (true) {
        if (isdefined(level.var_a9e78bf7) && level.var_a9e78bf7["zombifyenabled"]) {
            if (!level.var_b1955bd6 && namespace_37cacec1::function_5f2c4513() || !level flag::get("bzmExtraZombieCleared")) {
                wait(1);
                continue;
            }
        }
        break;
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x5 linked
// Checksum 0x2baf712e, Offset: 0x76e8
// Size: 0x31c
function function_9b15c7b() {
    level notify(#"hash_11692fba");
    level endon(#"hash_11692fba");
    while (true) {
        if (isdefined(level.var_a9e78bf7) && level.var_a9e78bf7["zombifyenabled"]) {
            if (!level.var_b1955bd6 && namespace_37cacec1::function_5f2c4513() || !level flag::get("bzmExtraZombieCleared")) {
                zombies = getaiteamarray("axis");
                foreach (zombie in zombies) {
                    if (isdefined(zombie.allowdeath) && isdefined(zombie) && isalive(zombie) && isactor(zombie) && !zombie haspath() && !zombie.lastpathtime && isdefined(zombie.var_11f7b644) && gettime() - zombie.var_11f7b644 >= 6000 && zombie.allowdeath) {
                        zombie kill();
                        util::wait_network_frame();
                    }
                }
                zombies = getaiteamarray("axis");
                if (zombies.size < 4) {
                    foreach (zombie in zombies) {
                        zombie oed::function_e228c18a();
                        zombie setforcenocull();
                        if (isactor(zombie)) {
                            zombie.var_4e78d51b = 1;
                            zombie set_zombie_run_cycle("sprint");
                        }
                    }
                }
                break;
            }
        }
        wait(0.5);
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0xa2d0cc75, Offset: 0x7a10
// Size: 0x26a
function function_11692fba() {
    if (!sessionmodeiscampaignzombiesgame()) {
        return;
    }
    if (isdefined(level.var_a9e78bf7) && level.var_a9e78bf7["forcecleanuponcompletion"]) {
        level.var_b1955bd6 = 0;
        level.var_d0e37460 = 0;
        level flag::clear("bzmExtraZombieCleared");
        level flag::clear("bzmObjectiveEnabled");
        zombies = getaiteamarray("axis");
        foreach (zombie in zombies) {
            if (isdefined(zombie.var_c5bc032a) && isdefined(zombie) && zombie.var_c5bc032a) {
                zombie kill();
                util::wait_network_frame();
            }
        }
        return;
    }
    level thread function_9b15c7b();
    while (true) {
        if (isdefined(level.var_a9e78bf7) && level.var_a9e78bf7["zombifyenabled"]) {
            if (!level.var_b1955bd6 && namespace_37cacec1::function_5f2c4513() || !level flag::get("bzmExtraZombieCleared")) {
                wait(1);
                continue;
            }
        }
        break;
    }
    level.var_b1955bd6 = 0;
    level.var_d0e37460 = 0;
    level flag::clear("bzmExtraZombieCleared");
    level flag::clear("bzmObjectiveEnabled");
    level notify(#"hash_11692fba");
}

// Namespace namespace_293e8aad
// Params 2, eflags: 0x1 linked
// Checksum 0x5438f43d, Offset: 0x7c88
// Size: 0x172
function function_88adb698(var_454219da, var_a50fa19f) {
    if (!sessionmodeiscampaignzombiesgame()) {
        return;
    }
    /#
        assert(isdefined(var_454219da));
    #/
    namespace_a432d965::function_da5f2c0d(getdvarstring("mapname"), var_454219da);
    if (!var_a50fa19f && level.var_a9e78bf7["onlyuseonstart"]) {
        level.var_a9e78bf7["extraspawns"] = 0;
    }
    if (!namespace_37cacec1::function_5f2c4513()) {
        level flag::set("bzmExtraZombieCleared");
    } else {
        level flag::clear("bzmExtraZombieCleared");
    }
    level flag::set("bzmObjectiveEnabled");
    level.var_bcd51977 = 0;
    level.var_b1955bd6 = 0;
    level.var_d0e37460 = 0;
    namespace_2396e2d7::function_b6c845e8();
    function_aaa07980();
    level notify(#"hash_2d2866aa");
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0xa76eb2a6, Offset: 0x7e08
// Size: 0xa0
function function_fa34e301() {
    self notify(#"hash_fa34e301");
    self endon(#"hash_fa34e301");
    self endon(#"hash_3f7b661c");
    waittillframeend();
    while (true) {
        level clientfield::set("cybercom_disabled", 1);
        self cybercom_tacrig::function_8ffa26e2("cybercom_playermovement", 1);
        self cybercom_tacrig::function_8ffa26e2("cybercom_copycat", 1);
        wait(0.1);
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x0
// Checksum 0x11961ad7, Offset: 0x7eb0
// Size: 0x60
function function_5abd553b() {
    self endon(#"disconnect");
    self endon(#"death");
    while (true) {
        var_455568c4 = self waittill(#"hash_62a3f030");
        array::add(level.var_9a25f386, var_455568c4);
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x5 linked
// Checksum 0xc81cc05, Offset: 0x7f18
// Size: 0x52c
function function_fcf02f23() {
    /#
        assert(isplayer(self));
    #/
    mapname = getdvarstring("mapname");
    var_f0b98892 = self savegame::function_36adbb9c("saved_weapon", undefined);
    if (!ismapsublevel(mapname) && getdvarint("ui_blocksaves") != 0) {
        var_f0b98892 = undefined;
    }
    if (!isdefined(var_f0b98892)) {
        self takeallweapons();
    } else {
        primary_weapons = self getweaponslistprimaries();
        var_872e164d = array::exclude(self getweaponslist(0), primary_weapons);
        arrayremovevalue(var_872e164d, level.weaponbasemelee);
        foreach (offhand_weapon in var_872e164d) {
            self takeweapon(offhand_weapon);
            self sortheldweapons();
        }
    }
    primaryoffhand = getweapon("frag_grenade");
    primaryoffhandcount = 4;
    self giveweapon(primaryoffhand);
    self setweaponammoclip(primaryoffhand, primaryoffhandcount);
    self.grenadetypeprimary = primaryoffhand;
    self.grenadetypeprimarycount = primaryoffhandcount;
    self ability_util::gadget_reset(primaryoffhand, 0, 0, 0);
    secondaryoffhand = getweapon("flash_grenade");
    secondaryoffhandcount = 4;
    self giveweapon(secondaryoffhand);
    self setweaponammoclip(secondaryoffhand, secondaryoffhandcount);
    self.grenadetypesecondary = secondaryoffhand;
    self.grenadetypesecondarycount = secondaryoffhandcount;
    self ability_util::gadget_reset(secondaryoffhand, 0, 0, 0);
    if (!isdefined(var_f0b98892)) {
        if (mapname == "cp_mi_cairo_infection") {
            startweapon = getweapon("ar_standard");
        } else {
            startweapon = getweapon("pistol_standard");
        }
        self giveweapon(startweapon);
        self switchtoweapon(startweapon);
        self givemaxammo(startweapon);
    }
    self sortheldweapons();
    if (isdefined(startweapon)) {
        self switchtoweapon(startweapon);
    }
    self namespace_d00ec32::function_c219b381();
    self cybercom_tacrig::function_78908229();
    self cybercom_tacrig::function_8ffa26e2("cybercom_copycat", 1);
    primary_weapons = self getweaponslistprimaries();
    var_872e164d = array::exclude(self getweaponslist(0), primary_weapons);
    arrayremovevalue(var_872e164d, level.weaponbasemelee);
    /#
        assert(isdefined(var_872e164d) && isarray(var_872e164d) && var_872e164d.size == 2);
    #/
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x5 linked
// Checksum 0x8d114811, Offset: 0x8450
// Size: 0x8a
function function_f22c67b() {
    foreach (player in level.activeplayers) {
        player thread function_fcf02f23();
    }
}

// Namespace namespace_293e8aad
// Params 2, eflags: 0x5 linked
// Checksum 0xf64e29c8, Offset: 0x84e8
// Size: 0xb4
function function_203903e(player, timeout) {
    player endon(#"disconnect");
    player endon(#"death");
    /#
        assert(isdefined(player) && isplayer(player));
    #/
    timeout = gettime() + timeout * 1000;
    do {
        util::wait_network_frame();
    } while (!player isstreamerready() && gettime() < timeout);
}

