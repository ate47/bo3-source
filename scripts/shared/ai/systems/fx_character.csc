#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/destructible_character;
#using scripts/shared/ai/systems/gib;

#namespace fx_character;

// Namespace fx_character
// Params 0, eflags: 0x2
// Checksum 0xbea295cf, Offset: 0x168
// Size: 0x2d6
function autoexec main()
{
    fxbundles = struct::get_script_bundles( "fxcharacterdef" );
    processedfxbundles = [];
    
    foreach ( fxbundlename, fxbundle in fxbundles )
    {
        processedfxbundle = spawnstruct();
        processedfxbundle.effectcount = fxbundle.effectcount;
        processedfxbundle.fx = [];
        processedfxbundle.name = fxbundlename;
        
        for ( index = 1; index <= fxbundle.effectcount ; index++ )
        {
            fx = getstructfield( fxbundle, "effect" + index + "_fx" );
            
            if ( isdefined( fx ) )
            {
                fxstruct = spawnstruct();
                fxstruct.attachtag = getstructfield( fxbundle, "effect" + index + "_attachtag" );
                fxstruct.fx = getstructfield( fxbundle, "effect" + index + "_fx" );
                fxstruct.stopongib = fxclientutils::_gibpartnametogibflag( getstructfield( fxbundle, "effect" + index + "_stopongib" ) );
                fxstruct.stoponpiecedestroyed = getstructfield( fxbundle, "effect" + index + "_stoponpiecedestroyed" );
                processedfxbundle.fx[ processedfxbundle.fx.size ] = fxstruct;
            }
        }
        
        processedfxbundles[ fxbundlename ] = processedfxbundle;
    }
    
    level.scriptbundles[ "fxcharacterdef" ] = processedfxbundles;
}

#namespace fxclientutils;

// Namespace fxclientutils
// Params 2, eflags: 0x4
// Checksum 0xd069e952, Offset: 0x448
// Size: 0x156
function private _configentity( localclientnum, entity )
{
    if ( !isdefined( entity._fxcharacter ) )
    {
        entity._fxcharacter = [];
        handledgibs = array( 8, 16, 32, 128, 256 );
        
        foreach ( gibflag in handledgibs )
        {
            gibclientutils::addgibcallback( localclientnum, entity, gibflag, &_gibhandler );
        }
        
        for ( index = 1; index <= 20 ; index++ )
        {
            destructclientutils::adddestructpiececallback( localclientnum, entity, index, &_destructhandler );
        }
    }
}

// Namespace fxclientutils
// Params 3, eflags: 0x4
// Checksum 0xedc6aabf, Offset: 0x5a8
// Size: 0x166
function private _destructhandler( localclientnum, entity, piecenumber )
{
    if ( !isdefined( entity._fxcharacter ) )
    {
        return;
    }
    
    foreach ( fxbundlename, fxbundleinst in entity._fxcharacter )
    {
        fxbundle = struct::get_script_bundle( "fxcharacterdef", fxbundlename );
        
        for ( index = 0; index < fxbundle.fx.size ; index++ )
        {
            if ( isdefined( fxbundleinst[ index ] ) && fxbundle.fx[ index ].stoponpiecedestroyed === piecenumber )
            {
                stopfx( localclientnum, fxbundleinst[ index ] );
                fxbundleinst[ index ] = undefined;
            }
        }
    }
}

// Namespace fxclientutils
// Params 3, eflags: 0x4
// Checksum 0xa16325ff, Offset: 0x718
// Size: 0x166
function private _gibhandler( localclientnum, entity, gibflag )
{
    if ( !isdefined( entity._fxcharacter ) )
    {
        return;
    }
    
    foreach ( fxbundlename, fxbundleinst in entity._fxcharacter )
    {
        fxbundle = struct::get_script_bundle( "fxcharacterdef", fxbundlename );
        
        for ( index = 0; index < fxbundle.fx.size ; index++ )
        {
            if ( isdefined( fxbundleinst[ index ] ) && fxbundle.fx[ index ].stopongib === gibflag )
            {
                stopfx( localclientnum, fxbundleinst[ index ] );
                fxbundleinst[ index ] = undefined;
            }
        }
    }
}

