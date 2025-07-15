#using scripts/codescripts/struct;
#using scripts/shared/_burnplayer;
#using scripts/shared/abilities/_ability_gadgets;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/weapons/_weaponobjects;

#namespace roulette;

// Namespace roulette
// Params 0, eflags: 0x2
// Checksum 0x5e5edd60, Offset: 0x3f8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_roulette", &__init__, undefined, undefined );
}

// Namespace roulette
// Params 0
// Checksum 0xbbb057eb, Offset: 0x438
// Size: 0x308
function __init__()
{
    clientfield::register( "toplayer", "roulette_state", 11000, 2, "int" );
    ability_player::register_gadget_activation_callbacks( 43, &gadget_roulette_on_activate, &gadget_roulette_on_deactivate );
    ability_player::register_gadget_possession_callbacks( 43, &gadget_roulette_on_give, &gadget_roulette_on_take );
    ability_player::register_gadget_flicker_callbacks( 43, &gadget_roulette_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 43, &gadget_roulette_is_inuse );
    ability_player::register_gadget_ready_callbacks( 43, &gadget_roulette_is_ready );
    ability_player::register_gadget_is_flickering_callbacks( 43, &gadget_roulette_is_flickering );
    ability_player::register_gadget_should_notify( 43, 0 );
    callback::on_connect( &gadget_roulette_on_connect );
    callback::on_spawned( &gadget_roulette_on_player_spawn );
    
    if ( sessionmodeismultiplayergame() )
    {
        level.gadgetrouletteprobabilities = [];
        level.gadgetrouletteprobabilities[ 0 ] = 0;
        level.gadgetrouletteprobabilities[ 1 ] = 0;
        level.weaponnone = getweapon( "none" );
        level.gadget_roulette = getweapon( "gadget_roulette" );
        registergadgettype( "gadget_flashback", 1, 1 );
        registergadgettype( "gadget_combat_efficiency", 1, 1 );
        registergadgettype( "gadget_heat_wave", 1, 1 );
        registergadgettype( "gadget_vision_pulse", 1, 1 );
        registergadgettype( "gadget_speed_burst", 1, 1 );
        registergadgettype( "gadget_camo", 1, 1 );
        registergadgettype( "gadget_armor", 1, 1 );
        registergadgettype( "gadget_resurrect", 1, 1 );
        registergadgettype( "gadget_clone", 1, 1 );
    }
    
    /#
    #/
}

/#

    // Namespace roulette
    // Params 0
    // Checksum 0xa669fb93, Offset: 0x748
    // Size: 0x1c, Type: dev
    function updatedvars()
    {
        while ( true )
        {
            wait 1;
        }
    }

#/

// Namespace roulette
// Params 1
// Checksum 0xcf390dee, Offset: 0x770
// Size: 0x22
function gadget_roulette_is_inuse( slot )
{
    return self gadgetisactive( slot );
}

// Namespace roulette
// Params 1
// Checksum 0xefc80a36, Offset: 0x7a0
// Size: 0x22
function gadget_roulette_is_flickering( slot )
{
    return self gadgetflickering( slot );
}

// Namespace roulette
// Params 2
// Checksum 0xf7719fe7, Offset: 0x7d0
// Size: 0x34
function gadget_roulette_on_flicker( slot, weapon )
{
    self thread gadget_roulette_flicker( slot, weapon );
}

// Namespace roulette
// Params 2
// Checksum 0x58e8b84d, Offset: 0x810
// Size: 0x54
function gadget_roulette_on_give( slot, weapon )
{
    self clientfield::set_to_player( "roulette_state", 0 );
    
    if ( sessionmodeismultiplayergame() )
    {
        self.isroulette = 1;
    }
}

// Namespace roulette
// Params 2
// Checksum 0x10114e8e, Offset: 0x870
// Size: 0x34
function gadget_roulette_on_take( slot, weapon )
{
    /#
        if ( level.devgui_giving_abilities === 1 )
        {
            self.isroulette = 0;
        }
    #/
}

// Namespace roulette
// Params 0
// Checksum 0x6b12eddb, Offset: 0x8b0
// Size: 0x14
function gadget_roulette_on_connect()
{
    roulette_init_allow_spin();
}

