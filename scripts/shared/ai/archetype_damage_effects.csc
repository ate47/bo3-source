#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace archetype_damage_effects;

// Namespace archetype_damage_effects
// Params 0, eflags: 0x2
// Checksum 0xf02a96fb, Offset: 0x11d0
// Size: 0x24
function autoexec main()
{
    registerclientfields();
    loadeffects();
}

// Namespace archetype_damage_effects
// Params 0
// Checksum 0x2862588d, Offset: 0x1200
// Size: 0x94
function registerclientfields()
{
    clientfield::register( "actor", "arch_actor_fire_fx", 1, 2, "int", &actor_fire_fx_state, 0, 0 );
    clientfield::register( "actor", "arch_actor_char", 1, 2, "int", &actor_char, 0, 0 );
}

// Namespace archetype_damage_effects
// Params 0
// Checksum 0x2bc6036f, Offset: 0x12a0
// Size: 0xa82
function loadeffects()
{
    level._effect[ "fire_human_j_elbow_le_loop" ] = "fire/fx_fire_ai_human_arm_left_loop";
    level._effect[ "fire_human_j_elbow_ri_loop" ] = "fire/fx_fire_ai_human_arm_right_loop";
    level._effect[ "fire_human_j_shoulder_le_loop" ] = "fire/fx_fire_ai_human_arm_left_loop";
    level._effect[ "fire_human_j_shoulder_ri_loop" ] = "fire/fx_fire_ai_human_arm_right_loop";
    level._effect[ "fire_human_j_spine4_loop" ] = "fire/fx_fire_ai_human_torso_loop";
    level._effect[ "fire_human_j_hip_le_loop" ] = "fire/fx_fire_ai_human_hip_left_loop";
    level._effect[ "fire_human_j_hip_ri_loop" ] = "fire/fx_fire_ai_human_hip_right_loop";
    level._effect[ "fire_human_j_knee_le_loop" ] = "fire/fx_fire_ai_human_leg_left_loop";
    level._effect[ "fire_human_j_knee_ri_loop" ] = "fire/fx_fire_ai_human_leg_right_loop";
    level._effect[ "fire_human_j_head_loop" ] = "fire/fx_fire_ai_human_head_loop";
    level._effect[ "fire_human_j_elbow_le_os" ] = "fire/fx_fire_ai_human_arm_left_os";
    level._effect[ "fire_human_j_elbow_ri_os" ] = "fire/fx_fire_ai_human_arm_right_os";
    level._effect[ "fire_human_j_shoulder_le_os" ] = "fire/fx_fire_ai_human_arm_left_os";
    level._effect[ "fire_human_j_shoulder_ri_os" ] = "fire/fx_fire_ai_human_arm_right_os";
    level._effect[ "fire_human_j_spine4_os" ] = "fire/fx_fire_ai_human_torso_os";
    level._effect[ "fire_human_j_hip_le_os" ] = "fire/fx_fire_ai_human_hip_left_os";
    level._effect[ "fire_human_j_hip_ri_os" ] = "fire/fx_fire_ai_human_hip_right_os";
    level._effect[ "fire_human_j_knee_le_os" ] = "fire/fx_fire_ai_human_leg_left_os";
    level._effect[ "fire_human_j_knee_ri_os" ] = "fire/fx_fire_ai_human_leg_right_os";
    level._effect[ "fire_human_j_head_os" ] = "fire/fx_fire_ai_human_head_os";
    level._effect[ "fire_human_riotshield_j_elbow_le_loop" ] = "fire/fx_fire_ai_human_arm_left_loop";
    level._effect[ "fire_human_riotshield_j_elbow_ri_loop" ] = "fire/fx_fire_ai_human_arm_right_loop";
    level._effect[ "fire_human_riotshield_j_shoulder_le_loop" ] = "fire/fx_fire_ai_human_arm_left_loop";
    level._effect[ "fire_human_riotshield_j_shoulder_ri_loop" ] = "fire/fx_fire_ai_human_arm_right_loop";
    level._effect[ "fire_human_riotshield_j_spine4_loop" ] = "fire/fx_fire_ai_human_torso_loop";
    level._effect[ "fire_human_riotshield_j_hip_le_loop" ] = "fire/fx_fire_ai_human_hip_left_loop";
    level._effect[ "fire_human_riotshield_j_hip_ri_loop" ] = "fire/fx_fire_ai_human_hip_right_loop";
    level._effect[ "fire_human_riotshield_j_knee_le_loop" ] = "fire/fx_fire_ai_human_leg_left_loop";
    level._effect[ "fire_human_riotshield_j_knee_ri_loop" ] = "fire/fx_fire_ai_human_leg_right_loop";
    level._effect[ "fire_human_riotshield_j_head_loop" ] = "fire/fx_fire_ai_human_head_loop";
    level._effect[ "fire_human_riotshield_j_elbow_le_os" ] = "fire/fx_fire_ai_human_arm_left_os";
    level._effect[ "fire_human_riotshield_j_elbow_ri_os" ] = "fire/fx_fire_ai_human_arm_right_os";
    level._effect[ "fire_human_riotshield_j_shoulder_le_os" ] = "fire/fx_fire_ai_human_arm_left_os";
    level._effect[ "fire_human_riotshield_j_shoulder_ri_os" ] = "fire/fx_fire_ai_human_arm_right_os";
    level._effect[ "fire_human_riotshield_j_spine4_os" ] = "fire/fx_fire_ai_human_torso_os";
    level._effect[ "fire_human_riotshield_j_hip_le_os" ] = "fire/fx_fire_ai_human_hip_left_os";
    level._effect[ "fire_human_riotshield_j_hip_ri_os" ] = "fire/fx_fire_ai_human_hip_right_os";
    level._effect[ "fire_human_riotshield_j_knee_le_os" ] = "fire/fx_fire_ai_human_leg_left_os";
    level._effect[ "fire_human_riotshield_j_knee_ri_os" ] = "fire/fx_fire_ai_human_leg_right_os";
    level._effect[ "fire_human_riotshield_j_head_os" ] = "fire/fx_fire_ai_human_head_os";
    level._effect[ "fire_warlord_j_elbow_le_loop" ] = "fire/fx_fire_ai_human_arm_left_loop";
    level._effect[ "fire_warlord_j_elbow_ri_loop" ] = "fire/fx_fire_ai_human_arm_right_loop";
    level._effect[ "fire_warlord_j_shoulder_le_loop" ] = "fire/fx_fire_ai_human_arm_left_loop";
    level._effect[ "fire_warlord_j_shoulder_ri_loop" ] = "fire/fx_fire_ai_human_arm_right_loop";
    level._effect[ "fire_warlord_j_spine4_loop" ] = "fire/fx_fire_ai_human_torso_loop";
    level._effect[ "fire_warlord_j_hip_le_loop" ] = "fire/fx_fire_ai_human_hip_left_loop";
    level._effect[ "fire_warlord_j_hip_ri_loop" ] = "fire/fx_fire_ai_human_hip_right_loop";
    level._effect[ "fire_warlord_j_knee_le_loop" ] = "fire/fx_fire_ai_human_leg_left_loop";
    level._effect[ "fire_warlord_j_knee_ri_loop" ] = "fire/fx_fire_ai_human_leg_right_loop";
    level._effect[ "fire_warlord_j_head_loop" ] = "fire/fx_fire_ai_human_head_loop";
    level._effect[ "fire_warlord_j_elbow_le_os" ] = "fire/fx_fire_ai_human_arm_left_os";
    level._effect[ "fire_warlord_j_elbow_ri_os" ] = "fire/fx_fire_ai_human_arm_right_os";
    level._effect[ "fire_warlord_j_shoulder_le_os" ] = "fire/fx_fire_ai_human_arm_left_os";
    level._effect[ "fire_warlord_j_shoulder_ri_os" ] = "fire/fx_fire_ai_human_arm_right_os";
    level._effect[ "fire_warlord_j_spine4_os" ] = "fire/fx_fire_ai_human_torso_os";
    level._effect[ "fire_warlord_j_hip_le_os" ] = "fire/fx_fire_ai_human_hip_left_os";
    level._effect[ "fire_warlord_j_hip_ri_os" ] = "fire/fx_fire_ai_human_hip_right_os";
    level._effect[ "fire_warlord_j_knee_le_os" ] = "fire/fx_fire_ai_human_leg_left_os";
    level._effect[ "fire_warlord_j_knee_ri_os" ] = "fire/fx_fire_ai_human_leg_right_os";
    level._effect[ "fire_warlord_j_head_os" ] = "fire/fx_fire_ai_human_head_os";
    level._effect[ "fire_zombie_j_elbow_le_os" ] = "fire/fx_fire_ai_human_arm_left_os";
    level._effect[ "fire_zombie_j_elbow_ri_os" ] = "fire/fx_fire_ai_human_arm_right_os";
    level._effect[ "fire_zombie_j_shoulder_le_os" ] = "fire/fx_fire_ai_human_arm_left_os";
    level._effect[ "fire_zombie_j_shoulder_ri_os" ] = "fire/fx_fire_ai_human_arm_right_os";
    level._effect[ "fire_zombie_j_spine4_os" ] = "fire/fx_fire_ai_human_torso_os";
    level._effect[ "fire_zombie_j_hip_le_os" ] = "fire/fx_fire_ai_human_hip_left_os";
    level._effect[ "fire_zombie_j_hip_ri_os" ] = "fire/fx_fire_ai_human_hip_right_os";
    level._effect[ "fire_zombie_j_knee_le_os" ] = "fire/fx_fire_ai_human_leg_left_os";
    level._effect[ "fire_zombie_j_knee_ri_os" ] = "fire/fx_fire_ai_human_leg_right_os";
    level._effect[ "fire_zombie_j_head_os" ] = "fire/fx_fire_ai_human_head_os";
    level._effect[ "smolder_human_j_elbow_le_os" ] = "smoke/fx_smk_ai_human_arm_left_os";
    level._effect[ "smolder_human_j_elbow_ri_os" ] = "smoke/fx_smk_ai_human_arm_right_os";
    level._effect[ "smolder_human_j_shoulder_le_os" ] = "smoke/fx_smk_ai_human_arm_left_os";
    level._effect[ "smolder_human_j_shoulder_ri_os" ] = "smoke/fx_smk_ai_human_arm_right_os";
    level._effect[ "smolder_human_j_spine4_os" ] = "smoke/fx_smk_ai_human_torso_os";
    level._effect[ "smolder_human_j_hip_le_os" ] = "smoke/fx_smk_ai_human_hip_left_os";
    level._effect[ "smolder_human_j_hip_ri_os" ] = "smoke/fx_smk_ai_human_hip_right_os";
    level._effect[ "smolder_human_j_knee_le_os" ] = "smoke/fx_smk_ai_human_leg_left_os";
    level._effect[ "smolder_human_j_knee_ri_os" ] = "smoke/fx_smk_ai_human_leg_right_os";
    level._effect[ "smolder_human_j_head_os" ] = "smoke/fx_smk_ai_human_head_os";
    level._effect[ "fire_robot_j_elbow_le_rot_loop" ] = "fire/fx_fire_ai_robot_arm_left_loop";
    level._effect[ "fire_robot_j_elbow_ri_rot_loop" ] = "fire/fx_fire_ai_robot_arm_right_loop";
    level._effect[ "fire_robot_j_shoulder_le_rot_loop" ] = "fire/fx_fire_ai_robot_arm_left_loop";
    level._effect[ "fire_robot_j_shoulder_ri_rot_loop" ] = "fire/fx_fire_ai_robot_arm_right_loop";
    level._effect[ "fire_robot_j_spine4_loop" ] = "fire/fx_fire_ai_robot_torso_loop";
    level._effect[ "fire_robot_j_knee_le_loop" ] = "fire/fx_fire_ai_robot_leg_left_loop";
    level._effect[ "fire_robot_j_knee_ri_loop" ] = "fire/fx_fire_ai_robot_leg_right_loop";
    level._effect[ "fire_robot_j_head_loop" ] = "fire/fx_fire_ai_robot_head_loop";
    level._effect[ "fire_robot_j_elbow_le_rot_os" ] = "fire/fx_fire_ai_robot_arm_left_os";
    level._effect[ "fire_robot_j_elbow_ri_rot_os" ] = "fire/fx_fire_ai_robot_arm_right_os";
    level._effect[ "fire_robot_j_shoulder_le_rot_os" ] = "fire/fx_fire_ai_robot_arm_left_os";
    level._effect[ "fire_robot_j_shoulder_ri_rot_os" ] = "fire/fx_fire_ai_robot_arm_right_os";
    level._effect[ "fire_robot_j_spine4_os" ] = "fire/fx_fire_ai_robot_torso_os";
    level._effect[ "fire_robot_j_knee_le_os" ] = "fire/fx_fire_ai_robot_leg_left_os";
    level._effect[ "fire_robot_j_knee_ri_os" ] = "fire/fx_fire_ai_robot_leg_right_os";
    level._effect[ "fire_robot_j_head_os" ] = "fire/fx_fire_ai_robot_head_os";
}

