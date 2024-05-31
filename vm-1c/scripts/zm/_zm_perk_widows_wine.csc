#using scripts/zm/_zm_powerup_ww_grenade;
#using scripts/zm/_zm_perks;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_perk_widows_wine;

// Namespace zm_perk_widows_wine
// Params 0, eflags: 0x2
// namespace_21f2cb7f<file_0>::function_2dc19561
// Checksum 0x95c9efcf, Offset: 0x2d8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_perk_widows_wine", &__init__, undefined, undefined);
}

// Namespace zm_perk_widows_wine
// Params 0, eflags: 0x1 linked
// namespace_21f2cb7f<file_0>::function_8c87d8eb
// Checksum 0x42b776b7, Offset: 0x318
// Size: 0xcc
function __init__() {
    zm_perks::register_perk_clientfields("specialty_widowswine", &widows_wine_client_field_func, &widows_wine_code_callback_func);
    zm_perks::register_perk_effects("specialty_widowswine", "widow_light");
    zm_perks::register_perk_init_thread("specialty_widowswine", &init_widows_wine);
    clientfield::register("toplayer", "widows_wine_1p_contact_explosion", 1, 1, "counter", &function_bb108b89, 0, 0);
}

// Namespace zm_perk_widows_wine
// Params 0, eflags: 0x1 linked
// namespace_21f2cb7f<file_0>::function_28504119
// Checksum 0x6d7c4be6, Offset: 0x3f0
// Size: 0x52
function init_widows_wine() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect["widow_light"] = "zombie/fx_perk_widows_wine_zmb";
        level._effect["widows_wine_wrap"] = "zombie/fx_widows_wrap_torso_zmb";
    }
}

// Namespace zm_perk_widows_wine
// Params 0, eflags: 0x1 linked
// namespace_21f2cb7f<file_0>::function_a8110ee4
// Checksum 0xfc8467a9, Offset: 0x450
// Size: 0xcc
function widows_wine_client_field_func() {
    clientfield::register("clientuimodel", "hudItems.perks.widows_wine", 1, 2, "int", undefined, 0, 1);
    clientfield::register("actor", "widows_wine_wrapping", 1, 1, "int", &function_c48acb49, 0, 1);
    clientfield::register("vehicle", "widows_wine_wrapping", 1, 1, "int", &function_c48acb49, 0, 0);
}

// Namespace zm_perk_widows_wine
// Params 0, eflags: 0x1 linked
// namespace_21f2cb7f<file_0>::function_a8dd76a3
// Checksum 0x99ec1590, Offset: 0x528
// Size: 0x4
function widows_wine_code_callback_func() {
    
}

// Namespace zm_perk_widows_wine
// Params 7, eflags: 0x1 linked
// namespace_21f2cb7f<file_0>::function_c48acb49
// Checksum 0x9f6e86a5, Offset: 0x538
// Size: 0x194
function function_c48acb49(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (isdefined(self) && isalive(self)) {
            if (!isdefined(self.var_7fcb88c0)) {
                self.var_7fcb88c0 = playfxontag(localclientnum, level._effect["widows_wine_wrap"], self, "j_spineupper");
            }
            if (!isdefined(self.sndwidowswine)) {
                self playsound(0, "wpn_wwgrenade_cocoon_imp");
                self.sndwidowswine = self playloopsound("wpn_wwgrenade_cocoon_lp", 0.1);
            }
        }
        return;
    }
    if (isdefined(self.var_7fcb88c0)) {
        stopfx(localclientnum, self.var_7fcb88c0);
        self.var_7fcb88c0 = undefined;
    }
    if (isdefined(self.sndwidowswine)) {
        self playsound(0, "wpn_wwgrenade_cocoon_stop");
        self stoploopsound(self.sndwidowswine, 0.1);
    }
}

// Namespace zm_perk_widows_wine
// Params 7, eflags: 0x1 linked
// namespace_21f2cb7f<file_0>::function_bb108b89
// Checksum 0x6b737327, Offset: 0x6d8
// Size: 0x9c
function function_bb108b89(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    owner = self getowner(localclientnum);
    if (isdefined(owner) && owner == getlocalplayer(localclientnum)) {
        thread function_617a36aa(localclientnum);
    }
}

// Namespace zm_perk_widows_wine
// Params 1, eflags: 0x1 linked
// namespace_21f2cb7f<file_0>::function_617a36aa
// Checksum 0x2c27dd78, Offset: 0x780
// Size: 0xbc
function function_617a36aa(localclientnum) {
    tag = "tag_flash";
    if (!viewmodelhastag(localclientnum, tag)) {
        tag = "tag_weapon";
        if (!viewmodelhastag(localclientnum, tag)) {
            return;
        }
    }
    var_3d48c982 = playviewmodelfx(localclientnum, "zombie/fx_widows_exp_1p_zmb", tag);
    wait(2);
    deletefx(localclientnum, var_3d48c982, 1);
}

