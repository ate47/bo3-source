#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace underwater;

// Namespace underwater
// Params 0
// Checksum 0x443e33b3, Offset: 0x2f0
// Size: 0x14
function main()
{
    init_clientfields();
}

// Namespace underwater
// Params 0
// Checksum 0x4d4e0d61, Offset: 0x310
// Size: 0x94
function init_clientfields()
{
    clientfield::register( "world", "infection_underwater_debris", 1, 1, "int", &handle_underwater_debris, 1, 1 );
    clientfield::register( "toplayer", "water_motes", 1, 1, "int", &water_motes, 0, 0 );
}

// Namespace underwater
// Params 7
// Checksum 0x453681c2, Offset: 0x3b0
// Size: 0x14a
function handle_underwater_debris( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !isdefined( newval ) )
    {
        return;
    }
    
    if ( oldval != newval )
    {
        a_players = getlocalplayers();
        
        foreach ( player in a_players )
        {
            var_ae6a34c0 = player getlocalclientnumber();
            
            if ( newval )
            {
                player thread underwater_debris_init( var_ae6a34c0 );
                continue;
            }
            
            player thread underwater_cleanup( var_ae6a34c0 );
        }
    }
}

// Namespace underwater
// Params 1
// Checksum 0xe087f70d, Offset: 0x508
// Size: 0x434
function underwater_debris_init( localclientnum )
{
    debris = [];
    level._effect[ "bubbles_pews" ] = "water/fx_water_bubbles_debris_50x10";
    level._effect[ "bubbles_body" ] = "water/fx_water_bubbles_debris_body";
    level._effect[ "bubbles_books" ] = "water/fx_water_bubbles_debris_sm";
    position = struct::get_array( "underwater_debris" );
    
    for ( i = 0; i < position.size ; i++ )
    {
        if ( isdefined( position[ i ].model ) )
        {
            junk = spawn( localclientnum, position[ i ].origin, "script_model" );
            junk setmodel( position[ i ].model );
            junk.targetname = position[ i ].targetname;
            
            if ( junk.model === "c_ger_winter_soldier_1_body" )
            {
                junk thread scene::play( "cin_gen_ambient_float01", junk );
                junk.sfx_id = playfxontag( localclientnum, level._effect[ "bubbles_body" ], junk, "tag_origin" );
            }
            else if ( junk.model === "c_ger_winter_soldier_2_body" )
            {
                junk thread scene::play( "cin_gen_ambient_float02", junk );
                junk.sfx_id = playfxontag( localclientnum, level._effect[ "bubbles_body" ], junk, "tag_origin" );
            }
            else if ( junk.model === "p7_church_pew_01" )
            {
                junk.sfx_id = playfxontag( localclientnum, level._effect[ "bubbles_pews" ], junk, "tag_origin" );
            }
            else if ( junk.model === "p7_book_vintage_02_burn" )
            {
                junk.sfx_id = playfxontag( localclientnum, level._effect[ "bubbles_books" ], junk, "tag_origin" );
            }
            else if ( junk.model === "p7_book_vintage_open_01_burn" )
            {
                junk.sfx_id = playfxontag( localclientnum, level._effect[ "bubbles_books" ], junk, "tag_origin" );
            }
            
            if ( isdefined( position[ i ].angles ) )
            {
                junk.angles = position[ i ].angles;
            }
            
            if ( isdefined( position[ i ].script_noteworthy ) )
            {
                junk.script_noteworthy = position[ i ].script_noteworthy;
            }
            
            array::add( debris, junk, 0 );
        }
    }
    
    array::thread_all( debris, &underwater_debris_move );
}

// Namespace underwater
// Params 0
// Checksum 0xbd01168a, Offset: 0x948
// Size: 0x124
function underwater_debris_move()
{
    level endon( #"underwater_move_done" );
    bottom = bullettrace( self.origin, self.origin + ( 0, 0, -1500 ), 0, undefined );
    self moveto( bottom[ "position" ], 60 );
    
    while ( true )
    {
        time = randomfloatrange( 4, 6 );
        self rotateto( self.angles + ( randomfloatrange( -30, 30 ), randomfloatrange( -30, 30 ), randomfloatrange( -30, 30 ) ), time );
        self waittill( #"rotatedone" );
    }
}

// Namespace underwater
// Params 1
// Checksum 0x9c1893c3, Offset: 0xa78
// Size: 0x134
function underwater_cleanup( localclientnum )
{
    a_debris = getentarray( localclientnum, "underwater_debris", "targetname" );
    
    if ( isdefined( a_debris ) )
    {
        for ( i = 0; i < a_debris.size ; i++ )
        {
            if ( a_debris[ i ] scene::is_playing() )
            {
                a_debris[ i ] scene::stop();
            }
            
            if ( isdefined( a_debris[ i ].sfx_id ) )
            {
                deletefx( localclientnum, a_debris[ i ].sfx_id, 0 );
                a_debris[ i ].sfx_id = undefined;
            }
            
            a_debris[ i ] delete();
        }
    }
    
    stopwatersheetingfx( localclientnum );
}

// Namespace underwater
// Params 7
// Checksum 0xf898cfaf, Offset: 0xbb8
// Size: 0xb4
function water_motes( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval != 0 )
    {
        self.var_8e8c7340 = playfxoncamera( localclientnum, level._effect[ "water_motes" ], ( 0, 0, 0 ), ( 1, 0, 0 ), ( 0, 0, 1 ) );
        return;
    }
    
    if ( isdefined( self.var_8e8c7340 ) )
    {
        deletefx( localclientnum, self.var_8e8c7340, 1 );
    }
}

