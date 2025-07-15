#using scripts/codescripts/struct;
#using scripts/cp/_challenges;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
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

#namespace cybercom_gadget_mrpukey;

// Namespace cybercom_gadget_mrpukey
// Params 0
// Checksum 0x99ec1590, Offset: 0x578
// Size: 0x4
function init()
{
    
}

// Namespace cybercom_gadget_mrpukey
// Params 0
// Checksum 0x6af5eabc, Offset: 0x588
// Size: 0x1fc
function main()
{
    cybercom_gadget::registerability( 2, 64 );
    level._effect[ "puke_reaction" ] = "water/fx_liquid_vomit";
    level.cybercom.mrpukey = spawnstruct();
    level.cybercom.mrpukey._is_flickering = &_is_flickering;
    level.cybercom.mrpukey._on_flicker = &_on_flicker;
    level.cybercom.mrpukey._on_give = &_on_give;
    level.cybercom.mrpukey._on_take = &_on_take;
    level.cybercom.mrpukey._on_connect = &_on_connect;
    level.cybercom.mrpukey._on = &_on;
    level.cybercom.mrpukey._off = &_off;
    level.cybercom.mrpukey._is_primed = &_is_primed;
    level.cybercom.mrpukey.var_106f11dd = array( "c_54i_cqb_head1", "c_nrc_cqb_head", "c_nrc_cqb_f_head", "c_54i_supp_head1", "c_54i_supp_head1", "c_nrc_sniper_head", "c_nrc_suppressor_head" );
}

// Namespace cybercom_gadget_mrpukey
// Params 1
// Checksum 0xde61ff3e, Offset: 0x790
// Size: 0xc
function _is_flickering( slot )
{
    
}

// Namespace cybercom_gadget_mrpukey
// Params 2
// Checksum 0xf7208179, Offset: 0x7a8
// Size: 0x14
function _on_flicker( slot, weapon )
{
    
}

// Namespace cybercom_gadget_mrpukey
// Params 2
// Checksum 0xf4c16b13, Offset: 0x7c8
// Size: 0x1b4
function _on_give( slot, weapon )
{
    self.cybercom.var_110c156a = getdvarint( "scr_mrpukey_target_count", 4 );
    self.cybercom.var_cf33c5a4 = getdvarfloat( "scr_pukey_fov", 0.968 );
    
    if ( self hascybercomability( "cybercom_mrpukey" ) == 2 )
    {
        self.cybercom.var_f72b478f = getdvarfloat( "scr_pukey_upgraded_fov", 0.92 );
        self.cybercom.var_110c156a = getdvarint( "scr_mrpukey_target_count_upgraded", 5 );
    }
    
    self.cybercom.targetlockcb = &_get_valid_targets;
    self.cybercom.targetlockrequirementcb = &_lock_requirement;
    self thread cybercom::function_b5f4e597( weapon );
    self cybercom::function_8257bcb3( "base_rifle", 5 );
    self cybercom::function_8257bcb3( "fem_rifle", 5 );
    self cybercom::function_8257bcb3( "riotshield", 2 );
}

// Namespace cybercom_gadget_mrpukey
// Params 2
// Checksum 0x14d873f9, Offset: 0x988
// Size: 0x62
function _on_take( slot, weapon )
{
    self _off( slot, weapon );
    self.cybercom.targetlockcb = undefined;
    self.cybercom.targetlockrequirementcb = undefined;
    self.cybercom.var_f72b478f = undefined;
}

// Namespace cybercom_gadget_mrpukey
// Params 0
// Checksum 0x99ec1590, Offset: 0x9f8
// Size: 0x4
function _on_connect()
{
    
}

// Namespace cybercom_gadget_mrpukey
// Params 2
// Checksum 0x606eeadc, Offset: 0xa08
// Size: 0x54
function _on( slot, weapon )
{
    self thread function_2de61c3f( slot, weapon );
    self _off( slot, weapon );
}

// Namespace cybercom_gadget_mrpukey
// Params 2
// Checksum 0x7bf646e9, Offset: 0xa68
// Size: 0x3a
function _off( slot, weapon )
{
    self thread cybercom::weaponendlockwatcher( weapon );
    self.cybercom.is_primed = undefined;
}

