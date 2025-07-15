#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/shared/_oob;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/load_shared;
#using scripts/shared/player_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace savegame;

// Namespace savegame
// Params 0, eflags: 0x2
// Checksum 0x941de505, Offset: 0x348
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "save", &__init__, undefined, undefined );
}

// Namespace savegame
// Params 0
// Checksum 0xa7f8efea, Offset: 0x388
// Size: 0x11c
function __init__()
{
    if ( !isdefined( world.loadout ) )
    {
        world.loadout = [];
    }
    
    if ( !isdefined( world.mapdata ) )
    {
        world.mapdata = [];
    }
    
    if ( !isdefined( world.playerdata ) )
    {
        world.playerdata = [];
    }
    
    foreach ( trig in trigger::get_all() )
    {
        if ( isdefined( trig.script_checkpoint ) && trig.script_checkpoint )
        {
            trig thread checkpoint_trigger();
        }
    }
    
    level.var_67e1f60e = [];
}

// Namespace savegame
// Params 0
// Checksum 0x10f70fc8, Offset: 0x4b0
// Size: 0x20
function save()
{
    if ( !isdefined( world.loadout ) )
    {
        world.loadout = [];
    }
}

// Namespace savegame
// Params 0
// Checksum 0x99ec1590, Offset: 0x4d8
// Size: 0x4
function load()
{
    
}

// Namespace savegame
// Params 1
// Checksum 0xffaad58a, Offset: 0x4e8
// Size: 0x78
function set_mission_name( name )
{
    if ( isdefined( level.savename ) && level.savename != name )
    {
        errormsg( "<dev string:x28>" + level.savename + "<dev string:x4e>" + name + "<dev string:x53>" );
    }
    
    level.savename = name;
}

// Namespace savegame
// Params 0
// Checksum 0x6af5884b, Offset: 0x568
// Size: 0x32
function get_mission_name()
{
    if ( !isdefined( level.savename ) )
    {
        set_mission_name( level.script );
    }
    
    return level.savename;
}

// Namespace savegame
// Params 2
// Checksum 0x5d629a5e, Offset: 0x5a8
// Size: 0x90
function set_mission_data( name, value )
{
    id = get_mission_name();
    
    if ( !isdefined( world.mapdata ) )
    {
        world.mapdata = [];
    }
    
    if ( !isdefined( world.mapdata[ id ] ) )
    {
        world.mapdata[ id ] = [];
    }
    
    world.mapdata[ id ][ name ] = value;
}

// Namespace savegame
// Params 2
// Checksum 0x633206b1, Offset: 0x640
// Size: 0x8c
function get_mission_data( name, defval )
{
    id = get_mission_name();
    
    if ( isdefined( world.mapdata ) && isdefined( world.mapdata[ id ] ) && isdefined( world.mapdata[ id ][ name ] ) )
    {
        return world.mapdata[ id ][ name ];
    }
    
    return defval;
}

// Namespace savegame
// Params 0
// Checksum 0xa4ee0264, Offset: 0x6d8
// Size: 0x5a
function clear_mission_data()
{
    id = get_mission_name();
    
    if ( isdefined( world.mapdata ) && isdefined( world.mapdata[ id ] ) )
    {
        world.mapdata[ id ] = [];
    }
}

// Namespace savegame
// Params 0, eflags: 0x4
// Checksum 0x40514082, Offset: 0x740
// Size: 0xa
function private get_player_unique_id()
{
    return self.playername;
}

// Namespace savegame
// Params 2
// Checksum 0xaad627ec, Offset: 0x758
// Size: 0x142
function set_player_data( name, value )
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        networkmode = "offline";
        
        if ( sessionmodeisonlinegame() )
        {
            networkmode = "online";
        }
        
        campaignmode = "CPZM" + networkmode;
    }
    else
    {
        campaignmode = "CP";
    }
    
    id = self get_player_unique_id();
    
    if ( !isdefined( world.playerdata ) )
    {
        world.playerdata = [];
    }
    
    if ( !isdefined( world.playerdata[ campaignmode ] ) )
    {
        world.playerdata[ campaignmode ] = [];
    }
    
    if ( !isdefined( world.playerdata[ campaignmode ][ id ] ) )
    {
        world.playerdata[ campaignmode ][ id ] = [];
    }
    
    world.playerdata[ campaignmode ][ id ][ name ] = value;
}

