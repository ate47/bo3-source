#using scripts/cp/_spawn_manager_debug;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/name_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace spawn_manager;

// Namespace spawn_manager
// Params 0, eflags: 0x2
// Checksum 0x27fc78a0, Offset: 0x298
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("spawn_manager", &__init__, undefined, undefined);
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0xa1862027, Offset: 0x2d8
// Size: 0xe4
function __init__() {
    level.var_9eb6e779 = 0;
    level.var_b5b6bce6 = 50;
    level.var_ad131964 = 0;
    level.var_44883b1c = 0;
    level.spawn_managers = [];
    level.spawn_managers = getentarray("spawn_manager", "classname");
    array::thread_all(level.spawn_managers, &function_4f3c7857);
    function_a307afed();
    /#
        callback::on_connect(&on_player_connect);
        level thread function_573de556();
    #/
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0x5b25470f, Offset: 0x3c8
// Size: 0x1c4
function function_8180b524() {
    assert(isdefined(self));
    assert(isdefined(self.target));
    assert(self.var_20149b34 >= self.var_4d210f7a, "<dev string:x28>" + self.sm_id);
    if (!isdefined(self.var_8f471bf9) || self.var_8f471bf9 > self.var_d8202611.size) {
        self.var_8f471bf9 = self.var_d8202611.size;
    }
    if (!isdefined(self.var_ec676387) || self.var_ec676387 > self.var_d8202611.size) {
        self.var_ec676387 = self.var_d8202611.size;
    }
    assert(self.var_ec676387 >= self.var_8f471bf9, "<dev string:x28>" + self.sm_id);
    self.var_bc2f37e4 = randomintrange(self.var_8f471bf9, self.var_ec676387 + 1);
    self.spawners = self function_826b96e5();
    function_b72dc5ae();
    assert(self.var_4d210f7a <= self.var_e290d32d, "<dev string:x7d>");
    if (!isdefined(self.script_forcespawn)) {
        self.script_forcespawn = 0;
    }
}

// Namespace spawn_manager
// Params 1, eflags: 0x0
// Checksum 0xbeaf2174, Offset: 0x598
// Size: 0x164
function function_2ce178dd(var_43f783bc) {
    totalfree = self.count >= 0 ? self.count : level.var_b5b6bce6;
    var_3b349fcd = self.var_e290d32d - self.var_e5c2eec1.size;
    var_7f9a0c9b = var_3b349fcd >= var_43f783bc && totalfree >= var_43f783bc && var_43f783bc > 0;
    var_e636b61e = level.var_b5b6bce6 - level.var_ad131964;
    assert(self.enable == level flag::get("<dev string:xad>" + self.sm_id + "<dev string:xb1>"), "<dev string:xba>");
    if (self.script_forcespawn == 0) {
        return (totalfree > 0 && var_3b349fcd > 0 && var_e636b61e > 0 && var_7f9a0c9b && self.enable);
    }
    return totalfree > 0 && var_3b349fcd > 0 && self.enable;
}

// Namespace spawn_manager
// Params 1, eflags: 0x0
// Checksum 0xbb9533ca, Offset: 0x708
// Size: 0x84
function spawn_manager_spawn(maxdelay) {
    self endon(#"death");
    start = gettime();
    while (true) {
        ai = self spawner::spawn();
        if (isdefined(ai) || gettime() - start > 1000 * maxdelay) {
            return ai;
        }
        wait 0.5;
    }
}

// Namespace spawn_manager
// Params 2, eflags: 0x0
// Checksum 0x618cc10, Offset: 0x798
// Size: 0x136
function function_668c4ede(spawner, var_43f783bc) {
    for (i = 0; i < var_43f783bc; i++) {
        ai = undefined;
        if (isdefined(spawner) && isdefined(spawner.targetname)) {
            ai = spawner spawn_manager_spawn(2);
            if (isdefined(ai)) {
                ai.sm_id = self.sm_id;
            }
        } else {
            continue;
        }
        if (!spawner::spawn_failed(ai)) {
            if (isdefined(self.script_radius)) {
                ai.script_radius = self.script_radius;
            }
            if (isdefined(spawner.script_radius)) {
                ai.script_radius = spawner.script_radius;
            }
            ai thread function_efd8772(spawner, self);
        }
    }
}

// Namespace spawn_manager
// Params 2, eflags: 0x0
// Checksum 0xf4aab3fb, Offset: 0x8d8
// Size: 0x15c
function function_efd8772(spawner, manager) {
    targetname = manager.targetname;
    classname = spawner.classname;
    level.var_9eb6e779++;
    manager.spawncount++;
    if (manager.count > 0) {
        manager.count--;
    }
    level.var_ad131964++;
    origin = spawner.origin;
    manager.var_e5c2eec1[manager.var_e5c2eec1.size] = self;
    spawner.var_e5c2eec1[spawner.var_e5c2eec1.size] = self;
    self waittill(#"death");
    if (isdefined(spawner)) {
        arrayremovevalue(spawner.var_e5c2eec1, self);
    }
    if (isdefined(manager)) {
        arrayremovevalue(manager.var_e5c2eec1, self);
    }
    level.var_ad131964--;
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0xb2e51fdd, Offset: 0xa40
// Size: 0x198
function function_b088c390() {
    if (isdefined(self.name)) {
        /#
            function_a89a3a33(self.name);
        #/
        self.sm_id = self.name;
    } else if (isdefined(self.targetname) && !strstartswith(self.targetname, "pf")) {
        /#
            function_a89a3a33(self.targetname);
        #/
        self.sm_id = self.targetname;
    } else {
        function_24cc6574();
    }
    if (!isdefined(self.var_bd948b2a)) {
        self.var_bd948b2a = self.count;
    }
    if (!isdefined(self.var_4cb76884)) {
        self.var_4cb76884 = isdefined(self.var_5fa59123) ? self.var_5fa59123 : level.var_b5b6bce6;
    }
    if (!isdefined(self.var_6f1e6d96)) {
        self.var_6f1e6d96 = isdefined(self.var_e290d32d) ? self.var_e290d32d : level.var_b5b6bce6;
    }
    if (!isdefined(self.var_5e6995dd)) {
        self.var_5e6995dd = isdefined(self.var_4d210f7a) ? self.var_4d210f7a : 1;
    }
    if (!isdefined(self.var_5b01a5b7)) {
        self.var_5b01a5b7 = isdefined(self.var_20149b34) ? self.var_20149b34 : 1;
    }
}

/#

    // Namespace spawn_manager
    // Params 1, eflags: 0x0
    // Checksum 0x617d5545, Offset: 0xbe0
    // Size: 0x13a
    function function_a89a3a33(str_name) {
        var_2b309d3d = getentarray("<dev string:xf5>", "<dev string:x103>");
        foreach (sm in var_2b309d3d) {
            if (sm != self) {
                if (sm.targetname === str_name || sm.name === str_name) {
                    assertmsg("<dev string:x10d>" + str_name + "<dev string:x13a>" + self.origin + "<dev string:x150>" + sm.origin);
                }
            }
        }
    }

#/

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0x36173650, Offset: 0xd28
// Size: 0x3c
function function_24cc6574() {
    if (!isdefined(level.var_6ff5e673)) {
        level.var_6ff5e673 = 0;
    }
    self.sm_id = "sm_auto" + level.var_6ff5e673;
    level.var_6ff5e673++;
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0x4f2b672, Offset: 0xd70
// Size: 0xd0
function function_c791ea22() {
    if (level.players.size >= 4 && isdefined(self.var_afecb75f)) {
        n_count = self.var_afecb75f;
    } else if (level.players.size >= 3 && isdefined(self.var_99d7d770)) {
        n_count = self.var_99d7d770;
    } else if (level.players.size >= 2 && isdefined(self.var_722be5e1)) {
        n_count = self.var_722be5e1;
    } else {
        n_count = self.var_bd948b2a;
    }
    if (n_count > 0) {
        self.count = n_count;
        return;
    }
    self.count = -1;
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0x91f6d51c, Offset: 0xe48
// Size: 0xb0
function function_f6bee20a() {
    if (level.players.size >= 4 && isdefined(self.var_7806fba9)) {
        self.var_5fa59123 = self.var_7806fba9;
        return;
    }
    if (level.players.size >= 3 && isdefined(self.var_c856abde)) {
        self.var_5fa59123 = self.var_c856abde;
        return;
    }
    if (level.players.size >= 2 && isdefined(self.var_7356d647)) {
        self.var_5fa59123 = self.var_7356d647;
        return;
    }
    self.var_5fa59123 = self.var_4cb76884;
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0x6462833a, Offset: 0xf00
// Size: 0xb0
function function_497c788() {
    if (level.players.size >= 4 && isdefined(self.var_5132a283)) {
        self.var_e290d32d = self.var_5132a283;
        return;
    }
    if (level.players.size >= 3 && isdefined(self.var_1ca2b3fc)) {
        self.var_e290d32d = self.var_1ca2b3fc;
        return;
    }
    if (level.players.size >= 2 && isdefined(self.var_5d148eed)) {
        self.var_e290d32d = self.var_5d148eed;
        return;
    }
    self.var_e290d32d = self.var_6f1e6d96;
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0x945f929c, Offset: 0xfb8
// Size: 0xb0
function function_12d13f75() {
    if (level.players.size >= 4 && isdefined(self.var_ae6f65e0)) {
        self.var_4d210f7a = self.var_ae6f65e0;
        return;
    }
    if (level.players.size >= 3 && isdefined(self.var_a56a2c0f)) {
        self.var_4d210f7a = self.var_a56a2c0f;
        return;
    }
    if (level.players.size >= 2 && isdefined(self.var_5404b486)) {
        self.var_4d210f7a = self.var_5404b486;
        return;
    }
    self.var_4d210f7a = self.var_5e6995dd;
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0x91b5f4fa, Offset: 0x1070
// Size: 0xb0
function function_b4162883() {
    if (level.players.size >= 4 && isdefined(self.var_c78c1f22)) {
        self.var_20149b34 = self.var_c78c1f22;
        return;
    }
    if (level.players.size >= 3 && isdefined(self.var_5b917145)) {
        self.var_20149b34 = self.var_5b917145;
        return;
    }
    if (level.players.size >= 2 && isdefined(self.var_73a95774)) {
        self.var_20149b34 = self.var_73a95774;
        return;
    }
    self.var_20149b34 = self.var_5b01a5b7;
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0xdc1046d0, Offset: 0x1128
// Size: 0x10a
function function_b72dc5ae() {
    function_c791ea22();
    function_f6bee20a();
    function_497c788();
    function_12d13f75();
    function_b4162883();
    foreach (sp in self.spawners) {
        sp function_c791ea22();
        sp function_f6bee20a();
        sp function_497c788();
    }
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0x2d2a4116, Offset: 0x1240
// Size: 0x98
function function_798a2c2() {
    if (!isdefined(self.var_29534eb8)) {
        self.var_29534eb8 = 0;
    }
    if (!isdefined(self.var_83f92d46)) {
        self.var_83f92d46 = 0;
    }
    if (self.var_83f92d46 > 0 && self.var_83f92d46 > self.var_29534eb8) {
        wait randomfloatrange(self.var_29534eb8, self.var_83f92d46);
        return;
    }
    if (self.var_29534eb8 > 0) {
        wait self.var_29534eb8;
    }
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0x75a9ea4a, Offset: 0x12e0
// Size: 0x7c4
function function_4f3c7857() {
    self endon(#"death");
    self function_b088c390();
    self function_180dd5b8();
    self thread function_59c8d9fd();
    self thread function_1a7d1c94();
    self.enable = 0;
    self.var_e5c2eec1 = [];
    self.spawncount = 0;
    isfirsttime = 1;
    self.var_d8202611 = getentarray(self.target, "targetname");
    assert(self.var_d8202611.size, "<dev string:x158>" + self.sm_id + "<dev string:x168>");
    level flag::wait_till("sm_" + self.sm_id + "_enabled");
    util::script_delay();
    self function_8180b524();
    var_2032c6ef = 1;
    self function_96547d01();
    while (self.count != 0 && self.spawners.size > 0) {
        function_49adc3a9();
        n_active = self.var_e5c2eec1.size;
        var_ad5a25f2 = self.var_e290d32d - n_active;
        if (!var_2032c6ef && self.var_e5c2eec1.size <= self.var_5fa59123) {
            var_2032c6ef = 1;
            function_798a2c2();
        } else if (var_2032c6ef && var_ad5a25f2 < self.var_bf8006e3) {
            var_2032c6ef = 0;
        }
        if (!var_2032c6ef) {
            wait 0.05;
            continue;
        }
        self function_96547d01();
        if (self.count > 0) {
            if (self.var_bf8006e3 > self.count) {
                self.var_bf8006e3 = self.count;
            }
        }
        spawned = 0;
        while (!spawned) {
            function_49adc3a9();
            if (self.spawners.size <= 0) {
                break;
            }
            if (self function_2ce178dd(self.var_bf8006e3)) {
                assert(self.var_bf8006e3 > 0);
                var_97820103 = [];
                var_34017727 = [];
                for (i = 0; i < self.spawners.size; i++) {
                    current_spawner = self.spawners[i];
                    if (isdefined(current_spawner)) {
                        if (current_spawner.var_e5c2eec1.size > current_spawner.var_5fa59123) {
                            continue;
                        }
                        var_70296209 = current_spawner.var_e290d32d - current_spawner.var_e5c2eec1.size;
                        if (var_70296209 >= self.var_bf8006e3) {
                            if (isdefined(current_spawner.spawnflags) && (current_spawner.spawnflags & 32) == 32) {
                                var_34017727[var_34017727.size] = current_spawner;
                                continue;
                            }
                            var_97820103[var_97820103.size] = current_spawner;
                        }
                    }
                }
                if (var_97820103.size > 0 || var_34017727.size > 0) {
                    if (var_34017727.size > 0) {
                        spawner = array::random(var_34017727);
                    } else {
                        spawner = array::random(var_97820103);
                    }
                    if (!(isdefined(spawner.spawnflags) && (spawner.spawnflags & 64) == 64) && spawner.count < self.var_bf8006e3) {
                        self.var_bf8006e3 = spawner.count;
                    }
                    if (!isfirsttime) {
                        function_960bbce6();
                    } else {
                        isfirsttime = 0;
                    }
                    if (!self.enable) {
                        continue;
                    }
                    self function_668c4ede(spawner, self.var_bf8006e3);
                    spawned = 1;
                } else {
                    var_e5d9a7ad = 0;
                    for (i = 0; i < self.spawners.size; i++) {
                        current_spawner = self.spawners[i];
                        if (isdefined(current_spawner)) {
                            if (current_spawner.var_e290d32d > var_e5d9a7ad) {
                                var_e5d9a7ad = current_spawner.var_e290d32d;
                            }
                        }
                    }
                    if (var_e5d9a7ad < self.var_20149b34) {
                        self.var_20149b34 = var_e5d9a7ad;
                        self function_96547d01();
                    }
                }
            }
            wait 0.05;
        }
        wait 0.05;
        assert(!level flag::get("<dev string:xad>" + self.sm_id + "<dev string:x187>"), "<dev string:xba>");
        assert(!level flag::get("<dev string:xad>" + self.sm_id + "<dev string:x18f>"), "<dev string:xba>");
        if (!(isdefined(self.script_forcespawn) && self.script_forcespawn)) {
            numplayers = max(getplayers().size, 1);
            wait laststand::player_num_in_laststand() / numplayers * 8;
        }
    }
    self function_a192045f();
    if (isdefined(self.var_e5c2eec1) && self.var_e5c2eec1.size != 0) {
        array::wait_till(self.var_e5c2eec1, "death");
    }
    self delete();
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0x2bab9b2a, Offset: 0x1ab0
// Size: 0x74
function function_59c8d9fd() {
    while (isdefined(self)) {
        self waittill(#"enable");
        self.enable = 1;
        self function_a4c90661();
        self waittill(#"disable");
        self function_4f80fcc2();
    }
    self function_4f80fcc2();
}

// Namespace spawn_manager
// Params 1, eflags: 0x0
// Checksum 0x3b531811, Offset: 0x1b30
// Size: 0x4c
function function_95ee6040(spawn_manager) {
    spawn_manager endon(#"death");
    spawn_manager endon(#"enable");
    self endon(#"death");
    self waittill(#"trigger");
    spawn_manager notify(#"enable");
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0xc2687fc9, Offset: 0x1b88
// Size: 0x14c
function function_1a7d1c94() {
    self waittill(#"death");
    sm_id = self.sm_id;
    a_spawners = self.var_d8202611;
    var_f3e62b98 = self.var_e5c2eec1;
    level flag::clear("sm_" + sm_id + "_enabled");
    level flag::set("sm_" + sm_id + "_killed");
    level flag::set("sm_" + sm_id + "_complete");
    array::delete_all(a_spawners);
    if (var_f3e62b98.size) {
        array::wait_till(var_f3e62b98, "death");
    }
    level flag::set("sm_" + sm_id + "_cleared");
    level.spawn_managers = array::remove_undefined(level.spawn_managers);
}

// Namespace spawn_manager
// Params 1, eflags: 0x0
// Checksum 0x1266c6de, Offset: 0x1ce0
// Size: 0x198
function function_a307afed(var_38e11efe) {
    triggers = trigger::get_all("trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_damage", "trigger_box");
    foreach (trig in triggers) {
        if (isdefined(trig.target)) {
            targets = function_1d528fc9(trig.target);
            foreach (target in targets) {
                trig thread function_95ee6040(target);
            }
        }
    }
}

// Namespace spawn_manager
// Params 1, eflags: 0x0
// Checksum 0x12118e47, Offset: 0x1e80
// Size: 0x120
function function_1d528fc9(targetname) {
    if (isdefined(targetname)) {
        var_a2ced170 = [];
        for (i = 0; i < level.spawn_managers.size; i++) {
            if (isdefined(level.spawn_managers[i])) {
                if (level.spawn_managers[i].targetname === targetname || level.spawn_managers[i].name === targetname) {
                    if (!isdefined(var_a2ced170)) {
                        var_a2ced170 = [];
                    } else if (!isarray(var_a2ced170)) {
                        var_a2ced170 = array(var_a2ced170);
                    }
                    var_a2ced170[var_a2ced170.size] = level.spawn_managers[i];
                }
            }
        }
        return var_a2ced170;
    }
    return level.spawn_managers;
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0x751cbd0f, Offset: 0x1fa8
// Size: 0x38c
function function_826b96e5() {
    arrayremovevalue(self.var_d8202611, undefined);
    exclude = [];
    for (i = 0; i < self.var_d8202611.size; i++) {
        if (isdefined(level.var_8abbc4a7) && self.var_d8202611[i].classname == "actor_enemy_dog_sp") {
            if (!isdefined(exclude)) {
                exclude = [];
            } else if (!isarray(exclude)) {
                exclude = array(exclude);
            }
            exclude[exclude.size] = self.var_d8202611[i];
        }
    }
    self.var_d8202611 = array::exclude(self.var_d8202611, exclude);
    var_ac004116 = 0;
    foreach (sp in self.var_d8202611) {
        if (!isdefined(sp.var_bd948b2a)) {
            sp.var_bd948b2a = sp.count;
        }
        if (!isdefined(sp.var_6f1e6d96)) {
            sp.var_6f1e6d96 = isdefined(sp.var_e290d32d) ? sp.var_e290d32d : level.var_b5b6bce6;
        }
        if (!isdefined(sp.var_4cb76884)) {
            sp.var_4cb76884 = isdefined(sp.var_5fa59123) ? sp.var_5fa59123 : sp.var_6f1e6d96;
        }
        sp.var_e5c2eec1 = [];
    }
    var_86c9545d = arraycopy(self.var_d8202611);
    var_1861712f = self.var_bc2f37e4;
    if (var_1861712f > self.var_d8202611.size) {
        var_1861712f = self.var_d8202611.size;
    }
    spawners = [];
    while (spawners.size < var_1861712f) {
        spawner = array::random(var_86c9545d);
        if (!isdefined(spawners)) {
            spawners = [];
        } else if (!isarray(spawners)) {
            spawners = array(spawners);
        }
        spawners[spawners.size] = spawner;
        arrayremovevalue(var_86c9545d, spawner);
    }
    return spawners;
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0xe70357d4, Offset: 0x2340
// Size: 0x5e
function function_96547d01() {
    if (self.var_4d210f7a < self.var_20149b34) {
        self.var_bf8006e3 = randomintrange(self.var_4d210f7a, self.var_20149b34 + 1);
    } else {
        self.var_bf8006e3 = self.var_4d210f7a;
    }
    return self.var_bf8006e3;
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0x77a52018, Offset: 0x23a8
// Size: 0xc4
function function_49adc3a9() {
    spawners = [];
    for (i = 0; i < self.spawners.size; i++) {
        if (isdefined(self.spawners[i])) {
            if (self.spawners[i].count != 0) {
                spawners[spawners.size] = self.spawners[i];
                continue;
            }
            self.spawners[i] delete();
        }
    }
    self.spawners = spawners;
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0x4edb3063, Offset: 0x2478
// Size: 0x194
function function_960bbce6() {
    if (isdefined(self.script_wait)) {
        wait self.script_wait;
        if (isdefined(self.script_wait_add)) {
            self.script_wait += self.script_wait_add;
        }
        return;
    }
    if (isdefined(self.script_wait_min) && isdefined(self.script_wait_max)) {
        var_714358d = 1;
        players = getplayers();
        if (players.size == 2) {
            var_714358d = 0.7;
        } else if (players.size == 3) {
            var_714358d = 0.5;
        } else if (players.size == 4) {
            var_714358d = 0.3;
        }
        diff = self.script_wait_max - self.script_wait_min;
        if (abs(diff) > 0) {
            wait randomfloatrange(self.script_wait_min, self.script_wait_min + diff * var_714358d);
        } else {
            wait self.script_wait_min;
        }
        if (isdefined(self.script_wait_add)) {
            self.script_wait_min += self.script_wait_add;
            self.script_wait_max += self.script_wait_add;
        }
    }
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0x47ce8276, Offset: 0x2618
// Size: 0xc4
function function_180dd5b8() {
    level flag::init("sm_" + self.sm_id + "_enabled");
    level flag::init("sm_" + self.sm_id + "_complete");
    level flag::init("sm_" + self.sm_id + "_killed");
    level flag::init("sm_" + self.sm_id + "_cleared");
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0xd66492a6, Offset: 0x26e8
// Size: 0x7c
function function_a4c90661() {
    assert(!level flag::get("<dev string:xad>" + self.sm_id + "<dev string:xb1>"), "<dev string:xba>");
    level flag::set("sm_" + self.sm_id + "_enabled");
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0xbccc0114, Offset: 0x2770
// Size: 0x3c
function function_4f80fcc2() {
    self.enable = 0;
    level flag::clear("sm_" + self.sm_id + "_enabled");
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0x15daa95c, Offset: 0x27b8
// Size: 0x7c
function function_b2ad4aa9() {
    assert(!level flag::get("<dev string:xad>" + self.sm_id + "<dev string:x187>"), "<dev string:xba>");
    level flag::set("sm_" + self.sm_id + "_killed");
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0xcd78f4a9, Offset: 0x2840
// Size: 0x7c
function function_a192045f() {
    assert(!level flag::get("<dev string:xad>" + self.sm_id + "<dev string:x18f>"), "<dev string:xba>");
    level flag::set("sm_" + self.sm_id + "_complete");
}

// Namespace spawn_manager
// Params 0, eflags: 0x0
// Checksum 0xa0247fc5, Offset: 0x28c8
// Size: 0x7c
function function_752c456a() {
    assert(!level flag::get("<dev string:xad>" + self.sm_id + "<dev string:x199>"), "<dev string:xba>");
    level flag::set("sm_" + self.sm_id + "_cleared");
}

// Namespace spawn_manager
// Params 1, eflags: 0x0
// Checksum 0x646173e4, Offset: 0x2950
// Size: 0x40
function function_41cd3a68(var_703b8c9a) {
    assert(var_703b8c9a <= 32, "<dev string:x1a2>");
    level.var_b5b6bce6 = var_703b8c9a;
}

// Namespace spawn_manager
// Params 4, eflags: 0x0
// Checksum 0x53620539, Offset: 0x2998
// Size: 0x14c
function function_a226cc(var_12173487, trig_name, var_8f641cf, var_6f97d0a3) {
    if (isdefined(var_6f97d0a3) && var_6f97d0a3) {
        trigger = getent(trig_name, var_8f641cf);
        assert(isdefined(trigger), "<dev string:x1df>" + var_8f641cf + "<dev string:x1ec>" + trig_name + "<dev string:x1f0>");
        trigger endon(#"trigger");
    }
    if (level flag::exists("sm_" + var_12173487 + "_enabled")) {
        level flag::wait_till("sm_" + var_12173487 + "_complete");
        trigger::use(trig_name, var_8f641cf);
        return;
    }
    assertmsg("<dev string:x201>" + var_12173487 + "<dev string:x229>");
}

// Namespace spawn_manager
// Params 4, eflags: 0x0
// Checksum 0x8240c588, Offset: 0x2af0
// Size: 0x14c
function function_d1d8e99b(var_12173487, trig_name, var_8f641cf, var_6f97d0a3) {
    if (isdefined(var_6f97d0a3) && var_6f97d0a3) {
        trigger = getent(trig_name, var_8f641cf);
        assert(isdefined(trigger), "<dev string:x1df>" + var_8f641cf + "<dev string:x1ec>" + trig_name + "<dev string:x1f0>");
        trigger endon(#"trigger");
    }
    if (level flag::exists("sm_" + var_12173487 + "_enabled")) {
        level flag::wait_till("sm_" + var_12173487 + "_cleared");
        trigger::use(trig_name, var_8f641cf);
        return;
    }
    assertmsg("<dev string:x236>" + var_12173487 + "<dev string:x229>");
}

// Namespace spawn_manager
// Params 4, eflags: 0x0
// Checksum 0x1e036be0, Offset: 0x2c48
// Size: 0x14c
function function_1da22674(var_12173487, trig_name, var_8f641cf, var_6f97d0a3) {
    if (isdefined(var_6f97d0a3) && var_6f97d0a3) {
        trigger = getent(trig_name, var_8f641cf);
        assert(isdefined(trigger), "<dev string:x1df>" + var_8f641cf + "<dev string:x1ec>" + trig_name + "<dev string:x1f0>");
        trigger endon(#"trigger");
    }
    if (level flag::exists("sm_" + var_12173487 + "_enabled")) {
        level flag::wait_till("sm_" + var_12173487 + "_enabled");
        trigger::use(trig_name, var_8f641cf);
        return;
    }
    assertmsg("<dev string:x236>" + var_12173487 + "<dev string:x229>");
}

// Namespace spawn_manager
// Params 8, eflags: 0x0
// Checksum 0x292ca172, Offset: 0x2da0
// Size: 0x10c
function function_5000af1e(var_12173487, process, ent, var1, var2, var3, var4, var5) {
    assert(isdefined(process), "<dev string:x260>");
    assert(level flag::exists("<dev string:xad>" + var_12173487 + "<dev string:xb1>"), "<dev string:x294>" + var_12173487 + "<dev string:x229>");
    wait_till_complete(var_12173487);
    util::single_func(ent, process, var1, var2, var3, var4, var5);
}

// Namespace spawn_manager
// Params 8, eflags: 0x0
// Checksum 0xed260135, Offset: 0x2eb8
// Size: 0x10c
function function_16c424d1(var_12173487, process, ent, var1, var2, var3, var4, var5) {
    assert(isdefined(process), "<dev string:x2bc>");
    assert(level flag::exists("<dev string:xad>" + var_12173487 + "<dev string:xb1>"), "<dev string:x2ef>" + var_12173487 + "<dev string:x229>");
    wait_till_cleared(var_12173487);
    util::single_func(ent, process, var1, var2, var3, var4, var5);
}

// Namespace spawn_manager
// Params 8, eflags: 0x0
// Checksum 0xa8013596, Offset: 0x2fd0
// Size: 0x10c
function function_617b3ed2(var_12173487, process, ent, var1, var2, var3, var4, var5) {
    assert(isdefined(process), "<dev string:x316>");
    assert(level flag::exists("<dev string:xad>" + var_12173487 + "<dev string:xb1>"), "<dev string:x349>" + var_12173487 + "<dev string:x229>");
    function_22e86a7e(var_12173487);
    util::single_func(ent, process, var1, var2, var3, var4, var5);
}

// Namespace spawn_manager
// Params 2, eflags: 0x0
// Checksum 0x9c323a2d, Offset: 0x30e8
// Size: 0x124
function enable(var_12173487, var_aa7c8545) {
    if (level flag::exists("sm_" + var_12173487 + "_enabled")) {
        foreach (sm in level.spawn_managers) {
            if (isdefined(sm) && sm.sm_id == var_12173487) {
                sm notify(#"enable");
                return;
            }
        }
        return;
    }
    if (!(isdefined(var_aa7c8545) && var_aa7c8545)) {
        assertmsg("<dev string:x370>" + var_12173487 + "<dev string:x229>");
    }
}

// Namespace spawn_manager
// Params 2, eflags: 0x0
// Checksum 0x5145bf25, Offset: 0x3218
// Size: 0x124
function disable(var_12173487, var_aa7c8545) {
    if (level flag::exists("sm_" + var_12173487 + "_enabled")) {
        foreach (sm in level.spawn_managers) {
            if (isdefined(sm) && sm.sm_id == var_12173487) {
                sm notify(#"disable");
                return;
            }
        }
        return;
    }
    if (!(isdefined(var_aa7c8545) && var_aa7c8545)) {
        assertmsg("<dev string:x388>" + var_12173487 + "<dev string:x229>");
    }
}

// Namespace spawn_manager
// Params 2, eflags: 0x0
// Checksum 0x73fab842, Offset: 0x3348
// Size: 0x14c
function kill(var_12173487, var_aa7c8545) {
    if (level flag::exists("sm_" + var_12173487 + "_enabled")) {
        foreach (sm in level.spawn_managers) {
            if (isdefined(sm) && sm.sm_id == var_12173487) {
                sm delete();
                level.spawn_managers = array::remove_undefined(level.spawn_managers);
                return;
            }
        }
        return;
    }
    if (!(isdefined(var_aa7c8545) && var_aa7c8545)) {
        assertmsg("<dev string:x3a1>" + var_12173487 + "<dev string:x229>");
    }
}

// Namespace spawn_manager
// Params 1, eflags: 0x0
// Checksum 0xe35129a3, Offset: 0x34a0
// Size: 0x9c
function is_enabled(var_12173487) {
    if (level flag::exists("sm_" + var_12173487 + "_enabled")) {
        if (level flag::get("sm_" + var_12173487 + "_enabled")) {
            return 1;
        }
        return 0;
    }
    assertmsg("<dev string:x3b7>" + var_12173487 + "<dev string:x229>");
}

// Namespace spawn_manager
// Params 1, eflags: 0x0
// Checksum 0x53b0ac1f, Offset: 0x3548
// Size: 0x9c
function is_complete(var_12173487) {
    if (level flag::exists("sm_" + var_12173487 + "_enabled")) {
        if (level flag::get("sm_" + var_12173487 + "_complete")) {
            return 1;
        }
        return 0;
    }
    assertmsg("<dev string:x3d3>" + var_12173487 + "<dev string:x229>");
}

// Namespace spawn_manager
// Params 1, eflags: 0x0
// Checksum 0x139c59aa, Offset: 0x35f0
// Size: 0x9c
function function_b02fc450(var_12173487) {
    if (level flag::exists("sm_" + var_12173487 + "_enabled")) {
        if (level flag::get("sm_" + var_12173487 + "_cleared")) {
            return 1;
        }
        return 0;
    }
    assertmsg("<dev string:x3f0>" + var_12173487 + "<dev string:x229>");
}

// Namespace spawn_manager
// Params 1, eflags: 0x0
// Checksum 0x417f75c4, Offset: 0x3698
// Size: 0x9c
function is_killed(var_12173487) {
    if (level flag::exists("sm_" + var_12173487 + "_enabled")) {
        if (level flag::get("sm_" + var_12173487 + "_killed")) {
            return 1;
        }
        return 0;
    }
    assertmsg("<dev string:x40c>" + var_12173487 + "<dev string:x229>");
}

// Namespace spawn_manager
// Params 1, eflags: 0x0
// Checksum 0x1e8a7dab, Offset: 0x3740
// Size: 0x8c
function wait_till_cleared(var_12173487) {
    if (level flag::exists("sm_" + var_12173487 + "_enabled")) {
        level flag::wait_till("sm_" + var_12173487 + "_cleared");
        return;
    }
    assertmsg("<dev string:x427>" + var_12173487 + "<dev string:x229>");
}

// Namespace spawn_manager
// Params 2, eflags: 0x0
// Checksum 0x42954ba5, Offset: 0x37d8
// Size: 0x134
function function_27bf2e8(var_12173487, var_41cac60e) {
    assert(isdefined(var_41cac60e), "<dev string:x44a>");
    assert(var_41cac60e, "<dev string:x490>");
    if (level flag::exists("sm_" + var_12173487 + "_enabled")) {
        level flag::wait_till("sm_" + var_12173487 + "_complete");
    } else {
        assertmsg("<dev string:x4ee>" + var_12173487 + "<dev string:x229>");
    }
    if (level flag::get("sm_" + var_12173487 + "_cleared")) {
        return;
    }
    while (function_423eae50(var_12173487).size > var_41cac60e) {
        wait 0.1;
    }
}

// Namespace spawn_manager
// Params 1, eflags: 0x0
// Checksum 0xe9ddf758, Offset: 0x3918
// Size: 0x8c
function wait_till_complete(var_12173487) {
    if (level flag::exists("sm_" + var_12173487 + "_enabled")) {
        level flag::wait_till("sm_" + var_12173487 + "_complete");
        return;
    }
    assertmsg("<dev string:x516>" + var_12173487 + "<dev string:x229>");
}

// Namespace spawn_manager
// Params 1, eflags: 0x0
// Checksum 0xb3d03906, Offset: 0x39b0
// Size: 0x8c
function function_22e86a7e(var_12173487) {
    if (level flag::exists("sm_" + var_12173487 + "_enabled")) {
        level flag::wait_till("sm_" + var_12173487 + "_enabled");
        return;
    }
    assertmsg("<dev string:x53a>" + var_12173487 + "<dev string:x229>");
}

// Namespace spawn_manager
// Params 2, eflags: 0x0
// Checksum 0x6f9cfc62, Offset: 0x3a48
// Size: 0x16c
function function_740ea7ff(var_12173487, count) {
    if (level flag::exists("sm_" + var_12173487 + "_enabled")) {
        level flag::wait_till("sm_" + var_12173487 + "_enabled");
    } else {
        assertmsg("<dev string:x55d>" + var_12173487 + "<dev string:x229>");
    }
    spawn_manager = function_1d528fc9(var_12173487);
    assert(spawn_manager.size, "<dev string:x586>");
    assert(spawn_manager.size == 1, "<dev string:x5cf>");
    while (true) {
        if (isdefined(spawn_manager[0].spawncount) && spawn_manager[0].spawncount < count && !is_killed(var_12173487)) {
            wait 0.5;
            continue;
        }
        break;
    }
}

// Namespace spawn_manager
// Params 1, eflags: 0x0
// Checksum 0x964e17d3, Offset: 0x3bc0
// Size: 0x3c
function function_423eae50(var_12173487) {
    a_ai = getaiarray(var_12173487, "sm_id");
    return a_ai;
}

