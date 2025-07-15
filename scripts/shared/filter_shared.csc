#using scripts/shared/postfx_shared;

#namespace filter;

// Namespace filter
// Params 0
// Checksum 0x99ec1590, Offset: 0x5f0
// Size: 0x4
function init_filter_indices()
{
    
}

// Namespace filter
// Params 2
// Checksum 0xc55d5da1, Offset: 0x600
// Size: 0x3a
function map_material_helper_by_localclientnum( localclientnum, materialname )
{
    level.filter_matid[ materialname ] = mapmaterialindex( localclientnum, materialname );
}

// Namespace filter
// Params 2
// Checksum 0x9bfee571, Offset: 0x648
// Size: 0x4c
function map_material_if_undefined( localclientnum, materialname )
{
    if ( isdefined( mapped_material_id( materialname ) ) )
    {
        return;
    }
    
    map_material_helper_by_localclientnum( localclientnum, materialname );
}

// Namespace filter
// Params 2
// Checksum 0x60aa26bd, Offset: 0x6a0
// Size: 0x34
function map_material_helper( player, materialname )
{
    map_material_helper_by_localclientnum( player.localclientnum, materialname );
}

// Namespace filter
// Params 1
// Checksum 0x41917d11, Offset: 0x6e0
// Size: 0x30
function mapped_material_id( materialname )
{
    if ( !isdefined( level.filter_matid ) )
    {
        level.filter_matid = [];
    }
    
    return level.filter_matid[ materialname ];
}

// Namespace filter
// Params 1
// Checksum 0xf903ad8e, Offset: 0x718
// Size: 0x3c
function init_filter_binoculars( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_binoculars" );
}

// Namespace filter
// Params 3
// Checksum 0x295be456, Offset: 0x760
// Size: 0x7c
function enable_filter_binoculars( player, filterid, overlayid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_binoculars" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
}

// Namespace filter
// Params 3
// Checksum 0x2bf24d00, Offset: 0x7e8
// Size: 0x44
function disable_filter_binoculars( player, filterid, overlayid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 1
// Checksum 0xc82954df, Offset: 0x838
// Size: 0x3c
function init_filter_binoculars_with_outline( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_binoculars_with_outline" );
}

// Namespace filter
// Params 3
// Checksum 0xf1b61421, Offset: 0x880
// Size: 0x7c
function enable_filter_binoculars_with_outline( player, filterid, overlayid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_binoculars_with_outline" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
}

// Namespace filter
// Params 3
// Checksum 0x5108d15, Offset: 0x908
// Size: 0x44
function disable_filter_binoculars_with_outline( player, filterid, overlayid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 1
// Checksum 0xaf823dba, Offset: 0x958
// Size: 0xbc
function init_filter_hazmat( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_hazmat" );
    map_material_helper( player, "generic_overlay_hazmat_1" );
    map_material_helper( player, "generic_overlay_hazmat_2" );
    map_material_helper( player, "generic_overlay_hazmat_3" );
    map_material_helper( player, "generic_overlay_hazmat_4" );
}

// Namespace filter
// Params 4
// Checksum 0xf2e53f9a, Offset: 0xa20
// Size: 0x74
function set_filter_hazmat_opacity( player, filterid, overlayid, opacity )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 0, opacity );
    setoverlayconstant( player.localclientnum, overlayid, 0, opacity );
}

// Namespace filter
// Params 5
// Checksum 0x4c87e0ce, Offset: 0xaa0
// Size: 0x214
function enable_filter_hazmat( player, filterid, overlayid, stage, opacity )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_hazmat" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
    
    if ( stage == 1 )
    {
        setoverlaymaterial( player.localclientnum, overlayid, mapped_material_id( "generic_overlay_hazmat_1" ), 1 );
    }
    else if ( stage == 2 )
    {
        setoverlaymaterial( player.localclientnum, overlayid, mapped_material_id( "generic_overlay_hazmat_2" ), 1 );
    }
    else if ( stage == 3 )
    {
        setoverlaymaterial( player.localclientnum, overlayid, mapped_material_id( "generic_overlay_hazmat_3" ), 1 );
    }
    else if ( stage == 4 )
    {
        setoverlaymaterial( player.localclientnum, overlayid, mapped_material_id( "generic_overlay_hazmat_4" ), 1 );
    }
    
    setoverlayenabled( player.localclientnum, overlayid, 1 );
    set_filter_hazmat_opacity( player, filterid, overlayid, opacity );
}

// Namespace filter
// Params 3
// Checksum 0xeb6c8b1a, Offset: 0xcc0
// Size: 0x6c
function disable_filter_hazmat( player, filterid, overlayid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
    setoverlayenabled( player.localclientnum, overlayid, 0 );
}

// Namespace filter
// Params 1
// Checksum 0x7c178839, Offset: 0xd38
// Size: 0x5c
function init_filter_helmet( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_helmet" );
    map_material_helper( player, "generic_overlay_helmet" );
}

// Namespace filter
// Params 3
// Checksum 0x9be93cbd, Offset: 0xda0
// Size: 0xe4
function enable_filter_helmet( player, filterid, overlayid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_helmet" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
    setoverlaymaterial( player.localclientnum, overlayid, mapped_material_id( "generic_overlay_helmet" ), 1 );
    setoverlayenabled( player.localclientnum, overlayid, 1 );
}

// Namespace filter
// Params 3
// Checksum 0xdf92121b, Offset: 0xe90
// Size: 0x6c
function disable_filter_helmet( player, filterid, overlayid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
    setoverlayenabled( player.localclientnum, overlayid, 0 );
}

// Namespace filter
// Params 1
// Checksum 0x216d97a2, Offset: 0xf08
// Size: 0x3c
function init_filter_tacticalmask( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_overlay_tacticalmask" );
}

// Namespace filter
// Params 2
// Checksum 0xbaa59c7b, Offset: 0xf50
// Size: 0x74
function enable_filter_tacticalmask( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_overlay_tacticalmask" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
}

// Namespace filter
// Params 2
// Checksum 0x974a4f90, Offset: 0xfd0
// Size: 0x3c
function disable_filter_tacticalmask( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 1
// Checksum 0x93919043, Offset: 0x1018
// Size: 0x3c
function init_filter_hud_projected_grid( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_hud_projected_grid" );
}

// Namespace filter
// Params 1
// Checksum 0x117fccf3, Offset: 0x1060
// Size: 0x3c
function init_filter_hud_projected_grid_haiti( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_hud_projected_grid_haiti" );
}

// Namespace filter
// Params 3
// Checksum 0x9e2c74b2, Offset: 0x10a8
// Size: 0x44
function set_filter_hud_projected_grid_position( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 0, amount );
}

