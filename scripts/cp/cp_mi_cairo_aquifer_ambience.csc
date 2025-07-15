#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;

#namespace aquifer_ambience;

// Namespace aquifer_ambience
// Params 0, eflags: 0x2
// Checksum 0x192961e2, Offset: 0x430
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "aquifer_ambience", &__init__, undefined, undefined );
}

// Namespace aquifer_ambience
// Params 0
// Checksum 0xaf1e6420, Offset: 0x470
// Size: 0x1cc
function __init__()
{
    clientfield::register( "toplayer", "show_sand_storm", 1, 1, "int", &show_sand_storm, 0, 0 );
    clientfield::register( "world", "hide_sand_storm", 1, 1, "int", &hide_sand_storm, 0, 0 );
    clientfield::register( "world", "play_trucks", 1, 1, "int", &play_trucks, 0, 0 );
    clientfield::register( "world", "start_ambience", 1, 1, "int", &start_ambience, 0, 0 );
    clientfield::register( "world", "stop_ambience", 1, 1, "int", &stop_ambience, 0, 0 );
    clientfield::register( "world", "kill_ambience", 1, 1, "int", &kill_ambience, 0, 0 );
    level thread function_89b52898();
}

// Namespace aquifer_ambience
// Params 1
// Checksum 0xd226eeaf, Offset: 0x648
// Size: 0xc
function main( localclientnum )
{
    
}

// Namespace aquifer_ambience
// Params 7
// Checksum 0x6d3a76b3, Offset: 0x660
// Size: 0x172
function start_ambience( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !isdefined( level.scriptbundles[ "scene" ][ "p7_fxanim_cp_aqu_war_dogfight_main_loop_a_bundle_client" ] ) )
    {
        return;
    }
    
    thread function_ca056d7e();
    a_dogfights = struct::get_array( "p7_fxanim_cp_aqu_war_dogfight_main_loop_a_bundle_client", "scriptbundlename" );
    var_7056bf21 = struct::get( "p7_fxanim_cp_aqu_war_dogfight_a_jet_vtol_bundle", "scriptbundlename" );
    array::add( a_dogfights, var_7056bf21 );
    
    foreach ( d_fight in a_dogfights )
    {
        d_fight thread scene::play();
    }
}

