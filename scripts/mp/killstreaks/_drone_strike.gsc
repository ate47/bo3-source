#using scripts/codescripts/struct;
#using scripts/mp/_challenges;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/killstreaks/_airsupport;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreak_hacking;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_planemortar;
#using scripts/mp/killstreaks/_satellite;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_hacker_tool;

#namespace drone_strike;

// Namespace drone_strike
// Params 0
// Checksum 0xcacd8e6d, Offset: 0x6b0
// Size: 0x10c
function init()
{
    killstreaks::register( "drone_strike", "drone_strike", "killstreak_drone_strike", "drone_strike_used", &activatedronestrike, 1 );
    killstreaks::register_strings( "drone_strike", &"KILLSTREAK_DRONE_STRIKE_EARNED", &"KILLSTREAK_DRONE_STRIKE_NOT_AVAILABLE", &"KILLSTREAK_DRONE_STRIKE_INBOUND", &"KILLSTREAK_DRONE_STRIKE_INBOUND_NEAR_PLAYER", &"KILLSTREAK_DRONE_STRIKE_HACKED" );
    killstreaks::register_dialog( "drone_strike", "mpl_killstreak_drone_strike", "droneStrikeDialogBundle", undefined, "friendlyDroneStrike", "enemyDroneStrike", "enemyDroneStrikeMultiple", "friendlyDroneStrikeHacked", "enemyDroneStrikeHacked", "requestDroneStrike", "threatDroneStrike" );
    killstreaks::set_team_kill_penalty_scale( "drone_strike", level.teamkillreducedpenalty );
}

// Namespace drone_strike
// Params 0
// Checksum 0xa3e9ac8d, Offset: 0x7c8
// Size: 0x76, Type: bool
function activatedronestrike()
{
    if ( self killstreakrules::iskillstreakallowed( "drone_strike", self.team ) == 0 )
    {
        return false;
    }
    
    result = self selectdronestrikepath();
    
    if ( !isdefined( result ) || !result )
    {
        return false;
    }
    
    return true;
}

