#using scripts/codescripts/struct;
#using scripts/cp/_challenges;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/destructible_character;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicles/_amws;

#namespace cybercom_gadget_servo_shortout;

// Namespace cybercom_gadget_servo_shortout
// Params 0
// Checksum 0x99ec1590, Offset: 0x570
// Size: 0x4
function init()
{
    
}

// Namespace cybercom_gadget_servo_shortout
// Params 0
// Checksum 0x9f4b1a34, Offset: 0x580
// Size: 0x198
function main()
{
    cybercom_gadget::registerability( 0, 2 );
    level.cybercom.servo_shortout = spawnstruct();
    level.cybercom.servo_shortout._is_flickering = &_is_flickering;
    level.cybercom.servo_shortout._on_flicker = &_on_flicker;
    level.cybercom.servo_shortout._on_give = &_on_give;
    level.cybercom.servo_shortout._on_take = &_on_take;
    level.cybercom.servo_shortout._on_connect = &_on_connect;
    level.cybercom.servo_shortout._on = &_on;
    level.cybercom.servo_shortout._off = &_off;
    level.cybercom.servo_shortout._is_primed = &_is_primed;
    level.cybercom.servo_shortout.gibcounter = 0;
}

// Namespace cybercom_gadget_servo_shortout
// Params 1
// Checksum 0xce370c6e, Offset: 0x720
// Size: 0xc
function _is_flickering( slot )
{
    
}

// Namespace cybercom_gadget_servo_shortout
// Params 2
// Checksum 0x10c8c282, Offset: 0x738
// Size: 0x14
function _on_flicker( slot, weapon )
{
    
}

// Namespace cybercom_gadget_servo_shortout
// Params 2
// Checksum 0x976b2fe4, Offset: 0x758
// Size: 0xf4
function _on_give( slot, weapon )
{
    self.cybercom.var_110c156a = getdvarint( "scr_servo_shortout_count", 2 );
    
    if ( self hascybercomability( "cybercom_servoshortout" ) == 2 )
    {
        self.cybercom.var_110c156a = getdvarint( "scr_servo_shortout_upgraded_count", 3 );
    }
    
    self.cybercom.targetlockcb = &_get_valid_targets;
    self.cybercom.targetlockrequirementcb = &_lock_requirement;
    self thread cybercom::function_b5f4e597( weapon );
}

// Namespace cybercom_gadget_servo_shortout
// Params 2
// Checksum 0xadf1c12, Offset: 0x858
// Size: 0x52
function _on_take( slot, weapon )
{
    self _off( slot, weapon );
    self.cybercom.targetlockcb = undefined;
    self.cybercom.targetlockrequirementcb = undefined;
}

// Namespace cybercom_gadget_servo_shortout
// Params 0
// Checksum 0x99ec1590, Offset: 0x8b8
// Size: 0x4
function _on_connect()
{
    
}

// Namespace cybercom_gadget_servo_shortout
// Params 2
// Checksum 0xb9fddf5, Offset: 0x8c8
// Size: 0x54
function _on( slot, weapon )
{
    self thread _activate_servo_shortout( slot, weapon );
    self _off( slot, weapon );
}

// Namespace cybercom_gadget_servo_shortout
// Params 2
// Checksum 0xfc70e955, Offset: 0x928
// Size: 0x3a
function _off( slot, weapon )
{
    self thread cybercom::weaponendlockwatcher( weapon );
    self.cybercom.is_primed = undefined;
}

// Namespace cybercom_gadget_servo_shortout
// Params 2
// Checksum 0xc44c6a97, Offset: 0x970
// Size: 0xa8
function _is_primed( slot, weapon )
{
    if ( !( isdefined( self.cybercom.is_primed ) && self.cybercom.is_primed ) )
    {
        assert( self.cybercom.activecybercomweapon == weapon );
        self thread cybercom::weaponlockwatcher( slot, weapon, self.cybercom.var_110c156a );
        self.cybercom.is_primed = 1;
    }
}

