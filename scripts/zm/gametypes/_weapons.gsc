#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/bb_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons_shared;
#using scripts/zm/_bb;
#using scripts/zm/_challenges;
#using scripts/zm/_sticky_grenade;
#using scripts/zm/_util;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/gametypes/_globallogic_utils;
#using scripts/zm/gametypes/_shellshock;
#using scripts/zm/gametypes/_weapon_utils;
#using scripts/zm/gametypes/_weaponobjects;

#namespace weapons;

// Namespace weapons
// Params 0
// Checksum 0xd96e02af, Offset: 0x678
// Size: 0x84
function init()
{
    level.missileentities = [];
    level.hackertooltargets = [];
    
    if ( !isdefined( level.grenadelauncherdudtime ) )
    {
        level.grenadelauncherdudtime = 0;
    }
    
    if ( !isdefined( level.throwngrenadedudtime ) )
    {
        level.throwngrenadedudtime = 0;
    }
    
    level thread onplayerconnect();
    
    if ( level._uses_sticky_grenades )
    {
        _sticky_grenade::init();
    }
}

// Namespace weapons
// Params 0
// Checksum 0x7961baa, Offset: 0x708
// Size: 0x80
function onplayerconnect()
{
    for ( ;; )
    {
        level waittill( #"connecting", player );
        player.usedweapons = 0;
        player.lastfiretime = 0;
        player.hits = 0;
        player scavenger_hud_create();
        player thread onplayerspawned();
    }
}

// Namespace weapons
// Params 0
// Checksum 0xfb4e9f26, Offset: 0x790
// Size: 0x108
function onplayerspawned()
{
    self endon( #"disconnect" );
    
    for ( ;; )
    {
        self waittill( #"spawned_player" );
        self.concussionendtime = 0;
        self.hasdonecombat = 0;
        self.shielddamageblocked = 0;
        self thread watchweaponusage();
        self thread watchgrenadeusage();
        self thread watchmissileusage();
        self thread watchweaponchange();
        self thread watchriotshielduse();
        self thread trackweapon();
        self.droppeddeathweapon = undefined;
        self.tookweaponfrom = [];
        self.pickedupweaponkills = [];
        self thread updatestowedweapon();
    }
}

// Namespace weapons
// Params 0
// Checksum 0x19a8905e, Offset: 0x8a0
// Size: 0xa0
function watchweaponchange()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self.lastdroppableweapon = self getcurrentweapon();
    
    while ( true )
    {
        previous_weapon = self getcurrentweapon();
        self waittill( #"weapon_change", newweapon );
        
        if ( maydropweapon( newweapon ) )
        {
            self.lastdroppableweapon = newweapon;
        }
    }
}

// Namespace weapons
// Params 0
// Checksum 0x99ec1590, Offset: 0x948
// Size: 0x4
function watchriotshielduse()
{
    
}

// Namespace weapons
// Params 1
// Checksum 0xd45ead11, Offset: 0x958
// Size: 0x98
function updatelastheldweapontimings( newtime )
{
    if ( isdefined( self.currentweapon ) && isdefined( self.currentweaponstarttime ) )
    {
        totaltime = int( ( newtime - self.currentweaponstarttime ) / 1000 );
        
        if ( totaltime > 0 )
        {
            self addweaponstat( self.currentweapon, "timeUsed", totaltime );
            self.currentweaponstarttime = newtime;
        }
    }
}

// Namespace weapons
// Params 1
// Checksum 0xeb5cab41, Offset: 0x9f8
// Size: 0x366
function updateweapontimings( newtime )
{
    if ( self util::is_bot() )
    {
        return;
    }
    
    updatelastheldweapontimings( newtime );
    
    if ( !isdefined( self.staticweaponsstarttime ) )
    {
        return;
    }
    
    totaltime = int( ( newtime - self.staticweaponsstarttime ) / 1000 );
    
    if ( totaltime < 0 )
    {
        return;
    }
    
    self.staticweaponsstarttime = newtime;
    
    if ( isdefined( self.weapon_array_grenade ) )
    {
        for ( i = 0; i < self.weapon_array_grenade.size ; i++ )
        {
            self addweaponstat( self.weapon_array_grenade[ i ], "timeUsed", totaltime );
        }
    }
    
    if ( isdefined( self.weapon_array_inventory ) )
    {
        for ( i = 0; i < self.weapon_array_inventory.size ; i++ )
        {
            self addweaponstat( self.weapon_array_inventory[ i ], "timeUsed", totaltime );
        }
    }
    
    if ( isdefined( self.killstreak ) )
    {
        for ( i = 0; i < self.killstreak.size ; i++ )
        {
            killstreakweapon = level.menureferenceforkillstreak[ self.killstreak[ i ] ];
            
            if ( isdefined( killstreakweapon ) )
            {
                self addweaponstat( killstreakweapon, "timeUsed", totaltime );
            }
        }
    }
    
    if ( level.rankedmatch && level.perksenabled )
    {
        perksindexarray = [];
        specialtys = self.specialty;
        
        if ( !isdefined( specialtys ) )
        {
            return;
        }
        
        if ( !isdefined( self.curclass ) )
        {
            return;
        }
        
        if ( isdefined( self.class_num ) )
        {
            for ( numspecialties = 0; numspecialties < level.maxspecialties ; numspecialties++ )
            {
                perk = self getloadoutitem( self.class_num, "specialty" + numspecialties + 1 );
                
                if ( perk != 0 )
                {
                    perksindexarray[ perk ] = 1;
                }
            }
            
            perkindexarraykeys = getarraykeys( perksindexarray );
            
            for ( i = 0; i < perkindexarraykeys.size ; i++ )
            {
                if ( perksindexarray[ perkindexarraykeys[ i ] ] == 1 )
                {
                    self adddstat( "itemStats", perkindexarraykeys[ i ], "stats", "timeUsed", "statValue", totaltime );
                }
            }
        }
    }
}

// Namespace weapons
// Params 0
// Checksum 0xa71b6ba8, Offset: 0xd68
// Size: 0x19a
function trackweapon()
{
    currentweapon = self getcurrentweapon();
    currenttime = gettime();
    spawnid = getplayerspawnid( self );
    
    while ( true )
    {
        event = self util::waittill_any_return( "weapon_change", "death", "disconnect" );
        newtime = gettime();
        
        if ( event == "weapon_change" )
        {
            self bb::commit_weapon_data( spawnid, currentweapon, currenttime );
            newweapon = self getcurrentweapon();
            
            if ( newweapon != level.weaponnone && newweapon != currentweapon )
            {
                updatelastheldweapontimings( newtime );
                currentweapon = newweapon;
                currenttime = newtime;
            }
            
            continue;
        }
        
        if ( event != "disconnect" )
        {
            self bb::commit_weapon_data( spawnid, currentweapon, currenttime );
            updateweapontimings( newtime );
        }
        
        return;
    }
}

// Namespace weapons
// Params 1
// Checksum 0xc01de2f7, Offset: 0xf10
// Size: 0x4e, Type: bool
function maydropweapon( weapon )
{
    if ( level.disableweapondrop == 1 )
    {
        return false;
    }
    
    if ( weapon == level.weaponnone )
    {
        return false;
    }
    
    if ( !weapon.isprimary )
    {
        return false;
    }
    
    return true;
}

// Namespace weapons
// Params 1
// Checksum 0x173d27eb, Offset: 0xf68
// Size: 0x414
function dropweaponfordeath( attacker )
{
    if ( level.disableweapondrop == 1 )
    {
        return;
    }
    
    weapon = self.lastdroppableweapon;
    
    if ( isdefined( self.droppeddeathweapon ) )
    {
        return;
    }
    
    if ( !isdefined( weapon ) )
    {
        /#
            if ( getdvarstring( "<dev string:x28>" ) == "<dev string:x36>" )
            {
                println( "<dev string:x38>" );
            }
        #/
        
        return;
    }
    
    if ( weapon == level.weaponnone )
    {
        /#
            if ( getdvarstring( "<dev string:x28>" ) == "<dev string:x36>" )
            {
                println( "<dev string:x58>" );
            }
        #/
        
        return;
    }
    
    if ( !self hasweapon( weapon ) )
    {
        /#
            if ( getdvarstring( "<dev string:x28>" ) == "<dev string:x36>" )
            {
                println( "<dev string:x7b>" + weapon.name + "<dev string:xa7>" );
            }
        #/
        
        return;
    }
    
    if ( !self anyammoforweaponmodes( weapon ) )
    {
        /#
            if ( getdvarstring( "<dev string:x28>" ) == "<dev string:x36>" )
            {
                println( "<dev string:xa9>" );
            }
        #/
        
        return;
    }
    
    if ( !shoulddroplimitedweapon( weapon, self ) )
    {
        return;
    }
    
    clipammo = self getweaponammoclip( weapon );
    stockammo = self getweaponammostock( weapon );
    clip_and_stock_ammo = clipammo + stockammo;
    
    if ( !clip_and_stock_ammo )
    {
        /#
            if ( getdvarstring( "<dev string:x28>" ) == "<dev string:x36>" )
            {
                println( "<dev string:xd6>" );
            }
        #/
        
        return;
    }
    
    stockmax = weapon.maxammo;
    
    if ( stockammo > stockmax )
    {
        stockammo = stockmax;
    }
    
    item = self dropitem( weapon );
    
    if ( !isdefined( item ) )
    {
        /#
            iprintlnbold( "<dev string:xf2>" + weapon.name );
        #/
        
        return;
    }
    
    /#
        if ( getdvarstring( "<dev string:x28>" ) == "<dev string:x36>" )
        {
            println( "<dev string:x119>" + weapon.name );
        }
    #/
    
    droplimitedweapon( weapon, self, item );
    self.droppeddeathweapon = 1;
    item itemweaponsetammo( clipammo, stockammo );
    item.owner = self;
    item.ownersattacker = attacker;
    item thread watchpickup();
    item thread deletepickupafterawhile();
}

// Namespace weapons
// Params 0
// Checksum 0x1a924208, Offset: 0x1388
// Size: 0x34
function deletepickupafterawhile()
{
    self endon( #"death" );
    wait 60;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self delete();
}

// Namespace weapons
// Params 0
// Checksum 0xb39150d, Offset: 0x13c8
// Size: 0x280
function watchpickup()
{
    self endon( #"death" );
    weapon = self.item;
    
    while ( true )
    {
        self waittill( #"trigger", player, droppeditem );
        
        if ( isdefined( droppeditem ) )
        {
            break;
        }
    }
    
    /#
        if ( getdvarstring( "<dev string:x28>" ) == "<dev string:x36>" )
        {
            println( "<dev string:x12a>" + weapon.name + "<dev string:x13d>" + isdefined( self.ownersattacker ) );
        }
    #/
    
    assert( isdefined( player.tookweaponfrom ) );
    assert( isdefined( player.pickedupweaponkills ) );
    
    if ( isdefined( droppeditem ) )
    {
        for ( i = 0; i < droppeditem.size ; i++ )
        {
            if ( !isdefined( droppeditem[ i ] ) )
            {
                continue;
            }
            
            droppedweapon = droppeditem[ i ].item;
            
            if ( isdefined( player.tookweaponfrom[ droppedweapon ] ) )
            {
                droppeditem[ i ].owner = player.tookweaponfrom[ droppedweapon ];
                droppeditem[ i ].ownersattacker = player;
                player.tookweaponfrom[ droppedweapon ] = undefined;
            }
            
            droppeditem[ i ] thread watchpickup();
        }
    }
    
    if ( isdefined( self.ownersattacker ) && self.ownersattacker == player )
    {
        player.tookweaponfrom[ weapon ] = self.owner;
        player.pickedupweaponkills[ weapon ] = 0;
        return;
    }
    
    player.tookweaponfrom[ weapon ] = undefined;
    player.pickedupweaponkills[ weapon ] = undefined;
}

// Namespace weapons
// Params 0
// Checksum 0xad16d980, Offset: 0x1650
// Size: 0x20e
function watchweaponusage()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self.usedkillstreakweapon = [];
    self.usedkillstreakweapon[ "minigun" ] = 0;
    self.usedkillstreakweapon[ "m32" ] = 0;
    self.usedkillstreakweapon[ "m202_flash" ] = 0;
    self.usedkillstreakweapon[ "m220_tow" ] = 0;
    self.usedkillstreakweapon[ "mp40_blinged" ] = 0;
    self.killstreaktype = [];
    self.killstreaktype[ "minigun" ] = "minigun";
    self.killstreaktype[ "m32" ] = "m32";
    self.killstreaktype[ "m202_flash" ] = "m202_flash";
    self.killstreaktype[ "m220_tow" ] = "m220_tow";
    self.killstreaktype[ "mp40_blinged" ] = "mp40_blinged_drop";
    
    for ( ;; )
    {
        self waittill( #"weapon_fired", curweapon );
        self.lastfiretime = gettime();
        self.hasdonecombat = 1;
        
        switch ( curweapon.weapclass )
        {
            case "mg":
            case "pistol":
            case "rifle":
            case "smg":
            case "spread":
                self trackweaponfire( curweapon );
                level.globalshotsfired++;
                break;
            case "grenade":
            case "rocketlauncher":
                self addweaponstat( curweapon, "shots", 1 );
                break;
            default:
                break;
        }
    }
}

// Namespace weapons
// Params 1
// Checksum 0xbc14f341, Offset: 0x1868
// Size: 0x2d4
function trackweaponfire( curweapon )
{
    shotsfired = 1;
    
    if ( isdefined( self.laststandparams ) && self.laststandparams.laststandstarttime == gettime() )
    {
        self.hits = 0;
        return;
    }
    
    pixbeginevent( "trackWeaponFire" );
    misses = int( max( 0, shotsfired - self.hits ) );
    self addweaponstat( curweapon, "shots", shotsfired );
    self addweaponstat( curweapon, "hits", self.hits );
    self addweaponstat( curweapon, "misses", misses );
    
    if ( isdefined( level.add_client_stat ) )
    {
        self [[ level.add_client_stat ]]( "total_shots", shotsfired );
        self [[ level.add_client_stat ]]( "hits", self.hits );
        self [[ level.add_client_stat ]]( "misses", misses );
    }
    else
    {
        self addplayerstat( "total_shots", shotsfired );
        self addplayerstat( "hits", self.hits );
        self addplayerstat( "misses", misses );
    }
    
    self incrementplayerstat( "total_shots", shotsfired );
    self incrementplayerstat( "hits", self.hits );
    self incrementplayerstat( "misses", misses );
    self bb::add_to_stat( "shots", shotsfired );
    self bb::add_to_stat( "hits", self.hits );
    self bb::add_to_stat( "misses", misses );
    self.hits = 0;
    pixendevent();
}

// Namespace weapons
// Params 0
// Checksum 0x93ea0a08, Offset: 0x1b48
// Size: 0x150
function watchgrenadeusage()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self.throwinggrenade = 0;
    self.gotpullbacknotify = 0;
    self thread beginothergrenadetracking();
    self thread watchforthrowbacks();
    self thread watchforgrenadeduds();
    self thread watchforgrenadelauncherduds();
    
    for ( ;; )
    {
        self waittill( #"grenade_pullback", weapon );
        self addweaponstat( weapon, "shots", 1 );
        self.hasdonecombat = 1;
        self.throwinggrenade = 1;
        self.gotpullbacknotify = 1;
        
        if ( weapon.drawoffhandmodelinhand )
        {
            self setoffhandvisible( 1 );
            self thread watch_offhand_end();
        }
        
        self thread begingrenadetracking();
    }
}

// Namespace weapons
// Params 0
// Checksum 0x6a6353d5, Offset: 0x1ca0
// Size: 0xc0
function watchmissileusage()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    for ( ;; )
    {
        self waittill( #"missile_fire", missile, weapon );
        self.hasdonecombat = 1;
        assert( isdefined( missile ) );
        level.missileentities[ level.missileentities.size ] = missile;
        missile.weapon = weapon;
        missile thread watchmissiledeath();
    }
}

// Namespace weapons
// Params 0
// Checksum 0xc25b5985, Offset: 0x1d68
// Size: 0x2c
function watchmissiledeath()
{
    self waittill( #"death" );
    arrayremovevalue( level.missileentities, self );
}

// Namespace weapons
// Params 2
// Checksum 0x763d29b0, Offset: 0x1da0
// Size: 0x112
function dropweaponstoground( origin, radius )
{
    weapons = getdroppedweapons();
    
    for ( i = 0; i < weapons.size ; i++ )
    {
        if ( distancesquared( origin, weapons[ i ].origin ) < radius * radius )
        {
            trace = bullettrace( weapons[ i ].origin, weapons[ i ].origin + ( 0, 0, -2000 ), 0, weapons[ i ] );
            weapons[ i ].origin = trace[ "position" ];
        }
    }
}

// Namespace weapons
// Params 2
// Checksum 0x3e415c7f, Offset: 0x1ec0
// Size: 0xce
function dropgrenadestoground( origin, radius )
{
    grenades = getentarray( "grenade", "classname" );
    
    for ( i = 0; i < grenades.size ; i++ )
    {
        if ( distancesquared( origin, grenades[ i ].origin ) < radius * radius )
        {
            grenades[ i ] launch( ( 5, 5, 5 ) );
        }
    }
}

// Namespace weapons
// Params 0
// Checksum 0xab70a74b, Offset: 0x1f98
// Size: 0x94
function watchgrenadecancel()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"grenade_fire" );
    waittillframeend();
    weapon = level.weaponnone;
    
    while ( self isthrowinggrenade() && weapon == level.weaponnone )
    {
        self waittill( #"weapon_change", weapon );
    }
    
    self.throwinggrenade = 0;
    self.gotpullbacknotify = 0;
}

// Namespace weapons
// Params 0
// Checksum 0x31529b14, Offset: 0x2038
// Size: 0xbc
function watch_offhand_end()
{
    self notify( #"watchoffhandend" );
    self endon( #"watchoffhandend" );
    
    while ( self is_using_offhand_equipment() )
    {
        msg = self util::waittill_any_return( "death", "disconnect", "grenade_fire", "weapon_change", "watchOffhandEnd" );
        
        if ( msg == "death" || msg == "disconnect" )
        {
            break;
        }
    }
    
    self setoffhandvisible( 0 );
}

// Namespace weapons
// Params 0
// Checksum 0x7b54b542, Offset: 0x2100
// Size: 0x5a, Type: bool
function is_using_offhand_equipment()
{
    if ( self isusingoffhand() )
    {
        weapon = self getcurrentoffhand();
        
        if ( weapon.isequipment )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace weapons
// Params 0
// Checksum 0x656ba655, Offset: 0x2168
// Size: 0x160
function begingrenadetracking()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    starttime = gettime();
    self thread watchgrenadecancel();
    self waittill( #"grenade_fire", grenade, weapon );
    
    if ( !isdefined( grenade ) )
    {
        return;
    }
    
    level.missileentities[ level.missileentities.size ] = grenade;
    grenade.weapon = weapon;
    grenade thread watchmissiledeath();
    
    if ( grenade util::ishacked() )
    {
        return;
    }
    
    if ( gettime() - starttime > 1000 )
    {
        grenade.iscooked = 1;
    }
    
    switch ( weapon.name )
    {
        case "frag_grenade":
        default:
            self addweaponstat( weapon, "used", 1 );
        case "explosive_bolt":
            grenade.originalowner = self;
            break;
    }
    
    self.throwinggrenade = 0;
}

// Namespace weapons
// Params 0
// Checksum 0x99ec1590, Offset: 0x22d0
// Size: 0x4
function beginothergrenadetracking()
{
    
}

// Namespace weapons
// Params 3
// Checksum 0xd2e200b8, Offset: 0x22e0
// Size: 0xac
function checkstucktoplayer( deleteonteamchange, awardscoreevent, weapon )
{
    self endon( #"death" );
    self waittill( #"stuck_to_player", player );
    
    if ( isdefined( player ) )
    {
        if ( deleteonteamchange )
        {
            self thread stucktoplayerteamchange( player );
        }
        
        if ( awardscoreevent && isdefined( self.originalowner ) )
        {
            if ( self.originalowner util::isenemyplayer( player ) )
            {
            }
        }
        
        self.stucktoplayer = player;
    }
}

// Namespace weapons
// Params 0
// Checksum 0x1f721b2e, Offset: 0x2398
// Size: 0x34
function checkhatchetbounce()
{
    self endon( #"stuck_to_player" );
    self endon( #"death" );
    self waittill( #"grenade_bounce" );
    self.bounced = 1;
}

// Namespace weapons
// Params 1
// Checksum 0xd6a97969, Offset: 0x23d8
// Size: 0x9a
function stucktoplayerteamchange( player )
{
    self endon( #"death" );
    player endon( #"disconnect" );
    originalteam = player.pers[ "team" ];
    
    while ( true )
    {
        player waittill( #"joined_team" );
        
        if ( player.pers[ "team" ] != originalteam )
        {
            self detonate();
            return;
        }
    }
}

// Namespace weapons
// Params 0
// Checksum 0xce5f43d4, Offset: 0x2480
// Size: 0xa8
function watchforthrowbacks()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    for ( ;; )
    {
        self waittill( #"grenade_fire", grenade, weapon );
        
        if ( self.gotpullbacknotify )
        {
            self.gotpullbacknotify = 0;
            continue;
        }
        
        if ( !issubstr( weapon.name, "frag_" ) )
        {
            continue;
        }
        
        grenade.threwback = 1;
        grenade.originalowner = self;
    }
}

// Namespace weapons
// Params 4
// Checksum 0xdb3c89c, Offset: 0x2530
// Size: 0x134
function registergrenadelauncherduddvar( dvarstring, defaultvalue, minvalue, maxvalue )
{
    dvarstring = "scr_" + dvarstring + "_grenadeLauncherDudTime";
    
    if ( getdvarstring( dvarstring ) == "" )
    {
        setdvar( dvarstring, defaultvalue );
    }
    
    if ( getdvarint( dvarstring ) > maxvalue )
    {
        setdvar( dvarstring, maxvalue );
    }
    else if ( getdvarint( dvarstring ) < minvalue )
    {
        setdvar( dvarstring, minvalue );
    }
    
    level.grenadelauncherdudtimedvar = dvarstring;
    level.grenadelauncherdudtimemin = minvalue;
    level.grenadelauncherdudtimemax = maxvalue;
    level.grenadelauncherdudtime = getdvarint( level.grenadelauncherdudtimedvar );
}

// Namespace weapons
// Params 4
// Checksum 0xc6df581e, Offset: 0x2670
// Size: 0x134
function registerthrowngrenadeduddvar( dvarstring, defaultvalue, minvalue, maxvalue )
{
    dvarstring = "scr_" + dvarstring + "_thrownGrenadeDudTime";
    
    if ( getdvarstring( dvarstring ) == "" )
    {
        setdvar( dvarstring, defaultvalue );
    }
    
    if ( getdvarint( dvarstring ) > maxvalue )
    {
        setdvar( dvarstring, maxvalue );
    }
    else if ( getdvarint( dvarstring ) < minvalue )
    {
        setdvar( dvarstring, minvalue );
    }
    
    level.throwngrenadedudtimedvar = dvarstring;
    level.throwngrenadedudtimemin = minvalue;
    level.throwngrenadedudtimemax = maxvalue;
    level.throwngrenadedudtime = getdvarint( level.throwngrenadedudtimedvar );
}

// Namespace weapons
// Params 4
// Checksum 0x3df6de2, Offset: 0x27b0
// Size: 0x10c
function registerkillstreakdelay( dvarstring, defaultvalue, minvalue, maxvalue )
{
    dvarstring = "scr_" + dvarstring + "_killstreakDelayTime";
    
    if ( getdvarstring( dvarstring ) == "" )
    {
        setdvar( dvarstring, defaultvalue );
    }
    
    if ( getdvarint( dvarstring ) > maxvalue )
    {
        setdvar( dvarstring, maxvalue );
    }
    else if ( getdvarint( dvarstring ) < minvalue )
    {
        setdvar( dvarstring, minvalue );
    }
    
    level.killstreakrounddelay = getdvarint( dvarstring );
}

// Namespace weapons
// Params 3
// Checksum 0xd6353515, Offset: 0x28c8
// Size: 0x15c
function turngrenadeintoadud( weapon, isthrowngrenade, player )
{
    if ( level.roundstartexplosivedelay >= globallogic_utils::gettimepassed() / 1000 )
    {
        if ( weapon.disallowatmatchstart || weaponhasattachment( weapon, "gl" ) )
        {
            timeleft = int( level.roundstartexplosivedelay - globallogic_utils::gettimepassed() / 1000 );
            
            if ( !timeleft )
            {
                timeleft = 1;
            }
            
            if ( isthrowngrenade )
            {
                player iprintlnbold( &"MP_GRENADE_UNAVAILABLE_FOR_N", " " + timeleft + " ", &"EXE_SECONDS" );
            }
            else
            {
                player iprintlnbold( &"MP_LAUNCHER_UNAVAILABLE_FOR_N", " " + timeleft + " ", &"EXE_SECONDS" );
            }
            
            self makegrenadedud();
        }
    }
}

// Namespace weapons
// Params 0
// Checksum 0x26d9d892, Offset: 0x2a30
// Size: 0x70
function watchforgrenadeduds()
{
    self endon( #"spawned_player" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"grenade_fire", grenade, weapon );
        grenade turngrenadeintoadud( weapon, 1, self );
    }
}

// Namespace weapons
// Params 0
// Checksum 0xfab2d8d0, Offset: 0x2aa8
// Size: 0xc8
function watchforgrenadelauncherduds()
{
    self endon( #"spawned_player" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"grenade_launcher_fire", grenade, weapon );
        grenade turngrenadeintoadud( weapon, 0, self );
        assert( isdefined( grenade ) );
        level.missileentities[ level.missileentities.size ] = grenade;
        grenade.weapon = weapon;
        grenade thread watchmissiledeath();
    }
}

// Namespace weapons
// Params 4
// Checksum 0xfe62f375, Offset: 0x2b78
// Size: 0x658
function getdamageableents( pos, radius, dolos, startradius )
{
    ents = [];
    
    if ( !isdefined( dolos ) )
    {
        dolos = 0;
    }
    
    if ( !isdefined( startradius ) )
    {
        startradius = 0;
    }
    
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( !isalive( players[ i ] ) || players[ i ].sessionstate != "playing" )
        {
            continue;
        }
        
        playerpos = players[ i ].origin + ( 0, 0, 32 );
        distsq = distancesquared( pos, playerpos );
        
        if ( !dolos || distsq < radius * radius && weapondamagetracepassed( pos, playerpos, startradius, undefined ) )
        {
            newent = spawnstruct();
            newent.isplayer = 1;
            newent.isadestructable = 0;
            newent.isadestructible = 0;
            newent.isactor = 0;
            newent.entity = players[ i ];
            newent.damagecenter = playerpos;
            ents[ ents.size ] = newent;
        }
    }
    
    grenades = getentarray( "grenade", "classname" );
    
    for ( i = 0; i < grenades.size ; i++ )
    {
        entpos = grenades[ i ].origin;
        distsq = distancesquared( pos, entpos );
        
        if ( !dolos || distsq < radius * radius && weapondamagetracepassed( pos, entpos, startradius, grenades[ i ] ) )
        {
            newent = spawnstruct();
            newent.isplayer = 0;
            newent.isadestructable = 0;
            newent.isadestructible = 0;
            newent.isactor = 0;
            newent.entity = grenades[ i ];
            newent.damagecenter = entpos;
            ents[ ents.size ] = newent;
        }
    }
    
    destructibles = getentarray( "destructible", "targetname" );
    
    for ( i = 0; i < destructibles.size ; i++ )
    {
        entpos = destructibles[ i ].origin;
        distsq = distancesquared( pos, entpos );
        
        if ( !dolos || distsq < radius * radius && weapondamagetracepassed( pos, entpos, startradius, destructibles[ i ] ) )
        {
            newent = spawnstruct();
            newent.isplayer = 0;
            newent.isadestructable = 0;
            newent.isadestructible = 1;
            newent.isactor = 0;
            newent.entity = destructibles[ i ];
            newent.damagecenter = entpos;
            ents[ ents.size ] = newent;
        }
    }
    
    destructables = getentarray( "destructable", "targetname" );
    
    for ( i = 0; i < destructables.size ; i++ )
    {
        entpos = destructables[ i ].origin;
        distsq = distancesquared( pos, entpos );
        
        if ( !dolos || distsq < radius * radius && weapondamagetracepassed( pos, entpos, startradius, destructables[ i ] ) )
        {
            newent = spawnstruct();
            newent.isplayer = 0;
            newent.isadestructable = 1;
            newent.isadestructible = 0;
            newent.isactor = 0;
            newent.entity = destructables[ i ];
            newent.damagecenter = entpos;
            ents[ ents.size ] = newent;
        }
    }
    
    return ents;
}

// Namespace weapons
// Params 7
// Checksum 0x6780bc4e, Offset: 0x31d8
// Size: 0x19c
function damageent( einflictor, eattacker, idamage, smeansofdeath, weapon, damagepos, damagedir )
{
    if ( self.isplayer )
    {
        self.damageorigin = damagepos;
        self.entity thread [[ level.callbackplayerdamage ]]( einflictor, eattacker, idamage, 0, smeansofdeath, weapon, damagepos, damagedir, "none", damagepos, 0, 0, ( 1, 0, 0 ) );
        return;
    }
    
    if ( self.isactor )
    {
        self.damageorigin = damagepos;
        self.entity thread [[ level.callbackactordamage ]]( einflictor, eattacker, idamage, 0, smeansofdeath, weapon, damagepos, damagedir, "none", damagepos, 0, 0, 0, ( 1, 0, 0 ) );
        return;
    }
    
    if ( self.isadestructible )
    {
        self.damageorigin = damagepos;
        self.entity dodamage( idamage, damagepos, eattacker, einflictor, 0, smeansofdeath, 0, weapon );
        return;
    }
    
    self.entity util::damage_notify_wrapper( idamage, eattacker, ( 0, 0, 0 ), ( 0, 0, 0 ), "mod_explosive", "", "" );
}

/#

    // Namespace weapons
    // Params 3
    // Checksum 0x74ea9136, Offset: 0x3380
    // Size: 0x6e, Type: dev
    function debugline( a, b, color )
    {
        for ( i = 0; i < 600 ; i++ )
        {
            line( a, b, color );
            wait 0.05;
        }
    }

#/

// Namespace weapons
// Params 5
// Checksum 0xeb3d34ec, Offset: 0x33f8
// Size: 0x1f2
function onweapondamage( eattacker, einflictor, weapon, meansofdeath, damage )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    switch ( weapon.name )
    {
        case "concussion_grenade":
            radius = 512;
            
            if ( self == eattacker )
            {
                radius *= 0.5;
            }
            
            scale = 1 - distance( self.origin, einflictor.origin ) / radius;
            
            if ( scale < 0 )
            {
                scale = 0;
            }
            
            time = 2 + 4 * scale;
            wait 0.05;
            
            if ( self hasperk( "specialty_stunprotection" ) )
            {
                time *= 0.1;
            }
            
            self thread playconcussionsound( time );
            
            if ( self util::mayapplyscreeneffect() )
            {
                self shellshock( "concussion_grenade_mp", time, 0 );
            }
            
            self.concussionendtime = gettime() + time * 1000;
            break;
        default:
            if ( isdefined( level.shellshockonplayerdamage ) )
            {
                [[ level.shellshockonplayerdamage ]]( meansofdeath, damage, weapon );
            }
            
            break;
    }
}

// Namespace weapons
// Params 1
// Checksum 0xe6198bd8, Offset: 0x35f8
// Size: 0x154
function playconcussionsound( duration )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    concussionsound = spawn( "script_origin", ( 0, 0, 1 ) );
    concussionsound.origin = self.origin;
    concussionsound linkto( self );
    concussionsound thread deleteentonownerdeath( self );
    concussionsound playsound( "" );
    concussionsound playloopsound( "" );
    
    if ( duration > 0.5 )
    {
        wait duration - 0.5;
    }
    
    concussionsound playsound( "" );
    concussionsound stoploopsound( 0.5 );
    wait 0.5;
    concussionsound notify( #"delete" );
    concussionsound delete();
}

// Namespace weapons
// Params 1
// Checksum 0x49a36ea3, Offset: 0x3758
// Size: 0x3c
function deleteentonownerdeath( owner )
{
    self endon( #"delete" );
    owner waittill( #"death" );
    self delete();
}

// Namespace weapons
// Params 0
// Checksum 0xf56d828c, Offset: 0x37a0
// Size: 0x2d0
function updatestowedweapon()
{
    self endon( #"spawned" );
    self endon( #"killed_player" );
    self endon( #"disconnect" );
    self.tag_stowed_back = undefined;
    self.tag_stowed_hip = undefined;
    team = self.pers[ "team" ];
    curclass = self.pers[ "class" ];
    
    while ( true )
    {
        self waittill( #"weapon_change", newweapon );
        self.weapon_array_primary = [];
        self.weapon_array_sidearm = [];
        self.weapon_array_grenade = [];
        self.weapon_array_inventory = [];
        weaponslist = self getweaponslist();
        
        for ( idx = 0; idx < weaponslist.size ; idx++ )
        {
            switch ( weaponslist[ idx ] )
            {
                case "m202_flash":
                case "m220_tow":
                case "m32":
                case "minigun":
                case "mp40_blinged":
                case "zipline":
                    continue;
                default:
                    break;
            }
            
            if ( is_primary_weapon( weaponslist[ idx ] ) )
            {
                self.weapon_array_primary[ self.weapon_array_primary.size ] = weaponslist[ idx ];
                continue;
            }
            
            if ( is_side_arm( weaponslist[ idx ] ) )
            {
                self.weapon_array_sidearm[ self.weapon_array_sidearm.size ] = weaponslist[ idx ];
                continue;
            }
            
            if ( is_grenade( weaponslist[ idx ] ) )
            {
                self.weapon_array_grenade[ self.weapon_array_grenade.size ] = weaponslist[ idx ];
                continue;
            }
            
            if ( is_inventory( weaponslist[ idx ] ) )
            {
                self.weapon_array_inventory[ self.weapon_array_inventory.size ] = weaponslist[ idx ];
                continue;
            }
            
            if ( weaponslist[ idx ].isprimary )
            {
                self.weapon_array_primary[ self.weapon_array_primary.size ] = weaponslist[ idx ];
            }
        }
        
        detach_all_weapons();
        stow_on_back();
        stow_on_hip();
    }
}

// Namespace weapons
// Params 0
// Checksum 0x60a4e475, Offset: 0x3a78
// Size: 0xd2
function loadout_get_class_num()
{
    assert( isplayer( self ) );
    assert( isdefined( self.curclass ) );
    
    if ( isdefined( level.classtoclassnum[ self.curclass ] ) )
    {
        return level.classtoclassnum[ self.curclass ];
    }
    
    class_num = int( self.curclass[ self.curclass.size - 1 ] ) - 1;
    
    if ( -1 == class_num )
    {
        class_num = 9;
    }
    
    return class_num;
}

// Namespace weapons
// Params 1
// Checksum 0xba56357c, Offset: 0x3b58
// Size: 0xb2
function loadout_get_offhand_weapon( stat )
{
    if ( isdefined( level.givecustomloadout ) )
    {
        return level.weaponnone;
    }
    
    class_num = self loadout_get_class_num();
    index = 0;
    
    if ( isdefined( level.tbl_weaponids[ index ] ) && isdefined( level.tbl_weaponids[ index ][ "reference" ] ) )
    {
        return getweapon( level.tbl_weaponids[ index ][ "reference" ] );
    }
    
    return level.weaponnone;
}

// Namespace weapons
// Params 1
// Checksum 0x6403b9b7, Offset: 0x3c18
// Size: 0x54
function loadout_get_offhand_count( stat )
{
    if ( isdefined( level.givecustomloadout ) )
    {
        return 0;
    }
    
    class_num = self loadout_get_class_num();
    count = 0;
    return count;
}

// Namespace weapons
// Params 0
// Checksum 0x152f223c, Offset: 0x3c78
// Size: 0x81e
function scavenger_think()
{
    self endon( #"death" );
    self waittill( #"scavenger", player );
    primary_weapons = player getweaponslistprimaries();
    offhand_weapons_and_alts = array::exclude( player getweaponslist( 1 ), primary_weapons );
    arrayremovevalue( offhand_weapons_and_alts, level.weaponbasemelee );
    player playsound( "wpn_ammo_pickup" );
    player playlocalsound( "wpn_ammo_pickup" );
    player.scavenger_icon.alpha = 1;
    player.scavenger_icon fadeovertime( 2.5 );
    player.scavenger_icon.alpha = 0;
    scavenger_lethal_proc = 1;
    scavenger_tactical_proc = 1;
    
    if ( !isdefined( player.scavenger_lethal_proc ) )
    {
        player.scavenger_lethal_proc = 0;
        player.scavenger_tactical_proc = 0;
    }
    
    loadout_primary = player loadout_get_offhand_weapon( "primarygrenade" );
    loadout_primary_count = player loadout_get_offhand_count( "primarygrenadecount" );
    loadout_secondary = player loadout_get_offhand_weapon( "specialgrenade" );
    loadout_secondary_count = player loadout_get_offhand_count( "specialgrenadeCount" );
    
    for ( i = 0; i < offhand_weapons_and_alts.size ; i++ )
    {
        weapon = offhand_weapons_and_alts[ i ];
        
        if ( !weapon.isscavengable )
        {
            continue;
        }
        
        switch ( weapon.name )
        {
            case "bouncingbetty":
            case "claymore":
            case "frag_grenade":
            case "hatchet":
            case "satchel_charge":
            case "sticky_grenade":
                if ( isdefined( player.grenadetypeprimarycount ) && player.grenadetypeprimarycount < 1 )
                {
                    break;
                }
                
                if ( player getweaponammostock( weapon ) != loadout_primary_count )
                {
                    if ( player.scavenger_lethal_proc < scavenger_lethal_proc )
                    {
                        player.scavenger_lethal_proc++;
                        break;
                    }
                    
                    player.scavenger_lethal_proc = 0;
                    player.scavenger_tactical_proc = 0;
                }
            case "concussion_grenade":
            case "emp_grenade":
            case "flash_grenade":
            case "nightingale":
            case "pda_hack":
            case "proximity_grenade":
            case "sensor_grenade":
            case "tabun_gas":
            case "trophy_system":
            case "willy_pete":
                if ( isdefined( player.grenadetypesecondarycount ) && player.grenadetypesecondarycount < 1 )
                {
                    break;
                }
                
                if ( weapon == loadout_secondary && player getweaponammostock( weapon ) != loadout_secondary_count )
                {
                    if ( player.scavenger_tactical_proc < scavenger_tactical_proc )
                    {
                        player.scavenger_tactical_proc++;
                        break;
                    }
                    
                    player.scavenger_tactical_proc = 0;
                    player.scavenger_lethal_proc = 0;
                }
                
                maxammo = weapon.maxammo;
                stock = player getweaponammostock( weapon );
                
                if ( isdefined( level.customloadoutscavenge ) )
                {
                    maxammo = self [[ level.customloadoutscavenge ]]( weapon );
                }
                else if ( weapon == loadout_primary )
                {
                    maxammo = loadout_primary_count;
                }
                else if ( weapon == loadout_secondary )
                {
                    maxammo = loadout_secondary_count;
                }
                
                if ( stock < maxammo )
                {
                    ammo = stock + 1;
                    
                    if ( ammo > maxammo )
                    {
                        ammo = maxammo;
                    }
                    
                    player setweaponammostock( weapon, ammo );
                    player thread challenges::scavengedgrenade();
                }
                
                break;
            default:
                if ( weapon.islauncherweapon )
                {
                    stock = player getweaponammostock( weapon );
                    start = player getfractionstartammo( weapon );
                    clip = weapon.clipsize;
                    clip *= getdvarfloat( "scavenger_clip_multiplier", 2 );
                    clip = int( clip );
                    maxammo = weapon.maxammo;
                    
                    if ( stock < maxammo - clip )
                    {
                        ammo = stock + clip;
                        player setweaponammostock( weapon, ammo );
                    }
                    else
                    {
                        player setweaponammostock( weapon, maxammo );
                    }
                }
                
                break;
        }
    }
    
    for ( i = 0; i < primary_weapons.size ; i++ )
    {
        weapon = primary_weapons[ i ];
        
        if ( !weapon.isscavengable )
        {
            continue;
        }
        
        stock = player getweaponammostock( weapon );
        start = player getfractionstartammo( weapon );
        clip = weapon.clipsize;
        clip *= getdvarfloat( "scavenger_clip_multiplier", 2 );
        clip = int( clip );
        maxammo = weapon.maxammo;
        
        if ( stock < maxammo - clip )
        {
            ammo = stock + clip;
            player setweaponammostock( weapon, ammo );
            continue;
        }
        
        player setweaponammostock( weapon, maxammo );
    }
}

// Namespace weapons
// Params 0
// Checksum 0xdce600ba, Offset: 0x44a0
// Size: 0x15c
function scavenger_hud_create()
{
    if ( level.wagermatch )
    {
        return;
    }
    
    self.scavenger_icon = newclienthudelem( self );
    self.scavenger_icon.horzalign = "center";
    self.scavenger_icon.vertalign = "middle";
    self.scavenger_icon.x = -16;
    self.scavenger_icon.y = 16;
    self.scavenger_icon.alpha = 0;
    width = 32;
    height = 16;
    
    if ( self issplitscreen() )
    {
        width = int( width * 0.5 );
        height = int( height * 0.5 );
        self.scavenger_icon.x = -8;
    }
    
    self.scavenger_icon setshader( "hud_scavenger_pickup", width, height );
}

// Namespace weapons
// Params 1
// Checksum 0x9d59fcf1, Offset: 0x4608
// Size: 0xd4
function dropscavengerfordeath( attacker )
{
    if ( sessionmodeiszombiesgame() )
    {
        return;
    }
    
    if ( level.wagermatch )
    {
        return;
    }
    
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    if ( attacker == self )
    {
        return;
    }
    
    if ( level.gametype == "hack" )
    {
        item = self dropscavengeritem( getweapon( "scavenger_item_hack" ) );
    }
    else
    {
        item = self dropscavengeritem( getweapon( "scavenger_item" ) );
    }
    
    item thread scavenger_think();
}

// Namespace weapons
// Params 3
// Checksum 0x81442634, Offset: 0x46e8
// Size: 0x74
function addlimitedweapon( weapon, owner, num_drops )
{
    limited_info = spawnstruct();
    limited_info.weapon = weapon;
    limited_info.drops = num_drops;
    owner.limited_info = limited_info;
}

// Namespace weapons
// Params 2
// Checksum 0x4f665679, Offset: 0x4768
// Size: 0x7a, Type: bool
function shoulddroplimitedweapon( weapon, owner )
{
    limited_info = owner.limited_info;
    
    if ( !isdefined( limited_info ) )
    {
        return true;
    }
    
    if ( limited_info.weapon != weapon )
    {
        return true;
    }
    
    if ( limited_info.drops <= 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace weapons
// Params 3
// Checksum 0x35c86a04, Offset: 0x47f0
// Size: 0xac
function droplimitedweapon( weapon, owner, item )
{
    limited_info = owner.limited_info;
    
    if ( !isdefined( limited_info ) )
    {
        return;
    }
    
    if ( limited_info.weapon != weapon )
    {
        return;
    }
    
    limited_info.drops -= 1;
    owner.limited_info = undefined;
    item thread limitedpickup( limited_info );
}

// Namespace weapons
// Params 1
// Checksum 0xe3ab0bba, Offset: 0x48a8
// Size: 0x5c
function limitedpickup( limited_info )
{
    self endon( #"death" );
    self waittill( #"trigger", player, item );
    
    if ( !isdefined( item ) )
    {
        return;
    }
    
    player.limited_info = limited_info;
}

