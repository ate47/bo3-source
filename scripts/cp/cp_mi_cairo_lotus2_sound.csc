#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;

#namespace cp_mi_cairo_lotus2_sound;

// Namespace cp_mi_cairo_lotus2_sound
// Params 0
// Checksum 0xd287ea97, Offset: 0x110
// Size: 0x7c
function main()
{
    level thread function_ceb762bb();
    level thread function_b22d6998();
    level thread function_92b27557();
    level thread function_20ab061c();
    level thread function_46ad8085();
}

// Namespace cp_mi_cairo_lotus2_sound
// Params 0
// Checksum 0x79381dac, Offset: 0x198
// Size: 0x2c
function function_ceb762bb()
{
    level waittill( #"hash_2ac6dc33" );
    audio::snd_set_snapshot( "cp_lotus_vtol_hallway" );
}

// Namespace cp_mi_cairo_lotus2_sound
// Params 0
// Checksum 0x367be17f, Offset: 0x1d0
// Size: 0x2c
function function_b22d6998()
{
    level waittill( #"hash_bb262c24" );
    audio::snd_set_snapshot( "default" );
}

// Namespace cp_mi_cairo_lotus2_sound
// Params 0
// Checksum 0xc32806f6, Offset: 0x208
// Size: 0xb4
function function_92b27557()
{
    trigger = getent( 0, "stress_1", "targetname" );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", who );
        
        if ( who isplayer() )
        {
            playsound( 0, "amb_metal_shake", ( -1015, -323, 15307 ) );
            break;
        }
    }
}

// Namespace cp_mi_cairo_lotus2_sound
// Params 0
// Checksum 0x7893866f, Offset: 0x2c8
// Size: 0xb4
function function_20ab061c()
{
    trigger = getent( 0, "stress_2", "targetname" );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", who );
        
        if ( who isplayer() )
        {
            playsound( 0, "amb_metal_shake", ( -852, -280, 15407 ) );
            break;
        }
    }
}

// Namespace cp_mi_cairo_lotus2_sound
// Params 0
// Checksum 0xb60aa7f0, Offset: 0x388
// Size: 0xb4
function function_46ad8085()
{
    trigger = getent( 0, "stress_3", "targetname" );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", who );
        
        if ( who isplayer() )
        {
            playsound( 0, "amb_metal_shake", ( -11199, -65, 15377 ) );
            break;
        }
    }
}

