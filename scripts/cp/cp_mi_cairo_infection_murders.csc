#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace blackstation_murders;

// Namespace blackstation_murders
// Params 0
// Checksum 0x3ccb0279, Offset: 0x238
// Size: 0x14
function main()
{
    init_clientfields();
}

// Namespace blackstation_murders
// Params 0
// Checksum 0xb9a54cb0, Offset: 0x258
// Size: 0x16c
function init_clientfields()
{
    clientfield::register( "world", "black_station_ceiling_fxanim", 1, 2, "int", &black_station_ceiling_fxanim, 1, 0 );
    clientfield::register( "world", "igc_blackscreen_fade_in", 1, 1, "counter", &function_9eb32c49, 0, 0 );
    clientfield::register( "world", "igc_blackscreen_fade_in_immediate", 1, 1, "counter", &function_d2f9a5e3, 0, 0 );
    clientfield::register( "world", "igc_blackscreen_fade_out_immediate", 1, 1, "counter", &function_22cced56, 0, 0 );
    clientfield::register( "toplayer", "japanese_graphic_content_hide", 1, 1, "int", &function_f1acb728, 1, 1 );
}

// Namespace blackstation_murders
// Params 7
// Checksum 0x1bc609ac, Offset: 0x3d0
// Size: 0xa4
function black_station_ceiling_fxanim( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( oldval == newval )
    {
        return;
    }
    
    if ( newval == 1 )
    {
        level thread scene::init( "p7_fxanim_cp_infection_ceiling_open_bundle" );
        return;
    }
    
    if ( newval == 2 )
    {
        level thread scene::play( "p7_fxanim_cp_infection_ceiling_open_bundle" );
    }
}

// Namespace blackstation_murders
// Params 7
// Checksum 0xc1f70c3e, Offset: 0x480
// Size: 0xbc
function function_f1acb728( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( bnewent )
    {
        return;
    }
    
    if ( util::is_gib_restricted_build() )
    {
        if ( newval == 1 )
        {
            self lui::screen_fade_out( 0, "black" );
            return;
        }
        
        if ( newval == 0 )
        {
            self lui::screen_fade_in( 0, "black" );
        }
    }
}

// Namespace blackstation_murders
// Params 7
// Checksum 0xc2d2725b, Offset: 0x548
// Size: 0x84
function function_9eb32c49( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = getlocalplayer( localclientnum );
    player lui::screen_fade_in( 0.2, "black" );
}

// Namespace blackstation_murders
// Params 7
// Checksum 0x7d95a1cf, Offset: 0x5d8
// Size: 0x84
function function_d2f9a5e3( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = getlocalplayer( localclientnum );
    player lui::screen_fade_in( 0, "black" );
}

// Namespace blackstation_murders
// Params 7
// Checksum 0xdd9fd13e, Offset: 0x668
// Size: 0x84
function function_22cced56( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = getlocalplayer( localclientnum );
    player lui::screen_fade_out( 0, "black" );
}

