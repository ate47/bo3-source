#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/duplicaterenderbundle;
#using scripts/shared/filter_shared;
#using scripts/shared/gfx_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace postfx;

// Namespace postfx
// Params 0, eflags: 0x2
// Checksum 0x228dcdfc, Offset: 0x248
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "postfx_bundle", &__init__, undefined, undefined );
}

// Namespace postfx
// Params 0
// Checksum 0xb149bfc0, Offset: 0x288
// Size: 0x24
function __init__()
{
    callback::on_localplayer_spawned( &localplayer_postfx_bundle_init );
}

// Namespace postfx
// Params 1
// Checksum 0xdc4efc84, Offset: 0x2b8
// Size: 0x1c
function localplayer_postfx_bundle_init( localclientnum )
{
    init_postfx_bundles();
}

// Namespace postfx
// Params 0
// Checksum 0x6938a182, Offset: 0x2e0
// Size: 0x64
function init_postfx_bundles()
{
    if ( isdefined( self.postfxbundelsinited ) )
    {
        return;
    }
    
    self.postfxbundelsinited = 1;
    self.playingpostfxbundle = "";
    self.forcestoppostfxbundle = 0;
    self.exitpostfxbundle = 0;
    
    /#
        self thread postfxbundledebuglisten();
    #/
}

