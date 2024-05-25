#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/serverfaceanim_shared;
#using scripts/shared/gameskill_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_2396e2d7;

// Namespace namespace_2396e2d7
// Params 0, eflags: 0x1 linked
// Checksum 0x3511d7ed, Offset: 0x578
// Size: 0x314
function function_fc1970dd() {
    level.var_bcf55096 = [];
    level.var_bcf55096["female"] = [];
    level.var_3fae1bc = 0;
    if (isdefined(level.var_a9e78bf7["aitypeFemale"])) {
        array::add(level.var_bcf55096["female"], "actor_" + level.var_a9e78bf7["aitypeFemale"]);
        if (isdefined(level.var_a9e78bf7["femaleSpawnChance"])) {
            level.var_3fae1bc = int(level.var_a9e78bf7["femaleSpawnChance"]);
        }
    }
    level.var_bcf55096["male"] = [];
    if (isdefined(level.var_a9e78bf7["aitypeMale1"])) {
        array::add(level.var_bcf55096["male"], "actor_" + level.var_a9e78bf7["aitypeMale1"]);
    }
    if (isdefined(level.var_a9e78bf7["aitypeMale2"])) {
        if (isdefined(level.var_a9e78bf7["maleSpawnChance2"]) && randomint(100) < level.var_a9e78bf7["maleSpawnChance2"]) {
            array::add(level.var_bcf55096["male"], "actor_" + level.var_a9e78bf7["aitypeMale2"]);
        }
    }
    if (isdefined(level.var_a9e78bf7["aitypeMale3"])) {
        if (isdefined(level.var_a9e78bf7["maleSpawnChance3"]) && randomint(100) < level.var_a9e78bf7["maleSpawnChance3"]) {
            array::add(level.var_bcf55096["male"], "actor_" + level.var_a9e78bf7["aitypeMale3"]);
        }
    }
    if (isdefined(level.var_a9e78bf7["aitypeMale4"])) {
        if (isdefined(level.var_a9e78bf7["maleSpawnChance4"]) && randomint(100) < level.var_a9e78bf7["maleSpawnChance4"]) {
            array::add(level.var_bcf55096["male"], "actor_" + level.var_a9e78bf7["aitypeMale4"]);
        }
    }
}

// Namespace namespace_2396e2d7
// Params 0, eflags: 0x1 linked
// Checksum 0xbbba969c, Offset: 0x898
// Size: 0xf8
function function_9bb9e127() {
    if (!isdefined(level.var_bcf55096)) {
        return undefined;
    }
    if (!level.var_bcf55096.size) {
        return undefined;
    }
    var_e24f6a0d = undefined;
    var_bc003134 = randomint(100) < level.var_3fae1bc;
    if (var_bc003134 && level.var_bcf55096["female"].size) {
        var_e24f6a0d = array::random(level.var_bcf55096["female"]);
    } else {
        var_e24f6a0d = array::random(level.var_bcf55096["male"]);
    }
    assert(isdefined(var_e24f6a0d));
    return var_e24f6a0d;
}

// Namespace namespace_2396e2d7
// Params 0, eflags: 0x1 linked
// Checksum 0x880c9b2f, Offset: 0x998
// Size: 0x3a
function function_b6c845e8() {
    if (level.var_a9e78bf7["zombifyenabled"]) {
        level.var_78175c63 = &function_d78435a0;
        return;
    }
    level.var_78175c63 = undefined;
}

