#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_bb;
#using scripts/zm/_zm;
#using scripts/zm/_zm_ai_dogs;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_blockers;
#using scripts/zm/_zm_hackables_doors;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_moon;
#using scripts/zm/zm_moon_amb;
#using scripts/zm/zm_moon_gravity;
#using scripts/zm/zm_moon_utility;
#using scripts/zm/zm_moon_wasteland;

#namespace zm_moon_utility;

// Namespace zm_moon_utility
// Params 0
// Checksum 0x7c10d916, Offset: 0x920
// Size: 0x1b4
function init_zombie_airlocks()
{
    airlock_buys = getentarray( "zombie_airlock_buy", "targetname" );
    
    for ( i = 0; i < airlock_buys.size ; i++ )
    {
        airlock_buys[ i ] thread airlock_buy_init();
    }
    
    level thread zm_hackables_doors::hack_doors( "zombie_airlock_hackable", &moon_door_opened );
    airlock_hacks = getentarray( "zombie_airlock_hackable", "targetname" );
    
    for ( i = 0; i < airlock_hacks.size ; i++ )
    {
        airlock_hacks[ i ] thread airlock_hack_init();
    }
    
    airlock_doors = getentarray( "zombie_door_airlock", "script_noteworthy" );
    
    for ( i = 0; i < airlock_doors.size ; i++ )
    {
        airlock_doors[ i ] thread airlock_init();
    }
    
    level thread init_door_sounds();
    level thread zombie_moon_receiving_hatch_init();
    level thread moon_glass_breach_init();
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0x92e6d846, Offset: 0xae0
// Size: 0x64
function init_door_sounds()
{
    zm_utility::add_sound( "lab_door", "zmb_lab_door_slide" );
    zm_utility::add_sound( "electric_metal_big", "zmb_heavy_door_open" );
    zm_utility::add_sound( "zmb_heavy_door_open", "zmb_heavy_door_open" );
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0x5ae8cc9e, Offset: 0xb50
// Size: 0x22c
function airlock_hack_init()
{
    self.type = undefined;
    
    if ( isdefined( self.script_flag ) && !isdefined( level.flag[ self.script_flag ] ) )
    {
        if ( isdefined( self.script_flag ) )
        {
            tokens = strtok( self.script_flag, "," );
            
            for ( i = 0; i < tokens.size ; i++ )
            {
                level flag::init( self.script_flag );
            }
        }
    }
    
    self.trigs = [];
    targets = getentarray( self.target, "targetname" );
    
    for ( i = 0; i < targets.size ; i++ )
    {
        if ( !isdefined( self.trigs ) )
        {
            self.trigs = [];
        }
        else if ( !isarray( self.trigs ) )
        {
            self.trigs = array( self.trigs );
        }
        
        self.trigs[ self.trigs.size ] = targets[ i ];
        
        if ( isdefined( targets[ i ].classname ) && targets[ i ].classname == "trigger_multiple" )
        {
            targets[ i ] triggerenable( 0 );
        }
    }
    
    self setcursorhint( "HINT_NOICON" );
    self.script_noteworthy = "default";
    self sethintstring( &"ZOMBIE_EQUIP_HACKER" );
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0x78669d54, Offset: 0xd88
// Size: 0x274
function airlock_buy_init()
{
    self.type = undefined;
    
    if ( isdefined( self.script_flag ) && !isdefined( level.flag[ self.script_flag ] ) )
    {
        if ( isdefined( self.script_flag ) )
        {
            tokens = strtok( self.script_flag, "," );
            
            for ( i = 0; i < tokens.size ; i++ )
            {
                level flag::init( self.script_flag );
            }
        }
    }
    
    self.trigs = [];
    targets = getentarray( self.target, "targetname" );
    
    for ( i = 0; i < targets.size ; i++ )
    {
        if ( !isdefined( self.trigs ) )
        {
            self.trigs = [];
        }
        else if ( !isarray( self.trigs ) )
        {
            self.trigs = array( self.trigs );
        }
        
        self.trigs[ self.trigs.size ] = targets[ i ];
        
        if ( isdefined( targets[ i ].classname ) && targets[ i ].classname == "trigger_multiple" )
        {
            targets[ i ] triggerenable( 0 );
        }
    }
    
    self setcursorhint( "HINT_NOICON" );
    
    if ( self.script_noteworthy == "electric_door" || isdefined( self.script_noteworthy ) && self.script_noteworthy == "electric_buyable_door" )
    {
        self sethintstring( &"ZOMBIE_NEED_POWER" );
    }
    else
    {
        self.script_noteworthy = "default";
    }
    
    self thread airlock_buy_think();
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0xf910271e, Offset: 0x1008
// Size: 0x142
function airlock_buy_think()
{
    self endon( #"kill_door_think" );
    cost = 1000;
    
    if ( isdefined( self.zombie_cost ) )
    {
        cost = self.zombie_cost;
    }
    
    while ( true )
    {
        switch ( self.script_noteworthy )
        {
            case "electric_door":
                level flag::wait_till( "power_on" );
                break;
            case "electric_buyable_door":
                level flag::wait_till( "power_on" );
                self zm_utility::set_hint_string( self, "default_buy_door", cost );
                
                if ( !self airlock_buy() )
                {
                    continue;
                }
                
                break;
            default:
                self zm_utility::set_hint_string( self, "default_buy_door", cost );
                
                if ( !self airlock_buy() )
                {
                    continue;
                }
                
                self moon_door_opened();
                break;
        }
    }
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0xfe82f300, Offset: 0x1158
// Size: 0x186
function moon_door_opened()
{
    self notify( #"door_opened" );
    
    if ( isdefined( self.script_flag ) )
    {
        tokens = strtok( self.script_flag, "," );
        
        for ( i = 0; i < tokens.size ; i++ )
        {
            level flag::set( tokens[ i ] );
        }
    }
    
    for ( i = 0; i < self.trigs.size ; i++ )
    {
        self.trigs[ i ] triggerenable( 1 );
        self.trigs[ i ] thread change_door_models();
    }
    
    zm_utility::play_sound_at_pos( "purchase", self.origin );
    all_trigs = getentarray( self.target, "target" );
    
    for ( i = 0; i < all_trigs.size ; i++ )
    {
        all_trigs[ i ] triggerenable( 0 );
    }
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0x43773241, Offset: 0x12e8
// Size: 0x196
function change_door_models()
{
    doors = getentarray( self.target, "targetname" );
    
    for ( i = 0; i < doors.size ; i++ )
    {
        if ( isdefined( doors[ i ].model ) && doors[ i ].model == "p7_zm_moo_door_airlock_heavy_lt_locked" )
        {
            doors[ i ] setmodel( "p7_zm_moo_door_airlock_heavy_lt" );
        }
        else if ( isdefined( doors[ i ].model ) && doors[ i ].model == "p7_zm_moo_door_airlock_heavy_rt_locked" )
        {
            doors[ i ] setmodel( "p7_zm_moo_door_airlock_heavy_rt" );
        }
        else if ( isdefined( doors[ i ].model ) && doors[ i ].model == "p7_zm_moo_door_airlock_heavy_single_locked" )
        {
            doors[ i ] setmodel( "p7_zm_moo_door_airlock_heavy_single" );
        }
        
        doors[ i ] thread airlock_connect_paths();
    }
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0x1814fae9, Offset: 0x1488
// Size: 0x74
function airlock_connect_paths()
{
    if ( self.classname == "script_brushmodel" )
    {
        self notsolid();
        self connectpaths();
        
        if ( !isdefined( self._door_open ) || self._door_open == 0 )
        {
            self solid();
        }
    }
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0xfca9c346, Offset: 0x1508
// Size: 0x314, Type: bool
function airlock_buy()
{
    self waittill( #"trigger", who, force );
    
    if ( isdefined( force ) && ( getdvarint( "zombie_unlock_all" ) > 0 || force ) )
    {
        return true;
    }
    
    if ( !who usebuttonpressed() )
    {
        return false;
    }
    
    if ( who zm_utility::in_revive_trigger() )
    {
        return false;
    }
    
    if ( who.is_drinking > 0 )
    {
        return false;
    }
    
    cost = 0;
    upgraded = 0;
    
    if ( zombie_utility::is_player_valid( who ) )
    {
        cost = self.zombie_cost;
        
        if ( who zm_pers_upgrades_functions::is_pers_double_points_active() )
        {
            cost = who zm_pers_upgrades_functions::pers_upgrade_double_points_cost( cost );
            upgraded = 1;
        }
        
        if ( who zm_score::can_player_purchase( cost ) )
        {
            who zm_score::minus_to_player_score( cost );
            scoreevents::processscoreevent( "open_door", who );
            demo::bookmark( "zm_player_door", gettime(), who );
            who zm_stats::increment_client_stat( "doors_purchased" );
            who zm_stats::increment_player_stat( "doors_purchased" );
            who zm_stats::increment_challenge_stat( "SURVIVALIST_BUY_DOOR" );
            self.purchaser = who;
            who recordmapevent( 5, gettime(), who.origin, level.round_number, cost );
            bb::logpurchaseevent( who, self, cost, self.target, upgraded, "_door", "_purchase" );
            who zm_stats::increment_challenge_stat( "ZM_DAILY_PURCHASE_DOORS" );
        }
        else
        {
            zm_utility::play_sound_at_pos( "no_purchase", self.origin );
            who zm_audio::create_and_play_dialog( "general", "outofmoney" );
            return false;
        }
    }
    
    return true;
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0xbaba4416, Offset: 0x1828
// Size: 0xdc
function airlock_init()
{
    self.type = undefined;
    self._door_open = 0;
    targets = getentarray( self.target, "targetname" );
    self.doors = [];
    
    for ( i = 0; i < targets.size ; i++ )
    {
        targets[ i ] zm_blockers::door_classify( self );
        targets[ i ].startpos = targets[ i ].origin;
    }
    
    self thread airlock_think();
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0xaa2589cd, Offset: 0x1910
// Size: 0x1b4
function airlock_think()
{
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( isdefined( self.doors[ 0 ].startpos ) && self.doors[ 0 ].startpos != self.doors[ 0 ].origin )
        {
            continue;
        }
        
        for ( i = 0; i < self.doors.size ; i++ )
        {
            self.doors[ i ] thread airlock_activate( 0.25, 1 );
        }
        
        self._door_open = 1;
        
        while ( isdefined( self.doors[ 0 ].door_moving ) && ( self moon_airlock_occupied() || self.doors[ 0 ].door_moving == 1 ) )
        {
            wait 0.1;
        }
        
        self thread door_clean_up_corpses();
        
        for ( i = 0; i < self.doors.size ; i++ )
        {
            self.doors[ i ] thread airlock_activate( 0.25, 0 );
        }
        
        self._door_open = 0;
    }
}

// Namespace zm_moon_utility
// Params 2
// Checksum 0x88133bb9, Offset: 0x1ad0
// Size: 0x246
function airlock_activate( time, open )
{
    if ( !isdefined( time ) )
    {
        time = 1;
    }
    
    if ( !isdefined( open ) )
    {
        open = 1;
    }
    
    if ( isdefined( self.door_moving ) )
    {
        return;
    }
    
    self.door_moving = 1;
    self notsolid();
    
    if ( self.classname == "script_brushmodel" )
    {
        if ( open )
        {
            self connectpaths();
        }
    }
    
    if ( isdefined( self.script_sound ) )
    {
        if ( open )
        {
            self playsound( "zmb_airlock_open" );
        }
        else
        {
            self playsound( "zmb_airlock_close" );
        }
    }
    
    scale = 1;
    
    if ( !open )
    {
        scale = -1;
    }
    
    switch ( self.script_string )
    {
        default:
            if ( isdefined( self.script_vector ) )
            {
                vector = vectorscale( self.script_vector, scale );
                
                if ( open )
                {
                    if ( isdefined( self.startpos ) )
                    {
                        self moveto( self.startpos + vector, time );
                    }
                    else
                    {
                        self moveto( self.origin + vector, time );
                    }
                    
                    self._door_open = 1;
                }
                else
                {
                    if ( isdefined( self.startpos ) )
                    {
                        self moveto( self.startpos, time );
                    }
                    else
                    {
                        self moveto( self.origin - vector, time );
                    }
                    
                    self._door_open = 0;
                }
                
                self thread zm_blockers::door_solid_thread();
            }
            
            break;
    }
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0xf256e1b4, Offset: 0x1d20
// Size: 0x1aa
function moon_airlock_occupied()
{
    is_occupied = 0;
    zombies = getaiarray();
    
    for ( i = 0; i < zombies.size ; i++ )
    {
        if ( zombies[ i ] istouching( self ) )
        {
            is_occupied++;
        }
    }
    
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( players[ i ] istouching( self ) )
        {
            is_occupied++;
        }
    }
    
    if ( is_occupied > 0 )
    {
        if ( isdefined( self.doors[ 0 ].startpos ) && self.doors[ 0 ].startpos == self.doors[ 0 ].origin )
        {
            for ( i = 0; i < self.doors.size ; i++ )
            {
                self.doors[ i ] thread airlock_activate( 0.25, 1 );
            }
            
            self._door_open = 1;
        }
        
        return 1;
    }
    
    return 0;
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0xb50ed079, Offset: 0x1ed8
// Size: 0x96
function door_clean_up_corpses()
{
    corpses = getcorpsearray();
    
    if ( isdefined( corpses ) )
    {
        for ( i = 0; i < corpses.size ; i++ )
        {
            if ( corpses[ i ] istouching( self ) )
            {
                corpses[ i ] thread door_remove_corpses();
            }
        }
    }
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0x27f33632, Offset: 0x1f78
// Size: 0x5c
function door_remove_corpses()
{
    if ( isdefined( level._effect[ "dog_gib" ] ) )
    {
        playfx( level._effect[ "dog_gib" ], self.origin );
    }
    
    self delete();
}

// Namespace zm_moon_utility
// Params 2
// Checksum 0xcb016828, Offset: 0x1fe0
// Size: 0xe2
function zapper_light_green( light_name, key_name )
{
    var_e9947991 = getentarray( light_name, key_name );
    
    foreach ( light in var_e9947991 )
    {
        str_light = "zap_teleport_light_0" + light.script_int;
        exploder::exploder( str_light );
    }
}

// Namespace zm_moon_utility
// Params 2
// Checksum 0x1911eaab, Offset: 0x20d0
// Size: 0xe2
function zapper_light_red( light_name, key_name )
{
    var_e9947991 = getentarray( light_name, key_name );
    
    foreach ( light in var_e9947991 )
    {
        str_light = "zap_teleport_light_0" + light.script_int;
        exploder::stop_exploder( str_light );
    }
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0x6de3f645, Offset: 0x21c0
// Size: 0x6ca
function moon_intermission()
{
    self closeingamemenu();
    level endon( #"stop_intermission" );
    self endon( #"disconnect" );
    self endon( #"death" );
    self notify( #"_zombie_game_over" );
    self.score = self.score_total;
    self.sessionstate = "intermission";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.friendlydamage = undefined;
    points = struct::get_array( "intermission", "targetname" );
    
    for ( i = 0; i < points.size ; i++ )
    {
        if ( level flag::get( "enter_nml" ) )
        {
            if ( points[ i ].script_noteworthy == "moon" )
            {
                arrayremovevalue( points, points[ i ] );
            }
            
            continue;
        }
        
        if ( points[ i ].script_noteworthy == "earth" )
        {
            arrayremovevalue( points, points[ i ] );
        }
    }
    
    if ( !isdefined( points ) || points.size == 0 )
    {
        points = getentarray( "info_intermission", "classname" );
        
        if ( points.size < 1 )
        {
            println( "<dev string:x28>" );
            return;
        }
    }
    
    self.game_over_bg = newclienthudelem( self );
    self.game_over_bg.horzalign = "fullscreen";
    self.game_over_bg.vertalign = "fullscreen";
    self.game_over_bg setshader( "black", 640, 480 );
    self.game_over_bg.alpha = 1;
    org = undefined;
    
    while ( true )
    {
        points = array::randomize( points );
        
        for ( i = 0; i < points.size ; i++ )
        {
            point = points[ i ];
            
            if ( !isdefined( org ) )
            {
                self spawn( point.origin, point.angles );
            }
            
            if ( isdefined( points[ i ].target ) )
            {
                if ( !isdefined( org ) )
                {
                    org = spawn( "script_model", self.origin + ( 0, 0, -60 ) );
                    org setmodel( "tag_origin" );
                }
                
                org.origin = points[ i ].origin;
                org.angles = points[ i ].angles;
                
                for ( j = 0; j < getplayers().size ; j++ )
                {
                    player = getplayers()[ j ];
                    player camerasetposition( org );
                    player camerasetlookat();
                    player cameraactivate( 1 );
                }
                
                speed = 20;
                
                if ( isdefined( points[ i ].speed ) )
                {
                    speed = points[ i ].speed;
                }
                
                target_point = struct::get( points[ i ].target, "targetname" );
                dist = distance( points[ i ].origin, target_point.origin );
                time = dist / speed;
                q_time = time * 0.25;
                
                if ( q_time > 1 )
                {
                    q_time = 1;
                }
                
                self.game_over_bg fadeovertime( q_time );
                self.game_over_bg.alpha = 0;
                org moveto( target_point.origin, time, q_time, q_time );
                org rotateto( target_point.angles, time, q_time, q_time );
                wait time - q_time;
                self.game_over_bg fadeovertime( q_time );
                self.game_over_bg.alpha = 1;
                wait q_time;
                continue;
            }
            
            self.game_over_bg fadeovertime( 1 );
            self.game_over_bg.alpha = 0;
            wait 5;
            self.game_over_bg thread zm::fade_up_over_time( 1 );
        }
    }
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0x9a079162, Offset: 0x2898
// Size: 0x26c
function hacker_location_random_init()
{
    hacker_tool_array = [];
    hacker_pos = undefined;
    level.hacker_tool_positions = [];
    hacker = getentarray( "zombie_equipment_upgrade", "targetname" );
    
    for ( i = 0; i < hacker.size ; i++ )
    {
        if ( isdefined( hacker[ i ].zombie_equipment_upgrade ) && hacker[ i ].zombie_equipment_upgrade == "equip_hacker" )
        {
            if ( !isdefined( hacker_tool_array ) )
            {
                hacker_tool_array = [];
            }
            else if ( !isarray( hacker_tool_array ) )
            {
                hacker_tool_array = array( hacker_tool_array );
            }
            
            hacker_tool_array[ hacker_tool_array.size ] = hacker[ i ];
            struct = spawnstruct();
            struct.trigger_org = hacker[ i ].origin;
            struct.model_org = getent( hacker[ i ].target, "targetname" ).origin;
            struct.model_ang = getent( hacker[ i ].target, "targetname" ).angles;
            level.hacker_tool_positions[ level.hacker_tool_positions.size ] = struct;
        }
    }
    
    if ( hacker_tool_array.size > 1 )
    {
        hacker_pos = hacker_tool_array[ randomint( hacker_tool_array.size ) ];
        arrayremovevalue( hacker_tool_array, hacker_pos );
        array::thread_all( hacker_tool_array, &hacker_position_cleanup );
    }
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0x557e3bcb, Offset: 0x2b10
// Size: 0x74
function hacker_position_cleanup()
{
    model = getent( self.target, "targetname" );
    
    if ( isdefined( model ) )
    {
        model delete();
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0x8687d808, Offset: 0x2b90
// Size: 0x126
function moon_glass_breach_init()
{
    level.glass = getentarray( "moon_breach_glass", "targetname" );
    array::thread_all( level.glass, &glass_breach_think );
    level.var_4fd08591 = [];
    level.var_4fd08591[ "bridge_zone" ] = 1;
    level.var_4fd08591[ "generator_exit_east_zone" ] = 1;
    level.var_4fd08591[ "enter_forest_east_zone" ] = 1;
    level flag::wait_till( "start_zombie_round_logic" );
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        players[ i ] thread check_for_grenade_throw();
    }
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0x2397843, Offset: 0x2cc0
// Size: 0x266
function glass_gets_destroyed()
{
    if ( isdefined( self.fxpos_array ) )
    {
        for ( i = 0; i < self.fxpos_array.size ; i++ )
        {
            if ( !isdefined( self.fxpos_array[ i ].var_3ce053e5 ) )
            {
                playfx( level._effect[ "glass_impact" ], self.fxpos_array[ i ].origin, anglestoforward( self.fxpos_array[ i ].angles ) );
                self.fxpos_array[ i ].var_3ce053e5 = 1;
            }
        }
    }
    
    if ( isdefined( self.script_noteworthy ) )
    {
        if ( isdefined( level.var_4fd08591[ self.script_noteworthy ] ) && level.var_4fd08591[ self.script_noteworthy ] )
        {
            function_f1daf14e( self.script_noteworthy );
            level.var_4fd08591[ self.script_noteworthy ] = 0;
        }
        
        level thread send_client_notify_for_breach( self.script_noteworthy );
        _zones = getentarray( self.script_noteworthy, "targetname" );
        
        if ( isdefined( _zones ) )
        {
            for ( i = 0; i < _zones.size ; i++ )
            {
                _zones[ i ].script_string = "lowgravity";
            }
            
            level thread zm_moon_gravity::zone_breached( self.script_noteworthy );
        }
    }
    
    util::wait_network_frame();
    
    if ( isdefined( self.model ) && self.damage_state == 0 )
    {
        self setmodel( self.model + "_dmg" );
        self.damage_state = 1;
        return;
    }
    
    self delete();
    return;
}

// Namespace zm_moon_utility
// Params 1
// Checksum 0xa8c3fa92, Offset: 0x2f30
// Size: 0x4c
function wait_for_grenade_explode( player )
{
    player endon( #"projectile_impact" );
    self waittill( #"explode", grenade_origin );
    self thread check_for_grenade_damage_on_window( grenade_origin );
}

// Namespace zm_moon_utility
// Params 1
// Checksum 0xff2fd341, Offset: 0x2f88
// Size: 0x54
function wait_for_projectile_impact( grenade )
{
    grenade endon( #"explode" );
    self waittill( #"projectile_impact", weapon_name, position );
    self thread check_for_grenade_damage_on_window( position );
}

// Namespace zm_moon_utility
// Params 1
// Checksum 0xd345c8ab, Offset: 0x2fe8
// Size: 0x162
function check_for_grenade_damage_on_window( grenade_origin )
{
    radiussqtocheck = 44096;
    
    for ( i = 0; i < level.glass.size ; i++ )
    {
        if ( level.glass[ i ].damage_state == 0 )
        {
            glass_destroyed = 0;
            
            for ( j = 0; j < level.glass[ i ].fxpos_array.size ; j++ )
            {
                glass_origin = level.glass[ i ].fxpos_array[ j ].origin;
                
                if ( distancesquared( glass_origin, grenade_origin ) < radiussqtocheck )
                {
                    glass_destroyed = 1;
                    break;
                }
            }
            
            if ( glass_destroyed )
            {
                level.glass[ i ] glass_gets_destroyed();
                level.glass[ i ].damage_state = 1;
            }
        }
    }
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0x817c7087, Offset: 0x3158
// Size: 0x68
function check_for_grenade_throw()
{
    while ( true )
    {
        self waittill( #"grenade_fire", grenade, weapname );
        grenade thread wait_for_grenade_explode( self );
        self thread wait_for_projectile_impact( grenade );
    }
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0x9384537c, Offset: 0x31c8
// Size: 0x124
function glass_breach_think()
{
    level endon( #"intermission" );
    self.fxpos_array = [];
    
    if ( isdefined( self.target ) )
    {
        self.fxpos_array = struct::get_array( self.target, "targetname" );
    }
    
    self.health = 99999;
    self.damage_state = 0;
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction, point, dmg_type );
        
        if ( dmg_type == "MOD_PROJECTILE" || isplayer( attacker ) && dmg_type == "MOD_PROJECTILE_SPLASH" )
        {
            if ( self.damage_state == 0 )
            {
                self glass_gets_destroyed();
                self.damage_state = 1;
            }
        }
    }
}

// Namespace zm_moon_utility
// Params 1
// Checksum 0x66ae79f3, Offset: 0x32f8
// Size: 0x216
function send_client_notify_for_breach( zone )
{
    switch ( zone )
    {
        case "bridge_zone":
            if ( !( isdefined( level.audio_zones_breached[ "1" ] ) && level.audio_zones_breached[ "1" ] ) )
            {
                level clientfield::increment( "Az1" );
                level.audio_zones_breached[ "1" ] = 1;
                
                if ( level flag::get( "power_on" ) )
                {
                    level thread zm_moon_amb::play_mooncomp_vox( "vox_mcomp_breach_start" );
                }
            }
            
            break;
        default:
            if ( !( isdefined( level.audio_zones_breached[ "4a" ] ) && level.audio_zones_breached[ "4a" ] ) )
            {
                level clientfield::increment( "Az4a" );
                level.audio_zones_breached[ "4a" ] = 1;
                
                if ( level flag::get( "power_on" ) )
                {
                    level thread zm_moon_amb::play_mooncomp_vox( "vox_mcomp_breach_labs" );
                }
            }
            
            break;
        case "enter_forest_east_zone":
            if ( !( isdefined( level.audio_zones_breached[ "4b" ] ) && level.audio_zones_breached[ "4b" ] ) )
            {
                level clientfield::increment( "Az4b" );
                level.audio_zones_breached[ "4b" ] = 1;
                
                if ( level flag::get( "power_on" ) )
                {
                    level thread zm_moon_amb::play_mooncomp_vox( "vox_mcomp_breach_labs" );
                }
            }
            
            break;
    }
}

// Namespace zm_moon_utility
// Params 1
// Checksum 0x1f7ddf7b, Offset: 0x3518
// Size: 0x94
function function_f1daf14e( str_area )
{
    var_af1a2667 = undefined;
    
    switch ( str_area )
    {
        case "bridge_zone":
            var_af1a2667 = "fxexp_300";
            break;
        default:
            var_af1a2667 = "fxexp_320";
            break;
        case "enter_forest_east_zone":
            var_af1a2667 = "fxexp_340";
            break;
    }
    
    if ( isdefined( var_af1a2667 ) )
    {
        exploder::exploder( var_af1a2667 );
    }
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0xfa6b88dc, Offset: 0x35b8
// Size: 0x6c
function zombie_moon_receiving_hatch_init()
{
    hatches = getentarray( "recieving_hatch", "targetname" );
    array::thread_all( hatches, &zombie_moon_hatch );
    level thread function_8ceda02();
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0x9482e28a, Offset: 0x3630
// Size: 0x12c
function zombie_moon_hatch()
{
    scale = 1;
    level flag::wait_till( "power_on" );
    self playsound( "evt_loading_door_start" );
    
    if ( isdefined( self.script_vector ) )
    {
        vector = vectorscale( self.script_vector, scale );
        self moveto( self.origin + vector, 1 );
        
        if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "hatch_clip" )
        {
            self thread zm_blockers::disconnect_paths_when_done();
        }
        else
        {
            self notsolid();
            self connectpaths();
        }
        
        wait 1;
        self playsound( "evt_loading_door_end" );
    }
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0xd3c4b6e, Offset: 0x3768
// Size: 0x152
function function_8ceda02()
{
    a_nd_traversal = getnodearray( "hatch_node", "targetname" );
    
    foreach ( node in a_nd_traversal )
    {
        unlinktraversal( node );
    }
    
    level flag::wait_till( "power_on" );
    wait 1;
    
    foreach ( node in a_nd_traversal )
    {
        linktraversal( node );
    }
}

// Namespace zm_moon_utility
// Params 0
// Checksum 0x13ad6a4c, Offset: 0x38c8
// Size: 0xde
function sky_transition_fog_settings()
{
    players = getplayers();
    
    if ( level flag::get( "enter_nml" ) )
    {
        for ( i = 0; i < players.size ; i++ )
        {
            players[ i ] clientfield::set_to_player( "player_sky_transition", 1 );
        }
        
        return;
    }
    
    for ( i = 0; i < players.size ; i++ )
    {
        players[ i ] clientfield::set_to_player( "player_sky_transition", 0 );
    }
}

