#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_castle_teleporter;
#using scripts/zm/zm_castle_vo;

#namespace zm_castle_rocket_trap;

// Namespace zm_castle_rocket_trap
// Params 0
// Checksum 0x2f473a2b, Offset: 0x680
// Size: 0x6c
function main()
{
    register_clientfields();
    function_34ad16fc();
    level thread function_6827f93b();
    level.grenade_planted = &function_ff1f70cd;
    
    /#
        level thread function_65b37e40();
    #/
}

// Namespace zm_castle_rocket_trap
// Params 0
// Checksum 0x3fa75aba, Offset: 0x6f8
// Size: 0xc4
function register_clientfields()
{
    clientfield::register( "world", "rocket_trap_warning_smoke", 1, 1, "int" );
    clientfield::register( "world", "rocket_trap_warning_fire", 1, 1, "int" );
    clientfield::register( "world", "sndRocketAlarm", 5000, 2, "int" );
    clientfield::register( "world", "sndRocketTrap", 5000, 3, "int" );
}

// Namespace zm_castle_rocket_trap
// Params 0
// Checksum 0x4aacd98c, Offset: 0x7c8
// Size: 0x12c
function function_6827f93b()
{
    n_timeout = randomintrange( 30, 240 );
    level waittill( #"castle_teleporter_used" );
    level thread function_79ce76bb();
    level.zones[ "zone_v10_pad_exterior" ].is_spawning_allowed = 1;
    level.zones[ "zone_v10_pad_door" ].is_spawning_allowed = 1;
    level.zones[ "zone_v10_pad" ].adjacent_zones[ "zone_v10_pad_door" ].is_connected = 1;
    wait 60;
    
    while ( true )
    {
        level util::waittill_any_timeout( n_timeout, "rocket_blast", "powerup_dropped" );
        function_713600fe();
        n_timeout = randomintrange( 90, 300 );
    }
}

// Namespace zm_castle_rocket_trap
// Params 1
// Checksum 0xd4f22463, Offset: 0x900
// Size: 0x63c
function function_713600fe( var_44f606ad )
{
    if ( !isdefined( var_44f606ad ) )
    {
        var_44f606ad = 0;
    }
    
    if ( level flag::get( "rocket_firing" ) )
    {
        return;
    }
    
    var_69192d95 = struct::get( "rocket_trap_rumble_source", "targetname" );
    var_ac6452ae = getentarray( "rocket_tunnel_door_r", "targetname" );
    var_ac6452ae array::thread_all( var_ac6452ae, &function_e52f317f, 0, 10 );
    var_1b5666fb = getentarray( "rocket_tunnel_door_l", "targetname" );
    var_1b5666fb array::thread_all( var_1b5666fb, &function_e52f317f, 1, 10 );
    level flag::set( "rocket_firing" );
    zm_castle_teleporter::function_ee24bc2e();
    level thread function_563e8bc8();
    level clientfield::set( "sndRocketAlarm", 1 );
    exploder::exploder( "fx_rocket_trap_01" );
    level clientfield::set( "sndRocketTrap", 1 );
    
    if ( !( isdefined( level.sndoutro ) && level.sndoutro ) )
    {
        playsoundatposition( "vox_maxis_rocket_pa_begin_0", ( 5231, -2514, -2150 ) );
    }
    
    wait 7;
    exploder::exploder( "fx_rocket_trap_02" );
    level thread function_92008f69( 0 );
    level thread function_fe2fe879( "zm_castle_rocket_trap_warning_rumble", var_69192d95.origin, 0.125 );
    level clientfield::set( "sndRocketTrap", 2 );
    
    if ( !( isdefined( level.sndoutro ) && level.sndoutro ) )
    {
        playsoundatposition( "vox_maxis_rocket_pa_doors_0", ( 5231, -2514, -2150 ) );
    }
    
    level thread function_447a5d62();
    wait 2;
    level notify( #"hash_d6ba1e76" );
    level thread function_3a4d6d70();
    wait 1;
    function_60a8040b( 10 );
    level clientfield::set( "sndRocketAlarm", 2 );
    exploder::exploder( "fx_rocket_trap_03" );
    exploder::exploder( "lgt_rocket_fire" );
    level notify( #"hash_1b4db1d1" );
    level thread function_fe2fe879( "zm_castle_rocket_trap_blast_rumble", var_69192d95.origin, 0.125 );
    level thread function_92008f69( 1 );
    level clientfield::set( "sndRocketTrap", 3 );
    level.zones[ "zone_v10_pad_exterior" ].is_spawning_allowed = 0;
    level.zones[ "zone_v10_pad_door" ].is_spawning_allowed = 0;
    level.zones[ "zone_v10_pad" ].adjacent_zones[ "zone_v10_pad_door" ].is_connected = 0;
    wait 20;
    exploder::stop_exploder( "fx_rocket_trap_03" );
    exploder::stop_exploder( "lgt_rocket_fire" );
    level notify( #"hash_1b4db1d1" );
    level clientfield::set( "sndRocketTrap", 4 );
    level.zones[ "zone_v10_pad_exterior" ].is_spawning_allowed = 1;
    level.zones[ "zone_v10_pad_door" ].is_spawning_allowed = 1;
    level.zones[ "zone_v10_pad" ].adjacent_zones[ "zone_v10_pad_door" ].is_connected = 1;
    level notify( #"open_a10_doors" );
    
    if ( isdefined( level.var_c62829c7 ) && !level flag::get( "rune_prison_obelisk" ) )
    {
        level thread flag::set_for_time( 7.5, "rune_prison_obelisk_magma_enabled" );
    }
    
    if ( !( isdefined( level.sndoutro ) && level.sndoutro ) )
    {
        playsoundatposition( "vox_maxis_rocket_pa_complete_0", ( 5231, -2514, -2150 ) );
    }
    
    level waittill( #"hash_c009e96d" );
    level flag::clear( "rocket_firing" );
    zm_castle_teleporter::function_ee24bc2e();
    
    if ( !( isdefined( var_44f606ad ) && var_44f606ad ) )
    {
        wait 120;
    }
}

// Namespace zm_castle_rocket_trap
// Params 2
// Checksum 0x5d493bc, Offset: 0xf48
// Size: 0x118
function function_e52f317f( is_left_door, n_time )
{
    if ( self.script_noteworthy === "clip" )
    {
        self thread function_343a73a4();
    }
    
    v_original_origin = self.origin;
    
    if ( is_left_door )
    {
        n_move_x = -24.5;
        var_80b1884b = -92.5;
    }
    else
    {
        n_move_x = 25.5;
        var_80b1884b = 92.5;
    }
    
    while ( true )
    {
        level waittill( #"hash_d6ba1e76" );
        self moveto( self.origin + ( n_move_x, var_80b1884b, 0 ), n_time );
        level waittill( #"open_a10_doors" );
        self moveto( v_original_origin, n_time * 0.75 );
    }
}

// Namespace zm_castle_rocket_trap
// Params 0
// Checksum 0xdb682194, Offset: 0x1068
// Size: 0x74
function function_34ad16fc()
{
    level.var_66385c9a = array( "vox_maxis_rocket_pa_ten_0", "vox_maxis_rocket_pa_nine_0", "vox_maxis_rocket_pa_eight_0", "vox_maxis_rocket_pa_seven_0", "vox_maxis_rocket_pa_six_0", "vox_maxis_rocket_pa_five_0", "vox_maxis_rocket_pa_four_0", "vox_maxis_rocket_pa_three_0", "vox_maxis_rocket_pa_two_0", "vox_maxis_rocket_pa_one_0", "vox_maxis_rocket_pa_initiating_0" );
}

// Namespace zm_castle_rocket_trap
// Params 0
// Checksum 0x63bcbbc4, Offset: 0x10e8
// Size: 0x7c
function function_3a4d6d70()
{
    for ( i = 0; i < level.var_66385c9a.size ; i++ )
    {
        if ( !( isdefined( level.sndoutro ) && level.sndoutro ) )
        {
            playsoundatposition( level.var_66385c9a[ i ], ( 5231, -2514, -2150 ) );
        }
        
        wait 1;
    }
}

// Namespace zm_castle_rocket_trap
// Params 0
// Checksum 0x55cd03c1, Offset: 0x1170
// Size: 0x1dc
function function_447a5d62()
{
    var_f96c9da7 = [];
    
    foreach ( e_player in level.activeplayers )
    {
        str_player_zone = e_player zm_zonemgr::get_player_zone();
        
        if ( str_player_zone === "zone_v10_pad_exterior" || str_player_zone === "zone_v10_pad_door" )
        {
            if ( zm_utility::is_player_valid( e_player ) )
            {
                if ( !isdefined( var_f96c9da7 ) )
                {
                    var_f96c9da7 = [];
                }
                else if ( !isarray( var_f96c9da7 ) )
                {
                    var_f96c9da7 = array( var_f96c9da7 );
                }
                
                var_f96c9da7[ var_f96c9da7.size ] = e_player;
            }
        }
    }
    
    if ( var_f96c9da7.size )
    {
        e_vo_player = array::random( var_f96c9da7 );
        
        /#
            iprintlnbold( "<dev string:x28>" );
        #/
        
        e_vo_player thread zm_castle_vo::vo_say( "vox_plr_" + e_vo_player.characterindex + "_rocket_start_" + randomint( 5 ), 1, 1 );
    }
}

// Namespace zm_castle_rocket_trap
// Params 1
// Checksum 0x5d60db0b, Offset: 0x1358
// Size: 0x3a
function function_60a8040b( var_d15b8c83 )
{
    for ( i = var_d15b8c83; i > 0 ; i-- )
    {
        wait 1;
    }
}

// Namespace zm_castle_rocket_trap
// Params 1
// Checksum 0x1632b86e, Offset: 0x13a0
// Size: 0x1e8
function function_92008f69( var_ec7cc126 )
{
    level endon( #"hash_1b4db1d1" );
    var_5f1ce845 = getent( "rocket_trap_blast_damage_vol", "targetname" );
    var_f38730c7 = getent( "rocket_trap_side_blast_damage_vol", "targetname" );
    
    while ( true )
    {
        if ( var_ec7cc126 )
        {
            array::thread_all( level.activeplayers, &function_76de618f, var_5f1ce845, 1 );
            array::thread_all( getaiteamarray( level.zombie_team ), &function_76de618f, var_5f1ce845, 1 );
            array::thread_all( level.activeplayers, &function_76de618f, var_f38730c7, 1 );
            array::thread_all( getaiteamarray( level.zombie_team ), &function_76de618f, var_f38730c7, 1 );
        }
        else
        {
            array::thread_all( level.activeplayers, &function_76de618f, var_5f1ce845, 0 );
            array::thread_all( getaiteamarray( level.zombie_team ), &function_76de618f, var_5f1ce845, 0 );
        }
        
        wait 0.4;
    }
}

// Namespace zm_castle_rocket_trap
// Params 2
// Checksum 0x26a473e5, Offset: 0x1590
// Size: 0x71c
function function_76de618f( vol_area, var_ec7cc126 )
{
    if ( !isdefined( var_ec7cc126 ) )
    {
        var_ec7cc126 = 0;
    }
    
    self endon( #"death" );
    
    if ( !isplayer( self ) && var_ec7cc126 == 1 )
    {
        self thread function_5acfb0f();
    }
    
    if ( !self istouching( vol_area ) )
    {
        return;
    }
    
    if ( isdefined( self.maxhealth ) )
    {
        var_499440d9 = self.maxhealth;
    }
    else
    {
        var_499440d9 = self.health;
    }
    
    if ( isdefined( var_ec7cc126 ) && var_ec7cc126 )
    {
        if ( isplayer( self ) )
        {
            if ( level flag::get( "solo_game" ) && self.lives > 0 )
            {
                a_s_respawn_points = struct::get_array( "player_respawn_point", "targetname" );
                a_s_points = [];
                
                foreach ( s_respawn_point in a_s_respawn_points )
                {
                    if ( s_respawn_point.script_noteworthy === "zone_v10_pad" )
                    {
                        array::add( a_s_points, s_respawn_point, 0 );
                    }
                }
                
                if ( isdefined( a_s_points ) )
                {
                    s_point = array::random( a_s_points );
                    self setorigin( s_point.origin );
                    self setplayerangles( s_point.angles );
                }
                
                util::wait_network_frame();
                playfx( level._effect[ "lightning_dog_spawn" ], self.origin );
                
                while ( isdefined( self.gravityspikes_slam ) && ( self isslamming() || self.gravityspikes_state === 3 && self.gravityspikes_slam ) )
                {
                    util::wait_network_frame();
                }
                
                self dodamage( var_499440d9, self.origin, undefined, undefined, undefined, "MOD_BURNED" );
            }
            else
            {
                if ( self laststand::player_is_in_laststand() )
                {
                    if ( level flag::get( "solo_game" ) )
                    {
                        self enableinvulnerability();
                        a_s_respawn_points = struct::get_array( "player_respawn_point", "targetname" );
                        a_s_points = [];
                        
                        foreach ( s_respawn_point in a_s_respawn_points )
                        {
                            if ( s_respawn_point.script_noteworthy === "zone_v10_pad" )
                            {
                                array::add( a_s_points, s_respawn_point, 0 );
                            }
                        }
                        
                        if ( isdefined( a_s_points ) )
                        {
                            s_point = array::random( a_s_points );
                            self setorigin( s_point.origin );
                            self setplayerangles( s_point.angles );
                        }
                        
                        util::wait_network_frame();
                        playfx( level._effect[ "lightning_dog_spawn" ], self.origin );
                        self disableinvulnerability();
                        return;
                    }
                    else if ( self.bleedout_time > 0 )
                    {
                        self.bleedout_time = 0;
                    }
                }
                else if ( var_499440d9 >= self.health )
                {
                    self.bleedout_time = 0.5;
                }
                
                self dodamage( var_499440d9, self.origin, undefined, undefined, undefined, "MOD_BURNED" );
            }
        }
        else
        {
            level.zombie_total++;
            level.zombie_respawns++;
            
            if ( isdefined( self.maxhealth ) && self.health < self.maxhealth )
            {
                if ( !isdefined( level.a_zombie_respawn_health[ self.archetype ] ) )
                {
                    level.a_zombie_respawn_health[ self.archetype ] = [];
                }
                
                if ( !isdefined( level.a_zombie_respawn_health[ self.archetype ] ) )
                {
                    level.a_zombie_respawn_health[ self.archetype ] = [];
                }
                else if ( !isarray( level.a_zombie_respawn_health[ self.archetype ] ) )
                {
                    level.a_zombie_respawn_health[ self.archetype ] = array( level.a_zombie_respawn_health[ self.archetype ] );
                }
                
                level.a_zombie_respawn_health[ self.archetype ][ level.a_zombie_respawn_health[ self.archetype ].size ] = self.health;
            }
            
            self dodamage( var_499440d9, self.origin, undefined, undefined, undefined, "MOD_BURNED" );
        }
        
        return;
    }
    
    var_499440d9 *= 0.25;
    self dodamage( var_499440d9, self.origin + ( 0, 100, 0 ), undefined, undefined, undefined, "MOD_BURNED" );
}

// Namespace zm_castle_rocket_trap
// Params 3
// Checksum 0x25d9ff93, Offset: 0x1cb8
// Size: 0x56
function function_fe2fe879( str_rumble, v_rumble_origin, n_duration )
{
    level endon( #"hash_1b4db1d1" );
    
    while ( true )
    {
        playrumbleonposition( str_rumble, v_rumble_origin );
        wait n_duration;
    }
}

// Namespace zm_castle_rocket_trap
// Params 0
// Checksum 0xce035761, Offset: 0x1d18
// Size: 0x20c
function function_5acfb0f()
{
    wait 1;
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    var_2d8a543 = getent( "zone_v10_pad", "targetname" );
    
    if ( self.archetype === "mechz" )
    {
        self.zone_name = zm_utility::get_current_zone();
    }
    
    if ( ( self.zone_name === "zone_v10_pad_door" || self.zone_name === "zone_v10_pad_exterior" ) && !self istouching( var_2d8a543 ) )
    {
        level.zombie_total++;
        level.zombie_respawns++;
        
        if ( isdefined( self.maxhealth ) && self.health < self.maxhealth )
        {
            if ( !isdefined( level.a_zombie_respawn_health[ self.archetype ] ) )
            {
                level.a_zombie_respawn_health[ self.archetype ] = [];
            }
            
            if ( !isdefined( level.a_zombie_respawn_health[ self.archetype ] ) )
            {
                level.a_zombie_respawn_health[ self.archetype ] = [];
            }
            else if ( !isarray( level.a_zombie_respawn_health[ self.archetype ] ) )
            {
                level.a_zombie_respawn_health[ self.archetype ] = array( level.a_zombie_respawn_health[ self.archetype ] );
            }
            
            level.a_zombie_respawn_health[ self.archetype ][ level.a_zombie_respawn_health[ self.archetype ].size ] = self.health;
        }
        
        self dodamage( self.health + 100, self.origin, undefined, undefined, undefined, "MOD_BURNED" );
    }
}

// Namespace zm_castle_rocket_trap
// Params 0
// Checksum 0x2e7ecd61, Offset: 0x1f30
// Size: 0x1c
function function_79ce76bb()
{
    exploder::exploder( "lgt_rocket_green" );
}

// Namespace zm_castle_rocket_trap
// Params 0
// Checksum 0x6b1445e8, Offset: 0x1f58
// Size: 0x9c
function function_563e8bc8()
{
    exploder::stop_exploder( "lgt_rocket_green" );
    
    while ( level flag::get( "rocket_firing" ) )
    {
        exploder::exploder( "lgt_rocket_red" );
        wait 0.25;
        exploder::stop_exploder( "lgt_rocket_red" );
        wait 0.25;
    }
    
    exploder::exploder( "lgt_rocket_green" );
}

/#

    // Namespace zm_castle_rocket_trap
    // Params 0
    // Checksum 0x52127f9, Offset: 0x2000
    // Size: 0xb8, Type: dev
    function function_65b37e40()
    {
        wait 0.05;
        level waittill( #"start_zombie_round_logic" );
        wait 0.05;
        setdvar( "<dev string:x4f>", 0 );
        adddebugcommand( "<dev string:x6b>" );
        
        while ( true )
        {
            if ( getdvarint( "<dev string:x4f>" ) )
            {
                setdvar( "<dev string:x4f>", 0 );
                level thread function_713600fe( 1 );
            }
            
            wait 0.5;
        }
    }

#/

// Namespace zm_castle_rocket_trap
// Params 0
// Checksum 0xa89d822b, Offset: 0x20c0
// Size: 0x1d4
function function_343a73a4()
{
    level waittill( #"hash_d6ba1e76" );
    self playsound( "evt_rocket_door_start" );
    self playloopsound( "evt_rocket_door_lp" );
    level.var_f363d488 = 1;
    
    foreach ( e_player in level.activeplayers )
    {
        self thread function_80af95ac( e_player );
    }
    
    self waittill( #"movedone" );
    level notify( #"hash_c009e96d" );
    level.var_f363d488 = undefined;
    self stoploopsound();
    self playsound( "evt_rocket_door_stop" );
    level waittill( #"open_a10_doors" );
    self playsound( "evt_rocket_door_start" );
    self playloopsound( "evt_rocket_door_lp" );
    self waittill( #"movedone" );
    level notify( #"hash_c009e96d" );
    self stoploopsound();
    self playsound( "evt_rocket_door_stop" );
}

// Namespace zm_castle_rocket_trap
// Params 2
// Checksum 0xef8f1ab3, Offset: 0x22a0
// Size: 0xf4
function function_ff1f70cd( e_grenade, mdl_grenade )
{
    e_grenade endon( #"death" );
    e_grenade endon( #"explode" );
    
    if ( e_grenade zm_zonemgr::entity_in_zone( "zone_v10_pad_door" ) || e_grenade.weapon.name === "cymbal_monkey" && e_grenade zm_zonemgr::entity_in_zone( "zone_v10_pad_exterior" ) )
    {
        while ( isdefined( level.zones[ "zone_v10_pad_door" ].is_spawning_allowed ) && level.zones[ "zone_v10_pad_door" ].is_spawning_allowed )
        {
            wait 0.1;
        }
        
        e_grenade detonate();
    }
}

// Namespace zm_castle_rocket_trap
// Params 1
// Checksum 0x5918d898, Offset: 0x23a0
// Size: 0x15e
function function_80af95ac( e_player )
{
    e_player endon( #"death" );
    e_player endon( #"hash_9265913f" );
    
    if ( !isdefined( e_player.var_37aa2a5b ) )
    {
        e_player.var_37aa2a5b = [];
    }
    
    while ( isdefined( level.var_f363d488 ) && level.var_f363d488 )
    {
        if ( e_player istouching( self ) )
        {
            array::add( e_player.var_37aa2a5b, self, 0 );
        }
        else
        {
            arrayremovevalue( e_player.var_37aa2a5b, self );
        }
        
        if ( e_player.var_37aa2a5b.size >= 2 )
        {
            e_player dodamage( e_player.health, e_player.origin, undefined, undefined, undefined, "MOD_IMPACT" );
            e_player.var_37aa2a5b = undefined;
            e_player notify( #"hash_9265913f" );
        }
        
        util::wait_network_frame();
    }
    
    e_player.var_37aa2a5b = undefined;
}

