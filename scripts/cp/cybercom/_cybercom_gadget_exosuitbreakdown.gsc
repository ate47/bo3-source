#using scripts/codescripts/struct;
#using scripts/cp/_challenges;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
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

#namespace cybercom_gadget_exosuitbreakdown;

// Namespace cybercom_gadget_exosuitbreakdown
// Params 0
// Checksum 0x99ec1590, Offset: 0x5a0
// Size: 0x4
function init()
{
    
}

// Namespace cybercom_gadget_exosuitbreakdown
// Params 0
// Checksum 0xe15ce59d, Offset: 0x5b0
// Size: 0x17c
function main()
{
    cybercom_gadget::registerability( 0, 4 );
    level.cybercom.exo_breakdown = spawnstruct();
    level.cybercom.exo_breakdown._is_flickering = &_is_flickering;
    level.cybercom.exo_breakdown._on_flicker = &_on_flicker;
    level.cybercom.exo_breakdown._on_give = &_on_give;
    level.cybercom.exo_breakdown._on_take = &_on_take;
    level.cybercom.exo_breakdown._on_connect = &_on_connect;
    level.cybercom.exo_breakdown._on = &_on;
    level.cybercom.exo_breakdown._off = &_off;
    level.cybercom.exo_breakdown._is_primed = &_is_primed;
}

// Namespace cybercom_gadget_exosuitbreakdown
// Params 1
// Checksum 0x6246284f, Offset: 0x738
// Size: 0xc
function _is_flickering( slot )
{
    
}

// Namespace cybercom_gadget_exosuitbreakdown
// Params 2
// Checksum 0x5107c92d, Offset: 0x750
// Size: 0x14
function _on_flicker( slot, weapon )
{
    
}

// Namespace cybercom_gadget_exosuitbreakdown
// Params 2
// Checksum 0xc478e786, Offset: 0x770
// Size: 0x1c4
function _on_give( slot, weapon )
{
    self.cybercom.var_110c156a = getdvarint( "scr_exo_breakdown_count", 1 );
    self.cybercom.var_1360b9f1 = getdvarint( "scr_exo_breakdown_loops", 2 );
    
    if ( self hascybercomability( "cybercom_exosuitbreakdown" ) == 2 )
    {
        self.cybercom.var_110c156a = getdvarint( "scr_exo_breakdown_upgraded_count", 2 );
    }
    
    self.cybercom.targetlockcb = &_get_valid_targets;
    self.cybercom.targetlockrequirementcb = &_lock_requirement;
    self thread cybercom::function_b5f4e597( weapon );
    self cybercom::function_8257bcb3( "base_rifle_stn", 8 );
    self cybercom::function_8257bcb3( "base_rifle_crc", 2 );
    self cybercom::function_8257bcb3( "fem_rifle_stn", 8 );
    self cybercom::function_8257bcb3( "fem_rifle_crc", 2 );
    self cybercom::function_8257bcb3( "riotshield", 2 );
}

// Namespace cybercom_gadget_exosuitbreakdown
// Params 2
// Checksum 0xd78b664e, Offset: 0x940
// Size: 0x52
function _on_take( slot, weapon )
{
    self _off( slot, weapon );
    self.cybercom.targetlockcb = undefined;
    self.cybercom.targetlockrequirementcb = undefined;
}

// Namespace cybercom_gadget_exosuitbreakdown
// Params 0
// Checksum 0x99ec1590, Offset: 0x9a0
// Size: 0x4
function _on_connect()
{
    
}

// Namespace cybercom_gadget_exosuitbreakdown
// Params 2
// Checksum 0xfb7c9833, Offset: 0x9b0
// Size: 0x54
function _on( slot, weapon )
{
    self thread _activate_exo_breakdown( slot, weapon );
    self _off( slot, weapon );
}

// Namespace cybercom_gadget_exosuitbreakdown
// Params 2
// Checksum 0x7eef657c, Offset: 0xa10
// Size: 0x3a
function _off( slot, weapon )
{
    self thread cybercom::weaponendlockwatcher( weapon );
    self.cybercom.is_primed = undefined;
}

// Namespace cybercom_gadget_exosuitbreakdown
// Params 2
// Checksum 0x45175bfb, Offset: 0xa58
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

