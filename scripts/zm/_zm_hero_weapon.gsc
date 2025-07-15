#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace zm_hero_weapon;

// Namespace zm_hero_weapon
// Params 0, eflags: 0x2
// Checksum 0xddcbcacf, Offset: 0x330
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_hero_weapons", &__init__, undefined, undefined );
}

// Namespace zm_hero_weapon
// Params 0
// Checksum 0x3a0a2a5c, Offset: 0x370
// Size: 0x84
function __init__()
{
    if ( !isdefined( level._hero_weapons ) )
    {
        level._hero_weapons = [];
    }
    
    callback::on_spawned( &on_player_spawned );
    level.hero_power_update = &hero_power_event_callback;
    ability_player::register_gadget_activation_callbacks( 14, &gadget_hero_weapon_on_activate, &gadget_hero_weapon_on_off );
}

// Namespace zm_hero_weapon
// Params 2
// Checksum 0xca33803a, Offset: 0x400
// Size: 0x14
function gadget_hero_weapon_on_activate( slot, weapon )
{
    
}

// Namespace zm_hero_weapon
// Params 2
// Checksum 0x9a3b144e, Offset: 0x420
// Size: 0x34
function gadget_hero_weapon_on_off( slot, weapon )
{
    self thread watch_for_glitches( slot, weapon );
}

// Namespace zm_hero_weapon
// Params 2
// Checksum 0x91877935, Offset: 0x460
// Size: 0xb8
function watch_for_glitches( slot, weapon )
{
    wait 1;
    
    if ( isdefined( self ) )
    {
        w_current = self getcurrentweapon();
        
        if ( isdefined( w_current ) && zm_utility::is_hero_weapon( w_current ) )
        {
            self.hero_power = self gadgetpowerget( 0 );
            
            if ( self.hero_power <= 0 )
            {
                zm_weapons::switch_back_primary_weapon( undefined, 1 );
                self.i_tried_to_glitch_the_hero_weapon = 1;
            }
        }
    }
}

// Namespace zm_hero_weapon
// Params 1
// Checksum 0x91d0c352, Offset: 0x520
// Size: 0x16c
function register_hero_weapon( weapon_name )
{
    weaponnone = getweapon( "none" );
    weapon = getweapon( weapon_name );
    
    if ( weapon != weaponnone )
    {
        hero_weapon = spawnstruct();
        hero_weapon.weapon = weapon;
        hero_weapon.give_fn = &default_give;
        hero_weapon.take_fn = &default_take;
        hero_weapon.wield_fn = &default_wield;
        hero_weapon.unwield_fn = &default_unwield;
        hero_weapon.power_full_fn = &default_power_full;
        hero_weapon.power_empty_fn = &default_power_empty;
        
        if ( !isdefined( level._hero_weapons ) )
        {
            level._hero_weapons = [];
        }
        
        level._hero_weapons[ weapon ] = hero_weapon;
        zm_utility::register_hero_weapon_for_level( weapon_name );
    }
}

// Namespace zm_hero_weapon
// Params 3
// Checksum 0xd1d7326f, Offset: 0x698
// Size: 0xfc
function register_hero_weapon_give_take_callbacks( weapon_name, give_fn, take_fn )
{
    if ( !isdefined( give_fn ) )
    {
        give_fn = &default_give;
    }
    
    if ( !isdefined( take_fn ) )
    {
        take_fn = &default_take;
    }
    
    weaponnone = getweapon( "none" );
    weapon = getweapon( weapon_name );
    
    if ( weapon != weaponnone && isdefined( level._hero_weapons[ weapon ] ) )
    {
        level._hero_weapons[ weapon ].give_fn = give_fn;
        level._hero_weapons[ weapon ].take_fn = take_fn;
    }
}

// Namespace zm_hero_weapon
// Params 1
// Checksum 0x5949750, Offset: 0x7a0
// Size: 0x7c
function default_give( weapon )
{
    power = self gadgetpowerget( 0 );
    
    if ( power < 100 )
    {
        self set_hero_weapon_state( weapon, 1 );
        return;
    }
    
    self set_hero_weapon_state( weapon, 2 );
}

// Namespace zm_hero_weapon
// Params 1
// Checksum 0xed663b25, Offset: 0x828
// Size: 0x24
function default_take( weapon )
{
    self set_hero_weapon_state( weapon, 0 );
}

// Namespace zm_hero_weapon
// Params 3
// Checksum 0x44e3b313, Offset: 0x858
// Size: 0xfc
function register_hero_weapon_wield_unwield_callbacks( weapon_name, wield_fn, unwield_fn )
{
    if ( !isdefined( wield_fn ) )
    {
        wield_fn = &default_wield;
    }
    
    if ( !isdefined( unwield_fn ) )
    {
        unwield_fn = &default_unwield;
    }
    
    weaponnone = getweapon( "none" );
    weapon = getweapon( weapon_name );
    
    if ( weapon != weaponnone && isdefined( level._hero_weapons[ weapon ] ) )
    {
        level._hero_weapons[ weapon ].wield_fn = wield_fn;
        level._hero_weapons[ weapon ].unwield_fn = unwield_fn;
    }
}