// Namespace filter
// Params 3
// Checksum 0x4981f418, Offset: 0x10f8
// Size: 0x4c
function set_filter_hud_projected_grid_radius( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 1, amount );
}

// Namespace filter
// Params 2
// Checksum 0xf1ea5617, Offset: 0x1150
// Size: 0xb4
function enable_filter_hud_projected_grid( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_hud_projected_grid" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
    player set_filter_hud_projected_grid_position( player, filterid, 500 );
    player set_filter_hud_projected_grid_radius( player, filterid, 200 );
}

// Namespace filter
// Params 2
// Checksum 0x87393ac7, Offset: 0x1210
// Size: 0xb4
function enable_filter_hud_projected_grid_haiti( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_hud_projected_grid_haiti" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
    player set_filter_hud_projected_grid_position( player, filterid, 500 );
    player set_filter_hud_projected_grid_radius( player, filterid, 200 );
}

// Namespace filter
// Params 2
// Checksum 0x6b849cfd, Offset: 0x12d0
// Size: 0x3c
function disable_filter_hud_projected_grid( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 2
// Checksum 0xf1f343c3, Offset: 0x1318
// Size: 0x44
function init_filter_emp( player, materialname )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_emp_damage" );
}

// Namespace filter
// Params 3
// Checksum 0x7af4aaf1, Offset: 0x1368
// Size: 0x44
function set_filter_emp_amount( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 0, amount );
}

// Namespace filter
// Params 2
// Checksum 0x1813fa47, Offset: 0x13b8
// Size: 0x74
function enable_filter_emp( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_emp_damage" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
}

// Namespace filter
// Params 2
// Checksum 0x79af8fa8, Offset: 0x1438
// Size: 0x3c
function disable_filter_emp( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 1
// Checksum 0x2bfa8d48, Offset: 0x1480
// Size: 0x3c
function init_filter_raindrops( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_raindrops" );
}

// Namespace filter
// Params 3
// Checksum 0x4814e826, Offset: 0x14c8
// Size: 0x44
function set_filter_raindrops_amount( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 0, amount );
}

// Namespace filter
// Params 2
// Checksum 0xd12c835, Offset: 0x1518
// Size: 0xbc
function enable_filter_raindrops( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_raindrops" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
    setfilterpassquads( player.localclientnum, filterid, 0, 400 );
    set_filter_raindrops_amount( player, filterid, 1 );
}

// Namespace filter
// Params 2
// Checksum 0xca9b5f7, Offset: 0x15e0
// Size: 0x3c
function disable_filter_raindrops( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 1
// Checksum 0xc585747e, Offset: 0x1628
// Size: 0x3c
function init_filter_squirrel_raindrops( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_squirrel_raindrops" );
}

// Namespace filter
// Params 3
// Checksum 0x277664d8, Offset: 0x1670
// Size: 0x44
function set_filter_squirrel_raindrops_amount( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 0, amount );
}

// Namespace filter
// Params 2
// Checksum 0x5b36a2d6, Offset: 0x16c0
// Size: 0xbc
function enable_filter_squirrel_raindrops( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_squirrel_raindrops" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
    setfilterpassquads( player.localclientnum, filterid, 0, 400 );
    set_filter_squirrel_raindrops_amount( player, filterid, 1 );
}

// Namespace filter
// Params 2
// Checksum 0xafe6a342, Offset: 0x1788
// Size: 0x3c
function disable_filter_squirrel_raindrops( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 1
// Checksum 0x1c3dd214, Offset: 0x17d0
// Size: 0x3c
function init_filter_radialblur( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_radialblur" );
}

// Namespace filter
// Params 3
// Checksum 0x4050a21e, Offset: 0x1818
// Size: 0x44
function set_filter_radialblur_amount( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 0, amount );
}

// Namespace filter
// Params 2
// Checksum 0xeb1e519a, Offset: 0x1868
// Size: 0x94
function enable_filter_radialblur( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_radialblur" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
    set_filter_radialblur_amount( player, filterid, 1 );
}

// Namespace filter
// Params 2
// Checksum 0xeaf40b1d, Offset: 0x1908
// Size: 0x3c
function disable_filter_radialblur( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 2
// Checksum 0xa22264c3, Offset: 0x1950
// Size: 0x54
function init_filter_vehicle_damage( player, materialname )
{
    init_filter_indices();
    
    if ( !isdefined( level.filter_matid[ materialname ] ) )
    {
        map_material_helper( player, materialname );
    }
}

// Namespace filter
// Params 3
// Checksum 0x530f1830, Offset: 0x19b0
// Size: 0x44
function set_filter_vehicle_damage_amount( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 0, amount );
}

// Namespace filter
// Params 4
// Checksum 0x69d4ceeb, Offset: 0x1a00
// Size: 0x84
function set_filter_vehicle_sun_position( player, filterid, x, y )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 4, x );
    setfilterpassconstant( player.localclientnum, filterid, 0, 5, y );
}

// Namespace filter
// Params 3
// Checksum 0x6019d036, Offset: 0x1a90
// Size: 0x84
function enable_filter_vehicle_damage( player, filterid, materialname )
{
    if ( isdefined( level.filter_matid[ materialname ] ) )
    {
        setfilterpassmaterial( player.localclientnum, filterid, 0, level.filter_matid[ materialname ] );
        setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
    }
}

