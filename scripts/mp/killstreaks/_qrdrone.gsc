#using scripts/codescripts/struct;
#using scripts/mp/_challenges;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_shellshock;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/killstreaks/_ai_tank;
#using scripts/mp/killstreaks/_airsupport;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_remote_weapons;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_heatseekingmissile;
#using scripts/shared/weapons/_weaponobjects;

#namespace qrdrone;

// Namespace qrdrone
// Params 0
// Checksum 0x93172def, Offset: 0xb68
// Size: 0x564
function init()
{
    level.qrdrone_vehicle = "qrdrone_mp";
    level.ai_tank_stun_fx = "killstreaks/fx_agr_emp_stun";
    level.qrdrone_minigun_flash = "weapon/fx_muz_md_rifle_3p";
    level.qrdrone_fx[ "explode" ] = "killstreaks/fx_drgnfire_explosion";
    level._effect[ "quadrotor_nudge" ] = "killstreaks/fx_drgnfire_impact_sparks";
    level._effect[ "quadrotor_damage" ] = "killstreaks/fx_drgnfire_damage_state";
    level.qrdrone_dialog[ "launch" ][ 0 ] = "ac130_plt_yeahcleared";
    level.qrdrone_dialog[ "launch" ][ 1 ] = "ac130_plt_rollinin";
    level.qrdrone_dialog[ "launch" ][ 2 ] = "ac130_plt_scanrange";
    level.qrdrone_dialog[ "out_of_range" ][ 0 ] = "ac130_plt_cleanup";
    level.qrdrone_dialog[ "out_of_range" ][ 1 ] = "ac130_plt_targetreset";
    level.qrdrone_dialog[ "track" ][ 0 ] = "ac130_fco_moreenemy";
    level.qrdrone_dialog[ "track" ][ 1 ] = "ac130_fco_getthatguy";
    level.qrdrone_dialog[ "track" ][ 2 ] = "ac130_fco_guymovin";
    level.qrdrone_dialog[ "track" ][ 3 ] = "ac130_fco_getperson";
    level.qrdrone_dialog[ "track" ][ 4 ] = "ac130_fco_guyrunnin";
    level.qrdrone_dialog[ "track" ][ 5 ] = "ac130_fco_gotarunner";
    level.qrdrone_dialog[ "track" ][ 6 ] = "ac130_fco_backonthose";
    level.qrdrone_dialog[ "track" ][ 7 ] = "ac130_fco_gonnagethim";
    level.qrdrone_dialog[ "track" ][ 8 ] = "ac130_fco_personnelthere";
    level.qrdrone_dialog[ "track" ][ 9 ] = "ac130_fco_rightthere";
    level.qrdrone_dialog[ "track" ][ 10 ] = "ac130_fco_tracking";
    level.qrdrone_dialog[ "tag" ][ 0 ] = "ac130_fco_nice";
    level.qrdrone_dialog[ "tag" ][ 1 ] = "ac130_fco_yougothim";
    level.qrdrone_dialog[ "tag" ][ 2 ] = "ac130_fco_yougothim2";
    level.qrdrone_dialog[ "tag" ][ 3 ] = "ac130_fco_okyougothim";
    level.qrdrone_dialog[ "assist" ][ 0 ] = "ac130_fco_goodkill";
    level.qrdrone_dialog[ "assist" ][ 1 ] = "ac130_fco_thatsahit";
    level.qrdrone_dialog[ "assist" ][ 2 ] = "ac130_fco_directhit";
    level.qrdrone_dialog[ "assist" ][ 3 ] = "ac130_fco_rightontarget";
    level.qrdrone_lastdialogtime = 0;
    level.qrdrone_nodeployzones = getentarray( "no_vehicles", "targetname" );
    level._effect[ "qrdrone_prop" ] = "_t6/weapon/qr_drone/fx_qr_wash_3p";
    
    /#
        util::set_dvar_if_unset( "<dev string:x28>", 60 );
    #/
    
    clientfield::register( "helicopter", "qrdrone_state", 1, 3, "int" );
    clientfield::register( "helicopter", "qrdrone_timeout", 1, 1, "int" );
    clientfield::register( "helicopter", "qrdrone_countdown", 1, 1, "int" );
    clientfield::register( "vehicle", "qrdrone_state", 1, 3, "int" );
    clientfield::register( "vehicle", "qrdrone_timeout", 1, 1, "int" );
    clientfield::register( "vehicle", "qrdrone_countdown", 1, 1, "int" );
    clientfield::register( "vehicle", "qrdrone_out_of_range", 1, 1, "int" );
    level.qrdroneonblowup = &qrdrone_blowup;
    level.qrdroneondamage = &qrdrone_damagewatcher;
}

// Namespace qrdrone
// Params 1
// Checksum 0x1921109e, Offset: 0x10d8
// Size: 0xc0
function tryuseqrdrone( lifeid )
{
    if ( self util::isusingremote() || isdefined( level.nukeincoming ) )
    {
        return 0;
    }
    
    if ( !self isonground() )
    {
        self iprintlnbold( &"KILLSTREAK_QRDRONE_NOT_PLACEABLE" );
        return 0;
    }
    
    streakname = "TODO";
    result = self givecarryqrdrone( lifeid, streakname );
    self.iscarrying = 0;
    return result;
}

// Namespace qrdrone
// Params 2
// Checksum 0x7aa7e408, Offset: 0x11a0
// Size: 0x120
function givecarryqrdrone( lifeid, streakname )
{
    carryqrdrone = createcarryqrdrone( streakname, self );
    self setcarryingqrdrone( carryqrdrone );
    
    if ( isalive( self ) && isdefined( carryqrdrone ) )
    {
        origin = carryqrdrone.origin;
        angles = self.angles;
        carryqrdrone.soundent delete();
        carryqrdrone delete();
        result = self startqrdrone( lifeid, streakname, origin, angles );
    }
    else
    {
        result = 0;
    }
    
    return result;
}

