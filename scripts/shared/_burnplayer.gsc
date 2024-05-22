#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/codescripts/struct;

#namespace burnplayer;

// Namespace burnplayer
// Params 0, eflags: 0x2
// Checksum 0xfddb2fcd, Offset: 0x190
// Size: 0x34
function function_2dc19561() {
    system::register("burnplayer", &__init__, undefined, undefined);
}

// Namespace burnplayer
// Params 0, eflags: 0x1 linked
// Checksum 0x6b2ed257, Offset: 0x1d0
// Size: 0x64
function __init__() {
    clientfield::register("allplayers", "burn", 1, 1, "int");
    clientfield::register("playercorpse", "burned_effect", 1, 1, "int");
}

// Namespace burnplayer
// Params 5, eflags: 0x1 linked
// Checksum 0x580dcdd8, Offset: 0x240
// Size: 0xdc
function setplayerburning(duration, interval, damageperinterval, attacker, weapon) {
    self clientfield::set("burn", 1);
    self thread watchburntimer(duration);
    self thread watchburndamage(interval, damageperinterval, attacker, weapon);
    self thread watchforwater();
    self thread watchburnfinished();
    self playloopsound("chr_burn_loop_overlay");
}

// Namespace burnplayer
// Params 3, eflags: 0x1 linked
// Checksum 0x2a0c6c92, Offset: 0x328
// Size: 0xac
function takingburndamage(eattacker, weapon, smeansofdeath) {
    if (isdefined(self.doing_scripted_burn_damage)) {
        self.doing_scripted_burn_damage = undefined;
        return;
    }
    if (weapon == level.weaponnone) {
        return;
    }
    if (weapon.burnduration == 0) {
        return;
    }
    self setplayerburning(weapon.burnduration / 1000, weapon.burndamageinterval / 1000, weapon.burndamage, eattacker, weapon);
}

// Namespace burnplayer
// Params 0, eflags: 0x1 linked
// Checksum 0xa5df9b0b, Offset: 0x3e0
// Size: 0x6c
function watchburnfinished() {
    self endon(#"disconnect");
    self util::waittill_any("death", "burn_finished");
    self clientfield::set("burn", 0);
    self stoploopsound(1);
}

// Namespace burnplayer
// Params 1, eflags: 0x1 linked
// Checksum 0x911e5abe, Offset: 0x458
// Size: 0x52
function watchburntimer(duration) {
    self notify(#"burnplayer_watchburntimer");
    self endon(#"burnplayer_watchburntimer");
    self endon(#"disconnect");
    self endon(#"death");
    wait(duration);
    self notify(#"burn_finished");
}

// Namespace burnplayer
// Params 4, eflags: 0x1 linked
// Checksum 0xbeac297d, Offset: 0x4b8
// Size: 0xc2
function watchburndamage(interval, damage, attacker, weapon) {
    if (damage == 0) {
        return;
    }
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"burnplayer_watchburntimer");
    self endon(#"burn_finished");
    while (true) {
        wait(interval);
        self.doing_scripted_burn_damage = 1;
        self dodamage(damage, self.origin, attacker, undefined, undefined, "MOD_BURNED", 0, weapon);
        self.doing_scripted_burn_damage = undefined;
    }
}

// Namespace burnplayer
// Params 0, eflags: 0x1 linked
// Checksum 0x46395752, Offset: 0x588
// Size: 0x60
function watchforwater() {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"burn_finished");
    while (true) {
        if (self isplayerunderwater()) {
            self notify(#"burn_finished");
        }
        wait(0.05);
    }
}

