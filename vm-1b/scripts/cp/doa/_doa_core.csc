#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/cp_doa_bo3_fx;
#using scripts/cp/cp_doa_bo3_sound;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_camera;
#using scripts/cp/doa/_doa_core;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_sfx;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_vortex;
#using scripts/shared/blood;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace namespace_693feb87;

// Namespace namespace_693feb87
// Params 0, eflags: 0x0
// Checksum 0xd773fbc8, Offset: 0xb30
// Size: 0xdfa
function main() {
    namespace_3ca3c537::init();
    namespace_eaa992c::init();
    namespace_1a381543::init();
    namespace_64c6b720::init();
    namespace_ad544aeb::function_d22ceb57((75, 0, 0), 600);
    level.disablewatersurfacefx = 1;
    level.var_160ae6c6 = 1;
    level.var_666a15bd = 0;
    level.gibresettime = 0.5;
    level.gibmaxcount = 3;
    level.gibtimer = 0;
    level.gibcount = 0;
    level.var_ff8aba3b = (0, 0, 4);
    level.var_96344b03 = 3;
    level.var_46418da4 = 2;
    level.var_bd436f37 = 0.5;
    level.var_e3119165 = array("zombietron_gib_chunk_fat", "zombietron_gib_chunk_bone_01", "zombietron_gib_chunk_bone_02", "zombietron_gib_chunk_bone_03", "zombietron_gib_chunk_flesh_01", "zombietron_gib_chunk_flesh_02", "zombietron_gib_chunk_flesh_03", "zombietron_gib_chunk_meat_01", "zombietron_gib_chunk_meat_02", "zombietron_gib_chunk_meat_03");
    clientfield::register("world", "podiumEvent", 1, 1, "int", &podiumEvent, 0, 0);
    clientfield::register("world", "overworld", 1, 1, "int", &function_a6c926fc, 0, 0);
    clientfield::register("world", "scoreMenu", 1, 1, "int", &function_d3b4c89d, 0, 0);
    clientfield::register("world", "overworldlevel", 1, 5, "int", &function_22de3f7, 0, 0);
    clientfield::register("scriptmover", "play_fx", 1, 7, "int", &function_351aa01c, 0, 0);
    clientfield::register("allplayers", "play_fx", 1, 7, "int", &function_351aa01c, 0, 0);
    clientfield::register("actor", "play_fx", 1, 7, "int", &function_351aa01c, 0, 0);
    clientfield::register("vehicle", "play_fx", 1, 7, "int", &function_351aa01c, 0, 0);
    clientfield::register("scriptmover", "off_fx", 1, 7, "int", &function_33760903, 0, 0);
    clientfield::register("allplayers", "off_fx", 1, 7, "int", &function_33760903, 0, 0);
    clientfield::register("actor", "off_fx", 1, 7, "int", &function_33760903, 0, 0);
    clientfield::register("vehicle", "off_fx", 1, 7, "int", &function_33760903, 0, 0);
    clientfield::register("scriptmover", "play_sfx", 1, 7, "int", &function_68503cb7, 0, 0);
    clientfield::register("allplayers", "play_sfx", 1, 7, "int", &function_68503cb7, 0, 0);
    clientfield::register("actor", "play_sfx", 1, 7, "int", &function_68503cb7, 0, 0);
    clientfield::register("vehicle", "play_sfx", 1, 7, "int", &function_68503cb7, 0, 0);
    clientfield::register("scriptmover", "off_sfx", 1, 7, "int", &function_9bf26aa6, 0, 0);
    clientfield::register("allplayers", "off_sfx", 1, 7, "int", &function_9bf26aa6, 0, 0);
    clientfield::register("actor", "off_sfx", 1, 7, "int", &function_9bf26aa6, 0, 0);
    clientfield::register("vehicle", "off_sfx", 1, 7, "int", &function_9bf26aa6, 0, 0);
    clientfield::register("allplayers", "fated_boost", 1, 1, "int", &function_409fa9ce, 0, 0);
    clientfield::register("allplayers", "bombDrop", 1, 1, "int", &function_f87ff72d, 0, 0);
    clientfield::register("toplayer", "controlBinding", 1, 1, "counter", &function_f8c69ca4, 0, 0);
    clientfield::register("toplayer", "controlBindingDefault", 1, 1, "counter", &function_efc8d4f3, 0, 0);
    clientfield::register("world", "cleanUpGibs", 1, 1, "counter", &cleanUpGibs, 0, 0);
    clientfield::register("world", "killweather", 1, 1, "counter", &namespace_3ca3c537::killweather, 0, 0);
    clientfield::register("world", "flipCamera", 1, 2, "int", &namespace_3ca3c537::flipcamera, 0, 0);
    clientfield::register("world", "arenaUpdate", 1, 8, "int", &namespace_3ca3c537::setarena, 0, 0);
    clientfield::register("world", "arenaRound", 1, 2, "int", &namespace_3ca3c537::arenaRound, 0, 0);
    clientfield::register("actor", "enemy_ragdoll_explode", 1, 1, "int", &zombie_ragdoll_explode_cb, 0, 0);
    clientfield::register("actor", "zombie_gut_explosion", 1, 1, "int", &zombie_gut_explosion_cb, 0, 0);
    clientfield::register("actor", "zombie_chunk", 1, 1, "counter", &function_3a1ccea7, 0, 0);
    clientfield::register("actor", "zombie_saw_explosion", 1, 1, "int", &function_15b503eb, 0, 0);
    clientfield::register("actor", "zombie_rhino_explosion", 1, 1, "int", &function_8b8f5cb4, 0, 0);
    clientfield::register("world", "game_active", 1, 1, "int", &function_8f0839e3, 0, 0);
    clientfield::register("world", "restart_doa", 1, 1, "counter", &function_4ac9a8ba, 0, 0);
    clientfield::register("scriptmover", "hazard_type", 1, 4, "int", &function_20671f0, 0, 0);
    clientfield::register("scriptmover", "hazard_activated", 1, 4, "int", &function_ec2caec3, 0, 0);
    clientfield::register("actor", "zombie_riser_fx", 1, 1, "int", &handle_zombie_risers, 0, 0);
    clientfield::register("actor", "zombie_bloodriser_fx", 1, 1, "int", &function_cb806a9b, 0, 0);
    clientfield::register("scriptmover", "heartbeat", 1, 3, "int", &function_d277a961, 0, 0);
    clientfield::register("scriptmover", "wobble", 1, 1, "int", &namespace_eaa992c::pickupwobble, 0, 0);
    clientfield::register("actor", "burnType", 1, 2, "int", &namespace_eaa992c::burnType, 0, 0);
    clientfield::register("actor", "burnZombie", 1, 1, "counter", &namespace_eaa992c::burnZombie, 0, 0);
    clientfield::register("actor", "burnCorpse", 1, 1, "counter", &namespace_eaa992c::burncorpse, 0, 0);
    clientfield::register("toplayer", "changeCamera", 1, 1, "counter", &changecamera, 0, 0);
    clientfield::register("actor", "zombie_has_eyes", 1, 1, "int", &namespace_eaa992c::zombie_eyes_clientfield_cb, 0, 0);
    clientfield::register("world", "cameraHeight", 1, 3, "int", &function_b868b40f, 0, 0);
    clientfield::register("world", "cleanupGiblets", 1, 1, "int", &cleanupGiblets, 0, 0);
    clientfield::register("scriptmover", "camera_focus_item", 1, 1, "int", &function_354ec425, 0, 0);
    clientfield::register("actor", "camera_focus_item", 1, 1, "int", &function_354ec425, 0, 0);
    clientfield::register("vehicle", "camera_focus_item", 1, 1, "int", &function_354ec425, 0, 0);
    callback::on_spawned(&on_player_spawn);
    callback::on_shutdown(&on_player_shutdown);
    callback::on_localclient_connect(&player_on_connect);
    setdvar("dynEnt_spawnedLimit", 400);
    /#
        clientfield::register("<dev string:x28>", "<dev string:x2e>", 1, 1, "<dev string:x3a>", &fixCameraOn, 0, 0);
        clientfield::register("<dev string:x28>", "<dev string:x3e>", 1, 2, "<dev string:x3a>", &debugCamera, 0, 0);
        clientfield::register("<dev string:x28>", "<dev string:x4a>", 1, 30, "<dev string:x3a>", &debugCameraPayload, 0, 0);
        level.var_83a34f19 = 0;
        level.var_e9c73e06 = 0;
        level.var_7a6087fd = 0;
    #/
    setdvar("scr_use_digital_blood_enabled", 0);
    level thread function_ae0a4fc5();
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x0
// Checksum 0x679699a3, Offset: 0x1938
// Size: 0x20d
function function_ae0a4fc5() {
    self notify(#"hash_ae0a4fc5");
    self endon(#"hash_ae0a4fc5");
    while (true) {
        players = getplayers(0);
        foreach (player in players) {
            if (isdefined(player.doa)) {
                continue;
            }
            if (!player isplayer()) {
                continue;
            }
            if (player islocalplayer() && isspectating(player getlocalclientnumber())) {
                continue;
            }
            if (!isdefined(player.name)) {
                continue;
            }
            if (isdefined(player.var_4abf708a) && !isfxplaying(0, player.var_4abf708a)) {
                player notify(#"hash_aae01d5a", player.var_8064cb04);
            }
            doa = level.var_29e6f519[player getentitynumber()];
            if (isdefined(doa.player) && doa.player != player) {
                function_245e1ba2("player DOA assignment failure: " + player.name + " Reason: DOA struct assigned to " + doa.player.name + " My Ent #" + player getentitynumber() + " Other Ent #" + doa.player getentitynumber());
                continue;
            }
            player function_12c2fbcb();
        }
        wait 0.016;
    }
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0x1fcc7c23, Offset: 0x1b50
// Size: 0x2a
function player_on_connect(localclientnum) {
    disablespeedblur(localclientnum);
    self blood::function_14cd2c76(localclientnum);
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0xe8cd7b57, Offset: 0x1b88
// Size: 0x32
function on_player_spawn(localclientnum) {
    self.entnum = self getentitynumber();
    self thread function_7762e7fe(localclientnum);
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0x66239bf9, Offset: 0x1bc8
// Size: 0x5a
function on_player_shutdown(localclientnum) {
    if (isdefined(self.var_4abf708a)) {
        killfx(localclientnum, self.var_4abf708a);
        self.var_4abf708a = undefined;
    }
    if (self islocalplayer()) {
        self setcontrollerlightbarcolor(localclientnum);
    }
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0x83e16731, Offset: 0x1c30
// Size: 0x195
function function_7762e7fe(localclientnum) {
    self endon(#"entityshutdown");
    if (!isdefined(self.entnum)) {
        self.entnum = self getentitynumber();
    }
    var_36ffb352 = "player_trail_" + function_ee495f41(self.entnum);
    var_58d01926 = "player_trail_" + function_ee495f41(self.entnum) + "_night";
    self.var_8064cb04 = 0;
    while (true) {
        self waittill(#"hash_aae01d5a", newstate);
        self.var_8064cb04 = newstate;
        if (isdefined(self.var_4abf708a)) {
            killfx(localclientnum, self.var_4abf708a);
            self.var_4abf708a = undefined;
        }
        switch (self.var_8064cb04) {
        case 0:
            break;
        case 1:
            self.var_4abf708a = playfxontag(localclientnum, level._effect[var_36ffb352], self, "tag_origin");
            break;
        case 2:
            self.var_4abf708a = playfxontag(localclientnum, level._effect[var_58d01926], self, "tag_origin");
            break;
        default:
            assert(0);
            break;
        }
    }
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0xdf5b3078, Offset: 0x1dd0
// Size: 0x3a
function function_fc05827f(localclientnum) {
    self endon(#"disconnect");
    wait 0.5;
    disablespeedblur(localclientnum);
    self blood::function_14cd2c76(localclientnum);
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x208cc184, Offset: 0x1e18
// Size: 0x82
function function_22de3f7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    level.var_160ae6c6 = newval;
    setuimodelvalue(getuimodel(level.var_7e2a814c, "level"), level.var_160ae6c6);
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xceccac18, Offset: 0x1ea8
// Size: 0xea
function function_d3b4c89d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    player = getlocalplayer(localclientnum);
    if (!isdefined(player)) {
        return;
    }
    if (newval) {
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "forceScoreboard"), 1);
        return;
    }
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "forceScoreboard"), 0);
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x59287a8, Offset: 0x1fa0
// Size: 0x11d
function function_a6c926fc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    player = getlocalplayer(localclientnum);
    if (!isdefined(player)) {
        return;
    }
    if (newval) {
        setuimodelvalue(getuimodel(level.var_7e2a814c, "level"), level.var_160ae6c6);
        if (!isdefined(player.var_336bed9c)) {
            player.var_336bed9c = createluimenu(localclientnum, "DOA_overworld");
        }
        openluimenu(localclientnum, player.var_336bed9c);
        return;
    }
    if (isdefined(player.var_336bed9c)) {
        closeluimenu(localclientnum, player.var_336bed9c);
        player.var_336bed9c = undefined;
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x78449b1a, Offset: 0x20c8
// Size: 0x189
function podiumEvent(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    players = getlocalplayers();
    if (newval) {
        if (!isdefined(level.var_45fd31cd)) {
            level.var_45fd31cd = createluimenu(localclientnum, "DOA_outro_frame");
        }
        openluimenu(localclientnum, level.var_45fd31cd);
        if (isdefined(level.var_ba533099)) {
            exploder::kill_exploder(level.var_ba533099);
            level.var_ba533099 = undefined;
        }
        if (isdefined(level.var_c065e9ed)) {
            stopfx(localclientnum, level.var_c065e9ed);
        }
        level.var_b62087b0 = struct::get("podium_camera", "targetname");
        players[0] camerasetposition(level.var_b62087b0.origin);
        players[0] camerasetlookat(level.var_b62087b0.angles);
        return;
    }
    if (isdefined(level.var_45fd31cd)) {
        closeluimenu(localclientnum, level.var_45fd31cd);
        level.var_45fd31cd = undefined;
    }
    level.var_b62087b0 = undefined;
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x855dc004, Offset: 0x2260
// Size: 0xf2
function function_354ec425(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (!(isdefined(self.var_354ec425) && self.var_354ec425)) {
            self.var_354ec425 = 1;
            if (!isdefined(level.var_172ed9a1)) {
                level.var_172ed9a1 = [];
            } else if (!isarray(level.var_172ed9a1)) {
                level.var_172ed9a1 = array(level.var_172ed9a1);
            }
            level.var_172ed9a1[level.var_172ed9a1.size] = self;
        }
        return;
    }
    if (isdefined(self.var_354ec425) && self.var_354ec425) {
        self.var_354ec425 = undefined;
        arrayremovevalue(level.var_172ed9a1, self);
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x20fc7152, Offset: 0x2360
// Size: 0x4a
function cleanupGiblets(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    cleanupspawneddynents();
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0xe235d6cb, Offset: 0x23b8
// Size: 0x71
function function_ee495f41(num) {
    switch (num) {
    case 0:
        return "green";
    case 1:
        return "blue";
    case 2:
        return "red";
    case 3:
        return "yellow";
    default:
        assert(0);
        break;
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x5c53d9a6, Offset: 0x2438
// Size: 0xca
function function_351aa01c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    if (newval != 0) {
        name = namespace_eaa992c::function_9e6fe7c3(newval);
        if (isdefined(self.var_ec1cda64) && namespace_eaa992c::function_7664cc94(newval) && isdefined(self.var_ec1cda64[name])) {
            self thread namespace_eaa992c::function_e68e3c0d(localclientnum, name, 1);
        }
        self thread namespace_eaa992c::function_e68e3c0d(localclientnum, name, 0, namespace_eaa992c::function_28a90644(newval));
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x82fb6af5, Offset: 0x2510
// Size: 0x6a
function function_33760903(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    if (newval != 0) {
        self thread namespace_eaa992c::function_e68e3c0d(localclientnum, namespace_eaa992c::function_9e6fe7c3(newval), 1);
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x2f08c8ba, Offset: 0x2588
// Size: 0x62
function function_68503cb7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (localclientnum != 0) {
        return;
    }
    if (newval != 0) {
        self namespace_1a381543::function_1f085aea(localclientnum, newval, 0);
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x798f72ee, Offset: 0x25f8
// Size: 0x62
function function_9bf26aa6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (localclientnum != 0) {
        return;
    }
    if (newval != 0) {
        self namespace_1a381543::function_1f085aea(localclientnum, newval, 1);
    }
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0x332b7243, Offset: 0x2668
// Size: 0xed
function function_10477d98(localclientnum) {
    self notify(#"hash_f33fde4b");
    self endon(#"disconnect");
    self endon(#"hash_7f60c43e");
    self endon(#"entityshutdown");
    self endon(#"hash_f33fde4b");
    endtime = gettime() + 600;
    self playsound(0, "zmb_fated_boost_activate");
    while (gettime() < endtime) {
        playfx(localclientnum, level._effect["fury_boost"], self.origin, anglestoforward(self.angles), (0, 0, 1));
        playfx(localclientnum, level._effect["fury_patch"], self.origin, anglestoforward(self.angles), (0, 0, 1));
        wait 0.01;
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x7752e615, Offset: 0x2760
// Size: 0x6a
function function_b868b40f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        level.var_e7f3233a = undefined;
    } else {
        level.var_e7f3233a = newval;
    }
    namespace_3ca3c537::function_986ae2b3(localclientnum);
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x502cbdc0, Offset: 0x27d8
// Size: 0x67
function function_409fa9ce(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    if (newval) {
        self thread function_10477d98(localclientnum);
        return;
    }
    self notify(#"hash_f33fde4b");
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x4e5db13d, Offset: 0x2848
// Size: 0x131
function function_cb806a9b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    self endon(#"entityshutdown");
    if (!oldval && newval) {
        localplayers = level.localplayers;
        sound = "zmb_zombie_spawn";
        burst_fx = level._effect["rise_blood_burst"];
        billow_fx = level._effect["rise_blood_billow"];
        var_cf929ddb = level._effect["rise_blood_dust"];
        type = "dirt";
        playsound(0, sound, self.origin);
        for (i = 0; i < localplayers.size; i++) {
            self thread rise_dust_fx(i, type, billow_fx, burst_fx, var_cf929ddb);
        }
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xb21db516, Offset: 0x2988
// Size: 0x131
function handle_zombie_risers(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    self endon(#"entityshutdown");
    if (!oldval && newval) {
        localplayers = level.localplayers;
        sound = "zmb_zombie_spawn";
        burst_fx = level._effect["rise_burst"];
        billow_fx = level._effect["rise_billow"];
        var_cf929ddb = level._effect["rise_dust"];
        type = "dirt";
        playsound(0, sound, self.origin);
        for (i = 0; i < localplayers.size; i++) {
            self thread rise_dust_fx(i, type, billow_fx, burst_fx, var_cf929ddb);
        }
    }
}

// Namespace namespace_693feb87
// Params 5, eflags: 0x0
// Checksum 0x5f010aef, Offset: 0x2ac8
// Size: 0x151
function rise_dust_fx(localclientnum, type, billow_fx, burst_fx, var_cf929ddb) {
    if (localclientnum != 0) {
        return;
    }
    dust_tag = "J_SpineUpper";
    self endon(#"entityshutdown");
    if (isdefined(burst_fx)) {
        playfx(localclientnum, burst_fx, self.origin + (0, 0, randomintrange(5, 10)));
    }
    wait 0.25;
    if (isdefined(billow_fx)) {
        playfx(localclientnum, billow_fx, self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
    }
    wait 2;
    dust_time = 5.5;
    dust_interval = 0.3;
    player = level.localplayers[localclientnum];
    for (t = 0; t < dust_time; t += dust_interval) {
        playfxontag(localclientnum, var_cf929ddb, self, dust_tag);
        wait dust_interval;
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x101dee6b, Offset: 0x2c28
// Size: 0x5a
function function_20671f0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    self.hazard_type = newval;
    self thread function_38452435(localclientnum);
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x6d4c3cab, Offset: 0x2c90
// Size: 0xad
function function_ec2caec3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    if (!isdefined(self.hazard_type)) {
        self.hazard_type = 0;
    }
    switch (self.hazard_type) {
    case 1:
        self function_e41e6611(localclientnum, newval);
        break;
    case 2:
        self function_d8d20160(localclientnum, newval);
        break;
    }
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x4
// Checksum 0xe840fe70, Offset: 0x2d48
// Size: 0x79
function private function_38452435(localclientnum) {
    if (localclientnum != 0) {
        return;
    }
    self notify(#"hash_38452435");
    self endon(#"hash_38452435");
    self waittill(#"entityshutdown");
    if (isdefined(self.fx)) {
        deletefx(localclientnum, self.fx);
        self.fx = undefined;
    }
    if (isdefined(self.fx2)) {
        deletefx(localclientnum, self.fx2);
        self.fx2 = undefined;
    }
}

// Namespace namespace_693feb87
// Params 2, eflags: 0x0
// Checksum 0x6ec14c22, Offset: 0x2dd0
// Size: 0x2a5
function function_e41e6611(localclientnum, value) {
    if (localclientnum != 0) {
        return;
    }
    switch (value) {
    case 0:
        break;
    case 1:
        if (isdefined(self.fx)) {
            deletefx(localclientnum, self.fx);
            self.fx = undefined;
        }
        if (isdefined(self.fx2)) {
            deletefx(localclientnum, self.fx2);
            self.fx2 = undefined;
        }
        self.fx2 = playfx(localclientnum, level._effect["trap_green"], self.origin + (0, 0, 124));
        break;
    case 2:
        if (isdefined(self.fx)) {
            deletefx(localclientnum, self.fx);
            self.fx = undefined;
        }
        if (isdefined(self.fx2)) {
            deletefx(localclientnum, self.fx2);
            self.fx2 = undefined;
        }
        self.fx2 = playfx(localclientnum, level._effect["trap_red"], self.origin + (0, 0, 124));
        break;
    case 3:
        if (isdefined(self.fx)) {
            deletefx(localclientnum, self.fx);
            self.fx = undefined;
        }
        if (isdefined(self.fx2)) {
            deletefx(localclientnum, self.fx2);
            self.fx2 = undefined;
        }
        self.fx = playfx(localclientnum, level._effect["electric_trap"], self.origin + (0, 0, 100));
        self.fx2 = playfx(localclientnum, level._effect["hazard_electric"], self.origin + (0, 0, 124));
        break;
    case 9:
        if (isdefined(self.fx)) {
            deletefx(localclientnum, self.fx);
        }
        if (isdefined(self.fx2)) {
            deletefx(localclientnum, self.fx2);
        }
        break;
    }
}

// Namespace namespace_693feb87
// Params 2, eflags: 0x0
// Checksum 0x1dc51329, Offset: 0x3080
// Size: 0x115
function function_d8d20160(localclientnum, value) {
    if (localclientnum != 0) {
        return;
    }
    switch (value) {
    case 3:
        self.fx = playfxontag(localclientnum, level._effect["trashcan_active"], self, "tag_origin");
        break;
    case 4:
    case 5:
    case 6:
        playfx(localclientnum, level._effect["trashcan_damaged"], self.origin + (0, 0, 32));
        break;
    case 9:
        playfx(localclientnum, level._effect["trashcan_destroyed"], self.origin + (0, 0, 32));
        if (isdefined(self.fx)) {
            deletefx(localclientnum, self.fx);
        }
        break;
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x775403c9, Offset: 0x31a0
// Size: 0x42
function function_8f0839e3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.var_666a15bd = newval;
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xcbfcc2c9, Offset: 0x31f0
// Size: 0xfb
function function_4ac9a8ba(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    namespace_3ca3c537::restart();
    namespace_64c6b720::function_6fa6dee2(localclientnum);
    namespace_ad544aeb::function_d22ceb57((75, 0, 0), 600);
    cleanupspawneddynents();
    foreach (player in getplayers(localclientnum)) {
        player.doa = undefined;
        player thread function_12c2fbcb();
    }
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0x2d42b2b8, Offset: 0x32f8
// Size: 0x16a
function function_f7c0d598(mapping) {
    if (!isdefined(mapping)) {
        mapping = "zombietron";
    }
    self notify(#"hash_f7c0d598");
    self endon(#"hash_f7c0d598");
    self endon(#"entityshutdown");
    self endon(#"disconnect");
    function_245e1ba2("Remapping controller on Player: " + (isdefined(self.name) ? self.name : "Unk Player") + "\tMapping = " + mapping + "\tIsLocalPlayer:" + (self islocalplayer() ? "true" : "false"));
    if (self islocalplayer()) {
        clientnum = self getlocalclientnumber();
        function_245e1ba2("\tRemapping controller local clientNumber: " + clientnum);
        if (!self isdriving(clientnum)) {
            forcegamemodemappings(clientnum, mapping);
            function_245e1ba2("\tRemapping controller executed");
        } else {
            function_245e1ba2("\tRemapping controller failed; Player is Driving");
        }
        return;
    }
    function_245e1ba2("\tRemapping controller failed; Player is remote client");
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xedbf8468, Offset: 0x3470
// Size: 0x4a
function function_f8c69ca4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread function_f7c0d598();
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xbbeee96b, Offset: 0x34c8
// Size: 0x3a
function function_efc8d4f3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xe351c562, Offset: 0x3510
// Size: 0x21a
function function_f87ff72d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    if (newval == 0) {
        return;
    }
    if (issplitscreen() && !issplitscreenhost(localclientnum)) {
        return;
    }
    var_ec8a4984 = self.origin;
    origin = var_ec8a4984 + (20, 0, 2000);
    bomb = spawn(0, origin, "script_model");
    bomb setmodel("zombietron_nuke");
    bomb.angles = (90, 0, 0);
    bomb moveto(var_ec8a4984, 0.3, 0, 0);
    playsound(0, "zmb_nuke_incoming", self.origin);
    bomb waittill(#"movedone");
    playsound(0, "zmb_nuke_impact", var_ec8a4984);
    playfx(0, level._effect["bomb"], var_ec8a4984);
    foreach (player in getlocalplayers()) {
        player earthquake(1, 0.8, var_ec8a4984, 1000);
    }
    bomb delete();
    wait 0.2;
    playfx(0, level._effect["nuke_dust"], var_ec8a4984);
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0xfbb7df53, Offset: 0x3738
// Size: 0x67
function randomize_array(array) {
    for (i = 0; i < array.size; i++) {
        j = randomint(array.size);
        temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
    return array;
}

// Namespace namespace_693feb87
// Params 3, eflags: 0x0
// Checksum 0xc2c2fae6, Offset: 0x37a8
// Size: 0x141
function function_ef1ad359(origin, count, dir) {
    if (!isdefined(count)) {
    }
    for (count = 3; count; count--) {
        if (!isdefined(dir)) {
            dir = (level.var_ff8aba3b + (randomfloatrange(level.var_46418da4 * -1 - count, level.var_46418da4 + count), randomfloatrange(level.var_46418da4 * -1 - count, level.var_46418da4 + count), randomintrange(level.var_96344b03 * -1 - count, level.var_96344b03 + count))) * level.var_bd436f37;
        }
        model = level.var_e3119165[randomint(level.var_e3119165.size)];
        launchorigin = origin + (randomintrange(-12, 12), randomintrange(-12, 12), randomintrange(-40, 12));
        createdynentandlaunch(0, model, launchorigin, (0, 0, 0), launchorigin, dir, level._effect["gibtrail_fx"], 1);
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xbced9aba, Offset: 0x38f8
// Size: 0xda
function function_3a1ccea7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    if (isdefined(level._effect["zombie_guts_explosion"]) && util::is_mature()) {
        where = self gettagorigin("J_SpineLower");
        if (!isdefined(where)) {
            where = self.origin;
        }
        playfx(localclientnum, level._effect["zombie_guts_explosion"], where);
        level thread function_ef1ad359(where, 1);
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x46f3f0c4, Offset: 0x39e0
// Size: 0xda
function zombie_gut_explosion_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    if (newval) {
        if (isdefined(level._effect["zombie_guts_explosion"]) && util::is_mature()) {
            where = self gettagorigin("J_SpineLower");
            if (!isdefined(where)) {
                where = self.origin;
            }
            playfx(localclientnum, level._effect["zombie_guts_explosion"], where);
            level thread function_ef1ad359(where, 6);
        }
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xcb54b98, Offset: 0x3ac8
// Size: 0xd2
function function_15b503eb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    if (!newval) {
        return;
    }
    if (isdefined(level._effect["zombie_guts_explosion"]) && util::is_mature()) {
        where = self gettagorigin("J_SpineLower");
        if (!isdefined(where)) {
            where = self.origin;
        }
        playfx(localclientnum, level._effect["zombie_guts_explosion"], where);
        level thread function_ef1ad359(where);
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xaf44b115, Offset: 0x3ba8
// Size: 0xda
function function_8b8f5cb4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    if (!newval) {
        return;
    }
    if (isdefined(level._effect["zombie_guts_explosion"]) && util::is_mature()) {
        where = self gettagorigin("J_SpineLower");
        if (!isdefined(where)) {
            where = self.origin;
        }
        playfx(localclientnum, level._effect["zombie_guts_explosion"], where);
        level thread function_ef1ad359(where, 5);
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x29db5fbc, Offset: 0x3c90
// Size: 0x5a
function zombie_ragdoll_explode_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    if (newval) {
        self zombie_wait_explode(localclientnum);
    }
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0x36a87921, Offset: 0x3cf8
// Size: 0xe2
function zombie_wait_explode(localclientnum) {
    if (localclientnum != 0) {
        return;
    }
    where = self gettagorigin("J_SpineLower");
    if (!isdefined(where)) {
        where = self.origin;
    }
    start = gettime();
    while (gettime() - start < 2000) {
        if (isdefined(self)) {
            where = self gettagorigin("J_SpineLower");
            if (!isdefined(where)) {
                where = self.origin;
            }
        }
        wait 0.05;
    }
    if (isdefined(level._effect["zombie_guts_explosion"]) && util::is_mature()) {
        playfx(localclientnum, level._effect["zombie_guts_explosion"], where);
    }
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0x1afefdcc, Offset: 0x3de8
// Size: 0x209
function function_36c61ba6(localclientnum) {
    if (localclientnum != 0) {
        return;
    }
    self endon(#"entityshutdown");
    targetscale = 1.25;
    var_ad5de66e = 1;
    currentscale = 1;
    var_711842d8 = 0.002;
    var_fa7c415 = 0.002;
    var_ba7af42 = var_711842d8;
    baseangles = self.angles;
    self.rate = 1;
    while (isdefined(self)) {
        var_ba7af42 = var_711842d8;
        playfx(localclientnum, level._effect["gibtrail_fx"], self.origin + (randomintrange(-12, 12), randomintrange(-12, 12), 24), (1, 0, 0), (0, 0, 1));
        while (currentscale < targetscale) {
            currentscale += var_ba7af42;
            var_ba7af42 += var_fa7c415 * self.rate;
            if (currentscale > targetscale) {
                currentscale = targetscale;
            }
            self setscale(currentscale);
            self.angles = self.angles + (0, 1, 1);
            wait 0.016;
        }
        while (currentscale > var_ad5de66e) {
            currentscale -= var_ba7af42;
            var_ba7af42 -= var_fa7c415 * self.rate;
            if (var_ba7af42 < 0.0125) {
                var_ba7af42 = 0.0125;
            }
            if (currentscale < var_ad5de66e) {
                currentscale = var_ad5de66e;
            }
            self setscale(currentscale);
            self.angles = self.angles - (0, 1, 1);
            wait 0.016;
        }
        self rotateto(baseangles, 0.6 - self.rate / 10);
        wait 0.6 - self.rate / 10;
    }
}

// Namespace namespace_693feb87
// Params 2, eflags: 0x0
// Checksum 0x98e96db1, Offset: 0x4000
// Size: 0x62
function function_455fa2fe(localclientnum, owner) {
    if (localclientnum != 0) {
        return;
    }
    owner waittill(#"entityshutdown");
    playfx(localclientnum, level._effect["heart_explode"], self.origin);
    self delete();
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x3c0c1fb6, Offset: 0x4070
// Size: 0x109
function function_d277a961(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    switch (newval) {
    case 1:
        self.var_eba9b631 = spawn(localclientnum, self.origin, "script_model");
        self.var_eba9b631 setmodel("zombietron_heart");
        self.var_eba9b631 thread function_455fa2fe(localclientnum, self);
        self.var_eba9b631 thread function_36c61ba6(localclientnum);
        self hide();
    default:
        if (isdefined(self.var_eba9b631)) {
            self.var_eba9b631.rate = newval;
        }
        break;
    }
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0x1310a94a, Offset: 0x4188
// Size: 0x49
function delay_for_clients_then_execute(func) {
    wait 0.1;
    while (!clienthassnapshot(self.localclientnum)) {
        wait 0.016;
    }
    wait 0.1;
    self thread [[ func ]]();
}

// Namespace namespace_693feb87
// Params 3, eflags: 0x0
// Checksum 0x1ac7869b, Offset: 0x41e0
// Size: 0xf9
function function_ddbc17b4(localclientnum, var_bac17ccf, var_2ca34dda) {
    if (var_bac17ccf == 1 && getplayers(localclientnum).size == 1) {
        var_bac17ccf++;
    }
    if (var_bac17ccf == 0 && level.localplayers.size > 1) {
        var_bac17ccf++;
    }
    if (var_bac17ccf == 4 && level.localplayers.size > 1) {
        var_bac17ccf++;
    }
    if (var_bac17ccf == 4 && isdefined(level.var_e7f3233a) && level.var_e7f3233a != 1) {
        var_bac17ccf++;
    }
    if (var_bac17ccf == 3 && level.localplayers.size > 1) {
        var_bac17ccf++;
    }
    if (var_bac17ccf > 4) {
        if (level.localplayers.size > 1) {
            var_bac17ccf = 1;
        } else {
            var_bac17ccf = 0;
        }
    }
    if (var_bac17ccf == var_2ca34dda) {
        return var_2ca34dda;
    }
    InvalidOpCode(0xc1, var_bac17ccf, 1, level.var_72aa496e[level.var_6e76d849].var_dd94482c);
    // Unknown operator (0xc1, t7_1b, PC)
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x4765fec9, Offset: 0x4308
// Size: 0x16a
function changecamera(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    if (!isdefined(self.cameramode)) {
        self.cameramode = 0;
    }
    lastmode = self.cameramode;
    self.cameramode = function_ddbc17b4(localclientnum, self.cameramode + 1, self.cameramode);
    self cameraforcedisablescriptcam(0);
    if (isdefined(level.var_3fdc0d10) && level.var_3fdc0d10) {
        self.cameramode = 2;
    }
    if (self.cameramode == 4) {
        level.var_e7f3233a = 1;
        namespace_3ca3c537::function_986ae2b3(localclientnum);
    }
    if (lastmode == 4 && self.cameramode != lastmode) {
        if (isdefined(level.var_e7f3233a) && level.var_e7f3233a == 1) {
            level.var_e7f3233a = undefined;
            namespace_3ca3c537::function_986ae2b3(localclientnum);
        }
    }
    function_245e1ba2("Player " + self getentitynumber() + " camera mode changed to " + self.cameramode);
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xe4d7755d, Offset: 0x4480
// Size: 0x8a
function fixCameraOn(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayers()[0];
    if (newval) {
        level.var_3fdc0d10 = 1;
        player.cameramode = 2;
        return;
    }
    level.var_3fdc0d10 = undefined;
    player.cameramode = 0;
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x3ba5e6c5, Offset: 0x4518
// Size: 0x9a
function debugCamera(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.var_7a6087fd = newval;
    player = getlocalplayers()[0];
    if (level.var_7a6087fd == 1) {
        player function_f7c0d598("default");
        return;
    }
    player function_f7c0d598();
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x60bf745b, Offset: 0x45c0
// Size: 0x69
function debugCameraPayload(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    low = !true;
    InvalidOpCode(0xe1, 16, newval, newval);
    // Unknown operator (0xe1, t7_1b, PC)
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x4dd9bbc0, Offset: 0x4848
// Size: 0x4a
function cleanUpGibs(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    cleanupspawneddynents();
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0xe68ea51, Offset: 0x48a0
// Size: 0x2a
function function_245e1ba2(txt) {
    println("<dev string:x5d>" + txt);
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x0
// Checksum 0x7dbcb48b, Offset: 0x48d8
// Size: 0x33a
function function_12c2fbcb() {
    if (!isdefined(self.var_ec1cda64)) {
        self.var_ec1cda64 = [];
    }
    if (!isdefined(self.doa)) {
        self.entnum = self getentitynumber();
        self.doa = level.var_29e6f519[self.entnum];
        if (isdefined(self.doa.player)) {
            function_245e1ba2("DOA struct already has a player: " + (isdefined(self.name) ? self.name : "Unk") + " DOA struct assigned to " + (isdefined(self.doa.player) ? self.doa.player.name : "Nobody") + " My Ent #" + self getentitynumber() + " Owner Ent #" + (isdefined(self.doa.player) ? self.doa.player getentitynumber() : -1));
            assert(self.doa.player == self);
        }
        namespace_64c6b720::function_e06716c7(self.doa);
        self.doa.player = self;
        function_245e1ba2("DOA struct assigned: " + (isdefined(self.name) ? self.name : "Unk") + " My Ent #" + self.entnum + " Owner Ent #" + (isdefined(self.doa.player) ? self.doa.player getentitynumber() : -1));
        self cameraforcedisablescriptcam(0);
        self camerasetupdatecallback(&namespace_ad544aeb::function_d207ecc1);
        setfriendlynamedraw(0);
        if (self islocalplayer()) {
            self.cameramode = namespace_3ca3c537::function_9f1a0b26(0);
        }
        if (self islocalplayer()) {
            localclientnum = self getlocalclientnumber();
            switch (self.entnum) {
            case 0:
                self setcontrollerlightbarcolor(localclientnum, (0, 1, 0));
                break;
            case 1:
                self setcontrollerlightbarcolor(localclientnum, (0, 0, 1));
                break;
            case 2:
                self setcontrollerlightbarcolor(localclientnum, (1, 0, 0));
                break;
            case 3:
                self setcontrollerlightbarcolor(localclientnum, (1, 1, 0));
                break;
            }
        }
    }
    self thread function_f7c0d598();
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0x9d2f7a18, Offset: 0x4c20
// Size: 0x366
function function_c33d3992(localclientnum) {
    if (!clienthassnapshot(localclientnum)) {
        function_245e1ba2("player_IsReady failure: " + (isdefined(self.name) ? self.name : "Unk") + " Reason: No Client Snap");
        return false;
    }
    if (!self isplayer()) {
        function_245e1ba2("player_IsReady failure: " + (isdefined(self.name) ? self.name : "Unk") + " Reason: Not a player");
        return false;
    }
    if (!self hasdobj(localclientnum)) {
        function_245e1ba2("player_IsReady failure: " + (isdefined(self.name) ? self.name : "Unk") + " Reason: No DOBJ");
        return false;
    }
    if (self islocalplayer() && !isdefined(self getlocalclientnumber())) {
        function_245e1ba2("player_IsReady failure: " + (isdefined(self.name) ? self.name : "Unk") + " Reason: No local client number");
        return false;
    }
    if (isspectating(localclientnum)) {
        function_245e1ba2("player_IsReady failure: " + (isdefined(self.name) ? self.name : "Unk") + " Reason: Is spectating");
        return false;
    }
    if (isdemoplaying()) {
        function_245e1ba2("player_IsReady failure: " + (isdefined(self.name) ? self.name : "Unk") + " Reason: Demo is playing");
        return false;
    }
    if (self islocalplayer() && isdefined(self getlocalclientnumber())) {
        spectated = playerbeingspectated(self getlocalclientnumber());
        if (self != spectated) {
            function_245e1ba2("player_IsReady failure: " + (isdefined(self.name) ? self.name : "Unk") + " Reason: self != spectated");
            return false;
        }
    }
    doa = level.var_29e6f519[self getentitynumber()];
    if (isdefined(doa.player) && doa.player != self) {
        function_245e1ba2("player_IsReady failure: " + (isdefined(self.name) ? self.name : "Unk") + " Reason: DOA struct assigned to " + doa.player.name + " My Ent #" + self getentitynumber() + " Other Ent #" + doa.player getentitynumber());
        return false;
    }
    return true;
}

