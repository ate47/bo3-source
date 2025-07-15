#using scripts/codescripts/struct;
#using scripts/cp/_bb;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_dev;
#using scripts/cp/cybercom/_cybercom_gadget_active_camo;
#using scripts/cp/cybercom/_cybercom_gadget_cacophany;
#using scripts/cp/cybercom/_cybercom_gadget_concussive_wave;
#using scripts/cp/cybercom/_cybercom_gadget_electrostatic_strike;
#using scripts/cp/cybercom/_cybercom_gadget_exosuitbreakdown;
#using scripts/cp/cybercom/_cybercom_gadget_firefly;
#using scripts/cp/cybercom/_cybercom_gadget_forced_malfunction;
#using scripts/cp/cybercom/_cybercom_gadget_iff_override;
#using scripts/cp/cybercom/_cybercom_gadget_immolation;
#using scripts/cp/cybercom/_cybercom_gadget_misdirection;
#using scripts/cp/cybercom/_cybercom_gadget_mrpukey;
#using scripts/cp/cybercom/_cybercom_gadget_overdrive;
#using scripts/cp/cybercom/_cybercom_gadget_rapid_strike;
#using scripts/cp/cybercom/_cybercom_gadget_ravage_core;
#using scripts/cp/cybercom/_cybercom_gadget_security_breach;
#using scripts/cp/cybercom/_cybercom_gadget_sensory_overload;
#using scripts/cp/cybercom/_cybercom_gadget_servo_shortout;
#using scripts/cp/cybercom/_cybercom_gadget_smokescreen;
#using scripts/cp/cybercom/_cybercom_gadget_surge;
#using scripts/cp/cybercom/_cybercom_gadget_system_overload;
#using scripts/cp/cybercom/_cybercom_gadget_unstoppable_force;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace cybercom_gadget;

// Namespace cybercom_gadget
// Params 0
// Checksum 0xaf966d7d, Offset: 0x750
// Size: 0x154
function init()
{
    cybercom_gadget_iff_override::init();
    cybercom_gadget_security_breach::init();
    cybercom_gadget_system_overload::init();
    cybercom_gadget_servo_shortout::init();
    cybercom_gadget_exosuitbreakdown::init();
    cybercom_gadget_surge::init();
    cybercom_gadget_ravage_core::init();
    cybercom_gadget_overdrive::init();
    cybercom_gadget_unstoppable_force::init();
    cybercom_gadget_concussive_wave::init();
    cybercom_gadget_active_camo::init();
    cybercom_gadget_cacophany::init();
    cybercom_gadget_rapid_strike::init();
    cybercom_gadget_immolation::init();
    cybercom_gadget_sensory_overload::init();
    cybercom_gadget_forced_malfunction::init();
    cybercom_gadget_firefly::init();
    cybercom_gadget_smokescreen::init();
    cybercom_gadget_misdirection::init();
    cybercom_gadget_electrostatic_strike::init();
    cybercom_gadget_mrpukey::init();
}

// Namespace cybercom_gadget
// Params 0
// Checksum 0x7591850a, Offset: 0x8b0
// Size: 0x194
function main()
{
    callback::on_connect( &on_player_connect );
    callback::on_spawned( &on_player_spawned );
    cybercom_gadget_system_overload::main();
    cybercom_gadget_exosuitbreakdown::main();
    cybercom_gadget_surge::main();
    cybercom_gadget_iff_override::main();
    cybercom_gadget_security_breach::main();
    cybercom_gadget_servo_shortout::main();
    cybercom_gadget_ravage_core::main();
    cybercom_gadget_overdrive::main();
    cybercom_gadget_smokescreen::main();
    cybercom_gadget_forced_malfunction::main();
    cybercom_gadget_active_camo::main();
    cybercom_gadget_concussive_wave::main();
    cybercom_gadget_unstoppable_force::main();
    cybercom_gadget_rapid_strike::main();
    cybercom_gadget_sensory_overload::main();
    cybercom_gadget_misdirection::main();
    cybercom_gadget_cacophany::main();
    cybercom_gadget_mrpukey::main();
    cybercom_gadget_firefly::main();
    cybercom_gadget_immolation::main();
    cybercom_gadget_electrostatic_strike::main();
}

// Namespace cybercom_gadget
// Params 0
// Checksum 0x78f4b70c, Offset: 0xa50
// Size: 0x1c
function on_player_connect()
{
    self thread function_48868896();
}

// Namespace cybercom_gadget
// Params 0
// Checksum 0x2c271fd7, Offset: 0xa78
// Size: 0x1c
function on_player_spawned()
{
    self thread function_12bffd86();
}

