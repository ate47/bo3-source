#using scripts/shared/ai_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace warlord;

// Namespace warlord
// Params 0, eflags: 0x2
// Checksum 0xbac6971b, Offset: 0x3c0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "warlord", &__init__, undefined, undefined );
}

// Namespace warlord
// Params 0, eflags: 0x2
// Checksum 0x6ab4e328, Offset: 0x400
// Size: 0xe2
function autoexec precache()
{
    level._effect[ "fx_elec_warlord_damage_1" ] = "electric/fx_elec_warlord_damage_1";
    level._effect[ "fx_elec_warlord_damage_2" ] = "electric/fx_elec_warlord_damage_2";
    level._effect[ "fx_elec_warlord_lower_damage_1" ] = "electric/fx_elec_warlord_lower_damage_1";
    level._effect[ "fx_elec_warlord_lower_damage_2" ] = "electric/fx_elec_warlord_lower_damage_2";
    level._effect[ "fx_exp_warlord_death" ] = "explosions/fx_exp_warlord_death";
    level._effect[ "fx_exhaust_jetpack_warlord_juke" ] = "vehicle/fx_exhaust_jetpack_warlord_juke";
    level._effect[ "fx_light_eye_glow_warlord" ] = "light/fx_light_eye_glow_warlord";
    level._effect[ "fx_light_body_glow_warlord" ] = "light/fx_light_body_glow_warlord";
}

// Namespace warlord
// Params 0
// Checksum 0x64a4deb8, Offset: 0x4f0
// Size: 0x13c
function __init__()
{
    if ( ai::shouldregisterclientfieldforarchetype( "warlord" ) )
    {
        clientfield::register( "actor", "warlord_type", 1, 2, "int", &warlordclientutils::warlordtypehandler, 0, 0 );
        clientfield::register( "actor", "warlord_damage_state", 1, 2, "int", &warlordclientutils::warlorddamagestatehandler, 0, 0 );
        clientfield::register( "actor", "warlord_thruster_direction", 1, 3, "int", &warlordclientutils::warlordthrusterhandler, 0, 0 );
        clientfield::register( "actor", "warlord_lights_state", 1, 1, "int", &warlordclientutils::warlordlightshandler, 0, 0 );
    }
}

#namespace warlordclientutils;

// Namespace warlordclientutils
// Params 7
// Checksum 0xe0444911, Offset: 0x638
// Size: 0x22e
function warlorddamagestatehandler( localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump )
{
    entity = self;
    
    if ( isdefined( entity.damagestatefx ) )
    {
        stopfx( localclientnum, entity.damagestatefx );
        entity.damagestatefx = undefined;
    }
    
    if ( isdefined( entity.damageheavystatefx ) )
    {
        stopfx( localclientnum, entity.damageheavystatefx );
        entity.damageheavystatefx = undefined;
    }
    
    switch ( newvalue )
    {
        case 0:
            break;
        case 2:
            entity.damageheavystatefx = playfxontag( localclientnum, level._effect[ "fx_elec_warlord_damage_2" ], entity, "j_spine4" );
            playfxontag( localclientnum, level._effect[ "fx_elec_warlord_lower_damage_2" ], entity, "j_mainroot" );
        case 1:
            entity.damagestatefx = playfxontag( localclientnum, level._effect[ "fx_elec_warlord_damage_1" ], entity, "j_spine4" );
            playfxontag( localclientnum, level._effect[ "fx_elec_warlord_lower_damage_1" ], entity, "j_mainroot" );
            break;
        case 3:
            playfxontag( localclientnum, level._effect[ "fx_exp_warlord_death" ], entity, "j_spine4" );
            break;
    }
}

// Namespace warlordclientutils
// Params 7
// Checksum 0x6af2e411, Offset: 0x870
// Size: 0x60
function warlordtypehandler( localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump )
{
    entity = self;
    entity.warlordtype = newvalue;
}

// Namespace warlordclientutils
// Params 7
// Checksum 0xf139463b, Offset: 0x8d8
// Size: 0x25c
function warlordthrusterhandler( localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump )
{
    entity = self;
    
    if ( isdefined( entity.thrusterfx ) )
    {
        assert( isarray( entity.thrusterfx ) );
        
        for ( index = 0; index < entity.thrusterfx.size ; index++ )
        {
            stopfx( localclientnum, entity.thrusterfx[ index ] );
        }
    }
    
    entity.thrusterfx = [];
    tags = [];
    
    switch ( newvalue )
    {
        case 0:
            break;
        case 1:
            tags = array( "tag_jets_left_front", "tag_jets_right_front" );
            break;
        case 2:
            tags = array( "tag_jets_left_back", "tag_jets_right_back" );
            break;
        case 3:
            tags = array( "tag_jets_left_side" );
            break;
        case 4:
            tags = array( "tag_jets_right_side" );
            break;
    }
    
    for ( index = 0; index < tags.size ; index++ )
    {
        entity.thrusterfx[ entity.thrusterfx.size ] = playfxontag( localclientnum, level._effect[ "fx_exhaust_jetpack_warlord_juke" ], entity, tags[ index ] );
    }
}

// Namespace warlordclientutils
// Params 7
// Checksum 0xbf029161, Offset: 0xb40
// Size: 0xc4
function warlordlightshandler( localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump )
{
    entity = self;
    
    if ( newvalue == 1 )
    {
        playfxontag( localclientnum, level._effect[ "fx_light_eye_glow_warlord" ], entity, "tag_eye" );
        playfxontag( localclientnum, level._effect[ "fx_light_body_glow_warlord" ], entity, "j_spine4" );
    }
}

