#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_heatseekingmissile;
#using scripts/shared/weapons/_weaponobjects;

#namespace hacker_tool;

// Namespace hacker_tool
// Params 0
// Checksum 0xc0b73156, Offset: 0x380
// Size: 0x13c
function init_shared()
{
    level.weaponhackertool = getweapon( "pda_hack" );
    level.hackertoollostsightlimitms = 1000;
    level.hackertoollockonradius = 25;
    level.hackertoollockonfov = 65;
    level.hackertoolhacktimems = 0.4;
    level.equipmenthackertoolradius = 20;
    level.equipmenthackertooltimems = 100;
    level.carepackagehackertoolradius = 60;
    level.carepackagehackertooltimems = getgametypesetting( "crateCaptureTime" ) * 500;
    level.carepackagefriendlyhackertooltimems = getgametypesetting( "crateCaptureTime" ) * 2000;
    level.carepackageownerhackertooltimems = 250;
    level.vehiclehackertoolradius = 80;
    level.vehiclehackertooltimems = 5000;
    clientfield::register( "toplayer", "hacker_tool", 1, 2, "int" );
    callback::on_spawned( &on_player_spawned );
}

// Namespace hacker_tool
// Params 0
// Checksum 0xb3632ee1, Offset: 0x4c8
// Size: 0x5c
function on_player_spawned()
{
    self endon( #"disconnect" );
    self clearhackertarget( undefined, 0, 1 );
    self thread watchhackertooluse();
    self thread watchhackertoolfired();
}

// Namespace hacker_tool
// Params 3
// Checksum 0x24382585, Offset: 0x530
// Size: 0x244
function clearhackertarget( weapon, successfulhack, spawned )
{
    self notify( #"stop_lockon_sound" );
    self notify( #"stop_locked_sound" );
    self notify( #"clearhackertarget" );
    self.stingerlocksound = undefined;
    self stoprumble( "stinger_lock_rumble" );
    self.hackertoollockstarttime = 0;
    self.hackertoollockstarted = 0;
    self.hackertoollockfinalized = 0;
    self.hackertoollocktimeelapsed = 0;
    
    if ( isdefined( weapon ) )
    {
        if ( weapon.ishacktoolweapon )
        {
            self setweaponhackpercent( weapon, 0 );
        }
        
        if ( isdefined( self.hackertooltarget ) )
        {
            heatseekingmissile::setfriendlyflags( weapon, self.hackertooltarget );
        }
    }
    
    if ( successfulhack == 0 )
    {
        if ( spawned == 0 )
        {
            if ( isdefined( self.hackertooltarget ) )
            {
                self playsoundtoplayer( "evt_hacker_hack_lost", self );
            }
        }
        
        self clientfield::set_to_player( "hacker_tool", 0 );
        self stophackertoolsoundloop();
    }
    
    if ( isdefined( self.hackertooltarget ) )
    {
        heatseekingmissile::targetinghacking( self.hackertooltarget, 0 );
    }
    
    self.hackertooltarget = undefined;
    self weaponlockfree();
    self weaponlocktargettooclose( 0 );
    self weaponlocknoclearance( 0 );
    self stoplocalsound( game[ "locking_on_sound" ] );
    self stoplocalsound( game[ "locked_on_sound" ] );
    self heatseekingmissile::destroylockoncanceledmessage();
}

// Namespace hacker_tool
// Params 0
// Checksum 0xc00149a3, Offset: 0x780
// Size: 0x690
function watchhackertoolfired()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"killhackermonitor" );
    
    while ( true )
    {
        self waittill( #"hacker_tool_fired", hackertooltarget, weapon );
        
        if ( isdefined( hackertooltarget ) )
        {
            if ( isentityhackablecarepackage( hackertooltarget ) )
            {
                scoreevents::givecratecapturemedal( hackertooltarget, self );
                hackertooltarget notify( #"captured", self, 1 );
                
                if ( isdefined( hackertooltarget.owner ) && isplayer( hackertooltarget.owner ) && hackertooltarget.owner.team != self.team && isdefined( level.play_killstreak_hacked_dialog ) )
                {
                    hackertooltarget.owner [[ level.play_killstreak_hacked_dialog ]]( hackertooltarget.killstreaktype, hackertooltarget.killstreakid, self );
                }
            }
            else if ( isentityhackableweaponobject( hackertooltarget ) && isdefined( hackertooltarget.hackertrigger ) )
            {
                hackertooltarget.hackertrigger notify( #"trigger", self, 1 );
                hackertooltarget.previouslyhacked = 1;
                self.throwinggrenade = 0;
            }
            else if ( !isdefined( hackertooltarget.killstreaktimedout ) || isdefined( hackertooltarget.killstreak_hackedcallback ) && hackertooltarget.killstreaktimedout == 0 )
            {
                if ( hackertooltarget.killstreak_hackedprotection == 0 )
                {
                    if ( isdefined( hackertooltarget.owner ) && isplayer( hackertooltarget.owner ) )
                    {
                        if ( isdefined( level.play_killstreak_hacked_dialog ) )
                        {
                            hackertooltarget.owner [[ level.play_killstreak_hacked_dialog ]]( hackertooltarget.killstreaktype, hackertooltarget.killstreakid, self );
                        }
                    }
                    
                    self playsoundtoplayer( "evt_hacker_fw_success", self );
                    hackertooltarget notify( #"killstreak_hacked", self );
                    hackertooltarget.previouslyhacked = 1;
                    hackertooltarget [[ hackertooltarget.killstreak_hackedcallback ]]( self );
                    
                    if ( self util::has_blind_eye_perk_purchased_and_equipped() || self util::has_hacker_perk_purchased_and_equipped() )
                    {
                        self addplayerstat( "hack_streak_with_blindeye_or_engineer", 1 );
                    }
                }
                else
                {
                    if ( isdefined( hackertooltarget.owner ) && isplayer( hackertooltarget.owner ) )
                    {
                        if ( isdefined( level.play_killstreak_firewall_hacked_dialog ) )
                        {
                            self.hackertooltarget.owner [[ level.play_killstreak_firewall_hacked_dialog ]]( self.hackertooltarget.killstreaktype, self.hackertooltarget.killstreakid );
                        }
                    }
                    
                    self playsoundtoplayer( "evt_hacker_ks_success", self );
                    scoreevents::processscoreevent( "hacked_killstreak_protection", self, hackertooltarget, level.weaponhackertool );
                }
                
                hackertooltarget.killstreak_hackedprotection = 0;
            }
            else
            {
                if ( isdefined( hackertooltarget.classname ) && hackertooltarget.classname == "grenade" )
                {
                    damage = 1;
                }
                else if ( isdefined( hackertooltarget.hackertooldamage ) )
                {
                    damage = hackertooltarget.hackertooldamage;
                }
                else if ( isdefined( hackertooltarget.maxhealth ) )
                {
                    damage = hackertooltarget.maxhealth + 1;
                }
                else
                {
                    damage = 999999;
                }
                
                if ( isdefined( hackertooltarget.numflares ) && hackertooltarget.numflares > 0 )
                {
                    damage = 1;
                    hackertooltarget.numflares--;
                    hackertooltarget heatseekingmissile::missiletarget_playflarefx();
                }
                
                hackertooltarget dodamage( damage, self.origin, self, self, 0, "MOD_UNKNOWN", 0, weapon );
            }
            
            if ( self util::is_item_purchased( "pda_hack" ) )
            {
                self addplayerstat( "hack_enemy_target", 1 );
            }
            
            self addweaponstat( weapon, "used", 1 );
        }
        
        clearhackertarget( weapon, 1, 0 );
        self forceoffhandend();
        
        if ( getdvarint( "player_sustainAmmo" ) == 0 )
        {
            clip_ammo = self getweaponammoclip( weapon );
            clip_ammo--;
            assert( clip_ammo >= 0 );
            self setweaponammoclip( weapon, clip_ammo );
        }
        
        self killstreaks::switch_to_last_non_killstreak_weapon();
    }
}

// Namespace hacker_tool
// Params 0
// Checksum 0x4b21a8e6, Offset: 0xe18
// Size: 0x110
function watchhackertooluse()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    
    for ( ;; )
    {
        self waittill( #"grenade_pullback", weapon );
        
        if ( weapon.rootweapon == level.weaponhackertool )
        {
            wait 0.05;
            currentoffhand = self getcurrentoffhand();
            
            if ( self isusingoffhand() && currentoffhand.rootweapon == level.weaponhackertool )
            {
                self thread hackertooltargetloop( weapon );
                self thread watchhackertoolend( weapon );
                self thread watchforgrenadefire( weapon );
                self thread watchhackertoolinterrupt( weapon );
            }
        }
    }
}

// Namespace hacker_tool
// Params 1
// Checksum 0xac2d202d, Offset: 0xf30
// Size: 0xa0
function watchhackertoolinterrupt( weapon )
{
    self endon( #"disconnect" );
    self endon( #"hacker_tool_fired" );
    self endon( #"death" );
    self endon( #"weapon_change" );
    self endon( #"grenade_fire" );
    
    while ( true )
    {
        level waittill( #"use_interrupt", interrupttarget );
        
        if ( self.hackertooltarget == interrupttarget )
        {
            clearhackertarget( weapon, 0, 0 );
        }
        
        wait 0.05;
    }
}

// Namespace hacker_tool
// Params 1
// Checksum 0x3969a75f, Offset: 0xfd8
// Size: 0xb4
function watchhackertoolend( weapon )
{
    self endon( #"disconnect" );
    self endon( #"hacker_tool_fired" );
    msg = self util::waittill_any_return( "weapon_change", "death", "hacker_tool_fired", "disconnect" );
    clearhackertarget( weapon, 0, 0 );
    self clientfield::set_to_player( "hacker_tool", 0 );
    self stophackertoolsoundloop();
}

// Namespace hacker_tool
// Params 1
// Checksum 0x65ebe9f8, Offset: 0x1098
// Size: 0x11c
function watchforgrenadefire( weapon )
{
    self endon( #"disconnect" );
    self endon( #"hacker_tool_fired" );
    self endon( #"weapon_change" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"grenade_fire", grenade_instance, grenade_weapon, respawnfromhack );
        
        if ( isdefined( respawnfromhack ) && respawnfromhack )
        {
            continue;
        }
        
        clearhackertarget( grenade_weapon, 0, 0 );
        clip_ammo = self getweaponammoclip( grenade_weapon );
        clip_max_ammo = grenade_weapon.clipsize;
        
        if ( clip_ammo < clip_max_ammo )
        {
            clip_ammo++;
        }
        
        self setweaponammoclip( grenade_weapon, clip_ammo );
        break;
    }
}

// Namespace hacker_tool
// Params 0
// Checksum 0xd1882420, Offset: 0x11c0
// Size: 0x64
function playhackertoolsoundloop()
{
    if ( isdefined( self.hacker_alreadyhacked ) && ( !isdefined( self.hacker_sound_ent ) || self.hacker_alreadyhacked == 1 ) )
    {
        self playloopsound( "evt_hacker_device_loop" );
        self.hacker_sound_ent = 1;
        self.hacker_alreadyhacked = 0;
    }
}

// Namespace hacker_tool
// Params 0
// Checksum 0x3f039fc7, Offset: 0x1230
// Size: 0x36
function stophackertoolsoundloop()
{
    self stoploopsound( 0.5 );
    self.hacker_sound_ent = undefined;
    self.hacker_alreadyhacked = undefined;
}

// Namespace hacker_tool
// Params 1
// Checksum 0x30b7c789, Offset: 0x1270
// Size: 0x990
function hackertooltargetloop( weapon )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"weapon_change" );
    self endon( #"grenade_fire" );
    self clientfield::set_to_player( "hacker_tool", 1 );
    self playhackertoolsoundloop();
    
    while ( true )
    {
        wait 0.05;
        wait 0.05;
        
        if ( self.hackertoollockfinalized )
        {
            if ( !self isvalidhackertooltarget( self.hackertooltarget, weapon, 0 ) )
            {
                self clearhackertarget( weapon, 0, 0 );
                continue;
            }
            
            passed = self hackersoftsighttest( weapon );
            
            if ( !passed )
            {
                continue;
            }
            
            self clientfield::set_to_player( "hacker_tool", 0 );
            self stophackertoolsoundloop();
            heatseekingmissile::targetinghacking( self.hackertooltarget, 0 );
            heatseekingmissile::setfriendlyflags( weapon, self.hackertooltarget );
            thread heatseekingmissile::looplocallocksound( game[ "locked_on_sound" ], 0.75 );
            self notify( #"hacker_tool_fired", self.hackertooltarget, weapon );
            return;
        }
        
        if ( self.hackertoollockstarted )
        {
            if ( !self isvalidhackertooltarget( self.hackertooltarget, weapon, 0 ) )
            {
                self clearhackertarget( weapon, 0, 0 );
                continue;
            }
            
            lockontime = self getlockontime( self.hackertooltarget, weapon );
            
            if ( lockontime == 0 )
            {
                self clearhackertarget( weapon, 0, 0 );
                continue;
            }
            
            if ( self.hackertoollocktimeelapsed == 0 )
            {
                self playlocalsound( "evt_hacker_hacking" );
                
                if ( isdefined( self.hackertooltarget.owner ) && isplayer( self.hackertooltarget.owner ) )
                {
                    if ( !isdefined( self.hackertooltarget.killstreaktimedout ) || isdefined( self.hackertooltarget.killstreak_hackedcallback ) && self.hackertooltarget.killstreaktimedout == 0 )
                    {
                        if ( self.hackertooltarget.killstreak_hackedprotection == 0 )
                        {
                            if ( isdefined( level.play_killstreak_being_hacked_dialog ) )
                            {
                                self.hackertooltarget.owner [[ level.play_killstreak_being_hacked_dialog ]]( self.hackertooltarget.killstreaktype, self.hackertooltarget.killstreakid );
                            }
                        }
                        else if ( isdefined( level.play_killstreak_firewall_being_hacked_dialog ) )
                        {
                            self.hackertooltarget.owner [[ level.play_killstreak_firewall_being_hacked_dialog ]]( self.hackertooltarget.killstreaktype, self.hackertooltarget.killstreakid );
                        }
                    }
                }
            }
            
            self weaponlockstart( self.hackertooltarget );
            self playhackertoolsoundloop();
            
            if ( isdefined( self.hackertooltarget.killstreak_hackedprotection ) && self.hackertooltarget.killstreak_hackedprotection == 1 )
            {
                self clientfield::set_to_player( "hacker_tool", 3 );
            }
            else
            {
                self clientfield::set_to_player( "hacker_tool", 2 );
            }
            
            heatseekingmissile::targetinghacking( self.hackertooltarget, 1 );
            heatseekingmissile::setfriendlyflags( weapon, self.hackertooltarget );
            passed = self hackersoftsighttest( weapon );
            
            if ( !passed )
            {
                continue;
            }
            
            if ( self.hackertoollostsightlinetime == 0 )
            {
                self.hackertoollocktimeelapsed += 0.1 * hackingtimescale( self.hackertooltarget );
                hackpercentage = self.hackertoollocktimeelapsed / lockontime * 100;
                self setweaponhackpercent( weapon, hackpercentage );
                heatseekingmissile::setfriendlyflags( weapon, self.hackertooltarget );
            }
            else
            {
                self.hackertoollocktimeelapsed -= 0.1 * hackingtimenolineofsightscale( self.hackertooltarget );
                
                if ( self.hackertoollocktimeelapsed < 0 )
                {
                    self.hackertoollocktimeelapsed = 0;
                    self clearhackertarget( weapon, 0, 0 );
                    continue;
                }
                
                hackpercentage = self.hackertoollocktimeelapsed / lockontime * 100;
                self setweaponhackpercent( weapon, hackpercentage );
                heatseekingmissile::setfriendlyflags( weapon, self.hackertooltarget );
            }
            
            if ( self.hackertoollocktimeelapsed < lockontime )
            {
                continue;
            }
            
            assert( isdefined( self.hackertooltarget ) );
            self notify( #"stop_lockon_sound" );
            self.hackertoollockfinalized = 1;
            self weaponlockfinalize( self.hackertooltarget );
            continue;
        }
        
        if ( self isempjammed() )
        {
            self heatseekingmissile::destroylockoncanceledmessage();
            continue;
        }
        
        besttarget = self getbesthackertooltarget( weapon );
        
        if ( !isdefined( besttarget ) )
        {
            self stophackertoolsoundloop();
            self heatseekingmissile::destroylockoncanceledmessage();
            continue;
        }
        
        if ( !self heatseekingmissile::locksighttest( besttarget ) )
        {
            self stophackertoolsoundloop();
            self heatseekingmissile::destroylockoncanceledmessage();
            continue;
        }
        
        if ( self heatseekingmissile::locksighttest( besttarget ) && isdefined( besttarget.lockondelay ) && besttarget.lockondelay )
        {
            self stophackertoolsoundloop();
            self heatseekingmissile::displaylockoncanceledmessage();
            continue;
        }
        
        self heatseekingmissile::destroylockoncanceledmessage();
        
        if ( isentitypreviouslyhacked( besttarget ) )
        {
            if ( isdefined( self.hacker_alreadyhacked ) && ( !isdefined( self.hacker_sound_ent ) || self.hacker_alreadyhacked == 0 ) )
            {
                self.hacker_sound_ent = 1;
                self.hacker_alreadyhacked = 1;
                self playloopsound( "evt_hacker_unhackable_loop" );
            }
            
            continue;
        }
        else
        {
            self stophackertoolsoundloop();
        }
        
        heatseekingmissile::initlockfield( besttarget );
        self.hackertooltarget = besttarget;
        self thread watchtargetentityupdate( besttarget );
        self.hackertoollockstarttime = gettime();
        self.hackertoollockstarted = 1;
        self.hackertoollostsightlinetime = 0;
        self.hackertoollocktimeelapsed = 0;
        self setweaponhackpercent( weapon, 0 );
        
        if ( isdefined( self.hackertooltarget ) )
        {
            heatseekingmissile::setfriendlyflags( weapon, self.hackertooltarget );
        }
    }
}

// Namespace hacker_tool
// Params 1
// Checksum 0xa9ad2c72, Offset: 0x1c08
// Size: 0x90
function watchtargetentityupdate( besttarget )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self notify( #"watchtargetentityupdate" );
    self endon( #"watchtargetentityupdate" );
    self endon( #"clearhackertarget" );
    besttarget endon( #"death" );
    besttarget waittill( #"hackertool_update_ent", newentity );
    heatseekingmissile::initlockfield( newentity );
    self.hackertooltarget = newentity;
}

// Namespace hacker_tool
// Params 1
// Checksum 0xd5a06b74, Offset: 0x1ca0
// Size: 0x39a
function getbesthackertooltarget( weapon )
{
    targetsvalid = [];
    targetsall = arraycombine( target_getarray(), level.missileentities, 0, 0 );
    targetsall = arraycombine( targetsall, level.hackertooltargets, 0, 0 );
    
    for ( idx = 0; idx < targetsall.size ; idx++ )
    {
        target_ent = targetsall[ idx ];
        
        if ( !isdefined( target_ent ) || !isdefined( target_ent.owner ) )
        {
            continue;
        }
        
        /#
            if ( getdvarstring( "<dev string:x28>" ) == "<dev string:x35>" )
            {
                if ( self iswithinhackertoolreticle( targetsall[ idx ], weapon ) )
                {
                    targetsvalid[ targetsvalid.size ] = targetsall[ idx ];
                }
                
                continue;
            }
        #/
        
        if ( level.teambased || level.use_team_based_logic_for_locking_on === 1 )
        {
            if ( isentityhackablecarepackage( target_ent ) )
            {
                if ( self cantargetentity( target_ent, weapon ) )
                {
                    targetsvalid[ targetsvalid.size ] = target_ent;
                }
            }
            else if ( isdefined( target_ent.team ) )
            {
                if ( target_ent.team != self.team )
                {
                    if ( self cantargetentity( target_ent, weapon ) )
                    {
                        targetsvalid[ targetsvalid.size ] = target_ent;
                    }
                }
            }
            else if ( isdefined( target_ent.owner.team ) )
            {
                if ( target_ent.owner.team != self.team )
                {
                    if ( self cantargetentity( target_ent, weapon ) )
                    {
                        targetsvalid[ targetsvalid.size ] = target_ent;
                    }
                }
            }
            
            continue;
        }
        
        if ( self iswithinhackertoolreticle( target_ent, weapon ) )
        {
            if ( isentityhackablecarepackage( target_ent ) )
            {
                if ( self cantargetentity( target_ent, weapon ) )
                {
                    targetsvalid[ targetsvalid.size ] = target_ent;
                }
                
                continue;
            }
            
            if ( isdefined( target_ent.owner ) && self != target_ent.owner )
            {
                if ( self cantargetentity( target_ent, weapon ) )
                {
                    targetsvalid[ targetsvalid.size ] = target_ent;
                }
            }
        }
    }
    
    chosenent = undefined;
    
    if ( targetsvalid.size != 0 )
    {
        chosenent = targetsvalid[ 0 ];
    }
    
    return chosenent;
}

// Namespace hacker_tool
// Params 2
// Checksum 0x7f0cab, Offset: 0x2048
// Size: 0x66, Type: bool
function cantargetentity( target, weapon )
{
    if ( !self iswithinhackertoolreticle( target, weapon ) )
    {
        return false;
    }
    
    if ( !isvalidhackertooltarget( target, weapon, 1 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace hacker_tool
// Params 2
// Checksum 0xd900a690, Offset: 0x20b8
// Size: 0xba
function iswithinhackertoolreticle( target, weapon )
{
    radiusinner = gethackertoolinnerradius( target );
    radiusouter = gethackertoolouterradius( target );
    
    if ( target_scaleminmaxradius( target, self, level.hackertoollockonfov, radiusinner, radiusouter ) > 0 )
    {
        return 1;
    }
    
    return target_boundingisunderreticle( self, target, weapon.lockonmaxrange );
}

// Namespace hacker_tool
// Params 1
// Checksum 0x97dccd21, Offset: 0x2180
// Size: 0x1f6
function hackingtimescale( target )
{
    hackratio = 1;
    radiusinner = gethackertoolinnerradius( target );
    radiusouter = gethackertoolouterradius( target );
    
    if ( radiusinner != radiusouter )
    {
        scale = target_scaleminmaxradius( target, self, level.hackertoollockonfov, radiusinner, radiusouter );
        scale = scale * scale * scale * scale;
        hacktime = lerpfloat( gethackoutertime( target ), gethacktime( target ), scale );
        
        /#
            hackertooldebugtext = getdvarint( "<dev string:x37>", 0 );
            
            if ( hackertooldebugtext )
            {
                print3d( target.origin, "<dev string:x4b>" + scale + "<dev string:x53>" + radiusinner + "<dev string:x5c>" + radiusouter, ( 0, 0, 0 ), 1, hackertooldebugtext, 2 );
            }
            
            assert( hacktime > 0 );
        #/
        
        hackratio = gethacktime( target ) / hacktime;
        
        if ( !isdefined( hackratio ) )
        {
            hackratio = 1;
        }
    }
    
    return hackratio;
}

// Namespace hacker_tool
// Params 1
// Checksum 0x69e6e6c7, Offset: 0x2380
// Size: 0x92
function hackingtimenolineofsightscale( target )
{
    hackratio = 1;
    
    if ( isdefined( target.killstreakhacklostlineofsighttimems ) && target.killstreakhacklostlineofsighttimems > 0 )
    {
        assert( target.killstreakhacklostlineofsighttimems > 0 );
        hackratio = 1000 / target.killstreakhacklostlineofsighttimems;
    }
    
    return hackratio;
}

// Namespace hacker_tool
// Params 1
// Checksum 0x6328526b, Offset: 0x2420
// Size: 0xec, Type: bool
function isentityhackableweaponobject( entity )
{
    if ( isdefined( entity.classname ) && entity.classname == "grenade" )
    {
        if ( isdefined( entity.weapon ) )
        {
            watcher = weaponobjects::getweaponobjectwatcherbyweapon( entity.weapon );
            
            if ( isdefined( watcher ) )
            {
                if ( watcher.hackable )
                {
                    /#
                        assert( isdefined( watcher.hackertoolradius ) );
                        assert( isdefined( watcher.hackertooltimems ) );
                    #/
                    
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace hacker_tool
// Params 1
// Checksum 0x60700721, Offset: 0x2518
// Size: 0xe2
function getweaponobjecthackerradius( entity )
{
    /#
        assert( isdefined( entity.classname ) );
        assert( isdefined( entity.weapon ) );
    #/
    
    watcher = weaponobjects::getweaponobjectwatcherbyweapon( entity.weapon );
    
    /#
        assert( watcher.hackable );
        assert( isdefined( watcher.hackertoolradius ) );
    #/
    
    return watcher.hackertoolradius;
}

// Namespace hacker_tool
// Params 1
// Checksum 0x3c257cd8, Offset: 0x2608
// Size: 0xe2
function getweaponobjecthacktimems( entity )
{
    /#
        assert( isdefined( entity.classname ) );
        assert( isdefined( entity.weapon ) );
    #/
    
    watcher = weaponobjects::getweaponobjectwatcherbyweapon( entity.weapon );
    
    /#
        assert( watcher.hackable );
        assert( isdefined( watcher.hackertooltimems ) );
    #/
    
    return watcher.hackertooltimems;
}

// Namespace hacker_tool
// Params 1
// Checksum 0x7fa0d92d, Offset: 0x26f8
// Size: 0x42
function isentityhackablecarepackage( entity )
{
    if ( isdefined( entity.model ) )
    {
        return ( entity.model == "wpn_t7_care_package_world" );
    }
    
    return 0;
}

// Namespace hacker_tool
// Params 3
// Checksum 0x8536cd75, Offset: 0x2748
// Size: 0x176, Type: bool
function isvalidhackertooltarget( ent, weapon, allowhacked )
{
    if ( !isdefined( ent ) )
    {
        return false;
    }
    
    if ( self util::isusingremote() )
    {
        return false;
    }
    
    if ( self isempjammed() )
    {
        return false;
    }
    
    if ( !( isdefined( ent.allowhackingaftercloak ) && ( target_istarget( ent ) || ent.allowhackingaftercloak == 1 ) ) && !isentityhackableweaponobject( ent ) && !isinarray( level.hackertooltargets, ent ) )
    {
        return false;
    }
    
    if ( isentityhackableweaponobject( ent ) )
    {
        if ( distancesquared( self.origin, ent.origin ) > weapon.lockonmaxrange * weapon.lockonmaxrange )
        {
            return false;
        }
    }
    
    if ( allowhacked == 0 && isentitypreviouslyhacked( ent ) )
    {
        return false;
    }
    
    return true;
}

// Namespace hacker_tool
// Params 1
// Checksum 0x7be46e6a, Offset: 0x28c8
// Size: 0x3a, Type: bool
function isentitypreviouslyhacked( entity )
{
    if ( isdefined( entity.previouslyhacked ) && entity.previouslyhacked )
    {
        return true;
    }
    
    return false;
}

// Namespace hacker_tool
// Params 1
// Checksum 0xa93fd6f3, Offset: 0x2910
// Size: 0x1a0
function hackersoftsighttest( weapon )
{
    passed = 1;
    lockontime = 0;
    
    if ( isdefined( self.hackertooltarget ) )
    {
        lockontime = self getlockontime( self.hackertooltarget, weapon );
    }
    
    if ( lockontime == 0 || self isempjammed() )
    {
        self clearhackertarget( weapon, 0, 0 );
        passed = 0;
    }
    else if ( iswithinhackertoolreticle( self.hackertooltarget, weapon ) && self heatseekingmissile::locksighttest( self.hackertooltarget ) )
    {
        self.hackertoollostsightlinetime = 0;
    }
    else
    {
        if ( self.hackertoollostsightlinetime == 0 )
        {
            self.hackertoollostsightlinetime = gettime();
        }
        
        timepassed = gettime() - self.hackertoollostsightlinetime;
        lostlineofsighttimelimitmsec = level.hackertoollostsightlimitms;
        
        if ( isdefined( self.hackertooltarget.killstreakhacklostlineofsightlimitms ) )
        {
            lostlineofsighttimelimitmsec = self.hackertooltarget.killstreakhacklostlineofsightlimitms;
        }
        
        if ( timepassed >= lostlineofsighttimelimitmsec )
        {
            self clearhackertarget( weapon, 0, 0 );
            passed = 0;
        }
    }
    
    return passed;
}

// Namespace hacker_tool
// Params 2
// Checksum 0xfc192f06, Offset: 0x2ab8
// Size: 0xa2
function registerwithhackertool( radius, hacktimems )
{
    self endon( #"death" );
    
    if ( isdefined( radius ) )
    {
        self.hackertoolradius = radius;
    }
    else
    {
        self.hackertoolradius = level.hackertoollockonradius;
    }
    
    if ( isdefined( hacktimems ) )
    {
        self.hackertooltimems = hacktimems;
    }
    else
    {
        self.hackertooltimems = level.hackertoolhacktimems;
    }
    
    self thread watchhackableentitydeath();
    level.hackertooltargets[ level.hackertooltargets.size ] = self;
}

// Namespace hacker_tool
// Params 0
// Checksum 0x935fc665, Offset: 0x2b68
// Size: 0x2c
function watchhackableentitydeath()
{
    self waittill( #"death" );
    arrayremovevalue( level.hackertooltargets, self );
}

// Namespace hacker_tool
// Params 1
// Checksum 0xf309d80b, Offset: 0x2ba0
// Size: 0x10c
function gethackertoolinnerradius( target )
{
    radius = level.hackertoollockonradius;
    
    if ( isentityhackablecarepackage( target ) )
    {
        assert( isdefined( target.hackertoolradius ) );
        radius = target.hackertoolradius;
    }
    else if ( isentityhackableweaponobject( target ) )
    {
        radius = getweaponobjecthackerradius( target );
    }
    else if ( isdefined( target.hackertoolinnerradius ) )
    {
        radius = target.hackertoolinnerradius;
    }
    else if ( isdefined( target.hackertoolradius ) )
    {
        radius = target.hackertoolradius;
    }
    
    return radius;
}

// Namespace hacker_tool
// Params 1
// Checksum 0x6a8a3c79, Offset: 0x2cb8
// Size: 0x10c
function gethackertoolouterradius( target )
{
    radius = level.hackertoollockonradius;
    
    if ( isentityhackablecarepackage( target ) )
    {
        assert( isdefined( target.hackertoolradius ) );
        radius = target.hackertoolradius;
    }
    else if ( isentityhackableweaponobject( target ) )
    {
        radius = getweaponobjecthackerradius( target );
    }
    else if ( isdefined( target.hackertoolouterradius ) )
    {
        radius = target.hackertoolouterradius;
    }
    else if ( isdefined( target.hackertoolradius ) )
    {
        radius = target.hackertoolradius;
    }
    
    return radius;
}

// Namespace hacker_tool
// Params 1
// Checksum 0x995590c0, Offset: 0x2dd0
// Size: 0x168
function gethacktime( target )
{
    time = 500;
    
    if ( isentityhackablecarepackage( target ) )
    {
        assert( isdefined( target.hackertooltimems ) );
        
        if ( isdefined( target.owner ) && target.owner == self )
        {
            time = level.carepackageownerhackertooltimems;
        }
        else if ( isdefined( target.owner ) && target.owner.team == self.team )
        {
            time = level.carepackagefriendlyhackertooltimems;
        }
        else
        {
            time = level.carepackagehackertooltimems;
        }
    }
    else if ( isentityhackableweaponobject( target ) )
    {
        time = getweaponobjecthacktimems( target );
    }
    else if ( isdefined( target.hackertoolinnertimems ) )
    {
        time = target.hackertoolinnertimems;
    }
    else
    {
        time = level.vehiclehackertooltimems;
    }
    
    return time;
}

// Namespace hacker_tool
// Params 1
// Checksum 0x3f16001f, Offset: 0x2f40
// Size: 0x168
function gethackoutertime( target )
{
    time = 500;
    
    if ( isentityhackablecarepackage( target ) )
    {
        assert( isdefined( target.hackertooltimems ) );
        
        if ( isdefined( target.owner ) && target.owner == self )
        {
            time = level.carepackageownerhackertooltimems;
        }
        else if ( isdefined( target.owner ) && target.owner.team == self.team )
        {
            time = level.carepackagefriendlyhackertooltimems;
        }
        else
        {
            time = level.carepackagehackertooltimems;
        }
    }
    else if ( isentityhackableweaponobject( target ) )
    {
        time = getweaponobjecthacktimems( target );
    }
    else if ( isdefined( target.hackertooloutertimems ) )
    {
        time = target.hackertooloutertimems;
    }
    else
    {
        time = level.vehiclehackertooltimems;
    }
    
    return time;
}

// Namespace hacker_tool
// Params 2
// Checksum 0x9e10ee08, Offset: 0x30b0
// Size: 0x8c
function getlockontime( target, weapon )
{
    locklengthms = self gethacktime( self.hackertooltarget );
    
    if ( locklengthms == 0 )
    {
        return 0;
    }
    
    lockonspeed = weapon.lockonspeed;
    
    if ( lockonspeed <= 0 )
    {
        lockonspeed = 1000;
    }
    
    return locklengthms / lockonspeed;
}

/#

    // Namespace hacker_tool
    // Params 0
    // Checksum 0xfb00f307, Offset: 0x3148
    // Size: 0x90, Type: dev
    function tunables()
    {
        while ( true )
        {
            level.hackertoollostsightlimitms = getdvarint( "<dev string:x65>", 1000 );
            level.hackertoollockonradius = getdvarfloat( "<dev string:x84>", 20 );
            level.hackertoollockonfov = getdvarint( "<dev string:x9f>", 65 );
            wait 1;
        }
    }

#/
