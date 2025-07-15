#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/end_game_taunts;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace end_game_flow;

// Namespace end_game_flow
// Params 0, eflags: 0x2
// Checksum 0xd6e23e2a, Offset: 0x2c0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "end_game_flow", &__init__, undefined, undefined );
}

// Namespace end_game_flow
// Params 0
// Checksum 0xc8f1a7c0, Offset: 0x300
// Size: 0x184
function __init__()
{
    clientfield::register( "world", "displayTop3Players", 1, 1, "int", &handletopthreeplayers, 0, 0 );
    clientfield::register( "world", "triggerScoreboardCamera", 1, 1, "int", &showscoreboard, 0, 0 );
    clientfield::register( "world", "playTop0Gesture", 1000, 3, "int", &handleplaytop0gesture, 0, 0 );
    clientfield::register( "world", "playTop1Gesture", 1000, 3, "int", &handleplaytop1gesture, 0, 0 );
    clientfield::register( "world", "playTop2Gesture", 1000, 3, "int", &handleplaytop2gesture, 0, 0 );
    level thread streamerwatcher();
}

// Namespace end_game_flow
// Params 3
// Checksum 0x6f52165, Offset: 0x490
// Size: 0xbc
function setanimationonmodel( localclientnum, charactermodel, topplayerindex )
{
    anim_name = end_game_taunts::getidleanimname( localclientnum, charactermodel, topplayerindex );
    
    if ( isdefined( anim_name ) )
    {
        charactermodel util::waittill_dobj( localclientnum );
        
        if ( !charactermodel hasanimtree() )
        {
            charactermodel useanimtree( $all_player );
        }
        
        charactermodel setanim( anim_name );
    }
}

// Namespace end_game_flow
// Params 3
// Checksum 0x19f8a4af, Offset: 0x558
// Size: 0x454
function loadcharacteronmodel( localclientnum, charactermodel, topplayerindex )
{
    assert( isdefined( charactermodel ) );
    bodymodel = gettopplayersbodymodel( localclientnum, topplayerindex );
    displaytopplayermodel = createuimodel( getuimodelforcontroller( localclientnum ), "displayTopPlayer" + topplayerindex + 1 );
    setuimodelvalue( displaytopplayermodel, 1 );
    
    if ( !isdefined( bodymodel ) || bodymodel == "" )
    {
        setuimodelvalue( displaytopplayermodel, 0 );
        return;
    }
    
    charactermodel setmodel( bodymodel );
    helmetmodel = gettopplayershelmetmodel( localclientnum, topplayerindex );
    
    if ( !charactermodel isattached( helmetmodel, "" ) )
    {
        charactermodel.helmetmodel = helmetmodel;
        charactermodel attach( helmetmodel, "" );
    }
    
    moderenderoptions = getcharactermoderenderoptions( currentsessionmode() );
    bodyrenderoptions = gettopplayersbodyrenderoptions( localclientnum, topplayerindex );
    helmetrenderoptions = gettopplayershelmetrenderoptions( localclientnum, topplayerindex );
    weaponrenderoptions = gettopplayersweaponrenderoptions( localclientnum, topplayerindex );
    charactermodel.bodymodel = bodymodel;
    charactermodel.moderenderoptions = moderenderoptions;
    charactermodel.bodyrenderoptions = bodyrenderoptions;
    charactermodel.helmetrenderoptions = helmetrenderoptions;
    charactermodel.headrenderoptions = helmetrenderoptions;
    weapon_right = gettopplayersweaponinfo( localclientnum, topplayerindex );
    
    if ( !isdefined( level.weaponnone ) )
    {
        level.weaponnone = getweapon( "none" );
    }
    
    charactermodel setbodyrenderoptions( moderenderoptions, bodyrenderoptions, helmetrenderoptions, helmetrenderoptions );
    
    if ( weapon_right[ "weapon" ] == level.weaponnone )
    {
        weapon_right[ "weapon" ] = getweapon( "ar_standard" );
        charactermodel.showcaseweapon = weapon_right[ "weapon" ];
        charactermodel attachweapon( weapon_right[ "weapon" ] );
        return;
    }
    
    charactermodel.showcaseweapon = weapon_right[ "weapon" ];
    charactermodel.showcaseweaponrenderoptions = weaponrenderoptions;
    charactermodel.showcaseweaponacvi = weapon_right[ "acvi" ];
    charactermodel attachweapon( weapon_right[ "weapon" ], weaponrenderoptions, weapon_right[ "acvi" ] );
    charactermodel useweaponhidetags( weapon_right[ "weapon" ] );
}

