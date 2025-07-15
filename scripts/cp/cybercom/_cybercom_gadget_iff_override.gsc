#using scripts/codescripts/struct;
#using scripts/cp/_achievements;
#using scripts/cp/_challenges;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/ai/archetype_robot;
#using scripts/shared/ai_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;

#namespace cybercom_gadget_iff_override;

// Namespace cybercom_gadget_iff_override
// Params 0
// Checksum 0x99ec1590, Offset: 0x578
// Size: 0x4
function init()
{
    
}

// Namespace cybercom_gadget_iff_override
// Params 0
// Checksum 0xb8f96414, Offset: 0x588
// Size: 0x1d4
function main()
{
    cybercom_gadget::registerability( 0, 64 );
    level._effect[ "iff_takeover" ] = "electric/fx_elec_sparks_burst_lg_os";
    level._effect[ "iff_takeover_revert" ] = "explosions/fx_exp_grenade_flshbng";
    level._effect[ "iff_takeover_death" ] = "explosions/fx_exp_grenade_flshbng";
    level.cybercom.iff_override = spawnstruct();
    level.cybercom.iff_override._is_flickering = &_is_flickering;
    level.cybercom.iff_override._on_flicker = &_on_flicker;
    level.cybercom.iff_override._on_give = &_on_give;
    level.cybercom.iff_override._on_take = &_on_take;
    level.cybercom.iff_override._on_connect = &_on_connect;
    level.cybercom.iff_override._on = &_on;
    level.cybercom.iff_override._off = &_off;
    level.cybercom.iff_override._is_primed = &_is_primed;
}

// Namespace cybercom_gadget_iff_override
// Params 1
// Checksum 0x1e3d09ae, Offset: 0x768
// Size: 0xc
function _is_flickering( slot )
{
    
}

// Namespace cybercom_gadget_iff_override
// Params 2
// Checksum 0xe5290cf2, Offset: 0x780
// Size: 0x14
function _on_flicker( slot, weapon )
{
    
}

// Namespace cybercom_gadget_iff_override
// Params 2
// Checksum 0x9790261f, Offset: 0x7a0
// Size: 0x1fc
function _on_give( slot, weapon )
{
    self.cybercom.var_110c156a = getdvarint( "scr_iff_override_count", 1 );
    self.cybercom.iff_override_lifetime = getdvarint( "scr_iff_override_lifetime", 60 );
    self.cybercom.var_84bab148 = getdvarint( "scr_iff_override_control_count", 1 );
    
    if ( self hascybercomability( "cybercom_iffoverride" ) == 2 )
    {
        self.cybercom.var_110c156a = getdvarint( "scr_iff_override_upgraded_count", 2 );
        self.cybercom.iff_override_lifetime = getdvarint( "scr_iff_override_upgraded_lifetime", 120 );
        self.cybercom.var_84bab148 = getdvarint( "scr_iff_override_control_upgraded_count", 2 );
    }
    
    self.cybercom.targetlockcb = &_get_valid_targets;
    self.cybercom.targetlockrequirementcb = &_lock_requirement;
    self.cybercom.var_46a37937 = [];
    self.cybercom.var_73d069a7 = &function_17342509;
    self.cybercom.var_46483c8f = 63;
    self thread cybercom::function_b5f4e597( weapon );
}

// Namespace cybercom_gadget_iff_override
// Params 2
// Checksum 0x42b036f3, Offset: 0x9a8
// Size: 0x72
function _on_take( slot, weapon )
{
    self _off( slot, weapon );
    self.cybercom.targetlockcb = undefined;
    self.cybercom.targetlockrequirementcb = undefined;
    self.cybercom.var_46483c8f = undefined;
    self.cybercom.var_73d069a7 = undefined;
}

// Namespace cybercom_gadget_iff_override
// Params 2
// Checksum 0x58d48724, Offset: 0xa28
// Size: 0x4c
function function_17342509( slot, weapon )
{
    self gadgetactivate( slot, weapon );
    _on( slot, weapon );
}

// Namespace cybercom_gadget_iff_override
// Params 0
// Checksum 0x99ec1590, Offset: 0xa80
// Size: 0x4
function _on_connect()
{
    
}

