#using scripts/cp/_load;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_lotus3_fx;
#using scripts/cp/cp_mi_cairo_lotus3_patch_c;
#using scripts/cp/cp_mi_cairo_lotus3_sound;
#using scripts/cp/lotus_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_cairo_lotus3;

// Namespace cp_mi_cairo_lotus3
// Params 0
// Checksum 0xfbcdfed1, Offset: 0x5d8
// Size: 0x94
function main()
{
    util::set_streamer_hint_function( &force_streamer, 4 );
    init_clientfields();
    cp_mi_cairo_lotus3_fx::main();
    cp_mi_cairo_lotus3_sound::main();
    load::main();
    util::waitforclient( 0 );
    cp_mi_cairo_lotus3_patch_c::function_7403e82b();
}

// Namespace cp_mi_cairo_lotus3
// Params 0
// Checksum 0xf5eb5cc9, Offset: 0x678
// Size: 0x28c
function init_clientfields()
{
    clientfield::register( "toplayer", "sand_fx", 1, 1, "int", &player_sand_fx_logic, 0, 0 );
    clientfield::register( "vehicle", "boss_left_outer_fx", 1, 1, "int", &function_9f0a1f48, 0, 0 );
    clientfield::register( "vehicle", "boss_left_inner_fx", 1, 1, "int", &function_260a2497, 0, 0 );
    clientfield::register( "vehicle", "boss_right_inner_fx", 1, 1, "int", &function_4be69226, 0, 0 );
    clientfield::register( "vehicle", "boss_right_outer_fx", 1, 1, "int", &function_47274359, 0, 0 );
    clientfield::register( "vehicle", "gunship_rumble_off", 1, 1, "int", &function_307fd74a, 0, 0 );
    clientfield::register( "vehicle", "play_raps_trail_fx", 1, 1, "int", &function_66f3947f, 0, 0 );
    clientfield::register( "world", "t2a_paper_burst", 1, 1, "int", &function_1be9086e, 0, 0 );
    clientfield::register( "world", "city_sky", 1, 1, "int", &function_3b5052db, 0, 0 );
}

// Namespace cp_mi_cairo_lotus3
// Params 7
// Checksum 0x32f794dd, Offset: 0x910
// Size: 0x110
function function_3b5052db( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        var_80120d96 = 0.1;
        fade_in_time = 4;
        var_2fbcffed = 0.6;
        var_baa794af = var_2fbcffed - var_80120d96;
        var_15dfe09e = fade_in_time / 0.05;
        var_363e9b28 = var_baa794af / var_15dfe09e;
        
        while ( var_80120d96 < var_2fbcffed )
        {
            var_80120d96 += var_363e9b28;
            setsaveddvar( "r_skyTransition", var_80120d96 );
            wait 0.05;
        }
    }
}

// Namespace cp_mi_cairo_lotus3
// Params 7
// Checksum 0x69438896, Offset: 0xa28
// Size: 0x64
function function_1be9086e( n_local_client, n_val_old, n_val_new, b_ent_new, b_initial_snap, str_field, b_demo_jump )
{
    if ( n_val_new )
    {
        level scene::play( "p7_fxanim_gp_trash_paper_burst_out_01_bundle" );
    }
}

// Namespace cp_mi_cairo_lotus3
// Params 7
// Checksum 0xc0b0248d, Offset: 0xa98
// Size: 0xa4
function player_sand_fx_logic( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self thread player_sand_fx_loop( localclientnum );
        return;
    }
    
    self notify( #"sand_fx_stop" );
    
    if ( isdefined( self.n_fx_id ) )
    {
        deletefx( localclientnum, self.n_fx_id, 1 );
    }
}