// Namespace qrdrone
// Params 2
// Checksum 0xf06a16f2, Offset: 0x12c8
// Size: 0x330
function createcarryqrdrone( streakname, owner )
{
    pos = owner.origin + anglestoforward( owner.angles ) * 4 + anglestoup( owner.angles ) * 50;
    carryqrdrone = spawnturret( "misc_turret", pos, getweapon( "auto_gun_turret" ) );
    carryqrdrone.turrettype = "sentry";
    carryqrdrone setturrettype( carryqrdrone.turrettype );
    carryqrdrone.origin = pos;
    carryqrdrone.angles = owner.angles;
    carryqrdrone.canbeplaced = 1;
    carryqrdrone makeunusable();
    carryqrdrone.owner = owner;
    carryqrdrone setowner( carryqrdrone.owner );
    carryqrdrone.scale = 3;
    carryqrdrone.inheliproximity = 0;
    carryqrdrone thread carryqrdrone_handleexistence();
    carryqrdrone.rangetrigger = getent( "qrdrone_range", "targetname" );
    
    if ( !isdefined( carryqrdrone.rangetrigger ) )
    {
        carryqrdrone.maxheight = int( airsupport::getminimumflyheight() );
        carryqrdrone.maxdistance = 3600;
    }
    
    carryqrdrone.minheight = level.mapcenter[ 2 ] - 800;
    carryqrdrone.soundent = spawn( "script_origin", carryqrdrone.origin );
    carryqrdrone.soundent.angles = carryqrdrone.angles;
    carryqrdrone.soundent.origin = carryqrdrone.origin;
    carryqrdrone.soundent linkto( carryqrdrone );
    carryqrdrone.soundent playloopsound( "recondrone_idle_high" );
    return carryqrdrone;
}

