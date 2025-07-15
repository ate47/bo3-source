#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/trigger_shared;

#namespace cp_mi_zurich_coalescence_sound;

// Namespace cp_mi_zurich_coalescence_sound
// Params 0
// Checksum 0x619ba62c, Offset: 0x220
// Size: 0x94
function main()
{
    level thread function_61bfc68f();
    level thread function_2a3f78bf();
    level thread function_7d065157();
    level thread function_c24abe63();
    level thread function_6f4cea1d();
    level thread function_252e5c74();
}

// Namespace cp_mi_zurich_coalescence_sound
// Params 0
// Checksum 0x2ec20b91, Offset: 0x2c0
// Size: 0x444
function function_c24abe63()
{
    level audio::playloopat( "amb_emergency_alarm_buzz", ( -9406, 40799, 349 ) );
    level audio::playloopat( "amb_containment_room", ( -11125, 43509, 0 ) );
    level audio::playloopat( "evt_vortex", ( -31633, 3164, 1373 ) );
    level audio::playloopat( "evt_vortex", ( 749, -20385, 1205 ) );
    level audio::playloopat( "evt_vortex", ( -22216, -26825, 1650 ) );
    level audio::playloopat( "pfx_water_runoff", ( -19515, -1656, 1370 ) );
    level audio::playloopat( "pfx_water_runoff", ( -19459, -16488, 1366 ) );
    level audio::playloopat( "pfx_water_runoff", ( -19383, -16637, 1351 ) );
    level audio::playloopat( "pfx_water_runoff", ( -19258, -16779, 1340 ) );
    level audio::playloopat( "pfx_water_runoff", ( -19424, -16994, 1324 ) );
    level audio::playloopat( "pfx_water_runoff", ( -18964, -17213, 1324 ) );
    level audio::playloopat( "pfx_water_runoff", ( -18888, -17421, 1316 ) );
    level audio::playloopat( "pfx_water_runoff", ( 16645, 7162, 58 ) );
    level audio::playloopat( "pfx_water_runoff", ( 16538, 6892, 33 ) );
    level audio::playloopat( "pfx_water_runoff", ( 16316, 6699, 26 ) );
    level audio::playloopat( "pfx_water_runoff", ( 16136, 6514, 18 ) );
    level audio::playloopat( "pfx_water_runoff", ( 15830, 6403, 16 ) );
    level audio::playloopat( "pfx_water_runoff", ( 14665, 6386, 33 ) );
    level audio::playloopat( "pfx_water_runoff", ( 14817, 6217, 13 ) );
    level audio::playloopat( "pfx_water_runoff", ( 14999, 6261, 9 ) );
    level audio::playloopat( "pfx_water_runoff", ( 15149, 6366, 10 ) );
    level audio::playloopat( "pfx_water_runoff", ( 15308, 6212, 15 ) );
    level audio::playloopat( "pfx_water_runoff", ( 15546, 6230, 14 ) );
    level audio::playloopat( "pfx_water_runoff", ( 15843, 6416, 27 ) );
    level audio::playloopat( "pfx_water_runoff", ( 16142, 6516, 23 ) );
    level audio::playloopat( "pfx_water_runoff", ( 16353, 6750, 30 ) );
    level audio::playloopat( "amb_blood_waterfall", ( -20099, 5149, 271 ) );
}

