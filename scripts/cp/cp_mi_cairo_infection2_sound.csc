#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;

#namespace cp_mi_cairo_infection2_sound;

// Namespace cp_mi_cairo_infection2_sound
// Params 0
// Checksum 0x4bf0e825, Offset: 0x250
// Size: 0x7c
function main()
{
    level thread church_bells();
    level thread rock_gap_1();
    level thread rock_gap_2();
    level thread rock_gap_3();
    level thread function_f744d326();
}

// Namespace cp_mi_cairo_infection2_sound
// Params 0
// Checksum 0xd0df37b1, Offset: 0x2d8
// Size: 0xb4
function church_bells()
{
    trigger = getent( 0, "bells", "targetname" );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", who );
        
        if ( who isplayer() )
        {
            playsound( 0, "amb_church_bell", ( -47231, 3435, 1024 ) );
            break;
        }
    }
}

// Namespace cp_mi_cairo_infection2_sound
// Params 0
// Checksum 0xe15d4293, Offset: 0x398
// Size: 0xb4
function rock_gap_1()
{
    trigger = getent( 0, "rock_gap_1", "targetname" );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", who );
        
        if ( who isplayer() )
        {
            playsound( 0, "amb_rock_gap_1", ( 235, 112, -692 ) );
            break;
        }
    }
}

// Namespace cp_mi_cairo_infection2_sound
// Params 0
// Checksum 0x2796d498, Offset: 0x458
// Size: 0xb4
function rock_gap_2()
{
    trigger = getent( 0, "rock_gap_2", "targetname" );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", who );
        
        if ( who isplayer() )
        {
            playsound( 0, "amb_rock_gap_2", ( 683, 189, -725 ) );
            break;
        }
    }
}

// Namespace cp_mi_cairo_infection2_sound
// Params 0
// Checksum 0xb2c393a2, Offset: 0x518
// Size: 0xb4
function rock_gap_3()
{
    trigger = getent( 0, "rock_gap_3", "targetname" );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", who );
        
        if ( who isplayer() )
        {
            playsound( 0, "amb_rock_gap_3", ( 1122, 101, -736 ) );
            break;
        }
    }
}

// Namespace cp_mi_cairo_infection2_sound
// Params 0
// Checksum 0x30de3d50, Offset: 0x5d8
// Size: 0x154
function function_f744d326()
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    audio::playloopat( "vox_infc_salim_journal_001_salm", ( 5838, 144, -293 ) );
    audio::playloopat( "vox_infc_salim_journal_002_salm", ( -8985, 817, 241 ) );
    audio::playloopat( "vox_infc_salim_journal_003_salm", ( -7119, -1047, -53 ) );
    audio::playloopat( "vox_infc_salim_journal_004_salm", ( -3796, 702, -187 ) );
    audio::playloopat( "vox_infc_salim_journal_005_salm", ( -8370, 778, 153 ) );
    audio::playloopat( "vox_infc_salim_journal_006_salm", ( -67200, -4096, 314 ) );
    audio::playloopat( "vox_infc_salim_journal_007_salm", ( -48043, -1388, 282 ) );
    audio::playloopat( "vox_infc_salim_journal_008_salm", ( -47788, 2077, 515 ) );
}