// Namespace filter
// Params 2
// Checksum 0x1459a588, Offset: 0x1b20
// Size: 0x3c
function disable_filter_vehicle_damage( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 1
// Checksum 0x316d124f, Offset: 0x1b68
// Size: 0x3c
function init_filter_oob( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_out_of_bounds" );
}

// Namespace filter
// Params 2
// Checksum 0x56b95e63, Offset: 0x1bb0
// Size: 0x74
function enable_filter_oob( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_out_of_bounds" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
}

// Namespace filter
// Params 2
// Checksum 0xcf83d4c8, Offset: 0x1c30
// Size: 0x3c
function disable_filter_oob( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 1
// Checksum 0x72741e89, Offset: 0x1c78
// Size: 0x3c
function init_filter_tactical( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_tactical_damage" );
}

// Namespace filter
// Params 2
// Checksum 0x1b9f204a, Offset: 0x1cc0
// Size: 0x74
function enable_filter_tactical( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_tactical_damage" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
}

// Namespace filter
// Params 3
// Checksum 0x93e595a7, Offset: 0x1d40
// Size: 0x44
function set_filter_tactical_amount( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 0, amount );
}

// Namespace filter
// Params 2
// Checksum 0x74c408a9, Offset: 0x1d90
// Size: 0x3c
function disable_filter_tactical( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 1
// Checksum 0x3177648, Offset: 0x1dd8
// Size: 0x3c
function init_filter_water_sheeting( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_water_sheeting" );
}

// Namespace filter
// Params 2
// Checksum 0x4f1b1b72, Offset: 0x1e20
// Size: 0x7c
function enable_filter_water_sheeting( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_water_sheeting" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1, 0, 1 );
}

// Namespace filter
// Params 3
// Checksum 0x724ce968, Offset: 0x1ea8
// Size: 0x44
function set_filter_water_sheet_reveal( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 0, amount );
}

// Namespace filter
// Params 3
// Checksum 0x7524cbf9, Offset: 0x1ef8
// Size: 0x4c
function set_filter_water_sheet_speed( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 1, amount );
}

// Namespace filter
// Params 5
// Checksum 0x32235f49, Offset: 0x1f50
// Size: 0xbc
function set_filter_water_sheet_rivulet_reveal( player, filterid, riv1, riv2, riv3 )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 2, riv1 );
    setfilterpassconstant( player.localclientnum, filterid, 0, 3, riv2 );
    setfilterpassconstant( player.localclientnum, filterid, 0, 4, riv3 );
}

// Namespace filter
// Params 2
// Checksum 0xb107d6de, Offset: 0x2018
// Size: 0x3c
function disable_filter_water_sheeting( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 1
// Checksum 0x834f7a8d, Offset: 0x2060
// Size: 0x3c
function init_filter_water_dive( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_water_dive" );
}

// Namespace filter
// Params 2
// Checksum 0x5fdae4a3, Offset: 0x20a8
// Size: 0x7c
function enable_filter_water_dive( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_water_dive" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1, 0, 1 );
}

// Namespace filter
// Params 2
// Checksum 0x6e7704b6, Offset: 0x2130
// Size: 0x3c
function disable_filter_water_dive( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 3
// Checksum 0xc89f4625, Offset: 0x2178
// Size: 0x44
function set_filter_water_dive_bubbles( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 0, amount );
}

// Namespace filter
// Params 3
// Checksum 0x29531162, Offset: 0x21c8
// Size: 0x4c
function set_filter_water_scuba_bubbles( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 1, amount );
}

// Namespace filter
// Params 3
// Checksum 0x77d37dfc, Offset: 0x2220
// Size: 0x4c
function set_filter_water_scuba_dive_speed( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 2, amount );
}

// Namespace filter
// Params 3
// Checksum 0x63e2f848, Offset: 0x2278
// Size: 0x4c
function set_filter_water_scuba_bubble_attitude( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 3, amount );
}

// Namespace filter
// Params 3
// Checksum 0x5bc7f455, Offset: 0x22d0
// Size: 0x4c
function set_filter_water_wash_reveal_dir( player, filterid, dir )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 4, dir );
}

// Namespace filter
// Params 5
// Checksum 0x616055e7, Offset: 0x2328
// Size: 0xbc
function set_filter_water_wash_color( player, filterid, red, green, blue )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 5, red );
    setfilterpassconstant( player.localclientnum, filterid, 0, 6, green );
    setfilterpassconstant( player.localclientnum, filterid, 0, 7, blue );
}

// Namespace filter
// Params 1
// Checksum 0x20446804, Offset: 0x23f0
// Size: 0x3c
function init_filter_teleportation( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_teleportation" );
}

// Namespace filter
// Params 2
// Checksum 0xf7b6f165, Offset: 0x2438
// Size: 0x74
function enable_filter_teleportation( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_teleportation" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
}

// Namespace filter
// Params 3
// Checksum 0x77c0fae5, Offset: 0x24b8
// Size: 0x44
function set_filter_teleportation_anus_zoom( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 0, amount );
}

// Namespace filter
// Params 3
// Checksum 0x4684eca, Offset: 0x2508
// Size: 0x4c
function set_filter_teleportation_anus_amount( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 6, amount );
}

// Namespace filter
// Params 3
// Checksum 0xb835c0c, Offset: 0x2560
// Size: 0x4c
function set_filter_teleportation_panther_zoom( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 1, amount );
}

// Namespace filter
// Params 3
// Checksum 0x6f6b6e2a, Offset: 0x25b8
// Size: 0x4c
function set_filter_teleportation_panther_amount( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 7, amount );
}

// Namespace filter
// Params 3
// Checksum 0xc64ccab4, Offset: 0x2610
// Size: 0x4c
function set_filter_teleportation_glow_radius( player, filterid, radius )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 2, radius );
}

// Namespace filter
// Params 3
// Checksum 0xfe253c29, Offset: 0x2668
// Size: 0x4c
function set_filter_teleportation_warp_amount( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 3, amount );
}

// Namespace filter
// Params 3
// Checksum 0xbb9b2408, Offset: 0x26c0
// Size: 0x4c
function set_filter_teleportation_warp_direction( player, filterid, direction )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 4, direction );
}

// Namespace filter
// Params 3
// Checksum 0xb50f14b2, Offset: 0x2718
// Size: 0x4c
function set_filter_teleportation_lightning_reveal( player, filterid, threshold )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 5, threshold );
}

// Namespace filter
// Params 3
// Checksum 0xcddeccbd, Offset: 0x2770
// Size: 0x4c
function set_filter_teleportation_faces_amount( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 8, amount );
}

// Namespace filter
// Params 3
// Checksum 0x5b91c04f, Offset: 0x27c8
// Size: 0x4c
function set_filter_teleportation_space_background( player, filterid, set )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 9, set );
}

// Namespace filter
// Params 3
// Checksum 0x75663ea3, Offset: 0x2820
// Size: 0x4c
function set_filter_teleportation_sparkle_amount( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 10, amount );
}