// Namespace namespace_2396e2d7
// Params 1, eflags: 0x5 linked
// Checksum 0x9d176e31, Offset: 0x9e0
// Size: 0x220
function private function_cf0834db(spawner) {
    if (isdefined(spawner.targetname) && (isdefined(spawner.targetname) && (spawner.archetype == "direwolf" || spawner.archetype == "civilian" || issubstr(spawner.classname, "hero") || issubstr(spawner.classname, "boss") || issubstr(spawner.targetname, "hakim")) || issubstr(spawner.targetname, "chase_bomber")) || spawner.targetname === "comm_relay_igc_robot" || spawner.targetname === "robot_wrestles_maretti" || spawner.targetname === "cin_lot_09_02_pursuit_vign_wallsmash_robot" || spawner.targetname === "cin_gen_hendricksmoment_riphead_robot" || spawner.targetname === "standdown_robot01" || spawner.targetname === "standdown_robot02" || spawner.targetname === "standdown_robot03" || spawner.targetname === "rainman" || spawner.targetname === "balcony_bash_robot") {
        return false;
    }
    if (isdefined(spawner.script_vehicleride)) {
        return false;
    }
    return true;
}

// Namespace namespace_2396e2d7
// Params 1, eflags: 0x5 linked
// Checksum 0xc01f17ff, Offset: 0xc08
// Size: 0x64
function private function_aa71a1e8(spawner) {
    if (!isdefined(spawner.targetname)) {
        return true;
    }
    if (spawner.targetname == "foundry_hackable_vehicle" || spawner.targetname == "hijack_diaz_wasp_spawnpoint") {
        return false;
    }
    return true;
}

// Namespace namespace_2396e2d7
// Params 0, eflags: 0x1 linked
// Checksum 0xf8b5b829, Offset: 0xc78
// Size: 0x2a6
function function_559632b9() {
    var_6cc76a5d = 0;
    var_fcbd82a5 = 0;
    if (!(isdefined(level.var_64b9a8b0) && level.var_64b9a8b0)) {
        zombies = getactorteamarray("axis");
        foreach (zombie in zombies) {
            if (zombie.archetype == "zombie") {
                if (zombie ai::get_behavior_attribute("suicidal_behavior")) {
                    var_fcbd82a5++;
                    continue;
                }
                if (zombie ai::get_behavior_attribute("spark_behavior")) {
                    var_6cc76a5d++;
                }
            }
        }
    }
    if (randomint(100) < level.var_a9e78bf7["deimosinfectedzombiechance"] && var_6cc76a5d < 2) {
        return "deimos_zombie";
    } else if (randomint(100) < level.var_a9e78bf7["sparkzombieupgradedchance"] && var_6cc76a5d < 1) {
        return "sparky_upgraded";
    } else if (randomint(100) < level.var_a9e78bf7["sparkzombiechance"] && var_6cc76a5d < 1) {
        return "sparky";
    } else if (randomint(100) < level.var_a9e78bf7["suicidalzombieupgradedchance"] && var_6cc76a5d < 2) {
        return "on_fire_upgraded";
    } else if (randomint(100) < level.var_a9e78bf7["suicidalzombiechance"] && var_6cc76a5d < 2) {
        return "on_fire";
    }
    return "";
}

