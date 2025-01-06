#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/cp_doa_bo3_enemy;
#using scripts/cp/cp_doa_bo3_fx;
#using scripts/cp/cp_doa_bo3_sound;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_chicken_pickup;
#using scripts/cp/doa/_doa_core;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_enemy_boss;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_hazard;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/util_shared;

#using_animtree("generic");

#namespace namespace_a3646565;

// Namespace namespace_a3646565
// Params 0, eflags: 0x0
// Checksum 0x1305f670, Offset: 0xcf8
// Size: 0x172
function init() {
    if (!isdefined(level.doa.var_55dddb3a)) {
        level.doa.var_55dddb3a = getent("doa_silverback_spawner", "targetname");
    }
    level.doa.var_5f57a68d = getent("doa_spawner_parasite", "targetname");
    level.doa.var_b5aef19c = getent("doa_spawner_purple_parasite", "targetname");
    level.doa.var_4f253f44 = getent("boss_mech", "targetname");
    level.doa.var_4f253f44.count = 999999;
    level.doa.var_155f5b81 = [];
    level.doa.var_22c9944 = [];
    level.doa.var_7b9808fc = 0;
    level.doa.var_635342b0 = getent("fido_egg", "targetname");
    level.doa.var_635342b0 show();
}

// Namespace namespace_a3646565
// Params 0, eflags: 0x0
// Checksum 0xd37d6ea5, Offset: 0xe78
// Size: 0x14a
function function_d8e6314c() {
    foreach (var_2e488485 in level.doa.var_155f5b81) {
        if (isdefined(var_2e488485)) {
            var_2e488485 delete();
        }
    }
    if (isdefined(level.doa.var_6fb37836)) {
        level.doa.var_6fb37836 delete();
    }
    if (isdefined(level.doa.var_2775f29c)) {
        level.doa.var_2775f29c delete();
    }
    if (isdefined(level.doa.var_17593d0e)) {
        level.doa.var_17593d0e delete();
    }
    level thread namespace_a7e6beb5::function_c1869ec8();
    level thread namespace_49107f3a::clearallcorpses();
    level thread namespace_d88e3a06::function_116bb43();
    level flag::clear("doa_game_silverback_round");
}

