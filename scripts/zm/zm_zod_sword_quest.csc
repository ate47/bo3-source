#using scripts/codescripts/struct;
#using scripts/shared/animation_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace zm_zod_sword;

// Namespace zm_zod_sword
// Params 0, eflags: 0x2
// Checksum 0x73194443, Offset: 0x890
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_zod_sword", &__init__, undefined, undefined );
}

// Namespace zm_zod_sword
// Params 0
// Checksum 0x2ac8d5ee, Offset: 0x8d0
// Size: 0x662
function __init__()
{
    level._effect[ "egg_glow" ] = "zombie/fx_egg_ready_zod_zmb";
    level._effect[ "blood_soul" ] = "zombie/fx_trail_blood_soul_zmb";
    level._effect[ "sword_quest_ground_glow_white" ] = "zombie/fx_sword_quest_egg_ground_whitepedestal_zod_zmb";
    level._effect[ "sword_quest_ground_fire_white" ] = "zombie/fx_sword_quest_egg_ground_whitefire_zod_zmb";
    level._effect[ "sword_quest_sword_glow" ] = "zombie/fx_sword_quest_glow_zod_zmb";
    clientfield::register( "scriptmover", "zod_egg_glow", 1, 1, "int", &sword_egg_glow, 0, 0 );
    clientfield::register( "scriptmover", "zod_egg_soul", 1, 1, "int", &blood_soul_fx, 0, 0 );
    clientfield::register( "scriptmover", "sword_statue_glow", 1, 1, "int", &sword_statue_glow, 0, 0 );
    n_bits = getminbitcountfornum( 5 );
    clientfield::register( "toplayer", "magic_circle_state_0", 1, n_bits, "int", &function_528aad40, 0, 1 );
    clientfield::register( "toplayer", "magic_circle_state_1", 1, n_bits, "int", &function_1d308217, 0, 1 );
    clientfield::register( "toplayer", "magic_circle_state_2", 1, n_bits, "int", &function_b17464d4, 0, 1 );
    clientfield::register( "toplayer", "magic_circle_state_3", 1, n_bits, "int", &function_b6499939, 0, 1 );
    n_bits = getminbitcountfornum( 9 );
    clientfield::register( "world", "keeper_quest_state_0", 1, n_bits, "int", &function_9ba2b995, 0, 1 );
    clientfield::register( "world", "keeper_quest_state_1", 1, n_bits, "int", &function_fd8ec03a, 0, 1 );
    clientfield::register( "world", "keeper_quest_state_2", 1, n_bits, "int", &function_32002235, 0, 1 );
    clientfield::register( "world", "keeper_quest_state_3", 1, n_bits, "int", &function_4fd5e276, 0, 1 );
    n_bits = getminbitcountfornum( 4 );
    clientfield::register( "world", "keeper_egg_location_0", 1, n_bits, "int", undefined, 0, 1 );
    clientfield::register( "world", "keeper_egg_location_1", 1, n_bits, "int", undefined, 0, 1 );
    clientfield::register( "world", "keeper_egg_location_2", 1, n_bits, "int", undefined, 0, 1 );
    clientfield::register( "world", "keeper_egg_location_3", 1, n_bits, "int", undefined, 0, 1 );
    clientfield::register( "toplayer", "ZM_ZOD_UI_LVL1_SWORD_PICKUP", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1 );
    clientfield::register( "toplayer", "ZM_ZOD_UI_LVL1_EGG_PICKUP", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1 );
    clientfield::register( "toplayer", "ZM_ZOD_UI_LVL2_SWORD_PICKUP", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1 );
    clientfield::register( "toplayer", "ZM_ZOD_UI_LVL2_EGG_PICKUP", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1 );
    level.var_e91b9e85 = [];
    level.var_e91b9e85[ 0 ] = "wpn_t7_zmb_zod_sword2_box_world";
    level.var_e91b9e85[ 1 ] = "wpn_t7_zmb_zod_sword2_det_world";
    level.var_e91b9e85[ 2 ] = "wpn_t7_zmb_zod_sword2_fem_world";
    level.var_e91b9e85[ 3 ] = "wpn_t7_zmb_zod_sword2_mag_world";
}

