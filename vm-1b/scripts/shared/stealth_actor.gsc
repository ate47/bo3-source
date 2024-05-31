#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/stealth_vo;
#using scripts/shared/stealth_tagging;
#using scripts/shared/stealth_status;
#using scripts/shared/stealth_event;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth_debug;
#using scripts/shared/stealth_behavior;
#using scripts/shared/stealth;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;

#namespace namespace_aec89ff8;

// Namespace namespace_aec89ff8
// Params 0, eflags: 0x0
// namespace_aec89ff8<file_0>::function_c35e6aab
// Checksum 0xc4aead01, Offset: 0x2f0
// Size: 0x17a
function init() {
    assert(isactor(self));
    if (!(isdefined(self.script_stealth) && self.script_stealth) && !(isdefined(self.var_64f4c3f) && self.var_64f4c3f) && !(isdefined(self.var_66a618ee) && self.var_66a618ee)) {
        return;
    }
    if (isdefined(self.stealth)) {
        return;
    }
    if (!isdefined(self.stealth)) {
        self.stealth = spawnstruct();
    }
    self.stealth.var_1286401a = 1;
    self function_a860a2eb();
    self namespace_8312dbf::init();
    self namespace_80045451::init();
    self namespace_c8814633::init();
    self namespace_f917b91a::init();
    self namespace_234a4910::init();
    self.overrideactordamage = &function_ebcb7adc;
    /#
        self namespace_e449108e::init_debug();
    #/
    if (isdefined(self.var_66a618ee) && (isdefined(self.var_64f4c3f) && self.var_64f4c3f || self.var_66a618ee)) {
        self thread function_39fb9593();
    }
}

// Namespace namespace_aec89ff8
// Params 0, eflags: 0x0
// namespace_aec89ff8<file_0>::function_fcf56ab5
// Checksum 0xf3435f9f, Offset: 0x478
// Size: 0xaa
function stop() {
    if (self namespace_80045451::enabled()) {
        self namespace_80045451::function_a2429809("combat");
        self.stealth.investigating = undefined;
        foreach (player in level.activeplayers) {
            self setignoreent(player, 0);
        }
        self namespace_8312dbf::function_180adb28();
    }
}

// Namespace namespace_aec89ff8
// Params 0, eflags: 0x0
// namespace_aec89ff8<file_0>::function_11424fa
// Checksum 0x8e094975, Offset: 0x530
// Size: 0x2a
function reset() {
    if (self namespace_80045451::enabled()) {
        self namespace_80045451::function_a2429809("unaware");
    }
}

// Namespace namespace_aec89ff8
// Params 0, eflags: 0x0
// namespace_aec89ff8<file_0>::function_b55533bc
// Checksum 0xb2f90984, Offset: 0x568
// Size: 0x1e
function enabled() {
    return isdefined(self.stealth) && isdefined(self.stealth.var_1286401a);
}

// Namespace namespace_aec89ff8
// Params 0, eflags: 0x0
// namespace_aec89ff8<file_0>::function_a860a2eb
// Checksum 0x7e156232, Offset: 0x590
// Size: 0x13d
function function_a860a2eb() {
    entnum = self getentitynumber();
    if (!isdefined(self.___archetypeonanimscriptedcallback) || isdefined(self.stealth) && !isdefined(self.stealth.var_fd87ae1c) && self.___archetypeonanimscriptedcallback != &function_a880fdea) {
        self.stealth.var_fd87ae1c = self.___archetypeonanimscriptedcallback;
    }
    self.___archetypeonanimscriptedcallback = &function_a880fdea;
    switch (entnum % 4) {
    case 1:
        blackboard::setblackboardattribute(self, "_context2", "v2");
        break;
    case 2:
        blackboard::setblackboardattribute(self, "_context2", "v3");
        break;
    case 3:
        blackboard::setblackboardattribute(self, "_context2", "v4");
        break;
    default:
        blackboard::setblackboardattribute(self, "_context2", "v1");
        break;
    }
}

// Namespace namespace_aec89ff8
// Params 1, eflags: 0x0
// namespace_aec89ff8<file_0>::function_a880fdea
// Checksum 0xd697666e, Offset: 0x6d8
// Size: 0x52
function function_a880fdea(entity) {
    if (isdefined(entity.stealth) && isdefined(entity.stealth.var_fd87ae1c)) {
        [[ entity.stealth.var_fd87ae1c ]](entity);
    }
    entity function_a860a2eb();
}

// Namespace namespace_aec89ff8
// Params 13, eflags: 0x0
// namespace_aec89ff8<file_0>::function_ebcb7adc
// Checksum 0x524f0365, Offset: 0x738
// Size: 0xdb
function function_ebcb7adc(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
    if (self.awarenesslevelcurrent != "combat" && idamage > 10) {
        var_a16c4666 = self geteye();
        if (isplayer(einflictor) && isdefined(vpoint) && distancesquared(vpoint, var_a16c4666) < 100) {
            return (self.health + 1);
        }
    }
    return idamage;
}

