#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace art;

// Namespace art
// Params 0, eflags: 0x2
// Checksum 0x21449a9b, Offset: 0x1a8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "art", &__init__, undefined, undefined );
}

// Namespace art
// Params 0
// Checksum 0xa7133ad0, Offset: 0x1e8
// Size: 0x234
function __init__()
{
    /#
        if ( getdvarstring( "<dev string:x28>" ) == "<dev string:x36>" || getdvarstring( "<dev string:x28>" ) == "<dev string:x37>" )
        {
            setdvar( "<dev string:x28>", 0 );
        }
        
        if ( getdvarstring( "<dev string:x39>" ) == "<dev string:x36>" )
        {
            setdvar( "<dev string:x39>", "<dev string:x48>" );
        }
        
        if ( getdvarstring( "<dev string:x4a>" ) == "<dev string:x36>" )
        {
            setdvar( "<dev string:x4a>", "<dev string:x48>" );
        }
        
        if ( getdvarstring( "<dev string:x62>" ) == "<dev string:x36>" && isdefined( level.script ) )
        {
            setdvar( "<dev string:x62>", level.script );
        }
    #/
    
    if ( !isdefined( level.dofdefault ) )
    {
        level.dofdefault[ "nearStart" ] = 0;
        level.dofdefault[ "nearEnd" ] = 1;
        level.dofdefault[ "farStart" ] = 8000;
        level.dofdefault[ "farEnd" ] = 10000;
        level.dofdefault[ "nearBlur" ] = 6;
        level.dofdefault[ "farBlur" ] = 0;
    }
    
    level.curdof = ( level.dofdefault[ "farStart" ] - level.dofdefault[ "nearEnd" ] ) / 2;
    
    /#
        thread tweakart();
    #/
}

/#

    // Namespace art
    // Params 2
    // Checksum 0xb2db437f, Offset: 0x428
    // Size: 0x44, Type: dev
    function artfxprintln( file, string )
    {
        if ( file == -1 )
        {
            return;
        }
        
        fprintln( file, string );
    }

#/

// Namespace art
// Params 2
// Checksum 0x5585d4b9, Offset: 0x478
// Size: 0xd4
function strtok_loc( string, par1 )
{
    stringlist = [];
    indexstring = "";
    
    for ( i = 0; i < string.size ; i++ )
    {
        if ( string[ i ] == " " )
        {
            stringlist[ stringlist.size ] = indexstring;
            indexstring = "";
            continue;
        }
        
        indexstring += string[ i ];
    }
    
    if ( indexstring.size )
    {
        stringlist[ stringlist.size ] = indexstring;
    }
    
    return stringlist;
}

// Namespace art
// Params 0
// Checksum 0x2c278114, Offset: 0x558
// Size: 0x1b4
function setfogsliders()
{
    fogall = strtok_loc( getdvarstring( "g_fogColorReadOnly" ), " " );
    red = fogall[ 0 ];
    green = fogall[ 1 ];
    blue = fogall[ 2 ];
    halfplane = getdvarstring( "g_fogHalfDistReadOnly" );
    nearplane = getdvarstring( "g_fogStartDistReadOnly" );
    
    if ( !isdefined( red ) || !isdefined( green ) || !isdefined( blue ) || !isdefined( halfplane ) )
    {
        red = 1;
        green = 1;
        blue = 1;
        halfplane = 10000001;
        nearplane = 10000000;
    }
    
    setdvar( "scr_fog_exp_halfplane", halfplane );
    setdvar( "scr_fog_nearplane", nearplane );
    setdvar( "scr_fog_color", red + " " + green + " " + blue );
}

