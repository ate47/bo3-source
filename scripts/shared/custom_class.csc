#using scripts/codescripts/struct;
#using scripts/core/_multi_extracam;
#using scripts/shared/_character_customization;
#using scripts/shared/ai/archetype_damage_effects;
#using scripts/shared/ai/systems/destructible_character;
#using scripts/shared/ai/zombie;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/exploder_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/util_shared;

#namespace customclass;

// Namespace customclass
// Params 1
// Checksum 0x720b1a9b, Offset: 0x580
// Size: 0x24
function localclientconnect( localclientnum )
{
    level thread custom_class_init( localclientnum );
}

// Namespace customclass
// Params 0
// Checksum 0xc0e6b4e0, Offset: 0x5b0
// Size: 0x124
function init()
{
    level.weapon_script_model = [];
    level.preload_weapon_model = [];
    level.last_weapon_name = [];
    level.current_weapon = [];
    level.attachment_names = [];
    level.attachment_indices = [];
    level.paintshophiddenposition = [];
    level.camo_index = [];
    level.reticle_index = [];
    level.show_player_tag = [];
    level.show_emblem = [];
    level.preload_weapon_complete = [];
    level.preload_weapon_complete = [];
    level.weapon_clientscript_cac_model = [];
    level.weaponnone = getweapon( "none" );
    level.weapon_position = struct::get( "paintshop_weapon_position" );
    duplicate_render::set_dr_filter_offscreen( "cac_locked_weapon", 10, "cac_locked_weapon", undefined, 2, "mc/sonar_frontend_locked_gun", 1 );
}

// Namespace customclass
// Params 1
// Checksum 0xf40860b7, Offset: 0x6e0
// Size: 0x64
function custom_class_init( localclientnum )
{
    level.last_weapon_name[ localclientnum ] = "";
    level.current_weapon[ localclientnum ] = undefined;
    level thread custom_class_start_threads( localclientnum );
    level thread handle_cac_customization( localclientnum );
}

