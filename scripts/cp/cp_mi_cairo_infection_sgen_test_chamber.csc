#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_cairo_infection_sgen_test_chamber;

// Namespace cp_mi_cairo_infection_sgen_test_chamber
// Params 0
// Checksum 0xf07b5103, Offset: 0x2b8
// Size: 0x14
function main()
{
    init_clientfields();
}

// Namespace cp_mi_cairo_infection_sgen_test_chamber
// Params 0
// Checksum 0xb9bd98e3, Offset: 0x2d8
// Size: 0x16c
function init_clientfields()
{
    clientfield::register( "world", "sgen_test_chamber_pod_graphics", 1, 1, "int", &function_8d81452c, 0, 0 );
    clientfield::register( "world", "sgen_test_chamber_time_lapse", 1, 1, "int", &callback_time_lapse, 0, 0 );
    clientfield::register( "scriptmover", "sgen_test_guys_decay", 1, 1, "int", &callback_guys_decay, 0, 0 );
    clientfield::register( "world", "fxanim_hive_cluster_break", 1, 1, "int", &fxanim_hive_cluster_break, 0, 0 );
    clientfield::register( "world", "fxanim_time_lapse_objects", 1, 1, "int", &fxanim_time_lapse_objects, 0, 0 );
}

// Namespace cp_mi_cairo_infection_sgen_test_chamber
// Params 7
// Checksum 0x2be197b4, Offset: 0x450
// Size: 0xbc
function fxanim_hive_cluster_break( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::init( "p7_fxanim_cp_infection_sgen_hive_drop_bundle" );
        return;
    }
    
    scene::add_scene_func( "p7_fxanim_cp_infection_sgen_hive_drop_bundle", &callback_hive_remove, "play" );
    level thread scene::play( "p7_fxanim_cp_infection_sgen_hive_drop_bundle" );
}

// Namespace cp_mi_cairo_infection_sgen_test_chamber
// Params 1
// Checksum 0xb6afe4b3, Offset: 0x518
// Size: 0x34
function callback_hive_remove( a_ent )
{
    wait 8;
    a_ent[ "sgen_hive_drop" ] delete();
}

// Namespace cp_mi_cairo_infection_sgen_test_chamber
// Params 7
// Checksum 0xbc2acdc3, Offset: 0x558
// Size: 0x202
function function_8d81452c( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    testing_pod_ents = getentarray( localclientnum, "dni_testing_pod", "targetname" );
    
    if ( oldval != newval )
    {
        if ( newval == 1 )
        {
            foreach ( testing_pod_ent in testing_pod_ents )
            {
                testing_pod_ent attach( "p7_sgen_dni_testing_pod_graphics_01_screen", "tag_origin" );
                testing_pod_ent attach( "p7_sgen_dni_testing_pod_graphics_01_door", "tag_door_anim" );
            }
            
            return;
        }
        
        foreach ( testing_pod_ent in testing_pod_ents )
        {
            testing_pod_ent detach( "p7_sgen_dni_testing_pod_graphics_01_screen", "tag_origin" );
            testing_pod_ent detach( "p7_sgen_dni_testing_pod_graphics_01_door", "tag_door_anim" );
        }
    }
}

// Namespace cp_mi_cairo_infection_sgen_test_chamber
// Params 7
// Checksum 0xafd7deef, Offset: 0x768
// Size: 0xf2
function callback_time_lapse( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    testing_pod_ents = getentarray( localclientnum, "dni_testing_pod", "targetname" );
    
    foreach ( testing_pod_ent in testing_pod_ents )
    {
        testing_pod_ent thread time_lapse();
    }
}

// Namespace cp_mi_cairo_infection_sgen_test_chamber
// Params 0
// Checksum 0x4f78c9b4, Offset: 0x868
// Size: 0xb6
function time_lapse()
{
    n_wait_per_cycle = 0.0666667;
    n_growth_increment = 1 / 180;
    n_growth = 0;
    i = 0;
    
    while ( i <= 12 )
    {
        self mapshaderconstant( 0, 0, "scriptVector0", n_growth, 0, 0, 0 );
        n_growth += n_growth_increment;
        wait n_wait_per_cycle;
        i += n_wait_per_cycle;
    }
}

// Namespace cp_mi_cairo_infection_sgen_test_chamber
// Params 7
// Checksum 0x4cf5c5f7, Offset: 0x928
// Size: 0x54
function callback_guys_decay( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self thread decaymanmaterial( localclientnum );
}

// Namespace cp_mi_cairo_infection_sgen_test_chamber
// Params 1
// Checksum 0x9967399a, Offset: 0x988
// Size: 0xda
function decaymanmaterial( localclientnum )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self notify( #"decaymanmaterial" );
    self endon( #"decaymanmaterial" );
    var_9ef7f234 = 1 / 6.5;
    i = 0;
    
    while ( i <= 6.5 )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self mapshaderconstant( localclientnum, 0, "scriptVector0", i * var_9ef7f234, 0, 0, 0 );
        wait 0.01;
        i += 0.01;
    }
}

// Namespace cp_mi_cairo_infection_sgen_test_chamber
// Params 7
// Checksum 0x3bedd30b, Offset: 0xa70
// Size: 0x64
function fxanim_time_lapse_objects( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "p7_fxanim_cp_infection_sgen_time_lapse_objects_bundle" );
    }
}

