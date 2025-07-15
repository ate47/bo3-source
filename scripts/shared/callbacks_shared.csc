#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/footsteps_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace callback;

// Namespace callback
// Params 3
// Checksum 0xeaad0c5c, Offset: 0x1e0
// Size: 0x14c
function callback( event, localclientnum, params )
{
    if ( isdefined( level._callbacks ) && isdefined( level._callbacks[ event ] ) )
    {
        for ( i = 0; i < level._callbacks[ event ].size ; i++ )
        {
            callback = level._callbacks[ event ][ i ][ 0 ];
            obj = level._callbacks[ event ][ i ][ 1 ];
            
            if ( !isdefined( callback ) )
            {
                continue;
            }
            
            if ( isdefined( obj ) )
            {
                if ( isdefined( params ) )
                {
                    obj thread [[ callback ]]( localclientnum, self, params );
                }
                else
                {
                    obj thread [[ callback ]]( localclientnum, self );
                }
                
                continue;
            }
            
            if ( isdefined( params ) )
            {
                self thread [[ callback ]]( localclientnum, params );
                continue;
            }
            
            self thread [[ callback ]]( localclientnum );
        }
    }
}

// Namespace callback
// Params 3
// Checksum 0x6971a7b4, Offset: 0x338
// Size: 0x14c
function entity_callback( event, localclientnum, params )
{
    if ( isdefined( self._callbacks ) && isdefined( self._callbacks[ event ] ) )
    {
        for ( i = 0; i < self._callbacks[ event ].size ; i++ )
        {
            callback = self._callbacks[ event ][ i ][ 0 ];
            obj = self._callbacks[ event ][ i ][ 1 ];
            
            if ( !isdefined( callback ) )
            {
                continue;
            }
            
            if ( isdefined( obj ) )
            {
                if ( isdefined( params ) )
                {
                    obj thread [[ callback ]]( localclientnum, self, params );
                }
                else
                {
                    obj thread [[ callback ]]( localclientnum, self );
                }
                
                continue;
            }
            
            if ( isdefined( params ) )
            {
                self thread [[ callback ]]( localclientnum, params );
                continue;
            }
            
            self thread [[ callback ]]( localclientnum );
        }
    }
}

// Namespace callback
// Params 3
// Checksum 0x3a916861, Offset: 0x490
// Size: 0x18c
function add_callback( event, func, obj )
{
    assert( isdefined( event ), "<dev string:x28>" );
    
    if ( !isdefined( level._callbacks ) || !isdefined( level._callbacks[ event ] ) )
    {
        level._callbacks[ event ] = [];
    }
    
    foreach ( callback in level._callbacks[ event ] )
    {
        if ( callback[ 0 ] == func )
        {
            if ( !isdefined( obj ) || callback[ 1 ] == obj )
            {
                return;
            }
        }
    }
    
    array::add( level._callbacks[ event ], array( func, obj ), 0 );
    
    if ( isdefined( obj ) )
    {
        obj thread remove_callback_on_death( event, func );
    }
}

// Namespace callback
// Params 3
// Checksum 0x47b03572, Offset: 0x628
// Size: 0x164
function add_entity_callback( event, func, obj )
{
    assert( isdefined( event ), "<dev string:x28>" );
    
    if ( !isdefined( self._callbacks ) || !isdefined( self._callbacks[ event ] ) )
    {
        self._callbacks[ event ] = [];
    }
    
    foreach ( callback in self._callbacks[ event ] )
    {
        if ( callback[ 0 ] == func )
        {
            if ( !isdefined( obj ) || callback[ 1 ] == obj )
            {
                return;
            }
        }
    }
    
    array::add( self._callbacks[ event ], array( func, obj ), 0 );
}

