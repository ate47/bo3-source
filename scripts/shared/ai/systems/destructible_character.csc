#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/clientfield_shared;

#namespace destructible_character;

// Namespace destructible_character
// Params 0, eflags: 0x2
// Checksum 0xd7c6f9f5, Offset: 0x198
// Size: 0x3e6
function autoexec main()
{
    clientfield::register( "actor", "destructible_character_state", 1, 21, "int", &destructclientutils::_destructhandler, 0, 0 );
    destructibles = struct::get_script_bundles( "destructiblecharacterdef" );
    processedbundles = [];
    
    foreach ( destructiblename, destructible in destructibles )
    {
        destructbundle = spawnstruct();
        destructbundle.piececount = destructible.piececount;
        destructbundle.pieces = [];
        destructbundle.name = destructiblename;
        
        for ( index = 1; index <= destructbundle.piececount ; index++ )
        {
            piecestruct = spawnstruct();
            piecestruct.gibmodel = getstructfield( destructible, "piece" + index + "_gibmodel" );
            piecestruct.gibtag = getstructfield( destructible, "piece" + index + "_gibtag" );
            piecestruct.gibfx = getstructfield( destructible, "piece" + index + "_gibfx" );
            piecestruct.gibfxtag = getstructfield( destructible, "piece" + index + "_gibeffecttag" );
            piecestruct.gibdynentfx = getstructfield( destructible, "piece" + index + "_gibdynentfx" );
            piecestruct.gibsound = getstructfield( destructible, "piece" + index + "_gibsound" );
            piecestruct.hitlocation = getstructfield( destructible, "piece" + index + "_hitlocation" );
            piecestruct.hidetag = getstructfield( destructible, "piece" + index + "_hidetag" );
            piecestruct.detachmodel = getstructfield( destructible, "piece" + index + "_detachmodel" );
            destructbundle.pieces[ destructbundle.pieces.size ] = piecestruct;
        }
        
        processedbundles[ destructiblename ] = destructbundle;
    }
    
    level.scriptbundles[ "destructiblecharacterdef" ] = processedbundles;
}

#namespace destructclientutils;

// Namespace destructclientutils
// Params 7, eflags: 0x4
// Checksum 0xacfac1d4, Offset: 0x588
// Size: 0x138
function private _destructhandler( localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump )
{
    entity = self;
    destructflags = oldvalue ^ newvalue;
    shouldspawngibs = newvalue & 1;
    
    if ( bnewent )
    {
        destructflags = 0 ^ newvalue;
    }
    
    if ( !isdefined( entity.destructibledef ) )
    {
        return;
    }
    
    currentdestructflag = 2;
    
    for ( piecenumber = 1; destructflags >= currentdestructflag ; piecenumber++ )
    {
        if ( destructflags & currentdestructflag )
        {
            _destructpiece( localclientnum, entity, piecenumber, shouldspawngibs );
        }
        
        currentdestructflag <<= 1;
    }
    
    entity._destruct_state = newvalue;
}

// Namespace destructclientutils
// Params 4, eflags: 0x4
// Checksum 0x521f25b2, Offset: 0x6c8
// Size: 0x164
function private _destructpiece( localclientnum, entity, piecenumber, shouldspawngibs )
{
    if ( !isdefined( entity.destructibledef ) )
    {
        return;
    }
    
    destructbundle = struct::get_script_bundle( "destructiblecharacterdef", entity.destructibledef );
    piece = destructbundle.pieces[ piecenumber - 1 ];
    
    if ( isdefined( piece ) )
    {
        if ( shouldspawngibs )
        {
            gibclientutils::_playgibfx( localclientnum, entity, piece.gibfx, piece.gibfxtag );
            entity thread gibclientutils::_gibpiece( localclientnum, entity, piece.gibmodel, piece.gibtag, piece.gibdynentfx );
            gibclientutils::_playgibsound( localclientnum, entity, piece.gibsound );
        }
        
        _handledestructcallbacks( localclientnum, entity, piecenumber );
    }
}

// Namespace destructclientutils
// Params 2, eflags: 0x4
// Checksum 0x557f08af, Offset: 0x838
// Size: 0x3a
function private _getdestructstate( localclientnum, entity )
{
    if ( isdefined( entity._destruct_state ) )
    {
        return entity._destruct_state;
    }
    
    return 0;
}

// Namespace destructclientutils
// Params 3, eflags: 0x4
// Checksum 0xe0d458c6, Offset: 0x880
// Size: 0xf4
function private _handledestructcallbacks( localclientnum, entity, piecenumber )
{
    if ( isdefined( entity._destructcallbacks ) && isdefined( entity._destructcallbacks[ piecenumber ] ) )
    {
        foreach ( callback in entity._destructcallbacks[ piecenumber ] )
        {
            if ( isfunctionptr( callback ) )
            {
                [[ callback ]]( localclientnum, entity, piecenumber );
            }
        }
    }
}

// Namespace destructclientutils
// Params 4
// Checksum 0xb1c157a2, Offset: 0x980
// Size: 0xf6
function adddestructpiececallback( localclientnum, entity, piecenumber, callbackfunction )
{
    assert( isfunctionptr( callbackfunction ) );
    
    if ( !isdefined( entity._destructcallbacks ) )
    {
        entity._destructcallbacks = [];
    }
    
    if ( !isdefined( entity._destructcallbacks[ piecenumber ] ) )
    {
        entity._destructcallbacks[ piecenumber ] = [];
    }
    
    destructcallbacks = entity._destructcallbacks[ piecenumber ];
    destructcallbacks[ destructcallbacks.size ] = callbackfunction;
    entity._destructcallbacks[ piecenumber ] = destructcallbacks;
}

// Namespace destructclientutils
// Params 3
// Checksum 0x50f61d1f, Offset: 0xa80
// Size: 0x3e
function ispiecedestructed( localclientnum, entity, piecenumber )
{
    return _getdestructstate( localclientnum, entity ) & 1 << piecenumber;
}

