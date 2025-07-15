#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;

#namespace zm_traps;

// Namespace zm_traps
// Params 0, eflags: 0x2
// Checksum 0x6cc2b4bc, Offset: 0x760
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "zm_traps", &__init__, &__main__, undefined );
}

// Namespace zm_traps
// Params 0
// Checksum 0x1480ef36, Offset: 0x7a8
// Size: 0x3c
function __init__()
{
    level.trap_kills = 0;
    level.burning_zombies = [];
    callback::on_finalize_initialization( &init );
}

// Namespace zm_traps
// Params 0
// Checksum 0xc376937b, Offset: 0x7f0
// Size: 0x54
function init()
{
    traps = getentarray( "zombie_trap", "targetname" );
    array::thread_all( traps, &trap_init );
}

// Namespace zm_traps
// Params 0
// Checksum 0xc31006ac, Offset: 0x850
// Size: 0x54
function __main__()
{
    traps = getentarray( "zombie_trap", "targetname" );
    array::thread_all( traps, &trap_main );
}

// Namespace zm_traps
// Params 0
// Checksum 0x1a55dce6, Offset: 0x8b0
// Size: 0x68c
function trap_init()
{
    self flag::init( "flag_active" );
    self flag::init( "flag_cooldown" );
    self._trap_type = "";
    
    if ( isdefined( self.script_noteworthy ) )
    {
        self._trap_type = self.script_noteworthy;
        
        if ( isdefined( level._custom_traps ) && isdefined( level._custom_traps[ self.script_noteworthy ] ) && isdefined( level._custom_traps[ self.script_noteworthy ].activate ) )
        {
            self._trap_activate_func = level._custom_traps[ self.script_noteworthy ].activate;
        }
        else
        {
            switch ( self.script_noteworthy )
            {
                case "rotating":
                    self._trap_activate_func = &trap_activate_rotating;
                    break;
                case "flipper":
                    self._trap_activate_func = &trap_activate_flipper;
                    break;
                default:
                    self._trap_activate_func = &trap_activate_fire;
                    break;
            }
        }
        
        if ( isdefined( level._zombiemode_trap_use_funcs ) && isdefined( level._zombiemode_trap_use_funcs[ self._trap_type ] ) )
        {
            self._trap_use_func = level._zombiemode_trap_use_funcs[ self._trap_type ];
        }
        else
        {
            self._trap_use_func = &trap_use_think;
        }
    }
    
    self trap_model_type_init();
    self._trap_use_trigs = [];
    self._trap_lights = [];
    self._trap_movers = [];
    self._trap_switches = [];
    components = getentarray( self.target, "targetname" );
    
    for ( i = 0; i < components.size ; i++ )
    {
        if ( isdefined( components[ i ].script_noteworthy ) )
        {
            switch ( components[ i ].script_noteworthy )
            {
                case "counter_1s":
                    self.counter_1s = components[ i ];
                    continue;
                case "counter_10s":
                    self.counter_10s = components[ i ];
                    continue;
                case "counter_100s":
                    self.counter_100s = components[ i ];
                    continue;
                case "mover":
                    self._trap_movers[ self._trap_movers.size ] = components[ i ];
                    continue;
                default:
                    self._trap_switches[ self._trap_switches.size ] = components[ i ];
                    continue;
                case "light":
                    self._trap_lights[ self._trap_lights.size ] = components[ i ];
                    continue;
            }
        }
        
        if ( isdefined( components[ i ].script_string ) )
        {
            switch ( components[ i ].script_string )
            {
                case "flipper1":
                    self.flipper1 = components[ i ];
                    continue;
                case "flipper2":
                    self.flipper2 = components[ i ];
                    continue;
                case "flipper1_radius_check":
                    self.flipper1_radius_check = components[ i ];
                    continue;
                case "flipper2_radius_check":
                    self.flipper2_radius_check = components[ i ];
                    continue;
                case "target1":
                    self.target1 = components[ i ];
                    continue;
                case "target2":
                    self.target2 = components[ i ];
                    continue;
                default:
                    self.target3 = components[ i ];
                    continue;
            }
        }
        
        switch ( components[ i ].classname )
        {
            default:
                self._trap_use_trigs[ self._trap_use_trigs.size ] = components[ i ];
                break;
            case "script_model":
                if ( components[ i ].model == self._trap_light_model_off )
                {
                    self._trap_lights[ self._trap_lights.size ] = components[ i ];
                }
                else if ( components[ i ].model == self._trap_switch_model )
                {
                    self._trap_switches[ self._trap_switches.size ] = components[ i ];
                }
                
                break;
        }
    }
    
    self._trap_fx_structs = [];
    components = struct::get_array( self.target, "targetname" );
    
    for ( i = 0; i < components.size ; i++ )
    {
        if ( isdefined( components[ i ].script_string ) && components[ i ].script_string == "use_this_angle" )
        {
            self.use_this_angle = components[ i ];
            continue;
        }
        
        self._trap_fx_structs[ self._trap_fx_structs.size ] = components[ i ];
    }
    
    assert( self._trap_use_trigs.size > 0, "<dev string:x28>" + self.target );
    
    if ( !isdefined( self.zombie_cost ) )
    {
        self.zombie_cost = 1000;
    }
    
    self._trap_in_use = 0;
    self._trap_cooling_down = 0;
    self thread trap_dialog();
}

