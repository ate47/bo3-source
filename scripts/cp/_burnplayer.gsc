#using scripts/codescripts/struct;
#using scripts/cp/gametypes/_globallogic_player;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/util_shared;

#namespace burnplayer;

// Namespace burnplayer
// Params 0
// Checksum 0xdb1a9ec1, Offset: 0x290
// Size: 0x20
function initburnplayer()
{
    level.flamedamage = 15;
    level.flameburntime = 1.5;
}

// Namespace burnplayer
// Params 3
// Checksum 0xc392822c, Offset: 0x2b8
// Size: 0x384
function hitwithincendiary( attacker, inflictor, mod )
{
    if ( isdefined( self.burning ) )
    {
        return;
    }
    
    self thread waitthenstoptanning( level.flameburntime );
    self endon( #"disconnect" );
    attacker endon( #"disconnect" );
    waittillframeend();
    self.burning = 1;
    self thread burn_blocker();
    tagarray = [];
    
    if ( isai( self ) )
    {
        tagarray[ tagarray.size ] = "J_Wrist_RI";
        tagarray[ tagarray.size ] = "J_Wrist_LE";
        tagarray[ tagarray.size ] = "J_Elbow_LE";
        tagarray[ tagarray.size ] = "J_Elbow_RI";
        tagarray[ tagarray.size ] = "J_Knee_RI";
        tagarray[ tagarray.size ] = "J_Knee_LE";
        tagarray[ tagarray.size ] = "J_Ankle_RI";
        tagarray[ tagarray.size ] = "J_Ankle_LE";
    }
    else
    {
        tagarray[ tagarray.size ] = "J_Wrist_RI";
        tagarray[ tagarray.size ] = "J_Wrist_LE";
        tagarray[ tagarray.size ] = "J_Elbow_LE";
        tagarray[ tagarray.size ] = "J_Elbow_RI";
        tagarray[ tagarray.size ] = "J_Knee_RI";
        tagarray[ tagarray.size ] = "J_Knee_LE";
        tagarray[ tagarray.size ] = "J_Ankle_RI";
        tagarray[ tagarray.size ] = "J_Ankle_LE";
        
        if ( isplayer( self ) && self.health > 0 )
        {
            self setburn( 3 );
        }
    }
    
    if ( isdefined( level._effect[ "character_fire_death_torso" ] ) )
    {
        for ( arrayindex = 0; arrayindex < tagarray.size ; arrayindex++ )
        {
            playfxontag( level._effect[ "character_fire_death_sm" ], self, tagarray[ arrayindex ] );
        }
    }
    
    if ( isai( self ) )
    {
        playfxontag( level._effect[ "character_fire_death_torso" ], self, "J_Spine1" );
    }
    else
    {
        playfxontag( level._effect[ "character_fire_death_torso" ], self, "J_SpineLower" );
    }
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( isplayer( self ) )
    {
        self thread watchforwater( 7 );
        self thread watchfordeath();
    }
}

// Namespace burnplayer
// Params 3
// Checksum 0x78dfafc5, Offset: 0x648
// Size: 0x3bc
function hitwithnapalmstrike( attacker, inflictor, mod )
{
    if ( isdefined( self.burning ) || self hasperk( "specialty_fireproof" ) )
    {
        return;
    }
    
    self thread waitthenstoptanning( level.flameburntime );
    self endon( #"disconnect" );
    attacker endon( #"disconnect" );
    self endon( #"death" );
    
    if ( isdefined( self.burning ) )
    {
        return;
    }
    
    self thread burn_blocker();
    waittillframeend();
    self.burning = 1;
    self thread burn_blocker();
    tagarray = [];
    
    if ( isai( self ) )
    {
        tagarray[ tagarray.size ] = "J_Wrist_RI";
        tagarray[ tagarray.size ] = "J_Wrist_LE";
        tagarray[ tagarray.size ] = "J_Elbow_LE";
        tagarray[ tagarray.size ] = "J_Elbow_RI";
        tagarray[ tagarray.size ] = "J_Knee_RI";
        tagarray[ tagarray.size ] = "J_Knee_LE";
        tagarray[ tagarray.size ] = "J_Ankle_RI";
        tagarray[ tagarray.size ] = "J_Ankle_LE";
    }
    else
    {
        tagarray[ tagarray.size ] = "J_Wrist_RI";
        tagarray[ tagarray.size ] = "J_Wrist_LE";
        tagarray[ tagarray.size ] = "J_Elbow_LE";
        tagarray[ tagarray.size ] = "J_Elbow_RI";
        tagarray[ tagarray.size ] = "J_Knee_RI";
        tagarray[ tagarray.size ] = "J_Knee_LE";
        tagarray[ tagarray.size ] = "J_Ankle_RI";
        tagarray[ tagarray.size ] = "J_Ankle_LE";
        
        if ( isplayer( self ) )
        {
            self setburn( 3 );
        }
    }
    
    if ( isdefined( level._effect[ "character_fire_death_sm" ] ) )
    {
        for ( arrayindex = 0; arrayindex < tagarray.size ; arrayindex++ )
        {
            playfxontag( level._effect[ "character_fire_death_sm" ], self, tagarray[ arrayindex ] );
        }
    }
    
    if ( isdefined( level._effect[ "character_fire_death_torso" ] ) )
    {
        playfxontag( level._effect[ "character_fire_death_torso" ], self, "J_SpineLower" );
    }
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    self thread donapalmstrikedamage( attacker, inflictor, mod );
    
    if ( isplayer( self ) )
    {
        self thread watchforwater( 7 );
        self thread watchfordeath();
    }
}

// Namespace burnplayer
// Params 3
// Checksum 0x71486487, Offset: 0xa10
// Size: 0x2b4
function walkedthroughflames( attacker, inflictor, weapon )
{
    if ( isdefined( self.burning ) || self hasperk( "specialty_fireproof" ) )
    {
        return;
    }
    
    self thread waitthenstoptanning( level.flameburntime );
    self endon( #"disconnect" );
    waittillframeend();
    self.burning = 1;
    self thread burn_blocker();
    tagarray = [];
    
    if ( isai( self ) )
    {
        tagarray[ tagarray.size ] = "J_Wrist_RI";
        tagarray[ tagarray.size ] = "J_Wrist_LE";
        tagarray[ tagarray.size ] = "J_Elbow_LE";
        tagarray[ tagarray.size ] = "J_Elbow_RI";
        tagarray[ tagarray.size ] = "J_Knee_RI";
        tagarray[ tagarray.size ] = "J_Knee_LE";
        tagarray[ tagarray.size ] = "J_Ankle_RI";
        tagarray[ tagarray.size ] = "J_Ankle_LE";
    }
    else
    {
        tagarray[ tagarray.size ] = "J_Knee_RI";
        tagarray[ tagarray.size ] = "J_Knee_LE";
        tagarray[ tagarray.size ] = "J_Ankle_RI";
        tagarray[ tagarray.size ] = "J_Ankle_LE";
    }
    
    if ( isdefined( level._effect[ "character_fire_player_sm" ] ) )
    {
        for ( arrayindex = 0; arrayindex < tagarray.size ; arrayindex++ )
        {
            playfxontag( level._effect[ "character_fire_player_sm" ], self, tagarray[ arrayindex ] );
        }
    }
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    self thread doflamedamage( attacker, inflictor, weapon, 1 );
    
    if ( isplayer( self ) )
    {
        self thread watchforwater( 7 );
        self thread watchfordeath();
    }
}

// Namespace burnplayer
// Params 3
// Checksum 0xfde233a6, Offset: 0xcd0
// Size: 0x266
function burnedwithflamethrower( attacker, inflictor, weapon )
{
    if ( isdefined( self.burning ) )
    {
        return;
    }
    
    self thread waitthenstoptanning( level.flameburntime );
    self endon( #"disconnect" );
    waittillframeend();
    self.burning = 1;
    self thread burn_blocker();
    tagarray = [];
    
    if ( isai( self ) )
    {
        tagarray[ 0 ] = "J_Spine1";
        tagarray[ 1 ] = "J_Elbow_LE";
        tagarray[ 2 ] = "J_Elbow_RI";
        tagarray[ 3 ] = "J_Head";
        tagarray[ 4 ] = "j_knee_ri";
        tagarray[ 5 ] = "j_knee_le";
    }
    else
    {
        tagarray[ 0 ] = "J_Elbow_RI";
        tagarray[ 1 ] = "j_knee_ri";
        tagarray[ 2 ] = "j_knee_le";
        
        if ( isplayer( self ) && self.health > 0 )
        {
            self setburn( 3 );
        }
    }
    
    if ( isplayer( self ) && isalive( self ) )
    {
        self thread watchforwater( 7 );
        self thread watchfordeath();
    }
    
    if ( isdefined( level._effect[ "character_fire_player_sm" ] ) )
    {
        for ( arrayindex = 0; arrayindex < tagarray.size ; arrayindex++ )
        {
            playfxontag( level._effect[ "character_fire_player_sm" ], self, tagarray[ arrayindex ] );
        }
    }
}

// Namespace burnplayer
// Params 3
// Checksum 0xb18b1795, Offset: 0xf40
// Size: 0x276
function burnedwithdragonsbreath( attacker, inflictor, weapon )
{
    if ( isdefined( self.burning ) )
    {
        return;
    }
    
    self thread waitthenstoptanning( level.flameburntime );
    self endon( #"disconnect" );
    waittillframeend();
    self.burning = 1;
    self thread burn_blocker();
    tagarray = [];
    
    if ( isai( self ) )
    {
        tagarray[ 0 ] = "J_Spine1";
        tagarray[ 1 ] = "J_Elbow_LE";
        tagarray[ 2 ] = "J_Elbow_RI";
        tagarray[ 3 ] = "J_Head";
        tagarray[ 4 ] = "j_knee_ri";
        tagarray[ 5 ] = "j_knee_le";
    }
    else
    {
        tagarray[ 0 ] = "j_spinelower";
        tagarray[ 1 ] = "J_Elbow_RI";
        tagarray[ 2 ] = "j_knee_ri";
        tagarray[ 3 ] = "j_knee_le";
        
        if ( isplayer( self ) && self.health > 0 )
        {
            self setburn( 3 );
        }
    }
    
    if ( isplayer( self ) && isalive( self ) )
    {
        self thread watchforwater( 7 );
        self thread watchfordeath();
        return;
    }
    
    if ( isdefined( level._effect[ "character_fire_player_sm" ] ) )
    {
        for ( arrayindex = 0; arrayindex < tagarray.size ; arrayindex++ )
        {
            playfxontag( level._effect[ "character_fire_player_sm" ], self, tagarray[ arrayindex ] );
        }
    }
}

// Namespace burnplayer
// Params 0
// Checksum 0x331c2cbf, Offset: 0x11c0
// Size: 0x5c
function burnedtodeath()
{
    self.burning = 1;
    self thread burn_blocker();
    self thread doburningsound();
    self thread waitthenstoptanning( level.flameburntime );
}

// Namespace burnplayer
// Params 0
// Checksum 0x550702d5, Offset: 0x1228
// Size: 0x6e
function watchfordeath()
{
    self endon( #"disconnect" );
    self notify( #"hash_abaf0a23" );
    self endon( #"hash_abaf0a23" );
    self waittill( #"death" );
    
    if ( isplayer( self ) )
    {
        self _stopburning();
    }
    
    self.burning = undefined;
}

// Namespace burnplayer
// Params 1
// Checksum 0xbff4f6f2, Offset: 0x12a0
// Size: 0xa8
function watchforwater( time )
{
    self endon( #"disconnect" );
    self notify( #"hash_bbb80fa" );
    self endon( #"hash_bbb80fa" );
    wait 0.1;
    looptime = 0.1;
    
    while ( time > 0 )
    {
        wait looptime;
        
        if ( self depthofplayerinwater() > 0 )
        {
            finish_burn();
            time = 0;
        }
        
        time -= looptime;
    }
}

// Namespace burnplayer
// Params 0
// Checksum 0xb82d27e4, Offset: 0x1350
// Size: 0x120
function finish_burn()
{
    self notify( #"hash_3e41273b" );
    tagarray = [];
    tagarray[ 0 ] = "j_spinelower";
    tagarray[ 1 ] = "J_Elbow_RI";
    tagarray[ 2 ] = "J_Head";
    tagarray[ 3 ] = "j_knee_ri";
    tagarray[ 4 ] = "j_knee_le";
    
    if ( isdefined( level._effect[ "fx_fire_player_sm_smk_2sec" ] ) )
    {
        for ( arrayindex = 0; arrayindex < tagarray.size ; arrayindex++ )
        {
            playfxontag( level._effect[ "fx_fire_player_sm_smk_2sec" ], self, tagarray[ arrayindex ] );
        }
    }
    
    self.burning = undefined;
    self _stopburning();
    self.ingroundnapalm = 0;
}

// Namespace burnplayer
// Params 3
// Checksum 0x6ed45aa1, Offset: 0x1478
// Size: 0x116
function donapalmstrikedamage( attacker, inflictor, mod )
{
    if ( isai( self ) )
    {
        dodognapalmstrikedamage( attacker, inflictor, mod );
        return;
    }
    
    self endon( #"death" );
    self endon( #"disconnect" );
    attacker endon( #"disconnect" );
    self endon( #"hash_3e41273b" );
    
    while ( isdefined( level.napalmstrikedamage ) && isdefined( self ) && self depthofplayerinwater() < 1 )
    {
        self dodamage( level.napalmstrikedamage, self.origin, attacker, attacker, "none", mod, 0, getweapon( "napalm" ) );
        wait 1;
    }
}

// Namespace burnplayer
// Params 3
// Checksum 0x4ffec7e6, Offset: 0x1598
// Size: 0x308
function donapalmgrounddamage( attacker, inflictor, mod )
{
    if ( self hasperk( "specialty_fireproof" ) )
    {
        return;
    }
    
    if ( level.teambased )
    {
        if ( attacker != self && attacker.team == self.team )
        {
            return;
        }
    }
    
    if ( isai( self ) )
    {
        dodognapalmgrounddamage( attacker, inflictor, mod );
        return;
    }
    
    if ( isdefined( self.burning ) )
    {
        return;
    }
    
    self thread burn_blocker();
    self endon( #"death" );
    self endon( #"disconnect" );
    attacker endon( #"disconnect" );
    self endon( #"hash_3e41273b" );
    
    if ( isdefined( level.groundburntime ) )
    {
        if ( getdvarstring( "scr_groundBurnTime" ) == "" )
        {
            waittime = level.groundburntime;
        }
        else
        {
            waittime = getdvarfloat( "scr_groundBurnTime" );
        }
    }
    else
    {
        waittime = 100;
    }
    
    self walkedthroughflames( attacker, inflictor, getweapon( "napalm" ) );
    self.ingroundnapalm = 1;
    
    if ( isdefined( level.napalmgrounddamage ) )
    {
        if ( getdvarstring( "scr_napalmGroundDamage" ) == "" )
        {
            napalmgrounddamage = level.napalmgrounddamage;
        }
        else
        {
            napalmgrounddamage = getdvarfloat( "scr_napalmGroundDamage" );
        }
        
        while ( isdefined( self ) && isdefined( inflictor ) && self depthofplayerinwater() < 1 && waittime > 0 )
        {
            self dodamage( level.napalmgrounddamage, self.origin, attacker, inflictor, "none", mod, 0, getweapon( "napalm" ) );
            
            if ( isplayer( self ) )
            {
                self setburn( 1.1 );
            }
            
            wait 1;
            waittime -= 1;
        }
    }
    
    self.ingroundnapalm = 0;
}

// Namespace burnplayer
// Params 3
// Checksum 0xdc0e1d40, Offset: 0x18a8
// Size: 0x96
function dodognapalmstrikedamage( attacker, inflictor, mod )
{
    attacker endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"hash_3e41273b" );
    
    while ( isdefined( level.napalmstrikedamage ) && isdefined( self ) )
    {
        self dodamage( level.napalmstrikedamage, self.origin, attacker, attacker, "none", mod );
        wait 1;
    }
}

// Namespace burnplayer
// Params 3
// Checksum 0x3502b22d, Offset: 0x1948
// Size: 0xae
function dodognapalmgrounddamage( attacker, inflictor, mod )
{
    attacker endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"hash_3e41273b" );
    
    while ( isdefined( level.napalmgrounddamage ) && isdefined( self ) )
    {
        self dodamage( level.napalmgrounddamage, self.origin, attacker, attacker, "none", mod, 0, getweapon( "napalm" ) );
        wait 1;
    }
}

// Namespace burnplayer
// Params 0
// Checksum 0xdf5ba65e, Offset: 0x1a00
// Size: 0x2a
function burn_blocker()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    wait 3;
    self.burning = undefined;
}

// Namespace burnplayer
// Params 4
// Checksum 0x6603a47, Offset: 0x1a38
// Size: 0x204
function doflamedamage( attacker, inflictor, weapon, time )
{
    if ( isai( self ) )
    {
        dodogflamedamage( attacker, inflictor, weapon, time );
        return;
    }
    
    if ( isdefined( attacker ) )
    {
        attacker endon( #"disconnect" );
    }
    
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"hash_3e41273b" );
    self thread doburningsound();
    self notify( #"snd_burn_scream" );
    wait_time = 1;
    
    while ( isdefined( level.flamedamage ) && isdefined( self ) && self depthofplayerinwater() < 1 && time > 0 )
    {
        if ( isdefined( attacker ) && isdefined( inflictor ) && isdefined( weapon ) )
        {
            if ( damagefeedback::dodamagefeedback( weapon, attacker ) )
            {
                attacker damagefeedback::update();
            }
            
            self dodamage( level.flamedamage, self.origin, attacker, inflictor, "none", "MOD_BURNED", 0, weapon );
        }
        else
        {
            self dodamage( level.flamedamage, self.origin );
        }
        
        wait wait_time;
        time -= wait_time;
    }
    
    self thread finish_burn();
}

// Namespace burnplayer
// Params 4
// Checksum 0x5e4b1cb, Offset: 0x1c48
// Size: 0x116
function dodogflamedamage( attacker, inflictor, weapon, time )
{
    if ( !isdefined( attacker ) || !isdefined( inflictor ) || !isdefined( weapon ) )
    {
        return;
    }
    
    attacker endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"hash_3e41273b" );
    self thread doburningsound();
    wait_time = 1;
    
    while ( isdefined( level.flamedamage ) && isdefined( self ) && time > 0 )
    {
        self dodamage( level.flamedamage, self.origin, attacker, inflictor, "none", "MOD_BURNED", 0, weapon );
        wait wait_time;
        time -= wait_time;
    }
}

// Namespace burnplayer
// Params 1
// Checksum 0x991e2e71, Offset: 0x1d68
// Size: 0x3c
function waitthenstoptanning( time )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    wait time;
    self _stopburning();
}

// Namespace burnplayer
// Params 0
// Checksum 0xb0b2142f, Offset: 0x1db0
// Size: 0x124
function doburningsound()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    fire_sound_ent = spawn( "script_origin", self.origin );
    fire_sound_ent linkto( self, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fire_sound_ent playloopsound( "mpl_player_burn_loop" );
    self thread firesounddeath( fire_sound_ent );
    self waittill( #"stopburnsound" );
    
    if ( isdefined( fire_sound_ent ) )
    {
        fire_sound_ent stoploopsound( 0.5 );
    }
    
    wait 0.5;
    
    if ( isdefined( fire_sound_ent ) )
    {
        fire_sound_ent delete();
    }
    
    println( "<dev string:x28>" );
}

// Namespace burnplayer
// Params 0
// Checksum 0x7a6cf2fc, Offset: 0x1ee0
// Size: 0x1a
function _stopburning()
{
    self endon( #"disconnect" );
    self notify( #"stopburnsound" );
}

// Namespace burnplayer
// Params 1
// Checksum 0xa85c6b1d, Offset: 0x1f08
// Size: 0x74
function firesounddeath( ent )
{
    ent endon( #"death" );
    self util::waittill_any( "death", "disconnect" );
    ent delete();
    println( "<dev string:x3b>" );
}

