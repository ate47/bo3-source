#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_gadgets;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/gadgets/_gadget_active_camo;
#using scripts/shared/abilities/gadgets/_gadget_armor;
#using scripts/shared/abilities/gadgets/_gadget_cacophany;
#using scripts/shared/abilities/gadgets/_gadget_camo;
#using scripts/shared/abilities/gadgets/_gadget_cleanse;
#using scripts/shared/abilities/gadgets/_gadget_clone;
#using scripts/shared/abilities/gadgets/_gadget_combat_efficiency;
#using scripts/shared/abilities/gadgets/_gadget_concussive_wave;
#using scripts/shared/abilities/gadgets/_gadget_es_strike;
#using scripts/shared/abilities/gadgets/_gadget_exo_breakdown;
#using scripts/shared/abilities/gadgets/_gadget_firefly_swarm;
#using scripts/shared/abilities/gadgets/_gadget_flashback;
#using scripts/shared/abilities/gadgets/_gadget_forced_malfunction;
#using scripts/shared/abilities/gadgets/_gadget_heat_wave;
#using scripts/shared/abilities/gadgets/_gadget_hero_weapon;
#using scripts/shared/abilities/gadgets/_gadget_iff_override;
#using scripts/shared/abilities/gadgets/_gadget_immolation;
#using scripts/shared/abilities/gadgets/_gadget_misdirection;
#using scripts/shared/abilities/gadgets/_gadget_mrpukey;
#using scripts/shared/abilities/gadgets/_gadget_other;
#using scripts/shared/abilities/gadgets/_gadget_overdrive;
#using scripts/shared/abilities/gadgets/_gadget_rapid_strike;
#using scripts/shared/abilities/gadgets/_gadget_ravage_core;
#using scripts/shared/abilities/gadgets/_gadget_resurrect;
#using scripts/shared/abilities/gadgets/_gadget_roulette;
#using scripts/shared/abilities/gadgets/_gadget_security_breach;
#using scripts/shared/abilities/gadgets/_gadget_sensory_overload;
#using scripts/shared/abilities/gadgets/_gadget_servo_shortout;
#using scripts/shared/abilities/gadgets/_gadget_shock_field;
#using scripts/shared/abilities/gadgets/_gadget_smokescreen;
#using scripts/shared/abilities/gadgets/_gadget_speed_burst;
#using scripts/shared/abilities/gadgets/_gadget_surge;
#using scripts/shared/abilities/gadgets/_gadget_system_overload;
#using scripts/shared/abilities/gadgets/_gadget_thief;
#using scripts/shared/abilities/gadgets/_gadget_unstoppable_force;
#using scripts/shared/abilities/gadgets/_gadget_vision_pulse;
#using scripts/shared/array_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/weapons/replay_gun;

#namespace ability_player;

// Namespace ability_player
// Params 0, eflags: 0x2
// Checksum 0x15dada27, Offset: 0xba8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("ability_player", &__init__, undefined, undefined);
}

// Namespace ability_player
// Params 0, eflags: 0x0
// Checksum 0x1171def3, Offset: 0xbe8
// Size: 0xcc
function __init__() {
    function_18f95194();
    setup_clientfields();
    level thread function_56806b7b();
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    callback::on_disconnect(&on_player_disconnect);
    if (!isdefined(level._gadgets_level)) {
        level._gadgets_level = [];
    }
    /#
        level thread abilities_devgui_init();
    #/
}

// Namespace ability_player
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0xcc0
// Size: 0x4
function function_18f95194() {
    
}

// Namespace ability_player
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0xcd0
// Size: 0x4
function setup_clientfields() {
    
}

// Namespace ability_player
// Params 0, eflags: 0x0
// Checksum 0x47b2a0b0, Offset: 0xce0
// Size: 0x34
function on_player_connect() {
    if (!isdefined(self._gadgets_player)) {
        self._gadgets_player = [];
    }
    /#
        self thread abilities_devgui_player_connect();
    #/
}

// Namespace ability_player
// Params 0, eflags: 0x0
// Checksum 0xc335cafa, Offset: 0xd20
// Size: 0x36
function on_player_spawned() {
    self thread function_35a6b583();
    self.heroabilityactivatetime = undefined;
    self.heroabilitydectivatetime = undefined;
    self.heroabilityactive = undefined;
}