// Namespace zm_traps
// Params 0
// Checksum 0x4e630e86, Offset: 0xf48
// Size: 0x26e
function trap_main()
{
    level flag::wait_till( "start_zombie_round_logic" );
    
    for ( i = 0; i < self._trap_use_trigs.size ; i++ )
    {
        self._trap_use_trigs[ i ] setcursorhint( "HINT_NOICON" );
    }
    
    if ( !isdefined( self.script_string ) || "disable_wait_for_power" != self.script_string )
    {
        self trap_set_string( &"ZOMBIE_NEED_POWER" );
        
        if ( isdefined( self.script_int ) )
        {
            level flag::wait_till( "power_on" + self.script_int );
        }
        else
        {
            level flag::wait_till( "power_on" );
        }
    }
    
    if ( isdefined( self.script_flag_wait ) )
    {
        self trap_set_string( "" );
        self triggerenable( 0 );
        self trap_lights_red();
        
        if ( !isdefined( level.flag[ self.script_flag_wait ] ) )
        {
            level flag::init( self.script_flag_wait );
        }
        
        level flag::wait_till( self.script_flag_wait );
        self triggerenable( 1 );
    }
    
    self trap_set_string( &"ZOMBIE_BUTTON_BUY_TRAP", self.zombie_cost );
    self trap_lights_green();
    
    for ( i = 0; i < self._trap_use_trigs.size ; i++ )
    {
        self._trap_use_trigs[ i ] thread [[ self._trap_use_func ]]( self );
        self._trap_use_trigs[ i ] thread update_trigger_visibility();
    }
}

