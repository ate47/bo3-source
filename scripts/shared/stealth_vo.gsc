#using scripts/cp/_dialog;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_vengeance_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/array_shared;
#using scripts/shared/stealth;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth_player;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace stealth_vo;

// Namespace stealth_vo
// Params 0
// Checksum 0x55d860aa, Offset: 0x2c8
// Size: 0xa2
function init()
{
    assert( isdefined( self.stealth ) );
    self set_stealth_mode( 1 );
    
    if ( isplayer( self ) )
    {
        self thread ambient_player_thread();
        return;
    }
    
    if ( self == level )
    {
        self init_level_defaults();
        level.allowbattlechatter[ "stealth" ] = 1;
    }
}

// Namespace stealth_vo
// Params 0
// Checksum 0x648111b7, Offset: 0x378
// Size: 0x44
function stop()
{
    assert( isdefined( self ) );
    
    if ( isdefined( self.allowbattlechatter[ "stealth" ] ) )
    {
        self.allowbattlechatter[ "stealth" ] = undefined;
    }
}

// Namespace stealth_vo
// Params 0
// Checksum 0x30f7980b, Offset: 0x3c8
// Size: 0x2e, Type: bool
function enabled()
{
    return isdefined( self.stealth ) && isdefined( self.allowbattlechatter ) && isdefined( self.allowbattlechatter[ "stealth" ] );
}

// Namespace stealth_vo
// Params 1
// Checksum 0x488b9d1d, Offset: 0x400
// Size: 0x4c, Type: bool
function get_stealth_mode( bstealthmode )
{
    return isdefined( self.stealth ) && isdefined( self.allowbattlechatter ) && isdefined( self.allowbattlechatter[ "stealth" ] ) && self.allowbattlechatter[ "stealth" ];
}

// Namespace stealth_vo
// Params 1
// Checksum 0xb265dad5, Offset: 0x458
// Size: 0x24
function set_stealth_mode( bstealthmode )
{
    self thread set_stealth_mode_internal_thread( bstealthmode );
}

