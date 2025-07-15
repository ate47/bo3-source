#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace infection_util;

// Namespace infection_util
// Params 0, eflags: 0x2
// Checksum 0x499041c8, Offset: 0xab0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "infection_util", &__init__, undefined, undefined );
}

// Namespace infection_util
// Params 0
// Checksum 0x9e410f8f, Offset: 0xaf0
// Size: 0x24
function __init__()
{
    init_fx();
    init_clientfields();
}

// Namespace infection_util
// Params 0
// Checksum 0x7f82674a, Offset: 0xb20
// Size: 0x216
function init_fx()
{
    level._effect[ "ai_dni_rez_in_arm_left" ] = "player/fx_ai_dni_rez_in_arm_left_dirty";
    level._effect[ "ai_dni_rez_in_arm_right" ] = "player/fx_ai_dni_rez_in_arm_right_dirty";
    level._effect[ "ai_dni_rez_in_head" ] = "player/fx_ai_dni_rez_in_head_dirty";
    level._effect[ "ai_dni_rez_in_hip_left" ] = "player/fx_ai_dni_rez_in_hip_left_dirty";
    level._effect[ "ai_dni_rez_in_hip_right" ] = "player/fx_ai_dni_rez_in_hip_right_dirty";
    level._effect[ "ai_dni_rez_in_leg_left" ] = "player/fx_ai_dni_rez_in_leg_left_dirty";
    level._effect[ "ai_dni_rez_in_leg_right" ] = "player/fx_ai_dni_rez_in_leg_right_dirty";
    level._effect[ "ai_dni_rez_in_torso" ] = "player/fx_ai_dni_rez_in_torso_dirty";
    level._effect[ "ai_dni_rez_in_waist" ] = "player/fx_ai_dni_rez_in_waist_dirty";
    level._effect[ "ai_dni_rez_out_arm_left" ] = "player/fx_ai_dni_rez_out_arm_left_dirty";
    level._effect[ "ai_dni_rez_out_arm_right" ] = "player/fx_ai_dni_rez_out_arm_right_dirty";
    level._effect[ "ai_dni_rez_out_head" ] = "player/fx_ai_dni_rez_out_head_dirty";
    level._effect[ "ai_dni_rez_out_hip_left" ] = "player/fx_ai_dni_rez_out_hip_left_dirty";
    level._effect[ "ai_dni_rez_out_hip_right" ] = "player/fx_ai_dni_rez_out_hip_right_dirty";
    level._effect[ "ai_dni_rez_out_leg_left" ] = "player/fx_ai_dni_rez_out_leg_left_dirty";
    level._effect[ "ai_dni_rez_out_leg_right" ] = "player/fx_ai_dni_rez_out_leg_right_dirty";
    level._effect[ "ai_dni_rez_out_torso" ] = "player/fx_ai_dni_rez_out_torso_dirty";
    level._effect[ "ai_dni_rez_out_waist" ] = "player/fx_ai_dni_rez_out_waist_dirty";
    level._effect[ "ai_dni_rez_out_wolf_dirty" ] = "player/fx_ai_dni_rez_out_wolf_dirty";
}

