#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_util;
#using scripts/cp/cp_doa_bo3_fx;
#using scripts/cp/cp_doa_bo3_sound;
#using scripts/cp/doa/_doa_core;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/gametypes/coop;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicles/_quadtank;

#using_animtree("critter");

#namespace cp_doa_bo3;

// Namespace cp_doa_bo3
// Params 0, eflags: 0x0
// Checksum 0x9253e667, Offset: 0x5c0
// Size: 0x1da
function main() {
    setdvar("doa_redins_rally", 0);
    level.var_2eda2d85 = &function_62423327;
    level.var_1f314fb9 = &function_4eb73a5;
    cp_doa_bo3_fx::main();
    cp_doa_bo3_sound::main();
    clientfield::register("world", "redinsExploder", 1, 2, "int", &redinsExploder, 0, 0);
    clientfield::register("world", "activateBanner", 1, 3, "int", &function_99e9c8d, 0, 0);
    clientfield::register("world", "pumpBannerBar", 1, 8, "float", &pumpBannerBar, 0, 0);
    clientfield::register("world", "redinstutorial", 1, 1, "int", &redinstutorial, 0, 0);
    clientfield::register("world", "redinsinstruct", 1, 12, "int", &redinsinstruct, 0, 0);
    clientfield::register("scriptmover", "runcowanim", 1, 1, "int", &function_caf96f2d, 0, 0);
    namespace_693feb87::main();
    load::main();
}

