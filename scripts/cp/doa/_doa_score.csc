#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/cp_doa_bo3_fx;
#using scripts/cp/cp_doa_bo3_sound;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_camera;
#using scripts/cp/doa/_doa_core;
#using scripts/cp/doa/_doa_fx;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace doa_score;

// Namespace doa_score
// Params 0
// Checksum 0xcd6b6813, Offset: 0x438
// Size: 0x1bc
function init()
{
    clientfield::register( "world", "set_scoreHidden", 1, 1, "int", &function_7fe5e3f4, 0, 0 );
    
    for ( i = 0; i < 4 ; i++ )
    {
        clientfield::register( "world", "set_ui_gprDOA" + i, 1, 30, "int", &function_2db8b053, 0, 0 );
        clientfield::register( "world", "set_ui_gpr2DOA" + i, 1, 30, "int", &function_b9397b2b, 0, 0 );
        clientfield::register( "world", "set_ui_GlobalGPR" + i, 1, 30, "int", &function_e0f15ca4, 0, 0 );
    }
    
    clientfield::register( "world", "startCountdown", 1, 3, "int", &function_75319a37, 0, 0 );
    callback::on_spawned( &on_player_spawn );
    function_6fa6dee2();
}

// Namespace doa_score
// Params 0
// Checksum 0x3bbc555d, Offset: 0x600
// Size: 0x9ec
function function_6fa6dee2()
{
    globalmodel = getglobaluimodel();
    level.var_7e2a814c = createuimodel( globalmodel, "DeadOpsArcadeGlobal" );
    setuimodelvalue( createuimodel( level.var_7e2a814c, "gbanner" ), "" );
    setuimodelvalue( createuimodel( level.var_7e2a814c, "grgb1" ), "0 255 0" );
    setuimodelvalue( createuimodel( level.var_7e2a814c, "grgb2" ), "255 255 0" );
    setuimodelvalue( createuimodel( level.var_7e2a814c, "grgb3" ), "255 0 0" );
    setuimodelvalue( createuimodel( level.var_7e2a814c, "gtxt0" ), "" );
    setuimodelvalue( createuimodel( level.var_7e2a814c, "gpr0" ), 0 );
    setuimodelvalue( createuimodel( level.var_7e2a814c, "gpr1" ), 0 );
    setuimodelvalue( createuimodel( level.var_7e2a814c, "gpr2" ), 0 );
    setuimodelvalue( createuimodel( level.var_7e2a814c, "gpr3" ), 0 );
    setuimodelvalue( createuimodel( level.var_7e2a814c, "redins" ), "" );
    setuimodelvalue( createuimodel( level.var_7e2a814c, "countdown" ), "" );
    setuimodelvalue( createuimodel( level.var_7e2a814c, "level" ), 1 );
    setuimodelvalue( createuimodel( level.var_7e2a814c, "driving" ), 0 );
    setuimodelvalue( createuimodel( level.var_7e2a814c, "hint" ), "" );
    setuimodelvalue( createuimodel( level.var_7e2a814c, "instruct" ), "" );
    setuimodelvalue( createuimodel( level.var_7e2a814c, "round" ), 0 );
    setuimodelvalue( createuimodel( level.var_7e2a814c, "teleporter" ), 0 );
    setuimodelvalue( createuimodel( level.var_7e2a814c, "numexits" ), 0 );
    setuimodelvalue( createuimodel( level.var_7e2a814c, "gameover" ), 0 );
    setuimodelvalue( createuimodel( level.var_7e2a814c, "doafps" ), 0 );
    setuimodelvalue( createuimodel( level.var_7e2a814c, "changingLevel" ), 0 );
    level.var_b9d30140 = [];
    var_483f522 = createuimodel( globalmodel, "DeadOpsArcadePlayers" );
    
    for ( i = 1; i <= 4 ; i++ )
    {
        model = createuimodel( var_483f522, "player" + i );
        setuimodelvalue( createuimodel( model, "name" ), "" );
        setuimodelvalue( createuimodel( model, "lives" ), 0 );
        setuimodelvalue( createuimodel( model, "bombs" ), 0 );
        setuimodelvalue( createuimodel( model, "boosts" ), 0 );
        setuimodelvalue( createuimodel( model, "score" ), "0" );
        setuimodelvalue( createuimodel( model, "multiplier" ), 0 );
        setuimodelvalue( createuimodel( model, "xbar" ), 0 );
        setuimodelvalue( createuimodel( model, "bulletbar" ), 0 );
        setuimodelvalue( createuimodel( model, "bulletbar_rgb" ), "255 208 0" );
        setuimodelvalue( createuimodel( model, "ribbon" ), 0 );
        setuimodelvalue( createuimodel( model, "gpr_rgb" ), "0 255 0" );
        setuimodelvalue( createuimodel( model, "generic_txt" ), "" );
        setuimodelvalue( createuimodel( model, "gpr" ), 0 );
        setuimodelvalue( createuimodel( model, "gpr2" ), 0 );
        setuimodelvalue( createuimodel( model, "weaplevel1" ), 0 );
        setuimodelvalue( createuimodel( model, "weaplevel2" ), 0 );
        setuimodelvalue( createuimodel( model, "respawn" ), "" );
        level.var_b9d30140[ level.var_b9d30140.size ] = model;
    }
    
    level.var_c8a4d758 = 0;
    level.gpr = array( 0, 0, 0, 0 );
    level.var_29e6f519 = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        doa = spawnstruct();
        doa.ui_model = level.var_b9d30140[ i ];
        level.var_29e6f519[ level.var_29e6f519.size ] = doa;
        function_e06716c7( doa, i );
    }
    
    level thread function_cdb6d911();
    level thread function_4d819138();
    level thread function_2c9a6a47();
}

