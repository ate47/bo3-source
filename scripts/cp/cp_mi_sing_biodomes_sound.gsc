#using scripts/codescripts/struct;
#using scripts/cp/voice/voice_biodomes;
#using scripts/shared/music_shared;

#namespace cp_mi_sing_biodomes_sound;

// Namespace cp_mi_sing_biodomes_sound
// Params 0
// Checksum 0xb654e7f9, Offset: 0x178
// Size: 0x2c
function main()
{
    voice_biodomes::init_voice();
    level thread function_ced15c18();
}

// Namespace cp_mi_sing_biodomes_sound
// Params 0
// Checksum 0x763566bc, Offset: 0x1b0
// Size: 0x5c
function function_ced15c18()
{
    wait 2;
    sound_org = spawn( "script_origin", ( 15049, 15030, 136 ) );
    sound_org playloopsound( "mus_bar_background" );
}

#namespace namespace_f1b4cbbc;

// Namespace namespace_f1b4cbbc
// Params 0
// Checksum 0xf8ed7d8d, Offset: 0x218
// Size: 0x1c
function function_973b77f9()
{
    music::setmusicstate( "none" );
}

// Namespace namespace_f1b4cbbc
// Params 0
// Checksum 0x7b7c4d9e, Offset: 0x240
// Size: 0x1c
function function_f936f64e()
{
    music::setmusicstate( "igc_intro" );
}

// Namespace namespace_f1b4cbbc
// Params 0
// Checksum 0xacbd6feb, Offset: 0x268
// Size: 0x1c
function function_fa2e45b8()
{
    music::setmusicstate( "battle_1" );
}

// Namespace namespace_f1b4cbbc
// Params 0
// Checksum 0xc53e4e01, Offset: 0x290
// Size: 0x1c
function function_6c35b4f3()
{
    music::setmusicstate( "battle_2" );
}

// Namespace namespace_f1b4cbbc
// Params 0
// Checksum 0x9807f2d6, Offset: 0x2b8
// Size: 0x1c
function function_ac7f09b1()
{
    music::setmusicstate( "warlord" );
}

// Namespace namespace_f1b4cbbc
// Params 0
// Checksum 0xc357b09c, Offset: 0x2e0
// Size: 0x1c
function function_2e34977e()
{
    music::setmusicstate( "siegebot" );
}

// Namespace namespace_f1b4cbbc
// Params 0
// Checksum 0x6b787317, Offset: 0x308
// Size: 0x1c
function function_ae96b33c()
{
    music::setmusicstate( "eyes_on_xiulan" );
}

// Namespace namespace_f1b4cbbc
// Params 0
// Checksum 0xca5e675c, Offset: 0x330
// Size: 0x1c
function function_46333a8a()
{
    music::setmusicstate( "battle_3" );
}

// Namespace namespace_f1b4cbbc
// Params 0
// Checksum 0x12637052, Offset: 0x358
// Size: 0x1c
function function_6f733943()
{
    music::setmusicstate( "jump_loop" );
}

// Namespace namespace_f1b4cbbc
// Params 0
// Checksum 0x5994394, Offset: 0x380
// Size: 0x1c
function function_cc3270ca()
{
    music::setmusicstate( "jump" );
}

// Namespace namespace_f1b4cbbc
// Params 0
// Checksum 0x997234af, Offset: 0x3a8
// Size: 0x1c
function function_11139d81()
{
    music::setmusicstate( "boat_ride" );
}

// Namespace namespace_f1b4cbbc
// Params 0
// Checksum 0xfdacb23a, Offset: 0x3d0
// Size: 0x1c
function function_3919d226()
{
    music::setmusicstate( "igc_3_data_drives" );
}

