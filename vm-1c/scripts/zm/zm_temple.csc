#using scripts/zm/zm_temple_sq;
#using scripts/zm/zm_temple_maze;
#using scripts/zm/zm_temple_geyser;
#using scripts/zm/zm_temple_fx;
#using scripts/zm/zm_temple_amb;
#using scripts/zm/zm_temple_ai_monkey;
#using scripts/zm/zm_temple_ffotd;
#using scripts/zm/_zm_audio_zhd;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerup_insta_kill;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_free_perk;
#using scripts/zm/_zm_powerup_fire_sale;
#using scripts/zm/_zm_powerup_carpenter;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_ai_monkey;
#using scripts/zm/_zm_ai_sonic;
#using scripts/zm/_zm_ai_napalm;
#using scripts/zm/_zm_perk_widows_wine;
#using scripts/zm/_zm_perk_staminup;
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_deadshot;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/_zm_weap_shrink_ray;
#using scripts/zm/_zm_weap_cymbal_monkey;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_radio;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_3dfeef6;

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x2
// Checksum 0x29d47e65, Offset: 0xc98
// Size: 0x1c
function autoexec function_d9af860b() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0x494b97b9, Offset: 0xcc0
// Size: 0x314
function main() {
    namespace_dd1df788::main_start();
    setdvar("player_sliding_velocity_cap", 50);
    setdvar("player_sliding_wishspeed", 600);
    level.default_game_mode = "zclassic";
    level.default_start_location = "default";
    thread namespace_5a142e53::main();
    level._uses_sticky_grenades = 1;
    level.var_fd2ea5bf = "zombie_temple";
    level.var_8f3e0996 = 1;
    level.var_dc92592 = "zombie_temple_caves";
    level.var_d343e2d9 = 2;
    level.var_27ac88fb = "zombie_temple";
    level.var_b147d899 = "zombie_temple_eclipse";
    level.var_cc2b2a14 = 3;
    level.var_d37e3e94 = "zombie_temple_eclipseCave";
    level.var_2e19fbe7 = 3;
    level.riser_fx_on_client = 1;
    level.var_f409c3b7 = 1;
    level.use_clientside_rock_tearin_fx = 1;
    level.use_clientside_board_fx = 1;
    level.var_e34b793e = 0;
    include_weapons();
    function_904eea0();
    visionset_mgr::register_overlay_info_style_blur("zm_ai_screecher_blur", 21000, 15, 0.1, 0.25, 20);
    level thread namespace_c3b98877::main();
    function_80cb4231();
    namespace_1e4bbaa5::init_clientfields();
    namespace_d8a67ca0::main();
    load::main();
    namespace_570c8452::init();
    level thread function_2dd0c8b0();
    callback::on_localclient_connect(&function_76faa4d1);
    callback::on_localplayer_spawned(&function_5a53d129);
    level thread function_ae718896();
    level thread function_1499a076();
    level.var_e7418723 = 0;
    level thread function_b5154c12();
    util::waitforclient(0);
    level thread function_6ac83719();
    println("zm_ai_screecher_blur");
    namespace_dd1df788::main_end();
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0xaba209c, Offset: 0xfe0
// Size: 0x7c
function function_6ac83719() {
    visionset_mgr::function_980ca37e("zombie_temple", 2);
    visionset_mgr::function_a95252c1("");
    visionset_mgr::function_3aea3c1a(0, "zombie_temple");
    visionset_mgr::function_3aea3c1a(1, "zombie_temple_caves");
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0xf327756b, Offset: 0x1068
// Size: 0x4e4
function function_80cb4231() {
    clientfield::register("actor", "ragimpactgib", 21000, 1, "int", &ragdoll_impact_watch_start, 0, 0);
    clientfield::register("scriptmover", "spiketrap", 21000, 1, "int", &function_133f421f, 0, 0);
    clientfield::register("scriptmover", "mazewall", 21000, 1, "int", &function_98ca8bd1, 0, 0);
    clientfield::register("scriptmover", "weaksauce", 21000, 1, "int", &function_602bf03c, 0, 0);
    clientfield::register("scriptmover", "hotsauce", 21000, 1, "int", &function_cae69a93, 0, 0);
    clientfield::register("scriptmover", "sauceend", 21000, 1, "int", &function_e057558f, 0, 0);
    clientfield::register("scriptmover", "watertrail", 21000, 1, "int", &function_eed31edc, 0, 0);
    clientfield::register("toplayer", "floorrumble", 21000, 1, "int", &function_bfe7237e, 0, 0);
    clientfield::register("toplayer", "minecart_rumble", 21000, 1, "int", &function_425904c0, 0, 0);
    clientfield::register("world", "papspinners", 21000, 4, "int", &function_9fe44296, 0, 0);
    clientfield::register("world", "water_wheel_right", 21000, 1, "int", &function_58c29149, 0, 0);
    clientfield::register("world", "water_wheel_left", 21000, 1, "int", &function_3c7f447a, 0, 0);
    clientfield::register("world", "waterfall_trap", 21000, 1, "int", &function_a4520d2c, 0, 0);
    clientfield::register("world", "time_transition", 21000, 1, "int", &function_b20caafb, 0, 1);
    clientfield::register("allplayers", "player_legs_hide", 21000, 1, "int", &function_197274ad, 0, 0);
    clientfield::register("scriptmover", "zombie_has_eyes", 21000, 1, "int", &zm::zombie_eyes_clientfield_cb, 0, 0);
    visionset_mgr::register_overlay_info_style_postfx_bundle("zm_waterfall_postfx", 21000, 32, "pstfx_waterfall_soft", 3);
    visionset_mgr::register_overlay_info_style_postfx_bundle("zm_temple_eclipse", 21000, 1, "pstfx_temple_eclipse_in", 3);
}

// Namespace namespace_3dfeef6
// Params 7, eflags: 0x1 linked
// Checksum 0xfe83413a, Offset: 0x1558
// Size: 0x54
function function_133f421f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    function_60f46de3(localclientnum, newval);
}

// Namespace namespace_3dfeef6
// Params 7, eflags: 0x1 linked
// Checksum 0x3ccb0870, Offset: 0x15b8
// Size: 0x54
function function_98ca8bd1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    namespace_6383e0::function_469b0955(localclientnum, newval);
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0xcecb248, Offset: 0x1618
// Size: 0x5e
function function_7f5b75() {
    wait(1.2);
    for (i = 0; i < self.fx_ents.size; i++) {
        self.fx_ents[i] delete();
    }
    self.fx_ents = undefined;
}

// Namespace namespace_3dfeef6
// Params 7, eflags: 0x1 linked
// Checksum 0xaf4a88d9, Offset: 0x1680
// Size: 0x18c
function function_eed31edc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (localclientnum != 0) {
        return;
    }
    if (newval) {
        players = getlocalplayers();
        self.fx_ents = [];
        for (i = 0; i < players.size; i++) {
            self.fx_ents[i] = spawn(i, (0, 0, 0), "script_model");
            self.fx_ents[i] setmodel("tag_origin");
            self.fx_ents[i] linkto(self, "tag_origin");
            playfxontag(i, level._effect["fx_crystal_water_trail"], self.fx_ents[i], "tag_origin");
        }
        return;
    }
    if (isdefined(self.fx_ents)) {
        self thread function_7f5b75();
    }
}

