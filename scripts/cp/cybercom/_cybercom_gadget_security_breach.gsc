#using scripts/codescripts/struct;
#using scripts/cp/_challenges;
#using scripts/cp/_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/player_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace cybercom_gadget_security_breach;

// Namespace cybercom_gadget_security_breach
// Params 0
// Checksum 0x6da6a11e, Offset: 0x7b0
// Size: 0x1d4
function init()
{
    clientfield::register( "toplayer", "hijack_vehicle_transition", 1, 2, "int" );
    clientfield::register( "toplayer", "hijack_static_effect", 1, 7, "float" );
    clientfield::register( "toplayer", "sndInDrivableVehicle", 1, 1, "int" );
    clientfield::register( "vehicle", "vehicle_hijacked", 1, 1, "int" );
    clientfield::register( "toplayer", "hijack_spectate", 1, 1, "int" );
    clientfield::register( "toplayer", "hijack_static_ramp_up", 1, 1, "int" );
    clientfield::register( "toplayer", "vehicle_hijacked", 1, 1, "int" );
    visionset_mgr::register_info( "visionset", "hijack_vehicle", 1, 5, 1, 1 );
    visionset_mgr::register_info( "visionset", "hijack_vehicle_blur", 1, 6, 1, 1 );
    callback::on_spawned( &on_player_spawned );
}

// Namespace cybercom_gadget_security_breach
// Params 0
// Checksum 0xb2205049, Offset: 0x990
// Size: 0x17c
function main()
{
    cybercom_gadget::registerability( 0, 32 );
    level.cybercom.security_breach = spawnstruct();
    level.cybercom.security_breach._is_flickering = &_is_flickering;
    level.cybercom.security_breach._on_flicker = &_on_flicker;
    level.cybercom.security_breach._on_give = &_on_give;
    level.cybercom.security_breach._on_take = &_on_take;
    level.cybercom.security_breach._on_connect = &_on_connect;
    level.cybercom.security_breach._on = &_on;
    level.cybercom.security_breach._off = &_off;
    level.cybercom.security_breach._is_primed = &_is_primed;
}

// Namespace cybercom_gadget_security_breach
// Params 0
// Checksum 0x1fd3723d, Offset: 0xb18
// Size: 0x94
function on_player_spawned()
{
    self clientfield::set_to_player( "hijack_static_effect", 0 );
    self clientfield::set_to_player( "hijack_spectate", 0 );
    self clientfield::set_to_player( "hijack_static_ramp_up", 0 );
    self util::freeze_player_controls( 0 );
    self cameraactivate( 0 );
}

// Namespace cybercom_gadget_security_breach
// Params 1
// Checksum 0xa56badab, Offset: 0xbb8
// Size: 0xc
function _is_flickering( slot )
{
    
}

// Namespace cybercom_gadget_security_breach
// Params 2
// Checksum 0xf658735e, Offset: 0xbd0
// Size: 0x14
function _on_flicker( slot, weapon )
{
    
}

// Namespace cybercom_gadget_security_breach
// Params 2
// Checksum 0x2b7954fa, Offset: 0xbf0
// Size: 0x13c
function _on_give( slot, weapon )
{
    self.cybercom.var_110c156a = 1;
    self.cybercom.security_breach_lifetime = getdvarint( "scr_security_breach_lifetime", 30 );
    
    if ( self hascybercomability( "cybercom_securitybreach" ) == 2 )
    {
        self.cybercom.security_breach_lifetime = getdvarint( "scr_security_breach_upgraded_lifetime", 60 );
    }
    
    self.cybercom.targetlockcb = &_get_valid_targets;
    self.cybercom.targetlockrequirementcb = &_lock_requirement;
    self.cybercom.var_73d069a7 = &function_17342509;
    self.cybercom.var_46483c8f = 63;
    self thread cybercom::function_b5f4e597( weapon );
}

