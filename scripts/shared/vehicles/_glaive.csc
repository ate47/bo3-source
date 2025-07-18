#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace glaive;

// Namespace glaive
// Params 0, eflags: 0x2
// Checksum 0xcbdf1820, Offset: 0x1b0
// Size: 0x4c
function autoexec main()
{
    clientfield::register( "vehicle", "glaive_blood_fx", 1, 1, "int", &glaivebloodfxhandler, 0, 0 );
}

// Namespace glaive
// Params 7, eflags: 0x4
// Checksum 0x4f87c05d, Offset: 0x208
// Size: 0xdc
function private glaivebloodfxhandler( localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump )
{
    if ( isdefined( self.bloodfxhandle ) )
    {
        stopfx( localclientnum, self.bloodfxhandle );
        self.bloodfxhandle = undefined;
    }
    
    settings = struct::get_script_bundle( "vehiclecustomsettings", "glaivesettings" );
    
    if ( isdefined( settings ) )
    {
        if ( newvalue )
        {
            self.bloodfxhandle = playfxontag( localclientnum, settings.weakspotfx, self, "j_spineupper" );
        }
    }
}

