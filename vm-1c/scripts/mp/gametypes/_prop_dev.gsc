#using scripts/shared/bots/_bot;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/gametypes/prop;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_prop_controls;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_globallogic_spawn;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_dogtags;
#using scripts/mp/_util;
#using scripts/mp/_teamops;

#namespace prop_dev;

/#

    // Namespace prop_dev
    // Params 2, eflags: 0x0
    // Checksum 0x10ee84f4, Offset: 0x340
    // Size: 0x9c
    function adddevguicommand(path, var_66e49a4e) {
        pathstr = "<unknown string>" + path + "<unknown string>";
        cmdstr = "<unknown string>" + var_66e49a4e + "<unknown string>";
        debugcommand = "<unknown string>" + pathstr + "<unknown string>" + cmdstr;
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
        minigame_on = getdvarint("<unknown string>", 1);
        server_hud = getdvarint("<unknown string>", 1);
        var_100dc1ab = getdvarfloat("<unknown string>");
        util::set_dvar_int_if_unset("<unknown string>", 0);
        util::set_dvar_int_if_unset("<unknown string>", 0);
        util::set_dvar_int_if_unset("<unknown string>", 0);
        util::set_dvar_int_if_unset("<unknown string>", 0);
        util::set_dvar_int_if_unset("<unknown string>", 0);
        util::set_dvar_int_if_unset("<unknown string>", 0);
        util::set_dvar_int_if_unset("<unknown string>", 0);
        util::set_dvar_int_if_unset("<unknown string>", 0);
        util::set_dvar_int_if_unset("<unknown string>", 0);
        util::set_dvar_int_if_unset("<unknown string>", 0);
        util::set_dvar_int_if_unset("<unknown string>", 0);
        util::set_dvar_int_if_unset("<unknown string>", 1);
        util::set_dvar_int_if_unset("<unknown string>", 1);
        util::set_dvar_int_if_unset("<unknown string>", 0);
        util::set_dvar_int_if_unset("<unknown string>", 0);
        util::set_dvar_int_if_unset("<unknown string>", 0);
        util::set_dvar_int_if_unset("<unknown string>", 0);
        util::set_dvar_int_if_unset("<unknown string>", 0);
        util::set_dvar_int_if_unset("<unknown string>", 0);
        util::set_dvar_int_if_unset("<unknown string>", 0);
        util::set_dvar_int_if_unset("<unknown string>", 0);
        setdvar("<unknown string>", 0);
        setdvar("<unknown string>", 0);
        setdvar("<unknown string>", 0);
        setdvar("<unknown string>", 0);
        setdvar("<unknown string>", 0);
        setdvar("<unknown string>", 0);
        setdvar("<unknown string>", 0);
        setdvar("<unknown string>", 0);
        if (getdvarint("<unknown string>", 0) != 0) {
            adddebugcommand("<unknown string>");
        }
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>" + 4 + "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>" + 0.25 + "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        adddevguicommand("<unknown string>", "<unknown string>");
        while (true) {
            if (isdefined(level.prematch_over) && level.prematch_over) {
                level.allow_teamchange = "<unknown string>" + getdvarint("<unknown string>", 0);
                level.var_2898ef72 = getdvarint("<unknown string>", 0) != 0;
            }
            if (getdvarint("<unknown string>", 0) != server_hud && isdefined(level.players)) {
                server_hud = getdvarint("<unknown string>", 0);
                if (!isdefined(level.players[0].changepropkey)) {
                    iprintlnbold("<unknown string>");
                } else {
                    foreach (player in level.players) {
                        if (isdefined(player.team) && player util::isprop()) {
                            player prop_controls::propabilitykeysvisible(server_hud, 1);
                        }
                    }
                    level.elim_hud.alpha = server_hud;
                }
            }
            if (getdvarint("<unknown string>", 0) != var_ccd61088 && isdefined(level.players)) {
                foreach (player in level.players) {
                    if (player util::isprop()) {
                        var_ccd61088 = getdvarint("<unknown string>", 0);
                        player.var_c4494f8d = !(isdefined(player.var_c4494f8d) && player.var_c4494f8d);
                        player iprintlnbold(player.var_c4494f8d ? "<unknown string>" : "<unknown string>");
                    }
                }
            }
            if (getdvarint("<unknown string>", 0) != var_6c9fc047 && isdefined(level.players)) {
                foreach (player in level.players) {
                    if (player util::isprop()) {
                        var_6c9fc047 = getdvarint("<unknown string>", 0);
                        player.var_b53602f4 = !(isdefined(player.var_b53602f4) && player.var_b53602f4);
                        player iprintlnbold(player.var_b53602f4 ? "<unknown string>" : "<unknown string>");
                    }
                }
            }
            if (getdvarint("<unknown string>", 0) != var_f0760dd5 && isdefined(level.players)) {
                foreach (player in level.players) {
                    if (player util::isprop()) {
                        var_f0760dd5 = getdvarint("<unknown string>", 0);
                        player.var_2f1101f4 = !(isdefined(player.var_2f1101f4) && player.var_2f1101f4);
                        player iprintlnbold(player.var_2f1101f4 ? "<unknown string>" : "<unknown string>");
                    }
                }
            }
            if (getdvarint("<unknown string>", 0) != var_8c45c976) {
                var_8c45c976 = getdvarint("<unknown string>", 0);
                if (var_8c45c976) {
                    setdvar("<unknown string>", 1);
                    setdvar("<unknown string>", 1);
                    setdvar("<unknown string>", 10000);
                } else {
                    setdvar("<unknown string>", 1600);
                    setdvar("<unknown string>", 1000);
                    setdvar("<unknown string>", 400);
                    iprintlnbold(var_8c45c976 ? "<unknown string>" : "<unknown string>");
                }
            }
            if (getdvarint("<unknown string>", 0) != var_fe10d650 && isdefined(level.players)) {
                foreach (player in level.players) {
                    if (player prop::function_e4b2f23()) {
                        var_fe10d650 = getdvarint("<unknown string>", 0);
                        player.var_74ca9cd1 = !(isdefined(player.var_74ca9cd1) && player.var_74ca9cd1);
                        player iprintlnbold(player.var_74ca9cd1 ? "<unknown string>" : "<unknown string>");
                    }
                }
            }
            isremoved = getdvarint("<unknown string>", 0);
            if (isremoved != var_b58392ae) {
                var_b58392ae = isremoved;
                function_f35dfc64(!isremoved);
            }
            var_504c9134 = getdvarint("<unknown string>", 0);
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
            if (getdvarint("<unknown string>", 0) != 0) {
                function_543336f9();
                setdvar("<unknown string>", 0);
            }
            if (getdvarint("<unknown string>", 0) != 0) {
                function_a8147bf9();
                setdvar("<unknown string>", 0);
            }
            if (getdvarint("<unknown string>", 0) != 0) {
                function_1a022b4b();
                setdvar("<unknown string>", 0);
            }
            if (getdvarint("<unknown string>", 0) != 0) {
                if (isdefined(level.players) && isdefined(level.players[0])) {
                    level thread prop::function_435d5169(%"<unknown string>", level.players[0]);
                }
                setdvar("<unknown string>", 0);
            }
            if (getdvarint("<unknown string>", 0) != 0) {
                function_276ad638();
            }
            if (getdvarint("<unknown string>", 0)) {
                function_b02387d6();
            }
            if (getdvarint("<unknown string>", 0) != 0) {
                function_ad9aebcc();
                setdvar("<unknown string>", 0);
            }
            if (getdvarint("<unknown string>", 0) != 0) {
                if (isdefined(level.players) && isdefined(level.players[0])) {
                    level.players[0] prop_controls::canlock();
                }
            }
            if (getdvarint("<unknown string>", 0) != 0 || getdvarint("<unknown string>", 0) != 0) {
                function_36895abd();
            }
            if (getdvarint("<unknown string>", 0) != 0) {
                function_6863880e();
                setdvar("<unknown string>", 0);
            }
            if (getdvarint("<unknown string>", 0) != 0) {
                function_9b9725b1();
                setdvar("<unknown string>", 0);
            }
            if (getdvarint("<unknown string>", 0) != 0 && isdefined(level.players)) {
                foreach (player in level.players) {
                    player notify(#"cancelcountdown");
                }
                setdvar("<unknown string>", 0);
            }
            if (getdvarint("<unknown string>", 0) != 0) {
                function_b52ad1b2();
            }
            if (getdvarint("<unknown string>", 0) != 0) {
                showplayers();
            }
            if (getdvarint("<unknown string>", 0) != 0) {
                showtargets();
            }
            if (getdvarint("<unknown string>", 1) != minigame_on && isdefined(level.players) && level.players.size > 0) {
                minigame_on = getdvarint("<unknown string>", 1);
                iprintlnbold(minigame_on ? "<unknown string>" : "<unknown string>");
            }
            if (getdvarint("<unknown string>", 0) != var_74fced3d && isdefined(level.players) && level.players.size > 0) {
                var_74fced3d = getdvarint("<unknown string>", 0);
                if (var_74fced3d == 2) {
                    iprintlnbold("<unknown string>");
                } else if (var_74fced3d == 1) {
                    iprintlnbold("<unknown string>");
                } else {
                    iprintlnbold("<unknown string>");
                }
            }
            wait(0.05);
        }
    }

    // Namespace prop_dev
    // Params 1, eflags: 0x0
    // Checksum 0xd6fdb526, Offset: 0x1b10
    // Size: 0xec
    function function_f35dfc64(enabled) {
        setdvar("<unknown string>", enabled);
        setdvar("<unknown string>", enabled);
        setdvar("<unknown string>", enabled);
        setdvar("<unknown string>", enabled);
        setdvar("<unknown string>", enabled);
        setdvar("<unknown string>", enabled);
        setdvar("<unknown string>", enabled);
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
        self.var_c9f40191 = function_e7f343ff(white, %"<unknown string>", self.prop.info.proprange);
        self.var_40dabe6f = function_e7f343ff(white, %"<unknown string>", self.prop.info.propheight);
        self.var_f1fdc495 = function_e7f343ff(white, %"<unknown string>", self.prop.info.anglesoffset[2]);
        self.var_e7ec6bb6 = function_e7f343ff(white, %"<unknown string>", self.prop.info.anglesoffset[1]);
        self.var_3e02b967 = function_e7f343ff(white, %"<unknown string>", self.prop.info.anglesoffset[0]);
        self.var_381d73f7 = function_e7f343ff(blue, %"<unknown string>", self.prop.info.xyzoffset[2]);
        self.var_c61604bc = function_e7f343ff(green, %"<unknown string>", self.prop.info.xyzoffset[1]);
        self.var_ec187f25 = function_e7f343ff(red, %"<unknown string>", self.prop.info.xyzoffset[0]);
        self.var_f3f7c094 = function_e7f343ff(white, %"<unknown string>", self.prop.info.propscale);
        self.var_6b04bc54 = function_e7f343ff(white, %"<unknown string>", self.prop.info.propsize);
        self.var_b97b612d = function_e7f343ff(white, undefined, undefined, "<unknown string>" + self.prop.info.propsizetext);
        self.placementmodel = function_e7f343ff(white, undefined, undefined, "<unknown string>" + self.var_4efaa35 + "<unknown string>" + self.prop.info.modelname);
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
        setdvar("<unknown string>", 0);
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
            wait(0.05);
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
            msg = self util::waittill_any_return("<unknown string>", "<unknown string>", "<unknown string>", "<unknown string>", "<unknown string>");
            if (!isdefined(msg)) {
                continue;
            }
            if (msg == "<unknown string>") {
                self function_6049bca3(-1);
                continue;
            }
            if (msg == "<unknown string>") {
                self function_6049bca3(1);
                continue;
            }
            if (msg == "<unknown string>") {
                self function_a24562f8(1);
                continue;
            }
            if (msg == "<unknown string>") {
                self function_a24562f8(-1);
                continue;
            }
            if (msg == "<unknown string>") {
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
        wait(0.5);
        while (true) {
            function_9c8c6fe4(val);
            wait(0.05);
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
        wait(0.5);
        while (true) {
            function_8bdc662f(val);
            wait(0.05);
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
            self.placementmodel settext("<unknown string>" + self.var_4efaa35 + "<unknown string>" + self.prop.info.modelname);
            self.var_b97b612d settext("<unknown string>" + self.prop.info.propsizetext);
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
            sizes = array("<unknown string>", "<unknown string>", "<unknown string>", "<unknown string>", "<unknown string>", "<unknown string>");
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
            self.var_b97b612d settext("<unknown string>" + self.prop.info.propsizetext);
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
        self prop_controls::notifyonplayercommand("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommand("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommand("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommand("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommand("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommand("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommand("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommand("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommand("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommand("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommand("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommand("<unknown string>", "<unknown string>");
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0xf5d14f24, Offset: 0x3cb8
    // Size: 0x1e4
    function function_4e71de66() {
        self prop_controls::notifyonplayercommandremove("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommandremove("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommandremove("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommandremove("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommandremove("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommandremove("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommandremove("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommandremove("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommandremove("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommandremove("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommandremove("<unknown string>", "<unknown string>");
        self prop_controls::notifyonplayercommandremove("<unknown string>", "<unknown string>");
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
        propstr = "<unknown string>" + propinfo.modelname + "<unknown string>" + propinfo.propsizetext + "<unknown string>" + propinfo.propscale;
        if (function_b7096a63(propinfo.xyzoffset)) {
            propstr += "<unknown string>" + propinfo.xyzoffset[0] + "<unknown string>" + propinfo.xyzoffset[1] + "<unknown string>" + propinfo.xyzoffset[2];
        } else {
            propstr += "<unknown string>";
        }
        if (function_b7096a63(propinfo.anglesoffset)) {
            propstr += "<unknown string>" + propinfo.anglesoffset[0] + "<unknown string>" + propinfo.anglesoffset[1] + "<unknown string>" + propinfo.anglesoffset[2];
        } else {
            propstr += "<unknown string>";
        }
        if (function_f0e744af(propinfo)) {
            propstr += "<unknown string>" + propinfo.propheight;
        } else {
            propstr += "<unknown string>" + prop::getthirdpersonheightoffsetforsize(propinfo.propsize);
        }
        if (function_52e4c413(propinfo)) {
            propstr += "<unknown string>" + propinfo.proprange;
        } else {
            propstr += "<unknown string>" + prop::getthirdpersonrangeforsize(propinfo.propsize);
        }
        fprintln(file, propstr);
    }

    // Namespace prop_dev
    // Params 2, eflags: 0x0
    // Checksum 0x645efcda, Offset: 0x4270
    // Size: 0x5c
    function function_90b01d01(file, propinfo) {
        propstr = "<unknown string>" + propinfo.modelname + "<unknown string>";
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
        var_7b625b5a = var_dc7b1be6 + "<unknown string>";
        var_74036302 = var_dc7b1be6 + "<unknown string>";
        var_11e4d40d = var_dc7b1be6 + "<unknown string>";
        var_9f31b917 = level.script + "<unknown string>";
        var_a0b36f12 = level.script + "<unknown string>";
        var_43a6e14b = "<unknown string>";
        var_6da36d3e = "<unknown string>";
        var_586b7057 = "<unknown string>";
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>" + var_7b625b5a + "<unknown string>");
        fprintln(file, "<unknown string>" + var_74036302 + "<unknown string>");
        fprintln(file, "<unknown string>" + var_11e4d40d + "<unknown string>" + var_43a6e14b);
        fprintln(file, "<unknown string>" + var_7b625b5a + "<unknown string>" + var_586b7057);
        fprintln(file, "<unknown string>" + var_74036302 + "<unknown string>" + var_6da36d3e);
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>" + var_9f31b917 + "<unknown string>" + var_dc7b1be6);
        fprintln(file, "<unknown string>" + var_a0b36f12 + "<unknown string>" + var_74036302 + "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0x1b15aca1, Offset: 0x4868
    // Size: 0x3c4
    function function_543336f9() {
        platform = "<unknown string>";
        if (level.orbis) {
            platform = "<unknown string>";
        } else if (level.durango) {
            platform = "<unknown string>";
        }
        var_dc7b1be6 = level.script + "<unknown string>";
        var_7b625b5a = var_dc7b1be6 + "<unknown string>";
        var_36b45864 = "<unknown string>" + platform + "<unknown string>";
        var_586b7057 = "<unknown string>";
        file = openfile(var_7b625b5a, "<unknown string>");
        if (file == -1) {
            iprintlnbold("<unknown string>" + var_36b45864 + var_7b625b5a + "<unknown string>");
            println("<unknown string>" + var_36b45864 + var_7b625b5a + "<unknown string>");
            return;
        }
        function_d3a80896(file, var_dc7b1be6);
        fprintln(file, "<unknown string>");
        function_74e29250(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        function_74e29250(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        function_74e29250(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        function_74e29250(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        function_74e29250(file, "<unknown string>");
        iprintlnbold("<unknown string>" + var_36b45864 + var_7b625b5a + "<unknown string>" + var_586b7057);
        println("<unknown string>" + var_36b45864 + var_7b625b5a + "<unknown string>" + var_586b7057);
        closefile(file);
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0xc289c660, Offset: 0x4c38
    // Size: 0x3a4
    function function_a8147bf9() {
        platform = "<unknown string>";
        if (level.orbis) {
            platform = "<unknown string>";
        } else if (level.durango) {
            platform = "<unknown string>";
        }
        var_dc7b1be6 = level.script + "<unknown string>";
        var_7b625b5a = var_dc7b1be6 + "<unknown string>";
        var_36b45864 = "<unknown string>" + platform + "<unknown string>";
        var_586b7057 = "<unknown string>";
        file = openfile(var_7b625b5a, "<unknown string>");
        if (file == -1) {
            iprintlnbold("<unknown string>" + var_36b45864 + var_7b625b5a + "<unknown string>");
            println("<unknown string>" + var_36b45864 + var_7b625b5a + "<unknown string>");
            return;
        }
        fprintln(file, "<unknown string>");
        function_bce1e8ea(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        function_bce1e8ea(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        function_bce1e8ea(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        function_bce1e8ea(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        function_bce1e8ea(file, "<unknown string>");
        iprintlnbold("<unknown string>" + var_36b45864 + var_7b625b5a + "<unknown string>" + var_586b7057);
        println("<unknown string>" + var_36b45864 + var_7b625b5a + "<unknown string>" + var_586b7057);
        closefile(file);
    }

    // Namespace prop_dev
    // Params 0, eflags: 0x0
    // Checksum 0xaa973459, Offset: 0x4fe8
    // Size: 0xc54
    function function_1a022b4b() {
        platform = "<unknown string>";
        if (level.orbis) {
            platform = "<unknown string>";
        } else if (level.durango) {
            platform = "<unknown string>";
        }
        var_dc7b1be6 = level.script + "<unknown string>";
        var_7b625b5a = var_dc7b1be6 + "<unknown string>";
        var_74036302 = var_dc7b1be6 + "<unknown string>";
        var_11e4d40d = var_dc7b1be6 + "<unknown string>";
        var_9f31b917 = level.script + "<unknown string>";
        var_a0b36f12 = level.script + "<unknown string>";
        var_36b45864 = "<unknown string>" + platform + "<unknown string>";
        var_43a6e14b = "<unknown string>";
        var_6da36d3e = "<unknown string>";
        var_586b7057 = "<unknown string>";
        file = openfile(var_7b625b5a, "<unknown string>");
        if (file == -1) {
            iprintlnbold("<unknown string>" + var_36b45864 + var_7b625b5a + "<unknown string>");
            println("<unknown string>" + var_36b45864 + var_7b625b5a + "<unknown string>");
            return;
        }
        function_d3a80896(file, var_dc7b1be6);
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        closefile(file);
        file = openfile(var_74036302, "<unknown string>");
        if (file == -1) {
            iprintlnbold("<unknown string>" + var_36b45864 + var_74036302 + "<unknown string>");
            println("<unknown string>" + var_36b45864 + var_74036302 + "<unknown string>");
            return;
        }
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        fprintln(file, "<unknown string>");
        closefile(file);
        file = openfile(var_11e4d40d, "<unknown string>");
        if (file == -1) {
            iprintlnbold("<unknown string>" + var_36b45864 + var_11e4d40d + "<unknown string>");
            println("<unknown string>" + var_36b45864 + var_11e4d40d + "<unknown string>");
            return;
        }
        fprintln(file, "<unknown string>" + var_7b625b5a);
        fprintln(file, "<unknown string>" + var_74036302);
        closefile(file);
        iprintlnbold("<unknown string>" + var_36b45864);
        println("<unknown string>" + var_36b45864);
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
        if (!isdefined(enemybot.pers["<unknown string>"])) {
            enemybot.pers["<unknown string>"] = 0;
        }
        if (!isdefined(enemybot.hits)) {
            enemybot.hits = 0;
        }
        setdvar("<unknown string>", 0);
        setdvar("<unknown string>", 0);
        player.health = player.maxhealth;
        weapon = getweapon("<unknown string>");
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
        player util::waittill_notify_or_timeout("<unknown string>", 0.3);
        wait(0.5);
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
            if (isdefined(player) && isdefined(player.team) && player.team == game["<unknown string>"]) {
                print3d(player.origin + (0, 0, 50), "<unknown string>" + player.health);
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
            print3d(player.origin + (0, 0, 50), "<unknown string>" + speed);
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
        propent = spawn("<unknown string>", origin);
        propent setcontents(0);
        propent notsolid();
        propent setplayercollision(0);
        prop = spawn("<unknown string>", propent.origin);
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
    function function_ad9aebcc() {
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
        var_a20cbf64 = spawn("<unknown string>", origin);
        var_a20cbf64.targetname = "<unknown string>";
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
                print3d(target.origin + (0, 0, 30), "<unknown string>" + target.fakehealth);
            }
        }
    }

#/