// Namespace ability_player
// Params 0, eflags: 0x0
// Checksum 0x2bd5899d, Offset: 0xd60
// Size: 0x1c
function on_player_disconnect() {
    /#
        self thread abilities_devgui_player_disconnect();
    #/
}

// Namespace ability_player
// Params 0, eflags: 0x0
// Checksum 0x67e528a2, Offset: 0xd88
// Size: 0x70
function is_using_any_gadget() {
    if (!isplayer(self)) {
        return false;
    }
    for (i = 0; i < 3; i++) {
        if (self gadget_is_in_use(i)) {
            return true;
        }
    }
    return false;
}

// Namespace ability_player
// Params 1, eflags: 0x0
// Checksum 0xfdeccba7, Offset: 0xe00
// Size: 0x136
function gadgets_save_power(game_ended) {
    for (slot = 0; slot < 3; slot++) {
        if (!isdefined(self._gadgets_player[slot])) {
            continue;
        }
        gadgetweapon = self._gadgets_player[slot];
        powerleft = self gadgetpowerchange(slot, 0);
        if (game_ended && gadget_is_in_use(slot)) {
            self gadgetdeactivate(slot, gadgetweapon);
            if (gadgetweapon.gadget_power_round_end_active_penalty > 0) {
                powerleft -= gadgetweapon.gadget_power_round_end_active_penalty;
                powerleft = max(0, powerleft);
            }
        }
        self.pers["held_gadgets_power"][gadgetweapon] = powerleft;
    }
}

