#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/killstreaks/_airsupport;
#using scripts/mp/killstreaks/_emp;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreak_hacking;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_placeables;
#using scripts/mp/teams/_teams;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/weapons/_weaponobjects;

#namespace emp;

// Namespace emp
// Params 0
// Checksum 0xdade4432, Offset: 0x6a8
// Size: 0x2dc
function init()
{
    bundle = struct::get_script_bundle( "killstreak", "killstreak_emp" );
    level.empkillstreakbundle = bundle;
    level.activeplayeremps = [];
    level.activeemps = [];
    
    foreach ( team in level.teams )
    {
        level.activeemps[ team ] = 0;
    }
    
    level.enemyempactivefunc = &enemyempactive;
    level thread emptracker();
    killstreaks::register( "emp", "emp", "killstreak_emp", "emp_used", &activateemp );
    killstreaks::register_strings( "emp", &"KILLSTREAK_EARNED_EMP", &"KILLSTREAK_EMP_NOT_AVAILABLE", &"KILLSTREAK_EMP_INBOUND", undefined, &"KILLSTREAK_EMP_HACKED", 0 );
    killstreaks::register_dialog( "emp", "mpl_killstreak_emp_activate", "empDialogBundle", undefined, "friendlyEmp", "enemyEmp", "enemyEmpMultiple", "friendlyEmpHacked", "enemyEmpHacked", "requestEmp", "threatEmp" );
    clientfield::register( "scriptmover", "emp_turret_init", 1, 1, "int" );
    clientfield::register( "vehicle", "emp_turret_deploy", 1, 1, "int" );
    spinanim = %mp_emp_power_core::o_turret_emp_core_spin;
    deployanim = %mp_emp_power_core::o_turret_emp_core_deploy;
    callback::on_spawned( &onplayerspawned );
    callback::on_connect( &onplayerconnect );
    vehicle::add_main_callback( "emp_turret", &initturretvehicle );
}

// Namespace emp
// Params 0
// Checksum 0x745d2afe, Offset: 0x990
// Size: 0xec
function initturretvehicle()
{
    turretvehicle = self;
    turretvehicle killstreaks::setup_health( "emp" );
    turretvehicle.damagetaken = 0;
    turretvehicle.health = turretvehicle.maxhealth;
    turretvehicle clientfield::set( "enemyvehicle", 1 );
    turretvehicle.soundmod = "drone_land";
    turretvehicle.overridevehicledamage = &onturretdamage;
    turretvehicle.overridevehicledeath = &onturretdeath;
    target_set( turretvehicle, ( 0, 0, 36 ) );
}

