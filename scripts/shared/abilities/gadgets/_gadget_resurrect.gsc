#using scripts/codescripts/struct;
#using scripts/shared/_oob;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/weapons/_smokegrenade;

#namespace resurrect;

// Namespace resurrect
// Params 0, eflags: 0x2
// Checksum 0x1b73e12d, Offset: 0x4c8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_resurrect", &__init__, undefined, undefined );
}

// Namespace resurrect
// Params 0
// Checksum 0x600f0a12, Offset: 0x508
// Size: 0x2b4
function __init__()
{
    clientfield::register( "allplayers", "resurrecting", 1, 1, "int" );
    clientfield::register( "toplayer", "resurrect_state", 1, 2, "int" );
    clientfield::register( "clientuimodel", "hudItems.rejack.activationWindowEntered", 1, 1, "int" );
    clientfield::register( "clientuimodel", "hudItems.rejack.rejackActivated", 1, 1, "int" );
    ability_player::register_gadget_activation_callbacks( 40, &gadget_resurrect_on, &gadget_resurrect_off );
    ability_player::register_gadget_possession_callbacks( 40, &gadget_resurrect_on_give, &gadget_resurrect_on_take );
    ability_player::register_gadget_flicker_callbacks( 40, &gadget_resurrect_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 40, &gadget_resurrect_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 40, &gadget_resurrect_is_flickering );
    ability_player::register_gadget_primed_callbacks( 40, &gadget_resurrect_is_primed );
    ability_player::register_gadget_ready_callbacks( 40, &gadget_resurrect_is_ready );
    callback::on_connect( &gadget_resurrect_on_connect );
    callback::on_spawned( &gadget_resurrect_on_spawned );
    
    if ( !isdefined( level.vsmgr_prio_visionset_resurrect ) )
    {
        level.vsmgr_prio_visionset_resurrect = 62;
    }
    
    if ( !isdefined( level.vsmgr_prio_visionset_resurrect_up ) )
    {
        level.vsmgr_prio_visionset_resurrect_up = 63;
    }
    
    visionset_mgr::register_info( "visionset", "resurrect", 1, level.vsmgr_prio_visionset_resurrect, 16, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0 );
    visionset_mgr::register_info( "visionset", "resurrect_up", 1, level.vsmgr_prio_visionset_resurrect_up, 16, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0 );
}

// Namespace resurrect
// Params 1
// Checksum 0xb640e3a, Offset: 0x7c8
// Size: 0x22
function gadget_resurrect_is_inuse( slot )
{
    return self gadgetisactive( slot );
}

// Namespace resurrect
// Params 1
// Checksum 0x72462163, Offset: 0x7f8
// Size: 0x22
function gadget_resurrect_is_flickering( slot )
{
    return self gadgetflickering( slot );
}

// Namespace resurrect
// Params 2
// Checksum 0x8c03c3a9, Offset: 0x828
// Size: 0x14
function gadget_resurrect_on_flicker( slot, weapon )
{
    
}

// Namespace resurrect
// Params 2
// Checksum 0x64c8ac0e, Offset: 0x848
// Size: 0x2c
function gadget_resurrect_on_give( slot, weapon )
{
    self.usedresurrect = 0;
    self.resurrect_weapon = weapon;
}

