#using scripts/shared/array_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/bots/bot_buttons;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace bot_combat;

// Namespace bot_combat
// Params 0
// Checksum 0xb9eea440, Offset: 0x180
// Size: 0x16c
function combat_think()
{
    if ( self has_threat() )
    {
        if ( self threat_is_alive() )
        {
            self update_threat();
        }
        else
        {
            self thread [[ level.botthreatdead ]]();
        }
    }
    
    if ( !self has_threat() && !self get_new_threat() )
    {
        return;
    }
    else if ( self has_threat() )
    {
        if ( !self threat_visible() || self.bot.threat.lastdistancesq > level.botsettings.threatradiusmaxsq )
        {
            self get_new_threat( level.botsettings.threatradiusmin );
        }
    }
    
    if ( self threat_visible() )
    {
        self thread [[ level.botupdatethreatgoal ]]();
        self thread [[ level.botthreatengage ]]();
        return;
    }
    
    self thread [[ level.botthreatlost ]]();
}

// Namespace bot_combat
// Params 1
// Checksum 0xcec84a4f, Offset: 0x2f8
// Size: 0x22
function is_alive( entity )
{
    return isalive( entity );
}

// Namespace bot_combat
// Params 1
// Checksum 0xbe4c1b4, Offset: 0x328
// Size: 0x32
function get_bot_threats( maxdistance )
{
    if ( !isdefined( maxdistance ) )
    {
        maxdistance = 0;
    }
    
    return self botgetthreats( maxdistance );
}

// Namespace bot_combat
// Params 0
// Checksum 0x49dcb002, Offset: 0x368
// Size: 0x1a
function get_ai_threats()
{
    return getaiteamarray( "axis" );
}

// Namespace bot_combat
// Params 1
// Checksum 0xadde8142, Offset: 0x390
// Size: 0xe, Type: bool
function ignore_none( entity )
{
    return false;
}

// Namespace bot_combat
// Params 1
// Checksum 0xde59d988, Offset: 0x3a8
// Size: 0x24, Type: bool
function ignore_non_sentient( entity )
{
    return !issentient( entity );
}

// Namespace bot_combat
// Params 0
// Checksum 0xe2e3cb35, Offset: 0x3d8
// Size: 0x1c, Type: bool
function has_threat()
{
    return isdefined( self.bot.threat.entity );
}

// Namespace bot_combat
// Params 0
// Checksum 0x301a4eb5, Offset: 0x400
// Size: 0x36, Type: bool
function threat_visible()
{
    return self has_threat() && self.bot.threat.visible;
}

// Namespace bot_combat
// Params 0
// Checksum 0x48b413b8, Offset: 0x440
// Size: 0x82
function threat_is_alive()
{
    if ( !self has_threat() )
    {
        return 0;
    }
    
    if ( isdefined( level.botthreatisalive ) )
    {
        return self [[ level.botthreatisalive ]]( self.bot.threat.entity );
    }
    
    return isalive( self.bot.threat.entity );
}

// Namespace bot_combat
// Params 1
// Checksum 0xe7593144, Offset: 0x4d0
// Size: 0x74
function set_threat( entity )
{
    self.bot.threat.entity = entity;
    self.bot.threat.aimoffset = self get_aim_offset( entity );
    self update_threat( 1 );
}

// Namespace bot_combat
// Params 0
// Checksum 0xe2baabce, Offset: 0x550
// Size: 0x44
function clear_threat()
{
    self.bot.threat.entity = undefined;
    self clear_threat_aim();
    self botlookforward();
}

