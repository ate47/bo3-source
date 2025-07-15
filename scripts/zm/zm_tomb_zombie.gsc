#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_behavior;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/zm_tomb_tank;

#namespace zm_tomb_zombie;

// Namespace zm_tomb_zombie
// Params 0, eflags: 0x2
// Checksum 0xf519961f, Offset: 0x4c0
// Size: 0x5c
function autoexec init()
{
    function_b5da43f3();
    setdvar( "scr_zm_use_code_enemy_selection", 0 );
    level thread update_closest_player();
    level.validate_on_navmesh = 1;
    level.pathdist_type = 2;
}

// Namespace zm_tomb_zombie
// Params 0, eflags: 0x4
// Checksum 0xa4fe2cfe, Offset: 0x528
// Size: 0x234
function private function_b5da43f3()
{
    behaviortreenetworkutility::registerbehaviortreescriptapi( "wasKilledByWaterStaff", &function_901a96ec );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "wasKilledByFireStaff", &function_7ae408dd );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "wasKilledByLightningStaff", &function_a8b7161f );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "wasKilledOnTank", &waskilledontank );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "wasStunnedByFireStaff", &function_1beccbaf );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "wasStunnedByLightningStaff", &function_4638613d );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "zombieShouldWhirlwind", &zombieshouldwhirlwind );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "zombieStunFireActionEnd", &zombiestunfireactionend );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "zombieStunLightningActionEnd", &zombiestunlightningactionend );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "tombSetFindFleshState", &tombsetfindfleshstate );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "tombClearFindFleshState", &tombclearfindfleshstate );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "tombOnTankDeathActionStart", &tombontankdeathactionstart );
    spawner::add_archetype_spawn_function( "zombie", &function_59f740e7 );
    animationstatenetwork::registernotetrackhandlerfunction( "shatter", &function_e24c6a3f );
}

// Namespace zm_tomb_zombie
// Params 0
// Checksum 0xb56819e3, Offset: 0x768
// Size: 0x1c
function function_59f740e7()
{
    self.zombiemoveactioncallback = &tombsetfindfleshstate;
}

// Namespace zm_tomb_zombie
// Params 1
// Checksum 0xb84ed822, Offset: 0x790
// Size: 0x64
function function_e24c6a3f( entity )
{
    entity clientfield::set( "staff_shatter_fx", 1 );
    entity clientfield::set( "attach_bullet_model", 0 );
    entity ghost();
}

