#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace mp_miniature_ladybug;

// Namespace mp_miniature_ladybug
// Params 0
// Checksum 0xb750ebe4, Offset: 0x4f8
// Size: 0x27a
function main()
{
    level.var_760ab2f = [];
    level.var_760ab2f[ "bbq" ] = array( "p7_fxanim_mp_mini_ladybug_bbq_idle_bundle", "p7_fxanim_mp_mini_ladybug_bbq_01_bundle", "p7_fxanim_mp_mini_ladybug_bbq_02_bundle", "p7_fxanim_mp_mini_ladybug_bbq_03_bundle", "p7_fxanim_mp_mini_ladybug_bbq_04_bundle" );
    level.var_760ab2f[ "cake" ] = array( "p7_fxanim_mp_mini_ladybug_cake_idle_bundle", "p7_fxanim_mp_mini_ladybug_cake_01_bundle", "p7_fxanim_mp_mini_ladybug_cake_02_bundle", "p7_fxanim_mp_mini_ladybug_cake_03_bundle" );
    level.var_760ab2f[ "coffee" ] = array( "p7_fxanim_mp_mini_ladybug_coffee_idle_bundle", "p7_fxanim_mp_mini_ladybug_coffee_01_bundle", "p7_fxanim_mp_mini_ladybug_coffee_02_bundle", "p7_fxanim_mp_mini_ladybug_coffee_03_bundle", "p7_fxanim_mp_mini_ladybug_coffee_04_bundle" );
    level.var_760ab2f[ "plant" ] = array( "p7_fxanim_mp_mini_ladybug_plant_idle_bundle", "p7_fxanim_mp_mini_ladybug_plant_01_bundle", "p7_fxanim_mp_mini_ladybug_plant_02_bundle", "p7_fxanim_mp_mini_ladybug_plant_03_bundle" );
    level.var_760ab2f[ "soda" ] = array( "p7_fxanim_mp_mini_ladybug_soda_idle_bundle", "p7_fxanim_mp_mini_ladybug_soda_01_bundle", "p7_fxanim_mp_mini_ladybug_soda_02_bundle", "p7_fxanim_mp_mini_ladybug_soda_03_bundle", "p7_fxanim_mp_mini_ladybug_soda_04_bundle" );
    
    foreach ( str_id, a_scenes in level.var_760ab2f )
    {
        scene::add_scene_func( level.var_760ab2f[ str_id ][ 0 ], &function_edb97aef, "play", str_id );
        s_scene = struct::get( level.var_760ab2f[ str_id ][ 1 ], "scriptbundlename" );
        s_scene thread scene::play( level.var_760ab2f[ str_id ][ 0 ] );
    }
}

// Namespace mp_miniature_ladybug
// Params 2
// Checksum 0xe82ec69a, Offset: 0x780
// Size: 0x12c
function function_edb97aef( a_ents, str_id )
{
    if ( !isdefined( self.var_3bb24e3d ) )
    {
        self.var_3bb24e3d = 0;
    }
    
    bug = a_ents[ "ladybug_" + str_id ];
    bug.takedamage = 1;
    
    if ( self.var_3bb24e3d != 0 )
    {
        bug util::waittill_notify_or_timeout( "damage", randomintrange( 10, 20 ) );
    }
    
    self.var_3bb24e3d++;
    
    if ( self.var_3bb24e3d >= level.var_760ab2f[ str_id ].size )
    {
        self.var_3bb24e3d = 1;
    }
    
    self scene::play( level.var_760ab2f[ str_id ][ self.var_3bb24e3d ], a_ents );
    self thread scene::play( level.var_760ab2f[ str_id ][ 0 ], a_ents );
}

