#using scripts/codescripts/struct;
#using scripts/cp/_objectives;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection3_sound;
#using scripts/cp/cp_mi_cairo_infection_accolades;
#using scripts/cp/cp_mi_cairo_infection_hideout_outro;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace infection_zombies;

// Namespace infection_zombies
// Params 0
// Checksum 0x987b294f, Offset: 0xcc8
// Size: 0x214
function main()
{
    level flag::init( "sarah_tree" );
    level flag::init( "end_round_wait" );
    level flag::init( "spawn_zombies", 1 );
    level flag::init( "zombies_completed" );
    level flag::init( "zombies_final_round" );
    level.gamedifficulty = getlocalprofileint( "g_gameskill" );
    
    if ( !isdefined( level.gamedifficulty ) )
    {
        level.gamedifficulty = 1;
    }
    
    init_levelvars();
    init_client_field_callback_funcs();
    level.zombie_spawn_locations = [];
    level.playable_areas = getentarray( "player_volume", "script_noteworthy" );
    
    for ( i = 0; i < level.playable_areas.size ; i++ )
    {
        if ( isdefined( level.playable_areas[ i ].target ) )
        {
            level.playable_areas[ i ] thread spawn_locations_init();
        }
    }
    
    level.zombie_spawners = getentarray( "zombie_spawner_infection_3", "script_noteworthy" );
    array::thread_all( level.zombie_spawners, &spawner::add_spawn_function, &zombie_spawn_init );
    level thread sarah_at_stalingrad();
}

// Namespace infection_zombies
// Params 0
// Checksum 0x52ca63c3, Offset: 0xee8
// Size: 0x96
function spawn_locations_init()
{
    points = struct::get_array( self.target, "targetname" );
    
    for ( i = 0; i < points.size ; i++ )
    {
        points[ i ].enabled = 1;
        array::add( level.zombie_spawn_locations, points[ i ], 0 );
    }
}

// Namespace infection_zombies
// Params 0
// Checksum 0x50d3dac8, Offset: 0xf88
// Size: 0x1c4
function init_client_field_callback_funcs()
{
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        clientfield::register( "actor", "zombie_riser_fx", 1, 1, "int" );
        clientfield::register( "actor", "zombie_has_eyes", 1, 1, "int" );
        clientfield::register( "actor", "zombie_gut_explosion", 1, 1, "int" );
        clientfield::register( "actor", "zombie_tac_mode_disable", 1, 1, "int" );
    }
    
    clientfield::register( "scriptmover", "zombie_fire_wall_fx", 1, 1, "int" );
    clientfield::register( "scriptmover", "zombie_fire_backdraft_fx", 1, 1, "int" );
    clientfield::register( "toplayer", "zombie_fire_overlay_init", 1, 1, "int" );
    clientfield::register( "toplayer", "zombie_fire_overlay", 1, 7, "float" );
    clientfield::register( "world", "zombie_root_grow", 1, 1, "int" );
}

// Namespace infection_zombies
// Params 0
// Checksum 0xc5a69289, Offset: 0x1158
// Size: 0x56
function check_num_alive()
{
    while ( true )
    {
        num_zombies = zombie_utility::get_current_zombie_count();
        
        /#
            iprintlnbold( "<dev string:x28>", num_zombies );
        #/
        
        wait 1;
    }
}

// Namespace infection_zombies
// Params 0
// Checksum 0x33f9cc08, Offset: 0x11b8
// Size: 0x3b8
function init_levelvars()
{
    level.zombie_team = "axis";
    level.is_zombie_level = 1;
    level.first_round = 1;
    level.start_round = 1;
    level.round_number = level.start_round;
    level.zombie_total = 0;
    level.total_zombies_killed = 0;
    level.zombie_spawn_locations = [];
    level.zombie_vars = [];
    level.current_zombie_array = [];
    level.current_zombie_count = 0;
    level.zombie_total_subtract = 0;
    level.zombie_actor_limit = 31;
    level.zombies_timeout_playspace = 0;
    level.zombie_game_time = 150;
    level.zombie_total_min = 2;
    level._effect[ "lightning_dog_spawn" ] = "zombie/fx_dog_lightning_buildup_zmb";
    level._effect[ "burn_loop_zombie_left_arm" ] = "fire/fx_fire_ai_human_arm_left_loop";
    level._effect[ "burn_loop_zombie_right_arm" ] = "fire/fx_fire_ai_human_arm_right_loop";
    level._effect[ "burn_loop_zombie_torso" ] = "fire/fx_fire_ai_human_torso_loop";
    level._effect[ "zombie_firewall_fx" ] = "fire/fx_fire_wall_moving_infection_city";
    difficulty = 1;
    column = int( difficulty ) + 1;
    zombie_utility::set_zombie_var( "zombie_health_increase", 0, 0, column );
    zombie_utility::set_zombie_var( "zombie_health_increase_multiplier", 0.1, 1, column );
    zombie_utility::set_zombie_var( "zombie_health_start", 50, 0, column );
    zombie_utility::set_zombie_var( "zombie_spawn_delay", 2, 1, column );
    zombie_utility::set_zombie_var( "zombie_ai_per_player", 8, 0, column );
    zombie_utility::set_zombie_var( "zombie_between_round_time", 1 );
    zombie_utility::set_zombie_var( "game_start_delay", 0, 0, column );
    zombie_utility::set_zombie_var( "zombie_use_failsafe", 1 );
    zombie_utility::set_zombie_var( "below_world_check", -5000 );
    zombie_utility::set_zombie_var( "zombie_max_ai", 32, 0, column );
    level.zombie_ai_limit = level.zombie_vars[ "zombie_max_ai" ];
    level.move_spawn_func = &move_zombie_spawn_location;
    level.max_zombie_func = &infection_max_zombie_func;
    timer = level.zombie_vars[ "zombie_spawn_delay" ];
    
    if ( timer > 0.08 )
    {
        level.zombie_vars[ "zombie_spawn_delay" ] = timer * 0.95;
    }
    else if ( timer < 0.25 )
    {
        level.zombie_vars[ "zombie_spawn_delay" ] = 0.25;
    }
    
    level.speed_change_max = 0;
    level.speed_change_num = 0;
}