// Namespace callback
// Params 2
// Checksum 0x1e0389d7, Offset: 0x798
// Size: 0x3c
function remove_callback_on_death( event, func )
{
    self waittill( #"death" );
    remove_callback( event, func, self );
}

// Namespace callback
// Params 3
// Checksum 0xf6dbdc0b, Offset: 0x7e0
// Size: 0x13a
function remove_callback( event, func, obj )
{
    assert( isdefined( event ), "<dev string:x58>" );
    assert( isdefined( level._callbacks[ event ] ), "<dev string:x8b>" );
    
    foreach ( index, func_group in level._callbacks[ event ] )
    {
        if ( func_group[ 0 ] == func )
        {
            if ( func_group[ 1 ] === obj )
            {
                arrayremoveindex( level._callbacks[ event ], index, 0 );
            }
        }
    }
}

// Namespace callback
// Params 2
// Checksum 0x9e9c1fb7, Offset: 0x928
// Size: 0x34
function on_localclient_connect( func, obj )
{
    add_callback( #"hash_da8d7d74", func, obj );
}

// Namespace callback
// Params 2
// Checksum 0x5f5eaa03, Offset: 0x968
// Size: 0x34
function on_localclient_shutdown( func, obj )
{
    add_callback( #"hash_e64327a6", func, obj );
}

// Namespace callback
// Params 2
// Checksum 0x827b66a7, Offset: 0x9a8
// Size: 0x34
function on_finalize_initialization( func, obj )
{
    add_callback( #"hash_36fb1b1a", func, obj );
}

// Namespace callback
// Params 2
// Checksum 0x94e186a6, Offset: 0x9e8
// Size: 0x34
function on_localplayer_spawned( func, obj )
{
    add_callback( #"hash_842e788a", func, obj );
}

// Namespace callback
// Params 2
// Checksum 0x49ce9dfb, Offset: 0xa28
// Size: 0x34
function remove_on_localplayer_spawned( func, obj )
{
    remove_callback( #"hash_842e788a", func, obj );
}

// Namespace callback
// Params 2
// Checksum 0x4606d377, Offset: 0xa68
// Size: 0x34
function on_spawned( func, obj )
{
    add_callback( #"hash_bc12b61f", func, obj );
}

// Namespace callback
// Params 2
// Checksum 0xd71999b3, Offset: 0xaa8
// Size: 0x34
function remove_on_spawned( func, obj )
{
    remove_callback( #"hash_bc12b61f", func, obj );
}

// Namespace callback
// Params 2
// Checksum 0xe963b01a, Offset: 0xae8
// Size: 0x34
function on_shutdown( func, obj )
{
    add_entity_callback( #"hash_390259d9", func, obj );
}

// Namespace callback
// Params 2
// Checksum 0x7cbf803b, Offset: 0xb28
// Size: 0x34
function on_start_gametype( func, obj )
{
    add_callback( #"hash_cc62acca", func, obj );
}

// Namespace callback
// Params 0
// Checksum 0xbd9ee26c, Offset: 0xb68
// Size: 0x2c
function codecallback_preinitialization()
{
    callback( #"hash_ecc6aecf" );
    system::run_pre_systems();
}

// Namespace callback
// Params 0
// Checksum 0xac821d11, Offset: 0xba0
// Size: 0x2c
function codecallback_finalizeinitialization()
{
    system::run_post_systems();
    callback( #"hash_36fb1b1a" );
}

// Namespace callback
// Params 3
// Checksum 0x6b4192ef, Offset: 0xbd8
// Size: 0xfc
function codecallback_statechange( clientnum, system, newstate )
{
    if ( !isdefined( level._systemstates ) )
    {
        level._systemstates = [];
    }
    
    if ( !isdefined( level._systemstates[ system ] ) )
    {
        level._systemstates[ system ] = spawnstruct();
    }
    
    level._systemstates[ system ].state = newstate;
    
    if ( isdefined( level._systemstates[ system ].callback ) )
    {
        [[ level._systemstates[ system ].callback ]]( clientnum, newstate );
        return;
    }
    
    println( "<dev string:xb8>" + system + "<dev string:xe4>" );
}

// Namespace callback
// Params 0
// Checksum 0xb1a144af, Offset: 0xce0
// Size: 0x54
function codecallback_maprestart()
{
    println( "<dev string:x10c>" );
    util::waitforclient( 0 );
    level thread util::init_utility();
}

// Namespace callback
// Params 1
// Checksum 0xa3189630, Offset: 0xd40
// Size: 0x48
function codecallback_localclientconnect( localclientnum )
{
    println( "<dev string:x12e>" + localclientnum );
    [[ level.callbacklocalclientconnect ]]( localclientnum );
}

/#

    // Namespace callback
    // Params 1
    // Checksum 0xc07545d1, Offset: 0xd90
    // Size: 0x34, Type: dev
    function codecallback_localclientdisconnect( clientnum )
    {
        println( "<dev string:x15b>" + clientnum );
    }

#/

// Namespace callback
// Params 2
// Checksum 0x2c1d9c42, Offset: 0xdd0
// Size: 0x2a
function codecallback_glasssmash( org, dir )
{
    level notify( #"glass_smash", org, dir );
}

// Namespace callback
// Params 5
// Checksum 0x24fb4f5e, Offset: 0xe08
// Size: 0x54
function codecallback_soundsetambientstate( ambientroom, ambientpackage, roomcollidercent, packagecollidercent, defaultroom )
{
    audio::setcurrentambientstate( ambientroom, ambientpackage, roomcollidercent, packagecollidercent, defaultroom );
}

// Namespace callback
// Params 3
// Checksum 0x89379260, Offset: 0xe68
// Size: 0x1c
function codecallback_soundsetaiambientstate( triggers, actors, numtriggers )
{
    
}

// Namespace callback
// Params 2
// Checksum 0x30140c87, Offset: 0xe90
// Size: 0x34
function codecallback_soundplayuidecodeloop( decodestring, playtimems )
{
    self thread audio::soundplayuidecodeloop( decodestring, playtimems );
}

// Namespace callback
// Params 1
// Checksum 0xa19a4e89, Offset: 0xed0
// Size: 0x40
function codecallback_playerspawned( localclientnum )
{
    println( "<dev string:x18b>" );
    [[ level.callbackplayerspawned ]]( localclientnum );
}

// Namespace callback
// Params 3
// Checksum 0x6e34919e, Offset: 0xf18
// Size: 0x44
function codecallback_gibevent( localclientnum, type, locations )
{
    if ( isdefined( level._gibeventcbfunc ) )
    {
        self thread [[ level._gibeventcbfunc ]]( localclientnum, type, locations );
    }
}

// Namespace callback
// Params 0
// Checksum 0x8c9e42c4, Offset: 0xf68
// Size: 0x20
function codecallback_precachegametype()
{
    if ( isdefined( level.callbackprecachegametype ) )
    {
        [[ level.callbackprecachegametype ]]();
    }
}

// Namespace callback
// Params 0
// Checksum 0x98ea46d7, Offset: 0xf90
// Size: 0x48
function codecallback_startgametype()
{
    if ( !isdefined( level.gametypestarted ) || isdefined( level.callbackstartgametype ) && !level.gametypestarted )
    {
        [[ level.callbackstartgametype ]]();
        level.gametypestarted = 1;
    }
}

// Namespace callback
// Params 1
// Checksum 0x90291ad2, Offset: 0xfe0
// Size: 0x20
function codecallback_entityspawned( localclientnum )
{
    [[ level.callbackentityspawned ]]( localclientnum );
}

// Namespace callback
// Params 3
// Checksum 0x33d10e9c, Offset: 0x1008
// Size: 0x76
function codecallback_soundnotify( localclientnum, entity, note )
{
    switch ( note )
    {
        default:
            if ( getgametypesetting( "silentPlant" ) == 0 )
            {
                entity playsound( localclientnum, "fly_bomb_buttons_npc" );
            }
            
            break;
    }
}

// Namespace callback
// Params 2
// Checksum 0xc75c4aea, Offset: 0x1088
// Size: 0x5c
function codecallback_entityshutdown( localclientnum, entity )
{
    if ( isdefined( level.callbackentityshutdown ) )
    {
        [[ level.callbackentityshutdown ]]( localclientnum, entity );
    }
    
    entity entity_callback( #"hash_390259d9", localclientnum );
}

// Namespace callback
// Params 2
// Checksum 0x6444fb87, Offset: 0x10f0
// Size: 0x4c
function codecallback_localclientshutdown( localclientnum, entity )
{
    level.localplayers = getlocalplayers();
    entity callback( #"hash_e64327a6", localclientnum );
}

// Namespace callback
// Params 2
// Checksum 0x2b71ff28, Offset: 0x1148
// Size: 0x2c
function codecallback_localclientchanged( localclientnum, entity )
{
    level.localplayers = getlocalplayers();
}

// Namespace callback
// Params 12
// Checksum 0xa7a85a58, Offset: 0x1180
// Size: 0xb0
function codecallback_airsupport( localclientnum, x, y, z, type, yaw, team, teamfaction, owner, exittype, time, height )
{
    if ( isdefined( level.callbackairsupport ) )
    {
        [[ level.callbackairsupport ]]( localclientnum, x, y, z, type, yaw, team, teamfaction, owner, exittype, time, height );
    }
}

// Namespace callback
// Params 2
// Checksum 0x37011c8d, Offset: 0x1238
// Size: 0x3c
function codecallback_demojump( localclientnum, time )
{
    level notify( #"demo_jump", time );
    level notify( "demo_jump" + localclientnum, time );
}

// Namespace callback
// Params 1
// Checksum 0xe50f14c4, Offset: 0x1280
// Size: 0x2c
function codecallback_demoplayerswitch( localclientnum )
{
    level notify( #"demo_player_switch" );
    level notify( "demo_player_switch" + localclientnum );
}

// Namespace callback
// Params 1
// Checksum 0xa27ae773, Offset: 0x12b8
// Size: 0x2c
function codecallback_playerswitch( localclientnum )
{
    level notify( #"player_switch" );
    level notify( "player_switch" + localclientnum );
}

// Namespace callback
// Params 2
// Checksum 0xf3effed8, Offset: 0x12f0
// Size: 0x3c
function codecallback_killcambegin( localclientnum, time )
{
    level notify( #"killcam_begin", time );
    level notify( "killcam_begin" + localclientnum, time );
}

// Namespace callback
// Params 2
// Checksum 0xc28a1ab2, Offset: 0x1338
// Size: 0x3c
function codecallback_killcamend( localclientnum, time )
{
    level notify( #"killcam_end", time );
    level notify( "killcam_end" + localclientnum, time );
}

// Namespace callback
// Params 2
// Checksum 0x3f32ebfa, Offset: 0x1380
// Size: 0x38
function codecallback_creatingcorpse( localclientnum, player )
{
    if ( isdefined( level.callbackcreatingcorpse ) )
    {
        [[ level.callbackcreatingcorpse ]]( localclientnum, player );
    }
}

// Namespace callback
// Params 4
// Checksum 0x5110290a, Offset: 0x13c0
// Size: 0x44
function codecallback_playerfoliage( client_num, player, firstperson, quiet )
{
    footsteps::playerfoliage( client_num, player, firstperson, quiet );
}

// Namespace callback
// Params 1
// Checksum 0xc45a0b4a, Offset: 0x1410
// Size: 0xcc
function codecallback_activateexploder( exploder_id )
{
    if ( !isdefined( level._exploder_ids ) )
    {
        return;
    }
    
    keys = getarraykeys( level._exploder_ids );
    exploder = undefined;
    
    for ( i = 0; i < keys.size ; i++ )
    {
        if ( level._exploder_ids[ keys[ i ] ] == exploder_id )
        {
            exploder = keys[ i ];
            break;
        }
    }
    
    if ( !isdefined( exploder ) )
    {
        return;
    }
    
    exploder::activate_exploder( exploder );
}

// Namespace callback
// Params 1
// Checksum 0x77bf9cbd, Offset: 0x14e8
// Size: 0xcc
function codecallback_deactivateexploder( exploder_id )
{
    if ( !isdefined( level._exploder_ids ) )
    {
        return;
    }
    
    keys = getarraykeys( level._exploder_ids );
    exploder = undefined;
    
    for ( i = 0; i < keys.size ; i++ )
    {
        if ( level._exploder_ids[ keys[ i ] ] == exploder_id )
        {
            exploder = keys[ i ];
            break;
        }
    }
    
    if ( !isdefined( exploder ) )
    {
        return;
    }
    
    exploder::stop_exploder( exploder );
}

// Namespace callback
// Params 3
// Checksum 0x1c1d043e, Offset: 0x15c0
// Size: 0x44
function codecallback_chargeshotweaponsoundnotify( localclientnum, weapon, chargeshotlevel )
{
    if ( isdefined( level.sndchargeshot_func ) )
    {
        self [[ level.sndchargeshot_func ]]( localclientnum, weapon, chargeshotlevel );
    }
}

// Namespace callback
// Params 1
// Checksum 0xf810ae0a, Offset: 0x1610
// Size: 0x4c
function codecallback_hostmigration( localclientnum )
{
    println( "<dev string:x1ae>" );
    
    if ( isdefined( level.callbackhostmigration ) )
    {
        [[ level.callbackhostmigration ]]( localclientnum );
    }
}

// Namespace callback
// Params 3
// Checksum 0xe967be99, Offset: 0x1668
// Size: 0x44
function codecallback_dogsoundnotify( client_num, entity, note )
{
    if ( isdefined( level.callbackdogsoundnotify ) )
    {
        [[ level.callbackdogsoundnotify ]]( client_num, entity, note );
    }
}

// Namespace callback
// Params 5
// Checksum 0xf8f39517, Offset: 0x16b8
// Size: 0x50
function codecallback_playaifootstep( client_num, pos, surface, notetrack, bone )
{
    [[ level.callbackplayaifootstep ]]( client_num, pos, surface, notetrack, bone );
}

// Namespace callback
// Params 1
// Checksum 0xd5261361, Offset: 0x1710
// Size: 0x20
function codecallback_playlightloopexploder( exploderindex )
{
    [[ level.callbackplaylightloopexploder ]]( exploderindex );
}

// Namespace callback
// Params 1
// Checksum 0xc9492d6b, Offset: 0x1738
// Size: 0x1a2
function codecallback_stoplightloopexploder( exploderindex )
{
    num = int( exploderindex );
    
    if ( isdefined( level.createfxexploders[ num ] ) )
    {
        for ( i = 0; i < level.createfxexploders[ num ].size ; i++ )
        {
            ent = level.createfxexploders[ num ][ i ];
            
            if ( !isdefined( ent.looperfx ) )
            {
                ent.looperfx = [];
            }
            
            for ( clientnum = 0; clientnum < level.max_local_clients ; clientnum++ )
            {
                if ( localclientactive( clientnum ) )
                {
                    if ( isdefined( ent.looperfx[ clientnum ] ) )
                    {
                        for ( looperfxcount = 0; looperfxcount < ent.looperfx[ clientnum ].size ; looperfxcount++ )
                        {
                            deletefx( clientnum, ent.looperfx[ clientnum ][ looperfxcount ] );
                        }
                    }
                }
                
                ent.looperfx[ clientnum ] = [];
            }
            
            ent.looperfx = [];
        }
    }
}

// Namespace callback
// Params 3
// Checksum 0xb0124b18, Offset: 0x18e8
// Size: 0x44
function codecallback_clientflag( localclientnum, flag, set )
{
    if ( isdefined( level.callbackclientflag ) )
    {
        [[ level.callbackclientflag ]]( localclientnum, flag, set );
    }
}

// Namespace callback
// Params 2
// Checksum 0x6ee22f78, Offset: 0x1938
// Size: 0x5a
function codecallback_clientflagasval( localclientnum, val )
{
    if ( isdefined( level._client_flagasval_callbacks ) && isdefined( level._client_flagasval_callbacks[ self.type ] ) )
    {
        self thread [[ level._client_flagasval_callbacks[ self.type ] ]]( localclientnum, val );
    }
}

// Namespace callback
// Params 5
// Checksum 0x99e51925, Offset: 0x19a0
// Size: 0x5c
function codecallback_extracamrenderhero( localclientnum, jobindex, extracamindex, sessionmode, characterindex )
{
    if ( isdefined( level.extra_cam_render_hero_func_callback ) )
    {
        [[ level.extra_cam_render_hero_func_callback ]]( localclientnum, jobindex, extracamindex, sessionmode, characterindex );
    }
}

// Namespace callback
// Params 4
// Checksum 0xe5d74533, Offset: 0x1a08
// Size: 0x50
function codecallback_extracamrenderlobbyclienthero( localclientnum, jobindex, extracamindex, sessionmode )
{
    if ( isdefined( level.extra_cam_render_lobby_client_hero_func_callback ) )
    {
        [[ level.extra_cam_render_lobby_client_hero_func_callback ]]( localclientnum, jobindex, extracamindex, sessionmode );
    }
}

// Namespace callback
// Params 6
// Checksum 0x7e10c680, Offset: 0x1a60
// Size: 0x68
function codecallback_extracamrendercurrentheroheadshot( localclientnum, jobindex, extracamindex, sessionmode, characterindex, isdefaulthero )
{
    if ( isdefined( level.extra_cam_render_current_hero_headshot_func_callback ) )
    {
        [[ level.extra_cam_render_current_hero_headshot_func_callback ]]( localclientnum, jobindex, extracamindex, sessionmode, characterindex, isdefaulthero );
    }
}

// Namespace callback
// Params 7
// Checksum 0xe648d319, Offset: 0x1ad0
// Size: 0x74
function codecallback_extracamrendercharacterbodyitem( localclientnum, jobindex, extracamindex, sessionmode, characterindex, itemindex, defaultitemrender )
{
    if ( isdefined( level.extra_cam_render_character_body_item_func_callback ) )
    {
        [[ level.extra_cam_render_character_body_item_func_callback ]]( localclientnum, jobindex, extracamindex, sessionmode, characterindex, itemindex, defaultitemrender );
    }
}

// Namespace callback
// Params 7
// Checksum 0x31a14d17, Offset: 0x1b50
// Size: 0x74
function codecallback_extracamrendercharacterhelmetitem( localclientnum, jobindex, extracamindex, sessionmode, characterindex, itemindex, defaultitemrender )
{
    if ( isdefined( level.extra_cam_render_character_helmet_item_func_callback ) )
    {
        [[ level.extra_cam_render_character_helmet_item_func_callback ]]( localclientnum, jobindex, extracamindex, sessionmode, characterindex, itemindex, defaultitemrender );
    }
}

// Namespace callback
// Params 6
// Checksum 0xaa2cdcf9, Offset: 0x1bd0
// Size: 0x68
function codecallback_extracamrendercharacterheaditem( localclientnum, jobindex, extracamindex, sessionmode, headindex, defaultitemrender )
{
    if ( isdefined( level.extra_cam_render_character_head_item_func_callback ) )
    {
        [[ level.extra_cam_render_character_head_item_func_callback ]]( localclientnum, jobindex, extracamindex, sessionmode, headindex, defaultitemrender );
    }
}

// Namespace callback
// Params 5
// Checksum 0xe2ba0aba, Offset: 0x1c40
// Size: 0x5c
function codecallback_extracamrenderoutfitpreview( localclientnum, jobindex, extracamindex, sessionmode, outfitindex )
{
    if ( isdefined( level.extra_cam_render_outfit_preview_func_callback ) )
    {
        [[ level.extra_cam_render_outfit_preview_func_callback ]]( localclientnum, jobindex, extracamindex, sessionmode, outfitindex );
    }
}

// Namespace callback
// Params 10
// Checksum 0x8a9a6ccf, Offset: 0x1ca8
// Size: 0x98
function codecallback_extracamrenderwcpaintjobicon( localclientnum, extracamindex, jobindex, attachmentvariantstring, weaponoptions, weaponplusattachments, loadoutslot, paintjobindex, paintjobslot, isfilesharepreview )
{
    if ( isdefined( level.extra_cam_render_wc_paintjobicon_func_callback ) )
    {
        [[ level.extra_cam_render_wc_paintjobicon_func_callback ]]( localclientnum, extracamindex, jobindex, attachmentvariantstring, weaponoptions, weaponplusattachments, loadoutslot, paintjobindex, paintjobslot, isfilesharepreview );
    }
}

// Namespace callback
// Params 10
// Checksum 0x9f9e78a4, Offset: 0x1d48
// Size: 0x98
function codecallback_extracamrenderwcvarianticon( localclientnum, extracamindex, jobindex, attachmentvariantstring, weaponoptions, weaponplusattachments, loadoutslot, paintjobindex, paintjobslot, isfilesharepreview )
{
    if ( isdefined( level.extra_cam_render_wc_varianticon_func_callback ) )
    {
        [[ level.extra_cam_render_wc_varianticon_func_callback ]]( localclientnum, extracamindex, jobindex, attachmentvariantstring, weaponoptions, weaponplusattachments, loadoutslot, paintjobindex, paintjobslot, isfilesharepreview );
    }
}

// Namespace callback
// Params 3
// Checksum 0x687ccc9a, Offset: 0x1de8
// Size: 0x44
function codecallback_collectibleschanged( changedclient, collectiblesarray, localclientnum )
{
    if ( isdefined( level.on_collectibles_change ) )
    {
        [[ level.on_collectibles_change ]]( changedclient, collectiblesarray, localclientnum );
    }
}

// Namespace callback
// Params 2
// Checksum 0xbeba8a1e, Offset: 0x1e38
// Size: 0x72
function add_weapon_type( weapontype, callback )
{
    if ( !isdefined( level.weapon_type_callback_array ) )
    {
        level.weapon_type_callback_array = [];
    }
    
    if ( isstring( weapontype ) )
    {
        weapontype = getweapon( weapontype );
    }
    
    level.weapon_type_callback_array[ weapontype ] = callback;
}

// Namespace callback
// Params 1
// Checksum 0xfce44147, Offset: 0x1eb8
// Size: 0x62
function spawned_weapon_type( localclientnum )
{
    weapontype = self.weapon.rootweapon;
    
    if ( isdefined( level.weapon_type_callback_array ) && isdefined( level.weapon_type_callback_array[ weapontype ] ) )
    {
        self thread [[ level.weapon_type_callback_array[ weapontype ] ]]( localclientnum );
    }
}

// Namespace callback
// Params 3
// Checksum 0xe70a8280, Offset: 0x1f28
// Size: 0x5a
function codecallback_callclientscript( pself, label, param )
{
    if ( !isdefined( level._animnotifyfuncs ) )
    {
        return;
    }
    
    if ( isdefined( level._animnotifyfuncs[ label ] ) )
    {
        pself [[ level._animnotifyfuncs[ label ] ]]( param );
    }
}

// Namespace callback
// Params 2
// Checksum 0x18c60ad5, Offset: 0x1f90
// Size: 0x52
function codecallback_callclientscriptonlevel( label, param )
{
    if ( !isdefined( level._animnotifyfuncs ) )
    {
        return;
    }
    
    if ( isdefined( level._animnotifyfuncs[ label ] ) )
    {
        level [[ level._animnotifyfuncs[ label ] ]]( param );
    }
}

// Namespace callback
// Params 1
// Checksum 0x6c4aad3a, Offset: 0x1ff0
// Size: 0x34
function codecallback_serversceneinit( scene_name )
{
    if ( isdefined( level.server_scenes[ scene_name ] ) )
    {
        level thread scene::init( scene_name );
    }
}

// Namespace callback
// Params 1
// Checksum 0x1ee31fd4, Offset: 0x2030
// Size: 0x4c
function codecallback_serversceneplay( scene_name )
{
    level thread scene_black_screen();
    
    if ( isdefined( level.server_scenes[ scene_name ] ) )
    {
        level thread scene::play( scene_name );
    }
}

// Namespace callback
// Params 1
// Checksum 0x1dc0bb33, Offset: 0x2088
// Size: 0x5c
function codecallback_serverscenestop( scene_name )
{
    level thread scene_black_screen();
    
    if ( isdefined( level.server_scenes[ scene_name ] ) )
    {
        level thread scene::stop( scene_name, undefined, undefined, undefined, 1 );
    }
}

// Namespace callback
// Params 0
// Checksum 0xa6fb2505, Offset: 0x20f0
// Size: 0x178
function scene_black_screen()
{
    foreach ( i, player in level.localplayers )
    {
        if ( !isdefined( player.lui_black ) )
        {
            player.lui_black = createluimenu( i, "FullScreenBlack" );
            openluimenu( i, player.lui_black );
        }
    }
    
    wait 0.016;
    
    foreach ( i, player in level.localplayers )
    {
        if ( isdefined( player.lui_black ) )
        {
            closeluimenu( i, player.lui_black );
            player.lui_black = undefined;
        }
    }
}

// Namespace callback
// Params 3
// Checksum 0x9ec38fa0, Offset: 0x2270
// Size: 0x44
function codecallback_gadgetvisionpulse_reveal( local_client_num, entity, breveal )
{
    if ( isdefined( level.gadgetvisionpulse_reveal_func ) )
    {
        entity [[ level.gadgetvisionpulse_reveal_func ]]( local_client_num, breveal );
    }
}

