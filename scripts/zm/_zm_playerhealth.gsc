#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm_perks;

#namespace zm_playerhealth;

// Namespace zm_playerhealth
// Params 0, eflags: 0x2
// Checksum 0x31e42b91, Offset: 0x2e8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_playerhealth", &__init__, undefined, undefined );
}

// Namespace zm_playerhealth
// Params 0
// Checksum 0x1e9db964, Offset: 0x328
// Size: 0x33c
function __init__()
{
    clientfield::register( "toplayer", "sndZombieHealth", 21000, 1, "int" );
    level.global_damage_func_ads = &empty_kill_func;
    level.global_damage_func = &empty_kill_func;
    level.difficultytype[ 0 ] = "easy";
    level.difficultytype[ 1 ] = "normal";
    level.difficultytype[ 2 ] = "hardened";
    level.difficultytype[ 3 ] = "veteran";
    level.difficultystring[ "easy" ] = &"GAMESKILL_EASY";
    level.difficultystring[ "normal" ] = &"GAMESKILL_NORMAL";
    level.difficultystring[ "hardened" ] = &"GAMESKILL_HARDENED";
    level.difficultystring[ "veteran" ] = &"GAMESKILL_VETERAN";
    
    /#
        thread playerhealthdebug();
    #/
    
    level.gameskill = 1;
    
    switch ( level.gameskill )
    {
        case 0:
            setdvar( "currentDifficulty", "easy" );
            break;
        case 1:
            setdvar( "currentDifficulty", "normal" );
            break;
        case 2:
            setdvar( "currentDifficulty", "hardened" );
            break;
        case 3:
            setdvar( "currentDifficulty", "veteran" );
            break;
    }
    
    /#
        print( "<dev string:x28>" + level.gameskill );
    #/
    
    level.player_deathinvulnerabletime = 1700;
    level.longregentime = 5000;
    level.healthoverlaycutoff = 0.2;
    level.invultime_preshield = 0.35;
    level.invultime_onshield = 0.5;
    level.invultime_postshield = 0.3;
    level.playerhealth_regularregendelay = 2400;
    level.worthydamageratio = 0.1;
    callback::on_spawned( &on_player_spawned );
    
    if ( !isdefined( level.vsmgr_prio_overlay_zm_player_health_blur ) )
    {
        level.vsmgr_prio_overlay_zm_player_health_blur = 22;
    }
    
    visionset_mgr::register_info( "overlay", "zm_health_blur", 1, level.vsmgr_prio_overlay_zm_player_health_blur, 1, 1, &visionset_mgr::ramp_in_out_thread_per_player, 1 );
}