// Namespace end_game_flow
// Params 3
// Checksum 0xd06557c8, Offset: 0x9b8
// Size: 0x64
function setupmodelandanimation( localclientnum, charactermodel, topplayerindex )
{
    charactermodel endon( #"entityshutdown" );
    loadcharacteronmodel( localclientnum, charactermodel, topplayerindex );
    setanimationonmodel( localclientnum, charactermodel, topplayerindex );
}

// Namespace end_game_flow
// Params 1
// Checksum 0x6259daa, Offset: 0xa28
// Size: 0x126
function preparetopthreeplayers( localclientnum )
{
    numclients = gettopscorercount( localclientnum );
    position = struct::get( "endgame_top_players_struct", "targetname" );
    
    if ( !isdefined( position ) )
    {
        return;
    }
    
    for ( index = 0; index < 3 ; index++ )
    {
        if ( index < numclients )
        {
            model = spawn( localclientnum, position.origin, "script_model" );
            loadcharacteronmodel( localclientnum, model, index );
            model hide();
            model sethighdetail( 1 );
        }
    }
}

// Namespace end_game_flow
// Params 1
// Checksum 0x13aae18a, Offset: 0xb58
// Size: 0x394
function showtopthreeplayers( localclientnum )
{
    level.topplayercharacters = [];
    topplayerscriptstructs = [];
    topplayerscriptstructs[ 0 ] = struct::get( "TopPlayer1", "targetname" );
    topplayerscriptstructs[ 1 ] = struct::get( "TopPlayer2", "targetname" );
    topplayerscriptstructs[ 2 ] = struct::get( "TopPlayer3", "targetname" );
    
    foreach ( index, scriptstruct in topplayerscriptstructs )
    {
        level.topplayercharacters[ index ] = spawn( localclientnum, scriptstruct.origin, "script_model" );
        level.topplayercharacters[ index ].angles = scriptstruct.angles;
    }
    
    numclients = gettopscorercount( localclientnum );
    
    foreach ( index, charactermodel in level.topplayercharacters )
    {
        if ( index < numclients )
        {
            thread setupmodelandanimation( localclientnum, charactermodel, index );
            
            if ( index == 0 )
            {
                thread end_game_taunts::playcurrenttaunt( localclientnum, charactermodel, index );
            }
        }
    }
    
    /#
        level thread end_game_taunts::check_force_taunt();
        level thread end_game_taunts::check_force_gesture();
        level thread end_game_taunts::draw_runner_up_bounds();
    #/
    
    position = struct::get( "endgame_top_players_struct", "targetname" );
    playmaincamxcam( localclientnum, level.endgamexcamname, 0, "cam_topscorers", "topscorers", position.origin, position.angles );
    playradiantexploder( localclientnum, "exploder_mp_endgame_lights" );
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "displayTop3Players" ), 1 );
    thread spamuimodelvalue( localclientnum );
    thread checkforgestures( localclientnum );
}

// Namespace end_game_flow
// Params 1
// Checksum 0xac5d42b1, Offset: 0xef8
// Size: 0x68
function spamuimodelvalue( localclientnum )
{
    while ( true )
    {
        wait 0.25;
        setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "displayTop3Players" ), 1 );
    }
}

// Namespace end_game_flow
// Params 1
// Checksum 0x9f8e9cf7, Offset: 0xf68
// Size: 0x76
function checkforgestures( localclientnum )
{
    localplayers = getlocalplayers();
    
    for ( i = 0; i < localplayers.size ; i++ )
    {
        thread checkforplayergestures( localclientnum, localplayers[ i ], i );
    }
}

