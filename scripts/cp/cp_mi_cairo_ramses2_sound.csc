#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;

#namespace cp_mi_cairo_ramses2_sound;

// Namespace cp_mi_cairo_ramses2_sound
// Params 0
// Checksum 0x81d01cb3, Offset: 0x1a8
// Size: 0x154
function main()
{
    level thread hospital_walla();
    level thread setigcsnapshot( "igcds1", "cp_ramses_demostreet_1" );
    level thread setigcsnapshot( "igcds2", "cp_ramses_demostreet_2" );
    level thread setigcsnapshot( "igcds3", "cp_ramses_demostreet_3", "igc" );
    level thread setigcsnapshot( "igcds4", "default", "normal" );
    level thread setoutrosnapshot( "outrofoley", "outroduck" );
    level thread set_prevtol_snapshot();
    level thread play_igc_fire_loop();
    level thread function_6a0726e7();
    level thread function_671db01b();
}

// Namespace cp_mi_cairo_ramses2_sound
// Params 0
// Checksum 0xb70b7838, Offset: 0x308
// Size: 0x12
function hospital_walla()
{
    level notify( #"walla_off" );
}

// Namespace cp_mi_cairo_ramses2_sound
// Params 3
// Checksum 0xdabfcf58, Offset: 0x328
// Size: 0x64
function setigcsnapshot( arg1, arg2, arg3 )
{
    level waittill( arg1 );
    audio::snd_set_snapshot( arg2 );
    
    if ( isdefined( arg3 ) )
    {
        setsoundcontext( "foley", arg3 );
    }
}

// Namespace cp_mi_cairo_ramses2_sound
// Params 2
// Checksum 0x87ae2966, Offset: 0x398
// Size: 0x5c
function setoutrosnapshot( arg1, arg2 )
{
    level waittill( arg1 );
    setsoundcontext( "foley", "normal" );
    level waittill( arg2 );
    audio::snd_set_snapshot( "cp_ramses_outro" );
}

// Namespace cp_mi_cairo_ramses2_sound
// Params 0
// Checksum 0x6d0c6c7a, Offset: 0x400
// Size: 0x54
function set_prevtol_snapshot()
{
    level waittill( #"pres" );
    audio::snd_set_snapshot( "cp_ramses_pre_vtol" );
    level waittill( #"pst" );
    audio::snd_set_snapshot( "cp_ramses_plaza_battle" );
}

// Namespace cp_mi_cairo_ramses2_sound
// Params 0
// Checksum 0x8f543522, Offset: 0x460
// Size: 0x2c
function play_igc_fire_loop()
{
    audio::playloopat( "amb_vtol_fire_loop", ( 8101, -16182, 322 ) );
}

// Namespace cp_mi_cairo_ramses2_sound
// Params 0
// Checksum 0xd448991e, Offset: 0x498
// Size: 0x2c
function function_6a0726e7()
{
    level waittill( #"hash_24819a18" );
    audio::snd_set_snapshot( "cp_ramses_vtol_walk" );
}

// Namespace cp_mi_cairo_ramses2_sound
// Params 0
// Checksum 0xa6abcfc0, Offset: 0x4d0
// Size: 0x34
function function_671db01b()
{
    level waittill( #"pst" );
    wait 0.5;
    audio::snd_set_snapshot( "cp_ramses_plaza_battle" );
}

