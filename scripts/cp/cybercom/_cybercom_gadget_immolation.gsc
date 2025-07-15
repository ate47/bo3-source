#using scripts/codescripts/struct;
#using scripts/cp/_challenges;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/ai/systems/blackboard;
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
#using scripts/shared/vehicle_ai_shared;

#namespace cybercom_gadget_immolation;

// Namespace cybercom_gadget_immolation
// Params 0
// Checksum 0x99ec1590, Offset: 0x7b0
// Size: 0x4
function init()
{
    
}

// Namespace cybercom_gadget_immolation
// Params 0
// Checksum 0xccebbc3a, Offset: 0x7c0
// Size: 0x22c
function main()
{
    cybercom_gadget::registerability( 2, 4 );
    level.cybercom.immolation = spawnstruct();
    level.cybercom.immolation._is_flickering = &_is_flickering;
    level.cybercom.immolation._on_flicker = &_on_flicker;
    level.cybercom.immolation._on_give = &_on_give;
    level.cybercom.immolation._on_take = &_on_take;
    level.cybercom.immolation._on_connect = &_on_connect;
    level.cybercom.immolation._on = &_on;
    level.cybercom.immolation._off = &_off;
    level.cybercom.immolation._is_primed = &_is_primed;
    level.cybercom.immolation.grenadelocs = array( "j_shoulder_le_rot", "j_elbow_le_rot", "j_shoulder_ri_rot", "j_elbow_ri_rot", "j_hip_le", "j_knee_le", "j_hip_ri", "j_knee_ri", "j_head", "j_mainroot" );
    level.cybercom.immolation.grenadetypes = array( "frag_grenade_notrail", "emp_grenade" );
}

// Namespace cybercom_gadget_immolation
// Params 1
// Checksum 0xf7cb068e, Offset: 0x9f8
// Size: 0xc
function _is_flickering( slot )
{
    
}

// Namespace cybercom_gadget_immolation
// Params 2
// Checksum 0x6260790c, Offset: 0xa10
// Size: 0x14
function _on_flicker( slot, weapon )
{
    
}

// Namespace cybercom_gadget_immolation
// Params 2
// Checksum 0x20aff044, Offset: 0xa30
// Size: 0xf4
function _on_give( slot, weapon )
{
    self.cybercom.var_110c156a = getdvarint( "scr_immolation_count", 1 );
    
    if ( self hascybercomability( "cybercom_immolation" ) == 2 )
    {
        self.cybercom.var_110c156a = getdvarint( "scr_immolation_upgraded_count", 1 );
    }
    
    self.cybercom.targetlockcb = &_get_valid_targets;
    self.cybercom.targetlockrequirementcb = &_lock_requirement;
    self thread cybercom::function_b5f4e597( weapon );
}

// Namespace cybercom_gadget_immolation
// Params 2
// Checksum 0x48268750, Offset: 0xb30
// Size: 0x52
function _on_take( slot, weapon )
{
    self _off( slot, weapon );
    self.cybercom.targetlockcb = undefined;
    self.cybercom.targetlockrequirementcb = undefined;
}

// Namespace cybercom_gadget_immolation
// Params 0
// Checksum 0x99ec1590, Offset: 0xb90
// Size: 0x4
function _on_connect()
{
    
}

// Namespace cybercom_gadget_immolation
// Params 2
// Checksum 0xaad1d4e3, Offset: 0xba0
// Size: 0x54
function _on( slot, weapon )
{
    self thread _activate_immolation( slot, weapon );
    self _off( slot, weapon );
}

