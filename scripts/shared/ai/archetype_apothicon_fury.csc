#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;

#namespace apothiconfurybehavior;

// Namespace apothiconfurybehavior
// Params 0, eflags: 0x2
// Checksum 0x9fc5252d, Offset: 0x3f0
// Size: 0x262
function autoexec main()
{
    ai::add_archetype_spawn_function( "apothicon_fury", &apothiconspawnsetup );
    
    if ( ai::shouldregisterclientfieldforarchetype( "apothicon_fury" ) )
    {
        clientfield::register( "actor", "fury_fire_damage", 15000, getminbitcountfornum( 7 ), "counter", &apothiconfiredamageeffect, 0, 0 );
        clientfield::register( "actor", "furious_level", 15000, 1, "int", &apothiconfuriousmodeeffect, 0, 0 );
        clientfield::register( "actor", "bamf_land", 15000, 1, "counter", &apothiconbamflandeffect, 0, 0 );
        clientfield::register( "actor", "apothicon_fury_death", 15000, 2, "int", &apothiconfurydeath, 0, 0 );
        clientfield::register( "actor", "juke_active", 15000, 1, "int", &apothiconjukeactive, 0, 0 );
    }
    
    level._effect[ "dlc4/genesis/fx_apothicon_fury_impact" ] = "dlc4/genesis/fx_apothicon_fury_impact";
    level._effect[ "dlc4/genesis/fx_apothicon_fury_breath" ] = "dlc4/genesis/fx_apothicon_fury_breath";
    level._effect[ "dlc4/genesis/fx_apothicon_fury_teleport_impact" ] = "dlc4/genesis/fx_apothicon_fury_teleport_impact";
    level._effect[ "dlc4/genesis/fx_apothicon_fury_smk_body" ] = "dlc4/genesis/fx_apothicon_fury_smk_body";
    level._effect[ "dlc4/genesis/fx_apothicon_fury_foot_amb" ] = "dlc4/genesis/fx_apothicon_fury_foot_amb";
    level._effect[ "dlc4/genesis/fx_apothicon_fury_death" ] = "dlc4/genesis/fx_apothicon_fury_death";
}

// Namespace apothiconfurybehavior
// Params 1
// Checksum 0x2e26b10f, Offset: 0x660
// Size: 0x3c
function apothiconspawnsetup( localclientnum )
{
    self thread apothiconspawnshader( localclientnum );
    self apothiconstartloopingeffects( localclientnum );
}

// Namespace apothiconfurybehavior
// Params 1
// Checksum 0xae17e177, Offset: 0x6a8
// Size: 0x192
function apothiconstartloopingeffects( localclientnum )
{
    self.loopingeffects = [];
    self.loopingeffects[ 0 ] = playfxontag( localclientnum, level._effect[ "dlc4/genesis/fx_apothicon_fury_breath" ], self, "j_head" );
    self.loopingeffects[ 1 ] = playfxontag( localclientnum, level._effect[ "dlc4/genesis/fx_apothicon_fury_smk_body" ], self, "j_spine4" );
    self.loopingeffects[ 2 ] = playfxontag( localclientnum, level._effect[ "dlc4/genesis/fx_apothicon_fury_foot_amb" ], self, "j_ball_le" );
    self.loopingeffects[ 3 ] = playfxontag( localclientnum, level._effect[ "dlc4/genesis/fx_apothicon_fury_foot_amb" ], self, "j_ball_ri" );
    self.loopingeffects[ 4 ] = playfxontag( localclientnum, level._effect[ "dlc4/genesis/fx_apothicon_fury_foot_amb" ], self, "j_wrist_le" );
    self.loopingeffects[ 5 ] = playfxontag( localclientnum, level._effect[ "dlc4/genesis/fx_apothicon_fury_foot_amb" ], self, "j_wrist_ri" );
}

// Namespace apothiconfurybehavior
// Params 1
// Checksum 0xef114daf, Offset: 0x848
// Size: 0x9a
function apothiconstoploopingeffects( localclientnum )
{
    foreach ( fx in self.loopingeffects )
    {
        killfx( localclientnum, fx );
    }
}

// Namespace apothiconfurybehavior
// Params 1
// Checksum 0x29456767, Offset: 0x8f0
// Size: 0x118
function apothiconspawnshader( localclientnum )
{
    self endon( #"entityshutdown" );
    self util::waittill_dobj( localclientnum );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    s_timer = new_timer( localclientnum );
    n_phase_in = 1;
    
    do
    {
        util::server_wait( localclientnum, 0.11 );
        n_current_time = s_timer get_time_in_seconds();
        n_delta_val = lerpfloat( 0, 0.01, n_current_time / n_phase_in );
        self mapshaderconstant( localclientnum, 0, "scriptVector2", n_delta_val );
    }
    while ( n_current_time < n_phase_in );
    
    s_timer notify( #"timer_done" );
}

// Namespace apothiconfurybehavior
// Params 7
// Checksum 0x431d689, Offset: 0xa10
// Size: 0xec
function apothiconjukeactive( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"entityshutdown" );
    self util::waittill_dobj( localclientnum );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( newval )
    {
        playsound( 0, "zmb_fury_bamf_teleport_in", self.origin );
        self apothiconstartloopingeffects( localclientnum );
        return;
    }
    
    playsound( 0, "zmb_fury_bamf_teleport_out", self.origin );
    self apothiconstoploopingeffects( localclientnum );
}

// Namespace apothiconfurybehavior
// Params 7
// Checksum 0xf91d4df8, Offset: 0xb08
// Size: 0x2a8
function apothiconfiredamageeffect( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"entityshutdown" );
    self util::waittill_dobj( localclientnum );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    tag = undefined;
    
    if ( newval == 6 )
    {
        tag = array::random( array( "J_Hip_RI", "J_Knee_RI" ) );
    }
    
    if ( newval == 7 )
    {
        tag = array::random( array( "J_Hip_LE", "J_Knee_LE" ) );
    }
    else if ( newval == 4 )
    {
        tag = array::random( array( "J_Shoulder_RI", "J_Shoulder_RI_tr", "J_Elbow_RI" ) );
    }
    else if ( newval == 5 )
    {
        tag = array::random( array( "J_Shoulder_LE", "J_Shoulder_LE_tr", "J_Elbow_LE" ) );
    }
    else if ( newval == 3 )
    {
        tag = array::random( array( "J_MainRoot" ) );
    }
    else if ( newval == 2 )
    {
        tag = array::random( array( "J_SpineUpper", "J_Clavicle_RI", "J_Clavicle_LE" ) );
    }
    else
    {
        tag = array::random( array( "J_Neck", "J_Head", "J_Helmet" ) );
    }
    
    fx = playfxontag( localclientnum, level._effect[ "dlc4/genesis/fx_apothicon_fury_impact" ], self, tag );
}

