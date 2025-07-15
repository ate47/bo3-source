#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_core;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_fate;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_gibs;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_shield_pickup;
#using scripts/cp/doa/_doa_tesla_pickup;
#using scripts/cp/doa/_doa_turret_pickup;
#using scripts/cp/doa/_doa_utility;
#using scripts/cp/gametypes/_globallogic_score;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace doa_player_utility;

// Namespace doa_player_utility
// Params 0
// Checksum 0xc5d8942, Offset: 0xb38
// Size: 0x1e4
function playercreate()
{
    self show();
    
    if ( !isdefined( self.entnum ) )
    {
        self.entnum = self getentitynumber();
    }
    
    assert( !isdefined( self.doa ), "<dev string:x28>" );
    level flagsys::wait_till( "doa_init_complete" );
    self setthreatbiasgroup( "players" );
    self setcharacterbodytype( self.entnum, self.entnum );
    self setcharacterbodystyle( 0 );
    self setcharacterhelmetstyle( 0 );
    self.doa = spawnstruct();
    self enablelinkto();
    self thread turnplayershieldon( 0 );
    self thread function_bbb1254c( 1 );
    
    if ( isdefined( level.doa ) && isdefined( level.doa.var_bc9b7c71 ) )
    {
        self thread [[ level.doa.var_bc9b7c71 ]]();
    }
    
    self thread function_7d7a7fde();
    self function_60123d1c();
    self thread function_70339630();
}

