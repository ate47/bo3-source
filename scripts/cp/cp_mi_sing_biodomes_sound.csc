#using scripts/codescripts/struct;

#namespace cp_mi_sing_biodomes_sound;

// Namespace cp_mi_sing_biodomes_sound
// Params 0
// Checksum 0xc3793c4b, Offset: 0x98
// Size: 0x14
function main()
{
    thread party_stop();
}

// Namespace cp_mi_sing_biodomes_sound
// Params 0
// Checksum 0x8e3a563a, Offset: 0xb8
// Size: 0x12
function party_stop()
{
    level notify( #"no_party" );
}

