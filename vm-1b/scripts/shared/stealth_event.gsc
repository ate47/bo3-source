#using scripts/shared/stealth_vo;
#using scripts/shared/stealth_behavior;
#using scripts/shared/stealth_debug;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;

#namespace namespace_c8814633;

// Namespace namespace_c8814633
// Params 0, eflags: 0x0
// Checksum 0x7ec38d94, Offset: 0x210
// Size: 0xb2
function init() {
    assert(isdefined(self.stealth));
    if (isdefined(self.stealth.event)) {
        return;
    }
    if (!isdefined(self.stealth.event)) {
        self.stealth.event = spawnstruct();
    }
    if (!isdefined(self.stealth.event.package)) {
        self.stealth.event.package = spawnstruct();
    }
    self function_78e2e218();
}

// Namespace namespace_c8814633
// Params 0, eflags: 0x0
// Checksum 0xa4da884b, Offset: 0x2d0
// Size: 0x1e
function enabled() {
    return isdefined(self.stealth) && isdefined(self.stealth.event);
}

// Namespace namespace_c8814633
// Params 0, eflags: 0x0
// Checksum 0x5e6a3888, Offset: 0x2f8
// Size: 0x202
function function_78e2e218() {
    self register_handler("alert", &namespace_80045451::function_6c10e440, 3);
    if (isactor(self)) {
        self register_handler("pain", &function_26f273e1, 2);
        self register_handler("death", &function_26f273e1, 2);
        self register_handler("damage", &function_26f273e1, 2);
        self register_handler("combat_spread", &namespace_80045451::function_101ac5, 1);
        self register_handler("combat_interest", &namespace_80045451::function_933965f6, 2);
        self register_handler("stealth_sight_start", &namespace_80045451::function_ca6a0809, 1);
        self register_handler("stealth_sight_max", &namespace_80045451::function_617b90af, 1);
        self register_handler("stealth_sight_end", &namespace_80045451::function_85b3a352, 1);
        self register_handler("witness_combat", &namespace_80045451::function_a7964595, 2);
        self register_handler("investigate", &namespace_7829c86f::function_de77b9e6, 3);
        self register_handler("stealth_vo", &namespace_234a4910::function_2756e5d4, 1);
    }
    self thread function_b349369d();
}