// Namespace savegame
// Params 2
// Checksum 0xc99594fe, Offset: 0x8a8
// Size: 0x12a
function get_player_data( name, defval )
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        networkmode = "offline";
        
        if ( sessionmodeisonlinegame() )
        {
            networkmode = "online";
        }
        
        campaignmode = "CPZM" + networkmode;
    }
    else
    {
        campaignmode = "CP";
    }
    
    id = self get_player_unique_id();
    
    if ( isdefined( world.playerdata ) && isdefined( world.playerdata[ campaignmode ] ) && isdefined( world.playerdata[ campaignmode ][ id ] ) && isdefined( world.playerdata[ campaignmode ][ id ][ name ] ) )
    {
        return world.playerdata[ campaignmode ][ id ][ name ];
    }
    
    return defval;
}

// Namespace savegame
// Params 0
// Checksum 0xeb4b79e7, Offset: 0x9e0
// Size: 0xd2
function clear_player_data()
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        networkmode = "offline";
        
        if ( sessionmodeisonlinegame() )
        {
            networkmode = "online";
        }
        
        campaignmode = "CPZM" + networkmode;
    }
    else
    {
        campaignmode = "CP";
    }
    
    id = self get_player_unique_id();
    
    if ( isdefined( world.playerdata ) && isdefined( world.playerdata[ campaignmode ] ) )
    {
        world.playerdata[ campaignmode ] = [];
    }
}

// Namespace savegame
// Params 0
// Checksum 0x8cb05ba6, Offset: 0xac0
// Size: 0x24a
function function_37ae30c6()
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        networkmode = "offline";
        
        if ( sessionmodeisonlinegame() )
        {
            networkmode = "online";
        }
        
        campaignmode = "CPZM" + networkmode;
    }
    else
    {
        campaignmode = "CP";
    }
    
    if ( !isdefined( world.playerdata ) )
    {
        world.playerdata = [];
    }
    
    if ( !isdefined( world.playerdata[ campaignmode ] ) )
    {
        world.playerdata[ campaignmode ] = [];
    }
    
    keys = getarraykeys( world.playerdata[ campaignmode ] );
    
    if ( isdefined( keys ) )
    {
        foreach ( key in keys )
        {
            key_found = 0;
            
            foreach ( player in level.players )
            {
                if ( key === player get_player_unique_id() )
                {
                    key_found = 1;
                    break;
                }
            }
            
            if ( !key_found )
            {
                arrayremoveindex( world.playerdata[ campaignmode ], key, 1 );
            }
        }
    }
}

// Namespace savegame
// Params 0
// Checksum 0x89b48c00, Offset: 0xd18
// Size: 0x26, Type: bool
function function_f6ab8f28()
{
    return getdvarint( "ui_blocksaves", 1 ) == 0;
}

// Namespace savegame
// Params 0
// Checksum 0x3f0242e0, Offset: 0xd48
// Size: 0x4c
function function_fb150717()
{
    if ( isdefined( level.var_cc93e6eb ) && level.var_cc93e6eb || getdvarint( "scr_no_checkpoints", 0 ) )
    {
        return;
    }
    
    level thread function_74fcb9ca();
}

