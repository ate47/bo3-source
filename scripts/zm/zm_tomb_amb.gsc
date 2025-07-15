#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_audio_zhd;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;

#namespace zm_tomb_amb;

// Namespace zm_tomb_amb
// Params 0
// Checksum 0xbcd9bc1, Offset: 0x478
// Size: 0x74
function init()
{
    clientfield::register( "toplayer", "sndEggElements", 21000, 1, "int" );
    level.var_61f315ab = &function_3630300b;
    level.var_8229c449 = &function_231d9741;
    level.zmannouncerprefix = "vox_zmbat_";
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0x36521491, Offset: 0x4f8
// Size: 0x7c
function main()
{
    level thread sndmusicegg();
    level thread snd115egg();
    level thread sndstingersetup();
    level thread sndmaelstrom();
    level thread function_45b4acf2();
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0xb22d4c26, Offset: 0x580
// Size: 0x74
function sndstingersetup()
{
    level.sndroundwait = 1;
    level flag::wait_till( "start_zombie_round_logic" );
    level thread sndstingerroundwait();
    level thread locationstingerwait();
    level thread snddoormusictrigs();
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0x99ec1590, Offset: 0x600
// Size: 0x4
function sndstingersetupstates()
{
    
}

// Namespace zm_tomb_amb
// Params 2
// Checksum 0xd1743bdc, Offset: 0x610
// Size: 0x194
function locationstingerwait( zone_name, type )
{
    array = sndlocationsarray();
    sndnorepeats = 3;
    numcut = 0;
    level.sndlastzone = undefined;
    level.sndlocationplayed = 0;
    level thread sndlocationbetweenroundswait();
    
    while ( true )
    {
        level waittill( #"newzoneactive", activezone );
        wait 0.1;
        
        if ( !sndlocationshouldplay( array, activezone ) )
        {
            continue;
        }
        
        if ( isdefined( level.sndroundwait ) && level.sndroundwait )
        {
            continue;
        }
        
        level thread sndplaystinger( activezone );
        level.sndlocationplayed = 1;
        array = sndcurrentlocationarray( array, activezone, numcut, sndnorepeats );
        level.sndlastzone = activezone;
        
        if ( numcut >= sndnorepeats )
        {
            numcut = 0;
        }
        else
        {
            numcut++;
        }
        
        level waittill( #"between_round_over" );
        
        while ( isdefined( level.sndroundwait ) && level.sndroundwait )
        {
            wait 0.1;
        }
        
        level.sndlocationplayed = 0;
    }
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0x72ce64e3, Offset: 0x7b0
// Size: 0x9e
function sndlocationsarray()
{
    array = [];
    array[ 0 ] = "zone_nml_18";
    array[ 1 ] = "zone_village_2";
    array[ 2 ] = "ug_bottom_zone";
    array[ 3 ] = "zone_air_stairs";
    array[ 4 ] = "zone_fire_stairs";
    array[ 5 ] = "zone_bolt_stairs";
    array[ 6 ] = "zone_ice_stairs";
    return array;
}

// Namespace zm_tomb_amb
// Params 2
// Checksum 0x93b8378f, Offset: 0x858
// Size: 0x1de
function sndlocationshouldplay( array, activezone )
{
    shouldplay = 0;
    
    if ( !zm_audio_zhd::function_8090042c() )
    {
        return shouldplay;
    }
    
    foreach ( place in array )
    {
        if ( place == activezone )
        {
            shouldplay = 1;
        }
    }
    
    if ( shouldplay == 0 )
    {
        return shouldplay;
    }
    
    playersinlocal = 0;
    players = getplayers();
    
    foreach ( player in players )
    {
        if ( player zm_zonemgr::entity_in_zone( activezone ) )
        {
            if ( !( isdefined( player.afterlife ) && player.afterlife ) )
            {
                playersinlocal++;
            }
        }
    }
    
    if ( playersinlocal >= 1 )
    {
        shouldplay = 1;
    }
    else
    {
        shouldplay = 0;
    }
    
    return shouldplay;
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0x4797a58d, Offset: 0xa40
// Size: 0x40
function sndstingerroundwait()
{
    wait 25;
    level.sndroundwait = 0;
    
    while ( true )
    {
        level waittill( #"end_of_round" );
        level thread sndstingerroundwait_start();
    }
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0xd29b1e9e, Offset: 0xa88
// Size: 0x2c
function sndstingerroundwait_start()
{
    level.sndroundwait = 1;
    wait 0.05;
    level thread sndstingerroundwait_end();
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0x48baab53, Offset: 0xac0
// Size: 0x2c
function sndstingerroundwait_end()
{
    level endon( #"end_of_round" );
    level waittill( #"between_round_over" );
    wait 28;
    level.sndroundwait = 0;
}

// Namespace zm_tomb_amb
// Params 4
// Checksum 0x971b12b, Offset: 0xaf8
// Size: 0xea
function sndcurrentlocationarray( current_array, activezone, numcut, max_num_removed )
{
    if ( numcut >= max_num_removed )
    {
        current_array = sndlocationsarray();
    }
    
    foreach ( place in current_array )
    {
        if ( place == activezone )
        {
            arrayremovevalue( current_array, place );
            break;
        }
    }
    
    return current_array;
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0x795379fd, Offset: 0xbf0
// Size: 0x188
function sndlocationbetweenrounds()
{
    level endon( #"newzoneactive" );
    activezones = zm_zonemgr::get_active_zone_names();
    
    foreach ( zone in activezones )
    {
        if ( isdefined( level.sndlastzone ) && zone == level.sndlastzone )
        {
            continue;
        }
        
        players = getplayers();
        
        foreach ( player in players )
        {
            if ( player zm_zonemgr::entity_in_zone( zone ) )
            {
                wait 0.1;
                level notify( #"newzoneactive", zone );
                return;
            }
        }
    }
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0x39759d54, Offset: 0xd80
// Size: 0x78
function sndlocationbetweenroundswait()
{
    while ( isdefined( level.sndroundwait ) && level.sndroundwait )
    {
        wait 0.1;
    }
    
    while ( true )
    {
        level thread sndlocationbetweenrounds();
        level waittill( #"between_round_over" );
        
        while ( isdefined( level.sndroundwait ) && level.sndroundwait )
        {
            wait 0.1;
        }
    }
}

// Namespace zm_tomb_amb
// Params 1
// Checksum 0x1aafb04, Offset: 0xe00
// Size: 0x3c
function sndplaystinger( state )
{
    if ( !zm_audio_zhd::function_8090042c() )
    {
        return;
    }
    
    level thread zm_audio::sndmusicsystem_playstate( state );
}

// Namespace zm_tomb_amb
// Params 2
// Checksum 0xb9c56077, Offset: 0xe48
// Size: 0x44
function sndplaystingerwithoverride( state, var_70f98722 )
{
    if ( !zm_audio_zhd::function_8090042c() )
    {
        return;
    }
    
    level thread zm_audio::sndmusicsystem_playstate( state );
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0x5fa32eb9, Offset: 0xe98
// Size: 0xb2
function snddoormusictrigs()
{
    trigs = getentarray( "sndMusicDoor", "script_noteworthy" );
    
    foreach ( trig in trigs )
    {
        trig thread snddoormusic();
    }
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0x701cf535, Offset: 0xf58
// Size: 0xb4
function snddoormusic()
{
    self endon( #"snddoormusic_triggered" );
    
    while ( true )
    {
        self waittill( #"trigger" );
        
        if ( !zm_audio_zhd::function_8090042c() )
        {
            wait 0.1;
            continue;
        }
        
        break;
    }
    
    if ( isdefined( self.target ) )
    {
        ent = getent( self.target, "targetname" );
        ent notify( #"snddoormusic_triggered" );
    }
    
    level thread sndplaystingerwithoverride( self.script_sound );
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0xf021d8b9, Offset: 0x1018
// Size: 0xf8
function sndmaelstrom()
{
    trig = getent( "sndMaelstrom", "targetname" );
    
    if ( !isdefined( trig ) )
    {
        return;
    }
    
    while ( true )
    {
        trig waittill( #"trigger", who );
        
        if ( isplayer( who ) && !( isdefined( who.sndmaelstrom ) && who.sndmaelstrom ) )
        {
            who.sndmaelstrom = 1;
            who clientfield::set_to_player( "sndMaelstrom", 1 );
        }
        
        who thread sndmaelstrom_timeout();
        wait 0.1;
    }
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0x65fda3af, Offset: 0x1118
// Size: 0x5c
function sndmaelstrom_timeout()
{
    self notify( #"sndmaelstrom_timeout" );
    self endon( #"sndmaelstrom_timeout" );
    self endon( #"disconnect" );
    wait 2;
    self.sndmaelstrom = 0;
    self clientfield::set_to_player( "sndMaelstrom", 0 );
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0x104bdc26, Offset: 0x1180
// Size: 0x5c
function sndmusicegg()
{
    level thread zm_audio_zhd::function_e753d4f();
    level flag::wait_till( "snd_song_completed" );
    level thread zm_audio::sndmusicsystem_playstate( "archangel" );
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0x74530a74, Offset: 0x11e8
// Size: 0xc2
function snd115egg()
{
    n_count = 0;
    level.var_69a8687 = 0;
    var_8bd44282 = struct::get_array( "mus115", "targetname" );
    array::thread_all( var_8bd44282, &function_89a607c3 );
    
    while ( n_count < 3 )
    {
        level waittill( #"hash_34d7d690" );
        n_count++;
    }
    
    level thread zm_audio::sndmusicsystem_playstate( "aether" );
    level notify( #"hash_c598ee9d" );
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0xd09253e1, Offset: 0x12b8
// Size: 0xaa
function function_89a607c3()
{
    level endon( #"hash_c598ee9d" );
    var_169695f4 = array( 1, 1, 5 );
    self thread zm_sidequests::fake_use( "115_trig_activated", &function_f36e092d );
    self waittill( #"115_trig_activated" );
    playsoundatposition( "zmb_ee_mus_activate", self.origin );
    level.var_69a8687++;
    level notify( #"hash_34d7d690" );
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0x4df83568, Offset: 0x1370
// Size: 0x40, Type: bool
function function_f36e092d()
{
    if ( !zm_audio_zhd::function_8090042c() )
    {
        return false;
    }
    
    if ( self getstance() != "prone" )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0x8c8e873a, Offset: 0x13b8
// Size: 0x34
function function_45b4acf2()
{
    level thread function_ada4c741();
    level thread function_87c575b6();
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0xe67a7b3c, Offset: 0x13f8
// Size: 0x70
function function_ada4c741()
{
    level endon( #"snd_zhdegg_activate" );
    
    while ( true )
    {
        level waittill( #"player_zombie_blood", e_player );
        e_player clientfield::set_to_player( "sndEggElements", 1 );
        e_player thread function_42354338();
    }
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0xb60afc3c, Offset: 0x1470
// Size: 0x44
function function_42354338()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self waittill( #"zombie_blood_over" );
    self clientfield::set_to_player( "sndEggElements", 0 );
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0xd77d938e, Offset: 0x14c0
// Size: 0xb4
function function_87c575b6()
{
    var_e5e0779d = struct::get_array( "s_zhdegg_elements", "targetname" );
    
    if ( var_e5e0779d.size <= 0 )
    {
        return;
    }
    
    array::thread_all( var_e5e0779d, &function_66aff463 );
    
    for ( var_f2633d7f = 0; var_f2633d7f < var_e5e0779d.size ; var_f2633d7f++ )
    {
        level waittill( #"hash_556250a8" );
    }
    
    level flag::set( "snd_zhdegg_activate" );
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0x368162b6, Offset: 0x1580
// Size: 0x154
function function_66aff463()
{
    var_8e7ce497 = spawn( "trigger_damage", self.origin, 0, 15, 50 );
    
    while ( true )
    {
        var_8e7ce497 waittill( #"damage", amount, inflictor, direction, point, type, tagname, modelname, partname, weapon );
        
        if ( isplayer( inflictor ) && issubstr( weapon.name, "staff_" + self.script_string ) )
        {
            level notify( #"hash_556250a8" );
            level util::clientnotify( "snd" + self.script_string );
            break;
        }
    }
    
    var_8e7ce497 delete();
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0x23ef15bc, Offset: 0x16e0
// Size: 0x11a, Type: bool
function function_3630300b()
{
    var_d1f154fd = struct::get_array( "s_ballerina_timed", "targetname" );
    var_d1f154fd = array::sort_by_script_int( var_d1f154fd, 1 );
    level.var_aa39de8 = 0;
    wait 1;
    
    foreach ( var_6d450235 in var_d1f154fd )
    {
        var_6d450235 thread function_b8227f87();
        wait 1;
    }
    
    while ( level.var_aa39de8 < var_d1f154fd.size )
    {
        wait 0.1;
    }
    
    wait 1;
    return true;
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0x93968a68, Offset: 0x1808
// Size: 0x124
function function_b8227f87()
{
    self.var_ac086ffb = util::spawn_model( self.model, self.origin, self.angles );
    self.var_ac086ffb clientfield::set( "snd_zhdegg", 1 );
    self.var_ac086ffb playloopsound( "mus_musicbox_lp", 2 );
    self thread zm_audio_zhd::function_9d55fd08();
    self thread zm_audio_zhd::function_2fdaabf3();
    self util::waittill_any( "ballerina_destroyed" );
    level.var_aa39de8++;
    self.var_ac086ffb clientfield::set( "snd_zhdegg", 0 );
    util::wait_network_frame();
    self.var_ac086ffb delete();
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0x939ff91d, Offset: 0x1938
// Size: 0xc4
function function_231d9741()
{
    playsoundatposition( "zmb_sam_egg_success", ( 0, 0, 0 ) );
    wait 3;
    s_ballerina_end = struct::get( "s_ballerina_end", "targetname" );
    s_ballerina_end thread function_69f032ca();
    s_ballerina_end waittill( #"hash_3a53ac43" );
    zm_powerups::specific_powerup_drop( "full_ammo", s_ballerina_end.origin );
    level flag::set( "snd_zhdegg_completed" );
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0x17910bf8, Offset: 0x1a08
// Size: 0x17c
function function_69f032ca()
{
    self endon( #"hash_34014bea" );
    self.var_ac086ffb = util::spawn_model( self.model, self.origin, self.angles );
    self.var_ac086ffb clientfield::set( "snd_zhdegg", 1 );
    self thread zm_audio_zhd::function_9d55fd08();
    self.var_ac086ffb playloopsound( "mus_musicbox_lp", 2 );
    var_209d26c2 = struct::get( self.target, "targetname" );
    self thread function_bec55ee6();
    self.var_ac086ffb moveto( var_209d26c2.origin, 25, 10 );
    self.var_ac086ffb waittill( #"movedone" );
    self notify( #"hash_3a53ac43" );
    self.var_ac086ffb clientfield::set( "snd_zhdegg", 0 );
    util::wait_network_frame();
    self.var_ac086ffb delete();
}

// Namespace zm_tomb_amb
// Params 0
// Checksum 0xf34f6004, Offset: 0x1b90
// Size: 0x1c4
function function_bec55ee6()
{
    self endon( #"hash_3a53ac43" );
    self.var_ac086ffb setcandamage( 1 );
    self.var_ac086ffb.health = 1000000;
    
    while ( true )
    {
        self.var_ac086ffb waittill( #"damage", damage, attacker, dir, loc, type, model, tag, part, weapon, flags );
        
        if ( !isdefined( attacker ) || !isplayer( attacker ) )
        {
            continue;
        }
        
        if ( type == "MOD_PROJECTILE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_GRENADE" || type == "MOD_EXPLOSIVE" )
        {
            continue;
        }
        
        self notify( #"hash_34014bea" );
        self.var_ac086ffb clientfield::set( "snd_zhdegg", 0 );
        util::wait_network_frame();
        self.var_ac086ffb delete();
        self thread function_69f032ca();
        break;
    }
}

