#using scripts/codescripts/struct;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_chicken_pickup;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_fate;
#using scripts/cp/doa/_doa_hazard;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_shield_pickup;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/util_shared;

#namespace doa_player_challenge;

// Namespace doa_player_challenge
// Params 0
// Checksum 0x1b0adf2d, Offset: 0x4b8
// Size: 0x18
function init()
{
    level.doa.var_ff23f7c8 = 0;
}

// Namespace doa_player_challenge
// Params 0
// Checksum 0xd46cdc40, Offset: 0x4d8
// Size: 0x38c
function function_471d1403()
{
    possible = [];
    
    foreach ( room in level.doa.var_ec2bff7b )
    {
        if ( room.type != 13 )
        {
            continue;
        }
        
        if ( isdefined( room.var_2b9a70de ) && level.doa.round_number == room.var_2b9a70de )
        {
            level.doa.forced_magical_room = 13;
            level.doa.var_94073ca5 = room.name;
            level.doa.var_ff23f7c8 = level.doa.round_number;
            return;
        }
        
        if ( isdefined( room.minround ) && level.doa.round_number < room.minround )
        {
            continue;
        }
        
        if ( isdefined( room.maxround ) && level.doa.round_number > room.maxround )
        {
            continue;
        }
        
        if ( isdefined( room.var_5185e411 ) && !level [[ room.var_5185e411 ]]( room ) )
        {
            continue;
        }
        
        if ( isdefined( room.var_a90de2a1 ) )
        {
            if ( room.var_57ce7582.size > 0 )
            {
                lastseen = room.var_57ce7582[ room.var_57ce7582.size - 1 ];
            }
            
            if ( isdefined( lastseen ) && level.doa.round_number - lastseen < room.var_a90de2a1 )
            {
                continue;
            }
        }
        
        if ( isdefined( room.random ) && randomint( 100 ) > room.random )
        {
            continue;
        }
        
        possible[ possible.size ] = room;
    }
    
    if ( level.doa.round_number - level.doa.var_ff23f7c8 < 14 )
    {
        return;
    }
    
    if ( possible.size > 0 )
    {
        if ( possible.size > 1 )
        {
            room = possible[ randomint( possible.size ) ];
        }
        else
        {
            room = possible[ 0 ];
        }
        
        level.doa.forced_magical_room = 13;
        level.doa.var_94073ca5 = room.name;
        level.doa.var_ff23f7c8 = level.doa.round_number;
    }
}

