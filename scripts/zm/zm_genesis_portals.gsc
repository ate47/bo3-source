#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_hero_weapon;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_ball;
#using scripts/zm/_zm_zonemgr;

#namespace zm_genesis_portals;

// Namespace zm_genesis_portals
// Params 0, eflags: 0x2
// Checksum 0xa22642ac, Offset: 0x8f0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_genesis_portals", &__init__, undefined, undefined );
}

// Namespace zm_genesis_portals
// Params 0
// Checksum 0x3ef0fd2b, Offset: 0x930
// Size: 0x2f4
function __init__()
{
    clientfield::register( "toplayer", "player_stargate_fx", 15000, 1, "int" );
    clientfield::register( "toplayer", "player_light_exploder", 15000, 4, "int" );
    clientfield::register( "world", "genesis_light_exposure", 15000, 1, "int" );
    clientfield::register( "world", "power_pad_sheffield", 15000, 1, "int" );
    clientfield::register( "world", "power_pad_prison", 15000, 1, "int" );
    clientfield::register( "world", "power_pad_asylum", 15000, 1, "int" );
    clientfield::register( "world", "power_pad_temple", 15000, 1, "int" );
    clientfield::register( "toplayer", "hint_verruckt_portal_top", 15000, 1, "int" );
    clientfield::register( "toplayer", "hint_verruckt_portal_bottom", 15000, 1, "int" );
    clientfield::register( "toplayer", "hint_temple_portal_top", 15000, 1, "int" );
    clientfield::register( "toplayer", "hint_temple_portal_bottom", 15000, 1, "int" );
    clientfield::register( "toplayer", "hint_sheffield_portal_top", 15000, 1, "int" );
    clientfield::register( "toplayer", "hint_sheffield_portal_bottom", 15000, 1, "int" );
    clientfield::register( "toplayer", "hint_prison_portal_top", 15000, 1, "int" );
    clientfield::register( "toplayer", "hint_prison_portal_bottom", 15000, 1, "int" );
    callback::on_connect( &function_cfc89ca );
}

// Namespace zm_genesis_portals
// Params 0
// Checksum 0xef055a8a, Offset: 0xc30
// Size: 0x1c4
function function_16616103()
{
    level flag::init( "verruct_portal" );
    level thread create_portal( "verruckt", "verruct_portal" );
    level thread function_e4ff383e( "power_on4", "verruct_portal" );
    level flag::init( "temple_portal" );
    level thread create_portal( "temple", "temple_portal" );
    level thread function_e4ff383e( "power_on3", "temple_portal" );
    level flag::init( "sheffield_portal" );
    level thread create_portal( "sheffield", "sheffield_portal" );
    level thread function_e4ff383e( "power_on2", "sheffield_portal" );
    level flag::init( "prison_portal" );
    level thread create_portal( "prison", "prison_portal" );
    level thread function_e4ff383e( "power_on1", "prison_portal" );
}

// Namespace zm_genesis_portals
// Params 2
// Checksum 0x195f9407, Offset: 0xe00
// Size: 0x44
function function_e4ff383e( var_49e3dd2e, var_d16ec704 )
{
    level flag::wait_till( var_49e3dd2e );
    level flag::set( var_d16ec704 );
}

// Namespace zm_genesis_portals
// Params 0
// Checksum 0x155f5f4f, Offset: 0xe50
// Size: 0x9c
function function_ff160813()
{
    while ( true )
    {
        if ( level flag::get( "power_on1" ) && level flag::get( "power_on3" ) && level flag::get( "power_on4" ) )
        {
            break;
        }
        
        wait 1;
    }
    
    level flag::set( "sheffield_portal" );
}

// Namespace zm_genesis_portals
// Params 2
// Checksum 0xb7fd06aa, Offset: 0xef8
// Size: 0x1f8
function create_portal( str_id, var_776628b2 )
{
    width = 192;
    height = 128;
    length = 192;
    str_areaname = str_id;
    s_loc = struct::get( str_areaname, "targetname" );
    function_4a4784d4( str_areaname, 0 );
    
    if ( isdefined( var_776628b2 ) )
    {
        level flag::wait_till( var_776628b2 );
    }
    
    level thread portal_activate( str_areaname );
    level thread portal_open( str_areaname );
    var_6bca29ec = "close_portal_" + str_id;
    var_2c5f1c2a = "open_portal_" + str_id;
    
    while ( true )
    {
        level util::waittill_any( "close_all_portals", var_6bca29ec );
        level thread function_7fa2f44( str_areaname );
        level.var_ccae6720 = 1;
        function_4a4784d4( str_areaname, 0 );
        level util::waittill_any( "open_all_portals", var_2c5f1c2a );
        level thread portal_activate( str_areaname );
        level.var_ccae6720 = 0;
        function_4a4784d4( str_areaname, 1 );
    }
}

