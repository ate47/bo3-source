#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/ai/behavior_zombie_dog;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_ai_dogs;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_hero_weapon;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/_zm_perk_deadshot;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_staminup;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_power;
#using scripts/zm/_zm_powerup_carpenter;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_powerup_fire_sale;
#using scripts/zm/_zm_powerup_free_perk;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_insta_kill;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_timer;
#using scripts/zm/_zm_trap_electric;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_annihilator;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_weap_bowie;
#using scripts/zm/_zm_weap_cymbal_monkey;
#using scripts/zm/_zm_weap_tesla;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/bgbs/_zm_bgb_anywhere_but_here;
#using scripts/zm/zm_factory_cleanup_mgr;
#using scripts/zm/zm_factory_ffotd;
#using scripts/zm/zm_factory_fx;
#using scripts/zm/zm_factory_gamemodes;
#using scripts/zm/zm_factory_teleporter;
#using scripts/zm/zm_factory_vo;
#using scripts/zm/zm_factory_zombie;

#namespace zm_factory;

// Namespace zm_factory
// Params 0, eflags: 0x2
// Checksum 0xe0864ca4, Offset: 0x1e50
// Size: 0x28
function autoexec opt_in()
{
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
    level.randomize_perk_machine_location = 1;
}

// Namespace zm_factory
// Params 0
// Checksum 0x625215dc, Offset: 0x1e80
// Size: 0xa0c
function main()
{
    zm_factory_ffotd::main_start();
    setclearanceceiling( 17 );
    zm_factory_fx::main();
    init_clientfields();
    scene::add_scene_func( "p7_fxanim_zm_factory_bridge_lft_bundle", &bridge_disconnect, "init" );
    scene::add_scene_func( "p7_fxanim_zm_factory_bridge_lft_bundle", &bridge_connect, "done" );
    scene::add_scene_func( "p7_fxanim_zm_factory_bridge_rt_bundle", &bridge_disconnect, "init" );
    scene::add_scene_func( "p7_fxanim_zm_factory_bridge_rt_bundle", &bridge_connect, "done" );
    level._uses_sticky_grenades = 1;
    level._uses_taser_knuckles = 1;
    zm::init_fx();
    level util::set_lighting_state( 1 );
    callback::on_connect( &function_7cb67075 );
    callback::on_spawned( &on_player_spawned );
    level._effect[ "eye_glow" ] = "zombie/fx_glow_eye_orange";
    level._effect[ "headshot" ] = "zombie/fx_bul_flesh_head_fatal_zmb";
    level._effect[ "headshot_nochunks" ] = "zombie/fx_bul_flesh_head_nochunks_zmb";
    level._effect[ "bloodspurt" ] = "zombie/fx_bul_flesh_neck_spurt_zmb";
    level._effect[ "animscript_gib_fx" ] = "zombie/fx_blood_torso_explo_zmb";
    level._effect[ "animscript_gibtrail_fx" ] = "trail/fx_trail_blood_streak";
    level._effect[ "switch_sparks" ] = "electric/fx_elec_sparks_directional_orange";
    level.var_9cef605e = &function_81abed86;
    level.default_start_location = "start_room";
    level.default_game_mode = "zclassic";
    zm::spawn_life_brush( ( 700, -986, 280 ), 128, 128 );
    level.random_pandora_box_start = 1;
    
    if ( 1 == getdvarint( "movie_intro" ) )
    {
        setdvar( "art_review", "1" );
        level.random_pandora_box_start = 0;
        level.start_chest_name = "chest_4";
        clock_snow = getent( "clock_snow", "targetname" );
        clock_snow ghost();
        scene::add_scene_func( "cin_der_01_intro_3rd_sh050", &clock_shot, "play" );
        level thread cinematic();
    }
    else
    {
        clock = getent( "factory_clock", "targetname" );
        clock thread scene::play( "p7_fxanim_zm_factory_clock_bundle" );
    }
    
    level.has_richtofen = 0;
    level.powerup_special_drop_override = &powerup_special_drop_override;
    level.precachecustomcharacters = &precachecustomcharacters;
    level.givecustomcharacters = &givecustomcharacters;
    level thread setup_personality_character_exerts();
    initcharacterstartindex();
    level.register_offhand_weapons_for_level_defaults_override = &offhand_weapon_overrride;
    level.zombiemode_offhand_weapon_give_override = &offhand_weapon_give_override;
    level._zombie_custom_add_weapons = &custom_add_weapons;
    level thread custom_add_vox();
    level._allow_melee_weapon_switching = 1;
    level.enemy_location_override_func = &enemy_location_override;
    level.no_target_override = &no_target_override;
    zm_pap_util::enable_swap_attachments();
    level thread function_e0f73644();
    include_weapons();
    include_powerups();
    include_perks();
    level.zm_custom_spawn_location_selection = &factory_custom_spawn_location_selection;
    load::main();
    fx_overrides();
    compass::setupminimap( "compass_map_zm_factory" );
    _zm_weap_cymbal_monkey::init();
    _zm_weap_tesla::init();
    level.pulls_since_last_ray_gun = 0;
    level.pulls_since_last_tesla_gun = 0;
    level.player_drops_tesla_gun = 0;
    level.debug_keyline_zombies = 0;
    level.burning_zombies = [];
    level.max_barrier_search_dist_override = 400;
    level.door_dialog_function = &zm::play_door_dialog;
    script_anims_init();
    level.zombie_anim_override = &anim_override_func;
    level.dog_rounds_allowed = getgametypesetting( "allowdogs" );
    
    if ( level.dog_rounds_allowed )
    {
        zm_ai_dogs::enable_dog_rounds();
    }
    
    level.fn_custom_round_ai_spawn = &function_33aa4940;
    level._round_start_func = &zm::round_start;
    init_sounds();
    init_achievement();
    level thread power_electric_switch();
    level thread magic_box_init();
    level.zones = [];
    level.zone_manager_init_func = &factory_zone_init;
    init_zones[ 0 ] = "receiver_zone";
    level thread zm_zonemgr::manage_zones( init_zones );
    level function_a1d5988d();
    level.zombie_ai_limit = 24;
    level thread jump_from_bridge();
    level lock_additional_player_spawner();
    level thread bridge_init();
    level.grenade_planted = &function_6ea54e62;
    level thread sndfunctions();
    level.sndtrapfunc = &sndpa_traps;
    level.monk_scream_trig = getent( "monk_scream_trig", "targetname" );
    zombie_utility::set_zombie_var( "zombie_powerup_drop_max_per_round", 4 );
    a_t_audio = getentarray( "audio_bump_trigger", "targetname" );
    
    foreach ( t_audio_bump in a_t_audio )
    {
        if ( t_audio_bump.script_sound === "zmb_perks_bump_bottle" )
        {
            t_audio_bump thread check_for_change();
        }
    }
    
    trigs = getentarray( "trig_ee", "targetname" );
    array::thread_all( trigs, &extra_events );
    level.use_powerup_volumes = 1;
    level.zm_bgb_anywhere_but_here_validation_override = &function_869d6f66;
    level thread function_6d012317();
    level thread flytrap();
    level thread function_5d386c43();
    
    /#
        level thread function_afea638c();
    #/
    
    zm_factory_ffotd::main_end();
}

// Namespace zm_factory
// Params 0
// Checksum 0xff977775, Offset: 0x2898
// Size: 0xf4
function init_clientfields()
{
    clientfield::register( "world", "console_blue", 1, 1, "int" );
    clientfield::register( "world", "console_green", 1, 1, "int" );
    clientfield::register( "world", "console_red", 1, 1, "int" );
    clientfield::register( "world", "console_start", 1, 1, "int" );
    clientfield::register( "toplayer", "lightning_strike", 1, 1, "counter" );
}

// Namespace zm_factory
// Params 0
// Checksum 0x9af05b50, Offset: 0x2998
// Size: 0x108
function function_a1d5988d()
{
    var_e4821d40 = level.zones[ "wnuen_bridge_zone" ].a_loc_types[ "dog_location" ];
    
    if ( isdefined( var_e4821d40 ) )
    {
        foreach ( spawn in var_e4821d40 )
        {
            if ( spawn.origin == ( 1196, -1459.8, 135.4 ) )
            {
                spawn.origin = getclosestpointonnavmesh( ( 1244, -1444, 136 ), 15 );
                return;
            }
        }
    }
}

// Namespace zm_factory
// Params 0
// Checksum 0xbf22cda5, Offset: 0x2aa8
// Size: 0x1fc
function cinematic()
{
    level flag::wait_till( "all_players_connected" );
    setdvar( "cg_draw2D", 0 );
    setdvar( "cg_drawFPS", 0 );
    setdvar( "cg_drawPerformanceWarnings", 0 );
    
    while ( !aretexturesloaded() )
    {
        wait 0.05;
    }
    
    visionsetnaked( "cp_igc_chinatown_intro", 0.05 );
    
    foreach ( e_player in level.players )
    {
        e_player freezecontrols( 1 );
        e_player allowsprint( 0 );
        e_player allowjump( 0 );
    }
    
    level.players[ 0 ] setclientuivisibilityflag( "hud_visible", 0 );
    setdvar( "debug_show_viewpos", "0" );
    wait 3;
    s_tag_align = struct::get( "tag_align_switch_box" );
    s_tag_align scene::play( "cin_der_01_intro_3rd_sh010" );
}

// Namespace zm_factory
// Params 1
// Checksum 0xe3e26732, Offset: 0x2cb0
// Size: 0x54
function clock_shot( a_ents )
{
    clock = getent( "factory_clock", "targetname" );
    clock thread scene::play( "p7_fxanim_zm_factory_clock_igc_bundle" );
}

// Namespace zm_factory
// Params 0
// Checksum 0xd9218a30, Offset: 0x2d10
// Size: 0x1c
function on_player_spawned()
{
    self thread periodic_lightning_strikes();
}