// Namespace filter
// Params 2
// Checksum 0x3562dc7c, Offset: 0x2878
// Size: 0x3c
function disable_filter_teleportation( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 1
// Checksum 0xfc0096ed, Offset: 0x28c0
// Size: 0x2c
function settransported( player )
{
    player thread postfx::playpostfxbundle( "zm_teleporter" );
}

// Namespace filter
// Params 1
// Checksum 0x7561b6df, Offset: 0x28f8
// Size: 0x3c
function init_filter_ev_interference( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_ev_interference" );
}

// Namespace filter
// Params 2
// Checksum 0xa5cfe597, Offset: 0x2940
// Size: 0x9c
function enable_filter_ev_interference( player, filterid )
{
    map_material_if_undefined( player.localclientnum, "generic_filter_ev_interference" );
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_ev_interference" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
}

// Namespace filter
// Params 3
// Checksum 0x42954557, Offset: 0x29e8
// Size: 0x44
function set_filter_ev_interference_amount( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 0, amount );
}

// Namespace filter
// Params 2
// Checksum 0x3cc8efaa, Offset: 0x2a38
// Size: 0x3c
function disable_filter_ev_interference( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 1
// Checksum 0x9e61d3b3, Offset: 0x2a80
// Size: 0x52
function init_filter_vehiclehijack( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_vehicle_takeover" );
    return mapped_material_id( "generic_filter_vehicle_takeover" );
}

// Namespace filter
// Params 3
// Checksum 0x2c47dc2f, Offset: 0x2ae0
// Size: 0x7c
function enable_filter_vehiclehijack( player, filterid, overlayid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_vehicle_takeover" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
}

// Namespace filter
// Params 3
// Checksum 0x45653f31, Offset: 0x2b68
// Size: 0x44
function disable_filter_vehiclehijack( player, filterid, overlayid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 3
// Checksum 0x82904649, Offset: 0x2bb8
// Size: 0x44
function set_filter_ev_vehiclehijack_amount( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 0, amount );
}

// Namespace filter
// Params 1
// Checksum 0x87ac373b, Offset: 0x2c08
// Size: 0x3c
function init_filter_vehicle_hijack_oor( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_vehicle_out_of_range" );
}

// Namespace filter
// Params 2
// Checksum 0xa01627fa, Offset: 0x2c50
// Size: 0x134
function enable_filter_vehicle_hijack_oor( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_vehicle_out_of_range" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
    setfilterpassconstant( player.localclientnum, filterid, 0, 1, 0 );
    setfilterpassconstant( player.localclientnum, filterid, 0, 2, 1 );
    setfilterpassconstant( player.localclientnum, filterid, 0, 3, 0 );
    setfilterpassconstant( player.localclientnum, filterid, 0, 4, -1 );
}

// Namespace filter
// Params 2
// Checksum 0x30b9d563, Offset: 0x2d90
// Size: 0x44
function set_filter_vehicle_hijack_oor_noblack( player, filterid )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 3, 1 );
}

// Namespace filter
// Params 3
// Checksum 0x1c4dd1ca, Offset: 0x2de0
// Size: 0x74
function set_filter_vehicle_hijack_oor_amount( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 0, amount );
    setfilterpassconstant( player.localclientnum, filterid, 0, 1, amount );
}

// Namespace filter
// Params 2
// Checksum 0xcad63941, Offset: 0x2e60
// Size: 0x3c
function disable_filter_vehicle_hijack_oor( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 1
// Checksum 0xd7b74551, Offset: 0x2ea8
// Size: 0x3c
function init_filter_speed_burst( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_speed_burst" );
}

// Namespace filter
// Params 2
// Checksum 0xb3be6986, Offset: 0x2ef0
// Size: 0x74
function enable_filter_speed_burst( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_speed_burst" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
}

// Namespace filter
// Params 4
// Checksum 0x972286a4, Offset: 0x2f70
// Size: 0x54
function set_filter_speed_burst( player, filterid, constantindex, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, constantindex, amount );
}

// Namespace filter
// Params 2
// Checksum 0xf4a92358, Offset: 0x2fd0
// Size: 0x3c
function disable_filter_speed_burst( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 1
// Checksum 0x1faf7a0b, Offset: 0x3018
// Size: 0x4c
function init_filter_overdrive( player )
{
    init_filter_indices();
    
    if ( sessionmodeiscampaigngame() )
    {
        map_material_helper( player, "generic_filter_overdrive_cp" );
    }
}

// Namespace filter
// Params 2
// Checksum 0x9790b0ad, Offset: 0x3070
// Size: 0x74
function enable_filter_overdrive( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_overdrive_cp" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
}

// Namespace filter
// Params 4
// Checksum 0x7e858ed, Offset: 0x30f0
// Size: 0x54
function set_filter_overdrive( player, filterid, constantindex, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, constantindex, amount );
}

// Namespace filter
// Params 2
// Checksum 0x999845a0, Offset: 0x3150
// Size: 0x3c
function disable_filter_overdrive( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 1
// Checksum 0xe7755bf7, Offset: 0x3198
// Size: 0x3c
function init_filter_frost( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_frost" );
}

// Namespace filter
// Params 2
// Checksum 0x6a1fdc3, Offset: 0x31e0
// Size: 0x74
function enable_filter_frost( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_frost" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
}

// Namespace filter
// Params 3
// Checksum 0xba88d1f4, Offset: 0x3260
// Size: 0x44
function set_filter_frost_layer_one( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 0, amount );
}

// Namespace filter
// Params 3
// Checksum 0xb1309fac, Offset: 0x32b0
// Size: 0x4c
function set_filter_frost_layer_two( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 1, amount );
}

// Namespace filter
// Params 3
// Checksum 0x3947aa0d, Offset: 0x3308
// Size: 0x4c
function set_filter_frost_reveal_direction( player, filterid, direction )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 2, direction );
}

