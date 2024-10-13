#using scripts/cp/_skipto;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/cp/_util;
#using scripts/codescripts/struct;

#namespace achievements;

// Namespace achievements
// Params 0, eflags: 0x2
// Checksum 0xd606ca34, Offset: 0x548
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("achievements", &__init__, undefined, undefined);
}

// Namespace achievements
// Params 0, eflags: 0x1 linked
// Checksum 0xcb5b452b, Offset: 0x588
// Size: 0xe4
function __init__() {
    callback::on_connect(&on_player_connect);
    callback::on_ai_spawned(&on_ai_spawned);
    callback::on_ai_damage(&on_ai_damage);
    callback::on_ai_killed(&on_ai_killed);
    callback::on_player_killed(&on_player_death);
    spawner::add_archetype_spawn_function("wasp", &function_632712d7, 3);
    function_4462a8b7();
}

// Namespace achievements
// Params 0, eflags: 0x1 linked
// Checksum 0x895db7e7, Offset: 0x678
// Size: 0x11a
function function_4462a8b7() {
    level.var_a4d4c1e3["cp_mi_cairo_aquifer"] = "CP_COMPLETE_AQUIFER";
    level.var_a4d4c1e3["cp_mi_sing_biodomes"] = "CP_COMPLETE_BIODOMES";
    level.var_a4d4c1e3["cp_mi_sing_blackstation"] = "CP_COMPLETE_BLACKSTATION";
    level.var_a4d4c1e3["cp_mi_cairo_infection"] = "CP_COMPLETE_INFECTION";
    level.var_a4d4c1e3["cp_mi_cairo_lotus"] = "CP_COMPLETE_LOTUS";
    level.var_a4d4c1e3["cp_mi_zurich_newworld"] = "CP_COMPLETE_NEWWORLD";
    level.var_a4d4c1e3["cp_mi_eth_prologue"] = "CP_COMPLETE_PROLOGUE";
    level.var_a4d4c1e3["cp_mi_cairo_ramses"] = "CP_COMPLETE_RAMSES";
    level.var_a4d4c1e3["cp_mi_sing_sgen"] = "CP_COMPLETE_SGEN";
    level.var_a4d4c1e3["cp_mi_sing_vengeance"] = "CP_COMPLETE_VENGEANCE";
}

// Namespace achievements
// Params 2, eflags: 0x1 linked
// Checksum 0x188ef673, Offset: 0x7a0
// Size: 0xac
function function_52c9c74a(str_id, var_56503a18) {
    if (!isdefined(var_56503a18)) {
        var_56503a18 = 0;
    }
    if (sessionmodeiscampaignzombiesgame() && !var_56503a18) {
        return;
    }
    /#
        printtoprightln("<dev string:x28>" + str_id, (1, 1, 1));
        println("<dev string:x28>" + str_id);
    #/
    self giveachievement(str_id);
}

