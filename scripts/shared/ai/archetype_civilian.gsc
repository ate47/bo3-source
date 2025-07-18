#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_state_machine;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai_shared;
#using scripts/shared/spawner_shared;

#namespace archetype_civilian;

// Namespace archetype_civilian
// Params 0, eflags: 0x2
// Checksum 0xc28bd094, Offset: 0x2a8
// Size: 0x14
function autoexec main()
{
    archetypecivilian::registerbehaviorscriptfunctions();
}

#namespace archetypecivilian;

// Namespace archetypecivilian
// Params 0
// Checksum 0x9a35315c, Offset: 0x2c8
// Size: 0x1a4
function registerbehaviorscriptfunctions()
{
    spawner::add_archetype_spawn_function( "civilian", &civilianblackboardinit );
    spawner::add_archetype_spawn_function( "civilian", &archetypecivilianinit );
    ai::registermatchedinterface( "civilian", "sprint", 0, array( 1, 0 ) );
    ai::registermatchedinterface( "civilian", "panic", 0, array( 1, 0 ) );
    behaviortreenetworkutility::registerbehaviortreeaction( "civilianMoveAction", &civilianmoveactioninitialize, undefined, &civilianmoveactionfinalize );
    behaviortreenetworkutility::registerbehaviortreeaction( "civilianCowerAction", &civiliancoweractioninitialize, undefined, undefined );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "civilianIsPanicked", &civilianispanicked );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "civilianPanic", &civilianpanic );
    behaviorstatemachine::registerbsmscriptapiinternal( "civilianPanic", &civilianpanic );
}

// Namespace archetypecivilian
// Params 0, eflags: 0x4
// Checksum 0x625ab7ad, Offset: 0x478
// Size: 0x13c
function private civilianblackboardinit()
{
    blackboard::createblackboardforentity( self );
    ai::createinterfaceforentity( self );
    self aiutility::registerutilityblackboardattributes();
    blackboard::registerblackboardattribute( self, "_panic", "calm", &bb_getpanic );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x28>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_human_locomotion_variation", undefined, undefined );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x2f>" );
        #/
    }
    
    self.___archetypeonanimscriptedcallback = &civilianonanimscriptedcallback;
    
    /#
        self finalizetrackedblackboardattributes();
    #/
}

// Namespace archetypecivilian
// Params 0, eflags: 0x4
// Checksum 0x357563bd, Offset: 0x5c0
// Size: 0xbc
function private archetypecivilianinit()
{
    entity = self;
    locomotiontypes = array( "alt1", "alt2", "alt3", "alt4" );
    altindex = entity getentitynumber() % locomotiontypes.size;
    blackboard::setblackboardattribute( entity, "_human_locomotion_variation", locomotiontypes[ altindex ] );
    entity setavoidancemask( "avoid ai" );
}

// Namespace archetypecivilian
// Params 0, eflags: 0x4
// Checksum 0x59ad0bc9, Offset: 0x688
// Size: 0x36
function private bb_getpanic()
{
    if ( ai::getaiattribute( self, "panic" ) )
    {
        return "panic";
    }
    
    return "calm";
}

// Namespace archetypecivilian
// Params 1, eflags: 0x4
// Checksum 0x81c13565, Offset: 0x6c8
// Size: 0x34
function private civilianonanimscriptedcallback( entity )
{
    entity.__blackboard = undefined;
    entity civilianblackboardinit();
}

// Namespace archetypecivilian
// Params 2, eflags: 0x4
// Checksum 0xd7523d1d, Offset: 0x708
// Size: 0x58
function private civilianmoveactioninitialize( entity, asmstatename )
{
    blackboard::setblackboardattribute( entity, "_desired_stance", "stand" );
    animationstatenetworkutility::requeststate( entity, asmstatename );
    return 5;
}

// Namespace archetypecivilian
// Params 2, eflags: 0x4
// Checksum 0x2dfdced8, Offset: 0x768
// Size: 0x68
function private civilianmoveactionfinalize( entity, asmstatename )
{
    if ( blackboard::getblackboardattribute( entity, "_stance" ) != "stand" )
    {
        blackboard::setblackboardattribute( entity, "_desired_stance", "stand" );
    }
    
    return 4;
}

// Namespace archetypecivilian
// Params 2, eflags: 0x4
// Checksum 0xcfa539e, Offset: 0x7d8
// Size: 0xc8
function private civiliancoweractioninitialize( entity, asmstatename )
{
    if ( isdefined( entity.node ) )
    {
        higheststance = aiutility::gethighestnodestance( entity.node );
        
        if ( higheststance == "crouch" )
        {
            blackboard::setblackboardattribute( entity, "_stance", "crouch" );
        }
        else
        {
            blackboard::setblackboardattribute( entity, "_stance", "stand" );
        }
    }
    
    animationstatenetworkutility::requeststate( entity, asmstatename );
    return 5;
}

// Namespace archetypecivilian
// Params 1, eflags: 0x4
// Checksum 0xae944285, Offset: 0x8a8
// Size: 0x34, Type: bool
function private civilianispanicked( entity )
{
    return blackboard::getblackboardattribute( entity, "_panic" ) == "panic";
}

// Namespace archetypecivilian
// Params 1, eflags: 0x4
// Checksum 0x58b3c3ee, Offset: 0x8e8
// Size: 0x30, Type: bool
function private civilianpanic( entity )
{
    entity ai::set_behavior_attribute( "panic", 1 );
    return true;
}

