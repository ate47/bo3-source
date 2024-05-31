#using scripts/shared/stealth_vo;
#using scripts/shared/stealth_behavior;
#using scripts/shared/stealth_debug;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;

#namespace namespace_c8814633;

// Namespace namespace_c8814633
// Params 0, eflags: 0x1 linked
// namespace_c8814633<file_0>::function_c35e6aab
// Checksum 0x7e56cedd, Offset: 0x210
// Size: 0xd4
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
// namespace_c8814633<file_0>::function_b55533bc
// Checksum 0x969143a, Offset: 0x2f0
// Size: 0x20
function enabled() {
    return isdefined(self.stealth) && isdefined(self.stealth.event);
}

// Namespace namespace_c8814633
// Params 0, eflags: 0x1 linked
// namespace_c8814633<file_0>::function_78e2e218
// Checksum 0x9adab0ab, Offset: 0x318
// Size: 0x274
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
// Params 0, eflags: 0x1 linked
// namespace_c8814633<file_0>::function_b349369d
// Checksum 0x20a6caa, Offset: 0x598
// Size: 0x3a
function function_b349369d() {
    self util::waittill_any("stop_stealth", "death");
    self notify(#"hash_2bbc4f84");
}

// Namespace namespace_c8814633
// Params 3, eflags: 0x1 linked
// namespace_c8814633<file_0>::function_bb67c273
// Checksum 0x7632f097, Offset: 0x5e0
// Size: 0x196
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
            iprintlnbold("stealth_sight_end" + var_8a0dd434);
        #/
        break;
    }
}

// Namespace namespace_c8814633
// Params 1, eflags: 0x1 linked
// namespace_c8814633<file_0>::function_44782a56
// Checksum 0xa5dcaad, Offset: 0x780
// Size: 0x48
function function_44782a56(eventname) {
    self endon(#"hash_2bbc4f84");
    while (true) {
        self waittill(eventname);
        self thread function_5b52d0d9(eventname);
    }
}

// Namespace namespace_c8814633
// Params 1, eflags: 0x1 linked
// namespace_c8814633<file_0>::function_6a7aa4bf
// Checksum 0x4b18709b, Offset: 0x7d0
// Size: 0x58
function function_6a7aa4bf(eventname) {
    self endon(#"hash_2bbc4f84");
    while (true) {
        arg1 = self waittill(eventname);
        self thread function_5b52d0d9(eventname, arg1);
    }
}

// Namespace namespace_c8814633
// Params 1, eflags: 0x1 linked
// namespace_c8814633<file_0>::function_f8733584
// Checksum 0x3ad7200b, Offset: 0x830
// Size: 0x68
function function_f8733584(eventname) {
    self endon(#"hash_2bbc4f84");
    while (true) {
        arg1, arg2 = self waittill(eventname);
        self thread function_5b52d0d9(eventname, arg1, arg2);
    }
}

// Namespace namespace_c8814633
// Params 0, eflags: 0x1 linked
// namespace_c8814633<file_0>::function_551bd4f3
// Checksum 0xfb7e1ed0, Offset: 0x8a0
// Size: 0x5c
function function_551bd4f3() {
    self endon(#"hash_94ff6d85");
    arg1, arg2 = self waittill(#"death");
    self thread function_5b52d0d9("death", arg1, arg2);
}

// Namespace namespace_c8814633
// Params 1, eflags: 0x1 linked
// namespace_c8814633<file_0>::function_1e75afed
// Checksum 0xe6778b0e, Offset: 0x908
// Size: 0x78
function function_1e75afed(eventname) {
    self endon(#"hash_2bbc4f84");
    while (true) {
        arg1, arg2, arg3 = self waittill(eventname);
        self thread function_5b52d0d9(eventname, arg1, arg2, arg3);
    }
}

// Namespace namespace_c8814633
// Params 4, eflags: 0x5 linked
// namespace_c8814633<file_0>::function_5b52d0d9
// Checksum 0x56171fa8, Offset: 0x988
// Size: 0x2c6
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
            args = "stealth_sight_end";
            if (isdefined(arg1)) {
                args = "stealth_sight_end" + namespace_e449108e::debug_text(arg1) + args;
            }
            self thread namespace_e449108e::function_1c1f41ef(eventname + "stealth_sight_end" + args + "stealth_sight_end", (0.75, 0.75, 0.75), 1, 0.5, self.origin + (0, 0, 30), 3);
        }
    #/
    self.stealth.event.package.name = eventname;
    self.stealth.event.package.parms[0] = arg1;
    self.stealth.event.package.parms[1] = arg2;
    self.stealth.event.package.parms[2] = arg3;
    self [[ level.stealth.eventhandler[eventname] ]](self.stealth.event.package);
}

// Namespace namespace_c8814633
// Params 1, eflags: 0x1 linked
// namespace_c8814633<file_0>::function_26f273e1
// Checksum 0xa19e0de5, Offset: 0xc58
// Size: 0x134
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
// Params 11, eflags: 0x1 linked
// namespace_c8814633<file_0>::function_7dd521be
// Checksum 0x393acedc, Offset: 0xd98
// Size: 0x26a
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

