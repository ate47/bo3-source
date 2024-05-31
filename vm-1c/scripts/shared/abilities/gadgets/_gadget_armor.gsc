#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace armor;

// Namespace armor
// Params 0, eflags: 0x2
// namespace_5e52c0f2<file_0>::function_2dc19561
// Checksum 0xbb9ee106, Offset: 0x4d8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_armor", &__init__, undefined, undefined);
}

// Namespace armor
// Params 0, eflags: 0x1 linked
// namespace_5e52c0f2<file_0>::function_8c87d8eb
// Checksum 0xe26d26b, Offset: 0x518
// Size: 0x144
function __init__() {
    ability_player::register_gadget_activation_callbacks(4, &function_27d2ab93, &function_ef8f7527);
    ability_player::register_gadget_possession_callbacks(4, &function_f593f079, &function_c03e583);
    ability_player::register_gadget_flicker_callbacks(4, &function_9b27736e);
    ability_player::register_gadget_is_inuse_callbacks(4, &function_24782613);
    ability_player::register_gadget_is_flickering_callbacks(4, &function_e4e11f03);
    clientfield::register("allplayers", "armor_status", 1, 5, "int");
    clientfield::register("toplayer", "player_damage_type", 1, 1, "int");
    callback::on_connect(&function_362bc1a8);
}

// Namespace armor
// Params 1, eflags: 0x1 linked
// namespace_5e52c0f2<file_0>::function_24782613
// Checksum 0xe841b40b, Offset: 0x668
// Size: 0x22
function function_24782613(slot) {
    return self gadgetisactive(slot);
}

// Namespace armor
// Params 1, eflags: 0x1 linked
// namespace_5e52c0f2<file_0>::function_e4e11f03
// Checksum 0x38b17ccc, Offset: 0x698
// Size: 0x22
function function_e4e11f03(slot) {
    return self gadgetflickering(slot);
}

// Namespace armor
// Params 2, eflags: 0x1 linked
// namespace_5e52c0f2<file_0>::function_9b27736e
// Checksum 0xfafd890f, Offset: 0x6c8
// Size: 0x34
function function_9b27736e(slot, weapon) {
    self thread function_29961c34(slot, weapon);
}

// Namespace armor
// Params 2, eflags: 0x1 linked
// namespace_5e52c0f2<file_0>::function_f593f079
// Checksum 0xdcd54c3b, Offset: 0x708
// Size: 0x4c
function function_f593f079(slot, weapon) {
    self clientfield::set("armor_status", 0);
    self.var_5f5848a3 = slot;
    self.var_f3bad013 = weapon;
}

// Namespace armor
// Params 2, eflags: 0x1 linked
// namespace_5e52c0f2<file_0>::function_c03e583
// Checksum 0xa874831f, Offset: 0x760
// Size: 0x34
function function_c03e583(slot, weapon) {
    self function_ef8f7527(slot, weapon);
}

// Namespace armor
// Params 0, eflags: 0x1 linked
// namespace_5e52c0f2<file_0>::function_362bc1a8
// Checksum 0x99ec1590, Offset: 0x7a0
// Size: 0x4
function function_362bc1a8() {
    
}

// Namespace armor
// Params 2, eflags: 0x1 linked
// namespace_5e52c0f2<file_0>::function_27d2ab93
// Checksum 0x3850d83c, Offset: 0x7b0
// Size: 0xec
function function_27d2ab93(slot, weapon) {
    if (isalive(self)) {
        self flagsys::set("gadget_armor_on");
        self.shock_onpain = 0;
        self.var_442c2e3d = isdefined(weapon.gadget_max_hitpoints) && weapon.gadget_max_hitpoints > 0 ? weapon.gadget_max_hitpoints : undefined;
        if (isdefined(self.overrideplayerdamage)) {
            self.var_6b5f7ec4 = self.overrideplayerdamage;
        }
        self.overrideplayerdamage = &function_37346b5a;
        self thread function_98b378e(slot, weapon);
    }
}

