#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_powerups;
#using scripts/zm/zm_cosmodrome;
#using scripts/zm/zm_cosmodrome_amb;
#using scripts/zm/zm_cosmodrome_traps;

#namespace zm_cosmodrome_pack_a_punch;

// Namespace zm_cosmodrome_pack_a_punch
// Params 0
// Checksum 0xfbce430c, Offset: 0x5d8
// Size: 0x1ac
function pack_a_punch_main()
{
    level flag::init( "lander_a_used" );
    level flag::init( "lander_b_used" );
    level flag::init( "lander_c_used" );
    level flag::init( "launch_activated" );
    level flag::init( "launch_complete" );
    level.pack_debug = 0;
    level.pack_a_punch_door = getent( "rocket_room_bottom_door", "targetname" );
    level.pack_a_punch_door.clip = getent( level.pack_a_punch_door.target, "targetname" );
    level.pack_a_punch_door.clip linkto( level.pack_a_punch_door );
    launch_trig = getent( "trig_launch_rocket", "targetname" );
    launch_trig thread launch_rocket();
    level thread pack_a_punch_activate();
    level thread rocket_launch_preparation();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0
// Checksum 0x8286dfc1, Offset: 0x790
// Size: 0x14c
function pack_a_punch_activate()
{
    if ( getdvarstring( "rocket_test" ) != "" )
    {
        level flag::set( "lander_a_used" );
        level flag::set( "lander_b_used" );
        level flag::set( "lander_c_used" );
    }
    
    level flag::wait_till( "lander_a_used" );
    level flag::wait_till( "lander_b_used" );
    level flag::wait_till( "lander_c_used" );
    level thread move_rocket_arm();
    wait 4;
    level flag::wait_till( "launch_complete" );
    pack_print( "punch activate" );
    level thread pack_a_punch_open_door();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0
// Checksum 0x8be524a0, Offset: 0x8e8
// Size: 0x5c
function move_rocket_arm()
{
    wait 5.5;
    zm_cosmodrome_traps::link_rocket_pieces();
    level thread zm_cosmodrome_traps::rocket_arm_sounds();
    level zm_cosmodrome_traps::move_lifter_away();
    zm_cosmodrome_traps::unlink_rocket_pieces();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0
// Checksum 0x88860f33, Offset: 0x950
// Size: 0x4a
function rocket_launch_preparation()
{
    level waittill( #"new_lander_used" );
    exploder::exploder( "fxexp_5601" );
    level waittill( #"new_lander_used" );
    wait 6;
    level notify( #"rocket_lights_on" );
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0
// Checksum 0xda90f3c0, Offset: 0x9a8
// Size: 0x64
function pack_a_punch_close_door()
{
    move_dist = -228;
    level.pack_a_punch_door movez( move_dist, 1.5 );
    level.pack_a_punch_door waittill( #"movedone" );
    level.pack_a_punch_door disconnectpaths();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0
// Checksum 0x92244c3e, Offset: 0xa18
// Size: 0x1b4
function pack_a_punch_open_door()
{
    level flag::set( "rocket_group" );
    upper_door_model = getent( "rocket_room_top_door", "targetname" );
    upper_door_model.clip = getent( upper_door_model.target, "targetname" );
    upper_door_model.clip linkto( upper_door_model );
    upper_door_model moveto( upper_door_model.origin + upper_door_model.script_vector, 1.5 );
    level.pack_a_punch_door moveto( level.pack_a_punch_door.origin + level.pack_a_punch_door.script_vector, 1.5 );
    level.pack_a_punch_door.clip notsolid();
    upper_door_model playsound( "zmb_heavy_door_open" );
    level.pack_a_punch_door.clip playsound( "zmb_heavy_door_open" );
    level.pack_a_punch_door waittill( #"movedone" );
    level.pack_a_punch_door.clip connectpaths();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 1
// Checksum 0xb125d487, Offset: 0xbd8
// Size: 0x3c
function pack_print( str )
{
    /#
        if ( isdefined( level.pack_debug ) && level.pack_debug )
        {
            iprintln( str );
        }
    #/
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0
// Checksum 0x875e9c6e, Offset: 0xc20
// Size: 0x1c4
function launch_rocket()
{
    panel = getent( "rocket_launch_panel", "targetname" );
    self usetriggerrequirelookat();
    self sethintstring( &"ZOMBIE_NEED_POWER" );
    self setcursorhint( "HINT_NOICON" );
    level waittill( #"pack_a_punch_on" );
    self sethintstring( &"ZM_COSMODROME_WAITING_AUTHORIZATION" );
    level flag::wait_till( "launch_activated" );
    self sethintstring( &"ZM_COSMODROME_LAUNCH_AVAILABLE" );
    panel setmodel( "p7_zm_asc_console_launch_key_full_green" );
    
    /#
        self thread zm_cosmodrome::function_620401c0( self.origin, "<dev string:x28>", "<dev string:x3e>" );
    #/
    
    self waittill( #"trigger", who );
    panel playsound( "zmb_comp_activate" );
    level thread zm_cosmodrome_amb::play_cosmo_announcer_vox( "vox_ann_launch_button" );
    level thread do_launch_countdown();
    self delete();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0
// Checksum 0x16db88ca, Offset: 0xdf0
// Size: 0x174
function play_launch_loopers()
{
    level endon( #"rocket_dmg" );
    level.rocket_base_looper = getent( "rocket_base_engine", "script_noteworthy" );
    level.rocket_base_looper playloopsound( "zmb_rocket_launch", 0.1 );
    wait 2;
    level.var_4ba14d27 = spawn( "script_origin", ( 0, 0, 0 ) );
    level.var_d999ddec = spawn( "script_origin", ( 0, 0, 0 ) );
    level.var_4ba14d27 playloopsound( "zmb_rocket_air_distf", 0.1 );
    level.var_d999ddec playloopsound( "zmb_rocket_air_distr", 0.1 );
    wait 22;
    level.rocket_base_looper stoploopsound( 1 );
    wait 46;
    level.var_4ba14d27 stoploopsound( 1 );
    level.var_d999ddec stoploopsound( 1 );
    level thread delete_rocket_sound_ents();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0
// Checksum 0x6bb114d3, Offset: 0xf70
// Size: 0x5c
function delete_rocket_sound_ents()
{
    wait 5;
    
    if ( isdefined( level.var_4ba14d27 ) )
    {
        level.var_4ba14d27 delete();
    }
    
    if ( isdefined( level.var_d999ddec ) )
    {
        level.var_d999ddec delete();
    }
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0
// Checksum 0xce6b568e, Offset: 0xfd8
// Size: 0x1fc
function do_launch_countdown()
{
    level.gantry_r rotateyaw( 60, 6 );
    level.gantry_l rotateyaw( -60, 6 );
    level.gantry_l playsound( "zmb_rocket_disengage" );
    level.gantry_l playsound( "zmb_rocket_start" );
    wait 3;
    rocket_base = getent( "rocket_base_engine", "script_noteworthy" );
    level thread play_launch_loopers();
    zm_cosmodrome_traps::claw_attach( level.claw_arm_l, "claw_l" );
    zm_cosmodrome_traps::claw_attach( level.claw_arm_r, "claw_r" );
    wait 2;
    
    for ( i = 5; i > 0 ; i-- )
    {
        level thread zm_cosmodrome_amb::play_cosmo_announcer_vox( "vox_ann_launch_countdown_" + i, 1, 1 );
        wait 1;
        
        if ( i == 4 )
        {
            level.claw_arm_r moveto( level.claw_retract_r_pos, 4 );
            level.claw_arm_l moveto( level.claw_retract_l_pos, 4 );
            exploder::exploder( "fxexp_5602" );
        }
    }
    
    rocket_liftoff();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0
// Checksum 0xb4d5382c, Offset: 0x11e0
// Size: 0x2f4
function rocket_liftoff()
{
    rocket_pieces = getentarray( level.rocket.target, "targetname" );
    
    for ( i = 0; i < rocket_pieces.size ; i++ )
    {
        rocket_pieces[ i ] linkto( level.rocket );
    }
    
    level endon( #"rocket_dmg" );
    rocket_base = getent( "rocket_base_engine", "script_noteworthy" );
    exploder::stop_exploder( "fxexp_5601" );
    exploder::exploder( "fxexp_5701" );
    rocket_base clientfield::set( "COSMO_ROCKET_FX", 1 );
    level thread launch_rumble_and_quake();
    wait 1;
    level thread zm_cosmodrome_amb::play_cosmo_announcer_vox( "vox_ann_engines_firing", 1 );
    level.rocket setforcenocull();
    level.rocket moveto( level.rocket.origin + ( 0, 0, 50000 ), 50, 45 );
    wait 5;
    zm_cosmodrome_traps::claw_detach( level.claw_arm_l, "claw_l" );
    zm_cosmodrome_traps::claw_detach( level.claw_arm_r, "claw_r" );
    level thread rocket_monitor_for_damage();
    wait 5;
    level flag::set( "launch_complete" );
    level thread zm_cosmodrome_amb::play_cosmo_announcer_vox( "vox_ann_after_launch" );
    wait 20;
    level notify( #"stop_rumble" );
    level.rocket waittill( #"movedone" );
    rocket_pieces = getentarray( level.rocket.target, "targetname" );
    
    for ( i = 0; i < rocket_pieces.size ; i++ )
    {
        rocket_pieces[ i ] delete();
    }
    
    level.rocket delete();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0
// Checksum 0x9b530cf2, Offset: 0x14e0
// Size: 0x1c4
function launch_rumble_and_quake()
{
    level endon( #"stop_rumble" );
    level endon( #"stop_rumble_dmg" );
    
    while ( isdefined( level.rocket ) )
    {
        players = getplayers();
        players_in_range = [];
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( distancesquared( players[ i ].origin, level.rocket.origin ) < 30250000 )
            {
                players_in_range[ players_in_range.size ] = players[ i ];
            }
        }
        
        if ( players_in_range.size < 1 )
        {
            wait 0.1;
            continue;
        }
        
        earthquake( randomfloatrange( 0.15, 0.35 ), randomfloatrange( 0.25, 0.5 ), level.rocket.origin, 5500 );
        rumble = "slide_rumble";
        
        for ( i = 0; i < players_in_range.size ; i++ )
        {
            players_in_range[ i ] playrumbleonentity( rumble );
        }
        
        wait 0.1;
    }
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0
// Checksum 0x6a08b6c5, Offset: 0x16b0
// Size: 0x224
function rocket_monitor_for_damage()
{
    level endon( #"stop_rumble" );
    rocket_pieces = getentarray( level.rocket.target, "targetname" );
    array::thread_all( rocket_pieces, &rocket_piece_monitor_for_damage );
    level.rocket thread rocket_piece_monitor_for_damage();
    level waittill( #"rocket_dmg" );
    playsoundatposition( "zmb_rocket_destroyed", ( 0, 0, 0 ) );
    level.rocket thread rocket_explode();
    level.rocket thread piece_crash_down();
    arrayremovevalue( rocket_pieces, level.var_be9553f1 );
    level.var_be9553f1 unlink();
    level.var_be9553f1 show();
    level.var_be9553f1 thread scene::play( "p7_fxanim_zm_asc_rocket_explode_debris_bundle", level.var_be9553f1 );
    var_8094093b = getent( "rocket_base_engine", "script_noteworthy" );
    var_8094093b clientfield::set( "COSMO_ROCKET_FX", 0 );
    
    for ( i = 0; i < rocket_pieces.size ; i++ )
    {
        rocket_pieces[ i ] thread function_24d5fd7f();
    }
    
    wait 2;
    
    if ( !level flag::get( "launch_complete" ) )
    {
        level flag::set( "launch_complete" );
    }
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0
// Checksum 0x1480ab46, Offset: 0x18e0
// Size: 0x54
function function_24d5fd7f()
{
    self unlink();
    self ghost();
    wait 5;
    self delete();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 1
// Checksum 0xb11a85be, Offset: 0x1940
// Size: 0x25c
function piece_crash_down( num )
{
    trace = bullettrace( self.origin, self.origin + ( randomintrange( -100, 100 ), randomintrange( -100, 100 ), -20000 ), 0, self );
    ground_pos = trace[ "position" ] + ( 0, 0, 1.5 );
    self moveto( ground_pos, 3 );
    self rotateto( ( randomintrange( -360, 360 ), randomintrange( -360, 360 ), randomintrange( -360, 360 ) ), 3.9 );
    wait 3.9;
    earthquake( randomfloatrange( 0.25, 0.45 ), randomfloatrange( 0.65, 0.75 ), self.origin, 5500 );
    
    if ( isdefined( num ) )
    {
        if ( num == 0 )
        {
            self playsound( "zmb_rocket_top_crash" );
        }
        else if ( num == 1 )
        {
            self playsound( "zmb_rocket_bottom_crash" );
        }
    }
    
    if ( self == level.rocket )
    {
        playfxontag( level._effect[ "rocket_exp_2" ], self, "tag_origin" );
    }
    
    wait 1;
    self hide();
    wait 10;
    self delete();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0
// Checksum 0xc50b2264, Offset: 0x1ba8
// Size: 0x16c
function rocket_piece_monitor_for_damage()
{
    level endon( #"no_rocket_damage" );
    self setcandamage( 1 );
    self waittill( #"damage", dmg_amount, attacker, dir, point, dmg_type );
    
    if ( dmg_type == "MOD_PROJECTILE" || dmg_type == "MOD_PROJECTILE_SPLASH" || dmg_type == "MOD_EXPLOSIVE" || dmg_type == "MOD_EXPLOSIVE_SPLASH" || dmg_type == "MOD_GRENADE" || isplayer( attacker ) && dmg_type == "MOD_GRENADE_SPLASH" )
    {
        level notify( #"rocket_dmg" );
        level.rocket_base_looper stoploopsound( 1 );
        level.var_4ba14d27 stoploopsound( 1 );
        level.var_d999ddec stoploopsound( 1 );
        level thread delete_rocket_sound_ents();
    }
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0
// Checksum 0xb2f89a8c, Offset: 0x1d20
// Size: 0xac
function rocket_explode()
{
    playfxontag( level._effect[ "rocket_exp_1" ], self, "tag_origin" );
    self playsound( "zmb_rocket_stage_1_exp" );
    wait 2;
    var_6d564cb6 = struct::get( "pressure_pad", "targetname" );
    zm_powerups::specific_powerup_drop( "double_points", var_6d564cb6.origin );
}

