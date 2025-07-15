#using scripts/codescripts/struct;
#using scripts/shared/ai/archetype_locomotion_utility;
#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;

#namespace zombiequad;

// Namespace zombiequad
// Params 0, eflags: 0x2
// Checksum 0xf8ca25e9, Offset: 0x500
// Size: 0x64
function autoexec init()
{
    initzombiebehaviorsandasm();
    spawner::add_archetype_spawn_function( "zombie_quad", &archetypequadblackboardinit );
    spawner::add_archetype_spawn_function( "zombie_quad", &quadspawnsetup );
}

// Namespace zombiequad
// Params 0
// Checksum 0xea8ae66b, Offset: 0x570
// Size: 0x1ec
function archetypequadblackboardinit()
{
    blackboard::createblackboardforentity( self );
    self aiutility::registerutilityblackboardattributes();
    ai::createinterfaceforentity( self );
    blackboard::registerblackboardattribute( self, "_locomotion_speed", "locomotion_speed_walk", &zombiebehavior::bb_getlocomotionspeedtype );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x28>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_quad_wall_crawl", undefined, undefined );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x3a>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_quad_phase_direction", undefined, undefined );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x4b>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_quad_phase_distance", undefined, undefined );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x61>" );
        #/
    }
    
    self.___archetypeonanimscriptedcallback = &archetypequadonanimscriptedcallback;
    
    /#
        self finalizetrackedblackboardattributes();
    #/
}

// Namespace zombiequad
// Params 1, eflags: 0x4
// Checksum 0x9ba23d08, Offset: 0x768
// Size: 0x34
function private archetypequadonanimscriptedcallback( entity )
{
    entity.__blackboard = undefined;
    entity archetypequadblackboardinit();
}

// Namespace zombiequad
// Params 0, eflags: 0x4
// Checksum 0x3fdcd04f, Offset: 0x7a8
// Size: 0x34
function private initzombiebehaviorsandasm()
{
    animationstatenetwork::registeranimationmocomp( "mocomp_teleport_traversal@zombie_quad", &quadteleporttraversalmocompstart, undefined, undefined );
}

// Namespace zombiequad
// Params 0
// Checksum 0x53578ec6, Offset: 0x7e8
// Size: 0x1c
function quadspawnsetup()
{
    self setpitchorient();
}

// Namespace zombiequad
// Params 5
// Checksum 0x9e0e2c39, Offset: 0x810
// Size: 0x19c
function quadteleporttraversalmocompstart( entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration )
{
    entity orientmode( "face angle", entity.angles[ 1 ] );
    entity animmode( "normal" );
    
    if ( isdefined( entity.traverseendnode ) )
    {
        /#
            print3d( entity.traversestartnode.origin, "<dev string:x76>", ( 1, 0, 0 ), 1, 1, 60 );
            print3d( entity.traverseendnode.origin, "<dev string:x76>", ( 0, 1, 0 ), 1, 1, 60 );
            line( entity.traversestartnode.origin, entity.traverseendnode.origin, ( 0, 1, 0 ), 1, 0, 60 );
        #/
        
        entity forceteleport( entity.traverseendnode.origin, entity.traverseendnode.angles, 0 );
    }
}

