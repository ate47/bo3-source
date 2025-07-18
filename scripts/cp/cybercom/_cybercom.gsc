#using scripts/codescripts/struct;
#using scripts/cp/cybercom/_cybercom_dev;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_gadget_concussive_wave;
#using scripts/cp/cybercom/_cybercom_gadget_electrostatic_strike;
#using scripts/cp/cybercom/_cybercom_gadget_exosuitbreakdown;
#using scripts/cp/cybercom/_cybercom_gadget_firefly;
#using scripts/cp/cybercom/_cybercom_gadget_forced_malfunction;
#using scripts/cp/cybercom/_cybercom_gadget_iff_override;
#using scripts/cp/cybercom/_cybercom_gadget_immolation;
#using scripts/cp/cybercom/_cybercom_gadget_mrpukey;
#using scripts/cp/cybercom/_cybercom_gadget_security_breach;
#using scripts/cp/cybercom/_cybercom_gadget_sensory_overload;
#using scripts/cp/cybercom/_cybercom_gadget_servo_shortout;
#using scripts/cp/cybercom/_cybercom_gadget_smokescreen;
#using scripts/cp/cybercom/_cybercom_gadget_surge;
#using scripts/cp/cybercom/_cybercom_gadget_system_overload;
#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/cp/cybercom/_cybercom_tactical_rig_emergencyreserve;
#using scripts/cp/cybercom/_cybercom_tactical_rig_proximitydeterrent;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/ai_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace cybercom;

// Namespace cybercom
// Params 0, eflags: 0x2
// Checksum 0x87d74700, Offset: 0x978
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "cybercom", &init, &main, undefined );
}

// Namespace cybercom
// Params 0
// Checksum 0x614a0b0d, Offset: 0x9c0
// Size: 0x3c4
function init()
{
    clientfield::register( "world", "cybercom_disabled", 1, 1, "int" );
    clientfield::register( "toplayer", "cybercom_disabled", 1, 1, "int" );
    clientfield::register( "vehicle", "cybercom_setiffname", 1, 3, "int" );
    clientfield::register( "actor", "cybercom_setiffname", 1, 3, "int" );
    clientfield::register( "actor", "cybercom_immolate", 1, 2, "int" );
    clientfield::register( "vehicle", "cybercom_immolate", 1, 1, "int" );
    clientfield::register( "actor", "cybercom_sysoverload", 1, 2, "int" );
    clientfield::register( "vehicle", "cybercom_sysoverload", 1, 1, "int" );
    clientfield::register( "actor", "cybercom_surge", 1, 2, "int" );
    clientfield::register( "vehicle", "cybercom_surge", 1, 2, "int" );
    clientfield::register( "scriptmover", "cybercom_surge", 1, 1, "int" );
    clientfield::register( "actor", "cybercom_shortout", 1, 2, "int" );
    clientfield::register( "vehicle", "cybercom_shortout", 1, 2, "int" );
    clientfield::register( "allplayers", "cyber_arm_pulse", 1, 2, "counter" );
    clientfield::register( "actor", "cyber_arm_pulse", 1, 2, "counter" );
    clientfield::register( "scriptmover", "cyber_arm_pulse", 1, 2, "counter" );
    clientfield::register( "toplayer", "hacking_progress", 1, 12, "int" );
    clientfield::register( "clientuimodel", "playerAbilities.inRange", 1, 1, "int" );
    clientfield::register( "toplayer", "resetAbilityWheel", 1, 1, "int" );
    cybercom_gadget::init();
    cybercom_tacrig::init();
    function_beff8cf9();
}

// Namespace cybercom
// Params 3
// Checksum 0x1fb06128, Offset: 0xd90
// Size: 0x78
function function_4ee56464( var_23810282, var_442fb6cd, var_6ee14d17 )
{
    returnstruct = spawnstruct();
    returnstruct.var_974cd16f = var_23810282;
    returnstruct.var_e909f6f0 = var_442fb6cd;
    returnstruct.var_3d1b9c0c = var_6ee14d17;
    return returnstruct;
}

// Namespace cybercom
// Params 0
// Checksum 0xa3844a23, Offset: 0xe10
// Size: 0x4e
function function_beff8cf9()
{
    level.var_e4e6dd84 = [];
    level.var_e4e6dd84[ "default" ] = function_4ee56464( 0.5, 0.5, 0.5 );
}

