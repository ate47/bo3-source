#using scripts/codescripts/struct;
#using scripts/cp/_challenges;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_dev;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_gadget_sensory_overload;
#using scripts/cp/cybercom/_cybercom_gadget_system_overload;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace cybercom_gadget_smokescreen;

// Namespace cybercom_gadget_smokescreen
// Params 0
// Checksum 0x99ec1590, Offset: 0x440
// Size: 0x4
function init()
{
    
}

// Namespace cybercom_gadget_smokescreen
// Params 0
// Checksum 0xeedc48a8, Offset: 0x450
// Size: 0x17c
function main()
{
    cybercom_gadget::registerability( 1, 1 );
    level.cybercom.smokescreen = spawnstruct();
    level.cybercom.smokescreen._is_flickering = &_is_flickering;
    level.cybercom.smokescreen._on_flicker = &_on_flicker;
    level.cybercom.smokescreen._on_give = &_on_give;
    level.cybercom.smokescreen._on_take = &_on_take;
    level.cybercom.smokescreen._on_connect = &_on_connect;
    level.cybercom.smokescreen._on = &_on;
    level.cybercom.smokescreen._off = &_off;
    level.cybercom.smokescreen._is_primed = &_is_primed;
}

// Namespace cybercom_gadget_smokescreen
// Params 1
// Checksum 0xd230f060, Offset: 0x5d8
// Size: 0xc
function _is_flickering( slot )
{
    
}

// Namespace cybercom_gadget_smokescreen
// Params 2
// Checksum 0x78b18fc8, Offset: 0x5f0
// Size: 0x14
function _on_flicker( slot, weapon )
{
    
}

// Namespace cybercom_gadget_smokescreen
// Params 2
// Checksum 0x1d5424, Offset: 0x610
// Size: 0x4c
function _on_give( slot, weapon )
{
    self.cybercom.targetlockcb = undefined;
    self.cybercom.targetlockrequirementcb = undefined;
    self thread cybercom::function_b5f4e597( weapon );
}

// Namespace cybercom_gadget_smokescreen
// Params 2
// Checksum 0x19113ca5, Offset: 0x668
// Size: 0x14
function _on_take( slot, weapon )
{
    
}

// Namespace cybercom_gadget_smokescreen
// Params 0
// Checksum 0x99ec1590, Offset: 0x688
// Size: 0x4
function _on_connect()
{
    
}

// Namespace cybercom_gadget_smokescreen
// Params 2
// Checksum 0xb8ccd566, Offset: 0x698
// Size: 0xe4
function _on( slot, weapon )
{
    cybercom::function_adc40f11( weapon, 1 );
    level thread spawn_smokescreen( self, self hascybercomability( "cybercom_smokescreen" ) == 2 );
    
    if ( isplayer( self ) )
    {
        itemindex = getitemindexfromref( "cybercom_smokescreen" );
        
        if ( isdefined( itemindex ) )
        {
            self adddstat( "ItemStats", itemindex, "stats", "used", "statValue", 1 );
        }
    }
}

// Namespace cybercom_gadget_smokescreen
// Params 2
// Checksum 0x63e3cfd5, Offset: 0x788
// Size: 0x14
function _off( slot, weapon )
{
    
}

// Namespace cybercom_gadget_smokescreen
// Params 2
// Checksum 0xafacf266, Offset: 0x7a8
// Size: 0x14
function _is_primed( slot, weapon )
{
    
}

// Namespace cybercom_gadget_smokescreen
// Params 2
// Checksum 0x172cb9c9, Offset: 0x7c8
// Size: 0xe2
function rotateforwardxy( vtorotate, fangledegrees )
{
    x = vtorotate[ 0 ] * cos( fangledegrees ) + vtorotate[ 1 ] * sin( fangledegrees );
    y = -1 * vtorotate[ 0 ] * sin( fangledegrees ) + vtorotate[ 1 ] * cos( fangledegrees );
    z = vtorotate[ 2 ];
    return ( x, y, z );
}

