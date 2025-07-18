#using scripts/codescripts/struct;
#using scripts/shared/aat_shared;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;

#namespace zm_ai_monkey;

// Namespace zm_ai_monkey
// Params 0, eflags: 0x2
// Checksum 0xd94cca93, Offset: 0x12f0
// Size: 0x254
function autoexec init()
{
    initmonkeybehaviorsandasm();
    spawner::add_archetype_spawn_function( "monkey", &archetypemonkeyblackboardinit );
    spawner::add_archetype_spawn_function( "monkey", &monkeyspawnsetup );
    animationstatenetwork::registernotetrackhandlerfunction( "monkey_melee", &monkeynotetrackmeleefire );
    animationstatenetwork::registernotetrackhandlerfunction( "monkey_groundpound", &monkeynotetrackgroundpound );
    animationstatenetwork::registernotetrackhandlerfunction( "grenade_pickup", &function_fcdc0829 );
    level thread aat::register_immunity( "zm_aat_blast_furnace", "monkey", 1, 1, 1 );
    level thread aat::register_immunity( "zm_aat_dead_wire", "monkey", 1, 1, 1 );
    level thread aat::register_immunity( "zm_aat_fire_works", "monkey", 1, 1, 1 );
    level thread aat::register_immunity( "zm_aat_thunder_wall", "monkey", 1, 1, 1 );
    level thread aat::register_immunity( "zm_aat_turned", "monkey", 1, 1, 1 );
    clientfield::register( "actor", "monkey_eye_glow", 21000, 1, "int" );
    level.var_45abf882 = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        level.var_45abf882[ i ] = "rtrg_ai_zm_dlc5_monkey_thundergun_roll_0" + i + 1;
    }
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0xef0ffd2f, Offset: 0x1550
// Size: 0x5c
function monkeynotetrackmeleefire( entity )
{
    entity melee();
    
    /#
        record3dtext( "<dev string:x28>", self.origin, ( 1, 0, 0 ), "<dev string:x2e>", entity );
    #/
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0x6cdf5a55, Offset: 0x15b8
// Size: 0x4d6
function monkeynotetrackgroundpound( entity )
{
    playfxontag( level._effect[ "monkey_groundhit" ], entity, "tag_origin" );
    entity playsound( "zmb_monkey_groundpound" );
    origin = entity.origin + ( 0, 0, 40 );
    zombies = array::get_all_closest( origin, getaispeciesarray( level.zombie_team, "all" ), undefined, undefined, level.monkey_zombie_groundhit_damage_radius );
    
    if ( isdefined( zombies ) )
    {
        for ( i = 0; i < zombies.size ; i++ )
        {
            if ( !isdefined( zombies[ i ] ) )
            {
                continue;
            }
            
            if ( zm_utility::is_magic_bullet_shield_enabled( zombies[ i ] ) )
            {
                continue;
            }
            
            test_origin = zombies[ i ] geteye();
            
            if ( !bullettracepassed( origin, test_origin, 0, undefined ) )
            {
                continue;
            }
            
            if ( zombies[ i ] == entity )
            {
                continue;
            }
            
            if ( zombies[ i ].animname == "monkey_zombie" )
            {
                continue;
            }
            
            zombies[ i ] zombie_utility::gib_random_parts();
            gibserverutils::annihilate( zombies[ i ] );
            zombies[ i ] dodamage( zombies[ i ].health * 10, entity.origin, entity );
        }
    }
    
    players = getplayers();
    affected_players = [];
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( !zombie_utility::is_player_valid( players[ i ] ) )
        {
            continue;
        }
        
        test_origin = players[ i ] geteye();
        
        if ( distancesquared( origin, test_origin ) > level.monkey_zombie_groundhit_damage_radius * level.monkey_zombie_groundhit_damage_radius )
        {
            continue;
        }
        
        if ( !bullettracepassed( origin, test_origin, 0, undefined ) )
        {
            continue;
        }
        
        if ( !isdefined( affected_players ) )
        {
            affected_players = [];
        }
        else if ( !isarray( affected_players ) )
        {
            affected_players = array( affected_players );
        }
        
        affected_players[ affected_players.size ] = players[ i ];
    }
    
    entity.chest_beat = 0;
    
    for ( i = 0; i < affected_players.size ; i++ )
    {
        entity.chest_beat = 1;
        player = affected_players[ i ];
        
        if ( player isonground() )
        {
            damage = player.maxhealth * 0.5;
            player dodamage( damage, entity.origin, entity );
        }
    }
    
    if ( isdefined( entity.force_detonate ) )
    {
        for ( i = 0; i < entity.force_detonate.size ; i++ )
        {
            if ( isdefined( entity.force_detonate[ i ] ) )
            {
                entity.force_detonate[ i ] detonate( undefined );
            }
        }
    }
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0x7aed13dd, Offset: 0x1a98
// Size: 0x194
function function_fcdc0829( entity )
{
    target = self.monkey_thrower;
    throw_angle = randomintrange( 20, 30 );
    dir = vectortoangles( target.origin - entity.origin );
    dir = ( dir[ 0 ] - throw_angle, dir[ 1 ], dir[ 2 ] );
    dir = anglestoforward( dir );
    velocity = dir * 550;
    fuse = randomfloatrange( 1, 2 );
    hand_pos = entity gettagorigin( "J_Thumb_RI_1" );
    
    if ( !isdefined( hand_pos ) )
    {
        hand_pos = entity.origin;
    }
    
    grenade_type = target zm_utility::get_player_lethal_grenade();
    entity magicgrenadetype( grenade_type, hand_pos, velocity, fuse );
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xce00a650, Offset: 0x1c38
// Size: 0xe4
function archetypemonkeyblackboardinit()
{
    blackboard::createblackboardforentity( self );
    self aiutility::registerutilityblackboardattributes();
    ai::createinterfaceforentity( self );
    blackboard::registerblackboardattribute( self, "_locomotion_speed", "locomotion_speed_walk", &zombiebehavior::bb_getlocomotionspeedtype );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x35>" );
        #/
    }
    
    self.___archetypeonanimscriptedcallback = &archetypemonkeyonanimscriptedcallback;
    
    /#
        self finalizetrackedblackboardattributes();
    #/
}

// Namespace zm_ai_monkey
// Params 0, eflags: 0x4
// Checksum 0x2f63bb4c, Offset: 0x1d28
// Size: 0x34
function private monkeyspawnsetup()
{
    self setpitchorient();
    self monkey_prespawn();
}

// Namespace zm_ai_monkey
// Params 1, eflags: 0x4
// Checksum 0xd18ec506, Offset: 0x1d68
// Size: 0x34
function private archetypemonkeyonanimscriptedcallback( entity )
{
    entity.__blackboard = undefined;
    entity archetypemonkeyblackboardinit();
}

// Namespace zm_ai_monkey
// Params 0, eflags: 0x4
// Checksum 0x667ee8ce, Offset: 0x1da8
// Size: 0x144
function private initmonkeybehaviorsandasm()
{
    behaviortreenetworkutility::registerbehaviortreescriptapi( "monkeyTargetService", &monkeytargetservice );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "monkeyShouldGroundHit", &monkeyshouldgroundhit );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "monkeyShouldThrowBackRun", &monkeyshouldthrowbackrun );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "monkeyShouldThrowBackStill", &monkeyshouldthrowbackstill );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "monkeyGroundHitStart", &monkeygroundhitstart );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "monkeyGroundHitTerminate", &monkeygroundhitterminate );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "monkeyThrowBackTerminate", &monkeythrowbackterminate );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "monkeyGrenadeTauntTerminate", &monkeygrenadetauntterminate );
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0xddf963dd, Offset: 0x1ef8
// Size: 0x330
function monkeytargetservice( entity )
{
    if ( isdefined( entity.ignoreall ) && entity.ignoreall )
    {
        return 0;
    }
    
    if ( !( isdefined( entity.following_player ) && entity.following_player ) )
    {
        return 0;
    }
    
    if ( isdefined( entity.destroy_octobomb ) )
    {
        return 0;
    }
    
    player = zm_utility::get_closest_valid_player( self.origin, self.ignore_player );
    entity.favoriteenemy = player;
    
    if ( isdefined( entity.pack ) && isdefined( entity.pack.enemy ) )
    {
        if ( !isdefined( entity.favoriteenemy ) || entity.favoriteenemy != entity.pack.enemy )
        {
            entity.favoriteenemy = entity.pack.enemy;
        }
    }
    
    if ( !isdefined( player ) || player isnotarget() )
    {
        if ( isdefined( entity.ignore_player ) )
        {
            if ( isdefined( level._should_skip_ignore_player_logic ) && [[ level._should_skip_ignore_player_logic ]]() )
            {
                return;
            }
            
            entity.ignore_player = [];
        }
        
        if ( isdefined( level.no_target_override ) )
        {
            [[ level.no_target_override ]]( entity );
        }
        else
        {
            entity setgoal( entity.origin );
        }
        
        return 0;
    }
    
    if ( isdefined( level.enemy_location_override_func ) )
    {
        enemy_ground_pos = [[ level.enemy_location_override_func ]]( entity, player );
        
        if ( isdefined( enemy_ground_pos ) )
        {
            entity setgoal( enemy_ground_pos );
            return 1;
        }
    }
    
    targetpos = getclosestpointonnavmesh( entity.favoriteenemy.origin, 15, 15 );
    
    if ( isdefined( targetpos ) )
    {
        entity setgoal( targetpos );
        return 1;
    }
    
    if ( isdefined( entity.favoriteenemy.last_valid_position ) )
    {
        entity setgoal( entity.favoriteenemy.last_valid_position );
        return 1;
    }
    
    entity setgoal( entity.origin );
    return 0;
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0x3c913bc2, Offset: 0x2230
// Size: 0x3a, Type: bool
function monkeyshouldgroundhit( entity )
{
    if ( isdefined( entity.var_aa9937 ) && entity.var_aa9937 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0x6bb0d8b3, Offset: 0x2278
// Size: 0x38
function monkeygroundhitstart( entity )
{
    self monkey_zombie_set_state( "ground_pound" );
    self.ground_hit = 1;
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0x295d1048, Offset: 0x22b8
// Size: 0x54
function monkeygroundhitterminate( entity )
{
    self.ground_hit = 0;
    self monkey_zombie_set_state( "ground_pound_done" );
    self.nextgroundhit = gettime() + level.monkey_ground_attack_delay;
    self.var_aa9937 = 0;
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0x7d60200e, Offset: 0x2318
// Size: 0x3a, Type: bool
function monkeyshouldthrowbackrun( entity )
{
    if ( isdefined( entity.var_cf51d24 ) && entity.var_cf51d24 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0xf10193f6, Offset: 0x2360
// Size: 0x3a, Type: bool
function monkeyshouldthrowbackstill( entity )
{
    if ( isdefined( entity.var_6602f0c5 ) && entity.var_6602f0c5 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0x4aed68e4, Offset: 0x23a8
// Size: 0x2c
function monkeythrowbackterminate( entity )
{
    entity.var_cf51d24 = 0;
    entity.var_6602f0c5 = 0;
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0x565320e, Offset: 0x23e0
// Size: 0x1c
function monkeygrenadetauntterminate( entity )
{
    entity notify( #"throw_done" );
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x53cab70f, Offset: 0x2408
// Size: 0x37c
function function_4c8046f8()
{
    function_dd79f3a8();
    level._effect[ "monkey_groundhit" ] = "dlc5/zmhd/fx_zmb_monkey_ground_hit";
    level._effect[ "monkey_death" ] = "dlc5/cosmo/fx_zmb_monkey_death";
    level._effect[ "monkey_spawn" ] = "dlc5/cosmo/fx_zombie_ape_spawn_dust";
    
    if ( !isdefined( level.monkey_zombie_spawn_heuristic ) )
    {
        level.monkey_zombie_spawn_heuristic = &monkey_zombie_default_spawn_heuristic;
    }
    
    if ( !isdefined( level.monkey_zombie_enter_level ) )
    {
        level.monkey_zombie_enter_level = &monkey_zombie_default_enter_level;
    }
    
    level.num_monkey_zombies = 0;
    level.monkey_zombie_spawners = getentarray( "monkey_zombie_spawner", "targetname" );
    
    if ( !isdefined( level.max_monkey_zombies ) )
    {
        level.max_monkey_zombies = 1;
    }
    
    if ( !isdefined( level.monkey_zombie_min_health ) )
    {
        level.monkey_zombie_min_health = 150;
    }
    
    if ( !isdefined( level.monkey_zombie_groundhit_damage ) )
    {
        level.monkey_zombie_groundhit_damage = 100;
    }
    
    if ( !isdefined( level.monkey_zombie_groundhit_trigger_radius ) )
    {
        level.monkey_zombie_groundhit_trigger_radius = 96;
    }
    
    if ( !isdefined( level.monkey_zombie_groundhit_damage_radius ) )
    {
        level.monkey_zombie_groundhit_damage_radius = 280;
    }
    
    if ( !isdefined( level.monkey_ground_attack_delay ) )
    {
        level.monkey_ground_attack_delay = 5000;
    }
    
    if ( !isdefined( level.monkeys_per_pack ) )
    {
        level.monkeys_per_pack = 3;
    }
    
    if ( !isdefined( level.monkey_pack_max ) )
    {
        level.monkey_pack_max = 1;
    }
    
    if ( !isdefined( level.monkey_pack ) )
    {
        level.monkey_pack = [];
    }
    
    if ( !isdefined( level.machine_health_max ) )
    {
        level.machine_health_max = 100;
    }
    
    if ( !isdefined( level.machine_damage_min ) )
    {
        level.machine_damage_min = 1;
    }
    
    if ( !isdefined( level.machine_damage_max ) )
    {
        level.machine_damage_max = 8;
    }
    
    if ( !isdefined( level.ground_hit_delay ) )
    {
        level.ground_hit_delay = randomfloatrange( 4.5, 6.5 ) * 1000;
    }
    
    level.monkey_death = 0;
    level.monkey_death_total = 0;
    level.monkey_packs_killed = 0;
    level.monkey_encounters = 1;
    level.monkey_intermission = 0;
    level flag::init( "monkey_round" );
    level flag::init( "last_monkey_down" );
    level flag::init( "monkey_pack_down" );
    level flag::init( "perk_bought" );
    level flag::init( "monkey_free_perk" );
    level thread monkey_round_tracker();
    level.perk_lost_func = &monkey_perk_lost;
    level.perk_bought_func = &monkey_perk_bought;
    level.revive_solo_fx_func = &monkey_revive_solo_fx;
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xe8943b49, Offset: 0x2790
// Size: 0x2de
function monkey_prespawn()
{
    self.animname = "monkey_zombie";
    self pushactors( 1 );
    self.b_ignore_cleanup = 1;
    self.ignorelocationaldamage = 1;
    self.ignoreall = 1;
    self.allowdeath = 1;
    self.is_zombie = 1;
    self.missinglegs = 0;
    self allowedstances( "stand" );
    self.gibbed = 0;
    self.head_gibbed = 0;
    self.no_widows_wine = 1;
    self.disablearrivals = 1;
    self.disableexits = 1;
    self.grenadeawareness = 0;
    self.badplaceawareness = 0;
    self.ignoresuppression = 1;
    self.suppressionthreshold = 1;
    self.nododgemove = 1;
    self.dontshootwhilemoving = 1;
    self.pathenemylookahead = 0;
    self.badplaceawareness = 0;
    self.chatinitialized = 0;
    self.a.disablepain = 1;
    self zm_utility::disable_react();
    self.freezegun_damage = 0;
    self thread zm_spawner::zombie_damage_failsafe();
    self.flame_damage_time = 0;
    self.meleedamage = 40;
    self.no_powerups = 1;
    self.no_gib = 1;
    self.custom_damage_func = &monkey_custom_damage;
    self.chest_beat = 0;
    self.machine_damage = level.machine_damage_min;
    self.dropped = 1;
    self allowpitchangle( 1 );
    self.thundergun_fling_func = &monkey_fling;
    self monkey_zombie_set_state( "default" );
    self.nochangeduringmelee = 1;
    
    if ( isdefined( level.monkey_prespawn ) )
    {
        self [[ level.monkey_prespawn ]]();
    }
    
    self.zombie_move_speed = "walk";
    self zombie_utility::set_zombie_run_cycle();
    self thread zm_spawner::play_ambient_zombie_vocals();
    self thread zm_audio::zmbaivox_notifyconvert();
    self.ground_hit_time = gettime();
    self notify( #"zombie_init_done" );
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x2bf7727b, Offset: 0x2a78
// Size: 0x4b0
function function_dd79f3a8()
{
    level.monkey_perk_attack_anims[ 0 ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_front";
    level.monkey_perk_attack_anims[ 1 ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left";
    level.monkey_perk_attack_anims[ 2 ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_top";
    level.monkey_perk_attack_anims[ 3 ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right";
    level.monkey_perk_attack_anims[ 4 ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_top";
    level.monkey_perk_attack_anims[ "specialty_armorvest" ][ "front" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_front_jugg";
    level.monkey_perk_attack_anims[ "specialty_armorvest" ][ "left" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_jugg";
    level.monkey_perk_attack_anims[ "specialty_armorvest" ][ "left_top" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_top_jugg";
    level.monkey_perk_attack_anims[ "specialty_armorvest" ][ "right" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_jugg";
    level.monkey_perk_attack_anims[ "specialty_armorvest" ][ "right_top" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_top_jugg";
    level.monkey_perk_attack_anims[ "specialty_staminup" ][ "front" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_front_marathon";
    level.monkey_perk_attack_anims[ "specialty_staminup" ][ "left" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_marathon";
    level.monkey_perk_attack_anims[ "specialty_staminup" ][ "left_top" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_top_marathon";
    level.monkey_perk_attack_anims[ "specialty_staminup" ][ "right" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_marathon";
    level.monkey_perk_attack_anims[ "specialty_staminup" ][ "right_top" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_top_marathon";
    level.monkey_perk_attack_anims[ "specialty_quickrevive" ][ "front" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_front_revive";
    level.monkey_perk_attack_anims[ "specialty_quickrevive" ][ "left" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_revive";
    level.monkey_perk_attack_anims[ "specialty_quickrevive" ][ "left_top" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_top_revive";
    level.monkey_perk_attack_anims[ "specialty_quickrevive" ][ "right" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_revive";
    level.monkey_perk_attack_anims[ "specialty_quickrevive" ][ "right_top" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_top_revive";
    level.monkey_perk_attack_anims[ "specialty_fastreload" ][ "front" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_front_speed";
    level.monkey_perk_attack_anims[ "specialty_fastreload" ][ "left" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_speed";
    level.monkey_perk_attack_anims[ "specialty_fastreload" ][ "left_top" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_top_speed";
    level.monkey_perk_attack_anims[ "specialty_fastreload" ][ "right" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_speed";
    level.monkey_perk_attack_anims[ "specialty_fastreload" ][ "right_top" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_top_speed";
    level.monkey_perk_attack_anims[ "specialty_additionalprimaryweapon" ][ "front" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_front_mulekick";
    level.monkey_perk_attack_anims[ "specialty_additionalprimaryweapon" ][ "left" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_mulekick";
    level.monkey_perk_attack_anims[ "specialty_additionalprimaryweapon" ][ "left_top" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_top_mulekick";
    level.monkey_perk_attack_anims[ "specialty_additionalprimaryweapon" ][ "right" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_mulekick";
    level.monkey_perk_attack_anims[ "specialty_additionalprimaryweapon" ][ "right_top" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_top_mulekick";
    level.monkey_perk_attack_anims[ "specialty_widowswine" ][ "front" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_front_widows_vine";
    level.monkey_perk_attack_anims[ "specialty_widowswine" ][ "left" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_widows_vine";
    level.monkey_perk_attack_anims[ "specialty_widowswine" ][ "left_top" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_left_top_widows_vine";
    level.monkey_perk_attack_anims[ "specialty_widowswine" ][ "right" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_widows_vine";
    level.monkey_perk_attack_anims[ "specialty_widowswine" ][ "right_top" ] = "rtrg_ai_zm_dlc5_monkey_attack_perks_right_top_widows_vine";
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0xfd8eaa10, Offset: 0x2f30
// Size: 0x1e8
function monkey_zombie_spawn( pack )
{
    self.script_moveoverride = 1;
    
    if ( !isdefined( level.num_monkey_zombies ) )
    {
        level.num_monkey_zombies = 0;
    }
    
    level.num_monkey_zombies++;
    monkey_zombie = zombie_utility::spawn_zombie( self );
    self.count = 666;
    self.last_spawn_time = gettime();
    
    if ( isdefined( monkey_zombie ) )
    {
        monkey_zombie.script_noteworthy = self.script_noteworthy;
        monkey_zombie.targetname = self.targetname;
        monkey_zombie.target = self.target;
        monkey_zombie.deathfunction = &monkey_zombie_die;
        monkey_zombie.animname = "monkey_zombie";
        monkey_zombie.pack = pack;
        monkey_zombie.perk = pack.perk;
        monkey_zombie.ground_hit_time = pack.ground_hit_time;
        monkey_zombie.spawn_origin = self.origin;
        monkey_zombie.spawn_angles = self.angles;
        monkey_zombie clientfield::set( "monkey_eye_glow", 1 );
        monkey_zombie thread watch_for_death();
        monkey_zombie thread monkey_zombie_think();
        monkey_zombie.zombie_think_done = 1;
    }
    else
    {
        level.num_monkey_zombies--;
    }
    
    monkey_zombie thread wait_for_damage();
    return monkey_zombie;
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x3782236b, Offset: 0x3120
// Size: 0xd0
function wait_for_damage()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", n_amount, e_attacker, v_direction, v_point, str_type );
        
        if ( e_attacker zm_utility::is_player() )
        {
            e_attacker zm_score::player_add_points( "damage" );
            e_attacker.use_weapon_type = str_type;
            self thread zm_powerups::check_for_instakill( e_attacker, str_type, v_point );
        }
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x99ec1590, Offset: 0x31f8
// Size: 0x4
function watch_for_death()
{
    
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xe03ecb8a, Offset: 0x3208
// Size: 0x140
function monkey_round_spawning()
{
    level endon( #"intermission" );
    level endon( #"end_of_round" );
    level endon( #"restart_round" );
    
    /#
        level endon( #"kill_round" );
        
        if ( getdvarint( "<dev string:x47>" ) == 2 || getdvarint( "<dev string:x47>" ) >= 4 )
        {
            return;
        }
    #/
    
    if ( level.intermission )
    {
        return;
    }
    
    level.monkey_intermission = 1;
    level thread monkey_round_aftermath();
    pack_idx = 0;
    
    while ( true )
    {
        level monkey_pack_spawn();
        pack_idx++;
        
        if ( pack_idx >= level.monkey_pack_max )
        {
            break;
        }
        
        time = randomfloatrange( 3.2, 4.4 );
        wait time;
        util::wait_network_frame();
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x4ee1abb9, Offset: 0x3350
// Size: 0x7c
function monkey_setup_packs()
{
    level.monkey_packs_killed = 0;
    players = getplayers();
    
    if ( players.size > level.monkey_encounters )
    {
        level.monkey_pack_max = players.size + level.monkey_encounters;
    }
    else
    {
        level.monkey_pack_max = players.size * 2;
    }
    
    level.monkey_encounters++;
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xdd830aec, Offset: 0x33d8
// Size: 0xe4
function monkey_setup_health()
{
    switch ( level.monkey_encounters )
    {
        case 1:
            level.monkey_zombie_health = level.zombie_health * 0.25;
            break;
        case 2:
            level.monkey_zombie_health = level.zombie_health * 0.5;
            break;
        case 3:
            level.monkey_zombie_health = level.zombie_health * 0.75;
            break;
        default:
            level.monkey_zombie_health = level.zombie_health;
            break;
    }
    
    if ( level.zombie_health > 1600 )
    {
        level.zombie_health = 1600;
    }
    
    monkey_print( "monkey health = " + level.monkey_zombie_health );
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x80f070d1, Offset: 0x34c8
// Size: 0xb8
function monkey_setup_spawners()
{
    level.current_monkey_spawners = [];
    
    for ( i = 0; i < level.monkey_zombie_spawners.size ; i++ )
    {
        if ( level.zones[ level.monkey_zombie_spawners[ i ].script_noteworthy ].is_enabled )
        {
            level.current_monkey_spawners[ level.current_monkey_spawners.size ] = level.monkey_zombie_spawners[ i ];
        }
    }
    
    level.current_monkey_spawners = randomize_array( level.current_monkey_spawners );
    level.monkey_spawner_idx = 0;
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0x94f409ca, Offset: 0x3588
// Size: 0x9c
function randomize_array( array )
{
    for ( i = 0; i < array.size ; i++ )
    {
        j = randomint( array.size );
        temp = array[ i ];
        array[ i ] = array[ j ];
        array[ j ] = temp;
    }
    
    return array;
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xfc4f15, Offset: 0x3630
// Size: 0x60
function monkey_get_next_spawner()
{
    spawner = level.current_monkey_spawners[ level.monkey_spawner_idx ];
    
    if ( isdefined( spawner ) )
    {
        level.monkey_spawner_idx++;
        
        if ( level.monkey_spawner_idx == level.current_monkey_spawners.size )
        {
            level monkey_setup_spawners();
        }
    }
    
    return spawner;
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xb845551, Offset: 0x3698
// Size: 0xac
function monkey_get_available_spawners()
{
    spawners = [];
    
    for ( i = 0; i < level.monkey_zombie_spawners.size ; i++ )
    {
        if ( level.zones[ level.monkey_zombie_spawners[ i ].script_noteworthy ].is_enabled )
        {
            spawners[ spawners.size ] = level.monkey_zombie_spawners[ i ];
        }
    }
    
    spawners = array::randomize( spawners );
    return spawners;
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x66f411a, Offset: 0x3750
// Size: 0x1e8
function monkey_pack_man_setup_perks()
{
    level.monkey_perks = [];
    vending_triggers = function_5b9c3e11();
    
    for ( i = 0; i < vending_triggers.size ; i++ )
    {
        if ( vending_triggers[ i ].targeted )
        {
            continue;
        }
        
        players = getplayers();
        
        for ( j = 0; j < players.size ; j++ )
        {
            perk = vending_triggers[ i ].script_noteworthy;
            org = vending_triggers[ i ].origin;
            
            if ( isdefined( vending_triggers[ i ].realorigin ) )
            {
                org = vending_triggers[ i ].realorigin;
            }
            
            zone_enabled = zm_zonemgr::get_zone_from_position( org, 0 );
            
            if ( players[ j ] hasperk( perk ) && isdefined( zone_enabled ) )
            {
                level.monkey_perks[ level.monkey_perks.size ] = vending_triggers[ i ];
                break;
            }
        }
    }
    
    if ( level.monkey_perks.size > 1 )
    {
        level.monkey_perks = array::randomize( level.monkey_perks );
    }
    
    level.monkey_perk_idx = 0;
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xcc2cab68, Offset: 0x3940
// Size: 0xee
function function_5b9c3e11()
{
    vending_machines = [];
    var_560b7d8d = getentarray( "zombie_vending", "targetname" );
    
    for ( i = 0; i < var_560b7d8d.size ; i++ )
    {
        if ( var_560b7d8d[ i ].script_noteworthy != "specialty_weapupgrade" )
        {
            if ( !isdefined( vending_machines ) )
            {
                vending_machines = [];
            }
            else if ( !isarray( vending_machines ) )
            {
                vending_machines = array( vending_machines );
            }
            
            vending_machines[ vending_machines.size ] = var_560b7d8d[ i ];
        }
    }
    
    return vending_machines;
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xd1bec8aa, Offset: 0x3a38
// Size: 0x90
function monkey_pack_man_get_next_perk()
{
    if ( level.monkey_perks.size == 0 )
    {
        self.perk = undefined;
        return;
    }
    
    perk = level.monkey_perks[ level.monkey_perk_idx ];
    perk.targeted = 1;
    level.monkey_perk_idx++;
    
    if ( level.monkey_perk_idx == level.monkey_perks.size )
    {
        level monkey_pack_man_setup_perks();
    }
    
    self.perk = perk;
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xc20737e2, Offset: 0x3ad0
// Size: 0x94
function monkey_pack_spawn()
{
    monkey_print( "spawning pack" );
    pack = spawnstruct();
    pack.monkeys = [];
    pack.attack = [];
    pack.target = undefined;
    level.monkey_pack[ level.monkey_pack.size ] = pack;
    pack thread monkey_pack_think();
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x5af246f7, Offset: 0x3b70
// Size: 0x174
function monkey_pack_think()
{
    self.ground_hit_time = gettime();
    self monkey_pack_man_get_next_perk();
    self monkey_pack_set_machine();
    self monkey_pack_choose_enemy();
    self.spawning_done = 0;
    
    for ( i = 0; i < level.monkeys_per_pack ; i++ )
    {
        spawner = monkey_get_next_spawner();
        
        if ( isdefined( spawner ) )
        {
            monkey = spawner monkey_zombie_spawn( self );
            self.monkeys[ self.monkeys.size ] = monkey;
        }
        
        if ( i < level.monkeys_per_pack - 1 )
        {
            time = randomfloatrange( 2.2, 4.4 );
            wait time;
        }
    }
    
    self.spawning_done = 1;
    self thread monkey_pack_update_enemy();
    self thread monkey_pack_update_perk();
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xcad38b14, Offset: 0x3cf0
// Size: 0x168
function monkey_pack_update_perk()
{
    while ( true )
    {
        if ( !isdefined( self.perk ) )
        {
            break;
        }
        
        if ( self.machine.monkey_health == 0 )
        {
            monkey_print( "pack destroyed " + self.machine.targetname );
            self monkey_pack_take_perk();
            util::wait_network_frame();
            self monkey_pack_clear_perk_pos();
            self monkey_pack_man_get_next_perk();
            self monkey_pack_set_machine();
            
            for ( i = 0; i < self.monkeys.size ; i++ )
            {
                if ( !self.monkeys[ i ].charge_player )
                {
                    self.monkeys[ i ].perk = self.perk;
                    self.monkeys[ i ] notify( #"stop_perk_attack" );
                }
            }
        }
        
        util::wait_network_frame();
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x71597bd5, Offset: 0x3e60
// Size: 0x138
function monkey_pack_next_perk()
{
    perk = undefined;
    perk_idx = -1;
    num_perks = 0;
    keys = getarraykeys( level.monkey_perks );
    
    for ( i = 0; i < keys.size ; i++ )
    {
        if ( level.monkey_perks[ keys[ i ] ] > num_perks )
        {
            num_perks = level.monkey_perks[ keys[ i ] ];
            perk_idx = i;
        }
    }
    
    if ( perk_idx >= 0 )
    {
        perk = keys[ perk_idx ];
    }
    
    if ( isdefined( perk ) )
    {
        monkey_print( "perk is " + perk );
    }
    else
    {
        monkey_print( "no more perks" );
    }
    
    self.perk = perk;
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x6591d3fd, Offset: 0x3fa0
// Size: 0xae
function monkey_pack_set_machine()
{
    self.machine = undefined;
    
    if ( !isdefined( self.perk ) )
    {
        return;
    }
    
    targets = getentarray( self.perk.target, "targetname" );
    
    for ( j = 0; j < targets.size ; j++ )
    {
        if ( targets[ j ].classname == "script_model" )
        {
            self.machine = targets[ j ];
        }
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x25b64583, Offset: 0x4058
// Size: 0xe4
function monkey_pack_choose_enemy()
{
    monkey_enemy = [];
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( !zombie_utility::is_player_valid( players[ i ] ) )
        {
            continue;
        }
        
        monkey_enemy[ monkey_enemy.size ] = players[ i ];
    }
    
    monkey_enemy = array::randomize( monkey_enemy );
    
    if ( monkey_enemy.size > 0 )
    {
        self.enemy = monkey_enemy[ 0 ];
        return;
    }
    
    self.enemy = players[ 0 ];
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x21ee093e, Offset: 0x4148
// Size: 0x24c
function monkey_pack_update_enemy()
{
    while ( self.monkeys.size > 0 )
    {
        players = getplayers();
        total_dist = 1000000;
        player_idx = 0;
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( !zombie_utility::is_player_valid( players[ i ] ) )
            {
                continue;
            }
            
            dist = 0;
            
            for ( j = 0; j < self.monkeys.size ; j++ )
            {
                if ( !isdefined( self.monkeys[ j ] ) )
                {
                    continue;
                }
                
                dist += distance( players[ i ].origin, self.monkeys[ j ].origin );
            }
            
            if ( dist < total_dist )
            {
                total_dist = dist;
                player_idx = i;
            }
            
            if ( isdefined( players[ i ].b_is_designated_target ) && players[ i ].b_is_designated_target )
            {
                player_idx = i;
            }
        }
        
        if ( isdefined( players ) )
        {
            if ( isdefined( self.enemy ) )
            {
                if ( self.enemy != players[ player_idx ] )
                {
                    monkey_print( "pack enemy is " + self.enemy.name );
                }
            }
            else
            {
                monkey_print( "pack enemy is " + players[ player_idx ].name );
            }
            
            self.enemy = players[ player_idx ];
        }
        
        wait 0.2;
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x8a647d5f, Offset: 0x43a0
// Size: 0x1c, Type: bool
function monkey_zombie_check_ground_hit()
{
    if ( gettime() >= self.ground_hit_time )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0x15e5fcab, Offset: 0x43c8
// Size: 0x22c
function monkey_pack_update_ground_hit( hitter )
{
    self.ground_hit_time = gettime() + level.ground_hit_delay;
    level.ground_hit_delay = randomfloatrange( 4.5, 6.5 ) * 1000;
    
    for ( i = 0; i < self.monkeys.size ; i++ )
    {
        if ( isdefined( self.monkeys[ i ] ) )
        {
            self.monkeys[ i ].ground_hit_time = self.ground_hit_time;
        }
    }
    
    groundpound_reset = level.monkey_zombie_groundhit_trigger_radius * 2;
    groundpound_reset_sq = groundpound_reset * groundpound_reset;
    
    for ( i = 0; i < level.monkey_pack.size ; i++ )
    {
        pack = level.monkey_pack[ i ];
        
        if ( self == pack )
        {
            continue;
        }
        
        for ( j = 0; j < pack.monkeys.size ; j++ )
        {
            monkey = pack.monkeys[ j ];
            
            if ( !isdefined( monkey ) )
            {
                continue;
            }
            
            if ( hitter == monkey )
            {
                continue;
            }
            
            dist_sq = distancesquared( hitter.origin, monkey.origin );
            
            if ( dist_sq <= groundpound_reset_sq )
            {
                monkey.ground_hit_time = self.ground_hit_time;
            }
        }
    }
    
    monkey_print( "next ground hit in " + level.ground_hit_delay );
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xd156752a, Offset: 0x4600
// Size: 0x9c
function monkey_round_wait()
{
    /#
        if ( getdvarint( "<dev string:x47>" ) == 2 || getdvarint( "<dev string:x47>" ) >= 4 )
        {
            level waittill( #"forever" );
        }
    #/
    
    wait 1;
    
    if ( level flag::get( "monkey_round" ) )
    {
        wait 7;
        
        while ( level.monkey_intermission )
        {
            wait 0.5;
        }
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xb4a5e22c, Offset: 0x46a8
// Size: 0x80
function monkey_round_aftermath()
{
    level flag::wait_till( "last_monkey_down" );
    level thread zm_audio::sndmusicsystem_playstate( "monkey_round_end" );
    level.round_spawn_func = level.monkey_save_spawn_func;
    level.round_wait_func = level.monkey_save_wait_func;
    wait 6;
    level.sndmusicspecialround = 0;
    level.monkey_intermission = 0;
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xa5ec379e, Offset: 0x4730
// Size: 0x230
function monkey_round_tracker()
{
    level flag::wait_till( "power_on" );
    level flag::wait_till( "perk_bought" );
    level.monkey_save_spawn_func = level.round_spawn_func;
    level.monkey_save_wait_func = level.round_wait_func;
    level.next_monkey_round = level.round_number + randomintrange( 1, 4 );
    level.prev_monkey_round = level.next_monkey_round;
    
    while ( true )
    {
        level waittill( #"between_round_over" );
        
        if ( level.round_number == level.next_monkey_round )
        {
            if ( !monkey_player_has_perk() )
            {
                level.next_monkey_round++;
                monkey_print( "next monkey round at " + level.next_monkey_round );
                continue;
            }
            
            level.sndmusicspecialround = 1;
            level.monkey_save_spawn_func = level.round_spawn_func;
            level.monkey_save_wait_func = level.round_wait_func;
            level thread zm_audio::sndmusicsystem_playstate( "monkey_round_start" );
            monkey_round_start();
            level.round_spawn_func = &monkey_round_spawning;
            level.round_wait_func = &monkey_round_wait;
            level.prev_monkey_round = level.next_monkey_round;
            level.next_monkey_round = level.round_number + randomintrange( 4, 6 );
            monkey_print( "next monkey round at " + level.next_monkey_round );
            continue;
        }
        
        if ( level flag::get( "monkey_round" ) )
        {
            monkey_round_stop();
        }
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x5e33979a, Offset: 0x4968
// Size: 0x13c
function monkey_round_start()
{
    level flag::set( "monkey_round" );
    level flag::set( "monkey_free_perk" );
    
    if ( isdefined( level.monkey_round_start ) )
    {
        level thread [[ level.monkey_round_start ]]();
    }
    
    level thread monkey_zombie_setup_perks();
    level monkey_setup_health();
    level monkey_setup_spawners();
    level monkey_setup_packs();
    level monkey_pack_man_setup_perks();
    level thread monkey_grenade_watcher();
    util::clientnotify( "monkey_start" );
    playsoundatposition( "zmb_ape_intro_sonicboom_fnt", ( 0, 0, 0 ) );
    level thread play_delayed_player_vox();
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x19b4fca0, Offset: 0x4ab0
// Size: 0x6c
function play_delayed_player_vox()
{
    wait 8;
    players = getplayers();
    players[ randomintrange( 0, players.size ) ] zm_audio::create_and_play_dialog( "general", "monkey_spawn" );
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x74e0c9a6, Offset: 0x4b28
// Size: 0x120
function monkey_round_stop()
{
    level flag::clear( "monkey_round" );
    level flag::clear( "last_monkey_down" );
    
    if ( isdefined( level.monkey_round_stop ) )
    {
        level thread [[ level.monkey_round_stop ]]();
    }
    
    util::clientnotify( "monkey_stop" );
    level notify( #"grenade_watcher_stop" );
    players = getplayers();
    
    foreach ( player in players )
    {
        self.perk_hud_flash = undefined;
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x685251c5, Offset: 0x4c50
// Size: 0x164, Type: bool
function monkey_player_has_perk()
{
    vending_triggers = function_5b9c3e11();
    
    for ( i = 0; i < vending_triggers.size ; i++ )
    {
        players = getplayers();
        
        for ( j = 0; j < players.size ; j++ )
        {
            perk = vending_triggers[ i ].script_noteworthy;
            org = vending_triggers[ i ].origin;
            
            if ( isdefined( vending_triggers[ i ].realorigin ) )
            {
                org = vending_triggers[ i ].realorigin;
            }
            
            zone_enabled = zm_zonemgr::get_zone_from_position( org, 0 );
            
            if ( players[ j ] hasperk( perk ) && isdefined( zone_enabled ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x46b62980, Offset: 0x4dc0
// Size: 0x78
function monkey_zombie_manager()
{
    while ( true )
    {
        while ( level.num_monkey_zombies < level.max_monkey_zombies )
        {
            spawner = monkey_zombie_pick_best_spawner();
            
            if ( isdefined( spawner ) )
            {
                spawner monkey_zombie_spawn();
            }
            
            wait 10;
        }
        
        wait 10;
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x8476fe25, Offset: 0x4e40
// Size: 0xaa
function monkey_zombie_pick_best_spawner()
{
    best_spawner = undefined;
    best_score = -1;
    
    for ( i = 0; i < level.monkey_zombie_spawners.size ; i++ )
    {
        score = [[ level.monkey_zombie_spawn_heuristic ]]( level.monkey_zombie_spawners[ i ] );
        
        if ( score > best_score )
        {
            best_spawner = level.monkey_zombie_spawners[ i ];
            best_score = score;
        }
    }
    
    return best_spawner;
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x1607a352, Offset: 0x4ef8
// Size: 0x3c
function monkey_zombie_choose_run()
{
    self endon( #"death" );
    self.zombie_move_speed = "run";
    self waittill( #"speed_up" );
    self.zombie_move_speed = "sprint";
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x52f88196, Offset: 0x4f40
// Size: 0x1f0
function monkey_zombie_think()
{
    self endon( #"death" );
    self thread play_random_monkey_vox();
    self.goalradius = 32;
    self.meleeattackdist = 64;
    self.charge_player = 0;
    level.monkey_zombie_min_health = int( level.monkey_zombie_health );
    
    if ( !isdefined( self.maxhealth ) || self.maxhealth < level.monkey_zombie_min_health )
    {
        self.maxhealth = level.monkey_zombie_min_health;
        self.health = level.monkey_zombie_min_health;
    }
    
    if ( isdefined( level.user_ryan_monkey_health ) )
    {
        self.maxhealth = 1;
        self.health = 1;
    }
    
    self thread monkey_zombie_choose_run();
    self.maxsightdistsqrd = 9216;
    self [[ level.monkey_zombie_enter_level ]]();
    
    if ( isdefined( level.monkey_zombie_custom_think ) )
    {
        self thread [[ level.monkey_zombie_custom_think ]]();
    }
    
    self.ignoreall = 0;
    self thread monkey_zombie_ground_hit_think();
    self thread monkey_zombie_grenade_watcher();
    self thread monkey_zombie_bhb_watcher();
    self thread monkey_zombie_speed_watcher();
    self thread monkey_zombie_fling_watcher();
    self thread monkey_zombie_update();
    self thread function_f0891021();
    
    if ( isdefined( level.monkey_zombie_failsafe ) )
    {
        self thread [[ level.monkey_zombie_failsafe ]]();
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x8568cc85, Offset: 0x5138
// Size: 0x88
function monkey_zombie_debug()
{
    self endon( #"death" );
    
    while ( true )
    {
        forward = vectornormalize( anglestoforward( self.angles ) );
        end_pos = self.origin - vectorscale( forward, 120 );
        util::wait_network_frame();
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x9239bf78, Offset: 0x51c8
// Size: 0x186
function monkey_zombie_update()
{
    self endon( #"death" );
    self endon( #"monkey_update_stop" );
    self animmode( "none" );
    
    while ( true )
    {
        if ( isdefined( self.custom_think ) && self.custom_think )
        {
            util::wait_network_frame();
            continue;
        }
        else if ( self.state == "bhb_response" || isdefined( self.state ) && self.state == "grenade_response" )
        {
            util::wait_network_frame();
            continue;
        }
        else if ( isdefined( self.perk ) )
        {
            self thread monkey_zombie_destroy_perk();
            self waittill( #"stop_perk_attack" );
            util::wait_network_frame();
            continue;
        }
        else if ( isdefined( self.ground_hit ) && self.ground_hit )
        {
            util::wait_network_frame();
            continue;
        }
        else if ( !isdefined( self.following_player ) || !self.following_player )
        {
            self.following_player = 1;
            self monkey_zombie_set_state( "charge_player" );
        }
        
        wait 1;
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x1b18c1ff, Offset: 0x5358
// Size: 0x116
function function_f0891021()
{
    self endon( #"death" );
    
    while ( true )
    {
        dist_sq = 0;
        start_pos = self.origin;
        wait 1;
        dist_sq = distancesquared( start_pos, self.origin );
        start_pos = self.origin;
        wait 1;
        dist_sq += distancesquared( start_pos, self.origin );
        start_pos = self.origin;
        wait 1;
        dist_sq += distancesquared( start_pos, self.origin );
        
        if ( dist_sq < 144 )
        {
            self.following_player = 1;
            self monkey_zombie_set_state( "charge_player" );
        }
        
        wait 3;
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xb31c0b0b, Offset: 0x5478
// Size: 0xda
function monkey_zombie_get_perk_pos()
{
    a_s_points = struct::get_array( self.pack.machine.target, "targetname" );
    
    for ( i = 0; i < a_s_points.size ; i++ )
    {
        if ( a_s_points[ i ].script_noteworthy !== "attack_spot" )
        {
            continue;
        }
        
        if ( isdefined( self.pack.attack[ i ] ) )
        {
            continue;
        }
        
        self.pack.attack[ i ] = self;
        self.attack = a_s_points[ i ];
        break;
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xa990b30d, Offset: 0x5560
// Size: 0x10
function monkey_pack_clear_perk_pos()
{
    self.attack = [];
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x3773dca3, Offset: 0x5578
// Size: 0xc8
function monkey_zombie_health_watcher()
{
    self endon( #"death" );
    health_limit = self.health * 0.75;
    
    while ( true )
    {
        if ( self.health <= health_limit )
        {
            self stopanimscripted();
            util::wait_network_frame();
            self notify( #"stop_perk_attack" );
            self monkey_zombie_set_state( "charge_player" );
            self.charge_player = 1;
            self.perk = undefined;
            break;
        }
        
        util::wait_network_frame();
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x5dc087a6, Offset: 0x5648
// Size: 0x70
function monkey_zombie_fling_watcher()
{
    self endon( #"death" );
    half_health = level.monkey_zombie_health * 0.5;
    
    while ( true )
    {
        if ( self.health <= half_health )
        {
            self.thundergun_fling_func = undefined;
            break;
        }
        
        util::wait_network_frame();
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x88312af, Offset: 0x56c0
// Size: 0x56
function monkey_zombie_speed_watcher()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( self.health < self.maxhealth )
        {
            break;
        }
        
        util::wait_network_frame();
    }
    
    self notify( #"speed_up" );
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x909ca565, Offset: 0x5720
// Size: 0x86
function monkey_grenade_watcher()
{
    self endon( #"death" );
    level.monkey_grenades = [];
    level.monkey_bhbs = [];
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        players[ i ] thread monkey_grenade_watch();
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xc8fc086d, Offset: 0x57b0
// Size: 0x108
function monkey_grenade_watch()
{
    self endon( #"death" );
    level endon( #"grenade_watcher_stop" );
    
    while ( true )
    {
        self waittill( #"grenade_fire", grenade, weapon );
        
        if ( zm_utility::is_lethal_grenade( weapon ) )
        {
            grenade thread monkey_grenade_wait();
            grenade.thrower = self;
            level.monkey_grenades[ level.monkey_grenades.size ] = grenade;
        }
        
        if ( weapon === level.w_black_hole_bomb )
        {
            grenade thread monkey_bhb_wait();
            level.monkey_bhbs[ level.monkey_bhbs.size ] = grenade;
        }
        
        monkey_print( "thrown from " + weapon.name );
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x3e7cedd4, Offset: 0x58c0
// Size: 0x44
function monkey_grenade_wait()
{
    self waittill( #"death" );
    arrayremovevalue( level.monkey_grenades, self );
    monkey_print( "remove grenade from level" );
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x845c0196, Offset: 0x5910
// Size: 0x44
function monkey_bhb_wait()
{
    self waittill( #"death" );
    arrayremovevalue( level.monkey_bhbs, self );
    monkey_print( "remove bhb from level" );
}

// Namespace zm_ai_monkey
// Params 2
// Checksum 0x10ffc453, Offset: 0x5960
// Size: 0x184
function monkey_zombie_grenade_throw_watcher( target, animname )
{
    self endon( #"death" );
    self waittillmatch( animname, "grenade_throw" );
    throw_angle = randomintrange( 20, 30 );
    dir = vectortoangles( target.origin - self.origin );
    dir = ( dir[ 0 ] - throw_angle, dir[ 1 ], dir[ 2 ] );
    dir = anglestoforward( dir );
    velocity = dir * 550;
    fuse = randomfloatrange( 1, 2 );
    hand_pos = self gettagorigin( "TAG_WEAPON_RIGHT" );
    grenade_type = target zm_utility::get_player_lethal_grenade();
    self magicgrenadetype( grenade_type, hand_pos, velocity, fuse );
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0xf605b5bf, Offset: 0x5af0
// Size: 0xc4
function monkey_zombie_grenade_throw( target )
{
    self endon( #"death" );
    forward = vectornormalize( anglestoforward( self.angles ) );
    end_pos = self.origin + vector_scale( forward, 96 );
    
    if ( bullettracepassed( self.origin, end_pos, 0, undefined ) )
    {
        self.var_cf51d24 = 1;
        return;
    }
    
    self.var_6602f0c5 = 1;
}

// Namespace zm_ai_monkey
// Params 2
// Checksum 0x99271010, Offset: 0x5bc0
// Size: 0x4e
function vector_scale( vec, scale )
{
    vec = ( vec[ 0 ] * scale, vec[ 1 ] * scale, vec[ 2 ] * scale );
    return vec;
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x68330dc1, Offset: 0x5c18
// Size: 0xd8
function monkey_zombie_watch_machine_damage()
{
    self endon( #"death" );
    self endon( #"stop_perk_attack" );
    self endon( #"stop_machine_watch" );
    arrival_health = self.health;
    
    while ( true )
    {
        monkey_zone = self monkey_get_zone();
        
        if ( isdefined( monkey_zone ) )
        {
            if ( monkey_zone.is_occupied || self.health < arrival_health )
            {
                monkey_print( "player is here, go crazy" );
                self.machine_damage = level.machine_damage_max;
                break;
            }
        }
        
        util::wait_network_frame();
    }
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0xddbb2f40, Offset: 0x5cf8
// Size: 0xac
function monkey_zombie_set_state( state )
{
    self.state = state;
    monkey_print( "set state to " + state );
    
    /#
        if ( !isdefined( self.var_ee277195 ) )
        {
            self.var_ee277195 = [];
        }
        
        if ( !isdefined( self.var_d82deb25 ) )
        {
            self.var_d82deb25 = 0;
        }
        
        self.var_ee277195[ self.var_d82deb25 ] = state;
        self.var_d82deb25++;
        
        if ( self.var_d82deb25 > 100 )
        {
            self.var_d82deb25 = 0;
        }
    #/
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xf6ab2199, Offset: 0x5db0
// Size: 0x1a
function monkey_zombie_get_state()
{
    if ( isdefined( self.state ) )
    {
        return self.state;
    }
    
    return undefined;
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x700b4a01, Offset: 0x5dd8
// Size: 0x4b4
function monkey_zombie_attack_perk()
{
    self endon( #"death" );
    self endon( #"stop_perk_attack" );
    self endon( #"next_perk" );
    
    if ( !isdefined( self.perk ) )
    {
        return;
    }
    
    level flag::clear( "monkey_free_perk" );
    self.following_player = 0;
    self thread monkey_zombie_health_watcher();
    self monkey_zombie_set_state( "attack_perk" );
    level thread play_player_perk_theft_vox( self.perk.script_noteworthy, self );
    spot = self.attack.script_int;
    self teleport( self.attack.origin, self.attack.angles );
    monkey_print( "attack " + self.perk.script_noteworthy + " from " + spot );
    choose = 0;
    
    if ( spot == 1 )
    {
        choose = randomintrange( 1, 3 );
    }
    else if ( spot == 3 )
    {
        choose = randomintrange( 3, 5 );
    }
    
    perk_attack_anim = undefined;
    
    if ( choose == 0 )
    {
        if ( isdefined( level.monkey_perk_attack_anims[ self.perk.script_noteworthy ] ) )
        {
            perk_attack_anim = level.monkey_perk_attack_anims[ self.perk.script_noteworthy ][ "front" ];
        }
    }
    else if ( choose == 1 )
    {
        if ( isdefined( level.monkey_perk_attack_anims[ self.perk.script_noteworthy ] ) )
        {
            perk_attack_anim = level.monkey_perk_attack_anims[ self.perk.script_noteworthy ][ "left" ];
        }
    }
    else if ( choose == 2 )
    {
        if ( isdefined( level.monkey_perk_attack_anims[ self.perk.script_noteworthy ] ) )
        {
            perk_attack_anim = level.monkey_perk_attack_anims[ self.perk.script_noteworthy ][ "left_top" ];
        }
    }
    else if ( choose == 3 )
    {
        if ( isdefined( level.monkey_perk_attack_anims[ self.perk.script_noteworthy ] ) )
        {
            perk_attack_anim = level.monkey_perk_attack_anims[ self.perk.script_noteworthy ][ "right" ];
        }
    }
    else if ( choose == 4 )
    {
        if ( isdefined( level.monkey_perk_attack_anims[ self.perk.script_noteworthy ] ) )
        {
            perk_attack_anim = level.monkey_perk_attack_anims[ self.perk.script_noteworthy ][ "right_top" ];
        }
    }
    
    if ( !isdefined( perk_attack_anim ) )
    {
        perk_attack_anim = level.monkey_perk_attack_anims[ choose ];
    }
    
    self thread monkey_wait_to_drop();
    time = getanimlength( perk_attack_anim );
    
    while ( true )
    {
        monkey_pack_flash_perk( self.perk.script_noteworthy );
        self thread play_attack_impacts( time );
        self animscripted( "attack_perk_anim", self.attack.origin, self.attack.angles, perk_attack_anim );
        
        if ( self monkey_zombie_perk_damage( self.machine_damage ) )
        {
            break;
        }
        
        wait time;
    }
    
    self notify( #"stop_machine_watch" );
    self monkey_zombie_set_state( "attack_perk_done" );
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xcc6f2964, Offset: 0x6298
// Size: 0xcc
function monkey_wait_to_drop()
{
    self endon( #"death" );
    wait 0.2;
    self.dropped = 0;
    self.perk_attack_origin = self.attack.origin;
    
    while ( true )
    {
        diff = abs( self.perk_attack_origin[ 2 ] - self.origin[ 2 ] );
        
        if ( diff < 8 )
        {
            break;
        }
        
        util::wait_network_frame();
    }
    
    self.dropped = 1;
    monkey_print( "close to ground" );
}

// Namespace zm_ai_monkey
// Params 2
// Checksum 0x751ed1a5, Offset: 0x6370
// Size: 0x21a
function play_player_perk_theft_vox( perk, monkey )
{
    force_quit = 0;
    
    if ( !isdefined( level.perk_theft_vox ) )
    {
        level.perk_theft_vox = [];
    }
    
    if ( !isdefined( level.perk_theft_vox[ perk ] ) )
    {
        level.perk_theft_vox[ perk ] = 0;
    }
    
    if ( level.perk_theft_vox[ perk ] )
    {
        return;
    }
    
    level.perk_theft_vox[ perk ] = 1;
    
    while ( true )
    {
        player = getplayers();
        rand = randomintrange( 0, player.size );
        
        if ( monkey monkey_zombie_perk_damage( monkey.machine_damage ) )
        {
            level.perk_theft_vox[ perk ] = 0;
            return;
        }
        
        if ( isalive( player[ rand ] ) && !player[ rand ] laststand::player_is_in_laststand() && player[ rand ] hasperk( perk ) )
        {
            player[ rand ] zm_audio::create_and_play_dialog( "perk", "steal_" + perk );
            break;
        }
        else if ( force_quit >= 6 )
        {
            break;
        }
        
        force_quit++;
        wait 0.05;
    }
    
    while ( isdefined( monkey ) && !monkey monkey_zombie_perk_damage( monkey.machine_damage ) )
    {
        wait 1;
    }
    
    level.perk_theft_vox[ perk ] = 0;
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0xda69def6, Offset: 0x6598
// Size: 0x9e
function play_attack_impacts( time )
{
    self endon( #"death" );
    
    for ( i = 0; i < time ; i++ )
    {
        if ( randomintrange( 0, 100 ) >= 41 )
        {
            self playsound( "zmb_monkey_attack_machine" );
        }
        
        wait randomfloatrange( 0.7, 1.1 );
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x258135b, Offset: 0x6640
// Size: 0x114
function monkey_zombie_destroy_perk()
{
    self endon( #"death" );
    self endon( #"stop_perk_attack" );
    
    if ( isdefined( self.perk ) )
    {
        self monkey_zombie_set_state( "destroy_perk" );
        monkey_print( "goto " + self.perk.script_noteworthy );
        self monkey_zombie_get_perk_pos();
        
        if ( isdefined( self.attack ) )
        {
            self setgoalpos( self.attack.origin );
            self waittill( #"goal" );
            self setgoalpos( self.origin );
            self thread monkey_zombie_watch_machine_damage();
            self thread monkey_zombie_attack_perk();
        }
    }
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0x75f523c5, Offset: 0x6760
// Size: 0x126
function monkey_zombie_default_spawn_heuristic( spawner )
{
    if ( !isdefined( spawner.script_noteworthy ) )
    {
        return -1;
    }
    
    if ( !isdefined( level.zones ) || !isdefined( level.zones[ spawner.script_noteworthy ] ) || !level.zones[ spawner.script_noteworthy ].is_enabled )
    {
        return -1;
    }
    
    score = 0;
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        score = int( distancesquared( spawner.origin, players[ i ].origin ) );
    }
    
    return score;
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xa41bf98e, Offset: 0x6890
// Size: 0xf0
function monkey_zombie_ground_hit()
{
    self endon( #"death" );
    
    if ( self.ground_hit )
    {
        return;
    }
    
    self monkey_zombie_set_state( "ground_pound" );
    self.ground_hit = 1;
    self thread groundhit_watcher( "ground_pound" );
    self zombie_shared::donotetracks( "ground_pound" );
    self.ground_hit = 0;
    self monkey_zombie_set_state( "ground_pound_done" );
    self.nextgroundhit = gettime() + level.monkey_ground_attack_delay;
    
    if ( self.chest_beat )
    {
        self zombie_shared::donotetracks( "board_taunt" );
        self.chest_beat = 0;
    }
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0xd5748c80, Offset: 0x6988
// Size: 0xc6, Type: bool
function monkey_pack_ready_to_detonate( claymore )
{
    for ( i = 0; i < self.monkeys.size ; i++ )
    {
        if ( self.monkeys[ i ] == self )
        {
            continue;
        }
        
        ready = self.monkeys[ i ].force_detonate;
        
        if ( isdefined( ready ) )
        {
            for ( j = 0; j < ready.size ; j++ )
            {
                if ( claymore == ready[ j ] )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x97d7dc1d, Offset: 0x6a58
// Size: 0x150, Type: bool
function monkey_zombie_force_groundhit()
{
    if ( !isdefined( level.claymores ) )
    {
        return false;
    }
    
    claymore_dist = 46656;
    height_max = 12;
    self.force_detonate = [];
    
    for ( i = 0; i < level.claymores.size ; i++ )
    {
        if ( self.pack monkey_pack_ready_to_detonate( level.claymores[ i ] ) )
        {
            continue;
        }
        
        height_diff = abs( self.origin[ 2 ] - level.claymores[ i ].origin[ 2 ] );
        
        if ( height_diff < height_max )
        {
            if ( distancesquared( self.origin, level.claymores[ i ].origin ) < claymore_dist )
            {
                self.force_detonate[ self.force_detonate.size ] = level.claymores[ i ];
            }
        }
    }
    
    return self.force_detonate.size > 0;
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xa6cdfa3b, Offset: 0x6bb0
// Size: 0x280
function monkey_zombie_ground_hit_think()
{
    self endon( #"death" );
    self.ground_hit = 0;
    self.nextgroundhit = gettime() + level.monkey_ground_attack_delay;
    
    while ( true )
    {
        if ( isdefined( self.state ) && self.state == "attack_perk" )
        {
            util::wait_network_frame();
            continue;
        }
        
        if ( isdefined( self.dropped ) && !self.dropped )
        {
            wait 1;
            continue;
        }
        
        if ( !self.ground_hit && self monkey_zombie_force_groundhit() )
        {
            self.pack monkey_pack_update_ground_hit( self );
            self.var_aa9937 = 1;
        }
        else if ( !self.ground_hit && self monkey_zombie_check_ground_hit() )
        {
            players = getplayers();
            closeenough = 0;
            origin = self geteye();
            
            for ( i = 0; i < players.size ; i++ )
            {
                if ( players[ i ] laststand::player_is_in_laststand() )
                {
                    continue;
                }
                
                test_origin = players[ i ] geteye();
                d = distancesquared( origin, test_origin );
                
                if ( d > level.monkey_zombie_groundhit_trigger_radius * level.monkey_zombie_groundhit_trigger_radius )
                {
                    continue;
                }
                
                if ( !bullettracepassed( origin, test_origin, 0, undefined ) )
                {
                    continue;
                }
                
                closeenough = 1;
                break;
            }
            
            if ( closeenough )
            {
                self.pack monkey_pack_update_ground_hit( self );
                self.var_aa9937 = 1;
            }
        }
        
        util::wait_network_frame();
    }
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0xad4230f5, Offset: 0x6e38
// Size: 0x4ae
function groundhit_watcher( animname )
{
    self endon( #"death" );
    self waittillmatch( animname, "fire" );
    playfxontag( level._effect[ "monkey_groundhit" ], self, "tag_origin" );
    self playsound( "zmb_monkey_groundpound" );
    origin = self.origin + ( 0, 0, 40 );
    zombies = array::get_all_closest( origin, getaispeciesarray( level.zombie_team, "all" ), undefined, undefined, level.monkey_zombie_groundhit_damage_radius );
    
    if ( isdefined( zombies ) )
    {
        for ( i = 0; i < zombies.size ; i++ )
        {
            if ( !isdefined( zombies[ i ] ) )
            {
                continue;
            }
            
            if ( zm_utility::is_magic_bullet_shield_enabled( zombies[ i ] ) )
            {
                continue;
            }
            
            test_origin = zombies[ i ] geteye();
            
            if ( !bullettracepassed( origin, test_origin, 0, undefined ) )
            {
                continue;
            }
            
            if ( zombies[ i ] == self )
            {
                continue;
            }
            
            if ( zombies[ i ].animname == "monkey_zombie" )
            {
                continue;
            }
            
            zombies[ i ] zombie_utility::gib_random_parts();
            gibserverutils::annihilate( zombies[ i ] );
            zombies[ i ] dodamage( zombies[ i ].health * 10, self.origin, self );
        }
    }
    
    players = getplayers();
    affected_players = [];
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( !zombie_utility::is_player_valid( players[ i ] ) )
        {
            continue;
        }
        
        test_origin = players[ i ] geteye();
        
        if ( distancesquared( origin, test_origin ) > level.monkey_zombie_groundhit_damage_radius * level.monkey_zombie_groundhit_damage_radius )
        {
            continue;
        }
        
        if ( !bullettracepassed( origin, test_origin, 0, undefined ) )
        {
            continue;
        }
        
        if ( !isdefined( affected_players ) )
        {
            affected_players = [];
        }
        else if ( !isarray( affected_players ) )
        {
            affected_players = array( affected_players );
        }
        
        affected_players[ affected_players.size ] = players[ i ];
    }
    
    self.chest_beat = 0;
    
    for ( i = 0; i < affected_players.size ; i++ )
    {
        self.chest_beat = 1;
        player = affected_players[ i ];
        
        if ( player isonground() )
        {
            damage = player.maxhealth * 0.5;
            player dodamage( damage, self.origin, self );
        }
    }
    
    if ( isdefined( self.force_detonate ) )
    {
        for ( i = 0; i < self.force_detonate.size ; i++ )
        {
            if ( isdefined( self.force_detonate[ i ] ) )
            {
                self.force_detonate[ i ] detonate( undefined );
            }
        }
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x2d0925d3, Offset: 0x72f0
// Size: 0x240
function monkey_zombie_grenade_pickup()
{
    self endon( #"death" );
    pickup_dist_sq = 1024;
    picked_up = 0;
    
    while ( isdefined( self.monkey_grenade ) )
    {
        self setgoalpos( self.monkey_grenade.origin );
        grenade_dist_sq = distancesquared( self.origin, self.monkey_grenade.origin );
        
        if ( grenade_dist_sq <= pickup_dist_sq )
        {
            self.monkey_thrower = self.monkey_grenade.thrower;
            self.monkey_grenade delete();
            self.monkey_grenade = undefined;
            picked_up = 1;
            monkey_print( "deleting grenade" );
        }
        
        util::wait_network_frame();
    }
    
    if ( picked_up )
    {
        while ( true )
        {
            self setgoalpos( self.monkey_thrower.origin );
            target_dir = self.monkey_thrower.origin - self.origin;
            monkey_dir = anglestoforward( self.angles );
            dot = vectordot( vectornormalize( target_dir ), vectornormalize( monkey_dir ) );
            
            if ( dot >= 0.5 )
            {
                break;
            }
            
            util::wait_network_frame();
        }
        
        self thread monkey_zombie_grenade_throw( self.monkey_thrower );
        self waittill( #"throw_done" );
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xd32bf357, Offset: 0x7538
// Size: 0xdc
function monkey_zombie_grenade_response()
{
    self endon( #"death" );
    monkey_print( "go for grenade" );
    self notify( #"stop_find_flesh" );
    self notify( #"monkey_update_stop" );
    self notify( #"stop_perk_attack" );
    self.following_player = 0;
    self monkey_zombie_set_state( "grenade_response" );
    self monkey_zombie_clear_attack_pos();
    self monkey_zombie_grenade_pickup();
    self thread monkey_zombie_update();
    self monkey_zombie_set_state( "grenade_response_done" );
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x6c37bd49, Offset: 0x7620
// Size: 0x1c8
function monkey_zombie_grenade_watcher()
{
    self endon( #"death" );
    grenade_respond_dist_sq = 14400;
    
    while ( true )
    {
        if ( self.state == "default" )
        {
            util::wait_network_frame();
            continue;
        }
        
        if ( isdefined( self.ground_hit ) && self.ground_hit )
        {
            util::wait_network_frame();
            continue;
        }
        
        if ( isdefined( self.monkey_grenade ) && self.monkey_grenade )
        {
            util::wait_network_frame();
            continue;
        }
        
        if ( level.monkey_grenades.size > 0 )
        {
            for ( i = 0; i < level.monkey_grenades.size ; i++ )
            {
                grenade = level.monkey_grenades[ i ];
                
                if ( !isdefined( grenade ) || isdefined( grenade.monkey ) )
                {
                    util::wait_network_frame();
                    continue;
                }
                
                grenade_dist_sq = distancesquared( self.origin, grenade.origin );
                
                if ( grenade_dist_sq <= grenade_respond_dist_sq )
                {
                    grenade.monkey = self;
                    self.monkey_grenade = grenade;
                    self monkey_zombie_grenade_response();
                    break;
                }
            }
        }
        
        util::wait_network_frame();
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x645db1aa, Offset: 0x77f0
// Size: 0x284
function monkey_zombie_bhb_teleport()
{
    self endon( #"death" );
    monkey_print( "bhb teleport" );
    black_hole_teleport = struct::get_array( "struct_black_hole_teleport", "targetname" );
    zone_name = self zm_utility::get_current_zone();
    locations = [];
    
    for ( i = 0; i < black_hole_teleport.size ; i++ )
    {
        bhb_zone_name = black_hole_teleport[ i ].script_string;
        
        if ( !isdefined( bhb_zone_name ) || !isdefined( zone_name ) )
        {
            continue;
        }
        
        if ( bhb_zone_name == zone_name )
        {
            continue;
        }
        
        if ( !level.zones[ bhb_zone_name ].is_enabled )
        {
            continue;
        }
        
        locations[ locations.size ] = black_hole_teleport[ i ];
    }
    
    self stopanimscripted();
    util::wait_network_frame();
    so = spawn( "script_origin", self.origin );
    so.angles = self.angles;
    self linkto( so );
    
    if ( locations.size > 0 )
    {
        locations = array::randomize( locations );
        so.origin = locations[ 0 ].origin;
        so.angles = locations[ 0 ].angles;
    }
    else
    {
        so.origin = self.spawn_origin;
        so.angles = self.spawn_angles;
    }
    
    util::wait_network_frame();
    self unlink();
    so delete();
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x52d4a7d9, Offset: 0x7a80
// Size: 0xdc
function monkey_zombie_bhb_failsafe()
{
    self endon( #"death" );
    self endon( #"bhb_old_failsafe" );
    prev_origin = self.origin;
    min_movement = 256;
    
    while ( true )
    {
        wait 1;
        dist = distancesquared( prev_origin, self.origin );
        
        if ( dist < min_movement )
        {
            break;
        }
        
        prev_origin = self.origin;
    }
    
    if ( self.state == "ground_pound" )
    {
        return;
    }
    
    self.safetochangescript = 1;
    self animmode( "none" );
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x745a55d8, Offset: 0x7b68
// Size: 0x1c4
function monkey_zombie_bhb_run()
{
    self endon( #"death" );
    jump_dist_sq = 4096;
    jump = 0;
    util::wait_network_frame();
    
    if ( !isdefined( self.monkey_bhb ) || !isdefined( self.monkey_bhb.origin ) )
    {
        return;
    }
    
    self.safetochangescript = 0;
    self setgoalpos( self.monkey_bhb.origin );
    
    while ( isdefined( self.monkey_bhb ) )
    {
        bhb_dist_sq = distancesquared( self.origin, self.monkey_bhb.origin );
        
        if ( bhb_dist_sq <= jump_dist_sq )
        {
            jump = 1;
            break;
        }
        
        util::wait_network_frame();
    }
    
    if ( jump )
    {
        self monkey_zombie_bhb_teleport();
    }
    
    util::wait_network_frame();
    self.safetochangescript = 1;
    self setgoalpos( self.origin );
    self util::waittill_notify_or_timeout( "goal", 0.5 );
    self notify( #"bhb_old_failsafe" );
    util::wait_network_frame();
    self thread monkey_zombie_bhb_failsafe();
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x75231cd4, Offset: 0x7d38
// Size: 0xa2
function monkey_zombie_clear_attack_pos()
{
    if ( isdefined( self.attack ) )
    {
        if ( isdefined( self.pack.attack ) )
        {
            for ( i = 0; i < self.pack.attack.size ; i++ )
            {
                if ( self == self.pack.attack[ i ] )
                {
                    arrayremovevalue( self.pack.attack, self );
                    self.attack = undefined;
                    return;
                }
            }
        }
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x43c0639e, Offset: 0x7de8
// Size: 0xdc
function monkey_zombie_bhb_response()
{
    self endon( #"death" );
    monkey_print( "bhb response" );
    self notify( #"stop_find_flesh" );
    self notify( #"monkey_update_stop" );
    self notify( #"stop_perk_attack" );
    self.following_player = 0;
    self monkey_zombie_set_state( "bhb_response" );
    self monkey_zombie_clear_attack_pos();
    self monkey_zombie_bhb_run();
    self thread monkey_zombie_update();
    self monkey_zombie_set_state( "bhb_response_done" );
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x8b561b09, Offset: 0x7ed0
// Size: 0x200
function monkey_zombie_bhb_watcher()
{
    self endon( #"death" );
    bhb_respond_dist_sq = 262144;
    
    while ( true )
    {
        if ( self.state == "default" || self.state == "ground_pound" || self.state == "ground_pound_taunt" || self.state == "grenade_reponse" || self.state == "bhb_response" || self.state == "attack_perk" || !( isdefined( self.dropped ) && self.dropped ) )
        {
            util::wait_network_frame();
            continue;
        }
        
        if ( level.monkey_bhbs.size > 0 )
        {
            for ( i = 0; i < level.monkey_bhbs.size ; i++ )
            {
                bhb = level.monkey_bhbs[ i ];
                
                if ( isdefined( bhb.is_valid ) && bhb.is_valid )
                {
                    if ( !isdefined( bhb ) || !isdefined( bhb.origin ) || !isdefined( self.origin ) )
                    {
                        continue;
                    }
                    
                    bhb_dist_sq = distancesquared( self.origin, bhb.origin );
                    
                    if ( bhb_dist_sq <= bhb_respond_dist_sq )
                    {
                        self.monkey_bhb = bhb;
                        self monkey_zombie_bhb_response();
                    }
                }
            }
        }
        
        util::wait_network_frame();
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xfca8bab1, Offset: 0x80d8
// Size: 0x284
function monkey_remove_from_pack()
{
    for ( i = 0; i < level.monkey_pack.size ; i++ )
    {
        pack = level.monkey_pack[ i ];
        
        for ( j = 0; j < pack.monkeys.size ; j++ )
        {
            if ( self == pack.monkeys[ j ] )
            {
                arrayremovevalue( pack.monkeys, self );
                
                if ( pack.monkeys.size == 0 && pack.spawning_done )
                {
                    if ( isdefined( pack.perk ) )
                    {
                        pack.perk.targeted = 0;
                    }
                    
                    level.monkey_packs_killed++;
                    level flag::set( "monkey_pack_down" );
                    arrayremovevalue( level.monkey_pack, pack );
                }
            }
        }
    }
    
    if ( level.monkey_packs_killed >= level.monkey_pack_max )
    {
        level flag::set( "last_monkey_down" );
        
        if ( self monkey_zombie_can_drop_free_perk() )
        {
            forward = vectornormalize( anglestoforward( self.angles ) );
            end_pos = self.origin - vectorscale( forward, 32 );
            level thread zm_powerups::specific_powerup_drop( "free_perk", end_pos );
        }
        
        drop_pos = self.origin;
        
        if ( self.state == "attack_perk" || !self.dropped )
        {
            drop_pos = self.attack.origin;
        }
        
        level thread zm_powerups::specific_powerup_drop( "full_ammo", drop_pos );
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xbf434c46, Offset: 0x8368
// Size: 0x1f6, Type: bool
function monkey_zombie_can_drop_free_perk()
{
    if ( !level flag::get( "monkey_free_perk" ) )
    {
        return false;
    }
    
    max_perks = 0;
    
    if ( !isdefined( level.max_perks ) )
    {
        println( "<dev string:x54>" );
        max_perks = 4;
    }
    else
    {
        max_perks = level.max_perks;
    }
    
    if ( level flag::get( "solo_game" ) )
    {
        if ( level.solo_lives_given >= level.max_solo_lives )
        {
            players = getplayers();
            
            if ( !players[ 0 ] hasperk( "specialty_quickrevive" ) )
            {
                max_perks--;
            }
        }
    }
    
    players = getplayers();
    vending_triggers = function_5b9c3e11();
    
    for ( i = 0; i < players.size ; i++ )
    {
        num_perks = 0;
        
        for ( j = 0; j < vending_triggers.size ; j++ )
        {
            perk = vending_triggers[ j ].script_noteworthy;
            
            if ( players[ i ] hasperk( perk ) )
            {
                num_perks++;
            }
        }
        
        if ( num_perks < max_perks )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_ai_monkey
// Params 8
// Checksum 0xdc3973f0, Offset: 0x8568
// Size: 0x1e6, Type: bool
function monkey_zombie_die( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime )
{
    self zombie_utility::reset_attack_spot();
    self clientfield::set( "monkey_eye_glow", 0 );
    self.grenadeammo = 0;
    playfx( level._effect[ "monkey_death" ], self.origin );
    playsoundatposition( "zmb_monkey_explode", self.origin );
    level zm_spawner::zombie_death_points( self.origin, self.damagemod, self.damagelocation, self.attacker, self );
    
    if ( randomintrange( 0, 100 ) >= 75 )
    {
        if ( isdefined( self.attacker ) && isplayer( self.attacker ) )
        {
            self.attacker zm_audio::create_and_play_dialog( "kill", "space_monkey" );
        }
    }
    
    if ( self.damagemod == "MOD_BURNED" )
    {
        self thread zombie_death::flame_death_fx();
    }
    
    level.monkey_death++;
    level.monkey_death_total++;
    self monkey_remove_from_pack();
    self bgb::actor_death_override( attacker );
    return false;
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0x2ea0df68, Offset: 0x8758
// Size: 0x74
function monkey_custom_damage( player )
{
    self endon( #"death" );
    damage = self.meleedamage;
    
    if ( isdefined( self.ground_hit ) && self.ground_hit )
    {
        damage = int( player.maxhealth * 0.25 );
    }
    
    return damage;
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x3f8cecaf, Offset: 0x87d8
// Size: 0x54
function monkey_zombie_default_enter_level()
{
    playfx( level._effect[ "monkey_spawn" ], self.origin );
    playsoundatposition( "zmb_ape_intro_land", self.origin );
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x6fdcfc3, Offset: 0x8838
// Size: 0x88
function monkey_pathing()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( isdefined( self.favoriteenemy ) )
        {
            self.ignoreall = 0;
            self orientmode( "face default" );
            self setgoalpos( self.favoriteenemy.origin );
        }
        
        util::wait_network_frame();
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x907fd406, Offset: 0x88c8
// Size: 0x1b0
function monkey_find_flesh()
{
    self endon( #"death" );
    level endon( #"intermission" );
    self endon( #"stop_find_flesh" );
    
    if ( level.intermission )
    {
        return;
    }
    
    self zm_spawner::zombie_history( "monkey find flesh -> start" );
    self.goalradius = 48;
    players = getplayers();
    self.ignore_player = [];
    player = zm_utility::get_closest_valid_player( self.origin, self.ignore_player );
    
    if ( !isdefined( player ) )
    {
        self zm_spawner::zombie_history( "monkey find flesh -> can't find player, continue" );
    }
    
    self.favoriteenemy = player;
    
    while ( true )
    {
        if ( isdefined( self.pack ) && isdefined( self.pack.enemy ) )
        {
            if ( !isdefined( self.favoriteenemy ) || self.favoriteenemy != self.pack.enemy )
            {
                self.favoriteenemy = self.pack.enemy;
            }
        }
        
        if ( isdefined( level.user_ryan_monkey_pathing ) )
        {
            self thread monkey_pathing();
        }
        else
        {
            self.ignoreall = 0;
            self orientmode( "face default" );
        }
        
        wait 0.1;
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xf7573bf2, Offset: 0x8a80
// Size: 0x66
function monkey_zombie_setup_perks()
{
    vending_triggers = function_5b9c3e11();
    
    for ( i = 0; i < vending_triggers.size ; i++ )
    {
        vending_triggers[ i ] monkey_zombie_perk_init();
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x6d4739ec, Offset: 0x8af0
// Size: 0xcc
function monkey_zombie_perk_init()
{
    self.targeted = 0;
    machine = undefined;
    targets = getentarray( self.target, "targetname" );
    
    for ( i = 0; i < targets.size ; i++ )
    {
        if ( targets[ i ].classname == "script_model" )
        {
            machine = targets[ i ];
            break;
        }
    }
    
    if ( isdefined( machine ) )
    {
        machine.monkey_health = 100;
    }
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0x31c61ccb, Offset: 0x8bc8
// Size: 0x9a, Type: bool
function monkey_zombie_perk_damage( amount )
{
    if ( !isdefined( self.perk ) )
    {
        return true;
    }
    
    machine = self.pack.machine;
    machine.monkey_health -= amount;
    
    if ( machine.monkey_health < 0 )
    {
        machine.monkey_health = 0;
    }
    
    return machine.monkey_health == 0;
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x845a1969, Offset: 0x8c70
// Size: 0x116
function monkey_pack_take_perk()
{
    players = getplayers();
    self.perk.targeted = 0;
    perk = self.perk.script_noteworthy;
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( players[ i ] hasperk( perk ) )
        {
            perk_str = perk + "_stop";
            players[ i ] notify( perk_str );
            
            if ( level flag::get( "solo_game" ) && perk == "specialty_quickrevive" )
            {
                players[ i ].lives--;
            }
        }
    }
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0xe68601d9, Offset: 0x8d90
// Size: 0x40
function monkey_perk_lost( perk )
{
    if ( perk == "specialty_armorvest" )
    {
        if ( self.health > self.maxhealth )
        {
            self.health = self.maxhealth;
        }
    }
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0xffe5c26a, Offset: 0x8dd8
// Size: 0x36
function monkey_perk_bought( perk )
{
    level flag::set( "perk_bought" );
    level.perk_bought_func = undefined;
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0xb7dfb427, Offset: 0x8e18
// Size: 0xa6
function monkey_pack_flash_perk( perk )
{
    if ( !isdefined( perk ) )
    {
        return;
    }
    
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( players[ i ] hasperk( perk ) )
        {
            players[ i ] thread function_7acaa6b4( perk );
        }
    }
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0x245191a7, Offset: 0x8ec8
// Size: 0xb4
function function_7acaa6b4( perk )
{
    self endon( #"disconnect" );
    
    if ( !isdefined( self.perk_hud_flash ) || self.perk_hud_flash != perk )
    {
        self.perk_hud_flash = perk;
        self zm_perks::set_perk_clientfield( perk, 2 );
        wait 0.3;
        
        if ( self hasperk( perk ) )
        {
            self zm_perks::set_perk_clientfield( perk, 1 );
        }
        
        self.perk_hud_flash = "none";
    }
}

// Namespace zm_ai_monkey
// Params 2
// Checksum 0x77c55f48, Offset: 0x8f88
// Size: 0x5a
function monkey_pack_stop_flash( perk, taken )
{
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
    }
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x400a3476, Offset: 0x8ff0
// Size: 0xe4
function monkey_get_zone()
{
    zone = undefined;
    keys = getarraykeys( level.zones );
    
    for ( i = 0; i < keys.size ; i++ )
    {
        zone = level.zones[ keys[ i ] ];
        
        for ( j = 0; j < zone.volumes.size ; j++ )
        {
            if ( self istouching( zone.volumes[ j ] ) )
            {
                return zone;
            }
        }
    }
    
    return zone;
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0x7b7b6ae9, Offset: 0x90e0
// Size: 0x1ea
function monkey_fling( player )
{
    monkey_print( "fling monkey damage" );
    damage = int( level.monkey_zombie_health * 0.5 );
    self dodamage( damage, self.origin, self );
    forward = vectornormalize( anglestoforward( self.angles ) );
    attack_dir = vectornormalize( self.origin - player.origin );
    dot = vectordot( attack_dir, forward );
    
    if ( dot < 0 )
    {
        end_pos = self.origin - vectorscale( forward, 120 );
        
        if ( sighttracepassed( self.origin, end_pos, 0, self ) )
        {
            flings = array::randomize( level.var_45abf882 );
            length = getanimlength( flings[ 0 ] );
            self animscripted( "fling_anim", self.origin, self.angles, flings[ 0 ] );
            wait length;
        }
    }
    
    self.thundergun_fling_func = undefined;
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0x58499b0d, Offset: 0x92d8
// Size: 0x9a
function monkey_revive_solo_fx()
{
    vending_triggers = getentarray( "zombie_vending", "targetname" );
    
    for ( i = 0; i < vending_triggers.size ; i++ )
    {
        if ( vending_triggers[ i ].script_noteworthy == "specialty_quickrevive" )
        {
            vending_triggers[ i ] delete();
            break;
        }
    }
}

// Namespace zm_ai_monkey
// Params 1
// Checksum 0xa9b6ec9a, Offset: 0x9380
// Size: 0x44
function monkey_print( str )
{
    /#
        if ( isdefined( level.var_ce37864e ) && level.var_ce37864e )
        {
            iprintln( str + "<dev string:x96>" );
        }
    #/
}

// Namespace zm_ai_monkey
// Params 0
// Checksum 0xdc91446e, Offset: 0x93d0
// Size: 0x38
function play_random_monkey_vox()
{
    self endon( #"death" );
    
    while ( true )
    {
        wait randomfloatrange( 1.25, 3 );
    }
}