// Namespace namespace_2396e2d7
// Params 5, eflags: 0x1 linked
// Checksum 0x458b2360, Offset: 0xf28
// Size: 0x6de
function function_d78435a0(b_force, str_targetname, v_origin, v_angles, bignorespawninglimit) {
    if (!isdefined(b_force)) {
        b_force = 0;
    }
    e_spawned = undefined;
    force_spawn = 0;
    makeroom = 0;
    infinitespawn = 0;
    deleteonzerocount = 0;
    /#
        if (getdvarstring("aitypeMale3") != "aitypeMale3") {
            return;
        }
    #/
    if (!spawner::check_player_requirements()) {
        return;
    }
    while (true) {
        if (!(isdefined(bignorespawninglimit) && bignorespawninglimit)) {
            spawner::global_spawn_throttle(1);
        }
        if (isdefined(self.lastspawntime) && self.lastspawntime >= gettime()) {
            wait(0.05);
            continue;
        }
        break;
    }
    if (isactorspawner(self)) {
        if (isdefined(self.spawnflags) && (self.spawnflags & 2) == 2) {
            makeroom = 1;
        }
    } else if (isvehiclespawner(self)) {
        if (isdefined(self.spawnflags) && (self.spawnflags & 8) == 8) {
            makeroom = 1;
        }
    }
    if (isdefined(self.spawnflags) && (b_force || (self.spawnflags & 16) == 16) || isdefined(self.script_forcespawn)) {
        force_spawn = 1;
    }
    if (isdefined(self.spawnflags) && (self.spawnflags & 64) == 64) {
        infinitespawn = 1;
    }
    if (!isdefined(e_spawned)) {
        if (isactorspawner(self)) {
            assert(isdefined(self.archetype));
            var_8b333c37 = function_cf0834db(self);
            if (self.team == "axis" && var_8b333c37) {
                var_2985e88a = self.archetype;
                var_1a2d16a4 = function_559632b9();
                if (self.archetype == "warlord" || var_1a2d16a4 == "on_fire_upgraded" || var_1a2d16a4 == "sparky_upgraded") {
                    e_spawned = self spawnfromspawner(str_targetname, 1, makeroom, infinitespawn, "actor_spawner_bo3_zombie_bonuszm_warlord");
                    if (self.archetype == "warlord") {
                        e_spawned.var_6ad7f3f8 = 1;
                        e_spawned.var_d4d290e = 1;
                    }
                } else {
                    zombify = 1;
                    var_e24f6a0d = function_9bb9e127();
                    if (isdefined(var_e24f6a0d)) {
                        e_spawned = self spawnfromspawner(str_targetname, 1, makeroom, infinitespawn, var_e24f6a0d, zombify);
                    } else {
                        e_spawned = self spawnfromspawner(str_targetname, 1, makeroom, infinitespawn);
                    }
                    if (isdefined(e_spawned) && isdefined(var_2985e88a)) {
                        e_spawned.var_2985e88a = var_2985e88a;
                        if (var_1a2d16a4 == "deimos_zombie") {
                            e_spawned.var_b7a92141 = 1;
                        }
                    }
                }
                if (isdefined(e_spawned)) {
                    e_spawned.target = self.target;
                    e_spawned.var_30e91c0d = var_1a2d16a4;
                }
            } else {
                e_spawned = self spawnfromspawner(str_targetname, force_spawn, makeroom, infinitespawn);
            }
        } else {
            var_261da234 = function_aa71a1e8(self);
            var_e24f6a0d = undefined;
            if (var_261da234 && isdefined(self.archetype)) {
                if (self.archetype == "wasp") {
                    var_e24f6a0d = "spawner_zombietron_parasite_purple_cpzm";
                } else if (self.archetype == "raps") {
                    var_e24f6a0d = "spawner_zombietron_veh_meatball_small";
                }
            }
            if (isdefined(var_e24f6a0d)) {
                e_spawned = self spawnfromspawner(str_targetname, force_spawn, makeroom, infinitespawn, var_e24f6a0d);
            } else {
                e_spawned = self spawnfromspawner(str_targetname, force_spawn, makeroom, infinitespawn);
            }
        }
    }
    if (isdefined(e_spawned)) {
        e_spawned.var_11f7b644 = gettime();
        level.global_spawn_count++;
        if (isdefined(level.run_custom_function_on_ai)) {
            e_spawned thread [[ level.run_custom_function_on_ai ]](self, str_targetname, force_spawn);
        }
        if (isdefined(v_origin) || isdefined(v_angles)) {
            e_spawned spawner::teleport_spawned(v_origin, v_angles);
        }
        self.lastspawntime = gettime();
    }
    if (isdefined(self.script_delete_on_zero) && (deleteonzerocount || self.script_delete_on_zero) && isdefined(self.count) && self.count <= 0) {
        self delete();
    }
    if (issentient(e_spawned)) {
        if (!spawner::spawn_failed(e_spawned)) {
            return e_spawned;
        }
        return;
    }
    return e_spawned;
}

