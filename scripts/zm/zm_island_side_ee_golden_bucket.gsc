#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_ai_spiders;
#using scripts/zm/_zm_attackables;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_keeper_skull;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/bgbs/_zm_bgb_anywhere_but_here;
#using scripts/zm/bgbs/_zm_bgb_pop_shocks;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/zm_island_perks;
#using scripts/zm/zm_island_planting;
#using scripts/zm/zm_island_power;
#using scripts/zm/zm_island_util;

#namespace side_ee_golden_bucket;

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0x2b91f652, Offset: 0x988
// Size: 0x2c
function init()
{
    register_clientfields();
    
    /#
        function_66eeac50();
    #/
}

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0x20759ac0, Offset: 0x9c0
// Size: 0x64
function register_clientfields()
{
    clientfield::register( "world", "reveal_golden_bucket_planting_location", 9000, 1, "int" );
    clientfield::register( "scriptmover", "golden_bucket_glow_fx", 9000, 1, "int" );
}

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0x7f8014d0, Offset: 0xa30
// Size: 0x1c
function main()
{
    level thread function_ee79f2bd();
}

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0xa62e7d02, Offset: 0xa58
// Size: 0x234
function function_ee79f2bd()
{
    level flag::init( "prereq_plants_grown_golden_bucket_ee" );
    level flag::init( "bucket_planted" );
    level flag::init( "golden_bucket_ee_completed" );
    level thread function_8db1ed35();
    s_planting_spot = struct::get( "planting_spot_golden_bucket", "targetname" );
    s_planting_spot.model = util::spawn_model( "p7_zm_isl_plant_planter", s_planting_spot.origin, s_planting_spot.angles );
    s_planting_spot.s_plant = spawnstruct();
    s_planting_spot.s_plant.model = util::spawn_model( "tag_origin", s_planting_spot.origin, s_planting_spot.angles );
    level flag::wait_till( "skull_quest_complete" );
    level flag::wait_till( "prereq_plants_grown_golden_bucket_ee" );
    
    foreach ( player in level.players )
    {
        player thread function_e6cfa209();
    }
    
    callback::on_spawned( &function_e6cfa209 );
}

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0x516acece, Offset: 0xc98
// Size: 0x64
function function_8db1ed35()
{
    level util::waittill_multiple( "minor_cache_plant_spawned", "major_cache_plant_spawned", "babysitter_plant_spawned", "trap_plant_spawned", "fruit_plant_spawned" );
    level flag::set( "prereq_plants_grown_golden_bucket_ee" );
}

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0x6eb61b13, Offset: 0xd08
// Size: 0x15a
function function_e6cfa209()
{
    self endon( #"disconnect" );
    level endon( #"hash_e6cfa209" );
    e_clip = getent( "swamp_planter_skull_reveal", "targetname" );
    
    while ( true )
    {
        if ( self util::ads_button_held() )
        {
            if ( self getcurrentweapon() !== level.var_c003f5b )
            {
                while ( self adsbuttonpressed() )
                {
                    wait 0.05;
                }
            }
            else if ( self getammocount( level.var_c003f5b ) )
            {
                if ( self keeper_skull::function_3f3f64e9( e_clip ) && self keeper_skull::function_5fa274c1( e_clip ) )
                {
                    break;
                }
            }
        }
        
        wait 0.1;
    }
    
    level thread function_26f677a6( e_clip );
    callback::remove_on_spawned( &function_e6cfa209 );
    level notify( #"hash_e6cfa209" );
}

// Namespace side_ee_golden_bucket
// Params 1
// Checksum 0x36c28675, Offset: 0xe70
// Size: 0x1a4
function function_26f677a6( e_clip )
{
    level clientfield::set( "reveal_golden_bucket_planting_location", 1 );
    playsoundatposition( "zmb_wpn_skullgun_discover", e_clip.origin );
    exploder::exploder( "fxexp_515" );
    wait 3;
    e_clip delete();
    s_planting_spot = struct::get( "planting_spot_golden_bucket", "targetname" );
    s_planting_spot.script_unitrigger_type = "unitrigger_box_use";
    s_planting_spot.cursor_hint = "HINT_NOICON";
    s_planting_spot.script_width = 128;
    s_planting_spot.script_height = 128;
    s_planting_spot.script_length = 128;
    s_planting_spot.require_look_at = 1;
    s_planting_spot.prompt_and_visibility_func = &function_4fd948c5;
    zm_unitrigger::register_static_unitrigger( s_planting_spot, &function_870bdfee );
    level flag::wait_till( "bucket_planted" );
    zm_unitrigger::unregister_unitrigger( s_planting_spot );
}

// Namespace side_ee_golden_bucket
// Params 1
// Checksum 0x77fa9d63, Offset: 0x1020
// Size: 0x98
function function_4fd948c5( player )
{
    if ( player clientfield::get_to_player( "bucket_held" ) && !level flag::get( "bucket_planted" ) )
    {
        self sethintstring( &"ZM_ISLAND_PLANT_BUCKET" );
        return 1;
    }
    
    self sethintstring( "" );
    return 0;
}

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0x845acc53, Offset: 0x10c0
// Size: 0xb0
function function_870bdfee()
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
        
        if ( player clientfield::get_to_player( "bucket_held" ) )
        {
            self thread function_9b3bd7c4( player );
        }
    }
}

// Namespace side_ee_golden_bucket
// Params 1
// Checksum 0xb891e83f, Offset: 0x1178
// Size: 0x144
function function_9b3bd7c4( e_player )
{
    level flag::set( "bucket_planted" );
    e_player thread zm_island_power::function_4b057b64();
    self.stub.s_plant.model setmodel( "p7_fxanim_zm_island_plant_seed_mod" );
    self.stub.s_plant.model show();
    self.stub.s_plant.model notsolid();
    self scene::init( "p7_fxanim_zm_island_plant_stage1_bundle", self.stub.s_plant.model );
    self.stub.s_plant.model playsound( "evt_island_seed_grow_stage_1" );
    level thread function_4cebde70();
}

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0xd2a330ac, Offset: 0x12c8
// Size: 0x194
function function_4cebde70()
{
    level thread function_c2dab6c5();
    exploder::exploder( "fxexp_800" );
    wait 2;
    var_fc72ce0a = struct::get_array( "planting_spot_golden_bucket_challenge", "targetname" );
    
    foreach ( s_planting_spot in var_fc72ce0a )
    {
        s_planting_spot.model = util::spawn_model( "p7_zm_isl_plant_planter", s_planting_spot.origin, s_planting_spot.angles );
        s_planting_spot.model movez( 16, 2 );
        playsoundatposition( "zmb_planters_appear", s_planting_spot.origin );
    }
    
    s_planting_spot.model waittill( #"movedone" );
    level thread function_152720d8( var_fc72ce0a );
}

// Namespace side_ee_golden_bucket
// Params 1
// Checksum 0x1b6ac74b, Offset: 0x1468
// Size: 0xe4
function function_152720d8( var_fc72ce0a )
{
    foreach ( var_8c46024b in var_fc72ce0a )
    {
        var_8c46024b.origin = var_8c46024b.model.origin;
        var_8c46024b zm_island_planting::function_fedc998b( 1 );
    }
    
    level.a_s_planting_spots = arraycombine( level.a_s_planting_spots, var_fc72ce0a, 0, 0 );
}

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0x559ce7c0, Offset: 0x1558
// Size: 0xf0
function function_c2dab6c5()
{
    e_volume = getent( "golden_bucket_ee_volume", "targetname" );
    
    while ( !level flag::get( "golden_bucket_ee_completed" ) )
    {
        while ( true )
        {
            if ( function_9a2f5188( e_volume ) && function_e630b27f() )
            {
                break;
            }
            
            wait 1;
        }
        
        level thread function_64b86454();
        level thread function_738acad6();
        level thread function_f0d8de1d();
        function_21bde96b();
    }
}

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0x9c7ab744, Offset: 0x1650
// Size: 0x7c
function function_21bde96b()
{
    level endon( #"hash_247c3608" );
    
    for ( var_79f8fdda = 0; var_79f8fdda < 50 ; var_79f8fdda++ )
    {
        level waittill( #"hash_8c54f723" );
    }
    
    level flag::set( "golden_bucket_ee_completed" );
    level notify( #"hash_4d1841e4" );
    level thread function_4d1841e4();
}

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0xbea4e365, Offset: 0x16d8
// Size: 0x4e
function function_64b86454()
{
    level endon( #"hash_4d1841e4" );
    
    while ( true )
    {
        if ( !function_e630b27f() )
        {
            break;
        }
        
        wait 1;
    }
    
    level notify( #"hash_247c3608" );
}

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0x1340e0cc, Offset: 0x1730
// Size: 0x34
function function_738acad6()
{
    level endon( #"hash_247c3608" );
    level endon( #"hash_4d1841e4" );
    wait 600;
    level thread function_72c0a344();
}

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0x8524d8ac, Offset: 0x1770
// Size: 0xe8
function function_f0d8de1d()
{
    level endon( #"hash_247c3608" );
    level endon( #"hash_62e8dbc1" );
    level endon( #"hash_4d1841e4" );
    e_volume = getent( "golden_bucket_ee_volume", "targetname" );
    n_timeout = 120;
    
    while ( true )
    {
        n_counter = n_timeout;
        
        while ( !function_9a2f5188( e_volume ) )
        {
            n_counter -= 1;
            
            if ( n_counter == 0 )
            {
                level thread function_72c0a344();
                level notify( #"hash_62e8dbc1" );
            }
            
            wait 1;
        }
        
        wait 0.05;
    }
}

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0xb928972c, Offset: 0x1860
// Size: 0xc2
function function_72c0a344()
{
    var_fc72ce0a = struct::get_array( "planting_spot_golden_bucket_challenge", "targetname" );
    
    foreach ( var_8c46024b in var_fc72ce0a )
    {
        var_8c46024b thread function_c1f64636( 0 );
        wait 0.05;
    }
}

// Namespace side_ee_golden_bucket
// Params 1
// Checksum 0x9aac77a1, Offset: 0x1930
// Size: 0xbc, Type: bool
function function_9a2f5188( e_volume )
{
    a_players = getplayers();
    
    foreach ( player in a_players )
    {
        if ( player istouching( e_volume ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0x28bc77bd, Offset: 0x19f8
// Size: 0xfc, Type: bool
function function_e630b27f()
{
    var_fc72ce0a = struct::get_array( "planting_spot_golden_bucket_challenge", "targetname" );
    
    foreach ( var_8c46024b in var_fc72ce0a )
    {
        if ( isdefined( var_8c46024b.s_plant ) && isdefined( var_8c46024b.s_plant.var_b454101b ) && var_8c46024b.s_plant.var_b454101b.health > 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0xc87a7d21, Offset: 0x1b00
// Size: 0x62c
function function_4d1841e4()
{
    level flag::init( "golden_bucket_cache_plant_opened" );
    level flag::init( "golden_bucket_planters_empty" );
    playsoundatposition( "zmb_golden_bucket_success", ( 0, 0, 0 ) );
    level thread function_6742be8f();
    var_fc72ce0a = struct::get_array( "planting_spot_golden_bucket_challenge", "targetname" );
    
    foreach ( var_8c46024b in var_fc72ce0a )
    {
        var_8c46024b thread function_c1f64636( 1 );
        wait 0.05;
    }
    
    level flag::wait_till( "golden_bucket_planters_empty" );
    function_41280a71();
    s_planting_spot = struct::get( "planting_spot_golden_bucket", "targetname" );
    s_planting_spot.s_plant.model clientfield::set( "plant_growth_siege_anims", 1 );
    s_planting_spot scene::play( "p7_fxanim_zm_island_plant_stage1_bundle", s_planting_spot.s_plant.model );
    s_planting_spot.s_plant.model playsound( "evt_island_seed_grow_stage_2" );
    wait 2;
    s_planting_spot.s_plant.model solid();
    s_planting_spot.s_plant.model disconnectpaths();
    s_planting_spot.s_plant.model clientfield::set( "plant_growth_siege_anims", 2 );
    s_planting_spot scene::play( "p7_fxanim_zm_island_plant_stage2_bundle", s_planting_spot.s_plant.model );
    s_planting_spot.s_plant.model playsound( "evt_island_seed_grow_stage_3" );
    wait 2;
    s_planting_spot.s_plant.model clientfield::set( "plant_growth_siege_anims", 3 );
    s_planting_spot thread scene::play( "p7_fxanim_zm_island_plant_stage3_bundle", s_planting_spot.s_plant.model );
    s_planting_spot.s_plant.model waittill( #"hash_116e737b" );
    s_planting_spot.s_plant.model setmodel( "p7_fxanim_zm_island_plant_cache_major_glow_mod" );
    s_planting_spot.s_plant.model clientfield::set( "cache_plant_interact_fx", 1 );
    s_planting_spot.s_plant.model disconnectpaths();
    s_planting_spot thread scene::init( "p7_fxanim_zm_island_plant_cache_major_bundle", s_planting_spot.s_plant.model );
    s_planting_spot.s_plant.model waittill( #"hash_aa2731d8" );
    s_planting_spot.prompt_and_visibility_func = &function_53296cde;
    zm_unitrigger::register_static_unitrigger( s_planting_spot, &function_30804104 );
    level flag::wait_till( "golden_bucket_cache_plant_opened" );
    s_planting_spot.s_plant.model clientfield::set( "cache_plant_interact_fx", 0 );
    zm_unitrigger::unregister_unitrigger( s_planting_spot );
    s_planting_spot scene::play( "p7_fxanim_zm_island_plant_cache_major_bundle", s_planting_spot.s_plant.model );
    m_reward = util::spawn_model( "p7_zm_isl_bucket_115_gold", s_planting_spot.origin + ( 0, 0, 36 ), s_planting_spot.angles );
    m_reward clientfield::set( "golden_bucket_glow_fx", 1 );
    playsoundatposition( "zmb_golden_bucket_appear", s_planting_spot.origin + ( 0, 0, 36 ) );
    wait 1;
    s_planting_spot.prompt_and_visibility_func = &function_53296cde;
    zm_unitrigger::register_static_unitrigger( s_planting_spot, &function_da9c118b );
}

// Namespace side_ee_golden_bucket
// Params 1
// Checksum 0xda7bd2ca, Offset: 0x2138
// Size: 0x194
function function_c1f64636( b_completed )
{
    if ( b_completed )
    {
        zm_unitrigger::unregister_unitrigger( self.s_plant_unitrigger );
        
        if ( isdefined( self.s_plant.var_b454101b ) )
        {
            self.s_plant.var_b454101b zm_attackables::deactivate();
            self notify( #"hash_4729ad2" );
        }
        
        wait 3;
        
        while ( true )
        {
            if ( isdefined( self.s_plant ) && isdefined( self.s_plant.var_b454101b ) )
            {
                self.s_plant.var_b454101b zm_attackables::do_damage( self.s_plant.var_b454101b.health );
            }
            
            if ( self.var_75c7a97e == 0 )
            {
                self notify( #"hash_7a0cef7b" );
                break;
            }
            
            wait 0.1;
        }
        
        level notify( #"hash_46080242" );
        arrayremovevalue( level.a_s_planting_spots, self );
        return;
    }
    
    if ( isdefined( self.s_plant ) && isdefined( self.s_plant.var_b454101b ) )
    {
        self.s_plant.var_b454101b zm_attackables::do_damage( self.s_plant.var_b454101b.health );
    }
}

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0x6a3d31dd, Offset: 0x22d8
// Size: 0x54
function function_6742be8f()
{
    for ( i = 0; i < 3 ; i++ )
    {
        level waittill( #"hash_46080242" );
    }
    
    level flag::set( "golden_bucket_planters_empty" );
}

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0x94cb8ff8, Offset: 0x2338
// Size: 0x202
function function_41280a71()
{
    exploder::exploder( "fxexp_801" );
    var_fc72ce0a = struct::get_array( "planting_spot_golden_bucket_challenge", "targetname" );
    
    foreach ( s_planting_spot in var_fc72ce0a )
    {
        s_planting_spot.s_plant.model linkto( s_planting_spot.model );
        s_planting_spot.model movez( -16, 2 );
        playsoundatposition( "zmb_planters_disappear", s_planting_spot.origin );
    }
    
    s_planting_spot.model waittill( #"movedone" );
    
    foreach ( s_planting_spot in var_fc72ce0a )
    {
        s_planting_spot.s_plant.model delete();
        s_planting_spot.model delete();
    }
}

// Namespace side_ee_golden_bucket
// Params 1
// Checksum 0x223011b1, Offset: 0x2548
// Size: 0xc0
function function_53296cde( player )
{
    if ( !level flag::get( "golden_bucket_cache_plant_opened" ) )
    {
        self sethintstring( &"ZM_ISLAND_CACHE_PLANT" );
        return 1;
    }
    
    if ( !( isdefined( player.var_b6a244f9 ) && player.var_b6a244f9 ) )
    {
        self sethintstring( &"ZM_ISLAND_PICKUP_GOLDEN_BUCKET" );
        return 1;
    }
    
    self sethintstring( "" );
    return 0;
}

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0x1b79bf1c, Offset: 0x2610
// Size: 0x98
function function_30804104()
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
        
        level flag::set( "golden_bucket_cache_plant_opened" );
    }
}

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0xf5a6de40, Offset: 0x26b0
// Size: 0xc8
function function_da9c118b()
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
        
        if ( !( isdefined( player.var_b6a244f9 ) && player.var_b6a244f9 ) )
        {
            player thread function_bbd146a7();
            player notify( #"player_got_gold_bucket" );
        }
    }
}

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0x9159fcc8, Offset: 0x2780
// Size: 0x4c
function function_bbd146a7()
{
    self endon( #"disconnect" );
    self.var_b6a244f9 = 1;
    self zm_island_power::function_d570abb();
    self thread function_da0bbc71();
}

// Namespace side_ee_golden_bucket
// Params 0
// Checksum 0x67a5312c, Offset: 0x27d8
// Size: 0x11c
function function_da0bbc71()
{
    self endon( #"disconnect" );
    wait 3.75;
    
    while ( true )
    {
        if ( self meleebuttonpressed() && self sprintbuttonpressed() )
        {
            if ( self zm_utility::in_revive_trigger() )
            {
                wait 0.1;
                continue;
            }
            
            if ( self.is_drinking > 0 )
            {
                wait 0.1;
                continue;
            }
            
            if ( !zm_utility::is_player_valid( self ) )
            {
                wait 0.1;
                continue;
            }
            
            self.var_c6cad973 += 1;
            
            if ( self.var_c6cad973 > 3 )
            {
                self.var_c6cad973 = 1;
            }
            
            self thread zm_island_power::function_a84a1aec( self.var_c6cad973, 0 );
            wait 3.75;
            continue;
        }
        
        wait 0.1;
    }
}

/#

    // Namespace side_ee_golden_bucket
    // Params 0
    // Checksum 0x587ea36c, Offset: 0x2900
    // Size: 0x74, Type: dev
    function function_66eeac50()
    {
        zm_devgui::add_custom_devgui_callback( &function_3655d28a );
        adddebugcommand( "<dev string:x28>" );
        adddebugcommand( "<dev string:x7e>" );
        adddebugcommand( "<dev string:xe6>" );
    }

    // Namespace side_ee_golden_bucket
    // Params 1
    // Checksum 0xe3f9e170, Offset: 0x2980
    // Size: 0x1a2, Type: dev
    function function_3655d28a( cmd )
    {
        switch ( cmd )
        {
            default:
                level flag::set( "<dev string:x155>" );
                level flag::set( "<dev string:x17a>" );
                return 1;
            case "<dev string:x18f>":
                level flag::set( "<dev string:x155>" );
                level flag::set( "<dev string:x17a>" );
                e_clip = getent( "<dev string:x1a4>", "<dev string:x1bf>" );
                level thread function_26f677a6( e_clip );
                level notify( #"hash_e6cfa209" );
                return 1;
            case "<dev string:x1ca>":
                foreach ( player in level.players )
                {
                    player thread function_bbd146a7();
                }
                
                return 1;
        }
        
        return 0;
    }

#/