// Namespace aquifer_ambience
// Params 7
// Checksum 0x385f71ec, Offset: 0x7e0
// Size: 0x2cc
function stop_ambience( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    level notify( #"hash_9e245bdd" );
    
    if ( !isdefined( level.var_c2750169 ) )
    {
        level.var_c2750169 = [];
    }
    
    foreach ( jet in level.var_c2750169 )
    {
        jet thread scene::stop( 1 );
        jet.scene_played = 0;
    }
    
    a_dogfights = struct::get_array( "p7_fxanim_cp_aqu_war_dogfight_main_loop_a_bundle_client", "scriptbundlename" );
    var_7056bf21 = struct::get( "p7_fxanim_cp_aqu_war_dogfight_a_jet_vtol_bundle", "scriptbundlename" );
    var_ffd496bd = struct::get( "p7_fxanim_cp_aqu_war_patrol_a_vtol_nrc_bundle", "scriptbundlename" );
    var_63f986ef = struct::get( "p7_fxanim_cp_aqu_war_patrol_a_vtol_egypt_bundle", "scriptbundlename" );
    array::add( a_dogfights, var_7056bf21 );
    array::add( a_dogfights, var_ffd496bd );
    array::add( a_dogfights, var_63f986ef );
    
    foreach ( d_fight in a_dogfights )
    {
        d_fight thread scene::stop( 1 );
        d_fight.scene_played = 0;
    }
    
    array::run_all( level.var_c2750169, &scene::stop, 1 );
}

// Namespace aquifer_ambience
// Params 7
// Checksum 0x91e51f21, Offset: 0xab8
// Size: 0x344
function kill_ambience( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    level notify( #"hash_9e245bdd" );
    
    if ( isdefined( level.var_c2750169 ) )
    {
        foreach ( jet in level.var_c2750169 )
        {
            jet thread scene::stop( 1 );
            jet.scene_played = 0;
        }
    }
    
    a_dogfights = struct::get_array( "p7_fxanim_cp_aqu_war_dogfight_main_loop_a_bundle_client", "scriptbundlename" );
    var_7056bf21 = struct::get( "p7_fxanim_cp_aqu_war_dogfight_a_jet_vtol_bundle", "scriptbundlename" );
    var_ffd496bd = struct::get( "p7_fxanim_cp_aqu_war_patrol_a_vtol_nrc_bundle", "scriptbundlename" );
    var_63f986ef = struct::get( "p7_fxanim_cp_aqu_war_patrol_a_vtol_egypt_bundle", "scriptbundlename" );
    array::add( a_dogfights, var_7056bf21 );
    array::add( a_dogfights, var_ffd496bd );
    array::add( a_dogfights, var_63f986ef );
    
    foreach ( d_fight in a_dogfights )
    {
        d_fight thread scene::stop( 1 );
    }
    
    waittillframeend();
    struct::delete_script_bundle( "scene", "p7_fxanim_cp_aqu_war_dogfight_main_loop_a_bundle_client" );
    struct::delete_script_bundle( "scene", "p7_fxanim_cp_aqu_war_dogfight_a_jet_vtol_bundle" );
    struct::delete_script_bundle( "scene", "p7_fxanim_cp_aqu_warpatrol_a_vtol_nrc_bundle" );
    struct::delete_script_bundle( "scene", "p7_fxanim_cp_aqu_warpatrol_a_vtol_egypt_bundle" );
    struct::delete_script_bundle( "scene", "p7_fxanim_cp_aqu_war_flyover_a_jet_bundle" );
    struct::delete_script_bundle( "scene", "p7_fxanim_cp_aqu_war_flyover_b_jet_bundle" );
}

// Namespace aquifer_ambience
// Params 0
// Checksum 0x97e01c72, Offset: 0xe08
// Size: 0x23e
function function_ca056d7e()
{
    a_pos = struct::get_array( "jet_flyover_pos", "targetname" );
    
    if ( a_pos.size == 0 )
    {
        return;
    }
    
    var_ed7818f9 = [];
    array::add( var_ed7818f9, "p7_fxanim_cp_aqu_war_flyover_a_jet_bundle" );
    array::add( var_ed7818f9, "p7_fxanim_cp_aqu_war_flyover_b_jet_bundle" );
    
    if ( isdefined( level.var_c2750169 ) )
    {
        foreach ( jet in level.var_c2750169 )
        {
            if ( jet scene::is_playing() )
            {
                jet scene::stop();
            }
        }
    }
    
    level notify( #"hash_9e245bdd" );
    
    if ( !isdefined( level.var_c2750169 ) )
    {
        level.var_c2750169 = [];
        
        for ( i = 0; i < 12 ; i++ )
        {
            level.var_c2750169[ level.var_c2750169.size ] = struct::spawn( a_pos[ i ].origin, a_pos[ i ].angles );
        }
    }
    
    for ( i = 0; i < 12 ; i++ )
    {
        level.var_c2750169[ i ] thread function_5794dab9( var_ed7818f9[ i % 2 ], randomfloatrange( 0, 20 ) );
    }
}

// Namespace aquifer_ambience
// Params 2
// Checksum 0x127d9830, Offset: 0x1050
// Size: 0x54
function function_5794dab9( s_bundle, delay )
{
    level endon( #"hash_9e245bdd" );
    level endon( #"inside_aquifer" );
    level endon( #"inside_water_room" );
    wait delay;
    self thread scene::play( s_bundle );
}

// Namespace aquifer_ambience
// Params 7
// Checksum 0x3110c74d, Offset: 0x10b0
// Size: 0xa4
function hide_sand_storm( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    s_storm = getentarray( localclientnum, "sand_storm", "targetname" );
    
    if ( s_storm.size > 0 )
    {
        array::run_all( s_storm, &visible, 0 );
    }
}

// Namespace aquifer_ambience
// Params 7
// Checksum 0x4d1ad5dd, Offset: 0x1160
// Size: 0xa4
function show_sand_storm( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    s_storm = getentarray( localclientnum, "sand_storm", "targetname" );
    
    if ( s_storm.size > 0 )
    {
        array::run_all( s_storm, &visible, 1 );
    }
}

// Namespace aquifer_ambience
// Params 1
// Checksum 0x802451d1, Offset: 0x1210
// Size: 0x44
function visible( bool )
{
    if ( bool )
    {
        self show();
        return;
    }
    
    self hide();
}

// Namespace aquifer_ambience
// Params 7
// Checksum 0x8a4a502, Offset: 0x1260
// Size: 0xec
function play_trucks( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !isdefined( level.scriptbundles[ "scene" ][ "p7_fxanim_cp_aqu_war_groundassault_bundle" ] ) )
    {
        return;
    }
    
    pos = getent( localclientnum, "dogfighting_scene_client_side", "targetname" );
    pos scene::play( "p7_fxanim_cp_aqu_war_groundassault_bundle" );
    pos scene::stop( "p7_fxanim_cp_aqu_war_groundassault_bundle", 1 );
    waittillframeend();
    struct::delete_script_bundle( "scene", "p7_fxanim_cp_aqu_war_groundassault_bundle" );
}

// Namespace aquifer_ambience
// Params 0
// Checksum 0x33e438b1, Offset: 0x1358
// Size: 0x34
function function_89b52898()
{
    level waittill( #"hash_496d3ee1" );
    audio::playloopat( "amb_postwateroom_weird_lp", ( 12618, 1364, 2949 ) );
}

