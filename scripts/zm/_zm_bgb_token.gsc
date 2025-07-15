#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_stats;

#namespace bgb_token;

// Namespace bgb_token
// Params 0, eflags: 0x2
// Checksum 0xe9dc99bf, Offset: 0x200
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "bgb_token", &__init__, &__main__, undefined );
}

// Namespace bgb_token
// Params 0, eflags: 0x4
// Checksum 0x52543f79, Offset: 0x248
// Size: 0x3c
function private __init__()
{
    if ( !is_bgb_token_in_use() )
    {
        return;
    }
    
    callback::on_spawned( &on_player_spawned );
}

// Namespace bgb_token
// Params 0, eflags: 0x4
// Checksum 0xc773b658, Offset: 0x290
// Size: 0xfc
function private __main__()
{
    if ( !is_bgb_token_in_use() )
    {
        return;
    }
    
    if ( !isdefined( level.bgb_token_max_per_game ) )
    {
        level.bgb_token_max_per_game = -1;
    }
    
    if ( !isdefined( level.var_baa8fd09 ) )
    {
        level.var_baa8fd09 = 3600;
    }
    
    if ( !isdefined( level.var_342aa5b2 ) )
    {
        level.var_342aa5b2 = 0.33;
    }
    
    if ( !isdefined( level.var_4d1d42c7 ) )
    {
        level.var_4d1d42c7 = 5;
    }
    
    if ( !isdefined( level.var_5f0752c5 ) )
    {
        level.var_5f0752c5 = 1000;
    }
    
    if ( !isdefined( level.var_af87760a ) )
    {
        level.var_af87760a = 0.33;
    }
    
    if ( !isdefined( level.var_bc978de9 ) )
    {
        level.var_bc978de9 = 8;
    }
    
    if ( !isdefined( level.var_c50e9bdb ) )
    {
        level.var_c50e9bdb = 9;
    }
    
    /#
        level thread setup_devgui();
    #/
}

// Namespace bgb_token
// Params 0, eflags: 0x4
// Checksum 0xc86cd741, Offset: 0x398
// Size: 0x60
function private on_player_spawned()
{
    if ( !isdefined( self.bgb_token_last_given_time ) )
    {
        self.bgb_token_last_given_time = self zm_stats::get_global_stat( "BGB_TOKEN_LAST_GIVEN_TIME" );
        self.bgb_tokens_gained_this_game = 0;
        self.var_bc978de9 = level.var_bc978de9 + level.round_number - 1;
    }
}

// Namespace bgb_token
// Params 0, eflags: 0x4
// Checksum 0xded9743f, Offset: 0x400
// Size: 0x66, Type: bool
function private is_bgb_token_in_use()
{
    if ( !( isdefined( level.bgb_in_use ) && level.bgb_in_use ) || !level.onlinegame || !getdvarint( "loot_enabled" ) )
    {
        return false;
    }
    
    if ( isusingmods() )
    {
        return false;
    }
    
    return true;
}

// Namespace bgb_token
// Params 1
// Checksum 0xe77678e5, Offset: 0x470
// Size: 0xc6
function function_c2f81136( increment )
{
    if ( !is_bgb_token_in_use() )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.var_bc978de9 ) )
        {
            player.var_bc978de9 += increment;
        }
    }
}

/#

    // Namespace bgb_token
    // Params 0, eflags: 0x4
    // Checksum 0x519b1518, Offset: 0x540
    // Size: 0x8c, Type: dev
    function private setup_devgui()
    {
        waittillframeend();
        setdvar( "<dev string:x28>", "<dev string:x3f>" );
        bgb_devgui_base = "<dev string:x40>";
        adddebugcommand( bgb_devgui_base + "<dev string:x59>" + "<dev string:x28>" + "<dev string:x67>" );
        level thread bgb_token_devgui_think();
    }

    // Namespace bgb_token
    // Params 0, eflags: 0x4
    // Checksum 0xd305b917, Offset: 0x5d8
    // Size: 0x88, Type: dev
    function private bgb_token_devgui_think()
    {
        for ( ;; )
        {
            bgb_award_token_dvar = getdvarstring( "<dev string:x28>" );
            
            if ( bgb_award_token_dvar != "<dev string:x3f>" )
            {
                level.players[ 0 ] bgb_token_give_to_player();
            }
            
            setdvar( "<dev string:x28>", "<dev string:x3f>" );
            wait 0.5;
        }
    }

#/

// Namespace bgb_token
// Params 0, eflags: 0x4
// Checksum 0xa9e07aba, Offset: 0x668
// Size: 0x12c
function private bgb_token_give_to_player()
{
    var_90491adb = int( self getvialsscale() );
    
    for ( count = 0; count < var_90491adb ; count++ )
    {
        self incrementbgbtokensgained();
    }
    
    self.bgb_tokens_gained_this_game += var_90491adb;
    self.var_bc978de9 += level.var_c50e9bdb;
    self.bgb_token_last_given_time = self zm_stats::get_global_stat( "TIME_PLAYED_TOTAL" );
    self zm_stats::set_global_stat( "BGB_TOKEN_LAST_GIVEN_TIME", self.bgb_token_last_given_time );
    uploadstats( self );
    self reportlootreward( "3", var_90491adb );
}

// Namespace bgb_token
// Params 1, eflags: 0x4
// Checksum 0xfb292a0, Offset: 0x7a0
// Size: 0x34, Type: bool
function private bgb_token_percent_chance( target_percent )
{
    if ( randomfloat( 1 ) < target_percent )
    {
        return true;
    }
    
    return false;
}

// Namespace bgb_token
// Params 1
// Checksum 0x9fef18d2, Offset: 0x7e0
// Size: 0x1ec
function function_51cf4361( var_5561679e )
{
    if ( !is_bgb_token_in_use() )
    {
        return;
    }
    
    if ( 0 <= level.bgb_token_max_per_game && self.bgb_tokens_gained_this_game >= level.bgb_token_max_per_game )
    {
        return;
    }
    
    time_played_total = self zm_stats::get_global_stat( "TIME_PLAYED_TOTAL" );
    
    if ( time_played_total - level.var_baa8fd09 > self.bgb_token_last_given_time )
    {
        if ( bgb_token_percent_chance( level.var_342aa5b2 ) )
        {
            self bgb_token_give_to_player();
        }
        
        return;
    }
    
    if ( level.round_number < level.var_4d1d42c7 )
    {
        return;
    }
    
    var_95d14cf5 = math::clamp( var_5561679e, 0, level.var_5f0752c5 );
    var_741485e6 = float( var_95d14cf5 ) / level.var_5f0752c5;
    
    if ( !bgb_token_percent_chance( var_741485e6 * level.var_af87760a ) )
    {
        return;
    }
    
    var_edfe0eb4 = self.var_bc978de9 - level.round_number;
    
    if ( 1 > var_edfe0eb4 )
    {
        var_edfe0eb4 = 1;
    }
    
    var_b8a1486b = float( var_edfe0eb4 * var_edfe0eb4 );
    
    if ( !bgb_token_percent_chance( 1 / var_b8a1486b ) )
    {
        return;
    }
    
    self bgb_token_give_to_player();
}

