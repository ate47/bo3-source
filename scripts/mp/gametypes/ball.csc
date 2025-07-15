#using scripts/codescripts/struct;
#using scripts/mp/_shoutcaster;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/util_shared;

#namespace ball;

// Namespace ball
// Params 0
// Checksum 0x9e2e2566, Offset: 0x350
// Size: 0x236
function main()
{
    clientfield::register( "allplayers", "ballcarrier", 1, 1, "int", &player_ballcarrier_changed, 0, 1 );
    clientfield::register( "allplayers", "passoption", 1, 1, "int", &player_passoption_changed, 0, 0 );
    clientfield::register( "world", "ball_away", 1, 1, "int", &world_ball_away_changed, 0, 1 );
    clientfield::register( "world", "ball_score_allies", 1, 1, "int", &world_ball_score_allies, 0, 1 );
    clientfield::register( "world", "ball_score_axis", 1, 1, "int", &world_ball_score_axis, 0, 1 );
    callback::on_localclient_connect( &on_localclient_connect );
    callback::on_spawned( &on_player_spawned );
    
    if ( !getdvarint( "tu11_programaticallyColoredGameFX" ) )
    {
        level.effect_scriptbundles = [];
        level.effect_scriptbundles[ "goal" ] = struct::get_script_bundle( "teamcolorfx", "teamcolorfx_uplink_goal" );
        level.effect_scriptbundles[ "goal_score" ] = struct::get_script_bundle( "teamcolorfx", "teamcolorfx_uplink_goal_score" );
    }
}

// Namespace ball
// Params 1
// Checksum 0x7eab9c46, Offset: 0x590
// Size: 0x17c
function on_localclient_connect( localclientnum )
{
    objective_ids = [];
    
    while ( !isdefined( objective_ids[ "allies" ] ) )
    {
        objective_ids[ "allies" ] = serverobjective_getobjective( localclientnum, "ball_goal_allies" );
        objective_ids[ "axis" ] = serverobjective_getobjective( localclientnum, "ball_goal_axis" );
        wait 0.05;
    }
    
    foreach ( key, objective in objective_ids )
    {
        level.goals[ key ] = spawnstruct();
        level.goals[ key ].objectiveid = objective;
        setup_goal( localclientnum, level.goals[ key ] );
    }
    
    setup_fx( localclientnum );
}

// Namespace ball
// Params 1
// Checksum 0x7f52c131, Offset: 0x718
// Size: 0xe2
function on_player_spawned( localclientnum )
{
    players = getplayers( localclientnum );
    
    foreach ( player in players )
    {
        if ( player util::isenemyplayer( self ) )
        {
            player duplicate_render::update_dr_flag( localclientnum, "ballcarrier", 0 );
        }
    }
}

// Namespace ball
// Params 2
// Checksum 0xf259a730, Offset: 0x808
// Size: 0xc0
function setup_goal( localclientnum, goal )
{
    goal.origin = serverobjective_getobjectiveorigin( localclientnum, goal.objectiveid );
    goal_entity = serverobjective_getobjectiveentity( localclientnum, goal.objectiveid );
    
    if ( isdefined( goal_entity ) )
    {
        goal.origin = goal_entity.origin;
    }
    
    goal.team = serverobjective_getobjectiveteam( localclientnum, goal.objectiveid );
}

// Namespace ball
// Params 3
// Checksum 0x4a42c58c, Offset: 0x8d0
// Size: 0xc4
function setup_goal_fx( localclientnum, goal, effects )
{
    if ( isdefined( goal.base_fx ) )
    {
        stopfx( localclientnum, goal.base_fx );
    }
    
    goal.base_fx = playfx( localclientnum, effects[ goal.team ], goal.origin );
    setfxteam( localclientnum, goal.base_fx, goal.team );
}

// Namespace ball
// Params 1
// Checksum 0x4d825120, Offset: 0x9a0
// Size: 0x1ac
function setup_fx( localclientnum )
{
    effects = [];
    
    if ( shoutcaster::is_shoutcaster_using_team_identity( localclientnum ) )
    {
        if ( getdvarint( "tu11_programaticallyColoredGameFX" ) )
        {
            effects[ "allies" ] = "ui/fx_uplink_goal_marker_white";
            effects[ "axis" ] = "ui/fx_uplink_goal_marker_white";
        }
        else
        {
            effects = shoutcaster::get_color_fx( localclientnum, level.effect_scriptbundles[ "goal" ] );
        }
    }
    else
    {
        effects[ "allies" ] = "ui/fx_uplink_goal_marker";
        effects[ "axis" ] = "ui/fx_uplink_goal_marker";
    }
    
    foreach ( goal in level.goals )
    {
        thread setup_goal_fx( localclientnum, goal, effects );
        thread resetondemojump( localclientnum, goal, effects );
    }
    
    thread watch_for_team_change( localclientnum );
}

// Namespace ball
// Params 2
// Checksum 0x873549ef, Offset: 0xb58
// Size: 0x154
function play_score_fx( localclientnum, goal )
{
    effects = [];
    
    if ( shoutcaster::is_shoutcaster_using_team_identity( localclientnum ) )
    {
        if ( getdvarint( "tu11_programaticallyColoredGameFX" ) )
        {
            effects[ "allies" ] = "ui/fx_uplink_goal_marker_white_flash";
            effects[ "axis" ] = "ui/fx_uplink_goal_marker_white_flash";
        }
        else
        {
            effects = shoutcaster::get_color_fx( localclientnum, level.effect_scriptbundles[ "goal_score" ] );
        }
    }
    else
    {
        effects[ "allies" ] = "ui/fx_uplink_goal_marker_flash";
        effects[ "axis" ] = "ui/fx_uplink_goal_marker_flash";
    }
    
    fx_handle = playfx( localclientnum, effects[ goal.team ], goal.origin );
    setfxteam( localclientnum, fx_handle, goal.team );
}

