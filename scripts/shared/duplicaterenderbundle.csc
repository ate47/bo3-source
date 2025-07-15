#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/gfx_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace duplicate_render_bundle;

// Namespace duplicate_render_bundle
// Params 0, eflags: 0x2
// Checksum 0xb03b661a, Offset: 0x230
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "duplicate_render_bundle", &__init__, undefined, undefined );
}

// Namespace duplicate_render_bundle
// Params 0
// Checksum 0x4fb7160b, Offset: 0x270
// Size: 0x24
function __init__()
{
    callback::on_localplayer_spawned( &localplayer_duplicate_render_bundle_init );
}

// Namespace duplicate_render_bundle
// Params 1
// Checksum 0x5a01651d, Offset: 0x2a0
// Size: 0x1c
function localplayer_duplicate_render_bundle_init( localclientnum )
{
    init_duplicate_render_bundles();
}

// Namespace duplicate_render_bundle
// Params 0
// Checksum 0xbce53f3f, Offset: 0x2c8
// Size: 0x64
function init_duplicate_render_bundles()
{
    if ( isdefined( self.duprenderbundelsinited ) )
    {
        return;
    }
    
    self.duprenderbundelsinited = 1;
    self.playingduprenderbundle = "";
    self.forcestopduprenderbundle = 0;
    self.exitduprenderbundle = 0;
    
    /#
        self thread duprenderbundledebuglisten();
    #/
}

/#

    // Namespace duplicate_render_bundle
    // Params 0
    // Checksum 0xdf8c00cc, Offset: 0x338
    // Size: 0x1c0, Type: dev
    function duprenderbundledebuglisten()
    {
        self endon( #"entityshutdown" );
        setdvar( "<dev string:x28>", "<dev string:x49>" );
        setdvar( "<dev string:x4a>", "<dev string:x49>" );
        setdvar( "<dev string:x6b>", "<dev string:x49>" );
        
        while ( true )
        {
            playbundlename = getdvarstring( "<dev string:x28>" );
            
            if ( playbundlename != "<dev string:x49>" )
            {
                self thread playduprenderbundle( playbundlename );
                setdvar( "<dev string:x28>", "<dev string:x49>" );
            }
            
            stopbundlename = getdvarstring( "<dev string:x4a>" );
            
            if ( stopbundlename != "<dev string:x49>" )
            {
                self thread stopduprenderbundle();
                setdvar( "<dev string:x4a>", "<dev string:x49>" );
            }
            
            stopbundlename = getdvarstring( "<dev string:x6b>" );
            
            if ( stopbundlename != "<dev string:x49>" )
            {
                self thread exitduprenderbundle();
                setdvar( "<dev string:x6b>", "<dev string:x49>" );
            }
            
            wait 0.5;
        }
    }

#/

// Namespace duplicate_render_bundle
// Params 1
// Checksum 0x2cc9b982, Offset: 0x500
// Size: 0x554
function playduprenderbundle( playbundlename )
{
    self endon( #"entityshutdown" );
    init_duplicate_render_bundles();
    stopplayingduprenderbundle();
    bundle = struct::get_script_bundle( "duprenderbundle", playbundlename );
    
    if ( !isdefined( bundle ) )
    {
        println( "<dev string:x8c>" + playbundlename + "<dev string:xa6>" );
        return;
    }
    
    totalaccumtime = 0;
    filter::init_filter_indices();
    self.playingduprenderbundle = playbundlename;
    localclientnum = self.localclientnum;
    looping = 0;
    enterstage = 0;
    exitstage = 0;
    finishlooponexit = 0;
    
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
    
    for ( stageidx = 0; stageidx < num_stages && !self.forcestopduprenderbundle ; stageidx++ )
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
            finishplayingduprenderbundle( localclientnum, stageprefix + " length not defined" );
            return;
        }
        
        stagelength *= 1000;
        adddupmaterial( localclientnum, bundle, stageprefix + "fb_", 0 );
        adddupmaterial( localclientnum, bundle, stageprefix + "dupfb_", 1 );
        adddupmaterial( localclientnum, bundle, stageprefix + "sonar_", 2 );
        loopingstage = enterstage && ( !enterstage && stageidx == 0 || looping && stageidx == 1 );
        accumtime = 0;
        prevtime = self getclienttime();
        
        while ( ( loopingstage || accumtime < stagelength ) && !self.forcestopduprenderbundle )
        {
            gfx::setstage( localclientnum, bundle, undefined, stageprefix, stagelength, accumtime, totalaccumtime, &setshaderconstants );
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
                
                if ( self.exitduprenderbundle )
                {
                    loopingstage = 0;
                    
                    if ( !finishlooponexit )
                    {
                        break;
                    }
                }
            }
        }
        
        self disableduplicaterendering();
    }
    
    finishplayingduprenderbundle( localclientnum, "Finished " + playbundlename );
}

