#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_powerup_shield_charge;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_riotshield;
#using scripts/zm/craftables/_zm_craftables;

#namespace zm_craft_shield;

// Namespace zm_craft_shield
// Params 0, eflags: 0x2
// Checksum 0x1fd66332, Offset: 0x438
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "zm_craft_shield", &__init__, &__main__, undefined );
}

// Namespace zm_craft_shield
// Params 0
// Checksum 0x99ec1590, Offset: 0x480
// Size: 0x4
function __init__()
{
    
}

// Namespace zm_craft_shield
// Params 6
// Checksum 0xa0a13710, Offset: 0x490
// Size: 0x47c
function init( shield_equipment, shield_weapon, shield_model, str_to_craft, str_taken, str_grab )
{
    if ( !isdefined( str_to_craft ) )
    {
        str_to_craft = &"ZOMBIE_CRAFT_RIOT";
    }
    
    if ( !isdefined( str_taken ) )
    {
        str_taken = &"ZOMBIE_BOUGHT_RIOT";
    }
    
    if ( !isdefined( str_grab ) )
    {
        str_grab = &"ZOMBIE_GRAB_RIOTSHIELD";
    }
    
    level.craftable_shield_equipment = shield_equipment;
    level.craftable_shield_weapon = shield_weapon;
    level.craftable_shield_model = shield_model;
    level.craftable_shield_grab = str_grab;
    level.riotshield_supports_deploy = 0;
    riotshield_dolly = zm_craftables::generate_zombie_craftable_piece( level.craftable_shield_equipment, "dolly", 32, 64, 0, undefined, &on_pickup_common, &on_drop_common, undefined, undefined, undefined, undefined, "piece_riotshield_dolly", 1, "build_zs" );
    riotshield_door = zm_craftables::generate_zombie_craftable_piece( level.craftable_shield_equipment, "door", 48, 15, 25, undefined, &on_pickup_common, &on_drop_common, undefined, undefined, undefined, undefined, "piece_riotshield_door", 1, "build_zs" );
    riotshield_clamp = zm_craftables::generate_zombie_craftable_piece( level.craftable_shield_equipment, "clamp", 48, 15, 25, undefined, &on_pickup_common, &on_drop_common, undefined, undefined, undefined, undefined, "piece_riotshield_clamp", 1, "build_zs" );
    registerclientfield( "world", "piece_riotshield_dolly", 1, 1, "int", undefined, 0 );
    registerclientfield( "world", "piece_riotshield_door", 1, 1, "int", undefined, 0 );
    registerclientfield( "world", "piece_riotshield_clamp", 1, 1, "int", undefined, 0 );
    clientfield::register( "toplayer", "ZMUI_SHIELD_PART_PICKUP", 1, 1, "int" );
    clientfield::register( "toplayer", "ZMUI_SHIELD_CRAFTED", 1, 1, "int" );
    riotshield = spawnstruct();
    riotshield.name = level.craftable_shield_equipment;
    riotshield.weaponname = level.craftable_shield_weapon;
    riotshield zm_craftables::add_craftable_piece( riotshield_dolly );
    riotshield zm_craftables::add_craftable_piece( riotshield_door );
    riotshield zm_craftables::add_craftable_piece( riotshield_clamp );
    riotshield.onbuyweapon = &on_buy_weapon_riotshield;
    riotshield.triggerthink = &riotshield_craftable;
    zm_craftables::include_zombie_craftable( riotshield );
    zm_craftables::add_zombie_craftable( level.craftable_shield_equipment, str_to_craft, "ERROR", str_taken, &on_fully_crafted, 1 );
    zm_craftables::add_zombie_craftable_vox_category( level.craftable_shield_equipment, "build_zs" );
    zm_craftables::make_zombie_craftable_open( level.craftable_shield_equipment, level.craftable_shield_model, ( 0, -90, 0 ), ( 0, 0, 26 ) );
}

