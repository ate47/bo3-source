#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_audio;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace zm_hero_weapon;

// Namespace zm_hero_weapon
// Params 0, eflags: 0x2
// Checksum 0xddcbcacf, Offset: 0x330
// Size: 0x34
function function_2dc19561() {
    system::register("zm_hero_weapons", &__init__, undefined, undefined);
}

// Namespace zm_hero_weapon
// Params 0, eflags: 0x1 linked
// Checksum 0x3a0a2a5c, Offset: 0x370
// Size: 0x84
function __init__() {
    if (!isdefined(level.var_e1cac31a)) {
        level.var_e1cac31a = [];
    }
    callback::on_spawned(&on_player_spawned);
    level.hero_power_update = &function_ee417828;
    ability_player::register_gadget_activation_callbacks(14, &gadget_hero_weapon_on_activate, &gadget_hero_weapon_on_off);
}

// Namespace zm_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0xca33803a, Offset: 0x400
// Size: 0x14
function gadget_hero_weapon_on_activate(slot, weapon) {
    
}

// Namespace zm_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0x9a3b144e, Offset: 0x420
// Size: 0x34
function gadget_hero_weapon_on_off(slot, weapon) {
    self thread function_66dc358a(slot, weapon);
}

// Namespace zm_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0x91877935, Offset: 0x460
// Size: 0xb8
function function_66dc358a(slot, weapon) {
    wait(1);
    if (isdefined(self)) {
        w_current = self getcurrentweapon();
        if (isdefined(w_current) && zm_utility::is_hero_weapon(w_current)) {
            self.hero_power = self gadgetpowerget(0);
            if (self.hero_power <= 0) {
                zm_weapons::switch_back_primary_weapon(undefined, 1);
                self.var_4fe17261 = 1;
            }
        }
    }
}

// Namespace zm_hero_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0x91d0c352, Offset: 0x520
// Size: 0x16c
function function_d29010f8(weapon_name) {
    weaponnone = getweapon("none");
    weapon = getweapon(weapon_name);
    if (weapon != weaponnone) {
        hero_weapon = spawnstruct();
        hero_weapon.weapon = weapon;
        hero_weapon.var_de5837e9 = &function_d2d326f4;
        hero_weapon.var_2435bb1b = &function_b2420f42;
        hero_weapon.var_66843a8d = &function_44ede878;
        hero_weapon.var_ce4a62b0 = &function_d1e94a2f;
        hero_weapon.var_42862d23 = &function_95308272;
        hero_weapon.var_58fa5951 = &function_194811c8;
        if (!isdefined(level.var_e1cac31a)) {
            level.var_e1cac31a = [];
        }
        level.var_e1cac31a[weapon] = hero_weapon;
        zm_utility::register_hero_weapon_for_level(weapon_name);
    }
}

// Namespace zm_hero_weapon
// Params 3, eflags: 0x0
// Checksum 0xd1d7326f, Offset: 0x698
// Size: 0xfc
function function_9aa1d93(weapon_name, var_de5837e9, var_2435bb1b) {
    if (!isdefined(var_de5837e9)) {
        var_de5837e9 = &function_d2d326f4;
    }
    if (!isdefined(var_2435bb1b)) {
        var_2435bb1b = &function_b2420f42;
    }
    weaponnone = getweapon("none");
    weapon = getweapon(weapon_name);
    if (weapon != weaponnone && isdefined(level.var_e1cac31a[weapon])) {
        level.var_e1cac31a[weapon].var_de5837e9 = var_de5837e9;
        level.var_e1cac31a[weapon].var_2435bb1b = var_2435bb1b;
    }
}

// Namespace zm_hero_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0x5949750, Offset: 0x7a0
// Size: 0x7c
function function_d2d326f4(weapon) {
    power = self gadgetpowerget(0);
    if (power < 100) {
        self function_eca1a7bb(weapon, 1);
        return;
    }
    self function_eca1a7bb(weapon, 2);
}

// Namespace zm_hero_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0xed663b25, Offset: 0x828
// Size: 0x24
function function_b2420f42(weapon) {
    self function_eca1a7bb(weapon, 0);
}

// Namespace zm_hero_weapon
// Params 3, eflags: 0x1 linked
// Checksum 0x44e3b313, Offset: 0x858
// Size: 0xfc
function function_e295a0c2(weapon_name, var_66843a8d, var_ce4a62b0) {
    if (!isdefined(var_66843a8d)) {
        var_66843a8d = &function_44ede878;
    }
    if (!isdefined(var_ce4a62b0)) {
        var_ce4a62b0 = &function_d1e94a2f;
    }
    weaponnone = getweapon("none");
    weapon = getweapon(weapon_name);
    if (weapon != weaponnone && isdefined(level.var_e1cac31a[weapon])) {
        level.var_e1cac31a[weapon].var_66843a8d = var_66843a8d;
        level.var_e1cac31a[weapon].var_ce4a62b0 = var_ce4a62b0;
    }
}

