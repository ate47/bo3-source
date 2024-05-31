#using scripts/zm/_zm_perks;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_perk_electric_cherry;

// Namespace zm_perk_electric_cherry
// Params 0, eflags: 0x2
// namespace_a7884d63<file_0>::function_2dc19561
// Checksum 0x11ddf0bf, Offset: 0x380
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_perk_electric_cherry", &__init__, undefined, undefined);
}

// Namespace zm_perk_electric_cherry
// Params 0, eflags: 0x1 linked
// namespace_a7884d63<file_0>::function_8c87d8eb
// Checksum 0xa481624, Offset: 0x3c0
// Size: 0x84
function __init__() {
    zm_perks::register_perk_clientfields("specialty_electriccherry", &electric_cherry_client_field_func, &electric_cherry_code_callback_func);
    zm_perks::register_perk_effects("specialty_electriccherry", "electric_light");
    zm_perks::register_perk_init_thread("specialty_electriccherry", &init_electric_cherry);
}

// Namespace zm_perk_electric_cherry
// Params 0, eflags: 0x1 linked
// namespace_a7884d63<file_0>::function_fd67ecd
// Checksum 0x541947e0, Offset: 0x450
// Size: 0x226
function init_electric_cherry() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect["electric_light"] = "_t6/misc/fx_zombie_cola_revive_on";
    }
    registerclientfield("allplayers", "electric_cherry_reload_fx", 1, 2, "int", &electric_cherry_reload_attack_fx, 0);
    clientfield::register("actor", "tesla_death_fx", 1, 1, "int", &tesla_death_fx_callback, 0, 0);
    clientfield::register("vehicle", "tesla_death_fx_veh", 10000, 1, "int", &tesla_death_fx_callback, 0, 0);
    clientfield::register("actor", "tesla_shock_eyes_fx", 1, 1, "int", &tesla_shock_eyes_fx_callback, 0, 0);
    clientfield::register("vehicle", "tesla_shock_eyes_fx_veh", 10000, 1, "int", &tesla_shock_eyes_fx_callback, 0, 0);
    level._effect["electric_cherry_explode"] = "dlc1/castle/fx_castle_electric_cherry_down";
    level._effect["electric_cherry_trail"] = "dlc1/castle/fx_castle_electric_cherry_trail";
    level._effect["tesla_death_cherry"] = "zombie/fx_tesla_shock_zmb";
    level._effect["tesla_shock_eyes_cherry"] = "zombie/fx_tesla_shock_eyes_zmb";
    level._effect["tesla_shock_cherry"] = "zombie/fx_bmode_shock_os_zod_zmb";
}

// Namespace zm_perk_electric_cherry
// Params 0, eflags: 0x1 linked
// namespace_a7884d63<file_0>::function_f3ab8914
// Checksum 0x29b49cc9, Offset: 0x680
// Size: 0x3c
function electric_cherry_client_field_func() {
    clientfield::register("clientuimodel", "hudItems.perks.electric_cherry", 1, 2, "int", undefined, 0, 1);
}

// Namespace zm_perk_electric_cherry
// Params 0, eflags: 0x1 linked
// namespace_a7884d63<file_0>::function_8eb471d3
// Checksum 0x99ec1590, Offset: 0x6c8
// Size: 0x4
function electric_cherry_code_callback_func() {
    
}

// Namespace zm_perk_electric_cherry
// Params 7, eflags: 0x1 linked
// namespace_a7884d63<file_0>::function_d3aeb08
// Checksum 0x32a16dd, Offset: 0x6d8
// Size: 0x176
function electric_cherry_reload_attack_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.electric_cherry_reload_fx)) {
        stopfx(localclientnum, self.electric_cherry_reload_fx);
    }
    if (newval == 1) {
        self.electric_cherry_reload_fx = playfxontag(localclientnum, level._effect["electric_cherry_explode"], self, "tag_origin");
        return;
    }
    if (newval == 2) {
        self.electric_cherry_reload_fx = playfxontag(localclientnum, level._effect["electric_cherry_explode"], self, "tag_origin");
        return;
    }
    if (newval == 3) {
        self.electric_cherry_reload_fx = playfxontag(localclientnum, level._effect["electric_cherry_explode"], self, "tag_origin");
        return;
    }
    if (isdefined(self.electric_cherry_reload_fx)) {
        stopfx(localclientnum, self.electric_cherry_reload_fx);
    }
    self.electric_cherry_reload_fx = undefined;
}

// Namespace zm_perk_electric_cherry
// Params 7, eflags: 0x1 linked
// namespace_a7884d63<file_0>::function_98fcc024
// Checksum 0x3bc169, Offset: 0x858
// Size: 0x12e
function tesla_death_fx_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        str_tag = "J_SpineUpper";
        if (isdefined(self.str_tag_tesla_death_fx)) {
            str_tag = self.str_tag_tesla_death_fx;
        } else if (isdefined(self.isdog) && self.isdog) {
            str_tag = "J_Spine1";
        }
        self.n_death_fx = playfxontag(localclientnum, level._effect["tesla_death_cherry"], self, str_tag);
        setfxignorepause(localclientnum, self.n_death_fx, 1);
        return;
    }
    if (isdefined(self.n_death_fx)) {
        deletefx(localclientnum, self.n_death_fx, 1);
    }
    self.n_death_fx = undefined;
}

// Namespace zm_perk_electric_cherry
// Params 7, eflags: 0x1 linked
// namespace_a7884d63<file_0>::function_6f5d566b
// Checksum 0xde9efe6d, Offset: 0x990
// Size: 0x1c6
function tesla_shock_eyes_fx_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        str_tag = "J_SpineUpper";
        if (isdefined(self.str_tag_tesla_shock_eyes_fx)) {
            str_tag = self.str_tag_tesla_shock_eyes_fx;
        } else if (isdefined(self.isdog) && self.isdog) {
            str_tag = "J_Spine1";
        }
        self.n_shock_eyes_fx = playfxontag(localclientnum, level._effect["tesla_shock_eyes_cherry"], self, "J_Eyeball_LE");
        setfxignorepause(localclientnum, self.n_shock_eyes_fx, 1);
        self.n_shock_fx = playfxontag(localclientnum, level._effect["tesla_death_cherry"], self, str_tag);
        setfxignorepause(localclientnum, self.n_shock_fx, 1);
        return;
    }
    if (isdefined(self.n_shock_eyes_fx)) {
        deletefx(localclientnum, self.n_shock_eyes_fx, 1);
        self.n_shock_eyes_fx = undefined;
    }
    if (isdefined(self.n_shock_fx)) {
        deletefx(localclientnum, self.n_shock_fx, 1);
        self.n_shock_fx = undefined;
    }
}

