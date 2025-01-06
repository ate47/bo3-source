#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/cp_doa_bo3_fx;
#using scripts/cp/cp_doa_bo3_sound;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_camera;
#using scripts/cp/doa/_doa_core;
#using scripts/cp/doa/_doa_fx;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace namespace_64c6b720;

// Namespace namespace_64c6b720
// Params 0, eflags: 0x0
// Checksum 0x664e7955, Offset: 0x410
// Size: 0x16a
function init() {
    clientfield::register("world", "set_scoreHidden", 1, 1, "int", &function_7fe5e3f4, 0, 0);
    for (i = 0; i < 4; i++) {
        clientfield::register("world", "set_ui_gprDOA" + i, 1, 30, "int", &function_2db8b053, 0, 0);
        clientfield::register("world", "set_ui_gpr2DOA" + i, 1, 30, "int", &function_b9397b2b, 0, 0);
        clientfield::register("world", "set_ui_GlobalGPR" + i, 1, 30, "int", &function_e0f15ca4, 0, 0);
    }
    clientfield::register("world", "startCountdown", 1, 3, "int", &function_75319a37, 0, 0);
    callback::on_spawned(&on_player_spawn);
    function_6fa6dee2(0);
}

// Namespace namespace_64c6b720
// Params 1, eflags: 0x0
// Checksum 0x89b2cb22, Offset: 0x588
// Size: 0x76a
function function_6fa6dee2(localclientnum) {
    globalmodel = getglobaluimodel();
    level.var_7e2a814c = createuimodel(globalmodel, "DeadOpsArcadeGlobal");
    setuimodelvalue(createuimodel(level.var_7e2a814c, "gbanner"), "");
    setuimodelvalue(createuimodel(level.var_7e2a814c, "grgb1"), "0 255 0");
    setuimodelvalue(createuimodel(level.var_7e2a814c, "grgb2"), "255 255 0");
    setuimodelvalue(createuimodel(level.var_7e2a814c, "grgb3"), "255 0 0");
    setuimodelvalue(createuimodel(level.var_7e2a814c, "gtxt0"), "");
    setuimodelvalue(createuimodel(level.var_7e2a814c, "gpr0"), 0);
    setuimodelvalue(createuimodel(level.var_7e2a814c, "gpr1"), 0);
    setuimodelvalue(createuimodel(level.var_7e2a814c, "gpr2"), 0);
    setuimodelvalue(createuimodel(level.var_7e2a814c, "gpr3"), 0);
    setuimodelvalue(createuimodel(level.var_7e2a814c, "redins"), "");
    setuimodelvalue(createuimodel(level.var_7e2a814c, "countdown"), "");
    setuimodelvalue(createuimodel(level.var_7e2a814c, "level"), 1);
    setuimodelvalue(createuimodel(level.var_7e2a814c, "driving"), 0);
    setuimodelvalue(createuimodel(level.var_7e2a814c, "hint"), "");
    setuimodelvalue(createuimodel(level.var_7e2a814c, "instruct"), "");
    level.var_b9d30140 = [];
    var_483f522 = createuimodel(globalmodel, "DeadOpsArcadePlayers");
    for (i = 1; i <= 4; i++) {
        model = createuimodel(var_483f522, "player" + i);
        setuimodelvalue(createuimodel(model, "name"), "");
        setuimodelvalue(createuimodel(model, "lives"), 0);
        setuimodelvalue(createuimodel(model, "bombs"), 0);
        setuimodelvalue(createuimodel(model, "boosts"), 0);
        setuimodelvalue(createuimodel(model, "score"), 0);
        setuimodelvalue(createuimodel(model, "multiplier"), 0);
        setuimodelvalue(createuimodel(model, "xbar"), 0);
        setuimodelvalue(createuimodel(model, "bulletbar"), 0);
        setuimodelvalue(createuimodel(model, "bulletbar_rgb"), "255 208 0");
        setuimodelvalue(createuimodel(model, "ribbon"), 0);
        setuimodelvalue(createuimodel(model, "gpr_rgb"), "0 255 0");
        setuimodelvalue(createuimodel(model, "generic_txt"), "");
        setuimodelvalue(createuimodel(model, "gpr"), 0);
        setuimodelvalue(createuimodel(model, "gpr2"), 0);
        setuimodelvalue(createuimodel(model, "weaplevel1"), 0);
        setuimodelvalue(createuimodel(model, "weaplevel2"), 0);
        setuimodelvalue(createuimodel(model, "respawn"), "");
        level.var_b9d30140[level.var_b9d30140.size] = model;
    }
    level.var_c8a4d758 = 0;
    level.gpr = array(0, 0, 0, 0);
    level.var_29e6f519 = [];
    for (i = 0; i < 4; i++) {
        doa = spawnstruct();
        doa.ui_model = level.var_b9d30140[i];
        level.var_29e6f519[level.var_29e6f519.size] = doa;
        function_e06716c7(doa, i);
    }
    level thread function_cdb6d911(localclientnum);
    level thread function_4d819138();
    level thread function_2c9a6a47();
}

