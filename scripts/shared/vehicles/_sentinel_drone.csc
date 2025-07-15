#using scripts/codescripts/struct;
#using scripts/shared/archetype_shared/archetype_shared;
#using scripts/shared/beam_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace sentinel_drone;

// Namespace sentinel_drone
// Params 0, eflags: 0x2
// Checksum 0xe866954c, Offset: 0x8b8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "sentinel_drone", &__init__, undefined, undefined );
}

// Namespace sentinel_drone
// Params 0
// Checksum 0x5809ddbd, Offset: 0x8f8
// Size: 0x866
function __init__()
{
    clientfield::register( "scriptmover", "sentinel_drone_beam_set_target_id", 12000, 5, "int", &sentinel_drone_beam_set_target_id, 0, 0 );
    clientfield::register( "vehicle", "sentinel_drone_beam_set_source_to_target", 12000, 5, "int", &sentinel_drone_beam_set_source_to_target, 0, 0 );
    clientfield::register( "toplayer", "sentinel_drone_damage_player_fx", 12000, 1, "counter", &sentinel_drone_damage_player_fx, 0, 0 );
    clientfield::register( "vehicle", "sentinel_drone_beam_fire1", 12000, 1, "int", &sentinel_drone_beam_fire1, 0, 0 );
    clientfield::register( "vehicle", "sentinel_drone_beam_fire2", 12000, 1, "int", &sentinel_drone_beam_fire2, 0, 0 );
    clientfield::register( "vehicle", "sentinel_drone_beam_fire3", 12000, 1, "int", &sentinel_drone_beam_fire3, 0, 0 );
    clientfield::register( "vehicle", "sentinel_drone_arm_cut_1", 12000, 1, "int", &sentinel_drone_arm_cut_1, 0, 0 );
    clientfield::register( "vehicle", "sentinel_drone_arm_cut_2", 12000, 1, "int", &sentinel_drone_arm_cut_2, 0, 0 );
    clientfield::register( "vehicle", "sentinel_drone_arm_cut_3", 12000, 1, "int", &sentinel_drone_arm_cut_3, 0, 0 );
    clientfield::register( "vehicle", "sentinel_drone_face_cut", 12000, 1, "int", &sentinel_drone_face_cut, 0, 0 );
    clientfield::register( "vehicle", "sentinel_drone_beam_charge", 12000, 1, "int", &sentinel_drone_beam_charge, 0, 0 );
    clientfield::register( "vehicle", "sentinel_drone_camera_scanner", 12000, 1, "int", &sentinel_drone_camera_scanner, 0, 0 );
    clientfield::register( "vehicle", "sentinel_drone_camera_destroyed", 12000, 1, "int", &sentinel_drone_camera_destroyed, 0, 0 );
    clientfield::register( "scriptmover", "sentinel_drone_deathfx", 1, 1, "int", &sentinel_drone_deathfx, 0, 0 );
    level._sentinel_enemy_detected_taunts = [];
    
    if ( !isdefined( level._sentinel_enemy_detected_taunts ) )
    {
        level._sentinel_enemy_detected_taunts = [];
    }
    else if ( !isarray( level._sentinel_enemy_detected_taunts ) )
    {
        level._sentinel_enemy_detected_taunts = array( level._sentinel_enemy_detected_taunts );
    }
    
    level._sentinel_enemy_detected_taunts[ level._sentinel_enemy_detected_taunts.size ] = "vox_valk_valkyrie_detected_0";
    
    if ( !isdefined( level._sentinel_enemy_detected_taunts ) )
    {
        level._sentinel_enemy_detected_taunts = [];
    }
    else if ( !isarray( level._sentinel_enemy_detected_taunts ) )
    {
        level._sentinel_enemy_detected_taunts = array( level._sentinel_enemy_detected_taunts );
    }
    
    level._sentinel_enemy_detected_taunts[ level._sentinel_enemy_detected_taunts.size ] = "vox_valk_valkyrie_detected_1";
    
    if ( !isdefined( level._sentinel_enemy_detected_taunts ) )
    {
        level._sentinel_enemy_detected_taunts = [];
    }
    else if ( !isarray( level._sentinel_enemy_detected_taunts ) )
    {
        level._sentinel_enemy_detected_taunts = array( level._sentinel_enemy_detected_taunts );
    }
    
    level._sentinel_enemy_detected_taunts[ level._sentinel_enemy_detected_taunts.size ] = "vox_valk_valkyrie_detected_2";
    
    if ( !isdefined( level._sentinel_enemy_detected_taunts ) )
    {
        level._sentinel_enemy_detected_taunts = [];
    }
    else if ( !isarray( level._sentinel_enemy_detected_taunts ) )
    {
        level._sentinel_enemy_detected_taunts = array( level._sentinel_enemy_detected_taunts );
    }
    
    level._sentinel_enemy_detected_taunts[ level._sentinel_enemy_detected_taunts.size ] = "vox_valk_valkyrie_detected_3";
    
    if ( !isdefined( level._sentinel_enemy_detected_taunts ) )
    {
        level._sentinel_enemy_detected_taunts = [];
    }
    else if ( !isarray( level._sentinel_enemy_detected_taunts ) )
    {
        level._sentinel_enemy_detected_taunts = array( level._sentinel_enemy_detected_taunts );
    }
    
    level._sentinel_enemy_detected_taunts[ level._sentinel_enemy_detected_taunts.size ] = "vox_valk_valkyrie_detected_4";
    level._sentinel_attack_taunts = [];
    
    if ( !isdefined( level._sentinel_attack_taunts ) )
    {
        level._sentinel_attack_taunts = [];
    }
    else if ( !isarray( level._sentinel_attack_taunts ) )
    {
        level._sentinel_attack_taunts = array( level._sentinel_attack_taunts );
    }
    
    level._sentinel_attack_taunts[ level._sentinel_attack_taunts.size ] = "vox_valk_valkyrie_attack_0";
    
    if ( !isdefined( level._sentinel_attack_taunts ) )
    {
        level._sentinel_attack_taunts = [];
    }
    else if ( !isarray( level._sentinel_attack_taunts ) )
    {
        level._sentinel_attack_taunts = array( level._sentinel_attack_taunts );
    }
    
    level._sentinel_attack_taunts[ level._sentinel_attack_taunts.size ] = "vox_valk_valkyrie_attack_1";
    
    if ( !isdefined( level._sentinel_attack_taunts ) )
    {
        level._sentinel_attack_taunts = [];
    }
    else if ( !isarray( level._sentinel_attack_taunts ) )
    {
        level._sentinel_attack_taunts = array( level._sentinel_attack_taunts );
    }
    
    level._sentinel_attack_taunts[ level._sentinel_attack_taunts.size ] = "vox_valk_valkyrie_attack_2";
    
    if ( !isdefined( level._sentinel_attack_taunts ) )
    {
        level._sentinel_attack_taunts = [];
    }
    else if ( !isarray( level._sentinel_attack_taunts ) )
    {
        level._sentinel_attack_taunts = array( level._sentinel_attack_taunts );
    }
    
    level._sentinel_attack_taunts[ level._sentinel_attack_taunts.size ] = "vox_valk_valkyrie_attack_3";
    
    if ( !isdefined( level._sentinel_attack_taunts ) )
    {
        level._sentinel_attack_taunts = [];
    }
    else if ( !isarray( level._sentinel_attack_taunts ) )
    {
        level._sentinel_attack_taunts = array( level._sentinel_attack_taunts );
    }
    
    level._sentinel_attack_taunts[ level._sentinel_attack_taunts.size ] = "vox_valk_valkyrie_attack_4";
}

