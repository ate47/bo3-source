#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_zurich_coalescence_root_singapore;
#using scripts/cp/cp_mi_zurich_coalescence_sound;
#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_plaza_battle;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_street;
#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;

#namespace zurich_city;

// Namespace zurich_city
// Params 2
// Checksum 0x15acc795, Offset: 0xd60
// Size: 0x114
function skipto_main( str_objective, b_starting )
{
    load::function_73adcefc();
    level flag::init( "intro_igc_ready" );
    level flag::init( "intro_squad_ready_move" );
    function_a1dcdc1();
    level scene::init( "cin_zur_01_01_intro_1st_lost_contact" );
    load::function_c32ba481();
    level thread util::do_chyron_text( &"CP_MI_ZURICH_COALESCENCE_INTRO_LINE_1_FULL", "", &"CP_MI_ZURICH_COALESCENCE_INTRO_LINE_2_FULL", &"CP_MI_ZURICH_COALESCENCE_INTRO_LINE_2_SHORT", &"CP_MI_ZURICH_COALESCENCE_INTRO_LINE_3_FULL", &"CP_MI_ZURICH_COALESCENCE_INTRO_LINE_3_SHORT", &"CP_MI_ZURICH_COALESCENCE_INTRO_LINE_4_FULL", &"CP_MI_ZURICH_COALESCENCE_INTRO_LINE_4_FULL" );
    skipto::objective_completed( str_objective );
}

// Namespace zurich_city
// Params 4
// Checksum 0xd890427d, Offset: 0xe80
// Size: 0x12c
function skipto_done( str_objective, b_starting, b_direct, player )
{
    zurich_util::enable_surreal_ai_fx( 0 );
    level thread root_singapore::function_c38b8260();
    umbragate_set( "hq_atrium_umbra_gate", 0 );
    umbragate_set( "hq_entrance_umbra_gate", 0 );
    umbragate_set( "hq_exit_umbra_gate", 0 );
    umbragate_set( "garage_umbra_gate", 0 );
    var_fb9735b9 = [];
    var_fb9735b9[ 0 ] = getent( "plaza_battle_blast_door_left", "targetname" );
    var_fb9735b9[ 1 ] = getent( "plaza_battle_blast_door_right", "targetname" );
    array::delete_all( var_fb9735b9 );
}

