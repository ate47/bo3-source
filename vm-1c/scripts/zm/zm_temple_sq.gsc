#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_weap_shrink_ray;
#using scripts/zm/zm_temple_sq_bag;
#using scripts/zm/zm_temple_sq_brock;
#using scripts/zm/zm_temple_sq_bttp;
#using scripts/zm/zm_temple_sq_bttp2;
#using scripts/zm/zm_temple_sq_dgcwf;
#using scripts/zm/zm_temple_sq_lgs;
#using scripts/zm/zm_temple_sq_oafc;
#using scripts/zm/zm_temple_sq_ptt;
#using scripts/zm/zm_temple_sq_skits;
#using scripts/zm/zm_temple_sq_std;

#namespace zm_temple_sq;

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x19e9b9e7, Offset: 0x9b8
// Size: 0x674
function init() {
    level flag::init("pap_override");
    level flag::init("radio_9_played");
    level flag::init("gongs_resonating");
    level flag::init("trap_destroyed");
    level flag::init("radio_7_played");
    level flag::init("meteorite_shrunk");
    level flag::init("doing_bounce_around");
    level.var_5c940024 = [];
    level.var_5c940024[1] = array(2, 4, 3, 5, 6, "R");
    level.var_5c940024[2] = array(1, 2, 3, 4, 1, "R");
    level.var_5c940024[3] = array(4, 3, 1, 3, 5, "R");
    level.var_5c940024[4] = array(1, 3, 2, 6, 5, "R");
    level.var_5c940024[5] = array(6, 5, 6, 1, 3, 5, "R");
    level.var_5c940024[6] = array(5, 6, 1, 4, 2, 1, 3, "M");
    var_81c48749 = getentarray("sq_gong", "targetname");
    foreach (var_3e9e1b32 in var_81c48749) {
        var_3e9e1b32.script_vector = (0, 0, 40);
    }
    zm_temple_sq_brock::init();
    zm_temple_sq_skits::function_2387a156();
    namespace_6e97c459::function_f59cfc65("sq", &function_bb41e83b, undefined, &function_e4eeb8b4, &function_c1d310ea, &function_182a03f);
    namespace_6e97c459::function_93b970b8("sq", "sq_sundial", &function_20359a78);
    namespace_6e97c459::function_93b970b8("sq", "sq_sundial_button", &function_f0b40ff2);
    namespace_6e97c459::function_93b970b8("sq", "sq_ptt_dial", &function_a63b1e99);
    namespace_6e97c459::function_93b970b8("sq", "sq_bttp2_dial", &function_44229e01);
    namespace_6e97c459::function_93b970b8("sq", "sq_spiketrap");
    namespace_6e97c459::function_f1e70f21("sq", "sq_crystals", &function_251b8f40);
    namespace_6e97c459::function_93b970b8("sq", "sq_gong", &function_b4c87a43, &function_6ad41e2e);
    zm_temple_sq_oafc::init();
    zm_temple_sq_dgcwf::init();
    zm_temple_sq_lgs::init();
    zm_temple_sq_ptt::init();
    zm_temple_sq_std::init();
    zm_temple_sq_bttp::init();
    zm_temple_sq_bttp2::init();
    zm_temple_sq_bag::init();
    level.var_c5defb4b = 0;
    function_7ada93b1();
    trig = getent("sq_dgcwf_trig", "targetname");
    trig triggerenable(0);
    /#
        level thread function_6f079a19();
        level thread function_d5125f67();
        level thread function_e63287bf();
    #/
    level thread function_b210b5b();
    level.var_93582a5d = array("specialty_armorvest", "specialty_quickrevive", "specialty_fastreload", "specialty_doubletap2", "specialty_staminup", "specialty_widowswine", "specialty_deadshot", "specialty_additionalprimaryweapon");
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x5467cfb, Offset: 0x1038
// Size: 0x94
function init_clientfield() {
    namespace_6e97c459::function_225a92d6("vril", 21000);
    namespace_6e97c459::function_225a92d6("dynamite", 21000);
    namespace_6e97c459::function_225a92d6("anti115", 21000);
    clientfield::register("scriptmover", "meteor_shrink", 21000, 1, "counter");
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0xc902fcce, Offset: 0x10d8
// Size: 0xb6
function function_7ada93b1() {
    var_6c1012a9 = getentarray("sq_gong", "targetname");
    var_6c1012a9 = array::randomize(var_6c1012a9);
    for (i = 0; i < var_6c1012a9.size; i++) {
        if (i < 4) {
            var_6c1012a9[i].var_4a3ea713 = 1;
            continue;
        }
        var_6c1012a9[i].var_4a3ea713 = 0;
    }
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0xf2c35c49, Offset: 0x1198
// Size: 0x126
function function_1ec8e68b() {
    self endon(#"disconnect");
    while (true) {
        self waittill(#"spawned_player");
        waittillframeend();
        self namespace_6e97c459::function_f72f765e("sq", "anti115");
        foreach (perk in level.var_93582a5d) {
            if (!self hasperk(perk)) {
                if (zm_perks::function_23ee6fc() && perk == "specialty_quickrevive") {
                    continue;
                }
                self zm_perks::give_perk(perk);
            }
        }
    }
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x88dc46dc, Offset: 0x12c8
// Size: 0xec
function reward() {
    level notify(#"hash_78ab33de");
    self namespace_6e97c459::function_f72f765e("sq", "anti115");
    for (i = 0; i < level.var_93582a5d.size; i++) {
        if (!self hasperk(level.var_93582a5d[i])) {
            self playsound("evt_sq_bag_gain_perks");
            self zm_perks::give_perk(level.var_93582a5d[i]);
            wait 0.25;
        }
    }
    self.var_7fceabe1 = 1;
    self thread function_1ec8e68b();
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0xed6d0ba8, Offset: 0x13c0
// Size: 0x76
function function_d5125f67() {
    while (0 == getdvarint("scr_raise_crystals")) {
        wait 0.1;
    }
    level notify(#"hash_15ab69d8");
    level notify(#"hash_87b2d913");
    level notify(#"hash_61b05eaa");
    level notify(#"hash_d3b7cde5");
    level notify(#"hash_adb5537c");
    level notify(#"hash_1fbcc2b7");
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0xf069eb71, Offset: 0x1440
// Size: 0x172
function function_b210b5b() {
    if (isdefined(level.var_18a00be6)) {
        return;
    }
    level.var_18a00be6 = 1;
    level thread function_503b7aa9();
    while (true) {
        level flag::wait_till("gongs_resonating");
        for (i = 0; i < level.var_15ea76e6.size; i++) {
            if (level.var_15ea76e6[i]) {
                str_exploder = "fxexp_50" + i + 1;
                exploder::exploder(str_exploder);
                util::wait_network_frame();
            }
        }
        while (level flag::get("gongs_resonating")) {
            wait 0.1;
        }
        for (i = 0; i < level.var_15ea76e6.size; i++) {
            str_exploder = "fxexp_50" + i + 1;
            exploder::stop_exploder(str_exploder);
            util::wait_network_frame();
        }
    }
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x20899caf, Offset: 0x15c0
// Size: 0x132
function function_503b7aa9() {
    while (true) {
        level waittill(#"hash_e2cfa6d0");
        for (i = 0; i < level.var_15ea76e6.size; i++) {
            if (level.var_15ea76e6[i]) {
                str_exploder = "fxexp_51" + i + 1;
                exploder::exploder(str_exploder);
                util::wait_network_frame();
            }
        }
        wait 1;
        level flag::clear("gongs_resonating");
        wait 6;
        for (i = 0; i < level.var_15ea76e6.size; i++) {
            str_exploder = "fxexp_51" + i + 1;
            exploder::stop_exploder(str_exploder);
            util::wait_network_frame();
        }
    }
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0xf0e2b83e, Offset: 0x1700
// Size: 0xe0
function function_6f079a19() {
    level endon(#"end_game");
    setdvar("scr_force_eclipse", 0);
    level waittill(#"start_zombie_round_logic");
    while (true) {
        while (0 == getdvarint("scr_force_eclipse")) {
            wait 0.1;
        }
        function_262fe732();
        function_ea122a69();
        while (1 == getdvarint("scr_force_eclipse")) {
            wait 0.1;
        }
        function_701bca();
        function_9db048d0();
    }
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x775a2632, Offset: 0x17e8
// Size: 0x124
function function_6ad41e2e() {
    if (isdefined(self.var_bbca234) && isdefined(self.var_bbca234.target)) {
        self.var_bbca234.var_4ba5f5f1 = getent(self.var_bbca234.target, "targetname");
        self.var_bbca234.var_4ba5f5f1.takedamage = 1;
    } else {
        return;
    }
    while (true) {
        self.var_bbca234.var_4ba5f5f1 waittill(#"damage", amount, attacker, dir, point, mod);
        if (isplayer(attacker) && mod == "MOD_MELEE") {
            self.var_bbca234 notify(#"triggered", attacker);
        }
    }
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0xe290c461, Offset: 0x1918
// Size: 0x1c
function function_b4c87a43() {
    self thread zm_temple_sq_bag::function_8cadb8d9();
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x4421ff6b, Offset: 0x1940
// Size: 0x1c
function function_a63b1e99() {
    self thread zm_temple_sq_ptt::function_fbbc8808();
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0xfbd75cdd, Offset: 0x1968
// Size: 0x34
function function_44229e01() {
    self.trigger triggerignoreteam();
    self thread zm_temple_sq_bttp2::function_fbbc8808();
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x8f7edd95, Offset: 0x19a8
// Size: 0x4c
function function_885a7581() {
    function_9db048d0();
    level flag::wait_till("initial_players_connected");
    namespace_6e97c459::function_d9be8a5b("sq");
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x720bcb4e, Offset: 0x1a00
// Size: 0x3c
function function_c11347b4() {
    level endon(#"hash_bc01cbc3");
    level waittill(#"hash_1ac5373b");
    wait 0.1;
    self thread function_20359a78();
}

// Namespace zm_temple_sq
// Params 2, eflags: 0x0
// Checksum 0xca474b14, Offset: 0x1a48
// Size: 0xe4
function function_ecc9a32(duration, multiplier) {
    if (!isdefined(duration)) {
        duration = 2;
    }
    if (!isdefined(multiplier)) {
        multiplier = 1.3;
    }
    for (var_c5605c0f = 0.1; var_c5605c0f < duration; var_c5605c0f *= multiplier) {
        self playloopsound("evt_sq_gen_sundial_spin", 0.5);
        self rotatepitch(-76, var_c5605c0f);
        wait var_c5605c0f * 0.95;
    }
    self stoploopsound(2);
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0xabb7d52b, Offset: 0x1b38
// Size: 0x24
function function_82fca959() {
    function_ecc9a32(1, 1.6);
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0xb90e20d2, Offset: 0x1b68
// Size: 0x478
function function_20359a78() {
    level endon(#"hash_1ac5373b");
    level endon(#"end_game");
    self.var_681c1b20 = 1;
    self thread function_c11347b4();
    if (!isdefined(self.original_pos)) {
        self.original_pos = self.origin - anglestoup(self.angles);
        self.var_eaa97957 = self.original_pos - anglestoup(self.angles) * 34;
    }
    self.origin = self.var_eaa97957;
    level.var_cfcfda61 = 0;
    level.var_17714997 = 0;
    level.var_ad272545 = 0;
    level flag::wait_till("power_on");
    level notify(#"hash_1f64531f");
    wait 0.05;
    buttons = getentarray("sq_sundial_button", "targetname");
    array::thread_all(buttons, &function_f0b40ff2);
    while (true) {
        while (level.var_cfcfda61 < 4) {
            wait 0.1;
        }
        level.var_ad272545 = 1;
        self playsound("evt_sq_gen_transition_start");
        self playsound("evt_sq_gen_sundial_emerge");
        self moveto(self.original_pos, 0.25);
        self waittill(#"movedone");
        self thread function_ecc9a32();
        wait 0.5;
        stage = namespace_6e97c459::function_513e3f2a("sq");
        level notify(#"hash_187891f8");
        amount = 8.5;
        level waittill(#"hash_5102f256");
        self playsound("evt_sq_gen_sundial_timer");
        self moveto(self.origin - anglestoup(self.angles) * amount, 1);
        self thread function_82fca959();
        level waittill(#"hash_c466afcd");
        self playsound("evt_sq_gen_sundial_timer");
        self moveto(self.origin - anglestoup(self.angles) * amount, 1);
        self thread function_82fca959();
        level waittill(#"hash_643b1d89");
        self playsound("evt_sq_gen_sundial_timer");
        self moveto(self.origin - anglestoup(self.angles) * amount, 1);
        self thread function_82fca959();
        level waittill(#"hash_b455418");
        self thread function_5d2ebf02();
        self moveto(self.origin - anglestoup(self.angles) * amount, 10);
        self thread function_ecc9a32();
        self waittill(#"movedone");
        level.var_ad272545 = 0;
        wait 0.1;
    }
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0xfd4123c9, Offset: 0x1fe8
// Size: 0x56
function function_5d2ebf02() {
    level endon(#"hash_22750029");
    level endon(#"hash_1ac5373b");
    while (level.var_ad272545 == 1) {
        self playsound("evt_sq_gen_sundial_timer");
        wait 1;
    }
}

// Namespace zm_temple_sq
// Params 2, eflags: 0x0
// Checksum 0x6401f6fa, Offset: 0x2048
// Size: 0xa2
function function_1523fda0(who, buttons) {
    /#
        if (getplayers().size < 4) {
            return false;
        }
    #/
    for (i = 0; i < buttons.size; i++) {
        if (isdefined(buttons[i].var_f6dc8eff) && buttons[i].var_f6dc8eff == who) {
            return true;
        }
    }
    return false;
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x3698ea7d, Offset: 0x20f8
// Size: 0x3a8
function function_f0b40ff2() {
    level endon(#"hash_187891f8");
    level endon(#"hash_1f64531f");
    if (!isdefined(self.var_681c1b20)) {
        self.var_681c1b20 = 1;
        self.var_bbf92e7d = self.origin - anglestoup(self.angles);
        self.var_eaa97957 = self.var_bbf92e7d - anglestoup(self.angles) * 5.5;
        self moveto(self.var_eaa97957, 0.01);
    }
    if (isdefined(self.trigger)) {
        self.trigger delete();
        self.trigger = undefined;
    }
    self.var_f6dc8eff = undefined;
    level flag::wait_till("power_on");
    self moveto(self.var_bbf92e7d, 0.25);
    wait 0.25;
    buttons = getentarray("sq_sundial_button", "targetname");
    offset = anglestoforward(self.angles) * 5 - (0, 0, 16);
    self.trigger = spawn("trigger_radius_use", self.var_bbf92e7d + offset, 0, 48, 32);
    self.trigger triggerignoreteam();
    self.trigger.radius = 48;
    self.trigger setcursorhint("HINT_NOICON");
    while (true) {
        self.trigger waittill(#"trigger", who);
        if (function_1523fda0(who, buttons)) {
            continue;
        }
        if (!level.var_17714997 && level.var_305d1f14) {
            self.var_f6dc8eff = who;
            level.var_cfcfda61++;
            self playsound("evt_sq_gen_button");
            self moveto(self.var_eaa97957, 0.25);
            delay = 1;
            /#
                if (getplayers().size == 1 || getdvarint("<dev string:x28>") == 2) {
                    delay = 10;
                }
            #/
            wait delay;
            while (level.var_ad272545) {
                wait 0.1;
            }
            self.var_f6dc8eff = undefined;
            self moveto(self.var_bbf92e7d, 0.25);
            if (level.var_cfcfda61 > 0) {
                level.var_cfcfda61--;
            }
        }
    }
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0xcf997d36, Offset: 0x24a8
// Size: 0xa6
function function_7a325b14() {
    var_6c1012a9 = getentarray("sq_gong", "targetname");
    var_6c1012a9 = array::randomize(var_6c1012a9);
    for (i = 0; i < var_6c1012a9.size; i++) {
        name = "gong" + i;
        var_6c1012a9[i].animname = name;
    }
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0xa1b0b6e4, Offset: 0x2558
// Size: 0x48c
function function_bb41e83b() {
    level.var_305d1f14 = 1;
    if (!isdefined(level.var_b169a849)) {
        function_701bca();
        level.var_b169a849 = 0;
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        var_8e0fe378 = players[i].characterindex;
        if (isdefined(players[i].var_62030aa3)) {
            var_8e0fe378 = players[i].var_62030aa3;
        }
        if (var_8e0fe378 == 3 && zm::is_sidequest_previously_completed("COTD")) {
            players[i] namespace_6e97c459::function_f72f765e("sq", "vril", 0);
            break;
        }
    }
    zm_temple_sq_brock::function_67e052f1(1);
    function_7a325b14();
    wall = getent("sq_wall", "targetname");
    wall setmodel("p7_zm_sha_wall_temple_brick_02");
    wall solid();
    crystals = getentarray("sq_crystals", "targetname");
    level.var_15ea76e6 = [];
    for (i = 0; i < crystals.size; i++) {
        level.var_15ea76e6[i] = 0;
    }
    a_e_trap = getentarray("sq_spiketrap", "targetname");
    foreach (e_trap in a_e_trap) {
        e_trap show();
    }
    level flag::clear("radio_4_played");
    level flag::clear("radio_7_played");
    level flag::clear("radio_9_played");
    level flag::clear("meteorite_shrunk");
    var_3de6066b = getent("sq_meteorite", "targetname");
    var_3de6066b setmodel("p7_zm_sha_meteorite");
    var_3de6066b ghost();
    if (!isdefined(var_3de6066b.original_origin)) {
        var_3de6066b.original_origin = var_3de6066b.origin;
        var_3de6066b.original_angles = var_3de6066b.angles;
    }
    var_3de6066b.origin = var_3de6066b.original_origin;
    var_3de6066b.angles = var_3de6066b.original_angles;
    anti115 = getent("sq_anti_115", "targetname");
    anti115 show();
    level thread pap_watcher();
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x7e47d81, Offset: 0x29f0
// Size: 0xd8
function pap_watcher() {
    level notify(#"hash_85f334e1");
    level endon(#"hash_85f334e1");
    while (true) {
        level flag::wait_till("pap_override");
        while (level flag::get("pack_machine_in_use")) {
            wait 0.1;
        }
        level thread function_3129bf4e();
        while (level flag::get("pap_override")) {
            wait 0.1;
        }
        level thread function_b90b29ed();
    }
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0xa42aae47, Offset: 0x2ad0
// Size: 0x90
function function_ed9fb3c7() {
    level endon(#"hash_1ac5373b");
    while (true) {
        if (getdvarstring("cheat_sq") != "") {
            if (isdefined(level.var_e68ff12d)) {
                setdvar("cheat_sq", "");
                namespace_6e97c459::function_2f3ced1f("sq", level.var_e68ff12d);
            }
        }
        wait 0.1;
    }
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0xd85097b7, Offset: 0x2b68
// Size: 0x4c
function function_c1d310ea() {
    /#
        level thread function_ed9fb3c7();
    #/
    level.var_17714997 = 1;
    function_262fe732();
    function_ea122a69();
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0xf70be639, Offset: 0x2bc0
// Size: 0x3c
function function_182a03f() {
    level notify(#"hash_1ac5373b");
    level.var_17714997 = 0;
    function_701bca();
    function_9db048d0();
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x701c2270, Offset: 0x2c08
// Size: 0x3c
function function_e4eeb8b4() {
    level notify(#"hash_bc01cbc3");
    level notify(#"hash_1ac5373b");
    level notify(#"hash_1f64531f");
    level thread function_37426445();
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x9ccb71c3, Offset: 0x2c50
// Size: 0x40
function function_c4024977() {
    self endon(#"picked_up");
    while (true) {
        self rotateyaw(-76, 0.4);
        wait 0.4;
    }
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x5976c0a8, Offset: 0x2c98
// Size: 0x41c
function function_37426445() {
    wall = getent("sq_wall", "targetname");
    wall setmodel("p7_zm_sha_wall_temple_brick_02_dmg");
    wall notsolid();
    anti115 = getent("sq_anti_115", "targetname");
    anti115 thread function_c4024977();
    anti115 playloopsound("zmb_meteor_loop");
    exploder::exploder("fxexp_520");
    trigger = spawn("trigger_radius_use", anti115.origin, 0, 32, 72);
    trigger triggerignoreteam();
    trigger setcursorhint("HINT_NOICON");
    trigger.radius = 48;
    trigger.height = 72;
    while (true) {
        trigger waittill(#"trigger", who);
        if (isplayer(who) && !isdefined(who.var_54680ca)) {
            who.var_54680ca = 1;
            who playsound("zmb_meteor_activate");
            who thread reward();
            who thread zm_audio::create_and_play_dialog("eggs", "quest8", 7);
            who thread function_c1968457();
            break;
        }
        if (isplayer(who)) {
            who playsound("zmb_no_cha_ching");
        }
    }
    trigger delete();
    anti115 stoploopsound(1);
    anti115 notify(#"picked_up");
    level notify(#"picked_up");
    anti115 ghost();
    exploder::stop_exploder("fxexp_520");
    var_9ff55c5b = 0;
    for (players = getplayers(); var_9ff55c5b < players.size; players = getplayers()) {
        var_9ff55c5b = 0;
        for (i = 0; i < players.size; i++) {
            if (distance2dsquared(players[i].origin, wall.origin) > 129600) {
                var_9ff55c5b++;
            }
        }
        wait 0.1;
    }
    level flag::clear("pap_override");
    level thread function_ff72a80e();
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x7ed19a39, Offset: 0x30c0
// Size: 0x9c
function function_c1968457() {
    wait 5;
    losers = getplayers();
    arrayremovevalue(losers, self);
    if (losers.size >= 1) {
        losers[randomintrange(0, losers.size)] thread zm_audio::create_and_play_dialog("eggs", "quest8", 8);
    }
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x4bbb8a71, Offset: 0x3168
// Size: 0x37c
function function_ff72a80e() {
    var_da5d3a32 = level.var_d24533c5["sq"];
    if (var_da5d3a32.var_57800922 >= 3) {
        return;
    }
    var_da5d3a32.var_57800922++;
    level flag::wait_till("radio_9_played");
    while (level flag::get("doing_bounce_around")) {
        wait 0.1;
    }
    var_27cd5134 = getarraykeys(var_da5d3a32.stages);
    for (i = 0; i < var_27cd5134.size; i++) {
        var_da5d3a32.stages[var_27cd5134[i]].completed = 0;
    }
    var_da5d3a32.var_c5d90674 = -1;
    var_da5d3a32.var_451a400c = -1;
    level flag::clear("radio_7_played");
    level flag::clear("radio_9_played");
    level flag::clear("trap_destroyed");
    function_7ada93b1();
    crystals = getentarray("sq_crystals", "targetname");
    for (i = 0; i < crystals.size; i++) {
        if (isdefined(crystals[i].trigger)) {
            crystals[i].trigger delete();
            crystals[i] delete();
        }
    }
    dynamite = getent("dynamite", "targetname");
    dynamite delete();
    buttons = getentarray("sq_sundial_button", "targetname");
    for (i = 0; i < buttons.size; i++) {
        if (isdefined(buttons[i].trigger)) {
            buttons[i].trigger delete();
            buttons[i].trigger = undefined;
        }
    }
    function_885a7581();
    dial = getent("sq_sundial", "targetname");
    dial thread function_20359a78();
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x3144f170, Offset: 0x34f0
// Size: 0xdc
function function_262fe732() {
    foreach (e_player in level.players) {
        e_player thread function_5fdf6353();
    }
    level util::set_lighting_state(1);
    level clientfield::set("time_transition", 0);
    level function_7aca917c(0);
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0xb3f6911b, Offset: 0x35d8
// Size: 0xdc
function function_701bca() {
    foreach (e_player in level.players) {
        e_player thread function_5fdf6353();
    }
    level util::set_lighting_state(0);
    level clientfield::set("time_transition", 1);
    level function_7aca917c(1);
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x41d0ecc, Offset: 0x36c0
// Size: 0x6c
function function_5fdf6353() {
    level endon(#"end_game");
    self endon(#"disconnect");
    visionset_mgr::activate("overlay", "zm_temple_eclipse", self);
    wait 3;
    if (isdefined(self)) {
        visionset_mgr::deactivate("overlay", "zm_temple_eclipse", self);
    }
}

// Namespace zm_temple_sq
// Params 1, eflags: 0x0
// Checksum 0x257d2fd1, Offset: 0x3738
// Size: 0x12c
function function_fdf9dab3(n_time) {
    level notify(#"hash_89011ead");
    level endon(#"hash_89011ead");
    if (!isdefined(level.var_9e9e4a20)) {
        level.var_9e9e4a20 = 0;
    }
    if (level.var_9e9e4a20 > 0) {
        var_3557d539 = 360 - level.var_9e9e4a20;
    } else {
        var_3557d539 = 360;
    }
    var_c7518b5c = var_3557d539 / n_time / 0.1;
    while (var_3557d539 > 0) {
        level.var_9e9e4a20 += var_c7518b5c;
        setdvar("r_skyRotation", level.var_9e9e4a20);
        var_3557d539 -= var_c7518b5c;
        wait 0.1;
    }
    level.var_9e9e4a20 = 0;
    setdvar("r_skyRotation", level.var_9e9e4a20);
}

// Namespace zm_temple_sq
// Params 1, eflags: 0x0
// Checksum 0x259a42f7, Offset: 0x3870
// Size: 0x9c
function function_7aca917c(var_8182276a) {
    if (!isdefined(var_8182276a)) {
        var_8182276a = 0;
    }
    if (isdefined(level.var_1b3f87f7)) {
        level.var_1b3f87f7 delete();
    }
    level.var_1b3f87f7 = createstreamerhint(level.activeplayers[0].origin, 1, var_8182276a);
    level.var_1b3f87f7 setlightingonly(1);
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x42417f6e, Offset: 0x3918
// Size: 0x6c
function function_ea122a69() {
    ent = getent("sq_meteorite", "targetname");
    if (isdefined(ent)) {
        ent show();
        exploder::exploder("fxexp_518");
    }
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0xb211610a, Offset: 0x3990
// Size: 0x6c
function function_9db048d0() {
    ent = getent("sq_meteorite", "targetname");
    if (isdefined(ent)) {
        ent ghost();
        exploder::stop_exploder("fxexp_518");
    }
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0xa35af104, Offset: 0x3a08
// Size: 0xac
function function_439a6a14() {
    if (!isdefined(level.var_561c8f96)) {
        var_cd998d3c = getentarray("sq_spiketrap", "targetname");
        ent = var_cd998d3c[0];
        if (isdefined(ent)) {
            sb = util::spawn_model("p7_zm_sha_skeleton", ent.origin, ent.angles);
            level.var_561c8f96 = sb;
        }
    }
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x1294e6be, Offset: 0x3ac0
// Size: 0x36
function function_5f10d4a9() {
    if (isdefined(level.var_561c8f96)) {
        level.var_561c8f96 delete();
        level.var_561c8f96 = undefined;
    }
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x1b853ad, Offset: 0x3b00
// Size: 0x114
function function_ccf3d988() {
    dynamite = getent("dynamite", "targetname");
    dynamite.angles = dynamite.original_angles;
    dynamite.origin = dynamite.original_origin;
    dynamite unlink();
    dynamite linkto(dynamite.var_bbca234, "", dynamite.origin - dynamite.var_bbca234.origin, dynamite.angles - dynamite.var_bbca234.angles);
    dynamite.dropped = undefined;
    dynamite show();
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x6a78e498, Offset: 0x3c20
// Size: 0x44
function function_19458ffa() {
    self stoploopsound(0.5);
    wait 0.5;
    self delete();
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x9e8201fa, Offset: 0x3c70
// Size: 0x4ee
function function_251b8f40() {
    if (isdefined(self.trigger)) {
        zm_weap_shrink_ray::function_d705d94f(self.trigger);
        self.trigger thread function_19458ffa();
        self.trigger = undefined;
    }
    if (isdefined(self.script_noteworthy) && self.script_noteworthy == "dynamite" && !isdefined(self.dynamite)) {
        var_aab24385 = struct::get(self.target, "targetname");
        dynamite = spawn("script_model", var_aab24385.origin);
        dynamite.angles = var_aab24385.angles;
        dynamite setmodel("p7_zm_sha_dynamite_wrap_full");
        dynamite.targetname = "dynamite";
        dynamite.target = var_aab24385.target;
        dynamite.original_origin = dynamite.origin;
        dynamite.original_angles = dynamite.angles;
        dynamite.var_bbca234 = self;
        dynamite linkto(self, "", dynamite.origin - self.origin, dynamite.angles - self.angles);
        self.dynamite = dynamite;
    }
    if (!isdefined(self.original_origin)) {
        self.original_origin = self.origin;
    }
    self dontinterpolate();
    self.origin = self.original_origin - (0, 0, 154);
    self ghost();
    level waittill("raise_crystal_" + self.script_int, var_1e404668);
    if (isdefined(var_1e404668) && var_1e404668) {
        level notify(#"hash_bd6f486d");
    }
    self show();
    self playsound("evt_sq_gen_crystal_start");
    self playloopsound("evt_sq_gen_crystal_loop", 2);
    self moveto(self.origin + (0, 0, 154), 4, 0.8, 0.4);
    self waittill(#"movedone");
    self stoploopsound(1);
    self playsound("evt_sq_gen_crystal_end");
    level notify("raised_crystal_" + self.script_int);
    if (isdefined(self.script_noteworthy) && self.script_noteworthy == "empty_holder") {
        if (isdefined(var_1e404668) && var_1e404668) {
            level waittill(#"hash_93d9795e");
        }
        self setmodel("p7_zm_sha_crystal_holder_full");
    }
    trigger = spawn("trigger_damage", self.origin + (0, 0, 134), 0, 32, 32);
    trigger.radius = 32;
    trigger.height = 32;
    trigger thread function_3bf43eeb();
    trigger.var_bbca234 = self;
    zm_weap_shrink_ray::function_80738220(trigger);
    self.trigger = trigger;
    self thread function_45a7678();
    self thread function_7b77a86a();
    level.var_15ea76e6[self.script_int - 1] = 1;
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x4fe8d81f, Offset: 0x4168
// Size: 0xb0
function function_45a7678() {
    self.trigger endon(#"death");
    while (true) {
        level flag::wait_till("gongs_resonating");
        self playloopsound("mus_sq_bag_crystal_loop", 2);
        while (level flag::get("gongs_resonating")) {
            wait 0.1;
        }
        self stoploopsound(0.5);
    }
}

// Namespace zm_temple_sq
// Params 1, eflags: 0x0
// Checksum 0x65eddd90, Offset: 0x4220
// Size: 0x8a
function function_d7fe0309(num) {
    sq = getentarray("sq_crystals", "targetname");
    for (i = 0; i < sq.size; i++) {
        if (sq[i].script_int == num) {
            return sq[i];
        }
    }
}

// Namespace zm_temple_sq
// Params 1, eflags: 0x0
// Checksum 0x1240d4cf, Offset: 0x42b8
// Size: 0x4a
function function_5b24d5a1(i) {
    if (isdefined(level.var_15ea76e6[i - 1]) && level.var_15ea76e6[i - 1] == 1) {
        return true;
    }
    return false;
}

// Namespace zm_temple_sq
// Params 3, eflags: 0x0
// Checksum 0xbb21b894, Offset: 0x4310
// Size: 0x12c
function function_f5c88bbf(a, b, hotsauce) {
    if (hotsauce) {
        a clientfield::set("hotsauce", 1);
    } else {
        a clientfield::set("weaksauce", 1);
    }
    b clientfield::set("sauceend", 1);
    util::wait_network_frame();
    util::wait_network_frame();
    util::wait_network_frame();
    if (isdefined(a)) {
        a clientfield::set("hotsauce", 0);
        a clientfield::set("weaksauce", 0);
    }
    if (isdefined(b)) {
        b clientfield::set("sauceend", 0);
    }
}

// Namespace zm_temple_sq
// Params 2, eflags: 0x0
// Checksum 0x14cf839e, Offset: 0x4448
// Size: 0x164
function function_9301abe7(start, hotsauce) {
    if (!isdefined(level.var_68f41fb4)) {
        level.var_68f41fb4 = spawn("script_model", (0, 0, 0));
        level.var_68f41fb4 setmodel("tag_origin");
    }
    yaw = randomfloat(360);
    r = randomfloatrange(100, -56);
    amntx = cos(yaw) * r;
    amnty = sin(yaw) * r;
    level.var_68f41fb4.origin = start.origin + (amntx, amnty, randomint(60));
    level thread function_f5c88bbf(start, level.var_68f41fb4, hotsauce);
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x8d37b309, Offset: 0x45b8
// Size: 0x1cc
function function_c8c1e622() {
    wait 1;
    clientfield::increment("meteor_shrink");
    self playsound("evt_sq_bag_shrink_meteor");
    self setmodel("p7_zm_sha_meteorite_small");
    exploder::exploder("fxexp_519");
    wait 0.1;
    exploder::stop_exploder("fxexp_518");
    self ghost();
    wait 0.25;
    level flag::set("meteorite_shrunk");
    level thread function_1f78a85d();
    self playsound("evt_sq_bag_meteor_fall");
    self moveto(self.origin - (0, 0, 120), 2, 0.5);
    self waittill(#"movedone");
    players = getplayers();
    players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("eggs", "quest8", 4);
}

// Namespace zm_temple_sq
// Params 1, eflags: 0x0
// Checksum 0x51a8cbb6, Offset: 0x4790
// Size: 0x534
function function_e562bcb4(hotsauce) {
    level.var_ac3f0659 = 1;
    level flag::set("doing_bounce_around");
    var_2ecbb0cd = level.var_5c940024[self.script_int];
    start = self;
    end = undefined;
    if (isdefined(var_2ecbb0cd)) {
        for (i = 0; i < var_2ecbb0cd.size; i++) {
            if ("" + var_2ecbb0cd[i] == "M") {
                if (namespace_6e97c459::function_c0c0cab6("sq", "BaG") && !level flag::get("meteorite_shrunk")) {
                    ent = getent("sq_meteorite", "targetname");
                    if (hotsauce) {
                        start playsound("evt_sq_bag_crystal_bounce_correct");
                        exploder::exploder("fxexp_509");
                        ent thread function_c8c1e622();
                    } else {
                        start playsound("evt_sq_bag_crystal_bounce_fail");
                        exploder::exploder("fxexp_529");
                        players = getplayers();
                        players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("eggs", "quest8", 3);
                    }
                } else {
                    start playsound("evt_sq_bag_crystal_bounce_fail");
                    exploder::exploder("fxexp_529");
                }
            } else if ("" + var_2ecbb0cd[i] == "R") {
                start playsound("evt_sq_bag_crystal_bounce_fail");
                function_9301abe7(start, hotsauce);
                break;
            } else if (function_5b24d5a1(var_2ecbb0cd[i])) {
                end = function_d7fe0309(var_2ecbb0cd[i]);
                start playsound("evt_sq_bag_crystal_bounce_correct");
                level thread function_f5c88bbf(start, end, hotsauce);
                start = end;
            } else {
                start playsound("evt_sq_bag_crystal_bounce_fail");
                function_9301abe7(start, hotsauce);
                break;
            }
            wait 0.5;
            if (i == 6) {
                end playsound("mus_sq_bag_crystal_final_hit");
            } else {
                end playsound("evt_sq_bag_crystal_hit_" + i);
            }
            if (hotsauce && isdefined(end) && isdefined(end.dynamite) && !isdefined(end.dynamite.dropped) && namespace_6e97c459::function_c0c0cab6("sq", "BaG")) {
                end.dynamite thread zm_temple_sq_bag::function_ee5cccb6();
            }
            end playsound("evt_sq_bag_crystal_charge");
            if (hotsauce) {
                str_exploder = "fxexp_" + end.script_int + 520;
                exploder::exploder(str_exploder);
            } else {
                str_exploder = "fxexp_" + end.script_int + 530;
                exploder::exploder(str_exploder);
            }
            wait 0.5;
        }
    }
    level.var_ac3f0659 = undefined;
    level flag::clear("doing_bounce_around");
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x15b1b668, Offset: 0x4cd0
// Size: 0x88
function function_2bfcbd0e() {
    self endon(#"death");
    while (true) {
        self waittill(#"shrunk", hotsauce);
        if (!level flag::get("gongs_resonating")) {
            hotsauce = 0;
        }
        if (!isdefined(level.var_ac3f0659)) {
            self.var_bbca234 thread function_e562bcb4(hotsauce);
        }
    }
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x1f463fdd, Offset: 0x4d60
// Size: 0x78
function function_3bf43eeb() {
    self endon(#"death");
    self thread function_2bfcbd0e();
    while (true) {
        self waittill(#"damage", amount, attacker, dir, point, type);
    }
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0xf663525d, Offset: 0x4de0
// Size: 0x270
function function_3129bf4e() {
    if (!isdefined(level.var_96a5220e)) {
        level.var_96a5220e = 0;
    }
    if (level.var_96a5220e) {
        return;
    }
    level.var_96a5220e = 1;
    pap_clip = level.pack_a_punch.triggers[0].clip;
    pap_clip notsolid();
    pap_clip connectpaths();
    var_775d8b87 = level.pack_a_punch.triggers[0];
    var_775d8b87 enablelinkto();
    pap_machine = var_775d8b87.pap_machine;
    if (!isdefined(var_775d8b87.original_origin)) {
        var_775d8b87.original_origin = var_775d8b87.origin;
    }
    var_21974cbb = spawn("script_origin", var_775d8b87.origin);
    var_21974cbb.angles = pap_machine.angles;
    var_775d8b87 linkto(var_21974cbb);
    level.var_5a64f9f6 = var_775d8b87.origin;
    pap_machine linkto(var_21974cbb);
    var_21974cbb moveto(var_21974cbb.origin + (0, 0, -350), 5);
    var_21974cbb waittill(#"movedone");
    var_775d8b87 unlink();
    pap_machine unlink();
    pap_machine ghost();
    pap_machine notsolid();
    var_21974cbb delete();
    level.var_96a5220e = 2;
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0xd0a6475b, Offset: 0x5058
// Size: 0x210
function function_b90b29ed() {
    if (!isdefined(level.var_96a5220e) || level.var_96a5220e == 0) {
        return;
    }
    if (level.var_96a5220e == 1) {
        while (level.var_96a5220e != 2) {
            wait 1;
        }
    }
    pap_clip = level.pack_a_punch.triggers[0].clip;
    pap_clip solid();
    pap_clip connectpaths();
    var_775d8b87 = level.pack_a_punch.triggers[0];
    pap_machine = var_775d8b87.pap_machine;
    var_21974cbb = spawn("script_origin", var_775d8b87.origin);
    var_21974cbb.angles = pap_machine.angles;
    var_775d8b87 linkto(var_21974cbb);
    pap_machine linkto(var_21974cbb);
    pap_machine solid();
    pap_machine show();
    var_21974cbb moveto(level.var_5a64f9f6, 5);
    var_21974cbb waittill(#"movedone");
    var_775d8b87 unlink();
    pap_machine unlink();
    var_21974cbb delete();
    level.var_96a5220e = 0;
}

// Namespace zm_temple_sq
// Params 1, eflags: 0x0
// Checksum 0x20b6f7c, Offset: 0x5270
// Size: 0xaa
function function_26186755(var_8e0fe378) {
    if (!isdefined(var_8e0fe378)) {
        var_8e0fe378 = 0;
    }
    var_bc7547cb = "a";
    switch (var_8e0fe378) {
    case 0:
        var_bc7547cb = "a";
        break;
    case 1:
        var_bc7547cb = "b";
        break;
    case 2:
        var_bc7547cb = "d";
        break;
    case 3:
        var_bc7547cb = "c";
        break;
    }
    return var_bc7547cb;
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0xc3d40144, Offset: 0x5328
// Size: 0xf6
function function_1f78a85d() {
    var_6c1012a9 = getentarray("sq_gong", "targetname");
    for (i = 0; i < var_6c1012a9.size; i++) {
        if (var_6c1012a9[i].var_4a3ea713) {
            if (var_6c1012a9[i].ringing) {
                if (level.var_c5defb4b >= 0) {
                    level.var_c5defb4b--;
                }
                var_6c1012a9[i] stoploopsound(0.5);
            }
        }
        var_6c1012a9[i].ringing = 0;
    }
    level notify(#"hash_7b77a86a");
    level notify(#"hash_6a46050f");
}

// Namespace zm_temple_sq
// Params 0, eflags: 0x0
// Checksum 0x9223ff2f, Offset: 0x5428
// Size: 0x3c
function function_7b77a86a() {
    self.trigger endon(#"death");
    level waittill(#"hash_7b77a86a");
    self stoploopsound(0.5);
}

/#

    // Namespace zm_temple_sq
    // Params 0, eflags: 0x0
    // Checksum 0x990652d0, Offset: 0x5470
    // Size: 0x64
    function function_e63287bf() {
        level waittill(#"start_zombie_round_logic");
        zm_devgui::add_custom_devgui_callback(&function_b1064ab3);
        adddebugcommand("<dev string:x35>");
        adddebugcommand("<dev string:x6f>");
    }

    // Namespace zm_temple_sq
    // Params 1, eflags: 0x0
    // Checksum 0xa45c92d3, Offset: 0x54e0
    // Size: 0x76
    function function_b1064ab3(cmd) {
        switch (cmd) {
        case "<dev string:xa8>":
            setdvar("<dev string:xab>", 0);
            return 1;
        case "<dev string:xbd>":
            setdvar("<dev string:xab>", 1);
            return 1;
        }
        return 0;
    }

#/