// Namespace ability_player
// Params 0, eflags: 0x0
// Checksum 0x31cad955, Offset: 0xf40
// Size: 0x54
function function_35a6b583() {
    self endon(#"disconnect");
    self.pers["held_gadgets_power"] = [];
    self waittill(#"death");
    if (!isdefined(self._gadgets_player)) {
        return;
    }
    self gadgets_save_power(0);
}

// Namespace ability_player
// Params 0, eflags: 0x0
// Checksum 0xaae251b8, Offset: 0xfa0
// Size: 0xea
function function_56806b7b() {
    level waittill(#"game_ended");
    players = getplayers();
    foreach (player in players) {
        if (!isalive(player)) {
            continue;
        }
        if (!isdefined(player._gadgets_player)) {
            continue;
        }
        player gadgets_save_power(1);
    }
}

// Namespace ability_player
// Params 2, eflags: 0x0
// Checksum 0x4e354dac, Offset: 0x1098
// Size: 0x28
function script_set_cclass(cclass, save) {
    if (!isdefined(save)) {
        save = 1;
    }
}

// Namespace ability_player
// Params 1, eflags: 0x0
// Checksum 0xeaa6c6c6, Offset: 0x10c8
// Size: 0xc
function function_51b42ee1(weapon) {
    
}

// Namespace ability_player
// Params 1, eflags: 0x0
// Checksum 0x6c63b481, Offset: 0x10e0
// Size: 0x78
function register_gadget(type) {
    if (!isdefined(level._gadgets_level)) {
        level._gadgets_level = [];
    }
    if (!isdefined(level._gadgets_level[type])) {
        level._gadgets_level[type] = spawnstruct();
        level._gadgets_level[type].should_notify = 1;
    }
}

// Namespace ability_player
// Params 2, eflags: 0x0
// Checksum 0x58a8bc5d, Offset: 0x1160
// Size: 0x54
function register_gadget_should_notify(type, should_notify) {
    register_gadget(type);
    if (isdefined(should_notify)) {
        level._gadgets_level[type].should_notify = should_notify;
    }
}

// Namespace ability_player
// Params 3, eflags: 0x0
// Checksum 0x16cf01d6, Offset: 0x11c0
// Size: 0x272
function register_gadget_possession_callbacks(type, on_give, on_take) {
    register_gadget(type);
    if (!isdefined(level._gadgets_level[type].on_give)) {
        level._gadgets_level[type].on_give = [];
    }
    if (!isdefined(level._gadgets_level[type].on_take)) {
        level._gadgets_level[type].on_take = [];
    }
    if (isdefined(on_give)) {
        if (!isdefined(level._gadgets_level[type].on_give)) {
            level._gadgets_level[type].on_give = [];
        } else if (!isarray(level._gadgets_level[type].on_give)) {
            level._gadgets_level[type].on_give = array(level._gadgets_level[type].on_give);
        }
        level._gadgets_level[type].on_give[level._gadgets_level[type].on_give.size] = on_give;
    }
    if (isdefined(on_take)) {
        if (!isdefined(level._gadgets_level[type].on_take)) {
            level._gadgets_level[type].on_take = [];
        } else if (!isarray(level._gadgets_level[type].on_take)) {
            level._gadgets_level[type].on_take = array(level._gadgets_level[type].on_take);
        }
        level._gadgets_level[type].on_take[level._gadgets_level[type].on_take.size] = on_take;
    }
}

// Namespace ability_player
// Params 3, eflags: 0x0
// Checksum 0x39d1228d, Offset: 0x1440
// Size: 0x272
function register_gadget_activation_callbacks(type, turn_on, turn_off) {
    register_gadget(type);
    if (!isdefined(level._gadgets_level[type].turn_on)) {
        level._gadgets_level[type].turn_on = [];
    }
    if (!isdefined(level._gadgets_level[type].turn_off)) {
        level._gadgets_level[type].turn_off = [];
    }
    if (isdefined(turn_on)) {
        if (!isdefined(level._gadgets_level[type].turn_on)) {
            level._gadgets_level[type].turn_on = [];
        } else if (!isarray(level._gadgets_level[type].turn_on)) {
            level._gadgets_level[type].turn_on = array(level._gadgets_level[type].turn_on);
        }
        level._gadgets_level[type].turn_on[level._gadgets_level[type].turn_on.size] = turn_on;
    }
    if (isdefined(turn_off)) {
        if (!isdefined(level._gadgets_level[type].turn_off)) {
            level._gadgets_level[type].turn_off = [];
        } else if (!isarray(level._gadgets_level[type].turn_off)) {
            level._gadgets_level[type].turn_off = array(level._gadgets_level[type].turn_off);
        }
        level._gadgets_level[type].turn_off[level._gadgets_level[type].turn_off.size] = turn_off;
    }
}

// Namespace ability_player
// Params 2, eflags: 0x0
// Checksum 0x4130076e, Offset: 0x16c0
// Size: 0x14a
function register_gadget_flicker_callbacks(type, on_flicker) {
    register_gadget(type);
    if (!isdefined(level._gadgets_level[type].on_flicker)) {
        level._gadgets_level[type].on_flicker = [];
    }
    if (isdefined(on_flicker)) {
        if (!isdefined(level._gadgets_level[type].on_flicker)) {
            level._gadgets_level[type].on_flicker = [];
        } else if (!isarray(level._gadgets_level[type].on_flicker)) {
            level._gadgets_level[type].on_flicker = array(level._gadgets_level[type].on_flicker);
        }
        level._gadgets_level[type].on_flicker[level._gadgets_level[type].on_flicker.size] = on_flicker;
    }
}

// Namespace ability_player
// Params 2, eflags: 0x0
// Checksum 0xd6638e12, Offset: 0x1818
// Size: 0x14a
function register_gadget_ready_callbacks(type, ready_func) {
    register_gadget(type);
    if (!isdefined(level._gadgets_level[type].on_ready)) {
        level._gadgets_level[type].on_ready = [];
    }
    if (isdefined(ready_func)) {
        if (!isdefined(level._gadgets_level[type].on_ready)) {
            level._gadgets_level[type].on_ready = [];
        } else if (!isarray(level._gadgets_level[type].on_ready)) {
            level._gadgets_level[type].on_ready = array(level._gadgets_level[type].on_ready);
        }
        level._gadgets_level[type].on_ready[level._gadgets_level[type].on_ready.size] = ready_func;
    }
}

// Namespace ability_player
// Params 2, eflags: 0x0
// Checksum 0x5425f352, Offset: 0x1970
// Size: 0x14a
function register_gadget_primed_callbacks(type, primed_func) {
    register_gadget(type);
    if (!isdefined(level._gadgets_level[type].on_primed)) {
        level._gadgets_level[type].on_primed = [];
    }
    if (isdefined(primed_func)) {
        if (!isdefined(level._gadgets_level[type].on_primed)) {
            level._gadgets_level[type].on_primed = [];
        } else if (!isarray(level._gadgets_level[type].on_primed)) {
            level._gadgets_level[type].on_primed = array(level._gadgets_level[type].on_primed);
        }
        level._gadgets_level[type].on_primed[level._gadgets_level[type].on_primed.size] = primed_func;
    }
}

// Namespace ability_player
// Params 2, eflags: 0x0
// Checksum 0x5fd2674e, Offset: 0x1ac8
// Size: 0x54
function register_gadget_is_inuse_callbacks(type, inuse_func) {
    register_gadget(type);
    if (isdefined(inuse_func)) {
        level._gadgets_level[type].isinuse = inuse_func;
    }
}

// Namespace ability_player
// Params 2, eflags: 0x0
// Checksum 0x7814ef64, Offset: 0x1b28
// Size: 0x54
function register_gadget_is_flickering_callbacks(type, flickering_func) {
    register_gadget(type);
    if (isdefined(flickering_func)) {
        level._gadgets_level[type].isflickering = flickering_func;
    }
}

// Namespace ability_player
// Params 2, eflags: 0x0
// Checksum 0x871d9f5e, Offset: 0x1b88
// Size: 0x14a
function register_gadget_failed_activate_callback(type, failed_activate) {
    register_gadget(type);
    if (!isdefined(level._gadgets_level[type].failed_activate)) {
        level._gadgets_level[type].failed_activate = [];
    }
    if (isdefined(failed_activate)) {
        if (!isdefined(level._gadgets_level[type].failed_activate)) {
            level._gadgets_level[type].failed_activate = [];
        } else if (!isarray(level._gadgets_level[type].failed_activate)) {
            level._gadgets_level[type].failed_activate = array(level._gadgets_level[type].failed_activate);
        }
        level._gadgets_level[type].failed_activate[level._gadgets_level[type].failed_activate.size] = failed_activate;
    }
}

// Namespace ability_player
// Params 1, eflags: 0x0
// Checksum 0x4336353a, Offset: 0x1ce0
// Size: 0xca
function gadget_is_in_use(slot) {
    if (isdefined(self._gadgets_player[slot])) {
        if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
            if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].isinuse)) {
                return self [[ level._gadgets_level[self._gadgets_player[slot].gadget_type].isinuse ]](slot);
            }
        }
    }
    return self gadgetisactive(slot);
}

