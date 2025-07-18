#using scripts/codescripts/struct;
#using scripts/mp/_arena;
#using scripts/mp/_armblade;
#using scripts/mp/_art;
#using scripts/mp/_ballistic_knife;
#using scripts/mp/_bb;
#using scripts/mp/_blackjack_challenges;
#using scripts/mp/_bouncingbetty;
#using scripts/mp/_callbacks;
#using scripts/mp/_contracts;
#using scripts/mp/_destructible;
#using scripts/mp/_devgui;
#using scripts/mp/_explosive_bolt;
#using scripts/mp/_flashgrenades;
#using scripts/mp/_hacker_tool;
#using scripts/mp/_heatseekingmissile;
#using scripts/mp/_hive_gun;
#using scripts/mp/_incendiary;
#using scripts/mp/_lightninggun;
#using scripts/mp/_load;
#using scripts/mp/_perks;
#using scripts/mp/_pickup_items;
#using scripts/mp/_proximity_grenade;
#using scripts/mp/_riotshield;
#using scripts/mp/_satchel_charge;
#using scripts/mp/_sensor_grenade;
#using scripts/mp/_smokegrenade;
#using scripts/mp/_tacticalinsertion;
#using scripts/mp/_threat_detector;
#using scripts/mp/_trophy_system;
#using scripts/mp/_util;
#using scripts/mp/_vehicle;
#using scripts/mp/gametypes/_classicmode;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_weaponobjects;
#using scripts/mp/killstreaks/_ai_tank;
#using scripts/mp/killstreaks/_counteruav;
#using scripts/mp/killstreaks/_dogs;
#using scripts/mp/killstreaks/_drone_strike;
#using scripts/mp/killstreaks/_killstreak_detect;
#using scripts/mp/killstreaks/_placeables;
#using scripts/mp/killstreaks/_rcbomb;
#using scripts/mp/killstreaks/_satellite;
#using scripts/mp/killstreaks/_uav;
#using scripts/shared/_burnplayer;
#using scripts/shared/_oob;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/archetype_shared/archetype_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/entityheadicons_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/load_shared;
#using scripts/shared/math_shared;
#using scripts/shared/medals_shared;
#using scripts/shared/music_shared;
#using scripts/shared/objpoints_shared;
#using scripts/shared/player_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/serverfaceanim_shared;
#using scripts/shared/system_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/tweakables_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_ballistic_knife;
#using scripts/shared/weapons/_bouncingbetty;
#using scripts/shared/weapons/_flashgrenades;
#using scripts/shared/weapons/_hive_gun;
#using scripts/shared/weapons/_lightninggun;
#using scripts/shared/weapons/_pineapple_gun;
#using scripts/shared/weapons/_proximity_grenade;
#using scripts/shared/weapons/_riotshield;
#using scripts/shared/weapons/_satchel_charge;
#using scripts/shared/weapons/_sensor_grenade;
#using scripts/shared/weapons/_sticky_grenade;
#using scripts/shared/weapons/_tacticalinsertion;
#using scripts/shared/weapons/_trophy_system;
#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/weapons/multilockapguidance;

#namespace load;

// Namespace load
// Params 0
// Checksum 0x6d2c6807, Offset: 0xce0
// Size: 0x104
function main()
{
    assert( isdefined( level.first_frame ), "<dev string:x28>" );
    level._loadstarted = 1;
    setclearanceceiling( 30 );
    register_clientfields();
    level.aitriggerspawnflags = getaitriggerflags();
    level.vehicletriggerspawnflags = getvehicletriggerflags();
    setup_traversals();
    level.globallogic_audio_dialog_on_player_override = &globallogic_audio::leader_dialog_on_player;
    level.growing_hitmarker = 1;
    system::wait_till( "all" );
    level flagsys::set( "load_main_complete" );
}

// Namespace load
// Params 2
// Checksum 0x71cace33, Offset: 0xdf0
// Size: 0xba
function setfootstepeffect( name, fx )
{
    assert( isdefined( name ), "<dev string:x54>" );
    assert( isdefined( fx ), "<dev string:x7e>" );
    
    if ( !isdefined( anim.optionalstepeffects ) )
    {
        anim.optionalstepeffects = [];
    }
    
    anim.optionalstepeffects[ anim.optionalstepeffects.size ] = name;
    level._effect[ "step_" + name ] = fx;
}

// Namespace load
// Params 0
// Checksum 0xf6c331ad, Offset: 0xeb8
// Size: 0x224
function footsteps()
{
    setfootstepeffect( "asphalt", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "brick", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "carpet", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "cloth", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "concrete", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "dirt", "_t6/bio/player/fx_footstep_sand" );
    setfootstepeffect( "foliage", "_t6/bio/player/fx_footstep_sand" );
    setfootstepeffect( "gravel", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "grass", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "metal", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "mud", "_t6/bio/player/fx_footstep_mud" );
    setfootstepeffect( "paper", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "plaster", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "rock", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "sand", "_t6/bio/player/fx_footstep_sand" );
    setfootstepeffect( "water", "_t6/bio/player/fx_footstep_water" );
    setfootstepeffect( "wood", "_t6/bio/player/fx_footstep_dust" );
}

// Namespace load
// Params 0
// Checksum 0x17992b6f, Offset: 0x10e8
// Size: 0xbc
function init_traverse()
{
    point = getent( self.target, "targetname" );
    
    if ( isdefined( point ) )
    {
        self.traverse_height = point.origin[ 2 ];
        point delete();
        return;
    }
    
    point = struct::get( self.target, "targetname" );
    
    if ( isdefined( point ) )
    {
        self.traverse_height = point.origin[ 2 ];
    }
}

// Namespace load
// Params 0
// Checksum 0x408cbe5e, Offset: 0x11b0
// Size: 0x96
function setup_traversals()
{
    potential_traverse_nodes = getallnodes();
    
    for ( i = 0; i < potential_traverse_nodes.size ; i++ )
    {
        node = potential_traverse_nodes[ i ];
        
        if ( node.type == "Begin" )
        {
            node init_traverse();
        }
    }
}

// Namespace load
// Params 0
// Checksum 0x4a8ae350, Offset: 0x1250
// Size: 0x94
function register_clientfields()
{
    clientfield::register( "missile", "cf_m_proximity", 1, 1, "int" );
    clientfield::register( "missile", "cf_m_emp", 1, 1, "int" );
    clientfield::register( "missile", "cf_m_stun", 1, 1, "int" );
}