// Namespace sentinel_drone
// Params 2
// Checksum 0xd258ea6b, Offset: 0x1168
// Size: 0xe0
function sentinel_is_drone_initialized( localclientnum, b_check_for_target_existance_only )
{
    if ( !( isdefined( b_check_for_target_existance_only ) && b_check_for_target_existance_only ) )
    {
        if ( !( isdefined( self.init ) && self.init ) )
        {
            return 0;
        }
        
        if ( !self hasdobj( localclientnum ) )
        {
            return 0;
        }
        
        return 1;
    }
    
    source_num = self getentitynumber();
    
    if ( isdefined( level.sentinel_drone_source_to_target ) && isdefined( level.sentinel_drone_source_to_target[ source_num ] ) && isdefined( level.sentinel_drone_target_id ) && isdefined( level.sentinel_drone_target_id[ level.sentinel_drone_source_to_target[ source_num ] ] ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace sentinel_drone
// Params 7
// Checksum 0x9a3adf8a, Offset: 0x1250
// Size: 0x84
function sentinel_drone_damage_player_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    localplayer = getlocalplayer( localclientnum );
    
    if ( isdefined( localplayer ) )
    {
        localplayer thread postfx::playpostfxbundle( "sentinel_pstfx_shock_charge" );
    }
}

// Namespace sentinel_drone
// Params 7
// Checksum 0x6f40c38f, Offset: 0x12e0
// Size: 0x118
function sentinel_drone_deathfx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    settings = struct::get_script_bundle( "vehiclecustomsettings", "sentinel_drone_settings" );
    
    if ( isdefined( settings ) )
    {
        if ( newval )
        {
            handle = playfx( localclientnum, settings.drone_secondary_death_fx_1, self.origin );
            setfxignorepause( localclientnum, handle, 1 );
            
            if ( isdefined( self.beam_target_fx ) && isdefined( self.beam_target_fx[ localclientnum ] ) )
            {
                stopfx( localclientnum, self.beam_target_fx[ localclientnum ] );
                self.beam_target_fx[ localclientnum ] = undefined;
            }
        }
    }
}

// Namespace sentinel_drone
// Params 7
// Checksum 0xc80599f, Offset: 0x1400
// Size: 0x16c
function sentinel_drone_camera_scanner( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !sentinel_is_drone_initialized( localclientnum ) )
    {
        return 0;
    }
    
    if ( newval == 1 )
    {
        if ( !isdefined( self.camerascannerfx ) && !( isdefined( self.cameradestroyed ) && self.cameradestroyed ) )
        {
            self.camerascannerfx = playfxontag( localclientnum, "dlc3/stalingrad/fx_sentinel_drone_scanner_light_glow", self, "tag_flash" );
        }
        
        sentinel_play_engine_fx( localclientnum, 0, 1 );
        return;
    }
    
    /#
        keep_scanner_on = getdvarint( "<dev string:x28>", 0 );
    #/
    
    if ( isdefined( self.camerascannerfx ) && !( isdefined( keep_scanner_on ) && keep_scanner_on ) )
    {
        stopfx( localclientnum, self.camerascannerfx );
        self.camerascannerfx = undefined;
    }
    
    sentinel_play_engine_fx( localclientnum, 1, 0 );
}

