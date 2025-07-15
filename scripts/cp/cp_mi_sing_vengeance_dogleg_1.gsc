#using scripts/codescripts/struct;
#using scripts/cp/_debug;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_vengeance_accolades;
#using scripts/cp/cp_mi_sing_vengeance_quadtank_alley;
#using scripts/cp/cp_mi_sing_vengeance_sound;
#using scripts/cp/cp_mi_sing_vengeance_util;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/stealth;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth_level;
#using scripts/shared/stealth_status;
#using scripts/shared/stealth_vo;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace vengeance_dogleg_1;

// Namespace vengeance_dogleg_1
// Params 2
// Checksum 0xa9c2f9a2, Offset: 0x1308
// Size: 0x24c
function skipto_dogleg_1_init( str_objective, b_starting )
{
    level thread cafe_burning_setup();
    
    if ( b_starting )
    {
        load::function_73adcefc();
        vengeance_util::skipto_baseline( str_objective, b_starting );
        vengeance_util::init_hero( "hendricks", str_objective );
        callback::on_spawned( &vengeance_util::give_hero_weapon );
        level.ai_hendricks ai::set_ignoreall( 1 );
        level.ai_hendricks ai::set_ignoreme( 1 );
        level.ai_hendricks colors::disable();
        level.ai_hendricks.goalradius = 32;
        level.ai_hendricks setgoal( level.ai_hendricks.origin );
        vengeance_util::function_e00864bd( "dogleg_1_umbra_gate", 1, "dogleg_1_gate" );
        objectives::set( "cp_level_vengeance_rescue_kane" );
        objectives::set( "cp_level_vengeance_go_to_safehouse" );
        objectives::hide( "cp_level_vengeance_go_to_safehouse" );
        level thread namespace_9fd035::function_dad71f51( "tension_loop_2" );
        level.var_4c62d05f = level.players[ 0 ];
        scene::init( "cin_ven_04_10_cafedoor_1st_sh010" );
        util::set_streamer_hint( 3 );
        load::function_a2995f22();
    }
    
    vengeance_util::function_4e8207e9( "dogleg_1" );
    dogleg_1_main( str_objective, b_starting );
}