// Namespace doa_score
// Params 2
// Checksum 0x1413355f, Offset: 0xff8
// Size: 0x1f8
function function_d3f117f9( doa, idx )
{
    if ( !isdefined( doa ) )
    {
        return;
    }
    
    /#
        for ( i = 0; i < level.var_29e6f519.size ; i++ )
        {
            if ( level.var_29e6f519[ i ] == doa )
            {
                idx = i;
                break;
            }
        }
        
        txt = "<dev string:x28>" + ( isdefined( idx ) ? idx : "<dev string:x3e>" ) + "<dev string:x42>" + ( isdefined( doa.player ) ? doa.player getentitynumber() : "<dev string:x63>" );
        doa_core::debugmsg( txt );
    #/
    
    doa.score = 0;
    doa.var_db3637c0 = 0;
    doa.xbar = 0;
    doa.lives = 3;
    doa.bombs = 1;
    doa.boosters = 2;
    doa.bulletbar = 0;
    doa.multiplier = 1;
    doa.name = "";
    doa.gpr = 0;
    doa.gpr2 = 0;
    doa.var_4f0e30c = 0;
    doa.var_c88a6593 = 0;
    doa.isrespawning = 0;
}

// Namespace doa_score
// Params 2
// Checksum 0x6a1b22d2, Offset: 0x11f8
// Size: 0x4a4
function function_e06716c7( doa, idx )
{
    function_d3f117f9( doa, idx );
    
    if ( isdefined( doa.ui_model ) && isdefined( getuimodel( doa.ui_model, "name" ) ) )
    {
        setuimodelvalue( getuimodel( doa.ui_model, "name" ), doa.name );
        setuimodelvalue( getuimodel( doa.ui_model, "lives" ), doa.lives );
        setuimodelvalue( getuimodel( doa.ui_model, "bombs" ), doa.bombs );
        setuimodelvalue( getuimodel( doa.ui_model, "boosts" ), doa.boosters );
        setuimodelvalue( getuimodel( doa.ui_model, "score" ), "" + doa.score );
        setuimodelvalue( getuimodel( doa.ui_model, "multiplier" ), doa.multiplier );
        setuimodelvalue( getuimodel( doa.ui_model, "xbar" ), doa.xbar );
        setuimodelvalue( getuimodel( doa.ui_model, "bulletbar" ), doa.bulletbar );
        setuimodelvalue( getuimodel( doa.ui_model, "bulletbar_rgb" ), "255 208 0" );
        setuimodelvalue( getuimodel( doa.ui_model, "ribbon" ), 0 );
        setuimodelvalue( getuimodel( doa.ui_model, "gpr_rgb" ), "0 255 0" );
        setuimodelvalue( getuimodel( doa.ui_model, "generic_txt" ), "" );
        setuimodelvalue( getuimodel( doa.ui_model, "gpr" ), doa.gpr );
        setuimodelvalue( getuimodel( doa.ui_model, "gpr2" ), doa.gpr2 );
        setuimodelvalue( getuimodel( doa.ui_model, "weaplevel1" ), 0 );
        setuimodelvalue( getuimodel( doa.ui_model, "weaplevel2" ), 0 );
        setuimodelvalue( getuimodel( doa.ui_model, "respawn" ), "" );
    }
}

