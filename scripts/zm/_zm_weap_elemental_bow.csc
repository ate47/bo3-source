#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;

#namespace namespace_790026d5;

// Namespace namespace_790026d5
// Params 0, eflags: 0x2
// Checksum 0xa8d9c37c, Offset: 0x298
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("_zm_weap_elemental_bow", &__init__, undefined, undefined);
}

// Namespace namespace_790026d5
// Params 0, eflags: 0x0
// Checksum 0x5c540656, Offset: 0x2d8
// Size: 0x184
function __init__() {
    clientfield::register("toplayer", "elemental_bow" + "_ambient_bow_fx", 5000, 1, "int", &function_5b4bf635, 0, 0);
    clientfield::register("missile", "elemental_bow" + "_arrow_impact_fx", 5000, 1, "int", &function_4e8aa99, 0, 0);
    clientfield::register("missile", "elemental_bow4" + "_arrow_impact_fx", 5000, 1, "int", &function_bdaa35c, 0, 0);
    level._effect["elemental_bow_ambient_bow"] = "dlc1/zmb_weapon/fx_bow_default_ambient_1p_zmb";
    level._effect["elemental_bow_arrow_impact"] = "dlc1/zmb_weapon/fx_bow_default_impact_zmb";
    level._effect["elemental_bow_arrow_charged_impact"] = "dlc1/zmb_weapon/fx_bow_default_impact_ug_zmb";
    setdvar("bg_chargeShotUseOneAmmoForMultipleBullets", 0);
    setdvar("bg_zm_dlc1_chargeShotMultipleBulletsForFullCharge", 2);
}

// Namespace namespace_790026d5
// Params 7, eflags: 0x0
// Checksum 0xef15891c, Offset: 0x468
// Size: 0x64
function function_5b4bf635(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_3158b481(localclientnum, newval, "elemental_bow_ambient_bow");
}

// Namespace namespace_790026d5
// Params 7, eflags: 0x0
// Checksum 0x6df5b6aa, Offset: 0x4d8
// Size: 0x74
function function_4e8aa99(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfx(localclientnum, level._effect["elemental_bow_arrow_impact"], self.origin);
    }
}

// Namespace namespace_790026d5
// Params 7, eflags: 0x0
// Checksum 0x236441c4, Offset: 0x558
// Size: 0x74
function function_bdaa35c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfx(localclientnum, level._effect["elemental_bow_arrow_charged_impact"], self.origin);
    }
}

// Namespace namespace_790026d5
// Params 2, eflags: 0x0
// Checksum 0xa80cffbf, Offset: 0x5d8
// Size: 0xb2
function function_e5c5e30(localclientnum, str_fx_name) {
    if (isdefined(self.var_505704d9) && isdefined(self.var_505704d9[str_fx_name])) {
        deletefx(localclientnum, self.var_505704d9[str_fx_name], 1);
    }
    if (isdefined(self.var_a96110c3) && isdefined(self.var_a96110c3[str_fx_name])) {
        deletefx(localclientnum, self.var_a96110c3[str_fx_name], 1);
    }
    self notify(#"hash_74395f6a");
}

// Namespace namespace_790026d5
// Params 3, eflags: 0x0
// Checksum 0xdd9a91b9, Offset: 0x698
// Size: 0x144
function function_3158b481(localclientnum, newval, str_fx_name) {
    function_e5c5e30(localclientnum, str_fx_name);
    if (newval) {
        if (!isspectating(localclientnum)) {
            currentweapon = getcurrentweapon(localclientnum);
            if (issubstr(currentweapon.name, "elemental_bow")) {
                self.var_505704d9[str_fx_name] = playviewmodelfx(localclientnum, level._effect[str_fx_name], "tag_fx_02");
                self.var_a96110c3[str_fx_name] = playviewmodelfx(localclientnum, level._effect[str_fx_name], "tag_fx_03");
            }
        }
        if (isdemoplaying()) {
            self thread function_74395f6a(localclientnum, str_fx_name);
        }
    }
}

// Namespace namespace_790026d5
// Params 2, eflags: 0x0
// Checksum 0xf8f8fc47, Offset: 0x7e8
// Size: 0x7c
function function_74395f6a(localclientnum, str_fx_name) {
    self notify(#"hash_74395f6a");
    self endon(#"hash_74395f6a");
    lcn, var_fcf6978f, newplayer = level waittill(#"demo_plplayer_change");
    var_fcf6978f function_e5c5e30(localclientnum, str_fx_name);
}

