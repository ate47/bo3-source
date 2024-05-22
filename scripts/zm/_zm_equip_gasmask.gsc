#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_equipment;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;

#namespace namespace_11fcf241;

// Namespace namespace_11fcf241
// Params 0, eflags: 0x2
// Checksum 0x6efafa2b, Offset: 0x2e8
// Size: 0x3c
function function_2dc19561() {
    system::register("zm_equip_gasmask", &__init__, &__main__, undefined);
}

// Namespace namespace_11fcf241
// Params 0, eflags: 0x0
// Checksum 0x66f61c76, Offset: 0x330
// Size: 0x12c
function __init__() {
    clientfield::register("toplayer", "gasmaskoverlay", 21000, 1, "int");
    clientfield::register("clientuimodel", "hudItems.showDpadDown_PES", 21000, 1, "int");
    zm_equipment::register("equip_gasmask", %ZOMBIE_EQUIP_GASMASK_PICKUP_HINT_STRING, %ZOMBIE_EQUIP_GASMASK_HOWTO, undefined, "gasmask");
    zm_equipment::register_slot_watcher_override("equip_gasmask", &function_7cb416b);
    visionset_mgr::register_info("overlay", "zm_gasmask_postfx", 21000, 501, 32, 1);
    callback::on_spawned(&on_player_spawned);
    level.var_f486078e = getweapon("equip_gasmask");
}

// Namespace namespace_11fcf241
// Params 0, eflags: 0x0
// Checksum 0x4c492b5e, Offset: 0x468
// Size: 0x4c
function __main__() {
    zm_equipment::register_for_level("equip_gasmask");
    zm_equipment::register_for_level("lower_equip_gasmask");
    zm_equipment::include("equip_gasmask");
}

// Namespace namespace_11fcf241
// Params 0, eflags: 0x0
// Checksum 0x743cba77, Offset: 0x4c0
// Size: 0xdc
function on_player_spawned() {
    self thread function_7cd9aa57();
    self thread function_ec63e67();
    self thread function_28d41431();
    self thread function_4933258e();
    self thread function_86a7986e();
    self clientfield::set_to_player("gasmaskoverlay", 0);
    visionset_mgr::deactivate("overlay", "zm_gasmask_postfx", self);
    self zm_equipment::set_equipment_invisibility_to_player(level.var_f486078e, 0);
}

// Namespace namespace_11fcf241
// Params 0, eflags: 0x0
// Checksum 0xc63e9c3d, Offset: 0x5a8
// Size: 0x160
function function_7cd9aa57() {
    self notify(#"hash_68b26c4c");
    self endon(#"hash_68b26c4c");
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"hash_5a02c845");
        if (isdefined(level.var_d244879e)) {
            ent_num = self.characterindex;
            if (isdefined(self.var_62030aa3)) {
                ent_num = self.var_62030aa3;
            }
            self [[ level.var_d244879e ]](ent_num);
        }
        if (isdefined(level.var_7d233af)) {
            ent_num = self.characterindex;
            if (isdefined(self.var_62030aa3)) {
                ent_num = self.var_62030aa3;
            }
            self [[ level.var_7d233af ]](ent_num);
        }
        self clientfield::set_player_uimodel("hudItems.showDpadDown_PES", 0);
        self clientfield::set_to_player("gasmaskoverlay", 0);
        visionset_mgr::deactivate("overlay", "zm_gasmask_postfx", self);
        level clientfield::set("player" + self getentitynumber() + "wearableItem", 0);
    }
}