// Namespace emp
// Params 0
// Checksum 0x889c859, Offset: 0xa88
// Size: 0x24
function onplayerspawned()
{
    self endon( #"disconnect" );
    self updateemp();
}

// Namespace emp
// Params 0
// Checksum 0x15824918, Offset: 0xab8
// Size: 0x3a
function onplayerconnect()
{
    self.entnum = self getentitynumber();
    level.activeplayeremps[ self.entnum ] = 0;
}

// Namespace emp
// Params 0
// Checksum 0x6d6296b3, Offset: 0xb00
// Size: 0x1f8, Type: bool
function activateemp()
{
    player = self;
    killstreakid = player killstreakrules::killstreakstart( "emp", player.team, 0, 0 );
    
    if ( killstreakid == -1 )
    {
        return false;
    }
    
    bundle = level.empkillstreakbundle;
    empbase = player placeables::spawnplaceable( "emp", killstreakid, &onplaceemp, &oncancelplacement, undefined, &onshutdown, undefined, undefined, "wpn_t7_turret_emp_core", "wpn_t7_turret_emp_core_yellow", "wpn_t7_turret_emp_core_red", 1, "", undefined, undefined, 0, bundle.ksplaceablehint, bundle.ksplaceableinvalidlocationhint );
    empbase thread util::ghost_wait_show_to_player( player );
    empbase.othermodel thread util::ghost_wait_show_to_others( player );
    empbase clientfield::set( "emp_turret_init", 1 );
    empbase.othermodel clientfield::set( "emp_turret_init", 1 );
    event = empbase util::waittill_any_return( "placed", "cancelled", "death", "disconnect" );
    
    if ( event != "placed" )
    {
        return false;
    }
    
    return true;
}

// Namespace emp
// Params 1
// Checksum 0xd340d5f6, Offset: 0xd00
// Size: 0x34c
function onplaceemp( emp )
{
    player = self;
    assert( isplayer( player ) );
    assert( !isdefined( emp.vehicle ) );
    emp.vehicle = spawnvehicle( "emp_turret", emp.origin, emp.angles );
    emp.vehicle thread util::ghost_wait_show( 0.05 );
    emp.vehicle.killstreaktype = emp.killstreaktype;
    emp.vehicle.owner = player;
    emp.vehicle setowner( player );
    emp.vehicle.ownerentnum = player.entnum;
    emp.vehicle.parentstruct = emp;
    player.emptime = gettime();
    player killstreaks::play_killstreak_start_dialog( "emp", player.pers[ "team" ], emp.killstreakid );
    player addweaponstat( getweapon( "emp" ), "used", 1 );
    level thread popups::displaykillstreakteammessagetoall( "emp", player );
    emp.vehicle killstreaks::configure_team( "emp", emp.killstreakid, player );
    emp.vehicle killstreak_hacking::enable_hacking( "emp", &hackedcallbackpre, &hackedcallbackpost );
    emp thread killstreaks::waitfortimeout( "emp", 60000, &on_timeout, "death" );
    
    if ( issentient( emp.vehicle ) == 0 )
    {
        emp.vehicle makesentient();
    }
    
    emp.vehicle vehicle::disconnect_paths( 0, 0 );
    player thread deployempturret( emp );
}

// Namespace emp
// Params 1
// Checksum 0x3f48ed8b, Offset: 0x1058
// Size: 0x1dc
function deployempturret( emp )
{
    player = self;
    player endon( #"disconnect" );
    player endon( #"joined_team" );
    player endon( #"joined_spectators" );
    emp endon( #"death" );
    emp.vehicle useanimtree( $mp_emp_power_core );
    emp.vehicle setanim( %mp_emp_power_core::o_turret_emp_core_deploy, 1 );
    length = getanimlength( %mp_emp_power_core::o_turret_emp_core_deploy );
    emp.vehicle clientfield::set( "emp_turret_deploy", 1 );
    wait length * 0.75;
    emp.vehicle thread playempfx();
    emp.vehicle playsound( "mpl_emp_turret_activate" );
    emp.vehicle setanim( %mp_emp_power_core::o_turret_emp_core_spin, 1 );
    player thread emp_jamenemies( emp, 0 );
    wait length * 0.25;
    emp.vehicle clearanim( %mp_emp_power_core::o_turret_emp_core_deploy, 0 );
}

// Namespace emp
// Params 1
// Checksum 0x72b7733f, Offset: 0x1240
// Size: 0x84
function hackedcallbackpre( hacker )
{
    emp_vehicle = self;
    emp_vehicle clientfield::set( "enemyvehicle", 2 );
    emp_vehicle.parentstruct killstreaks::configure_team( "emp", emp_vehicle.parentstruct.killstreakid, hacker, undefined, undefined, undefined, 1 );
}

// Namespace emp
// Params 1
// Checksum 0x6e3bb1bf, Offset: 0x12d0
// Size: 0x44
function hackedcallbackpost( hacker )
{
    emp_vehicle = self;
    hacker thread emp_jamenemies( emp_vehicle.parentstruct, 1 );
}

// Namespace emp
// Params 1
// Checksum 0xc471d655, Offset: 0x1320
// Size: 0x4c
function doneempfx( fxtagorigin )
{
    playfx( "killstreaks/fx_emp_exp_death", fxtagorigin );
    playsoundatposition( "mpl_emp_turret_deactivate", fxtagorigin );
}

// Namespace emp
// Params 0
// Checksum 0x849433c6, Offset: 0x1378
// Size: 0x3c
function playempfx()
{
    emp_vehicle = self;
    emp_vehicle playloopsound( "mpl_emp_turret_loop_close" );
    wait 0.05;
}

// Namespace emp
// Params 0
// Checksum 0xc4f519ed, Offset: 0x13c0
// Size: 0x84
function on_timeout()
{
    emp = self;
    
    if ( isdefined( emp.vehicle ) )
    {
        fxtagorigin = emp.vehicle gettagorigin( "tag_fx" );
        doneempfx( fxtagorigin );
    }
    
    shutdownemp( emp );
}

// Namespace emp
// Params 1
// Checksum 0x589fa470, Offset: 0x1450
// Size: 0x4c
function oncancelplacement( emp )
{
    stopemp( emp.team, emp.ownerentnum, emp.originalteam, emp.killstreakid );
}

// Namespace emp
// Params 15
// Checksum 0x5d845760, Offset: 0x14a8
// Size: 0x158
function onturretdamage( einflictor, attacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    empdamage = 0;
    idamage = self killstreaks::ondamageperweapon( "emp", attacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, empdamage, undefined, 1, 1 );
    self.damagetaken += idamage;
    
    if ( self.damagetaken > self.maxhealth && !isdefined( self.will_die ) )
    {
        self.will_die = 1;
        self thread ondeathafterframeend( attacker, weapon );
    }
    
    return idamage;
}

// Namespace emp
// Params 8
// Checksum 0x3da8dd63, Offset: 0x1608
// Size: 0x64
function onturretdeath( inflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime )
{
    self ondeath( attacker, weapon );
}

// Namespace emp
// Params 2
// Checksum 0xe1595e7d, Offset: 0x1678
// Size: 0x3c
function ondeathafterframeend( attacker, weapon )
{
    waittillframeend();
    
    if ( isdefined( self ) )
    {
        self ondeath( attacker, weapon );
    }
}

// Namespace emp
// Params 2
// Checksum 0x8d4e2de6, Offset: 0x16c0
// Size: 0x22c
function ondeath( attacker, weapon )
{
    emp_vehicle = self;
    fxtagorigin = self gettagorigin( "tag_fx" );
    doneempfx( fxtagorigin );
    
    if ( !isdefined( emp_vehicle.owner ) || isdefined( attacker ) && isplayer( attacker ) && emp_vehicle.owner util::isenemyplayer( attacker ) )
    {
        attacker challenges::destroyscorestreak( weapon, 0, 1, 0 );
        attacker challenges::destroynonairscorestreak_poststatslock( weapon );
        attacker addplayerstat( "destroy_turret", 1 );
        attacker addweaponstat( weapon, "destroy_turret", 1 );
        scoreevents::processscoreevent( "destroyed_emp", attacker, emp_vehicle.owner, weapon );
        luinotifyevent( &"player_callout", 2, &"KILLSTREAK_DESTROYED_EMP", attacker.entnum );
    }
    
    if ( isdefined( attacker ) && isdefined( emp_vehicle.owner ) && attacker != emp_vehicle.owner )
    {
        emp_vehicle killstreaks::play_destroyed_dialog_on_owner( "emp", emp_vehicle.parentstruct.killstreakid );
    }
    
    shutdownemp( emp_vehicle.parentstruct );
}

// Namespace emp
// Params 1
// Checksum 0x5797d9ad, Offset: 0x18f8
// Size: 0x24
function onshutdown( emp )
{
    shutdownemp( emp );
}

// Namespace emp
// Params 1
// Checksum 0xac2607db, Offset: 0x1928
// Size: 0x134
function shutdownemp( emp )
{
    if ( !isdefined( emp ) )
    {
        return;
    }
    
    if ( isdefined( emp.already_shutdown ) )
    {
        return;
    }
    
    emp.already_shutdown = 1;
    
    if ( isdefined( emp.vehicle ) )
    {
        emp.vehicle clientfield::set( "emp_turret_deploy", 0 );
    }
    
    stopemp( emp.team, emp.ownerentnum, emp.originalteam, emp.killstreakid );
    
    if ( isdefined( emp.othermodel ) )
    {
        emp.othermodel delete();
    }
    
    if ( isdefined( emp.vehicle ) )
    {
        emp.vehicle delete();
    }
    
    emp delete();
}

// Namespace emp
// Params 4
// Checksum 0x6bcee5bf, Offset: 0x1a68
// Size: 0x54
function stopemp( currentteam, currentownerentnum, originalteam, killstreakid )
{
    stopempeffect( currentteam, currentownerentnum );
    stopemprule( originalteam, killstreakid );
}

// Namespace emp
// Params 2
// Checksum 0xbf2a633b, Offset: 0x1ac8
// Size: 0x42
function stopempeffect( team, ownerentnum )
{
    level.activeemps[ team ] = 0;
    level.activeplayeremps[ ownerentnum ] = 0;
    level notify( #"emp_updated" );
}

// Namespace emp
// Params 2
// Checksum 0xa7bcc1be, Offset: 0x1b18
// Size: 0x34
function stopemprule( killstreakoriginalteam, killstreakid )
{
    killstreakrules::killstreakstop( "emp", killstreakoriginalteam, killstreakid );
}

// Namespace emp
// Params 0
// Checksum 0x2bf3ab27, Offset: 0x1b58
// Size: 0x14
function hasactiveemp()
{
    return level.activeplayeremps[ self.entnum ];
}

// Namespace emp
// Params 1
// Checksum 0xc881f687, Offset: 0x1b78
// Size: 0x1c, Type: bool
function teamhasactiveemp( team )
{
    return level.activeemps[ team ] > 0;
}

// Namespace emp
// Params 0
// Checksum 0x52bcdfa4, Offset: 0x1ba0
// Size: 0x164, Type: bool
function enemyempactive()
{
    if ( level.teambased )
    {
        foreach ( team in level.teams )
        {
            if ( team != self.team && teamhasactiveemp( team ) )
            {
                return true;
            }
        }
    }
    else
    {
        enemies = self teams::getenemyplayers();
        
        foreach ( player in enemies )
        {
            if ( player hasactiveemp() )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace emp
// Params 0
// Checksum 0x3169db1b, Offset: 0x1d10
// Size: 0xb4
function enemyempowner()
{
    enemies = self teams::getenemyplayers();
    
    foreach ( player in enemies )
    {
        if ( player hasactiveemp() )
        {
            return player;
        }
    }
    
    return undefined;
}

// Namespace emp
// Params 2
// Checksum 0x20da5e81, Offset: 0x1dd0
// Size: 0x1b4
function emp_jamenemies( empent, hacked )
{
    level endon( #"game_ended" );
    self endon( #"killstreak_hacked" );
    
    if ( level.teambased )
    {
        if ( hacked )
        {
            level.activeemps[ empent.originalteam ] = 0;
        }
        
        level.activeemps[ self.team ] = 1;
    }
    
    if ( hacked )
    {
        level.activeplayeremps[ empent.originalownerentnum ] = 0;
    }
    
    level.activeplayeremps[ self.entnum ] = 1;
    level notify( #"emp_updated" );
    level notify( #"emp_deployed" );
    visionsetnaked( "flash_grenade", 1.5 );
    wait 0.1;
    visionsetnaked( "flash_grenade", 0 );
    visionsetnaked( getdvarstring( "mapname" ), 5 );
    empkillstreakweapon = getweapon( "emp" );
    empkillstreakweapon.isempkillstreak = 1;
    level killstreaks::destroyotherteamsactivevehicles( self, empkillstreakweapon );
    level killstreaks::destroyotherteamsequipment( self, empkillstreakweapon );
    level weaponobjects::destroy_other_teams_supplemental_watcher_objects( self, empkillstreakweapon );
}

// Namespace emp
// Params 0
// Checksum 0xdcd703c7, Offset: 0x1f90
// Size: 0xae
function emptracker()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"emp_updated" );
        
        foreach ( player in level.players )
        {
            player updateemp();
        }
    }
}

// Namespace emp
// Params 0
// Checksum 0xc2622160, Offset: 0x2048
// Size: 0xb4
function updateemp()
{
    player = self;
    enemy_emp_active = player enemyempactive();
    player setempjammed( enemy_emp_active );
    emped = player isempjammed();
    player clientfield::set_to_player( "empd_monitor_distance", emped );
    
    if ( emped )
    {
        player notify( #"emp_jammed" );
    }
}

