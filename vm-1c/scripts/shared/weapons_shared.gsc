#using scripts/shared/weapons/_weapons;
#using scripts/shared/util_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/codescripts/struct;

#namespace weapons;

// Namespace weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xaa47fc6f, Offset: 0x148
// Size: 0x46
function is_primary_weapon(weapon) {
    root_weapon = weapon.rootweapon;
    return root_weapon != level.weaponnone && isdefined(level.primary_weapon_array[root_weapon]);
}

// Namespace weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xb598aac4, Offset: 0x198
// Size: 0x46
function is_side_arm(weapon) {
    root_weapon = weapon.rootweapon;
    return root_weapon != level.weaponnone && isdefined(level.side_arm_array[root_weapon]);
}

// Namespace weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xb2504e18, Offset: 0x1e8
// Size: 0x46
function is_inventory(weapon) {
    root_weapon = weapon.rootweapon;
    return root_weapon != level.weaponnone && isdefined(level.inventory_array[root_weapon]);
}

// Namespace weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xb59bada3, Offset: 0x238
// Size: 0x46
function is_grenade(weapon) {
    root_weapon = weapon.rootweapon;
    return root_weapon != level.weaponnone && isdefined(level.grenade_array[root_weapon]);
}

// Namespace weapons
// Params 0, eflags: 0x1 linked
// Checksum 0xc449641b, Offset: 0x288
// Size: 0x34
function force_stowed_weapon_update() {
    detach_all_weapons();
    stow_on_back();
    stow_on_hip();
}

// Namespace weapons
// Params 0, eflags: 0x1 linked
// Checksum 0xa387f0be, Offset: 0x2c8
// Size: 0x6e
function detach_carry_object_model() {
    if (isdefined(self.carryobject) && isdefined(self.carryobject gameobjects::get_visible_carrier_model())) {
        if (isdefined(self.tag_stowed_back)) {
            self detach(self.tag_stowed_back, "tag_stowed_back");
            self.tag_stowed_back = undefined;
        }
    }
}

// Namespace weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x84c9e58e, Offset: 0x340
// Size: 0x136
function detach_all_weapons() {
    if (isdefined(self.tag_stowed_back)) {
        clear_weapon = 1;
        if (isdefined(self.carryobject)) {
            carriermodel = self.carryobject gameobjects::get_visible_carrier_model();
            if (isdefined(carriermodel) && carriermodel == self.tag_stowed_back) {
                self detach(self.tag_stowed_back, "tag_stowed_back");
                clear_weapon = 0;
            }
        }
        if (clear_weapon) {
            self clearstowedweapon();
        }
        self.tag_stowed_back = undefined;
    } else {
        self clearstowedweapon();
    }
    if (isdefined(self.tag_stowed_hip)) {
        detach_model = self.tag_stowed_hip.worldmodel;
        self detach(detach_model, "tag_stowed_hip_rear");
        self.tag_stowed_hip = undefined;
    }
}

// Namespace weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xd8c6006e, Offset: 0x480
// Size: 0x1d4
function stow_on_back(current) {
    currentweapon = self getcurrentweapon();
    currentaltweapon = currentweapon.altweapon;
    self.tag_stowed_back = undefined;
    weaponoptions = 0;
    index_weapon = level.weaponnone;
    if (isdefined(self.carryobject) && isdefined(self.carryobject gameobjects::get_visible_carrier_model())) {
        self.tag_stowed_back = self.carryobject gameobjects::get_visible_carrier_model();
        self attach(self.tag_stowed_back, "tag_stowed_back", 1);
        return;
    } else if (currentweapon != level.weaponnone) {
        for (idx = 0; idx < self.weapon_array_primary.size; idx++) {
            temp_index_weapon = self.weapon_array_primary[idx];
            assert(isdefined(temp_index_weapon), "<dev string:x28>");
            if (temp_index_weapon == currentweapon) {
                continue;
            }
            if (temp_index_weapon == currentaltweapon) {
                continue;
            }
            if (temp_index_weapon.nonstowedweapon) {
                continue;
            }
            index_weapon = temp_index_weapon;
        }
    }
    self setstowedweapon(index_weapon);
}

// Namespace weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x255225ce, Offset: 0x660
// Size: 0xfc
function stow_on_hip() {
    currentweapon = self getcurrentweapon();
    self.tag_stowed_hip = undefined;
    for (idx = 0; idx < self.weapon_array_inventory.size; idx++) {
        if (self.weapon_array_inventory[idx] == currentweapon) {
            continue;
        }
        if (!self getweaponammostock(self.weapon_array_inventory[idx])) {
            continue;
        }
        self.tag_stowed_hip = self.weapon_array_inventory[idx];
    }
    if (!isdefined(self.tag_stowed_hip)) {
        return;
    }
    self attach(self.tag_stowed_hip.worldmodel, "tag_stowed_hip_rear", 1);
}

// Namespace weapons
// Params 4, eflags: 0x1 linked
// Checksum 0xc0d88eb3, Offset: 0x768
// Size: 0x62
function weapondamagetracepassed(from, to, startradius, ignore) {
    trace = weapondamagetrace(from, to, startradius, ignore);
    return trace["fraction"] == 1;
}

// Namespace weapons
// Params 4, eflags: 0x1 linked
// Checksum 0x5e48222d, Offset: 0x7d8
// Size: 0x1e0
function weapondamagetrace(from, to, startradius, ignore) {
    midpos = undefined;
    diff = to - from;
    if (lengthsquared(diff) < startradius * startradius) {
        midpos = to;
    }
    dir = vectornormalize(diff);
    midpos = from + (dir[0] * startradius, dir[1] * startradius, dir[2] * startradius);
    trace = bullettrace(midpos, to, 0, ignore);
    if (getdvarint("scr_damage_debug") != 0) {
        if (trace["fraction"] == 1) {
            thread debugline(midpos, to, (1, 1, 1));
        } else {
            thread debugline(midpos, trace["position"], (1, 0.9, 0.8));
            thread debugline(trace["position"], to, (1, 0.4, 0.3));
        }
    }
    return trace;
}

// Namespace weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x67a3fc62, Offset: 0x9c0
// Size: 0x40
function has_lmg() {
    weapon = self getcurrentweapon();
    return weapon.weapclass == "mg";
}

// Namespace weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x2a71f790, Offset: 0xa08
// Size: 0x36
function has_launcher() {
    weapon = self getcurrentweapon();
    return weapon.isrocketlauncher;
}

// Namespace weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x5595ce02, Offset: 0xa48
// Size: 0x3c
function has_hero_weapon() {
    weapon = self getcurrentweapon();
    return weapon.gadget_type == 14;
}

// Namespace weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xc42c8fb4, Offset: 0xa90
// Size: 0x6e
function has_lockon(target) {
    player = self;
    clientnum = player getentitynumber();
    return isdefined(target.locked_on) && target.locked_on & 1 << clientnum;
}