// Namespace zm_craft_shield
// Params 0
// Checksum 0x4d304f75, Offset: 0x918
// Size: 0x1c
function __main__()
{
    /#
        shield_devgui();
    #/
}

// Namespace zm_craft_shield
// Params 0
// Checksum 0xd2c90327, Offset: 0x940
// Size: 0x3c
function riotshield_craftable()
{
    zm_craftables::craftable_trigger_think( "riotshield_zm_craftable_trigger", level.craftable_shield_equipment, level.craftable_shield_weapon, level.craftable_shield_grab, 1, 1 );
}

// Namespace zm_craft_shield
// Params 2
// Checksum 0xba70474a, Offset: 0x988
// Size: 0x54
function show_infotext_for_duration( str_infotext, n_duration )
{
    self clientfield::set_to_player( str_infotext, 1 );
    wait n_duration;
    self clientfield::set_to_player( str_infotext, 0 );
}

// Namespace zm_craft_shield
// Params 1
// Checksum 0x84261de7, Offset: 0x9e8
// Size: 0x148
function on_pickup_common( player )
{
    println( "<dev string:x28>" );
    player playsound( "zmb_craftable_pickup" );
    
    if ( isdefined( level.craft_shield_piece_pickup_vo_override ) )
    {
        player thread [[ level.craft_shield_piece_pickup_vo_override ]]();
    }
    
    foreach ( e_player in level.players )
    {
        e_player thread zm_craftables::player_show_craftable_parts_ui( "zmInventory.player_crafted_shield", "zmInventory.widget_shield_parts", 0 );
        e_player thread show_infotext_for_duration( "ZMUI_SHIELD_PART_PICKUP", 3.5 );
    }
    
    self pickup_from_mover();
    self.piece_owner = player;
}

// Namespace zm_craft_shield
// Params 1
// Checksum 0xcd5b9b4d, Offset: 0xb38
// Size: 0x4e
function on_drop_common( player )
{
    println( "<dev string:x4e>" );
    self drop_on_mover( player );
    self.piece_owner = undefined;
}

// Namespace zm_craft_shield
// Params 0
// Checksum 0xf1366177, Offset: 0xb90
// Size: 0x20
function pickup_from_mover()
{
    if ( isdefined( level.craft_shield_pickup_override ) )
    {
        [[ level.craft_shield_pickup_override ]]();
    }
}

// Namespace zm_craft_shield
// Params 0
// Checksum 0x2ee760d8, Offset: 0xbb8
// Size: 0xee, Type: bool
function on_fully_crafted()
{
    players = level.players;
    
    foreach ( e_player in players )
    {
        if ( zm_utility::is_player_valid( e_player ) )
        {
            e_player thread zm_craftables::player_show_craftable_parts_ui( "zmInventory.player_crafted_shield", "zmInventory.widget_shield_parts", 1 );
            e_player thread show_infotext_for_duration( "ZMUI_SHIELD_CRAFTED", 3.5 );
        }
    }
    
    return true;
}

// Namespace zm_craft_shield
// Params 1
// Checksum 0xb4f35b68, Offset: 0xcb0
// Size: 0x28
function drop_on_mover( player )
{
    if ( isdefined( level.craft_shield_drop_override ) )
    {
        [[ level.craft_shield_drop_override ]]();
    }
}

