#using scripts/shared/vehicles/_quadtank;
#using scripts/cp/cp_mi_cairo_aquifer_patch_c;
#using scripts/shared/audio_shared;
#using scripts/cp/cp_mi_cairo_aquifer_ambience;
#using scripts/cp/cp_mi_cairo_aquifer_utility;
#using scripts/cp/cp_mi_cairo_aquifer_sound;
#using scripts/cp/cp_mi_cairo_aquifer_fx;
#using scripts/cp/_util;
#using scripts/cp/_load;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_19487f32;

// Namespace namespace_19487f32
// Params 0, eflags: 0x1 linked
// Checksum 0x644eced5, Offset: 0x3d8
// Size: 0x94
function main() {
    util::function_57b966c8(&function_71f88fc, 11);
    function_4b0a421();
    namespace_d6728217::main();
    namespace_1d1d22be::main();
    load::main();
    util::waitforclient(0);
    namespace_a24425cb::function_7403e82b();
}

// Namespace namespace_19487f32
// Params 0, eflags: 0x1 linked
// Checksum 0x434ffe1c, Offset: 0x478
// Size: 0x4c
function function_4b0a421() {
    clientfield::register("world", "water_room_exit_scenes", 1, 1, "int", &function_fb25b781, 0, 0);
}

// Namespace namespace_19487f32
// Params 1, eflags: 0x1 linked
// Checksum 0x26e4596, Offset: 0x4d0
// Size: 0x1aa
function function_71f88fc(n_zone) {
    switch (n_zone) {
    case 1:
        break;
    case 2:
        forcestreambundle("cin_aqu_05_01_enter_1st_look");
        break;
    case 3:
        forcestreambundle("cin_aqu_02_01_floodroom_1st_dragged");
        break;
    case 4:
        forcestreambundle("cin_aqu_03_01_platform_1st_secureplatform_exit");
        break;
    case 5:
        forcestreamxmodel("c_hro_taylor_base_fb");
        forcestreamxmodel("c_hro_maretti_base_fb");
        forcestreamxmodel("c_t7_ally_fb");
        forcestreamxmodel("veh_t7_mil_vtol_nrc_land");
        forcestreamxmodel("p7_aqu_door_hangar_metal_01_l");
        forcestreamxmodel("p7_aqu_door_hangar_metal_01_r");
        streamtexturelist("cp_mi_cairo_aquifer");
        break;
    case 6:
        break;
    case 7:
        break;
    case 8:
        break;
    case 9:
        break;
    case 10:
        break;
    case 11:
        break;
    default:
        break;
    }
}

// Namespace namespace_19487f32
// Params 3, eflags: 0x0
// Checksum 0x59c561be, Offset: 0x688
// Size: 0x7c
function function_93df2062(player, filterid, var_5a938650) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_binoculars"));
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

// Namespace namespace_19487f32
// Params 1, eflags: 0x1 linked
// Checksum 0x21a259b2, Offset: 0x710
// Size: 0x30
function mapped_material_id(materialname) {
    if (!isdefined(level.filter_matid)) {
        level.filter_matid = [];
    }
    return level.filter_matid[materialname];
}

// Namespace namespace_19487f32
// Params 7, eflags: 0x1 linked
// Checksum 0xc0474d19, Offset: 0x748
// Size: 0x84
function function_fb25b781(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::init("cin_aqu_03_01_platform_1st_secureplatform_ambient");
        return;
    }
    level thread scene::play("cin_aqu_03_01_platform_1st_secureplatform_ambient");
}

