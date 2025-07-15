#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;

#namespace cheat;

// Namespace cheat
// Params 0, eflags: 0x2
// Checksum 0x8598ba5d, Offset: 0xe0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "cheat", &__init__, undefined, undefined );
}

// Namespace cheat
// Params 0
// Checksum 0x6b54a10, Offset: 0x120
// Size: 0x5c
function __init__()
{
    level.cheatstates = [];
    level.cheatfuncs = [];
    level.cheatdvars = [];
    level flag::init( "has_cheated" );
    level thread death_monitor();
}

// Namespace cheat
// Params 0
// Checksum 0x31f2394, Offset: 0x188
// Size: 0x1c
function player_init()
{
    self thread specialfeaturesmenu();
}

// Namespace cheat
// Params 0
// Checksum 0xf13d2a17, Offset: 0x1b0
// Size: 0x14
function death_monitor()
{
    setdvars_based_on_varibles();
}

// Namespace cheat
// Params 0
// Checksum 0xe3961ac8, Offset: 0x1d0
// Size: 0x66
function setdvars_based_on_varibles()
{
    /#
        for ( index = 0; index < level.cheatdvars.size ; index++ )
        {
            setdvar( level.cheatdvars[ index ], level.cheatstates[ level.cheatdvars[ index ] ] );
        }
    #/
}

// Namespace cheat
// Params 2
// Checksum 0x62f7c4ca, Offset: 0x240
// Size: 0x9a
function addcheat( toggledvar, cheatfunc )
{
    /#
        setdvar( toggledvar, 0 );
    #/
    
    level.cheatstates[ toggledvar ] = getdvarint( toggledvar );
    level.cheatfuncs[ toggledvar ] = cheatfunc;
    
    if ( level.cheatstates[ toggledvar ] )
    {
        [[ cheatfunc ]]( level.cheatstates[ toggledvar ] );
    }
}

// Namespace cheat
// Params 1
// Checksum 0x77ffe534, Offset: 0x2e8
// Size: 0x96
function checkcheatchanged( toggledvar )
{
    cheatvalue = getdvarint( toggledvar );
    
    if ( level.cheatstates[ toggledvar ] == cheatvalue )
    {
        return;
    }
    
    if ( cheatvalue )
    {
        level flag::set( "has_cheated" );
    }
    
    level.cheatstates[ toggledvar ] = cheatvalue;
    [[ level.cheatfuncs[ toggledvar ] ]]( cheatvalue );
}

// Namespace cheat
// Params 0
// Checksum 0xe0e3652b, Offset: 0x388
// Size: 0xac
function specialfeaturesmenu()
{
    level endon( #"unloaded" );
    addcheat( "sf_use_ignoreammo", &ignore_ammomode );
    level.cheatdvars = getarraykeys( level.cheatstates );
    
    for ( ;; )
    {
        for ( index = 0; index < level.cheatdvars.size ; index++ )
        {
            checkcheatchanged( level.cheatdvars[ index ] );
        }
        
        wait 0.5;
    }
}

// Namespace cheat
// Params 1
// Checksum 0x558a341e, Offset: 0x440
// Size: 0x54
function ignore_ammomode( cheatvalue )
{
    if ( cheatvalue )
    {
        setsaveddvar( "player_sustainAmmo", 1 );
        return;
    }
    
    setsaveddvar( "player_sustainAmmo", 0 );
}

// Namespace cheat
// Params 0
// Checksum 0x52bcee02, Offset: 0x4a0
// Size: 0x22
function is_cheating()
{
    return level flag::get( "has_cheated" );
}

