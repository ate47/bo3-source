#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_placeable_mine;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_util;
#using scripts/zm/_zm_utility;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/player_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_7b165194;

// Namespace namespace_7b165194
// Params 0, eflags: 0x2
// namespace_7b165194<file_0>::function_2dc19561
// Checksum 0xe78f4936, Offset: 0x3c8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("controllable_spider", &__init__, undefined, undefined);
}

// Namespace namespace_7b165194
// Params 0, eflags: 0x1 linked
// namespace_7b165194<file_0>::function_8c87d8eb
// Checksum 0x3157f87d, Offset: 0x408
// Size: 0xac
function __init__() {
    register_clientfields();
    zm_placeable_mine::add_mine_type("controllable_spider", %);
    callback::on_spawned(&function_b2a01f79);
    level.var_99f2368e = getweapon("controllable_spider");
    level flag::init("controllable_spider_equipped");
    /#
        function_be10e0f1();
    #/
}

// Namespace namespace_7b165194
// Params 0, eflags: 0x1 linked
// namespace_7b165194<file_0>::function_4ece4a2f
// Checksum 0x13e990c3, Offset: 0x4c0
// Size: 0x94
function register_clientfields() {
    clientfield::register("scriptmover", "player_cocooned_fx", 9000, 1, "int");
    clientfield::register("allplayers", "player_cocooned_fx", 9000, 1, "int");
    clientfield::register("clientuimodel", "hudItems.showDpadRight_Spider", 9000, 1, "int");
}

// Namespace namespace_7b165194
// Params 0, eflags: 0x1 linked
// namespace_7b165194<file_0>::function_468b927
// Checksum 0x4ba0b3cc, Offset: 0x560
// Size: 0x84
function function_468b927() {
    if (!self hasweapon(level.var_99f2368e)) {
        self thread zm_placeable_mine::setup_for_player(level.var_99f2368e, "hudItems.showDpadRight_Spider");
        self givemaxammo(level.var_99f2368e);
        level thread function_160ff11f();
    }
}

// Namespace namespace_7b165194
// Params 0, eflags: 0x1 linked
// namespace_7b165194<file_0>::function_160ff11f
// Checksum 0xdd4c70f8, Offset: 0x5f0
// Size: 0x8c
function function_160ff11f() {
    if (!level flag::get("controllable_spider_equipped")) {
        level flag::set("controllable_spider_equipped");
        level.var_4af51a33 = &function_84313596;
        level.closest_player_targets_override = &closest_player_targets_override;
        level.var_b780352b = &closest_player_targets_override;
    }
}