// Namespace bot_combat
// Params 1
// Checksum 0x2648f662, Offset: 0x5a0
// Size: 0x3f0
function update_threat( newthreat )
{
    if ( isdefined( newthreat ) && newthreat )
    {
        self.bot.threat.wasvisible = 0;
        self clear_threat_aim();
    }
    else
    {
        self.bot.threat.wasvisible = self.bot.threat.visible;
    }
    
    velocity = self.bot.threat.entity getvelocity();
    distancesq = distancesquared( self geteye(), self.bot.threat.entity.origin );
    predictiontime = isdefined( level.botsettings.thinkinterval ) ? level.botsettings.thinkinterval : 0.05;
    predictedposition = self.bot.threat.entity.origin + velocity * predictiontime;
    aimpoint = predictedposition + self.bot.threat.aimoffset;
    dot = self bot::fwd_dot( aimpoint );
    fov = self botgetfov();
    
    if ( isdefined( newthreat ) && newthreat )
    {
        self.bot.threat.visible = 1;
    }
    else if ( dot < fov || !self botsighttrace( self.bot.threat.entity ) )
    {
        self.bot.threat.visible = 0;
        return;
    }
    
    self.bot.threat.visible = 1;
    self.bot.threat.lastvisibletime = gettime();
    self.bot.threat.lastdistancesq = distancesq;
    self.bot.threat.lastvelocity = velocity;
    self.bot.threat.lastposition = predictedposition;
    self.bot.threat.aimpoint = aimpoint;
    self.bot.threat.dot = dot;
    weapon = self getcurrentweapon();
    weaponrange = weapon_range( weapon );
    self.bot.threat.inrange = distancesq < weaponrange * weaponrange;
    weaponrangeclose = weapon_range_close( weapon );
    self.bot.threat.incloserange = distancesq < weaponrangeclose * weaponrangeclose;
}

// Namespace bot_combat
// Params 1
// Checksum 0x81aee3b0, Offset: 0x998
// Size: 0x7c, Type: bool
function get_new_threat( maxdistance )
{
    entity = self get_greatest_threat( maxdistance );
    
    if ( isdefined( entity ) && entity !== self.bot.threat.entity )
    {
        self set_threat( entity );
        return true;
    }
    
    return false;
}

// Namespace bot_combat
// Params 1
// Checksum 0xb9522eee, Offset: 0xa20
// Size: 0xcc
function get_greatest_threat( maxdistance )
{
    threats = self [[ level.botgetthreats ]]( maxdistance );
    
    if ( !isdefined( threats ) )
    {
        return undefined;
    }
    
    foreach ( entity in threats )
    {
        if ( self [[ level.botignorethreat ]]( entity ) )
        {
            continue;
        }
        
        return entity;
    }
    
    return undefined;
}

// Namespace bot_combat
// Params 0
// Checksum 0xc002a5fd, Offset: 0xaf8
// Size: 0x4bc
function engage_threat()
{
    if ( !self.bot.threat.wasvisible && self.bot.threat.visible && !self isthrowinggrenade() && !self fragbuttonpressed() && !self secondaryoffhandbuttonpressed() && !self isswitchingweapons() )
    {
        visibleroll = randomint( 100 );
        rollweight = isdefined( level.botsettings.lethalweight ) ? level.botsettings.lethalweight : 0;
        
        if ( visibleroll < rollweight && self.bot.threat.lastdistancesq >= level.botsettings.lethaldistanceminsq && self.bot.threat.lastdistancesq <= level.botsettings.lethaldistancemaxsq && self getweaponammostock( self.grenadetypeprimary ) )
        {
            self clear_threat_aim();
            self throw_grenade( self.grenadetypeprimary, self.bot.threat.lastposition );
            return;
        }
        
        visibleroll -= rollweight;
        rollweight = isdefined( level.botsettings.tacticalweight ) ? level.botsettings.tacticalweight : 0;
        
        if ( visibleroll >= 0 && visibleroll < rollweight && self.bot.threat.lastdistancesq >= level.botsettings.tacticaldistanceminsq && self.bot.threat.lastdistancesq <= level.botsettings.tacticaldistancemaxsq && self getweaponammostock( self.grenadetypesecondary ) )
        {
            self clear_threat_aim();
            self throw_grenade( self.grenadetypesecondary, self.bot.threat.lastposition );
            return;
        }
        
        self.bot.threat.aimoffset = self get_aim_offset( self.bot.threat.entity );
    }
    
    if ( self fragbuttonpressed() )
    {
        self throw_grenade( self.grenadetypeprimary, self.bot.threat.lastposition );
        return;
    }
    else if ( self secondaryoffhandbuttonpressed() )
    {
        self throw_grenade( self.grenadetypesecondary, self.bot.threat.lastposition );
        return;
    }
    
    self update_weapon_aim();
    
    if ( self isreloading() || self isswitchingweapons() || self isthrowinggrenade() || self fragbuttonpressed() || self secondaryoffhandbuttonpressed() || self ismeleeing() )
    {
        return;
    }
    
    if ( melee_attack() )
    {
        return;
    }
    
    self update_weapon_ads();
    self fire_weapon();
}

