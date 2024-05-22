#using scripts/mp/_util;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace shellshock;

// Namespace shellshock
// Params 0, eflags: 0x2
// Checksum 0x6b716a28, Offset: 0x1d0
// Size: 0x34
function function_2dc19561() {
    system::register("shellshock", &__init__, undefined, undefined);
}

// Namespace shellshock
// Params 0, eflags: 0x1 linked
// Checksum 0x4c9508ad, Offset: 0x210
// Size: 0x3c
function __init__() {
    callback::on_start_gametype(&init);
    level.shellshockonplayerdamage = &on_damage;
}

// Namespace shellshock
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x258
// Size: 0x4
function init() {
    
}

// Namespace shellshock
// Params 3, eflags: 0x1 linked
// Checksum 0x68b3c5a9, Offset: 0x268
// Size: 0x1ac
function on_damage(cause, damage, weapon) {
    if (self util::isflashbanged()) {
        return;
    }
    if (self.health <= 0) {
        self clientfield::set_to_player("sndMelee", 0);
    }
    if (cause == "MOD_EXPLOSIVE" || cause == "MOD_GRENADE" || cause == "MOD_GRENADE_SPLASH" || cause == "MOD_PROJECTILE" || cause == "MOD_PROJECTILE_SPLASH") {
        if (weapon.explosionradius == 0) {
            return;
        }
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
// Checksum 0x2ef22436, Offset: 0x420
// Size: 0x1e
function end_on_death() {
    self waittill(#"death");
    waittillframeend();
    self notify(#"end_explode");
}

// Namespace shellshock
// Params 1, eflags: 0x0
// Checksum 0xb8035dc8, Offset: 0x448
// Size: 0x2a
function end_on_timer(timer) {
    self endon(#"disconnect");
    wait(timer);
    self notify(#"end_on_timer");
}

// Namespace shellshock
// Params 1, eflags: 0x1 linked
// Checksum 0x18d4f868, Offset: 0x480
// Size: 0x5c
function rcbomb_earthquake(position) {
    playrumbleonposition("grenade_rumble", position);
    earthquake(0.5, 0.5, self.origin, 512);
}

// Namespace shellshock
// Params 0, eflags: 0x0
// Checksum 0x98f6327f, Offset: 0x4e8
// Size: 0x42
function reset_meleesnd() {
    self endon(#"death");
    wait(6);
    self clientfield::set_to_player("sndMelee", 0);
    self notify(#"snd_melee_end");
}

