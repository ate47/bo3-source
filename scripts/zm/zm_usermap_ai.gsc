#using scripts/codescripts/struct;
#using scripts/shared/ai/behavior_zombie_dog;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_ai_dogs;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/_zm_perk_deadshot;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_staminup;
#using scripts/zm/_zm_powerup_carpenter;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_powerup_fire_sale;
#using scripts/zm/_zm_powerup_free_perk;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_insta_kill;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_trap_electric;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_weap_bowie;
#using scripts/zm/_zm_weap_cymbal_monkey;
#using scripts/zm/_zm_weap_tesla;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;

#namespace zm_usermap_ai;

// Namespace zm_usermap_ai
// Params 0, eflags: 0x2
// Checksum 0x9ba6d5d1, Offset: 0x7b0
// Size: 0x80
function autoexec init()
{
    if ( !isdefined( level.pathdist_type ) )
    {
        level.pathdist_type = 2;
    }
    
    initzmfactorybehaviorsandasm();
    setdvar( "scr_zm_use_code_enemy_selection", 0 );
    level.closest_player_override = &factory_closest_player;
    level thread update_closest_player();
    level.move_valid_poi_to_navmesh = 1;
}

// Namespace zm_usermap_ai
// Params 0, eflags: 0x4
// Checksum 0xa9d7cc32, Offset: 0x838
// Size: 0x8c
function private initzmfactorybehaviorsandasm()
{
    behaviortreenetworkutility::registerbehaviortreescriptapi( "ZmFactoryTraversalService", &zmfactorytraversalservice );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "shouldMoveLowg", &shouldmovelowg );
    animationstatenetwork::registeranimationmocomp( "mocomp_idle_special_factory", &mocompidlespecialfactorystart, undefined, &mocompidlespecialfactoryterminate );
}

// Namespace zm_usermap_ai
// Params 1
// Checksum 0xcd92f5b0, Offset: 0x8d0
// Size: 0x44, Type: bool
function zmfactorytraversalservice( entity )
{
    if ( isdefined( entity.traversestartnode ) )
    {
        entity pushactors( 0 );
        return true;
    }
    
    return false;
}

// Namespace zm_usermap_ai
// Params 5, eflags: 0x4
// Checksum 0x1e3f3503, Offset: 0x920
// Size: 0x104
function private mocompidlespecialfactorystart( entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration )
{
    if ( isdefined( entity.enemyoverride ) && isdefined( entity.enemyoverride[ 1 ] ) )
    {
        entity orientmode( "face direction", entity.enemyoverride[ 1 ].origin - entity.origin );
        entity animmode( "zonly_physics", 0 );
        return;
    }
    
    entity orientmode( "face current" );
    entity animmode( "zonly_physics", 0 );
}

// Namespace zm_usermap_ai
// Params 5, eflags: 0x4
// Checksum 0x929ffa60, Offset: 0xa30
// Size: 0x2c
function private mocompidlespecialfactoryterminate( entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration )
{
    
}

// Namespace zm_usermap_ai
// Params 1
// Checksum 0xd3ddca04, Offset: 0xa68
// Size: 0x2e, Type: bool
function shouldmovelowg( entity )
{
    return isdefined( entity.low_gravity ) && entity.low_gravity;
}

// Namespace zm_usermap_ai
// Params 1, eflags: 0x4
// Checksum 0xef904743, Offset: 0xaa0
// Size: 0xfa
function private factory_validate_last_closest_player( players )
{
    if ( isdefined( self.last_closest_player.am_i_valid ) && isdefined( self.last_closest_player ) && self.last_closest_player.am_i_valid )
    {
        return;
    }
    
    self.need_closest_player = 1;
    
    foreach ( player in players )
    {
        if ( isdefined( player.am_i_valid ) && player.am_i_valid )
        {
            self.last_closest_player = player;
            return;
        }
    }
    
    self.last_closest_player = undefined;
}

// Namespace zm_usermap_ai
// Params 2, eflags: 0x4
// Checksum 0xdbea9a1e, Offset: 0xba8
// Size: 0x262
function private factory_closest_player( origin, players )
{
    if ( players.size == 0 )
    {
        return undefined;
    }
    
    if ( isdefined( self.zombie_poi ) )
    {
        return undefined;
    }
    
    if ( players.size == 1 )
    {
        self.last_closest_player = players[ 0 ];
        return self.last_closest_player;
    }
    
    if ( !isdefined( self.last_closest_player ) )
    {
        self.last_closest_player = players[ 0 ];
    }
    
    if ( !isdefined( self.need_closest_player ) )
    {
        self.need_closest_player = 1;
    }
    
    if ( isdefined( level.last_closest_time ) && level.last_closest_time >= level.time )
    {
        self factory_validate_last_closest_player( players );
        return self.last_closest_player;
    }
    
    if ( isdefined( self.need_closest_player ) && self.need_closest_player )
    {
        level.last_closest_time = level.time;
        self.need_closest_player = 0;
        closest = players[ 0 ];
        closest_dist = self zm_utility::approximate_path_dist( closest );
        
        if ( !isdefined( closest_dist ) )
        {
            closest = undefined;
        }
        
        for ( index = 1; index < players.size ; index++ )
        {
            dist = self zm_utility::approximate_path_dist( players[ index ] );
            
            if ( isdefined( dist ) )
            {
                if ( isdefined( closest_dist ) )
                {
                    if ( dist < closest_dist )
                    {
                        closest = players[ index ];
                        closest_dist = dist;
                    }
                    
                    continue;
                }
                
                closest = players[ index ];
                closest_dist = dist;
            }
        }
        
        self.last_closest_player = closest;
    }
    
    if ( players.size > 1 && isdefined( closest ) )
    {
        self zm_utility::approximate_path_dist( closest );
    }
    
    self factory_validate_last_closest_player( players );
    return self.last_closest_player;
}

// Namespace zm_usermap_ai
// Params 0, eflags: 0x4
// Checksum 0xfec229c1, Offset: 0xe18
// Size: 0x18c
function private update_closest_player()
{
    level waittill( #"start_of_round" );
    
    while ( true )
    {
        reset_closest_player = 1;
        zombies = zombie_utility::get_round_enemy_array();
        
        foreach ( zombie in zombies )
        {
            if ( isdefined( zombie.need_closest_player ) && zombie.need_closest_player )
            {
                reset_closest_player = 0;
                break;
            }
        }
        
        if ( reset_closest_player )
        {
            foreach ( zombie in zombies )
            {
                if ( isdefined( zombie.need_closest_player ) )
                {
                    zombie.need_closest_player = 1;
                }
            }
        }
        
        wait 0.05;
    }
}