// Namespace bot_combat
// Params 0
// Checksum 0x95ce1b32, Offset: 0xfc0
// Size: 0x13c
function update_threat_goal()
{
    if ( self botundermanualcontrol() )
    {
        return;
    }
    
    if ( self.bot.threat.wasvisible || self botgoalset() && !self.bot.threat.visible )
    {
        return;
    }
    
    radius = get_threat_goal_radius();
    radiussq = radius * radius;
    threatdistsq = distance2dsquared( self.origin, self.bot.threat.lastposition );
    
    if ( threatdistsq < radiussq || !self botsetgoal( self.bot.threat.lastposition, radius ) )
    {
        self combat_strafe();
    }
}

// Namespace bot_combat
// Params 0
// Checksum 0x9ccb08de, Offset: 0x1108
// Size: 0xe2
function get_threat_goal_radius()
{
    weapon = self getcurrentweapon();
    
    if ( !self getweaponammoclip( weapon ) && ( randomint( 100 ) < 10 || weapon.weapclass == "melee" || !self getweaponammostock( weapon ) ) )
    {
        return level.botsettings.meleerange;
    }
    
    return randomintrange( level.botsettings.threatradiusmin, level.botsettings.threatradiusmax );
}

// Namespace bot_combat
// Params 0
// Checksum 0x5b1c39cb, Offset: 0x11f8
// Size: 0x14c
function fire_weapon()
{
    if ( !self.bot.threat.inrange )
    {
        return;
    }
    
    weapon = self getcurrentweapon();
    
    if ( weapon == level.weaponnone || !self getweaponammoclip( weapon ) || self.bot.threat.dot < weapon_fire_dot( weapon ) )
    {
        return;
    }
    
    if ( weapon.firetype == "Single Shot" || weapon.firetype == "Burst" || weapon.firetype == "Charge Shot" )
    {
        if ( self attackbuttonpressed() )
        {
            return;
        }
    }
    
    self bot::press_attack_button();
    
    if ( weapon.isdualwield )
    {
        self bot::press_throw_button();
    }
}

// Namespace bot_combat
// Params 0
// Checksum 0x9120be55, Offset: 0x1350
// Size: 0x98, Type: bool
function melee_attack()
{
    if ( self.bot.threat.dot < level.botsettings.meleedot )
    {
        return false;
    }
    
    if ( distancesquared( self.origin, self.bot.threat.lastposition ) > level.botsettings.meleerangesq )
    {
        return false;
    }
    
    self bot::tap_melee_button();
    return true;
}

// Namespace bot_combat
// Params 0
// Checksum 0x15539658, Offset: 0x13f0
// Size: 0x1b4
function chase_threat()
{
    if ( self botundermanualcontrol() )
    {
        return;
    }
    
    if ( self.bot.threat.wasvisible && !self.bot.threat.visible )
    {
        self clear_threat_aim();
        self botsetgoal( self.bot.threat.lastposition );
        self bot::sprint_to_goal();
        return;
    }
    
    if ( self.bot.threat.lastvisibletime + ( isdefined( level.botsettings.chasethreattime ) ? level.botsettings.chasethreattime : 0 ) < gettime() )
    {
        self clear_threat();
        return;
    }
    
    if ( !self botgoalset() )
    {
        self bot::navmesh_wander( self.bot.threat.lastvelocity, self.botsettings.chasewandermin, self.botsettings.chasewandermax, self.botsettings.chasewanderspacing, self.botsettings.chasewanderfwddot );
        self clear_threat();
    }
}

// Namespace bot_combat
// Params 1
// Checksum 0xf906a30b, Offset: 0x15b0
// Size: 0xb8
function get_aim_offset( entity )
{
    if ( issentient( entity ) && randomint( 100 ) < ( isdefined( level.botsettings.headshotweight ) ? level.botsettings.headshotweight : 0 ) )
    {
        return ( entity geteye() - entity.origin );
    }
    
    return entity getcentroid() - entity.origin;
}

