#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;

#namespace zm_tomb_ambient_scripts;

// Namespace zm_tomb_ambient_scripts
// Params 0
// Checksum 0xcab87353, Offset: 0x150
// Size: 0x4c
function main()
{
    clientfield::register( "scriptmover", "zeppelin_fx", 21000, 1, "int", &zeppelin_fx, 0, 0 );
}

// Namespace zm_tomb_ambient_scripts
// Params 7
// Checksum 0xc1bc4b49, Offset: 0x1a8
// Size: 0xac
function zeppelin_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( newval )
    {
        self.var_1f4bb75 = playfxontag( localclientnum, level._effect[ "zeppelin_lights" ], self, "tag_body" );
        return;
    }
    
    if ( isdefined( self.var_1f4bb75 ) )
    {
        stopfx( localclientnum, self.var_1f4bb75 );
    }
}