// Namespace zm_hero_weapon
// Params 1
// Checksum 0xc2f21230, Offset: 0x960
// Size: 0x2c
function default_wield( weapon )
{
    self set_hero_weapon_state( weapon, 3 );
}

// Namespace zm_hero_weapon
// Params 1
// Checksum 0xa0d76c05, Offset: 0x998
// Size: 0x2c
function default_unwield( weapon )
{
    self set_hero_weapon_state( weapon, 1 );
}

// Namespace zm_hero_weapon
// Params 3
// Checksum 0xe74252b4, Offset: 0x9d0
// Size: 0xfc
function register_hero_weapon_power_callbacks( weapon_name, power_full_fn, power_empty_fn )
{
    if ( !isdefined( power_full_fn ) )
    {
        power_full_fn = &default_power_full;
    }
    
    if ( !isdefined( power_empty_fn ) )
    {
        power_empty_fn = &default_power_empty;
    }
    
    weaponnone = getweapon( "none" );
    weapon = getweapon( weapon_name );
    
    if ( weapon != weaponnone && isdefined( level._hero_weapons[ weapon ] ) )
    {
        level._hero_weapons[ weapon ].power_full_fn = power_full_fn;
        level._hero_weapons[ weapon ].power_empty_fn = power_empty_fn;
    }
}

// Namespace zm_hero_weapon
// Params 1
// Checksum 0x8a58efd8, Offset: 0xad8
// Size: 0x4c
function default_power_full( weapon )
{
    self set_hero_weapon_state( weapon, 2 );
    self thread zm_equipment::show_hint_text( &"ZOMBIE_HERO_WEAPON_HINT", 2 );
}

// Namespace zm_hero_weapon
// Params 1
// Checksum 0xc834301c, Offset: 0xb30
// Size: 0x2c
function default_power_empty( weapon )
{
    self set_hero_weapon_state( weapon, 1 );
}

// Namespace zm_hero_weapon
// Params 2
// Checksum 0xfc9d75c2, Offset: 0xb68
// Size: 0x44
function set_hero_weapon_state( w_weapon, state )
{
    self.hero_weapon_state = state;
    self clientfield::set_player_uimodel( "zmhud.swordState", state );
}

// Namespace zm_hero_weapon
// Params 0
// Checksum 0x8674e9de, Offset: 0xbb8
// Size: 0x64
function on_player_spawned()
{
    self set_hero_weapon_state( undefined, 0 );
    self thread watch_hero_weapon_give();
    self thread watch_hero_weapon_take();
    self thread watch_hero_weapon_change();
}

