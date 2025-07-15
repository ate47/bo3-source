#using scripts/codescripts/struct;
#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace skeletonbehavior;

// Namespace skeletonbehavior
// Params 0, eflags: 0x2
// Checksum 0x96d46297, Offset: 0x530
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "skeleton", &__init__, undefined, undefined );
}

// Namespace skeletonbehavior
// Params 0
// Checksum 0x458a2a71, Offset: 0x570
// Size: 0xac
function __init__()
{
    initskeletonbehaviorsandasm();
    spawner::add_archetype_spawn_function( "skeleton", &archetypeskeletonblackboardinit );
    spawner::add_archetype_spawn_function( "skeleton", &skeletonspawnsetup );
    
    if ( ai::shouldregisterclientfieldforarchetype( "skeleton" ) )
    {
        clientfield::register( "actor", "skeleton", 1, 1, "int" );
    }
}

// Namespace skeletonbehavior
// Params 0
// Checksum 0xafcdb836, Offset: 0x628
// Size: 0xbc
function skeletonspawnsetup()
{
    self.zombie_move_speed = "walk";
    
    if ( randomint( 2 ) == 0 )
    {
        self.zombie_arms_position = "up";
    }
    else
    {
        self.zombie_arms_position = "down";
    }
    
    self.missinglegs = 0;
    self setavoidancemask( "avoid none" );
    self pushactors( 1 );
    clientfield::set( "skeleton", 1 );
}

// Namespace skeletonbehavior
// Params 0, eflags: 0x4
// Checksum 0xca7ee6fc, Offset: 0x6f0
// Size: 0xf4
function private initskeletonbehaviorsandasm()
{
    behaviortreenetworkutility::registerbehaviortreescriptapi( "skeletonTargetService", &skeletontargetservice );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "skeletonShouldMelee", &skeletonshouldmeleecondition );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "skeletonGibLegsCondition", &skeletongiblegscondition );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "isSkeletonWalking", &isskeletonwalking );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "skeletonDeathAction", &skeletondeathaction );
    animationstatenetwork::registernotetrackhandlerfunction( "contact", &skeletonnotetrackmeleefire );
}

// Namespace skeletonbehavior
// Params 0, eflags: 0x4
// Checksum 0xe6f828d0, Offset: 0x7f0
// Size: 0x24c
function private archetypeskeletonblackboardinit()
{
    blackboard::createblackboardforentity( self );
    self aiutility::registerutilityblackboardattributes();
    blackboard::registerblackboardattribute( self, "_arms_position", "arms_up", &bb_getarmsposition );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x28>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_locomotion_speed", "locomotion_speed_walk", &bb_getlocomotionspeedtype );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x37>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_has_legs", "has_legs_yes", &bb_gethaslegsstatus );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x49>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_which_board_pull", undefined, undefined );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x53>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_board_attack_spot", undefined, undefined );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x65>" );
        #/
    }
    
    self.___archetypeonanimscriptedcallback = &archetypeskeletononanimscriptedcallback;
    
    /#
        self finalizetrackedblackboardattributes();
    #/
}

// Namespace skeletonbehavior
// Params 1, eflags: 0x4
// Checksum 0x8f26919b, Offset: 0xa48
// Size: 0x34
function private archetypeskeletononanimscriptedcallback( entity )
{
    entity.__blackboard = undefined;
    entity archetypeskeletonblackboardinit();
}

// Namespace skeletonbehavior
// Params 0
// Checksum 0x3eb6f2a6, Offset: 0xa88
// Size: 0x3a
function bb_getarmsposition()
{
    if ( isdefined( self.skeleton_arms_position ) )
    {
        if ( self.zombie_arms_position == "up" )
        {
            return "arms_up";
        }
        
        return "arms_down";
    }
    
    return "arms_up";
}

// Namespace skeletonbehavior
// Params 0
// Checksum 0x7db12759, Offset: 0xad0
// Size: 0x92
function bb_getlocomotionspeedtype()
{
    if ( isdefined( self.zombie_move_speed ) )
    {
        if ( self.zombie_move_speed == "walk" )
        {
            return "locomotion_speed_walk";
        }
        else if ( self.zombie_move_speed == "run" )
        {
            return "locomotion_speed_run";
        }
        else if ( self.zombie_move_speed == "sprint" )
        {
            return "locomotion_speed_sprint";
        }
        else if ( self.zombie_move_speed == "super_sprint" )
        {
            return "locomotion_speed_super_sprint";
        }
    }
    
    return "locomotion_speed_walk";
}

