#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weaponobjects;

#namespace acousticsensor;

// Namespace acousticsensor
// Params 0
// Checksum 0xeffdb9b0, Offset: 0x280
// Size: 0x5c
function init_shared()
{
    level._effect[ "acousticsensor_enemy_light" ] = "_t6/misc/fx_equip_light_red";
    level._effect[ "acousticsensor_friendly_light" ] = "_t6/misc/fx_equip_light_green";
    callback::add_weapon_watcher( &createacousticsensorwatcher );
}

// Namespace acousticsensor
// Params 0
// Checksum 0xa24f1a71, Offset: 0x2e8
// Size: 0xc0
function createacousticsensorwatcher()
{
    watcher = self weaponobjects::createuseweaponobjectwatcher( "acoustic_sensor", self.team );
    watcher.onspawn = &onspawnacousticsensor;
    watcher.ondetonatecallback = &acousticsensordetonate;
    watcher.stun = &weaponobjects::weaponstun;
    watcher.stuntime = 5;
    watcher.hackable = 1;
    watcher.ondamage = &watchacousticsensordamage;
}

// Namespace acousticsensor
// Params 2
// Checksum 0x8b5d3bd7, Offset: 0x3b0
// Size: 0x10c
function onspawnacousticsensor( watcher, player )
{
    self endon( #"death" );
    self thread weaponobjects::onspawnuseweaponobject( watcher, player );
    player.acousticsensor = self;
    self setowner( player );
    self setteam( player.team );
    self.owner = player;
    self playloopsound( "fly_acoustic_sensor_lp" );
    
    if ( !self util::ishacked() )
    {
        player addweaponstat( self.weapon, "used", 1 );
    }
    
    self thread watchshutdown( player, self.origin );
}

// Namespace acousticsensor
// Params 3
// Checksum 0xe3739fa, Offset: 0x4c8
// Size: 0x104
function acousticsensordetonate( attacker, weapon, target )
{
    if ( !isdefined( weapon ) || !weapon.isemp )
    {
        playfx( level._equipment_explode_fx, self.origin );
    }
    
    if ( isdefined( attacker ) )
    {
        if ( self.owner util::isenemyplayer( attacker ) )
        {
            attacker challenges::destroyedequipment( weapon );
            scoreevents::processscoreevent( "destroyed_motion_sensor", attacker, self.owner, weapon );
        }
    }
    
    playsoundatposition( "dst_equipment_destroy", self.origin );
    self destroyent();
}

// Namespace acousticsensor
// Params 0
// Checksum 0x8135d255, Offset: 0x5d8
// Size: 0x1c
function destroyent()
{
    self delete();
}

// Namespace acousticsensor
// Params 2
// Checksum 0x9939efbf, Offset: 0x600
// Size: 0x52
function watchshutdown( player, origin )
{
    self util::waittill_any( "death", "hacked" );
    
    if ( isdefined( player ) )
    {
        player.acousticsensor = undefined;
    }
}

// Namespace acousticsensor
// Params 1
// Checksum 0x8499f6b3, Offset: 0x660
// Size: 0x38a
function watchacousticsensordamage( watcher )
{
    self endon( #"death" );
    self endon( #"hacked" );
    self setcandamage( 1 );
    damagemax = 100;
    
    if ( !self util::ishacked() )
    {
        self.damagetaken = 0;
    }
    
    while ( true )
    {
        self.maxhealth = 100000;
        self.health = self.maxhealth;
        self waittill( #"damage", damage, attacker, direction, point, type, tagname, modelname, partname, weapon, idflags );
        
        if ( !isdefined( attacker ) || !isplayer( attacker ) )
        {
            continue;
        }
        
        if ( level.teambased && attacker.team == self.owner.team && attacker != self.owner )
        {
            continue;
        }
        
        if ( watcher.stuntime > 0 && weapon.dostun )
        {
            self thread weaponobjects::stunstart( watcher, watcher.stuntime );
        }
        
        if ( weapon.dodamagefeedback )
        {
            if ( level.teambased && self.owner.team != attacker.team )
            {
                if ( damagefeedback::dodamagefeedback( weapon, attacker ) )
                {
                    attacker damagefeedback::update();
                }
            }
            else if ( !level.teambased && self.owner != attacker )
            {
                if ( damagefeedback::dodamagefeedback( weapon, attacker ) )
                {
                    attacker damagefeedback::update();
                }
            }
        }
        
        if ( isplayer( attacker ) && level.teambased && isdefined( attacker.team ) && self.owner.team == attacker.team && attacker != self.owner )
        {
            continue;
        }
        
        if ( type == "MOD_MELEE" || weapon.isemp )
        {
            self.damagetaken = damagemax;
        }
        else
        {
            self.damagetaken += damage;
        }
        
        if ( self.damagetaken >= damagemax )
        {
            watcher thread weaponobjects::waitanddetonate( self, 0, attacker, weapon );
            return;
        }
    }
}

