#using scripts/cp/_util;
#using scripts/shared/vehicles/_quadtank;
#using scripts/shared/callbacks_shared;
#using scripts/shared/util_shared;

#namespace namespace_855113f3;

// Namespace namespace_855113f3
// Params 0, eflags: 0x0
// namespace_855113f3<file_0>::function_35209d64
// Checksum 0xee5b8adf, Offset: 0x1c8
// Size: 0x3c
function function_35209d64() {
    self thread function_ea61aedc();
    callback::on_vehicle_damage(&function_610493ff, self);
}

// Namespace namespace_855113f3
// Params 0, eflags: 0x0
// namespace_855113f3<file_0>::function_ea61aedc
// Checksum 0xe8ab1e2a, Offset: 0x210
// Size: 0x18c
function function_ea61aedc() {
    self endon(#"death");
    self endon(#"hash_f1e417ec");
    var_fae93870 = 0;
    var_c1df3693 = 2;
    var_9a15ea97 = getweapon("launcher_standard");
    while (true) {
        self notify(#"hash_82f5563d");
        missile = self waittill(#"projectile_applyattractor");
        if (missile.weapon === var_9a15ea97) {
            var_fae93870++;
            if (var_fae93870 >= var_c1df3693) {
                var_fae93870 = 0;
                foreach (player in level.activeplayers) {
                    player thread util::show_hint_text(%OBJECTIVES_QUAD_TANK_HINT_TROPHY, 0, "quad_tank_trophy_hint_disable");
                    player thread function_82f5563d(self);
                }
                var_c1df3693 *= 2;
            }
            wait(2);
        }
    }
}

// Namespace namespace_855113f3
// Params 1, eflags: 0x0
// namespace_855113f3<file_0>::function_82f5563d
// Checksum 0x88565738, Offset: 0x3a8
// Size: 0x70
function function_82f5563d(var_ac4390f) {
    var_ac4390f endon(#"hash_82f5563d");
    var_ac4390f endon(#"death");
    self endon(#"death");
    var_ac4390f util::waittill_any("trophy_system_disabled", "trophy_system_destroyed");
    self notify(#"hash_82f5563d");
    var_ac4390f notify(#"hash_82f5563d");
}

// Namespace namespace_855113f3
// Params 2, eflags: 0x0
// namespace_855113f3<file_0>::function_610493ff
// Checksum 0xdd17963, Offset: 0x420
// Size: 0x164
function function_610493ff(obj, params) {
    if (isplayer(params.eattacker) && self quadtank::function_fcd2c4ce() && issubstr(params.smeansofdeath, "BULLET")) {
        player = params.eattacker;
        if (isdefined(player.var_d4b7c617)) {
            player.var_d4b7c617 += params.idamage;
        } else {
            player.var_d4b7c617 = params.idamage;
        }
        if (player.var_d4b7c617 >= 999) {
            player.var_d4b7c617 = 0;
            player notify(#"hash_d9337df");
            player thread util::show_hint_text(%OBJECTIVES_QUAD_TANK_HINT_ROCKET, 0, "quad_tank_rocket_hint_disable");
            player thread function_d9337df(self);
        }
    }
}

// Namespace namespace_855113f3
// Params 1, eflags: 0x0
// namespace_855113f3<file_0>::function_d9337df
// Checksum 0xcdb4a8fd, Offset: 0x590
// Size: 0x10e
function function_d9337df(var_ac4390f) {
    var_ac4390f endon(#"death");
    self endon(#"death");
    self endon(#"hash_d9337df");
    while (true) {
        n_damage, e_attacker, direction_vec, var_2f950561, damagetype, modelname, tagname, partname, weapon, idflags = var_ac4390f waittill(#"damage");
        if (weapon.weapclass === "rocketlauncher" && isplayer(e_attacker)) {
            var_ac4390f notify(#"hash_d9337df");
            self notify(#"hash_d9337df");
        }
    }
}