// Namespace cybercom_gadget_servo_shortout
// Params 1, eflags: 0x4
// Checksum 0xddb3e14d, Offset: 0xa20
// Size: 0x268, Type: bool
function private _lock_requirement( target )
{
    if ( target cybercom::cybercom_aicheckoptout( "cybercom_servoshortout" ) )
    {
        self cybercom::function_29bf9dee( target, 2 );
        return false;
    }
    
    if ( isdefined( target.hijacked ) && target.hijacked )
    {
        self cybercom::function_29bf9dee( target, 4 );
        return false;
    }
    
    if ( isdefined( target.is_disabled ) && target.is_disabled )
    {
        self cybercom::function_29bf9dee( target, 6 );
        return false;
    }
    
    if ( !isdefined( target.archetype ) )
    {
        self cybercom::function_29bf9dee( target, 2 );
        return false;
    }
    
    if ( isactor( target ) && target cybercom::getentitypose() != "stand" && target cybercom::getentitypose() != "crouch" )
    {
        return false;
    }
    
    if ( isactor( target ) && target.archetype != "robot" )
    {
        self cybercom::function_29bf9dee( target, 2 );
        return false;
    }
    
    if ( !isactor( target ) && !isvehicle( target ) )
    {
        self cybercom::function_29bf9dee( target, 2 );
        return false;
    }
    
    if ( isactor( target ) && !target isonground() && !target cybercom::function_421746e0() )
    {
        return false;
    }
    
    return true;
}

// Namespace cybercom_gadget_servo_shortout
// Params 1, eflags: 0x4
// Checksum 0xf135bfad, Offset: 0xc90
// Size: 0x52
function private _get_valid_targets( weapon )
{
    return arraycombine( getaiteamarray( "axis" ), getaiteamarray( "team3" ), 0, 0 );
}

// Namespace cybercom_gadget_servo_shortout
// Params 2, eflags: 0x4
// Checksum 0xbe0267f1, Offset: 0xcf0
// Size: 0x394
function private _activate_servo_shortout( slot, weapon )
{
    var_98c55a0e = 0;
    upgraded = self hascybercomability( "cybercom_servoshortout" ) == 2;
    aborted = 0;
    fired = 0;
    
    foreach ( item in self.cybercom.lock_targets )
    {
        if ( isdefined( item.inrange ) && isdefined( item.target ) && item.inrange )
        {
            if ( item.inrange == 1 )
            {
                if ( !cybercom::targetisvalid( item.target, weapon ) )
                {
                    continue;
                }
                
                self thread challenges::function_96ed590f( "cybercom_uses_control" );
                
                if ( !var_98c55a0e && randomint( 100 ) < ( upgraded ? getdvarint( "scr_servo_killchance_upgraded", 30 ) : getdvarint( "scr_servo_killchance", 15 ) ) )
                {
                    item.target thread servo_shortout( self, undefined, upgraded, 1 );
                    var_98c55a0e = 1;
                }
                else
                {
                    item.target thread servo_shortout( self, undefined, upgraded, 0 );
                }
                
                fired++;
                continue;
            }
            
            if ( item.inrange == 2 )
            {
                aborted++;
            }
        }
    }
    
    if ( aborted && !fired )
    {
        self.cybercom.lock_targets = [];
        self cybercom::function_29bf9dee( undefined, 1, 0 );
    }
    
    cybercom::function_adc40f11( weapon, fired );
    
    if ( fired && isplayer( self ) )
    {
        itemindex = getitemindexfromref( "cybercom_servoshortout" );
        
        if ( isdefined( itemindex ) )
        {
            self adddstat( "ItemStats", itemindex, "stats", "assists", "statValue", fired );
            self adddstat( "ItemStats", itemindex, "stats", "used", "statValue", 1 );
        }
    }
}

// Namespace cybercom_gadget_servo_shortout
// Params 0, eflags: 0x4
// Checksum 0xb1ee8c00, Offset: 0x1090
// Size: 0x38
function private _update_gib_position()
{
    level.cybercom.servo_shortout.gibcounter++;
    return level.cybercom.servo_shortout.gibcounter % 3;
}

