#using scripts/codescripts/struct;
#using scripts/cp/cybercom/_cybercom_util;
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

#namespace tiger_tank;

// Namespace tiger_tank
// Method(s) 0 Total 0
class class_57d92933 {

}

// Namespace tiger_tank
// Params 0, eflags: 0x2
// Checksum 0x33d1e3af, Offset: 0x560
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("tiger_tank", &__init__, undefined, undefined);
}

// Namespace tiger_tank
// Params 0, eflags: 0x0
// Checksum 0x853daf10, Offset: 0x598
// Size: 0x6a
function __init__() {
    level._effect["fx_exp_quadtank_death_03"] = "explosions/fx_exp_quadtank_death_03";
    clientfield::register("vehicle", "tiger_tank_retreat_fx", 1, 1, "int");
    clientfield::register("vehicle", "tiger_tank_disable_sfx", 1, 1, "int");
}

#namespace namespace_2e121905;

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0x60c02475, Offset: 0x610
// Size: 0x142
function __constructor() {
    self.var_a3ea1738 = "none";
    self.var_cad6330b = "";
    self.var_a89a845e = 0;
    self.var_ae796281 = 0;
    self.var_c99bf370 = 0;
    self.var_b78b4a49 = -1;
    self.var_88164886 = undefined;
    self.var_bdfe6578 = 0;
    function_a1b34855("attack", "attack_moving", 100, &function_cf0ca3a4, &function_864de95);
    function_a1b34855("retreat", "retreat", 100, &function_101b3238, &always_true);
    function_a1b34855("idle", "idle", 100, &function_797da861, &always_true);
    self flag::init("firing");
    self flag::init("moving");
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x760
// Size: 0x2
function __destructor() {
    
}

// Namespace namespace_2e121905
// Params 2, eflags: 0x0
// Checksum 0x6ed6f03b, Offset: 0x770
// Size: 0x72
function function_147315f(vehicle, var_e45a16d2) {
    if (isdefined(var_e45a16d2)) {
        var_f73d6972 = getent(var_e45a16d2, "targetname");
        var_dfb53de7 = spawner::simple_spawn_single(var_f73d6972);
        function_3a062392(var_dfb53de7);
    }
    function_347dd051(vehicle);
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0xf715a5ed, Offset: 0x7f0
// Size: 0x23
function function_f7f47181() {
    if (self.var_ae796281 < 2) {
        self.var_c99bf370 = 1;
        self notify(#"state_changed");
    }
}

// Namespace namespace_2e121905
// Params 1, eflags: 0x0
// Checksum 0xccd6da7f, Offset: 0x820
// Size: 0x32
function function_d4274a7(n_state) {
    if (isdefined(self.m_vehicle)) {
        self.m_vehicle clientfield::set("tiger_tank_disable_sfx", n_state);
    }
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0x605ac155, Offset: 0x860
// Size: 0x6a
function function_ce839946() {
    self endon(#"stop_think");
    if (!self.var_bdfe6578) {
        if (isdefined(self.m_vehicle)) {
            self thread function_b5349d82();
            wait 0.1;
            self thread function_4ac084e9();
            wait 3;
            self thread fire_turret();
            self thread function_3092a01d();
        }
    }
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0x5609360, Offset: 0x8d8
// Size: 0x13
function stop_think() {
    self notify(#"stop_think");
    self notify(#"state_changed");
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0x41f57497, Offset: 0x8f8
// Size: 0x2a
function function_13eceb32() {
    if (isdefined(self.var_b9d89d33)) {
        self.var_b9d89d33 delete();
        self.var_b9d89d33 = undefined;
    }
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0x54209ae5, Offset: 0x930
// Size: 0x62
function delete_ai() {
    stop_think();
    if (isdefined(self.m_vehicle)) {
        self.m_vehicle delete();
        self.m_vehicle = undefined;
    }
    if (isdefined(self.var_b9d89d33)) {
        self.var_b9d89d33 delete();
        self.var_b9d89d33 = undefined;
    }
}

// Namespace namespace_2e121905
// Params 1, eflags: 0x0
// Checksum 0xf6f3f240, Offset: 0x9a0
// Size: 0x1ba
function function_347dd051(vehicle) {
    self.m_vehicle = vehicle;
    self.m_vehicle.health = self.m_vehicle.healthdefault;
    self.m_vehicle setneargoalnotifydist(120);
    self.m_vehicle cybercom::function_59965309("cybercom_immolation");
    target_set(self.m_vehicle, (0, 0, 60));
    self.m_vehicle turret::set_burst_parameters(0.75, 1.5, 0.25, 0.75, 1);
    self.m_vehicle function_2ea2374c(1, 0);
    self.m_vehicle function_af655b16();
    if (issentient(self.m_vehicle)) {
        self thread vehicle_death();
    }
    if (isdefined(self.var_b9d89d33)) {
        function_dc12d289();
    }
    self thread damage_watcher();
    self thread function_4ea63f4f();
    self.var_4c5ecca3 = getent("street_lookat", "targetname");
    self.m_vehicle setlookatent(self.var_4c5ecca3);
}

// Namespace namespace_2e121905
// Params 1, eflags: 0x0
// Checksum 0x75ac209f, Offset: 0xb68
// Size: 0x12
function function_3a062392(var_dfb53de7) {
    self.var_b9d89d33 = var_dfb53de7;
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0xf6eae2a, Offset: 0xb88
// Size: 0x42
function function_dc12d289() {
    if (isdefined(self.var_b9d89d33)) {
        self.var_b9d89d33 thread vehicle::get_in(self.m_vehicle, "gunner1", 1);
        self thread function_490ccf02();
    }
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0x7fc6ddad, Offset: 0xbd8
// Size: 0x13d
function fire_turret() {
    self endon(#"death");
    self endon(#"stop_think");
    self.m_vehicle endon(#"death");
    while (true) {
        if (isdefined(self.var_88164886)) {
            var_31362a8b = (0, 0, 53);
            v_target_origin = self.var_88164886.origin + var_31362a8b;
            self.var_b86c3bf6 = distance(self.m_vehicle.origin, self.var_88164886.origin);
            self.m_vehicle util::waittill_any_timeout(2, "turret_on_target");
            if (can_hit_target(v_target_origin) && self.var_b86c3bf6 > 620) {
                self.m_vehicle fireweapon(0, self.var_88164886, var_31362a8b);
            } else {
                self.m_vehicle clearturrettarget();
            }
        } else {
            self.m_vehicle clearturrettarget();
        }
        wait randomfloatrange(4, 8);
    }
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0xadf17ab8, Offset: 0xd20
// Size: 0xc9
function function_3092a01d() {
    self endon(#"death");
    self endon(#"stop_think");
    self.m_vehicle endon(#"death");
    while (true) {
        if (isdefined(self.var_88164886)) {
            if (isdefined(self.var_b9d89d33) && isalive(self.var_b9d89d33)) {
                self.m_vehicle thread turret::shoot_at_target(function_8360af05(), -1, (0, 0, 0), 1, 0);
            }
            wait randomfloatrange(2, 3);
            self.m_vehicle turret::disable(1);
            wait randomfloatrange(4, 6);
            continue;
        }
        wait 0.1;
    }
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0x566af5d8, Offset: 0xdf8
// Size: 0xad
function function_b5349d82() {
    self endon(#"death");
    self endon(#"stop_think");
    self.m_vehicle endon(#"death");
    while (true) {
        self.var_88164886 = function_70b03789();
        if (isdefined(self.var_88164886)) {
            self.m_vehicle settargetentity(self.var_88164886);
        } else {
            self.m_vehicle clearturrettarget();
            self.m_vehicle cleartargetentity();
        }
        wait randomfloatrange(4, 5);
    }
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0x22201ba5, Offset: 0xeb0
// Size: 0xed
function function_4ac084e9() {
    self endon(#"death");
    self endon(#"stop_think");
    self.m_vehicle endon(#"death");
    while (true) {
        var_b1e10140 = function_1de87b78();
        if (var_b1e10140) {
            var_d868c8e5 = function_1138db74();
            if (var_d868c8e5) {
                str_type = "retreat";
            } else if (self.var_c99bf370) {
                self.var_c99bf370 = 0;
                str_type = "retreat";
            } else {
                str_type = "attack";
            }
        } else {
            str_type = "idle";
        }
        var_164d95b8 = function_82ff0374(str_type);
        update_state(str_type, var_164d95b8);
        wait 0.1;
    }
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0xa23d27aa, Offset: 0xfa8
// Size: 0x6f
function damage_watcher() {
    self endon(#"death");
    self endon(#"stop_think");
    self.m_vehicle endon(#"death");
    while (true) {
        self.m_vehicle waittill(#"damage");
        self.var_b47d057e = gettime();
        if (function_1138db74()) {
            debug_print("cTigerTank: damage interrupt!");
            self notify(#"hash_360844d8");
        }
    }
}

// Namespace namespace_2e121905
// Params 2, eflags: 0x0
// Checksum 0x6f5ad422, Offset: 0x1020
// Size: 0x98
function update_state(str_type, var_164d95b8) {
    self endon(#"hash_360844d8");
    if (self.var_a3ea1738 != var_164d95b8) {
        self notify(#"state_changed");
        assert(isdefined(self.var_40c162df[str_type][var_164d95b8]), "<dev string:x28>" + str_type + "<dev string:x45>" + var_164d95b8 + "<dev string:x54>");
        self.var_cad6330b = self.var_a3ea1738;
        self.var_a3ea1738 = var_164d95b8;
    }
    [[ self.var_40c162df[str_type][var_164d95b8].var_ba703cb1 ]]();
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0x6074e42f, Offset: 0x10c0
// Size: 0x69
function function_797da861() {
    self endon(#"state_changed");
    debug_print("cTigerTank: idle");
    self.m_vehicle turret::disable(0);
    function_4568faa9();
    while (!function_1de87b78()) {
        wait 0.5;
    }
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0xf43709ca, Offset: 0x1138
// Size: 0x4
function function_864de95() {
    return true;
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0xa8e087f2, Offset: 0x1148
// Size: 0x1d6
function function_cf0ca3a4() {
    self endon(#"state_changed");
    debug_print("cTigerTank: attack moving");
    if (isdefined(self.var_88164886)) {
        v_to_target = vectornormalize(self.var_88164886.origin - self.m_vehicle.origin) * 900;
        s_goal = function_cb234295(self.m_vehicle.origin + v_to_target);
        if (isdefined(s_goal)) {
            var_4b59adf6 = distance(self.m_vehicle.origin, s_goal.origin);
            v_dir = anglestoforward(s_goal.angles) * -56;
            self.var_4c5ecca3.origin = s_goal.origin + v_dir;
            function_f3e33440(s_goal.origin, 1, 1);
        }
        var_79d88e26 = randomfloatrange(2.5, 3);
        wait var_79d88e26;
        var_bf67bca7 = function_c9318f4b();
        var_4b59adf6 = distance(self.m_vehicle.origin, var_bf67bca7.origin);
        function_f3e33440(var_bf67bca7.origin, 1, 1);
        var_79d88e26 = randomfloatrange(3.5, 4);
        wait var_79d88e26;
        return;
    }
    wait 3;
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0x3869f689, Offset: 0x1328
// Size: 0x122
function function_101b3238() {
    self endon(#"state_changed");
    debug_print("cTigerTank: retreat");
    self.var_b78b4a49 = -1;
    var_9de10fe3 = function_ffde4e7f();
    if (isdefined(var_9de10fe3)) {
        debug_print("cTigerTank: retreating!");
        function_d677fbba(var_9de10fe3.origin, "RETREAT", (0, 0, 1), -56);
        self.m_vehicle clientfield::set("tiger_tank_retreat_fx", 1);
        self.var_d7b7066f = gettime();
        function_f3e33440(var_9de10fe3.origin, 1, 0, 0);
        function_bfc2da97();
        self function_4a890e39();
        self.m_vehicle clientfield::set("tiger_tank_retreat_fx", 0);
        return;
    }
    debug_print("cTigerTank: retreat failed!");
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0xc006c8e1, Offset: 0x1458
// Size: 0x36
function function_1de87b78() {
    a_targets = self.m_vehicle turret::function_5798a268(0);
    var_b1e10140 = a_targets.size > 0;
    return var_b1e10140;
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0x980e9c29, Offset: 0x1498
// Size: 0xed
function function_70b03789() {
    a_targets = self.m_vehicle turret::function_5798a268(0);
    e_closest = undefined;
    if (a_targets.size > 0) {
        var_a529ba4d = arraysort(a_targets, self.m_vehicle.origin, 1);
        foreach (e_target in var_a529ba4d) {
            if (distance2d(e_target.origin, self.m_vehicle.origin) > self.m_vehicle.radius) {
                e_closest = e_target;
            }
        }
    }
    return e_closest;
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0x7cdd6e0c, Offset: 0x1590
// Size: 0x26
function get_targets() {
    a_targets = self.m_vehicle turret::function_5798a268(0);
    return a_targets;
}

// Namespace namespace_2e121905
// Params 1, eflags: 0x0
// Checksum 0xb3d23ba3, Offset: 0x15c0
// Size: 0x9e
function function_82ff0374(str_type) {
    assert(isdefined(self.var_40c162df[str_type]), "<dev string:x64>" + str_type + "<dev string:xa6>");
    var_eaf4e195 = function_e429cfd8(str_type);
    if (var_eaf4e195.size > 1 && isinarray(var_eaf4e195, self.var_a3ea1738)) {
        arrayremovevalue(var_eaf4e195, self.var_a3ea1738, 0);
    }
    var_1e336267 = function_25fc80d0(str_type, var_eaf4e195);
    return var_1e336267;
}

// Namespace namespace_2e121905
// Params 1, eflags: 0x0
// Checksum 0xe45057f, Offset: 0x1668
// Size: 0xdc
function function_e429cfd8(str_type) {
    var_a7133b4a = getarraykeys(self.var_40c162df[str_type]);
    var_eaf4e195 = [];
    for (i = 0; i < var_a7133b4a.size; i++) {
        if ([[ self.var_40c162df[str_type][var_a7133b4a[i]].func_validate ]]()) {
            if (!isdefined(var_eaf4e195)) {
                var_eaf4e195 = [];
            } else if (!isarray(var_eaf4e195)) {
                var_eaf4e195 = array(var_eaf4e195);
            }
            var_eaf4e195[var_eaf4e195.size] = var_a7133b4a[i];
        }
    }
    assert(var_eaf4e195.size, "<dev string:xa9>" + str_type + "<dev string:xa6>");
    return var_eaf4e195;
}

// Namespace namespace_2e121905
// Params 2, eflags: 0x0
// Checksum 0xe4bb193b, Offset: 0x1750
// Size: 0xf4
function function_25fc80d0(str_type, var_a7133b4a) {
    var_1177aea3 = 0;
    for (i = 0; i < var_a7133b4a.size; i++) {
        var_1177aea3 += self.var_40c162df[str_type][var_a7133b4a[i]].n_chance;
        self.var_40c162df[str_type][var_a7133b4a[i]].var_e60fa78d = var_1177aea3;
    }
    n_roll = randomintrange(0, var_1177aea3);
    for (j = 0; j < var_a7133b4a.size; j++) {
        if (n_roll < self.var_40c162df[str_type][var_a7133b4a[j]].var_e60fa78d) {
            var_1e336267 = var_a7133b4a[j];
            break;
        }
    }
    assert(isdefined(var_1e336267), "<dev string:xf4>");
    return var_1e336267;
}

// Namespace namespace_2e121905
// Params 5, eflags: 0x0
// Checksum 0xf065ea90, Offset: 0x1850
// Size: 0x18e
function function_a1b34855(str_type, str_state, n_chance, var_ba703cb1, func_validate) {
    assert(isdefined(str_type), "<dev string:x135>");
    assert(isdefined(str_state), "<dev string:x16c>");
    assert(isdefined(n_chance), "<dev string:x1a4>");
    assert(isdefined(var_ba703cb1), "<dev string:x1db>");
    assert(isdefined(func_validate), "<dev string:x214>");
    if (!isdefined(self.var_40c162df)) {
        self.var_40c162df = [];
    }
    if (!isdefined(self.var_40c162df[str_type])) {
        self.var_40c162df[str_type] = [];
    }
    assert(!isdefined(self.var_40c162df[str_type][str_state]), "<dev string:x250>" + str_type + "<dev string:x2a4>" + str_state + "<dev string:xa6>");
    self.var_40c162df[str_type][str_state] = spawnstruct();
    self.var_40c162df[str_type][str_state].n_chance = n_chance;
    self.var_40c162df[str_type][str_state].var_ba703cb1 = var_ba703cb1;
    self.var_40c162df[str_type][str_state].func_validate = func_validate;
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0x81c54bfd, Offset: 0x19e8
// Size: 0x32
function function_4a890e39() {
    self endon(#"death");
    self.m_vehicle endon(#"death");
    self flag::wait_till_clear("moving");
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0x77f4b645, Offset: 0x1a28
// Size: 0x5a
function function_bfc2da97() {
    self.m_vehicle setvehgoalpos(self.m_vehicle.origin, 1, 0);
    self.m_vehicle cancelaimove();
    self flag::clear("moving");
}

// Namespace namespace_2e121905
// Params 5, eflags: 0x0
// Checksum 0xffda67c7, Offset: 0x1a90
// Size: 0x1ca
function function_f3e33440(v_target, var_188645ca, var_bc1310a, var_96d0393f, n_timeout) {
    if (!isdefined(var_bc1310a)) {
        var_bc1310a = 0;
    }
    if (!isdefined(var_96d0393f)) {
        var_96d0393f = 0;
    }
    if (!isdefined(n_timeout)) {
        n_timeout = 20;
    }
    self flag::set("moving");
    var_e87aa1d8 = self.m_vehicle setvehgoalpos(v_target, var_188645ca, 1);
    if (var_e87aa1d8) {
        if (var_bc1310a) {
            self.m_vehicle setspeed(10);
        }
        if (var_96d0393f) {
            self thread function_b86522b7();
        }
        self thread function_838f37e(v_target);
        str_result = self.m_vehicle util::waittill_any_timeout(n_timeout, "near_goal", "goal", "within_engagement_distance");
        self.m_vehicle clearvehgoalpos();
        self.m_vehicle cancelaimove();
        function_46f90745();
        if (str_result === "timeout") {
            debug_print("cTigerTank: send_vehicle_to_position timed out");
        }
        if (var_bc1310a) {
            var_b015145a = self.m_vehicle getmaxspeed() / 17.6;
            self.m_vehicle setspeed(var_b015145a);
        }
        self flag::clear("moving");
    }
}

// Namespace namespace_2e121905
// Params 3, eflags: 0x0
// Checksum 0x855a38a5, Offset: 0x1c68
// Size: 0xc6
function function_cb234295(v_target, var_c1061a76, var_a610eec8) {
    var_b85e0186 = array("street", "street_0", "street_1", "street_2");
    var_62533f1c = var_b85e0186[self.var_ae796281];
    self.var_889ff800 = getvehiclenodearray(var_62533f1c, "script_noteworthy");
    assert(self.var_889ff800.size, "<dev string:x2af>");
    var_bd615cc9 = arraygetclosest(v_target, self.var_889ff800);
    return var_bd615cc9;
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0x74c107b0, Offset: 0x1d38
// Size: 0x182
function vehicle_death() {
    var_4059c9b4 = self.m_vehicle.deathmodel;
    self.m_vehicle waittill(#"death");
    self.var_bdfe6578 = 1;
    stop_think();
    if (isdefined(self.m_vehicle)) {
        self.m_vehicle playsound("exp_tiger_death");
        var_42af8d5d = util::spawn_model(var_4059c9b4, self.m_vehicle.origin, self.m_vehicle.angles);
        badplace_box("", 0, self.m_vehicle.origin, self.m_vehicle.radius, "neutral");
        playfxontag(level._effect["fx_exp_quadtank_death_03"], var_42af8d5d, "tag_origin");
        self.m_vehicle ai::set_ignoreme(1);
        self.m_vehicle ai::set_ignoreall(1);
        self.m_vehicle hide();
        function_13eceb32();
        wait 2;
        self.m_vehicle delete();
        self.m_vehicle = undefined;
    }
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0xf2f08427, Offset: 0x1ec8
// Size: 0x3a
function function_490ccf02() {
    self endon(#"death");
    self.m_vehicle endon(#"death");
    self.var_b9d89d33 waittill(#"death");
    function_4568faa9();
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0xb54f9a92, Offset: 0x1f10
// Size: 0xaa
function function_b86522b7() {
    self endon(#"death");
    self endon(#"state_changed");
    self.m_vehicle endon(#"death");
    self.m_vehicle endon(#"goal");
    self.m_vehicle endon(#"near_goal");
    while (distance(self.m_vehicle.origin, self.var_88164886.origin) > 900) {
        wait 0.25;
    }
    debug_print("cTigerTank: notify - within_engagement_distance");
    self.m_vehicle notify(#"within_engagement_distance");
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0xf43709ca, Offset: 0x1fc8
// Size: 0x4
function always_true() {
    return true;
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0x1a98afb5, Offset: 0x1fd8
// Size: 0x3
function always_false() {
    return false;
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0xcbb8535, Offset: 0x1fe8
// Size: 0xb1
function function_ffde4e7f() {
    a_locations = array("street_0_retreat", "street_1_retreat", "street_2_retreat");
    var_62533f1c = a_locations[self.var_ae796281];
    self.var_889ff800 = getvehiclenodearray(var_62533f1c, "script_noteworthy");
    var_9de10fe3 = arraygetfarthest(self.m_vehicle.origin, self.var_889ff800);
    self.var_ae796281++;
    if (self.var_ae796281 == 1) {
        level notify(#"hash_6ee94cb6");
    }
    return var_9de10fe3;
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0xd44bb4cf, Offset: 0x20a8
// Size: 0xd7
function function_c9318f4b() {
    a_locations = array("street", "street_0", "street_1", "street_2");
    var_62533f1c = a_locations[self.var_ae796281];
    self.var_889ff800 = getvehiclenodearray(var_62533f1c, "script_noteworthy");
    for (var_e7bee84c = randomint(self.var_889ff800.size); var_e7bee84c == self.var_b78b4a49; var_e7bee84c = randomint(self.var_889ff800.size)) {
    }
    self.var_b78b4a49 = var_e7bee84c;
    var_9de10fe3 = self.var_889ff800[var_e7bee84c];
    return var_9de10fe3;
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0x8b5e7f0d, Offset: 0x2188
// Size: 0xd9
function function_1138db74() {
    if (self.var_ae796281 < 2) {
        n_current_time = gettime();
        if (isdefined(self.var_b47d057e)) {
            n_time_since_last_damage = (n_current_time - self.var_b47d057e) * 0.001;
            if (n_time_since_last_damage < 5) {
                var_f5742a3c = 1;
            } else {
                var_f5742a3c = 0;
            }
        } else {
            var_f5742a3c = 0;
        }
        var_46b3a714 = function_67d093da() < 0.7;
        var_59e2529 = isdefined(self.var_d7b7066f) && (n_current_time - self.var_d7b7066f) * 0.001 < 5;
        var_d868c8e5 = var_f5742a3c && var_46b3a714 && !var_59e2529;
        return var_d868c8e5;
    }
    return 0;
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0xc62d3ad1, Offset: 0x2270
// Size: 0x22
function function_67d093da() {
    return self.m_vehicle.health / self.m_vehicle.healthdefault;
}

// Namespace namespace_2e121905
// Params 1, eflags: 0x0
// Checksum 0x35c6faf6, Offset: 0x22a0
// Size: 0x3a
function debug_print(str_text) {
    /#
        if (getdvarint("<dev string:x2fb>", 0)) {
            iprintlnbold(str_text);
        }
    #/
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0x981a8a82, Offset: 0x22e8
// Size: 0xd5
function function_4ea63f4f() {
    self endon(#"death");
    self.m_vehicle endon(#"death");
    while (true) {
        if (getdvarint("debug_tiger_tank", 0)) {
            function_8ad17378("STATE: " + self.var_a3ea1738, 0, 2);
            function_8ad17378("FIRING: " + self flag::get("firing"), 1, 2);
            function_8ad17378("MOVING: " + self flag::get("moving"), 2, 2);
        }
        wait 0.1;
    }
}

// Namespace namespace_2e121905
// Params 1, eflags: 0x0
// Checksum 0x9849e643, Offset: 0x23c8
// Size: 0x5e
function can_hit_target(v_target) {
    v_start = self.m_vehicle gettagorigin("tag_barrel");
    b_trace_passed = bullettracepassed(v_start, v_target, 0, self.m_vehicle);
    return b_trace_passed;
}

// Namespace namespace_2e121905
// Params 3, eflags: 0x0
// Checksum 0xd1bd2361, Offset: 0x2430
// Size: 0x7a
function function_8ad17378(str_text, var_8dc519f1, n_duration) {
    v_offset = (0, 0, 120) + (0, 0, var_8dc519f1 * 25);
    /#
        print3d(self.m_vehicle.origin + v_offset, str_text, (1, 1, 1), 1, 1.5, n_duration);
    #/
}

/#

    // Namespace namespace_2e121905
    // Params 0, eflags: 0x0
    // Checksum 0xdf0bbaf1, Offset: 0x24b8
    // Size: 0x32
    function function_302aef1c() {
        if (getdvarint("<dev string:x2fb>", 0) > 1) {
            debugbreak();
        }
    }

#/

// Namespace namespace_2e121905
// Params 1, eflags: 0x0
// Checksum 0x7b60916f, Offset: 0x24f8
// Size: 0x55
function function_838f37e(v_goal) {
    self endon(#"death");
    self endon(#"hash_46f90745");
    /#
        while (true) {
            function_d677fbba(v_goal, "<dev string:x30c>", (1, 1, 1), 1);
            wait 0.05;
        }
    #/
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0xb61868d2, Offset: 0x2558
// Size: 0xf
function function_46f90745() {
    /#
        self notify(#"hash_46f90745");
    #/
}

// Namespace namespace_2e121905
// Params 4, eflags: 0x0
// Checksum 0xdc9be099, Offset: 0x2570
// Size: 0x92
function function_d677fbba(v_goal, str_text, v_color, n_duration) {
    /#
        if (getdvarint("<dev string:x2fb>", 0)) {
            debugstar(v_goal, n_duration, v_color);
            print3d(v_goal + (0, 0, 40), str_text, v_color, 1, 1.5, n_duration);
        }
    #/
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0xe40f4d21, Offset: 0x2610
// Size: 0xa
function function_af655b16() {
    self.fovcosine = 0;
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0x99146927, Offset: 0x2628
// Size: 0x2a
function function_4568faa9() {
    self.m_vehicle turret::disable(1);
    self.m_vehicle notify("turret_disabled" + 1);
}

// Namespace namespace_2e121905
// Params 0, eflags: 0x0
// Checksum 0xddfba641, Offset: 0x2660
// Size: 0x7e
function function_8360af05() {
    a_potential_targets = get_targets();
    if (isdefined(self.var_88164886)) {
        arrayremovevalue(a_potential_targets, self.var_88164886);
    }
    if (a_potential_targets.size > 0) {
        var_221cf570 = arraysort(a_potential_targets, self.m_vehicle.origin, 1)[0];
    } else {
        var_221cf570 = self.var_88164886;
    }
    return var_221cf570;
}

