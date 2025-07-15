#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_score;
#using scripts/zm/zm_temple_ai_monkey;

#namespace zm_temple_triggers;

// Namespace zm_temple_triggers
// Params 0
// Checksum 0xc35ec214, Offset: 0x368
// Size: 0x64
function main()
{
    level thread init_code_triggers();
    level thread init_water_drop_triggers();
    level thread init_slow_trigger();
    level thread init_code_structs();
}

// Namespace zm_temple_triggers
// Params 0
// Checksum 0xfedc25ad, Offset: 0x3d8
// Size: 0x54
function init_code_triggers()
{
    triggers = getentarray( "code_trigger", "targetname" );
    array::thread_all( triggers, &trigger_code );
}

// Namespace zm_temple_triggers
// Params 0
// Checksum 0xdcf14283, Offset: 0x438
// Size: 0xb8
function trigger_code()
{
    code = self.script_noteworthy;
    
    if ( !isdefined( code ) )
    {
        code = "DPAD_UP DPAD_UP DPAD_DOWN DPAD_DOWN DPAD_LEFT DPAD_RIGHT DPAD_LEFT DPAD_RIGHT BUTTON_B BUTTON_A";
    }
    
    if ( !isdefined( self.script_string ) )
    {
        self.script_string = "cash";
    }
    
    self.players = [];
    
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( is_in_array( self.players, who ) )
        {
            continue;
        }
        
        who thread watch_for_code_touching_trigger( code, self );
    }
}

