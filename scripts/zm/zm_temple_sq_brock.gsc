#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/zm_temple_sq;

#namespace zm_temple_sq_brock;

// Namespace zm_temple_sq_brock
// Params 0
// Checksum 0x50d3e64c, Offset: 0x208
// Size: 0x64
function init()
{
    level flag::init( "radio_4_played" );
    level._brock_naglines = [];
    level._brock_corpse_locations = [];
    level._radio_structs = struct::get_array( "sq_radios", "targetname" );
}

// Namespace zm_temple_sq_brock
// Params 0
// Checksum 0xb7c30401, Offset: 0x278
// Size: 0x7e
function delete_radio_internal()
{
    if ( isdefined( level._active_sq_radio ) )
    {
        level._active_sq_radio.trigger delete();
        level._active_sq_radio stopsounds();
        util::wait_network_frame();
        level._active_sq_radio delete();
        level._active_sq_radio = undefined;
    }
}

// Namespace zm_temple_sq_brock
// Params 0
// Checksum 0x962b93f3, Offset: 0x300
// Size: 0x1c
function delete_radio()
{
    level thread delete_radio_internal();
}

// Namespace zm_temple_sq_brock
// Params 0
// Checksum 0x68f4c0aa, Offset: 0x328
// Size: 0x3c
function trig_thread()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger" );
        self.owner_ent notify( #"triggered" );
    }
}

// Namespace zm_temple_sq_brock
// Params 0
// Checksum 0x315fe699, Offset: 0x370
// Size: 0x6e
function radio_debug()
{
    self endon( #"death" );
    level endon( #"radio_7_played" );
    
    /#
        while ( !( isdefined( level.disable_print3d_ent ) && level.disable_print3d_ent ) )
        {
            print3d( self.origin, "<dev string:x28>", ( 0, 255, 255 ), 1 );
            wait 1;
        }
    #/
}

// Namespace zm_temple_sq_brock
// Params 1
// Checksum 0xca01e1d0, Offset: 0x3e8
// Size: 0x304
function radio9_override( struct )
{
    self notify( #"overridden" );
    self endon( #"death" );
    self.trigger delete();
    self ghost();
    sidequest = level._zombie_sidequests[ "sq" ];
    
    if ( sidequest.num_reps >= 3 )
    {
        return;
    }
    
    level waittill( #"picked_up" );
    level waittill( #"flush_done" );
    self show();
    
    for ( target = struct.target; isdefined( target ) ; target = struct.target )
    {
        struct = struct::get( target, "targetname" );
        time = struct.script_float;
        
        if ( !isdefined( time ) )
        {
            time = 1;
        }
        
        self moveto( struct.origin, time, time / 10 );
        self waittill( #"movedone" );
    }
    
    self.trigger = spawn( "trigger_radius_use", self.origin + ( 0, 0, 12 ), 0, 64, 72 );
    self.trigger triggerignoreteam();
    self.trigger.radius = 64;
    self.trigger.height = 72;
    self.trigger setcursorhint( "HINT_NOICON" );
    self.trigger.owner_ent = self;
    self.trigger thread trig_thread();
    self waittill( #"triggered" );
    snd = "vox_radio_egg_" + self.script_int - 1;
    self playsound( snd );
    self playloopsound( "vox_radio_egg_snapshot", 1 );
    wait self.manual_wait;
    self stoploopsound( 1 );
    level flag::set( "radio_9_played" );
}

// Namespace zm_temple_sq_brock
// Params 1
// Checksum 0xaf8cd1c8, Offset: 0x6f8
// Size: 0x44
function radio7_override( struct )
{
    self endon( #"death" );
    self waittill( #"triggered" );
    level flag::set( "radio_7_played" );
}

// Namespace zm_temple_sq_brock
// Params 1
// Checksum 0x7f699553, Offset: 0x748
// Size: 0x44
function radio4_override( struct )
{
    self endon( #"death" );
    self waittill( #"triggered" );
    level flag::set( "radio_4_played" );
}

// Namespace zm_temple_sq_brock
// Params 1
// Checksum 0x62d263e3, Offset: 0x798
// Size: 0x184
function radio2_override( struct )
{
    self endon( #"death" );
    self notify( #"overridden" );
    self waittill( #"triggered" );
    var_8e0fe378 = level._player_who_pressed_the_switch.characterindex;
    
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
    
    snd = "vox_radio_egg_" + self.script_int - 1 + "" + var_bc7547cb;
    self playsoundwithnotify( snd, "radiodone" );
    self playloopsound( "vox_radio_egg_snapshot", 1 );
    self waittill( #"radiodone" );
    self stoploopsound( 1 );
}

// Namespace zm_temple_sq_brock
// Params 0
// Checksum 0xebe5cdef, Offset: 0x928
// Size: 0xb4
function radio_thread()
{
    self endon( #"death" );
    self endon( #"overridden" );
    self thread radio_debug();
    self waittill( #"triggered" );
    snd = "vox_radio_egg_" + self.script_int - 1;
    self playsound( snd );
    self playloopsound( "vox_radio_egg_snapshot", 1 );
    wait self.manual_wait;
    self stoploopsound( 1 );
}

// Namespace zm_temple_sq_brock
// Params 2
// Checksum 0x87564af8, Offset: 0x9e8
// Size: 0x2c8
function create_radio( radio_num, thread_func )
{
    delete_radio();
    radio_struct = undefined;
    
    for ( i = 0; i < level._radio_structs.size ; i++ )
    {
        if ( level._radio_structs[ i ].script_int == radio_num )
        {
            radio_struct = level._radio_structs[ i ];
            break;
        }
    }
    
    if ( !isdefined( radio_struct ) )
    {
        println( "<dev string:x2a>" + radio_num );
        return;
    }
    
    radio = spawn( "script_model", radio_struct.origin );
    radio.angles = radio_struct.angles;
    radio setmodel( "p7_zm_sha_recorder_digital" );
    radio.script_int = radio_struct.script_int;
    radio.script_noteworthy = radio_struct.script_noteworthy;
    radio set_manual_wait_time( radio_num );
    radio.trigger = spawn( "trigger_radius_use", radio.origin + ( 0, 0, 12 ), 0, 64, 72 );
    radio.trigger triggerignoreteam();
    radio.trigger.radius = 64;
    radio.trigger.height = 72;
    radio.trigger setcursorhint( "HINT_NOICON" );
    radio.trigger.owner_ent = radio;
    radio.trigger thread trig_thread();
    radio thread radio_thread();
    
    if ( isdefined( thread_func ) )
    {
        radio thread [[ thread_func ]]( radio_struct );
    }
    
    level._active_sq_radio = radio;
}

// Namespace zm_temple_sq_brock
// Params 1
// Checksum 0xce6d9fcc, Offset: 0xcb8
// Size: 0x118
function set_manual_wait_time( num )
{
    if ( !isdefined( num ) )
    {
        num = 1;
    }
    
    waittime = 45;
    
    switch ( num )
    {
        case 1:
            waittime = 113;
            break;
        case 2:
            waittime = 95;
            break;
        case 3:
            waittime = 20;
            break;
        case 4:
            waittime = 58;
            break;
        case 5:
            waittime = 74;
            break;
        case 6:
            waittime = 35;
            break;
        case 7:
            waittime = 40;
            break;
        case 8:
            waittime = 39;
            break;
        case 9:
            waittime = 76;
            break;
    }
    
    self.manual_wait = waittime;
}