// Namespace achievements
// Params 0, eflags: 0x1 linked
// Checksum 0xf3d0c2ed, Offset: 0x858
// Size: 0xe8
function on_player_connect() {
    self endon(#"disconnect");
    self.var_75cf9e2e = spawnstruct();
    self.var_75cf9e2e.var_ac197c3f = 0;
    self.var_75cf9e2e.var_940a9f6e = 0;
    self.var_75cf9e2e.kills = [];
    self.var_75cf9e2e.var_43311285 = [];
    self thread wall_run();
    self thread function_e587e1f2();
    while (true) {
        str_id = self waittill(#"hash_52c9c74a");
        function_52c9c74a(str_id);
    }
}

// Namespace achievements
// Params 3, eflags: 0x1 linked
// Checksum 0x94943805, Offset: 0x948
// Size: 0x74
function function_5f2f7800(eplayer, levelname, difficulty) {
    if (!isdefined(levelname) || !isdefined(level.var_a4d4c1e3[levelname])) {
        return;
    }
    if (difficulty < 2) {
        return;
    }
    eplayer function_52c9c74a(level.var_a4d4c1e3[levelname]);
}

// Namespace achievements
// Params 1, eflags: 0x1 linked
// Checksum 0x5dab7b87, Offset: 0x9c8
// Size: 0x244
function function_c3e7ff05(eplayer) {
    var_44a14bc7 = [];
    for (index = 0; index <= 4; index++) {
        var_44a14bc7[index] = 0;
    }
    var_7941f5c8 = skipto::function_23eda99c();
    var_f0ecfb92 = 0;
    foreach (mission in var_7941f5c8) {
        if (!eplayer getdstat("PlayerStatsByMap", mission, "hasBeenCompleted")) {
            continue;
        }
        highestdifficulty = eplayer getdstat("PlayerStatsByMap", mission, "highestStats", "HIGHEST_DIFFICULTY");
        if (!isdefined(var_44a14bc7[highestdifficulty])) {
            var_44a14bc7[highestdifficulty] = 0;
        }
        var_44a14bc7[highestdifficulty]++;
        var_f0ecfb92++;
    }
    var_98680dde = var_7941f5c8.size;
    if (var_f0ecfb92 == var_98680dde) {
        eplayer function_52c9c74a("CP_CAMPAIGN_COMPLETE");
    }
    if (var_44a14bc7[2] + var_44a14bc7[3] + var_44a14bc7[4] == var_98680dde) {
        eplayer function_52c9c74a("CP_HARD_COMPLETE");
    }
    if (var_44a14bc7[4] == var_98680dde) {
        eplayer function_52c9c74a("CP_REALISTIC_COMPLETE");
    }
}

// Namespace achievements
// Params 4, eflags: 0x1 linked
// Checksum 0x5dc98f99, Offset: 0xc18
// Size: 0x64
function function_733a6065(eplayer, levelname, difficulty, var_10c5a3ef) {
    if (!var_10c5a3ef) {
        function_5f2f7800(eplayer, levelname, difficulty);
        function_c3e7ff05(eplayer);
    }
}

// Namespace achievements
// Params 0, eflags: 0x1 linked
// Checksum 0x609cfd03, Offset: 0xc88
// Size: 0x138
function wall_run() {
    self endon(#"disconnect");
    while (true) {
        self waittill(#"wallrun_begin");
        v_start = self.origin;
        self waittill(#"wallrun_end");
        var_1d634a25 = distance(v_start, self.origin);
        var_3411368a = self getdstat("Achievements", "CP_COMPLETE_WALL_RUN");
        var_3411368a += var_1d634a25;
        /#
            printtoprightln(var_3411368a, (1, 1, 1));
        #/
        if (var_3411368a >= 9843) {
            function_52c9c74a("CP_COMPLETE_WALL_RUN");
            return;
        }
        self setdstat("Achievements", "CP_COMPLETE_WALL_RUN", int(var_3411368a));
    }
}

// Namespace achievements
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xdc8
// Size: 0x4
function on_ai_spawned() {
    
}

// Namespace achievements
// Params 1, eflags: 0x1 linked
// Checksum 0x94078186, Offset: 0xdd8
// Size: 0x64
function on_ai_damage(s_params) {
    self.var_74390712 = undefined;
    if (isplayer(s_params.eattacker)) {
        if (s_params.idflags & 8) {
            self.var_74390712 = s_params.eattacker;
        }
    }
}

// Namespace achievements
// Params 1, eflags: 0x1 linked
// Checksum 0xe1aeb598, Offset: 0xe48
// Size: 0x5c
function on_player_death(s_params) {
    self.var_75cf9e2e.var_ac197c3f = 0;
    self.var_75cf9e2e.var_940a9f6e = 0;
    self.var_75cf9e2e.kills = [];
    self.var_75cf9e2e.var_43311285 = [];
}

// Namespace achievements
// Params 2, eflags: 0x5 linked
// Checksum 0x31717bfd, Offset: 0xeb0
// Size: 0x16c
function private function_1121f26a(var_c856ad1d, evictim) {
    if (isdefined(var_c856ad1d.hijacked_vehicle_entity)) {
        var_1efe785f = distance(var_c856ad1d.hijacked_vehicle_entity.origin, evictim.origin);
    } else {
        var_1efe785f = distance(var_c856ad1d.origin, evictim.origin);
    }
    if (var_1efe785f >= 3937) {
        var_46907f23 = var_c856ad1d getdstat("Achievements", "CP_DISTANCE_KILL");
        var_46907f23++;
        /#
            printtoprightln("<dev string:x3f>" + var_1efe785f + "<dev string:x40>" + var_46907f23, (1, 1, 1));
        #/
        if (var_46907f23 >= 5) {
            var_c856ad1d function_52c9c74a("CP_DISTANCE_KILL");
            return;
        }
        var_c856ad1d setdstat("Achievements", "CP_DISTANCE_KILL", var_46907f23);
    }
}

// Namespace achievements
// Params 4, eflags: 0x5 linked
// Checksum 0x82e2b9b4, Offset: 0x1028
// Size: 0x48c
function private function_914b8688(player, evictim, weapon, einflictor) {
    if (!isdefined(weapon)) {
        return;
    }
    if (!isdefined(player.var_58477d59)) {
        player.var_58477d59 = [];
        player.var_58477d59["CP_FLYING_WASP_KILL"] = 0;
        player.var_58477d59["CP_COMBAT_ROBOT_KILL"] = 0;
    }
    var_9663b3f1 = 0;
    if (weapon.name == "gadget_firefly_swarm" || weapon.name == "gadget_firefly_swarm_upgraded") {
        function_9dab90e7(player);
        var_9663b3f1 = 1;
    } else if (isdefined(player.var_75cf9e2e.var_6ce188b0) && weapon.name == "gadget_unstoppable_force" || weapon.name == "gadget_unstoppable_force_upgraded") {
        player.var_75cf9e2e.var_6ce188b0++;
        if (player.var_75cf9e2e.var_6ce188b0 >= 5) {
            player function_52c9c74a("CP_UNSTOPPABLE_KILL");
        }
    } else if (isdefined(player.hijacked_vehicle_entity)) {
        if (isdefined(player.hijacked_vehicle_entity.killcount)) {
            player.hijacked_vehicle_entity.killcount++;
        } else {
            player.hijacked_vehicle_entity.killcount = 1;
        }
        if (player.hijacked_vehicle_entity.scriptvehicletype == "wasp" && player.hijacked_vehicle_entity.killcount >= 20) {
            if (!player.var_58477d59["CP_FLYING_WASP_KILL"]) {
                player function_52c9c74a("CP_FLYING_WASP_KILL");
                player.var_58477d59["CP_FLYING_WASP_KILL"] = 1;
            }
        }
        if (player.hijacked_vehicle_entity.killcount >= 10) {
            if (!player.var_58477d59["CP_COMBAT_ROBOT_KILL"]) {
                player function_52c9c74a("CP_COMBAT_ROBOT_KILL");
                player.var_58477d59["CP_COMBAT_ROBOT_KILL"] = 1;
            }
        }
    } else if (isai(einflictor) && isdefined(einflictor.remote_owner) && einflictor.remote_owner == player) {
        if (isdefined(einflictor.killcount)) {
            einflictor.killcount++;
        } else {
            einflictor.killcount = 1;
        }
        if (einflictor.killcount >= 10) {
            if (!player.var_58477d59["CP_COMBAT_ROBOT_KILL"]) {
                player function_52c9c74a("CP_COMBAT_ROBOT_KILL");
                player.var_58477d59["CP_COMBAT_ROBOT_KILL"] = 1;
            }
        }
    }
    if (isdefined(evictim.swarm) && !var_9663b3f1) {
        function_9dab90e7(player);
    }
    if (isdefined(player.var_75cf9e2e.var_a4fb0163) && player.var_75cf9e2e.var_a4fb0163 >= 6) {
        player function_52c9c74a("CP_FIREFLIES_KILL");
    }
}

// Namespace achievements
// Params 3, eflags: 0x5 linked
// Checksum 0x4f15c880, Offset: 0x14c0
// Size: 0x17c
function private function_2b2fb40b(player, var_aae1ed0d, weapon) {
    player.var_75cf9e2e.var_940a9f6e++;
    currentindex = player.var_75cf9e2e.var_ac197c3f;
    player.var_75cf9e2e.kills[currentindex] = gettime();
    player.var_75cf9e2e.var_ac197c3f = (currentindex + 1) % 10;
    if (player.var_75cf9e2e.var_940a9f6e < 10) {
        return;
    }
    startindex = (currentindex + 1) % 10;
    starttime = player.var_75cf9e2e.kills[startindex];
    endtime = player.var_75cf9e2e.kills[currentindex];
    if (player.var_75cf9e2e.var_940a9f6e >= 10 && endtime - starttime <= 3000) {
        player function_52c9c74a("CP_TIMED_KILL");
    }
}

// Namespace achievements
// Params 2, eflags: 0x5 linked
// Checksum 0x25e2b1f9, Offset: 0x1648
// Size: 0x18c
function private function_b1d71bd3(player, weapon) {
    baseindex = getbaseweaponitemindex(weapon);
    if (baseindex < 1 || !isdefined(baseindex) || baseindex > 60) {
        return;
    }
    player.var_75cf9e2e.var_43311285[weapon.rootweapon.name] = gettime();
    var_6c46ba29 = 0;
    var_376861f6 = gettime() - 30000;
    if (var_376861f6 < 0) {
        var_376861f6 = 0;
    }
    foreach (lastkilltime in player.var_75cf9e2e.var_43311285) {
        if (lastkilltime > var_376861f6) {
            var_6c46ba29++;
        }
    }
    if (var_6c46ba29 >= 5) {
        player function_52c9c74a("CP_DIFFERENT_GUN_KILL");
    }
}

// Namespace achievements
// Params 3, eflags: 0x5 linked
// Checksum 0x727cb614, Offset: 0x17e0
// Size: 0x24c
function private function_307b3ac3(eplayer, evictim, eweapon) {
    if (!evictim util::function_d9c13489() || evictim.team !== "axis") {
        return;
    }
    if (!isdefined(eplayer.var_75cf9e2e.var_6a670270)) {
        eplayer.var_75cf9e2e.var_6a670270 = [];
    }
    if (!isdefined(eplayer.var_75cf9e2e.var_6a670270)) {
        eplayer.var_75cf9e2e.var_6a670270 = [];
    } else if (!isarray(eplayer.var_75cf9e2e.var_6a670270)) {
        eplayer.var_75cf9e2e.var_6a670270 = array(eplayer.var_75cf9e2e.var_6a670270);
    }
    eplayer.var_75cf9e2e.var_6a670270[eplayer.var_75cf9e2e.var_6a670270.size] = gettime();
    startindex = eplayer.var_75cf9e2e.var_6a670270.size - 1;
    maxtime = gettime() - 3000;
    for (var_7b5c89e6 = startindex; var_7b5c89e6 >= 0; var_7b5c89e6--) {
        if (eplayer.var_75cf9e2e.var_6a670270[var_7b5c89e6] < maxtime) {
            arrayremoveindex(eplayer.var_75cf9e2e.var_6a670270, var_7b5c89e6);
        }
    }
    if (eplayer.var_75cf9e2e.var_6a670270.size >= 5) {
        eplayer function_52c9c74a("CP_TIMED_STUNNED_KILL");
    }
}

// Namespace achievements
// Params 3, eflags: 0x5 linked
// Checksum 0xc41a2fc8, Offset: 0x1a38
// Size: 0xec
function private function_c4f2de38(player, victim, inflictor) {
    if (!isdefined(inflictor.weapon) || !isdefined(self.scriptvehicletype) || self.scriptvehicletype != "wasp" || inflictor.weapon.type != "grenade") {
        return;
    }
    if (!isdefined(inflictor.var_9bbaef3)) {
        inflictor.var_9bbaef3 = 1;
    } else {
        inflictor.var_9bbaef3++;
    }
    if (inflictor.var_9bbaef3 >= 3) {
        player function_52c9c74a("CP_KILL_WASPS");
    }
}

// Namespace achievements
// Params 3, eflags: 0x1 linked
// Checksum 0x3027eed4, Offset: 0x1b30
// Size: 0xc4
function function_17ec453c(eattacker, evictim, eweapon) {
    if (isdefined(eattacker.var_6fb3bfc3) && isplayer(eattacker.var_6fb3bfc3)) {
        if (isdefined(eattacker.killcount)) {
            eattacker.killcount++;
        } else {
            eattacker.killcount = 1;
        }
        if (eattacker.killcount >= 10) {
            eattacker.var_6fb3bfc3 function_52c9c74a("CP_COMBAT_ROBOT_KILL");
        }
    }
}

// Namespace achievements
// Params 2, eflags: 0x1 linked
// Checksum 0x19cb686e, Offset: 0x1c00
// Size: 0x7c
function function_99d6210d(eplayer, evictim) {
    if (isdefined(evictim.var_74390712) && evictim.var_74390712 == eplayer && evictim.team !== "allies") {
        eplayer function_52c9c74a("CP_OBSTRUCTED_KILL");
    }
}

// Namespace achievements
// Params 1, eflags: 0x1 linked
// Checksum 0xfce6693e, Offset: 0x1c88
// Size: 0x5c
function function_fbe029db(eplayer) {
    var_ba8faef8 = eplayer getmeleechaincount();
    if (2 <= var_ba8faef8) {
        eplayer function_52c9c74a("CP_MELEE_COMBO_KILL");
    }
}

// Namespace achievements
// Params 1, eflags: 0x1 linked
// Checksum 0x38b1bd89, Offset: 0x1cf0
// Size: 0x1ac
function on_ai_killed(s_params) {
    if (isplayer(s_params.eattacker)) {
        player = s_params.eattacker;
        function_1121f26a(player, self);
        function_914b8688(player, self, s_params.weapon, s_params.einflictor);
        function_fbe029db(player);
        function_2b2fb40b(player, self, s_params.weapon);
        function_b1d71bd3(player, s_params.weapon);
        function_c4f2de38(player, self, s_params.einflictor);
        function_307b3ac3(player, self, s_params.weapon);
        function_99d6210d(player, self);
        return;
    }
    if (isai(s_params.eattacker)) {
        function_17ec453c(s_params.eattacker, self, s_params.weapon);
    }
}

// Namespace achievements
// Params 1, eflags: 0x1 linked
// Checksum 0x6a438277, Offset: 0x1ea8
// Size: 0xc
function function_632712d7(n_count) {
    
}

// Namespace achievements
// Params 1, eflags: 0x5 linked
// Checksum 0xf271b138, Offset: 0x1ec0
// Size: 0x60
function private function_9dab90e7(player) {
    if (!isdefined(player.var_75cf9e2e.var_a4fb0163)) {
        player.var_75cf9e2e.var_a4fb0163 = 1;
        return;
    }
    player.var_75cf9e2e.var_a4fb0163++;
}

// Namespace achievements
// Params 0, eflags: 0x5 linked
// Checksum 0x3d213abf, Offset: 0x1f28
// Size: 0xac
function private function_e587e1f2() {
    self endon(#"disconnect");
    while (true) {
        rewardxp, attachmentindex, itemindex, rankid, islastrank = self waittill(#"gun_level_complete");
        if (itemindex >= 1 && islastrank && itemindex <= 60) {
            self function_52c9c74a("CP_ALL_WEAPON_ATTACHMENTS");
            break;
        }
    }
}

// Namespace achievements
// Params 1, eflags: 0x1 linked
// Checksum 0xdb95929f, Offset: 0x1fe0
// Size: 0x34
function function_17dc8de7(var_e9af7d73) {
    if (var_e9af7d73 == 3) {
        self function_52c9c74a("CP_ALL_WEAPON_CAMOS");
    }
}

// Namespace achievements
// Params 0, eflags: 0x1 linked
// Checksum 0x31223000, Offset: 0x2020
// Size: 0xc0
function function_b2d1aafa() {
    if (level.cybercom.var_12f85dec == 0) {
        foreach (player in level.players) {
            if (!isdefined(player.var_75cf9e2e.var_a4fb0163)) {
                continue;
            }
            player.var_75cf9e2e.var_a4fb0163 = undefined;
        }
    }
}

// Namespace achievements
// Params 1, eflags: 0x1 linked
// Checksum 0xce3ad276, Offset: 0x20e8
// Size: 0x24
function function_386309ce(player) {
    player.var_75cf9e2e.var_6ce188b0 = 0;
}

// Namespace achievements
// Params 1, eflags: 0x1 linked
// Checksum 0x536761ba, Offset: 0x2118
// Size: 0x2e
function function_6903d776(eai) {
    if (isdefined(eai.killcount)) {
        eai.killcount = undefined;
    }
}

