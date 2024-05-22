#using scripts/cp/cp_doa_bo3_enemy;
#using scripts/cp/cp_doa_bo3_silverback_battle;
#using scripts/cp/doa/_doa_gibs;
#using scripts/cp/doa/_doa_fate;
#using scripts/cp/doa/_doa_hazard;
#using scripts/cp/doa/_doa_tesla_pickup;
#using scripts/cp/doa/_doa_vehicle_pickup;
#using scripts/cp/doa/_doa_turret_pickup;
#using scripts/cp/doa/_doa_audio;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_enemy_boss;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/array_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

// Can't decompile export namespace_917e49b3::function_5e04bf78

// Can't decompile export namespace_917e49b3::function_7206982b

// Can't decompile export namespace_917e49b3::function_fb3b78fe

// Can't decompile export namespace_917e49b3::function_e4d4b80

#namespace namespace_917e49b3;

// Namespace namespace_917e49b3
// Params 0, eflags: 0x1 linked
// Checksum 0x6bd79db7, Offset: 0xd98
// Size: 0x574
function function_d4766377() {
    if (!isdefined(level.doa.var_27f5178d)) {
        level.doa.var_27f5178d = struct::get_array("podium_zombie_spectate", "targetname");
        level.doa.var_260a85f3 = array("c_zom_zod_zombie_cin_fb1", "c_zom_zod_zombie_cin_fb2", "c_zom_zod_zombie_cin_fb3", "c_zom_zod_zombie_fem_cin_fb1");
    }
    if (!isdefined(level.doa.var_799853ee)) {
        level.doa.var_799853ee = getent("podium_damage_trigger", "targetname");
    }
    level.doa.var_799853ee triggerenable(0);
    if (!isdefined(level.doa.var_92721db3)) {
        var_92721db3 = getentarray("podium_spot", "targetname");
        level.doa.var_92721db3 = [];
        for (i = 0; i < 4; i++) {
            for (j = 0; j < var_92721db3.size; j++) {
                if (i == int(var_92721db3[j].script_noteworthy)) {
                    end = level.doa.var_92721db3.size;
                    level.doa.var_92721db3[end] = var_92721db3[j];
                    level.doa.var_92721db3[end].position = i;
                }
            }
        }
    }
    foreach (var_d13b8f3d in level.doa.var_92721db3) {
        if (isdefined(var_d13b8f3d.var_53538eb0)) {
            var_d13b8f3d.var_53538eb0 delete();
        }
        if (isdefined(var_d13b8f3d.playermodel)) {
            var_d13b8f3d.playermodel delete();
        }
        var_d13b8f3d.player = undefined;
        var_d13b8f3d hide();
        var_d13b8f3d notsolid();
    }
    if (!isdefined(level.doa.var_b7f5f6c8)) {
        var_b519899f = struct::get_array("podium_silverback", "targetname");
        level.doa.var_b7f5f6c8 = [];
        foreach (point in var_b519899f) {
            level.doa.var_b7f5f6c8[int(point.script_noteworthy)] = point;
        }
    }
    foreach (spot in level.doa.var_27f5178d) {
        if (isdefined(spot.spectator)) {
            if (isdefined(spot.spectator.org)) {
                spot.spectator.org delete();
            }
            spot.spectator delete();
        }
    }
    level clientfield::set("redinsExploder", 0);
    level clientfield::set("podiumEvent", 0);
}

// Namespace namespace_917e49b3
// Params 1, eflags: 0x1 linked
// Checksum 0xba963cf9, Offset: 0x1318
// Size: 0x2cc
function function_ef727812(num) {
    /#
        assert(isdefined(level.doa.var_92721db3));
    #/
    foreach (var_d13b8f3d in level.doa.var_92721db3) {
        var_d13b8f3d.var_53538eb0 = spawn("script_model", var_d13b8f3d.origin);
        var_d13b8f3d.var_53538eb0 thread namespace_49107f3a::function_783519c1("podiumAllDone", 1);
        var_d13b8f3d.var_53538eb0 setmodel(var_d13b8f3d.model);
        var_d13b8f3d.var_53538eb0.angles = var_d13b8f3d.angles;
        num--;
        if (num == 0) {
            break;
        }
    }
    level.doa.var_799853ee triggerenable(1);
    foreach (spot in level.doa.var_27f5178d) {
        spot.spectator = spawn("script_model", spot.origin);
        spot.spectator thread namespace_49107f3a::function_783519c1("podiumAllDone", 1);
        spot.spectator.angles = spot.angles;
        spot.spectator thread function_5e06cff2();
    }
    level clientfield::set("podiumEvent", 1);
}