// Namespace bot_combat
// Params 0
// Checksum 0x894dc0a8, Offset: 0x1670
// Size: 0x1f4
function update_weapon_aim()
{
    if ( !isdefined( self.bot.threat.aimstarttime ) )
    {
        self start_threat_aim();
    }
    
    aimtime = gettime() - self.bot.threat.aimstarttime;
    
    if ( aimtime < 0 )
    {
        return;
    }
    
    if ( aimtime >= self.bot.threat.aimtime || !isdefined( self.bot.threat.aimerror ) )
    {
        self botlookatpoint( self.bot.threat.aimpoint );
        return;
    }
    
    eyepoint = self geteye();
    threatangles = vectortoangles( self.bot.threat.aimpoint - eyepoint );
    initialangles = threatangles + self.bot.threat.aimerror;
    currangles = vectorlerp( initialangles, threatangles, aimtime / self.bot.threat.aimtime );
    playerangles = self getplayerangles();
    self botsetlookangles( anglestoforward( currangles ) );
}

// Namespace bot_combat
// Params 0
// Checksum 0xd75065e7, Offset: 0x1870
// Size: 0x19c
function start_threat_aim()
{
    self.bot.threat.aimstarttime = gettime() + ( isdefined( level.botsettings.aimdelay ) ? level.botsettings.aimdelay : 0 ) * 1000;
    self.bot.threat.aimtime = ( isdefined( level.botsettings.aimtime ) ? level.botsettings.aimtime : 0 ) * 1000;
    pitcherror = angleerror( isdefined( level.botsettings.aimerrorminpitch ) ? level.botsettings.aimerrorminpitch : 0, isdefined( level.botsettings.aimerrormaxpitch ) ? level.botsettings.aimerrormaxpitch : 0 );
    yawerror = angleerror( isdefined( level.botsettings.aimerrorminyaw ) ? level.botsettings.aimerrorminyaw : 0, isdefined( level.botsettings.aimerrormaxyaw ) ? level.botsettings.aimerrormaxyaw : 0 );
    self.bot.threat.aimerror = ( pitcherror, yawerror, 0 );
}

// Namespace bot_combat
// Params 2
// Checksum 0xff5424a3, Offset: 0x1a18
// Size: 0x86
function angleerror( anglemin, anglemax )
{
    angle = anglemax - anglemin;
    angle *= randomfloatrange( -1, 1 );
    
    if ( angle < 0 )
    {
        angle -= anglemin;
    }
    else
    {
        angle += anglemin;
    }
    
    return angle;
}

// Namespace bot_combat
// Params 0
// Checksum 0xd30a5d1b, Offset: 0x1aa8
// Size: 0x6a
function clear_threat_aim()
{
    if ( !isdefined( self.bot.threat.aimstarttime ) )
    {
        return;
    }
    
    self.bot.threat.aimstarttime = undefined;
    self.bot.threat.aimtime = undefined;
    self.bot.threat.aimerror = undefined;
}

// Namespace bot_combat
// Params 0
// Checksum 0x74e72767, Offset: 0x1b20
// Size: 0x164
function bot_pre_combat()
{
    if ( self has_threat() )
    {
        return;
    }
    
    if ( isdefined( self.bot.damage.time ) && self.bot.damage.time + 1500 > gettime() )
    {
        if ( self has_threat() && self.bot.damage.time > self.bot.threat.lastvisibletime )
        {
            self clear_threat();
        }
        
        self bot::navmesh_wander( self.bot.damage.attackdir, level.botsettings.damagewandermin, level.botsettings.damagewandermax, level.botsettings.damagewanderspacing, level.botsettings.damagewanderfwddot );
        self bot::end_sprint_to_goal();
        self clear_damage();
    }
}

// Namespace bot_combat
// Params 0
// Checksum 0x99ec1590, Offset: 0x1c90
// Size: 0x4
function bot_post_combat()
{
    
}

// Namespace bot_combat
// Params 0
// Checksum 0x311bb27f, Offset: 0x1ca0
// Size: 0x104
function update_weapon_ads()
{
    if ( !self.bot.threat.inrange || self.bot.threat.incloserange )
    {
        return;
    }
    
    weapon = self getcurrentweapon();
    
    if ( weapon == level.weaponnone || weapon.isdualwield || weapon.weapclass == "melee" || self getweaponammoclip( weapon ) <= 0 )
    {
        return;
    }
    
    if ( self.bot.threat.dot < weapon_ads_dot( weapon ) )
    {
        return;
    }
    
    self bot::press_ads_button();
}

