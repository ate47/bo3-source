#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace mpdialog;

// Namespace mpdialog
// Params 0, eflags: 0x2
// Checksum 0xc1ad19b3, Offset: 0x2e8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "mpdialog", &__init__, undefined, undefined );
}

// Namespace mpdialog
// Params 0
// Checksum 0x2d1f01b2, Offset: 0x328
// Size: 0x1cc
function __init__()
{
    level.mpboostresponse = [];
    level.mpboostresponse[ "assassin" ] = "Spectre";
    level.mpboostresponse[ "grenadier" ] = "Grenadier";
    level.mpboostresponse[ "outrider" ] = "Outrider";
    level.mpboostresponse[ "prophet" ] = "Technomancer";
    level.mpboostresponse[ "pyro" ] = "Firebreak";
    level.mpboostresponse[ "reaper" ] = "Reaper";
    level.mpboostresponse[ "ruin" ] = "Mercenary";
    level.mpboostresponse[ "seraph" ] = "Enforcer";
    level.mpboostresponse[ "trapper" ] = "Trapper";
    level.mpboostresponse[ "blackjack" ] = "Blackjack";
    level.clientvoicesetup = &client_voice_setup;
    clientfield::register( "world", "boost_number", 1, 2, "int", &set_boost_number, 1, 1 );
    clientfield::register( "allplayers", "play_boost", 1, 2, "int", &play_boost_vox, 1, 0 );
}

// Namespace mpdialog
// Params 1
// Checksum 0x74848ae9, Offset: 0x500
// Size: 0x84
function client_voice_setup( localclientnum )
{
    self thread snipervonotify( localclientnum, "playerbreathinsound", "exertSniperHold" );
    self thread snipervonotify( localclientnum, "playerbreathoutsound", "exertSniperExhale" );
    self thread snipervonotify( localclientnum, "playerbreathgaspsound", "exertSniperGasp" );
}

