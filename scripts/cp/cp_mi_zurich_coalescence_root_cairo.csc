#using scripts/codescripts/struct;
#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace root_cairo;

// Namespace root_cairo
// Params 0
// Checksum 0x5f710e15, Offset: 0x358
// Size: 0x24
function main()
{
    init_clientfields();
    init_effects();
}

// Namespace root_cairo
// Params 0
// Checksum 0xa2479f64, Offset: 0x388
// Size: 0x94
function init_clientfields()
{
    clientfield::register( "scriptmover", "vtol_spawn_fx", 1, 1, "counter", &function_c969e4b5, 0, 0 );
    clientfield::register( "world", "cairo_client_ents", 1, 1, "int", &function_889c4970, 0, 0 );
}

// Namespace root_cairo
// Params 0
// Checksum 0xebc64784, Offset: 0x428
// Size: 0x1e
function init_effects()
{
    level._effect[ "vtol_spawn_fx" ] = "explosions/fx_exp_lightning_fold_infection";
}

// Namespace root_cairo
// Params 7
// Checksum 0x4b761066, Offset: 0x450
// Size: 0x34e
function function_889c4970( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        if ( isdefined( level.var_fdb616fc ) && level.var_fdb616fc )
        {
            return;
        }
        
        level.var_fdb616fc = 1;
        scene::add_scene_func( "p7_fxanim_cp_zurich_cairo_b_collapse_01_bundle", &zurich_util::function_4dd02a03, "init", "cairo_root_client_cleanup" );
        level thread scene::init( "p7_fxanim_cp_zurich_cairo_b_collapse_01_bundle" );
        scene::add_scene_func( "p7_fxanim_cp_zurich_cairo_b_collapse_02_bundle", &zurich_util::function_4dd02a03, "init", "cairo_root_client_cleanup" );
        level thread scene::init( "p7_fxanim_cp_zurich_cairo_b_collapse_02_bundle" );
        scene::add_scene_func( "p7_fxanim_cp_zurich_cairo_b_collapse_03_bundle", &zurich_util::function_4dd02a03, "init", "cairo_root_client_cleanup" );
        level thread scene::init( "p7_fxanim_cp_zurich_cairo_b_collapse_03_bundle" );
        scene::add_scene_func( "p7_fxanim_cp_zurich_cairo_lightpole_bundle", &zurich_util::function_4dd02a03, "init", "cairo_root_client_cleanup" );
        level thread scene::init( "p7_fxanim_cp_zurich_cairo_lightpole_bundle" );
        scene::add_scene_func( "p7_fxanim_cp_zurich_sinkhole_01_bundle", &zurich_util::function_4dd02a03, "init", "cairo_root_client_cleanup" );
        level thread scene::init( "p7_fxanim_cp_zurich_sinkhole_01_bundle" );
        scene::add_scene_func( "p7_fxanim_cp_zurich_sinkhole_02_bundle", &zurich_util::function_4dd02a03, "init", "cairo_root_client_cleanup" );
        level thread scene::init( "p7_fxanim_cp_zurich_sinkhole_02_bundle" );
        var_84828c57 = getentarray( localclientnum, "cairo_client_building", "targetname" );
        array::thread_all( var_84828c57, &function_ea552f44, localclientnum );
        var_c9a3a65d = getentarray( localclientnum, "cairo_client_explode", "targetname" );
        array::thread_all( var_c9a3a65d, &function_9f362d5c, localclientnum );
        return;
    }
    
    level notify( #"cairo_root_client_cleanup" );
    level.var_fdb616fc = undefined;
}

// Namespace root_cairo
// Params 1
// Checksum 0xe3f4806d, Offset: 0x7a8
// Size: 0x6c
function function_ea552f44( localclientnum )
{
    self waittill( #"trigger" );
    assert( isdefined( self.script_string ), "<dev string:x28>" );
    level thread scene::play( "p7_fxanim_cp_zurich_cairo_" + self.script_string );
}

// Namespace root_cairo
// Params 1
// Checksum 0xed1bfbc2, Offset: 0x820
// Size: 0x6c
function function_9f362d5c( localclientnum )
{
    self waittill( #"trigger" );
    assert( isdefined( self.script_string ), "<dev string:x63>" );
    level thread scene::play( "p7_fxanim_cp_zurich_" + self.script_string );
}

// Namespace root_cairo
// Params 7
// Checksum 0xe6f7bf17, Offset: 0x898
// Size: 0x6c
function function_c969e4b5( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playfxontag( localclientnum, level._effect[ "vtol_spawn_fx" ], self, "tag_origin" );
}

