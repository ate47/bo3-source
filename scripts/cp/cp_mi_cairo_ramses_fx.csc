#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/fx_shared;

#namespace cp_mi_cairo_ramses_fx;

// Namespace cp_mi_cairo_ramses_fx
// Params 0
// Checksum 0x6d6db820, Offset: 0x108
// Size: 0x94
function main()
{
    clientfield::register( "world", "defend_fog_banks", 1, 1, "int", &station_defend_lighting, 0, 0 );
    clientfield::register( "world", "start_fog_banks", 1, 1, "int", &station_start_lighting, 0, 0 );
}

// Namespace cp_mi_cairo_ramses_fx
// Params 7
// Checksum 0x5cc72003, Offset: 0x1a8
// Size: 0xce
function station_defend_lighting( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    for ( localclientnum = 0; localclientnum < level.localplayers.size ; localclientnum++ )
    {
        setlitfogbank( localclientnum, -1, 1, 1 );
        setworldfogactivebank( localclientnum, 2 );
        setexposureactivebank( localclientnum, 2 );
        setpbgactivebank( localclientnum, 2 );
    }
}

// Namespace cp_mi_cairo_ramses_fx
// Params 7
// Checksum 0xc03e9b45, Offset: 0x280
// Size: 0xc6
function station_start_lighting( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    for ( localclientnum = 0; localclientnum < level.localplayers.size ; localclientnum++ )
    {
        setlitfogbank( localclientnum, -1, 0, 1 );
        setworldfogactivebank( localclientnum, 1 );
        setexposureactivebank( localclientnum, 1 );
        setpbgactivebank( localclientnum, 1 );
    }
}

