#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;

#namespace mp_ethiopia_sound;

// Namespace mp_ethiopia_sound
// Params 0
// Checksum 0xc6c346d, Offset: 0x108
// Size: 0x4c
function main()
{
    level thread snd_dmg_monk();
    level thread snd_dmg_cheet();
    level thread snd_dmg_boar();
}

// Namespace mp_ethiopia_sound
// Params 0
// Checksum 0x14146546, Offset: 0x160
// Size: 0x9e
function snd_dmg_monk()
{
    trigger = getent( "snd_monkey", "targetname" );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", who );
        
        if ( isplayer( who ) )
        {
            trigger playsound( "amb_monkey_shot" );
            wait 15;
        }
    }
}

// Namespace mp_ethiopia_sound
// Params 0
// Checksum 0x3fcf38f, Offset: 0x208
// Size: 0x9e
function snd_dmg_cheet()
{
    trigger = getent( "snd_cheet", "targetname" );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", who );
        
        if ( isplayer( who ) )
        {
            trigger playsound( "amb_cheeta_shot" );
            wait 15;
        }
    }
}

// Namespace mp_ethiopia_sound
// Params 0
// Checksum 0xc97a31f, Offset: 0x2b0
// Size: 0x9e
function snd_dmg_boar()
{
    trigger = getent( "snd_boar", "targetname" );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", who );
        
        if ( isplayer( who ) )
        {
            trigger playsound( "amb_boar_shot" );
            wait 15;
        }
    }
}