// Namespace cybercom_gadget_smokescreen
// Params 2
// Checksum 0xbb3a8301, Offset: 0x8b8
// Size: 0x3d4
function spawn_smokescreen( owner, upgraded )
{
    if ( !isdefined( upgraded ) )
    {
        upgraded = 0;
    }
    
    weapon = upgraded ? getweapon( "smoke_cybercom_upgraded" ) : getweapon( "smoke_cybercom" );
    forward = anglestoforward( owner.angles );
    center = 40 * forward + owner.origin;
    frontspot = 140 * forward + center;
    owner thread _cloudcreate( frontspot, weapon, upgraded );
    playsoundatposition( "gdt_cybercore_smokescreen", frontspot );
    rotated = rotateforwardxy( forward, 23 );
    var_ae0aa92 = rotated * 140 + center;
    rotated = rotateforwardxy( forward, 46 );
    var_e4de3029 = rotated * 140 + center;
    rotated = rotateforwardxy( forward, 69 );
    var_bedbb5c0 = rotated * 140 + center;
    owner thread _cloudcreate( var_ae0aa92, weapon, upgraded );
    util::wait_network_frame();
    owner thread _cloudcreate( var_e4de3029, weapon, upgraded );
    util::wait_network_frame();
    owner thread _cloudcreate( var_bedbb5c0, weapon, upgraded );
    util::wait_network_frame();
    rotated = rotateforwardxy( forward, -23 );
    var_354533f = rotated * 140 + center;
    rotated = rotateforwardxy( forward, -46 );
    var_914ce404 = rotated * 140 + center;
    rotated = rotateforwardxy( forward, -69 );
    var_b74f5e6d = rotated * 140 + center;
    owner thread _cloudcreate( var_354533f, weapon, upgraded );
    util::wait_network_frame();
    owner thread _cloudcreate( var_914ce404, weapon, upgraded );
    util::wait_network_frame();
    owner thread _cloudcreate( var_b74f5e6d, weapon, upgraded );
    util::wait_network_frame();
    owner thread function_e52895b( center );
}

// Namespace cybercom_gadget_smokescreen
// Params 3, eflags: 0x4
// Checksum 0xa466cabf, Offset: 0xc98
// Size: 0x290
function private _cloudcreate( origin, weapon, createionfield )
{
    timestep = 2;
    cloud = _createnosightcloud( origin, getdvarint( "scr_smokescreen_duration", 7 ), weapon );
    cloud thread _deleteaftertime( getdvarint( "scr_smokescreen_duration", 7 ) );
    cloud thread _scaleovertime( getdvarint( "scr_smokescreen_duration", 7 ), 1, 2 );
    cloud setteam( self.team );
    
    if ( isplayer( self ) )
    {
        cloud setowner( self );
    }
    
    cloud.durationleft = getdvarint( "scr_smokescreen_duration", 7 );
    
    if ( createionfield )
    {
        cloud thread _ionizedhazard( self, timestep );
    }
    
    if ( getdvarint( "scr_smokescreen_debug", 0 ) )
    {
        cloud thread _debug_cloud( getdvarint( "scr_smokescreen_duration", 7 ) );
        level thread cybercom_dev::function_a0e51d80( cloud.origin, getdvarint( "scr_smokescreen_duration", 7 ), 16, ( 1, 0, 0 ) );
    }
    
    cloud endon( #"death" );
    
    while ( true )
    {
        fxblocksight( cloud, cloud.currentradius );
        wait timestep;
        cloud.durationleft -= timestep;
        
        if ( cloud.durationleft < 0 )
        {
            cloud.durationleft = 0;
        }
    }
}

// Namespace cybercom_gadget_smokescreen
// Params 2, eflags: 0x4
// Checksum 0x6c6a6796, Offset: 0xf30
// Size: 0xb6
function private _ionizedhazard( player, timestep )
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( isdefined( self.trigger ) )
        {
            self.trigger delete();
        }
        
        self.trigger = spawn( "trigger_radius", self.origin, 25, self.currentradius, self.currentradius );
        self.trigger thread _ionizedhazardthink( player, self );
        wait timestep;
    }
}

// Namespace cybercom_gadget_smokescreen
// Params 2, eflags: 0x4
// Checksum 0x6751a475, Offset: 0xff0
// Size: 0x31a
function private _ionizedhazardthink( player, cloud )
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", guy );
        
        if ( !isdefined( cloud ) )
        {
            return;
        }
        
        if ( !isdefined( guy ) )
        {
            continue;
        }
        
        if ( !isalive( guy ) )
        {
            continue;
        }
        
        if ( isdefined( guy.is_disabled ) && guy.is_disabled )
        {
            return 0;
        }
        
        if ( !( isdefined( guy.takedamage ) && guy.takedamage ) )
        {
            return 0;
        }
        
        if ( isdefined( guy._ai_melee_opponent ) )
        {
            return 0;
        }
        
        if ( isdefined( guy.is_disabled ) && guy.is_disabled )
        {
            continue;
        }
        
        if ( guy cybercom::cybercom_aicheckoptout( "cybercom_smokescreen" ) )
        {
            continue;
        }
        
        if ( isdefined( guy.magic_bullet_shield ) && guy.magic_bullet_shield )
        {
            continue;
        }
        
        if ( isactor( guy ) && guy isinscriptedstate() )
        {
            continue;
        }
        
        if ( isdefined( guy.allowdeath ) && !guy.allowdeath )
        {
            continue;
        }
        
        if ( isvehicle( guy ) )
        {
            if ( !isdefined( guy.var_5895314d ) )
            {
                player thread challenges::function_96ed590f( "cybercom_uses_martial" );
                guy.var_5895314d = 1;
            }
            
            guy thread cybercom_gadget_system_overload::system_overload( player, cloud.durationleft * 1000 );
        }
        
        if ( isdefined( guy.archetype ) )
        {
            switch ( guy.archetype )
            {
                default:
                    player thread challenges::function_96ed590f( "cybercom_uses_martial" );
                    guy thread cybercom_gadget_system_overload::system_overload( player, cloud.durationleft * 1000 );
                    break;
                case "human":
                case "human_riotshield":
                    player thread challenges::function_96ed590f( "cybercom_uses_martial" );
                    guy thread cybercom_gadget_sensory_overload::sensory_overload( player, "cybercom_smokescreen" );
                    break;
            }
        }
    }
}