// Namespace zm_genesis_portals
// Params 0
// Checksum 0xddd6991c, Offset: 0x10f8
// Size: 0xcc
function function_a90ab0d7()
{
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( player zm_utility::in_revive_trigger() )
        {
            continue;
        }
        
        if ( player.is_drinking > 0 )
        {
            continue;
        }
        
        if ( !zm_utility::is_player_valid( player ) )
        {
            continue;
        }
        
        level thread portal_activate( self.stub.str_areaname );
        level thread portal_open( self.stub.str_areaname );
        break;
    }
}

// Namespace zm_genesis_portals
// Params 1
// Checksum 0xdf02baf4, Offset: 0x11d0
// Size: 0x296
function portal_activate( str_areaname )
{
    switch ( str_areaname )
    {
        case "prison":
            level clientfield::set( "power_pad_prison", 1 );
            
            if ( getdvarint( "splitscreen_playerCount" ) < 3 )
            {
                level thread scene::play( "prison_power_door", "targetname" );
                level thread scene::play( "prison_power_door2", "targetname" );
            }
            
            break;
        case "sheffield":
            level clientfield::set( "power_pad_sheffield", 1 );
            
            if ( getdvarint( "splitscreen_playerCount" ) < 3 )
            {
                level thread scene::play( "sheffield_power_door", "targetname" );
                level thread scene::play( "sheffield_power_door2", "targetname" );
            }
            
            break;
        case "temple":
            level clientfield::set( "power_pad_temple", 1 );
            
            if ( getdvarint( "splitscreen_playerCount" ) < 3 )
            {
                level thread scene::play( "temple_power_door", "targetname" );
                level thread scene::play( "temple_power_door2", "targetname" );
            }
            
            break;
        default:
            level clientfield::set( "power_pad_asylum", 1 );
            
            if ( getdvarint( "splitscreen_playerCount" ) < 3 )
            {
                level thread scene::play( "verruckt_power_door", "targetname" );
                level thread scene::play( "verruckt_power_door2", "targetname" );
            }
            
            break;
    }
}

// Namespace zm_genesis_portals
// Params 1
// Checksum 0x8e9b3e1e, Offset: 0x1470
// Size: 0xb6
function function_7fa2f44( str_areaname )
{
    switch ( str_areaname )
    {
        case "sheffield":
            exploder::stop_exploder( "fxexp_212" );
            break;
        case "temple":
            exploder::stop_exploder( "fxexp_242" );
            break;
        default:
            exploder::stop_exploder( "fxexp_232" );
            break;
        case "prison":
            exploder::stop_exploder( "fxexp_222" );
            break;
    }
}

// Namespace zm_genesis_portals
// Params 1
// Checksum 0x3092c855, Offset: 0x1530
// Size: 0x422
function portal_open( str_areaname )
{
    function_4a4784d4( str_areaname, 1 );
    a_t_portal_top = getentarray( str_areaname + "_portal_top", "script_noteworthy" );
    var_ebfa395 = getentarrayfromarray( a_t_portal_top, "teleport_trigger", "targetname" );
    var_a70f04bd = getentarrayfromarray( a_t_portal_top, "teleport_clip", "targetname" );
    a_t_portal_bottom = getentarray( str_areaname + "_portal_bottom", "script_noteworthy" );
    var_50fc4fb = getentarrayfromarray( a_t_portal_bottom, "teleport_trigger", "targetname" );
    var_852a023 = getentarrayfromarray( a_t_portal_bottom, "teleport_clip", "targetname" );
    var_ebfa395[ 0 ].e_dest = var_50fc4fb[ 0 ];
    var_50fc4fb[ 0 ].e_dest = var_ebfa395[ 0 ];
    var_1693bd2 = getnodearray( str_areaname + "_portal_node", "script_noteworthy" );
    
    foreach ( var_9110bac3 in var_1693bd2 )
    {
        var_e8b9ac31 = distancesquared( var_9110bac3.origin, var_ebfa395[ 0 ].origin );
        var_6d6d9e09 = distancesquared( var_9110bac3.origin, var_50fc4fb[ 0 ].origin );
        
        if ( var_e8b9ac31 < var_6d6d9e09 )
        {
            var_9110bac3.portal_trig = var_ebfa395[ 0 ];
            continue;
        }
        
        var_9110bac3.portal_trig = var_50fc4fb[ 0 ];
    }
    
    wait 2;
    var_ebfa395[ 0 ] thread portal_think();
    
    foreach ( e_clip in var_a70f04bd )
    {
        e_clip delete();
    }
    
    var_50fc4fb[ 0 ] thread portal_think();
    
    foreach ( e_clip in var_852a023 )
    {
        e_clip delete();
    }
}

