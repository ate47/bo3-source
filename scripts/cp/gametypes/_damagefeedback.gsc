#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace damagefeedback;

// Namespace damagefeedback
// Params 0, eflags: 0x2
// Checksum 0x33bed38c, Offset: 0x218
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "damagefeedback", &__init__, undefined, undefined );
}

// Namespace damagefeedback
// Params 0
// Checksum 0x84de7fec, Offset: 0x258
// Size: 0x44
function __init__()
{
    callback::on_start_gametype( &init );
    callback::on_connect( &on_player_connect );
}

// Namespace damagefeedback
// Params 0
// Checksum 0x99ec1590, Offset: 0x2a8
// Size: 0x4
function init()
{
    
}

// Namespace damagefeedback
// Params 0
// Checksum 0xe54991a1, Offset: 0x2b8
// Size: 0xd8
function on_player_connect()
{
    self.hud_damagefeedback = newdamageindicatorhudelem( self );
    self.hud_damagefeedback.horzalign = "center";
    self.hud_damagefeedback.vertalign = "middle";
    self.hud_damagefeedback.x = -12;
    self.hud_damagefeedback.y = -12;
    self.hud_damagefeedback.alpha = 0;
    self.hud_damagefeedback.archived = 1;
    self.hud_damagefeedback setshader( "damage_feedback", 24, 48 );
    self.hitsoundtracker = 1;
}

// Namespace damagefeedback
// Params 1
// Checksum 0xb9b79e31, Offset: 0x398
// Size: 0x28, Type: bool
function should_play_sound( mod )
{
    if ( !isdefined( mod ) )
    {
        return false;
    }
    
    switch ( mod )
    {
        case "MOD_CRUSH":
        case "MOD_GRENADE_SPLASH":
        case "MOD_HIT_BY_OBJECT":
        case "MOD_MELEE":
        case "MOD_MELEE_ASSASSINATE":
        default:
            return false;
    }
}

// Namespace damagefeedback
// Params 3
// Checksum 0x8fd6a397, Offset: 0x408
// Size: 0x260
function update( mod, inflictor, perkfeedback )
{
    if ( !isplayer( self ) || sessionmodeiszombiesgame() )
    {
        return;
    }
    
    if ( should_play_sound( mod ) )
    {
        if ( isdefined( inflictor ) && isdefined( inflictor.soundmod ) )
        {
            switch ( inflictor.soundmod )
            {
                case "player":
                    self playlocalsound( "mpl_hit_alert" );
                    break;
                case "heli":
                    self thread play_hit_sound( mod, "mpl_hit_alert_air" );
                    break;
                case "hpm":
                    self thread play_hit_sound( mod, "mpl_hit_alert_hpm" );
                    break;
                case "taser_spike":
                    self thread play_hit_sound( mod, "mpl_hit_alert_taser_spike" );
                    break;
                case "dog":
                case "straferun":
                    break;
                case "default_loud":
                    self thread play_hit_sound( mod, "mpl_hit_heli_gunner" );
                    break;
                default:
                    self thread play_hit_sound( mod, "mpl_hit_alert_low" );
                    break;
            }
        }
        else
        {
            self playlocalsound( "mpl_hit_alert_low" );
        }
    }
    
    if ( isdefined( perkfeedback ) )
    {
    }
    else
    {
        self.hud_damagefeedback setshader( "damage_feedback", 24, 48 );
    }
    
    self.hud_damagefeedback.alpha = 1;
    self.hud_damagefeedback fadeovertime( 1 );
    self.hud_damagefeedback.alpha = 0;
}

// Namespace damagefeedback
// Params 2
// Checksum 0x83d2869b, Offset: 0x670
// Size: 0x60
function play_hit_sound( mod, alert )
{
    self endon( #"disconnect" );
    
    if ( self.hitsoundtracker )
    {
        self.hitsoundtracker = 0;
        self playlocalsound( alert );
        wait 0.05;
        self.hitsoundtracker = 1;
    }
}

// Namespace damagefeedback
// Params 1
// Checksum 0x67a874e3, Offset: 0x6d8
// Size: 0xea
function update_special( hitent )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( hitent ) )
    {
        return;
    }
    
    if ( !isplayer( hitent ) )
    {
        return;
    }
    
    wait 0.05;
    
    if ( !isdefined( self.directionalhitarray ) )
    {
        self.directionalhitarray = [];
        hitentnum = hitent getentitynumber();
        self.directionalhitarray[ hitentnum ] = 1;
        self thread send_hit_special_event_at_frame_end( hitent );
        return;
    }
    
    hitentnum = hitent getentitynumber();
    self.directionalhitarray[ hitentnum ] = 1;
}

// Namespace damagefeedback
// Params 1
// Checksum 0x4c16db74, Offset: 0x7d0
// Size: 0x17e
function send_hit_special_event_at_frame_end( hitent )
{
    self endon( #"disconnect" );
    waittillframeend();
    enemyshit = 0;
    value = 1;
    entbitarray0 = 0;
    
    for ( i = 0; i < 32 ; i++ )
    {
        if ( isdefined( self.directionalhitarray[ i ] ) && self.directionalhitarray[ i ] != 0 )
        {
            entbitarray0 += value;
            enemyshit++;
        }
        
        value *= 2;
    }
    
    entbitarray1 = 0;
    
    for ( i = 33; i < 64 ; i++ )
    {
        if ( isdefined( self.directionalhitarray[ i ] ) && self.directionalhitarray[ i ] != 0 )
        {
            entbitarray1 += value;
            enemyshit++;
        }
        
        value *= 2;
    }
    
    if ( enemyshit )
    {
        self directionalhitindicator( entbitarray0, entbitarray1 );
    }
    
    self.directionalhitarray = undefined;
    entbitarray0 = 0;
    entbitarray1 = 0;
}

