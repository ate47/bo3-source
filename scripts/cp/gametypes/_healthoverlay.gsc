#using scripts/codescripts/struct;
#using scripts/cp/gametypes/_globallogic_player;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;

#namespace healthoverlay;

// Namespace healthoverlay
// Params 0, eflags: 0x2
// Checksum 0x7f994d6d, Offset: 0x1b8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "healthoverlay", &__init__, undefined, undefined );
}

// Namespace healthoverlay
// Params 0
// Checksum 0xd8780d78, Offset: 0x1f8
// Size: 0xc4
function __init__()
{
    callback::on_start_gametype( &init );
    callback::on_joined_team( &end_health_regen );
    callback::on_joined_spectate( &end_health_regen );
    callback::on_spawned( &player_health_regen );
    callback::on_disconnect( &end_health_regen );
    callback::on_player_killed( &end_health_regen );
}

// Namespace healthoverlay
// Params 0
// Checksum 0x60477e63, Offset: 0x2c8
// Size: 0x50
function init()
{
    level.healthoverlaycutoff = 0.55;
    regentime = level.playerhealthregentime;
    level.playerhealth_regularregendelay = regentime * 1000;
    level.healthregendisabled = level.playerhealth_regularregendelay <= 0;
}

// Namespace healthoverlay
// Params 0
// Checksum 0xb216045f, Offset: 0x320
// Size: 0x4a
function end_health_regen()
{
    self.lastregendelayprogress = 1;
    self setcontrolleruimodelvalue( "hudItems.regenDelayProgress", 1 );
    self notify( #"end_healthregen" );
}

// Namespace healthoverlay
// Params 1
// Checksum 0x7f8ce855, Offset: 0x378
// Size: 0xe8
function update_regen_delay_progress( duration )
{
    remaining = duration;
    self.lastregendelayprogress = 0;
    self setcontrolleruimodelvalue( "hudItems.regenDelayProgress", self.lastregendelayprogress );
    
    while ( remaining > 0 )
    {
        wait duration / 5;
        remaining -= duration / 5;
        self.lastregendelayprogress = 1 - remaining / duration + 0.05;
        
        if ( self.lastregendelayprogress > 1 )
        {
            self.lastregendelayprogress = 1;
        }
        
        self setcontrolleruimodelvalue( "hudItems.regenDelayProgress", self.lastregendelayprogress );
    }
}

// Namespace healthoverlay
// Params 0
// Checksum 0x4060880e, Offset: 0x468
// Size: 0x68c
function player_health_regen()
{
    self endon( #"end_healthregen" );
    self endon( #"removehealthregen" );
    
    if ( self.health <= 0 )
    {
        assert( !isalive( self ) );
        return;
    }
    
    maxhealth = self.health;
    oldhealth = maxhealth;
    player = self;
    health_add = 0;
    regenrate = 0.1;
    usetrueregen = 0;
    veryhurt = 0;
    player.breathingstoptime = -10000;
    thread sndhealthlow( maxhealth * 0.2 );
    lastsoundtime_recover = 0;
    hurttime = 0;
    newhealth = 0;
    
    for ( ;; )
    {
        wait 0.05;
        
        if ( isdefined( player.regenrate ) )
        {
            regenrate = player.regenrate;
            usetrueregen = 1;
        }
        
        if ( player.health == maxhealth )
        {
            veryhurt = 0;
            self.atbrinkofdeath = 0;
            continue;
        }
        
        if ( player.health <= 0 )
        {
            return;
        }
        
        if ( isdefined( player.laststand ) && player.laststand )
        {
            if ( !isdefined( self.waiting_to_revive ) || !self.waiting_to_revive )
            {
                self.lastregendelayprogress = 0;
                self setcontrolleruimodelvalue( "hudItems.regenDelayProgress", 0 );
            }
            
            continue;
        }
        
        wasveryhurt = veryhurt;
        ratio = player.health / maxhealth;
        
        if ( ratio <= level.healthoverlaycutoff )
        {
            veryhurt = 1;
            self.atbrinkofdeath = 1;
            
            if ( !wasveryhurt )
            {
                hurttime = gettime();
            }
        }
        
        if ( player.health >= oldhealth )
        {
            if ( level.healthregendisabled )
            {
                continue;
            }
            
            regentime = level.playerhealth_regularregendelay;
            
            if ( player hasperk( "specialty_healthregen" ) )
            {
                regentime = int( regentime / getdvarfloat( "perk_healthRegenMultiplier" ) );
            }
            
            regendelayprogress = ( gettime() - hurttime ) / regentime;
            
            if ( regendelayprogress < 1 )
            {
                if ( !isdefined( self.lastregendelayprogress ) || int( self.lastregendelayprogress * 5 ) != int( regendelayprogress * 5 ) )
                {
                    self.lastregendelayprogress = regendelayprogress;
                    player setcontrolleruimodelvalue( "hudItems.regenDelayProgress", regendelayprogress );
                }
                
                continue;
            }
            
            if ( gettime() - lastsoundtime_recover > regentime )
            {
                lastsoundtime_recover = gettime();
                self notify( #"snd_breathing_better" );
            }
            
            if ( veryhurt )
            {
                newhealth = ratio;
                veryhurttime = 3000;
                
                if ( player hasperk( "specialty_healthregen" ) )
                {
                    veryhurttime = int( veryhurttime / getdvarfloat( "perk_healthRegenMultiplier" ) );
                }
                
                regendelayprogress = ( gettime() - hurttime ) / veryhurttime;
                
                if ( regendelayprogress >= 1 )
                {
                    newhealth += regenrate;
                }
                else if ( !isdefined( self.lastregendelayprogress ) || int( self.lastregendelayprogress * 5 ) != int( regendelayprogress * 5 ) )
                {
                    self.lastregendelayprogress = regendelayprogress;
                    player setcontrolleruimodelvalue( "hudItems.regenDelayProgress", regendelayprogress );
                }
            }
            else if ( usetrueregen )
            {
                newhealth = ratio + regenrate;
            }
            else
            {
                newhealth = 1;
            }
            
            if ( newhealth != oldhealth )
            {
                self.lastregendelayprogress = 1;
                player setcontrolleruimodelvalue( "hudItems.regenDelayProgress", 1 );
            }
            
            if ( newhealth >= 1 )
            {
                self globallogic_player::resetattackerlist();
                newhealth = 1;
            }
            
            if ( newhealth <= 0 )
            {
                return;
            }
            
            player setnormalhealth( newhealth );
            change = player.health - oldhealth;
            
            if ( change > 0 )
            {
                player decay_player_damages( change );
            }
            
            oldhealth = player.health;
            continue;
        }
        
        oldhealth = player.health;
        health_add = 0;
        hurttime = gettime();
        player.breathingstoptime = hurttime + 6000;
    }
}

// Namespace healthoverlay
// Params 1
// Checksum 0x1d7ea81f, Offset: 0xb00
// Size: 0xee
function decay_player_damages( decay )
{
    if ( !isdefined( self.attackerdamage ) )
    {
        return;
    }
    
    for ( i = 0; i < self.attackerdamage.size ; i++ )
    {
        if ( !isdefined( self.attackerdamage[ i ] ) || !isdefined( self.attackerdamage[ i ].damage ) )
        {
            continue;
        }
        
        self.attackerdamage[ i ].damage -= decay;
        
        if ( self.attackerdamage[ i ].damage < 0 )
        {
            self.attackerdamage[ i ].damage = 0;
        }
    }
}

// Namespace healthoverlay
// Params 1
// Checksum 0xfa51ed2, Offset: 0xbf8
// Size: 0xca
function player_breathing_sound( healthcap )
{
    self endon( #"end_healthregen" );
    wait 2;
    player = self;
    
    for ( ;; )
    {
        wait 0.2;
        
        if ( player.health <= 0 )
        {
            return;
        }
        
        if ( player.health >= healthcap )
        {
            continue;
        }
        
        if ( level.healthregendisabled && gettime() > player.breathingstoptime )
        {
            continue;
        }
        
        player notify( #"snd_breathing_hurt" );
        wait 0.784;
        wait 0.1 + randomfloat( 0.8 );
    }
}

// Namespace healthoverlay
// Params 1
// Checksum 0x52ce349e, Offset: 0xcd0
// Size: 0x130
function sndhealthlow( healthcap )
{
    self endon( #"end_healthregen" );
    self endon( #"removehealthregen" );
    self.sndhealthlow = 0;
    
    while ( true )
    {
        if ( self.health <= healthcap && !( isdefined( self laststand::player_is_in_laststand() ) && self laststand::player_is_in_laststand() ) )
        {
            self.sndhealthlow = 1;
            self clientfield::set_to_player( "sndHealth", 1 );
            
            while ( self.health <= healthcap )
            {
                wait 0.1;
            }
        }
        
        if ( self.sndhealthlow )
        {
            self.sndhealthlow = 0;
            
            if ( !( isdefined( self laststand::player_is_in_laststand() ) && self laststand::player_is_in_laststand() ) )
            {
                self clientfield::set_to_player( "sndHealth", 0 );
            }
        }
        
        wait 0.1;
    }
}

