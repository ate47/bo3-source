#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace spectating;

// Namespace spectating
// Params 0, eflags: 0x2
// Checksum 0xa7f8e255, Offset: 0x110
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "spectating", &__init__, undefined, undefined );
}

// Namespace spectating
// Params 0
// Checksum 0x663ae2b6, Offset: 0x150
// Size: 0x24
function __init__()
{
    callback::on_start_gametype( &main );
}

// Namespace spectating
// Params 0
// Checksum 0xb3433432, Offset: 0x180
// Size: 0xbc
function main()
{
    foreach ( team in level.teams )
    {
        level.spectateoverride[ team ] = spawnstruct();
    }
    
    callback::on_connecting( &on_player_connecting );
}

// Namespace spectating
// Params 0
// Checksum 0xce59167c, Offset: 0x248
// Size: 0x64
function on_player_connecting()
{
    callback::on_joined_team( &on_joined_team );
    callback::on_spawned( &on_player_spawned );
    callback::on_joined_spectate( &on_joined_spectate );
}

// Namespace spectating
// Params 0
// Checksum 0xf208c339, Offset: 0x2b8
// Size: 0x24
function on_player_spawned()
{
    self endon( #"disconnect" );
    self setspectatepermissions();
}

// Namespace spectating
// Params 0
// Checksum 0xe6ebf1ec, Offset: 0x2e8
// Size: 0x24
function on_joined_team()
{
    self endon( #"disconnect" );
    self setspectatepermissionsformachine();
}

// Namespace spectating
// Params 0
// Checksum 0x76aa7f1a, Offset: 0x318
// Size: 0x24
function on_joined_spectate()
{
    self endon( #"disconnect" );
    self setspectatepermissionsformachine();
}

// Namespace spectating
// Params 0
// Checksum 0x8fa82224, Offset: 0x348
// Size: 0x5e
function updatespectatesettings()
{
    level endon( #"game_ended" );
    
    for ( index = 0; index < level.players.size ; index++ )
    {
        level.players[ index ] setspectatepermissions();
    }
}

// Namespace spectating
// Params 0
// Checksum 0x706e7bf1, Offset: 0x3b0
// Size: 0xce
function getsplitscreenteam()
{
    for ( index = 0; index < level.players.size ; index++ )
    {
        if ( !isdefined( level.players[ index ] ) )
        {
            continue;
        }
        
        if ( level.players[ index ] == self )
        {
            continue;
        }
        
        if ( !self isplayeronsamemachine( level.players[ index ] ) )
        {
            continue;
        }
        
        team = level.players[ index ].sessionteam;
        
        if ( team != "spectator" )
        {
            return team;
        }
    }
    
    return self.sessionteam;
}

// Namespace spectating
// Params 0
// Checksum 0x4b1ff96d, Offset: 0x488
// Size: 0xb8, Type: bool
function otherlocalplayerstillalive()
{
    for ( index = 0; index < level.players.size ; index++ )
    {
        if ( !isdefined( level.players[ index ] ) )
        {
            continue;
        }
        
        if ( level.players[ index ] == self )
        {
            continue;
        }
        
        if ( !self isplayeronsamemachine( level.players[ index ] ) )
        {
            continue;
        }
        
        if ( isalive( level.players[ index ] ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace spectating
// Params 1
// Checksum 0x434309f6, Offset: 0x548
// Size: 0x9a
function allowspectateallteams( allow )
{
    foreach ( team in level.teams )
    {
        self allowspectateteam( team, allow );
    }
}

// Namespace spectating
// Params 2
// Checksum 0x190f26bb, Offset: 0x5f0
// Size: 0xb2
function allowspectateallteamsexceptteam( skip_team, allow )
{
    foreach ( team in level.teams )
    {
        if ( team == skip_team )
        {
            continue;
        }
        
        self allowspectateteam( team, allow );
    }
}

// Namespace spectating
// Params 0
// Checksum 0xfccc78f2, Offset: 0x6b0
// Size: 0x524
function setspectatepermissions()
{
    team = self.sessionteam;
    
    if ( team == "spectator" )
    {
        if ( self issplitscreen() && !level.splitscreen )
        {
            team = getsplitscreenteam();
        }
        
        if ( team == "spectator" )
        {
            self allowspectateallteams( 1 );
            self allowspectateteam( "freelook", 0 );
            self allowspectateteam( "none", 1 );
            self allowspectateteam( "localplayers", 1 );
            return;
        }
    }
    
    spectatetype = level.spectatetype;
    
    switch ( spectatetype )
    {
        case 0:
            self allowspectateallteams( 0 );
            self allowspectateteam( "freelook", 0 );
            self allowspectateteam( "none", 1 );
            self allowspectateteam( "localplayers", 0 );
            break;
        case 3:
            if ( self issplitscreen() && self otherlocalplayerstillalive() )
            {
                self allowspectateallteams( 0 );
                self allowspectateteam( "none", 0 );
                self allowspectateteam( "freelook", 0 );
                self allowspectateteam( "localplayers", 1 );
                break;
            }
        case 1:
            if ( !level.teambased )
            {
                self allowspectateallteams( 1 );
                self allowspectateteam( "none", 1 );
                self allowspectateteam( "freelook", 0 );
                self allowspectateteam( "localplayers", 1 );
            }
            else if ( isdefined( team ) && isdefined( level.teams[ team ] ) )
            {
                self allowspectateteam( team, 1 );
                self allowspectateallteamsexceptteam( team, 0 );
                self allowspectateteam( "freelook", 0 );
                self allowspectateteam( "none", 0 );
                self allowspectateteam( "localplayers", 1 );
            }
            else
            {
                self allowspectateallteams( 0 );
                self allowspectateteam( "freelook", 0 );
                self allowspectateteam( "none", 0 );
                self allowspectateteam( "localplayers", 1 );
            }
            
            break;
        case 2:
            self allowspectateallteams( 1 );
            self allowspectateteam( "freelook", 1 );
            self allowspectateteam( "none", 1 );
            self allowspectateteam( "localplayers", 1 );
            break;
    }
    
    if ( isdefined( team ) && isdefined( level.teams[ team ] ) )
    {
        if ( isdefined( level.spectateoverride[ team ].allowfreespectate ) )
        {
            self allowspectateteam( "freelook", 1 );
        }
        
        if ( isdefined( level.spectateoverride[ team ].allowenemyspectate ) )
        {
            self allowspectateallteamsexceptteam( team, 1 );
        }
    }
}

// Namespace spectating
// Params 0
// Checksum 0xc780025d, Offset: 0xbe0
// Size: 0xde
function setspectatepermissionsformachine()
{
    self setspectatepermissions();
    
    if ( !self issplitscreen() )
    {
        return;
    }
    
    for ( index = 0; index < level.players.size ; index++ )
    {
        if ( !isdefined( level.players[ index ] ) )
        {
            continue;
        }
        
        if ( level.players[ index ] == self )
        {
            continue;
        }
        
        if ( !self isplayeronsamemachine( level.players[ index ] ) )
        {
            continue;
        }
        
        level.players[ index ] setspectatepermissions();
    }
}