// Namespace cybercom_gadget_mrpukey
// Params 2
// Checksum 0x6a6d4cbc, Offset: 0xab0
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

// Namespace cybercom_gadget_mrpukey
// Params 1, eflags: 0x4
// Checksum 0x13c08c9b, Offset: 0xb60
// Size: 0x200, Type: bool
function private _lock_requirement( target )
{
    if ( target cybercom::cybercom_aicheckoptout( "cybercom_mrpukey" ) )
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
    
    if ( isvehicle( target ) || !isdefined( target.archetype ) )
    {
        self cybercom::function_29bf9dee( target, 2 );
        return false;
    }
    
    if ( isactor( target ) && target.archetype != "human" && target.archetype != "human_riotshield" )
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

// Namespace cybercom_gadget_mrpukey
// Params 1, eflags: 0x4
// Checksum 0xa7fa5be3, Offset: 0xd68
// Size: 0x52
function private _get_valid_targets( weapon )
{
    return arraycombine( getaiteamarray( "axis" ), getaiteamarray( "team3" ), 0, 0 );
}

// Namespace cybercom_gadget_mrpukey
// Params 2, eflags: 0x4
// Checksum 0xd3560dcd, Offset: 0xdc8
// Size: 0x2e4
function private function_2de61c3f( slot, weapon )
{
    upgraded = self hascybercomability( "cybercom_mrpukey" ) == 2;
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
                
                self thread challenges::function_96ed590f( "cybercom_uses_chaos" );
                item.target thread _puke( upgraded, 0, self, weapon );
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
        itemindex = getitemindexfromref( "cybercom_mrpukey" );
        
        if ( isdefined( itemindex ) )
        {
            self adddstat( "ItemStats", itemindex, "stats", "kills", "statValue", fired );
            self adddstat( "ItemStats", itemindex, "stats", "used", "statValue", 1 );
        }
    }
}

// Namespace cybercom_gadget_mrpukey
// Params 4, eflags: 0x4
// Checksum 0xbdb74fcd, Offset: 0x10b8
// Size: 0x1ec
function private _puke( upgraded, secondary, attacker, weapon )
{
    if ( !isdefined( upgraded ) )
    {
        upgraded = 0;
    }
    
    if ( !isdefined( secondary ) )
    {
        secondary = 0;
    }
    
    self notify( #"cybercom_action", weapon, attacker );
    weapon = getweapon( "gadget_mrpukey" );
    self.ignoreall = 1;
    self.is_disabled = 1;
    self dodamage( self.health + 666, self.origin, isdefined( attacker ) ? attacker : undefined, undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1 );
    
    if ( self function_ceb2ee11() )
    {
        self waittill( #"puke" );
        playfxontag( level._effect[ "puke_reaction" ], self, "j_neck" );
        
        if ( isdefined( self.voiceprefix ) && isdefined( self.bcvoicenumber ) )
        {
            self thread battlechatter::do_sound( self.voiceprefix + self.bcvoicenumber + "_puke", 1 );
        }
        
        return;
    }
    
    wait 0.2;
    
    if ( isdefined( self ) )
    {
        if ( isdefined( self.voiceprefix ) && isdefined( self.bcvoicenumber ) )
        {
            self thread battlechatter::do_sound( self.voiceprefix + self.bcvoicenumber + "_exert_sonic", 1 );
        }
    }
}

// Namespace cybercom_gadget_mrpukey
// Params 0
// Checksum 0xada038db, Offset: 0x12b0
// Size: 0xa8, Type: bool
function function_ceb2ee11()
{
    attachsize = self getattachsize();
    
    for ( i = 0; i < attachsize ; i++ )
    {
        model_name = self getattachmodelname( i );
        
        if ( isinarray( level.cybercom.mrpukey.var_106f11dd, model_name ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace cybercom_gadget_mrpukey
// Params 3
// Checksum 0x7b482510, Offset: 0x1360
// Size: 0x2ca
function function_da7ef8ba( target, var_9bc2efcb, upgraded )
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
    
    weapon = getweapon( "gadget_mrpukey" );
    
    foreach ( guy in validtargets )
    {
        if ( !cybercom::targetisvalid( guy, weapon ) )
        {
            continue;
        }
        
        guy thread _puke( upgraded, 0, self );
        wait 0.05;
    }
}