// Namespace bot_combat
// Params 1
// Checksum 0xf6d0e3a5, Offset: 0x1db0
// Size: 0xbe
function weapon_ads_dot( weapon )
{
    if ( weapon.issniperweapon )
    {
        return level.botsettings.sniperads;
    }
    else if ( weapon.isrocketlauncher )
    {
        return level.botsettings.rocketlauncherads;
    }
    
    switch ( weapon.weapclass )
    {
        case "mg":
            return level.botsettings.mgads;
        case "smg":
            return level.botsettings.smgads;
        default:
            return level.botsettings.spreadads;
        case "pistol":
            return level.botsettings.pistolads;
        case "rifle":
            return level.botsettings.rifleads;
    }
}

// Namespace bot_combat
// Params 1
// Checksum 0x4d88569, Offset: 0x1eb8
// Size: 0xbe
function weapon_fire_dot( weapon )
{
    if ( weapon.issniperweapon )
    {
        return level.botsettings.sniperfire;
    }
    else if ( weapon.isrocketlauncher )
    {
        return level.botsettings.rocketlauncherfire;
    }
    
    switch ( weapon.weapclass )
    {
        case "mg":
            return level.botsettings.mgfire;
        case "smg":
            return level.botsettings.smgfire;
        default:
            return level.botsettings.spreadfire;
        case "pistol":
            return level.botsettings.pistolfire;
        case "rifle":
            return level.botsettings.riflefire;
    }
}

// Namespace bot_combat
// Params 1
// Checksum 0x45b8fe45, Offset: 0x1fc0
// Size: 0xbe
function weapon_range( weapon )
{
    if ( weapon.issniperweapon )
    {
        return level.botsettings.sniperrange;
    }
    else if ( weapon.isrocketlauncher )
    {
        return level.botsettings.rocketlauncherrange;
    }
    
    switch ( weapon.weapclass )
    {
        case "mg":
            return level.botsettings.mgrange;
        case "smg":
            return level.botsettings.smgrange;
        default:
            return level.botsettings.spreadrange;
        case "pistol":
            return level.botsettings.pistolrange;
        case "rifle":
            return level.botsettings.riflerange;
    }
}

// Namespace bot_combat
// Params 1
// Checksum 0xb3567cd3, Offset: 0x20c8
// Size: 0xbe
function weapon_range_close( weapon )
{
    if ( weapon.issniperweapon )
    {
        return level.botsettings.sniperrangeclose;
    }
    else if ( weapon.isrocketlauncher )
    {
        return level.botsettings.rocketlauncherrangeclose;
    }
    
    switch ( weapon.weapclass )
    {
        case "mg":
            return level.botsettings.mgrangeclose;
        case "smg":
            return level.botsettings.smgrangeclose;
        default:
            return level.botsettings.spreadrangeclose;
        case "pistol":
            return level.botsettings.pistolrangeclose;
        case "rifle":
            return level.botsettings.riflerangeclose;
    }
}

// Namespace bot_combat
// Params 0
// Checksum 0x6e5f8073, Offset: 0x21d0
// Size: 0x35a, Type: bool
function switch_weapon()
{
    currentweapon = self getcurrentweapon();
    
    if ( self isswitchingweapons() || currentweapon.isheroweapon || currentweapon.isitem )
    {
        return false;
    }
    
    weapon = bot::get_ready_gadget();
    
    if ( weapon != level.weaponnone )
    {
        if ( !isdefined( level.enemyempactive ) || !self [[ level.enemyempactive ]]() )
        {
            self bot::activate_hero_gadget( weapon );
            return true;
        }
    }
    
    weapons = self getweaponslistprimaries();
    
    if ( currentweapon == level.weaponnone || currentweapon.weapclass == "melee" || currentweapon.weapclass == "rocketLauncher" || currentweapon.weapclass == "pistol" )
    {
        foreach ( weapon in weapons )
        {
            if ( weapon == currentweapon )
            {
                continue;
            }
            
            if ( self getweaponammoclip( weapon ) || self getweaponammostock( weapon ) )
            {
                self botswitchtoweapon( weapon );
                return true;
            }
        }
        
        return false;
    }
    
    currentammostock = self getweaponammostock( currentweapon );
    
    if ( currentammostock )
    {
        return false;
    }
    
    switchfrac = 0.3;
    currentclipfrac = self weapon_clip_frac( currentweapon );
    
    if ( currentclipfrac > switchfrac )
    {
        return false;
    }
    
    foreach ( weapon in weapons )
    {
        if ( self getweaponammostock( weapon ) || self weapon_clip_frac( weapon ) > switchfrac )
        {
            self botswitchtoweapon( weapon );
            return true;
        }
    }
    
    return false;
}

