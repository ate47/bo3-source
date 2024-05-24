#using scripts/zm/zm_temple_sq_brock;
#using scripts/zm/zm_temple_sq;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_audio;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_435c2400;

// Namespace namespace_435c2400
// Params 2, eflags: 0x1 linked
// Checksum 0xf6d2b9a2, Offset: 0x9c8
// Size: 0xd4
function function_98e846ee(character, vo) {
    entry = spawnstruct();
    switch (character) {
    case 0:
        entry.character = 0;
        break;
    case 1:
        entry.character = 1;
        break;
    case 3:
        entry.character = 3;
        break;
    case 2:
        entry.character = 2;
        break;
    }
    entry.vo = vo;
    return entry;
}

// Namespace namespace_435c2400
// Params 0, eflags: 0x1 linked
// Checksum 0x74b0a6c1, Offset: 0xaa8
// Size: 0xdb6
function function_2387a156() {
    if (!isdefined(level.var_bc33b0dc)) {
        level.var_bc33b0dc = [];
        level.var_bc33b0dc["tt1"] = array(function_98e846ee("dempsey", "vox_egg_skit_travel_1_0"), function_98e846ee("nikolai", "vox_egg_skit_travel_1_1"), function_98e846ee("takeo", "vox_egg_skit_travel_1_2"), function_98e846ee("richtofen", "vox_egg_skit_travel_1_3"), function_98e846ee("dempsey", "vox_egg_skit_travel_1_4"));
        level.var_bc33b0dc["tt2"] = array(function_98e846ee("takeo", "vox_egg_skit_travel_2_0"), function_98e846ee("nikolai", "vox_egg_skit_travel_2_1"), function_98e846ee("richtofen", "vox_egg_skit_travel_2_2"), function_98e846ee("dempsey", "vox_egg_skit_travel_2_3"), function_98e846ee("nikolai", "vox_egg_skit_travel_2_4"));
        level.var_bc33b0dc["tt3"] = array(function_98e846ee("dempsey", "vox_egg_skit_travel_3_0"), function_98e846ee("takeo", "vox_egg_skit_travel_3_1"), function_98e846ee("richtofen", "vox_egg_skit_travel_3_2"), function_98e846ee("nikolai", "vox_egg_skit_travel_3_3"), function_98e846ee("richtofen", "vox_egg_skit_travel_3_3a"), function_98e846ee("dempsey", "vox_egg_skit_travel_3_4"));
        level.var_bc33b0dc["tt4a"] = array(function_98e846ee("takeo", "vox_egg_skit_travel_4a_0"), function_98e846ee("dempsey", "vox_egg_skit_travel_4a_1"), function_98e846ee("richtofen", "vox_egg_skit_travel_4a_2"), function_98e846ee("nikolai", "vox_egg_skit_travel_4a_3"), function_98e846ee("dempsey", "vox_egg_skit_travel_4a_4"), function_98e846ee("dempsey", "vox_egg_skit_travel_4a_5"), function_98e846ee("dempsey", "vox_egg_skit_travel_4a_6"), function_98e846ee("richtofen", "vox_egg_skit_travel_4a_7"));
        level.var_bc33b0dc["tt4b"] = array(function_98e846ee("richtofen", "vox_egg_skit_travel_4b_0"), function_98e846ee("dempsey", "vox_egg_skit_travel_4b_1"), function_98e846ee("richtofen", "vox_egg_skit_travel_4b_2"), function_98e846ee("dempsey", "vox_egg_skit_travel_4b_3"), function_98e846ee("richtofen", "vox_egg_skit_travel_4b_4"), function_98e846ee("nikolai", "vox_egg_skit_travel_4b_5"), function_98e846ee("richtofen", "vox_egg_skit_travel_4b_6"));
        level.var_bc33b0dc["tt5"] = array(function_98e846ee("richtofen", "vox_egg_skit_travel_5_0"), function_98e846ee("takeo", "vox_egg_skit_travel_5_1"), function_98e846ee("dempsey", "vox_egg_skit_travel_5_2"), function_98e846ee("nikolai", "vox_egg_skit_travel_5_3"), function_98e846ee("richtofen", "vox_egg_skit_travel_5_4"));
        level.var_bc33b0dc["tt6"] = array(function_98e846ee("dempsey", "vox_egg_skit_travel_6_0"), function_98e846ee("richtofen", "vox_egg_skit_travel_6_1"), function_98e846ee("richtofen", "vox_egg_skit_travel_6_2"), function_98e846ee("nikolai", "vox_egg_skit_travel_6_3"), function_98e846ee("richtofen", "vox_egg_skit_travel_6_4"), function_98e846ee("takeo", "vox_egg_skit_travel_6_5"), function_98e846ee("takeo", "vox_egg_skit_travel_6_6"));
        level.var_bc33b0dc["tt7a"] = array(function_98e846ee("dempsey", "vox_egg_skit_travel_7a_0"), function_98e846ee("richtofen", "vox_egg_skit_travel_7a_1"), function_98e846ee("dempsey", "vox_egg_skit_travel_7a_2"), function_98e846ee("nikolai", "vox_egg_skit_travel_7a_3"), function_98e846ee("takeo", "vox_egg_skit_travel_7a_4"));
        level.var_bc33b0dc["tt7b"] = array(function_98e846ee("dempsey", "vox_egg_skit_travel_7b_0"), function_98e846ee("richtofen", "vox_egg_skit_travel_7b_1"), function_98e846ee("nikolai", "vox_egg_skit_travel_7b_2"), function_98e846ee("takeo", "vox_egg_skit_travel_7b_3"), function_98e846ee("takeo", "vox_egg_skit_travel_7b_4"));
        level.var_bc33b0dc["tt8"] = array(function_98e846ee("richtofen", "vox_egg_skit_travel_8_0"), function_98e846ee("dempsey", "vox_egg_skit_travel_8_1"), function_98e846ee("richtofen", "vox_egg_skit_travel_8_2"), function_98e846ee("nikolai", "vox_egg_skit_travel_8_3"), function_98e846ee("richtofen", "vox_egg_skit_travel_8_4"));
        level.var_bc33b0dc["fail1"] = array(function_98e846ee("dempsey", "vox_egg_skit_fail_0_0"), function_98e846ee("nikolai", "vox_egg_skit_fail_0_1"), function_98e846ee("takeo", "vox_egg_skit_fail_0_2"), function_98e846ee("richtofen", "vox_egg_skit_fail_0_3"));
        level.var_bc33b0dc["fail2"] = array(function_98e846ee("dempsey", "vox_egg_skit_fail_1_0"), function_98e846ee("nikolai", "vox_egg_skit_fail_2_1"), function_98e846ee("takeo", "vox_egg_skit_fail_3_2"), function_98e846ee("richtofen", "vox_egg_skit_fail_4_3"));
        level.var_bc33b0dc["fail3"] = array(function_98e846ee("dempsey", "vox_egg_skit_fail_0_0"), function_98e846ee("nikolai", "vox_egg_skit_fail_1_1"), function_98e846ee("takeo", "vox_egg_skit_fail_2_2"), function_98e846ee("richtofen", "vox_egg_skit_fail_3_3"));
        level.var_bc33b0dc["fail4"] = array(function_98e846ee("dempsey", "vox_egg_skit_fail_0_0"), function_98e846ee("nikolai", "vox_egg_skit_fail_1_1"), function_98e846ee("takeo", "vox_egg_skit_fail_2_2"), function_98e846ee("richtofen", "vox_egg_skit_fail_3_3"));
        level.var_bc33b0dc["start0"] = array(function_98e846ee("dempsey", "vox_egg_skit_start_0_0"), function_98e846ee("nikolai", "vox_egg_skit_start_0_1"), function_98e846ee("takeo", "vox_egg_skit_start_0_2"), function_98e846ee("richtofen", "vox_egg_skit_start_0_2a"), function_98e846ee("nikolai", "vox_egg_skit_start_0_3"), function_98e846ee("richtofen", "vox_egg_skit_start_0_4"), function_98e846ee("richtofen", "vox_egg_skit_start_0_5"));
        level.var_bc33b0dc["start1"] = array(function_98e846ee("takeo", "vox_egg_skit_start_1_0"), function_98e846ee("richtofen", "vox_egg_skit_start_1_1"), function_98e846ee("nikolai", "vox_egg_skit_start_1_2"), function_98e846ee("nikolai", "vox_egg_skit_start_1_3"), function_98e846ee("takeo", "vox_egg_skit_start_1_4"), function_98e846ee("nikolai", "vox_egg_skit_start_1_5"), function_98e846ee("dempsey", "vox_egg_skit_start_1_6"), function_98e846ee("dempsey", "vox_egg_skit_start_1_7"));
    }
}