// Namespace zm_hero_weapon
// Params 0
// Checksum 0xacab0702, Offset: 0xc28
// Size: 0xac
function watch_hero_weapon_give()
{
    self notify( #"watch_hero_weapon_give" );
    self endon( #"watch_hero_weapon_give" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"weapon_give", w_weapon );
        
        if ( isdefined( w_weapon ) && zm_utility::is_hero_weapon( w_weapon ) )
        {
            self thread watch_hero_power( w_weapon );
            self [[ level._hero_weapons[ w_weapon ].give_fn ]]( w_weapon );
        }
    }
}

// Namespace zm_hero_weapon
// Params 0
// Checksum 0x9404639b, Offset: 0xce0
// Size: 0xa6
function watch_hero_weapon_take()
{
    self notify( #"watch_hero_weapon_take" );
    self endon( #"watch_hero_weapon_take" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"weapon_take", w_weapon );
        
        if ( isdefined( w_weapon ) && zm_utility::is_hero_weapon( w_weapon ) )
        {
            self [[ level._hero_weapons[ w_weapon ].take_fn ]]( w_weapon );
            self notify( #"stop_watch_hero_power" );
        }
    }
}

// Namespace zm_hero_weapon
// Params 0
// Checksum 0x82066688, Offset: 0xd90
// Size: 0x188
function watch_hero_weapon_change()
{
    self notify( #"watch_hero_weapon_change" );
    self endon( #"watch_hero_weapon_change" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"weapon_change", w_current, w_previous );
        
        if ( self.sessionstate != "spectator" )
        {
            if ( isdefined( w_previous ) && zm_utility::is_hero_weapon( w_previous ) )
            {
                self [[ level._hero_weapons[ w_previous ].unwield_fn ]]( w_previous );
                
                if ( self gadgetpowerget( 0 ) == 100 )
                {
                    if ( self hasweapon( w_previous ) )
                    {
                        self setweaponammoclip( w_previous, w_previous.clipsize );
                        self [[ level._hero_weapons[ w_previous ].power_full_fn ]]( w_previous );
                    }
                }
            }
            
            if ( isdefined( w_current ) && zm_utility::is_hero_weapon( w_current ) )
            {
                self [[ level._hero_weapons[ w_current ].wield_fn ]]( w_current );
            }
        }
    }
}

// Namespace zm_hero_weapon
// Params 1
// Checksum 0x988a8497, Offset: 0xf20
// Size: 0x140
function watch_hero_power( w_weapon )
{
    self notify( #"watch_hero_power" );
    self endon( #"watch_hero_power" );
    self endon( #"stop_watch_hero_power" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self.hero_power_prev ) )
    {
        self.hero_power_prev = -1;
    }
    
    while ( true )
    {
        self.hero_power = self gadgetpowerget( 0 );
        self clientfield::set_player_uimodel( "zmhud.swordEnergy", self.hero_power / 100 );
        
        if ( self.hero_power != self.hero_power_prev )
        {
            self.hero_power_prev = self.hero_power;
            
            if ( self.hero_power >= 100 )
            {
                self [[ level._hero_weapons[ w_weapon ].power_full_fn ]]( w_weapon );
            }
            else if ( self.hero_power <= 0 )
            {
                self [[ level._hero_weapons[ w_weapon ].power_empty_fn ]]( w_weapon );
            }
        }
        
        wait 0.05;
    }
}

// Namespace zm_hero_weapon
// Params 1
// Checksum 0xdb2ee190, Offset: 0x1068
// Size: 0xf8
function continue_draining_hero_weapon( w_weapon )
{
    self endon( #"stop_draining_hero_weapon" );
    self set_hero_weapon_state( w_weapon, 3 );
    
    while ( isdefined( self ) )
    {
        n_rate = 1;
        
        if ( isdefined( w_weapon.gadget_power_usage_rate ) )
        {
            n_rate = w_weapon.gadget_power_usage_rate;
        }
        
        self.hero_power -= 0.05 * n_rate;
        self.hero_power = math::clamp( self.hero_power, 0, 100 );
        
        if ( self.hero_power != self.hero_power_prev )
        {
            self gadgetpowerset( 0, self.hero_power );
        }
        
        wait 0.05;
    }
}

// Namespace zm_hero_weapon
// Params 2
// Checksum 0x66e2d91e, Offset: 0x1168
// Size: 0x52
function register_hero_recharge_event( w_hero, func )
{
    if ( !isdefined( level.a_func_hero_power_update ) )
    {
        level.a_func_hero_power_update = [];
    }
    
    if ( !isdefined( level.a_func_hero_power_update[ w_hero ] ) )
    {
        level.a_func_hero_power_update[ w_hero ] = func;
    }
}

// Namespace zm_hero_weapon
// Params 2
// Checksum 0x5b761bd, Offset: 0x11c8
// Size: 0x8c
function hero_power_event_callback( e_player, ai_enemy )
{
    w_hero = e_player.current_hero_weapon;
    
    if ( isdefined( level.a_func_hero_power_update ) && isdefined( level.a_func_hero_power_update[ w_hero ] ) )
    {
        level [[ level.a_func_hero_power_update[ w_hero ] ]]( e_player, ai_enemy );
        return;
    }
    
    level hero_power_event( e_player, ai_enemy );
}

// Namespace zm_hero_weapon
// Params 2
// Checksum 0xf9b2ff3f, Offset: 0x1260
// Size: 0x8c
function hero_power_event( player, ai_enemy )
{
    if ( isdefined( player ) && player zm_utility::has_player_hero_weapon() && !( player.hero_weapon_state === 3 ) && !( isdefined( player.disable_hero_power_charging ) && player.disable_hero_power_charging ) )
    {
        player player_hero_power_event( ai_enemy );
    }
}

// Namespace zm_hero_weapon
// Params 1
// Checksum 0x103188ec, Offset: 0x12f8
// Size: 0x174
function player_hero_power_event( ai_enemy )
{
    if ( isdefined( self ) )
    {
        w_current = self zm_utility::get_player_hero_weapon();
        
        if ( isdefined( ai_enemy.heroweapon_kill_power ) )
        {
            perkfactor = 1;
            
            if ( self hasperk( "specialty_overcharge" ) )
            {
                perkfactor = getdvarfloat( "gadgetPowerOverchargePerkScoreFactor" );
            }
            
            if ( isdefined( self.i_tried_to_glitch_the_hero_weapon ) && self.i_tried_to_glitch_the_hero_weapon )
            {
            }
            
            self.hero_power += perkfactor * ai_enemy.heroweapon_kill_power;
            self.hero_power = math::clamp( self.hero_power, 0, 100 );
            
            if ( self.hero_power != self.hero_power_prev )
            {
                self gadgetpowerset( 0, self.hero_power );
                self clientfield::set_player_uimodel( "zmhud.swordEnergy", self.hero_power / 100 );
                self clientfield::increment_uimodel( "zmhud.swordChargeUpdate" );
            }
        }
    }
}

// Namespace zm_hero_weapon
// Params 0
// Checksum 0xfff9669b, Offset: 0x1478
// Size: 0x3c
function take_hero_weapon()
{
    if ( isdefined( self.current_hero_weapon ) )
    {
        self notify( #"weapon_take", self.current_hero_weapon );
        self gadgetpowerset( 0, 0 );
    }
}

// Namespace zm_hero_weapon
// Params 0
// Checksum 0x1fe81f5, Offset: 0x14c0
// Size: 0x10, Type: bool
function is_hero_weapon_in_use()
{
    return self.hero_weapon_state === 3;
}

