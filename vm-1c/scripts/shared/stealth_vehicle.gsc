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
// Params 0, eflags: 0x1 linked
// Checksum 0xabcf8c95, Offset: 0x1e8
// Size: 0x124
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
// Params 0, eflags: 0x1 linked
// Checksum 0x11f14a1b, Offset: 0x318
// Size: 0x104
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
// Params 0, eflags: 0x1 linked
// Checksum 0xbb275ef2, Offset: 0x428
// Size: 0x3c
function reset() {
    if (self stealth_aware::enabled()) {
        self stealth_aware::function_a2429809("unaware");
    }
}

// Namespace stealth_vehicle
// Params 0, eflags: 0x0
// Checksum 0x65e7237f, Offset: 0x470
// Size: 0x20
function enabled() {
    return isdefined(self.stealth) && isdefined(self.stealth.var_164876a9);
}

// Namespace stealth_vehicle
// Params 0, eflags: 0x1 linked
// Checksum 0xb1ea3cdb, Offset: 0x498
// Size: 0x8c
function function_1664d989() {
    self endon(#"death");
    self endon(#"stop_stealth");
    self thread function_6fceb02e(-6);
    self thread function_c5738439();
    self util::waittill_any("damage", "wake_all");
    self wake_up();
}

// Namespace stealth_vehicle
// Params 0, eflags: 0x1 linked
// Checksum 0x5c3e04a7, Offset: 0x530
// Size: 0xc6
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
// Params 1, eflags: 0x1 linked
// Checksum 0x4ad2a667, Offset: 0x600
// Size: 0x158
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
// Params 0, eflags: 0x1 linked
// Checksum 0xc80dc4a9, Offset: 0x760
// Size: 0x32
function wake_up() {
    self ai::set_ignoreall(0);
    self notify(#"alert", "combat");
}