// Namespace cybercom_gadget_exosuitbreakdown
// Params 1, eflags: 0x4
// Checksum 0x7b4492c0, Offset: 0xb08
// Size: 0x208, Type: bool
function private _lock_requirement( target )
{
    if ( target cybercom::cybercom_aicheckoptout( "cybercom_exosuitbreakdown" ) )
    {
        self cybercom::function_29bf9dee( target, 2 );
        return false;
    }
    
    if ( isdefined( target.is_disabled ) && target.is_disabled )
    {
        self cybercom::function_29bf9dee( target, 6 );
        return false;
    }
    
    if ( isactor( target ) && target cybercom::getentitypose() != "stand" && target cybercom::getentitypose() != "crouch" )
    {
        return false;
    }
    
    if ( isvehicle( target ) )
    {
        self cybercom::function_29bf9dee( target, 2 );
        return false;
    }
    
    if ( target.archetype != "human" && target.archetype != "human_riotshield" && ( !isdefined( target.archetype ) || target.archetype != "warlord" ) )
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

// Namespace cybercom_gadget_exosuitbreakdown
// Params 1, eflags: 0x4
// Checksum 0xe7d8b03d, Offset: 0xd18
// Size: 0x52
function private _get_valid_targets( weapon )
{
    return arraycombine( getaiteamarray( "axis" ), getaiteamarray( "team3" ), 0, 0 );
}

// Namespace cybercom_gadget_exosuitbreakdown
// Params 2
// Checksum 0x6b61b0f0, Offset: 0xd78
// Size: 0x2a4
function _activate_exo_breakdown( slot, weapon )
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
                
                self thread challenges::function_96ed590f( "cybercom_uses_control" );
                item.target thread _exo_breakdown( self );
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
        itemindex = getitemindexfromref( "cybercom_exosuitbreakdown" );
        
        if ( isdefined( itemindex ) )
        {
            self adddstat( "ItemStats", itemindex, "stats", "assists", "statValue", fired );
            self adddstat( "ItemStats", itemindex, "stats", "used", "statValue", 1 );
        }
    }
}

// Namespace cybercom_gadget_exosuitbreakdown
// Params 2
// Checksum 0xf2c3c05e, Offset: 0x1028
// Size: 0x2ba
function ai_activateexosuitbreakdown( target, var_9bc2efcb )
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
    
    weapon = getweapon( "gadget_exo_breakdown" );
    
    foreach ( guy in validtargets )
    {
        if ( !cybercom::targetisvalid( guy, weapon ) )
        {
            continue;
        }
        
        guy thread _exo_breakdown( self );
        wait 0.05;
    }
}

