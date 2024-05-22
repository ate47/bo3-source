#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_a7d38b50;

// Namespace namespace_a7d38b50
// Params 0, eflags: 0x2
// Checksum 0xfc02a92d, Offset: 0x188
// Size: 0x34
function function_2dc19561() {
    system::register("gadget_roulette", &__init__, undefined, undefined);
}

// Namespace namespace_a7d38b50
// Params 0, eflags: 0x1 linked
// Checksum 0xde03de54, Offset: 0x1c8
// Size: 0x6c
function __init__() {
    clientfield::register("toplayer", "roulette_state", 11000, 2, "int", &function_abc7905, 0, 0);
    callback::on_localplayer_spawned(&on_localplayer_spawned);
}

// Namespace namespace_a7d38b50
// Params 7, eflags: 0x1 linked
// Checksum 0x58a93926, Offset: 0x240
// Size: 0x54
function function_abc7905(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_80a6323d(localclientnum, newval);
}

// Namespace namespace_a7d38b50
// Params 2, eflags: 0x1 linked
// Checksum 0x1896b8f6, Offset: 0x2a0
// Size: 0x8c
function function_80a6323d(localclientnum, newval) {
    controllermodel = getuimodelforcontroller(localclientnum);
    if (isdefined(controllermodel)) {
        var_2bab83be = getuimodel(controllermodel, "playerAbilities.playerGadget3.rouletteStatus");
        if (isdefined(var_2bab83be)) {
            setuimodelvalue(var_2bab83be, newval);
        }
    }
}

// Namespace namespace_a7d38b50
// Params 1, eflags: 0x1 linked
// Checksum 0x2086fa7b, Offset: 0x338
// Size: 0x74
function on_localplayer_spawned(localclientnum) {
    var_4c8a0a2b = 0;
    if (getserverhighestclientfieldversion() >= 11000) {
        var_4c8a0a2b = self clientfield::get_to_player("roulette_state");
    }
    function_80a6323d(localclientnum, var_4c8a0a2b);
}