// Namespace cybercom
// Params 2
// Checksum 0x85bc197, Offset: 0xe68
// Size: 0x13c
function ability_on( slot, weapon )
{
    self gadgetsetactivatetime( slot, gettime() );
    
    if ( !isdefined( self.spawntime ) || gettime() - self.spawntime > 200 )
    {
        if ( getdvarint( "ai_awarenessEnabled" ) && isdefined( weapon ) && issubstr( weapon.name, "hijack" ) )
        {
            return;
        }
        
        self generatescriptevent();
    }
    
    if ( isplayer( self ) )
    {
        if ( !isdefined( self.var_1c0132c[ weapon.name ] ) )
        {
            self.var_1c0132c[ weapon.name ] = 0;
        }
        
        self.var_1c0132c[ weapon.name ]++;
        self matchrecordlogcybercoreevent( weapon, self.origin, gettime(), 0 );
    }
}

// Namespace cybercom
// Params 2
// Checksum 0x9290920f, Offset: 0xfb0
// Size: 0x14
function ability_off( slot, weapon )
{
    
}

// Namespace cybercom
// Params 0
// Checksum 0xd6367e7b, Offset: 0xfd0
// Size: 0x11c
function initialize()
{
    level.cybercom = spawnstruct();
    level.cybercom.abilities = [];
    level.cybercom.swarms_released = 0;
    level.cybercom.var_12f85dec = 0;
    level.cybercom._ability_turn_on = &ability_on;
    level.cybercom._ability_turn_off = &ability_off;
    level.vehicle_initializer_cb = &vehicle_init_cybercom;
    level.vehicle_destructer_cb = &function_79bafe1d;
    level.vehicle_defense_cb = &function_fabadf47;
    level.cybercom.overrideactordamage = &function_25889576;
    level.cybercom.overridevehicledamage = &function_17136681;
}

