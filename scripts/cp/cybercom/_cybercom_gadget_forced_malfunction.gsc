#using scripts/codescripts/struct;
#using scripts/cp/_challenges;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/ai_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace cybercom_gadget_forced_malfunction;

// Namespace cybercom_gadget_forced_malfunction
// Params 0
// Checksum 0xb36b509f, Offset: 0x528
// Size: 0x34
function init()
{
    clientfield::register( "actor", "forced_malfunction", 1, 1, "int" );
}

// Namespace cybercom_gadget_forced_malfunction
// Params 0
// Checksum 0xd0ec5e2b, Offset: 0x568
// Size: 0x17c
function main()
{
    cybercom_gadget::registerability( 1, 2 );
    level.cybercom.forced_malfunction = spawnstruct();
    level.cybercom.forced_malfunction._is_flickering = &_is_flickering;
    level.cybercom.forced_malfunction._on_flicker = &_on_flicker;
    level.cybercom.forced_malfunction._on_give = &_on_give;
    level.cybercom.forced_malfunction._on_take = &_on_take;
    level.cybercom.forced_malfunction._on_connect = &_on_connect;
    level.cybercom.forced_malfunction._on = &_on;
    level.cybercom.forced_malfunction._off = &_off;
    level.cybercom.forced_malfunction._is_primed = &_is_primed;
}

// Namespace cybercom_gadget_forced_malfunction
// Params 1
// Checksum 0x15fd0bc9, Offset: 0x6f0
// Size: 0xc
function _is_flickering( slot )
{
    
}

// Namespace cybercom_gadget_forced_malfunction
// Params 2
// Checksum 0xa557bc78, Offset: 0x708
// Size: 0x14
function _on_flicker( slot, weapon )
{
    
}

// Namespace cybercom_gadget_forced_malfunction
// Params 2
// Checksum 0x4053b4c, Offset: 0x728
// Size: 0x154
function _on_give( slot, weapon )
{
    self.cybercom.var_110c156a = getdvarint( "scr_forced_malfunction_count", 2 );
    
    if ( self hascybercomability( "cybercom_forcedmalfunction" ) == 2 )
    {
        self.cybercom.var_110c156a = getdvarint( "scr_forced_malfunction_upgraded_count", 4 );
    }
    
    self.cybercom.targetlockcb = &_get_valid_targets;
    self.cybercom.targetlockrequirementcb = &_lock_requirement;
    self thread cybercom::function_b5f4e597( weapon );
    self cybercom::function_8257bcb3( "base_rifle", 5 );
    self cybercom::function_8257bcb3( "fem_rifle", 3 );
    self cybercom::function_8257bcb3( "riotshield", 2 );
}

// Namespace cybercom_gadget_forced_malfunction
// Params 2
// Checksum 0x56ebe727, Offset: 0x888
// Size: 0x52
function _on_take( slot, weapon )
{
    self _off( slot, weapon );
    self.cybercom.targetlockcb = undefined;
    self.cybercom.targetlockrequirementcb = undefined;
}

// Namespace cybercom_gadget_forced_malfunction
// Params 0
// Checksum 0x99ec1590, Offset: 0x8e8
// Size: 0x4
function _on_connect()
{
    
}

// Namespace cybercom_gadget_forced_malfunction
// Params 2
// Checksum 0xc5b2ae50, Offset: 0x8f8
// Size: 0x54
function _on( slot, weapon )
{
    self thread _activate_forced_malfunction( slot, weapon );
    self _off( slot, weapon );
}

// Namespace cybercom_gadget_forced_malfunction
// Params 2
// Checksum 0x26fa9531, Offset: 0x958
// Size: 0x3a
function _off( slot, weapon )
{
    self thread cybercom::weaponendlockwatcher( weapon );
    self.cybercom.is_primed = undefined;
}

// Namespace cybercom_gadget_forced_malfunction
// Params 2
// Checksum 0xc0a06d7e, Offset: 0x9a0
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