// Namespace sentinel_drone
// Params 7
// Checksum 0x37c4eee5, Offset: 0x1578
// Size: 0xb6
function sentinel_drone_camera_destroyed( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self.cameradestroyed = 1;
    
    if ( isdefined( self.camerascannerfx ) )
    {
        stopfx( localclientnum, self.camerascannerfx );
        self.camerascannerfx = undefined;
    }
    
    if ( isdefined( self.cameraambientfx ) )
    {
        stopfx( localclientnum, self.cameraambientfx );
        self.cameraambientfx = undefined;
    }
}

// Namespace sentinel_drone
// Params 7
// Checksum 0xd1ba0fa9, Offset: 0x1638
// Size: 0x5c
function sentinel_drone_beam_fire1( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    sentinel_drone_beam_fire( localclientnum, newval, "tag_fx1" );
}

// Namespace sentinel_drone
// Params 7
// Checksum 0xba5149ad, Offset: 0x16a0
// Size: 0x5c
function sentinel_drone_beam_fire2( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    sentinel_drone_beam_fire( localclientnum, newval, "tag_fx2" );
}

// Namespace sentinel_drone
// Params 7
// Checksum 0xc1e29887, Offset: 0x1708
// Size: 0x5c
function sentinel_drone_beam_fire3( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    sentinel_drone_beam_fire( localclientnum, newval, "tag_fx3" );
}