// Namespace fxclientutils
// Params 1, eflags: 0x4
// Checksum 0xb67e2208, Offset: 0x888
// Size: 0x6e
function private _gibpartnametogibflag( gibpartname )
{
    if ( isdefined( gibpartname ) )
    {
        switch ( gibpartname )
        {
            case "head":
                return 8;
            case "right arm":
                return 16;
            case "left arm":
                return 32;
            default:
                return 128;
            case "left leg":
                return 256;
        }
    }
}

// Namespace fxclientutils
// Params 3, eflags: 0x4
// Checksum 0x9c83d894, Offset: 0x900
// Size: 0x4a
function private _isgibbed( localclientnum, entity, stopongibflag )
{
    if ( !isdefined( stopongibflag ) )
    {
        return 0;
    }
    
    return gibclientutils::isgibbed( localclientnum, entity, stopongibflag );
}

// Namespace fxclientutils
// Params 3, eflags: 0x4
// Checksum 0x4227efd6, Offset: 0x958
// Size: 0x4a
function private _ispiecedestructed( localclientnum, entity, stoponpiecedestroyed )
{
    if ( !isdefined( stoponpiecedestroyed ) )
    {
        return 0;
    }
    
    return destructclientutils::ispiecedestructed( localclientnum, entity, stoponpiecedestroyed );
}

// Namespace fxclientutils
// Params 3, eflags: 0x4
// Checksum 0x53bf3b0a, Offset: 0x9b0
// Size: 0x7e, Type: bool
function private _shouldplayfx( localclientnum, entity, fxstruct )
{
    if ( _isgibbed( localclientnum, entity, fxstruct.stopongib ) )
    {
        return false;
    }
    
    if ( _ispiecedestructed( localclientnum, entity, fxstruct.stoponpiecedestroyed ) )
    {
        return false;
    }
    
    return true;
}

// Namespace fxclientutils
// Params 3
// Checksum 0x72dd5148, Offset: 0xa38
// Size: 0x18e
function playfxbundle( localclientnum, entity, fxscriptbundle )
{
    if ( !isdefined( fxscriptbundle ) )
    {
        return;
    }
    
    _configentity( localclientnum, entity );
    fxbundle = struct::get_script_bundle( "fxcharacterdef", fxscriptbundle );
    
    if ( isdefined( entity._fxcharacter[ fxbundle.name ] ) )
    {
        return;
    }
    
    if ( isdefined( fxbundle ) )
    {
        playingfx = [];
        
        for ( index = 0; index < fxbundle.fx.size ; index++ )
        {
            fxstruct = fxbundle.fx[ index ];
            
            if ( _shouldplayfx( localclientnum, entity, fxstruct ) )
            {
                playingfx[ index ] = gibclientutils::_playgibfx( localclientnum, entity, fxstruct.fx, fxstruct.attachtag );
            }
        }
        
        if ( playingfx.size > 0 )
        {
            entity._fxcharacter[ fxbundle.name ] = playingfx;
        }
    }
}

// Namespace fxclientutils
// Params 2
// Checksum 0x9b874d97, Offset: 0xbd0
// Size: 0x14a
function stopallfxbundles( localclientnum, entity )
{
    _configentity( localclientnum, entity );
    fxbundlenames = [];
    
    foreach ( fxbundlename, fxbundle in entity._fxcharacter )
    {
        fxbundlenames[ fxbundlenames.size ] = fxbundlename;
    }
    
    foreach ( fxbundlename in fxbundlenames )
    {
        stopfxbundle( localclientnum, entity, fxbundlename );
    }
}

// Namespace fxclientutils
// Params 3
// Checksum 0xb0508c91, Offset: 0xd28
// Size: 0x154
function stopfxbundle( localclientnum, entity, fxscriptbundle )
{
    if ( !isdefined( fxscriptbundle ) )
    {
        return;
    }
    
    _configentity( localclientnum, entity );
    fxbundle = struct::get_script_bundle( "fxcharacterdef", fxscriptbundle );
    
    if ( isdefined( entity._fxcharacter[ fxbundle.name ] ) )
    {
        foreach ( fx in entity._fxcharacter[ fxbundle.name ] )
        {
            if ( isdefined( fx ) )
            {
                stopfx( localclientnum, fx );
            }
        }
        
        entity._fxcharacter[ fxbundle.name ] = undefined;
    }
}