// Namespace zurich_city
// Params 2
// Checksum 0x27ba7267, Offset: 0xfb8
// Size: 0x364
function function_9940e82f( str_objective, b_starting )
{
    spawner::add_spawn_function_group( "intro_ai", "script_noteworthy", &function_56e5aa4d );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        level flag::init( "intro_igc_ready" );
        level flag::init( "intro_squad_ready_move" );
        scene::add_scene_func( "cin_zur_01_01_intro_1st_lost_contact", &function_a1dcdc1, "init" );
        level scene::init( "cin_zur_01_01_intro_1st_lost_contact" );
    }
    
    level zurich_util::init_kane( str_objective, 1 );
    level.var_ebb30c1a = [];
    level thread zurich_street::function_48166ad7();
    level thread zurich_util::function_2361541e( "street" );
    level thread function_e3750802();
    level clientfield::set( "intro_ambience", 1 );
    exploder::exploder( "streets_tower_wasp_swarm" );
    level clientfield::set( "zurich_city_ambience", 1 );
    
    if ( b_starting )
    {
        load::function_a2995f22();
    }
    else
    {
        level waittill( #"chyron_menu_closed" );
        level thread util::screen_fade_in( 2 );
    }
    
    level thread function_37ee22ee();
    level flag::wait_till( "intro_igc_ready" );
    scene::add_scene_func( "cin_zur_01_01_intro_1st_lost_contact", &function_b8f105c6, "play" );
    scene::add_scene_func( "cin_zur_01_01_intro_1st_lost_contact", &function_5e558eb, "done" );
    level thread scene::play( "cin_zur_01_01_intro_1st_lost_contact" );
    array::thread_all( level.players, &zurich_util::function_41753e77, "dni_futz" );
    
    if ( isdefined( level.bzm_zurichdialogue1callback ) )
    {
        level thread [[ level.bzm_zurichdialogue1callback ]]();
    }
    
    level waittill( #"hash_1b75d876" );
    level clientfield::set( "gameplay_started", 1 );
    level thread zurich_street::function_1be1a835();
    
    if ( isdefined( str_objective ) )
    {
        skipto::objective_completed( str_objective );
    }
}

// Namespace zurich_city
// Params 4
// Checksum 0x35c8e591, Offset: 0x1328
// Size: 0x54
function function_40b9b738( str_objective, b_starting, b_direct, player )
{
    objectives::set( "cp_level_zurich_assault_hq_obj" );
    zurich_util::enable_surreal_ai_fx( 0 );
}

// Namespace zurich_city
// Params 0
// Checksum 0x9ead3f04, Offset: 0x1388
// Size: 0x3c2
function function_ab4451a1()
{
    level endon( #"hash_e0d14dc8" );
    n_count = 0;
    a_mdl_doors = [];
    a_s_doors = struct::get_array( "skybar_rollup_door" );
    
    foreach ( i, s_door in a_s_doors )
    {
        wait 0.05;
        a_mdl_doors[ i ] = util::spawn_model( "p7_loading_dock_rollup_door", s_door.origin, s_door.angles );
        a_mdl_doors[ i ].script_objective = "garage";
    }
    
    array::thread_all( a_mdl_doors, &function_52073baf );
    
    while ( true )
    {
        level waittill( #"hash_443f3c33" );
        a_mdl_doors = array::randomize( a_mdl_doors );
        
        foreach ( mdl in a_mdl_doors )
        {
            wait 0.15;
            mdl movez( 85, randomfloatrange( 0.9, 1.2 ) );
        }
        
        mdl waittill( #"movedone" );
        
        if ( !n_count )
        {
            var_c522d6c9 = zurich_util::function_33ec653f( "skybar_raven_enemy_spawn_manager", undefined, undefined, &zurich_util::function_d065a580 );
            n_count++;
        }
        else
        {
            var_c522d6c9 = zurich_util::function_33ec653f( "skybar_raven_enemy_spawn_manager2", undefined, undefined, &zurich_util::function_d065a580 );
            n_count--;
        }
        
        wait randomfloatrange( 3, 3.6 );
        a_mdl_doors = array::randomize( a_mdl_doors );
        
        foreach ( mdl in a_mdl_doors )
        {
            wait 0.15;
            mdl movez( 85 * -1, randomfloatrange( 0.9, 1.2 ) );
        }
        
        mdl waittill( #"movedone" );
        level notify( #"hash_2fa6d91" );
    }
}

// Namespace zurich_city
// Params 0
// Checksum 0x2e9be68b, Offset: 0x1758
// Size: 0xbc
function function_52073baf()
{
    self endon( #"death" );
    
    while ( true )
    {
        self setcandamage( 1 );
        self.health = 999999;
        self waittill( #"damage", n_damage, e_attacker, _, _, str_damage_type );
        
        if ( isplayer( e_attacker ) )
        {
            level notify( #"hash_443f3c33" );
            self setcandamage( 0 );
            level waittill( #"hash_2fa6d91" );
        }
    }
}

// Namespace zurich_city
// Params 2
// Checksum 0xc616af35, Offset: 0x1820
// Size: 0x384
function function_8fb45492( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        spawner::add_spawn_function_group( "intro_ai", "script_noteworthy", &function_56e5aa4d );
        level flag::set( "intro_squad_ready_move" );
        level zurich_util::init_kane( str_objective, 1 );
        level.var_ebb30c1a = [];
        level thread function_e3750802();
        level clientfield::set( "intro_ambience", 1 );
        exploder::exploder( "streets_tower_wasp_swarm" );
        level clientfield::set( "zurich_city_ambience", 1 );
        zurich_street::function_48166ad7();
        scene::add_scene_func( "cin_zur_01_01_intro_1st_lost_contact", &function_4ef4b654, "play" );
        scene::add_scene_func( "cin_zur_01_01_intro_1st_lost_contact", &function_5e558eb, "done" );
        level scene::skipto_end( "cin_zur_01_01_intro_1st_lost_contact" );
        level thread function_37ee22ee();
        level thread zurich_street::function_1be1a835();
        load::function_a2995f22();
    }
    
    level thread namespace_67110270::function_db37681();
    
    foreach ( e_player in level.activeplayers )
    {
        e_player util::player_frost_breath( 1 );
        e_player thread zurich_street::function_2e5e657b();
    }
    
    savegame::checkpoint_save();
    level thread scene::play( "p7_fxanim_cp_zurich_hunter_start_01_bundle" );
    level thread function_51e389ee();
    level thread function_3eb0da5f();
    level thread function_ddcc04ff();
    level thread function_ab4451a1();
    level thread function_da30164f();
    trigger::wait_till( "zurich_intro_exit_zone_trig" );
    
    if ( isdefined( str_objective ) )
    {
        skipto::objective_completed( str_objective );
    }
}

// Namespace zurich_city
// Params 0
// Checksum 0xd544784c, Offset: 0x1bb0
// Size: 0xa4
function function_37ee22ee()
{
    trigger::use( "intro_kane_colors_start_colortrig" );
    level flag::wait_till( "intro_squad_ready_move" );
    trigger::use( "intro_allies_colors_start_colortrig" );
    trigger::wait_till( "intro_breadcrumb_trig", undefined, undefined, 0 );
    trigger::use( "zurich_street_start_colortrig" );
    trigger::wait_till( "zurich_intro_exit_zone_trig" );
}

// Namespace zurich_city
// Params 4
// Checksum 0x97c9d82c, Offset: 0x1c60
// Size: 0x3c
function function_cf4ddc29( str_objective, b_starting, b_direct, player )
{
    zurich_util::enable_surreal_ai_fx( 0 );
}

// Namespace zurich_city
// Params 0
// Checksum 0xd6399bb0, Offset: 0x1ca8
// Size: 0x64
function function_3eb0da5f()
{
    level scene::play( "p7_fxanim_cp_zurich_car_crash_stuck_bundle" );
    trigger::wait_till( "intro_breadcrumb_trig2", undefined, undefined, 0 );
    level scene::stop( "p7_fxanim_cp_zurich_car_crash_stuck_bundle" );
}

// Namespace zurich_city
// Params 1
// Checksum 0x545fd07d, Offset: 0x1d18
// Size: 0x74
function function_d9b234c1( nd_start )
{
    if ( !isdefined( nd_start ) )
    {
        nd_start = getnode( self.target, "targetname" );
    }
    
    self.script_objective = "street";
    self.team = "allies";
    self function_84f0b3d2( nd_start );
}

// Namespace zurich_city
// Params 1
// Checksum 0x4cde0ee7, Offset: 0x1d98
// Size: 0x10c
function function_84f0b3d2( nd_start )
{
    self endon( #"death" );
    self notify( #"stop_running" );
    self endon( #"stop_running" );
    self forceteleport( nd_start.origin );
    wait 0.05;
    
    while ( isdefined( nd_start.target ) )
    {
        var_ff0d12d2 = getnode( nd_start.target, "targetname" );
        self ai::force_goal( var_ff0d12d2, 32, 0, "stop_running" );
        nd_start = var_ff0d12d2;
    }
    
    self ai::set_behavior_attribute( "panic", 1 );
    self ai_cleanup();
}

// Namespace zurich_city
// Params 0
// Checksum 0x2130e493, Offset: 0x1eb0
// Size: 0x24
function function_51e389ee()
{
    objectives::breadcrumb( "intro_breadcrumb_trig", "cp_waypoint_breadcrumb" );
}

// Namespace zurich_city
// Params 0
// Checksum 0x68e73808, Offset: 0x1ee0
// Size: 0x28
function function_e3750802()
{
    var_295a1e1f = zurich_util::function_f9afa212( "zurich_intro_camera" );
}

// Namespace zurich_city
// Params 0
// Checksum 0x229824b7, Offset: 0x1f10
// Size: 0x44
function function_9b46fb9()
{
    var_295a1e1f = getentarray( "zurich_intro_camera_ai", "targetname" );
    array::delete_all( var_295a1e1f );
}

// Namespace zurich_city
// Params 0
// Checksum 0xeb91e116, Offset: 0x1f60
// Size: 0x114
function function_a1dcdc1()
{
    level.var_4fc7570c = spawner::simple_spawn_single( "zurich_intro_redshirts_right_1", &function_56e5aa4d );
    level.var_c1cec647 = spawner::simple_spawn_single( "zurich_intro_redshirts_right_2", &function_56e5aa4d );
    level.var_726eb89c = getnode( "intro_ally_hunter_vignette_rpg", "targetname" ) zurich_util::function_a569867c( undefined, &function_56e5aa4d );
    level.var_e47627d7 = getnode( "intro_ally_hunter_vignette_support", "targetname" ) zurich_util::function_a569867c( undefined, &function_56e5aa4d );
    level flag::set( "intro_igc_ready" );
}

// Namespace zurich_city
// Params 1
// Checksum 0xb06d4eb, Offset: 0x2080
// Size: 0x7b4
function function_b8f105c6( a_ents )
{
    nd_intro = getnode( "zurich_intro_redshirt_run_by_node", "targetname" );
    var_ae4ab21f = getnode( "zurich_intro_sitrep_node", "targetname" );
    a_ents[ "zurich_intro_sitrep_guy" ].allowbattlechatter[ "bc" ] = 0;
    a_ents[ "zurich_intro_sitrep_guy" ] ai::set_ignoreme( 1 );
    a_ents[ "zurich_intro_sitrep_guy" ] thread function_56e5aa4d();
    a_ents[ "kane" ].allowbattlechatter[ "bc" ] = 0;
    a_ents[ "kane" ] ai::set_ignoreme( 1 );
    
    foreach ( e_player in level.activeplayers )
    {
        e_player.ignoreme = 1;
    }
    
    level thread function_6e68a9b();
    level thread function_a294dd02();
    level thread function_5f96c3e7();
    level thread function_e7f6d0c8();
    level thread function_73361364( a_ents );
    wait 0.05;
    ai_sniper = getnode( "intro_robot_balcony_sniper", "targetname" ) zurich_util::function_a569867c( undefined, &function_b82ef7f0 );
    a_ents[ "zurich_intro_sitrep_guy" ] setgoal( var_ae4ab21f );
    a_ents[ "zurich_intro_sitrep_guy" ] waittill( #"hash_2b365e46" );
    ai_hunter = getvehiclenode( "intro_hunter_kill_node", "targetname" ) zurich_util::function_a569867c( undefined, &function_5568741b );
    level.var_726eb89c thread function_663b5805( ai_hunter );
    var_9bcc4bde = spawner::simple_spawn_single( "zurich_intro_redshirts_right_3", &function_56e5aa4d );
    var_9faa0c88 = getweapon( "launcher_standard" );
    s_rpg = struct::get( "intro_magic_bullet_scene_spot2" );
    s_target = struct::get( s_rpg.target );
    e_rocket = magicbullet( var_9faa0c88, s_rpg.origin, s_target.origin );
    e_rocket.team = "allies";
    a_ents[ "zurich_intro_sitrep_guy" ] thread function_d8d72142();
    wait 0.05;
    var_b7bd6d68 = spawner::simple_spawn_single( "zurich_intro_redshirts_right_5", &function_56e5aa4d );
    a_ents[ "kane" ] waittill( #"hash_c8804d8f" );
    level.var_726eb89c delete();
    level.var_e47627d7 delete();
    var_b7bd6d68 delete();
    
    if ( ai_sniper.weapon !== level.weaponnone )
    {
        magicbullet( ai_sniper.weapon, ai_sniper gettagorigin( "tag_flash" ), a_ents[ "zurich_intro_sitrep_guy" ] geteye() + ( 0, 16, 32 ) );
    }
    
    a_ents[ "kane" ] waittill( #"hash_5752b84e" );
    a_ents[ "zurich_intro_sitrep_guy" ] thread function_d8d72142();
    nd_goal = getnode( level.var_c1cec647.script_noteworthy, "targetname" );
    level.var_c1cec647 setgoal( nd_goal );
    a_ents[ "kane" ] waittill( #"hash_300ae2a3" );
    a_ents[ "zurich_intro_sitrep_guy" ] thread function_d8d72142();
    vh_vtol = getvehiclenode( "street_intro_vtol", "targetname" ) zurich_util::function_a569867c( undefined, &zurich_street::vtol_spawnfunc );
    var_ddbfe7d1 = spawner::simple_spawn_single( "zurich_intro_redshirts_right_4", &function_56e5aa4d );
    nd_goal = getnode( level.var_4fc7570c.script_noteworthy, "targetname" );
    level.var_4fc7570c setgoal( nd_goal );
    a_ents[ "kane" ] waittill( #"hash_602a6061" );
    var_61a68fbf = spawner::simple_spawn_single( "zurich_intro_support", &function_56e5aa4d );
    var_61a68fbf setgoal( nd_intro );
    a_ents[ "kane" ] waittill( #"hash_54d3aa25" );
    var_22ec8e08 = spawner::simple_spawn_single( "intro_street_front_siegebot", &function_19017cb9 );
    
    if ( isalive( ai_hunter ) )
    {
        ai_hunter kill();
    }
}

// Namespace zurich_city
// Params 1
// Checksum 0xa1e58ef9, Offset: 0x2840
// Size: 0xc4
function function_663b5805( ai_hunter )
{
    self endon( #"death" );
    ai_hunter endon( #"death" );
    ai_hunter waittill( #"hash_77b2a1ab" );
    self setentitytarget( ai_hunter );
    magicbullet( self.weapon, self gettagorigin( "tag_flash" ), ai_hunter.origin );
    ai_hunter vehicle::god_off();
    wait 1;
    ai_hunter kill();
}

// Namespace zurich_city
// Params 1
// Checksum 0xf950f6ec, Offset: 0x2910
// Size: 0x44
function function_73361364( a_ents )
{
    a_ents[ "kane" ] waittill( #"hash_300ae2a3" );
    level thread scene::play( "p7_fxanim_cp_zurich_hunter_start_02_bundle" );
}

// Namespace zurich_city
// Params 0
// Checksum 0x6f1eaac4, Offset: 0x2960
// Size: 0xdc
function function_b82ef7f0()
{
    self endon( #"death" );
    self util::magic_bullet_shield();
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    level waittill( #"hash_1b75d876" );
    self util::stop_magic_bullet_shield();
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
    self.overrideactordamage = &zurich_util::function_8ac3f026;
    level.ai_kane ai::shoot_at_target( "shoot_until_target_dead", self );
}

// Namespace zurich_city
// Params 0
// Checksum 0x3fad1a3f, Offset: 0x2a48
// Size: 0xbc
function function_5568741b()
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self dodamage( int( self.health / 2 ), self.origin );
    self vehicle::god_on();
    self waittill( #"reached_end_node" );
    self setvehgoalpos( self.origin, 1 );
}

// Namespace zurich_city
// Params 0
// Checksum 0x3f635e91, Offset: 0x2b10
// Size: 0x316
function function_d8d72142()
{
    self endon( #"death" );
    level endon( #"hash_1b75d876" );
    n_offset = 32;
    a_s_weapons = struct::get_array( "intro_magic_bullet_scene_spot" );
    w_weapon = self.weapon;
    
    for ( i = 0; i < 36 ; i++ )
    {
        s_weapon = array::random( a_s_weapons );
        a_s_targets = struct::get_array( s_weapon.target );
        s_target = array::random( a_s_targets );
        var_8d661004 = ( randomintrange( n_offset * -1, n_offset ), randomintrange( n_offset * -1, n_offset ), randomintrange( n_offset * -1, n_offset ) );
        magicbullet( w_weapon, s_weapon.origin + var_8d661004, s_target.origin + var_8d661004 );
        wait randomfloatrange( 0.25, 0.32 );
    }
    
    wait 1.2;
    
    for ( i = 0; i < 19 ; i++ )
    {
        s_weapon = array::random( a_s_weapons );
        a_s_targets = struct::get_array( s_weapon.target );
        s_target = array::random( a_s_targets );
        var_8d661004 = ( randomintrange( n_offset * -1, n_offset ), randomintrange( n_offset * -1, n_offset ), randomintrange( n_offset * -1, n_offset ) );
        magicbullet( w_weapon, s_weapon.origin + var_8d661004, s_target.origin + var_8d661004 );
        wait randomfloatrange( 0.25, 0.32 );
    }
}

// Namespace zurich_city
// Params 0
// Checksum 0xfaf1926d, Offset: 0x2e30
// Size: 0xa8
function function_6e68a9b()
{
    level endon( #"hash_1b75d876" );
    wait 0.05;
    
    while ( true )
    {
        for ( a_ai = zurich_util::function_33ec653f( "intro_street_robots_spawn_manager", undefined, undefined, &function_56e5aa4d ); a_ai.size > 1 ; a_ai = array::remove_dead( a_ai ) )
        {
            array::wait_any( a_ai, "death" );
        }
    }
}

// Namespace zurich_city
// Params 0
// Checksum 0x5124d284, Offset: 0x2ee0
// Size: 0xc4
function function_56e5aa4d()
{
    self endon( #"death" );
    self.script_accuracy = 0.1;
    
    if ( self.team == "allies" )
    {
        util::magic_bullet_shield( self );
        
        if ( self.script_aigroup === "intro_hero_redshirts" )
        {
            return;
        }
        
        level flag::wait_till( "intro_squad_ready_move" );
        self util::stop_magic_bullet_shield();
        self ai::set_ignoreme( 0 );
        return;
    }
    
    self.overrideactordamage = &zurich_util::function_8ac3f026;
}

// Namespace zurich_city
// Params 1
// Checksum 0x2ea40a34, Offset: 0x2fb0
// Size: 0x316
function function_5e558eb( a_ents )
{
    level clientfield::set( "set_exposure_bank", 0 );
    var_35a3121c = spawner::get_ai_group_ai( "intro_squad_right" );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( !isalive( var_35a3121c[ i ] ) )
        {
            continue;
        }
        
        var_35a3121c[ i ] util::stop_magic_bullet_shield();
        var_35a3121c[ i ] kill();
    }
    
    level flag::set( "intro_squad_ready_move" );
    util::teleport_players_igc( "intro_igc_player" );
    a_ai_allies = getaiteamarray( "allies" );
    
    foreach ( ai in a_ai_allies )
    {
        if ( ai util::is_hero() )
        {
            continue;
        }
        
        ai.script_accuracy = 0.1;
    }
    
    a_ents[ "zurich_intro_sitrep_guy" ].allowbattlechatter[ "bc" ] = 1;
    a_ents[ "kane" ].allowbattlechatter[ "bc" ] = 1;
    
    foreach ( e_player in level.activeplayers )
    {
        e_player.ignoreme = 0;
    }
    
    var_51a7831a = spawner::get_ai_group_ai( "intro_street_front_siegebot" );
    
    if ( isalive( var_51a7831a ) )
    {
        var_51a7831a kill();
    }
    
    level.var_4fc7570c = undefined;
    level.var_c1cec647 = undefined;
    level.var_726eb89c = undefined;
    level.var_e47627d7 = undefined;
}

// Namespace zurich_city
// Params 0
// Checksum 0x51d7ea56, Offset: 0x32d0
// Size: 0x1f4
function function_19017cb9()
{
    self endon( #"death" );
    self ai::set_ignoreme( 1 );
    nd_start = getnode( "intro_street_front_siegebot_start_node", "targetname" );
    nd_end = getnode( nd_start.target, "targetname" );
    s_rpg = struct::get( "intro_magic_rpg_spot" );
    var_2d4ab0e6 = struct::get( "intro_magic_rpg_spot2" );
    var_9faa0c88 = getweapon( "launcher_standard" );
    self setvehgoalpos( nd_start.origin, 1, 1 );
    wait 3.5;
    self setvehgoalpos( nd_end.origin, 1, 1 );
    wait 1.3;
    magicbullet( var_9faa0c88, s_rpg.origin, self geteye() );
    wait 1.5;
    magicbullet( var_9faa0c88, s_rpg.origin, self geteye() );
    wait 0.98;
    self kill();
}

// Namespace zurich_city
// Params 0
// Checksum 0x79d59a66, Offset: 0x34d0
// Size: 0x1d8
function function_a294dd02()
{
    level endon( #"hash_1b75d876" );
    n_offset = 128;
    var_fccc406f = struct::get_array( "intro_magic_rpg_spot_enemy" );
    var_9faa0c88 = getweapon( "launcher_standard" );
    
    while ( true )
    {
        s_rpg = array::random( var_fccc406f );
        a_s_targets = struct::get_array( s_rpg.target );
        s_target = array::random( a_s_targets );
        var_8d661004 = ( randomintrange( n_offset * -1, n_offset ), randomintrange( n_offset * -1, n_offset ), randomintrange( n_offset * -1, n_offset ) );
        e_rocket = magicbullet( var_9faa0c88, s_rpg.origin + var_8d661004, s_target.origin + var_8d661004 );
        e_rocket.team = "allies";
        wait randomfloatrange( 1.1, 3.1 );
    }
}

// Namespace zurich_city
// Params 1
// Checksum 0x6dc1db42, Offset: 0x36b0
// Size: 0x440
function function_4ef4b654( a_ents )
{
    level clientfield::set( "set_exposure_bank", 1 );
    var_4fc7570c = spawner::simple_spawn_single( "zurich_intro_redshirts_right_1" );
    var_c1cec647 = spawner::simple_spawn_single( "zurich_intro_redshirts_right_2" );
    var_61a68fbf = spawner::simple_spawn_single( "zurich_intro_support" );
    var_b982e5d0 = spawner::get_ai_group_ai( "intro_squad_right" );
    nd_intro = getnode( "zurich_intro_redshirt_run_by_node", "targetname" );
    var_ae4ab21f = getnode( "zurich_intro_sitrep_node", "targetname" );
    var_35a3121c = [];
    var_35a3121c = arraycombine( var_b982e5d0, var_35a3121c, 0, 0 );
    
    if ( !isdefined( var_35a3121c ) )
    {
        var_35a3121c = [];
    }
    else if ( !isarray( var_35a3121c ) )
    {
        var_35a3121c = array( var_35a3121c );
    }
    
    var_35a3121c[ var_35a3121c.size ] = var_61a68fbf;
    
    if ( !isdefined( var_35a3121c ) )
    {
        var_35a3121c = [];
    }
    else if ( !isarray( var_35a3121c ) )
    {
        var_35a3121c = array( var_35a3121c );
    }
    
    var_35a3121c[ var_35a3121c.size ] = a_ents[ "zurich_intro_sitrep_guy" ];
    
    foreach ( ai in var_35a3121c )
    {
        ai.script_accuracy = 0.1;
    }
    
    level thread function_e7f6d0c8();
    var_61a68fbf forceteleport( nd_intro.origin, nd_intro.angles );
    a_ents[ "zurich_intro_sitrep_guy" ] forceteleport( var_ae4ab21f.origin, var_ae4ab21f.angles );
    
    foreach ( ai in var_b982e5d0 )
    {
        nd_goal = getnode( ai.script_noteworthy, "targetname" );
        ai forceteleport( nd_goal.origin, nd_goal.angles );
        ai setgoal( nd_goal );
    }
    
    var_9bcc4bde = spawner::simple_spawn_single( "zurich_intro_redshirts_right_3" );
    var_ddbfe7d1 = spawner::simple_spawn_single( "zurich_intro_redshirts_right_4" );
}

// Namespace zurich_city
// Params 0
// Checksum 0x9452c32d, Offset: 0x3af8
// Size: 0xe4
function function_da30164f()
{
    level endon( #"hash_e0d14dc8" );
    var_6a6344b5 = struct::get( "street_choke_throw_look_point" );
    var_1a20be33 = getent( "street_balcony_choke_throw_trig", "targetname" );
    var_1a20be33 endon( #"death" );
    
    if ( !isdefined( var_1a20be33 ) )
    {
        return;
    }
    
    level flag::wait_till_timeout( 6, "intro_player_ready" );
    
    do
    {
        wait 0.5;
    }
    while ( !zurich_util::function_f8645b6( -1, var_6a6344b5.origin, 0.99 ) );
    
    var_1a20be33 trigger::use();
}

// Namespace zurich_city
// Params 0
// Checksum 0xa07693ec, Offset: 0x3be8
// Size: 0x1fe
function function_5f96c3e7()
{
    a_sp_civs = getentarray( "zurich_ambient_outdoor_civ", "targetname" );
    var_7b2d1a16 = getnodearray( "intro_street_civ_path", "targetname" );
    var_ceb52e2a = [];
    
    for ( i = 0; i < 3 ; i++ )
    {
        foreach ( nd in var_7b2d1a16 )
        {
            sp_civ = array::random( a_sp_civs );
            var_ceb52e2a[ i ] = spawner::simple_spawn_single( sp_civ, &function_d9b234c1, nd );
            var_ceb52e2a[ i ] playloopsound( "evt_intro_civilian_loop" );
            wait randomfloatrange( 0.9, 1.8 );
        }
        
        if ( level flag::get( "intro_second_wave_civs_start" ) )
        {
            break;
        }
        
        wait randomfloatrange( 1.34, 3 );
    }
}

// Namespace zurich_city
// Params 0
// Checksum 0xf4fbef0b, Offset: 0x3df0
// Size: 0x1fc
function function_e7f6d0c8()
{
    a_sp_civs = getentarray( "zurich_ambient_outdoor_civ", "targetname" );
    level flag::wait_till( "intro_second_wave_civs_start" );
    var_7b2d1a16 = getnodearray( "intro_garage_civ_path", "targetname" );
    
    for ( i = 0; i < 1 ; i++ )
    {
        foreach ( nd in var_7b2d1a16 )
        {
            sp_civ = array::random( a_sp_civs );
            var_ceb52e2a[ i ] = spawner::simple_spawn_single( sp_civ, &function_d9b234c1, nd );
            wait randomfloatrange( 0.7, 1.4 );
        }
        
        wait randomfloatrange( 0.5, 1.1 );
    }
    
    level flag::wait_till( "street_civs_start" );
    function_9b9c35d7();
}

// Namespace zurich_city
// Params 0
// Checksum 0xc3e97030, Offset: 0x3ff8
// Size: 0x152
function function_9b9c35d7()
{
    a_sp_civs = getentarray( "zurich_ambient_outdoor_civ", "targetname" );
    var_7b2d1a16 = getnodearray( "intro_garage2_civ_path", "targetname" );
    
    foreach ( i, nd in var_7b2d1a16 )
    {
        sp_civ = array::random( a_sp_civs );
        var_ceb52e2a[ i ] = spawner::simple_spawn_single( sp_civ, &function_d9b234c1, nd );
        wait randomfloatrange( 0.5, 1.1 );
    }
}

// Namespace zurich_city
// Params 0
// Checksum 0xacb2e43f, Offset: 0x4158
// Size: 0x114
function function_ddcc04ff()
{
    var_b2bb8a85 = getvehiclenode( "intro_quadtank_spot_right", "targetname" );
    var_f3200b3f = spawner::simple_spawn_single( "zurich_ambient_quadtank" );
    var_f3200b3f ai::set_ignoreme( 1 );
    var_f3200b3f vehicle_ai::start_scripted();
    var_f3200b3f thread vehicle::get_on_and_go_path( var_b2bb8a85 );
    
    while ( !level flag::get( "street_civs_start" ) )
    {
        var_f3200b3f vehicle::get_on_and_go_path( var_b2bb8a85 );
        wait randomfloatrange( 2, 4 );
    }
    
    var_f3200b3f thread ai_cleanup();
}

// Namespace zurich_city
// Params 1
// Checksum 0x59ce266d, Offset: 0x4278
// Size: 0xa6
function ai_cleanup( n_dist )
{
    if ( !isdefined( n_dist ) )
    {
        n_dist = 512;
    }
    
    self endon( #"death" );
    
    while ( true )
    {
        if ( !( isdefined( self zurich_util::player_can_see_me( n_dist ) ) && self zurich_util::player_can_see_me( n_dist ) ) )
        {
            if ( isalive( self ) )
            {
                self delete();
            }
        }
        
        wait 2;
    }
}

