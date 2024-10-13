#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace cp_mi_cairo_ramses_fx;

// Namespace cp_mi_cairo_ramses_fx
// Params 0, eflags: 0x1 linked
// Checksum 0x421c3635, Offset: 0x118
// Size: 0x7e
function main() {
    clientfield::register("world", "defend_fog_banks", 1, 1, "int");
    clientfield::register("world", "start_fog_banks", 1, 1, "int");
    level._effect["vtol_thruster"] = "vehicle/fx_vtol_thruster_vista";
}