// Namespace qrdrone
// Params 0
// Checksum 0x65f567b0, Offset: 0x1600
// Size: 0x66
function watchforattack()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"place_carryqrdrone" );
    self endon( #"cancel_carryqrdrone" );
    
    for ( ;; )
    {
        wait 0.05;
        
        if ( self attackbuttonpressed() )
        {
            self notify( #"place_carryqrdrone" );
        }
    }
}

// Namespace qrdrone
// Params 1
// Checksum 0x7678615d, Offset: 0x1670
// Size: 0x114
function setcarryingqrdrone( carryqrdrone )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    carryqrdrone thread carryqrdrone_setcarried( self );
    
    if ( !carryqrdrone.canbeplaced )
    {
        if ( self.team != "spectator" )
        {
            self iprintlnbold( &"KILLSTREAK_QRDRONE_NOT_PLACEABLE" );
        }
        
        if ( isdefined( carryqrdrone.soundent ) )
        {
            carryqrdrone.soundent delete();
        }
        
        carryqrdrone delete();
        return;
    }
    
    self.iscarrying = 0;
    carryqrdrone.carriedby = undefined;
    carryqrdrone playsound( "sentry_gun_plant" );
    carryqrdrone notify( #"placed" );
}

// Namespace qrdrone
// Params 1
// Checksum 0xa7b6adfc, Offset: 0x1790
// Size: 0x82
function carryqrdrone_setcarried( carrier )
{
    self setcandamage( 0 );
    self setcontents( 0 );
    self.carriedby = carrier;
    carrier.iscarrying = 1;
    carrier thread updatecarryqrdroneplacement( self );
    self notify( #"carried" );
}

// Namespace qrdrone
// Params 0
// Checksum 0x8e471a6d, Offset: 0x1820
// Size: 0xac, Type: bool
function isinremotenodeploy()
{
    if ( isdefined( level.qrdrone_nodeployzones ) && level.qrdrone_nodeployzones.size )
    {
        foreach ( zone in level.qrdrone_nodeployzones )
        {
            if ( self istouching( zone ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace qrdrone
// Params 1
// Checksum 0x4d2bc25b, Offset: 0x18d8
// Size: 0x244
function updatecarryqrdroneplacement( carryqrdrone )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    carryqrdrone endon( #"placed" );
    carryqrdrone endon( #"death" );
    carryqrdrone.canbeplaced = 1;
    lastcanplacecarryqrdrone = -1;
    
    for ( ;; )
    {
        heightoffset = 18;
        
        switch ( self getstance() )
        {
            default:
                heightoffset = 40;
                break;
            case "crouch":
                heightoffset = 25;
                break;
            case "prone":
                heightoffset = 10;
                break;
        }
        
        placement = self canplayerplacevehicle( 22, 22, 50, heightoffset, 0, 0 );
        carryqrdrone.origin = placement[ "origin" ] + anglestoup( self.angles ) * 27;
        carryqrdrone.angles = placement[ "angles" ];
        carryqrdrone.canbeplaced = self isonground() && placement[ "result" ] && carryqrdrone qrdrone_in_range() && !carryqrdrone isinremotenodeploy();
        
        if ( carryqrdrone.canbeplaced != lastcanplacecarryqrdrone )
        {
            if ( carryqrdrone.canbeplaced )
            {
                if ( self attackbuttonpressed() )
                {
                    self notify( #"place_carryqrdrone" );
                }
            }
        }
        
        lastcanplacecarryqrdrone = carryqrdrone.canbeplaced;
        wait 0.05;
    }
}

// Namespace qrdrone
// Params 0
// Checksum 0x85487923, Offset: 0x1b28
// Size: 0x94
function carryqrdrone_handleexistence()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.owner endon( #"place_carryqrdrone" );
    self.owner endon( #"cancel_carryqrdrone" );
    self.owner util::waittill_any( "death", "disconnect", "joined_team", "joined_spectators" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace qrdrone
// Params 0
// Checksum 0x37f32605, Offset: 0x1bc8
// Size: 0x24
function removeremoteweapon()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    wait 0.7;
}

// Namespace qrdrone
// Params 4
// Checksum 0xc32c7092, Offset: 0x1bf8
// Size: 0x2d0
function startqrdrone( lifeid, streakname, origin, angles )
{
    self lockplayerforqrdronelaunch();
    self util::setusingremote( streakname );
    self util::freeze_player_controls( 1 );
    result = self killstreaks::init_ride_killstreak( "qrdrone" );
    
    if ( result != "success" || level.gameended )
    {
        if ( result != "disconnect" )
        {
            self util::freeze_player_controls( 0 );
            self killstreakrules::iskillstreakallowed( "qrdrone", self.team );
            self notify( #"qrdrone_unlock" );
            self killstreaks::clear_using_remote();
        }
        
        return 0;
    }
    
    team = self.team;
    killstreak_id = self killstreakrules::killstreakstart( "qrdrone", team, 0, 1 );
    
    if ( killstreak_id == -1 )
    {
        self notify( #"qrdrone_unlock" );
        self util::freeze_player_controls( 0 );
        self killstreaks::clear_using_remote();
        return 0;
    }
    
    self notify( #"qrdrone_unlock" );
    qrdrone = createqrdrone( lifeid, self, streakname, origin, angles, killstreak_id );
    self util::freeze_player_controls( 0 );
    
    if ( isdefined( qrdrone ) )
    {
        self thread qrdrone_ride( lifeid, qrdrone, streakname );
        qrdrone waittill( #"end_remote" );
        killstreakrules::killstreakstop( "qrdrone", team, killstreak_id );
        return 1;
    }
    
    self iprintlnbold( &"MP_TOO_MANY_VEHICLES" );
    self killstreaks::clear_using_remote();
    killstreakrules::killstreakstop( "qrdrone", team, killstreak_id );
    return 0;
}

// Namespace qrdrone
// Params 0
// Checksum 0xbf35cecf, Offset: 0x1ed0
// Size: 0x74
function lockplayerforqrdronelaunch()
{
    lockspot = spawn( "script_origin", self.origin );
    lockspot hide();
    self playerlinkto( lockspot );
    self thread clearplayerlockfromqrdronelaunch( lockspot );
}

// Namespace qrdrone
// Params 1
// Checksum 0x73f4b08a, Offset: 0x1f50
// Size: 0x64
function clearplayerlockfromqrdronelaunch( lockspot )
{
    level endon( #"game_ended" );
    msg = self util::waittill_any_return( "disconnect", "death", "qrdrone_unlock" );
    lockspot delete();
}

// Namespace qrdrone
// Params 6
// Checksum 0x1b6108c6, Offset: 0x1fc0
// Size: 0x470
function createqrdrone( lifeid, owner, streakname, origin, angles, killstreak_id )
{
    qrdrone = spawnhelicopter( owner, origin, angles, level.qrdrone_vehicle, "veh_t6_drone_quad_rotor_mp" );
    
    if ( !isdefined( qrdrone ) )
    {
        return undefined;
    }
    
    qrdrone.lifeid = lifeid;
    qrdrone.team = owner.team;
    qrdrone.pers[ "team" ] = owner.team;
    qrdrone.owner = owner;
    qrdrone clientfield::set( "enemyvehicle", 1 );
    qrdrone.health = 999999;
    qrdrone.maxhealth = 250;
    qrdrone.damagetaken = 0;
    qrdrone.destroyed = 0;
    qrdrone setcandamage( 1 );
    qrdrone enableaimassist();
    qrdrone.smoking = 0;
    qrdrone.inheliproximity = 0;
    qrdrone.helitype = "qrdrone";
    qrdrone.markedplayers = [];
    qrdrone.isstunned = 0;
    qrdrone setenemymodel( "veh_t6_drone_quad_rotor_mp_alt" );
    qrdrone setdrawinfrared( 1 );
    qrdrone.killcament = qrdrone.owner;
    owner weaponobjects::addweaponobjecttowatcher( "qrdrone", qrdrone );
    qrdrone thread qrdrone_explode_on_notify( killstreak_id );
    qrdrone thread qrdrone_explode_on_game_end();
    qrdrone thread qrdrone_leave_on_timeout( streakname );
    qrdrone thread qrdrone_watch_distance();
    qrdrone thread qrdrone_watch_for_exit();
    qrdrone thread deleteonkillbrush( owner );
    target_set( qrdrone, ( 0, 0, 0 ) );
    target_setturretaquire( qrdrone, 0 );
    qrdrone.numflares = 0;
    qrdrone.flareoffset = ( 0, 0, -100 );
    qrdrone thread heatseekingmissile::missiletarget_lockonmonitor( self, "end_remote" );
    qrdrone thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile( "crashing" );
    qrdrone.emp_fx = spawn( "script_model", self.origin );
    qrdrone.emp_fx setmodel( "tag_origin" );
    qrdrone.emp_fx linkto( self, "tag_origin", ( 0, 0, -20 ) + anglestoforward( self.angles ) * 6 );
    qrdrone spawning::create_entity_enemy_influencer( "small_vehicle", qrdrone.team );
    qrdrone spawning::create_entity_enemy_influencer( "qrdrone_cylinder", qrdrone.team );
    return qrdrone;
}

// Namespace qrdrone
// Params 3
// Checksum 0x29023f66, Offset: 0x2438
// Size: 0x164
function qrdrone_ride( lifeid, qrdrone, streakname )
{
    qrdrone.playerlinked = 1;
    self.restoreangles = self.angles;
    qrdrone usevehicle( self, 0 );
    self util::clientnotify( "qrfutz" );
    self killstreaks::play_killstreak_start_dialog( "qrdrone", self.pers[ "team" ] );
    self addweaponstat( getweapon( "killstreak_qrdrone" ), "used", 1 );
    self.qrdrone_ridelifeid = lifeid;
    self.qrdrone = qrdrone;
    self thread qrdrone_delaylaunchdialog( qrdrone );
    self thread qrdrone_fireguns( qrdrone );
    qrdrone thread play_lockon_sounds( self );
    
    if ( isdefined( level.qrdrone_vision ) )
    {
        self setvisionsetwaiter();
    }
}

// Namespace qrdrone
// Params 1
// Checksum 0x19d8cf8, Offset: 0x25a8
// Size: 0x6c
function qrdrone_delaylaunchdialog( qrdrone )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    qrdrone endon( #"death" );
    qrdrone endon( #"end_remote" );
    qrdrone endon( #"end_launch_dialog" );
    wait 3;
    self qrdrone_dialog( "launch" );
}

// Namespace qrdrone
// Params 1
// Checksum 0x98e43d48, Offset: 0x2620
// Size: 0x8c
function qrdrone_unlink( qrdrone )
{
    if ( isdefined( qrdrone ) )
    {
        qrdrone.playerlinked = 0;
        self destroyhud();
        
        if ( isdefined( self.viewlockedentity ) )
        {
            self unlink();
            
            if ( isdefined( level.gameended ) && level.gameended )
            {
                self util::freeze_player_controls( 1 );
            }
        }
    }
}

// Namespace qrdrone
// Params 1
// Checksum 0x5809d98f, Offset: 0x26b8
// Size: 0xae
function qrdrone_endride( qrdrone )
{
    if ( isdefined( qrdrone ) )
    {
        qrdrone notify( #"end_remote" );
        self killstreaks::clear_using_remote();
        self setplayerangles( self.restoreangles );
        
        if ( isalive( self ) )
        {
            self killstreaks::switch_to_last_non_killstreak_weapon();
        }
        
        self thread qrdrone_freezebuffer();
    }
    
    self.qrdrone = undefined;
}

// Namespace qrdrone
// Params 1
// Checksum 0x163f68f4, Offset: 0x2770
// Size: 0x198
function play_lockon_sounds( player )
{
    player endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"blowup" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    self endon( #"end_remote" );
    self.locksounds = spawn( "script_model", self.origin );
    wait 0.1;
    self.locksounds linkto( self, "tag_player" );
    
    while ( true )
    {
        self waittill( #"locking on" );
        
        while ( true )
        {
            if ( enemy_locking() )
            {
                self.locksounds playsoundtoplayer( "uin_alert_lockon", player );
                wait 0.125;
            }
            
            if ( enemy_locked() )
            {
                self.locksounds playsoundtoplayer( "uin_alert_lockon", player );
                wait 0.125;
            }
            
            if ( !enemy_locking() && !enemy_locked() )
            {
                self.locksounds stopsounds();
                break;
            }
        }
    }
}

// Namespace qrdrone
// Params 0
// Checksum 0x8e4c112b, Offset: 0x2910
// Size: 0x22, Type: bool
function enemy_locking()
{
    if ( isdefined( self.locking_on ) && self.locking_on )
    {
        return true;
    }
    
    return false;
}

// Namespace qrdrone
// Params 0
// Checksum 0xed47be0f, Offset: 0x2940
// Size: 0x22, Type: bool
function enemy_locked()
{
    if ( isdefined( self.locked_on ) && self.locked_on )
    {
        return true;
    }
    
    return false;
}

// Namespace qrdrone
// Params 0
// Checksum 0xe571c9b, Offset: 0x2970
// Size: 0x5c
function qrdrone_freezebuffer()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    level endon( #"game_ended" );
    self util::freeze_player_controls( 1 );
    wait 0.5;
    self util::freeze_player_controls( 0 );
}

// Namespace qrdrone
// Params 1
// Checksum 0xef030f02, Offset: 0x29d8
// Size: 0xc8
function qrdrone_playerexit( qrdrone )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    qrdrone endon( #"death" );
    qrdrone endon( #"end_remote" );
    wait 2;
    
    while ( true )
    {
        timeused = 0;
        
        while ( self usebuttonpressed() )
        {
            timeused += 0.05;
            
            if ( timeused > 0.75 )
            {
                qrdrone thread qrdrone_leave();
                return;
            }
            
            wait 0.05;
        }
        
        wait 0.05;
    }
}

// Namespace qrdrone
// Params 0
// Checksum 0x24b0ae5b, Offset: 0x2aa8
// Size: 0x7c
function touchedkillbrush()
{
    if ( isdefined( self ) )
    {
        self clientfield::set( "qrdrone_state", 3 );
        watcher = self.owner weaponobjects::getweaponobjectwatcher( "qrdrone" );
        watcher thread weaponobjects::waitanddetonate( self, 0 );
    }
}

// Namespace qrdrone
// Params 1
// Checksum 0xca949fab, Offset: 0x2b30
// Size: 0x3c4
function deleteonkillbrush( player )
{
    player endon( #"disconnect" );
    self endon( #"death" );
    killbrushes = [];
    hurt = getentarray( "trigger_hurt", "classname" );
    
    foreach ( trig in hurt )
    {
        if ( !isdefined( trig.script_parameters ) || trig.origin[ 2 ] <= player.origin[ 2 ] && trig.script_parameters != "qrdrone_safe" )
        {
            killbrushes[ killbrushes.size ] = trig;
        }
    }
    
    crate_triggers = getentarray( "crate_kill_trigger", "targetname" );
    
    while ( true )
    {
        for ( i = 0; i < killbrushes.size ; i++ )
        {
            if ( self istouching( killbrushes[ i ] ) )
            {
                self touchedkillbrush();
                return;
            }
        }
        
        foreach ( trigger in crate_triggers )
        {
            if ( trigger.active && self istouching( trigger ) )
            {
                self touchedkillbrush();
                return;
            }
        }
        
        if ( isdefined( level.levelkillbrushes ) )
        {
            foreach ( trigger in level.levelkillbrushes )
            {
                if ( self istouching( trigger ) )
                {
                    self touchedkillbrush();
                    return;
                }
            }
        }
        
        if ( level.script == "mp_castaway" )
        {
            origin = self.origin - ( 0, 0, 12 );
            water = getwaterheight( origin );
            
            if ( water - origin[ 2 ] > 0 )
            {
                self touchedkillbrush();
                return;
            }
        }
        
        wait 0.1;
    }
}

// Namespace qrdrone
// Params 0
// Checksum 0xa72ac0ae, Offset: 0x2f00
// Size: 0x74
function qrdrone_force_destroy()
{
    self clientfield::set( "qrdrone_state", 3 );
    watcher = self.owner weaponobjects::getweaponobjectwatcher( "qrdrone" );
    watcher thread weaponobjects::waitanddetonate( self, 0 );
}

// Namespace qrdrone
// Params 1
// Checksum 0x11a68c4f, Offset: 0x2f80
// Size: 0x30
function qrdrone_get_damage_effect( health_pct )
{
    if ( health_pct > 0.5 )
    {
        return level._effect[ "quadrotor_damage" ];
    }
    
    return undefined;
}

// Namespace qrdrone
// Params 2
// Checksum 0x63e0e7e2, Offset: 0x2fb8
// Size: 0x74
function qrdrone_play_single_fx_on_tag( effect, tag )
{
    if ( isdefined( self.damage_fx_ent ) )
    {
        if ( self.damage_fx_ent.effect == effect )
        {
            return;
        }
        
        self.damage_fx_ent delete();
    }
    
    playfxontag( effect, self, "tag_origin" );
}

// Namespace qrdrone
// Params 1
// Checksum 0x80fcd794, Offset: 0x3038
// Size: 0x7c
function qrdrone_update_damage_fx( health_percent )
{
    effect = qrdrone_get_damage_effect( health_percent );
    
    if ( isdefined( effect ) )
    {
        qrdrone_play_single_fx_on_tag( effect, "tag_origin" );
        return;
    }
    
    if ( isdefined( self.damage_fx_ent ) )
    {
        self.damage_fx_ent delete();
    }
}

// Namespace qrdrone
// Params 0
// Checksum 0xda572e3e, Offset: 0x30c0
// Size: 0x388
function qrdrone_damagewatcher()
{
    self endon( #"death" );
    self.maxhealth = 999999;
    self.health = self.maxhealth;
    self.maxhealth = 225;
    low_health = 0;
    damage_taken = 0;
    
    for ( ;; )
    {
        self waittill( #"damage", damage, attacker, dir, point, mod, model, tag, part, weapon, flags );
        
        if ( !isdefined( attacker ) || !isplayer( attacker ) )
        {
            continue;
        }
        
        self.owner playrumbleonentity( "damage_heavy" );
        
        /#
            self.damage_debug = damage + "<dev string:x3b>" + weapon.name + "<dev string:x3e>";
        #/
        
        if ( mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET" )
        {
            if ( isplayer( attacker ) )
            {
                if ( attacker hasperk( "specialty_armorpiercing" ) )
                {
                    damage += int( damage * level.cac_armorpiercing_data );
                }
            }
            
            if ( weapon.weapclass == "spread" )
            {
                damage *= 2;
            }
        }
        
        if ( weapon.isemp && mod == "MOD_GRENADE_SPLASH" )
        {
            damage_taken += 225;
            damage = 0;
        }
        
        if ( !self.isstunned )
        {
            if ( mod == "MOD_GRENADE_SPLASH" || weapon.isstun && mod == "MOD_GAS" )
            {
                self.isstunned = 1;
                self qrdrone_stun( 2 );
            }
        }
        
        self.attacker = attacker;
        self.owner sendkillstreakdamageevent( int( damage ) );
        damage_taken += damage;
        
        if ( damage_taken >= 225 )
        {
            self.owner sendkillstreakdamageevent( 200 );
            self qrdrone_death( attacker, weapon, dir, mod );
            return;
        }
        
        qrdrone_update_damage_fx( float( damage_taken ) / 225 );
    }
}

// Namespace qrdrone
// Params 1
// Checksum 0x20cd5494, Offset: 0x3450
// Size: 0x98
function qrdrone_stun( duration )
{
    self endon( #"death" );
    self notify( #"stunned" );
    self.owner util::freeze_player_controls( 1 );
    
    if ( isdefined( self.owner.fullscreen_static ) )
    {
        self.owner thread remote_weapons::stunstaticfx( duration );
    }
    
    wait duration;
    self.owner util::freeze_player_controls( 0 );
    self.isstunned = 0;
}

// Namespace qrdrone
// Params 4
// Checksum 0xeb769ee2, Offset: 0x34f0
// Size: 0x254
function qrdrone_death( attacker, weapon, dir, damagetype )
{
    if ( isdefined( self.damage_fx_ent ) )
    {
        self.damage_fx_ent delete();
    }
    
    if ( isdefined( attacker ) && isplayer( attacker ) && attacker != self.owner )
    {
        level thread popups::displayteammessagetoall( &"SCORE_DESTROYED_QRDRONE", attacker );
        
        if ( self.owner util::isenemyplayer( attacker ) )
        {
            attacker challenges::destroyedqrdrone( damagetype, weapon );
            attacker addweaponstat( weapon, "destroyed_qrdrone", 1 );
            attacker challenges::addflyswatterstat( weapon, self );
            attacker addweaponstat( weapon, "destroyed_controlled_killstreak", 1 );
        }
    }
    
    self thread qrdrone_crash_movement( attacker, dir );
    
    if ( weapon.isemp )
    {
        playfxontag( level.ai_tank_stun_fx, self.emp_fx, "tag_origin" );
    }
    
    self waittill( #"crash_done" );
    
    if ( isdefined( self.emp_fx ) )
    {
        self.emp_fx delete();
    }
    
    self clientfield::set( "qrdrone_state", 3 );
    watcher = self.owner weaponobjects::getweaponobjectwatcher( "qrdrone" );
    watcher thread weaponobjects::waitanddetonate( self, 0, attacker, weapon );
}

// Namespace qrdrone
// Params 0
// Checksum 0x6e234c54, Offset: 0x3750
// Size: 0x44
function death_fx()
{
    playfxontag( self.deathfx, self, self.deathfxtag );
    self playsound( "veh_qrdrone_sparks" );
}

// Namespace qrdrone
// Params 2
// Checksum 0xa0ac9b21, Offset: 0x37a0
// Size: 0x37e
function qrdrone_crash_movement( attacker, hitdir )
{
    self endon( #"crash_done" );
    self endon( #"death" );
    self notify( #"crashing" );
    self takeplayercontrol();
    self setmaxpitchroll( 90, 180 );
    self setphysacceleration( ( 0, 0, -800 ) );
    side_dir = vectorcross( hitdir, ( 0, 0, 1 ) );
    side_dir_mag = randomfloatrange( -100, 100 );
    side_dir_mag += math::sign( side_dir_mag ) * 80;
    side_dir *= side_dir_mag;
    velocity = self getvelocity();
    self setvehvelocity( velocity + ( 0, 0, 100 ) + vectornormalize( side_dir ) );
    ang_vel = self getangularvelocity();
    ang_vel = ( ang_vel[ 0 ] * 0.3, ang_vel[ 1 ], ang_vel[ 2 ] * 0.3 );
    yaw_vel = randomfloatrange( 0, 210 ) * math::sign( ang_vel[ 1 ] );
    yaw_vel += math::sign( yaw_vel ) * 180;
    ang_vel += ( randomfloatrange( -100, 100 ), yaw_vel, randomfloatrange( -200, 200 ) );
    self setangularvelocity( ang_vel );
    self.crash_accel = randomfloatrange( 75, 110 );
    self thread qrdrone_crash_accel();
    self thread qrdrone_collision();
    self playsound( "veh_qrdrone_dmg_hit" );
    self thread qrdrone_dmg_snd();
    wait 0.1;
    
    if ( randomint( 100 ) < 40 )
    {
        self thread qrdrone_fire_for_time( randomfloatrange( 0.7, 2 ) );
    }
    
    wait 2;
    self notify( #"crash_done" );
}

// Namespace qrdrone
// Params 0
// Checksum 0xc3983f9c, Offset: 0x3b28
// Size: 0xd4
function qrdrone_dmg_snd()
{
    dmg_ent = spawn( "script_origin", self.origin );
    dmg_ent linkto( self );
    dmg_ent playloopsound( "veh_qrdrone_dmg_loop" );
    self util::waittill_any( "crash_done", "death" );
    dmg_ent stoploopsound( 0.2 );
    wait 2;
    dmg_ent delete();
}

// Namespace qrdrone
// Params 1
// Checksum 0xe8bce08c, Offset: 0x3c08
// Size: 0xd4
function qrdrone_fire_for_time( totalfiretime )
{
    self endon( #"crash_done" );
    self endon( #"change_state" );
    self endon( #"death" );
    weapon = self seatgetweapon( 0 );
    firetime = weapon.firetime;
    time = 0;
    firecount = 1;
    
    while ( time < totalfiretime )
    {
        self fireweapon();
        firecount++;
        wait firetime;
        time += firetime;
    }
}

// Namespace qrdrone
// Params 0
// Checksum 0xe664c927, Offset: 0x3ce8
// Size: 0x1d8
function qrdrone_crash_accel()
{
    self endon( #"crash_done" );
    self endon( #"death" );
    count = 0;
    
    while ( true )
    {
        velocity = self getvelocity();
        self setvehvelocity( velocity + anglestoup( self.angles ) * self.crash_accel );
        self.crash_accel *= 0.98;
        wait 0.1;
        count++;
        
        if ( count % 8 == 0 )
        {
            if ( randomint( 100 ) > 40 )
            {
                if ( velocity[ 2 ] > 150 )
                {
                    self.crash_accel *= 0.75;
                    continue;
                }
                
                if ( velocity[ 2 ] < 40 && count < 60 )
                {
                    if ( abs( self.angles[ 0 ] ) > 30 || abs( self.angles[ 2 ] ) > 30 )
                    {
                        self.crash_accel = randomfloatrange( 160, 200 );
                        continue;
                    }
                    
                    self.crash_accel = randomfloatrange( 85, 120 );
                }
            }
        }
    }
}

// Namespace qrdrone
// Params 0
// Checksum 0x7e11ea8b, Offset: 0x3ec8
// Size: 0x166
function qrdrone_collision()
{
    self endon( #"crash_done" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"veh_collision", velocity, normal );
        ang_vel = self getangularvelocity() * 0.5;
        self setangularvelocity( ang_vel );
        velocity = self getvelocity();
        
        if ( normal[ 2 ] < 0.7 )
        {
            self setvehvelocity( velocity + normal * 70 );
            self playsound( "veh_qrdrone_wall" );
            playfx( level._effect[ "quadrotor_nudge" ], self.origin );
            continue;
        }
        
        self playsound( "veh_qrdrone_explo" );
        self notify( #"crash_done" );
    }
}

// Namespace qrdrone
// Params 2
// Checksum 0x8023e1f0, Offset: 0x4038
// Size: 0x33c
function qrdrone_watch_distance( zoffset, minheightoverride )
{
    self endon( #"death" );
    self.owner inithud();
    self clientfield::set( "qrdrone_out_of_range", 1 );
    wait 0.05;
    self clientfield::set( "qrdrone_out_of_range", 0 );
    qrdrone_height = struct::get( "qrdrone_height", "targetname" );
    
    if ( isdefined( qrdrone_height ) )
    {
        self.maxheight = qrdrone_height.origin[ 2 ];
    }
    else
    {
        self.maxheight = int( airsupport::getminimumflyheight() );
    }
    
    if ( isdefined( zoffset ) )
    {
        self.maxheight += zoffset;
    }
    
    self.maxdistance = 12800;
    self.minheight = level.mapcenter[ 2 ] - 800;
    
    if ( isdefined( minheightoverride ) )
    {
        self.minheight = minheightoverride;
    }
    
    self.centerref = spawn( "script_model", level.mapcenter );
    inrangepos = self.origin;
    self.rangecountdownactive = 0;
    
    while ( true )
    {
        if ( !self qrdrone_in_range() )
        {
            staticalpha = 0;
            
            while ( !self qrdrone_in_range() )
            {
                if ( !self.rangecountdownactive )
                {
                    self.rangecountdownactive = 1;
                    self thread qrdrone_rangecountdown();
                }
                
                if ( isdefined( self.heliinproximity ) )
                {
                    dist = distance( self.origin, self.heliinproximity.origin );
                    staticalpha = 1 - ( dist - 150 ) / 150;
                }
                else
                {
                    dist = distance( self.origin, inrangepos );
                    staticalpha = min( 0.7, dist / 200 );
                }
                
                self.owner set_static_alpha( staticalpha, self );
                wait 0.05;
            }
            
            self notify( #"in_range" );
            self.rangecountdownactive = 0;
            self thread qrdrone_staticfade( staticalpha );
        }
        
        inrangepos = self.origin;
        wait 0.05;
    }
}

// Namespace qrdrone
// Params 0
// Checksum 0x870d0121, Offset: 0x4380
// Size: 0x5e, Type: bool
function qrdrone_in_range()
{
    if ( self.origin[ 2 ] < self.maxheight && self.origin[ 2 ] > self.minheight && !self.inheliproximity )
    {
        if ( self ismissileinsideheightlock() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace qrdrone
// Params 1
// Checksum 0xf9a0caed, Offset: 0x43e8
// Size: 0x98
function qrdrone_staticfade( staticalpha )
{
    self endon( #"death" );
    
    while ( self qrdrone_in_range() )
    {
        staticalpha -= 0.05;
        
        if ( staticalpha < 0 )
        {
            self.owner set_static_alpha( staticalpha, self );
            break;
        }
        
        self.owner set_static_alpha( staticalpha, self );
        wait 0.05;
    }
}

// Namespace qrdrone
// Params 0
// Checksum 0x458c2997, Offset: 0x4488
// Size: 0xfc
function qrdrone_rangecountdown()
{
    self endon( #"death" );
    self endon( #"in_range" );
    
    if ( isdefined( self.heliinproximity ) )
    {
        countdown = 6.1;
    }
    else
    {
        countdown = 6.1;
    }
    
    hostmigration::waitlongdurationwithhostmigrationpause( countdown );
    self.owner notify( #"stop_signal_failure" );
    
    if ( isdefined( self.distance_shutdown_override ) )
    {
        return [[ self.distance_shutdown_override ]]();
    }
    
    self clientfield::set( "qrdrone_state", 3 );
    watcher = self.owner weaponobjects::getweaponobjectwatcher( "qrdrone" );
    watcher thread weaponobjects::waitanddetonate( self, 0 );
}

// Namespace qrdrone
// Params 1
// Checksum 0x172e4588, Offset: 0x4590
// Size: 0x13c
function qrdrone_explode_on_notify( killstreak_id )
{
    self endon( #"death" );
    self endon( #"end_ride" );
    self.owner util::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner killstreaks::clear_using_remote();
        self.owner destroyhud();
        self.owner qrdrone_endride( self );
    }
    else
    {
        killstreakrules::killstreakstop( "qrdrone", self.team, killstreak_id );
    }
    
    self clientfield::set( "qrdrone_state", 3 );
    watcher = self.owner weaponobjects::getweaponobjectwatcher( "qrdrone" );
    watcher thread weaponobjects::waitanddetonate( self, 0 );
}

// Namespace qrdrone
// Params 0
// Checksum 0x386145ea, Offset: 0x46d8
// Size: 0x9c
function qrdrone_explode_on_game_end()
{
    self endon( #"death" );
    level waittill( #"game_ended" );
    self clientfield::set( "qrdrone_state", 3 );
    watcher = self.owner weaponobjects::getweaponobjectwatcher( "qrdrone" );
    watcher weaponobjects::waitanddetonate( self, 0 );
    self.owner qrdrone_endride( self );
}

// Namespace qrdrone
// Params 1
// Checksum 0xcbee7c55, Offset: 0x4780
// Size: 0x17c
function qrdrone_leave_on_timeout( killstreakname )
{
    qrdrone = self;
    qrdrone endon( #"death" );
    
    if ( !level.vehiclestimed )
    {
        return;
    }
    
    qrdrone.flytime = 60;
    waittime = self.flytime - 10;
    
    /#
        util::set_dvar_int_if_unset( "<dev string:x28>", qrdrone.flytime );
        qrdrone.flytime = getdvarint( "<dev string:x28>" );
        waittime = self.flytime - 10;
        
        if ( waittime < 0 )
        {
            wait qrdrone.flytime;
            self clientfield::set( "<dev string:x40>", 3 );
            watcher = qrdrone.owner weaponobjects::getweaponobjectwatcher( "<dev string:x4e>" );
            watcher thread weaponobjects::waitanddetonate( qrdrone, 0 );
            return;
        }
    #/
    
    qrdrone thread killstreaks::waitfortimeout( killstreakname, waittime, &qrdrone_leave_on_timeout_callback, "death" );
}

// Namespace qrdrone
// Params 0
// Checksum 0xe840cfb5, Offset: 0x4908
// Size: 0x12c
function qrdrone_leave_on_timeout_callback()
{
    qrdrone = self;
    qrdrone clientfield::set( "qrdrone_state", 1 );
    qrdrone clientfield::set( "qrdrone_countdown", 1 );
    hostmigration::waitlongdurationwithhostmigrationpause( 6 );
    qrdrone clientfield::set( "qrdrone_state", 2 );
    qrdrone clientfield::set( "qrdrone_timeout", 1 );
    hostmigration::waitlongdurationwithhostmigrationpause( 4 );
    qrdrone clientfield::set( "qrdrone_state", 3 );
    watcher = self.owner weaponobjects::getweaponobjectwatcher( "qrdrone" );
    watcher thread weaponobjects::waitanddetonate( self, 0 );
}

// Namespace qrdrone
// Params 0
// Checksum 0xc982bd4a, Offset: 0x4a40
// Size: 0x6a
function qrdrone_leave()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self notify( #"leaving" );
    self.owner qrdrone_unlink( self );
    self.owner qrdrone_endride( self );
    self notify( #"death" );
}

// Namespace qrdrone
// Params 0
// Checksum 0xf228e6f5, Offset: 0x4ab8
// Size: 0x1a
function qrdrone_exit_button_pressed()
{
    return self usebuttonpressed();
}

// Namespace qrdrone
// Params 0
// Checksum 0x289a586a, Offset: 0x4ae0
// Size: 0x120
function qrdrone_watch_for_exit()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    wait 1;
    
    while ( true )
    {
        timeused = 0;
        
        while ( self.owner qrdrone_exit_button_pressed() )
        {
            timeused += 0.05;
            
            if ( timeused > 0.25 )
            {
                self clientfield::set( "qrdrone_state", 3 );
                watcher = self.owner weaponobjects::getweaponobjectwatcher( "qrdrone" );
                watcher thread weaponobjects::waitanddetonate( self, 0, self.owner );
                return;
            }
            
            wait 0.05;
        }
        
        wait 0.05;
    }
}

// Namespace qrdrone
// Params 0
// Checksum 0x986fefc9, Offset: 0x4c08
// Size: 0x134
function qrdrone_cleanup()
{
    if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( self.owner ) )
    {
        if ( self.playerlinked == 1 )
        {
            self.owner qrdrone_unlink( self );
        }
        
        self.owner qrdrone_endride( self );
    }
    
    if ( isdefined( self.scrambler ) )
    {
        self.scrambler delete();
    }
    
    if ( isdefined( self ) && isdefined( self.centerref ) )
    {
        self.centerref delete();
    }
    
    target_setturretaquire( self, 0 );
    
    if ( isdefined( self.damage_fx_ent ) )
    {
        self.damage_fx_ent delete();
    }
    
    if ( isdefined( self.emp_fx ) )
    {
        self.emp_fx delete();
    }
    
    self delete();
}

// Namespace qrdrone
// Params 0
// Checksum 0x8afd3953, Offset: 0x4d48
// Size: 0x7c
function qrdrone_light_fx()
{
    playfxontag( level.chopper_fx[ "light" ][ "belly" ], self, "tag_light_nose" );
    wait 0.05;
    playfxontag( level.chopper_fx[ "light" ][ "tail" ], self, "tag_light_tail1" );
}

// Namespace qrdrone
// Params 1
// Checksum 0x5dd986a1, Offset: 0x4dd0
// Size: 0xcc
function qrdrone_dialog( dialoggroup )
{
    if ( dialoggroup == "tag" )
    {
        waittime = 1000;
    }
    else
    {
        waittime = 5000;
    }
    
    if ( gettime() - level.qrdrone_lastdialogtime < waittime )
    {
        return;
    }
    
    level.qrdrone_lastdialogtime = gettime();
    randomindex = randomint( level.qrdrone_dialog[ dialoggroup ].size );
    soundalias = level.qrdrone_dialog[ dialoggroup ][ randomindex ];
    self playlocalsound( soundalias );
}

// Namespace qrdrone
// Params 0
// Checksum 0x11784270, Offset: 0x4ea8
// Size: 0x9c
function qrdrone_watchheliproximity()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"end_remote" );
    
    while ( true )
    {
        inheliproximity = 0;
        
        if ( !self.inheliproximity && inheliproximity )
        {
            self.inheliproximity = 1;
        }
        else if ( self.inheliproximity && !inheliproximity )
        {
            self.inheliproximity = 0;
            self.heliinproximity = undefined;
        }
        
        wait 0.05;
    }
}

// Namespace qrdrone
// Params 0
// Checksum 0x2813b834, Offset: 0x4f50
// Size: 0x14c
function qrdrone_detonatewaiter()
{
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    
    while ( self.owner attackbuttonpressed() )
    {
        wait 0.05;
    }
    
    watcher = self.owner weaponobjects::getweaponobjectwatcher( "qrdrone" );
    
    while ( !self.owner attackbuttonpressed() )
    {
        wait 0.05;
    }
    
    self clientfield::set( "qrdrone_state", 3 );
    watcher thread weaponobjects::waitanddetonate( self, 0 );
    self.owner thread hud::fade_to_black_for_x_sec( getdvarfloat( "scr_rcbomb_fadeOut_delay" ), getdvarfloat( "scr_rcbomb_fadeOut_timeIn" ), getdvarfloat( "scr_rcbomb_fadeOut_timeBlack" ), getdvarfloat( "scr_rcbomb_fadeOut_timeOut" ) );
}

// Namespace qrdrone
// Params 1
// Checksum 0x28dbbce2, Offset: 0x50a8
// Size: 0xe4
function qrdrone_fireguns( qrdrone )
{
    self endon( #"disconnect" );
    qrdrone endon( #"death" );
    qrdrone endon( #"blowup" );
    qrdrone endon( #"crashing" );
    level endon( #"game_ended" );
    qrdrone endon( #"end_remote" );
    wait 1;
    
    while ( true )
    {
        if ( self attackbuttonpressed() )
        {
            qrdrone fireweapon();
            weapon = getweapon( "qrdrone_turret" );
            firetime = weapon.firetime;
            wait firetime;
            continue;
        }
        
        wait 0.05;
    }
}

// Namespace qrdrone
// Params 2
// Checksum 0x700baf71, Offset: 0x5198
// Size: 0x324
function qrdrone_blowup( attacker, weapon )
{
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    self notify( #"blowup" );
    explosionorigin = self.origin;
    explosionangles = self.angles;
    
    if ( !isdefined( attacker ) )
    {
        attacker = self.owner;
    }
    
    origin = self.origin + ( 0, 0, 10 );
    radius = 256;
    min_damage = 10;
    max_damage = 35;
    
    if ( isdefined( attacker ) )
    {
        self radiusdamage( origin, radius, max_damage, min_damage, attacker, "MOD_EXPLOSIVE", self.weapon );
    }
    
    physicsexplosionsphere( origin, radius, radius, 1, max_damage, min_damage );
    shellshock::rcbomb_earthquake( origin );
    playsoundatposition( "veh_qrdrone_explo", self.origin );
    playfx( level.qrdrone_fx[ "explode" ], explosionorigin, ( 0, 0, 1 ) );
    self hide();
    
    if ( isdefined( self.owner ) )
    {
        self.owner util::clientnotify( "qrdrone_blowup" );
        
        if ( attacker != self.owner )
        {
            level.globalkillstreaksdestroyed++;
            attacker addweaponstat( self.weapon, "destroyed", 1 );
        }
        
        self.owner remote_weapons::destroyremotehud();
        self.owner util::freeze_player_controls( 1 );
        self.owner sendkillstreakdamageevent( 600 );
        wait 0.75;
        self.owner thread hud::fade_to_black_for_x_sec( 0, 0.25, 0.1, 0.25 );
        wait 0.25;
        self.owner qrdrone_unlink( self );
        self.owner util::freeze_player_controls( 0 );
        
        if ( isdefined( self.neverdelete ) && self.neverdelete )
        {
            return;
        }
    }
    
    qrdrone_cleanup();
}

// Namespace qrdrone
// Params 0
// Checksum 0xbabbba68, Offset: 0x54c8
// Size: 0x6c
function setvisionsetwaiter()
{
    self endon( #"disconnect" );
    self useservervisionset( 1 );
    self setvisionsetforplayer( level.qrdrone_vision, 1 );
    self.qrdrone waittill( #"end_remote" );
    self useservervisionset( 0 );
}

// Namespace qrdrone
// Params 0
// Checksum 0x99ec1590, Offset: 0x5540
// Size: 0x4
function inithud()
{
    
}

// Namespace qrdrone
// Params 0
// Checksum 0x59f9bda9, Offset: 0x5550
// Size: 0xa4
function destroyhud()
{
    if ( isdefined( self ) )
    {
        self notify( #"stop_signal_failure" );
        self.flashingsignalfailure = 0;
        self clientfield::set_to_player( "static_postfx", 0 );
        
        if ( isdefined( self.fullscreen_static ) )
        {
            self.fullscreen_static destroy();
        }
        
        self remote_weapons::destroyremotehud();
        self util::clientnotify( "nofutz" );
    }
}

// Namespace qrdrone
// Params 2
// Checksum 0xb195b1f3, Offset: 0x5600
// Size: 0x10c
function set_static_alpha( alpha, drone )
{
    if ( isdefined( self.fullscreen_static ) )
    {
        self.fullscreen_static.alpha = alpha;
    }
    
    if ( alpha > 0 )
    {
        if ( !isdefined( self.flashingsignalfailure ) || !self.flashingsignalfailure )
        {
            self thread flash_signal_failure( drone );
            self.flashingsignalfailure = 1;
            
            if ( self isremotecontrolling() )
            {
                self clientfield::set_to_player( "static_postfx", 1 );
            }
        }
        
        return;
    }
    
    self notify( #"stop_signal_failure" );
    drone clientfield::set( "qrdrone_out_of_range", 0 );
    self.flashingsignalfailure = 0;
    self clientfield::set_to_player( "static_postfx", 0 );
}

// Namespace qrdrone
// Params 1
// Checksum 0x9d33602f, Offset: 0x5718
// Size: 0xbe
function flash_signal_failure( drone )
{
    self endon( #"stop_signal_failure" );
    drone endon( #"death" );
    drone clientfield::set( "qrdrone_out_of_range", 1 );
    
    for ( i = 0;  ; i++ )
    {
        drone playsoundtoplayer( "uin_alert_lockon", self );
        
        if ( i < 5 )
        {
            wait 0.6;
            continue;
        }
        
        if ( i < 6 )
        {
            wait 0.5;
            continue;
        }
        
        wait 0.3;
    }
}

