#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;

#namespace _zm_weap_one_inch_punch;

// Namespace _zm_weap_one_inch_punch
// Params 0
// Checksum 0x34b56d3e, Offset: 0x120
// Size: 0x94
function init()
{
    clientfield::register( "allplayers", "oneinchpunch_impact", 21000, 1, "int", &oneinchpunch_impact, 0, 0 );
    clientfield::register( "actor", "oneinchpunch_physics_launchragdoll", 21000, 1, "int", &oneinchpunch_physics_launchragdoll, 0, 0 );
}

// Namespace _zm_weap_one_inch_punch
// Params 7
// Checksum 0x5bcc485e, Offset: 0x1c0
// Size: 0x17c
function oneinchpunch_impact( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    var_4383636a = 75;
    var_bf0c8e05 = 60;
    
    if ( newval == 1 )
    {
        if ( !isdefined( level.var_57220446 ) )
        {
            level.var_57220446 = [];
        }
        
        level.var_57220446[ self getentitynumber() ] = gettime();
        self earthquake( 0.5, 0.5, self.origin, 300 );
        self playrumbleonentity( localclientnum, "damage_heavy" );
        
        if ( isdefined( self.b_punch_upgraded ) && self.b_punch_upgraded && isdefined( self.str_punch_element ) && self.str_punch_element == "air" )
        {
            var_4383636a *= 2;
        }
        
        physicsexplosioncylinder( localclientnum, self.origin, var_4383636a, var_bf0c8e05, 1 );
    }
}

// Namespace _zm_weap_one_inch_punch
// Params 7
// Checksum 0xa4ad2197, Offset: 0x348
// Size: 0x1d4
function oneinchpunch_physics_launchragdoll( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    self endon( #"entity_shutdown" );
    
    if ( newval == 1 )
    {
        var_70efc576 = undefined;
        var_17013cd1 = 0;
        
        if ( isdefined( level.var_57220446 ) )
        {
            for ( i = 0; i < level.var_57220446.size ; i++ )
            {
                if ( isdefined( level.var_57220446[ i ] ) && level.var_57220446[ i ] > var_17013cd1 )
                {
                    var_70efc576 = i;
                    var_17013cd1 = level.var_57220446[ i ];
                }
            }
        }
        
        if ( isdefined( var_70efc576 ) )
        {
            a_players = getlocalplayers();
            var_b262e13f = a_players[ var_70efc576 ];
        }
        
        if ( isdefined( var_b262e13f ) )
        {
            v_launch = vectornormalize( self.origin - var_b262e13f.origin ) * randomintrange( 125, 150 ) + ( 0, 0, randomintrange( 75, 150 ) );
        }
        
        if ( isdefined( v_launch ) )
        {
            self launchragdoll( v_launch );
        }
    }
}