// Namespace infection_util
// Params 0
// Checksum 0x3c35afb7, Offset: 0xd40
// Size: 0x464
function init_clientfields()
{
    clientfield::register( "toplayer", "snow_fx", 1, 2, "int", &callback_fx_snow_players, 0, 0 );
    clientfield::register( "actor", "sarah_objective_light", 1, 1, "int", &callback_sarah_light, 0, 0 );
    clientfield::register( "actor", "sarah_body_light", 1, 1, "int", &function_206d5db6, 0, 0 );
    clientfield::register( "actor", "reverse_arrival_snow_fx", 1, 1, "int", &callback_time_snow_fx, 0, 0 );
    clientfield::register( "actor", "reverse_arrival_dmg_fx", 1, 1, "int", &callback_time_dmg_fx, 0, 0 );
    clientfield::register( "actor", "exploding_ai_deaths", 1, 1, "int", &callback_exploding_death_fx, 0, 0 );
    clientfield::register( "actor", "reverse_arrival_explosion_fx", 1, 1, "int", &callback_reverse_time_explosion_fx, 0, 0 );
    clientfield::register( "allplayers", "player_spawn_fx", 1, 1, "int", &callback_ally_spawn_fx, 0, 0 );
    clientfield::register( "toplayer", "stop_post_fx", 1, 1, "counter", &callback_stop_post_fx, 0, 0 );
    clientfield::register( "actor", "ai_dni_rez_in", 1, 1, "int", &function_207ed741, 0, 0 );
    clientfield::register( "actor", "ai_dni_rez_out", 1, 1, "counter", &function_5ae9b898, 0, 0 );
    clientfield::register( "toplayer", "postfx_dni_interrupt", 1, 1, "counter", &postfx_dni_interrupt, 0, 0 );
    clientfield::register( "toplayer", "postfx_futz", 1, 1, "counter", &postfx_futz, 0, 0 );
    clientfield::register( "actor", "sarah_camo_shader", 1, 3, "int", &ent_camo_material_callback, 0, 1 );
    duplicate_render::set_dr_filter_framebuffer( "active_camo", 90, "actor_camo_on", "", 0, "mc/hud_outline_predator_camo_active_inf", 1 );
    duplicate_render::set_dr_filter_framebuffer( "active_camo_flicker", 80, "actor_camo_flicker", "", 0, "mc/hud_outline_predator_camo_disruption_inf", 1 );
}

// Namespace infection_util
// Params 7
// Checksum 0x38b38d85, Offset: 0x11b0
// Size: 0x74
function callback_time_snow_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self fx_play_on_tag( localclientnum, "reverse_snow_fx", "weather/fx_snow_impact_body_reverse_infection" );
    }
}

// Namespace infection_util
// Params 7
// Checksum 0x6516c242, Offset: 0x1230
// Size: 0xb4
function callback_time_dmg_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self fx_play_on_tag( localclientnum, "reverse_blood_fx", "impacts/fx_bul_impact_blood_body_fatal_reverse", "tag_eye" );
        return;
    }
    
    self fx_play_on_tag( localclientnum, "reverse_blood_fx", "impacts/fx_bul_impact_blood_body_fatal_reverse", "j_spine4" );
}

// Namespace infection_util
// Params 7
// Checksum 0xa322785f, Offset: 0x12f0
// Size: 0xac
function callback_reverse_time_explosion_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self fx_play( localclientnum, "reverse_explosion_arrival", "explosions/fx_exp_mortar_snow_reverse", 1, self.origin );
        return;
    }
    
    self fx_clear( localclientnum, "reverse_explosion_arrival", "explosions/fx_exp_mortar_snow_reverse" );
}

// Namespace infection_util
// Params 7
// Checksum 0x580e99cb, Offset: 0x13a8
// Size: 0x13c
function callback_exploding_death_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        pos = self gettagorigin( "j_spine4" );
        angles = self gettagangles( "j_spine4" );
        fxobj = util::spawn_model( localclientnum, "tag_origin", pos, angles );
        fxobj fx_play_on_tag( localclientnum, "exploding_death_fx", "explosions/fx_exp_torso_blood_infection", "tag_origin" );
        fxobj playsound( 0, "evt_ai_explode" );
        wait 6;
        fxobj delete();
    }
}

