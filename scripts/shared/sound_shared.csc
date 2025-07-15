#namespace sound;

// Namespace sound
// Params 4
// Checksum 0x9063c75e, Offset: 0x80
// Size: 0x94
function loop_fx_sound( clientnum, alias, origin, ender )
{
    sound_entity = spawn( clientnum, origin, "script_origin" );
    
    if ( isdefined( ender ) )
    {
        thread loop_delete( ender, sound_entity );
        self endon( ender );
    }
    
    sound_entity playloopsound( alias );
}

// Namespace sound
// Params 3
// Checksum 0x6d5e6bba, Offset: 0x120
// Size: 0x3c
function play_in_space( localclientnum, alias, origin )
{
    playsound( localclientnum, alias, origin );
}

// Namespace sound
// Params 2
// Checksum 0xd672eb05, Offset: 0x168
// Size: 0x34
function loop_delete( ender, sound_entity )
{
    self waittill( ender );
    sound_entity delete();
}

// Namespace sound
// Params 1
// Checksum 0xa45c4987, Offset: 0x1a8
// Size: 0x4c
function play_on_client( sound_alias )
{
    players = level.localplayers;
    playsound( 0, sound_alias, players[ 0 ].origin );
}

// Namespace sound
// Params 4
// Checksum 0x71dc55a7, Offset: 0x200
// Size: 0x82
function loop_on_client( sound_alias, min_delay, max_delay, end_on )
{
    players = level.localplayers;
    
    if ( isdefined( end_on ) )
    {
        level endon( end_on );
    }
    
    for ( ;; )
    {
        play_on_client( sound_alias );
        wait min_delay + randomfloat( max_delay );
    }
}

