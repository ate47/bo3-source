#using scripts/shared/ai_shared;
#using scripts/shared/stealth_tagging;
#using scripts/shared/stealth_status;
#using scripts/shared/stealth_event;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth_debug;
#using scripts/shared/stealth;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;

#namespace stealth_vehicle;

// Namespace stealth_vehicle
// Params 0, eflags: 0x0
// Checksum 0xfaa92d0e, Offset: 0x1e8
// Size: 0xf2
function init() {
    assert(isvehicle(self));
    if (!(isdefined(self.script_stealth) && self.script_stealth)) {
        return;
    }
    if (isdefined(self.stealth)) {
        return;
    }
    if (!isdefined(self.stealth)) {
        self.stealth = spawnstruct();
    }
    self.stealth.var_164876a9 = 1;
    self stealth_status::init();
    self stealth_aware::init();
    self stealth_event::init();
    self.awarenesslevelcurrent = "unaware";
    self.awarenesslevelprevious = "unaware";
    self thread function_1664d989();
    /#
        self stealth_debug::init_debug();
    #/
}

// Namespace stealth_vehicle
// Params 0, eflags: 0x0
// Checksum 0x4eca2943, Offset: 0x2e8
// Size: 0xba
function stop() {
    if (self stealth_aware::enabled()) {
        self stealth_aware::function_a2429809("combat");
        self.stealth.investigating = undefined;
        foreach (player in level.activeplayers) {
            self setignoreent(player, 0);
        }
        self stealth_status::function_180adb28();
        self ai::set_ignoreall(0);
    }
}

// Namespace stealth_vehicle
// Params 0, eflags: 0x0
// Checksum 0x2d2a0b65, Offset: 0x3b0
// Size: 0x2a
function reset() {
    if (self stealth_aware::enabled()) {
        self stealth_aware::function_a2429809("unaware");
    }
}

// Namespace stealth_vehicle
// Params 0, eflags: 0x0
// Checksum 0x14bbb7f4, Offset: 0x3e8
// Size: 0x1e
function enabled() {
    return isdefined(self.stealth) && isdefined(self.stealth.var_164876a9);
}

// Namespace stealth_vehicle
// Params 0, eflags: 0x0
// Checksum 0x1a064429, Offset: 0x410
// Size: 0x62
function function_1664d989() {
    self endon(#"death");
    self endon(#"stop_stealth");
    self thread function_6fceb02e(-6);
    self thread function_c5738439();
    self util::waittill_any("damage", "wake_all");
    self wake_up();
}

// Namespace stealth_vehicle
// Params 0, eflags: 0x0
// Checksum 0x7f81cdb6, Offset: 0x480
// Size: 0x9d
function function_c5738439() {
    self endon(#"death");
    self endon(#"stop_stealth");
    self ai::set_ignoreall(1);
    while (true) {
        weapon = undefined;
        weapon, attacker = self waittill(#"cybercom_action");
        if (isdefined(weapon)) {
            switch (weapon.name) {
            case "gadget_iff_override":
            case "gadget_iff_override_upgraded":
                self wake_up();
                break;
            default:
                break;
            }
        }
    }
}

// Namespace stealth_vehicle
// Params 1, eflags: 0x0
// Checksum 0x9d5b881f, Offset: 0x528
// Size: 0x105
function function_6fceb02e(radius) {
    self notify(#"hash_6fceb02e");
    self endon(#"hash_6fceb02e");
    self endon(#"death");
    self endon(#"stop_stealth");
    radiussq = radius * radius;
    while (true) {
        foreach (player in level.activeplayers) {
            if (!isalive(player)) {
                continue;
            }
            if (distancesquared(player.origin, self.origin) <= radiussq) {
                self wake_up();
            }
        }
        wait randomfloatrange(0.5, 1);
    }
}

// Namespace stealth_vehicle
// Params 0, eflags: 0x0
// Checksum 0x817cd1e0, Offset: 0x638
// Size: 0x23
function wake_up() {
    self ai::set_ignoreall(0);
    self notify(#"alert", "combat");
}