// Namespace infection_util
// Params 7
// Checksum 0x8d5e72a3, Offset: 0x14f0
// Size: 0x182
function callback_sarah_light( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !isdefined( level.var_c1d1c557 ) )
    {
        level.var_c1d1c557 = util::spawn_model( localclientnum, "tag_origin", self.origin, self.angles );
    }
    
    if ( newval )
    {
        if ( self.team != "allies" )
        {
            return;
        }
        
        level thread function_cdbbde70( self, level.var_c1d1c557 );
        level.var_c1d1c557 fx_play_on_tag( localclientnum, "objective_light", "light/fx_beam_sarah_marker_bright", "tag_origin" );
        self fx_play_on_tag( localclientnum, "objective_light", "player/fx_ai_sarah_marker_body", "J_MainRoot" );
        return;
    }
    
    level.var_c1d1c557 fx_clear( localclientnum, "objective_light", "light/fx_beam_sarah_marker_bright" );
    self fx_clear( localclientnum, "objective_light", "player/fx_ai_sarah_marker_body" );
    level notify( #"hash_f9e936e2" );
}

// Namespace infection_util
// Params 2
// Checksum 0x6b663c13, Offset: 0x1680
// Size: 0xd0
function function_cdbbde70( ai_sarah, ground_ent )
{
    level notify( #"hash_f9e936e2" );
    ground_ent endon( #"death" );
    level endon( #"hash_f9e936e2" );
    
    while ( isdefined( ai_sarah ) )
    {
        ground_ent.origin = bullettrace( ai_sarah.origin, ai_sarah.origin + ( 0, 0, -100000 ), 0, ai_sarah )[ "position" ];
        ground_ent.angles = ( 0, ai_sarah.angles[ 1 ], 0 );
        wait 0.016;
    }
}

// Namespace infection_util
// Params 7
// Checksum 0xc61f2b57, Offset: 0x1758
// Size: 0xbc
function function_206d5db6( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        if ( self.team != "allies" )
        {
            return;
        }
        
        self fx_play_on_tag( localclientnum, "objective_light", "player/fx_ai_sarah_marker_body", "J_MainRoot" );
        return;
    }
    
    self fx_clear( localclientnum, "objective_light", "player/fx_ai_sarah_marker_body" );
}

// Namespace infection_util
// Params 7
// Checksum 0x378cf622, Offset: 0x1820
// Size: 0x124
function callback_fx_snow_players( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self fx_play_on_tag( localclientnum, "snow_fx", "weather/fx_snow_player_loop", "none" );
        return;
    }
    
    if ( newval == 2 )
    {
        self fx_play_on_tag( localclientnum, "snow_fx", "weather/fx_snow_player_loop_reverse", "none" );
        return;
    }
    
    if ( newval == 3 )
    {
        self fx_play_on_tag( localclientnum, "snow_fx", "weather/fx_snow_player_loop_reverse_sideways", "none" );
        return;
    }
    
    self fx_delete_type( localclientnum, "snow_fx", 0 );
}

// Namespace infection_util
// Params 3
// Checksum 0xd1f5ebd0, Offset: 0x1950
// Size: 0x10c
function fx_clear( localclientnum, str_type, str_fx )
{
    if ( !isdefined( self.a_fx ) )
    {
        self.a_fx = [];
    }
    
    if ( !isdefined( self.a_fx[ localclientnum ] ) )
    {
        self.a_fx[ localclientnum ] = [];
    }
    
    if ( !isdefined( self.a_fx[ localclientnum ][ str_type ] ) )
    {
        self.a_fx[ localclientnum ][ str_type ] = [];
    }
    
    if ( isdefined( str_fx ) && isdefined( self.a_fx[ localclientnum ][ str_type ][ str_fx ] ) )
    {
        n_fx_id = self.a_fx[ localclientnum ][ str_type ][ str_fx ];
        deletefx( localclientnum, n_fx_id, 0 );
        self.a_fx[ localclientnum ][ str_type ][ str_fx ] = undefined;
    }
}

// Namespace infection_util
// Params 3
// Checksum 0x71f26a3a, Offset: 0x1a68
// Size: 0x11e
function fx_delete_type( localclientnum, str_type, b_stop_immediately )
{
    if ( !isdefined( b_stop_immediately ) )
    {
        b_stop_immediately = 1;
    }
    
    if ( isdefined( self.a_fx ) && isdefined( self.a_fx[ localclientnum ] ) && isdefined( self.a_fx[ localclientnum ][ str_type ] ) )
    {
        a_keys = getarraykeys( self.a_fx[ localclientnum ][ str_type ] );
        
        for ( i = 0; i < a_keys.size ; i++ )
        {
            deletefx( localclientnum, self.a_fx[ localclientnum ][ str_type ][ a_keys[ i ] ], b_stop_immediately );
            self.a_fx[ localclientnum ][ str_type ][ a_keys[ i ] ] = undefined;
        }
    }
}

// Namespace infection_util
// Params 5
// Checksum 0x68a0b980, Offset: 0x1b90
// Size: 0x10e
function fx_play_on_tag( localclientnum, str_type, str_fx, str_tag, b_kill_fx_with_same_type )
{
    if ( !isdefined( str_tag ) )
    {
        str_tag = "tag_origin";
    }
    
    if ( !isdefined( b_kill_fx_with_same_type ) )
    {
        b_kill_fx_with_same_type = 1;
    }
    
    self fx_clear( localclientnum, str_type, str_fx );
    
    if ( b_kill_fx_with_same_type )
    {
        self fx_delete_type( localclientnum, str_type, 0 );
    }
    
    if ( isdefined( self ) && self hasdobj( localclientnum ) )
    {
        n_fx_id = playfxontag( localclientnum, str_fx, self, str_tag );
        self.a_fx[ localclientnum ][ str_type ][ str_fx ] = n_fx_id;
    }
}

// Namespace infection_util
// Params 7
// Checksum 0xea00ac46, Offset: 0x1ca8
// Size: 0x15e
function fx_play( localclientnum, str_type, str_fx, b_kill_fx_with_same_type, v_pos, v_forward, v_up )
{
    if ( !isdefined( b_kill_fx_with_same_type ) )
    {
        b_kill_fx_with_same_type = 1;
    }
    
    self fx_clear( localclientnum, str_type, str_fx );
    
    if ( b_kill_fx_with_same_type )
    {
        self fx_delete_type( localclientnum, str_type, 0 );
    }
    
    if ( isdefined( v_forward ) && isdefined( v_up ) )
    {
        n_fx_id = playfx( localclientnum, str_fx, v_pos, v_forward, v_up );
    }
    else if ( isdefined( v_forward ) )
    {
        n_fx_id = playfx( localclientnum, str_fx, v_pos, v_forward );
    }
    else
    {
        n_fx_id = playfx( localclientnum, str_fx, v_pos );
    }
    
    self.a_fx[ localclientnum ][ str_type ][ str_fx ] = n_fx_id;
}

// Namespace infection_util
// Params 7
// Checksum 0x4acb6d00, Offset: 0x1e10
// Size: 0xbc
function callback_ally_spawn_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self fx_play_on_tag( localclientnum, "objective_light", "light/fx_beam_friendly_flash_in_infection" );
        self playsound( 0, "evt_ai_teleport" );
        return;
    }
    
    self fx_clear( localclientnum, "objective_light", "light/fx_beam_friendly_flash_in_infection" );
}

