#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace gadget_roulette;

// Namespace gadget_roulette
// Params 0, eflags: 0x2
// Checksum 0xfc02a92d, Offset: 0x188
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_roulette", &__init__, undefined, undefined);
}

// Namespace gadget_roulette
// Params 0, eflags: 0x0
// Checksum 0xde03de54, Offset: 0x1c8
// Size: 0x6c
function __init__() {
    clientfield::register("toplayer", "roulette_state", 11000, 2, "int", &function_abc7905, 0, 0);
    callback::on_localplayer_spawned(&on_localplayer_spawned);
}

// Namespace gadget_roulette
// Params 7, eflags: 0x0
// Checksum 0x58a93926, Offset: 0x240
// Size: 0x54
function function_abc7905(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_80a6323d(localclientnum, newval);
}

// Namespace gadget_roulette
// Params 2, eflags: 0x0
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

// Namespace gadget_roulette
// Params 1, eflags: 0x0
// Checksum 0x2086fa7b, Offset: 0x338
// Size: 0x74
function on_localplayer_spawned(localclientnum) {
    roulette_state = 0;
    if (getserverhighestclientfieldversion() >= 11000) {
        roulette_state = self clientfield::get_to_player("roulette_state");
    }
    function_80a6323d(localclientnum, roulette_state);
}

