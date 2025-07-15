#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_black_hole_bomb;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_remaster_zombie;

#namespace zm_moon_zombie;

// Namespace zm_moon_zombie
// Params 0, eflags: 0x2
// Checksum 0x75e6897a, Offset: 0x420
// Size: 0x44
function autoexec init()
{
    initzmbehaviorsandasm();
    level thread zm_remaster_zombie::update_closest_player();
    level.last_valid_position_override = &moon_last_valid_position;
}

// Namespace zm_moon_zombie
// Params 0, eflags: 0x4
// Checksum 0x5eb80163, Offset: 0x470
// Size: 0xa4
function private initzmbehaviorsandasm()
{
    spawner::add_archetype_spawn_function( "zombie", &function_7a726580 );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "moonZombieKilledByMicrowaveGunDw", &killedbymicrowavegundw );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "moonZombieKilledByMicrowaveGun", &killedbymicrowavegun );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "moonShouldMoveLowg", &moonshouldmovelowg );
}

// Namespace zm_moon_zombie
// Params 5
// Checksum 0xfca9f6f4, Offset: 0x520
// Size: 0x19c
function teleporttraversalmocompstart( entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration )
{
    entity orientmode( "face angle", entity.angles[ 1 ] );
    entity animmode( "normal" );
    
    if ( isdefined( entity.traverseendnode ) )
    {
        /#
            print3d( entity.traversestartnode.origin, "<dev string:x28>", ( 1, 0, 0 ), 1, 1, 60 );
            print3d( entity.traverseendnode.origin, "<dev string:x28>", ( 0, 1, 0 ), 1, 1, 60 );
            line( entity.traversestartnode.origin, entity.traverseendnode.origin, ( 0, 1, 0 ), 1, 0, 60 );
        #/
        
        entity forceteleport( entity.traverseendnode.origin, entity.traverseendnode.angles, 0 );
    }
}

// Namespace zm_moon_zombie
// Params 1
// Checksum 0x16a304c0, Offset: 0x6c8
// Size: 0x18a, Type: bool
function zodshouldmove( entity )
{
    if ( isdefined( entity.zombie_tesla_hit ) && entity.zombie_tesla_hit && !( isdefined( entity.tesla_death ) && entity.tesla_death ) )
    {
        return false;
    }
    
    if ( isdefined( entity.pushed ) && entity.pushed )
    {
        return false;
    }
    
    if ( isdefined( entity.knockdown ) && entity.knockdown )
    {
        return false;
    }
    
    if ( isdefined( entity.grapple_is_fatal ) && entity.grapple_is_fatal )
    {
        return false;
    }
    
    if ( level.wait_and_revive )
    {
        if ( !( isdefined( entity.var_1e3fb1c ) && entity.var_1e3fb1c ) )
        {
            return false;
        }
    }
    
    if ( isdefined( entity.stumble ) )
    {
        return false;
    }
    
    if ( zombiebehavior::zombieshouldmeleecondition( entity ) )
    {
        return false;
    }
    
    if ( entity haspath() )
    {
        return true;
    }
    
    if ( isdefined( entity.keep_moving ) && entity.keep_moving )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_moon_zombie
// Params 0, eflags: 0x4
// Checksum 0xfc1ea588, Offset: 0x860
// Size: 0x34
function private function_7a726580()
{
    self.cant_move_cb = &moon_cant_move_cb;
    self.closest_player_override = &zm_remaster_zombie::remaster_closest_player;
}

// Namespace zm_moon_zombie
// Params 0, eflags: 0x4
// Checksum 0x437a67e1, Offset: 0x8a0
// Size: 0x2c
function private moon_cant_move_cb()
{
    self pushactors( 0 );
    self.enablepushtime = gettime() + 1000;
}

// Namespace zm_moon_zombie
// Params 1
// Checksum 0xb0447e76, Offset: 0x8d8
// Size: 0x2e, Type: bool
function killedbymicrowavegundw( entity )
{
    return isdefined( entity.microwavegun_dw_death ) && entity.microwavegun_dw_death;
}

// Namespace zm_moon_zombie
// Params 1
// Checksum 0x35df044e, Offset: 0x910
// Size: 0x2e, Type: bool
function killedbymicrowavegun( entity )
{
    return isdefined( entity.microwavegun_death ) && entity.microwavegun_death;
}

// Namespace zm_moon_zombie
// Params 1
// Checksum 0x58c9938f, Offset: 0x948
// Size: 0x2e, Type: bool
function moonshouldmovelowg( entity )
{
    return isdefined( entity.in_low_gravity ) && entity.in_low_gravity;
}

// Namespace zm_moon_zombie
// Params 0
// Checksum 0x486b431e, Offset: 0x980
// Size: 0xd4, Type: bool
function moon_last_valid_position()
{
    if ( isdefined( self.in_low_gravity ) && self.in_low_gravity )
    {
        if ( self isonground() )
        {
            return false;
        }
        
        trace = groundtrace( self.origin + ( 0, 0, 15 ), self.origin + ( 0, 0, -1000 ), 0, undefined );
        ground_pos = trace[ "position" ];
        
        if ( isdefined( ground_pos ) )
        {
            if ( ispointonnavmesh( ground_pos, self ) )
            {
                self.last_valid_position = ground_pos;
                return true;
            }
        }
    }
    
    return false;
}