// Namespace infection_util
// Params 7
// Checksum 0x90942126, Offset: 0x1ed8
// Size: 0x74
function callback_stop_post_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = getlocalplayer( localclientnum );
    player postfx::stoppostfxbundle();
}

// Namespace infection_util
// Params 7
// Checksum 0x162e6633, Offset: 0x1f58
// Size: 0x64
function postfx_dni_interrupt( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self postfx::playpostfxbundle( "pstfx_dni_interrupt" );
    }
}

// Namespace infection_util
// Params 7
// Checksum 0x7a157503, Offset: 0x1fc8
// Size: 0x64
function postfx_futz( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self postfx::playpostfxbundle( "pstfx_dni_screen_futz" );
    }
}

// Namespace infection_util
// Params 7
// Checksum 0x93445bb9, Offset: 0x2038
// Size: 0xa4
function ent_camo_material_callback( local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self duplicate_render::set_dr_flag( "actor_camo_flicker", newval == 2 );
    self duplicate_render::set_dr_flag( "actor_camo_on", newval != 0 );
    self duplicate_render::change_dr_flags( local_client_num );
}

// Namespace infection_util
// Params 7
// Checksum 0xc10d10f3, Offset: 0x20e8
// Size: 0x274
function function_207ed741( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self playsound( 0, "evt_ai_teleport" );
    
    if ( newval )
    {
        playfxontag( localclientnum, level._effect[ "ai_dni_rez_in_arm_left" ], self, "j_elbow_le" );
        playfxontag( localclientnum, level._effect[ "ai_dni_rez_in_arm_left" ], self, "j_shoulder_le" );
        playfxontag( localclientnum, level._effect[ "ai_dni_rez_in_arm_right" ], self, "j_elbow_ri" );
        playfxontag( localclientnum, level._effect[ "ai_dni_rez_in_arm_right" ], self, "j_shoulder_ri" );
        playfxontag( localclientnum, level._effect[ "ai_dni_rez_in_head" ], self, "j_head" );
        playfxontag( localclientnum, level._effect[ "ai_dni_rez_in_hip_left" ], self, "j_hip_le" );
        playfxontag( localclientnum, level._effect[ "ai_dni_rez_in_hip_right" ], self, "j_hip_ri" );
        playfxontag( localclientnum, level._effect[ "ai_dni_rez_in_leg_left" ], self, "j_knee_le" );
        playfxontag( localclientnum, level._effect[ "ai_dni_rez_in_leg_right" ], self, "j_knee_ri" );
        playfxontag( localclientnum, level._effect[ "ai_dni_rez_in_torso" ], self, "j_spine4" );
        playfxontag( localclientnum, level._effect[ "ai_dni_rez_in_waist" ], self, "j_spinelower" );
    }
}

