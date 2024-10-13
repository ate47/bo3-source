#using scripts/cp/_util;
#using scripts/cp/_load;
#using scripts/shared/vehicles/_quadtank;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace cp_mi_zurich_coalescence_patch_c;

// Namespace cp_mi_zurich_coalescence_patch_c
// Params 0, eflags: 0x1 linked
// Checksum 0x4e7599b3, Offset: 0x1d8
// Size: 0x4c
function function_7403e82b() {
    var_49997a8a = findstaticmodelindex((-10564.2, 39630.2, 392));
    hidestaticmodel(var_49997a8a);
}

