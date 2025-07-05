#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_util;

#namespace shellshock;

// Namespace shellshock
// Params 0, eflags: 0x2
// Checksum 0x4a66fd99, Offset: 0x190
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("shellshock", &__init__, undefined, undefined);
}

// Namespace shellshock
// Params 0, eflags: 0x0
// Checksum 0x678fd677, Offset: 0x1d0
// Size: 0x3c
function __init__() {
    callback::on_start_gametype(&main);
    level.shellshockonplayerdamage = &on_damage;
}

// Namespace shellshock
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x218
// Size: 0x4
function main() {
    
}

// Namespace shellshock
// Params 3, eflags: 0x0
// Checksum 0x11e3d09b, Offset: 0x228
// Size: 0x12c
function on_damage(cause, damage, weapon) {
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
// Checksum 0xc743ebef, Offset: 0x360
// Size: 0x1e
function endondeath() {
    self waittill(#"death");
    waittillframeend();
    self notify(#"end_explode");
}

// Namespace shellshock
// Params 1, eflags: 0x0
// Checksum 0xd63b1c15, Offset: 0x388
// Size: 0x2a
function endontimer(timer) {
    self endon(#"disconnect");
    wait timer;
    self notify(#"end_on_timer");
}

// Namespace shellshock
// Params 1, eflags: 0x0
// Checksum 0x3982c13d, Offset: 0x3c0
// Size: 0x5c
function rcbomb_earthquake(position) {
    playrumbleonposition("grenade_rumble", position);
    earthquake(0.5, 0.5, self.origin, 512);
}