// Namespace mpdialog
// Params 3
// Checksum 0x548a283a, Offset: 0x590
// Size: 0x98
function snipervonotify( localclientnum, notifystring, dialogkey )
{
    self endon( #"entityshutdown" );
    
    for ( ;; )
    {
        self waittill( notifystring );
        
        if ( isunderwater( localclientnum ) )
        {
            return;
        }
        
        dialogalias = self get_player_dialog_alias( dialogkey );
        
        if ( isdefined( dialogalias ) )
        {
            self playsound( 0, dialogalias );
        }
    }
}

// Namespace mpdialog
// Params 7
// Checksum 0x582f1f46, Offset: 0x630
// Size: 0x48
function set_boost_number( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    level.boostnumber = newval;
}

// Namespace mpdialog
// Params 7
// Checksum 0x1aa080fc, Offset: 0x680
// Size: 0x13c
function play_boost_vox( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    localplayerteam = getlocalplayerteam( localclientnum );
    entitynumber = self getentitynumber();
    
    if ( newval == 0 || self.team != localplayerteam || level._sndnextsnapshot != "mpl_prematch" || level.booststartentnum === entitynumber || level.boostresponseentnum === entitynumber )
    {
        return;
    }
    
    if ( newval == 1 )
    {
        level.booststartentnum = entitynumber;
        self thread play_boost_start_vox( localclientnum );
        return;
    }
    
    if ( newval == 2 )
    {
        level.boostresponseentnum = entitynumber;
        self thread play_boost_start_response_vox( localclientnum );
    }
}

// Namespace mpdialog
// Params 1
// Checksum 0xa19f1a19, Offset: 0x7c8
// Size: 0x134
function play_boost_start_vox( localclientnum )
{
    self endon( #"entityshutdown" );
    self endon( #"death" );
    wait 2;
    playbackid = self play_dialog( "boostStart" + level.boostnumber, localclientnum );
    
    if ( isdefined( playbackid ) && playbackid >= 0 )
    {
        while ( soundplaying( playbackid ) )
        {
            wait 0.05;
        }
    }
    
    wait 0.5;
    level.booststartresponse = "boostStartResp" + level.mpboostresponse[ self getmpdialogname() ] + level.boostnumber;
    
    if ( isdefined( level.boostresponseentnum ) )
    {
        responder = getentbynum( localclientnum, level.boostresponseentnum );
        
        if ( isdefined( responder ) )
        {
            responder thread play_boost_start_response_vox( localclientnum );
        }
    }
}

// Namespace mpdialog
// Params 1
// Checksum 0x70c160f3, Offset: 0x908
// Size: 0x7c
function play_boost_start_response_vox( localclientnum )
{
    self endon( #"entityshutdown" );
    self endon( #"death" );
    
    if ( !isdefined( level.booststartresponse ) || self.team != getlocalplayerteam( localclientnum ) )
    {
        return;
    }
    
    self play_dialog( level.booststartresponse, localclientnum );
}

// Namespace mpdialog
// Params 2
// Checksum 0x1dc713f, Offset: 0x990
// Size: 0x62
function get_commander_dialog_alias( commandername, dialogkey )
{
    if ( !isdefined( commandername ) )
    {
        return;
    }
    
    commanderbundle = struct::get_script_bundle( "mpdialog_commander", commandername );
    return get_dialog_bundle_alias( commanderbundle, dialogkey );
}

// Namespace mpdialog
// Params 1
// Checksum 0x643779e4, Offset: 0xa00
// Size: 0x82
function get_player_dialog_alias( dialogkey )
{
    bundlename = self getmpdialogname();
    
    if ( !isdefined( bundlename ) )
    {
        return undefined;
    }
    
    playerbundle = struct::get_script_bundle( "mpdialog_player", bundlename );
    return get_dialog_bundle_alias( playerbundle, dialogkey );
}

// Namespace mpdialog
// Params 2
// Checksum 0xab17a4eb, Offset: 0xa90
// Size: 0xae
function get_dialog_bundle_alias( dialogbundle, dialogkey )
{
    if ( !isdefined( dialogbundle ) || !isdefined( dialogkey ) )
    {
        return undefined;
    }
    
    dialogalias = getstructfield( dialogbundle, dialogkey );
    
    if ( !isdefined( dialogalias ) )
    {
        return;
    }
    
    voiceprefix = getstructfield( dialogbundle, "voiceprefix" );
    
    if ( isdefined( voiceprefix ) )
    {
        dialogalias = voiceprefix + dialogalias;
    }
    
    return dialogalias;
}

// Namespace mpdialog
// Params 2
// Checksum 0xbb5246cf, Offset: 0xb48
// Size: 0x162
function play_dialog( dialogkey, localclientnum )
{
    if ( !isdefined( dialogkey ) || !isdefined( localclientnum ) )
    {
        return -1;
    }
    
    dialogalias = self get_player_dialog_alias( dialogkey );
    
    if ( !isdefined( dialogalias ) )
    {
        return -1;
    }
    
    soundpos = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 60 );
    
    if ( !isspectating( localclientnum ) )
    {
        return self playsound( undefined, dialogalias, soundpos );
    }
    
    voicebox = spawn( localclientnum, self.origin, "script_model" );
    self thread update_voice_origin( voicebox );
    voicebox thread delete_after( 10 );
    return voicebox playsound( undefined, dialogalias, soundpos );
}

// Namespace mpdialog
// Params 1
// Checksum 0x7a9dc328, Offset: 0xcb8
// Size: 0x4c
function update_voice_origin( voicebox )
{
    while ( true )
    {
        wait 0.1;
        
        if ( !isdefined( self ) || !isdefined( voicebox ) )
        {
            return;
        }
        
        voicebox.origin = self.origin;
    }
}

// Namespace mpdialog
// Params 1
// Checksum 0x5fe5d4b8, Offset: 0xd10
// Size: 0x24
function delete_after( waittime )
{
    wait waittime;
    self delete();
}