// Namespace doa_player_challenge
// Params 1, eflags: 0x4
// Checksum 0xbcb28abc, Offset: 0x870
// Size: 0x2d6
function private function_4952be41( room )
{
    level endon( #"player_challenge_success" );
    level endon( #"player_challenge_failure" );
    level endon( #"hash_8194e795" );
    level flag::wait_till( "doa_challenge_running" );
    lastdiff = 1;
    
    if ( room.timeout > 0 )
    {
        timeout = room.timeout * 1000;
        expire = gettime() + timeout;
        var_4af4d74c = 0;
        
        while ( gettime() < expire )
        {
            if ( level flag::get( "doa_game_is_over" ) )
            {
                break;
            }
            
            diff = expire - gettime();
            ratio = diff / timeout;
            
            if ( ratio < 0.75 && lastdiff >= 0.75 )
            {
                level notify( #"hash_c62f5087", 75 );
            }
            
            if ( ratio < 0.5 && lastdiff >= 0.5 )
            {
                level notify( #"hash_c62f5087", 50 );
            }
            
            if ( ratio < 0.25 && lastdiff >= 0.25 )
            {
                level notify( #"hash_c62f5087", 25 );
            }
            
            if ( ratio < 0.2 && lastdiff >= 0.2 )
            {
                level thread doa_utility::function_37fb5c23( &"DOA_PLAYER_CHALLENGE_HURRY" );
            }
            
            if ( isdefined( room.banner ) )
            {
                data = doa_utility::clamp( diff / timeout, 0, 1 );
                level clientfield::set( "pumpBannerBar", data );
            }
            
            lastdiff = ratio;
            wait 0.1;
        }
        
        if ( isdefined( room.banner ) )
        {
            level clientfield::set( "pumpBannerBar", 0 );
        }
        
        if ( !( isdefined( room.var_674e3329 ) && room.var_674e3329 ) )
        {
            level notify( #"player_challenge_failure" );
        }
    }
}

// Namespace doa_player_challenge
// Params 1
// Checksum 0xb08ec637, Offset: 0xb50
// Size: 0x844
function do_playerchallenge( room )
{
    level flag::clear( "doa_challenge_ready" );
    level flag::clear( "doa_challenge_running" );
    level notify( #"hash_e2918623" );
    level thread doa_utility::clearallcorpses();
    level thread doa_hazard::function_116bb43();
    level thread doa_pickups::function_c1869ec8();
    level waittill( #"hash_229914a6" );
    level notify( #"kill_guardians" );
    
    if ( isdefined( room.var_6f369ab4 ) && room.var_57ce7582.size >= room.var_6f369ab4 )
    {
        arrayremovevalue( level.doa.var_ec2bff7b, room, 0 );
    }
    
    level notify( #"doa_playerdumpFPS" );
    
    foreach ( player in getplayers() )
    {
        player notify( #"hash_d28ba89d" );
    }
    
    wait 0.25;
    doa_round::function_55762a85( doa_player_utility::function_68ece679().origin );
    level clientfield::set( "flipCamera", 0 );
    level clientfield::increment( "killweather" );
    level clientfield::increment( "killfog" );
    level thread doa_utility::set_lighting_state( room.var_ac3f2368 );
    
    if ( level.doa.flipped )
    {
        settopdowncamerayaw( 0 );
    }
    
    level.doa.challenge_room = room;
    
    if ( isdefined( room.var_45da785b ) )
    {
        level [[ room.var_45da785b ]]( room );
    }
    
    doa_utility::function_390adefe( 0 );
    level thread doa_utility::function_c5f3ece8( &"DOA_PLAYER_CHALLENGE_ROOM", undefined, 6 );
    level.voice playsoundwithnotify( "vox_doaa_silverback_challenge", "soundDone" );
    level.voice waittill( #"sounddone" );
    wait 0.75;
    level thread doa_utility::function_37fb5c23( room.text );
    
    if ( isdefined( room.vox ) )
    {
        level.voice playsound( room.vox );
    }
    
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        players[ i ] freezecontrols( 0 );
    }
    
    if ( isdefined( room.var_58e293a2 ) )
    {
        level thread [[ room.var_58e293a2 ]]( room );
        level flag::wait_till( "doa_challenge_running" );
        level thread function_4952be41( room );
    }
    
    if ( isdefined( room.banner ) )
    {
        level clientfield::set( "activateBanner", room.banner );
    }
    
    level notify( #"hash_6d346dac" );
    
    if ( room.timeout > 0 )
    {
        msg = level util::waittill_any_timeout( room.timeout, "player_challenge_failure", "player_challenge_success", "doa_game_is_over" );
    }
    else
    {
        msg = level util::waittill_any_return( "doa_game_is_over", "player_challenge_failure", "player_challenge_success" );
    }
    
    wait 1;
    
    if ( msg == "player_challenge_failure" )
    {
        if ( !level flag::get( "doa_game_is_over" ) )
        {
            level thread doa_utility::function_c5f3ece8( &"DOA_PLAYER_CHALLENGE_ROOM_FAILED" );
            wait 1;
            level thread doa_utility::function_37fb5c23( isdefined( room.title2 ) ? room.title2 : &"DOA_PLAYER_CHALLENGE_ROOM_FAILED2" );
        }
        
        if ( isdefined( room.var_1cd9eda ) )
        {
            level [[ room.var_1cd9eda ]]( room );
        }
    }
    else if ( msg == "player_challenge_success" )
    {
        level thread doa_utility::function_c5f3ece8( &"DOA_PLAYER_CHALLENGE_ROOM_SUCCESS" );
        wait 1;
        level thread doa_utility::function_37fb5c23( isdefined( room.title2 ) ? room.title2 : &"DOA_PLAYER_CHALLENGE_ROOM_SUCCESS2" );
        
        if ( isdefined( room.var_2530dc89 ) )
        {
            level [[ room.var_2530dc89 ]]( room );
        }
    }
    else if ( msg == "timeout" )
    {
        level notify( room.name + "_challenge_timeout" );
        level thread doa_utility::function_c5f3ece8( &"DOA_PLAYER_CHALLENGE_ROOM_TIMEUP" );
        wait 1;
        level thread doa_utility::function_37fb5c23( isdefined( room.title2 ) ? room.title2 : &"DOA_PLAYER_CHALLENGE_ROOM_TIMEUP2" );
    }
    
    if ( !level flag::get( "doa_game_is_over" ) )
    {
        wait 5;
        doa_utility::function_44eb090b();
        
        if ( level.doa.flipped )
        {
            level clientfield::set( "flipCamera", 1 );
            settopdowncamerayaw( 180 );
        }
        
        doa_pickups::function_c1869ec8();
    }
    
    if ( isdefined( room.banner ) )
    {
        level clientfield::set( "activateBanner", 0 );
    }
    
    if ( isdefined( room.var_c64606ef ) )
    {
        level [[ room.var_c64606ef ]]( room );
    }
}