// Namespace doa_player_utility
// Params 0
// Checksum 0xc4432f8e, Offset: 0xd28
// Size: 0x58
function function_70339630()
{
    self endon( #"disconnect" );
    
    while ( array::contains( level.activeplayers, self ) == 0 )
    {
        self.ignoreme = 1;
        wait 0.05;
    }
    
    self.ignoreme = 0;
}

// Namespace doa_player_utility
// Params 1
// Checksum 0xf8203008, Offset: 0xd88
// Size: 0x95c
function function_bbb1254c( var_44eb97b0 )
{
    if ( !isdefined( var_44eb97b0 ) )
    {
        var_44eb97b0 = 0;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.doa.multiplier = 1;
    self.doa.var_d55e6679 = 0;
    self.doa.var_5d2140f2 = level.doa.rules.var_a9114441;
    self.doa.var_a3f61a60 = isdefined( self.doa.infps ) && self.doa.infps ? 4 : 0;
    self.doa.default_movespeed = 1;
    self.doa.weapontime = 0;
    self.doa.var_91c268dc = 0;
    self.doa.weaponlevel = 0;
    self.doa.var_c2b9d7d0 = 0;
    
    if ( !( isdefined( self.doa.infps ) && self.doa.infps ) )
    {
        self.topdowncamera = 1;
    }
    
    self.ignoreme = 0;
    self.doa.respawning = 0;
    self.doa.var_b08ad9f8 = [];
    self thread doa_fx::turnofffx( "reviveAdvertise" );
    self thread doa_fx::turnofffx( "reviveActive" );
    self thread doa_fx::turnofffx( "down_marker_" + function_ee495f41( self.entnum ) );
    self thread doa_fx::turnofffx( "stunbear" );
    self thread doa_fx::turnofffx( "stunbear_fade" );
    self thread doa_fx::turnofffx( "slow_feet" );
    self thread doa_fx::turnofffx( "web_contact" );
    
    if ( var_44eb97b0 )
    {
        self.headshots = 0;
        self.downs = 0;
        self.revives = 0;
        self.score = 0;
        self.assists = 0;
        self.kills = 0;
        self.deaths = 0;
        self.chickens = 0;
        self.gems = 0;
        self.skulls = 0;
        self.doa.var_e1956fd2 = 0;
        self.doa.score = 0;
        self.doa.var_db3637c0 = 0;
        self.doa.kills = 0;
        self.doa.redinsWins = 0;
        self.doa.chickensTamed = 0;
        self.doa.cowsExploded = 0;
        self.doa.goldenCowsExploded = 0;
        self.doa.silverbackKills = 0;
        self.doa.skulls = 0;
        self.doa.gems = 0;
        self.doa.silverbackKillsRound = 0;
        self.doa.var_fda5a6e5 = 0;
        self.doa.var_6946711f = 0;
        self.doa.var_67cd9d65 = 0;
        self.doa.var_bfe4f859 = 0;
        self.doa.var_faf30682 = 0;
        self.doa.fate = 0;
        self.doa.bombs = level.doa.rules.var_812a15ac;
        self.doa.boosters = level.doa.rules.var_ec21c11e;
        self.doa.lives = level.doa.rules.var_1a69346e;
        self.doa.default_weap = getweapon( level.doa.rules.default_weapon );
        self.doa.var_295df6ca = level.doa.rules.var_61b88ecb;
        self.doa.lightstate = 1;
        self.doa.var_c5fe2763 = undefined;
        self.doa.var_80ffe475 = undefined;
        self.doa.guardians = [];
        self notify( #"hash_44eb97b0" );
        wait 0.05;
        
        if ( isdefined( self.doa.var_3cdd8203 ) )
        {
            foreach ( chicken in self.doa.var_3cdd8203 )
            {
                if ( isdefined( chicken.bird ) )
                {
                    chicken.bird delete();
                }
                
                chicken delete();
            }
            
            self.doa.var_3cdd8203 = [];
        }
        
        self thread playerLeaderboardUploader();
    }
    
    if ( isdefined( self.doa.var_480b6280 ) && ( self.doa.fate == 4 || self.doa.fate == 13 || self.doa.var_480b6280 ) )
    {
        self.doa.default_movespeed = level.doa.rules.var_b92b82b;
    }
    
    self.doa.var_7c1bcaf3 = 0;
    
    if ( self.doa.fate == 2 )
    {
        self.doa.var_7c1bcaf3 = 1;
    }
    else if ( self.doa.fate == 11 )
    {
        self.doa.var_7c1bcaf3 = 2;
    }
    
    self setmovespeedscale( self.doa.default_movespeed );
    self function_aea40863();
    self thread function_4eabae51();
    self thread function_ab0e2cf3();
    self thread function_73d40751();
    self thread function_f19e9b07();
    self thread infiniteammo();
    self thread function_60123d1c();
    self thread function_7d7a7fde();
    self thread function_d7c57981();
    self thread function_e6b2517f();
    self thread function_a36ffe73();
    self thread function_2fee362e();
    
    /#
    #/
    
    self setplayercollision( 1 );
    self cleardamageindicator();
    self.health = self.maxhealth;
    self.ignoreme = 0;
    
    if ( isdefined( self.hud_damagefeedback ) )
    {
        self.hud_damagefeedback destroy();
        self.hud_damagefeedback = undefined;
    }
    
    self doa_score::function_850bb47e();
}

// Namespace doa_player_utility
// Params 0
// Checksum 0x4c039e2c, Offset: 0x16f0
// Size: 0xe0
function playerLeaderboardUploader()
{
    self notify( #"playerLeaderboardUploader" );
    self endon( #"playerLeaderboardUploader" );
    self endon( #"disconnect" );
    self.doa.var_a483af0a = 0;
    self.doa.var_b55a8647 = 0;
    
    while ( true )
    {
        self util::waittill_any( "doa_round_is_over", "bossEventComplete", "playerLeaderboardUploader", "disconnect" );
        
        if ( level.doa.round_number >= getdvarint( "scr_doa_min_level_stat_upload", 45 ) )
        {
            self thread doa_core::function_780f83fd( level.doa.round_number );
        }
    }
}

// Namespace doa_player_utility
// Params 0
// Checksum 0xf5b0dcb, Offset: 0x17d8
// Size: 0x38c
function function_eb67e3d2()
{
    while ( true )
    {
        if ( self stancebuttonpressed() )
        {
            stance = 1;
        }
        
        if ( self fragbuttonpressed() )
        {
            frag = 1;
        }
        
        if ( self reloadbuttonpressed() )
        {
            reload = 1;
        }
        
        if ( self secondaryoffhandbuttonpressed() )
        {
            var_6275e96c = 1;
        }
        
        if ( self inventorybuttonpressed() )
        {
            inventory = 1;
        }
        
        if ( self offhandspecialbuttonpressed() )
        {
            var_41f5c788 = 1;
        }
        
        if ( self weaponswitchbuttonpressed() )
        {
            var_ad9943fa = 1;
        }
        
        if ( self vehiclemoveupbuttonpressed() )
        {
            var_affc5722 = 1;
        }
        
        if ( self actionbuttonpressed() )
        {
            action = 1;
        }
        
        if ( self jumpbuttonpressed() )
        {
            jump = 1;
        }
        
        if ( self sprintbuttonpressed() )
        {
            sprint = 1;
        }
        
        if ( self meleebuttonpressed() )
        {
            melee = 1;
        }
        
        if ( self throwbuttonpressed() )
        {
            throw = 1;
        }
        
        if ( self adsbuttonpressed() )
        {
            ads = 1;
        }
        
        if ( self actionslotfourbuttonpressed() )
        {
            action4 = 1;
        }
        
        if ( self actionslotthreebuttonpressed() )
        {
            action3 = 1;
        }
        
        if ( self actionslottwobuttonpressed() )
        {
            action2 = 1;
        }
        
        if ( self actionslotonebuttonpressed() )
        {
            action1 = 1;
        }
        
        if ( self attackbuttonpressed() )
        {
            attack = 1;
        }
        
        if ( self boostbuttonpressed() )
        {
            boost = 1;
        }
        
        if ( self changeseatbuttonpressed() )
        {
            changeseat = 1;
        }
        
        if ( self usebuttonpressed() )
        {
            use = 1;
        }
        
        wait 0.05;
    }
}

// Namespace doa_player_utility
// Params 0
// Checksum 0xac509adb, Offset: 0x1b70
// Size: 0xc4
function function_7e372abd()
{
    self endon( #"disconnect" );
    
    while ( !isdefined( self.doa ) )
    {
        wait 0.05;
    }
    
    if ( isdefined( level.doa.var_e6653624 ) )
    {
        if ( !isinarray( level.doa.var_e6653624, self.name ) )
        {
            level.doa.var_e6653624[ level.doa.var_e6653624.size ] = self.name;
            level.doa.var_a9ba4ffb[ self.name ] = gettime();
        }
    }
    
    self function_ad1d5fcb( 1 );
}

// Namespace doa_player_utility
// Params 0
// Checksum 0x490b4967, Offset: 0x1c40
// Size: 0x92
function function_4db260cb()
{
    foreach ( player in getplayers() )
    {
        player thread function_7e372abd();
    }
}

// Namespace doa_player_utility
// Params 2
// Checksum 0x1e77cc42, Offset: 0x1ce0
// Size: 0x136
function function_895845f9( origin, ignore_player )
{
    valid_player_found = 0;
    players = getplayers();
    
    if ( isdefined( ignore_player ) )
    {
        for ( i = 0; i < ignore_player.size ; i++ )
        {
            if ( isdefined( ignore_player[ i ] ) )
            {
                players = arrayremovevalue( players, ignore_player[ i ] );
            }
        }
    }
    
    while ( !valid_player_found )
    {
        player = doa_utility::getclosestto( origin, players );
        
        if ( !isdefined( player ) )
        {
            return undefined;
        }
        
        if ( !isplayervalid( player, 1 ) )
        {
            players = arrayremovevalue( players, player );
            continue;
        }
        
        return player;
    }
}

// Namespace doa_player_utility
// Params 2
// Checksum 0xfa70a96c, Offset: 0x1e20
// Size: 0xa4, Type: bool
function isplayervalid( player, checkignoremeflag )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( !isalive( player ) )
    {
        return false;
    }
    
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    if ( player.sessionstate == "spectator" )
    {
        return false;
    }
    
    if ( player.sessionstate == "intermission" )
    {
        return false;
    }
    
    return true;
}

// Namespace doa_player_utility
// Params 1
// Checksum 0x977768b5, Offset: 0x1ed0
// Size: 0xfc
function function_5bcae97c( trigger )
{
    trigger thread doa_utility::function_a625b5d3( self );
    trigger thread doa_utility::function_75e76155( self, "enter_vehicle" );
    trigger thread doa_utility::function_75e76155( self, "turnPlayerShieldOn" );
    trigger thread doa_utility::function_75e76155( self, "turnPlayerShieldOff" );
    trigger waittill( #"death" );
    
    if ( isdefined( self ) )
    {
        self function_4519b17( 0 );
        self.doa.shield_is_on = undefined;
        self thread doa_fx::turnofffx( "player_shield_short" );
        self thread doa_fx::turnofffx( "player_shield_long" );
    }
}

// Namespace doa_player_utility
// Params 1
// Checksum 0x2330a284, Offset: 0x1fd8
// Size: 0x2e2
function turnplayershieldon( short_shield )
{
    if ( !isdefined( short_shield ) )
    {
        short_shield = 1;
    }
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    self endon( #"enter_vehicle" );
    self notify( #"turnplayershieldon" );
    self endon( #"turnplayershieldon" );
    
    if ( !isdefined( self.doa ) || isdefined( self.doa.vehicle ) )
    {
        return;
    }
    
    if ( isdefined( self.doa.shield_is_on ) )
    {
        self notify( #"turnplayershieldoff" );
        waittillframeend();
    }
    else if ( short_shield )
    {
        self thread doa_sound::function_90118d8c( "zmb_player_shield_half" );
    }
    else if ( mayspawnentity() )
    {
        self playsound( "zmb_player_shield_full" );
    }
    
    self function_4519b17( 1 );
    
    if ( mayspawnfakeentity() )
    {
        trigger = spawn( "trigger_radius", self.origin, 17, 50, 50 );
        trigger.targetname = "turnPlayerShieldOn";
        self.doa.shield_is_on = trigger;
        trigger enablelinkto();
        trigger linkto( self );
        trigger thread shield_trigger_think( self );
        self thread function_5bcae97c( trigger );
        trigger thread doa_utility::function_1bd67aef( 9.85 );
        util::wait_network_frame();
    }
    
    if ( short_shield )
    {
        self thread doa_fx::function_285a2999( "player_shield_short" );
    }
    else
    {
        self thread doa_fx::function_285a2999( "player_shield_long" );
        wait 6;
    }
    
    self thread doa_sound::function_90118d8c( "zmb_player_shield_half" );
    wait 3;
    self thread doa_sound::function_90118d8c( "zmb_player_shield_end" );
    wait 0.5;
    self function_4519b17( 0 );
    self notify( #"turnplayershieldoff" );
}

// Namespace doa_player_utility
// Params 0, eflags: 0x4
// Checksum 0x88f5327a, Offset: 0x22c8
// Size: 0x24
function private function_6b0da7ff()
{
    self endon( #"death" );
    
    while ( true )
    {
        wait 0.05;
    }
}

// Namespace doa_player_utility
// Params 3
// Checksum 0xff7d0680, Offset: 0x22f8
// Size: 0x4ac
function shield_trigger_think( player, var_c1ff53d9, thresh )
{
    self endon( #"death" );
    self thread function_6b0da7ff();
    self thread function_ab9cf24b( player );
    self.player = player;
    
    while ( isdefined( player ) )
    {
        self waittill( #"trigger", guy );
        
        if ( !isdefined( guy ) )
        {
            continue;
        }
        
        if ( isplayer( guy ) )
        {
            continue;
        }
        
        if ( isdefined( guy.launched ) )
        {
            continue;
        }
        
        if ( !issentient( guy ) )
        {
            continue;
        }
        
        if ( !( isdefined( guy.takedamage ) && guy.takedamage ) )
        {
            continue;
        }
        
        if ( isdefined( guy.boss ) && guy.boss )
        {
            continue;
        }
        
        if ( guy.team == player.team )
        {
            continue;
        }
        
        ok = 1;
        
        if ( isdefined( var_c1ff53d9 ) )
        {
            v_velocity = var_c1ff53d9 getvelocity();
            speed = lengthsquared( v_velocity );
            
            /#
            #/
            
            ok = speed < thresh * thresh;
        }
        
        if ( !ok )
        {
            continue;
        }
        
        guy setplayercollision( 0 );
        
        if ( !isvehicle( guy ) )
        {
            if ( !( isdefined( guy.no_ragdoll ) && guy.no_ragdoll ) )
            {
                guy.launched = 1;
                
                if ( randomint( 100 ) < getdvarint( "scr_doa_ragdoll_toss_up_chance", 25 ) )
                {
                    velocity = function_93739933( player getvelocity() );
                    
                    if ( velocity > 30 && !( isdefined( guy.var_ad61c13d ) && guy.var_ad61c13d ) )
                    {
                        guy clientfield::set( "zombie_rhino_explosion", 1 );
                        doa_gib::trygibbinglimb( guy, 5000 );
                        doa_gib::trygibbinglegs( guy, 5000, undefined, 1, player );
                    }
                    
                    assert( !( isdefined( guy.boss ) && guy.boss ) );
                    guy thread doa_utility::function_e3c30240( ( 0, 0, 220 ), 100, 0.3 );
                    guy thread doa_utility::function_ba30b321( 0.2, player );
                    guy thread doa_sound::function_90118d8c( "zmb_ragdoll_launched" );
                }
                else
                {
                    guy dodamage( guy.health, player.origin, player, player, "none", "MOD_EXPLOSIVE" );
                }
            }
            else
            {
                guy dodamage( guy.health, player.origin, player, player, "none", "MOD_EXPLOSIVE" );
            }
            
            continue;
        }
        
        guy thread doa_utility::function_ba30b321( 0, player );
    }
    
    self delete();
}

// Namespace doa_player_utility
// Params 1
// Checksum 0x601f5c8d, Offset: 0x27b0
// Size: 0x2c
function function_93739933( vel )
{
    return length( vel ) * 0.0568182;
}

// Namespace doa_player_utility
// Params 1, eflags: 0x4
// Checksum 0xd1405de7, Offset: 0x27e8
// Size: 0x11c
function private function_ab9cf24b( player )
{
    self endon( #"death" );
    
    if ( !isdefined( level.doa ) || !isdefined( level.doa.hazards ) )
    {
        return;
    }
    
    while ( true )
    {
        foreach ( hazard in level.doa.hazards )
        {
            if ( isdefined( hazard ) && self istouching( hazard ) && isdefined( hazard.death_func ) )
            {
                hazard thread [[ hazard.death_func ]]();
            }
        }
        
        wait 0.1;
    }
}

// Namespace doa_player_utility
// Params 0
// Checksum 0xa95d81a0, Offset: 0x2910
// Size: 0xb2
function infiniteammo()
{
    self notify( #"hash_93c32bc6" );
    self endon( #"hash_93c32bc6" );
    self endon( #"disconnect" );
    wait 1;
    
    while ( true )
    {
        wait 2;
        weaponslist = self getweaponslistprimaries();
        
        for ( idx = 0; idx < weaponslist.size ; idx++ )
        {
            self setweaponammoclip( weaponslist[ idx ], 666 );
        }
    }
}

// Namespace doa_player_utility
// Params 1
// Checksum 0xf81f5b8, Offset: 0x29d0
// Size: 0x1b0
function function_1a86a494( bonusroom )
{
    if ( !isdefined( bonusroom ) )
    {
        bonusroom = 0;
    }
    
    assert( isdefined( self.doa ) );
    
    if ( self.doa.boosters < 1 )
    {
        self.doa.boosters = 1;
    }
    
    if ( self.doa.fate == 4 )
    {
        if ( self.doa.boosters < 2 )
        {
            self.doa.boosters = 2;
        }
    }
    else if ( self.doa.fate == 13 )
    {
        if ( self.doa.boosters < 4 )
        {
            self.doa.boosters = 4;
        }
    }
    else if ( self.doa.fate == 11 )
    {
        if ( !bonusroom && !isdefined( self.doa.var_3df27425 ) )
        {
            self thread doa_shield::magnet_update( 10 );
        }
    }
    else if ( self.doa.fate == 10 )
    {
        if ( self.doa.bombs < 1 )
        {
            self.doa.bombs = 1;
        }
    }
    
    self.health = self.maxhealth;
    self.ignoreme = 0;
}

// Namespace doa_player_utility
// Params 1
// Checksum 0x331b40eb, Offset: 0x2b88
// Size: 0x106
function function_82e3b1cb( bonusroom )
{
    if ( !isdefined( bonusroom ) )
    {
        bonusroom = 0;
    }
    
    players = function_5eb6e4d1();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( isdefined( players[ i ].doa.respawning ) && ( !isalive( players[ i ] ) || players[ i ].doa.respawning ) )
        {
            players[ i ] function_ad1d5fcb();
        }
        
        players[ i ] function_1a86a494( bonusroom );
    }
}

// Namespace doa_player_utility
// Params 0
// Checksum 0xea03d196, Offset: 0x2c98
// Size: 0x16c
function function_aea40863()
{
    self function_d5f89a15( self.doa.default_weap.name );
    self disableweaponcycling();
    self allowjump( 0 );
    self allowcrouch( 0 );
    self allowprone( 0 );
    self allowslide( 0 );
    self allowdoublejump( 0 );
    self allowwallrun( 0 );
    self allowsprint( isdefined( self.doa.infps ) && self.doa.infps );
    self allowads( isdefined( self.doa.infps ) && self.doa.infps );
    self setstance( "stand" );
}

// Namespace doa_player_utility
// Params 1
// Checksum 0x41fbc092, Offset: 0x2e10
// Size: 0xc4
function function_6a52a347( count )
{
    if ( !isdefined( count ) )
    {
        count = 1;
    }
    
    assert( isdefined( self.doa ) );
    max = level.doa.rules.max_lives;
    
    if ( self.doa.fate == 11 )
    {
        max++;
    }
    
    self.doa.lives = doa_utility::clamp( self.doa.lives + count, 0, max );
}

// Namespace doa_player_utility
// Params 1
// Checksum 0xa6753372, Offset: 0x2ee0
// Size: 0xc4
function function_ba145a39( count )
{
    if ( !isdefined( count ) )
    {
        count = 1;
    }
    
    assert( isdefined( self.doa ) );
    max = level.doa.rules.max_bombs;
    
    if ( self.doa.fate == 11 )
    {
        max++;
    }
    
    self.doa.bombs = doa_utility::clamp( self.doa.bombs + count, 0, max );
}

// Namespace doa_player_utility
// Params 1
// Checksum 0x5b18c089, Offset: 0x2fb0
// Size: 0xc4
function function_f3748dcb( count )
{
    if ( !isdefined( count ) )
    {
        count = 1;
    }
    
    assert( isdefined( self.doa ) );
    max = level.doa.rules.var_376b21db;
    
    if ( self.doa.fate == 11 )
    {
        max++;
    }
    
    self.doa.boosters = doa_utility::clamp( self.doa.boosters + count, 0, max );
}

// Namespace doa_player_utility
// Params 0, eflags: 0x4
// Checksum 0xf619789b, Offset: 0x3080
// Size: 0xd4
function private function_3f041ff1()
{
    self endon( #"disconnect" );
    self util::waittill_any( "new_speed_pickup", "player_died", "speed_expired", "disconnect" );
    self thread doa_fx::turnofffx( "boots" );
    self.doa.fast_feet = undefined;
    self setmovespeedscale( self.doa.default_movespeed );
    self thread doa_sound::function_4f06fb8( "zmb_pwup_speed_loop" );
    self thread doa_sound::function_90118d8c( "zmb_pwup_speed_end" );
}

// Namespace doa_player_utility
// Params 0
// Checksum 0x135ecffc, Offset: 0x3160
// Size: 0x166
function function_832d21c2()
{
    self notify( #"new_speed_pickup" );
    self endon( #"new_speed_pickup" );
    self endon( #"disconnect" );
    self thread function_3f041ff1();
    wait 0.05;
    self thread doa_sound::function_90118d8c( "zmb_pwup_speed_loop" );
    self setmovespeedscale( level.doa.rules.var_b92b82b );
    self thread doa_fx::function_285a2999( "boots" );
    self.doa.fast_feet = 1;
    self.doa.slow_feet = undefined;
    timeleft = gettime() + self doa_utility::function_1ded48e6( level.doa.rules.player_speed_time ) * 1000;
    
    while ( isdefined( self.doa.fast_feet ) && self.doa.fast_feet && gettime() < timeleft )
    {
        wait 0.05;
    }
    
    self notify( #"speed_expired" );
}

// Namespace doa_player_utility
// Params 0, eflags: 0x4
// Checksum 0xc5606a64, Offset: 0x32d0
// Size: 0x114
function private function_af5211c2()
{
    self endon( #"disconnect" );
    self util::waittill_any( "new_speed_pickup", "player_died", "speed_expired", "snare_broken", "disconnect" );
    self thread doa_fx::turnofffx( "slow_feet" );
    self thread doa_fx::turnofffx( "web_contact" );
    self thread doa_sound::function_4f06fb8( "zmb_pwup_slow_speed_loop" );
    self thread doa_sound::function_90118d8c( "zmb_pwup_slow_speed_end" );
    self.doa.slow_feet = undefined;
    util::wait_network_frame();
    self setmovespeedscale( self.doa.default_movespeed );
}

// Namespace doa_player_utility
// Params 1
// Checksum 0xc652e9ff, Offset: 0x33f0
// Size: 0x1de
function function_3840375a( speed )
{
    if ( !isdefined( speed ) )
    {
        speed = level.doa.rules.var_ee067ec;
    }
    
    self notify( #"hash_c70bfe29" );
    self endon( #"hash_c70bfe29" );
    self endon( #"disconnect" );
    self thread function_af5211c2();
    wait 0.05;
    self thread doa_sound::function_90118d8c( "zmb_pwup_slow_speed_loop" );
    self setmovespeedscale( speed );
    
    if ( speed == 0 )
    {
        self thread doa_fx::function_285a2999( "web_contact" );
        timeleft = gettime() + level.doa.rules.var_dec839f3 * 1000;
    }
    else if ( speed == level.doa.rules.var_ee067ec )
    {
        self thread doa_fx::function_285a2999( "slow_feet" );
        timeleft = gettime() + level.doa.rules.var_353018d2 * 1000;
    }
    
    self.doa.slow_feet = 1;
    self.doa.fast_feet = undefined;
    
    while ( isdefined( self.doa.slow_feet ) && self.doa.slow_feet && gettime() < timeleft )
    {
        wait 0.05;
    }
    
    self notify( #"speed_expired" );
}

// Namespace doa_player_utility
// Params 0
// Checksum 0xbbeeee01, Offset: 0x35d8
// Size: 0x42
function function_1ba980a()
{
    self endon( #"disconnect" );
    self notify( #"hash_1ba980a" );
    self endon( #"hash_1ba980a" );
    level waittill( #"hash_8817f58" );
    self notify( #"snare_broken" );
}

// Namespace doa_player_utility
// Params 0
// Checksum 0xd1cad194, Offset: 0x3628
// Size: 0x2fe
function function_6e1ed82()
{
    self notify( #"hash_6e1ed82" );
    self endon( #"hash_6e1ed82" );
    self endon( #"speed_expired" );
    self endon( #"disconnect" );
    var_2fa8cbbd = 0;
    samples = [];
    idx = 0;
    self thread function_1ba980a();
    
    while ( !var_2fa8cbbd && isdefined( self ) )
    {
        norm_move = self getnormalizedmovement();
        var_11533e3b = length( norm_move );
        idx = ( idx + 1 ) % 20;
        
        if ( isdefined( var_11533e3b ) && var_11533e3b > 0.5 )
        {
            samples[ idx ] = norm_move;
        }
        else
        {
            samples[ idx ] = ( 0, 0, 0 );
        }
        
        if ( samples.size >= 20 )
        {
            var_70a33bda = 0;
            q1 = 0;
            q2 = 0;
            var_4aa0c171 = 0;
            var_8ad257e = 0;
            
            foreach ( vec in samples )
            {
                if ( vec == ( 0, 0, 0 ) )
                {
                    var_70a33bda++;
                    continue;
                }
                
                if ( vec[ 0 ] > 0 && vec[ 1 ] > 0 )
                {
                    q1++;
                    continue;
                }
                
                if ( vec[ 0 ] > 0 && vec[ 1 ] < 0 )
                {
                    q2++;
                    continue;
                }
                
                if ( vec[ 0 ] < 0 && vec[ 1 ] < 0 )
                {
                    var_4aa0c171++;
                    continue;
                }
                
                var_8ad257e++;
            }
            
            if ( var_70a33bda < 4 )
            {
                if ( q1 >= 2 && q2 >= 2 && var_4aa0c171 >= 2 && var_8ad257e >= 2 )
                {
                    var_2fa8cbbd = 1;
                }
            }
        }
        
        wait 0.05;
    }
    
    self notify( #"snare_broken" );
}

// Namespace doa_player_utility
// Params 0
// Checksum 0x96f72fe3, Offset: 0x3930
// Size: 0x7c
function function_a36ffe73()
{
    self notify( #"hash_a36ffe73" );
    self endon( #"hash_a36ffe73" );
    self waittill( #"hash_89b28ec", attacker );
    self thread function_6e1ed82();
    self thread function_3840375a( 0 );
    self thread function_a36ffe73();
}

// Namespace doa_player_utility
// Params 0
// Checksum 0xac283df2, Offset: 0x39b8
// Size: 0x64
function function_d7c57981()
{
    self notify( #"hash_d7c57981" );
    self endon( #"hash_d7c57981" );
    self waittill( #"hash_9132a424", attacker );
    self thread function_3840375a();
    self thread function_d7c57981();
}

// Namespace doa_player_utility
// Params 0
// Checksum 0xf98ad3e4, Offset: 0x3a28
// Size: 0x8a
function function_e5fa8e6a()
{
    self thread doa_sound::function_90118d8c( "zmb_player_poisoned" );
    self.doa.var_91c268dc = 0;
    self.doa.weaponlevel = 0;
    self function_d5f89a15( self.doa.default_weap.name );
    self notify( #"kill_shield" );
}

// Namespace doa_player_utility
// Params 0
// Checksum 0xd03a2719, Offset: 0x3ac0
// Size: 0x64
function function_e6b2517f()
{
    self notify( #"hash_e6b2517f" );
    self endon( #"hash_e6b2517f" );
    self waittill( #"poisoned", attacker );
    self thread function_e5fa8e6a();
    self thread function_e6b2517f();
}

// Namespace doa_player_utility
// Params 0
// Checksum 0x554e5cea, Offset: 0x3b30
// Size: 0x5c0
function function_ab0e2cf3()
{
    self notify( #"boosterThink" );
    self endon( #"boosterThink" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        wait 0.05;
        
        if ( !isalive( self ) )
        {
            continue;
        }
        
        if ( isdefined( self.var_744a3931 ) )
        {
            continue;
        }
        
        if ( isdefined( level.var_3259f885 ) && level.var_3259f885 )
        {
            continue;
        }
        
        if ( isdefined( self.doa.var_3e3bcaa1 ) && self.doa.var_3e3bcaa1 )
        {
            continue;
        }
        
        if ( !isdefined( self.doa.vehicle ) && ( isdefined( self.doa.var_3be905bb ) && self.doa.var_3be905bb || self fragbuttonpressed() ) )
        {
            self.doa.var_3be905bb = 0;
            
            if ( isdefined( self.doa.boosters ) && self.doa.boosters > 0 )
            {
                self.doa.rhino_deaths = 0;
                self.doa.slow_feet = undefined;
                
                if ( mayspawnentity() )
                {
                    self playsound( "zmb_speed_boost_activate" );
                }
                
                self.doa.boosters--;
                self thread turnplayershieldon();
                curdir = anglestoforward( ( 0, 0, 0 ) );
                
                if ( mayspawnfakeentity() )
                {
                    trigger = spawn( "trigger_radius", self.origin, 1, 85, 50 );
                    trigger.targetname = "triggerBoost1";
                    trigger enablelinkto();
                    trigger linkto( self, "tag_origin", curdir * 200, self.angles );
                    trigger thread shield_trigger_think( self );
                    trigger thread doa_utility::function_a625b5d3( self );
                    trigger thread doa_utility::function_75e76155( self, "boosterThink" );
                    trigger thread doa_utility::function_1bd67aef( 0.6 );
                }
                
                if ( mayspawnfakeentity() )
                {
                    trigger2 = spawn( "trigger_radius", self.origin, 1, 85, 50 );
                    trigger2.targetname = "triggerBoost2";
                    trigger2 enablelinkto();
                    trigger2 linkto( self, "tag_origin", curdir * 50, self.angles );
                    trigger2 thread shield_trigger_think( self );
                    trigger2 thread doa_utility::function_a625b5d3( self );
                    trigger2 thread doa_utility::function_75e76155( self, "boosterThink" );
                    trigger2 thread doa_utility::function_1bd67aef( 0.6 );
                }
                
                curdir = anglestoforward( self.angles );
                endtime = gettime() + 600;
                boost_vector = curdir * 2000;
                boost_vector += ( 0, 0, 200 );
                self setvelocity( boost_vector );
                boost_vector -= ( 0, 0, 200 );
                self playrumbleonentity( "zombietron_booster_rumble" );
                
                if ( isdefined( self.doa.var_480b6280 ) && ( self.doa.fate == 13 || self.doa.var_480b6280 ) )
                {
                    self thread doa_fate::function_3caf8e2( endtime );
                }
                
                while ( gettime() < endtime )
                {
                    self setvelocity( boost_vector );
                    wait 0.05;
                }
                
                if ( self.doa.rhino_deaths >= 20 )
                {
                }
                
                self.doa.rhino_deaths = undefined;
                
                if ( isdefined( trigger ) )
                {
                    trigger delete();
                }
                
                if ( isdefined( trigger2 ) )
                {
                    trigger2 delete();
                }
            }
        }
    }
}

// Namespace doa_player_utility
// Params 0
// Checksum 0x958f24d, Offset: 0x40f8
// Size: 0x94
function function_7d7a7fde()
{
    if ( level.time == self.birthtime || !isdefined( self.doa ) )
    {
        wait 0.05;
    }
    
    if ( !( isdefined( self.doa.infps ) && self.doa.infps ) )
    {
        self clientfield::increment_to_player( "controlBinding" );
        return;
    }
    
    self clientfield::increment_to_player( "goFPS" );
}

// Namespace doa_player_utility
// Params 0, eflags: 0x4
// Checksum 0xbb818606, Offset: 0x4198
// Size: 0x4c
function private function_9fc6e261()
{
    self waittill( #"actor_corpse", corpse );
    wait 0.05;
    
    if ( isdefined( corpse ) )
    {
        corpse clientfield::increment( "burnCorpse" );
    }
}

// Namespace doa_player_utility
// Params 4, eflags: 0x4
// Checksum 0xd237bd29, Offset: 0x41f0
// Size: 0x344
function private function_d392db04( var_adc420e5, origin, player, updir )
{
    self endon( #"death" );
    assert( !( isdefined( self.boss ) && self.boss ) );
    
    if ( !isdefined( level.var_b3050900 ) )
    {
        level.var_b3050900 = 160 * 160;
        level.var_5e8840d3 = 512 * 512;
        level.var_c4dbc378 = 75;
        level.var_619a7a66 = 250;
        level.var_38e68ca7 = 1;
    }
    
    distsq = distancesquared( self.origin, origin );
    var_b3458cba = doa_utility::clamp( distsq / level.var_5e8840d3, 0.1, 1 );
    time = doa_utility::clamp( var_adc420e5 * var_b3458cba, 0.05, var_adc420e5 );
    wait time;
    
    if ( isdefined( self.archetype ) && self.archetype == "robot" )
    {
        self doa_gib::function_7b3e39cb();
    }
    else
    {
        self thread function_9fc6e261();
        
        if ( !( isdefined( self.nofire ) && self.nofire ) && isactor( self ) )
        {
            self clientfield::increment( "burnZombie" );
        }
    }
    
    if ( self.archetype == "zombie" )
    {
        roll = randomint( 100 );
        
        if ( roll < 10 )
        {
            self clientfield::set( "zombie_rhino_explosion", 1 );
            util::wait_network_frame();
        }
        else if ( roll < 40 )
        {
            self clientfield::set( "zombie_gut_explosion", 1 );
            util::wait_network_frame();
        }
        else if ( roll < 70 )
        {
            self clientfield::set( "zombie_saw_explosion", 1 );
            util::wait_network_frame();
        }
    }
    
    self.takedamage = 1;
    self.allowdeath = 1;
    self dodamage( self.health + 1, origin, isdefined( player ) ? player : undefined, undefined, "none", "MOD_EXPLOSIVE" );
}

// Namespace doa_player_utility
// Params 0
// Checksum 0xb510f15d, Offset: 0x4540
// Size: 0xe0
function function_73d40751()
{
    self notify( #"hash_73d40751" );
    self endon( #"hash_73d40751" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        wait 0.05;
        
        if ( self weaponswitchbuttonpressed() )
        {
            if ( !( isdefined( self.doa.var_655cbff1 ) && self.doa.var_655cbff1 ) )
            {
                self clientfield::increment_to_player( "changeCamera" );
                self notify( #"camera_changed" );
                level notify( #"camera_changed", self );
            }
            
            while ( self weaponswitchbuttonpressed() )
            {
                wait 0.05;
            }
        }
    }
}

// Namespace doa_player_utility
// Params 0
// Checksum 0x52d163d8, Offset: 0x4628
// Size: 0xd8
function function_f19e9b07()
{
    self notify( #"hash_f26fb3a4" );
    self endon( #"hash_f26fb3a4" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        wait 0.05;
        
        if ( !isalive( self ) )
        {
            continue;
        }
        
        if ( self stancebuttonpressed() )
        {
            if ( isdefined( self.doa.vehicle ) )
            {
                self notify( #"hash_d28ba89d" );
            }
            else
            {
                self doa_pickups::function_9615d68f();
            }
            
            while ( self stancebuttonpressed() )
            {
                wait 0.05;
            }
        }
    }
}

// Namespace doa_player_utility
// Params 0
// Checksum 0xb376beb9, Offset: 0x4708
// Size: 0x580
function function_4eabae51()
{
    self notify( #"hash_97fb783" );
    self endon( #"hash_97fb783" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        wait 0.05;
        
        if ( !isalive( self ) )
        {
            continue;
        }
        
        if ( isdefined( self.var_744a3931 ) )
        {
            continue;
        }
        
        if ( isdefined( self.doa.var_3024fd0f ) && self.doa.var_3024fd0f )
        {
            continue;
        }
        
        if ( isdefined( level.var_3259f885 ) && level.var_3259f885 )
        {
            continue;
        }
        
        if ( isdefined( self.doa.var_c1de140a ) )
        {
            if ( gettime() < self.doa.var_c1de140a )
            {
                continue;
            }
            else
            {
                self.doa.var_c1de140a = undefined;
            }
        }
        
        if ( isdefined( self.doa.var_f30b49ec ) && self.doa.var_f30b49ec )
        {
            if ( self jumpbuttonpressed() )
            {
                continue;
            }
            else
            {
                self.doa.var_f30b49ec = undefined;
            }
        }
        
        if ( isdefined( self.doa.var_f2870a9e ) && self.doa.var_f2870a9e || self jumpbuttonpressed() )
        {
            self.doa.var_f2870a9e = 0;
            self.doa.var_f30b49ec = 1;
            
            if ( isdefined( self.doa.bombs ) && self.doa.bombs > 0 )
            {
                self.doa.bombs--;
                player_org = self.origin;
                origin = player_org + ( 20, 0, 800 );
                self clientfield::set( "bombDrop", 1 );
                self thread turnplayershieldon();
                doa_utility::clearallcorpses();
                wait 0.4;
                playrumbleonposition( "artillery_rumble", self.origin );
                util::wait_network_frame();
                level notify( #"hash_8817f58" );
                enemies = doa_utility::function_fb2ad2fb();
                camerapos = doa_arena::function_5147636f();
                updir = vectornormalize( camerapos - player_org );
                var_adc420e5 = 0.3;
                
                foreach ( guy in enemies )
                {
                    if ( isdefined( guy ) )
                    {
                        if ( isdefined( guy.boss ) && guy.boss )
                        {
                            guy.nuked = gettime();
                            continue;
                        }
                        
                        if ( isvehicle( guy ) )
                        {
                            guy dodamage( guy.health + 1, player_org, self, self, "none", "MOD_EXPLOSIVE", 0, getweapon( "none" ) );
                        }
                        
                        guy thread function_d392db04( var_adc420e5, player_org, self, updir );
                    }
                }
                
                foreach ( hazard in level.doa.hazards )
                {
                    if ( isdefined( hazard ) && isdefined( hazard.death_func ) )
                    {
                        hazard thread [[ hazard.death_func ]]();
                    }
                }
                
                util::wait_network_frame();
                self clientfield::set( "bombDrop", 0 );
                physicsexplosionsphere( player_org, 1024, 1024, 3 );
            }
        }
    }
}

// Namespace doa_player_utility
// Params 1
// Checksum 0x46a91dc2, Offset: 0x4c90
// Size: 0xd8
function function_350f42fa( weaponpack )
{
    self endon( #"disconnect" );
    self notify( #"hash_42ae3dd7" );
    self endon( #"hash_42ae3dd7" );
    
    while ( true )
    {
        self waittill( #"missile_fire", projectile, weapon );
        
        if ( weapon == level.doa.var_e30c10ec )
        {
            projectile thread function_48b5439d( self );
            projectile thread function_62c5034a( self );
            continue;
        }
        
        if ( weapon == level.doa.var_ccb54987 )
        {
            self thread function_5e373fc6();
        }
    }
}

// Namespace doa_player_utility
// Params 1
// Checksum 0x3e0e03fa, Offset: 0x4d70
// Size: 0x168
function function_62c5034a( owner )
{
    self endon( #"death" );
    owner endon( #"hash_42ae3dd7" );
    owner endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"grenade_bounce", pos, normal, ent, surface );
        physicsexplosionsphere( pos, getdvarint( "scr_doa_secondary_explo_rad", 64 ), getdvarint( "scr_doa_secondary_explo_rad", 64 ), 3 );
        radiusdamage( pos, getdvarint( "scr_doa_secondary_explo_rad", 64 ), getdvarint( "scr_doa_secondary_explo_dmg", 2000 ), getdvarint( "scr_doa_secondary_explo_dmg", 2000 ), owner );
        playfx( level._effect[ "impact_raygun" ], pos );
        wait getdvarfloat( "scr_doa_secondary_firerate_frac", 0.65 );
    }
}

// Namespace doa_player_utility
// Params 1
// Checksum 0xa10a820e, Offset: 0x4ee0
// Size: 0xd8
function function_48b5439d( owner )
{
    self endon( #"death" );
    owner endon( #"hash_42ae3dd7" );
    owner endon( #"disconnect" );
    owner.doa.var_cdd906a9 = 0;
    
    while ( true )
    {
        owner waittill( #"hash_21f7a743", victim );
        time = gettime();
        
        if ( owner.doa.var_cdd906a9 > time )
        {
            continue;
        }
        
        owner.doa.var_cdd906a9 = time;
        level thread doa_tesla::function_395fdfb8( victim, owner );
    }
}

// Namespace doa_player_utility
// Params 1
// Checksum 0xe1658125, Offset: 0x4fc0
// Size: 0x54
function missile_logic( target )
{
    self waittill( #"missile_fire", missile, weap );
    
    if ( isdefined( target ) )
    {
        missile missile_settarget( target );
    }
}

// Namespace doa_player_utility
// Params 0
// Checksum 0x639ce363, Offset: 0x5020
// Size: 0x36c
function function_5e373fc6()
{
    if ( !isdefined( self.doa.var_5af6f9a9 ) )
    {
        self.doa.var_5af6f9a9 = getweapon( "zombietron_rpg_2_secondary" );
    }
    
    enemies = doa_utility::function_fb2ad2fb();
    
    if ( enemies.size == 0 )
    {
        return;
    }
    
    closetargets = arraysortclosest( enemies, self.origin, enemies.size, 0, 4096 );
    fovtargets = [];
    
    foreach ( guy in closetargets )
    {
        if ( isdefined( guy.boss ) && guy.boss )
        {
            continue;
        }
        
        if ( util::within_fov( self.origin, self.angles, guy.origin, 0.8 ) )
        {
            fovtargets[ fovtargets.size ] = guy;
        }
        
        if ( fovtargets.size >= 2 )
        {
            break;
        }
    }
    
    if ( fovtargets.size == 0 )
    {
        return;
    }
    
    target1 = fovtargets[ 0 ];
    target2 = fovtargets.size > 1 ? fovtargets[ 1 ] : fovtargets[ 0 ];
    v_spawn = self gettagorigin( "tag_flash" );
    
    if ( !isdefined( v_spawn ) )
    {
        return;
    }
    
    v_dir = anglestoforward( self.angles );
    self.doa.var_b5d64970 = gettime() + getdvarint( "scr_doa_secondary_firerate", int( getdvarfloat( "scr_doa_secondary_firerate_frac", 0.65 ) * 1000 ) );
    self thread missile_logic( target1 );
    magicbullet( self.doa.var_5af6f9a9, v_spawn, v_spawn + 50 * v_dir, self );
    wait 0.05;
    self thread missile_logic( target2 );
    magicbullet( self.doa.var_5af6f9a9, v_spawn, v_spawn + 50 * v_dir, self );
}

// Namespace doa_player_utility
// Params 1
// Checksum 0x6e6fb973, Offset: 0x5398
// Size: 0x28c
function function_baa7411e( weapon )
{
    self takeallweapons();
    self giveweapon( weapon );
    self switchtoweaponimmediate( weapon );
    self thread turnOnFlashlight( level.doa.arena_round_number == 3 );
    self.doa.var_d898dd8e = weapon;
    self.doa.var_7a1de0da = 0;
    self.doa.var_88842727 = weapon;
    
    if ( weapon == self.doa.default_weap )
    {
        self.doa.var_d898dd8e = undefined;
        
        if ( weapon == level.doa.var_69899304 )
        {
            self.doa.var_d898dd8e = level.doa.var_69899304;
        }
        
        if ( weapon == level.doa.var_416914d0 )
        {
            self.doa.var_d898dd8e = level.doa.var_416914d0;
        }
        
        return;
    }
    
    if ( weapon.type == "gas" )
    {
        self.doa.var_d898dd8e = level.doa.var_e6a7c945;
        return;
    }
    
    if ( weapon.name == "zombietron_launcher" )
    {
        self.doa.var_d898dd8e = level.doa.var_ab5c3535;
        self.doa.var_7a1de0da = -5;
        return;
    }
    
    if ( weapon.name == "zombietron_launcher_1" )
    {
        self.doa.var_d898dd8e = level.doa.var_5706a235;
        self.doa.var_7a1de0da = -5;
        return;
    }
    
    if ( weapon.name == "zombietron_launcher_2" )
    {
        self.doa.var_d898dd8e = level.doa.var_7d091c9e;
        self.doa.var_7a1de0da = -5;
    }
}

// Namespace doa_player_utility
// Params 1
// Checksum 0x84304cbe, Offset: 0x5630
// Size: 0x3ac
function function_71dab8e8( amount )
{
    if ( !isdefined( amount ) )
    {
        amount = 1;
    }
    
    if ( !isdefined( self.doa.weaponpack ) )
    {
        return;
    }
    
    if ( isdefined( self.doa.respawning ) && self.doa.respawning )
    {
        return;
    }
    
    self.doa.var_91c268dc += int( getdvarint( "scr_doa_weapon_increment", 64 ) * amount );
    
    if ( self.doa.var_91c268dc >= getdvarint( "scr_doa_weapon_increment_range", 1024 ) )
    {
        if ( self.doa.weaponlevel < 2 )
        {
            oldlevel = self.doa.weaponlevel;
            self.doa.weaponlevel += int( self.doa.var_91c268dc / getdvarint( "scr_doa_weapon_increment_range", 1024 ) );
            
            if ( self.doa.weaponlevel > 2 )
            {
                self.doa.weaponlevel = 2;
            }
            
            self.doa.var_91c268dc -= ( self.doa.weaponlevel - oldlevel ) * getdvarint( "scr_doa_weapon_increment_range", 1024 );
            graceperiod = gettime() + 2000;
            
            if ( isdefined( self.doa.var_c2b9d7d0 ) && self.doa.var_c2b9d7d0 < graceperiod )
            {
                self.doa.var_c2b9d7d0 = graceperiod;
            }
            
            self function_baa7411e( self.doa.weaponpack[ self.doa.weaponlevel ] );
            
            if ( mayspawnentity() )
            {
                self playsoundtoplayer( "zmb_weapon_upgraded", self );
            }
            
            /#
                doa_utility::debugmsg( "<dev string:x3e>" + self.name + "<dev string:x46>" + self.doa.weaponlevel + "<dev string:x61>" + self.doa.weaponpack[ self.doa.weaponlevel ].name );
            #/
        }
        else
        {
            self.doa.var_91c268dc = getdvarint( "scr_doa_weapon_increment_range", 1024 ) - 1;
        }
    }
    
    self.doa.var_91c268dc = math::clamp( self.doa.var_91c268dc, 0, getdvarint( "scr_doa_weapon_increment_range", 1024 ) - 1 );
}

// Namespace doa_player_utility
// Params 0
// Checksum 0xeda3e95c, Offset: 0x59e8
// Size: 0x4bc
function updateweapon()
{
    if ( !isdefined( self.doa ) || !isdefined( self.doa.var_a2d31b4a ) )
    {
        return;
    }
    
    if ( isdefined( self.doa.var_88842727 ) && self.doa.var_88842727 == level.doa.var_69899304 )
    {
        self.doa.weaponlevel = 2;
        self.doa.var_91c268dc = getdvarint( "scr_doa_weapon_increment_range", 1024 ) - 1;
        return;
    }
    
    if ( gettime() < self.doa.var_c2b9d7d0 )
    {
        return;
    }
    
    if ( self.doa.var_91c268dc > 0 )
    {
        decay = getdvarint( "scr_doa_weapon_increment_decay", 1 ) + self.doa.var_f303ab59;
        self.doa.var_f303ab59 = 0;
        
        if ( self isfiring() )
        {
            decay = int( decay * ( getdvarint( "scr_doa_weapon_increment_decayscale", 5 ) - self.doa.var_7c1bcaf3 ) );
        }
        
        self.doa.var_91c268dc -= decay;
        
        if ( self.doa.var_91c268dc < 0 )
        {
            self.doa.var_91c268dc = 0;
        }
    }
    else if ( self.doa.weaponlevel > 0 )
    {
        self.doa.weaponlevel--;
        self.doa.var_91c268dc = getdvarint( "scr_doa_weapon_increment_range", 1024 ) - 1;
        self function_baa7411e( self.doa.weaponpack[ self.doa.weaponlevel ] );
        self thread turnOnFlashlight( level.doa.arena_round_number == 3 );
        
        /#
            doa_utility::debugmsg( "<dev string:x3e>" + self.name + "<dev string:x68>" + self.doa.weaponlevel + "<dev string:x61>" + self.doa.weaponpack[ self.doa.weaponlevel ].name );
        #/
    }
    
    if ( isdefined( self.doa.var_1b58e8ba ) && self.doa.var_a2d31b4a == self.doa.default_weap.name && self.doa.weaponlevel <= self.doa.var_1b58e8ba )
    {
        self.doa.weaponlevel = self.doa.var_1b58e8ba;
        self.doa.var_91c268dc = getdvarint( "scr_doa_weapon_increment_range", 1024 ) - 1;
        
        if ( isdefined( self.doa.var_88842727 ) && self.doa.var_88842727 != self.doa.weaponpack[ self.doa.weaponlevel ] )
        {
            self function_baa7411e( self.doa.weaponpack[ self.doa.weaponlevel ] );
        }
    }
    
    if ( self.doa.var_91c268dc == 0 && self.doa.weaponlevel == 0 && self.doa.var_a2d31b4a != self.doa.default_weap.name )
    {
        self function_d5f89a15( self.doa.default_weap.name );
    }
}

// Namespace doa_player_utility
// Params 2
// Checksum 0xcbe3cac9, Offset: 0x5eb0
// Size: 0x4c4
function function_d5f89a15( name, weaponpickup )
{
    if ( !isdefined( weaponpickup ) )
    {
        weaponpickup = 0;
    }
    
    if ( !isdefined( self.doa ) )
    {
        return;
    }
    
    if ( isdefined( weaponpickup ) && weaponpickup )
    {
        fill = 1;
        
        if ( isdefined( self.doa.var_a2d31b4a ) && self.doa.var_a2d31b4a == name )
        {
            self function_71dab8e8( getdvarint( "scr_doa_weapon_increment_range", 1024 ) / getdvarint( "scr_doa_weapon_increment", 64 ) );
            return;
        }
    }
    
    if ( isdefined( self.doa.var_a2d31b4a ) && ( !isdefined( self.doa.var_a2d31b4a ) || self.doa.var_a2d31b4a != name ) )
    {
        self.doa.weaponpack = [];
        self.doa.var_a2d31b4a = name;
        self.doa.var_91c268dc = 0;
        self.doa.weaponlevel = 0;
        
        if ( self.doa.fate == 1 || isdefined( self.doa.default_weap ) && name != self.doa.default_weap.name && self.doa.fate == 10 )
        {
            self.doa.weaponlevel = 1;
        }
        
        self.doa.var_c2b9d7d0 = 0;
        self.doa.var_b5d64970 = 0;
        self.doa.var_f303ab59 = 0;
        self takeallweapons();
        var_5f2870f1 = getweapon( name );
        assert( isdefined( var_5f2870f1 ) );
        var_3925f688 = getweapon( name + "_1" );
        var_ab2d65c3 = getweapon( name + "_2" );
        self.doa.weaponpack[ 0 ] = var_5f2870f1;
        self.doa.weaponpack[ 1 ] = var_3925f688 != level.weaponnone ? var_3925f688 : var_5f2870f1;
        self.doa.weaponpack[ 2 ] = var_3925f688 != level.weaponnone ? var_3925f688 : var_ab2d65c3 != level.weaponnone ? var_ab2d65c3 : var_5f2870f1;
        self function_baa7411e( self.doa.weaponpack[ self.doa.weaponlevel ] );
        self thread function_350f42fa( self.doa.var_a2d31b4a );
    }
    else
    {
        self function_baa7411e( self.doa.weaponpack[ self.doa.weaponlevel ] );
    }
    
    if ( isdefined( fill ) && fill )
    {
        self.doa.var_91c268dc = getdvarint( "scr_doa_weapon_increment_range", 1024 ) - 1;
    }
    
    /#
        doa_utility::debugmsg( "<dev string:x3e>" + self.name + "<dev string:x85>" + self.doa.var_a2d31b4a + "<dev string:x99>" + ( isdefined( fill ) && fill ? "<dev string:xa0>" : "<dev string:xa5>" ) );
        self thread function_1318d1e4();
    #/
}

// Namespace doa_player_utility
// Params 0
// Checksum 0x69591697, Offset: 0x6380
// Size: 0x74
function function_1318d1e4()
{
    self notify( #"hash_1318d1e4" );
    self endon( #"hash_1318d1e4" );
    self endon( #"disconnect" );
    self waittill( #"weapon_fired", weapon );
    
    /#
        doa_utility::debugmsg( "<dev string:xab>" + weapon.name );
    #/
}

// Namespace doa_player_utility
// Params 0
// Checksum 0xd908941e, Offset: 0x6400
// Size: 0x34
function function_7f33210a()
{
    if ( !isdefined( self ) || !isdefined( self.doa ) )
    {
        return;
    }
    
    self.doa.lightstate = 0;
}

// Namespace doa_player_utility
// Params 1
// Checksum 0xf73fc282, Offset: 0x6440
// Size: 0x6c
function function_b5843d4f( isnight )
{
    self endon( #"disconnect" );
    
    if ( !isdefined( self ) || !isdefined( self.doa ) )
    {
        return;
    }
    
    if ( isdefined( self.doa.vehicle ) )
    {
        return;
    }
    
    self.doa.lightstate = isnight ? 2 : 1;
}

// Namespace doa_player_utility
// Params 1
// Checksum 0x578398fd, Offset: 0x64b8
// Size: 0x10c
function turnOnFlashlight( on )
{
    if ( !isdefined( on ) )
    {
        on = 1;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self notify( #"turnOnFlashlight" );
    self endon( #"turnOnFlashlight" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self ) || !isdefined( self.doa ) )
    {
        return;
    }
    
    if ( isdefined( self.doa.vehicle ) )
    {
        return;
    }
    
    self util::waittill_any_timeout( 0.25, "weapon_change_complete", "disconnect", "turnOnFlashlight" );
    
    if ( isdefined( self ) && isdefined( self.entnum ) )
    {
        if ( on )
        {
            self thread doa_fx::function_285a2999( "player_flashlight" );
            return;
        }
        
        self thread doa_fx::turnofffx( "player_flashlight" );
    }
}

// Namespace doa_player_utility
// Params 0
// Checksum 0x1262091e, Offset: 0x65d0
// Size: 0xf4
function function_7e85dbee()
{
    var_b427d4ac = self.doa.multiplier;
    
    if ( self.doa.fate == 2 || self.doa.fate == 11 )
    {
        var_b427d4ac--;
    }
    
    if ( var_b427d4ac > 1 )
    {
        var_516eed4b = doa_utility::clamp( int( randomfloatrange( 0.3, 0.5 ) * ( var_b427d4ac - 1 ) * 4 ), 3 );
        level thread doa_pickups::spawnubertreasure( self.origin, var_516eed4b, 85, 1, 1 );
    }
}

// Namespace doa_player_utility
// Params 0
// Checksum 0x48fea903, Offset: 0x66d0
// Size: 0x84
function function_2fee362e()
{
    self endon( #"disconnect" );
    self notify( #"hash_2fee362e" );
    self endon( #"hash_2fee362e" );
    
    while ( !( isdefined( level.hostmigrationtimer ) && level.hostmigrationtimer ) )
    {
        wait 1;
    }
    
    while ( isdefined( level.hostmigrationtimer ) && level.hostmigrationtimer )
    {
        wait 0.05;
    }
    
    self thread turnplayershieldon( 0 );
}

// Namespace doa_player_utility
// Params 9
// Checksum 0x3ca46216, Offset: 0x6760
// Size: 0x40c
function function_3682cfe4( einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    self globallogic_score::incpersstat( "deaths", 1, 1, 1 );
    self thread doa_sound::function_90118d8c( "zmb_player_death" );
    self notify( #"player_died" );
    self freezecontrols( 1 );
    self setplayercollision( 0 );
    self thread function_7e85dbee();
    self.doa.var_91c268dc = 0;
    self.doa.weaponlevel = 0;
    self.doa.var_c2b9d7d0 = 0;
    self.var_5f951816 = gettime();
    self thread doa_score::function_850bb47e();
    self.deaths = math::clamp( self.deaths + 1, 0, 1023 );
    self.dead = 1;
    
    /#
        doa_utility::debugmsg( "<dev string:xb9>" + smeansofdeath + "<dev string:xcb>" + idamage );
        
        if ( isdefined( einflictor ) )
        {
            doa_utility::debugmsg( "<dev string:xd8>" + einflictor getentitynumber() + "<dev string:xf5>" + einflictor.classname + ( isdefined( einflictor.targetname ) ? "<dev string:x104>" + einflictor.targetname : "<dev string:x114>" ) );
        }
        
        if ( isdefined( attacker ) )
        {
            doa_utility::debugmsg( "<dev string:x115>" + attacker getentitynumber() + "<dev string:xf5>" + attacker.classname + ( isdefined( attacker.targetname ) ? "<dev string:x104>" + attacker.targetname : "<dev string:x114>" ) );
        }
    #/
    
    if ( self.doa.lives == 0 )
    {
        players = function_5eb6e4d1();
        count = 0;
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( !isalive( players[ i ] ) && players[ i ].doa.lives == 0 || isdefined( players[ i ].var_744a3931 ) )
            {
                count++;
            }
        }
        
        if ( count == players.size )
        {
            level flag::set( "doa_game_is_over" );
            level notify( #"player_challenge_failure" );
        }
        else
        {
            self thread function_c7471371();
        }
        
        return;
    }
    
    self thread function_161ce9cd();
}

// Namespace doa_player_utility
// Params 0, eflags: 0x4
// Checksum 0xfe014027, Offset: 0x6b78
// Size: 0x4a
function private function_fdf74b3()
{
    self notify( #"new_ignore_attacker" );
    self endon( #"new_ignore_attacker" );
    self endon( #"disconnect" );
    wait level.rules.ignore_enemy_timer;
    self.doa.ignoreattacker = undefined;
}

// Namespace doa_player_utility
// Params 13
// Checksum 0x6649d7b8, Offset: 0x6bd0
// Size: 0x5fc
function function_bfbc53f4( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal )
{
    if ( isdefined( smeansofdeath ) && smeansofdeath == "MOD_FALLING" )
    {
        idamage = 0;
    }
    
    if ( isdefined( self.doa.var_ccf4ef81 ) && isdefined( self.doa ) && self.doa.var_ccf4ef81 )
    {
        idamage = 0;
    }
    
    if ( isdefined( level.hostmigrationtimer ) && level.hostmigrationtimer )
    {
        idamage = 0;
    }
    
    if ( !isdefined( self.doa ) )
    {
        idamage = 0;
    }
    else
    {
        if ( isdefined( self.doa.vehicle ) )
        {
            idamage = 0;
        }
        
        if ( isdefined( self.doa.shield_is_on ) )
        {
            self cleardamageindicator();
            idamage = 0;
        }
        
        if ( idamage && isdefined( eattacker ) )
        {
            if ( isdefined( eattacker.meleedamage ) )
            {
                idamage = eattacker.meleedamage;
            }
            
            if ( eattacker == self )
            {
                idamage = 0;
            }
            
            if ( isdefined( self.doa.ignoreattacker ) && self.doa.ignoreattacker == eattacker )
            {
                idamage = 0;
            }
            
            if ( isdefined( eattacker.owner ) )
            {
                eattacker = eattacker.owner;
            }
            
            if ( eattacker.team == self.team )
            {
                idamage = 0;
            }
            
            if ( eattacker isragdoll() )
            {
                idamage = 0;
                eattacker thread doa_utility::function_ba30b321( 0.1 );
            }
            
            if ( isdefined( eattacker.knocked_out ) && eattacker.knocked_out )
            {
                idamage = 0;
            }
            
            if ( isdefined( self.doa.infps ) && self.doa.infps )
            {
                curtime = gettime();
                
                if ( curtime < self.doa.var_f9deeb49 )
                {
                    idamage = 0;
                }
                
                if ( idamage > self.maxhealth )
                {
                    idamage = self.maxhealth;
                }
                
                if ( !( isdefined( eattacker.boss ) && eattacker.boss ) )
                {
                    idamage = int( idamage * getdvarfloat( "scr_doa_fps_dmg_mod", 0.35 ) );
                }
                
                if ( idamage > 0 )
                {
                    self.doa.var_f9deeb49 = curtime + 1000;
                }
            }
            
            if ( isdefined( eattacker.is_zombie ) && eattacker.is_zombie )
            {
                self.doa.ignoreattacker = eattacker;
                self thread function_fdf74b3();
            }
            
            if ( isdefined( eattacker.var_f4795bf ) && eattacker.var_f4795bf && smeansofdeath == "MOD_PROJECTILE" )
            {
                self notify( #"hash_89b28ec", eattacker );
                idamage = 0;
            }
            else if ( smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_BURNED" || !( isdefined( eattacker.boss ) && eattacker.boss ) && smeansofdeath == "MOD_EXPLOSIVE" )
            {
                self cleardamageindicator();
                idamage = 0;
            }
            
            if ( isdefined( eattacker.custom_damage_func ) )
            {
                idamage = eattacker [[ eattacker.custom_damage_func ]]();
            }
            
            if ( isdefined( eattacker.boss ) && eattacker.boss )
            {
                eattacker.damagedplayer = gettime();
            }
            
            if ( isdefined( eattacker.var_65e0af26 ) && eattacker.var_65e0af26 )
            {
                self notify( #"hash_9132a424", eattacker );
            }
            
            if ( isdefined( eattacker.var_dcdf7239 ) && eattacker.var_dcdf7239 )
            {
                self notify( #"poisoned", eattacker );
            }
        }
    }
    
    self finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal );
}

// Namespace doa_player_utility
// Params 13
// Checksum 0xe4dadbbf, Offset: 0x71d8
// Size: 0xb4
function finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal )
{
    self finishplayerdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal );
}

// Namespace doa_player_utility
// Params 9
// Checksum 0x80dddfe7, Offset: 0x7298
// Size: 0x4c
function playerlaststand( einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    
}

// Namespace doa_player_utility
// Params 9
// Checksum 0x823941b1, Offset: 0x72f0
// Size: 0x4c
function function_f847ee8c( einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    
}

// Namespace doa_player_utility
// Params 1
// Checksum 0xec9e208e, Offset: 0x7348
// Size: 0xa8
function function_68ece679( entnum )
{
    points = level.doa.arenas[ level.doa.current_arena ].player_spawn_points;
    assert( points.size );
    
    if ( isdefined( entnum ) && isdefined( points[ entnum ] ) )
    {
        return points[ entnum ];
    }
    
    return points[ randomint( points.size ) ];
}

// Namespace doa_player_utility
// Params 1, eflags: 0x4
// Checksum 0x78bc9f28, Offset: 0x73f8
// Size: 0xf4
function private function_161ce9cd( delay )
{
    if ( !isdefined( delay ) )
    {
        delay = 2;
    }
    
    self endon( #"disconnect" );
    wait delay;
    
    if ( self.doa.lives < 1 )
    {
        return;
    }
    
    if ( level flag::get( "doa_game_is_over" ) )
    {
        return;
    }
    
    while ( isdefined( level.hostmigrationtimer ) )
    {
        wait 0.05;
    }
    
    self.doa.lives = doa_utility::clamp( self.doa.lives - 1, 0, level.doa.rules.max_lives );
    self notify( #"playerLifeRespawn" );
    self function_ad1d5fcb();
}

// Namespace doa_player_utility
// Params 1, eflags: 0x4
// Checksum 0x2ee44434, Offset: 0x74f8
// Size: 0x382
function private function_ad1d5fcb( var_243f32c0 )
{
    if ( !isdefined( var_243f32c0 ) )
    {
        var_243f32c0 = 0;
    }
    
    self endon( #"disconnect" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    assert( isdefined( self.doa ) );
    self.doa.respawning = 0;
    
    if ( isdefined( self.var_1a898004 ) )
    {
        doa_utility::function_11f3f381( self.var_1a898004, 1 );
        self.var_1a898004 = undefined;
    }
    
    self.var_9ea856f6 = 0;
    self.doa.var_f4a883ed = undefined;
    self disableinvulnerability();
    self show();
    
    if ( !var_243f32c0 && isdefined( self.doa.var_bac6a79 ) )
    {
        switch ( self.doa.var_bac6a79 )
        {
            case "spawn_at_start":
                spot = function_68ece679( self.entnum ).origin;
                break;
            case "spawn_at_safe":
                spot = doa_utility::getclosestto( self.origin, level.doa.arenas[ level.doa.current_arena ].var_1d2ed40 ).origin;
                break;
            default:
                spot = function_68ece679( self.entnum ).origin;
                break;
        }
        
        self.doa.var_bac6a79 = undefined;
    }
    
    self notify( #"doa_respawn_player" );
    self reviveplayer();
    
    if ( !isdefined( spot ) )
    {
        spot = self.origin;
    }
    
    self setorigin( spot );
    
    if ( !var_243f32c0 )
    {
        if ( mayspawnentity() )
        {
            self playsound( "zmb_player_respawn" );
        }
        
        self thread doa_fx::function_285a2999( "player_respawn_" + function_ee495f41( self.entnum ) );
        self thread turnplayershieldon( 0 );
        self thread turnOnFlashlight( level.doa.arena_round_number == 3 );
    }
    
    self thread function_b5843d4f( level.doa.arena_round_number == 3 );
    wait 0.05;
    self thread function_bbb1254c( var_243f32c0 );
    self setplayercollision( 1 );
    self freezecontrols( 0 );
    self.dead = undefined;
    self notify( #"player_respawned" );
}

// Namespace doa_player_utility
// Params 0, eflags: 0x4
// Checksum 0xfcf66629, Offset: 0x7888
// Size: 0xc2
function private function_bbdc9bc0()
{
    self endon( #"disconnect" );
    self endon( #"player_respawned" );
    level endon( #"doa_game_is_over" );
    
    while ( !level flag::get( "doa_game_is_over" ) )
    {
        if ( self.doa.lives > 0 )
        {
            self function_161ce9cd( isdefined( self.doa.var_ec2548a9 ) && self.doa.var_ec2548a9 ? 0 : 2 );
            return;
        }
        
        wait 0.2;
    }
    
    self.doa.respawning = undefined;
}

// Namespace doa_player_utility
// Params 1
// Checksum 0x88c87372, Offset: 0x7958
// Size: 0xf4
function function_1c683070( distsq )
{
    if ( !isdefined( distsq ) )
    {
        distsq = 1296;
    }
    
    count = 0;
    
    foreach ( player in getplayers() )
    {
        if ( player == self )
        {
            continue;
        }
        
        if ( distancesquared( self.origin, player.origin ) <= distsq )
        {
            count++;
        }
    }
    
    return count;
}

// Namespace doa_player_utility
// Params 2
// Checksum 0x7ef1e5b1, Offset: 0x7a58
// Size: 0x3ae
function function_2b1d321f( player, downedplayer )
{
    if ( player == downedplayer )
    {
        return;
    }
    
    downedplayer endon( #"disconnect" );
    player endon( #"disconnect" );
    level endon( #"doa_game_is_over" );
    downedplayer endon( #"player_respawned" );
    
    while ( true )
    {
        wait 0.05;
        
        if ( !isdefined( player.doa ) )
        {
            continue;
        }
        
        distsq = distancesquared( player.origin, downedplayer.origin );
        
        if ( isdefined( player.doa.respawning ) && player.doa.respawning )
        {
            distsq = 9999999;
        }
        
        if ( isdefined( player.doa.vehicle ) )
        {
            distsq = 9999999;
        }
        
        if ( !isalive( player ) )
        {
            distsq = 9999999;
        }
        
        if ( distsq > 48 * 48 )
        {
            found = undefined;
            
            foreach ( savior in downedplayer.doa.var_b08ad9f8 )
            {
                if ( !isdefined( savior.player ) )
                {
                    arrayremovevalue( downedplayer.doa.var_b08ad9f8, savior );
                    break;
                }
                
                if ( savior.player == player )
                {
                    found = savior;
                    break;
                }
            }
            
            if ( isdefined( found ) )
            {
                arrayremovevalue( downedplayer.doa.var_b08ad9f8, found );
            }
            
            continue;
        }
        
        found = undefined;
        
        foreach ( savior in downedplayer.doa.var_b08ad9f8 )
        {
            if ( savior.player == player )
            {
                found = savior;
                break;
            }
        }
        
        if ( !isdefined( found ) )
        {
            savior = spawnstruct();
            savior.player = player;
            savior.timestamp = gettime();
            downedplayer.doa.var_b08ad9f8[ downedplayer.doa.var_b08ad9f8.size ] = savior;
        }
    }
}

// Namespace doa_player_utility
// Params 0
// Checksum 0x474eb54, Offset: 0x7e10
// Size: 0x3e8
function function_b1958e58()
{
    self endon( #"disconnect" );
    level endon( #"doa_game_is_over" );
    self endon( #"player_respawned" );
    self thread function_285fe1ad();
    
    foreach ( player in getplayers() )
    {
        if ( player == self )
        {
            continue;
        }
        
        level thread function_2b1d321f( player, self );
    }
    
    self.doa.var_97c2af1a = 0;
    self.doa.var_70b102c6 = 0;
    self thread doa_fx::turnofffx( "reviveAdvertise" );
    self thread doa_fx::turnofffx( "reviveActive" );
    
    while ( self.var_9ea856f6 > 0 )
    {
        util::wait_network_frame();
        self.doa.var_22d93250 = 0;
        self.doa.var_6ccec7c0 = self.doa.var_b08ad9f8.size;
        curtime = gettime();
        
        foreach ( savior in self.doa.var_b08ad9f8 )
        {
            if ( curtime - savior.timestamp > getdvarint( "scr_doa_playrevive_delay", 250 ) )
            {
                self.doa.var_22d93250++;
            }
        }
        
        if ( self.doa.var_97c2af1a == 0 && self.doa.var_6ccec7c0 > 0 )
        {
            self thread doa_fx::function_285a2999( "reviveAdvertise" );
            self thread doa_fx::turnofffx( "reviveActive" );
        }
        
        if ( self.doa.var_97c2af1a > 0 && self.doa.var_6ccec7c0 == 0 )
        {
            self thread doa_fx::turnofffx( "reviveAdvertise" );
            self thread doa_fx::turnofffx( "reviveActive" );
        }
        
        if ( self.doa.var_22d93250 > 0 && self.doa.var_70b102c6 == 0 )
        {
            self thread doa_fx::turnofffx( "reviveAdvertise" );
            self thread doa_fx::function_285a2999( "reviveActive" );
        }
        
        self.doa.var_97c2af1a = self.doa.var_6ccec7c0;
        self.doa.var_70b102c6 = self.doa.var_22d93250;
    }
}

// Namespace doa_player_utility
// Params 0
// Checksum 0xf03a41e1, Offset: 0x8200
// Size: 0x5c
function function_285fe1ad()
{
    self endon( #"disconnect" );
    level endon( #"doa_game_is_over" );
    self waittill( #"player_respawned" );
    
    if ( mayspawnentity() )
    {
        self playsound( "evt_revived_respawn" );
    }
}

// Namespace doa_player_utility
// Params 0
// Checksum 0x9148932, Offset: 0x8268
// Size: 0x44c
function function_27202201()
{
    self endon( #"disconnect" );
    level endon( #"doa_game_is_over" );
    self endon( #"player_respawned" );
    self.doa.respawning = 1;
    self.var_9ea856f6 = level.doa.rules.var_575e919f;
    
    if ( self.doa.fate == 2 || self.doa.fate == 11 )
    {
        self.var_9ea856f6 -= 10;
    }
    
    self thread function_b1958e58();
    self function_7f33210a();
    self thread doa_fx::function_285a2999( "down_marker_" + function_ee495f41( self.entnum ) );
    
    while ( self.var_9ea856f6 > 0 )
    {
        wait 1;
        self.var_9ea856f6 -= 1;
        
        if ( self.doa.var_22d93250 > 0 )
        {
            amount = int( math::clamp( self.doa.var_22d93250 - 1 + 3, 3, 5 ) );
            
            if ( mayspawnentity() )
            {
                playsoundatposition( "evt_revive", self.origin );
            }
            
            self thread doa_fx::function_285a2999( "reviveCredit" );
            self.var_9ea856f6 -= amount;
            
            foreach ( savior in self.doa.var_b08ad9f8 )
            {
                if ( isdefined( savior.player ) )
                {
                    savior.player.doa.var_faf30682 += 1;
                }
            }
        }
        
        self freezecontrols( 1 );
        players = function_5eb6e4d1();
        count = 0;
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( isdefined( players[ i ].doa.respawning ) && ( !isalive( players[ i ] ) || players[ i ].doa.respawning ) && players[ i ].doa.lives == 0 )
            {
                count++;
            }
        }
        
        if ( count == players.size )
        {
            level flag::set( "doa_game_is_over" );
            level notify( #"player_challenge_failure" );
            self.doa.respawning = 0;
            self.var_9ea856f6 = 0;
            return;
        }
    }
    
    self.doa.respawning = 0;
    self.var_9ea856f6 = 0;
    self function_ad1d5fcb();
}

// Namespace doa_player_utility
// Params 0
// Checksum 0xaa1dc807, Offset: 0x86c0
// Size: 0x230
function function_c7471371()
{
    self endon( #"disconnect" );
    level endon( #"doa_game_is_over" );
    self thread function_bbdc9bc0();
    self thread function_27202201();
    
    while ( self.lives == 0 && !level flag::get( "doa_game_is_over" ) )
    {
        players = function_5eb6e4d1();
        richestplayer = undefined;
        biggestlives = 1;
        
        foreach ( player in players )
        {
            if ( player == self )
            {
                continue;
            }
            
            if ( isdefined( player.var_744a3931 ) )
            {
                continue;
            }
            
            if ( isdefined( player.doa.var_c5fe2763 ) && player.doa.var_c5fe2763 )
            {
                continue;
            }
            
            if ( player.doa.lives > biggestlives )
            {
                biggestlives = player.doa.lives;
                richestplayer = player;
            }
        }
        
        if ( isdefined( self.dead ) && isdefined( richestplayer ) && level flag::get( "doa_round_active" ) && self.dead )
        {
            level thread _stealLifeFrom( richestplayer, self );
            return;
        }
        
        wait 1;
    }
}

// Namespace doa_player_utility
// Params 1, eflags: 0x4
// Checksum 0xac6d5bda, Offset: 0x88f8
// Size: 0x66
function private function_79489c4c( time )
{
    self endon( #"disconnect" );
    level endon( #"doa_game_is_over" );
    self notify( #"hash_79489c4c" );
    self endon( #"hash_79489c4c" );
    self.doa.var_c5fe2763 = 1;
    wait time;
    self.doa.var_c5fe2763 = undefined;
}

// Namespace doa_player_utility
// Params 3, eflags: 0x4
// Checksum 0x8fa9e227, Offset: 0x8968
// Size: 0x210
function private _lifeLink( source, dest, orb )
{
    self endon( #"disconnect" );
    dest endon( #"disconnect" );
    level endon( #"doa_game_is_over" );
    
    if ( !isdefined( orb ) )
    {
        orb = spawn( "script_model", self.origin + ( 0, 0, 50 ) );
        orb.targetname = "_lifeLink";
        orb setmodel( "tag_origin" );
    }
    
    orb thread doa_fx::function_285a2999( "trail_fast" );
    orb thread doa_utility::function_a625b5d3( source );
    orb thread doa_utility::function_a625b5d3( dest );
    orb thread doa_utility::function_75e76155( source, "end_life_link" );
    orb thread doa_utility::function_75e76155( dest, "playerLifeRespawn" );
    orb thread doa_utility::function_783519c1( "doa_game_is_over", 1 );
    orb thread doa_utility::function_1bd67aef( 4 );
    end = dest.origin + ( 0, 0, 50 );
    
    while ( isdefined( orb ) )
    {
        orb moveto( end, 0.2, 0, 0 );
        wait 0.5;
        
        if ( isdefined( orb ) )
        {
            orb.origin = self.origin + ( 0, 0, 50 );
        }
    }
}

// Namespace doa_player_utility
// Params 2, eflags: 0x4
// Checksum 0x9668880e, Offset: 0x8b80
// Size: 0xa9c
function private _stealLifeFrom( source, dest )
{
    self endon( #"disconnect" );
    level endon( #"doa_game_is_over" );
    
    if ( dest.doa.lives > 0 )
    {
        return;
    }
    
    if ( !isdefined( source ) || source.doa.lives < 1 )
    {
        return;
    }
    
    if ( isdefined( source.doa.var_c5fe2763 ) && source.doa.var_c5fe2763 )
    {
        return;
    }
    
    if ( isdefined( dest.doa.var_c5fe2763 ) && dest.doa.var_c5fe2763 )
    {
        return;
    }
    
    source thread function_79489c4c( 60 );
    source thread _lifeLink( source, dest );
    dest thread function_79489c4c( level.doa.rules.var_378eec79 + 5 );
    wait 1;
    origin = source.origin;
    pickup = spawn( "script_model", origin );
    pickup.targetname = "_stealLifeFrom";
    pickup.angles = source.angles;
    pickup setmodel( level.doa.extra_life_model );
    pickup thread doa_fx::function_285a2999( "glow_white" );
    source thread turnplayershieldon( 1 );
    pickup thread doa_utility::function_a625b5d3( source );
    pickup thread doa_utility::function_a625b5d3( dest );
    pickup thread doa_utility::function_75e76155( level, "doa_game_is_over" );
    pickup moveto( dest.origin, 1, 0, 0 );
    pickup thread doa_sound::function_90118d8c( "zmb_pickup_life_shimmer" );
    pickup thread doa_utility::function_1bd67aef( 3 );
    pickup util::waittill_any_timeout( 2, "movedone" );
    source notify( #"end_life_link" );
    pickup delete();
    
    if ( !( isdefined( dest.doa.respawning ) && dest.doa.respawning ) || dest.doa.lives > 0 )
    {
        return;
    }
    
    dest.doa.lives++;
    dest.doa.var_ec2548a9 = 1;
    dest.doa.var_67cd9d65++;
    source.doa.var_bfe4f859++;
    source.doa.lives--;
    
    if ( source.doa.lives < 0 )
    {
        source.doa.lives = 0;
    }
    
    if ( isdefined( source.doa.vehicle ) )
    {
        if ( math::cointoss() )
        {
            /#
                doa_utility::debugmsg( "<dev string:x130>" + source.name );
            #/
            
            level thread doa_pickups::directeditemawardto( source, level.doa.booster_model, 4 );
            return;
        }
        
        /#
            doa_utility::debugmsg( "<dev string:x14a>" + source.name );
        #/
        
        level thread doa_pickups::directeditemawardto( source, level.doa.var_501f85b4, 3 );
        return;
    }
    
    roll = randomint( 100 );
    
    if ( roll < 30 && gettime() > level.doa.var_d2b5415f )
    {
        level.doa.var_d2b5415f = gettime() + 60000;
        
        if ( math::cointoss() )
        {
            /#
                doa_utility::debugmsg( "<dev string:x161>" + source.name );
            #/
            
            source thread doa_sound::function_90118d8c( "zmb_army_skeleton" );
            
            for ( i = 0; i < 10 ; i++ )
            {
                spot = doa_utility::function_14a10231( source.origin );
                level thread doa_pickups::function_411355c0( 30, source, spot );
                wait 0.5;
            }
        }
        else
        {
            /#
                doa_utility::debugmsg( "<dev string:x17b>" + source.name );
            #/
            
            source thread doa_sound::function_90118d8c( "zmb_army_robot" );
            
            for ( i = 0; i < 4 ; i++ )
            {
                spot = doa_utility::function_14a10231( source.origin );
                level thread doa_pickups::function_411355c0( 31, source, spot );
                wait 0.5;
            }
        }
        
        return;
    }
    
    if ( roll < 30 )
    {
        wait 0.4;
        level thread doa_pickups::directeditemawardto( source, level.doa.var_97bbae9c );
        wait 0.4;
        level thread doa_pickups::directeditemawardto( source, level.doa.var_97bbae9c );
        wait 0.4;
        level thread doa_pickups::directeditemawardto( source, level.doa.var_97bbae9c );
        wait 0.4;
        level thread doa_pickups::directeditemawardto( source, level.doa.var_97bbae9c );
        level thread doa_pickups::directeditemawardto( source, level.doa.gloves );
        return;
    }
    
    if ( roll < 40 )
    {
        /#
            doa_utility::debugmsg( "<dev string:x14a>" + source.name );
        #/
        
        level thread doa_pickups::directeditemawardto( source, level.doa.var_501f85b4, 2 );
        return;
    }
    
    if ( roll < 50 )
    {
        /#
            doa_utility::debugmsg( "<dev string:x130>" + source.name );
        #/
        
        level thread doa_pickups::directeditemawardto( source, level.doa.booster_model, 3 );
        return;
    }
    
    if ( roll < 60 )
    {
        /#
            doa_utility::debugmsg( "<dev string:x195>" + source.name );
        #/
        
        level thread doa_pickups::directeditemawardto( source, level.doa.var_3b704a85 );
        return;
    }
    
    if ( roll < 70 )
    {
        /#
            doa_utility::debugmsg( "<dev string:x1ab>" + source.name );
        #/
        
        level thread doa_pickups::directeditemawardto( source, level.doa.var_f21ae3af );
        return;
    }
    
    if ( roll < 80 )
    {
        /#
            doa_utility::debugmsg( "<dev string:x1c5>" + source.name );
        #/
        
        level thread doa_pickups::directeditemawardto( source, level.doa.var_d6256e83 );
        return;
    }
    
    /#
        doa_utility::debugmsg( "<dev string:x1e1>" + source.name );
    #/
    
    level thread doa_pickups::directeditemawardto( source, level.doa.var_8d63e734, 2 );
}

// Namespace doa_player_utility
// Params 0
// Checksum 0x74c826d1, Offset: 0x9628
// Size: 0x1b6
function function_60123d1c()
{
    self notify( #"hash_cca1b1b9" );
    self notify( #"kill_watch_player_in_combat" );
    self notify( #"removehealthregen" );
    self notify( #"nohealthoverlay" );
    self notify( #"killspawnmonitor" );
    self notify( #"killmonitorreloads" );
    self notify( #"killrank" );
    self notify( #"killspawnmonitor" );
    self notify( #"killgrenademonitor" );
    self notify( #"killhurtcheck" );
    self notify( #"killteamchangemonitor" );
    self notify( #"killhackermonitor" );
    self notify( #"killreplaygunmonitor" );
    self notify( #"track_riot_shield" );
    self notify( #"killdtpmonitor" );
    self notify( #"killgameendmonitor" );
    self notify( #"killflashmonitor" );
    self notify( #"killplayedtimemonitor" );
    self notify( #"killplayersprintmonitor" );
    self notify( #"killempmonitor" );
    self notify( #"riotshieldtrackingstart" );
    self notify( #"watch_remove_influencer" );
    self notify( #"killoedmonitor" );
    self notify( #"killmantlemonitor" );
    self notify( #"new_cover_on_death_thread" );
    self notify( #"bolttrackingstart" );
    self notify( #"smoketrackingstart" );
    self notify( #"emptrackingstart" );
    self notify( #"proximitytrackingstart" );
    self notify( #"insertiontrackingstart" );
    self notify( #"grenadetrackingstart" );
    self notify( #"hash_5c6cd2a" );
    self notify( #"killonpainmonitor" );
    self notify( #"killondeathmonitor" );
    self notify( #"end_healthregen" );
    level notify( #"stop_spawn_weight_debug" );
}

// Namespace doa_player_utility
// Params 1
// Checksum 0xd1ead2ac, Offset: 0x97e8
// Size: 0x82
function function_fea7ed75( num )
{
    if ( !isdefined( num ) )
    {
        return ( 1, 1, 1 );
    }
    
    switch ( num )
    {
        case 0:
            return ( 0, 1, 0 );
        case 1:
            return ( 0, 0, 1 );
        case 2:
            return ( 1, 0, 0 );
        case 3:
            return ( 1, 1, 0 );
        default:
            assert( 0 );
            break;
    }
}

// Namespace doa_player_utility
// Params 1
// Checksum 0x94fa2217, Offset: 0x9878
// Size: 0x2c
function function_e7e0aa7f( num )
{
    return "glow_" + function_ee495f41( num );
}

// Namespace doa_player_utility
// Params 1
// Checksum 0x81255fd2, Offset: 0x98b0
// Size: 0x82
function function_ee495f41( num )
{
    switch ( num )
    {
        case 0:
            return "green";
        case 1:
            return "blue";
        case 2:
            return "red";
        case 3:
            return "yellow";
        default:
            assert( 0 );
            break;
    }
}

// Namespace doa_player_utility
// Params 0
// Checksum 0x7f81a97a, Offset: 0x9940
// Size: 0xc4
function function_5eb6e4d1()
{
    players = [];
    
    foreach ( player in getplayers() )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isdefined( player.doa ) )
        {
            players[ players.size ] = player;
        }
    }
    
    return players;
}

// Namespace doa_player_utility
// Params 1
// Checksum 0x4d239e81, Offset: 0x9a10
// Size: 0x19c
function function_35f36dec( origin )
{
    players = function_5eb6e4d1();
    
    if ( players.size == 0 )
    {
        return undefined;
    }
    
    if ( players.size == 1 )
    {
        return players[ 0 ];
    }
    
    bestent = players[ 0 ];
    bestsq = 8192 * 8192;
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) || !isalive( player ) )
        {
            continue;
        }
        
        if ( isdefined( player.ignoreme ) && player.ignoreme )
        {
            continue;
        }
        
        distsq = distancesquared( player.origin, origin );
        
        if ( distsq < bestsq )
        {
            bestent = player;
            bestsq = distsq;
        }
    }
    
    return bestent;
}

// Namespace doa_player_utility
// Params 0
// Checksum 0x21b585b3, Offset: 0x9bb8
// Size: 0x88
function function_f300c612()
{
    self endon( #"disconnect" );
    self notify( #"hash_f300c612" );
    self endon( #"hash_f300c612" );
    
    while ( true )
    {
        wait 0.05;
        
        if ( isdefined( self.doa.var_f4a883ed ) && self.doa.var_f4a883ed )
        {
            doa_dev::drawcylinder( self.origin, 50, 50, 1, ( 1, 0, 0 ) );
        }
    }
}

// Namespace doa_player_utility
// Params 2
// Checksum 0xda029dd7, Offset: 0x9c48
// Size: 0x1c8
function function_4519b17( on, clear )
{
    if ( !isdefined( clear ) )
    {
        clear = 0;
    }
    
    if ( !isdefined( self ) || !isdefined( self.doa ) )
    {
        return;
    }
    
    if ( clear )
    {
        self.doa.var_f4a883ed = undefined;
        self disableinvulnerability();
        self.takedamage = 1;
    }
    
    if ( isdefined( level.doa.var_e5a69065 ) && level.doa.var_e5a69065 )
    {
        self thread function_f300c612();
    }
    
    if ( on )
    {
        if ( !isdefined( self.doa.var_f4a883ed ) )
        {
            self.doa.var_f4a883ed = 1;
            self enableinvulnerability();
            self.takedamage = 0;
        }
        else
        {
            assert( self.doa.var_f4a883ed > 0 );
            self.doa.var_f4a883ed++;
        }
        
        return;
    }
    
    if ( isdefined( self.doa.var_f4a883ed ) )
    {
        self.doa.var_f4a883ed--;
    }
    
    if ( !isdefined( self.doa.var_f4a883ed ) || self.doa.var_f4a883ed == 0 )
    {
        self.doa.var_f4a883ed = undefined;
        self disableinvulnerability();
        self.takedamage = 1;
    }
}

// Namespace doa_player_utility
// Params 1
// Checksum 0x8b35897f, Offset: 0x9e18
// Size: 0x452
function function_139199e1( type )
{
    while ( !level flag::get( "doa_round_active" ) )
    {
        wait 0.05;
    }
    
    if ( !isdefined( type ) )
    {
        if ( randomint( 100 ) > 50 )
        {
            type = "fury";
        }
        else
        {
            type = "force";
        }
    }
    
    if ( self.doa.fate == 10 && type == "fury" )
    {
        type = "force";
    }
    
    if ( self.doa.fate == 13 && type == "force" )
    {
        type = "fury";
    }
    
    level thread doa_utility::function_c5f3ece8( &"DOA_CHALLENGE_VICTOR" );
    wait 3;
    level.doa.var_9b77ca48 = 1;
    
    switch ( type )
    {
        default:
            level thread doa_utility::function_37fb5c23( &"DOA_REWARD_FURY" );
            var_213a57a7 = self.doa.default_weap;
            wait 2;
            level thread doa_fate::directedFate( self, "zombietron_statue_fury", 0.5, &donothing );
            self.doa.default_weap = level.doa.var_69899304;
            self function_d5f89a15( self.doa.default_weap.name );
            
            while ( level flag::get( "doa_round_active" ) )
            {
                wait 0.05;
            }
            
            self.doa.default_weap = var_213a57a7;
            self function_d5f89a15( self.doa.default_weap.name );
            break;
        case "force":
            level thread doa_utility::function_37fb5c23( &"DOA_REWARD_FORCE" );
            wait 1;
            level thread doa_pickups::directeditemawardto( self, level.doa.booster_model, 6 );
            wait 1;
            level thread doa_fate::directedFate( self, "zombietron_statue_force", 0.5, &donothing );
            self.doa.var_480b6280 = 1;
            defaultspeed = self.doa.default_movespeed;
            self.doa.default_movespeed = level.doa.rules.var_b92b82b;
            self setmovespeedscale( self.doa.default_movespeed );
            
            while ( level flag::get( "doa_round_active" ) )
            {
                wait 0.05;
            }
            
            self.doa.var_480b6280 = undefined;
            self.doa.default_movespeed = defaultspeed;
            self setmovespeedscale( self.doa.default_movespeed );
            break;
    }
    
    level thread doa_utility::function_c5f3ece8( &"DOA_REWARD_EXPIRE" );
    wait 2;
    level thread doa_utility::function_37fb5c23( &"DOA_REWARD_EXPIRE2" );
    wait 7;
    level.doa.var_9b77ca48 = undefined;
    level.doa.var_c03fe5f1 = undefined;
}

// Namespace doa_player_utility
// Params 0
// Checksum 0x99ec1590, Offset: 0xa278
// Size: 0x4
function donothing()
{
    
}