// Namespace cybercom_gadget_security_breach
// Params 2
// Checksum 0x815aac1a, Offset: 0xd38
// Size: 0x72
function _on_take( slot, weapon )
{
    self _off( slot, weapon );
    self.cybercom.targetlockcb = undefined;
    self.cybercom.targetlockrequirementcb = undefined;
    self.cybercom.var_46483c8f = undefined;
    self.cybercom.var_73d069a7 = undefined;
}

// Namespace cybercom_gadget_security_breach
// Params 0
// Checksum 0x99ec1590, Offset: 0xdb8
// Size: 0x4
function _on_connect()
{
    
}

// Namespace cybercom_gadget_security_breach
// Params 2
// Checksum 0x773a4088, Offset: 0xdc8
// Size: 0x4c
function function_17342509( slot, weapon )
{
    self gadgetactivate( slot, weapon );
    _on( slot, weapon );
}

// Namespace cybercom_gadget_security_breach
// Params 2
// Checksum 0x7d4ee75b, Offset: 0xe20
// Size: 0x54
function _on( slot, weapon )
{
    self thread _activate_security_breach( slot, weapon );
    self _off( slot, weapon );
}

// Namespace cybercom_gadget_security_breach
// Params 2
// Checksum 0x28b29453, Offset: 0xe80
// Size: 0x46
function _off( slot, weapon )
{
    self thread cybercom::weaponendlockwatcher( weapon );
    self.cybercom.is_primed = undefined;
    self notify( #"hash_8216024" );
}

// Namespace cybercom_gadget_security_breach
// Params 2
// Checksum 0x2635fa08, Offset: 0xed0
// Size: 0xcc
function _is_primed( slot, weapon )
{
    if ( !( isdefined( self.cybercom.is_primed ) && self.cybercom.is_primed ) )
    {
        assert( self.cybercom.activecybercomweapon == weapon );
        self notify( #"hash_50db7e6" );
        self thread cybercom::weaponlockwatcher( slot, weapon, self.cybercom.var_110c156a );
        self.cybercom.is_primed = 1;
        self playsoundtoplayer( "gdt_securitybreach_target", self );
    }
}

// Namespace cybercom_gadget_security_breach
// Params 1, eflags: 0x4
// Checksum 0x32af010, Offset: 0xfa8
// Size: 0x1d4, Type: bool
function private _lock_requirement( target )
{
    if ( target cybercom::cybercom_aicheckoptout( "cybercom_hijack" ) )
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
    
    if ( isdefined( target.lockon_owner ) && target.lockon_owner != self )
    {
        self cybercom::function_29bf9dee( target, 7 );
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
    
    if ( isdefined( target.var_d3f57f67 ) && target.var_d3f57f67 )
    {
        return false;
    }
    
    if ( !isvehicle( target ) )
    {
        self cybercom::function_29bf9dee( target, 2 );
        return false;
    }
    
    return true;
}

// Namespace cybercom_gadget_security_breach
// Params 1, eflags: 0x4
// Checksum 0x735fcc3, Offset: 0x1188
// Size: 0xa2
function private _get_valid_targets( weapon )
{
    enemy = arraycombine( getaiteamarray( "axis" ), getaiteamarray( "team3" ), 0, 0 );
    ally = getaiteamarray( "allies" );
    return arraycombine( enemy, ally, 0, 0 );
}

// Namespace cybercom_gadget_security_breach
// Params 2, eflags: 0x4
// Checksum 0x2f866c60, Offset: 0x1238
// Size: 0x324
function private _activate_security_breach( slot, weapon )
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
                item.target thread _security_breach( self, weapon );
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
    
    if ( !aborted && fired )
    {
        upgraded = weapon.name == "gadget_remote_hijack_upgraded";
        self playsound( "gdt_cybercore_activate" + ( isdefined( upgraded ) && upgraded ? "_upgraded" : "" ) );
    }
    
    cybercom::function_adc40f11( weapon, fired );
    
    if ( fired && isplayer( self ) )
    {
        itemindex = getitemindexfromref( "cybercom_hijack" );
        
        if ( isdefined( itemindex ) )
        {
            self adddstat( "ItemStats", itemindex, "stats", "kills", "statValue", fired );
            self adddstat( "ItemStats", itemindex, "stats", "used", "statValue", 1 );
        }
    }
}

// Namespace cybercom_gadget_security_breach
// Params 5, eflags: 0x4
// Checksum 0x109f5f2b, Offset: 0x1568
// Size: 0xec
function private _security_breach_ramp_visionset( player, setname, delay, direction, duration )
{
    wait delay;
    
    if ( direction > 0 )
    {
        visionset_mgr::activate( "visionset", setname, player, duration, 0, 0 );
        visionset_mgr::deactivate( "visionset", setname, player );
        return;
    }
    
    visionset_mgr::activate( "visionset", setname, player, 0, 0, duration );
    visionset_mgr::deactivate( "visionset", setname, player );
}

// Namespace cybercom_gadget_security_breach
// Params 2, eflags: 0x4
// Checksum 0x8a9f6750, Offset: 0x1660
// Size: 0x82, Type: bool
function private function_637db461( player, weapon )
{
    if ( isdefined( self.hijacked ) && self.hijacked )
    {
        player cybercom::function_29bf9dee( self, 4 );
        return false;
    }
    
    if ( isdefined( self.is_disabled ) && self.is_disabled )
    {
        player cybercom::function_29bf9dee( self, 6 );
        return false;
    }
    
    return false;
}

// Namespace cybercom_gadget_security_breach
// Params 2, eflags: 0x4
// Checksum 0x47545dc0, Offset: 0x16f0
// Size: 0x61c
function private _security_breach( player, weapon )
{
    wait getdvarfloat( "scr_security_breach_activate_delay", 0.5 );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isvehicle( self ) )
    {
        return;
    }
    
    if ( player laststand::player_is_in_laststand() )
    {
        return;
    }
    
    if ( isdefined( player.cybercom.emergency_reserve ) && player.cybercom.emergency_reserve )
    {
        return;
    }
    
    if ( isdefined( self.playerdrivenversion ) )
    {
        self setvehicletype( self.playerdrivenversion );
    }
    
    vehentnum = self getentitynumber();
    self notify( #"cybercom_action", weapon, player );
    self notify( #"cloneandremoveentity", vehentnum );
    level notify( #"cloneandremoveentity", vehentnum );
    player gadgetpowerset( 0, 0 );
    player gadgetpowerset( 1, 0 );
    player gadgetpowerset( 2, 0 );
    player cybercom::disablecybercom( 1 );
    
    if ( isai( self ) && self.archetype == "quadtank" )
    {
        player notify( #"give_achievement", "CP_CONTROL_QUAD" );
    }
    
    player notify( #"security_breach", self );
    waittillframeend();
    self notsolid();
    var_66ff806d = self.var_66ff806d;
    clone = cloneandremoveentity( self );
    
    if ( !isdefined( clone ) )
    {
        return;
    }
    
    clone solid();
    level notify( #"clonedentity", clone, vehentnum );
    player notify( #"clonedentity", clone, vehentnum );
    clone.takedamage = 0;
    clone.hijacked = 1;
    clone.var_a076880e = undefined;
    clone.is_disabled = 1;
    clone.owner = player;
    clone.var_66ff806d = var_66ff806d;
    clone setteam( player.team );
    clone.health = clone.healthdefault;
    clone.var_fb7ce72a = &function_637db461;
    
    if ( isdefined( self.var_72f54197 ) )
    {
        clone.var_72f54197 = self.var_72f54197;
    }
    
    if ( isdefined( self.var_b0ac175a ) )
    {
        clone.var_b0ac175a = self.var_b0ac175a;
    }
    
    playerstate = spawnstruct();
    player function_dc86efaa( playerstate, "begin" );
    
    if ( !isdefined( clone ) )
    {
        player disableinvulnerability();
        player cybercom::enablecybercom();
        return;
    }
    
    player.hijacked_vehicle_entity = clone;
    player function_dc86efaa( playerstate, "cloak" );
    clone thread _invulnerableforatime( getdvarint( "scr_security_breach_no_damage_time", 8 ), player );
    
    if ( isdefined( clone.vehicletype ) && clone.vehicletype != "turret_sentry" )
    {
        clone thread _anchor_to_location( player, player.origin );
    }
    
    clone.blocktween = 1;
    clone makevehicleusable();
    clone usevehicle( player, 0 );
    clone makevehicleunusable();
    player function_dc86efaa( playerstate, "cloak_wait" );
    clone clientfield::set( "vehicle_hijacked", 1 );
    clone.blocktween = undefined;
    clone makevehicleusable();
    clone thread _wait_for_return( player );
    player function_dc86efaa( playerstate, "return_wait" );
    visionset_mgr::deactivate( "visionset", "hijack_vehicle_blur", player );
    player function_dc86efaa( playerstate, "finish" );
}

// Namespace cybercom_gadget_security_breach
// Params 2
// Checksum 0x7101dc1, Offset: 0x1d18
// Size: 0x524
function function_dc86efaa( var_b6c35df6, str_state )
{
    assert( isplayer( self ) );
    player = self;
    
    switch ( str_state )
    {
        case "begin":
            player setcontrolleruimodelvalue( "vehicle.outOfRange", 0 );
            player enableinvulnerability();
            player cybercom::disablecybercom( 1 );
            wait 0.1;
            return;
        case "cloak":
            var_b6c35df6.oldstance = player getstance();
            var_b6c35df6.oldignoreme = player.ignoreme;
            var_b6c35df6.var_d40d5a7d = player.b_tactical_mode_enabled;
            player.b_tactical_mode_enabled = 0;
            player.ignoreme = 1;
            player setclientuivisibilityflag( "weapon_hud_visible", 0 );
            player setstance( "crouch" );
            player clientfield::set( "camo_shader", 2 );
            player thread _start_transition( 2 );
            player thread _security_breach_ramp_visionset( player, "hijack_vehicle", 0.1, 1, 0.1 );
            player waittill( #"transition_in_do_switch" );
            player setlowready( 1 );
            visionset_mgr::activate( "visionset", "hijack_vehicle_blur", player );
            player hide();
            player notsolid();
            player setplayercollision( 0 );
            player clientfield::set( "camo_shader", 1 );
            player clientfield::set_to_player( "sndInDrivableVehicle", 1 );
            player player::take_weapons();
            return;
        case "cloak_wait":
            player waittill( #"transition_done" );
            player clientfield::set_to_player( "vehicle_hijacked", 1 );
            return "return_wait";
        default:
            player waittill( #"return_to_body" );
            player player::give_back_weapons( 1 );
            player seteverhadweaponall( 1 );
            player thread _security_breach_ramp_visionset( player, "hijack_vehicle", 0, -1, 0.1 );
            return;
        case "finish":
            player show();
            player solid();
            player setplayercollision( 1 );
            player setstance( var_b6c35df6.oldstance );
            player setlowready( 0 );
            player.b_tactical_mode_enabled = var_b6c35df6.var_d40d5a7d;
            player waittill( #"transition_done" );
            player seteverhadweaponall( 0 );
            player clientfield::set_to_player( "vehicle_hijacked", 0 );
            player clientfield::set_to_player( "sndInDrivableVehicle", 0 );
            player.hijacked_vehicle_entity = undefined;
            player disableinvulnerability();
            player.ignoreme = 0;
            player setclientuivisibilityflag( "weapon_hud_visible", 1 );
            player cybercom::enablecybercom();
            wait 1;
            player clientfield::set( "camo_shader", 0 );
            player notify( #"stop_camo_sound" );
    }
}

// Namespace cybercom_gadget_security_breach
// Params 1
// Checksum 0x117cde52, Offset: 0x2278
// Size: 0xac
function _start_transition( direction )
{
    self endon( #"death" );
    self notify( #"_start_transition" );
    self endon( #"_start_transition" );
    self clientfield::set_to_player( "hijack_vehicle_transition", direction );
    util::wait_network_frame();
    self notify( #"transition_in_do_switch" );
    wait 0.2;
    wait 0.2;
    self notify( #"transition_done" );
    self clientfield::set_to_player( "hijack_vehicle_transition", 1 );
}

// Namespace cybercom_gadget_security_breach
// Params 1
// Checksum 0xbc21c0c5, Offset: 0x2330
// Size: 0x144
function setanchorvolume( ent )
{
    clearanchorvolume();
    
    if ( isdefined( ent ) && isplayer( self ) )
    {
        self.cybercom.secbreachanchorent = ent;
        
        if ( isdefined( ent.script_parameters ) )
        {
            data = strtok( ent.script_parameters, " " );
            assert( data.size == 2 );
            self.cybercom.secbreachanchorminsq = int( data[ 0 ] ) * int( data[ 0 ] );
            self.cybercom.secbreachanchormaxsq = int( data[ 1 ] ) * int( data[ 1 ] );
        }
    }
}

// Namespace cybercom_gadget_security_breach
// Params 0
// Checksum 0x7b230c7b, Offset: 0x2480
// Size: 0x32
function clearanchorvolume()
{
    self.cybercom.secbreachanchorent = undefined;
    self.cybercom.secbreachanchorminsq = undefined;
    self.cybercom.secbreachanchormaxsq = undefined;
}

// Namespace cybercom_gadget_security_breach
// Params 2, eflags: 0x4
// Checksum 0xf0189ef0, Offset: 0x24c0
// Size: 0x410
function private _anchor_to_location( player, anchor )
{
    self endon( #"death" );
    player endon( #"return_to_body" );
    player endon( #"kill_static_achor" );
    player endon( #"disconnect" );
    player waittill( #"transition_done" );
    wait 0.1;
    maxstatic = 0.95;
    lastoutofrangewarningvalue = undefined;
    
    while ( true )
    {
        distcheck = 1;
        losecontactdistsq = getdvarint( "scr_security_breach_lose_contact_distanceSQ", getdvarint( "scr_security_breach_lose_contact_distance", 1200 ) * getdvarint( "scr_security_breach_lose_contact_distance", 1200 ) );
        lostcontactdistsq = getdvarint( "scr_security_breach_lost_contact_distanceSQ", getdvarint( "scr_security_breach_lost_contact_distance", 2400 ) * getdvarint( "scr_security_breach_lost_contact_distance", 2400 ) );
        
        if ( isdefined( player.cybercom.secbreachanchorent ) )
        {
            if ( isdefined( player.cybercom.secbreachanchorminsq ) )
            {
                losecontactdistsq = player.cybercom.secbreachanchorminsq;
                lostcontactdistsq = player.cybercom.secbreachanchormaxsq;
            }
            
            if ( self istouching( player.cybercom.secbreachanchorent ) )
            {
                val = 0;
                distancesq = 0;
                distcheck = 0;
            }
        }
        
        if ( self.archetype === "turret" )
        {
            val = 0;
            distancesq = 0;
            distcheck = 0;
        }
        
        if ( distcheck )
        {
            distancesq = distancesquared( self.origin, anchor );
            
            if ( distancesq < losecontactdistsq )
            {
                val = 0;
            }
            else if ( distancesq >= lostcontactdistsq )
            {
                val = maxstatic;
            }
            else
            {
                range = lostcontactdistsq - losecontactdistsq;
                val = math::clamp( ( distancesq - losecontactdistsq ) / range, 0, maxstatic );
            }
            
            outofrangewarningvalue = distancesq >= getdvarfloat( "scr_security_breach_lost_contact_warning_distance_percent", 0.6 ) * lostcontactdistsq;
            
            if ( outofrangewarningvalue !== lastoutofrangewarningvalue )
            {
                player setcontrolleruimodelvalue( "vehicle.outOfRange", outofrangewarningvalue );
                lastoutofrangewarningvalue = outofrangewarningvalue;
            }
        }
        
        player clientfield::set_to_player( "hijack_static_effect", val );
        
        if ( distancesq > lostcontactdistsq )
        {
            self setteam( "axis" );
            self.takedamage = 1;
            self.owner = undefined;
            self.skipfriendlyfirecheck = 1;
            
            if ( isdefined( player ) )
            {
                self kill( self.origin, player );
            }
            else
            {
                self kill();
            }
        }
        
        wait 0.05;
    }
}

// Namespace cybercom_gadget_security_breach
// Params 2, eflags: 0x4
// Checksum 0xc1ee1fe1, Offset: 0x28d8
// Size: 0x6c
function private _invulnerableforatime( time, player )
{
    self endon( #"death" );
    self.takedamage = 0;
    player util::waittill_any_timeout( time, "return_to_body" );
    self.takedamage = !isgodmode( player );
}

// Namespace cybercom_gadget_security_breach
// Params 1, eflags: 0x4
// Checksum 0x115576b7, Offset: 0x2950
// Size: 0x194
function private _playerspectate( vehicle )
{
    self endon( #"spawned" );
    self util::freeze_player_controls( 1 );
    self clientfield::set_to_player( "hijack_static_ramp_up", 1 );
    
    if ( isdefined( vehicle.archetype ) && vehicle.archetype == "wasp" && !( isdefined( vehicle.var_66ff806d ) && vehicle.var_66ff806d ) )
    {
        self thread _playerspectatechase( vehicle );
    }
    else
    {
        self clientfield::set_to_player( "hijack_spectate", 1 );
    }
    
    self cameraactivate( 1 );
    self waittill( #"transition_in_do_switch" );
    self clientfield::set_to_player( "hijack_static_ramp_up", 0 );
    self cameraactivate( 0 );
    self clientfield::set_to_player( "hijack_spectate", 0 );
    self clientfield::set_to_player( "hijack_static_effect", 0 );
    self util::freeze_player_controls( 0 );
}

// Namespace cybercom_gadget_security_breach
// Params 1, eflags: 0x4
// Checksum 0x884dac14, Offset: 0x2af0
// Size: 0x21c
function private _playerspectatechase( vehicle )
{
    forward = anglestoforward( vehicle.angles );
    moveamount = vectorscale( forward, -200 );
    moveamount = ( moveamount[ 0 ], moveamount[ 1 ], vehicle.origin[ 2 ] + 72 );
    cam = spawn( "script_model", vehicle.origin + moveamount );
    cam setmodel( "tag_origin" );
    
    if ( !( isdefined( vehicle.crash_style ) && vehicle.crash_style ) )
    {
        cam linkto( vehicle, "tag_origin" );
    }
    
    self startcameratween( 1 );
    origin = vehicle.origin;
    wait 0.05;
    self camerasetposition( cam );
    
    if ( isdefined( vehicle ) )
    {
        self camerasetlookat( vehicle );
    }
    else
    {
        self camerasetlookat( origin + ( 0, 0, 50 ) );
    }
    
    self util::waittill_any( "transition_in_do_switch", "spawned", "disconnect", "death", "return_to_body" );
    cam delete();
}

// Namespace cybercom_gadget_security_breach
// Params 1, eflags: 0x4
// Checksum 0x6d9b32e1, Offset: 0x2d18
// Size: 0xa8
function private _wait_for_death( player )
{
    player endon( #"return_to_body" );
    self waittill( #"death" );
    player thread _playerspectate( self );
    wait 3;
    player notify( #"kill_static_achor" );
    player thread _start_transition( 3 );
    player waittill( #"transition_in_do_switch" );
    waittillframeend();
    player unlink();
    player notify( #"return_to_body", 1 );
}

// Namespace cybercom_gadget_security_breach
// Params 1, eflags: 0x4
// Checksum 0xdcc93333, Offset: 0x2dc8
// Size: 0x10c
function private _wait_for_player_exit( player )
{
    self endon( #"death" );
    player endon( #"return_to_body" );
    self util::waittill_any( "unlink", "exit_vehicle" );
    
    if ( isdefined( level.gameended ) && ( game[ "state" ] == "postgame" || level.gameended ) )
    {
        return;
    }
    
    self setteam( "axis" );
    self.takedamage = 1;
    self.owner = undefined;
    
    if ( isdefined( player ) )
    {
        self kill( self.origin, player, player, getweapon( "gadget_remote_hijack" ) );
        return;
    }
    
    self kill();
}

// Namespace cybercom_gadget_security_breach
// Params 1, eflags: 0x4
// Checksum 0x99f3e9a8, Offset: 0x2ee0
// Size: 0x192
function private _wait_for_return( player )
{
    self thread _wait_for_death( player );
    self thread _wait_for_player_exit( player );
    original_location = player.origin;
    original_angles = player.angles;
    player.cybercom.tacrigs_disabled = 1;
    self.vehdontejectoccupantsondeath = 1;
    player waittill( #"return_to_body", reason );
    wait 0.05;
    player setorigin( original_location );
    player setplayerangles( original_angles );
    wait 0.05;
    
    if ( isdefined( self ) )
    {
        self setteam( "axis" );
        self.takedamage = 1;
        self.owner = undefined;
        
        if ( isdefined( player ) )
        {
            self kill( self.origin, player );
        }
        else
        {
            self kill();
        }
    }
    
    player.cybercom.tacrigs_disabled = undefined;
}

// Namespace cybercom_gadget_security_breach
// Params 0
// Checksum 0x57d06f1d, Offset: 0x3080
// Size: 0x64
function clearusingremote()
{
    self enableoffhandweapons();
    
    if ( isdefined( self.lastweapon ) )
    {
        self switchtoweapon( self.lastweapon );
        wait 1;
    }
    
    self takeweapon( self.remoteweapon );
}

// Namespace cybercom_gadget_security_breach
// Params 1
// Checksum 0xb9e63f93, Offset: 0x30f0
// Size: 0xa4
function setusingremote( remotename )
{
    self.lastweapon = self getcurrentweapon();
    self.remoteweapon = getweapon( remotename );
    self giveweapon( self.remoteweapon );
    self switchtoweapon( self.remoteweapon );
    self disableoffhandweapons();
}

// Namespace cybercom_gadget_security_breach
// Params 2
// Checksum 0x82c09a7b, Offset: 0x31a0
// Size: 0x66
function function_43b801ea( onoff, entnum )
{
    while ( true )
    {
        level waittill( #"clonedentity", clone, vehentnum );
        
        if ( vehentnum == entnum )
        {
            clone.var_66ff806d = onoff;
            return;
        }
    }
}

// Namespace cybercom_gadget_security_breach
// Params 0
// Checksum 0xc8d290a7, Offset: 0x3210
// Size: 0x44
function function_f002d0f9()
{
    self endon( #"death" );
    self waittill( #"cloneandremoveentity", myentnum );
    level thread function_43b801ea( 0, myentnum );
}

// Namespace cybercom_gadget_security_breach
// Params 0
// Checksum 0x635d22c4, Offset: 0x3260
// Size: 0x5c
function function_664c9cd6()
{
    self setteam( "axis" );
    self.takedamage = 1;
    self.owner = undefined;
    self dodamage( self.health, self.origin );
}

