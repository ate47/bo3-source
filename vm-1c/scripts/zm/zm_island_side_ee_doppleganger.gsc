#using scripts/zm/zm_island_util;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_ai_clone;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/archetype_clone;
#using scripts/shared/ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_island_side_ee_doppleganger;

// Namespace zm_island_side_ee_doppleganger
// Params 0, eflags: 0x2
// Checksum 0x2a0e63f0, Offset: 0x4a0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_island_side_ee_doppleganger", &__init__, undefined, undefined);
}

// Namespace zm_island_side_ee_doppleganger
// Params 0, eflags: 0x1 linked
// Checksum 0xc69a70b7, Offset: 0x4e0
// Size: 0x70
function __init__() {
    callback::on_connect(&on_player_connected);
    callback::on_spawned(&on_player_spawned);
    callback::on_disconnect(&function_178d800);
    level.var_5f4ff545 = -1;
}

// Namespace zm_island_side_ee_doppleganger
// Params 0, eflags: 0x1 linked
// Checksum 0xda917a1c, Offset: 0x558
// Size: 0x34
function main() {
    level thread function_46051422();
    /#
        level thread function_bece461b();
    #/
}

// Namespace zm_island_side_ee_doppleganger
// Params 0, eflags: 0x1 linked
// Checksum 0x6aca1d38, Offset: 0x598
// Size: 0x24
function on_player_connected() {
    self flag::init("doppleganger_enabled");
}

// Namespace zm_island_side_ee_doppleganger
// Params 0, eflags: 0x1 linked
// Checksum 0x83ac1999, Offset: 0x5c8
// Size: 0x24
function on_player_spawned() {
    self flag::clear("doppleganger_enabled");
}

// Namespace zm_island_side_ee_doppleganger
// Params 0, eflags: 0x1 linked
// Checksum 0x81186781, Offset: 0x5f8
// Size: 0x2c
function function_178d800() {
    if (isdefined(self.ai_doppleganger)) {
        self.ai_doppleganger function_38165cb6();
    }
}

