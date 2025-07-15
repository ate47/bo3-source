#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;
#using scripts/shared/system_shared;

#namespace footsteps;

// Namespace footsteps
// Params 0, eflags: 0x2
// Checksum 0x1b3a7c62, Offset: 0x170
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "footsteps", &__init__, undefined, undefined );
}

// Namespace footsteps
// Params 0
// Checksum 0x2356d33, Offset: 0x1b0
// Size: 0x19e
function __init__()
{
    surfacearray = getsurfacestrings();
    movementarray = [];
    movementarray[ movementarray.size ] = "step_run";
    movementarray[ movementarray.size ] = "land";
    level.playerfootsounds = [];
    
    for ( movementarrayindex = 0; movementarrayindex < movementarray.size ; movementarrayindex++ )
    {
        movementtype = movementarray[ movementarrayindex ];
        
        for ( surfacearrayindex = 0; surfacearrayindex < surfacearray.size ; surfacearrayindex++ )
        {
            surfacetype = surfacearray[ surfacearrayindex ];
            
            for ( index = 0; index < 4 ; index++ )
            {
                if ( index < 2 )
                {
                    firstperson = 0;
                }
                else
                {
                    firstperson = 1;
                }
                
                if ( index % 2 == 0 )
                {
                    islouder = 0;
                }
                else
                {
                    islouder = 1;
                }
                
                snd = buildandcachesoundalias( movementtype, surfacetype, firstperson, islouder );
            }
        }
    }
}

/#

    // Namespace footsteps
    // Params 2
    // Checksum 0xe57ee82, Offset: 0x358
    // Size: 0x114, Type: dev
    function checksurfacetypeiscorrect( movetype, surfacetype )
    {
        if ( !isdefined( level.playerfootsounds[ movetype ][ surfacetype ] ) )
        {
            println( "<dev string:x28>" + surfacetype + "<dev string:x3e>" );
            println( "<dev string:x63>" );
            println( "<dev string:x7b>" );
            arraykeys = getarraykeys( level.playerfootsounds[ movetype ] );
            
            for ( i = 0; i < arraykeys.size ; i++ )
            {
                println( arraykeys[ i ] );
            }
            
            println( "<dev string:x84>" );
        }
    }

#/

// Namespace footsteps
// Params 6
// Checksum 0x41c9c4e9, Offset: 0x478
// Size: 0xcc
function playerjump( client_num, player, surfacetype, firstperson, quiet, islouder )
{
    if ( isdefined( player.audiomaterialoverride ) )
    {
        surfacetype = player.audiomaterialoverride;
        
        /#
            checksurfacetypeiscorrect( "<dev string:x8b>", surfacetype );
        #/
    }
    
    sound_alias = level.playerfootsounds[ "step_run" ][ surfacetype ][ firstperson ][ islouder ];
    player playsound( client_num, sound_alias );
}

// Namespace footsteps
// Params 7
// Checksum 0x804095fa, Offset: 0x550
// Size: 0x1d4
function playerland( client_num, player, surfacetype, firstperson, quiet, damageplayer, islouder )
{
    if ( isdefined( player.audiomaterialoverride ) )
    {
        surfacetype = player.audiomaterialoverride;
        
        /#
            checksurfacetypeiscorrect( "<dev string:x94>", surfacetype );
        #/
    }
    
    sound_alias = level.playerfootsounds[ "land" ][ surfacetype ][ firstperson ][ islouder ];
    player playsound( client_num, sound_alias );
    
    if ( isdefined( player.step_sound ) && !quiet && player.step_sound != "none" )
    {
        volume = audio::get_vol_from_speed( player );
        player playsound( client_num, player.step_sound, player.origin, volume );
    }
    
    if ( damageplayer )
    {
        if ( isdefined( level.playerfalldamagesound ) )
        {
            player [[ level.playerfalldamagesound ]]( client_num, firstperson );
            return;
        }
        
        sound_alias = "fly_land_damage_npc";
        
        if ( firstperson )
        {
            sound_alias = "fly_land_damage_plr";
            player playsound( client_num, sound_alias );
        }
    }
}

