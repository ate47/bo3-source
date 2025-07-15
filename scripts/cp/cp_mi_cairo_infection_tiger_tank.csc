#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace tiger_tank;

// Namespace tiger_tank
// Params 0, eflags: 0x2
// Checksum 0xd0a90d85, Offset: 0x178
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "tiger_tank", &__init__, undefined, undefined );
}

// Namespace tiger_tank
// Params 0
// Checksum 0xde87fb5e, Offset: 0x1b8
// Size: 0x94
function __init__()
{
    clientfield::register( "vehicle", "tiger_tank_retreat_fx", 1, 1, "int", &callback_retreat_fx, 0, 0 );
    clientfield::register( "vehicle", "tiger_tank_disable_sfx", 1, 1, "int", &callback_disable_sfx, 0, 0 );
}

// Namespace tiger_tank
// Params 7
// Checksum 0x17fd4941, Offset: 0x258
// Size: 0xac
function callback_retreat_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self fx_play( localclientnum, "retreat_fx", "explosions/fx_exp_grenade_smoke", 1, self.origin );
        return;
    }
    
    self fx_clear( localclientnum, "retreat_fx", "explosions/fx_exp_grenade_smoke" );
}

// Namespace tiger_tank
// Params 3
// Checksum 0x9c060a37, Offset: 0x310
// Size: 0x10c
function fx_clear( localclientnum, str_type, str_fx )
{
    if ( !isdefined( self.a_fx ) )
    {
        self.a_fx = [];
    }
    
    if ( !isdefined( self.a_fx[ localclientnum ] ) )
    {
        self.a_fx[ localclientnum ] = [];
    }
    
    if ( !isdefined( self.a_fx[ localclientnum ][ str_type ] ) )
    {
        self.a_fx[ localclientnum ][ str_type ] = [];
    }
    
    if ( isdefined( str_fx ) && isdefined( self.a_fx[ localclientnum ][ str_type ][ str_fx ] ) )
    {
        n_fx_id = self.a_fx[ localclientnum ][ str_type ][ str_fx ];
        deletefx( localclientnum, n_fx_id, 0 );
        self.a_fx[ localclientnum ][ str_type ][ str_fx ] = undefined;
    }
}

// Namespace tiger_tank
// Params 7
// Checksum 0x541d25bc, Offset: 0x428
// Size: 0x15e
function fx_play( localclientnum, str_type, str_fx, b_kill_fx_with_same_type, v_pos, v_forward, v_up )
{
    if ( !isdefined( b_kill_fx_with_same_type ) )
    {
        b_kill_fx_with_same_type = 1;
    }
    
    self fx_clear( localclientnum, str_type, str_fx );
    
    if ( b_kill_fx_with_same_type )
    {
        self fx_delete_type( localclientnum, str_type, 0 );
    }
    
    if ( isdefined( v_forward ) && isdefined( v_up ) )
    {
        n_fx_id = playfx( localclientnum, str_fx, v_pos, v_forward, v_up );
    }
    else if ( isdefined( v_forward ) )
    {
        n_fx_id = playfx( localclientnum, str_fx, v_pos, v_forward );
    }
    else
    {
        n_fx_id = playfx( localclientnum, str_fx, v_pos );
    }
    
    self.a_fx[ localclientnum ][ str_type ][ str_fx ] = n_fx_id;
}

// Namespace tiger_tank
// Params 3
// Checksum 0x9408f114, Offset: 0x590
// Size: 0x11e
function fx_delete_type( localclientnum, str_type, b_stop_immediately )
{
    if ( !isdefined( b_stop_immediately ) )
    {
        b_stop_immediately = 1;
    }
    
    if ( isdefined( self.a_fx ) && isdefined( self.a_fx[ localclientnum ] ) && isdefined( self.a_fx[ localclientnum ][ str_type ] ) )
    {
        a_keys = getarraykeys( self.a_fx[ localclientnum ][ str_type ] );
        
        for ( i = 0; i < a_keys.size ; i++ )
        {
            deletefx( localclientnum, self.a_fx[ localclientnum ][ str_type ][ a_keys[ i ] ], b_stop_immediately );
            self.a_fx[ localclientnum ][ str_type ][ a_keys[ i ] ] = undefined;
        }
    }
}

// Namespace tiger_tank
// Params 7
// Checksum 0x64625866, Offset: 0x6b8
// Size: 0x74
function callback_disable_sfx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self disablevehiclesounds();
        return;
    }
    
    self enablevehiclesounds();
}

