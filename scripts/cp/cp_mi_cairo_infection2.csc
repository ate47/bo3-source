#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection2_fx;
#using scripts/cp/cp_mi_cairo_infection2_patch_c;
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
// Params 0
// Checksum 0xfe17abae, Offset: 0x498
// Size: 0xf4
function main()
{
    util::set_streamer_hint_function( &force_streamer, 11 );
    init_clientfields();
    cp_mi_cairo_infection2_sound::main();
    church::main();
    sgen_server_room::main();
    cp_mi_cairo_infection_forest::main();
    village::main();
    village_surreal::main();
    blackstation_murders::main();
    underwater::main();
    load::main();
    util::waitforclient( 0 );
    cp_mi_cairo_infection2_patch_c::function_7403e82b();
}

// Namespace cp_mi_cairo_infection2
// Params 0
// Checksum 0x48a187a3, Offset: 0x598
// Size: 0x94
function init_clientfields()
{
    clientfield::register( "world", "cathedral_water_state", 1, 1, "int", &value12, 0, 1 );
    clientfield::register( "world", "set_exposure_bank", 1, 2, "int", &set_exposure_bank, 0, 0 );
}

// Namespace cp_mi_cairo_infection2
// Params 7
// Checksum 0xe29da9d1, Offset: 0x638
// Size: 0x104
function value12( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( bnewent )
    {
        setwavewaterenabled( "silo_flood_water", 0 );
        setwavewaterenabled( "placeholder", 0 );
        return;
    }
    
    if ( oldval != newval )
    {
        if ( newval == 0 )
        {
            setwavewaterenabled( "silo_flood_water", 0 );
            setwavewaterenabled( "placeholder", 0 );
            return;
        }
        
        setwavewaterenabled( "silo_flood_water", 1 );
        setwavewaterenabled( "placeholder", 1 );
    }
}

// Namespace cp_mi_cairo_infection2
// Params 1
// Checksum 0x16ea0ef2, Offset: 0x748
// Size: 0x1c2
function force_streamer( n_zone )
{
    switch ( n_zone )
    {
        case 12:
            forcestreamxmodel( "c_hro_sarah_base_body" );
            forcestreamxmodel( "c_hro_sarah_base_head" );
            break;
        case 5:
            forcestreamxmodel( "c_hro_sarah_base_body" );
            forcestreamxmodel( "c_hro_sarah_base_head" );
            forcestreamxmodel( "c_hro_maretti_base_body" );
            forcestreamxmodel( "c_hro_maretti_base_head" );
            forcestreamxmodel( "c_hro_taylor_base_body" );
            forcestreamxmodel( "c_hro_taylor_base_head" );
            forcestreamxmodel( "c_hro_diaz_base_body" );
            forcestreamxmodel( "c_hro_diaz_base_head" );
            break;
        case 2:
            forcestreambundle( "cin_inf_08_03_blackstation_vign_aftermath" );
            break;
        case 7:
            forcestreamxmodel( "c_hro_sarah_base_body" );
            forcestreamxmodel( "c_hro_sarah_base_head" );
            break;
        case 11:
            forcestreamxmodel( "p7_inf_fountain_01" );
            break;
        default:
            break;
    }
}

// Namespace cp_mi_cairo_infection2
// Params 7
// Checksum 0xa27a5a0, Offset: 0x918
// Size: 0x84
function function_11db030f( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval != oldval && newval >= 1 && newval <= 6 )
    {
        setukkoscriptindex( localclientnum, newval, 1 );
    }
}

// Namespace cp_mi_cairo_infection2
// Params 7
// Checksum 0x61f89fb7, Offset: 0x9a8
// Size: 0x64
function set_exposure_bank( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval != oldval )
    {
        setexposureactivebank( localclientnum, newval );
    }
}

