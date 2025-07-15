#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace acousticsensor;

// Namespace acousticsensor
// Params 0
// Checksum 0xf92c74cf, Offset: 0x1a8
// Size: 0xb4
function init_shared()
{
    level._effect[ "acousticsensor_enemy_light" ] = "_t6/misc/fx_equip_light_red";
    level._effect[ "acousticsensor_friendly_light" ] = "_t6/misc/fx_equip_light_green";
    
    if ( !isdefined( level.acousticsensors ) )
    {
        level.acousticsensors = [];
    }
    
    if ( !isdefined( level.acousticsensorhandle ) )
    {
        level.acousticsensorhandle = 0;
    }
    
    callback::on_localclient_connect( &on_player_connect );
    callback::add_weapon_type( "acoustic_sensor", &spawned );
}

// Namespace acousticsensor
// Params 1
// Checksum 0xadac86c9, Offset: 0x268
// Size: 0x44
function on_player_connect( localclientnum )
{
    setlocalradarenabled( localclientnum, 0 );
    
    if ( localclientnum == 0 )
    {
        level thread updateacousticsensors();
    }
}

// Namespace acousticsensor
// Params 3
// Checksum 0x4bc47850, Offset: 0x2b8
// Size: 0x9e
function addacousticsensor( handle, sensorent, owner )
{
    acousticsensor = spawnstruct();
    acousticsensor.handle = handle;
    acousticsensor.sensorent = sensorent;
    acousticsensor.owner = owner;
    size = level.acousticsensors.size;
    level.acousticsensors[ size ] = acousticsensor;
}

// Namespace acousticsensor
// Params 1
// Checksum 0x1538f359, Offset: 0x360
// Size: 0x114
function removeacousticsensor( acousticsensorhandle )
{
    for ( i = 0; i < level.acousticsensors.size ; i++ )
    {
        last = level.acousticsensors.size - 1;
        
        if ( level.acousticsensors[ i ].handle == acousticsensorhandle )
        {
            level.acousticsensors[ i ].handle = level.acousticsensors[ last ].handle;
            level.acousticsensors[ i ].sensorent = level.acousticsensors[ last ].sensorent;
            level.acousticsensors[ i ].owner = level.acousticsensors[ last ].owner;
            level.acousticsensors[ last ] = undefined;
            return;
        }
    }
}

// Namespace acousticsensor
// Params 1
// Checksum 0x39bf2601, Offset: 0x480
// Size: 0xa4
function spawned( localclientnum )
{
    handle = level.acousticsensorhandle;
    level.acousticsensorhandle++;
    self thread watchshutdown( handle );
    owner = self getowner( localclientnum );
    addacousticsensor( handle, self, owner );
    util::local_players_entity_thread( self, &spawnedperclient );
}

// Namespace acousticsensor
// Params 1
// Checksum 0x121b875f, Offset: 0x530
// Size: 0x54
function spawnedperclient( localclientnum )
{
    self endon( #"entityshutdown" );
    self thread fx::blinky_light( localclientnum, "tag_light", level._effect[ "acousticsensor_friendly_light" ], level._effect[ "acousticsensor_enemy_light" ] );
}

// Namespace acousticsensor
// Params 1
// Checksum 0x5b6ad378, Offset: 0x590
// Size: 0x2c
function watchshutdown( handle )
{
    self waittill( #"entityshutdown" );
    removeacousticsensor( handle );
}

// Namespace acousticsensor
// Params 0
// Checksum 0xf132eb, Offset: 0x5c8
// Size: 0x234
function updateacousticsensors()
{
    self endon( #"entityshutdown" );
    localradarenabled = [];
    previousacousticsensorcount = -1;
    util::waitforclient( 0 );
    
    while ( true )
    {
        localplayers = level.localplayers;
        
        if ( previousacousticsensorcount != 0 || level.acousticsensors.size != 0 )
        {
            for ( i = 0; i < localplayers.size ; i++ )
            {
                localradarenabled[ i ] = 0;
            }
            
            for ( i = 0; i < level.acousticsensors.size ; i++ )
            {
                if ( isdefined( level.acousticsensors[ i ].sensorent.stunned ) && level.acousticsensors[ i ].sensorent.stunned )
                {
                    continue;
                }
                
                for ( j = 0; j < localplayers.size ; j++ )
                {
                    if ( localplayers[ j ] == level.acousticsensors[ i ].sensorent getowner( j ) )
                    {
                        localradarenabled[ j ] = 1;
                        setlocalradarposition( j, level.acousticsensors[ i ].sensorent.origin );
                    }
                }
            }
            
            for ( i = 0; i < localplayers.size ; i++ )
            {
                setlocalradarenabled( i, localradarenabled[ i ] );
            }
        }
        
        previousacousticsensorcount = level.acousticsensors.size;
        wait 0.1;
    }
}

