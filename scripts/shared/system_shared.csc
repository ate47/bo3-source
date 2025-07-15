#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;

#namespace system;

// Namespace system
// Params 4
// Checksum 0xc7264937, Offset: 0xc8
// Size: 0x144
function register( str_system, func_preinit, func_postinit, reqs )
{
    if ( !isdefined( reqs ) )
    {
        reqs = [];
    }
    
    if ( isdefined( level.system_funcs ) && isdefined( level.system_funcs[ str_system ] ) )
    {
        return;
    }
    
    if ( !isdefined( level.system_funcs ) )
    {
        level.system_funcs = [];
    }
    
    level.system_funcs[ str_system ] = spawnstruct();
    level.system_funcs[ str_system ].prefunc = func_preinit;
    level.system_funcs[ str_system ].postfunc = func_postinit;
    level.system_funcs[ str_system ].reqs = reqs;
    level.system_funcs[ str_system ].predone = !isdefined( func_preinit );
    level.system_funcs[ str_system ].postdone = !isdefined( func_postinit );
    level.system_funcs[ str_system ].ignore = 0;
}

// Namespace system
// Params 1
// Checksum 0xac61e5fd, Offset: 0x218
// Size: 0xbc
function exec_post_system( req )
{
    /#
        if ( !isdefined( level.system_funcs[ req ] ) )
        {
            assertmsg( "<dev string:x28>" + req + "<dev string:x31>" );
        }
    #/
    
    if ( level.system_funcs[ req ].ignore )
    {
        return;
    }
    
    if ( !level.system_funcs[ req ].postdone )
    {
        [[ level.system_funcs[ req ].postfunc ]]();
        level.system_funcs[ req ].postdone = 1;
    }
}

// Namespace system
// Params 0
// Checksum 0xd2b8a2d1, Offset: 0x2e0
// Size: 0x1ec
function run_post_systems()
{
    foreach ( key, func in level.system_funcs )
    {
        assert( func.predone || func.ignore, "<dev string:x43>" );
        
        if ( isarray( func.reqs ) )
        {
            foreach ( req in func.reqs )
            {
                thread exec_post_system( req );
            }
        }
        else
        {
            thread exec_post_system( func.reqs );
        }
        
        thread exec_post_system( key );
    }
    
    if ( !level flag::exists( "system_init_complete" ) )
    {
        level flag::init( "system_init_complete", 0 );
    }
    
    level flag::set( "system_init_complete" );
}

// Namespace system
// Params 1
// Checksum 0x836c460d, Offset: 0x4d8
// Size: 0xbc
function exec_pre_system( req )
{
    /#
        if ( !isdefined( level.system_funcs[ req ] ) )
        {
            assertmsg( "<dev string:x28>" + req + "<dev string:x31>" );
        }
    #/
    
    if ( level.system_funcs[ req ].ignore )
    {
        return;
    }
    
    if ( !level.system_funcs[ req ].predone )
    {
        [[ level.system_funcs[ req ].prefunc ]]();
        level.system_funcs[ req ].predone = 1;
    }
}

// Namespace system
// Params 0
// Checksum 0x22433237, Offset: 0x5a0
// Size: 0x15a
function run_pre_systems()
{
    foreach ( key, func in level.system_funcs )
    {
        if ( isarray( func.reqs ) )
        {
            foreach ( req in func.reqs )
            {
                thread exec_pre_system( req );
            }
        }
        else
        {
            thread exec_pre_system( func.reqs );
        }
        
        thread exec_pre_system( key );
    }
}

// Namespace system
// Params 1
// Checksum 0x905d30bd, Offset: 0x708
// Size: 0x6c
function wait_till( required_systems )
{
    if ( !level flag::exists( "system_init_complete" ) )
    {
        level flag::init( "system_init_complete", 0 );
    }
    
    level flag::wait_till( "system_init_complete" );
}

// Namespace system
// Params 1
// Checksum 0x631d36d5, Offset: 0x780
// Size: 0x90
function ignore( str_system )
{
    assert( !isdefined( level.gametype ), "<dev string:xac>" );
    
    if ( !isdefined( level.system_funcs ) || !isdefined( level.system_funcs[ str_system ] ) )
    {
        register( str_system, undefined, undefined, undefined );
    }
    
    level.system_funcs[ str_system ].ignore = 1;
}

// Namespace system
// Params 1
// Checksum 0x1bab0c0, Offset: 0x818
// Size: 0x4a
function is_system_running( str_system )
{
    if ( !isdefined( level.system_funcs ) || !isdefined( level.system_funcs[ str_system ] ) )
    {
        return 0;
    }
    
    return level.system_funcs[ str_system ].postdone;
}

