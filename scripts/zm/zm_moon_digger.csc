#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace zm_moon_digger;

// Namespace zm_moon_digger
// Params 0
// Checksum 0x4f4eed3c, Offset: 0x268
// Size: 0x1c
function main()
{
    level thread init_excavator_consoles();
}

// Namespace zm_moon_digger
// Params 7
// Checksum 0xe01f350f, Offset: 0x290
// Size: 0x1aa
function digger_moving_earthquake_rumble( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( localclientnum != 0 )
    {
        return;
    }
    
    if ( newval )
    {
        for ( i = 0; i < level.localplayers.size ; i++ )
        {
            level thread do_digger_moving_earthquake_rumble( i, self );
        }
        
        return;
    }
    
    if ( isdefined( self.headlight1 ) )
    {
        for ( i = 0; i < level.localplayers.size ; i++ )
        {
            stopfx( i, self.headlight1 );
            stopfx( i, self.headlight2 );
            stopfx( i, self.blink1 );
            stopfx( i, self.blink2 );
            
            if ( isdefined( self.tread_fx ) )
            {
                stopfx( i, self.tread_fx );
            }
            
            if ( isdefined( self.var_deef11e2 ) )
            {
                stopfx( i, self.var_deef11e2 );
            }
        }
    }
    
    self notify( #"stop_moving_rumble" );
}

// Namespace zm_moon_digger
// Params 7
// Checksum 0x11b4843c, Offset: 0x448
// Size: 0x5c
function function_a0cf54a0( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( newval )
    {
        level thread function_1e254f15();
    }
}

// Namespace zm_moon_digger
// Params 0
// Checksum 0xb3dabe75, Offset: 0x4b0
// Size: 0x148
function function_1e254f15()
{
    for ( i = 0; i < level.localplayers.size ; i++ )
    {
        player = getlocalplayers()[ i ];
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        piece = struct::get( "biodome_breached", "targetname" );
        
        if ( distancesquared( player.origin, piece.origin ) < 6250000 )
        {
            player earthquake( 0.5, 3, player.origin, 1500 );
            player thread bio_breach_rumble( i );
        }
        
        scene::play( "p7_fxanim_zmhd_moon_biodome_glass_bundle" );
        level notify( #"sl9" );
        level notify( #"sl10" );
    }
}

// Namespace zm_moon_digger
// Params 1
// Checksum 0xdbfff6d0, Offset: 0x600
// Size: 0x7e
function bio_breach_rumble( localclientnum )
{
    self endon( #"disconnect" );
    
    for ( i = 0; i < 10 ; i++ )
    {
        self playrumbleonentity( localclientnum, "damage_heavy" );
        wait randomfloatrange( 0.1, 0.2 );
    }
}

// Namespace zm_moon_digger
// Params 7
// Checksum 0xc8bae123, Offset: 0x688
// Size: 0xae
function digger_digging_earthquake_rumble( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( localclientnum != 0 )
    {
        return;
    }
    
    if ( newval )
    {
        for ( i = 0; i < level.localplayers.size ; i++ )
        {
            level thread do_digger_digging_earthquake_rumble( i, self );
        }
        
        return;
    }
    
    self notify( #"stop_digging_rumble" );
}

// Namespace zm_moon_digger
// Params 2
// Checksum 0xa0b22697, Offset: 0x740
// Size: 0x1d8
function do_digger_moving_earthquake_rumble( localclientnum, quake_ent )
{
    quake_ent util::waittill_dobj( localclientnum );
    quake_ent endon( #"entityshutdown" );
    quake_ent endon( #"stop_moving_rumble" );
    dist_sqd = 6250000;
    quake_ent.tread_fx = playfxontag( localclientnum, level._effect[ "digger_treadfx_fwd" ], quake_ent, "tag_origin" );
    quake_ent.var_deef11e2 = playfxontag( localclientnum, level._effect[ "exca_body_all" ], quake_ent, "tag_origin" );
    player = getlocalplayers()[ localclientnum ];
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    while ( true )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        player earthquake( randomfloatrange( 0.15, 0.25 ), 3, quake_ent.origin, 2500 );
        
        if ( distancesquared( quake_ent.origin, player.origin ) < dist_sqd )
        {
            player playrumbleonentity( localclientnum, "slide_rumble" );
        }
        
        wait randomfloatrange( 0.05, 0.15 );
    }
}

// Namespace zm_moon_digger
// Params 2
// Checksum 0x39b1720f, Offset: 0x920
// Size: 0x198
function do_digger_digging_earthquake_rumble( localclientnum, quake_ent )
{
    quake_ent endon( #"entityshutdown" );
    quake_ent endon( #"stop_digging_rumble" );
    player = getlocalplayers()[ localclientnum ];
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    count = 0;
    dist = 2250000;
    
    while ( true )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        player earthquake( randomfloatrange( 0.12, 0.17 ), 3, quake_ent.origin, 1500 );
        
        if ( distancesquared( quake_ent.origin, player.origin ) < dist && abs( quake_ent.origin[ 2 ] - player.origin[ 2 ] ) < 750 )
        {
            player playrumbleonentity( localclientnum, "grenade_rumble" );
        }
        
        wait randomfloatrange( 0.1, 0.25 );
    }
}

// Namespace zm_moon_digger
// Params 7
// Checksum 0xa4d7b11b, Offset: 0xac0
// Size: 0x15e
function digger_arm_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( localclientnum != 0 )
    {
        return;
    }
    
    if ( newval )
    {
        for ( i = 0; i < level.localplayers.size ; i++ )
        {
            level thread do_digger_arm_fx( i, self );
        }
        
        return;
    }
    
    if ( isdefined( self.blink1 ) )
    {
        for ( i = 0; i < level.localplayers.size ; i++ )
        {
            stopfx( i, self.blink1 );
            stopfx( i, self.blink2 );
        }
    }
    
    if ( isdefined( self.var_5f9ccb3a ) )
    {
        for ( i = 0; i < level.localplayers.size ; i++ )
        {
            stopfx( i, self.var_5f9ccb3a );
        }
    }
}

// Namespace zm_moon_digger
// Params 2
// Checksum 0x405bec01, Offset: 0xc28
// Size: 0x90
function do_digger_arm_fx( localclientnum, ent )
{
    ent endon( #"entityshutdown" );
    player = getlocalplayers()[ localclientnum ];
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    ent.var_5f9ccb3a = playfxontag( localclientnum, level._effect[ "exca_arm_all" ], ent, "tag_origin" );
}

// Namespace zm_moon_digger
// Params 7
// Checksum 0xa1753ab6, Offset: 0xcc0
// Size: 0x8c
function function_245b13ce( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( newval )
    {
        level thread digger_visibility_toggle( localclientnum, "hide" );
        return;
    }
    
    level thread digger_visibility_toggle( localclientnum, "show" );
}

// Namespace zm_moon_digger
// Params 2
// Checksum 0x2f718ed7, Offset: 0xd58
// Size: 0x33a
function digger_visibility_toggle( localclient, visible )
{
    diggers = getentarray( localclient, "digger_body", "targetname" );
    tracks = getentarray( localclient, "tracks", "targetname" );
    
    switch ( visible )
    {
        case "hide":
            for ( i = 0; i < tracks.size ; i++ )
            {
                tracks[ i ] hide();
            }
            
            for ( i = 0; i < diggers.size ; i++ )
            {
                arm = getent( localclient, diggers[ i ].target, "targetname" );
                blade_center = getent( localclient, arm.target, "targetname" );
                blade = getent( localclient, blade_center.target, "targetname" );
                diggers[ i ] hide();
                arm hide();
                blade hide();
            }
            
            break;
        default:
            for ( i = 0; i < tracks.size ; i++ )
            {
                tracks[ i ] show();
            }
            
            for ( i = 0; i < diggers.size ; i++ )
            {
                arm = getent( localclient, diggers[ i ].target, "targetname" );
                blade_center = getent( localclient, arm.target, "targetname" );
                blade = getent( localclient, blade_center.target, "targetname" );
                diggers[ i ] show();
                arm show();
                blade show();
            }
            
            break;
    }
}

// Namespace zm_moon_digger
// Params 0
// Checksum 0x31b1cc67, Offset: 0x10a0
// Size: 0x176
function init_excavator_consoles()
{
    wait 15;
    
    for ( index = 0; index < level.localplayers.size ; index++ )
    {
        if ( !level clientfield::get( "TCA" ) )
        {
            mdl_console = getent( index, "tunnel_console", "targetname" );
            function_9b3daafa( index, mdl_console, 0 );
        }
        
        if ( !level clientfield::get( "HCA" ) )
        {
            mdl_console = getent( index, "hangar_console", "targetname" );
            function_9b3daafa( index, mdl_console, 0 );
        }
        
        if ( !level clientfield::get( "BCA" ) )
        {
            mdl_console = getent( index, "biodome_console", "targetname" );
            function_9b3daafa( index, mdl_console, 0 );
        }
    }
}

// Namespace zm_moon_digger
// Params 7
// Checksum 0x77da2126, Offset: 0x1220
// Size: 0x10c
function function_774edb15( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    switch ( fieldname )
    {
        default:
            var_ffc320da = "tunnel_console";
            break;
        case "HCA":
            var_ffc320da = "hangar_console";
            break;
        case "BCA":
            var_ffc320da = "biodome_console";
            break;
    }
    
    mdl_console = getent( localclientnum, var_ffc320da, "targetname" );
    
    if ( newval )
    {
        function_9b3daafa( localclientnum, mdl_console, 1 );
        return;
    }
    
    function_9b3daafa( localclientnum, mdl_console, 0 );
}

// Namespace zm_moon_digger
// Params 3
// Checksum 0x7278c0de, Offset: 0x1338
// Size: 0xe8
function function_9b3daafa( localclientnum, mdl_console, var_a61a4e58 )
{
    if ( isdefined( mdl_console.n_fx_id ) )
    {
        stopfx( localclientnum, mdl_console.n_fx_id );
    }
    
    if ( var_a61a4e58 )
    {
        mdl_console.n_fx_id = playfxontag( localclientnum, level._effect[ "panel_on" ], mdl_console, "tag_origin" );
        return;
    }
    
    mdl_console.n_fx_id = playfxontag( localclientnum, level._effect[ "panel_off" ], mdl_console, "tag_origin" );
}

