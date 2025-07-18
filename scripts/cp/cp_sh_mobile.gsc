#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_safehouse;
#using scripts/cp/_util;
#using scripts/cp/cp_sh_mobile_fx;
#using scripts/cp/cp_sh_mobile_sound;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace cp_sh_mobile;

// Namespace cp_sh_mobile
// Params 0
// Checksum 0x47babaeb, Offset: 0x3d0
// Size: 0xdc
function main()
{
    cp_sh_mobile_fx::main();
    cp_sh_mobile_sound::main();
    load::main();
    level thread set_ambient_state();
    level thread setup_vignettes();
    level scene::add_scene_func( "p_player_enter_readyroom_mobile", &function_1b1968a9, "init" );
    level.var_8ea79b65 = &function_6c5a247e;
    level.var_58373e3b = &function_3a7a79ca;
    level.var_f3db725a = &function_9e35a10d;
}

// Namespace cp_sh_mobile
// Params 0
// Checksum 0x5f5a8c9d, Offset: 0x4b8
// Size: 0x18c
function set_ambient_state()
{
    level thread function_6d9e2e34();
    level flag::wait_till( "all_players_connected" );
    safehouse::function_a85e8026( 2 );
    level thread function_301c79b5( 1 );
    
    switch ( level.next_map )
    {
        case "cp_mi_eth_prologue":
            level util::set_lighting_state( 0 );
            break;
        case "cp_mi_cairo_ramses":
        case "cp_mi_cairo_ramses2":
        case "cp_mi_cairo_ramses3":
            level util::set_lighting_state( 1 );
            safehouse::function_a85e8026( 1 );
            function_301c79b5( 2 );
            break;
        default:
            level util::set_lighting_state( 1 );
            safehouse::function_a85e8026( 3 );
            function_301c79b5( 3 );
            break;
    }
    
    level.var_ac964c36 = 1;
    level thread rumbles();
}

// Namespace cp_sh_mobile
// Params 1
// Checksum 0xeb9f479c, Offset: 0x650
// Size: 0x3c
function function_1b1968a9( a_ents )
{
    mdl_door = a_ents[ "safe_room_door" ];
    mdl_door notsolid();
}

// Namespace cp_sh_mobile
// Params 0
// Checksum 0x4a96affe, Offset: 0x698
// Size: 0x180
function rumbles()
{
    v_source = ( 56, 0, 439 );
    
    while ( true )
    {
        if ( randomint( 100 ) < 20 )
        {
            wait randomfloatrange( 0.5, 3 );
        }
        else
        {
            wait randomfloatrange( 5, 10 );
        }
        
        n_rand = randomint( 100 );
        
        if ( isdefined( level.var_ac964c36 ) && level.var_ac964c36 )
        {
            if ( n_rand < 10 )
            {
                earthquake( 0.2, 0.75, v_source, 2000 );
            }
            else if ( n_rand < 40 )
            {
                earthquake( 0.1, 0.75, v_source, 2000 );
            }
            else
            {
                earthquake( 0.1, 0.5, v_source, 2000 );
            }
            
            playsoundatposition( "evt_fuselage_shake", v_source );
        }
    }
}

