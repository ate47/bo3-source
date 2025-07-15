#using scripts/codescripts/struct;

#namespace mp_stronghold_sound;

// Namespace mp_stronghold_sound
// Params 0
// Checksum 0x877e1b58, Offset: 0xb8
// Size: 0x1c
function main()
{
    level thread snd_dmg_chant();
}

// Namespace mp_stronghold_sound
// Params 0
// Checksum 0xd411dbb5, Offset: 0xe0
// Size: 0x98
function snd_dmg_chant()
{
    trigger = getent( "snd_chant", "targetname" );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", who );
        
        if ( isplayer( who ) )
        {
            trigger playsound( "amb_monk_chant" );
        }
    }
}

