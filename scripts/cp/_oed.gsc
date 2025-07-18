#using scripts/codescripts/struct;
#using scripts/cp/gametypes/_save;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace oed;

// Namespace oed
// Params 0, eflags: 0x2
// Checksum 0xc005c270, Offset: 0x2d8
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "oed", &__init__, &__main__, undefined );
}

// Namespace oed
// Params 0
// Checksum 0x14f4e14b, Offset: 0x320
// Size: 0x3bc
function __init__()
{
    clientfield::register( "toplayer", "ev_toggle", 1, 1, "int" );
    clientfield::register( "toplayer", "sitrep_toggle", 1, 1, "int" );
    clientfield::register( "toplayer", "tmode_toggle", 1, 3, "int" );
    clientfield::register( "toplayer", "active_dni_fx", 1, 1, "counter" );
    clientfield::register( "toplayer", "hack_dni_fx", 1, 1, "counter" );
    clientfield::register( "actor", "thermal_active", 1, 1, "int" );
    clientfield::register( "actor", "sitrep_material", 1, 1, "int" );
    clientfield::register( "actor", "force_tmode", 1, 1, "int" );
    clientfield::register( "actor", "tagged", 1, 1, "int" );
    clientfield::register( "vehicle", "thermal_active", 1, 1, "int" );
    clientfield::register( "vehicle", "sitrep_material", 1, 1, "int" );
    clientfield::register( "scriptmover", "thermal_active", 1, 1, "int" );
    clientfield::register( "scriptmover", "sitrep_material", 1, 1, "int" );
    clientfield::register( "item", "sitrep_material", 1, 1, "int" );
    
    if ( !isdefined( level.vsmgr_prio_visionset_tmode ) )
    {
        level.vsmgr_prio_visionset_tmode = 50;
    }
    
    visionset_mgr::register_info( "visionset", "tac_mode", 1, level.vsmgr_prio_visionset_tmode, 15, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0 );
    callback::on_spawned( &on_player_spawned );
    spawner::add_global_spawn_function( "axis", &enable_thermal_on_spawned );
    spawner::add_global_spawn_function( "allies", &enable_thermal_on_spawned );
    level.b_enhanced_vision_enabled = 1;
    level.b_tactical_mode_enabled = 1;
    level.b_player_scene_active = 0;
    level.enable_thermal = &enable_thermal;
    level.disable_thermal = &disable_thermal;
}

// Namespace oed
// Params 0
// Checksum 0x3f596e70, Offset: 0x6e8
// Size: 0x14
function __main__()
{
    keyline_weapons();
}

// Namespace oed
// Params 0
// Checksum 0x83f9c8ed, Offset: 0x708
// Size: 0x74
function keyline_weapons()
{
    waittillframeend();
    
    if ( level.b_tactical_mode_enabled )
    {
        array::thread_all( util::query_ents( associativearray( "classname", "weapon_" ), 1, [], 1, 1 ), &enable_keyline );
    }
}

// Namespace oed
// Params 0
// Checksum 0xbeab933a, Offset: 0x788
// Size: 0x13c
function on_player_spawned()
{
    self.b_enhanced_vision_enabled = level.b_enhanced_vision_enabled;
    self.ev_state = 0;
    self ev_activate_on_player( self.ev_state );
    self.b_tactical_mode_enabled = level.b_tactical_mode_enabled;
    self.tmode_state = 0;
    b_playsound = 0;
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        if ( isdefined( getlocalprofileint( "tacticalModeAutoOn" ) ) && getlocalprofileint( "tacticalModeAutoOn" ) )
        {
            self.tmode_state = 1;
            b_playsound = 0;
        }
    }
    
    self tmode_activate_on_player( self.tmode_state, b_playsound );
    self clientfield::set_to_player( "sitrep_toggle", 1 );
    self thread function_cec8e852();
    self thread init_heroes();
}

