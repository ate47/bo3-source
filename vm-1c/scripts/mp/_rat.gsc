#using scripts/mp/gametypes/_dev;
#using scripts/mp/bots/_bot;
#using scripts/mp/_util;
#using scripts/shared/array_shared;
#using scripts/shared/rat_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;

#namespace rat;

/#

    // Namespace rat
    // Params 0, eflags: 0x2
    // namespace_c7970376<file_0>::function_2dc19561
    // Checksum 0x4188acbd, Offset: 0x130
    // Size: 0x34
    function autoexec function_2dc19561() {
        system::register("<unknown string>", &__init__, undefined, undefined);
    }

    // Namespace rat
    // Params 0, eflags: 0x1 linked
    // namespace_c7970376<file_0>::function_8c87d8eb
    // Checksum 0xa2e1d915, Offset: 0x170
    // Size: 0x9c
    function __init__() {
        rat_shared::init();
        level.rat.common.gethostplayer = &util::gethostplayer;
        level.rat.deathcount = 0;
        rat_shared::addratscriptcmd("<unknown string>", &rscaddenemy);
        setdvar("<unknown string>", 0);
    }

    // Namespace rat
    // Params 1, eflags: 0x1 linked
    // namespace_c7970376<file_0>::function_fa95cdc0
    // Checksum 0xae3e113b, Offset: 0x218
    // Size: 0x284
    function rscaddenemy(params) {
        player = [[ level.rat.common.gethostplayer ]]();
        team = "<unknown string>";
        if (isdefined(player.pers["<unknown string>"])) {
            team = util::getotherteam(player.pers["<unknown string>"]);
        }
        bot = dev::getormakebot(team);
        if (!isdefined(bot)) {
            println("<unknown string>");
            ratreportcommandresult(params._id, 0, "<unknown string>");
            return;
        }
        bot thread testenemy(team);
        bot thread deathcounter();
        wait(2);
        pos = (float(params.x), float(params.y), float(params.z));
        bot setorigin(pos);
        if (isdefined(params.ax)) {
            angles = (float(params.ax), float(params.ay), float(params.az));
            bot setplayerangles(angles);
        }
        ratreportcommandresult(params._id, 1);
    }

    // Namespace rat
    // Params 1, eflags: 0x1 linked
    // namespace_c7970376<file_0>::function_46de06b3
    // Checksum 0xe170273f, Offset: 0x4a8
    // Size: 0x66
    function testenemy(team) {
        self endon(#"disconnect");
        while (!isdefined(self.pers["<unknown string>"])) {
            wait(0.05);
        }
        if (level.teambased) {
            self notify(#"menuresponse", game["<unknown string>"], team);
        }
    }

    // Namespace rat
    // Params 0, eflags: 0x1 linked
    // namespace_c7970376<file_0>::function_455d89f
    // Checksum 0x6e23e87, Offset: 0x518
    // Size: 0x4c
    function deathcounter() {
        self waittill(#"death");
        level.rat.deathcount++;
        setdvar("<unknown string>", level.rat.deathcount);
    }

#/