// Namespace ability_player
// Params 1, eflags: 0x0
// Checksum 0xccc9fbca, Offset: 0x1db8
// Size: 0x8e
function gadget_is_flickering(slot) {
    if (!isdefined(self._gadgets_player[slot])) {
        return 0;
    }
    if (!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].isflickering)) {
        return 0;
    }
    return self [[ level._gadgets_level[self._gadgets_player[slot].gadget_type].isflickering ]](slot);
}

// Namespace ability_player
// Params 2, eflags: 0x0
// Checksum 0x92df06ef, Offset: 0x1e50
// Size: 0x22c
function give_gadget(slot, weapon) {
    if (isdefined(self._gadgets_player[slot])) {
        self take_gadget(slot, self._gadgets_player[slot]);
    }
    for (eslot = 0; eslot < 3; eslot++) {
        existinggadget = self._gadgets_player[eslot];
        if (isdefined(existinggadget) && existinggadget == weapon) {
            self take_gadget(eslot, existinggadget);
        }
    }
    self._gadgets_player[slot] = weapon;
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_give)) {
            foreach (on_give in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_give) {
                self [[ on_give ]](slot, weapon);
            }
        }
    }
    if (sessionmodeismultiplayergame()) {
        self.heroabilityname = isdefined(weapon) ? weapon.name : undefined;
    }
}

// Namespace ability_player
// Params 2, eflags: 0x0
// Checksum 0x673409b5, Offset: 0x2088
// Size: 0x138
function take_gadget(slot, weapon) {
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_take)) {
            foreach (on_take in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_take) {
                self [[ on_take ]](slot, weapon);
            }
        }
    }
    self._gadgets_player[slot] = undefined;
}

