#using scripts/codescripts/struct;
#using scripts/shared/_oob;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/shared;
#using scripts/shared/ai_puppeteer_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace _gadget_clone;

// Namespace _gadget_clone
// Params 0, eflags: 0x2
// Checksum 0xc858ee47, Offset: 0x520
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_clone", &__init__, undefined, undefined );
}

// Namespace _gadget_clone
// Params 0
// Checksum 0x11944b9a, Offset: 0x560
// Size: 0x180
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 42, &gadget_clone_on, &gadget_clone_off );
    ability_player::register_gadget_possession_callbacks( 42, &gadget_clone_on_give, &gadget_clone_on_take );
    ability_player::register_gadget_flicker_callbacks( 42, &gadget_clone_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 42, &gadget_clone_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 42, &gadget_clone_is_flickering );
    callback::on_connect( &gadget_clone_on_connect );
    clientfield::register( "actor", "clone_activated", 1, 1, "int" );
    clientfield::register( "actor", "clone_damaged", 1, 1, "int" );
    clientfield::register( "allplayers", "clone_activated", 1, 1, "int" );
    level._clone = [];
}

// Namespace _gadget_clone
// Params 1
// Checksum 0x350f0493, Offset: 0x6e8
// Size: 0x22
function gadget_clone_is_inuse( slot )
{
    return self gadgetisactive( slot );
}

// Namespace _gadget_clone
// Params 1
// Checksum 0x4db29cf4, Offset: 0x718
// Size: 0x22
function gadget_clone_is_flickering( slot )
{
    return self gadgetflickering( slot );
}

// Namespace _gadget_clone
// Params 2
// Checksum 0x7c3ee49a, Offset: 0x748
// Size: 0x14
function gadget_clone_on_flicker( slot, weapon )
{
    
}

// Namespace _gadget_clone
// Params 2
// Checksum 0x9644b0bc, Offset: 0x768
// Size: 0x14
function gadget_clone_on_give( slot, weapon )
{
    
}

// Namespace _gadget_clone
// Params 2
// Checksum 0x6375ff4, Offset: 0x788
// Size: 0x14
function gadget_clone_on_take( slot, weapon )
{
    
}

// Namespace _gadget_clone
// Params 0
// Checksum 0x99ec1590, Offset: 0x7a8
// Size: 0x4
function gadget_clone_on_connect()
{
    
}

