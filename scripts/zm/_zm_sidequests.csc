#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;

#namespace zm_sidequests;

// Namespace zm_sidequests
// Params 2
// Checksum 0xef1a64ca, Offset: 0xf0
// Size: 0xac
function register_sidequest_icon( icon_name, version_number )
{
    clientfieldprefix = "sidequestIcons." + icon_name + ".";
    clientfield::register( "clientuimodel", clientfieldprefix + "icon", version_number, 1, "int", undefined, 0, 0 );
    clientfield::register( "clientuimodel", clientfieldprefix + "notification", version_number, 1, "int", undefined, 0, 0 );
}

