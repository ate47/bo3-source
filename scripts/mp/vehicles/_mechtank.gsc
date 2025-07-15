#using scripts/codescripts/struct;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/ai/blackboard_vehicle;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/clientfield_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/gameskill_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;

#namespace mechtank;

// Namespace mechtank
// Params 0, eflags: 0x2
// Checksum 0x9dc80ec0, Offset: 0x3a8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "mechtank", &__init__, undefined, undefined );
}

// Namespace mechtank
// Params 0
// Checksum 0x7b844efa, Offset: 0x3e8
// Size: 0x2c
function __init__()
{
    vehicle::add_main_callback( "mechtank", &mechtank_initialize );
}

#using_animtree( "generic" );

// Namespace mechtank
// Params 0
// Checksum 0x7e3e68f5, Offset: 0x420
// Size: 0x12c
function mechtank_initialize()
{
    self useanimtree( #animtree );
    self.targetoffset = ( 0, 0, 60 );
    self enableaimassist();
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.maxsightdistsqrd = 10000 * 10000;
    self.allow_movement = 1;
    assert( isdefined( self.scriptbundlesettings ) );
    self.settings = struct::get_script_bundle( "vehiclecustomsettings", self.scriptbundlesettings );
    self.overridevehicledamage = &mechtankcallback_vehicledamage;
    killstreak_bundles::register_killstreak_bundle( "mechtank" );
    self.maxhealth = killstreak_bundles::get_max_health( "mechtank" );
    self.heatlh = self.maxhealth;
}

// Namespace mechtank
// Params 15
// Checksum 0xb9c7c6e3, Offset: 0x558
// Size: 0x210
function mechtankcallback_vehicledamage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    if ( isplayer( eattacker ) && eattacker.usingvehicle && ( eattacker == self || isdefined( eattacker ) && eattacker.viewlockedentity === self ) )
    {
        return 0;
    }
    
    if ( smeansofdeath === "MOD_MELEE" || smeansofdeath === "MOD_MELEE_WEAPON_BUTT" || smeansofdeath === "MOD_MELEE_ASSASSINATE" || smeansofdeath === "MOD_ELECTROCUTED" || smeansofdeath === "MOD_CRUSH" || weapon.isemp )
    {
        return 0;
    }
    
    idamage = self killstreaks::ondamageperweapon( "mechtank", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, 0, undefined, 1, 1 );
    driver = self getseatoccupant( 0 );
    
    if ( isplayer( driver ) )
    {
        driver vehicle::update_damage_as_occupant( self.maxhealth - self.health - idamage, self.maxhealth );
    }
    
    return idamage;
}

