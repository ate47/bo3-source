#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;

#namespace zm_theater_achievements;

// Namespace zm_theater_achievements
// Params 0, eflags: 0x2
// Checksum 0x6aefe740, Offset: 0x248
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_theater_achievements", &__init__, undefined, undefined );
}

// Namespace zm_theater_achievements
// Params 0
// Checksum 0x964055a2, Offset: 0x288
// Size: 0x5c
function __init__()
{
    level.achievement_sound_func = &achievement_sound_func;
    zm_spawner::register_zombie_death_event_callback( &function_1abfde35 );
    callback::on_connect( &onplayerconnect );
}

// Namespace zm_theater_achievements
// Params 1
// Checksum 0x12c0b4d0, Offset: 0x2f0
// Size: 0xac
function achievement_sound_func( achievement_name_lower )
{
    self endon( #"disconnect" );
    
    if ( !sessionmodeisonlinegame() )
    {
        return;
    }
    
    for ( i = 0; i < self getentitynumber() + 1 ; i++ )
    {
        util::wait_network_frame();
    }
    
    self thread zm_utility::do_player_general_vox( "general", "achievement" );
}

// Namespace zm_theater_achievements
// Params 0
// Checksum 0x885fde47, Offset: 0x3a8
// Size: 0x4c
function onplayerconnect()
{
    self thread achievement_ive_seen_some_things();
    self thread function_24b05d89();
    self thread function_6c831509();
}

// Namespace zm_theater_achievements
// Params 0
// Checksum 0xb1dd48b2, Offset: 0x400
// Size: 0x134
function achievement_ive_seen_some_things()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    self.var_3ac4b03d = [];
    
    for ( i = 0; i <= 3 ; i++ )
    {
        self.var_3ac4b03d[ i ] = i;
    }
    
    level flag::wait_till( "power_on" );
    
    while ( self.var_3ac4b03d.size > 0 )
    {
        self waittill( #"player_teleported", n_loc );
        
        if ( isdefined( n_loc ) && isint( n_loc ) && isinarray( self.var_3ac4b03d, n_loc ) )
        {
            arrayremovevalue( self.var_3ac4b03d, n_loc );
        }
        
        wait 0.05;
    }
    
    /#
    #/
    
    self zm_utility::giveachievement_wrapper( "ZM_THEATER_IVE_SEEN_SOME_THINGS", 0 );
}

// Namespace zm_theater_achievements
// Params 0
// Checksum 0xcbb3cf96, Offset: 0x540
// Size: 0x104
function function_24b05d89()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    self.var_597e831d = [];
    
    for ( i = 1; i <= 3 ; i++ )
    {
        self.var_597e831d[ i - 1 ] = "ps" + i;
    }
    
    level flag::wait_till( "power_on" );
    
    while ( self.var_597e831d.size > 0 )
    {
        level waittill( #"play_movie", var_2be4351a );
        
        if ( isdefined( var_2be4351a ) && isinarray( self.var_597e831d, var_2be4351a ) )
        {
            arrayremovevalue( self.var_597e831d, var_2be4351a );
        }
    }
    
    /#
    #/
}

// Namespace zm_theater_achievements
// Params 0
// Checksum 0x630e90ce, Offset: 0x650
// Size: 0x94
function function_6c831509()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    self.var_386853b6 = [];
    self.var_386853b6[ "zombie" ] = 40;
    self.var_386853b6[ "zombie_quad" ] = 20;
    self.var_386853b6[ "zombie_dog" ] = 10;
    self waittill( #"hash_f5c9d74f" );
    
    /#
    #/
}

// Namespace zm_theater_achievements
// Params 1
// Checksum 0x3f9a6e84, Offset: 0x6f0
// Size: 0x144
function function_1abfde35( e_attacker )
{
    if ( isdefined( e_attacker ) && e_attacker.target === "crematorium_room_trap" && isdefined( self.archetype ) && isdefined( e_attacker.activated_by_player ) )
    {
        var_3500dd7a = e_attacker.activated_by_player;
        var_3500dd7a.var_386853b6[ self.archetype ]--;
        var_fc3072e7 = 1;
        
        foreach ( n_targets in var_3500dd7a.var_386853b6 )
        {
            if ( n_targets > 0 )
            {
                var_fc3072e7 = 0;
                break;
            }
        }
        
        if ( var_fc3072e7 && isdefined( var_3500dd7a ) )
        {
            var_3500dd7a notify( #"hash_f5c9d74f" );
        }
    }
}

