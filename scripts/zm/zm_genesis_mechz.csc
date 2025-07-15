#using scripts/codescripts/struct;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace zm_genesis_mechz;

// Namespace zm_genesis_mechz
// Params 0, eflags: 0x2
// Checksum 0xf7c34f46, Offset: 0x2b0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_genesis_mechz", &__init__, undefined, undefined );
}

// Namespace zm_genesis_mechz
// Params 0
// Checksum 0xcf13c96e, Offset: 0x2f0
// Size: 0xc4
function __init__()
{
    level._effect[ "tesla_zombie_shock" ] = "dlc4/genesis/fx_elec_trap_body_shock";
    
    if ( ai::shouldregisterclientfieldforarchetype( "mechz" ) )
    {
        clientfield::register( "actor", "death_ray_shock_fx", 15000, 1, "int", &death_ray_shock_fx, 0, 0 );
    }
    
    clientfield::register( "actor", "mechz_fx_spawn", 15000, 1, "counter", &function_4b9cfd4c, 0, 0 );
}

// Namespace zm_genesis_mechz
// Params 7
// Checksum 0x6328da43, Offset: 0x3c0
// Size: 0x124
function death_ray_shock_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self function_51adc559( localclientnum );
    
    if ( newval )
    {
        if ( !isdefined( self.tesla_shock_fx ) )
        {
            tag = "J_SpineUpper";
            
            if ( !self isai() )
            {
                tag = "tag_origin";
            }
            
            self.tesla_shock_fx = playfxontag( localclientnum, level._effect[ "tesla_zombie_shock" ], self, tag );
            self playsound( 0, "zmb_electrocute_zombie" );
        }
        
        if ( isdemoplaying() )
        {
            self thread function_7772592b( localclientnum );
        }
    }
}

// Namespace zm_genesis_mechz
// Params 1
// Checksum 0xf53bc5ba, Offset: 0x4f0
// Size: 0x4c
function function_7772592b( localclientnum )
{
    self notify( #"hash_51adc559" );
    self endon( #"hash_51adc559" );
    level waittill( #"demo_jump" );
    self function_51adc559( localclientnum );
}

// Namespace zm_genesis_mechz
// Params 1
// Checksum 0xb537c374, Offset: 0x548
// Size: 0x52
function function_51adc559( localclientnum )
{
    if ( isdefined( self.tesla_shock_fx ) )
    {
        deletefx( localclientnum, self.tesla_shock_fx, 1 );
        self.tesla_shock_fx = undefined;
    }
    
    self notify( #"hash_51adc559" );
}

// Namespace zm_genesis_mechz
// Params 7
// Checksum 0xedc769c0, Offset: 0x5a8
// Size: 0xa4
function function_4b9cfd4c( localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump )
{
    if ( newvalue )
    {
        self.spawnfx = playfxontag( localclientnum, level._effect[ "mechz_ground_spawn" ], self, "tag_origin" );
        playsound( 0, "zmb_mechz_spawn_nofly", self.origin );
    }
}

