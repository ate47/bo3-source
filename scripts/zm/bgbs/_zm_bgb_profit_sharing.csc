#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_profit_sharing;

// Namespace zm_bgb_profit_sharing
// Params 0, eflags: 0x2
// Checksum 0x7fa579b3, Offset: 0x1f8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_bgb_profit_sharing", &__init__, undefined, undefined );
}

// Namespace zm_bgb_profit_sharing
// Params 0
// Checksum 0x8cf3600f, Offset: 0x238
// Size: 0xd8
function __init__()
{
    if ( !( isdefined( level.bgb_in_use ) && level.bgb_in_use ) )
    {
        return;
    }
    
    clientfield::register( "allplayers", "zm_bgb_profit_sharing_3p_fx", 15000, 1, "int", &function_df72a623, 0, 0 );
    clientfield::register( "toplayer", "zm_bgb_profit_sharing_1p_fx", 15000, 1, "int", &function_f683a0e1, 0, 1 );
    bgb::register( "zm_bgb_profit_sharing", "time" );
    level.var_75dff42 = [];
}

// Namespace zm_bgb_profit_sharing
// Params 7
// Checksum 0x8a6bb27d, Offset: 0x318
// Size: 0x128
function function_df72a623( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    e_local_player = getlocalplayer( localclientnum );
    
    if ( newval )
    {
        if ( e_local_player != self )
        {
            if ( !isdefined( self.var_3485cf73 ) )
            {
                self.var_3485cf73 = [];
            }
            
            if ( isdefined( self.var_3485cf73[ localclientnum ] ) )
            {
                return;
            }
            
            self.var_3485cf73[ localclientnum ] = playfxontag( localclientnum, "zombie/fx_bgb_profit_3p", self, "j_spine4" );
        }
        
        return;
    }
    
    if ( isdefined( self.var_3485cf73 ) && isdefined( self.var_3485cf73[ localclientnum ] ) )
    {
        stopfx( localclientnum, self.var_3485cf73[ localclientnum ] );
        self.var_3485cf73[ localclientnum ] = undefined;
    }
}

// Namespace zm_bgb_profit_sharing
// Params 7
// Checksum 0x6b98415e, Offset: 0x448
// Size: 0xf8
function function_f683a0e1( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        if ( isdefined( level.var_75dff42[ localclientnum ] ) )
        {
            deletefx( localclientnum, level.var_75dff42[ localclientnum ] );
        }
        
        level.var_75dff42[ localclientnum ] = playfxoncamera( localclientnum, "zombie/fx_bgb_profit_1p", ( 0, 0, 0 ), ( 1, 0, 0 ) );
        return;
    }
    
    if ( isdefined( level.var_75dff42[ localclientnum ] ) )
    {
        stopfx( localclientnum, level.var_75dff42[ localclientnum ] );
        level.var_75dff42[ localclientnum ] = undefined;
    }
}

