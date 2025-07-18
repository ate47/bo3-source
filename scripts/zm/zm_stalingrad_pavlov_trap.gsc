#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_stalingrad;
#using scripts/zm/zm_stalingrad_util;
#using scripts/zm/zm_stalingrad_vo;

#namespace zm_stalingrad_pavlov_trap;

// Namespace zm_stalingrad_pavlov_trap
// Params 0
// Checksum 0x41a27a2c, Offset: 0x430
// Size: 0x17a
function main()
{
    a_t_flinger = struct::get_array( "flinger_trigger", "targetname" );
    
    foreach ( s_flinger in a_t_flinger )
    {
        var_66e182a0 = getentarray( s_flinger.target, "targetname" );
        s_flinger.var_66e182a0 = var_66e182a0;
        
        foreach ( var_a70a7d09 in var_66e182a0 )
        {
            s_flinger.var_a70a7d09 = var_a70a7d09;
        }
        
        s_flinger function_41b278b3();
    }
}

// Namespace zm_stalingrad_pavlov_trap
// Params 0
// Checksum 0xf6d017f8, Offset: 0x5b8
// Size: 0x8c
function function_41b278b3()
{
    self.script_unitrigger_type = "unitrigger_box_use";
    self.cursor_hint = "HINT_NOICON";
    self.require_look_at = 1;
    self.script_width = 32;
    self.script_height = 128;
    self.script_length = 32;
    self.prompt_and_visibility_func = &function_fbea6a64;
    zm_unitrigger::register_static_unitrigger( self, &function_335dff5e );
}

// Namespace zm_stalingrad_pavlov_trap
// Params 1
// Checksum 0x1e9e3ab3, Offset: 0x650
// Size: 0x19a
function function_fbea6a64( e_player )
{
    if ( e_player.is_drinking > 0 )
    {
        self sethintstring( "" );
        return 0;
    }
    
    if ( level flag::get( "lockdown_active" ) && self.stub.script_noteworthy !== "street_flinger" )
    {
        self sethintstring( &"ZM_STALINGRAD_FLINGER_DISABLED" );
        return 0;
    }
    
    if ( isdefined( self.stub.var_66a9cd70 ) && self.stub.var_66a9cd70 )
    {
        self sethintstring( &"ZOMBIE_TRAP_ACTIVE" );
        return 0;
    }
    
    if ( !level flag::get( "power_on" ) )
    {
        self sethintstring( &"ZOMBIE_NEED_POWER" );
        return 0;
    }
    
    if ( self.stub.var_dd690f31 === 0 )
    {
        self sethintstring( &"ZM_STALINGRAD_TRAP_COOLDOWN" );
        return 0;
    }
    
    self sethintstring( &"ZM_STALINGRAD_FLINGER_TRAP_USE", 1000 );
    return 1;
}