// Namespace sentinel_drone
// Params 3
// Checksum 0x1d8bb6a9, Offset: 0x1770
// Size: 0x284
function sentinel_drone_beam_fire( localclientnum, newval, tag_id )
{
    if ( sentinel_is_drone_initialized( localclientnum, newval == 0 ) )
    {
        source_num = self getentitynumber();
        beam_target = level.sentinel_drone_target_id[ level.sentinel_drone_source_to_target[ source_num ] ];
    }
    else
    {
        return;
    }
    
    if ( newval == 1 )
    {
        level beam::launch( self, tag_id, beam_target, "tag_origin", "electric_taser_beam_1" );
        self playsound( 0, "zmb_sentinel_attack_short" );
        
        if ( !isdefined( beam_target.beam_target_fx ) )
        {
            beam_target.beam_target_fx = [];
        }
        
        if ( !isdefined( beam_target.beam_target_fx[ localclientnum ] ) )
        {
            beam_target.beam_target_fx[ localclientnum ] = playfxontag( localclientnum, "dlc3/stalingrad/fx_sentinel_drone_taser_fire_tgt", beam_target, "tag_origin" );
        }
        
        /#
            keep_scanner_on = getdvarint( "<dev string:x28>", 0 );
        #/
        
        if ( isdefined( self.camerascannerfx ) && !( isdefined( keep_scanner_on ) && keep_scanner_on ) )
        {
            stopfx( localclientnum, self.camerascannerfx );
            self.camerascannerfx = undefined;
        }
        
        return;
    }
    
    level beam::kill( self, tag_id, beam_target, "tag_origin", "electric_taser_beam_1" );
    
    if ( isdefined( beam_target.beam_target_fx ) && isdefined( beam_target.beam_target_fx[ localclientnum ] ) )
    {
        stopfx( localclientnum, beam_target.beam_target_fx[ localclientnum ] );
        beam_target.beam_target_fx[ localclientnum ] = undefined;
    }
    
    self sentinel_play_claws_ambient_fx( localclientnum );
}

// Namespace sentinel_drone
// Params 7
// Checksum 0x4cbf813, Offset: 0x1a00
// Size: 0x66
function sentinel_drone_beam_set_target_id( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !isdefined( level.sentinel_drone_target_id ) )
    {
        level.sentinel_drone_target_id = [];
    }
    
    level.sentinel_drone_target_id[ newval ] = self;
}

#using_animtree( "generic" );

// Namespace sentinel_drone
// Params 7
// Checksum 0xf588f741, Offset: 0x1a70
// Size: 0x174
function sentinel_drone_beam_set_source_to_target( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !isdefined( level.sentinel_drone_source_to_target ) )
    {
        level.sentinel_drone_source_to_target = [];
    }
    
    source_num = self getentitynumber();
    level.sentinel_drone_source_to_target[ source_num ] = newval;
    self.init = 1;
    self sentinel_play_claws_ambient_fx( localclientnum );
    self.cameraambientfx = playfxontag( localclientnum, "dlc3/stalingrad/fx_sentinel_drone_eye_camera_lens_glow", self, "tag_flash" );
    self.camerascannerfx = playfxontag( localclientnum, "dlc3/stalingrad/fx_sentinel_drone_scanner_light_glow", self, "tag_flash" );
    sentinel_play_engine_fx( localclientnum, 1, 0 );
    self useanimtree( #animtree );
    self setanim( "ai_zm_dlc3_sentinel_antenna_twitch" );
}

// Namespace sentinel_drone
// Params 7
// Checksum 0x225ab245, Offset: 0x1bf0
// Size: 0x54
function sentinel_drone_arm_cut_1( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    sentinel_drone_arm_cut( localclientnum, 1 );
}

// Namespace sentinel_drone
// Params 7
// Checksum 0x8f4c8905, Offset: 0x1c50
// Size: 0x54
function sentinel_drone_arm_cut_2( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    sentinel_drone_arm_cut( localclientnum, 2 );
}

// Namespace sentinel_drone
// Params 7
// Checksum 0x3ec54c3d, Offset: 0x1cb0
// Size: 0x54
function sentinel_drone_arm_cut_3( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    sentinel_drone_arm_cut( localclientnum, 3 );
}

// Namespace sentinel_drone
// Params 4
// Checksum 0x828d04a1, Offset: 0x1d10
// Size: 0x2cc
function sentinel_spawn_broken_arm( localclientnum, arm, arm_tag, claw_tag )
{
    if ( !sentinel_is_drone_initialized( localclientnum ) )
    {
        return 0;
    }
    
    velocity = self getvelocity();
    velocity_normal = vectornormalize( velocity );
    velocity_length = length( velocity );
    
    if ( arm == 3 )
    {
        launch_dir = anglestoforward( self.angles ) * -1;
        launch_dir += ( 0, 0, 1 );
        launch_dir = vectornormalize( launch_dir );
    }
    else if ( arm == 1 )
    {
        launch_dir = anglestoright( self.angles );
    }
    else
    {
        launch_dir = anglestoright( self.angles ) * -1;
    }
    
    velocity_length *= 0.1;
    
    if ( velocity_length < 10 )
    {
        velocity_length = 10;
    }
    
    launch_dir = launch_dir * 0.5 + velocity_normal * 0.5;
    launch_dir *= velocity_length;
    claw_pos = self gettagorigin( claw_tag ) + launch_dir * 3;
    claw_ang = self gettagangles( claw_tag );
    thread sentinel_launch_piece( localclientnum, "veh_t7_dlc3_sentinel_drone_spawn_claw", claw_pos, claw_ang, self.origin, launch_dir * 1.3 );
    arm_pos = self gettagorigin( arm_tag ) + launch_dir * 2;
    arm_ang = self gettagangles( arm_tag );
    thread sentinel_launch_piece( localclientnum, "veh_t7_dlc3_sentinel_drone_spawn_arm", arm_pos, arm_ang, self.origin, launch_dir );
}