// Namespace namespace_a3646565
// Params 0, eflags: 0x0
// Checksum 0x4f4b2077, Offset: 0xfd0
// Size: 0x22
function function_f35c54a() {
    level endon(#"bossEventComplete");
    level waittill(#"doa_game_is_over");
    function_d8e6314c();
}

// Namespace namespace_a3646565
// Params 0, eflags: 0x0
// Checksum 0x566f7cd5, Offset: 0x1000
// Size: 0x22
function function_8b1dfb44() {
    self namespace_cdb9a8fe::function_fe0946ac();
    self.doa.var_3d8ad456 = 1;
}

// Namespace namespace_a3646565
// Params 0, eflags: 0x0
// Checksum 0x2afe1aa0, Offset: 0x1030
// Size: 0xab2
function function_fc48f9f3() {
    level endon(#"doa_game_is_over");
    init();
    level flag::set("doa_round_paused");
    flag::set("doa_round_active");
    /#
        if (level.doa.round_number < 64) {
            level.doa.round_number = 64;
            level.doa.zombie_move_speed += level.doa.round_number * level.doa.var_c9e1c854;
            level.doa.zombie_health += level.doa.round_number * level.doa.var_792b9741;
            namespace_d88e3a06::function_7a8a936b();
            namespace_cdb9a8fe::function_691ef36b();
            namespace_cdb9a8fe::function_703bb8b2(level.doa.round_number);
        }
    #/
    level thread namespace_cdb9a8fe::function_87703158(1);
    var_e5c8b9e7 = level.doa.var_bc9b7c71;
    level.doa.var_bc9b7c71 = &function_8b1dfb44;
    foreach (player in namespace_831a4a7c::function_5eb6e4d1()) {
        player notify(#"hash_d28ba89d");
    }
    level thread namespace_49107f3a::function_c5f3ece8(%DOA_BOSS, undefined, 6, (1, 0, 0));
    level.voice playsound("vox_doaa_boss_fight");
    level notify(#"hash_ba37290e", "bossbattle");
    wait 1;
    level thread namespace_49107f3a::function_37fb5c23(%CP_DOA_BO3_SILVERBACK_LAIR, undefined, 5, (1, 0, 0));
    if (getdvarint("scr_boss_silverback_mech_enabled", 0)) {
        level clientfield::set("cameraHeight", 2);
        arenacenter = namespace_3ca3c537::function_61d60e0b();
        loc = spawnstruct();
        loc.angles = (0, 0, 0);
        loc.origin = arenacenter + (0, 0, 3000);
        mech = level.doa.var_4f253f44 spawner::spawn(1);
        mech.origin = loc.origin;
        mech.boss = 1;
        mech enablelinkto();
        mech.driver = spawn("script_model", mech gettagorigin("tag_driver"));
        mech.driver.targetname = "mechDrive";
        mech.driver setmodel("c_rus_simianaut_body");
        mech.driver linkto(mech, "tag_driver");
        mech.health = getdvarint("scr_boss_silverback_mech_health", 200000);
        mech.maxhealth = getdvarint("scr_boss_silverback_mech_health", 200000);
        mech clientfield::set("camera_focus_item", 1);
        org = spawn("script_model", loc.origin);
        org.targetname = "mechOrg";
        org setmodel("tag_origin");
        mech linkto(org);
        org thread namespace_eaa992c::function_285a2999("def_explode");
        org thread namespace_eaa992c::function_285a2999("fire_trail");
        org moveto(arenacenter, 2);
        org util::waittill_any_timeout(3, "movedone");
        mech unlink();
        org delete();
        level clientfield::set("cameraHeight", 0);
    }
    foreach (player in namespace_831a4a7c::function_5eb6e4d1()) {
        player freezecontrols(0);
    }
    if (getdvarint("scr_boss_silverback_mech_enabled", 0)) {
        level clientfield::set("activateBanner", 6);
        level thread function_28eb6914(mech);
        level thread function_a733cd6a(mech);
        level waittill(#"hash_885b3b5e");
    }
    var_3d99e7a6 = math::clamp(1 + level.doa.var_da96f13c, 1, 10);
    while (var_3d99e7a6) {
        var_3d99e7a6--;
        level thread _silverbackGroundSpawn(var_3d99e7a6);
    }
    level waittill(#"hash_d29de2a8");
    level flag::set("doa_game_silverback_round");
    level.var_172ed9a1 = [];
    level flag::clear("doa_round_paused");
    level thread function_b4195d47();
    level function_72e0a286();
    level notify(#"all_silverbacks_dead");
    level clientfield::set("activateBanner", 0);
    level flag::clear("doa_round_active");
    namespace_49107f3a::function_1ced251e();
    level thread namespace_49107f3a::function_c5f3ece8(%CP_DOA_BO3_SILVERBACK_DEFEATED, undefined, 6, (1, 0, 0));
    wait 4;
    level thread namespace_49107f3a::function_37fb5c23(%CP_DOA_BO3_SILVERBACK_DEFEATED2, undefined, 5, (1, 0, 0));
    wait 6.5;
    namespace_49107f3a::function_44eb090b();
    level.doa.var_635342b0 hide();
    array::thread_all(getplayers(), &namespace_831a4a7c::function_82e3b1cb);
    level thread namespace_a7e6beb5::function_c1869ec8();
    level thread namespace_49107f3a::clearallcorpses();
    if (isdefined(level.doa.var_6fb37836)) {
        level.doa.var_6fb37836 delete();
    }
    egg = spawn("script_model", namespace_3ca3c537::function_61d60e0b() + (0, 0, 48));
    egg.targetname = "fido";
    egg setmodel("zombietron_eggxl");
    level thread namespace_a7e6beb5::function_22d0e830(0, 10, 0.1);
    level thread namespace_a7e6beb5::function_22d0e830(1, 8, randomfloatrange(2, 4));
    var_249f9545 = struct::get_array("boss_player_end_spot");
    i = 0;
    foreach (player in getplayers()) {
        player namespace_cdb9a8fe::function_fe0946ac(var_249f9545[i].origin);
        player thread namespace_831a4a7c::turnOnFlashlight(0);
        i++;
    }
    level namespace_49107f3a::set_lighting_state(2);
    level clientfield::increment("killweather");
    namespace_49107f3a::function_390adefe();
    function_a753035a(egg);
    level thread namespace_49107f3a::function_c5f3ece8(%CP_DOA_BO3_FIDO_SAVED, undefined, 6, (1, 1, 0));
    wait 4;
    level thread namespace_49107f3a::function_37fb5c23(%CP_DOA_BO3_FIDO_SAVED2, undefined, 5, (1, 1, 0));
    wait 6.5;
    namespace_3ca3c537::function_4586479a(0);
    function_d8e6314c();
    level thread function_14ba3248();
    lui::play_movie("cp_doa_bo3_endgame", "fullscreen", 1);
    level notify(#"hash_629939b8");
    level flag::set("doa_game_is_completed");
    level.doa.var_635342b0 show();
    level.doa.var_458c27d = 0;
    level clientfield::set("arenaRound", level.doa.var_458c27d);
    level thread util::set_lighting_state(level.doa.var_458c27d);
    namespace_3ca3c537::function_5af67667(level.doa.var_90873830 + 1);
    level.doa.var_bc9b7c71 = var_e5c8b9e7;
}

// Namespace namespace_a3646565
// Params 0, eflags: 0x4
// Checksum 0x2dcfe1b5, Offset: 0x1af0
// Size: 0x7d
function private function_14ba3248() {
    level endon(#"hash_629939b8");
    wait 16;
    foreach (player in getplayers()) {
        player notify(#"menuresponse", "FullscreenMovie", "finished_movie_playback");
    }
}

// Namespace namespace_a3646565
// Params 0, eflags: 0x4
// Checksum 0x38cc4d9b, Offset: 0x1b78
// Size: 0xbf
function private function_72e0a286() {
    level endon(#"all_silverbacks_dead");
    while (true) {
        wait 1;
        valid = [];
        foreach (var_2e488485 in level.doa.var_155f5b81) {
            if (isdefined(var_2e488485) && var_2e488485.health > 0) {
                valid[valid.size] = var_2e488485;
            }
        }
        level.doa.var_155f5b81 = valid;
        if (level.doa.var_155f5b81.size == 0) {
            return;
        }
    }
}

// Namespace namespace_a3646565
// Params 0, eflags: 0x4
// Checksum 0xef57ce99, Offset: 0x1c40
// Size: 0x2a
function private function_b4195d47() {
    level thread function_28eb6914();
    level clientfield::set("activateBanner", 5);
}

// Namespace namespace_a3646565
// Params 1, eflags: 0x0
// Checksum 0xbee98966, Offset: 0x1c78
// Size: 0x1c9
function function_28eb6914(ent) {
    level notify(#"hash_28eb6914");
    level endon(#"hash_28eb6914");
    level endon(#"doa_game_is_over");
    level endon(#"all_silverbacks_dead");
    level clientfield::set("pumpBannerBar", 0);
    util::wait_network_frame();
    level clientfield::set("pumpBannerBar", 1);
    if (isdefined(ent)) {
        ent endon(#"death");
        while (true) {
            lasthealth = ent.health;
            ent waittill(#"damage", damage, attacker);
            data = namespace_49107f3a::clamp(ent.health / ent.maxhealth, 0, 1);
            level clientfield::set("pumpBannerBar", data);
        }
        return;
    }
    while (level.doa.var_155f5b81.size) {
        var_9386082f = 0;
        foreach (var_2e488485 in level.doa.var_155f5b81) {
            if (!isdefined(var_2e488485)) {
                continue;
            }
            var_9386082f += var_2e488485.health;
        }
        data = namespace_49107f3a::clamp(var_9386082f / level.doa.var_7b9808fc, 0, 1);
        level clientfield::set("pumpBannerBar", data);
        wait 1;
    }
}

// Namespace namespace_a3646565
// Params 0, eflags: 0x4
// Checksum 0xef59af78, Offset: 0x1e50
// Size: 0x3a
function private function_eb6ee9e0() {
    level endon(#"doa_game_is_over");
    self waittill(#"death");
    level notify(#"hash_ae3ed999");
    level clientfield::set("activateBanner", 0);
}

// Namespace namespace_a3646565
// Params 1, eflags: 0x4
// Checksum 0xb48e033e, Offset: 0x1e98
// Size: 0x462
function private _silverbackGroundSpawn(delay) {
    level endon(#"doa_game_is_over");
    level endon(#"all_silverbacks_dead");
    if (delay) {
        wait delay * 30;
    }
    spawnloc = namespace_49107f3a::function_308fa126(6);
    spot = spawnloc[randomint(spawnloc.size)];
    org = spawn("script_model", spot);
    org.targetname = "_silverbackGroundSpawn";
    org setmodel("tag_origin");
    org2 = spawn("script_origin", spot + (0, 0, 2500));
    org2.targetname = "_silverbackGroundSpawn2";
    player = getplayers()[0];
    if (isdefined(player)) {
        org.angles = vectortoangles(getplayers()[0].origin - org.origin);
    } else {
        org.angles = (0, 0, 0);
    }
    playsoundatposition("zmb_ape_prespawn", org.origin);
    org thread namespace_eaa992c::function_285a2999("silverback_intro");
    wait 0.5;
    org thread namespace_eaa992c::function_285a2999("silverback_intro");
    org thread namespace_eaa992c::function_285a2999("stoneboss_shield_explode");
    wait 0.5;
    org thread namespace_eaa992c::function_285a2999("silverback_intro");
    org thread namespace_eaa992c::function_285a2999("stoneboss_shield_explode");
    wait 0.5;
    wait getdvarfloat("scr_boss_silverback_intro_time", 1);
    silverback = namespace_51bd792::function_36aa8b6c(org2);
    silverback linkto(org2);
    silverback thread namespace_eaa992c::function_285a2999("player_trail_red");
    silverback thread namespace_eaa992c::function_285a2999("silverback_intro_trail1");
    silverback thread namespace_eaa992c::function_285a2999("silverback_intro_trail2");
    player = namespace_831a4a7c::function_5eb6e4d1()[0];
    if (isdefined(player)) {
        anim_ang = vectortoangles(player.origin - org2.origin);
        org2 rotateto((0, anim_ang[1], 0), 0.75);
    }
    org2 moveto(org.origin, 1);
    org2 util::waittill_any_timeout(2, "movedone");
    silverback unlink();
    silverback thread namespace_eaa992c::function_285a2999("silverback_intro_explo");
    silverback thread namespace_eaa992c::turnofffx("silverback_intro_trail1");
    silverback thread namespace_eaa992c::turnofffx("silverback_intro_trail2");
    playrumbleonposition("explosion_generic", org.origin);
    playsoundatposition("zmb_ape_spawn", org.origin);
    silverback.aioverridedamage = &function_ae39e30a;
    level.doa.var_155f5b81[level.doa.var_155f5b81.size] = silverback;
    silverback thread function_19b9f1d6();
    level notify(#"hash_d29de2a8");
    level.doa.var_7b9808fc += silverback.health;
    wait 1;
    org delete();
    org2 delete();
}

// Namespace namespace_a3646565
// Params 15, eflags: 0x0
// Checksum 0x4de59cbb, Offset: 0x2308
// Size: 0xfc
function function_ae39e30a(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal) {
    if (isdefined(eattacker) && isplayer(eattacker)) {
        points = int(idamage * 0.25);
        eattacker namespace_64c6b720::function_80eb303(points, 1);
    }
    namespace_49107f3a::debugmsg("BossHealth(" + self.targetname + "): " + self.health - idamage);
    return idamage;
}

// Namespace namespace_a3646565
// Params 1, eflags: 0x4
// Checksum 0x8a729168, Offset: 0x2410
// Size: 0x10d
function private function_a733cd6a(mech) {
    level endon(#"doa_game_is_over");
    level.doa.var_6fb37836 = mech;
    mech endon(#"death");
    mech thread function_eb6ee9e0();
    level thread _monkeyEjectionSeat(mech.driver);
    mech.driver thread function_fb3b78fe();
    if (!isdefined(mech.maxhealth)) {
        mech.maxhealth = mech.health;
    }
    while (mech.health > 0) {
        /#
            if (getdvarint("<dev string:x28>", 0)) {
                self dodamage(int(mech.maxhealth * 0.01), mech.origin);
            }
        #/
        wait 0.05;
    }
}

// Namespace namespace_a3646565
// Params 0, eflags: 0x0
// Checksum 0xab0ca651, Offset: 0x2528
// Size: 0x121
function function_fb3b78fe() {
    self endon(#"death");
    level endon(#"hash_ae3ed999");
    self.var_15a6bfe6 = 0;
    self useanimtree(#generic);
    while (true) {
        if (isdefined(self.damagedplayer) && self.damagedplayer && self.damagedplayer < gettime() + 1500) {
            if (self.var_15a6bfe6 > gettime()) {
                wait 0.05;
                continue;
            }
            self.var_15a6bfe6 = gettime() + randomintrange(5000, 15000);
            self animscripted("mech_taunt", self.origin, self.angles, "ai_zombie_doa_simianaut_mech_idle_taunt");
            self waittillmatch(#"mech_taunt", "end");
            continue;
        }
        self animscripted("mech_idle", self.origin, self.angles, "ai_zombie_doa_simianaut_mech_idle");
        self waittillmatch(#"mech_idle", "end");
    }
}

// Namespace namespace_a3646565
// Params 1, eflags: 0x4
// Checksum 0x28825ae7, Offset: 0x2658
// Size: 0x1c3
function private _monkeyEjectionSeat(driver) {
    level endon(#"doa_game_is_over");
    level waittill(#"hash_ae3ed999");
    driver playsound("zmb_simianaut_roar");
    driver animscripted("mech_eject", driver.origin, driver.angles, "ai_zombie_doa_simianaut_mech_idle_eject");
    driver waittillmatch(#"mech_eject", "eject");
    loc = spawnstruct();
    loc.angles = (0, 0, 0);
    loc.origin = driver.origin;
    org = spawn("script_model", driver.origin);
    org.targetname = "_monkeyEjectionSeat";
    org setmodel("tag_origin");
    driver linkto(org);
    driver thread namespace_eaa992c::function_285a2999("def_explode");
    driver thread namespace_eaa992c::function_285a2999("silverback_intro_trail1");
    driver thread namespace_eaa992c::function_285a2999("silverback_intro_trail2");
    org moveto(org.origin + (0, 0, 3000), 2);
    org util::waittill_any_timeout(3, "movedone");
    driver delete();
    org delete();
    level notify(#"hash_885b3b5e");
}

// Namespace namespace_a3646565
// Params 0, eflags: 0x4
// Checksum 0x53efb91b, Offset: 0x2828
// Size: 0xbc
function private function_19b9f1d6() {
    level endon(#"doa_game_is_over");
    self.var_d3627554 = int(self.health * 0.8);
    self.var_b220d777 = int(self.health * 0.5);
    self.var_e6ea564a = int(self.health * 0.2);
    self.overrideactordamage = &function_b1dd7cc0;
    self.takedamage = 1;
    self function_ec5c4c1c();
    self waittill(#"death");
}

// Namespace namespace_a3646565
// Params 1, eflags: 0x0
// Checksum 0x6bd0ede8, Offset: 0x28f0
// Size: 0xa
function function_162d9658(params) {
    
}

// Namespace namespace_a3646565
// Params 1, eflags: 0x0
// Checksum 0xb31b838d, Offset: 0x2908
// Size: 0xa
function function_695a39c6(params) {
    
}

// Namespace namespace_a3646565
// Params 1, eflags: 0x0
// Checksum 0xf71b7cb6, Offset: 0x2920
// Size: 0x11a
function function_ec5c4c1c(params) {
    level endon(#"doa_game_is_over");
    self playsound("zmb_simianaut_roar");
    self animscripted("pissedoff", self.origin, self.angles, "ai_zombie_doa_simianaut_ground_pound");
    self waittillmatch(#"pissedoff", "zombie_melee");
    playfx(level._effect["ground_pound"], self.origin);
    self waittillmatch(#"pissedoff", "end");
    self playsound("zmb_simianaut_roar");
    self thread function_f61639be();
    self thread function_a3a6c6d0();
    self thread function_c8f8a134();
    self thread function_b3eb3a0b();
    self thread function_47e8d1a6();
    self thread function_2fd43405();
}

// Namespace namespace_a3646565
// Params 0, eflags: 0x0
// Checksum 0x9f9e8790, Offset: 0x2a48
// Size: 0x155
function function_2fd43405() {
    self endon(#"death");
    if (!isdefined(self.maxhealth)) {
        self.maxhealth = self.health;
    }
    self.var_d3627554 = int(self.health) * 0.75;
    self.var_b220d777 = int(self.health) * 0.5;
    self.var_e6ea564a = int(self.health) * 0.25;
    self.var_b96cf2ea = 0;
    while (true) {
        lasthealth = self.health;
        self waittill(#"damage");
        if (lasthealth > self.var_d3627554 && self.health <= self.var_d3627554) {
            self.var_b96cf2ea = self.var_b96cf2ea + 2;
        }
        if (lasthealth > self.var_b220d777 && self.health <= self.var_b220d777) {
            self.var_b96cf2ea = self.var_b96cf2ea + 2;
        }
        if (lasthealth > self.var_e6ea564a && self.health <= self.var_e6ea564a) {
            self.var_b96cf2ea = self.var_b96cf2ea + 4;
        }
    }
}

// Namespace namespace_a3646565
// Params 0, eflags: 0x0
// Checksum 0xd607c11e, Offset: 0x2ba8
// Size: 0x81
function function_47e8d1a6() {
    if (getdvarint("scr_doa_soak_think", 0)) {
        self endon(#"death");
        if (!isdefined(self.maxhealth)) {
            self.maxhealth = self.health;
        }
        while (true) {
            self dodamage(int(self.maxhealth * 0.05), self.origin);
            wait 60;
        }
    }
}

// Namespace namespace_a3646565
// Params 0, eflags: 0x0
// Checksum 0x663c072d, Offset: 0x2c38
// Size: 0xdd
function function_c8f8a134() {
    self endon(#"death");
    var_4846ae59 = 512 * 512;
    self.zombie_move_speed = "run";
    while (true) {
        wait 0.05;
        if (isdefined(self.enemy)) {
            if (distancesquared(self.enemy.origin, self.origin) > var_4846ae59) {
                self.zombie_move_speed = "sprint";
                while (isdefined(self.enemy) && distancesquared(self.enemy.origin, self.origin) > 256 * 256) {
                    wait 0.05;
                }
            }
            self.zombie_move_speed = "run";
        }
    }
}

// Namespace namespace_a3646565
// Params 1, eflags: 0x0
// Checksum 0xd89eca32, Offset: 0x2d20
// Size: 0xa91
function function_b3eb3a0b(params) {
    self endon(#"death");
    var_b84274b8 = spawn("script_origin", self.origin);
    var_18767fff = 64 * 64;
    while (true) {
        wait 0.05;
        if (isdefined(self.enemy) && randomint(100) < getdvarint("scr_boss_silverback_special_attack_chance_boost", 10)) {
            targetorigin = self.enemy.origin;
            self playsound("zmb_simianaut_roar");
            self animscripted("pissedoff", self.origin, self.angles, "ai_zombie_doa_simianaut_taunt");
            self waittillmatch(#"pissedoff", "end");
            var_b84274b8.angles = self.angles;
            var_b84274b8.origin = self.origin;
            self linkto(var_b84274b8);
            anim_ang = vectortoangles(targetorigin - self.origin);
            var_b84274b8 rotateto((0, anim_ang[1], 0), 0.5);
            var_b84274b8 waittill(#"rotatedone");
            self playsound("zmb_speed_boost_activate_boss");
            playrumbleonposition("explosion_generic", self.origin);
            dist = distance(targetorigin, self.origin) + 256;
            forward = anglestoforward(var_b84274b8.angles);
            var_dc1444a6 = var_b84274b8.origin + forward * dist;
            trace = bullettrace(var_b84274b8.origin + (0, 0, 30), var_dc1444a6 + (0, 0, 30), 0, undefined);
            var_dc1444a6 = trace["position"] + forward * -64;
            distsq = distancesquared(var_b84274b8.origin, var_dc1444a6);
            var_65ef86fe = math::clamp(int(distsq / var_18767fff), 1, 9999);
            traveltime = math::clamp(var_65ef86fe * getdvarfloat("scr_boss_silverback_travel_time64", 0.005), 0, 0.7);
            if (getdvarint("scr_boss_debug_boost", 0)) {
                level thread namespace_49107f3a::debug_circle(var_dc1444a6 + (0, 0, 20), 30, 3, (1, 0, 0));
                level thread namespace_49107f3a::debug_line(var_dc1444a6 + (0, 0, 20), self.origin + (0, 0, 20), 3, (1, 0, 0));
                var_b84274b8 thread namespace_49107f3a::debugorigin(3, 20, (1, 0, 0));
            }
            var_b84274b8 thread function_df12b0c9(self.enemy);
            self.boosting = 1;
            var_b84274b8 moveto(var_dc1444a6, traveltime);
            var_b84274b8 util::waittill_any_timeout(traveltime + 2, "movedone");
            self.boosting = undefined;
            var_b84274b8 notify(#"hash_7018a851");
            if (getdvarint("scr_boss_debug_boost", 0)) {
                var_b84274b8 notify(#"hash_c32e3b78");
            }
            self unlink();
            self stopanimscripted();
            wait getdvarint("scr_boss_silverback_special_attack_cooldown", 5);
            continue;
        }
        if (randomint(100) < getdvarint("scr_boss_silverback_special_attack_chance_launch", 15)) {
            self playsound("zmb_simianaut_roar");
            self animscripted("pissedoff", self.origin, self.angles, "ai_zombie_doa_simianaut_taunt");
            self waittillmatch(#"pissedoff", "end");
            players = namespace_831a4a7c::function_5eb6e4d1();
            if (players.size == 1) {
                self.favoriteenemy = players[0];
            } else {
                if (isdefined(self.enemy)) {
                    arrayremovevalue(players, self.enemy);
                }
                if (players.size == 1) {
                    self.favoriteenemy = players[0];
                } else {
                    self.favoriteenemy = players[randomint(players.size)];
                }
                if (isdefined(self.favoriteenemy)) {
                    targetpos = self.favoriteenemy.origin;
                }
            }
            if (!isdefined(targetpos)) {
                spawnloc = namespace_49107f3a::function_308fa126(6);
                targetpos = spawnloc[randomint(spawnloc.size)];
            }
            self playsound("evt_turret_takeoff");
            self thread namespace_eaa992c::function_285a2999("boss_takeoff");
            self thread namespace_eaa992c::function_285a2999("crater_dust");
            playrumbleonposition("explosion_generic", self.origin);
            height = 800;
            timems = height / 1000 * 3000;
            var_b84274b8.angles = self.angles;
            var_b84274b8.origin = self.origin;
            self linkto(var_b84274b8);
            if (getdvarint("scr_boss_debug_launch", 0)) {
                level thread namespace_49107f3a::debug_circle(targetpos + (0, 0, 20), 30, 3, (1, 0, 0));
                var_b84274b8 thread namespace_49107f3a::debugorigin(3, 20, (1, 0, 0));
            }
            var_b84274b8 thread function_df12b0c9(self.enemy);
            self thread function_5659ec29("move_to_pos_downward_cycle");
            var_b84274b8 function_8bc2f7b(targetpos, timems, height);
            self unlink();
            self playsound("zmb_simianaut_roar");
            self animscripted("pissedoff", self.origin, self.angles, "ai_zombie_doa_simianaut_attack_v1");
            self waittillmatch(#"pissedoff", "fire");
            if (isdefined(self.var_a09d9abe)) {
                self.var_a09d9abe unlink();
                self.var_a09d9abe = undefined;
            }
            var_b84274b8 notify(#"hash_7018a851");
            if (getdvarint("scr_boss_debug_launch", 0)) {
                var_b84274b8 notify(#"hash_c32e3b78");
            }
            self thread namespace_eaa992c::function_285a2999("turret_impact");
            self playsound("evt_turret_land");
            physicsexplosionsphere(self.origin, -56, -128, 2);
            targetpos = undefined;
            wait getdvarint("scr_boss_silverback_special_attack_cooldown", 5);
            continue;
        }
        if (function_e1938709() && isdefined(self.enemy) && randomint(100) < getdvarint("scr_boss_silverback_special_attack_chance_banana", 6) + self.var_b96cf2ea) {
            banana1 = spawn("script_model", self.origin);
            banana1.targetname = "banana1";
            if (isdefined(banana1)) {
                banana1 thread function_b830b6d7("tag_weapon_right", self);
            }
            banana2 = spawn("script_model", self.origin);
            banana2.targetname = "banana2";
            if (isdefined(banana2)) {
                banana2 thread function_b830b6d7("tag_weapon_left", self);
            }
            if (isdefined(banana1) || isdefined(banana2)) {
                self playsound("zmb_simianaut_roar");
                var_b84274b8.angles = self.angles;
                var_b84274b8.origin = self.origin;
                self linkto(var_b84274b8);
                anim_ang = vectortoangles(self.enemy.origin - self.origin);
                var_b84274b8 rotateto((0, anim_ang[1], 0), 0.5);
                var_b84274b8 waittill(#"rotatedone");
                self unlink();
                self animscripted("pissedoff", self.origin, self.angles, "ai_zombie_doa_simianaut_attack_v1");
                self waittillmatch(#"pissedoff", "fire");
                self notify(#"hash_5825c195");
            }
            wait getdvarint("scr_boss_silverback_special_attack_cooldown", 5);
            continue;
        }
    }
}

// Namespace namespace_a3646565
// Params 0, eflags: 0x0
// Checksum 0x70082412, Offset: 0x37c0
// Size: 0x2a
function function_e1938709() {
    return level.doa.var_22c9944.size <= getdvarint("scr_boss_banana_max", 4);
}

// Namespace namespace_a3646565
// Params 2, eflags: 0x0
// Checksum 0xfe70e4de, Offset: 0x37f8
// Size: 0x30a
function function_b830b6d7(linktag, silverback) {
    level.doa.var_22c9944[level.doa.var_22c9944.size] = self;
    self linkto(silverback, linktag);
    self setmodel("zombietron_banana");
    silverback waittill(#"hash_5825c195");
    self unlink();
    forward = anglestoforward(silverback.angles);
    target_point = silverback.origin + getdvarfloat("scr_boss_banana_influence_forward", 64) * forward + (randomfloatrange(getdvarfloat("scr_boss_banana_incluence_random", 2) * -1, getdvarfloat("scr_boss_banana_incluence_random", 2)), randomfloatrange(getdvarfloat("scr_boss_banana_incluence_random", 2) * -1, getdvarfloat("scr_boss_banana_incluence_random", 2)), getdvarfloat("scr_boss_banana_incluence_up", -126));
    vel = vectornormalize(target_point - self.origin);
    vel *= getdvarfloat("scr_boss_banana_velocity", 0.8);
    self physicslaunch(self.origin, vel);
    self thread namespace_eaa992c::function_285a2999("explo_warning_light_banana");
    wait getdvarfloat("scr_boss_banana_fuse", 5);
    self thread namespace_eaa992c::function_285a2999("silverback_banana_explo");
    wait 0.5;
    trigger = spawn("trigger_radius", self.origin, 0, -128, 64);
    trigger.targetname = "banana";
    arrayremovevalue(level.doa.var_22c9944, self);
    self delete();
    trigger thread function_c2d22e21();
    if (getdvarint("scr_boss_debug_banana", 0)) {
        level thread namespace_49107f3a::debug_circle(trigger.origin + (0, 0, 20), -128, getdvarfloat("scr_boss_banana_life", 5), (1, 0, 0));
    }
    wait getdvarfloat("scr_boss_banana_life", 5);
    trigger delete();
}

// Namespace namespace_a3646565
// Params 0, eflags: 0x4
// Checksum 0xfa17e81, Offset: 0x3b10
// Size: 0x79
function private function_c2d22e21() {
    self endon(#"death");
    while (true) {
        self waittill(#"trigger", guy);
        if (isplayer(guy)) {
            if (!isdefined(guy.var_18098213) || gettime() > guy.var_18098213) {
                guy notify(#"hash_9132a424");
                guy.var_18098213 = gettime() + 1000;
            }
        }
    }
}

// Namespace namespace_a3646565
// Params 1, eflags: 0x4
// Checksum 0xc3d28530, Offset: 0x3b98
// Size: 0x97
function private function_df12b0c9(target) {
    if (!isdefined(target)) {
        return;
    }
    self endon(#"hash_7018a851");
    self notify(#"hash_df12b0c9");
    self endon(#"hash_df12b0c9");
    target endon(#"death");
    target endon(#"disconnect");
    while (isdefined(target)) {
        anim_ang = vectortoangles(target.origin - self.origin);
        self rotateto((0, anim_ang[1], 0), 0.5);
        self waittill(#"rotatedone");
    }
}

// Namespace namespace_a3646565
// Params 1, eflags: 0x4
// Checksum 0x88960377, Offset: 0x3c38
// Size: 0x11e
function private function_5659ec29(var_c840292d) {
    self notify(#"hash_5659ec29");
    self endon(#"death");
    self endon(#"hash_5659ec29");
    level waittill(var_c840292d);
    loc = spawnstruct();
    loc.origin = self.origin;
    loc.angles = self.angles;
    spawner = randomint(100) > 50 ? level.doa.var_5f57a68d : level.doa.var_b5aef19c;
    if (spawner == level.doa.var_5f57a68d) {
        ai = namespace_51bd792::function_1631202b(spawner, loc);
    } else {
        ai = namespace_51bd792::function_33525e11(spawner, loc);
    }
    if (isdefined(ai)) {
        ai linkto(self, "tag_weapon_right");
        ai.health = 1000;
        self.var_a09d9abe = ai;
    }
}

// Namespace namespace_a3646565
// Params 0, eflags: 0x4
// Checksum 0x5bc4656, Offset: 0x3d60
// Size: 0xc5
function private function_a3a6c6d0() {
    self endon(#"death");
    while (true) {
        var_6792dc08 = getentarray("a_pickup_item", "script_noteworthy");
        for (i = 0; i < var_6792dc08.size; i++) {
            pickup = var_6792dc08[i];
            if (isdefined(pickup)) {
                distsq = distancesquared(self.origin, pickup.origin);
                if (distsq < 72 * 72) {
                    pickup thread namespace_a7e6beb5::function_6b4a5f81();
                }
            }
        }
        wait 0.1;
    }
}

// Namespace namespace_a3646565
// Params 1, eflags: 0x0
// Checksum 0xc2d1052d, Offset: 0x3e30
// Size: 0x171
function function_f61639be(dist) {
    if (!isdefined(dist)) {
        dist = 72;
    }
    level endon(#"exit_taken");
    level endon(#"hash_f9703b89");
    self endon(#"death");
    distsq = dist * dist;
    while (isdefined(self)) {
        players = namespace_831a4a7c::function_5eb6e4d1();
        foreach (player in players) {
            if (!isdefined(player)) {
                continue;
            }
            if (distancesquared(self.origin, player.origin) < distsq) {
                player dodamage(player.health + 666, player.origin);
                if (!(isdefined(self.boosting) && self.boosting)) {
                    self playsound("zmb_simianaut_roar");
                    self animscripted("pissedoff", self.origin, self.angles, "ai_zombie_doa_simianaut_attack_v1");
                }
                wait 3;
            }
        }
        wait 0.05;
    }
}

// Namespace namespace_a3646565
// Params 12, eflags: 0x0
// Checksum 0x805b9766, Offset: 0x3fb0
// Size: 0x104
function function_b1dd7cc0(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    if (self.health >= self.var_d3627554 && self.health - damage < self.var_d3627554) {
    } else if (self.health >= self.var_b220d777 && self.health - damage < self.var_b220d777) {
    } else if (self.health >= self.var_e6ea564a && self.health - damage < self.var_e6ea564a) {
    }
    namespace_49107f3a::debugmsg("Silverback took damage: " + damage + " of type:" + mod);
    return damage;
}

// Namespace namespace_a3646565
// Params 1, eflags: 0x0
// Checksum 0x3dd59ab0, Offset: 0x40c0
// Size: 0x152
function function_a753035a(egg) {
    level.doa.var_2775f29c = egg;
    level endon(#"doa_game_is_over");
    egg physicslaunch(egg.origin, (0, 0, 10));
    hops = 6;
    while (hops) {
        wait randomfloatrange(0.5 * hops, 1.2 * hops);
        hops--;
        egg namespace_5e6c5d1f::function_d63bdb9(1);
    }
    egg playsound("zmb_egg_hatch");
    egg thread namespace_eaa992c::function_285a2999("egg_hatchXL");
    chicken = spawn("script_model", egg.origin);
    chicken.targetname = "fidohatched";
    chicken setmodel("zombietron_chicken_fido");
    level.doa.var_17593d0e = chicken;
    util::wait_network_frame();
    egg delete();
    level thread function_1d9d0ed2(chicken);
}

// Namespace namespace_a3646565
// Params 1, eflags: 0x0
// Checksum 0x406815b5, Offset: 0x4220
// Size: 0x79
function function_1d9d0ed2(chicken) {
    chicken endon(#"death");
    chicken thread namespace_5e6c5d1f::function_cdfa9ce8(chicken);
    chicken.var_a732885d = 1;
    var_2e036f52 = 1;
    while (true) {
        chicken rotateto(chicken.angles + (0, 180, 0), var_2e036f52);
        wait 1;
    }
}

// Namespace namespace_a3646565
// Params 3, eflags: 0x0
// Checksum 0xa24250e5, Offset: 0x42a8
// Size: 0x201
function function_8bc2f7b(destination, timems, var_cc70d530) {
    self endon(#"death");
    frames = timems / 50;
    delta = (destination - self.origin) / frames;
    stoptime = gettime() + timems;
    if (isdefined(var_cc70d530)) {
        deltaz = var_cc70d530 / frames / 2;
        var_7679a621 = gettime() + timems / 2;
        while (true) {
            time = gettime();
            if (time > stoptime) {
                break;
            }
            if (time < var_7679a621) {
                var_98c693d1 = delta + (0, 0, deltaz);
                var_4f4b0e1a = 1;
            } else {
                if (isdefined(var_4f4b0e1a) && var_4f4b0e1a) {
                    level notify(#"move_to_pos_downward_cycle");
                    self notify(#"move_to_pos_downward_cycle");
                }
                var_4f4b0e1a = 0;
                var_98c693d1 = delta - (0, 0, deltaz);
            }
            newspot = self.origin + var_98c693d1;
            if (newspot[2] < destination[2]) {
                newspot = (newspot[0], newspot[1], destination[2]);
                if (isai(self)) {
                    self forceteleport(newspot);
                    return;
                }
                self.origin = newspot;
                return;
            }
            if (isai(self)) {
                self forceteleport(newspot);
            } else {
                self.origin = newspot;
            }
            wait 0.05;
        }
        return;
    }
    while (gettime() < stoptime) {
        if (isai(self)) {
            self forceteleport(self.origin + delta);
        } else {
            self.origin = self.origin + delta;
        }
        wait 0.05;
    }
}

