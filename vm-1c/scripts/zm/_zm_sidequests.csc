#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;

#namespace namespace_6e97c459;

// Namespace namespace_6e97c459
// Params 2, eflags: 0x0
// Checksum 0xef1a64ca, Offset: 0xf0
// Size: 0xac
function function_225a92d6(icon_name, var_6f3d2f15) {
    var_d1ed79d8 = "sidequestIcons." + icon_name + ".";
    clientfield::register("clientuimodel", var_d1ed79d8 + "icon", var_6f3d2f15, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", var_d1ed79d8 + "notification", var_6f3d2f15, 1, "int", undefined, 0, 0);
}