// Namespace zm_traps
// Params 1
// Checksum 0xdf6ad76c, Offset: 0x11c0
// Size: 0x3a0
function trap_use_think( trap )
{
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( who zm_utility::in_revive_trigger() )
        {
            continue;
        }
        
        if ( who.is_drinking > 0 )
        {
            continue;
        }
        
        if ( zm_utility::is_player_valid( who ) && !trap._trap_in_use )
        {
            players = getplayers();
            
            if ( who zm_score::can_player_purchase( trap.zombie_cost ) )
            {
                who zm_score::minus_to_player_score( trap.zombie_cost );
            }
            else
            {
                self playsound( "zmb_trap_deny" );
                who zm_audio::create_and_play_dialog( "general", "outofmoney" );
                continue;
            }
            
            trap.activated_by_player = who;
            trap._trap_in_use = 1;
            trap trap_set_string( &"ZOMBIE_TRAP_ACTIVE" );
            zm_utility::play_sound_at_pos( "purchase", who.origin );
            
            if ( !( isdefined( level.b_trap_start_custom_vo ) && level.b_trap_start_custom_vo ) )
            {
                who zm_audio::create_and_play_dialog( "trap", "start" );
            }
            
            if ( trap._trap_switches.size )
            {
                trap thread trap_move_switches();
                trap waittill( #"switch_activated" );
            }
            
            trap triggerenable( 1 );
            trap thread [[ trap._trap_activate_func ]]();
            trap waittill( #"trap_done" );
            trap triggerenable( 0 );
            trap._trap_cooling_down = 1;
            trap trap_set_string( &"ZOMBIE_TRAP_COOLDOWN" );
            
            /#
                if ( getdvarint( "<dev string:x52>" ) >= 1 )
                {
                    trap._trap_cooldown_time = 5;
                }
            #/
            
            wait trap._trap_cooldown_time;
            trap._trap_cooling_down = 0;
            playsoundatposition( "zmb_trap_ready", trap.origin );
            
            if ( isdefined( level.sndtrapfunc ) )
            {
                level thread [[ level.sndtrapfunc ]]( trap, 0 );
            }
            
            trap notify( #"available" );
            trap._trap_in_use = 0;
            trap trap_set_string( &"ZOMBIE_BUTTON_BUY_TRAP", trap.zombie_cost );
        }
    }
}

// Namespace zm_traps
// Params 0, eflags: 0x4
// Checksum 0x5c77df64, Offset: 0x1568
// Size: 0xfc
function private update_trigger_visibility()
{
    self endon( #"death" );
    
    while ( true )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            if ( distancesquared( level.players[ i ].origin, self.origin ) < 16384 )
            {
                if ( level.players[ i ].is_drinking > 0 )
                {
                    self setinvisibletoplayer( level.players[ i ], 1 );
                    continue;
                }
                
                self setinvisibletoplayer( level.players[ i ], 0 );
            }
        }
        
        wait 0.25;
    }
}

// Namespace zm_traps
// Params 0
// Checksum 0xea2504f2, Offset: 0x1670
// Size: 0xc6
function trap_lights_red()
{
    for ( i = 0; i < self._trap_lights.size ; i++ )
    {
        light = self._trap_lights[ i ];
        str_light_red = light.targetname + "_red";
        str_light_green = light.targetname + "_green";
        exploder::stop_exploder( str_light_green );
        exploder::exploder( str_light_red );
    }
}

// Namespace zm_traps
// Params 0
// Checksum 0xe0745f19, Offset: 0x1740
// Size: 0xde
function trap_lights_green()
{
    for ( i = 0; i < self._trap_lights.size ; i++ )
    {
        light = self._trap_lights[ i ];
        
        if ( isdefined( light._switch_disabled ) )
        {
            continue;
        }
        
        str_light_red = light.targetname + "_red";
        str_light_green = light.targetname + "_green";
        exploder::stop_exploder( str_light_red );
        exploder::exploder( str_light_green );
    }
}

// Namespace zm_traps
// Params 3
// Checksum 0xc0630692, Offset: 0x1828
// Size: 0xde
function trap_set_string( string, param1, param2 )
{
    for ( i = 0; i < self._trap_use_trigs.size ; i++ )
    {
        if ( !isdefined( param1 ) )
        {
            self._trap_use_trigs[ i ] sethintstring( string );
            continue;
        }
        
        if ( !isdefined( param2 ) )
        {
            self._trap_use_trigs[ i ] sethintstring( string, param1 );
            continue;
        }
        
        self._trap_use_trigs[ i ] sethintstring( string, param1, param2 );
    }
}

// Namespace zm_traps
// Params 0
// Checksum 0x995ba8c6, Offset: 0x1910
// Size: 0x19c
function trap_move_switches()
{
    self trap_lights_red();
    
    for ( i = 0; i < self._trap_switches.size ; i++ )
    {
        self._trap_switches[ i ] rotatepitch( 180, 0.5 );
        
        if ( isdefined( self._trap_type ) && self._trap_type == "fire" )
        {
            self._trap_switches[ i ] playsound( "evt_switch_flip_trap_fire" );
            continue;
        }
        
        self._trap_switches[ i ] playsound( "evt_switch_flip_trap" );
    }
    
    self._trap_switches[ 0 ] waittill( #"rotatedone" );
    self notify( #"switch_activated" );
    self waittill( #"available" );
    
    for ( i = 0; i < self._trap_switches.size ; i++ )
    {
        self._trap_switches[ i ] rotatepitch( -180, 0.5 );
    }
    
    self._trap_switches[ 0 ] waittill( #"rotatedone" );
    self trap_lights_green();
}

// Namespace zm_traps
// Params 0
// Checksum 0xe3033bbd, Offset: 0x1ab8
// Size: 0xd2
function trap_activate_fire()
{
    self._trap_duration = 40;
    self._trap_cooldown_time = 60;
    fx_points = struct::get_array( self.target, "targetname" );
    
    for ( i = 0; i < fx_points.size ; i++ )
    {
        util::wait_network_frame();
        fx_points[ i ] thread trap_audio_fx( self );
    }
    
    self thread trap_damage();
    wait self._trap_duration;
    self notify( #"trap_done" );
}

// Namespace zm_traps
// Params 0
// Checksum 0x87d64582, Offset: 0x1b98
// Size: 0x236
function trap_activate_rotating()
{
    self endon( #"trap_done" );
    self._trap_duration = 30;
    self._trap_cooldown_time = 60;
    self thread trap_damage();
    self thread trig_update( self._trap_movers[ 0 ] );
    old_angles = self._trap_movers[ 0 ].angles;
    
    for ( i = 0; i < self._trap_movers.size ; i++ )
    {
        self._trap_movers[ i ] rotateyaw( 360, 5, 4.5 );
    }
    
    wait 5;
    step = 1.5;
    t = 0;
    
    while ( t < self._trap_duration )
    {
        for ( i = 0; i < self._trap_movers.size ; i++ )
        {
            self._trap_movers[ i ] rotateyaw( 360, step );
        }
        
        wait step;
        t += step;
    }
    
    for ( i = 0; i < self._trap_movers.size ; i++ )
    {
        self._trap_movers[ i ] rotateyaw( 360, 5, 0, 4.5 );
    }
    
    wait 5;
    
    for ( i = 0; i < self._trap_movers.size ; i++ )
    {
        self._trap_movers[ i ].angles = old_angles;
    }
    
    self notify( #"trap_done" );
}

// Namespace zm_traps
// Params 0
// Checksum 0x99ec1590, Offset: 0x1dd8
// Size: 0x4
function trap_activate_flipper()
{
    
}

// Namespace zm_traps
// Params 1
// Checksum 0xa54858b7, Offset: 0x1de8
// Size: 0x134
function trap_audio_fx( trap )
{
    if ( isdefined( level._custom_traps ) && isdefined( level._custom_traps[ trap.script_noteworthy ] ) && isdefined( level._custom_traps[ trap.script_noteworthy ].audio ) )
    {
        self [[ level._custom_traps[ trap.script_noteworthy ].audio ]]( trap );
        return;
    }
    
    sound_origin = undefined;
    trap util::waittill_any_timeout( trap._trap_duration, "trap_done" );
    
    if ( isdefined( sound_origin ) )
    {
        playsoundatposition( "wpn_zmb_electrap_stop", sound_origin.origin );
        sound_origin stoploopsound();
        wait 0.05;
        sound_origin delete();
    }
}

// Namespace zm_traps
// Params 0
// Checksum 0xd0f94275, Offset: 0x1f28
// Size: 0x2aa
function trap_damage()
{
    self endon( #"trap_done" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            if ( isdefined( level._custom_traps ) && isdefined( level._custom_traps[ self._trap_type ] ) && isdefined( level._custom_traps[ self._trap_type ].player_damage ) )
            {
                ent thread [[ level._custom_traps[ self._trap_type ].player_damage ]]();
                goto LOC_00000174;
            }
            else
            {
                switch ( self._trap_type )
                {
                    case "rocket":
                        ent thread player_fire_damage();
                        break;
                    default:
                        if ( ent getstance() == "stand" )
                        {
                            ent dodamage( 50, ent.origin + ( 0, 0, 20 ) );
                            ent setstance( "crouch" );
                        }
                        
                        break;
                }
            LOC_00000174:
            }
            
        LOC_00000174:
            continue;
        }
        
        if ( !isdefined( ent.marked_for_death ) )
        {
            if ( isdefined( level._custom_traps ) && isdefined( level._custom_traps[ self._trap_type ] ) && isdefined( level._custom_traps[ self._trap_type ].damage ) )
            {
                ent thread [[ level._custom_traps[ self._trap_type ].damage ]]( self );
                continue;
            }
            
            switch ( self._trap_type )
            {
                case "rocket":
                    ent thread zombie_trap_death( self, 100 );
                    break;
                case "rotating":
                    ent thread zombie_trap_death( self, 200 );
                    break;
                default:
                    ent thread zombie_trap_death( self, randomint( 100 ) );
                    break;
            }
        }
    }
}

// Namespace zm_traps
// Params 1
// Checksum 0xef03cece, Offset: 0x21e0
// Size: 0x58
function trig_update( parent )
{
    self endon( #"trap_done" );
    start_angles = self.angles;
    
    while ( true )
    {
        self.angles = parent.angles;
        wait 0.05;
    }
}

// Namespace zm_traps
// Params 0
// Checksum 0x5662f0a, Offset: 0x2240
// Size: 0x23e
function player_elec_damage()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    if ( !isdefined( level.elec_loop ) )
    {
        level.elec_loop = 0;
    }
    
    if ( !( isdefined( self.is_burning ) && self.is_burning ) && zm_utility::is_player_valid( self ) )
    {
        self.is_burning = 1;
        
        if ( isdefined( level.trap_electric_visionset_registered ) && level.trap_electric_visionset_registered )
        {
            visionset_mgr::activate( "overlay", "zm_trap_electric", self, 1.25, 1.25 );
        }
        else
        {
            self setelectrified( 1.25 );
        }
        
        shocktime = 2.5;
        
        if ( isdefined( level.str_elec_damage_shellshock_override ) )
        {
            str_elec_shellshock = level.str_elec_damage_shellshock_override;
        }
        else
        {
            str_elec_shellshock = "electrocution";
        }
        
        self shellshock( str_elec_shellshock, shocktime );
        self playrumbleonentity( "damage_heavy" );
        
        if ( level.elec_loop == 0 )
        {
            elec_loop = 1;
            self playsound( "wpn_zmb_electrap_zap" );
        }
        
        if ( !self hasperk( "specialty_armorvest" ) || self.health - 100 < 1 )
        {
            self dodamage( self.health + 100, self.origin );
            self.is_burning = undefined;
            return;
        }
        
        self dodamage( 50, self.origin );
        wait 0.1;
        self.is_burning = undefined;
    }
}

// Namespace zm_traps
// Params 0
// Checksum 0x5bfc8bc9, Offset: 0x2488
// Size: 0x17e
function player_fire_damage()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    if ( !( isdefined( self.is_burning ) && self.is_burning ) && !self laststand::player_is_in_laststand() )
    {
        self.is_burning = 1;
        
        if ( isdefined( level.trap_fire_visionset_registered ) && level.trap_fire_visionset_registered )
        {
            visionset_mgr::activate( "overlay", "zm_trap_burn", self, 1.25, 1.25 );
        }
        else
        {
            self setburn( 1.25 );
        }
        
        self notify( #"burned" );
        
        if ( !self hasperk( "specialty_armorvest" ) || self.health - 100 < 1 )
        {
            radiusdamage( self.origin, 10, self.health + 100, self.health + 100 );
            self.is_burning = undefined;
            return;
        }
        
        self dodamage( 50, self.origin );
        wait 0.1;
        self.is_burning = undefined;
    }
}

// Namespace zm_traps
// Params 2
// Checksum 0xc4d49547, Offset: 0x2610
// Size: 0x434
function zombie_trap_death( trap, param )
{
    self endon( #"death" );
    self.marked_for_death = 1;
    
    switch ( trap._trap_type )
    {
        case "rocket":
            if ( isdefined( self.animname ) && self.animname != "zombie_dog" )
            {
                if ( param > 90 && level.burning_zombies.size < 6 )
                {
                    level.burning_zombies[ level.burning_zombies.size ] = self;
                    self thread zombie_flame_watch();
                    self playsound( "zmb_ignite" );
                    self thread zombie_death::flame_death_fx();
                    playfxontag( level._effect[ "character_fire_death_torso" ], self, "J_SpineLower" );
                    wait randomfloat( 1.25 );
                }
                else
                {
                    refs[ 0 ] = "guts";
                    refs[ 1 ] = "right_arm";
                    refs[ 2 ] = "left_arm";
                    refs[ 3 ] = "right_leg";
                    refs[ 4 ] = "left_leg";
                    refs[ 5 ] = "no_legs";
                    refs[ 6 ] = "head";
                    self.a.gib_ref = refs[ randomint( refs.size ) ];
                    playsoundatposition( "wpn_zmb_electrap_zap", self.origin );
                    wait randomfloat( 1.25 );
                    self playsound( "wpn_zmb_electrap_zap" );
                }
            }
            
            if ( isdefined( self.fire_damage_func ) )
            {
                self [[ self.fire_damage_func ]]( trap );
            }
            else
            {
                level notify( #"trap_kill", self, trap );
                self dodamage( self.health + 666, self.origin, trap );
            }
            
            break;
        case "centrifuge":
        default:
            ang = vectortoangles( trap.origin - self.origin );
            direction_vec = vectorscale( anglestoright( ang ), param );
            
            if ( isdefined( self.trap_reaction_func ) )
            {
                self [[ self.trap_reaction_func ]]( trap );
            }
            
            level notify( #"trap_kill", self, trap );
            self startragdoll();
            self launchragdoll( direction_vec );
            util::wait_network_frame();
            self.a.gib_ref = "head";
            self dodamage( self.health, self.origin, trap );
            break;
    }
    
    if ( isdefined( trap.activated_by_player ) && isplayer( trap.activated_by_player ) )
    {
        trap.activated_by_player zm_stats::increment_challenge_stat( "ZOMBIE_HUNTER_KILL_TRAP" );
    }
}

// Namespace zm_traps
// Params 0
// Checksum 0x35da5586, Offset: 0x2a50
// Size: 0x3c
function zombie_flame_watch()
{
    self waittill( #"death" );
    self stoploopsound();
    arrayremovevalue( level.burning_zombies, self );
}

// Namespace zm_traps
// Params 0
// Checksum 0xa811d04, Offset: 0x2a98
// Size: 0x84
function play_elec_vocals()
{
    if ( isdefined( self ) )
    {
        org = self.origin;
        wait 0.15;
        playsoundatposition( "zmb_elec_vocals", org );
        playsoundatposition( "wpn_zmb_electrap_zap", org );
        playsoundatposition( "zmb_exp_jib_zombie", org );
    }
}

// Namespace zm_traps
// Params 0
// Checksum 0xb0735da6, Offset: 0x2b28
// Size: 0x2ec
function electroctute_death_fx()
{
    self endon( #"death" );
    
    if ( isdefined( self.is_electrocuted ) && self.is_electrocuted )
    {
        return;
    }
    
    self.is_electrocuted = 1;
    self thread electrocute_timeout();
    
    if ( self.team == level.zombie_team )
    {
        level.bconfiretime = gettime();
        level.bconfireorg = self.origin;
    }
    
    if ( isdefined( level._effect[ "elec_torso" ] ) )
    {
        playfxontag( level._effect[ "elec_torso" ], self, "J_SpineLower" );
    }
    
    self playsound( "zmb_elec_jib_zombie" );
    wait 1;
    tagarray = [];
    tagarray[ 0 ] = "J_Elbow_LE";
    tagarray[ 1 ] = "J_Elbow_RI";
    tagarray[ 2 ] = "J_Knee_RI";
    tagarray[ 3 ] = "J_Knee_LE";
    tagarray = array::randomize( tagarray );
    
    if ( isdefined( level._effect[ "elec_md" ] ) )
    {
        playfxontag( level._effect[ "elec_md" ], self, tagarray[ 0 ] );
    }
    
    self playsound( "zmb_elec_jib_zombie" );
    wait 1;
    self playsound( "zmb_elec_jib_zombie" );
    tagarray[ 0 ] = "J_Wrist_RI";
    tagarray[ 1 ] = "J_Wrist_LE";
    
    if ( !isdefined( self.a.gib_ref ) || self.a.gib_ref != "no_legs" )
    {
        tagarray[ 2 ] = "J_Ankle_RI";
        tagarray[ 3 ] = "J_Ankle_LE";
    }
    
    tagarray = array::randomize( tagarray );
    
    if ( isdefined( level._effect[ "elec_sm" ] ) )
    {
        playfxontag( level._effect[ "elec_sm" ], self, tagarray[ 0 ] );
        playfxontag( level._effect[ "elec_sm" ], self, tagarray[ 1 ] );
    }
}

// Namespace zm_traps
// Params 0
// Checksum 0x28d588f2, Offset: 0x2e20
// Size: 0x7e
function electrocute_timeout()
{
    self endon( #"death" );
    self playloopsound( "amb_fire_manager_0" );
    wait 12;
    self stoploopsound();
    
    if ( isdefined( self ) && isalive( self ) )
    {
        self.is_electrocuted = 0;
        self notify( #"stop_flame_damage" );
    }
}

// Namespace zm_traps
// Params 0
// Checksum 0x18ca2b0d, Offset: 0x2ea8
// Size: 0x194
function trap_dialog()
{
    self endon( #"warning_dialog" );
    level endon( #"switch_flipped" );
    timer = 0;
    
    while ( true )
    {
        wait 0.5;
        players = getplayers();
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( !isdefined( players[ i ] ) )
            {
                continue;
            }
            
            dist = distancesquared( players[ i ].origin, self.origin );
            
            if ( dist > 4900 )
            {
                timer = 0;
                continue;
            }
            
            if ( dist < 4900 && timer < 3 )
            {
                wait 0.5;
                timer++;
            }
            
            if ( dist < 4900 && timer == 3 )
            {
                index = zm_utility::get_player_index( players[ i ] );
                plr = "plr_" + index + "_";
                wait 3;
                self notify( #"warning_dialog" );
            }
        }
    }
}

// Namespace zm_traps
// Params 1
// Checksum 0xa8a36d08, Offset: 0x3048
// Size: 0xaa
function get_trap_array( trap_type )
{
    ents = getentarray( "zombie_trap", "targetname" );
    traps = [];
    
    for ( i = 0; i < ents.size ; i++ )
    {
        if ( ents[ i ].script_noteworthy == trap_type )
        {
            traps[ traps.size ] = ents[ i ];
        }
    }
    
    return traps;
}

// Namespace zm_traps
// Params 0
// Checksum 0x26b078d5, Offset: 0x3100
// Size: 0x98
function trap_disable()
{
    cooldown = self._trap_cooldown_time;
    
    if ( self._trap_in_use )
    {
        self notify( #"trap_done" );
        self._trap_cooldown_time = 0.05;
        self waittill( #"available" );
    }
    
    array::thread_all( self._trap_use_trigs, &triggerenable, 0 );
    self trap_lights_red();
    self._trap_cooldown_time = cooldown;
}

// Namespace zm_traps
// Params 0
// Checksum 0x9fdba38b, Offset: 0x31a0
// Size: 0x4c
function trap_enable()
{
    array::thread_all( self._trap_use_trigs, &triggerenable, 1 );
    self trap_lights_green();
}

// Namespace zm_traps
// Params 0
// Checksum 0xd7509302, Offset: 0x31f8
// Size: 0xd6
function trap_model_type_init()
{
    if ( !isdefined( self.script_parameters ) )
    {
        self.script_parameters = "default";
    }
    
    switch ( self.script_parameters )
    {
        case "pentagon_electric":
            self._trap_light_model_off = "zombie_trap_switch_light";
            self._trap_light_model_green = "zombie_trap_switch_light_on_green";
            self._trap_light_model_red = "zombie_trap_switch_light_on_red";
            self._trap_switch_model = "zombie_trap_switch_handle";
            break;
        case "default":
        default:
            self._trap_light_model_off = "zombie_zapper_cagelight";
            self._trap_light_model_green = "zombie_zapper_cagelight";
            self._trap_light_model_red = "zombie_zapper_cagelight";
            self._trap_switch_model = "zombie_zapper_handle";
            break;
    }
}

// Namespace zm_traps
// Params 1
// Checksum 0x374edd94, Offset: 0x32d8
// Size: 0x1a, Type: bool
function is_trap_registered( a_registered_traps )
{
    return isdefined( a_registered_traps[ self.script_noteworthy ] );
}

// Namespace zm_traps
// Params 3
// Checksum 0x697ad7f, Offset: 0x3300
// Size: 0xe4
function register_trap_basic_info( str_trap, func_activate, func_audio )
{
    assert( isdefined( str_trap ), "<dev string:x5f>" );
    assert( isdefined( func_activate ), "<dev string:x9d>" );
    assert( isdefined( func_audio ), "<dev string:xdc>" );
    _register_undefined_trap( str_trap );
    level._custom_traps[ str_trap ].activate = func_activate;
    level._custom_traps[ str_trap ].audio = func_audio;
}

// Namespace zm_traps
// Params 1
// Checksum 0x8ee7d68c, Offset: 0x33f0
// Size: 0x5a
function _register_undefined_trap( str_trap )
{
    if ( !isdefined( level._custom_traps ) )
    {
        level._custom_traps = [];
    }
    
    if ( !isdefined( level._custom_traps[ str_trap ] ) )
    {
        level._custom_traps[ str_trap ] = spawnstruct();
    }
}

// Namespace zm_traps
// Params 3
// Checksum 0xc9fe2270, Offset: 0x3458
// Size: 0x94
function register_trap_damage( str_trap, func_player_damage, func_damage )
{
    assert( isdefined( str_trap ), "<dev string:x5f>" );
    _register_undefined_trap( str_trap );
    level._custom_traps[ str_trap ].player_damage = func_player_damage;
    level._custom_traps[ str_trap ].damage = func_damage;
}