// Namespace zm_stalingrad_pavlov_trap
// Params 0
// Checksum 0x94d734e2, Offset: 0x7f8
// Size: 0x18e
function function_335dff5e()
{
    self waittill( #"trigger", e_player );
    
    if ( self.stub.var_dd690f31 !== 0 && e_player zm_score::can_player_purchase( 1000 ) )
    {
        e_player clientfield::increment_to_player( "interact_rumble" );
        e_player zm_score::minus_to_player_score( 1000 );
        
        foreach ( var_a70a7d09 in self.stub.var_66e182a0 )
        {
            self.stub thread function_d9a07413( e_player, var_a70a7d09 );
        }
        
        return;
    }
    
    zm_utility::play_sound_at_pos( "no_purchase", self.origin );
    
    if ( isdefined( level.custom_generic_deny_vo_func ) )
    {
        e_player thread [[ level.custom_generic_deny_vo_func ]]( 1 );
        return;
    }
    
    e_player zm_audio::create_and_play_dialog( "general", "outofmoney" );
    return;
}

// Namespace zm_stalingrad_pavlov_trap
// Params 2
// Checksum 0x32350c07, Offset: 0x990
// Size: 0x466
function function_d9a07413( e_player, var_a70a7d09 )
{
    self.var_66a9cd70 = 1;
    
    if ( self.target === "flinger_pavlov_street" )
    {
        var_76b899c0 = struct::get_array( "flinger_pavlov_street", "target" );
        
        foreach ( s_struct in var_76b899c0 )
        {
            s_struct.var_66a9cd70 = 1;
        }
    }
    
    self zm_stalingrad_util::function_903f6b36( 1 );
    var_b4f536a1 = struct::get( var_a70a7d09.target );
    var_ebbae7d4 = getent( var_b4f536a1.target, "targetname" );
    v_fling = anglestoforward( var_b4f536a1.angles );
    n_rotate_angle = var_ebbae7d4.script_int;
    
    if ( isdefined( var_ebbae7d4.target ) )
    {
        var_d617e29b = getent( var_ebbae7d4.target, "targetname" );
    }
    
    n_start_time = gettime();
    n_total_time = 0;
    e_player thread zm_stalingrad_vo::function_96153834();
    
    while ( 30 > n_total_time )
    {
        function_e0c7ad1e( var_a70a7d09 );
        function_54227761( var_a70a7d09, v_fling, e_player );
        playrumbleonposition( "zm_stalingrad_bridge_closing", var_d617e29b.origin );
        var_d617e29b scene::play( "p7_fxanim_zm_stal_flinger_trap_bundle", array( var_d617e29b ) );
        n_total_time = ( gettime() - n_start_time ) / 1000;
        wait 0.5;
    }
    
    self.var_66a9cd70 = 0;
    self.var_dd690f31 = 0;
    var_76b899c0 = struct::get_array( "flinger_pavlov_street", "target" );
    
    if ( self.target === "flinger_pavlov_street" )
    {
        foreach ( s_struct in var_76b899c0 )
        {
            s_struct.var_dd690f31 = 0;
            s_struct.var_66a9cd70 = 0;
        }
    }
    
    wait 120;
    self zm_stalingrad_util::function_903f6b36( 0 );
    self.var_dd690f31 = 1;
    
    if ( self.target === "flinger_pavlov_street" )
    {
        foreach ( s_struct in var_76b899c0 )
        {
            s_struct.var_dd690f31 = 1;
        }
    }
}

// Namespace zm_stalingrad_pavlov_trap
// Params 3
// Checksum 0x1ff3382d, Offset: 0xe00
// Size: 0x18c
function function_54227761( var_a70a7d09, v_fling, e_player )
{
    a_zombies = getaiteamarray( level.zombie_team );
    n_count = 0;
    n_kill_count = 0;
    
    foreach ( ai_zombie in a_zombies )
    {
        if ( ai_zombie istouching( var_a70a7d09 ) )
        {
            ai_zombie thread function_d2f913f5( v_fling );
            
            if ( isdefined( e_player ) )
            {
                e_player zm_stats::increment_challenge_stat( "ZOMBIE_HUNTER_KILL_TRAP" );
            }
            
            n_count++;
            n_kill_count++;
            
            if ( n_count >= 3 )
            {
                wait 0.05;
                n_count = 0;
            }
        }
    }
    
    if ( isdefined( e_player ) )
    {
        e_player notify( #"hash_e442448", n_kill_count, self.script_noteworthy );
    }
}

// Namespace zm_stalingrad_pavlov_trap
// Params 1
// Checksum 0xeafed0d3, Offset: 0xf98
// Size: 0xb2
function function_e0c7ad1e( var_a70a7d09 )
{
    foreach ( e_player in level.players )
    {
        if ( e_player istouching( var_a70a7d09 ) )
        {
            e_player thread function_fce6cca8();
        }
    }
}

// Namespace zm_stalingrad_pavlov_trap
// Params 0
// Checksum 0xcedafe99, Offset: 0x1058
// Size: 0x1a4
function function_fce6cca8()
{
    self endon( #"death" );
    var_8e692aea = [];
    var_8e692aea[ 0 ] = ( -274, 3830, -12 );
    var_8e692aea[ 1 ] = ( 270, 3865, -12 );
    var_5733bd24 = randomintrange( 0, 2 );
    var_848f1155 = spawn( "script_origin", self.origin );
    self playerlinkto( var_848f1155 );
    self notsolid();
    var_848f1155 notsolid();
    self.var_fa6d2a24 = 1;
    n_time = var_848f1155 zm_utility::fake_physicslaunch( var_8e692aea[ var_5733bd24 ], 400 );
    wait n_time;
    self dodamage( self.maxhealth * 0.34, self.origin );
    self solid();
    self.var_fa6d2a24 = 0;
    var_848f1155 delete();
}

// Namespace zm_stalingrad_pavlov_trap
// Params 1
// Checksum 0xf78b0f2e, Offset: 0x1208
// Size: 0x94
function function_d2f913f5( v_fling )
{
    self endon( #"death" );
    angle = v_fling * 300;
    self startragdoll();
    self launchragdoll( angle );
    
    if ( isalive( self ) )
    {
        self kill();
    }
}