/#

    // Namespace postfx
    // Params 0
    // Checksum 0x8d0a5480, Offset: 0x350
    // Size: 0x1c0, Type: dev
    function postfxbundledebuglisten()
    {
        self endon( #"entityshutdown" );
        setdvar( "<dev string:x28>", "<dev string:x3f>" );
        setdvar( "<dev string:x40>", "<dev string:x3f>" );
        setdvar( "<dev string:x57>", "<dev string:x3f>" );
        
        while ( true )
        {
            playbundlename = getdvarstring( "<dev string:x28>" );
            
            if ( playbundlename != "<dev string:x3f>" )
            {
                self thread playpostfxbundle( playbundlename );
                setdvar( "<dev string:x28>", "<dev string:x3f>" );
            }
            
            stopbundlename = getdvarstring( "<dev string:x40>" );
            
            if ( stopbundlename != "<dev string:x3f>" )
            {
                self thread stoppostfxbundle();
                setdvar( "<dev string:x40>", "<dev string:x3f>" );
            }
            
            stopbundlename = getdvarstring( "<dev string:x57>" );
            
            if ( stopbundlename != "<dev string:x3f>" )
            {
                self thread exitpostfxbundle();
                setdvar( "<dev string:x57>", "<dev string:x3f>" );
            }
            
            wait 0.5;
        }
    }

#/

// Namespace postfx
// Params 1
// Checksum 0x50299743, Offset: 0x518
// Size: 0x8b4
function playpostfxbundle( playbundlename )
{
    self endon( #"entityshutdown" );
    self endon( #"death" );
    init_postfx_bundles();
    stopplayingpostfxbundle();
    bundle = struct::get_script_bundle( "postfxbundle", playbundlename );
    
    if ( !isdefined( bundle ) )
    {
        println( "<dev string:x6e>" + playbundlename + "<dev string:x85>" );
        return;
    }
    
    filterid = 0;
    totalaccumtime = 0;
    filter::init_filter_indices();
    self.playingpostfxbundle = playbundlename;
    localclientnum = self.localclientnum;
    looping = 0;
    enterstage = 0;
    exitstage = 0;
    finishlooponexit = 0;
    firstpersononly = 0;
    
    if ( isdefined( bundle.looping ) )
    {
        looping = bundle.looping;
    }
    
    if ( isdefined( bundle.enterstage ) )
    {
        enterstage = bundle.enterstage;
    }
    
    if ( isdefined( bundle.exitstage ) )
    {
        exitstage = bundle.exitstage;
    }
    
    if ( isdefined( bundle.finishlooponexit ) )
    {
        finishlooponexit = bundle.finishlooponexit;
    }
    
    if ( isdefined( bundle.firstpersononly ) )
    {
        firstpersononly = bundle.firstpersononly;
    }
    
    if ( looping )
    {
        num_stages = 1;
        
        if ( enterstage )
        {
            num_stages++;
        }
        
        if ( exitstage )
        {
            num_stages++;
        }
    }
    else
    {
        num_stages = bundle.num_stages;
    }
    
    self.captureimagename = undefined;
    
    if ( isdefined( bundle.screencapture ) && bundle.screencapture )
    {
        self.captureimagename = playbundlename;
        createscenecodeimage( localclientnum, self.captureimagename );
        captureframe( localclientnum, self.captureimagename );
        setfilterpasscodetexture( localclientnum, filterid, 0, 0, self.captureimagename );
    }
    
    self thread watchentityshutdown( localclientnum, filterid );
    
    for ( stageidx = 0; stageidx < num_stages && !self.forcestoppostfxbundle ; stageidx++ )
    {
        stageprefix = "s";
        
        if ( stageidx < 10 )
        {
            stageprefix += "0";
        }
        
        stageprefix += stageidx + "_";
        stagelength = getstructfield( bundle, stageprefix + "length" );
        
        if ( !isdefined( stagelength ) )
        {
            finishplayingpostfxbundle( localclientnum, stageprefix + "length not defined", filterid );
            return;
        }
        
        stagelength *= 1000;
        stagematerial = getstructfield( bundle, stageprefix + "material" );
        
        if ( !isdefined( stagematerial ) )
        {
            finishplayingpostfxbundle( localclientnum, stageprefix + "material not defined", filterid );
            return;
        }
        
        filter::map_material_helper( self, stagematerial );
        setfilterpassmaterial( localclientnum, filterid, 0, filter::mapped_material_id( stagematerial ) );
        setfilterpassenabled( localclientnum, filterid, 0, 1, 0, firstpersononly );
        stagecapture = getstructfield( bundle, stageprefix + "screenCapture" );
        
        if ( isdefined( stagecapture ) && stagecapture )
        {
            if ( isdefined( self.captureimagename ) )
            {
                freecodeimage( localclientnum, self.captureimagename );
                self.captureimagename = undefined;
                setfilterpasscodetexture( localclientnum, filterid, 0, 0, "" );
            }
            
            self.captureimagename = stageprefix + playbundlename;
            createscenecodeimage( localclientnum, self.captureimagename );
            captureframe( localclientnum, self.captureimagename );
            setfilterpasscodetexture( localclientnum, filterid, 0, 0, self.captureimagename );
        }
        
        stagesprite = getstructfield( bundle, stageprefix + "spriteFilter" );
        
        if ( isdefined( stagesprite ) && stagesprite )
        {
            setfilterpassquads( localclientnum, filterid, 0, 2048 );
        }
        else
        {
            setfilterpassquads( localclientnum, filterid, 0, 0 );
        }
        
        thermal = getstructfield( bundle, stageprefix + "thermal" );
        enablethermaldraw( localclientnum, isdefined( thermal ) && thermal );
        loopingstage = enterstage && ( !enterstage && stageidx == 0 || looping && stageidx == 1 );
        accumtime = 0;
        prevtime = self getclienttime();
        
        while ( ( loopingstage || accumtime < stagelength ) && !self.forcestoppostfxbundle )
        {
            gfx::setstage( localclientnum, bundle, filterid, stageprefix, stagelength, accumtime, totalaccumtime, &setfilterconstants );
            wait 0.016;
            currtime = self getclienttime();
            deltatime = currtime - prevtime;
            accumtime += deltatime;
            totalaccumtime += deltatime;
            prevtime = currtime;
            
            if ( loopingstage )
            {
                while ( accumtime >= stagelength )
                {
                    accumtime -= stagelength;
                }
                
                if ( self.exitpostfxbundle )
                {
                    loopingstage = 0;
                    
                    if ( !finishlooponexit )
                    {
                        break;
                    }
                }
            }
        }
        
        setfilterpassenabled( localclientnum, filterid, 0, 0 );
    }
    
    finishplayingpostfxbundle( localclientnum, "Finished " + playbundlename, filterid );
}

// Namespace postfx
// Params 2
// Checksum 0xeecf8868, Offset: 0xdd8
// Size: 0x64
function watchentityshutdown( localclientnum, filterid )
{
    self util::waittill_any( "entityshutdown", "death", "finished_playing_postfx_bundle" );
    finishplayingpostfxbundle( localclientnum, "Entity Shutdown", filterid );
}

// Namespace postfx
// Params 4
// Checksum 0xc9879422, Offset: 0xe48
// Size: 0x104
function setfilterconstants( localclientnum, shaderconstantname, filterid, values )
{
    baseshaderconstindex = gfx::getshaderconstantindex( shaderconstantname );
    setfilterpassconstant( localclientnum, filterid, 0, baseshaderconstindex + 0, values[ 0 ] );
    setfilterpassconstant( localclientnum, filterid, 0, baseshaderconstindex + 1, values[ 1 ] );
    setfilterpassconstant( localclientnum, filterid, 0, baseshaderconstindex + 2, values[ 2 ] );
    setfilterpassconstant( localclientnum, filterid, 0, baseshaderconstindex + 3, values[ 3 ] );
}

// Namespace postfx
// Params 3
// Checksum 0x4d9b9b49, Offset: 0xf58
// Size: 0x12e
function finishplayingpostfxbundle( localclientnum, msg, filterid )
{
    /#
        if ( isdefined( msg ) )
        {
            println( msg );
        }
    #/
    
    if ( isdefined( self ) )
    {
        self notify( #"finished_playing_postfx_bundle" );
        self.forcestoppostfxbundle = 0;
        self.exitpostfxbundle = 0;
        self.playingpostfxbundle = "";
    }
    
    setfilterpassquads( localclientnum, filterid, 0, 0 );
    setfilterpassenabled( localclientnum, filterid, 0, 0 );
    enablethermaldraw( localclientnum, 0 );
    
    if ( isdefined( self.captureimagename ) )
    {
        setfilterpasscodetexture( localclientnum, filterid, 0, 0, "" );
        freecodeimage( localclientnum, self.captureimagename );
        self.captureimagename = undefined;
    }
}

// Namespace postfx
// Params 0
// Checksum 0x83107ac0, Offset: 0x1090
// Size: 0x2c
function stopplayingpostfxbundle()
{
    if ( self.playingpostfxbundle != "" )
    {
        stoppostfxbundle();
    }
}

// Namespace postfx
// Params 0
// Checksum 0xa81d07ee, Offset: 0x10c8
// Size: 0x76
function stoppostfxbundle()
{
    self notify( #"stoppostfxbundle_singleton" );
    self endon( #"stoppostfxbundle_singleton" );
    
    if ( isdefined( self.playingpostfxbundle ) && self.playingpostfxbundle != "" )
    {
        self.forcestoppostfxbundle = 1;
        
        while ( self.playingpostfxbundle != "" )
        {
            wait 0.016;
            
            if ( !isdefined( self ) )
            {
                return;
            }
        }
    }
}

// Namespace postfx
// Params 0
// Checksum 0xc55314bb, Offset: 0x1148
// Size: 0x48
function exitpostfxbundle()
{
    if ( !( isdefined( self.exitpostfxbundle ) && self.exitpostfxbundle ) && isdefined( self.playingpostfxbundle ) && self.playingpostfxbundle != "" )
    {
        self.exitpostfxbundle = 1;
    }
}

// Namespace postfx
// Params 3
// Checksum 0x910f2a31, Offset: 0x1198
// Size: 0x124
function setfrontendstreamingoverlay( localclientnum, system, enabled )
{
    if ( !isdefined( self.overlayclients ) )
    {
        self.overlayclients = [];
    }
    
    if ( !isdefined( self.overlayclients[ localclientnum ] ) )
    {
        self.overlayclients[ localclientnum ] = [];
    }
    
    self.overlayclients[ localclientnum ][ system ] = enabled;
    
    foreach ( en in self.overlayclients[ localclientnum ] )
    {
        if ( en )
        {
            enablefrontendstreamingoverlay( localclientnum, 1 );
            return;
        }
    }
    
    enablefrontendstreamingoverlay( localclientnum, 0 );
}

