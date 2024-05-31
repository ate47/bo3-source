#using scripts/shared/array_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;

#namespace rat_shared;

/#

    // Namespace rat_shared
    // Params 0, eflags: 0x1 linked
    // Checksum 0x645bc421, Offset: 0xd0
    // Size: 0x104
    function init() {
        if (!isdefined(level.rat)) {
            level.rat = spawnstruct();
            level.rat.common = spawnstruct();
            level.rat.script_command_list = [];
            addratscriptcmd("<unknown string>", &rscteleport);
            addratscriptcmd("<unknown string>", &function_edac6d3e);
            addratscriptcmd("<unknown string>", &rscsimulatescripterror);
            addratscriptcmd("<unknown string>", &rscrecteleport);
        }
    }

    // Namespace rat_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0xa1d5276c, Offset: 0x1e0
    // Size: 0x46
    function addratscriptcmd(commandname, functioncallback) {
        init();
        level.rat.script_command_list[commandname] = functioncallback;
    }

    // Namespace rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x177b05bd, Offset: 0x230
    // Size: 0x104
    function codecallback_ratscriptcommand(params) {
        init();
        assert(isdefined(params._cmd));
        assert(isdefined(params._id));
        assert(isdefined(level.rat.script_command_list[params._cmd]), "<unknown string>" + params._cmd);
        callback = level.rat.script_command_list[params._cmd];
        level thread [[ callback ]](params);
    }

    // Namespace rat_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x58db72f7, Offset: 0x340
    // Size: 0x17c
    function rscteleport(params) {
        player = [[ level.rat.common.gethostplayer ]]();
        pos = (float(params.x), float(params.y), float(params.z));
        player setorigin(pos);
        if (isdefined(params.ax)) {
            angles = (float(params.ax), float(params.ay), float(params.az));
            player setplayerangles(angles);
        }
        ratreportcommandresult(params._id, 1);
    }

    // Namespace rat_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x5d890268, Offset: 0x4c8
    // Size: 0x1ec
    function function_edac6d3e(params) {
        foreach (player in level.players) {
            if (!isdefined(player.bot)) {
                continue;
            }
            pos = (float(params.x), float(params.y), float(params.z));
            player setorigin(pos);
            if (isdefined(params.ax)) {
                angles = (float(params.ax), float(params.ay), float(params.az));
                player setplayerangles(angles);
            }
            if (!isdefined(params.all)) {
                break;
            }
        }
        ratreportcommandresult(params._id, 1);
    }

    // Namespace rat_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x1c804330, Offset: 0x6c0
    // Size: 0x8c
    function rscsimulatescripterror(params) {
        if (params.errorlevel == "<unknown string>") {
            assertmsg("<unknown string>");
        } else {
            thisdoesntexist.orthis = 0;
        }
        ratreportcommandresult(params._id, 1);
    }

    // Namespace rat_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x8012e80, Offset: 0x758
    // Size: 0x15c
    function rscrecteleport(params) {
        println("<unknown string>");
        player = [[ level.rat.common.gethostplayer ]]();
        pos = player getorigin();
        angles = player getplayerangles();
        cmd = "<unknown string>" + pos[0] + "<unknown string>" + pos[1] + "<unknown string>" + pos[2] + "<unknown string>" + angles[0] + "<unknown string>" + angles[1] + "<unknown string>" + angles[2];
        ratrecordmessage(0, "<unknown string>", cmd);
        setdvar("<unknown string>", "<unknown string>");
    }

#/