// Namespace footsteps
// Params 4
// Checksum 0xe83c03c1, Offset: 0x730
// Size: 0x9c
function playerfoliage( client_num, player, firstperson, quiet )
{
    sound_alias = "fly_movement_foliage_npc";
    
    if ( firstperson )
    {
        sound_alias = "fly_movement_foliage_plr";
    }
    
    volume = audio::get_vol_from_speed( player );
    player playsound( client_num, sound_alias, player.origin, volume );
}

// Namespace footsteps
// Params 4
// Checksum 0x19e5897, Offset: 0x7d8
// Size: 0x234
function buildandcachesoundalias( movementtype, surfacetype, firstperson, islouder )
{
    sound_alias = "fly_" + movementtype;
    
    if ( firstperson )
    {
        sound_alias += "_plr_";
    }
    else
    {
        sound_alias += "_npc_";
    }
    
    sound_alias += surfacetype;
    
    if ( !isdefined( level.playerfootsounds ) )
    {
        level.playerfootsounds = [];
    }
    
    if ( !isdefined( level.playerfootsounds[ movementtype ] ) )
    {
        level.playerfootsounds[ movementtype ] = [];
    }
    
    if ( !isdefined( level.playerfootsounds[ movementtype ][ surfacetype ] ) )
    {
        level.playerfootsounds[ movementtype ][ surfacetype ] = [];
    }
    
    if ( !isdefined( level.playerfootsounds[ movementtype ][ surfacetype ][ firstperson ] ) )
    {
        level.playerfootsounds[ movementtype ][ surfacetype ][ firstperson ] = [];
    }
    
    assert( isarray( level.playerfootsounds ) );
    assert( isarray( level.playerfootsounds[ movementtype ] ) );
    assert( isarray( level.playerfootsounds[ movementtype ][ surfacetype ] ) );
    assert( isarray( level.playerfootsounds[ movementtype ][ surfacetype ][ firstperson ] ) );
    level.playerfootsounds[ movementtype ][ surfacetype ][ firstperson ][ islouder ] = sound_alias;
    return sound_alias;
}

// Namespace footsteps
// Params 4
// Checksum 0x681fd8a3, Offset: 0xa18
// Size: 0x158
function do_foot_effect( client_num, ground_type, foot_pos, on_fire )
{
    if ( !isdefined( level._optionalstepeffects ) )
    {
        return;
    }
    
    if ( on_fire )
    {
        ground_type = "fire";
    }
    
    /#
        if ( getdvarint( "<dev string:x99>" ) )
        {
            print3d( foot_pos, ground_type, ( 0.5, 0.5, 0.8 ), 1, 3, 30 );
        }
    #/
    
    for ( i = 0; i < level._optionalstepeffects.size ; i++ )
    {
        if ( level._optionalstepeffects[ i ] == ground_type )
        {
            effect = "fly_step_" + ground_type;
            
            if ( isdefined( level._effect[ effect ] ) )
            {
                playfx( client_num, level._effect[ effect ], foot_pos, foot_pos + ( 0, 0, 100 ) );
                return;
            }
        }
    }
}

// Namespace footsteps
// Params 0
// Checksum 0x2e5c63dc, Offset: 0xb78
// Size: 0x6c
function missing_ai_footstep_callback()
{
    /#
        type = self.archetype;
        
        if ( !isdefined( type ) )
        {
            type = "<dev string:xac>";
        }
        
        println( "<dev string:xb4>" + type + "<dev string:xc3>" + self._aitype + "<dev string:x147>" );
    #/
}

// Namespace footsteps
// Params 5
// Checksum 0xced7a97a, Offset: 0xbf0
// Size: 0xe2
function playaifootstep( client_num, pos, surface, notetrack, bone )
{
    if ( !isdefined( self.archetype ) )
    {
        println( "<dev string:x175>" );
        footstepdoeverything();
        return;
    }
    
    if ( !isdefined( level._footstepcbfuncs ) || !isdefined( level._footstepcbfuncs[ self.archetype ] ) )
    {
        self missing_ai_footstep_callback();
        footstepdoeverything();
        return;
    }
    
    [[ level._footstepcbfuncs[ self.archetype ] ]]( client_num, pos, surface, notetrack, bone );
}