// Namespace namespace_3dfeef6
// Params 7, eflags: 0x1 linked
// Checksum 0x91475ab1, Offset: 0x1818
// Size: 0xb4
function function_602bf03c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (localclientnum != 0) {
        return;
    }
    if (!newval) {
        return;
    }
    s = spawnstruct();
    s.fx = "fx_weak_sauce_trail";
    s.origin = self.origin + (0, 0, 134);
    level.var_74e2d6e3 = s;
}

// Namespace namespace_3dfeef6
// Params 7, eflags: 0x1 linked
// Checksum 0x47bdcb72, Offset: 0x18d8
// Size: 0xb4
function function_cae69a93(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (localclientnum != 0) {
        return;
    }
    if (!newval) {
        return;
    }
    s = spawnstruct();
    s.fx = "fx_hot_sauce_trail";
    s.origin = self.origin + (0, 0, 134);
    level.var_74e2d6e3 = s;
}

// Namespace namespace_3dfeef6
// Params 7, eflags: 0x1 linked
// Checksum 0x45e97701, Offset: 0x1998
// Size: 0x98
function function_e057558f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (localclientnum != 0) {
        return;
    }
    if (!newval) {
        return;
    }
    level.var_783ac250 = self.origin;
    if (self.model == "p7_zm_sha_crystal_holder_full") {
        level.var_783ac250 += (0, 0, 134);
    }
}

