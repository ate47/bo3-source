#using scripts/shared/vehicles/_raps;
#using scripts/shared/drown;
#using scripts/shared/player_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/doors_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/math_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/debug_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace load;

// Namespace load
// Params 0, eflags: 0x2
// Checksum 0x9cdd5c3, Offset: 0x698
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("load", &__init__, undefined, undefined);
}

// Namespace load
// Params 0, eflags: 0x2
// Checksum 0xee1e469c, Offset: 0x6d8
// Size: 0x22
function autoexec first_frame() {
    level.first_frame = 1;
    wait(0.05);
    level.first_frame = undefined;
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0x5398dec, Offset: 0x708
// Size: 0x3c4
function __init__() {
    /#
        level thread function_bce02ad1();
        level thread level_notify_listener();
        level thread client_notify_listener();
        level thread load_checkpoint_on_notify();
        level thread save_checkpoint_on_notify();
    #/
    if (sessionmodeiscampaigngame()) {
        level.game_mode_suffix = "_cp";
    } else if (sessionmodeiszombiesgame()) {
        level.game_mode_suffix = "_zm";
    } else {
        level.game_mode_suffix = "_mp";
    }
    level.script = tolower(getdvarstring("mapname"));
    level.clientscripts = getdvarstring("cg_usingClientScripts") != "";
    level.campaign = "american";
    level.clientscripts = getdvarstring("cg_usingClientScripts") != "";
    level flag::init("all_players_connected");
    level flag::init("all_players_spawned");
    level flag::init("first_player_spawned");
    if (!isdefined(level.timeofday)) {
        level.timeofday = "day";
    }
    if (getdvarstring("scr_RequiredMapAspectratio") == "") {
        setdvar("scr_RequiredMapAspectratio", "1");
    }
    setdvar("r_waterFogTest", 0);
    setdvar("tu6_player_shallowWaterHeight", "0.0");
    util::registerclientsys("levelNotify");
    level thread all_players_spawned();
    level thread keep_time();
    level thread count_network_frames();
    callback::on_spawned(&on_spawned);
    self thread playerdamagerumble();
    array::thread_all(getentarray("water", "targetname"), &water_think);
    array::thread_all_ents(getentarray("badplace", "targetname"), &badplace_think);
    weapon_ammo();
    set_objective_text_colors();
    link_ents();
    function_b018f2a7();
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0x5ed8d3f1, Offset: 0xad8
// Size: 0x64
function function_b018f2a7() {
    var_ae867510 = getdvarfloat("tu16_physicsPushOutThreshold", -1);
    if (var_ae867510 != -1) {
        setdvar("tu16_physicsPushOutThreshold", 20);
    }
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0xba8c27c7, Offset: 0xb48
// Size: 0x38
function count_network_frames() {
    level.network_frame = 0;
    while (true) {
        util::wait_network_frame();
        level.network_frame++;
    }
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0x5b6582a7, Offset: 0xb88
// Size: 0x24
function keep_time() {
    while (true) {
        level.time = gettime();
        wait(0.05);
    }
}

/#

    // Namespace load
    // Params 1, eflags: 0x0
    // Checksum 0xf3818246, Offset: 0xbb8
    // Size: 0x7a
    function function_1bf0e5a5(msg) {
        if (!isdefined(level.var_ed1cf314)) {
            level.var_ed1cf314 = [];
        } else if (!isarray(level.var_ed1cf314)) {
            level.var_ed1cf314 = array(level.var_ed1cf314);
        }
        level.var_ed1cf314[level.var_ed1cf314.size] = msg;
    }

    // Namespace load
    // Params 0, eflags: 0x1 linked
    // Checksum 0xdec56495, Offset: 0xc40
    // Size: 0xfc
    function function_bce02ad1() {
        level.var_ed1cf314 = array("all_players_connected", "all_players_connected", "all_players_connected");
        wait(1);
        println("all_players_connected");
        foreach (msg in level.var_ed1cf314) {
            println("all_players_connected");
        }
        println("all_players_connected");
    }

    // Namespace load
    // Params 0, eflags: 0x1 linked
    // Checksum 0x362b6a9d, Offset: 0xd48
    // Size: 0x110
    function level_notify_listener() {
        while (true) {
            val = getdvarstring("all_players_connected");
            if (val != "all_players_connected") {
                toks = strtok(val, "all_players_connected");
                if (toks.size == 3) {
                    level notify(toks[0], toks[1], toks[2]);
                } else if (toks.size == 2) {
                    level notify(toks[0], toks[1]);
                } else {
                    level notify(toks[0]);
                }
                setdvar("all_players_connected", "all_players_connected");
            }
            wait(0.2);
        }
    }

    // Namespace load
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8820c67, Offset: 0xe60
    // Size: 0x88
    function client_notify_listener() {
        while (true) {
            val = getdvarstring("all_players_connected");
            if (val != "all_players_connected") {
                util::clientnotify(val);
                setdvar("all_players_connected", "all_players_connected");
            }
            wait(0.2);
        }
    }

    // Namespace load
    // Params 0, eflags: 0x1 linked
    // Checksum 0x3c5e9af4, Offset: 0xef0
    // Size: 0x40
    function load_checkpoint_on_notify() {
        while (true) {
            level waittill(#"save");
            checkpointcreate();
            checkpointcommit();
        }
    }

    // Namespace load
    // Params 0, eflags: 0x1 linked
    // Checksum 0x59e2e37e, Offset: 0xf38
    // Size: 0x30
    function save_checkpoint_on_notify() {
        while (true) {
            level waittill(#"load");
            checkpointrestore();
        }
    }

#/

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0xddaaca7c, Offset: 0xf70
// Size: 0x23e
function weapon_ammo() {
    ents = getentarray();
    for (i = 0; i < ents.size; i++) {
        if (isdefined(ents[i].classname) && getsubstr(ents[i].classname, 0, 7) == "weapon_") {
            weap = ents[i];
            change_ammo = 0;
            clip = undefined;
            extra = undefined;
            if (isdefined(weap.script_ammo_clip)) {
                clip = weap.script_ammo_clip;
                change_ammo = 1;
            }
            if (isdefined(weap.script_ammo_extra)) {
                extra = weap.script_ammo_extra;
                change_ammo = 1;
            }
            if (change_ammo) {
                if (!isdefined(clip)) {
                    assertmsg("all_players_connected" + weap.classname + "all_players_connected" + weap.origin + "all_players_connected");
                }
                if (!isdefined(extra)) {
                    assertmsg("all_players_connected" + weap.classname + "all_players_connected" + weap.origin + "all_players_connected");
                }
                weap itemweaponsetammo(clip, extra);
                weap itemweaponsetammo(clip, extra, 1);
            }
        }
    }
}

// Namespace load
// Params 1, eflags: 0x1 linked
// Checksum 0x4d039a56, Offset: 0x11b8
// Size: 0x74
function badplace_think(badplace) {
    if (!isdefined(level.badplaces)) {
        level.badplaces = 0;
    }
    level.badplaces++;
    badplace_box("badplace" + level.badplaces, -1, badplace.origin, badplace.radius, "all");
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0x1b47364c, Offset: 0x1238
// Size: 0x58
function playerdamagerumble() {
    while (true) {
        amount = self waittill(#"damage");
        if (isdefined(self.specialdamage)) {
            continue;
        }
        self playrumbleonentity("damage_heavy");
    }
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0xec502c05, Offset: 0x1298
// Size: 0x74
function map_is_early_in_the_game() {
    /#
        if (isdefined(level.testmap)) {
            return true;
        }
    #/
    /#
        if (!isdefined(level.early_level[level.script])) {
            level.early_level[level.script] = 0;
        }
    #/
    return isdefined(level.early_level[level.script]) && level.early_level[level.script];
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0x77c3f75a, Offset: 0x1318
// Size: 0x88
function player_throwgrenade_timer() {
    self endon(#"death");
    self endon(#"disconnect");
    self.lastgrenadetime = 0;
    while (true) {
        while (!self isthrowinggrenade()) {
            wait(0.05);
        }
        self.lastgrenadetime = gettime();
        while (self isthrowinggrenade()) {
            wait(0.05);
        }
    }
}

// Namespace load
// Params 0, eflags: 0x0
// Checksum 0x21318ffc, Offset: 0x13a8
// Size: 0x376
function function_cebdcdf7() {
    self endon(#"disconnect");
    self thread player_throwgrenade_timer();
    if (issplitscreen() || util::coopgame()) {
        return;
    }
    attacker, cause, weapon, var_75db6cbf = self waittill(#"death");
    if (cause != "MOD_GAS" && cause != "MOD_GRENADE" && cause != "MOD_GRENADE_SPLASH" && cause != "MOD_SUICIDE" && cause != "MOD_EXPLOSIVE" && cause != "MOD_PROJECTILE" && cause != "MOD_PROJECTILE_SPLASH") {
        return;
    }
    if (level.gameskill >= 2) {
        if (!map_is_early_in_the_game()) {
            return;
        }
    }
    if (cause == "MOD_EXPLOSIVE") {
        if (attacker.classname == "script_vehicle" || isdefined(attacker) && isdefined(attacker.var_4d8d3fde)) {
            level notify(#"hash_4021bd14");
            setdvar("ui_deadquote", "@SCRIPT_EXPLODING_VEHICLE_DEATH");
            self thread function_8229d210();
            return;
        }
        if (isdefined(var_75db6cbf) && isdefined(var_75db6cbf.destructibledef)) {
            if (issubstr(var_75db6cbf.destructibledef, "barrel_explosive")) {
                level notify(#"hash_4021bd14");
                setdvar("ui_deadquote", "@SCRIPT_EXPLODING_BARREL_DEATH");
                return;
            }
            if (isdefined(var_75db6cbf.var_675dbca3) && var_75db6cbf.var_675dbca3) {
                level notify(#"hash_4021bd14");
                setdvar("ui_deadquote", "@SCRIPT_EXPLODING_VEHICLE_DEATH");
                self thread function_8229d210();
                return;
            }
        }
    }
    if (cause == "MOD_GRENADE" || cause == "MOD_GRENADE_SPLASH") {
        if (!weapon.istimeddetonation || !weapon.isgrenadeweapon) {
            return;
        }
        level notify(#"hash_4021bd14");
        if (weapon.name == "explosive_bolt") {
            setdvar("ui_deadquote", "@SCRIPT_EXPLOSIVE_BOLT_DEATH");
            thread function_f67aaa2d();
            return;
        }
        setdvar("ui_deadquote", "@SCRIPT_GRENADE_DEATH");
        thread function_49fc0e66();
        return;
    }
}

// Namespace load
// Params 2, eflags: 0x0
// Checksum 0x774d10c1, Offset: 0x1728
// Size: 0x304
function function_fed824a2(var_a211332b, var_3009c3f0) {
    self.failingmission = 1;
    setdvar("ui_deadquote", "");
    wait(0.5);
    fontelem = newhudelem();
    fontelem.elemtype = "font";
    fontelem.font = "default";
    fontelem.fontscale = 1.5;
    fontelem.x = 0;
    fontelem.y = -60;
    fontelem.alignx = "center";
    fontelem.aligny = "middle";
    fontelem.horzalign = "center";
    fontelem.vertalign = "middle";
    fontelem settext(var_a211332b);
    fontelem.foreground = 1;
    fontelem.alpha = 0;
    fontelem fadeovertime(1);
    fontelem.alpha = 1;
    fontelem.hidewheninmenu = 1;
    if (isdefined(var_3009c3f0)) {
        fontelem = newhudelem();
        fontelem.elemtype = "font";
        fontelem.font = "default";
        fontelem.fontscale = 1.5;
        fontelem.x = 0;
        fontelem.y = -60 + level.fontheight * fontelem.fontscale;
        fontelem.alignx = "center";
        fontelem.aligny = "middle";
        fontelem.horzalign = "center";
        fontelem.vertalign = "middle";
        fontelem settext(var_3009c3f0);
        fontelem.foreground = 1;
        fontelem.alpha = 0;
        fontelem fadeovertime(1);
        fontelem.alpha = 1;
        fontelem.hidewheninmenu = 1;
    }
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0x5bb0eba9, Offset: 0x1a38
// Size: 0x284
function function_49fc0e66() {
    self endon(#"disconnect");
    wait(0.5);
    var_e1479b80 = newclienthudelem(self);
    var_e1479b80.x = 0;
    var_e1479b80.y = 68;
    var_e1479b80 setshader("hud_grenadeicon_256", 50, 50);
    var_e1479b80.alignx = "center";
    var_e1479b80.aligny = "middle";
    var_e1479b80.horzalign = "center";
    var_e1479b80.vertalign = "middle";
    var_e1479b80.foreground = 1;
    var_e1479b80.alpha = 0;
    var_e1479b80 fadeovertime(1);
    var_e1479b80.alpha = 1;
    var_e1479b80.hidewheninmenu = 1;
    var_ed3ed80e = newclienthudelem(self);
    var_ed3ed80e.x = 0;
    var_ed3ed80e.y = 25;
    var_ed3ed80e setshader("hud_grenadepointer", 50, 25);
    var_ed3ed80e.alignx = "center";
    var_ed3ed80e.aligny = "middle";
    var_ed3ed80e.horzalign = "center";
    var_ed3ed80e.vertalign = "middle";
    var_ed3ed80e.foreground = 1;
    var_ed3ed80e.alpha = 0;
    var_ed3ed80e fadeovertime(1);
    var_ed3ed80e.alpha = 1;
    var_ed3ed80e.hidewheninmenu = 1;
    self thread function_69110cf3(var_e1479b80, var_ed3ed80e);
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0x6b0c41cb, Offset: 0x1cc8
// Size: 0x284
function function_f67aaa2d() {
    self endon(#"disconnect");
    wait(0.5);
    var_e1479b80 = newclienthudelem(self);
    var_e1479b80.x = 0;
    var_e1479b80.y = 68;
    var_e1479b80 setshader("hud_explosive_arrow_icon", 50, 50);
    var_e1479b80.alignx = "center";
    var_e1479b80.aligny = "middle";
    var_e1479b80.horzalign = "center";
    var_e1479b80.vertalign = "middle";
    var_e1479b80.foreground = 1;
    var_e1479b80.alpha = 0;
    var_e1479b80 fadeovertime(1);
    var_e1479b80.alpha = 1;
    var_e1479b80.hidewheninmenu = 1;
    var_ed3ed80e = newclienthudelem(self);
    var_ed3ed80e.x = 0;
    var_ed3ed80e.y = 25;
    var_ed3ed80e setshader("hud_grenadepointer", 50, 25);
    var_ed3ed80e.alignx = "center";
    var_ed3ed80e.aligny = "middle";
    var_ed3ed80e.horzalign = "center";
    var_ed3ed80e.vertalign = "middle";
    var_ed3ed80e.foreground = 1;
    var_ed3ed80e.alpha = 0;
    var_ed3ed80e fadeovertime(1);
    var_ed3ed80e.alpha = 1;
    var_ed3ed80e.hidewheninmenu = 1;
    self thread function_69110cf3(var_e1479b80, var_ed3ed80e);
}

// Namespace load
// Params 0, eflags: 0x0
// Checksum 0x76d9e67, Offset: 0x1f58
// Size: 0x284
function function_d88a3ecf() {
    self endon(#"disconnect");
    wait(0.5);
    var_e1479b80 = newclienthudelem(self);
    var_e1479b80.x = 0;
    var_e1479b80.y = 68;
    var_e1479b80 setshader("hud_monsoon_titus_arrow", 50, 50);
    var_e1479b80.alignx = "center";
    var_e1479b80.aligny = "middle";
    var_e1479b80.horzalign = "center";
    var_e1479b80.vertalign = "middle";
    var_e1479b80.foreground = 1;
    var_e1479b80.alpha = 0;
    var_e1479b80 fadeovertime(1);
    var_e1479b80.alpha = 1;
    var_e1479b80.hidewheninmenu = 1;
    var_ed3ed80e = newclienthudelem(self);
    var_ed3ed80e.x = 0;
    var_ed3ed80e.y = 25;
    var_ed3ed80e setshader("hud_grenadepointer", 50, 25);
    var_ed3ed80e.alignx = "center";
    var_ed3ed80e.aligny = "middle";
    var_ed3ed80e.horzalign = "center";
    var_ed3ed80e.vertalign = "middle";
    var_ed3ed80e.foreground = 1;
    var_ed3ed80e.alpha = 0;
    var_ed3ed80e fadeovertime(1);
    var_ed3ed80e.alpha = 1;
    var_ed3ed80e.hidewheninmenu = 1;
    self thread function_69110cf3(var_e1479b80, var_ed3ed80e);
}

// Namespace load
// Params 0, eflags: 0x0
// Checksum 0x924542ea, Offset: 0x21e8
// Size: 0x284
function function_a2ec9313() {
    self endon(#"disconnect");
    wait(0.5);
    var_e1479b80 = newclienthudelem(self);
    var_e1479b80.x = 0;
    var_e1479b80.y = 68;
    var_e1479b80 setshader("hud_monsoon_nitrogen_barrel", 50, 50);
    var_e1479b80.alignx = "center";
    var_e1479b80.aligny = "middle";
    var_e1479b80.horzalign = "center";
    var_e1479b80.vertalign = "middle";
    var_e1479b80.foreground = 1;
    var_e1479b80.alpha = 0;
    var_e1479b80 fadeovertime(1);
    var_e1479b80.alpha = 1;
    var_e1479b80.hidewheninmenu = 1;
    var_ed3ed80e = newclienthudelem(self);
    var_ed3ed80e.x = 0;
    var_ed3ed80e.y = 25;
    var_ed3ed80e setshader("hud_grenadepointer", 50, 25);
    var_ed3ed80e.alignx = "center";
    var_ed3ed80e.aligny = "middle";
    var_ed3ed80e.horzalign = "center";
    var_ed3ed80e.vertalign = "middle";
    var_ed3ed80e.foreground = 1;
    var_ed3ed80e.alpha = 0;
    var_ed3ed80e fadeovertime(1);
    var_ed3ed80e.alpha = 1;
    var_ed3ed80e.hidewheninmenu = 1;
    self thread function_69110cf3(var_e1479b80, var_ed3ed80e);
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0x49103b34, Offset: 0x2478
// Size: 0x17c
function function_8229d210() {
    self endon(#"disconnect");
    wait(0.5);
    var_e1479b80 = newclienthudelem(self);
    var_e1479b80.x = 0;
    var_e1479b80.y = -10;
    var_e1479b80 setshader("hud_exploding_vehicles", 50, 50);
    var_e1479b80.alignx = "center";
    var_e1479b80.aligny = "middle";
    var_e1479b80.horzalign = "center";
    var_e1479b80.vertalign = "middle";
    var_e1479b80.foreground = 1;
    var_e1479b80.alpha = 0;
    var_e1479b80 fadeovertime(1);
    var_e1479b80.alpha = 1;
    var_e1479b80.hidewheninmenu = 1;
    var_ed3ed80e = newclienthudelem(self);
    self thread function_69110cf3(var_e1479b80, var_ed3ed80e);
}

// Namespace load
// Params 2, eflags: 0x1 linked
// Checksum 0x23c483ff, Offset: 0x2600
// Size: 0x5c
function function_69110cf3(var_10b2f152, var_ad2b839c) {
    self endon(#"disconnect");
    self waittill(#"spawned");
    var_10b2f152 destroy();
    var_ad2b839c destroy();
}

// Namespace load
// Params 6, eflags: 0x1 linked
// Checksum 0xf8f3d539, Offset: 0x2668
// Size: 0x1c4
function function_e152ebb3(shader, iwidth, var_40c0cdd3, fdelay, x, y) {
    if (!isdefined(fdelay)) {
        fdelay = 0.5;
    }
    wait(fdelay);
    overlay = newclienthudelem(self);
    if (isdefined(x)) {
        overlay.x = x;
    } else {
        overlay.x = 0;
    }
    if (isdefined(y)) {
        overlay.y = y;
    } else {
        overlay.y = 40;
    }
    overlay setshader(shader, iwidth, var_40c0cdd3);
    overlay.alignx = "center";
    overlay.aligny = "middle";
    overlay.horzalign = "center";
    overlay.vertalign = "middle";
    overlay.foreground = 1;
    overlay.alpha = 0;
    overlay fadeovertime(1);
    overlay.alpha = 1;
    overlay.hidewheninmenu = 1;
    self thread function_90e3bbdb(overlay);
}

// Namespace load
// Params 1, eflags: 0x1 linked
// Checksum 0xee24e4c9, Offset: 0x2838
// Size: 0x3c
function function_90e3bbdb(overlay) {
    self endon(#"disconnect");
    self waittill(#"spawned");
    overlay destroy();
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0xbfb5c250, Offset: 0x2880
// Size: 0x448
function water_think() {
    assert(isdefined(self.target));
    targeted = getent(self.target, "targetname");
    assert(isdefined(targeted));
    waterheight = targeted.origin[2];
    targeted = undefined;
    level.depth_allow_prone = 8;
    level.depth_allow_crouch = 33;
    level.depth_allow_stand = 50;
    while (true) {
        wait(0.05);
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (players[i].inwater) {
                players[i] allowprone(1);
                players[i] allowcrouch(1);
                players[i] allowstand(1);
            }
        }
        other = self waittill(#"trigger");
        if (!isplayer(other)) {
            continue;
        }
        while (true) {
            players = getplayers();
            players_in_water_count = 0;
            for (i = 0; i < players.size; i++) {
                if (players[i] istouching(self)) {
                    players_in_water_count++;
                    players[i].inwater = 1;
                    playerorg = players[i] getorigin();
                    d = playerorg[2] - waterheight;
                    if (d > 0) {
                        continue;
                    }
                    newspeed = int(level.default_run_speed - abs(d * 5));
                    if (newspeed < 50) {
                        newspeed = 50;
                    }
                    assert(newspeed <= -66);
                    if (abs(d) > level.depth_allow_crouch) {
                        players[i] allowcrouch(0);
                    } else {
                        players[i] allowcrouch(1);
                    }
                    if (abs(d) > level.depth_allow_prone) {
                        players[i] allowprone(0);
                    } else {
                        players[i] allowprone(1);
                    }
                    continue;
                }
                if (players[i].inwater) {
                    players[i].inwater = 0;
                }
            }
            if (players_in_water_count == 0) {
                break;
            }
            wait(0.5);
        }
        wait(0.05);
    }
}

// Namespace load
// Params 1, eflags: 0x0
// Checksum 0xe3d7ddef, Offset: 0x2cd0
// Size: 0x13c
function indicate_start(start) {
    hudelem = newhudelem();
    hudelem.alignx = "left";
    hudelem.aligny = "middle";
    hudelem.x = 70;
    hudelem.y = 400;
    hudelem.label = start;
    hudelem.alpha = 0;
    hudelem.fontscale = 3;
    wait(1);
    hudelem fadeovertime(1);
    hudelem.alpha = 1;
    wait(5);
    hudelem fadeovertime(1);
    hudelem.alpha = 0;
    wait(1);
    hudelem destroy();
}

// Namespace load
// Params 0, eflags: 0x0
// Checksum 0x9e185602, Offset: 0x2e18
// Size: 0x1e4
function calculate_map_center() {
    if (!isdefined(level.mapcenter)) {
        nodes = getallnodes();
        if (isdefined(nodes[0])) {
            level.nodesmins = nodes[0].origin;
            level.nodesmaxs = nodes[0].origin;
        } else {
            level.nodesmins = (0, 0, 0);
            level.nodesmaxs = (0, 0, 0);
        }
        for (index = 0; index < nodes.size; index++) {
            if (nodes[index].type == "BAD NODE") {
                println("all_players_connected", nodes[index].origin);
                continue;
            }
            origin = nodes[index].origin;
            level.nodesmins = math::expand_mins(level.nodesmins, origin);
            level.nodesmaxs = math::expand_maxs(level.nodesmaxs, origin);
        }
        level.mapcenter = math::find_box_center(level.nodesmins, level.nodesmaxs);
        println("all_players_connected", level.mapcenter);
        setmapcenter(level.mapcenter);
    }
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0x6b709e43, Offset: 0x3008
// Size: 0x94
function set_objective_text_colors() {
    my_textbrightness_default = "1.0 1.0 1.0";
    my_textbrightness_90 = "0.9 0.9 0.9";
    var_c875cf40 = "0.85 0.85 0.85";
    if (level.script == "armada") {
        setsaveddvar("con_typewriterColorBase", my_textbrightness_90);
        return;
    }
    setsaveddvar("con_typewriterColorBase", my_textbrightness_default);
}

// Namespace load
// Params 4, eflags: 0x0
// Checksum 0x30bf5067, Offset: 0x30a8
// Size: 0x122
function lerp_trigger_dvar_value(trigger, dvar, value, time) {
    trigger.lerping_dvar[dvar] = 1;
    steps = time * 20;
    curr_value = getdvarfloat(dvar);
    diff = (curr_value - value) / steps;
    for (i = 0; i < steps; i++) {
        curr_value -= diff;
        setsaveddvar(dvar, curr_value);
        wait(0.05);
    }
    setsaveddvar(dvar, value);
    trigger.lerping_dvar[dvar] = 0;
}

// Namespace load
// Params 1, eflags: 0x0
// Checksum 0x29780f2, Offset: 0x31d8
// Size: 0xec
function set_fog_progress(progress) {
    anti_progress = 1 - progress;
    startdist = self.script_start_dist * anti_progress + self.script_start_dist * progress;
    halfwaydist = self.script_halfway_dist * anti_progress + self.script_halfway_dist * progress;
    color = self.script_color * anti_progress + self.script_color * progress;
    setvolfog(startdist, halfwaydist, self.script_halfway_height, self.script_base_height, color[0], color[1], color[2], 0.4);
}

/#

    // Namespace load
    // Params 0, eflags: 0x0
    // Checksum 0xa50b7b47, Offset: 0x32d0
    // Size: 0x24
    function ascii_logo() {
        println("all_players_connected");
    }

#/

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0x45af9438, Offset: 0x3300
// Size: 0x15c
function all_players_spawned() {
    level flag::wait_till("all_players_connected");
    waittillframeend();
    level.host = util::gethostplayer();
    while (true) {
        if (getnumconnectedplayers() == 0) {
            wait(0.05);
            continue;
        }
        players = getplayers();
        count = 0;
        for (i = 0; i < players.size; i++) {
            if (players[i].sessionstate == "playing") {
                count++;
            }
        }
        wait(0.05);
        if (count > 0) {
            level flag::set("first_player_spawned");
        }
        if (count == players.size) {
            break;
        }
    }
    level flag::set("all_players_spawned");
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0x875110ec, Offset: 0x3468
// Size: 0x1e0
function shock_onpain() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"killonpainmonitor");
    if (getdvarstring("blurpain") == "") {
        setdvar("blurpain", "on");
    }
    while (true) {
        oldhealth = self.health;
        damage, attacker, direction_vec, point, mod = self waittill(#"damage");
        if (isdefined(level.shock_onpain) && !level.shock_onpain) {
            continue;
        }
        if (isdefined(self.shock_onpain) && !self.shock_onpain) {
            continue;
        }
        if (self.health < 1) {
            continue;
        }
        if (mod == "MOD_PROJECTILE") {
            continue;
        }
        if (mod == "MOD_GRENADE_SPLASH" || mod == "MOD_GRENADE" || mod == "MOD_EXPLOSIVE" || mod == "MOD_PROJECTILE_SPLASH") {
            self shock_onexplosion(damage);
            continue;
        }
        if (getdvarstring("blurpain") == "on") {
            self shellshock("pain", 0.5);
        }
    }
}

// Namespace load
// Params 1, eflags: 0x1 linked
// Checksum 0x80405272, Offset: 0x3650
// Size: 0xc2
function shock_onexplosion(damage) {
    time = 0;
    multiplier = self.maxhealth / 100;
    scaled_damage = damage * multiplier;
    if (scaled_damage >= 90) {
        time = 4;
    } else if (scaled_damage >= 50) {
        time = 3;
    } else if (scaled_damage >= 25) {
        time = 2;
    } else if (scaled_damage > 10) {
        time = 1;
    }
    if (time) {
    }
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0xabb7bf06, Offset: 0x3720
// Size: 0x7a
function shock_ondeath() {
    self waittill(#"death");
    if (isdefined(level.shock_ondeath) && !level.shock_ondeath) {
        return;
    }
    if (isdefined(self.shock_ondeath) && !self.shock_ondeath) {
        return;
    }
    if (isdefined(self.specialdeath)) {
        return;
    }
    if (getdvarstring("r_texturebits") == "16") {
        return;
    }
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0xcab53541, Offset: 0x37a8
// Size: 0x80
function on_spawned() {
    if (!isdefined(self.player_inited) || !self.player_inited) {
        if (sessionmodeiscampaigngame()) {
            self thread shock_ondeath();
            self thread shock_onpain();
        }
        wait(0.05);
        if (isdefined(self)) {
            self.player_inited = 1;
        }
    }
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0xa913f354, Offset: 0x3830
// Size: 0xfa
function link_ents() {
    foreach (ent in getentarray()) {
        if (isdefined(ent.linkto)) {
            e_link = getent(ent.linkto, "linkname");
            if (isdefined(e_link)) {
                ent enablelinkto();
                ent linkto(e_link);
            }
        }
    }
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0x4fe714b4, Offset: 0x3938
// Size: 0x242
function art_review() {
    str_dvar = getdvarstring("art_review");
    switch (str_dvar) {
    case 6:
        setdvar("art_review", "0");
        break;
    case 13:
    case 69:
        hud = hud::createserverfontstring("objective", 1.2);
        hud hud::setpoint("CENTER", "CENTER", 0, -200);
        hud.sort = 1001;
        hud.color = (1, 0, 0);
        hud settext("ART REVIEW");
        hud.foreground = 0;
        hud.hidewheninmenu = 0;
        if (sessionmodeiszombiesgame()) {
            setdvar("zombie_cheat", "2");
            if (str_dvar == "1") {
                setdvar("zombie_devgui", "power_on");
            }
        } else {
            foreach (trig in trigger::get_all()) {
                trig triggerenable(0);
            }
        }
        level waittill(#"forever");
        break;
    }
}