// Namespace zm_island_side_ee_doppleganger
// Params 1, eflags: 0x1 linked
// Checksum 0x23c5904d, Offset: 0x630
// Size: 0x12a
function function_46051422(n_time) {
    if (!isdefined(n_time)) {
        n_time = 60;
    }
    level thread function_b1aa7056();
    level waittill(#"hash_8d6c8d6d");
    while (true) {
        if (level.activeplayers.size > 1) {
            var_f72c48e9 = randomint(10);
            if (var_f72c48e9 == 7) {
                wait randomintrange(60, 300);
                var_2bb7b39d = function_8c3f76f3();
                if (zm_utility::is_player_valid(var_2bb7b39d)) {
                    var_2bb7b39d thread function_5ee3951f();
                    while (isalive(var_2bb7b39d.ai_doppleganger)) {
                        wait 1;
                    }
                }
            }
        }
        wait 60;
    }
}

// Namespace zm_island_side_ee_doppleganger
// Params 0, eflags: 0x1 linked
// Checksum 0x18eaf58c, Offset: 0x768
// Size: 0x138
function function_b1aa7056() {
    t_lookat_doppleganger_enable = getent("t_lookat_doppleganger_enable", "targetname");
    if (isdefined(t_lookat_doppleganger_enable)) {
        while (true) {
            e_who = t_lookat_doppleganger_enable waittill(#"trigger");
            if (zm_utility::is_player_valid(e_who) && e_who util::ads_button_held() && !e_who flag::get("doppleganger_enabled")) {
                e_weapon = e_who getcurrentweapon();
                var_5d131e4a = strtok(e_weapon.name, "_");
                if (var_5d131e4a[0] === "sniper") {
                    e_who thread function_957b43e5();
                }
            }
            wait 0.1;
        }
    }
}

// Namespace zm_island_side_ee_doppleganger
// Params 0, eflags: 0x1 linked
// Checksum 0xd99fdfff, Offset: 0x8a8
// Size: 0x5c
function function_957b43e5() {
    self endon(#"death");
    self flag::set("doppleganger_enabled");
    level notify(#"hash_8d6c8d6d");
    wait 300;
    self flag::clear("doppleganger_enabled");
}

// Namespace zm_island_side_ee_doppleganger
// Params 0, eflags: 0x1 linked
// Checksum 0x8e3a1205, Offset: 0x910
// Size: 0x378
function function_8c3f76f3() {
    var_9876cb30 = [];
    var_7378d690 = [];
    var_2bb7b39d = undefined;
    a_alive_players = [];
    foreach (player in level.activeplayers) {
        if (zm_utility::is_player_valid(player) && player flag::get("doppleganger_enabled")) {
            array::add(a_alive_players, player);
        }
    }
    if (a_alive_players.size) {
        foreach (player in a_alive_players) {
            n_index = player zm_zonemgr::get_player_zone();
            if (!isdefined(var_9876cb30[n_index])) {
                var_9876cb30[n_index] = 0;
            }
            var_9876cb30[n_index]++;
            var_7378d690[n_index] = player;
        }
        var_2ca3526b = getarraykeys(var_9876cb30);
        foreach (key in var_2ca3526b) {
            if (var_9876cb30[key] == 1) {
                var_8662c367 = var_7378d690[key];
                if (zm_utility::is_player_valid(var_8662c367)) {
                    var_fb6aeae6 = arraycopy(level.activeplayers);
                    arrayremovevalue(var_fb6aeae6, var_8662c367);
                    e_closest_player = arraygetclosest(var_8662c367.origin, var_fb6aeae6);
                    if (zm_utility::is_player_valid(e_closest_player) && distance2dsquared(var_8662c367.origin, e_closest_player.origin) >= 1000000) {
                        var_2bb7b39d = var_8662c367;
                        break;
                    }
                }
            }
        }
    }
    return var_2bb7b39d;
}

// Namespace zm_island_side_ee_doppleganger
// Params 0, eflags: 0x1 linked
// Checksum 0x8d155736, Offset: 0xc90
// Size: 0x3b4
function function_5ee3951f() {
    var_697ad100 = array(0, 1, 2, 3);
    a_players = arraycopy(level.activeplayers);
    arrayremovevalue(a_players, self);
    if (isdefined(self.ai_doppleganger)) {
        self.ai_doppleganger delete();
    }
    var_91a9d91c = anglestoforward(self.angles);
    var_2fe7373d = self.origin - var_91a9d91c * -36;
    self.var_d73c077d = getclosestpointonnavmesh(var_2fe7373d, 64);
    if (!isdefined(self.var_d73c077d)) {
        var_6e3e5458 = anglestoright(self.angles);
        var_2fe7373d = self.origin - var_6e3e5458 * -36;
        self.var_d73c077d = getclosestpointonnavmesh(var_2fe7373d, 64);
    }
    if (!isdefined(self.var_d73c077d)) {
        var_379fad75 = anglestoright(self.angles) * -1;
        var_2fe7373d = self.origin - var_379fad75 * -36;
        self.var_d73c077d = getclosestpointonnavmesh(var_2fe7373d, 64);
    }
    if (isdefined(self.var_d73c077d)) {
        var_411ea70c = self.var_d73c077d - self.origin;
        var_4e08bd7 = vectortoangles(var_411ea70c);
        self.ai_doppleganger = spawnactor("spawner_zm_island_clone", self.var_d73c077d, var_4e08bd7, "ai_doppleganger", 1);
        if (a_players.size > 0) {
            arrayremovevalue(a_players, self);
            do {
                var_52b4a338 = array::random(a_players);
                arrayremovevalue(a_players, var_52b4a338);
            } while (!zm_utility::is_player_valid(var_52b4a338) && a_players.size > 0);
        }
        if (!zm_utility::is_player_valid(var_52b4a338)) {
            var_52b4a338 = self;
        }
        self.ai_doppleganger namespace_16383e98::function_c80742de(self.ai_doppleganger, var_52b4a338, self);
        self.ai_doppleganger hide();
        self.ai_doppleganger showtoplayer(self);
        self thread function_c948de86();
        self flag::clear("doppleganger_enabled");
    }
}

// Namespace zm_island_side_ee_doppleganger
// Params 0, eflags: 0x1 linked
// Checksum 0x4c1ce2ec, Offset: 0x1050
// Size: 0x1e6
function function_c948de86() {
    self.ai_doppleganger endon(#"death");
    self endon(#"death");
    self.ai_doppleganger asmsetanimationrate(1.2);
    util::magic_bullet_shield(self.ai_doppleganger);
    var_4010e215 = 10000;
    var_66d72d36 = 360000;
    var_87c6d702 = "";
    do {
        n_dist_sq = distancesquared(self.origin, self.ai_doppleganger.origin);
        if (n_dist_sq <= var_4010e215 && self zm_island_util::is_facing(self.ai_doppleganger, 0.7)) {
            var_87c6d702 = "scare";
            continue;
        }
        if (n_dist_sq > var_66d72d36 && !self zm_island_util::is_facing(self.ai_doppleganger, 0.5)) {
            var_87c6d702 = "delete";
            continue;
        }
        wait 0.1;
    } while (zm_utility::is_player_valid(self) && isdefined(self.ai_doppleganger) && var_87c6d702 == "");
    switch (var_87c6d702) {
    case "scare":
        self thread function_69f74476();
        break;
    case "delete":
        self thread function_38165cb6();
        break;
    }
}

// Namespace zm_island_side_ee_doppleganger
// Params 0, eflags: 0x1 linked
// Checksum 0x9ae2d383, Offset: 0x1240
// Size: 0x2b4
function function_69f74476() {
    if (isalive(self) && isdefined(self.ai_doppleganger)) {
        self util::function_7d553ac6();
        self disableweapons(1);
        self enableinvulnerability();
        ai = self.ai_doppleganger;
        var_1f377995 = util::spawn_model("tag_origin", ai.origin, self.angles);
        ai linkto(var_1f377995);
        self setplayerangles(vectortoangles(ai.origin - self.origin));
        self thread function_89b0bd32();
        v_dest = self.origin + vectornormalize(anglestoforward(self.angles)) * 30;
        ai util::stop_magic_bullet_shield();
        ai thread scene::play("zm_dlc2_side_ee_doppleganger_scare_180l");
        wait 0.05;
        var_1f377995 moveto(v_dest, 0.1);
        var_1f377995 waittill(#"movedone");
        var_1f377995 linkto(self);
        ai waittill(#"scene_done");
        self notify(#"hash_916d8c9f");
        self util::function_f7beb173();
        self function_38165cb6();
        self enableweapons();
        self disableinvulnerability();
        var_1f377995 delete();
        return;
    }
    if (isdefined(self.ai_doppleganger)) {
        self function_38165cb6();
    }
}

// Namespace zm_island_side_ee_doppleganger
// Params 0, eflags: 0x1 linked
// Checksum 0x230c0374, Offset: 0x1500
// Size: 0x78
function function_89b0bd32() {
    self endon(#"hash_916d8c9f");
    self endon(#"disconnect");
    while (true) {
        self playrumbleonentity("tank_damage_heavy_mp");
        earthquake(0.35, 0.5, self.origin, 325);
        wait 0.15;
    }
}

// Namespace zm_island_side_ee_doppleganger
// Params 0, eflags: 0x1 linked
// Checksum 0x3cd5390d, Offset: 0x1580
// Size: 0x44
function function_38165cb6() {
    if (isdefined(self.ai_doppleganger)) {
        util::stop_magic_bullet_shield(self.ai_doppleganger);
        self.ai_doppleganger delete();
    }
}

/#

    // Namespace zm_island_side_ee_doppleganger
    // Params 0, eflags: 0x1 linked
    // Checksum 0x47110361, Offset: 0x15d0
    // Size: 0x8c
    function function_bece461b() {
        zm_devgui::add_custom_devgui_callback(&function_8924dbff);
        adddebugcommand("<dev string:x28>");
        adddebugcommand("<dev string:x80>");
        adddebugcommand("<dev string:xd9>");
        adddebugcommand("<dev string:x12f>");
    }

    // Namespace zm_island_side_ee_doppleganger
    // Params 1, eflags: 0x1 linked
    // Checksum 0x7e1fdea2, Offset: 0x1668
    // Size: 0x13e
    function function_8924dbff(cmd) {
        switch (cmd) {
        case "<dev string:x196>":
            level.activeplayers[0] function_5ee3951f();
            return 1;
        case "<dev string:x1ab>":
            foreach (player in level.players) {
                player flag::set("<dev string:x1bf>");
            }
            return 1;
        case "<dev string:x1d4>":
            level.activeplayers[0] function_38165cb6();
            return 1;
        case "<dev string:x1e8>":
            function_8c3f76f3();
            return 1;
        }
        return 0;
    }

#/