// Namespace resurrect
// Params 2
// Checksum 0xee7e0715, Offset: 0x880
// Size: 0x3a
function gadget_resurrect_on_take( slot, weapon )
{
    self.overrideplayerdeadstatus = undefined;
    self.resurrect_weapon = undefined;
    self.secondarydeathcamtime = undefined;
    self notify( #"resurrect_taken" );
}

// Namespace resurrect
// Params 0
// Checksum 0xc8e4f6ec, Offset: 0x8c8
// Size: 0xf4
function gadget_resurrect_on_spawned()
{
    self clientfield::set_player_uimodel( "hudItems.rejack.activationWindowEntered", 0 );
    self util::show_hud( 1 );
    self._disable_proximity_alarms = 0;
    self flagsys::clear( "gadget_resurrect_ready" );
    self flagsys::clear( "gadget_resurrect_pending" );
    
    if ( self flagsys::get( "gadget_resurrect_activated" ) )
    {
        self thread do_resurrected_on_spawned_player_fx();
        self thread resurrect_drain_power();
        self flagsys::clear( "gadget_resurrect_activated" );
    }
}

// Namespace resurrect
// Params 1
// Checksum 0x62a9156a, Offset: 0x9c8
// Size: 0xac
function resurrect_drain_power( amount )
{
    if ( isdefined( self.resurrect_weapon ) )
    {
        slot = self gadgetgetslot( self.resurrect_weapon );
        
        if ( slot >= 0 && slot < 3 )
        {
            if ( isdefined( amount ) )
            {
                self gadgetpowerchange( slot, amount );
                return;
            }
            
            self gadgetstatechange( slot, self.resurrect_weapon, 3 );
        }
    }
}

// Namespace resurrect
// Params 0
// Checksum 0x99ec1590, Offset: 0xa80
// Size: 0x4
function gadget_resurrect_on_connect()
{
    
}

// Namespace resurrect
// Params 2
// Checksum 0x2fe851a7, Offset: 0xa90
// Size: 0x14
function gadget_resurrect_on( slot, weapon )
{
    
}

// Namespace resurrect
// Params 0
// Checksum 0xabd75b48, Offset: 0xab0
// Size: 0x194
function watch_smoke_detonate()
{
    self endon( #"player_input_suicide" );
    self endon( #"player_input_revive" );
    self endon( #"disconnect" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( ( self isplayerswimming() || self isonground() ) && !self iswallrunning() && !self istraversing() )
        {
            smoke_weapon = getweapon( "gadget_resurrect_smoke_grenade" );
            stat_weapon = getweapon( "gadget_resurrect" );
            smokeeffect = smokegrenade::smokedetonate( self, stat_weapon, smoke_weapon, self.origin, 128, 5, 4 );
            smokeeffect thread watch_smoke_effect_watch_suicide( self );
            smokeeffect thread watch_smoke_effect_watch_resurrect( self );
            smokeeffect thread watch_smoke_death( self );
            return;
        }
        
        wait 0.05;
    }
}

// Namespace resurrect
// Params 1
// Checksum 0xe13c0e20, Offset: 0xc50
// Size: 0x54
function watch_smoke_death( player )
{
    self endon( #"death" );
    player util::waittill_any_timeout( 5, "disconnect", "death" );
    self delete();
}

// Namespace resurrect
// Params 1
// Checksum 0x7c758b5c, Offset: 0xcb0
// Size: 0x3c
function watch_smoke_effect_watch_suicide( player )
{
    self endon( #"death" );
    player waittill( #"player_input_suicide" );
    self delete();
}

// Namespace resurrect
// Params 1
// Checksum 0x47e7833, Offset: 0xcf8
// Size: 0x44
function watch_smoke_effect_watch_resurrect( player )
{
    self endon( #"death" );
    player waittill( #"player_input_revive" );
    wait 0.5;
    self delete();
}

// Namespace resurrect
// Params 2
// Checksum 0x4dfba0d8, Offset: 0xd48
// Size: 0xfc
function gadget_resurrect_is_primed( slot, weapon )
{
    if ( isdefined( self.resurrect_not_allowed_by ) )
    {
        return;
    }
    
    self startresurrectviewangletransition();
    self.lastwaterdamagetime = gettime();
    self._disable_proximity_alarms = 1;
    self thread watch_smoke_detonate();
    self util::show_hud( 0 );
    visionset_mgr::activate( "visionset", "resurrect", self, 1.4, 4, 0.25 );
    self clientfield::set_to_player( "resurrect_state", 1 );
    self shellshock( "resurrect", 5.4, 0 );
}

// Namespace resurrect
// Params 2
// Checksum 0x9b22978c, Offset: 0xe50
// Size: 0x14
function gadget_resurrect_is_ready( slot, weapon )
{
    
}

// Namespace resurrect
// Params 2
// Checksum 0x77d530be, Offset: 0xec8
// Size: 0x4c
function gadget_resurrect_start( slot, weapon )
{
    wait 0.1;
    self gadgetsetactivatetime( slot, gettime() );
    self thread resurrect_delay( weapon );
}

// Namespace resurrect
// Params 2
// Checksum 0x7a8a4a47, Offset: 0xf20
// Size: 0x22
function gadget_resurrect_off( slot, weapon )
{
    self notify( #"gadget_resurrect_off" );
}

// Namespace resurrect
// Params 1
// Checksum 0xfe444ccc, Offset: 0xf50
// Size: 0x46
function resurrect_delay( weapon )
{
    self endon( #"disconnect" );
    self endon( #"game_ended" );
    self endon( #"death" );
    self notify( #"resurrect_delay" );
    self endon( #"resurrect_delay" );
}

// Namespace resurrect
// Params 1
// Checksum 0x47b37b66, Offset: 0xfa0
// Size: 0x84, Type: bool
function overridespawn( ispredictedspawn )
{
    if ( !self flagsys::get( "gadget_resurrect_ready" ) )
    {
        return false;
    }
    
    if ( !self flagsys::get( "gadget_resurrect_activated" ) )
    {
        return false;
    }
    
    if ( !isdefined( self.resurrect_origin ) )
    {
        self.resurrect_origin = self.origin;
        self.resurrect_angles = self.angles;
    }
    
    return true;
}

// Namespace resurrect
// Params 0
// Checksum 0xfd6ac5a1, Offset: 0x1030
// Size: 0x30, Type: bool
function is_jumping()
{
    ground_ent = self getgroundent();
    return !isdefined( ground_ent );
}

// Namespace resurrect
// Params 0
// Checksum 0x9bfea20f, Offset: 0x1068
// Size: 0x2e, Type: bool
function player_position_valid()
{
    if ( self clientfield::get_to_player( "out_of_bounds" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace resurrect
// Params 1
// Checksum 0xbda7e0bb, Offset: 0x10a0
// Size: 0xa2
function resurrect_breadcrumbs( slot )
{
    self endon( #"disconnect" );
    self endon( #"game_ended" );
    self endon( #"resurrect_taken" );
    self.resurrect_slot = slot;
    
    while ( true )
    {
        if ( isalive( self ) && self player_position_valid() )
        {
            self.resurrect_origin = self.origin;
            self.resurrect_angles = self.angles;
        }
        
        wait 1;
    }
}

// Namespace resurrect
// Params 1
// Checksum 0x59780211, Offset: 0x1150
// Size: 0x5c
function glow_for_time( time )
{
    self endon( #"disconnect" );
    self clientfield::set( "resurrecting", 1 );
    wait time;
    self clientfield::set( "resurrecting", 0 );
}

// Namespace resurrect
// Params 2
// Checksum 0x69b07d84, Offset: 0x11b8
// Size: 0x42
function wait_for_time( time, msg )
{
    self endon( #"disconnect" );
    self endon( #"game_ended" );
    self endon( msg );
    wait time;
    self notify( msg );
}

// Namespace resurrect
// Params 1
// Checksum 0x1c7b62dc, Offset: 0x1208
// Size: 0x7c
function wait_for_activate( msg )
{
    self endon( #"disconnect" );
    self endon( #"game_ended" );
    self endon( msg );
    
    while ( true )
    {
        if ( self offhandspecialbuttonpressed() )
        {
            self flagsys::set( "gadget_resurrect_activated" );
            self notify( msg );
        }
        
        wait 0.05;
    }
}

// Namespace resurrect
// Params 2
// Checksum 0x657ead84, Offset: 0x1290
// Size: 0xb6
function bot_wait_for_activate( msg, time )
{
    self endon( #"disconnect" );
    self endon( #"game_ended" );
    self endon( msg );
    
    if ( !self util::is_bot() )
    {
        return;
    }
    
    time = int( time + 1 );
    randwait = randomint( time );
    wait randwait;
    self flagsys::set( "gadget_resurrect_activated" );
    self notify( msg );
}

// Namespace resurrect
// Params 0
// Checksum 0xe02286c8, Offset: 0x1350
// Size: 0xc4
function do_resurrect_hint_fx()
{
    offset = ( 0, 0, 40 );
    fxorg = spawn( "script_model", self.resurrect_origin + offset );
    fxorg setmodel( "tag_origin" );
    fx = playfxontag( "player/fx_plyr_revive", fxorg, "tag_origin" );
    self waittill( #"resurrect_time_or_activate" );
    fxorg delete();
}

// Namespace resurrect
// Params 0
// Checksum 0x4ab8b8b9, Offset: 0x1420
// Size: 0x7c
function do_resurrected_on_dead_body_fx()
{
    if ( isdefined( self.body ) )
    {
        fx = playfx( "player/fx_plyr_revive_demat", self.body.origin );
        self.body notsolid();
        self.body ghost();
    }
}

// Namespace resurrect
// Params 0
// Checksum 0xa59962fc, Offset: 0x14a8
// Size: 0x50
function do_resurrected_on_spawned_player_fx()
{
    playsoundatposition( "mpl_resurrect_npc", self.origin );
    fx = playfx( "player/fx_plyr_rejack_light", self.origin );
}

// Namespace resurrect
// Params 2
// Checksum 0x58da8d16, Offset: 0x1500
// Size: 0x24c
function resurrect_watch_for_death( slot, weapon )
{
    self endon( #"disconnect" );
    self endon( #"game_ended" );
    self waittill( #"death" );
    resurrect_time = 3;
    
    if ( isdefined( weapon.gadget_resurrect_duration ) )
    {
        resurrect_time = weapon.gadget_resurrect_duration / 1000;
    }
    
    self.usedresurrect = 0;
    self flagsys::clear( "gadget_resurrect_activated" );
    self flagsys::set( "gadget_resurrect_pending" );
    self.resurrect_available_time = gettime();
    self thread wait_for_time( resurrect_time, "resurrect_time_or_activate" );
    self thread wait_for_activate( "resurrect_time_or_activate" );
    self thread bot_wait_for_activate( "resurrect_time_or_activate", resurrect_time );
    self thread do_resurrect_hint_fx();
    self waittill( #"resurrect_time_or_activate" );
    self flagsys::clear( "gadget_resurrect_pending" );
    
    if ( self flagsys::get( "gadget_resurrect_activated" ) )
    {
        self thread do_resurrected_on_dead_body_fx();
        self notify( #"end_death_delay" );
        self notify( #"end_killcam" );
        self.cancelkillcam = 1;
        self.usedresurrect = 1;
        self notify( #"end_death_delay" );
        self notify( #"force_spawn" );
        
        if ( !( isdefined( 1 ) && 1 ) )
        {
            self.pers[ "resetMomentumOnSpawn" ] = 0;
        }
        
        if ( isdefined( level.playgadgetsuccess ) )
        {
            self [[ level.playgadgetsuccess ]]( weapon, "resurrectSuccessDelay" );
        }
    }
}

// Namespace resurrect
// Params 0
// Checksum 0x56ae792e, Offset: 0x1758
// Size: 0x2e, Type: bool
function gadget_resurrect_delay_updateteamstatus()
{
    if ( self flagsys::get( "gadget_resurrect_ready" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace resurrect
// Params 0
// Checksum 0x5df29cd7, Offset: 0x1790
// Size: 0x70
function gadget_resurrect_is_player_predead()
{
    should_not_be_dead = 0;
    
    if ( self.sessionstate == "playing" && isalive( self ) )
    {
        should_not_be_dead = 1;
    }
    
    if ( self flagsys::get( "gadget_resurrect_pending" ) )
    {
        return 1;
    }
    
    return should_not_be_dead;
}

// Namespace resurrect
// Params 0
// Checksum 0x321fc7d4, Offset: 0x1808
// Size: 0xc6
function gadget_resurrect_secondary_deathcam_time()
{
    if ( self flagsys::get( "gadget_resurrect_pending" ) && isdefined( self.resurrect_available_time ) )
    {
        resurrect_time = 3000;
        weapon = self.resurrect_weapon;
        
        if ( isdefined( weapon.gadget_resurrect_duration ) )
        {
            resurrect_time = weapon.gadget_resurrect_duration;
        }
        
        time_left = resurrect_time - gettime() - self.resurrect_available_time;
        
        if ( time_left > 0 )
        {
            return ( time_left / 1000 );
        }
    }
    
    return 0;
}

// Namespace resurrect
// Params 0
// Checksum 0x7f3ffe10, Offset: 0x18d8
// Size: 0xe4
function enter_rejack_standby()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    level endon( #"game_ended" );
    self.rejack_activate_requested = 0;
    
    if ( isdefined( level.resetplayerscorestreaks ) )
    {
        [[ level.resetplayerscorestreaks ]]( self );
    }
    
    self init_rejack_ui();
    self thread watch_rejack_activate_requested();
    self thread watch_rejack_suicide();
    wait 1.4;
    self thread watch_rejack_activate();
    self thread watch_rejack_timeout();
    self thread watch_bad_trigger_touch();
}

// Namespace resurrect
// Params 0
// Checksum 0x83fea633, Offset: 0x19c8
// Size: 0x74
function rejack_suicide()
{
    self notify( #"heroability_off" );
    visionset_mgr::deactivate( "visionset", "resurrect", self );
    self thread remove_rejack_ui();
    self util::show_hud( 1 );
    player_suicide();
}

// Namespace resurrect
// Params 0
// Checksum 0x52a3ab80, Offset: 0x1a48
// Size: 0x150
function watch_bad_trigger_touch()
{
    self endon( #"player_input_revive" );
    self endon( #"player_input_suicide" );
    self endon( #"disconnect" );
    self endon( #"death" );
    level endon( #"game_ended" );
    a_killbrushes = getentarray( "trigger_hurt", "classname" );
    
    while ( true )
    {
        a_killbrushes = getentarray( "trigger_hurt", "classname" );
        
        for ( i = 0; i < a_killbrushes.size ; i++ )
        {
            if ( self istouching( a_killbrushes[ i ] ) )
            {
                if ( !a_killbrushes[ i ] istriggerenabled() )
                {
                    continue;
                }
                
                self rejack_suicide();
            }
        }
        
        if ( self oob::istouchinganyoobtrigger() )
        {
            self rejack_suicide();
        }
        
        wait 0.05;
    }
}

// Namespace resurrect
// Params 0
// Checksum 0x14dffd70, Offset: 0x1ba0
// Size: 0x94
function watch_rejack_timeout()
{
    self endon( #"player_input_revive" );
    self endon( #"player_input_suicide" );
    self endon( #"disconnect" );
    self endon( #"death" );
    level endon( #"game_ended" );
    wait 4;
    self playsound( "mpl_rejack_suicide_timeout" );
    self thread resurrect_drain_power( -30 );
    self rejack_suicide();
}

// Namespace resurrect
// Params 0
// Checksum 0x55e1536b, Offset: 0x1c40
// Size: 0xf4
function watch_rejack_suicide()
{
    self endon( #"player_input_revive" );
    self endon( #"disconnect" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( self usebuttonpressed() )
    {
        wait 1;
    }
    
    if ( isdefined( self.laststand ) && self.laststand )
    {
        starttime = gettime();
        
        while ( true )
        {
            if ( !self usebuttonpressed() )
            {
                starttime = gettime();
            }
            
            if ( starttime + 500 < gettime() )
            {
                self rejack_suicide();
                self playsound( "mpl_rejack_suicide" );
                return;
            }
            
            wait 0.01;
        }
    }
}

// Namespace resurrect
// Params 0
// Checksum 0xbd00a791, Offset: 0x1d40
// Size: 0x6e
function reload_clip_on_stand()
{
    weapons = self getweaponslistprimaries();
    
    for ( i = 0; i < weapons.size ; i++ )
    {
        self reloadweaponammo( weapons[ i ] );
    }
}

// Namespace resurrect
// Params 0
// Checksum 0x6d975005, Offset: 0x1db8
// Size: 0xa8
function watch_rejack_activate_requested()
{
    self endon( #"player_input_suicide" );
    self endon( #"player_input_revive" );
    self endon( #"disconnect" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( self offhandspecialbuttonpressed() )
    {
        wait 0.05;
    }
    
    self.rejack_activate_requested = 0;
    
    while ( !self.rejack_activate_requested )
    {
        if ( self offhandspecialbuttonpressed() )
        {
            self.rejack_activate_requested = 1;
        }
        
        wait 0.05;
    }
}

// Namespace resurrect
// Params 0
// Checksum 0x63e5f954, Offset: 0x1e68
// Size: 0x1b4
function watch_rejack_activate()
{
    self endon( #"player_input_suicide" );
    self endon( #"disconnect" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( isdefined( self.laststand ) && self.laststand )
    {
        while ( true )
        {
            wait 0.05;
            
            if ( isdefined( self.rejack_activate_requested ) && self.rejack_activate_requested )
            {
                self notify( #"player_input_revive" );
                
                if ( isdefined( level.start_player_health_regen ) )
                {
                    self thread [[ level.start_player_health_regen ]]();
                }
                
                self._disable_proximity_alarms = 0;
                self thread do_resurrected_on_spawned_player_fx();
                self thread resurrect_drain_power();
                self thread rejack_ui_activate();
                visionset_mgr::deactivate( "visionset", "resurrect", self );
                visionset_mgr::activate( "visionset", "resurrect_up", self, 0.35, 0.1, 0.2 );
                self clientfield::set_to_player( "resurrect_state", 2 );
                self stopshellshock();
                self reload_clip_on_stand();
                level notify( #"hero_gadget_activated", self );
                self notify( #"hero_gadget_activated" );
                return;
            }
        }
    }
}

// Namespace resurrect
// Params 0
// Checksum 0xdb866984, Offset: 0x2028
// Size: 0x84
function init_rejack_ui()
{
    self clientfield::set_player_uimodel( "hudItems.rejack.activationWindowEntered", 1 );
    self luinotifyevent( &"create_rejack_timer", 1, gettime() + int( 4000 ) );
    self clientfield::set_player_uimodel( "hudItems.rejack.rejackActivated", 0 );
}

// Namespace resurrect
// Params 0
// Checksum 0xeb13bbe8, Offset: 0x20b8
// Size: 0x4c
function remove_rejack_ui()
{
    self endon( #"disconnect" );
    wait 1.5;
    self clientfield::set_player_uimodel( "hudItems.rejack.activationWindowEntered", 0 );
    self util::show_hud( 1 );
}

// Namespace resurrect
// Params 0
// Checksum 0x5eac87a, Offset: 0x2110
// Size: 0x3c
function rejack_ui_activate()
{
    self clientfield::set_player_uimodel( "hudItems.rejack.rejackActivated", 1 );
    self thread remove_rejack_ui();
}

// Namespace resurrect
// Params 0
// Checksum 0x4628cc1e, Offset: 0x2158
// Size: 0x54
function player_suicide()
{
    self._disable_proximity_alarms = 0;
    self notify( #"player_input_suicide" );
    self clientfield::set_to_player( "resurrect_state", 0 );
    self thread resurrect_drain_power( -30 );
}

