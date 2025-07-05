#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace shellshock;

// Namespace shellshock
// Params 0, eflags: 0x2
// Checksum 0xbf3648df, Offset: 0x1d0
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("shellshock", &__init__, undefined, undefined);
}

// Namespace shellshock
// Params 0, eflags: 0x0
// Checksum 0x61af7314, Offset: 0x208
// Size: 0x3a
function __init__() {
    callback::on_start_gametype(&init);
    level.shellshockonplayerdamage = &on_damage;
}

// Namespace shellshock
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x250
// Size: 0x2
function init() {
    
}

// Namespace shellshock
// Params 3, eflags: 0x0
// Checksum 0xfb45d047, Offset: 0x260
// Size: 0x122
function on_damage(cause, damage, weapon) {
    if (self util::isflashbanged()) {
        return;
    }
    if (self.health <= 0) {
        self clientfield::set_to_player("sndMelee", 0);
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
            if (self util::mayapplyscreeneffect() && self hasperk("specialty_flakjacket") == 0) {
                self shellshock("frag_grenade_mp", 0.5);
            }
        }
    }
}

// Namespace shellshock
// Params 0, eflags: 0x0
// Checksum 0x73d1b239, Offset: 0x390
// Size: 0x17
function end_on_death() {
    self waittill(#"death");
    waittillframeend();
    self notify(#"end_explode");
}

// Namespace shellshock
// Params 1, eflags: 0x0
// Checksum 0x72aca590, Offset: 0x3b0
// Size: 0x1f
function end_on_timer(timer) {
    self endon(#"disconnect");
    wait timer;
    self notify(#"end_on_timer");
}

// Namespace shellshock
// Params 1, eflags: 0x0
// Checksum 0xb3cb8218, Offset: 0x3d8
// Size: 0x4a
function rcbomb_earthquake(position) {
    playrumbleonposition("grenade_rumble", position);
    earthquake(0.5, 0.5, self.origin, 512);
}

// Namespace shellshock
// Params 0, eflags: 0x0
// Checksum 0xf3a0b7eb, Offset: 0x430
// Size: 0x2b
function reset_meleesnd() {
    self endon(#"death");
    wait 6;
    self clientfield::set_to_player("sndMelee", 0);
    self notify(#"snd_melee_end");
}

