#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_battlechatter;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/killstreaks/_airsupport;
#using scripts/mp/killstreaks/_helicopter;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreak_detect;
#using scripts/mp/killstreaks/_killstreak_hacking;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_satellite;
#using scripts/mp/teams/_teams;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/tweakables_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_heatseekingmissile;
#using scripts/shared/weapons/_weaponobjects;

#namespace counteruav;

// Namespace counteruav
// Params 0
// Checksum 0x3c69ec29, Offset: 0x708
// Size: 0x324
function init()
{
    level.activecounteruavs = [];
    level.counter_uav_positions = generaterandompoints( 20 );
    level.counter_uav_position_index = [];
    level.counter_uav_offsets = buildoffsetlist( ( 0, 0, 0 ), 3, 450, 450 );
    
    if ( level.teambased )
    {
        foreach ( team in level.teams )
        {
            level.activecounteruavs[ team ] = 0;
            level.counter_uav_position_index[ team ] = 0;
            level thread movementmanagerthink( team );
        }
    }
    else
    {
        level.activecounteruavs = [];
    }
    
    level.activeplayercounteruavs = [];
    level.counter_uav_entities = [];
    
    if ( tweakables::gettweakablevalue( "killstreak", "allowcounteruav" ) )
    {
        killstreaks::register( "counteruav", "counteruav", "killstreak_counteruav", "counteruav_used", &activatecounteruav );
        killstreaks::register_strings( "counteruav", &"KILLSTREAK_EARNED_COUNTERUAV", &"KILLSTREAK_COUNTERUAV_NOT_AVAILABLE", &"KILLSTREAK_COUNTERUAV_INBOUND", undefined, &"KILLSTREAK_COUNTERUAV_HACKED" );
        killstreaks::register_dialog( "counteruav", "mpl_killstreak_radar", "counterUavDialogBundle", "counterUavPilotDialogBundle", "friendlyCounterUav", "enemyCounterUav", "enemyCounterUavMultiple", "friendlyCounterUavHacked", "enemyCounterUavHacked", "requestCounterUav", "threatCounterUav" );
    }
    
    clientfield::register( "toplayer", "counteruav", 1, 1, "int" );
    level thread watchcounteruavs();
    callback::on_connect( &onplayerconnect );
    callback::on_spawned( &onplayerspawned );
    callback::on_joined_team( &onplayerjoinedteam );
    
    /#
        if ( getdvarint( "<dev string:x28>" ) )
        {
            level thread waitanddebugdrawoffsetlist();
        }
    #/
}

// Namespace counteruav
// Params 0
// Checksum 0x52e15150, Offset: 0xa38
// Size: 0x8a
function onplayerconnect()
{
    self.entnum = self getentitynumber();
    
    if ( !level.teambased )
    {
        level.activecounteruavs[ self.entnum ] = 0;
        level.counter_uav_position_index[ self.entnum ] = 0;
        self thread movementmanagerthink( self.entnum );
    }
    
    level.activeplayercounteruavs[ self.entnum ] = 0;
}

// Namespace counteruav
// Params 0
// Checksum 0x1dbb2559, Offset: 0xad0
// Size: 0x5c
function onplayerspawned()
{
    if ( self enemycounteruavactive() )
    {
        self clientfield::set_to_player( "counteruav", 1 );
        return;
    }
    
    self clientfield::set_to_player( "counteruav", 0 );
}

// Namespace counteruav
// Params 1
// Checksum 0xf3dc2fb0, Offset: 0xb38
// Size: 0x138
function generaterandompoints( count )
{
    points = [];
    
    for ( i = 0; i < count ; i++ )
    {
        point = airsupport::getrandommappoint( isdefined( level.cuav_map_x_offset ) ? level.cuav_map_x_offset : 0, isdefined( level.cuav_map_y_offset ) ? level.cuav_map_y_offset : 0, isdefined( level.cuav_map_x_percentage ) ? level.cuav_map_x_percentage : 0.5, isdefined( level.cuav_map_y_percentage ) ? level.cuav_map_y_percentage : 0.5 );
        minflyheight = airsupport::getminimumflyheight();
        point += ( 0, 0, minflyheight + ( isdefined( level.counter_uav_position_z_offset ) ? level.counter_uav_position_z_offset : 1000 ) );
        points[ i ] = point;
    }
    
    return points;
}