// Namespace cp_mi_cairo_lotus3
// Params 1
// Checksum 0x31c028a, Offset: 0xb48
// Size: 0x98
function player_sand_fx_loop( localclientnum )
{
    self endon( #"disconnect" );
    self endon( #"entityshutdown" );
    self endon( #"sand_fx_stop" );
    
    while ( true )
    {
        v_eye = self geteye();
        self.n_fx_id = playfx( localclientnum, level._effect[ "player_sand" ], v_eye );
        wait 0.1;
    }
}

// Namespace cp_mi_cairo_lotus3
// Params 7
// Checksum 0x99173a04, Offset: 0xbe8
// Size: 0x8c
function function_9f0a1f48( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"disconnect" );
    self endon( #"entityshutdown" );
    
    if ( newval )
    {
        playfxontag( localclientnum, level._effect[ "gunship_fan_damage" ], self, "tag_target_fan_left_outer" );
    }
}

// Namespace cp_mi_cairo_lotus3
// Params 7
// Checksum 0x42bd247f, Offset: 0xc80
// Size: 0x8c
function function_260a2497( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"disconnect" );
    self endon( #"entityshutdown" );
    
    if ( newval )
    {
        playfxontag( localclientnum, level._effect[ "gunship_fan_damage" ], self, "tag_target_fan_left_inner" );
    }
}

// Namespace cp_mi_cairo_lotus3
// Params 7
// Checksum 0xd479815b, Offset: 0xd18
// Size: 0x8c
function function_4be69226( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"disconnect" );
    self endon( #"entityshutdown" );
    
    if ( newval )
    {
        playfxontag( localclientnum, level._effect[ "gunship_fan_damage" ], self, "tag_target_fan_right_inner" );
    }
}

// Namespace cp_mi_cairo_lotus3
// Params 7
// Checksum 0x18ec038c, Offset: 0xdb0
// Size: 0x8c
function function_47274359( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"disconnect" );
    self endon( #"entityshutdown" );
    
    if ( newval )
    {
        playfxontag( localclientnum, level._effect[ "gunship_fan_damage" ], self, "tag_target_fan_right_outer" );
    }
}

// Namespace cp_mi_cairo_lotus3
// Params 7
// Checksum 0x8e38f3a6, Offset: 0xe48
// Size: 0x74
function function_307fd74a( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"disconnect" );
    self endon( #"entityshutdown" );
    
    if ( newval )
    {
        self.rumbleon = 0;
        return;
    }
    
    self.rumbleon = 1;
}

// Namespace cp_mi_cairo_lotus3
// Params 7
// Checksum 0x8ce68183, Offset: 0xec8
// Size: 0xb4
function function_66f3947f( n_local_client, n_val_old, n_val_new, b_ent_new, b_initial_snap, str_field, b_demo_jump )
{
    self endon( #"disconnect" );
    self endon( #"entityshutdown" );
    
    if ( n_val_new )
    {
        self.fx_trail = playfxontag( n_local_client, "vehicle/fx_gunship_raps_trail", self, "tag_origin" );
        return;
    }
    
    if ( isdefined( self.fx_trail ) )
    {
        stopfx( n_local_client, self.fx_trail );
    }
}

// Namespace cp_mi_cairo_lotus3
// Params 1
// Checksum 0xf2eb55b8, Offset: 0xf88
// Size: 0x21a
function force_streamer( n_index )
{
    switch ( n_index )
    {
        case 1:
            forcestreambundle( "cin_lot_09_01_pursuit_1st_switch_end" );
            break;
        case 2:
            forcestreambundle( "cin_lot_11_tower2ascent_3rd_sh010" );
            forcestreambundle( "cin_lot_11_tower2ascent_3rd_sh020" );
            forcestreambundle( "cin_lot_11_tower2ascent_3rd_sh030" );
            forcestreambundle( "cin_lot_11_tower2ascent_3rd_sh040" );
            forcestreambundle( "cin_lot_11_tower2ascent_3rd_sh050" );
            forcestreambundle( "cin_lot_11_tower2ascent_3rd_sh060" );
            forcestreambundle( "cin_lot_11_tower2ascent_3rd_sh070" );
            forcestreambundle( "cin_lot_11_tower2ascent_3rd_sh080" );
            forcestreambundle( "cin_lot_11_tower2ascent_3rd_sh090" );
            forcestreambundle( "cin_lot_11_tower2ascent_3rd_sh100" );
            forcestreambundle( "cin_lot_11_tower2ascent_3rd_sh110" );
            forcestreambundle( "cin_lot_11_tower2ascent_3rd_sh120" );
            break;
        case 3:
            forcestreambundle( "cin_lot_15_taylorintro_3rd_sh010" );
            forcestreambundle( "cin_lot_15_taylorintro_3rd_sh020" );
            forcestreambundle( "cin_lot_15_taylorintro_3rd_sh030" );
            forcestreambundle( "cin_lot_15_taylorintro_3rd_sh040" );
            forcestreambundle( "cin_lot_15_taylorintro_3rd_sh050" );
            forcestreambundle( "cin_lot_15_taylorintro_3rd_sh060" );
            break;
        default:
            break;
    }
}