// Namespace namespace_11fcf241
// Params 0, eflags: 0x0
// Checksum 0x3eeb0a44, Offset: 0x710
// Size: 0x4ee
function function_28d41431() {
    self endon(#"zombified");
    self endon(#"disconnect");
    self notify(#"hash_b0734faa");
    self endon(#"hash_b0734faa");
    var_f499fcb0 = getweapon("lower_equip_gasmask");
    if (isdefined(level.var_d244879e)) {
        ent_num = self.characterindex;
        self [[ level.var_d244879e ]](ent_num);
    }
    while (true) {
        str_notify = self util::waittill_any_return("equip_gasmask_activate", "equip_gasmask_deactivate", "disconnect");
        if (!self zm_equipment::has_player_equipment(level.var_f486078e)) {
            continue;
        }
        if (self zm_equipment::is_active(level.var_f486078e)) {
            self zm_utility::increment_is_drinking();
            self setactionslot(2, "");
            if (isdefined(level.var_b8c1e53d)) {
                ent_num = self.characterindex;
                if (isdefined(self.var_62030aa3)) {
                    ent_num = self.var_62030aa3;
                }
                self [[ level.var_b8c1e53d ]](ent_num, 1);
            }
            self clientfield::increment_to_player("gas_mask_on");
            self waittill(#"weapon_change_complete");
            level clientfield::set("player" + self getentitynumber() + "wearableItem", 1);
            self clientfield::set_to_player("gasmaskoverlay", 1);
            visionset_mgr::activate("overlay", "zm_gasmask_postfx", self);
        } else {
            self zm_utility::increment_is_drinking();
            self setactionslot(2, "");
            if (isdefined(level.var_b8c1e53d)) {
                ent_num = self.characterindex;
                if (isdefined(self.var_62030aa3)) {
                    ent_num = self.var_62030aa3;
                }
                self [[ level.var_b8c1e53d ]](ent_num, 0);
            }
            self takeweapon(level.var_f486078e);
            self giveweapon(var_f499fcb0);
            self switchtoweapon(var_f499fcb0);
            wait(0.05);
            self clientfield::set_to_player("gasmaskoverlay", 0);
            visionset_mgr::deactivate("overlay", "zm_gasmask_postfx", self);
            level clientfield::set("player" + self getentitynumber() + "wearableItem", 0);
            self waittill(#"weapon_change_complete");
            self takeweapon(var_f499fcb0);
            self giveweapon(level.var_f486078e);
        }
        if (!self laststand::player_is_in_laststand()) {
            if (self zm_utility::is_multiple_drinking()) {
                self zm_utility::decrement_is_drinking();
                self setactionslot(2, "weapon", level.var_f486078e);
                self notify(#"hash_62c1db37");
                continue;
            } else {
                self zm_weapons::switch_back_primary_weapon(self.prev_weapon_before_equipment_change);
            }
        }
        self setactionslot(2, "weapon", level.var_f486078e);
        if (!self laststand::player_is_in_laststand() && !(isdefined(self.intermission) && self.intermission)) {
            self zm_utility::decrement_is_drinking();
        }
        self notify(#"hash_62c1db37");
    }
}

// Namespace namespace_11fcf241
// Params 0, eflags: 0x0
// Checksum 0xa52ff89, Offset: 0xc08
// Size: 0xe8
function function_4933258e() {
    self notify(#"hash_17dade16");
    self endon(#"hash_17dade16");
    self endon(#"disconnect");
    while (true) {
        equipment = self waittill(#"player_given");
        if (equipment == level.var_f486078e) {
            self clientfield::set_player_uimodel("hudItems.showDpadDown_PES", 1);
        }
        if (isdefined(level.var_f04b2acd)) {
            ent_num = self.characterindex;
            if (isdefined(self.var_62030aa3)) {
                ent_num = self.var_62030aa3;
            }
            self [[ level.var_f04b2acd ]](ent_num);
            self clientfield::increment_to_player("gas_mask_buy");
        }
    }
}

// Namespace namespace_11fcf241
// Params 0, eflags: 0x0
// Checksum 0x10fd02fc, Offset: 0xcf8
// Size: 0xe0
function function_86a7986e() {
    self endon(#"disconnect");
    while (true) {
        self waittill(#"bled_out");
        self clientfield::set_player_uimodel("hudItems.showDpadDown_PES", 0);
        self clientfield::set_to_player("gasmaskoverlay", 0);
        visionset_mgr::deactivate("overlay", "zm_gasmask_postfx", self);
        level clientfield::set("player" + self getentitynumber() + "wearableItem", 0);
        self takeweapon(level.var_f486078e);
    }
}

// Namespace namespace_11fcf241
// Params 0, eflags: 0x0
// Checksum 0xd9eafe79, Offset: 0xde0
// Size: 0x64
function function_ec63e67() {
    self endon(#"hash_5a02c845");
    level waittill(#"pre_end_game");
    if (isdefined(self)) {
        self clientfield::set_to_player("gasmaskoverlay", 0);
        visionset_mgr::deactivate("overlay", "zm_gasmask_postfx", self);
    }
}

// Namespace namespace_11fcf241
// Params 0, eflags: 0x0
// Checksum 0x8c59d722, Offset: 0xe50
// Size: 0x22
function function_7dd87435() {
    return self zm_equipment::is_active(level.var_f486078e);
}

/#

    // Namespace namespace_11fcf241
    // Params 2, eflags: 0x0
    // Checksum 0x5c06f647, Offset: 0xe80
    // Size: 0x8c
    function function_6af10a60(msg, color) {
        if (!getdvarint("<unknown string>")) {
            return;
        }
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        print3d(self.origin + (0, 0, 60), msg, color, 1, 1, 40);
    }

#/

// Namespace namespace_11fcf241
// Params 4, eflags: 0x0
// Checksum 0x8a00934, Offset: 0xf18
// Size: 0xbc
function function_7cb416b(var_226f0a45, w_curr, var_d79c9dc0, str_notify) {
    if (w_curr == var_226f0a45) {
        if (self.current_equipment_active[var_226f0a45] == 1) {
            self notify(str_notify.deactivate);
            self.current_equipment_active[var_226f0a45] = 0;
        } else if (self.current_equipment_active[var_226f0a45] == 0) {
            self notify(str_notify.activate);
            self.current_equipment_active[var_226f0a45] = 1;
        }
        self waittill(#"hash_62c1db37");
    }
}

