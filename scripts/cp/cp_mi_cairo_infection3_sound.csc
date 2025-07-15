#using scripts/codescripts/struct;

#namespace cp_mi_cairo_infection3_sound;

// Namespace cp_mi_cairo_infection3_sound
// Params 0
// Checksum 0x44c61e1b, Offset: 0xb0
// Size: 0x1c
function main()
{
    level thread function_aa67a452();
}

// Namespace cp_mi_cairo_infection3_sound
// Params 0
// Checksum 0x64e06536, Offset: 0xd8
// Size: 0xd0
function function_aa67a452()
{
    while ( true )
    {
        playsound( 0, "amb_cold_gusts", ( 27434, 389, -3117 ) );
        wait randomintrange( 1, 3 );
        playsound( 0, "amb_cold_gusts", ( 27491, 841, -3118 ) );
        wait randomintrange( 1, 2 );
        playsound( 0, "amb_cold_gusts", ( 27128, 535, -3112 ) );
        wait randomintrange( 0, 2 );
    }
}