// Namespace skeletonbehavior
// Params 0
// Checksum 0x928f481d, Offset: 0xb70
// Size: 0x1e
function bb_gethaslegsstatus()
{
    if ( self.missinglegs )
    {
        return "has_legs_no";
    }
    
    return "has_legs_yes";
}

// Namespace skeletonbehavior
// Params 1
// Checksum 0xa13d6678, Offset: 0xb98
// Size: 0x80, Type: bool
function isskeletonwalking( behaviortreeentity )
{
    if ( !isdefined( behaviortreeentity.zombie_move_speed ) )
    {
        return true;
    }
    
    return behaviortreeentity.zombie_move_speed == "walk" && !( isdefined( behaviortreeentity.missinglegs ) && behaviortreeentity.missinglegs ) && behaviortreeentity.zombie_arms_position == "up";
}

// Namespace skeletonbehavior
// Params 1
// Checksum 0x2f256bb4, Offset: 0xc20
// Size: 0x42, Type: bool
function skeletongiblegscondition( behaviortreeentity )
{
    return gibserverutils::isgibbed( behaviortreeentity, 256 ) || gibserverutils::isgibbed( behaviortreeentity, 128 );
}

// Namespace skeletonbehavior
// Params 1
// Checksum 0xe809db28, Offset: 0xc70
// Size: 0x80
function skeletonnotetrackmeleefire( animationentity )
{
    hitent = animationentity melee();
    
    if ( isdefined( hitent ) && isdefined( animationentity.aux_melee_damage ) && self.team != hitent.team )
    {
        animationentity [[ animationentity.aux_melee_damage ]]( hitent );
    }
}

// Namespace skeletonbehavior
// Params 4
// Checksum 0xa5a69f62, Offset: 0xcf8
// Size: 0xa2, Type: bool
function is_within_fov( start_origin, start_angles, end_origin, fov )
{
    normal = vectornormalize( end_origin - start_origin );
    forward = anglestoforward( start_angles );
    dot = vectordot( forward, normal );
    return dot >= fov;
}

