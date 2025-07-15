#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/voice/voice_sgen;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/music_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_sing_sgen_sound;

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xde4df6e2, Offset: 0x548
// Size: 0x11c
function main()
{
    voice_sgen::init_voice();
    level thread raven_fly();
    level thread upper_silo_door_bang();
    level thread water_monster_scare();
    level thread robot_hallway_scare();
    level thread underwater_explosions();
    level thread underwater_bump_handling();
    level thread silo_robot_awaken();
    level thread under_silo_metal_groan();
    level thread play_dni_chamber_hum();
    level thread function_a56ceafc();
    level thread namespace_d40478f6::function_af9045f8();
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x745541e, Offset: 0x670
// Size: 0x3c
function function_a56ceafc()
{
    level flag::wait_till( "exterior_gone_hot" );
    util::clientnotify( "kw" );
}

// Namespace cp_mi_sing_sgen_sound
// Params 2
// Checksum 0xf5f91da, Offset: 0x6b8
// Size: 0x198
function sndmusicset( area, musicend )
{
    if ( !isdefined( musicend ) )
    {
        musicend = 0;
    }
    
    if ( !isdefined( area ) )
    {
        return;
    }
    
    message_mid = undefined;
    message_bot = undefined;
    
    switch ( area )
    {
        case "igc_intro":
            message_mid = "Oneshot: IGC Intro Music";
            break;
        case "quadtank_intro":
            if ( !musicend )
            {
            }
            
            break;
        case "sgen_enter":
            break;
        case "dark_battle":
            if ( !musicend )
            {
            }
            
            break;
        case "pallas":
            if ( !musicend )
            {
            }
            else
            {
                message_mid = "StopLooper: Pallas Battle Music";
                message_bot = "Oneshot: Pallas Defeat Stinger";
            }
            
            break;
        default:
            if ( !musicend )
            {
                message_mid = "Looper: Water Exit";
            }
            else
            {
                message_mid = "StopLooper: Water Exit";
                message_bot = "Oneshot: Level End";
            }
            
            break;
    }
    
    foreach ( player in level.players )
    {
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x26b0435, Offset: 0x858
// Size: 0x74
function raven_fly()
{
    trigger = getent( "amb_raven_fly", "targetname" );
    
    if ( isdefined( trigger ) )
    {
        trigger waittill( #"trigger" );
        wait 2;
        playsoundatposition( "evt_raven_caw", ( 420, -2031, 590 ) );
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x989ed2ee, Offset: 0x8d8
// Size: 0x7c
function upper_silo_door_bang()
{
    trigger = getent( "amb_door_bang_silo_office", "targetname" );
    
    if ( isdefined( trigger ) )
    {
        trigger waittill( #"trigger" );
        wait 0.5;
        playsoundatposition( "evt_door_bang", ( 660, -608, -1195 ) );
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x7cce8c57, Offset: 0x960
// Size: 0x7c
function silo_door_scare()
{
    trigger = getent( "silo_door_scare", "targetname" );
    
    if ( isdefined( trigger ) )
    {
        trigger waittill( #"trigger" );
        wait 0.5;
        playsoundatposition( "evt_silo_door_scare", ( -780, 874, -2806 ) );
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xec7a283a, Offset: 0x9e8
// Size: 0x74
function under_silo_metal_groan()
{
    trigger = getent( "evt_metal_groan_undersilo", "targetname" );
    
    if ( isdefined( trigger ) )
    {
        trigger waittill( #"trigger" );
        wait 3;
        playsoundatposition( "evt_dist_metal", ( 82, -863, -4551 ) );
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xf886a6ef, Offset: 0xa68
// Size: 0x54
function water_monster_scare()
{
    trigger = getent( "evt_water_monster", "targetname" );
    
    if ( isdefined( trigger ) )
    {
        trigger waittill( #"trigger" );
        wait 0.5;
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xfa81813f, Offset: 0xac8
// Size: 0x7c
function robot_hallway_scare()
{
    trigger = getent( "amb_robot_hallway", "targetname" );
    
    if ( isdefined( trigger ) )
    {
        trigger waittill( #"trigger" );
        wait 0.5;
        playsoundatposition( "evt_robot_hallway", ( 216, -2624, -5120 ) );
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xc5882343, Offset: 0xb50
// Size: 0x76
function underwater_explosions()
{
    water_exp_trigs = getentarray( "evt_underwater_exp", "targetname" );
    
    for ( i = 0; i < water_exp_trigs.size ; i++ )
    {
        water_exp_trigs[ i ] thread play_explosions();
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x2de4cc84, Offset: 0xbd0
// Size: 0x64
function play_explosions()
{
    target = struct::get( self.target, "targetname" );
    self waittill( #"trigger" );
    playsoundatposition( self.script_sound, target.origin );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x9b8cd85c, Offset: 0xc40
// Size: 0x76
function underwater_bump_handling()
{
    underwater_bump_trigs = getentarray( "amb_underwater_bump", "targetname" );
    
    for ( i = 0; i < underwater_bump_trigs.size ; i++ )
    {
        underwater_bump_trigs[ i ] thread play_underwater_bumps();
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xf9fcae55, Offset: 0xcc0
// Size: 0x2c
function play_underwater_bumps()
{
    self waittill( #"trigger" );
    self playsound( self.script_sound );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x7a37392d, Offset: 0xcf8
// Size: 0x76
function silo_robot_awaken()
{
    sound_locs = getentarray( "evt_robots_awaken", "targetname" );
    
    for ( i = 0; i < sound_locs.size ; i++ )
    {
        sound_locs[ i ] thread play_robot_awaken();
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xd23a1601, Offset: 0xd78
// Size: 0x70
function play_robot_awaken()
{
    self.counter = 0;
    level waittill( #"ambush" );
    
    while ( self.counter < 2 )
    {
        wait randomintrange( 0, 4 );
        self playsound( "evt_robots_awaken" );
        self.counter++;
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x6e2a122f, Offset: 0xdf0
// Size: 0x6c
function play_dni_chamber_hum()
{
    level waittill( #"enter_server" );
    sound_org = getent( "amb_dni_chamber_origin", "targetname" );
    
    if ( isdefined( sound_org ) )
    {
        sound_org playloopsound( "amb_dni_chamber_hum", 0 );
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xaf8b3fdb, Offset: 0xe68
// Size: 0x34
function function_2b89e6e8()
{
    level waittill( #"debris_hit" );
    playsoundatposition( "fly_hendricks_kick_debris_beam_b", ( -562, -326, -135 ) );
}

#namespace namespace_d40478f6;

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xf2dc225a, Offset: 0xea8
// Size: 0x1c
function function_973b77f9()
{
    music::setmusicstate( "none" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xf15f76fb, Offset: 0xed0
// Size: 0x1c
function function_3440789f()
{
    music::setmusicstate( "quad_awaken" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xd2e6c9de, Offset: 0xef8
// Size: 0x3c
function play_genlab_music()
{
    music::setmusicstate( "genlab" );
    level clientfield::set( "sndLabWalla", 0 );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x3791a247, Offset: 0xf40
// Size: 0x24
function play_robot_knock_music()
{
    wait 6;
    music::setmusicstate( "knockbot" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x96e0b574, Offset: 0xf70
// Size: 0x1c
function function_98762d53()
{
    music::setmusicstate( "pre_silo" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xb6409947, Offset: 0xf98
// Size: 0x1c
function play_robot_ambush_music()
{
    music::setmusicstate( "ambush" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xa044caef, Offset: 0xfc0
// Size: 0x1c
function function_55f6ee71()
{
    music::setmusicstate( "corvus_entrance" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xed4fffa5, Offset: 0xfe8
// Size: 0x1c
function function_3eb3d06()
{
    music::setmusicstate( "gas_battle_silo" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x26c38eac, Offset: 0x1010
// Size: 0x1c
function function_874f01d()
{
    music::setmusicstate( "elevator_ride" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xb4898008, Offset: 0x1038
// Size: 0x1c
function function_ad14681b()
{
    music::setmusicstate( "diaz_fight_part_one" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x7b37207e, Offset: 0x1060
// Size: 0x34
function function_3d554ba8()
{
    music::setmusicstate( "none" );
    wait 12;
    level thread function_fdf54ba5();
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x7b516c9, Offset: 0x10a0
// Size: 0x1c
function function_fdf54ba5()
{
    music::setmusicstate( "diaz_fight_part_two" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xc51b2a8e, Offset: 0x10c8
// Size: 0x34
function function_af5cbae3()
{
    music::setmusicstate( "none" );
    wait 10;
    level thread function_7881343b();
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x6f143d7c, Offset: 0x1108
// Size: 0x1c
function function_7881343b()
{
    music::setmusicstate( "diaz_fight_part_three" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x6e752e40, Offset: 0x1130
// Size: 0x24
function function_895a407a()
{
    wait 3;
    music::setmusicstate( "none" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xe67ed9f5, Offset: 0x1160
// Size: 0x24
function function_72ef07c3()
{
    wait 1;
    music::setmusicstate( "defend_hendrix" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x395624cb, Offset: 0x1190
// Size: 0x24
function function_5d6d7c60()
{
    wait 1;
    music::setmusicstate( "depth_charge_ambience" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x63eb81da, Offset: 0x11c0
// Size: 0x24
function function_71f06599()
{
    wait 4;
    music::setmusicstate( "silo_water" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x56705d5d, Offset: 0x11f0
// Size: 0x1c
function function_29597dc9()
{
    music::setmusicstate( "robot_hallway" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x2a410033, Offset: 0x1218
// Size: 0x1c
function robot_hallway_underscore()
{
    music::setmusicstate( "robot_hallway_underscore" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xb3f965d0, Offset: 0x1240
// Size: 0x2c
function function_af9045f8()
{
    level waittill( #"hash_ddeafd5d" );
    music::setmusicstate( "diaz_igc3" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xb69ede30, Offset: 0x1278
// Size: 0x1c
function function_34465ae6()
{
    music::setmusicstate( "dark_battle_stg" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xd88b49db, Offset: 0x12a0
// Size: 0x24
function function_4a262c0b()
{
    wait 2;
    music::setmusicstate( "dni_lab_igc2" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xdcdb2645, Offset: 0x12d0
// Size: 0x1c
function function_6cad5ce0()
{
    music::setmusicstate( "flyin_igc1" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x5cdf2ed2, Offset: 0x12f8
// Size: 0x24
function function_26fc5a92()
{
    wait 3;
    music::setmusicstate( "hendricks_bodies" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xb5701dba, Offset: 0x1328
// Size: 0x1c
function function_fb17452c()
{
    music::setmusicstate( "descent" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0xfd20ef38, Offset: 0x1350
// Size: 0x1c
function play_outro()
{
    music::setmusicstate( "outro" );
}

// Namespace namespace_d40478f6
// Params 0
// Checksum 0x88a1caeb, Offset: 0x1378
// Size: 0xdc
function function_22982c6e()
{
    playsoundatposition( "evt_sgen_hallway_scare", ( 182, -1189, -4560 ) );
    ent = spawn( "script_origin", ( 182, -1189, -4560 ) );
    ent playloopsound( "amb_sgen_corporate_jingle_scripted" );
    wait 25;
    playsoundatposition( "evt_sgen_hallway_scare_off", ( 182, -1189, -4560 ) );
    ent stoploopsound();
    ent delete();
}