// Namespace zm_genesis_portals
// Params 2
// Checksum 0x9aa5a641, Offset: 0x1960
// Size: 0xd2
function function_4a4784d4( str_areaname, b_enabled )
{
    var_1693bd2 = getnodearray( str_areaname + "_portal_node", "script_noteworthy" );
    
    foreach ( var_9110bac3 in var_1693bd2 )
    {
        setenablenode( var_9110bac3, b_enabled );
    }
}

// Namespace zm_genesis_portals
// Params 1
// Checksum 0x71421e9, Offset: 0x1a40
// Size: 0x1f0
function portal_think( b_show_fx )
{
    self.a_s_port_locs = struct::get_array( self.target, "targetname" );
    
    if ( !isdefined( b_show_fx ) )
    {
        b_show_fx = 1;
    }
    
    if ( isdefined( self.script_string ) )
    {
        str_zone = self.script_string;
    }
    
    if ( isdefined( self.e_dest ) && isdefined( self.e_dest.script_noteworthy ) )
    {
        var_759fb311 = self.e_dest.script_noteworthy;
    }
    
    while ( true )
    {
        self waittill( #"trigger", e_portee );
        
        if ( isdefined( level.var_ccae6720 ) && level.var_ccae6720 )
        {
            continue;
        }
        
        if ( isdefined( e_portee.b_teleporting ) && e_portee.b_teleporting )
        {
            continue;
        }
        
        if ( isplayer( e_portee ) )
        {
            if ( e_portee getstance() != "prone" )
            {
                playfx( level._effect[ "portal_3p" ], e_portee.origin );
                e_portee playlocalsound( "zmb_teleporter_teleport_2d" );
                playsoundatposition( "zmb_teleporter_teleport_out", e_portee.origin );
                e_portee thread portal_teleport_player( b_show_fx, self.a_s_port_locs, str_zone, self.origin, var_759fb311 );
            }
        }
    }
}

// Namespace zm_genesis_portals
// Params 5
// Checksum 0x28a715cc, Offset: 0x1c38
// Size: 0x97c
function portal_teleport_player( show_fx, a_s_port_locs, str_zone, v_portal, var_759fb311 )
{
    if ( !isdefined( show_fx ) )
    {
        show_fx = 1;
    }
    
    self endon( #"disconnect" );
    self notify( #"gravityspikes_attack_watchers_end" );
    self.b_teleporting = 1;
    self.teleport_location = self.origin;
    self.a_s_port_locs = a_s_port_locs;
    
    if ( isdefined( var_759fb311 ) )
    {
        self clientfield::set_to_player( "hint_" + var_759fb311, 1 );
    }
    
    if ( show_fx )
    {
        self clientfield::set_to_player( "player_stargate_fx", 1 );
    }
    
    n_pos = self.characterindex;
    prone_offset = ( 0, 0, 49 );
    crouch_offset = ( 0, 0, 20 );
    stand_offset = ( 0, 0, 0 );
    a_ai_enemies = getaiteamarray( "axis" );
    a_ai_enemies = arraysort( a_ai_enemies, v_portal, 1, 99, 768 );
    array::thread_all( a_ai_enemies, &ai_delay_cleanup );
    level.n_cleanup_manager_restart_time = 4 + 15;
    level.n_cleanup_manager_restart_time += gettime() / 1000;
    image_room = struct::get( "teleport_room_" + n_pos, "targetname" );
    var_d9543609 = undefined;
    
    if ( self hasweapon( level.ballweapon ) )
    {
        var_d9543609 = self.carryobject;
    }
    
    if ( zm_hero_weapon::is_hero_weapon_in_use() )
    {
        self switchtoweaponimmediate();
        wait 0.05;
    }
    
    self disableoffhandweapons();
    self disableweapons();
    self freezecontrols( 1 );
    util::wait_network_frame();
    
    if ( self getstance() == "prone" )
    {
        desired_origin = image_room.origin + prone_offset;
    }
    else if ( self getstance() == "crouch" )
    {
        desired_origin = image_room.origin + crouch_offset;
    }
    else
    {
        desired_origin = image_room.origin + stand_offset;
    }
    
    self.teleport_origin = util::spawn_model( "tag_origin", self.origin, self.angles );
    self playerlinktoabsolute( self.teleport_origin, "tag_origin" );
    self.teleport_origin.origin = desired_origin;
    self.teleport_origin.angles = image_room.angles;
    util::wait_network_frame();
    self.teleport_origin.angles = image_room.angles;
    
    if ( isdefined( str_zone ) )
    {
        zm_zonemgr::enable_zone( str_zone );
    }
    
    if ( isdefined( var_759fb311 ) )
    {
        switch ( var_759fb311 )
        {
            case "prison_portal_bottom":
            case "sheffield_portal_bottom":
            case "temple_portal_bottom":
            case "verruckt_portal_bottom":
                self function_eec1f014( "prototype", 10, 1 );
                break;
            case "sheffield_portal_top":
                self function_eec1f014( "start", 2, 1 );
                break;
            case "prison_portal_top":
                self function_eec1f014( "prison", 4, 1 );
                break;
            default:
                self function_eec1f014( "asylum", 6, 1 );
                break;
            case "temple_portal_top":
                self function_eec1f014( "temple", 8, 1 );
                break;
        }
    }
    
    wait 4;
    
    if ( show_fx )
    {
        self clientfield::set_to_player( "player_stargate_fx", 0 );
    }
    
    a_players = getplayers();
    arrayremovevalue( a_players, self );
    s_pos = array::random( a_s_port_locs );
    
    if ( a_players.size > 0 )
    {
        var_cefa4b63 = 0;
        
        while ( !var_cefa4b63 )
        {
            var_cefa4b63 = 1;
            s_pos = array::random( a_s_port_locs );
            
            foreach ( var_3bc10d31 in a_players )
            {
                f_dist = distance( var_3bc10d31.origin, s_pos.origin );
                
                if ( f_dist < 32 )
                {
                    var_cefa4b63 = 0;
                }
            }
            
            wait 0.05;
        }
    }
    
    playfx( level._effect[ "portal_3p" ], s_pos.origin );
    self unlink();
    playsoundatposition( "zmb_teleporter_teleport_in", s_pos.origin );
    self thread function_bfba39d8();
    self setorigin( s_pos.origin );
    self setplayerangles( s_pos.angles );
    
    if ( isdefined( var_d9543609 ) )
    {
        var_d9543609 ball::reset_ball( 0 );
    }
    
    self.zone_name = self zm_utility::get_current_zone();
    self.last_valid_position = self.origin;
    
    if ( !ispointonnavmesh( self.origin, self ) )
    {
        position = getclosestpointonnavmesh( self.origin, 100, 15 );
        
        if ( isdefined( position ) )
        {
            self.last_valid_position = position;
        }
    }
    
    level thread function_483df985( s_pos );
    self enableweapons();
    self enableoffhandweapons();
    self freezecontrols( level.intermission );
    
    if ( isdefined( var_759fb311 ) )
    {
        self clientfield::set_to_player( "hint_" + var_759fb311, 0 );
        
        /#
            streamerskiptodebug( "<dev string:x28>" + var_759fb311 );
        #/
    }
    
    self.b_teleporting = 0;
    self thread zm_audio::create_and_play_dialog( "portal", "travel" );
}

// Namespace zm_genesis_portals
// Params 0
// Checksum 0xc8a2633, Offset: 0x25c0
// Size: 0x46
function function_bfba39d8()
{
    util::wait_network_frame();
    
    if ( isdefined( self.teleport_origin ) )
    {
        self.teleport_origin delete();
        self.teleport_origin = undefined;
    }
}

// Namespace zm_genesis_portals
// Params 1
// Checksum 0xd820df84, Offset: 0x2610
// Size: 0x464
function function_483df985( s_pos )
{
    a_ai = getaiarray();
    a_aoe_ai = arraysortclosest( a_ai, s_pos.origin, a_ai.size, 0, 260 );
    
    foreach ( ai in a_aoe_ai )
    {
        if ( !isdefined( level.ai_companion ) || isactor( ai ) && ai != level.ai_companion )
        {
            if ( ai.archetype === "zombie" )
            {
                playfx( level._effect[ "beast_return_aoe_kill" ], ai gettagorigin( "j_spineupper" ) );
            }
            else
            {
                playfx( level._effect[ "beast_return_aoe_kill" ], ai.origin );
            }
            
            ai.has_been_damaged_by_player = 0;
            ai.deathpoints_already_given = 1;
            ai.no_powerups = 1;
            
            if ( !( isdefined( ai.exclude_cleanup_adding_to_total ) && ai.exclude_cleanup_adding_to_total ) )
            {
                level.zombie_total++;
                level.zombie_respawns++;
                ai.b_cleaned_up = 1;
                
                if ( isdefined( ai.maxhealth ) && ai.health < ai.maxhealth )
                {
                    if ( !isdefined( level.a_zombie_respawn_health[ ai.archetype ] ) )
                    {
                        level.a_zombie_respawn_health[ ai.archetype ] = [];
                    }
                    
                    if ( !isdefined( level.a_zombie_respawn_health[ ai.archetype ] ) )
                    {
                        level.a_zombie_respawn_health[ ai.archetype ] = [];
                    }
                    else if ( !isarray( level.a_zombie_respawn_health[ ai.archetype ] ) )
                    {
                        level.a_zombie_respawn_health[ ai.archetype ] = array( level.a_zombie_respawn_health[ ai.archetype ] );
                    }
                    
                    level.a_zombie_respawn_health[ ai.archetype ][ level.a_zombie_respawn_health[ ai.archetype ].size ] = ai.health;
                }
                
                ai zombie_utility::reset_attack_spot();
            }
            
            switch ( ai.archetype )
            {
                case "margwa":
                    if ( isdefined( ai.canstun ) && ai.canstun )
                    {
                        ai.reactstun = 1;
                    }
                    
                    break;
                case "mechz":
                    if ( !( isdefined( ai.stun ) && ai.stun ) && ai.stumble_stun_cooldown_time < gettime() )
                    {
                        ai.stun = 1;
                    }
                    
                    break;
                default:
                    ai kill();
                    break;
            }
        }
    }
}

// Namespace zm_genesis_portals
// Params 0
// Checksum 0xb81affa0, Offset: 0x2a80
// Size: 0x72
function ai_delay_cleanup()
{
    if ( !( isdefined( self.b_ignore_cleanup ) && self.b_ignore_cleanup ) )
    {
        self notify( #"delay_cleanup" );
        self endon( #"death" );
        self endon( #"delay_cleanup" );
        self.b_ignore_cleanup = 1;
        self.var_b6b1080c = 1;
        wait 10;
        self.b_ignore_cleanup = undefined;
        self.var_b6b1080c = undefined;
    }
}

// Namespace zm_genesis_portals
// Params 1
// Checksum 0xaf790690, Offset: 0x2b00
// Size: 0x2c4
function portal_teleport_ai( e_portee )
{
    e_portee endon( #"death" );
    e_portee.b_teleporting = 1;
    e_portee pathmode( "dont move" );
    playfx( level._effect[ "portal_3p" ], e_portee.origin );
    playsoundatposition( "zmb_teleporter_teleport_out", e_portee.origin );
    e_portee notsolid();
    util::wait_network_frame();
    image_room = struct::get( "teleport_room_zombies", "targetname" );
    
    if ( isactor( e_portee ) )
    {
        e_portee forceteleport( image_room.origin, image_room.angles );
    }
    else
    {
        e_portee.origin = image_room.origin;
        e_portee.angles = image_room.angles;
    }
    
    wait 5;
    s_port_loc = array::random( self.a_s_port_locs );
    
    if ( isactor( e_portee ) )
    {
        e_portee forceteleport( s_port_loc.origin, s_port_loc.angles );
    }
    else
    {
        e_portee.origin = s_port_loc.origin;
        e_portee.angles = s_port_loc.angles;
    }
    
    playsoundatposition( "zmb_teleporter_teleport_in", s_port_loc.origin );
    playfx( level._effect[ "portal_3p" ], s_port_loc.origin );
    e_portee solid();
    wait 1;
    e_portee pathmode( "move allowed" );
    e_portee.b_teleporting = 0;
}

// Namespace zm_genesis_portals
// Params 0
// Checksum 0xb88e4cf4, Offset: 0x2dd0
// Size: 0x464
function function_cfc89ca()
{
    self endon( #"disconnect" );
    level endon( #"hash_c9cb5160" );
    level flag::wait_till( "start_zombie_round_logic" );
    self.var_fe12a779 = [];
    self.var_fe12a779[ "start" ] = 0;
    self.var_fe12a779[ "prison" ] = 0;
    self.var_fe12a779[ "asylum" ] = 0;
    self.var_fe12a779[ "temple" ] = 0;
    self.var_fe12a779[ "prototype" ] = 0;
    
    while ( true )
    {
        if ( isdefined( self.var_a3d40b8 ) && !( isdefined( self.is_flung ) && self.is_flung ) )
        {
            switch ( self.var_a3d40b8 )
            {
                case "start_island":
                    self function_eec1f014( "start", 2, 1 );
                    self function_eec1f014( "prison", 3, 0 );
                    self function_eec1f014( "asylum", 5, 0 );
                    self function_eec1f014( "temple", 7, 0 );
                    self function_eec1f014( "prototype", 9, 0 );
                    break;
                case "prison_island":
                    self function_eec1f014( "prison", 4, 1 );
                    self function_eec1f014( "start", 1, 0 );
                    self function_eec1f014( "asylum", 5, 0 );
                    self function_eec1f014( "temple", 7, 0 );
                    self function_eec1f014( "prototype", 9, 0 );
                    break;
                case "asylum_island":
                    self function_eec1f014( "asylum", 6, 1 );
                    self function_eec1f014( "start", 1, 0 );
                    self function_eec1f014( "prison", 3, 0 );
                    self function_eec1f014( "temple", 7, 0 );
                    self function_eec1f014( "prototype", 9, 0 );
                    break;
                default:
                    self function_eec1f014( "temple", 8, 1 );
                    self function_eec1f014( "start", 1, 0 );
                    self function_eec1f014( "prison", 3, 0 );
                    self function_eec1f014( "asylum", 5, 0 );
                    self function_eec1f014( "prototype", 9, 0 );
                    break;
                case "prototype_island":
                    self function_eec1f014( "prototype", 10, 1 );
                    self function_eec1f014( "start", 1, 0 );
                    self function_eec1f014( "prison", 3, 0 );
                    self function_eec1f014( "asylum", 5, 0 );
                    self function_eec1f014( "temple", 7, 0 );
                    break;
            }
        }
        
        wait 0.05;
    }
}

// Namespace zm_genesis_portals
// Params 3
// Checksum 0xe219447f, Offset: 0x3240
// Size: 0x9e
function function_eec1f014( str_name, n_value, b_toggle )
{
    if ( self.var_fe12a779[ str_name ] == b_toggle )
    {
        self clientfield::set_to_player( "player_light_exploder", n_value );
        util::wait_network_frame();
        
        if ( self.var_fe12a779[ str_name ] )
        {
            self.var_fe12a779[ str_name ] = 0;
            return;
        }
        
        self.var_fe12a779[ str_name ] = 1;
    }
}

// Namespace zm_genesis_portals
// Params 0
// Checksum 0x59da525d, Offset: 0x32e8
// Size: 0x6e
function function_b64d33a7()
{
    level waittill( #"start_zombie_round_logic" );
    wait 120;
    
    while ( true )
    {
        level clientfield::set( "genesis_light_exposure", 1 );
        wait 5;
        level clientfield::set( "genesis_light_exposure", 0 );
        wait 120;
    }
}

