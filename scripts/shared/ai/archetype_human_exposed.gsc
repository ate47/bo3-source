#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai_shared;

#namespace archetype_human_exposed;

// Namespace archetype_human_exposed
// Params 0, eflags: 0x2
// Checksum 0x9c49652d, Offset: 0x238
// Size: 0x144
function autoexec registerbehaviorscriptfunctions()
{
    behaviortreenetworkutility::registerbehaviortreescriptapi( "hasCloseEnemy", &hascloseenemy );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "noCloseEnemyService", &nocloseenemyservice );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "tryReacquireService", &tryreacquireservice );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "prepareToReactToEnemy", &preparetoreacttoenemy );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "resetReactionToEnemy", &resetreactiontoenemy );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "exposedSetDesiredStanceToStand", &exposedsetdesiredstancetostand );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "setPathMoveDelayedRandom", &setpathmovedelayedrandom );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "vengeanceService", &vengeanceservice );
}

// Namespace archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0xd6dd1c1, Offset: 0x388
// Size: 0x54
function private preparetoreacttoenemy( behaviortreeentity )
{
    behaviortreeentity.newenemyreaction = 0;
    behaviortreeentity.malfunctionreaction = 0;
    behaviortreeentity pathmode( "move delayed", 1, 3 );
}

// Namespace archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0xd030ff30, Offset: 0x3e8
// Size: 0x2c
function private resetreactiontoenemy( behaviortreeentity )
{
    behaviortreeentity.newenemyreaction = 0;
    behaviortreeentity.malfunctionreaction = 0;
}

// Namespace archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0x67ea8f08, Offset: 0x420
// Size: 0x54, Type: bool
function private nocloseenemyservice( behaviortreeentity )
{
    if ( isdefined( behaviortreeentity.enemy ) && aiutility::hascloseenemytomelee( behaviortreeentity ) )
    {
        behaviortreeentity clearpath();
        return true;
    }
    
    return false;
}

// Namespace archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0x8b3129d4, Offset: 0x480
// Size: 0x64, Type: bool
function private hascloseenemy( behaviortreeentity )
{
    if ( !isdefined( behaviortreeentity.enemy ) )
    {
        return false;
    }
    
    if ( distancesquared( behaviortreeentity.origin, behaviortreeentity.enemy.origin ) < 22500 )
    {
        return true;
    }
    
    return false;
}

// Namespace archetype_human_exposed
// Params 2, eflags: 0x4
// Checksum 0x6bf7e00b, Offset: 0x4f0
// Size: 0x38, Type: bool
function private _isvalidneighbor( entity, neighbor )
{
    return isdefined( neighbor ) && entity.team === neighbor.team;
}

// Namespace archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0xe945a739, Offset: 0x530
// Size: 0x152
function private vengeanceservice( entity )
{
    actors = getaiarray();
    
    if ( !isdefined( entity.attacker ) )
    {
        return;
    }
    
    foreach ( ai in actors )
    {
        if ( _isvalidneighbor( entity, ai ) && distancesquared( entity.origin, ai.origin ) <= 360 * 360 && randomfloat( 1 ) >= 0.5 )
        {
            ai getperfectinfo( entity.attacker, 1 );
        }
    }
}

// Namespace archetype_human_exposed
// Params 2, eflags: 0x4
// Checksum 0x49ffb7c3, Offset: 0x690
// Size: 0x4c
function private setpathmovedelayedrandom( behaviortreeentity, asmstatename )
{
    behaviortreeentity pathmode( "move delayed", 0, randomfloatrange( 1, 3 ) );
}

// Namespace archetype_human_exposed
// Params 2, eflags: 0x4
// Checksum 0x5500c47a, Offset: 0x6e8
// Size: 0x7c
function private exposedsetdesiredstancetostand( behaviortreeentity, asmstatename )
{
    aiutility::keepclaimnode( behaviortreeentity );
    currentstance = blackboard::getblackboardattribute( behaviortreeentity, "_stance" );
    blackboard::setblackboardattribute( behaviortreeentity, "_desired_stance", "stand" );
}

// Namespace archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0xa0542659, Offset: 0x770
// Size: 0x2d2, Type: bool
function private tryreacquireservice( behaviortreeentity )
{
    if ( !isdefined( behaviortreeentity.reacquire_state ) )
    {
        behaviortreeentity.reacquire_state = 0;
    }
    
    if ( !isdefined( behaviortreeentity.enemy ) )
    {
        behaviortreeentity.reacquire_state = 0;
        return false;
    }
    
    if ( behaviortreeentity haspath() )
    {
        behaviortreeentity.reacquire_state = 0;
        return false;
    }
    
    if ( behaviortreeentity seerecently( behaviortreeentity.enemy, 4 ) )
    {
        behaviortreeentity.reacquire_state = 0;
        return false;
    }
    
    dirtoenemy = vectornormalize( behaviortreeentity.enemy.origin - behaviortreeentity.origin );
    forward = anglestoforward( behaviortreeentity.angles );
    
    if ( vectordot( dirtoenemy, forward ) < 0.5 )
    {
        behaviortreeentity.reacquire_state = 0;
        return false;
    }
    
    switch ( behaviortreeentity.reacquire_state )
    {
        case 0:
        case 1:
        case 2:
            step_size = 32 + behaviortreeentity.reacquire_state * 32;
            reacquirepos = behaviortreeentity reacquirestep( step_size );
            break;
        case 4:
            if ( !behaviortreeentity cansee( behaviortreeentity.enemy ) || !behaviortreeentity canshootenemy() )
            {
                behaviortreeentity flagenemyunattackable();
            }
            
            break;
        default:
            if ( behaviortreeentity.reacquire_state > 15 )
            {
                behaviortreeentity.reacquire_state = 0;
                return false;
            }
            
            break;
    }
    
    if ( isvec( reacquirepos ) )
    {
        behaviortreeentity useposition( reacquirepos );
        return true;
    }
    
    behaviortreeentity.reacquire_state++;
    return false;
}

