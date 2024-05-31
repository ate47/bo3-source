#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_gadgets;
#using scripts/shared/system_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace ability_power;

// Namespace ability_power
// Params 0, eflags: 0x2
// namespace_fcced877<file_0>::function_2dc19561
// Checksum 0x46d4b0bd, Offset: 0x288
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("ability_power", &__init__, undefined, undefined);
}

// Namespace ability_power
// Params 0, eflags: 0x1 linked
// namespace_fcced877<file_0>::function_8c87d8eb
// Checksum 0xcb703d1d, Offset: 0x2c8
// Size: 0x24
function __init__() {
    callback::on_connect(&on_player_connect);
}

/#

    // Namespace ability_power
    // Params 2, eflags: 0x1 linked
    // namespace_fcced877<file_0>::function_13b0d3c3
    // Checksum 0x8576c243, Offset: 0x2f8
    // Size: 0x10c
    function cpower_print(slot, str) {
        color = "killed actor";
        toprint = color + "killed actor" + str;
        weaponname = "killed actor";
        if (isdefined(self._gadgets_player[slot])) {
            weaponname = self._gadgets_player[slot].name;
        }
        if (getdvarint("killed actor") > 0) {
            self iprintlnbold(toprint);
            return;
        }
        println(self.playername + "killed actor" + weaponname + "killed actor" + toprint);
    }

#/

// Namespace ability_power
// Params 0, eflags: 0x1 linked
// namespace_fcced877<file_0>::function_fb4f96b5
// Checksum 0x99ec1590, Offset: 0x410
// Size: 0x4
function on_player_connect() {
    
}

// Namespace ability_power
// Params 1, eflags: 0x1 linked
// namespace_fcced877<file_0>::function_4bebd1c5
// Checksum 0xfa7262e4, Offset: 0x420
// Size: 0x1e
function power_is_hero_ability(gadget) {
    return gadget.gadget_type != 0;
}

// Namespace ability_power
// Params 2, eflags: 0x1 linked
// namespace_fcced877<file_0>::function_cf8b1e89
// Checksum 0x80a20107, Offset: 0x448
// Size: 0x68
function is_weapon_or_variant_same_as_gadget(weapon, gadget) {
    if (weapon == gadget) {
        return true;
    }
    if (isdefined(level.weaponlightninggun) && gadget == level.weaponlightninggun) {
        if (isdefined(level.weaponlightninggunarc) && weapon == level.weaponlightninggunarc) {
            return true;
        }
    }
    return false;
}

// Namespace ability_power
// Params 4, eflags: 0x1 linked
// namespace_fcced877<file_0>::function_89e84a38
// Checksum 0xdced7892, Offset: 0x4b8
// Size: 0x24e
function power_gain_event_score(eattacker, score, weapon, var_ce8a30c7) {
    if (score > 0) {
        for (slot = 0; slot < 3; slot++) {
            gadget = self._gadgets_player[slot];
            if (isdefined(gadget)) {
                ignoreself = gadget.gadget_powergainscoreignoreself;
                if (isdefined(weapon) && ignoreself && is_weapon_or_variant_same_as_gadget(weapon, gadget)) {
                    continue;
                }
                ignorewhenactive = gadget.gadget_powergainscoreignorewhenactive;
                if (ignorewhenactive && self gadgetisactive(slot)) {
                    continue;
                }
                if (isdefined(var_ce8a30c7) && var_ce8a30c7 && power_is_hero_ability(gadget)) {
                    continue;
                }
                scorefactor = gadget.gadget_powergainscorefactor;
                if (isdefined(self.gadgetthiefactive) && self.gadgetthiefactive == 1) {
                    continue;
                }
                gametypefactor = getgametypesetting("scoreHeroPowerGainFactor");
                perkfactor = 1;
                if (self hasperk("specialty_overcharge")) {
                    perkfactor = getdvarfloat("gadgetPowerOverchargePerkScoreFactor");
                }
                if (scorefactor > 0 && gametypefactor > 0) {
                    gaintoadd = score * scorefactor * gametypefactor * perkfactor;
                    self power_gain_event(slot, eattacker, gaintoadd, "score");
                }
            }
        }
    }
}

// Namespace ability_power
// Params 1, eflags: 0x0
// namespace_fcced877<file_0>::function_393d0e93
// Checksum 0xcaca1b14, Offset: 0x710
// Size: 0x8e
function power_gain_event_damage_actor(eattacker) {
    basegain = 0;
    if (basegain > 0) {
        for (slot = 0; slot < 3; slot++) {
            if (isdefined(self._gadgets_player[slot])) {
                self power_gain_event(slot, eattacker, basegain, "damaged actor");
            }
        }
    }
}

