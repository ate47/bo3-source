#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_ai_monkey;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;

#namespace zm_cosmodrome_ai_monkey;

// Namespace zm_cosmodrome_ai_monkey
// Params 0
// Checksum 0x889d33bc, Offset: 0x1f8
// Size: 0x1c
function init()
{
    level.monkey_zombie_enter_level = &monkey_cosmodrome_enter_level;
}

// Namespace zm_cosmodrome_ai_monkey
// Params 0
// Checksum 0x6e75e3ce, Offset: 0x220
// Size: 0x27c
function monkey_cosmodrome_enter_level()
{
    self endon( #"death" );
    end = self monkey_lander_get_closest_dest();
    end_launch = struct::get( end.target, "targetname" );
    start_launch = end_launch.origin + ( 0, 0, 2000 );
    lander = spawn( "script_model", start_launch );
    angles = vectortoangles( end.origin - start_launch );
    lander.angles = angles;
    lander setmodel( "p7_fxanim_zm_asc_lander_crash_mod" );
    lander hide();
    lander thread clear_lander();
    self hide();
    util::wait_network_frame();
    lander clientfield::set( "COSMO_MONKEY_LANDER_FX", 1 );
    self forceteleport( lander.origin );
    self linkto( lander );
    wait 2.5;
    lander show();
    lander moveto( end.origin, 0.6 );
    lander waittill( #"movedone" );
    lander clientfield::set( "COSMO_MONKEY_LANDER_FX", 0 );
    wait 2;
    self unlink();
    self show();
}

// Namespace zm_cosmodrome_ai_monkey
// Params 0
// Checksum 0x9ce6af15, Offset: 0x4a8
// Size: 0x4c
function clear_lander()
{
    wait 8;
    self movez( -100, 0.5 );
    self waittill( #"movedone" );
    self delete();
}

// Namespace zm_cosmodrome_ai_monkey
// Params 0
// Checksum 0xb076b3ad, Offset: 0x500
// Size: 0x1d2
function monkey_lander_get_closest_dest()
{
    if ( !isdefined( level._lander_endarray ) )
    {
        level._lander_endarray = [];
    }
    
    if ( !isdefined( level._lander_endarray[ self.script_noteworthy ] ) )
    {
        level._lander_endarray[ self.script_noteworthy ] = [];
        end_spots = struct::get_array( "monkey_land", "targetname" );
        
        for ( i = 0; i < end_spots.size ; i++ )
        {
            if ( self.script_noteworthy == end_spots[ i ].script_noteworthy )
            {
                level._lander_endarray[ self.script_noteworthy ][ level._lander_endarray[ self.script_noteworthy ].size ] = end_spots[ i ];
            }
        }
    }
    
    choice = level._lander_endarray[ self.script_noteworthy ][ 0 ];
    max_dist = 1410065408;
    
    for ( i = 0; i < level._lander_endarray[ self.script_noteworthy ].size ; i++ )
    {
        dist = distance2d( self.origin, level._lander_endarray[ self.script_noteworthy ][ i ].origin );
        
        if ( dist < max_dist )
        {
            max_dist = dist;
            choice = level._lander_endarray[ self.script_noteworthy ][ i ];
        }
    }
    
    return choice;
}

// Namespace zm_cosmodrome_ai_monkey
// Params 0
// Checksum 0x95d900d3, Offset: 0x6e0
// Size: 0x1c
function monkey_cosmodrome_prespawn()
{
    self.lander_death = &monkey_cosmodrome_lander_death;
}

// Namespace zm_cosmodrome_ai_monkey
// Params 0
// Checksum 0xc9abffa7, Offset: 0x708
// Size: 0xa4
function monkey_cosmodrome_failsafe()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( self.state != "bhb_jump" )
        {
            if ( !zm_utility::check_point_in_playable_area( self.origin ) )
            {
                break;
            }
        }
        
        wait 1;
    }
    
    assertmsg( "<dev string:x28>" + self.origin );
    self dodamage( self.health + 100, self.origin );
}

// Namespace zm_cosmodrome_ai_monkey
// Params 0
// Checksum 0xd83ed238, Offset: 0x7b8
// Size: 0x6c
function monkey_cosmodrome_lander_death()
{
    self zombie_utility::reset_attack_spot();
    self thread zombie_utility::zombie_eye_glow_stop();
    level.monkey_death++;
    level.monkey_death_total++;
    self zm_ai_monkey::monkey_remove_from_pack();
    util::wait_network_frame();
}

