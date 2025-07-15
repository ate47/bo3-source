#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;

#namespace zm_zod_quest_vo;

// Namespace zm_zod_quest_vo
// Params 0
// Checksum 0x99ec1590, Offset: 0x1b0
// Size: 0x4
function opening_vo()
{
    
}

// Namespace zm_zod_quest_vo
// Params 0
// Checksum 0x99ec1590, Offset: 0x1c0
// Size: 0x4
function see_map_trigger()
{
    
}

// Namespace zm_zod_quest_vo
// Params 1
// Checksum 0x10947887, Offset: 0x1d0
// Size: 0x20a
function vo_play_soliloquy( convo )
{
    self endon( #"disconnect" );
    assert( isdefined( convo ), "<dev string:x28>" );
    
    if ( !level flag::get( "story_vo_playing" ) )
    {
        level flag::set( "story_vo_playing" );
        self thread vo_play_soliloquy_disconnect_listener();
        self.dontspeak = 1;
        self clientfield::set_to_player( "isspeaking", 1 );
        
        for ( i = 0; i < convo.size ; i++ )
        {
            if ( isdefined( self.afterlife ) && self.afterlife )
            {
                self.dontspeak = 0;
                self clientfield::set_to_player( "isspeaking", 0 );
                level flag::clear( "story_vo_playing" );
                self notify( #"soliloquy_vo_done" );
                return;
            }
            else
            {
                self playsoundwithnotify( convo[ i ], "sound_done" + convo[ i ] );
                self waittill( "sound_done" + convo[ i ] );
            }
            
            wait 1;
        }
        
        self.dontspeak = 0;
        self clientfield::set_to_player( "isspeaking", 0 );
        level flag::clear( "story_vo_playing" );
        self notify( #"soliloquy_vo_done" );
    }
}

// Namespace zm_zod_quest_vo
// Params 0
// Checksum 0xfb29d215, Offset: 0x3e8
// Size: 0x3c
function vo_play_soliloquy_disconnect_listener()
{
    self endon( #"soliloquy_vo_done" );
    self waittill( #"disconnect" );
    level flag::clear( "story_vo_playing" );
}

// Namespace zm_zod_quest_vo
// Params 1
// Checksum 0xfbd773cd, Offset: 0x430
// Size: 0x704
function vo_play_four_part_conversation( convo )
{
    assert( isdefined( convo ), "<dev string:x28>" );
    players = getplayers();
    
    if ( players.size == 4 && !level flag::get( "story_vo_playing" ) )
    {
        level flag::set( "story_vo_playing" );
        old_speaking_player = undefined;
        speaking_player = undefined;
        n_dist = 0;
        n_max_reply_dist = 1500;
        e_player1 = undefined;
        e_player2 = undefined;
        e_player3 = undefined;
        e_player4 = undefined;
        
        foreach ( player in players )
        {
            if ( isdefined( player ) )
            {
                switch ( player.character_name )
                {
                    case "Arlington":
                        e_player1 = player;
                        break;
                    default:
                        e_player2 = player;
                        break;
                    case "Billy":
                        e_player3 = player;
                        break;
                    case "Finn":
                        e_player4 = player;
                        break;
                }
            }
        }
        
        if ( !isdefined( e_player1 ) || !isdefined( e_player2 ) || !isdefined( e_player3 ) || !isdefined( e_player4 ) )
        {
            return;
        }
        else
        {
            foreach ( player in players )
            {
                if ( isdefined( player ) )
                {
                    player.dontspeak = 1;
                    player clientfield::set_to_player( "isspeaking", 1 );
                }
            }
        }
        
        for ( i = 0; i < convo.size ; i++ )
        {
            players = getplayers();
            
            if ( players.size != 4 )
            {
                foreach ( player in players )
                {
                    if ( isdefined( player ) )
                    {
                        player.dontspeak = 0;
                        player clientfield::set_to_player( "isspeaking", 0 );
                    }
                }
                
                level flag::clear( "story_vo_playing" );
                return;
            }
            
            if ( issubstr( convo[ i ], "plr_0" ) )
            {
                speaking_player = e_player4;
            }
            else if ( issubstr( convo[ i ], "plr_1" ) )
            {
                speaking_player = e_player2;
            }
            else if ( issubstr( convo[ i ], "plr_2" ) )
            {
                speaking_player = e_player3;
            }
            else if ( issubstr( convo[ i ], "plr_3" ) )
            {
                speaking_player = e_player1;
            }
            
            if ( isdefined( old_speaking_player ) )
            {
                n_dist = distance( old_speaking_player.origin, speaking_player.origin );
            }
            
            if ( speaking_player.afterlife || n_dist > n_max_reply_dist )
            {
                foreach ( player in players )
                {
                    if ( isdefined( player ) )
                    {
                        player.dontspeak = 0;
                        player clientfield::set_to_player( "isspeaking", 0 );
                    }
                }
                
                level flag::clear( "story_vo_playing" );
                return;
            }
            else
            {
                speaking_player playsoundwithnotify( convo[ i ], "sound_done" + convo[ i ] );
                speaking_player waittill( "sound_done" + convo[ i ] );
                old_speaking_player = speaking_player;
            }
            
            wait 1;
        }
        
        foreach ( player in players )
        {
            if ( isdefined( player ) )
            {
                player.dontspeak = 0;
                player clientfield::set_to_player( "isspeaking", 0 );
            }
        }
        
        level flag::clear( "story_vo_playing" );
    }
}