// Namespace ability_player
// Params 2, eflags: 0x0
// Checksum 0x9eefb215, Offset: 0x21c8
// Size: 0x304
function turn_gadget_on(slot, weapon) {
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    self.playedgadgetsuccess = 0;
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_on)) {
            foreach (turn_on in level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_on) {
                self [[ turn_on ]](slot, weapon);
                self trackheropoweractivated(game["timepassed"]);
                level notify(#"hero_gadget_activated", self, weapon);
                self notify(#"hero_gadget_activated", weapon);
            }
        }
    }
    if (isdefined(level.cybercom) && isdefined(level.cybercom._ability_turn_on)) {
        self [[ level.cybercom._ability_turn_on ]](slot, weapon);
    }
    self.pers["heroGadgetNotified"] = 0;
    xuid = self getxuid();
    bbprint("mpheropowerevents", "spawnid %d gametime %d name %s powerstate %s playername %s xuid %s", getplayerspawnid(self), gettime(), self._gadgets_player[slot].name, "activated", self.name, xuid);
    if (isdefined(level.playgadgetactivate)) {
        self [[ level.playgadgetactivate ]](weapon);
    }
    if (weapon.gadget_type != 14) {
        if (isdefined(self.isneardeath) && self.isneardeath == 1) {
            if (isdefined(level.heroabilityactivateneardeath)) {
                [[ level.heroabilityactivateneardeath ]]();
            }
        }
        self.heroabilityactivatetime = gettime();
        self.heroabilityactive = 1;
        self.heroability = weapon;
    }
    self thread ability_power::power_consume_timer_think(slot, weapon);
}

// Namespace ability_player
// Params 2, eflags: 0x0
// Checksum 0xa9a853a1, Offset: 0x24d8
// Size: 0x33c
function turn_gadget_off(slot, weapon) {
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    if (!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        return;
    }
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_off)) {
        foreach (turn_off in level._gadgets_level[self._gadgets_player[slot].gadget_type].turn_off) {
            self [[ turn_off ]](slot, weapon);
            dead = self.health <= 0;
            self trackheropowerexpired(game["timepassed"], dead, self.var_6f75d638, self.var_6a936b17);
        }
    }
    if (isdefined(level.cybercom) && isdefined(level.cybercom._ability_turn_off)) {
        self [[ level.cybercom._ability_turn_off ]](slot, weapon);
    }
    if (weapon.gadget_type != 14) {
        if (self isempjammed() == 1) {
            self gadgettargetresult(0);
            if (isdefined(level.var_3b36608e)) {
                if (isdefined(weapon.gadget_turnoff_onempjammed) && weapon.gadget_turnoff_onempjammed == 1) {
                    self thread [[ level.var_3b36608e ]]();
                }
            }
        }
        self.heroabilitydectivatetime = gettime();
        self.heroabilityactive = undefined;
        self.heroability = weapon;
    }
    self notify(#"heroability_off", weapon);
    xuid = self getxuid();
    bbprint("mpheropowerevents", "spawnid %d gametime %d name %s powerstate %s playername %s xuid %s", getplayerspawnid(self), gettime(), self._gadgets_player[slot].name, "expired", self.name, xuid);
    if (isdefined(level.oldschool) && level.oldschool) {
        self takeweapon(weapon);
    }
}

// Namespace ability_player
// Params 1, eflags: 0x0
// Checksum 0x884adf33, Offset: 0x2820
// Size: 0x282
function gadget_checkheroabilitykill(attacker) {
    heroabilitystat = 0;
    if (isdefined(attacker.heroability)) {
        switch (attacker.heroability.name) {
        case "gadget_armor":
        case "gadget_clone":
        case "gadget_heat_wave":
        case "gadget_speed_burst":
            if (isdefined(attacker.heroabilitydectivatetime) && (isdefined(attacker.heroabilityactive) || attacker.heroabilitydectivatetime > gettime() - 100)) {
                heroabilitystat = 1;
            }
            break;
        case "gadget_camo":
        case "gadget_flashback":
        case "gadget_resurrect":
            if (isdefined(attacker.heroabilitydectivatetime) && (isdefined(attacker.heroabilityactive) || attacker.heroabilitydectivatetime > gettime() - 6000)) {
                heroabilitystat = 1;
            }
            break;
        case "gadget_vision_pulse":
            if (isdefined(attacker.visionpulsespottedenemytime)) {
                timecutoff = gettime();
                if (attacker.visionpulsespottedenemytime + 10000 > timecutoff) {
                    for (i = 0; i < attacker.visionpulsespottedenemy.size; i++) {
                        spottedenemy = attacker.visionpulsespottedenemy[i];
                        if (spottedenemy == self) {
                            if (self.lastspawntime < attacker.visionpulsespottedenemytime) {
                                heroabilitystat = 1;
                                break;
                            }
                        }
                    }
                }
            }
        case "gadget_combat_efficiency":
            if (isdefined(attacker._gadget_combat_efficiency) && attacker._gadget_combat_efficiency == 1) {
                heroabilitystat = 1;
                break;
            } else if (isdefined(attacker.combatefficiencylastontime) && attacker.combatefficiencylastontime > gettime() - 100) {
                heroabilitystat = 1;
                break;
            }
            break;
        }
    }
    return heroabilitystat;
}