// Namespace duplicate_render_bundle
// Params 4
// Checksum 0xf41254a7, Offset: 0xa60
// Size: 0x1fc
function adddupmaterial( localclientnum, bundle, prefix, type )
{
    method = 0;
    methodstr = getstructfield( bundle, prefix + "method" );
    
    if ( isdefined( methodstr ) )
    {
        switch ( methodstr )
        {
            case "off":
                method = 0;
                break;
            case "default material":
                method = 1;
                break;
            case "custom material":
                method = 3;
                break;
            case "force custom material":
                method = 3;
                break;
            default:
                method = 2;
                break;
            case "enemy material":
                method = 4;
                break;
        }
    }
    
    materialname = getstructfield( bundle, prefix + "mc_material" );
    materialid = -1;
    
    if ( isdefined( materialname ) && materialname != "" )
    {
        materialname = "mc/" + materialname;
        materialid = filter::mapped_material_id( materialname );
        
        if ( !isdefined( materialid ) )
        {
            filter::map_material_helper_by_localclientnum( localclientnum, materialname );
            materialid = filter::mapped_material_id();
            
            if ( !isdefined( materialid ) )
            {
                materialid = -1;
            }
        }
    }
    
    self addduplicaterenderoption( type, method, materialid );
}

// Namespace duplicate_render_bundle
// Params 4
// Checksum 0x8a82312d, Offset: 0xc68
// Size: 0x6c
function setshaderconstants( localclientnum, shaderconstantname, filterid, values )
{
    self mapshaderconstant( localclientnum, 0, shaderconstantname, values[ 0 ], values[ 1 ], values[ 2 ], values[ 3 ] );
}

// Namespace duplicate_render_bundle
// Params 2
// Checksum 0x48da07de, Offset: 0xce0
// Size: 0x64
function finishplayingduprenderbundle( localclientnum, msg )
{
    /#
        if ( isdefined( msg ) )
        {
            println( msg );
        }
    #/
    
    self.forcestopduprenderbundle = 0;
    self.exitduprenderbundle = 0;
    self.playingduprenderbundle = "";
}

// Namespace duplicate_render_bundle
// Params 0
// Checksum 0x9277ac22, Offset: 0xd50
// Size: 0x2c
function stopplayingduprenderbundle()
{
    if ( self.playingduprenderbundle != "" )
    {
        stopduprenderbundle();
    }
}

// Namespace duplicate_render_bundle
// Params 0
// Checksum 0x3bd6c971, Offset: 0xd88
// Size: 0x72
function stopduprenderbundle()
{
    if ( !( isdefined( self.forcestopduprenderbundle ) && self.forcestopduprenderbundle ) && isdefined( self.playingduprenderbundle ) && self.playingduprenderbundle != "" )
    {
        self.forcestopduprenderbundle = 1;
        
        while ( self.playingduprenderbundle != "" )
        {
            wait 0.016;
            
            if ( !isdefined( self ) )
            {
                return;
            }
        }
    }
}

// Namespace duplicate_render_bundle
// Params 0
// Checksum 0x20be7a97, Offset: 0xe08
// Size: 0x48
function exitduprenderbundle()
{
    if ( !( isdefined( self.exitduprenderbundle ) && self.exitduprenderbundle ) && isdefined( self.playingduprenderbundle ) && self.playingduprenderbundle != "" )
    {
        self.exitduprenderbundle = 1;
    }
}