// Namespace namespace_3dfeef6
// Params 3, eflags: 0x1 linked
// Checksum 0x2fbb12ba, Offset: 0x1a38
// Size: 0xf4
function function_119af5f9(localclientnum, fx_name, dest) {
    println("zm_ai_screecher_blur" + fx_name + "zm_ai_screecher_blur" + self.origin + "zm_ai_screecher_blur" + dest);
    playfxontag(localclientnum, level._effect[fx_name], self, "tag_origin");
    self playloopsound("evt_sq_bag_crystal_bounce_loop", 0.05);
    self moveto(dest, 0.5);
    self waittill(#"movedone");
    self delete();
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0xc708704, Offset: 0x1b38
// Size: 0x11a
function function_b5154c12() {
    num_players = getlocalplayers().size;
    while (true) {
        wait(0.016);
        if (!isdefined(level.var_74e2d6e3) || !isdefined(level.var_783ac250)) {
            continue;
        }
        for (i = 0; i < num_players; i++) {
            e = spawn(i, level.var_74e2d6e3.origin, "script_model");
            e setmodel("tag_origin");
            e thread function_119af5f9(i, level.var_74e2d6e3.fx, level.var_783ac250);
        }
        level.var_74e2d6e3 = undefined;
        level.var_783ac250 = undefined;
    }
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0xc21db335, Offset: 0x1c60
// Size: 0x3c
function function_2dd0c8b0() {
    level.power = 0;
    level waittill(#"zpo");
    level.power = 1;
    level thread function_3c84e77b();
}

// Namespace namespace_3dfeef6
// Params 7, eflags: 0x1 linked
// Checksum 0xf1cc01f4, Offset: 0x1ca8
// Size: 0x2d4
function function_b20caafb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        level notify(#"hash_72edbd2b");
        level thread namespace_c3b98877::function_e3a6a660(bnewent, binitialsnap, bwasdemojump);
        var_4796f90 = isdefined(level.var_e7418723) && level.var_e7418723;
        level.var_e7418723 = 0;
        visionset_mgr::function_a95252c1("");
        level notify(#"hash_560b77f5", level.var_e7418723);
        exploder::exploder("fxexp_401");
        if (var_4796f90) {
            exploder::kill_exploder("fxexp_402");
        }
        exploder::kill_exploder("eclipse");
        if (bnewent || binitialsnap || bwasdemojump) {
            setdvar("r_skyTransition", 0);
        } else {
            level thread function_bf1b3728(0, 2);
        }
        setlitfogbank(localclientnum, -1, 0, 0);
        setworldfogactivebank(localclientnum, 1);
    } else {
        level thread namespace_c3b98877::function_418a175a();
        level.var_e7418723 = 1;
        level notify(#"hash_560b77f5", level.var_e7418723);
        visionset_mgr::function_a95252c1("_eclipse");
        exploder::exploder("eclipse");
        exploder::exploder("fxexp_402");
        exploder::kill_exploder("fxexp_401");
        level thread function_bf1b3728(1, 2.5);
        setlitfogbank(localclientnum, -1, 1, 1);
        setworldfogactivebank(localclientnum, 2);
    }
    if (!isdefined(level.var_b169a849)) {
        level.var_b169a849 = 0;
        return;
    }
    level thread function_7b0ba395(localclientnum);
}

// Namespace namespace_3dfeef6
// Params 2, eflags: 0x1 linked
// Checksum 0xa71c0b30, Offset: 0x1f88
// Size: 0x144
function function_bf1b3728(n_val, n_time) {
    level notify(#"hash_47d048e6");
    level endon(#"hash_47d048e6");
    if (!isdefined(level.var_3766c3d3)) {
        level.var_3766c3d3 = 0;
    }
    if (level.var_3766c3d3 == n_val) {
        return;
    }
    if (n_val > level.var_3766c3d3) {
        var_83a6ec14 = n_val - level.var_3766c3d3;
    } else {
        var_83a6ec14 = (level.var_3766c3d3 - n_val) * -1;
        wait(0.5);
    }
    var_c7518b5c = var_83a6ec14 / n_time / 0.1;
    while (level.var_3766c3d3 != n_val) {
        level.var_3766c3d3 += var_c7518b5c;
        setdvar("r_skyTransition", level.var_3766c3d3);
        wait(0.1);
    }
    setdvar("r_skyTransition", n_val);
}

// Namespace namespace_3dfeef6
// Params 1, eflags: 0x1 linked
// Checksum 0xcc539365, Offset: 0x20d8
// Size: 0x12c
function function_7b0ba395(localclientnum) {
    level endon(#"hash_2293ad98");
    level endon(#"end_game");
    player = getlocalplayers()[localclientnum];
    var_efeac590 = 0;
    n_end_time = 2;
    player playrumblelooponentity(localclientnum, "tank_rumble");
    while (isdefined(player) && var_efeac590 < n_end_time) {
        player earthquake(0.3, 0.1, player.origin, 100);
        var_efeac590 += 0.1;
        wait(0.1);
    }
    if (isdefined(player)) {
        player stoprumble(localclientnum, "tank_rumble");
    }
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0x6beb53e8, Offset: 0x2210
// Size: 0x8e
function function_3c84e77b() {
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        ent = getent(i, "power_generator", "targetname");
        ent thread function_9a2a3c08();
    }
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0xd5041863, Offset: 0x22a8
// Size: 0xc8
function function_9a2a3c08() {
    offsetangle = 0.25;
    var_4659fadf = 0.1;
    total = 0;
    self rotateroll(0 - offsetangle, var_4659fadf);
    while (true) {
        self waittill(#"rotatedone");
        self rotateroll(offsetangle * 2, var_4659fadf);
        self waittill(#"rotatedone");
        self rotateroll(0 - offsetangle * 2, var_4659fadf);
    }
}

// Namespace namespace_3dfeef6
// Params 7, eflags: 0x1 linked
// Checksum 0x67d9a957, Offset: 0x2378
// Size: 0x74
function function_197274ad(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self hideviewlegs();
        return;
    }
    self showviewlegs();
}

// Namespace namespace_3dfeef6
// Params 7, eflags: 0x1 linked
// Checksum 0x68376b85, Offset: 0x23f8
// Size: 0xd6
function function_58c29149(clientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        wheel = getent(i, "water_wheel_right", "targetname");
        wheel thread function_991549a9(120, 2.2);
    }
}

// Namespace namespace_3dfeef6
// Params 7, eflags: 0x1 linked
// Checksum 0x32c227c6, Offset: 0x24d8
// Size: 0xd6
function function_3c7f447a(clientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        wheel = getent(i, "water_wheel_left", "targetname");
        wheel thread function_991549a9(120, 1.8);
    }
}

// Namespace namespace_3dfeef6
// Params 2, eflags: 0x1 linked
// Checksum 0xac8f2df7, Offset: 0x25b8
// Size: 0x9c
function function_991549a9(rotate, time) {
    spinuptime = time - 0.5;
    self rotatepitch(rotate, time, spinuptime, 0.1);
    self waittill(#"rotatedone");
    while (true) {
        self rotatepitch(rotate, time, 0, 0);
        self waittill(#"rotatedone");
    }
}

// Namespace namespace_3dfeef6
// Params 1, eflags: 0x1 linked
// Checksum 0x3e3f6d46, Offset: 0x2660
// Size: 0x9e
function function_e80f1a40(var_cb15dba5) {
    while (!self hasdobj(var_cb15dba5)) {
        wait(0.05);
    }
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        if (self == players[i]) {
            self clearalternateaimparams();
        }
    }
}

/#

    // Namespace namespace_3dfeef6
    // Params 0, eflags: 0x0
    // Checksum 0xff476da2, Offset: 0x2708
    // Size: 0xe6
    function function_53be9070() {
        scale = 0.1;
        offset = (0, 0, 0);
        dir = anglestoforward(self.angles);
        for (i = 0; i < 5; i++) {
            print3d(self.origin + offset, "zm_ai_screecher_blur", (60, 60, -1), 1, scale, 10);
            scale *= 1.7;
            offset += dir * 6;
        }
    }

#/

// Namespace namespace_3dfeef6
// Params 7, eflags: 0x1 linked
// Checksum 0x7e796d47, Offset: 0x27f8
// Size: 0xf6
function function_a4520d2c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    targets = struct::get_array("sq_sad", "targetname");
    for (i = 0; i < targets.size; i++) {
        if (!isdefined(level.var_d2f7dbb3) || !isdefined(level.var_d2f7dbb3[i])) {
            continue;
        }
        if (level.var_d2f7dbb3[i] == 0) {
            exploder::exploder("fxexp_12" + i);
        }
        wait(0.25);
    }
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0x58e4e5d9, Offset: 0x28f8
// Size: 0x136
function function_1499a076() {
    println("zm_ai_screecher_blur");
    println("zm_ai_screecher_blur");
    level waittill(#"sr");
    players = getlocalplayers();
    println("zm_ai_screecher_blur");
    targets = struct::get_array("sq_sad", "targetname");
    println("zm_ai_screecher_blur" + targets.size + "zm_ai_screecher_blur");
    for (i = 0; i < targets.size; i++) {
        targets[i] thread function_d5a83a80(players.size);
    }
}

// Namespace namespace_3dfeef6
// Params 1, eflags: 0x1 linked
// Checksum 0xc1f5770e, Offset: 0x2a38
// Size: 0x104
function function_7f0f9f17(var_294b95fc) {
    level waittill(#"sr");
    if (isdefined(level.var_91da34fc[self.script_int - 1])) {
        for (i = 0; i < level.var_91da34fc[self.script_int - 1].size; i++) {
            if (isdefined(level.var_91da34fc[self.script_int - 1][i])) {
                level.var_91da34fc[self.script_int - 1][i] delete();
            }
        }
        level.var_91da34fc[self.script_int - 1] = undefined;
    }
    level.var_d2f7dbb3[self.script_int - 1] = 0;
    self thread function_d5a83a80(var_294b95fc);
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0x976aff67, Offset: 0x2b48
// Size: 0x60
function function_8c9f1faf() {
    /#
        level endon(#"sr");
        level endon(#"hash_3a652831");
        while (true) {
            print3d(self.origin, "zm_ai_screecher_blur", (255, 0, 0), 1);
            wait(0.1);
        }
    #/
}

// Namespace namespace_3dfeef6
// Params 1, eflags: 0x1 linked
// Checksum 0x71e2ad69, Offset: 0x2bb0
// Size: 0x1ee
function function_d5a83a80(var_294b95fc) {
    if (!isdefined(level.var_91da34fc)) {
        level.var_91da34fc = [];
        level.var_d2f7dbb3 = [];
        for (i = 0; i < 4; i++) {
            level.var_d2f7dbb3[i] = 0;
        }
    }
    level endon(#"sr");
    self thread function_7f0f9f17(var_294b95fc);
    while (true) {
        level waittill("S" + self.script_int);
        println("zm_ai_screecher_blur" + self.script_int);
        self thread function_8c9f1faf();
        level.var_d2f7dbb3[self.script_int - 1] = 1;
        level.var_91da34fc[self.script_int - 1] = [];
        for (i = 0; i < var_294b95fc; i++) {
            e = spawn(i, self.origin, "script_model");
            e.angles = self.angles + (270, 0, 0);
            e setmodel("wpn_t7_spider_mine_world");
            level.var_91da34fc[self.script_int - 1][level.var_91da34fc[self.script_int - 1].size] = e;
        }
    }
}

// Namespace namespace_3dfeef6
// Params 1, eflags: 0x1 linked
// Checksum 0x84259e10, Offset: 0x2da8
// Size: 0x6c
function function_5a53d129(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    if (isdefined(self.var_1687ae46)) {
        return;
    }
    self.var_1687ae46 = 1;
    if (localclientnum != 0) {
        return;
    }
    self thread function_e80f1a40(localclientnum);
}

// Namespace namespace_3dfeef6
// Params 1, eflags: 0x1 linked
// Checksum 0x4a6c83b4, Offset: 0x2e20
// Size: 0x54
function function_76faa4d1(var_cb15dba5) {
    setsaveddvar("phys_buoyancy", 1);
    level thread function_ff327069();
    thread function_4d36d07e();
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0x9a8e1205, Offset: 0x2e80
// Size: 0x152
function function_904eea0() {
    level._effect["sticky_grenade_zm_fx"] = "maps/zombie/fx_zmb_wall_buy_pistol";
    level._effect["frag_grenade_zm_fx"] = "maps/zombie/fx_zmb_wall_buy_pistol";
    level._effect["pdw57_zm_fx"] = "maps/zombie/fx_zmb_wall_buy_rifle";
    level._effect["870mcs_zm_fx"] = "maps/zombie/fx_zmb_wall_buy_rifle";
    level._effect["ak74u_zm_fx"] = "maps/zombie/fx_zmb_wall_buy_rifle";
    level._effect["beretta93r_zm_fx"] = "maps/zombie/fx_zmb_wall_buy_pistol";
    level._effect["bowie_knife_zm_fx"] = "maps/zombie/fx_zmb_wall_buy_rifle";
    level._effect["claymore_zm_fx"] = "maps/zombie/fx_zmb_wall_buy_rifle";
    level._effect["m14_zm_fx"] = "maps/zombie/fx_zmb_wall_buy_rifle";
    level._effect["m16_zm_fx"] = "maps/zombie/fx_zmb_wall_buy_rifle";
    level._effect["mp5k_zm_fx"] = "maps/zombie/fx_zmb_wall_buy_rifle";
    level._effect["rottweil72_zm_fx"] = "maps/zombie/fx_zmb_wall_buy_rifle";
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0xf0cf972d, Offset: 0x2fe0
// Size: 0x24
function include_weapons() {
    zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_temple_weapons.csv", 1);
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x0
// Checksum 0x9378f69e, Offset: 0x3010
// Size: 0xb4
function function_204811f8() {
    level._custom_box_monitor = &function_3c7f29df;
    level.var_bea700d2 = array("waterfall_upper_chest", "blender_chest", "pressure_chest", "bridge_chest", "caves_water_chest", "power_chest", "caves1_chest", "caves2_chest", "caves3_chest");
    callback::on_localclient_connect(&function_9a2369f);
    level.var_70c3435f = [];
    level.initialized = [];
}

// Namespace namespace_3dfeef6
// Params 1, eflags: 0x1 linked
// Checksum 0xcaa523bd, Offset: 0x30d0
// Size: 0x15e
function function_9a2369f(clientnum) {
    structs = struct::get_array("magic_box_indicator", "targetname");
    for (i = 0; i < structs.size; i++) {
        s = structs[i];
        if (!isdefined(s.viewmodels)) {
            s.viewmodels = [];
        }
        s.viewmodels[clientnum] = undefined;
    }
    level.initialized[clientnum] = 1;
    keys = getarraykeys(level.var_70c3435f);
    for (i = 0; i < keys.size; i++) {
        key = keys[i];
        state = level.var_70c3435f[key];
        function_3c7f29df(i, state, "");
    }
}

// Namespace namespace_3dfeef6
// Params 3, eflags: 0x1 linked
// Checksum 0xd035772c, Offset: 0x3238
// Size: 0xd6
function function_3c7f29df(clientnum, state, oldstate) {
    if (!isdefined(level.initialized[clientnum])) {
        level.var_70c3435f[clientnum] = state;
        return;
    }
    switch (state) {
    case 82:
        function_15a486b0(clientnum);
        break;
    case 83:
        level thread function_c659d0bd(clientnum);
        break;
    default:
        level notify("location_set" + clientnum);
        function_cda1bc07(clientnum, state);
        break;
    }
}

// Namespace namespace_3dfeef6
// Params 2, eflags: 0x1 linked
// Checksum 0x18d4db40, Offset: 0x3318
// Size: 0x64
function function_4e819b81(clientnum, location) {
    structs = struct::get_array(location, "script_noteworthy");
    array::thread_all(structs, &function_4f280c4f, clientnum, undefined);
}

// Namespace namespace_3dfeef6
// Params 1, eflags: 0x1 linked
// Checksum 0x823894bf, Offset: 0x3388
// Size: 0x6e
function function_b6aeb22c(clientnum) {
    for (i = 0; i < level.var_bea700d2.size; i++) {
        location = level.var_bea700d2[i];
        function_4e819b81(clientnum, location);
    }
}

// Namespace namespace_3dfeef6
// Params 2, eflags: 0x1 linked
// Checksum 0xc9175078, Offset: 0x3400
// Size: 0x6c
function function_f1577db3(clientnum, location) {
    structs = struct::get_array(location, "script_noteworthy");
    array::thread_all(structs, &function_4f280c4f, clientnum, "zt_map_knife");
}

// Namespace namespace_3dfeef6
// Params 2, eflags: 0x1 linked
// Checksum 0x1be4a054, Offset: 0x3478
// Size: 0x44
function function_cda1bc07(clientnum, location) {
    function_b6aeb22c(clientnum);
    function_f1577db3(clientnum, location);
}

// Namespace namespace_3dfeef6
// Params 2, eflags: 0x1 linked
// Checksum 0x9a13c482, Offset: 0x34c8
// Size: 0xd4
function function_4f280c4f(clientnum, viewmodel) {
    if (isdefined(self.viewmodels[clientnum])) {
        self.viewmodels[clientnum] delete();
        self.viewmodels[clientnum] = undefined;
    }
    if (isdefined(viewmodel)) {
        self.viewmodels[clientnum] = spawn(clientnum, self.origin, "script_model");
        self.viewmodels[clientnum].angles = self.angles;
        self.viewmodels[clientnum] setmodel(viewmodel);
    }
}

// Namespace namespace_3dfeef6
// Params 1, eflags: 0x1 linked
// Checksum 0x40261e40, Offset: 0x35a8
// Size: 0x9c
function function_c659d0bd(clientnum) {
    level endon("location_set" + clientnum);
    index = 0;
    while (true) {
        location = level.var_bea700d2[index];
        function_cda1bc07(clientnum, location);
        index++;
        if (index >= level.var_bea700d2.size) {
            index = 0;
        }
        wait(0.25);
    }
}

// Namespace namespace_3dfeef6
// Params 1, eflags: 0x1 linked
// Checksum 0x64276a61, Offset: 0x3650
// Size: 0x6e
function function_15a486b0(clientnum) {
    for (i = 0; i < level.var_bea700d2.size; i++) {
        location = level.var_bea700d2[i];
        function_f1577db3(clientnum, location);
    }
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0x3773a9bd, Offset: 0x36c8
// Size: 0x96
function function_ff327069() {
    local_players = getlocalplayers();
    for (index = 0; index < local_players.size; index++) {
        val = clientfield::get("papspinners");
        level function_455a41fb(index, level.var_e34b793e);
    }
}

// Namespace namespace_3dfeef6
// Params 7, eflags: 0x1 linked
// Checksum 0xe40b666b, Offset: 0x3768
// Size: 0x7c
function function_9fe44296(clientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    level.var_e34b793e = newval;
    getlocalplayers()[clientnum] function_455a41fb(clientnum, level.var_e34b793e);
}

// Namespace namespace_3dfeef6
// Params 2, eflags: 0x1 linked
// Checksum 0x42774a11, Offset: 0x37f0
// Size: 0x6c
function power(base, exp) {
    assert(exp >= 0);
    if (exp == 0) {
        return 1;
    }
    return base * power(base, exp - 1);
}

// Namespace namespace_3dfeef6
// Params 2, eflags: 0x1 linked
// Checksum 0x6a849ca1, Offset: 0x3868
// Size: 0x2b6
function function_455a41fb(clientnum, num) {
    println("zm_ai_screecher_blur" + clientnum + "zm_ai_screecher_blur" + num);
    if (!isdefined(level.var_1dfcee77)) {
        level function_2462b329(clientnum);
    } else if (!isdefined(level.var_1dfcee77[clientnum])) {
        level function_2462b329(clientnum);
    }
    for (i = 3; i >= 0; i--) {
        println("zm_ai_screecher_blur" + i + "zm_ai_screecher_blur" + clientnum);
        assert(isdefined(level.var_1dfcee77));
        assert(isdefined(level.var_1dfcee77[clientnum]));
        assert(isdefined(level.var_1dfcee77[clientnum][i]));
        pow = power(2, i);
        if (num >= pow) {
            num -= pow;
            println("zm_ai_screecher_blur" + clientnum + "zm_ai_screecher_blur" + i + "zm_ai_screecher_blur" + level.var_1dfcee77[clientnum][i].size);
            array::thread_all(level.var_1dfcee77[clientnum][i], &function_a445d032);
            continue;
        }
        println("zm_ai_screecher_blur" + clientnum + "zm_ai_screecher_blur" + i + "zm_ai_screecher_blur" + level.var_1dfcee77[clientnum][i].size);
        array::thread_all(level.var_1dfcee77[clientnum][i], &function_ee245ed9);
    }
}

// Namespace namespace_3dfeef6
// Params 2, eflags: 0x1 linked
// Checksum 0xa0f8291f, Offset: 0x3b28
// Size: 0xe6
function function_60f46de3(localclientnum, active) {
    if (!isdefined(self.var_4aaa522f)) {
        self function_f2bd87d8(localclientnum);
    }
    var_4aaa522f = self.var_4aaa522f;
    if (isdefined(var_4aaa522f)) {
        for (i = 0; i < var_4aaa522f.size; i++) {
            playsound = i == 0;
            var_4aaa522f[i] thread function_ce3590d(localclientnum);
            var_4aaa522f[i] thread function_644db2c0(localclientnum, active, playsound);
        }
    }
}

// Namespace namespace_3dfeef6
// Params 1, eflags: 0x1 linked
// Checksum 0x4953e3be, Offset: 0x3c18
// Size: 0x150
function function_f2bd87d8(localclientnum) {
    var_a22a6aac = getentarray(localclientnum, "spear_trap_spear", "targetname");
    self.var_4aaa522f = [];
    for (i = 0; i < var_a22a6aac.size; i++) {
        var_f97ee2c = var_a22a6aac[i];
        if (isdefined(var_f97ee2c.assigned) && var_f97ee2c.assigned) {
            continue;
        }
        delta = abs(self.origin[0] - var_f97ee2c.origin[0]);
        if (abs(self.origin[0] - var_f97ee2c.origin[0]) < 21) {
            var_f97ee2c.assigned = 1;
            self.var_4aaa522f[self.var_4aaa522f.size] = var_f97ee2c;
        }
    }
}

// Namespace namespace_3dfeef6
// Params 1, eflags: 0x1 linked
// Checksum 0xea4e7c42, Offset: 0x3d70
// Size: 0x80
function function_ce3590d(localclientnum) {
    if (!isdefined(self.init) || !self.init) {
        self.var_1617fc4a = 90;
        self.var_2b36a3e4 = 120;
        self.start = self.origin;
        self.movedir = -1 * anglestoright(self.angles);
        self.init = 1;
    }
}

// Namespace namespace_3dfeef6
// Params 3, eflags: 0x1 linked
// Checksum 0x6b491da0, Offset: 0x3df8
// Size: 0x1bc
function function_644db2c0(localclientnum, active, playsound) {
    if (active) {
        if (playsound) {
            sound::play_in_space(0, "evt_spiketrap_warn", self.origin);
        }
        movedist = randomfloatrange(self.var_1617fc4a, self.var_2b36a3e4);
        endpos = self.start + self.movedir * movedist;
        playfx(localclientnum, level._effect["punji_dust"], endpos);
        playsound(0, "evt_spiketrap", self.origin);
        movetime = randomfloatrange(0.08, 0.22);
        self moveto(endpos, movetime);
        return;
    }
    if (playsound) {
        playsound(0, "evt_spiketrap_retract", self.origin);
    }
    movetime = randomfloatrange(0.1, 0.2);
    self moveto(self.start, movetime);
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0xf709c5b6, Offset: 0x3fc0
// Size: 0xbc
function function_4d36d07e() {
    boards = [];
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        boards = arraycombine(boards, getentarray(i, "plank_water", "targetname"), 1, 0);
    }
    array::thread_all(boards, &function_3fdbf57c);
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0x8e3d1ea9, Offset: 0x4088
// Size: 0x7c
function function_3fdbf57c() {
    wait(randomfloat(1));
    self.start_origin = self.origin;
    self.start_angles = self.angles;
    self.var_38b442c7 = self.origin;
    self thread function_809c17e3();
    self thread function_bcd32a9f();
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0xd75907c5, Offset: 0x4110
// Size: 0x134
function function_809c17e3() {
    dist = randomfloatrange(2.5, 3);
    movetime = randomfloatrange(3.5, 4.5);
    minz = self.start_origin[2] - dist;
    maxz = self.start_origin[2] + dist;
    while (true) {
        var_fdb5c190 = minz - self.origin[2];
        self movez(var_fdb5c190, movetime);
        self waittill(#"movedone");
        var_fdb5c190 = maxz - self.origin[2];
        self movez(var_fdb5c190, movetime);
        self waittill(#"movedone");
    }
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0xafe5cdfc, Offset: 0x4250
// Size: 0x84
function function_bcd32a9f() {
    while (true) {
        yaw = randomfloatrange(-360, 360);
        self rotateyaw(yaw, randomfloatrange(60, 90));
        self waittill(#"rotatedone");
    }
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x0
// Checksum 0xaa01b0ac, Offset: 0x42e0
// Size: 0x168
function function_e8267079() {
    dist = randomfloatrange(20, 30);
    movetime = randomfloatrange(5, 10);
    while (true) {
        yaw = randomfloatrange(0, 360);
        var_bd2a1673 = anglestoforward((0, yaw, 0));
        var_246f2529 = self.start_origin + var_bd2a1673 * dist;
        var_49bab662 = var_246f2529[0] - self.origin[0];
        self movex(var_49bab662, movetime);
        var_6fbd30cb = var_246f2529[1] - self.origin[1];
        self movey(var_6fbd30cb, movetime);
    }
}

// Namespace namespace_3dfeef6
// Params 1, eflags: 0x1 linked
// Checksum 0xf3f1697a, Offset: 0x4450
// Size: 0x186
function function_2462b329(var_6870ff1c) {
    if (!isdefined(level.var_1dfcee77)) {
        level.var_1dfcee77 = [];
    }
    if (level.var_1dfcee77.size <= var_6870ff1c) {
        level.var_1dfcee77[level.var_1dfcee77.size] = array([], [], [], []);
    }
    println("zm_ai_screecher_blur" + var_6870ff1c + "zm_ai_screecher_blur");
    for (i = 0; i < level.var_1dfcee77[var_6870ff1c].size; i++) {
        var_1dfcee77 = getentarray(var_6870ff1c, "pap_spinner" + i + 1, "targetname");
        println("zm_ai_screecher_blur" + var_6870ff1c + "zm_ai_screecher_blur" + i + "zm_ai_screecher_blur" + var_1dfcee77.size);
        array::thread_all(var_1dfcee77, &function_99b87681, i + 1);
        level.var_1dfcee77[var_6870ff1c][i] = var_1dfcee77;
    }
}

// Namespace namespace_3dfeef6
// Params 1, eflags: 0x1 linked
// Checksum 0x2edeb659, Offset: 0x45e0
// Size: 0x88
function function_99b87681(var_f2ec6edf) {
    self.var_17ffadc4 = var_f2ec6edf;
    self.startangles = self.angles;
    self.var_c7af3f91 = "evt_pap_spinner0" + var_f2ec6edf;
    self.var_40d8300 = "evt_pap_timer_stop";
    self.angles = (0, 90 * (var_f2ec6edf - 1) + randomfloatrange(10, 80), 0);
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0x997de786, Offset: 0x4670
// Size: 0x104
function function_ee245ed9() {
    if (!level.power) {
        return;
    }
    if (isdefined(self.var_ee245ed9) && self.var_ee245ed9) {
        return;
    }
    self.var_ee245ed9 = 1;
    self.var_a445d032 = 0;
    self notify(#"hash_b1727ec2");
    self endon(#"death");
    self endon(#"hash_b1727ec2");
    var_ff4aae8e = self function_da0f1a90();
    self function_dd5883b5();
    self rotateyaw(360, var_ff4aae8e, 0.25);
    self waittill(#"rotatedone");
    while (true) {
        self rotateyaw(360, var_ff4aae8e);
        self waittill(#"rotatedone");
    }
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0x3fae0767, Offset: 0x4780
// Size: 0x78
function function_da0f1a90() {
    var_ff4aae8e = 1.7;
    if (self.var_17ffadc4 == 2) {
        var_ff4aae8e = 1.5;
    } else if (self.var_17ffadc4 == 3) {
        var_ff4aae8e = 1.2;
    } else if (self.var_17ffadc4 == 4) {
        var_ff4aae8e = 0.8;
    }
    return var_ff4aae8e;
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0x38b2207f, Offset: 0x4800
// Size: 0x16c
function function_a445d032() {
    if (!level.power) {
        return;
    }
    if (isdefined(self.var_a445d032) && self.var_a445d032) {
        return;
    }
    self.var_ee245ed9 = 0;
    self.var_a445d032 = 1;
    self notify(#"hash_b1727ec2");
    self endon(#"death");
    self endon(#"hash_b1727ec2");
    var_46cda0f5 = self.startangles[1];
    currentyaw = self.angles[1];
    for (deltayaw = var_46cda0f5 - currentyaw; deltayaw < 0; deltayaw += 360) {
    }
    var_ff4aae8e = self function_da0f1a90();
    var_ff4aae8e *= deltayaw / 360;
    if (var_ff4aae8e > 0) {
        self rotateyaw(deltayaw, var_ff4aae8e, 0);
        self waittill(#"rotatedone");
    }
    self function_ee1c6a2f();
    self.angles = self.startangles;
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0x39eb210f, Offset: 0x4978
// Size: 0x2c
function function_dd5883b5() {
    self.var_3539b4ec = self playloopsound(self.var_c7af3f91);
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0xc60f5d95, Offset: 0x49b0
// Size: 0x54
function function_ee1c6a2f() {
    if (isdefined(self.var_3539b4ec)) {
        self stoploopsound(self.var_3539b4ec, 0.1);
    }
    self playsound(0, self.var_40d8300);
}

// Namespace namespace_3dfeef6
// Params 0, eflags: 0x1 linked
// Checksum 0x48cf36bd, Offset: 0x4a10
// Size: 0x1b8
function function_ae718896() {
    if (!level clientfield::get("zombie_power_on")) {
        level waittill(#"zpo");
    }
    wait(4.5);
    level notify(#"hash_a39e7bd2");
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        var_a4944e4c = getentarray(i, "model_lights_on", "targetname");
        for (x = 0; x < var_a4944e4c.size; x++) {
            light = var_a4944e4c[x];
            if (isdefined(light.script_string)) {
                light setmodel(light.script_string);
                continue;
            }
            if (light.model == "p_ztem_power_hanging_light_off") {
                light setmodel("p_ztem_power_hanging_light");
                continue;
            }
            if (light.model == "p_lights_cagelight02_off") {
                light setmodel("p_lights_cagelight02_on");
            }
        }
    }
}

// Namespace namespace_3dfeef6
// Params 7, eflags: 0x1 linked
// Checksum 0xd7593ac4, Offset: 0x4bd0
// Size: 0x5c
function ragdoll_impact_watch_start(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self thread ragdoll_impact_watch(localclientnum);
    }
}

// Namespace namespace_3dfeef6
// Params 1, eflags: 0x1 linked
// Checksum 0x659fd91e, Offset: 0x4c38
// Size: 0x1c6
function ragdoll_impact_watch(localclientnum) {
    self endon(#"entityshutdown");
    waittime = 0.016;
    var_e19d938a = 500;
    prevorigin = self.origin;
    wait(waittime);
    var_fa5a6167 = self.origin - prevorigin;
    var_3343e457 = length(var_fa5a6167);
    prevorigin = self.origin;
    wait(waittime);
    var_cf19f96b = 1;
    while (true) {
        vel = self.origin - prevorigin;
        speed = length(vel);
        if (speed < var_3343e457 * 0.5 && var_3343e457 > var_e19d938a * waittime) {
            dir = vectornormalize(var_fa5a6167);
            self function_8c38a9bd(localclientnum, dir);
            break;
        }
        if (var_3343e457 < var_e19d938a * waittime && !var_cf19f96b) {
            break;
        }
        prevorigin = self.origin;
        var_fa5a6167 = vel;
        var_3343e457 = speed;
        var_cf19f96b = 0;
        wait(waittime);
    }
}

// Namespace namespace_3dfeef6
// Params 2, eflags: 0x1 linked
// Checksum 0x124c3f6e, Offset: 0x4e08
// Size: 0x64
function function_8c38a9bd(localclientnum, hitdir) {
    if (util::is_mature()) {
        playfx(localclientnum, level._effect["rag_doll_gib_mini"], self.origin, hitdir * -1);
    }
}

// Namespace namespace_3dfeef6
// Params 7, eflags: 0x1 linked
// Checksum 0x71ac668e, Offset: 0x4e78
// Size: 0xe4
function function_bfe7237e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    player = getlocalplayers()[localclientnum];
    if (player getentitynumber() != self getentitynumber()) {
        return;
    }
    if (newval) {
        self thread function_7ddf62e1(localclientnum);
        return;
    }
    self notify(#"hash_efc0320f");
    self stoprumble(localclientnum, "slide_rumble");
}

// Namespace namespace_3dfeef6
// Params 1, eflags: 0x1 linked
// Checksum 0x36e38c48, Offset: 0x4f68
// Size: 0x48
function function_7ddf62e1(var_7343ea0b) {
    self endon(#"hash_efc0320f");
    while (isdefined(self)) {
        self playrumbleonentity(var_7343ea0b, "slide_rumble");
        wait(0.05);
    }
}

// Namespace namespace_3dfeef6
// Params 7, eflags: 0x1 linked
// Checksum 0x2c7038a1, Offset: 0x4fb8
// Size: 0xdc
function function_425904c0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        player = getlocalplayer(localclientnum);
        if (self == player) {
            self playrumblelooponentity(localclientnum, "tank_rumble");
        }
        return;
    }
    player = getlocalplayer(localclientnum);
    if (self == player) {
        self stoprumble(localclientnum, "tank_rumble");
    }
}