// Namespace cp_doa_bo3
// Params 3, eflags: 0x0
// Checksum 0xb26f18fd, Offset: 0x7a8
// Size: 0x445
function function_4eb73a5(localclientnum, mapname, var_5fb1dd3e) {
    if (isdefined(level.var_c065e9ed)) {
        stopfx(localclientnum, level.var_c065e9ed);
    }
    level.var_c065e9ed = undefined;
    switch (mapname) {
    case "island":
        break;
    case "dock":
        if (var_5fb1dd3e == "night") {
            level.var_c065e9ed = playfxoncamera(localclientnum, level._effect["ambient_rainfall_" + randomintrange(1, 4)], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    case "farm":
        if (var_5fb1dd3e == "dusk" || var_5fb1dd3e == "night") {
            level.var_c065e9ed = playfxoncamera(localclientnum, level._effect["ambient_snowfall_1"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    case "graveyard":
        if (var_5fb1dd3e == "noon") {
            level.var_c065e9ed = playfxoncamera(localclientnum, level._effect["ambient_snowfall_1"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        } else if (var_5fb1dd3e == "night") {
            level.var_c065e9ed = playfxoncamera(localclientnum, level._effect["ambient_rainfall_" + randomintrange(1, 4)], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    case "temple":
        if (var_5fb1dd3e == "night") {
            level.var_c065e9ed = playfxoncamera(localclientnum, level._effect["ambient_rainfall_" + randomintrange(1, 4)], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    case "safehouse":
        break;
    case "blood":
        if (var_5fb1dd3e != "dusk") {
            level.var_c065e9ed = playfxoncamera(localclientnum, level._effect["ambient_snowfall_1"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    case "cave":
        break;
    case "vengeance":
        if (var_5fb1dd3e == "night") {
            level.var_c065e9ed = playfxoncamera(localclientnum, level._effect["ambient_rainfall_" + randomintrange(1, 4)], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    case "sgen":
        break;
    case "apartments":
        if (var_5fb1dd3e == "night") {
            level.var_c065e9ed = playfxoncamera(localclientnum, level._effect["ambient_rainfall_" + randomintrange(1, 4)], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    case "sector":
        break;
    case "metro":
        if (var_5fb1dd3e == "night") {
            level.var_c065e9ed = playfxoncamera(localclientnum, level._effect["ambient_snowfall_1"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    case "clearing":
        if (var_5fb1dd3e != "night") {
            level.var_c065e9ed = playfxoncamera(localclientnum, level._effect["ambient_snowfall_1"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    case "newworld":
        if (var_5fb1dd3e == "dusk" || var_5fb1dd3e == "night") {
            level.var_c065e9ed = playfxoncamera(localclientnum, level._effect["ambient_snowfall_1"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    case "boss":
        if (var_5fb1dd3e == "night") {
            level.var_c065e9ed = playfxoncamera(localclientnum, level._effect["ambient_rainfall_" + randomintrange(1, 4)], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        }
        break;
    }
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x0
// Checksum 0xcad54979, Offset: 0xbf8
// Size: 0x1a9
function function_62423327(arena) {
    switch (arena.name) {
    case "redins":
        arena.var_f3114f93 = &function_787f2b69;
        arena.var_aad78940 = 99;
        arena.var_f4f1abf3 = 1;
        arena.var_dd94482c = 1 + 8 + 4;
        arena.var_ecf7ec70 = 0;
        break;
    case "tankmaze":
        arena.var_aad78940 = 99;
        arena.var_dd94482c = 1 + 4;
        arena.var_ecf7ec70 = 2;
        break;
    case "spiral":
        arena.var_aad78940 = 2;
        arena.var_dd94482c = 1;
        arena.var_ecf7ec70 = 0;
        break;
    case "truck_soccer":
        arena.var_f3114f93 = &function_b5e8546d;
        arena.var_aad78940 = 99;
        arena.var_dd94482c = 1 + 8 + 4;
        arena.var_ecf7ec70 = 2;
        break;
    case "alien_armory":
    case "armory":
    case "bomb_storage":
    case "coop":
    case "hangar":
    case "vault":
    case "wolfhole":
        arena.var_dd94482c = 4;
        arena.var_ecf7ec70 = 2;
        break;
    case "apartments":
        arena.var_bfa5d6ae = 1;
        break;
    default:
        break;
    }
}

// Namespace cp_doa_bo3
// Params 7, eflags: 0x0
// Checksum 0xe1d69c7c, Offset: 0xdb0
// Size: 0x6a
function pumpBannerBar(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setuimodelvalue(getuimodel(level.var_7e2a814c, "gpr0"), newval);
}

// Namespace cp_doa_bo3
// Params 7, eflags: 0x0
// Checksum 0x94a38643, Offset: 0xe28
// Size: 0x785
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

// Namespace cp_doa_bo3
// Params 1, eflags: 0x0
// Checksum 0xae9c8d9e, Offset: 0x15b8
// Size: 0x4a
function function_b5e8546d(localclientnum) {
    setuimodelvalue(createuimodel(level.var_7e2a814c, "driving"), 1);
    level thread function_caffcc1d(localclientnum);
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x0
// Checksum 0x56373ab, Offset: 0x1610
// Size: 0x42
function function_caffcc1d(localclientnum) {
    level waittill(#"hash_ec7ca67b");
    setuimodelvalue(createuimodel(level.var_7e2a814c, "driving"), 0);
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x0
// Checksum 0x5c90d584, Offset: 0x1660
// Size: 0x22a
function function_c8020bd9(localclientnum) {
    level waittill(#"hash_ec7ca67b");
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

// Namespace cp_doa_bo3
// Params 2, eflags: 0x0
// Checksum 0x4f1951b7, Offset: 0x1898
// Size: 0x92
function function_7183a31d(fieldname, diff) {
    level notify(#"hash_7183a31d");
    level endon(#"hash_7183a31d");
    setuimodelvalue(createuimodel(level.var_7e2a814c, "gtxt0"), "+" + diff);
    wait 2;
    setuimodelvalue(createuimodel(level.var_7e2a814c, "gtxt0"), "");
}

// Namespace cp_doa_bo3
// Params 0, eflags: 0x0
// Checksum 0xc2cd688e, Offset: 0x1938
// Size: 0x4d
function function_ec984567() {
    level endon(#"hash_ec7ca67b");
    while (true) {
        level waittill(#"hash_48152b36", fieldname, diff);
        if (diff > 0) {
            level thread function_7183a31d(fieldname, diff);
        }
    }
}

// Namespace cp_doa_bo3
// Params 7, eflags: 0x0
// Checksum 0x349eb80, Offset: 0x1990
// Size: 0xc5
function redinsExploder(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
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

// Namespace cp_doa_bo3
// Params 7, eflags: 0x0
// Checksum 0xc707882, Offset: 0x1a60
// Size: 0xf2
function redinsinstruct(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    if (newval) {
        var_a923fad3 = !true;
        InvalidOpCode(0xe1, 4, newval, newval);
        // Unknown operator (0xe1, t7_1b, PC)
    }
    setuimodelvalue(createuimodel(level.var_7e2a814c, "instruct"), "");
}

// Namespace cp_doa_bo3
// Params 7, eflags: 0x0
// Checksum 0x6bec9bf3, Offset: 0x1b60
// Size: 0x169
function redinstutorial(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
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
                level waittill(#"countdown", val);
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

// Namespace cp_doa_bo3
// Params 1, eflags: 0x0
// Checksum 0x5992e352, Offset: 0x1cd8
// Size: 0x315
function function_787f2b69(localclientnum) {
    level endon(#"hash_ec7ca67b");
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
        wait 0.1;
    }
}

// Namespace cp_doa_bo3
// Params 0, eflags: 0x0
// Checksum 0x2086bbe3, Offset: 0x1ff8
// Size: 0x8a
function function_a8eb710() {
    self endon(#"entityshutdown");
    self useanimtree(#critter);
    self.animation = randomint(2) ? critter%a_water_buffalo_run_a : critter%a_water_buffalo_run_b;
    self setanim(self.animation, 1, 0, 1);
}

// Namespace cp_doa_bo3
// Params 7, eflags: 0x0
// Checksum 0x4f5fbd89, Offset: 0x2090
// Size: 0x52
function function_caf96f2d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread function_a8eb710();
    }
}

