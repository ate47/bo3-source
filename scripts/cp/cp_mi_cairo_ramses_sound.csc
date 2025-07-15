#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;

#namespace cp_mi_cairo_ramses_sound;

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0xb91f742b, Offset: 0x190
// Size: 0x94
function main()
{
    level thread hornsndtrigger();
    level thread defibsndtrigger();
    level thread post_interview_weapon_snapshot();
    level thread vital_snd();
    level thread sndplayrandomexplosions_vtol_ride_start();
    level thread sndlevelfadeout();
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0x6bd6aad4, Offset: 0x230
// Size: 0xb4
function hornsndtrigger()
{
    trigger = getent( 0, "subway_horn", "targetname" );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", who );
        
        if ( who isplayer() )
        {
            playsound( 0, "amb_subway_horn", ( 7608, 1158, -415 ) );
            break;
        }
    }
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0x41f4937d, Offset: 0x2f0
// Size: 0xb4
function defibsndtrigger()
{
    trigger = getent( 0, "defibrillator", "targetname" );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", who );
        
        if ( who isplayer() )
        {
            playsound( 0, "amb_defibrillator", ( 7443, -1682, 74 ) );
            break;
        }
    }
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0x33fdc3d4, Offset: 0x3b0
// Size: 0x60
function sndpaannouncer()
{
    level endon( #"hosp_amb" );
    
    while ( true )
    {
        playsound( 0, "amb_hospital_pa", ( 7068, -1791, 548 ) );
        wait randomintrange( 30, 46 );
    }
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0x35118413, Offset: 0x418
// Size: 0x54
function post_interview_weapon_snapshot()
{
    level waittill( #"inv" );
    audio::snd_set_snapshot( "cp_ramses_raps_intro" );
    level waittill( #"dro" );
    audio::snd_set_snapshot( "default" );
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0xc6106376, Offset: 0x478
// Size: 0xc4
function vital_snd()
{
    if ( !isdefined( level.snd_hrt ) )
    {
        level.snd_hrt = spawn( 0, ( 6610, -2082, 66 ), "script.origin" );
    }
    
    level waittill( #"vital_sign" );
    level.snd_hrt playloopsound( "amb_heart_monitor_lp" );
    level waittill( #"hosp_amb" );
    level.snd_hrt stopallloopsounds( 0.25 );
    wait 1;
    level.snd_hrt delete();
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0x2cb02fab, Offset: 0x548
// Size: 0x188
function sndplayrandomexplosions_vtol_ride_start()
{
    level endon( #"ride_vtol" );
    spot1 = ( 10198, -9557, 755 );
    spot2 = ( 6406, -9437, 894 );
    spot3 = ( 4810, -8798, 833 );
    spot4 = ( 2412, -7377, 859 );
    spot5 = ( 28, -6302, 777 );
    spot6 = ( -257, -3146, 658 );
    spot7 = ( 334, -300, 620 );
    spots = array( spot1, spot2, spot3, spot4, spot5, spot6, spot7 );
    level waittill( #"hosp_amb" );
    
    while ( true )
    {
        spot = array::random( spots );
        playsound( 0, "exp_dist_heavy", spot );
        wait randomintrange( 3, 6 );
    }
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0
// Checksum 0xf04aabce, Offset: 0x6d8
// Size: 0x2c
function sndlevelfadeout()
{
    level waittill( #"sndlevelend" );
    audio::snd_set_snapshot( "cmn_level_fadeout" );
}