// Namespace stealth_vo
// Params 1
// Checksum 0x570cc646, Offset: 0x488
// Size: 0x11a
function set_stealth_mode_internal_thread( bstealthmode )
{
    if ( isdefined( self.allowbattlechatter ) && isdefined( self.allowbattlechatter[ "stealth" ] ) && self.allowbattlechatter[ "stealth" ] == bstealthmode )
    {
        return;
    }
    
    self notify( #"set_stealth_mode_internal_thread" );
    self endon( #"set_stealth_mode_internal_thread" );
    
    if ( !isplayer( self ) )
    {
        self endon( #"death" );
    }
    
    wait 0.05;
    
    if ( isdefined( self ) )
    {
        while ( isdefined( self.isspeaking ) && ( isdefined( self ) && isdefined( self.stealth ) && isdefined( self.stealth.vo_event_priority ) || self.isspeaking ) )
        {
            wait 0.05;
        }
        
        self.allowbattlechatter[ "bc" ] = !bstealthmode;
        self.allowbattlechatter[ "stealth" ] = bstealthmode;
    }
}

// Namespace stealth_vo
// Params 1
// Checksum 0x4e67994f, Offset: 0x5b0
// Size: 0x27e
function on_voice_event( eventpackage )
{
    self endon( #"death" );
    self endon( #"stop_stealth" );
    
    if ( !isactor( self ) || !isalive( self ) )
    {
        return;
    }
    
    str_event = eventpackage.parms[ 0 ];
    
    if ( !isdefined( str_event ) )
    {
        return;
    }
    
    alias_line = self get_line( str_event );
    
    if ( isdefined( alias_line ) )
    {
        alias_response = self get_line( str_event + "_" + alias_line + "_response" );
        priority = level.stealth.vo_event_priority[ str_event ];
        
        if ( !isdefined( priority ) )
        {
            priority = 0;
        }
        
        if ( !isdefined( self.stealth.vo_event_priority ) || self.stealth.vo_event_priority <= priority )
        {
            self.stealth.vo_event_priority = priority;
        }
        else
        {
            return;
        }
        
        wait randomfloatrange( 0.25, 0.75 );
        
        if ( isdefined( self.silenced ) && self.silenced )
        {
            return;
        }
        
        if ( !isdefined( self.stealth.vo_event_priority ) || self.stealth.vo_event_priority <= priority )
        {
            self.stealth.vo_event_priority = priority;
            self battlechatter::bc_makeline( self, alias_line, alias_response, "stealth", 1 );
            
            while ( isdefined( self.isspeaking ) && self.isspeaking )
            {
                wait 0.05;
            }
            
            if ( isdefined( self.stealth ) && isdefined( self.stealth.vo_event_priority ) && self.stealth.vo_event_priority == priority )
            {
                self.stealth.vo_event_priority = undefined;
            }
        }
    }
}

// Namespace stealth_vo
// Params 2
// Checksum 0xe2bdc37, Offset: 0x838
// Size: 0x356
function get_line( str_event, tablestruct )
{
    now = gettime();
    
    if ( !self enabled() )
    {
        return undefined;
    }
    
    if ( !isdefined( level.stealth ) )
    {
        return undefined;
    }
    
    if ( !isdefined( tablestruct ) )
    {
        tablestruct = level.stealth.vo_alias;
    }
    
    if ( !isdefined( tablestruct.alias ) || !isdefined( tablestruct.alias[ str_event ] ) )
    {
        return undefined;
    }
    
    if ( !isdefined( level.stealth.var_e031c3f5 ) )
    {
        level.stealth.var_e031c3f5 = [];
    }
    
    line = undefined;
    count = 0;
    checkawareness = [];
    checkawareness[ 0 ] = "noncombat";
    
    if ( self stealth_aware::enabled() )
    {
        checkawareness[ checkawareness.size ] = self stealth_aware::get_awareness();
    }
    
    for ( try = 0; try < 2 ; try++ )
    {
        foreach ( awareness in checkawareness )
        {
            if ( isdefined( tablestruct.alias[ str_event ][ awareness ] ) )
            {
                foreach ( alias in tablestruct.alias[ str_event ][ awareness ] )
                {
                    if ( try == 0 )
                    {
                        if ( isdefined( level.stealth.var_e031c3f5[ alias ] ) && now - level.stealth.var_e031c3f5[ alias ] < 2000 )
                        {
                            continue;
                        }
                    }
                    
                    count += 1;
                    
                    if ( randomfloat( 1 ) <= 1 / count )
                    {
                        line = alias;
                    }
                }
            }
        }
        
        if ( isdefined( line ) )
        {
            break;
        }
    }
    
    if ( isdefined( line ) )
    {
        level.stealth.var_e031c3f5[ line ] = now;
    }
    
    return line;
}

// Namespace stealth_vo
// Params 0
// Checksum 0x5e57ed16, Offset: 0xb98
// Size: 0x2cc
function init_level_defaults()
{
    if ( !isdefined( level.stealth ) )
    {
        level.stealth = spawnstruct();
    }
    
    if ( !isdefined( level.stealth.vo_event_priority ) )
    {
        level.stealth.vo_event_priority = [];
    }
    
    level.stealth.vo_event_priority[ "ambient" ] = 0;
    level.stealth.vo_event_priority[ "resume" ] = 0.25;
    level.stealth.vo_event_priority[ "alert" ] = 0.5;
    level.stealth.vo_event_priority[ "explosion" ] = 0.8;
    level.stealth.vo_event_priority[ "corpse" ] = 0.9;
    level.stealth.vo_event_priority[ "enemy" ] = 1;
    alias_register( "alert", "patrol_alerted", "response_backup" );
    alias_register( "ambient", "patrol_brief", "response_affirm" );
    alias_register( "ambient", "patrol_calm", undefined, "unaware" );
    alias_register( "ambient", "patrol_clear", undefined, "unaware" );
    alias_register( "ambient", "patrol_cough", undefined, "unaware" );
    alias_register( "ambient", "patrol_throat", undefined, "unaware" );
    alias_register( "resume", "patrol_resume", "response_affirm" );
    alias_register( "resume", "patrol_resume", "response_secure" );
    alias_register( "corpse", "spotted_corpse" );
    alias_register( "enemy", "spotted_enemy" );
    alias_register( "explosion", "spotted_explosion" );
}

// Namespace stealth_vo
// Params 0
// Checksum 0x3e4695bd, Offset: 0xe70
// Size: 0x324
function ambient_player_thread()
{
    assert( isplayer( self ) );
    self notify( #"ambient_player_thread" );
    self endon( #"ambient_player_thread" );
    self endon( #"disconnect" );
    self endon( #"stop_stealth" );
    wait 0.05;
    maxdist = 1000;
    maxdistsq = maxdist * maxdist;
    
    while ( true )
    {
        wait randomfloatrange( 10, 15 );
        
        if ( !isdefined( level.stealth ) || !isdefined( level.stealth.enemies ) || !isdefined( self.team ) || !isdefined( level.stealth.enemies[ self.team ] ) )
        {
            continue;
        }
        
        candidates = [];
        
        foreach ( enemy in level.stealth.enemies[ self.team ] )
        {
            if ( !isalive( enemy ) )
            {
                continue;
            }
            
            if ( !enemy get_stealth_mode() )
            {
                continue;
            }
            
            if ( enemy.ignoreall )
            {
                continue;
            }
            
            distsq = distancesquared( enemy.origin, self.origin );
            
            if ( distsq > maxdistsq )
            {
                continue;
            }
            
            if ( isdefined( enemy.stealth.vo_next_ambient ) && gettime() < enemy.stealth.vo_next_ambient )
            {
                continue;
            }
            
            candidates[ candidates.size ] = enemy;
        }
        
        candidates = arraysortclosest( candidates, self.origin, 1, 0, maxdist );
        
        if ( isdefined( candidates ) && candidates.size > 0 )
        {
            candidates[ 0 ] notify( #"stealth_vo", "ambient" );
            candidates[ 0 ].stealth.vo_next_ambient = gettime() + randomintrange( 8000, 12000 );
        }
    }
}

// Namespace stealth_vo
// Params 0
// Checksum 0x86b1d5d7, Offset: 0x11a0
// Size: 0x1e
function alias_clear()
{
    if ( isdefined( level.stealth ) )
    {
        level.stealth.vo_alias = undefined;
    }
}

// Namespace stealth_vo
// Params 4
// Checksum 0xd5691c90, Offset: 0x11c8
// Size: 0x164
function alias_register( str_event, str_alias, str_alias_response, str_awareness )
{
    assert( isstring( str_event ) );
    assert( isstring( str_alias ) );
    
    if ( !isdefined( level.stealth ) )
    {
        level.stealth = spawnstruct();
    }
    
    if ( !isdefined( level.stealth.vo_alias ) )
    {
        level.stealth.vo_alias = spawnstruct();
    }
    
    struct_alias_register( level.stealth.vo_alias, str_event, str_alias, str_awareness );
    
    if ( isdefined( str_alias_response ) )
    {
        struct_alias_register( level.stealth.vo_alias, str_event + "_" + str_alias + "_response", str_alias, str_awareness );
    }
}

// Namespace stealth_vo
// Params 4
// Checksum 0xa853cf7b, Offset: 0x1338
// Size: 0x196
function struct_alias_register( struct, str_event, str_alias, str_awareness )
{
    assert( isdefined( struct ) );
    assert( isstring( str_event ) );
    assert( isstring( str_alias ) );
    
    if ( !isdefined( str_awareness ) )
    {
        str_awareness = "noncombat";
    }
    
    if ( !isdefined( struct.alias ) )
    {
        struct.alias = [];
    }
    
    if ( !isdefined( struct.alias[ str_event ] ) )
    {
        struct.alias[ str_event ] = [];
    }
    
    if ( !isdefined( struct.alias[ str_event ][ str_awareness ] ) )
    {
        struct.alias[ str_event ][ str_awareness ] = [];
    }
    
    if ( !isdefined( struct.alias[ str_event ][ str_awareness ][ str_alias ] ) )
    {
        struct.alias[ str_event ][ str_awareness ][ str_alias ] = str_alias;
    }
}

// Namespace stealth_vo
// Params 3
// Checksum 0xe27f6a68, Offset: 0x14d8
// Size: 0x170
function function_5714528b( var_be26784d, str_vo_line, b_text )
{
    assert( isdefined( level.stealth ) );
    
    if ( !isdefined( level.stealth.vo_callout ) )
    {
        level.stealth.vo_callout = [];
    }
    
    if ( !isdefined( level.stealth.vo_callout[ var_be26784d ] ) )
    {
        level.stealth.vo_callout[ var_be26784d ] = [];
    }
    
    level.stealth.vo_callout[ var_be26784d ][ level.stealth.vo_callout[ var_be26784d ].size ] = str_vo_line;
    
    if ( isdefined( b_text ) && b_text )
    {
        if ( !isdefined( level.stealth.var_787c93a0 ) )
        {
            level.stealth.var_787c93a0 = [];
        }
        
        if ( !isdefined( level.stealth.var_787c93a0[ var_be26784d ] ) )
        {
            level.stealth.var_787c93a0[ var_be26784d ] = [];
        }
        
        level.stealth.var_787c93a0[ var_be26784d ][ level.stealth.var_787c93a0[ var_be26784d ].size ] = str_vo_line;
    }
}

// Namespace stealth_vo
// Params 2
// Checksum 0x6149989b, Offset: 0x1650
// Size: 0x394
function function_866c6270( var_be26784d, priority )
{
    if ( !( isdefined( level.stealth.vo_callouts ) && level.stealth.vo_callouts ) )
    {
        return;
    }
    
    assert( isplayer( self ) );
    assert( isdefined( level.stealth ) );
    assert( isdefined( level.stealth.vo_callout ) );
    assert( isdefined( level.stealth.vo_callout[ var_be26784d ] ) );
    
    if ( !isdefined( priority ) )
    {
        priority = 0;
    }
    
    str_vo_line = undefined;
    
    if ( level.stealth.vo_callout[ var_be26784d ].size <= 2 )
    {
        str_vo_line = array::random( level.stealth.vo_callout[ var_be26784d ] );
    }
    else
    {
        if ( !isdefined( self.stealth.vo_deck ) )
        {
            self.stealth.vo_deck = [];
        }
        
        if ( !isdefined( self.stealth.vo_deck[ var_be26784d ] ) )
        {
            self.stealth.vo_deck[ var_be26784d ] = level.stealth.vo_callout[ var_be26784d ];
        }
        
        if ( !isdefined( self.stealth.var_b9ae563d ) )
        {
            self.stealth.var_b9ae563d = [];
        }
        
        if ( !isdefined( self.stealth.var_b9ae563d[ var_be26784d ] ) )
        {
            self.stealth.var_b9ae563d[ var_be26784d ] = self.stealth.vo_deck[ var_be26784d ].size;
        }
        
        if ( self.stealth.var_b9ae563d[ var_be26784d ] > self.stealth.vo_deck[ var_be26784d ].size - 1 )
        {
            self.stealth.vo_deck = array::randomize( level.stealth.vo_callout[ var_be26784d ] );
            self.stealth.var_b9ae563d[ var_be26784d ] = 0;
        }
        
        str_vo_line = self.stealth.vo_deck[ self.stealth.var_b9ae563d[ var_be26784d ] ];
        self.stealth.var_b9ae563d[ var_be26784d ] += 1;
    }
    
    if ( isdefined( str_vo_line ) )
    {
        if ( isdefined( level.stealth.var_787c93a0 ) && isdefined( level.stealth.var_787c93a0[ var_be26784d ] ) )
        {
            self thread function_500f3ab6( str_vo_line );
            return;
        }
        
        self thread vengeance_util::function_ee75acde( str_vo_line, 0, priority, self );
    }
}

// Namespace stealth_vo
// Params 3
// Checksum 0xc96d7d4f, Offset: 0x19f0
// Size: 0xac
function function_e3ae87b3( var_be26784d, var_4818f349, priority )
{
    assert( isplayer( self ) );
    
    if ( !isdefined( level.stealth ) )
    {
        return;
    }
    
    if ( !isdefined( level.stealth.vo_callout ) )
    {
        return;
    }
    
    if ( !isdefined( level.stealth.vo_callout[ var_be26784d ] ) )
    {
        return;
    }
    
    self thread function_584c6d3a( var_be26784d, var_4818f349, priority );
}

// Namespace stealth_vo
// Params 3
// Checksum 0x137cd994, Offset: 0x1aa8
// Size: 0x194
function function_584c6d3a( var_be26784d, var_4818f349, priority )
{
    self notify( #"hash_e3ae87b3" );
    self endon( #"hash_e3ae87b3" );
    self endon( #"disconnect" );
    self endon( #"stop_stealth" );
    assert( isplayer( self ) );
    
    if ( isentity( var_4818f349 ) )
    {
        var_4818f349 endon( #"death" );
    }
    
    now = gettime();
    
    if ( !isdefined( self.stealth.var_23eafafa ) )
    {
        self.stealth.var_23eafafa = [];
    }
    
    wait randomfloatrange( 1, 2 );
    
    if ( !self stealth_player::enabled() )
    {
        return;
    }
    
    if ( isdefined( self.stealth.var_23eafafa[ var_be26784d ] ) && now - self.stealth.var_23eafafa[ var_be26784d ] < 20000 )
    {
        return;
    }
    
    self.stealth.var_23eafafa[ var_be26784d ] = now;
    self function_866c6270( var_be26784d, priority );
}

// Namespace stealth_vo
// Params 1
// Checksum 0x5340e155, Offset: 0x1c48
// Size: 0xde
function function_500f3ab6( str_text )
{
    self notify( #"hash_500f3ab6" );
    self endon( #"hash_500f3ab6" );
    self endon( #"disconnect" );
    self endon( #"stop_stealth" );
    
    if ( isdefined( self.stealth.var_500f3ab6 ) )
    {
        self util::screen_message_delete_client();
    }
    
    self thread util::screen_message_create_client( "[ " + str_text + " ]", undefined, undefined, 125, 0 );
    wait 3;
    self util::screen_message_delete_client();
    
    if ( isdefined( self.stealth.var_500f3ab6 ) )
    {
        self.stealth.var_500f3ab6 = undefined;
    }
}

// Namespace stealth_vo
// Params 1
// Checksum 0x5082ce79, Offset: 0x1d30
// Size: 0x74
function function_4970c8b8( callout )
{
    if ( isdefined( callout ) )
    {
        if ( !isdefined( level.stealth.var_581c13ae ) )
        {
            level.stealth.var_581c13ae = [];
        }
        
        level.stealth.var_581c13ae[ level.stealth.var_581c13ae.size ] = self;
        self.stealth_callout = callout;
    }
}

