#using scripts/codescripts/struct;
#using scripts/shared/aat_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_bb;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_daily_challenges;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace zm_magicbox;

// Namespace zm_magicbox
// Params 0, eflags: 0x2
// Checksum 0x1c582414, Offset: 0x7c0
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_magicbox", &__init__, &__main__, undefined);
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x5d65ca71, Offset: 0x808
// Size: 0x16c
function __init__() {
    level.start_chest_name = "start_chest";
    level._effect["lght_marker"] = "zombie/fx_weapon_box_marker_zmb";
    level._effect["lght_marker_flare"] = "zombie/fx_weapon_box_marker_fl_zmb";
    level._effect["poltergeist"] = "zombie/fx_barrier_buy_zmb";
    clientfield::register("zbarrier", "magicbox_open_glow", 1, 1, "int");
    clientfield::register("zbarrier", "magicbox_closed_glow", 1, 1, "int");
    clientfield::register("zbarrier", "zbarrier_show_sounds", 1, 1, "counter");
    clientfield::register("zbarrier", "zbarrier_leave_sounds", 1, 1, "counter");
    clientfield::register("scriptmover", "force_stream", 7000, 1, "int");
    level thread magicbox_host_migration();
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x616753f4, Offset: 0x980
// Size: 0xbc
function __main__() {
    if (!isdefined(level.chest_joker_model)) {
        level.chest_joker_model = "p7_zm_teddybear";
    }
    if (!isdefined(level.magic_box_zbarrier_state_func)) {
        level.magic_box_zbarrier_state_func = &process_magic_box_zbarrier_state;
    }
    if (!isdefined(level.magic_box_check_equipment)) {
        level.magic_box_check_equipment = &default_magic_box_check_equipment;
    }
    wait 0.05;
    if (zm_utility::is_classic()) {
        level.chests = struct::get_array("treasure_chest_use", "targetname");
        treasure_chest_init(level.start_chest_name);
    }
}

// Namespace zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0xc6a45f99, Offset: 0xa48
// Size: 0x2f4
function treasure_chest_init(start_chest_name) {
    level flag::init("moving_chest_enabled");
    level flag::init("moving_chest_now");
    level flag::init("chest_has_been_used");
    level.chest_moves = 0;
    level.chest_level = 0;
    if (level.chests.size == 0) {
        return;
    }
    for (i = 0; i < level.chests.size; i++) {
        level.chests[i].box_hacks = [];
        level.chests[i].orig_origin = level.chests[i].origin;
        level.chests[i] get_chest_pieces();
        if (isdefined(level.chests[i].zombie_cost)) {
            level.chests[i].old_cost = level.chests[i].zombie_cost;
            continue;
        }
        level.chests[i].old_cost = 950;
    }
    if (!level.enable_magic) {
        foreach (chest in level.chests) {
            chest hide_chest();
        }
        return;
    }
    level.chest_accessed = 0;
    if (level.chests.size > 1) {
        level flag::set("moving_chest_enabled");
        level.chests = array::randomize(level.chests);
    } else {
        level.chest_index = 0;
        level.chests[0].no_fly_away = 1;
    }
    init_starting_chest_location(start_chest_name);
    array::thread_all(level.chests, &treasure_chest_think);
}

// Namespace zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x9bd6cc7f, Offset: 0xd48
// Size: 0x3cc
function init_starting_chest_location(start_chest_name) {
    level.chest_index = 0;
    start_chest_found = 0;
    if (level.chests.size == 1) {
        start_chest_found = 1;
        if (isdefined(level.chests[level.chest_index].zbarrier)) {
            level.chests[level.chest_index].zbarrier set_magic_box_zbarrier_state("initial");
            level.chests[level.chest_index] thread function_14a6411c();
        }
    } else {
        for (i = 0; i < level.chests.size; i++) {
            if (isdefined(level.random_pandora_box_start) && level.random_pandora_box_start == 1) {
                if (isdefined(level.chests[i].start_exclude) && (start_chest_found || level.chests[i].start_exclude == 1)) {
                    level.chests[i] hide_chest();
                } else {
                    level.chest_index = i;
                    level.chests[level.chest_index].hidden = 0;
                    if (isdefined(level.chests[level.chest_index].zbarrier)) {
                        level.chests[level.chest_index].zbarrier set_magic_box_zbarrier_state("initial");
                        level.chests[level.chest_index] thread function_14a6411c();
                    }
                    start_chest_found = 1;
                }
                continue;
            }
            if (start_chest_found || !isdefined(level.chests[i].script_noteworthy) || !issubstr(level.chests[i].script_noteworthy, start_chest_name)) {
                level.chests[i] hide_chest();
                continue;
            }
            level.chest_index = i;
            level.chests[level.chest_index].hidden = 0;
            if (isdefined(level.chests[level.chest_index].zbarrier)) {
                level.chests[level.chest_index].zbarrier set_magic_box_zbarrier_state("initial");
                level.chests[level.chest_index] thread function_14a6411c();
            }
            start_chest_found = 1;
        }
    }
    if (!isdefined(level.pandora_show_func)) {
        if (isdefined(level.custom_pandora_show_func)) {
            level.pandora_show_func = level.custom_pandora_show_func;
        } else {
            level.pandora_show_func = &default_pandora_show_func;
        }
    }
    level.chests[level.chest_index] thread [[ level.pandora_show_func ]]();
}

// Namespace zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x4b961495, Offset: 0x1120
// Size: 0x18
function set_treasure_chest_cost(cost) {
    level.zombie_treasure_chest_cost = cost;
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x96ceed19, Offset: 0x1140
// Size: 0x2a0
function get_chest_pieces() {
    self.chest_box = getent(self.script_noteworthy + "_zbarrier", "script_noteworthy");
    self.chest_rubble = [];
    rubble = getentarray(self.script_noteworthy + "_rubble", "script_noteworthy");
    for (i = 0; i < rubble.size; i++) {
        if (distancesquared(self.origin, rubble[i].origin) < 10000) {
            self.chest_rubble[self.chest_rubble.size] = rubble[i];
        }
    }
    self.zbarrier = getent(self.script_noteworthy + "_zbarrier", "script_noteworthy");
    if (isdefined(self.zbarrier)) {
        self.zbarrier zbarrierpieceuseboxriselogic(3);
        self.zbarrier zbarrierpieceuseboxriselogic(4);
    }
    self.unitrigger_stub = spawnstruct();
    self.unitrigger_stub.origin = self.origin + anglestoright(self.angles) * -22.5;
    self.unitrigger_stub.angles = self.angles;
    self.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    self.unitrigger_stub.script_width = 104;
    self.unitrigger_stub.script_height = 50;
    self.unitrigger_stub.script_length = 45;
    self.unitrigger_stub.trigger_target = self;
    zm_unitrigger::unitrigger_force_per_player_triggers(self.unitrigger_stub, 1);
    self.unitrigger_stub.prompt_and_visibility_func = &boxtrigger_update_prompt;
    self.zbarrier.owner = self;
}

// Namespace zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0xcb44a37e, Offset: 0x13e8
// Size: 0x90
function boxtrigger_update_prompt(player) {
    can_use = self boxstub_update_prompt(player);
    if (isdefined(self.hint_string)) {
        if (isdefined(self.hint_parm1)) {
            self sethintstring(self.hint_string, self.hint_parm1);
        } else {
            self sethintstring(self.hint_string);
        }
    }
    return can_use;
}

// Namespace zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0xe988b015, Offset: 0x1480
// Size: 0x198
function boxstub_update_prompt(player) {
    if (!self trigger_visible_to_player(player)) {
        return false;
    }
    if (isdefined(level.func_magicbox_update_prompt_use_override)) {
        if ([[ level.func_magicbox_update_prompt_use_override ]]()) {
            return false;
        }
    }
    self.hint_parm1 = undefined;
    if (isdefined(self.stub.trigger_target.grab_weapon_hint) && self.stub.trigger_target.grab_weapon_hint) {
        cursor_hint = "HINT_WEAPON";
        cursor_hint_weapon = self.stub.trigger_target.grab_weapon;
        self setcursorhint(cursor_hint, cursor_hint_weapon);
        if (isdefined(level.magic_box_check_equipment) && [[ level.magic_box_check_equipment ]](cursor_hint_weapon)) {
            self.hint_string = %ZOMBIE_TRADE_EQUIP_FILL;
        } else {
            self.hint_string = %ZOMBIE_TRADE_WEAPON_FILL;
        }
    } else {
        self setcursorhint("HINT_NOICON");
        self.hint_parm1 = self.stub.trigger_target.zombie_cost;
        self.hint_string = zm_utility::get_hint_string(self, "default_treasure_chest");
    }
    return true;
}

// Namespace zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x6100dbf1, Offset: 0x1620
// Size: 0x22
function default_magic_box_check_equipment(weapon) {
    return zm_utility::is_offhand_weapon(weapon);
}

// Namespace zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0xb6066895, Offset: 0x1650
// Size: 0x178
function trigger_visible_to_player(player) {
    self setinvisibletoplayer(player);
    visible = 1;
    if (isdefined(self.stub.trigger_target.chest_user) && !isdefined(self.stub.trigger_target.box_rerespun)) {
        if (player != self.stub.trigger_target.chest_user || zm_utility::is_placeable_mine(self.stub.trigger_target.chest_user getcurrentweapon()) || self.stub.trigger_target.chest_user zm_equipment::hacker_active()) {
            visible = 0;
        }
    } else if (!player can_buy_weapon()) {
        visible = 0;
    }
    if (player bgb::is_enabled("zm_bgb_disorderly_combat")) {
        visible = 0;
    }
    if (!visible) {
        return false;
    }
    self setvisibletoplayer(player);
    return true;
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x7b81af1d, Offset: 0x17d0
// Size: 0x54
function magicbox_unitrigger_think() {
    self endon(#"kill_trigger");
    while (true) {
        self waittill(#"trigger", player);
        self.stub.trigger_target notify(#"trigger", player);
    }
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x6031fb69, Offset: 0x1830
// Size: 0x24
function play_crazi_sound() {
    self playlocalsound(level.zmb_laugh_alias);
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xbc3b882c, Offset: 0x1860
// Size: 0x10a
function show_chest() {
    self.zbarrier set_magic_box_zbarrier_state("arriving");
    self.zbarrier util::waittill_any_timeout(5, "arrived");
    self thread [[ level.pandora_show_func ]]();
    self.zbarrier clientfield::set("magicbox_closed_glow", 1);
    thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &magicbox_unitrigger_think);
    self.zbarrier clientfield::increment("zbarrier_show_sounds");
    self.hidden = 0;
    if (isdefined(self.box_hacks["summon_box"])) {
        self [[ self.box_hacks["summon_box"] ]](0);
    }
}

// Namespace zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0xc39f2666, Offset: 0x1978
// Size: 0x21c
function hide_chest(doboxleave) {
    if (isdefined(self.unitrigger_stub)) {
        thread zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
    }
    if (isdefined(self.pandora_light)) {
        self.pandora_light delete();
    }
    self.zbarrier clientfield::set("magicbox_closed_glow", 0);
    self.hidden = 1;
    if (isdefined(self.box_hacks) && isdefined(self.box_hacks["summon_box"])) {
        self [[ self.box_hacks["summon_box"] ]](1);
    }
    if (isdefined(self.zbarrier)) {
        if (isdefined(doboxleave) && doboxleave) {
            self.zbarrier clientfield::increment("zbarrier_leave_sounds");
            level thread zm_audio::sndannouncerplayvox("boxmove");
            self.zbarrier thread magic_box_zbarrier_leave();
            self.zbarrier waittill(#"left");
            playfx(level._effect["poltergeist"], self.zbarrier.origin, anglestoup(self.zbarrier.angles), anglestoforward(self.zbarrier.angles));
            playsoundatposition("zmb_box_poof", self.zbarrier.origin);
            return;
        }
        self.zbarrier thread set_magic_box_zbarrier_state("away");
    }
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x7dad4ee4, Offset: 0x1ba0
// Size: 0x4c
function magic_box_zbarrier_leave() {
    self set_magic_box_zbarrier_state("leaving");
    self waittill(#"left");
    self set_magic_box_zbarrier_state("away");
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x2121959c, Offset: 0x1bf8
// Size: 0x11c
function default_pandora_fx_func() {
    self endon(#"death");
    self.pandora_light = spawn("script_model", self.zbarrier.origin);
    self.pandora_light.angles = self.zbarrier.angles + (-90, 0, -90);
    self.pandora_light setmodel("tag_origin");
    if (!(isdefined(level._box_initialized) && level._box_initialized)) {
        level flag::wait_till("start_zombie_round_logic");
        level._box_initialized = 1;
    }
    wait 1;
    if (isdefined(self) && isdefined(self.pandora_light)) {
        playfxontag(level._effect["lght_marker"], self.pandora_light, "tag_origin");
    }
}

// Namespace zm_magicbox
// Params 3, eflags: 0x0
// Checksum 0x2f60e6a9, Offset: 0x1d20
// Size: 0x94
function default_pandora_show_func(anchor, anchortarget, pieces) {
    if (!isdefined(self.pandora_light)) {
        if (!isdefined(level.pandora_fx_func)) {
            level.pandora_fx_func = &default_pandora_fx_func;
        }
        self thread [[ level.pandora_fx_func ]]();
    }
    playfx(level._effect["lght_marker_flare"], self.pandora_light.origin);
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xd7b871be, Offset: 0x1dc0
// Size: 0x44
function unregister_unitrigger_on_kill_think() {
    self notify(#"unregister_unitrigger_on_kill_think");
    self endon(#"unregister_unitrigger_on_kill_think");
    self waittill(#"kill_chest_think");
    thread zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x154fa84c, Offset: 0x1e10
// Size: 0xf04
function treasure_chest_think() {
    self endon(#"kill_chest_think");
    user = undefined;
    user_cost = undefined;
    self.box_rerespun = undefined;
    self.weapon_out = undefined;
    self thread unregister_unitrigger_on_kill_think();
    while (true) {
        if (!isdefined(self.forced_user)) {
            self waittill(#"trigger", user);
            if (user == level) {
                continue;
            }
        } else {
            user = self.forced_user;
        }
        if (user zm_utility::in_revive_trigger()) {
            wait 0.1;
            continue;
        }
        if (user.is_drinking > 0) {
            wait 0.1;
            continue;
        }
        if (isdefined(self.disabled) && self.disabled) {
            wait 0.1;
            continue;
        }
        if (user getcurrentweapon() == level.weaponnone) {
            wait 0.1;
            continue;
        }
        if (isdefined(self.being_removed) && self.being_removed) {
            wait 0.1;
            continue;
        }
        reduced_cost = undefined;
        if (zm_utility::is_player_valid(user) && user namespace_25f8c2ad::function_dc08b4af()) {
            reduced_cost = int(self.zombie_cost / 2);
        }
        if (isdefined(self.auto_open) && zm_utility::is_player_valid(user)) {
            if (!isdefined(self.var_c20f8a07)) {
                user zm_score::minus_to_player_score(self.zombie_cost);
                user_cost = self.zombie_cost;
            } else {
                user_cost = 0;
            }
            self.chest_user = user;
            break;
        } else if (zm_utility::is_player_valid(user) && user zm_score::can_player_purchase(self.zombie_cost)) {
            user zm_score::minus_to_player_score(self.zombie_cost);
            user_cost = self.zombie_cost;
            self.chest_user = user;
            break;
        } else if (isdefined(reduced_cost) && user zm_score::can_player_purchase(reduced_cost)) {
            user zm_score::minus_to_player_score(reduced_cost);
            user_cost = reduced_cost;
            self.chest_user = user;
            break;
        } else if (!user zm_score::can_player_purchase(self.zombie_cost)) {
            zm_utility::play_sound_at_pos("no_purchase", self.origin);
            user zm_audio::create_and_play_dialog("general", "outofmoney");
            continue;
        }
        wait 0.05;
    }
    level flag::set("chest_has_been_used");
    demo::bookmark("zm_player_use_magicbox", gettime(), user);
    user zm_stats::increment_client_stat("use_magicbox");
    user zm_stats::increment_player_stat("use_magicbox");
    user zm_stats::increment_challenge_stat("SURVIVALIST_BUY_MAGIC_BOX");
    user zm_daily_challenges::increment_magic_box();
    if (isdefined(level.var_ee31d7a5)) {
        user thread [[ level.var_ee31d7a5 ]]();
    }
    self thread watch_for_emp_close();
    self._box_open = 1;
    self._box_opened_by_fire_sale = 0;
    if (isdefined(level.zombie_vars["zombie_powerup_fire_sale_on"]) && level.zombie_vars["zombie_powerup_fire_sale_on"] && !isdefined(self.auto_open) && self [[ level._zombiemode_check_firesale_loc_valid_func ]]()) {
        self._box_opened_by_fire_sale = 1;
    }
    if (isdefined(self.chest_lid)) {
        self.chest_lid thread treasure_chest_lid_open();
    }
    if (isdefined(self.zbarrier)) {
        zm_utility::play_sound_at_pos("open_chest", self.origin);
        zm_utility::play_sound_at_pos("music_chest", self.origin);
        self.zbarrier set_magic_box_zbarrier_state("open");
    }
    self.timedout = 0;
    self.weapon_out = 1;
    self.zbarrier thread treasure_chest_weapon_spawn(self, user);
    if (isdefined(level.custom_treasure_chest_glowfx)) {
        self.zbarrier thread [[ level.custom_treasure_chest_glowfx ]]();
    } else {
        self.zbarrier thread treasure_chest_glowfx();
    }
    thread zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
    self.zbarrier util::waittill_any("randomization_done", "box_hacked_respin");
    if (level flag::get("moving_chest_now") && !self._box_opened_by_fire_sale && isdefined(user_cost)) {
        user zm_score::add_to_player_score(user_cost, 0, "magicbox_bear");
    }
    if (level flag::get("moving_chest_now") && !level.zombie_vars["zombie_powerup_fire_sale_on"] && !self._box_opened_by_fire_sale) {
        self thread treasure_chest_move(self.chest_user);
    } else {
        if (!(isdefined(self.unbearable_respin) && self.unbearable_respin)) {
            self.grab_weapon_hint = 1;
            self.grab_weapon = self.zbarrier.weapon;
            self.chest_user = user;
            bb::logpurchaseevent(user, self, user_cost, self.grab_weapon, 0, "_magicbox", "_offered");
            weaponidx = undefined;
            if (isdefined(self.grab_weapon)) {
                weaponidx = matchrecordgetweaponindex(self.grab_weapon);
            }
            if (isdefined(weaponidx)) {
                user recordmapevent(10, gettime(), user.origin, level.round_number, weaponidx);
            }
            thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &magicbox_unitrigger_think);
            if (isdefined(self.zbarrier) && !(isdefined(self.zbarrier.var_672cb890) && self.zbarrier.var_672cb890)) {
                self thread treasure_chest_timeout();
            }
        }
        while (!(isdefined(self.var_672cb890) && self.var_672cb890)) {
            self waittill(#"trigger", grabber);
            self.weapon_out = undefined;
            if (isdefined(level.magic_box_grab_by_anyone) && level.magic_box_grab_by_anyone) {
                if (isplayer(grabber)) {
                    user = grabber;
                }
            }
            if (isdefined(level.var_55d2ea99) && level.var_55d2ea99) {
                self namespace_25f8c2ad::function_61be7933(user, grabber);
            }
            if (isdefined(grabber.is_drinking) && grabber.is_drinking > 0) {
                wait 0.1;
                continue;
            }
            if (grabber == user && user getcurrentweapon() == level.weaponnone) {
                wait 0.1;
                continue;
            }
            if (isdefined(self.box_rerespun) && grabber != level && self.box_rerespun) {
                user = grabber;
            }
            if (grabber == user || grabber == level) {
                self.box_rerespun = undefined;
                current_weapon = level.weaponnone;
                if (zm_utility::is_player_valid(user)) {
                    current_weapon = user getcurrentweapon();
                }
                if (grabber == user && zm_utility::is_player_valid(user) && !(user.is_drinking > 0) && !zm_utility::is_placeable_mine(current_weapon) && !zm_equipment::is_equipment(current_weapon) && !user zm_utility::is_player_revive_tool(current_weapon) && !current_weapon.isheroweapon && !current_weapon.isgadget) {
                    bb::logpurchaseevent(user, self, user_cost, self.zbarrier.weapon, 0, "_magicbox", "_grabbed");
                    weaponidx = undefined;
                    if (isdefined(self.zbarrier) && isdefined(self.zbarrier.weapon)) {
                        weaponidx = matchrecordgetweaponindex(self.zbarrier.weapon);
                    }
                    if (isdefined(weaponidx)) {
                        user recordmapevent(11, gettime(), user.origin, level.round_number, weaponidx);
                    }
                    self notify(#"user_grabbed_weapon");
                    user notify(#"user_grabbed_weapon");
                    user thread treasure_chest_give_weapon(self.zbarrier.weapon);
                    demo::bookmark("zm_player_grabbed_magicbox", gettime(), user);
                    user zm_stats::increment_client_stat("grabbed_from_magicbox");
                    user zm_stats::increment_player_stat("grabbed_from_magicbox");
                    break;
                } else if (grabber == level) {
                    self.timedout = 1;
                    bb::logpurchaseevent(user, self, user_cost, self.zbarrier.weapon, 0, "_magicbox", "_returned");
                    weaponidx = undefined;
                    if (isdefined(self.zbarrier) && isdefined(self.zbarrier.weapon)) {
                        weaponidx = matchrecordgetweaponindex(self.zbarrier.weapon);
                    }
                    if (isdefined(weaponidx)) {
                        user recordmapevent(12, gettime(), user.origin, level.round_number, weaponidx);
                    }
                    break;
                }
            }
            wait 0.05;
        }
        self.grab_weapon_hint = 0;
        self.zbarrier notify(#"weapon_grabbed");
        if (!(isdefined(self._box_opened_by_fire_sale) && self._box_opened_by_fire_sale)) {
            level.chest_accessed += 1;
        }
        thread zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
        if (isdefined(self.chest_lid)) {
            self.chest_lid thread treasure_chest_lid_close(self.timedout);
        }
        if (isdefined(self.zbarrier)) {
            self.zbarrier set_magic_box_zbarrier_state("close");
            zm_utility::play_sound_at_pos("close_chest", self.origin);
            self.zbarrier waittill(#"closed");
            wait 1;
        } else {
            wait 3;
        }
        if (isdefined(level.zombie_vars["zombie_powerup_fire_sale_on"]) && level.zombie_vars["zombie_powerup_fire_sale_on"] && self [[ level._zombiemode_check_firesale_loc_valid_func ]]() || self == level.chests[level.chest_index]) {
            thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &magicbox_unitrigger_think);
        }
    }
    self._box_open = 0;
    self._box_opened_by_fire_sale = 0;
    self.unbearable_respin = undefined;
    self.chest_user = undefined;
    self notify(#"chest_accessed");
    self thread treasure_chest_think();
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x58c22f9b, Offset: 0x2d20
// Size: 0x186
function watch_for_emp_close() {
    self endon(#"chest_accessed");
    self.var_672cb890 = 0;
    if (!zm_utility::should_watch_for_emp()) {
        return;
    }
    if (isdefined(self.zbarrier)) {
        self.zbarrier.var_672cb890 = 0;
    }
    while (true) {
        level waittill(#"emp_detonate", origin, radius);
        if (distancesquared(origin, self.origin) < radius * radius) {
            break;
        }
    }
    if (level flag::get("moving_chest_now")) {
        return;
    }
    self.var_672cb890 = 1;
    if (isdefined(self.zbarrier)) {
        self.zbarrier.var_672cb890 = 1;
        self.zbarrier notify(#"box_hacked_respin");
        if (isdefined(self.zbarrier.weapon_model)) {
            self.zbarrier.weapon_model notify(#"kill_weapon_movement");
        }
        if (isdefined(self.zbarrier.weapon_model_dw)) {
            self.zbarrier.weapon_model_dw notify(#"kill_weapon_movement");
        }
    }
    wait 0.1;
    self notify(#"trigger", level);
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x46c5bf59, Offset: 0x2eb0
// Size: 0xe2
function can_buy_weapon() {
    if (isdefined(self.is_drinking) && self.is_drinking > 0) {
        return false;
    }
    if (self zm_equipment::hacker_active()) {
        return false;
    }
    current_weapon = self getcurrentweapon();
    if (zm_utility::is_placeable_mine(current_weapon) || zm_equipment::is_equipment_that_blocks_purchase(current_weapon)) {
        return false;
    }
    if (self zm_utility::in_revive_trigger()) {
        return false;
    }
    if (current_weapon == level.weaponnone) {
        return false;
    }
    if (current_weapon.isheroweapon || current_weapon.isgadget) {
        return false;
    }
    return true;
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x26a26b03, Offset: 0x2fa0
// Size: 0x170
function default_box_move_logic() {
    index = -1;
    for (i = 0; i < level.chests.size; i++) {
        if (issubstr(level.chests[i].script_noteworthy, "move" + level.chest_moves + 1) && i != level.chest_index) {
            index = i;
            break;
        }
    }
    if (index != -1) {
        level.chest_index = index;
    } else {
        level.chest_index++;
    }
    if (level.chest_index >= level.chests.size) {
        temp_chest_name = level.chests[level.chest_index - 1].script_noteworthy;
        level.chest_index = 0;
        level.chests = array::randomize(level.chests);
        if (temp_chest_name == level.chests[level.chest_index].script_noteworthy) {
            level.chest_index++;
        }
    }
}

// Namespace zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0xc6a2ed1c, Offset: 0x3118
// Size: 0x380
function treasure_chest_move(player_vox) {
    level waittill(#"weapon_fly_away_start");
    players = getplayers();
    array::thread_all(players, &play_crazi_sound);
    if (isdefined(player_vox)) {
        player_vox util::delay(randomintrange(2, 7), undefined, &zm_audio::create_and_play_dialog, "general", "box_move");
    }
    level waittill(#"weapon_fly_away_end");
    if (isdefined(self.zbarrier)) {
        self hide_chest(1);
    }
    wait 0.1;
    post_selection_wait_duration = 7;
    if (level.zombie_vars["zombie_powerup_fire_sale_on"] == 1 && self [[ level._zombiemode_check_firesale_loc_valid_func ]]()) {
        current_sale_time = level.zombie_vars["zombie_powerup_fire_sale_time"];
        util::wait_network_frame();
        self thread fire_sale_fix();
        level.zombie_vars["zombie_powerup_fire_sale_time"] = current_sale_time;
        while (level.zombie_vars["zombie_powerup_fire_sale_time"] > 0) {
            wait 0.1;
        }
    } else {
        post_selection_wait_duration += 5;
    }
    level.verify_chest = 0;
    if (isdefined(level._zombiemode_custom_box_move_logic)) {
        [[ level._zombiemode_custom_box_move_logic ]]();
    } else {
        default_box_move_logic();
    }
    if (isdefined(level.chests[level.chest_index].box_hacks["summon_box"])) {
        level.chests[level.chest_index] [[ level.chests[level.chest_index].box_hacks["summon_box"] ]](0);
    }
    wait post_selection_wait_duration;
    playfx(level._effect["poltergeist"], level.chests[level.chest_index].zbarrier.origin, anglestoup(level.chests[level.chest_index].zbarrier.angles), anglestoforward(level.chests[level.chest_index].zbarrier.angles));
    level.chests[level.chest_index] show_chest();
    level flag::clear("moving_chest_now");
    self.zbarrier.chest_moving = 0;
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x4ecc27b, Offset: 0x34a0
// Size: 0xf4
function fire_sale_fix() {
    if (!isdefined(level.zombie_vars["zombie_powerup_fire_sale_on"])) {
        return;
    }
    if (level.zombie_vars["zombie_powerup_fire_sale_on"]) {
        self.old_cost = 950;
        self thread show_chest();
        self.zombie_cost = 10;
        self.unitrigger_stub zm_utility::unitrigger_set_hint_string(self, "default_treasure_chest", self.zombie_cost);
        util::wait_network_frame();
        level waittill(#"fire_sale_off");
        while (isdefined(self._box_open) && self._box_open) {
            wait 0.1;
        }
        self hide_chest(1);
        self.zombie_cost = self.old_cost;
    }
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xbe42826c, Offset: 0x35a0
// Size: 0xee
function check_for_desirable_chest_location() {
    if (!isdefined(level.desirable_chest_location)) {
        return level.chest_index;
    }
    if (level.chests[level.chest_index].script_noteworthy == level.desirable_chest_location) {
        level.desirable_chest_location = undefined;
        return level.chest_index;
    }
    for (i = 0; i < level.chests.size; i++) {
        if (level.chests[i].script_noteworthy == level.desirable_chest_location) {
            level.desirable_chest_location = undefined;
            return i;
        }
    }
    /#
        iprintln(level.desirable_chest_location + "<dev string:x28>");
    #/
    level.desirable_chest_location = undefined;
    return level.chest_index;
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x90e2ec1b, Offset: 0x3698
// Size: 0x98
function rotateroll_box() {
    angles = 40;
    angles2 = 0;
    while (isdefined(self)) {
        self rotateroll(angles + angles2, 0.5);
        wait 0.7;
        angles2 = 40;
        self rotateroll(angles * -2, 0.5);
        wait 0.7;
    }
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xa88e682f, Offset: 0x3738
// Size: 0x8c
function verify_chest_is_open() {
    for (i = 0; i < level.open_chest_location.size; i++) {
        if (isdefined(level.open_chest_location[i])) {
            if (level.open_chest_location[i] == level.chests[level.chest_index].script_noteworthy) {
                level.verify_chest = 1;
                return;
            }
        }
    }
    level.verify_chest = 0;
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x26656a14, Offset: 0x37d0
// Size: 0x46
function treasure_chest_timeout() {
    self endon(#"user_grabbed_weapon");
    self.zbarrier endon(#"box_hacked_respin");
    self.zbarrier endon(#"box_hacked_rerespin");
    wait 12;
    self notify(#"trigger", level);
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x8fa3814c, Offset: 0x3820
// Size: 0x94
function treasure_chest_lid_open() {
    openroll = 105;
    opentime = 0.5;
    self rotateroll(105, opentime, opentime * 0.5);
    zm_utility::play_sound_at_pos("open_chest", self.origin);
    zm_utility::play_sound_at_pos("music_chest", self.origin);
}

// Namespace zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x6c36411c, Offset: 0x38c0
// Size: 0x8a
function treasure_chest_lid_close(timedout) {
    closeroll = -105;
    closetime = 0.5;
    self rotateroll(closeroll, closetime, closetime * 0.5);
    zm_utility::play_sound_at_pos("close_chest", self.origin);
    self notify(#"lid_closed");
}

// Namespace zm_magicbox
// Params 3, eflags: 0x0
// Checksum 0xb2cf9613, Offset: 0x3958
// Size: 0x19c
function function_9821da97(player, weapon, var_10f9c82c) {
    if (!zm_weapons::get_is_in_box(weapon)) {
        return 0;
    }
    if (isdefined(player) && player zm_weapons::has_weapon_or_upgrade(weapon)) {
        return 0;
    }
    if (!zm_weapons::limited_weapon_below_quota(weapon, player, var_10f9c82c)) {
        return 0;
    }
    if (!player zm_weapons::player_can_use_content(weapon)) {
        return 0;
    }
    if (isdefined(level.custom_magic_box_selection_logic)) {
        if (![[ level.custom_magic_box_selection_logic ]](weapon, player, var_10f9c82c)) {
            return 0;
        }
    }
    if (weapon.name == "ray_gun") {
        if (player zm_weapons::has_weapon_or_upgrade(getweapon("raygun_mark2"))) {
            return 0;
        }
    }
    if (weapon.name == "raygun_mark2") {
        if (player zm_weapons::has_weapon_or_upgrade(getweapon("ray_gun"))) {
            return 0;
        }
    }
    if (isdefined(player) && isdefined(level.special_weapon_magicbox_check)) {
        return player [[ level.special_weapon_magicbox_check ]](weapon);
    }
    return 1;
}

// Namespace zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x6616b999, Offset: 0x3b00
// Size: 0x16c
function function_f4e72416(player) {
    keys = array::randomize(getarraykeys(level.zombie_weapons));
    if (isdefined(level.customrandomweaponweights)) {
        keys = player [[ level.customrandomweaponweights ]](keys);
    }
    /#
        forced_weapon_name = getdvarstring("<dev string:x45>");
        forced_weapon = getweapon(forced_weapon_name);
        if (forced_weapon_name != "<dev string:x56>" && isdefined(level.zombie_weapons[forced_weapon])) {
            arrayinsert(keys, forced_weapon, 0);
        }
    #/
    var_10f9c82c = zm_pap_util::function_f925b7b9();
    for (i = 0; i < keys.size; i++) {
        if (function_9821da97(player, keys[i], var_10f9c82c)) {
            return keys[i];
        }
    }
    return keys[0];
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xe98311e6, Offset: 0x3c78
// Size: 0x30
function weapon_show_hint_choke() {
    level._weapon_show_hint_choke = 0;
    while (true) {
        wait 0.05;
        level._weapon_show_hint_choke = 0;
    }
}

// Namespace zm_magicbox
// Params 4, eflags: 0x0
// Checksum 0x58e3825e, Offset: 0x3cb0
// Size: 0x368
function decide_hide_show_hint(endon_notify, second_endon_notify, onlyplayer, can_buy_weapon_extra_check_func) {
    self endon(#"death");
    if (isdefined(endon_notify)) {
        self endon(endon_notify);
    }
    if (isdefined(second_endon_notify)) {
        self endon(second_endon_notify);
    }
    if (!isdefined(level._weapon_show_hint_choke)) {
        level thread weapon_show_hint_choke();
    }
    use_choke = 0;
    if (isdefined(level._use_choke_weapon_hints) && level._use_choke_weapon_hints == 1) {
        use_choke = 1;
    }
    while (true) {
        last_update = gettime();
        if (isdefined(self.chest_user) && !isdefined(self.box_rerespun)) {
            if (zm_utility::is_placeable_mine(self.chest_user getcurrentweapon()) || self.chest_user zm_equipment::hacker_active()) {
                self setinvisibletoplayer(self.chest_user);
            } else {
                self setvisibletoplayer(self.chest_user);
            }
        } else if (isdefined(onlyplayer)) {
            if ((!isdefined(can_buy_weapon_extra_check_func) || onlyplayer can_buy_weapon() && onlyplayer [[ can_buy_weapon_extra_check_func ]](self.weapon)) && !onlyplayer bgb::is_enabled("zm_bgb_disorderly_combat")) {
                self setinvisibletoplayer(onlyplayer, 0);
            } else {
                self setinvisibletoplayer(onlyplayer, 1);
            }
        } else {
            players = getplayers();
            for (i = 0; i < players.size; i++) {
                if ((!isdefined(can_buy_weapon_extra_check_func) || players[i] can_buy_weapon() && players[i] [[ can_buy_weapon_extra_check_func ]](self.weapon)) && !players[i] bgb::is_enabled("zm_bgb_disorderly_combat")) {
                    self setinvisibletoplayer(players[i], 0);
                    continue;
                }
                self setinvisibletoplayer(players[i], 1);
            }
        }
        if (use_choke) {
            while (level._weapon_show_hint_choke > 4 && gettime() < last_update + -106) {
                wait 0.05;
            }
        } else {
            wait 0.1;
        }
        level._weapon_show_hint_choke++;
    }
}

// Namespace zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0xbea68f5d, Offset: 0x4020
// Size: 0x56
function get_left_hand_weapon_model_name(weapon) {
    dw_weapon = weapon.dualwieldweapon;
    if (dw_weapon != level.weaponnone) {
        return dw_weapon.worldmodel;
    }
    return weapon.worldmodel;
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x5abd3b85, Offset: 0x4080
// Size: 0xec
function clean_up_hacked_box() {
    self waittill(#"box_hacked_respin");
    self endon(#"box_spin_done");
    if (isdefined(self.weapon_model)) {
        self.weapon_model delete();
        self.weapon_model = undefined;
    }
    if (isdefined(self.weapon_model_dw)) {
        self.weapon_model_dw delete();
        self.weapon_model_dw = undefined;
    }
    self hidezbarrierpiece(3);
    self hidezbarrierpiece(4);
    self setzbarrierpiecestate(3, "closed");
    self setzbarrierpiecestate(4, "closed");
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x572fdd08, Offset: 0x4178
// Size: 0x2c
function treasure_chest_firesale_active() {
    return isdefined(level.zombie_vars["zombie_powerup_fire_sale_on"]) && level.zombie_vars["zombie_powerup_fire_sale_on"];
}

// Namespace zm_magicbox
// Params 2, eflags: 0x0
// Checksum 0xc2f050a9, Offset: 0x41b0
// Size: 0x262
function treasure_chest_should_move(chest, player) {
    if (getdvarstring("magic_chest_movable") == "1" && !(isdefined(chest._box_opened_by_fire_sale) && chest._box_opened_by_fire_sale) && !treasure_chest_firesale_active() && self [[ level._zombiemode_check_firesale_loc_valid_func ]]()) {
        random = randomint(100);
        if (!isdefined(level.chest_min_move_usage)) {
            level.chest_min_move_usage = 4;
        }
        if (level.chest_accessed < level.chest_min_move_usage) {
            chance_of_joker = -1;
        } else {
            chance_of_joker = level.chest_accessed + 20;
            if (level.chest_moves == 0 && level.chest_accessed >= 8) {
                chance_of_joker = 100;
            }
            if (level.chest_accessed >= 4 && level.chest_accessed < 8) {
                if (random < 15) {
                    chance_of_joker = 100;
                } else {
                    chance_of_joker = -1;
                }
            }
            if (level.chest_moves > 0) {
                if (level.chest_accessed >= 8 && level.chest_accessed < 13) {
                    if (random < 30) {
                        chance_of_joker = 100;
                    } else {
                        chance_of_joker = -1;
                    }
                }
                if (level.chest_accessed >= 13) {
                    if (random < 50) {
                        chance_of_joker = 100;
                    } else {
                        chance_of_joker = -1;
                    }
                }
            }
        }
        if (isdefined(chest.no_fly_away)) {
            chance_of_joker = -1;
        }
        if (isdefined(level.var_3e719d28)) {
            chance_of_joker = [[ level.var_3e719d28 ]](chance_of_joker);
        }
        if (chance_of_joker > random) {
            return true;
        }
    }
    return false;
}

// Namespace zm_magicbox
// Params 4, eflags: 0x0
// Checksum 0x5c7fda98, Offset: 0x4420
// Size: 0x88
function spawn_joker_weapon_model(player, model, origin, angles) {
    weapon_model = spawn("script_model", origin);
    if (isdefined(angles)) {
        weapon_model.angles = angles;
    }
    weapon_model setmodel(model);
    return weapon_model;
}

// Namespace zm_magicbox
// Params 3, eflags: 0x0
// Checksum 0xad84792a, Offset: 0x44b0
// Size: 0x114
function treasure_chest_weapon_locking(player, weapon, onoff) {
    if (isdefined(self.locked_model)) {
        self.locked_model delete();
        self.locked_model = undefined;
    }
    if (onoff) {
        if (weapon == level.weaponnone) {
            self.locked_model = spawn_joker_weapon_model(player, level.chest_joker_model, self.origin, (0, 0, 0));
        } else {
            self.locked_model = zm_utility::spawn_buildkit_weapon_model(player, weapon, undefined, self.origin, (0, 0, 0));
        }
        self.locked_model ghost();
        self.locked_model clientfield::set("force_stream", 1);
    }
}

// Namespace zm_magicbox
// Params 3, eflags: 0x0
// Checksum 0xdc57b80, Offset: 0x45d0
// Size: 0xa3a
function treasure_chest_weapon_spawn(chest, player, respin) {
    self endon(#"box_hacked_respin");
    self thread clean_up_hacked_box();
    assert(isdefined(player));
    self.chest_moving = 0;
    move_the_box = treasure_chest_should_move(chest, player);
    preferred_weapon = undefined;
    if (move_the_box) {
        preferred_weapon = level.weaponnone;
    } else {
        preferred_weapon = function_f4e72416(player);
    }
    chest treasure_chest_weapon_locking(player, preferred_weapon, 1);
    self.weapon = level.weaponnone;
    modelname = undefined;
    rand = undefined;
    var_5b9e73d8 = 40;
    if (isdefined(chest.zbarrier)) {
        if (isdefined(level.custom_magic_box_do_weapon_rise)) {
            chest.zbarrier thread [[ level.custom_magic_box_do_weapon_rise ]]();
        } else {
            chest.zbarrier thread magic_box_do_weapon_rise();
        }
    }
    for (i = 0; i < var_5b9e73d8; i++) {
        if (i < 20) {
            wait 0.05;
            continue;
        }
        if (i < 30) {
            wait 0.1;
            continue;
        }
        if (i < 35) {
            wait 0.2;
            continue;
        }
        if (i < 38) {
            wait 0.3;
        }
    }
    if (isdefined(level.var_c6955e8b)) {
        [[ level.var_c6955e8b ]]();
    }
    new_firesale = move_the_box && treasure_chest_firesale_active();
    if (new_firesale) {
        move_the_box = 0;
        preferred_weapon = function_f4e72416(player);
    }
    if (!move_the_box && function_9821da97(player, preferred_weapon, zm_pap_util::function_f925b7b9())) {
        rand = preferred_weapon;
    } else {
        rand = function_f4e72416(player);
    }
    self.weapon = rand;
    if (isdefined(level.func_magicbox_weapon_spawned)) {
        self thread [[ level.func_magicbox_weapon_spawned ]](self.weapon);
    }
    wait 0.1;
    if (isdefined(level.custom_magicbox_float_height)) {
        v_float = anglestoup(self.angles) * level.custom_magicbox_float_height;
    } else {
        v_float = anglestoup(self.angles) * 40;
    }
    self.model_dw = undefined;
    self.weapon_model = zm_utility::spawn_buildkit_weapon_model(player, rand, undefined, self.origin + v_float, (self.angles[0] * -1, self.angles[1] + -76, self.angles[2] * -1));
    if (rand.isdualwield) {
        dweapon = rand;
        if (isdefined(rand.dualwieldweapon) && rand.dualwieldweapon != level.weaponnone) {
            dweapon = rand.dualwieldweapon;
        }
        self.weapon_model_dw = zm_utility::spawn_buildkit_weapon_model(player, dweapon, undefined, self.weapon_model.origin - (3, 3, 3), self.weapon_model.angles);
    }
    if (move_the_box && !(level.zombie_vars["zombie_powerup_fire_sale_on"] && self [[ level._zombiemode_check_firesale_loc_valid_func ]]())) {
        self.weapon_model setmodel(level.chest_joker_model);
        if (isdefined(self.weapon_model_dw)) {
            self.weapon_model_dw delete();
            self.weapon_model_dw = undefined;
        }
        if (isplayer(chest.chest_user) && chest.chest_user bgb::is_enabled("zm_bgb_unbearable")) {
            level.chest_accessed = 0;
            chest.unbearable_respin = 1;
            chest.chest_user notify(#"zm_bgb_unbearable", chest);
            chest waittill(#"forever");
        }
        self.chest_moving = 1;
        level flag::set("moving_chest_now");
        level.chest_accessed = 0;
        level.chest_moves++;
    }
    self notify(#"randomization_done");
    if (isdefined(self.chest_moving) && self.chest_moving) {
        if (isdefined(level.chest_joker_custom_movement)) {
            self [[ level.chest_joker_custom_movement ]]();
        } else {
            v_origin = self.weapon_model.origin;
            self.weapon_model delete();
            self.weapon_model = spawn("script_model", v_origin);
            self.weapon_model setmodel(level.chest_joker_model);
            self.weapon_model.angles = self.angles + (0, 180, 0);
            wait 0.5;
            level notify(#"weapon_fly_away_start");
            wait 2;
            if (isdefined(self.weapon_model)) {
                v_fly_away = self.origin + anglestoup(self.angles) * 500;
                self.weapon_model moveto(v_fly_away, 4, 3);
            }
            if (isdefined(self.weapon_model_dw)) {
                v_fly_away = self.origin + anglestoup(self.angles) * 500;
                self.weapon_model_dw moveto(v_fly_away, 4, 3);
            }
            self.weapon_model waittill(#"movedone");
            self.weapon_model delete();
            if (isdefined(self.weapon_model_dw)) {
                self.weapon_model_dw delete();
                self.weapon_model_dw = undefined;
            }
            self notify(#"box_moving");
            level notify(#"weapon_fly_away_end");
        }
    } else {
        if (!isdefined(respin)) {
            if (isdefined(chest.box_hacks["respin"])) {
                self [[ chest.box_hacks["respin"] ]](chest, player);
            }
        } else if (isdefined(chest.box_hacks["respin_respin"])) {
            self [[ chest.box_hacks["respin_respin"] ]](chest, player);
        }
        if (isdefined(level.custom_magic_box_timer_til_despawn)) {
            self.weapon_model thread [[ level.custom_magic_box_timer_til_despawn ]](self);
        } else {
            self.weapon_model thread timer_til_despawn(v_float);
        }
        if (isdefined(self.weapon_model_dw)) {
            if (isdefined(level.custom_magic_box_timer_til_despawn)) {
                self.weapon_model_dw thread [[ level.custom_magic_box_timer_til_despawn ]](self);
            } else {
                self.weapon_model_dw thread timer_til_despawn(v_float);
            }
        }
        self waittill(#"weapon_grabbed");
        if (!chest.timedout) {
            if (isdefined(self.weapon_model)) {
                self.weapon_model delete();
            }
            if (isdefined(self.weapon_model_dw)) {
                self.weapon_model_dw delete();
            }
        }
    }
    chest treasure_chest_weapon_locking(player, preferred_weapon, 0);
    self.weapon = level.weaponnone;
    self notify(#"box_spin_done");
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x6c3e8ec3, Offset: 0x5018
// Size: 0x1a
function chest_get_min_usage() {
    min_usage = 4;
    return min_usage;
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xff98bcc9, Offset: 0x5040
// Size: 0x116
function chest_get_max_usage() {
    max_usage = 6;
    players = getplayers();
    if (level.chest_moves == 0) {
        if (players.size == 1) {
            max_usage = 3;
        } else if (players.size == 2) {
            max_usage = 4;
        } else if (players.size == 3) {
            max_usage = 5;
        } else {
            max_usage = 6;
        }
    } else if (players.size == 1) {
        max_usage = 4;
    } else if (players.size == 2) {
        max_usage = 4;
    } else if (players.size == 3) {
        max_usage = 5;
    } else {
        max_usage = 7;
    }
    return max_usage;
}

// Namespace zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x502942ce, Offset: 0x5160
// Size: 0x84
function timer_til_despawn(v_float) {
    self endon(#"kill_weapon_movement");
    putbacktime = 12;
    self moveto(self.origin - v_float * 0.85, putbacktime, putbacktime * 0.5);
    wait putbacktime;
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x73cd7680, Offset: 0x51f0
// Size: 0xc4
function treasure_chest_glowfx() {
    self clientfield::set("magicbox_open_glow", 1);
    self clientfield::set("magicbox_closed_glow", 0);
    ret_val = self util::waittill_any_return("weapon_grabbed", "box_moving");
    self clientfield::set("magicbox_open_glow", 0);
    if ("box_moving" != ret_val) {
        self clientfield::set("magicbox_closed_glow", 1);
    }
}

// Namespace zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0xa62cfeb7, Offset: 0x52c0
// Size: 0x164
function treasure_chest_give_weapon(weapon) {
    self.last_box_weapon = gettime();
    if (weapon.name == "ray_gun" || weapon.name == "raygun_mark2") {
        playsoundatposition("mus_raygun_stinger", (0, 0, 0));
    }
    if (should_upgrade_weapon(self, weapon)) {
        if (self zm_weapons::can_upgrade_weapon(weapon)) {
            weapon = zm_weapons::get_upgrade_weapon(weapon);
            self notify(#"zm_bgb_crate_power_used");
        }
    }
    if (zm_utility::is_hero_weapon(weapon) && !self hasweapon(weapon)) {
        self give_hero_weapon(weapon);
        return;
    }
    w_give = self zm_weapons::weapon_give(weapon, 0, 1);
    if (isdefined(weapon)) {
        self thread aat::remove(w_give);
    }
}

// Namespace zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x2606b205, Offset: 0x5430
// Size: 0x114
function give_hero_weapon(weapon) {
    w_previous = self getcurrentweapon();
    self zm_weapons::weapon_give(weapon);
    self gadgetpowerset(0, 99);
    self switchtoweapon(weapon);
    self waittill(#"weapon_change_complete");
    self setlowready(1);
    self switchtoweapon(w_previous);
    self util::waittill_any_timeout(1, "weapon_change_complete");
    self setlowready(0);
    self gadgetpowerset(0, 100);
}

// Namespace zm_magicbox
// Params 2, eflags: 0x0
// Checksum 0x7eb156d3, Offset: 0x5550
// Size: 0x5e
function should_upgrade_weapon(player, weapon) {
    if (isdefined(level.magicbox_should_upgrade_weapon_override)) {
        return [[ level.magicbox_should_upgrade_weapon_override ]](player, weapon);
    }
    if (player bgb::is_enabled("zm_bgb_crate_power")) {
        return 1;
    }
    return 0;
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x57fda026, Offset: 0x55b8
// Size: 0xa8
function function_7496cc77() {
    self endon(#"zbarrier_state_change");
    self setzbarrierpiecestate(0, "closed");
    while (true) {
        wait randomfloatrange(-76, 1800);
        self setzbarrierpiecestate(0, "opening");
        wait randomfloatrange(-76, 1800);
        self setzbarrierpiecestate(0, "closing");
    }
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x92b7dd7e, Offset: 0x5668
// Size: 0x44
function function_fea04511() {
    self setzbarrierpiecestate(1, "open");
    self clientfield::set("magicbox_closed_glow", 1);
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x8d61d350, Offset: 0x56b8
// Size: 0x62
function function_4831fb0d() {
    self setzbarrierpiecestate(1, "opening");
    while (self getzbarrierpiecestate(1) == "opening") {
        wait 0.05;
    }
    self notify(#"arrived");
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x8c582cb6, Offset: 0x5728
// Size: 0x62
function function_fd5f77b3() {
    self setzbarrierpiecestate(1, "closing");
    while (self getzbarrierpiecestate(1) == "closing") {
        wait 0.1;
    }
    self notify(#"left");
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x33913978, Offset: 0x5798
// Size: 0x62
function function_63e09f12() {
    self setzbarrierpiecestate(2, "opening");
    while (self getzbarrierpiecestate(2) == "opening") {
        wait 0.1;
    }
    self notify(#"opened");
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xcaa92ea8, Offset: 0x5808
// Size: 0x62
function function_fe30a0c8() {
    self setzbarrierpiecestate(2, "closing");
    while (self getzbarrierpiecestate(2) == "closing") {
        wait 0.1;
    }
    self notify(#"closed");
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x901bfa4e, Offset: 0x5878
// Size: 0x15c
function magic_box_do_weapon_rise() {
    self endon(#"box_hacked_respin");
    self setzbarrierpiecestate(3, "closed");
    self setzbarrierpiecestate(4, "closed");
    util::wait_network_frame();
    self zbarrierpieceuseboxriselogic(3);
    self zbarrierpieceuseboxriselogic(4);
    self showzbarrierpiece(3);
    self showzbarrierpiece(4);
    self setzbarrierpiecestate(3, "opening");
    self setzbarrierpiecestate(4, "opening");
    while (self getzbarrierpiecestate(3) != "open") {
        wait 0.5;
    }
    self hidezbarrierpiece(3);
    self hidezbarrierpiece(4);
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xa93dcf1, Offset: 0x59e0
// Size: 0x3c
function magic_box_do_teddy_flyaway() {
    self showzbarrierpiece(3);
    self setzbarrierpiecestate(3, "closing");
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0x1569fc17, Offset: 0x5a28
// Size: 0x74
function is_chest_active() {
    curr_state = self.zbarrier get_magic_box_zbarrier_state();
    if (level flag::get("moving_chest_now")) {
        return false;
    }
    if (curr_state == "open" || curr_state == "close") {
        return true;
    }
    return false;
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xb6046605, Offset: 0x5aa8
// Size: 0xa
function get_magic_box_zbarrier_state() {
    return self.state;
}

// Namespace zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x615f83e1, Offset: 0x5ac0
// Size: 0x80
function set_magic_box_zbarrier_state(state) {
    for (i = 0; i < self getnumzbarrierpieces(); i++) {
        self hidezbarrierpiece(i);
    }
    self notify(#"zbarrier_state_change");
    self [[ level.magic_box_zbarrier_state_func ]](state);
}

// Namespace zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0xa0b17943, Offset: 0x5b48
// Size: 0x252
function process_magic_box_zbarrier_state(state) {
    switch (state) {
    case "away":
        self showzbarrierpiece(0);
        self thread function_7496cc77();
        self.state = "away";
        break;
    case "arriving":
        self showzbarrierpiece(1);
        self thread function_4831fb0d();
        self.state = "arriving";
        break;
    case "initial":
        self showzbarrierpiece(1);
        self thread function_fea04511();
        thread zm_unitrigger::register_static_unitrigger(self.owner.unitrigger_stub, &magicbox_unitrigger_think);
        self.state = "initial";
        break;
    case "open":
        self showzbarrierpiece(2);
        self thread function_63e09f12();
        self.state = "open";
        break;
    case "close":
        self showzbarrierpiece(2);
        self thread function_fe30a0c8();
        self.state = "close";
        break;
    case "leaving":
        self showzbarrierpiece(1);
        self thread function_fd5f77b3();
        self.state = "leaving";
        break;
    default:
        if (isdefined(level.custom_magicbox_state_handler)) {
            self [[ level.custom_magicbox_state_handler ]](state);
        }
        break;
    }
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xc8c46aa7, Offset: 0x5da8
// Size: 0x14e
function magicbox_host_migration() {
    level endon(#"end_game");
    level notify(#"mb_hostmigration");
    level endon(#"mb_hostmigration");
    while (true) {
        level waittill(#"host_migration_end");
        if (!isdefined(level.chests)) {
            continue;
        }
        foreach (chest in level.chests) {
            if (!(isdefined(chest.hidden) && chest.hidden)) {
                if (isdefined(chest) && isdefined(chest.pandora_light)) {
                    playfxontag(level._effect["lght_marker"], chest.pandora_light, "tag_origin");
                }
            }
            util::wait_network_frame();
        }
    }
}

// Namespace zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xcd7c724b, Offset: 0x5f00
// Size: 0x148
function function_14a6411c() {
    level flag::wait_till("initial_blackscreen_passed");
    self endon(#"left");
    while (true) {
        foreach (player in getplayers()) {
            var_87379d4f = distance(player.origin, self.origin);
            if (var_87379d4f < 400 && player zm_utility::is_player_looking_at(self.origin)) {
                player zm_audio::create_and_play_dialog("box", "encounter");
                return;
            }
        }
        wait 0.5;
    }
}

