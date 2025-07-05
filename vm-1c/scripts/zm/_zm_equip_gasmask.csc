#using scripts/shared/clientfield_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_equipment;

#namespace zm_equip_gasmask;

// Namespace zm_equip_gasmask
// Params 0, eflags: 0x2
// Checksum 0x712e7161, Offset: 0x1d8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_equip_gasmask", &__init__, undefined, undefined);
}

// Namespace zm_equip_gasmask
// Params 0, eflags: 0x0
// Checksum 0xb327cc4b, Offset: 0x218
// Size: 0xcc
function __init__() {
    zm_equipment::include("equip_gasmask");
    clientfield::register("toplayer", "gasmaskoverlay", 21000, 1, "int", &function_9cee2510, 0, 0);
    clientfield::register("clientuimodel", "hudItems.showDpadDown_PES", 21000, 1, "int", undefined, 0, 0);
    visionset_mgr::register_overlay_info_style_postfx_bundle("zm_gasmask_postfx", 21000, 32, "pstfx_moon_helmet", 3);
}

// Namespace zm_equip_gasmask
// Params 7, eflags: 0x0
// Checksum 0xb643961, Offset: 0x2f0
// Size: 0x146
function function_9cee2510(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(level.localplayers[localclientnum]) && (!self islocalplayer() || isspectating(localclientnum, 0) || self getentitynumber() != level.localplayers[localclientnum] getentitynumber())) {
        return;
    }
    if (newval) {
        if (!isdefined(self.var_cf129735)) {
            self.var_cf129735 = self playloopsound("evt_gasmask_loop", 0.5);
        }
        return;
    }
    if (isdefined(self.var_cf129735)) {
        self stoploopsound(self.var_cf129735, 0.5);
        self.var_cf129735 = undefined;
    }
}

