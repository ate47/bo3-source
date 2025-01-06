#using scripts/mp/_teamops;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_dogtags;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_spawn;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_prop_controls;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/gametypes/prop;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/bots/_bot;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace prop_dev;

/#

    // Namespace prop_dev
    // Params 2, eflags: 0x0
    // Checksum 0x10ee84f4, Offset: 0x340
    // Size: 0x9c
    function adddevguicommand(path, var_66e49a4e) {
        pathstr = "<dev string:x28>" + path + "<dev string:x28>";
        cmdstr = "<dev string:x28>" + var_66e49a4e + "<dev string:x2a>";
        debugcommand = "<dev string:x2d>" + pathstr + "<dev string:x39>" + cmdstr;
        adddebugcommand(debugcommand);
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0xaafd4ebc, Offset: 0x3e8
    // Size: 0x1720
    function propdevgui() {
        var_b58392ae = 0;
        var_8b6a1374 = 0;
        var_ccd61088 = 0;
        var_6c9fc047 = 0;
        var_f0760dd5 = 0;
        var_8c45c976 = 0;
        var_fe10d650 = 0;
        var_74fced3d = 0;
        minigame_on = getdvarint("<dev string:x3b>", 1);
        server_hud = getdvarint("<dev string:x4d>", 1);
        var_100dc1ab = getdvarfloat("<dev string:x65>");
        util::set_dvar_int_if_unset("<dev string:x77>", 0);
        util::set_dvar_int_if_unset("<dev string:x8a>", 0);
        util::set_dvar_int_if_unset("<dev string:x9c>", 0);
        util::set_dvar_int_if_unset("<dev string:xaf>", 0);
        util::set_dvar_int_if_unset("<dev string:xc0>", 0);
        util::set_dvar_int_if_unset("<dev string:xd1>", 0);
        util::set_dvar_int_if_unset("<dev string:xe6>", 0);
        util::set_dvar_int_if_unset("<dev string:xff>", 0);
        util::set_dvar_int_if_unset("<dev string:x116>", 0);
        util::set_dvar_int_if_unset("<dev string:x129>", 0);
        util::set_dvar_int_if_unset("<dev string:x13b>", 0);
        util::set_dvar_int_if_unset("<dev string:x153>", 1);
        util::set_dvar_int_if_unset("<dev string:x4d>", 1);
        util::set_dvar_int_if_unset("<dev string:x173>", 0);
        util::set_dvar_int_if_unset("<dev string:x188>", 0);
        util::set_dvar_int_if_unset("<dev string:x19c>", 0);
        util::set_dvar_int_if_unset("<dev string:x1b3>", 0);
        util::set_dvar_int_if_unset("<dev string:x1c9>", 0);
        util::set_dvar_int_if_unset("<dev string:x1db>", 0);
        util::set_dvar_int_if_unset("<dev string:x1f3>", 0);
        util::set_dvar_int_if_unset("<dev string:x20b>", 0);
        setdvar("<dev string:x226>", 0);
        setdvar("<dev string:x238>", 0);
        setdvar("<dev string:x24d>", 0);
        setdvar("<dev string:x263>", 0);
        setdvar("<dev string:x27c>", 0);
        setdvar("<dev string:x297>", 0);
        setdvar("<dev string:x2a8>", 0);
        setdvar("<dev string:x2ba>", 0);
        if (getdvarint("<dev string:xe6>", 0) != 0) {
            adddebugcommand("<dev string:x2d1>");
        }
        adddevguicommand("<dev string:x2ee>", "<dev string:x30e>");
        adddevguicommand("<dev string:x32e>", "<dev string:x347>");
        adddevguicommand("<dev string:x384>", "<dev string:x39d>" + 4 + "<dev string:x3b9>");
        adddevguicommand("<dev string:x3da>", "<dev string:x39d>" + 0.25 + "<dev string:x3b9>");
        adddevguicommand("<dev string:x3f4>", "<dev string:x418>");
        adddevguicommand("<dev string:x435>", "<dev string:x458>");
        adddevguicommand("<dev string:x479>", "<dev string:x49a>");
        adddevguicommand("<dev string:x4b7>", "<dev string:x4d9>");
        adddevguicommand("<dev string:x4f7>", "<dev string:x519>");
        adddevguicommand("<dev string:x537>", "<dev string:x557>");
        adddevguicommand("<dev string:x573>", "<dev string:x593>");
        adddevguicommand("<dev string:x5af>", "<dev string:x5c8>");
        adddevguicommand("<dev string:x5e5>", "<dev string:x5fe>");
        adddevguicommand("<dev string:x61b>", "<dev string:x631>");
        adddevguicommand("<dev string:x64a>", "<dev string:x660>");
        adddevguicommand("<dev string:x679>", "<dev string:x68c>");
        adddevguicommand("<dev string:x6d9>", "<dev string:x6ef>");
        adddevguicommand("<dev string:x70c>", "<dev string:x721>");
        adddevguicommand("<dev string:x73e>", "<dev string:x754>");
        adddevguicommand("<dev string:x76c>", "<dev string:x78b>");
        adddevguicommand("<dev string:x7a3>", "<dev string:x7c1>");
        adddevguicommand("<dev string:x7d8>", "<dev string:x7f1>");
        adddevguicommand("<dev string:x811>", "<dev string:x829>");
        adddevguicommand("<dev string:x848>", "<dev string:x864>");
        adddevguicommand("<dev string:x887>", "<dev string:x89e>");
        adddevguicommand("<dev string:x8c1>", "<dev string:x8dc>");
        adddevguicommand("<dev string:x8f9>", "<dev string:x923>");
        adddevguicommand("<dev string:x943>", "<dev string:x970>");
        adddevguicommand("<dev string:x98c>", "<dev string:x9bc>");
        adddevguicommand("<dev string:x9db>", "<dev string:xa06>");
        adddevguicommand("<dev string:xa27>", "<dev string:xa41>");
        adddevguicommand("<dev string:xa64>", "<dev string:xa7d>");
        adddevguicommand("<dev string:xa9a>", "<dev string:xabe>");
        while (true) {
            if (isdefined(level.prematch_over) && level.prematch_over) {
                level.allow_teamchange = "<dev string:xae6>" + getdvarint("<dev string:xff>", 0);
                level.var_2898ef72 = getdvarint("<dev string:x116>", 0) != 0;
            }
            if (getdvarint("<dev string:x4d>", 0) != server_hud && isdefined(level.players)) {
                server_hud = getdvarint("<dev string:x4d>", 0);
                if (!isdefined(level.players[0].changepropkey)) {
                    iprintlnbold("<dev string:xae7>");
                } else {
                    foreach (player in level.players) {
                        if (isdefined(player.team) && player util::isprop()) {
                            player prop_controls::propabilitykeysvisible(server_hud, 1);
                        }
                    }
                    level.elim_hud.alpha = server_hud;
                }
            }
            if (getdvarint("<dev string:x77>", 0) != var_ccd61088 && isdefined(level.players)) {
                foreach (player in level.players) {
                    if (player util::isprop()) {
                        var_ccd61088 = getdvarint("<dev string:x77>", 0);
                        player.var_c4494f8d = !(isdefined(player.var_c4494f8d) && player.var_c4494f8d);
                        player iprintlnbold(player.var_c4494f8d ? "<dev string:xaff>" : "<dev string:xb11>");
                    }
                }
            }
            if (getdvarint("<dev string:x8a>", 0) != var_6c9fc047 && isdefined(level.players)) {
                foreach (player in level.players) {
                    if (player util::isprop()) {
                        var_6c9fc047 = getdvarint("<dev string:x8a>", 0);
                        player.var_b53602f4 = !(isdefined(player.var_b53602f4) && player.var_b53602f4);
                        player iprintlnbold(player.var_b53602f4 ? "<dev string:xb20>" : "<dev string:xb31>");
                    }
                }
            }
            if (getdvarint("<dev string:x9c>", 0) != var_f0760dd5 && isdefined(level.players)) {
                foreach (player in level.players) {
                    if (player util::isprop()) {
                        var_f0760dd5 = getdvarint("<dev string:x9c>", 0);
                        player.var_2f1101f4 = !(isdefined(player.var_2f1101f4) && player.var_2f1101f4);
                        player iprintlnbold(player.var_2f1101f4 ? "<dev string:xb3f>" : "<dev string:xb51>");
                    }
                }
            }
            if (getdvarint("<dev string:xc0>", 0) != var_8c45c976) {
                var_8c45c976 = getdvarint("<dev string:xc0>", 0);
                if (var_8c45c976) {
                    setdvar("<dev string:xb60>", 1);
                    setdvar("<dev string:xb80>", 1);
                    setdvar("<dev string:xba5>", 10000);
                } else {
                    setdvar("<dev string:xb60>", 1600);
                    setdvar("<dev string:xb80>", 1000);
                    setdvar("<dev string:xba5>", 400);
                    iprintlnbold(var_8c45c976 ? "<dev string:xbbb>" : "<dev string:xbcb>");
                }
            }
            if (getdvarint("<dev string:xaf>", 0) != var_fe10d650 && isdefined(level.players)) {
                foreach (player in level.players) {
                    if (player prop::function_e4b2f23()) {
                        var_fe10d650 = getdvarint("<dev string:xaf>", 0);
                        player.var_74ca9cd1 = !(isdefined(player.var_74ca9cd1) && player.var_74ca9cd1);
                        player iprintlnbold(player.var_74ca9cd1 ? "<dev string:xbd8>" : "<dev string:xbe8>");
                    }
                }
            }
            isremoved = getdvarint("<dev string:xd1>", 0);
            if (isremoved != var_b58392ae) {
                var_b58392ae = isremoved;
                function_f35dfc64(!isremoved);
            }
            var_504c9134 = getdvarint("<dev string:x238>", 0);
            if (var_504c9134 != var_8b6a1374) {
                var_8b6a1374 = var_504c9134;
                result = function_194631ab(var_504c9134);
                if (!result) {
                    var_8b6a1374 = !var_504c9134;
                }
                if (var_8b6a1374) {
                    level.drown_damage = 0;
                } else {
                    level.drown_damage = var_100dc1ab;
                }
            }
            if (getdvarint("<dev string:x24d>", 0) != 0) {
                function_543336f9();
                setdvar("<dev string:x24d>", 0);
            }
            if (getdvarint("<dev string:x263>", 0) != 0) {
                function_a8147bf9();
                setdvar("<dev string:x263>", 0);
            }
            if (getdvarint("<dev string:x27c>", 0) != 0) {
                function_1a022b4b();
                setdvar("<dev string:x27c>", 0);
            }
            if (getdvarint("<dev string:x2ba>", 0) != 0) {
                if (isdefined(level.players) && isdefined(level.players[0])) {
                    level thread prop::function_435d5169(%"<dev string:xbf5>", level.players[0]);
                }
                setdvar("<dev string:x2ba>", 0);
            }
            if (getdvarint("<dev string:x129>", 0) != 0) {
                function_276ad638();
            }
            if (getdvarint("<dev string:x13b>", 0)) {
                function_b02387d6();
            }
            if (getdvarint("<dev string:x226>", 0) != 0) {
                showmodels();
                setdvar("<dev string:x226>", 0);
            }
            if (getdvarint("<dev string:x188>", 0) != 0) {
                if (isdefined(level.players) && isdefined(level.players[0])) {
                    level.players[0] prop_controls::canlock();
                }
            }
            if (getdvarint("<dev string:x173>", 0) != 0 || getdvarint("<dev string:x188>", 0) != 0) {
                function_36895abd();
            }
            if (getdvarint("<dev string:x297>", 0) != 0) {
                function_6863880e();
                setdvar("<dev string:x297>", 0);
            }
            if (getdvarint("<dev string:x2a8>", 0) != 0) {
                function_9b9725b1();
                setdvar("<dev string:x2a8>", 0);
            }
            if (getdvarint("<dev string:x19c>", 0) != 0 && isdefined(level.players)) {
                foreach (player in level.players) {
                    player notify(#"cancelcountdown");
                }
                setdvar("<dev string:x19c>", 0);
            }
            if (getdvarint("<dev string:x1c9>", 0) != 0) {
                function_b52ad1b2();
            }
            if (getdvarint("<dev string:x1db>", 0) != 0) {
                showplayers();
            }
            if (getdvarint("<dev string:x1f3>", 0) != 0) {
                showtargets();
            }
            if (getdvarint("<dev string:x3b>", 1) != minigame_on && isdefined(level.players) && level.players.size > 0) {
                minigame_on = getdvarint("<dev string:x3b>", 1);
                iprintlnbold(minigame_on ? "<dev string:xc06>" : "<dev string:xc12>");
            }
            if (getdvarint("<dev string:x20b>", 0) != var_74fced3d && isdefined(level.players) && level.players.size > 0) {
                var_74fced3d = getdvarint("<dev string:x20b>", 0);
                if (var_74fced3d == 2) {
                    iprintlnbold("<dev string:xc1f>");
                } else if (var_74fced3d == 1) {
                    iprintlnbold("<dev string:xc32>");
                } else {
                    iprintlnbold("<dev string:xc46>");
                }
            }
            wait 0.05;
        }
    }

    // Namespace prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0xd6fdb526, Offset: 0x1b10
    // Size: 0xec
    function function_f35dfc64(enabled) {
        setdvar("<dev string:xc5b>", enabled);
        setdvar("<dev string:xc67>", enabled);
        setdvar("<dev string:xc73>", enabled);
        setdvar("<dev string:xc7e>", enabled);
        setdvar("<dev string:xc8a>", enabled);
        setdvar("<dev string:xc99>", enabled);
        setdvar("<dev string:xcaa>", enabled);
    }

    // Namespace prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0x7ba3ecbf, Offset: 0x1c08
    // Size: 0xe2
    function function_194631ab(enabled) {
        if (!isdefined(level.players) || level.players.size == 0) {
            return 0;
        }
        player = level.players[0];
        if (!isdefined(player) || !isalive(player) || isdefined(player.placementoffset) || !isdefined(player.prop)) {
            return 0;
        }
        if (enabled) {
            player function_1b260dda();
        } else {
            player function_bff3e3c5();
        }
        return 1;
    }

    // Namespace prop_dev
    // Params 5, eflags: 0x0
    // Checksum 0xa3e9f7e5, Offset: 0x1cf8
    // Size: 0x8e
    function function_e7f343ff(color, label, value, text, var_5f790513) {
        hudelem = prop_controls::addupperrighthudelem(label, value, text, var_5f790513);
        hudelem.alpha = 0.5;
        hudelem.color = color;
        return hudelem;
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x21b8f9ef, Offset: 0x1d90
    // Size: 0x4ec
    function function_1b260dda() {
        self prop_controls::cleanuppropcontrolshud();
        self prop_controls::function_3122ae57();
        if (self issplitscreen()) {
            self.currenthudy = -10;
        } else {
            self.currenthudy = -80;
        }
        self.var_4efaa35 = function_639754d0(self.prop.info.modelname);
        white = (1, 1, 1);
        red = (1, 0, 0);
        green = (0, 1, 0);
        blue = (0, 0.5, 1);
        self.var_c9f40191 = function_e7f343ff(white, %"<dev string:xcb8>", self.prop.info.proprange);
        self.var_40dabe6f = function_e7f343ff(white, %"<dev string:xcc4>", self.prop.info.propheight);
        self.var_f1fdc495 = function_e7f343ff(white, %"<dev string:xcd1>", self.prop.info.anglesoffset[2]);
        self.var_e7ec6bb6 = function_e7f343ff(white, %"<dev string:xce8>", self.prop.info.anglesoffset[1]);
        self.var_3e02b967 = function_e7f343ff(white, %"<dev string:xcfe>", self.prop.info.anglesoffset[0]);
        self.var_381d73f7 = function_e7f343ff(blue, %"<dev string:xd16>", self.prop.info.xyzoffset[2]);
        self.var_c61604bc = function_e7f343ff(green, %"<dev string:xd2b>", self.prop.info.xyzoffset[1]);
        self.var_ec187f25 = function_e7f343ff(red, %"<dev string:xd40>", self.prop.info.xyzoffset[0]);
        self.var_f3f7c094 = function_e7f343ff(white, %"<dev string:xd55>", self.prop.info.propscale);
        self.var_6b04bc54 = function_e7f343ff(white, %"<dev string:xd60>", self.prop.info.propsize);
        self.var_b97b612d = function_e7f343ff(white, undefined, undefined, "<dev string:xd6c>" + self.prop.info.propsizetext);
        self.placementmodel = function_e7f343ff(white, undefined, undefined, "<dev string:xd73>" + self.var_4efaa35 + "<dev string:xd7b>" + self.prop.info.modelname);
        self.var_af6ef079 = array(self.placementmodel, self.var_b97b612d, self.var_6b04bc54, self.var_f3f7c094, self.var_ec187f25, self.var_c61604bc, self.var_381d73f7, self.var_3e02b967, self.var_e7ec6bb6, self.var_f1fdc495, self.var_40dabe6f, self.var_c9f40191);
        self.placementindex = 0;
        self function_9cfa92f3();
        self thread function_d8d922ad();
        self thread function_18a45f58();
        self thread function_8bd2ff0();
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x43b9e33e, Offset: 0x2288
    // Size: 0x17c
    function function_bff3e3c5() {
        self notify(#"hash_bff3e3c5");
        prop_controls::safedestroy(self.placementmodel);
        prop_controls::safedestroy(self.var_b97b612d);
        prop_controls::safedestroy(self.var_6b04bc54);
        prop_controls::safedestroy(self.var_f3f7c094);
        prop_controls::safedestroy(self.var_ec187f25);
        prop_controls::safedestroy(self.var_c61604bc);
        prop_controls::safedestroy(self.var_381d73f7);
        prop_controls::safedestroy(self.var_3e02b967);
        prop_controls::safedestroy(self.var_e7ec6bb6);
        prop_controls::safedestroy(self.var_f1fdc495);
        prop_controls::safedestroy(self.var_40dabe6f);
        prop_controls::safedestroy(self.var_c9f40191);
        self function_4e71de66();
        self prop_controls::propcontrolshud();
        self prop_controls::setupkeybindings();
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x5b4e48d4, Offset: 0x2410
    // Size: 0x54
    function function_8bd2ff0() {
        self endon(#"game_ended");
        self endon(#"disconnect");
        self endon(#"hash_bff3e3c5");
        self waittill(#"death");
        setdvar("<dev string:x238>", 0);
    }

    // Namespace prop_dev
    // Params 6, eflags: 0x0
    // Checksum 0xc28dfe5c, Offset: 0x2470
    // Size: 0x13c
    function debugaxis(origin, angles, size, alpha, depthtest, duration) {
        axisx = anglestoforward(angles) * size;
        axisy = anglestoright(angles) * size;
        axisz = anglestoup(angles) * size;
        line(origin, origin + axisx, (1, 0, 0), alpha, 0, duration);
        line(origin, origin + axisy, (0, 1, 0), alpha, 0, duration);
        line(origin, origin + axisz, (0, 0, 1), alpha, 0, duration);
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0xa3d2d16e, Offset: 0x25b8
    // Size: 0xb0
    function function_d8d922ad() {
        self endon(#"hash_bff3e3c5");
        while (true) {
            debugaxis(self.origin, self.angles, 100, 1, 0, 1);
            box(self.origin, self getmins(), self getmaxs(), self.angles[1], (1, 0, 1), 1, 0, 1);
            wait 0.05;
        }
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x1970135e, Offset: 0x2670
    // Size: 0x178
    function function_18a45f58() {
        self endon(#"hash_bff3e3c5");
        self function_9c8c6fe4(0);
        while (true) {
            msg = self util::waittill_any_return("<dev string:xd7d>", "<dev string:xd80>", "<dev string:xd85>", "<dev string:xd8a>", "<dev string:xd90>");
            if (!isdefined(msg)) {
                continue;
            }
            if (msg == "<dev string:xd7d>") {
                self function_6049bca3(-1);
                continue;
            }
            if (msg == "<dev string:xd80>") {
                self function_6049bca3(1);
                continue;
            }
            if (msg == "<dev string:xd8a>") {
                self function_a24562f8(1);
                continue;
            }
            if (msg == "<dev string:xd85>") {
                self function_a24562f8(-1);
                continue;
            }
            if (msg == "<dev string:xd90>") {
                function_c64fb4ca();
            }
        }
    }

    // Namespace prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0x691cbaf6, Offset: 0x27f0
    // Size: 0x68
    function function_6049bca3(val) {
        self endon(#"letgo");
        function_9c8c6fe4(val);
        wait 0.5;
        while (true) {
            function_9c8c6fe4(val);
            wait 0.05;
        }
    }

    // Namespace prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0x51c5a6ce, Offset: 0x2860
    // Size: 0xf4
    function function_9c8c6fe4(val) {
        hudelem = self.var_af6ef079[self.placementindex];
        hudelem.alpha = 0.5;
        hudelem.fontscale = 1;
        self.placementindex += val;
        if (self.placementindex >= self.var_af6ef079.size) {
            self.placementindex = 0;
        } else if (self.placementindex < 0) {
            self.placementindex = self.var_af6ef079.size - 1;
        }
        hudelem = self.var_af6ef079[self.placementindex];
        hudelem.alpha = 1;
        hudelem.fontscale = 1.3;
    }

    // Namespace prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0x979bdb9, Offset: 0x2960
    // Size: 0x68
    function function_a24562f8(val) {
        self endon(#"letgo");
        function_8bdc662f(val);
        wait 0.5;
        while (true) {
            function_8bdc662f(val);
            wait 0.05;
        }
    }

    // Namespace prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0x876bb00d, Offset: 0x29d0
    // Size: 0x78
    function function_e52aa8bb(inval) {
        tempindex = self.var_4efaa35 + inval;
        if (tempindex >= level.propindex.size) {
            tempindex = 0;
        } else if (tempindex < 0) {
            tempindex = level.propindex.size - 1;
        }
        self.var_4efaa35 = tempindex;
    }

    // Namespace prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0x83df7dee, Offset: 0x2a50
    // Size: 0x84
    function function_639754d0(var_95f39eee) {
        for (index = 0; index < level.propindex.size; index++) {
            if (level.proplist[level.propindex[index][0]][level.propindex[index][1]].modelname == var_95f39eee) {
                return index;
            }
        }
    }

    // Namespace prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0xb3f2ffad, Offset: 0x2ae0
    // Size: 0xf5c
    function function_8bdc662f(val) {
        hudelem = self.var_af6ef079[self.placementindex];
        if (hudelem == self.placementmodel) {
            function_e52aa8bb(val);
            self.prop.info = level.proplist[level.propindex[self.var_4efaa35][0]][level.propindex[self.var_4efaa35][1]];
            prop_controls::propchangeto(self.prop.info);
            self.placementmodel settext("<dev string:xd95>" + self.var_4efaa35 + "<dev string:xd9d>" + self.prop.info.modelname);
            self.var_b97b612d settext("<dev string:xd6c>" + self.prop.info.propsizetext);
            self.var_6b04bc54 setvalue(self.prop.info.propsize);
            self.var_f3f7c094 setvalue(self.prop.info.propscale);
            self.var_ec187f25 setvalue(self.prop.info.xyzoffset[0]);
            self.var_c61604bc setvalue(self.prop.info.xyzoffset[1]);
            self.var_381d73f7 setvalue(self.prop.info.xyzoffset[2]);
            self.var_3e02b967 setvalue(self.prop.info.anglesoffset[0]);
            self.var_e7ec6bb6 setvalue(self.prop.info.anglesoffset[1]);
            self.var_f1fdc495 setvalue(self.prop.info.anglesoffset[2]);
            self.var_40dabe6f setvalue(self.prop.info.propheight);
            self.var_c9f40191 setvalue(self.prop.info.proprange);
            return;
        }
        if (hudelem == self.var_b97b612d || hudelem == self.var_6b04bc54) {
            sizes = array("<dev string:xda1>", "<dev string:xda8>", "<dev string:xdae>", "<dev string:xdb5>", "<dev string:xdbb>", "<dev string:xdc2>");
            index = 0;
            for (i = 0; i < sizes.size; i++) {
                if (sizes[i] == self.prop.info.propsizetext) {
                    index = i;
                    break;
                }
            }
            index += val;
            if (index < 0) {
                index = sizes.size - 1;
            } else if (index >= sizes.size) {
                index = 0;
            }
            self.prop.info.propsizetext = sizes[index];
            self.prop.info.propsize = prop::getpropsize(self.prop.info.propsizetext);
            self.var_b97b612d settext("<dev string:xd6c>" + self.prop.info.propsizetext);
            self.var_6b04bc54 setvalue(self.prop.info.propsize);
            self.health = self.prop.info.propsize;
            self.maxhealth = self.health;
            return;
        }
        if (hudelem == self.var_f3f7c094) {
            var_759a3fa8 = 0.1;
            var_c5fe12fe = 10;
            var_edcea860 = 0.01;
            self.prop.info.propscale += var_edcea860 * val;
            self.prop.info.propscale = math::clamp(self.prop.info.propscale, var_759a3fa8, var_c5fe12fe);
            self.prop setscale(self.prop.info.propscale, 1);
            self.var_f3f7c094 setvalue(self.prop.info.propscale);
            return;
        }
        if (hudelem == self.var_ec187f25) {
            self.prop unlink();
            self.prop.info.xyzoffset = (self.prop.info.xyzoffset[0] + val, self.prop.info.xyzoffset[1], self.prop.info.xyzoffset[2]);
            self.prop.xyzoffset = self.prop.info.xyzoffset;
            self.var_ec187f25 setvalue(self.prop.info.xyzoffset[0]);
            function_4ef69a48();
            return;
        }
        if (hudelem == self.var_c61604bc) {
            self.prop unlink();
            self.prop.info.xyzoffset = (self.prop.info.xyzoffset[0], self.prop.info.xyzoffset[1] + val, self.prop.info.xyzoffset[2]);
            self.prop.xyzoffset = self.prop.info.xyzoffset;
            self.var_c61604bc setvalue(self.prop.info.xyzoffset[1]);
            function_4ef69a48();
            return;
        }
        if (hudelem == self.var_381d73f7) {
            self.prop unlink();
            self.prop.info.xyzoffset = (self.prop.info.xyzoffset[0], self.prop.info.xyzoffset[1], self.prop.info.xyzoffset[2] + val);
            self.prop.xyzoffset = self.prop.info.xyzoffset;
            self.var_381d73f7 setvalue(self.prop.info.xyzoffset[2]);
            function_4ef69a48();
            return;
        }
        if (hudelem == self.var_3e02b967) {
            self.prop unlink();
            self.prop.info.anglesoffset = (self.prop.info.anglesoffset[0] + val, self.prop.info.anglesoffset[1], self.prop.info.anglesoffset[2]);
            self.prop.anglesoffset = self.prop.info.anglesoffset;
            self.var_3e02b967 setvalue(self.prop.info.anglesoffset[0]);
            function_4ef69a48();
            return;
        }
        if (hudelem == self.var_e7ec6bb6) {
            self.prop unlink();
            self.prop.info.anglesoffset = (self.prop.info.anglesoffset[0], self.prop.info.anglesoffset[1] + val, self.prop.info.anglesoffset[2]);
            self.prop.anglesoffset = self.prop.info.anglesoffset;
            self.var_e7ec6bb6 setvalue(self.prop.info.anglesoffset[1]);
            function_4ef69a48();
            return;
        }
        if (hudelem == self.var_f1fdc495) {
            self.prop unlink();
            self.prop.info.anglesoffset = (self.prop.info.anglesoffset[0], self.prop.info.anglesoffset[1], self.prop.info.anglesoffset[2] + val);
            self.prop.anglesoffset = self.prop.info.anglesoffset;
            self.var_f1fdc495 setvalue(self.prop.info.anglesoffset[2]);
            function_4ef69a48();
            return;
        }
        if (hudelem == self.var_40dabe6f) {
            adjust = 10;
            self.prop.info.propheight += adjust * val;
            self.prop.info.propheight = math::clamp(self.prop.info.propheight, -30, 40);
            self.thirdpersonheightoffset = self.prop.info.propheight;
            self setclientthirdperson(1, self.thirdpersonrange, self.thirdpersonheightoffset);
            self.var_40dabe6f setvalue(self.prop.info.propheight);
            return;
        }
        if (hudelem == self.var_c9f40191) {
            adjust = 10;
            self.prop.info.proprange += adjust * val;
            self.prop.info.proprange = math::clamp(self.prop.info.proprange, 50, 360);
            self.thirdpersonrange = self.prop.info.proprange;
            self setclientthirdperson(1, self.thirdpersonrange, self.thirdpersonheightoffset);
            self.var_c9f40191 setvalue(self.prop.info.proprange);
        }
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x4757a0ed, Offset: 0x3a48
    // Size: 0x74
    function function_4ef69a48() {
        self.prop.origin = self.propent.origin;
        self prop::applyxyzoffset();
        self prop::applyanglesoffset();
        self.prop linkto(self.propent);
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x5b8e6721, Offset: 0x3ac8
    // Size: 0x1e4
    function function_9cfa92f3() {
        self prop_controls::notifyonplayercommand("<dev string:xd7d>", "<dev string:xdc9>");
        self prop_controls::notifyonplayercommand("<dev string:xd80>", "<dev string:xdd7>");
        self prop_controls::notifyonplayercommand("<dev string:xd85>", "<dev string:xde5>");
        self prop_controls::notifyonplayercommand("<dev string:xd8a>", "<dev string:xdf3>");
        self prop_controls::notifyonplayercommand("<dev string:xe01>", "<dev string:xe07>");
        self prop_controls::notifyonplayercommand("<dev string:xe01>", "<dev string:xe15>");
        self prop_controls::notifyonplayercommand("<dev string:xe01>", "<dev string:xe23>");
        self prop_controls::notifyonplayercommand("<dev string:xe01>", "<dev string:xe31>");
        self prop_controls::notifyonplayercommand("<dev string:xd90>", "<dev string:xe3f>");
        self prop_controls::notifyonplayercommand("<dev string:xe47>", "<dev string:xe4f>");
        self prop_controls::notifyonplayercommand("<dev string:xe58>", "<dev string:xe5f>");
        self prop_controls::notifyonplayercommand("<dev string:xe58>", "<dev string:xe6a>");
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0xf5d14f24, Offset: 0x3cb8
    // Size: 0x1e4
    function function_4e71de66() {
        self prop_controls::notifyonplayercommandremove("<dev string:xd7d>", "<dev string:xdc9>");
        self prop_controls::notifyonplayercommandremove("<dev string:xd80>", "<dev string:xdd7>");
        self prop_controls::notifyonplayercommandremove("<dev string:xd85>", "<dev string:xde5>");
        self prop_controls::notifyonplayercommandremove("<dev string:xd8a>", "<dev string:xdf3>");
        self prop_controls::notifyonplayercommandremove("<dev string:xe01>", "<dev string:xe07>");
        self prop_controls::notifyonplayercommandremove("<dev string:xe01>", "<dev string:xe15>");
        self prop_controls::notifyonplayercommandremove("<dev string:xe01>", "<dev string:xe23>");
        self prop_controls::notifyonplayercommandremove("<dev string:xe01>", "<dev string:xe31>");
        self prop_controls::notifyonplayercommandremove("<dev string:xd90>", "<dev string:xe3f>");
        self prop_controls::notifyonplayercommandremove("<dev string:xe47>", "<dev string:xe4f>");
        self prop_controls::notifyonplayercommandremove("<dev string:xe58>", "<dev string:xe5f>");
        self prop_controls::notifyonplayercommandremove("<dev string:xe58>", "<dev string:xe6a>");
    }

    // Namespace prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0xf0f7e163, Offset: 0x3ea8
    // Size: 0x4c
    function function_b7096a63(vec) {
        return vec[0] != 0 || vec[1] != 0 || isdefined(vec) && vec[2] != 0;
    }

    // Namespace prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0x26e43a0, Offset: 0x3f00
    // Size: 0x56
    function function_f0e744af(propinfo) {
        return isdefined(propinfo.propheight) && propinfo.propheight != prop::getthirdpersonheightoffsetforsize(propinfo.propsize);
    }

    // Namespace prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0x3832ff7, Offset: 0x3f60
    // Size: 0x56
    function function_52e4c413(propinfo) {
        return isdefined(propinfo.proprange) && propinfo.proprange != prop::getthirdpersonrangeforsize(propinfo.propsize);
    }

    // Namespace prop_dev
    // Params 2, eflags: 0x0
    // Checksum 0x276c8e5c, Offset: 0x3fc0
    // Size: 0x2a4
    function function_954fa963(file, propinfo) {
        propstr = "<dev string:xae6>" + propinfo.modelname + "<dev string:xe74>" + propinfo.propsizetext + "<dev string:xe74>" + propinfo.propscale;
        if (function_b7096a63(propinfo.xyzoffset)) {
            propstr += "<dev string:xe74>" + propinfo.xyzoffset[0] + "<dev string:xe74>" + propinfo.xyzoffset[1] + "<dev string:xe74>" + propinfo.xyzoffset[2];
        } else {
            propstr += "<dev string:xe76>";
        }
        if (function_b7096a63(propinfo.anglesoffset)) {
            propstr += "<dev string:xe74>" + propinfo.anglesoffset[0] + "<dev string:xe74>" + propinfo.anglesoffset[1] + "<dev string:xe74>" + propinfo.anglesoffset[2];
        } else {
            propstr += "<dev string:xe76>";
        }
        if (function_f0e744af(propinfo)) {
            propstr += "<dev string:xe74>" + propinfo.propheight;
        } else {
            propstr += "<dev string:xe74>" + prop::getthirdpersonheightoffsetforsize(propinfo.propsize);
        }
        if (function_52e4c413(propinfo)) {
            propstr += "<dev string:xe74>" + propinfo.proprange;
        } else {
            propstr += "<dev string:xe74>" + prop::getthirdpersonrangeforsize(propinfo.propsize);
        }
        fprintln(file, propstr);
    }

    // Namespace prop_dev
    // Params 2, eflags: 0x0
    // Checksum 0x645efcda, Offset: 0x4270
    // Size: 0x5c
    function function_90b01d01(file, propinfo) {
        propstr = "<dev string:xe7d>" + propinfo.modelname + "<dev string:xe93>";
        fprintln(file, propstr);
    }

    // Namespace prop_dev
    // Params 2, eflags: 0x0
    // Checksum 0x78e0e2cf, Offset: 0x42d8
    // Size: 0x128
    function function_74e29250(file, propsizetext) {
        foreach (sizetype in level.proplist) {
            foreach (propinfo in sizetype) {
                if (propinfo.propsizetext == propsizetext) {
                    function_954fa963(file, propinfo);
                }
            }
        }
    }

    // Namespace prop_dev
    // Params 2, eflags: 0x0
    // Checksum 0xb6ee1cee, Offset: 0x4408
    // Size: 0x128
    function function_bce1e8ea(file, propsizetext) {
        foreach (sizetype in level.proplist) {
            foreach (propinfo in sizetype) {
                if (propinfo.propsizetext == propsizetext) {
                    function_90b01d01(file, propinfo);
                }
            }
        }
    }

    // Namespace prop_dev
    // Params 2, eflags: 0x0
    // Checksum 0x1e42a382, Offset: 0x4538
    // Size: 0x324
    function function_d3a80896(file, var_dc7b1be6) {
        var_7b625b5a = var_dc7b1be6 + "<dev string:xe98>";
        var_74036302 = var_dc7b1be6 + "<dev string:xe9d>";
        var_11e4d40d = var_dc7b1be6 + "<dev string:xea2>";
        var_9f31b917 = level.script + "<dev string:xea8>";
        var_a0b36f12 = level.script + "<dev string:xeae>";
        var_43a6e14b = "<dev string:xeb3>";
        var_6da36d3e = "<dev string:xecc>";
        var_586b7057 = "<dev string:xee8>";
        fprintln(file, "<dev string:xf0c>");
        fprintln(file, "<dev string:xae6>");
        fprintln(file, "<dev string:xfb2>");
        fprintln(file, "<dev string:xfba>" + var_7b625b5a + "<dev string:xfd1>");
        fprintln(file, "<dev string:xfe3>" + var_74036302 + "<dev string:xfd1>");
        fprintln(file, "<dev string:xffa>" + var_11e4d40d + "<dev string:x100d>" + var_43a6e14b);
        fprintln(file, "<dev string:x1012>" + var_7b625b5a + "<dev string:x100d>" + var_586b7057);
        fprintln(file, "<dev string:x1025>" + var_74036302 + "<dev string:x100d>" + var_6da36d3e);
        fprintln(file, "<dev string:x1038>");
        fprintln(file, "<dev string:x1059>" + var_9f31b917 + "<dev string:x1074>" + var_dc7b1be6);
        fprintln(file, "<dev string:x107f>" + var_a0b36f12 + "<dev string:x109a>" + var_74036302 + "<dev string:x10b0>");
        fprintln(file, "<dev string:xae6>");
        fprintln(file, "<dev string:x10b2>");
        fprintln(file, "<dev string:xae6>");
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x1b15aca1, Offset: 0x4868
    // Size: 0x3c4
    function function_543336f9() {
        platform = "<dev string:x10e2>";
        if (level.orbis) {
            platform = "<dev string:x10e5>";
        } else if (level.durango) {
            platform = "<dev string:x10eb>";
        }
        var_dc7b1be6 = level.script + "<dev string:x10f3>";
        var_7b625b5a = var_dc7b1be6 + "<dev string:xe98>";
        var_36b45864 = "<dev string:x10f7>" + platform + "<dev string:x10fd>";
        var_586b7057 = "<dev string:xee8>";
        file = openfile(var_7b625b5a, "<dev string:x110a>");
        if (file == -1) {
            iprintlnbold("<dev string:x1110>" + var_36b45864 + var_7b625b5a + "<dev string:x1123>");
            println("<dev string:x1110>" + var_36b45864 + var_7b625b5a + "<dev string:x1123>");
            return;
        }
        function_d3a80896(file, var_dc7b1be6);
        fprintln(file, "<dev string:x1130>");
        function_74e29250(file, "<dev string:xda1>");
        fprintln(file, "<dev string:xae6>");
        fprintln(file, "<dev string:x1143>");
        function_74e29250(file, "<dev string:xda8>");
        fprintln(file, "<dev string:xae6>");
        fprintln(file, "<dev string:x1150>");
        function_74e29250(file, "<dev string:xdae>");
        fprintln(file, "<dev string:xae6>");
        fprintln(file, "<dev string:x115e>");
        function_74e29250(file, "<dev string:xdb5>");
        fprintln(file, "<dev string:xae6>");
        fprintln(file, "<dev string:x116b>");
        function_74e29250(file, "<dev string:xdbb>");
        iprintlnbold("<dev string:x117e>" + var_36b45864 + var_7b625b5a + "<dev string:x1185>" + var_586b7057);
        println("<dev string:x117e>" + var_36b45864 + var_7b625b5a + "<dev string:x1185>" + var_586b7057);
        closefile(file);
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0xc289c660, Offset: 0x4c38
    // Size: 0x3a4
    function function_a8147bf9() {
        platform = "<dev string:x10e2>";
        if (level.orbis) {
            platform = "<dev string:x10e5>";
        } else if (level.durango) {
            platform = "<dev string:x10eb>";
        }
        var_dc7b1be6 = level.script + "<dev string:x10f3>";
        var_7b625b5a = var_dc7b1be6 + "<dev string:xe9d>";
        var_36b45864 = "<dev string:x10f7>" + platform + "<dev string:x10fd>";
        var_586b7057 = "<dev string:xecc>";
        file = openfile(var_7b625b5a, "<dev string:x110a>");
        if (file == -1) {
            iprintlnbold("<dev string:x1110>" + var_36b45864 + var_7b625b5a + "<dev string:x1123>");
            println("<dev string:x1110>" + var_36b45864 + var_7b625b5a + "<dev string:x1123>");
            return;
        }
        fprintln(file, "<dev string:x1190>");
        function_bce1e8ea(file, "<dev string:xda1>");
        fprintln(file, "<dev string:xae6>");
        fprintln(file, "<dev string:x11a5>");
        function_bce1e8ea(file, "<dev string:xda8>");
        fprintln(file, "<dev string:xae6>");
        fprintln(file, "<dev string:x11b4>");
        function_bce1e8ea(file, "<dev string:xdae>");
        fprintln(file, "<dev string:xae6>");
        fprintln(file, "<dev string:x11c4>");
        function_bce1e8ea(file, "<dev string:xdb5>");
        fprintln(file, "<dev string:xae6>");
        fprintln(file, "<dev string:x11d3>");
        function_bce1e8ea(file, "<dev string:xdbb>");
        iprintlnbold("<dev string:x117e>" + var_36b45864 + var_7b625b5a + "<dev string:x1185>" + var_586b7057);
        println("<dev string:x117e>" + var_36b45864 + var_7b625b5a + "<dev string:x1185>" + var_586b7057);
        closefile(file);
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0xaa973459, Offset: 0x4fe8
    // Size: 0xc54
    function function_1a022b4b() {
        platform = "<dev string:x10e2>";
        if (level.orbis) {
            platform = "<dev string:x10e5>";
        } else if (level.durango) {
            platform = "<dev string:x10eb>";
        }
        var_dc7b1be6 = level.script + "<dev string:x10f3>";
        var_7b625b5a = var_dc7b1be6 + "<dev string:xe98>";
        var_74036302 = var_dc7b1be6 + "<dev string:xe9d>";
        var_11e4d40d = var_dc7b1be6 + "<dev string:xea2>";
        var_9f31b917 = level.script + "<dev string:xea8>";
        var_a0b36f12 = level.script + "<dev string:xeae>";
        var_36b45864 = "<dev string:x10f7>" + platform + "<dev string:x10fd>";
        var_43a6e14b = "<dev string:xeb3>";
        var_6da36d3e = "<dev string:xecc>";
        var_586b7057 = "<dev string:xee8>";
        file = openfile(var_7b625b5a, "<dev string:x110a>");
        if (file == -1) {
            iprintlnbold("<dev string:x1110>" + var_36b45864 + var_7b625b5a + "<dev string:x1123>");
            println("<dev string:x1110>" + var_36b45864 + var_7b625b5a + "<dev string:x1123>");
            return;
        }
        function_d3a80896(file, var_dc7b1be6);
        fprintln(file, "<dev string:x1130>");
        fprintln(file, "<dev string:x11e8>");
        fprintln(file, "<dev string:x11e8>");
        fprintln(file, "<dev string:x11e8>");
        fprintln(file, "<dev string:xae6>");
        fprintln(file, "<dev string:x1143>");
        fprintln(file, "<dev string:x1201>");
        fprintln(file, "<dev string:x1201>");
        fprintln(file, "<dev string:x1201>");
        fprintln(file, "<dev string:x1201>");
        fprintln(file, "<dev string:x1201>");
        fprintln(file, "<dev string:x1201>");
        fprintln(file, "<dev string:xae6>");
        fprintln(file, "<dev string:x1150>");
        fprintln(file, "<dev string:x1218>");
        fprintln(file, "<dev string:x1218>");
        fprintln(file, "<dev string:x1218>");
        fprintln(file, "<dev string:x1218>");
        fprintln(file, "<dev string:x1218>");
        fprintln(file, "<dev string:x1218>");
        fprintln(file, "<dev string:xae6>");
        fprintln(file, "<dev string:x115e>");
        fprintln(file, "<dev string:x1231>");
        fprintln(file, "<dev string:x1231>");
        fprintln(file, "<dev string:x1231>");
        fprintln(file, "<dev string:x1231>");
        fprintln(file, "<dev string:x1231>");
        fprintln(file, "<dev string:x1231>");
        fprintln(file, "<dev string:xae6>");
        fprintln(file, "<dev string:x116b>");
        fprintln(file, "<dev string:x1248>");
        fprintln(file, "<dev string:x1248>");
        fprintln(file, "<dev string:x1248>");
        closefile(file);
        file = openfile(var_74036302, "<dev string:x110a>");
        if (file == -1) {
            iprintlnbold("<dev string:x1110>" + var_36b45864 + var_74036302 + "<dev string:x1123>");
            println("<dev string:x1110>" + var_36b45864 + var_74036302 + "<dev string:x1123>");
            return;
        }
        fprintln(file, "<dev string:x1190>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:xae6>");
        fprintln(file, "<dev string:x11a5>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:xae6>");
        fprintln(file, "<dev string:x11b4>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:xae6>");
        fprintln(file, "<dev string:x11c4>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:xae6>");
        fprintln(file, "<dev string:x11d3>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:x1266>");
        fprintln(file, "<dev string:x1266>");
        closefile(file);
        file = openfile(var_11e4d40d, "<dev string:x110a>");
        if (file == -1) {
            iprintlnbold("<dev string:x1110>" + var_36b45864 + var_11e4d40d + "<dev string:x1123>");
            println("<dev string:x1110>" + var_36b45864 + var_11e4d40d + "<dev string:x1123>");
            return;
        }
        fprintln(file, "<dev string:x1280>" + var_7b625b5a);
        fprintln(file, "<dev string:x12a0>" + var_74036302);
        closefile(file);
        iprintlnbold("<dev string:x12b4>" + var_36b45864);
        println("<dev string:x12b4>" + var_36b45864);
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x4b50b060, Offset: 0x5c48
    // Size: 0x3e8
    function function_c64fb4ca() {
        player = level.players[0];
        if (!isdefined(player) || !isalive(player) || !(isdefined(player.hasspawned) && player.hasspawned)) {
            return;
        }
        if (isdefined(level.players[1])) {
            enemybot = level.players[1];
        } else {
            enemybot = bot::add_bot(util::getotherteam(player.team));
        }
        if (!isdefined(enemybot.pers["<dev string:x12cb>"])) {
            enemybot.pers["<dev string:x12cb>"] = 0;
        }
        if (!isdefined(enemybot.hits)) {
            enemybot.hits = 0;
        }
        setdvar("<dev string:x12d9>", 0);
        setdvar("<dev string:x12e9>", 0);
        player.health = player.maxhealth;
        weapon = getweapon("<dev string:x12fb>");
        end = player.origin;
        dir = anglestoforward(player.angles);
        start = end + dir * 100 + (0, 0, 30);
        magicbullet(weapon, start, end, enemybot);
        dirback = -1 * dir;
        start = end + dirback * 100 + (0, 0, 30);
        magicbullet(weapon, start, end, enemybot);
        dirright = anglestoright(player.angles);
        start = end + dirright * 100 + (0, 0, 30);
        magicbullet(weapon, start, end, enemybot);
        dirleft = -1 * dirright;
        start = end + dirleft * 100 + (0, 0, 30);
        magicbullet(weapon, start, end, enemybot);
        start = end + (0, 0, 100);
        magicbullet(weapon, start, end, enemybot);
        player util::waittill_notify_or_timeout("<dev string:x1308>", 0.3);
        wait 0.5;
        player.health = player.maxhealth;
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0xa85fb79d, Offset: 0x6038
    // Size: 0x10a
    function function_276ad638() {
        if (!isdefined(level.players)) {
            return;
        }
        foreach (player in level.players) {
            if (isdefined(player) && isdefined(player.team) && player.team == game["<dev string:x130f>"]) {
                print3d(player.origin + (0, 0, 50), "<dev string:xae6>" + player.health);
            }
        }
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0xbdb77043, Offset: 0x6150
    // Size: 0x132
    function function_b52ad1b2() {
        if (!isdefined(level.players)) {
            return;
        }
        foreach (player in level.players) {
            velocity = player getvelocity();
            var_6c52699a = (velocity[0], velocity[1], 0);
            speed = length(var_6c52699a);
            print3d(player.origin + (0, 0, 50), "<dev string:xae6>" + speed);
        }
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x3b365809, Offset: 0x6290
    // Size: 0xca
    function function_b02387d6() {
        if (!isdefined(level.players)) {
            return;
        }
        foreach (player in level.players) {
            if (isdefined(player) && isdefined(player.prop)) {
                player prop_controls::get_ground_normal(player.prop, 1);
            }
        }
    }

    // Namespace prop_dev
    // Params 3, eflags: 0x0
    // Checksum 0xdf8fdf55, Offset: 0x6368
    // Size: 0x32a
    function function_61b27799(propinfo, origin, angles) {
        propent = spawn("<dev string:x1319>", origin);
        propent setcontents(0);
        propent notsolid();
        propent setplayercollision(0);
        prop = spawn("<dev string:x1319>", propent.origin);
        prop.angles = angles;
        prop setmodel(propinfo.modelname);
        prop setscale(propinfo.propscale, 1);
        prop setcandamage(1);
        prop.xyzoffset = propinfo.xyzoffset;
        prop.anglesoffset = propinfo.anglesoffset;
        prop.health = 1;
        prop setplayercollision(0);
        forward = anglestoforward(angles) * prop.xyzoffset[0];
        right = anglestoright(angles) * prop.xyzoffset[1];
        up = anglestoup(angles) * prop.xyzoffset[2];
        prop.origin += forward;
        prop.origin += right;
        prop.origin += up;
        prop.angles += prop.anglesoffset;
        prop linkto(propent);
        propent.prop = prop;
        propent.propinfo = propinfo;
        return propent;
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x6628b56a, Offset: 0x66a0
    // Size: 0x264
    function showmodels() {
        player = level.players[0];
        angles = player.angles;
        dir = anglestoforward(angles);
        origin = player.origin + (0, 0, 100);
        if (!isdefined(level.var_7627c471)) {
            level.var_7627c471 = [];
            foreach (category in level.proplist) {
                foreach (propinfo in category) {
                    level.var_7627c471[level.var_7627c471.size] = function_61b27799(propinfo, origin, angles);
                    origin += dir * 60;
                }
            }
            return;
        }
        foreach (propent in level.var_7627c471) {
            propent.origin = origin;
            origin += dir * 60;
        }
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0xe76f612, Offset: 0x6910
    // Size: 0x334
    function function_36895abd() {
        if (!isdefined(level.var_ec1690fd)) {
            return;
        }
        color = (0, 1, 0);
        if (!level.var_ec1690fd.success) {
            color = (1, 0, 0);
        }
        print3d(level.var_ec1690fd.playerorg + (0, 0, 50), level.var_ec1690fd.type);
        box(level.var_ec1690fd.playerorg, level.var_ec1690fd.playermins, level.var_ec1690fd.playermaxs, level.var_ec1690fd.playerangles[1], color);
        if (isdefined(level.var_ec1690fd.origin1)) {
            sphere(level.var_ec1690fd.origin1, 5, color);
            line(level.var_ec1690fd.playerorg, level.var_ec1690fd.origin1);
            if (isdefined(level.var_ec1690fd.text1)) {
                print3d(level.var_ec1690fd.origin1 + (0, 0, -10), level.var_ec1690fd.text1);
            }
        }
        if (isdefined(level.var_ec1690fd.origin2)) {
            sphere(level.var_ec1690fd.origin2, 5, color);
            line(level.var_ec1690fd.playerorg, level.var_ec1690fd.origin2);
            if (isdefined(level.var_ec1690fd.text2)) {
                print3d(level.var_ec1690fd.origin2 + (0, 0, 10), level.var_ec1690fd.text2);
            }
        }
        if (isdefined(level.var_ec1690fd.origin3)) {
            sphere(level.var_ec1690fd.origin3, 5, color);
            line(level.var_ec1690fd.playerorg, level.var_ec1690fd.origin3);
            if (isdefined(level.var_ec1690fd.text3)) {
                print3d(level.var_ec1690fd.origin3 + (0, 0, 30), level.var_ec1690fd.text3);
            }
        }
    }

    // Namespace prop_dev
    // Params 4, eflags: 0x0
    // Checksum 0x868dbd0, Offset: 0x6c50
    // Size: 0x19c
    function function_b2eba1e3(propinfo, origin, angles, team) {
        var_a20cbf64 = spawn("<dev string:x1319>", origin);
        var_a20cbf64.targetname = "<dev string:x1326>";
        var_a20cbf64 setmodel(propinfo.modelname);
        var_a20cbf64 setscale(propinfo.propscale, 1);
        var_a20cbf64.angles = angles;
        var_a20cbf64 setcandamage(1);
        var_a20cbf64.fakehealth = 50;
        var_a20cbf64.health = 99999;
        var_a20cbf64.maxhealth = 99999;
        var_a20cbf64 thread prop::function_500dc7d9(&prop_controls::damageclonewatch);
        var_a20cbf64 setplayercollision(0);
        var_a20cbf64 makesentient();
        var_a20cbf64 function_344baafe();
        var_a20cbf64 setteam(team);
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x5e43d0eb, Offset: 0x6df8
    // Size: 0x268
    function function_9b9725b1() {
        player = level.players[0];
        angles = player.angles;
        dir = anglestoforward(angles);
        origin = player.origin + (0, 0, 100);
        if (isdefined(level.var_79ca1379)) {
            foreach (clone in level.var_79ca1379) {
                clone prop_controls::function_a40d8853();
            }
        }
        level.var_79ca1379 = [];
        foreach (category in level.proplist) {
            foreach (propinfo in category) {
                level.var_79ca1379[level.var_79ca1379.size] = function_b2eba1e3(propinfo, origin, angles, util::getotherteam(player.team));
                origin += dir * 60;
            }
        }
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0xfbc664a3, Offset: 0x7068
    // Size: 0x11e
    function function_6863880e() {
        player = level.players[0];
        angles = player.angles;
        dir = anglestoforward(angles);
        origin = player.origin + dir * (0, 0, 100);
        propinfo = prop::getnextprop(player);
        if (!isdefined(level.var_79ca1379)) {
            level.var_79ca1379 = [];
        }
        level.var_79ca1379[level.var_79ca1379.size] = function_b2eba1e3(propinfo, origin, angles, util::getotherteam(player.team));
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x69dc4cdd, Offset: 0x7190
    // Size: 0xf2
    function showplayers() {
        if (!isdefined(level.players)) {
            return;
        }
        foreach (player in level.players) {
            box(player.origin, player getmins(), player getmaxs(), player.angles[1], (1, 0, 1), 1, 0, 1);
        }
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x9a50efeb, Offset: 0x7290
    // Size: 0xd6
    function showtargets() {
        if (!isdefined(level.var_e5ad813f) || !isdefined(level.var_e5ad813f.targets)) {
            return;
        }
        for (i = 0; i < level.var_e5ad813f.targets.size; i++) {
            target = level.var_e5ad813f.targets[i];
            if (isdefined(target)) {
                print3d(target.origin + (0, 0, 30), "<dev string:xae6>" + target.fakehealth);
            }
        }
    }

#/
