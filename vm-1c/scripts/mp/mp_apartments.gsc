#using scripts/mp/mp_apartments_fx;
#using scripts/mp/mp_apartments_amb;
#using scripts/mp/_load;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_globallogic;
#using scripts/shared/compass;
#using scripts/mp/_util;
#using scripts/codescripts/struct;

#namespace mp_apartments;

// Namespace mp_apartments
// Params 0, eflags: 0x1 linked
// namespace_a646b324<file_0>::function_d290ebfa
// Checksum 0x515000ad, Offset: 0x258
// Size: 0x63c
function main() {
    namespace_8a0e01ed::main();
    level.var_7bb6ebae = &function_7bb6ebae;
    level.remotemissile_kill_z = 650 + 50;
    load::main();
    compass::setupminimap("compass_map_mp_apartments");
    namespace_ad0e5c15::main();
    setdvar("compassmaxrange", "2100");
    setdvar("phys_buoyancy", 1);
    setdvar("phys_ragdoll_buoyancy", 1);
    spawncollision("collision_clip_wall_256x256x10", "collider", (-944.403, -907.351, 1475.01), (0, 90, -90));
    var_62bd5a1c = spawn("script_model", (-895.394, -903.731, 1420.55));
    var_62bd5a1c.angles = (0, 0, -90);
    var_62bd5a1c setmodel("p7_debris_wood_plywood_4x8_flat_white_wet");
    var_d4c4c957 = spawn("script_model", (-943.14, -904.731, 1420.55));
    var_d4c4c957.angles = (0, 0, -90);
    var_d4c4c957 setmodel("p7_debris_wood_plywood_4x8_flat_white_wet");
    var_aec24eee = spawn("script_model", (-996.733, -903.731, 1420.55));
    var_aec24eee.angles = (0, 0, -90);
    var_aec24eee setmodel("p7_debris_wood_plywood_4x8_flat_white_wet");
    var_f0b5eae1 = spawn("script_model", (-1043.21, -904.731, 1420.55));
    var_f0b5eae1.angles = (0, 0, -90);
    var_f0b5eae1 setmodel("p7_debris_wood_plywood_4x8_flat_white_wet");
    var_cab37078 = spawn("script_model", (-895.394, -904.731, 1393.59));
    var_cab37078.angles = (0, 0, -90);
    var_cab37078 setmodel("p7_debris_wood_plywood_4x8_flat_white_wet");
    var_3cbadfb3 = spawn("script_model", (-943.14, -905.731, 1393.59));
    var_3cbadfb3.angles = (0, 0, -90);
    var_3cbadfb3 setmodel("p7_debris_wood_plywood_4x8_flat_white_wet");
    var_16b8654a = spawn("script_model", (-996.733, -904.731, 1393.59));
    var_16b8654a.angles = (0, 0, -90);
    var_16b8654a setmodel("p7_debris_wood_plywood_4x8_flat_white_wet");
    var_58ac013d = spawn("script_model", (-1043.21, -905.731, 1393.59));
    var_58ac013d.angles = (0, 0, -90);
    var_58ac013d setmodel("p7_debris_wood_plywood_4x8_flat_white_wet");
    spawncollision("collision_clip_cylinder_32x128", "collider", (-2155.05, -1682.18, 1691.28), (0, 0, 0));
    spawncollision("collision_clip_cylinder_32x128", "collider", (-2155.05, -1682.18, 1799.26), (0, 0, 0));
    spawncollision("collision_clip_cylinder_32x128", "collider", (-2155.05, -1682.18, 1905.5), (0, 0, 0));
    level.cleandepositpoints = array((-2348.08, -639.428, 1215.81), (-186.08, -415.428, 1344.81), (70.9199, -1853.93, 1344.81), (-1352.58, -913.428, 1226.81), (-434.08, 660.072, 1346.81));
}

// Namespace mp_apartments
// Params 1, eflags: 0x1 linked
// namespace_a646b324<file_0>::function_7bb6ebae
// Checksum 0xd7140f66, Offset: 0x8a0
// Size: 0x74
function function_7bb6ebae(&var_ef2e1e06) {
    if (!isdefined(var_ef2e1e06)) {
        var_ef2e1e06 = [];
    } else if (!isarray(var_ef2e1e06)) {
        var_ef2e1e06 = array(var_ef2e1e06);
    }
    var_ef2e1e06[var_ef2e1e06.size] = (-560, -2020, 1355);
}