// Namespace cp_mi_zurich_coalescence_sound
// Params 0
// Checksum 0x394a490f, Offset: 0x710
// Size: 0x1f4
function function_61bfc68f()
{
    level audio::playloopat( "amb_broadcast_00", ( -9976, 23986, 52 ) );
    level audio::playloopat( "amb_broadcast_01", ( -9976, 24146, 52 ) );
    level audio::playloopat( "amb_emergency_tone", ( -9963, 24568, 52 ) );
    level audio::playloopat( "amb_broadcast_03", ( -9974, 24766, 52 ) );
    level audio::playloopat( "amb_broadcast_04", ( -9145, 24734, 52 ) );
    level audio::playloopat( "amb_broadcast_00", ( -8486, 25318, 52 ) );
    level waittill( #"hash_a1eebd3d" );
    level audio::stoploopat( "amb_broadcast_00", ( -9976, 23986, 52 ) );
    level audio::stoploopat( "amb_broadcast_01", ( -9976, 24146, 52 ) );
    level audio::stoploopat( "amb_emergency_tone", ( -9963, 24568, 52 ) );
    level audio::stoploopat( "amb_broadcast_03", ( -9974, 24766, 52 ) );
    level audio::stoploopat( "amb_broadcast_04", ( -9145, 24734, 52 ) );
    level audio::stoploopat( "amb_broadcast_00", ( -8486, 3163, 52 ) );
}

// Namespace cp_mi_zurich_coalescence_sound
// Params 0
// Checksum 0x1a309ada, Offset: 0x910
// Size: 0x2c
function function_7d065157()
{
    level audio::playloopat( "evt_waterrise", ( -31478, 3175, 1286 ) );
}

// Namespace cp_mi_zurich_coalescence_sound
// Params 0
// Checksum 0x1cf6a40f, Offset: 0x948
// Size: 0x4c
function function_2a3f78bf()
{
    level thread function_79e0ed83();
    level thread function_15dcdc5a();
    level thread function_bf9775f1();
}

// Namespace cp_mi_zurich_coalescence_sound
// Params 0
// Checksum 0xfe08b0cf, Offset: 0x9a0
// Size: 0xbc
function function_79e0ed83()
{
    level waittill( #"stSINmus" );
    audio::playloopat( "amb_data_tunnel", ( 0, 0, 0 ) );
    level thread function_357ee4f7();
    target_origin = ( -2152, 3613, 1506 );
    player = getlocalplayer( 0 );
    level.tensionactive = 1;
    level sndramperthink( player, target_origin, "mus_i_live_data_tunnel", 0, 1, 200, 3600 );
}

// Namespace cp_mi_zurich_coalescence_sound
// Params 0
// Checksum 0x4387dda, Offset: 0xa68
// Size: 0xc4
function function_15dcdc5a()
{
    level waittill( #"stZURmus" );
    audio::playloopat( "amb_data_tunnel", ( 0, 0, 0 ) );
    level thread function_357ee4f7();
    target_origin = ( 182, 3271, 1383 );
    player = getlocalplayer( 0 );
    level.tensionactive = 1;
    level sndramperthink( player, target_origin, "mus_i_live_data_tunnel", 0.4, 1, 200, 3600 );
}

// Namespace cp_mi_zurich_coalescence_sound
// Params 0
// Checksum 0xadbcfce9, Offset: 0xb38
// Size: 0xbc
function function_bf9775f1()
{
    level waittill( #"stCAMU" );
    audio::playloopat( "amb_data_tunnel", ( 0, 0, 0 ) );
    level thread function_357ee4f7();
    target_origin = ( 2256, 2635, 1676 );
    player = getlocalplayer( 0 );
    level.tensionactive = 1;
    level sndramperthink( player, target_origin, "mus_i_live_data_tunnel", 0, 1, 200, 3600 );
}

// Namespace cp_mi_zurich_coalescence_sound
// Params 0
// Checksum 0x6b11d557, Offset: 0xc00
// Size: 0x40
function function_357ee4f7()
{
    level waittill( #"stp_mus" );
    wait 5;
    audio::stoploopat( "amb_data_tunnel", ( 0, 0, 0 ) );
    level.tensionactive = 0;
}

// Namespace cp_mi_zurich_coalescence_sound
// Params 13
// Checksum 0x9e830b1e, Offset: 0xc48
// Size: 0x404
function sndramperthink( player, target_origin, alias1, min_vol1, max_vol1, min_dist1, max_dist1, alias2, min_vol2, max_vol2, min_dist2, max_dist2, end_alias )
{
    level endon( #"save_restore" );
    level endon( #"disconnect" );
    player endon( #"death" );
    player endon( #"disconnect" );
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    volume1 = undefined;
    volume2 = undefined;
    
    if ( isdefined( alias1 ) )
    {
        sndloop1_ent = spawn( 0, ( 0, 0, 0 ), "script_origin" );
        sndloop1_id = sndloop1_ent playloopsound( alias1, 3 );
        sndloop1_min_volume = min_vol1;
        sndloop1_max_volume = max_vol1;
        sndloop1_min_distance = min_dist1;
        sndloop1_max_distance = max_dist1;
        volume1 = 0;
    }
    
    if ( isdefined( alias2 ) )
    {
        sndloop2_ent = spawn( 0, ( 0, 0, 0 ), "script_origin" );
        sndloop2_id = sndloop2_ent playloopsound( alias2, 3 );
        sndloop2_min_volume = min_vol2;
        sndloop2_max_volume = max_vol2;
        sndloop2_min_distance = min_dist2;
        sndloop2_max_distance = max_dist2;
        volume2 = 0;
    }
    
    level thread function_860d167b( sndloop1_ent, sndloop2_ent, sndloop1_id, sndloop2_id );
    
    while ( isdefined( level.tensionactive ) && level.tensionactive )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        distance = distance( target_origin, player.origin );
        
        if ( isdefined( volume1 ) )
        {
            volume1 = audio::scale_speed( sndloop1_min_distance, sndloop1_max_distance, sndloop1_min_volume, sndloop1_max_volume, distance );
            volume1 = abs( 1 - volume1 );
            setsoundvolume( sndloop1_id, volume1 );
        }
        
        if ( isdefined( volume2 ) )
        {
            volume2 = audio::scale_speed( sndloop2_min_distance, sndloop2_max_distance, sndloop2_min_volume, sndloop2_max_volume, distance );
            volume2 = abs( 1 - volume2 );
            setsoundvolume( sndloop2_id, volume2 );
        }
        
        wait 0.1;
    }
    
    level notify( #"hash_61477803" );
    
    if ( isdefined( end_alias ) )
    {
        playsound( 0, end_alias, ( 0, 0, 0 ) );
    }
    
    if ( isdefined( sndloop1_ent ) )
    {
        sndloop1_ent delete();
    }
    
    if ( isdefined( sndloop2_ent ) )
    {
        sndloop2_ent delete();
    }
}

// Namespace cp_mi_zurich_coalescence_sound
// Params 4
// Checksum 0x8a8b399f, Offset: 0x1058
// Size: 0xdc
function function_860d167b( ent1, ent2, id1, id2 )
{
    level endon( #"hash_61477803" );
    level waittill( #"save_restore" );
    ent1 delete();
    id1 = undefined;
    target_origin = ( 2256, 2635, 1676 );
    wait 2;
    player = getlocalplayer( 0 );
    
    if ( isdefined( player ) )
    {
        level thread sndramperthink( player, target_origin, "mus_i_live_data_tunnel", 0, 1, 200, 3600 );
    }
}

// Namespace cp_mi_zurich_coalescence_sound
// Params 0
// Checksum 0x735ccaa6, Offset: 0x1140
// Size: 0x13c
function function_6f4cea1d()
{
    level waittill( #"sndpa" );
    level audio::playloopat( "mus_whiterabbit_diagetic", ( -10397, 39703, 601 ) );
    level audio::playloopat( "mus_whiterabbit_diagetic", ( -9550, 39146, 426 ) );
    level audio::playloopat( "mus_whiterabbit_diagetic", ( -8409, 37890, 585 ) );
    level waittill( #"sndpa" );
    wait 5;
    level audio::stoploopat( "mus_whiterabbit_diagetic", ( -10397, 39703, 601 ) );
    level audio::stoploopat( "mus_whiterabbit_diagetic", ( -9550, 39146, 426 ) );
    level audio::stoploopat( "mus_whiterabbit_diagetic", ( -8409, 37890, 585 ) );
}

// Namespace cp_mi_zurich_coalescence_sound
// Params 0
// Checksum 0x684e3f09, Offset: 0x1288
// Size: 0x54
function function_252e5c74()
{
    level audio::playloopat( "amb_air_raid", ( -7922, 22826, 376 ) );
    level audio::playloopat( "amb_blood_waterfall", ( 20084, 5242, 303 ) );
}

