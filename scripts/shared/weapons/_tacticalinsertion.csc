#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace tacticalinsertion;

// Namespace tacticalinsertion
// Params 0
// Checksum 0x89ff87cc, Offset: 0x1f8
// Size: 0x1f4
function init_shared()
{
    level._effect[ "tacticalInsertionFriendly" ] = "_t6/misc/fx_equip_tac_insert_light_grn";
    level._effect[ "tacticalInsertionEnemy" ] = "_t6/misc/fx_equip_tac_insert_light_red";
    clientfield::register( "scriptmover", "tacticalinsertion", 1, 1, "int", &spawned, 0, 0 );
    latlongstruct = struct::get( "lat_long", "targetname" );
    
    if ( isdefined( latlongstruct ) )
    {
        mapx = latlongstruct.origin[ 0 ];
        mapy = latlongstruct.origin[ 1 ];
        lat = latlongstruct.script_vector[ 0 ];
        long = latlongstruct.script_vector[ 1 ];
    }
    else
    {
        if ( isdefined( level.worldmapx ) && isdefined( level.worldmapy ) )
        {
            mapx = level.worldmapx;
            mapy = level.worldmapy;
        }
        else
        {
            mapx = 0;
            mapy = 0;
        }
        
        if ( isdefined( level.worldlat ) && isdefined( level.worldlong ) )
        {
            lat = level.worldlat;
            long = level.worldlong;
        }
        else
        {
            lat = 34.0216;
            long = -118.449;
        }
    }
    
    setmaplatlong( mapx, mapy, long, lat );
}

// Namespace tacticalinsertion
// Params 7
// Checksum 0xd1b26e43, Offset: 0x3f8
// Size: 0x5c
function spawned( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !newval )
    {
        return;
    }
    
    self thread checkforplayerswitch( localclientnum );
}

// Namespace tacticalinsertion
// Params 1
// Checksum 0x6c028cad, Offset: 0x460
// Size: 0x11c
function playflarefx( localclientnum )
{
    self endon( #"entityshutdown" );
    level endon( #"player_switch" );
    
    if ( util::friend_not_foe( localclientnum ) )
    {
        self.tacticalinsertionfx = playfxontag( localclientnum, level._effect[ "tacticalInsertionFriendly" ], self, "tag_flash" );
    }
    else
    {
        self.tacticalinsertionfx = playfxontag( localclientnum, level._effect[ "tacticalInsertionEnemy" ], self, "tag_flash" );
    }
    
    self thread watchtacinsertshutdown( localclientnum, self.tacticalinsertionfx );
    looporigin = self.origin;
    audio::playloopat( "fly_tinsert_beep", looporigin );
    self thread stopflareloopwatcher( looporigin );
}

// Namespace tacticalinsertion
// Params 2
// Checksum 0x346141d1, Offset: 0x588
// Size: 0x3c
function watchtacinsertshutdown( localclientnum, fxhandle )
{
    self waittill( #"entityshutdown" );
    stopfx( localclientnum, fxhandle );
}

// Namespace tacticalinsertion
// Params 1
// Checksum 0x63cef46e, Offset: 0x5d0
// Size: 0x5c
function stopflareloopwatcher( looporigin )
{
    while ( true )
    {
        if ( !isdefined( self ) || !isdefined( self.tacticalinsertionfx ) )
        {
            audio::stoploopat( "fly_tinsert_beep", looporigin );
            break;
        }
        
        wait 0.5;
    }
}

// Namespace tacticalinsertion
// Params 1
// Checksum 0x2cf0f956, Offset: 0x638
// Size: 0x64
function checkforplayerswitch( localclientnum )
{
    self endon( #"entityshutdown" );
    
    while ( true )
    {
        level waittill( #"player_switch" );
        
        if ( isdefined( self.tacticalinsertionfx ) )
        {
            stopfx( localclientnum, self.tacticalinsertionfx );
            self.tacticalinsertionfx = undefined;
        }
        
        waittillframeend();
    }
}

