#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace zm_stalingrad_mounted_mg;

// Namespace zm_stalingrad_mounted_mg
// Params 0, eflags: 0x2
// Checksum 0x8989e3b4, Offset: 0x190
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_stalingrad_mounted_mg", &__init__, undefined, undefined );
}

// Namespace zm_stalingrad_mounted_mg
// Params 0
// Checksum 0xfdc67ffc, Offset: 0x1d0
// Size: 0x64
function __init__()
{
    level._effect[ "mounted_mg_overheat" ] = "dlc3/stalingrad/fx_mg42_over_heat";
    clientfield::register( "vehicle", "overheat_fx", 12000, 1, "int", &function_c71f5e4a, 0, 0 );
}

// Namespace zm_stalingrad_mounted_mg
// Params 7
// Checksum 0xc81e841f, Offset: 0x240
// Size: 0xac
function function_c71f5e4a( n_local_client, n_old, n_new, b_new_ent, b_initial_snap, str_field, b_was_time_jump )
{
    if ( n_new )
    {
        self.var_b4b6b5a6 = playfxontag( n_local_client, level._effect[ "mounted_mg_overheat" ], self, "tag_flash" );
        return;
    }
    
    if ( isdefined( self.var_b4b6b5a6 ) )
    {
        stopfx( n_local_client, self.var_b4b6b5a6 );
    }
}

