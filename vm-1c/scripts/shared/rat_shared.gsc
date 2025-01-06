#using scripts/shared/array_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace rat_shared;

/#

    // Namespace rat_shared
    // Params 0, eflags: 0x0
    // Checksum 0x645bc421, Offset: 0xd0
    // Size: 0x104
    function init() {
        if (!isdefined(level.rat)) {
            level.rat = spawnstruct();
            level.rat.common = spawnstruct();
            level.rat.script_command_list = [];
            addratscriptcmd("<dev string:x28>", &rscteleport);
            addratscriptcmd("<dev string:x31>", &function_edac6d3e);
            addratscriptcmd("<dev string:x41>", &rscsimulatescripterror);
            addratscriptcmd("<dev string:x55>", &rscrecteleport);
        }
    }

    // Namespace rat_shared
    // Params 2, eflags: 0x0
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
        assert(isdefined(level.rat.script_command_list[params._cmd]), "<dev string:x62>" + params._cmd);
        callback = level.rat.script_command_list[params._cmd];
        level thread [[ callback ]](params);
    }

    // Namespace rat_shared
    // Params 1, eflags: 0x0
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
    // Params 1, eflags: 0x0
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
    // Params 1, eflags: 0x0
    // Checksum 0x1c804330, Offset: 0x6c0
    // Size: 0x8c
    function rscsimulatescripterror(params) {
        if (params.errorlevel == "<dev string:x7e>") {
            assertmsg("<dev string:x84>");
        } else {
            thisdoesntexist.orthis = 0;
        }
        ratreportcommandresult(params._id, 1);
    }

    // Namespace rat_shared
    // Params 1, eflags: 0x0
    // Checksum 0x8012e80, Offset: 0x758
    // Size: 0x15c
    function rscrecteleport(params) {
        println("<dev string:x9d>");
        player = [[ level.rat.common.gethostplayer ]]();
        pos = player getorigin();
        angles = player getplayerangles();
        cmd = "<dev string:xbf>" + pos[0] + "<dev string:xd0>" + pos[1] + "<dev string:xd4>" + pos[2] + "<dev string:xd8>" + angles[0] + "<dev string:xdd>" + angles[1] + "<dev string:xe2>" + angles[2];
        ratrecordmessage(0, "<dev string:xe7>", cmd);
        setdvar("<dev string:xf4>", "<dev string:x110>");
    }

#/