// Namespace bot_combat
// Params 0
// Checksum 0xe97da6c4, Offset: 0x2538
// Size: 0x24a
function threat_switch_weapon()
{
    currentweapon = self getcurrentweapon();
    
    if ( self isswitchingweapons() || self getweaponammoclip( currentweapon ) || currentweapon.isitem )
    {
        return;
    }
    
    currentammostock = self getweaponammostock( currentweapon );
    weapons = self getweaponslistprimaries();
    
    foreach ( weapon in weapons )
    {
        if ( weapon == currentweapon || weapon.requirelockontofire )
        {
            continue;
        }
        
        if ( weapon.weapclass == "melee" )
        {
            if ( currentammostock && randomintrange( 0, 100 ) < 75 )
            {
                continue;
            }
        }
        else
        {
            if ( !self getweaponammoclip( weapon ) && currentammostock )
            {
                continue;
            }
            
            weaponammostock = self getweaponammostock( weapon );
            
            if ( !currentammostock && !weaponammostock )
            {
                continue;
            }
            
            if ( weapon.weapclass != "pistol" && randomintrange( 0, 100 ) < 75 )
            {
                continue;
            }
        }
        
        self botswitchtoweapon( weapon );
    }
}

// Namespace bot_combat
// Params 0
// Checksum 0xfe651764, Offset: 0x2790
// Size: 0xcc, Type: bool
function reload_weapon()
{
    weapon = self getcurrentweapon();
    
    if ( !self getweaponammostock( weapon ) )
    {
        return false;
    }
    
    reloadfrac = 0.5;
    
    if ( weapon.weapclass == "mg" )
    {
        reloadfrac = 0.25;
    }
    
    if ( self weapon_clip_frac( weapon ) < reloadfrac )
    {
        self bot::tap_reload_button();
        return true;
    }
    
    return false;
}

// Namespace bot_combat
// Params 1
// Checksum 0xf355a527, Offset: 0x2868
// Size: 0x64
function weapon_clip_frac( weapon )
{
    if ( weapon.clipsize <= 0 )
    {
        return 1;
    }
    
    clipammo = self getweaponammoclip( weapon );
    return clipammo / weapon.clipsize;
}

// Namespace bot_combat
// Params 2
// Checksum 0xf6fbde65, Offset: 0x28d8
// Size: 0xdc
function throw_grenade( weapon, target )
{
    if ( !isdefined( self.bot.threat.aimstarttime ) )
    {
        self aim_grenade( weapon, target );
        self press_grenade_button( weapon );
        return;
    }
    
    if ( self.bot.threat.aimstarttime + self.bot.threat.aimtime > gettime() )
    {
        return;
    }
    
    if ( self will_hit_target( weapon, target ) )
    {
        return;
    }
    
    self press_grenade_button( weapon );
}

// Namespace bot_combat
// Params 1
// Checksum 0xfe18d520, Offset: 0x29c0
// Size: 0x5c
function press_grenade_button( weapon )
{
    if ( weapon == self.grenadetypeprimary )
    {
        self bot::press_frag_button();
        return;
    }
    
    if ( weapon == self.grenadetypesecondary )
    {
        self bot::press_offhand_button();
    }
}

// Namespace bot_combat
// Params 2
// Checksum 0x1ca88626, Offset: 0x2a28
// Size: 0x84
function aim_grenade( weapon, target )
{
    aimpeak = target + ( 0, 0, 100 );
    self.bot.threat.aimstarttime = gettime();
    self.bot.threat.aimtime = 1500;
    self botsetlookanglesfrompoint( aimpeak );
}