// Namespace cybercom_gadget_immolation
// Params 2
// Checksum 0x72cef02f, Offset: 0xc00
// Size: 0x46
function _off( slot, weapon )
{
    self thread cybercom::weaponendlockwatcher( weapon );
    self.cybercom.is_primed = undefined;
    self notify( #"hash_c74ed649" );
}

// Namespace cybercom_gadget_immolation
// Params 2
// Checksum 0x501b5d5c, Offset: 0xc50
// Size: 0xb0
function _is_primed( slot, weapon )
{
    if ( !( isdefined( self.cybercom.is_primed ) && self.cybercom.is_primed ) )
    {
        assert( self.cybercom.activecybercomweapon == weapon );
        self notify( #"hash_9cefb9d9" );
        self thread cybercom::weaponlockwatcher( slot, weapon, self.cybercom.var_110c156a );
        self.cybercom.is_primed = 1;
    }
}

// Namespace cybercom_gadget_immolation
// Params 1, eflags: 0x4
// Checksum 0x550be, Offset: 0xd08
// Size: 0x308, Type: bool
function private _lock_requirement( target )
{
    if ( target cybercom::cybercom_aicheckoptout( "cybercom_immolation" ) )
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
        return false;
    }
    
    if ( isvehicle( target ) && !target _validimmolatevehicle() )
    {
        self cybercom::function_29bf9dee( target, 2 );
        return false;
    }
    
    if ( !isactor( target ) && !isvehicle( target ) )
    {
        self cybercom::function_29bf9dee( target, 2 );
        return false;
    }
    
    if ( target.archetype != "robot" && target.archetype != "human" && isactor( target ) && target.archetype != "human_riotshield" )
    {
        self cybercom::function_29bf9dee( target, 2 );
        return false;
    }
    
    if ( ( target.archetype == "human" || target.archetype == "human_riotshield" ) && isplayer( self ) )
    {
        if ( !( self hascybercomability( "cybercom_immolation" ) == 2 ) )
        {
            self cybercom::function_29bf9dee( target, 2 );
            return false;
        }
    }
    
    if ( isactor( target ) && !target isonground() && !target cybercom::function_421746e0() )
    {
        return false;
    }
    
    return true;
}

// Namespace cybercom_gadget_immolation
// Params 1, eflags: 0x4
// Checksum 0x28541bbd, Offset: 0x1018
// Size: 0x52
function private _get_valid_targets( weapon )
{
    return arraycombine( getaiteamarray( "axis" ), getaiteamarray( "team3" ), 0, 0 );
}

// Namespace cybercom_gadget_immolation
// Params 2, eflags: 0x4
// Checksum 0x28055ef7, Offset: 0x1078
// Size: 0x314
function private _activate_immolation( slot, weapon )
{
    upgraded = self hascybercomability( "cybercom_immolation" ) == 2;
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
                item.target.immolate_origin = item.target.origin;
                item.target thread _immolate( self, upgraded, 0, weapon );
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
        itemindex = getitemindexfromref( "cybercom_immolation" );
        
        if ( isdefined( itemindex ) )
        {
            self adddstat( "ItemStats", itemindex, "stats", "kills", "statValue", fired );
            self adddstat( "ItemStats", itemindex, "stats", "used", "statValue", 1 );
        }
    }
}