// Namespace ability_power
// Params 2, eflags: 0x0
// namespace_fcced877<file_0>::function_f20e7ecb
// Checksum 0x3ededdce, Offset: 0x7a8
// Size: 0x186
function power_gain_event_killed_actor(eattacker, meansofdeath) {
    basegain = 5;
    for (slot = 0; slot < 3; slot++) {
        if (isdefined(self._gadgets_player[slot])) {
            if (meansofdeath == "MOD_MELEE_ASSASSINATE" && self ability_util::function_7bf047db()) {
                if (self._gadgets_player[slot].gadget_powertakedowngain > 0) {
                    source = "assassinate actor";
                    self power_gain_event(slot, eattacker, self._gadgets_player[slot].gadget_powertakedowngain, source);
                }
            }
            if (self._gadgets_player[slot].gadget_powerreplenishfactor > 0) {
                gaintoadd = basegain * self._gadgets_player[slot].gadget_powerreplenishfactor;
                if (gaintoadd > 0) {
                    source = "killed actor";
                    self power_gain_event(slot, eattacker, gaintoadd, source);
                }
            }
        }
    }
}

// Namespace ability_power
// Params 4, eflags: 0x1 linked
// namespace_fcced877<file_0>::function_b2849c8b
// Checksum 0x637b828a, Offset: 0x938
// Size: 0xf4
function power_gain_event(slot, eattacker, val, source) {
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    powertoadd = val;
    if (powertoadd > 0.1 || powertoadd < -0.1) {
        powerleft = self gadgetpowerchange(slot, powertoadd);
        /#
            self cpower_print(slot, "killed actor" + powertoadd + "killed actor" + source + "killed actor" + powerleft);
        #/
    }
}

// Namespace ability_power
// Params 5, eflags: 0x1 linked
// namespace_fcced877<file_0>::function_4111b469
// Checksum 0xef257ace, Offset: 0xa38
// Size: 0x196
function power_loss_event_took_damage(eattacker, einflictor, weapon, smeansofdeath, idamage) {
    baseloss = idamage;
    for (slot = 0; slot < 3; slot++) {
        if (isdefined(self._gadgets_player[slot])) {
            if (self gadgetisactive(slot)) {
                powerloss = baseloss * self._gadgets_player[slot].gadget_poweronlossondamage;
                if (powerloss > 0) {
                    self power_loss_event(slot, eattacker, powerloss, "took damage with power on");
                }
                if (self._gadgets_player[slot].gadget_flickerondamage > 0) {
                    self ability_gadgets::setflickering(slot, self._gadgets_player[slot].gadget_flickerondamage);
                }
                continue;
            }
            powerloss = baseloss * self._gadgets_player[slot].gadget_powerofflossondamage;
            if (powerloss > 0) {
                self power_loss_event(slot, eattacker, powerloss, "took damage");
            }
        }
    }
}

// Namespace ability_power
// Params 4, eflags: 0x1 linked
// namespace_fcced877<file_0>::function_e121567f
// Checksum 0xa4806b6f, Offset: 0xbd8
// Size: 0xd4
function power_loss_event(slot, eattacker, val, source) {
    powertoremove = val * -1;
    if (powertoremove > 0.1 || powertoremove < -0.1) {
        powerleft = self gadgetpowerchange(slot, powertoremove);
        /#
            self cpower_print(slot, "killed actor" + powertoremove + "killed actor" + source + "killed actor" + powerleft);
        #/
    }
}

// Namespace ability_power
// Params 1, eflags: 0x0
// namespace_fcced877<file_0>::function_7b5970fe
// Checksum 0x3fb9a5d0, Offset: 0xcb8
// Size: 0x58
function power_drain_completely(slot) {
    powerleft = self gadgetpowerchange(slot, 0);
    powerleft = self gadgetpowerchange(slot, powerleft * -1);
}

// Namespace ability_power
// Params 0, eflags: 0x1 linked
// namespace_fcced877<file_0>::function_c51dbe03
// Checksum 0xa06fe933, Offset: 0xd18
// Size: 0x6e
function ismovingpowerloss() {
    velocity = self getvelocity();
    speedsq = lengthsquared(velocity);
    return speedsq > self._gadgets_player.gadget_powermovespeed * self._gadgets_player.gadget_powermovespeed;
}

// Namespace ability_power
// Params 2, eflags: 0x1 linked
// namespace_fcced877<file_0>::function_238c013c
// Checksum 0x9750aea3, Offset: 0xd90
// Size: 0x240
function power_consume_timer_think(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    time = gettime();
    while (true) {
        wait(0.1);
        if (!isdefined(self._gadgets_player[slot])) {
            return;
        }
        if (!self gadgetisactive(slot)) {
            return;
        }
        currenttime = gettime();
        interval = currenttime - time;
        time = currenttime;
        powerconsumpted = 0;
        if (self isonground()) {
            if (self._gadgets_player[slot].gadget_powersprintloss > 0 && self issprinting()) {
                powerconsumpted += 1 * interval / 1000 * self._gadgets_player[slot].gadget_powersprintloss;
            } else if (self._gadgets_player[slot].gadget_powermoveloss && self ismovingpowerloss()) {
                powerconsumpted += 1 * interval / 1000 * self._gadgets_player[slot].gadget_powermoveloss;
            }
        }
        if (powerconsumpted > 0.1) {
            self power_loss_event(slot, self, powerconsumpted, "consume");
            if (self._gadgets_player[slot].gadget_flickeronpowerloss > 0) {
                self ability_gadgets::setflickering(slot, self._gadgets_player[slot].gadget_flickeronpowerloss);
            }
        }
    }
}