// Namespace end_game_flow
// Params 3
// Checksum 0xc8ac1d3c, Offset: 0xfe8
// Size: 0xdc
function checkforplayergestures( localclientnum, localplayer, playerindex )
{
    localtopplayerindex = localplayer gettopplayersindex( localclientnum );
    
    if ( !isdefined( localtopplayerindex ) || !isdefined( level.topplayercharacters ) || localtopplayerindex >= level.topplayercharacters.size )
    {
        return;
    }
    
    charactermodel = level.topplayercharacters[ localtopplayerindex ];
    
    if ( localtopplayerindex > 0 )
    {
        wait 3;
    }
    else if ( isdefined( charactermodel.playingtaunt ) )
    {
        charactermodel waittill( #"tauntfinished" );
    }
    
    showgestures( localclientnum, playerindex );
}

// Namespace end_game_flow
// Params 2
// Checksum 0x70cec1e7, Offset: 0x10d0
// Size: 0x8c
function showgestures( localclientnum, playerindex )
{
    gesturesmodel = getuimodel( getuimodelforcontroller( localclientnum ), "topPlayerInfo.showGestures" );
    
    if ( isdefined( gesturesmodel ) )
    {
        setuimodelvalue( gesturesmodel, 1 );
        allowactionslotinput( playerindex );
    }
}

// Namespace end_game_flow
// Params 7
// Checksum 0x648b58e6, Offset: 0x1168
// Size: 0x5c
function handleplaytop0gesture( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    handleplaygesture( localclientnum, 0, newval );
}

// Namespace end_game_flow
// Params 7
// Checksum 0x258d76a6, Offset: 0x11d0
// Size: 0x5c
function handleplaytop1gesture( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    handleplaygesture( localclientnum, 1, newval );
}

// Namespace end_game_flow
// Params 7
// Checksum 0x154a28ee, Offset: 0x1238
// Size: 0x5c
function handleplaytop2gesture( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    handleplaygesture( localclientnum, 2, newval );
}

// Namespace end_game_flow
// Params 3
// Checksum 0x916bce76, Offset: 0x12a0
// Size: 0xc4
function handleplaygesture( localclientnum, topplayerindex, gesturetype )
{
    if ( gesturetype > 2 || !isdefined( level.topplayercharacters ) || topplayerindex >= level.topplayercharacters.size )
    {
        return;
    }
    
    charactermodel = level.topplayercharacters[ topplayerindex ];
    
    if ( isdefined( charactermodel.playinggesture ) && ( isdefined( charactermodel.playingtaunt ) || charactermodel.playinggesture ) )
    {
        return;
    }
    
    thread end_game_taunts::playgesturetype( localclientnum, charactermodel, topplayerindex, gesturetype );
}

// Namespace end_game_flow
// Params 0
// Checksum 0x2d21bd00, Offset: 0x1370
// Size: 0x50
function streamerwatcher()
{
    while ( true )
    {
        level waittill( #"streamfksl", localclientnum );
        preparetopthreeplayers( localclientnum );
        end_game_taunts::stream_epic_models();
    }
}

// Namespace end_game_flow
// Params 7
// Checksum 0x38e15084, Offset: 0x13c8
// Size: 0x84
function handletopthreeplayers( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( isdefined( newval ) && newval > 0 && isdefined( level.endgamexcamname ) )
    {
        level.showedtopthreeplayers = 1;
        showtopthreeplayers( localclientnum );
    }
}

// Namespace end_game_flow
// Params 7
// Checksum 0x7d9a714a, Offset: 0x1458
// Size: 0x150
function showscoreboard( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( isdefined( newval ) && newval > 0 && isdefined( level.endgamexcamname ) )
    {
        end_game_taunts::stop_stream_epic_models();
        end_game_taunts::deletecameraglass( undefined );
        position = struct::get( "endgame_top_players_struct", "targetname" );
        playmaincamxcam( localclientnum, level.endgamexcamname, 0, "cam_topscorers", "", position.origin, position.angles );
        setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "forceScoreboard" ), 1 );
        level.inendgameflow = 1;
    }
}

