#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace hideout_outro;

// Namespace hideout_outro
// Params 0
// Checksum 0xefb8dfce, Offset: 0x400
// Size: 0x2c
function main()
{
    init_clientfields();
    level thread city_ceilings_init();
}

// Namespace hideout_outro
// Params 0
// Checksum 0xbc64849b, Offset: 0x438
// Size: 0x30c
function init_clientfields()
{
    n_clientbits = getminbitcountfornum( 4 );
    clientfield::register( "world", "infection_hideout_fx", 1, 1, "int", &handle_hideout_fx, 1, 1 );
    clientfield::register( "world", "hideout_stretch", 1, 1, "int", &hideout_stretch_fxanim, 1, 1 );
    clientfield::register( "world", "stalingrad_rise_nuke", 1, 2, "int", &stalingrad_rise_fxanim, 1, 1 );
    clientfield::register( "world", "stalingrand_nuke_fog_banks", 1, 1, "int", &function_3c38e46d, 1, 1 );
    clientfield::register( "world", "city_tree_passed", 1, 1, "int", &city_tree_passed, 1, 1 );
    clientfield::register( "world", "stalingrad_tree_init", 1, 2, "int", &stalingrad_tree_fxanim, 1, 1 );
    clientfield::register( "world", "stalingrad_city_ceilings", 1, n_clientbits, "int", &city_ceilings_play, 1, 1 );
    clientfield::register( "world", "infection_nuke_lights", 1, 1, "int", &function_92bc5026, 0, 0 );
    clientfield::register( "toplayer", "ukko_toggling", 1, 1, "counter", &function_f414574b, 0, 0 );
    clientfield::register( "toplayer", "nuke_earth_quake", 1, getminbitcountfornum( 8 ), "int", &function_521c838b, 0, 0 );
}

// Namespace hideout_outro
// Params 7
// Checksum 0x262bfdc4, Offset: 0x750
// Size: 0x7c
function handle_hideout_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !isdefined( newval ) )
    {
        return;
    }
    
    if ( newval != oldval && newval == 1 )
    {
        startwatersheetingfx( localclientnum, 8 );
    }
}

// Namespace hideout_outro
// Params 7
// Checksum 0x30edabef, Offset: 0x7d8
// Size: 0x44
function hideout_stretch_fxanim( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
    }
}

// Namespace hideout_outro
// Params 7
// Checksum 0x264bf9a9, Offset: 0x828
// Size: 0xdc
function stalingrad_rise_fxanim( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        level thread scene::init( "p7_fxanim_cp_infection_nuke_buildings_bundle" );
        level thread scene::init( "p7_fxanim_cp_infection_nuke_tree_building_bundle" );
        return;
    }
    
    if ( newval == 2 )
    {
        level thread scene::play( "p7_fxanim_cp_infection_nuke_wave_bundle" );
        level waittill( #"nuke_buildings" );
        level thread scene::play( "p7_fxanim_cp_infection_nuke_buildings_bundle" );
    }
}

// Namespace hideout_outro
// Params 7
// Checksum 0xef3bc8f2, Offset: 0x910
// Size: 0x14c
function stalingrad_tree_fxanim( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        scene::add_scene_func( "p7_fxanim_cp_infection_nuke_tree_01_bundle", &callback_city_tree, "play" );
        scene::add_scene_func( "p7_fxanim_cp_infection_nuke_tree_02_bundle", &callback_city_tree, "init" );
        level thread scene::play( "p7_fxanim_cp_infection_nuke_tree_01_bundle" );
        level thread scene::init( "p7_fxanim_cp_infection_nuke_tree_02_bundle" );
        return;
    }
    
    if ( newval == 2 )
    {
        scene::add_scene_func( "p7_fxanim_cp_infection_nuke_tree_02_bundle", &tree_hits_building, "play" );
        level thread scene::play( "p7_fxanim_cp_infection_nuke_tree_02_bundle" );
    }
}

// Namespace hideout_outro
// Params 1
// Checksum 0x3007a984, Offset: 0xa68
// Size: 0x44
function tree_hits_building( a_ents )
{
    a_ents[ "nuke_tree_02_trunk" ] waittill( #"tree_smash" );
    level thread scene::play( "p7_fxanim_cp_infection_nuke_tree_building_bundle" );
}

// Namespace hideout_outro
// Params 0
// Checksum 0x1d4c0d71, Offset: 0xab8
// Size: 0x6c
function city_ceilings_init()
{
    wait 0.05;
    level thread scene::init( "p7_fxanim_cp_infection_house_ceiling_01_bundle" );
    level thread scene::init( "p7_fxanim_cp_infection_house_ceiling_03_bundle" );
    level thread scene::init( "p7_fxanim_cp_infection_house_ceiling_04_bundle" );
}

// Namespace hideout_outro
// Params 7
// Checksum 0x531d03de, Offset: 0xb30
// Size: 0xc4
function city_ceilings_play( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        level thread scene::play( "p7_fxanim_cp_infection_house_ceiling_01_bundle" );
        return;
    }
    
    if ( newval == 3 )
    {
        level thread scene::play( "p7_fxanim_cp_infection_house_ceiling_03_bundle" );
        return;
    }
    
    if ( newval == 4 )
    {
        level thread scene::play( "p7_fxanim_cp_infection_house_ceiling_04_bundle" );
    }
}

