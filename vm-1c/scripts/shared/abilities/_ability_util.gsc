#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;

#namespace ability_util;

// Namespace ability_util
// Params 2, eflags: 0x1 linked
// namespace_2bd142f8<file_0>::function_9a857717
// Checksum 0xed0af001, Offset: 0x140
// Size: 0x48
function gadget_is_type(slot, type) {
    if (!isdefined(self._gadgets_player[slot])) {
        return false;
    }
    return self._gadgets_player[slot].gadget_type == type;
}

// Namespace ability_util
// Params 1, eflags: 0x1 linked
// namespace_2bd142f8<file_0>::function_4387ab03
// Checksum 0xd401017c, Offset: 0x190
// Size: 0x76
function gadget_slot_for_type(type) {
    invalid = 3;
    for (i = 0; i < 3; i++) {
        if (!self gadget_is_type(i, type)) {
            continue;
        }
        return i;
    }
    return invalid;
}

// Namespace ability_util
// Params 0, eflags: 0x1 linked
// namespace_2bd142f8<file_0>::function_7bf047db
// Checksum 0xd45622ec, Offset: 0x210
// Size: 0x1a
function function_7bf047db() {
    return gadget_is_active(2);
}

// Namespace ability_util
// Params 0, eflags: 0x1 linked
// namespace_2bd142f8<file_0>::function_6f20bf82
// Checksum 0xb1ee0ab7, Offset: 0x238
// Size: 0x1a
function gadget_combat_efficiency_enabled() {
    if (isdefined(self._gadget_combat_efficiency)) {
        return self._gadget_combat_efficiency;
    }
    return 0;
}

// Namespace ability_util
// Params 1, eflags: 0x1 linked
// namespace_2bd142f8<file_0>::function_39c85e49
// Checksum 0xe3faf6fd, Offset: 0x260
// Size: 0x94
function gadget_combat_efficiency_power_drain(score) {
    powerchange = -1 * score * getdvarfloat("scr_combat_efficiency_power_loss_scalar", 0.275);
    slot = gadget_slot_for_type(15);
    if (slot != 3) {
        self gadgetpowerchange(slot, powerchange);
    }
}

// Namespace ability_util
// Params 0, eflags: 0x0
// namespace_2bd142f8<file_0>::function_625fb64c
// Checksum 0x138bf8a8, Offset: 0x300
// Size: 0x66
function function_625fb64c() {
    slot = self gadget_slot_for_type(2);
    if (slot >= 0 && slot < 3) {
        if (self ability_player::gadget_is_flickering(slot)) {
            return true;
        }
    }
    return false;
}

// Namespace ability_util
// Params 0, eflags: 0x0
// namespace_2bd142f8<file_0>::function_db4e8ae0
// Checksum 0xbf190db7, Offset: 0x370
// Size: 0x1a
function function_db4e8ae0() {
    return gadget_is_active(5);
}

// Namespace ability_util
// Params 1, eflags: 0x0
// namespace_2bd142f8<file_0>::function_771465b7
// Checksum 0xd5cda0dc, Offset: 0x398
// Size: 0x92
function is_weapon_gadget(weapon) {
    foreach (var_493ae09d, var_1ca59e0d in level._gadgets_level) {
        if (var_493ae09d == weapon) {
            return true;
        }
    }
    return false;
}

// Namespace ability_util
// Params 1, eflags: 0x0
// namespace_2bd142f8<file_0>::function_4bdd0a0f
// Checksum 0xa6596205, Offset: 0x438
// Size: 0x84
function gadget_power_reset(gadgetweapon) {
    slot = self gadgetgetslot(gadgetweapon);
    if (slot >= 0 && slot < 3) {
        self gadgetpowerreset(slot);
        self gadgetcharging(slot, 1);
    }
}

// Namespace ability_util
// Params 4, eflags: 0x1 linked
// namespace_2bd142f8<file_0>::function_526c4bd
// Checksum 0xf48973f9, Offset: 0x4c8
// Size: 0x33c
function gadget_reset(gadgetweapon, changedclass, roundbased, firstround) {
    if (getdvarint("gadgetEnabled") == 0) {
        return;
    }
    slot = self gadgetgetslot(gadgetweapon);
    if (slot >= 0 && slot < 3) {
        if (isdefined(self.pers["held_gadgets_power"]) && isdefined(self.pers["held_gadgets_power"][gadgetweapon])) {
            self gadgetpowerset(slot, self.pers["held_gadgets_power"][gadgetweapon]);
        } else if (isdefined(self.pers["held_gadgets_power"]) && isdefined(self.pers[#"hash_c35f137f"]) && isdefined(self.pers["held_gadgets_power"][self.pers[#"hash_c35f137f"]])) {
            self gadgetpowerset(slot, self.pers["held_gadgets_power"][self.pers[#"hash_c35f137f"]]);
        } else if (isdefined(self.pers["held_gadgets_power"]) && isdefined(self.pers[#"hash_65987563"]) && isdefined(self.pers["held_gadgets_power"][self.pers[#"hash_65987563"]])) {
            self gadgetpowerset(slot, self.pers["held_gadgets_power"][self.pers[#"hash_65987563"]]);
        }
        resetonclasschange = changedclass && gadgetweapon.gadget_power_reset_on_class_change;
        resetonfirstround = !roundbased || !isdefined(self.firstspawn) && firstround;
        resetonroundswitch = !isdefined(self.firstspawn) && roundbased && !firstround && gadgetweapon.gadget_power_reset_on_round_switch;
        resetonteamchanged = isdefined(self.switchedteamsresetgadgets) && isdefined(self.firstspawn) && self.switchedteamsresetgadgets && gadgetweapon.gadget_power_reset_on_team_change;
        if (resetonclasschange || resetonfirstround || resetonroundswitch || resetonteamchanged) {
            self gadgetpowerreset(slot);
            self gadgetcharging(slot, 1);
        }
    }
}

// Namespace ability_util
// Params 0, eflags: 0x1 linked
// namespace_2bd142f8<file_0>::function_b3a94301
// Checksum 0xda8321d2, Offset: 0x810
// Size: 0x1a
function gadget_power_armor_on() {
    return gadget_is_active(4);
}

// Namespace ability_util
// Params 1, eflags: 0x1 linked
// namespace_2bd142f8<file_0>::function_4aa7ecdd
// Checksum 0x9807cfd6, Offset: 0x838
// Size: 0x6e
function gadget_is_active(gadgettype) {
    slot = self gadget_slot_for_type(gadgettype);
    if (slot >= 0 && slot < 3) {
        if (self ability_player::gadget_is_in_use(slot)) {
            return true;
        }
    }
    return false;
}

// Namespace ability_util
// Params 1, eflags: 0x0
// namespace_2bd142f8<file_0>::function_2dd89d87
// Checksum 0xe203e3a9, Offset: 0x8b0
// Size: 0x52
function gadget_has_type(gadgettype) {
    slot = self gadget_slot_for_type(gadgettype);
    if (slot >= 0 && slot < 3) {
        return true;
    }
    return false;
}

