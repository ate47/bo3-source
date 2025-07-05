#using scripts/mp/_util;
#using scripts/mp/bots/_bot;
#using scripts/mp/gametypes/_dev;
#using scripts/shared/array_shared;
#using scripts/shared/rat_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace rat;

/#

    // Namespace rat
    // Params 0, eflags: 0x2
    // Checksum 0x33c82f14, Offset: 0x130
    // Size: 0x2a
    function autoexec __init__sytem__() {
        system::register("<dev string:x28>", &__init__, undefined, undefined);
    }

    // Namespace rat
    // Params 0, eflags: 0x0
    // Checksum 0x67ab0cd0, Offset: 0x168
    // Size: 0x8a
    function __init__() {
        rat_shared::init();
        level.rat.common.gethostplayer = &util::gethostplayer;
        level.rat.deathcount = 0;
        rat_shared::addratscriptcmd("<dev string:x2c>", &rscaddenemy);
        setdvar("<dev string:x35>", 0);
    }

    // Namespace rat
    // Params 1, eflags: 0x0
    // Checksum 0xa0621d7, Offset: 0x200
    // Size: 0x1f2
    function rscaddenemy(params) {
        player = [[ level.rat.common.gethostplayer ]]();
        team = "<dev string:x45>";
        if (isdefined(player.pers["<dev string:x4a>"])) {
            team = util::getotherteam(player.pers["<dev string:x4a>"]);
        }
        bot = dev::getormakebot(team);
        if (!isdefined(bot)) {
            println("<dev string:x4f>");
            ratreportcommandresult(params._id, 0, "<dev string:x4f>");
            return;
        }
        bot thread testenemy(team);
        bot thread deathcounter();
        wait 2;
        pos = (float(params.x), float(params.y), float(params.z));
        bot setorigin(pos);
        if (isdefined(params.ax)) {
            angles = (float(params.ax), float(params.ay), float(params.az));
            bot setplayerangles(angles);
        }
        ratreportcommandresult(params._id, 1);
    }

    // Namespace rat
    // Params 1, eflags: 0x0
    // Checksum 0xced76262, Offset: 0x400
    // Size: 0x53
    function testenemy(team) {
        self endon(#"disconnect");
        while (!isdefined(self.pers["<dev string:x4a>"])) {
            wait 0.05;
        }
        if (level.teambased) {
            InvalidOpCode(0x54, "<dev string:x69>", team);
            // Unknown operator (0x54, t7_1b, PC)
        }
    }

    // Namespace rat
    // Params 0, eflags: 0x0
    // Checksum 0xd6a89a77, Offset: 0x460
    // Size: 0x42
    function deathcounter() {
        self waittill(#"death");
        level.rat.deathcount++;
        setdvar("<dev string:x35>", level.rat.deathcount);
    }

#/