// Namespace sentinel_drone
// Params 2
// Checksum 0x1625828d, Offset: 0x1fe8
// Size: 0x3ec
function sentinel_drone_arm_cut( localclientnum, arm )
{
    if ( arm == 1 )
    {
        if ( !( isdefined( self.rightarmlost ) && self.rightarmlost ) )
        {
            sentinel_spawn_broken_arm( localclientnum, 1, "tag_arm_right_04_d1", "tag_fx1" );
            self.rightarmlost = 1;
            sentinel_drone_beam_fire( localclientnum, 0, "tag_fx1" );
            
            if ( isdefined( self.rightclawambientfx ) )
            {
                stopfx( localclientnum, self.rightclawambientfx );
                self.rightclawambientfx = undefined;
            }
            
            if ( isdefined( self.rightclawchargefx ) )
            {
                stopfx( localclientnum, self.rightclawchargefx );
                self.rightclawchargefx = undefined;
            }
            
            if ( sentinel_is_drone_initialized( localclientnum ) )
            {
                playfxontag( localclientnum, "dlc3/stalingrad/fx_sentinel_drone_dest_arm", self, "tag_arm_right_04_d1" );
                self setanim( "ai_zm_dlc3_sentinel_arms_broken_right" );
            }
        }
        
        return;
    }
    
    if ( arm == 2 )
    {
        if ( !( isdefined( self.leftarmlost ) && self.leftarmlost ) )
        {
            sentinel_spawn_broken_arm( localclientnum, 2, "tag_arm_left_03_d1", "tag_fx2" );
            self.leftarmlost = 1;
            sentinel_drone_beam_fire( localclientnum, 0, "tag_fx2" );
            
            if ( isdefined( self.leftclawambientfx ) )
            {
                stopfx( localclientnum, self.leftclawambientfx );
                self.leftclawambientfx = undefined;
            }
            
            if ( isdefined( self.leftclawchargefx ) )
            {
                stopfx( localclientnum, self.leftclawchargefx );
                self.leftclawchargefx = undefined;
            }
            
            if ( sentinel_is_drone_initialized( localclientnum ) )
            {
                playfxontag( localclientnum, "dlc3/stalingrad/fx_sentinel_drone_dest_arm", self, "tag_arm_left_03_d1" );
                self setanim( "ai_zm_dlc3_sentinel_arms_broken_left" );
            }
        }
        
        return;
    }
    
    if ( arm == 3 )
    {
        if ( !( isdefined( self.toparmlost ) && self.toparmlost ) )
        {
            sentinel_spawn_broken_arm( localclientnum, 3, "tag_arm_top_03_d1", "tag_fx3" );
            self.toparmlost = 1;
            sentinel_drone_beam_fire( localclientnum, 0, "tag_fx3" );
            
            if ( isdefined( self.topclawambientfx ) )
            {
                stopfx( localclientnum, self.topclawambientfx );
                self.topclawambientfx = undefined;
            }
            
            if ( isdefined( self.topclawchargefx ) )
            {
                stopfx( localclientnum, self.topclawchargefx );
                self.topclawchargefx = undefined;
            }
            
            if ( sentinel_is_drone_initialized( localclientnum ) )
            {
                playfxontag( localclientnum, "dlc3/stalingrad/fx_sentinel_drone_dest_arm", self, "tag_arm_top_03_d1" );
                self setanim( "ai_zm_dlc3_sentinel_arms_broken_top" );
            }
        }
    }
}