// Namespace zm_playerhealth
// Params 0
// Checksum 0xc7762652, Offset: 0x670
// Size: 0x44
function on_player_spawned()
{
    self zm_perks::perk_set_max_health_if_jugg( "health_reboot", 1, 0 );
    self notify( #"nohealthoverlay" );
    self thread playerhealthregen();
}

// Namespace zm_playerhealth
// Params 0
// Checksum 0xb14fa474, Offset: 0x6c0
// Size: 0x54
function player_health_visionset()
{
    visionset_mgr::deactivate( "overlay", "zm_health_blur", self );
    visionset_mgr::activate( "overlay", "zm_health_blur", self, 0, 1, 1 );
}

// Namespace zm_playerhealth
// Params 0
// Checksum 0x8af64608, Offset: 0x720
// Size: 0xcc
function playerhurtcheck()
{
    self endon( #"nohealthoverlay" );
    self.hurtagain = 0;
    
    for ( ;; )
    {
        self waittill( #"damage", amount, attacker, dir, point, mod );
        
        if ( isdefined( attacker ) && isplayer( attacker ) && attacker.team == self.team )
        {
            continue;
        }
        
        self.hurtagain = 1;
        self.damagepoint = point;
        self.damageattacker = attacker;
    }
}

// Namespace zm_playerhealth
// Params 0
// Checksum 0x8d589359, Offset: 0x7f8
// Size: 0x730
function playerhealthregen()
{
    self notify( #"playerhealthregen" );
    self endon( #"playerhealthregen" );
    self endon( #"death" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self.flag ) )
    {
        self.flag = [];
        self.flags_lock = [];
    }
    
    if ( !isdefined( self.flag[ "player_has_red_flashing_overlay" ] ) )
    {
        self flag::init( "player_has_red_flashing_overlay" );
        self flag::init( "player_is_invulnerable" );
    }
    
    self flag::clear( "player_has_red_flashing_overlay" );
    self flag::clear( "player_is_invulnerable" );
    self thread healthoverlay();
    oldratio = 1;
    health_add = 0;
    regenrate = 0.1;
    veryhurt = 0;
    playerjustgotredflashing = 0;
    invultime = 0;
    hurttime = 0;
    newhealth = 0;
    lastinvulratio = 1;
    self thread playerhurtcheck();
    
    if ( !isdefined( self.veryhurt ) )
    {
        self.veryhurt = 0;
    }
    
    self.bolthit = 0;
    
    if ( getdvarstring( "scr_playerInvulTimeScale" ) == "" )
    {
        setdvar( "scr_playerInvulTimeScale", 1 );
    }
    
    playerinvultimescale = getdvarfloat( "scr_playerInvulTimeScale" );
    
    for ( ;; )
    {
        wait 0.05;
        waittillframeend();
        
        if ( self.health == self.maxhealth )
        {
            if ( self flag::get( "player_has_red_flashing_overlay" ) )
            {
                self clientfield::set_to_player( "sndZombieHealth", 0 );
                self flag::clear( "player_has_red_flashing_overlay" );
            }
            
            lastinvulratio = 1;
            playerjustgotredflashing = 0;
            veryhurt = 0;
            continue;
        }
        
        if ( self.health <= 0 )
        {
            /#
                showhitlog();
            #/
            
            return;
        }
        
        wasveryhurt = veryhurt;
        health_ratio = self.health / self.maxhealth;
        
        if ( health_ratio <= level.healthoverlaycutoff )
        {
            veryhurt = 1;
            
            if ( !wasveryhurt )
            {
                hurttime = gettime();
                self startfadingblur( 3.6, 2 );
                self clientfield::set_to_player( "sndZombieHealth", 1 );
                self flag::set( "player_has_red_flashing_overlay" );
                playerjustgotredflashing = 1;
            }
        }
        
        if ( self.hurtagain )
        {
            hurttime = gettime();
            self.hurtagain = 0;
        }
        
        if ( health_ratio >= oldratio )
        {
            if ( gettime() - hurttime < level.playerhealth_regularregendelay )
            {
                continue;
            }
            
            if ( veryhurt )
            {
                self.veryhurt = 1;
                newhealth = health_ratio;
                
                if ( gettime() > hurttime + level.longregentime )
                {
                    newhealth += regenrate;
                }
            }
            else
            {
                newhealth = 1;
                self.veryhurt = 0;
            }
            
            if ( newhealth > 1 )
            {
                newhealth = 1;
            }
            
            if ( newhealth <= 0 )
            {
                return;
            }
            
            /#
                if ( newhealth > health_ratio )
                {
                    logregen( newhealth );
                }
            #/
            
            self setnormalhealth( newhealth );
            oldratio = self.health / self.maxhealth;
            continue;
        }
        
        invulworthyhealthdrop = lastinvulratio - health_ratio > level.worthydamageratio;
        
        if ( self.health <= 1 )
        {
            self setnormalhealth( 2 / self.maxhealth );
            invulworthyhealthdrop = 1;
            
            /#
                if ( !isdefined( level.player_deathinvulnerabletimeout ) )
                {
                    level.player_deathinvulnerabletimeout = 0;
                }
                
                if ( level.player_deathinvulnerabletimeout < gettime() )
                {
                    level.player_deathinvulnerabletimeout = gettime() + getdvarint( "<dev string:x35>" );
                }
            #/
        }
        
        oldratio = self.health / self.maxhealth;
        level notify( #"hit_again" );
        health_add = 0;
        hurttime = gettime();
        self startfadingblur( 3, 0.8 );
        
        if ( !invulworthyhealthdrop || playerinvultimescale <= 0 )
        {
            /#
                loghit( self.health, 0 );
            #/
            
            continue;
        }
        
        if ( self flag::get( "player_is_invulnerable" ) )
        {
            continue;
        }
        
        self flag::set( "player_is_invulnerable" );
        level notify( #"player_becoming_invulnerable" );
        
        if ( playerjustgotredflashing )
        {
            invultime = level.invultime_onshield;
            playerjustgotredflashing = 0;
        }
        else if ( veryhurt )
        {
            invultime = level.invultime_postshield;
        }
        else
        {
            invultime = level.invultime_preshield;
        }
        
        invultime *= playerinvultimescale;
        
        /#
            loghit( self.health, invultime );
        #/
        
        lastinvulratio = self.health / self.maxhealth;
        self thread playerinvul( invultime );
    }
}

// Namespace zm_playerhealth
// Params 1
// Checksum 0x7c3c6426, Offset: 0xf30
// Size: 0x6c
function playerinvul( timer )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    if ( timer > 0 )
    {
        /#
            level.playerinvultimeend = gettime() + timer * 1000;
        #/
        
        wait timer;
    }
    
    self flag::clear( "player_is_invulnerable" );
}

// Namespace zm_playerhealth
// Params 0
// Checksum 0x5bb3085f, Offset: 0xfa8
// Size: 0x1e0
function healthoverlay()
{
    self endon( #"disconnect" );
    self endon( #"nohealthoverlay" );
    
    if ( !isdefined( self._health_overlay ) )
    {
        self._health_overlay = newclienthudelem( self );
        self._health_overlay.x = 0;
        self._health_overlay.y = 0;
        self._health_overlay setshader( "overlay_low_health", 640, 480 );
        self._health_overlay.alignx = "left";
        self._health_overlay.aligny = "top";
        self._health_overlay.horzalign = "fullscreen";
        self._health_overlay.vertalign = "fullscreen";
        self._health_overlay.alpha = 0;
    }
    
    overlay = self._health_overlay;
    self thread healthoverlay_remove( overlay );
    self thread watchhideredflashingoverlay( overlay );
    pulsetime = 0.8;
    
    for ( ;; )
    {
        if ( overlay.alpha > 0 )
        {
            overlay fadeovertime( 0.5 );
        }
        
        overlay.alpha = 0;
        self flag::wait_till( "player_has_red_flashing_overlay" );
        self redflashingoverlay( overlay );
    }
}

// Namespace zm_playerhealth
// Params 4
// Checksum 0x7e454e0b, Offset: 0x1190
// Size: 0x240
function fadefunc( overlay, severity, mult, hud_scaleonly )
{
    pulsetime = 0.8;
    scalemin = 0.5;
    fadeintime = pulsetime * 0.1;
    stayfulltime = pulsetime * ( 0.1 + severity * 0.2 );
    fadeouthalftime = pulsetime * ( 0.1 + severity * 0.1 );
    fadeoutfulltime = pulsetime * 0.3;
    remainingtime = pulsetime - fadeintime - stayfulltime - fadeouthalftime - fadeoutfulltime;
    assert( remainingtime >= -0.001 );
    
    if ( remainingtime < 0 )
    {
        remainingtime = 0;
    }
    
    halfalpha = 0.8 + severity * 0.1;
    leastalpha = 0.5 + severity * 0.3;
    overlay fadeovertime( fadeintime );
    overlay.alpha = mult * 1;
    wait fadeintime + stayfulltime;
    overlay fadeovertime( fadeouthalftime );
    overlay.alpha = mult * halfalpha;
    wait fadeouthalftime;
    overlay fadeovertime( fadeoutfulltime );
    overlay.alpha = mult * leastalpha;
    wait fadeoutfulltime;
    wait remainingtime;
}

// Namespace zm_playerhealth
// Params 1
// Checksum 0x58cbcec4, Offset: 0x13d8
// Size: 0xae
function watchhideredflashingoverlay( overlay )
{
    self endon( #"death_or_disconnect" );
    
    while ( isdefined( overlay ) )
    {
        self waittill( #"clear_red_flashing_overlay" );
        self clientfield::set_to_player( "sndZombieHealth", 0 );
        self flag::clear( "player_has_red_flashing_overlay" );
        overlay fadeovertime( 0.05 );
        overlay.alpha = 0;
        self notify( #"hit_again" );
    }
}

// Namespace zm_playerhealth
// Params 1
// Checksum 0xaa59a084, Offset: 0x1490
// Size: 0x24a
function redflashingoverlay( overlay )
{
    self endon( #"hit_again" );
    self endon( #"damage" );
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"clear_red_flashing_overlay" );
    self.stopflashingbadlytime = gettime() + level.longregentime;
    
    if ( !( isdefined( self.is_in_process_of_zombify ) && self.is_in_process_of_zombify ) && !( isdefined( self.is_zombie ) && self.is_zombie ) )
    {
        fadefunc( overlay, 1, 1, 0 );
        
        while ( !( isdefined( self.is_in_process_of_zombify ) && self.is_in_process_of_zombify ) && gettime() < self.stopflashingbadlytime && isalive( self ) && !( isdefined( self.is_zombie ) && self.is_zombie ) )
        {
            fadefunc( overlay, 0.9, 1, 0 );
        }
        
        if ( !( isdefined( self.is_in_process_of_zombify ) && self.is_in_process_of_zombify ) && !( isdefined( self.is_zombie ) && self.is_zombie ) )
        {
            if ( isalive( self ) )
            {
                fadefunc( overlay, 0.65, 0.8, 0 );
            }
            
            fadefunc( overlay, 0, 0.6, 1 );
        }
    }
    
    overlay fadeovertime( 0.5 );
    overlay.alpha = 0;
    self flag::clear( "player_has_red_flashing_overlay" );
    self clientfield::set_to_player( "sndZombieHealth", 0 );
    wait 0.5;
    self notify( #"hit_again" );
}

// Namespace zm_playerhealth
// Params 1
// Checksum 0x15591e96, Offset: 0x16e8
// Size: 0x6c
function healthoverlay_remove( overlay )
{
    self endon( #"disconnect" );
    self util::waittill_any( "noHealthOverlay", "death" );
    overlay fadeovertime( 3.5 );
    overlay.alpha = 0;
}

// Namespace zm_playerhealth
// Params 5
// Checksum 0xb17f6bcb, Offset: 0x1760
// Size: 0x2c
function empty_kill_func( type, loc, point, attacker, amount )
{
    
}

/#

    // Namespace zm_playerhealth
    // Params 2
    // Checksum 0x59f3e9d, Offset: 0x1798
    // Size: 0x18, Type: dev
    function loghit( newhealth, invultime )
    {
        
    }

    // Namespace zm_playerhealth
    // Params 1
    // Checksum 0x1acf3c81, Offset: 0x17b8
    // Size: 0x10, Type: dev
    function logregen( newhealth )
    {
        
    }

    // Namespace zm_playerhealth
    // Params 0
    // Checksum 0x1c49d3a3, Offset: 0x17d0
    // Size: 0x8, Type: dev
    function showhitlog()
    {
        
    }

    // Namespace zm_playerhealth
    // Params 0
    // Checksum 0x13442feb, Offset: 0x17e0
    // Size: 0x110, Type: dev
    function playerhealthdebug()
    {
        if ( getdvarstring( "<dev string:x52>" ) == "<dev string:x63>" )
        {
            setdvar( "<dev string:x52>", "<dev string:x64>" );
        }
        
        waittillframeend();
        
        while ( true )
        {
            while ( true )
            {
                if ( getdvarstring( "<dev string:x52>" ) != "<dev string:x64>" )
                {
                    break;
                }
                
                wait 0.5;
            }
            
            thread printhealthdebug();
            
            while ( true )
            {
                if ( getdvarstring( "<dev string:x52>" ) == "<dev string:x64>" )
                {
                    break;
                }
                
                wait 0.5;
            }
            
            level notify( #"stop_printing_grenade_timers" );
            destroyhealthdebug();
        }
    }

    // Namespace zm_playerhealth
    // Params 0
    // Checksum 0x28e276b8, Offset: 0x18f8
    // Size: 0x66e, Type: dev
    function printhealthdebug()
    {
        level notify( #"stop_printing_health_bars" );
        level endon( #"stop_printing_health_bars" );
        x = 40;
        y = 40;
        level.healthbarhudelems = [];
        level.healthbarkeys[ 0 ] = "<dev string:x66>";
        level.healthbarkeys[ 1 ] = "<dev string:x6d>";
        level.healthbarkeys[ 2 ] = "<dev string:x79>";
        
        if ( !isdefined( level.playerinvultimeend ) )
        {
            level.playerinvultimeend = 0;
        }
        
        if ( !isdefined( level.player_deathinvulnerabletimeout ) )
        {
            level.player_deathinvulnerabletimeout = 0;
        }
        
        for ( i = 0; i < level.healthbarkeys.size ; i++ )
        {
            key = level.healthbarkeys[ i ];
            textelem = newhudelem();
            textelem.x = x;
            textelem.y = y;
            textelem.alignx = "<dev string:x85>";
            textelem.aligny = "<dev string:x8a>";
            textelem.horzalign = "<dev string:x8e>";
            textelem.vertalign = "<dev string:x8e>";
            textelem settext( key );
            bgbar = newhudelem();
            bgbar.x = x + 79;
            bgbar.y = y + 1;
            bgbar.alignx = "<dev string:x85>";
            bgbar.aligny = "<dev string:x8a>";
            bgbar.horzalign = "<dev string:x8e>";
            bgbar.vertalign = "<dev string:x8e>";
            bgbar.maxwidth = 3;
            bgbar setshader( "<dev string:x99>", bgbar.maxwidth, 10 );
            bgbar.color = ( 0.5, 0.5, 0.5 );
            bar = newhudelem();
            bar.x = x + 80;
            bar.y = y + 2;
            bar.alignx = "<dev string:x85>";
            bar.aligny = "<dev string:x8a>";
            bar.horzalign = "<dev string:x8e>";
            bar.vertalign = "<dev string:x8e>";
            bar setshader( "<dev string:x9f>", 1, 8 );
            textelem.bar = bar;
            textelem.bgbar = bgbar;
            textelem.key = key;
            y += 10;
            level.healthbarhudelems[ key ] = textelem;
        }
        
        level flag::wait_till( "<dev string:xa5>" );
        
        while ( true )
        {
            wait 0.05;
            players = getplayers();
            
            for ( i = 0; i < level.healthbarkeys.size && players.size > 0 ; i++ )
            {
                key = level.healthbarkeys[ i ];
                player = players[ 0 ];
                width = 0;
                
                if ( i == 0 )
                {
                    width = player.health / player.maxhealth * 300;
                }
                else if ( i == 1 )
                {
                    width = ( level.playerinvultimeend - gettime() ) / 1000 * 40;
                }
                else if ( i == 2 )
                {
                    width = ( level.player_deathinvulnerabletimeout - gettime() ) / 1000 * 40;
                }
                
                width = int( max( width, 1 ) );
                width = int( min( width, 300 ) );
                bar = level.healthbarhudelems[ key ].bar;
                bar setshader( "<dev string:x9f>", width, 8 );
                bgbar = level.healthbarhudelems[ key ].bgbar;
                
                if ( width + 2 > bgbar.maxwidth )
                {
                    bgbar.maxwidth = width + 2;
                    bgbar setshader( "<dev string:x99>", bgbar.maxwidth, 10 );
                    bgbar.color = ( 0.5, 0.5, 0.5 );
                }
            }
        }
    }

    // Namespace zm_playerhealth
    // Params 0
    // Checksum 0x96689f7b, Offset: 0x1f70
    // Size: 0xce, Type: dev
    function destroyhealthdebug()
    {
        if ( !isdefined( level.healthbarhudelems ) )
        {
            return;
        }
        
        for ( i = 0; i < level.healthbarkeys.size ; i++ )
        {
            level.healthbarhudelems[ level.healthbarkeys[ i ] ].bgbar destroy();
            level.healthbarhudelems[ level.healthbarkeys[ i ] ].bar destroy();
            level.healthbarhudelems[ level.healthbarkeys[ i ] ] destroy();
        }
    }

#/
