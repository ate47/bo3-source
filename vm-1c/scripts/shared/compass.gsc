#using scripts/codescripts/struct;

#namespace compass;

// Namespace compass
// Params 1, eflags: 0x1 linked
// namespace_b11c18b7<file_0>::function_a471e46d
// Checksum 0xb5439aef, Offset: 0xc0
// Size: 0x46c
function setupminimap(material) {
    requiredmapaspectratio = getdvarfloat("scr_requiredMapAspectRatio");
    corners = getentarray("minimap_corner", "targetname");
    if (corners.size != 2) {
        println("<unknown string>");
        return;
    }
    corner0 = (corners[0].origin[0], corners[0].origin[1], 0);
    corner1 = (corners[1].origin[0], corners[1].origin[1], 0);
    cornerdiff = corner1 - corner0;
    north = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
    west = (0 - north[1], north[0], 0);
    if (vectordot(cornerdiff, west) > 0) {
        if (vectordot(cornerdiff, north) > 0) {
            northwest = corner1;
            southeast = corner0;
        } else {
            side = vecscale(north, vectordot(cornerdiff, north));
            northwest = corner1 - side;
            southeast = corner0 + side;
        }
    } else if (vectordot(cornerdiff, north) > 0) {
        side = vecscale(north, vectordot(cornerdiff, north));
        northwest = corner0 + side;
        southeast = corner1 - side;
    } else {
        northwest = corner0;
        southeast = corner1;
    }
    if (requiredmapaspectratio > 0) {
        var_64e59deb = vectordot(northwest - southeast, north);
        var_96a8ca85 = vectordot(northwest - southeast, west);
        mapaspectratio = var_96a8ca85 / var_64e59deb;
        if (mapaspectratio < requiredmapaspectratio) {
            incr = requiredmapaspectratio / mapaspectratio;
            addvec = vecscale(west, var_96a8ca85 * (incr - 1) * 0.5);
        } else {
            incr = mapaspectratio / requiredmapaspectratio;
            addvec = vecscale(north, var_64e59deb * (incr - 1) * 0.5);
        }
        northwest += addvec;
        southeast -= addvec;
    }
    setminimap(material, northwest[0], northwest[1], southeast[0], southeast[1]);
}

// Namespace compass
// Params 2, eflags: 0x1 linked
// namespace_b11c18b7<file_0>::function_854418c9
// Checksum 0x9f81d54e, Offset: 0x538
// Size: 0x44
function vecscale(vec, scalar) {
    return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
}

