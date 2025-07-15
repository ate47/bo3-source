#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_equip_hacker;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/zm_moon_amb;
#using scripts/zm/zm_moon_sq;

#namespace zm_moon_sq_ss;

// Namespace zm_moon_sq_ss
// Params 0
// Checksum 0x81e3cc71, Offset: 0x4f8
// Size: 0x558
function ss_debug()
{
    /#
        level endon( #"sq_ss1_over" );
        level endon( #"sq_ss2_over" );
        
        if ( !isdefined( level._debug_ss ) )
        {
            level._debug_ss = 1;
            level.ss_val = newdebughudelem();
            level.ss_val.location = 0;
            level.ss_val.alignx = "<dev string:x28>";
            level.ss_val.aligny = "<dev string:x2d>";
            level.ss_val.foreground = 1;
            level.ss_val.fontscale = 1.3;
            level.ss_val.sort = 20;
            level.ss_val.x = 10;
            level.ss_val.y = 240;
            level.ss_val.og_scale = 1;
            level.ss_val.color = ( 255, 255, 255 );
            level.ss_val.alpha = 1;
            level.ss_val_text = newdebughudelem();
            level.ss_val_text.location = 0;
            level.ss_val_text.alignx = "<dev string:x34>";
            level.ss_val_text.aligny = "<dev string:x2d>";
            level.ss_val_text.foreground = 1;
            level.ss_val_text.fontscale = 1.3;
            level.ss_val_text.sort = 20;
            level.ss_val_text.x = 0;
            level.ss_val_text.y = 240;
            level.ss_val_text.og_scale = 1;
            level.ss_val_text.color = ( 255, 255, 255 );
            level.ss_val_text.alpha = 1;
            level.ss_val_text settext( "<dev string:x3a>" );
            level.ss_user_val = newdebughudelem();
            level.ss_user_val.location = 0;
            level.ss_user_val.alignx = "<dev string:x28>";
            level.ss_user_val.aligny = "<dev string:x2d>";
            level.ss_user_val.foreground = 1;
            level.ss_user_val.fontscale = 1.3;
            level.ss_user_val.sort = 20;
            level.ss_user_val.x = 10;
            level.ss_user_val.y = 270;
            level.ss_user_val.og_scale = 1;
            level.ss_user_val.color = ( 255, 255, 255 );
            level.ss_user_val.alpha = 1;
            level.ss_user_val_text = newdebughudelem();
            level.ss_user_val_text.location = 0;
            level.ss_user_val_text.alignx = "<dev string:x34>";
            level.ss_user_val_text.aligny = "<dev string:x2d>";
            level.ss_user_val_text.foreground = 1;
            level.ss_user_val_text.fontscale = 1.3;
            level.ss_user_val_text.sort = 20;
            level.ss_user_val_text.x = 0;
            level.ss_user_val_text.y = 270;
            level.ss_user_val_text.og_scale = 1;
            level.ss_user_val_text.color = ( 255, 255, 255 );
            level.ss_user_val_text.alpha = 1;
            level.ss_user_val_text settext( "<dev string:x41>" );
        }
        
        while ( true )
        {
            if ( isdefined( level._ss_user_seq ) )
            {
                str = "<dev string:x4d>";
                
                for ( i = 0; i < level._ss_user_seq.size ; i++ )
                {
                    str += level._ss_user_seq[ i ];
                }
                
                level.ss_user_val settext( str );
            }
            else
            {
                level.ss_user_val settext( "<dev string:x4d>" );
            }
            
            wait 0.1;
        }
    #/
}

// Namespace zm_moon_sq_ss
// Params 0
// Checksum 0xfb5fa100, Offset: 0xa58
// Size: 0x148
function init_1()
{
    level flag::init( "displays_active" );
    level flag::init( "wait_for_hack" );
    zm_sidequests::declare_sidequest_stage( "sq", "ss1", &init_stage_1, &stage_logic, &exit_stage_1 );
    buttons = getentarray( "sq_ss_button", "targetname" );
    
    for ( i = 0; i < buttons.size ; i++ )
    {
        ent = getent( buttons[ i ].target, "targetname" );
        buttons[ i ].terminal_model = ent;
    }
    
    level._ss_buttons = buttons;
}

// Namespace zm_moon_sq_ss
// Params 0
// Checksum 0xa272f70f, Offset: 0xba8
// Size: 0x54
function init_2()
{
    zm_sidequests::declare_sidequest_stage( "sq", "ss2", &init_stage_2, &stage_logic, &exit_stage_2 );
}

// Namespace zm_moon_sq_ss
// Params 0
// Checksum 0xef332a35, Offset: 0xc08
// Size: 0x30
function init_stage_1()
{
    level flag::clear( "wait_for_hack" );
    level._ss_stage = 1;
}

// Namespace zm_moon_sq_ss
// Params 0
// Checksum 0x7822343, Offset: 0xc40
// Size: 0x10
function init_stage_2()
{
    level._ss_stage = 2;
}

// Namespace zm_moon_sq_ss
// Params 1
// Checksum 0x1434f9e3, Offset: 0xc58
// Size: 0x2c
function ss2_hack( hacker )
{
    level flag::clear( "wait_for_hack" );
}

// Namespace zm_moon_sq_ss
// Params 0
// Checksum 0x96c969d, Offset: 0xc90
// Size: 0x10c
function stage_logic()
{
    buttons = level._ss_buttons;
    array::thread_all( buttons, &sq_ss_button_thread );
    
    if ( isdefined( level._ss_hacks ) )
    {
        for ( i = 0; i < level._ss_hacks.size ; i++ )
        {
            zm_equip_hacker::deregister_hackable_struct( level._ss_hacks[ i ] );
        }
    }
    
    level thread ss_debug();
    
    if ( level._ss_stage == 1 )
    {
        do_ss1_logic();
    }
    else
    {
        do_ss2_logic();
    }
    
    zm_sidequests::stage_completed( "sq", "ss" + level._ss_stage );
}

// Namespace zm_moon_sq_ss
// Params 0
// Checksum 0xec3fe8a, Offset: 0xda8
// Size: 0x1c
function do_ss1_logic()
{
    ss_logic( 6, 1 );
}

// Namespace zm_moon_sq_ss
// Params 0
// Checksum 0x95617ab, Offset: 0xdd0
// Size: 0x9e
function do_ss2_logic()
{
    level.ss_comp_vox_count = 0;
    ss_logic( 6, 3 );
    wait 2;
    level notify( #"rl" );
    ss_logic( 7, 4 );
    wait 2;
    level notify( #"rl" );
    ss_logic( 8, 5 );
    wait 2;
    level notify( #"rl" );
}

// Namespace zm_moon_sq_ss
// Params 1
// Checksum 0xa83b18e, Offset: 0xe78
// Size: 0x214
function generate_sequence( seq_length )
{
    seq = [];
    
    for ( i = 0; i < seq_length ; i++ )
    {
        seq[ seq.size ] = randomintrange( 0, 4 );
    }
    
    last = -1;
    num_reps = 0;
    
    for ( i = 0; i < seq_length ; i++ )
    {
        if ( seq[ i ] == last )
        {
            num_reps++;
            
            if ( num_reps >= 2 )
            {
                while ( seq[ i ] == last )
                {
                    seq[ i ] = randomintrange( 0, 4 );
                }
                
                num_reps = 0;
                last = seq[ i ];
            }
            
            continue;
        }
        
        last = seq[ i ];
        num_reps = 0;
    }
    
    /#
        if ( isdefined( level.ss_val ) )
        {
            str = "<dev string:x4d>";
            
            for ( i = 0; i < seq.size ; i++ )
            {
                str += seq[ i ];
            }
            
            level.ss_val settext( str );
        }
    #/
    
    if ( 1 == getdvarint( "scr_debug_ss" ) )
    {
        for ( i = 0; i < seq.size ; i++ )
        {
            seq[ i ] = 0;
        }
    }
    
    return seq;
}

// Namespace zm_moon_sq_ss
// Params 0
// Checksum 0xb561c824, Offset: 0x1098
// Size: 0x9e
function kill_debug()
{
    /#
        if ( isdefined( level.ss_val ) )
        {
            level.ss_val destroy();
            level.ss_val = undefined;
            level.ss_val_text destroy();
            level.ss_val_text = undefined;
            level.ss_user_val destroy();
            level.ss_user_val = undefined;
            level.ss_user_val_text destroy();
            level.ss_user_val_text = undefined;
            level._debug_ss = undefined;
        }
    #/
}

// Namespace zm_moon_sq_ss
// Params 1
// Checksum 0x4897c184, Offset: 0x1140
// Size: 0x64
function exit_stage_1( success )
{
    kill_debug();
    level flag::set( "ss1" );
    array::thread_all( level._ss_buttons, &sq_ss_button_dud_thread );
}

// Namespace zm_moon_sq_ss
// Params 1
// Checksum 0x35538cd9, Offset: 0x11b0
// Size: 0x1c
function exit_stage_2( success )
{
    kill_debug();
}

// Namespace zm_moon_sq_ss
// Params 0
// Checksum 0x2fb6565a, Offset: 0x11d8
// Size: 0x24
function sq_ss_button_dud_thread()
{
    self endon( #"ss_kill_button_thread" );
    self thread sq_ss_button_thread( 1 );
}

// Namespace zm_moon_sq_ss
// Params 0
// Checksum 0x73135c14, Offset: 0x1208
// Size: 0x80
function sq_ss_button_debug()
{
    level endon( #"ss_kill_button_thread" );
    level endon( #"sq_ss1_over" );
    level endon( #"sq_ss2_over" );
    
    while ( true )
    {
        /#
            print3d( self.origin + ( 0, 0, 12 ), self.script_int, ( 0, 255, 0 ), 1 );
        #/
        
        wait 0.1;
    }
}

// Namespace zm_moon_sq_ss
// Params 0
// Checksum 0x125ac8b, Offset: 0x1290
// Size: 0x35c
function do_attract()
{
    level flag::set( "displays_active" );
    buttons = level._ss_buttons;
    
    for ( i = 0; i < buttons.size ; i++ )
    {
        ent = buttons[ i ].terminal_model;
        ent setmodel( "p7_zm_moo_computer_rocket_launch" );
    }
    
    for ( i = 0; i < buttons.size ; i++ )
    {
        button = undefined;
        
        for ( j = 0; j < buttons.size ; j++ )
        {
            if ( buttons[ j ].script_int == i )
            {
                button = buttons[ j ];
            }
        }
        
        if ( isdefined( button ) )
        {
            ent = button.terminal_model;
            model = get_console_model( button.script_int );
            ent setmodel( model );
            ent playsound( color_sound_selector( button.script_int ) );
            wait 0.6;
            ent setmodel( "p7_zm_moo_computer_rocket_launch" );
        }
    }
    
    level thread do_ss_start_vox( level._ss_stage );
    
    for ( i = buttons.size - 1; i >= 0 ; i-- )
    {
        button = undefined;
        
        for ( j = 0; j < buttons.size ; j++ )
        {
            if ( buttons[ j ].script_int == i )
            {
                button = buttons[ j ];
            }
        }
        
        if ( isdefined( button ) )
        {
            ent = button.terminal_model;
            model = get_console_model( button.script_int );
            ent setmodel( model );
            ent playsound( color_sound_selector( button.script_int ) );
            wait 0.6;
            ent setmodel( "p7_zm_moo_computer_rocket_launch" );
        }
    }
    
    wait 0.5;
    level flag::clear( "displays_active" );
}

// Namespace zm_moon_sq_ss
// Params 1
// Checksum 0x9842501f, Offset: 0x15f8
// Size: 0x190
function sq_ss_button_thread( dud )
{
    level endon( #"sq_ss1_over" );
    level endon( #"sq_ss2_over" );
    
    if ( !isdefined( dud ) )
    {
        self notify( #"ss_kill_button_thread" );
    }
    
    pos = self.origin;
    pressed = self.origin - anglestoright( self.angles ) * 0.25;
    targ_model = self.terminal_model;
    
    while ( true )
    {
        self waittill( #"trigger" );
        
        if ( !level flag::get( "displays_active" ) )
        {
            if ( !isdefined( dud ) )
            {
                if ( isdefined( level._ss_user_seq ) )
                {
                    level._ss_user_seq[ level._ss_user_seq.size ] = self.script_int;
                }
            }
            
            model = get_console_model( self.script_int );
            targ_model playsound( color_sound_selector( self.script_int ) );
            targ_model setmodel( model );
        }
        
        wait 0.3;
        targ_model setmodel( "p7_zm_moo_computer_rocket_launch" );
    }
}

// Namespace zm_moon_sq_ss
// Params 1
// Checksum 0xa6bf3dcd, Offset: 0x1790
// Size: 0x96
function get_console_model( num )
{
    model = "p7_zm_moo_computer_rocket_launch";
    
    switch ( num )
    {
        case 0:
            model = "p7_zm_moo_computer_rocket_launch_red";
            break;
        case 1:
            model = "p7_zm_moo_computer_rocket_launch_green";
            break;
        case 2:
            model = "p7_zm_moo_computer_rocket_launch_blue";
            break;
        case 3:
            model = "p7_zm_moo_computer_rocket_launch_yellow";
            break;
    }
    
    return model;
}

// Namespace zm_moon_sq_ss
// Params 2
// Checksum 0x30da104d, Offset: 0x1830
// Size: 0x12c
function ss_logic( seq_length, seq_start_length )
{
    seq = generate_sequence( seq_length );
    level._ss_user_seq = [];
    level._ss_sequence_matched = 0;
    
    for ( fails = 0; !level._ss_sequence_matched ; fails = 0 )
    {
        wait 0.5;
        self thread ss_logic_internal( seq, seq_length, seq_start_length );
        self util::waittill_either( "ss_won", "ss_failed" );
        
        if ( level._ss_sequence_matched )
        {
            display_success( seq );
            continue;
        }
        
        display_fail();
        fails++;
        
        if ( fails == 4 )
        {
            seq = generate_sequence( seq_length );
        }
    }
}

// Namespace zm_moon_sq_ss
// Params 3
// Checksum 0x5bdaaeee, Offset: 0x1968
// Size: 0x102
function ss_logic_internal( seq, seq_length, seq_start_length )
{
    self endon( #"ss_won" );
    self endon( #"ss_failed" );
    do_attract();
    pos = seq_start_length;
    buttons = level._ss_buttons;
    
    for ( i = pos; i <= seq_length ; i++ )
    {
        level._ss_user_seq = [];
        display_seq( buttons, seq, i );
        wait 1;
        validate_input( seq, i );
        wait 1;
    }
    
    level._ss_sequence_matched = 1;
    self notify( #"ss_won" );
}

// Namespace zm_moon_sq_ss
// Params 1
// Checksum 0xe3680651, Offset: 0x1a78
// Size: 0x46
function user_input_timeout( len )
{
    self endon( #"correct_input" );
    self endon( #"ss_failed" );
    self endon( #"ss_won" );
    wait len * 4;
    self notify( #"ss_failed" );
}

// Namespace zm_moon_sq_ss
// Params 2
// Checksum 0xd9e1ce6c, Offset: 0x1ac8
// Size: 0x10e
function validate_input( sequence, len )
{
    self thread user_input_timeout( len );
    
    while ( level._ss_user_seq.size < len )
    {
        for ( i = 0; i < level._ss_user_seq.size ; i++ )
        {
            if ( level._ss_user_seq[ i ] != sequence[ i ] )
            {
                self notify( #"ss_failed" );
            }
        }
        
        wait 0.05;
    }
    
    for ( i = 0; i < level._ss_user_seq.size ; i++ )
    {
        if ( level._ss_user_seq[ i ] != sequence[ i ] )
        {
            self notify( #"ss_failed" );
        }
    }
    
    level._ss_user_seq = [];
    self notify( #"correct_input" );
}

// Namespace zm_moon_sq_ss
// Params 0
// Checksum 0x2087a31d, Offset: 0x1be0
// Size: 0x234
function display_fail()
{
    level flag::set( "displays_active" );
    buttons = level._ss_buttons;
    level thread do_ss_failure_vox( level._ss_stage );
    all_screens_black = 0;
    
    while ( !all_screens_black )
    {
        all_screens_black = 1;
        
        for ( i = 0; i < buttons.size ; i++ )
        {
            ent = buttons[ i ].terminal_model;
            
            if ( ent.model != "p7_zm_moo_computer_rocket_launch" )
            {
                all_screens_black = 0;
                break;
            }
        }
        
        wait 0.1;
    }
    
    level thread sound::play_in_space( "evt_ss_wrong", ( -1006.3, 294.2, -93.7 ) );
    
    for ( i = 0; i < 5 ; i++ )
    {
        for ( j = 0; j < buttons.size ; j++ )
        {
            ent = buttons[ j ].terminal_model;
            ent setmodel( "p7_zm_moo_computer_rocket_launch_red" );
        }
        
        wait 0.2;
        
        for ( j = 0; j < buttons.size ; j++ )
        {
            ent = buttons[ j ].terminal_model;
            ent setmodel( "p7_zm_moo_computer_rocket_launch" );
        }
        
        wait 0.05;
    }
    
    level flag::clear( "displays_active" );
}

// Namespace zm_moon_sq_ss
// Params 1
// Checksum 0x9267e87a, Offset: 0x1e20
// Size: 0x86
function play_win_seq( seq )
{
    for ( i = 0; i < seq.size ; i++ )
    {
        level thread sound::play_in_space( color_sound_selector( seq[ i ] ), ( -1006.3, 294.2, -93.7 ) );
        wait 0.2;
    }
}

// Namespace zm_moon_sq_ss
// Params 1
// Checksum 0x8df2e6be, Offset: 0x1eb0
// Size: 0x224
function display_success( seq )
{
    level flag::set( "displays_active" );
    buttons = level._ss_buttons;
    level thread do_ss_success_vox( level._ss_stage );
    all_screens_black = 0;
    
    while ( !all_screens_black )
    {
        all_screens_black = 1;
        
        for ( i = 0; i < buttons.size ; i++ )
        {
            ent = buttons[ i ].terminal_model;
            
            if ( ent.model != "p7_zm_moo_computer_rocket_launch" )
            {
                all_screens_black = 0;
                break;
            }
        }
        
        wait 0.1;
    }
    
    level thread play_win_seq( seq );
    
    for ( i = 0; i < 5 ; i++ )
    {
        for ( j = 0; j < buttons.size ; j++ )
        {
            ent = buttons[ j ].terminal_model;
            ent setmodel( "p7_zm_moo_computer_rocket_launch_green" );
        }
        
        wait 0.2;
        
        for ( j = 0; j < buttons.size ; j++ )
        {
            ent = buttons[ j ].terminal_model;
            ent setmodel( "p7_zm_moo_computer_rocket_launch" );
        }
        
        wait 0.05;
    }
    
    level flag::clear( "displays_active" );
}

// Namespace zm_moon_sq_ss
// Params 3
// Checksum 0xc48a72f5, Offset: 0x20e0
// Size: 0x21c
function display_seq( buttons, seq, index )
{
    level flag::set( "displays_active" );
    
    for ( i = 0; i < index ; i++ )
    {
        print_duration = 1;
        wait_duration = 0.4;
        
        if ( i < index - 1 )
        {
            print_duration /= 2;
            wait_duration /= 2;
        }
        
        for ( j = 0; j < buttons.size ; j++ )
        {
            ent = buttons[ j ].terminal_model;
            model = get_console_model( seq[ i ] );
            level thread sound::play_in_space( color_sound_selector( seq[ i ] ), ( -1006.3, 294.2, -93.7 ) );
            ent setmodel( model );
        }
        
        wait print_duration;
        
        for ( j = 0; j < buttons.size ; j++ )
        {
            ent = buttons[ j ].terminal_model;
            ent setmodel( "p7_zm_moo_computer_rocket_launch" );
        }
        
        wait wait_duration;
    }
    
    level flag::clear( "displays_active" );
}

// Namespace zm_moon_sq_ss
// Params 1
// Checksum 0x8a5a5a66, Offset: 0x2308
// Size: 0x5e
function color_sound_selector( index )
{
    switch ( index )
    {
        case 0:
            return "evt_ss_e";
        case 1:
            return "evt_ss_d";
        case 2:
            return "evt_ss_c";
        case 3:
            return "evt_ss_lo_g";
    }
}

// Namespace zm_moon_sq_ss
// Params 1
// Checksum 0xe3adb3b6, Offset: 0x2370
// Size: 0x104
function do_ss_start_vox( stage )
{
    playon = level._ss_buttons[ 1 ].terminal_model;
    
    if ( stage == 1 )
    {
        player = is_player_close_enough( playon );
        
        if ( isdefined( player ) )
        {
            playon playsoundwithnotify( "vox_mcomp_quest_step1_0", "mcomp_done0" );
            playon waittill( #"mcomp_done0" );
            
            if ( isdefined( player ) )
            {
                player thread zm_audio::create_and_play_dialog( "eggs", "quest1", 0 );
            }
        }
        
        return;
    }
    
    if ( level.ss_comp_vox_count == 0 )
    {
        playon playsoundwithnotify( "vox_mcomp_quest_step7_0", "mcomp_done1" );
    }
}

// Namespace zm_moon_sq_ss
// Params 1
// Checksum 0x4b6f772b, Offset: 0x2480
// Size: 0x1ae
function do_ss_failure_vox( stage )
{
    playon = level._ss_buttons[ 1 ].terminal_model;
    
    if ( stage == 1 )
    {
        player = is_player_close_enough( playon );
        
        if ( isdefined( player ) )
        {
            playon playsoundwithnotify( "vox_mcomp_quest_step1_1", "mcomp_done2" );
            playon waittill( #"mcomp_done2" );
            
            if ( isdefined( player ) )
            {
                player thread zm_audio::create_and_play_dialog( "eggs", "quest1", 1 );
            }
        }
        
        return;
    }
    
    player = is_player_close_enough( playon );
    
    if ( isdefined( player ) )
    {
        switch ( level.ss_comp_vox_count )
        {
            case 0:
                player thread zm_audio::create_and_play_dialog( "eggs", "quest1", 1 );
                break;
            case 1:
                player thread zm_audio::create_and_play_dialog( "eggs", "quest7", 1 );
                break;
            case 2:
                player thread zm_audio::create_and_play_dialog( "eggs", "quest7", 3 );
                break;
        }
    }
}

// Namespace zm_moon_sq_ss
// Params 1
// Checksum 0xe8b3a417, Offset: 0x2638
// Size: 0x1d6
function do_ss_success_vox( stage )
{
    playon = level._ss_buttons[ 1 ].terminal_model;
    
    if ( stage == 1 )
    {
        player = is_player_close_enough( playon );
        
        if ( isdefined( player ) )
        {
            playon playsoundwithnotify( "vox_mcomp_quest_step1_2", "mcomp_done3" );
            playon waittill( #"mcomp_done3" );
            
            if ( isdefined( player ) )
            {
                player thread zm_audio::create_and_play_dialog( "eggs", "quest1", 2 );
            }
        }
        
        return;
    }
    
    switch ( level.ss_comp_vox_count )
    {
        case 0:
            playon playsoundwithnotify( "vox_mcomp_quest_step7_2", "mcomp_done4" );
            level.ss_comp_vox_count++;
            break;
        case 1:
            playon playsoundwithnotify( "vox_mcomp_hack_success", "mcomp_done5" );
            level.ss_comp_vox_count++;
            break;
        case 2:
            playon playsoundwithnotify( "vox_mcomp_quest_step7_4", "mcomp_done6" );
            playon waittill( #"mcomp_done6" );
            
            if ( !level flag::get( "be2" ) )
            {
                playon playsoundwithnotify( "vox_xcomp_quest_step7_5", "xcomp_done7" );
            }
            
            break;
    }
}

// Namespace zm_moon_sq_ss
// Params 1
// Checksum 0x2f4139b1, Offset: 0x2818
// Size: 0x9c
function is_player_close_enough( org )
{
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( distancesquared( org.origin, players[ i ].origin ) <= 5625 )
        {
            return players[ i ];
        }
    }
    
    return undefined;
}