// Namespace cybercom_gadget_forced_malfunction
// Params 1, eflags: 0x4
// Checksum 0xeba66962, Offset: 0xa50
// Size: 0x2bc, Type: bool
function private _lock_requirement( target )
{
    if ( target cybercom::cybercom_aicheckoptout( "cybercom_forcedmalfunction" ) )
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
    
    if ( isvehicle( target ) )
    {
        self cybercom::function_29bf9dee( target, 2 );
        return false;
    }
    
    if ( target.archetype == "zombie" || isactor( target ) && isdefined( target.archetype ) && target.archetype == "direwolf" )
    {
        self cybercom::function_29bf9dee( target, 2 );
        return false;
    }
    
    if ( isactor( target ) && target cybercom::getentitypose() != "stand" && target cybercom::getentitypose() != "crouch" )
    {
        return false;
    }
    
    if ( isactor( target ) && !target isonground() && !target cybercom::function_421746e0() )
    {
        return false;
    }
    
    if ( isactor( target ) && isdefined( target.weapon ) && target.weapon.name == "none" )
    {
        self cybercom::function_29bf9dee( target, 2 );
        return false;
    }
    
    return true;
}

// Namespace cybercom_gadget_forced_malfunction
// Params 1, eflags: 0x4
// Checksum 0x4ec68eaa, Offset: 0xd18
// Size: 0x52
function private _get_valid_targets( weapon )
{
    return arraycombine( getaiteamarray( "axis" ), getaiteamarray( "team3" ), 0, 0 );
}

// Namespace cybercom_gadget_forced_malfunction
// Params 2, eflags: 0x4
// Checksum 0xb9a64992, Offset: 0xd78
// Size: 0x2a4
function private _activate_forced_malfunction( slot, weapon )
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
                
                self thread challenges::function_96ed590f( "cybercom_uses_martial" );
                item.target thread _force_malfunction( self, undefined );
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
    
    if ( fired && isplayer( self ) )
    {
        itemindex = getitemindexfromref( "cybercom_forcedmalfunction" );
        
        if ( isdefined( itemindex ) )
        {
            self adddstat( "ItemStats", itemindex, "stats", "assists", "statValue", fired );
            self adddstat( "ItemStats", itemindex, "stats", "used", "statValue", 1 );
        }
    }
    
    cybercom::function_adc40f11( weapon, fired );
}

