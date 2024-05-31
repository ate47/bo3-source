#using scripts/zm/craftables/_zm_craftables;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_48e6dffb;

// Namespace namespace_48e6dffb
// Params 0, eflags: 0x1 linked
// Checksum 0x57e55c70, Offset: 0x4d0
// Size: 0x494
function init() {
    clientfield::register("clientuimodel", "zmInventory.widget_bucket_parts", 9000, 1, "int");
    clientfield::register("toplayer", "bucket_held", 9000, getminbitcountfornum(2), "int");
    clientfield::register("toplayer", "bucket_bucket_type", 9000, getminbitcountfornum(2), "int");
    clientfield::register("toplayer", "bucket_bucket_water_type", 9000, getminbitcountfornum(3), "int");
    clientfield::register("toplayer", "bucket_bucket_water_level", 9000, getminbitcountfornum(3), "int");
    clientfield::register("clientuimodel", "zmInventory.widget_skull_parts", 9000, 1, "int");
    clientfield::register("toplayer", "skull_skull_state", 9000, getminbitcountfornum(3), "int");
    clientfield::register("toplayer", "skull_skull_type", 9000, getminbitcountfornum(3), "int");
    clientfield::register("clientuimodel", "zmInventory.widget_gasmask_parts", 9000, 1, "int");
    clientfield::register("toplayer", "gaskmask_part_visor", 9000, 1, "int");
    clientfield::register("toplayer", "gaskmask_part_strap", 9000, 1, "int");
    clientfield::register("toplayer", "gaskmask_part_filter", 9000, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.gaskmask_gasmask_active", 9000, 1, "int");
    clientfield::register("toplayer", "gaskmask_gasmask_progress", 9000, getminbitcountfornum(10), "int");
    clientfield::register("clientuimodel", "zmInventory.widget_machinetools_parts", 9000, 1, "int");
    clientfield::register("toplayer", "valveone_part_lever", 9000, 1, "int");
    clientfield::register("toplayer", "valvetwo_part_lever", 9000, 1, "int");
    clientfield::register("toplayer", "valvethree_part_lever", 9000, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.widget_wonderweapon_parts", 9000, 1, "int");
    clientfield::register("toplayer", "wonderweapon_part_wwi", 9000, 1, "int");
    clientfield::register("toplayer", "wonderweapon_part_wwii", 9000, 1, "int");
    clientfield::register("toplayer", "wonderweapon_part_wwiii", 9000, 1, "int");
}

// Namespace namespace_48e6dffb
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x970
// Size: 0x4
function main() {
    
}

// Namespace namespace_48e6dffb
// Params 0, eflags: 0x1 linked
// Checksum 0x5e3951e9, Offset: 0x980
// Size: 0x166
function function_1a9a4375() {
    self endon(#"disconnect");
    self.var_df4182b1 = 0;
    self.var_4d1c77e5 = 0;
    while (true) {
        self waittill(#"hash_b5ecf1dd");
        self thread function_2cc6bcea();
        self playsoundtoplayer("zmb_gasmask_pickup", self);
        self thread function_8801a9c5();
        var_ba18d83c = 10;
        self thread namespace_f37770c8::function_97be99b3(undefined, "zmInventory.gaskmask_gasmask_active", 0);
        self clientfield::set_to_player("gaskmask_gasmask_progress", var_ba18d83c);
        while (isdefined(self.var_df4182b1) && self.var_df4182b1 && var_ba18d83c > 0) {
            self waittill(#"hash_b56a74a8");
            self playsoundtoplayer("zmb_gasmask_use", self);
            var_ba18d83c -= 1;
            self thread function_6649823b(var_ba18d83c);
            wait(1);
        }
        self notify(#"hash_7cbf7e55");
    }
}

// Namespace namespace_48e6dffb
// Params 0, eflags: 0x1 linked
// Checksum 0x26b41f7f, Offset: 0xaf0
// Size: 0x170
function function_2cc6bcea() {
    self endon(#"disconnect");
    mdl_body = self getcharacterbodymodel();
    switch (mdl_body) {
    case 32:
        str_character = "nikolai";
        break;
    case 31:
        str_character = "dempsey";
        break;
    case 33:
        str_character = "richtofen";
        break;
    case 34:
        str_character = "takeo";
        break;
    }
    if (!(isdefined(self.var_4d1c77e5) && self.var_4d1c77e5)) {
        self attach("c_zom_dlc2_" + str_character + "_head_gasmask");
        self.var_4d1c77e5 = 1;
    }
    self util::waittill_any("disconnect", "death", "player_lost_gasmask");
    if (isdefined(self.var_4d1c77e5) && self.var_4d1c77e5) {
        self detach("c_zom_dlc2_" + str_character + "_head_gasmask");
        self.var_4d1c77e5 = 0;
    }
}

// Namespace namespace_48e6dffb
// Params 1, eflags: 0x1 linked
// Checksum 0xa8424f3f, Offset: 0xc68
// Size: 0x9c
function function_6649823b(var_ba18d83c) {
    self notify(#"hash_cc68cc91");
    self endon(#"death");
    self endon(#"hash_cc68cc91");
    self clientfield::set_player_uimodel("zmInventory.gaskmask_gasmask_active", 1);
    self clientfield::set_to_player("gaskmask_gasmask_progress", var_ba18d83c);
    self waittill(#"hash_dd8e5266");
    self thread clientfield::set_player_uimodel("zmInventory.gaskmask_gasmask_active", 0);
}

// Namespace namespace_48e6dffb
// Params 0, eflags: 0x1 linked
// Checksum 0x87bd9d5, Offset: 0xd10
// Size: 0x60
function function_8801a9c5() {
    self endon(#"disconnect");
    self util::waittill_any("death", "player_lost_gasmask");
    self playsoundtoplayer("zmb_gasmask_break", self);
    self.var_df4182b1 = 0;
}

