#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_mgturret;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;

#namespace zm_auto_turret;

// Namespace zm_auto_turret
// Params 0, eflags: 0x2
// Checksum 0xf5b558f6, Offset: 0x368
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "zm_auto_turret", &__init__, &__main__, undefined );
}

// Namespace zm_auto_turret
// Params 0
// Checksum 0xa60780de, Offset: 0x3b0
// Size: 0x3c
function __init__()
{
    level._effect[ "auto_turret_light" ] = "dlc4/genesis/fx_light_turret_auto";
    zm_spawner::register_zombie_death_event_callback( &death_check_for_challenge_updates );
}

// Namespace zm_auto_turret
// Params 0
// Checksum 0x86485f0, Offset: 0x3f8
// Size: 0x17e
function __main__()
{
    level.auto_turret_array = getentarray( "auto_turret_trigger", "script_noteworthy" );
    
    if ( !isdefined( level.auto_turret_array ) )
    {
        return;
    }
    
    level.curr_auto_turrets_active = 0;
    
    if ( !isdefined( level.max_auto_turrets_active ) )
    {
        level.max_auto_turrets_active = 2;
    }
    
    if ( !isdefined( level.auto_turret_cost ) )
    {
        level.auto_turret_cost = 1500;
    }
    
    if ( !isdefined( level.auto_turret_timeout ) )
    {
        level.auto_turret_timeout = 30;
    }
    
    for ( i = 0; i < level.auto_turret_array.size ; i++ )
    {
        level.auto_turret_array[ i ] setcursorhint( "HINT_NOICON" );
        level.auto_turret_array[ i ] sethintstring( &"ZOMBIE_NEED_POWER" );
        level.auto_turret_array[ i ] usetriggerrequirelookat();
        level.auto_turret_array[ i ].curr_time = -1;
        level.auto_turret_array[ i ].turret_active = 0;
        level.auto_turret_array[ i ] thread auto_turret_think();
    }
}