// Namespace sentinel_drone
// Params 7
// Checksum 0x5c45125b, Offset: 0x23e0
// Size: 0x2a6
function sentinel_drone_beam_charge( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !sentinel_is_drone_initialized( localclientnum ) )
    {
        return 0;
    }
    
    if ( newval == 1 )
    {
        if ( !isdefined( self.camerascannerfx ) )
        {
            self.camerascannerfx = playfxontag( localclientnum, "dlc3/stalingrad/fx_sentinel_drone_scanner_light_glow", self, "tag_flash" );
        }
        
        self sentinel_play_claws_ambient_fx( localclientnum, 1 );
        
        if ( !( isdefined( self.rightarmlost ) && self.rightarmlost ) )
        {
            self.rightclawchargefx = playfxontag( localclientnum, "dlc3/stalingrad/fx_sentinel_drone_taser_charging", self, "tag_fx1" );
        }
        
        if ( !( isdefined( self.leftarmlost ) && self.leftarmlost ) )
        {
            self.leftclawchargefx = playfxontag( localclientnum, "dlc3/stalingrad/fx_sentinel_drone_taser_charging", self, "tag_fx2" );
        }
        
        if ( !( isdefined( self.toparmlost ) && self.toparmlost ) )
        {
            self.topclawchargefx = playfxontag( localclientnum, "dlc3/stalingrad/fx_sentinel_drone_taser_charging", self, "tag_fx3" );
        }
        
        if ( isdefined( self.enemy_already_spotted ) )
        {
            if ( randomint( 100 ) < 30 )
            {
                sentinel_play_taunt( localclientnum, level._sentinel_attack_taunts );
            }
        }
        else
        {
            self.enemy_already_spotted = 1;
            sentinel_play_taunt( localclientnum, level._sentinel_enemy_detected_taunts );
        }
        
        return;
    }
    
    if ( isdefined( self.rightclawchargefx ) )
    {
        stopfx( localclientnum, self.rightclawchargefx );
        self.rightclawchargefx = undefined;
    }
    
    if ( isdefined( self.leftclawchargefx ) )
    {
        stopfx( localclientnum, self.leftclawchargefx );
        self.leftclawchargefx = undefined;
    }
    
    if ( isdefined( self.topclawchargefx ) )
    {
        stopfx( localclientnum, self.topclawchargefx );
        self.topclawchargefx = undefined;
    }
}

// Namespace sentinel_drone
// Params 7
// Checksum 0xfc7a6fe9, Offset: 0x2690
// Size: 0x20c
function sentinel_drone_face_cut( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !sentinel_is_drone_initialized( localclientnum ) )
    {
        return 0;
    }
    
    face_pos = self gettagorigin( "tag_faceplate_d0" );
    face_ang = self gettagangles( "tag_faceplate_d0" );
    velocity = self getvelocity();
    velocity_normal = vectornormalize( velocity );
    velocity_length = length( velocity );
    launch_dir = anglestoforward( self.angles );
    velocity_length *= 0.1;
    
    if ( velocity_length < 10 )
    {
        velocity_length = 10;
    }
    
    launch_dir = launch_dir * 0.5 + velocity_normal * 0.5;
    launch_dir *= velocity_length;
    thread sentinel_launch_piece( localclientnum, "veh_t7_dlc3_sentinel_drone_faceplate", face_pos, face_ang, self.origin, launch_dir );
    playfxontag( localclientnum, "dlc3/stalingrad/fx_sentinel_drone_dest_core", self, "tag_faceplate_d0" );
    playfxontag( localclientnum, "dlc3/stalingrad/fx_sentinel_drone_energy_core_glow", self, "ag_core_d0" );
}