// Namespace cp_sh_mobile
// Params 0
// Checksum 0xacf3d6a5, Offset: 0x820
// Size: 0x13a
function function_6d9e2e34()
{
    level.var_ea4a62a = util::spawn_model( "tag_origin" );
    callback::on_spawned( &function_eb7433ac );
    
    while ( true )
    {
        n_degree = randomfloatrange( 0.25, 1 );
        n_time = randomfloatrange( 3, 6 );
        level.var_ea4a62a rotateroll( n_degree, n_time, n_time / 2, n_time / 2 );
        level.var_ea4a62a waittill( #"rotatedone" );
        level.var_ea4a62a rotateroll( n_degree * -1, n_time, n_time / 2, n_time / 2 );
        level.var_ea4a62a waittill( #"rotatedone" );
    }
}

// Namespace cp_sh_mobile
// Params 0
// Checksum 0x4253ab1f, Offset: 0x968
// Size: 0x90
function function_eb7433ac()
{
    self endon( #"death" );
    
    while ( true )
    {
        self playersetgroundreferenceent( level.var_ea4a62a );
        self flag::wait_till( "in_training_sim" );
        self playersetgroundreferenceent( undefined );
        self flag::wait_till_clear( "in_training_sim" );
    }
}

// Namespace cp_sh_mobile
// Params 0
// Checksum 0x4989b921, Offset: 0xa00
// Size: 0xe4
function function_9ca26ba0()
{
    while ( true )
    {
        n_degree = randomfloatrange( 0.25, 1 );
        n_time = randomfloatrange( 3, 6 );
        self rotateroll( n_degree, n_time, n_time / 2, n_time / 2 );
        self waittill( #"rotatedone" );
        self rotateroll( n_degree * -1, n_time, n_time / 2, n_time / 2 );
        self waittill( #"rotatedone" );
    }
}

// Namespace cp_sh_mobile
// Params 0
// Checksum 0x76b31c5, Offset: 0xaf0
// Size: 0x5a
function function_6c5a247e()
{
    switch ( level.next_map )
    {
        case "cp_mi_eth_prologue":
            util::set_lighting_state( 1 );
            break;
        default:
            util::set_lighting_state( 0 );
            break;
    }
}

// Namespace cp_sh_mobile
// Params 0
// Checksum 0x19dbe7cb, Offset: 0xb58
// Size: 0x14
function function_3a7a79ca()
{
    util::set_lighting_state();
}

// Namespace cp_sh_mobile
// Params 0
// Checksum 0xb8b130a6, Offset: 0xb78
// Size: 0x1c
function function_9e35a10d()
{
    util::set_lighting_state( 1 );
}

// Namespace cp_sh_mobile
// Params 1
// Checksum 0xe8b216f5, Offset: 0xba0
// Size: 0x1a6
function function_301c79b5( n_num )
{
    wait 1;
    var_1d257bd1 = getent( "fxanim_skybox_01", "targetname" );
    var_4327f63a = getent( "fxanim_skybox_02", "targetname" );
    var_692a70a3 = getent( "fxanim_skybox_03", "targetname" );
    
    switch ( n_num )
    {
        case 1:
            var_1d257bd1 show();
            var_4327f63a hide();
            var_692a70a3 hide();
            break;
        case 2:
            var_1d257bd1 hide();
            var_4327f63a show();
            var_692a70a3 hide();
            break;
        case 3:
            var_1d257bd1 hide();
            var_4327f63a hide();
            var_692a70a3 show();
            break;
    }
}

// Namespace cp_sh_mobile
// Params 0
// Checksum 0x77062265, Offset: 0xd50
// Size: 0x2ce
function setup_vignettes()
{
    a_str_scenes = [];
    
    if ( !isdefined( a_str_scenes ) )
    {
        a_str_scenes = [];
    }
    else if ( !isarray( a_str_scenes ) )
    {
        a_str_scenes = array( a_str_scenes );
    }
    
    a_str_scenes[ a_str_scenes.size ] = "cin_ram_02_03_station_vign_bloodmopping_clean";
    
    if ( !isdefined( a_str_scenes ) )
    {
        a_str_scenes = [];
    }
    else if ( !isarray( a_str_scenes ) )
    {
        a_str_scenes = array( a_str_scenes );
    }
    
    a_str_scenes[ a_str_scenes.size ] = "cin_ram_02_03_station_vign_balcony_surveying_guy01";
    
    if ( !isdefined( a_str_scenes ) )
    {
        a_str_scenes = [];
    }
    else if ( !isarray( a_str_scenes ) )
    {
        a_str_scenes = array( a_str_scenes );
    }
    
    a_str_scenes[ a_str_scenes.size ] = "cin_ram_02_03_station_vign_balcony_surveying_guy02";
    
    if ( !isdefined( a_str_scenes ) )
    {
        a_str_scenes = [];
    }
    else if ( !isarray( a_str_scenes ) )
    {
        a_str_scenes = array( a_str_scenes );
    }
    
    a_str_scenes[ a_str_scenes.size ] = "cin_ram_02_03_station_vign_scaffold_inspecting";
    
    if ( !isdefined( a_str_scenes ) )
    {
        a_str_scenes = [];
    }
    else if ( !isarray( a_str_scenes ) )
    {
        a_str_scenes = array( a_str_scenes );
    }
    
    a_str_scenes[ a_str_scenes.size ] = "cin_saf_mob_armory_vign_repair_3dprinter";
    e_spawner = getent( "worker_spawner", "targetname" );
    a_str_scenes = array::randomize( a_str_scenes );
    n_vign_total = randomintrange( 2, 3 );
    
    /#
    #/
    
    for ( n_vign_index = 0; n_vign_index < n_vign_total ; n_vign_index++ )
    {
        str_scene = a_str_scenes[ n_vign_index ];
        level thread scene::play( str_scene, e_spawner );
    }
}

