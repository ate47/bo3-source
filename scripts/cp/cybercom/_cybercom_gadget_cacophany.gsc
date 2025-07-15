#using scripts/codescripts/struct;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/math_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace cybercom_gadget_cacophany;

// Namespace cybercom_gadget_cacophany
// Params 0
// Checksum 0x99ec1590, Offset: 0x350
// Size: 0x4
function init()
{
    
}

// Namespace cybercom_gadget_cacophany
// Params 0
// Checksum 0x92f8397b, Offset: 0x360
// Size: 0x17c
function main()
{
    cybercom_gadget::registerability( 2, 16 );
    level.cybercom.cacophany = spawnstruct();
    level.cybercom.cacophany._is_flickering = &_is_flickering;
    level.cybercom.cacophany._on_flicker = &_on_flicker;
    level.cybercom.cacophany._on_give = &_on_give;
    level.cybercom.cacophany._on_take = &_on_take;
    level.cybercom.cacophany._on_connect = &_on_connect;
    level.cybercom.cacophany._on = &_on;
    level.cybercom.cacophany._off = &_off;
    level.cybercom.cacophany._is_primed = &_is_primed;
}

// Namespace cybercom_gadget_cacophany
// Params 1
// Checksum 0x245bfe36, Offset: 0x4e8
// Size: 0xc
function _is_flickering( slot )
{
    
}

// Namespace cybercom_gadget_cacophany
// Params 2
// Checksum 0x57427223, Offset: 0x500
// Size: 0x14
function _on_flicker( slot, weapon )
{
    
}

// Namespace cybercom_gadget_cacophany
// Params 2
// Checksum 0x220d8889, Offset: 0x520
// Size: 0x1b4
function _on_give( slot, weapon )
{
    self.cybercom.var_110c156a = getdvarint( "scr_cacophany_count", 4 );
    self.cybercom.var_f72b478f = getdvarfloat( "scr_cacophany_fov", 0.95 );
    self.cybercom.var_23d4a73a = getdvarfloat( "scr_cacophany_lock_radius", 330 );
    
    if ( self hascybercomability( "cybercom_cacophany" ) == 2 )
    {
        self.cybercom.var_110c156a = getdvarint( "scr_cacophany_upgraded_count", 5 );
        self.cybercom.var_f72b478f = getdvarfloat( "scr_cacophany_upgraded_fov", 0.5 );
        self.cybercom.var_23d4a73a = getdvarfloat( "scr_cacophany_lock_radius", 330 );
    }
    
    self.cybercom.targetlockcb = &_get_valid_targets;
    self.cybercom.targetlockrequirementcb = &_lock_requirement;
    self thread cybercom::function_b5f4e597( weapon );
}

// Namespace cybercom_gadget_cacophany
// Params 2
// Checksum 0x806e6aa3, Offset: 0x6e0
// Size: 0x72
function _on_take( slot, weapon )
{
    self _off( slot, weapon );
    self.cybercom.targetlockcb = undefined;
    self.cybercom.targetlockrequirementcb = undefined;
    self.cybercom.var_f72b478f = undefined;
    self.cybercom.var_23d4a73a = undefined;
}

// Namespace cybercom_gadget_cacophany
// Params 0
// Checksum 0x99ec1590, Offset: 0x760
// Size: 0x4
function _on_connect()
{
    
}

// Namespace cybercom_gadget_cacophany
// Params 2
// Checksum 0xa276f931, Offset: 0x770
// Size: 0x54
function _on( slot, weapon )
{
    self thread function_7f3f3bde( slot, weapon );
    self _off( slot, weapon );
}

// Namespace cybercom_gadget_cacophany
// Params 2
// Checksum 0xe8d05293, Offset: 0x7d0
// Size: 0x3a
function _off( slot, weapon )
{
    self thread cybercom::weaponendlockwatcher( weapon );
    self.cybercom.is_primed = undefined;
}

// Namespace cybercom_gadget_cacophany
// Params 2
// Checksum 0x264e9fc6, Offset: 0x818
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

// Namespace cybercom_gadget_cacophany
// Params 1, eflags: 0x4
// Checksum 0x6c8227d3, Offset: 0x8c8
// Size: 0xdc, Type: bool
function private _lock_requirement( target )
{
    if ( target cybercom::cybercom_aicheckoptout( "cybercom_cacophany" ) )
    {
        self cybercom::function_29bf9dee( target, 2 );
        return false;
    }
    
    if ( isdefined( target.destroyingweapon ) )
    {
        return false;
    }
    
    if ( isdefined( target.var_37915be0 ) && target.var_37915be0 )
    {
        return false;
    }
    
    if ( isdefined( target.is_disabled ) && target.is_disabled )
    {
        self cybercom::function_29bf9dee( target, 6 );
        return false;
    }
    
    return true;
}

// Namespace cybercom_gadget_cacophany
// Params 1, eflags: 0x4
// Checksum 0x56cad3c9, Offset: 0x9b0
// Size: 0x2a
function private _get_valid_targets( weapon )
{
    return getentarray( "destructible", "targetname" );
}

// Namespace cybercom_gadget_cacophany
// Params 2, eflags: 0x4
// Checksum 0xc25ac954, Offset: 0x9e8
// Size: 0x28c
function private function_7f3f3bde( slot, weapon )
{
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
                
                item.target thread function_41e98fcc( self, fired );
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
        itemindex = getitemindexfromref( "cybercom_cacophany" );
        
        if ( isdefined( itemindex ) )
        {
            self adddstat( "ItemStats", itemindex, "stats", "assists", "statValue", fired );
            self adddstat( "ItemStats", itemindex, "stats", "used", "statValue", 1 );
        }
    }
}

// Namespace cybercom_gadget_cacophany
// Params 2
// Checksum 0x3e1fabf9, Offset: 0xc80
// Size: 0xa8
function function_41e98fcc( attacker, offset )
{
    if ( offset == 0 )
    {
        wait 0.1;
    }
    else
    {
        var_f5aa368a = 0.15 + randomfloatrange( 0.1, 0.25 ) * offset;
        wait var_f5aa368a;
    }
    
    self dodamage( self.health + 100, self.origin, attacker, attacker );
    self.var_37915be0 = 1;
}