// Namespace filter
// Params 2
// Checksum 0xd672e56d, Offset: 0x3360
// Size: 0x3c
function disable_filter_frost( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 1
// Checksum 0xdff77d2b, Offset: 0x33a8
// Size: 0x3c
function init_filter_vision_pulse( localclientnum )
{
    init_filter_indices();
    map_material_helper_by_localclientnum( localclientnum, "generic_filter_vision_pulse" );
}

// Namespace filter
// Params 2
// Checksum 0x8553119e, Offset: 0x33f0
// Size: 0x84
function enable_filter_vision_pulse( localclientnum, filterid )
{
    map_material_if_undefined( localclientnum, "generic_filter_vision_pulse" );
    setfilterpassmaterial( localclientnum, filterid, 0, mapped_material_id( "generic_filter_vision_pulse" ) );
    setfilterpassenabled( localclientnum, filterid, 0, 1 );
}

// Namespace filter
// Params 4
// Checksum 0x221ed56, Offset: 0x3480
// Size: 0x4c
function set_filter_vision_pulse_constant( localclientnum, filterid, constid, value )
{
    setfilterpassconstant( localclientnum, filterid, 0, constid, value );
}

// Namespace filter
// Params 2
// Checksum 0xb70ea376, Offset: 0x34d8
// Size: 0x34
function disable_filter_vision_pulse( localclientnum, filterid )
{
    setfilterpassenabled( localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 1
// Checksum 0x27b06eba, Offset: 0x3518
// Size: 0x3c
function init_filter_sprite_transition( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_transition_sprite" );
}

// Namespace filter
// Params 2
// Checksum 0x9cd8ba38, Offset: 0x3560
// Size: 0x9c
function enable_filter_sprite_transition( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 1, mapped_material_id( "generic_filter_transition_sprite" ) );
    setfilterpassenabled( player.localclientnum, filterid, 1, 1 );
    setfilterpassquads( player.localclientnum, filterid, 1, 2048 );
}

// Namespace filter
// Params 3
// Checksum 0xfdf7f0d7, Offset: 0x3608
// Size: 0x4c
function set_filter_sprite_transition_octogons( player, filterid, octos )
{
    setfilterpassconstant( player.localclientnum, filterid, 1, 0, octos );
}

// Namespace filter
// Params 3
// Checksum 0xd51706d3, Offset: 0x3660
// Size: 0x4c
function set_filter_sprite_transition_blur( player, filterid, blur )
{
    setfilterpassconstant( player.localclientnum, filterid, 1, 1, blur );
}

// Namespace filter
// Params 3
// Checksum 0xdae9b14c, Offset: 0x36b8
// Size: 0x4c
function set_filter_sprite_transition_boost( player, filterid, boost )
{
    setfilterpassconstant( player.localclientnum, filterid, 1, 2, boost );
}

// Namespace filter
// Params 4
// Checksum 0xecf5f5f9, Offset: 0x3710
// Size: 0x84
function set_filter_sprite_transition_move_radii( player, filterid, inner, outter )
{
    setfilterpassconstant( player.localclientnum, filterid, 1, 24, inner );
    setfilterpassconstant( player.localclientnum, filterid, 1, 25, outter );
}

// Namespace filter
// Params 3
// Checksum 0x37af8ee, Offset: 0x37a0
// Size: 0x4c
function set_filter_sprite_transition_elapsed( player, filterid, time )
{
    setfilterpassconstant( player.localclientnum, filterid, 1, 28, time );
}

// Namespace filter
// Params 2
// Checksum 0x17318892, Offset: 0x37f8
// Size: 0x3c
function disable_filter_sprite_transition( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 1, 0 );
}

// Namespace filter
// Params 1
// Checksum 0x6d90db4c, Offset: 0x3840
// Size: 0x3c
function init_filter_frame_transition( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_transition_frame" );
}

// Namespace filter
// Params 2
// Checksum 0x10ed44e1, Offset: 0x3888
// Size: 0x74
function enable_filter_frame_transition( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 2, mapped_material_id( "generic_filter_transition_frame" ) );
    setfilterpassenabled( player.localclientnum, filterid, 2, 1 );
}

// Namespace filter
// Params 3
// Checksum 0xf821c3fa, Offset: 0x3908
// Size: 0x4c
function set_filter_frame_transition_heavy_hexagons( player, filterid, hexes )
{
    setfilterpassconstant( player.localclientnum, filterid, 2, 0, hexes );
}

// Namespace filter
// Params 3
// Checksum 0xf1941654, Offset: 0x3960
// Size: 0x4c
function set_filter_frame_transition_light_hexagons( player, filterid, hexes )
{
    setfilterpassconstant( player.localclientnum, filterid, 2, 1, hexes );
}

// Namespace filter
// Params 3
// Checksum 0xbef0cefe, Offset: 0x39b8
// Size: 0x4c
function set_filter_frame_transition_flare( player, filterid, opacity )
{
    setfilterpassconstant( player.localclientnum, filterid, 2, 2, opacity );
}

// Namespace filter
// Params 3
// Checksum 0xd5006c4e, Offset: 0x3a10
// Size: 0x4c
function set_filter_frame_transition_blur( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 2, 3, amount );
}

// Namespace filter
// Params 3
// Checksum 0x77dcb3e1, Offset: 0x3a68
// Size: 0x4c
function set_filter_frame_transition_iris( player, filterid, opacity )
{
    setfilterpassconstant( player.localclientnum, filterid, 2, 4, opacity );
}

// Namespace filter
// Params 3
// Checksum 0xc4df8919, Offset: 0x3ac0
// Size: 0x4c
function set_filter_frame_transition_saved_frame_reveal( player, filterid, reveal )
{
    setfilterpassconstant( player.localclientnum, filterid, 2, 5, reveal );
}

// Namespace filter
// Params 3
// Checksum 0xccb0b10d, Offset: 0x3b18
// Size: 0x4c
function set_filter_frame_transition_warp( player, filterid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, 2, 6, amount );
}

// Namespace filter
// Params 2
// Checksum 0x87612297, Offset: 0x3b70
// Size: 0x3c
function disable_filter_frame_transition( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 2, 0 );
}

// Namespace filter
// Params 1
// Checksum 0xae5e92f6, Offset: 0x3bb8
// Size: 0x3c
function init_filter_base_frame_transition( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_transition_frame_base" );
}

// Namespace filter
// Params 2
// Checksum 0xfe308fc7, Offset: 0x3c00
// Size: 0x74
function enable_filter_base_frame_transition( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_transition_frame_base" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
}

// Namespace filter
// Params 3
// Checksum 0x5159d083, Offset: 0x3c80
// Size: 0x44
function set_filter_base_frame_transition_warp( player, filterid, warp )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 0, warp );
}

