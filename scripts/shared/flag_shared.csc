#using scripts/shared/util_shared;

#namespace flag;

// Namespace flag
// Params 3
// Checksum 0x86f47e97, Offset: 0xb0
// Size: 0xb6
function init( str_flag, b_val, b_is_trigger )
{
    if ( !isdefined( b_val ) )
    {
        b_val = 0;
    }
    
    if ( !isdefined( b_is_trigger ) )
    {
        b_is_trigger = 0;
    }
    
    if ( !isdefined( self.flag ) )
    {
        self.flag = [];
    }
    
    /#
        if ( !isdefined( level.first_frame ) )
        {
            assert( !isdefined( self.flag[ str_flag ] ), "<dev string:x28>" + str_flag + "<dev string:x50>" );
        }
    #/
    
    self.flag[ str_flag ] = b_val;
}

// Namespace flag
// Params 1
// Checksum 0xcceab3f4, Offset: 0x170
// Size: 0x26, Type: bool
function exists( str_flag )
{
    return isdefined( self.flag ) && isdefined( self.flag[ str_flag ] );
}

// Namespace flag
// Params 1
// Checksum 0xde799908, Offset: 0x1a0
// Size: 0x70
function set( str_flag )
{
    assert( exists( str_flag ), "<dev string:x5d>" + str_flag + "<dev string:x78>" );
    self.flag[ str_flag ] = 1;
    self notify( str_flag );
}

// Namespace flag
// Params 3
// Checksum 0x105bfd7a, Offset: 0x218
// Size: 0x3c
function delay_set( n_delay, str_flag, str_cancel )
{
    self thread _delay_set( n_delay, str_flag, str_cancel );
}