// Namespace cybercom_gadget_iff_override
// Params 2
// Checksum 0x95db6f7c, Offset: 0xa90
// Size: 0x54
function _on( slot, weapon )
{
    self thread _activate_iff_override( slot, weapon );
    self _off( slot, weapon );
}

// Namespace cybercom_gadget_iff_override
// Params 2
// Checksum 0x5df29fb3, Offset: 0xaf0
// Size: 0x3a
function _off( slot, weapon )
{
    self thread cybercom::weaponendlockwatcher( weapon );
    self.cybercom.is_primed = undefined;
}

// Namespace cybercom_gadget_iff_override
// Params 2
// Checksum 0x54adad9e, Offset: 0xb38
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

// Namespace cybercom_gadget_iff_override
// Params 2, eflags: 0x4
// Checksum 0x1e7f2914, Offset: 0xbe8
// Size: 0xfc
function private function_f1ec3062( team, attacker )
{
    self endon( #"death" );
    self waittill( #"iff_override_reverted" );
    self clientfield::set( "cybercom_setiffname", 4 );
    self setteam( team );
    wait 1;
    self clientfield::set( "cybercom_setiffname", 0 );
    playfx( level._effect[ "iff_takeover_death" ], self.origin );
    
    if ( isdefined( attacker ) )
    {
        self kill( self.origin, attacker );
        return;
    }
    
    self kill();
}

// Namespace cybercom_gadget_iff_override
// Params 1, eflags: 0x4
// Checksum 0xabea9f68, Offset: 0xcf0
// Size: 0x1dc
function private function_2458babe( entity )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    valid = [];
    
    foreach ( guy in self.cybercom.var_46a37937 )
    {
        if ( isdefined( guy ) && isalive( guy ) )
        {
            valid[ valid.size ] = guy;
        }
    }
    
    self.cybercom.var_46a37937 = valid;
    self.cybercom.var_46a37937[ self.cybercom.var_46a37937.size ] = entity;
    
    if ( self.cybercom.var_46a37937.size > self.cybercom.var_84bab148 )
    {
        var_983e95da = self.cybercom.var_46a37937[ 0 ];
        arrayremoveindex( self.cybercom.var_46a37937, 0 );
        
        if ( isdefined( var_983e95da ) )
        {
            var_983e95da notify( #"iff_override_reverted" );
            wait 1.5;
            
            if ( isalive( var_983e95da ) )
            {
                var_983e95da kill();
            }
        }
    }
}

// Namespace cybercom_gadget_iff_override
// Params 1, eflags: 0x4
// Checksum 0x8926bf29, Offset: 0xed8
// Size: 0x334, Type: bool
function private _lock_requirement( target )
{
    if ( target cybercom::cybercom_aicheckoptout( "cybercom_iffoverride" ) )
    {
        if ( isdefined( target.rogue_controlled ) && target.rogue_controlled )
        {
            self cybercom::function_29bf9dee( target, 4 );
        }
        else
        {
            self cybercom::function_29bf9dee( target, 2 );
        }
        
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
    
    if ( isactor( target ) && target.archetype != "robot" )
    {
        self cybercom::function_29bf9dee( target, 2 );
        return false;
    }
    
    if ( robotsoldierbehavior::robotiscrawler( target ) || isactor( target ) && target.archetype == "robot" && robotsoldierbehavior::robotshouldbecomecrawler( target ) )
    {
        self cybercom::function_29bf9dee( target, 2 );
        return false;
    }
    
    if ( !isactor( target ) && !isvehicle( target ) )
    {
        return false;
    }
    
    if ( isvehicle( target ) && isdefined( target.iffowner ) )
    {
        self cybercom::function_29bf9dee( target, 4 );
        return false;
    }
    
    if ( isdefined( target.var_f40d252c ) && target.var_f40d252c )
    {
        return false;
    }
    
    if ( isactor( target ) && target.archetype == "robot" && target ai::get_behavior_attribute( "rogue_control" ) == "level_3" )
    {
        self cybercom::function_29bf9dee( target, 4 );
        return false;
    }
    
    return true;
}

// Namespace cybercom_gadget_iff_override
// Params 1, eflags: 0x4
// Checksum 0x180c8120, Offset: 0x1218
// Size: 0x104
function private _get_valid_targets( weapon )
{
    prospects = getaiteamarray( "axis" );
    valid = [];
    
    foreach ( enemy in prospects )
    {
        if ( isactor( enemy ) && ( isvehicle( enemy ) || isdefined( enemy.archetype ) ) )
        {
            valid[ valid.size ] = enemy;
        }
    }
    
    return valid;
}

// Namespace cybercom_gadget_iff_override
// Params 2, eflags: 0x4
// Checksum 0x66cfcfb, Offset: 0x1328
// Size: 0x2ac
function private _activate_iff_override( slot, weapon )
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
                item.target thread iff_override( self, undefined, weapon );
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
        itemindex = getitemindexfromref( "cybercom_iffoverride" );
        
        if ( isdefined( itemindex ) )
        {
            self adddstat( "ItemStats", itemindex, "stats", "assists", "statValue", fired );
            self adddstat( "ItemStats", itemindex, "stats", "used", "statValue", 1 );
        }
    }
}

// Namespace cybercom_gadget_iff_override
// Params 1, eflags: 0x4
// Checksum 0x23e31e68, Offset: 0x15e0
// Size: 0xe8
function private _iff_leash_to_owner( owner )
{
    self endon( #"death" );
    self endon( #"iff_override_reverted" );
    
    if ( isplayer( owner ) )
    {
        owner endon( #"disconnect" );
    }
    else
    {
        owner endon( #"death" );
    }
    
    while ( isdefined( owner ) )
    {
        wait randomfloatrange( 1, 4 );
        
        if ( distancesquared( self.origin, owner.origin ) > self.goalradius * self.goalradius )
        {
            self setgoal( owner.origin );
        }
    }
}

// Namespace cybercom_gadget_iff_override
// Params 1
// Checksum 0xf633afc7, Offset: 0x16d0
// Size: 0xe0
function iff_vehiclecb( isactive )
{
    if ( isactive && isdefined( self.iffowner ) && isplayer( self.iffowner ) )
    {
        self clientfield::set( "cybercom_setiffname", 2 );
        self thread function_384a3bfb();
        return;
    }
    
    if ( !isactive && isdefined( self.iffowner ) )
    {
        self clientfield::set( "cybercom_setiffname", 0 );
        achievements::function_6903d776( self );
        self.iffowner = undefined;
        self.iff_override_cb = undefined;
        self.is_disabled = 0;
    }
}

// Namespace cybercom_gadget_iff_override
// Params 0, eflags: 0x4
// Checksum 0xe2cac318, Offset: 0x17b8
// Size: 0x3c
function private function_384a3bfb()
{
    self endon( #"death" );
    self waittill( #"iff_override_reverted" );
    self clientfield::set( "cybercom_setiffname", 4 );
}

// Namespace cybercom_gadget_iff_override
// Params 1, eflags: 0x4
// Checksum 0x1746f94b, Offset: 0x1800
// Size: 0xa4
function private _iff_overridevehicle( assignedowner )
{
    self endon( #"death" );
    wait randomfloatrange( 0, 0.75 );
    
    if ( isplayer( assignedowner ) )
    {
        self.iff_override_cb = &iff_vehiclecb;
        self.iffowner = assignedowner;
    }
    
    assignedowner thread function_2458babe( self );
    self thread vehicle_ai::iff_override( assignedowner );
}

// Namespace cybercom_gadget_iff_override
// Params 0, eflags: 0x4
// Checksum 0x14eab942, Offset: 0x18b0
// Size: 0x3c
function private function_2b203db0()
{
    self endon( #"death" );
    self waittill( #"iff_override_revert_warn" );
    self clientfield::set( "cybercom_setiffname", 3 );
}

// Namespace cybercom_gadget_iff_override
// Params 3
// Checksum 0x265f25a2, Offset: 0x18f8
// Size: 0x53c
function iff_override( attacker, disabletimemsec, weapon )
{
    if ( !isdefined( weapon ) )
    {
        weapon = getweapon( "gadget_iff_override" );
    }
    
    self notify( #"cybercom_action", weapon, attacker );
    self clientfield::set( "cybercom_setiffname", 1 );
    
    if ( isactor( self ) )
    {
        self ai::set_behavior_attribute( "can_become_crawler", 0 );
        self ai::set_behavior_attribute( "can_gib", 0 );
    }
    
    self.is_disabled = 1;
    
    if ( isvehicle( self ) )
    {
        self thread function_2b203db0();
        self thread _iff_overridevehicle( attacker );
        return;
    }
    
    if ( self cybercom::function_421746e0() )
    {
        self kill( self.origin, isdefined( attacker ) ? attacker : undefined, undefined, weapon );
        return;
    }
    
    if ( isdefined( disabletimemsec ) )
    {
        disabletime = int( disabletimemsec / 1000 );
    }
    else if ( isdefined( attacker.cybercom ) && isdefined( attacker.cybercom.iff_override_lifetime ) )
    {
        disabletime = attacker.cybercom.iff_override_lifetime;
    }
    else
    {
        disabletime = getdvarint( "scr_iff_override_lifetime", 60 );
    }
    
    self.ignoreall = 1;
    self ai::set_behavior_attribute( "robot_lights", 2 );
    wait 1;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    entnum = self getentitynumber();
    self notify( #"cloneandremoveentity", entnum );
    level notify( #"cloneandremoveentity", entnum );
    wait 0.05;
    team = self.team;
    clone = cloneandremoveentity( self );
    
    if ( !isdefined( clone ) )
    {
        return;
    }
    
    level notify( #"clonedentity", clone, entnum );
    
    if ( isactor( clone ) )
    {
        clone ai::set_behavior_attribute( "move_mode", "rusher" );
    }
    
    attacker thread function_2458babe( clone );
    clone thread function_f1ec3062( team, attacker );
    clone thread function_2b203db0();
    clone thread _iff_override_revert_after( disabletime, attacker );
    clone.no_friendly_fire_penalty = 1;
    clone setteam( attacker.team );
    clone.remote_owner = attacker;
    clone.oldteam = team;
    
    if ( isdefined( clone.favoriteenemy ) && isdefined( clone.favoriteenemy._currentroguerobot ) )
    {
        clone.favoriteenemy._currentroguerobot = undefined;
    }
    
    clone.favoriteenemy = undefined;
    playfx( level._effect[ "iff_takeover" ], clone.origin );
    clone thread _iff_leash_to_owner( attacker );
    clone.oldgoalradius = clone.goalradius;
    clone.goalradius = 512;
    clone clientfield::set( "cybercom_setiffname", 2 );
    
    if ( isdefined( self.var_72f54197 ) )
    {
        clone.var_72f54197 = self.var_72f54197;
    }
    
    if ( isdefined( self.var_b0ac175a ) )
    {
        clone.var_b0ac175a = self.var_b0ac175a;
    }
}

// Namespace cybercom_gadget_iff_override
// Params 2
// Checksum 0xb6104832, Offset: 0x1e40
// Size: 0x2e
function iff_notifymeinnsec( time, note )
{
    self endon( #"death" );
    wait time;
    self notify( note );
}

// Namespace cybercom_gadget_iff_override
// Params 2, eflags: 0x4
// Checksum 0x8bc27bc3, Offset: 0x1e78
// Size: 0x8a
function private _iff_override_revert_after( timesec, attacker )
{
    self endon( #"death" );
    wait timesec - 6;
    self notify( #"iff_override_revert_warn" );
    wait 6;
    self clientfield::set( "cybercom_setiffname", 4 );
    wait 2;
    self setteam( self.oldteam );
    self notify( #"iff_override_reverted" );
}

// Namespace cybercom_gadget_iff_override
// Params 2
// Checksum 0x75c4995f, Offset: 0x1f10
// Size: 0x2ba
function ai_activateiffoverride( target, var_9bc2efcb )
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
    
    weapon = getweapon( "gadget_iff_override" );
    
    foreach ( guy in validtargets )
    {
        if ( !cybercom::targetisvalid( guy, weapon ) )
        {
            continue;
        }
        
        guy thread iff_override( self, undefined, undefined );
        wait 0.05;
    }
}