// Namespace filter
// Params 3
// Checksum 0x3bbe90d3, Offset: 0x3cd0
// Size: 0x4c
function set_filter_base_frame_transition_boost( player, filterid, boost )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 1, boost );
}

// Namespace filter
// Params 3
// Checksum 0x4d063a75, Offset: 0x3d28
// Size: 0x4c
function set_filter_base_frame_transition_durden( player, filterid, opacity )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 2, opacity );
}

// Namespace filter
// Params 3
// Checksum 0x5d4db11b, Offset: 0x3d80
// Size: 0x4c
function set_filter_base_frame_transition_durden_blur( player, filterid, blur )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 3, blur );
}

// Namespace filter
// Params 2
// Checksum 0x800da7bf, Offset: 0x3dd8
// Size: 0x3c
function disable_filter_base_frame_transition( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 2
// Checksum 0xfd90ff8d, Offset: 0x3e20
// Size: 0x5c
function init_filter_sprite_blood( localclientnum, digitalblood )
{
    if ( digitalblood )
    {
        map_material_helper_by_localclientnum( localclientnum, "generic_filter_sprite_blood_damage_reaper" );
        return;
    }
    
    map_material_helper_by_localclientnum( localclientnum, "generic_filter_sprite_blood_damage" );
}

// Namespace filter
// Params 4
// Checksum 0xc20b52e6, Offset: 0x3e88
// Size: 0xd4
function enable_filter_sprite_blood( localclientnum, filterid, passid, digitalblood )
{
    if ( digitalblood )
    {
        setfilterpassmaterial( localclientnum, filterid, passid, mapped_material_id( "generic_filter_sprite_blood_damage_reaper" ) );
    }
    else
    {
        setfilterpassmaterial( localclientnum, filterid, passid, mapped_material_id( "generic_filter_sprite_blood_damage" ) );
    }
    
    setfilterpassenabled( localclientnum, filterid, passid, 1 );
    setfilterpassquads( localclientnum, filterid, passid, 400 );
}

// Namespace filter
// Params 2
// Checksum 0x8ce4af2f, Offset: 0x3f68
// Size: 0x5c
function init_filter_sprite_blood_heavy( localclientnum, digitalblood )
{
    if ( digitalblood )
    {
        map_material_helper_by_localclientnum( localclientnum, "generic_filter_sprite_blood_heavy_damage_reaper" );
        return;
    }
    
    map_material_helper_by_localclientnum( localclientnum, "generic_filter_sprite_blood_heavy_damage" );
}

// Namespace filter
// Params 4
// Checksum 0xc3dd809e, Offset: 0x3fd0
// Size: 0xd4
function enable_filter_sprite_blood_heavy( localclientnum, filterid, passid, digitalblood )
{
    if ( digitalblood )
    {
        setfilterpassmaterial( localclientnum, filterid, passid, mapped_material_id( "generic_filter_sprite_blood_heavy_damage_reaper" ) );
    }
    else
    {
        setfilterpassmaterial( localclientnum, filterid, passid, mapped_material_id( "generic_filter_sprite_blood_heavy_damage" ) );
    }
    
    setfilterpassenabled( localclientnum, filterid, passid, 1 );
    setfilterpassquads( localclientnum, filterid, passid, 400 );
}

// Namespace filter
// Params 4
// Checksum 0xef1b6df, Offset: 0x40b0
// Size: 0x4c
function set_filter_sprite_blood_opacity( localclientnum, filterid, passid, opacity )
{
    setfilterpassconstant( localclientnum, filterid, passid, 0, opacity );
}

// Namespace filter
// Params 4
// Checksum 0x8536a5ab, Offset: 0x4108
// Size: 0x4c
function set_filter_sprite_blood_seed_offset( localclientnum, filterid, passid, offset )
{
    setfilterpassconstant( localclientnum, filterid, passid, 26, offset );
}

// Namespace filter
// Params 4
// Checksum 0xd3338612, Offset: 0x4160
// Size: 0x4c
function set_filter_sprite_blood_elapsed( localclientnum, filterid, passid, time )
{
    setfilterpassconstant( localclientnum, filterid, passid, 28, time );
}

// Namespace filter
// Params 3
// Checksum 0xa5a9375b, Offset: 0x41b8
// Size: 0x3c
function disable_filter_sprite_blood( localclientnum, filterid, passid )
{
    setfilterpassenabled( localclientnum, filterid, passid, 0 );
}

// Namespace filter
// Params 2
// Checksum 0xb4cae356, Offset: 0x4200
// Size: 0x6c
function init_filter_feedback_blood( localclientnum, digitalblood )
{
    init_filter_indices();
    
    if ( digitalblood )
    {
        map_material_helper_by_localclientnum( localclientnum, "generic_filter_blood_damage_reaper" );
        return;
    }
    
    map_material_helper_by_localclientnum( localclientnum, "generic_filter_blood_damage" );
}

// Namespace filter
// Params 4
// Checksum 0x218fe9cd, Offset: 0x4278
// Size: 0xb4
function enable_filter_feedback_blood( localclientnum, filterid, passid, digitalblood )
{
    if ( digitalblood )
    {
        setfilterpassmaterial( localclientnum, filterid, passid, mapped_material_id( "generic_filter_blood_damage_reaper" ) );
    }
    else
    {
        setfilterpassmaterial( localclientnum, filterid, passid, mapped_material_id( "generic_filter_blood_damage" ) );
    }
    
    setfilterpassenabled( localclientnum, filterid, passid, 1 );
}

// Namespace filter
// Params 4
// Checksum 0xbb190130, Offset: 0x4338
// Size: 0x4c
function set_filter_feedback_blood_opacity( localclientnum, filterid, passid, opacity )
{
    setfilterpassconstant( localclientnum, filterid, passid, 0, opacity );
}

// Namespace filter
// Params 5
// Checksum 0xa3c386e3, Offset: 0x4390
// Size: 0x7c
function set_filter_feedback_blood_sundir( localclientnum, filterid, passid, pitch, yaw )
{
    setfilterpassconstant( localclientnum, filterid, passid, 1, pitch );
    setfilterpassconstant( localclientnum, filterid, passid, 2, yaw );
}

// Namespace filter
// Params 4
// Checksum 0x680dda36, Offset: 0x4418
// Size: 0x4c
function set_filter_feedback_blood_vignette( localclientnum, filterid, passid, amount )
{
    setfilterpassconstant( localclientnum, filterid, passid, 3, amount );
}

// Namespace filter
// Params 5
// Checksum 0x2209a9a2, Offset: 0x4470
// Size: 0x7c
function set_filter_feedback_blood_drowning( localclientnum, filterid, passid, tintamount, allowtint )
{
    setfilterpassconstant( localclientnum, filterid, passid, 4, tintamount );
    setfilterpassconstant( localclientnum, filterid, passid, 5, allowtint );
}

// Namespace filter
// Params 3
// Checksum 0xcd830dc2, Offset: 0x44f8
// Size: 0x3c
function disable_filter_feedback_blood( localclientnum, filterid, passid )
{
    setfilterpassenabled( localclientnum, filterid, passid, 0 );
}

// Namespace filter
// Params 1
// Checksum 0x96a0d660, Offset: 0x4540
// Size: 0x3c
function init_filter_sprite_rain( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_sprite_rain" );
}

// Namespace filter
// Params 2
// Checksum 0x11e36924, Offset: 0x4588
// Size: 0x9c
function enable_filter_sprite_rain( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_sprite_rain" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
    setfilterpassquads( player.localclientnum, filterid, 0, 2048 );
}

// Namespace filter
// Params 3
// Checksum 0x5985b593, Offset: 0x4630
// Size: 0x44
function set_filter_sprite_rain_opacity( player, filterid, opacity )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 0, opacity );
}

