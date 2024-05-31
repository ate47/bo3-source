#using scripts/shared/vehicles/_quadtank;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_core;
#using scripts/cp/cp_doa_bo3_sound;
#using scripts/cp/cp_doa_bo3_fx;
#using scripts/shared/exploder_shared;
#using scripts/cp/gametypes/coop;
#using scripts/cp/_util;
#using scripts/cp/_load;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#using_animtree("critter");
#using_animtree("a_water_buffalo_run_b");

#namespace namespace_bb5d050c;

// Namespace namespace_bb5d050c
// Params 0, eflags: 0x1 linked
// namespace_bb5d050c<file_0>::function_d290ebfa
// Checksum 0x30efffb5, Offset: 0x620
// Size: 0x29c
function main() {
    setdvar("doa_redins_rally", 0);
    level.var_2eda2d85 = &function_62423327;
    level.var_1f314fb9 = &function_4eb73a5;
    namespace_e8effba5::main();
    namespace_4fca3ee8::main();
    setdvar("bg_friendlyFireMode", 0);
    clientfield::register("world", "redinsExploder", 1, 2, "int", &function_1dd0a889, 0, 0);
    clientfield::register("world", "activateBanner", 1, 3, "int", &function_99e9c8d, 0, 0);
    clientfield::register("world", "pumpBannerBar", 1, 8, "float", &function_98982de8, 0, 0);
    clientfield::register("world", "redinstutorial", 1, 1, "int", &function_c7163a08, 0, 0);
    clientfield::register("world", "redinsinstruct", 1, 12, "int", &function_9cbb849c, 0, 0);
    clientfield::register("scriptmover", "runcowanim", 1, 1, "int", &function_caf96f2d, 0, 0);
    clientfield::register("scriptmover", "runsiegechickenanim", 8000, 2, "int", &function_f9064aec, 0, 0);
    namespace_693feb87::main();
    load::main();
}

