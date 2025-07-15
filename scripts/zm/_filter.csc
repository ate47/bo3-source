#using scripts/codescripts/struct;
#using scripts/shared/filter_shared;

#namespace filter;

// Namespace filter
// Params 1
// Checksum 0x54402168, Offset: 0xc0
// Size: 0x3c
function init_filter_zm_turned( player )
{
    init_filter_indices();
    map_material_helper( player, "generic_filter_zm_turned" );
}

// Namespace filter
// Params 3
// Checksum 0xc5533eb0, Offset: 0x108
// Size: 0x7c
function enable_filter_zm_turned( player, filterid, overlayid )
{
    setfilterpassmaterial( player.localclientnum, filterid, 0, level.filter_matid[ "generic_filter_zm_turned" ] );
    setfilterpassenabled( player.localclientnum, filterid, 0, 1 );
}

// Namespace filter
// Params 3
// Checksum 0x21d2bedc, Offset: 0x190
// Size: 0x44
function disable_filter_zm_turned( player, filterid, overlayid )
{
    setfilterpassenabled( player.localclientnum, filterid, 0, 0 );
}

