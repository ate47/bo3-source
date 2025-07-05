#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace helicopter_gunner;

// Namespace helicopter_gunner
// Params 0, eflags: 0x2
// Checksum 0xd4f25fd3, Offset: 0x208
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("helicopter_gunner", &__init__, undefined, undefined);
}

// Namespace helicopter_gunner
// Params 0, eflags: 0x0
// Checksum 0xb81ed2de, Offset: 0x240
// Size: 0x102
function __init__() {
    clientfield::register("vehicle", "vtol_turret_destroyed_0", 1, 1, "int", &function_4e820f76, 0, 0);
    clientfield::register("vehicle", "vtol_turret_destroyed_1", 1, 1, "int", &function_748489df, 0, 0);
    clientfield::register("toplayer", "vtol_update_client", 1, 1, "counter", &function_f4f4212c, 0, 0);
    clientfield::register("toplayer", "fog_bank_2", 1, 1, "int", &function_539964e7, 0, 0);
    visionset_mgr::register_visionset_info("mothership_visionset", 1, 1, undefined, "mp_vehicles_mothership");
}

// Namespace helicopter_gunner
// Params 7, eflags: 0x0
// Checksum 0xe340d1ac, Offset: 0x350
// Size: 0x3a
function function_4e820f76(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace helicopter_gunner
// Params 7, eflags: 0x0
// Checksum 0xd624d086, Offset: 0x398
// Size: 0x3a
function function_748489df(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace helicopter_gunner
// Params 3, eflags: 0x0
// Checksum 0xec07dcc, Offset: 0x3e0
// Size: 0x6a
function function_366de7bb(localclientnum, var_1a2e89c5, new_value) {
    var_64d5b0bd = getuimodel(getuimodelforcontroller(localclientnum), var_1a2e89c5);
    if (isdefined(var_64d5b0bd)) {
        setuimodelvalue(var_64d5b0bd, new_value);
    }
}

// Namespace helicopter_gunner
// Params 7, eflags: 0x0
// Checksum 0x734ab33b, Offset: 0x458
// Size: 0xba
function function_f4f4212c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    veh = getplayervehicle(self);
    if (isdefined(veh)) {
        function_366de7bb(localclientnum, "vehicle.partDestroyed.0", veh clientfield::get("vtol_turret_destroyed_0"));
        function_366de7bb(localclientnum, "vehicle.partDestroyed.1", veh clientfield::get("vtol_turret_destroyed_1"));
    }
}

// Namespace helicopter_gunner
// Params 7, eflags: 0x0
// Checksum 0xaf938fab, Offset: 0x520
// Size: 0x7a
function function_539964e7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval != newval) {
        if (newval == 1) {
            setlitfogbank(localclientnum, -1, 1, 0);
            return;
        }
        setlitfogbank(localclientnum, -1, 0, 0);
    }
}