// Namespace hideout_outro
// Params 7
// Checksum 0xdcffb934, Offset: 0xc00
// Size: 0x58
function city_tree_passed( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        level.city_skipped = 1;
    }
}

// Namespace hideout_outro
// Params 1
// Checksum 0x91d79c67, Offset: 0xc60
// Size: 0x92
function callback_city_tree( a_ents )
{
    foreach ( e_tree in a_ents )
    {
        e_tree thread city_tree_shader();
    }
}

// Namespace hideout_outro
// Params 0
// Checksum 0xcb6b68a3, Offset: 0xd00
// Size: 0x3f0
function city_tree_shader()
{
    self endon( #"death" );
    self endon( #"entityshutdown" );
    n_growth = 0;
    n_increment = 0.1;
    
    while ( n_growth < 1 )
    {
        foreach ( player in getlocalplayers() )
        {
            var_ae6a34c0 = player getlocalclientnumber();
            
            if ( isdefined( var_ae6a34c0 ) )
            {
                n_growth += n_increment;
                self mapshaderconstant( var_ae6a34c0, 0, "scriptVector0", n_growth, 1, 0, 0 );
            }
        }
        
        wait n_increment;
    }
    
    n_pulse_max = 1;
    n_pulse_min = 0.2;
    n_pulse = n_pulse_min;
    
    while ( true )
    {
        n_cycle_time = randomfloatrange( 2, 8 );
        n_pulse_increment = ( n_pulse_max - n_pulse_min ) / n_cycle_time / n_increment;
        
        while ( n_pulse < n_pulse_max )
        {
            foreach ( player in getlocalplayers() )
            {
                var_ae6a34c0 = player getlocalclientnumber();
                
                if ( isdefined( var_ae6a34c0 ) )
                {
                    self mapshaderconstant( var_ae6a34c0, 0, "scriptVector0", 1, n_pulse, 0, 0 );
                    n_pulse += n_pulse_increment;
                }
            }
            
            wait n_increment;
        }
        
        n_cycle_time = randomfloatrange( 2, 8 );
        n_pulse_increment = ( n_pulse_max - n_pulse_min ) / n_cycle_time / n_increment;
        
        while ( n_pulse_min < n_pulse )
        {
            foreach ( player in getlocalplayers() )
            {
                var_ae6a34c0 = player getlocalclientnumber();
                
                if ( isdefined( var_ae6a34c0 ) )
                {
                    self mapshaderconstant( var_ae6a34c0, 0, "scriptVector0", 1, n_pulse, 0, 0 );
                    n_pulse -= n_pulse_increment;
                }
            }
            
            wait n_increment;
        }
    }
}

// Namespace hideout_outro
// Params 7
// Checksum 0x236f87ce, Offset: 0x10f8
// Size: 0x1a4
function function_f414574b( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"zombies_completed" );
    var_fb330b21 = randomintrange( 1, 5 );
    setukkoscriptindex( localclientnum, randomintrange( 2, 4 ), 1 );
    wait randomfloatrange( 0.05, 0.25 );
    var_fb330b21--;
    
    while ( var_fb330b21 )
    {
        setukkoscriptindex( localclientnum, 1, 1 );
        wait randomfloatrange( 0.05, 0.1 );
        setukkoscriptindex( localclientnum, randomintrange( 2, 4 ), 1 );
        wait randomfloatrange( 0.05, 0.25 );
        var_fb330b21--;
    }
    
    setukkoscriptindex( localclientnum, 1, 1 );
}

// Namespace hideout_outro
// Params 7
// Checksum 0x5c56f753, Offset: 0x12a8
// Size: 0xbc
function function_3c38e46d( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( oldval != newval )
    {
        if ( newval == 1 )
        {
            setworldfogactivebank( localclientnum, 2 );
            level waittill( #"hash_53817054" );
            setworldfogactivebank( localclientnum, 4 );
            return;
        }
        
        setworldfogactivebank( localclientnum, 0 );
    }
}

// Namespace hideout_outro
// Params 7
// Checksum 0xf280d503, Offset: 0x1370
// Size: 0x74
function function_92bc5026( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( oldval != newval )
    {
        if ( newval == 1 )
        {
            exploder::exploder( "infection_nuke_lights" );
        }
    }
}

// Namespace hideout_outro
// Params 7
// Checksum 0x3fb15e66, Offset: 0x13f0
// Size: 0x64
function function_521c838b( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval > 0 )
    {
        self thread nuke_earth_quake( localclientnum, newval );
    }
}

// Namespace hideout_outro
// Params 2
// Checksum 0x5ca7669b, Offset: 0x1460
// Size: 0x152
function nuke_earth_quake( localclientnum, n_time )
{
    self endon( #"death" );
    n_start_time = getservertime( localclientnum );
    n_time_passed = 0;
    n_scale = 0.1;
    self playrumbleonentity( localclientnum, "tank_damage_heavy_mp" );
    self earthquake( 0.3, 0.5, self.origin, 100 );
    
    while ( n_time_passed < n_time )
    {
        self playrumbleonentity( localclientnum, "damage_heavy" );
        self earthquake( n_scale, 1, self.origin, 100 );
        wait 0.25;
        n_scale += 0.015;
        n_time_passed = ( getservertime( localclientnum ) - n_start_time ) / 1000;
    }
}