// Namespace zm_factory
// Params 0
// Checksum 0x58731def, Offset: 0x2d38
// Size: 0xa6
function periodic_lightning_strikes()
{
    self endon( #"disconnect" );
    util::wait_network_frame();
    
    while ( true )
    {
        n_random_wait = randomintrange( 12, 18 );
        
        if ( isdefined( self ) && isplayer( self ) )
        {
            self notify( #"lightning_strike" );
            self clientfield::increment_to_player( "lightning_strike", 1 );
        }
        
        wait n_random_wait;
    }
}

// Namespace zm_factory
// Params 0
// Checksum 0xefd0e0b3, Offset: 0x2de8
// Size: 0xd6
function offhand_weapon_overrride()
{
    zm_utility::register_lethal_grenade_for_level( "frag_grenade" );
    level.zombie_lethal_grenade_player_init = getweapon( "frag_grenade" );
    zm_utility::register_tactical_grenade_for_level( "cymbal_monkey" );
    zm_utility::register_tactical_grenade_for_level( "emp_grenade" );
    zm_utility::register_melee_weapon_for_level( level.weaponbasemelee.name );
    zm_utility::register_melee_weapon_for_level( "bowie_knife" );
    zm_utility::register_melee_weapon_for_level( "tazer_knuckles" );
    level.zombie_melee_weapon_player_init = level.weaponbasemelee;
    level.zombie_equipment_player_init = undefined;
}

// Namespace zm_factory
// Params 1
// Checksum 0x69b0f77a, Offset: 0x2ec8
// Size: 0xbe, Type: bool
function offhand_weapon_give_override( weapon )
{
    self endon( #"death" );
    
    if ( zm_utility::is_tactical_grenade( weapon ) && isdefined( self zm_utility::get_player_tactical_grenade() ) && !self zm_utility::is_player_tactical_grenade( weapon ) )
    {
        self setweaponammoclip( self zm_utility::get_player_tactical_grenade(), 0 );
        self takeweapon( self zm_utility::get_player_tactical_grenade() );
    }
    
    return false;
}

// Namespace zm_factory
// Params 0
// Checksum 0x5eb26eb2, Offset: 0x2f90
// Size: 0x1c
function include_powerups()
{
    zm_powerups::add_zombie_special_drop( "nothing" );
}

// Namespace zm_factory
// Params 0
// Checksum 0x99ec1590, Offset: 0x2fb8
// Size: 0x4
function include_perks()
{
    
}

// Namespace zm_factory
// Params 0
// Checksum 0x99ec1590, Offset: 0x2fc8
// Size: 0x4
function include_weapons()
{
    
}

// Namespace zm_factory
// Params 0
// Checksum 0x99ec1590, Offset: 0x2fd8
// Size: 0x4
function precachecustomcharacters()
{
    
}

// Namespace zm_factory
// Params 0
// Checksum 0x19145859, Offset: 0x2fe8
// Size: 0x24
function initcharacterstartindex()
{
    level.characterstartindex = randomint( 4 );
}

// Namespace zm_factory
// Params 0
// Checksum 0x7f313978, Offset: 0x3018
// Size: 0x3e
function selectcharacterindextouse()
{
    if ( level.characterstartindex >= 4 )
    {
        level.characterstartindex = 0;
    }
    
    self.characterindex = level.characterstartindex;
    level.characterstartindex++;
    return self.characterindex;
}

// Namespace zm_factory
// Params 0
// Checksum 0x750d7f35, Offset: 0x3060
// Size: 0x214
function assign_lowest_unused_character_index()
{
    charindexarray = [];
    charindexarray[ 0 ] = 0;
    charindexarray[ 1 ] = 1;
    charindexarray[ 2 ] = 2;
    charindexarray[ 3 ] = 3;
    players = getplayers();
    
    if ( players.size == 1 )
    {
        charindexarray = array::randomize( charindexarray );
        
        if ( charindexarray[ 0 ] == 2 )
        {
            level.has_richtofen = 1;
        }
        
        return charindexarray[ 0 ];
    }
    else
    {
        n_characters_defined = 0;
        
        foreach ( player in players )
        {
            if ( isdefined( player.characterindex ) )
            {
                arrayremovevalue( charindexarray, player.characterindex, 0 );
                n_characters_defined++;
            }
        }
        
        if ( charindexarray.size > 0 )
        {
            if ( n_characters_defined == players.size - 1 )
            {
                if ( !( isdefined( level.has_richtofen ) && level.has_richtofen ) )
                {
                    level.has_richtofen = 1;
                    return 2;
                }
            }
            
            charindexarray = array::randomize( charindexarray );
            
            if ( charindexarray[ 0 ] == 2 )
            {
                level.has_richtofen = 1;
            }
            
            return charindexarray[ 0 ];
        }
    }
    
    return 0;
}

// Namespace zm_factory
// Params 0
// Checksum 0xabe7a763, Offset: 0x3280
// Size: 0x2cc
function givecustomcharacters()
{
    if ( isdefined( level.hotjoin_player_setup ) && [[ level.hotjoin_player_setup ]]( "c_zom_farmgirl_viewhands" ) )
    {
        return;
    }
    
    self detachall();
    
    if ( !isdefined( self.characterindex ) )
    {
        self.characterindex = assign_lowest_unused_character_index();
    }
    
    self.favorite_wall_weapons_list = [];
    self.talks_in_danger = 0;
    
    /#
        if ( getdvarstring( "<dev string:x28>" ) != "<dev string:x33>" )
        {
            self.characterindex = getdvarint( "<dev string:x28>" );
        }
    #/
    
    self setcharacterbodytype( self.characterindex );
    self setcharacterbodystyle( 0 );
    self setcharacterhelmetstyle( 0 );
    
    switch ( self.characterindex )
    {
        case 1:
            self.favorite_wall_weapons_list[ self.favorite_wall_weapons_list.size ] = getweapon( "870mcs" );
            break;
        case 0:
            self.favorite_wall_weapons_list[ self.favorite_wall_weapons_list.size ] = getweapon( "frag_grenade" );
            self.favorite_wall_weapons_list[ self.favorite_wall_weapons_list.size ] = getweapon( "bouncingbetty" );
            break;
        case 3:
            self.favorite_wall_weapons_list[ self.favorite_wall_weapons_list.size ] = getweapon( "hk416" );
            break;
        case 2:
            self.talks_in_danger = 1;
            level.rich_sq_player = self;
            level.sndradioa = self;
            self.favorite_wall_weapons_list[ self.favorite_wall_weapons_list.size ] = getweapon( "pistol_standard" );
            break;
    }
    
    self setmovespeedscale( 1 );
    self setsprintduration( 4 );
    self setsprintcooldown( 0 );
    self thread set_exert_id();
}

// Namespace zm_factory
// Params 0
// Checksum 0xd7209e10, Offset: 0x3558
// Size: 0x54
function set_exert_id()
{
    self endon( #"disconnect" );
    util::wait_network_frame();
    util::wait_network_frame();
    self zm_audio::setexertvoice( self.characterindex + 1 );
}

// Namespace zm_factory
// Params 0
// Checksum 0x93ae0305, Offset: 0x35b8
// Size: 0x7f2
function setup_personality_character_exerts()
{
    level.exert_sounds[ 1 ][ "burp" ][ 0 ] = "evt_belch";
    level.exert_sounds[ 1 ][ "burp" ][ 1 ] = "evt_belch";
    level.exert_sounds[ 1 ][ "burp" ][ 2 ] = "evt_belch";
    level.exert_sounds[ 2 ][ "burp" ][ 0 ] = "evt_belch";
    level.exert_sounds[ 2 ][ "burp" ][ 1 ] = "evt_belch";
    level.exert_sounds[ 2 ][ "burp" ][ 2 ] = "evt_belch";
    level.exert_sounds[ 3 ][ "burp" ][ 0 ] = "evt_belch";
    level.exert_sounds[ 3 ][ "burp" ][ 1 ] = "evt_belch";
    level.exert_sounds[ 3 ][ "burp" ][ 2 ] = "evt_belch";
    level.exert_sounds[ 4 ][ "burp" ][ 0 ] = "evt_belch";
    level.exert_sounds[ 4 ][ "burp" ][ 1 ] = "evt_belch";
    level.exert_sounds[ 4 ][ "burp" ][ 2 ] = "evt_belch";
    level.exert_sounds[ 1 ][ "hitmed" ][ 0 ] = "vox_plr_0_exert_pain_0";
    level.exert_sounds[ 1 ][ "hitmed" ][ 1 ] = "vox_plr_0_exert_pain_1";
    level.exert_sounds[ 1 ][ "hitmed" ][ 2 ] = "vox_plr_0_exert_pain_2";
    level.exert_sounds[ 1 ][ "hitmed" ][ 3 ] = "vox_plr_0_exert_pain_3";
    level.exert_sounds[ 1 ][ "hitmed" ][ 4 ] = "vox_plr_0_exert_pain_4";
    level.exert_sounds[ 2 ][ "hitmed" ][ 0 ] = "vox_plr_1_exert_pain_0";
    level.exert_sounds[ 2 ][ "hitmed" ][ 1 ] = "vox_plr_1_exert_pain_1";
    level.exert_sounds[ 2 ][ "hitmed" ][ 2 ] = "vox_plr_1_exert_pain_2";
    level.exert_sounds[ 2 ][ "hitmed" ][ 3 ] = "vox_plr_1_exert_pain_3";
    level.exert_sounds[ 2 ][ "hitmed" ][ 4 ] = "vox_plr_1_exert_pain_4";
    level.exert_sounds[ 3 ][ "hitmed" ][ 0 ] = "vox_plr_2_exert_pain_0";
    level.exert_sounds[ 3 ][ "hitmed" ][ 1 ] = "vox_plr_2_exert_pain_1";
    level.exert_sounds[ 3 ][ "hitmed" ][ 2 ] = "vox_plr_2_exert_pain_2";
    level.exert_sounds[ 3 ][ "hitmed" ][ 3 ] = "vox_plr_2_exert_pain_3";
    level.exert_sounds[ 3 ][ "hitmed" ][ 4 ] = "vox_plr_2_exert_pain_4";
    level.exert_sounds[ 4 ][ "hitmed" ][ 0 ] = "vox_plr_3_exert_pain_0";
    level.exert_sounds[ 4 ][ "hitmed" ][ 1 ] = "vox_plr_3_exert_pain_1";
    level.exert_sounds[ 4 ][ "hitmed" ][ 2 ] = "vox_plr_3_exert_pain_2";
    level.exert_sounds[ 4 ][ "hitmed" ][ 3 ] = "vox_plr_3_exert_pain_3";
    level.exert_sounds[ 4 ][ "hitmed" ][ 4 ] = "vox_plr_3_exert_pain_4";
    level.exert_sounds[ 1 ][ "hitlrg" ][ 0 ] = "vox_plr_0_exert_pain_0";
    level.exert_sounds[ 1 ][ "hitlrg" ][ 1 ] = "vox_plr_0_exert_pain_1";
    level.exert_sounds[ 1 ][ "hitlrg" ][ 2 ] = "vox_plr_0_exert_pain_2";
    level.exert_sounds[ 1 ][ "hitlrg" ][ 3 ] = "vox_plr_0_exert_pain_3";
    level.exert_sounds[ 1 ][ "hitlrg" ][ 4 ] = "vox_plr_0_exert_pain_4";
    level.exert_sounds[ 2 ][ "hitlrg" ][ 0 ] = "vox_plr_1_exert_pain_0";
    level.exert_sounds[ 2 ][ "hitlrg" ][ 1 ] = "vox_plr_1_exert_pain_1";
    level.exert_sounds[ 2 ][ "hitlrg" ][ 2 ] = "vox_plr_1_exert_pain_2";
    level.exert_sounds[ 2 ][ "hitlrg" ][ 3 ] = "vox_plr_1_exert_pain_3";
    level.exert_sounds[ 2 ][ "hitlrg" ][ 4 ] = "vox_plr_1_exert_pain_4";
    level.exert_sounds[ 3 ][ "hitlrg" ][ 0 ] = "vox_plr_2_exert_pain_0";
    level.exert_sounds[ 3 ][ "hitlrg" ][ 1 ] = "vox_plr_2_exert_pain_1";
    level.exert_sounds[ 3 ][ "hitlrg" ][ 2 ] = "vox_plr_2_exert_pain_2";
    level.exert_sounds[ 3 ][ "hitlrg" ][ 3 ] = "vox_plr_2_exert_pain_3";
    level.exert_sounds[ 3 ][ "hitlrg" ][ 4 ] = "vox_plr_2_exert_pain_4";
    level.exert_sounds[ 4 ][ "hitlrg" ][ 0 ] = "vox_plr_3_exert_pain_0";
    level.exert_sounds[ 4 ][ "hitlrg" ][ 1 ] = "vox_plr_3_exert_pain_1";
    level.exert_sounds[ 4 ][ "hitlrg" ][ 2 ] = "vox_plr_3_exert_pain_2";
    level.exert_sounds[ 4 ][ "hitlrg" ][ 3 ] = "vox_plr_3_exert_pain_3";
    level.exert_sounds[ 4 ][ "hitlrg" ][ 4 ] = "vox_plr_3_exert_pain_4";
}

// Namespace zm_factory
// Params 0
// Checksum 0xee1ead4, Offset: 0x3db8
// Size: 0x24
function custom_add_weapons()
{
    zm_weapons::load_weapon_spec_from_table( "gamedata/weapons/zm/zm_factory_weapons.csv", 1 );
}

// Namespace zm_factory
// Params 0
// Checksum 0x174127a6, Offset: 0x3de8
// Size: 0x1c
function custom_add_vox()
{
    zm_audio::loadplayervoicecategories( "gamedata/audio/zm/zm_factory_vox.csv" );
}

// Namespace zm_factory
// Params 0
// Checksum 0x99ec1590, Offset: 0x3e10
// Size: 0x4
function init_achievement()
{
    
}

// Namespace zm_factory
// Params 0
// Checksum 0xf28cd1de, Offset: 0x3e20
// Size: 0x1e4
function factory_zone_init()
{
    zm_zonemgr::add_adjacent_zone( "receiver_zone", "outside_east_zone", "enter_outside_east" );
    zm_zonemgr::add_adjacent_zone( "receiver_zone", "outside_west_zone", "enter_outside_west" );
    zm_zonemgr::add_adjacent_zone( "wnuen_zone", "outside_east_zone", "enter_wnuen_building" );
    zm_zonemgr::add_adjacent_zone( "wnuen_zone", "wnuen_bridge_zone", "enter_wnuen_loading_dock" );
    zm_zonemgr::add_adjacent_zone( "warehouse_bottom_zone", "outside_west_zone", "enter_warehouse_building" );
    zm_zonemgr::add_adjacent_zone( "warehouse_bottom_zone", "warehouse_top_zone", "enter_warehouse_second_floor" );
    zm_zonemgr::add_adjacent_zone( "warehouse_top_zone", "bridge_zone", "enter_warehouse_second_floor" );
    zm_zonemgr::add_adjacent_zone( "tp_east_zone", "wnuen_zone", "enter_tp_east" );
    zm_zonemgr::add_adjacent_zone( "tp_east_zone", "outside_east_zone", "enter_tp_east", 1 );
    zm_zonemgr::add_zone_flags( "enter_tp_east", "enter_wnuen_building" );
    zm_zonemgr::add_adjacent_zone( "tp_south_zone", "outside_south_zone", "enter_tp_south" );
    zm_zonemgr::add_adjacent_zone( "tp_west_zone", "warehouse_top_zone", "enter_tp_west" );
}

// Namespace zm_factory
// Params 0
// Checksum 0x2f86e5e1, Offset: 0x4010
// Size: 0x416
function intro_screen()
{
    if ( 1 == getdvarint( "movie_intro" ) )
    {
        return;
    }
    
    level flag::wait_till( "start_zombie_round_logic" );
    wait 2;
    level.intro_hud = [];
    
    for ( i = 0; i < 3 ; i++ )
    {
        level.intro_hud[ i ] = newhudelem();
        level.intro_hud[ i ].x = 0;
        level.intro_hud[ i ].y = 0;
        level.intro_hud[ i ].alignx = "left";
        level.intro_hud[ i ].aligny = "bottom";
        level.intro_hud[ i ].horzalign = "left";
        level.intro_hud[ i ].vertalign = "bottom";
        level.intro_hud[ i ].foreground = 1;
        
        if ( level.splitscreen && !level.hidef )
        {
            level.intro_hud[ i ].fontscale = 2.75;
        }
        else
        {
            level.intro_hud[ i ].fontscale = 1.75;
        }
        
        level.intro_hud[ i ].alpha = 0;
        level.intro_hud[ i ].color = ( 1, 1, 1 );
        level.intro_hud[ i ].inuse = 0;
    }
    
    level.intro_hud[ 0 ].y = -110;
    level.intro_hud[ 1 ].y = -90;
    level.intro_hud[ 2 ].y = -70;
    level.intro_hud[ 0 ] settext( &"ZOMBIE_INTRO_FACTORY_LEVEL_PLACE" );
    level.intro_hud[ 1 ] settext( "" );
    level.intro_hud[ 2 ] settext( "" );
    
    for ( i = 0; i < 3 ; i++ )
    {
        level.intro_hud[ i ] fadeovertime( 3.5 );
        level.intro_hud[ i ].alpha = 1;
        wait 1.5;
    }
    
    wait 1.5;
    
    for ( i = 0; i < 3 ; i++ )
    {
        level.intro_hud[ i ] fadeovertime( 3.5 );
        level.intro_hud[ i ].alpha = 0;
        wait 1.5;
    }
    
    for ( i = 0; i < 3 ; i++ )
    {
        level.intro_hud[ i ] destroy();
    }
}

// Namespace zm_factory
// Params 2
// Checksum 0xf611ee64, Offset: 0x4430
// Size: 0x86
function enemy_location_override( zombie, enemy )
{
    aiprofile_beginentry( "factory-enemy_location_override" );
    
    if ( isdefined( zombie.is_trapped ) && zombie.is_trapped )
    {
        aiprofile_endentry();
        return zombie.origin;
    }
    
    aiprofile_endentry();
    return undefined;
}

// Namespace zm_factory
// Params 1
// Checksum 0xe05d486d, Offset: 0x44c0
// Size: 0x80, Type: bool
function validate_and_set_no_target_position( position )
{
    if ( isdefined( position ) )
    {
        goal_point = getclosestpointonnavmesh( position.origin, 100 );
        
        if ( isdefined( goal_point ) )
        {
            self setgoal( goal_point );
            self.has_exit_point = 1;
            return true;
        }
    }
    
    return false;
}

// Namespace zm_factory
// Params 1
// Checksum 0x72ae20ad, Offset: 0x4548
// Size: 0x33c
function no_target_override( zombie )
{
    if ( isdefined( zombie.has_exit_point ) )
    {
        return;
    }
    
    players = level.players;
    dist_zombie = 0;
    dist_player = 0;
    dest = 0;
    
    if ( isdefined( level.zm_loc_types[ "dog_location" ] ) )
    {
        locs = array::randomize( level.zm_loc_types[ "dog_location" ] );
        
        for ( i = 0; i < locs.size ; i++ )
        {
            found_point = 0;
            
            foreach ( player in players )
            {
                if ( player laststand::player_is_in_laststand() )
                {
                    continue;
                }
                
                away = vectornormalize( self.origin - player.origin );
                endpos = self.origin + vectorscale( away, 600 );
                dist_zombie = distancesquared( locs[ i ].origin, endpos );
                dist_player = distancesquared( locs[ i ].origin, player.origin );
                
                if ( dist_zombie < dist_player )
                {
                    dest = i;
                    found_point = 1;
                    continue;
                }
                
                found_point = 0;
            }
            
            if ( found_point )
            {
                if ( zombie validate_and_set_no_target_position( locs[ i ] ) )
                {
                    return;
                }
            }
        }
    }
    
    escape_position = zombie factory_cleanup::get_escape_position_in_current_zone();
    
    if ( zombie validate_and_set_no_target_position( escape_position ) )
    {
        return;
    }
    
    escape_position = zombie factory_cleanup::get_escape_position();
    
    if ( zombie validate_and_set_no_target_position( escape_position ) )
    {
        return;
    }
    
    zombie.has_exit_point = 1;
    zombie setgoal( zombie.origin );
}

// Namespace zm_factory
// Params 0
// Checksum 0x99ec1590, Offset: 0x4890
// Size: 0x4
function script_anims_init()
{
    
}

// Namespace zm_factory
// Params 1
// Checksum 0xea46cc04, Offset: 0x48a0
// Size: 0xc
function factory_playanim( animname )
{
    
}

// Namespace zm_factory
// Params 0
// Checksum 0x99ec1590, Offset: 0x48b8
// Size: 0x4
function anim_override_func()
{
    
}

// Namespace zm_factory
// Params 0
// Checksum 0xf1bff87a, Offset: 0x48c8
// Size: 0x72
function lock_additional_player_spawner()
{
    spawn_points = struct::get_array( "player_respawn_point", "targetname" );
    
    for ( i = 0; i < spawn_points.size ; i++ )
    {
        spawn_points[ i ].locked = 1;
    }
}

// Namespace zm_factory
// Params 0
// Checksum 0x9252ea55, Offset: 0x4948
// Size: 0x23c
function bridge_init()
{
    level flag::init( "bridge_down" );
    bridge_audio = struct::get( "bridge_audio", "targetname" );
    level flag::wait_till( "power_on" );
    level util::clientnotify( "pl1" );
    level thread scene::play( "p7_fxanim_zm_factory_bridge_lft_bundle" );
    level scene::play( "p7_fxanim_zm_factory_bridge_rt_bundle" );
    level flag::set( "bridge_down" );
    wnuen_bridge_clip = getent( "wnuen_bridge_clip", "targetname" );
    wnuen_bridge_clip connectpaths();
    wnuen_bridge_clip delete();
    warehouse_bridge_clip = getent( "warehouse_bridge_clip", "targetname" );
    warehouse_bridge_clip connectpaths();
    warehouse_bridge_clip delete();
    wnuen_bridge = getent( "wnuen_bridge", "targetname" );
    wnuen_bridge connectpaths();
    zm_zonemgr::connect_zones( "wnuen_bridge_zone", "bridge_zone" );
    zm_zonemgr::connect_zones( "warehouse_top_zone", "bridge_zone" );
    wait 14;
    level thread sndpa_dovox( "vox_maxis_teleporter_lost_0" );
}

// Namespace zm_factory
// Params 1
// Checksum 0xe5883cee, Offset: 0x4b90
// Size: 0x92
function bridge_disconnect( a_parts )
{
    foreach ( part in a_parts )
    {
        part disconnectpaths();
    }
}

// Namespace zm_factory
// Params 1
// Checksum 0xd3e83a4f, Offset: 0x4c30
// Size: 0x92
function bridge_connect( a_parts )
{
    foreach ( part in a_parts )
    {
        part connectpaths();
    }
}

// Namespace zm_factory
// Params 0
// Checksum 0xcb5f100f, Offset: 0x4cd0
// Size: 0x8c
function jump_from_bridge()
{
    trig = getent( "trig_outside_south_zone", "targetname" );
    trig waittill( #"trigger" );
    zm_zonemgr::connect_zones( "outside_south_zone", "bridge_zone", 1 );
    zm_zonemgr::connect_zones( "outside_south_zone", "wnuen_bridge_zone", 1 );
}

// Namespace zm_factory
// Params 0
// Checksum 0x9fd8e3c2, Offset: 0x4d68
// Size: 0x84
function init_sounds()
{
    zm_utility::add_sound( "break_stone", "evt_break_stone" );
    zm_utility::add_sound( "gate_door", "zmb_gate_slide_open" );
    zm_utility::add_sound( "heavy_door", "zmb_heavy_door_open" );
    zm_utility::add_sound( "zmb_heavy_door_open", "zmb_heavy_door_open" );
}

// Namespace zm_factory
// Params 0
// Checksum 0x8781d5, Offset: 0x4df8
// Size: 0xc8
function factory_ray_gun_weighting_func()
{
    if ( level.chest_moves > 0 )
    {
        num_to_add = 1;
        
        if ( isdefined( level.pulls_since_last_ray_gun ) )
        {
            if ( level.pulls_since_last_ray_gun > 11 )
            {
                num_to_add += int( level.zombie_include_weapons.size * 0.1 );
            }
            else if ( level.pulls_since_last_ray_gun > 7 )
            {
                num_to_add += int( 0.05 * level.zombie_include_weapons.size );
            }
        }
        
        return num_to_add;
    }
    
    return 0;
}

// Namespace zm_factory
// Params 0
// Checksum 0x1a62080d, Offset: 0x4ec8
// Size: 0xbc
function factory_cymbal_monkey_weighting_func()
{
    players = getplayers();
    count = 0;
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( players[ i ] zm_weapons::has_weapon_or_upgrade( "cymbal_monkey_zm" ) )
        {
            count++;
        }
    }
    
    if ( count > 0 )
    {
        return 1;
    }
    
    if ( level.round_number < 10 )
    {
        return 3;
    }
    
    return 5;
}

// Namespace zm_factory
// Params 0
// Checksum 0x8b5f3197, Offset: 0x4f90
// Size: 0x9a
function magic_box_init()
{
    level.open_chest_location = [];
    level.open_chest_location[ 0 ] = "chest1";
    level.open_chest_location[ 1 ] = "chest2";
    level.open_chest_location[ 2 ] = "chest3";
    level.open_chest_location[ 3 ] = "chest4";
    level.open_chest_location[ 4 ] = "chest5";
    level.open_chest_location[ 5 ] = "start_chest";
}

// Namespace zm_factory
// Params 1
// Checksum 0x5e92ef42, Offset: 0x5038
// Size: 0x4c
function power_on_listener( trig )
{
    /#
        trig endon( #"trigger" );
        level flag::wait_till( "<dev string:x34>" );
        trig notify( #"trigger" );
    #/
}

// Namespace zm_factory
// Params 0
// Checksum 0xd270df3, Offset: 0x5090
// Size: 0x3dc
function power_electric_switch()
{
    trig = getent( "use_power_switch", "targetname" );
    trig sethintstring( &"ZOMBIE_ELECTRIC_SWITCH" );
    trig setcursorhint( "HINT_NOICON" );
    cheat = 0;
    
    /#
        if ( getdvarint( "<dev string:x3d>" ) >= 3 )
        {
            wait 5;
            cheat = 1;
        }
    #/
    
    user = undefined;
    
    if ( cheat != 1 )
    {
        level thread power_on_listener( trig );
        trig waittill( #"trigger", user );
        
        if ( isdefined( user ) )
        {
        }
    }
    
    level thread scene::play( "power_switch", "targetname" );
    level flag::set( "power_on" );
    util::wait_network_frame();
    level notify( #"sleight_on" );
    util::wait_network_frame();
    level notify( #"revive_on" );
    util::wait_network_frame();
    level notify( #"doubletap_on" );
    util::wait_network_frame();
    level notify( #"juggernog_on" );
    util::wait_network_frame();
    level notify( #"pack_a_punch_on" );
    util::wait_network_frame();
    level notify( #"specialty_armorvest_power_on" );
    util::wait_network_frame();
    level notify( #"specialty_rof_power_on" );
    util::wait_network_frame();
    level notify( #"specialty_quickrevive_power_on" );
    util::wait_network_frame();
    level notify( #"specialty_fastreload_power_on" );
    util::wait_network_frame();
    level util::set_lighting_state( 0 );
    util::clientnotify( "ZPO" );
    util::wait_network_frame();
    trig delete();
    wait 1;
    s_switch = struct::get( "power_switch_fx", "targetname" );
    forward = anglestoforward( s_switch.origin );
    playfx( level._effect[ "switch_sparks" ], s_switch.origin, forward );
    zm_zonemgr::connect_zones( "outside_east_zone", "outside_south_zone" );
    zm_zonemgr::connect_zones( "outside_west_zone", "outside_south_zone", 1 );
    level util::delay( 19, undefined, &zm_audio::sndmusicsystem_playstate, "power_on" );
}

// Namespace zm_factory
// Params 0
// Checksum 0x2379271, Offset: 0x5478
// Size: 0x9c
function check_for_change()
{
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( player getstance() == "prone" )
        {
            player zm_score::add_to_player_score( 100 );
            zm_utility::play_sound_at_pos( "purchase", player.origin );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace zm_factory
// Params 0
// Checksum 0xd11e9e55, Offset: 0x5520
// Size: 0xa4
function extra_events()
{
    self usetriggerrequirelookat();
    self setcursorhint( "HINT_NOICON" );
    self waittill( #"trigger" );
    targ = getent( self.target, "targetname" );
    
    if ( isdefined( targ ) )
    {
        targ movez( -10, 5 );
    }
}

// Namespace zm_factory
// Params 0
// Checksum 0x6dfe874d, Offset: 0x55d0
// Size: 0x2b4
function flytrap()
{
    level flag::init( "hide_and_seek" );
    level flag::init( "flytrap" );
    level.flytrap_counter = 0;
    level thread hide_and_seek_target( "ee_exp_monkey" );
    util::wait_network_frame();
    level thread hide_and_seek_target( "ee_bowie_bear" );
    util::wait_network_frame();
    level thread hide_and_seek_target( "ee_perk_bear" );
    util::wait_network_frame();
    trig_control_panel = getent( "trig_ee_flytrap", "targetname" );
    
    for ( upgrade_hit = 0; !upgrade_hit ; upgrade_hit = 1 )
    {
        trig_control_panel waittill( #"damage", amount, inflictor, direction, point, type, tagname, modelname, partname, weapon );
        
        if ( zm_weapons::is_weapon_upgraded( weapon ) )
        {
        }
    }
    
    level flag::set( "flytrap" );
    thread zm_utility::play_sound_2d( "vox_maxis_flytrap_1_0" );
    scene::play( "p7_fxanim_zm_factory_fly_trap_bundle" );
    wait 9;
    level flag::set( "hide_and_seek" );
    level flag::wait_till( "ee_exp_monkey" );
    level flag::wait_till( "ee_bowie_bear" );
    level flag::wait_till( "ee_perk_bear" );
    level thread flytrap_prize();
}

// Namespace zm_factory
// Params 1
// Checksum 0xf3392270, Offset: 0x5890
// Size: 0x21c
function hide_and_seek_target( target_name )
{
    level flag::init( target_name );
    obj_array = getentarray( target_name, "targetname" );
    
    for ( i = 0; i < obj_array.size ; i++ )
    {
        obj_array[ i ] hide();
    }
    
    trig = getent( "trig_" + target_name, "targetname" );
    trig triggerenable( 0 );
    level flag::wait_till( "hide_and_seek" );
    
    for ( i = 0; i < obj_array.size ; i++ )
    {
        obj_array[ i ] show();
    }
    
    trig triggerenable( 1 );
    trig waittill( #"trigger" );
    level.flytrap_counter += 1;
    thread flytrap_samantha_vox();
    trig playsound( "zmb_flytrap_target_" + level.flytrap_counter );
    
    for ( i = 0; i < obj_array.size ; i++ )
    {
        obj_array[ i ] hide();
    }
    
    level flag::set( target_name );
}

// Namespace zm_factory
// Params 2
// Checksum 0xde21565f, Offset: 0x5ab8
// Size: 0x156
function phono_egg_init( trigger_name, origin_name )
{
    if ( !isdefined( level.phono_counter ) )
    {
        level.phono_counter = 0;
    }
    
    players = getplayers();
    phono_trig = getent( trigger_name, "targetname" );
    phono_origin = getent( origin_name, "targetname" );
    
    if ( !isdefined( phono_trig ) || !isdefined( phono_origin ) )
    {
        return;
    }
    
    phono_trig usetriggerrequirelookat();
    phono_trig setcursorhint( "HINT_NOICON" );
    
    for ( i = 0; i < players.size ; i++ )
    {
        phono_trig waittill( #"trigger", players );
        level.phono_counter += 1;
        phono_origin play_phono_egg();
    }
}

// Namespace zm_factory
// Params 0
// Checksum 0xd3b7b2e1, Offset: 0x5c18
// Size: 0xac
function play_phono_egg()
{
    if ( !isdefined( level.phono_counter ) )
    {
        level.phono_counter = 0;
    }
    
    if ( level.phono_counter == 1 )
    {
        self playsound( "evt_phono_one" );
    }
    
    if ( level.phono_counter == 2 )
    {
        self playsound( "evt_phono_two" );
    }
    
    if ( level.phono_counter == 3 )
    {
        self playsound( "evt_phono_three" );
    }
}

// Namespace zm_factory
// Params 2
// Checksum 0x2e2f47d4, Offset: 0x5cd0
// Size: 0x166
function radio_egg_init( trigger_name, origin_name )
{
    players = getplayers();
    radio_trig = getent( trigger_name, "targetname" );
    radio_origin = getent( origin_name, "targetname" );
    
    if ( !isdefined( radio_trig ) || !isdefined( radio_origin ) )
    {
        return;
    }
    
    radio_trig usetriggerrequirelookat();
    radio_trig setcursorhint( "HINT_NOICON" );
    radio_origin playloopsound( "amb_radio_static" );
    
    for ( i = 0; i < players.size ; i++ )
    {
        radio_trig waittill( #"trigger", players );
        radio_origin stoploopsound( 0.1 );
        radio_origin playsound( trigger_name );
    }
}

// Namespace zm_factory
// Params 1
// Checksum 0xbfb245ca, Offset: 0x5e40
// Size: 0x5c
function play_music_easter_egg( player )
{
    level.music_override = 1;
    wait 4;
    
    if ( isdefined( player ) )
    {
        player zm_audio::create_and_play_dialog( "eggs", "music_activate" );
    }
    
    wait 236;
    level.music_override = 0;
}

// Namespace zm_factory
// Params 1
// Checksum 0x20e0fa62, Offset: 0x5ea8
// Size: 0x124
function meteor_egg( trigger_name )
{
    meteor_trig = getent( trigger_name, "targetname" );
    meteor_trig usetriggerrequirelookat();
    meteor_trig setcursorhint( "HINT_NOICON" );
    meteor_trig playloopsound( "zmb_meteor_loop" );
    meteor_trig waittill( #"trigger", player );
    meteor_trig stoploopsound( 1 );
    player playsound( "zmb_meteor_activate" );
    level.meteor_counter += 1;
    
    if ( level.meteor_counter == 3 )
    {
        level thread play_music_easter_egg( player );
    }
}

// Namespace zm_factory
// Params 0
// Checksum 0x3de47be4, Offset: 0x5fd8
// Size: 0xc0
function flytrap_samantha_vox()
{
    if ( !isdefined( level.flytrap_counter ) )
    {
        level.flytrap_counter = 0;
    }
    
    if ( level.flytrap_counter == 1 )
    {
        thread zm_utility::play_sound_2d( "vox_maxis_flytrap_2_0" );
    }
    
    if ( level.flytrap_counter == 2 )
    {
        thread zm_utility::play_sound_2d( "vox_maxis_flytrap_3_0" );
    }
    
    if ( level.flytrap_counter == 3 )
    {
        thread zm_utility::play_sound_2d( "vox_maxis_flytrap_4_0" );
        wait 9;
        thread zm_utility::play_sound_2d( "vox_maxis_flytrap_4_1" );
        return;
    }
    
    wait 0.05;
}

// Namespace zm_factory
// Params 0
// Checksum 0x98241ccf, Offset: 0x60a0
// Size: 0x6e
function factory_exit_level()
{
    zombies = getaiarray( level.zombie_team );
    
    for ( i = 0; i < zombies.size ; i++ )
    {
        zombies[ i ] thread factory_find_exit_point();
    }
}

// Namespace zm_factory
// Params 0
// Checksum 0x9a6d80ea, Offset: 0x6118
// Size: 0x218
function factory_find_exit_point()
{
    self endon( #"death" );
    player = getplayers()[ 0 ];
    dist_zombie = 0;
    dist_player = 0;
    dest = 0;
    away = vectornormalize( self.origin - player.origin );
    endpos = self.origin + vectorscale( away, 600 );
    locs = array::randomize( level.zm_loc_types[ "dog_location" ] );
    
    for ( i = 0; i < locs.size ; i++ )
    {
        dist_zombie = distancesquared( locs[ i ].origin, endpos );
        dist_player = distancesquared( locs[ i ].origin, player.origin );
        
        if ( dist_zombie < dist_player )
        {
            dest = i;
            break;
        }
    }
    
    self notify( #"stop_find_flesh" );
    self notify( #"zombie_acquire_enemy" );
    self setgoal( locs[ dest ].origin );
    
    while ( true )
    {
        if ( !level flag::get( "wait_and_revive" ) )
        {
            break;
        }
        
        util::wait_network_frame();
    }
}

// Namespace zm_factory
// Params 0
// Checksum 0x4a7c9765, Offset: 0x6338
// Size: 0x31a
function powerup_special_drop_override()
{
    if ( level.round_number <= 10 )
    {
        powerup = zm_powerups::get_valid_powerup();
    }
    else
    {
        powerup = level.zombie_special_drop_array[ randomint( level.zombie_special_drop_array.size ) ];
        
        if ( level.round_number > 15 && randomint( 100 ) < ( level.round_number - 15 ) * 5 )
        {
            powerup = "nothing";
        }
    }
    
    switch ( powerup )
    {
        case "full_ammo":
            if ( level.round_number > 10 && randomint( 100 ) < ( level.round_number - 10 ) * 5 )
            {
                powerup = level.zombie_powerup_array[ randomint( level.zombie_powerup_array.size ) ];
            }
            
            break;
        case "dog":
            if ( level.round_number >= 15 )
            {
                dog_spawners = getentarray( "special_dog_spawner", "targetname" );
                thread zm_utility::play_sound_2d( "vox_sam_nospawn" );
                powerup = undefined;
            }
            else
            {
                powerup = zm_powerups::get_valid_powerup();
            }
            
            break;
        case "free_perk":
        default:
            if ( isdefined( level._zombiemode_special_drop_setup ) )
            {
                is_powerup = [[ level._zombiemode_special_drop_setup ]]( powerup );
            }
            else
            {
                playfx( level._effect[ "lightning_dog_spawn" ], self.origin );
                playsoundatposition( "zmb_hellhound_prespawn", self.origin );
                wait 1.5;
                playsoundatposition( "zmb_hellhound_bolt", self.origin );
                earthquake( 0.5, 0.75, self.origin, 1000 );
                playsoundatposition( "zmb_hellhound_spawn", self.origin );
                wait 1;
                thread zm_utility::play_sound_2d( "vox_sam_nospawn" );
                self delete();
            }
            
            powerup = undefined;
            break;
    }
    
    return powerup;
}

// Namespace zm_factory
// Params 0
// Checksum 0xa48f6b57, Offset: 0x6660
// Size: 0x22, Type: bool
function function_81abed86()
{
    if ( isdefined( self.b_teleporting ) && self.b_teleporting )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_factory
// Params 0
// Checksum 0x5dbba146, Offset: 0x6690
// Size: 0x9c
function sndfunctions()
{
    level thread setupmusic();
    level thread sndfirstdoor();
    level thread sndpasetup();
    level thread sndradiosetup();
    level thread sndconversations();
    level.sndweaponpickupoverride = array( "hero_annihilator" );
}

// Namespace zm_factory
// Params 0
// Checksum 0xb0e50cab, Offset: 0x6738
// Size: 0x384
function sndconversations()
{
    level flag::wait_till( "initial_blackscreen_passed" );
    level zm_audio::sndconversation_init( "round1start" );
    level zm_audio::sndconversation_addline( "round1start", "round1_start_0", 4, 2 );
    level zm_audio::sndconversation_addline( "round1start", "round1_start_0", 2 );
    level zm_audio::sndconversation_addline( "round1start", "round1_start_1", 4, 2 );
    level zm_audio::sndconversation_addline( "round1start", "round1_start_1", 2 );
    level zm_audio::sndconversation_init( "round1during", "end_of_round" );
    level zm_audio::sndconversation_addline( "round1during", "round1_during_0", 1 );
    level zm_audio::sndconversation_addline( "round1during", "round1_during_0", 3 );
    level zm_audio::sndconversation_addline( "round1during", "round1_during_0", 0 );
    level zm_audio::sndconversation_addline( "round1during", "round1_during_0", 2 );
    level zm_audio::sndconversation_init( "round1end" );
    level zm_audio::sndconversation_addline( "round1end", "round1_end_0", 4, 2 );
    level zm_audio::sndconversation_addline( "round1end", "round1_end_0", 2 );
    level zm_audio::sndconversation_init( "round2during", "end_of_round" );
    level zm_audio::sndconversation_addline( "round2during", "round2_during_0", 0 );
    level zm_audio::sndconversation_addline( "round2during", "round2_during_0", 3 );
    level zm_audio::sndconversation_addline( "round2during", "round2_during_0", 1 );
    level zm_audio::sndconversation_addline( "round2during", "round2_during_0", 2 );
    
    if ( level.players.size >= 2 )
    {
        level thread sndconvo1();
        level thread sndconvo2();
        level thread sndconvo3();
        level thread sndconvo4();
        return;
    }
    
    level thread sndfieldreport1();
}

// Namespace zm_factory
// Params 0
// Checksum 0x8b869caf, Offset: 0x6ac8
// Size: 0x3c
function sndconvo1()
{
    wait randomintrange( 2, 5 );
    level zm_audio::sndconversation_play( "round1start" );
}

// Namespace zm_factory
// Params 0
// Checksum 0xa2774706, Offset: 0x6b10
// Size: 0x4c
function sndconvo2()
{
    level waittill( #"sndconversationdone" );
    wait randomintrange( 20, 30 );
    level zm_audio::sndconversation_play( "round1during" );
}

// Namespace zm_factory
// Params 0
// Checksum 0x3db77537, Offset: 0x6b68
// Size: 0x4c
function sndconvo3()
{
    level waittill( #"end_of_round" );
    wait randomintrange( 4, 7 );
    level zm_audio::sndconversation_play( "round1end" );
}

// Namespace zm_factory
// Params 0
// Checksum 0x23e8bfa4, Offset: 0x6bc0
// Size: 0x74
function sndconvo4()
{
    while ( true )
    {
        level waittill( #"start_of_round" );
        
        if ( !( isdefined( level.first_round ) && level.first_round ) )
        {
            break;
        }
    }
    
    wait randomintrange( 45, 60 );
    level zm_audio::sndconversation_play( "round2during" );
}

// Namespace zm_factory
// Params 0
// Checksum 0xe7af021e, Offset: 0x6c40
// Size: 0xf4
function sndfieldreport1()
{
    wait randomintrange( 7, 10 );
    
    while ( isdefined( level.players[ 0 ].isspeaking ) && level.players[ 0 ].isspeaking )
    {
        wait 0.5;
    }
    
    level.sndvoxoverride = 1;
    doline( level.players[ 0 ], "fieldreport_start_0" );
    
    if ( isdefined( getspecificcharacter( 2 ) ) )
    {
        doline( level.players[ 0 ], "fieldreport_start_1" );
    }
    
    level.sndvoxoverride = 0;
    level thread sndfieldreport2();
}

// Namespace zm_factory
// Params 0
// Checksum 0x6edba3f0, Offset: 0x6d40
// Size: 0xc4
function sndfieldreport2()
{
    level waittill( #"end_of_round" );
    wait randomintrange( 1, 3 );
    
    while ( isdefined( level.players[ 0 ].isspeaking ) && level.players[ 0 ].isspeaking )
    {
        wait 0.5;
    }
    
    level.sndvoxoverride = 1;
    doline( level.players[ 0 ], "fieldreport_round1_0" );
    level.sndvoxoverride = 0;
    level thread sndfieldreport3();
}

// Namespace zm_factory
// Params 0
// Checksum 0xfd163a15, Offset: 0x6e10
// Size: 0xf0
function sndfieldreport3()
{
    level waittill( #"end_of_round" );
    wait randomintrange( 1, 3 );
    
    while ( isdefined( level.players[ 0 ].isspeaking ) && level.players[ 0 ].isspeaking )
    {
        wait 0.5;
    }
    
    level.sndvoxoverride = 1;
    doline( level.players[ 0 ], "fieldreport_round2_0" );
    
    if ( isdefined( getspecificcharacter( 2 ) ) )
    {
        doline( level.players[ 0 ], "fieldreport_round2_1" );
    }
    
    level.sndvoxoverride = 0;
}

// Namespace zm_factory
// Params 2
// Checksum 0x8104d230, Offset: 0x6f08
// Size: 0xd4
function doline( guy, alias )
{
    if ( isdefined( guy ) )
    {
        guy clientfield::set_to_player( "isspeaking", 1 );
        guy playsoundontag( "vox_plr_" + guy.characterindex + "_" + alias, "J_Head" );
        waitplaybacktime( "vox_plr_" + guy.characterindex + "_" + alias );
        guy clientfield::set_to_player( "isspeaking", 0 );
    }
}

// Namespace zm_factory
// Params 1
// Checksum 0x61921ba2, Offset: 0x6fe8
// Size: 0x76
function waitplaybacktime( alias )
{
    playbacktime = soundgetplaybacktime( alias );
    
    if ( !isdefined( playbacktime ) )
    {
        playbacktime = 1;
    }
    
    if ( playbacktime >= 0 )
    {
        playbacktime *= 0.001;
    }
    else
    {
        playbacktime = 1;
    }
    
    wait playbacktime;
}

// Namespace zm_factory
// Params 0
// Checksum 0xb4746e8e, Offset: 0x7068
// Size: 0xba
function getrandomnotrichtofen()
{
    array = level.players;
    array::randomize( array );
    
    foreach ( guy in array )
    {
        if ( guy.characterindex != 2 )
        {
            return guy;
        }
    }
    
    return undefined;
}

// Namespace zm_factory
// Params 1
// Checksum 0xa6c71e98, Offset: 0x7130
// Size: 0x9a
function getspecificcharacter( charindex )
{
    foreach ( guy in level.players )
    {
        if ( guy.characterindex == charindex )
        {
            return guy;
        }
    }
    
    return undefined;
}

// Namespace zm_factory
// Params 0
// Checksum 0xd3455f7b, Offset: 0x71d8
// Size: 0xa0, Type: bool
function isanyonetalking()
{
    foreach ( player in level.players )
    {
        if ( isdefined( player.isspeaking ) && player.isspeaking )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_factory
// Params 0
// Checksum 0xd4aefa2e, Offset: 0x7280
// Size: 0xb4
function sndradiosetup()
{
    level thread zm_audio::sndradiosetup( "vox_maxis_maxis_radio", undefined, ( 582, -2167, 286 ), ( 629, -1257, 259 ), ( -594, -1359, 108 ), ( -159, 437, 18 ), ( 1219, 136, 90 ) );
    level thread sndspecialradiosetup( "vox_maxis_player_radio", ( 966, 805, 124 ), ( -1197, -1466, 215 ), ( -94, -2324, 175 ) );
}

// Namespace zm_factory
// Params 4
// Checksum 0xc621af7b, Offset: 0x7340
// Size: 0x2de
function sndspecialradiosetup( alias_prefix, origin1, origin2, origin3 )
{
    radio = spawnstruct();
    radio.counter = 1;
    radio.alias_prefix = alias_prefix;
    radio.isplaying = 0;
    radio.array = array();
    
    if ( !isdefined( radio.array ) )
    {
        radio.array = [];
    }
    else if ( !isarray( radio.array ) )
    {
        radio.array = array( radio.array );
    }
    
    radio.array[ radio.array.size ] = origin1;
    
    if ( !isdefined( radio.array ) )
    {
        radio.array = [];
    }
    else if ( !isarray( radio.array ) )
    {
        radio.array = array( radio.array );
    }
    
    radio.array[ radio.array.size ] = origin2;
    
    if ( !isdefined( radio.array ) )
    {
        radio.array = [];
    }
    else if ( !isarray( radio.array ) )
    {
        radio.array = array( radio.array );
    }
    
    radio.array[ radio.array.size ] = origin3;
    
    if ( radio.array.size > 0 )
    {
        for ( i = 0; i < radio.array.size ; i++ )
        {
            level thread sndradiowait( radio.array[ i ], radio, i + 1 );
        }
    }
}

// Namespace zm_factory
// Params 3
// Checksum 0x7ed25d98, Offset: 0x7628
// Size: 0x2d4
function sndradiowait( origin, radio, num )
{
    temp_ent = spawn( "script_origin", origin );
    temp_ent thread zm_audio::secretuse( "sndRadioHit", ( 255, 0, 0 ), &zm_audio::sndradio_override, radio );
    temp_ent waittill( #"sndradiohit", player );
    
    if ( isdefined( level.sndradioa ) && level.sndradioa == player )
    {
        if ( num == 1 )
        {
            alias = "vox_maxis_player_radio1a";
        }
        
        if ( num == 2 )
        {
            alias = "vox_maxis_player_radio2a";
        }
        
        if ( num == 3 )
        {
            alias = "vox_maxis_player_radio3a";
        }
    }
    else
    {
        if ( num == 1 )
        {
            alias = "vox_demp_player_radio1b";
        }
        
        if ( num == 2 )
        {
            alias = "vox_niko_player_radio2b";
        }
        
        if ( num == 3 )
        {
            alias = "vox_take_player_radio3b";
        }
    }
    
    radionum = num;
    radioalias = alias;
    radiolinecount = zm_spawner::get_number_variants( radioalias );
    
    if ( radiolinecount > 0 )
    {
        radio.isplaying = 1;
        
        for ( i = 0; i < radiolinecount ; i++ )
        {
            temp_ent playsound( radioalias + "_" + i );
            playbacktime = soundgetplaybacktime( radioalias + "_" + i );
            
            if ( !isdefined( playbacktime ) )
            {
                playbacktime = 1;
            }
            
            if ( playbacktime >= 0 )
            {
                playbacktime *= 0.001;
            }
            else
            {
                playbacktime = 1;
            }
            
            wait playbacktime;
        }
    }
    
    radio.counter++;
    radio.isplaying = 0;
    temp_ent delete();
}

// Namespace zm_factory
// Params 2
// Checksum 0x4cfb2ffa, Offset: 0x7908
// Size: 0x29c
function function_6ea54e62( grenade, model )
{
    grenade endon( #"death" );
    grenade endon( #"explode" );
    
    if ( grenade.weapon.name === "cymbal_monkey" )
    {
        if ( grenade istouching( level.monk_scream_trig ) )
        {
            grenade.monk_scream_vox = 1;
            grenade playsound( "zmb_vox_cymmonkey_scream" );
            return;
        }
        else
        {
            var_6cfabdcd = getentarray( "sndTransportTrig", "targetname" );
            
            foreach ( trig in var_6cfabdcd )
            {
                if ( grenade istouching( trig ) )
                {
                    grenade.monk_scream_vox = 1;
                    
                    if ( isdefined( level.cymbal_monkey_dual_view ) && level.cymbal_monkey_dual_view )
                    {
                        grenade playsoundtoteam( "zmb_monkey_song_reverse", "allies" );
                    }
                    else
                    {
                        grenade playsound( "zmb_cymmonkey_song_reverse" );
                    }
                    
                    wait 6.5;
                    grenade playsound( "zmb_vox_cymmonkey_explode_reverse" );
                    return;
                }
            }
        }
        
        if ( !( isdefined( grenade.monk_scream_vox ) && grenade.monk_scream_vox ) )
        {
            if ( isdefined( level.cymbal_monkey_dual_view ) && level.cymbal_monkey_dual_view )
            {
                grenade playsoundtoteam( "zmb_monkey_song", "allies" );
            }
            else
            {
                grenade playsound( "zmb_cymmonkey_song" );
            }
            
            wait 6.5;
            grenade playsound( "zmb_vox_cymmonkey_explode" );
        }
    }
}

// Namespace zm_factory
// Params 0
// Checksum 0x7f420a13, Offset: 0x7bb0
// Size: 0x21c
function setupmusic()
{
    zm_audio::musicstate_create( "round_start", 3, "roundstart1", "roundstart2", "roundstart3", "roundstart4" );
    zm_audio::musicstate_create( "round_start_short", 3, "roundstart_short1", "roundstart_short2", "roundstart_short3", "roundstart_short4" );
    zm_audio::musicstate_create( "round_start_first", 3, "roundstart_first" );
    zm_audio::musicstate_create( "round_end", 3, "roundend1" );
    zm_audio::musicstate_create( "game_over", 5, "gameover" );
    zm_audio::musicstate_create( "dog_start", 3, "dogstart1" );
    zm_audio::musicstate_create( "dog_end", 3, "dogend1" );
    zm_audio::musicstate_create( "timer", 3, "timer" );
    zm_audio::musicstate_create( "power_on", 2, "poweron" );
    zm_audio::musicstate_create( "musicEasterEgg", 4, "egg" );
    zm_audio::sndmusicsystem_eesetup( "musicEasterEgg", ( 900, -586, 151 ), ( 987, -873, 122 ), ( -1340, -483, 255 ) );
    level thread function_f8db7034();
}

// Namespace zm_factory
// Params 0
// Checksum 0x1086b83c, Offset: 0x7dd8
// Size: 0x2c
function function_f8db7034()
{
    level waittill( #"hash_a1b1dadb" );
    level thread audio::unlockfrontendmusic( "mus_beauty_the_giant_mix_intro" );
}

// Namespace zm_factory
// Params 0
// Checksum 0x6d834ad3, Offset: 0x7e10
// Size: 0x2c
function sndfirstdoor()
{
    level waittill( #"snddooropening" );
    level thread zm_audio::sndmusicsystem_playstate( "first_door" );
}

// Namespace zm_factory
// Params 0
// Checksum 0x49ebe818, Offset: 0x7e48
// Size: 0x160
function sndpasetup()
{
    level.patalking = 0;
    level.paarray = array();
    array = struct::get_array( "pa_system", "targetname" );
    
    foreach ( pa in array )
    {
        ent = spawn( "script_origin", pa.origin );
        
        if ( !isdefined( level.paarray ) )
        {
            level.paarray = [];
        }
        else if ( !isarray( level.paarray ) )
        {
            level.paarray = array( level.paarray );
        }
        
        level.paarray[ level.paarray.size ] = ent;
    }
}

// Namespace zm_factory
// Params 3
// Checksum 0x68977d45, Offset: 0x7fb0
// Size: 0x104
function sndpa_dovox( alias, delay, nowait )
{
    if ( !isdefined( nowait ) )
    {
        nowait = 0;
    }
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    if ( !( isdefined( level.patalking ) && level.patalking ) )
    {
        level.patalking = 1;
        level thread sndpa_playvox( alias );
        playbacktime = soundgetplaybacktime( alias );
        
        if ( !isdefined( playbacktime ) || playbacktime <= 2 )
        {
            waittime = 1;
        }
        else
        {
            waittime = playbacktime * 0.001;
        }
        
        if ( !nowait )
        {
            wait waittime - 0.9;
        }
        
        level.patalking = 0;
    }
}

// Namespace zm_factory
// Params 1
// Checksum 0x3524c7f7, Offset: 0x80c0
// Size: 0xba
function sndpa_playvox( alias )
{
    array::randomize( level.paarray );
    
    foreach ( pa in level.paarray )
    {
        pa playsound( alias );
        wait 0.05;
    }
}

// Namespace zm_factory
// Params 2
// Checksum 0x2e350ccf, Offset: 0x8188
// Size: 0x17e
function sndpa_traps( trap, stage )
{
    if ( isdefined( trap ) )
    {
        if ( stage == 1 )
        {
            switch ( trap.target )
            {
                case "trap_b":
                    level thread sndpa_dovox( "vox_maxis_trap_warehouse_inuse_0", 2 );
                    break;
                case "trap_a":
                    level thread sndpa_dovox( "vox_maxis_trap_lab_inuse_0", 2 );
                    break;
                default:
                    level thread sndpa_dovox( "vox_maxis_trap_bridge_inuse_0", 2 );
                    break;
            }
            
            return;
        }
        
        switch ( trap.target )
        {
            case "trap_b":
                level thread sndpa_dovox( "vox_maxis_trap_warehouse_active_0", 4 );
                break;
            case "trap_a":
                level thread sndpa_dovox( "vox_maxis_trap_lab_active_0", 4 );
                break;
            default:
                level thread sndpa_dovox( "vox_maxis_trap_bridge_active_0", 4 );
                break;
        }
    }
}

// Namespace zm_factory
// Params 0
// Checksum 0xbb6a84bb, Offset: 0x8310
// Size: 0x158
function function_33aa4940()
{
    var_88369d66 = 0;
    
    if ( level.round_number > 30 )
    {
        if ( randomfloat( 100 ) < 4 )
        {
            var_88369d66 = 1;
        }
    }
    else if ( level.round_number > 25 )
    {
        if ( randomfloat( 100 ) < 3 )
        {
            var_88369d66 = 1;
        }
    }
    else if ( level.round_number > 20 )
    {
        if ( randomfloat( 100 ) < 2 )
        {
            var_88369d66 = 1;
        }
    }
    else if ( level.round_number > 15 )
    {
        if ( randomfloat( 100 ) < 1 )
        {
            var_88369d66 = 1;
        }
    }
    
    if ( var_88369d66 )
    {
        zm_ai_dogs::special_dog_spawn( 1 );
        level.zombie_total--;
    }
    
    return var_88369d66;
}

// Namespace zm_factory
// Params 1
// Checksum 0x9fe9768, Offset: 0x8470
// Size: 0x21c
function factory_custom_spawn_location_selection( a_spots )
{
    if ( level.zombie_respawns > 0 )
    {
        if ( !isdefined( level.n_player_spawn_selection_index ) )
        {
            level.n_player_spawn_selection_index = 0;
        }
        
        a_players = getplayers();
        level.n_player_spawn_selection_index++;
        
        if ( level.n_player_spawn_selection_index >= a_players.size )
        {
            level.n_player_spawn_selection_index = 0;
        }
        
        e_player = a_players[ level.n_player_spawn_selection_index ];
        arraysortclosest( a_spots, e_player.origin );
        a_candidates = [];
        v_player_dir = anglestoforward( e_player.angles );
        
        for ( i = 0; i < a_spots.size ; i++ )
        {
            v_dir = a_spots[ i ].origin - e_player.origin;
            dp = vectordot( v_player_dir, v_dir );
            
            if ( dp >= 0 )
            {
                a_candidates[ a_candidates.size ] = a_spots[ i ];
                
                if ( a_candidates.size > 10 )
                {
                    break;
                }
            }
        }
        
        if ( a_candidates.size )
        {
            s_spot = array::random( a_candidates );
        }
        else
        {
            s_spot = array::random( a_spots );
        }
    }
    else
    {
        s_spot = array::random( a_spots );
    }
    
    return s_spot;
}

// Namespace zm_factory
// Params 2, eflags: 0x4
// Checksum 0x5d4c96ca, Offset: 0x8698
// Size: 0x120
function private factory_closest_player( origin, players )
{
    closest = players[ 0 ];
    closest_dist = self zm_utility::approximate_path_dist( closest );
    
    if ( !isdefined( closest_dist ) )
    {
        closest = undefined;
    }
    
    for ( index = 1; index < players.size ; index++ )
    {
        dist = self zm_utility::approximate_path_dist( players[ index ] );
        
        if ( isdefined( dist ) && dist < closest_dist )
        {
            closest = players[ index ];
            closest_dist = dist;
        }
    }
    
    if ( players.size > 1 && isdefined( closest ) )
    {
        self zm_utility::approximate_path_dist( closest );
    }
    
    return closest;
}

// Namespace zm_factory
// Params 0
// Checksum 0x4b72cf39, Offset: 0x87c0
// Size: 0xc6
function fx_overrides()
{
    level._effect[ "jugger_light" ] = "zombie/fx_perk_juggernaut_factory_zmb";
    level._effect[ "revive_light" ] = "zombie/fx_perk_quick_revive_factory_zmb";
    level._effect[ "sleight_light" ] = "zombie/fx_perk_sleight_of_hand_factory_zmb";
    level._effect[ "doubletap2_light" ] = "zombie/fx_perk_doubletap2_factory_zmb";
    level._effect[ "deadshot_light" ] = "zombie/fx_perk_daiquiri_factory_zmb";
    level._effect[ "marathon_light" ] = "zombie/fx_perk_stamin_up_factory_zmb";
    level._effect[ "additionalprimaryweapon_light" ] = "zombie/fx_perk_mule_kick_factory_zmb";
}

// Namespace zm_factory
// Params 0
// Checksum 0x1df7305a, Offset: 0x8890
// Size: 0x44
function function_6d012317()
{
    var_3d01fc2c = getent( "cipher_brick_main", "script_noteworthy" );
    var_3d01fc2c thread brick_cipher();
}

// Namespace zm_factory
// Params 0
// Checksum 0x88a3fa55, Offset: 0x88e0
// Size: 0x18a
function brick_cipher()
{
    self create_unitrigger();
    self waittill( #"trigger_activated" );
    var_74772b0f = getentarray( "cipher_bricks", "targetname" );
    
    foreach ( var_3d01fc2c in var_74772b0f )
    {
        var_3d01fc2c movez( 375, 2 );
    }
    
    zm_unitrigger::unregister_unitrigger( self.s_unitrigger );
    wait 2;
    
    foreach ( var_3d01fc2c in var_74772b0f )
    {
        var_3d01fc2c delete();
    }
}

// Namespace zm_factory
// Params 1
// Checksum 0xc72f6f31, Offset: 0x8a78
// Size: 0xdc
function create_unitrigger( str_hint )
{
    s_unitrigger = spawnstruct();
    s_unitrigger.origin = self.origin;
    s_unitrigger.angles = self.angles;
    s_unitrigger.script_unitrigger_type = "unitrigger_radius_use";
    s_unitrigger.cursor_hint = "HINT_NOICON";
    s_unitrigger.str_hint = str_hint;
    s_unitrigger.related_parent = self;
    s_unitrigger.radius = 64;
    self.s_unitrigger = s_unitrigger;
    zm_unitrigger::register_static_unitrigger( s_unitrigger, &unitrigger_logic );
}

// Namespace zm_factory
// Params 0
// Checksum 0x8b7d888b, Offset: 0x8b60
// Size: 0xa4
function unitrigger_logic()
{
    self endon( #"death" );
    
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
        
        self.stub.related_parent notify( #"trigger_activated", player );
    }
}

// Namespace zm_factory
// Params 0
// Checksum 0xd7124bcf, Offset: 0x8c10
// Size: 0x27c
function function_5d386c43()
{
    level flag::init( "snow_ee_completed" );
    level flag::init( "console_one_completed" );
    level flag::init( "console_two_completed" );
    level flag::init( "console_three_completed" );
    level flag::wait_till( "power_on" );
    level clientfield::set( "console_start", 1 );
    level flag::wait_till_all( array( "console_one_completed", "console_two_completed", "console_three_completed" ) );
    exploder::exploder( "teleporter_controller_main_light" );
    var_d3486562 = struct::get( "snowpile_console" );
    var_d3486562 create_unitrigger();
    var_d3486562 waittill( #"trigger_activated" );
    playsoundatposition( "zmb_snowmelt_button_press", var_d3486562.origin );
    zm_unitrigger::unregister_unitrigger( var_d3486562.s_unitrigger );
    level util::clientnotify( "sndSB" );
    level thread function_428d50ed();
    exploder::exploder( "fx_expl_robothead_laser" );
    wait 0.5;
    scene::play( "p7_fxanim_zm_factory_snowbank_bundle" );
    wait 0.5;
    exploder::stop_exploder( "fx_expl_robothead_laser" );
    mdl_clip = getent( "snowbank_clip", "targetname" );
    mdl_clip delete();
}

// Namespace zm_factory
// Params 0
// Checksum 0x497aad85, Offset: 0x8e98
// Size: 0x9c
function function_428d50ed()
{
    level flag::set( "snow_ee_completed" );
    exploder::stop_exploder( "teleporter_controller_main_light" );
    level clientfield::set( "console_blue", 0 );
    level clientfield::set( "console_green", 0 );
    level clientfield::set( "console_red", 0 );
}

// Namespace zm_factory
// Params 0
// Checksum 0x3a86a80e, Offset: 0x8f40
// Size: 0x1a6
function function_7cb67075()
{
    self endon( #"disconnect" );
    level endon( #"snow_ee_completed" );
    
    if ( level flag::exists( "snow_ee_completed" ) && level flag::get( "snow_ee_completed" ) )
    {
        return;
    }
    
    var_f1f15003 = getweapon( "cymbal_monkey" );
    var_230694a = getentarray( "teleporter_radius_trigger", "targetname" );
    
    while ( true )
    {
        self waittill( #"grenade_fire", e_grenade, w_weapon );
        
        if ( w_weapon == var_f1f15003 )
        {
            e_grenade waittill( #"stationary" );
            
            foreach ( trigger in var_230694a )
            {
                if ( e_grenade istouching( trigger ) )
                {
                    e_grenade thread function_ffa4d8ca( trigger );
                }
            }
        }
    }
}

// Namespace zm_factory
// Params 1
// Checksum 0x120f86db, Offset: 0x90f0
// Size: 0xf8
function function_ffa4d8ca( t_teleporter )
{
    if ( !isdefined( t_teleporter.var_634166a2 ) )
    {
        t_teleporter.var_634166a2 = [];
    }
    
    if ( !isdefined( t_teleporter.var_634166a2 ) )
    {
        t_teleporter.var_634166a2 = [];
    }
    else if ( !isarray( t_teleporter.var_634166a2 ) )
    {
        t_teleporter.var_634166a2 = array( t_teleporter.var_634166a2 );
    }
    
    t_teleporter.var_634166a2[ t_teleporter.var_634166a2.size ] = self;
    self waittill( #"death" );
    t_teleporter.var_634166a2 = array::remove_dead( t_teleporter.var_634166a2 );
}

// Namespace zm_factory
// Params 0
// Checksum 0x6b20a6bc, Offset: 0x91f0
// Size: 0xd6
function function_c7b37638()
{
    var_3c2393cb = getent( self.targetname, "script_noteworthy" );
    
    if ( isdefined( var_3c2393cb.var_634166a2 ) && var_3c2393cb.var_634166a2.size )
    {
        switch ( var_3c2393cb.script_noteworthy )
        {
            case "trigger_teleport_pad_0":
                level thread function_fdf0e661();
                break;
            case "trigger_teleport_pad_1":
                level thread function_8fe22c4f();
                break;
            default:
                level thread function_4bc4a18d();
                break;
        }
    }
}

// Namespace zm_factory
// Params 0
// Checksum 0xafed8b8d, Offset: 0x92d0
// Size: 0x84
function function_fdf0e661()
{
    if ( !level flag::get( "console_one_completed" ) && !level flag::get( "snow_ee_completed" ) )
    {
        level flag::set( "console_one_completed" );
        level clientfield::set( "console_blue", 1 );
    }
}

// Namespace zm_factory
// Params 0
// Checksum 0x720d3eaa, Offset: 0x9360
// Size: 0x84
function function_8fe22c4f()
{
    if ( !level flag::get( "console_two_completed" ) && !level flag::get( "snow_ee_completed" ) )
    {
        level flag::set( "console_two_completed" );
        level clientfield::set( "console_green", 1 );
    }
}

// Namespace zm_factory
// Params 0
// Checksum 0x9c3aadfd, Offset: 0x93f0
// Size: 0x84
function function_4bc4a18d()
{
    if ( !level flag::get( "console_three_completed" ) && !level flag::get( "snow_ee_completed" ) )
    {
        level flag::set( "console_three_completed" );
        level clientfield::set( "console_red", 1 );
    }
}

// Namespace zm_factory
// Params 0
// Checksum 0x441794c0, Offset: 0x9480
// Size: 0xc0
function function_e0f73644()
{
    if ( math::cointoss() )
    {
        level._custom_perks[ "specialty_staminup" ].perk_machine_power_override_thread = &function_384be1c4;
        level._custom_perks[ "specialty_deadshot" ].perk_machine_power_override_thread = &function_49e223a9;
        return;
    }
    
    level._custom_perks[ "specialty_deadshot" ].perk_machine_power_override_thread = &function_16d38a15;
    level._custom_perks[ "specialty_staminup" ].perk_machine_power_override_thread = &function_6000324c;
}

// Namespace zm_factory
// Params 0
// Checksum 0x83c2615c, Offset: 0x9548
// Size: 0x4c
function function_384be1c4()
{
    zm_perks::perk_machine_removal( "specialty_staminup" );
    level._custom_perks = array::remove_index( level._custom_perks, "specialty_staminup", 1 );
}

// Namespace zm_factory
// Params 0
// Checksum 0x690c6e42, Offset: 0x95a0
// Size: 0x4c
function function_16d38a15()
{
    zm_perks::perk_machine_removal( "specialty_deadshot" );
    level._custom_perks = array::remove_index( level._custom_perks, "specialty_deadshot", 1 );
}

// Namespace zm_factory
// Params 0
// Checksum 0x56428f27, Offset: 0x95f8
// Size: 0x7c
function function_49e223a9()
{
    level waittill( #"start_zombie_round_logic" );
    level thread function_8fbb6760( "specialty_deadshot" );
    level flag::wait_till( "snow_ee_completed" );
    level thread function_f8f36ff3( "specialty_deadshot", level._custom_perks[ "specialty_deadshot" ] );
}

// Namespace zm_factory
// Params 0
// Checksum 0x5c93a368, Offset: 0x9680
// Size: 0x7c
function function_6000324c()
{
    level waittill( #"start_zombie_round_logic" );
    level thread function_8fbb6760( "specialty_staminup" );
    level flag::wait_till( "snow_ee_completed" );
    level thread function_f8f36ff3( "specialty_staminup", level._custom_perks[ "specialty_staminup" ] );
}

// Namespace zm_factory
// Params 2
// Checksum 0x90d13789, Offset: 0x9708
// Size: 0x204
function function_f8f36ff3( str_key, s_custom_perk )
{
    machine = getentarray( s_custom_perk.radiant_machine_name, "targetname" );
    machine_triggers = getentarray( s_custom_perk.radiant_machine_name, "target" );
    
    for ( i = 0; i < machine.size ; i++ )
    {
        machine[ i ] setmodel( level.machine_assets[ str_key ].on_model );
        machine[ i ] vibrate( ( 0, -100, 0 ), 0.3, 0.4, 3 );
        machine[ i ] playsound( "zmb_perks_power_on" );
        machine[ i ] thread zm_perks::perk_fx( s_custom_perk.machine_light_effect );
        machine[ i ] thread zm_perks::play_loop_on_machine();
    }
    
    level notify( str_key + "_power_on" );
    array::thread_all( machine_triggers, &zm_perks::set_power_on, 1 );
    
    if ( isdefined( level.machine_assets[ str_key ].power_on_callback ) )
    {
        array::thread_all( machine, level.machine_assets[ str_key ].power_on_callback );
    }
}

// Namespace zm_factory
// Params 1
// Checksum 0x6d033321, Offset: 0x9918
// Size: 0x54
function function_8fbb6760( str_perk )
{
    t_perk = getent( str_perk, "script_noteworthy" );
    t_perk sethintstring( &"" );
}

// Namespace zm_factory
// Params 0
// Checksum 0x39450f1c, Offset: 0x9978
// Size: 0xc4
function flytrap_prize()
{
    var_3c100ea1 = struct::get( "flytrap_prize", "targetname" );
    var_6e1b8eeb = util::spawn_model( "wpn_t7_hero_annihilator_world", var_3c100ea1.origin, var_3c100ea1.angles );
    var_6e1b8eeb thread function_45814329( var_3c100ea1 );
    level thread function_86e1c543();
    level flag::clear( "flytrap" );
}

// Namespace zm_factory
// Params 1
// Checksum 0x57ddcc88, Offset: 0x9a48
// Size: 0x58
function function_45814329( var_3c100ea1 )
{
    self endon( #"death" );
    
    while ( true )
    {
        self rotateto( self.angles + ( 0, 180, 0 ), 2 );
        wait 1.9;
    }
}

// Namespace zm_factory
// Params 0
// Checksum 0xeea3bb2, Offset: 0x9aa8
// Size: 0x1a0
function function_86e1c543()
{
    var_957c9ba0 = getweapon( "hero_annihilator" );
    
    while ( true )
    {
        var_65af5e9c = trigger::wait_till( "flytrap_prize" );
        
        if ( !( isdefined( level.var_1cbe7756 ) && level.var_1cbe7756 ) )
        {
            foreach ( player in level.players )
            {
                level scoreevents::processscoreevent( "main_EE_quest_factory", player );
                player zm_stats::increment_global_stat( "DARKOPS_FACTORY_EE" );
                player zm_stats::increment_global_stat( "DARKOPS_FACTORY_SUPER_EE" );
            }
            
            level.var_1cbe7756 = 1;
        }
        
        player = var_65af5e9c.who;
        
        if ( !player hasweapon( var_957c9ba0 ) )
        {
            player function_5d3bb3fe( var_957c9ba0 );
        }
    }
}

// Namespace zm_factory
// Params 1
// Checksum 0xe1cf96dc, Offset: 0x9c50
// Size: 0x114
function function_5d3bb3fe( var_957c9ba0 )
{
    w_previous = self getcurrentweapon();
    self zm_weapons::weapon_give( var_957c9ba0 );
    self gadgetpowerset( 0, 99 );
    self switchtoweapon( var_957c9ba0 );
    self waittill( #"weapon_change_complete" );
    self setlowready( 1 );
    self switchtoweapon( w_previous );
    self util::waittill_any_timeout( 1, "weapon_change_complete" );
    self setlowready( 0 );
    self gadgetpowerset( 0, 100 );
}

// Namespace zm_factory
// Params 0
// Checksum 0x452f720a, Offset: 0x9d70
// Size: 0x28, Type: bool
function function_869d6f66()
{
    if ( !isdefined( self zm_bgb_anywhere_but_here::function_728dfe3() ) )
    {
        return false;
    }
    
    return true;
}

/#

    // Namespace zm_factory
    // Params 0
    // Checksum 0xeea3feb3, Offset: 0x9da0
    // Size: 0x9c, Type: dev
    function function_dabc4be1()
    {
        trig_control_panel = getent( "<dev string:x4a>", "<dev string:x5a>" );
        var_5dc8ad42 = getweapon( "<dev string:x65>" );
        trig_control_panel dodamage( 100, trig_control_panel.origin, undefined, undefined, undefined, "<dev string:x7e>", 0, var_5dc8ad42 );
    }

    // Namespace zm_factory
    // Params 1
    // Checksum 0x7ea28faa, Offset: 0x9e48
    // Size: 0x158, Type: dev
    function function_35372e3f( n_value )
    {
        if ( !level flag::exists( "<dev string:x8a>" ) || !level flag::exists( "<dev string:x98>" ) || !level flag::exists( "<dev string:xa6>" ) || !level flag::exists( "<dev string:xb4>" ) )
        {
            return;
        }
        
        var_ef99f97c = getentarray( "<dev string:xc1>", "<dev string:xd1>" );
        
        foreach ( trigger in var_ef99f97c )
        {
            trigger dodamage( 100, trigger.origin );
            wait 5;
        }
    }

    // Namespace zm_factory
    // Params 1
    // Checksum 0xccb86760, Offset: 0x9fa8
    // Size: 0xc2, Type: dev
    function function_7c3a679c( n_value )
    {
        var_957c9ba0 = getweapon( "<dev string:xe3>" );
        
        foreach ( player in level.activeplayers )
        {
            player function_5d3bb3fe( var_957c9ba0 );
        }
    }

    // Namespace zm_factory
    // Params 1
    // Checksum 0xb6a5fac3, Offset: 0xa078
    // Size: 0x9a, Type: dev
    function function_1196e483( n_value )
    {
        foreach ( player in level.players )
        {
            player ability_player::abilities_devgui_power_fill();
        }
    }

    // Namespace zm_factory
    // Params 1
    // Checksum 0xb7fb4be2, Offset: 0xa120
    // Size: 0x4c, Type: dev
    function function_75baeb50( n_value )
    {
        level flag::set( "<dev string:xf4>" );
        level clientfield::set( "<dev string:x10a>", 1 );
    }

    // Namespace zm_factory
    // Params 1
    // Checksum 0xc1454745, Offset: 0xa178
    // Size: 0x4c, Type: dev
    function function_5e65cea5( n_value )
    {
        level flag::set( "<dev string:x117>" );
        level clientfield::set( "<dev string:x12d>", 1 );
    }

    // Namespace zm_factory
    // Params 1
    // Checksum 0x47006314, Offset: 0xa1d0
    // Size: 0x4c, Type: dev
    function function_71fe81( n_value )
    {
        level flag::set( "<dev string:x13b>" );
        level clientfield::set( "<dev string:x153>", 1 );
    }

    // Namespace zm_factory
    // Params 0
    // Checksum 0x8e38f8ac, Offset: 0xa228
    // Size: 0xa0, Type: dev
    function function_dafe334()
    {
        level flag::set( "<dev string:xf4>" );
        level flag::set( "<dev string:x117>" );
        level flag::set( "<dev string:x13b>" );
        wait 0.2;
        var_d3486562 = struct::get( "<dev string:x15f>" );
        var_d3486562 notify( #"trigger_activated" );
    }

    // Namespace zm_factory
    // Params 0
    // Checksum 0x488ffe69, Offset: 0xa2d0
    // Size: 0x1cc, Type: dev
    function function_afea638c()
    {
        level thread setup_devgui_func( "<dev string:x170>", "<dev string:x196>", 1, &function_75baeb50 );
        level thread setup_devgui_func( "<dev string:x1a7>", "<dev string:x1ce>", 1, &function_5e65cea5 );
        level thread setup_devgui_func( "<dev string:x1e0>", "<dev string:x205>", 1, &function_71fe81 );
        level thread setup_devgui_func( "<dev string:x215>", "<dev string:x236>", 1, &function_dafe334 );
        level thread setup_devgui_func( "<dev string:x247>", "<dev string:x26d>", 1, &function_dabc4be1 );
        level thread setup_devgui_func( "<dev string:x27e>", "<dev string:x2a2>", 1, &function_35372e3f );
        level thread setup_devgui_func( "<dev string:x2b5>", "<dev string:x2de>", 1, &function_7c3a679c );
        level thread setup_devgui_func( "<dev string:x2f5>", "<dev string:x324>", 1, &function_1196e483 );
    }

    // Namespace zm_factory
    // Params 5
    // Checksum 0xece2dd4b, Offset: 0xa4a8
    // Size: 0x120, Type: dev
    function setup_devgui_func( str_devgui_path, str_dvar, n_value, func, n_base_value )
    {
        if ( !isdefined( n_base_value ) )
        {
            n_base_value = -1;
        }
        
        setdvar( str_dvar, n_base_value );
        adddebugcommand( "<dev string:x340>" + str_devgui_path + "<dev string:x34d>" + str_dvar + "<dev string:x351>" + n_value + "<dev string:x353>" );
        
        while ( true )
        {
            n_dvar = getdvarint( str_dvar );
            
            if ( n_dvar > n_base_value )
            {
                [[ func ]]( n_dvar );
                setdvar( str_dvar, n_base_value );
            }
            
            util::wait_network_frame();
        }
    }

#/