// Namespace doa_score
// Params 0
// Checksum 0x328408c6, Offset: 0x16a8
// Size: 0x1ee
function function_cdb6d911()
{
    self notify( #"hash_cdb6d911" );
    self endon( #"hash_cdb6d911" );
    
    while ( true )
    {
        foreach ( model in level.var_b9d30140 )
        {
            setuimodelvalue( getuimodel( model, "ribbon" ), 0 );
        }
        
        var_324ecf57 = level.var_29e6f519[ 0 ];
        
        foreach ( doa in level.var_29e6f519 )
        {
            if ( doa.score > var_324ecf57.score )
            {
                var_324ecf57 = doa;
            }
        }
        
        if ( getplayers( 0 ).size > 1 && isdefined( var_324ecf57 ) )
        {
            setuimodelvalue( getuimodel( var_324ecf57.ui_model, "ribbon" ), 1 );
        }
        
        wait 1;
    }
}

// Namespace doa_score
// Params 0
// Checksum 0x11c2e5b8, Offset: 0x18a0
// Size: 0x288
function function_4d819138()
{
    self notify( #"hash_4d819138" );
    self endon( #"hash_4d819138" );
    
    while ( true )
    {
        foreach ( doa in level.var_29e6f519 )
        {
            if ( !isdefined( doa.player ) )
            {
                continue;
            }
            
            var_9c4a2a35 = doa.player.score + doa.var_db3637c0 * int( 4e+06 );
            delta = var_9c4a2a35 - doa.score;
            
            if ( delta > 0 )
            {
                inc = 1;
                frac = int( 0.01 * delta );
                units = int( frac / inc );
                inc += units * inc;
                doa.score += inc;
                
                if ( doa.score > var_9c4a2a35 )
                {
                    doa.score = var_9c4a2a35;
                }
            }
            else if ( delta < 0 )
            {
                doa.score = 0;
            }
            
            score = doa.score * 25;
            setuimodelvalue( getuimodel( doa.ui_model, "score" ), "" + score );
        }
        
        wait 0.016;
    }
}

// Namespace doa_score
// Params 0
// Checksum 0x68482663, Offset: 0x1b30
// Size: 0xa6e
function function_2c9a6a47()
{
    self notify( #"hash_2c9a6a47" );
    self endon( #"hash_2c9a6a47" );
    
    while ( true )
    {
        wait 0.016;
        
        foreach ( doa in level.var_29e6f519 )
        {
            setuimodelvalue( getuimodel( doa.ui_model, "respawn" ), "" );
            
            if ( isdefined( level.var_c8a4d758 ) && level.var_c8a4d758 )
            {
                setuimodelvalue( getuimodel( doa.ui_model, "name" ), "" );
                setuimodelvalue( getuimodel( doa.ui_model, "weaplevel1" ), 0 );
                setuimodelvalue( getuimodel( doa.ui_model, "weaplevel2" ), 0 );
            }
            else
            {
                name = "";
                
                if ( isdefined( doa.player ) && isdefined( doa.player.name ) )
                {
                    name = doa.player.name;
                }
                
                setuimodelvalue( getuimodel( doa.ui_model, "name" ), name );
                
                if ( isdefined( doa.isrespawning ) && doa.isrespawning )
                {
                    setuimodelvalue( createuimodel( doa.ui_model, "name" ), istring( "DOA_RESPAWNING" ) );
                    val = "" + int( ceil( doa.xbar * 60 ) );
                    setuimodelvalue( getuimodel( doa.ui_model, "respawn" ), val );
                }
            }
            
            if ( isdefined( doa.player ) )
            {
                doa.lives = ( doa.player.headshots & 61440 ) >> 12;
                doa.bombs = ( doa.player.headshots & 3840 ) >> 8;
                doa.boosters = ( doa.player.headshots & 240 ) >> 4;
                doa.multiplier = doa.player.headshots & 15;
                doa.xbar = ( doa.player.downs >> 2 ) / 255;
                doa.bulletbar = ( doa.player.revives >> 2 ) / 255;
                doa.var_4f0e30c = doa.player.downs & 3;
                doa.isrespawning = doa.player.assists & 1;
                doa.var_db3637c0 = doa.player.assists >> 2;
                doa.var_c88a6593 = doa.player.revives & 3;
                
                if ( !isdefined( doa.player.var_8064cb04 ) || doa.player.var_8064cb04 != doa.var_c88a6593 )
                {
                    level notify( #"hash_aae01d5a", doa.player.entnum, doa.var_c88a6593 );
                }
            }
            
            setuimodelvalue( getuimodel( doa.ui_model, "bombs" ), doa.bombs );
            setuimodelvalue( getuimodel( doa.ui_model, "boosts" ), doa.boosters );
            setuimodelvalue( getuimodel( doa.ui_model, "lives" ), doa.lives );
            setuimodelvalue( getuimodel( doa.ui_model, "multiplier" ), doa.multiplier );
            setuimodelvalue( getuimodel( doa.ui_model, "xbar" ), doa.xbar );
            setuimodelvalue( getuimodel( doa.ui_model, "bulletbar" ), doa.bulletbar );
            setuimodelvalue( getuimodel( doa.ui_model, "weaplevel1" ), 0 );
            setuimodelvalue( getuimodel( doa.ui_model, "weaplevel2" ), 0 );
            
            if ( !( isdefined( level.var_c8a4d758 ) && level.var_c8a4d758 ) )
            {
                switch ( doa.var_4f0e30c )
                {
                    case 0:
                        setuimodelvalue( getuimodel( doa.ui_model, "weaplevel1" ), 0 );
                        setuimodelvalue( getuimodel( doa.ui_model, "weaplevel2" ), 0 );
                        setuimodelvalue( getuimodel( doa.ui_model, "bulletbar_rgb" ), "255 208 0" );
                        break;
                    case 1:
                        setuimodelvalue( getuimodel( doa.ui_model, "weaplevel1" ), 1 );
                        setuimodelvalue( getuimodel( doa.ui_model, "weaplevel2" ), 0 );
                        setuimodelvalue( getuimodel( doa.ui_model, "bulletbar_rgb" ), "255 0 0" );
                        break;
                    case 2:
                        setuimodelvalue( getuimodel( doa.ui_model, "weaplevel1" ), 1 );
                        setuimodelvalue( getuimodel( doa.ui_model, "weaplevel2" ), 1 );
                        setuimodelvalue( getuimodel( doa.ui_model, "bulletbar_rgb" ), "128 0 255" );
                        break;
                }
            }
            
            setuimodelvalue( getuimodel( doa.ui_model, "gpr" ), doa.gpr );
            setuimodelvalue( getuimodel( doa.ui_model, "gpr2" ), doa.gpr2 );
        }
    }
}

// Namespace doa_score
// Params 2
// Checksum 0xae7c7e1, Offset: 0x25a8
// Size: 0x9c
function on_shutdown( localclientnum, ent )
{
    if ( isdefined( ent ) && self === ent )
    {
        /#
            doa_core::debugmsg( "<dev string:x67>" + ( isdefined( self.name ) ? self.name : self getentitynumber() ) );
        #/
        
        if ( isdefined( self.doa ) )
        {
            function_e06716c7( self.doa );
        }
    }
}

// Namespace doa_score
// Params 1
// Checksum 0x801c95ee, Offset: 0x2650
// Size: 0x2c
function on_player_spawn( localclientnum )
{
    self callback::on_shutdown( &on_shutdown, self );
}

// Namespace doa_score
// Params 7
// Checksum 0x82eedf2c, Offset: 0x2688
// Size: 0x48
function function_7fe5e3f4( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    level.var_c8a4d758 = newval;
}

// Namespace doa_score
// Params 7
// Checksum 0xa3b1fa89, Offset: 0x26d8
// Size: 0x134
function function_e0f15ca4( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    diff = newval - oldval;
    
    if ( diff )
    {
        level notify( #"hash_48152b36", fieldname, diff );
    }
    
    idx = int( fieldname[ fieldname.size - 1 ] );
    assert( idx >= 0 && idx < level.gpr.size );
    level.gpr[ idx ] = newval;
    field = "gpr" + idx;
    setuimodelvalue( createuimodel( level.var_7e2a814c, field ), newval );
}

// Namespace doa_score
// Params 7
// Checksum 0x7436d51, Offset: 0x2818
// Size: 0x8c
function function_2db8b053( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playernum = int( fieldname[ fieldname.size - 1 ] );
    level.var_29e6f519[ playernum ].gpr = newval;
}

// Namespace doa_score
// Params 7
// Checksum 0x809a7227, Offset: 0x28b0
// Size: 0x8c
function function_b9397b2b( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playernum = int( fieldname[ fieldname.size - 1 ] );
    level.var_29e6f519[ playernum ].gpr2 = newval;
}

// Namespace doa_score
// Params 7
// Checksum 0xf012797e, Offset: 0x2948
// Size: 0x3c
function function_6ccafee6( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    
}

// Namespace doa_score
// Params 7
// Checksum 0x2ac96c0b, Offset: 0x2990
// Size: 0x7c
function function_75319a37( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 0 )
    {
        return;
    }
    
    if ( isdefined( level.var_b1ce5a88 ) && level.var_b1ce5a88 )
    {
        return;
    }
    
    level thread function_56dd76b( newval );
}

// Namespace doa_score
// Params 1
// Checksum 0xa0414ce1, Offset: 0x2a18
// Size: 0x130
function function_a08fe7c3( totaltime )
{
    totaltime *= 1000;
    curtime = gettime();
    endtime = curtime + totaltime;
    
    while ( curtime < endtime )
    {
        curtime = gettime();
        diff = endtime - curtime;
        ratio = diff / totaltime;
        r = 255 * ratio;
        g = 255 * ( 1 - ratio );
        rgb = r + " " + g + " 0";
        setuimodelvalue( getuimodel( level.var_7e2a814c, "grgb1" ), rgb );
        wait 0.016;
    }
}

// Namespace doa_score
// Params 1
// Checksum 0xb31b4eeb, Offset: 0x2b50
// Size: 0x1e0
function function_56dd76b( val )
{
    level.var_b1ce5a88 = 1;
    startval = val;
    level thread function_a08fe7c3( startval * 1.1 );
    
    while ( val > 0 )
    {
        setuimodelvalue( getuimodel( level.var_7e2a814c, "countdown" ), "" + val );
        playsound( 0, "evt_countdown", ( 0, 0, 0 ) );
        wait 1.05;
        setuimodelvalue( getuimodel( level.var_7e2a814c, "countdown" ), "" );
        wait 0.016;
        val -= 1;
        level notify( #"countdown", val );
    }
    
    level notify( #"countdown", 0 );
    setuimodelvalue( getuimodel( level.var_7e2a814c, "countdown" ), &"CP_DOA_BO3_GO" );
    playsound( 0, "evt_countdown_go", ( 0, 0, 0 ) );
    wait 1.1;
    setuimodelvalue( getuimodel( level.var_7e2a814c, "countdown" ), "" );
    level.var_b1ce5a88 = 0;
}

// Namespace doa_score
// Params 1
// Checksum 0x9b1ecb2c, Offset: 0x2d38
// Size: 0x44
function function_ecca2450( text )
{
    setuimodelvalue( getuimodel( level.var_7e2a814c, "countdown" ), text );
}

