#using scripts/codescripts/struct;
#using scripts/mp/_shoutcaster;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/util_shared;

#namespace escort;

// Namespace escort
// Params 0
// Checksum 0x4a18a0af, Offset: 0x1e8
// Size: 0xb4
function main()
{
    clientfield::register( "actor", "robot_state", 1, 2, "int", &robot_state_changed, 0, 1 );
    clientfield::register( "actor", "escort_robot_burn", 1, 1, "int", &robot_burn, 0, 0 );
    callback::on_localclient_connect( &on_localclient_connect );
}

// Namespace escort
// Params 0
// Checksum 0x99ec1590, Offset: 0x2a8
// Size: 0x4
function onprecachegametype()
{
    
}

// Namespace escort
// Params 0
// Checksum 0x99ec1590, Offset: 0x2b8
// Size: 0x4
function onstartgametype()
{
    
}

// Namespace escort
// Params 1
// Checksum 0x203de21b, Offset: 0x2c8
// Size: 0xfc
function on_localclient_connect( localclientnum )
{
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "escortGametype.robotStatusText" ), &"MPUI_ESCORT_ROBOT_MOVING" );
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "escortGametype.robotStatusVisible" ), 0 );
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "escortGametype.enemyRobot" ), 0 );
    level wait_team_changed( localclientnum );
}

// Namespace escort
// Params 7
// Checksum 0x63df61a, Offset: 0x3d0
// Size: 0xac
function robot_burn( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self endon( #"entityshutdown" );
        self util::waittill_dobj( localclientnum );
        fxhandles = playtagfxset( localclientnum, "escort_robot_burn", self );
        self thread watch_fx_shutdown( localclientnum, fxhandles );
    }
}

// Namespace escort
// Params 2
// Checksum 0x9051c6a4, Offset: 0x488
// Size: 0xa2
function watch_fx_shutdown( localclientnum, fxhandles )
{
    wait 3;
    
    foreach ( fx in fxhandles )
    {
        stopfx( localclientnum, fx );
    }
}

// Namespace escort
// Params 7
// Checksum 0x3e883ade, Offset: 0x538
// Size: 0x16c
function robot_state_changed( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( bnewent )
    {
        if ( !isdefined( level.escortrobots ) )
        {
            level.escortrobots = [];
        }
        else if ( !isarray( level.escortrobots ) )
        {
            level.escortrobots = array( level.escortrobots );
        }
        
        level.escortrobots[ level.escortrobots.size ] = self;
        self thread update_robot_team( localclientnum );
    }
    
    if ( newval == 1 )
    {
        setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "escortGametype.robotStatusVisible" ), 1 );
        return;
    }
    
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "escortGametype.robotStatusVisible" ), 0 );
}

// Namespace escort
// Params 1
// Checksum 0x7749f2d1, Offset: 0x6b0
// Size: 0xe6
function wait_team_changed( localclientnum )
{
    while ( true )
    {
        level waittill( #"team_changed" );
        
        while ( !isdefined( getnonpredictedlocalplayer( localclientnum ) ) )
        {
            wait 0.05;
        }
        
        if ( !isdefined( level.escortrobots ) )
        {
            continue;
        }
        
        foreach ( robot in level.escortrobots )
        {
            robot thread update_robot_team( localclientnum );
        }
    }
}

// Namespace escort
// Params 1
// Checksum 0x14bf9d2f, Offset: 0x7a0
// Size: 0x174
function update_robot_team( localclientnum )
{
    localplayerteam = getlocalplayerteam( localclientnum );
    
    if ( shoutcaster::is_shoutcaster( localclientnum ) )
    {
        friend = self shoutcaster::is_friendly( localclientnum );
    }
    else
    {
        friend = self.team == localplayerteam;
    }
    
    if ( friend )
    {
        setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "escortGametype.enemyRobot" ), 0 );
    }
    else
    {
        setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "escortGametype.enemyRobot" ), 1 );
    }
    
    self duplicate_render::set_dr_flag( "enemyvehicle_fb", !friend );
    localplayer = getlocalplayer( localclientnum );
    localplayer duplicate_render::update_dr_filters( localclientnum );
}

