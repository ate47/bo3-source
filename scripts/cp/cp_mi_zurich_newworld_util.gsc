#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_hacking;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_zurich_newworld_rooftops;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/weapons_shared;

#namespace newworld_util;

// Namespace newworld_util
// Params 0, eflags: 0x2
// Checksum 0xf2400b91, Offset: 0xcc8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "newworld_util", &__init__, undefined, undefined );
}

// Namespace newworld_util
// Params 0
// Checksum 0x967c3f5d, Offset: 0xd08
// Size: 0x14
function __init__()
{
    init_client_field_callback_funcs();
}

// Namespace newworld_util
// Params 0
// Checksum 0xc65434e7, Offset: 0xd28
// Size: 0x34
function init_client_field_callback_funcs()
{
    clientfield::register( "toplayer", "postfx_futz", 1, 1, "counter" );
}

// Namespace newworld_util
// Params 0
// Checksum 0xb882e933, Offset: 0xd68
// Size: 0x56c
function replace_weapons()
{
    if ( !isdefined( level.var_ba7d14b0 ) )
    {
        level.var_ba7d14b0 = [];
    }
    
    w_ar = getweapon( "ar_fastburst", "suppressed", "acog" );
    w_smg = getweapon( "smg_fastfire", "extclip" );
    w_lmg = getweapon( "lmg_light", "acog", "fmj", "fastreload" );
    w_shotgun = getweapon( "shotgun_pump", "steadyaim", "extbarrel" );
    var_a0543d15 = getweapon( "pistol_standard", "suppressed", "reflex" );
    var_9254de0d = getweapon( "pistol_standard", "steadyaim" );
    var_ae16e040 = getweapon( "pistol_standard", "steadyaim" );
    var_6473fc51 = getweapon( "pistol_standard", "steadyaim" );
    w_frag = getweapon( "frag_grenade" );
    w_emp = getweapon( "emp_grenade" );
    
    switch ( level.skipto_current_objective[ 0 ] )
    {
        case "factory_alley":
        case "factory_factory_exterior":
        case "factory_factory_intro_igc":
        case "factory_foundry":
        case "factory_inside_man_igc":
        case "factory_vat_room":
        case "factory_warehouse":
        case "white_infinite_igc":
            self take_weapons();
            self.primaryloadoutweapon = w_ar;
            self giveweapon( var_a0543d15 );
            self giveweapon( w_frag );
            self giveweapon( w_emp );
            break;
        case "chase_apartment_igc":
        case "chase_bridge_collapse":
        case "chase_chase_start":
        case "chase_construction_site":
        case "chase_glass_ceiling_igc":
        case "chase_old_zurich":
        case "chase_rooftops":
            self take_weapons();
            self.primaryloadoutweapon = w_smg;
            self giveweapon( var_9254de0d );
            self giveweapon( w_frag );
            self giveweapon( w_emp );
            break;
        case "underground_construction":
        case "underground_crossroads":
        case "underground_maintenance":
        case "underground_pinned_down_igc":
        case "underground_staging_room_igc":
        case "underground_subway":
        case "underground_water_plant":
            if ( !self flagsys::get( "mobile_armory_in_use" ) && !isdefined( level.var_ba7d14b0[ self getentitynumber() ] ) )
            {
                self take_weapons();
                self.primaryloadoutweapon = w_lmg;
                self giveweapon( var_ae16e040 );
                self giveweapon( w_frag );
                self giveweapon( w_emp );
            }
            else
            {
                self thread function_3a7ee040();
            }
            
            break;
        case "train_detach_bomb_igc":
        case "train_inbound_igc":
        case "train_train_roof":
        case "train_train_start":
            self take_weapons();
            self.primaryloadoutweapon = w_shotgun;
            self giveweapon( var_6473fc51 );
            self giveweapon( w_frag );
            self giveweapon( w_emp );
            break;
        default:
            break;
    }
    
    if ( isdefined( self.primaryloadoutweapon ) )
    {
        self giveweapon( self.primaryloadoutweapon );
        self switchtoweapon( self.primaryloadoutweapon );
    }
}

// Namespace newworld_util
// Params 0
// Checksum 0x5dd80e4a, Offset: 0x12e0
// Size: 0x7c
function function_3a7ee040()
{
    if ( !isdefined( level.var_ba7d14b0[ self getentitynumber() ] ) )
    {
        level.var_ba7d14b0[ self getentitynumber() ] = 1;
        self waittill( #"disconnect" );
        level.var_ba7d14b0[ self getentitynumber() ] = undefined;
    }
}

// Namespace newworld_util
// Params 0
// Checksum 0x70b9796d, Offset: 0x1368
// Size: 0xa4
function on_player_loadout()
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    if ( self function_c633d8fe() && isdefined( self.primaryloadoutweapon ) )
    {
        return;
    }
    
    self replace_weapons();
    self replace_cyber_abilities();
    self cybercom_tacrig::takeallrigabilities();
    self cybercom_tacrig::giverigability( "cybercom_playermovement", 0 );
}

// Namespace newworld_util
// Params 1
// Checksum 0x8fb8f55d, Offset: 0x1418
// Size: 0xe0
function take_weapons( b_save )
{
    if ( !isdefined( b_save ) )
    {
        b_save = 1;
    }
    
    a_w_old_weapons = self getweaponslist();
    
    foreach ( w_weapon in a_w_old_weapons )
    {
        self takeweapon( w_weapon );
    }
    
    if ( b_save )
    {
        self.a_w_old_weapons = a_w_old_weapons;
    }
}

// Namespace newworld_util
// Params 0
// Checksum 0x845cf2b2, Offset: 0x1500
// Size: 0x2d2
function replace_cyber_abilities()
{
    wait 0.05;
    self cybercom_gadget::takeallabilities();
    
    switch ( level.skipto_current_objective[ 0 ] )
    {
        case "factory_alley":
        case "factory_factory_exterior":
        case "factory_factory_intro_igc":
        case "factory_foundry":
        case "factory_inside_man_igc":
        case "factory_vat_room":
        case "factory_warehouse":
        case "white_infinite_igc":
            if ( isdefined( level.var_b7a27741 ) && level.var_b7a27741 )
            {
                self cybercom_gadget::giveability( "cybercom_hijack", 0 );
                self cybercom_gadget::equipability( "cybercom_hijack", 1 );
            }
            
            break;
        case "chase_apartment_igc":
        case "chase_bridge_collapse":
        case "chase_chase_start":
        case "chase_construction_site":
        case "chase_glass_ceiling_igc":
        case "chase_old_zurich":
        case "chase_rooftops":
            if ( isdefined( level.var_ebe3b234 ) && level.var_ebe3b234 )
            {
                self cybercom_gadget::giveability( "cybercom_systemoverload", 0 );
                self cybercom_gadget::equipability( "cybercom_systemoverload", 1 );
            }
            
            break;
        case "underground_construction":
        case "underground_crossroads":
        case "underground_maintenance":
        case "underground_pinned_down_igc":
        case "underground_staging_room_igc":
        case "underground_subway":
        case "underground_water_plant":
            if ( isdefined( level.var_e120c906 ) && level.var_e120c906 )
            {
                self cybercom_gadget::giveability( "cybercom_fireflyswarm", 1 );
            }
            
            if ( isdefined( level.var_11d004e5 ) && level.var_11d004e5 )
            {
                self cybercom_gadget::giveability( "cybercom_immolation", 0 );
                self cybercom_gadget::equipability( "cybercom_immolation", 1 );
            }
            
            break;
        case "train_detach_bomb_igc":
        case "train_inbound_igc":
        case "train_train_roof":
        case "train_train_start":
            if ( isdefined( level.var_fbc6080 ) && level.var_fbc6080 )
            {
                self cybercom_gadget::giveability( "cybercom_concussive", 1 );
            }
            
            self cybercom_gadget::giveability( "cybercom_rapidstrike", 0 );
            self cybercom_gadget::equipability( "cybercom_rapidstrike" );
            break;
        default:
            break;
    }
}

