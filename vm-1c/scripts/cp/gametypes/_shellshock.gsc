#using scripts/cp/_util;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace shellshock;

// Namespace shellshock
// Params 0, eflags: 0x2
// namespace_f1aa5a21<file_0>::function_2dc19561
// Checksum 0x31daab32, Offset: 0x190
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("shellshock", &__init__, undefined, undefined);
}

// Namespace shellshock
// Params 0, eflags: 0x1 linked
// namespace_f1aa5a21<file_0>::function_8c87d8eb
// Checksum 0x44806851, Offset: 0x1d0
// Size: 0x3c
function __init__() {
    callback::on_start_gametype(&init);
    level.shellshockonplayerdamage = &on_damage;
}

// Namespace shellshock
// Params 0, eflags: 0x1 linked
// namespace_f1aa5a21<file_0>::function_c35e6aab
// Checksum 0x99ec1590, Offset: 0x218
// Size: 0x4
function init() {
    
}

// Namespace shellshock
// Params 3, eflags: 0x1 linked
// namespace_f1aa5a21<file_0>::function_1a61261a
// Checksum 0x7758cc1a, Offset: 0x228
// Size: 0x14c
function on_damage(cause, damage, weapon) {
    if (self util::isflashbanged()) {
        return;
    }
    if (cause == "MOD_EXPLOSIVE" || cause == "MOD_GRENADE" || cause == "MOD_GRENADE_SPLASH" || cause == "MOD_PROJECTILE" || cause == "MOD_PROJECTILE_SPLASH") {
        time = 0;
        if (damage >= 90) {
            time = 4;
        } else if (damage >= 50) {
            time = 3;
        } else if (damage >= 25) {
            time = 2;
        } else if (damage > 10) {
            time = 2;
        }
        if (time) {
            if (self util::mayapplyscreeneffect()) {
                self shellshock("frag_grenade_mp", 0.5);
            }
        }
    }
}

// Namespace shellshock
// Params 0, eflags: 0x0
// namespace_f1aa5a21<file_0>::function_b1fe3c1b
// Checksum 0xab408df5, Offset: 0x380
// Size: 0x1e
function end_on_death() {
    self waittill(#"death");
    waittillframeend();
    self notify(#"end_explode");
}

// Namespace shellshock
// Params 1, eflags: 0x0
// namespace_f1aa5a21<file_0>::function_fea9fb9a
// Checksum 0xe8a7543, Offset: 0x3a8
// Size: 0x2a
function end_on_timer(timer) {
    self endon(#"disconnect");
    wait(timer);
    self notify(#"end_on_timer");
}

// Namespace shellshock
// Params 1, eflags: 0x0
// namespace_f1aa5a21<file_0>::function_d06cf10c
// Checksum 0xf19021, Offset: 0x3e0
// Size: 0x5c
function rcbomb_earthquake(position) {
    playrumbleonposition("grenade_rumble", position);
    earthquake(0.5, 0.5, self.origin, 512);
}