// Namespace cybercom_gadget_immolation
// Params 0, eflags: 0x4
// Checksum 0xd6daf44a, Offset: 0x1398
// Size: 0x8e, Type: bool
function private _validimmolatevehicle()
{
    if ( !isdefined( self.vehicletype ) )
    {
        return false;
    }
    
    if ( issubstr( self.vehicletype, "amws" ) )
    {
        return true;
    }
    
    if ( issubstr( self.vehicletype, "wasp" ) )
    {
        return true;
    }
    
    if ( issubstr( self.vehicletype, "raps" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace cybercom_gadget_immolation
// Params 3, eflags: 0x4
// Checksum 0xc4afa14f, Offset: 0x1430
// Size: 0xc4
function private _immolatevehicle( attacker, upgraded, immediate )
{
    if ( !isdefined( immediate ) )
    {
        immediate = 0;
    }
    
    assert( self _validimmolatevehicle() );
    self clientfield::set( "cybercom_immolate", 1 );
    self.is_disabled = 1;
    
    if ( !immediate )
    {
        wait randomfloatrange( 0, 0.75 );
    }
    
    self thread vehicle_ai::immolate( attacker );
}

// Namespace cybercom_gadget_immolation
// Params 4, eflags: 0x4
// Checksum 0x3dbf409b, Offset: 0x1500
// Size: 0x17c
function private _immolate( attacker, upgraded, immediate, weapon )
{
    if ( !isdefined( immediate ) )
    {
        immediate = 0;
    }
    
    self notify( #"cybercom_action", weapon, attacker );
    
    if ( self cybercom::function_421746e0() )
    {
        if ( isvehicle( self ) )
        {
            self kill( self.origin, isdefined( attacker ) ? attacker : undefined, undefined, weapon );
            return;
        }
        else
        {
            immediate = 1;
        }
    }
    
    if ( isvehicle( self ) )
    {
        self thread _immolatevehicle( attacker, upgraded );
        return;
    }
    
    if ( self.archetype == "robot" )
    {
        self thread _immolaterobot( attacker, upgraded, immediate );
        return;
    }
    
    if ( self.archetype == "human" || self.archetype == "human_riotshield" )
    {
        self thread _immolatehuman( attacker, upgraded, immediate );
    }
}

// Namespace cybercom_gadget_immolation
// Params 4
// Checksum 0xcf210e22, Offset: 0x1688
// Size: 0x12c
function _immolategrenadedetonationwatch( tag, count, attacker, weapon )
{
    msg = self util::waittill_any_timeout( 3, "death", "explode", "damage" );
    
    if ( isdefined( self.grenade_prop ) )
    {
        self.grenade_prop delete();
    }
    
    self stopsound( "gdt_immolation_human_countdown" );
    attacker thread _detonate_grenades( self, 100, count );
    
    if ( isalive( self ) )
    {
        self stopanimscripted();
        self kill( self.origin, isdefined( attacker ) ? attacker : undefined, undefined, weapon );
    }
}

// Namespace cybercom_gadget_immolation
// Params 3
// Checksum 0xebeb8db3, Offset: 0x17c0
// Size: 0x4ac
function _immolatehuman( attacker, upgraded, immediate )
{
    if ( !isdefined( immediate ) )
    {
        immediate = 0;
    }
    
    self endon( #"death" );
    weapon = getweapon( "gadget_immolation" );
    self clientfield::set( "cybercom_immolate", 1 );
    
    if ( immediate )
    {
        self.ignoreall = 1;
        self clientfield::set( "arch_actor_fire_fx", 1 );
        self thread _corpsewatcher();
        util::wait_network_frame();
        self thread _immolategrenadedetonationwatch( "tag_weapon_chest", undefined, attacker, weapon );
        self kill( self.origin, isdefined( attacker ) ? attacker : undefined, undefined, weapon );
        return;
    }
    
    wait randomfloatrange( 0.1, 0.75 );
    
    if ( !attacker cybercom::targetisvalid( self, weapon, 0 ) )
    {
        return;
    }
    
    self.is_disabled = 1;
    self.ignoreall = 1;
    tag = undefined;
    numgrenades = undefined;
    
    if ( self.archetype != "human_riotshield" && self cybercom::getentitypose() == "stand" && randomint( 100 ) < getdvarint( "scr_immolation_specialanimchance", 15 ) )
    {
        self notify( #"bhtn_action_notify", "reactImmolationLong" );
        self thread _immolategrenadedetonationwatch( "tag_inhand", 1, attacker, weapon );
        self animscripted( "immo_anim", self.origin, self.angles, "ai_base_rifle_stn_exposed_immolate_explode_midthrow" );
        self thread cybercom::stopanimscriptedonnotify( "damage_pain", "immo_anim", 1, attacker, weapon );
        self waittillmatch( #"immo_anim", "grenade_right" );
        self.grenade_prop = spawn( "script_model", self gettagorigin( "tag_inhand" ) );
        self.grenade_prop setmodel( "wpn_t7_grenade_frag_world" );
        self.grenade_prop enablelinkto();
        self.grenade_prop linkto( self, "tag_inhand" );
        playfxontag( "light/fx_ability_light_chest_immolation", self.grenade_prop, "tag_origin" );
        self waittillmatch( #"immo_anim", "explode" );
        self stopsound( "gdt_immolation_human_countdown" );
        self notify( #"explode" );
        return;
    }
    
    self notify( #"bhtn_action_notify", "reactImmolation" );
    self dodamage( 5, self.origin, isdefined( attacker ) ? attacker : undefined, undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1 );
    playfxontag( "light/fx_ability_light_chest_immolation", self, "tag_weapon_chest" );
    self thread function_f8956516();
    self thread _immolategrenadedetonationwatch( "tag_weapon_chest", undefined, attacker, weapon );
}

// Namespace cybercom_gadget_immolation
// Params 0
// Checksum 0x412b751c, Offset: 0x1c78
// Size: 0x52
function function_f8956516()
{
    self endon( #"death" );
    self waittillmatch( #"bhtn_action_terminate", "specialpain" );
    self stopsound( "gdt_immolation_human_countdown" );
    self notify( #"explode" );
}

// Namespace cybercom_gadget_immolation
// Params 3
// Checksum 0x76293f08, Offset: 0x1cd8
// Size: 0x524
function _immolaterobot( attacker, upgraded, immediate )
{
    if ( !isdefined( immediate ) )
    {
        immediate = 0;
    }
    
    self endon( #"death" );
    
    if ( !immediate )
    {
        wait randomfloatrange( 0.1, 0.75 );
    }
    
    weapon = getweapon( "gadget_immolation" );
    
    if ( !attacker cybercom::targetisvalid( self, weapon, 0 ) )
    {
        return;
    }
    
    self.is_disabled = 1;
    
    if ( isdefined( self.iscrawler ) && self.iscrawler || !cybercom::function_76e3026d( self ) )
    {
        self playsound( "wpn_incendiary_explode" );
        physicsexplosionsphere( self.origin, 200, 32, 2 );
        self immolate_nearby( attacker, upgraded );
        origin = self.origin;
        self dodamage( self.health, self.origin, isdefined( attacker ) ? attacker : undefined, isdefined( attacker ) ? attacker : undefined, "none", "MOD_BURNED", 0, weapon, -1, 1 );
        wait 0.1;
        radiusdamage( origin, getdvarint( "scr_immolation_outer_radius", 235 ), 500, 30, isdefined( attacker ) ? attacker : undefined, "MOD_EXPLOSIVE", weapon );
        return;
    }
    
    self clientfield::set( "arch_actor_fire_fx", 1 );
    self clientfield::set( "cybercom_immolate", 1 );
    self thread _corpsewatcher();
    self.ignoreall = 1;
    type = self cybercom::function_5e3d3aa();
    self.ignoreall = 1;
    variant = "_" + randomint( 3 );
    
    if ( variant == "_0" )
    {
        variant = "";
    }
    
    var_a30bdd5a = getdvarfloat( "scr_immolation_death_delay", 0.87 ) + randomfloatrange( 0, 0.2 );
    time_until_detonation = gettime() + var_a30bdd5a * 1000;
    self dodamage( 5, self.origin, isdefined( attacker ) ? attacker : undefined, undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1 );
    
    while ( gettime() < time_until_detonation )
    {
        wait 0.1;
    }
    
    self clientfield::set( "cybercom_immolate", 2 );
    self immolate_nearby( attacker, upgraded );
    
    if ( upgraded )
    {
    }
    
    level notify( #"hash_f90d73d4" );
    attacker notify( #"hash_f90d73d4" );
    util::wait_network_frame();
    origin = self.origin;
    self dodamage( self.health, self.origin, isdefined( attacker ) ? attacker : undefined, isdefined( attacker ) ? attacker : undefined, "none", "MOD_BURNED", 0, weapon, -1, 1 );
    radiusdamage( origin, getdvarint( "scr_immolation_outer_radius", 235 ), 500, 30, isdefined( attacker ) ? attacker : undefined, "MOD_EXPLOSIVE", weapon );
}

// Namespace cybercom_gadget_immolation
// Params 0, eflags: 0x4
// Checksum 0x9db6324e, Offset: 0x2208
// Size: 0x54
function private _corpsewatcher()
{
    archetype = self.archetype;
    self waittill( #"actor_corpse", corpse );
    corpse clientfield::set( "arch_actor_fire_fx", 2 );
}

// Namespace cybercom_gadget_immolation
// Params 3, eflags: 0x4
// Checksum 0x9b9c19b0, Offset: 0x2268
// Size: 0x2c8
function private _detonate_grenades( guy, chance, numextradetonations )
{
    if ( !isdefined( chance ) )
    {
        chance = getdvarint( "scr_immolation_gchance", 100 );
    }
    
    self endon( #"disconnect" );
    loc = guy _get_grenade_spawn_loc();
    
    if ( !isdefined( loc ) )
    {
        loc = guy.origin + ( 0, 0, 50 );
    }
    
    grenade = self magicgrenadetype( getweapon( "frag_grenade_notrail" ), loc, ( 0, 0, 0 ), 0 );
    
    if ( !isdefined( numextradetonations ) )
    {
        numextradetonations = randomint( getdvarint( "scr_immolation_gcount", 3 ) ) + 1;
    }
    
    while ( numextradetonations && isdefined( self ) && isdefined( guy ) )
    {
        wait randomfloatrange( getdvarfloat( "scr_immolation_grenade_wait_timeMIN", 0.3 ), getdvarfloat( "scr_immolation_grenade_wait_timeMAX", 0.9 ) );
        numextradetonations--;
        
        if ( randomint( 100 ) > chance )
        {
            continue;
        }
        
        gtype = level.cybercom.immolation.grenadetypes[ randomint( level.cybercom.immolation.grenadetypes.size ) ];
        
        /#
        #/
        
        if ( isdefined( guy ) )
        {
            loc = guy _get_grenade_spawn_loc();
            
            if ( !isdefined( loc ) )
            {
                loc = guy.origin + ( 0, 0, 50 );
            }
        }
        
        if ( isdefined( loc ) )
        {
            grenade = self magicgrenadetype( getweapon( gtype ), loc, ( 0, 0, 0 ), 0.05 );
            grenade thread waitforexplode();
        }
    }
}

// Namespace cybercom_gadget_immolation
// Params 0
// Checksum 0xf6dd4892, Offset: 0x2538
// Size: 0x4c
function waitforexplode()
{
    self util::waittill_any_timeout( 3, "death", "detonated" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace cybercom_gadget_immolation
// Params 2, eflags: 0x4
// Checksum 0x5530daba, Offset: 0x2590
// Size: 0x1b2
function private _detonate_grenades_inrange( player, rangemax )
{
    weapon = getweapon( "gadget_immolation" );
    enemies = arraycombine( getaispeciesarray( "axis", "robot" ), getaispeciesarray( "team3", "robot" ), 0, 0 );
    closetargets = arraysortclosest( enemies, self.origin, enemies.size, 0, rangemax );
    
    foreach ( guy in closetargets )
    {
        if ( player cybercom::targetisvalid( guy, weapon ) )
        {
            if ( isdefined( guy.grenades_detonated ) && guy.grenades_detonated )
            {
                continue;
            }
            
            guy.grenades_detonated = 1;
            player thread _detonate_grenades( guy );
        }
    }
}

// Namespace cybercom_gadget_immolation
// Params 2
// Checksum 0x7a5f22c4, Offset: 0x2750
// Size: 0x1fa
function immolate_nearby( attacker, upgraded )
{
    weapon = getweapon( "gadget_immolation" );
    targets = _get_valid_targets();
    var_5b8b9202 = 0;
    closetargets = arraysortclosest( targets, self.origin, 666, 0, getdvarint( "scr_immolation_radius", 150 ) );
    
    foreach ( guy in closetargets )
    {
        if ( guy == self )
        {
            continue;
        }
        
        if ( isdefined( attacker.var_a691a602 ) )
        {
            if ( attacker.var_a691a602 >= 2 )
            {
                break;
            }
        }
        
        if ( attacker cybercom::targetisvalid( guy, weapon ) )
        {
            if ( !isdefined( attacker.var_a691a602 ) )
            {
                attacker thread function_4f174738();
            }
            else
            {
                attacker.var_a691a602++;
            }
            
            if ( isvehicle( guy ) )
            {
                continue;
            }
            
            guy thread _immolate( attacker, upgraded, 1, weapon );
        }
    }
}

// Namespace cybercom_gadget_immolation
// Params 0, eflags: 0x4
// Checksum 0x24dd27fd, Offset: 0x2958
// Size: 0xb2
function private _get_grenade_spawn_loc()
{
    if ( isdefined( self.archetype ) && self.archetype == "human" )
    {
        return self gettagorigin( "tag_weapon_chest" );
    }
    
    tag = level.cybercom.immolation.grenadelocs[ randomint( level.cybercom.immolation.grenadelocs.size ) ];
    return self gettagorigin( tag );
}

// Namespace cybercom_gadget_immolation
// Params 3
// Checksum 0x41e07c47, Offset: 0x2a18
// Size: 0x2da
function ai_activateimmolate( target, var_9bc2efcb, upgraded )
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
    
    weapon = getweapon( "gadget_immolation" );
    
    foreach ( guy in validtargets )
    {
        if ( !self cybercom::targetisvalid( guy, weapon ) )
        {
            continue;
        }
        
        guy thread _immolate( self, upgraded, 0, getweapon( "gadget_immolation" ) );
        wait 0.05;
    }
}

// Namespace cybercom_gadget_immolation
// Params 0
// Checksum 0xa42170d5, Offset: 0x2d00
// Size: 0x26
function function_4f174738()
{
    self endon( #"death" );
    self.var_a691a602 = 0;
    wait 2;
    self.var_a691a602 = undefined;
}