// Namespace drone_strike
// Params 0
// Checksum 0x2c1bed70, Offset: 0x848
// Size: 0x18a
function selectdronestrikepath()
{
    self beginlocationnapalmselection( "map_directional_selector" );
    self.selectinglocation = 1;
    self thread airsupport::endselectionthink();
    locations = [];
    
    if ( !isdefined( self.pers[ "drone_strike_radar_used" ] ) || !self.pers[ "drone_strike_radar_used" ] )
    {
        self thread planemortar::singleradarsweep();
    }
    
    location = self waitforlocationselection();
    
    if ( !isdefined( self ) )
    {
        return 0;
    }
    
    if ( !isdefined( location.origin ) )
    {
        self.pers[ "drone_strike_radar_used" ] = 1;
        self notify( #"cancel_selection" );
        return 0;
    }
    
    if ( self killstreakrules::iskillstreakallowed( "drone_strike", self.team ) == 0 )
    {
        self.pers[ "drone_strike_radar_used" ] = 1;
        self notify( #"cancel_selection" );
        return 0;
    }
    
    self.pers[ "drone_strike_radar_used" ] = 0;
    return self airsupport::finishhardpointlocationusage( location, &dronestrikelocationselected );
}

// Namespace drone_strike
// Params 0
// Checksum 0xf2abe4f9, Offset: 0x9e0
// Size: 0x8c
function waitforlocationselection()
{
    self endon( #"emp_jammed" );
    self endon( #"emp_grenaded" );
    self waittill( #"confirm_location", location, yaw );
    locationinfo = spawnstruct();
    locationinfo.origin = location;
    locationinfo.yaw = yaw;
    return locationinfo;
}

// Namespace drone_strike
// Params 1
// Checksum 0x8139dd51, Offset: 0xa78
// Size: 0x158, Type: bool
function dronestrikelocationselected( location )
{
    team = self.team;
    killstreak_id = self killstreakrules::killstreakstart( "drone_strike", team, 0, 1 );
    
    if ( killstreak_id == -1 )
    {
        return false;
    }
    
    self killstreaks::play_killstreak_start_dialog( "drone_strike", team, killstreak_id );
    self addweaponstat( getweapon( "drone_strike" ), "used", 1 );
    spawn_influencer = level spawning::create_enemy_influencer( "artillery", location.origin, team );
    self thread watchforkillstreakend( team, spawn_influencer, killstreak_id );
    self thread startdronestrike( location.origin, location.yaw, team, killstreak_id );
    return true;
}

// Namespace drone_strike
// Params 3
// Checksum 0x87d3f965, Offset: 0xbd8
// Size: 0x7c
function watchforkillstreakend( team, influencer, killstreak_id )
{
    self util::waittill_any( "disconnect", "joined_team", "joined_spectators", "drone_strike_complete", "emp_jammed" );
    killstreakrules::killstreakstop( "drone_strike", team, killstreak_id );
}

// Namespace drone_strike
// Params 4
// Checksum 0x29047183, Offset: 0xc60
// Size: 0x3aa
function startdronestrike( position, yaw, team, killstreak_id )
{
    self endon( #"emp_jammed" );
    self endon( #"joined_team" );
    self endon( #"joined_spectators" );
    self endon( #"disconnect" );
    angles = ( 0, yaw, 0 );
    direction = anglestoforward( angles );
    height = airsupport::getminimumflyheight() + 3000;
    selectedposition = ( position[ 0 ], position[ 1 ], height );
    startpoint = selectedposition + vectorscale( direction, -14000 );
    endpoint = selectedposition + vectorscale( direction, -6000 );
    tracestartpos = ( position[ 0 ], position[ 1 ], height );
    traceendpos = ( position[ 0 ], position[ 1 ], height * -1 );
    trace = bullettrace( tracestartpos, traceendpos, 0, undefined );
    targetpoint = trace[ "fraction" ] < 1 ? trace[ "position" ] : ( position[ 0 ], position[ 1 ], 0 );
    initialoffset = vectorscale( direction, ( 12 * 0.5 - 1 ) * 500 ) * -1;
    
    for ( i = 0; i < 12 ; i++ )
    {
        right = anglestoright( angles );
        rightoffset = vectorscale( right, 300 );
        leftoffset = vectorscale( right, 900 );
        forwardoffset = endpoint + initialoffset + vectorscale( direction, i * 500 );
        self thread spawndrone( startpoint + rightoffset, forwardoffset + rightoffset, targetpoint, angles, self.team, killstreak_id );
        self thread spawndrone( startpoint - rightoffset, forwardoffset - rightoffset, targetpoint, angles, self.team, killstreak_id );
        self thread spawndrone( startpoint + leftoffset, forwardoffset + leftoffset, targetpoint, angles, self.team, killstreak_id );
        wait 1;
        self playsound( "mpl_thunder_flyover_wash" );
    }
    
    wait 3;
    self notify( #"drone_strike_complete" );
}

// Namespace drone_strike
// Params 6
// Checksum 0x3824999, Offset: 0x1018
// Size: 0x524
function spawndrone( startpoint, endpoint, targetpoint, angles, team, killstreak_id )
{
    drone = spawnplane( self, "script_model", startpoint );
    drone.team = team;
    drone.targetname = "drone_strike";
    drone setowner( self );
    drone.owner = self;
    drone.owner thread watchownerevents( drone );
    drone killstreaks::configure_team( "drone_strike", killstreak_id, self );
    drone killstreak_hacking::enable_hacking( "drone_strike" );
    target_set( drone );
    drone endon( #"delete" );
    drone endon( #"death" );
    drone.angles = angles;
    drone setmodel( "veh_t7_drone_rolling_thunder" );
    drone setenemymodel( "veh_t7_drone_rolling_thunder" );
    drone notsolid();
    playfxontag( "killstreaks/fx_rolling_thunder_thruster_trails", drone, "tag_fx" );
    drone clientfield::set( "enemyvehicle", 1 );
    drone setupdamagehandling();
    drone thread watchforemp( self );
    drone moveto( endpoint, 1.8, 0, 0 );
    wait 1.8;
    weapon = getweapon( "drone_strike" );
    velocity = drone getvelocity();
    halfgravity = 386;
    dxy = abs( -6000 );
    dz = endpoint[ 2 ] - targetpoint[ 2 ];
    dvxy = dxy * sqrt( halfgravity / dz );
    nvel = vectornormalize( velocity );
    launchvel = nvel * dvxy;
    bomb = self launchbomb( weapon, drone.origin, launchvel );
    target_set( bomb );
    bomb killstreaks::configure_team( "drone_strike", killstreak_id, self );
    bomb killstreak_hacking::enable_hacking( "drone_strike" );
    drone notify( #"hackertool_update_ent", bomb );
    bomb clientfield::set( "enemyvehicle", 1 );
    bomb.targetname = "drone_strike";
    bomb setowner( self );
    bomb.owner = self;
    bomb.team = team;
    bomb playsound( "mpl_thunder_incoming_start" );
    bomb setupdamagehandling();
    bomb thread watchforemp( self );
    bomb.owner thread watchownerevents( bomb );
    wait 0.05;
    drone hide();
    wait 0.05;
    drone delete();
}

// Namespace drone_strike
// Params 0
// Checksum 0xb9ec8118, Offset: 0x1548
// Size: 0xf4
function setupdamagehandling()
{
    drone = self;
    drone setcandamage( 1 );
    drone.maxhealth = killstreak_bundles::get_max_health( "drone_strike" );
    drone.lowhealth = killstreak_bundles::get_low_health( "drone_strike" );
    drone.health = drone.maxhealth;
    drone thread killstreaks::monitordamage( "drone_strike", drone.maxhealth, &destroydroneplane, drone.lowhealth, undefined, 0, &empdamagedrone, 1 );
}

// Namespace drone_strike
// Params 2
// Checksum 0xf2466db1, Offset: 0x1648
// Size: 0x19c
function destroydroneplane( attacker, weapon )
{
    self endon( #"death" );
    attacker = self [[ level.figure_out_attacker ]]( attacker );
    
    if ( !isdefined( self.owner ) || isdefined( attacker ) && self.owner util::isenemyplayer( attacker ) )
    {
        challenges::destroyedaircraft( attacker, weapon, 0 );
        attacker challenges::addflyswatterstat( weapon, self );
        scoreevents::processscoreevent( "destroyed_rolling_thunder_drone", attacker, self.owner, weapon );
        luinotifyevent( &"player_callout", 2, &"KILLSTREAK_DESTROYED_ROLLING_THUNDER_DRONE", attacker.entnum );
    }
    
    params = level.killstreakbundle[ "drone_strike" ];
    
    if ( isdefined( params.ksexplosionfx ) )
    {
        playfxontag( params.ksexplosionfx, self, "tag_origin" );
    }
    
    self setmodel( "tag_origin" );
    wait 0.5;
    self delete();
}

// Namespace drone_strike
// Params 1
// Checksum 0x3e155982, Offset: 0x17f0
// Size: 0x84
function watchownerevents( bomb )
{
    player = self;
    bomb endon( #"death" );
    player util::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    
    if ( isdefined( isalive( bomb ) ) )
    {
        bomb delete();
    }
}

// Namespace drone_strike
// Params 1
// Checksum 0x304e9434, Offset: 0x1880
// Size: 0x6c
function watchforemp( owner )
{
    self endon( #"delete" );
    self endon( #"death" );
    self waittill( #"emp_deployed", attacker );
    thread dronestrikeawardempscoreevent( attacker, self );
    self blowupdronestrike();
}

// Namespace drone_strike
// Params 1
// Checksum 0xe67477e1, Offset: 0x18f8
// Size: 0x3c
function empdamagedrone( attacker )
{
    thread dronestrikeawardempscoreevent( attacker, self );
    self blowupdronestrike();
}

// Namespace drone_strike
// Params 2
// Checksum 0xa0e22a3c, Offset: 0x1940
// Size: 0x15c
function dronestrikeawardempscoreevent( attacker, victim )
{
    owner = self.owner;
    attacker endon( #"disconnect" );
    attacker notify( #"dronestrikeawardscoreevent_singleton" );
    attacker endon( #"dronestrikeawardscoreevent_singleton" );
    waittillframeend();
    attacker = self [[ level.figure_out_attacker ]]( attacker );
    scoreevents::processscoreevent( "destroyed_rolling_thunder_all_drones", attacker, victim, getweapon( "emp" ) );
    challenges::destroyedaircraft( attacker, getweapon( "emp" ), 0 );
    attacker challenges::addflyswatterstat( getweapon( "emp" ), self );
    luinotifyevent( &"player_callout", 2, &"KILLSTREAK_DESTROYED_ROLLING_THUNDER_ALL_DRONES", attacker.entnum );
    owner globallogic_audio::play_taacom_dialog( "destroyed", "drone_strike" );
}

// Namespace drone_strike
// Params 0
// Checksum 0xa730fe5e, Offset: 0x1aa8
// Size: 0x7c
function blowupdronestrike()
{
    params = level.killstreakbundle[ "drone_strike" ];
    
    if ( isdefined( self ) && isdefined( params.ksexplosionfx ) )
    {
        playfx( params.ksexplosionfx, self.origin );
    }
    
    self delete();
}