// Namespace namespace_aec89ff8
// Params 0, eflags: 0x0
// namespace_aec89ff8<file_0>::function_39fb9593
// Checksum 0xd3835de4, Offset: 0x820
// Size: 0x245
function function_39fb9593() {
    self notify(#"hash_39fb9593");
    self endon(#"hash_39fb9593");
    self endon(#"death");
    self.var_75a707ea = 1;
    if (!(isdefined(self.var_66a618ee) && self.var_66a618ee)) {
        self function_77ae41ed(1);
        if (self ai::has_behavior_attribute("sprint")) {
            self ai::set_behavior_attribute("sprint", 1);
        }
        if (self ai::has_behavior_attribute("traversals")) {
            self ai::set_behavior_attribute("traversals", "procedural");
        }
    }
    self thread function_8be8b843();
    if (level flag::get("stealth_discovered") && getdvarint("stealth_no_return")) {
        wait(0.05);
        self stealth::stop();
        return;
    }
    wait(1);
    self thread function_517ba9d2();
    self thread function_56e538df();
    while (true) {
        var_12131b3c = self waittill(#"hash_3dce0f1d");
        if (!self enabled() || !isdefined(level.stealth) || !isdefined(level.stealth.seek)) {
            return;
        }
        if (var_12131b3c != "combat") {
            self notify(#"investigate", self.origin, undefined, "infinite");
            continue;
        }
        if (var_12131b3c == "combat") {
            foreach (combatant in level.stealth.seek) {
                namespace_80045451::function_bc0ce0bf(combatant);
            }
            self namespace_7829c86f::function_2481442d();
        }
    }
}

// Namespace namespace_aec89ff8
// Params 0, eflags: 0x0
// namespace_aec89ff8<file_0>::function_8be8b843
// Checksum 0x9e57c4d0, Offset: 0xa70
// Size: 0xc9
function function_8be8b843() {
    self endon(#"hash_39fb9593");
    self endon(#"death");
    while (true) {
        foreach (player in level.activeplayers) {
            self getperfectinfo(player, 1);
            if (self namespace_80045451::enabled()) {
                self namespace_80045451::function_bc0ce0bf(player);
            }
        }
        self clearforcedgoal();
        self cleargoalvolume();
        wait(1);
    }
}

// Namespace namespace_aec89ff8
// Params 0, eflags: 0x0
// namespace_aec89ff8<file_0>::function_517ba9d2
// Checksum 0xa48e531a, Offset: 0xb48
// Size: 0x3f
function function_517ba9d2() {
    self endon(#"hash_39fb9593");
    self endon(#"death");
    while (true) {
        var_12131b3c = self waittill(#"awareness");
        self notify(#"hash_3dce0f1d", var_12131b3c);
    }
}

// Namespace namespace_aec89ff8
// Params 0, eflags: 0x0
// namespace_aec89ff8<file_0>::function_56e538df
// Checksum 0xac34ed42, Offset: 0xb90
// Size: 0x5d
function function_56e538df() {
    self endon(#"hash_39fb9593");
    self endon(#"death");
    while (true) {
        level flag::wait_till("stealth_combat");
        self notify(#"hash_3dce0f1d", "combat");
        level flag::wait_till_clear("stealth_combat");
    }
}

// Namespace namespace_aec89ff8
// Params 0, eflags: 0x0
// namespace_aec89ff8<file_0>::function_1064f733
// Checksum 0x6889cf43, Offset: 0xbf8
// Size: 0x219
function function_1064f733() {
    self notify(#"hash_1064f733");
    self endon(#"hash_1064f733");
    self endon(#"death");
    if (isdefined(self.var_75a707ea) && self.var_75a707ea) {
        return;
    }
    if (isdefined(self.var_1064f733) && self.var_1064f733) {
        return;
    }
    self.var_1064f733 = 1;
    nosighttime = 0;
    wait(randomfloatrange(0.1, 3));
    while (true) {
        var_a21c667 = 0;
        foreach (player in level.activeplayers) {
            if (self cansee(player)) {
                nosighttime = 0;
                var_a21c667 = 1;
                break;
            }
        }
        if (!var_a21c667) {
            nosighttime += 1;
        }
        if (nosighttime >= 8) {
            foreach (player in level.activeplayers) {
                self getperfectinfo(player, 1);
            }
            self clearforcedgoal();
            self cleargoalvolume();
            self function_77ae41ed(1);
            if (self ai::has_behavior_attribute("sprint")) {
                self ai::set_behavior_attribute("sprint", 1);
            }
        } else {
            self function_77ae41ed(0);
            if (self ai::has_behavior_attribute("sprint")) {
                self ai::set_behavior_attribute("sprint", 0);
            }
        }
        wait(1);
    }
}

// Namespace namespace_aec89ff8
// Params 1, eflags: 0x0
// namespace_aec89ff8<file_0>::function_77ae41ed
// Checksum 0xb80ab3d3, Offset: 0xe20
// Size: 0xca
function function_77ae41ed(var_e0824a47) {
    if (var_e0824a47) {
        if (self ai::has_behavior_attribute("move_mode")) {
            if (self ai::has_behavior_attribute("can_become_rusher") && self ai::get_behavior_attribute("can_become_rusher")) {
                self ai::set_behavior_attribute("move_mode", "rusher");
            } else {
                self ai::set_behavior_attribute("move_mode", "rambo");
            }
        }
        return;
    }
    if (self ai::has_behavior_attribute("move_mode")) {
        self ai::set_behavior_attribute("move_mode", "normal");
    }
}