// Namespace namespace_435c2400
// Params 2, eflags: 0x1 linked
// Checksum 0xa983f838, Offset: 0x1868
// Size: 0x444
function function_22d442e8(var_3b02d9c2, group) {
    level endon(#"hash_f180f1ce");
    if (!isdefined(level.var_12e02d45)) {
        buttons = getentarray("sq_sundial_button", "targetname");
        pos = (0, 0, 0);
        for (i = 0; i < buttons.size; i++) {
            pos += buttons[i].origin;
        }
        pos /= buttons.size;
        level.var_12e02d45 = pos;
    }
    if (!isdefined(var_3b02d9c2)) {
        var_3b02d9c2 = level.var_12e02d45;
    }
    while (true) {
        players = getplayers();
        if (isdefined(group)) {
            players = group;
        }
        var_2ce017e2 = 0;
        var_11295a10 = level.var_12e02d45;
        if (isdefined(group)) {
            var_11295a10 = (0, 0, 0);
            var_cb3cff2b = 0;
            for (i = 0; i < group.size; i++) {
                if (isdefined(group[i])) {
                    var_11295a10 += group[i].origin;
                    var_cb3cff2b++;
                }
            }
            if (var_cb3cff2b) {
                var_11295a10 /= var_cb3cff2b;
            }
        }
        for (i = 0; i < players.size; i++) {
            if (!isdefined(players[i])) {
                break;
            }
            dist_squared = distance2dsquared(players[i].origin, var_11295a10);
            if (isdefined(dist_squared)) {
                var_2ce017e2 = max(var_2ce017e2, dist_squared);
            }
        }
        if (var_2ce017e2 > 518400) {
            break;
        }
        wait(0.1);
    }
    level notify(#"hash_22d442e8");
    speaker = getplayers()[0];
    if (isdefined(level.var_1b611061)) {
        speaker = level.var_1b611061;
    }
    if (isdefined(speaker.var_d7c2ba50) && speaker.var_d7c2ba50) {
        while (isdefined(speaker) && speaker.var_d7c2ba50) {
            wait(0.2);
        }
    }
    character = speaker.characterindex;
    if (isdefined(speaker) && isdefined(speaker.var_62030aa3)) {
        character = speaker.var_62030aa3;
    }
    num = 5;
    if (character === 3) {
        num = 8;
    }
    snd = "vox_plr_" + character + "_safety_" + randomintrange(0, num);
    if (!isdefined(speaker)) {
        return;
    }
    /#
        iprintln(character + "vox_egg_skit_travel_1_0" + snd);
    #/
    speaker playsoundwithnotify(snd, "line_done");
    speaker waittill(#"hash_aca755da");
    level.var_c502e691 = 0;
}

// Namespace namespace_435c2400
// Params 1, eflags: 0x1 linked
// Checksum 0x9173ff5d, Offset: 0x1cb8
// Size: 0x1ba
function function_909060e5(var_a0bbcaa5) {
    players = getplayers();
    var_3b1f0101 = players[0];
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i].var_62030aa3)) {
            if (players[i].var_62030aa3 == var_a0bbcaa5.character) {
                var_3b1f0101 = players[i];
                break;
            }
            continue;
        }
        if (players[i].characterindex == var_a0bbcaa5.character) {
            var_3b1f0101 = players[i];
            break;
        }
    }
    var_3b1f0101.var_d7c2ba50 = 1;
    level.var_1b611061 = var_3b1f0101;
    if (!isdefined(var_3b1f0101)) {
        return;
    }
    /#
        iprintln(var_3b1f0101 getentitynumber() + "vox_egg_skit_travel_1_0" + var_a0bbcaa5.vo);
    #/
    var_3b1f0101 playsoundwithnotify(var_a0bbcaa5.vo, "line_done");
    var_3b1f0101 waittill(#"hash_aca755da");
    var_3b1f0101.var_d7c2ba50 = 0;
    level notify(#"hash_7d032c08");
}

// Namespace namespace_435c2400
// Params 2, eflags: 0x1 linked
// Checksum 0x740cc220, Offset: 0x1e80
// Size: 0xe4
function function_acc79afb(skit_name, group) {
    level endon(#"hash_22d442e8");
    script = level.var_bc33b0dc[skit_name];
    level.var_c502e691 = 1;
    level thread function_22d442e8(undefined, group);
    for (i = 0; i < script.size; i++) {
        if (i == script.size - 1) {
            level notify(#"hash_f180f1ce");
        }
        level thread function_909060e5(script[i]);
        level waittill(#"hash_7d032c08");
    }
    level.var_c502e691 = 0;
}

// Namespace namespace_435c2400
// Params 1, eflags: 0x1 linked
// Checksum 0x430fdb2c, Offset: 0x1f70
// Size: 0x35c
function function_b6268f3d(first_time) {
    var_a8e5ccfc = undefined;
    if (isdefined(first_time) && first_time) {
        var_a8e5ccfc = array(level.var_bc33b0dc["fail1"]);
    } else {
        var_a8e5ccfc = array(level.var_bc33b0dc["fail2"], level.var_bc33b0dc["fail3"], level.var_bc33b0dc["fail4"]);
    }
    players = getplayers();
    player_index = 0;
    var_fb29795b = undefined;
    while (player_index != players.size) {
        var_fb29795b = [];
        for (i = 0; i < players.size; i++) {
            if (i == player_index) {
                continue;
            }
            if (distance2dsquared(players[player_index].origin, players[i].origin) < 129600) {
                var_fb29795b[var_fb29795b.size] = players[i];
            }
        }
        player_index++;
        if (var_fb29795b.size > 0) {
            break;
        }
    }
    level.var_c502e691 = 1;
    skit = var_a8e5ccfc[randomintrange(0, var_a8e5ccfc.size)];
    if (var_fb29795b.size > 0) {
        pos = (0, 0, 0);
        for (i = 0; i < var_fb29795b.size; i++) {
            pos += var_fb29795b[i].origin;
        }
        pos /= var_fb29795b.size;
        level endon(#"hash_22d442e8");
        level thread function_22d442e8(pos, var_fb29795b);
        for (i = 0; i < var_fb29795b.size; i++) {
            level thread function_909060e5(skit[var_fb29795b[i].characterindex]);
            level waittill(#"hash_7d032c08");
        }
    } else {
        player = players[randomintrange(0, players.size)];
        level thread function_909060e5(skit[player.characterindex]);
        level waittill(#"hash_7d032c08");
    }
    level.var_c502e691 = 0;
}

