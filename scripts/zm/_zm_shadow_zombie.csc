#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_elemental_zombies;

#namespace zm_shadow_zombie;

// Namespace zm_shadow_zombie
// Params 0, eflags: 0x2
// Checksum 0xe4d80363, Offset: 0x3c8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_shadow_zombie", &__init__, undefined, undefined );
}

// Namespace zm_shadow_zombie
// Params 0
// Checksum 0xfc736e13, Offset: 0x408
// Size: 0x24
function __init__()
{
    init_fx();
    register_clientfields();
}

// Namespace zm_shadow_zombie
// Params 0
// Checksum 0xe77bbfa5, Offset: 0x438
// Size: 0x8a
function init_fx()
{
    level._effect[ "shadow_zombie_fx" ] = "dlc4/genesis/fx_zombie_shadow_ambient_trail";
    level._effect[ "shadow_zombie_suicide" ] = "dlc4/genesis/fx_zombie_shadow_death";
    level._effect[ "dlc4/genesis/fx_zombie_shadow_damage" ] = "shadow_zombie_damage_fx";
    
    if ( !isdefined( level._effect[ "mini_curse_circle" ] ) )
    {
        level._effect[ "mini_curse_circle" ] = "dlc4/genesis/fx_zombie_shadow_trap_ambient";
    }
}

// Namespace zm_shadow_zombie
// Params 0
// Checksum 0xf52ffac4, Offset: 0x4d0
// Size: 0x124
function register_clientfields()
{
    clientfield::register( "actor", "shadow_zombie_clientfield_aura_fx", 15000, 1, "int", &function_384150e9, 0, 0 );
    clientfield::register( "actor", "shadow_zombie_clientfield_death_fx", 15000, 1, "int", &function_ac1abcb6, 0, 0 );
    clientfield::register( "actor", "shadow_zombie_clientfield_damaged_fx", 15000, 1, "counter", &function_b3071651, 0, 0 );
    clientfield::register( "scriptmover", "shadow_zombie_cursetrap_fx", 15000, 1, "int", &shadow_zombie_cursetrap_fx, 0, 0 );
}

// Namespace zm_shadow_zombie
// Params 7
// Checksum 0x18e8e2ef, Offset: 0x600
// Size: 0x98
function function_ac1abcb6( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( oldval !== newval && newval === 1 )
    {
        fx = playfxontag( localclientnum, level._effect[ "shadow_zombie_suicide" ], self, "j_spineupper" );
    }
}

// Namespace zm_shadow_zombie
// Params 7
// Checksum 0x651a5efb, Offset: 0x6a0
// Size: 0x144
function function_b3071651( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"entityshutdown" );
    self util::waittill_dobj( localclientnum );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( newval )
    {
        if ( isdefined( level._effect[ "dlc4/genesis/fx_zombie_shadow_damage" ] ) )
        {
            playsound( localclientnum, "gdt_electro_bounce", self.origin );
            locs = array( "j_wrist_le", "j_wrist_ri" );
            fx = playfxontag( localclientnum, level._effect[ "dlc4/genesis/fx_zombie_shadow_damage" ], self, array::random( locs ) );
            setfxignorepause( localclientnum, fx, 1 );
        }
    }
}

// Namespace zm_shadow_zombie
// Params 7
// Checksum 0xc2ab0e57, Offset: 0x7f0
// Size: 0xec
function function_384150e9( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !isdefined( newval ) )
    {
        return;
    }
    
    if ( newval == 1 )
    {
        fx = playfxontag( localclientnum, level._effect[ "shadow_zombie_fx" ], self, "j_spineupper" );
        fx2 = playfxontag( localclientnum, level._effect[ "shadow_zombie_fx" ], self, "j_head" );
        setfxignorepause( localclientnum, fx, 1 );
    }
}

// Namespace zm_shadow_zombie
// Params 7
// Checksum 0xf50f6103, Offset: 0x8e8
// Size: 0x114
function shadow_zombie_cursetrap_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( isdefined( self.sndlooper ) )
    {
        self stoploopsound( self.sndlooper, 0.5 );
        self.sndlooper = undefined;
        self playsound( 0, "zmb_zod_cursed_landmine_end" );
    }
    
    if ( newval )
    {
        self.sndlooper = self playloopsound( "zmb_zod_cursed_landmine_lp", 1 );
        self playsound( 0, "zmb_zod_cursed_landmine_start" );
    }
    
    self function_267f859f( localclientnum, level._effect[ "mini_curse_circle" ], newval, 1 );
}

// Namespace zm_shadow_zombie
// Params 5
// Checksum 0x98bcbf9a, Offset: 0xa08
// Size: 0x18e
function function_267f859f( localclientnum, fx_id, b_on, b_is_ent, str_tag )
{
    if ( !isdefined( fx_id ) )
    {
        fx_id = undefined;
    }
    
    if ( !isdefined( b_on ) )
    {
        b_on = 1;
    }
    
    if ( !isdefined( b_is_ent ) )
    {
        b_is_ent = 0;
    }
    
    if ( !isdefined( str_tag ) )
    {
        str_tag = "tag_origin";
    }
    
    if ( b_on )
    {
        if ( isdefined( self.vfx_ref ) )
        {
            stopfx( localclientnum, self.vfx_ref );
        }
        
        if ( b_is_ent )
        {
            self.vfx_ref = playfxontag( localclientnum, fx_id, self, str_tag );
        }
        else if ( self.angles === ( 0, 0, 0 ) )
        {
            self.vfx_ref = playfx( localclientnum, fx_id, self.origin );
        }
        else
        {
            self.vfx_ref = playfx( localclientnum, fx_id, self.origin, self.angles );
        }
        
        return;
    }
    
    if ( isdefined( self.vfx_ref ) )
    {
        stopfx( localclientnum, self.vfx_ref );
        self.vfx_ref = undefined;
    }
}

