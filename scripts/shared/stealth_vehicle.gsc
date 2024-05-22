#using scripts/shared/ai_shared;
#using scripts/shared/stealth_tagging;
#using scripts/shared/stealth_status;
#using scripts/shared/stealth_event;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth_debug;
#using scripts/shared/stealth;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;

#namespace namespace_594759f3;

// Namespace namespace_594759f3
// Params 0, eflags: 0x0
// Checksum 0xabcf8c95, Offset: 0x1e8
// Size: 0x124
function init() {
    /#
        assert(isvehicle(self));
    #/
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
    self namespace_8312dbf::init();
    self namespace_80045451::init();
    self namespace_c8814633::init();
    self.awarenesslevelcurrent = "unaware";
    self.awarenesslevelprevious = "unaware";
    self thread function_1664d989();
    /#
        self namespace_e449108e::init_debug();
    #/
}

// Namespace namespace_594759f3
// Params 0, eflags: 0x0
// Checksum 0x11f14a1b, Offset: 0x318
// Size: 0x104
function stop() {
    if (self namespace_80045451::enabled()) {
        self namespace_80045451::function_a2429809("combat");
        self.stealth.investigating = undefined;
        foreach (player in level.activeplayers) {
            self setignoreent(player, 0);
        }
        self namespace_8312dbf::function_180adb28();
        self ai::set_ignoreall(0);
    }
}

// Namespace namespace_594759f3
// Params 0, eflags: 0x0
// Checksum 0xbb275ef2, Offset: 0x428
// Size: 0x3c
function reset() {
    if (self namespace_80045451::enabled()) {
        self namespace_80045451::function_a2429809("unaware");
    }
}

// Namespace namespace_594759f3
// Params 0, eflags: 0x0
// Checksum 0x65e7237f, Offset: 0x470
// Size: 0x20
function enabled() {
    return isdefined(self.stealth) && isdefined(self.stealth.var_164876a9);
}

// Namespace namespace_594759f3
// Params 0, eflags: 0x0
// Checksum 0xb1ea3cdb, Offset: 0x498
// Size: 0x8c
function function_1664d989() {
    self endon(#"death");
    self endon(#"hash_94ff6d85");
    self thread function_6fceb02e(-6);
    self thread function_c5738439();
    self util::waittill_any("damage", "wake_all");
    self wake_up();
}

// Namespace namespace_594759f3
// Params 0, eflags: 0x0
// Checksum 0x5c3e04a7, Offset: 0x530
// Size: 0xc6
function function_c5738439() {
    self endon(#"death");
    self endon(#"hash_94ff6d85");
    self ai::set_ignoreall(1);
    while (true) {
        weapon = undefined;
        weapon, attacker = self waittill(#"hash_f8c5dd60");
        if (isdefined(weapon)) {
            switch (weapon.name) {
            case 4:
            case 5:
                self wake_up();
                break;
            default:
                break;
            }
        }
    }
}

// Namespace namespace_594759f3
// Params 1, eflags: 0x0
// Checksum 0x4ad2a667, Offset: 0x600
// Size: 0x158
function function_6fceb02e(radius) {
    self notify(#"hash_6fceb02e");
    self endon(#"hash_6fceb02e");
    self endon(#"death");
    self endon(#"hash_94ff6d85");
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
        wait(randomfloatrange(0.5, 1));
    }
}

// Namespace namespace_594759f3
// Params 0, eflags: 0x0
// Checksum 0xc80dc4a9, Offset: 0x760
// Size: 0x32
function wake_up() {
    self ai::set_ignoreall(0);
    self notify(#"alert", "combat");
}