// Namespace zm_hero_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0xc2f21230, Offset: 0x960
// Size: 0x2c
function function_44ede878(weapon) {
    self function_eca1a7bb(weapon, 3);
}

// Namespace zm_hero_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0xa0d76c05, Offset: 0x998
// Size: 0x2c
function function_d1e94a2f(weapon) {
    self function_eca1a7bb(weapon, 1);
}

// Namespace zm_hero_weapon
// Params 3, eflags: 0x1 linked
// Checksum 0xe74252b4, Offset: 0x9d0
// Size: 0xfc
function function_abe86c3f(weapon_name, var_42862d23, var_58fa5951) {
    if (!isdefined(var_42862d23)) {
        var_42862d23 = &function_95308272;
    }
    if (!isdefined(var_58fa5951)) {
        var_58fa5951 = &function_194811c8;
    }
    weaponnone = getweapon("none");
    weapon = getweapon(weapon_name);
    if (weapon != weaponnone && isdefined(level.var_e1cac31a[weapon])) {
        level.var_e1cac31a[weapon].var_42862d23 = var_42862d23;
        level.var_e1cac31a[weapon].var_58fa5951 = var_58fa5951;
    }
}

// Namespace zm_hero_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0x8a58efd8, Offset: 0xad8
// Size: 0x4c
function function_95308272(weapon) {
    self function_eca1a7bb(weapon, 2);
    self thread zm_equipment::show_hint_text(%ZOMBIE_HERO_WEAPON_HINT, 2);
}

// Namespace zm_hero_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0xc834301c, Offset: 0xb30
// Size: 0x2c
function function_194811c8(weapon) {
    self function_eca1a7bb(weapon, 1);
}

// Namespace zm_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0xfc9d75c2, Offset: 0xb68
// Size: 0x44
function function_eca1a7bb(w_weapon, state) {
    self.var_f59c6d9a = state;
    self clientfield::set_player_uimodel("zmhud.swordState", state);
}

// Namespace zm_hero_weapon
// Params 0, eflags: 0x1 linked
// Checksum 0x8674e9de, Offset: 0xbb8
// Size: 0x64
function on_player_spawned() {
    self function_eca1a7bb(undefined, 0);
    self thread function_a3acc0f8();
    self thread function_6026b04e();
    self thread function_554fa98b();
}