// Namespace namespace_64c6b720
// Params 2, eflags: 0x0
// Checksum 0x71e3f9a7, Offset: 0xd00
// Size: 0x16a
function function_d3f117f9(doa, idx) {
    if (!isdefined(doa)) {
        return;
    }
    /#
        for (i = 0; i < level.var_29e6f519.size; i++) {
            if (level.var_29e6f519[i] == doa) {
                idx = i;
                break;
            }
        }
        txt = "<dev string:x28>" + (isdefined(idx) ? idx : "<dev string:x3e>") + "<dev string:x42>" + (isdefined(doa.player) ? doa.player getentitynumber() : "<dev string:x63>");
        namespace_693feb87::function_245e1ba2(txt);
    #/
    doa.score = 0;
    doa.xbar = 0;
    doa.lives = 3;
    doa.bombs = 1;
    doa.var_c5e98ad6 = 2;
    doa.bulletbar = 0;
    doa.multiplier = 1;
    doa.name = "";
    doa.gpr = 0;
    doa.gpr2 = 0;
    doa.var_4f0e30c = 0;
    doa.var_c88a6593 = 0;
    doa.var_c86225b5 = 0;
}

// Namespace namespace_64c6b720
// Params 2, eflags: 0x0
// Checksum 0xe44a9bea, Offset: 0xe78
// Size: 0x3fa
function function_e06716c7(doa, idx) {
    function_d3f117f9(doa, idx);
    if (isdefined(doa.ui_model) && isdefined(getuimodel(doa.ui_model, "name"))) {
        setuimodelvalue(getuimodel(doa.ui_model, "name"), doa.name);
        setuimodelvalue(getuimodel(doa.ui_model, "lives"), doa.lives);
        setuimodelvalue(getuimodel(doa.ui_model, "bombs"), doa.bombs);
        setuimodelvalue(getuimodel(doa.ui_model, "boosts"), doa.var_c5e98ad6);
        setuimodelvalue(getuimodel(doa.ui_model, "score"), doa.score);
        setuimodelvalue(getuimodel(doa.ui_model, "multiplier"), doa.multiplier);
        setuimodelvalue(getuimodel(doa.ui_model, "xbar"), doa.xbar);
        setuimodelvalue(getuimodel(doa.ui_model, "bulletbar"), doa.bulletbar);
        setuimodelvalue(getuimodel(doa.ui_model, "bulletbar_rgb"), "255 208 0");
        setuimodelvalue(getuimodel(doa.ui_model, "ribbon"), 0);
        setuimodelvalue(getuimodel(doa.ui_model, "gpr_rgb"), "0 255 0");
        setuimodelvalue(getuimodel(doa.ui_model, "generic_txt"), "");
        setuimodelvalue(getuimodel(doa.ui_model, "gpr"), doa.gpr);
        setuimodelvalue(getuimodel(doa.ui_model, "gpr2"), doa.gpr2);
        setuimodelvalue(getuimodel(doa.ui_model, "weaplevel1"), 0);
        setuimodelvalue(getuimodel(doa.ui_model, "weaplevel2"), 0);
        setuimodelvalue(getuimodel(doa.ui_model, "respawn"), "");
    }
}