// Namespace _gadget_clone
// Params 1
// Checksum 0xd3923544, Offset: 0x7b8
// Size: 0xb2
function killclones( player )
{
    if ( isdefined( player._clone ) )
    {
        foreach ( clone in player._clone )
        {
            if ( isdefined( clone ) )
            {
                clone notify( #"clone_shutdown" );
            }
        }
    }
}

// Namespace _gadget_clone
// Params 0
// Checksum 0xaefc1c0b, Offset: 0x878
// Size: 0x30, Type: bool
function is_jumping()
{
    ground_ent = self getgroundent();
    return !isdefined( ground_ent );
}

// Namespace _gadget_clone
// Params 3
// Checksum 0x850bc2a1, Offset: 0x8b0
// Size: 0x458
function calculatespawnorigin( origin, angles, clonedistance )
{
    player = self;
    startangles = [];
    testangles = [];
    testangles[ 0 ] = ( 0, 0, 0 );
    testangles[ 1 ] = ( 0, -30, 0 );
    testangles[ 2 ] = ( 0, 30, 0 );
    testangles[ 3 ] = ( 0, -60, 0 );
    testangles[ 4 ] = ( 0, 60, 0 );
    testangles[ 5 ] = ( 0, 90, 0 );
    testangles[ 6 ] = ( 0, -90, 0 );
    testangles[ 7 ] = ( 0, 120, 0 );
    testangles[ 8 ] = ( 0, -120, 0 );
    testangles[ 9 ] = ( 0, 150, 0 );
    testangles[ 10 ] = ( 0, -150, 0 );
    testangles[ 11 ] = ( 0, 180, 0 );
    validspawns = spawnstruct();
    validpositions = [];
    validangles = [];
    zoffests = [];
    zoffests[ 0 ] = 5;
    zoffests[ 1 ] = 0;
    
    if ( player is_jumping() )
    {
        zoffests[ 2 ] = -5;
    }
    
    foreach ( zoff in zoffests )
    {
        for ( i = 0; i < testangles.size ; i++ )
        {
            startangles[ i ] = ( 0, angles[ 1 ], 0 );
            startpoint = origin + vectorscale( anglestoforward( startangles[ i ] + testangles[ i ] ), clonedistance );
            startpoint += ( 0, 0, zoff );
            
            if ( playerpositionvalidignoreent( startpoint, self ) )
            {
                closestnavmeshpoint = getclosestpointonnavmesh( startpoint, 500 );
                
                if ( isdefined( closestnavmeshpoint ) )
                {
                    startpoint = closestnavmeshpoint;
                    trace = groundtrace( startpoint + ( 0, 0, 24 ), startpoint - ( 0, 0, 24 ), 0, 0, 0 );
                    
                    if ( isdefined( trace[ "position" ] ) )
                    {
                        startpoint = trace[ "position" ];
                    }
                }
                
                validpositions[ validpositions.size ] = startpoint;
                validangles[ validangles.size ] = startangles[ i ] + testangles[ i ];
                
                if ( validangles.size == 3 )
                {
                    break;
                }
            }
        }
        
        if ( validangles.size == 3 )
        {
            break;
        }
    }
    
    validspawns.validpositions = validpositions;
    validspawns.validangles = validangles;
    return validspawns;
}

// Namespace _gadget_clone
// Params 1
// Checksum 0xf92e0437, Offset: 0xd10
// Size: 0xcc
function insertclone( clone )
{
    insertedclone = 0;
    
    for ( i = 0; i < 20 ; i++ )
    {
        if ( !isdefined( level._clone[ i ] ) )
        {
            level._clone[ i ] = clone;
            insertedclone = 1;
            println( "<dev string:x28>" + i + "<dev string:x3c>" + level._clone.size );
            break;
        }
    }
    
    assert( insertedclone );
}

// Namespace _gadget_clone
// Params 1
// Checksum 0x52288752, Offset: 0xde8
// Size: 0xc2
function removeclone( clone )
{
    for ( i = 0; i < 20 ; i++ )
    {
        if ( isdefined( level._clone[ i ] ) && level._clone[ i ] == clone )
        {
            level._clone[ i ] = undefined;
            array::remove_undefined( level._clone );
            println( "<dev string:x4e>" + i + "<dev string:x3c>" + level._clone.size );
            break;
        }
    }
}

// Namespace _gadget_clone
// Params 0
// Checksum 0x5e073c7b, Offset: 0xeb8
// Size: 0x17c
function removeoldestclone()
{
    assert( level._clone.size == 20 );
    oldestclone = undefined;
    
    for ( i = 0; i < 20 ; i++ )
    {
        if ( !isdefined( oldestclone ) && isdefined( level._clone[ i ] ) )
        {
            oldestclone = level._clone[ i ];
            oldestindex = i;
            continue;
        }
        
        if ( isdefined( level._clone[ i ] ) && level._clone[ i ].spawntime < oldestclone.spawntime )
        {
            oldestclone = level._clone[ i ];
            oldestindex = i;
        }
    }
    
    println( "<dev string:x67>" + i + "<dev string:x3c>" + level._clone.size );
    level._clone[ oldestindex ] notify( #"clone_shutdown" );
    level._clone[ oldestindex ] = undefined;
    array::remove_undefined( level._clone );
}

// Namespace _gadget_clone
// Params 0
// Checksum 0x9458309d, Offset: 0x1040
// Size: 0x494
function spawnclones()
{
    self endon( #"death" );
    self killclones( self );
    self._clone = [];
    velocity = self getvelocity();
    velocity += ( 0, 0, velocity[ 2 ] * -1 );
    velocity = vectornormalize( velocity );
    origin = self.origin + velocity * 17 + vectorscale( anglestoforward( self getangles() ), 17 );
    validspawns = calculatespawnorigin( origin, self getangles(), 60 );
    
    if ( validspawns.validpositions.size < 3 )
    {
        validextendedspawns = calculatespawnorigin( origin, self getangles(), 180 );
        
        for ( index = 0; index < validextendedspawns.validpositions.size && validspawns.validpositions.size < 3 ; index++ )
        {
            validspawns.validpositions[ validspawns.validpositions.size ] = validextendedspawns.validpositions[ index ];
            validspawns.validangles[ validspawns.validangles.size ] = validextendedspawns.validangles[ index ];
        }
    }
    
    for ( i = 0; i < validspawns.validpositions.size ; i++ )
    {
        traveldistance = distance( validspawns.validpositions[ i ], self.origin );
        validspawns.spawntimes[ i ] = traveldistance / 800;
        self thread _cloneorbfx( validspawns.validpositions[ i ], validspawns.spawntimes[ i ] );
    }
    
    for ( i = 0; i < validspawns.validpositions.size ; i++ )
    {
        if ( level._clone.size < 20 )
        {
        }
        else
        {
            removeoldestclone();
        }
        
        clone = spawnactor( "spawner_bo3_human_male_reaper_mp", validspawns.validpositions[ i ], validspawns.validangles[ i ], "", 1 );
        
        /#
            recordcircle( validspawns.validpositions[ i ], 2, ( 1, 0.5, 0 ), "<dev string:x96>", clone );
        #/
        
        _configureclone( clone, self, anglestoforward( validspawns.validangles[ i ] ), validspawns.spawntimes[ i ] );
        self._clone[ self._clone.size ] = clone;
        insertclone( clone );
        wait 0.05;
    }
    
    self notify( #"reveal_clone" );
    
    if ( self oob::isoutofbounds() )
    {
        gadget_clone_off( self, undefined );
    }
}

// Namespace _gadget_clone
// Params 2
// Checksum 0x65dd9e24, Offset: 0x14e0
// Size: 0xcc
function gadget_clone_on( slot, weapon )
{
    self clientfield::set( "clone_activated", 1 );
    self flagsys::set( "clone_activated" );
    fx = playfx( "player/fx_plyr_clone_reaper_appear", self.origin, anglestoforward( self getangles() ) );
    fx.team = self.team;
    thread spawnclones();
}

// Namespace _gadget_clone
// Params 0, eflags: 0x4
// Checksum 0x23acf5c, Offset: 0x15b8
// Size: 0x3a4
function private _updateclonepathing()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( getdvarint( "tu1_gadgetCloneSwimming", 1 ) )
        {
            if ( self.origin[ 2 ] + 36 <= getwaterheight( self.origin ) )
            {
                blackboard::setblackboardattribute( self, "_stance", "swim" );
                self setgoal( self.origin, 1 );
                wait 0.5;
                continue;
            }
        }
        
        if ( getdvarint( "tu1_gadgetCloneCrouching", 1 ) )
        {
            if ( !isdefined( self.lastknownpos ) )
            {
                self.lastknownpos = self.origin;
                self.lastknownpostime = gettime();
            }
            
            if ( distancesquared( self.lastknownpos, self.origin ) < 24 * 24 && !self haspath() )
            {
                blackboard::setblackboardattribute( self, "_stance", "crouch" );
                wait 0.5;
                continue;
            }
            
            if ( self.lastknownpostime + 2000 <= gettime() )
            {
                self.lastknownpos = self.origin;
                self.lastknownpostime = gettime();
            }
        }
        
        distance = 0;
        
        if ( isdefined( self._clone_goal ) )
        {
            distance = distancesquared( self._clone_goal, self.origin );
        }
        
        if ( distance < 14400 || !self haspath() )
        {
            forward = anglestoforward( self getangles() );
            searchorigin = self.origin + forward * 750;
            self._goal_center_point = searchorigin;
            queryresult = positionquery_source_navigation( self._goal_center_point, 500, 750, 750, 100, self );
            
            if ( queryresult.data.size == 0 )
            {
                queryresult = positionquery_source_navigation( self.origin, 500, 750, 750, 100, self );
            }
            
            if ( queryresult.data.size > 0 )
            {
                randindex = randomintrange( 0, queryresult.data.size );
                self setgoalpos( queryresult.data[ randindex ].origin, 1 );
                self._clone_goal = queryresult.data[ randindex ].origin;
                self._clone_goal_max_dist = 750;
            }
        }
        
        wait 0.5;
    }
}

// Namespace _gadget_clone
// Params 2
// Checksum 0x148879c6, Offset: 0x1968
// Size: 0x14c
function _cloneorbfx( endpos, traveltime )
{
    spawnpos = self gettagorigin( "j_spine4" );
    fxorg = spawn( "script_model", spawnpos );
    fxorg setmodel( "tag_origin" );
    fx = playfxontag( "player/fx_plyr_clone_reaper_orb", fxorg, "tag_origin" );
    fx.team = self.team;
    fxendpos = endpos + ( 0, 0, 35 );
    fxorg moveto( fxendpos, traveltime );
    self util::waittill_any_timeout( traveltime, "death", "disconnect" );
    fxorg delete();
}

// Namespace _gadget_clone
// Params 2, eflags: 0x4
// Checksum 0xbf1a8227, Offset: 0x1ac0
// Size: 0x16c
function private _clonecopyplayerlook( clone, player )
{
    if ( getdvarint( "tu1_gadgetCloneCopyLook", 1 ) )
    {
        if ( isplayer( player ) && isai( clone ) )
        {
            bodymodel = player getcharacterbodymodel();
            
            if ( isdefined( bodymodel ) )
            {
                clone setmodel( bodymodel );
            }
            
            headmodel = player getcharacterheadmodel();
            
            if ( isdefined( headmodel ) )
            {
                if ( isdefined( clone.head ) )
                {
                    clone detach( clone.head );
                }
                
                clone attach( headmodel );
            }
            
            helmetmodel = player getcharacterhelmetmodel();
            
            if ( isdefined( helmetmodel ) )
            {
                clone attach( helmetmodel );
            }
        }
    }
}

// Namespace _gadget_clone
// Params 4, eflags: 0x4
// Checksum 0x635ab461, Offset: 0x1c38
// Size: 0x4ac
function private _configureclone( clone, player, forward, spawntime )
{
    clone.isaiclone = 1;
    clone.propername = "";
    clone.ignoretriggerdamage = 1;
    clone.minwalkdistance = 125;
    clone.overrideactordamage = &clonedamageoverride;
    clone.spawntime = gettime();
    clone setmaxhealth( int( 1.5 * level.playermaxhealth ) );
    
    if ( getdvarint( "tu1_aiPathableMaterials", 0 ) )
    {
        if ( isdefined( clone.pathablematerial ) )
        {
            clone.pathablematerial &= ~2;
        }
    }
    
    clone pushactors( 1 );
    clone pushplayer( 1 );
    clone setcontents( 8192 );
    clone setavoidancemask( "avoid none" );
    clone asmsetanimationrate( randomfloatrange( 0.98, 1.02 ) );
    clone setclone();
    clone _clonecopyplayerlook( clone, player );
    clone _cloneselectweapon( player );
    clone thread _clonewatchdeath();
    clone thread _clonewatchownerdisconnect( player );
    clone thread _clonewatchshutdown();
    clone thread _clonefakefire();
    clone thread _clonebreakglass();
    clone._goal_center_point = forward * 1000 + clone.origin;
    clone._goal_center_point = getclosestpointonnavmesh( clone._goal_center_point, 600 );
    queryresult = undefined;
    
    if ( isdefined( clone._goal_center_point ) && clone findpath( clone.origin, clone._goal_center_point, 1, 0 ) )
    {
        queryresult = positionquery_source_navigation( clone._goal_center_point, 0, 450, 450, 100, clone );
    }
    else
    {
        queryresult = positionquery_source_navigation( clone.origin, 500, 750, 750, 50, clone );
    }
    
    if ( queryresult.data.size > 0 )
    {
        clone setgoalpos( queryresult.data[ 0 ].origin, 1 );
        clone._clone_goal = queryresult.data[ 0 ].origin;
        clone._clone_goal_max_dist = 450;
    }
    else
    {
        clone._goal_center_point = clone.origin;
    }
    
    clone thread _updateclonepathing();
    clone ghost();
    clone thread _show( spawntime );
    _configurecloneteam( clone, player, 0 );
}

// Namespace _gadget_clone
// Params 0, eflags: 0x4
// Checksum 0xe71f0388, Offset: 0x20f0
// Size: 0x6c
function private _playdematerialization()
{
    if ( isdefined( self ) )
    {
        fx = playfx( "player/fx_plyr_clone_vanish", self.origin );
        fx.team = self.team;
        playsoundatposition( "mpl_clone_holo_death", self.origin );
    }
}

// Namespace _gadget_clone
// Params 0, eflags: 0x4
// Checksum 0x1f51bcf0, Offset: 0x2168
// Size: 0x74
function private _clonewatchdeath()
{
    self waittill( #"death" );
    
    if ( isdefined( self ) )
    {
        self stoploopsound();
        self _playdematerialization();
        removeclone( self );
        self delete();
    }
}

// Namespace _gadget_clone
// Params 3, eflags: 0x4
// Checksum 0x1b359ba2, Offset: 0x21e8
// Size: 0xc4
function private _configurecloneteam( clone, player, ishacked )
{
    if ( ishacked == 0 )
    {
        clone.originalteam = player.team;
    }
    
    clone.ignoreall = 1;
    clone.owner = player;
    clone setteam( player.team );
    clone.team = player.team;
    clone setentityowner( player );
}

// Namespace _gadget_clone
// Params 1, eflags: 0x4
// Checksum 0x1157f09f, Offset: 0x22b8
// Size: 0xdc
function private _show( spawntime )
{
    self endon( #"death" );
    wait spawntime;
    self show();
    self clientfield::set( "clone_activated", 1 );
    fx = playfx( "player/fx_plyr_clone_reaper_appear", self.origin, anglestoforward( self getangles() ) );
    fx.team = self.team;
    self playloopsound( "mpl_clone_gadget_loop_npc" );
}

// Namespace _gadget_clone
// Params 2
// Checksum 0x7956c09e, Offset: 0x23a0
// Size: 0xc8
function gadget_clone_off( slot, weapon )
{
    self clientfield::set( "clone_activated", 0 );
    self flagsys::clear( "clone_activated" );
    self killclones( self );
    self _playdematerialization();
    
    if ( isalive( self ) && isdefined( level.playgadgetsuccess ) )
    {
        self [[ level.playgadgetsuccess ]]( weapon, "cloneSuccessDelay" );
    }
}

// Namespace _gadget_clone
// Params 0, eflags: 0x4
// Checksum 0xa0d08ff8, Offset: 0x2470
// Size: 0x5c
function private _clonedamaged()
{
    self endon( #"death" );
    self clientfield::set( "clone_damaged", 1 );
    util::wait_network_frame();
    self clientfield::set( "clone_damaged", 0 );
}

// Namespace _gadget_clone
// Params 3
// Checksum 0x15e59182, Offset: 0x24d8
// Size: 0xbc
function processclonescoreevent( clone, attacker, weapon )
{
    if ( isdefined( attacker ) && isplayer( attacker ) )
    {
        if ( !level.teambased || clone.team != attacker.pers[ "team" ] )
        {
            if ( isdefined( clone.isaiclone ) && clone.isaiclone )
            {
                scoreevents::processscoreevent( "killed_clone_enemy", attacker, clone, weapon );
            }
        }
    }
}

// Namespace _gadget_clone
// Params 15
// Checksum 0x601756fe, Offset: 0x25a0
// Size: 0x196
function clonedamageoverride( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal )
{
    self thread _clonedamaged();
    
    if ( weapon.isemp && smeansofdeath == "MOD_GRENADE_SPLASH" )
    {
        processclonescoreevent( self, eattacker, weapon );
        self notify( #"clone_shutdown" );
    }
    
    if ( isdefined( level.weaponlightninggun ) && weapon == level.weaponlightninggun )
    {
        processclonescoreevent( self, eattacker, weapon );
        self notify( #"clone_shutdown" );
    }
    
    supplydrop = getweapon( "supplydrop" );
    
    if ( isdefined( supplydrop ) && supplydrop == weapon )
    {
        processclonescoreevent( self, eattacker, weapon );
        self notify( #"clone_shutdown" );
    }
    
    return idamage;
}

// Namespace _gadget_clone
// Params 1
// Checksum 0xefe14373, Offset: 0x2740
// Size: 0x8c
function _clonewatchownerdisconnect( player )
{
    clone = self;
    clone notify( #"watchcloneownerdisconnect" );
    clone endon( #"watchcloneownerdisconnect" );
    clone endon( #"clone_shutdown" );
    player util::waittill_any( "joined_team", "disconnect", "joined_spectators" );
    
    if ( isdefined( clone ) )
    {
        clone notify( #"clone_shutdown" );
    }
}

// Namespace _gadget_clone
// Params 0
// Checksum 0xa7d81966, Offset: 0x27d8
// Size: 0xb4
function _clonewatchshutdown()
{
    clone = self;
    clone waittill( #"clone_shutdown" );
    removeclone( clone );
    
    if ( isdefined( clone ) )
    {
        if ( !level.gameended )
        {
            clone kill();
            return;
        }
        
        clone stoploopsound();
        self _playdematerialization();
        clone hide();
    }
}

// Namespace _gadget_clone
// Params 0
// Checksum 0x79b32ebe, Offset: 0x2898
// Size: 0x58
function _clonebreakglass()
{
    clone = self;
    clone endon( #"clone_shutdown" );
    clone endon( #"death" );
    
    while ( true )
    {
        clone util::break_glass();
        wait 0.25;
    }
}

// Namespace _gadget_clone
// Params 0
// Checksum 0x2da9d60e, Offset: 0x28f8
// Size: 0x258
function _clonefakefire()
{
    clone = self;
    clone endon( #"clone_shutdown" );
    clone endon( #"death" );
    
    while ( true )
    {
        waittime = randomfloatrange( 0.5, 3 );
        wait waittime;
        shotsfired = randomintrange( 1, 4 );
        
        if ( isdefined( clone.fakefireweapon ) && clone.fakefireweapon != level.weaponnone )
        {
            players = getplayers();
            
            foreach ( player in players )
            {
                if ( isdefined( player ) && isalive( player ) && player getteam() != clone.team )
                {
                    if ( distancesquared( player.origin, clone.origin ) < 562500 )
                    {
                        if ( clone cansee( player ) )
                        {
                            clone fakefire( clone.owner, clone.origin, clone.fakefireweapon, shotsfired );
                            break;
                        }
                    }
                }
            }
        }
        
        wait shotsfired / 2;
        clone setfakefire( 0 );
    }
}

// Namespace _gadget_clone
// Params 1
// Checksum 0x14575a59, Offset: 0x2b58
// Size: 0x1a0
function _cloneselectweapon( player )
{
    clone = self;
    items = _clonebuilditemlist( player );
    playerweapon = player getcurrentweapon();
    ball = getweapon( "ball" );
    
    if ( isdefined( playerweapon ) && isdefined( ball ) && playerweapon == ball )
    {
        weapon = ball;
    }
    else if ( isdefined( playerweapon.worldmodel ) && _testplayerweapon( playerweapon, items[ "primary" ] ) )
    {
        weapon = playerweapon;
    }
    else
    {
        if ( isdefined( level.var_7ce7fbed ) )
        {
            weapon = [[ level.var_7ce7fbed ]]( player );
        }
        else
        {
            weapon = undefined;
        }
        
        if ( !isdefined( weapon ) )
        {
            weapon = _chooseweapon( player );
        }
    }
    
    if ( isdefined( weapon ) )
    {
        clone shared::placeweaponon( weapon, "right" );
        clone.fakefireweapon = weapon;
    }
}

// Namespace _gadget_clone
// Params 1
// Checksum 0x9526ae3, Offset: 0x2d00
// Size: 0x208
function _clonebuilditemlist( player )
{
    pixbeginevent( "clone_build_item_list" );
    items = [];
    
    for ( i = 0; i < 256 ; i++ )
    {
        row = tablelookuprownum( level.statstableid, 0, i );
        
        if ( row > -1 )
        {
            slot = tablelookupcolumnforrow( level.statstableid, row, 13 );
            
            if ( slot == "" )
            {
                continue;
            }
            
            number = int( tablelookupcolumnforrow( level.statstableid, row, 0 ) );
            
            if ( player isitemlocked( number ) )
            {
                continue;
            }
            
            allocation = int( tablelookupcolumnforrow( level.statstableid, row, 12 ) );
            
            if ( allocation < 0 )
            {
                continue;
            }
            
            name = tablelookupcolumnforrow( level.statstableid, row, 3 );
            
            if ( !isdefined( items[ slot ] ) )
            {
                items[ slot ] = [];
            }
            
            items[ slot ][ items[ slot ].size ] = name;
        }
    }
    
    pixendevent();
    return items;
}

// Namespace _gadget_clone
// Params 1, eflags: 0x4
// Checksum 0xa01e260a, Offset: 0x2f10
// Size: 0xaa
function private _chooseweapon( player )
{
    classnum = randomint( 10 );
    
    for ( i = 0; i < 10 ; i++ )
    {
        weapon = player getloadoutweapon( ( i + classnum ) % 10, "primary" );
        
        if ( weapon != level.weaponnone )
        {
            break;
        }
    }
    
    return weapon;
}

// Namespace _gadget_clone
// Params 2, eflags: 0x4
// Checksum 0x1381ec34, Offset: 0x2fc8
// Size: 0x9e, Type: bool
function private _testplayerweapon( playerweapon, items )
{
    if ( !isdefined( items ) || !items.size || !isdefined( playerweapon ) )
    {
        return false;
    }
    
    for ( i = 0; i < items.size ; i++ )
    {
        displayname = items[ i ];
        
        if ( playerweapon.displayname == displayname )
        {
            return true;
        }
    }
    
    return false;
}

