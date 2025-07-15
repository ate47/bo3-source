#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;

#namespace zm_tomb_capture_zones;

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x8e09bc50, Offset: 0xe18
// Size: 0x59c
function init_structs()
{
    level.zombie_custom_riser_fx_handler = &function_5f50cf29;
    level.var_d7512031 = 0;
    clientfield::register( "world", "packapunch_anim", 21000, 3, "int", &play_pap_anim, 0, 0 );
    clientfield::register( "actor", "zone_capture_zombie", 21000, 1, "int", &function_a412a80d, 0, 0 );
    clientfield::register( "scriptmover", "zone_capture_emergence_hole", 21000, 1, "int", &function_be0738b1, 0, 0 );
    clientfield::register( "world", "zc_change_progress_bar_color", 21000, 1, "int", &zm_utility::setsharedinventoryuimodels, 0, 0 );
    clientfield::register( "world", "zone_capture_hud_all_generators_captured", 21000, 1, "int", &function_ac197e52, 0, 1 );
    setupclientfieldcodecallbacks( "world", 1, "zone_capture_hud_all_generators_captured" );
    clientfield::register( "world", "pap_monolith_ring_shake", 21000, 1, "counter", &pap_monolith_ring_shake, 0, 0 );
    clientfield::register( "world", "zone_capture_perk_machine_smoke_fx_always_on", 21000, 1, "int", &function_daf4318, 0, 0 );
    clientfield::register( "clientuimodel", "zmInventory.capture_generator_wheel_widget", 21000, 1, "int", undefined, 0, 0 );
    clientfield::register( "zbarrier", "pap_emissive_fx", 21000, 1, "int", &pap_emissive_fx, 0, 0 );
    a_s_generator = struct::get_array( "s_generator", "targetname" );
    
    foreach ( struct in a_s_generator )
    {
        clientfield::register( "world", struct.script_noteworthy, 21000, 7, "float", &function_a6f34d1c, 0, 0 );
        clientfield::register( "world", "state_" + struct.script_noteworthy, 21000, 3, "int", &function_d56a2c4b, 0, 0 );
        clientfield::register( "world", "zone_capture_hud_generator_" + struct.script_int, 21000, 2, "int", &zm_utility::setsharedinventoryuimodels, 0, 0 );
        clientfield::register( "world", "zone_capture_monolith_crystal_" + struct.script_int, 21000, 1, "int", &function_54aa6e5c, 0, 0 );
        clientfield::register( "world", "zone_capture_perk_machine_smoke_fx_" + struct.script_int, 21000, 1, "int", &function_6543186c, 0, 0 );
        setupclientfieldcodecallbacks( "world", 1, "zone_capture_hud_generator_" + struct.script_int );
    }
    
    level._effect[ "zone_capture_damage_spark" ] = "dlc5/tomb/fx_tomb_mech_dmg_armor";
    level._effect[ "zone_capture_damage_steam" ] = "dlc1/castle/fx_mech_dmg_steam";
    level._effect[ "zone_capture_zombie_spawn" ] = "dlc5/tomb/fx_tomb_emergence_spawn";
    function_3ec54bc4();
    function_7cc68e33();
    function_a4e6d2a7();
}