// Namespace newworld_util
// Params 0
// Checksum 0x90f9530b, Offset: 0x17e0
// Size: 0xac, Type: bool
function function_7ee91bc9()
{
    foreach ( player in level.players )
    {
        if ( player != self )
        {
            if ( isdefined( player.b_tactical_mode_enabled ) && player.b_tactical_mode_enabled )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace newworld_util
// Params 0
// Checksum 0xa9af1390, Offset: 0x1898
// Size: 0xac, Type: bool
function function_1cf75ffb()
{
    foreach ( player in level.players )
    {
        if ( player != self )
        {
            if ( isdefined( player.b_enhanced_vision_enabled ) && player.b_enhanced_vision_enabled )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace newworld_util
// Params 0
// Checksum 0xeebee6af, Offset: 0x1950
// Size: 0x214
function function_1943bf79()
{
    var_33dcf6cf = 0;
    var_1dedaef1 = 0;
    
    switch ( level.skipto_current_objective[ 0 ] )
    {
        case "factory_factory_exterior":
        case "factory_factory_intro_igc":
        case "white_infinite_igc":
            if ( isdefined( level.var_9ef26e4f ) && level.var_9ef26e4f )
            {
                var_1dedaef1 = 1;
            }
            else
            {
                var_1dedaef1 = 0;
            }
            
            var_33dcf6cf = 0;
            break;
        case "chase_apartment_igc":
        case "chase_bridge_collapse":
        case "chase_chase_start":
        case "chase_construction_site":
        case "chase_glass_ceiling_igc":
        case "chase_old_zurich":
        case "chase_rooftops":
        case "factory_alley":
        case "factory_foundry":
        case "factory_inside_man_igc":
        case "factory_vat_room":
        case "factory_warehouse":
        case "underground_construction":
        case "underground_crossroads":
        case "underground_pinned_down_igc":
        case "underground_subway":
            var_1dedaef1 = 1;
            
            if ( isdefined( level.var_74f7a02e ) && level.var_74f7a02e )
            {
                var_33dcf6cf = 1;
            }
            else
            {
                var_33dcf6cf = 0;
            }
            
            break;
        case "train_detach_bomb_igc":
        case "train_inbound_igc":
        case "train_train_roof":
        case "train_train_start":
        case "underground_maintenance":
        case "underground_staging_room_igc":
        case "underground_water_plant":
            var_1dedaef1 = 1;
            var_33dcf6cf = 1;
            break;
        default:
            break;
    }
    
    println( "<dev string:x28>" + var_1dedaef1 + "<dev string:x35>" + var_33dcf6cf + "<dev string:x41>" );
    self function_a7cfc593( var_1dedaef1 );
    self function_ba1a260f( var_33dcf6cf );
}

// Namespace newworld_util
// Params 0
// Checksum 0x9232fb4a, Offset: 0x1b70
// Size: 0x1e2
function player_snow_fx()
{
    switch ( level.skipto_current_objective[ 0 ] )
    {
        case "white_infinite_igc":
            level clientfield::set( "player_snow_fx", 4 );
            break;
        case "factory_alley":
        case "factory_factory_exterior":
        case "factory_factory_intro_igc":
        case "factory_foundry":
        case "factory_inside_man_igc":
        case "factory_vat_room":
        case "factory_warehouse":
            level clientfield::set( "player_snow_fx", 1 );
            break;
        case "chase_apartment_igc":
        case "chase_bridge_collapse":
        case "chase_chase_start":
        case "chase_construction_site":
        case "chase_glass_ceiling_igc":
        case "chase_old_zurich":
        case "chase_rooftops":
            level clientfield::set( "player_snow_fx", 2 );
            break;
        case "underground_construction":
        case "underground_crossroads":
        case "underground_maintenance":
        case "underground_pinned_down_igc":
        case "underground_staging_room_igc":
        case "underground_subway":
        case "underground_water_plant":
            level clientfield::set( "player_snow_fx", 3 );
            break;
        case "train_inbound_igc":
        case "train_train_roof":
        case "train_train_start":
            level clientfield::set( "player_snow_fx", 4 );
            break;
        case "train_detach_bomb_igc":
        case "waking_up_igc":
            level clientfield::set( "player_snow_fx", 0 );
            break;
        default:
            break;
    }
}

// Namespace newworld_util
// Params 0
// Checksum 0x67fb644b, Offset: 0x1d60
// Size: 0x24
function function_85d8906c()
{
    level clientfield::set( "player_snow_fx", 0 );
}

// Namespace newworld_util
// Params 0
// Checksum 0x821dd1ec, Offset: 0x1d90
// Size: 0x4c
function ai_death_derez()
{
    if ( self should_derez_on_death() )
    {
        self thread derez_when_actor_becomes_corpse();
        self thread derez_on_ragdoll_start();
    }
}

// Namespace newworld_util
// Params 0
// Checksum 0xa5416e50, Offset: 0x1de8
// Size: 0x1c, Type: bool
function should_derez_on_death()
{
    return !isvehicle( self );
}

// Namespace newworld_util
// Params 0
// Checksum 0x52807017, Offset: 0x1e10
// Size: 0xc2
function derez_when_actor_becomes_corpse()
{
    self endon( #"ai_derez_death" );
    self waittill( #"actor_corpse", e_corpse );
    
    if ( isdefined( level.player_on_top_of_train ) && level.player_on_top_of_train )
    {
        wait 10;
    }
    
    if ( isdefined( e_corpse ) )
    {
        e_corpse clientfield::set( "derez_ai_deaths", 1 );
    }
    
    util::wait_network_frame();
    wait 0.1;
    
    if ( isdefined( e_corpse ) )
    {
        e_corpse delete();
    }
    
    if ( isdefined( self ) )
    {
        self notify( #"ai_derez_death" );
    }
}

// Namespace newworld_util
// Params 0
// Checksum 0x628f9e34, Offset: 0x1ee0
// Size: 0xca
function derez_on_ragdoll_start()
{
    self endon( #"ai_derez_death" );
    self waittill( #"start_ragdoll" );
    
    if ( isdefined( level.player_on_top_of_train ) && level.player_on_top_of_train )
    {
        wait 10;
    }
    else if ( self.b_balcony_death === 1 )
    {
        wait 4;
    }
    
    if ( isdefined( self ) )
    {
        self clientfield::set( "derez_ai_deaths", 1 );
    }
    
    util::wait_network_frame();
    wait 0.1;
    
    if ( isdefined( self ) )
    {
        self delete();
        self notify( #"ai_derez_death" );
    }
}

// Namespace newworld_util
// Params 1
// Checksum 0x365097c2, Offset: 0x1fb8
// Size: 0x124
function function_523cdc93( var_9e5eb4d9 )
{
    if ( !isdefined( var_9e5eb4d9 ) )
    {
        var_9e5eb4d9 = 1;
    }
    
    if ( isdefined( var_9e5eb4d9 ) && var_9e5eb4d9 )
    {
        self waittill( #"damage", damage, attacker );
        self thread function_91b16538();
        self thread function_4ccc51b5();
    }
    
    if ( isdefined( self ) )
    {
        self clientfield::set( "derez_ai_deaths", 1 );
    }
    
    util::wait_network_frame();
    wait 0.25;
    
    if ( isdefined( attacker ) && isplayer( attacker ) )
    {
        attacker thread newworld_rooftops::function_8e9219f();
    }
    
    if ( isdefined( self ) )
    {
        self notify( #"hash_ed74b5db" );
        self delete();
    }
}

// Namespace newworld_util
// Params 0
// Checksum 0x5322a8d2, Offset: 0x20e8
// Size: 0x52
function function_91b16538()
{
    self endon( #"hash_ed74b5db" );
    self waittill( #"start_ragdoll" );
    wait 0.25;
    
    if ( isdefined( self ) )
    {
        self delete();
        self notify( #"hash_ed74b5db" );
    }
}

// Namespace newworld_util
// Params 0
// Checksum 0xe54560c9, Offset: 0x2148
// Size: 0x6a
function function_4ccc51b5()
{
    self endon( #"hash_ed74b5db" );
    self waittill( #"actor_corpse", e_corpse );
    wait 0.25;
    
    if ( isdefined( e_corpse ) )
    {
        e_corpse delete();
    }
    
    if ( isdefined( self ) )
    {
        self notify( #"hash_ed74b5db" );
    }
}

// Namespace newworld_util
// Params 3
// Checksum 0x85128044, Offset: 0x21c0
// Size: 0x6c
function wait_till_flag_or_ai_group_ai_count( str_flag, str_aigroup, n_count )
{
    if ( flag::get( str_flag ) )
    {
        return;
    }
    
    level endon( str_flag );
    spawner::waittill_ai_group_ai_count( str_aigroup, int( n_count ) );
}

// Namespace newworld_util
// Params 7
// Checksum 0x643b60d5, Offset: 0x2238
// Size: 0x3dc
function function_948d4091( var_81a32895, b_upgrade, str_endon, b_looping, var_6e6341cf, var_8cb8bcef, var_9e68f294 )
{
    if ( !isdefined( b_upgrade ) )
    {
        b_upgrade = 0;
    }
    
    if ( !isdefined( b_looping ) )
    {
        b_looping = 1;
    }
    
    self endon( #"death" );
    level endon( str_endon );
    
    if ( isdefined( 30 ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( 30, "timeout" );
    }
    
    self flag::init( var_81a32895 + "_WW_opened" );
    self flag::init( var_81a32895 + "_WW_closed" );
    self flag::init( var_81a32895 + "_WW_tutorial" );
    
    if ( var_81a32895 == "cybercom_fireflyswarm" )
    {
        var_bcb7a46f = &"CP_MI_ZURICH_NEWWORLD_SELECT_FIREFLY_LINE_1";
    }
    else if ( var_81a32895 == "cybercom_concussive" )
    {
        var_bcb7a46f = &"CP_MI_ZURICH_NEWWORLD_SELECT_CONCUSSIVE_WAVE_LINE_1";
    }
    
    self thread function_8531ac12( var_81a32895, str_endon );
    self thread function_b95b168e( var_81a32895, str_endon );
    
    if ( isdefined( var_9e68f294 ) )
    {
        a_start_flags = array( var_9e68f294, var_81a32895 + "_WW_tutorial" );
        self flag::wait_till_any( a_start_flags );
    }
    
    a_flags = array( var_81a32895 + "_WW_tutorial", var_81a32895 + "_WW_closed" );
    
    while ( !self flag::get( var_81a32895 + "_WW_tutorial" ) )
    {
        self function_c585d78f( var_81a32895, str_endon );
        self thread util::hide_hint_text( 1 );
        wait 0.5;
        
        while ( !self flag::get( var_81a32895 + "_WW_tutorial" ) && self flag::get( var_81a32895 + "_WW_opened" ) )
        {
            self thread function_e5122074( var_bcb7a46f, str_endon );
            self flag::wait_till_any_timeout( 4, a_flags );
            
            if ( !self flag::get( var_81a32895 + "_WW_tutorial" ) && self flag::get( var_81a32895 + "_WW_opened" ) )
            {
                self flag::wait_till_any_timeout( 3, a_flags );
            }
        }
        
        self thread function_d81a8f6f();
    }
    
    self thread function_6062e90( var_81a32895, b_upgrade, str_endon, b_looping, var_6e6341cf, undefined, var_8cb8bcef );
}

// Namespace newworld_util
// Params 2
// Checksum 0x24ba08b5, Offset: 0x2620
// Size: 0x1b0
function function_c585d78f( var_81a32895, str_endon )
{
    self endon( #"death" );
    level endon( str_endon );
    self endon( var_81a32895 + "_WW_opened" );
    
    if ( isdefined( 30 ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( 30, "timeout" );
    }
    
    self util::hide_hint_text( 1 );
    
    while ( !self flag::get( var_81a32895 + "_WW_opened" ) )
    {
        if ( !level.console && !self gamepadusedlast() )
        {
            self thread util::show_hint_text( &"CP_MI_ZURICH_NEWWORLD_OPEN_CYBERCORE_ABILITY_WHEEL_KB", 0, undefined, 4 );
        }
        else
        {
            self thread util::show_hint_text( &"CP_MI_ZURICH_NEWWORLD_OPEN_CYBERCORE_ABILITY_WHEEL", 0, undefined, 4 );
        }
        
        self flag::wait_till_timeout( 4, var_81a32895 + "_WW_opened" );
        
        if ( !self flag::get( var_81a32895 + "_WW_opened" ) )
        {
            self flag::wait_till_timeout( 3, var_81a32895 + "_WW_opened" );
        }
    }
}

// Namespace newworld_util
// Params 2
// Checksum 0x371e7580, Offset: 0x27d8
// Size: 0xdc
function function_e5122074( var_bcb7a46f, str_endon )
{
    self endon( #"death" );
    self endon( str_endon );
    self.var_bb5e2d77 = self openluimenu( "CyberComTutorial" );
    self setluimenudata( self.var_bb5e2d77, "tutorial_line_1", var_bcb7a46f );
    
    if ( level.console || self gamepadusedlast() )
    {
        self setluimenudata( self.var_bb5e2d77, "tutorial_line_2", &"CP_MI_ZURICH_NEWWORLD_EQUIP_CYBERCORE" );
    }
    
    wait 4;
    self thread function_d81a8f6f();
}

// Namespace newworld_util
// Params 0
// Checksum 0xa54835d3, Offset: 0x28c0
// Size: 0x64
function function_d81a8f6f()
{
    self endon( #"death" );
    
    if ( isdefined( self.var_bb5e2d77 ) )
    {
        lui::play_animation( self.var_bb5e2d77, "fadeout" );
        wait 0.1;
        self closeluimenu( self.var_bb5e2d77 );
    }
}

// Namespace newworld_util
// Params 2
// Checksum 0xa03af4b9, Offset: 0x2930
// Size: 0x148
function function_8531ac12( var_81a32895, str_endon )
{
    self endon( #"death" );
    level endon( str_endon );
    
    if ( isdefined( 30 ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( 30, "timeout" );
    }
    
    while ( !self flag::get( var_81a32895 + "_WW_tutorial" ) )
    {
        self waittill( #"menuresponse", menu, response );
        var_66700f08 = strtok( response, "," );
        
        if ( var_66700f08[ 0 ] == "opened" )
        {
            self flag::set( var_81a32895 + "_WW_opened" );
            self flag::clear( var_81a32895 + "_WW_closed" );
        }
    }
}

// Namespace newworld_util
// Params 2
// Checksum 0x72e6c595, Offset: 0x2a80
// Size: 0x168
function function_b95b168e( var_81a32895, str_endon )
{
    self endon( #"death" );
    level endon( str_endon );
    
    if ( isdefined( 30 ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( 30, "timeout" );
    }
    
    while ( true )
    {
        self waittill( #"menuresponse", menu, response );
        var_66700f08 = strtok( response, "," );
        
        if ( var_66700f08[ 0 ] == "opened" )
        {
            continue;
        }
        
        if ( var_66700f08[ 0 ] == var_81a32895 )
        {
            self flag::set( var_81a32895 + "_WW_tutorial" );
            break;
        }
        
        self flag::clear( var_81a32895 + "_WW_opened" );
        self flag::set( var_81a32895 + "_WW_closed" );
    }
}

// Namespace newworld_util
// Params 8
// Checksum 0x415ca440, Offset: 0x2bf0
// Size: 0x3d0
function function_6062e90( var_81a32895, b_upgrade, str_endon, b_looping, var_6e6341cf, var_e8551372, var_9e68f294, var_3945b2c8 )
{
    if ( !isdefined( b_upgrade ) )
    {
        b_upgrade = 0;
    }
    
    if ( !isdefined( b_looping ) )
    {
        b_looping = 1;
    }
    
    self endon( #"death" );
    
    if ( isarray( str_endon ) )
    {
        foreach ( str_condition in str_endon )
        {
            level endon( str_condition );
        }
    }
    else
    {
        level endon( str_endon );
    }
    
    if ( isdefined( var_3945b2c8 ) )
    {
        self endon( var_3945b2c8 );
    }
    
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    self gadgetpowerset( 0, 100 );
    self gadgetpowerset( 1, 100 );
    var_279df5c8 = 0;
    
    if ( var_81a32895 == "cybercom_fireflyswarm" || var_81a32895 == "cybercom_rapidstrike" || var_81a32895 == "cybercom_concussive" )
    {
        var_279df5c8 = 1;
    }
    
    if ( isdefined( 30 ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( 30, "timeout" );
    }
    
    if ( !self flag::exists( var_81a32895 + "_use_ability_tutorial" ) )
    {
        self flag::init( var_81a32895 + "_use_ability_tutorial" );
    }
    else
    {
        self flag::clear( var_81a32895 + "_use_ability_tutorial" );
    }
    
    self thread function_a7a2da7e( var_81a32895, b_upgrade, str_endon );
    
    if ( isdefined( var_9e68f294 ) )
    {
        if ( isfloat( var_9e68f294 ) || isint( var_9e68f294 ) )
        {
            n_wait = var_9e68f294;
            wait n_wait;
        }
        else if ( self flag::exists( var_9e68f294 ) )
        {
            self flag::wait_till( var_9e68f294 );
        }
        else if ( level flag::exists( var_9e68f294 ) )
        {
            level flag::wait_till( var_9e68f294 );
        }
    }
    
    while ( !self flag::get( var_81a32895 + "_use_ability_tutorial" ) )
    {
        self function_c60fae50( var_81a32895, str_endon, b_looping, var_6e6341cf );
        
        if ( !var_279df5c8 )
        {
            self function_5dca74fc( var_81a32895, str_endon, var_e8551372 );
        }
    }
}

// Namespace newworld_util
// Params 4
// Checksum 0x26838167, Offset: 0x2fc8
// Size: 0x208
function function_c60fae50( var_81a32895, str_endon, b_looping, var_f069395f )
{
    self endon( #"death" );
    
    if ( isarray( str_endon ) )
    {
        foreach ( str_condition in str_endon )
        {
            level endon( str_condition );
        }
    }
    else
    {
        level endon( str_endon );
    }
    
    self endon( var_81a32895 + "_primed" );
    
    if ( isdefined( 30 ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( 30, "timeout" );
    }
    
    while ( !self flag::get( var_81a32895 + "_use_ability_tutorial" ) )
    {
        if ( isdefined( var_f069395f ) )
        {
            self thread util::show_hint_text( var_f069395f, 0, undefined, 4 );
        }
        else
        {
            self thread util::show_hint_text( &"CP_MI_ZURICH_NEWWORLD_USE_CYBERCORE", 0, undefined, 4 );
        }
        
        if ( b_looping === 1 )
        {
            if ( !self flag::get( var_81a32895 + "_use_ability_tutorial" ) )
            {
                self flag::wait_till_timeout( 3, var_81a32895 + "_use_ability_tutorial" );
            }
            
            continue;
        }
        
        break;
    }
}

// Namespace newworld_util
// Params 3
// Checksum 0x6f019b5c, Offset: 0x31d8
// Size: 0x1b8
function function_5dca74fc( var_81a32895, str_endon, var_e8551372 )
{
    self endon( #"death" );
    
    if ( isarray( str_endon ) )
    {
        foreach ( str_condition in str_endon )
        {
            level endon( str_condition );
        }
    }
    else
    {
        level endon( str_endon );
    }
    
    self endon( var_81a32895 + "_off" );
    
    if ( isdefined( 30 ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( 30, "timeout" );
    }
    
    self util::hide_hint_text( 1 );
    
    while ( !self flag::get( var_81a32895 + "_use_ability_tutorial" ) )
    {
        level waittill( #"ccom_locked_on", ent, e_player );
        
        if ( e_player == self )
        {
            self function_e52b73c0( var_81a32895, str_endon, var_e8551372 );
        }
    }
}

// Namespace newworld_util
// Params 3
// Checksum 0x29c326c3, Offset: 0x3398
// Size: 0x1bc
function function_e52b73c0( var_81a32895, str_endon, var_f069395f )
{
    self endon( #"death" );
    
    if ( isarray( str_endon ) )
    {
        foreach ( str_condition in str_endon )
        {
            level endon( str_condition );
        }
    }
    else
    {
        level endon( str_endon );
    }
    
    self endon( var_81a32895 + "_off" );
    
    if ( isdefined( 30 ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( 30, "timeout" );
    }
    
    self endon( #"hash_5e2557e1" );
    self thread function_e84823a9( var_81a32895, str_endon );
    wait 0.8;
    self util::show_hint_text( var_f069395f, 0, undefined, 4 );
    
    if ( !self flag::get( var_81a32895 + "_use_ability_tutorial" ) )
    {
        self flag::wait_till_timeout( 3, var_81a32895 + "_use_ability_tutorial" );
    }
}

// Namespace newworld_util
// Params 2
// Checksum 0x985c5d6b, Offset: 0x3560
// Size: 0x1a2
function function_e84823a9( var_81a32895, str_endon )
{
    self endon( #"death" );
    
    if ( isarray( str_endon ) )
    {
        foreach ( str_condition in str_endon )
        {
            level endon( str_condition );
        }
    }
    else
    {
        level endon( str_endon );
    }
    
    self endon( var_81a32895 + "_off" );
    
    if ( isdefined( 30 ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( 30, "timeout" );
    }
    
    while ( true )
    {
        level waittill( #"ccom_lost_lock", ent, e_player );
        
        if ( e_player == self )
        {
            if ( isdefined( self.cybercom ) && self.cybercom.lock_targets.size < 1 )
            {
                self notify( #"hash_5e2557e1" );
                self util::hide_hint_text( 1 );
                return;
            }
        }
    }
}

// Namespace newworld_util
// Params 3
// Checksum 0xaa59dc84, Offset: 0x3710
// Size: 0x1bc
function function_a7a2da7e( var_81a32895, b_upgrade, str_endon )
{
    if ( !isdefined( b_upgrade ) )
    {
        b_upgrade = 0;
    }
    
    self endon( #"death" );
    
    if ( isarray( str_endon ) )
    {
        foreach ( str_condition in str_endon )
        {
            level endon( str_condition );
        }
    }
    else
    {
        level endon( str_endon );
    }
    
    if ( isdefined( 30 ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( 30, "timeout" );
    }
    
    weapon = function_71840183( var_81a32895, b_upgrade );
    self waittill( weapon.name + "_fired" );
    self flag::set( var_81a32895 + "_use_ability_tutorial" );
    level notify( var_81a32895 + "_use_ability_tutorial" );
    self util::hide_hint_text( 1 );
}

// Namespace newworld_util
// Params 2
// Checksum 0x9559da0c, Offset: 0x38d8
// Size: 0x94
function function_71840183( var_81a32895, b_upgrade )
{
    if ( !isdefined( b_upgrade ) )
    {
        b_upgrade = 0;
    }
    
    weapon = undefined;
    ability = cybercom_gadget::getabilitybyname( var_81a32895 );
    
    if ( b_upgrade == 1 )
    {
        weapon = ability.weaponupgraded;
    }
    else
    {
        weapon = ability.weapon;
    }
    
    return weapon;
}

// Namespace newworld_util
// Params 0
// Checksum 0xd6f9c10d, Offset: 0x3978
// Size: 0x120
function function_2e7b4007()
{
    self endon( #"death" );
    level endon( #"underground_combat_complete" );
    self.var_8a320fc6 = 0;
    var_6d5d984c = function_71840183( "cybercom_immolation" );
    var_bb989cf4 = var_6d5d984c.name + "_fired";
    var_239727aa = function_71840183( "cybercom_fireflyswarm", 1 );
    var_aa2f1c54 = var_239727aa.name + "_fired";
    self thread function_6851db33( var_6d5d984c, var_239727aa );
    
    while ( true )
    {
        self util::waittill_any( var_bb989cf4, var_aa2f1c54 );
        self notify( #"cc_ability_used" );
        self.var_8a320fc6++;
    }
}

// Namespace newworld_util
// Params 2
// Checksum 0xe5fdd5f6, Offset: 0x3aa0
// Size: 0x136
function function_6851db33( var_3283f77e, var_239727aa )
{
    self endon( #"death" );
    level endon( #"underground_combat_complete" );
    
    while ( true )
    {
        wait 90;
        
        if ( self.var_8a320fc6 < 1 )
        {
            self notify( #"hash_6851db33" );
            
            if ( self._gadgets_player[ 0 ] === var_3283f77e )
            {
                self thread function_6062e90( "cybercom_immolation", 0, "underground_combat_complete", 1, "CP_MI_ZURICH_NEWWORLD_IMMOLATION_TARGET", "CP_MI_ZURICH_NEWWORLD_IMMOLATION_RELEASE" );
            }
            else if ( self._gadgets_player[ 0 ] === var_239727aa )
            {
                self thread function_6062e90( "cybercom_fireflyswarm", 1, "underground_combat_complete", 1, "CP_MI_ZURICH_NEWWORLD_FIREFLY_SWARM_TUTORIAL" );
            }
            
            self util::waittill_any_timeout( 4, "cc_ability_used" );
            self thread util::hide_hint_text( 1 );
            continue;
        }
        
        return;
    }
}

// Namespace newworld_util
// Params 0
// Checksum 0x3e57cae6, Offset: 0x3be0
// Size: 0xcc
function function_70176ad6()
{
    self endon( #"death" );
    
    if ( self function_c633d8fe() )
    {
        return;
    }
    
    if ( !isdefined( self.var_98bf72c3 ) )
    {
        self.var_98bf72c3 = 0;
    }
    
    while ( self.var_98bf72c3 < 3 )
    {
        self waittill( #"gadget_denied_activation", n_slot, var_2de327e8 );
        
        if ( var_2de327e8 == 1 )
        {
            self.var_98bf72c3++;
            self util::show_hint_text( &"CP_MI_ZURICH_NEWWORLD_CYBERCOM_RECHARGE", 0, undefined, 4 );
            level notify( #"hash_76cbcc2f" );
            wait 30;
        }
    }
}

// Namespace newworld_util
// Params 2
// Checksum 0xedacd404, Offset: 0x3cb8
// Size: 0x76
function function_520255e3( str_trigger, time )
{
    str_notify = "mufc_" + str_trigger;
    level thread function_901793d( str_trigger, str_notify );
    level thread function_2ffbaa00( time, str_notify );
    level waittill( str_notify );
}

// Namespace newworld_util
// Params 2
// Checksum 0xf33d2309, Offset: 0x3d38
// Size: 0x6c
function function_901793d( str_trigger, str_notify )
{
    level endon( str_notify );
    e_trigger = getent( str_trigger, "targetname" );
    
    if ( isdefined( e_trigger ) )
    {
        e_trigger waittill( #"trigger" );
    }
    
    level notify( str_notify );
}

// Namespace newworld_util
// Params 2
// Checksum 0xd3a8d407, Offset: 0x3db0
// Size: 0x2c
function function_2ffbaa00( time, str_notify )
{
    level endon( str_notify );
    wait time;
    level notify( str_notify );
}

// Namespace newworld_util
// Params 1
// Checksum 0xbc66fcb4, Offset: 0x3de8
// Size: 0x7e
function function_f29e6c6d( var_7daa2a51 )
{
    a_spawners = getentarray( var_7daa2a51, "targetname" );
    
    for ( i = 0; i < a_spawners.size ; i++ )
    {
        a_spawners[ i ] thread function_9a829e81();
    }
}

// Namespace newworld_util
// Params 0
// Checksum 0xc4c8f875, Offset: 0x3e70
// Size: 0x154
function function_9a829e81()
{
    if ( isdefined( self.script_delay ) )
    {
        wait self.script_delay;
    }
    
    e_ent = self spawner::spawn();
    e_ent endon( #"death" );
    
    if ( isdefined( e_ent.script_noteworthy ) && e_ent.script_noteworthy == "rusher_on_spawn" )
    {
        e_ent ai::set_behavior_attribute( "move_mode", "rusher" );
        e_ent ai::set_behavior_attribute( "sprint", 1 );
    }
    
    if ( isdefined( e_ent.target ) )
    {
        e_ent waittill( #"goal" );
    }
    
    if ( isdefined( e_ent.script_noteworthy ) && e_ent.script_noteworthy == "rusher_at_goal" )
    {
        e_ent ai::set_behavior_attribute( "move_mode", "rusher" );
        e_ent ai::set_behavior_attribute( "sprint", 1 );
    }
}

// Namespace newworld_util
// Params 1
// Checksum 0x2b79f0e9, Offset: 0x3fd0
// Size: 0xac
function function_68b8f4af( e_volume )
{
    a_ai = getaiteamarray( "axis" );
    a_touching = [];
    
    for ( i = 0; i < a_ai.size ; i++ )
    {
        if ( a_ai[ i ] istouching( e_volume ) )
        {
            a_touching[ a_touching.size ] = a_ai[ i ];
        }
    }
    
    return a_touching;
}

// Namespace newworld_util
// Params 4
// Checksum 0xcabb0886, Offset: 0x4088
// Size: 0x18e
function function_c478189b( str_trigger, var_390543cc, var_9d774f5d, max_guys )
{
    if ( isdefined( str_trigger ) )
    {
        e_trigger = getent( str_trigger, "targetname" );
        e_trigger waittill( #"trigger" );
    }
    
    var_441bd962 = getent( var_390543cc, "targetname" );
    var_ee2fd889 = getent( var_9d774f5d, "targetname" );
    a_ai = getaiteamarray( "axis" );
    
    if ( !isdefined( max_guys ) )
    {
        max_guys = a_ai.size;
    }
    
    if ( max_guys > a_ai.size )
    {
        max_guys = a_ai.size;
    }
    
    for ( i = 0; i < max_guys ; i++ )
    {
        e_ent = a_ai[ i ];
        
        if ( e_ent istouching( var_441bd962 ) )
        {
            e_ent setgoalvolume( var_ee2fd889 );
        }
    }
}

// Namespace newworld_util
// Params 1
// Checksum 0xf3587fe3, Offset: 0x4220
// Size: 0xa8
function function_f5363f47( str_trigger )
{
    a_triggers = getentarray( str_trigger, "targetname" );
    str_notify = str_trigger + "_waiting";
    
    for ( i = 0; i < a_triggers.size ; i++ )
    {
        level thread function_7eb8a7ab( a_triggers[ i ], str_notify );
    }
    
    level waittill( str_notify );
}

// Namespace newworld_util
// Params 2
// Checksum 0x75f0bfd, Offset: 0x42d0
// Size: 0x34
function function_7eb8a7ab( e_trigger, str_notify )
{
    level endon( str_notify );
    e_trigger waittill( #"trigger" );
    level notify( str_notify );
}

// Namespace newworld_util
// Params 1
// Checksum 0xb91f47a2, Offset: 0x4310
// Size: 0x92
function num_players_touching_volume( e_volume )
{
    a_players = getplayers();
    num_touching = 0;
    
    for ( i = 0; i < a_players.size ; i++ )
    {
        if ( a_players[ i ] istouching( e_volume ) )
        {
            num_touching++;
        }
    }
    
    return num_touching;
}

// Namespace newworld_util
// Params 9
// Checksum 0x1883b361, Offset: 0x43b0
// Size: 0x464
function function_e0fb6da9( str_struct, close_dist, wait_time_min, wait_time_max, var_d1b83750, max_ai, var_a70db4af, var_1813646e, var_98e9bc46 )
{
    a_players = getplayers();
    
    if ( a_players.size > 1 )
    {
        return;
    }
    
    s_struct = struct::get( str_struct, "targetname" );
    var_37124366 = getent( var_1813646e, "targetname" );
    var_7d22b48e = getent( var_98e9bc46, "targetname" );
    v_forward = anglestoforward( s_struct.angles );
    s_struct.start_time = undefined;
    num_charges = 0;
    wait_time = randomintrange( wait_time_min, wait_time_max );
    
    while ( true )
    {
        e_player = getplayers()[ 0 ];
        v_dir = s_struct.origin - e_player.origin;
        var_989d1f7c = vectordot( v_dir, v_forward );
        
        if ( var_989d1f7c < -100 )
        {
            return;
        }
        
        dist = distance( s_struct.origin, e_player.origin );
        
        if ( dist < close_dist )
        {
            if ( !isdefined( s_struct.start_time ) )
            {
                s_struct.start_time = gettime();
            }
        }
        else
        {
            s_struct.start_time = undefined;
        }
        
        if ( isdefined( s_struct.start_time ) )
        {
            time = gettime();
            dt = ( time - s_struct.start_time ) / 1000;
            
            if ( dt > wait_time )
            {
                a_ai = getaiteamarray( "axis" );
                a_touching = [];
                
                for ( i = 0; i < a_ai.size ; i++ )
                {
                    e_ent = a_ai[ i ];
                    
                    if ( !isdefined( e_ent.var_db552f4 ) )
                    {
                        if ( e_ent istouching( var_37124366 ) )
                        {
                            a_touching[ a_touching.size ] = e_ent;
                        }
                    }
                }
                
                var_d6f9eed8 = randomintrange( var_d1b83750, max_ai + 1 );
                
                if ( var_d6f9eed8 > a_touching.size )
                {
                    var_d6f9eed8 = a_touching.size;
                }
                
                for ( i = 0; i < var_d6f9eed8 ; i++ )
                {
                    a_touching[ i ] setgoal( var_7d22b48e );
                    a_touching[ i ].var_db552f4 = 1;
                }
                
                s_struct.start_time = undefined;
                num_charges++;
                
                if ( num_charges >= var_a70db4af )
                {
                    return;
                }
                
                wait_time = randomintrange( wait_time_min, wait_time_max );
            }
        }
        
        wait 0.05;
    }
}

// Namespace newworld_util
// Params 3
// Checksum 0xb773a099, Offset: 0x4820
// Size: 0x156
function function_8f7b1e06( str_trigger, var_390543cc, var_9d774f5d )
{
    if ( isdefined( str_trigger ) )
    {
        e_trigger = getent( str_trigger, "targetname" );
        e_trigger waittill( #"trigger" );
    }
    
    var_441bd962 = getent( var_390543cc, "targetname" );
    var_ee2fd889 = getent( var_9d774f5d, "targetname" );
    a_ai = getaiteamarray( "axis" );
    
    for ( i = 0; i < a_ai.size ; i++ )
    {
        e_ent = a_ai[ i ];
        
        if ( e_ent istouching( var_441bd962 ) )
        {
            e_ent setgoalvolume( var_ee2fd889 );
        }
    }
}

// Namespace newworld_util
// Params 4
// Checksum 0x92a22c39, Offset: 0x4980
// Size: 0x126
function function_bccc2e65( str_aigroup, var_6ec47843, str_node, goal_radius )
{
    spawner::waittill_ai_group_ai_count( "aig_water_treatment", var_6ec47843 );
    nd_node = getnode( str_node, "targetname" );
    a_ai = getentarray( str_aigroup, "script_aigroup" );
    
    for ( i = 0; i < a_ai.size ; i++ )
    {
        e_ent = a_ai[ i ];
        
        if ( issentient( e_ent ) )
        {
            e_ent.goalradius = goal_radius;
            e_ent setgoal( nd_node.origin );
        }
    }
}

// Namespace newworld_util
// Params 3
// Checksum 0x9a6107de, Offset: 0x4ab0
// Size: 0x7c
function movie_transition( str_movie_name, var_e0017db3, var_43656dbb )
{
    if ( !isdefined( var_e0017db3 ) )
    {
        var_e0017db3 = "fullscreen";
    }
    
    if ( !isdefined( var_43656dbb ) )
    {
        var_43656dbb = 0;
    }
    
    if ( !isdefined( var_e0017db3 ) )
    {
        var_e0017db3 = "fullscreen";
    }
    
    level post_fx_transitions( str_movie_name, var_e0017db3, var_43656dbb );
}

// Namespace newworld_util
// Params 3
// Checksum 0x379929b6, Offset: 0x4b38
// Size: 0x172
function post_fx_transitions( str_movie_name, var_e0017db3, var_43656dbb )
{
    if ( !isdefined( var_e0017db3 ) )
    {
        var_e0017db3 = "fullscreen";
    }
    
    if ( var_43656dbb )
    {
        foreach ( player in level.players )
        {
            player clientfield::increment_to_player( "postfx_futz", 1 );
        }
    }
    
    lui::play_movie( str_movie_name, var_e0017db3 );
    
    if ( var_43656dbb )
    {
        foreach ( player in level.players )
        {
            player clientfield::increment_to_player( "postfx_futz", 1 );
        }
    }
}

// Namespace newworld_util
// Params 1
// Checksum 0xdeeac896, Offset: 0x4cb8
// Size: 0x23c
function function_30ec5bf7( b_starting )
{
    if ( !isdefined( b_starting ) )
    {
        b_starting = 0;
    }
    
    if ( b_starting )
    {
        level flag::set( "infinite_white_transition" );
        lock_player_controls( 1 );
        util::screen_fade_out( 0, "white", "infinite_white" );
    }
    else
    {
        level flag::wait_till( "infinite_white_transition" );
        lui::prime_movie( "cp_newworld_fs_whiteinfinite", 1 );
        lock_player_controls( 1 );
        util::screen_fade_out( 0.5, "white", "infinite_white" );
        level thread lui::play_movie( "cp_newworld_fs_whiteinfinite", "fullscreen", 0, 1 );
    }
    
    level flag::wait_till_clear( "infinite_white_transition" );
    
    foreach ( e_player in level.activeplayers )
    {
        e_player notify( #"menuresponse", "FullscreenMovie", "finished_movie_playback" );
    }
    
    util::screen_fade_in( 0.5, "white", "infinite_white" );
    lock_player_controls( 0 );
    videostop( "cp_newworld_fs_whiteinfinite" );
}

// Namespace newworld_util
// Params 1
// Checksum 0x1657243c, Offset: 0x4f00
// Size: 0x9a
function function_43dfaf16( a_ents )
{
    foreach ( player in level.activeplayers )
    {
        player notify( #"menuresponse", "FullscreenMovie", "finished_movie_playback" );
    }
}

// Namespace newworld_util
// Params 1
// Checksum 0x33d31110, Offset: 0x4fa8
// Size: 0xe2
function lock_player_controls( b_lock )
{
    if ( !isdefined( b_lock ) )
    {
        b_lock = 1;
    }
    
    foreach ( player in level.activeplayers )
    {
        if ( b_lock )
        {
            player enableinvulnerability();
        }
        else
        {
            player disableinvulnerability();
        }
        
        player util::freeze_player_controls( b_lock );
    }
}

// Namespace newworld_util
// Params 6
// Checksum 0x5ea8882d, Offset: 0x5098
// Size: 0x1d8
function function_16dd8c5f( str_triggername, str_type, str_hint, var_8baec92b, var_2df3d133, var_d78830f5 )
{
    if ( !isdefined( str_type ) )
    {
        str_type = &"cp_level_newworld_access_door";
    }
    
    if ( !isdefined( str_hint ) )
    {
        str_hint = &"CP_MI_ZURICH_NEWWORLD_HACK";
    }
    
    if ( !isdefined( var_d78830f5 ) )
    {
        var_d78830f5 = 0;
    }
    
    t_interact = getent( str_triggername, "targetname" );
    t_interact triggerenable( 1 );
    
    if ( isdefined( var_8baec92b ) )
    {
        var_69f96d87 = getentarray( var_8baec92b, "targetname" );
    }
    else
    {
        var_69f96d87 = [];
    }
    
    if ( !var_d78830f5 )
    {
        s_gameobject = util::init_interactive_gameobject( t_interact, str_type, str_hint, &function_e27a8082, var_69f96d87 );
        s_gameobject.var_2df3d133 = var_2df3d133;
        level waittill( var_2df3d133, e_player );
    }
    else
    {
        t_interact hacking::init_hack_trigger( 1, str_type, str_hint, undefined, var_69f96d87 );
        t_interact hacking::trigger_wait();
    }
    
    if ( isdefined( var_2df3d133 ) )
    {
        level notify( var_2df3d133 );
    }
    
    if ( isdefined( e_player ) )
    {
        return e_player;
    }
}

// Namespace newworld_util
// Params 1
// Checksum 0x37aa6ef0, Offset: 0x5278
// Size: 0x36
function function_e27a8082( e_player )
{
    self gameobjects::disable_object();
    level notify( self.var_2df3d133, e_player );
}

// Namespace newworld_util
// Params 2
// Checksum 0x7fa9bc14, Offset: 0x52b8
// Size: 0x1a2
function function_39c9b63e( b_enable, var_98011344 )
{
    if ( !isdefined( b_enable ) )
    {
        b_enable = 1;
    }
    
    a_caches = getentarray( "ammo_cache", "script_noteworthy" );
    
    foreach ( e_ammo_cache in a_caches )
    {
        if ( e_ammo_cache.script_objective === var_98011344 || isdefined( e_ammo_cache.gameobject ) && !isdefined( var_98011344 ) )
        {
            if ( !b_enable )
            {
                e_ammo_cache oed::disable_thermal();
                e_ammo_cache oed::disable_keyline();
                e_ammo_cache.gameobject gameobjects::disable_object();
                continue;
            }
            
            e_ammo_cache.gameobject gameobjects::enable_object();
            e_ammo_cache oed::enable_thermal();
            e_ammo_cache oed::enable_keyline();
        }
    }
}

// Namespace newworld_util
// Params 0
// Checksum 0xd27dcf03, Offset: 0x5468
// Size: 0x104
function function_95132241()
{
    self endon( #"death" );
    b_can_delete = 0;
    
    while ( b_can_delete == 0 )
    {
        wait 1;
        
        foreach ( e_player in level.activeplayers )
        {
            if ( e_player util::is_player_looking_at( self.origin ) == 0 )
            {
                b_can_delete = 1;
                continue;
            }
            
            b_can_delete = 0;
        }
    }
    
    self util::stop_magic_bullet_shield();
    self kill();
}

// Namespace newworld_util
// Params 1
// Checksum 0x5f8741ce, Offset: 0x5578
// Size: 0x154
function function_c1c980d8( str_trigger )
{
    a_enemies = getaiteamarray( "axis" );
    t_trigger = getent( str_trigger, "targetname" );
    assert( isdefined( t_trigger ), "<dev string:x4d>" );
    
    foreach ( enemy in a_enemies )
    {
        if ( isalive( enemy ) && enemy istouching( t_trigger ) )
        {
            enemy thread function_95132241();
        }
    }
    
    t_trigger delete();
}

// Namespace newworld_util
// Params 1
// Checksum 0x9e0dd75c, Offset: 0x56d8
// Size: 0xa4
function function_c949a8ed( var_b06baa1b )
{
    if ( !isdefined( var_b06baa1b ) )
    {
        var_b06baa1b = 0;
    }
    
    self thread function_e44cc74b( var_b06baa1b );
    self playsound( "evt_ai_derez" );
    
    if ( var_b06baa1b )
    {
        self clientfield::increment( "cs_rez_in_fx", 2 );
        return;
    }
    
    self clientfield::increment( "cs_rez_in_fx", 1 );
}

// Namespace newworld_util
// Params 1
// Checksum 0x8fe77997, Offset: 0x5788
// Size: 0x16c
function function_e44cc74b( var_b06baa1b )
{
    self endon( #"death" );
    
    if ( var_b06baa1b )
    {
        if ( self.animname == "hall" )
        {
            self setmodel( "c_hro_sarah_salvation_reveal" );
        }
        else if ( !( isdefined( self.isdying ) && self.isdying ) )
        {
            self setmodel( "c_hro_" + self.animname + "_base_rev" );
        }
        
        util::wait_network_frame();
        self show();
        wait 0.5;
        
        if ( self.animname == "hall" )
        {
            self setmodel( "c_hro_sarah_base" );
        }
        else if ( !( isdefined( self.isdying ) && self.isdying ) )
        {
            self setmodel( "c_hro_" + self.animname + "_base" );
        }
        
        return;
    }
    
    wait 0.4;
    self show();
}

// Namespace newworld_util
// Params 1
// Checksum 0xcef727b3, Offset: 0x5900
// Size: 0xa4
function function_4943984c( var_b06baa1b )
{
    if ( !isdefined( var_b06baa1b ) )
    {
        var_b06baa1b = 0;
    }
    
    self thread function_9ab5a5ab( var_b06baa1b );
    self playsound( "evt_ai_derez" );
    
    if ( var_b06baa1b )
    {
        self clientfield::increment( "cs_rez_out_fx", 2 );
        return;
    }
    
    self clientfield::increment( "cs_rez_out_fx", 1 );
}

// Namespace newworld_util
// Params 1
// Checksum 0xb35190fd, Offset: 0x59b0
// Size: 0x15c
function function_9ab5a5ab( var_b06baa1b )
{
    self endon( #"death" );
    
    if ( var_b06baa1b )
    {
        if ( self.animname == "hall" )
        {
            self setmodel( "c_hro_sarah_salvation_reveal" );
        }
        else if ( !( isdefined( self.isdying ) && self.isdying ) )
        {
            self setmodel( "c_hro_" + self.animname + "_base_rev" );
        }
        
        wait 0.5;
        self ghost();
        
        if ( self.animname == "hall" )
        {
            self setmodel( "c_hro_sarah_base" );
        }
        else if ( !( isdefined( self.isdying ) && self.isdying ) )
        {
            self setmodel( "c_hro_" + self.animname + "_base" );
        }
        
        return;
    }
    
    wait 0.4;
    self ghost();
}

// Namespace newworld_util
// Params 1
// Checksum 0x76f5cdc7, Offset: 0x5b18
// Size: 0x7c
function function_d0aa2f4f( n_delay )
{
    if ( !isdefined( n_delay ) )
    {
        n_delay = 0.25;
    }
    
    self endon( #"death" );
    self function_4943984c();
    wait 0.4;
    self util::delay( n_delay, undefined, &function_c949a8ed );
}

// Namespace newworld_util
// Params 2
// Checksum 0x51e91437, Offset: 0x5ba0
// Size: 0x114
function function_737d2864( str_location, str_time )
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    self endon( #"death" );
    wait 3;
    self.var_55167309 = self openluimenu( "LocationAndTime" );
    self setluimenudata( self.var_55167309, "loctime_location", str_location );
    self setluimenudata( self.var_55167309, "loctime_date", str_time );
    wait 5;
    lui::play_animation( self.var_55167309, "fadeout" );
    wait 1.3;
    self closeluimenu( self.var_55167309 );
}

// Namespace newworld_util
// Params 0
// Checksum 0x82785a1d, Offset: 0x5cc0
// Size: 0x72
function function_c633d8fe()
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return 1;
    }
    
    assert( isplayer( self ) );
    return self getdstat( "PlayerStatsByMap", "cp_mi_zurich_newworld", "hasBeenCompleted" );
}

// Namespace newworld_util
// Params 0
// Checksum 0x32b93383, Offset: 0x5d40
// Size: 0xb4
function function_81acf083()
{
    var_ed60aa22 = 1;
    
    foreach ( player in level.activeplayers )
    {
        if ( !player function_c633d8fe() )
        {
            var_ed60aa22 = 0;
            break;
        }
    }
    
    return var_ed60aa22;
}

// Namespace newworld_util
// Params 0
// Checksum 0x9b81c9ba, Offset: 0x5e00
// Size: 0xb6
function function_70aba08e()
{
    var_6a25d5b0 = 0;
    
    foreach ( player in level.players )
    {
        if ( player hascybercomability( "cybercom_hijack" ) )
        {
            var_6a25d5b0 = 1;
            break;
        }
    }
    
    return var_6a25d5b0;
}

// Namespace newworld_util
// Params 1
// Checksum 0xdef0b53a, Offset: 0x5ec0
// Size: 0x1c4
function function_3e37f48b( b_enabled )
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    level flag::wait_till( "all_players_connected" );
    
    if ( b_enabled )
    {
        foreach ( e_player in level.activeplayers )
        {
            if ( e_player function_c633d8fe() )
            {
                continue;
            }
            
            level notify( #"enable_cybercom", e_player );
        }
        
        callback::remove_on_spawned( &function_d17cfcf8 );
        return;
    }
    
    foreach ( e_player in level.activeplayers )
    {
        if ( e_player function_c633d8fe() )
        {
            continue;
        }
        
        level notify( #"disable_cybercom", e_player, 1 );
    }
    
    callback::on_spawned( &function_d17cfcf8 );
}

// Namespace newworld_util
// Params 0
// Checksum 0xba9a745e, Offset: 0x6090
// Size: 0x32
function function_d17cfcf8()
{
    if ( self function_c633d8fe() )
    {
        return;
    }
    
    level notify( #"disable_cybercom", self, 1 );
}

// Namespace newworld_util
// Params 1
// Checksum 0x1042bedc, Offset: 0x60d0
// Size: 0xaa
function function_3196eaee( b_enabled )
{
    if ( !isdefined( b_enabled ) )
    {
        b_enabled = 1;
    }
    
    foreach ( e_player in level.players )
    {
        e_player function_a7cfc593( b_enabled );
    }
}

// Namespace newworld_util
// Params 1
// Checksum 0xf524048d, Offset: 0x6188
// Size: 0xaa
function function_63c3869a( b_enabled )
{
    if ( !isdefined( b_enabled ) )
    {
        b_enabled = 1;
    }
    
    foreach ( e_player in level.players )
    {
        e_player function_ba1a260f( b_enabled );
    }
}

// Namespace newworld_util
// Params 1
// Checksum 0xbe80e3df, Offset: 0x6240
// Size: 0x64
function function_a7cfc593( b_enabled )
{
    if ( !isdefined( b_enabled ) )
    {
        b_enabled = 1;
    }
    
    if ( self function_c633d8fe() )
    {
        return;
    }
    
    self.b_tactical_mode_enabled = b_enabled;
    
    if ( !b_enabled )
    {
        self oed::tmode_activate_on_player( 0 );
    }
}

// Namespace newworld_util
// Params 1
// Checksum 0xd8691f24, Offset: 0x62b0
// Size: 0x94
function function_ba1a260f( b_enabled )
{
    if ( !isdefined( b_enabled ) )
    {
        b_enabled = 1;
    }
    
    if ( self function_c633d8fe() )
    {
        return;
    }
    
    println( "<dev string:x8a>" + b_enabled + "<dev string:xa0>" + level.b_enhanced_vision_enabled );
    self.b_enhanced_vision_enabled = b_enabled;
    
    if ( !b_enabled )
    {
        self oed::set_player_ev( 0 );
    }
}

// Namespace newworld_util
// Params 1
// Checksum 0xf4e6be0f, Offset: 0x6350
// Size: 0xd2
function function_2eded728( b_enabled )
{
    if ( !isdefined( b_enabled ) )
    {
        b_enabled = 1;
    }
    
    if ( b_enabled )
    {
        foreach ( e_player in level.activeplayers )
        {
            e_player cybercom::cybercom_armpulse( 1 );
            e_player clientfield::increment_to_player( "hack_dni_fx" );
        }
    }
}

// Namespace newworld_util
// Params 1
// Checksum 0x3267ea58, Offset: 0x6430
// Size: 0x74
function scene_cleanup( str_scene_name )
{
    if ( scene::is_active( str_scene_name ) )
    {
        scene::stop( str_scene_name, 1 );
        util::wait_network_frame();
    }
    
    struct::delete_script_bundle( "scene", str_scene_name );
}

// Namespace newworld_util
// Params 0
// Checksum 0x6b9bf419, Offset: 0x64b0
// Size: 0xa0
function function_921d7387()
{
    self endon( #"death" );
    
    while ( true )
    {
        level waittill( #"hash_921d7387" );
        
        if ( isdefined( self.var_30a16593 ) && self.var_30a16593 )
        {
            continue;
        }
        
        wait 1;
        
        if ( isdefined( self.is_talking ) && self.is_talking )
        {
            continue;
        }
        
        self notify( #"scriptedbc", "generic_encourage" );
        self.var_30a16593 = 1;
        self thread function_9464547d();
    }
}

// Namespace newworld_util
// Params 0
// Checksum 0xf8ad31e4, Offset: 0x6558
// Size: 0x20
function function_9464547d()
{
    self endon( #"death" );
    wait 30;
    self.var_30a16593 = 0;
}

// Namespace newworld_util
// Params 1
// Checksum 0xe361bee1, Offset: 0x6580
// Size: 0x52
function function_606dbca2( params )
{
    if ( self.team !== "axis" )
    {
        return;
    }
    
    if ( isplayer( params.eattacker ) )
    {
        level notify( #"hash_921d7387" );
    }
}

// Namespace newworld_util
// Params 0
// Checksum 0x81192586, Offset: 0x65e0
// Size: 0x34
function function_83a7d040()
{
    util::wait_network_frame();
    util::wait_network_frame();
    util::wait_network_frame();
}

