#using scripts/codescripts/struct;
#using scripts/cp/voice/voice_ramses;
#using scripts/cp/voice/voice_ramses1;
#using scripts/shared/music_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_cairo_ramses_sound;

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0x97c896de, Offset: 0x1b0
// Size: 0x84
function main()
{
    voice_ramses::init_voice();
    voice_ramses1::init_voice();
    level thread function_785c9e9c();
    level thread function_1af9b46e();
    level thread function_b23a802b();
    level thread function_aa79274f();
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0xf66de9ce, Offset: 0x240
// Size: 0x2c
function function_785c9e9c()
{
    level waittill( #"sndstopintromusic" );
    music::setmusicstate( "menendez_stinger" );
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0x19b40246, Offset: 0x278
// Size: 0x24
function function_1af9b46e()
{
    level waittill( #"hash_ca1862bd" );
    level thread ramses_sound::function_973b77f9();
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0x2e1583ce, Offset: 0x2a8
// Size: 0x2c
function function_aa79274f()
{
    level waittill( #"hash_89bfff84" );
    music::setmusicstate( "raps_intro" );
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0xf4ad8a04, Offset: 0x2e0
// Size: 0x2c
function function_abcd4714()
{
    level waittill( #"hash_8626937b" );
    music::setmusicstate( "none" );
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0xc2a49871, Offset: 0x318
// Size: 0x2c
function function_b23a802b()
{
    level waittill( #"hash_47329bcb" );
    music::setmusicstate( "post_interrogation" );
}

#namespace ramses_sound;

// Namespace ramses_sound
// Params 0
// Checksum 0x61205c66, Offset: 0x350
// Size: 0x1c
function function_4f8bda39()
{
    music::setmusicstate( "intro" );
}

// Namespace ramses_sound
// Params 0
// Checksum 0xbd230536, Offset: 0x378
// Size: 0x1c
function function_53de5c02()
{
    music::setmusicstate( "interrogation" );
}

// Namespace ramses_sound
// Params 0
// Checksum 0xac9ca406, Offset: 0x3a0
// Size: 0x24
function station_defend_music()
{
    wait 5;
    music::setmusicstate( "station_defend" );
}

// Namespace ramses_sound
// Params 0
// Checksum 0x402a7cc3, Offset: 0x3d0
// Size: 0x1c
function function_9bda9447()
{
    music::setmusicstate( "station_defend_outro" );
}

// Namespace ramses_sound
// Params 0
// Checksum 0x58a62085, Offset: 0x3f8
// Size: 0x1c
function function_973b77f9()
{
    music::setmusicstate( "none" );
}

