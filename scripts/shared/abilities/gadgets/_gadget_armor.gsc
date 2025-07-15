#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weaponobjects;

#namespace armor;

// Namespace armor
// Params 0, eflags: 0x2
// Checksum 0xbb9ee106, Offset: 0x4d8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_armor", &__init__, undefined, undefined );
}

// Namespace armor
// Params 0
// Checksum 0xe26d26b, Offset: 0x518
// Size: 0x144
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 4, &gadget_armor_on, &gadget_armor_off );
    ability_player::register_gadget_possession_callbacks( 4, &gadget_armor_on_give, &gadget_armor_on_take );
    ability_player::register_gadget_flicker_callbacks( 4, &gadget_armor_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 4, &gadget_armor_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 4, &gadget_armor_is_flickering );
    clientfield::register( "allplayers", "armor_status", 1, 5, "int" );
    clientfield::register( "toplayer", "player_damage_type", 1, 1, "int" );
    callback::on_connect( &gadget_armor_on_connect );
}

// Namespace armor
// Params 1
// Checksum 0xe841b40b, Offset: 0x668
// Size: 0x22
function gadget_armor_is_inuse( slot )
{
    return self gadgetisactive( slot );
}

// Namespace armor
// Params 1
// Checksum 0x38b17ccc, Offset: 0x698
// Size: 0x22
function gadget_armor_is_flickering( slot )
{
    return self gadgetflickering( slot );
}

// Namespace armor
// Params 2
// Checksum 0xfafd890f, Offset: 0x6c8
// Size: 0x34
function gadget_armor_on_flicker( slot, weapon )
{
    self thread gadget_armor_flicker( slot, weapon );
}

// Namespace armor
// Params 2
// Checksum 0xdcd54c3b, Offset: 0x708
// Size: 0x4c
function gadget_armor_on_give( slot, weapon )
{
    self clientfield::set( "armor_status", 0 );
    self._gadget_armor_slot = slot;
    self._gadget_armor_weapon = weapon;
}

// Namespace armor
// Params 2
// Checksum 0xa874831f, Offset: 0x760
// Size: 0x34
function gadget_armor_on_take( slot, weapon )
{
    self gadget_armor_off( slot, weapon );
}

// Namespace armor
// Params 0
// Checksum 0x99ec1590, Offset: 0x7a0
// Size: 0x4
function gadget_armor_on_connect()
{
    
}

// Namespace armor
// Params 2
// Checksum 0x3850d83c, Offset: 0x7b0
// Size: 0xec
function gadget_armor_on( slot, weapon )
{
    if ( isalive( self ) )
    {
        self flagsys::set( "gadget_armor_on" );
        self.shock_onpain = 0;
        self.gadgethitpoints = isdefined( weapon.gadget_max_hitpoints ) && weapon.gadget_max_hitpoints > 0 ? weapon.gadget_max_hitpoints : undefined;
        
        if ( isdefined( self.overrideplayerdamage ) )
        {
            self.originaloverrideplayerdamage = self.overrideplayerdamage;
        }
        
        self.overrideplayerdamage = &armor_player_damage;
        self thread gadget_armor_status( slot, weapon );
    }
}

