#using scripts/codescripts/struct;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace foy_turret;

// Namespace foy_turret
// Method(s) 0 Total 0
class class_6fd92933 {

}

// Namespace foy_turret
// Params 0, eflags: 0x2
// Checksum 0xbf5b3d42, Offset: 0x298
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("foy_turret", &__init__, undefined, undefined);
}

// Namespace foy_turret
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x2d0
// Size: 0x2
function __init__() {
    
}

#namespace namespace_ce2d510;

// Namespace namespace_ce2d510
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x2e0
// Size: 0x2
function __constructor() {
    
}

// Namespace namespace_ce2d510
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x2f0
// Size: 0x2
function __destructor() {
    
}

// Namespace namespace_ce2d510
// Params 3, eflags: 0x0
// Checksum 0x4667b0a3, Offset: 0x300
// Size: 0xda
function function_66f910ed(vehicle, var_e45a16d2, var_6cdabc79) {
    self.m_vehicle = vehicle;
    self.m_vehicle flag::init("gunner_position_occupied");
    if (isdefined(var_e45a16d2)) {
        var_f73d6972 = getent(var_e45a16d2, "targetname");
        var_dfb53de7 = spawner::simple_spawn_single(var_f73d6972);
        var_dfb53de7 vehicle::get_in(self.m_vehicle, "driver", 1);
    }
    if (isdefined(var_6cdabc79)) {
        self.var_ee76385b = getent(var_6cdabc79, "targetname");
    }
    self thread turret_think();
}

// Namespace namespace_ce2d510
// Params 0, eflags: 0x0
// Checksum 0xf06699b0, Offset: 0x3e8
// Size: 0x62
function turret_think() {
    self.m_vehicle endon(#"death");
    self thread vehicle_death();
    self waittill(#"hash_2919200c");
    if (isdefined(self.var_ee76385b)) {
        self thread gunner_think(1);
        return;
    }
    self thread gunner_think(0);
}

// Namespace namespace_ce2d510
// Params 0, eflags: 0x0
// Checksum 0x23131268, Offset: 0x458
// Size: 0xb
function function_2919200c() {
    self notify(#"hash_2919200c");
}

// Namespace namespace_ce2d510
// Params 1, eflags: 0x0
// Checksum 0xfe869fc5, Offset: 0x470
// Size: 0x1dd
function gunner_think(var_72ffe0f4) {
    if (!isdefined(var_72ffe0f4)) {
        var_72ffe0f4 = 0;
    }
    self.m_vehicle endon(#"death");
    self.m_vehicle turret::set_burst_parameters(1, 2, 0.25, 0.75, 0);
    while (true) {
        var_dfb53de7 = self.m_vehicle vehicle::function_ad4ec07a("driver");
        if (isdefined(var_dfb53de7)) {
            self.m_vehicle turret::enable(0, 1);
            self.m_vehicle flag::set("gunner_position_occupied");
            var_dfb53de7 waittill(#"death");
            level notify(self.m_vehicle.targetname + "_gunner_death");
        }
        self.m_vehicle turret::disable(0);
        self.m_vehicle flag::clear("gunner_position_occupied");
        if (var_72ffe0f4) {
            wait randomfloatrange(4, 5);
            var_753bd441 = function_ceda4e5b();
            if (isalive(var_753bd441)) {
                var_753bd441 thread vehicle::get_in(self.m_vehicle, "driver", 0);
                var_753bd441 util::waittill_any("death", "in_vehicle");
            }
            continue;
        }
        break;
    }
}

// Namespace namespace_ce2d510
// Params 0, eflags: 0x0
// Checksum 0xa204b6de, Offset: 0x658
// Size: 0x42
function function_13eceb32() {
    var_dfb53de7 = self.m_vehicle vehicle::function_ad4ec07a("driver");
    if (isdefined(var_dfb53de7)) {
        var_dfb53de7 delete();
    }
}

// Namespace namespace_ce2d510
// Params 0, eflags: 0x0
// Checksum 0x95caecb0, Offset: 0x6a8
// Size: 0x2a
function vehicle_death() {
    self.m_vehicle waittill(#"death");
    function_13eceb32();
    self.m_vehicle = undefined;
}

// Namespace namespace_ce2d510
// Params 0, eflags: 0x0
// Checksum 0x673c657f, Offset: 0x6e0
// Size: 0x117
function function_ceda4e5b() {
    a_enemies = getaiteamarray("axis");
    a_valid = [];
    foreach (e_enemy in a_enemies) {
        if (isalive(e_enemy)) {
            if (e_enemy istouching(self.var_ee76385b)) {
                if (!isdefined(a_valid)) {
                    a_valid = [];
                } else if (!isarray(a_valid)) {
                    a_valid = array(a_valid);
                }
                a_valid[a_valid.size] = e_enemy;
            }
        }
    }
    var_dfb53de7 = arraysort(a_valid, self.m_vehicle.origin, 1, a_valid.size)[0];
    return var_dfb53de7;
}

// Namespace namespace_ce2d510
// Params 0, eflags: 0x0
// Checksum 0xf4c37130, Offset: 0x800
// Size: 0x9
function get_vehicle() {
    return self.m_vehicle;
}