// Namespace zm_zod_sword
// Params 3
// Checksum 0x80e9111f, Offset: 0xf40
// Size: 0x3f6
function magic_circle_state_internal( localclientnum, newval, n_current_ritual )
{
    self notify( "magic_circle_state_internal" + localclientnum );
    self endon( "magic_circle_state_internal" + localclientnum );
    s_ritual = function_5dab7fb( localclientnum, n_current_ritual );
    var_768e52e3 = undefined;
    var_5306b772 = struct::get_array( "sword_quest_magic_circle_place", "targetname" );
    
    foreach ( s_circle in var_5306b772 )
    {
        if ( s_circle.script_int === n_current_ritual )
        {
            var_768e52e3 = s_circle;
        }
    }
    
    if ( !isdefined( s_ritual.var_e2a5419e ) )
    {
        s_ritual.var_e2a5419e = [];
    }
    
    if ( !isdefined( s_ritual.var_bbf9b058 ) )
    {
        s_ritual.var_bbf9b058 = [];
    }
    
    if ( isdefined( s_ritual.var_e2a5419e[ localclientnum ] ) )
    {
        stopfx( localclientnum, s_ritual.var_e2a5419e[ localclientnum ] );
        s_ritual.var_e2a5419e[ localclientnum ] = undefined;
    }
    
    if ( isdefined( s_ritual.var_bbf9b058[ localclientnum ] ) )
    {
        stopfx( localclientnum, s_ritual.var_bbf9b058[ localclientnum ] );
        s_ritual.var_bbf9b058[ localclientnum ] = undefined;
    }
    
    switch ( newval )
    {
        case 0:
            function_cf043736( s_ritual, 0 );
            break;
        case 1:
            s_ritual.var_e2a5419e[ localclientnum ] = playfx( localclientnum, level._effect[ "sword_quest_ground_tell" ], var_768e52e3.origin );
            function_cf043736( s_ritual, 0 );
            break;
        case 2:
            s_ritual.var_e2a5419e[ localclientnum ] = playfx( localclientnum, level._effect[ "sword_quest_ground_glow" ], var_768e52e3.origin );
            function_cf043736( s_ritual, 1 );
            break;
        case 3:
            s_ritual.var_e2a5419e[ localclientnum ] = playfx( localclientnum, level._effect[ "sword_quest_ground_glow_white" ], var_768e52e3.origin );
            s_ritual.var_bbf9b058[ localclientnum ] = playfx( localclientnum, level._effect[ "sword_quest_ground_fire_white" ], var_768e52e3.origin );
            function_cf043736( s_ritual, 1 );
            break;
    }
}

// Namespace zm_zod_sword
// Params 2
// Checksum 0x79cdddde, Offset: 0x1340
// Size: 0x9c
function function_cf043736( s_ritual, var_cbdba0c5 )
{
    if ( var_cbdba0c5 )
    {
        s_ritual.var_55e0bdcf show();
        s_ritual.var_6a0d8b03 hide();
        return;
    }
    
    s_ritual.var_55e0bdcf hide();
    s_ritual.var_6a0d8b03 show();
}

#using_animtree( "generic" );