// Namespace infection_zombies
// Params 1
// Checksum 0x6af9a985, Offset: 0x1578
// Size: 0x3c2
function zombie_spawn_init( animname_set )
{
    self endon( #"death" );
    
    if ( !isdefined( animname_set ) )
    {
        animname_set = 0;
    }
    
    self.targetname = "zombie";
    self.script_noteworthy = undefined;
    
    if ( !animname_set )
    {
        self.animname = "zombie";
    }
    
    self thread infection_util::zmbaivox_notifyconvert();
    self.zmb_vocals_attack = "zmb_vocals_zombie_attack";
    self.ignoreall = 1;
    self.allowdeath = 1;
    self.force_gib = 1;
    self.is_zombie = 1;
    self allowedstances( "stand" );
    self.gibbed = 0;
    self.head_gibbed = 0;
    self setphysparams( 15, 0, 72 );
    self.goalradius = 32;
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
    self.a.disablereact = 1;
    self.allowreact = 0;
    self.disableammodrop = 1;
    
    if ( isdefined( level.zombie_health ) )
    {
        self.maxhealth = level.zombie_health;
        
        if ( isdefined( level.zombie_respawned_health ) && level.zombie_respawned_health.size > 0 )
        {
            self.health = level.zombie_respawned_health[ 0 ];
            arrayremovevalue( level.zombie_respawned_health, level.zombie_respawned_health[ 0 ] );
        }
        else
        {
            self.health = level.zombie_health;
        }
    }
    else
    {
        self.maxhealth = level.zombie_vars[ "zombie_health_start" ];
        self.health = self.maxhealth;
    }
    
    self setavoidancemask( "avoid none" );
    self pathmode( "dont move" );
    level thread zombie_death_event( self );
    self infection_run_speed();
    self thread zombie_think();
    self thread zombie_utility::zombie_gib_on_damage();
    
    if ( !isdefined( self.no_eye_glow ) || !self.no_eye_glow )
    {
        self thread zombie_utility::delayed_zombie_eye_glow();
    }
    
    self.deathfunction = &zombie_death_animscript;
    self.flame_damage_time = 0;
    self.meleedamage = 20;
    self.no_powerups = 1;
    self.team = level.zombie_team;
    self.zombie_init_done = 1;
    self notify( #"zombie_init_done" );
}

// Namespace infection_zombies
// Params 0
// Checksum 0x20e14bad, Offset: 0x1948
// Size: 0xa4
function zombie_think()
{
    self endon( #"death" );
    self thread do_zombie_spawn();
    self waittill( #"risen" );
    self zombie_setup_attack_properties();
    self setgoal( self.origin );
    self pathmode( "move allowed" );
    self.zombie_think_done = 1;
    self thread zombie_bad_path();
}

// Namespace infection_zombies
// Params 0
// Checksum 0xeb0ba892, Offset: 0x19f8
// Size: 0x50
function zombie_setup_attack_properties()
{
    self.ai_state = "find_flesh";
    self.ignoreall = 0;
    self.meleeattackdist = 64;
    self.maxsightdistsqrd = 16384;
    self.disablearrivals = 1;
    self.disableexits = 1;
}

// Namespace infection_zombies
// Params 1
// Checksum 0xdf5333cd, Offset: 0x1a50
// Size: 0x194
function infection_max_zombie_func( max_num )
{
    max = max_num;
    
    if ( level.round_number < 2 )
    {
        max = 8;
        
        if ( level.players.size == 4 )
        {
            max = 12;
        }
    }
    else if ( level.round_number < 3 )
    {
        max = 8;
        
        if ( level.players.size == 4 )
        {
            max = 16;
        }
    }
    else if ( level.round_number < 4 )
    {
        if ( level.players.size == 1 )
        {
            max = 10;
        }
        else if ( level.players.size == 4 )
        {
            max = 24;
        }
        else
        {
            max = 14;
        }
    }
    else if ( level.round_number < 5 )
    {
        if ( level.players.size == 1 )
        {
            max = 12;
        }
        else if ( level.players.size == 4 )
        {
            max = 32;
        }
        else
        {
            max = 20;
        }
    }
    else if ( level.round_number < 6 )
    {
        max = int( max_num * 1 );
    }
    
    return max;
}

// Namespace infection_zombies
// Params 0
// Checksum 0x582b0c84, Offset: 0x1bf0
// Size: 0x174
function infection_run_speed()
{
    self endon( #"death" );
    self.zombie_move_speed = "walk";
    n_chance = randomint( 100 );
    
    if ( level.round_number < 2 )
    {
        self.zombie_move_speed = "walk";
        
        if ( n_chance > 75 )
        {
            self.zombie_move_speed = "run";
        }
    }
    else if ( level.round_number < 3 )
    {
        self.zombie_move_speed = "walk";
        
        if ( n_chance > 50 )
        {
            self.zombie_move_speed = "run";
        }
    }
    else if ( level.round_number < 4 )
    {
        self.zombie_move_speed = "run";
        
        if ( n_chance > 95 )
        {
            self.zombie_move_speed = "sprint";
        }
    }
    else if ( level.round_number < 5 )
    {
        self.zombie_move_speed = "run";
        
        if ( n_chance > 30 )
        {
            self.zombie_move_speed = "sprint";
        }
    }
    else
    {
        self.zombie_move_speed = "sprint";
    }
    
    self thread speed_increase_over_time();
}

// Namespace infection_zombies
// Params 0
// Checksum 0x20313c0f, Offset: 0x1d70
// Size: 0x10c
function speed_increase_over_time()
{
    self endon( #"death" );
    
    if ( self.zombie_move_speed === "sprint" )
    {
        return;
    }
    
    timepassed = 0;
    starttime = gettime();
    time_segment = level.zombie_game_time * 0.4;
    
    while ( true )
    {
        if ( timepassed >= time_segment )
        {
            if ( self.zombie_move_speed === "walk" )
            {
                self zombie_utility::set_zombie_run_cycle( "run" );
            }
            else if ( self.zombie_move_speed === "run" )
            {
                self zombie_utility::set_zombie_run_cycle( "sprint" );
                return;
            }
            
            timepassed = 0;
        }
        
        wait 1;
        timepassed = ( gettime() - starttime ) / 1000;
    }
}

// Namespace infection_zombies
// Params 0
// Checksum 0xada1957e, Offset: 0x1e88
// Size: 0x280
function do_zombie_spawn()
{
    self endon( #"death" );
    zones = [];
    spots = [];
    
    if ( isdefined( level.playable_areas ) )
    {
        for ( i = 0; i < level.playable_areas.size ; i++ )
        {
            in_zone = player_in_zone( level.playable_areas[ i ] );
            
            if ( isdefined( in_zone ) && in_zone )
            {
                spots = add_zone_spawn_locations( level.playable_areas[ i ], spots );
            }
        }
        
        if ( spots.size <= 0 && isdefined( level.zombie_spawn_locations ) )
        {
            for ( i = 0; i < level.zombie_spawn_locations.size ; i++ )
            {
                if ( isdefined( level.zombie_spawn_locations[ i ].enabled ) && level.zombie_spawn_locations[ i ].enabled )
                {
                    spots[ spots.size ] = level.zombie_spawn_locations[ i ];
                }
            }
        }
    }
    else if ( isdefined( level.zombie_spawn_locations ) )
    {
        for ( i = 0; i < level.zombie_spawn_locations.size ; i++ )
        {
            if ( isdefined( level.zombie_spawn_locations[ i ].enabled ) && level.zombie_spawn_locations[ i ].enabled )
            {
                spots[ spots.size ] = level.zombie_spawn_locations[ i ];
            }
        }
    }
    
    assert( spots.size > 0, "<dev string:x44>" );
    spot = array::random( spots );
    
    if ( level.round_number < 3 )
    {
        spot = self select_barrier_spot( spots );
    }
    
    self.spawn_point = spot;
    self thread [[ level.move_spawn_func ]]( spot );
}

// Namespace infection_zombies
// Params 1
// Checksum 0x4519b680, Offset: 0x2110
// Size: 0x80, Type: bool
function player_in_zone( volume )
{
    players = getplayers();
    
    for ( j = 0; j < players.size ; j++ )
    {
        if ( players[ j ] istouching( volume ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace infection_zombies
// Params 1
// Checksum 0x549343fb, Offset: 0x2198
// Size: 0x26c
function select_barrier_spot( spots )
{
    all_spots = [];
    
    if ( isdefined( level.playable_areas ) )
    {
        for ( i = 0; i < level.playable_areas.size ; i++ )
        {
            all_spots = add_zone_spawn_locations( level.playable_areas[ i ], all_spots );
        }
    }
    
    for ( i = 0; i < all_spots.size ; i++ )
    {
        if ( isdefined( all_spots[ i ].barrier ) )
        {
            array::add( spots, all_spots[ i ], 0 );
        }
    }
    
    spots = array::randomize( spots );
    
    for ( i = 0; i < spots.size ; i++ )
    {
        if ( isdefined( spots[ i ].barrier ) && !( isdefined( spots[ i ].barrier.opened ) && spots[ i ].barrier.opened ) && !( isdefined( spots[ i ].occupied ) && spots[ i ].occupied ) )
        {
            spots[ i ].occupied = 1;
            level.barrier_occupied++;
            self thread barrier_spot_watcher( spots[ i ] );
            return spots[ i ];
        }
    }
    
    for ( i = 0; i < spots.size ; i++ )
    {
        if ( isdefined( spots[ i ].barrier.opened ) && ( !isdefined( spots[ i ].barrier ) || spots[ i ].barrier.opened ) )
        {
            return spots[ i ];
        }
    }
}

// Namespace infection_zombies
// Params 1
// Checksum 0x28558689, Offset: 0x2410
// Size: 0x5c
function barrier_spot_watcher( spot )
{
    while ( isalive( self ) && isdefined( spot.barrier ) )
    {
        wait 0.1;
    }
    
    spot.occupied = undefined;
    level.barrier_occupied--;
}

// Namespace infection_zombies
// Params 2
// Checksum 0x3d98f1b1, Offset: 0x2478
// Size: 0x10a
function add_zone_spawn_locations( zone, spots )
{
    assert( isdefined( zone.target ), "<dev string:x5d>" + zone.targetname );
    points = struct::get_array( zone.target, "targetname" );
    
    for ( i = 0; i < points.size ; i++ )
    {
        if ( isdefined( points[ i ].enabled ) && points[ i ].enabled )
        {
            array::add( spots, points[ i ], 0 );
        }
    }
    
    return spots;
}

// Namespace infection_zombies
// Params 1
// Checksum 0x1b96346a, Offset: 0x2590
// Size: 0x1ea
function move_zombie_spawn_location( spot )
{
    if ( isdefined( self.spawn_pos ) )
    {
        self notify( #"risen", self.spawn_pos.script_string );
        return;
    }
    
    self.spawn_pos = spot;
    
    if ( isdefined( spot.script_parameters ) )
    {
        self.script_parameters = spot.script_parameters;
    }
    
    if ( !isdefined( spot.script_noteworthy ) )
    {
        spot.script_noteworthy = "spawn_location";
    }
    
    if ( isdefined( spot.barrier ) && !( isdefined( spot.barrier.opened ) && spot.barrier.opened ) )
    {
        self thread do_zombie_move( spot );
        return;
    }
    
    tokens = strtok( spot.script_noteworthy, " " );
    
    foreach ( token in tokens )
    {
        if ( token == "riser_location" )
        {
            self thread do_zombie_rise( spot );
            continue;
        }
        
        self thread do_zombie_move( spot );
    }
}

// Namespace infection_zombies
// Params 1
// Checksum 0x860bc2ff, Offset: 0x2788
// Size: 0x36e
function do_zombie_move( spot )
{
    if ( isdefined( spot.barrier ) && !( isdefined( spot.barrier.opened ) && spot.barrier.opened ) )
    {
        pos = spot.barrier;
    }
    else
    {
        pos = spot;
    }
    
    self.anchor = spawn( "script_origin", self.origin );
    self.anchor.angles = self.angles;
    self linkto( self.anchor );
    
    if ( !isdefined( pos.angles ) )
    {
        pos.angles = ( 0, 0, 0 );
    }
    
    self ghost();
    self.anchor moveto( pos.origin, 0.05 );
    self.anchor rotateto( ( 0, pos.angles[ 1 ], 0 ), 0.05 );
    self.anchor waittill( #"movedone" );
    target_org = zombie_utility::get_desired_origin();
    
    if ( isdefined( target_org ) )
    {
        anim_ang = vectortoangles( target_org - self.origin );
        self.anchor rotateto( ( 0, anim_ang[ 1 ], 0 ), 0.05 );
        self.anchor waittill( #"rotatedone" );
    }
    
    if ( isdefined( level.zombie_spawn_fx ) )
    {
        playfx( level.zombie_spawn_fx, pos.origin );
    }
    
    self unlink();
    
    if ( isdefined( self.anchor ) )
    {
        self.anchor delete();
    }
    
    if ( isdefined( spot.barrier ) && pos == spot.barrier )
    {
        playfx( level._effect[ "lightning_dog_spawn" ], self.origin );
        self show();
        self thread zombie_to_barrier( spot );
        return;
    }
    
    self show();
    self notify( #"risen", spot.script_string );
}

// Namespace infection_zombies
// Params 1
// Checksum 0x88fb1011, Offset: 0x2b00
// Size: 0x3f6
function do_zombie_rise( spot )
{
    self endon( #"death" );
    self.in_the_ground = 1;
    
    if ( isdefined( self.anchor ) )
    {
        self.anchor delete();
    }
    
    self.anchor = spawn( "script_origin", self.origin );
    self.anchor.angles = self.angles;
    self linkto( self.anchor );
    
    if ( !isdefined( spot.angles ) )
    {
        spot.angles = ( 0, 0, 0 );
    }
    
    anim_org = spot.origin;
    anim_ang = spot.angles;
    anim_org += ( 0, 0, 0 );
    self ghost();
    self.anchor moveto( anim_org, 0.05 );
    self.anchor waittill( #"movedone" );
    target_org = zombie_utility::get_desired_origin();
    
    if ( isdefined( target_org ) )
    {
        anim_ang = vectortoangles( target_org - self.origin );
        self.anchor rotateto( ( 0, anim_ang[ 1 ], 0 ), 0.05 );
        self.anchor waittill( #"rotatedone" );
    }
    
    self unlink();
    
    if ( isdefined( self.anchor ) )
    {
        self.anchor delete();
    }
    
    self thread zombie_utility::hide_pop();
    level thread zombie_utility::zombie_rise_death( self, spot );
    spot thread zombie_rise_fx( self );
    
    if ( !isdefined( self.zombie_move_speed ) )
    {
        self.zombie_move_speed = "walk";
    }
    
    substate = 0;
    
    if ( self.zombie_move_speed == "walk" )
    {
        substate = randomint( 2 );
    }
    else if ( self.zombie_move_speed == "run" )
    {
        substate = 2;
    }
    else if ( self.zombie_move_speed == "sprint" )
    {
        substate = 3;
    }
    
    self orientmode( "face default" );
    self animscripted( "rise_anim", self.origin, self.angles, "ai_zombie_traverse_ground_climbout_fast" );
    self zombie_shared::donotetracks( "rise_anim", &zombie_utility::handle_rise_notetracks, spot );
    self notify( #"rise_anim_finished" );
    spot notify( #"stop_zombie_rise_fx" );
    self.in_the_ground = 0;
    self notify( #"risen", spot.script_string );
}

// Namespace infection_zombies
// Params 1
// Checksum 0xdc404ad, Offset: 0x2f00
// Size: 0x4c
function zombie_rise_fx( zombie )
{
    zombie endon( #"death" );
    self endon( #"stop_zombie_rise_fx" );
    self endon( #"rise_anim_finished" );
    zombie clientfield::set( "zombie_riser_fx", 1 );
}

// Namespace infection_zombies
// Params 1
// Checksum 0x18e8b910, Offset: 0x2f58
// Size: 0x318
function zombie_death_event( zombie )
{
    zombie.marked_for_recycle = 0;
    force_explode = 0;
    force_head_gib = 0;
    zombie waittill( #"death", attacker );
    time_of_death = gettime();
    
    if ( isdefined( zombie ) )
    {
        zombie stopsounds();
    }
    
    if ( isdefined( zombie ) && isdefined( zombie.marked_for_insta_upgraded_death ) )
    {
        force_head_gib = 1;
    }
    
    if ( !isdefined( zombie.damagehit_origin ) && isdefined( attacker ) && isalive( attacker ) )
    {
        zombie.damagehit_origin = attacker.origin;
    }
    
    if ( !isdefined( zombie ) )
    {
        return;
    }
    
    level.total_zombies_killed++;
    name = zombie.animname;
    
    if ( isdefined( zombie.sndname ) )
    {
        name = zombie.sndname;
    }
    
    zombie thread zombie_utility::zombie_eye_glow_stop();
    
    if ( isactor( zombie ) )
    {
        if ( zombie.damagemod == "MOD_GRENADE" || zombie.damagemod == "MOD_GRENADE_SPLASH" || zombie.damagemod == "MOD_EXPLOSIVE" || force_explode == 1 )
        {
            splode_dist = 180;
            
            if ( isdefined( zombie.damagehit_origin ) && distancesquared( zombie.origin, zombie.damagehit_origin ) < splode_dist * splode_dist )
            {
                tag = "J_SpineLower";
                
                if ( !( isdefined( zombie.is_on_fire ) && zombie.is_on_fire ) && !( isdefined( zombie.guts_explosion ) && zombie.guts_explosion ) )
                {
                    zombie thread zombie_utility::zombie_gut_explosion();
                }
            }
        }
    }
    
    if ( isdefined( zombie.attacker ) && isplayer( zombie.attacker ) )
    {
        zombie.attacker notify( #"zom_kill", zombie );
    }
    
    level notify( #"zom_kill" );
    level.total_zombies_killed++;
}

// Namespace infection_zombies
// Params 0
// Checksum 0xbe485ca9, Offset: 0x3278
// Size: 0x15c, Type: bool
function zombie_death_animscript()
{
    team = undefined;
    
    if ( isdefined( self._race_team ) )
    {
        team = self._race_team;
    }
    
    self zombie_utility::reset_attack_spot();
    
    if ( isdefined( level.zombie_death_animscript_override ) )
    {
        self [[ level.zombie_death_animscript_override ]]();
    }
    
    if ( !self.missinglegs && isdefined( self.a.gib_ref ) && self.a.gib_ref == "no_legs" )
    {
        self.deathanim = "zm_death";
    }
    
    self.grenadeammo = 0;
    
    if ( isdefined( self.attacker ) && isai( self.attacker ) )
    {
        self.attacker notify( #"killed", self );
    }
    
    if ( self.damagemod == "MOD_BURNED" )
    {
        self thread zombie_death::flame_death_fx();
    }
    
    if ( self.damagemod == "MOD_GRENADE" || self.damagemod == "MOD_GRENADE_SPLASH" )
    {
        level notify( #"zombie_grenade_death", self.origin );
    }
    
    return false;
}

// Namespace infection_zombies
// Params 1
// Checksum 0x53cc7be8, Offset: 0x33e0
// Size: 0x3b2
function sarah_at_stalingrad( a_ents )
{
    level endon( #"end_game" );
    level endon( #"game_ended" );
    level endon( #"zombies_completed" );
    level waittill( #"start_zombie_sequence" );
    level thread namespace_99d8554b::function_faa82017();
    level thread zombie_fire_wall_init();
    level thread zombie_barriers_init();
    level.barrier_occupied = 0;
    starttime = gettime();
    
    if ( level.players.size > 2 )
    {
        level.zombie_total_min = int( 1 * level.players.size );
    }
    
    level thread round_think();
    level.pavlov_sarah thread hideout_outro::pavlovs_temp_messages();
    level clientfield::set( "zombie_root_grow", 1 );
    level.overrideplayerdamage = &function_c013c278;
    level flag::wait_till( "zombies_final_round" );
    infection_accolades::function_e9c21474();
    level.overrideplayerdamage = &function_56f9ab2e;
    level waittill( #"sarah_begs_death" );
    level.pavlov_sarah scene::play( "cin_inf_16_01_zombies_vign_treemoment_talk02", level.pavlov_sarah );
    
    if ( isdefined( level.bzm_infectiondialogue23callback ) )
    {
        level thread [[ level.bzm_infectiondialogue23callback ]]();
    }
    
    level.pavlov_sarah cybercom::cybercom_aioptout( "cybercom_sensoryoverload" );
    level.pavlov_sarah clientfield::set( "sarah_body_light", 1 );
    level.pavlov_sarah thread scene::play( "cin_inf_16_01_zombies_vign_treemoment_outro", level.pavlov_sarah );
    level.pavlov_sarah notify( #"running_out" );
    level waittill( #"sarah_at_tree" );
    objectives::complete( "cp_level_infection_zombies" );
    objectives::set( "cp_level_infection_escape", level.pavlov_sarah );
    level flag::set( "sarah_tree" );
    level.pavlov_sarah infection_util::light_flash_bright( 1 );
    level.pavlov_sarah util::stop_magic_bullet_shield();
    level.pavlov_sarah setteam( "axis" );
    level.pavlov_sarah.allowpain = 1;
    level.pavlov_sarah.health = 9999;
    level.pavlov_sarah.overrideactordamage = &callback_sarah_damaged;
    level.pavlov_sarah waittill( #"death" );
    level.overrideplayerdamage = undefined;
    level flag::set( "zombies_completed" );
    level notify( #"end_round_think" );
}

// Namespace infection_zombies
// Params 13
// Checksum 0x3f1aecb3, Offset: 0x37a0
// Size: 0x154
function callback_sarah_damaged( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname )
{
    self.overrideactordamage = undefined;
    
    if ( weapon.type == "grenade" )
    {
        infection_accolades::function_cce60169();
    }
    
    objectives::complete( "cp_level_infection_escape", self );
    self infection_util::light_flash_bright( 0 );
    self clientfield::set( "exploding_ai_deaths", 1 );
    util::wait_network_frame();
    self ghost();
    self scene::stop( "cin_inf_16_01_zombies_vign_treemoment_outro" );
    self kill();
}

// Namespace infection_zombies
// Params 0
// Checksum 0x277d805f, Offset: 0x3900
// Size: 0x1c4
function pause_zombie_spawning()
{
    level flag::clear( "spawn_zombies" );
    timepassed = 0;
    starttime = gettime();
    
    while ( zombie_utility::get_current_zombie_count() > 0 )
    {
        zombies = getaiteamarray( "axis" );
        
        for ( i = 0; i < zombies.size ; i++ )
        {
            if ( !( isdefined( zombies[ i ] infection_util::player_can_see_me( 256 ) ) && zombies[ i ] infection_util::player_can_see_me( 256 ) ) )
            {
                zombies[ i ] kill();
            }
        }
        
        timepassed = ( gettime() - starttime ) / 1000;
        
        if ( timepassed >= 30 )
        {
            zombies = getaiteamarray( "axis" );
            
            for ( i = 0; i < zombies.size ; i++ )
            {
                zombies[ i ] kill();
            }
            
            return;
        }
        
        wait 0.1;
    }
    
    level flag::set( "spawn_zombies" );
}

// Namespace infection_zombies
// Params 0
// Checksum 0x68a2a96b, Offset: 0x3ad0
// Size: 0xe6
function kill_all_zombies()
{
    level flag::clear( "spawn_zombies" );
    zombies = getaiteamarray( "axis" );
    
    for ( i = 0; i < zombies.size ; i++ )
    {
        if ( !issubstr( zombies[ i ].targetname, "sarah" ) )
        {
            zombies[ i ] dodamage( zombies[ i ].health + 100, zombies[ i ].origin );
        }
    }
}

// Namespace infection_zombies
// Params 1
// Checksum 0xa369761, Offset: 0x3bc0
// Size: 0xe8
function check_round_timing( starttime )
{
    level endon( #"end_game" );
    level endon( #"game_ended" );
    n_game_period = level.zombie_game_time / 4;
    starttime = 0;
    n_timepassed = 0;
    
    while ( n_timepassed < level.zombie_game_time )
    {
        level waittill( #"between_round_over" );
        n_timepassed = ( gettime() - starttime ) / 1000;
        n_gametime = int( n_timepassed / n_game_period );
        
        if ( level.round_number < n_gametime )
        {
            if ( n_gametime > 4 )
            {
                n_gametime = 4;
            }
            
            level.round_number = n_gametime;
        }
    }
}

// Namespace infection_zombies
// Params 11
// Checksum 0xb6ddb25f, Offset: 0x3cb0
// Size: 0xd0
function function_c013c278( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime )
{
    if ( isdefined( eattacker.is_zombie ) && isdefined( eattacker ) && eattacker.is_zombie )
    {
        self playlocalsound( "evt_player_swiped" );
        
        if ( isdefined( eattacker.meleedamage ) )
        {
            idamage = eattacker.meleedamage;
        }
    }
    
    return idamage;
}

// Namespace infection_zombies
// Params 11
// Checksum 0x6ba4a2e4, Offset: 0x3d88
// Size: 0xfa
function function_56f9ab2e( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime )
{
    if ( isdefined( eattacker ) )
    {
        if ( !isdefined( self.numhits ) )
        {
            self.numhits = 0;
        }
        
        self.numhits++;
        
        if ( eattacker.script_hazard === "heat" )
        {
            return;
        }
        
        if ( self.health < self.maxhealth / 2 || self.numhits === 5 )
        {
            idamage = 0;
            level thread sarah_flash_kill();
        }
    }
    
    return idamage;
}

// Namespace infection_zombies
// Params 1
// Checksum 0xd9c0e31e, Offset: 0x3e90
// Size: 0x12e
function sarah_flash_kill( var_67e5f9c0 )
{
    if ( !isdefined( var_67e5f9c0 ) )
    {
        var_67e5f9c0 = 1;
    }
    
    wait 1;
    
    if ( var_67e5f9c0 )
    {
        level thread lui::screen_fade( 0.2, 0.8, 1, "white" );
        playsoundatposition( "evt_infection_thunder_special", ( 0, 0, 0 ) );
    }
    
    level flag::clear( "spawn_zombies" );
    level thread kill_all_zombies();
    wait 0.5;
    level thread namespace_99d8554b::function_973b77f9();
    
    if ( var_67e5f9c0 )
    {
        level thread lui::screen_fade( 1, 0, 0.8, "white" );
    }
    
    wait 1;
    level thread namespace_99d8554b::function_3d7fd2ca();
    wait 2;
    level notify( #"sarah_begs_death" );
}

// Namespace infection_zombies
// Params 0
// Checksum 0xcf3a5dd6, Offset: 0x3fc8
// Size: 0x226
function round_think()
{
    level endon( #"end_round_think" );
    level endon( #"end_game" );
    level endon( #"game_ended" );
    setroundsplayed( level.round_number );
    
    if ( level.players.size == 1 )
    {
        level.zombie_ai_limit = 28;
    }
    
    while ( true )
    {
        while ( level.zombie_spawn_locations.size <= 0 )
        {
            wait 0.1;
        }
        
        level thread round_spawning();
        level notify( #"start_of_round" );
        
        /#
            iprintlnbold( "<dev string:x87>", level.round_number );
        #/
        
        round_wait();
        level flag::wait_till( "spawn_zombies" );
        level.first_round = 0;
        level notify( #"end_of_round" );
        
        if ( level.round_number >= 4 )
        {
            level.pavlov_sarah pause_zombie_spawning();
            level notify( #"sarah_speaks_surge" );
        }
        
        timer = level.zombie_vars[ "zombie_spawn_delay" ];
        
        if ( timer > 0.08 )
        {
            level.zombie_vars[ "zombie_spawn_delay" ] = timer * 0.95;
        }
        else if ( timer < 0.08 )
        {
            level.zombie_vars[ "zombie_spawn_delay" ] = 0.08;
        }
        
        level.round_number++;
        setroundsplayed( level.round_number );
        level round_over();
        savegame::checkpoint_save();
        level notify( #"between_round_over" );
    }
}

// Namespace infection_zombies
// Params 0
// Checksum 0xe8a5551, Offset: 0x41f8
// Size: 0x50
function round_over()
{
    time = level.zombie_vars[ "zombie_between_round_time" ];
    
    if ( level.players.size == 4 )
    {
        time *= 0.25;
    }
    
    wait time;
}

// Namespace infection_zombies
// Params 0
// Checksum 0x588790e2, Offset: 0x4250
// Size: 0x8c
function round_wait()
{
    level endon( #"restart_round" );
    wait 1;
    
    while ( true )
    {
        should_wait = zombie_utility::get_current_zombie_count() > level.zombie_total_min || level.zombie_total > level.zombie_total_min;
        
        if ( !should_wait )
        {
            return;
        }
        
        if ( level flag::get( "end_round_wait" ) )
        {
            return;
        }
        
        wait 1;
    }
}

// Namespace infection_zombies
// Params 0
// Checksum 0x75673b72, Offset: 0x42e8
// Size: 0x3e8
function round_spawning()
{
    level endon( #"end_of_round" );
    
    if ( level.zombie_spawn_locations.size < 1 )
    {
        assertmsg( "<dev string:x95>" );
        return;
    }
    
    count = 0;
    max = level.zombie_ai_limit;
    multiplier = level.round_number / 5;
    
    if ( multiplier < 1 )
    {
        multiplier = 1;
    }
    
    if ( level flag::get( "sarah_tree" ) )
    {
        multiplier *= level.round_number * 0.15;
    }
    
    player_num = getplayers().size;
    
    if ( player_num == 1 )
    {
        max = int( max * multiplier );
    }
    else
    {
        max += int( ( player_num - 1 ) * level.zombie_vars[ "zombie_ai_per_player" ] * multiplier );
    }
    
    if ( !isdefined( level.max_zombie_func ) )
    {
        level.max_zombie_func = &zombie_utility::default_max_zombie_func;
    }
    
    old_total = level.zombie_total;
    level.zombie_total = [[ level.max_zombie_func ]]( max );
    level.zombie_total += old_total;
    level notify( #"zombie_total_set" );
    
    if ( level.round_number < 10 || level.speed_change_max > 0 )
    {
        level thread zombie_utility::zombie_speed_up();
    }
    
    while ( true )
    {
        while ( zombie_utility::get_current_zombie_count() >= level.zombie_ai_limit || level.zombie_total <= 0 )
        {
            wait 0.1;
        }
        
        while ( zombie_utility::get_current_actor_count() >= level.zombie_actor_limit )
        {
            zombie_utility::clear_all_corpses();
            wait 0.1;
        }
        
        level flag::wait_till( "spawn_zombies" );
        
        while ( level.zombie_spawn_locations.size <= 0 )
        {
            wait 0.1;
        }
        
        if ( isdefined( level.zombie_spawners ) )
        {
            spawner = array::random( level.zombie_spawners );
            ai = zombie_utility::spawn_zombie( spawner, spawner.targetname );
        }
        
        if ( isdefined( ai ) )
        {
            level.zombie_total--;
            ai thread zombie_utility::round_spawn_failsafe();
            count++;
        }
        
        time = level.zombie_vars[ "zombie_spawn_delay" ];
        
        if ( level.round_number == 1 )
        {
            time = level.zombie_vars[ "zombie_spawn_delay" ] * 0.25;
        }
        
        if ( level.players.size == 4 )
        {
            time *= 0.15;
        }
        
        wait time;
        util::wait_network_frame();
    }
}

// Namespace infection_zombies
// Params 0
// Checksum 0xcc6c8ddf, Offset: 0x46d8
// Size: 0x1a8
function zombie_bad_path()
{
    self endon( #"death" );
    self.b_zombie_path_bad = 0;
    level.a_s_zombie_escape = struct::get_array( "zombie_escape_point", "targetname" );
    
    while ( true )
    {
        if ( !self.b_zombie_path_bad )
        {
            while ( self can_zombie_see_any_player() )
            {
                wait 0.5;
            }
        }
        
        found_player = undefined;
        
        foreach ( e_player in level.players )
        {
            if ( isdefined( zombie_utility::is_player_valid( e_player ) ) && zombie_utility::is_player_valid( e_player ) && self maymovetopoint( e_player.origin, 1 ) )
            {
                self.favoriteenemy = e_player;
                found_player = 1;
            }
        }
        
        if ( !isdefined( found_player ) )
        {
            self.b_zombie_path_bad = 1;
            self escaped_zombies_cleanup();
        }
        
        wait 0.1;
    }
}

// Namespace infection_zombies
// Params 0, eflags: 0x4
// Checksum 0x63650f51, Offset: 0x4888
// Size: 0x10c
function private escaped_zombies_cleanup()
{
    self endon( #"death" );
    s_escape = self get_escape_position();
    self notify( #"stop_find_flesh" );
    self notify( #"zombie_acquire_enemy" );
    self ai::set_ignoreall( 1 );
    
    if ( isdefined( s_escape ) )
    {
        self setgoalpos( s_escape.origin );
        self thread check_player_available();
        self util::waittill_any( "goal", "reaquire_player" );
    }
    
    wait 0.1;
    
    if ( !self.b_zombie_path_bad )
    {
        self.ai_state = "find_flesh";
        self ai::set_ignoreall( 0 );
    }
}

// Namespace infection_zombies
// Params 0, eflags: 0x4
// Checksum 0x1e151eee, Offset: 0x49a0
// Size: 0x3c
function private get_escape_position()
{
    self endon( #"death" );
    s_farthest = self get_farthest_location( level.a_s_zombie_escape );
    return s_farthest;
}

// Namespace infection_zombies
// Params 1, eflags: 0x4
// Checksum 0x7072c016, Offset: 0x49e8
// Size: 0xbe
function private get_farthest_location( locations )
{
    n_farthest_index = 0;
    n_distance_farthest = 0;
    
    for ( i = 0; i < locations.size ; i++ )
    {
        n_distance_sq = distancesquared( self.origin, locations[ i ].origin );
        
        if ( n_distance_sq > n_distance_farthest )
        {
            n_distance_farthest = n_distance_sq;
            n_farthest_index = i;
        }
    }
    
    return locations[ n_farthest_index ];
}

// Namespace infection_zombies
// Params 0, eflags: 0x4
// Checksum 0x574b74da, Offset: 0x4ab0
// Size: 0x9c
function private check_player_available()
{
    self notify( #"_check_player_available" );
    self endon( #"_check_player_available" );
    self endon( #"death" );
    self endon( #"goal" );
    
    while ( self.b_zombie_path_bad )
    {
        wait randomfloatrange( 0.2, 0.5 );
        
        if ( self can_zombie_see_any_player() )
        {
            self.b_zombie_path_bad = 0;
            self notify( #"reaquire_player" );
            return;
        }
    }
}

// Namespace infection_zombies
// Params 0, eflags: 0x4
// Checksum 0xcc06dca7, Offset: 0x4b58
// Size: 0xa8, Type: bool
function private can_zombie_see_any_player()
{
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( !zombie_utility::is_player_valid( level.players[ i ] ) )
        {
            continue;
        }
        
        player_origin = level.players[ i ].origin;
        
        if ( self findpath( self.origin, player_origin, 1, 0 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace infection_zombies
// Params 0
// Checksum 0x6d03f538, Offset: 0x4c08
// Size: 0x4a2
function zombie_fire_wall_init()
{
    t_fire_trig = getent( "pavlov_house_fire", "targetname" );
    assert( isdefined( t_fire_trig ), "<dev string:xfa>" );
    t_fire_warning_trig = getent( "pavlov_house_fire_warning", "targetname" );
    wall_pos = struct::get( "firewall_align", "targetname" );
    assert( isdefined( wall_pos ), "<dev string:x115>" );
    e_fire_wall = util::spawn_model( "tag_origin", wall_pos.origin, wall_pos.angles );
    e_fire_wall.targetname = "firewall_firepos";
    e_fire_wall clientfield::set( "zombie_fire_wall_fx", 1 );
    e_fire_wall clientfield::set( "zombie_fire_backdraft_fx", 1 );
    fxpos = struct::get_array( "zombie_fire_wall", "targetname" );
    
    foreach ( pos in fxpos )
    {
        firepos = util::spawn_model( "tag_origin", pos.origin, pos.angles );
        firepos linkto( e_fire_wall );
        firepos.targetname = "firewall_firepos";
        firepos clientfield::set( "zombie_fire_wall_fx", 1 );
    }
    
    t_fire_trig enablelinkto();
    t_fire_trig linkto( e_fire_wall );
    t_fire_warning_trig enablelinkto();
    t_fire_warning_trig linkto( e_fire_wall );
    final_pos = struct::get( "final_fire_pos", "targetname" );
    
    if ( !isdefined( final_pos ) )
    {
        pos = ( e_fire_wall.origin[ 0 ] - 1292, e_fire_wall.origin[ 1 ], e_fire_wall.origin[ 2 ] );
    }
    else
    {
        pos = final_pos.origin;
    }
    
    time = level.zombie_game_time * 0.75;
    
    if ( isdefined( level.city_skipped ) && level.city_skipped )
    {
        time = 0.1;
    }
    
    e_fire_wall moveto( pos, time );
    t_fire_trig thread zombie_fire_watcher();
    exploder::exploder( "zombies_fire_transition" );
    
    foreach ( player in level.players )
    {
        player thread player_fire_damage( t_fire_trig, t_fire_warning_trig );
    }
}

// Namespace infection_zombies
// Params 0
// Checksum 0xd2725022, Offset: 0x50b8
// Size: 0x228
function zombie_fire_watcher()
{
    self endon( #"death" );
    num_on_fire = 0;
    var_52128914 = 0;
    
    while ( true )
    {
        a_zombies = getaiteamarray( "axis" );
        num_on_fire = a_zombies num_zombies_on_fire();
        var_52128914 = a_zombies function_499c7bc4();
        
        if ( num_on_fire < 12 )
        {
            for ( i = 0; i < a_zombies.size ; i++ )
            {
                if ( a_zombies[ i ] istouching( self ) && !( isdefined( a_zombies[ i ].on_fire ) && a_zombies[ i ].on_fire ) && num_on_fire < 12 )
                {
                    a_zombies[ i ].on_fire = 1;
                    a_zombies[ i ].var_e686b755 = 1;
                    num_on_fire++;
                    a_zombies[ i ] thread set_zombie_on_fire();
                }
                
                if ( !( isdefined( a_zombies[ i ].on_fire ) && a_zombies[ i ].on_fire ) && a_zombies[ i ] function_1a9db234() && num_on_fire < 12 )
                {
                    a_zombies[ i ].on_fire = 1;
                    num_on_fire++;
                    var_52128914++;
                    a_zombies[ i ] thread set_zombie_on_fire();
                }
            }
        }
        
        wait 1;
    }
}

// Namespace infection_zombies
// Params 0
// Checksum 0x39f32976, Offset: 0x52e8
// Size: 0x11c, Type: bool
function function_1a9db234()
{
    self endon( #"death" );
    a_zombies = getaiteamarray( "axis" );
    
    foreach ( zombie in a_zombies )
    {
        n_dist = distance2dsquared( self.origin, zombie.origin );
        
        if ( isdefined( zombie.on_fire ) && self != zombie && n_dist < 2500 && zombie.on_fire )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace infection_zombies
// Params 0
// Checksum 0x5de0f09f, Offset: 0x5410
// Size: 0x72
function num_zombies_on_fire()
{
    num = 0;
    
    for ( i = 0; i < self.size ; i++ )
    {
        if ( isdefined( self[ i ].on_fire ) && self[ i ].on_fire )
        {
            num++;
        }
    }
    
    return num;
}

// Namespace infection_zombies
// Params 0
// Checksum 0x556c59d5, Offset: 0x5490
// Size: 0xa0
function function_499c7bc4()
{
    num = 0;
    
    for ( i = 0; i < self.size ; i++ )
    {
        if ( isdefined( self[ i ].on_fire ) && self[ i ].on_fire && !( isdefined( self[ i ].var_e686b755 ) && self[ i ].var_e686b755 ) )
        {
            num++;
        }
    }
    
    return num;
}

// Namespace infection_zombies
// Params 0
// Checksum 0xc221f686, Offset: 0x5538
// Size: 0xfc
function set_zombie_on_fire()
{
    self endon( #"death" );
    chance = randomint( 10 );
    self playloopsound( "chr_burn_start_loop", 1 );
    
    if ( chance <= 2 )
    {
        playfxontag( level._effect[ "burn_loop_zombie_left_arm" ], self, "J_Elbow_LE" );
        return;
    }
    
    if ( chance <= 5 )
    {
        playfxontag( level._effect[ "burn_loop_zombie_right_arm" ], self, "J_Elbow_RI" );
        return;
    }
    
    playfxontag( level._effect[ "burn_loop_zombie_torso" ], self, "J_Spine4" );
}

// Namespace infection_zombies
// Params 2
// Checksum 0x3199bb5e, Offset: 0x5640
// Size: 0x18c
function player_fire_damage( var_7b08f0da, var_a5765dcf )
{
    self endon( #"death" );
    
    if ( !isdefined( self.sndfireent ) )
    {
        self.sndfireent = spawn( "script_origin", self.origin );
        self.sndfireent linkto( self );
    }
    
    while ( true )
    {
        var_a5765dcf waittill( #"trigger", who );
        
        if ( who == self )
        {
            while ( self istouching( var_7b08f0da ) || self istouching( var_a5765dcf ) || isdefined( var_7b08f0da ) && isdefined( var_a5765dcf ) && self.health != self.maxhealth )
            {
                self.sndfireent playloopsound( "chr_burn_start_loop", 0.5 );
                wait 0.1;
            }
            
            self clientfield::set( "burn", 0 );
            self.sndfireent stoploopsound( 1 );
            
            if ( !isdefined( var_a5765dcf ) || !isdefined( var_7b08f0da ) )
            {
                break;
            }
        }
        
        wait 0.1;
    }
}

// Namespace infection_zombies
// Params 0
// Checksum 0xcf32e04c, Offset: 0x57d8
// Size: 0x5be
function zombie_barriers_init()
{
    level thread scene::init( "p7_fxanim_cp_infection_house_ceiling_enter_01_bundle" );
    level thread scene::init( "p7_fxanim_cp_infection_house_ceiling_enter_02_bundle" );
    level thread scene::init( "p7_fxanim_cp_infection_house_wall_enter_01_bundle" );
    level thread scene::init( "p7_fxanim_cp_infection_house_wall_enter_02_bundle" );
    level.barriers = struct::get_array( "zombie_barrier", "targetname" );
    
    foreach ( barrier in level.barriers )
    {
        barrier.scenes = [];
        
        if ( isdefined( level.city_skipped ) && level.city_skipped )
        {
            level thread scene::skipto_end( "p7_fxanim_cp_infection_house_ceiling_enter_01_bundle" );
            level thread scene::skipto_end( "p7_fxanim_cp_infection_house_ceiling_enter_02_bundle" );
            level thread scene::skipto_end( "p7_fxanim_cp_infection_house_wall_enter_01_bundle" );
            level thread scene::skipto_end( "p7_fxanim_cp_infection_house_wall_enter_02_bundle" );
            parts = getentarray( barrier.target, "targetname" );
            
            for ( i = 0; i < parts.size ; i++ )
            {
                parts[ i ] hide();
                parts[ i ] notsolid();
            }
            
            barrier.opened = 1;
            continue;
        }
        
        parts = getentarray( barrier.target, "targetname" );
        
        for ( i = 0; i < parts.size ; i++ )
        {
            if ( parts[ i ].script_noteworthy === "lookat_barrier" )
            {
                barrier.look_trig = parts[ i ];
                continue;
            }
            
            if ( parts[ i ].script_noteworthy === "clip" )
            {
                barrier.clip = parts[ i ];
            }
        }
        
        a_bundle = struct::get_array( barrier.target, "targetname" );
        
        for ( i = 0; i < a_bundle.size ; i++ )
        {
            if ( a_bundle[ i ].script_noteworthy === "tearin_bundle" )
            {
                a_bundle[ i ] scene::init( a_bundle[ i ].scriptbundlename );
                array::add( barrier.scenes, a_bundle[ i ], 0 );
            }
        }
        
        for ( i = 0; i < level.zombie_spawn_locations.size ; i++ )
        {
            if ( level.zombie_spawn_locations[ i ].script_linkto === barrier.script_string )
            {
                level.zombie_spawn_locations[ i ].barrier = barrier;
                break;
            }
        }
        
        type = barrier.script_noteworthy;
        
        switch ( type )
        {
            default:
                barrier.bundlename = "cin_inf_16_01_zombies_vign_tearins_wallbreak_pull_";
                barrier.num_parts = 2;
                
                if ( barrier.script_string === "wall_barrier1" )
                {
                    barrier.fxanim = "p7_fxanim_cp_infection_house_wall_enter_01_bundle";
                }
                else
                {
                    barrier.fxanim = "p7_fxanim_cp_infection_house_wall_enter_02_bundle";
                }
                
                break;
            case "ceiling_filler_bedroom":
                barrier.bundlename = "cin_inf_16_01_zombies_vign_tearins_ceiling_bedroom_pull_";
                barrier.fxanim = "p7_fxanim_cp_infection_house_ceiling_enter_01_bundle";
                barrier.num_parts = 4;
                break;
            case "ceiling_filler_frontroom":
                barrier.bundlename = "cin_inf_16_01_zombies_vign_tearins_ceiling_frontroom_pull_";
                barrier.fxanim = "p7_fxanim_cp_infection_house_ceiling_enter_02_bundle";
                barrier.num_parts = 4;
                break;
        }
        
        barrier.opened = 0;
    }
}

// Namespace infection_zombies
// Params 1
// Checksum 0xbce07902, Offset: 0x5da0
// Size: 0x21c
function zombie_to_barrier( spot )
{
    barrier_pos = spot.barrier;
    assert( isdefined( barrier_pos ), "<dev string:x135>" );
    
    if ( isdefined( barrier_pos.opened ) && barrier_pos.opened )
    {
        self notify( #"risen", spot.script_string );
        return;
    }
    
    self endon( #"death" );
    self.favoriteenemy = undefined;
    goalradius_old = self.goalradius;
    self.goalradius = 4;
    self setgoal( barrier_pos.origin, 1 );
    self waittill( #"goal" );
    self pathmode( "dont move" );
    self.goalradius = goalradius_old;
    self.is_inert = 1;
    
    if ( isdefined( barrier_pos.look_trig ) )
    {
        barrier_pos trigger_wait_timeout( 30 );
    }
    
    if ( barrier_pos.script_noteworthy === "door_filler" || barrier_pos.script_noteworthy === "window_filler" )
    {
        self thread zombie_scriptbundle_barrier( spot );
        return;
    }
    
    if ( isdefined( barrier_pos.script_noteworthy ) )
    {
        self thread play_zombie_barrier_anim( spot );
        self waittill( #"barrier_note" );
        
        if ( isdefined( barrier_pos.fxanim ) )
        {
            level thread scene::play( barrier_pos.fxanim );
        }
    }
}

// Namespace infection_zombies
// Params 1
// Checksum 0x3ad95d31, Offset: 0x5fc8
// Size: 0x1ee
function play_zombie_barrier_anim( spot )
{
    barrier_pos = spot.barrier;
    self endon( #"death" );
    
    if ( !isdefined( barrier_pos.anim_num ) )
    {
        barrier_pos.anim_num = 1;
    }
    
    self forceteleport( barrier_pos.origin, barrier_pos.angles );
    
    while ( !( isdefined( barrier_pos.opened ) && barrier_pos.opened ) )
    {
        self thread scene::play( barrier_pos.bundlename + barrier_pos.anim_num, self );
        notetrack = "destroy_piece";
        self waittill( notetrack );
        self notify( #"barrier_note" );
        self waittill( #"scene_done" );
        
        if ( barrier_pos.anim_num < barrier_pos.num_parts )
        {
            barrier_pos.anim_num++;
            continue;
        }
        
        barrier_pos.opened = 1;
    }
    
    self notify( #"risen", spot.script_string );
    self.is_inert = 0;
    
    if ( isdefined( barrier_pos.clip ) )
    {
        barrier_pos.clip notsolid();
        barrier_pos.clip connectpaths();
    }
    
    spot.barrier = undefined;
    spot.occupied = undefined;
}

// Namespace infection_zombies
// Params 1
// Checksum 0xfba7d492, Offset: 0x61c0
// Size: 0x278
function zombie_scriptbundle_barrier( spot )
{
    self endon( #"death" );
    barrier_pos = spot.barrier;
    self forceteleport( barrier_pos.origin, barrier_pos.angles );
    
    while ( barrier_pos.scenes.size > 0 )
    {
        if ( !isdefined( barrier_pos.scene_num ) )
        {
            barrier_pos.scene_num = 1;
        }
        
        for ( i = 0; i < barrier_pos.scenes.size ; i++ )
        {
            if ( issubstr( barrier_pos.scenes[ i ].scriptbundlename, "_" + barrier_pos.scene_num ) )
            {
                str_scene = barrier_pos.scenes[ i ].scriptbundlename;
                s_scene = barrier_pos.scenes[ i ];
                break;
            }
        }
        
        s_scene thread scene::play( str_scene, self );
        s_scene util::waittill_notify_or_timeout( "scene_done", 5 );
        barrier_pos.scene_num++;
        arrayremovevalue( barrier_pos.scenes, s_scene );
    }
    
    self notify( #"risen", spot.script_string );
    self.is_inert = 0;
    
    if ( isdefined( barrier_pos.clip ) )
    {
        barrier_pos.clip notsolid();
        barrier_pos.clip connectpaths();
    }
    
    spot.barrier = undefined;
    spot.occupied = undefined;
    barrier_pos.opened = 1;
}

// Namespace infection_zombies
// Params 1
// Checksum 0x49ee1d6d, Offset: 0x6440
// Size: 0x94
function trigger_wait_timeout( time )
{
    self.look_trig thread timeout_notify( time );
    self.look_trig thread player_looked_at();
    self.look_trig util::waittill_any( "timeout", "was_seen" );
    
    if ( isdefined( self.look_trig ) )
    {
        self.look_trig delete();
    }
}

// Namespace infection_zombies
// Params 0
// Checksum 0xcb296b28, Offset: 0x64e0
// Size: 0x80
function player_looked_at()
{
    self endon( #"timeout" );
    self endon( #"was_seen" );
    
    while ( true )
    {
        self trigger::wait_till();
        
        if ( isdefined( zombie_utility::is_player_valid( self.who ) ) && zombie_utility::is_player_valid( self.who ) )
        {
            self notify( #"was_seen" );
            return;
        }
    }
}

// Namespace infection_zombies
// Params 1
// Checksum 0x49a00ee7, Offset: 0x6568
// Size: 0x6e
function timeout_notify( time )
{
    self endon( #"timeout" );
    self endon( #"was_seen" );
    end_time = gettime() + time * 1000;
    
    while ( gettime() < end_time )
    {
        wait 0.1;
        
        if ( !isdefined( self ) )
        {
            return;
        }
    }
    
    self notify( #"timeout" );
}