// Namespace namespace_917e49b3
// Params 0, eflags: 0x1 linked
// Checksum 0x46dc5f3, Offset: 0x15f0
// Size: 0xc0
function function_a85eaca4() {
    level endon(#"podiumalldone");
    players = function_4d8b6e1e();
    winner = players[0];
    while (true) {
        if (!isdefined(winner)) {
            players = function_4d8b6e1e();
            winner = players[0];
        }
        if (!isdefined(winner)) {
            return;
        }
        if (winner throwbuttonpressed()) {
            level notify(#"hash_115c344c");
        }
        wait(0.05);
    }
}

// Namespace namespace_917e49b3
// Params 0, eflags: 0x1 linked
// Checksum 0x3399359, Offset: 0x16b8
// Size: 0x3cc
function function_e2d6beb9() {
    level clientfield::set("roundMenu", 0);
    level clientfield::set("teleportMenu", 0);
    level clientfield::set("numexits", 0);
    players = function_4d8b6e1e();
    function_ef727812(players.size);
    level.doa.var_44d58db8 = players;
    level.var_3997f9e8 = spawn("script_origin", (0, 0, 0));
    level.var_3997f9e8 playloopsound("evt_ending_zombies_looper", 3);
    i = 0;
    foreach (player in players) {
        level.doa.var_92721db3[i].player = player;
        i++;
    }
    foreach (var_d13b8f3d in level.doa.var_92721db3) {
        if (isdefined(var_d13b8f3d.player)) {
            level thread function_2b20420b(var_d13b8f3d);
        }
    }
    level thread function_a85eaca4();
    level thread function_5e04bf78();
    level notify(#"hash_b96c96ac");
    level notify(#"hash_97276c43");
    wait(1);
    var_1a87bae6 = level.lighting_state;
    level thread namespace_49107f3a::set_lighting_state(1);
    level thread namespace_49107f3a::function_390adefe(0);
    level notify(#"hash_314666df");
    level thread function_d834fdd0();
    msg = level util::waittill_any_timeout(30, "silverbackAllDone");
    if (msg == "timeout") {
        level notify(#"hash_a099b4d6");
        level waittill(#"hash_115c344c");
    }
    level.var_3997f9e8 delete();
    namespace_49107f3a::function_44eb090b();
    level notify(#"podiumalldone");
    function_d4766377();
    level thread namespace_49107f3a::function_13fbad22();
    level thread namespace_49107f3a::set_lighting_state(var_1a87bae6);
}

// Namespace namespace_917e49b3
// Params 2, eflags: 0x1 linked
// Checksum 0x8c0ecd04, Offset: 0x2d78
// Size: 0xec
function function_f7e6e4b1(scale, var_fb37ad89) {
    if (!isdefined(scale)) {
        scale = 1;
    }
    if (!isdefined(var_fb37ad89)) {
        var_fb37ad89 = 9999;
    }
    level endon(#"podiumalldone");
    self endon(#"death");
    while (true) {
        level waittill(#"hash_71c0bde9");
        vector = (randomint(20), randomint(20), 30) * scale;
        self physicslaunch(self.origin, vector);
        var_fb37ad89--;
        if (var_fb37ad89 < 0) {
            return;
        }
    }
}

// Namespace namespace_917e49b3
// Params 0, eflags: 0x1 linked
// Checksum 0x96cf2d5f, Offset: 0x2e70
// Size: 0x2da
function function_d834fdd0() {
    level endon(#"podiumalldone");
    level waittill(#"hash_71c0bde9");
    level.doa.var_e102b46 thread namespace_eaa992c::function_285a2999("bomb");
    foreach (var_d13b8f3d in level.doa.var_92721db3) {
        if (isdefined(var_d13b8f3d.var_53538eb0)) {
            var_d13b8f3d.var_53538eb0 physicslaunch(var_d13b8f3d.var_53538eb0.origin, (randomint(10), randomint(10), 80));
            var_d13b8f3d.var_53538eb0 thread function_f7e6e4b1();
        }
        if (isdefined(var_d13b8f3d.playermodel)) {
            var_d13b8f3d.playermodel stopanimscripted();
            var_d13b8f3d.playermodel notsolid();
            var_d13b8f3d.playermodel startragdoll(1);
            var_d13b8f3d.playermodel notify(#"hash_cc763d5f");
            var_4671be4e = (0, 0, 130);
            var_d13b8f3d.playermodel launchragdoll(var_4671be4e);
        }
    }
    foreach (spot in level.doa.var_27f5178d) {
        if (isdefined(spot.spectator) && isdefined(spot.script_noteworthy)) {
            spot.spectator thread function_566de51a();
        }
    }
}

// Namespace namespace_917e49b3
// Params 0, eflags: 0x1 linked
// Checksum 0x6ec5cccd, Offset: 0x3158
// Size: 0x9c
function function_566de51a() {
    self endon(#"death");
    self thread namespace_eaa992c::function_285a2999("bomb");
    self stopanimscripted();
    self startragdoll(1);
    util::wait_network_frame();
    var_4671be4e = (0, 0, 130);
    self launchragdoll(var_4671be4e);
}

// Namespace namespace_917e49b3
// Params 1, eflags: 0x1 linked
// Checksum 0xee8b64f9, Offset: 0x3200
// Size: 0x24e
function function_2b20420b(var_d13b8f3d) {
    level endon(#"podiumalldone");
    var_d13b8f3d.playermodel = function_5ec4f559(var_d13b8f3d.player);
    spot = struct::get(var_d13b8f3d.target, "targetname");
    var_d13b8f3d.playermodel.origin = spot.origin;
    var_d13b8f3d.playermodel.angles = spot.angles;
    var_d13b8f3d.var_53538eb0 show();
    switch (var_d13b8f3d.position) {
    case 0:
        level.doa.var_e102b46 = var_d13b8f3d;
        level thread function_d040f4a6(var_d13b8f3d);
        wait(8);
        level thread fireworks();
        level notify(#"hash_86792d54");
        var_7ad30272 = level.doa.var_e102b46.origin + (0, 0, 600);
        level thread function_1aaa038(var_7ad30272);
        wait(4);
        level thread function_1aaa038(var_7ad30272);
        wait(6);
        level notify(#"hash_80a84385");
        break;
    case 1:
        level thread function_1b6034b2(var_d13b8f3d);
        break;
    case 2:
        level thread function_87082601(var_d13b8f3d);
        break;
    case 3:
        level thread function_b7bde10a(var_d13b8f3d);
        break;
    }
}

// Namespace namespace_917e49b3
// Params 1, eflags: 0x1 linked
// Checksum 0x9a2e7a9a, Offset: 0x3458
// Size: 0x26e
function function_1aaa038(droporigin) {
    var_9f9a4e58 = array("zombietron_ruby", "zombietron_diamond", "zombietron_sapphire");
    var_3e967ab = 30;
    while (var_3e967ab) {
        if (mayspawnentity()) {
            gem = spawn("script_model", droporigin);
            gem.script_noteworthy = "a_pickup_item";
            gem.angles = (0, randomint(360), 0);
            gem setmodel(var_9f9a4e58[randomint(var_9f9a4e58.size)]);
            target_point = gem.origin + (randomint(2), randomint(2), 12);
            vel = target_point - gem.origin;
            gem.origin += 4 * vel;
            vel *= randomfloatrange(0.5, 3);
            gem physicslaunch(gem.origin, vel);
            gem thread namespace_49107f3a::function_783519c1("podiumAllDone", 1);
            gem thread function_f7e6e4b1(3, 20);
            gem thread namespace_1a381543::function_90118d8c("zmb_gem_quieter");
            var_3e967ab--;
            util::wait_network_frame();
            continue;
        }
        return;
    }
}

// Namespace namespace_917e49b3
// Params 0, eflags: 0x1 linked
// Checksum 0x2088ab7e, Offset: 0x36d0
// Size: 0x76
function fireworks() {
    level endon(#"podiumalldone");
    level endon(#"hash_80a84385");
    while (true) {
        level clientfield::set("redinsExploder", 2);
        wait(4);
        level clientfield::set("redinsExploder", 0);
        wait(1);
    }
}

// Namespace namespace_917e49b3
// Params 1, eflags: 0x1 linked
// Checksum 0x37b8c29f, Offset: 0x3750
// Size: 0xe8
function function_5ec4f559(player) {
    model = spawn("script_model", player.origin);
    switch (player.entnum) {
    case 0:
        body = "c_zombietron_player1_podium";
        break;
    case 1:
        body = "c_zombietron_player2_podium";
        break;
    case 2:
        body = "c_zombietron_player3_podium";
        break;
    case 3:
        body = "c_zombietron_player4_podium";
        break;
    }
    model setmodel(body);
    return model;
}

// Namespace namespace_917e49b3
// Params 0, eflags: 0x1 linked
// Checksum 0x95bfa4dc, Offset: 0x3840
// Size: 0x1bc
function function_5e06cff2() {
    level endon(#"podiumalldone");
    self useanimtree(#generic);
    self setmodel(level.doa.var_260a85f3[randomint(level.doa.var_260a85f3.size)]);
    if (!isdefined(self.script_noteworthy)) {
        org = spawn("script_model", self.origin);
        org thread namespace_49107f3a::function_783519c1("podiumAllDone", 1);
        org setmodel("tag_origin");
        org enablelinkto();
        org notsolid();
        org.angles = self.angles;
        self linkto(org);
        self.org = org;
        self thread function_78713841();
    }
    self thread function_b8de7628();
    self thread function_7206982b();
    self thread function_fccfcf0c();
}

// Namespace namespace_917e49b3
// Params 0, eflags: 0x1 linked
// Checksum 0x7893005, Offset: 0x3af0
// Size: 0xf2
function function_78713841() {
    level endon(#"podiumalldone");
    self endon(#"death");
    while (true) {
        if (!isdefined(level.doa.var_63e2b87e)) {
            wait(randomfloatrange(0.1, 2));
            continue;
        }
        anim_ang = vectortoangles(level.doa.var_63e2b87e.origin - self.origin);
        self.org rotateto((0, anim_ang[1], 0), randomfloatrange(0.5, 2));
        self.org waittill(#"rotatedone");
    }
}

// Namespace namespace_917e49b3
// Params 0, eflags: 0x1 linked
// Checksum 0xe925c19e, Offset: 0x3bf0
// Size: 0x1a8
function function_b8de7628() {
    level endon(#"podiumalldone");
    self endon(#"death");
    var_2c143867 = array(generic%ai_zombie_base_idle_ad_v1, generic%ai_zombie_base_idle_au_v1, generic%bo3_ai_zombie_attack_v1, generic%bo3_ai_zombie_attack_v2, generic%bo3_ai_zombie_attack_v3, generic%bo3_ai_zombie_attack_v4, generic%bo3_ai_zombie_attack_v6);
    var_6ac65424 = array(generic%ai_zombie_doa_cheer_v1, generic%ai_zombie_doa_cheer_v2, generic%ai_zombie_doa_cheer_v3);
    self.animarray = var_2c143867;
    self.var_b2f6b3b7 = "zombie_outro_mood_angry";
    while (true) {
        note = level util::waittill_any_return("zombie_outro_mood_angry", "zombie_outro_mood_happy", "zombie_outro_mood_lol");
        self.var_b2f6b3b7 = note;
        if (note == "zombie_outro_mood_angry") {
            self.animarray = var_2c143867;
        } else {
            self.animarray = var_6ac65424;
        }
        self thread function_7206982b();
    }
}

// Namespace namespace_917e49b3
// Params 0, eflags: 0x1 linked
// Checksum 0x4f1b6a74, Offset: 0x3da0
// Size: 0x140
function function_fccfcf0c() {
    level endon(#"podiumalldone");
    self endon(#"death");
    wait(randomfloatrange(0, 2));
    location = self.origin + (0, 0, 90);
    while (true) {
        if (randomint(getdvarint("scr_doa_zombie_talk_chance", 50)) == 0) {
            switch (self.var_b2f6b3b7) {
            case 68:
                function_46882430(%DOA_GARRRR, location, 2);
                break;
            case 70:
                function_46882430(%DOA_GAR, location, 2);
                break;
            case 69:
                function_46882430(%DOA_GARHARHAR, location, 2);
                break;
            }
        }
        wait(1);
    }
}

// Namespace namespace_917e49b3
// Params 0, eflags: 0x1 linked
// Checksum 0xdc186fcf, Offset: 0x3fe0
// Size: 0xa6
function function_4036d4c6() {
    level endon(#"podiumalldone");
    self notify(#"hash_4036d4c6");
    self endon(#"hash_4036d4c6");
    self endon(#"death");
    while (true) {
        self waittill(#"damage");
        playrumbleonposition("explosion_generic", self.origin);
        physicsexplosionsphere(self.origin, 512, 512, 5);
        level notify(#"hash_71c0bde9");
    }
}

// Namespace namespace_917e49b3
// Params 4, eflags: 0x1 linked
// Checksum 0x931bcc37, Offset: 0x4178
// Size: 0xd4
function function_46882430(string, location, hold, fade) {
    if (!isdefined(hold)) {
        hold = 3;
    }
    if (!isdefined(fade)) {
        fade = 1;
    }
    id = namespace_49107f3a::function_c9fb43e9(string, location);
    level util::waittill_any_timeout(hold, "podiumAllDone", "killBubble");
    namespace_49107f3a::function_11f3f381(id, fade);
    level util::waittill_any_timeout(fade, "podiumAllDone");
}

// Namespace namespace_917e49b3
// Params 1, eflags: 0x1 linked
// Checksum 0x7eaecf4, Offset: 0x4258
// Size: 0x334
function function_d040f4a6(var_d13b8f3d) {
    level endon(#"podiumalldone");
    level waittill(#"hash_314666df");
    playermodel = var_d13b8f3d.playermodel;
    playermodel.team = "axis";
    playermodel useanimtree(#generic);
    playermodel solid();
    playermodel.takedamage = 1;
    level.doa.var_c12009c9 = var_d13b8f3d.var_53538eb0;
    offset = playermodel.origin + (0, 0, 90);
    playermodel thread function_e4d4b80(generic%ch_ram_05_02_block_nrc_vign_cheering_d_loop);
    wait(3);
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_1stplace_1");
    function_46882430(%DOA_FIRST_PLACE, offset);
    function_46882430(%DOA_OH_YEAH, offset, 2);
    function_46882430(%DOA_RICH, offset, 4);
    wait(1);
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_1stplace_2");
    function_46882430(%DOA_WOOO, offset);
    function_46882430(%DOA_WELL_HELLO, offset, 2);
    wait(1);
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_1stplace_3");
    function_46882430(%DOA_WANT_SOME, offset);
    function_46882430(%DOA_WOOO, offset, 2);
    function_46882430(%DOA_CANT_TOUCH, offset);
    level waittill(#"hash_ff1ecf6");
    wait(1);
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_1stplace_4");
    function_46882430(%DOA_WHATWASTHAT, offset);
    level waittill(#"hash_5e4b910f");
    if (level.doa.var_44d58db8.size == 4) {
        wait(1);
        function_46882430(%DOA_II, offset, 3.5);
        return;
    }
    wait(1);
    function_46882430(%DOA_NOOOO, offset, 2);
}

// Namespace namespace_917e49b3
// Params 1, eflags: 0x1 linked
// Checksum 0x41831433, Offset: 0x4598
// Size: 0x23c
function function_1b6034b2(var_d13b8f3d) {
    level endon(#"podiumalldone");
    level waittill(#"hash_314666df");
    playermodel = var_d13b8f3d.playermodel;
    playermodel thread function_e4d4b80(generic%ai_civ_base_cover_stn_pointidle);
    offset = playermodel.origin + (0, 0, 90);
    wait(4);
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_2ndplace_1");
    function_46882430(%DOA_SECOND_PLACE, offset);
    wait(1);
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_2ndplace_2");
    function_46882430(%DOA_FUN, offset);
    wait(1);
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_2ndplace_3");
    function_46882430(%DOA_AGAIN, offset);
    level waittill(#"hash_a284788a");
    wait(randomfloatrange(0, 2));
    function_46882430(%DOA_UMM, offset);
    level waittill(#"hash_e4be85d1");
    function_46882430(%DOA_NOTGOOD, offset);
    if (level.doa.var_44d58db8.size == 4) {
        level waittill(#"hash_5e4b910f");
        wait(1.5);
        function_46882430(%DOA_T, offset);
        return;
    }
    wait(1);
    function_46882430(%DOA_RUN, offset, 2);
}

// Namespace namespace_917e49b3
// Params 1, eflags: 0x1 linked
// Checksum 0x8900dda7, Offset: 0x47e0
// Size: 0x23c
function function_87082601(var_d13b8f3d) {
    level endon(#"podiumalldone");
    level waittill(#"hash_314666df");
    playermodel = var_d13b8f3d.playermodel;
    offset = playermodel.origin + (0, 0, 90);
    playermodel thread function_e4d4b80(generic%ai_civ_base_standidle_officer);
    wait(5);
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_3rdplace_1");
    function_46882430(%DOA_THIRD_PLACE, offset);
    wait(3);
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_3rdplace_2");
    function_46882430(%DOA_NEXTTIME, offset);
    wait(6);
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_3rdplace_3");
    function_46882430(%DOA_WHOISTHATGUY, offset);
    level waittill(#"hash_a284788a");
    wait(randomfloatrange(0, 2));
    function_46882430(%DOA_UMM, offset);
    level waittill(#"hash_e4be85d1");
    wait(1);
    function_46882430(%DOA_YOUTHINK, offset);
    if (level.doa.var_44d58db8.size == 4) {
        level waittill(#"hash_5e4b910f");
        wait(0.5);
        function_46882430(%DOA_SH, offset, 4);
        return;
    }
    wait(1);
    function_46882430(%DOA_BOOGIE, offset, 2);
}

// Namespace namespace_917e49b3
// Params 1, eflags: 0x1 linked
// Checksum 0xc0079db0, Offset: 0x4a28
// Size: 0x22c
function function_b7bde10a(var_d13b8f3d) {
    level endon(#"podiumalldone");
    level waittill(#"hash_314666df");
    playermodel = var_d13b8f3d.playermodel;
    right = anglestoright(playermodel.angles);
    offset = playermodel.origin + (0, 0, 80) + 30 * right;
    playermodel thread function_e4d4b80(generic%ch_new_06_01_chase_vign_sitting_civs_right_civ01_loop);
    wait(6);
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_4thplace_1");
    function_46882430(%DOA_LAST_PLACE, offset);
    wait(3);
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_4thplace_2");
    function_46882430(%DOA_CANTBETRUE, offset);
    function_46882430(%DOA_CHICKENS, offset);
    level waittill(#"hash_a284788a");
    wait(randomfloatrange(0, 2));
    function_46882430(%DOA_UMM, offset);
    level waittill(#"hash_e4be85d1");
    wait(2);
    function_46882430(%DOA_SITTING, offset);
    if (level.doa.var_44d58db8.size == 4) {
        level waittill(#"hash_5e4b910f");
        function_46882430(%DOA_OH, offset, 4.5);
    }
}

// Namespace namespace_917e49b3
// Params 0, eflags: 0x1 linked
// Checksum 0xb1bcd44e, Offset: 0x4c60
// Size: 0x1ac
function function_4d8b6e1e() {
    var_5198fae9 = getplayers();
    players = [];
    foreach (player in var_5198fae9) {
        if (isdefined(player.doa)) {
            players[players.size] = player;
        }
    }
    for (i = 1; i < players.size; i++) {
        for (j = i; j > 0 && int(players[j - 1] namespace_64c6b720::getplayerscore()) < int(players[j] namespace_64c6b720::getplayerscore()); j--) {
            array::swap(players, j, j - 1);
        }
    }
    return players;
}

