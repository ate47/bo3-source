#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/gametypes/_perplayer;
#using scripts/shared/util_shared;

#namespace _teargrenades;

// Namespace _teargrenades
// Params 0
// Checksum 0x5499b84f, Offset: 0x138
// Size: 0xa4
function main()
{
    level.tearradius = 170;
    level.tearheight = 128;
    level.teargasfillduration = 7;
    level.teargasduration = 23;
    level.tearsufferingduration = 3;
    level.teargrenadetimer = 4;
    fgmonitor = perplayer::init( "tear_grenade_monitor", &startmonitoringtearusage, &stopmonitoringtearusage );
    perplayer::enable( fgmonitor );
}

// Namespace _teargrenades
// Params 0
// Checksum 0x503985bf, Offset: 0x1e8
// Size: 0x1c
function startmonitoringtearusage()
{
    self thread monitortearusage();
}

// Namespace _teargrenades
// Params 1
// Checksum 0xaee3c42c, Offset: 0x210
// Size: 0x1a
function stopmonitoringtearusage( disconnected )
{
    self notify( #"stop_monitoring_tear_usage" );
}

// Namespace _teargrenades
// Params 0
// Checksum 0xd2559b5e, Offset: 0x238
// Size: 0x274
function monitortearusage()
{
    self endon( #"stop_monitoring_tear_usage" );
    wait 0.05;
    weapon = getweapon( "tear_grenade" );
    
    if ( !self hasweapon( weapon ) )
    {
        return;
    }
    
    prevammo = self getammocount( weapon );
    
    while ( true )
    {
        ammo = self getammocount( weapon );
        
        if ( ammo < prevammo )
        {
            num = prevammo - ammo;
            
            /#
            #/
            
            for ( i = 0; i < num ; i++ )
            {
                grenades = getentarray( "grenade", "classname" );
                bestdist = undefined;
                bestg = undefined;
                
                for ( g = 0; g < grenades.size ; g++ )
                {
                    if ( !isdefined( grenades[ g ].teargrenade ) )
                    {
                        dist = distance( grenades[ g ].origin, self.origin + ( 0, 0, 48 ) );
                        
                        if ( !isdefined( bestdist ) || dist < bestdist )
                        {
                            bestdist = dist;
                            bestg = g;
                        }
                    }
                }
                
                if ( isdefined( bestdist ) )
                {
                    grenades[ bestg ].teargrenade = 1;
                    grenades[ bestg ] thread teargrenade_think( self.team );
                }
            }
        }
        
        prevammo = ammo;
        wait 0.05;
    }
}

// Namespace _teargrenades
// Params 1
// Checksum 0xaba8ab64, Offset: 0x4b8
// Size: 0x4c
function teargrenade_think( team )
{
    wait level.teargrenadetimer;
    ent = spawnstruct();
    ent thread tear( self.origin );
}

// Namespace _teargrenades
// Params 1
// Checksum 0x160b98fa, Offset: 0x510
// Size: 0x228
function tear( pos )
{
    trig = spawn( "trigger_radius", pos, 0, level.tearradius, level.tearheight );
    starttime = gettime();
    self thread teartimer();
    self endon( #"tear_timeout" );
    
    while ( true )
    {
        trig waittill( #"trigger", player );
        
        if ( player.sessionstate != "playing" )
        {
            continue;
        }
        
        time = ( gettime() - starttime ) / 1000;
        currad = level.tearradius;
        curheight = level.tearheight;
        
        if ( time < level.teargasfillduration )
        {
            currad *= time / level.teargasfillduration;
            curheight *= time / level.teargasfillduration;
        }
        
        offset = player.origin + ( 0, 0, 32 ) - pos;
        offset2d = ( offset[ 0 ], offset[ 1 ], 0 );
        
        if ( lengthsquared( offset2d ) > currad * currad )
        {
            continue;
        }
        
        if ( player.origin[ 2 ] - pos[ 2 ] > curheight )
        {
            continue;
        }
        
        player.teargasstarttime = gettime();
        
        if ( !isdefined( player.teargassuffering ) )
        {
            player thread teargassuffering();
        }
    }
}

// Namespace _teargrenades
// Params 0
// Checksum 0x419f689a, Offset: 0x740
// Size: 0x1a
function teartimer()
{
    wait level.teargasduration;
    self notify( #"tear_timeout" );
}

// Namespace _teargrenades
// Params 0
// Checksum 0x60985c87, Offset: 0x768
// Size: 0xd6
function teargassuffering()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self.teargassuffering = 1;
    
    if ( self util::mayapplyscreeneffect() )
    {
        self shellshock( "teargas", 60 );
    }
    
    while ( true )
    {
        if ( gettime() - self.teargasstarttime > level.tearsufferingduration * 1000 )
        {
            break;
        }
        
        wait 1;
    }
    
    self shellshock( "teargas", 1 );
    
    if ( self util::mayapplyscreeneffect() )
    {
        self.teargassuffering = undefined;
    }
}

/#

    // Namespace _teargrenades
    // Params 3
    // Checksum 0xec7d4004, Offset: 0x848
    // Size: 0x2ec, Type: dev
    function drawcylinder( pos, rad, height )
    {
        time = 0;
        
        while ( true )
        {
            currad = rad;
            curheight = height;
            
            if ( time < level.teargasfillduration )
            {
                currad *= time / level.teargasfillduration;
                curheight *= time / level.teargasfillduration;
            }
            
            for ( r = 0; r < 20 ; r++ )
            {
                theta = r / 20 * 360;
                theta2 = ( r + 1 ) / 20 * 360;
                line( pos + ( cos( theta ) * currad, sin( theta ) * currad, 0 ), pos + ( cos( theta2 ) * currad, sin( theta2 ) * currad, 0 ) );
                line( pos + ( cos( theta ) * currad, sin( theta ) * currad, curheight ), pos + ( cos( theta2 ) * currad, sin( theta2 ) * currad, curheight ) );
                line( pos + ( cos( theta ) * currad, sin( theta ) * currad, 0 ), pos + ( cos( theta ) * currad, sin( theta ) * currad, curheight ) );
            }
            
            time += 0.05;
            
            if ( time > level.teargasduration )
            {
                break;
            }
            
            wait 0.05;
        }
    }

#/
