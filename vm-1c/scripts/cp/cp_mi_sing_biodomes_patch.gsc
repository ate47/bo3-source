#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_util;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace cp_mi_sing_biodomes_patch;

// Namespace cp_mi_sing_biodomes_patch
// Params 0, eflags: 0x0
// Checksum 0xed0274c8, Offset: 0x2e8
// Size: 0x44c
function function_7403e82b() {
    var_3d2d68be = spawn("script_model", (6509, 12522, -118));
    var_3d2d68be setmodel("p7_sin_ship_container_door_lt_red");
    var_3d2d68be.angles = (0, 0, 0);
    var_7a443ed8 = spawn("script_model", (6627, 12522, -118));
    var_7a443ed8 setmodel("p7_sin_ship_container_door_rt_red");
    var_7a443ed8.angles = (0, 0, 0);
    var_78b01796 = spawn("script_model", (4588.33, 16049, 71.0593));
    var_78b01796 setmodel("p7_sin_ship_container_side_panel_192_orange");
    var_78b01796.angles = (357.6, 0, 0);
    spawncollision("collision_clip_64x64x128", "collider", (4745, 13294, -126), (0, 20.5996, 0));
    var_d1a4a596 = spawn("script_model", (4611, 16502, -277));
    var_d1a4a596 setmodel("collision_clip_64x64x256");
    var_d1a4a596.angles = (270, 270, 0);
    var_d1a4a596 setscale(7);
    var_d1a4a596 setforcenocull();
    var_aba22b2d = spawn("script_model", (4838.67, 16359, -10.9407));
    var_aba22b2d setmodel("p7_corrugated_sheet_metal_rust_03");
    var_aba22b2d.angles = (0, 270, 0);
    var_aba22b2d setforcenocull();
    var_859fb0c4 = spawn("script_model", (6460, 13652, -348));
    var_859fb0c4 setmodel("collision_clip_64x64x128");
    var_859fb0c4.angles = (360, 90, -180);
    var_859fb0c4 setscale(5.8);
    var_859fb0c4 setforcenocull();
    var_5f9d365b = spawn("script_model", (6062.67, 13686, -16.9407));
    var_5f9d365b setmodel("p7_corrugated_sheet_metal_rust_03");
    var_5f9d365b.angles = (0, 270, 0);
    var_5f9d365b setforcenocull();
    var_399abbf2 = spawn("script_model", (5510.67, 15067, -16.9407));
    var_399abbf2 setmodel("p7_corrugated_sheet_metal_rust_03");
    var_399abbf2.angles = (0, 270, 0);
    var_399abbf2 setforcenocull();
}

