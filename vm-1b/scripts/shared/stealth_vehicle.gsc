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
// namespace_594759f3<file_0>::function_c35e6aab
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
// namespace_594759f3<file_0>::function_fcf56ab5
// Checksum 0x4eca2943, Offset: 0x2e8
// Size: 0xba
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
// namespace_594759f3<file_0>::function_11424fa
// Checksum 0x2d2a0b65, Offset: 0x3b0
// Size: 0x2a
function reset() {
    if (self namespace_80045451::enabled()) {
        self namespace_80045451::function_a2429809("unaware");
    }
}

// Namespace namespace_594759f3
// Params 0, eflags: 0x0
// namespace_594759f3<file_0>::function_b55533bc
// Checksum 0x14bbb7f4, Offset: 0x3e8
// Size: 0x1e
function enabled() {
    return isdefined(self.stealth) && isdefined(self.stealth.var_164876a9);
}

// Namespace namespace_594759f3
// Params 0, eflags: 0x0
// namespace_594759f3<file_0>::function_1664d989
// Checksum 0x1a064429, Offset: 0x410
// Size: 0x62
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
// namespace_594759f3<file_0>::function_c5738439
// Checksum 0x7f81cdb6, Offset: 0x480
// Size: 0x9d
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
// namespace_594759f3<file_0>::function_6fceb02e
// Checksum 0x9d5b881f, Offset: 0x528
// Size: 0x105
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
// namespace_594759f3<file_0>::function_cccbd0f7
// Checksum 0x817cd1e0, Offset: 0x638
// Size: 0x23
function wake_up() {
    self ai::set_ignoreall(0);
    self notify(#"alert", "combat");
}

