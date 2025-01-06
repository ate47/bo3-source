#using scripts/shared/stealth;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth_behavior;
#using scripts/shared/stealth_debug;
#using scripts/shared/stealth_vo;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace stealth_event;

// Namespace stealth_event
// Params 0, eflags: 0x0
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

// Namespace stealth_event
// Params 0, eflags: 0x0
// Checksum 0x969143a, Offset: 0x2f0
// Size: 0x20
function enabled() {
    return isdefined(self.stealth) && isdefined(self.stealth.event);
}

// Namespace stealth_event
// Params 0, eflags: 0x0
// Checksum 0x9adab0ab, Offset: 0x318
// Size: 0x274
function function_78e2e218() {
    self register_handler("alert", &stealth_aware::function_6c10e440, 3);
    if (isactor(self)) {
        self register_handler("pain", &function_26f273e1, 2);
        self register_handler("death", &function_26f273e1, 2);
        self register_handler("damage", &function_26f273e1, 2);
        self register_handler("combat_spread", &stealth_aware::function_101ac5, 1);
        self register_handler("combat_interest", &stealth_aware::function_933965f6, 2);
        self register_handler("stealth_sight_start", &stealth_aware::function_ca6a0809, 1);
        self register_handler("stealth_sight_max", &stealth_aware::function_617b90af, 1);
        self register_handler("stealth_sight_end", &stealth_aware::on_sight_end, 1);
        self register_handler("witness_combat", &stealth_aware::function_a7964595, 2);
        self register_handler("investigate", &stealth_behavior::function_de77b9e6, 3);
        self register_handler("stealth_vo", &stealth_vo::function_2756e5d4, 1);
    }
    self thread function_b349369d();
}

// Namespace stealth_event
// Params 0, eflags: 0x0
// Checksum 0x20a6caa, Offset: 0x598
// Size: 0x3a
function function_b349369d() {
    self util::waittill_any("stop_stealth", "death");
    self notify(#"hash_2bbc4f84");
}

// Namespace stealth_event
// Params 3, eflags: 0x0
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
            iprintlnbold("<dev string:x28>" + var_8a0dd434);
        #/
        break;
    }
}

// Namespace stealth_event
// Params 1, eflags: 0x0
// Checksum 0xa5dcaad, Offset: 0x780
// Size: 0x48
function function_44782a56(eventname) {
    self endon(#"hash_2bbc4f84");
    while (true) {
        self waittill(eventname);
        self thread function_5b52d0d9(eventname);
    }
}

// Namespace stealth_event
// Params 1, eflags: 0x0
// Checksum 0x4b18709b, Offset: 0x7d0
// Size: 0x58
function function_6a7aa4bf(eventname) {
    self endon(#"hash_2bbc4f84");
    while (true) {
        self waittill(eventname, arg1);
        self thread function_5b52d0d9(eventname, arg1);
    }
}

// Namespace stealth_event
// Params 1, eflags: 0x0
// Checksum 0x3ad7200b, Offset: 0x830
// Size: 0x68
function function_f8733584(eventname) {
    self endon(#"hash_2bbc4f84");
    while (true) {
        self waittill(eventname, arg1, arg2);
        self thread function_5b52d0d9(eventname, arg1, arg2);
    }
}

// Namespace stealth_event
// Params 0, eflags: 0x0
// Checksum 0xfb7e1ed0, Offset: 0x8a0
// Size: 0x5c
function function_551bd4f3() {
    self endon(#"stop_stealth");
    self waittill(#"death", arg1, arg2);
    self thread function_5b52d0d9("death", arg1, arg2);
}

// Namespace stealth_event
// Params 1, eflags: 0x0
// Checksum 0xe6778b0e, Offset: 0x908
// Size: 0x78
function function_1e75afed(eventname) {
    self endon(#"hash_2bbc4f84");
    while (true) {
        self waittill(eventname, arg1, arg2, arg3);
        self thread function_5b52d0d9(eventname, arg1, arg2, arg3);
    }
}

// Namespace stealth_event
// Params 4, eflags: 0x4
// Checksum 0x56171fa8, Offset: 0x988
// Size: 0x2c6
function private function_5b52d0d9(eventname, arg1, arg2, arg3) {
    self endon(#"stop_stealth");
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
        if (stealth_debug::enabled() && isdefined(self) && isentity(self)) {
            args = "<dev string:x5f>";
            if (isdefined(arg1)) {
                args = "<dev string:x60>" + stealth_debug::debug_text(arg1) + args;
            }
            self thread stealth_debug::function_1c1f41ef(eventname + "<dev string:x62>" + args + "<dev string:x65>", (0.75, 0.75, 0.75), 1, 0.5, self.origin + (0, 0, 30), 3);
        }
    #/
    self.stealth.event.package.name = eventname;
    self.stealth.event.package.parms[0] = arg1;
    self.stealth.event.package.parms[1] = arg2;
    self.stealth.event.package.parms[2] = arg3;
    self [[ level.stealth.eventhandler[eventname] ]](self.stealth.event.package);
}

// Namespace stealth_event
// Params 1, eflags: 0x0
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
    wait 0.05;
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

// Namespace stealth_event
// Params 11, eflags: 0x0
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
            if (agent stealth_aware::enabled() && agent stealth_aware::function_739525d() == "combat") {
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

