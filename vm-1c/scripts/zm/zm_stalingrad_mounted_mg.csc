#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace zm_stalingrad_mounted_mg;

// Namespace zm_stalingrad_mounted_mg
// Params 0, eflags: 0x2
// Checksum 0x8989e3b4, Offset: 0x190
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_stalingrad_mounted_mg", &__init__, undefined, undefined);
}

// Namespace zm_stalingrad_mounted_mg
// Params 0, eflags: 0x0
// Checksum 0xfdc67ffc, Offset: 0x1d0
// Size: 0x64
function __init__() {
    level._effect["mounted_mg_overheat"] = "dlc3/stalingrad/fx_mg42_over_heat";
    clientfield::register("vehicle", "overheat_fx", 12000, 1, "int", &function_c71f5e4a, 0, 0);
}

// Namespace zm_stalingrad_mounted_mg
// Params 7, eflags: 0x0
// Checksum 0xc81e841f, Offset: 0x240
// Size: 0xac
function function_c71f5e4a(var_6575414d, var_a53f7c1b, var_143c4e26, var_f16ed138, var_406ad39b, str_field, var_ffbb7dc) {
    if (var_143c4e26) {
        self.var_b4b6b5a6 = playfxontag(var_6575414d, level._effect["mounted_mg_overheat"], self, "tag_flash");
        return;
    }
    if (isdefined(self.var_b4b6b5a6)) {
        stopfx(var_6575414d, self.var_b4b6b5a6);
    }
}

