#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace helicopter_gunner;

// Namespace helicopter_gunner
// Params 0, eflags: 0x2
// Checksum 0x28e0e411, Offset: 0x208
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "helicopter_gunner", &__init__, undefined, undefined );
}

// Namespace helicopter_gunner
// Params 0
// Checksum 0x7788c6ec, Offset: 0x248
// Size: 0x14c
function __init__()
{
    clientfield::register( "vehicle", "vtol_turret_destroyed_0", 1, 1, "int", &turret_destroyed_0, 0, 0 );
    clientfield::register( "vehicle", "vtol_turret_destroyed_1", 1, 1, "int", &turret_destroyed_1, 0, 0 );
    clientfield::register( "toplayer", "vtol_update_client", 1, 1, "counter", &update_client, 0, 0 );
    clientfield::register( "toplayer", "fog_bank_2", 1, 1, "int", &fog_bank_2_callback, 0, 0 );
    visionset_mgr::register_visionset_info( "mothership_visionset", 1, 1, undefined, "mp_vehicles_mothership" );
}

// Namespace helicopter_gunner
// Params 7
// Checksum 0x66df3794, Offset: 0x3a0
// Size: 0x3c
function turret_destroyed_0( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    
}

// Namespace helicopter_gunner
// Params 7
// Checksum 0x2e0e26ab, Offset: 0x3e8
// Size: 0x3c
function turret_destroyed_1( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    
}

// Namespace helicopter_gunner
// Params 3
// Checksum 0x8d02caa7, Offset: 0x430
// Size: 0x7c
function update_turret_destroyed( localclientnum, ui_model_name, new_value )
{
    part_destroyed_ui_model = getuimodel( getuimodelforcontroller( localclientnum ), ui_model_name );
    
    if ( isdefined( part_destroyed_ui_model ) )
    {
        setuimodelvalue( part_destroyed_ui_model, new_value );
    }
}

// Namespace helicopter_gunner
// Params 7
// Checksum 0x4f474745, Offset: 0x4b8
// Size: 0xdc
function update_client( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    veh = getplayervehicle( self );
    
    if ( isdefined( veh ) )
    {
        update_turret_destroyed( localclientnum, "vehicle.partDestroyed.0", veh clientfield::get( "vtol_turret_destroyed_0" ) );
        update_turret_destroyed( localclientnum, "vehicle.partDestroyed.1", veh clientfield::get( "vtol_turret_destroyed_1" ) );
    }
}

// Namespace helicopter_gunner
// Params 7
// Checksum 0xeb96673e, Offset: 0x5a0
// Size: 0x9c
function fog_bank_2_callback( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( oldval != newval )
    {
        if ( newval == 1 )
        {
            setlitfogbank( localclientnum, -1, 1, 0 );
            return;
        }
        
        setlitfogbank( localclientnum, -1, 0, 0 );
    }
}

