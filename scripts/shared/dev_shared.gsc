#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/math_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace dev;

/#

    // Namespace dev
    // Params 5, eflags: 0x1 linked
    // Checksum 0x6a755d42, Offset: 0x150
    // Size: 0xcc
    function debug_sphere(origin, radius, color, alpha, time) {
        if (!isdefined(time)) {
            time = 1000;
        }
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        sides = int(10 * (1 + int(radius) % 100));
        sphere(origin, radius, color, alpha, 1, sides, time);
    }

    // Namespace dev
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9cb49404, Offset: 0x228
    // Size: 0xb1c
    function updateminimapsetting() {
        requiredmapaspectratio = getdvarfloat("<unknown string>");
        if (!isdefined(level.minimapheight)) {
            setdvar("<unknown string>", "<unknown string>");
            level.minimapheight = 0;
        }
        minimapheight = getdvarfloat("<unknown string>");
        if (minimapheight != level.minimapheight) {
            if (minimapheight <= 0) {
                util::gethostplayer() cameraactivate(0);
                level.minimapheight = minimapheight;
                level notify(#"end_draw_map_bounds");
            }
            if (minimapheight > 0) {
                level.minimapheight = minimapheight;
                players = getplayers();
                if (players.size > 0) {
                    player = util::gethostplayer();
                    corners = getentarray("<unknown string>", "<unknown string>");
                    if (corners.size == 2) {
                        viewpos = corners[0].origin + corners[1].origin;
                        viewpos = (viewpos[0] * 0.5, viewpos[1] * 0.5, viewpos[2] * 0.5);
                        level thread minimapwarn(corners);
                        maxcorner = (corners[0].origin[0], corners[0].origin[1], viewpos[2]);
                        mincorner = (corners[0].origin[0], corners[0].origin[1], viewpos[2]);
                        if (corners[1].origin[0] > corners[0].origin[0]) {
                            maxcorner = (corners[1].origin[0], maxcorner[1], maxcorner[2]);
                        } else {
                            mincorner = (corners[1].origin[0], mincorner[1], mincorner[2]);
                        }
                        if (corners[1].origin[1] > corners[0].origin[1]) {
                            maxcorner = (maxcorner[0], corners[1].origin[1], maxcorner[2]);
                        } else {
                            mincorner = (mincorner[0], corners[1].origin[1], mincorner[2]);
                        }
                        viewpostocorner = maxcorner - viewpos;
                        viewpos = (viewpos[0], viewpos[1], viewpos[2] + minimapheight);
                        northvector = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
                        eastvector = (northvector[1], 0 - northvector[0], 0);
                        disttotop = vectordot(northvector, viewpostocorner);
                        if (disttotop < 0) {
                            disttotop = 0 - disttotop;
                        }
                        disttoside = vectordot(eastvector, viewpostocorner);
                        if (disttoside < 0) {
                            disttoside = 0 - disttoside;
                        }
                        if (requiredmapaspectratio > 0) {
                            mapaspectratio = disttoside / disttotop;
                            if (mapaspectratio < requiredmapaspectratio) {
                                incr = requiredmapaspectratio / mapaspectratio;
                                disttoside *= incr;
                                addvec = vecscale(eastvector, vectordot(eastvector, maxcorner - viewpos) * (incr - 1));
                                mincorner -= addvec;
                                maxcorner += addvec;
                            } else {
                                incr = mapaspectratio / requiredmapaspectratio;
                                disttotop *= incr;
                                addvec = vecscale(northvector, vectordot(northvector, maxcorner - viewpos) * (incr - 1));
                                mincorner -= addvec;
                                maxcorner += addvec;
                            }
                        }
                        if (level.console) {
                            aspectratioguess = 1.77778;
                            angleside = 2 * atan(disttoside * 0.8 / minimapheight);
                            angletop = 2 * atan(disttotop * aspectratioguess * 0.8 / minimapheight);
                        } else {
                            aspectratioguess = 1.33333;
                            angleside = 2 * atan(disttoside / minimapheight);
                            angletop = 2 * atan(disttotop * aspectratioguess / minimapheight);
                        }
                        if (angleside > angletop) {
                            angle = angleside;
                        } else {
                            angle = angletop;
                        }
                        znear = minimapheight - 1000;
                        if (znear < 16) {
                            znear = 16;
                        }
                        if (znear > 10000) {
                            znear = 10000;
                        }
                        player camerasetposition(viewpos, (90, getnorthyaw(), 0));
                        player cameraactivate(1);
                        player takeallweapons();
                        setdvar("<unknown string>", 0);
                        setdvar("<unknown string>", 0);
                        setdvar("<unknown string>", 0);
                        setdvar("<unknown string>", 0);
                        setdvar("<unknown string>", 0);
                        setdvar("<unknown string>", 0);
                        setdvar("<unknown string>", znear);
                        setdvar("<unknown string>", 0.1);
                        setdvar("<unknown string>", 0);
                        setdvar("<unknown string>", 1);
                        setdvar("<unknown string>", 90);
                        setdvar("<unknown string>", 0);
                        setdvar("<unknown string>", 1);
                        setdvar("<unknown string>", 1);
                        setdvar("<unknown string>", 0);
                        setdvar("<unknown string>", 0);
                        setdvar("<unknown string>", "<unknown string>");
                        if (isdefined(level.objpoints)) {
                            for (i = 0; i < level.objpointnames.size; i++) {
                                if (isdefined(level.objpoints[level.objpointnames[i]])) {
                                    level.objpoints[level.objpointnames[i]] destroy();
                                }
                            }
                            level.objpoints = [];
                            level.objpointnames = [];
                        }
                        thread drawminimapbounds(viewpos, mincorner, maxcorner);
                    } else {
                        println("<unknown string>");
                    }
                    return;
                }
                setdvar("<unknown string>", "<unknown string>");
            }
        }
    }

    // Namespace dev
    // Params 2, eflags: 0x1 linked
    // Checksum 0x301d0c37, Offset: 0xd50
    // Size: 0x4a
    function vecscale(vec, scalar) {
        return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
    }

    // Namespace dev
    // Params 3, eflags: 0x1 linked
    // Checksum 0x6b765295, Offset: 0xda8
    // Size: 0x3c0
    function drawminimapbounds(viewpos, mincorner, maxcorner) {
        level notify(#"end_draw_map_bounds");
        level endon(#"end_draw_map_bounds");
        viewheight = viewpos[2] - maxcorner[2];
        north = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
        diaglen = length(mincorner - maxcorner);
        mincorneroffset = mincorner - viewpos;
        mincorneroffset = vectornormalize((mincorneroffset[0], mincorneroffset[1], 0));
        mincorner += vecscale(mincorneroffset, diaglen * 1 / 800);
        maxcorneroffset = maxcorner - viewpos;
        maxcorneroffset = vectornormalize((maxcorneroffset[0], maxcorneroffset[1], 0));
        maxcorner += vecscale(maxcorneroffset, diaglen * 1 / 800);
        diagonal = maxcorner - mincorner;
        side = vecscale(north, vectordot(diagonal, north));
        sidenorth = vecscale(north, abs(vectordot(diagonal, north)));
        corner0 = mincorner;
        corner1 = mincorner + side;
        corner2 = maxcorner;
        corner3 = maxcorner - side;
        toppos = vecscale(mincorner + maxcorner, 0.5) + vecscale(sidenorth, 0.51);
        textscale = diaglen * 0.003;
        while (true) {
            line(corner0, corner1);
            line(corner1, corner2);
            line(corner2, corner3);
            line(corner3, corner0);
            print3d(toppos, "<unknown string>", (1, 1, 1), 1, textscale);
            wait(0.05);
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3abd2d34, Offset: 0x1170
    // Size: 0x1e6
    function minimapwarn(corners) {
        threshold = 10;
        width = abs(corners[0].origin[0] - corners[1].origin[0]);
        width = int(width);
        height = abs(corners[0].origin[1] - corners[1].origin[1]);
        height = int(height);
        if (abs(width - height) > threshold) {
            for (;;) {
                iprintln("<unknown string>" + width + "<unknown string>" + height + "<unknown string>");
                if (height > width) {
                    scale = height / width;
                    iprintln("<unknown string>" + scale + "<unknown string>");
                } else {
                    scale = width / height;
                    iprintln("<unknown string>" + scale + "<unknown string>");
                }
                wait(10);
            }
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // Checksum 0xf87efa4f, Offset: 0x1360
    // Size: 0xaa
    function function_dfab5e4f(var_9a65c47f) {
        foreach (player in getplayers()) {
            player setcharacterhelmetstyle(var_9a65c47f);
        }
    }

    // Namespace dev
    // Params 2, eflags: 0x1 linked
    // Checksum 0x22469cfd, Offset: 0x1418
    // Size: 0xca
    function function_5fcfe5a4(character_index, body_index) {
        foreach (player in getplayers()) {
            player setcharacterbodytype(character_index);
            player setcharacterbodystyle(body_index);
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // Checksum 0xcaeb5420, Offset: 0x14f0
    // Size: 0x21e
    function body_customization_process_command(character_index) {
        split = strtok(character_index, "<unknown string>");
        switch (split.size) {
        case 1:
        default:
            command0 = strtok(split[0], "<unknown string>");
            character_index = int(command0[1]);
            body_index = 0;
            var_9a65c47f = 0;
            function_dfab5e4f(var_9a65c47f);
            function_5fcfe5a4(character_index, body_index);
            break;
        case 2:
            command0 = strtok(split[0], "<unknown string>");
            character_index = int(command0[1]);
            command1 = strtok(split[1], "<unknown string>");
            if (command1[0] == "<unknown string>") {
                body_index = int(command1[1]);
                function_5fcfe5a4(character_index, body_index);
            } else if (command1[0] == "<unknown string>") {
                var_9a65c47f = int(command1[1]);
                function_dfab5e4f(var_9a65c47f);
            }
            break;
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // Checksum 0x13761b6, Offset: 0x1718
    // Size: 0x2e6
    function body_customization_populate(mode) {
        bodies = getallcharacterbodies(mode);
        body_customization_devgui_base = "<unknown string>";
        foreach (playerbodytype in bodies) {
            body_name = makelocalizedstring(getcharacterdisplayname(playerbodytype, mode)) + "<unknown string>" + getcharacterassetname(playerbodytype, mode) + "<unknown string>";
            adddebugcommand(body_customization_devgui_base + body_name + "<unknown string>" + "<unknown string>" + "<unknown string>" + "<unknown string>" + "<unknown string>" + playerbodytype + "<unknown string>");
            for (i = 0; i < getcharacterbodymodelcount(playerbodytype, mode); i++) {
                adddebugcommand(body_customization_devgui_base + body_name + "<unknown string>" + i + "<unknown string>" + "<unknown string>" + "<unknown string>" + "<unknown string>" + playerbodytype + "<unknown string>" + "<unknown string>" + i + "<unknown string>");
                wait(0.05);
            }
            for (i = 0; i < getcharacterhelmetmodelcount(playerbodytype, mode); i++) {
                adddebugcommand(body_customization_devgui_base + body_name + "<unknown string>" + i + "<unknown string>" + "<unknown string>" + "<unknown string>" + "<unknown string>" + playerbodytype + "<unknown string>" + "<unknown string>" + i + "<unknown string>");
                wait(0.05);
            }
            wait(0.05);
        }
    }

    // Namespace dev
    // Params 1, eflags: 0x1 linked
    // Checksum 0xce02794d, Offset: 0x1a08
    // Size: 0x98
    function body_customization_devgui(mode) {
        thread body_customization_populate(mode);
        for (;;) {
            character_index = getdvarstring("<unknown string>");
            if (character_index != "<unknown string>") {
                body_customization_process_command(character_index);
            }
            setdvar("<unknown string>", "<unknown string>");
            wait(0.5);
        }
    }

    // Namespace dev
    // Params 2, eflags: 0x1 linked
    // Checksum 0xa9980c64, Offset: 0x1aa8
    // Size: 0xdc
    function add_perk_devgui(name, specialties) {
        perk_devgui_base = "<unknown string>";
        perk_name = makelocalizedstring(name);
        test = perk_devgui_base + perk_name + "<unknown string>" + "<unknown string>" + "<unknown string>" + specialties + "<unknown string>";
        adddebugcommand(perk_devgui_base + perk_name + "<unknown string>" + "<unknown string>" + "<unknown string>" + specialties + "<unknown string>");
    }

#/