// Namespace vengeance_dogleg_1
// Params 2
// Checksum 0xfbd9bf4b, Offset: 0x1560
// Size: 0x35a
function dogleg_1_main( str_objective, b_starting )
{
    level flag::set( "dogleg_1_begin" );
    level thread function_254de1e5();
    function_e17e849c();
    stealth::reset();
    vengeance_accolades::function_e887345e();
    vengeance_accolades::function_eda4634d();
    level thread function_7272ed9d();
    level thread dogleg_1_wasps();
    level.quadtank_alley_intro_org = struct::get( "quadtank_alley_intro_org" );
    level.quadtank_alley_intro_org scene::init( "cin_ven_04_30_quadalleydoor_1st" );
    level thread function_6236563e();
    level.dogleg_1_patroller_spawners = spawner::simple_spawn( "dogleg_1_patroller_spawners", &vengeance_util::setup_patroller );
    level thread dogleg_1_vo( b_starting );
    level thread function_1909c582();
    level thread function_6fdd2184();
    level thread cafe_molotov_setup();
    level thread function_842de716();
    level.lineup_kill_scripted_node = struct::get( "lineup_kill_scripted_node", "targetname" );
    level.lineup_kill_scripted_node thread scene::init( "cin_ven_03_20_storelineup_vign_exit" );
    storelineup_door3_clip = getent( "storelineup_door3_clip", "targetname" );
    
    if ( isdefined( storelineup_door3_clip ) )
    {
        storelineup_door3_clip solid();
        storelineup_door3_clip disconnectpaths();
    }
    
    storelineup_door3_open_clip = getent( "storelineup_door3_open_clip", "targetname" );
    storelineup_door3_open_clip delete();
    triggers = getentarray( "dogleg_1_stealth_checkpoint_trigger", "targetname" );
    
    foreach ( trigger in triggers )
    {
        trigger thread vengeance_util::function_f9c94344();
    }
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0xdfd89cf4, Offset: 0x18c8
// Size: 0xc2
function function_254de1e5()
{
    a_allies = getaiteamarray( "allies" );
    
    foreach ( ally in a_allies )
    {
        if ( isdefined( ally.remote_owner ) )
        {
            ally delete();
        }
    }
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0xca4d83d7, Offset: 0x1998
// Size: 0x1fc
function function_e17e849c()
{
    level.dogleg_1_intro_org = struct::get( "dogleg_1_intro_org" );
    vengeance_util::co_op_teleport_on_igc_end( "cin_ven_04_10_cafedoor_1st_sh100", "cafe_igc_teleport" );
    level thread function_798b0fec();
    level thread function_d45f757d();
    
    if ( isdefined( level.bzm_vengeancedialogue4callback ) )
    {
        level thread [[ level.bzm_vengeancedialogue4callback ]]();
    }
    
    level.dogleg_1_intro_org thread scene::play( "cin_ven_04_10_cafedoor_1st_sh010", level.var_4c62d05f );
    level.ai_hendricks thread setup_dogleg_1_hendricks();
    level waittill( #"hash_a60d391c" );
    level thread cafe_execution_setup();
    level thread function_e9e34547();
    level waittill( #"hash_2b965a47" );
    
    if ( isdefined( level.bzm_vengeancedialogue5callback ) )
    {
        level thread [[ level.bzm_vengeancedialogue5callback ]]();
    }
    
    level thread namespace_9fd035::function_dad71f51( "tension_loop_2" );
    
    foreach ( player in level.players )
    {
        player thread function_fd7fd40d();
    }
    
    util::clear_streamer_hint();
    savegame::checkpoint_save();
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0x7a9f8156, Offset: 0x1ba0
// Size: 0xb4
function function_fd7fd40d()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self thread function_8e0d7da8();
    weap = getweapon( "ar_marksman_veng_hero_weap" );
    
    if ( !self hasweapon( weap ) )
    {
        self giveweapon( weap );
    }
    
    self switchtoweaponimmediate( weap );
    self thread vengeance_util::function_12a1b6a0();
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0x8431ecaa, Offset: 0x1c60
// Size: 0x6c
function function_8e0d7da8()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self hideviewmodel();
    weap = getweapon( "ar_marksman_veng_hero_weap" );
    wait 0.15;
    self showviewmodel();
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0x10c77771, Offset: 0x1cd8
// Size: 0x274
function function_798b0fec()
{
    level endon( #"hash_2b965a47" );
    level dialog::remote( "tayr_you_don_t_understand_1", 0, "no_dni" );
    level thread namespace_9fd035::function_862430bd();
    util::clientnotify( "sndLRstop" );
    level notify( #"hash_15e32f84" );
    level.ai_hendricks waittill( #"hash_a89f76ac" );
    level.ai_hendricks vengeance_util::function_5fbec645( "hend_you_sold_us_out_you_0" );
    level dialog::remote( "tayr_i_told_the_truth_0", 0, "no_dni" );
    level dialog::remote( "tayr_behind_a_slick_corpo_0", 0, "no_dni" );
    level dialog::remote( "tayr_experiments_that_wou_0", 0, "no_dni" );
    level dialog::remote( "tayr_ask_yourself_who_s_0", 0, "no_dni" );
    level dialog::remote( "tayr_the_people_who_survi_0", 0, "no_dni" );
    level dialog::remote( "tayr_or_the_fucking_suits_0", 0, "no_dni" );
    level dialog::remote( "tayr_the_immortals_built_0", 0, "no_dni" );
    level dialog::remote( "tayr_maybe_they_want_reve_0", 0, "no_dni" );
    level dialog::remote( "tayr_maybe_they_just_want_0", 0, "no_dni" );
    level dialog::remote( "tayr_either_way_you_can_0", 0, "no_dni" );
    level dialog::remote( "hend_taylor_taylor_0", 0, "no_dni" );
    dialog::player_say( "plyr_kane_how_the_hell_0" );
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0xb1bc4303, Offset: 0x1f58
// Size: 0x104
function function_d45f757d()
{
    level waittill( #"hash_73c7894d" );
    molotov_civilian = getent( "molotov_civilian", "targetname" );
    
    if ( isdefined( molotov_civilian ) )
    {
        molotov_civilian thread vengeance_util::set_civilian_on_fire();
    }
    
    molotov_civilian2 = getent( "molotov_civilian2", "targetname" );
    
    if ( isdefined( molotov_civilian2 ) )
    {
        molotov_civilian2 thread vengeance_util::set_civilian_on_fire();
    }
    
    molotov_civilian3 = getent( "molotov_civilian3", "targetname" );
    
    if ( isdefined( molotov_civilian3 ) )
    {
        molotov_civilian3 thread vengeance_util::set_civilian_on_fire();
    }
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0x8da5b2d8, Offset: 0x2068
// Size: 0x8c
function function_842de716()
{
    dogleg_1_entrance_door_clip = getent( "dogleg_1_entrance_door_clip", "targetname" );
    
    if ( isdefined( dogleg_1_entrance_door_clip ) )
    {
        dogleg_1_entrance_door_clip notsolid();
        dogleg_1_entrance_door_clip connectpaths();
        wait 0.05;
        dogleg_1_entrance_door_clip delete();
    }
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0x74e85e1a, Offset: 0x2100
// Size: 0xea
function function_7272ed9d()
{
    killing_streets_lineup_kill_ai_blockers = getentarray( "killing_streets_lineup_kill_ai_blockers", "targetname" );
    
    foreach ( ent in killing_streets_lineup_kill_ai_blockers )
    {
        ent notsolid();
        ent connectpaths();
        wait 0.05;
        ent delete();
    }
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0x83524e3c, Offset: 0x21f8
// Size: 0xbc
function setup_dogleg_1_hendricks()
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self colors::disable();
    self ai::set_behavior_attribute( "cqb", 1 );
    self.goalradius = 32;
    self setgoal( self.origin );
    self waittill( #"hash_8e639ede" );
    self delete();
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0x422d82a4, Offset: 0x22c0
// Size: 0x54
function dogleg_1_wasps()
{
    level.dogleg_1_wasps = spawner::simple_spawn( "dogleg_1_wasps", &function_b5dfff73 );
    level.var_4843e321 = level.dogleg_1_wasps.size;
    vengeance_accolades::function_cae14a51();
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0x1dd5d0b8, Offset: 0x2320
// Size: 0x7c
function function_b5dfff73()
{
    dogleg_1_wasp_gv = getent( "dogleg_1_wasp_gv", "targetname" );
    
    if ( isdefined( dogleg_1_wasp_gv ) )
    {
        self clearforcedgoal();
        self cleargoalvolume();
        self setgoal( dogleg_1_wasp_gv );
    }
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0x14f242f5, Offset: 0x23a8
// Size: 0x1dc
function cafe_execution_setup()
{
    level.cafe_execution_org = struct::get( "cafe_execution_org" );
    spawner::add_spawn_function_group( "cafe_execution_civ_spawners", "script_noteworthy", &cafe_execution_civ_spawn_func );
    spawner::add_spawn_function_group( "cafe_execution_thug_spawners", "script_noteworthy", &cafe_exeuction_thug_spawn_func );
    spawner::add_spawn_function_group( "cafe_execution_thug_spawners", "script_noteworthy", &cafe_exeuction_thug_death_watcher_spawn_func );
    level.cafe_execution_org scene::init( "cin_ven_04_20_cafeexecution_vign_intro" );
    
    while ( !level scene::is_ready( "cin_ven_04_20_cafeexecution_vign_intro" ) )
    {
        wait 0.05;
    }
    
    level.cafe_execution_54i_thug_a_ai = getent( "cafe_execution_54i_thug_a_ai", "targetname", 1 );
    level.cafe_execution_civ_01_ai = getent( "cafe_execution_civ_01_ai", "targetname", 1 );
    level.cafe_execution_civ_02_ai = getent( "cafe_execution_civ_02_ai", "targetname", 1 );
    level.cafe_execution_civ_03_ai = getent( "cafe_execution_civ_03_ai", "targetname", 1 );
    level thread function_dbe2f523();
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0x5edd5ee4, Offset: 0x2590
// Size: 0x20c
function cafe_execution_civ_spawn_func()
{
    self endon( #"death" );
    self.team = "allies";
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    self ai::set_behavior_attribute( "panic", 0 );
    self.health = 1;
    self util::waittill_either( "try_to_escape", "kill_me" );
    
    if ( !level flag::get( "cafe_execution_thug_dead" ) )
    {
        self.takedamage = 1;
        self.skipdeath = 1;
        self.allowdeath = 1;
        self kill();
        return;
    }
    
    self stopanimscripted();
    self.civilian = 1;
    self ai::set_ignoreme( 0 );
    self ai::set_ignoreall( 0 );
    self animation::play( self.script_parameters, level.cafe_execution_org.origin, level.cafe_execution_org.angles );
    
    if ( isdefined( self.target ) )
    {
        node = getnode( self.target, "targetname" );
        self thread vengeance_util::delete_ai_at_path_end( node );
    }
    
    self ai::set_behavior_attribute( "panic", 1 );
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0xd48af6ce, Offset: 0x27a8
// Size: 0x3c
function cafe_exeuction_thug_spawn_func()
{
    self endon( #"death" );
    self waittill( #"alert" );
    level.cafe_execution_org scene::play( "cin_ven_04_20_cafeexecution_vign_intro" );
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0x6ff80127, Offset: 0x27f0
// Size: 0xc6
function cafe_exeuction_thug_death_watcher_spawn_func()
{
    self waittill( #"death" );
    level flag::set( "cafe_execution_thug_dead" );
    
    for ( i = 1; i < 6 ; i++ )
    {
        guy = getent( "cafe_execution_civ_0" + i + "_ai", "targetname" );
        
        if ( isdefined( guy ) && isalive( guy ) )
        {
            guy notify( #"try_to_escape" );
        }
    }
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0xda523c9d, Offset: 0x28c0
// Size: 0x15c
function function_dbe2f523()
{
    level.cafe_execution_54i_thug_a_ai endon( #"death" );
    level.cafe_execution_civ_01_ai endon( #"death" );
    level.cafe_execution_civ_02_ai endon( #"death" );
    level.cafe_execution_civ_03_ai endon( #"death" );
    level.cafe_execution_54i_thug_a_ai endon( #"alert" );
    level.cafe_execution_54i_thug_a_ai endon( #"fake_alert" );
    trigger = getent( "cafeexecution_vign_vo_trigger", "targetname" );
    trigger waittill( #"trigger" );
    level.cafe_execution_54i_thug_a_ai vengeance_util::function_5fbec645( "ffim1_all_your_money_won_t_1" );
    wait 0.5;
    level.cafe_execution_54i_thug_a_ai vengeance_util::function_5fbec645( "ffim2_laughter_2" );
    wait 0.5;
    level.cafe_execution_civ_01_ai vengeance_util::function_5fbec645( "mciv_stoooop_noooooo_0" );
    wait 1;
    level.cafe_execution_civ_02_ai vengeance_util::function_5fbec645( "mciv_let_me_go_please_0" );
    wait 0.5;
    level.cafe_execution_54i_thug_a_ai vengeance_util::function_5fbec645( "ffim3_laughter_3" );
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0x864d161f, Offset: 0x2a28
// Size: 0x16c
function cafe_burning_setup()
{
    level.cafe_burning_org = struct::get( "cafe_burning_org" );
    spawner::add_spawn_function_group( "cafe_burning_54i_thug_a", "targetname", &function_8b8b9516 );
    spawner::add_spawn_function_group( "cafe_burning_54i_thug_b", "targetname", &function_97ac3293 );
    spawner::add_spawn_function_group( "cafe_burning_civ_01", "targetname", &cafe_burning_civ_spawn_func );
    spawner::add_spawn_function_group( "cafe_burning_civ_02", "targetname", &cafe_burning_civ_spawn_func );
    spawner::add_spawn_function_group( "cafe_burning_civ_03", "targetname", &cafe_burning_civ_spawn_func );
    scene::add_scene_func( "cin_ven_04_20_cafeburning_vign_loop", &function_924af258, "init", 1 );
    level.cafe_burning_org scene::init( "cin_ven_04_20_cafeburning_vign_loop" );
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0x8b9160fb, Offset: 0x2ba0
// Size: 0x27c
function function_e9e34547()
{
    scene::add_scene_func( "cin_ven_04_20_cafeburning_vign_loop", &function_924af258, "play" );
    level.cafe_burning_org thread scene::play( "cin_ven_04_20_cafeburning_vign_loop" );
    wait 1;
    level.cafe_burning_54i_thug_a_ai = getent( "cafe_burning_54i_thug_a_ai", "targetname", 1 );
    level.cafe_burning_54i_thug_b_ai = getent( "cafe_burning_54i_thug_b_ai", "targetname", 1 );
    level.cafe_burning_civ_01_ai = getent( "cafe_burning_civ_01_ai", "targetname", 1 );
    level.cafe_burning_civ_03_ai = getent( "cafe_burning_civ_02_ai", "targetname", 1 );
    level.cafe_burning_civ_02_ai = getent( "cafe_burning_civ_03_ai", "targetname", 1 );
    level thread function_558e4ac8();
    level.cafe_burning_54i_thug_a_ai thread vengeance_util::function_394ba9b5( level.cafe_burning_54i_thug_b_ai );
    level.cafe_burning_54i_thug_b_ai thread vengeance_util::function_394ba9b5( level.cafe_burning_54i_thug_a_ai );
    level.cafe_burning_54i_thug_a_ai thread vengeance_util::function_d468b73d( "death", array( level.cafe_burning_civ_01_ai, level.cafe_burning_civ_02_ai, level.cafe_burning_civ_03_ai ), "cafe_burning_check_for_escape" );
    enemy_array = [];
    enemy_array[ 0 ] = level.cafe_burning_54i_thug_a_ai;
    enemy_array[ 1 ] = level.cafe_burning_54i_thug_b_ai;
    level.cafe_burning_civ_01_ai thread function_dc4e86b5( enemy_array );
    level.cafe_burning_civ_02_ai thread function_dc4e86b5( enemy_array );
    level.cafe_burning_civ_03_ai thread function_dc4e86b5( enemy_array );
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0x87fd3bc4, Offset: 0x2e28
// Size: 0x1b4
function function_558e4ac8()
{
    level.cafe_burning_54i_thug_a_ai endon( #"death" );
    level.cafe_burning_54i_thug_b_ai endon( #"death" );
    level.cafe_burning_civ_01_ai endon( #"death" );
    level.cafe_burning_civ_03_ai endon( #"death" );
    level.cafe_burning_civ_02_ai endon( #"death" );
    level.cafe_burning_54i_thug_a_ai endon( #"alert" );
    level.cafe_burning_54i_thug_b_ai endon( #"alert" );
    level.cafe_burning_54i_thug_a_ai endon( #"fake_alert" );
    level.cafe_burning_54i_thug_b_ai endon( #"fake_alert" );
    trigger = getent( "cafeburning_vign_vo_trigger", "targetname" );
    trigger waittill( #"trigger" );
    level.cafe_burning_54i_thug_a_ai vengeance_util::function_5fbec645( "ffim1_now_we_re_the_ones_w_1" );
    wait 1;
    level.cafe_burning_54i_thug_b_ai vengeance_util::function_5fbec645( "ffim2_laughter_3" );
    wait 1;
    level.cafe_burning_civ_01_ai vengeance_util::function_5fbec645( "mciv_no_please_noooooo_0" );
    wait 1.5;
    level.cafe_burning_civ_02_ai vengeance_util::function_5fbec645( "mciv_stop_i_have_childre_0" );
    wait 0.5;
    level.cafe_burning_54i_thug_a_ai vengeance_util::function_5fbec645( "ffim1_your_children_will_j_0" );
    wait 0.5;
    level.cafe_burning_54i_thug_b_ai vengeance_util::function_5fbec645( "ffim3_laughter_3" );
}

// Namespace vengeance_dogleg_1
// Params 2
// Checksum 0xfc07d4da, Offset: 0x2fe8
// Size: 0x122
function function_924af258( a_ents, hide_me )
{
    if ( isdefined( hide_me ) )
    {
        foreach ( ent in a_ents )
        {
            ent hide();
        }
        
        return;
    }
    
    foreach ( ent in a_ents )
    {
        ent show();
    }
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0x1234dc46, Offset: 0x3118
// Size: 0xe4
function function_8b8b9516()
{
    self endon( #"death" );
    self ai::set_behavior_attribute( "can_melee", 0 );
    var_ccf9b73f = util::spawn_anim_model( "p7_ven_gascan_static" );
    var_ccf9b73f linkto( self, "tag_weapon_chest", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self thread function_78c388c0( var_ccf9b73f );
    self thread vengeance_util::function_57b69bd6( var_ccf9b73f );
    self waittill( #"fake_alert" );
    
    if ( isdefined( self.silenced ) && self.silenced )
    {
        return;
    }
    
    self stopanimscripted();
}

// Namespace vengeance_dogleg_1
// Params 1
// Checksum 0xbbe243b, Offset: 0x3208
// Size: 0x24
function function_78c388c0( var_ccf9b73f )
{
    function_3f42ba98( var_ccf9b73f );
}

// Namespace vengeance_dogleg_1
// Params 1
// Checksum 0xf0057c6f, Offset: 0x3238
// Size: 0x338
function function_3f42ba98( var_ccf9b73f )
{
    self endon( #"death" );
    self endon( #"fake_alert" );
    self endon( #"alert" );
    
    while ( true )
    {
        level waittill( #"hash_e239447e" );
        playfxontag( level._effect[ "fx_fuel_pour_far_ven" ], var_ccf9b73f, "tag_fx" );
        level waittill( #"hash_bc36ca15" );
        playfxontag( level._effect[ "fx_fuel_pour_far_ven" ], var_ccf9b73f, "tag_fx" );
        level waittill( #"hash_96344fac" );
        playfxontag( level._effect[ "fx_fuel_pour_far_ven" ], var_ccf9b73f, "tag_fx" );
        level waittill( #"hash_7031d543" );
        playfxontag( level._effect[ "fx_fuel_pour_far_ven" ], var_ccf9b73f, "tag_fx" );
        level waittill( #"hash_4a2f5ada" );
        playfxontag( level._effect[ "fx_fuel_pour_far_ven" ], var_ccf9b73f, "tag_fx" );
        level waittill( #"hash_242ce071" );
        playfxontag( level._effect[ "fx_fuel_pour_far_ven" ], var_ccf9b73f, "tag_fx" );
        level waittill( #"hash_fe2a6608" );
        playfxontag( level._effect[ "fx_fuel_pour_far_ven" ], var_ccf9b73f, "tag_fx" );
        level waittill( #"hash_d827eb9f" );
        playfxontag( level._effect[ "fx_fuel_pour_far_ven" ], var_ccf9b73f, "tag_fx" );
        level waittill( #"hash_b2257136" );
        playfxontag( level._effect[ "fx_fuel_pour_far_ven" ], var_ccf9b73f, "tag_fx" );
        level waittill( #"hash_be9dc60a" );
        playfxontag( level._effect[ "fx_fuel_pour_far_ven" ], var_ccf9b73f, "tag_fx" );
        level waittill( #"hash_e4a04073" );
        playfxontag( level._effect[ "fx_fuel_pour_far_ven" ], var_ccf9b73f, "tag_fx" );
        level waittill( #"hash_7298d138" );
        playfxontag( level._effect[ "fx_fuel_pour_far_ven" ], var_ccf9b73f, "tag_fx" );
    }
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0x8a90379f, Offset: 0x3578
// Size: 0xe8
function function_97ac3293()
{
    self endon( #"death" );
    self thread watch_for_death();
    wait 0.2;
    self thread function_a44271e3();
    self util::waittill_any( "alert", "fake_alert" );
    level notify( #"cafeburning_flare_enemy_alert" );
    
    if ( isdefined( self.silenced ) && self.silenced )
    {
        return;
    }
    
    level.cafe_burning_org thread scene::play( "cin_ven_04_20_cafeburning_vign_main" );
    self waittill( #"cafe_burning_match_thrown" );
    level flag::set( "cafe_burning_match_thrown" );
    self.allowdeath = 1;
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0xb6696fc3, Offset: 0x3668
// Size: 0xec
function function_a44271e3()
{
    level endon( #"dogleg_1_end" );
    
    while ( isalive( self ) )
    {
        cafe_burning_flare = getent( "cafe_burning_flare", "targetname", 1 );
        
        if ( isdefined( cafe_burning_flare ) )
        {
            break;
        }
        
        wait 0.05;
    }
    
    if ( !isalive( self ) && !isdefined( cafe_burning_flare ) )
    {
        level.cafe_burning_org scene::stop( "cin_ven_04_20_cafeburning_vign_loop" );
        return;
    }
    
    self thread vengeance_util::function_1ed65aa( array( cafe_burning_flare ) );
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0xb258248a, Offset: 0x3760
// Size: 0x1e
function watch_for_death()
{
    self waittill( #"death" );
    level notify( #"cafeburning_flare_enemy_dead" );
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0x215b0036, Offset: 0x3788
// Size: 0x23c
function cafe_burning_civ_spawn_func()
{
    self endon( #"death" );
    self.team = "allies";
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    self ai::set_behavior_attribute( "panic", 0 );
    self.health = 1;
    self.goalradius = 32;
    msg = level util::waittill_any_return( "cafeburning_flare_enemy_alert", "cafeburning_flare_enemy_dead" );
    
    if ( msg == "cafeburning_flare_enemy_dead" )
    {
        self stopanimscripted();
        self.civilian = 1;
        self ai::set_ignoreme( 0 );
        self ai::set_ignoreall( 0 );
        level.cafe_burning_org scene::play( self.script_parameters );
        
        if ( isdefined( self.target ) )
        {
            node = getnode( self.target, "targetname" );
            self thread vengeance_util::delete_ai_at_path_end( node, undefined, undefined, 1024 );
        }
        
        self ai::set_behavior_attribute( "panic", 1 );
        return;
    }
    
    self waittill( #"cafe_burning_check_for_escape" );
    playsoundatposition( "evt_civ_group_burn", ( 21564, -86, 136 ) );
    self vengeance_util::set_civilian_on_fire( 0 );
    self vengeance_util::set_civilian_on_fire( 0 );
    self vengeance_util::set_civilian_on_fire( 0 );
}

// Namespace vengeance_dogleg_1
// Params 1
// Checksum 0x34bedee1, Offset: 0x39d0
// Size: 0xea
function function_dc4e86b5( enemy_array )
{
    level endon( #"dogleg_1_end" );
    level endon( #"stealth_discovered" );
    self waittill( #"damage", damage, attacker );
    
    if ( isplayer( attacker ) )
    {
        foreach ( enemy in enemy_array )
        {
            if ( isdefined( enemy ) )
            {
                enemy thread stealth_level::wake_all();
            }
        }
    }
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0xef5e150b, Offset: 0x3ac8
// Size: 0x5f4
function cafe_molotov_setup()
{
    level endon( #"dogleg_1_end" );
    level.cafe_molotov_org = struct::get( "cafe_molotov_org" );
    spawner::add_spawn_function_group( "cafe_molotov_civ_spawners", "script_noteworthy", &function_147bbbbf );
    var_932d1fc6 = [];
    var_932d1fc6[ 0 ] = spawner::simple_spawn_single( "cafe_molotov_thug_a", undefined, undefined, undefined, undefined, undefined, undefined, 1 );
    var_932d1fc6[ 1 ] = util::spawn_anim_model( "p7_emergency_flare" );
    var_932d1fc6[ 2 ] = util::spawn_anim_model( "p7_bottle_glass_liquor_03" );
    var_932d1fc6[ 3 ] = util::spawn_anim_model( "p7_bottle_glass_liquor_03" );
    var_932d1fc6[ 4 ] = util::spawn_anim_model( "p7_bottle_glass_liquor_03" );
    var_932d1fc6[ 5 ] = util::spawn_anim_model( "p7_bottle_glass_liquor_03" );
    a_objects = [];
    a_objects[ 0 ] = var_932d1fc6[ 1 ];
    a_objects[ 1 ] = var_932d1fc6[ 2 ];
    a_objects[ 2 ] = var_932d1fc6[ 3 ];
    a_objects[ 3 ] = var_932d1fc6[ 4 ];
    a_objects[ 4 ] = var_932d1fc6[ 5 ];
    wait 0.2;
    level.cafe_molotov_org thread scene::play( "cin_ven_04_20_cafemolotovflush_vign_intro", var_932d1fc6 );
    wait 0.2;
    var_932d1fc6[ 0 ] thread vengeance_util::function_7122594d( a_objects );
    wait 14;
    level.cafe_molotov_org thread scene::play( "cin_ven_04_20_cafemolotovflush_vign_civa" );
    wait 0.05;
    guy = getent( "cafe_molotov_civ_01_ai", "targetname" );
    
    if ( isdefined( guy ) )
    {
        guy thread vengeance_util::set_civilian_on_fire();
    }
    
    wait randomfloatrange( 4, 8 );
    level.cafe_molotov_org thread scene::play( "cin_ven_04_20_cafemolotovflush_vign_civb" );
    wait 0.05;
    guy = getent( "cafe_molotov_civ_02_ai", "targetname" );
    
    if ( isdefined( guy ) )
    {
        guy thread vengeance_util::set_civilian_on_fire();
    }
    
    wait randomfloatrange( 4, 8 );
    level.cafe_molotov_org thread scene::play( "cin_ven_04_20_cafemolotovflush_vign_civc" );
    wait 0.05;
    guy = getent( "cafe_molotov_civ_03_ai", "targetname" );
    
    if ( isdefined( guy ) )
    {
        guy thread vengeance_util::set_civilian_on_fire();
    }
    
    wait randomfloatrange( 4, 8 );
    level.cafe_molotov_org thread scene::play( "cin_ven_04_20_cafemolotovflush_vign_civd" );
    wait 0.05;
    guy = getent( "cafe_molotov_civ_04_ai", "targetname" );
    
    if ( isdefined( guy ) )
    {
        guy thread vengeance_util::set_civilian_on_fire();
    }
    
    wait randomfloatrange( 4, 8 );
    level.cafe_molotov_org thread scene::play( "cin_ven_04_20_cafemolotovflush_vign_cive" );
    wait 0.05;
    guy = getent( "cafe_molotov_civ_05_ai", "targetname" );
    
    if ( isdefined( guy ) )
    {
        guy thread vengeance_util::set_civilian_on_fire();
    }
    
    wait randomfloatrange( 4, 8 );
    level.cafe_molotov_org thread scene::play( "cin_ven_04_20_cafemolotovflush_vign_civf" );
    wait 0.05;
    guy = getent( "cafe_molotov_civ_06_ai", "targetname" );
    
    if ( isdefined( guy ) )
    {
        guy thread vengeance_util::set_civilian_on_fire();
    }
    
    wait randomfloatrange( 4, 8 );
    level.cafe_molotov_org thread scene::play( "cin_ven_04_20_cafemolotovflush_vign_civg" );
    wait 0.05;
    guy = getent( "cafe_molotov_civ_07_ai", "targetname" );
    
    if ( isdefined( guy ) )
    {
        guy thread vengeance_util::set_civilian_on_fire();
    }
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0xb9e4998c, Offset: 0x40c8
// Size: 0x80
function function_147bbbbf()
{
    self endon( #"death" );
    self.team = "allies";
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    self ai::set_behavior_attribute( "panic", 0 );
    self.health = 1;
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0x1c5807d, Offset: 0x4150
// Size: 0x294
function function_6236563e()
{
    wait 3;
    goto_quadtank_alley_obj_org = struct::get( "goto_quadtank_alley_obj_org", "targetname" );
    objectives::set( "cp_level_vengeance_goto_quadtank_alley", goto_quadtank_alley_obj_org );
    quadtank_alley_intro_trigger = getent( "quadtank_alley_intro_trigger", "script_noteworthy" );
    quadtank_alley_intro_trigger triggerenable( 0 );
    msg = level util::waittill_any_return( "goto_quadtank_alley_trigger_touched", "stealth_discovered" );
    
    if ( msg == "stealth_discovered" )
    {
        objectives::hide( "cp_level_vengeance_goto_quadtank_alley" );
        objectives::set( "cp_level_vengeance_clear_area" );
        level flag::wait_till_clear( "stealth_discovered" );
        objectives::show( "cp_level_vengeance_goto_quadtank_alley" );
        objectives::hide( "cp_level_vengeance_clear_area" );
        level flag::wait_till( "goto_quadtank_alley_trigger_touched" );
    }
    
    objectives::hide( "cp_level_vengeance_goto_quadtank_alley" );
    quadtank_alley_intro_trigger triggerenable( 1 );
    e_door_use_object = util::init_interactive_gameobject( quadtank_alley_intro_trigger, &"cp_prompt_enter_ven_gate", &"CP_MI_SING_VENGEANCE_HINT_OPEN", &function_9c72eea2 );
    objectives::set( "cp_level_vengeance_open_quadtank_alley_menu" );
    level thread vengeance_util::stealth_combat_toggle_trigger_and_objective( quadtank_alley_intro_trigger, undefined, "cp_level_vengeance_open_quadtank_alley_menu", "start_quadtank_alley_intro", "cp_level_vengeance_clear_area", e_door_use_object );
    level flag::wait_till( "start_quadtank_alley_intro" );
    e_door_use_object gameobjects::disable_object();
    objectives::hide( "cp_level_vengeance_open_quadtank_alley_menu" );
}

// Namespace vengeance_dogleg_1
// Params 1
// Checksum 0xc64c4987, Offset: 0x43f0
// Size: 0x28
function function_9c72eea2( e_player )
{
    level notify( #"quadtank_alley_activated" );
    level.var_4c62d05f = e_player;
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0x50280df1, Offset: 0x4420
// Size: 0x38
function function_1909c582()
{
    level endon( #"dogleg_1_end" );
    level flag::wait_till( "stealth_combat" );
    level.var_508337f6 = 1;
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0x12d6626a, Offset: 0x4460
// Size: 0x134
function function_6fdd2184()
{
    level endon( #"dogleg_1_end" );
    level flag::wait_till( "stealth_discovered" );
    stealth::function_26f24c93( 0 );
    level thread vengeance_util::function_80840124();
    level thread function_adb6f63( 5 );
    
    while ( true )
    {
        guys = getaiteamarray( "axis" );
        
        if ( isdefined( guys ) && guys.size <= 0 || !isdefined( guys ) )
        {
            break;
        }
        
        wait 0.1;
    }
    
    vengeance_util::function_ee75acde( "hend_that_s_the_last_of_0" );
    level flag::clear( "stealth_combat" );
    level flag::clear( "stealth_discovered" );
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0xca38f392, Offset: 0x45a0
// Size: 0x44
function function_24a63cea()
{
    self endon( #"death" );
    
    if ( isdefined( self.script_stealth_dontseek ) && self.script_stealth_dontseek )
    {
        self ai::set_behavior_attribute( "sprint", 1 );
    }
}

// Namespace vengeance_dogleg_1
// Params 4
// Checksum 0xfeb8e2b6, Offset: 0x45f0
// Size: 0x3dc
function skipto_dogleg_1_done( str_objective, b_starting, b_direct, player )
{
    level flag::set( "dogleg_1_end" );
    level notify( #"hash_bab8795" );
    level flag::clear( "combat_enemies_retreating" );
    level cleanup_dogleg_1();
    vengeance_accolades::function_a4b67c57();
    vengeance_accolades::function_82266abb();
    vengeance_util::function_4e8207e9( "dogleg_1", 0 );
    
    if ( isdefined( b_starting ) && ( !isdefined( b_starting ) || b_starting == 0 ) )
    {
        vengeance_util::init_hero( "hendricks", str_objective );
        vengeance_util::co_op_teleport_on_igc_end( "cin_ven_04_30_quadalleydoor_1st", "quadalleydoor_igc_teleport" );
        spawner::add_spawn_function_group( "quadteaser_qt", "script_noteworthy", &vengeance_quadtank_alley::quadtank_alley_quadtank_setup );
        level thread vengeance_quadtank_alley::function_32620a97();
        level thread vengeance_quadtank_alley::function_323d0a39();
        level util::waittill_notify_or_timeout( "quadtank_alley_activated", 1 );
        
        if ( isdefined( level.bzm_vengeancedialogue6callback ) )
        {
            level thread [[ level.bzm_vengeancedialogue6callback ]]();
        }
        
        level.quadtank_alley_intro_org thread scene::play( "cin_ven_04_30_quadalleydoor_1st", level.var_4c62d05f );
        level waittill( #"hash_57cf6a02" );
        var_7d044b82 = struct::get( "quad_alley_door_physics", "targetname" );
        physicsexplosionsphere( var_7d044b82.origin, 64, 48, 1 );
    }
    
    level struct::delete_script_bundle( "scene", "cin_ven_04_10_cafedoor_1st_sh010" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_10_cafedoor_3rd_sh020" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_10_cafedoor_3rd_sh030" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_10_cafedoor_3rd_sh040" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_10_cafedoor_3rd_sh050" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_10_cafedoor_3rd_sh060" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_10_cafedoor_3rd_sh070" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_10_cafedoor_3rd_sh080" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_10_cafedoor_3rd_sh090" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_10_cafedoor_1st_sh100" );
}

// Namespace vengeance_dogleg_1
// Params 0
// Checksum 0x70ae359f, Offset: 0x49d8
// Size: 0x10a
function cleanup_dogleg_1()
{
    array::thread_all( getaiteamarray( "axis" ), &util::self_delete );
    array::run_all( getcorpsearray(), &delete );
    
    if ( isdefined( level.dogleg_1_wasps ) )
    {
        foreach ( enemy in level.dogleg_1_wasps )
        {
            if ( isdefined( enemy ) )
            {
                enemy delete();
            }
        }
    }
}

// Namespace vengeance_dogleg_1
// Params 1
// Checksum 0x9a688757, Offset: 0x4af0
// Size: 0x290
function function_adb6f63( var_f02766b0 )
{
    level endon( #"dogleg_1_end" );
    
    if ( !isdefined( var_f02766b0 ) )
    {
        var_f02766b0 = 3;
    }
    
    while ( true )
    {
        guys = getaiteamarray( "axis" );
        
        if ( isdefined( guys ) && guys.size <= var_f02766b0 )
        {
            foreach ( guy in guys )
            {
                if ( isdefined( guy ) && isalive( guy ) )
                {
                    if ( isvehicle( guy ) )
                    {
                        dogleg_1_wasp_retreat_nodes = struct::get_array( "dogleg_1_wasp_retreat_nodes", "targetname" );
                        node = array::random( dogleg_1_wasp_retreat_nodes );
                        guy thread vengeance_util::delete_ai_at_path_end( node );
                    }
                    
                    node = getnodearraysorted( "dogleg_1_retreat_nodes", "targetname", guy.origin, 4096 );
                    
                    if ( isdefined( node[ 0 ] ) )
                    {
                        if ( guy ai::has_behavior_attribute( "sprint" ) )
                        {
                            guy ai::set_behavior_attribute( "sprint", 1 );
                        }
                        
                        guy thread vengeance_util::delete_ai_at_path_end( node[ 0 ] );
                        continue;
                    }
                    
                    a_ai = array( guy );
                    level thread vengeance_util::delete_ai_when_out_of_sight( a_ai, 1024 );
                }
            }
            
            level flag::set( "combat_enemies_retreating" );
            break;
        }
        
        wait 1;
    }
}

// Namespace vengeance_dogleg_1
// Params 1
// Checksum 0x866d64f8, Offset: 0x4d88
// Size: 0x5c
function dogleg_1_vo( b_starting )
{
    level endon( #"stealth_discovered" );
    stealth::function_26f24c93( 1 );
    flag::wait_till( "dogleg_1_stealth_motivator_01" );
    flag::wait_till( "dogleg_1_stealth_motivator_02" );
}

