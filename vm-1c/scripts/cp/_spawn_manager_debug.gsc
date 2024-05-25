#using scripts/cp/_spawn_manager;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace spawn_manager;

/#

    // Namespace spawn_manager
    // Params 0, eflags: 0x1 linked
    // Checksum 0x446e2b77, Offset: 0xd0
    // Size: 0x220
    function function_573de556() {
        for (;;) {
            if (getdvarstring("<unknown string>") != "<unknown string>") {
                wait(0.1);
                continue;
            }
            managers = function_1d528fc9();
            var_d50e154d = 0;
            var_d82333c2 = 0;
            level.var_cbea0384 = [];
            for (i = 0; i < managers.size; i++) {
                if (isdefined(managers[i]) && isdefined(managers[i].enable)) {
                    if (!managers[i].enable && (managers[i].enable || isdefined(managers[i].spawners))) {
                        if (managers[i].count < 0 || managers[i].count > managers[i].spawncount) {
                            if (managers[i].enable && isdefined(managers[i].var_ee45dcd6)) {
                                var_d50e154d += 1;
                                var_d82333c2 += managers[i].var_ee45dcd6;
                            }
                            level.var_cbea0384[level.var_cbea0384.size] = managers[i];
                        }
                    }
                }
            }
            function_6d2d8da0(level.var_ad131964, level.var_9eb6e779, level.var_b5b6bce6, var_d50e154d, var_d82333c2);
            wait(0.05);
        }
    }

    // Namespace spawn_manager
    // Params 5, eflags: 0x1 linked
    // Checksum 0xf3c375e1, Offset: 0x2f8
    // Size: 0x636
    function function_6d2d8da0(var_9f308938, spawn_ai, max_ai, var_744eb752, var_699e3746) {
        if (getdvarstring("<unknown string>") == "<unknown string>") {
            if (!isdefined(level.var_854c9d7)) {
                level.var_854c9d7 = newhudelem();
                level.var_854c9d7.alignx = "<unknown string>";
                level.var_854c9d7.x = 2;
                level.var_854c9d7.y = 40;
                level.var_854c9d7.fontscale = 1.5;
                level.var_854c9d7.color = (1, 1, 1);
            }
            if (!isdefined(level.var_c254bbec)) {
                level.var_c254bbec = [];
            }
            level.var_854c9d7 settext("<unknown string>" + spawn_ai + "<unknown string>" + var_9f308938 + "<unknown string>" + var_699e3746 + "<unknown string>" + max_ai + "<unknown string>" + var_744eb752);
            for (i = 0; i < level.var_cbea0384.size; i++) {
                if (!isdefined(level.var_c254bbec[i])) {
                    level.var_c254bbec[i] = newhudelem();
                    level.var_c254bbec[i].alignx = "<unknown string>";
                    level.var_c254bbec[i].x = 0;
                    level.var_c254bbec[i].fontscale = 1;
                    level.var_c254bbec[i].y = level.var_854c9d7.y + (i + 1) * 15;
                }
                if (isdefined(level.var_ec52af9c) && level.var_cbea0384[i] == level.var_ec52af9c) {
                    if (!level.var_cbea0384[i].enable) {
                        level.var_c254bbec[i].color = (0, 0.4, 0);
                    } else {
                        level.var_c254bbec[i].color = (0, 1, 0);
                    }
                } else if (level.var_cbea0384[i].enable) {
                    level.var_c254bbec[i].color = (1, 1, 1);
                } else {
                    level.var_c254bbec[i].color = (0.4, 0.4, 0.4);
                }
                text = "<unknown string>" + level.var_cbea0384[i].sm_id + "<unknown string>";
                text += "<unknown string>" + level.var_cbea0384[i].spawncount;
                text += "<unknown string>" + level.var_cbea0384[i].var_e5c2eec1.size + "<unknown string>" + level.var_cbea0384[i].var_5fa59123 + "<unknown string>" + level.var_cbea0384[i].var_e290d32d + "<unknown string>";
                text += "<unknown string>" + level.var_cbea0384[i].var_d8202611.size;
                if (isdefined(level.var_cbea0384[i].var_bf8006e3)) {
                    text += "<unknown string>" + level.var_cbea0384[i].var_bf8006e3 + "<unknown string>" + level.var_cbea0384[i].var_4d210f7a + "<unknown string>" + level.var_cbea0384[i].var_20149b34 + "<unknown string>";
                }
                level.var_c254bbec[i] settext(text);
            }
            if (level.var_cbea0384.size < level.var_c254bbec.size) {
                for (i = level.var_cbea0384.size; i < level.var_c254bbec.size; i++) {
                    if (isdefined(level.var_c254bbec[i])) {
                        level.var_c254bbec[i] destroy();
                    }
                }
            }
        }
        if (getdvarstring("<unknown string>") != "<unknown string>") {
            if (isdefined(level.var_854c9d7)) {
                level.var_854c9d7 destroy();
            }
            if (isdefined(level.var_c254bbec)) {
                for (i = 0; i < level.var_c254bbec.size; i++) {
                    if (isdefined(level.var_c254bbec) && isdefined(level.var_c254bbec[i])) {
                        level.var_c254bbec[i] destroy();
                    }
                }
                level.var_c254bbec = undefined;
            }
        }
    }

    // Namespace spawn_manager
    // Params 0, eflags: 0x1 linked
    // Checksum 0xdf8555b3, Offset: 0x938
    // Size: 0x1c
    function on_player_connect() {
        level thread function_2111823a();
    }

    // Namespace spawn_manager
    // Params 0, eflags: 0x1 linked
    // Checksum 0xfbf28bc6, Offset: 0x960
    // Size: 0x328
    function function_2111823a() {
        level notify(#"hash_2111823a");
        level endon(#"hash_2111823a");
        level.var_ec52af9c = undefined;
        level.var_8955ab4d = undefined;
        level.test_player = getplayers()[0];
        var_5b543fb5 = -1;
        var_1609b915 = undefined;
        while (true) {
            if (getdvarstring("<unknown string>") != "<unknown string>") {
                function_10c561e2();
                wait(0.05);
                continue;
            }
            if (isdefined(level.var_cbea0384) && level.var_cbea0384.size > 0) {
                if (var_5b543fb5 == -1) {
                    var_5b543fb5 = 0;
                    var_1609b915 = 0;
                }
                if (level.test_player buttonpressed("<unknown string>")) {
                    var_1609b915 = var_5b543fb5;
                    if (level.test_player buttonpressed("<unknown string>")) {
                        var_5b543fb5--;
                        if (var_5b543fb5 < 0) {
                            var_5b543fb5 = 0;
                        }
                    }
                    if (level.test_player buttonpressed("<unknown string>")) {
                        var_5b543fb5++;
                        if (var_5b543fb5 > level.var_cbea0384.size - 1) {
                            var_5b543fb5 = level.var_cbea0384.size - 1;
                        }
                    }
                }
                if (isdefined(var_5b543fb5) && var_5b543fb5 != -1) {
                    if (isdefined(level.var_ec52af9c) && isdefined(level.var_cbea0384[var_5b543fb5])) {
                        if (isdefined(var_1609b915) && var_1609b915 == var_5b543fb5) {
                            if (level.var_cbea0384[var_5b543fb5].targetname != level.var_8955ab4d) {
                                for (i = 0; i < level.var_cbea0384.size; i++) {
                                    if (level.var_cbea0384[i].targetname == level.var_8955ab4d) {
                                        var_5b543fb5 = i;
                                        var_1609b915 = i;
                                    }
                                }
                            }
                        }
                    }
                    if (isdefined(level.var_cbea0384[var_5b543fb5])) {
                        level.var_ec52af9c = level.var_cbea0384[var_5b543fb5];
                        level.var_8955ab4d = level.var_cbea0384[var_5b543fb5].targetname;
                    }
                }
                if (isdefined(level.var_ec52af9c)) {
                    level.var_ec52af9c function_2adbfa39();
                }
            } else {
                function_10c561e2();
            }
            wait(0.25);
        }
    }

    // Namespace spawn_manager
    // Params 0, eflags: 0x0
    // Checksum 0x348bc46b, Offset: 0xc90
    // Size: 0x20c
    function function_bad6361c() {
        while (true) {
            if (getdvarstring("<unknown string>") != "<unknown string>") {
                wait(0.1);
                continue;
            }
            if (isdefined(level.var_ec52af9c)) {
                spawn_manager = level.var_ec52af9c;
                if (isdefined(spawn_manager.spawners)) {
                    for (i = 0; i < spawn_manager.spawners.size; i++) {
                        current_spawner = spawn_manager.spawners[i];
                        if (isdefined(current_spawner) && current_spawner.count > 0) {
                            var_70296209 = current_spawner.var_ee45dcd6 - current_spawner.var_e5c2eec1.size;
                            print3d(current_spawner.origin + (0, 0, 65), "<unknown string>" + current_spawner.count, (0, 1, 0), 1, 1.25, 2);
                            print3d(current_spawner.origin + (0, 0, 85), "<unknown string>" + current_spawner.var_e5c2eec1.size + "<unknown string>" + var_70296209 + "<unknown string>" + current_spawner.var_ee45dcd6, (0, 1, 0), 1, 1.25, 2);
                        }
                    }
                }
                wait(0.05);
            }
            wait(0.05);
        }
    }

    // Namespace spawn_manager
    // Params 1, eflags: 0x0
    // Checksum 0xa51ca00, Offset: 0xea8
    // Size: 0x78
    function function_228116ac(text) {
        self endon(#"death");
        while (true) {
            print3d(self.origin + (0, 0, 65), text, (0.48, 9.4, 0.76), 1, 1);
            wait(0.05);
        }
    }

    // Namespace spawn_manager
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf35deb89, Offset: 0xf28
    // Size: 0xbcc
    function function_2adbfa39() {
        if (!isdefined(level.var_75b3119)) {
            level.var_75b3119 = 0;
        }
        if (!isdefined(level.var_c34122c6)) {
            level.var_c34122c6 = newhudelem();
            level.var_c34122c6.alignx = "<unknown string>";
            level.var_c34122c6.x = 10;
            level.var_c34122c6.y = -106;
            level.var_c34122c6.fontscale = 1.25;
            level.var_c34122c6.color = (1, 0, 0);
        }
        if (!isdefined(level.var_73af57cd)) {
            level.var_73af57cd = newhudelem();
            level.var_73af57cd.alignx = "<unknown string>";
            level.var_73af57cd.x = 10;
            level.var_73af57cd.y = -91;
            level.var_73af57cd.color = (1, 1, 1);
        }
        if (!isdefined(level.var_470c2455)) {
            level.var_470c2455 = newhudelem();
            level.var_470c2455.alignx = "<unknown string>";
            level.var_470c2455.x = 10;
            level.var_470c2455.y = -76;
            level.var_470c2455.color = (1, 1, 1);
        }
        if (!isdefined(level.var_c4b2df6b)) {
            level.var_c4b2df6b = newhudelem();
            level.var_c4b2df6b.alignx = "<unknown string>";
            level.var_c4b2df6b.x = 10;
            level.var_c4b2df6b.y = -61;
            level.var_c4b2df6b.color = (1, 1, 1);
        }
        if (!isdefined(level.var_a268b598)) {
            level.var_a268b598 = newhudelem();
            level.var_a268b598.alignx = "<unknown string>";
            level.var_a268b598.x = 10;
            level.var_a268b598.y = -46;
            level.var_a268b598.color = (1, 1, 1);
        }
        if (!isdefined(level.var_8c831eb6)) {
            level.var_8c831eb6 = newhudelem();
            level.var_8c831eb6.alignx = "<unknown string>";
            level.var_8c831eb6.x = 10;
            level.var_8c831eb6.y = -31;
            level.var_8c831eb6.color = (1, 1, 1);
        }
        if (!isdefined(level.var_471f36bf)) {
            level.var_471f36bf = newhudelem();
            level.var_471f36bf.alignx = "<unknown string>";
            level.var_471f36bf.x = 10;
            level.var_471f36bf.y = -16;
            level.var_471f36bf.color = (1, 1, 1);
        }
        if (!isdefined(level.var_7a568a0f)) {
            level.var_7a568a0f = newhudelem();
            level.var_7a568a0f.alignx = "<unknown string>";
            level.var_7a568a0f.x = 10;
            level.var_7a568a0f.y = -1;
            level.var_7a568a0f.color = (1, 1, 1);
        }
        if (!isdefined(level.var_5ba78cd1)) {
            level.var_5ba78cd1 = newhudelem();
            level.var_5ba78cd1.alignx = "<unknown string>";
            level.var_5ba78cd1.x = 10;
            level.var_5ba78cd1.y = 270;
            level.var_5ba78cd1.color = (1, 1, 1);
        }
        if (level.test_player buttonpressed("<unknown string>")) {
            if (level.test_player buttonpressed("<unknown string>")) {
                level.var_75b3119++;
                if (level.var_75b3119 > 7) {
                    level.var_75b3119 = 7;
                }
            }
            if (level.test_player buttonpressed("<unknown string>")) {
                level.var_75b3119--;
                if (level.var_75b3119 < 0) {
                    level.var_75b3119 = 0;
                }
            }
        }
        function_facd2f34();
        var_e92907e3 = 0;
        var_d1c37f1b = 0;
        if (level.test_player buttonpressed("<unknown string>")) {
            if (level.test_player buttonpressed("<unknown string>")) {
                var_d1c37f1b = 1;
            }
            if (level.test_player buttonpressed("<unknown string>")) {
                var_e92907e3 = 1;
            }
        }
        var_c4554a8d = 0;
        if (var_e92907e3 || var_d1c37f1b) {
            if (var_e92907e3) {
                add = 1;
            } else {
                add = -1;
            }
            switch (level.var_75b3119) {
            case 0:
                if (self.var_ee45dcd6 + add > self.var_e290d32d) {
                    self.var_e290d32d = self.var_ee45dcd6 + add;
                }
                if (self.var_ee45dcd6 + add < self.var_5fa59123) {
                    if (self.var_ee45dcd6 + add > 0) {
                        self.var_5fa59123 = self.var_ee45dcd6 + add;
                    }
                }
                var_c4554a8d = 1;
                self.var_ee45dcd6 += add;
                break;
            case 1:
                if (self.var_5fa59123 + add < self.var_20149b34) {
                    function_fed43545("<unknown string>");
                    break;
                }
                if (self.var_5fa59123 + add > self.var_e290d32d) {
                    function_fed43545("<unknown string>");
                    break;
                }
                var_c4554a8d = 1;
                self.var_5fa59123 += add;
                break;
            case 2:
                if (self.var_e290d32d + add < self.var_5fa59123) {
                    function_fed43545("<unknown string>");
                    break;
                }
                var_c4554a8d = 1;
                self.var_e290d32d += add;
                break;
            case 3:
                if (self.var_4d210f7a + add > self.var_20149b34) {
                    function_fed43545("<unknown string>");
                    break;
                }
                var_c4554a8d = 1;
                self.var_4d210f7a += add;
                break;
            case 4:
                if (self.var_20149b34 + add < self.var_4d210f7a) {
                    function_fed43545("<unknown string>");
                    break;
                }
                if (self.var_20149b34 + add > self.var_ee45dcd6) {
                    function_fed43545("<unknown string>");
                    break;
                }
                var_c4554a8d = 1;
                self.var_20149b34 += add;
                break;
            case 5:
                if (self.var_bc2f37e4 + add > self.var_d8202611.size) {
                    function_fed43545("<unknown string>");
                    break;
                }
                if (self.var_bc2f37e4 + add <= 0) {
                    function_fed43545("<unknown string>");
                    break;
                }
                if (self.var_bc2f37e4 + add < self.var_8f471bf9) {
                    if (self.var_bc2f37e4 + add > 0) {
                        self.var_8f471bf9 = self.var_bc2f37e4 + add;
                    }
                }
                if (self.var_bc2f37e4 + add > self.var_ec676387) {
                    self.var_ec676387 = self.var_bc2f37e4 + add;
                }
                var_c4554a8d = 1;
                self.var_bc2f37e4 += add;
                break;
            case 6:
                if (self.var_8f471bf9 + add > self.var_ec676387) {
                    function_fed43545("<unknown string>");
                    break;
                }
                var_c4554a8d = 1;
                self.var_8f471bf9 += add;
                break;
            case 7:
                if (self.var_ec676387 + add < self.var_8f471bf9) {
                    function_fed43545("<unknown string>");
                    break;
                }
                var_c4554a8d = 1;
                self.var_ec676387 += add;
                break;
            }
        }
        if (var_c4554a8d) {
            level.var_ec52af9c function_5b99d8b8();
        }
        if (isdefined(self)) {
            level.var_470c2455 settext("<unknown string>" + self.var_5fa59123);
            level.var_c4b2df6b settext("<unknown string>" + self.var_e290d32d);
            level.var_a268b598 settext("<unknown string>" + self.var_4d210f7a);
            level.var_8c831eb6 settext("<unknown string>" + self.var_20149b34);
            if (isdefined(self.var_bc2f37e4)) {
                level.var_471f36bf settext("<unknown string>" + self.var_bc2f37e4);
                level.var_7a568a0f settext("<unknown string>" + self.var_8f471bf9);
                level.var_5ba78cd1 settext("<unknown string>" + self.var_ec676387);
            }
        }
    }

    // Namespace spawn_manager
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4c007a0d, Offset: 0x1b00
    // Size: 0x57e
    function function_facd2f34() {
        switch (level.var_75b3119) {
        case 0:
            level.var_73af57cd.color = (0, 1, 0);
            level.var_470c2455.color = (1, 1, 1);
            level.var_c4b2df6b.color = (1, 1, 1);
            level.var_a268b598.color = (1, 1, 1);
            level.var_8c831eb6.color = (1, 1, 1);
            level.var_471f36bf.color = (1, 1, 1);
            level.var_7a568a0f.color = (1, 1, 1);
            level.var_5ba78cd1.color = (1, 1, 1);
            break;
        case 1:
            level.var_73af57cd.color = (1, 1, 1);
            level.var_470c2455.color = (0, 1, 0);
            level.var_c4b2df6b.color = (1, 1, 1);
            level.var_a268b598.color = (1, 1, 1);
            level.var_8c831eb6.color = (1, 1, 1);
            level.var_471f36bf.color = (1, 1, 1);
            level.var_7a568a0f.color = (1, 1, 1);
            level.var_5ba78cd1.color = (1, 1, 1);
            break;
        case 2:
            level.var_73af57cd.color = (1, 1, 1);
            level.var_470c2455.color = (1, 1, 1);
            level.var_c4b2df6b.color = (0, 1, 0);
            level.var_a268b598.color = (1, 1, 1);
            level.var_8c831eb6.color = (1, 1, 1);
            level.var_471f36bf.color = (1, 1, 1);
            level.var_7a568a0f.color = (1, 1, 1);
            level.var_5ba78cd1.color = (1, 1, 1);
            break;
        case 3:
            level.var_73af57cd.color = (1, 1, 1);
            level.var_470c2455.color = (1, 1, 1);
            level.var_c4b2df6b.color = (1, 1, 1);
            level.var_a268b598.color = (0, 1, 0);
            level.var_8c831eb6.color = (1, 1, 1);
            level.var_471f36bf.color = (1, 1, 1);
            level.var_7a568a0f.color = (1, 1, 1);
            level.var_5ba78cd1.color = (1, 1, 1);
            break;
        case 4:
            level.var_73af57cd.color = (1, 1, 1);
            level.var_470c2455.color = (1, 1, 1);
            level.var_c4b2df6b.color = (1, 1, 1);
            level.var_a268b598.color = (1, 1, 1);
            level.var_8c831eb6.color = (0, 1, 0);
            level.var_471f36bf.color = (1, 1, 1);
            level.var_7a568a0f.color = (1, 1, 1);
            level.var_5ba78cd1.color = (1, 1, 1);
            break;
        case 5:
            level.var_73af57cd.color = (1, 1, 1);
            level.var_470c2455.color = (1, 1, 1);
            level.var_c4b2df6b.color = (1, 1, 1);
            level.var_a268b598.color = (1, 1, 1);
            level.var_8c831eb6.color = (1, 1, 1);
            level.var_471f36bf.color = (0, 1, 0);
            level.var_7a568a0f.color = (1, 1, 1);
            level.var_5ba78cd1.color = (1, 1, 1);
            break;
        case 6:
            level.var_73af57cd.color = (1, 1, 1);
            level.var_470c2455.color = (1, 1, 1);
            level.var_c4b2df6b.color = (1, 1, 1);
            level.var_a268b598.color = (1, 1, 1);
            level.var_8c831eb6.color = (1, 1, 1);
            level.var_471f36bf.color = (1, 1, 1);
            level.var_7a568a0f.color = (0, 1, 0);
            level.var_5ba78cd1.color = (1, 1, 1);
            break;
        case 7:
            level.var_73af57cd.color = (1, 1, 1);
            level.var_470c2455.color = (1, 1, 1);
            level.var_c4b2df6b.color = (1, 1, 1);
            level.var_a268b598.color = (1, 1, 1);
            level.var_8c831eb6.color = (1, 1, 1);
            level.var_471f36bf.color = (1, 1, 1);
            level.var_7a568a0f.color = (1, 1, 1);
            level.var_5ba78cd1.color = (0, 1, 0);
            break;
        }
    }

    // Namespace spawn_manager
    // Params 0, eflags: 0x1 linked
    // Checksum 0x6ade33d8, Offset: 0x2088
    // Size: 0x1ac
    function function_5b99d8b8() {
        if (isdefined(level.var_75b3119) && level.var_75b3119 != 5) {
            self.var_bc2f37e4 = randomintrange(self.var_8f471bf9, self.var_ec676387 + 1);
        }
        if (isdefined(level.var_75b3119) && level.var_75b3119 != 0) {
            self.var_ee45dcd6 = randomintrange(self.var_5fa59123, self.var_e290d32d + 1);
        }
        self.spawners = self function_826b96e5();
        assert(self.count >= self.var_b7a63f07);
        assert(self.count <= self.var_5a85f779);
        assert(self.var_ee45dcd6 >= self.var_5fa59123);
        assert(self.var_ee45dcd6 <= self.var_e290d32d);
        assert(self.var_20149b34 <= self.var_ee45dcd6);
        assert(self.var_4d210f7a <= self.var_ee45dcd6);
    }

    // Namespace spawn_manager
    // Params 1, eflags: 0x1 linked
    // Checksum 0x35a09932, Offset: 0x2240
    // Size: 0x5c
    function function_fed43545(text) {
        self notify(#"modified");
        wait(0.05);
        level.var_c34122c6 settext(text);
        level.var_c34122c6 thread function_f9e758e5();
    }

    // Namespace spawn_manager
    // Params 0, eflags: 0x1 linked
    // Checksum 0xce440999, Offset: 0x22a8
    // Size: 0x3c
    function function_f9e758e5() {
        self endon(#"modified");
        wait(10);
        level.var_c34122c6 settext("<unknown string>");
    }

    // Namespace spawn_manager
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8e345548, Offset: 0x22f0
    // Size: 0x144
    function function_10c561e2() {
        if (isdefined(level.var_73af57cd)) {
            level.var_73af57cd destroy();
        }
        if (isdefined(level.var_470c2455)) {
            level.var_470c2455 destroy();
        }
        if (isdefined(level.var_c4b2df6b)) {
            level.var_c4b2df6b destroy();
        }
        if (isdefined(level.var_a268b598)) {
            level.var_a268b598 destroy();
        }
        if (isdefined(level.var_8c831eb6)) {
            level.var_8c831eb6 destroy();
        }
        if (isdefined(level.var_471f36bf)) {
            level.var_471f36bf destroy();
        }
        if (isdefined(level.var_7a568a0f)) {
            level.var_7a568a0f destroy();
        }
        if (isdefined(level.var_5ba78cd1)) {
            level.var_5ba78cd1 destroy();
        }
    }

#/
