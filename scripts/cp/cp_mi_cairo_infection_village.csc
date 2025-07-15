#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace village;

// Namespace village
// Params 0
// Checksum 0x89c00444, Offset: 0x520
// Size: 0x44
function main()
{
    init_clientfields();
    level thread sndrecordoutdoor();
    level thread mortar_test();
}

// Namespace village
// Params 0
// Checksum 0x52ce176, Offset: 0x570
// Size: 0x16c
function init_clientfields()
{
    clientfield::register( "world", "village_mortar_index", 1, 3, "int", &callback_village_mortar_index, 0, 0 );
    clientfield::register( "world", "village_intro_mortar", 1, 1, "int", &callback_village_intro_mortar, 0, 0 );
    clientfield::register( "world", "init_fold", 1, 1, "int", &function_aa7aa249, 0, 0 );
    clientfield::register( "world", "start_fold", 1, 1, "int", &function_5058bf3d, 0, 0 );
    clientfield::register( "scriptmover", "fold_buildings", 1, 1, "int", &function_b459a9c8, 0, 0 );
}

// Namespace village
// Params 7
// Checksum 0x77684b8, Offset: 0x6e8
// Size: 0x9c
function function_aa7aa249( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval != oldval )
    {
        flag::init( "fold_done" );
        level thread scene::init( "p7_fxanim_cp_infection_fold_debris_rise_bundle" );
        level thread monitor_t_fold_debris_fall( localclientnum );
    }
}

// Namespace village
// Params 7
// Checksum 0x57742aca, Offset: 0x790
// Size: 0xb4
function function_5058bf3d( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval != oldval )
    {
        level thread fold_earthquake( localclientnum, 1 );
        level scene::play( "p7_fxanim_cp_infection_fold_debris_rise_bundle" );
        flag::set( "fold_done" );
        level thread fold_earthquake( localclientnum, 0 );
    }
}

// Namespace village
// Params 1
// Checksum 0x6f1cd9a6, Offset: 0x850
// Size: 0x84
function monitor_t_fold_debris_fall( localclientnum )
{
    flag::wait_till( "fold_done" );
    e_trigger = getent( localclientnum, "t_fold_debris_fall", "targetname" );
    e_trigger waittill( #"trigger" );
    level thread scene::play( "p7_fxanim_cp_infection_fold_debris_fall_bundle" );
}

// Namespace village
// Params 2
// Checksum 0x536c8cf2, Offset: 0x8e0
// Size: 0xbc
function fold_earthquake( localclientnum, benable )
{
    e_fold = getent( localclientnum, "fold_earthquake_origin", "targetname" );
    assert( isdefined( e_fold ), "<dev string:x28>" );
    
    if ( benable )
    {
        e_fold playrumblelooponentity( localclientnum, "cp_infection_fold" );
        return;
    }
    
    e_fold stoprumble( localclientnum, "cp_infection_fold" );
}

// Namespace village
// Params 0
// Checksum 0xa27a04dd, Offset: 0x9a8
// Size: 0x8c
function sndrecordoutdoor()
{
    level waittill( #"sndrec" );
    audio::playloopat( "evt_infection_record_outdoor", ( -66583, -8277, 539 ) );
    audio::playloopat( "evt_infection_record_outdoor", ( -66974, -5736, 481 ) );
    audio::playloopat( "evt_infection_record_outdoor", ( -68367, -4740, 469 ) );
}

// Namespace village
// Params 7
// Checksum 0x6eb89f6c, Offset: 0xa40
// Size: 0x54
function callback_village_mortar_index( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    level.village_mortar_index = newval;
    level.village_mortar_index_randomize = 1;
}

// Namespace village
// Params 0
// Checksum 0x512fe1ae, Offset: 0xaa0
// Size: 0x22c
function mortar_test()
{
    if ( !isdefined( level.village_mortar_index ) )
    {
        level.village_mortar_index = 0;
        level.village_mortar_index_randomize = 1;
    }
    
    index = 0;
    delay = 0.1;
    
    while ( true )
    {
        switch ( level.village_mortar_index )
        {
            case 1:
                a_struct = struct::get_array( "s_village_mortar_1", "targetname" );
                delay = randomfloatrange( 1.3, 2 );
                break;
            case 2:
                a_struct = struct::get_array( "s_village_mortar_2", "targetname" );
                delay = randomfloatrange( 1.3, 2 );
                break;
            case 3:
                a_struct = struct::get_array( "s_village_mortar_3", "targetname" );
                delay = randomfloatrange( 1.3, 2.2 );
                break;
            case 0:
            default:
                a_struct = undefined;
                break;
        }
        
        if ( isdefined( a_struct ) )
        {
            if ( isdefined( level.village_mortar_index_randomize ) )
            {
                index = randomint( a_struct.size );
                level.village_mortar_index_randomize = undefined;
            }
            
            playfx( 0, "explosions/fx_exp_mortar_snow", a_struct[ index ].origin );
            index++;
            
            if ( index >= a_struct.size )
            {
                index = 0;
            }
        }
        
        wait delay;
    }
}

// Namespace village
// Params 7
// Checksum 0x6a6375ba, Offset: 0xcd8
// Size: 0x94
function callback_village_intro_mortar( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    s_village_intro_mortar = struct::get( "s_village_intro_mortar", "targetname" );
    playfx( 0, "explosions/fx_exp_mortar_snow", s_village_intro_mortar.origin );
}

// Namespace village
// Params 7
// Checksum 0xfd93d62d, Offset: 0xd78
// Size: 0x21a
function function_b459a9c8( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    var_f45c8a8 = [];
    var_f45c8a8[ "bank_jnt" ] = "p7_fxanim_cp_infection_fold_bank_mod";
    var_f45c8a8[ "barn_01_jnt" ] = "p7_fxanim_cp_infection_fold_barn01_mod";
    var_f45c8a8[ "barn_02_jnt" ] = "p7_fxanim_cp_infection_fold_barn02_mod";
    var_f45c8a8[ "boarding_jnt" ] = "p7_fxanim_cp_infection_fold_boarding_mod";
    var_f45c8a8[ "church_jnt" ] = "p7_fxanim_cp_infection_fold_church_mod";
    var_f45c8a8[ "hotel_jnt" ] = "p7_fxanim_cp_infection_fold_hotel_mod";
    var_f45c8a8[ "house_01_jnt" ] = "p7_fxanim_cp_infection_fold_house01_mod";
    var_f45c8a8[ "house_02_jnt" ] = "p7_fxanim_cp_infection_fold_house02_mod";
    var_f45c8a8[ "tankhouse_jnt" ] = "p7_fxanim_cp_infection_fold_tankhouse_mod";
    var_f45c8a8[ "tenements_jnt" ] = "p7_fxanim_cp_infection_fold_tenements_mod";
    
    foreach ( str_tag, var_bfcb06ed in var_f45c8a8 )
    {
        e_building = util::spawn_model( localclientnum, var_bfcb06ed, self gettagorigin( str_tag ), self gettagangles( str_tag ) );
        e_building linkto( self, str_tag );
    }
}