// Namespace zm_tomb_zombie
// Params 1
// Checksum 0xd827ecde, Offset: 0x800
// Size: 0x3a, Type: bool
function function_901a96ec( behaviortreeentity )
{
    if ( isdefined( behaviortreeentity.var_93022f09 ) && behaviortreeentity.var_93022f09 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_tomb_zombie
// Params 1
// Checksum 0x7eaf6d4c, Offset: 0x848
// Size: 0x3a, Type: bool
function function_7ae408dd( behaviortreeentity )
{
    if ( isdefined( behaviortreeentity.var_1339189a ) && behaviortreeentity.var_1339189a )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_tomb_zombie
// Params 1
// Checksum 0x8bb749c9, Offset: 0x890
// Size: 0x3a, Type: bool
function function_a8b7161f( behaviortreeentity )
{
    if ( isdefined( behaviortreeentity.var_26747e92 ) && behaviortreeentity.var_26747e92 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_tomb_zombie
// Params 1
// Checksum 0xda16385, Offset: 0x8d8
// Size: 0x3a, Type: bool
function waskilledontank( behaviortreeentity )
{
    return isdefined( self.b_climbing_tank ) && ( self zm_tomb_tank::entity_on_tank() || self.b_climbing_tank );
}

// Namespace zm_tomb_zombie
// Params 1
// Checksum 0x77e38544, Offset: 0x920
// Size: 0x3a, Type: bool
function function_1beccbaf( behaviortreeentity )
{
    if ( isdefined( behaviortreeentity.var_262d5062 ) && behaviortreeentity.var_262d5062 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_tomb_zombie
// Params 1
// Checksum 0x80ebbcc8, Offset: 0x968
// Size: 0x3a, Type: bool
function function_4638613d( behaviortreeentity )
{
    if ( isdefined( behaviortreeentity.var_b52ab77a ) && behaviortreeentity.var_b52ab77a )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_tomb_zombie
// Params 1
// Checksum 0x5cff1286, Offset: 0x9b0
// Size: 0x3a, Type: bool
function zombieshouldwhirlwind( behaviortreeentity )
{
    if ( isdefined( behaviortreeentity._whirlwind_attract_anim ) && behaviortreeentity._whirlwind_attract_anim )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_tomb_zombie
// Params 1
// Checksum 0x9ffe38d3, Offset: 0x9f8
// Size: 0x1c
function zombiestunlightningactionend( behaviortreeentity )
{
    behaviortreeentity.var_b52ab77a = 0;
}

// Namespace zm_tomb_zombie
// Params 1
// Checksum 0x50c2bc42, Offset: 0xa20
// Size: 0x1c
function zombiestunfireactionend( behaviortreeentity )
{
    behaviortreeentity.var_262d5062 = 0;
}

// Namespace zm_tomb_zombie
// Params 1
// Checksum 0x7d2b2d4e, Offset: 0xa48
// Size: 0x6c
function tombontankdeathactionstart( behaviortreeentity )
{
    behaviortreeentity thread function_fe0480d9();
    var_25c21be0 = spawnstruct();
    var_25c21be0 thread function_57039dd1();
    behaviortreeentity thread function_66e3edec( var_25c21be0 );
}

// Namespace zm_tomb_zombie
// Params 0
// Checksum 0x4f2a062a, Offset: 0xac0
// Size: 0x74
function function_fe0480d9()
{
    wait 0.7;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self zombie_utility::zombie_eye_glow_stop();
    self clientfield::set( "zombie_instant_explode", 1 );
    wait 0.05;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self hide();
}

// Namespace zm_tomb_zombie
// Params 0
// Checksum 0x80781915, Offset: 0xb40
// Size: 0x16
function function_57039dd1()
{
    wait 10;
    self notify( #"hash_57039dd1" );
}

// Namespace zm_tomb_zombie
// Params 1
// Checksum 0xc7b6e9e, Offset: 0xb60
// Size: 0x44
function function_66e3edec( var_25c21be0 )
{
    var_25c21be0 endon( #"hash_57039dd1" );
    self waittill( #"actor_corpse", e_corpse );
    e_corpse hide();
}

// Namespace zm_tomb_zombie
// Params 1, eflags: 0x4
// Checksum 0x7be2b94b, Offset: 0xbb0
// Size: 0xfa
function private function_ce3464b9( players )
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

// Namespace zm_tomb_zombie
// Params 2, eflags: 0x4
// Checksum 0xf424bba4, Offset: 0xcb8
// Size: 0x262
function private function_3394e22d( origin, players )
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
        self function_ce3464b9( players );
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
    
    self function_ce3464b9( players );
    return self.last_closest_player;
}

// Namespace zm_tomb_zombie
// Params 0, eflags: 0x4
// Checksum 0xc67e7ae9, Offset: 0xf28
// Size: 0x1f8
function private update_closest_player()
{
    level waittill( #"start_of_round" );
    
    while ( true )
    {
        reset_closest_player = 1;
        zombies = zombie_utility::get_zombie_array();
        mechzs = getaiarchetypearray( "mechz", level.zombie_team );
        
        if ( mechzs.size )
        {
            zombies = arraycombine( zombies, mechzs, 0, 0 );
        }
        
        foreach ( zombie in zombies )
        {
            if ( isdefined( zombie.completed_emerging_into_playable_area ) && zombie.completed_emerging_into_playable_area && !isdefined( zombie.var_13ed8adf ) )
            {
                reset_closest_player = 0;
                break;
            }
        }
        
        if ( reset_closest_player )
        {
            foreach ( zombie in zombies )
            {
                if ( isdefined( zombie.var_13ed8adf ) )
                {
                    zombie.var_13ed8adf = undefined;
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace zm_tomb_zombie
// Params 1
// Checksum 0xcbe841e9, Offset: 0x1128
// Size: 0x3c
function tombsetfindfleshstate( behaviortreeentity )
{
    behaviortreeentity.var_68ff8357 = behaviortreeentity.ai_state;
    behaviortreeentity.ai_state = "find_flesh";
}

// Namespace zm_tomb_zombie
// Params 1
// Checksum 0x66f5bb4f, Offset: 0x1170
// Size: 0x36
function tombclearfindfleshstate( behaviortreeentity )
{
    behaviortreeentity.ai_state = behaviortreeentity.var_68ff8357;
    behaviortreeentity.var_68ff8357 = undefined;
}

