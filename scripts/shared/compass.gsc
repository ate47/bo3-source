#using scripts/codescripts/struct;

#namespace compass;

// Namespace compass
// Params 1
// Checksum 0xb5439aef, Offset: 0xc0
// Size: 0x46c
function setupminimap( material )
{
    requiredmapaspectratio = getdvarfloat( "scr_requiredMapAspectRatio" );
    corners = getentarray( "minimap_corner", "targetname" );
    
    if ( corners.size != 2 )
    {
        println( "<dev string:x28>" );
        return;
    }
    
    corner0 = ( corners[ 0 ].origin[ 0 ], corners[ 0 ].origin[ 1 ], 0 );
    corner1 = ( corners[ 1 ].origin[ 0 ], corners[ 1 ].origin[ 1 ], 0 );
    cornerdiff = corner1 - corner0;
    north = ( cos( getnorthyaw() ), sin( getnorthyaw() ), 0 );
    west = ( 0 - north[ 1 ], north[ 0 ], 0 );
    
    if ( vectordot( cornerdiff, west ) > 0 )
    {
        if ( vectordot( cornerdiff, north ) > 0 )
        {
            northwest = corner1;
            southeast = corner0;
        }
        else
        {
            side = vecscale( north, vectordot( cornerdiff, north ) );
            northwest = corner1 - side;
            southeast = corner0 + side;
        }
    }
    else if ( vectordot( cornerdiff, north ) > 0 )
    {
        side = vecscale( north, vectordot( cornerdiff, north ) );
        northwest = corner0 + side;
        southeast = corner1 - side;
    }
    else
    {
        northwest = corner0;
        southeast = corner1;
    }
    
    if ( requiredmapaspectratio > 0 )
    {
        northportion = vectordot( northwest - southeast, north );
        westportion = vectordot( northwest - southeast, west );
        mapaspectratio = westportion / northportion;
        
        if ( mapaspectratio < requiredmapaspectratio )
        {
            incr = requiredmapaspectratio / mapaspectratio;
            addvec = vecscale( west, westportion * ( incr - 1 ) * 0.5 );
        }
        else
        {
            incr = mapaspectratio / requiredmapaspectratio;
            addvec = vecscale( north, northportion * ( incr - 1 ) * 0.5 );
        }
        
        northwest += addvec;
        southeast -= addvec;
    }
    
    setminimap( material, northwest[ 0 ], northwest[ 1 ], southeast[ 0 ], southeast[ 1 ] );
}

// Namespace compass
// Params 2
// Checksum 0x9f81d54e, Offset: 0x538
// Size: 0x44
function vecscale( vec, scalar )
{
    return ( vec[ 0 ] * scalar, vec[ 1 ] * scalar, vec[ 2 ] * scalar );
}

