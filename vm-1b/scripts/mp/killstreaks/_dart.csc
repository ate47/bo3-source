#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace dart;

// Namespace dart
// Params 0, eflags: 0x2
// Checksum 0xb6b76912, Offset: 0x208
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("dart", &__init__, undefined, undefined);
}

// Namespace dart
// Params 0, eflags: 0x0
// Checksum 0xcd7575b1, Offset: 0x240
// Size: 0x12a
function __init__() {
    clientfield::register("toplayer", "dart_update_ammo", 1, 2, "int", &update_ammo, 0, 0);
    clientfield::register("toplayer", "fog_bank_3", 1, 1, "int", &fog_bank_3_callback, 0, 0);
    level.dartbundle = struct::get_script_bundle("killstreak", "killstreak_dart");
    vehicle::add_vehicletype_callback(level.dartbundle.var_d9038040, &spawned);
    visionset_mgr::register_visionset_info("dart_visionset", 1, 1, undefined, "mp_vehicles_dart");
    visionset_mgr::register_visionset_info("sentinel_visionset", 1, 1, undefined, "mp_vehicles_sentinel");
    visionset_mgr::register_visionset_info("remote_missile_visionset", 1, 1, undefined, "mp_hellstorm");
}

// Namespace dart
// Params 7, eflags: 0x0
// Checksum 0x26428e0a, Offset: 0x378
// Size: 0x7a
function update_ammo(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setuimodelvalue(getuimodel(getuimodelforcontroller(localclientnum), "vehicle.ammo"), newval);
}

// Namespace dart
// Params 1, eflags: 0x0
// Checksum 0x674f5fb3, Offset: 0x400
// Size: 0x1a
function spawned(localclientnum) {
    self.killstreakbundle = level.dartbundle;
}

// Namespace dart
// Params 7, eflags: 0x0
// Checksum 0x1b3075eb, Offset: 0x428
// Size: 0x7a
function fog_bank_3_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval != newval) {
        if (newval == 1) {
            setworldfogactivebank(localclientnum, 4);
            return;
        }
        setworldfogactivebank(localclientnum, 1);
    }
}

