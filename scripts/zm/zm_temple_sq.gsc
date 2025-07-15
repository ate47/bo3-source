#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_weap_shrink_ray;
#using scripts/zm/zm_temple_sq_bag;
#using scripts/zm/zm_temple_sq_brock;
#using scripts/zm/zm_temple_sq_bttp;
#using scripts/zm/zm_temple_sq_bttp2;
#using scripts/zm/zm_temple_sq_dgcwf;
#using scripts/zm/zm_temple_sq_lgs;
#using scripts/zm/zm_temple_sq_oafc;
#using scripts/zm/zm_temple_sq_ptt;
#using scripts/zm/zm_temple_sq_skits;
#using scripts/zm/zm_temple_sq_std;

#namespace zm_temple_sq;

// Namespace zm_temple_sq
// Params 0
// Checksum 0x19e9b9e7, Offset: 0x9b8
// Size: 0x674
function init()
{
    level flag::init( "pap_override" );
    level flag::init( "radio_9_played" );
    level flag::init( "gongs_resonating" );
    level flag::init( "trap_destroyed" );
    level flag::init( "radio_7_played" );
    level flag::init( "meteorite_shrunk" );
    level flag::init( "doing_bounce_around" );
    level._crystal_bounce_paths = [];
    level._crystal_bounce_paths[ 1 ] = array( 2, 4, 3, 5, 6, "R" );
    level._crystal_bounce_paths[ 2 ] = array( 1, 2, 3, 4, 1, "R" );
    level._crystal_bounce_paths[ 3 ] = array( 4, 3, 1, 3, 5, "R" );
    level._crystal_bounce_paths[ 4 ] = array( 1, 3, 2, 6, 5, "R" );
    level._crystal_bounce_paths[ 5 ] = array( 6, 5, 6, 1, 3, 5, "R" );
    level._crystal_bounce_paths[ 6 ] = array( 5, 6, 1, 4, 2, 1, 3, "M" );
    var_81c48749 = getentarray( "sq_gong", "targetname" );
    
    foreach ( var_3e9e1b32 in var_81c48749 )
    {
        var_3e9e1b32.script_vector = ( 0, 0, 40 );
    }
    
    zm_temple_sq_brock::init();
    zm_temple_sq_skits::init_skits();
    zm_sidequests::declare_sidequest( "sq", &init_sidequest, undefined, &complete_sidequest, &generic_stage_start, &generic_stage_complete );
    zm_sidequests::declare_sidequest_asset( "sq", "sq_sundial", &sundial_monitor );
    zm_sidequests::declare_sidequest_asset( "sq", "sq_sundial_button", &sundial_button );
    zm_sidequests::declare_sidequest_asset( "sq", "sq_ptt_dial", &ptt_dial_handler );
    zm_sidequests::declare_sidequest_asset( "sq", "sq_bttp2_dial", &bttp2_dial_handler );
    zm_sidequests::declare_sidequest_asset( "sq", "sq_spiketrap" );
    zm_sidequests::declare_sidequest_asset_from_struct( "sq", "sq_crystals", &crystal_handler );
    zm_sidequests::declare_sidequest_asset( "sq", "sq_gong", &gong_handler, &gong_trigger_handler );
    zm_temple_sq_oafc::init();
    zm_temple_sq_dgcwf::init();
    zm_temple_sq_lgs::init();
    zm_temple_sq_ptt::init();
    zm_temple_sq_std::init();
    zm_temple_sq_bttp::init();
    zm_temple_sq_bttp2::init();
    zm_temple_sq_bag::init();
    level._num_gongs = 0;
    randomize_gongs();
    trig = getent( "sq_dgcwf_trig", "targetname" );
    trig triggerenable( 0 );
    
    /#
        level thread force_eclipse_watcher();
        level thread raise_all_crystals();
        level thread function_e63287bf();
    #/
    
    level thread gong_watcher();
    level._sq_perk_array = array( "specialty_armorvest", "specialty_quickrevive", "specialty_fastreload", "specialty_doubletap2", "specialty_staminup", "specialty_widowswine", "specialty_deadshot", "specialty_additionalprimaryweapon" );
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x5467cfb, Offset: 0x1038
// Size: 0x94
function init_clientfield()
{
    zm_sidequests::register_sidequest_icon( "vril", 21000 );
    zm_sidequests::register_sidequest_icon( "dynamite", 21000 );
    zm_sidequests::register_sidequest_icon( "anti115", 21000 );
    clientfield::register( "scriptmover", "meteor_shrink", 21000, 1, "counter" );
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0xc902fcce, Offset: 0x10d8
// Size: 0xb6
function randomize_gongs()
{
    gongs = getentarray( "sq_gong", "targetname" );
    gongs = array::randomize( gongs );
    
    for ( i = 0; i < gongs.size ; i++ )
    {
        if ( i < 4 )
        {
            gongs[ i ].right_gong = 1;
            continue;
        }
        
        gongs[ i ].right_gong = 0;
    }
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0xf2c35c49, Offset: 0x1198
// Size: 0x126
function watch_for_respawn()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"spawned_player" );
        waittillframeend();
        self zm_sidequests::add_sidequest_icon( "sq", "anti115" );
        
        foreach ( perk in level._sq_perk_array )
        {
            if ( !self hasperk( perk ) )
            {
                if ( zm_perks::use_solo_revive() && perk == "specialty_quickrevive" )
                {
                    continue;
                }
                
                self zm_perks::give_perk( perk );
            }
        }
    }
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x88dc46dc, Offset: 0x12c8
// Size: 0xec
function reward()
{
    level notify( #"temple_sidequest_achieved" );
    self zm_sidequests::add_sidequest_icon( "sq", "anti115" );
    
    for ( i = 0; i < level._sq_perk_array.size ; i++ )
    {
        if ( !self hasperk( level._sq_perk_array[ i ] ) )
        {
            self playsound( "evt_sq_bag_gain_perks" );
            self zm_perks::give_perk( level._sq_perk_array[ i ] );
            wait 0.25;
        }
    }
    
    self._retain_perks = 1;
    self thread watch_for_respawn();
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0xed6d0ba8, Offset: 0x13c0
// Size: 0x76
function raise_all_crystals()
{
    while ( 0 == getdvarint( "scr_raise_crystals" ) )
    {
        wait 0.1;
    }
    
    level notify( #"raise_crystal_1" );
    level notify( #"raise_crystal_2" );
    level notify( #"raise_crystal_3" );
    level notify( #"raise_crystal_4" );
    level notify( #"raise_crystal_5" );
    level notify( #"raise_crystal_6" );
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0xf069eb71, Offset: 0x1440
// Size: 0x172
function gong_watcher()
{
    if ( isdefined( level._gong_watcher_running ) )
    {
        return;
    }
    
    level._gong_watcher_running = 1;
    level thread watch_for_gongs_gone_bad();
    
    while ( true )
    {
        level flag::wait_till( "gongs_resonating" );
        
        for ( i = 0; i < level._raised_crystals.size ; i++ )
        {
            if ( level._raised_crystals[ i ] )
            {
                str_exploder = "fxexp_50" + i + 1;
                exploder::exploder( str_exploder );
                util::wait_network_frame();
            }
        }
        
        while ( level flag::get( "gongs_resonating" ) )
        {
            wait 0.1;
        }
        
        for ( i = 0; i < level._raised_crystals.size ; i++ )
        {
            str_exploder = "fxexp_50" + i + 1;
            exploder::stop_exploder( str_exploder );
            util::wait_network_frame();
        }
    }
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x20899caf, Offset: 0x15c0
// Size: 0x132
function watch_for_gongs_gone_bad()
{
    while ( true )
    {
        level waittill( #"wrong_gong" );
        
        for ( i = 0; i < level._raised_crystals.size ; i++ )
        {
            if ( level._raised_crystals[ i ] )
            {
                str_exploder = "fxexp_51" + i + 1;
                exploder::exploder( str_exploder );
                util::wait_network_frame();
            }
        }
        
        wait 1;
        level flag::clear( "gongs_resonating" );
        wait 6;
        
        for ( i = 0; i < level._raised_crystals.size ; i++ )
        {
            str_exploder = "fxexp_51" + i + 1;
            exploder::stop_exploder( str_exploder );
            util::wait_network_frame();
        }
    }
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0xf0e2b83e, Offset: 0x1700
// Size: 0xe0
function force_eclipse_watcher()
{
    level endon( #"end_game" );
    setdvar( "scr_force_eclipse", 0 );
    level waittill( #"start_zombie_round_logic" );
    
    while ( true )
    {
        while ( 0 == getdvarint( "scr_force_eclipse" ) )
        {
            wait 0.1;
        }
        
        back_to_the_eclipse();
        reveal_meteor();
        
        while ( 1 == getdvarint( "scr_force_eclipse" ) )
        {
            wait 0.1;
        }
        
        back_to_the_future();
        hide_meteor();
    }
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x775a2632, Offset: 0x17e8
// Size: 0x124
function gong_trigger_handler()
{
    if ( isdefined( self.owner_ent ) && isdefined( self.owner_ent.target ) )
    {
        self.owner_ent.var_4ba5f5f1 = getent( self.owner_ent.target, "targetname" );
        self.owner_ent.var_4ba5f5f1.takedamage = 1;
    }
    else
    {
        return;
    }
    
    while ( true )
    {
        self.owner_ent.var_4ba5f5f1 waittill( #"damage", amount, attacker, dir, point, mod );
        
        if ( isplayer( attacker ) && mod == "MOD_MELEE" )
        {
            self.owner_ent notify( #"triggered", attacker );
        }
    }
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0xe290c461, Offset: 0x1918
// Size: 0x1c
function gong_handler()
{
    self thread zm_temple_sq_bag::dud_gong_handler();
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x4421ff6b, Offset: 0x1940
// Size: 0x1c
function ptt_dial_handler()
{
    self thread zm_temple_sq_ptt::dud_dial_handler();
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0xfbd75cdd, Offset: 0x1968
// Size: 0x34
function bttp2_dial_handler()
{
    self.trigger triggerignoreteam();
    self thread zm_temple_sq_bttp2::dud_dial_handler();
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x8f7edd95, Offset: 0x19a8
// Size: 0x4c
function start_temple_sidequest()
{
    hide_meteor();
    level flag::wait_till( "initial_players_connected" );
    zm_sidequests::sidequest_start( "sq" );
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x720bcb4e, Offset: 0x1a00
// Size: 0x3c
function restart_sundial_monitor()
{
    level endon( #"kill_sundial_monitor" );
    level waittill( #"reset_sundial" );
    wait 0.1;
    self thread sundial_monitor();
}

// Namespace zm_temple_sq
// Params 2
// Checksum 0xca474b14, Offset: 0x1a48
// Size: 0xe4
function spin_dial( duration, multiplier )
{
    if ( !isdefined( duration ) )
    {
        duration = 2;
    }
    
    if ( !isdefined( multiplier ) )
    {
        multiplier = 1.3;
    }
    
    spin_time = 0.1;
    
    while ( spin_time < duration )
    {
        self playloopsound( "evt_sq_gen_sundial_spin", 0.5 );
        self rotatepitch( 180, spin_time );
        wait spin_time * 0.95;
        spin_time *= multiplier;
    }
    
    self stoploopsound( 2 );
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0xabb7d52b, Offset: 0x1b38
// Size: 0x24
function short_dial_spin()
{
    spin_dial( 1, 1.6 );
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0xb90e20d2, Offset: 0x1b68
// Size: 0x478
function sundial_monitor()
{
    level endon( #"reset_sundial" );
    level endon( #"end_game" );
    self.dont_rethread = 1;
    self thread restart_sundial_monitor();
    
    if ( !isdefined( self.original_pos ) )
    {
        self.original_pos = self.origin - anglestoup( self.angles );
        self.off_pos = self.original_pos - anglestoup( self.angles ) * 34;
    }
    
    self.origin = self.off_pos;
    level._sundial_buttons_pressed = 0;
    level._stage_active = 0;
    level._sundial_active = 0;
    level flag::wait_till( "power_on" );
    level notify( #"kill_buttons" );
    wait 0.05;
    buttons = getentarray( "sq_sundial_button", "targetname" );
    array::thread_all( buttons, &sundial_button );
    
    while ( true )
    {
        while ( level._sundial_buttons_pressed < 4 )
        {
            wait 0.1;
        }
        
        level._sundial_active = 1;
        self playsound( "evt_sq_gen_transition_start" );
        self playsound( "evt_sq_gen_sundial_emerge" );
        self moveto( self.original_pos, 0.25 );
        self waittill( #"movedone" );
        self thread spin_dial();
        wait 0.5;
        stage = zm_sidequests::sidequest_start_next_stage( "sq" );
        level notify( #"stage_starting" );
        amount = 8.5;
        level waittill( #"timed_stage_75_percent" );
        self playsound( "evt_sq_gen_sundial_timer" );
        self moveto( self.origin - anglestoup( self.angles ) * amount, 1 );
        self thread short_dial_spin();
        level waittill( #"timed_stage_50_percent" );
        self playsound( "evt_sq_gen_sundial_timer" );
        self moveto( self.origin - anglestoup( self.angles ) * amount, 1 );
        self thread short_dial_spin();
        level waittill( #"timed_stage_25_percent" );
        self playsound( "evt_sq_gen_sundial_timer" );
        self moveto( self.origin - anglestoup( self.angles ) * amount, 1 );
        self thread short_dial_spin();
        level waittill( #"timed_stage_10_seconds_to_go" );
        self thread play_one_second_increments();
        self moveto( self.origin - anglestoup( self.angles ) * amount, 10 );
        self thread spin_dial();
        self waittill( #"movedone" );
        level._sundial_active = 0;
        wait 0.1;
    }
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0xfd4123c9, Offset: 0x1fe8
// Size: 0x56
function play_one_second_increments()
{
    level endon( #"sidequest_sq_complete" );
    level endon( #"reset_sundial" );
    
    while ( level._sundial_active == 1 )
    {
        self playsound( "evt_sq_gen_sundial_timer" );
        wait 1;
    }
}

// Namespace zm_temple_sq
// Params 2
// Checksum 0x6401f6fa, Offset: 0x2048
// Size: 0xa2, Type: bool
function sundial_button_already_pressed_by( who, buttons )
{
    /#
        if ( getplayers().size < 4 )
        {
            return false;
        }
    #/
    
    for ( i = 0; i < buttons.size ; i++ )
    {
        if ( isdefined( buttons[ i ].triggering_player ) && buttons[ i ].triggering_player == who )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x3698ea7d, Offset: 0x20f8
// Size: 0x3a8
function sundial_button()
{
    level endon( #"stage_starting" );
    level endon( #"kill_buttons" );
    
    if ( !isdefined( self.dont_rethread ) )
    {
        self.dont_rethread = 1;
        self.on_pos = self.origin - anglestoup( self.angles );
        self.off_pos = self.on_pos - anglestoup( self.angles ) * 5.5;
        self moveto( self.off_pos, 0.01 );
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
        self.trigger = undefined;
    }
    
    self.triggering_player = undefined;
    level flag::wait_till( "power_on" );
    self moveto( self.on_pos, 0.25 );
    wait 0.25;
    buttons = getentarray( "sq_sundial_button", "targetname" );
    offset = anglestoforward( self.angles ) * 5 - ( 0, 0, 16 );
    self.trigger = spawn( "trigger_radius_use", self.on_pos + offset, 0, 48, 32 );
    self.trigger triggerignoreteam();
    self.trigger.radius = 48;
    self.trigger setcursorhint( "HINT_NOICON" );
    
    while ( true )
    {
        self.trigger waittill( #"trigger", who );
        
        if ( sundial_button_already_pressed_by( who, buttons ) )
        {
            continue;
        }
        
        if ( !level._stage_active && level._buttons_can_reset )
        {
            self.triggering_player = who;
            level._sundial_buttons_pressed++;
            self playsound( "evt_sq_gen_button" );
            self moveto( self.off_pos, 0.25 );
            delay = 1;
            
            /#
                if ( getplayers().size == 1 || getdvarint( "<dev string:x28>" ) == 2 )
                {
                    delay = 10;
                }
            #/
            
            wait delay;
            
            while ( level._sundial_active )
            {
                wait 0.1;
            }
            
            self.triggering_player = undefined;
            self moveto( self.on_pos, 0.25 );
            
            if ( level._sundial_buttons_pressed > 0 )
            {
                level._sundial_buttons_pressed--;
            }
        }
    }
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0xcf997d36, Offset: 0x24a8
// Size: 0xa6
function init_gongs()
{
    gongs = getentarray( "sq_gong", "targetname" );
    gongs = array::randomize( gongs );
    
    for ( i = 0; i < gongs.size ; i++ )
    {
        name = "gong" + i;
        gongs[ i ].animname = name;
    }
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0xa1b0b6e4, Offset: 0x2558
// Size: 0x48c
function init_sidequest()
{
    level._buttons_can_reset = 1;
    
    if ( !isdefined( level._sidequest_firsttime ) )
    {
        back_to_the_future();
        level._sidequest_firsttime = 0;
    }
    
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        var_8e0fe378 = players[ i ].characterindex;
        
        if ( isdefined( players[ i ].zm_random_char ) )
        {
            var_8e0fe378 = players[ i ].zm_random_char;
        }
        
        if ( var_8e0fe378 == 3 && zm::is_sidequest_previously_completed( "COTD" ) )
        {
            players[ i ] zm_sidequests::add_sidequest_icon( "sq", "vril", 0 );
            break;
        }
    }
    
    zm_temple_sq_brock::create_radio( 1 );
    init_gongs();
    wall = getent( "sq_wall", "targetname" );
    wall setmodel( "p7_zm_sha_wall_temple_brick_02" );
    wall solid();
    crystals = getentarray( "sq_crystals", "targetname" );
    level._raised_crystals = [];
    
    for ( i = 0; i < crystals.size ; i++ )
    {
        level._raised_crystals[ i ] = 0;
    }
    
    a_e_trap = getentarray( "sq_spiketrap", "targetname" );
    
    foreach ( e_trap in a_e_trap )
    {
        e_trap show();
    }
    
    level flag::clear( "radio_4_played" );
    level flag::clear( "radio_7_played" );
    level flag::clear( "radio_9_played" );
    level flag::clear( "meteorite_shrunk" );
    meteorite = getent( "sq_meteorite", "targetname" );
    meteorite setmodel( "p7_zm_sha_meteorite" );
    meteorite ghost();
    
    if ( !isdefined( meteorite.original_origin ) )
    {
        meteorite.original_origin = meteorite.origin;
        meteorite.original_angles = meteorite.angles;
    }
    
    meteorite.origin = meteorite.original_origin;
    meteorite.angles = meteorite.original_angles;
    anti115 = getent( "sq_anti_115", "targetname" );
    anti115 show();
    level thread pap_watcher();
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x7e47d81, Offset: 0x29f0
// Size: 0xd8
function pap_watcher()
{
    level notify( #"only_one_pap_watcher" );
    level endon( #"only_one_pap_watcher" );
    
    while ( true )
    {
        level flag::wait_till( "pap_override" );
        
        while ( level flag::get( "pack_machine_in_use" ) )
        {
            wait 0.1;
        }
        
        level thread pack_a_punch_hide();
        
        while ( level flag::get( "pap_override" ) )
        {
            wait 0.1;
        }
        
        level thread pack_a_punch_show();
    }
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0xa42aae47, Offset: 0x2ad0
// Size: 0x90
function cheat_complete_stage()
{
    level endon( #"reset_sundial" );
    
    while ( true )
    {
        if ( getdvarstring( "cheat_sq" ) != "" )
        {
            if ( isdefined( level._last_stage_started ) )
            {
                setdvar( "cheat_sq", "" );
                zm_sidequests::stage_completed( "sq", level._last_stage_started );
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0xd85097b7, Offset: 0x2b68
// Size: 0x4c
function generic_stage_start()
{
    /#
        level thread cheat_complete_stage();
    #/
    
    level._stage_active = 1;
    back_to_the_eclipse();
    reveal_meteor();
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0xf70be639, Offset: 0x2bc0
// Size: 0x3c
function generic_stage_complete()
{
    level notify( #"reset_sundial" );
    level._stage_active = 0;
    back_to_the_future();
    hide_meteor();
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x701c2270, Offset: 0x2c08
// Size: 0x3c
function complete_sidequest()
{
    level notify( #"kill_sundial_monitor" );
    level notify( #"reset_sundial" );
    level notify( #"kill_buttons" );
    level thread sidequest_done();
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x9ccb71c3, Offset: 0x2c50
// Size: 0x40
function spin_115()
{
    self endon( #"picked_up" );
    
    while ( true )
    {
        self rotateyaw( 180, 0.4 );
        wait 0.4;
    }
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x5976c0a8, Offset: 0x2c98
// Size: 0x41c
function sidequest_done()
{
    wall = getent( "sq_wall", "targetname" );
    wall setmodel( "p7_zm_sha_wall_temple_brick_02_dmg" );
    wall notsolid();
    anti115 = getent( "sq_anti_115", "targetname" );
    anti115 thread spin_115();
    anti115 playloopsound( "zmb_meteor_loop" );
    exploder::exploder( "fxexp_520" );
    trigger = spawn( "trigger_radius_use", anti115.origin, 0, 32, 72 );
    trigger triggerignoreteam();
    trigger setcursorhint( "HINT_NOICON" );
    trigger.radius = 48;
    trigger.height = 72;
    
    while ( true )
    {
        trigger waittill( #"trigger", who );
        
        if ( isplayer( who ) && !isdefined( who._has_anti115 ) )
        {
            who._has_anti115 = 1;
            who playsound( "zmb_meteor_activate" );
            who thread reward();
            who thread zm_audio::create_and_play_dialog( "eggs", "quest8", 7 );
            who thread delayed_loser_response();
            break;
        }
        
        if ( isplayer( who ) )
        {
            who playsound( "zmb_no_cha_ching" );
        }
    }
    
    trigger delete();
    anti115 stoploopsound( 1 );
    anti115 notify( #"picked_up" );
    level notify( #"picked_up" );
    anti115 ghost();
    exploder::stop_exploder( "fxexp_520" );
    players_far = 0;
    
    for ( players = getplayers(); players_far < players.size ; players = getplayers() )
    {
        players_far = 0;
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( distance2dsquared( players[ i ].origin, wall.origin ) > 129600 )
            {
                players_far++;
            }
        }
        
        wait 0.1;
    }
    
    level flag::clear( "pap_override" );
    level thread reset_sidequest();
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x7ed19a39, Offset: 0x30c0
// Size: 0x9c
function delayed_loser_response()
{
    wait 5;
    losers = getplayers();
    arrayremovevalue( losers, self );
    
    if ( losers.size >= 1 )
    {
        losers[ randomintrange( 0, losers.size ) ] thread zm_audio::create_and_play_dialog( "eggs", "quest8", 8 );
    }
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x4bbb8a71, Offset: 0x3168
// Size: 0x37c
function reset_sidequest()
{
    sidequest = level._zombie_sidequests[ "sq" ];
    
    if ( sidequest.num_reps >= 3 )
    {
        return;
    }
    
    sidequest.num_reps++;
    level flag::wait_till( "radio_9_played" );
    
    while ( level flag::get( "doing_bounce_around" ) )
    {
        wait 0.1;
    }
    
    stage_names = getarraykeys( sidequest.stages );
    
    for ( i = 0; i < stage_names.size ; i++ )
    {
        sidequest.stages[ stage_names[ i ] ].completed = 0;
    }
    
    sidequest.last_completed_stage = -1;
    sidequest.active_stage = -1;
    level flag::clear( "radio_7_played" );
    level flag::clear( "radio_9_played" );
    level flag::clear( "trap_destroyed" );
    randomize_gongs();
    crystals = getentarray( "sq_crystals", "targetname" );
    
    for ( i = 0; i < crystals.size ; i++ )
    {
        if ( isdefined( crystals[ i ].trigger ) )
        {
            crystals[ i ].trigger delete();
            crystals[ i ] delete();
        }
    }
    
    dynamite = getent( "dynamite", "targetname" );
    dynamite delete();
    buttons = getentarray( "sq_sundial_button", "targetname" );
    
    for ( i = 0; i < buttons.size ; i++ )
    {
        if ( isdefined( buttons[ i ].trigger ) )
        {
            buttons[ i ].trigger delete();
            buttons[ i ].trigger = undefined;
        }
    }
    
    start_temple_sidequest();
    dial = getent( "sq_sundial", "targetname" );
    dial thread sundial_monitor();
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x3144f170, Offset: 0x34f0
// Size: 0xdc
function back_to_the_eclipse()
{
    foreach ( e_player in level.players )
    {
        e_player thread function_5fdf6353();
    }
    
    level util::set_lighting_state( 1 );
    level clientfield::set( "time_transition", 0 );
    level function_7aca917c( 0 );
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0xb3f6911b, Offset: 0x35d8
// Size: 0xdc
function back_to_the_future()
{
    foreach ( e_player in level.players )
    {
        e_player thread function_5fdf6353();
    }
    
    level util::set_lighting_state( 0 );
    level clientfield::set( "time_transition", 1 );
    level function_7aca917c( 1 );
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x41d0ecc, Offset: 0x36c0
// Size: 0x6c
function function_5fdf6353()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    visionset_mgr::activate( "overlay", "zm_temple_eclipse", self );
    wait 3;
    
    if ( isdefined( self ) )
    {
        visionset_mgr::deactivate( "overlay", "zm_temple_eclipse", self );
    }
}

// Namespace zm_temple_sq
// Params 1
// Checksum 0x257d2fd1, Offset: 0x3738
// Size: 0x12c
function rotate_skydome( n_time )
{
    level notify( #"hash_89011ead" );
    level endon( #"hash_89011ead" );
    
    if ( !isdefined( level.var_9e9e4a20 ) )
    {
        level.var_9e9e4a20 = 0;
    }
    
    if ( level.var_9e9e4a20 > 0 )
    {
        var_3557d539 = 360 - level.var_9e9e4a20;
    }
    else
    {
        var_3557d539 = 360;
    }
    
    n_change = var_3557d539 / n_time / 0.1;
    
    while ( var_3557d539 > 0 )
    {
        level.var_9e9e4a20 += n_change;
        setdvar( "r_skyRotation", level.var_9e9e4a20 );
        var_3557d539 -= n_change;
        wait 0.1;
    }
    
    level.var_9e9e4a20 = 0;
    setdvar( "r_skyRotation", level.var_9e9e4a20 );
}

// Namespace zm_temple_sq
// Params 1
// Checksum 0x259a42f7, Offset: 0x3870
// Size: 0x9c
function function_7aca917c( var_8182276a )
{
    if ( !isdefined( var_8182276a ) )
    {
        var_8182276a = 0;
    }
    
    if ( isdefined( level.var_1b3f87f7 ) )
    {
        level.var_1b3f87f7 delete();
    }
    
    level.var_1b3f87f7 = createstreamerhint( level.activeplayers[ 0 ].origin, 1, var_8182276a );
    level.var_1b3f87f7 setlightingonly( 1 );
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x42417f6e, Offset: 0x3918
// Size: 0x6c
function reveal_meteor()
{
    ent = getent( "sq_meteorite", "targetname" );
    
    if ( isdefined( ent ) )
    {
        ent show();
        exploder::exploder( "fxexp_518" );
    }
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0xb211610a, Offset: 0x3990
// Size: 0x6c
function hide_meteor()
{
    ent = getent( "sq_meteorite", "targetname" );
    
    if ( isdefined( ent ) )
    {
        ent ghost();
        exploder::stop_exploder( "fxexp_518" );
    }
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0xa35af104, Offset: 0x3a08
// Size: 0xac
function spawn_skel()
{
    if ( !isdefined( level._sq_skel ) )
    {
        var_cd998d3c = getentarray( "sq_spiketrap", "targetname" );
        ent = var_cd998d3c[ 0 ];
        
        if ( isdefined( ent ) )
        {
            sb = util::spawn_model( "p7_zm_sha_skeleton", ent.origin, ent.angles );
            level._sq_skel = sb;
        }
    }
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x1294e6be, Offset: 0x3ac0
// Size: 0x36
function remove_skel()
{
    if ( isdefined( level._sq_skel ) )
    {
        level._sq_skel delete();
        level._sq_skel = undefined;
    }
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x1b853ad, Offset: 0x3b00
// Size: 0x114
function reset_dynamite()
{
    dynamite = getent( "dynamite", "targetname" );
    dynamite.angles = dynamite.original_angles;
    dynamite.origin = dynamite.original_origin;
    dynamite unlink();
    dynamite linkto( dynamite.owner_ent, "", dynamite.origin - dynamite.owner_ent.origin, dynamite.angles - dynamite.owner_ent.angles );
    dynamite.dropped = undefined;
    dynamite show();
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x6a78e498, Offset: 0x3c20
// Size: 0x44
function delay_kill_loop_sound_and_delete()
{
    self stoploopsound( 0.5 );
    wait 0.5;
    self delete();
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x9e8201fa, Offset: 0x3c70
// Size: 0x4ee
function crystal_handler()
{
    if ( isdefined( self.trigger ) )
    {
        zm_weap_shrink_ray::remove_shrinkable_object( self.trigger );
        self.trigger thread delay_kill_loop_sound_and_delete();
        self.trigger = undefined;
    }
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "dynamite" && !isdefined( self.dynamite ) )
    {
        dyn_pos = struct::get( self.target, "targetname" );
        dynamite = spawn( "script_model", dyn_pos.origin );
        dynamite.angles = dyn_pos.angles;
        dynamite setmodel( "p7_zm_sha_dynamite_wrap_full" );
        dynamite.targetname = "dynamite";
        dynamite.target = dyn_pos.target;
        dynamite.original_origin = dynamite.origin;
        dynamite.original_angles = dynamite.angles;
        dynamite.owner_ent = self;
        dynamite linkto( self, "", dynamite.origin - self.origin, dynamite.angles - self.angles );
        self.dynamite = dynamite;
    }
    
    if ( !isdefined( self.original_origin ) )
    {
        self.original_origin = self.origin;
    }
    
    self dontinterpolate();
    self.origin = self.original_origin - ( 0, 0, 154 );
    self ghost();
    level waittill( "raise_crystal_" + self.script_int, actual_stage );
    
    if ( isdefined( actual_stage ) && actual_stage )
    {
        level notify( #"suspend_timer" );
    }
    
    self show();
    self playsound( "evt_sq_gen_crystal_start" );
    self playloopsound( "evt_sq_gen_crystal_loop", 2 );
    self moveto( self.origin + ( 0, 0, 154 ), 4, 0.8, 0.4 );
    self waittill( #"movedone" );
    self stoploopsound( 1 );
    self playsound( "evt_sq_gen_crystal_end" );
    level notify( "raised_crystal_" + self.script_int );
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "empty_holder" )
    {
        if ( isdefined( actual_stage ) && actual_stage )
        {
            level waittill( #"crystal_dropped" );
        }
        
        self setmodel( "p7_zm_sha_crystal_holder_full" );
    }
    
    trigger = spawn( "trigger_damage", self.origin + ( 0, 0, 134 ), 0, 32, 32 );
    trigger.radius = 32;
    trigger.height = 32;
    trigger thread crystal_trigger_thread();
    trigger.owner_ent = self;
    zm_weap_shrink_ray::add_shrinkable_object( trigger );
    self.trigger = trigger;
    self thread play_loopsound_while_resonating();
    self thread force_stoploopsound_end();
    level._raised_crystals[ self.script_int - 1 ] = 1;
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x4fe8d81f, Offset: 0x4168
// Size: 0xb0
function play_loopsound_while_resonating()
{
    self.trigger endon( #"death" );
    
    while ( true )
    {
        level flag::wait_till( "gongs_resonating" );
        self playloopsound( "mus_sq_bag_crystal_loop", 2 );
        
        while ( level flag::get( "gongs_resonating" ) )
        {
            wait 0.1;
        }
        
        self stoploopsound( 0.5 );
    }
}

// Namespace zm_temple_sq
// Params 1
// Checksum 0x65eddd90, Offset: 0x4220
// Size: 0x8a
function get_crystal_from_script_int( num )
{
    sq = getentarray( "sq_crystals", "targetname" );
    
    for ( i = 0; i < sq.size ; i++ )
    {
        if ( sq[ i ].script_int == num )
        {
            return sq[ i ];
        }
    }
}

// Namespace zm_temple_sq
// Params 1
// Checksum 0x1240d4cf, Offset: 0x42b8
// Size: 0x4a, Type: bool
function is_crystal_raised( i )
{
    if ( isdefined( level._raised_crystals[ i - 1 ] ) && level._raised_crystals[ i - 1 ] == 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_temple_sq
// Params 3
// Checksum 0xbb21b894, Offset: 0x4310
// Size: 0x12c
function bounce_from_a_to_b( a, b, hotsauce )
{
    if ( hotsauce )
    {
        a clientfield::set( "hotsauce", 1 );
    }
    else
    {
        a clientfield::set( "weaksauce", 1 );
    }
    
    b clientfield::set( "sauceend", 1 );
    util::wait_network_frame();
    util::wait_network_frame();
    util::wait_network_frame();
    
    if ( isdefined( a ) )
    {
        a clientfield::set( "hotsauce", 0 );
        a clientfield::set( "weaksauce", 0 );
    }
    
    if ( isdefined( b ) )
    {
        b clientfield::set( "sauceend", 0 );
    }
}

// Namespace zm_temple_sq
// Params 2
// Checksum 0x14cf839e, Offset: 0x4448
// Size: 0x164
function do_bounce_off( start, hotsauce )
{
    if ( !isdefined( level._bounce_off_ent ) )
    {
        level._bounce_off_ent = spawn( "script_model", ( 0, 0, 0 ) );
        level._bounce_off_ent setmodel( "tag_origin" );
    }
    
    yaw = randomfloat( 360 );
    r = randomfloatrange( 100, 200 );
    amntx = cos( yaw ) * r;
    amnty = sin( yaw ) * r;
    level._bounce_off_ent.origin = start.origin + ( amntx, amnty, randomint( 60 ) );
    level thread bounce_from_a_to_b( start, level._bounce_off_ent, hotsauce );
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x8d37b309, Offset: 0x45b8
// Size: 0x1cc
function shrink_time()
{
    wait 1;
    clientfield::increment( "meteor_shrink" );
    self playsound( "evt_sq_bag_shrink_meteor" );
    self setmodel( "p7_zm_sha_meteorite_small" );
    exploder::exploder( "fxexp_519" );
    wait 0.1;
    exploder::stop_exploder( "fxexp_518" );
    self ghost();
    wait 0.25;
    level flag::set( "meteorite_shrunk" );
    level thread shut_off_all_looping_sounds();
    self playsound( "evt_sq_bag_meteor_fall" );
    self moveto( self.origin - ( 0, 0, 120 ), 2, 0.5 );
    self waittill( #"movedone" );
    players = getplayers();
    players[ randomintrange( 0, players.size ) ] thread zm_audio::create_and_play_dialog( "eggs", "quest8", 4 );
}

// Namespace zm_temple_sq
// Params 1
// Checksum 0x51a8cbb6, Offset: 0x4790
// Size: 0x534
function crystal_shrink_logic( hotsauce )
{
    level._crystal_shrink_logic_running = 1;
    level flag::set( "doing_bounce_around" );
    bounce_path = level._crystal_bounce_paths[ self.script_int ];
    start = self;
    end = undefined;
    
    if ( isdefined( bounce_path ) )
    {
        for ( i = 0; i < bounce_path.size ; i++ )
        {
            if ( "" + bounce_path[ i ] == "M" )
            {
                if ( zm_sidequests::sidequest_stage_active( "sq", "BaG" ) && !level flag::get( "meteorite_shrunk" ) )
                {
                    ent = getent( "sq_meteorite", "targetname" );
                    
                    if ( hotsauce )
                    {
                        start playsound( "evt_sq_bag_crystal_bounce_correct" );
                        exploder::exploder( "fxexp_509" );
                        ent thread shrink_time();
                    }
                    else
                    {
                        start playsound( "evt_sq_bag_crystal_bounce_fail" );
                        exploder::exploder( "fxexp_529" );
                        players = getplayers();
                        players[ randomintrange( 0, players.size ) ] thread zm_audio::create_and_play_dialog( "eggs", "quest8", 3 );
                    }
                }
                else
                {
                    start playsound( "evt_sq_bag_crystal_bounce_fail" );
                    exploder::exploder( "fxexp_529" );
                }
            }
            else if ( "" + bounce_path[ i ] == "R" )
            {
                start playsound( "evt_sq_bag_crystal_bounce_fail" );
                do_bounce_off( start, hotsauce );
                break;
            }
            else if ( is_crystal_raised( bounce_path[ i ] ) )
            {
                end = get_crystal_from_script_int( bounce_path[ i ] );
                start playsound( "evt_sq_bag_crystal_bounce_correct" );
                level thread bounce_from_a_to_b( start, end, hotsauce );
                start = end;
            }
            else
            {
                start playsound( "evt_sq_bag_crystal_bounce_fail" );
                do_bounce_off( start, hotsauce );
                break;
            }
            
            wait 0.5;
            
            if ( i == 6 )
            {
                end playsound( "mus_sq_bag_crystal_final_hit" );
            }
            else
            {
                end playsound( "evt_sq_bag_crystal_hit_" + i );
            }
            
            if ( hotsauce && isdefined( end ) && isdefined( end.dynamite ) && !isdefined( end.dynamite.dropped ) && zm_sidequests::sidequest_stage_active( "sq", "BaG" ) )
            {
                end.dynamite thread zm_temple_sq_bag::fire_in_the_hole();
            }
            
            end playsound( "evt_sq_bag_crystal_charge" );
            
            if ( hotsauce )
            {
                str_exploder = "fxexp_" + end.script_int + 520;
                exploder::exploder( str_exploder );
            }
            else
            {
                str_exploder = "fxexp_" + end.script_int + 530;
                exploder::exploder( str_exploder );
            }
            
            wait 0.5;
        }
    }
    
    level._crystal_shrink_logic_running = undefined;
    level flag::clear( "doing_bounce_around" );
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x15b1b668, Offset: 0x4cd0
// Size: 0x88
function crystal_shrink_thread()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"shrunk", hotsauce );
        
        if ( !level flag::get( "gongs_resonating" ) )
        {
            hotsauce = 0;
        }
        
        if ( !isdefined( level._crystal_shrink_logic_running ) )
        {
            self.owner_ent thread crystal_shrink_logic( hotsauce );
        }
    }
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x1f463fdd, Offset: 0x4d60
// Size: 0x78
function crystal_trigger_thread()
{
    self endon( #"death" );
    self thread crystal_shrink_thread();
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, dir, point, type );
    }
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0xf663525d, Offset: 0x4de0
// Size: 0x270
function pack_a_punch_hide()
{
    if ( !isdefined( level._pap_hidden ) )
    {
        level._pap_hidden = 0;
    }
    
    if ( level._pap_hidden )
    {
        return;
    }
    
    level._pap_hidden = 1;
    pap_clip = level.pack_a_punch.triggers[ 0 ].clip;
    pap_clip notsolid();
    pap_clip connectpaths();
    pap_machine_trig = level.pack_a_punch.triggers[ 0 ];
    pap_machine_trig enablelinkto();
    pap_machine = pap_machine_trig.pap_machine;
    
    if ( !isdefined( pap_machine_trig.original_origin ) )
    {
        pap_machine_trig.original_origin = pap_machine_trig.origin;
    }
    
    link_ent = spawn( "script_origin", pap_machine_trig.origin );
    link_ent.angles = pap_machine.angles;
    pap_machine_trig linkto( link_ent );
    level._original_pap_spot = pap_machine_trig.origin;
    pap_machine linkto( link_ent );
    link_ent moveto( link_ent.origin + ( 0, 0, -350 ), 5 );
    link_ent waittill( #"movedone" );
    pap_machine_trig unlink();
    pap_machine unlink();
    pap_machine ghost();
    pap_machine notsolid();
    link_ent delete();
    level._pap_hidden = 2;
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0xd0a6475b, Offset: 0x5058
// Size: 0x210
function pack_a_punch_show()
{
    if ( !isdefined( level._pap_hidden ) || level._pap_hidden == 0 )
    {
        return;
    }
    
    if ( level._pap_hidden == 1 )
    {
        while ( level._pap_hidden != 2 )
        {
            wait 1;
        }
    }
    
    pap_clip = level.pack_a_punch.triggers[ 0 ].clip;
    pap_clip solid();
    pap_clip connectpaths();
    pap_machine_trig = level.pack_a_punch.triggers[ 0 ];
    pap_machine = pap_machine_trig.pap_machine;
    link_ent = spawn( "script_origin", pap_machine_trig.origin );
    link_ent.angles = pap_machine.angles;
    pap_machine_trig linkto( link_ent );
    pap_machine linkto( link_ent );
    pap_machine solid();
    pap_machine show();
    link_ent moveto( level._original_pap_spot, 5 );
    link_ent waittill( #"movedone" );
    pap_machine_trig unlink();
    pap_machine unlink();
    link_ent delete();
    level._pap_hidden = 0;
}

// Namespace zm_temple_sq
// Params 1
// Checksum 0x20b6f7c, Offset: 0x5270
// Size: 0xaa
function function_26186755( var_8e0fe378 )
{
    if ( !isdefined( var_8e0fe378 ) )
    {
        var_8e0fe378 = 0;
    }
    
    var_bc7547cb = "a";
    
    switch ( var_8e0fe378 )
    {
        case 0:
            var_bc7547cb = "a";
            break;
        case 1:
            var_bc7547cb = "b";
            break;
        case 2:
            var_bc7547cb = "d";
            break;
        case 3:
            var_bc7547cb = "c";
            break;
    }
    
    return var_bc7547cb;
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0xc3d40144, Offset: 0x5328
// Size: 0xf6
function shut_off_all_looping_sounds()
{
    gongs = getentarray( "sq_gong", "targetname" );
    
    for ( i = 0; i < gongs.size ; i++ )
    {
        if ( gongs[ i ].right_gong )
        {
            if ( gongs[ i ].ringing )
            {
                if ( level._num_gongs >= 0 )
                {
                    level._num_gongs--;
                }
                
                gongs[ i ] stoploopsound( 0.5 );
            }
        }
        
        gongs[ i ].ringing = 0;
    }
    
    level notify( #"force_stoploopsound_end" );
    level notify( #"kill_resonate" );
}

// Namespace zm_temple_sq
// Params 0
// Checksum 0x9223ff2f, Offset: 0x5428
// Size: 0x3c
function force_stoploopsound_end()
{
    self.trigger endon( #"death" );
    level waittill( #"force_stoploopsound_end" );
    self stoploopsound( 0.5 );
}

/#

    // Namespace zm_temple_sq
    // Params 0
    // Checksum 0x990652d0, Offset: 0x5470
    // Size: 0x64, Type: dev
    function function_e63287bf()
    {
        level waittill( #"start_zombie_round_logic" );
        zm_devgui::add_custom_devgui_callback( &function_b1064ab3 );
        adddebugcommand( "<dev string:x35>" );
        adddebugcommand( "<dev string:x6f>" );
    }

    // Namespace zm_temple_sq
    // Params 1
    // Checksum 0xa45c92d3, Offset: 0x54e0
    // Size: 0x76, Type: dev
    function function_b1064ab3( cmd )
    {
        switch ( cmd )
        {
            default:
                setdvar( "<dev string:xab>", 0 );
                return 1;
            case "<dev string:xbd>":
                setdvar( "<dev string:xab>", 1 );
                return 1;
        }
        
        return 0;
    }

#/