// Namespace ability_player
// Params 2, eflags: 0x0
// Checksum 0xe69d06fc, Offset: 0x2ab0
// Size: 0x12a
function gadget_flicker(slot, weapon) {
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    if (!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        return;
    }
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_flicker)) {
        foreach (on_flicker in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_flicker) {
            self [[ on_flicker ]](slot, weapon);
        }
    }
}

// Namespace ability_player
// Params 2, eflags: 0x0
// Checksum 0x91d0226a, Offset: 0x2be8
// Size: 0x3ae
function gadget_ready(slot, weapon) {
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    if (!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        return;
    }
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].should_notify) && level._gadgets_level[self._gadgets_player[slot].gadget_type].should_notify) {
        if (isdefined(level.var_f543dad1)) {
            var_c04d8f24 = tablelookuprownum(level.var_f543dad1, 4, self._gadgets_player[slot].name);
            if (var_c04d8f24 > -1) {
                index = int(tablelookupcolumnforrow(level.var_f543dad1, var_c04d8f24, 0));
                if (index != 0) {
                    self luinotifyevent(%hero_weapon_received, 1, index);
                    self luinotifyeventtospectators(%hero_weapon_received, 1, index);
                }
            }
        }
        if (!isdefined(level.gameended) || !level.gameended) {
            if (!isdefined(self.pers["heroGadgetNotified"]) || !self.pers["heroGadgetNotified"]) {
                self.pers["heroGadgetNotified"] = 1;
                if (isdefined(level.playgadgetready)) {
                    self [[ level.playgadgetready ]](weapon);
                }
                self trackheropoweravailable(game["timepassed"]);
            }
        }
    }
    xuid = self getxuid();
    bbprint("mpheropowerevents", "spawnid %d gametime %d name %s powerstate %s playername %s xuid %s", getplayerspawnid(self), gettime(), self._gadgets_player[slot].name, "ready", self.name, xuid);
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_ready)) {
        foreach (on_ready in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_ready) {
            self [[ on_ready ]](slot, weapon);
        }
    }
}

// Namespace ability_player
// Params 2, eflags: 0x0
// Checksum 0x8ca4d2ae, Offset: 0x2fa0
// Size: 0x12a
function gadget_primed(slot, weapon) {
    if (!isdefined(self._gadgets_player[slot])) {
        return;
    }
    if (!isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
        return;
    }
    if (isdefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].on_primed)) {
        foreach (on_primed in level._gadgets_level[self._gadgets_player[slot].gadget_type].on_primed) {
            self [[ on_primed ]](slot, weapon);
        }
    }
}

