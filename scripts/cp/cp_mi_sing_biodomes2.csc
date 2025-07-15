#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/cp_mi_sing_biodomes2_fx;
#using scripts/cp/cp_mi_sing_biodomes2_patch_c;
#using scripts/cp/cp_mi_sing_biodomes2_sound;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_sing_biodomes2;

// Namespace cp_mi_sing_biodomes2
// Params 0
// Checksum 0x8294ccfd, Offset: 0x640
// Size: 0x6c
function main()
{
    clientfields_init();
    cp_mi_sing_biodomes2_fx::main();
    cp_mi_sing_biodomes2_sound::main();
    load::main();
    util::waitforclient( 0 );
    cp_mi_sing_biodomes2_patch_c::function_7403e82b();
}

// Namespace cp_mi_sing_biodomes2
// Params 0
// Checksum 0xede28053, Offset: 0x6b8
// Size: 0x67c
function clientfields_init()
{
    clientfield::register( "toplayer", "zipline_rumble_loop", 1, 1, "int", &function_85392f32, 0, 0 );
    clientfield::register( "toplayer", "dive_wind_rumble_loop", 1, 1, "int", &function_fdbd490e, 0, 0 );
    clientfield::register( "toplayer", "set_underwater_fx", 1, 1, "int", &function_16baac7c, 0, 0 );
    clientfield::register( "toplayer", "sound_evt_boat_rattle", 1, 1, "counter", &sound_evt_boat_rattle, 0, 0 );
    clientfield::register( "toplayer", "supertree_jump_debris_play", 1, 1, "int", &supertree_jump_debris_play, 0, 0 );
    clientfield::register( "toplayer", "zipline_speed_blur", 1, 1, "int", &zipline_speed_blur, 0, 0 );
    clientfield::register( "world", "boat_explosion_play", 1, 1, "int", &boat_explosion_play, 0, 0 );
    clientfield::register( "world", "elevator_top_debris_play", 1, 1, "int", &elevator_top_debris_play, 0, 0 );
    clientfield::register( "world", "elevator_bottom_debris_play", 1, 1, "int", &elevator_bottom_debris_play, 0, 0 );
    clientfield::register( "world", "tall_grass_init", 1, 1, "int", &tall_grass_init_func, 0, 0 );
    clientfield::register( "world", "tall_grass_play", 1, 1, "int", &tall_grass_play_func, 0, 0 );
    clientfield::register( "world", "supertree_fall_init", 1, 1, "counter", &supertree_init, 0, 0 );
    clientfield::register( "world", "supertree_fall_play", 1, 1, "counter", &supertree_play, 0, 0 );
    clientfield::register( "world", "ferriswheel_fall_play", 1, 1, "int", &ferriswheel_play, 0, 0 );
    clientfield::register( "vehicle", "boat_disable_sfx", 1, 1, "int", &callback_disable_sfx, 0, 0 );
    clientfield::register( "vehicle", "sound_evt_boat_scrape_impact", 1, 1, "counter", &sound_evt_boat_scrape_impact, 0, 0 );
    clientfield::register( "vehicle", "sound_veh_airboat_jump", 1, 1, "counter", &sound_veh_airboat_jump, 0, 0 );
    clientfield::register( "vehicle", "sound_veh_airboat_jump_air", 1, 1, "counter", &sound_veh_airboat_jump_air, 0, 0 );
    clientfield::register( "vehicle", "sound_veh_airboat_land", 1, 1, "counter", &sound_veh_airboat_land, 0, 0 );
    clientfield::register( "vehicle", "sound_veh_airboat_ramp_hit", 1, 1, "counter", &sound_veh_airboat_ramp_hit, 0, 0 );
    clientfield::register( "vehicle", "sound_veh_airboat_start", 1, 1, "counter", &sound_veh_airboat_start, 0, 0 );
    clientfield::register( "allplayers", "zipline_sound_loop", 1, 1, "int", &function_982d4d35, 0, 0 );
    clientfield::register( "scriptmover", "clone_control", 1, 1, "int", &function_d7b78660, 0, 0 );
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0x518a9ca1, Offset: 0xd40
// Size: 0x5c
function sound_evt_boat_rattle( n_local_client, n_val_old, n_val_new, b_ent_new, b_initial_snap, str_field, var_a5d31326 )
{
    self playsound( n_local_client, "evt_boat_rattle" );
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0xb4fd9626, Offset: 0xda8
// Size: 0x5c
function sound_evt_boat_scrape_impact( n_local_client, n_val_old, n_val_new, b_ent_new, b_initial_snap, str_field, var_a5d31326 )
{
    self playsound( n_local_client, "evt_boat_scrape_impact" );
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0xf8533f76, Offset: 0xe10
// Size: 0x5c
function sound_veh_airboat_jump( n_local_client, n_val_old, n_val_new, b_ent_new, b_initial_snap, str_field, var_a5d31326 )
{
    self playsound( n_local_client, "veh_airboat_jump" );
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0x1223a165, Offset: 0xe78
// Size: 0x5c
function sound_veh_airboat_jump_air( n_local_client, n_val_old, n_val_new, b_ent_new, b_initial_snap, str_field, var_a5d31326 )
{
    self playsound( n_local_client, "veh_airboat_jump_air" );
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0xb57506b7, Offset: 0xee0
// Size: 0x5c
function sound_veh_airboat_land( n_local_client, n_val_old, n_val_new, b_ent_new, b_initial_snap, str_field, var_a5d31326 )
{
    self playsound( n_local_client, "veh_airboat_land" );
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0x55d613b9, Offset: 0xf48
// Size: 0x5c
function sound_veh_airboat_ramp_hit( n_local_client, n_val_old, n_val_new, b_ent_new, b_initial_snap, str_field, var_a5d31326 )
{
    self playsound( n_local_client, "veh_airboat_ramp_hit" );
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0x10d07636, Offset: 0xfb0
// Size: 0x5c
function sound_veh_airboat_start( n_local_client, n_val_old, n_val_new, b_ent_new, b_initial_snap, str_field, var_a5d31326 )
{
    self playsound( n_local_client, "veh_airboat_start" );
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0x7abeecdc, Offset: 0x1018
// Size: 0x94
function zipline_speed_blur( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        enablespeedblur( localclientnum, 0.07, 0.55, 0.9, 0, 100, 100 );
        return;
    }
    
    disablespeedblur( localclientnum );
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0x514ec9ee, Offset: 0x10b8
// Size: 0x64
function boat_explosion_play( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "p7_fxanim_cp_biodomes_boat_explosion_debris_bundle" );
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0xed26c631, Offset: 0x1128
// Size: 0x64
function elevator_top_debris_play( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "p7_fxanim_cp_biodomes_cafe_roof_01_bundle" );
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0x66c0a794, Offset: 0x1198
// Size: 0x64
function elevator_bottom_debris_play( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "p7_fxanim_cp_biodomes_cafe_roof_02_bundle" );
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0xbef8a3f2, Offset: 0x1208
// Size: 0x64
function supertree_jump_debris_play( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "p7_fxanim_cp_biodomes_super_tree_jump_01_bundle" );
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0xbcdf4596, Offset: 0x1278
// Size: 0x64
function tall_grass_init_func( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::init( "p7_fxanim_cp_biodomes_boat_grass_bundle" );
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0xa82f7db8, Offset: 0x12e8
// Size: 0x64
function tall_grass_play_func( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "p7_fxanim_cp_biodomes_boat_grass_bundle" );
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0x6c68d074, Offset: 0x1358
// Size: 0x64
function supertree_init( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::init( "p7_fxanim_cp_biodomes_super_tree_collapse_bundle" );
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0x4dd78f7b, Offset: 0x13c8
// Size: 0x84
function supertree_play( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "p7_fxanim_cp_biodomes_super_tree_collapse_bundle" );
        level thread scene::play( "p7_fxanim_cp_biodomes_super_tree_collapse_catwalk_bundle" );
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0x67c60fb, Offset: 0x1458
// Size: 0x64
function ferriswheel_play( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "p7_fxanim_cp_biodomes_ferris_wheel_bundle" );
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0x1d898516, Offset: 0x14c8
// Size: 0x74
function callback_disable_sfx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self disablevehiclesounds();
        return;
    }
    
    self enablevehiclesounds();
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0x9d128d22, Offset: 0x1548
// Size: 0x94
function function_85392f32( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self playrumblelooponentity( localclientnum, "cp_biodomes_zipline_loop_rumble" );
        return;
    }
    
    self stoprumble( localclientnum, "cp_biodomes_zipline_loop_rumble" );
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0x2823866, Offset: 0x15e8
// Size: 0x8c
function function_982d4d35( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self playloopsound( "evt_zipline_move", 0.5 );
        return;
    }
    
    self stopallloopsounds( 0.5 );
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0x5bdba6e4, Offset: 0x1680
// Size: 0x94
function function_fdbd490e( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self playrumblelooponentity( localclientnum, "fallwind_loop_rapid" );
        return;
    }
    
    self stoprumble( localclientnum, "fallwind_loop_rapid" );
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0xc1f35d88, Offset: 0x1720
// Size: 0x194
function function_16baac7c( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        setlitfogbank( localclientnum, -1, 1, 1 );
        setworldfogactivebank( localclientnum, 2 );
        
        if ( isdefined( self.n_fx_id ) )
        {
            deletefx( localclientnum, self.n_fx_id, 1 );
        }
        
        self.n_fx_id = playfxoncamera( localclientnum, level._effect[ "underwater_motes" ], ( 0, 0, 0 ), ( 1, 0, 0 ), ( 0, 0, 1 ) );
        exploder::exploder( "exp_underwater_lights" );
        return;
    }
    
    setlitfogbank( localclientnum, -1, 0, 1 );
    setworldfogactivebank( localclientnum, 1 );
    
    if ( isdefined( self.n_fx_id ) )
    {
        deletefx( localclientnum, self.n_fx_id, 1 );
    }
    
    exploder::kill_exploder( "exp_underwater_lights" );
}

// Namespace cp_mi_sing_biodomes2
// Params 7
// Checksum 0xf591ee85, Offset: 0x18c0
// Size: 0x84
function function_d7b78660( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        if ( self.owner == getlocalplayer( localclientnum ) )
        {
            self thread function_6ec31df1( localclientnum );
        }
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 1
// Checksum 0x6576a8bd, Offset: 0x1950
// Size: 0xf0
function function_6ec31df1( localclientnum )
{
    self endon( #"entityshutdown" );
    
    while ( true )
    {
        if ( self clientfield::get( "clone_control" ) )
        {
            player = getlocalplayer( localclientnum );
            
            if ( isdefined( player ) )
            {
                if ( isthirdperson( localclientnum ) )
                {
                    self show();
                    player hide();
                }
                else
                {
                    player show();
                    self hide();
                }
            }
        }
        
        wait 0.016;
    }
}