// Namespace skeletonbehavior
// Params 1
// Checksum 0x9d5917cf, Offset: 0xda8
// Size: 0x1ee, Type: bool
function skeletoncanseeplayer( player )
{
    self endon( #"death" );
    
    if ( !isdefined( self.players_viscache ) )
    {
        self.players_viscache = [];
    }
    
    entnum = player getentitynumber();
    
    if ( !isdefined( self.players_viscache[ entnum ] ) )
    {
        self.players_viscache[ entnum ] = 0;
    }
    
    if ( self.players_viscache[ entnum ] > gettime() )
    {
        return true;
    }
    
    zombie_eye = self.origin + ( 0, 0, 40 );
    player_pos = player.origin + ( 0, 0, 40 );
    distancesq = distancesquared( zombie_eye, player_pos );
    
    if ( distancesq < 4096 )
    {
        self.players_viscache[ entnum ] = gettime() + 3000;
        return true;
    }
    else if ( distancesq > 1048576 )
    {
        return false;
    }
    
    if ( is_within_fov( zombie_eye, self.angles, player_pos, cos( 60 ) ) )
    {
        trace = groundtrace( zombie_eye, player_pos, 0, undefined );
        
        if ( trace[ "fraction" ] < 1 )
        {
            return false;
        }
        else
        {
            self.players_viscache[ entnum ] = gettime() + 3000;
            return true;
        }
    }
    
    return false;
}

// Namespace skeletonbehavior
// Params 3
// Checksum 0x70d1edcf, Offset: 0xfa0
// Size: 0x170
function is_player_valid( player, checkignoremeflag, ignore_laststand_players )
{
    if ( !isdefined( player ) )
    {
        return 0;
    }
    
    if ( !isalive( player ) )
    {
        return 0;
    }
    
    if ( !isplayer( player ) )
    {
        return 0;
    }
    
    if ( isdefined( player.is_zombie ) && player.is_zombie == 1 )
    {
        return 0;
    }
    
    if ( player.sessionstate == "spectator" )
    {
        return 0;
    }
    
    if ( player.sessionstate == "intermission" )
    {
        return 0;
    }
    
    if ( isdefined( self.intermission ) && self.intermission )
    {
        return 0;
    }
    
    if ( !( isdefined( ignore_laststand_players ) && ignore_laststand_players ) )
    {
        if ( player laststand::player_is_in_laststand() )
        {
            return 0;
        }
    }
    
    if ( isdefined( checkignoremeflag ) && checkignoremeflag && player.ignoreme )
    {
        return 0;
    }
    
    if ( isdefined( level.is_player_valid_override ) )
    {
        return [[ level.is_player_valid_override ]]( player );
    }
    
    return 1;
}

// Namespace skeletonbehavior
// Params 2
// Checksum 0x318714e4, Offset: 0x1118
// Size: 0x254
function get_closest_valid_player( origin, ignore_player )
{
    valid_player_found = 0;
    players = getplayers();
    
    if ( isdefined( ignore_player ) )
    {
        for ( i = 0; i < ignore_player.size ; i++ )
        {
            arrayremovevalue( players, ignore_player[ i ] );
        }
    }
    
    done = 0;
    
    while ( players.size && !done )
    {
        done = 1;
        
        for ( i = 0; i < players.size ; i++ )
        {
            player = players[ i ];
            
            if ( !is_player_valid( player, 1 ) )
            {
                arrayremovevalue( players, player );
                done = 0;
                break;
            }
        }
    }
    
    if ( players.size == 0 )
    {
        return undefined;
    }
    
    while ( !valid_player_found )
    {
        if ( isdefined( self.closest_player_override ) )
        {
            player = [[ self.closest_player_override ]]( origin, players );
        }
        else if ( isdefined( level.closest_player_override ) )
        {
            player = [[ level.closest_player_override ]]( origin, players );
        }
        else
        {
            player = arraygetclosest( origin, players );
        }
        
        if ( !isdefined( player ) || players.size == 0 )
        {
            return undefined;
        }
        
        if ( !is_player_valid( player, 1 ) )
        {
            arrayremovevalue( players, player );
            
            if ( players.size == 0 )
            {
                return undefined;
            }
            
            continue;
        }
        
        return player;
    }
}

// Namespace skeletonbehavior
// Params 1
// Checksum 0x320d3f74, Offset: 0x1378
// Size: 0x4c
function skeletonsetgoal( goal )
{
    if ( isdefined( self.setgoaloverridecb ) )
    {
        return [[ self.setgoaloverridecb ]]( goal );
    }
    
    self setgoal( goal );
}

// Namespace skeletonbehavior
// Params 1
// Checksum 0x2b5a36dd, Offset: 0x13d0
// Size: 0x3b0
function skeletontargetservice( behaviortreeentity )
{
    self endon( #"death" );
    
    if ( isdefined( behaviortreeentity.ignoreall ) && behaviortreeentity.ignoreall )
    {
        return 0;
    }
    
    if ( isdefined( behaviortreeentity.enemy ) && behaviortreeentity.enemy.team == behaviortreeentity.team )
    {
        behaviortreeentity clearentitytarget();
    }
    
    if ( behaviortreeentity.team == "allies" )
    {
        if ( isdefined( behaviortreeentity.favoriteenemy ) )
        {
            behaviortreeentity skeletonsetgoal( behaviortreeentity.favoriteenemy.origin );
            return 1;
        }
        
        if ( isdefined( behaviortreeentity.enemy ) )
        {
            behaviortreeentity skeletonsetgoal( behaviortreeentity.enemy.origin );
            return 1;
        }
        
        target = getclosesttome( getaiteamarray( "axis" ) );
        
        if ( isdefined( target ) )
        {
            behaviortreeentity skeletonsetgoal( target.origin );
            return 1;
        }
        else
        {
            behaviortreeentity skeletonsetgoal( behaviortreeentity.origin );
            return 0;
        }
        
        return;
    }
    
    player = get_closest_valid_player( behaviortreeentity.origin, behaviortreeentity.ignore_player );
    
    if ( !isdefined( player ) )
    {
        if ( isdefined( behaviortreeentity.ignore_player ) )
        {
            if ( isdefined( level._should_skip_ignore_player_logic ) && [[ level._should_skip_ignore_player_logic ]]() )
            {
                return;
            }
            
            behaviortreeentity.ignore_player = [];
        }
        
        behaviortreeentity skeletonsetgoal( behaviortreeentity.origin );
        return 0;
    }
    
    if ( isdefined( player.last_valid_position ) )
    {
        cansee = self skeletoncanseeplayer( player );
        
        if ( cansee )
        {
            behaviortreeentity skeletonsetgoal( player.last_valid_position );
            return 1;
        }
        else
        {
            influencepos = undefined;
            
            if ( isdefined( influencepos ) )
            {
                if ( distancesquared( influencepos, behaviortreeentity.origin ) > 1024 )
                {
                    behaviortreeentity skeletonsetgoal( influencepos );
                    return 1;
                }
                
                behaviortreeentity clearpath();
                return 0;
            }
            else
            {
                behaviortreeentity clearpath();
                return 0;
            }
        }
        
        return 1;
    }
    
    behaviortreeentity skeletonsetgoal( behaviortreeentity.origin );
    return 0;
}

// Namespace skeletonbehavior
// Params 1
// Checksum 0xcb115589, Offset: 0x1788
// Size: 0x1e, Type: bool
function isvalidenemy( enemy )
{
    if ( !isdefined( enemy ) )
    {
        return false;
    }
    
    return true;
}

// Namespace skeletonbehavior
// Params 1
// Checksum 0x514fee29, Offset: 0x17b0
// Size: 0x42
function getyaw( org )
{
    angles = vectortoangles( org - self.origin );
    return angles[ 1 ];
}

// Namespace skeletonbehavior
// Params 0
// Checksum 0x7643419d, Offset: 0x1800
// Size: 0xe4
function getyawtoenemy()
{
    pos = undefined;
    
    if ( isvalidenemy( self.enemy ) )
    {
        pos = self.enemy.origin;
    }
    else
    {
        forward = anglestoforward( self.angles );
        forward = vectorscale( forward, 150 );
        pos = self.origin + forward;
    }
    
    yaw = self.angles[ 1 ] - getyaw( pos );
    yaw = angleclamp180( yaw );
    return yaw;
}

// Namespace skeletonbehavior
// Params 1
// Checksum 0x6ec76839, Offset: 0x18f0
// Size: 0xec, Type: bool
function skeletonshouldmeleecondition( behaviortreeentity )
{
    if ( !isdefined( behaviortreeentity.enemy ) )
    {
        return false;
    }
    
    if ( isdefined( behaviortreeentity.marked_for_death ) )
    {
        return false;
    }
    
    if ( isdefined( behaviortreeentity.stunned ) && behaviortreeentity.stunned )
    {
        return false;
    }
    
    yaw = abs( getyawtoenemy() );
    
    if ( yaw > 45 )
    {
        return false;
    }
    
    if ( distancesquared( behaviortreeentity.origin, behaviortreeentity.enemy.origin ) < 4096 )
    {
        return true;
    }
    
    return false;
}

// Namespace skeletonbehavior
// Params 1
// Checksum 0xe713a185, Offset: 0x19e8
// Size: 0x38
function skeletondeathaction( behaviortreeentity )
{
    if ( isdefined( behaviortreeentity.deathfunction ) )
    {
        behaviortreeentity [[ behaviortreeentity.deathfunction ]]();
    }
}

// Namespace skeletonbehavior
// Params 2
// Checksum 0x1c79af1c, Offset: 0x1a28
// Size: 0x4a
function getclosestto( origin, entarray )
{
    if ( !isdefined( entarray ) )
    {
        return;
    }
    
    if ( entarray.size == 0 )
    {
        return;
    }
    
    return arraygetclosest( origin, entarray );
}

// Namespace skeletonbehavior
// Params 1
// Checksum 0x33ae1253, Offset: 0x1a80
// Size: 0x2a
function getclosesttome( entarray )
{
    return getclosestto( self.origin, entarray );
}