// Namespace filter
// Params 3
// Checksum 0xa59ceb44, Offset: 0x4680
// Size: 0x4c
function set_filter_sprite_rain_seed_offset( player, filterid, offset )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 26, offset );
}

// Namespace filter
// Params 3
// Checksum 0xa82cde89, Offset: 0x46d8
// Size: 0x4c
function set_filter_sprite_rain_elapsed( player, filterid, time )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 28, time );
}

// Namespace filter
// Params 2
// Checksum 0x94b6ed5d, Offset: 0x4730
// Size: 0x3c
function disable_filter_sprite_rain( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 1
// Checksum 0x1d5f42bb, Offset: 0x4778
// Size: 0x3c
function init_filter_sgen_sprite_rain( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_blkstn_sprite_rain" );
}

// Namespace filter
// Params 2
// Checksum 0x8286419c, Offset: 0x47c0
// Size: 0x9c
function enable_filter_sgen_sprite_rain( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_blkstn_sprite_rain" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
    setfilterpassquads( player.localclientnum, filterid, 0, 2048 );
}

// Namespace filter
// Params 1
// Checksum 0x64fee71d, Offset: 0x4868
// Size: 0x3c
function init_filter_sprite_dirt( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_sprite_dirt" );
}

// Namespace filter
// Params 2
// Checksum 0xab94915b, Offset: 0x48b0
// Size: 0x9c
function enable_filter_sprite_dirt( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_sprite_dirt" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
    setfilterpassquads( player.localclientnum, filterid, 0, 400 );
}

// Namespace filter
// Params 3
// Checksum 0xd3ba8249, Offset: 0x4958
// Size: 0x44
function set_filter_sprite_dirt_opacity( player, filterid, opacity )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 0, opacity );
}

// Namespace filter
// Params 5
// Checksum 0xa53df005, Offset: 0x49a8
// Size: 0xbc
function set_filter_sprite_dirt_source_position( player, filterid, right, up, distance )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 1, right );
    setfilterpassconstant( player.localclientnum, filterid, 0, 2, up );
    setfilterpassconstant( player.localclientnum, filterid, 0, 3, distance );
}

// Namespace filter
// Params 4
// Checksum 0xe0356e5, Offset: 0x4a70
// Size: 0x84
function set_filter_sprite_dirt_sun_position( player, filterid, pitch, yaw )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 4, pitch );
    setfilterpassconstant( player.localclientnum, filterid, 0, 5, yaw );
}

// Namespace filter
// Params 3
// Checksum 0x8b28048d, Offset: 0x4b00
// Size: 0x4c
function set_filter_sprite_dirt_seed_offset( player, filterid, offset )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 26, offset );
}

// Namespace filter
// Params 3
// Checksum 0x875c6b30, Offset: 0x4b58
// Size: 0x4c
function set_filter_sprite_dirt_elapsed( player, filterid, time )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 28, time );
}

// Namespace filter
// Params 2
// Checksum 0x93a61b67, Offset: 0x4bb0
// Size: 0x3c
function disable_filter_sprite_dirt( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 1
// Checksum 0x9b763238, Offset: 0x4bf8
// Size: 0x3c
function init_filter_blood_spatter( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_blood_spatter" );
}

// Namespace filter
// Params 2
// Checksum 0xea29c0eb, Offset: 0x4c40
// Size: 0x74
function enable_filter_blood_spatter( player, filterid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, mapped_material_id( "generic_filter_blood_spatter" ) );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
}

// Namespace filter
// Params 4
// Checksum 0xb661dd1a, Offset: 0x4cc0
// Size: 0x7c
function set_filter_blood_spatter_reveal( player, filterid, threshold, direction )
{
    setfilterpassconstant( player.localclientnum, filterid, 0, 0, threshold );
    setfilterpassconstant( player.localclientnum, filterid, 0, 1, direction );
}