/#

    // Namespace art
    // Params 0
    // Checksum 0xdb784f0b, Offset: 0x718
    // Size: 0x960, Type: dev
    function tweakart()
    {
        if ( !isdefined( level.tweakfile ) )
        {
            level.tweakfile = 0;
        }
        
        if ( getdvarstring( "<dev string:x75>" ) == "<dev string:x36>" )
        {
            setdvar( "<dev string:x88>", "<dev string:x9e>" );
            setdvar( "<dev string:xa2>", "<dev string:x9e>" );
            setdvar( "<dev string:xb9>", "<dev string:x37>" );
            setdvar( "<dev string:x75>", "<dev string:x37>" );
        }
        
        setdvar( "<dev string:xcb>", "<dev string:xdc>" );
        setdvar( "<dev string:xe0>", "<dev string:x37>" );
        setdvar( "<dev string:xed>", "<dev string:x37>" );
        setdvar( "<dev string:x105>", level.dofdefault[ "<dev string:x117>" ] );
        setdvar( "<dev string:x121>", level.dofdefault[ "<dev string:x131>" ] );
        setdvar( "<dev string:x139>", level.dofdefault[ "<dev string:x14a>" ] );
        setdvar( "<dev string:x153>", level.dofdefault[ "<dev string:x162>" ] );
        setdvar( "<dev string:x169>", level.dofdefault[ "<dev string:x17a>" ] );
        setdvar( "<dev string:x183>", level.dofdefault[ "<dev string:x193>" ] );
        file = undefined;
        filename = undefined;
        tweak_toggle = 1;
        
        for ( ;; )
        {
            while ( getdvarint( "<dev string:x28>" ) == 0 )
            {
                tweak_toggle = 1;
                wait 0.05;
            }
            
            if ( tweak_toggle )
            {
                tweak_toggle = 0;
                fogsettings = getfogsettings();
                setdvar( "<dev string:xb9>", fogsettings[ 0 ] );
                setdvar( "<dev string:x88>", fogsettings[ 1 ] );
                setdvar( "<dev string:xa2>", fogsettings[ 3 ] );
                setdvar( "<dev string:x75>", fogsettings[ 2 ] );
                setdvar( "<dev string:x19b>", fogsettings[ 4 ] + "<dev string:x1a9>" + fogsettings[ 5 ] + "<dev string:x1a9>" + fogsettings[ 6 ] );
                setdvar( "<dev string:x1ab>", fogsettings[ 7 ] );
                setdvar( "<dev string:x1bf>", fogsettings[ 8 ] + "<dev string:x1a9>" + fogsettings[ 9 ] + "<dev string:x1a9>" + fogsettings[ 10 ] );
                level.fogsundir = [];
                level.fogsundir[ 0 ] = fogsettings[ 11 ];
                level.fogsundir[ 1 ] = fogsettings[ 12 ];
                level.fogsundir[ 2 ] = fogsettings[ 13 ];
                setdvar( "<dev string:x1d1>", fogsettings[ 14 ] );
                setdvar( "<dev string:x1e9>", fogsettings[ 15 ] );
                setdvar( "<dev string:x1ff>", fogsettings[ 16 ] );
            }
            
            level.fogexphalfplane = getdvarfloat( "<dev string:x88>" );
            level.fogexphalfheight = getdvarfloat( "<dev string:xa2>" );
            level.fognearplane = getdvarfloat( "<dev string:xb9>" );
            level.fogbaseheight = getdvarfloat( "<dev string:x75>" );
            colors = strtok( getdvarstring( "<dev string:x19b>" ), "<dev string:x1a9>" );
            level.fogcolorred = int( colors[ 0 ] );
            level.fogcolorgreen = int( colors[ 1 ] );
            level.fogcolorblue = int( colors[ 2 ] );
            level.fogcolorscale = getdvarfloat( "<dev string:x1ab>" );
            colors = strtok( getdvarstring( "<dev string:x1bf>" ), "<dev string:x1a9>" );
            level.sunfogcolorred = int( colors[ 0 ] );
            level.sunfogcolorgreen = int( colors[ 1 ] );
            level.sunfogcolorblue = int( colors[ 2 ] );
            level.sunstartangle = getdvarfloat( "<dev string:x1d1>" );
            level.sunendangle = getdvarfloat( "<dev string:x1e9>" );
            level.fogmaxopacity = getdvarfloat( "<dev string:x1ff>" );
            
            if ( getdvarint( "<dev string:xed>" ) )
            {
                setdvar( "<dev string:xed>", "<dev string:x37>" );
                println( "<dev string:x213>" );
                players = getplayers();
                dir = vectornormalize( anglestoforward( players[ 0 ] getplayerangles() ) );
                level.fogsundir = [];
                level.fogsundir[ 0 ] = dir[ 0 ];
                level.fogsundir[ 1 ] = dir[ 1 ];
                level.fogsundir[ 2 ] = dir[ 2 ];
            }
            
            fovslidercheck();
            dumpsettings();
            
            if ( !getdvarint( "<dev string:x241>" ) )
            {
                if ( !isdefined( level.fogsundir ) )
                {
                    level.fogsundir = [];
                    level.fogsundir[ 0 ] = 1;
                    level.fogsundir[ 1 ] = 0;
                    level.fogsundir[ 2 ] = 0;
                }
                
                setvolfog( level.fognearplane, level.fogexphalfplane, level.fogexphalfheight, level.fogbaseheight, level.fogcolorred, level.fogcolorgreen, level.fogcolorblue, level.fogcolorscale, level.sunfogcolorred, level.sunfogcolorgreen, level.sunfogcolorblue, level.fogsundir[ 0 ], level.fogsundir[ 1 ], level.fogsundir[ 2 ], level.sunstartangle, level.sunendangle, 0, level.fogmaxopacity );
            }
            else
            {
                setexpfog( 100000000, 100000001, 0, 0, 0, 0 );
            }
            
            wait 0.1;
        }
    }