// Namespace ball
// Params 6
// Checksum 0xbab27aa3, Offset: 0xcb8
// Size: 0x7c
function play_goal_score_fx( localclientnum, team, oldval, newval, binitialsnap, bwastimejump )
{
    if ( newval != oldval && !binitialsnap && !bwastimejump )
    {
        play_score_fx( localclientnum, level.goals[ team ] );
    }
}

// Namespace ball
// Params 7
// Checksum 0x1da7138, Offset: 0xd40
// Size: 0x6c
function world_ball_score_allies( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    play_goal_score_fx( localclientnum, "allies", oldval, newval, binitialsnap, bwastimejump );
}

// Namespace ball
// Params 7
// Checksum 0x86481149, Offset: 0xdb8
// Size: 0x6c
function world_ball_score_axis( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    play_goal_score_fx( localclientnum, "axis", oldval, newval, binitialsnap, bwastimejump );
}

// Namespace ball
// Params 7
// Checksum 0x93994f2, Offset: 0xe30
// Size: 0x18c
function player_ballcarrier_changed( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    localplayer = getlocalplayer( localclientnum );
    
    if ( localplayer == self )
    {
        if ( newval )
        {
            self._hasball = 1;
        }
        else
        {
            self._hasball = 0;
            setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.passOption" ), 0 );
        }
    }
    
    if ( localplayer != self && self isfriendly( localclientnum ) )
    {
        self set_player_ball_carrier_dr( localclientnum, newval );
    }
    else
    {
        self set_player_ball_carrier_dr( localclientnum, 0 );
    }
    
    if ( isdefined( level.ball_carrier ) && level.ball_carrier != self )
    {
        return;
    }
    
    level notify( #"watch_for_death" );
    
    if ( newval == 1 )
    {
        self thread watch_for_death( localclientnum );
    }
}

// Namespace ball
// Params 1
// Checksum 0x2189f755, Offset: 0xfc8
// Size: 0x23c
function set_hud( localclientnum )
{
    level.ball_carrier = self;
    
    if ( shoutcaster::is_shoutcaster( localclientnum ) )
    {
        friendly = self shoutcaster::is_friendly( localclientnum );
    }
    else
    {
        friendly = self isfriendly( localclientnum );
    }
    
    if ( isdefined( self.name ) )
    {
        setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.ballStatusText" ), self.name );
    }
    else
    {
        setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.ballStatusText" ), "" );
    }
    
    if ( isdefined( friendly ) )
    {
        setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.ballHeldByFriendly" ), friendly );
        setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.ballHeldByEnemy" ), !friendly );
        return;
    }
    
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.ballHeldByFriendly" ), 0 );
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.ballHeldByEnemy" ), 0 );
}

// Namespace ball
// Params 1
// Checksum 0x37a7e272, Offset: 0x1210
// Size: 0xec
function clear_hud( localclientnum )
{
    level.ball_carrier = undefined;
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.ballHeldByEnemy" ), 0 );
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.ballHeldByFriendly" ), 0 );
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.ballStatusText" ), &"MPUI_BALL_AWAY" );
}

// Namespace ball
// Params 1
// Checksum 0x3fffbd4f, Offset: 0x1308
// Size: 0x24
function watch_for_death( localclientnum )
{
    level endon( #"watch_for_death" );
    self waittill( #"entityshutdown" );
}

// Namespace ball
// Params 7
// Checksum 0xb9de5619, Offset: 0x1338
// Size: 0xf4
function player_passoption_changed( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    localplayer = getlocalplayer( localclientnum );
    
    if ( localplayer != self && self isfriendly( localclientnum ) )
    {
        if ( isdefined( localplayer._hasball ) && localplayer._hasball )
        {
            setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.passOption" ), newval );
        }
    }
}

// Namespace ball
// Params 7
// Checksum 0x6ebfb289, Offset: 0x1438
// Size: 0x84
function world_ball_away_changed( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "ballGametype.ballAway" ), newval );
}

// Namespace ball
// Params 2
// Checksum 0x749c276, Offset: 0x14c8
// Size: 0x3c
function set_player_ball_carrier_dr( localclientnum, on_off )
{
    self duplicate_render::update_dr_flag( localclientnum, "ballcarrier", on_off );
}

// Namespace ball
// Params 2
// Checksum 0x691c35c7, Offset: 0x1510
// Size: 0x3c
function set_player_pass_option_dr( localclientnum, on_off )
{
    self duplicate_render::update_dr_flag( localclientnum, "passoption", on_off );
}

// Namespace ball
// Params 3
// Checksum 0x4d6aeaa5, Offset: 0x1558
// Size: 0x50
function resetondemojump( localclientnum, goal, effects )
{
    for ( ;; )
    {
        level waittill( "demo_jump" + localclientnum );
        setup_goal_fx( localclientnum, goal, effects );
    }
}

// Namespace ball
// Params 1
// Checksum 0xc0b7e05a, Offset: 0x15b0
// Size: 0x4c
function watch_for_team_change( localclientnum )
{
    level notify( #"end_team_change_watch" );
    level endon( #"end_team_change_watch" );
    level waittill( #"team_changed" );
    thread setup_fx( localclientnum );
}