// Namespace cybercom_gadget_forced_malfunction
// Params 3, eflags: 0x4
// Checksum 0x34930fab, Offset: 0x1028
// Size: 0xe4
function private function_586fec95( attacker, disablefor, weapon )
{
    self endon( #"death" );
    self clientfield::set( "forced_malfunction", 1 );
    self.is_disabled = 1;
    self dodamage( 5, self.origin, isdefined( attacker ) ? attacker : undefined, undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1 );
    self waittillmatch( #"bhtn_action_terminate", "specialpain" );
    self.is_disabled = 0;
    self clientfield::set( "forced_malfunction", 0 );
}

// Namespace cybercom_gadget_forced_malfunction
// Params 3, eflags: 0x4
// Checksum 0x6ecf571a, Offset: 0x1118
// Size: 0x1d0
function private function_609fcb0a( attacker, disablefor, weapon )
{
    self endon( #"death" );
    
    if ( !cybercom::function_76e3026d( self ) )
    {
        self kill( self.origin, isdefined( attacker ) ? attacker : undefined );
        return;
    }
    
    self clientfield::set( "forced_malfunction", 1 );
    self.is_disabled = 1;
    miss = 100;
    
    while ( isalive( self ) && gettime() < disablefor )
    {
        if ( getdvarint( "scr_malfunction_rate_of_failure", 25 ) + miss > randomint( 100 ) )
        {
            miss = 0;
            self dodamage( 5, self.origin, isdefined( attacker ) ? attacker : undefined, undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1 );
            self waittillmatch( #"bhtn_action_terminate", "specialpain" );
            continue;
        }
        
        miss += 10;
        wait randomintrange( 1, 3 );
    }
    
    self clientfield::set( "forced_malfunction", 0 );
    self.is_disabled = 0;
}

// Namespace cybercom_gadget_forced_malfunction
// Params 2, eflags: 0x4
// Checksum 0xfa12ee08, Offset: 0x12f0
// Size: 0x55c
function private _force_malfunction( attacker, disabletimemsec )
{
    self endon( #"death" );
    weapon = getweapon( "gadget_forced_malfunction" );
    self notify( #"cybercom_action", weapon, attacker );
    
    if ( isdefined( disabletimemsec ) )
    {
        disabletime = disabletimemsec;
    }
    else
    {
        disabletime = getdvarint( "scr_malfunction_duration", 15 ) * 1000;
    }
    
    if ( !attacker cybercom::targetisvalid( self, weapon ) )
    {
        return;
    }
    
    if ( self cybercom::function_421746e0() )
    {
        self kill( self.origin, isdefined( attacker ) ? attacker : undefined, undefined, weapon );
        return;
    }
    
    disablefor = gettime() + disabletime + randomint( 4000 );
    
    if ( self.archetype == "robot" )
    {
        self thread function_609fcb0a( attacker, disablefor, weapon );
        return;
    }
    
    if ( self.archetype == "warlord" )
    {
        self thread function_586fec95( attacker, disablefor, weapon );
        return;
    }
    
    assert( self.archetype == "<dev string:x28>" || self.archetype == "<dev string:x2e>" );
    type = self cybercom::function_5e3d3aa();
    self clientfield::set( "forced_malfunction", 1 );
    goalpos = self.goalpos;
    goalradius = self.goalradius;
    self.goalradius = 32;
    
    if ( self isactorshooting() )
    {
        base = "base_rifle";
        
        if ( isdefined( self.voiceprefix ) && getsubstr( self.voiceprefix, 7 ) == "f" )
        {
            base = "fem_rifle";
        }
        else if ( self.archetype == "human_riotshield" )
        {
            base = "riotshield";
        }
        
        type = self cybercom::function_5e3d3aa();
        variant = attacker cybercom::getanimationvariant( base );
        self animscripted( "malfunction_intro_anim", self.origin, self.angles, "ai_" + base + "_" + type + "_exposed_rifle_malfunction" + variant );
        self thread cybercom::stopanimscriptedonnotify( "damage_pain", "malfunction_intro_anim", 1, attacker, weapon );
        self thread cybercom::stopanimscriptedonnotify( "notify_melee_damage", "malfunction_intro_anim", 1, attacker, weapon );
        self waittillmatch( #"malfunction_intro_anim", "end" );
    }
    
    var_ac712236 = 0;
    
    while ( isalive( self ) && gettime() < disablefor )
    {
        if ( gettime() > var_ac712236 )
        {
            var_ac712236 = gettime() + randomfloatrange( getdvarfloat( "scr_malfunction_duration_min_wait", 2 ), getdvarfloat( "scr_malfunction_duration_max_wait", 3.25 ) ) * 1000;
            
            if ( getdvarint( "scr_malfunction_rate_of_failure", 90 ) > randomint( 100 ) )
            {
                self.malfunctionreaction = 1;
            }
            else
            {
                self.malfunctionreaction = 0;
            }
        }
        
        wait 0.2;
    }
    
    self clientfield::set( "forced_malfunction", 0 );
    self.malfunctionreaction = undefined;
    self.melee_charge_rangesq = undefined;
    self.goalradius = goalradius;
    self setgoal( goalpos, 1 );
}

// Namespace cybercom_gadget_forced_malfunction
// Params 2
// Checksum 0x948cf286, Offset: 0x1858
// Size: 0x2a2
function ai_activateforcedmalfuncton( target, var_9bc2efcb )
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
        self animscripted( "ai_cybercom_anim", self.origin, self.angles, "ai_base_rifle_" + type + "_exposed_cybercom_activate" );
        self waittillmatch( #"ai_cybercom_anim", "fire" );
    }
    
    weapon = getweapon( "gadget_forced_malfunction" );
    
    foreach ( guy in validtargets )
    {
        if ( !cybercom::targetisvalid( guy, weapon ) )
        {
            continue;
        }
        
        guy thread _force_malfunction( self );
        wait 0.05;
    }
}