// Namespace savegame
// Params 0, eflags: 0x4
// Checksum 0x7b915531, Offset: 0xda0
// Size: 0x8c
function private function_74fcb9ca()
{
    level notify( #"checkpoint_save" );
    level endon( #"checkpoint_save" );
    level endon( #"save_restore" );
    checkpointcreate();
    wait 0.05;
    wait 0.05;
    checkpointcommit();
    show_checkpoint_reached();
    level thread function_152fdd8c( 0 );
}

// Namespace savegame
// Params 0
// Checksum 0xc87fda4f, Offset: 0xe38
// Size: 0x2c
function checkpoint_trigger()
{
    self endon( #"death" );
    self waittill( #"trigger" );
    checkpoint_save();
}

// Namespace savegame
// Params 1
// Checksum 0x82f1b4c4, Offset: 0xe70
// Size: 0x34
function checkpoint_save( var_c36855a9 )
{
    if ( !isdefined( var_c36855a9 ) )
    {
        var_c36855a9 = 0;
    }
    
    level thread function_1add9d4a( var_c36855a9 );
}

// Namespace savegame
// Params 0
// Checksum 0x99ec1590, Offset: 0xeb0
// Size: 0x4
function show_checkpoint_reached()
{
    
}

// Namespace savegame
// Params 1
// Checksum 0x3a937828, Offset: 0xec0
// Size: 0x29c
function function_152fdd8c( delay )
{
    if ( function_f6ab8f28() )
    {
        wait 0.2;
        
        foreach ( player in level.players )
        {
            player player::generate_weapon_data();
            player set_player_data( "saved_weapon", player._generated_current_weapon.name );
            player set_player_data( "saved_weapondata", player._generated_weapons );
            player set_player_data( "lives", player.lives );
            player._generated_current_weapon = undefined;
            player._generated_weapons = undefined;
        }
        
        player = util::gethostplayer();
        
        if ( isdefined( player ) )
        {
            player set_player_data( "savegame_score", player.pers[ "score" ] );
            player set_player_data( "savegame_kills", player.pers[ "kills" ] );
            player set_player_data( "savegame_assists", player.pers[ "assists" ] );
            player set_player_data( "savegame_incaps", player.pers[ "incaps" ] );
            player set_player_data( "savegame_revives", player.pers[ "revives" ] );
        }
        
        savegame_create();
        wait delay;
        
        if ( isdefined( player ) )
        {
            util::show_event_message( player, &"COOP_REACHED_SKIPTO" );
        }
    }
}

// Namespace savegame
// Params 0
// Checksum 0x856b9d76, Offset: 0x1168
// Size: 0x16c, Type: bool
function function_319d38eb()
{
    if ( isdefined( level.missionfailed ) && level.missionfailed )
    {
        return false;
    }
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            return false;
        }
        
        if ( player clientfield::get( "burn" ) )
        {
            return false;
        }
        
        if ( player laststand::player_is_in_laststand() )
        {
            return false;
        }
        
        if ( player.sessionstate == "spectator" )
        {
            if ( isdefined( self.firstspawn ) )
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        
        if ( player oob::isoutofbounds() )
        {
            return false;
        }
        
        if ( isdefined( player.burning ) && player.burning )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace savegame
// Params 1, eflags: 0x4
// Checksum 0x46adfa6b, Offset: 0x12e0
// Size: 0x13c
function private function_1add9d4a( var_c36855a9 )
{
    level notify( #"hash_1add9d4a" );
    level endon( #"hash_1add9d4a" );
    level endon( #"kill_save" );
    level endon( #"save_restore" );
    wait 0.1;
    
    while ( true )
    {
        if ( function_147f4ca3() )
        {
            wait 0.1;
            checkpointcreate();
            wait 6;
            
            for ( check_count = 0; check_count < 5 ; check_count++ )
            {
                if ( function_319d38eb() )
                {
                    break;
                }
                
                wait 1;
            }
            
            if ( check_count == 5 )
            {
                continue;
            }
            
            checkpointcommit();
            show_checkpoint_reached();
            
            if ( var_c36855a9 )
            {
                level thread function_152fdd8c( 1.5 );
            }
            
            return;
        }
        
        wait 1;
    }
}

// Namespace savegame
// Params 0
// Checksum 0xf03359c1, Offset: 0x1428
// Size: 0x1f0, Type: bool
function function_147f4ca3()
{
    if ( isdefined( level.var_cc93e6eb ) && level.var_cc93e6eb )
    {
        return false;
    }
    
    if ( getdvarint( "scr_no_checkpoints", 0 ) )
    {
        return false;
    }
    
    if ( isdefined( level.missionfailed ) && level.missionfailed )
    {
        return false;
    }
    
    var_3d59bfa3 = 0;
    
    foreach ( player in level.players )
    {
        if ( player function_2c89c30c() )
        {
            var_3d59bfa3++;
        }
    }
    
    var_24cd4120 = level.players.size;
    
    if ( var_3d59bfa3 < var_24cd4120 )
    {
        return false;
    }
    
    if ( !function_8dc86b60() )
    {
        return false;
    }
    
    if ( !function_a3a9b003() )
    {
        return false;
    }
    
    if ( isdefined( level.var_67e1f60e ) )
    {
        foreach ( func in level.var_67e1f60e )
        {
            if ( !level [[ func ]]() )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace savegame
// Params 0, eflags: 0x4
// Checksum 0xf56b5c4e, Offset: 0x1620
// Size: 0x266, Type: bool
function private function_2c89c30c()
{
    healthfraction = 1;
    
    if ( isdefined( self.health ) && isdefined( self.maxhealth ) && self.maxhealth > 0 )
    {
        healthfraction = self.health / self.maxhealth;
    }
    
    if ( healthfraction < 0.7 )
    {
        return false;
    }
    
    if ( isdefined( self.lastdamagetime ) && self.lastdamagetime > gettime() - 1500 )
    {
        return false;
    }
    
    if ( self clientfield::get( "burn" ) )
    {
        return false;
    }
    
    if ( self ismeleeing() )
    {
        return false;
    }
    
    if ( self isthrowinggrenade() )
    {
        return false;
    }
    
    if ( self isfiring() )
    {
        return false;
    }
    
    if ( self util::isflashed() )
    {
        return false;
    }
    
    if ( self laststand::player_is_in_laststand() )
    {
        return false;
    }
    
    if ( self.sessionstate == "spectator" )
    {
        if ( isdefined( self.firstspawn ) )
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    
    if ( self oob::isoutofbounds() )
    {
        return false;
    }
    
    if ( isdefined( self.burning ) && self.burning )
    {
        return false;
    }
    
    if ( self flagsys::get( "mobile_armory_in_use" ) )
    {
        return false;
    }
    
    foreach ( weapon in self getweaponslist() )
    {
        fraction = self getfractionmaxammo( weapon );
        
        if ( fraction > 0.1 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace savegame
// Params 0, eflags: 0x4
// Checksum 0x640ece73, Offset: 0x1890
// Size: 0x184, Type: bool
function private function_a3a9b003()
{
    if ( !getdvarint( "tu1_saveGameAiProximityCheck", 1 ) )
    {
        return true;
    }
    
    ais = getaiteamarray( "axis" );
    
    foreach ( ai in ais )
    {
        if ( !isdefined( ai ) )
        {
            continue;
        }
        
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        if ( isactor( ai ) && ai isinscriptedstate() )
        {
            continue;
        }
        
        if ( isdefined( ai.ignoreall ) && ai.ignoreall )
        {
            continue;
        }
        
        playerproximity = ai function_2808d83d();
        
        if ( playerproximity <= 80 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace savegame
// Params 0, eflags: 0x4
// Checksum 0x800e3ba6, Offset: 0x1a20
// Size: 0x126, Type: bool
function private function_f70dd749()
{
    if ( !isdefined( self.enemy ) )
    {
        return true;
    }
    
    if ( !isplayer( self.enemy ) )
    {
        return true;
    }
    
    if ( isdefined( self.melee ) && isdefined( self.melee.target ) && isplayer( self.melee.target ) )
    {
        return false;
    }
    
    playerproximity = self function_2808d83d();
    
    if ( playerproximity < 500 )
    {
        return false;
    }
    else if ( playerproximity > 1000 || playerproximity < 0 )
    {
        return true;
    }
    else if ( isactor( self ) && self cansee( self.enemy ) && self canshootenemy() )
    {
        return false;
    }
    
    return true;
}

// Namespace savegame
// Params 0
// Checksum 0x3d97fdb9, Offset: 0x1b50
// Size: 0xde
function function_2808d83d()
{
    mindist = -1;
    
    foreach ( player in level.activeplayers )
    {
        dist = distance( player.origin, self.origin );
        
        if ( dist < mindist || mindist < 0 )
        {
            mindist = dist;
        }
    }
    
    return mindist;
}

// Namespace savegame
// Params 0, eflags: 0x4
// Checksum 0xde2a5e1f, Offset: 0x1c38
// Size: 0x182, Type: bool
function private function_8dc86b60()
{
    var_db6b9d9f = 0;
    
    foreach ( grenade in getentarray( "grenade", "classname" ) )
    {
        foreach ( player in level.activeplayers )
        {
            distsq = distancesquared( grenade.origin, player.origin );
            
            if ( distsq < 90000 )
            {
                var_db6b9d9f++;
            }
        }
    }
    
    if ( var_db6b9d9f > 0 && var_db6b9d9f >= level.activeplayers.size )
    {
        return false;
    }
    
    return true;
}