// Namespace namespace_7b165194
// Params 0, eflags: 0x1 linked
// namespace_7b165194<file_0>::function_b2a01f79
// Checksum 0xafa161f7, Offset: 0x688
// Size: 0x1ec
function function_b2a01f79() {
    self endon(#"disconnect");
    var_97cffdb4 = "zone_bunker_interior_elevator";
    var_be85f81a = "zone_bunker_prison_entrance";
    while (true) {
        w_current, w_previous = self waittill(#"weapon_change");
        if (w_current === level.var_99f2368e) {
            if (isdefined(self.var_b0329be9) && (!ispointonnavmesh(self.origin) || self.var_b0329be9) || !self isonground()) {
                self switchtoweaponimmediate(w_previous);
                wait(0.05);
                continue;
            }
            if (var_be85f81a === self zm_utility::get_current_zone() && (var_97cffdb4 === self zm_utility::get_current_zone() || level flag::get("elevator_in_use"))) {
                self switchtoweaponimmediate(w_previous);
                wait(0.05);
                continue;
            }
            n_ammo = self getammocount(level.var_99f2368e);
            if (n_ammo <= 0) {
                continue;
            }
            n_ammo--;
            self setweaponammoclip(level.var_99f2368e, n_ammo);
            self thread function_40296c9b(w_previous);
            self waittill(#"hash_6181e737");
        }
    }
}

// Namespace namespace_7b165194
// Params 1, eflags: 0x1 linked
// namespace_7b165194<file_0>::function_40296c9b
// Checksum 0xb7d4824, Offset: 0x880
// Size: 0x2ec
function function_40296c9b(w_previous) {
    self notify(#"hash_a1fe358c");
    var_cbe49ee = util::spawn_model("p7_zm_isl_cocoon_standing", self.origin, self.angles);
    var_cbe49ee clientfield::set("player_cocooned_fx", 1);
    self.var_cbe49ee = var_cbe49ee;
    e_spawner = getent("friendly_spider_spawner", "targetname");
    ai = zombie_utility::spawn_zombie(e_spawner);
    ai.origin = self.origin;
    ai.angles = self.angles;
    ai.am_i_valid = 1;
    ai thread player::last_valid_position();
    ai thread function_5ce6002e(self, w_previous);
    ai thread function_4e8bb77d();
    ai thread function_cb196021();
    ai usevehicle(self, 0);
    self freezecontrols(1);
    self lui::screen_fade_out(0.25);
    self.var_59bd3c5a = ai;
    self.old_origin = self.origin;
    self.old_angles = self.angles;
    self lui::screen_fade_in(0.25);
    self hide();
    self notsolid();
    self setplayercollision(0);
    self enableinvulnerability();
    self freezecontrols(0);
    self thread function_a21f0b74();
    self thread zm_equipment::show_hint_text(%ZM_ISLAND_SPIDER_SELF_DESTRUCT, 4);
    self.dontspeak = 1;
    self clientfield::set_to_player("isspeaking", 1);
}

// Namespace namespace_7b165194
// Params 2, eflags: 0x1 linked
// namespace_7b165194<file_0>::function_5ce6002e
// Checksum 0x48c09dac, Offset: 0xb78
// Size: 0x2d4
function function_5ce6002e(e_player, w_previous) {
    e_player endon(#"disconnect");
    self waittill(#"death");
    var_cbe49ee = e_player.var_cbe49ee;
    e_player freezecontrols(1);
    e_player.ignoreme = 1;
    wait(1);
    e_player lui::screen_fade_out(0.25);
    self notify(#"stop_last_valid_position");
    self notify(#"exit_vehicle");
    e_player clientfield::set("player_cocooned_fx", 1);
    var_cbe49ee hide();
    e_player lui::screen_fade_in(0.25);
    e_player thread function_5a1c08d0();
    var_f1c825f6 = getclosestpointonnavmesh(e_player.old_origin, 1000, 15);
    e_player.var_59bd3c5a = undefined;
    e_player freezecontrols(0);
    e_player unlink();
    e_player show();
    e_player solid();
    e_player setplayercollision(1);
    e_player disableinvulnerability();
    e_player setorigin(var_f1c825f6);
    e_player.angles = e_player.old_angles;
    e_player switchtoweaponimmediate(w_previous);
    e_player.ignoreme = 0;
    while (true) {
        w_current = e_player waittill(#"weapon_change");
        if (w_current == w_previous) {
            break;
        }
    }
    e_player waittill(#"weapon_change_complete");
    e_player notify(#"hash_6181e737");
    e_player.dontspeak = 0;
    e_player clientfield::set_to_player("isspeaking", 0);
}

// Namespace namespace_7b165194
// Params 0, eflags: 0x1 linked
// namespace_7b165194<file_0>::function_5a1c08d0
// Checksum 0x779e8a76, Offset: 0xe58
// Size: 0x34
function function_5a1c08d0() {
    var_cbe49ee = self.var_cbe49ee;
    wait(1);
    var_cbe49ee delete();
}

// Namespace namespace_7b165194
// Params 0, eflags: 0x1 linked
// namespace_7b165194<file_0>::function_4e8bb77d
// Checksum 0xc7052b69, Offset: 0xe98
// Size: 0x3c
function function_4e8bb77d() {
    self endon(#"death");
    wait(60);
    self dodamage(self.health + 1000, self.origin);
}

// Namespace namespace_7b165194
// Params 0, eflags: 0x1 linked
// namespace_7b165194<file_0>::function_cb196021
// Checksum 0xde2055ff, Offset: 0xee0
// Size: 0x44
function function_cb196021() {
    self endon(#"death");
    if (level.round_number <= 30) {
        self.health = -56 * level.round_number;
        return;
    }
    self.health = 6000;
}

// Namespace namespace_7b165194
// Params 0, eflags: 0x1 linked
// namespace_7b165194<file_0>::function_a21f0b74
// Checksum 0x5a1e50ba, Offset: 0xf30
// Size: 0xcc
function function_a21f0b74() {
    self.var_59bd3c5a endon(#"death");
    self endon(#"disconnect");
    while (true) {
        if (self util::use_button_held()) {
            self.var_59bd3c5a setteam("axis");
            self.var_59bd3c5a.takedamage = 1;
            self.var_59bd3c5a.owner = undefined;
            self.var_59bd3c5a dodamage(self.var_59bd3c5a.health + 1000, self.var_59bd3c5a.origin);
            return;
        }
        wait(0.05);
    }
}

// Namespace namespace_7b165194
// Params 0, eflags: 0x0
// namespace_7b165194<file_0>::function_e889b7
// Checksum 0x4b3ce5f6, Offset: 0x1008
// Size: 0x7c
function function_e889b7() {
    self endon(#"disconnect");
    level waittill(#"between_round_over");
    n_ammo = self getammocount(level.var_99f2368e);
    if (n_ammo <= 0) {
        n_ammo++;
        self setweaponammoclip(level.var_99f2368e, n_ammo);
    }
}

// Namespace namespace_7b165194
// Params 1, eflags: 0x1 linked
// namespace_7b165194<file_0>::function_84313596
// Checksum 0x5284b66f, Offset: 0x1090
// Size: 0x1a6
function function_84313596(zone_name) {
    if (!zm_zonemgr::zone_is_enabled(zone_name)) {
        return false;
    }
    zone = level.zones[zone_name];
    for (i = 0; i < zone.volumes.size; i++) {
        players = getplayers();
        for (j = 0; j < players.size; j++) {
            if (isdefined(players[j].var_59bd3c5a)) {
                if (players[j].var_59bd3c5a istouching(zone.volumes[i]) && !(players[j].var_59bd3c5a.sessionstate === "spectator")) {
                    return true;
                }
                continue;
            }
            if (players[j] istouching(zone.volumes[i]) && !(players[j].sessionstate == "spectator")) {
                return true;
            }
        }
    }
    return false;
}

// Namespace namespace_7b165194
// Params 0, eflags: 0x1 linked
// namespace_7b165194<file_0>::function_42b455c8
// Checksum 0xa4649d13, Offset: 0x1240
// Size: 0x84
function closest_player_targets_override() {
    a_targets = getplayers();
    for (i = 0; i < a_targets.size; i++) {
        if (isdefined(a_targets[i].var_59bd3c5a)) {
            a_targets[i] = a_targets[i].var_59bd3c5a;
        }
    }
    return a_targets;
}

/#

    // Namespace namespace_7b165194
    // Params 0, eflags: 0x1 linked
    // namespace_7b165194<file_0>::function_be10e0f1
    // Checksum 0xe3f94b9, Offset: 0x12d0
    // Size: 0x44
    function function_be10e0f1() {
        zm_devgui::add_custom_devgui_callback(&function_11949f35);
        adddebugcommand("clientuimodel");
    }

    // Namespace namespace_7b165194
    // Params 1, eflags: 0x1 linked
    // namespace_7b165194<file_0>::function_11949f35
    // Checksum 0x5cd8efe9, Offset: 0x1320
    // Size: 0xba
    function function_11949f35(cmd) {
        switch (cmd) {
        case 8:
            foreach (player in level.players) {
                player thread function_468b927();
            }
            return 1;
        }
        return 0;
    }

#/