// Namespace cybercom_gadget
// Params 0
// Checksum 0xb6388276, Offset: 0xaa0
// Size: 0x190
function function_12bffd86()
{
    self notify( #"hash_12bffd86" );
    self endon( #"hash_12bffd86" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        ret = self util::waittill_any_return( "cybercom_activation_failed", "cybercom_activation_succeeded" );
        
        if ( !isdefined( ret ) )
        {
            continue;
        }
        
        if ( !isdefined( self.cybercom.activecybercomweapon ) )
        {
            continue;
        }
        
        ability = function_1a6a2760( self.cybercom.activecybercomweapon );
        upgraded = self hascybercomability( ability.name ) == 2;
        
        if ( ret == "cybercom_activation_succeeded" )
        {
            alias = "gdt_cybercore_activate" + ( isdefined( upgraded ) && upgraded ? "_upgraded" : "" );
        }
        else
        {
            alias = "gdt_cybercore_activate_fail";
        }
        
        if ( !( isdefined( ability.passive ) && ability.passive ) )
        {
            self playsound( alias );
        }
    }
}

// Namespace cybercom_gadget
// Params 3
// Checksum 0x3998c94e, Offset: 0xc38
// Size: 0x15e
function registerability( type, flag, passive )
{
    if ( !isdefined( passive ) )
    {
        passive = 0;
    }
    
    if ( !isdefined( level.cybercom ) )
    {
        cybercom::initialize();
    }
    
    if ( getabilitybyflag( type, flag ) == undefined )
    {
        ability = spawnstruct();
        ability.type = type;
        ability.flag = flag;
        ability.passive = passive;
        ability.name = getcybercomabilityname( type, flag );
        ability.weapon = getcybercomweapon( type, flag, 0 );
        ability.weaponupgraded = getcybercomweapon( type, flag, 1 );
        level.cybercom.abilities[ level.cybercom.abilities.size ] = ability;
    }
}

// Namespace cybercom_gadget
// Params 1
// Checksum 0x11e6971, Offset: 0xda0
// Size: 0xb0, Type: bool
function ismeleeability( ability )
{
    if ( isdefined( ability ) )
    {
        if ( ability.type == 1 && ability.flag == 64 )
        {
            return true;
        }
        
        if ( ability.type == 2 && ability.flag == 2 )
        {
            return true;
        }
        
        if ( ability.type == 0 && ability.flag == 16 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace cybercom_gadget
// Params 2
// Checksum 0x15ee666f, Offset: 0xe58
// Size: 0x1d8
function meleeabilitygiven( ability, upgrade )
{
    if ( !isdefined( ability ) )
    {
        return;
    }
    
    if ( !ismeleeability( ability ) )
    {
        return;
    }
    
    if ( !isdefined( upgrade ) )
    {
        status = self hascybercomability( ability.name );
        
        if ( status == 0 )
        {
            return;
        }
        
        upgrade = status == 2;
    }
    
    if ( upgrade )
    {
        weapon = ability.weaponupgraded;
    }
    else
    {
        weapon = ability.weapon;
    }
    
    if ( isdefined( self.cybercom.activecybercommeleeweapon ) && self.cybercom.activecybercommeleeweapon != weapon )
    {
        self takeweapon( self.cybercom.activecybercommeleeweapon );
        self notify( #"weapon_taken", self.cybercom.activecybercommeleeweapon );
        level notify( #"weapon_taken", self.cybercom.activecybercommeleeweapon, self );
        self.cybercom.activecybercommeleeweapon = undefined;
    }
    
    if ( !self hasweapon( weapon ) )
    {
        self giveweapon( weapon );
        self notify( #"weapon_given", weapon );
        level notify( #"weapon_given", weapon, self );
    }
    
    self.cybercom.activecybercommeleeweapon = weapon;
}

// Namespace cybercom_gadget
// Params 1
// Checksum 0xe590a98c, Offset: 0x1038
// Size: 0x22a
function abilitytaken( ability )
{
    if ( !isdefined( ability ) )
    {
        return;
    }
    
    if ( self hasweapon( ability.weapon ) )
    {
        self takeweapon( ability.weapon );
        self notify( #"weapon_taken", ability.weapon );
        level notify( #"weapon_taken", ability.weapon, self );
    }
    
    if ( isdefined( self.cybercom.activecybercommeleeweapon ) && self.cybercom.activecybercommeleeweapon == ability.weapon )
    {
        self.cybercom.activecybercommeleeweapon = undefined;
    }
    
    if ( isdefined( self.cybercom.activecybercomweapon ) && self.cybercom.activecybercomweapon == ability.weapon )
    {
        self.cybercom.activecybercomweapon = undefined;
    }
    
    if ( self hasweapon( ability.weaponupgraded ) )
    {
        self takeweapon( ability.weaponupgraded );
        self notify( #"weapon_taken", ability.weaponupgraded );
        level notify( #"weapon_taken", ability.weaponupgraded, self );
    }
    
    if ( isdefined( self.cybercom.activecybercommeleeweapon ) && self.cybercom.activecybercommeleeweapon == ability.weaponupgraded )
    {
        self.cybercom.activecybercommeleeweapon = undefined;
    }
    
    if ( isdefined( self.cybercom.activecybercomweapon ) && self.cybercom.activecybercomweapon == ability.weaponupgraded )
    {
        self.cybercom.activecybercomweapon = undefined;
    }
}

// Namespace cybercom_gadget
// Params 2
// Checksum 0xc5cfe761, Offset: 0x1270
// Size: 0xd4
function giveability( name, upgrade )
{
    assert( getdvarint( "<dev string:x28>" ), "<dev string:x39>" );
    ability = getabilitybyname( name );
    
    if ( !isdefined( ability ) )
    {
        return;
    }
    
    self setcybercomability( name, upgrade );
    self cybercom::updatecybercomflags();
    self meleeabilitygiven( ability, upgrade );
}

// Namespace cybercom_gadget
// Params 0
// Checksum 0xe4cd7446, Offset: 0x1350
// Size: 0xa2
function function_edff667f()
{
    foreach ( ability in level.cybercom.abilities )
    {
        self giveability( ability.name, 1 );
    }
}

// Namespace cybercom_gadget
// Params 2
// Checksum 0x9a5868f6, Offset: 0x1400
// Size: 0x598
function equipability( name, var_a67a6c08 )
{
    if ( !isdefined( var_a67a6c08 ) )
    {
        var_a67a6c08 = 0;
    }
    
    assert( getdvarint( "<dev string:x28>" ), "<dev string:x78>" );
    abilitystatus = self hascybercomability( name );
    
    if ( abilitystatus == 0 )
    {
        return;
    }
    
    ability = getabilitybyname( name );
    
    if ( !isdefined( ability ) )
    {
        return;
    }
    
    self.cybercom.flags.type = ability.type;
    self setcybercomactivetype( ability.type );
    self.cybercom.lastequipped = ability;
    
    if ( abilitystatus == 2 )
    {
        weapon = ability.weaponupgraded;
    }
    else
    {
        weapon = ability.weapon;
    }
    
    if ( !ismeleeability( ability ) )
    {
        if ( isdefined( self.cybercom.activecybercommeleeweapon ) && self hasweapon( self.cybercom.activecybercommeleeweapon ) )
        {
            var_7116dac7 = self.cybercom.activecybercommeleeweapon;
            self takeweapon( self.cybercom.activecybercommeleeweapon );
            self.cybercom.activecybercommeleeweapon = undefined;
        }
        
        if ( isdefined( self.cybercom.activecybercomweapon ) && weapon != self.cybercom.activecybercomweapon )
        {
            self takeweapon( self.cybercom.activecybercomweapon );
            self notify( #"weapon_taken", self.cybercom.activecybercomweapon );
            level notify( #"weapon_taken", self.cybercom.activecybercomweapon, self );
        }
        
        if ( !self hasweapon( weapon ) )
        {
            self giveweapon( weapon );
            self notify( #"weapon_given", weapon );
            level notify( #"weapon_given", weapon, self );
        }
        
        self.cybercom.activecybercomweapon = weapon;
        
        if ( !( isdefined( self.cybercom.given_first_ability ) && self.cybercom.given_first_ability ) )
        {
            var_a67a6c08 = 1;
            self.cybercom.given_first_ability = 1;
        }
        
        if ( isdefined( var_7116dac7 ) )
        {
            self giveweapon( var_7116dac7 );
            self.cybercom.activecybercommeleeweapon = var_7116dac7;
            var_7116dac7 = undefined;
        }
        
        abilities = getabilitiesfortype( self.cybercom.lastequipped.type );
        abilityindex = 1;
        
        foreach ( ability in abilities )
        {
            if ( ability.name == self.cybercom.lastequipped.name )
            {
                self setcontrolleruimodelvalue( "AbilityWheel.Selected" + ability.type + 1, abilityindex );
                break;
            }
            
            abilityindex++;
        }
    }
    
    self sortheldweapons();
    
    if ( var_a67a6c08 )
    {
        self thread function_cae3643b();
    }
    
    bb::logcybercomevent( self, "equipped", name );
    var_6f5af609 = int( tablelookup( "gamedata/stats/cp/cp_statstable.csv", 4, ability.name, 0 ) );
    
    if ( isdefined( self.var_768ee804 ) )
    {
        var_6f5af609 |= self.var_768ee804 << 10;
    }
    
    self setdstat( "PlayerStatsList", "LAST_CYBERCOM_EQUIPPED", "statValue", var_6f5af609 );
    return ability;
}

// Namespace cybercom_gadget
// Params 0, eflags: 0x4
// Checksum 0xffa8b90b, Offset: 0x19a0
// Size: 0x64
function private function_cae3643b()
{
    waittillframeend();
    self gadgetpowerset( 0, 100 );
    self gadgetpowerset( 1, 100 );
    self gadgetpowerset( 2, 100 );
}

// Namespace cybercom_gadget
// Params 0
// Checksum 0x63db31ca, Offset: 0x1a10
// Size: 0x1b4
function takeallabilities()
{
    abilities = self getavailableabilities();
    
    foreach ( ability in abilities )
    {
        self abilitytaken( ability );
    }
    
    self clearcybercomability();
    
    if ( isdefined( self.cybercom.activecybercomweapon ) && self hasweapon( self.cybercom.activecybercomweapon ) )
    {
        self takeweapon( self.cybercom.activecybercomweapon );
    }
    
    self.cybercom.activecybercomweapon = undefined;
    
    if ( isdefined( self.cybercom.activecybercommeleeweapon ) && self hasweapon( self.cybercom.activecybercommeleeweapon ) )
    {
        self takeweapon( self.cybercom.activecybercommeleeweapon );
    }
    
    self.cybercom.activecybercommeleeweapon = undefined;
    self cybercom::updatecybercomflags();
}

// Namespace cybercom_gadget
// Params 1
// Checksum 0xf0637d4d, Offset: 0x1bd0
// Size: 0xb0
function getabilitybyname( name )
{
    foreach ( ability in level.cybercom.abilities )
    {
        if ( !isdefined( ability ) )
        {
            continue;
        }
        
        if ( ability.name == name )
        {
            return ability;
        }
    }
}

// Namespace cybercom_gadget
// Params 1
// Checksum 0x37742727, Offset: 0x1c88
// Size: 0xe8
function getabilitybyweaponname( name )
{
    weapon = getweapon( name );
    
    foreach ( ability in level.cybercom.abilities )
    {
        if ( isdefined( ability.weapon ) && weapon.name == ability.weapon.name )
        {
            return ability;
        }
    }
}

// Namespace cybercom_gadget
// Params 1
// Checksum 0x71d7db1c, Offset: 0x1d78
// Size: 0xf0
function function_1a6a2760( weapon )
{
    if ( !isdefined( weapon ) )
    {
        return;
    }
    
    foreach ( ability in level.cybercom.abilities )
    {
        if ( isdefined( ability.weapon ) && weapon == ability.weapon )
        {
            return ability;
        }
        
        if ( isdefined( ability.weaponupgraded ) && weapon == ability.weaponupgraded )
        {
            return ability;
        }
    }
}

// Namespace cybercom_gadget
// Params 2
// Checksum 0x1251879e, Offset: 0x1e70
// Size: 0xc2
function getabilitybyflag( type, flag )
{
    foreach ( ability in level.cybercom.abilities )
    {
        if ( ability.type == type && ability.flag == flag )
        {
            return ability;
        }
    }
    
    return undefined;
}

// Namespace cybercom_gadget
// Params 0
// Checksum 0x640646c9, Offset: 0x1f40
// Size: 0x128
function getavailableabilities()
{
    abilities = [];
    
    if ( !isdefined( self.cybercom ) || !isdefined( self.cybercom.flags ) || !isdefined( self.cybercom.flags.type ) )
    {
        return abilities;
    }
    
    foreach ( ability in level.cybercom.abilities )
    {
        ccomabilitystatus = self hascybercomability( ability.name );
        
        if ( ccomabilitystatus != 0 )
        {
            abilities[ abilities.size ] = ability;
        }
    }
    
    return abilities;
}

// Namespace cybercom_gadget
// Params 1
// Checksum 0x4eff8b57, Offset: 0x2070
// Size: 0xc0
function getabilitiesfortype( type )
{
    abilities = [];
    
    foreach ( ability in level.cybercom.abilities )
    {
        if ( ability.type == type )
        {
            abilities[ abilities.size ] = ability;
        }
    }
    
    return abilities;
}

// Namespace cybercom_gadget
// Params 0
// Checksum 0x722b1fb5, Offset: 0x2138
// Size: 0x50
function function_48868896()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"setcybercomability", var_4ccb808f );
        self equipability( var_4ccb808f );
    }
}

