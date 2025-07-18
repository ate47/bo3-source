#using scripts/codescripts/struct;
#using scripts/shared/music_shared;

#namespace cp_mi_cairo_lotus2_sound;

// Namespace cp_mi_cairo_lotus2_sound
// Params 0
// Checksum 0x8784011e, Offset: 0x178
// Size: 0x34
function main()
{
    level thread lotus2_sound::function_82e83534();
    level thread lotus2_sound::function_cd6d8f17();
}

#namespace lotus2_sound;

// Namespace lotus2_sound
// Params 0
// Checksum 0x42f8313c, Offset: 0x1b8
// Size: 0x1c
function function_8836c025()
{
    music::setmusicstate( "lotus2_intro" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0x32a464b6, Offset: 0x1e0
// Size: 0x1c
function function_fd00a4f2()
{
    music::setmusicstate( "breach_stinger" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0xc4140a11, Offset: 0x208
// Size: 0x1c
function function_51e72857()
{
    music::setmusicstate( "battle_two" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0xad8d2e7e, Offset: 0x230
// Size: 0x1c
function function_614dc783()
{
    music::setmusicstate( "elevator_tension" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0xfce5145f, Offset: 0x258
// Size: 0x1c
function function_8ca46216()
{
    music::setmusicstate( "post_elevator_battle" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0x829ffc2, Offset: 0x280
// Size: 0x1c
function function_a3388bcf()
{
    music::setmusicstate( "pre_igc" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0x1bbe3ac4, Offset: 0x2a8
// Size: 0x1c
function function_c954e9a2()
{
    music::setmusicstate( "post_igc_drama" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0xa6de0f65, Offset: 0x2d0
// Size: 0x1c
function function_208b0a38()
{
    music::setmusicstate( "robot_hole_stinger" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0xe75489fc, Offset: 0x2f8
// Size: 0x1c
function function_1d1fd3af()
{
    music::setmusicstate( "epic_reveal_stinger" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0x8e9ffffa, Offset: 0x320
// Size: 0x1c
function function_12202095()
{
    music::setmusicstate( "battle_three" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0x66aaa851, Offset: 0x348
// Size: 0x1c
function function_beaa78ac()
{
    music::setmusicstate( "post_vtol_crash" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0x34594bda, Offset: 0x370
// Size: 0x1c
function function_973b77f9()
{
    music::setmusicstate( "none" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0x96c7a4c0, Offset: 0x398
// Size: 0x2c
function function_cd6d8f17()
{
    level waittill( #"hash_d77cf6d0" );
    music::setmusicstate( "none" );
}

// Namespace lotus2_sound
// Params 0
// Checksum 0x9fc363dc, Offset: 0x3d0
// Size: 0x2c
function function_82e83534()
{
    level waittill( #"hash_23be1ef" );
    music::setmusicstate( "frozen_forest" );
}