// Namespace armor
// Params 2
// Checksum 0xf72bc618, Offset: 0x8a8
// Size: 0xf0
function gadget_armor_off( slot, weapon )
{
    armoron = flagsys::get( "gadget_armor_on" );
    self notify( #"gadget_armor_off" );
    self flagsys::clear( "gadget_armor_on" );
    self.shock_onpain = 1;
    self clientfield::set( "armor_status", 0 );
    
    if ( isdefined( self.originaloverrideplayerdamage ) )
    {
        self.overrideplayerdamage = self.originaloverrideplayerdamage;
        self.originaloverrideplayerdamage = undefined;
    }
    
    if ( armoron && isalive( self ) && isdefined( level.playgadgetsuccess ) )
    {
        self [[ level.playgadgetsuccess ]]( weapon );
    }
}

// Namespace armor
// Params 2
// Checksum 0xfcda46fe, Offset: 0x9a0
// Size: 0xcc
function gadget_armor_flicker( slot, weapon )
{
    self endon( #"disconnect" );
    
    if ( !self gadget_armor_is_inuse( slot ) )
    {
        return;
    }
    
    eventtime = self._gadgets_player[ slot ].gadget_flickertime;
    self set_gadget_status( "Flickering", eventtime );
    
    while ( true )
    {
        if ( !self gadgetflickering( slot ) )
        {
            self set_gadget_status( "Normal" );
            return;
        }
        
        wait 0.5;
    }
}

// Namespace armor
// Params 2
// Checksum 0x111dc023, Offset: 0xa78
// Size: 0x9c
function set_gadget_status( status, time )
{
    timestr = "";
    
    if ( isdefined( time ) )
    {
        timestr = "^3" + ", time: " + time;
    }
    
    if ( getdvarint( "scr_cpower_debug_prints" ) > 0 )
    {
        self iprintlnbold( "Gadget Armor: " + status + timestr );
    }
}

// Namespace armor
// Params 1
// Checksum 0xedae2673, Offset: 0xb20
// Size: 0x15a
function armor_damage_type_multiplier( smeansofdeath )
{
    switch ( smeansofdeath )
    {
        case "MOD_CRUSH":
        case "MOD_DROWN":
        case "MOD_FALLING":
        case "MOD_HIT_BY_OBJECT":
        case "MOD_SUICIDE":
        case "MOD_TELEFRAG":
            return 0;
        case "MOD_PROJECTILE":
            return getdvarfloat( "scr_armor_mod_proj_mult", 1 );
        case "MOD_MELEE":
        case "MOD_MELEE_WEAPON_BUTT":
            return getdvarfloat( "scr_armor_mod_melee_mult", 2 );
        case "MOD_EXPLOSIVE":
        case "MOD_GRENADE":
        case "MOD_GRENADE_SPLASH":
        case "MOD_PROJECTILE_SPLASH":
            return getdvarfloat( "scr_armor_mod_expl_mult", 1 );
        case "MOD_PISTOL_BULLET":
        case "MOD_RIFLE_BULLET":
            return getdvarfloat( "scr_armor_mod_bullet_mult", 0.7 );
        case "MOD_BURNED":
        case "MOD_TRIGGER_HURT":
        case "MOD_UNKNOWN":
        default:
            return getdvarfloat( "scr_armor_mod_misc_mult", 1 );
    }
}

// Namespace armor
// Params 2
// Checksum 0xfda1f5b7, Offset: 0xc88
// Size: 0x8a, Type: bool
function armor_damage_mod_allowed( weapon, smeansofdeath )
{
    switch ( weapon.name )
    {
        case "hero_lightninggun":
        case "hero_lightninggun_arc":
            return false;
        default:
            break;
    }
    
    switch ( smeansofdeath )
    {
        case "MOD_BURNED":
        case "MOD_CRUSH":
        case "MOD_DROWN":
        case "MOD_EXPLOSIVE":
        case "MOD_FALLING":
        case "MOD_GRENADE":
        case "MOD_GRENADE_SPLASH":
        case "MOD_HIT_BY_OBJECT":
        case "MOD_MELEE":
        case "MOD_MELEE_WEAPON_BUTT":
        case "MOD_PROJECTILE_SPLASH":
        case "MOD_SUICIDE":
        case "MOD_TELEFRAG":
        case "MOD_TRIGGER_HURT":
        case "MOD_UNKNOWN":
            return false;
        case "MOD_PISTOL_BULLET":
        case "MOD_RIFLE_BULLET":
            return true;
        case "MOD_PROJECTILE":
            if ( weapon.explosionradius == 0 )
            {
                return true;
            }
            
            return false;
        default:
            return false;
    }
}

// Namespace armor
// Params 4
// Checksum 0x935fd1f8, Offset: 0xdc0
// Size: 0x9c, Type: bool
function armor_should_take_damage( eattacker, weapon, smeansofdeath, shitloc )
{
    if ( isdefined( eattacker ) && !weaponobjects::friendlyfirecheck( self, eattacker ) )
    {
        return false;
    }
    
    if ( !armor_damage_mod_allowed( weapon, smeansofdeath ) )
    {
        return false;
    }
    
    if ( shitloc == "head" || isdefined( shitloc ) && shitloc == "helmet" )
    {
        return false;
    }
    
    return true;
}

// Namespace armor
// Params 11
// Checksum 0x6bff7fcf, Offset: 0xe68
// Size: 0x2d0
function armor_player_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime )
{
    damage = idamage;
    self.power_armor_took_damage = 0;
    
    if ( self armor_should_take_damage( eattacker, weapon, smeansofdeath, shitloc ) && isdefined( self._gadget_armor_slot ) )
    {
        self clientfield::set_to_player( "player_damage_type", 1 );
        
        if ( self gadget_armor_is_inuse( self._gadget_armor_slot ) )
        {
            armor_damage = damage * armor_damage_type_multiplier( smeansofdeath );
            damage = 0;
            
            if ( armor_damage > 0 )
            {
                if ( isdefined( self.gadgethitpoints ) )
                {
                    hitpointsleft = self.gadgethitpoints;
                }
                else
                {
                    hitpointsleft = self gadgetpowerchange( self._gadget_armor_slot, 0 );
                }
                
                if ( weapon == level.weaponlightninggun || weapon == level.weaponlightninggunarc )
                {
                    armor_damage = hitpointsleft;
                }
                else if ( hitpointsleft < armor_damage )
                {
                    damage = armor_damage - hitpointsleft;
                }
                
                if ( isdefined( self.gadgethitpoints ) )
                {
                    self hitpoints_loss_event( armor_damage );
                }
                else
                {
                    self ability_power::power_loss_event( self._gadget_armor_slot, eattacker, armor_damage, "armor damage" );
                }
                
                self.power_armor_took_damage = 1;
                self.power_armor_last_took_damage_time = gettime();
                self addtodamageindicator( int( armor_damage * getdvarfloat( "scr_armor_mod_view_kick_mult", 0.001 ) ), vdir );
            }
        }
        else
        {
            self clientfield::set_to_player( "player_damage_type", 0 );
        }
    }
    else
    {
        self clientfield::set_to_player( "player_damage_type", 0 );
    }
    
    return damage;
}

// Namespace armor
// Params 1
// Checksum 0x5e2682ff, Offset: 0x1140
// Size: 0x2c
function hitpoints_loss_event( val )
{
    if ( val > 0 )
    {
        self.gadgethitpoints -= val;
    }
}

// Namespace armor
// Params 2
// Checksum 0x6a14ee13, Offset: 0x1178
// Size: 0x20c
function gadget_armor_status( slot, weapon )
{
    self endon( #"disconnect" );
    maxhitpoints = isdefined( weapon.gadget_max_hitpoints ) && weapon.gadget_max_hitpoints > 0 ? weapon.gadget_max_hitpoints : 100;
    
    while ( self flagsys::get( "gadget_armor_on" ) )
    {
        if ( isdefined( self.gadgethitpoints ) && self.gadgethitpoints <= 0 )
        {
            self playsoundtoplayer( "wpn_power_armor_destroyed_plr", self );
            self playsoundtoallbutplayer( "wpn_power_armor_destroyed_npc", self );
            self gadgetdeactivate( slot, weapon );
            self gadgetpowerset( slot, 0 );
            break;
        }
        
        if ( isdefined( self.gadgethitpoints ) )
        {
            hitpointsratio = self.gadgethitpoints / maxhitpoints;
        }
        else
        {
            hitpointsratio = self gadgetpowerchange( self._gadget_armor_slot, 0 ) / maxhitpoints;
        }
        
        stage = 1 + int( hitpointsratio * 5 );
        
        if ( stage > 5 )
        {
            stage = 5;
        }
        
        self clientfield::set( "armor_status", stage );
        wait 0.05;
    }
    
    self clientfield::set( "armor_status", 0 );
}