// Namespace zm_tomb_capture_zones
// Params 7
// Checksum 0x153e6f17, Offset: 0x13c0
// Size: 0x84
function function_a6f34d1c( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    m_generator = function_f424a041( fieldname, localclientnum );
    m_generator function_c516c0e9( localclientnum, oldval, newval );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x1eba8555, Offset: 0x1450
// Size: 0x44
function function_c1a782c1()
{
    self clearanim( "p7_fxanim_zm_ori_generator_fluid_up_anim", 0 );
    self clearanim( "p7_fxanim_zm_ori_generator_fluid_down_anim", 0 );
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x1e0c8cc9, Offset: 0x14a0
// Size: 0xc4
function function_9c5303ba( var_ce864151 )
{
    if ( !isdefined( var_ce864151 ) )
    {
        var_ce864151 = 0;
    }
    
    n_blend_time = 0.2;
    
    if ( var_ce864151 )
    {
        n_blend_time = 0;
    }
    
    self clearanim( "p7_fxanim_zm_ori_generator_start_anim", n_blend_time );
    self clearanim( "p7_fxanim_zm_ori_generator_up_idle_anim", n_blend_time );
    self clearanim( "p7_fxanim_zm_ori_generator_down_idle_anim", n_blend_time );
    self clearanim( "p7_fxanim_zm_ori_generator_end_anim", n_blend_time );
}

// Namespace zm_tomb_capture_zones
// Params 3
// Checksum 0x26fa4447, Offset: 0x1570
// Size: 0x14c
function function_c516c0e9( localclientnumber, oldval, newval )
{
    if ( newval == 1 )
    {
        self clearanim( "p7_fxanim_zm_ori_generator_fluid_rotate_down_anim", 0.2 );
        self setanim( "p7_fxanim_zm_ori_generator_fluid_rotate_up_anim", 1, 0.2, 1 );
    }
    else if ( newval < oldval && oldval == 1 )
    {
        self clearanim( "p7_fxanim_zm_ori_generator_fluid_rotate_up_anim", 0.2 );
        self setanim( "p7_fxanim_zm_ori_generator_fluid_rotate_down_anim", 1, 0.2, 1 );
        wait getanimlength( "p7_fxanim_zm_ori_generator_fluid_rotate_down_anim" );
        self clearanim( "p7_fxanim_zm_ori_generator_fluid_rotate_down_anim", 0.2 );
    }
    
    self function_f937236c( newval );
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0x87093ba, Offset: 0x16c8
// Size: 0xbc
function function_f937236c( newval, var_ce864151 )
{
    if ( !isdefined( var_ce864151 ) )
    {
        var_ce864151 = 0;
    }
    
    n_blend_time = 0.2;
    
    if ( var_ce864151 )
    {
        n_blend_time = 0;
    }
    
    self setanim( "p7_fxanim_zm_ori_generator_fluid_up_anim", newval, n_blend_time, 1 );
    self setanim( "p7_fxanim_zm_ori_generator_fluid_down_anim", 1 - newval, n_blend_time, 1 );
    self function_7c4c8c42( newval );
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0x1d22ecc4, Offset: 0x1790
// Size: 0x176
function function_f424a041( str_name, localclientnumber )
{
    if ( !isdefined( level.var_92a1717d ) )
    {
        level.var_92a1717d = [];
    }
    
    if ( !isdefined( level.var_92a1717d[ localclientnumber ] ) )
    {
        level.var_92a1717d[ localclientnumber ] = [];
    }
    
    if ( !isdefined( level.var_92a1717d[ localclientnumber ][ str_name ] ) )
    {
        level.var_92a1717d[ localclientnumber ][ str_name ] = getent( localclientnumber, str_name, "targetname" );
    }
    
    assert( isdefined( level.var_92a1717d[ localclientnumber ][ str_name ] ), "<dev string:x28>" + str_name + "<dev string:x3d>" );
    level.var_92a1717d[ localclientnumber ][ str_name ] util::waittill_dobj( localclientnumber );
    
    if ( !level.var_92a1717d[ localclientnumber ][ str_name ] hasanimtree() )
    {
        level.var_92a1717d[ localclientnumber ][ str_name ] useanimtree( $generic );
    }
    
    return level.var_92a1717d[ localclientnumber ][ str_name ];
}

// Namespace zm_tomb_capture_zones
// Params 7
// Checksum 0x7ee2409a, Offset: 0x1910
// Size: 0x23a
function function_d56a2c4b( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    m_generator = function_f424a041( getsubstr( fieldname, 6 ), localclientnum );
    
    if ( newval == 6 )
    {
        m_generator function_bbdb6db3( localclientnum );
        return;
    }
    
    n_blend_time = 0.2;
    
    if ( bnewent || binitialsnap || bwasdemojump )
    {
        n_blend_time = 0;
    }
    
    m_generator function_9c5303ba();
    m_generator notify( #"hash_a7f9aff7" );
    
    if ( newval != 0 )
    {
        m_generator thread function_d66ac605( localclientnum );
    }
    
    switch ( newval )
    {
        case 0:
            m_generator generator_state_off( localclientnum, n_blend_time );
            break;
        case 1:
            m_generator generator_state_turn_on( localclientnum, n_blend_time );
            break;
        case 2:
            m_generator generator_state_power_up( localclientnum, n_blend_time );
            break;
        case 3:
            m_generator generator_state_power_down( localclientnum, n_blend_time );
            break;
        case 5:
            m_generator function_3414585a( localclientnum, n_blend_time );
            break;
        case 4:
            m_generator generator_state_turn_off( localclientnum, n_blend_time );
            break;
        default:
            break;
    }
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x1789777e, Offset: 0x1b58
// Size: 0x68
function function_d66ac605( localclientnumber )
{
    self endon( #"entityshutdown" );
    self.var_c4cb7bc3 = 1;
    
    while ( isdefined( self.var_c4cb7bc3 ) && self.var_c4cb7bc3 )
    {
        playrumbleonposition( localclientnumber, "generator_active", self.origin );
        wait 0.3;
    }
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0x59bf9a1e, Offset: 0x1bc8
// Size: 0x8c
function generator_state_off( localclientnumber, n_blend_time )
{
    self.var_c4cb7bc3 = 0;
    self function_71e86201();
    self mapshaderconstant( localclientnumber, 0, "ScriptVector2", 0, 0, 0, 0 );
    self function_312726e4( localclientnumber );
    self thread function_7be891d1( localclientnumber );
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0xf064b92d, Offset: 0x1c60
// Size: 0x94
function generator_state_turn_on( localclientnumber, n_blend_time )
{
    self setanim( "p7_fxanim_zm_ori_generator_start_anim", 1, n_blend_time, 1 );
    self mapshaderconstant( localclientnumber, 0, "ScriptVector2", 0, 1, 0, 0 );
    self function_f6af797d( localclientnumber );
    self function_3f53e168( localclientnumber );
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0xb82ce97d, Offset: 0x1d00
// Size: 0x94
function generator_state_power_up( localclientnumber, n_blend_time )
{
    self setanim( "p7_fxanim_zm_ori_generator_up_idle_anim", 1, n_blend_time, 1 );
    self mapshaderconstant( localclientnumber, 0, "ScriptVector2", 0, 1, 0, 0 );
    self function_f6af797d( localclientnumber );
    self function_3f53e168( localclientnumber );
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0x4782384c, Offset: 0x1da0
// Size: 0x64
function generator_state_power_down( localclientnumber, n_blend_time )
{
    self setanim( "p7_fxanim_zm_ori_generator_down_idle_anim", 1, n_blend_time, 1 );
    self mapshaderconstant( localclientnumber, 0, "ScriptVector2", 0, 1, 0, 0 );
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0x37bca49e, Offset: 0x1e10
// Size: 0x4c
function function_3414585a( localclientnumber, n_blend_time )
{
    self generator_state_power_down( localclientnumber, n_blend_time );
    self function_c1810bcc( localclientnumber );
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x2b919d00, Offset: 0x1e68
// Size: 0x3c
function function_c1810bcc( localclientnumber )
{
    self thread function_8daa207b( localclientnumber );
    self thread function_afe4ef7e( localclientnumber );
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xa562114a, Offset: 0x1eb0
// Size: 0x108
function function_8daa207b( localclientnumber )
{
    self notify( #"hash_74845d8b" );
    self endon( #"hash_74845d8b" );
    self endon( #"hash_a0c3abea" );
    
    if ( !isdefined( self.var_25ac834 ) )
    {
        self.var_25ac834 = [];
    }
    
    a_tags = array( "fx_side_exhaust01", "fx_frnt_exhaust", "fx_side_exhaust02", "j_piston_01" );
    
    while ( true )
    {
        self.var_25ac834[ localclientnumber ] = playfxontag( localclientnumber, level._effect[ "zone_capture_damage_spark" ], self, array::random( a_tags ) );
        wait randomfloatrange( 0.15, 0.35 );
    }
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x93591b35, Offset: 0x1fc0
// Size: 0x108
function function_afe4ef7e( localclientnumber )
{
    self notify( #"hash_e3f7fe2e" );
    self endon( #"hash_e3f7fe2e" );
    self endon( #"hash_a0c3abea" );
    
    if ( !isdefined( self.var_9fe4037d ) )
    {
        self.var_9fe4037d = [];
    }
    
    a_tags = array( "fx_side_exhaust01", "fx_frnt_exhaust", "fx_side_exhaust02", "j_piston_01" );
    
    while ( true )
    {
        self.var_9fe4037d[ localclientnumber ] = playfxontag( localclientnumber, level._effect[ "zone_capture_damage_steam" ], self, array::random( a_tags ) );
        wait randomfloatrange( 0.25, 0.35 );
    }
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x8905683f, Offset: 0x20d0
// Size: 0xac
function function_501771e3( localclientnumber )
{
    self notify( #"hash_a0c3abea" );
    
    if ( isdefined( self.var_25ac834 ) && isdefined( self.var_25ac834[ localclientnumber ] ) )
    {
        deletefx( localclientnumber, self.var_25ac834[ localclientnumber ], 1 );
    }
    
    if ( isdefined( self.var_9fe4037d ) && isdefined( self.var_9fe4037d[ localclientnumber ] ) )
    {
        deletefx( localclientnumber, self.var_9fe4037d[ localclientnumber ], 1 );
    }
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x8cca09c, Offset: 0x2188
// Size: 0x1a2
function function_bbdb6db3( localclientnumber )
{
    if ( !isdefined( self.var_244ac37 ) )
    {
        self.var_244ac37 = [];
    }
    
    if ( isdefined( self.var_244ac37[ localclientnumber ] ) )
    {
        stopfx( localclientnumber, self.var_244ac37[ localclientnumber ] );
    }
    
    var_a1c15b1a = self.targetname;
    var_2a0fd09 = undefined;
    
    switch ( var_a1c15b1a )
    {
        case "generator_start_bunker":
            var_2a0fd09 = level._effect[ "capture_complete_1" ];
            break;
        case "generator_tank_trench":
            var_2a0fd09 = level._effect[ "capture_complete_2" ];
            break;
        case "generator_mid_trench":
            var_2a0fd09 = level._effect[ "capture_complete_3" ];
            break;
        case "generator_nml_right":
            var_2a0fd09 = level._effect[ "capture_complete_4" ];
            break;
        case "generator_nml_left":
            var_2a0fd09 = level._effect[ "capture_complete_5" ];
            break;
        case "generator_church":
            var_2a0fd09 = level._effect[ "capture_complete_6" ];
            break;
        default:
            return;
    }
    
    self.var_244ac37[ localclientnumber ] = playfxontag( localclientnumber, var_2a0fd09, self, "j_generator_pole" );
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0x469960c6, Offset: 0x2338
// Size: 0x94
function generator_state_turn_off( localclientnumber, n_blend_time )
{
    self setanim( "p7_fxanim_zm_ori_generator_end_anim", 1, n_blend_time, 1 );
    self mapshaderconstant( localclientnumber, 0, "ScriptVector2", 0, 0, 0, 0 );
    self function_312726e4( localclientnumber );
    self thread function_7be891d1( localclientnumber );
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x3bcd1a58, Offset: 0x23d8
// Size: 0x16c
function function_7c4c8c42( newval )
{
    if ( !isdefined( self.var_be886049 ) )
    {
        sndorigin = self gettagorigin( "j_generator_pole" );
        self.var_be886049 = spawn( 0, sndorigin, "script_origin" );
        self.var_be886049 linkto( self, "j_generator_pole" );
        playsound( 0, "zmb_capturezone_donut_start", self.origin );
        self.var_be886049 thread function_3a4d4e97();
    }
    
    pitch = audio::scale_speed( 0, 1, 0.8, 1.6, newval );
    loop_id = self.var_be886049 playloopsound( "zmb_capturezone_rise", 1 );
    setsoundpitch( loop_id, pitch );
    self function_738a49be( 1 );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xab9939ad, Offset: 0x2550
// Size: 0x6c
function function_71e86201()
{
    if ( isdefined( self.var_ffb79f2 ) )
    {
        playsound( 0, "zmb_capturezone_donut_stop", self.origin );
        self.var_be886049 delete();
        self.var_be886049 = undefined;
    }
    
    self function_738a49be( 0 );
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x894df69c, Offset: 0x25c8
// Size: 0x26a
function function_f6af797d( localclientnumber )
{
    self function_312726e4( localclientnumber );
    var_a1c15b1a = self.targetname;
    var_2a0fd09 = undefined;
    
    switch ( var_a1c15b1a )
    {
        case "generator_start_bunker":
            var_2a0fd09 = level._effect[ "capture_progression_1" ];
            break;
        case "generator_tank_trench":
            var_2a0fd09 = level._effect[ "capture_progression_2" ];
            break;
        case "generator_mid_trench":
            var_2a0fd09 = level._effect[ "capture_progression_3" ];
            break;
        case "generator_nml_right":
            var_2a0fd09 = level._effect[ "capture_progression_4" ];
            break;
        case "generator_nml_left":
            var_2a0fd09 = level._effect[ "capture_progression_5" ];
            break;
        case "generator_church":
            var_2a0fd09 = level._effect[ "capture_progression_6" ];
            break;
        default:
            return;
    }
    
    self.var_244ac37[ localclientnumber ] = playfxontag( localclientnumber, var_2a0fd09, self, "j_generator_pole" );
    self.var_878c304c[ localclientnumber ] = playfxontag( localclientnumber, level._effect[ "capture_exhaust_front" ], self, "fx_frnt_exhaust" );
    self.var_7078bcfd[ localclientnumber ] = playfxontag( localclientnumber, level._effect[ "capture_exhaust_rear" ], self, "fx_rear_exhaust" );
    self.var_eb98b036[ localclientnumber ] = playfxontag( localclientnumber, level._effect[ "capture_exhaust_side" ], self, "fx_vat_exhaust01" );
    self.var_c59635cd[ localclientnumber ] = playfxontag( localclientnumber, level._effect[ "capture_exhaust_side" ], self, "fx_vat_exhaust02" );
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xe39f3e97, Offset: 0x2840
// Size: 0x1b4
function function_312726e4( localclientnumber )
{
    if ( !isdefined( self.var_244ac37 ) )
    {
        self.var_244ac37 = [];
    }
    
    if ( isdefined( self.var_244ac37[ localclientnumber ] ) )
    {
        stopfx( localclientnumber, self.var_244ac37[ localclientnumber ] );
    }
    
    if ( !isdefined( self.var_878c304c ) )
    {
        self.var_878c304c = [];
    }
    
    if ( !isdefined( self.var_7078bcfd ) )
    {
        self.var_7078bcfd = [];
    }
    
    if ( !isdefined( self.var_eb98b036 ) )
    {
        self.var_eb98b036 = [];
    }
    
    if ( !isdefined( self.var_c59635cd ) )
    {
        self.var_c59635cd = [];
    }
    
    if ( isdefined( self.var_878c304c[ localclientnumber ] ) )
    {
        stopfx( localclientnumber, self.var_878c304c[ localclientnumber ] );
    }
    
    if ( isdefined( self.var_7078bcfd[ localclientnumber ] ) )
    {
        stopfx( localclientnumber, self.var_7078bcfd[ localclientnumber ] );
    }
    
    if ( isdefined( self.var_eb98b036[ localclientnumber ] ) )
    {
        stopfx( localclientnumber, self.var_eb98b036[ localclientnumber ] );
    }
    
    if ( isdefined( self.var_c59635cd[ localclientnumber ] ) )
    {
        stopfx( localclientnumber, self.var_c59635cd[ localclientnumber ] );
    }
    
    self function_501771e3( localclientnumber );
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x107883d0, Offset: 0x2a00
// Size: 0x5c
function function_3f53e168( localclientnumber )
{
    if ( !isdefined( self.var_88677912 ) )
    {
        self.var_88677912 = [];
    }
    
    if ( isdefined( self.var_88677912[ localclientnumber ] ) )
    {
        deletefx( localclientnumber, self.var_88677912[ localclientnumber ], 1 );
    }
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xb177adb6, Offset: 0x2a68
// Size: 0x6a
function function_7be891d1( localclientnumber )
{
    self endon( #"hash_a7f9aff7" );
    self function_3f53e168( localclientnumber );
    self.var_88677912[ localclientnumber ] = playfxontag( localclientnumber, level._effect[ "zapper_light_notready" ], self, "tag_pole_top" );
}

// Namespace zm_tomb_capture_zones
// Params 5
// Checksum 0x95dd005a, Offset: 0x2ae0
// Size: 0xcc
function scale_speed( x1, x2, y1, y2, z )
{
    if ( z < x1 )
    {
        z = x1;
    }
    
    if ( z > x2 )
    {
        z = x2;
    }
    
    dx = x2 - x1;
    n = ( z - x1 ) / dx;
    dy = y2 - y1;
    w = n * dy + y1;
    return w;
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x20cb5bb0, Offset: 0x2bb8
// Size: 0x120
function function_738a49be( start )
{
    if ( !isdefined( self.var_f2b9c979 ) )
    {
        self.var_f2b9c979 = 0;
    }
    
    origin1 = self gettagorigin( "vat_01_sound" );
    origin2 = self gettagorigin( "vat_02_sound" );
    
    if ( start )
    {
        if ( !self.var_f2b9c979 )
        {
            audio::playloopat( "zmb_capturezone_vat_loop", origin1 );
            audio::playloopat( "zmb_capturezone_vat_loop", origin2 );
            self.var_f2b9c979 = 1;
        }
        
        return;
    }
    
    audio::stoploopat( "zmb_capturezone_vat_loop", origin1 );
    audio::stoploopat( "zmb_capturezone_vat_loop", origin2 );
    self.var_f2b9c979 = 0;
}

// Namespace zm_tomb_capture_zones
// Params 7
// Checksum 0x20aeba8, Offset: 0x2ce0
// Size: 0x1d4
function function_54aa6e5c( localclientnumber, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    var_a0a565ad = function_24fcf23b( fieldname, localclientnumber );
    str_exploder = "fxexp_" + level.var_6aec00d3[ fieldname ];
    
    if ( newval )
    {
        var_a0a565ad thread function_59c8afc0( localclientnumber, 0, 0.1, 2, 4, 0.5, 3 );
        var_a0a565ad stoploopsound( 1 );
        exploder::stop_exploder( str_exploder, localclientnumber );
        level thread function_31e3b463( 0, level.var_6aec00d3[ fieldname ] );
        return;
    }
    
    var_a0a565ad thread function_59c8afc0( localclientnumber, 0.65, 1, 0.7, 1, 0.05, 0.35 );
    var_a0a565ad playloopsound( "amb_monolith_glow" );
    exploder::exploder( str_exploder, localclientnumber );
    level thread function_31e3b463( 1, level.var_6aec00d3[ fieldname ] );
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0xabea51af, Offset: 0x2ec0
// Size: 0x14
function function_31e3b463( play, num )
{
    
}

// Namespace zm_tomb_capture_zones
// Params 7
// Checksum 0xdd0cb07c, Offset: 0x2ee0
// Size: 0x1b0
function function_59c8afc0( localclientnumber, var_98ce6736, var_4333264, var_e2ad4e8e, var_22a5887c, var_48d50352, var_d056f9f8 )
{
    self notify( #"hash_c0d7e9d" );
    self endon( #"hash_c0d7e9d" );
    
    if ( !isdefined( self.var_40a6544d ) )
    {
        self.var_40a6544d = var_98ce6736;
    }
    
    while ( true )
    {
        var_68feedab = randomfloatrange( var_98ce6736, var_4333264 );
        n_transition_time = randomfloatrange( var_e2ad4e8e, var_22a5887c );
        n_steps = int( n_transition_time / 0.016 );
        var_5885a5c5 = ( var_68feedab - self.var_40a6544d ) / n_steps;
        
        for ( i = 0; i < n_steps ; i++ )
        {
            self.var_40a6544d += var_5885a5c5;
            self mapshaderconstant( localclientnumber, 2, "scriptVector2", self.var_40a6544d, 0, 0, 0 );
            wait 0.016;
        }
        
        wait randomfloatrange( var_48d50352, var_d056f9f8 );
    }
}

// Namespace zm_tomb_capture_zones
// Params 3
// Checksum 0xc3e22af7, Offset: 0x3098
// Size: 0x116
function function_217d24cd( localclientnumber, var_68feedab, n_transition_time )
{
    self notify( #"hash_c0d7e9d" );
    self endon( #"hash_c0d7e9d" );
    
    if ( !isdefined( self.var_40a6544d ) )
    {
        self.var_40a6544d = 1;
    }
    
    n_steps = int( n_transition_time / 0.016 );
    var_5885a5c5 = ( var_68feedab - self.var_40a6544d ) / n_steps;
    
    for ( i = 0; i < n_steps ; i++ )
    {
        self.var_40a6544d += var_5885a5c5;
        self mapshaderconstant( localclientnumber, 2, "scriptVector2", self.var_40a6544d, 0, 0, 0 );
        wait 0.016;
    }
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0xfdd0c945, Offset: 0x31b8
// Size: 0x1de
function function_24fcf23b( str_targetname, localclientnum )
{
    if ( !isdefined( level.var_4cb39fae ) )
    {
        level.var_4cb39fae = [];
    }
    
    if ( !isdefined( level.var_4cb39fae[ localclientnum ] ) )
    {
        level.var_4cb39fae[ localclientnum ] = [];
    }
    
    if ( !isdefined( level.var_4cb39fae[ localclientnum ][ str_targetname ] ) )
    {
        level.var_4cb39fae[ localclientnum ][ str_targetname ] = getent( localclientnum, str_targetname, "targetname" );
        level.var_4cb39fae[ localclientnum ][ str_targetname ].var_8d2380bb = [];
        level.var_4cb39fae[ localclientnum ][ str_targetname ].var_8d2380bb[ localclientnum ] = 0;
    }
    
    level.var_4cb39fae[ localclientnum ][ str_targetname ] util::waittill_dobj( localclientnum );
    
    if ( !level.var_4cb39fae[ localclientnum ][ str_targetname ].var_8d2380bb[ localclientnum ] )
    {
        level.var_4cb39fae[ localclientnum ][ str_targetname ] mapshaderconstant( localclientnum, 2, "scriptVector2", 0 );
        level.var_4cb39fae[ localclientnum ][ str_targetname ].var_8d2380bb[ localclientnum ] = 1;
    }
    
    assert( isdefined( level.var_4cb39fae[ localclientnum ][ str_targetname ] ), "<dev string:x28>" + str_targetname + "<dev string:x71>" );
    return level.var_4cb39fae[ localclientnum ][ str_targetname ];
}

// Namespace zm_tomb_capture_zones
// Params 7
// Checksum 0x64b4d5ba, Offset: 0x33a0
// Size: 0x194
function function_ac197e52( localclientnumber, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    m_ring = function_12a07195( localclientnumber );
    
    if ( isdefined( m_ring ) )
    {
        if ( newval )
        {
            m_ring thread function_aab40f28( localclientnumber, 3 );
            m_ring thread function_f35264ff();
        }
        else
        {
            m_ring thread function_aab40f28( localclientnumber, 0 );
            m_ring thread function_3f73ddc3( oldval );
        }
    }
    
    var_82347477 = function_cd49ce76( localclientnumber );
    
    if ( isdefined( var_82347477 ) )
    {
        if ( newval )
        {
            var_82347477 thread function_59c8afc0( localclientnumber, 0.65, 1, 0.7, 1, 0.05, 0.35 );
            return;
        }
        
        var_82347477 show();
        var_82347477 thread function_217d24cd( localclientnumber, 0, 5 );
    }
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x97de2781, Offset: 0x3540
// Size: 0x54
function function_9164d089( localclientnumber )
{
    var_82347477 = function_cd49ce76( localclientnumber );
    
    if ( isdefined( var_82347477 ) )
    {
        var_82347477 hide();
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x342547da, Offset: 0x35a0
// Size: 0xf0
function function_f35264ff()
{
    self notify( #"hash_3b22402e" );
    self endon( #"hash_765cfe11" );
    self function_4f226940();
    self setanim( %generic::p7_fxanim_zm_ori_monolith_inductor_pull_anim, 1, 0.2 );
    wait getanimlength( %generic::p7_fxanim_zm_ori_monolith_inductor_pull_anim ) - 0.2;
    self clearanim( %generic::p7_fxanim_zm_ori_monolith_inductor_pull_anim, 0.2 );
    self setanim( %generic::p7_fxanim_zm_ori_monolith_inductor_pull_idle_anim, 1, 0.2 );
    level.var_d7512031 = 1;
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xf52f364b, Offset: 0x3698
// Size: 0xf0
function function_3f73ddc3( oldval )
{
    self notify( #"hash_765cfe11" );
    self endon( #"hash_3b22402e" );
    self function_4f226940();
    
    if ( oldval )
    {
        self setanim( %generic::p7_fxanim_zm_ori_monolith_inductor_release_anim, 1, 0.2 );
        wait getanimlength( %generic::p7_fxanim_zm_ori_monolith_inductor_release_anim ) - 0.2;
        self function_4f226940();
    }
    
    self setanim( %generic::p7_fxanim_zm_ori_monolith_inductor_idle_anim, 1, 0.2 );
    level.var_d7512031 = 0;
}

// Namespace zm_tomb_capture_zones
// Params 7
// Checksum 0x4a0e125a, Offset: 0x3790
// Size: 0x1ec
function pap_monolith_ring_shake( localclientnumber, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    m_ring = function_12a07195( localclientnumber );
    m_ring endon( #"hash_3b22402e" );
    
    if ( newval == 1 )
    {
        m_ring function_4f226940();
        m_ring setanim( %generic::p7_fxanim_zm_ori_monolith_inductor_shake_anim, 1, 0.2 );
        wait getanimlength( %generic::p7_fxanim_zm_ori_monolith_inductor_shake_anim ) - 0.2;
        m_ring clearanim( %generic::p7_fxanim_zm_ori_monolith_inductor_shake_anim, 0.2 );
        
        if ( level.var_d7512031 )
        {
            m_ring setanim( %generic::p7_fxanim_zm_ori_monolith_inductor_pull_anim, 1, 0.2 );
            wait getanimlength( %generic::p7_fxanim_zm_ori_monolith_inductor_pull_anim ) - 0.2;
            m_ring clearanim( %generic::p7_fxanim_zm_ori_monolith_inductor_pull_anim, 0.2 );
            m_ring setanim( %generic::p7_fxanim_zm_ori_monolith_inductor_pull_idle_anim, 1, 0.2 );
            return;
        }
        
        m_ring thread function_3f73ddc3( 0 );
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x34e4441d, Offset: 0x3988
// Size: 0xcc
function function_4f226940()
{
    self clearanim( %generic::p7_fxanim_zm_ori_monolith_inductor_pull_anim, 0.2 );
    self clearanim( %generic::p7_fxanim_zm_ori_monolith_inductor_pull_idle_anim, 0.2 );
    self clearanim( %generic::p7_fxanim_zm_ori_monolith_inductor_release_anim, 0.2 );
    self clearanim( %generic::p7_fxanim_zm_ori_monolith_inductor_shake_anim, 0.2 );
    self clearanim( %generic::p7_fxanim_zm_ori_monolith_inductor_idle_anim, 0.2 );
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0x8f5aa8da, Offset: 0x3a60
// Size: 0x148
function function_aab40f28( localclientnumber, n_value )
{
    self notify( #"hash_c6efbac2" );
    self endon( #"hash_c6efbac2" );
    
    if ( !isdefined( self.var_40a6544d ) )
    {
        self.var_40a6544d = [];
    }
    
    if ( !isdefined( self.var_40a6544d[ localclientnumber ] ) )
    {
        self.var_40a6544d[ localclientnumber ] = 0;
    }
    
    n_delta = n_value - self.var_40a6544d[ localclientnumber ];
    n_increment = n_delta / 4.5 * 0.016;
    
    while ( self.var_40a6544d[ localclientnumber ] != n_value )
    {
        self.var_40a6544d[ localclientnumber ] = math::clamp( self.var_40a6544d[ localclientnumber ] + n_increment, 0, 3 );
        self mapshaderconstant( localclientnumber, 3, "scriptVector2", 0, self.var_40a6544d[ localclientnumber ], 0, 0 );
        wait 0.016;
    }
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xb0dbebb0, Offset: 0x3bb0
// Size: 0x118
function function_12a07195( localclientnumber )
{
    if ( !isdefined( level.var_9920ede0 ) )
    {
        level.var_9920ede0 = [];
    }
    
    if ( !isdefined( level.var_9920ede0[ localclientnumber ] ) )
    {
        level.var_9920ede0[ localclientnumber ] = getent( localclientnumber, "pap_monolith_ring", "targetname" );
    }
    
    level.var_9920ede0[ localclientnumber ] util::waittill_dobj( localclientnumber );
    
    if ( !level.var_9920ede0[ localclientnumber ] hasanimtree() )
    {
        level.var_9920ede0[ localclientnumber ] mapshaderconstant( localclientnumber, 3, "scriptVector2", 0, 0, 0, 0 );
        level.var_9920ede0[ localclientnumber ] useanimtree( $generic );
    }
    
    return level.var_9920ede0[ localclientnumber ];
}

// Namespace zm_tomb_capture_zones
// Params 7
// Checksum 0x358b24e6, Offset: 0x3cd0
// Size: 0xc4
function function_be0738b1( localclientnumber, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( newval )
    {
        self emergence_hole_spawn( localclientnumber );
        return;
    }
    
    var_4478dceb = self function_45d7dc5a( localclientnumber, oldval && !bnewent && !bwasdemojump );
    self function_345cde91( localclientnumber, var_4478dceb );
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xd511d2d2, Offset: 0x3da0
// Size: 0x144
function emergence_hole_spawn( localclientnumber )
{
    self function_345cde91( localclientnumber );
    self.var_a326f0e[ localclientnumber ] = playfxontag( localclientnumber, level._effect[ "tesla_elec_kill" ], self, "tag_origin" );
    self.var_70ef4eef[ localclientnumber ] = playfxontag( localclientnumber, level._effect[ "screecher_hole" ], self, "tag_origin" );
    
    if ( !isdefined( self.sndent ) )
    {
        self.sndent = spawn( localclientnumber, self.origin, "script_origin" );
        self.sndent thread function_3a4d4e97();
    }
    
    self.sndent playloopsound( "zmb_capturezone_portal_loop", 2 );
    playsound( localclientnumber, "zmb_capturezone_portal_start", self.origin );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xc88ca6a6, Offset: 0x3ef0
// Size: 0x34
function function_3a4d4e97()
{
    self endon( #"entityshutdown" );
    level waittill( #"demo_jump" );
    self delete();
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0x3109b476, Offset: 0x3f30
// Size: 0x82, Type: bool
function function_45d7dc5a( localclientnumber, var_4f49ffe0 )
{
    if ( var_4f49ffe0 )
    {
        var_4478dceb = 0;
        playfxontag( localclientnumber, level._effect[ "tesla_elec_kill" ], self, "tag_origin" );
        playsound( localclientnumber, "zmb_capturezone_portal_stop" );
    }
    
    return !var_4f49ffe0;
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0xeb2a52f0, Offset: 0x3fc0
// Size: 0x174
function function_345cde91( localclientnumber, var_4478dceb )
{
    if ( !isdefined( var_4478dceb ) )
    {
        var_4478dceb = 1;
    }
    
    if ( !isdefined( self.var_a326f0e ) )
    {
        self.var_a326f0e = [];
    }
    
    if ( !isdefined( self.var_70ef4eef ) )
    {
        self.var_70ef4eef = [];
    }
    
    if ( !isdefined( self.var_6ecbad39 ) )
    {
        self.var_6ecbad39 = [];
    }
    
    if ( isdefined( self.var_70ef4eef[ localclientnumber ] ) )
    {
        deletefx( localclientnumber, self.var_a326f0e[ localclientnumber ], 1 );
        self.var_a326f0e[ localclientnumber ] = undefined;
    }
    
    if ( isdefined( self.var_70ef4eef[ localclientnumber ] ) )
    {
        deletefx( localclientnumber, self.var_70ef4eef[ localclientnumber ], 1 );
        self.var_70ef4eef[ localclientnumber ] = undefined;
    }
    
    if ( var_4478dceb )
    {
        if ( isdefined( self.var_6ecbad39[ localclientnumber ] ) )
        {
            deletefx( localclientnumber, self.var_6ecbad39[ localclientnumber ], 1 );
            self.var_6ecbad39[ localclientnumber ] = undefined;
        }
    }
    
    if ( isdefined( self.sndent ) )
    {
        self.sndent delete();
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xe0e1518a, Offset: 0x4140
// Size: 0x92
function function_5f50cf29()
{
    if ( self._aitype === "zm_tomb_basic_zone_capture" )
    {
        s_info = spawnstruct();
        s_info.burst_fx = level._effect[ "zone_capture_zombie_spawn" ];
        s_info.billow_fx = level._effect[ "zone_capture_zombie_spawn" ];
        s_info.type = "none";
        return s_info;
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xcb24d87c, Offset: 0x41e0
// Size: 0x134
function function_7cc68e33()
{
    function_6784d594( 0, undefined, %generic::p7_fxanim_zm_ori_pack_return_pc1_anim );
    function_6784d594( 1, %generic::p7_fxanim_zm_ori_pack_pc1_anim, %generic::p7_fxanim_zm_ori_pack_return_pc2_anim );
    function_6784d594( 2, %generic::p7_fxanim_zm_ori_pack_pc2_anim, %generic::p7_fxanim_zm_ori_pack_return_pc3_anim );
    function_6784d594( 3, %generic::p7_fxanim_zm_ori_pack_pc3_anim, %generic::p7_fxanim_zm_ori_pack_return_pc4_anim );
    function_6784d594( 4, %generic::p7_fxanim_zm_ori_pack_pc4_anim, %generic::p7_fxanim_zm_ori_pack_return_pc5_anim );
    function_6784d594( 5, %generic::p7_fxanim_zm_ori_pack_pc5_anim, %generic::p7_fxanim_zm_ori_pack_return_pc6_anim );
    function_6784d594( 6, %generic::p7_fxanim_zm_ori_pack_pc6_anim, undefined );
}

// Namespace zm_tomb_capture_zones
// Params 7
// Checksum 0x8402969f, Offset: 0x4320
// Size: 0x326
function play_pap_anim( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    m_pap = function_cd49ce76( localclientnum );
    var_c0fc4c20 = bnewent || binitialsnap || bwasdemojump;
    
    if ( newval > oldval || var_c0fc4c20 )
    {
        for ( i = 1; i <= newval ; i++ )
        {
            n_anim_time = 1;
            n_anim_rate = 0;
            
            if ( i == newval && !var_c0fc4c20 )
            {
                n_anim_time = 0;
                n_anim_rate = 1;
            }
            
            var_f24fe15c = level.var_f983511b[ "disassemble" ][ i - 1 ];
            
            if ( isdefined( var_f24fe15c ) )
            {
                m_pap clearanim( var_f24fe15c, 0 );
            }
            
            var_c930c99 = level.var_f983511b[ "assemble" ][ i ];
            m_pap setanim( var_c930c99, 1, 0, n_anim_rate );
            m_pap setanimtime( var_c930c99, n_anim_time );
        }
        
        return;
    }
    
    if ( newval < oldval )
    {
        for ( i = level.var_f983511b[ "disassemble" ].size - 1; i >= newval ; i-- )
        {
            n_anim_time = 1;
            n_anim_rate = 0;
            
            if ( i == newval )
            {
                n_anim_time = 0;
                n_anim_rate = 1;
            }
            
            var_f24fe15c = level.var_f983511b[ "assemble" ][ i + 1 ];
            
            if ( isdefined( var_f24fe15c ) )
            {
                m_pap clearanim( var_f24fe15c, 0 );
            }
            
            var_653a11db = level.var_f983511b[ "disassemble" ][ i ];
            m_pap setanim( var_653a11db, 1, n_anim_time, n_anim_rate );
            m_pap setanimtime( var_653a11db, n_anim_time );
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 3
// Checksum 0x24018a81, Offset: 0x4650
// Size: 0xc4
function function_6784d594( n_index, var_c930c99, var_653a11db )
{
    if ( !isdefined( level.var_f983511b ) )
    {
        level.var_f983511b = [];
    }
    
    if ( !isdefined( level.var_f983511b[ "assemble" ] ) )
    {
        level.var_f983511b[ "assemble" ] = [];
    }
    
    if ( !isdefined( level.var_f983511b[ "disassemble" ] ) )
    {
        level.var_f983511b[ "disassemble" ] = [];
    }
    
    level.var_f983511b[ "assemble" ][ n_index ] = var_c930c99;
    level.var_f983511b[ "disassemble" ][ n_index ] = var_653a11db;
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x1dfaf84a, Offset: 0x4720
// Size: 0x118
function function_cd49ce76( localclientnumber )
{
    if ( !isdefined( level.var_6a68eb65 ) )
    {
        level.var_6a68eb65 = [];
    }
    
    if ( !isdefined( level.var_6a68eb65[ localclientnumber ] ) )
    {
        level.var_6a68eb65[ localclientnumber ] = getent( localclientnumber, "pap_cs", "targetname" );
    }
    
    level.var_6a68eb65[ localclientnumber ] util::waittill_dobj( localclientnumber );
    
    if ( !level.var_6a68eb65[ localclientnumber ] hasanimtree() )
    {
        level.var_6a68eb65[ localclientnumber ] useanimtree( $generic );
        level.var_6a68eb65[ localclientnumber ] mapshaderconstant( localclientnumber, 2, "ScriptVector0", 1 );
    }
    
    return level.var_6a68eb65[ localclientnumber ];
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xe7ada483, Offset: 0x4840
// Size: 0x7a
function function_902e1a6d()
{
    util::waitforallclients();
    a_players = getlocalplayers();
    
    for ( localclientnum = 0; localclientnum < a_players.size ; localclientnum++ )
    {
        var_3fe0feb2 = function_cd49ce76( localclientnum );
    }
}

// Namespace zm_tomb_capture_zones
// Params 7
// Checksum 0xb60dd6ed, Offset: 0x48c8
// Size: 0xe4
function function_a412a80d( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( newval )
    {
        self._aitype = "zm_tomb_basic_zone_capture";
        self thread zm::handle_zombie_risers( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump );
        self._eyeglow_fx_override = level._effect[ "crusader_zombie_eyes" ];
        self zm::deletezombieeyes( localclientnum );
        self zm::createzombieeyes( localclientnum );
        self function_82ce76c3( localclientnum );
    }
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xe240295d, Offset: 0x49b8
// Size: 0xfc
function function_82ce76c3( localclientnumber )
{
    self function_b031f5ce( localclientnumber );
    self.var_3199f723[ localclientnumber ] = playfxontag( localclientnumber, level._effect[ "zone_capture_zombie_torso_fx" ], self, "J_Spine4" );
    
    if ( !isdefined( self.sndent ) )
    {
        self.sndent = spawn( 0, self.origin, "script_origin" );
        self.sndent linkto( self );
        self thread snddeleteent( self.sndent );
    }
    
    self.sndent playloopsound( "zmb_capturezone_zombie_loop", 1 );
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x501e2868, Offset: 0x4ac0
// Size: 0x54
function snddeleteent( ent )
{
    self util::waittill_any( "death", "entityshutdown" );
    
    if ( isdefined( ent ) )
    {
        ent delete();
    }
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xbc20094f, Offset: 0x4b20
// Size: 0x5c
function function_b031f5ce( localclientnumber )
{
    if ( !isdefined( self.var_3199f723 ) )
    {
        self.var_3199f723 = [];
    }
    
    if ( isdefined( self.var_3199f723[ localclientnumber ] ) )
    {
        deletefx( localclientnumber, self.var_3199f723[ localclientnumber ], 1 );
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xcf826bc5, Offset: 0x4b88
// Size: 0xc4
function function_a4e6d2a7()
{
    function_eebeeca5( "zone_capture_monolith_crystal_1", 5001 );
    function_eebeeca5( "zone_capture_monolith_crystal_2", 5002 );
    function_eebeeca5( "zone_capture_monolith_crystal_3", 5003 );
    function_eebeeca5( "zone_capture_monolith_crystal_4", 5004 );
    function_eebeeca5( "zone_capture_monolith_crystal_5", 5005 );
    function_eebeeca5( "zone_capture_monolith_crystal_6", 5006 );
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0x9e9e38d3, Offset: 0x4c58
// Size: 0x52
function function_eebeeca5( str_field_name, n_exploder_id )
{
    if ( !isdefined( level.var_6aec00d3 ) )
    {
        level.var_6aec00d3 = [];
    }
    
    if ( !isdefined( level.var_6aec00d3[ str_field_name ] ) )
    {
        level.var_6aec00d3[ str_field_name ] = n_exploder_id;
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xfa41ac88, Offset: 0x4cb8
// Size: 0x84
function function_3ec54bc4()
{
    function_b27ab5bf( "zone_capture_perk_machine_smoke_fx_1", "revive_pipes" );
    function_b27ab5bf( "zone_capture_perk_machine_smoke_fx_3", "speedcola_pipes" );
    function_b27ab5bf( "zone_capture_perk_machine_smoke_fx_4", "jugg_pipes" );
    function_b27ab5bf( "zone_capture_perk_machine_smoke_fx_5", "staminup_pipes" );
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0xc18dd335, Offset: 0x4d48
// Size: 0x52
function function_b27ab5bf( str_field_name, var_4560e0ce )
{
    if ( !isdefined( level.var_2707a8c ) )
    {
        level.var_2707a8c = [];
    }
    
    if ( !isdefined( level.var_2707a8c[ str_field_name ] ) )
    {
        level.var_2707a8c[ str_field_name ] = var_4560e0ce;
    }
}

// Namespace zm_tomb_capture_zones
// Params 7
// Checksum 0xa2a1fc6f, Offset: 0x4da8
// Size: 0xec
function pap_emissive_fx( localclientnumber, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( newval == 1 )
    {
        self mapshaderconstant( localclientnumber, 0, "scriptVector2", 0, 1, 0, 0 );
        level thread function_9164d089( localclientnumber );
        return;
    }
    
    self mapshaderconstant( localclientnumber, 0, "scriptVector2", 0, 0, 0, 0 );
}

// Namespace zm_tomb_capture_zones
// Params 7
// Checksum 0x6c1bdc3a, Offset: 0x4ea0
// Size: 0x8c
function function_daf4318( localclientnumber, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( newval )
    {
        var_3aed1533 = struct::get( "mulekick_pipes", "targetname" );
        var_3aed1533 function_b64620a3( localclientnumber );
    }
}

// Namespace zm_tomb_capture_zones
// Params 7
// Checksum 0x3dba3ec9, Offset: 0x4f38
// Size: 0xb4
function function_6543186c( localclientnumber, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    var_d26305ae = function_23d70c75( fieldname );
    
    if ( isdefined( var_d26305ae ) )
    {
        if ( newval == 1 )
        {
            var_d26305ae function_b64620a3( localclientnumber );
            return;
        }
        
        var_d26305ae function_176e302e( localclientnumber );
    }
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xf6a439c7, Offset: 0x4ff8
// Size: 0xc2
function function_23d70c75( str_field_name )
{
    s_fx = undefined;
    
    if ( isdefined( level.var_2707a8c[ str_field_name ] ) )
    {
        if ( !isdefined( level.var_d5b89792 ) )
        {
            level.var_d5b89792 = [];
        }
        
        if ( !isdefined( level.var_d5b89792[ level.var_2707a8c[ str_field_name ] ] ) )
        {
            level.var_d5b89792[ level.var_2707a8c[ str_field_name ] ] = struct::get( level.var_2707a8c[ str_field_name ], "targetname" );
        }
        
        s_fx = level.var_d5b89792[ level.var_2707a8c[ str_field_name ] ];
    }
    
    return s_fx;
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x8ef1c42e, Offset: 0x50c8
// Size: 0x5c
function function_176e302e( localclientnumber )
{
    if ( !isdefined( self.a_fx ) )
    {
        self.a_fx = [];
    }
    
    if ( isdefined( self.a_fx[ localclientnumber ] ) )
    {
        deletefx( localclientnumber, self.a_fx[ localclientnumber ], 0 );
    }
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x628aa4f, Offset: 0x5130
// Size: 0x7a
function function_b64620a3( localclientnumber )
{
    self function_176e302e( localclientnumber );
    self.a_fx[ localclientnumber ] = playfx( localclientnumber, level._effect[ "perk_pipe_smoke" ], self.origin, anglestoforward( self.angles ) );
}