// Namespace namespace_bb5d050c
// Params 3, eflags: 0x1 linked
// namespace_bb5d050c<file_0>::function_4eb73a5
// Checksum 0x37da1161, Offset: 0x8c8
// Size: 0x616
function function_4eb73a5(localclientnum, mapname, var_5fb1dd3e) {
    if (isdefined(level.var_c065e9ed) && isdefined(level.var_c065e9ed[localclientnum])) {
        stopfx(localclientnum, level.var_c065e9ed[localclientnum]);
        level.var_c065e9ed[localclientnum] = 0;
    }
    switch (mapname) {
    case 26:
        break;
    case 23:
        if (var_5fb1dd3e == "night") {
            level.var_c065e9ed[localclientnum] = playfxoncamera(localclientnum, level._effect["ambient_rainfall_" + randomintrange(1, 4)], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    case 24:
        if (var_5fb1dd3e == "dusk" || var_5fb1dd3e == "night") {
            level.var_c065e9ed[localclientnum] = playfxoncamera(localclientnum, level._effect["ambient_snowfall_1"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    case 25:
        if (var_5fb1dd3e == "noon") {
            level.var_c065e9ed[localclientnum] = playfxoncamera(localclientnum, level._effect["ambient_snowfall_1"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        } else if (var_5fb1dd3e == "night") {
            level.var_c065e9ed[localclientnum] = playfxoncamera(localclientnum, level._effect["ambient_rainfall_" + randomintrange(1, 4)], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    case 32:
        if (var_5fb1dd3e == "night") {
            level.var_c065e9ed[localclientnum] = playfxoncamera(localclientnum, level._effect["ambient_rainfall_" + randomintrange(1, 4)], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    case 29:
        break;
    case 19:
        if (var_5fb1dd3e != "dusk") {
            level.var_c065e9ed[localclientnum] = playfxoncamera(localclientnum, level._effect["ambient_snowfall_1"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    case 21:
        break;
    case 33:
        if (var_5fb1dd3e == "night") {
            level.var_c065e9ed[localclientnum] = playfxoncamera(localclientnum, level._effect["ambient_rainfall_" + randomintrange(1, 4)], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    case 31:
        break;
    case 18:
        if (var_5fb1dd3e == "night") {
            level.var_c065e9ed[localclientnum] = playfxoncamera(localclientnum, level._effect["ambient_rainfall_" + randomintrange(1, 4)], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    case 30:
        break;
    case 27:
        if (var_5fb1dd3e == "night") {
            level.var_c065e9ed[localclientnum] = playfxoncamera(localclientnum, level._effect["ambient_snowfall_1"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    case 22:
        if (var_5fb1dd3e != "night") {
            level.var_c065e9ed[localclientnum] = playfxoncamera(localclientnum, level._effect["ambient_snowfall_1"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    case 28:
        if (var_5fb1dd3e == "dusk" || var_5fb1dd3e == "night") {
            level.var_c065e9ed[localclientnum] = playfxoncamera(localclientnum, level._effect["ambient_snowfall_1"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    case 20:
        if (var_5fb1dd3e == "night") {
            level.var_c065e9ed[localclientnum] = playfxoncamera(localclientnum, level._effect["ambient_rainfall_" + randomintrange(1, 4)], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    }
}

// Namespace namespace_bb5d050c
// Params 1, eflags: 0x1 linked
// namespace_bb5d050c<file_0>::function_62423327
// Checksum 0x8f58643f, Offset: 0xee8
// Size: 0x252
function function_62423327(arena) {
    switch (arena.name) {
    case 39:
        arena.var_f3114f93 = &function_787f2b69;
        arena.var_aad78940 = 99;
        arena.var_f4f1abf3 = 1;
        arena.var_dd94482c = 1 + 8 + 4;
        arena.var_ecf7ec70 = 0;
        break;
    case 41:
        arena.var_f3114f93 = &function_52612667;
        arena.var_aad78940 = 99;
        arena.var_dd94482c = 1 + 4;
        arena.var_ecf7ec70 = 2;
        break;
    case 40:
        arena.var_aad78940 = 2;
        arena.var_dd94482c = 1;
        arena.var_ecf7ec70 = 0;
        break;
    case 42:
        arena.var_f3114f93 = &function_b5e8546d;
        arena.var_aad78940 = 99;
        arena.var_dd94482c = 1 + 8 + 4;
        arena.var_ecf7ec70 = 2;
        break;
    case 34:
    case 35:
    case 36:
    case 37:
    case 38:
    case 43:
    case 44:
        arena.var_dd94482c = 4;
        arena.var_ecf7ec70 = 2;
        break;
    case 18:
        arena.var_bfa5d6ae = 1;
        break;
    default:
        break;
    }
}

// Namespace namespace_bb5d050c
// Params 7, eflags: 0x1 linked
// namespace_bb5d050c<file_0>::function_98982de8
// Checksum 0xf010a2cc, Offset: 0x1148
// Size: 0x74
function function_98982de8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setuimodelvalue(getuimodel(level.var_7e2a814c, "gpr0"), newval);
}

// Namespace namespace_bb5d050c
// Params 7, eflags: 0x1 linked
// namespace_bb5d050c<file_0>::function_99e9c8d
// Checksum 0xf77e8105, Offset: 0x11c8
// Size: 0x7ee
function function_99e9c8d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setuimodelvalue(createuimodel(level.var_7e2a814c, "gbanner"), "");
    switch (newval) {
    case 6:
        setuimodelvalue(getuimodel(level.var_7e2a814c, "gbanner"), %CP_DOA_BO3_BOSS_CYBERSILVERBACK_MECH);
        setuimodelvalue(getuimodel(level.var_7e2a814c, "gpr0"), 1);
        setuimodelvalue(getuimodel(level.var_7e2a814c, "grgb1"), "255 0 0");
        setuimodelvalue(getuimodel(level.var_7e2a814c, "grgb2"), "255 128 0");
        setuimodelvalue(getuimodel(level.var_7e2a814c, "grgb3"), "255 0 32");
        break;
    case 5:
        setuimodelvalue(getuimodel(level.var_7e2a814c, "gbanner"), %CP_DOA_BO3_BOSS_CYBERSILVERBACK);
        setuimodelvalue(getuimodel(level.var_7e2a814c, "gpr0"), 1);
        setuimodelvalue(getuimodel(level.var_7e2a814c, "grgb1"), "255 0 0");
        setuimodelvalue(getuimodel(level.var_7e2a814c, "grgb2"), "255 128 0");
        setuimodelvalue(getuimodel(level.var_7e2a814c, "grgb3"), "255 0 32");
        break;
    case 4:
        setuimodelvalue(getuimodel(level.var_7e2a814c, "gbanner"), %CP_DOA_BO3_BOSS_MARGWA);
        setuimodelvalue(getuimodel(level.var_7e2a814c, "gpr0"), 1);
        setuimodelvalue(getuimodel(level.var_7e2a814c, "grgb1"), "255 0 0");
        setuimodelvalue(getuimodel(level.var_7e2a814c, "grgb2"), "255 128 0");
        setuimodelvalue(getuimodel(level.var_7e2a814c, "grgb3"), "255 0 32");
        break;
    case 1:
        setuimodelvalue(getuimodel(level.var_7e2a814c, "gbanner"), %CP_DOA_BO3_BOSS_STONEGUARDIAN);
        setuimodelvalue(getuimodel(level.var_7e2a814c, "gpr0"), 1);
        setuimodelvalue(getuimodel(level.var_7e2a814c, "grgb1"), "255 0 0");
        setuimodelvalue(getuimodel(level.var_7e2a814c, "grgb2"), "255 128 0");
        setuimodelvalue(getuimodel(level.var_7e2a814c, "grgb3"), "255 0 32");
        break;
    case 2:
        setuimodelvalue(getuimodel(level.var_7e2a814c, "gbanner"), %CP_DOA_BO3_BANNER_CHICKENBOWL);
        setuimodelvalue(getuimodel(level.var_7e2a814c, "gpr0"), 1);
        setuimodelvalue(getuimodel(level.var_7e2a814c, "grgb1"), "128 128 128");
        setuimodelvalue(getuimodel(level.var_7e2a814c, "grgb2"), "255 255 255");
        setuimodelvalue(getuimodel(level.var_7e2a814c, "grgb3"), "128 128 128");
        break;
    case 3:
        setuimodelvalue(getuimodel(level.var_7e2a814c, "gbanner"), %CP_DOA_BO3_BANNER_TANKMAZE);
        setuimodelvalue(getuimodel(level.var_7e2a814c, "gpr0"), 1);
        setuimodelvalue(getuimodel(level.var_7e2a814c, "grgb1"), "16 16 16");
        setuimodelvalue(getuimodel(level.var_7e2a814c, "grgb2"), "31 10 255");
        setuimodelvalue(getuimodel(level.var_7e2a814c, "grgb3"), "255 255 0");
        break;
    default:
        setuimodelvalue(createuimodel(level.var_7e2a814c, "gbanner"), "");
        setuimodelvalue(getuimodel(level.var_7e2a814c, "gpr0"), 0);
        break;
    }
}

// Namespace namespace_bb5d050c
// Params 1, eflags: 0x1 linked
// namespace_bb5d050c<file_0>::function_b5e8546d
// Checksum 0xac1d1a5, Offset: 0x19c0
// Size: 0x64
function function_b5e8546d(localclientnum) {
    level.var_81528e19 = 2;
    setuimodelvalue(createuimodel(level.var_7e2a814c, "driving"), 1);
    level thread function_caffcc1d(localclientnum);
}

// Namespace namespace_bb5d050c
// Params 1, eflags: 0x1 linked
// namespace_bb5d050c<file_0>::function_caffcc1d
// Checksum 0xc95040b3, Offset: 0x1a30
// Size: 0x54
function function_caffcc1d(localclientnum) {
    level waittill(#"hash_ec7ca67b");
    level.var_81528e19 = undefined;
    setuimodelvalue(createuimodel(level.var_7e2a814c, "driving"), 0);
}

// Namespace namespace_bb5d050c
// Params 1, eflags: 0x1 linked
// namespace_bb5d050c<file_0>::function_c8020bd9
// Checksum 0xf0efe55c, Offset: 0x1a90
// Size: 0x294
function function_c8020bd9(localclientnum) {
    level waittill(#"hash_ec7ca67b");
    level.var_81528e19 = undefined;
    setuimodelvalue(createuimodel(level.var_7e2a814c, "redins"), "");
    setuimodelvalue(createuimodel(level.var_7e2a814c, "gtxt0"), "");
    setuimodelvalue(createuimodel(level.var_7e2a814c, "gpr0"), 0);
    setuimodelvalue(createuimodel(level.var_7e2a814c, "gpr1"), 0);
    setuimodelvalue(createuimodel(level.var_7e2a814c, "gpr2"), 0);
    setuimodelvalue(createuimodel(level.var_7e2a814c, "gpr3"), 0);
    foreach (player in getplayers(localclientnum)) {
        setuimodelvalue(getuimodel(level.var_b9d30140[player getentitynumber()], "generic_txt"), "");
    }
    setdvar("doa_redins_rally", 0);
    setuimodelvalue(createuimodel(level.var_7e2a814c, "driving"), 0);
}

// Namespace namespace_bb5d050c
// Params 2, eflags: 0x1 linked
// namespace_bb5d050c<file_0>::function_7183a31d
// Checksum 0x6f9026b6, Offset: 0x1d30
// Size: 0xac
function function_7183a31d(fieldname, diff) {
    level notify(#"hash_7183a31d");
    level endon(#"hash_7183a31d");
    setuimodelvalue(createuimodel(level.var_7e2a814c, "gtxt0"), "+" + diff);
    wait(2);
    setuimodelvalue(createuimodel(level.var_7e2a814c, "gtxt0"), "");
}

// Namespace namespace_bb5d050c
// Params 0, eflags: 0x1 linked
// namespace_bb5d050c<file_0>::function_ec984567
// Checksum 0x8d746e19, Offset: 0x1de8
// Size: 0x68
function function_ec984567() {
    level endon(#"hash_ec7ca67b");
    while (true) {
        fieldname, diff = level waittill(#"hash_48152b36");
        if (diff > 0) {
            level thread function_7183a31d(fieldname, diff);
        }
    }
}

// Namespace namespace_bb5d050c
// Params 7, eflags: 0x1 linked
// namespace_bb5d050c<file_0>::function_1dd0a889
// Checksum 0x338d40bd, Offset: 0x1e58
// Size: 0xd6
function function_1dd0a889(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 0:
        exploder::kill_exploder("fx_exploder_rally_ramp_fireworks");
        exploder::kill_exploder("fx_exploder_rally_winner_fireworks");
        break;
    case 1:
        exploder::exploder("fx_exploder_rally_ramp_fireworks");
        break;
    case 2:
        exploder::exploder("fx_exploder_rally_winner_fireworks");
        break;
    }
}

// Namespace namespace_bb5d050c
// Params 7, eflags: 0x1 linked
// namespace_bb5d050c<file_0>::function_9cbb849c
// Checksum 0x75b9f59e, Offset: 0x1f38
// Size: 0x114
function function_9cbb849c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        var_a923fad3 = newval & 15;
        seconds = newval >> 4;
        text = sprintf(%CP_DOA_BO3_REDINS_INSTRUCTION, var_a923fad3, seconds);
        setuimodelvalue(createuimodel(level.var_7e2a814c, "instruct"), text);
        return;
    }
    setuimodelvalue(createuimodel(level.var_7e2a814c, "instruct"), "");
}

// Namespace namespace_bb5d050c
// Params 7, eflags: 0x1 linked
// namespace_bb5d050c<file_0>::function_c7163a08
// Checksum 0x70daeacf, Offset: 0x2058
// Size: 0x19e
function function_c7163a08(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1 && !(isdefined(level.var_f64ff200) && level.var_f64ff200)) {
        if (!isdefined(level.var_8c2ba713)) {
            level.var_8c2ba713 = createluimenu(localclientnum, "DOA_ControlsMenu");
        }
        if (isdefined(level.var_8c2ba713)) {
            openluimenu(localclientnum, level.var_8c2ba713);
            level.var_f64ff200 = 1;
            string = "CP_DOA_BO3_REDINS_HINT" + randomint(8);
            setuimodelvalue(createuimodel(level.var_7e2a814c, "hint"), istring(string));
            while (true) {
                val = level waittill(#"countdown");
                if (val <= 1) {
                    break;
                }
            }
            closeluimenu(localclientnum, level.var_8c2ba713);
            level.var_8c2ba713 = undefined;
            level.var_f64ff200 = undefined;
        }
    }
}

// Namespace namespace_bb5d050c
// Params 1, eflags: 0x1 linked
// namespace_bb5d050c<file_0>::function_96abee17
// Checksum 0x40bb40ba, Offset: 0x2200
// Size: 0x22
function function_96abee17(localclientnum) {
    level waittill(#"hash_ec7ca67b");
    level.var_81528e19 = undefined;
}

// Namespace namespace_bb5d050c
// Params 1, eflags: 0x1 linked
// namespace_bb5d050c<file_0>::function_52612667
// Checksum 0x105d0475, Offset: 0x2230
// Size: 0x94
function function_52612667(localclientnum) {
    level endon(#"hash_ec7ca67b");
    if (isdefined(level.var_c065e9ed) && isdefined(level.var_c065e9ed[localclientnum])) {
        stopfx(localclientnum, level.var_c065e9ed[localclientnum]);
        level.var_c065e9ed[localclientnum] = 0;
    }
    level.var_81528e19 = 2;
    level thread function_96abee17(localclientnum);
}

// Namespace namespace_bb5d050c
// Params 1, eflags: 0x1 linked
// namespace_bb5d050c<file_0>::function_787f2b69
// Checksum 0xb426fe52, Offset: 0x22d0
// Size: 0x420
function function_787f2b69(localclientnum) {
    level endon(#"hash_ec7ca67b");
    if (isdefined(level.var_c065e9ed) && isdefined(level.var_c065e9ed[localclientnum])) {
        stopfx(localclientnum, level.var_c065e9ed[localclientnum]);
        level.var_c065e9ed[localclientnum] = 0;
    }
    level.var_81528e19 = 2;
    level thread function_c8020bd9(localclientnum);
    setuimodelvalue(getuimodel(level.var_7e2a814c, "redins"), "1");
    setuimodelvalue(createuimodel(level.var_7e2a814c, "driving"), 1);
    setdvar("doa_redins_rally", 1);
    level thread function_ec984567();
    while (true) {
        for (i = 0; i < 4; i++) {
            setuimodelvalue(getuimodel(level.var_b9d30140[i], "name"), "");
            setuimodelvalue(getuimodel(level.var_b9d30140[i], "generic_txt"), "");
        }
        foreach (player in getplayers(localclientnum)) {
            setuimodelvalue(getuimodel(level.var_b9d30140[player getentitynumber()], "name"), "");
            setuimodelvalue(getuimodel(level.var_b9d30140[player getentitynumber()], "generic_txt"), isdefined(player.name) ? player.name : "");
            switch (player getentitynumber()) {
            case 0:
                rgb = "0 255 0";
                break;
            case 1:
                rgb = "0 0 255";
                break;
            case 2:
                rgb = "255 0 0";
                break;
            case 3:
                rgb = "255 255 0";
                break;
            }
            setuimodelvalue(getuimodel(level.var_b9d30140[player getentitynumber()], "gpr_rgb"), rgb);
        }
        wait(0.1);
    }
}

// Namespace namespace_bb5d050c
// Params 0, eflags: 0x1 linked
// namespace_bb5d050c<file_0>::function_a8eb710
// Checksum 0xbd477641, Offset: 0x26f8
// Size: 0xa4
function function_a8eb710() {
    self endon(#"entityshutdown");
    self useanimtree(#critter);
    self.animation = randomint(2) ? critter%a_water_buffalo_run_a : critter%a_water_buffalo_run_b;
    self setanim(self.animation, 1, 0, 1);
}

// Namespace namespace_bb5d050c
// Params 7, eflags: 0x1 linked
// namespace_bb5d050c<file_0>::function_caf96f2d
// Checksum 0x4fa3529e, Offset: 0x27a8
// Size: 0x5c
function function_caf96f2d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread function_a8eb710();
    }
}

// Namespace namespace_bb5d050c
// Params 2, eflags: 0x1 linked
// namespace_bb5d050c<file_0>::function_27542390
// Checksum 0xcb822d64, Offset: 0x2810
// Size: 0x1c8
function function_27542390(localclientnum, state) {
    self endon(#"entityshutdown");
    self notify(#"animstate");
    self endon(#"animstate");
    self.animstate = state;
    self useanimtree(7);
    while (true) {
        switch (self.animstate) {
        case 0:
            if (isdefined(self.animation)) {
                self clearanim(self.animation, 0);
                self.animation = undefined;
            }
            break;
        case 1:
            self.animation = <unknown>%<unknown>;
            self setanim(self.animation, 1, 0.2, 1);
            break;
        case 2:
            self.animation = <unknown>%<unknown>;
            self setanimrestart(self.animation, 1, 0.2, 1);
            break;
        case 3:
            break;
        }
        if (isdefined(self.animation)) {
            time = getanimlength(self.animation);
            wait(time);
            continue;
        }
        return;
    }
}

// Namespace namespace_bb5d050c
// Params 7, eflags: 0x1 linked
// namespace_bb5d050c<file_0>::function_f9064aec
// Checksum 0xf0be704a, Offset: 0x29e0
// Size: 0x5c
function function_f9064aec(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread function_27542390(localclientnum, newval);
}