// Namespace zm_hero_weapon
// Params 0, eflags: 0x1 linked
// Checksum 0xacab0702, Offset: 0xc28
// Size: 0xac
function function_a3acc0f8() {
    self notify(#"hash_a3acc0f8");
    self endon(#"hash_a3acc0f8");
    self endon(#"disconnect");
    while (true) {
        w_weapon = self waittill(#"weapon_give");
        if (isdefined(w_weapon) && zm_utility::is_hero_weapon(w_weapon)) {
            self thread function_ebde8383(w_weapon);
            self [[ level.var_e1cac31a[w_weapon].var_de5837e9 ]](w_weapon);
        }
    }
}

// Namespace zm_hero_weapon
// Params 0, eflags: 0x1 linked
// Checksum 0x9404639b, Offset: 0xce0
// Size: 0xa6
function function_6026b04e() {
    self notify(#"hash_6026b04e");
    self endon(#"hash_6026b04e");
    self endon(#"disconnect");
    while (true) {
        w_weapon = self waittill(#"weapon_take");
        if (isdefined(w_weapon) && zm_utility::is_hero_weapon(w_weapon)) {
            self [[ level.var_e1cac31a[w_weapon].var_2435bb1b ]](w_weapon);
            self notify(#"hash_ca7b8f26");
        }
    }
}

// Namespace zm_hero_weapon
// Params 0, eflags: 0x1 linked
// Checksum 0x82066688, Offset: 0xd90
// Size: 0x188
function function_554fa98b() {
    self notify(#"hash_554fa98b");
    self endon(#"hash_554fa98b");
    self endon(#"disconnect");
    while (true) {
        w_current, w_previous = self waittill(#"weapon_change");
        if (self.sessionstate != "spectator") {
            if (isdefined(w_previous) && zm_utility::is_hero_weapon(w_previous)) {
                self [[ level.var_e1cac31a[w_previous].var_ce4a62b0 ]](w_previous);
                if (self gadgetpowerget(0) == 100) {
                    if (self hasweapon(w_previous)) {
                        self setweaponammoclip(w_previous, w_previous.clipsize);
                        self [[ level.var_e1cac31a[w_previous].var_42862d23 ]](w_previous);
                    }
                }
            }
            if (isdefined(w_current) && zm_utility::is_hero_weapon(w_current)) {
                self [[ level.var_e1cac31a[w_current].var_66843a8d ]](w_current);
            }
        }
    }
}

// Namespace zm_hero_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0x988a8497, Offset: 0xf20
// Size: 0x140
function function_ebde8383(w_weapon) {
    self notify(#"hash_ebde8383");
    self endon(#"hash_ebde8383");
    self endon(#"hash_ca7b8f26");
    self endon(#"disconnect");
    if (!isdefined(self.var_2ff8e129)) {
        self.var_2ff8e129 = -1;
    }
    while (true) {
        self.hero_power = self gadgetpowerget(0);
        self clientfield::set_player_uimodel("zmhud.swordEnergy", self.hero_power / 100);
        if (self.hero_power != self.var_2ff8e129) {
            self.var_2ff8e129 = self.hero_power;
            if (self.hero_power >= 100) {
                self [[ level.var_e1cac31a[w_weapon].var_42862d23 ]](w_weapon);
            } else if (self.hero_power <= 0) {
                self [[ level.var_e1cac31a[w_weapon].var_58fa5951 ]](w_weapon);
            }
        }
        wait(0.05);
    }
}

// Namespace zm_hero_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0xdb2ee190, Offset: 0x1068
// Size: 0xf8
function function_bde51ee1(w_weapon) {
    self endon(#"hash_8851ed94");
    self function_eca1a7bb(w_weapon, 3);
    while (isdefined(self)) {
        n_rate = 1;
        if (isdefined(w_weapon.gadget_power_usage_rate)) {
            n_rate = w_weapon.gadget_power_usage_rate;
        }
        self.hero_power -= 0.05 * n_rate;
        self.hero_power = math::clamp(self.hero_power, 0, 100);
        if (self.hero_power != self.var_2ff8e129) {
            self gadgetpowerset(0, self.hero_power);
        }
        wait(0.05);
    }
}

// Namespace zm_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0x66e2d91e, Offset: 0x1168
// Size: 0x52
function function_3d766bf2(w_hero, func) {
    if (!isdefined(level.var_6f87c778)) {
        level.var_6f87c778 = [];
    }
    if (!isdefined(level.var_6f87c778[w_hero])) {
        level.var_6f87c778[w_hero] = func;
    }
}

// Namespace zm_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0x5b761bd, Offset: 0x11c8
// Size: 0x8c
function function_ee417828(e_player, ai_enemy) {
    w_hero = e_player.current_hero_weapon;
    if (isdefined(level.var_6f87c778) && isdefined(level.var_6f87c778[w_hero])) {
        level [[ level.var_6f87c778[w_hero] ]](e_player, ai_enemy);
        return;
    }
    level function_344c251e(e_player, ai_enemy);
}

// Namespace zm_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0xf9b2ff3f, Offset: 0x1260
// Size: 0x8c
function function_344c251e(player, ai_enemy) {
    if (isdefined(player) && player zm_utility::has_player_hero_weapon() && !(player.var_f59c6d9a === 3) && !(isdefined(player.disable_hero_power_charging) && player.disable_hero_power_charging)) {
        player function_6151f8ea(ai_enemy);
    }
}

// Namespace zm_hero_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0x103188ec, Offset: 0x12f8
// Size: 0x174
function function_6151f8ea(ai_enemy) {
    if (isdefined(self)) {
        w_current = self zm_utility::get_player_hero_weapon();
        if (isdefined(ai_enemy.heroweapon_kill_power)) {
            perkfactor = 1;
            if (self hasperk("specialty_overcharge")) {
                perkfactor = getdvarfloat("gadgetPowerOverchargePerkScoreFactor");
            }
            if (isdefined(self.var_4fe17261) && self.var_4fe17261) {
            }
            self.hero_power += perkfactor * ai_enemy.heroweapon_kill_power;
            self.hero_power = math::clamp(self.hero_power, 0, 100);
            if (self.hero_power != self.var_2ff8e129) {
                self gadgetpowerset(0, self.hero_power);
                self clientfield::set_player_uimodel("zmhud.swordEnergy", self.hero_power / 100);
                self clientfield::increment_uimodel("zmhud.swordChargeUpdate");
            }
        }
    }
}

// Namespace zm_hero_weapon
// Params 0, eflags: 0x1 linked
// Checksum 0xfff9669b, Offset: 0x1478
// Size: 0x3c
function function_fbd02062() {
    if (isdefined(self.current_hero_weapon)) {
        self notify(#"weapon_take", self.current_hero_weapon);
        self gadgetpowerset(0, 0);
    }
}

// Namespace zm_hero_weapon
// Params 0, eflags: 0x1 linked
// Checksum 0x1fe81f5, Offset: 0x14c0
// Size: 0x10
function function_f3451c9f() {
    return self.var_f59c6d9a === 3;
}