// Namespace armor
// Params 2, eflags: 0x1 linked
// namespace_5e52c0f2<file_0>::function_ef8f7527
// Checksum 0xf72bc618, Offset: 0x8a8
// Size: 0xf0
function function_ef8f7527(slot, weapon) {
    var_3ca1a1ad = flagsys::get("gadget_armor_on");
    self notify(#"hash_ef8f7527");
    self flagsys::clear("gadget_armor_on");
    self.shock_onpain = 1;
    self clientfield::set("armor_status", 0);
    if (isdefined(self.var_6b5f7ec4)) {
        self.overrideplayerdamage = self.var_6b5f7ec4;
        self.var_6b5f7ec4 = undefined;
    }
    if (var_3ca1a1ad && isalive(self) && isdefined(level.playgadgetsuccess)) {
        self [[ level.playgadgetsuccess ]](weapon);
    }
}

// Namespace armor
// Params 2, eflags: 0x1 linked
// namespace_5e52c0f2<file_0>::function_29961c34
// Checksum 0xfcda46fe, Offset: 0x9a0
// Size: 0xcc
function function_29961c34(slot, weapon) {
    self endon(#"disconnect");
    if (!self function_24782613(slot)) {
        return;
    }
    eventtime = self._gadgets_player[slot].gadget_flickertime;
    self function_39b1b87b("Flickering", eventtime);
    while (true) {
        if (!self gadgetflickering(slot)) {
            self function_39b1b87b("Normal");
            return;
        }
        wait(0.5);
    }
}

// Namespace armor
// Params 2, eflags: 0x1 linked
// namespace_5e52c0f2<file_0>::function_39b1b87b
// Checksum 0x111dc023, Offset: 0xa78
// Size: 0x9c
function function_39b1b87b(status, time) {
    timestr = "";
    if (isdefined(time)) {
        timestr = "^3" + ", time: " + time;
    }
    if (getdvarint("scr_cpower_debug_prints") > 0) {
        self iprintlnbold("Gadget Armor: " + status + timestr);
    }
}

// Namespace armor
// Params 1, eflags: 0x1 linked
// namespace_5e52c0f2<file_0>::function_46ec01fd
// Checksum 0xedae2673, Offset: 0xb20
// Size: 0x15a
function function_46ec01fd(smeansofdeath) {
    switch (smeansofdeath) {
    case 20:
    case 21:
    case 23:
    case 26:
    case 33:
    case 34:
        return 0;
    case 30:
        return getdvarfloat("scr_armor_mod_proj_mult", 1);
    case 27:
    case 28:
        return getdvarfloat("scr_armor_mod_melee_mult", 2);
    case 22:
    case 24:
    case 25:
    case 31:
        return getdvarfloat("scr_armor_mod_expl_mult", 1);
    case 29:
    case 32:
        return getdvarfloat("scr_armor_mod_bullet_mult", 0.7);
    case 19:
    case 35:
    case 36:
    default:
        return getdvarfloat("scr_armor_mod_misc_mult", 1);
    }
}

// Namespace armor
// Params 2, eflags: 0x1 linked
// namespace_5e52c0f2<file_0>::function_db3ccbce
// Checksum 0xfda1f5b7, Offset: 0xc88
// Size: 0x8a
function function_db3ccbce(weapon, smeansofdeath) {
    switch (weapon.name) {
    case 37:
    case 38:
        return false;
    default:
        break;
    }
    switch (smeansofdeath) {
    case 19:
    case 20:
    case 21:
    case 22:
    case 23:
    case 24:
    case 25:
    case 26:
    case 27:
    case 28:
    case 31:
    case 33:
    case 34:
    case 35:
    case 36:
        return false;
    case 29:
    case 32:
        return true;
    case 30:
        if (weapon.explosionradius == 0) {
            return true;
        }
        return false;
    default:
        return false;
    }
}

// Namespace armor
// Params 4, eflags: 0x1 linked
// namespace_5e52c0f2<file_0>::function_4a835afe
// Checksum 0x935fd1f8, Offset: 0xdc0
// Size: 0x9c
function function_4a835afe(eattacker, weapon, smeansofdeath, shitloc) {
    if (isdefined(eattacker) && !weaponobjects::friendlyfirecheck(self, eattacker)) {
        return false;
    }
    if (!function_db3ccbce(weapon, smeansofdeath)) {
        return false;
    }
    if (shitloc == "head" || isdefined(shitloc) && shitloc == "helmet") {
        return false;
    }
    return true;
}

// Namespace armor
// Params 11, eflags: 0x1 linked
// namespace_5e52c0f2<file_0>::function_37346b5a
// Checksum 0x6bff7fcf, Offset: 0xe68
// Size: 0x2d0
function function_37346b5a(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime) {
    damage = idamage;
    self.power_armor_took_damage = 0;
    if (self function_4a835afe(eattacker, weapon, smeansofdeath, shitloc) && isdefined(self.var_5f5848a3)) {
        self clientfield::set_to_player("player_damage_type", 1);
        if (self function_24782613(self.var_5f5848a3)) {
            armor_damage = damage * function_46ec01fd(smeansofdeath);
            damage = 0;
            if (armor_damage > 0) {
                if (isdefined(self.var_442c2e3d)) {
                    var_7f37e5f2 = self.var_442c2e3d;
                } else {
                    var_7f37e5f2 = self gadgetpowerchange(self.var_5f5848a3, 0);
                }
                if (weapon == level.weaponlightninggun || weapon == level.weaponlightninggunarc) {
                    armor_damage = var_7f37e5f2;
                } else if (var_7f37e5f2 < armor_damage) {
                    damage = armor_damage - var_7f37e5f2;
                }
                if (isdefined(self.var_442c2e3d)) {
                    self function_edc0b538(armor_damage);
                } else {
                    self ability_power::power_loss_event(self.var_5f5848a3, eattacker, armor_damage, "armor damage");
                }
                self.power_armor_took_damage = 1;
                self.power_armor_last_took_damage_time = gettime();
                self addtodamageindicator(int(armor_damage * getdvarfloat("scr_armor_mod_view_kick_mult", 0.001)), vdir);
            }
        } else {
            self clientfield::set_to_player("player_damage_type", 0);
        }
    } else {
        self clientfield::set_to_player("player_damage_type", 0);
    }
    return damage;
}

// Namespace armor
// Params 1, eflags: 0x1 linked
// namespace_5e52c0f2<file_0>::function_edc0b538
// Checksum 0x5e2682ff, Offset: 0x1140
// Size: 0x2c
function function_edc0b538(val) {
    if (val > 0) {
        self.var_442c2e3d -= val;
    }
}

// Namespace armor
// Params 2, eflags: 0x1 linked
// namespace_5e52c0f2<file_0>::function_98b378e
// Checksum 0x6a14ee13, Offset: 0x1178
// Size: 0x20c
function function_98b378e(slot, weapon) {
    self endon(#"disconnect");
    var_3eea3245 = isdefined(weapon.gadget_max_hitpoints) && weapon.gadget_max_hitpoints > 0 ? weapon.gadget_max_hitpoints : 100;
    while (self flagsys::get("gadget_armor_on")) {
        if (isdefined(self.var_442c2e3d) && self.var_442c2e3d <= 0) {
            self playsoundtoplayer("wpn_power_armor_destroyed_plr", self);
            self playsoundtoallbutplayer("wpn_power_armor_destroyed_npc", self);
            self gadgetdeactivate(slot, weapon);
            self gadgetpowerset(slot, 0);
            break;
        }
        if (isdefined(self.var_442c2e3d)) {
            var_73c6f93e = self.var_442c2e3d / var_3eea3245;
        } else {
            var_73c6f93e = self gadgetpowerchange(self.var_5f5848a3, 0) / var_3eea3245;
        }
        stage = 1 + int(var_73c6f93e * 5);
        if (stage > 5) {
            stage = 5;
        }
        self clientfield::set("armor_status", stage);
        wait(0.05);
    }
    self clientfield::set("armor_status", 0);
}