// Namespace zm_temple_triggers
// Params 2
// Checksum 0xd8a614a1, Offset: 0x4f8
// Size: 0x188
function watch_for_code_touching_trigger( code, trigger )
{
    if ( !isdefined( trigger.players ) )
    {
        trigger.players = [];
    }
    else if ( !isarray( trigger.players ) )
    {
        trigger.players = array( trigger.players );
    }
    
    trigger.players[ trigger.players.size ] = self;
    self thread watch_for_code( code );
    self thread touching_trigger( trigger );
    returnnotify = self util::waittill_any_return( "code_correct", "stopped_touching_trigger", "death" );
    self notify( #"code_trigger_end" );
    
    if ( returnnotify == "code_correct" )
    {
        trigger code_trigger_activated( self );
        return;
    }
    
    trigger.players = arrayremovevalue( trigger.players, self );
}

// Namespace zm_temple_triggers
// Params 2
// Checksum 0x37c9ef78, Offset: 0x688
// Size: 0x98, Type: bool
function is_in_array( array, item )
{
    foreach ( index in array )
    {
        if ( index == item )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_temple_triggers
// Params 2
// Checksum 0xb4550f95, Offset: 0x728
// Size: 0x11c
function array_remove( array, object )
{
    if ( !isdefined( array ) && !isdefined( object ) )
    {
        return;
    }
    
    new_array = [];
    
    foreach ( item in array )
    {
        if ( item != object )
        {
            if ( !isdefined( new_array ) )
            {
                new_array = [];
            }
            else if ( !isarray( new_array ) )
            {
                new_array = array( new_array );
            }
            
            new_array[ new_array.size ] = item;
        }
    }
    
    return new_array;
}

// Namespace zm_temple_triggers
// Params 1
// Checksum 0xaec05afe, Offset: 0x850
// Size: 0xfc
function array_removeundefined( array )
{
    if ( !isdefined( array ) )
    {
        return;
    }
    
    new_array = [];
    
    foreach ( item in array )
    {
        if ( isdefined( item ) )
        {
            if ( !isdefined( new_array ) )
            {
                new_array = [];
            }
            else if ( !isarray( new_array ) )
            {
                new_array = array( new_array );
            }
            
            new_array[ new_array.size ] = item;
        }
    }
    
    return new_array;
}

// Namespace zm_temple_triggers
// Params 1
// Checksum 0x150fbab4, Offset: 0x958
// Size: 0x4e
function code_trigger_activated( who )
{
    switch ( self.script_string )
    {
        case "cash":
            who zm_score::add_to_player_score( 100 );
            break;
        default:
            break;
    }
}

// Namespace zm_temple_triggers
// Params 1
// Checksum 0xc0a65be9, Offset: 0x9b0
// Size: 0x4a
function touching_trigger( trigger )
{
    self endon( #"code_trigger_end" );
    
    while ( self istouching( trigger ) )
    {
        wait 0.1;
    }
    
    self notify( #"stopped_touching_trigger" );
}

// Namespace zm_temple_triggers
// Params 1
// Checksum 0x251c9106, Offset: 0xa08
// Size: 0x110
function watch_for_code( code )
{
    self endon( #"code_trigger_end" );
    codes = strtok( code, " " );
    
    while ( true )
    {
        for ( i = 0; i < codes.size ; i++ )
        {
            button = codes[ i ];
            
            if ( !self button_pressed( button, 0.3 ) )
            {
                break;
            }
            
            if ( !self button_not_pressed( button, 0.3 ) )
            {
                break;
            }
            
            if ( i == codes.size - 1 )
            {
                self notify( #"code_correct" );
                return;
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_temple_triggers
// Params 2
// Checksum 0x78db1668, Offset: 0xb20
// Size: 0x6a, Type: bool
function button_not_pressed( button, time )
{
    endtime = gettime() + time * 1000;
    
    while ( gettime() < endtime )
    {
        if ( !self buttonpressed( button ) )
        {
            return true;
        }
        
        wait 0.01;
    }
    
    return false;
}

// Namespace zm_temple_triggers
// Params 2
// Checksum 0x358b248c, Offset: 0xb98
// Size: 0x6a, Type: bool
function button_pressed( button, time )
{
    endtime = gettime() + time * 1000;
    
    while ( gettime() < endtime )
    {
        if ( self buttonpressed( button ) )
        {
            return true;
        }
        
        wait 0.01;
    }
    
    return false;
}

// Namespace zm_temple_triggers
// Params 0
// Checksum 0x6fe7a23b, Offset: 0xc10
// Size: 0x10e
function init_slow_trigger()
{
    level flag::wait_till( "initial_players_connected" );
    slowtriggers = getentarray( "slow_trigger", "targetname" );
    
    for ( t = 0; t < slowtriggers.size ; t++ )
    {
        trig = slowtriggers[ t ];
        
        if ( !isdefined( trig.script_float ) )
        {
            trig.script_float = 0.5;
        }
        
        trig.inturp_time = 1;
        trig.inturp_rate = trig.script_float / trig.inturp_time;
        trig thread trigger_slow_touched_wait();
    }
}

// Namespace zm_temple_triggers
// Params 0
// Checksum 0xef97744e, Offset: 0xd28
// Size: 0x78
function trigger_slow_touched_wait()
{
    while ( true )
    {
        self waittill( #"trigger", player );
        player notify( #"enter_slowtrigger" );
        self trigger::function_thread( player, &trigger_slow_ent, &trigger_unslow_ent );
        wait 0.1;
    }
}

// Namespace zm_temple_triggers
// Params 2
// Checksum 0x51297ce8, Offset: 0xda8
// Size: 0x14c
function trigger_slow_ent( player, endon_condition )
{
    player endon( endon_condition );
    
    if ( isdefined( player ) )
    {
        prevtime = gettime();
        
        while ( player.movespeedscale > self.script_float )
        {
            wait 0.05;
            delta = gettime() - prevtime;
            player.movespeedscale -= delta / 1000 * self.inturp_rate;
            prevtime = gettime();
            player setmovespeedscale( player.movespeedscale );
        }
        
        player.movespeedscale = self.script_float;
        player allowjump( 0 );
        player allowsprint( 0 );
        player setmovespeedscale( self.script_float );
        player setvelocity( ( 0, 0, 0 ) );
    }
}

// Namespace zm_temple_triggers
// Params 1
// Checksum 0xe45b921f, Offset: 0xf00
// Size: 0x12c
function trigger_unslow_ent( player )
{
    player endon( #"enter_slowtrigger" );
    
    if ( isdefined( player ) )
    {
        prevtime = gettime();
        
        while ( player.movespeedscale < 1 )
        {
            wait 0.05;
            delta = gettime() - prevtime;
            player.movespeedscale += delta / 1000 * self.inturp_rate;
            prevtime = gettime();
            player setmovespeedscale( player.movespeedscale );
        }
        
        player.movespeedscale = 1;
        player allowjump( 1 );
        player allowsprint( 1 );
        player setmovespeedscale( 1 );
    }
}

// Namespace zm_temple_triggers
// Params 0
// Checksum 0xac98d42e, Offset: 0x1038
// Size: 0x13c
function trigger_corpse()
{
    if ( !isdefined( self.script_string ) )
    {
        self.script_string = "";
    }
    
    while ( true )
    {
        /#
            box( self.origin, self.mins, self.maxs, 0, ( 1, 0, 0 ) );
        #/
        
        corpses = getcorpsearray();
        
        for ( i = 0; i < corpses.size ; i++ )
        {
            corpse = corpses[ i ];
            
            /#
                box( corpse.orign, corpse.mins, corpse.maxs, 0, ( 1, 1, 0 ) );
            #/
            
            if ( corpse istouching( self ) )
            {
                self trigger_corpse_activated();
                return;
            }
        }
        
        wait 0.3;
    }
}

// Namespace zm_temple_triggers
// Params 0
// Checksum 0x9164d34f, Offset: 0x1180
// Size: 0x1c
function trigger_corpse_activated()
{
    iprintlnbold( "Corpse Trigger Activated" );
}

// Namespace zm_temple_triggers
// Params 0
// Checksum 0x6ceeec50, Offset: 0x11a8
// Size: 0x136
function init_water_drop_triggers()
{
    triggers = getentarray( "water_drop_trigger", "script_noteworthy" );
    
    for ( i = 0; i < triggers.size ; i++ )
    {
        trig = triggers[ i ];
        trig.water_drop_time = 0.5;
        trig.waterdrops = 1;
        trig.watersheeting = 1;
        
        if ( isdefined( trig.script_string ) )
        {
            if ( trig.script_string == "sheetingonly" )
            {
                trig.waterdrops = 0;
            }
            else if ( trig.script_string == "dropsonly" )
            {
                trig.watersheeting = 0;
            }
        }
        
        trig thread water_drop_trigger_think();
    }
}

// Namespace zm_temple_triggers
// Params 0
// Checksum 0x205ffa5e, Offset: 0x12e8
// Size: 0x10c
function water_drop_trigger_think()
{
    level flag::wait_till( "initial_players_connected" );
    wait 1;
    
    if ( isdefined( self.script_flag ) )
    {
        level flag::wait_till( self.script_flag );
    }
    
    if ( isdefined( self.script_float ) )
    {
        wait self.script_float;
    }
    
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( isplayer( who ) )
        {
            self trigger::function_thread( who, &water_drop_trig_entered, &water_drop_trig_exit );
            continue;
        }
        
        if ( isdefined( who.water_trigger_func ) )
        {
            who thread [[ who.water_trigger_func ]]( self );
        }
    }
}

// Namespace zm_temple_triggers
// Params 2
// Checksum 0x9beb4579, Offset: 0x1400
// Size: 0x1b4
function water_drop_trig_entered( player, endon_string )
{
    if ( isdefined( endon_string ) )
    {
        player endon( endon_string );
    }
    
    player notify( #"water_drop_trig_enter" );
    player endon( #"death" );
    player endon( #"disconnect" );
    player endon( #"spawned_spectator" );
    
    if ( player.sessionstate == "spectator" )
    {
        return;
    }
    
    if ( !isdefined( player.water_drop_ents ) )
    {
        player.water_drop_ents = [];
    }
    
    if ( isdefined( self.script_sound ) )
    {
        player playsound( self.script_sound );
    }
    
    if ( self.waterdrops )
    {
        if ( !isdefined( player.water_drop_ents ) )
        {
            player.water_drop_ents = [];
        }
        else if ( !isarray( player.water_drop_ents ) )
        {
            player.water_drop_ents = array( player.water_drop_ents );
        }
        
        player.water_drop_ents[ player.water_drop_ents.size ] = self;
        
        if ( !self.watersheeting )
        {
            player setwaterdrops( player player_get_num_water_drops() );
        }
    }
    
    if ( self.watersheeting )
    {
        self thread function_4dedd2e( player );
    }
}

// Namespace zm_temple_triggers
// Params 1
// Checksum 0x693304e9, Offset: 0x15c0
// Size: 0xac
function function_4dedd2e( player )
{
    player notify( #"water_drop_trig_enter" );
    player endon( #"death" );
    player endon( #"disconnect" );
    player endon( #"spawned_spectator" );
    player endon( #"irt" );
    player clientfield::set_to_player( "floorrumble", 1 );
    player thread intermission_rumble_clean_up();
    visionset_mgr::activate( "overlay", "zm_waterfall_postfx", player );
}

// Namespace zm_temple_triggers
// Params 1
// Checksum 0x5629087a, Offset: 0x1678
// Size: 0x154
function water_drop_trig_exit( player )
{
    if ( !isdefined( player.water_drop_ents ) )
    {
        player.water_drop_ents = [];
    }
    
    if ( self.waterdrops )
    {
        if ( self.watersheeting )
        {
            player notify( #"irt" );
            player clientfield::set_to_player( "floorrumble", 0 );
            player setwaterdrops( player player_get_num_water_drops() );
            visionset_mgr::deactivate( "overlay", "zm_waterfall_postfx", player );
        }
        
        player.water_drop_ents = array_remove( player.water_drop_ents, self );
        
        if ( player.water_drop_ents.size == 0 )
        {
            player water_drop_remove( 0 );
            return;
        }
        
        player setwaterdrops( player player_get_num_water_drops() );
    }
}

// Namespace zm_temple_triggers
// Params 1
// Checksum 0x178e7640, Offset: 0x17d8
// Size: 0x4c
function water_drop_remove( delay )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"water_drop_trig_enter" );
    wait delay;
    self setwaterdrops( 0 );
}

// Namespace zm_temple_triggers
// Params 0
// Checksum 0x6695c88b, Offset: 0x1830
// Size: 0x22
function player_get_num_water_drops()
{
    if ( self.water_drop_ents.size > 0 )
    {
        return 50;
    }
    
    return 0;
}

// Namespace zm_temple_triggers
// Params 0
// Checksum 0x6bbb5551, Offset: 0x1860
// Size: 0x54
function init_code_structs()
{
    structs = struct::get_array( "code_struct", "targetname" );
    array::thread_all( structs, &structs_code );
}

// Namespace zm_temple_triggers
// Params 0
// Checksum 0x350529f6, Offset: 0x18c0
// Size: 0x244
function structs_code()
{
    code = self.script_noteworthy;
    
    if ( !isdefined( code ) )
    {
        code = "DPAD_UP DPAD_DOWN DPAD_LEFT DPAD_RIGHT BUTTON_B BUTTON_A";
    }
    
    self.codes = strtok( code, " " );
    
    if ( !isdefined( self.script_string ) )
    {
        self.script_string = "cash";
    }
    
    self.reward = self.script_string;
    
    if ( !isdefined( self.radius ) )
    {
        self.radius = 32;
    }
    
    self.radiussq = self.radius * self.radius;
    playersinradius = [];
    
    while ( true )
    {
        players = getplayers();
        
        for ( i = playersinradius.size - 1; i >= 0 ; i-- )
        {
            player = playersinradius[ i ];
            
            if ( !self is_player_in_radius( player ) )
            {
                if ( isdefined( player ) )
                {
                    playersinradius = array_remove( playersinradius, player );
                    self notify( #"end_code_struct" );
                }
                else
                {
                    playersinradius = array_removeundefined( playersinradius );
                }
            }
            
            players = array_remove( players, player );
        }
        
        for ( i = 0; i < players.size ; i++ )
        {
            player = players[ i ];
            
            if ( self is_player_in_radius( player ) )
            {
                self thread code_entry( player );
                playersinradius[ playersinradius.size ] = player;
            }
        }
        
        wait 0.5;
    }
}

// Namespace zm_temple_triggers
// Params 1
// Checksum 0xa05e8fb0, Offset: 0x1b10
// Size: 0x10c
function code_entry( player )
{
    self endon( #"end_code_struct" );
    player endon( #"death" );
    player endon( #"disconnect" );
    
    while ( true )
    {
        for ( i = 0; i < self.codes.size ; i++ )
        {
            button = self.codes[ i ];
            
            if ( !player button_pressed( button, 0.3 ) )
            {
                break;
            }
            
            if ( !player button_not_pressed( button, 0.3 ) )
            {
                break;
            }
            
            if ( i == self.codes.size - 1 )
            {
                self code_reward( player );
                return;
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_temple_triggers
// Params 1
// Checksum 0x704e938a, Offset: 0x1c28
// Size: 0x6e
function code_reward( player )
{
    switch ( self.reward )
    {
        case "cash":
            player zm_score::add_to_player_score( 100 );
            break;
        case "mb":
            zm_temple_ai_monkey::monkey_ambient_gib_all();
            break;
        default:
            break;
    }
}

// Namespace zm_temple_triggers
// Params 1
// Checksum 0xd80c5986, Offset: 0x1ca0
// Size: 0xa0, Type: bool
function is_player_in_radius( player )
{
    if ( !zombie_utility::is_player_valid( player ) )
    {
        return false;
    }
    
    if ( abs( self.origin[ 2 ] - player.origin[ 2 ] ) > 30 )
    {
        return false;
    }
    
    if ( distance2dsquared( self.origin, player.origin ) > self.radiussq )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_temple_triggers
// Params 0
// Checksum 0xf57af174, Offset: 0x1d48
// Size: 0x3c
function intermission_rumble_clean_up()
{
    self endon( #"irt" );
    level waittill( #"intermission" );
    self clientfield::set_to_player( "floorrumble", 0 );
}

