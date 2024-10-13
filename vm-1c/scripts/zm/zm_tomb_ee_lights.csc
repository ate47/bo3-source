#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_tomb_ee_lights;

// Namespace zm_tomb_ee_lights
// Params 0, eflags: 0x1 linked
// Checksum 0x6aeb2afb, Offset: 0x130
// Size: 0x4c
function main() {
    clientfield::register("world", "light_show", 21000, 2, "int", &function_b6f5f7f5, 0, 0);
}

// Namespace zm_tomb_ee_lights
// Params 7, eflags: 0x1 linked
// Checksum 0x57188c94, Offset: 0x188
// Size: 0x13a
function function_b6f5f7f5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    switch (newval) {
    case 1:
        level.var_fdb98849 = (2, 2, 2);
        level.var_656c2f5 = (0.25, 0.25, 0.25);
        break;
    case 2:
        level.var_fdb98849 = (2, 0.1, 0.1);
        level.var_656c2f5 = (0.5, 0.1, 0.1);
        break;
    case 3:
        level.var_fdb98849 = (0.1, 2, 0.1);
        level.var_656c2f5 = (0.1, 0.5, 0.1);
        break;
    default:
        level.var_fdb98849 = undefined;
        level.var_656c2f5 = undefined;
        break;
    }
}