// Namespace cybercom
// Params 15
// Checksum 0xfa02853d, Offset: 0x10f8
// Size: 0x32a
function function_25889576( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, modelindex, surfacetype, surfacenormal )
{
    if ( issubstr( smeansofdeath, "MELEE" ) )
    {
        self notify( #"hash_95cdc515" );
        
        if ( weapon == getweapon( "gadget_es_strike" ) || weapon == getweapon( "gadget_es_strike_upgraded" ) )
        {
            idamage = 0;
            
            if ( !isdefined( shitloc ) || shitloc == "none" )
            {
                return idamage;
            }
            
            level notify( #"es_strike", self, eattacker, idamage, weapon, vpoint );
            var_2d399bc8 = 1;
        }
        
        if ( weapon == getweapon( "gadget_ravage_core_upgraded" ) && isdefined( self.archetype ) && ( weapon == getweapon( "gadget_ravage_core" ) || self.archetype == "robot" ) )
        {
            self ai::set_behavior_attribute( "can_gib", 0 );
            level notify( #"ravage_core", self, eattacker, idamage, weapon, vpoint );
            var_2d399bc8 = 1;
        }
        
        if ( weapon == getweapon( "gadget_rapid_strike" ) || weapon == getweapon( "gadget_rapid_strike_upgraded" ) )
        {
            level notify( #"rapid_strike", self, eattacker, idamage, weapon, vpoint );
            var_2d399bc8 = 1;
        }
    }
    else if ( smeansofdeath == "MOD_GRENADE_SPLASH" )
    {
        if ( weapon.name == "ravage_core_emp_grenade" )
        {
            if ( self.archetype == "human" || isdefined( self.archetype ) && self.archetype == "zombie" )
            {
                idamage = 60;
            }
        }
    }
    
    if ( isdefined( self.tokubetsukogekita ) && self.tokubetsukogekita && isdefined( eattacker ) && !isplayer( eattacker ) )
    {
        idamage = 1;
    }
    
    if ( idamage > 30 )
    {
        self notify( #"hash_15b29ba5" );
    }
    
    return idamage;
}

// Namespace cybercom
// Params 15
// Checksum 0x5cdb7d2b, Offset: 0x1430
// Size: 0x114
function function_17136681( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    if ( smeansofdeath == "MOD_MELEE" )
    {
        self notify( #"hash_95cdc515" );
        
        if ( weapon == getweapon( "gadget_es_strike" ) || weapon == getweapon( "gadget_es_strike_upgraded" ) )
        {
            idamage = 0;
            level notify( #"es_strike", self, eattacker, idamage, weapon, vpoint );
            var_2d399bc8 = 1;
        }
    }
    
    return idamage;
}

// Namespace cybercom
// Params 0
// Checksum 0x713def83, Offset: 0x1550
// Size: 0xb4
function main()
{
    callback::on_connect( &on_player_connect );
    callback::on_spawned( &on_player_spawned );
    
    if ( !isdefined( level.cybercom ) )
    {
        initialize();
    }
    
    cybercom_gadget::main();
    cybercom_tacrig::main();
    level thread wait_to_load();
    level thread _cybercom_notify_toggle();
}

// Namespace cybercom
// Params 0
// Checksum 0xcd5b6723, Offset: 0x1610
// Size: 0xac
function on_player_connect()
{
    self.cybercom = spawnstruct();
    self.cybercom.flags = spawnstruct();
    self.cybercom.var_b766574c = 0;
    self.var_1c0132c = [];
    self getcybercomflags();
    self.pers[ "cybercom_flags" ] = self.cybercom.flags;
    self thread on_menu_response();
}

// Namespace cybercom
// Params 0
// Checksum 0x21b6106a, Offset: 0x16c8
// Size: 0x1ee
function on_player_spawned()
{
    self.cybercom.lock_targets = [];
    self.cybercom.var_4eb8cd67 = [];
    self setabilitiesbyflags( self.pers[ "cybercom_flags" ] );
    self flagsys::set( "cybercom_init" );
    self.cybercom.given_first_ability = 0;
    self.cybercom.var_8967863e = 1;
    self.cybercom.var_18714ef0 = self gadgetpowerget( 0 );
    self.cybercom.var_3e73c959 = self gadgetpowerget( 1 );
    self.cybercom.var_647643c2 = self gadgetpowerget( 2 );
    var_8e1e095b = self getcybercomactivetype();
    
    switch ( var_8e1e095b )
    {
        case 0:
            self cybercom_gadget::meleeabilitygiven( cybercom_gadget::getabilitybyname( "cybercom_ravagecore" ) );
            break;
        case 1:
            self cybercom_gadget::meleeabilitygiven( cybercom_gadget::getabilitybyname( "cybercom_rapidstrike" ) );
            break;
        case 2:
            self cybercom_gadget::meleeabilitygiven( cybercom_gadget::getabilitybyname( "cybercom_es_strike" ) );
            break;
    }
}

// Namespace cybercom
// Params 1, eflags: 0x4
// Checksum 0x7775f832, Offset: 0x18c0
// Size: 0x20
function private function_b1497851( menu )
{
    self.cybercom.var_5e76d31b = 1;
}

// Namespace cybercom
// Params 2, eflags: 0x4
// Checksum 0x27de017b, Offset: 0x18e8
// Size: 0x28
function private function_4d11675a( menu, response )
{
    self.cybercom.var_5e76d31b = 0;
}

// Namespace cybercom
// Params 0
// Checksum 0xcf6e9f6a, Offset: 0x1918
// Size: 0x2a0
function on_menu_response()
{
    self endon( #"disconnect" );
    self notify( #"start_ccom_menu_response" );
    self endon( #"start_ccom_menu_response" );
    
    for ( ;; )
    {
        self waittill( #"menuresponse", menu, response );
        
        if ( isdefined( self.cybercom.menu ) && menu == self.cybercom.menu )
        {
            if ( isdefined( self.cybercom.is_primed ) && self.cybercom.is_primed )
            {
                continue;
            }
            
            if ( isdefined( self.cybercom.var_dd2f3b84 ) && self.cybercom.var_dd2f3b84 )
            {
                continue;
            }
            
            responsearray = strtok( response, "," );
            
            if ( response == "opened" )
            {
                self function_b1497851( menu );
                continue;
            }
            
            if ( responsearray.size > 1 )
            {
                self.var_768ee804 = int( responsearray[ 1 ] );
                ability = self cybercom_gadget::equipability( responsearray[ 0 ] );
                self clientfield::set_to_player( "resetAbilityWheel", 0 );
                self notify( #"hash_9a680733" );
                
                if ( isdefined( ability ) )
                {
                    switch ( ability.type )
                    {
                        case 0:
                            self cybercom_gadget::meleeabilitygiven( cybercom_gadget::getabilitybyname( "cybercom_ravagecore" ) );
                            break;
                        case 1:
                            self cybercom_gadget::meleeabilitygiven( cybercom_gadget::getabilitybyname( "cybercom_rapidstrike" ) );
                            break;
                        case 2:
                            self cybercom_gadget::meleeabilitygiven( cybercom_gadget::getabilitybyname( "cybercom_es_strike" ) );
                            break;
                    }
                }
                
                self function_4d11675a( menu, response );
            }
        }
    }
}

// Namespace cybercom
// Params 1
// Checksum 0xe39f5d58, Offset: 0x1bc0
// Size: 0x200
function disablecybercom( var_1e41d598 )
{
    assert( isplayer( self ) );
    self.cybercom.var_18714ef0 = self gadgetpowerget( 0 );
    self.cybercom.var_3e73c959 = self gadgetpowerget( 1 );
    self.cybercom.var_647643c2 = self gadgetpowerget( 1 );
    self.cybercom.var_384c5e6e = var_1e41d598;
    self notify( #"cybercom_disabled" );
    
    if ( isdefined( self.cybercom.activecybercommeleeweapon ) && self hasweapon( self.cybercom.activecybercommeleeweapon ) )
    {
        self.cybercom.var_7116dac7 = self.cybercom.activecybercommeleeweapon;
        self takeweapon( self.cybercom.activecybercommeleeweapon );
        self.cybercom.activecybercommeleeweapon = undefined;
    }
    
    if ( isdefined( self.cybercom.activecybercomweapon ) )
    {
        self takeweapon( self.cybercom.activecybercomweapon );
        self notify( #"weapon_taken", self.cybercom.activecybercomweapon );
        self.cybercom.activecybercomweapon = undefined;
    }
    
    self clientfield::set_to_player( "cybercom_disabled", 1 );
    self.cybercom.var_8967863e = 0;
}

// Namespace cybercom
// Params 0
// Checksum 0x18556843, Offset: 0x1dc8
// Size: 0x228
function enablecybercom()
{
    assert( isplayer( self ) );
    self clientfield::set_to_player( "cybercom_disabled", 0 );
    
    if ( isdefined( self.cybercom.lastequipped ) )
    {
        self cybercom_gadget::equipability( self.cybercom.lastequipped.name );
    }
    
    if ( isdefined( self.cybercom.var_7116dac7 ) )
    {
        self giveweapon( self.cybercom.var_7116dac7 );
        self.cybercom.activecybercommeleeweapon = self.cybercom.var_7116dac7;
        self.cybercom.var_7116dac7 = undefined;
    }
    
    if ( isdefined( self.cybercom.var_384c5e6e ) && self.cybercom.var_384c5e6e )
    {
        if ( isdefined( self.cybercom.var_18714ef0 ) )
        {
            self gadgetpowerset( 0, self.cybercom.var_18714ef0 );
        }
        
        if ( isdefined( self.cybercom.var_3e73c959 ) )
        {
            self gadgetpowerset( 1, self.cybercom.var_3e73c959 );
        }
        
        if ( isdefined( self.cybercom.var_647643c2 ) )
        {
            self gadgetpowerset( 2, self.cybercom.var_647643c2 );
        }
        
        self.cybercom.var_18714ef0 = undefined;
        self.cybercom.var_3e73c959 = undefined;
        self.cybercom.var_647643c2 = undefined;
        self.cybercom.var_384c5e6e = undefined;
    }
    
    self.cybercom.var_8967863e = 1;
}

// Namespace cybercom
// Params 0
// Checksum 0x6c132135, Offset: 0x1ff8
// Size: 0x34
function _cybercom_notify_toggle()
{
    level thread _cybercom_notify_toggle_on();
    level thread _cybercom_notify_toggle_off();
}

// Namespace cybercom
// Params 0
// Checksum 0x8d41c7d3, Offset: 0x2038
// Size: 0x12e
function _cybercom_notify_toggle_on()
{
    level notify( #"_cybercom_notify_toggle_on" );
    level endon( #"_cybercom_notify_toggle_on" );
    
    while ( true )
    {
        level waittill( #"enable_cybercom", player );
        
        if ( isdefined( player ) )
        {
            player enablecybercom();
            continue;
        }
        
        level clientfield::set( "cybercom_disabled", 0 );
        setdvar( "cybercom_enabled", 1 );
        
        foreach ( player in getplayers() )
        {
            player enablecybercom();
        }
    }
}

// Namespace cybercom
// Params 0
// Checksum 0x5b6bf20f, Offset: 0x2170
// Size: 0x13e
function _cybercom_notify_toggle_off()
{
    level notify( #"_cybercom_notify_toggle_off" );
    level endon( #"_cybercom_notify_toggle_off" );
    
    while ( true )
    {
        level waittill( #"disable_cybercom", player, var_1e41d598 );
        
        if ( isdefined( player ) )
        {
            player disablecybercom( var_1e41d598 );
            continue;
        }
        
        level clientfield::set( "cybercom_disabled", 1 );
        setdvar( "cybercom_enabled", 0 );
        
        foreach ( player in getplayers() )
        {
            player disablecybercom();
        }
    }
}

// Namespace cybercom
// Params 7
// Checksum 0xecdcd778, Offset: 0x22b8
// Size: 0xcc
function cybercom_getadjusteddamage( player, eattacker, einflictor, idamage, weapon, shitloc, smeansofdamage )
{
    if ( player hascybercomrig( "cybercom_proximitydeterrent" ) != 0 )
    {
        if ( isdefined( eattacker ) && eattacker.classname != "trigger_hurt" && eattacker.classname != "worldspawn" )
        {
            idamage = player cybercom_tacrig_proximitydeterrent::function_327bda1e( idamage, smeansofdamage );
        }
    }
    
    return idamage;
}

// Namespace cybercom
// Params 4
// Checksum 0x6fd4faf, Offset: 0x2390
// Size: 0x2e4
function function_d240e350( var_7872e02, target, var_9bc2efcb, upgraded )
{
    if ( !isdefined( var_9bc2efcb ) )
    {
        var_9bc2efcb = 1;
    }
    
    if ( !isdefined( upgraded ) )
    {
        upgraded = 0;
    }
    
    self endon( #"death" );
    
    while ( var_9bc2efcb && self isplayinganimscripted() )
    {
        wait 0.1;
    }
    
    switch ( var_7872e02 )
    {
        case "cybercom_iffoverride":
            cybercom_gadget_iff_override::ai_activateiffoverride( target, var_9bc2efcb );
            break;
        case "cybercom_systemoverload":
            cybercom_gadget_system_overload::ai_activatesystemoverload( target, var_9bc2efcb );
            break;
        case "cybercom_servoshortout":
            cybercom_gadget_servo_shortout::ai_activateservoshortout( target, var_9bc2efcb );
            break;
        case "cybercom_exosuitbreakdown":
            cybercom_gadget_exosuitbreakdown::ai_activateexosuitbreakdown( target, var_9bc2efcb );
            break;
        case "cybercom_surge":
            cybercom_gadget_surge::ai_activatesurge( target, var_9bc2efcb, upgraded );
            break;
        case "cybercom_sensoryoverload":
            cybercom_gadget_sensory_overload::ai_activatesensoryoverload( target, var_9bc2efcb );
            break;
        case "cybercom_forcedmalfunction":
            cybercom_gadget_forced_malfunction::ai_activateforcedmalfuncton( target, var_9bc2efcb );
            break;
        case "cybercom_fireflyswarm":
            cybercom_gadget_firefly::ai_activatefireflyswarm( target, var_9bc2efcb, upgraded );
            break;
        case "cybercom_immolation":
            cybercom_gadget_immolation::ai_activateimmolate( target, var_9bc2efcb, upgraded );
            break;
        case "cybercom_mrpukey":
            cybercom_gadget_mrpukey::function_da7ef8ba( target, var_9bc2efcb, upgraded );
            break;
        case "cybercom_concussive":
            cybercom_gadget_concussive_wave::ai_activateconcussivewave( target, var_9bc2efcb );
            break;
        case "cybercom_smokescreen":
            cybercom_gadget_smokescreen::ai_activatesmokescreen( var_9bc2efcb, upgraded );
            break;
        case "cybercom_es_strike":
            cybercom_gadget_electrostatic_strike::ai_activateelectrostaticstrike( upgraded );
            break;
        default:
            assert( 0, "<dev string:x28>" );
            break;
    }
    
    self playsound( "gdt_cybercore_activate_ai" );
}