// Namespace cybercom_gadget_smokescreen
// Params 3, eflags: 0x4
// Checksum 0xc0551218, Offset: 0x1318
// Size: 0x90
function private _moveindirection( dir, unitstomove, seconds )
{
    self endon( #"death" );
    ticks = seconds * 20;
    dxstep = unitstomove / ticks * vectornormalize( dir );
    
    while ( ticks )
    {
        ticks--;
        self.origin += dxstep;
    }
}

// Namespace cybercom_gadget_smokescreen
// Params 3, eflags: 0x4
// Checksum 0xd20be4a2, Offset: 0x13b0
// Size: 0x88
function private _createnosightcloud( origin, duration, weapon )
{
    smokescreen = spawntimedfx( weapon, origin, ( 0, 0, 1 ), duration );
    smokescreen.currentradius = getdvarint( "scr_smokescreen_radius", 60 );
    smokescreen.currentscale = 1;
    return smokescreen;
}

// Namespace cybercom_gadget_smokescreen
// Params 1, eflags: 0x4
// Checksum 0x251ec98a, Offset: 0x1440
// Size: 0x5c
function private _deleteaftertime( time )
{
    self endon( #"death" );
    wait time;
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    self delete();
}

// Namespace cybercom_gadget_smokescreen
// Params 3, eflags: 0x4
// Checksum 0x9c661a40, Offset: 0x14a8
// Size: 0x176
function private _scaleovertime( time, startscale, maxscale )
{
    self endon( #"death" );
    
    if ( maxscale < 1 )
    {
        maxscale = 1;
    }
    
    self.currentscale = startscale;
    serverticks = time * 20;
    up = maxscale > startscale;
    
    if ( up )
    {
        deltascale = maxscale - startscale;
        deltastep = deltascale / serverticks;
    }
    else
    {
        deltascale = startscale - maxscale;
        deltastep = deltascale / serverticks * -1;
    }
    
    while ( serverticks )
    {
        self.currentscale += deltastep;
        
        if ( self.currentscale > maxscale )
        {
            self.currentscale = maxscale;
        }
        
        if ( self.currentscale < 1 )
        {
            self.currentscale = 1;
        }
        
        self.currentradius = getdvarint( "scr_smokescreen_radius", 60 ) * self.currentscale;
        wait 0.05;
        serverticks--;
    }
}

// Namespace cybercom_gadget_smokescreen
// Params 1, eflags: 0x4
// Checksum 0x32b6a896, Offset: 0x1628
// Size: 0x70
function private _debug_cloud( time )
{
    self endon( #"death" );
    serverticks = time * 20;
    
    while ( serverticks )
    {
        serverticks--;
        level thread cybercom::debug_sphere( self.origin, self.currentradius );
        wait 0.05;
    }
}

// Namespace cybercom_gadget_smokescreen
// Params 2
// Checksum 0xad1bba24, Offset: 0x16a0
// Size: 0xfc
function ai_activatesmokescreen( var_9bc2efcb, upgraded )
{
    if ( !isdefined( var_9bc2efcb ) )
    {
        var_9bc2efcb = 1;
    }
    
    if ( !isdefined( upgraded ) )
    {
        upgraded = 0;
    }
    
    if ( isdefined( var_9bc2efcb ) && var_9bc2efcb )
    {
        type = self cybercom::function_5e3d3aa();
        self orientmode( "face default" );
        self animscripted( "ai_cybercom_anim", self.origin, self.angles, "ai_base_rifle_" + type + "_exposed_cybercom_activate" );
        self waittillmatch( #"ai_cybercom_anim", "fire" );
    }
    
    level thread spawn_smokescreen( self, upgraded );
}

// Namespace cybercom_gadget_smokescreen
// Params 1, eflags: 0x4
// Checksum 0xa78c071e, Offset: 0x17a8
// Size: 0x8e
function private function_e52895b( origin )
{
    self endon( #"death" );
    var_9f9fc36f = 1;
    timeleft = getdvarint( "scr_smokescreen_duration", 7 );
    
    while ( timeleft > 0 )
    {
        resetvisibilitycachewithinradius( origin, 1000 );
        wait var_9f9fc36f;
        timeleft -= var_9f9fc36f;
    }
}

