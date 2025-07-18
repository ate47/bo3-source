#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;

#namespace zombie_death;

// Namespace zombie_death
// Params 0
// Checksum 0xeee21498, Offset: 0x2c8
// Size: 0x66
function on_fire_timeout()
{
    self endon( #"death" );
    
    if ( isdefined( self.flame_fx_timeout ) )
    {
        wait self.flame_fx_timeout;
    }
    else
    {
        wait 12;
    }
    
    if ( isdefined( self ) && isalive( self ) )
    {
        self.is_on_fire = 0;
        self notify( #"stop_flame_damage" );
    }
}

// Namespace zombie_death
// Params 0
// Checksum 0xd59f9598, Offset: 0x338
// Size: 0x3bc
function flame_death_fx()
{
    self endon( #"death" );
    
    if ( isdefined( self.is_on_fire ) && self.is_on_fire )
    {
        return;
    }
    
    if ( isdefined( self.disable_flame_fx ) && self.disable_flame_fx )
    {
        return;
    }
    
    self.is_on_fire = 1;
    self thread on_fire_timeout();
    
    if ( isdefined( level._effect ) && isdefined( level._effect[ "character_fire_death_torso" ] ) )
    {
        fire_tag = "j_spinelower";
        fire_death_torso_fx = level._effect[ "character_fire_death_torso" ];
        
        if ( isdefined( self.weapon_specific_fire_death_torso_fx ) )
        {
            fire_death_torso_fx = self.weapon_specific_fire_death_torso_fx;
        }
        
        if ( !isdefined( self gettagorigin( fire_tag ) ) )
        {
            fire_tag = "tag_origin";
        }
        
        if ( !isdefined( self.isdog ) || !self.isdog )
        {
            playfxontag( fire_death_torso_fx, self, fire_tag );
        }
        
        self.weapon_specific_fire_death_torso_fx = undefined;
    }
    else
    {
        println( "<dev string:x28>" );
    }
    
    if ( isdefined( level._effect ) && isdefined( level._effect[ "character_fire_death_sm" ] ) )
    {
        if ( self.archetype !== "parasite" && self.archetype !== "raps" && self.archetype !== "spider" )
        {
            fire_death_sm_fx = level._effect[ "character_fire_death_sm" ];
            
            if ( isdefined( self.weapon_specific_fire_death_sm_fx ) )
            {
                fire_death_sm_fx = self.weapon_specific_fire_death_sm_fx;
            }
            
            if ( isdefined( self.weapon_specific_fire_death_torso_fx ) )
            {
                fire_death_torso_fx = self.weapon_specific_fire_death_torso_fx;
            }
            
            wait 1;
            tagarray = [];
            tagarray[ 0 ] = "J_Elbow_LE";
            tagarray[ 1 ] = "J_Elbow_RI";
            tagarray[ 2 ] = "J_Knee_RI";
            tagarray[ 3 ] = "J_Knee_LE";
            tagarray = randomize_array( tagarray );
            playfxontag( fire_death_sm_fx, self, tagarray[ 0 ] );
            wait 1;
            tagarray[ 0 ] = "J_Wrist_RI";
            tagarray[ 1 ] = "J_Wrist_LE";
            
            if ( !isdefined( self.a.gib_ref ) || self.a.gib_ref != "no_legs" )
            {
                tagarray[ 2 ] = "J_Ankle_RI";
                tagarray[ 3 ] = "J_Ankle_LE";
            }
            
            tagarray = randomize_array( tagarray );
            playfxontag( fire_death_sm_fx, self, tagarray[ 0 ] );
            playfxontag( fire_death_sm_fx, self, tagarray[ 1 ] );
            self.weapon_specific_fire_death_sm_fx = undefined;
        }
        
        return;
    }
    
    println( "<dev string:xc7>" );
}

// Namespace zombie_death
// Params 1
// Checksum 0xcded09f5, Offset: 0x700
// Size: 0x9c
function randomize_array( array )
{
    for ( i = 0; i < array.size ; i++ )
    {
        j = randomint( array.size );
        temp = array[ i ];
        array[ i ] = array[ j ];
        array[ j ] = temp;
    }
    
    return array;
}

// Namespace zombie_death
// Params 0
// Checksum 0xc9bfccf2, Offset: 0x7a8
// Size: 0x5c
function set_last_gib_time()
{
    anim notify( #"stop_last_gib_time" );
    anim endon( #"stop_last_gib_time" );
    wait 0.05;
    anim.lastgibtime = gettime();
    anim.totalgibs = randomintrange( anim.mingibs, anim.maxgibs );
}

// Namespace zombie_death
// Params 1
// Checksum 0xb5e34966, Offset: 0x810
// Size: 0x33a
function get_gib_ref( direction )
{
    if ( isdefined( self.a.gib_ref ) )
    {
        return;
    }
    
    if ( self.damagetaken < 165 )
    {
        return;
    }
    
    if ( gettime() > anim.lastgibtime + anim.gibdelay && anim.totalgibs > 0 )
    {
        anim.totalgibs--;
        anim thread set_last_gib_time();
        refs = [];
        
        switch ( direction )
        {
            case "right":
                refs[ refs.size ] = "left_arm";
                refs[ refs.size ] = "left_leg";
                gib_ref = get_random( refs );
                break;
            case "left":
                refs[ refs.size ] = "right_arm";
                refs[ refs.size ] = "right_leg";
                gib_ref = get_random( refs );
                break;
            case "forward":
                refs[ refs.size ] = "right_arm";
                refs[ refs.size ] = "left_arm";
                refs[ refs.size ] = "right_leg";
                refs[ refs.size ] = "left_leg";
                refs[ refs.size ] = "guts";
                refs[ refs.size ] = "no_legs";
                gib_ref = get_random( refs );
                break;
            case "back":
                refs[ refs.size ] = "right_arm";
                refs[ refs.size ] = "left_arm";
                refs[ refs.size ] = "right_leg";
                refs[ refs.size ] = "left_leg";
                refs[ refs.size ] = "no_legs";
                gib_ref = get_random( refs );
                break;
            default:
                refs[ refs.size ] = "right_arm";
                refs[ refs.size ] = "left_arm";
                refs[ refs.size ] = "right_leg";
                refs[ refs.size ] = "left_leg";
                refs[ refs.size ] = "no_legs";
                refs[ refs.size ] = "guts";
                gib_ref = get_random( refs );
                break;
        }
        
        self.a.gib_ref = gib_ref;
        return;
    }
    
    self.a.gib_ref = undefined;
}

// Namespace zombie_death
// Params 1
// Checksum 0xbeeb3530, Offset: 0xb58
// Size: 0x28
function get_random( array )
{
    return array[ randomint( array.size ) ];
}

// Namespace zombie_death
// Params 0
// Checksum 0x52d49d55, Offset: 0xb88
// Size: 0x15e
function do_gib()
{
    if ( !isdefined( self.a.gib_ref ) )
    {
        return;
    }
    
    if ( isdefined( self.is_on_fire ) && self.is_on_fire )
    {
        return;
    }
    
    switch ( self.a.gib_ref )
    {
        case "right_arm":
            gibserverutils::gibrightarm( self );
            break;
        case "left_arm":
            gibserverutils::gibleftarm( self );
            break;
        case "right_leg":
            gibserverutils::gibrightleg( self );
            break;
        case "left_leg":
            gibserverutils::gibleftleg( self );
            break;
        case "no_legs":
            gibserverutils::giblegs( self );
            break;
        case "head":
            gibserverutils::gibhead( self );
            break;
        case "guts":
            break;
        default:
            assertmsg( "<dev string:x160>" + self.a.gib_ref + "<dev string:x172>" );
            break;
    }
}

// Namespace zombie_death
// Params 0
// Checksum 0xec25bf32, Offset: 0xcf0
// Size: 0x56
function precache_gib_fx()
{
    anim._effect[ "animscript_gib_fx" ] = "zombie/fx_blood_torso_explo_zmb";
    anim._effect[ "animscript_gibtrail_fx" ] = "_t6/trail/fx_trail_blood_streak";
    anim._effect[ "death_neckgrab_spurt" ] = "_t6/impacts/fx_flesh_hit_neck_fatal";
}

