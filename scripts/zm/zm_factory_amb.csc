#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/music_shared;

#namespace zm_factory_amb;

// Namespace zm_factory_amb
// Params 0
// Checksum 0x24a0c2d2, Offset: 0x410
// Size: 0x144
function main()
{
    thread start_lights();
    thread teleport_pad_init( 0 );
    thread teleport_pad_init( 1 );
    thread teleport_pad_init( 2 );
    thread teleport_2d();
    thread pa_init( 0 );
    thread pa_init( 1 );
    thread pa_init( 2 );
    thread pa_single_init();
    thread homepad_loop();
    thread power_audio_2d();
    thread linkall_2d();
    thread crazy_power();
    thread flip_sparks();
    thread play_added_ambience();
    thread play_flux_whispers();
    thread play_backwards_children();
}

// Namespace zm_factory_amb
// Params 0
// Checksum 0xc23d6fbb, Offset: 0x560
// Size: 0x114
function start_lights()
{
    level waittill( #"pl1" );
    array::thread_all( struct::get_array( "dyn_light", "targetname" ), &light_sound );
    array::thread_all( struct::get_array( "switch_progress", "targetname" ), &switch_progress_sound );
    array::thread_all( struct::get_array( "dyn_generator", "targetname" ), &generator_sound );
    array::thread_all( struct::get_array( "dyn_breakers", "targetname" ), &breakers_sound );
}

// Namespace zm_factory_amb
// Params 0
// Checksum 0x405d6fc8, Offset: 0x680
// Size: 0x60
function light_sound()
{
    if ( isdefined( self ) )
    {
        playsound( 0, "evt_light_start", self.origin );
        e1 = audio::playloopat( "amb_light_buzz", self.origin );
    }
}

// Namespace zm_factory_amb
// Params 0
// Checksum 0x22b764b1, Offset: 0x6e8
// Size: 0x88
function generator_sound()
{
    if ( isdefined( self ) )
    {
        wait 3;
        playsound( 0, "evt_switch_progress", self.origin );
        playsound( 0, "evt_gen_start", self.origin );
        g1 = audio::playloopat( "evt_gen_loop", self.origin );
    }
}

// Namespace zm_factory_amb
// Params 0
// Checksum 0x648ff3f0, Offset: 0x778
// Size: 0x60
function breakers_sound()
{
    if ( isdefined( self ) )
    {
        playsound( 0, "evt_break_start", self.origin );
        b1 = audio::playloopat( "evt_break_loop", self.origin );
    }
}

// Namespace zm_factory_amb
// Params 0
// Checksum 0xd093bab3, Offset: 0x7e0
// Size: 0xfc
function switch_progress_sound()
{
    if ( isdefined( self.script_noteworthy ) )
    {
        if ( self.script_noteworthy == "1" )
        {
            time = 0.5;
        }
        else if ( self.script_noteworthy == "2" )
        {
            time = 1;
        }
        else if ( self.script_noteworthy == "3" )
        {
            time = 1.5;
        }
        else if ( self.script_noteworthy == "4" )
        {
            time = 2;
        }
        else if ( self.script_noteworthy == "5" )
        {
            time = 2.5;
        }
        else
        {
            time = 0;
        }
        
        wait time;
        playsound( 0, "evt_switch_progress", self.origin );
    }
}

// Namespace zm_factory_amb
// Params 0
// Checksum 0x155eea8b, Offset: 0x8e8
// Size: 0xd4
function homepad_loop()
{
    level waittill( #"pap1" );
    homepad = struct::get( "homepad_power_looper", "targetname" );
    home_breaker = struct::get( "homepad_breaker", "targetname" );
    
    if ( isdefined( homepad ) )
    {
        audio::playloopat( "amb_homepad_power_loop", homepad.origin );
    }
    
    if ( isdefined( home_breaker ) )
    {
        audio::playloopat( "amb_break_arc", home_breaker.origin );
    }
}

// Namespace zm_factory_amb
// Params 1
// Checksum 0x127a9c24, Offset: 0x9c8
// Size: 0x134
function teleport_pad_init( pad )
{
    telepad = struct::get_array( "telepad_" + pad, "targetname" );
    telepad_loop = struct::get_array( "telepad_" + pad + "_looper", "targetname" );
    homepad = struct::get_array( "homepad", "targetname" );
    level waittill( "tp" + pad );
    array::thread_all( telepad_loop, &telepad_loop );
    array::thread_all( telepad, &teleportation_audio, pad );
    array::thread_all( homepad, &teleportation_audio, pad );
}

// Namespace zm_factory_amb
// Params 0
// Checksum 0x6b5370a1, Offset: 0xb08
// Size: 0x24
function telepad_loop()
{
    audio::playloopat( "amb_power_loop", self.origin );
}

// Namespace zm_factory_amb
// Params 1
// Checksum 0xb8d9f8a1, Offset: 0xb38
// Size: 0x138
function teleportation_audio( pad )
{
    teleport_delay = 2;
    
    while ( true )
    {
        level waittill( "tpw" + pad );
        
        if ( isdefined( self.script_sound ) )
        {
            if ( self.targetname == "telepad_" + pad )
            {
                playsound( 0, self.script_sound + "_warmup", self.origin );
                wait 2;
                playsound( 0, self.script_sound + "_cooldown", self.origin );
            }
            
            if ( self.targetname == "homepad" )
            {
                wait 2;
                playsound( 0, self.script_sound + "_warmup", self.origin );
                playsound( 0, self.script_sound + "_cooldown", self.origin );
            }
        }
    }
}

// Namespace zm_factory_amb
// Params 1
// Checksum 0x3809990e, Offset: 0xc78
// Size: 0x38
function pa_init( pad )
{
    pa_sys = struct::get_array( "pa_system", "targetname" );
}

// Namespace zm_factory_amb
// Params 0
// Checksum 0x4a951aaf, Offset: 0xcb8
// Size: 0x30
function pa_single_init()
{
    pa_sys = struct::get_array( "pa_system", "targetname" );
}

// Namespace zm_factory_amb
// Params 1
// Checksum 0xc8c2faf3, Offset: 0xcf0
// Size: 0x186
function pa_countdown( pad )
{
    level endon( "scd" + pad );
    
    while ( true )
    {
        level waittill( "pac" + pad );
        playsound( 0, "evt_pa_buzz", self.origin );
        self thread pa_play_dialog( "vox_pa_audio_link_start" );
        
        for ( count = 30; count > 0 ; count-- )
        {
            play = count == 20 || count == 15 || count <= 10;
            
            if ( play )
            {
                playsound( 0, "vox_pa_audio_link_" + count, self.origin );
            }
            
            playsound( 0, "evt_clock_tick_1sec", ( 0, 0, 0 ) );
            wait 1;
        }
        
        playsound( 0, "evt_pa_buzz", self.origin );
        wait 1.2;
        self thread pa_play_dialog( "vox_pa_audio_link_fail" );
    }
    
    wait 1;
}

// Namespace zm_factory_amb
// Params 1
// Checksum 0xb18017f4, Offset: 0xe80
// Size: 0x6c
function pa_countdown_success( pad )
{
    level waittill( "scd" + pad );
    playsound( 0, "evt_pa_buzz", self.origin );
    wait 1.2;
    self pa_play_dialog( "vox_pa_audio_act_pad_" + pad );
}

// Namespace zm_factory_amb
// Params 1
// Checksum 0xf57444a5, Offset: 0xef8
// Size: 0x80
function pa_teleport( pad )
{
    while ( true )
    {
        level waittill( "tpc" + pad );
        wait 1;
        playsound( 0, "evt_pa_buzz", self.origin );
        wait 1.2;
        self pa_play_dialog( "vox_pa_teleport_finish" );
    }
}

// Namespace zm_factory_amb
// Params 1
// Checksum 0xbd0cf2a4, Offset: 0xf80
// Size: 0xc8
function pa_electric_trap( location )
{
    while ( true )
    {
        level waittill( location );
        playsound( 0, "evt_pa_buzz", self.origin );
        wait 1.2;
        self thread pa_play_dialog( "vox_pa_trap_inuse_" + location );
        wait 48.5;
        playsound( 0, "evt_pa_buzz", self.origin );
        wait 1.2;
        self thread pa_play_dialog( "vox_pa_trap_active_" + location );
    }
}

// Namespace zm_factory_amb
// Params 1
// Checksum 0xea936ce2, Offset: 0x1050
// Size: 0xa0
function pa_play_dialog( alias )
{
    if ( !isdefined( self.pa_is_speaking ) )
    {
        self.pa_is_speaking = 0;
    }
    
    if ( self.pa_is_speaking != 1 )
    {
        self.pa_is_speaking = 1;
        self.pa_id = playsound( 0, alias, self.origin );
        
        while ( soundplaying( self.pa_id ) )
        {
            wait 0.01;
        }
        
        self.pa_is_speaking = 0;
    }
}

// Namespace zm_factory_amb
// Params 0
// Checksum 0xa79afefd, Offset: 0x10f8
// Size: 0x60
function teleport_2d()
{
    while ( true )
    {
        level waittill( #"t2d" );
        playsound( 0, "evt_teleport_2d_fnt", ( 0, 0, 0 ) );
        playsound( 0, "evt_teleport_2d_rear", ( 0, 0, 0 ) );
    }
}

// Namespace zm_factory_amb
// Params 0
// Checksum 0x824ea3f8, Offset: 0x1160
// Size: 0x34
function power_audio_2d()
{
    level waittill( #"pl1" );
    playsound( 0, "evt_power_up_2d", ( 0, 0, 0 ) );
}

// Namespace zm_factory_amb
// Params 0
// Checksum 0x4586d826, Offset: 0x11a0
// Size: 0x34
function linkall_2d()
{
    level waittill( #"pap1" );
    playsound( 0, "evt_linkall_2d", ( 0, 0, 0 ) );
}

// Namespace zm_factory_amb
// Params 0
// Checksum 0x99ec1590, Offset: 0x11e0
// Size: 0x4
function pa_level_start()
{
    
}

// Namespace zm_factory_amb
// Params 0
// Checksum 0x8f88c43d, Offset: 0x11f0
// Size: 0x5c
function pa_power_on()
{
    level waittill( #"pl1" );
    playsound( 0, "evt_pa_buzz", self.origin );
    wait 1.2;
    self pa_play_dialog( "vox_pa_power_on" );
}

// Namespace zm_factory_amb
// Params 0
// Checksum 0xe893bdc7, Offset: 0x1258
// Size: 0x64
function crazy_power()
{
    level waittill( #"pl1" );
    playsound( 0, "evt_crazy_power_left", ( -510, 394, 102 ) );
    playsound( 0, "evt_crazy_power_right", ( 554, -1696, 156 ) );
}

// Namespace zm_factory_amb
// Params 0
// Checksum 0xe2e155f9, Offset: 0x12c8
// Size: 0x64
function flip_sparks()
{
    level waittill( #"pl1" );
    playsound( 0, "evt_flip_sparks_left", ( 511, -1771, 116 ) );
    playsound( 0, "evt_flip_sparks_right", ( 550, -1771, 116 ) );
}

// Namespace zm_factory_amb
// Params 0
// Checksum 0x5de2b921, Offset: 0x1338
// Size: 0x194
function play_added_ambience()
{
    audio::playloopat( "amb_snow_transitions", ( -181, -455, 6 ) );
    audio::playloopat( "amb_snow_transitions", ( 1315, -1428, 227 ) );
    audio::playloopat( "amb_snow_transitions", ( -1365, -1597, 295 ) );
    audio::playloopat( "amb_extreme_fire_dist", ( 1892, -2563, 1613 ) );
    audio::playloopat( "amb_extreme_fire_dist", ( 1441, -1622, 1603 ) );
    audio::playloopat( "amb_extreme_fire_dist", ( -1561, 410, 1559 ) );
    audio::playloopat( "amb_extreme_fire_dist", ( 844, 2038, 915 ) );
    audio::playloopat( "amb_small_fire", ( 779, -2249, 326 ) );
    audio::playloopat( "amb_small_fire", ( -2, -1417, 124 ) );
    audio::playloopat( "amb_small_fire", ( 1878, 911, 189 ) );
}

// Namespace zm_factory_amb
// Params 0
// Checksum 0xfc07904f, Offset: 0x14d8
// Size: 0xf0
function play_flux_whispers()
{
    while ( true )
    {
        playsound( 0, "amb_creepy_whispers", ( -339, 271, 207 ) );
        playsound( 0, "amb_creepy_whispers", ( 234, 110, 310 ) );
        playsound( 0, "amb_creepy_whispers", ( -17, -564, 255 ) );
        playsound( 0, "amb_creepy_whispers", ( 743, -1859, 210 ) );
        playsound( 0, "amb_creepy_whispers", ( 790, -748, 181 ) );
        wait randomintrange( 1, 4 );
    }
}

// Namespace zm_factory_amb
// Params 0
// Checksum 0xcb1f9f96, Offset: 0x15d0
// Size: 0x40
function play_backwards_children()
{
    while ( true )
    {
        wait 60;
        playsound( 0, "amb_creepy_children", ( -2637, -2403, 413 ) );
    }
}