// Namespace zm_craft_shield
// Params 1
// Checksum 0xf23923d0, Offset: 0xce0
// Size: 0x96
function on_buy_weapon_riotshield( player )
{
    if ( isdefined( player.player_shield_reset_health ) )
    {
        player [[ player.player_shield_reset_health ]]();
    }
    
    if ( isdefined( player.player_shield_reset_location ) )
    {
        player [[ player.player_shield_reset_location ]]();
    }
    
    player playsound( "zmb_craftable_buy_shield" );
    level notify( #"shield_built", player );
}

/#

    // Namespace zm_craft_shield
    // Params 0
    // Checksum 0xc5ba1f70, Offset: 0xd80
    // Size: 0xf4, Type: dev
    function shield_devgui()
    {
        level flagsys::wait_till( "<dev string:x72>" );
        wait 1;
        zm_devgui::add_custom_devgui_callback( &shield_devgui_callback );
        setdvar( "<dev string:x8b>", 0 );
        adddebugcommand( "<dev string:xaf>" + level.craftable_shield_equipment + "<dev string:xca>" );
        adddebugcommand( "<dev string:xaf>" + level.craftable_shield_equipment + "<dev string:x119>" );
        adddebugcommand( "<dev string:xaf>" + level.craftable_shield_equipment + "<dev string:x156>" );
    }

    // Namespace zm_craft_shield
    // Params 1
    // Checksum 0x73f015cf, Offset: 0xe80
    // Size: 0x1d0, Type: dev
    function shield_devgui_callback( cmd )
    {
        players = getplayers();
        retval = 0;
        
        switch ( cmd )
        {
            default:
                array::thread_all( players, &function_2b0b208f );
                retval = 1;
                break;
            case "<dev string:x196>":
                if ( players.size >= 1 )
                {
                    players[ 0 ] thread function_2b0b208f();
                }
                
                retval = 1;
                break;
            case "<dev string:x1ad>":
                if ( players.size >= 2 )
                {
                    players[ 1 ] thread function_2b0b208f();
                }
                
                retval = 1;
                break;
            case "<dev string:x1c4>":
                if ( players.size >= 3 )
                {
                    players[ 2 ] thread function_2b0b208f();
                }
                
                retval = 1;
                break;
            case "<dev string:x1db>":
                if ( players.size >= 4 )
                {
                    players[ 3 ] thread function_2b0b208f();
                }
                
                retval = 1;
                break;
            case "<dev string:x1f2>":
                array::thread_all( level.players, &function_70d7908d );
                retval = 1;
                break;
        }
        
        return retval;
    }

    // Namespace zm_craft_shield
    // Params 0
    // Checksum 0xecefade4, Offset: 0x1058
    // Size: 0x38, Type: dev
    function detect_reentry()
    {
        if ( isdefined( self.devgui_preserve_time ) )
        {
            if ( self.devgui_preserve_time == gettime() )
            {
                return 1;
            }
        }
        
        self.devgui_preserve_time = gettime();
        return 0;
    }

    // Namespace zm_craft_shield
    // Params 0
    // Checksum 0x8b036884, Offset: 0x1098
    // Size: 0x198, Type: dev
    function function_2b0b208f()
    {
        if ( self detect_reentry() )
        {
            return;
        }
        
        self notify( #"hash_2b0b208f" );
        self endon( #"hash_2b0b208f" );
        self.var_74469a7a = !( isdefined( self.var_74469a7a ) && self.var_74469a7a );
        println( "<dev string:x202>" + self.name + "<dev string:x212>" + ( self.var_74469a7a ? "<dev string:x228>" : "<dev string:x22b>" ) );
        iprintlnbold( "<dev string:x202>" + self.name + "<dev string:x212>" + ( self.var_74469a7a ? "<dev string:x228>" : "<dev string:x22b>" ) );
        
        if ( self.var_74469a7a )
        {
            while ( isdefined( self ) )
            {
                damagemax = level.weaponriotshield.weaponstarthitpoints;
                
                if ( isdefined( self.weaponriotshield ) )
                {
                    damagemax = self.weaponriotshield.weaponstarthitpoints;
                }
                
                shieldhealth = damagemax;
                shieldhealth = self damageriotshield( 0 );
                self damageriotshield( shieldhealth - damagemax );
                wait 0.05;
            }
        }
    }

    // Namespace zm_craft_shield
    // Params 0
    // Checksum 0x975b5366, Offset: 0x1238
    // Size: 0x54, Type: dev
    function function_70d7908d()
    {
        if ( self detect_reentry() )
        {
            return;
        }
        
        if ( isdefined( self.hasriotshield ) && self.hasriotshield )
        {
            self zm_equipment::change_ammo( self.weaponriotshield, 1 );
        }
    }

#/
