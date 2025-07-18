#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;

#namespace cp_mi_eth_prologue_sound;

// Namespace cp_mi_eth_prologue_sound
// Params 0
// Checksum 0x28a3cb86, Offset: 0x218
// Size: 0xf4
function main()
{
    level thread function_aca4761();
    level thread function_669e0ca5();
    level thread function_6ce0e63();
    level thread function_35acdae6();
    level thread function_9806d032();
    level thread function_c943c5e5();
    level thread function_4b8b96fe();
    level thread function_7ec0e1ae();
    level thread function_eb4e50fb();
    level thread function_889a9ace();
}

// Namespace cp_mi_eth_prologue_sound
// Params 0
// Checksum 0xcbbbe1a0, Offset: 0x318
// Size: 0xa4
function function_4b8b96fe()
{
    level audio::playloopat( "amb_jail_scene_2", ( 5582, -2060, -218 ) );
    level audio::playloopat( "amb_jail_scene_3", ( 5528, -1844, -209 ) );
    level audio::playloopat( "amb_jail_scene_4", ( 6289, -1689, -163 ) );
    level audio::playloopat( "amb_jail_scene_5", ( 5530, -1634, -265 ) );
}

// Namespace cp_mi_eth_prologue_sound
// Params 0
// Checksum 0x94cfb865, Offset: 0x3c8
// Size: 0x114
function function_aca4761()
{
    level audio::playloopat( "amb_firetruck_distant_alarm", ( -1287, -1872, 535 ) );
    level audio::playloopat( "evt_firehose", ( 581, -857, 130 ) );
    level waittill( #"hash_cfcc0f30" );
    level audio::playloopat( "amb_firetruck_close_alarm", ( -169, -585, 161 ) );
    level waittill( #"hash_da4c530f" );
    level audio::stoploopat( "amb_firetruck_distant_alarm", ( -1287, -1872, 535 ) );
    level audio::stoploopat( "amb_firetruck_close_alarm", ( -169, -585, 161 ) );
    level audio::stoploopat( "evt_firehose", ( -169, -585, 161 ) );
}

// Namespace cp_mi_eth_prologue_sound
// Params 0
// Checksum 0xdaf665e6, Offset: 0x4e8
// Size: 0x54
function function_669e0ca5()
{
    level audio::playloopat( "vox_garbled_radio_a", ( -840, -721, -13259 ) );
    level audio::playloopat( "vox_garbled_radio_b", ( -1003, -580, -13262 ) );
}

// Namespace cp_mi_eth_prologue_sound
// Params 0
// Checksum 0x2173ca22, Offset: 0x548
// Size: 0x2c
function function_6ce0e63()
{
    level audio::playloopat( "evt_halway_equipment", ( 3437, 597, -341 ) );
}

// Namespace cp_mi_eth_prologue_sound
// Params 0
// Checksum 0x8c01de15, Offset: 0x580
// Size: 0x54
function function_eddf6028()
{
    level waittill( #"hash_6e2fd964" );
    audio::snd_set_snapshot( "cp_prologue_exit_apc" );
    level waittill( #"hash_36f74bd3" );
    audio::snd_set_snapshot( "default" );
}

// Namespace cp_mi_eth_prologue_sound
// Params 0
// Checksum 0x99ec1590, Offset: 0x5e0
// Size: 0x4
function function_35acdae6()
{
    
}

// Namespace cp_mi_eth_prologue_sound
// Params 0
// Checksum 0x6ea67287, Offset: 0x5f0
// Size: 0xfc
function function_9806d032()
{
    level waittill( #"sndStartGarage" );
    level endon( #"hash_73c9d58d" );
    location1 = ( 15816, -749, 454 );
    location2 = ( 15248, -749, 463 );
    location3 = ( 15807, -1927, 478 );
    
    for ( count = 0; true ; count++ )
    {
        level thread function_ab91e7b9( location1 );
        
        if ( count > 5 )
        {
            level thread function_ab91e7b9( location2 );
        }
        
        if ( count > 10 )
        {
            level thread function_ab91e7b9( location3 );
        }
        
        wait 1;
    }
}

// Namespace cp_mi_eth_prologue_sound
// Params 1
// Checksum 0x682ab48b, Offset: 0x6f8
// Size: 0x4c
function function_ab91e7b9( location )
{
    wait randomfloatrange( 0.25, 2 );
    playsound( 0, "evt_garage_robot_hit", location );
}

// Namespace cp_mi_eth_prologue_sound
// Params 0
// Checksum 0x9cb278cc, Offset: 0x750
// Size: 0x74
function function_c943c5e5()
{
    level waittill( #"saw" );
    wait 5;
    level notify( #"hash_f8c8ddf6" );
    audio::playloopat( "amb_base_distant_walla", ( 12187, -167, 1183 ) );
    audio::playloopat( "amb_base_alert_outside", ( 14740, -1188, 751 ) );
}

// Namespace cp_mi_eth_prologue_sound
// Params 0
// Checksum 0x56a57403, Offset: 0x7d0
// Size: 0x74
function function_7ec0e1ae()
{
    level waittill( #"hash_dade54fb" );
    audio::playloopat( "amb_distant_soldier_walla", ( 8160, 756, 270 ) );
    level waittill( #"sndStartFakeBattle" );
    level waittill( #"sndStartFakeBattle" );
    audio::stoploopat( "amb_distant_soldier_walla", ( 8160, 756, 270 ) );
}

// Namespace cp_mi_eth_prologue_sound
// Params 0
// Checksum 0xa8ca2e, Offset: 0x850
// Size: 0x64
function function_eb4e50fb()
{
    level waittill( #"hash_caebb0ab" );
    audio::playloopat( "amb_distant_soldier_walla", ( 12604, 1857, 357 ) );
    level waittill( #"hash_f8c8ddf6" );
    audio::stoploopat( "amb_distant_soldier_walla", ( 12604, 1857, 357 ) );
}

// Namespace cp_mi_eth_prologue_sound
// Params 0
// Checksum 0xda0c9e29, Offset: 0x8c0
// Size: 0x294
function function_889a9ace()
{
    level waittill( #"hash_dccb7956" );
    audio::playloopat( "amb_darkbattle_battery_beep", ( 13849, 2832, 226 ) );
    audio::playloopat( "amb_darkbattle_battery_beep", ( 13521, 3259, 229 ) );
    audio::playloopat( "amb_darkbattle_battery_beep", ( 13287, 3267, 226 ) );
    audio::playloopat( "amb_darkbattle_battery_beep", ( 13584, 2694, 253 ) );
    audio::playloopat( "amb_darkbattle_battery_beep", ( 13008, 2740, 249 ) );
    audio::playloopat( "amb_darkbattle_battery_beep", ( 13008, 2549, 249 ) );
    audio::playloopat( "amb_darkbattle_battery_beep", ( 13147, 2544, 245 ) );
    audio::playloopat( "amb_darkbattle_battery_beep", ( 13870, 2403, 242 ) );
    level waittill( #"hash_e94a4dcf" );
    audio::stoploopat( "amb_darkbattle_battery_beep", ( 13849, 2832, 226 ) );
    audio::stoploopat( "amb_darkbattle_battery_beep", ( 13521, 3259, 229 ) );
    audio::stoploopat( "amb_darkbattle_battery_beep", ( 13287, 3267, 226 ) );
    audio::stoploopat( "amb_darkbattle_battery_beep", ( 13584, 2694, 253 ) );
    audio::stoploopat( "amb_darkbattle_battery_beep", ( 13008, 2740, 249 ) );
    audio::stoploopat( "amb_darkbattle_battery_beep", ( 13008, 2549, 249 ) );
    audio::stoploopat( "amb_darkbattle_battery_beep", ( 13147, 2544, 245 ) );
    audio::stoploopat( "amb_darkbattle_battery_beep", ( 13870, 2403, 242 ) );
}

