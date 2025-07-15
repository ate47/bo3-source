#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/scene_shared;

#namespace cp_mi_cairo_infection_sim_reality_starts;

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 0
// Checksum 0x95d07426, Offset: 0x3b0
// Size: 0x14
function main()
{
    init_clientfields();
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 0
// Checksum 0xaf5000fc, Offset: 0x3d0
// Size: 0x43c
function init_clientfields()
{
    clientfield::register( "toplayer", "sim_out_of_bound", 1, 1, "counter", &callback_out_of_bound, 0, 0 );
    clientfield::register( "world", "sim_lgt_tree_glow_01", 1, 1, "int", &callback_lgt_tree_glow_01, 0, 0 );
    clientfield::register( "world", "sim_lgt_tree_glow_02", 1, 1, "int", &callback_lgt_tree_glow_02, 0, 0 );
    clientfield::register( "world", "sim_lgt_tree_glow_03", 1, 1, "int", &callback_lgt_tree_glow_03, 0, 0 );
    clientfield::register( "world", "sim_lgt_tree_glow_04", 1, 1, "int", &callback_lgt_tree_glow_04, 0, 0 );
    clientfield::register( "world", "sim_lgt_tree_glow_05", 1, 1, "int", &callback_lgt_tree_glow_05, 0, 0 );
    clientfield::register( "world", "lgt_tree_glow_05_fade_out", 1, 1, "int", &function_c27ea863, 0, 0 );
    clientfield::register( "world", "sim_lgt_tree_glow_all_off", 1, 1, "int", &callback_lgt_tree_glow_all_off, 0, 0 );
    clientfield::register( "toplayer", "pstfx_frost_up", 1, 1, "counter", &callback_pstfx_frost_up, 0, 0 );
    clientfield::register( "toplayer", "pstfx_frost_down", 1, 1, "counter", &callback_pstfx_frost_down, 0, 0 );
    clientfield::register( "toplayer", "pstfx_frost_up_baby", 1, 1, "counter", &callback_pstfx_frost_up_baby, 0, 0 );
    clientfield::register( "toplayer", "pstfx_exit_all", 1, 1, "counter", &function_9d61ff9d, 0, 0 );
    clientfield::register( "scriptmover", "infection_baby_shader", 1, 1, "int", &callback_baby_skin_shader, 0, 0 );
    clientfield::register( "world", "toggle_sim_fog_banks", 1, 1, "int", &callback_toggle_sim_fog_banks, 0, 0 );
    clientfield::register( "world", "break_baby", 1, 1, "int", &callback_break_baby, 0, 0 );
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0x1f7abec8, Offset: 0x818
// Size: 0x84
function callback_out_of_bound( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = getlocalplayer( localclientnum );
    player postfx::stoppostfxbundle();
    player.pstfx_frost = 0;
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0xa7cf8500, Offset: 0x8a8
// Size: 0x64
function callback_lgt_tree_glow_01( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        exploder::exploder( "lgt_tree_glow_01" );
    }
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0xecc7db1a, Offset: 0x918
// Size: 0x64
function callback_lgt_tree_glow_02( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        exploder::exploder( "lgt_tree_glow_02" );
    }
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0x9abee95a, Offset: 0x988
// Size: 0x64
function callback_lgt_tree_glow_03( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        exploder::exploder( "lgt_tree_glow_03" );
    }
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0x66df0c3b, Offset: 0x9f8
// Size: 0x64
function callback_lgt_tree_glow_04( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        exploder::exploder( "lgt_tree_glow_04" );
    }
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0xa1b3e543, Offset: 0xa68
// Size: 0x7c
function callback_lgt_tree_glow_05( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        exploder::exploder( "lgt_tree_glow_05" );
        exploder::exploder( "lgt_tree_glow_05_fade_out" );
    }
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0xfe1ac881, Offset: 0xaf0
// Size: 0x64
function function_c27ea863( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        exploder::stop_exploder( "lgt_tree_glow_05_fade_out" );
    }
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0x3d882ca0, Offset: 0xb60
// Size: 0xae
function callback_lgt_tree_glow_all_off( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        for ( i = 1; i <= 5 ; i++ )
        {
            str_exploder_name = "lgt_tree_glow_0" + i;
            exploder::stop_exploder( str_exploder_name );
        }
    }
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0xcb80b589, Offset: 0xc18
// Size: 0xfc
function callback_pstfx_frost_up( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = getlocalplayer( localclientnum );
    
    if ( !isdefined( player.pstfx_frost ) )
    {
        player.pstfx_frost = 0;
    }
    
    if ( player.pstfx_frost == 0 && newval == 1 )
    {
        playsound( 0, "evt_freeze_start", ( 0, 0, 0 ) );
        player.pstfx_frost = 1;
        player postfx::playpostfxbundle( "pstfx_frost_loop" );
    }
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0xc3999d9e, Offset: 0xd20
// Size: 0xf4
function callback_pstfx_frost_down( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = getlocalplayer( localclientnum );
    
    if ( !isdefined( player.pstfx_frost ) )
    {
        player.pstfx_frost = 0;
    }
    
    if ( player.pstfx_frost == 1 && newval == 1 )
    {
        playsound( 0, "evt_freeze_end", ( 0, 0, 0 ) );
        player.pstfx_frost = 0;
        player thread postfx::exitpostfxbundle();
    }
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0xdf7cba4d, Offset: 0xe20
// Size: 0xd4
function callback_pstfx_frost_up_baby( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = getlocalplayer( localclientnum );
    player.pstfx_frost = -1;
    player postfx::playpostfxbundle( "pstfx_baby_frost_up" );
    player postfx::playpostfxbundle( "pstfx_baby_frost_loop" );
    playsound( 0, "evt_freeze_start", ( 0, 0, 0 ) );
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0x546d9b38, Offset: 0xf00
// Size: 0x74
function function_9d61ff9d( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = getlocalplayer( localclientnum );
    player thread postfx::exitpostfxbundle();
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0xeff5380d, Offset: 0xf80
// Size: 0x8c
function callback_toggle_sim_fog_banks( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    n_bank = 0;
    
    if ( newval == 1 )
    {
        n_bank = 2;
    }
    else
    {
        n_bank = 0;
    }
    
    setworldfogactivebank( localclientnum, n_bank );
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0xbcd6914c, Offset: 0x1018
// Size: 0xa4
function callback_break_baby( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !binitialsnap && !bnewent )
    {
        if ( newval != oldval && newval == 1 )
        {
            level thread scene::play( "p7_fxanim_cp_infection_baby_bundle" );
            exploder::exploder( "inf_boa_crying" );
        }
    }
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0xb3d40d34, Offset: 0x10c8
// Size: 0x1f0
function callback_baby_skin_shader( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    start_time = gettime();
    anim_time = 15;
    vien_start_time = 2;
    eyeball_start_time = 3;
    updating = 1;
    
    while ( updating )
    {
        time = gettime();
        time_in_seconds = ( time - start_time ) / 1000;
        
        if ( time_in_seconds >= anim_time )
        {
            time_in_seconds = anim_time;
            updating = 0;
        }
        
        n_desaturation = time_in_seconds / 15;
        
        if ( time_in_seconds < vien_start_time )
        {
            n_vein = 0;
        }
        else
        {
            n_vein = 1 - ( 15 - time_in_seconds ) / ( anim_time - vien_start_time );
        }
        
        if ( time_in_seconds < eyeball_start_time )
        {
            n_eyeball = 0;
        }
        else
        {
            n_eyeball = 1 - ( 15 - time_in_seconds ) / ( anim_time - eyeball_start_time );
        }
        
        self mapshaderconstant( localclientnum, 0, "scriptVector1", n_desaturation, n_vein, 0, 0 );
        self mapshaderconstant( localclientnum, 0, "scriptVector0", n_eyeball, 0, 0 );
        wait 0.01;
    }
}

