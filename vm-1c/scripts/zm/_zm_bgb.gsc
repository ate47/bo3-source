#using scripts/codescripts/struct;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_bgb_machine;
#using scripts/zm/_zm_bgb_token;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/gametypes/_globallogic_score;

#namespace bgb;

// Namespace bgb
// Params 0, eflags: 0x2
// Checksum 0x213594a4, Offset: 0x7c0
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("bgb", &__init__, &__main__, undefined);
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0x37dc04e3, Offset: 0x808
// Size: 0x1fc
function private __init__() {
    callback::on_spawned(&on_player_spawned);
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    level.weaponbgbgrab = getweapon("zombie_bgb_grab");
    level.weaponbgbuse = getweapon("zombie_bgb_use");
    level.bgb = [];
    clientfield::register("clientuimodel", "bgb_current", 1, 8, "int");
    clientfield::register("clientuimodel", "bgb_display", 1, 1, "int");
    clientfield::register("clientuimodel", "bgb_timer", 1, 8, "float");
    clientfield::register("clientuimodel", "bgb_activations_remaining", 1, 3, "int");
    clientfield::register("clientuimodel", "bgb_invalid_use", 1, 1, "counter");
    clientfield::register("clientuimodel", "bgb_one_shot_use", 1, 1, "counter");
    clientfield::register("toplayer", "bgb_blow_bubble", 1, 1, "counter");
    zm::register_vehicle_damage_callback(&vehicle_damage_override);
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0x29f60e58, Offset: 0xa10
// Size: 0x5e
function private __main__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb_finalize();
    /#
        level thread setup_devgui();
    #/
    level._effect["samantha_steal"] = "zombie/fx_monkey_lightning_zmb";
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0x4420286e, Offset: 0xa78
// Size: 0x5c
function private on_player_spawned() {
    self.bgb = "none";
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    self function_52dbea8c();
    self thread bgb_player_init();
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0xfe8c66bc, Offset: 0xae0
// Size: 0x50
function private function_52dbea8c() {
    if (!(isdefined(self.var_c2d95bad) && self.var_c2d95bad)) {
        self.var_c2d95bad = 1;
        self globallogic_score::initpersstat("bgb_tokens_gained_this_game", 0);
        self.bgb_tokens_gained_this_game = 0;
    }
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0xa7559f80, Offset: 0xb38
// Size: 0x1ec
function private bgb_player_init() {
    if (isdefined(self.bgb_pack)) {
        return;
    }
    self.bgb_pack = self getbubblegumpack();
    self.bgb_pack_randomized = [];
    self.bgb_stats = [];
    foreach (bgb in self.bgb_pack) {
        if (bgb == "weapon_null") {
            continue;
        }
        if (!(isdefined(level.bgb[bgb].consumable) && level.bgb[bgb].consumable)) {
            continue;
        }
        self.bgb_stats[bgb] = spawnstruct();
        self.bgb_stats[bgb].var_e0b06b47 = self getbgbremaining(bgb);
        self.bgb_stats[bgb].bgb_used_this_game = 0;
    }
    self.var_85da8a33 = 0;
    self clientfield::set_to_player("zm_bgb_machine_round_buys", self.var_85da8a33);
    self init_weapon_cycling();
    self thread bgb_player_monitor();
    self thread bgb_end_game();
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0x9dfca1c2, Offset: 0xd30
// Size: 0x20c
function private bgb_end_game() {
    self endon(#"disconnect");
    if (!level flag::exists("consumables_reported")) {
        level flag::init("consumables_reported");
    }
    self flag::init("finished_reporting_consumables");
    self waittill(#"report_bgb_consumption");
    self thread take();
    self function_e1f3d6d7();
    self zm_stats::set_global_stat("bgb_tokens_gained_this_game", self.bgb_tokens_gained_this_game);
    foreach (bgb in self.bgb_pack) {
        if (!isdefined(self.bgb_stats[bgb]) || !self.bgb_stats[bgb].bgb_used_this_game) {
            continue;
        }
        level flag::set("consumables_reported");
        zm_utility::function_d691fa6("end_consumables_count", self.bgb_stats[bgb].bgb_used_this_game);
        self reportlootconsume(bgb, self.bgb_stats[bgb].bgb_used_this_game);
    }
    self flag::set("finished_reporting_consumables");
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0x9290e1bb, Offset: 0xf48
// Size: 0x2d6
function private bgb_finalize() {
    var_a804a5cf = util::function_bc37a245();
    keys = getarraykeys(level.bgb);
    for (i = 0; i < keys.size; i++) {
        level.bgb[keys[i]].item_index = getitemindexfromref(keys[i]);
        level.bgb[keys[i]].rarity = int(tablelookup(var_a804a5cf, 0, level.bgb[keys[i]].item_index, 16));
        if (0 == level.bgb[keys[i]].rarity || 4 == level.bgb[keys[i]].rarity) {
            level.bgb[keys[i]].consumable = 0;
        } else {
            level.bgb[keys[i]].consumable = 1;
        }
        level.bgb[keys[i]].camo_index = int(tablelookup(var_a804a5cf, 0, level.bgb[keys[i]].item_index, 5));
        var_cf65a2c0 = tablelookup(var_a804a5cf, 0, level.bgb[keys[i]].item_index, 15);
        if (issubstr(var_cf65a2c0, "dlc")) {
            level.bgb[keys[i]].dlc_index = int(var_cf65a2c0[3]);
            continue;
        }
        level.bgb[keys[i]].dlc_index = 0;
    }
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0xe1e0d6b1, Offset: 0x1228
// Size: 0xd8
function private bgb_player_monitor() {
    self endon(#"disconnect");
    while (true) {
        str_return = level util::waittill_any_return("between_round_over", "restart_round");
        if (isdefined(level.var_4824bb2d)) {
            if (!(isdefined(self [[ level.var_4824bb2d ]]()) && self [[ level.var_4824bb2d ]]())) {
                continue;
            }
        }
        if (str_return === "restart_round") {
            level waittill(#"between_round_over");
            continue;
        }
        self.var_85da8a33 = 0;
        self clientfield::set_to_player("zm_bgb_machine_round_buys", self.var_85da8a33);
    }
}

/#

    // Namespace bgb
    // Params 0, eflags: 0x4
    // Checksum 0x795c8a15, Offset: 0x1308
    // Size: 0x264
    function private setup_devgui() {
        waittillframeend();
        setdvar("<dev string:x28>", "<dev string:x3b>");
        setdvar("<dev string:x3c>", -1);
        bgb_devgui_base = "<dev string:x4e>";
        keys = getarraykeys(level.bgb);
        foreach (key in keys) {
            adddebugcommand(bgb_devgui_base + key + "<dev string:x62>" + "<dev string:x28>" + "<dev string:x70>" + key + "<dev string:x72>");
        }
        adddebugcommand(bgb_devgui_base + "<dev string:x76>" + "<dev string:x28>" + "<dev string:x70>" + "<dev string:x8b>" + "<dev string:x72>");
        adddebugcommand(bgb_devgui_base + "<dev string:x90>" + "<dev string:x3c>" + "<dev string:x70>" + "<dev string:xa3>" + "<dev string:x72>");
        for (i = 0; i < 4; i++) {
            playernum = i + 1;
            adddebugcommand(bgb_devgui_base + "<dev string:xa6>" + playernum + "<dev string:xb5>" + "<dev string:x3c>" + "<dev string:x70>" + i + "<dev string:x72>");
        }
        level thread bgb_devgui_think();
    }

    // Namespace bgb
    // Params 0, eflags: 0x4
    // Checksum 0x286d0311, Offset: 0x1578
    // Size: 0x80
    function private bgb_devgui_think() {
        for (;;) {
            var_fe9a7d67 = getdvarstring("<dev string:x28>");
            if (var_fe9a7d67 != "<dev string:x3b>") {
                bgb_devgui_acquire(var_fe9a7d67);
            }
            setdvar("<dev string:x28>", "<dev string:x3b>");
            wait 0.5;
        }
    }

    // Namespace bgb
    // Params 1, eflags: 0x4
    // Checksum 0xab92deaa, Offset: 0x1600
    // Size: 0x11e
    function private bgb_devgui_acquire(bgb_name) {
        playerid = getdvarint("<dev string:x3c>");
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (playerid != -1 && playerid != i) {
                continue;
            }
            if ("<dev string:x8b>" == bgb_name) {
                players[i] thread take();
                continue;
            }
            function_594d2bdf(1);
            players[i] thread bgb_gumball_anim(bgb_name, 0);
            function_594d2bdf(0);
        }
    }

    // Namespace bgb
    // Params 0, eflags: 0x4
    // Checksum 0x852d87d8, Offset: 0x1728
    // Size: 0x144
    function private bgb_debug_text_display_init() {
        self.bgb_debug_text = newclienthudelem(self);
        self.bgb_debug_text.elemtype = "<dev string:xbd>";
        self.bgb_debug_text.font = "<dev string:xc2>";
        self.bgb_debug_text.fontscale = 1.8;
        self.bgb_debug_text.horzalign = "<dev string:xcc>";
        self.bgb_debug_text.vertalign = "<dev string:xd1>";
        self.bgb_debug_text.alignx = "<dev string:xcc>";
        self.bgb_debug_text.aligny = "<dev string:xd1>";
        self.bgb_debug_text.x = 15;
        self.bgb_debug_text.y = 35;
        self.bgb_debug_text.sort = 2;
        self.bgb_debug_text.color = (1, 1, 1);
        self.bgb_debug_text.alpha = 1;
        self.bgb_debug_text.hidewheninmenu = 1;
    }

#/

// Namespace bgb
// Params 2, eflags: 0x4
// Checksum 0xaf0b2d35, Offset: 0x1878
// Size: 0x1f0
function private bgb_set_debug_text(name, activations_remaining) {
    /#
        if (!isdefined(self.bgb_debug_text)) {
            return;
        }
        if (isdefined(activations_remaining)) {
            self clientfield::set_player_uimodel("<dev string:xd5>", 1);
        } else {
            self clientfield::set_player_uimodel("<dev string:xd5>", 0);
        }
        self notify(#"bgb_set_debug_text_thread");
        self endon(#"bgb_set_debug_text_thread");
        self endon(#"disconnect");
        self.bgb_debug_text fadeovertime(0.05);
        self.bgb_debug_text.alpha = 1;
        prefix = "<dev string:xe9>";
        short_name = name;
        if (issubstr(name, prefix)) {
            short_name = getsubstr(name, prefix.size);
        }
        if (isdefined(activations_remaining)) {
            self.bgb_debug_text settext("<dev string:xf1>" + short_name + "<dev string:xf7>" + activations_remaining + "<dev string:x119>");
        } else {
            self.bgb_debug_text settext("<dev string:xf1>" + short_name);
        }
        wait 1;
        if ("<dev string:x8b>" == name) {
            self.bgb_debug_text fadeovertime(1);
            self.bgb_debug_text.alpha = 0;
        }
    #/
}

/#

    // Namespace bgb
    // Params 1, eflags: 0x0
    // Checksum 0x5b63e5fa, Offset: 0x1a70
    // Size: 0xf4
    function bgb_print_stats(bgb) {
        printtoprightln(bgb + "<dev string:x120>" + self.bgb_stats[bgb].var_e0b06b47, (1, 1, 1));
        printtoprightln(bgb + "<dev string:x13a>" + self.bgb_stats[bgb].bgb_used_this_game, (1, 1, 1));
        n_available = self.bgb_stats[bgb].var_e0b06b47 - self.bgb_stats[bgb].bgb_used_this_game;
        printtoprightln(bgb + "<dev string:x14f>" + n_available, (1, 1, 1));
    }

#/

// Namespace bgb
// Params 1, eflags: 0x4
// Checksum 0x147b9851, Offset: 0x1b70
// Size: 0x66
function private has_consumable_bgb(bgb) {
    if (!isdefined(self.bgb_stats[bgb]) || !(isdefined(level.bgb[bgb].consumable) && level.bgb[bgb].consumable)) {
        return 0;
    }
    return 1;
}

// Namespace bgb
// Params 1, eflags: 0x0
// Checksum 0xa2dccf17, Offset: 0x1be0
// Size: 0x154
function sub_consumable_bgb(bgb) {
    if (!has_consumable_bgb(bgb)) {
        return;
    }
    if (isdefined(level.bgb[bgb].var_35e23ba2) && ![[ level.bgb[bgb].var_35e23ba2 ]]()) {
        return;
    }
    self.bgb_stats[bgb].bgb_used_this_game++;
    self flag::set("used_consumable");
    zm_utility::function_d691fa6("consumables_used", 1);
    if (level flag::exists("first_consumables_used")) {
        level flag::set("first_consumables_used");
    }
    self luinotifyevent(%zombie_bgb_used, 1, level.bgb[bgb].item_index);
    /#
        bgb_print_stats(bgb);
    #/
}

// Namespace bgb
// Params 1, eflags: 0x0
// Checksum 0x22869cfc, Offset: 0x1d40
// Size: 0x8c
function get_bgb_available(bgb) {
    if (!isdefined(self.bgb_stats[bgb])) {
        return true;
    }
    var_3232aae6 = self.bgb_stats[bgb].var_e0b06b47;
    n_bgb_used_this_game = self.bgb_stats[bgb].bgb_used_this_game;
    n_bgb_remaining = var_3232aae6 - n_bgb_used_this_game;
    return 0 < n_bgb_remaining;
}

// Namespace bgb
// Params 2, eflags: 0x4
// Checksum 0xd1a78e06, Offset: 0x1dd8
// Size: 0xc4
function private function_c3e0b2ba(bgb, var_aad41617) {
    if (!(isdefined(level.bgb[bgb].var_7ca0e2a7) && level.bgb[bgb].var_7ca0e2a7)) {
        return;
    }
    var_b0106e56 = self enableinvulnerability();
    self util::waittill_any_timeout(2, "bgb_bubble_blow_complete");
    if (isdefined(self) && !(isdefined(var_b0106e56) && var_b0106e56)) {
        self disableinvulnerability();
    }
}

// Namespace bgb
// Params 2, eflags: 0x0
// Checksum 0x5b4fdea6, Offset: 0x1ea8
// Size: 0x3d8
function bgb_gumball_anim(bgb, var_aad41617) {
    self endon(#"disconnect");
    level endon(#"end_game");
    unlocked = function_64f7cbc3();
    if (var_aad41617) {
        self thread function_c3e0b2ba(bgb);
        self thread zm_audio::create_and_play_dialog("bgb", "eat");
    }
    while (self isswitchingweapons()) {
        self waittill(#"weapon_change_complete");
    }
    gun = self function_bb702b0a(bgb, var_aad41617);
    evt = self util::waittill_any_return("fake_death", "death", "player_downed", "weapon_change_complete", "disconnect");
    succeeded = 0;
    if (evt == "weapon_change_complete") {
        succeeded = 1;
        if (var_aad41617) {
            if (isdefined(level.bgb[bgb].var_7ea552f4) && level.bgb[bgb].var_7ea552f4 || self function_b616fe7a(1)) {
                self notify(#"hash_83da9d01", bgb);
                self activation_start();
                self thread run_activation_func(bgb);
            } else {
                succeeded = 0;
            }
        } else {
            if (!(isdefined(unlocked) && unlocked)) {
                return 0;
            }
            self notify(#"bgb_gumball_anim_give", bgb);
            self thread give(bgb);
            self zm_stats::increment_client_stat("bgbs_chewed");
            self zm_stats::increment_player_stat("bgbs_chewed");
            self zm_stats::increment_challenge_stat("GUM_GOBBLER_CONSUME");
            self adddstat("ItemStats", level.bgb[bgb].item_index, "stats", "used", "statValue", 1);
            health = 0;
            if (isdefined(self.health)) {
                health = self.health;
            }
            self recordmapevent(4, gettime(), self.origin, level.round_number, level.bgb[bgb].item_index, health);
            demo::bookmark("zm_player_bgb_grab", gettime(), self);
            if (sessionmodeisonlinegame()) {
                util::function_a4c90358("zm_bgb_consumed", 1);
            }
        }
    }
    self function_a4493f0e(gun, bgb, var_aad41617);
    return succeeded;
}

// Namespace bgb
// Params 1, eflags: 0x4
// Checksum 0x4953f724, Offset: 0x2288
// Size: 0xa4
function private run_activation_func(bgb) {
    self endon(#"disconnect");
    self set_active(1);
    self do_one_shot_use();
    self notify(#"bgb_bubble_blow_complete");
    self [[ level.bgb[bgb].activation_func ]]();
    self set_active(0);
    self activation_complete();
}

// Namespace bgb
// Params 2, eflags: 0x4
// Checksum 0xb2c38a9f, Offset: 0x2338
// Size: 0x2a
function private bgb_get_gumball_anim_weapon(bgb, var_aad41617) {
    if (var_aad41617) {
        return level.weaponbgbuse;
    }
    return level.weaponbgbgrab;
}

// Namespace bgb
// Params 2, eflags: 0x4
// Checksum 0xc3775db, Offset: 0x2370
// Size: 0x158
function private function_bb702b0a(bgb, var_aad41617) {
    self zm_utility::increment_is_drinking();
    self zm_utility::disable_player_move_states(1);
    w_original = self getcurrentweapon();
    weapon = bgb_get_gumball_anim_weapon(bgb, var_aad41617);
    self giveweapon(weapon, self calcweaponoptions(level.bgb[bgb].camo_index, 0, 0));
    self switchtoweapon(weapon);
    if (weapon == level.weaponbgbgrab) {
        self playsound("zmb_bgb_powerup_default");
    }
    if (weapon == level.weaponbgbuse) {
        self clientfield::increment_to_player("bgb_blow_bubble");
    }
    return w_original;
}

// Namespace bgb
// Params 3, eflags: 0x4
// Checksum 0xca8bf35f, Offset: 0x24d0
// Size: 0x254
function private function_a4493f0e(w_original, bgb, var_aad41617) {
    assert(!w_original.isperkbottle);
    assert(w_original != level.weaponrevivetool);
    self zm_utility::enable_player_move_states();
    weapon = bgb_get_gumball_anim_weapon(bgb, var_aad41617);
    if (isdefined(self.intermission) && (self laststand::player_is_in_laststand() || self.intermission)) {
        self takeweapon(weapon);
        return;
    }
    self takeweapon(weapon);
    if (self zm_utility::is_multiple_drinking()) {
        self zm_utility::decrement_is_drinking();
        return;
    } else if (w_original != level.weaponnone && !zm_utility::is_placeable_mine(w_original) && !zm_equipment::is_equipment_that_blocks_purchase(w_original)) {
        self zm_weapons::switch_back_primary_weapon(w_original);
        if (zm_utility::is_melee_weapon(w_original)) {
            self zm_utility::decrement_is_drinking();
            return;
        }
    } else {
        self zm_weapons::switch_back_primary_weapon();
    }
    self util::waittill_any_timeout(1, "weapon_change_complete");
    if (!self laststand::player_is_in_laststand() && !(isdefined(self.intermission) && self.intermission)) {
        self zm_utility::decrement_is_drinking();
    }
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0x5d3eb4bd, Offset: 0x2730
// Size: 0x74
function private bgb_clear_monitors_and_clientfields() {
    self notify(#"bgb_limit_monitor");
    self notify(#"bgb_activation_monitor");
    self clientfield::set_player_uimodel("bgb_display", 0);
    self clientfield::set_player_uimodel("bgb_activations_remaining", 0);
    self clear_timer();
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0x3651469, Offset: 0x27b0
// Size: 0x524
function private bgb_limit_monitor() {
    self endon(#"disconnect");
    self endon(#"bgb_update");
    self notify(#"bgb_limit_monitor");
    self endon(#"bgb_limit_monitor");
    self clientfield::set_player_uimodel("bgb_display", 1);
    self thread function_5fc6d844(self.bgb);
    switch (level.bgb[self.bgb].limit_type) {
    case "activated":
        self thread bgb_activation_monitor();
        for (i = level.bgb[self.bgb].limit; i > 0; i--) {
            level.bgb[self.bgb].var_32fa3cb7 = i;
            if (level.bgb[self.bgb].var_336ffc4e) {
                function_497386b0();
            } else {
                self set_timer(i, level.bgb[self.bgb].limit);
            }
            self clientfield::set_player_uimodel("bgb_activations_remaining", i);
            self thread bgb_set_debug_text(self.bgb, i);
            self waittill(#"bgb_activation");
            while (isdefined(self get_active()) && self get_active()) {
                wait 0.05;
            }
            self playsoundtoplayer("zmb_bgb_power_decrement", self);
        }
        level.bgb[self.bgb].var_32fa3cb7 = 0;
        self playsoundtoplayer("zmb_bgb_power_done_delayed", self);
        self set_timer(0, level.bgb[self.bgb].limit);
        while (isdefined(self.bgb_activation_in_progress) && self.bgb_activation_in_progress) {
            wait 0.05;
        }
        break;
    case "time":
        self thread bgb_set_debug_text(self.bgb);
        self thread run_timer(level.bgb[self.bgb].limit);
        wait level.bgb[self.bgb].limit;
        self playsoundtoplayer("zmb_bgb_power_done", self);
        break;
    case "rounds":
        self thread bgb_set_debug_text(self.bgb);
        count = level.bgb[self.bgb].limit + 1;
        for (i = 0; i < count; i++) {
            self set_timer(count - i, count);
            level waittill(#"end_of_round");
            self playsoundtoplayer("zmb_bgb_power_decrement", self);
        }
        self playsoundtoplayer("zmb_bgb_power_done_delayed", self);
        break;
    case "event":
        self thread bgb_set_debug_text(self.bgb);
        self bgb_set_timer_clientfield(1);
        self [[ level.bgb[self.bgb].limit ]]();
        self playsoundtoplayer("zmb_bgb_power_done_delayed", self);
        break;
    default:
        assert(0, "<dev string:x15c>" + self.bgb + "<dev string:x17c>" + level.bgb[self.bgb].limit_type + "<dev string:x18c>");
        break;
    }
    self thread take();
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0xb19d48fe, Offset: 0x2ce0
// Size: 0x6c
function private bgb_bled_out_monitor() {
    self endon(#"disconnect");
    self endon(#"bgb_update");
    self notify(#"bgb_bled_out_monitor");
    self endon(#"bgb_bled_out_monitor");
    self waittill(#"bled_out");
    self notify(#"bgb_about_to_take_on_bled_out");
    wait 0.1;
    self thread take();
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0xb16e64c3, Offset: 0x2d58
// Size: 0xb6
function private bgb_activation_monitor() {
    self endon(#"disconnect");
    self notify(#"bgb_activation_monitor");
    self endon(#"bgb_activation_monitor");
    if ("activated" != level.bgb[self.bgb].limit_type) {
        return;
    }
    for (;;) {
        self waittill(#"bgb_activation_request");
        if (!self function_b616fe7a(0)) {
            continue;
        }
        if (self bgb_gumball_anim(self.bgb, 1)) {
            self notify(#"bgb_activation", self.bgb);
        }
    }
}

// Namespace bgb
// Params 1, eflags: 0x4
// Checksum 0x17fbd8b1, Offset: 0x2e18
// Size: 0x144
function private function_b616fe7a(var_5827b083) {
    if (!isdefined(var_5827b083)) {
        var_5827b083 = 0;
    }
    var_bb1d9487 = isdefined(level.bgb[self.bgb].validation_func) && !self [[ level.bgb[self.bgb].validation_func ]]();
    var_847ec8da = isdefined(level.var_9cef605e) && !self [[ level.var_9cef605e ]]();
    if (isdefined(self.bgb_activation_in_progress) && (isdefined(self.is_drinking) && !var_5827b083 && self.is_drinking || self.bgb_activation_in_progress) || self laststand::player_is_in_laststand() || var_bb1d9487 || var_847ec8da) {
        self clientfield::increment_uimodel("bgb_invalid_use");
        self playlocalsound("zmb_bgb_deny_plr");
        return false;
    }
    return true;
}

// Namespace bgb
// Params 1, eflags: 0x4
// Checksum 0x542a2377, Offset: 0x2f68
// Size: 0xa4
function private function_5fc6d844(bgb) {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"bgb_update");
    if (isdefined(level.bgb[bgb].var_50fe45f6) && level.bgb[bgb].var_50fe45f6) {
        function_650ca64(6);
    } else {
        return;
    }
    self waittill(#"bgb_activation_request");
    self thread take();
}

// Namespace bgb
// Params 1, eflags: 0x0
// Checksum 0x981d146b, Offset: 0x3018
// Size: 0x4c
function function_650ca64(n_value) {
    self setactionslot(1, "bgb");
    self clientfield::set_player_uimodel("bgb_activations_remaining", n_value);
}

// Namespace bgb
// Params 1, eflags: 0x0
// Checksum 0x5cf03fcd, Offset: 0x3070
// Size: 0x2c
function function_eabb0903(n_value) {
    self clientfield::set_player_uimodel("bgb_activations_remaining", 0);
}

// Namespace bgb
// Params 1, eflags: 0x0
// Checksum 0xef99bb19, Offset: 0x30a8
// Size: 0x28
function function_336ffc4e(name) {
    level.bgb[name].var_336ffc4e = 1;
}

// Namespace bgb
// Params 1, eflags: 0x0
// Checksum 0x5d7a7d6d, Offset: 0x30d8
// Size: 0x64
function do_one_shot_use(skip_demo_bookmark) {
    if (!isdefined(skip_demo_bookmark)) {
        skip_demo_bookmark = 0;
    }
    self clientfield::increment_uimodel("bgb_one_shot_use");
    if (!skip_demo_bookmark) {
        demo::bookmark("zm_player_bgb_activate", gettime(), self);
    }
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0xa8be8a8a, Offset: 0x3148
// Size: 0x10
function private activation_start() {
    self.bgb_activation_in_progress = 1;
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0x3430d9a, Offset: 0x3160
// Size: 0x1e
function private activation_complete() {
    self.bgb_activation_in_progress = 0;
    self notify(#"activation_complete");
}

// Namespace bgb
// Params 1, eflags: 0x4
// Checksum 0x33259947, Offset: 0x3188
// Size: 0x18
function private set_active(b_is_active) {
    self.bgb_active = b_is_active;
}

// Namespace bgb
// Params 0, eflags: 0x0
// Checksum 0xda2694c2, Offset: 0x31a8
// Size: 0x16
function get_active() {
    return isdefined(self.bgb_active) && self.bgb_active;
}

// Namespace bgb
// Params 1, eflags: 0x0
// Checksum 0x33748679, Offset: 0x31c8
// Size: 0x3e
function is_active(name) {
    if (!isdefined(self.bgb)) {
        return false;
    }
    return isdefined(self.bgb_active) && self.bgb == name && self.bgb_active;
}

// Namespace bgb
// Params 1, eflags: 0x0
// Checksum 0x74678969, Offset: 0x3210
// Size: 0xa4
function is_team_active(name) {
    foreach (player in level.players) {
        if (player is_active(name)) {
            return true;
        }
    }
    return false;
}

// Namespace bgb
// Params 1, eflags: 0x0
// Checksum 0x97e3feaa, Offset: 0x32c0
// Size: 0x64
function increment_ref_count(name) {
    if (!isdefined(level.bgb[name])) {
        return 0;
    }
    var_ad8303b0 = level.bgb[name].ref_count;
    level.bgb[name].ref_count++;
    return var_ad8303b0;
}

// Namespace bgb
// Params 1, eflags: 0x0
// Checksum 0x1dc94792, Offset: 0x3330
// Size: 0x52
function decrement_ref_count(name) {
    if (!isdefined(level.bgb[name])) {
        return 0;
    }
    level.bgb[name].ref_count--;
    return level.bgb[name].ref_count;
}

// Namespace bgb
// Params 2, eflags: 0x4
// Checksum 0xaf7d7b74, Offset: 0x3390
// Size: 0x92
function private calc_remaining_duration_lerp(start_time, end_time) {
    if (0 >= end_time - start_time) {
        return 0;
    }
    now = gettime();
    frac = float(end_time - now) / float(end_time - start_time);
    return math::clamp(frac, 0, 1);
}

// Namespace bgb
// Params 2, eflags: 0x4
// Checksum 0xcde8a8e, Offset: 0x3430
// Size: 0xd8
function private function_f9fad8b3(var_eeab9300, percent) {
    self endon(#"disconnect");
    self endon(#"hash_f9fad8b3");
    start_time = gettime();
    end_time = start_time + 1000;
    var_6d8b0ec7 = var_eeab9300;
    while (var_6d8b0ec7 > percent) {
        var_6d8b0ec7 = lerpfloat(percent, var_eeab9300, calc_remaining_duration_lerp(start_time, end_time));
        self clientfield::set_player_uimodel("bgb_timer", var_6d8b0ec7);
        wait 0.05;
    }
}

// Namespace bgb
// Params 1, eflags: 0x4
// Checksum 0x90df0bdf, Offset: 0x3510
// Size: 0xac
function private bgb_set_timer_clientfield(percent) {
    self notify(#"hash_f9fad8b3");
    var_eeab9300 = self clientfield::get_player_uimodel("bgb_timer");
    if (percent < var_eeab9300 && 0.1 <= var_eeab9300 - percent) {
        self thread function_f9fad8b3(var_eeab9300, percent);
        return;
    }
    self clientfield::set_player_uimodel("bgb_timer", percent);
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0x84f0b914, Offset: 0x35c8
// Size: 0x1c
function private function_497386b0() {
    self bgb_set_timer_clientfield(1);
}

// Namespace bgb
// Params 2, eflags: 0x0
// Checksum 0x425fdfe8, Offset: 0x35f0
// Size: 0x34
function set_timer(current, max) {
    self bgb_set_timer_clientfield(current / max);
}

// Namespace bgb
// Params 1, eflags: 0x0
// Checksum 0x57c0f587, Offset: 0x3630
// Size: 0x9c
function run_timer(max) {
    self endon(#"disconnect");
    self notify(#"bgb_run_timer");
    self endon(#"bgb_run_timer");
    for (current = max; current > 0; current -= 0.05) {
        self set_timer(current, max);
        wait 0.05;
    }
    self clear_timer();
}

// Namespace bgb
// Params 0, eflags: 0x0
// Checksum 0xa40abfcd, Offset: 0x36d8
// Size: 0x2a
function clear_timer() {
    self bgb_set_timer_clientfield(0);
    self notify(#"bgb_run_timer");
}

// Namespace bgb
// Params 7, eflags: 0x0
// Checksum 0x294e0264, Offset: 0x3710
// Size: 0x530
function register(name, limit_type, limit, enable_func, disable_func, validation_func, activation_func) {
    assert(isdefined(name), "<dev string:x19f>");
    assert("<dev string:x8b>" != name, "<dev string:x1c5>" + "<dev string:x8b>" + "<dev string:x1e7>");
    assert(!isdefined(level.bgb[name]), "<dev string:x21e>" + name + "<dev string:x235>");
    assert(isdefined(limit_type), "<dev string:x21e>" + name + "<dev string:x253>");
    assert(isdefined(limit), "<dev string:x21e>" + name + "<dev string:x271>");
    assert(!isdefined(enable_func) || isfunctionptr(enable_func), "<dev string:x21e>" + name + "<dev string:x28a>");
    assert(!isdefined(disable_func) || isfunctionptr(disable_func), "<dev string:x21e>" + name + "<dev string:x2c1>");
    switch (limit_type) {
    case "activated":
        assert(!isdefined(validation_func) || isfunctionptr(validation_func), "<dev string:x21e>" + name + "<dev string:x2f9>" + limit_type + "<dev string:x345>");
        assert(isdefined(activation_func), "<dev string:x21e>" + name + "<dev string:x347>" + limit_type + "<dev string:x345>");
        assert(isfunctionptr(activation_func), "<dev string:x21e>" + name + "<dev string:x37b>" + limit_type + "<dev string:x345>");
    case "rounds":
    case "time":
        assert(isint(limit), "<dev string:x21e>" + name + "<dev string:x3ba>" + limit + "<dev string:x3c5>" + limit_type + "<dev string:x345>");
        break;
    case "event":
        assert(isfunctionptr(limit), "<dev string:x21e>" + name + "<dev string:x3e7>" + limit_type + "<dev string:x345>");
        break;
    default:
        assert(0, "<dev string:x21e>" + name + "<dev string:x17c>" + limit_type + "<dev string:x18c>");
        break;
    }
    level.bgb[name] = spawnstruct();
    level.bgb[name].name = name;
    level.bgb[name].limit_type = limit_type;
    level.bgb[name].limit = limit;
    level.bgb[name].enable_func = enable_func;
    level.bgb[name].disable_func = disable_func;
    if ("activated" == limit_type) {
        level.bgb[name].validation_func = validation_func;
        level.bgb[name].activation_func = activation_func;
        level.bgb[name].var_336ffc4e = 0;
    }
    level.bgb[name].ref_count = 0;
}

// Namespace bgb
// Params 2, eflags: 0x0
// Checksum 0xb600ce11, Offset: 0x3c48
// Size: 0x68
function register_actor_damage_override(name, actor_damage_override_func) {
    assert(isdefined(level.bgb[name]), "<dev string:x41c>" + name + "<dev string:x449>");
    level.bgb[name].actor_damage_override_func = actor_damage_override_func;
}

// Namespace bgb
// Params 2, eflags: 0x0
// Checksum 0x28f077e3, Offset: 0x3cb8
// Size: 0x68
function register_vehicle_damage_override(name, vehicle_damage_override_func) {
    assert(isdefined(level.bgb[name]), "<dev string:x460>" + name + "<dev string:x449>");
    level.bgb[name].vehicle_damage_override_func = vehicle_damage_override_func;
}

// Namespace bgb
// Params 2, eflags: 0x0
// Checksum 0xb5137758, Offset: 0x3d28
// Size: 0x68
function register_actor_death_override(name, actor_death_override_func) {
    assert(isdefined(level.bgb[name]), "<dev string:x48f>" + name + "<dev string:x449>");
    level.bgb[name].actor_death_override_func = actor_death_override_func;
}

// Namespace bgb
// Params 3, eflags: 0x0
// Checksum 0x75a50890, Offset: 0x3d98
// Size: 0x8c
function register_lost_perk_override(name, lost_perk_override_func, lost_perk_override_func_always_run) {
    assert(isdefined(level.bgb[name]), "<dev string:x4bb>" + name + "<dev string:x449>");
    level.bgb[name].lost_perk_override_func = lost_perk_override_func;
    level.bgb[name].lost_perk_override_func_always_run = lost_perk_override_func_always_run;
}

// Namespace bgb
// Params 3, eflags: 0x0
// Checksum 0xcd6631bb, Offset: 0x3e30
// Size: 0x8c
function function_ff4b2998(name, add_to_player_score_override_func, add_to_player_score_override_func_always_run) {
    assert(isdefined(level.bgb[name]), "<dev string:x4e5>" + name + "<dev string:x449>");
    level.bgb[name].add_to_player_score_override_func = add_to_player_score_override_func;
    level.bgb[name].add_to_player_score_override_func_always_run = add_to_player_score_override_func_always_run;
}

// Namespace bgb
// Params 2, eflags: 0x0
// Checksum 0xc631f42d, Offset: 0x3ec8
// Size: 0x68
function function_4cda71bf(name, var_7ca0e2a7) {
    assert(isdefined(level.bgb[name]), "<dev string:x519>" + name + "<dev string:x449>");
    level.bgb[name].var_7ca0e2a7 = var_7ca0e2a7;
}

// Namespace bgb
// Params 2, eflags: 0x0
// Checksum 0xe1943fd8, Offset: 0x3f38
// Size: 0x68
function function_93da425(name, var_35e23ba2) {
    assert(isdefined(level.bgb[name]), "<dev string:x54f>" + name + "<dev string:x449>");
    level.bgb[name].var_35e23ba2 = var_35e23ba2;
}

// Namespace bgb
// Params 1, eflags: 0x0
// Checksum 0x1163c55b, Offset: 0x3fa8
// Size: 0x60
function function_2060b89(name) {
    assert(isdefined(level.bgb[name]), "<dev string:x57b>" + name + "<dev string:x449>");
    level.bgb[name].var_50fe45f6 = 1;
}

// Namespace bgb
// Params 1, eflags: 0x0
// Checksum 0x3f20e3af, Offset: 0x4010
// Size: 0x60
function function_f132da9c(name) {
    assert(isdefined(level.bgb[name]), "<dev string:x59e>" + name + "<dev string:x449>");
    level.bgb[name].var_7ea552f4 = 1;
}

// Namespace bgb
// Params 1, eflags: 0x0
// Checksum 0xa8e2effa, Offset: 0x4078
// Size: 0x4c
function function_d35f60a1(name) {
    unlocked = function_64f7cbc3();
    if (unlocked) {
        self give(name);
    }
}

// Namespace bgb
// Params 1, eflags: 0x0
// Checksum 0xc2f91b7e, Offset: 0x40d0
// Size: 0x1c4
function give(name) {
    self thread take();
    if ("none" == name) {
        return;
    }
    assert(isdefined(level.bgb[name]), "<dev string:x5ce>" + name + "<dev string:x449>");
    self notify(#"bgb_update", name, self.bgb);
    self notify("bgb_update_give_" + name);
    self.bgb = name;
    self clientfield::set_player_uimodel("bgb_current", level.bgb[name].item_index);
    self luinotifyevent(%zombie_bgb_notification, 1, level.bgb[name].item_index);
    if (isdefined(level.bgb[name].enable_func)) {
        self thread [[ level.bgb[name].enable_func ]]();
    }
    if (isdefined("activated" == level.bgb[name].limit_type)) {
        self setactionslot(1, "bgb");
    }
    self thread bgb_limit_monitor();
    self thread bgb_bled_out_monitor();
}

// Namespace bgb
// Params 0, eflags: 0x0
// Checksum 0x1ce0d3ee, Offset: 0x42a0
// Size: 0xf8
function take() {
    if ("none" == self.bgb) {
        return;
    }
    self setactionslot(1, "");
    self thread bgb_set_debug_text("none");
    if (isdefined(level.bgb[self.bgb].disable_func)) {
        self thread [[ level.bgb[self.bgb].disable_func ]]();
    }
    self bgb_clear_monitors_and_clientfields();
    self notify(#"bgb_update", "none", self.bgb);
    self notify("bgb_update_take_" + self.bgb);
    self.bgb = "none";
}

// Namespace bgb
// Params 0, eflags: 0x0
// Checksum 0xbaec966, Offset: 0x43a0
// Size: 0xa
function get_enabled() {
    return self.bgb;
}

// Namespace bgb
// Params 1, eflags: 0x0
// Checksum 0x369a99aa, Offset: 0x43b8
// Size: 0x38
function is_enabled(name) {
    assert(isdefined(self.bgb));
    return self.bgb == name;
}

// Namespace bgb
// Params 0, eflags: 0x0
// Checksum 0x4a6feaac, Offset: 0x43f8
// Size: 0x34
function any_enabled() {
    assert(isdefined(self.bgb));
    return self.bgb !== "none";
}

// Namespace bgb
// Params 1, eflags: 0x0
// Checksum 0xdd73cecb, Offset: 0x4438
// Size: 0xc2
function is_team_enabled(str_name) {
    foreach (player in level.players) {
        assert(isdefined(player.bgb));
        if (player.bgb == str_name) {
            return true;
        }
    }
    return false;
}

// Namespace bgb
// Params 0, eflags: 0x0
// Checksum 0x1db6d96, Offset: 0x4508
// Size: 0x88
function get_player_dropped_powerup_origin() {
    powerup_origin = self.origin + vectorscale(anglestoforward((0, self getplayerangles()[1], 0)), 60) + (0, 0, 5);
    self zm_stats::increment_challenge_stat("GUM_GOBBLER_POWERUPS");
    return powerup_origin;
}

// Namespace bgb
// Params 2, eflags: 0x0
// Checksum 0xadf187f6, Offset: 0x4598
// Size: 0xc4
function function_dea74fb0(str_powerup, v_origin) {
    if (!isdefined(v_origin)) {
        v_origin = self get_player_dropped_powerup_origin();
    }
    e_powerup = zm_powerups::specific_powerup_drop(str_powerup, v_origin);
    wait 1;
    if (!e_powerup zm::in_enabled_playable_area() && isdefined(e_powerup) && !e_powerup zm::in_life_brush()) {
        level thread function_434235f9(e_powerup);
    }
}

// Namespace bgb
// Params 1, eflags: 0x0
// Checksum 0x7eed9115, Offset: 0x4668
// Size: 0x37c
function function_434235f9(e_powerup) {
    if (!isdefined(e_powerup)) {
        return;
    }
    e_powerup ghost();
    e_powerup.var_499ed1ba = util::spawn_model(e_powerup.model, e_powerup.origin, e_powerup.angles);
    e_powerup.var_499ed1ba linkto(e_powerup);
    direction = e_powerup.origin;
    direction = (direction[1], direction[0], 0);
    if (direction[0] > 0 && (direction[1] < 0 || direction[1] > 0)) {
        direction = (direction[0], direction[1] * -1, 0);
    } else if (direction[0] < 0) {
        direction = (direction[0] * -1, direction[1], 0);
    }
    if (!(isdefined(e_powerup.sndnosamlaugh) && e_powerup.sndnosamlaugh)) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (isalive(players[i])) {
                players[i] playlocalsound(level.zmb_laugh_alias);
            }
        }
    }
    playfxontag(level._effect["samantha_steal"], e_powerup, "tag_origin");
    e_powerup.var_499ed1ba unlink();
    e_powerup.var_499ed1ba movez(60, 1, 0.25, 0.25);
    e_powerup.var_499ed1ba vibrate(direction, 1.5, 2.5, 1);
    e_powerup.var_499ed1ba waittill(#"movedone");
    if (isdefined(self.damagearea)) {
        self.damagearea delete();
    }
    e_powerup.var_499ed1ba delete();
    if (isdefined(e_powerup)) {
        if (isdefined(e_powerup.damagearea)) {
            e_powerup.damagearea delete();
        }
        e_powerup zm_powerups::powerup_delete();
    }
}

// Namespace bgb
// Params 12, eflags: 0x0
// Checksum 0x2ea7af6e, Offset: 0x49f0
// Size: 0x150
function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return damage;
    }
    if (isplayer(attacker)) {
        name = attacker get_enabled();
        if (name !== "none" && isdefined(level.bgb[name]) && isdefined(level.bgb[name].actor_damage_override_func)) {
            damage = [[ level.bgb[name].actor_damage_override_func ]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
        }
    }
    return damage;
}

// Namespace bgb
// Params 15, eflags: 0x0
// Checksum 0x8ccdaa93, Offset: 0x4b48
// Size: 0x174
function vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return idamage;
    }
    if (isplayer(eattacker)) {
        name = eattacker get_enabled();
        if (name !== "none" && isdefined(level.bgb[name]) && isdefined(level.bgb[name].vehicle_damage_override_func)) {
            idamage = [[ level.bgb[name].vehicle_damage_override_func ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
        }
    }
    return idamage;
}

// Namespace bgb
// Params 1, eflags: 0x0
// Checksum 0xd80802ea, Offset: 0x4cc8
// Size: 0xd4
function actor_death_override(attacker) {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return 0;
    }
    if (isplayer(attacker)) {
        name = attacker get_enabled();
        if (name !== "none" && isdefined(level.bgb[name]) && isdefined(level.bgb[name].actor_death_override_func)) {
            damage = [[ level.bgb[name].actor_death_override_func ]](attacker);
        }
    }
    return damage;
}

// Namespace bgb
// Params 1, eflags: 0x0
// Checksum 0x3e1114e7, Offset: 0x4da8
// Size: 0x254
function lost_perk_override(perk) {
    b_result = 0;
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return b_result;
    }
    if (!(isdefined(self.laststand) && self.laststand)) {
        return b_result;
    }
    keys = getarraykeys(level.bgb);
    for (i = 0; i < keys.size; i++) {
        name = keys[i];
        if (isdefined(level.bgb[name].lost_perk_override_func_always_run) && level.bgb[name].lost_perk_override_func_always_run && isdefined(level.bgb[name].lost_perk_override_func)) {
            b_result = [[ level.bgb[name].lost_perk_override_func ]](perk, self, undefined);
            if (b_result) {
                return b_result;
            }
        }
    }
    foreach (player in level.activeplayers) {
        name = player get_enabled();
        if (name !== "none" && isdefined(level.bgb[name]) && isdefined(level.bgb[name].lost_perk_override_func)) {
            b_result = [[ level.bgb[name].lost_perk_override_func ]](perk, self, player);
            if (b_result) {
                return b_result;
            }
        }
    }
    return b_result;
}

// Namespace bgb
// Params 2, eflags: 0x0
// Checksum 0xfc6e925f, Offset: 0x5008
// Size: 0x1c4
function add_to_player_score_override(n_points, str_awarded_by) {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return n_points;
    }
    str_enabled = self get_enabled();
    keys = getarraykeys(level.bgb);
    for (i = 0; i < keys.size; i++) {
        str_bgb = keys[i];
        if (str_bgb === str_enabled) {
            continue;
        }
        if (isdefined(level.bgb[str_bgb].add_to_player_score_override_func_always_run) && level.bgb[str_bgb].add_to_player_score_override_func_always_run && isdefined(level.bgb[str_bgb].add_to_player_score_override_func)) {
            n_points = [[ level.bgb[str_bgb].add_to_player_score_override_func ]](n_points, str_awarded_by, 0);
        }
    }
    if (str_enabled !== "none" && isdefined(level.bgb[str_enabled]) && isdefined(level.bgb[str_enabled].add_to_player_score_override_func)) {
        n_points = [[ level.bgb[str_enabled].add_to_player_score_override_func ]](n_points, str_awarded_by, 1);
    }
    return n_points;
}

// Namespace bgb
// Params 0, eflags: 0x0
// Checksum 0x5fcf4fae, Offset: 0x51d8
// Size: 0xc4
function function_d51db887() {
    keys = array::randomize(getarraykeys(level.bgb));
    for (i = 0; i < keys.size; i++) {
        if (level.bgb[keys[i]].rarity != 1) {
            continue;
        }
        if (level.bgb[keys[i]].dlc_index > 0) {
            continue;
        }
        return keys[i];
    }
}

// Namespace bgb
// Params 3, eflags: 0x0
// Checksum 0x23d70b86, Offset: 0x52a8
// Size: 0x20c
function function_4ed517b9(n_max_distance, var_98a3e738, var_287a7adb) {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"bgb_update");
    self.var_6638f10b = [];
    while (true) {
        foreach (e_player in level.players) {
            if (e_player == self) {
                continue;
            }
            array::remove_undefined(self.var_6638f10b);
            var_368e2240 = array::contains(self.var_6638f10b, e_player);
            var_50fd5a04 = zm_utility::is_player_valid(e_player, 0, 1) && function_2469cfe8(n_max_distance, self, e_player);
            if (!var_368e2240 && var_50fd5a04) {
                array::add(self.var_6638f10b, e_player, 0);
                if (isdefined(var_98a3e738)) {
                    self thread [[ var_98a3e738 ]](e_player);
                }
                continue;
            }
            if (var_368e2240 && !var_50fd5a04) {
                arrayremovevalue(self.var_6638f10b, e_player);
                if (isdefined(var_287a7adb)) {
                    self thread [[ var_287a7adb ]](e_player);
                }
            }
        }
        wait 0.05;
    }
}

// Namespace bgb
// Params 3, eflags: 0x4
// Checksum 0x6c2a4f72, Offset: 0x54c0
// Size: 0x7e
function private function_2469cfe8(n_distance, var_d21815c4, var_441f84ff) {
    var_31dc18aa = n_distance * n_distance;
    var_2931dc75 = distancesquared(var_d21815c4.origin, var_441f84ff.origin);
    if (var_2931dc75 <= var_31dc18aa) {
        return true;
    }
    return false;
}

// Namespace bgb
// Params 0, eflags: 0x0
// Checksum 0x194165cc, Offset: 0x5548
// Size: 0x44
function function_ca189700() {
    self clientfield::increment_uimodel("bgb_invalid_use");
    self playlocalsound("zmb_bgb_deny_plr");
}

// Namespace bgb
// Params 0, eflags: 0x0
// Checksum 0xbb0ca501, Offset: 0x5598
// Size: 0x24
function suspend_weapon_cycling() {
    self flag::clear("bgb_weapon_cycling");
}

// Namespace bgb
// Params 0, eflags: 0x0
// Checksum 0x5e7c3417, Offset: 0x55c8
// Size: 0x24
function resume_weapon_cycling() {
    self flag::set("bgb_weapon_cycling");
}

// Namespace bgb
// Params 0, eflags: 0x0
// Checksum 0xee0c457d, Offset: 0x55f8
// Size: 0x64
function init_weapon_cycling() {
    if (!self flag::exists("bgb_weapon_cycling")) {
        self flag::init("bgb_weapon_cycling");
    }
    self flag::set("bgb_weapon_cycling");
}

// Namespace bgb
// Params 0, eflags: 0x0
// Checksum 0xaccef0b8, Offset: 0x5668
// Size: 0x24
function function_378bff5d() {
    self flag::wait_till("bgb_weapon_cycling");
}

// Namespace bgb
// Params 1, eflags: 0x0
// Checksum 0x8adbaae7, Offset: 0x5698
// Size: 0x1a4
function revive_and_return_perk_on_bgb_activation(perk) {
    self notify("revive_and_return_perk_on_bgb_activation" + perk);
    self endon("revive_and_return_perk_on_bgb_activation" + perk);
    self endon(#"disconnect");
    self endon(#"bled_out");
    if (perk == "specialty_widowswine") {
        var_376ad33c = self getweaponammoclip(self.var_8980476);
    }
    self waittill(#"player_revived", e_reviver);
    if (isdefined(e_reviver.bgb) && (isdefined(self.bgb) && isdefined(e_reviver) && self is_enabled("zm_bgb_near_death_experience") || isdefined(self.var_df0decf1) && self.var_df0decf1 || e_reviver is_enabled("zm_bgb_near_death_experience"))) {
        if (zm_perks::function_23ee6fc() && perk == "specialty_quickrevive") {
            level.solo_game_free_player_quickrevive = 1;
        }
        wait 0.05;
        self thread zm_perks::give_perk(perk, 0);
        if (perk == "specialty_widowswine" && isdefined(var_376ad33c)) {
            self setweaponammoclip(self.var_8980476, var_376ad33c);
        }
    }
}

// Namespace bgb
// Params 0, eflags: 0x0
// Checksum 0x37e45910, Offset: 0x5848
// Size: 0x72
function bgb_revive_watcher() {
    self endon(#"disconnect");
    self endon(#"death");
    self.var_df0decf1 = 1;
    self waittill(#"player_revived", e_reviver);
    wait 0.05;
    if (isdefined(self.var_df0decf1) && self.var_df0decf1) {
        self notify(#"bgb_revive");
        self.var_df0decf1 = undefined;
    }
}