// Namespace customclass
// Params 1
// Checksum 0x49b34392, Offset: 0x750
// Size: 0xc8
function custom_class_start_threads( localclientnum )
{
    level endon( #"disconnect" );
    
    while ( true )
    {
        level thread custom_class_update( localclientnum );
        level thread custom_class_attachment_select_focus( localclientnum );
        level thread custom_class_remove( localclientnum );
        level thread custom_class_closed( localclientnum );
        level util::waittill_any( "CustomClass_update" + localclientnum, "CustomClass_focus" + localclientnum, "CustomClass_remove" + localclientnum, "CustomClass_closed" + localclientnum );
    }
}

// Namespace customclass
// Params 1
// Checksum 0xe39064d7, Offset: 0x820
// Size: 0xba
function handle_cac_customization( localclientnum )
{
    level endon( #"disconnect" );
    self.lastxcam = [];
    self.lastsubxcam = [];
    self.lastnotetrack = [];
    
    while ( true )
    {
        level thread handle_cac_customization_focus( localclientnum );
        level thread handle_cac_customization_weaponoption( localclientnum );
        level thread handle_cac_customization_attachmentvariant( localclientnum );
        level thread handle_cac_customization_closed( localclientnum );
        level waittill( "cam_customization_closed" + localclientnum );
    }
}

// Namespace customclass
// Params 1
// Checksum 0x21da7034, Offset: 0x8e8
// Size: 0x3d4
function custom_class_update( localclientnum )
{
    level endon( #"disconnect" );
    level endon( "CustomClass_focus" + localclientnum );
    level endon( "CustomClass_remove" + localclientnum );
    level endon( "CustomClass_closed" + localclientnum );
    level waittill( "CustomClass_update" + localclientnum, param1, param2, param3, param4, param5, param6, param7 );
    base_weapon_slot = param1;
    weapon_full_name = param2;
    camera = param3;
    weapon_options_param = param4;
    acv_param = param5;
    is_item_unlocked = param6;
    is_item_tokenlocked = param7;
    
    if ( !isdefined( is_item_unlocked ) )
    {
        is_item_unlocked = 1;
    }
    
    if ( !isdefined( is_item_tokenlocked ) )
    {
        is_item_tokenlocked = 0;
    }
    
    if ( isdefined( weapon_full_name ) )
    {
        if ( isdefined( acv_param ) && acv_param != "none" )
        {
            set_attachment_cosmetic_variants( localclientnum, acv_param );
        }
        
        if ( isdefined( weapon_options_param ) && weapon_options_param != "none" )
        {
            set_weapon_options( localclientnum, weapon_options_param );
        }
        
        postfx::setfrontendstreamingoverlay( localclientnum, "cac", 1 );
        position = level.weapon_position;
        
        if ( !isdefined( level.weapon_script_model[ localclientnum ] ) )
        {
            level.weapon_script_model[ localclientnum ] = spawn_weapon_model( localclientnum, position.origin, position.angles );
            level.preload_weapon_model[ localclientnum ] = spawn_weapon_model( localclientnum, position.origin, position.angles );
            level.preload_weapon_model[ localclientnum ] hide();
        }
        
        toggle_locked_weapon_shader( localclientnum, is_item_unlocked );
        toggle_tokenlocked_weapon_shader( localclientnum, is_item_unlocked && is_item_tokenlocked );
        update_weapon_script_model( localclientnum, weapon_full_name, undefined, is_item_unlocked, is_item_tokenlocked );
        level notify( #"xcammoved" );
        lerpduration = get_lerp_duration( camera );
        setup_paintshop_bg( localclientnum, camera );
        level transition_camera_immediate( localclientnum, base_weapon_slot, "cam_cac_weapon", "cam_cac", lerpduration, camera );
        return;
    }
    
    if ( isdefined( param1 ) && param1 == "purchased" )
    {
        toggle_tokenlocked_weapon_shader( localclientnum, 0 );
    }
}

// Namespace customclass
// Params 2
// Checksum 0xd0f575e7, Offset: 0xcc8
// Size: 0x84
function toggle_locked_weapon_shader( localclientnum, is_item_unlocked )
{
    if ( !isdefined( is_item_unlocked ) )
    {
        is_item_unlocked = 1;
    }
    
    if ( !isdefined( level.weapon_script_model[ localclientnum ] ) )
    {
        return;
    }
    
    if ( is_item_unlocked != 1 )
    {
        enablefrontendlockedweaponoverlay( localclientnum, 1 );
        return;
    }
    
    enablefrontendlockedweaponoverlay( localclientnum, 0 );
}

// Namespace customclass
// Params 2
// Checksum 0x788404d1, Offset: 0xd58
// Size: 0x7c
function toggle_tokenlocked_weapon_shader( localclientnum, is_item_tokenlocked )
{
    if ( !isdefined( is_item_tokenlocked ) )
    {
        is_item_tokenlocked = 0;
    }
    
    if ( !isdefined( level.weapon_script_model[ localclientnum ] ) )
    {
        return;
    }
    
    if ( is_item_tokenlocked )
    {
        enablefrontendtokenlockedweaponoverlay( localclientnum, 1 );
        return;
    }
    
    enablefrontendtokenlockedweaponoverlay( localclientnum, 0 );
}

// Namespace customclass
// Params 1
// Checksum 0xe5f0dfef, Offset: 0xde0
// Size: 0x90, Type: bool
function is_optic( attachmentname )
{
    csv_filename = "gamedata/weapons/common/attachmentTable.csv";
    row = tablelookuprownum( csv_filename, 4, attachmentname );
    
    if ( row > -1 )
    {
        group = tablelookupcolumnforrow( csv_filename, row, 2 );
        return ( group == "optic" );
    }
    
    return false;
}

// Namespace customclass
// Params 1
// Checksum 0xa8a0cde6, Offset: 0xe78
// Size: 0x344
function custom_class_attachment_select_focus( localclientnum )
{
    level endon( #"disconnect" );
    level endon( "CustomClass_update" + localclientnum );
    level endon( "CustomClass_remove" + localclientnum );
    level endon( "CustomClass_closed" + localclientnum );
    level waittill( "CustomClass_focus" + localclientnum, param1, param2, param3, param4, param5, param6 );
    level endon( "CustomClass_focus" + localclientnum );
    base_weapon_slot = param1;
    weapon_full_name = param2;
    attachment = param3;
    weapon_options_param = param4;
    acv_param = param5;
    donotmovecamera = param6;
    update_weapon_options = 0;
    weaponattachmentintersection = get_attachments_intersection( level.last_weapon_name[ localclientnum ], weapon_full_name );
    
    if ( isdefined( acv_param ) && acv_param != "none" )
    {
        set_attachment_cosmetic_variants( localclientnum, acv_param );
    }
    
    initialdelay = 0.3;
    lerpduration = 400;
    
    if ( is_optic( attachment ) )
    {
        initialdelay = 0;
        lerpduration = 200;
    }
    
    preload_weapon_model( localclientnum, weaponattachmentintersection, update_weapon_options );
    wait_preload_weapon( localclientnum );
    update_weapon_script_model( localclientnum, weaponattachmentintersection, update_weapon_options );
    
    if ( weapon_full_name == weaponattachmentintersection )
    {
        weapon_full_name = undefined;
    }
    
    if ( isdefined( donotmovecamera ) && donotmovecamera )
    {
        if ( isdefined( weapon_full_name ) )
        {
            preload_weapon_model( localclientnum, weapon_full_name, 0 );
            wait initialdelay;
            wait_preload_weapon( localclientnum );
            update_weapon_script_model( localclientnum, weapon_full_name, 0 );
        }
    }
    else
    {
        level thread transition_camera( localclientnum, base_weapon_slot, "cam_cac_attachments", "cam_cac", initialdelay, lerpduration, attachment, weapon_full_name );
    }
    
    if ( isdefined( weapon_options_param ) && weapon_options_param != "none" )
    {
        set_weapon_options( localclientnum, weapon_options_param );
    }
}

// Namespace customclass
// Params 1
// Checksum 0xbee02904, Offset: 0x11c8
// Size: 0x1d2
function custom_class_remove( localclientnum )
{
    level endon( #"disconnect" );
    level endon( "CustomClass_update" + localclientnum );
    level endon( "CustomClass_focus" + localclientnum );
    level endon( "CustomClass_closed" + localclientnum );
    level waittill( "CustomClass_remove" + localclientnum, param1, param2, param3, param4, param5, param6 );
    postfx::setfrontendstreamingoverlay( localclientnum, "cac", 0 );
    enablefrontendlockedweaponoverlay( localclientnum, 0 );
    enablefrontendtokenlockedweaponoverlay( localclientnum, 0 );
    position = level.weapon_position;
    camera = "select01";
    xcamname = "ui_cam_cac_ar_standard";
    playmaincamxcam( localclientnum, xcamname, 0, "cam_cac", camera, position.origin, position.angles );
    setup_paintshop_bg( localclientnum, camera );
    
    if ( isdefined( level.weapon_script_model[ localclientnum ] ) )
    {
        level.weapon_script_model[ localclientnum ] forcedelete();
    }
    
    level.last_weapon_name[ localclientnum ] = "";
}

// Namespace customclass
// Params 1
// Checksum 0xfd2074fd, Offset: 0x13a8
// Size: 0x13a
function custom_class_closed( localclientnum )
{
    level endon( #"disconnect" );
    level endon( "CustomClass_update" + localclientnum );
    level endon( "CustomClass_focus" + localclientnum );
    level endon( "CustomClass_remove" + localclientnum );
    level waittill( "CustomClass_closed" + localclientnum, param1, param2, param3, param4, param5, param6 );
    
    if ( isdefined( level.weapon_script_model[ localclientnum ] ) )
    {
        level.weapon_script_model[ localclientnum ] forcedelete();
    }
    
    postfx::setfrontendstreamingoverlay( localclientnum, "cac", 0 );
    enablefrontendlockedweaponoverlay( localclientnum, 0 );
    enablefrontendtokenlockedweaponoverlay( localclientnum, 0 );
    level.last_weapon_name[ localclientnum ] = "";
}

// Namespace customclass
// Params 3
// Checksum 0x10703eb, Offset: 0x14f0
// Size: 0x84
function spawn_weapon_model( localclientnum, origin, angles )
{
    weapon_model = spawn( localclientnum, origin, "script_model" );
    weapon_model sethighdetail( 1, 1 );
    
    if ( isdefined( angles ) )
    {
        weapon_model.angles = angles;
    }
    
    return weapon_model;
}

// Namespace customclass
// Params 2
// Checksum 0xe1ffd642, Offset: 0x1580
// Size: 0x108
function set_attachment_cosmetic_variants( localclientnum, acv_param )
{
    acv_indexes = strtok( acv_param, "," );
    level.attachment_names[ localclientnum ] = [];
    level.attachment_indices[ localclientnum ] = [];
    i = 0;
    
    while ( i + 1 < acv_indexes.size )
    {
        level.attachment_names[ localclientnum ][ level.attachment_names[ localclientnum ].size ] = acv_indexes[ i ];
        level.attachment_indices[ localclientnum ][ level.attachment_indices[ localclientnum ].size ] = int( acv_indexes[ i + 1 ] );
        i += 2;
    }
}

// Namespace customclass
// Params 1
// Checksum 0xdc31e644, Offset: 0x1690
// Size: 0xc4
function hide_paintshop_bg( localclientnum )
{
    paintshop_bg = getent( localclientnum, "paintshop_black", "targetname" );
    
    if ( isdefined( paintshop_bg ) )
    {
        if ( !isdefined( level.paintshophiddenposition[ localclientnum ] ) )
        {
            level.paintshophiddenposition[ localclientnum ] = paintshop_bg.origin;
        }
        
        paintshop_bg hide();
        paintshop_bg moveto( level.paintshophiddenposition[ localclientnum ], 0.01 );
    }
}

// Namespace customclass
// Params 1
// Checksum 0x874c035d, Offset: 0x1760
// Size: 0x9c
function show_paintshop_bg( localclientnum )
{
    paintshop_bg = getent( localclientnum, "paintshop_black", "targetname" );
    
    if ( isdefined( paintshop_bg ) )
    {
        paintshop_bg show();
        paintshop_bg moveto( level.paintshophiddenposition[ localclientnum ] + ( 0, 0, 227 ), 0.01 );
    }
}

// Namespace customclass
// Params 1
// Checksum 0x2f6a6b82, Offset: 0x1808
// Size: 0x3c
function get_camo_index( localclientnum )
{
    if ( !isdefined( level.camo_index[ localclientnum ] ) )
    {
        level.camo_index[ localclientnum ] = 0;
    }
    
    return level.camo_index[ localclientnum ];
}

// Namespace customclass
// Params 1
// Checksum 0x267c934e, Offset: 0x1850
// Size: 0x3c
function get_reticle_index( localclientnum )
{
    if ( !isdefined( level.reticle_index[ localclientnum ] ) )
    {
        level.reticle_index[ localclientnum ] = 0;
    }
    
    return level.reticle_index[ localclientnum ];
}

// Namespace customclass
// Params 1
// Checksum 0x3edcf972, Offset: 0x1898
// Size: 0x3c
function get_show_payer_tag( localclientnum )
{
    if ( !isdefined( level.show_player_tag[ localclientnum ] ) )
    {
        level.show_player_tag[ localclientnum ] = 0;
    }
    
    return level.show_player_tag[ localclientnum ];
}

// Namespace customclass
// Params 1
// Checksum 0x5da5de55, Offset: 0x18e0
// Size: 0x3c
function get_show_emblem( localclientnum )
{
    if ( !isdefined( level.show_emblem[ localclientnum ] ) )
    {
        level.show_emblem[ localclientnum ] = 0;
    }
    
    return level.show_emblem[ localclientnum ];
}

// Namespace customclass
// Params 1
// Checksum 0x64337382, Offset: 0x1928
// Size: 0x3c
function get_show_paintshop( localclientnum )
{
    if ( !isdefined( level.show_paintshop[ localclientnum ] ) )
    {
        level.show_paintshop[ localclientnum ] = 0;
    }
    
    return level.show_paintshop[ localclientnum ];
}

// Namespace customclass
// Params 2
// Checksum 0x3ac6ad71, Offset: 0x1970
// Size: 0x18c
function set_weapon_options( localclientnum, weapon_options_param )
{
    weapon_options = strtok( weapon_options_param, "," );
    level.camo_index[ localclientnum ] = int( weapon_options[ 0 ] );
    level.show_player_tag[ localclientnum ] = 0;
    level.show_emblem[ localclientnum ] = 0;
    level.reticle_index[ localclientnum ] = int( weapon_options[ 1 ] );
    level.show_paintshop[ localclientnum ] = int( weapon_options[ 2 ] );
    
    if ( isdefined( weapon_options ) && isdefined( level.weapon_script_model[ localclientnum ] ) )
    {
        level.weapon_script_model[ localclientnum ] setweaponrenderoptions( get_camo_index( localclientnum ), get_reticle_index( localclientnum ), get_show_payer_tag( localclientnum ), get_show_emblem( localclientnum ), get_show_paintshop( localclientnum ) );
    }
}

// Namespace customclass
// Params 1
// Checksum 0xc619cede, Offset: 0x1b08
// Size: 0xa8
function get_lerp_duration( camera )
{
    lerpduration = 0;
    
    if ( isdefined( camera ) )
    {
        paintshopcameracloseup = camera == "left" || camera == "right" || camera == "top" || camera == "paintshop_preview_left" || camera == "paintshop_preview_right" || camera == "paintshop_preview_top";
        
        if ( paintshopcameracloseup )
        {
            lerpduration = 500;
        }
    }
    
    return lerpduration;
}

// Namespace customclass
// Params 2
// Checksum 0x46b16b5, Offset: 0x1bb8
// Size: 0x19c
function setup_paintshop_bg( localclientnum, camera )
{
    if ( isdefined( camera ) )
    {
        paintshopcameracloseup = camera == "left" || camera == "right" || camera == "top" || camera == "paintshop_preview_left" || camera == "paintshop_preview_right" || camera == "paintshop_preview_top";
        playradiantexploder( localclientnum, "weapon_kick" );
        
        if ( paintshopcameracloseup )
        {
            show_paintshop_bg( localclientnum );
            killradiantexploder( localclientnum, "lights_paintshop" );
            killradiantexploder( localclientnum, "weapon_kick" );
            playradiantexploder( localclientnum, "lights_paintshop_zoom" );
            return;
        }
        
        hide_paintshop_bg( localclientnum );
        killradiantexploder( localclientnum, "lights_paintshop_zoom" );
        playradiantexploder( localclientnum, "lights_paintshop" );
        playradiantexploder( localclientnum, "weapon_kick" );
    }
}

// Namespace customclass
// Params 6
// Checksum 0x8471ad4a, Offset: 0x1d60
// Size: 0x28c
function transition_camera_immediate( localclientnum, weapontype, camera, subxcam, lerpduration, notetrack )
{
    xcam = getweaponxcam( level.current_weapon[ localclientnum ], camera );
    
    if ( !isdefined( xcam ) )
    {
        if ( strstartswith( weapontype, "specialty" ) )
        {
            xcam = "ui_cam_cac_perk";
        }
        else if ( strstartswith( weapontype, "bonuscard" ) )
        {
            xcam = "ui_cam_cac_wildcard";
        }
        else if ( strstartswith( weapontype, "cybercore" ) || strstartswith( weapontype, "cybercom" ) )
        {
            xcam = "ui_cam_cac_perk";
        }
        else if ( strstartswith( weapontype, "bubblegum" ) )
        {
            xcam = "ui_cam_cac_bgb";
        }
        else
        {
            xcam = getweaponxcam( getweapon( "ar_standard" ), camera );
        }
    }
    
    self.lastxcam[ weapontype ] = xcam;
    self.lastsubxcam[ weapontype ] = subxcam;
    self.lastnotetrack[ weapontype ] = notetrack;
    position = level.weapon_position;
    model = level.weapon_script_model[ localclientnum ];
    playmaincamxcam( localclientnum, xcam, lerpduration, subxcam, notetrack, position.origin, position.angles, model, position.origin, position.angles );
    
    if ( notetrack == "top" || notetrack == "right" || notetrack == "left" )
    {
        setallowxcamrightstickrotation( localclientnum, 0 );
    }
}

// Namespace customclass
// Params 1
// Checksum 0x52802b2a, Offset: 0x1ff8
// Size: 0x32
function wait_preload_weapon( localclientnum )
{
    if ( level.preload_weapon_complete[ localclientnum ] )
    {
        return;
    }
    
    level waittill( "preload_weapon_complete_" + localclientnum );
}

// Namespace customclass
// Params 1
// Checksum 0x77c385eb, Offset: 0x2038
// Size: 0x8c
function preload_weapon_watcher( localclientnum )
{
    level endon( "preload_weapon_changing_" + localclientnum );
    level endon( "preload_weapon_complete_" + localclientnum );
    
    while ( true )
    {
        if ( level.preload_weapon_model[ localclientnum ] isstreamed() )
        {
            level.preload_weapon_complete[ localclientnum ] = 1;
            level notify( "preload_weapon_complete_" + localclientnum );
            return;
        }
        
        wait 0.1;
    }
}

// Namespace customclass
// Params 3
// Checksum 0x31d5848f, Offset: 0x20d0
// Size: 0x2fc
function preload_weapon_model( localclientnum, newweaponstring, should_update_weapon_options )
{
    if ( !isdefined( should_update_weapon_options ) )
    {
        should_update_weapon_options = 1;
    }
    
    level notify( "preload_weapon_changing_" + localclientnum );
    level.preload_weapon_complete[ localclientnum ] = 0;
    current_weapon = getweaponwithattachments( newweaponstring );
    
    if ( current_weapon == level.weaponnone )
    {
        level.preload_weapon_complete[ localclientnum ] = 1;
        level notify( "preload_weapon_complete_" + localclientnum );
        return;
    }
    
    if ( isdefined( current_weapon.frontendmodel ) )
    {
        println( "<dev string:x28>" + current_weapon.name + "<dev string:x50>" + current_weapon.frontendmodel );
        level.preload_weapon_model[ localclientnum ] useweaponmodel( current_weapon, current_weapon.frontendmodel );
    }
    else
    {
        println( "<dev string:x28>" + current_weapon.name );
        level.preload_weapon_model[ localclientnum ] useweaponmodel( current_weapon );
    }
    
    if ( isdefined( level.preload_weapon_model[ localclientnum ] ) )
    {
        if ( isdefined( level.attachment_names[ localclientnum ] ) && isdefined( level.attachment_indices[ localclientnum ] ) )
        {
            for ( i = 0; i < level.attachment_names[ localclientnum ].size ; i++ )
            {
                level.preload_weapon_model[ localclientnum ] setattachmentcosmeticvariantindex( newweaponstring, level.attachment_names[ localclientnum ][ i ], level.attachment_indices[ localclientnum ][ i ] );
            }
        }
        
        if ( should_update_weapon_options )
        {
            level.preload_weapon_model[ localclientnum ] setweaponrenderoptions( get_camo_index( localclientnum ), get_reticle_index( localclientnum ), get_show_payer_tag( localclientnum ), get_show_emblem( localclientnum ), get_show_paintshop( localclientnum ) );
        }
    }
    
    level thread preload_weapon_watcher( localclientnum );
}

// Namespace customclass
// Params 5
// Checksum 0x6839cd58, Offset: 0x23d8
// Size: 0x474
function update_weapon_script_model( localclientnum, newweaponstring, should_update_weapon_options, is_item_unlocked, is_item_tokenlocked )
{
    if ( !isdefined( should_update_weapon_options ) )
    {
        should_update_weapon_options = 1;
    }
    
    if ( !isdefined( is_item_unlocked ) )
    {
        is_item_unlocked = 1;
    }
    
    if ( !isdefined( is_item_tokenlocked ) )
    {
        is_item_tokenlocked = 0;
    }
    
    level.last_weapon_name[ localclientnum ] = newweaponstring;
    level.current_weapon[ localclientnum ] = getweaponwithattachments( level.last_weapon_name[ localclientnum ] );
    
    if ( level.current_weapon[ localclientnum ] == level.weaponnone )
    {
        level.weapon_script_model[ localclientnum ] delete();
        position = level.weapon_position;
        level.weapon_script_model[ localclientnum ] = spawn_weapon_model( localclientnum, position.origin, position.angles );
        toggle_locked_weapon_shader( localclientnum, is_item_unlocked );
        toggle_tokenlocked_weapon_shader( localclientnum, is_item_unlocked && is_item_tokenlocked );
        level.weapon_script_model[ localclientnum ] setmodel( level.last_weapon_name[ localclientnum ] );
        level.weapon_script_model[ localclientnum ] setdedicatedshadow( 1 );
        return;
    }
    
    if ( isdefined( level.current_weapon[ localclientnum ].frontendmodel ) )
    {
        println( "<dev string:x63>" + level.current_weapon[ localclientnum ].name + "<dev string:x50>" + level.current_weapon[ localclientnum ].frontendmodel );
        level.weapon_script_model[ localclientnum ] useweaponmodel( level.current_weapon[ localclientnum ], level.current_weapon[ localclientnum ].frontendmodel );
    }
    else
    {
        println( "<dev string:x63>" + level.current_weapon[ localclientnum ].name );
        level.weapon_script_model[ localclientnum ] useweaponmodel( level.current_weapon[ localclientnum ] );
    }
    
    if ( isdefined( level.weapon_script_model[ localclientnum ] ) )
    {
        if ( isdefined( level.attachment_names[ localclientnum ] ) && isdefined( level.attachment_indices[ localclientnum ] ) )
        {
            for ( i = 0; i < level.attachment_names[ localclientnum ].size ; i++ )
            {
                level.weapon_script_model[ localclientnum ] setattachmentcosmeticvariantindex( newweaponstring, level.attachment_names[ localclientnum ][ i ], level.attachment_indices[ localclientnum ][ i ] );
            }
        }
        
        if ( should_update_weapon_options )
        {
            level.weapon_script_model[ localclientnum ] setweaponrenderoptions( get_camo_index( localclientnum ), get_reticle_index( localclientnum ), get_show_payer_tag( localclientnum ), get_show_emblem( localclientnum ), get_show_paintshop( localclientnum ) );
        }
    }
    
    level.weapon_script_model[ localclientnum ] setdedicatedshadow( 1 );
}

// Namespace customclass
// Params 9
// Checksum 0x8f7111f6, Offset: 0x2858
// Size: 0x134
function transition_camera( localclientnum, weapontype, camera, subxcam, initialdelay, lerpduration, notetrack, newweaponstring, should_update_weapon_options )
{
    if ( !isdefined( should_update_weapon_options ) )
    {
        should_update_weapon_options = 0;
    }
    
    self endon( #"entityshutdown" );
    self notify( #"xcammoved" );
    self endon( #"xcammoved" );
    level endon( #"cam_customization_closed" );
    
    if ( isdefined( newweaponstring ) )
    {
        preload_weapon_model( localclientnum, newweaponstring, should_update_weapon_options );
    }
    
    wait initialdelay;
    transition_camera_immediate( localclientnum, weapontype, camera, subxcam, lerpduration, notetrack );
    
    if ( isdefined( newweaponstring ) )
    {
        wait lerpduration / 1000;
        wait_preload_weapon( localclientnum );
        update_weapon_script_model( localclientnum, newweaponstring, should_update_weapon_options );
    }
}

// Namespace customclass
// Params 2
// Checksum 0x67ee54fe, Offset: 0x2998
// Size: 0x11c
function get_attachments_intersection( oldweapon, newweapon )
{
    if ( !isdefined( oldweapon ) )
    {
        return newweapon;
    }
    
    oldweaponparams = strtok( oldweapon, "+" );
    newweaponparams = strtok( newweapon, "+" );
    
    if ( oldweaponparams[ 0 ] != newweaponparams[ 0 ] )
    {
        return newweapon;
    }
    
    newweaponstring = newweaponparams[ 0 ];
    
    for ( i = 1; i < newweaponparams.size ; i++ )
    {
        if ( isinarray( oldweaponparams, newweaponparams[ i ] ) )
        {
            newweaponstring += "+" + newweaponparams[ i ];
        }
    }
    
    return newweaponstring;
}

// Namespace customclass
// Params 1
// Checksum 0xb020740c, Offset: 0x2ac0
// Size: 0xf8
function handle_cac_customization_focus( localclientnum )
{
    level endon( #"disconnect" );
    level endon( "cam_customization_closed" + localclientnum );
    
    while ( true )
    {
        level waittill( "cam_customization_focus" + localclientnum, param1, param2 );
        base_weapon_slot = param1;
        notetrack = param2;
        
        if ( isdefined( level.weapon_script_model[ localclientnum ] ) )
        {
            should_update_weapon_options = 1;
            level thread transition_camera( localclientnum, base_weapon_slot, "cam_cac_weapon", "cam_cac", 0.3, 400, notetrack, level.last_weapon_name[ localclientnum ], should_update_weapon_options );
        }
    }
}

// Namespace customclass
// Params 1
// Checksum 0xd32c4744, Offset: 0x2bc0
// Size: 0x1e0
function handle_cac_customization_weaponoption( localclientnum )
{
    level endon( #"disconnect" );
    level endon( "cam_customization_closed" + localclientnum );
    
    while ( true )
    {
        level waittill( "cam_customization_wo" + localclientnum, weapon_option, weapon_option_new_index, is_item_locked );
        
        if ( isdefined( level.weapon_script_model[ localclientnum ] ) )
        {
            if ( isdefined( is_item_locked ) && is_item_locked )
            {
                weapon_option_new_index = 0;
            }
            
            switch ( weapon_option )
            {
                case "camo":
                    level.camo_index[ localclientnum ] = int( weapon_option_new_index );
                    break;
                case "reticle":
                    level.reticle_index[ localclientnum ] = int( weapon_option_new_index );
                    break;
                case "paintjob":
                    level.show_paintshop[ localclientnum ] = int( weapon_option_new_index );
                    break;
                default:
                    break;
            }
            
            level.weapon_script_model[ localclientnum ] setweaponrenderoptions( get_camo_index( localclientnum ), get_reticle_index( localclientnum ), get_show_payer_tag( localclientnum ), get_show_emblem( localclientnum ), get_show_paintshop( localclientnum ) );
        }
    }
}

// Namespace customclass
// Params 1
// Checksum 0x722245a2, Offset: 0x2da8
// Size: 0x138
function handle_cac_customization_attachmentvariant( localclientnum )
{
    level endon( #"disconnect" );
    level endon( "cam_customization_closed" + localclientnum );
    
    while ( true )
    {
        level waittill( "cam_customization_acv" + localclientnum, weapon_attachment_name, acv_index );
        
        for ( i = 0; i < level.attachment_names[ localclientnum ].size ; i++ )
        {
            if ( level.attachment_names[ localclientnum ][ i ] == weapon_attachment_name )
            {
                level.attachment_indices[ localclientnum ][ i ] = int( acv_index );
                break;
            }
        }
        
        if ( isdefined( level.weapon_script_model[ localclientnum ] ) )
        {
            level.weapon_script_model[ localclientnum ] setattachmentcosmeticvariantindex( level.last_weapon_name[ localclientnum ], weapon_attachment_name, int( acv_index ) );
        }
    }
}

// Namespace customclass
// Params 1
// Checksum 0x29d37208, Offset: 0x2ee8
// Size: 0x1be
function handle_cac_customization_closed( localclientnum )
{
    level endon( #"disconnect" );
    level waittill( "cam_customization_closed" + localclientnum, param1, param2, param3, param4 );
    
    if ( isdefined( level.weapon_clientscript_cac_model[ localclientnum ] ) && isdefined( level.weapon_clientscript_cac_model[ localclientnum ][ level.loadout_slot_name ] ) )
    {
        level.weapon_clientscript_cac_model[ localclientnum ][ level.loadout_slot_name ] setweaponrenderoptions( get_camo_index( localclientnum ), get_reticle_index( localclientnum ), get_show_payer_tag( localclientnum ), get_show_emblem( localclientnum ), get_show_paintshop( localclientnum ) );
        
        for ( i = 0; i < level.attachment_names[ localclientnum ].size ; i++ )
        {
            level.weapon_clientscript_cac_model[ localclientnum ][ level.loadout_slot_name ] setattachmentcosmeticvariantindex( level.last_weapon_name[ localclientnum ], level.attachment_names[ localclientnum ][ i ], level.attachment_indices[ localclientnum ][ i ] );
        }
    }
}