// Namespace cybercom_gadget_servo_shortout
// Params 3
// Checksum 0xa3567179, Offset: 0x10d0
// Size: 0x274
function servo_shortoutvehicle( attacker, upgraded, weapon )
{
    self endon( #"death" );
    self clientfield::set( "cybercom_shortout", upgraded ? 2 : 1 );
    util::wait_network_frame();
    wait 0.5;
    
    if ( issubstr( self.vehicletype, "wasp" ) )
    {
        if ( isalive( self ) )
        {
            self.death_type = "gibbed";
            self kill( self.origin, isdefined( attacker ) ? attacker : undefined, undefined, weapon );
        }
        
        return;
    }
    
    if ( issubstr( self.vehicletype, "raps" ) )
    {
        self.servershortout = 1;
        self thread function_a61788ff();
        self dodamage( 1, self.origin, isdefined( attacker ) ? attacker : undefined, undefined, "none", "MOD_ELECTROCUTED" );
        return;
    }
    
    if ( issubstr( self.vehicletype, "amws" ) )
    {
        if ( isalive( self ) )
        {
            self amws::gib( attacker );
        }
        
        return;
    }
    
    dmg = int( self.healthdefault * 0.1 );
    self dodamage( dmg, self.origin, isdefined( attacker ) ? attacker : undefined, undefined, "none", "MOD_GRENADE_SPLASH", 0, getweapon( "emp_grenade" ), -1, 1 );
}

// Namespace cybercom_gadget_servo_shortout
// Params 0
// Checksum 0x9ecf3df, Offset: 0x1350
// Size: 0x1c
function function_a61788ff()
{
    self stopsounds();
}

// Namespace cybercom_gadget_servo_shortout
// Params 5
// Checksum 0x34e94970, Offset: 0x1378
// Size: 0x368
function servo_shortout( attacker, weapon, upgraded, var_66a2f0cf, damage )
{
    if ( !isdefined( damage ) )
    {
        damage = 2;
    }
    
    self endon( #"death" );
    
    if ( !isdefined( weapon ) )
    {
        weapon = getweapon( "gadget_servo_shortout" );
    }
    
    self notify( #"cybercom_action", weapon, attacker );
    
    if ( isvehicle( self ) )
    {
        self thread servo_shortoutvehicle( attacker, upgraded, weapon );
        return;
    }
    
    assert( self.archetype == "<dev string:x28>" );
    self clientfield::set( "cybercom_shortout", 1 );
    
    if ( !cybercom::function_76e3026d( self ) )
    {
        self kill( self.origin, isdefined( attacker ) ? attacker : undefined, undefined, weapon );
        return;
    }
    
    if ( self cybercom::function_421746e0() )
    {
        self kill( self.origin, isdefined( attacker ) ? attacker : undefined, undefined, weapon );
        return;
    }
    
    wait randomfloatrange( 0, 0.35 );
    self.is_disabled = 1;
    self dodamage( damage, self.origin, isdefined( attacker ) ? attacker : undefined, undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1 );
    time = randomfloatrange( 0.8, 2.1 );
    
    for ( i = 0; i < 2 ; i++ )
    {
        destructserverutils::destructnumberrandompieces( self, randomintrange( 1, 3 ) );
        wait time / 3;
    }
    
    if ( isalive( self ) )
    {
        if ( isdefined( var_66a2f0cf ) && var_66a2f0cf )
        {
            self kill( self.origin, isdefined( attacker ) ? attacker : undefined, undefined, weapon );
            return;
        }
        
        self clientfield::set( "cybercom_shortout", 2 );
        self ai::set_behavior_attribute( "force_crawler", "gib_legs" );
        self.is_disabled = 0;
    }
}

// Namespace cybercom_gadget_servo_shortout
// Params 2
// Checksum 0xf5ef8e7a, Offset: 0x16e8
// Size: 0x2ba
function ai_activateservoshortout( target, var_9bc2efcb )
{
    if ( !isdefined( var_9bc2efcb ) )
    {
        var_9bc2efcb = 1;
    }
    
    if ( !isdefined( target ) )
    {
        return;
    }
    
    if ( self.archetype != "human" )
    {
        return;
    }
    
    validtargets = [];
    
    if ( isarray( target ) )
    {
        foreach ( guy in target )
        {
            if ( !_lock_requirement( guy ) )
            {
                continue;
            }
            
            validtargets[ validtargets.size ] = guy;
        }
    }
    else
    {
        if ( !_lock_requirement( target ) )
        {
            return;
        }
        
        validtargets[ validtargets.size ] = target;
    }
    
    if ( isdefined( var_9bc2efcb ) && var_9bc2efcb )
    {
        type = self cybercom::function_5e3d3aa();
        self orientmode( "face default" );
        self animscripted( "ai_cybercom_anim", self.origin, self.angles, "ai_base_rifle_" + type + "_exposed_cybercom_activate" );
        self waittillmatch( #"ai_cybercom_anim", "fire" );
    }
    
    weapon = getweapon( "gadget_servo_shortout" );
    
    foreach ( guy in validtargets )
    {
        if ( !cybercom::targetisvalid( guy, weapon ) )
        {
            continue;
        }
        
        guy thread servo_shortout( self );
        wait 0.05;
    }
}

