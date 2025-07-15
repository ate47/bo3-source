#using scripts/shared/ai/archetype_utility;

#namespace animationstatenetworkutility;

// Namespace animationstatenetworkutility
// Params 2
// Checksum 0x435607bf, Offset: 0xc0
// Size: 0x4c
function requeststate( entity, statename )
{
    assert( isdefined( entity ) );
    entity asmrequestsubstate( statename );
}

// Namespace animationstatenetworkutility
// Params 2
// Checksum 0xbe537519, Offset: 0x118
// Size: 0x84
function searchanimationmap( entity, aliasname )
{
    if ( isdefined( entity ) && isdefined( aliasname ) )
    {
        animationname = entity animmappingsearch( istring( aliasname ) );
        
        if ( isdefined( animationname ) )
        {
            return findanimbyname( "generic", animationname );
        }
    }
}