// Namespace infection_util
// Params 7
// Checksum 0xa4cf6a09, Offset: 0x2368
// Size: 0x34c
function function_5ae9b898( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self playsound( 0, "evt_ai_explode" );
    
    if ( self.species === "zombie_dog" )
    {
        playfxontag( localclientnum, level._effect[ "ai_dni_rez_out_wolf_dirty" ], self, "j_head" );
        playfxontag( localclientnum, level._effect[ "ai_dni_rez_out_wolf_dirty" ], self, "j_mainroot" );
        playfxontag( localclientnum, level._effect[ "ai_dni_rez_out_wolf_dirty" ], self, "spine3_jnt" );
        playfxontag( localclientnum, level._effect[ "ai_dni_rez_out_wolf_dirty" ], self, "neck1_jnt" );
        return;
    }
    
    playfxontag( localclientnum, level._effect[ "ai_dni_rez_out_arm_left" ], self, "j_elbow_le" );
    playfxontag( localclientnum, level._effect[ "ai_dni_rez_out_arm_left" ], self, "j_shoulder_le" );
    playfxontag( localclientnum, level._effect[ "ai_dni_rez_out_arm_right" ], self, "j_elbow_ri" );
    playfxontag( localclientnum, level._effect[ "ai_dni_rez_out_arm_right" ], self, "j_shoulder_ri" );
    playfxontag( localclientnum, level._effect[ "ai_dni_rez_out_head" ], self, "j_head" );
    playfxontag( localclientnum, level._effect[ "ai_dni_rez_out_hip_left" ], self, "j_hip_le" );
    playfxontag( localclientnum, level._effect[ "ai_dni_rez_out_hip_right" ], self, "j_hip_ri" );
    playfxontag( localclientnum, level._effect[ "ai_dni_rez_out_leg_left" ], self, "j_knee_le" );
    playfxontag( localclientnum, level._effect[ "ai_dni_rez_out_leg_right" ], self, "j_knee_ri" );
    playfxontag( localclientnum, level._effect[ "ai_dni_rez_out_torso" ], self, "j_spine4" );
    playfxontag( localclientnum, level._effect[ "ai_dni_rez_out_waist" ], self, "j_spinelower" );
}