// Namespace archetype_damage_effects
// Params 3, eflags: 0x4
// Checksum 0xe1450fb9, Offset: 0x1d30
// Size: 0x15a
function private _burntag( localclientnum, tag, postfix )
{
    if ( isdefined( self ) && self hasdobj( localclientnum ) )
    {
        fx_to_play = undefined;
        fxname = "fire_" + self.archetype + "_" + tag + postfix;
        
        if ( isdefined( level._effect[ fxname ] ) )
        {
            fx_to_play = level._effect[ fxname ];
        }
        
        if ( isdefined( self._effect ) && isdefined( self._effect[ fxname ] ) )
        {
            fx_to_play = self._effect[ fxname ];
        }
        
        if ( isdefined( fx_to_play ) )
        {
            fx = playfxontag( localclientnum, fx_to_play, self, tag );
            
            if ( sessionmodeiscampaignzombiesgame() && isdefined( fx ) )
            {
                setfxignorepause( localclientnum, fx, 1 );
            }
            
            return fx;
        }
    }
}

// Namespace archetype_damage_effects
// Params 3, eflags: 0x4
// Checksum 0x6964bec5, Offset: 0x1e98
// Size: 0x14a
function private _burnstage( localclientnum, tagarray, shouldwait )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self endon( #"entityshutdown" );
    tags = array::randomize( tagarray );
    
    for ( i = 1; i < tags.size ; i++ )
    {
        if ( tags[ i ] == "null" )
        {
            continue;
        }
        
        self.activefx[ self.activefx.size ] = self _burntag( localclientnum, tags[ i ], shouldwait ? "_loop" : "_os" );
        
        if ( shouldwait )
        {
            wait randomfloatrange( 0.1, 0.3 );
        }
    }
    
    if ( shouldwait )
    {
        wait randomfloatrange( 0, 1 );
    }
    
    if ( isdefined( self ) )
    {
        self notify( #"burn_stage_finished" );
    }
}

// Namespace archetype_damage_effects
// Params 1, eflags: 0x4
// Checksum 0x73388c1a, Offset: 0x1ff0
// Size: 0x48c
function private _burnbody( localclientnum )
{
    self endon( #"entityshutdown" );
    self.burn_loop_sound_handle = self playloopsound( "chr_burn_npc_loop1", 0.2 );
    timer = 10;
    bonemodifier = "";
    
    if ( self.archetype == "robot" )
    {
        bonemodifier = "_rot";
        timer = 6;
    }
    
    if ( sessionmodeiscampaignzombiesgame() )
    {
        if ( self.archetype !== "zombie" )
        {
            self thread sndstopburnloop( timer );
        }
    }
    else
    {
        self thread sndstopburnloop( timer );
    }
    
    stage1burntags = array( "j_elbow_le" + bonemodifier, "j_elbow_ri" + bonemodifier, "null" );
    stage2burntags = array( "j_shoulder_le" + bonemodifier, "j_shoulder_ri" + bonemodifier, "null" );
    stage3burntags = array( "j_spine4", "null" );
    stage4burntags = array( "j_hip_le", "j_hip_ri", "j_head", "null" );
    stage5burntags = array( "j_knee_le", "j_knee_ri", "null" );
    maturemask = 0;
    
    if ( util::is_mature() )
    {
        maturemask = 1;
    }
    
    self.activefx = [];
    self.activefx[ self.activefx.size ] = self thread _burnstage( localclientnum, stage1burntags, 1 );
    self mapshaderconstant( localclientnum, 0, "scriptVector0", maturemask * 0.2 );
    self waittill( #"burn_stage_finished" );
    self.activefx[ self.activefx.size ] = self thread _burnstage( localclientnum, stage2burntags, 1 );
    self mapshaderconstant( localclientnum, 0, "scriptVector0", maturemask * 0.4 );
    self waittill( #"burn_stage_finished" );
    self.activefx[ self.activefx.size ] = self thread _burnstage( localclientnum, stage3burntags, 1 );
    self mapshaderconstant( localclientnum, 0, "scriptVector0", maturemask * 0.6 );
    self waittill( #"burn_stage_finished" );
    self.activefx[ self.activefx.size ] = self thread _burnstage( localclientnum, stage4burntags, 1 );
    self mapshaderconstant( localclientnum, 0, "scriptVector0", maturemask * 0.8 );
    self waittill( #"burn_stage_finished" );
    self.activefx[ self.activefx.size ] = self thread _burnstage( localclientnum, stage5burntags, 1 );
    self mapshaderconstant( localclientnum, 0, "scriptVector0", maturemask * 1 );
}

// Namespace archetype_damage_effects
// Params 1
// Checksum 0x6d57220, Offset: 0x2488
// Size: 0x64
function sndstopburnloop( timer )
{
    self util::waittill_any_timeout( timer, "entityshutdown", "stopBurningSounds" );
    
    if ( isdefined( self ) )
    {
        if ( isdefined( self.burn_loop_sound_handle ) )
        {
            self stoploopsound( self.burn_loop_sound_handle );
        }
    }
}

// Namespace archetype_damage_effects
// Params 2, eflags: 0x4
// Checksum 0xeb0ba258, Offset: 0x24f8
// Size: 0x3e4
function private _burncorpse( localclientnum, burningduration )
{
    self endon( #"entityshutdown" );
    timer = 10;
    bonemodifier = "";
    
    if ( self.archetype == "robot" )
    {
        bonemodifier = "_rot";
        timer = 3;
    }
    
    stage1burntags = array( "j_elbow_le" + bonemodifier, "j_elbow_ri" + bonemodifier );
    stage2burntags = array( "j_shoulder_le" + bonemodifier, "j_shoulder_ri" + bonemodifier );
    stage3burntags = array( "j_spine4", "j_spinelower", "null" );
    stage4burntags = array( "j_hip_le", "j_hip_ri", "j_head" );
    stage5burntags = array( "j_knee_le", "j_knee_ri" );
    self.burn_loop_sound_handle = self playloopsound( "chr_burn_npc_loop1", 0.2 );
    self thread sndstopburnloop( timer );
    self.activefx = [];
    self.activefx[ self.activefx.size ] = self thread _burnstage( localclientnum, stage1burntags, 0 );
    self.activefx[ self.activefx.size ] = self thread _burnstage( localclientnum, stage2burntags, 0 );
    self.activefx[ self.activefx.size ] = self thread _burnstage( localclientnum, stage3burntags, 0 );
    self.activefx[ self.activefx.size ] = self thread _burnstage( localclientnum, stage4burntags, 0 );
    self.activefx[ self.activefx.size ] = self thread _burnstage( localclientnum, stage5burntags, 0 );
    maturemask = 0;
    
    if ( util::is_mature() )
    {
        maturemask = 1;
    }
    
    self mapshaderconstant( localclientnum, 0, "scriptVector0", maturemask * 1 );
    wait 20;
    
    if ( isdefined( self ) )
    {
        foreach ( fx in self.activefx )
        {
            stopfx( localclientnum, fx );
            self notify( #"stopburningsounds" );
        }
        
        if ( isdefined( self ) )
        {
            self.activefx = [];
        }
    }
}

// Namespace archetype_damage_effects
// Params 1, eflags: 0x4
// Checksum 0x30e14d54, Offset: 0x28e8
// Size: 0x2e2
function private _smoldercorpse( localclientnum )
{
    self endon( #"entityshutdown" );
    bonemodifier = "";
    
    if ( self.archetype == "robot" )
    {
        bonemodifier = "_rot";
    }
    
    activefx = [];
    fxtoplay = [];
    tags = array( "j_elbow_le" + bonemodifier, "j_elbow_ri" + bonemodifier, "j_shoulder_le", "j_shoulder_ri", "j_spine4", "j_hip_le", "j_hip_ri", "j_knee_le", "j_knee_ri", "j_head" );
    
    for ( num = randomintrange( 6, 10 ); num ; num-- )
    {
        fxtoplay[ fxtoplay.size ] = tags[ randomint( tags.size ) ];
    }
    
    foreach ( tag in fxtoplay )
    {
        fx = "smolder_" + self.archetype + tag + "_os";
        
        if ( isdefined( level._effect[ fx ] ) )
        {
            activefx[ activefx.size ] = playfxontag( localclientnum, level._effect[ fx ], self, tag );
            wait randomfloatrange( 0.1, 1 );
        }
    }
    
    wait 20;
    
    if ( isdefined( self ) )
    {
        foreach ( fx in activefx )
        {
            stopfx( localclientnum, fx );
        }
    }
}

// Namespace archetype_damage_effects
// Params 3
// Checksum 0x9d5a020f, Offset: 0x2bd8
// Size: 0x16e
function actor_fire_fx( localclientnum, value, burningduration )
{
    switch ( value )
    {
        case 0:
            if ( isdefined( self.activefx ) )
            {
                self stopallloopsounds( 1 );
                
                foreach ( fx in self.activefx )
                {
                    stopfx( localclientnum, fx );
                }
            }
            
            self.activefx = [];
            break;
        case 1:
            self thread _burnbody( localclientnum );
            break;
        case 2:
            self thread _burncorpse( localclientnum, burningduration );
            break;
        case 3:
            self thread _smoldercorpse( localclientnum );
            break;
    }
}

// Namespace archetype_damage_effects
// Params 7
// Checksum 0xe0aee3e6, Offset: 0x2d50
// Size: 0x5c
function actor_fire_fx_state( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self actor_fire_fx( localclientnum, newval, 14 );
}

// Namespace archetype_damage_effects
// Params 7
// Checksum 0x47ee5fc6, Offset: 0x2db8
// Size: 0x116
function actor_char( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    maturemask = 0;
    
    if ( util::is_mature() )
    {
        maturemask = 1;
    }
    
    switch ( newval )
    {
        case 1:
            self thread actorcharrampto( localclientnum, 1 );
            break;
        case 0:
            self mapshaderconstant( localclientnum, 0, "scriptVector0", 0 );
            break;
        case 2:
            self mapshaderconstant( localclientnum, 0, "scriptVector0", maturemask * 1 );
            break;
    }
}

// Namespace archetype_damage_effects
// Params 2
// Checksum 0xecb46d7, Offset: 0x2ed8
// Size: 0x168
function actorcharrampto( localclientnum, chardesired )
{
    self endon( #"entityshutdown" );
    
    if ( !isdefined( self.curcharlevel ) )
    {
        self.curcharlevel = 0;
    }
    
    maturemask = 0;
    
    if ( util::is_mature() )
    {
        maturemask = 1;
    }
    
    if ( !isdefined( self.charsteps ) )
    {
        assert( isdefined( chardesired ) );
        self.charsteps = int( 200 );
        delta = chardesired - self.curcharlevel;
        self.charinc = delta / self.charsteps;
    }
    
    while ( self.charsteps )
    {
        self.curcharlevel = math::clamp( self.curcharlevel + self.charinc, 0, 1 );
        self mapshaderconstant( localclientnum, 0, "scriptVector0", maturemask * self.curcharlevel );
        self.charsteps--;
        wait 0.01;
    }
}