// Namespace zm_zod_sword
// Params 3
// Checksum 0x9b3a461f, Offset: 0x13e8
// Size: 0xeaa
function function_4d020922( localclientnum, newval, n_character_index )
{
    level notify( #"hash_4d020922" );
    level endon( #"hash_4d020922" );
    s_ritual = function_6890ca81( localclientnum, n_character_index );
    s_ritual.e_keeper util::waittill_dobj( localclientnum );
    
    if ( !s_ritual.e_keeper hasanimtree() )
    {
        s_ritual.e_keeper useanimtree( #animtree );
    }
    
    s_ritual.e_keeper duplicate_render::set_dr_flag( "zod_ghost", 1 );
    s_ritual.e_keeper duplicate_render::update_dr_filters( localclientnum );
    
    if ( !s_ritual.e_egg hasanimtree() )
    {
        s_ritual.e_egg useanimtree( #animtree );
    }
    
    switch ( newval )
    {
        case 0:
            s_ritual.e_keeper hide();
            s_ritual.e_sword hide();
            s_ritual.e_egg hide();
            
            if ( isdefined( s_ritual.e_keeper.sndloop ) )
            {
                s_ritual.e_keeper stoploopsound( s_ritual.e_keeper.sndloop, 1 );
            }
            
            break;
        case 1:
            v_origin = s_ritual.e_keeper gettagorigin( "tag_weapon_right" );
            v_angles = s_ritual.e_keeper gettagangles( "tag_weapon_right" );
            s_ritual.e_egg unlink();
            s_ritual.e_egg.origin = v_origin;
            s_ritual.e_egg.angles = v_angles;
            s_ritual.e_egg linkto( s_ritual.e_keeper, "tag_weapon_right" );
            s_ritual.e_keeper show();
            s_ritual.e_sword hide();
            s_ritual.e_egg show();
            level thread function_bd205438( localclientnum, s_ritual );
            s_ritual.e_keeper playsound( 0, "zmb_ee_keeper_ghost_appear" );
            
            if ( !isdefined( s_ritual.e_keeper.sndloop ) )
            {
                s_ritual.e_keeper.sndloop = s_ritual.e_keeper playloopsound( "zmb_ee_keeper_ghost_appear_lp", 2 );
            }
            
            s_ritual.e_keeper animation::play( "ai_zombie_zod_keeper_give_egg_intro", undefined, undefined, 1 );
            s_ritual.e_keeper thread function_274ba0e6( "ai_zombie_zod_keeper_give_egg_loop" );
            s_ritual.e_egg thread play_fx( localclientnum, "egg_glow" );
            break;
        case 2:
            s_ritual.e_keeper show();
            s_ritual.e_sword hide();
            s_ritual.e_egg hide();
            
            if ( !isdefined( s_ritual.e_keeper.sndloop ) )
            {
                s_ritual.e_keeper.sndloop = s_ritual.e_keeper playloopsound( "zmb_ee_keeper_ghost_appear_lp", 2 );
            }
            
            s_ritual.e_keeper notify( #"hash_274ba0e6" );
            s_ritual.e_keeper clearanim( "ai_zombie_zod_keeper_give_egg_intro", 0 );
            s_ritual.e_keeper clearanim( "ai_zombie_zod_keeper_give_egg_loop", 0 );
            s_ritual.e_keeper animation::play( "ai_zombie_zod_keeper_give_egg_outro", undefined, undefined, 1 );
            s_ritual.e_egg notify( "remove_" + "egg_glow" );
            break;
        case 3:
            s_ritual.e_keeper hide();
            s_ritual.e_sword hide();
            s_ritual.e_egg hide();
            s_ritual.e_egg notify( "remove_" + "egg_glow" );
            
            if ( isdefined( s_ritual.e_keeper.sndloop ) )
            {
                s_ritual.e_keeper stoploopsound( s_ritual.e_keeper.sndloop, 1 );
            }
            
            break;
        case 4:
            var_4d1c542 = level clientfield::get( "keeper_egg_location_" + n_character_index );
            v_origin = function_85b951d8( var_4d1c542 );
            s_ritual.e_egg unlink();
            s_ritual.e_egg.origin = v_origin;
            s_ritual.e_keeper hide();
            s_ritual.e_sword hide();
            s_ritual.e_egg show();
            
            if ( isdefined( s_ritual.e_keeper.sndloop ) )
            {
                s_ritual.e_keeper stoploopsound( s_ritual.e_keeper.sndloop, 1 );
            }
            
            s_ritual.e_egg thread play_fx( localclientnum, "egg_glow", "egg_keeper_jnt" );
            s_ritual.e_egg thread function_5b78bb9e( v_origin );
            break;
        case 5:
            s_ritual.e_keeper show();
            s_ritual.e_sword hide();
            s_ritual.e_egg hide();
            
            if ( !isdefined( s_ritual.e_keeper.sndloop ) )
            {
                s_ritual.e_keeper.sndloop = s_ritual.e_keeper playloopsound( "zmb_ee_keeper_ghost_appear_lp", 2 );
            }
            
            s_ritual.e_egg notify( "remove_" + "egg_glow" );
            break;
        case 6:
            s_ritual.e_keeper show();
            s_ritual.e_sword hide();
            s_ritual.e_egg hide();
            
            if ( !isdefined( s_ritual.e_keeper.sndloop ) )
            {
                s_ritual.e_keeper.sndloop = s_ritual.e_keeper playloopsound( "zmb_ee_keeper_ghost_appear_lp", 2 );
            }
            
            s_ritual.e_keeper animation::play( "ai_zombie_zod_keeper_give_me_sword_intro", undefined, undefined, 1 );
            s_ritual.e_keeper thread function_274ba0e6( "ai_zombie_zod_keeper_give_me_sword_loop" );
            break;
        case 7:
            v_origin = s_ritual.e_keeper gettagorigin( "tag_weapon_right" );
            v_angles = s_ritual.e_keeper gettagangles( "tag_weapon_right" );
            s_ritual.e_sword unlink();
            s_ritual.e_sword.origin = v_origin;
            s_ritual.e_sword.angles = v_angles;
            s_ritual.e_sword linkto( s_ritual.e_keeper, "tag_weapon_right" );
            s_ritual.e_keeper show();
            s_ritual.e_sword show();
            s_ritual.e_egg hide();
            
            if ( !isdefined( s_ritual.e_keeper.sndloop ) )
            {
                s_ritual.e_keeper.sndloop = s_ritual.e_keeper playloopsound( "zmb_ee_keeper_ghost_appear_lp", 2 );
            }
            
            s_ritual.e_keeper notify( #"hash_274ba0e6" );
            s_ritual.e_sword play_fx( localclientnum, "sword_quest_sword_glow", "tag_knife_fx" );
            s_ritual.e_keeper animation::play( "ai_zombie_zod_keeper_upgrade_sword", undefined, undefined, 1 );
            s_ritual.e_keeper thread function_274ba0e6( "ai_zombie_zod_keeper_give_me_sword_loop" );
            break;
        case 8:
            s_ritual.e_sword notify( "remove_" + "sword_quest_sword_glow" );
            wait 0.016;
            s_ritual.e_keeper show();
            s_ritual.e_sword hide();
            s_ritual.e_egg hide();
            
            if ( !isdefined( s_ritual.e_keeper.sndloop ) )
            {
                s_ritual.e_keeper.sndloop = s_ritual.e_keeper playloopsound( "zmb_ee_keeper_ghost_appear_lp", 2 );
            }
            
            s_ritual.e_keeper notify( #"hash_274ba0e6" );
            s_ritual.e_keeper animation::play( "ai_zombie_zod_keeper_give_me_sword_outro", undefined, undefined, 1 );
            s_ritual.e_keeper thread function_274ba0e6( "ai_zombie_zod_keeper_idle" );
            wait 2;
            s_ritual.var_5ab40ec3 = playfxontag( localclientnum, level._effect[ "keeper_spawn" ], s_ritual.e_keeper, "tag_origin" );
            wait 0.5;
            s_ritual.e_keeper hide();
            break;
    }
}

// Namespace zm_zod_sword
// Params 2
// Checksum 0xbb9f12c0, Offset: 0x22a0
// Size: 0x8c
function function_bd205438( localclientnum, s_ritual )
{
    s_ritual.var_5ab40ec3 = playfxontag( localclientnum, level._effect[ "keeper_spawn" ], s_ritual.e_keeper, "tag_origin" );
    wait 1;
    stopfx( localclientnum, s_ritual.var_5ab40ec3 );
}

// Namespace zm_zod_sword
// Params 1
// Checksum 0xd956a7ee, Offset: 0x2338
// Size: 0xac
function function_5b78bb9e( v_origin )
{
    self clearanim( "p7_fxanim_zm_zod_egg_keeper_rise_anim", 0 );
    self clearanim( "p7_fxanim_zm_zod_egg_keeper_idle_anim", 0 );
    self animation::play( "p7_fxanim_zm_zod_egg_keeper_rise_anim", v_origin, ( 0, 0, 1 ), 1 );
    self animation::play( "p7_fxanim_zm_zod_egg_keeper_idle_anim", v_origin, ( 0, 0, 1 ), 1 );
}

// Namespace zm_zod_sword
// Params 1
// Checksum 0xe4da7dd0, Offset: 0x23f0
// Size: 0x58
function function_274ba0e6( str_animname )
{
    self notify( #"hash_274ba0e6" );
    self endon( #"hash_274ba0e6" );
    
    while ( true )
    {
        self animation::play( str_animname, undefined, undefined, 1 );
    }
}

// Namespace zm_zod_sword
// Params 7
// Checksum 0x5e7eab09, Offset: 0x2450
// Size: 0x5c
function function_528aad40( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    magic_circle_state_internal( localclientnum, newval, 0 );
}

// Namespace zm_zod_sword
// Params 7
// Checksum 0x1c42a4f5, Offset: 0x24b8
// Size: 0x5c
function function_1d308217( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    magic_circle_state_internal( localclientnum, newval, 1 );
}

// Namespace zm_zod_sword
// Params 7
// Checksum 0xb9894bd8, Offset: 0x2520
// Size: 0x5c
function function_b17464d4( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    magic_circle_state_internal( localclientnum, newval, 2 );
}

// Namespace zm_zod_sword
// Params 7
// Checksum 0x7b63602e, Offset: 0x2588
// Size: 0x5c
function function_b6499939( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    magic_circle_state_internal( localclientnum, newval, 3 );
}

// Namespace zm_zod_sword
// Params 7
// Checksum 0xaea98577, Offset: 0x25f0
// Size: 0x5c
function function_9ba2b995( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    function_4d020922( localclientnum, newval, 0 );
}

// Namespace zm_zod_sword
// Params 7
// Checksum 0x6a865ee6, Offset: 0x2658
// Size: 0x5c
function function_fd8ec03a( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    function_4d020922( localclientnum, newval, 1 );
}

// Namespace zm_zod_sword
// Params 7
// Checksum 0x9bcbc289, Offset: 0x26c0
// Size: 0x5c
function function_32002235( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    function_4d020922( localclientnum, newval, 2 );
}

// Namespace zm_zod_sword
// Params 7
// Checksum 0x98c846a0, Offset: 0x2728
// Size: 0x5c
function function_4fd5e276( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    function_4d020922( localclientnum, newval, 3 );
}

// Namespace zm_zod_sword
// Params 2
// Checksum 0xd8c85672, Offset: 0x2790
// Size: 0xb4
function function_5dab7fb( localclientnum, n_current_ritual )
{
    if ( !isdefined( level.sword_quest ) )
    {
        level.sword_quest = [];
    }
    
    if ( !isdefined( level.sword_quest[ localclientnum ] ) )
    {
        level.sword_quest[ localclientnum ] = [];
    }
    
    if ( !isdefined( level.sword_quest[ localclientnum ][ n_current_ritual ] ) )
    {
        level.sword_quest[ localclientnum ][ n_current_ritual ] = spawnstruct();
    }
    
    s_ritual = level.sword_quest[ localclientnum ][ n_current_ritual ];
    return s_ritual;
}

// Namespace zm_zod_sword
// Params 2
// Checksum 0x7380d20b, Offset: 0x2850
// Size: 0x3d0
function function_6890ca81( localclientnum, n_character_index )
{
    s_loc = struct::get( "keeper_spirit_" + n_character_index, "targetname" );
    s_ritual = function_5dab7fb( localclientnum, n_character_index );
    
    if ( !isdefined( s_ritual.e_keeper ) )
    {
        s_ritual.e_keeper = spawn( localclientnum, s_loc.origin, "script_model" );
        s_ritual.e_keeper.angles = s_loc.angles;
        s_ritual.e_keeper setmodel( "c_zom_zod_keeper_fb" );
    }
    
    if ( !isdefined( s_ritual.e_sword ) )
    {
        s_ritual.e_sword = spawn( localclientnum, s_loc.origin, "script_model" );
        s_ritual.e_sword setmodel( level.var_e91b9e85[ n_character_index ] );
    }
    
    if ( !isdefined( s_ritual.e_egg ) )
    {
        s_ritual.e_egg = spawn( localclientnum, s_loc.origin, "script_model" );
        s_ritual.e_egg setmodel( "zm_zod_sword_egg_keeper_s1" );
    }
    
    if ( !isdefined( s_ritual.var_55e0bdcf ) )
    {
        a_circles = getentarray( localclientnum, "sword_quest_magic_circle_on", "targetname" );
        var_55e0bdcf = undefined;
        
        foreach ( e_circle in a_circles )
        {
            if ( e_circle.script_int === n_character_index )
            {
                var_55e0bdcf = e_circle;
            }
        }
        
        s_ritual.var_55e0bdcf = var_55e0bdcf;
    }
    
    if ( !isdefined( s_ritual.var_6a0d8b03 ) )
    {
        a_circles = getentarray( localclientnum, "sword_quest_magic_circle_off", "targetname" );
        var_6a0d8b03 = undefined;
        
        foreach ( e_circle in a_circles )
        {
            if ( e_circle.script_int === n_character_index )
            {
                var_6a0d8b03 = e_circle;
            }
        }
        
        s_ritual.var_6a0d8b03 = var_6a0d8b03;
    }
    
    return s_ritual;
}

// Namespace zm_zod_sword
// Params 1
// Checksum 0x719a89eb, Offset: 0x2c28
// Size: 0x5e
function get_name_from_ritual_clientfield_value( n_current_ritual )
{
    switch ( n_current_ritual )
    {
        case 1:
            return "boxer";
        case 2:
            return "detective";
        case 3:
            return "femme";
        case 4:
            return "magician";
    }
}

// Namespace zm_zod_sword
// Params 1
// Checksum 0x43595057, Offset: 0x2c90
// Size: 0xce
function function_85b951d8( var_181b74a5 )
{
    a_s_circles = struct::get_array( "sword_quest_magic_circle_place", "targetname" );
    
    foreach ( s_circle in a_s_circles )
    {
        if ( s_circle.script_int === var_181b74a5 )
        {
            return s_circle.origin;
        }
    }
}

// Namespace zm_zod_sword
// Params 2
// Checksum 0xf4556cb3, Offset: 0x2d68
// Size: 0xd4
function function_96ae1a10( var_181b74a5, n_character_index )
{
    a_s_circles = struct::get_array( "sword_quest_magic_circle_player_" + n_character_index, "targetname" );
    
    foreach ( s_circle in a_s_circles )
    {
        if ( s_circle.script_int === var_181b74a5 )
        {
            return s_circle;
        }
    }
}

// Namespace zm_zod_sword
// Params 3
// Checksum 0xe937124, Offset: 0x2e48
// Size: 0xcc
function play_fx( localclientnum, str_fx, str_tag )
{
    fx = undefined;
    
    if ( isdefined( str_tag ) )
    {
        fx = playfxontag( localclientnum, level._effect[ str_fx ], self, str_tag );
    }
    else
    {
        fx = playfx( localclientnum, level._effect[ str_fx ], self.origin );
    }
    
    self waittill( "remove_" + str_fx );
    stopfx( localclientnum, fx );
}

// Namespace zm_zod_sword
// Params 7
// Checksum 0x91987208, Offset: 0x2f20
// Size: 0x88
function sword_statue_glow( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self thread play_fx( localclientnum, "sword_quest_sword_glow", "tag_knife_fx" );
        return;
    }
    
    self notify( "remove_" + "sword_quest_sword_glow" );
}

// Namespace zm_zod_sword
// Params 7
// Checksum 0xd8c0c34d, Offset: 0x2fb0
// Size: 0x80
function sword_egg_glow( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self thread play_fx( localclientnum, "egg_glow" );
        return;
    }
    
    self notify( "remove_" + "egg_glow" );
}

// Namespace zm_zod_sword
// Params 7
// Checksum 0x37ccdec7, Offset: 0x3038
// Size: 0x7e
function blood_soul_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self thread play_fx( localclientnum, "blood_soul", "tag_origin" );
        return;
    }
    
    self notify( #"remove_blood_soul" );
}