// Namespace oed
// Params 0
// Checksum 0x9d6433fd, Offset: 0x8d0
// Size: 0x1f8
function function_cec8e852()
{
    self endon( #"death" );
    self endon( #"killoedmonitor" );
    
    while ( true )
    {
        /#
            level flagsys::wait_till_clear( "<dev string:x28>" );
        #/
        
        if ( level.b_enhanced_vision_enabled && self.b_enhanced_vision_enabled && self actionslotonebuttonpressed() )
        {
            if ( !scene::is_igc_active() )
            {
                self.ev_state = !( isdefined( self.ev_state ) && self.ev_state );
                self ev_activate_on_player( self.ev_state );
                
                while ( self actionslotonebuttonpressed() )
                {
                    wait 0.05;
                }
            }
        }
        
        if ( !sessionmodeiscampaignzombiesgame() && level.b_tactical_mode_enabled && self.b_tactical_mode_enabled && self actionslotfourbuttonpressed() )
        {
            if ( !scene::is_igc_active() )
            {
                self.tmode_state = !( isdefined( self.tmode_state ) && self.tmode_state );
                self tmode_activate_on_player( self.tmode_state );
                visionset_mgr::activate( "visionset", "tac_mode", self, 0.05, 0, 0.8 );
                wait 0.85;
                
                while ( self actionslotfourbuttonpressed() )
                {
                    wait 0.05;
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace oed
// Params 0
// Checksum 0x64fc4f22, Offset: 0xad0
// Size: 0x5c
function enable_thermal_on_spawned()
{
    if ( self.team == "axis" )
    {
        self enable_thermal();
        return;
    }
    
    if ( self.team == "allies" )
    {
        self enable_thermal();
    }
}

// Namespace oed
// Params 1
// Checksum 0x326818c7, Offset: 0xb38
// Size: 0x74
function enable_thermal( str_disable )
{
    self endon( #"death" );
    self clientfield::set( "thermal_active", 1 );
    self thread disable_thermal_on_death();
    
    if ( isdefined( str_disable ) )
    {
        level waittill( str_disable );
        self disable_thermal();
    }
}

// Namespace oed
// Params 0
// Checksum 0x1cbe5ffe, Offset: 0xbb8
// Size: 0x3c
function disable_thermal_on_death()
{
    self endon( #"disable_thermal" );
    self waittill( #"death" );
    
    if ( isdefined( self ) )
    {
        self disable_thermal();
    }
}

// Namespace oed
// Params 0
// Checksum 0xa498e3d0, Offset: 0xc00
// Size: 0x32
function disable_thermal()
{
    self clientfield::set( "thermal_active", 0 );
    self notify( #"disable_thermal" );
}

// Namespace oed
// Params 1
// Checksum 0x7213fd1f, Offset: 0xc40
// Size: 0xae
function toggle_thermal_mode_for_players( b_enabled )
{
    if ( !isdefined( b_enabled ) )
    {
        b_enabled = 1;
    }
    
    level.b_enhanced_vision_enabled = b_enabled;
    
    foreach ( e_player in level.players )
    {
        e_player.b_enhanced_vision_enabled = b_enabled;
    }
}

// Namespace oed
// Params 1
// Checksum 0x39b38f1c, Offset: 0xcf8
// Size: 0x4c
function enable_ev( b_enabled )
{
    if ( !isdefined( b_enabled ) )
    {
        b_enabled = 1;
    }
    
    self.b_enhanced_vision_enabled = b_enabled;
    
    if ( !b_enabled )
    {
        self ev_activate_on_player( b_enabled );
    }
}

// Namespace oed
// Params 1
// Checksum 0xc4891479, Offset: 0xd50
// Size: 0xc4
function enable_tac_mode( b_enabled )
{
    if ( !isdefined( b_enabled ) )
    {
        b_enabled = 1;
    }
    
    self.b_tactical_mode_enabled = b_enabled;
    
    if ( b_enabled )
    {
        if ( isdefined( getlocalprofileint( "tacticalModeAutoOn" ) ) && !sessionmodeiscampaignzombiesgame() && getlocalprofileint( "tacticalModeAutoOn" ) )
        {
            self tmode_activate_on_player( 1, 0 );
        }
        
        return;
    }
    
    self tmode_activate_on_player( 0, 0 );
}

// Namespace oed
// Params 1
// Checksum 0x582cd158, Offset: 0xe20
// Size: 0x34
function set_player_ev( b_enabled )
{
    if ( !isdefined( b_enabled ) )
    {
        b_enabled = 1;
    }
    
    ev_activate_on_player( b_enabled );
}

// Namespace oed
// Params 1
// Checksum 0xc5f1f7bf, Offset: 0xe60
// Size: 0x164
function ev_activate_on_player( b_enabled )
{
    if ( !isdefined( b_enabled ) )
    {
        b_enabled = 1;
    }
    
    self.ev_state = b_enabled;
    
    if ( self.ev_state )
    {
        if ( isdefined( self.tmode_state ) && self.tmode_state )
        {
            self.tmode_state_before_ev = 1;
        }
        else
        {
            self.tmode_state_before_ev = 0;
        }
        
        self tmode_activate_on_player( 0, 0, 0 );
    }
    
    if ( self.ev_state )
    {
        self notify( #"enhanced_vision_activated" );
    }
    else
    {
        self notify( #"enhanced_vision_deactivated" );
    }
    
    self clientfield::set_to_player( "ev_toggle", self.ev_state );
    
    if ( !self.ev_state )
    {
        if ( isdefined( self.tmode_state_before_ev ) && self.tmode_state_before_ev )
        {
            if ( isdefined( getlocalprofileint( "tacticalModeAutoOn" ) ) && !sessionmodeiscampaignzombiesgame() && getlocalprofileint( "tacticalModeAutoOn" ) )
            {
                self tmode_activate_on_player( 1, 0, 0 );
            }
        }
    }
}

// Namespace oed
// Params 3
// Checksum 0x7dabbb2c, Offset: 0xfd0
// Size: 0x194
function tmode_activate_on_player( b_enabled, b_playsound, b_turnoffev )
{
    if ( !isdefined( b_enabled ) )
    {
        b_enabled = 1;
    }
    
    if ( !isdefined( b_playsound ) )
    {
        b_playsound = 1;
    }
    
    if ( !isdefined( b_turnoffev ) )
    {
        b_turnoffev = 1;
    }
    
    self.tmode_state = b_enabled;
    
    if ( b_turnoffev && self.tmode_state )
    {
        self ev_activate_on_player( 0 );
    }
    
    if ( self.tmode_state )
    {
        self notify( #"tactical_mode_activated" );
    }
    else
    {
        self notify( #"tactical_mode_deactivated" );
    }
    
    self tmodesetserveruser( self.tmode_state );
    code = 0;
    
    if ( !isdefined( self.tmode_count ) )
    {
        self.tmode_count = 0;
    }
    
    self.tmode_count++;
    self.tmode_count &= 1;
    code = self.tmode_count;
    
    if ( b_playsound )
    {
        code |= 2;
    }
    
    if ( self.tmode_state )
    {
        code |= 4;
    }
    
    self clientfield::set_to_player( "tmode_toggle", code );
    self savegame::set_player_data( "tmode", self.tmode_state );
}

// Namespace oed
// Params 0
// Checksum 0x22f410bc, Offset: 0x1170
// Size: 0xca
function init_heroes()
{
    a_e_heroes = getentarray();
    
    foreach ( e_hero in a_e_heroes )
    {
        if ( isdefined( e_hero.is_hero ) && e_hero.is_hero )
        {
            e_hero thread enable_thermal();
        }
    }
}

// Namespace oed
// Params 1
// Checksum 0x9b87aa15, Offset: 0x1248
// Size: 0xae
function toggle_tac_mode_for_players( b_enabled )
{
    if ( !isdefined( b_enabled ) )
    {
        b_enabled = 1;
    }
    
    level.b_tactical_mode_enabled = b_enabled;
    
    foreach ( e_player in level.players )
    {
        e_player.b_tactical_mode_enabled = b_enabled;
    }
}

// Namespace oed
// Params 1
// Checksum 0xd7561243, Offset: 0x1300
// Size: 0x4c
function set_force_tmode( b_enabled )
{
    if ( !isdefined( b_enabled ) )
    {
        b_enabled = 1;
    }
    
    self.b_force_tmode = b_enabled;
    self clientfield::set( "force_tmode", b_enabled );
}

// Namespace oed
// Params 2
// Checksum 0x6a66af27, Offset: 0x1358
// Size: 0x94
function enable_keyline( b_interact, str_disable )
{
    if ( !isdefined( b_interact ) )
    {
        b_interact = 0;
    }
    
    self endon( #"death" );
    self clientfield::set( "sitrep_material", 1 );
    self thread disable_on_death();
    
    if ( isdefined( str_disable ) )
    {
        level waittill( str_disable );
        self disable_keyline();
    }
}

// Namespace oed
// Params 0
// Checksum 0xfaef3ff8, Offset: 0x13f8
// Size: 0x2c
function disable_on_death()
{
    self waittill( #"death" );
    
    if ( isdefined( self ) )
    {
        self disable_keyline();
    }
}

// Namespace oed
// Params 0
// Checksum 0xfcde8d83, Offset: 0x1430
// Size: 0x24
function disable_keyline()
{
    self clientfield::set( "sitrep_material", 0 );
}

// Namespace oed
// Params 1
// Checksum 0xff22c134, Offset: 0x1460
// Size: 0xea
function toggle_sitrep_for_players( b_active )
{
    if ( !isdefined( b_active ) )
    {
        b_active = 1;
    }
    
    foreach ( player in level.players )
    {
        player.sitrep_active = !( isdefined( player.sitrep_active ) && player.sitrep_active );
        player clientfield::set_to_player( "sitrep_toggle", player.sitrep_active );
    }
}

// Namespace oed
// Params 0
// Checksum 0xa1955d30, Offset: 0x1558
// Size: 0xc8
function init_sitrep_model()
{
    if ( !isdefined( self.angles ) )
    {
        self.angles = ( 0, 0, 0 );
    }
    
    s_sitrep_bundle = level.scriptbundles[ "sitrep" ][ self.scriptbundlename ];
    e_sitrep = util::spawn_model( s_sitrep_bundle.model, self.origin, self.angles );
    
    if ( isdefined( s_sitrep_bundle.sitrep_interact ) )
    {
        e_sitrep.script_sitrep_id = s_sitrep_bundle.sitrep_interact;
    }
    else
    {
        e_sitrep.script_sitrep_id = 0;
    }
    
    return e_sitrep;
}

