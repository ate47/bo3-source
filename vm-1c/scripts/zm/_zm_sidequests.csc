#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_6e97c459;

// Namespace namespace_6e97c459
// Params 2, eflags: 0x1 linked
// Checksum 0xef1a64ca, Offset: 0xf0
// Size: 0xac
function function_225a92d6(var_f814e008, var_6f3d2f15) {
    var_d1ed79d8 = "sidequestIcons." + var_f814e008 + ".";
    clientfield::register("clientuimodel", var_d1ed79d8 + "icon", var_6f3d2f15, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", var_d1ed79d8 + "notification", var_6f3d2f15, 1, "int", undefined, 0, 0);
}