// Namespace zm_auto_turret
// Params 0
// Checksum 0x68846215, Offset: 0x580
// Size: 0x3f8
function auto_turret_think()
{
    if ( !isdefined( self.target ) )
    {
        return;
    }
    
    turret_array = getentarray( self.target, "targetname" );
    
    if ( isdefined( self.target ) )
    {
        for ( i = 0; i < turret_array.size ; i++ )
        {
            if ( turret_array[ i ].model == "zombie_zapper_handle" )
            {
                self.handle = turret_array[ i ];
                continue;
            }
            
            if ( turret_array[ i ].classname == "script_vehicle" )
            {
                self.turret = turret_array[ i ];
                self.turret vehicle_ai::turnoff();
                self.turret._trap_type = "auto_turret";
            }
        }
    }
    
    if ( !isdefined( self.turret ) )
    {
        return;
    }
    
    self.turret.takedamage = 0;
    self.audio_origin = self.origin;
    
    if ( isdefined( level.var_774896e3 ) )
    {
        level flag::wait_till( level.var_774896e3 );
    }
    else
    {
        level flag::wait_till( "power_on" );
    }
    
    for ( ;; )
    {
        cost = level.auto_turret_cost;
        self sethintstring( &"ZOMBIE_AUTO_TURRET", cost );
        self waittill( #"trigger", player );
        index = zm_utility::get_player_index( player );
        
        if ( player laststand::player_is_in_laststand() )
        {
            continue;
        }
        
        if ( player zm_utility::in_revive_trigger() )
        {
            continue;
        }
        
        if ( !player zm_score::can_player_purchase( cost ) )
        {
            self playsound( "zmb_turret_deny" );
            player thread play_no_money_turret_dialog();
            continue;
        }
        
        player zm_score::minus_to_player_score( cost );
        self.turret.activated_by_player = player;
        self thread auto_turret_activate();
        var_736ddf4 = spawn( "script_origin", self.origin );
        playsoundatposition( "zmb_cha_ching", self.origin );
        playsoundatposition( "zmb_turret_startup", self.origin );
        var_736ddf4 playloopsound( "zmb_turret_loop" );
        self triggerenable( 0 );
        self waittill( #"turret_deactivated" );
        var_736ddf4 stoploopsound();
        playsoundatposition( "zmb_turret_down", self.audio_origin );
        var_736ddf4 delete();
        self triggerenable( 1 );
    }
}

// Namespace zm_auto_turret
// Params 0
// Checksum 0xef9400c4, Offset: 0x980
// Size: 0xa4
function activate_move_handle()
{
    if ( isdefined( self.handle ) )
    {
        self.handle rotatepitch( 160, 0.5 );
        self.handle playsound( "amb_sparks_l_b" );
        self.handle waittill( #"rotatedone" );
        self notify( #"switch_activated" );
        self waittill( #"turret_deactivated" );
        self.handle rotatepitch( -160, 0.5 );
    }
}

// Namespace zm_auto_turret
// Params 0
// Checksum 0x84560205, Offset: 0xa30
// Size: 0x2c
function play_no_money_turret_dialog()
{
    self zm_audio::create_and_play_dialog( "general", "outofmoney" );
}

// Namespace zm_auto_turret
// Params 0
// Checksum 0x859a9434, Offset: 0xa68
// Size: 0x29c
function auto_turret_activate()
{
    self endon( #"turret_deactivated" );
    
    if ( level.max_auto_turrets_active <= 0 )
    {
        return;
    }
    
    while ( level.curr_auto_turrets_active >= level.max_auto_turrets_active )
    {
        worst_turret = undefined;
        worst_turret_time = -1;
        
        for ( i = 0; i < level.auto_turret_array.size ; i++ )
        {
            if ( level.auto_turret_array[ i ] == self )
            {
                continue;
            }
            
            if ( !level.auto_turret_array[ i ].turret_active )
            {
                continue;
            }
            
            if ( worst_turret_time < 0 || level.auto_turret_array[ i ].curr_time < worst_turret_time )
            {
                worst_turret = level.auto_turret_array[ i ];
                worst_turret_time = level.auto_turret_array[ i ].curr_time;
            }
        }
        
        if ( isdefined( worst_turret ) )
        {
            worst_turret auto_turret_deactivate();
            continue;
        }
        
        assert( 0, "<dev string:x28>" );
    }
    
    self.turret vehicle_ai::turnon();
    self.turret_active = 1;
    self.turret_fx = util::spawn_model( "tag_origin", self.turret.origin, self.turret.angles );
    playfxontag( level._effect[ "auto_turret_light" ], self.turret_fx, "tag_origin" );
    
    if ( isdefined( self.turret.activated_by_player ) )
    {
        self.turret.activated_by_player thread zm_audio::create_and_play_dialog( "auto_turret", "activated" );
    }
    
    self.curr_time = level.auto_turret_timeout;
    self thread auto_turret_update_timeout();
    wait level.auto_turret_timeout;
    self auto_turret_deactivate();
}

// Namespace zm_auto_turret
// Params 0
// Checksum 0x743dca14, Offset: 0xd10
// Size: 0x72
function auto_turret_deactivate()
{
    self.turret_active = 0;
    self.curr_time = -1;
    self.turret vehicle_ai::turnoff();
    self.turret notify( #"stop_burst_fire_unmanned" );
    self.turret_fx delete();
    self notify( #"turret_deactivated" );
}

// Namespace zm_auto_turret
// Params 0
// Checksum 0x56462e8a, Offset: 0xd90
// Size: 0x30
function auto_turret_update_timeout()
{
    self endon( #"turret_deactivated" );
    
    while ( self.curr_time > 0 )
    {
        wait 1;
        self.curr_time--;
    }
}

// Namespace zm_auto_turret
// Params 1
// Checksum 0x84a913ea, Offset: 0xdc8
// Size: 0x6c
function death_check_for_challenge_updates( e_attacker )
{
    if ( !isdefined( e_attacker ) )
    {
        return;
    }
    
    if ( e_attacker._trap_type === "auto_turret" )
    {
        if ( isdefined( e_attacker.activated_by_player ) )
        {
            e_attacker.activated_by_player zm_stats::increment_challenge_stat( "ZOMBIE_HUNTER_KILL_TRAP" );
        }
    }
}

