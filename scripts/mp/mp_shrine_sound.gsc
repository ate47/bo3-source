#using scripts/codescripts/struct;

#namespace mp_shrine_sound;

// Namespace mp_shrine_sound
// Params 0
// Checksum 0x746d049a, Offset: 0xb8
// Size: 0x1c
function main()
{
    level thread function_12a90c0c();
}

// Namespace mp_shrine_sound
// Params 0
// Checksum 0xa1cee95e, Offset: 0xe0
// Size: 0x9e
function function_12a90c0c()
{
    trigger = getent( "snd_knights", "targetname" );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", who );
        
        if ( isplayer( who ) )
        {
            trigger playsound( "amb_knights" );
            wait 300;
        }
    }
}

