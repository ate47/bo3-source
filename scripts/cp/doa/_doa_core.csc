#using scripts/shared/exploder_shared;
#using scripts/shared/ai/zombie_vortex;
#using scripts/shared/ai/systems/gib;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_camera;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_core;
#using scripts/cp/cp_doa_bo3_sound;
#using scripts/cp/cp_doa_bo3_fx;
#using scripts/cp/_util;
#using scripts/shared/blood;
#using scripts/shared/math_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/player_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_693feb87;

// Namespace namespace_693feb87
// Params 0, eflags: 0x0
// Checksum 0x2a62e304, Offset: 0xa28
// Size: 0x144c
function main() {
    level.doa = spawnstruct();
    callback::on_spawned(&on_player_spawned);
    namespace_3ca3c537::init();
    namespace_eaa992c::init();
    namespace_1a381543::init();
    namespace_64c6b720::init();
    namespace_ad544aeb::function_d22ceb57((75, 0, 0), 600);
    namespace_a7e6beb5::init();
    level.doa.var_160ae6c6 = 1;
    level.doa.roundnumber = 1;
    level.doa.flipped = 0;
    level.doa.var_7817fe3c = [];
    level.disablewatersurfacefx = 1;
    level.gibresettime = 0.5;
    level.gibmaxcount = 3;
    level.gibtimer = 0;
    level.gibcount = 0;
    level.var_ff8aba3b = (0, 0, 4);
    level.var_96344b03 = 3;
    level.var_46418da4 = 2;
    level.var_bd436f37 = 0.5;
    level.var_e3119165 = array("zombietron_gib_chunk_fat", "zombietron_gib_chunk_bone_01", "zombietron_gib_chunk_bone_02", "zombietron_gib_chunk_bone_03", "zombietron_gib_chunk_flesh_01", "zombietron_gib_chunk_flesh_02", "zombietron_gib_chunk_flesh_03", "zombietron_gib_chunk_meat_01", "zombietron_gib_chunk_meat_02", "zombietron_gib_chunk_meat_03");
    clientfield::register("world", "podiumEvent", 1, 1, "int", &function_10093dd7, 0, 0);
    clientfield::register("world", "overworld", 1, 1, "int", &function_a6c926fc, 0, 0);
    clientfield::register("world", "scoreMenu", 1, 1, "int", &function_d3b4c89d, 0, 0);
    clientfield::register("world", "overworldlevel", 1, 5, "int", &function_22de3f7, 0, 0);
    clientfield::register("world", "roundnumber", 1, 10, "int", &function_e3bb35e, 0, 0);
    clientfield::register("world", "roundMenu", 1, 1, "int", &function_2eaf8a3f, 0, 0);
    clientfield::register("world", "teleportMenu", 1, 1, "int", &function_c97b97ae, 0, 0);
    clientfield::register("world", "numexits", 1, 3, "int", &function_c86d63f6, 0, 0);
    clientfield::register("world", "gameover", 1, 1, "int", &function_91976e37, 0, 0);
    clientfield::register("world", "doafps", 1, 1, "int", &function_e63081e8, 0, 0);
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
    clientfield::register("toplayer", "goFPS", 1, 1, "counter", &function_ca593121, 0, 0);
    clientfield::register("toplayer", "exitFPS", 1, 1, "counter", &function_9e1eca0b, 0, 0);
    clientfield::register("world", "cleanUpGibs", 1, 1, "counter", &function_efeeaa92, 0, 0);
    clientfield::register("world", "killweather", 1, 1, "counter", &namespace_3ca3c537::function_22f2039b, 0, 0);
    clientfield::register("world", "killfog", 1, 1, "counter", &namespace_3ca3c537::function_9977953, 0, 0);
    clientfield::register("world", "flipCamera", 1, 2, "int", &namespace_3ca3c537::flipcamera, 0, 0);
    clientfield::register("world", "arenaUpdate", 1, 8, "int", &namespace_3ca3c537::setarena, 0, 0);
    clientfield::register("world", "arenaRound", 1, 3, "int", &namespace_3ca3c537::function_836d1e22, 0, 0);
    clientfield::register("actor", "enemy_ragdoll_explode", 1, 1, "int", &zombie_ragdoll_explode_cb, 0, 0);
    clientfield::register("actor", "zombie_gut_explosion", 1, 1, "int", &zombie_gut_explosion_cb, 0, 0);
    clientfield::register("actor", "zombie_chunk", 1, 1, "counter", &function_3a1ccea7, 0, 0);
    clientfield::register("actor", "zombie_saw_explosion", 1, 1, "int", &function_15b503eb, 0, 0);
    clientfield::register("actor", "zombie_rhino_explosion", 1, 1, "int", &function_8b8f5cb4, 0, 0);
    clientfield::register("world", "restart_doa", 1, 1, "counter", &function_4ac9a8ba, 0, 0);
    clientfield::register("scriptmover", "hazard_type", 1, 4, "int", &function_20671f0, 0, 0);
    clientfield::register("scriptmover", "hazard_activated", 1, 4, "int", &function_ec2caec3, 0, 0);
    clientfield::register("actor", "zombie_riser_fx", 1, 1, "int", &handle_zombie_risers, 0, 0);
    clientfield::register("actor", "zombie_bloodriser_fx", 1, 1, "int", &function_cb806a9b, 0, 0);
    clientfield::register("scriptmover", "heartbeat", 1, 3, "int", &function_d277a961, 0, 0);
    clientfield::register("actor", "burnType", 1, 2, "int", &namespace_eaa992c::function_7aac5112, 0, 0);
    clientfield::register("actor", "burnZombie", 1, 1, "counter", &namespace_eaa992c::function_f6008bb4, 0, 0);
    clientfield::register("actor", "burnCorpse", 1, 1, "counter", &namespace_eaa992c::burncorpse, 0, 0);
    clientfield::register("toplayer", "changeCamera", 1, 1, "counter", &changecamera, 0, 0);
    clientfield::register("actor", "zombie_has_eyes", 1, 1, "int", &namespace_eaa992c::zombie_eyes_clientfield_cb, 0, 0);
    clientfield::register("world", "cameraHeight", 1, 3, "int", &function_b868b40f, 0, 0);
    clientfield::register("world", "cleanupGiblets", 1, 1, "int", &function_23f655ed, 0, 0);
    clientfield::register("scriptmover", "camera_focus_item", 1, 1, "int", &function_354ec425, 0, 0);
    clientfield::register("actor", "camera_focus_item", 1, 1, "int", &function_354ec425, 0, 0);
    clientfield::register("vehicle", "camera_focus_item", 1, 1, "int", &function_354ec425, 0, 0);
    callback::on_spawned(&on_player_spawn);
    callback::on_shutdown(&on_player_shutdown);
    callback::on_localclient_connect(&player_on_connect);
    /#
        clientfield::register("flipCamera", "zombie_saw_explosion", 1, 1, "zombie_has_eyes", &function_bbb7743c, 0, 0);
        clientfield::register("flipCamera", "dynEnt_spawnedLimit", 1, 2, "zombie_has_eyes", &function_cee29ae7, 0, 0);
        clientfield::register("flipCamera", "script_model", 1, 30, "zombie_has_eyes", &function_cd844947, 0, 0);
        level.var_83a34f19 = 0;
        level.var_e9c73e06 = 0;
        level.var_7a6087fd = 0;
    #/
    setdvar("dynEnt_spawnedLimit", 400);
    setdvar("cg_disableearthquake", 1);
    setdvar("scr_use_digital_blood_enabled", 0);
    setdvar("ik_enable_ai_terrain", 0);
    setdvar("r_newLensFlares", 0);
    level thread function_ae0a4fc5();
    level thread function_d5eb029a();
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0x7de001f4, Offset: 0x1e80
// Size: 0x84
function on_player_spawned(localclientnum) {
    recacheleaderboards(localclientnum);
    if (self islocalplayer() && localclientnum > 0) {
        allowscoreboard(localclientnum, 0);
    }
    level notify(#"hash_a2a24535");
    level thread function_5c2a88d5();
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x0
// Checksum 0x6be79366, Offset: 0x1f10
// Size: 0x3a4
function function_d5eb029a() {
    level notify(#"hash_d5eb029a");
    level endon(#"hash_d5eb029a");
    while (true) {
        playernum, newstate = level waittill(#"hash_aae01d5a");
        players = getplayers(0);
        foreach (player in players) {
            if (!isdefined(player.entnum)) {
                player.entnum = player getentitynumber();
            }
            if (playernum != player.entnum) {
                continue;
            }
            if (!isdefined(player.var_4abf708a)) {
                player.var_4abf708a = [];
                for (localclientnum = 0; localclientnum < 2; localclientnum++) {
                    player.var_4abf708a[localclientnum] = 0;
                }
            }
            var_36ffb352 = "player_trail_" + function_ee495f41(player.entnum);
            for (localclientnum = 0; localclientnum < 2; localclientnum++) {
                if (localclientnum >= getlocalplayers().size) {
                    continue;
                }
                if (isdefined(player.var_4abf708a[localclientnum]) && player.var_4abf708a[localclientnum] != 0) {
                    killfx(localclientnum, player.var_4abf708a[localclientnum]);
                    player.var_4abf708a[localclientnum] = 0;
                }
            }
            player.var_8064cb04 = newstate;
            switch (player.var_8064cb04) {
            case 0:
                break;
            case 1:
            case 2:
                for (localclientnum = 0; localclientnum < 2; localclientnum++) {
                    if (localclientnum >= getlocalplayers().size) {
                        continue;
                    }
                    if (!player hasdobj(localclientnum)) {
                        player.var_8064cb04 = 0;
                        continue;
                    }
                    player.var_4abf708a[localclientnum] = playfxontag(localclientnum, level._effect[var_36ffb352], player, "tag_origin");
                }
                break;
            default:
                /#
                    assert(0);
                #/
                break;
            }
        }
    }
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x0
// Checksum 0xb479b90e, Offset: 0x22c0
// Size: 0x260
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
            doa = level.var_29e6f519[player getentitynumber()];
            if (!isdefined(doa)) {
                continue;
            }
            if (isdefined(doa.player) && doa.player != player) {
                /#
                    debugmsg("fury_boost" + player.name + "vr_eyeScale" + doa.player.name + "<unknown string>" + player getentitynumber() + "<unknown string>" + doa.player getentitynumber());
                #/
                continue;
            }
            player function_12c2fbcb();
        }
        wait(0.016);
    }
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0x1058e50d, Offset: 0x2528
// Size: 0x3c
function player_on_connect(localclientnum) {
    disablespeedblur(localclientnum);
    self blood::function_14cd2c76(localclientnum);
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0x80cd2be9, Offset: 0x2570
// Size: 0x38
function on_player_spawn(localclientnum) {
    self.entnum = self getentitynumber();
    self.nobloodlightbarchange = 1;
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0xab473d9f, Offset: 0x25b0
// Size: 0xdc
function on_player_shutdown(localclientnum) {
    for (localclientnum = 0; localclientnum < 2; localclientnum++) {
        if (localclientnum >= getlocalplayers().size) {
            continue;
        }
        if (isdefined(self.var_4abf708a[localclientnum]) && self.var_4abf708a[localclientnum] != 0) {
            killfx(localclientnum, self.var_4abf708a[localclientnum]);
            self.var_4abf708a[localclientnum] = 0;
        }
    }
    if (self islocalplayer()) {
        self setcontrollerlightbarcolor(localclientnum);
    }
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0x69337cf5, Offset: 0x2698
// Size: 0x4c
function function_fc05827f(localclientnum) {
    self endon(#"disconnect");
    wait(0.5);
    disablespeedblur(localclientnum);
    self blood::function_14cd2c76(localclientnum);
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x70aaf276, Offset: 0x26f0
// Size: 0xfc
function function_2eaf8a3f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    /#
        debugmsg("<unknown string>" + newval + "<unknown string>" + level.doa.roundnumber);
    #/
    if (newval) {
        setuimodelvalue(getuimodel(level.var_7e2a814c, "round"), level.doa.roundnumber);
        return;
    }
    setuimodelvalue(getuimodel(level.var_7e2a814c, "round"), 0);
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x20f3127, Offset: 0x27f8
// Size: 0x74
function function_c97b97ae(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setuimodelvalue(getuimodel(level.var_7e2a814c, "teleporter"), newval);
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x7762234, Offset: 0x2878
// Size: 0x84
function function_e3bb35e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.doa.roundnumber = newval;
    /#
        debugmsg("<unknown string>" + level.doa.roundnumber);
    #/
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x4bbd897d, Offset: 0x2908
// Size: 0x9c
function function_c86d63f6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setuimodelvalue(getuimodel(level.var_7e2a814c, "numexits"), newval);
    /#
        debugmsg("<unknown string>" + newval);
    #/
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x35373392, Offset: 0x29b0
// Size: 0xc4
function function_91976e37(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setuimodelvalue(getuimodel(level.var_7e2a814c, "gameover"), newval > 0 ? level.doa.roundnumber : 0);
    /#
        debugmsg("<unknown string>" + level.doa.roundnumber);
    #/
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x5e03639e, Offset: 0x2a80
// Size: 0x258
function function_e63081e8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setuimodelvalue(getuimodel(level.var_7e2a814c, "doafps"), newval);
    /#
        debugmsg("<unknown string>" + newval);
    #/
    if (newval) {
        if (newval && getlocalplayers().size > 1) {
            setdvar("r_splitScreenExpandFull", 0);
        }
        if (isdefined(level.doa.var_6e0195ea)) {
            stopradiantexploder(localclientnum, level.doa.var_6e0195ea);
            level.doa.var_6e0195ea = undefined;
        }
        level.doa.var_6e0195ea = "fx_exploder_" + level.doa.arenas[level.doa.var_90873830].name + "_FPS";
        /#
            debugmsg("<unknown string>" + level.doa.var_6e0195ea + "<unknown string>" + localclientnum);
        #/
        playradiantexploder(localclientnum, level.doa.var_6e0195ea);
    } else {
        setdvar("r_splitScreenExpandFull", 1);
        if (isdefined(level.doa.var_6e0195ea)) {
            stopradiantexploder(localclientnum, level.doa.var_6e0195ea);
            level.doa.var_6e0195ea = undefined;
        }
    }
    level.doa.var_2836c8ee = newval;
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xf1e317c5, Offset: 0x2ce0
// Size: 0xfe
function function_9e1eca0b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_4f118af8)) {
        self.cameramode = self.var_4f118af8;
        self.var_4f118af8 = undefined;
    }
    if (isdefined(self.var_bf81deea) && self.var_bf81deea && self islocalplayer()) {
        self.var_bf81deea = undefined;
        level.var_6383030e = self.origin + (0, 0, 72);
        self cameraforcedisablescriptcam(0);
    }
    if (isdefined(self.var_a28838ac)) {
        killfx(localclientnum, self.var_a28838ac);
        self.var_a28838ac = undefined;
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xe7681c29, Offset: 0x2de8
// Size: 0x2ec
function function_ca593121(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!(isdefined(self.var_bf81deea) && self.var_bf81deea) && !isdefined(level.doa.var_db180da)) {
        if (!isdefined(level.var_6383030e)) {
            level.var_6383030e = self.origin;
        }
        level.doa.var_db180da = spawn(localclientnum, level.var_6383030e, "script_model");
        level.doa.var_db180da setmodel("tag_origin");
        level.doa.var_db180da moveto(self.origin + (0, 0, 72), 0.15);
        wait(0.1);
        playfx(localclientnum, level._effect["bomb"], self.origin);
        level.doa.var_db180da util::waittill_any_timeout(0.1, "movedone");
        playfx(localclientnum, level._effect["turret_impact"], self.origin);
        self earthquake(1, 0.8, self.origin, 1000);
        playrumbleonposition(localclientnum, "damage_heavy", self.origin);
        wait(0.1);
        if (isdefined(level.doa.var_db180da)) {
            level.doa.var_db180da delete();
            level.doa.var_db180da = undefined;
        }
    }
    if (!isdefined(self.var_4f118af8)) {
        self.var_4f118af8 = self.cameramode;
    }
    if (!(isdefined(self.var_bf81deea) && self.var_bf81deea) && self islocalplayer()) {
        self cameraforcedisablescriptcam(1);
        self.var_bf81deea = 1;
    }
    self thread function_f7c0d598("zombietron_fps");
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xf8b32bc9, Offset: 0x30e0
// Size: 0x94
function function_22de3f7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.doa.var_160ae6c6 = newval;
    setuimodelvalue(getuimodel(level.var_7e2a814c, "level"), level.doa.var_160ae6c6);
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xa8ee6e15, Offset: 0x3180
// Size: 0xc4
function function_d3b4c89d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    player = getlocalplayer(localclientnum);
    if (!isdefined(player)) {
        return;
    }
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "forceScoreboard"), newval);
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x119072e1, Offset: 0x3250
// Size: 0x1da
function function_a6c926fc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    player = getlocalplayer(localclientnum);
    if (!isdefined(player)) {
        return;
    }
    if (newval) {
        setuimodelvalue(getuimodel(level.var_7e2a814c, "level"), level.doa.var_160ae6c6);
        setuimodelvalue(createuimodel(level.var_7e2a814c, "changingLevel"), 1);
        if (!isdefined(player.var_336bed9c)) {
            player.var_336bed9c = createluimenu(localclientnum, "DOA_overworld");
        }
        openluimenu(localclientnum, player.var_336bed9c);
        return;
    }
    if (isdefined(player.var_336bed9c)) {
        setuimodelvalue(createuimodel(level.var_7e2a814c, "changingLevel"), 0);
        closeluimenu(localclientnum, player.var_336bed9c);
        player.var_336bed9c = undefined;
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xda31140a, Offset: 0x3438
// Size: 0x1fe
function function_10093dd7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.var_c065e9ed) && isdefined(level.var_c065e9ed[localclientnum])) {
        stopfx(localclientnum, level.var_c065e9ed[localclientnum]);
        level.var_c065e9ed[localclientnum] = 0;
    }
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
// Checksum 0x7604c9e1, Offset: 0x3640
// Size: 0x114
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
// Checksum 0x2f02471d, Offset: 0x3760
// Size: 0x4c
function function_23f655ed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    cleanupspawneddynents();
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0x83ecb617, Offset: 0x37b8
// Size: 0x82
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
        /#
            assert(0);
        #/
        break;
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xdb931c25, Offset: 0x3848
// Size: 0xf4
function function_351aa01c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
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
// Checksum 0x3911602b, Offset: 0x3948
// Size: 0x7c
function function_33760903(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval != 0) {
        self thread namespace_eaa992c::function_e68e3c0d(localclientnum, namespace_eaa992c::function_9e6fe7c3(newval), 1);
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xd357c448, Offset: 0x39d0
// Size: 0x74
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
// Checksum 0x566cc620, Offset: 0x3a50
// Size: 0x74
function function_9bf26aa6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (localclientnum != 0) {
        return;
    }
    if (newval != 0) {
        self namespace_1a381543::function_1f085aea(localclientnum, newval, 1);
    }
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x0
// Checksum 0xc9d87e0e, Offset: 0x3ad0
// Size: 0x9e
function onground() {
    a_trace = bullettrace(self.origin, self.origin + (0, 0, -5000), 0, self, 1);
    v_ground = a_trace["position"];
    distance_squared = distancesquared(self.origin, v_ground);
    if (distance_squared > 576) {
        return false;
    }
    return true;
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0xadf4c6c5, Offset: 0x3b78
// Size: 0x29c
function function_10477d98(localclientnum) {
    self notify(#"hash_f33fde4b");
    self endon(#"disconnect");
    self endon(#"hash_7f60c43e");
    self endon(#"entityshutdown");
    endtime = gettime() + 600;
    self playsound(0, "zmb_fated_boost_activate");
    lastposition = self.origin;
    stepsize = 20;
    while (gettime() < endtime) {
        if (self onground()) {
            wait(0.2);
            if (!(isdefined(level.doa.var_2836c8ee) && level.doa.var_2836c8ee) && localclientnum != 0) {
                continue;
            }
            normal = vectornormalize(self.origin - lastposition);
            step = normal * stepsize;
            dist = distance(self.origin, lastposition);
            if (dist < 10) {
                continue;
            }
            steps = int(dist / stepsize + 0.5);
            for (i = 0; i < steps; i++) {
                playfx(localclientnum, level._effect["fury_boost"], lastposition, anglestoforward(self.angles), (0, 0, 1));
                playfx(localclientnum, level._effect["fury_patch"], lastposition, anglestoforward(self.angles), (0, 0, 1));
                lastposition += step;
            }
            lastposition = self.origin;
            continue;
        }
        wait(0.5);
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x56d308f3, Offset: 0x3e20
// Size: 0x84
function function_b868b40f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        level.doa.var_708cc739 = undefined;
    } else {
        level.doa.var_708cc739 = newval;
    }
    namespace_3ca3c537::function_986ae2b3(localclientnum);
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xfb65da9e, Offset: 0x3eb0
// Size: 0xce
function function_409fa9ce(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    /#
        debugmsg("<unknown string>" + (isdefined(self.name) ? self.name : "<unknown string>") + "<unknown string>" + newval + "<unknown string>" + localclientnum);
    #/
    if (newval) {
        self thread function_10477d98(localclientnum);
        return;
    }
    self notify(#"hash_f33fde4b");
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x9ca31bb8, Offset: 0x3f88
// Size: 0x166
function function_cb806a9b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
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
// Checksum 0xe96738ff, Offset: 0x40f8
// Size: 0x166
function handle_zombie_risers(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
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
// Checksum 0x2c9c2d23, Offset: 0x4268
// Size: 0x1d6
function rise_dust_fx(localclientnum, type, billow_fx, burst_fx, var_cf929ddb) {
    dust_tag = "J_SpineUpper";
    self endon(#"entityshutdown");
    if (isdefined(burst_fx)) {
        playfx(localclientnum, burst_fx, self.origin + (0, 0, randomintrange(5, 10)));
    }
    wait(0.25);
    if (isdefined(billow_fx)) {
        playfx(localclientnum, billow_fx, self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
    }
    wait(2);
    dust_time = 5.5;
    dust_interval = 0.3;
    self util::waittill_dobj(localclientnum);
    for (t = 0; t < dust_time; t += dust_interval) {
        if (self hasdobj(localclientnum)) {
            playfxontag(localclientnum, var_cf929ddb, self, dust_tag);
        }
        wait(dust_interval);
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x25787f13, Offset: 0x4448
// Size: 0xac
function function_20671f0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.doa.var_7817fe3c[level.doa.var_7817fe3c.size] = self;
    arrayremovevalue(level.doa.var_7817fe3c, undefined);
    self.var_d05d7e08 = newval;
    self thread function_38452435(localclientnum);
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xc1efda95, Offset: 0x4500
// Size: 0xde
function function_ec2caec3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_d05d7e08)) {
        self.var_d05d7e08 = 0;
    }
    switch (self.var_d05d7e08) {
    case 3:
        self.activefx = level._effect["electric_trap2"];
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
// Checksum 0x129cf718, Offset: 0x45e8
// Size: 0x9e
function private function_38452435(localclientnum) {
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
// Params 0, eflags: 0x0
// Checksum 0x2559169c, Offset: 0x4690
// Size: 0x18c
function function_b54615b2() {
    arrayremovevalue(level.doa.var_7817fe3c, undefined);
    foreach (hazard in level.doa.var_7817fe3c) {
        if (!isdefined(hazard)) {
            continue;
        }
        if (hazard == self) {
            continue;
        }
        if (hazard.var_d05d7e08 != self.var_d05d7e08) {
            continue;
        }
        distsq = distancesquared(hazard.origin, self.origin);
        if (distsq < 72 * 72) {
            if (isdefined(hazard.activefx) && hazard.activefx == level._effect["electric_trap"]) {
                return level._effect["electric_trap2"];
            }
        }
    }
    self.var_5ad223cf = 1;
    return level._effect["electric_trap"];
}

// Namespace namespace_693feb87
// Params 2, eflags: 0x0
// Checksum 0x593bc8a, Offset: 0x4828
// Size: 0x386
function function_e41e6611(localclientnum, value) {
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
        if (!isdefined(self.activefx)) {
            self.activefx = self function_b54615b2();
        }
        /#
            if (isdefined(self.var_5ad223cf) && self.var_5ad223cf) {
                level thread drawcylinder(self.origin, 40, 20, -76, (0, 0, 1));
            }
        #/
        self.fx = playfx(localclientnum, self.activefx, self.origin + (0, 0, 100));
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
// Checksum 0x249c1fd5, Offset: 0x4bb8
// Size: 0x156
function function_d8d20160(localclientnum, value) {
    self util::waittill_dobj(localclientnum);
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
// Checksum 0xaa61f8f5, Offset: 0x4d18
// Size: 0x1fc
function function_4ac9a8ba(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    namespace_3ca3c537::restart();
    namespace_64c6b720::function_6fa6dee2();
    namespace_ad544aeb::function_d22ceb57((75, 0, 0), 600);
    cleanupspawneddynents();
    level.doa.var_7817fe3c = [];
    level.doa.roundnumber = 1;
    level.doa.var_160ae6c6 = 1;
    setuimodelvalue(getuimodel(level.var_7e2a814c, "level"), level.doa.var_160ae6c6);
    foreach (player in getplayers(0)) {
        player.doa = undefined;
        player thread function_12c2fbcb();
    }
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "forceScoreboard"), 0);
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0xbecb4713, Offset: 0x4f20
// Size: 0x174
function function_f7c0d598(mapping) {
    if (!isdefined(mapping)) {
        mapping = "zombietron";
    }
    self notify(#"hash_f7c0d598");
    self endon(#"hash_f7c0d598");
    self endon(#"entityshutdown");
    self endon(#"disconnect");
    /#
        debugmsg("<unknown string>" + (isdefined(self.name) ? self.name : "<unknown string>") + "<unknown string>" + mapping + "<unknown string>" + (self islocalplayer() ? "<unknown string>" : "<unknown string>"));
    #/
    if (self islocalplayer()) {
        clientnum = self getlocalclientnumber();
        /#
            debugmsg("<unknown string>" + clientnum);
        #/
        forcegamemodemappings(clientnum, mapping);
        return;
    }
    /#
        debugmsg("<unknown string>");
    #/
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xb1004401, Offset: 0x50a0
// Size: 0x54
function function_f8c69ca4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread function_f7c0d598();
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xfd8b0b9e, Offset: 0x5100
// Size: 0x2f4
function function_f87ff72d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        return;
    }
    if (isdefined(level.doa.var_2836c8ee) && level.doa.var_2836c8ee) {
        forward = anglestoforward(self.angles);
        var_ec8a4984 = self.origin + forward * 100;
    } else {
        var_ec8a4984 = self.origin;
    }
    origin = var_ec8a4984 + (20, 0, 2000);
    bomb = spawn(localclientnum, origin, "script_model");
    bomb setmodel("zombietron_nuke");
    bomb.angles = (90, 0, 0);
    bomb moveto(var_ec8a4984, 0.3, 0, 0);
    playsound(0, "zmb_nuke_incoming", self.origin);
    bomb waittill(#"movedone");
    playsound(localclientnum, "zmb_nuke_impact", var_ec8a4984);
    playfx(localclientnum, level._effect["bomb"], var_ec8a4984);
    foreach (player in getlocalplayers()) {
        player earthquake(1, 0.8, var_ec8a4984, 1000);
    }
    bomb delete();
    wait(0.2);
    playfx(localclientnum, level._effect["nuke_dust"], var_ec8a4984);
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0x46fb018, Offset: 0x5400
// Size: 0x9c
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
// Checksum 0xd360e022, Offset: 0x54a8
// Size: 0x1ce
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
// Checksum 0xbb14733c, Offset: 0x5680
// Size: 0xf4
function function_3a1ccea7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
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
// Checksum 0x59d91203, Offset: 0x5780
// Size: 0xfc
function zombie_gut_explosion_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
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
// Checksum 0xd72082aa, Offset: 0x5888
// Size: 0xfc
function function_15b503eb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
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
// Checksum 0x86d49e12, Offset: 0x5990
// Size: 0x104
function function_8b8f5cb4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
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
// Checksum 0xc077ee8f, Offset: 0x5aa0
// Size: 0x5c
function zombie_ragdoll_explode_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self zombie_wait_explode(localclientnum);
    }
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0xa607ae7a, Offset: 0x5b08
// Size: 0x114
function zombie_wait_explode(localclientnum) {
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
        wait(0.05);
    }
    if (isdefined(level._effect["zombie_guts_explosion"]) && util::is_mature()) {
        playfx(localclientnum, level._effect["zombie_guts_explosion"], where);
    }
}

// Namespace namespace_693feb87
// Params 3, eflags: 0x0
// Checksum 0x4197386, Offset: 0x5c28
// Size: 0x288
function function_36c61ba6(localclientnum, var_4faf5231, var_ad5de66e) {
    if (!isdefined(var_4faf5231)) {
        var_4faf5231 = 1;
    }
    if (!isdefined(var_ad5de66e)) {
        var_ad5de66e = 1;
    }
    self endon(#"entityshutdown");
    currentscale = var_ad5de66e;
    targetscale = var_ad5de66e * 1.25;
    var_711842d8 = 0.002;
    var_fa7c415 = 0.002;
    var_ba7af42 = var_711842d8;
    baseangles = self.angles;
    self.rate = 1;
    while (isdefined(self)) {
        var_ba7af42 = var_711842d8;
        while (currentscale < targetscale) {
            currentscale += var_ba7af42;
            var_ba7af42 += var_fa7c415 * self.rate;
            if (currentscale > targetscale) {
                currentscale = targetscale;
            }
            self setscale(currentscale);
            if (var_4faf5231) {
                self.angles += (0, 1, 1);
            }
            wait(0.016);
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
            if (var_4faf5231) {
                self.angles -= (0, 1, 1);
            }
            wait(0.016);
        }
        self rotateto(baseangles, 0.6 - self.rate / 10);
        wait(0.6 - self.rate / 10);
    }
}

// Namespace namespace_693feb87
// Params 3, eflags: 0x0
// Checksum 0x2d8f58c6, Offset: 0x5eb8
// Size: 0x6c
function function_455fa2fe(localclientnum, owner, fx) {
    owner waittill(#"entityshutdown");
    playfx(localclientnum, level._effect[fx], self.origin);
    self delete();
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xa9de01df, Offset: 0x5f30
// Size: 0x246
function function_d277a961(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 1:
        self.var_eba9b631 = spawn(localclientnum, self.origin, "script_model");
        self.var_eba9b631 setmodel("zombietron_heart");
        self.var_eba9b631 thread function_455fa2fe(localclientnum, self, "heart_explode");
        self.var_eba9b631 thread function_36c61ba6(localclientnum);
        self.var_eba9b631.rate = newval;
        self hide();
    case 2:
    case 3:
    case 4:
    case 5:
        if (isdefined(self.var_eba9b631)) {
            self.var_eba9b631.rate = newval;
        }
        break;
    case 6:
        self.var_eba9b631 = spawn(localclientnum, self.origin, "script_model");
        if (isdefined(self.var_eba9b631)) {
            self.var_eba9b631 setmodel("zombietron_spider_egg");
            self.var_eba9b631 setscale(0.5);
            self.var_eba9b631 thread function_455fa2fe(localclientnum, self, "egg_explode");
        }
        break;
    case 7:
        if (isdefined(self.var_eba9b631)) {
            self.var_eba9b631 thread function_36c61ba6(localclientnum, 0, 0.5);
        }
        break;
    }
}

// Namespace namespace_693feb87
// Params 1, eflags: 0x0
// Checksum 0xa71f10d3, Offset: 0x6180
// Size: 0x52
function delay_for_clients_then_execute(func) {
    wait(0.1);
    while (!clienthassnapshot(self.localclientnum)) {
        wait(0.016);
    }
    wait(0.1);
    self thread [[ func ]]();
}

// Namespace namespace_693feb87
// Params 3, eflags: 0x0
// Checksum 0xf6d85c9d, Offset: 0x61e0
// Size: 0x152
function function_ddbc17b4(localclientnum, var_bac17ccf, var_2ca34dda) {
    if (var_bac17ccf == 1 && getplayers(localclientnum).size == level.localplayers.size) {
        var_bac17ccf++;
    }
    if (var_bac17ccf == 4 && isdefined(level.doa.var_708cc739) && level.doa.var_708cc739 != 1) {
        var_bac17ccf++;
    }
    if (var_bac17ccf == 3 && level.localplayers.size > 1) {
        var_bac17ccf++;
    }
    if (var_bac17ccf > 4) {
        var_bac17ccf = 0;
    }
    if (var_bac17ccf == var_2ca34dda) {
        return var_2ca34dda;
    }
    if (level.doa.arenas[level.doa.var_90873830].var_dd94482c & 1 << var_bac17ccf) {
        return var_bac17ccf;
    }
    return function_ddbc17b4(localclientnum, var_bac17ccf + 1, var_2ca34dda);
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0x58366a3d, Offset: 0x6340
// Size: 0x294
function changecamera(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (localclientnum != 0) {
        return;
    }
    enablevr();
    setdvar("g_vrGameMode", 2);
    setdvar("cg_disableearthquake", 1);
    setdvar("vr_eyeScale", 0.3);
    if (!isdefined(self.cameramode)) {
        self.cameramode = 0;
    }
    lastmode = self.cameramode;
    self.cameramode = function_ddbc17b4(localclientnum, self.cameramode + 1, self.cameramode);
    if (isdefined(self.var_4f118af8)) {
        self.cameramode = self.var_4f118af8;
    }
    self cameraforcedisablescriptcam(0);
    if (isdefined(level.doa.var_20e9a021) && level.doa.var_20e9a021) {
        self.cameramode = 2;
    }
    if (self.cameramode == 4) {
        level.doa.var_708cc739 = 1;
        namespace_3ca3c537::function_986ae2b3(localclientnum);
    }
    if (self.cameramode == 3) {
        self cameraforcedisablescriptcam(1);
    }
    if (lastmode == 4 && self.cameramode != lastmode) {
        if (isdefined(level.doa.var_708cc739) && level.doa.var_708cc739 == 1) {
            level.doa.var_708cc739 = undefined;
            namespace_3ca3c537::function_986ae2b3(localclientnum);
        }
    }
    /#
        debugmsg("<unknown string>" + self getentitynumber() + "<unknown string>" + self.cameramode);
    #/
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xbefb77a3, Offset: 0x65e0
// Size: 0xb8
function function_bbb7743c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayers()[0];
    if (newval) {
        level.doa.var_20e9a021 = 1;
        player.cameramode = 2;
        return;
    }
    level.doa.var_20e9a021 = undefined;
    player.cameramode = 0;
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xbe0e84ae, Offset: 0x66a0
// Size: 0xb4
function function_cee29ae7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
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
// Checksum 0x5b01a10e, Offset: 0x6760
// Size: 0x414
function function_cd844947(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    low = newval & 65535;
    high = newval >> 16;
    forward = anglestoforward(level.var_a32fbbc0);
    right = anglestoright(level.var_a32fbbc0);
    level.var_191c8154 = (0, 0, 0);
    if (low & 1) {
        level.doa.arenas[level.doa.var_90873830].var_7526f3f5 = level.doa.arenas[level.doa.var_90873830].var_7526f3f5 + (0, 0, 10);
    }
    if (high & 1) {
        level.doa.arenas[level.doa.var_90873830].var_7526f3f5 = level.doa.arenas[level.doa.var_90873830].var_7526f3f5 - (0, 0, 10);
    }
    if (low & 2) {
        level.doa.arenas[level.doa.var_90873830].var_7526f3f5 = level.doa.arenas[level.doa.var_90873830].var_7526f3f5 + vectorscale(forward, 10);
    }
    if (high & 2) {
        level.doa.arenas[level.doa.var_90873830].var_7526f3f5 = level.doa.arenas[level.doa.var_90873830].var_7526f3f5 - vectorscale(forward, 10);
    }
    if (low & 4) {
        level.doa.arenas[level.doa.var_90873830].var_7526f3f5 = level.doa.arenas[level.doa.var_90873830].var_7526f3f5 + vectorscale(right, 10);
    }
    if (high & 4) {
        level.doa.arenas[level.doa.var_90873830].var_7526f3f5 = level.doa.arenas[level.doa.var_90873830].var_7526f3f5 - vectorscale(right, 10);
    }
    if (low & 8) {
        level.var_83a34f19 -= 1;
    }
    if (high & 8) {
        level.var_83a34f19 += 1;
    }
    if (low & 16) {
        level.var_e9c73e06 -= 1;
    }
    if (high & 16) {
        level.var_e9c73e06 += 1;
    }
}

// Namespace namespace_693feb87
// Params 7, eflags: 0x0
// Checksum 0xc530b83a, Offset: 0x6b80
// Size: 0x4c
function function_efeeaa92(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    cleanupspawneddynents();
}

/#

    // Namespace namespace_693feb87
    // Params 1, eflags: 0x0
    // Checksum 0x9913422e, Offset: 0x6bd8
    // Size: 0x34
    function debugmsg(txt) {
        println("<unknown string>" + txt);
    }

#/

// Namespace namespace_693feb87
// Params 0, eflags: 0x0
// Checksum 0xf7124a0c, Offset: 0x6c18
// Size: 0x41c
function function_12c2fbcb() {
    if (!isdefined(self.var_ec1cda64)) {
        self.var_ec1cda64 = [];
    }
    if (!isdefined(self.doa)) {
        self.entnum = self getentitynumber();
        self.doa = level.var_29e6f519[self.entnum];
        if (isdefined(self.doa.player)) {
            /#
                debugmsg("<unknown string>" + (isdefined(self.name) ? self.name : "<unknown string>") + "<unknown string>" + (isdefined(self.doa.player) ? self.doa.player.name : "<unknown string>") + "<unknown string>" + self getentitynumber() + "<unknown string>" + (isdefined(self.doa.player) ? self.doa.player getentitynumber() : -1));
            #/
            /#
                assert(self.doa.player == self);
            #/
        }
        namespace_64c6b720::function_e06716c7(self.doa);
        self.doa.player = self;
        /#
            debugmsg("<unknown string>" + (isdefined(self.name) ? self.name : "<unknown string>") + "<unknown string>" + self.entnum + "<unknown string>" + (isdefined(self.doa.player) ? self.doa.player getentitynumber() : -1));
        #/
        self cameraforcedisablescriptcam(0);
        self camerasetupdatecallback(&namespace_ad544aeb::function_d207ecc1);
        setdvar("vr_playerScale", 30);
        setfriendlynamedraw(0);
        if (self islocalplayer()) {
            self.cameramode = namespace_3ca3c537::function_9f1a0b26(0);
        }
        level notify(#"hash_aae01d5a", self.doa.player.entnum, self.doa.var_c88a6593);
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
// Checksum 0xc0a82063, Offset: 0x7040
// Size: 0x42c
function function_c33d3992(localclientnum) {
    if (!clienthassnapshot(localclientnum)) {
        /#
            debugmsg("<unknown string>" + (isdefined(self.name) ? self.name : "<unknown string>") + "<unknown string>");
        #/
        return false;
    }
    if (!self isplayer()) {
        /#
            debugmsg("<unknown string>" + (isdefined(self.name) ? self.name : "<unknown string>") + "<unknown string>");
        #/
        return false;
    }
    if (!self hasdobj(localclientnum)) {
        /#
            debugmsg("<unknown string>" + (isdefined(self.name) ? self.name : "<unknown string>") + "<unknown string>");
        #/
        return false;
    }
    if (self islocalplayer() && !isdefined(self getlocalclientnumber())) {
        /#
            debugmsg("<unknown string>" + (isdefined(self.name) ? self.name : "<unknown string>") + "<unknown string>");
        #/
        return false;
    }
    if (isspectating(localclientnum)) {
        /#
            debugmsg("<unknown string>" + (isdefined(self.name) ? self.name : "<unknown string>") + "<unknown string>");
        #/
        return false;
    }
    if (isdemoplaying()) {
        /#
            debugmsg("<unknown string>" + (isdefined(self.name) ? self.name : "<unknown string>") + "<unknown string>");
        #/
        return false;
    }
    if (self islocalplayer() && isdefined(self getlocalclientnumber())) {
        spectated = playerbeingspectated(self getlocalclientnumber());
        if (self != spectated) {
            /#
                debugmsg("<unknown string>" + (isdefined(self.name) ? self.name : "<unknown string>") + "<unknown string>");
            #/
            return false;
        }
    }
    doa = level.var_29e6f519[self getentitynumber()];
    if (isdefined(doa.player) && doa.player != self) {
        /#
            debugmsg("<unknown string>" + (isdefined(self.name) ? self.name : "<unknown string>") + "vr_eyeScale" + doa.player.name + "<unknown string>" + self getentitynumber() + "<unknown string>" + doa.player getentitynumber());
        #/
        return false;
    }
    return true;
}

// Namespace namespace_693feb87
// Params 0, eflags: 0x0
// Checksum 0x9d648174, Offset: 0x7478
// Size: 0x1e0
function function_5c2a88d5() {
    level endon(#"hash_a2a24535");
    while (true) {
        setsoundcontext("water", "over");
        foreach (player in getlocalplayers()) {
            player setsoundentcontext("water", "over");
        }
        level waittill(#"hash_c4c783f9");
        forceambientroom("cp_doa_fps_mode");
        setsoundcontext("water", "under");
        foreach (player in getlocalplayers()) {
            player setsoundentcontext("water", "under");
        }
        level waittill(#"hash_fca9c70d");
        forceambientroom("");
    }
}

// Namespace namespace_693feb87
// Params 5, eflags: 0x0
// Checksum 0xb8cbf264, Offset: 0x7660
// Size: 0x2fa
function drawcylinder(pos, rad, height, frames, color) {
    if (!isdefined(frames)) {
        frames = 60;
    }
    if (!isdefined(color)) {
        color = (0, 0, 0);
    }
    /#
        self endon(#"hash_f36da0a2");
        self endon(#"entityshutdown");
        currad = rad;
        curheight = height;
        for (frames = int(frames); frames; frames--) {
            for (r = 0; r < 20; r++) {
                theta = r / 20 * 360;
                theta2 = (r + 1) / 20 * 360;
                line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0), color);
                line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight), color);
                line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight), color);
            }
            wait(0.016);
        }
    #/
}

