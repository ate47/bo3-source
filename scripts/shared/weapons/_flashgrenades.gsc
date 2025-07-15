#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace flashgrenades;

// Namespace flashgrenades
// Params 0
// Checksum 0xd8fafa1f, Offset: 0x180
// Size: 0x54
function init_shared()
{
    level.sound_flash_start = "";
    level.sound_flash_loop = "";
    level.sound_flash_stop = "";
    callback::on_connect( &monitorflash );
}

// Namespace flashgrenades
// Params 1
// Checksum 0xff5c74e, Offset: 0x1e0
// Size: 0x80
function flashrumbleloop( duration )
{
    self endon( #"stop_monitoring_flash" );
    self endon( #"flash_rumble_loop" );
    self notify( #"flash_rumble_loop" );
    goaltime = gettime() + duration * 1000;
    
    while ( gettime() < goaltime )
    {
        self playrumbleonentity( "damage_heavy" );
        wait 0.05;
    }
}

// Namespace flashgrenades
// Params 4
// Checksum 0xefab220d, Offset: 0x268
// Size: 0x3e4
function monitorflash_internal( amount_distance, amount_angle, attacker, direct_on_player )
{
    hurtattacker = 0;
    hurtvictim = 1;
    duration = amount_distance * 3.5;
    min_duration = 2.5;
    max_self_duration = 2.5;
    
    if ( duration < min_duration )
    {
        duration = min_duration;
    }
    
    if ( isdefined( attacker ) && attacker == self )
    {
        duration /= 3;
    }
    
    if ( duration < 0.25 )
    {
        return;
    }
    
    rumbleduration = undefined;
    
    if ( duration > 2 )
    {
        rumbleduration = 0.75;
    }
    else
    {
        rumbleduration = 0.25;
    }
    
    assert( isdefined( self.team ) );
    
    if ( level.teambased && isdefined( attacker ) && isdefined( attacker.team ) && attacker.team == self.team && attacker != self )
    {
        friendlyfire = [[ level.figure_out_friendly_fire ]]( self );
        
        if ( friendlyfire == 0 )
        {
            return;
        }
        else if ( friendlyfire == 1 )
        {
        }
        else if ( friendlyfire == 2 )
        {
            duration *= 0.5;
            rumbleduration *= 0.5;
            hurtvictim = 0;
            hurtattacker = 1;
        }
        else if ( friendlyfire == 3 )
        {
            duration *= 0.5;
            rumbleduration *= 0.5;
            hurtattacker = 1;
        }
    }
    
    if ( self hasperk( "specialty_flashprotection" ) )
    {
        duration *= 0.1;
        rumbleduration *= 0.1;
    }
    
    if ( hurtvictim )
    {
        if ( !direct_on_player && ( self util::mayapplyscreeneffect() || self isremotecontrolling() ) )
        {
            if ( isdefined( attacker ) && self != attacker && isplayer( attacker ) )
            {
                attacker addweaponstat( getweapon( "flash_grenade" ), "hits", 1 );
                attacker addweaponstat( getweapon( "flash_grenade" ), "used", 1 );
            }
            
            self thread applyflash( duration, rumbleduration, attacker );
        }
    }
    
    if ( hurtattacker )
    {
        if ( attacker util::mayapplyscreeneffect() )
        {
            attacker thread applyflash( duration, rumbleduration, attacker );
        }
    }
}

// Namespace flashgrenades
// Params 0
// Checksum 0x2f99d114, Offset: 0x658
// Size: 0xa0
function monitorflash()
{
    self endon( #"disconnect" );
    self endon( #"killflashmonitor" );
    self.flashendtime = 0;
    
    while ( true )
    {
        self waittill( #"flashbang", amount_distance, amount_angle, attacker );
        
        if ( !isalive( self ) )
        {
            continue;
        }
        
        self monitorflash_internal( amount_distance, amount_angle, attacker, 1 );
    }
}

// Namespace flashgrenades
// Params 0
// Checksum 0xf4fe401a, Offset: 0x700
// Size: 0xc8
function monitorrcbombflash()
{
    self endon( #"death" );
    self.flashendtime = 0;
    
    while ( true )
    {
        self waittill( #"flashbang", amount_distance, amount_angle, attacker );
        driver = self getseatoccupant( 0 );
        
        if ( !isdefined( driver ) || !isalive( driver ) )
        {
            continue;
        }
        
        driver monitorflash_internal( amount_distance, amount_angle, attacker, 0 );
    }
}

// Namespace flashgrenades
// Params 3
// Checksum 0x5e910e82, Offset: 0x7d0
// Size: 0x14e
function applyflash( duration, rumbleduration, attacker )
{
    if ( !isdefined( self.flashduration ) || duration > self.flashduration )
    {
        self.flashduration = duration;
    }
    
    if ( !isdefined( self.flashrumbleduration ) || rumbleduration > self.flashrumbleduration )
    {
        self.flashrumbleduration = rumbleduration;
    }
    
    self thread playflashsound( duration );
    wait 0.05;
    
    if ( isdefined( self.flashduration ) )
    {
        if ( self hasperk( "specialty_flashprotection" ) == 0 )
        {
            self shellshock( "flashbang", self.flashduration, 0 );
        }
        
        self.flashendtime = gettime() + self.flashduration * 1000;
        self.lastflashedby = attacker;
    }
    
    if ( isdefined( self.flashrumbleduration ) )
    {
        self thread flashrumbleloop( self.flashrumbleduration );
    }
    
    self.flashduration = undefined;
    self.flashrumbleduration = undefined;
}

// Namespace flashgrenades
// Params 1
// Checksum 0xb469a9ee, Offset: 0x928
// Size: 0x154
function playflashsound( duration )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    flashsound = spawn( "script_origin", ( 0, 0, 1 ) );
    flashsound.origin = self.origin;
    flashsound linkto( self );
    flashsound thread deleteentonownerdeath( self );
    flashsound playsound( level.sound_flash_start );
    flashsound playloopsound( level.sound_flash_loop );
    
    if ( duration > 0.5 )
    {
        wait duration - 0.5;
    }
    
    flashsound playsound( level.sound_flash_start );
    flashsound stoploopsound( 0.5 );
    wait 0.5;
    flashsound notify( #"delete" );
    flashsound delete();
}

// Namespace flashgrenades
// Params 1
// Checksum 0x4d8194b, Offset: 0xa88
// Size: 0x3c
function deleteentonownerdeath( owner )
{
    self endon( #"delete" );
    owner waittill( #"death" );
    self delete();
}