#/

// Namespace art
// Params 0
// Checksum 0xa95277c2, Offset: 0x1080
// Size: 0x2d4
function fovslidercheck()
{
    if ( level.dofdefault[ "nearStart" ] >= level.dofdefault[ "nearEnd" ] )
    {
        level.dofdefault[ "nearStart" ] = level.dofdefault[ "nearEnd" ] - 1;
        setdvar( "scr_dof_nearStart", level.dofdefault[ "nearStart" ] );
    }
    
    if ( level.dofdefault[ "nearEnd" ] <= level.dofdefault[ "nearStart" ] )
    {
        level.dofdefault[ "nearEnd" ] = level.dofdefault[ "nearStart" ] + 1;
        setdvar( "scr_dof_nearEnd", level.dofdefault[ "nearEnd" ] );
    }
    
    if ( level.dofdefault[ "farStart" ] >= level.dofdefault[ "farEnd" ] )
    {
        level.dofdefault[ "farStart" ] = level.dofdefault[ "farEnd" ] - 1;
        setdvar( "scr_dof_farStart", level.dofdefault[ "farStart" ] );
    }
    
    if ( level.dofdefault[ "farEnd" ] <= level.dofdefault[ "farStart" ] )
    {
        level.dofdefault[ "farEnd" ] = level.dofdefault[ "farStart" ] + 1;
        setdvar( "scr_dof_farEnd", level.dofdefault[ "farEnd" ] );
    }
    
    if ( level.dofdefault[ "farBlur" ] >= level.dofdefault[ "nearBlur" ] )
    {
        level.dofdefault[ "farBlur" ] = level.dofdefault[ "nearBlur" ] - 0.1;
        setdvar( "scr_dof_farBlur", level.dofdefault[ "farBlur" ] );
    }
    
    if ( level.dofdefault[ "farStart" ] <= level.dofdefault[ "nearEnd" ] )
    {
        level.dofdefault[ "farStart" ] = level.dofdefault[ "nearEnd" ] + 1;
        setdvar( "scr_dof_farStart", level.dofdefault[ "farStart" ] );
    }
}

/#

    // Namespace art
    // Params 0
    // Checksum 0x2c6d0dd2, Offset: 0x1360
    // Size: 0x404, Type: dev
    function dumpsettings()
    {
        if ( getdvarstring( "<dev string:xe0>" ) != "<dev string:x37>" )
        {
            println( "<dev string:x251>" + level.fognearplane + "<dev string:x260>" );
            println( "<dev string:x262>" + level.fogexphalfplane + "<dev string:x260>" );
            println( "<dev string:x270>" + level.fogexphalfheight + "<dev string:x260>" );
            println( "<dev string:x280>" + level.fogbaseheight + "<dev string:x260>" );
            println( "<dev string:x290>" + level.fogcolorred + "<dev string:x260>" );
            println( "<dev string:x29a>" + level.fogcolorgreen + "<dev string:x260>" );
            println( "<dev string:x2a4>" + level.fogcolorblue + "<dev string:x260>" );
            println( "<dev string:x2ae>" + level.fogcolorscale + "<dev string:x260>" );
            println( "<dev string:x2bc>" + level.sunfogcolorred + "<dev string:x260>" );
            println( "<dev string:x2ca>" + level.sunfogcolorgreen + "<dev string:x260>" );
            println( "<dev string:x2d8>" + level.sunfogcolorblue + "<dev string:x260>" );
            println( "<dev string:x2e6>" + level.fogsundir[ 0 ] + "<dev string:x260>" );
            println( "<dev string:x2f4>" + level.fogsundir[ 1 ] + "<dev string:x260>" );
            println( "<dev string:x302>" + level.fogsundir[ 2 ] + "<dev string:x260>" );
            println( "<dev string:x310>" + level.sunstartangle + "<dev string:x260>" );
            println( "<dev string:x322>" + level.sunendangle + "<dev string:x260>" );
            println( "<dev string:x333>" );
            println( "<dev string:x33e>" + level.fogmaxopacity + "<dev string:x260>" );
            println( "<dev string:x36>" );
            println( "<dev string:x352>" );
            println( "<dev string:x3ae>" );
            println( "<dev string:x402>" );
            setdvar( "<dev string:xe0>", "<dev string:x37>" );
        }
    }

#/