// Namespace filter
// Params 2
// Checksum 0x4db16ac6, Offset: 0x4d48
// Size: 0x3c
function disable_filter_blood_spatter( player, filterid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

// Namespace filter
// Params 1
// Checksum 0xf09b2748, Offset: 0x4d90
// Size: 0x3c
function init_filter_teleporter_base( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_zm_teleporter_base" );
}

// Namespace filter
// Params 3
// Checksum 0xf3c2ec63, Offset: 0x4dd8
// Size: 0x7c
function enable_filter_teleporter_base( player, filterid, passid )
{
    setfilterpassmaterial( player.localclientnum, filterid, passid, mapped_material_id( "generic_filter_zm_teleporter_base" ) );
    setfilterpassenabled( player.localclientnum, filterid, passid, 1 );
}

// Namespace filter
// Params 4
// Checksum 0x612553d2, Offset: 0x4e60
// Size: 0x54
function set_filter_teleporter_base_amount( player, filterid, passid, amount )
{
    setfilterpassconstant( player.localclientnum, filterid, passid, 0, amount );
}

// Namespace filter
// Params 3
// Checksum 0x910852c, Offset: 0x4ec0
// Size: 0x44
function disable_filter_teleporter_base( player, filterid, passid )
{
    setfilterpassenabled( player.localclientnum, filterid, passid, 0 );
}

// Namespace filter
// Params 1
// Checksum 0xeb306675, Offset: 0x4f10
// Size: 0x3c
function init_filter_teleporter_sprite( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_zm_teleporter_sprite" );
}

// Namespace filter
// Params 3
// Checksum 0x29a8b6d5, Offset: 0x4f58
// Size: 0xa4
function enable_filter_teleporter_sprite( player, filterid, passid )
{
    setfilterpassmaterial( player.localclientnum, filterid, passid, mapped_material_id( "generic_filter_zm_teleporter_sprite" ) );
    setfilterpassenabled( player.localclientnum, filterid, passid, 1 );
    setfilterpassquads( player.localclientnum, filterid, passid, 400 );
}

// Namespace filter
// Params 4
// Checksum 0x5c8f0df5, Offset: 0x5008
// Size: 0x54
function set_filter_teleporter_sprite_opacity( player, filterid, passid, opacity )
{
    setfilterpassconstant( player.localclientnum, filterid, passid, 0, opacity );
}

// Namespace filter
// Params 4
// Checksum 0x5aeac5df, Offset: 0x5068
// Size: 0x54
function set_filter_teleporter_sprite_seed_offset( player, filterid, passid, offset )
{
    setfilterpassconstant( player.localclientnum, filterid, passid, 26, offset );
}

// Namespace filter
// Params 4
// Checksum 0x8ea81183, Offset: 0x50c8
// Size: 0x54
function set_filter_teleporter_sprite_elapsed( player, filterid, passid, time )
{
    setfilterpassconstant( player.localclientnum, filterid, passid, 28, time );
}

// Namespace filter
// Params 3
// Checksum 0x80cfeaa5, Offset: 0x5128
// Size: 0x44
function disable_filter_teleporter_sprite( player, filterid, passid )
{
    setfilterpassenabled( player.localclientnum, filterid, passid, 0 );
}

// Namespace filter
// Params 1
// Checksum 0xf0d1d8a1, Offset: 0x5178
// Size: 0x3c
function init_filter_teleporter_top( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_zm_teleporter_base" );
}

// Namespace filter
// Params 3
// Checksum 0x45b3a1cd, Offset: 0x51c0
// Size: 0x7c
function enable_filter_teleporter_top( player, filterid, passid )
{
    setfilterpassmaterial( player.localclientnum, filterid, passid, mapped_material_id( "generic_filter_zm_teleporter_base" ) );
    setfilterpassenabled( player.localclientnum, filterid, passid, 1 );
}

// Namespace filter
// Params 5
// Checksum 0x1e7ceb51, Offset: 0x5248
// Size: 0x8c
function set_filter_teleporter_top_reveal( player, filterid, passid, threshold, direction )
{
    setfilterpassconstant( player.localclientnum, filterid, passid, 0, threshold );
    setfilterpassconstant( player.localclientnum, filterid, passid, 1, direction );
}

// Namespace filter
// Params 3
// Checksum 0xd48c270e, Offset: 0x52e0
// Size: 0x44
function disable_filter_teleporter_top( player, filterid, passid )
{
    setfilterpassenabled( player.localclientnum, filterid, passid, 0 );
}

// Namespace filter
// Params 1
// Checksum 0x9cd8d46e, Offset: 0x5330
// Size: 0x3c
function init_filter_keyline_blend( player )
{
    init_filter_indices();
    map_material_helper( player, "postfx_keyline_blend" );
}

// Namespace filter
// Params 3
// Checksum 0x3bf3d22, Offset: 0x5378
// Size: 0x7c
function enable_filter_keyline_blend( player, filterid, passid )
{
    setfilterpassmaterial( player.localclientnum, filterid, passid, mapped_material_id( "postfx_keyline_blend" ) );
    setfilterpassenabled( player.localclientnum, filterid, passid, 1 );
}

// Namespace filter
// Params 4
// Checksum 0xab064b86, Offset: 0x5400
// Size: 0x54
function set_filter_keyline_blend_opacity( player, filterid, passid, opacity )
{
    setfilterpassconstant( player.localclientnum, filterid, passid, 0, opacity );
}

// Namespace filter
// Params 3
// Checksum 0x1d4767fe, Offset: 0x5460
// Size: 0x44
function disable_filter_keyline_blend( player, filterid, passid )
{
    setfilterpassenabled( player.localclientnum, filterid, passid, 0 );
}

// Namespace filter
// Params 1
// Checksum 0x154ce281, Offset: 0x54b0
// Size: 0x3c
function init_filter_drowning_damage( localclientnum )
{
    init_filter_indices();
    map_material_helper_by_localclientnum( localclientnum, "generic_filter_drowning" );
}

// Namespace filter
// Params 2
// Checksum 0xa77c970b, Offset: 0x54f8
// Size: 0x6c
function enable_filter_drowning_damage( localclientnum, passid )
{
    setfilterpassmaterial( localclientnum, 5, passid, mapped_material_id( "generic_filter_drowning" ) );
    setfilterpassenabled( localclientnum, 5, passid, 1, 0, 1 );
}

// Namespace filter
// Params 3
// Checksum 0xb7240302, Offset: 0x5570
// Size: 0x44
function set_filter_drowning_damage_opacity( localclientnum, passid, opacity )
{
    setfilterpassconstant( localclientnum, 5, passid, 0, opacity );
}

// Namespace filter
// Params 3
// Checksum 0x9a686710, Offset: 0x55c0
// Size: 0x44
function set_filter_drowning_damage_inner_radius( localclientnum, passid, inner )
{
    setfilterpassconstant( localclientnum, 5, passid, 1, inner );
}

// Namespace filter
// Params 3
// Checksum 0x479ca350, Offset: 0x5610
// Size: 0x44
function set_filter_drowning_damage_outer_radius( localclientnum, passid, outer )
{
    setfilterpassconstant( localclientnum, 5, passid, 2, outer );
}

// Namespace filter
// Params 2
// Checksum 0xc79f0207, Offset: 0x5660
// Size: 0x34
function disable_filter_drowning_damage( localclientnum, passid )
{
    setfilterpassenabled( localclientnum, 5, passid, 0 );
}