// Namespace flag
// Params 3
// Checksum 0xf93783e, Offset: 0x260
// Size: 0x54
function _delay_set( n_delay, str_flag, str_cancel )
{
    if ( isdefined( str_cancel ) )
    {
        self endon( str_cancel );
    }
    
    self endon( #"death" );
    wait n_delay;
    set( str_flag );
}

// Namespace flag
// Params 2
// Checksum 0xdeb85efe, Offset: 0x2c0
// Size: 0x6c
function set_for_time( n_time, str_flag )
{
    self notify( "__flag::set_for_time__" + str_flag );
    self endon( "__flag::set_for_time__" + str_flag );
    set( str_flag );
    wait n_time;
    clear( str_flag );
}

// Namespace flag
// Params 1
// Checksum 0x7dd30fee, Offset: 0x338
// Size: 0x78
function clear( str_flag )
{
    assert( exists( str_flag ), "<dev string:x92>" + str_flag + "<dev string:x78>" );
    
    if ( self.flag[ str_flag ] )
    {
        self.flag[ str_flag ] = 0;
        self notify( str_flag );
    }
}

// Namespace flag
// Params 1
// Checksum 0xdde3bb51, Offset: 0x3b8
// Size: 0x54
function toggle( str_flag )
{
    if ( get( str_flag ) )
    {
        clear( str_flag );
        return;
    }
    
    set( str_flag );
}

// Namespace flag
// Params 1
// Checksum 0x68d1a7a0, Offset: 0x418
// Size: 0x58
function get( str_flag )
{
    assert( exists( str_flag ), "<dev string:xaf>" + str_flag + "<dev string:x78>" );
    return self.flag[ str_flag ];
}

// Namespace flag
// Params 1
// Checksum 0xd47070ba, Offset: 0x478
// Size: 0x3c
function wait_till( str_flag )
{
    self endon( #"death" );
    
    while ( !get( str_flag ) )
    {
        self waittill( str_flag );
    }
}

// Namespace flag
// Params 2
// Checksum 0x80d74332, Offset: 0x4c0
// Size: 0x84
function wait_till_timeout( n_timeout, str_flag )
{
    if ( isdefined( n_timeout ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( n_timeout, "timeout" );
    }
    
    wait_till( str_flag );
}

// Namespace flag
// Params 1
// Checksum 0x764b357f, Offset: 0x550
// Size: 0x84
function wait_till_all( a_flags )
{
    self endon( #"death" );
    
    for ( i = 0; i < a_flags.size ; i++ )
    {
        str_flag = a_flags[ i ];
        
        if ( !get( str_flag ) )
        {
            self waittill( str_flag );
            i = -1;
        }
    }
}

// Namespace flag
// Params 2
// Checksum 0x642f2fdb, Offset: 0x5e0
// Size: 0x84
function wait_till_all_timeout( n_timeout, a_flags )
{
    if ( isdefined( n_timeout ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( n_timeout, "timeout" );
    }
    
    wait_till_all( a_flags );
}

// Namespace flag
// Params 1
// Checksum 0x50c21698, Offset: 0x670
// Size: 0xbc
function wait_till_any( a_flags )
{
    self endon( #"death" );
    
    foreach ( flag in a_flags )
    {
        if ( get( flag ) )
        {
            return flag;
        }
    }
    
    util::waittill_any_array( a_flags );
}

// Namespace flag
// Params 2
// Checksum 0xb0170515, Offset: 0x738
// Size: 0x84
function wait_till_any_timeout( n_timeout, a_flags )
{
    if ( isdefined( n_timeout ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( n_timeout, "timeout" );
    }
    
    wait_till_any( a_flags );
}

// Namespace flag
// Params 1
// Checksum 0xca73c7f2, Offset: 0x7c8
// Size: 0x3c
function wait_till_clear( str_flag )
{
    self endon( #"death" );
    
    while ( get( str_flag ) )
    {
        self waittill( str_flag );
    }
}

// Namespace flag
// Params 2
// Checksum 0xae18577f, Offset: 0x810
// Size: 0x84
function wait_till_clear_timeout( n_timeout, str_flag )
{
    if ( isdefined( n_timeout ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( n_timeout, "timeout" );
    }
    
    wait_till_clear( str_flag );
}

// Namespace flag
// Params 1
// Checksum 0xa536e199, Offset: 0x8a0
// Size: 0x84
function wait_till_clear_all( a_flags )
{
    self endon( #"death" );
    
    for ( i = 0; i < a_flags.size ; i++ )
    {
        str_flag = a_flags[ i ];
        
        if ( get( str_flag ) )
        {
            self waittill( str_flag );
            i = -1;
        }
    }
}

// Namespace flag
// Params 2
// Checksum 0x65abab7b, Offset: 0x930
// Size: 0x84
function wait_till_clear_all_timeout( n_timeout, a_flags )
{
    if ( isdefined( n_timeout ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( n_timeout, "timeout" );
    }
    
    wait_till_clear_all( a_flags );
}

// Namespace flag
// Params 1
// Checksum 0xc94163c1, Offset: 0x9c0
// Size: 0xc8
function wait_till_clear_any( a_flags )
{
    self endon( #"death" );
    
    while ( true )
    {
        foreach ( flag in a_flags )
        {
            if ( !get( flag ) )
            {
                return flag;
            }
        }
        
        util::waittill_any_array( a_flags );
    }
}

// Namespace flag
// Params 2
// Checksum 0x1fb38845, Offset: 0xa90
// Size: 0x84
function wait_till_clear_any_timeout( n_timeout, a_flags )
{
    if ( isdefined( n_timeout ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( n_timeout, "timeout" );
    }
    
    wait_till_clear_any( a_flags );
}

// Namespace flag
// Params 1
// Checksum 0xbd8fe1d5, Offset: 0xb20
// Size: 0x54
function delete( str_flag )
{
    if ( isdefined( self.flag[ str_flag ] ) )
    {
        self.flag[ str_flag ] = undefined;
        return;
    }
    
    println( "<dev string:xc3>" + str_flag );
}