// Namespace sentinel_drone
// Params 2
// Checksum 0xb5ce96d, Offset: 0x28a8
// Size: 0x1de
function sentinel_play_claws_ambient_fx( localclientnum, b_false )
{
    if ( !sentinel_is_drone_initialized( localclientnum ) )
    {
        return 0;
    }
    
    if ( !( isdefined( b_false ) && b_false ) )
    {
        if ( !( isdefined( self.rightarmlost ) && self.rightarmlost ) && !isdefined( self.rightclawambientfx ) )
        {
            self.rightclawambientfx = playfxontag( localclientnum, "dlc3/stalingrad/fx_sentinel_drone_taser_idle", self, "tag_fx1" );
        }
        
        if ( !( isdefined( self.leftarmlost ) && self.leftarmlost ) && !isdefined( self.leftclawambientfx ) )
        {
            self.leftclawambientfx = playfxontag( localclientnum, "dlc3/stalingrad/fx_sentinel_drone_taser_idle", self, "tag_fx2" );
        }
        
        if ( !( isdefined( self.toparmlost ) && self.toparmlost ) && !isdefined( self.topclawambientfx ) )
        {
            self.topclawambientfx = playfxontag( localclientnum, "dlc3/stalingrad/fx_sentinel_drone_taser_idle", self, "tag_fx3" );
        }
        
        return;
    }
    
    if ( isdefined( self.rightclawambientfx ) )
    {
        stopfx( localclientnum, self.rightclawambientfx );
        self.rightclawambientfx = undefined;
    }
    
    if ( isdefined( self.leftclawambientfx ) )
    {
        stopfx( localclientnum, self.leftclawambientfx );
        self.leftclawambientfx = undefined;
    }
    
    if ( isdefined( self.topclawambientfx ) )
    {
        stopfx( localclientnum, self.topclawambientfx );
        self.topclawambientfx = undefined;
    }
}

// Namespace sentinel_drone
// Params 3
// Checksum 0xa36319b6, Offset: 0x2a90
// Size: 0x11c
function sentinel_play_engine_fx( localclientnum, b_engine, b_roll_engine )
{
    if ( !sentinel_is_drone_initialized( localclientnum ) )
    {
        return 0;
    }
    
    if ( isdefined( b_engine ) && b_engine )
    {
        self.enginefx = playfxontag( localclientnum, "dlc3/stalingrad/fx_sentinel_drone_engine_idle", self, "tag_fx_engine_left" );
    }
    else if ( isdefined( self.enginefx ) )
    {
        stopfx( localclientnum, self.enginefx );
    }
    
    if ( isdefined( b_roll_engine ) && b_roll_engine )
    {
        self.enginerollfx = playfxontag( localclientnum, "dlc3/stalingrad/fx_sentinel_drone_engine_smk_fast", self, "tag_fx_engine_left" );
        return;
    }
    
    if ( isdefined( self.enginerollfx ) )
    {
        stopfx( localclientnum, self.enginerollfx );
    }
}

// Namespace sentinel_drone
// Params 2
// Checksum 0x2c17bb0e, Offset: 0x2bb8
// Size: 0xa4
function sentinel_play_taunt( localclientnum, taunt_arr )
{
    if ( isdefined( level._lastplayed_drone_taunt ) && gettime() - level._lastplayed_drone_taunt < 6000 )
    {
        return;
    }
    
    if ( isdefined( level.voxaideactivate ) && level.voxaideactivate )
    {
        return;
    }
    
    taunt = randomint( taunt_arr.size );
    level._lastplayed_drone_taunt = gettime();
    self playsound( localclientnum, taunt_arr[ taunt ] );
}

// Namespace sentinel_drone
// Params 6
// Checksum 0xa8b65ad7, Offset: 0x2c68
// Size: 0x284
function sentinel_launch_piece( localclientnum, model, pos, angles, hitpos, force )
{
    dynent = createdynentandlaunch( localclientnum, model, pos, angles, hitpos, force );
    
    if ( !isdefined( dynent ) )
    {
        return;
    }
    
    posheight = pos[ 2 ];
    wait 0.5;
    
    if ( !isdefined( dynent ) || !isdynentvalid( dynent ) )
    {
        return 0;
    }
    
    if ( dynent.origin == pos )
    {
        setdynentenabled( dynent, 0 );
        return;
    }
    
    pos = dynent.origin;
    wait 0.4;
    
    if ( !isdefined( dynent ) || !isdynentvalid( dynent ) )
    {
        return 0;
    }
    
    if ( dynent.origin == pos )
    {
        setdynentenabled( dynent, 0 );
        return;
    }
    
    wait 1;
    
    if ( !isdefined( dynent ) || !isdynentvalid( dynent ) )
    {
        return 0;
    }
    
    count = 0;
    old_pos = dynent.origin;
    
    while ( isdefined( dynent ) && isdynentvalid( dynent ) )
    {
        if ( old_pos == dynent.origin )
        {
            old_pos = dynent.origin;
            count++;
            
            if ( count == 5 )
            {
                if ( posheight - dynent.origin[ 2 ] < 15 )
                {
                    setdynentenabled( dynent, 0 );
                }
                else
                {
                    break;
                }
            }
        }
        else
        {
            count = 0;
        }
        
        wait 0.2;
    }
}

