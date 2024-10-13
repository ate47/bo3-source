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

#using_animtree("generic");

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
    if (!isdefined(level.doa.podium_damage_trigger)) {
        level.doa.podium_damage_trigger = getent("podium_damage_trigger", "targetname");
    }
    level.doa.podium_damage_trigger triggerenable(0);
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
    foreach (podium in level.doa.var_92721db3) {
        if (isdefined(podium.var_53538eb0)) {
            podium.var_53538eb0 delete();
        }
        if (isdefined(podium.playermodel)) {
            podium.playermodel delete();
        }
        podium.player = undefined;
        podium hide();
        podium notsolid();
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
    assert(isdefined(level.doa.var_92721db3));
    foreach (podium in level.doa.var_92721db3) {
        podium.var_53538eb0 = spawn("script_model", podium.origin);
        podium.var_53538eb0 thread namespace_49107f3a::function_783519c1("podiumAllDone", 1);
        podium.var_53538eb0 setmodel(podium.model);
        podium.var_53538eb0.angles = podium.angles;
        num--;
        if (num == 0) {
            break;
        }
    }
    level.doa.podium_damage_trigger triggerenable(1);
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
            level notify(#"silverbackAllDone");
        }
        wait 0.05;
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
    foreach (podium in level.doa.var_92721db3) {
        if (isdefined(podium.player)) {
            level thread function_2b20420b(podium);
        }
    }
    level thread function_a85eaca4();
    level thread function_5e04bf78();
    level notify(#"hash_b96c96ac");
    level notify(#"hash_97276c43");
    wait 1;
    var_1a87bae6 = level.lighting_state;
    level thread namespace_49107f3a::set_lighting_state(1);
    level thread namespace_49107f3a::function_390adefe(0);
    level notify(#"hash_314666df");
    level thread function_d834fdd0();
    msg = level util::waittill_any_timeout(30, "silverbackAllDone");
    if (msg == "timeout") {
        level notify(#"hash_a099b4d6");
        level waittill(#"silverbackAllDone");
    }
    level.var_3997f9e8 delete();
    namespace_49107f3a::function_44eb090b();
    level notify(#"podiumalldone");
    function_d4766377();
    level thread namespace_49107f3a::function_13fbad22();
    level thread namespace_49107f3a::set_lighting_state(var_1a87bae6);
}

// Namespace namespace_917e49b3
// Params 0, eflags: 0x1 linked
// Checksum 0x525a5501, Offset: 0x1a90
// Size: 0x12de
function function_5e04bf78() {
    level endon(#"silverbackAllDone");
    level waittill(#"hash_a099b4d6");
    point1 = level.doa.var_b7f5f6c8[0];
    point2 = level.doa.var_b7f5f6c8[1];
    var_5302f134 = level.doa.var_b7f5f6c8[2];
    org = spawn("script_model", point1.origin);
    org thread namespace_49107f3a::function_783519c1("podiumAllDone", 1);
    org setmodel("tag_origin");
    org2 = spawn("script_origin", org.origin + (0, 0, 2500));
    org2 thread namespace_49107f3a::function_783519c1("podiumAllDone", 1);
    org2.angles = point1.angles;
    playsoundatposition("zmb_ape_prespawn", org.origin);
    org thread namespace_eaa992c::function_285a2999("silverback_intro");
    wait 0.5;
    org thread namespace_eaa992c::function_285a2999("silverback_intro");
    org thread namespace_eaa992c::function_285a2999("stoneboss_shield_explode");
    wait 0.5;
    org thread namespace_eaa992c::function_285a2999("silverback_intro");
    org thread namespace_eaa992c::function_285a2999("stoneboss_shield_explode");
    wait 0.5;
    silverback = namespace_51bd792::function_36aa8b6c(org2);
    silverback thread namespace_49107f3a::function_783519c1("podiumAllDone", 1);
    silverback linkto(org2);
    silverback thread namespace_eaa992c::function_285a2999("player_trail_red");
    silverback thread namespace_eaa992c::function_285a2999("silverback_intro_trail1");
    silverback thread namespace_eaa992c::function_285a2999("silverback_intro_trail2");
    silverback forceteleport(org2.origin, org2.angles);
    org2 moveto(org.origin, 1);
    org2 util::waittill_any_timeout(1.5, "movedone");
    silverback.takedamage = 0;
    silverback thread namespace_eaa992c::function_285a2999("silverback_intro_explo");
    silverback thread namespace_eaa992c::turnofffx("silverback_intro_trail1");
    silverback thread namespace_eaa992c::turnofffx("silverback_intro_trail2");
    playrumbleonposition("explosion_generic", org.origin);
    playsoundatposition("zmb_ape_spawn", org.origin);
    silverback unlink();
    org2 delete();
    silverback playsound("zmb_simianaut_roar");
    silverback animscripted("pissedoff", silverback.origin, silverback.angles, "ai_zombie_doa_simianaut_ground_pound");
    silverback waittillmatch(#"pissedoff", "zombie_melee");
    playfx(level._effect["ground_pound"], silverback.origin);
    silverback waittillmatch(#"pissedoff", "end");
    silverback playsound("zmb_simianaut_roar");
    silverback playsound("evt_turret_takeoff");
    silverback thread namespace_eaa992c::function_285a2999("boss_takeoff");
    silverback thread namespace_eaa992c::function_285a2999("crater_dust");
    playrumbleonposition("explosion_generic", silverback.origin);
    height = 800;
    timems = height / 1000 * 3000;
    org.angles = silverback.angles;
    org.origin = silverback.origin;
    silverback linkto(org);
    org namespace_a3646565::function_8bc2f7b(point2.origin, timems, height);
    silverback thread namespace_eaa992c::function_285a2999("turret_impact");
    silverback playsound("zmb_simianaut_roar");
    level.doa.var_63e2b87e = silverback;
    level notify(#"zombie_outro_mood_happy");
    level notify(#"hash_a284788a");
    wait 2;
    level thread function_46882430(%DOA_ME_BACK, silverback.origin + (0, 0, 95), 2);
    wait 3;
    silverback playsound("zmb_simianaut_roar");
    wait 2;
    level thread function_46882430(%DOA_MY_TREASURE, silverback.origin + (0, 0, 95), 2);
    wait 1.8;
    level notify(#"zombie_outro_mood_angry");
    level.doa.var_63e2b87e = level.doa.var_e102b46;
    silverback playsound("evt_turret_takeoff");
    silverback thread namespace_eaa992c::function_285a2999("boss_takeoff");
    silverback thread namespace_eaa992c::function_285a2999("crater_dust");
    playrumbleonposition("explosion_generic", silverback.origin);
    org.angles = silverback.angles;
    org.origin = silverback.origin;
    level notify(#"hash_ff1ecf6");
    org moveto(org.origin + (0, 0, 2000), 1.3);
    org util::waittill_any_timeout(1.5, "movedone");
    org.origin = var_5302f134.origin + (0, 0, 2000);
    org.angles = var_5302f134.angles;
    silverback delete();
    var_ca099d36 = level.doa.var_4f253f44 spawnfromspawner("silverback_mech", 1, 1, 1);
    var_ca099d36 thread namespace_49107f3a::function_783519c1("podiumAllDone", 1);
    var_ca099d36 ghost();
    wait 0.05;
    var_ca099d36.origin = org.origin;
    var_ca099d36.angles = org.angles;
    var_ca099d36.nojumping = 1;
    var_ca099d36 vehicle_ai::start_scripted();
    var_ca099d36.team = "axis";
    var_ca099d36 enablelinkto();
    var_ca099d36.driver = spawn("script_model", var_ca099d36 gettagorigin("tag_driver"));
    var_ca099d36.driver ghost();
    var_ca099d36.driver thread namespace_49107f3a::function_783519c1("podiumAllDone", 1);
    var_ca099d36.driver.angles = org.angles;
    var_ca099d36.driver setmodel("c_rus_simianaut_body");
    var_ca099d36.driver linkto(var_ca099d36, "tag_driver");
    var_ca099d36.driver thread function_fb3b78fe();
    var_ca099d36 linkto(org);
    org thread namespace_eaa992c::function_285a2999("fire_trail");
    wait 0.05;
    var_ca099d36 show();
    var_ca099d36.driver show();
    org moveto(var_5302f134.origin, 2);
    var_ca099d36 playsound("evt_doa_monkeymech_land");
    org util::waittill_any_timeout(3, "movedone");
    org thread namespace_eaa992c::function_285a2999("def_explode");
    var_ca099d36 setturrettargetent(level.doa.var_c12009c9);
    var_ca099d36 function_9af49228(level.doa.var_c12009c9, (0, 0, 0), 1);
    var_ca099d36 unlink();
    level notify(#"hash_e4be85d1");
    wait 10;
    level thread function_46882430(%DOA_TRY_THIS, var_ca099d36.driver.origin + (0, 0, 145), 2);
    level notify(#"hash_5e4b910f");
    level.doa.podium_damage_trigger thread function_4036d4c6();
    msg = self util::waittill_any_timeout(1, "turret_on_target");
    rounds = 40;
    var_9d388e1d = undefined;
    while (rounds) {
        var_ca099d36 fireweapon(2, level.doa.var_c12009c9, (0, 0, -15));
        wait 0.15;
        rounds--;
        if (rounds == 28) {
            level notify(#"zombie_outro_mood_lol");
            level thread function_46882430(%DOA_HAHAHA, var_ca099d36.driver.origin + (0, 0, 145), 2);
        }
        if (rounds % 10 == 0) {
            if (isdefined(var_9d388e1d)) {
                var_9d388e1d delete();
            }
            target = level.doa.var_92721db3[randomint(level.doa.var_92721db3.size)];
            var_9d388e1d = spawn("script_model", target.origin + (0, 0, 32));
            var_9d388e1d thread namespace_49107f3a::function_783519c1("podiumAllDone", 1);
            var_9d388e1d setmodel("tag_origin");
            var_9d388e1d makesentient();
            level.doa.var_c12009c9 = var_9d388e1d;
            var_ca099d36 setturrettargetent(level.doa.var_c12009c9);
            var_ca099d36 function_9af49228(level.doa.var_c12009c9);
            msg = self util::waittill_any_timeout(1, "turret_on_target");
        }
    }
    if (isdefined(var_9d388e1d)) {
        var_9d388e1d delete();
    }
    var_ca099d36 function_bb5f9faa(1);
    var_ca099d36.driver.taunt = 1;
    var_ca099d36.driver stopanimscripted();
    wait 1;
    level thread function_46882430(%DOA_HAHAHA, var_ca099d36.driver.origin + (0, 0, 145), 2);
    wait 2;
    level thread function_46882430(%DOA_ME_WINNER, var_ca099d36.driver.origin + (0, 0, 145), 2);
    var_ca099d36.driver.taunt = undefined;
    wait 3;
    level thread function_46882430(%DOA_BYE, var_ca099d36.driver.origin + (0, 0, 145), 2);
    wait 2;
    var_ca099d36 linkto(org);
    var_ca099d36 playsound("evt_doa_monkeymech_takeoff");
    org thread namespace_eaa992c::function_285a2999("def_explode");
    org moveto(var_5302f134.origin + (0, 0, 2500), 2);
    org util::waittill_any_timeout(2.3, "movedone");
    if (isdefined(var_ca099d36)) {
        if (isdefined(var_ca099d36.driver)) {
            var_ca099d36.driver delete();
        }
        var_ca099d36 delete();
    }
    if (isdefined(org)) {
        org delete();
    }
    wait 4;
    level notify(#"silverbackAllDone");
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
    foreach (podium in level.doa.var_92721db3) {
        if (isdefined(podium.var_53538eb0)) {
            podium.var_53538eb0 physicslaunch(podium.var_53538eb0.origin, (randomint(10), randomint(10), 80));
            podium.var_53538eb0 thread function_f7e6e4b1();
        }
        if (isdefined(podium.playermodel)) {
            podium.playermodel stopanimscripted();
            podium.playermodel notsolid();
            podium.playermodel startragdoll(1);
            podium.playermodel notify(#"killBubble");
            var_4671be4e = (0, 0, 130);
            podium.playermodel launchragdoll(var_4671be4e);
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
function function_2b20420b(podium) {
    level endon(#"podiumalldone");
    podium.playermodel = function_5ec4f559(podium.player);
    spot = struct::get(podium.target, "targetname");
    podium.playermodel.origin = spot.origin;
    podium.playermodel.angles = spot.angles;
    podium.var_53538eb0 show();
    switch (podium.position) {
    case 0:
        level.doa.var_e102b46 = podium;
        level thread function_d040f4a6(podium);
        wait 8;
        level thread fireworks();
        level notify(#"hash_86792d54");
        var_7ad30272 = level.doa.var_e102b46.origin + (0, 0, 600);
        level thread function_1aaa038(var_7ad30272);
        wait 4;
        level thread function_1aaa038(var_7ad30272);
        wait 6;
        level notify(#"hash_80a84385");
        break;
    case 1:
        level thread function_1b6034b2(podium);
        break;
    case 2:
        level thread function_87082601(podium);
        break;
    case 3:
        level thread function_b7bde10a(podium);
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
        wait 4;
        level clientfield::set("redinsExploder", 0);
        wait 1;
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
// Checksum 0xff511c7a, Offset: 0x3a08
// Size: 0xde
function function_7206982b() {
    level endon(#"podiumalldone");
    self endon(#"death");
    self notify(#"hash_7206982b");
    self endon(#"hash_7206982b");
    while (true) {
        idleanim = self.animarray[randomint(self.animarray.size)];
        self animscripted("zombieanim", self.origin, self.angles, idleanim, "normal", generic%body, 1, 0.3, 0.3);
        self waittillmatch(#"zombieanim", "end");
    }
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
            wait randomfloatrange(0.1, 2);
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
    wait randomfloatrange(0, 2);
    location = self.origin + (0, 0, 90);
    while (true) {
        if (randomint(getdvarint("scr_doa_zombie_talk_chance", 50)) == 0) {
            switch (self.var_b2f6b3b7) {
            case "zombie_outro_mood_angry":
                function_46882430(%DOA_GARRRR, location, 2);
                break;
            case "zombie_outro_mood_happy":
                function_46882430(%DOA_GAR, location, 2);
                break;
            case "zombie_outro_mood_lol":
                function_46882430(%DOA_GARHARHAR, location, 2);
                break;
            }
        }
        wait 1;
    }
}

// Namespace namespace_917e49b3
// Params 0, eflags: 0x1 linked
// Checksum 0x6dd936f7, Offset: 0x3ee8
// Size: 0xee
function function_fb3b78fe() {
    level endon(#"podiumalldone");
    self endon(#"death");
    self useanimtree(#generic);
    while (true) {
        if (isdefined(self.taunt) && self.taunt) {
            self animscripted("mech_taunt", self.origin, self.angles, "ai_zombie_doa_simianaut_mech_idle_taunt");
            self waittillmatch(#"mech_taunt", "end");
            continue;
        }
        self animscripted("mech_idle", self.origin, self.angles, "ai_zombie_doa_simianaut_mech_idle");
        self waittillmatch(#"mech_idle", "end");
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
// Params 1, eflags: 0x1 linked
// Checksum 0x41a3bbd2, Offset: 0x4090
// Size: 0xde
function function_e4d4b80(animation) {
    level endon(#"podiumalldone");
    self notify(#"hash_e4d4b80");
    self endon(#"hash_e4d4b80");
    self useanimtree(#generic);
    while (true) {
        self animscripted("podium", self.origin, self.angles, animation, "normal", generic%body, 1, 0.5, 0.5);
        self waittillmatch(#"podium", "end");
        self notify(#"animation_loop", animation);
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
function function_d040f4a6(podium) {
    level endon(#"podiumalldone");
    level waittill(#"hash_314666df");
    playermodel = podium.playermodel;
    playermodel.team = "axis";
    playermodel useanimtree(#generic);
    playermodel solid();
    playermodel.takedamage = 1;
    level.doa.var_c12009c9 = podium.var_53538eb0;
    offset = playermodel.origin + (0, 0, 90);
    playermodel thread function_e4d4b80(generic%ch_ram_05_02_block_nrc_vign_cheering_d_loop);
    wait 3;
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_1stplace_1");
    function_46882430(%DOA_FIRST_PLACE, offset);
    function_46882430(%DOA_OH_YEAH, offset, 2);
    function_46882430(%DOA_RICH, offset, 4);
    wait 1;
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_1stplace_2");
    function_46882430(%DOA_WOOO, offset);
    function_46882430(%DOA_WELL_HELLO, offset, 2);
    wait 1;
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_1stplace_3");
    function_46882430(%DOA_WANT_SOME, offset);
    function_46882430(%DOA_WOOO, offset, 2);
    function_46882430(%DOA_CANT_TOUCH, offset);
    level waittill(#"hash_ff1ecf6");
    wait 1;
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_1stplace_4");
    function_46882430(%DOA_WHATWASTHAT, offset);
    level waittill(#"hash_5e4b910f");
    if (level.doa.var_44d58db8.size == 4) {
        wait 1;
        function_46882430(%DOA_II, offset, 3.5);
        return;
    }
    wait 1;
    function_46882430(%DOA_NOOOO, offset, 2);
}

// Namespace namespace_917e49b3
// Params 1, eflags: 0x1 linked
// Checksum 0x41831433, Offset: 0x4598
// Size: 0x23c
function function_1b6034b2(podium) {
    level endon(#"podiumalldone");
    level waittill(#"hash_314666df");
    playermodel = podium.playermodel;
    playermodel thread function_e4d4b80(generic%ai_civ_base_cover_stn_pointidle);
    offset = playermodel.origin + (0, 0, 90);
    wait 4;
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_2ndplace_1");
    function_46882430(%DOA_SECOND_PLACE, offset);
    wait 1;
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_2ndplace_2");
    function_46882430(%DOA_FUN, offset);
    wait 1;
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_2ndplace_3");
    function_46882430(%DOA_AGAIN, offset);
    level waittill(#"hash_a284788a");
    wait randomfloatrange(0, 2);
    function_46882430(%DOA_UMM, offset);
    level waittill(#"hash_e4be85d1");
    function_46882430(%DOA_NOTGOOD, offset);
    if (level.doa.var_44d58db8.size == 4) {
        level waittill(#"hash_5e4b910f");
        wait 1.5;
        function_46882430(%DOA_T, offset);
        return;
    }
    wait 1;
    function_46882430(%DOA_RUN, offset, 2);
}

// Namespace namespace_917e49b3
// Params 1, eflags: 0x1 linked
// Checksum 0x8900dda7, Offset: 0x47e0
// Size: 0x23c
function function_87082601(podium) {
    level endon(#"podiumalldone");
    level waittill(#"hash_314666df");
    playermodel = podium.playermodel;
    offset = playermodel.origin + (0, 0, 90);
    playermodel thread function_e4d4b80(generic%ai_civ_base_standidle_officer);
    wait 5;
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_3rdplace_1");
    function_46882430(%DOA_THIRD_PLACE, offset);
    wait 3;
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_3rdplace_2");
    function_46882430(%DOA_NEXTTIME, offset);
    wait 6;
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_3rdplace_3");
    function_46882430(%DOA_WHOISTHATGUY, offset);
    level waittill(#"hash_a284788a");
    wait randomfloatrange(0, 2);
    function_46882430(%DOA_UMM, offset);
    level waittill(#"hash_e4be85d1");
    wait 1;
    function_46882430(%DOA_YOUTHINK, offset);
    if (level.doa.var_44d58db8.size == 4) {
        level waittill(#"hash_5e4b910f");
        wait 0.5;
        function_46882430(%DOA_SH, offset, 4);
        return;
    }
    wait 1;
    function_46882430(%DOA_BOOGIE, offset, 2);
}

// Namespace namespace_917e49b3
// Params 1, eflags: 0x1 linked
// Checksum 0xc0079db0, Offset: 0x4a28
// Size: 0x22c
function function_b7bde10a(podium) {
    level endon(#"podiumalldone");
    level waittill(#"hash_314666df");
    playermodel = podium.playermodel;
    right = anglestoright(playermodel.angles);
    offset = playermodel.origin + (0, 0, 80) + 30 * right;
    playermodel thread function_e4d4b80(generic%ch_new_06_01_chase_vign_sitting_civs_right_civ01_loop);
    wait 6;
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_4thplace_1");
    function_46882430(%DOA_LAST_PLACE, offset);
    wait 3;
    playermodel thread namespace_1a381543::function_90118d8c("zmb_end_4thplace_2");
    function_46882430(%DOA_CANTBETRUE, offset);
    function_46882430(%DOA_CHICKENS, offset);
    level waittill(#"hash_a284788a");
    wait randomfloatrange(0, 2);
    function_46882430(%DOA_UMM, offset);
    level waittill(#"hash_e4be85d1");
    wait 2;
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