// Namespace bot_combat
// Params 2
// Checksum 0x88297306, Offset: 0x2ab8
// Size: 0x158, Type: bool
function will_hit_target( weapon, target )
{
    velocity = get_throw_velocity( weapon );
    throworigin = self geteye();
    xydist = distance2d( throworigin, target );
    xyspeed = distance2d( velocity, ( 0, 0, 0 ) );
    t = xydist / xyspeed;
    gravity = getdvarfloat( "bg_gravity" ) * -1;
    theight = throworigin[ 2 ] + velocity[ 2 ] * t + gravity * t * t * 0.5;
    return abs( theight - target[ 2 ] ) < 20;
}

// Namespace bot_combat
// Params 1
// Checksum 0x1b6210cd, Offset: 0x2c18
// Size: 0x5a
function get_throw_velocity( weapon )
{
    angles = self getplayerangles();
    forward = anglestoforward( angles );
    return forward * 928;
}

// Namespace bot_combat
// Params 0
// Checksum 0x78dbad39, Offset: 0x2c80
// Size: 0xda
function get_lethal_grenade()
{
    weaponslist = self getweaponslist();
    
    foreach ( weapon in weaponslist )
    {
        if ( weapon.type == "grenade" && self getweaponammostock( weapon ) )
        {
            return weapon;
        }
    }
    
    return level.weaponnone;
}

// Namespace bot_combat
// Params 0
// Checksum 0x227b42da, Offset: 0x2d68
// Size: 0x194
function wait_damage_loop()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction, point, mod, unused1, unused2, unused3, weapon, flags, inflictor );
        self.bot.damage.entity = attacker;
        self.bot.damage.amount = damage;
        self.bot.damage.attackdir = vectornormalize( attacker.origin - self.origin );
        self.bot.damage.weapon = weapon;
        self.bot.damage.mod = mod;
        self.bot.damage.time = gettime();
        self thread [[ level.onbotdamage ]]();
    }
}

// Namespace bot_combat
// Params 0
// Checksum 0x3923b7d8, Offset: 0x2f08
// Size: 0x92
function clear_damage()
{
    self.bot.damage.entity = undefined;
    self.bot.damage.amount = undefined;
    self.bot.damage.direction = undefined;
    self.bot.damage.weapon = undefined;
    self.bot.damage.mod = undefined;
    self.bot.damage.time = undefined;
}

// Namespace bot_combat
// Params 5
// Checksum 0x5510f30c, Offset: 0x2fa8
// Size: 0x394
function combat_strafe( radiusmin, radiusmax, spacing, sidedotmin, sidedotmax )
{
    if ( !isdefined( radiusmin ) )
    {
        radiusmin = isdefined( level.botsettings.strafemin ) ? level.botsettings.strafemin : 0;
    }
    
    if ( !isdefined( radiusmax ) )
    {
        radiusmax = isdefined( level.botsettings.strafemax ) ? level.botsettings.strafemax : 0;
    }
    
    if ( !isdefined( spacing ) )
    {
        spacing = isdefined( level.botsettings.strafespacing ) ? level.botsettings.strafespacing : 0;
    }
    
    if ( !isdefined( sidedotmin ) )
    {
        sidedotmin = isdefined( level.botsettings.strafesidedotmin ) ? level.botsettings.strafesidedotmin : 0;
    }
    
    if ( !isdefined( sidedotmax ) )
    {
        sidedotmax = isdefined( level.botsettings.strafesidedotmax ) ? level.botsettings.strafesidedotmax : 0;
    }
    
    fwd = anglestoforward( self.angles );
    
    /#
    #/
    
    queryresult = positionquery_source_navigation( self.origin, radiusmin, radiusmax, 64, spacing, self );
    best_point = undefined;
    
    foreach ( point in queryresult.data )
    {
        movedir = vectornormalize( point.origin - self.origin );
        dot = vectordot( movedir, fwd );
        
        if ( dot >= sidedotmin && dot <= sidedotmax )
        {
            point.score = mapfloat( radiusmin, radiusmax, 0, 50, point.disttoorigin2d );
            point.score += randomfloatrange( 0, 50 );
        }
        
        /#
        #/
        
        if ( !isdefined( best_point ) || point.score > best_point.score )
        {
            best_point = point;
        }
    }
    
    if ( isdefined( best_point ) )
    {
        /#
        #/
        
        self botsetgoal( best_point.origin );
        self bot::end_sprint_to_goal();
    }
}

