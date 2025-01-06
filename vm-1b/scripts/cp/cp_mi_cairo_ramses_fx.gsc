#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;

#namespace cp_mi_cairo_ramses_fx;

// Namespace cp_mi_cairo_ramses_fx
// Params 0, eflags: 0x0
// Checksum 0x495b2dec, Offset: 0x118
// Size: 0x6b
function main() {
    clientfield::register("world", "defend_fog_banks", 1, 1, "int");
    clientfield::register("world", "start_fog_banks", 1, 1, "int");
    level._effect["vtol_thruster"] = "vehicle/fx_vtol_thruster_vista";
}

