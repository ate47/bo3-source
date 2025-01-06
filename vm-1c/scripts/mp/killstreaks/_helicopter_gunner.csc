#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace helicopter_gunner;

// Namespace helicopter_gunner
// Params 0, eflags: 0x2
// Checksum 0x28e0e411, Offset: 0x208
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("helicopter_gunner", &__init__, undefined, undefined);
}

// Namespace helicopter_gunner
// Params 0, eflags: 0x0
// Checksum 0x7788c6ec, Offset: 0x248
// Size: 0x14c
function __init__() {
    clientfield::register("vehicle", "vtol_turret_destroyed_0", 1, 1, "int", &function_4e820f76, 0, 0);
    clientfield::register("vehicle", "vtol_turret_destroyed_1", 1, 1, "int", &function_748489df, 0, 0);
    clientfield::register("toplayer", "vtol_update_client", 1, 1, "counter", &function_f4f4212c, 0, 0);
    clientfield::register("toplayer", "fog_bank_2", 1, 1, "int", &function_539964e7, 0, 0);
    visionset_mgr::register_visionset_info("mothership_visionset", 1, 1, undefined, "mp_vehicles_mothership");
}

// Namespace helicopter_gunner
// Params 7, eflags: 0x0
// Checksum 0x66df3794, Offset: 0x3a0
// Size: 0x3c
function function_4e820f76(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace helicopter_gunner
// Params 7, eflags: 0x0
// Checksum 0x2e0e26ab, Offset: 0x3e8
// Size: 0x3c
function function_748489df(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace helicopter_gunner
// Params 3, eflags: 0x0
// Checksum 0x8d02caa7, Offset: 0x430
// Size: 0x7c
function function_366de7bb(localclientnum, var_1a2e89c5, new_value) {
    var_64d5b0bd = getuimodel(getuimodelforcontroller(localclientnum), var_1a2e89c5);
    if (isdefined(var_64d5b0bd)) {
        setuimodelvalue(var_64d5b0bd, new_value);
    }
}

// Namespace helicopter_gunner
// Params 7, eflags: 0x0
// Checksum 0x4f474745, Offset: 0x4b8
// Size: 0xdc
function function_f4f4212c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    veh = getplayervehicle(self);
    if (isdefined(veh)) {
        function_366de7bb(localclientnum, "vehicle.partDestroyed.0", veh clientfield::get("vtol_turret_destroyed_0"));
        function_366de7bb(localclientnum, "vehicle.partDestroyed.1", veh clientfield::get("vtol_turret_destroyed_1"));
    }
}

// Namespace helicopter_gunner
// Params 7, eflags: 0x0
// Checksum 0xeb96673e, Offset: 0x5a0
// Size: 0x9c
function function_539964e7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval != newval) {
        if (newval == 1) {
            setlitfogbank(localclientnum, -1, 1, 0);
            return;
        }
        setlitfogbank(localclientnum, -1, 0, 0);
    }
}