/#

    // Namespace ability_player
    // Params 1, eflags: 0x0
    // Checksum 0x99daabcb, Offset: 0x30d8
    // Size: 0x44
    function abilities_print(str) {
        toprint = "<dev string:x28>" + str;
        println(toprint);
    }

    // Namespace ability_player
    // Params 0, eflags: 0x0
    // Checksum 0x2504e69e, Offset: 0x3128
    // Size: 0x9c
    function abilities_devgui_init() {
        setdvar("<dev string:x3b>", "<dev string:x54>");
        setdvar("<dev string:x55>", "<dev string:x54>");
        setdvar("<dev string:x6e>", 0);
        if (isdedicated()) {
            return;
        }
        level.abilities_devgui_base = "<dev string:x8a>";
        level thread abilities_devgui_think();
    }

    // Namespace ability_player
    // Params 0, eflags: 0x0
    // Checksum 0x5774a221, Offset: 0x31d0
    // Size: 0xb0
    function abilities_devgui_player_connect() {
        if (!isdefined(level.abilities_devgui_base)) {
            return;
        }
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (players[i] != self) {
                continue;
            }
            abilities_devgui_add_player_commands(level.abilities_devgui_base, players[i].playername, i + 1);
            return;
        }
    }

    // Namespace ability_player
    // Params 3, eflags: 0x0
    // Checksum 0x8af9fb44, Offset: 0x3288
    // Size: 0xb8
    function abilities_devgui_add_player_commands(root, pname, index) {
        add_cmd_with_root = "<dev string:x9b>" + root + pname + "<dev string:xa7>";
        pid = "<dev string:x54>" + index;
        menu_index = 1;
        menu_index = abilities_devgui_add_gadgets(add_cmd_with_root, pid, menu_index);
        menu_index = abilities_devgui_add_power(add_cmd_with_root, pid, menu_index);
    }

    // Namespace ability_player
    // Params 6, eflags: 0x0
    // Checksum 0x10c2ece4, Offset: 0x3348
    // Size: 0xd4
    function abilities_devgui_add_player_command(root, pid, cmdname, menu_index, cmddvar, argdvar) {
        if (!isdefined(argdvar)) {
            argdvar = "<dev string:xa9>";
        }
        adddebugcommand(root + cmdname + "<dev string:xb1>" + "<dev string:x6e>" + "<dev string:xb9>" + pid + "<dev string:xbb>" + "<dev string:x3b>" + "<dev string:xb9>" + cmddvar + "<dev string:xbb>" + "<dev string:x55>" + "<dev string:xb9>" + argdvar + "<dev string:xc1>");
    }

    // Namespace ability_player
    // Params 3, eflags: 0x0
    // Checksum 0xb088df98, Offset: 0x3428
    // Size: 0xc0
    function abilities_devgui_add_power(add_cmd_with_root, pid, menu_index) {
        root = add_cmd_with_root + "<dev string:xc5>" + menu_index + "<dev string:xa7>";
        abilities_devgui_add_player_command(root, pid, "<dev string:xcc>", 1, "<dev string:xd7>", "<dev string:x54>");
        abilities_devgui_add_player_command(root, pid, "<dev string:xdf>", 2, "<dev string:xf0>", "<dev string:x54>");
        menu_index++;
        return menu_index;
    }

    // Namespace ability_player
    // Params 3, eflags: 0x0
    // Checksum 0x4550d7dc, Offset: 0x34f0
    // Size: 0x178
    function abilities_devgui_add_gadgets(add_cmd_with_root, pid, menu_index) {
        a_weapons = enumerateweapons("<dev string:xfb>");
        var_5cea3801 = [];
        a_abilities = [];
        for (i = 0; i < a_weapons.size; i++) {
            if (a_weapons[i].isgadget) {
                if (a_weapons[i].inventorytype == "<dev string:x102>") {
                    arrayinsert(var_5cea3801, a_weapons[i], 0);
                    continue;
                }
                arrayinsert(a_abilities, a_weapons[i], 0);
            }
        }
        function_876574ac(add_cmd_with_root, pid, a_abilities, "<dev string:x107>", menu_index);
        menu_index++;
        function_876574ac(add_cmd_with_root, pid, var_5cea3801, "<dev string:x116>", menu_index);
        menu_index++;
        return menu_index;
    }

    // Namespace ability_player
    // Params 5, eflags: 0x0
    // Checksum 0x1b3ba78a, Offset: 0x3670
    // Size: 0xc6
    function function_876574ac(root, pid, a_weapons, weapon_type, menu_index) {
        if (isdefined(a_weapons)) {
            player_devgui_root = root + weapon_type + "<dev string:xa7>";
            for (i = 0; i < a_weapons.size; i++) {
                function_79aa7c68(player_devgui_root, pid, a_weapons[i].name, i + 1);
                wait 0.05;
            }
        }
    }

    // Namespace ability_player
    // Params 4, eflags: 0x0
    // Checksum 0xe2dae482, Offset: 0x3740
    // Size: 0xac
    function function_79aa7c68(root, pid, weap_name, cmdindex) {
        adddebugcommand(root + weap_name + "<dev string:xb1>" + "<dev string:x6e>" + "<dev string:xb9>" + pid + "<dev string:xbb>" + "<dev string:x3b>" + "<dev string:xb9>" + "<dev string:x123>" + "<dev string:xbb>" + "<dev string:x55>" + "<dev string:xb9>" + weap_name + "<dev string:xc1>");
    }

    // Namespace ability_player
    // Params 0, eflags: 0x0
    // Checksum 0x6fad21cc, Offset: 0x37f8
    // Size: 0x5c
    function abilities_devgui_player_disconnect() {
        if (!isdefined(level.abilities_devgui_base)) {
            return;
        }
        remove_cmd_with_root = "<dev string:x130>" + level.abilities_devgui_base + self.playername + "<dev string:xc1>";
        util::add_queued_debug_command(remove_cmd_with_root);
    }

    // Namespace ability_player
    // Params 0, eflags: 0x0
    // Checksum 0x4528a55a, Offset: 0x3860
    // Size: 0x150
    function abilities_devgui_think() {
        for (;;) {
            cmd = getdvarstring("<dev string:x3b>");
            if (cmd == "<dev string:x54>") {
                wait 0.05;
                continue;
            }
            arg = getdvarstring("<dev string:x55>");
            switch (cmd) {
            case "<dev string:xd7>":
                abilities_devgui_handle_player_command(cmd, &abilities_devgui_power_fill);
                break;
            case "<dev string:xf0>":
                abilities_devgui_handle_player_command(cmd, &abilities_devgui_power_toggle_auto_fill);
                break;
            case "<dev string:x123>":
                abilities_devgui_handle_player_command(cmd, &abilities_devgui_give, arg);
            case "<dev string:x54>":
                break;
            default:
                break;
            }
            setdvar("<dev string:x3b>", "<dev string:x54>");
            wait 0.5;
        }
    }

    // Namespace ability_player
    // Params 1, eflags: 0x0
    // Checksum 0x91375ef0, Offset: 0x39b8
    // Size: 0x146
    function abilities_devgui_give(weapon_name) {
        level.devgui_giving_abilities = 1;
        for (i = 0; i < 3; i++) {
            if (isdefined(self._gadgets_player[i])) {
                self takeweapon(self._gadgets_player[i]);
            }
        }
        self notify(#"gadget_devgui_give");
        weapon = getweapon(weapon_name);
        self giveweapon(weapon);
        if (self util::is_bot()) {
            slot = self gadgetgetslot(weapon);
            self gadgetpowerset(slot, 100);
            self bot::function_cf8f9518(weapon);
        }
        level.devgui_giving_abilities = undefined;
    }

    // Namespace ability_player
    // Params 3, eflags: 0x0
    // Checksum 0xac66a026, Offset: 0x3b08
    // Size: 0x10c
    function abilities_devgui_handle_player_command(cmd, playercallback, pcb_param) {
        pid = getdvarint("<dev string:x6e>");
        if (pid > 0) {
            player = getplayers()[pid - 1];
            if (isdefined(player)) {
                if (isdefined(pcb_param)) {
                    player thread [[ playercallback ]](pcb_param);
                } else {
                    player thread [[ playercallback ]]();
                }
            }
        } else {
            array::thread_all(getplayers(), playercallback, pcb_param);
        }
        setdvar("<dev string:x6e>", "<dev string:x13f>");
    }

    // Namespace ability_player
    // Params 0, eflags: 0x0
    // Checksum 0xe1eabf1b, Offset: 0x3c20
    // Size: 0x8e
    function abilities_devgui_power_fill() {
        if (!isdefined(self) || !isdefined(self._gadgets_player)) {
            return;
        }
        for (i = 0; i < 3; i++) {
            if (isdefined(self._gadgets_player[i])) {
                self gadgetpowerset(i, self._gadgets_player[i].gadget_powermax);
            }
        }
    }

    // Namespace ability_player
    // Params 0, eflags: 0x0
    // Checksum 0x24513600, Offset: 0x3cb8
    // Size: 0x54
    function abilities_devgui_power_toggle_auto_fill() {
        if (!isdefined(self) || !isdefined(self._gadgets_player)) {
            return;
        }
        self.abilities_devgui_power_toggle_auto_fill = !(isdefined(self.abilities_devgui_power_toggle_auto_fill) && self.abilities_devgui_power_toggle_auto_fill);
        self thread abilities_devgui_power_toggle_auto_fill_think();
    }

    // Namespace ability_player
    // Params 0, eflags: 0x0
    // Checksum 0xc26c35e5, Offset: 0x3d18
    // Size: 0x108
    function abilities_devgui_power_toggle_auto_fill_think() {
        self endon(#"disconnect");
        self notify(#"auto_fill_think");
        self endon(#"auto_fill_think");
        for (;;) {
            if (!isdefined(self) || !isdefined(self._gadgets_player)) {
                return;
            }
            if (!(isdefined(self.abilities_devgui_power_toggle_auto_fill) && self.abilities_devgui_power_toggle_auto_fill)) {
                return;
            }
            for (i = 0; i < 3; i++) {
                if (isdefined(self._gadgets_player[i])) {
                    if (!self gadget_is_in_use(i) && self gadgetcharging(i)) {
                        self gadgetpowerset(i, self._gadgets_player[i].gadget_powermax);
                    }
                }
            }
            wait 1;
        }
    }

#/