// Namespace counteruav
// Params 1
// Checksum 0xf0443955, Offset: 0xc78
// Size: 0x126
function movementmanagerthink( teamorentnum )
{
    while ( true )
    {
        level waittill( #"counter_uav_updated" );
        activecount = 0;
        
        while ( level.activecounteruavs[ teamorentnum ] > 0 )
        {
            if ( activecount == 0 )
            {
                activecount = level.activecounteruavs[ teamorentnum ];
            }
            
            currentindex = level.counter_uav_position_index[ teamorentnum ];
            
            for ( newindex = currentindex; newindex == currentindex ; newindex = randomintrange( 0, 20 ) )
            {
            }
            
            destination = level.counter_uav_positions[ newindex ];
            level.counter_uav_position_index[ teamorentnum ] = newindex;
            level notify( "counter_uav_move_" + teamorentnum );
            wait 5 + randomintrange( 5, 10 );
        }
    }
}

// Namespace counteruav
// Params 1
// Checksum 0x7f3b312c, Offset: 0xda8
// Size: 0x58
function getcurrentposition( teamorentnum )
{
    baseposition = level.counter_uav_positions[ level.counter_uav_position_index[ teamorentnum ] ];
    offset = level.counter_uav_offsets[ self.cuav_offset_index ];
    return baseposition + offset;
}

// Namespace counteruav
// Params 0
// Checksum 0x8c347702, Offset: 0xe08
// Size: 0x2c
function assignfirstavailableoffsetindex()
{
    self.cuav_offset_index = getfirstavailableoffsetindex();
    maintaincouteruaventities();
}

// Namespace counteruav
// Params 0
// Checksum 0x590e2428, Offset: 0xe40
// Size: 0x136
function getfirstavailableoffsetindex()
{
    available_offsets = [];
    
    for ( i = 0; i < level.counter_uav_offsets.size ; i++ )
    {
        available_offsets[ i ] = 1;
    }
    
    foreach ( cuav in level.counter_uav_entities )
    {
        if ( isdefined( cuav ) )
        {
            available_offsets[ cuav.cuav_offset_index ] = 0;
        }
    }
    
    for ( i = 0; i < available_offsets.size ; i++ )
    {
        if ( available_offsets[ i ] )
        {
            return i;
        }
    }
    
    /#
        util::warning( "<dev string:x3e>" );
    #/
    
    return 0;
}

// Namespace counteruav
// Params 0
// Checksum 0x7ba60e77, Offset: 0xf80
// Size: 0x5e
function maintaincouteruaventities()
{
    for ( i = level.counter_uav_entities.size; i >= 0 ; i-- )
    {
        if ( !isdefined( level.counter_uav_entities[ i ] ) )
        {
            arrayremoveindex( level.counter_uav_entities, i );
        }
    }
}

/#

    // Namespace counteruav
    // Params 0
    // Checksum 0xdcae43ea, Offset: 0xfe8
    // Size: 0x2c, Type: dev
    function waitanddebugdrawoffsetlist()
    {
        level endon( #"game_ended" );
        wait 10;
        debugdrawoffsetlist();
    }

    // Namespace counteruav
    // Params 0
    // Checksum 0xfca1b646, Offset: 0x1020
    // Size: 0xda, Type: dev
    function debugdrawoffsetlist()
    {
        baseposition = level.counter_uav_positions[ 0 ];
        
        foreach ( offset in level.counter_uav_offsets )
        {
            util::debug_sphere( baseposition + offset, 24, ( 0.95, 0.05, 0.05 ), 0.75, 9999999 );
        }
    }

#/

// Namespace counteruav
// Params 4
// Checksum 0xe657dad2, Offset: 0x1108
// Size: 0x15e
function buildoffsetlist( startoffset, depth, offset_x, offset_y )
{
    offsets = [];
    
    for ( col = 0; col < depth ; col++ )
    {
        itemcount = math::pow( 2, col );
        startingindex = itemcount - 1;
        
        for ( i = 0; i < itemcount ; i++ )
        {
            x = offset_x * col;
            y = 0;
            
            if ( itemcount > 1 )
            {
                y = i * offset_y;
                total_y = offset_y * startingindex;
                y -= total_y / 2;
            }
            
            offsets[ startingindex + i ] = startoffset + ( x, y, 0 );
        }
    }
    
    return offsets;
}

// Namespace counteruav
// Params 0
// Checksum 0xf1a25301, Offset: 0x1270
// Size: 0x338, Type: bool
function activatecounteruav()
{
    if ( self killstreakrules::iskillstreakallowed( "counteruav", self.team ) == 0 )
    {
        return false;
    }
    
    killstreak_id = self killstreakrules::killstreakstart( "counteruav", self.team );
    
    if ( killstreak_id == -1 )
    {
        return false;
    }
    
    counteruav = spawncounteruav( self, killstreak_id );
    
    if ( !isdefined( counteruav ) )
    {
        return false;
    }
    
    counteruav setscale( 1 );
    counteruav clientfield::set( "enemyvehicle", 1 );
    counteruav.killstreak_id = killstreak_id;
    counteruav thread killstreaks::waittillemp( &destroycounteruavbyemp );
    counteruav thread killstreaks::waitfortimeout( "counteruav", 30000, &ontimeout, "delete", "death", "crashing" );
    counteruav thread killstreaks::waitfortimecheck( 30000 / 2, &ontimecheck, "delete", "death", "crashing" );
    counteruav thread util::waittillendonthreaded( "death", &destroycounteruav, "delete", "leaving" );
    counteruav setcandamage( 1 );
    counteruav thread killstreaks::monitordamage( "counteruav", 700, &destroycounteruav, 700 * 0.5, &onlowhealth, 0, undefined, 1 );
    counteruav playloopsound( "veh_uav_engine_loop", 1 );
    counteruav thread listenformove();
    self killstreaks::play_killstreak_start_dialog( "counteruav", self.team, killstreak_id );
    counteruav killstreaks::play_pilot_dialog_on_owner( "arrive", "counteruav", killstreak_id );
    counteruav thread killstreaks::player_killstreak_threat_tracking( "counteruav" );
    self addweaponstat( getweapon( "counteruav" ), "used", 1 );
    return true;
}

// Namespace counteruav
// Params 1
// Checksum 0x7f46fd29, Offset: 0x15b0
// Size: 0x34
function hackedprefunction( hacker )
{
    cuav = self;
    cuav resetactivecounteruav();
}

// Namespace counteruav
// Params 2
// Checksum 0x3eba090c, Offset: 0x15f0
// Size: 0x226
function spawncounteruav( owner, killstreak_id )
{
    minflyheight = airsupport::getminimumflyheight();
    cuav = spawnvehicle( "veh_counteruav_mp", airsupport::getmapcenter() + ( 0, 0, minflyheight + ( isdefined( level.counter_uav_position_z_offset ) ? level.counter_uav_position_z_offset : 1000 ) ), ( 0, 0, 0 ), "counteruav" );
    cuav assignfirstavailableoffsetindex();
    cuav killstreaks::configure_team( "counteruav", killstreak_id, owner, undefined, undefined, &configureteampost );
    cuav killstreak_hacking::enable_hacking( "counteruav", &hackedprefunction, undefined );
    cuav.targetname = "counteruav";
    killstreak_detect::killstreaktargetset( cuav );
    cuav thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile( "crashing", undefined, 1 );
    cuav.maxhealth = 700;
    cuav.health = 99999;
    cuav.rocketdamage = 700 + 1;
    cuav setdrawinfrared( 1 );
    
    if ( !isdefined( level.counter_uav_entities ) )
    {
        level.counter_uav_entities = [];
    }
    else if ( !isarray( level.counter_uav_entities ) )
    {
        level.counter_uav_entities = array( level.counter_uav_entities );
    }
    
    level.counter_uav_entities[ level.counter_uav_entities.size ] = cuav;
    return cuav;
}

// Namespace counteruav
// Params 2
// Checksum 0x806159ce, Offset: 0x1820
// Size: 0xc4
function configureteampost( owner, ishacked )
{
    cuav = self;
    
    if ( ishacked == 0 )
    {
        cuav teams::hidetosameteam();
    }
    else
    {
        cuav setvisibletoall();
    }
    
    cuav thread teams::waituntilteamchangesingleton( owner, "CUAV_watch_team_change", &onteamchange, self.entnum, "death", "leaving", "crashing" );
    cuav addactivecounteruav();
}

// Namespace counteruav
// Params 0
// Checksum 0xfed30f34, Offset: 0x18f0
// Size: 0x70
function listenformove()
{
    self endon( #"death" );
    self endon( #"leaving" );
    
    while ( true )
    {
        self thread counteruavmove();
        level util::waittill_any( "counter_uav_move_" + self.team, "counter_uav_move_" + self.ownerentnum );
    }
}

// Namespace counteruav
// Params 0
// Checksum 0x72292cb4, Offset: 0x1968
// Size: 0x15c
function counteruavmove()
{
    self endon( #"death" );
    self endon( #"leaving" );
    level endon( "counter_uav_move_" + self.team );
    destination = ( 0, 0, 0 );
    
    if ( level.teambased )
    {
        destination = self getcurrentposition( self.team );
    }
    else
    {
        destination = self getcurrentposition( self.ownerentnum );
    }
    
    lookangles = vectortoangles( destination - self.origin );
    rotationaccelerationduration = 0.5 * 0.2;
    rotationdecelerationduration = 0.5 * 0.2;
    travelaccelerationduration = 5 * 0.2;
    traveldecelerationduration = 5 * 0.2;
    self setvehgoalpos( destination, 1, 0 );
}

// Namespace counteruav
// Params 1
// Checksum 0x268cd2f, Offset: 0x1ad0
// Size: 0x4c
function playfx( name )
{
    self endon( #"death" );
    wait 0.1;
    
    if ( isdefined( self ) )
    {
        playfxontag( name, self, "tag_origin" );
    }
}

// Namespace counteruav
// Params 2
// Checksum 0xf966fcfb, Offset: 0x1b28
// Size: 0x7c
function onlowhealth( attacker, weapon )
{
    self.is_damaged = 1;
    params = level.killstreakbundle[ "counteruav" ];
    
    if ( isdefined( params.fxlowhealth ) )
    {
        playfxontag( params.fxlowhealth, self, "tag_origin" );
    }
}

// Namespace counteruav
// Params 2
// Checksum 0xbba4b266, Offset: 0x1bb0
// Size: 0x2c
function onteamchange( entnum, event )
{
    destroycounteruav( undefined, undefined );
}

// Namespace counteruav
// Params 0
// Checksum 0x44bf349a, Offset: 0x1be8
// Size: 0x14
function onplayerjoinedteam()
{
    hideallcounteruavstosameteam();
}

// Namespace counteruav
// Params 0
// Checksum 0xdf4299a6, Offset: 0x1c08
// Size: 0x94
function ontimeout()
{
    self.leaving = 1;
    self killstreaks::play_pilot_dialog_on_owner( "timeout", "counteruav" );
    self airsupport::leave( 5 );
    wait 5;
    self removeactivecounteruav();
    target_remove( self );
    self delete();
}

// Namespace counteruav
// Params 0
// Checksum 0xde08b955, Offset: 0x1ca8
// Size: 0x34
function ontimecheck()
{
    self killstreaks::play_pilot_dialog_on_owner( "timecheck", "counteruav", self.killstreak_id );
}

// Namespace counteruav
// Params 2
// Checksum 0x19dea600, Offset: 0x1ce8
// Size: 0x3c
function destroycounteruavbyemp( attacker, arg )
{
    destroycounteruav( attacker, getweapon( "emp" ) );
}

// Namespace counteruav
// Params 2
// Checksum 0x34f0b16b, Offset: 0x1d30
// Size: 0x1b4
function destroycounteruav( attacker, weapon )
{
    if ( self.leaving !== 1 )
    {
        self killstreaks::play_destroyed_dialog_on_owner( "counteruav", self.killstreak_id );
    }
    
    attacker = self [[ level.figure_out_attacker ]]( attacker );
    
    if ( !isdefined( self.owner ) || isdefined( attacker ) && self.owner util::isenemyplayer( attacker ) )
    {
        challenges::destroyedaircraft( attacker, weapon, 0 );
        scoreevents::processscoreevent( "destroyed_counter_uav", attacker, self.owner, weapon );
        luinotifyevent( &"player_callout", 2, &"KILLSTREAK_DESTROYED_COUNTERUAV", attacker.entnum );
        attacker challenges::addflyswatterstat( weapon, self );
    }
    
    self playsound( "evt_helicopter_midair_exp" );
    self removeactivecounteruav();
    
    if ( target_istarget( self ) )
    {
        target_remove( self );
    }
    
    self thread deletecounteruav();
}

// Namespace counteruav
// Params 0
// Checksum 0xdd6eedc9, Offset: 0x1ef0
// Size: 0xcc
function deletecounteruav()
{
    self notify( #"crashing" );
    params = level.killstreakbundle[ "counteruav" ];
    
    if ( isdefined( params.ksexplosionfx ) && isdefined( self ) )
    {
        self thread playfx( params.ksexplosionfx );
    }
    
    wait 0.1;
    
    if ( isdefined( self ) )
    {
        self setmodel( "tag_origin" );
    }
    
    wait 0.2;
    
    if ( isdefined( self ) )
    {
        self notify( #"delete" );
        self delete();
    }
}

// Namespace counteruav
// Params 0
// Checksum 0xcf83226b, Offset: 0x1fc8
// Size: 0x164, Type: bool
function enemycounteruavactive()
{
    if ( level.teambased )
    {
        foreach ( team in level.teams )
        {
            if ( team == self.team )
            {
                continue;
            }
            
            if ( teamhasactivecounteruav( team ) )
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
            if ( player hasactivecounteruav() )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace counteruav
// Params 0
// Checksum 0xe184d1d, Offset: 0x2138
// Size: 0x18, Type: bool
function hasactivecounteruav()
{
    return level.activecounteruavs[ self.entnum ] > 0;
}

// Namespace counteruav
// Params 1
// Checksum 0xe14d8282, Offset: 0x2158
// Size: 0x1c, Type: bool
function teamhasactivecounteruav( team )
{
    return level.activecounteruavs[ team ] > 0;
}

// Namespace counteruav
// Params 1
// Checksum 0x4a93df1e, Offset: 0x2180
// Size: 0x1c, Type: bool
function hasindexactivecounteruav( team_or_entnum )
{
    return level.activecounteruavs[ team_or_entnum ] > 0;
}

// Namespace counteruav
// Params 0
// Checksum 0x6ffe0b39, Offset: 0x21a8
// Size: 0x1ba
function addactivecounteruav()
{
    if ( level.teambased )
    {
        level.activecounteruavs[ self.team ]++;
        
        foreach ( team in level.teams )
        {
            if ( team == self.team )
            {
                continue;
            }
            
            if ( satellite::hassatellite( team ) )
            {
                self.owner challenges::blockedsatellite();
            }
        }
    }
    else
    {
        level.activecounteruavs[ self.ownerentnum ]++;
        keys = getarraykeys( level.activecounteruavs );
        
        for ( i = 0; i < keys.size ; i++ )
        {
            if ( keys[ i ] == self.ownerentnum )
            {
                continue;
            }
            
            if ( satellite::hassatellite( keys[ i ] ) )
            {
                self.owner challenges::blockedsatellite();
                break;
            }
        }
    }
    
    level.activeplayercounteruavs[ self.ownerentnum ]++;
    level notify( #"counter_uav_updated" );
}

// Namespace counteruav
// Params 0
// Checksum 0x12df9b87, Offset: 0x2370
// Size: 0x5c
function removeactivecounteruav()
{
    cuav = self;
    cuav resetactivecounteruav();
    cuav killstreakrules::killstreakstop( "counteruav", self.originalteam, self.killstreak_id );
}

// Namespace counteruav
// Params 0
// Checksum 0x6ef9cc09, Offset: 0x23d8
// Size: 0x16a
function resetactivecounteruav()
{
    if ( level.teambased )
    {
        level.activecounteruavs[ self.team ]--;
        assert( level.activecounteruavs[ self.team ] >= 0 );
        
        if ( level.activecounteruavs[ self.team ] < 0 )
        {
            level.activecounteruavs[ self.team ] = 0;
        }
    }
    else if ( isdefined( self.owner ) )
    {
        assert( isdefined( self.ownerentnum ) );
        
        if ( !isdefined( self.ownerentnum ) )
        {
            self.ownerentnum = self.owner getentitynumber();
        }
        
        level.activecounteruavs[ self.ownerentnum ]--;
        assert( level.activecounteruavs[ self.ownerentnum ] >= 0 );
        
        if ( level.activecounteruavs[ self.ownerentnum ] < 0 )
        {
            level.activecounteruavs[ self.ownerentnum ] = 0;
        }
    }
    
    level.activeplayercounteruavs[ self.ownerentnum ]--;
    level notify( #"counter_uav_updated" );
}

// Namespace counteruav
// Params 0
// Checksum 0xa82d4f7d, Offset: 0x2550
// Size: 0xe6
function watchcounteruavs()
{
    while ( true )
    {
        level waittill( #"counter_uav_updated" );
        
        foreach ( player in level.players )
        {
            if ( player enemycounteruavactive() )
            {
                player clientfield::set_to_player( "counteruav", 1 );
                continue;
            }
            
            player clientfield::set_to_player( "counteruav", 0 );
        }
    }
}

// Namespace counteruav
// Params 0
// Checksum 0x71a2c240, Offset: 0x2640
// Size: 0x92
function hideallcounteruavstosameteam()
{
    foreach ( counteruav in level.counter_uav_entities )
    {
        if ( isdefined( counteruav ) )
        {
            counteruav teams::hidetosameteam();
        }
    }
}