// Namespace apothiconfurybehavior
// Params 7
// Checksum 0x613eef8f, Offset: 0xdb8
// Size: 0x2ec
function apothiconfurydeath( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"entityshutdown" );
    self util::waittill_dobj( localclientnum );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( newval == 1 )
    {
        s_timer = new_timer( localclientnum );
        n_phase_in = 1;
        self.removingfireshader = 1;
        
        do
        {
            util::server_wait( localclientnum, 0.11 );
            n_current_time = s_timer get_time_in_seconds();
            n_delta_val = lerpfloat( 1, 0.1, n_current_time / n_phase_in );
            self mapshaderconstant( localclientnum, 0, "scriptVector2", n_delta_val );
        }
        while ( n_current_time < n_phase_in );
        
        s_timer notify( #"timer_done" );
        self.removingfireshader = 0;
        return;
    }
    
    if ( newval == 2 )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        playfxontag( localclientnum, level._effect[ "dlc4/genesis/fx_apothicon_fury_death" ], self, "j_spine4" );
        self apothiconstoploopingeffects( localclientnum );
        n_phase_in = 0.3;
        s_timer = new_timer( localclientnum );
        stoptime = gettime() + n_phase_in * 1000;
        
        do
        {
            util::server_wait( localclientnum, 0.11 );
            n_current_time = s_timer get_time_in_seconds();
            n_delta_val = lerpfloat( 1, 0, n_current_time / n_phase_in );
            self mapshaderconstant( localclientnum, 0, "scriptVector0", n_delta_val );
        }
        while ( n_current_time < n_phase_in && gettime() <= stoptime );
        
        s_timer notify( #"timer_done" );
        self mapshaderconstant( localclientnum, 0, "scriptVector0", 0 );
    }
}

// Namespace apothiconfurybehavior
// Params 7
// Checksum 0xf6935c58, Offset: 0x10b0
// Size: 0x150
function apothiconfuriousmodeeffect( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"entityshutdown" );
    self util::waittill_dobj( localclientnum );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( newval )
    {
        s_timer = new_timer( localclientnum );
        n_phase_in = 2;
        
        do
        {
            util::server_wait( localclientnum, 0.11 );
            n_current_time = s_timer get_time_in_seconds();
            n_delta_val = lerpfloat( 0.1, 1, n_current_time / n_phase_in );
            self mapshaderconstant( localclientnum, 0, "scriptVector2", n_delta_val );
        }
        while ( n_current_time < n_phase_in );
        
        s_timer notify( #"timer_done" );
    }
}

// Namespace apothiconfurybehavior
// Params 1
// Checksum 0x8b1caebd, Offset: 0x1208
// Size: 0x58
function new_timer( localclientnum )
{
    s_timer = spawnstruct();
    s_timer.n_time_current = 0;
    s_timer thread timer_increment_loop( localclientnum, self );
    return s_timer;
}

// Namespace apothiconfurybehavior
// Params 2
// Checksum 0x36624892, Offset: 0x1268
// Size: 0x68
function timer_increment_loop( localclientnum, entity )
{
    entity endon( #"entityshutdown" );
    self endon( #"timer_done" );
    
    while ( isdefined( self ) )
    {
        util::server_wait( localclientnum, 0.016 );
        self.n_time_current += 0.016;
    }
}

// Namespace apothiconfurybehavior
// Params 0
// Checksum 0xd4b6b984, Offset: 0x12d8
// Size: 0x10
function get_time()
{
    return self.n_time_current * 1000;
}

// Namespace apothiconfurybehavior
// Params 0
// Checksum 0x628f4955, Offset: 0x12f0
// Size: 0xa
function get_time_in_seconds()
{
    return self.n_time_current;
}

// Namespace apothiconfurybehavior
// Params 0
// Checksum 0x3194b06, Offset: 0x1308
// Size: 0x10
function reset_timer()
{
    self.n_time_current = 0;
}

// Namespace apothiconfurybehavior
// Params 7
// Checksum 0xef3b58be, Offset: 0x1320
// Size: 0x11c
function apothiconbamflandeffect( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"entityshutdown" );
    self util::waittill_dobj( localclientnum );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( newval )
    {
        playfxontag( localclientnum, level._effect[ "dlc4/genesis/fx_apothicon_fury_teleport_impact" ], self, "tag_origin" );
    }
    
    player = getlocalplayer( localclientnum );
    player earthquake( 0.5, 1.4, self.origin, 375 );
    playrumbleonposition( localclientnum, "apothicon_fury_land", self.origin );
}