// Namespace cybercom_gadget_exosuitbreakdown
// Params 3, eflags: 0x4
// Checksum 0xb9cd7e04, Offset: 0x12f0
// Size: 0x10a
function private function_69246d49( attacker, loops, weapon )
{
    self endon( #"death" );
    self.is_disabled = 1;
    self.ignoreall = 1;
    self.special_weapon = weapon;
    
    while ( loops )
    {
        self.allowpain = 1;
        self dodamage( 5, self.origin, isdefined( attacker ) ? attacker : undefined, undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1 );
        self.allowpain = 0;
        wait 0.05;
        self waittillmatch( #"bhtn_action_terminate" );
        loops--;
    }
    
    self.allowpain = 1;
    self.ignoreall = 0;
    self.is_disabled = undefined;
    self.special_weapon = undefined;
}

#using_animtree( "generic" );

// Namespace cybercom_gadget_exosuitbreakdown
// Params 1, eflags: 0x4
// Checksum 0xe3c24fb4, Offset: 0x1408
// Size: 0x58e
function private _exo_breakdown( attacker )
{
    self endon( #"death" );
    weapon = getweapon( "gadget_exo_breakdown" );
    self notify( #"cybercom_action", weapon, attacker );
    
    if ( isdefined( attacker.cybercom ) && isdefined( attacker.cybercom.exo_breakdown_lifetime ) )
    {
        loops = self.cybercom.var_1360b9f1;
    }
    else
    {
        loops = 1;
    }
    
    wait randomfloatrange( 0, 0.75 );
    
    if ( !attacker cybercom::targetisvalid( self, weapon ) )
    {
        return;
    }
    
    if ( self cybercom::function_421746e0() )
    {
        self kill( self.origin, isdefined( attacker ) ? attacker : undefined );
        return;
    }
    
    self notify( #"bhtn_action_notify", "reactExosuit" );
    
    if ( self.archetype == "warlord" )
    {
        self thread function_69246d49( attacker, 1, weapon );
        return;
    }
    
    self.is_disabled = 1;
    self.ignoreall = 1;
    
    if ( isplayer( attacker ) && attacker hascybercomability( "cybercom_exosuitbreakdown" ) == 2 )
    {
        if ( isdefined( self.voiceprefix ) && isdefined( self.bcvoicenumber ) )
        {
            self thread battlechatter::do_sound( self.voiceprefix + self.bcvoicenumber + "_exert_breakdown_pain", 1 );
        }
        
        self dodamage( self.health + 666, self.origin, isdefined( attacker ) ? attacker : undefined, undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1 );
        return;
    }
    
    base = "base_rifle";
    
    if ( isdefined( self.voiceprefix ) && getsubstr( self.voiceprefix, 7 ) == "f" )
    {
        base = "fem_rifle";
    }
    
    if ( self.archetype == "human_riotshield" )
    {
        base = "riotshield";
    }
    
    type = self cybercom::function_5e3d3aa();
    variant = attacker cybercom::getanimationvariant( base + "_" + type );
    self orientmode( "face default" );
    self animscripted( "exo_intro_anim", self.origin, self.angles, "ai_" + base + "_" + type + "_exposed_suit_overload_react_intro" + variant, "normal", %body, 1, 0.2 );
    self thread cybercom::stopanimscriptedonnotify( "damage_pain", "exo_intro_anim", 1, attacker, weapon );
    self thread cybercom::stopanimscriptedonnotify( "notify_melee_damage", "exo_intro_anim", 1, attacker, weapon );
    self waittillmatch( #"exo_intro_anim", "end" );
    function_58831b5a( loops, attacker, weapon, variant, base, type );
    self animscripted( "exo_outro_anim", self.origin, self.angles, "ai_" + base + "_" + type + "_exposed_suit_overload_react_outro" + variant, "normal", %body, 1, 0.2 );
    self thread cybercom::stopanimscriptedonnotify( "damage_pain", "exo_outro_anim", 1, attacker, weapon );
    self thread cybercom::stopanimscriptedonnotify( "notify_melee_damage", "exo_outro_anim", 1, attacker, weapon );
    self waittillmatch( #"exo_outro_anim", "end" );
    self.ignoreall = 0;
    self.is_disabled = undefined;
}

// Namespace cybercom_gadget_exosuitbreakdown
// Params 6
// Checksum 0xc85b3bfb, Offset: 0x19a0
// Size: 0x8e
function function_58831b5a( loops, attacker, weapon, variant, base, type )
{
    self endon( #"breakout_exo_loop" );
    self thread function_53cfe88a();
    
    while ( loops )
    {
        self function_e01b8059( attacker, weapon, variant, base, type );
        loops--;
    }
}

// Namespace cybercom_gadget_exosuitbreakdown
// Params 5
// Checksum 0xa5a0a8ff, Offset: 0x1a38
// Size: 0x12a
function function_e01b8059( attacker, weapon, variant, base, type )
{
    self endon( #"death" );
    self animscripted( "exo_loop_anim", self.origin, self.angles, "ai_" + base + "_" + type + "_exposed_suit_overload_react_loop" + variant, "normal", %body, 1, 0.2 );
    self thread cybercom::stopanimscriptedonnotify( "damage_pain", "exo_loop_anim", 1, attacker, weapon );
    self thread cybercom::stopanimscriptedonnotify( "breakout_exo_loop", "exo_loop_anim", 0, attacker, weapon );
    self waittillmatch( #"exo_loop_anim", "end" );
}

// Namespace cybercom_gadget_exosuitbreakdown
// Params 0
// Checksum 0x923bb189, Offset: 0x1b70
// Size: 0x3a
function function_53cfe88a()
{
    self endon( #"death" );
    wait getdvarfloat( "scr_exo_breakdown_loop_time", 4.2 );
    self notify( #"breakout_exo_loop" );
}

