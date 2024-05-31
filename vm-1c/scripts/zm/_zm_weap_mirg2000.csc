#using scripts/zm/_zm_weapons;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_7cee2b44;

// Namespace namespace_7cee2b44
// Params 0, eflags: 0x2
// namespace_7cee2b44<file_0>::function_2dc19561
// Checksum 0xea92be10, Offset: 0x4d8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("mirg2000", &__init__, undefined, undefined);
}

// Namespace namespace_7cee2b44
// Params 0, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_8c87d8eb
// Checksum 0x536a33d7, Offset: 0x518
// Size: 0x2da
function __init__() {
    clientfield::register("scriptmover", "plant_killer", 9000, getminbitcountfornum(4), "int", &function_23a70949, 0, 0);
    clientfield::register("vehicle", "mirg2000_spider_death_fx", 9000, 2, "int", &function_1d3d9723, 0, 0);
    clientfield::register("actor", "mirg2000_enemy_impact_fx", 9000, 2, "int", &function_15ad909d, 0, 0);
    clientfield::register("vehicle", "mirg2000_enemy_impact_fx", 9000, 2, "int", &function_15ad909d, 0, 0);
    clientfield::register("allplayers", "mirg2000_fire_button_held_sound", 9000, 1, "int", &function_4c2164f8, 0, 0);
    clientfield::register("toplayer", "mirg2000_charge_glow", 9000, 2, "int", &function_877c3ed1, 0, 0);
    level._effect["mirg2000_charged_shot_1"] = "dlc2/zmb_weapon/fx_mirg_impact_aoe_chrg2";
    level._effect["mirg2000_charged_shot_2"] = "dlc2/zmb_weapon/fx_mirg_impact_aoe_chrg3";
    level._effect["mirg2000_charged_shot_1_up"] = "dlc2/zmb_weapon/fx_mirg_impact_aoe_chrg2_ug";
    level._effect["mirg2000_charged_shot_2_up"] = "dlc2/zmb_weapon/fx_mirg_impact_aoe_chrg3_ug";
    level._effect["mirg2000_spider_death_fx"] = "dlc2/island/fx_spider_death_explo_mirg";
    level._effect["mirg2000_spider_death_fx_up"] = "dlc2/island/fx_spider_death_explo_mirg_ug";
    level._effect["mirg2000_enemy_impact"] = "dlc2/zmb_weapon/fx_mirg_impact_explo_default";
    level._effect["mirg2000_enemy_impact_up"] = "dlc2/zmb_weapon/fx_mirg_impact_explo_ug";
    level._effect["mirg2000_glow"] = "dlc2/zmb_weapon/fx_mirg_weapon_canister_light_green";
    level._effect["mirg2000_glow_up"] = "dlc2/zmb_weapon/fx_mirg_weapon_canister_light_blue";
}

// Namespace namespace_7cee2b44
// Params 7, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_23a70949
// Checksum 0x5f993857, Offset: 0x800
// Size: 0x1de
function function_23a70949(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 0:
        if (isdefined(self.var_b5dfc765)) {
            stopfx(localclientnum, self.var_b5dfc765);
        }
        break;
    case 1:
        self.var_b5dfc765 = playfxontag(localclientnum, level._effect["mirg2000_charged_shot_1"], self, "tag_origin");
        break;
    case 2:
        self.var_b5dfc765 = playfxontag(localclientnum, level._effect["mirg2000_charged_shot_2"], self, "tag_origin");
        break;
    case 3:
        self.var_b5dfc765 = playfxontag(localclientnum, level._effect["mirg2000_charged_shot_1_up"], self, "tag_origin");
        break;
    case 4:
        self.var_b5dfc765 = playfxontag(localclientnum, level._effect["mirg2000_charged_shot_2_up"], self, "tag_origin");
        break;
    default:
        if (isdefined(self.var_b5dfc765)) {
            stopfx(localclientnum, self.var_b5dfc765);
        }
        break;
    }
}

// Namespace namespace_7cee2b44
// Params 7, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_15ad909d
// Checksum 0xa6e33b24, Offset: 0x9e8
// Size: 0xbc
function function_15ad909d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 2) {
        playfxontag(localclientnum, level._effect["mirg2000_enemy_impact_up"], self, "J_SpineUpper");
        return;
    }
    if (newval == 1) {
        playfxontag(localclientnum, level._effect["mirg2000_enemy_impact"], self, "J_SpineUpper");
    }
}

// Namespace namespace_7cee2b44
// Params 7, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_1d3d9723
// Checksum 0xfe84fcff, Offset: 0xab0
// Size: 0xbc
function function_1d3d9723(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 2) {
        playfxontag(localclientnum, level._effect["mirg2000_spider_death_fx_up"], self, "tag_origin");
        return;
    }
    if (newval == 1) {
        playfxontag(localclientnum, level._effect["mirg2000_spider_death_fx"], self, "tag_origin");
    }
}

// Namespace namespace_7cee2b44
// Params 7, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_4c2164f8
// Checksum 0xe0f014d9, Offset: 0xb78
// Size: 0xce
function function_4c2164f8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (!isdefined(self.var_c56da363)) {
            self.var_c56da363 = self playloopsound("wpn_mirg2k_hold_lp", 1.25);
        }
        return;
    }
    if (newval == 0) {
        if (isdefined(self.var_c56da363)) {
            self stoploopsound(self.var_c56da363, 0.1);
            self.var_c56da363 = undefined;
        }
    }
}

// Namespace namespace_7cee2b44
// Params 7, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_877c3ed1
// Checksum 0xf8d3e9ce, Offset: 0xc50
// Size: 0x1b6
function function_877c3ed1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    w_current = getcurrentweapon(localclientnum);
    str_weapon_name = w_current.name;
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, newval, 0);
    if (str_weapon_name == "hero_mirg2000_upgraded" || newval != 3 && str_weapon_name == "hero_mirg2000") {
        if (str_weapon_name == "hero_mirg2000_upgraded") {
            if (!isdefined(self.var_cdc68d78)) {
                self.var_cdc68d78 = playviewmodelfx(localclientnum, level._effect["mirg2000_glow_up"], "tag_liquid");
            }
        } else if (!isdefined(self.var_cdc68d78)) {
            self.var_cdc68d78 = playviewmodelfx(localclientnum, level._effect["mirg2000_glow"], "tag_liquid");
        }
        return;
    }
    if (isdefined(self.var_cdc68d78)) {
        stopfx(localclientnum, self.var_cdc68d78);
        self.var_cdc68d78 = undefined;
    }
}