// Namespace roulette
// Params 0
// Checksum 0x2172c970, Offset: 0x8d0
// Size: 0x42
function roulette_init_allow_spin()
{
    if ( self.isroulette === 1 )
    {
        if ( !isdefined( self.pers[ #"hash_9f129a92" ] ) )
        {
            self.pers[ #"hash_9f129a92" ] = 1;
        }
    }
}

// Namespace roulette
// Params 0
// Checksum 0xa0d5fa2f, Offset: 0x920
// Size: 0x14
function gadget_roulette_on_player_spawn()
{
    roulette_init_allow_spin();
}

// Namespace roulette
// Params 0
// Checksum 0x99ec1590, Offset: 0x940
// Size: 0x4
function watch_entity_shutdown()
{
    
}

// Namespace roulette
// Params 2
// Checksum 0xef5ffb71, Offset: 0x950
// Size: 0x2c
function gadget_roulette_on_activate( slot, weapon )
{
    gadget_roulette_give_earned_specialist( weapon, 1 );
}

// Namespace roulette
// Params 2
// Checksum 0x1974859b, Offset: 0x988
// Size: 0x4c
function gadget_roulette_is_ready( slot, weapon )
{
    if ( self gadgetisactive( slot ) )
    {
        return;
    }
    
    gadget_roulette_give_earned_specialist( weapon, 0 );
}

// Namespace roulette
// Params 2
// Checksum 0x7fa172b2, Offset: 0x9e0
// Size: 0x8c
function gadget_roulette_give_earned_specialist( weapon, playsound )
{
    self giverandomweapon( weapon, 1 );
    
    if ( playsound )
    {
        self playsoundtoplayer( "mpl_bm_specialist_roulette", self );
    }
    
    self thread watchgadgetactivated( weapon );
    self thread watchrespin( weapon );
}

// Namespace roulette
// Params 1
// Checksum 0xcda3e507, Offset: 0xa78
// Size: 0x5c
function disable_hero_gadget_activation( duration )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"roulette_respin_activate" );
    self disableoffhandspecial();
    wait duration;
    self enableoffhandspecial();
}

// Namespace roulette
// Params 0
// Checksum 0x881435a2, Offset: 0xae0
// Size: 0x54
function watchrespingadgetactivated()
{
    self endon( #"watchrespingadgetactivated" );
    self endon( #"death" );
    self endon( #"disconnect" );
    self waittill( #"hero_gadget_activated" );
    self clientfield::set_to_player( "roulette_state", 0 );
}

// Namespace roulette
// Params 1
// Checksum 0xbed0d6be, Offset: 0xb40
// Size: 0x1ba
function watchrespin( weapon )
{
    self endon( #"hero_gadget_activated" );
    self notify( #"watchrespin" );
    self endon( #"watchrespin" );
    
    if ( !isdefined( self.pers[ #"hash_9f129a92" ] ) || self.pers[ #"hash_9f129a92" ] == 0 )
    {
        return;
    }
    
    self thread watchrespingadgetactivated();
    self clientfield::set_to_player( "roulette_state", 1 );
    wait getdvarfloat( "scr_roulette_pre_respin_wait_time", 1.3 );
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            break;
        }
        
        if ( self dpad_left_pressed() )
        {
            self.pers[ #"hash_65987563" ] = undefined;
            self giverandomweapon( weapon, 0 );
            self.pers[ #"hash_9f129a92" ] = 0;
            self notify( #"watchrespingadgetactivated" );
            self notify( #"roulette_respin_activate" );
            self clientfield::set_to_player( "roulette_state", 2 );
            self playsoundtoplayer( "mpl_bm_specialist_roulette", self );
            self thread reset_roulette_state_to_default();
            break;
        }
        
        wait 0.05;
    }
    
    if ( isdefined( self ) )
    {
        self notify( #"watchrespingadgetactivated" );
    }
}

// Namespace roulette
// Params 0
// Checksum 0x204f4d19, Offset: 0xd08
// Size: 0x34
function failsafe_reenable_offhand_special()
{
    self endon( #"end_failsafe_reenable_offhand_special" );
    wait 3;
    
    if ( isdefined( self ) )
    {
        self enableoffhandspecial();
    }
}

// Namespace roulette
// Params 0
// Checksum 0x548918d1, Offset: 0xd48
// Size: 0x44
function reset_roulette_state_to_default()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    wait 0.5;
    self clientfield::set_to_player( "roulette_state", 0 );
}

// Namespace roulette
// Params 1
// Checksum 0x79bbb368, Offset: 0xd98
// Size: 0x94
function watchgadgetactivated( weapon )
{
    self endon( #"death" );
    self notify( #"watchgadgetactivated" );
    self endon( #"watchgadgetactivated" );
    self waittill( #"hero_gadget_activated" );
    self.pers[ #"hash_9f129a92" ] = 1;
    
    if ( isdefined( weapon ) || weapon.name != "gadget_roulette" )
    {
        self clientfield::set_to_player( "roulette_state", 0 );
    }
}

// Namespace roulette
// Params 2
// Checksum 0xf0c00b47, Offset: 0xe38
// Size: 0x23e
function giverandomweapon( weapon, isprimaryroll )
{
    for ( i = 0; i < 3 ; i++ )
    {
        if ( isdefined( self._gadgets_player[ i ] ) )
        {
            self takeweapon( self._gadgets_player[ i ] );
        }
    }
    
    randomweapon = weapon;
    
    if ( isdefined( self.pers[ #"hash_65987563" ] ) )
    {
        randomweapon = self.pers[ #"hash_65987563" ];
    }
    else if ( isdefined( self.pers[ #"hash_cbcfa831" ] ) || isdefined( self.pers[ #"hash_cbcfa832" ] ) )
    {
        for ( randomweapon = getrandomgadget( isprimaryroll ); isdefined( self.pers[ #"hash_cbcfa832" ] ) && ( randomweapon == self.pers[ #"hash_cbcfa831" ] || randomweapon == self.pers[ #"hash_cbcfa832" ] ) ; randomweapon = getrandomgadget( isprimaryroll ) )
        {
        }
    }
    else
    {
        randomweapon = getrandomgadget( isprimaryroll );
    }
    
    if ( isdefined( level.playgadgetready ) && !isprimaryroll )
    {
        self thread [[ level.playgadgetready ]]( randomweapon, !isprimaryroll );
    }
    
    self thread gadget_roulette_on_deactivate_helper( weapon );
    self giveweapon( randomweapon );
    self.pers[ #"hash_65987563" ] = randomweapon;
    self.pers[ #"hash_cbcfa832" ] = self.pers[ #"hash_cbcfa831" ];
    self.pers[ #"hash_cbcfa831" ] = randomweapon;
}

// Namespace roulette
// Params 2
// Checksum 0x6b212acd, Offset: 0x1080
// Size: 0x2c
function gadget_roulette_on_deactivate( slot, weapon )
{
    thread gadget_roulette_on_deactivate_helper( weapon );
}

// Namespace roulette
// Params 1
// Checksum 0x123a51e0, Offset: 0x10b8
// Size: 0x10c
function gadget_roulette_on_deactivate_helper( weapon )
{
    self notify( #"gadget_roulette_on_deactivate_helper" );
    self endon( #"gadget_roulette_on_deactivate_helper" );
    self waittill( #"heroability_off", weapon_off );
    
    if ( isdefined( weapon_off ) && weapon_off.name == "gadget_speed_burst" )
    {
        self waittill( #"heroability_off", weapon_off );
    }
    
    for ( i = 0; i < 3 ; i++ )
    {
        if ( isdefined( self ) && isdefined( self._gadgets_player[ i ] ) )
        {
            self takeweapon( self._gadgets_player[ i ] );
        }
    }
    
    if ( isdefined( self ) )
    {
        self giveweapon( level.gadget_roulette );
        self.pers[ #"hash_65987563" ] = undefined;
    }
}

// Namespace roulette
// Params 2
// Checksum 0xe7ac1e92, Offset: 0x11d0
// Size: 0x14
function gadget_roulette_flicker( slot, weapon )
{
    
}

// Namespace roulette
// Params 2
// Checksum 0x42e32b14, Offset: 0x11f0
// Size: 0x9c
function set_gadget_status( status, time )
{
    timestr = "";
    
    if ( isdefined( time ) )
    {
        timestr = "^3" + ", time: " + time;
    }
    
    if ( getdvarint( "scr_cpower_debug_prints" ) > 0 )
    {
        self iprintlnbold( "Gadget Roulette: " + status + timestr );
    }
}

// Namespace roulette
// Params 0
// Checksum 0x786ccab, Offset: 0x1298
// Size: 0x1a
function dpad_left_pressed()
{
    return self actionslotthreebuttonpressed();
}

// Namespace roulette
// Params 1
// Checksum 0xb828d0d1, Offset: 0x12c0
// Size: 0x166
function getrandomgadget( isprimaryroll )
{
    if ( isprimaryroll )
    {
        category = 0;
        totalcategory = 0;
    }
    else
    {
        category = 1;
        totalcategory = 1;
    }
    
    randomgadgetnumber = randomintrange( 1, level.gadgetrouletteprobabilities[ totalcategory ] + 1 );
    gadgetnames = getarraykeys( level.gadgetrouletteprobabilities );
    selectedgadget = "";
    
    foreach ( gadget in gadgetnames )
    {
        randomgadgetnumber -= level.gadgetrouletteprobabilities[ gadget ][ category ];
        
        if ( randomgadgetnumber <= 0 )
        {
            selectedgadget = gadget;
            break;
        }
    }
    
    return selectedgadget;
}

// Namespace roulette
// Params 3
// Checksum 0xf54aeb64, Offset: 0x1430
// Size: 0x126
function registergadgettype( gadgetnamestring, primaryweight, secondaryweight )
{
    gadgetweapon = getweapon( gadgetnamestring );
    assert( isdefined( gadgetweapon ) );
    
    if ( gadgetweapon == level.weaponnone )
    {
        assertmsg( gadgetnamestring + "<dev string:x28>" );
    }
    
    if ( !isdefined( level.gadgetrouletteprobabilities[ gadgetweapon ] ) )
    {
        level.gadgetrouletteprobabilities[ gadgetweapon ] = [];
    }
    
    level.gadgetrouletteprobabilities[ gadgetweapon ][ 0 ] = primaryweight;
    level.gadgetrouletteprobabilities[ gadgetweapon ][ 1 ] = secondaryweight;
    level.gadgetrouletteprobabilities[ 0 ] += primaryweight;
    level.gadgetrouletteprobabilities[ 1 ] += secondaryweight;
}