// Namespace namespace_64c6b720
// Params 1, eflags: 0x0
// Checksum 0xdeac0a53, Offset: 0x1280
// Size: 0x171
function function_cdb6d911(localclientnum) {
    self notify(#"hash_cdb6d911");
    self endon(#"hash_cdb6d911");
    while (true) {
        foreach (model in level.var_b9d30140) {
            setuimodelvalue(getuimodel(model, "ribbon"), 0);
        }
        var_324ecf57 = level.var_29e6f519[0];
        foreach (doa in level.var_29e6f519) {
            if (doa.score > var_324ecf57.score) {
                var_324ecf57 = doa;
            }
        }
        if (getplayers(localclientnum).size > 1 && isdefined(var_324ecf57)) {
            setuimodelvalue(getuimodel(var_324ecf57.ui_model, "ribbon"), 1);
        }
        wait 1;
    }
}

// Namespace namespace_64c6b720
// Params 0, eflags: 0x0
// Checksum 0x7c58ed9c, Offset: 0x1400
// Size: 0x1f5
function function_4d819138() {
    self notify(#"hash_4d819138");
    self endon(#"hash_4d819138");
    while (true) {
        foreach (doa in level.var_29e6f519) {
            if (!isdefined(doa.player)) {
                continue;
            }
            delta = doa.player.score - doa.score;
            if (delta > 0) {
                inc = 1;
                frac = int(0.01 * delta);
                units = int(frac / inc);
                inc += units * inc;
                doa.score += inc;
                if (doa.score > doa.player.score) {
                    doa.score = doa.player.score;
                }
            } else if (delta < 0) {
                doa.score = 0;
            }
            score = math::clamp(doa.score * 25, 0, int(int(4e+06) * 25 - 1));
            setuimodelvalue(getuimodel(doa.ui_model, "score"), score);
        }
        wait 0.016;
    }
}

// Namespace namespace_64c6b720
// Params 0, eflags: 0x0
// Checksum 0xb8e7c8bf, Offset: 0x1600
// Size: 0x877
function function_2c9a6a47() {
    self notify(#"hash_2c9a6a47");
    self endon(#"hash_2c9a6a47");
    while (true) {
        wait 0.016;
        foreach (doa in level.var_29e6f519) {
            setuimodelvalue(getuimodel(doa.ui_model, "respawn"), "");
            if (isdefined(level.var_c8a4d758) && level.var_c8a4d758) {
                setuimodelvalue(getuimodel(doa.ui_model, "name"), "");
                setuimodelvalue(getuimodel(doa.ui_model, "weaplevel1"), 0);
                setuimodelvalue(getuimodel(doa.ui_model, "weaplevel2"), 0);
            } else {
                name = "";
                if (isdefined(doa.player) && isdefined(doa.player.name)) {
                    name = doa.player.name;
                }
                setuimodelvalue(getuimodel(doa.ui_model, "name"), name);
                if (isdefined(doa.var_c86225b5) && doa.var_c86225b5) {
                    setuimodelvalue(createuimodel(doa.ui_model, "name"), istring("DOA_RESPAWNING"));
                    val = "" + int(ceil(doa.xbar * 60));
                    setuimodelvalue(getuimodel(doa.ui_model, "respawn"), val);
                }
            }
            if (isdefined(doa.player)) {
                InvalidOpCode(0xe1, 12, !true, doa.player.headshots);
                // Unknown operator (0xe1, t7_1b, PC)
            }
            setuimodelvalue(getuimodel(doa.ui_model, "bombs"), doa.bombs);
            setuimodelvalue(getuimodel(doa.ui_model, "boosts"), doa.var_c5e98ad6);
            setuimodelvalue(getuimodel(doa.ui_model, "lives"), doa.lives);
            setuimodelvalue(getuimodel(doa.ui_model, "multiplier"), doa.multiplier);
            setuimodelvalue(getuimodel(doa.ui_model, "xbar"), doa.xbar);
            setuimodelvalue(getuimodel(doa.ui_model, "bulletbar"), doa.bulletbar);
            setuimodelvalue(getuimodel(doa.ui_model, "weaplevel1"), 0);
            setuimodelvalue(getuimodel(doa.ui_model, "weaplevel2"), 0);
            if (!(isdefined(level.var_c8a4d758) && level.var_c8a4d758)) {
                switch (doa.var_4f0e30c) {
                case 0:
                    setuimodelvalue(getuimodel(doa.ui_model, "weaplevel1"), 0);
                    setuimodelvalue(getuimodel(doa.ui_model, "weaplevel2"), 0);
                    setuimodelvalue(getuimodel(doa.ui_model, "bulletbar_rgb"), "255 208 0");
                    break;
                case 1:
                    setuimodelvalue(getuimodel(doa.ui_model, "weaplevel1"), 1);
                    setuimodelvalue(getuimodel(doa.ui_model, "weaplevel2"), 0);
                    setuimodelvalue(getuimodel(doa.ui_model, "bulletbar_rgb"), "255 0 0");
                    break;
                case 2:
                    setuimodelvalue(getuimodel(doa.ui_model, "weaplevel1"), 1);
                    setuimodelvalue(getuimodel(doa.ui_model, "weaplevel2"), 1);
                    setuimodelvalue(getuimodel(doa.ui_model, "bulletbar_rgb"), "128 0 255");
                    break;
                }
            }
            setuimodelvalue(getuimodel(doa.ui_model, "gpr"), doa.gpr);
            setuimodelvalue(getuimodel(doa.ui_model, "gpr2"), doa.gpr2);
        }
    }
}

// Namespace namespace_64c6b720
// Params 2, eflags: 0x0
// Checksum 0x69508164, Offset: 0x1e80
// Size: 0x82
function on_shutdown(localclientnum, ent) {
    if (isdefined(ent) && self === ent) {
        namespace_693feb87::function_245e1ba2("Player Disconnected:" + (isdefined(self.name) ? self.name : self getentitynumber()));
        if (isdefined(self.doa)) {
            function_e06716c7(self.doa);
        }
    }
}

// Namespace namespace_64c6b720
// Params 1, eflags: 0x0
// Checksum 0x52b79d67, Offset: 0x1f10
// Size: 0x2a
function on_player_spawn(localclientnum) {
    self callback::on_shutdown(&on_shutdown, self);
}

// Namespace namespace_64c6b720
// Params 7, eflags: 0x0
// Checksum 0x68299dec, Offset: 0x1f48
// Size: 0x42
function function_7fe5e3f4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.var_c8a4d758 = newval;
}

// Namespace namespace_64c6b720
// Params 7, eflags: 0x0
// Checksum 0x57d826ee, Offset: 0x1f98
// Size: 0xf2
function function_e0f15ca4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    diff = newval - oldval;
    if (diff) {
        level notify(#"hash_48152b36", fieldname, diff);
    }
    idx = int(fieldname[fieldname.size - 1]);
    assert(idx >= 0 && idx < level.gpr.size);
    level.gpr[idx] = newval;
    field = "gpr" + idx;
    setuimodelvalue(createuimodel(level.var_7e2a814c, field), newval);
}

// Namespace namespace_64c6b720
// Params 7, eflags: 0x0
// Checksum 0xdc0913c1, Offset: 0x2098
// Size: 0x6e
function function_2db8b053(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playernum = int(fieldname[fieldname.size - 1]);
    level.var_29e6f519[playernum].gpr = newval;
}

// Namespace namespace_64c6b720
// Params 7, eflags: 0x0
// Checksum 0xb7cab07f, Offset: 0x2110
// Size: 0x6e
function function_b9397b2b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playernum = int(fieldname[fieldname.size - 1]);
    level.var_29e6f519[playernum].gpr2 = newval;
}

// Namespace namespace_64c6b720
// Params 7, eflags: 0x0
// Checksum 0x958cda9d, Offset: 0x2188
// Size: 0x3a
function function_6ccafee6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace namespace_64c6b720
// Params 7, eflags: 0x0
// Checksum 0x87456d92, Offset: 0x21d0
// Size: 0x72
function function_75319a37(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    if (newval == 0) {
        return;
    }
    if (isdefined(level.var_b1ce5a88) && level.var_b1ce5a88) {
        return;
    }
    level thread function_56dd76b(newval);
}

// Namespace namespace_64c6b720
// Params 1, eflags: 0x0
// Checksum 0x84c2f807, Offset: 0x2250
// Size: 0xdd
function function_a08fe7c3(totaltime) {
    totaltime *= 1000;
    curtime = gettime();
    endtime = curtime + totaltime;
    while (curtime < endtime) {
        curtime = gettime();
        diff = endtime - curtime;
        ratio = diff / totaltime;
        r = -1 * ratio;
        g = -1 * (1 - ratio);
        rgb = r + " " + g + " 0";
        setuimodelvalue(getuimodel(level.var_7e2a814c, "grgb1"), rgb);
        wait 0.016;
    }
}

// Namespace namespace_64c6b720
// Params 1, eflags: 0x0
// Checksum 0xb9ce5cd9, Offset: 0x2338
// Size: 0x192
function function_56dd76b(val) {
    level.var_b1ce5a88 = 1;
    startval = val;
    level thread function_a08fe7c3(startval * 1.1);
    while (val > 0) {
        setuimodelvalue(getuimodel(level.var_7e2a814c, "countdown"), "" + val);
        playsound(0, "evt_countdown", (0, 0, 0));
        wait 1.05;
        setuimodelvalue(getuimodel(level.var_7e2a814c, "countdown"), "");
        wait 0.016;
        val -= 1;
        level notify(#"countdown", val);
    }
    level notify(#"countdown", 0);
    setuimodelvalue(getuimodel(level.var_7e2a814c, "countdown"), %CP_DOA_BO3_GO);
    playsound(0, "evt_countdown_go", (0, 0, 0));
    wait 1.1;
    setuimodelvalue(getuimodel(level.var_7e2a814c, "countdown"), "");
    level.var_b1ce5a88 = 0;
}

// Namespace namespace_64c6b720
// Params 1, eflags: 0x0
// Checksum 0x9124012, Offset: 0x24d8
// Size: 0x3a
function function_ecca2450(text) {
    setuimodelvalue(getuimodel(level.var_7e2a814c, "countdown"), text);
}