// Namespace namespace_c8814633
// Params 0, eflags: 0x0
// Checksum 0xc4860d46, Offset: 0x508
// Size: 0x2b
function function_b349369d() {
    self util::waittill_any("stop_stealth", "death");
    self notify(#"hash_2bbc4f84");
}

// Namespace namespace_c8814633
// Params 3, eflags: 0x0
// Checksum 0x457ea54f, Offset: 0x540
// Size: 0x14d
function register_handler(eventname, func, var_8a0dd434) {
    if (!isdefined(var_8a0dd434)) {
        var_8a0dd434 = 0;
    }
    if (!isdefined(level.stealth.eventhandler)) {
        level.stealth.eventhandler = [];
    }
    if (!isdefined(level.stealth.eventhandler[eventname])) {
        level.stealth.eventhandler[eventname] = func;
    }
    if (eventname == "death") {
        self thread function_551bd4f3();
        return;
    }
    switch (var_8a0dd434) {
    case 0:
        self thread function_44782a56(eventname);
        break;
    case 1:
        self thread function_6a7aa4bf(eventname);
        break;
    case 2:
        self thread function_f8733584(eventname);
        break;
    case 3:
        self thread function_1e75afed(eventname);
        break;
    default:
        /#
            iprintlnbold("<unknown string>" + var_8a0dd434);
        #/
        break;
    }
}

// Namespace namespace_c8814633
// Params 1, eflags: 0x0
// Checksum 0x33aaa1c6, Offset: 0x698
// Size: 0x35
function function_44782a56(eventname) {
    self endon(#"hash_2bbc4f84");
    while (true) {
        self waittill(eventname);
        self thread function_5b52d0d9(eventname);
    }
}

// Namespace namespace_c8814633
// Params 1, eflags: 0x0
// Checksum 0xff62b60d, Offset: 0x6d8
// Size: 0x3d
function function_6a7aa4bf(eventname) {
    self endon(#"hash_2bbc4f84");
    while (true) {
        arg1 = self waittill(eventname);
        self thread function_5b52d0d9(eventname, arg1);
    }
}

// Namespace namespace_c8814633
// Params 1, eflags: 0x0
// Checksum 0xf1413c0b, Offset: 0x720
// Size: 0x4d
function function_f8733584(eventname) {
    self endon(#"hash_2bbc4f84");
    while (true) {
        arg1, arg2 = self waittill(eventname);
        self thread function_5b52d0d9(eventname, arg1, arg2);
    }
}

// Namespace namespace_c8814633
// Params 0, eflags: 0x0
// Checksum 0x22e9db40, Offset: 0x778
// Size: 0x42
function function_551bd4f3() {
    self endon(#"hash_94ff6d85");
    arg1, arg2 = self waittill(#"death");
    self thread function_5b52d0d9("death", arg1, arg2);
}

// Namespace namespace_c8814633
// Params 1, eflags: 0x0
// Checksum 0xfa58b943, Offset: 0x7c8
// Size: 0x55
function function_1e75afed(eventname) {
    self endon(#"hash_2bbc4f84");
    while (true) {
        arg1, arg2, arg3 = self waittill(eventname);
        self thread function_5b52d0d9(eventname, arg1, arg2, arg3);
    }
}

// Namespace namespace_c8814633
// Params 4, eflags: 0x4
// Checksum 0xe3d2bbef, Offset: 0x828
// Size: 0x239
function private function_5b52d0d9(eventname, arg1, arg2, arg3) {
    self endon(#"hash_94ff6d85");
    assert(isdefined(eventname));
    assert(isdefined(level.stealth.eventhandler[eventname]));
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.stealth)) {
        return;
    }
    if (!isdefined(level.stealth)) {
        return;
    }
    if (eventname != "alert" || !(isdefined(self.var_89b9fc6) && self.var_89b9fc6)) {
        if (isdefined(self.ignoreall) && self.ignoreall && eventname != "death") {
            return;
        }
    }
    /#
        if (namespace_e449108e::enabled() && isdefined(self) && isentity(self)) {
            args = "<unknown string>";
            if (isdefined(arg1)) {
                args = "<unknown string>" + namespace_e449108e::debug_text(arg1) + args;
            }
            self thread namespace_e449108e::function_1c1f41ef(eventname + "<unknown string>" + args + "<unknown string>", (0.75, 0.75, 0.75), 1, 0.5, self.origin + (0, 0, 30), 3);
        }
    #/
    self.stealth.event.package.name = eventname;
    self.stealth.event.package.parms[0] = arg1;
    self.stealth.event.package.parms[1] = arg2;
    self.stealth.event.package.parms[2] = arg3;
    self [[ level.stealth.eventhandler[eventname] ]](self.stealth.event.package);
}

// Namespace namespace_c8814633
// Params 1, eflags: 0x0
// Checksum 0xa609f4c5, Offset: 0xa70
// Size: 0xfa
function function_26f273e1(var_904f1fb9) {
    if (!isdefined(self)) {
        return;
    }
    e_attacker = var_904f1fb9.parms[0];
    if (!isentity(e_attacker)) {
        e_attacker = var_904f1fb9.parms[1];
    }
    wait(0.05);
    if (!isdefined(self) || !isdefined(self.team)) {
        return;
    }
    if (isdefined(e_attacker) && e_attacker.team != self.team) {
        if (isalive(self)) {
            self notify(#"alert", "combat", e_attacker.origin, e_attacker, "took_damage");
        }
        self function_7dd521be(self.team, self.origin, 300, -128, 1, "witness_combat", e_attacker, "saw_combat");
    }
}

// Namespace namespace_c8814633
// Params 11, eflags: 0x0
// Checksum 0x425d5186, Offset: 0xb78
// Size: 0x1d9
function function_7dd521be(str_team, v_origin, radius, maxheightdiff, requiresight, eventname, arg1, arg2, arg3, arg4, arg5) {
    radiussq = radius * radius;
    agentlist = getaiarray();
    foreach (agent in agentlist) {
        if (!isalive(agent)) {
            continue;
        }
        if ((!isdefined(self) || !(agent === self)) && distancesquared(v_origin, agent.origin) < radiussq) {
            if (agent namespace_80045451::enabled() && agent namespace_80045451::function_739525d() == "combat") {
                continue;
            }
            if (abs(agent.origin[2] - self.origin[2]) > maxheightdiff) {
                continue;
            }
            var_be41c5a2 = !requiresight;
            if (requiresight) {
                var_be41c5a2 = agent stealth::can_see(self);
            }
            if (var_be41c5a2 && requiresight) {
                agent notify(eventname, arg1, arg2, arg3, arg4, arg5);
                continue;
            }
            if (var_be41c5a2) {
                agent notify(eventname, arg1, arg2, arg3, arg4, arg5);
            }
        }
    }
}

