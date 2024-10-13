#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace gadget_thief;

// Namespace gadget_thief
// Params 0, eflags: 0x2
// Checksum 0xa3a55712, Offset: 0x2c0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_thief", &__init__, undefined, undefined);
}

// Namespace gadget_thief
// Params 0, eflags: 0x1 linked
// Checksum 0x35cb5c53, Offset: 0x300
// Size: 0x1a4
function __init__() {
    clientfield::register("scriptmover", "gadget_thief_fx", 11000, 1, "int", &function_9f84f28b, 0, 0);
    clientfield::register("toplayer", "thief_state", 11000, 2, "int", &function_5215beb4, 0, 0);
    clientfield::register("toplayer", "thief_weapon_option", 11000, 4, "int", &function_11b5ab11, 0, 0);
    clientfield::register("clientuimodel", "playerAbilities.playerGadget3.flashStart", 11000, 3, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "playerAbilities.playerGadget3.flashEnd", 11000, 3, "int", undefined, 0, 0);
    level._effect["fx_hero_blackjack_beam_source"] = "weapon/fx_hero_blackjack_beam_source";
    level._effect["fx_hero_blackjack_beam_target"] = "weapon/fx_hero_blackjack_beam_target";
    callback::on_localplayer_spawned(&on_localplayer_spawned);
}

// Namespace gadget_thief
// Params 7, eflags: 0x1 linked
// Checksum 0x35ca392e, Offset: 0x4b0
// Size: 0xac
function function_9f84f28b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    playfxoncamera(localclientnum, level._effect["fx_hero_blackjack_beam_target"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
    playfx(localclientnum, level._effect["fx_hero_blackjack_beam_source"], self.origin);
}

// Namespace gadget_thief
// Params 7, eflags: 0x1 linked
// Checksum 0x20ca9e20, Offset: 0x568
// Size: 0x54
function function_5215beb4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_2f9da783(localclientnum, newval);
}

// Namespace gadget_thief
// Params 7, eflags: 0x1 linked
// Checksum 0x972c15d5, Offset: 0x5c8
// Size: 0x54
function function_11b5ab11(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_403d3d3e(localclientnum, newval);
}

// Namespace gadget_thief
// Params 2, eflags: 0x1 linked
// Checksum 0x13a18e5e, Offset: 0x628
// Size: 0x8c
function function_2f9da783(localclientnum, newval) {
    controllermodel = getuimodelforcontroller(localclientnum);
    if (isdefined(controllermodel)) {
        var_3c7ebefc = getuimodel(controllermodel, "playerAbilities.playerGadget3.thiefStatus");
        if (isdefined(var_3c7ebefc)) {
            setuimodelvalue(var_3c7ebefc, newval);
        }
    }
}

// Namespace gadget_thief
// Params 2, eflags: 0x1 linked
// Checksum 0xa47497fb, Offset: 0x6c0
// Size: 0x8c
function function_403d3d3e(localclientnum, newval) {
    controllermodel = getuimodelforcontroller(localclientnum);
    if (isdefined(controllermodel)) {
        var_3c7ebefc = getuimodel(controllermodel, "playerAbilities.playerGadget3.thiefWeaponStatus");
        if (isdefined(var_3c7ebefc)) {
            setuimodelvalue(var_3c7ebefc, newval);
        }
    }
}

// Namespace gadget_thief
// Params 1, eflags: 0x1 linked
// Checksum 0xb162c55c, Offset: 0x758
// Size: 0xbc
function on_localplayer_spawned(localclientnum) {
    thief_state = 0;
    thief_weapon_option = 0;
    if (getserverhighestclientfieldversion() >= 11000) {
        thief_state = self clientfield::get_to_player("thief_state");
        thief_weapon_option = self clientfield::get_to_player("thief_weapon_option");
    }
    function_2f9da783(localclientnum, thief_state);
    function_403d3d3e(localclientnum, thief_weapon_option);
}

