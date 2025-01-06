#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection2_fx;
#using scripts/cp/cp_mi_cairo_infection2_sound;
#using scripts/cp/cp_mi_cairo_infection_church;
#using scripts/cp/cp_mi_cairo_infection_forest;
#using scripts/cp/cp_mi_cairo_infection_murders;
#using scripts/cp/cp_mi_cairo_infection_sgen_server_room;
#using scripts/cp/cp_mi_cairo_infection_tiger_tank;
#using scripts/cp/cp_mi_cairo_infection_underwater;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cp_mi_cairo_infection_village;
#using scripts/cp/cp_mi_cairo_infection_village_surreal;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace cp_mi_cairo_infection2;

// Namespace cp_mi_cairo_infection2
// Params 0, eflags: 0x0
// Checksum 0xc6675007, Offset: 0x468
// Size: 0xd2
function main() {
    util::function_57b966c8(&force_streamer, 11);
    init_clientfields();
    cp_mi_cairo_infection2_sound::main();
    church::main();
    namespace_9472df26::main();
    cp_mi_cairo_infection_forest::main();
    village::main();
    namespace_4e2074f4::main();
    namespace_47ecfa2f::main();
    underwater::main();
    load::main();
    util::waitforclient(0);
}

// Namespace cp_mi_cairo_infection2
// Params 0, eflags: 0x0
// Checksum 0xf4dd2887, Offset: 0x548
// Size: 0x72
function init_clientfields() {
    clientfield::register("world", "cathedral_water_state", 1, 1, "int", &cathedral_water_state, 0, 1);
    clientfield::register("world", "set_exposure_bank", 1, 2, "int", &set_exposure_bank, 0, 0);
}

// Namespace cp_mi_cairo_infection2
// Params 7, eflags: 0x0
// Checksum 0xa8b19e82, Offset: 0x5c8
// Size: 0xe2
function cathedral_water_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (bnewent) {
        setwavewaterenabled("silo_flood_water", 0);
        setwavewaterenabled("placeholder", 0);
        return;
    }
    if (oldval != newval) {
        if (newval == 0) {
            setwavewaterenabled("silo_flood_water", 0);
            setwavewaterenabled("placeholder", 0);
            return;
        }
        setwavewaterenabled("silo_flood_water", 1);
        setwavewaterenabled("placeholder", 1);
    }
}

// Namespace cp_mi_cairo_infection2
// Params 1, eflags: 0x0
// Checksum 0x5ce31803, Offset: 0x6b8
// Size: 0x1a1
function force_streamer(n_zone) {
    switch (n_zone) {
    case 12:
        forcestreamxmodel("c_hro_sarah_base_body");
        forcestreamxmodel("c_hro_sarah_base_head");
        break;
    case 5:
        forcestreamxmodel("c_hro_sarah_base_body");
        forcestreamxmodel("c_hro_sarah_base_head");
        forcestreamxmodel("c_hro_maretti_base_body");
        forcestreamxmodel("c_hro_maretti_base_head");
        forcestreamxmodel("c_hro_taylor_base_body");
        forcestreamxmodel("c_hro_taylor_base_head");
        forcestreamxmodel("c_hro_diaz_base_body");
        forcestreamxmodel("c_hro_diaz_base_head");
        break;
    case 2:
        forcestreambundle("cin_inf_08_03_blackstation_vign_aftermath");
        break;
    case 7:
        forcestreamxmodel("c_hro_sarah_base_body");
        forcestreamxmodel("c_hro_sarah_base_head");
        break;
    case 11:
        forcestreamxmodel("p7_inf_fountain_01");
        break;
    default:
        break;
    }
}

// Namespace cp_mi_cairo_infection2
// Params 7, eflags: 0x0
// Checksum 0x8cb2dfc5, Offset: 0x868
// Size: 0x6a
function function_11db030f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval != oldval && newval >= 1 && newval <= 6) {
        setukkoscriptindex(localclientnum, newval, 1);
    }
}

// Namespace cp_mi_cairo_infection2
// Params 7, eflags: 0x0
// Checksum 0x484ed6b4, Offset: 0x8e0
// Size: 0x5a
function set_exposure_bank(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval != oldval) {
        setexposureactivebank(localclientnum, newval);
    }
}

