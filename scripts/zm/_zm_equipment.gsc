#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_audio;
#using scripts/zm/_util;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_equipment;

// Namespace zm_equipment
// Params 0, eflags: 0x2
// Checksum 0x59b48d85, Offset: 0x3b0
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_equipment", &__init__, &__main__, undefined);
}

// Namespace zm_equipment
// Params 0, eflags: 0x1 linked
// Checksum 0x69a7e10d, Offset: 0x3f8
// Size: 0x8c
function __init__() {
    level.buildable_piece_count = 24;
    level.var_5174ecb = "_t6/maps/zombie/fx_zmb_tranzit_electrap_explo";
    level.placeable_equipment_destroy_fn = [];
    if (!(isdefined(level._no_equipment_activated_clientfield) && level._no_equipment_activated_clientfield)) {
        clientfield::register("scriptmover", "equipment_activated", 1, 4, "int");
    }
    /#
        level thread function_f30ee99e();
    #/
}

// Namespace zm_equipment
// Params 0, eflags: 0x1 linked
// Checksum 0xb8d7699d, Offset: 0x490
// Size: 0x14
function __main__() {
    init_upgrade();
}

// Namespace zm_equipment
// Params 1, eflags: 0x0
// Checksum 0x8a45e980, Offset: 0x4b0
// Size: 0xbc
function signal_activated(val) {
    if (!isdefined(val)) {
        val = 1;
    }
    if (isdefined(level._no_equipment_activated_clientfield) && level._no_equipment_activated_clientfield) {
        return;
    }
    self endon(#"death");
    self clientfield::set("equipment_activated", val);
    for (i = 0; i < 2; i++) {
        util::wait_network_frame();
    }
    self clientfield::set("equipment_activated", 0);
}

// Namespace zm_equipment
// Params 5, eflags: 0x1 linked
// Checksum 0xf5dd2e73, Offset: 0x578
// Size: 0x214
function register(equipment_name, hint, howto_hint, hint_icon, equipmentvo) {
    equipment = getweapon(equipment_name);
    struct = spawnstruct();
    if (!isdefined(level.zombie_equipment)) {
        level.zombie_equipment = [];
    }
    struct.equipment = equipment;
    struct.hint = hint;
    struct.howto_hint = howto_hint;
    struct.hint_icon = hint_icon;
    struct.vox = equipmentvo;
    struct.triggers = [];
    struct.models = [];
    struct.notify_strings = spawnstruct();
    struct.notify_strings.activate = equipment.name + "_activate";
    struct.notify_strings.deactivate = equipment.name + "_deactivate";
    struct.notify_strings.taken = equipment.name + "_taken";
    struct.notify_strings.pickup = equipment.name + "_pickup";
    level.zombie_equipment[equipment] = struct;
    /#
        level thread function_de79cac6(equipment);
    #/
}

// Namespace zm_equipment
// Params 2, eflags: 0x0
// Checksum 0xc4be46f9, Offset: 0x798
// Size: 0x26
function register_slot_watcher_override(str_equipment, func_slot_watcher_override) {
    level.a_func_equipment_slot_watcher_override[str_equipment] = func_slot_watcher_override;
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0x810281d, Offset: 0x7c8
// Size: 0x6a
function is_included(equipment) {
    if (!isdefined(level.zombie_include_equipment)) {
        return false;
    }
    if (isstring(equipment)) {
        equipment = getweapon(equipment);
    }
    return isdefined(level.zombie_include_equipment[equipment.rootweapon]);
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0x3408ee79, Offset: 0x840
// Size: 0x46
function include(equipment_name) {
    if (!isdefined(level.zombie_include_equipment)) {
        level.zombie_include_equipment = [];
    }
    level.zombie_include_equipment[getweapon(equipment_name)] = 1;
}

// Namespace zm_equipment
// Params 3, eflags: 0x1 linked
// Checksum 0x3a45c4a9, Offset: 0x890
// Size: 0xc0
function set_ammo_driven(equipment_name, start, refill_max_ammo) {
    if (!isdefined(refill_max_ammo)) {
        refill_max_ammo = 0;
    }
    level.zombie_equipment[getweapon(equipment_name)].notake = 1;
    level.zombie_equipment[getweapon(equipment_name)].start_ammo = start;
    level.zombie_equipment[getweapon(equipment_name)].refill_max_ammo = refill_max_ammo;
}

// Namespace zm_equipment
// Params 2, eflags: 0x0
// Checksum 0x9fa324d9, Offset: 0x958
// Size: 0x94
function limit(equipment_name, limited) {
    if (!isdefined(level._limited_equipment)) {
        level._limited_equipment = [];
    }
    if (limited) {
        level._limited_equipment[level._limited_equipment.size] = getweapon(equipment_name);
        return;
    }
    arrayremovevalue(level._limited_equipment, getweapon(equipment_name), 0);
}

// Namespace zm_equipment
// Params 0, eflags: 0x1 linked
// Checksum 0xf1184d38, Offset: 0x9f8
// Size: 0x186
function init_upgrade() {
    equipment_spawns = [];
    equipment_spawns = getentarray("zombie_equipment_upgrade", "targetname");
    for (i = 0; i < equipment_spawns.size; i++) {
        equipment_spawns[i].equipment = getweapon(equipment_spawns[i].zombie_equipment_upgrade);
        hint_string = get_hint(equipment_spawns[i].equipment);
        equipment_spawns[i] sethintstring(hint_string);
        equipment_spawns[i] setcursorhint("HINT_NOICON");
        equipment_spawns[i] usetriggerrequirelookat();
        equipment_spawns[i] add_to_trigger_list(equipment_spawns[i].equipment);
        equipment_spawns[i] thread equipment_spawn_think();
    }
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0x8e1f0d08, Offset: 0xb88
// Size: 0x5a
function get_hint(equipment) {
    /#
        assert(isdefined(level.zombie_equipment[equipment]), equipment.name + "_pickup");
    #/
    return level.zombie_equipment[equipment].hint;
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0x940ed5f8, Offset: 0xbf0
// Size: 0x5a
function get_howto_hint(equipment) {
    /#
        assert(isdefined(level.zombie_equipment[equipment]), equipment.name + "_pickup");
    #/
    return level.zombie_equipment[equipment].howto_hint;
}

// Namespace zm_equipment
// Params 1, eflags: 0x0
// Checksum 0x5484ac22, Offset: 0xc58
// Size: 0x5a
function get_icon(equipment) {
    /#
        assert(isdefined(level.zombie_equipment[equipment]), equipment.name + "_pickup");
    #/
    return level.zombie_equipment[equipment].hint_icon;
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0x5a59121d, Offset: 0xcc0
// Size: 0x5a
function get_notify_strings(equipment) {
    /#
        assert(isdefined(level.zombie_equipment[equipment]), equipment.name + "_pickup");
    #/
    return level.zombie_equipment[equipment].notify_strings;
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0x59ebeb44, Offset: 0xd28
// Size: 0xce
function add_to_trigger_list(equipment) {
    /#
        assert(isdefined(level.zombie_equipment[equipment]), equipment.name + "_pickup");
    #/
    level.zombie_equipment[equipment].triggers[level.zombie_equipment[equipment].triggers.size] = self;
    level.zombie_equipment[equipment].models[level.zombie_equipment[equipment].models.size] = getent(self.target, "targetname");
}

// Namespace zm_equipment
// Params 0, eflags: 0x1 linked
// Checksum 0xed756491, Offset: 0xe00
// Size: 0x1b4
function equipment_spawn_think() {
    for (;;) {
        player = self waittill(#"trigger");
        if (player zm_utility::in_revive_trigger() || player.is_drinking > 0) {
            wait(0.1);
            continue;
        }
        if (!is_limited(self.equipment) || !limited_in_use(self.equipment)) {
            if (is_limited(self.equipment)) {
                player setup_limited(self.equipment);
                if (isdefined(level.hacker_tool_positions)) {
                    new_pos = array::random(level.hacker_tool_positions);
                    self.origin = new_pos.trigger_org;
                    model = getent(self.target, "targetname");
                    model.origin = new_pos.model_org;
                    model.angles = new_pos.model_ang;
                }
            }
            player give(self.equipment);
            continue;
        }
        wait(0.1);
    }
}

// Namespace zm_equipment
// Params 2, eflags: 0x1 linked
// Checksum 0x1554c7f1, Offset: 0xfc0
// Size: 0x10e
function set_equipment_invisibility_to_player(equipment, invisible) {
    triggers = level.zombie_equipment[equipment].triggers;
    for (i = 0; i < triggers.size; i++) {
        if (isdefined(triggers[i])) {
            triggers[i] setinvisibletoplayer(self, invisible);
        }
    }
    models = level.zombie_equipment[equipment].models;
    for (i = 0; i < models.size; i++) {
        if (isdefined(models[i])) {
            models[i] setinvisibletoplayer(self, invisible);
        }
    }
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0x28cc6dcf, Offset: 0x10d8
// Size: 0x2c4
function take(equipment) {
    if (!isdefined(equipment)) {
        equipment = self get_player_equipment();
    }
    if (!isdefined(equipment)) {
        return;
    }
    if (equipment == level.weaponnone) {
        return;
    }
    if (!self has_player_equipment(equipment)) {
        return;
    }
    current = 0;
    current_weapon = 0;
    if (isdefined(self get_player_equipment()) && equipment == self get_player_equipment()) {
        current = 1;
    }
    if (equipment == self getcurrentweapon()) {
        current_weapon = 1;
    }
    /#
        println("_pickup" + self.name + "_pickup" + equipment.name + "_pickup");
    #/
    notify_strings = get_notify_strings(equipment);
    if (isdefined(self.current_equipment_active[equipment]) && self.current_equipment_active[equipment]) {
        self.current_equipment_active[equipment] = 0;
        self notify(notify_strings.deactivate);
    }
    self notify(notify_strings.taken);
    self takeweapon(equipment);
    if (is_limited(equipment) && (!is_limited(equipment) || !limited_in_use(equipment))) {
        self set_equipment_invisibility_to_player(equipment, 0);
    }
    if (current) {
        self set_player_equipment(level.weaponnone);
        self setactionslot(2, "");
    } else {
        arrayremovevalue(self.deployed_equipment, equipment);
    }
    if (current_weapon) {
        self zm_weapons::switch_back_primary_weapon();
    }
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0xaacb9b56, Offset: 0x13a8
// Size: 0x1fe
function give(equipment) {
    if (!isdefined(equipment)) {
        return;
    }
    if (!isdefined(level.zombie_equipment[equipment])) {
        return;
    }
    if (self has_player_equipment(equipment)) {
        return;
    }
    /#
        println("_pickup" + self.name + "_pickup" + equipment.name + "_pickup");
    #/
    curr_weapon = self getcurrentweapon();
    curr_weapon_was_curr_equipment = self is_player_equipment(curr_weapon);
    self take();
    self set_player_equipment(equipment);
    self giveweapon(equipment);
    self start_ammo(equipment);
    self thread show_hint(equipment);
    self set_equipment_invisibility_to_player(equipment, 1);
    self setactionslot(2, "weapon", equipment);
    self thread slot_watcher(equipment);
    self zm_audio::create_and_play_dialog("weapon_pickup", level.zombie_equipment[equipment].vox);
    self notify(#"player_given", equipment);
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0xb057e5fc, Offset: 0x15b0
// Size: 0x134
function buy(equipment) {
    if (isstring(equipment)) {
        equipment = getweapon(equipment);
    }
    /#
        println("_pickup" + self.name + "_pickup" + equipment.name + "_pickup");
    #/
    if (isdefined(self.current_equipment) && equipment != self.current_equipment && self.current_equipment != level.weaponnone) {
        self take(self.current_equipment);
    }
    self notify(#"player_bought", equipment);
    self give(equipment);
    if (equipment.isriotshield && isdefined(self.player_shield_reset_health)) {
        self [[ self.player_shield_reset_health ]]();
    }
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0x4e3e4753, Offset: 0x16f0
// Size: 0x1fe
function slot_watcher(equipment) {
    self notify(#"kill_equipment_slot_watcher");
    self endon(#"kill_equipment_slot_watcher");
    self endon(#"disconnect");
    notify_strings = get_notify_strings(equipment);
    while (true) {
        curr_weapon, prev_weapon = self waittill(#"weapon_change");
        if (self.sessionstate != "spectator") {
            self.prev_weapon_before_equipment_change = undefined;
            if (isdefined(prev_weapon) && level.weaponnone != prev_weapon) {
                prev_weapon_type = prev_weapon.inventorytype;
                if ("primary" == prev_weapon_type || "altmode" == prev_weapon_type) {
                    self.prev_weapon_before_equipment_change = prev_weapon;
                }
            }
            if (!isdefined(level.a_func_equipment_slot_watcher_override)) {
                level.a_func_equipment_slot_watcher_override = [];
            }
            if (isdefined(level.a_func_equipment_slot_watcher_override[equipment.name])) {
                self [[ level.a_func_equipment_slot_watcher_override[equipment.name] ]](equipment, curr_weapon, prev_weapon, notify_strings);
                continue;
            }
            if (curr_weapon == equipment && !self.current_equipment_active[equipment]) {
                self notify(notify_strings.activate);
                self.current_equipment_active[equipment] = 1;
                continue;
            }
            if (curr_weapon != equipment && self.current_equipment_active[equipment]) {
                self notify(notify_strings.deactivate);
                self.current_equipment_active[equipment] = 0;
            }
        }
    }
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0x5c64fe1a, Offset: 0x18f8
// Size: 0x64
function is_limited(equipment) {
    if (isdefined(level._limited_equipment)) {
        for (i = 0; i < level._limited_equipment.size; i++) {
            if (level._limited_equipment[i] == equipment) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0x80407886, Offset: 0x1968
// Size: 0xbe
function limited_in_use(equipment) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        current_equipment = players[i] get_player_equipment();
        if (isdefined(current_equipment) && current_equipment == equipment) {
            return true;
        }
    }
    if (isdefined(level.dropped_equipment) && isdefined(level.dropped_equipment[equipment])) {
        return true;
    }
    return false;
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0xbf106b9f, Offset: 0x1a30
// Size: 0xa4
function setup_limited(equipment) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] set_equipment_invisibility_to_player(equipment, 1);
    }
    self thread release_limited_on_disconnect(equipment);
    self thread release_limited_on_taken(equipment);
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0x6025489a, Offset: 0x1ae0
// Size: 0xce
function release_limited_on_taken(equipment) {
    self endon(#"disconnect");
    notify_strings = get_notify_strings(equipment);
    self util::waittill_either(notify_strings.taken, "spawned_spectator");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] set_equipment_invisibility_to_player(equipment, 0);
    }
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0xe822426d, Offset: 0x1bb8
// Size: 0xde
function release_limited_on_disconnect(equipment) {
    notify_strings = get_notify_strings(equipment);
    self endon(notify_strings.taken);
    self waittill(#"disconnect");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isalive(players[i])) {
            players[i] set_equipment_invisibility_to_player(equipment, 0);
        }
    }
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0xa213c068, Offset: 0x1ca0
// Size: 0x40
function is_active(equipment) {
    if (!isdefined(self.current_equipment_active) || !isdefined(self.current_equipment_active[equipment])) {
        return 0;
    }
    return self.current_equipment_active[equipment];
}

// Namespace zm_equipment
// Params 6, eflags: 0x1 linked
// Checksum 0x6208e859, Offset: 0x1ce8
// Size: 0x88
function init_hint_hudelem(x, y, alignx, aligny, fontscale, alpha) {
    self.x = x;
    self.y = y;
    self.alignx = alignx;
    self.aligny = aligny;
    self.fontscale = fontscale;
    self.alpha = alpha;
    self.sort = 20;
}

// Namespace zm_equipment
// Params 2, eflags: 0x1 linked
// Checksum 0x330ccd4e, Offset: 0x1d78
// Size: 0x184
function setup_client_hintelem(ypos, font_scale) {
    if (!isdefined(ypos)) {
        ypos = -36;
    }
    if (!isdefined(font_scale)) {
        font_scale = 1.25;
    }
    self endon(#"death");
    self endon(#"disconnect");
    if (!isdefined(self.hintelem)) {
        self.hintelem = newclienthudelem(self);
    }
    if (self issplitscreen()) {
        if (getdvarint("splitscreen_playerCount") >= 3) {
            self.hintelem init_hint_hudelem(-96, 90, "center", "middle", font_scale * 0.8, 1);
        } else {
            self.hintelem init_hint_hudelem(-96, 90, "center", "middle", font_scale, 1);
        }
        return;
    }
    self.hintelem init_hint_hudelem(320, ypos, "center", "bottom", font_scale, 1);
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0x802e970a, Offset: 0x1f08
// Size: 0x9c
function show_hint(equipment) {
    self notify(#"kill_previous_show_equipment_hint_thread");
    self endon(#"kill_previous_show_equipment_hint_thread");
    self endon(#"death");
    self endon(#"disconnect");
    if (isdefined(self.do_not_display_equipment_pickup_hint) && self.do_not_display_equipment_pickup_hint) {
        return;
    }
    wait(0.5);
    text = get_howto_hint(equipment);
    self show_hint_text(text);
}

// Namespace zm_equipment
// Params 4, eflags: 0x1 linked
// Checksum 0xc37718b9, Offset: 0x1fb0
// Size: 0x204
function show_hint_text(text, show_for_time, font_scale, ypos) {
    if (!isdefined(show_for_time)) {
        show_for_time = 3.2;
    }
    if (!isdefined(font_scale)) {
        font_scale = 1.25;
    }
    if (!isdefined(ypos)) {
        ypos = -36;
    }
    self notify(#"hide_equipment_hint_text");
    wait(0.05);
    self setup_client_hintelem(ypos, font_scale);
    self.hintelem settext(text);
    self.hintelem.alpha = 1;
    self.hintelem.font = "small";
    self.hintelem.hidewheninmenu = 1;
    time = self util::waittill_any_timeout(show_for_time, "hide_equipment_hint_text", "death", "disconnect");
    if (isdefined(time) && isdefined(self) && isdefined(self.hintelem)) {
        self.hintelem fadeovertime(0.25);
        self.hintelem.alpha = 0;
        self util::waittill_any_timeout(0.25, "hide_equipment_hint_text");
    }
    if (isdefined(self) && isdefined(self.hintelem)) {
        self.hintelem settext("");
        self.hintelem destroy();
    }
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0x1e644da1, Offset: 0x21c0
// Size: 0xc6
function start_ammo(equipment) {
    if (self hasweapon(equipment)) {
        maxammo = 1;
        if (isdefined(level.zombie_equipment[equipment].notake) && level.zombie_equipment[equipment].notake) {
            maxammo = level.zombie_equipment[equipment].start_ammo;
        }
        self setweaponammoclip(equipment, maxammo);
        self notify(#"equipment_ammo_changed", equipment);
        return maxammo;
    }
    return 0;
}

// Namespace zm_equipment
// Params 2, eflags: 0x1 linked
// Checksum 0x259f0b05, Offset: 0x2290
// Size: 0x13e
function change_ammo(equipment, change) {
    if (self hasweapon(equipment)) {
        oldammo = self getweaponammoclip(equipment);
        maxammo = 1;
        if (isdefined(level.zombie_equipment[equipment].notake) && level.zombie_equipment[equipment].notake) {
            maxammo = level.zombie_equipment[equipment].start_ammo;
        }
        newammo = int(min(maxammo, max(0, oldammo + change)));
        self setweaponammoclip(equipment, newammo);
        self notify(#"equipment_ammo_changed", equipment);
        return newammo;
    }
    return 0;
}

// Namespace zm_equipment
// Params 3, eflags: 0x1 linked
// Checksum 0x72d1db37, Offset: 0x23d8
// Size: 0xa4
function function_c9a8ab09(origin, fx, angles) {
    effect = level.var_5174ecb;
    if (isdefined(fx)) {
        effect = fx;
    }
    if (isdefined(angles)) {
        playfx(effect, origin, anglestoforward(angles));
    } else {
        playfx(effect, origin);
    }
    wait(1.1);
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0x9f63b46a, Offset: 0x2488
// Size: 0x72
function register_for_level(weaponname) {
    weapon = getweapon(weaponname);
    if (is_equipment(weapon)) {
        return;
    }
    if (!isdefined(level.zombie_equipment_list)) {
        level.zombie_equipment_list = [];
    }
    level.zombie_equipment_list[weapon] = weapon;
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0x5fa83105, Offset: 0x2508
// Size: 0x3a
function is_equipment(weapon) {
    if (!isdefined(weapon) || !isdefined(level.zombie_equipment_list)) {
        return false;
    }
    return isdefined(level.zombie_equipment_list[weapon]);
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0x1457048a, Offset: 0x2550
// Size: 0x22
function is_equipment_that_blocks_purchase(weapon) {
    return is_equipment(weapon);
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0xa5f65dd1, Offset: 0x2580
// Size: 0x38
function is_player_equipment(weapon) {
    if (!isdefined(weapon) || !isdefined(self.current_equipment)) {
        return false;
    }
    return self.current_equipment == weapon;
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0xef940f56, Offset: 0x25c0
// Size: 0x8c
function has_deployed_equipment(weapon) {
    if (!isdefined(weapon) || !isdefined(self.deployed_equipment) || self.deployed_equipment.size < 1) {
        return false;
    }
    for (i = 0; i < self.deployed_equipment.size; i++) {
        if (self.deployed_equipment[i] == weapon) {
            return true;
        }
    }
    return false;
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0xc142b145, Offset: 0x2658
// Size: 0x3a
function has_player_equipment(weapon) {
    return self is_player_equipment(weapon) || self has_deployed_equipment(weapon);
}

// Namespace zm_equipment
// Params 0, eflags: 0x1 linked
// Checksum 0x2e468e0e, Offset: 0x26a0
// Size: 0x34
function get_player_equipment() {
    equipment = level.weaponnone;
    if (isdefined(self.current_equipment)) {
        equipment = self.current_equipment;
    }
    return equipment;
}

// Namespace zm_equipment
// Params 0, eflags: 0x1 linked
// Checksum 0x4f7d3de2, Offset: 0x26e0
// Size: 0x2a
function hacker_active() {
    return self is_active(getweapon("equip_hacker"));
}

// Namespace zm_equipment
// Params 1, eflags: 0x1 linked
// Checksum 0xec523a7e, Offset: 0x2718
// Size: 0x98
function set_player_equipment(weapon) {
    if (!isdefined(self.current_equipment_active)) {
        self.current_equipment_active = [];
    }
    if (isdefined(weapon)) {
        self.current_equipment_active[weapon] = 0;
    }
    if (!isdefined(self.equipment_got_in_round)) {
        self.equipment_got_in_round = [];
    }
    if (isdefined(weapon)) {
        self.equipment_got_in_round[weapon] = level.round_number;
    }
    self notify(#"new_equipment", weapon);
    self.current_equipment = weapon;
}

// Namespace zm_equipment
// Params 0, eflags: 0x1 linked
// Checksum 0x9db95f43, Offset: 0x27b8
// Size: 0x24
function init_player_equipment() {
    self set_player_equipment(level.zombie_equipment_player_init);
}

/#

    // Namespace zm_equipment
    // Params 0, eflags: 0x1 linked
    // Checksum 0x43d090f1, Offset: 0x27e8
    // Size: 0x1e0
    function function_f30ee99e() {
        setdvar("_pickup", "_pickup");
        wait(0.05);
        level flag::wait_till("_pickup");
        wait(0.05);
        str_cmd = "_pickup" + "_pickup" + "_pickup";
        adddebugcommand(str_cmd);
        while (true) {
            equipment_id = getdvarstring("_pickup");
            if (equipment_id != "_pickup") {
                foreach (player in getplayers()) {
                    if (equipment_id == "_pickup") {
                        player take();
                        continue;
                    }
                    if (is_included(equipment_id)) {
                        player buy(equipment_id);
                    }
                }
                setdvar("_pickup", "_pickup");
            }
            wait(0.05);
        }
    }

    // Namespace zm_equipment
    // Params 1, eflags: 0x1 linked
    // Checksum 0x373f622d, Offset: 0x29d0
    // Size: 0xac
    function function_de79cac6(equipment) {
        wait(0.05);
        level flag::wait_till("_pickup");
        wait(0.05);
        if (isdefined(equipment)) {
            equipment_id = equipment.name;
            str_cmd = "_pickup" + equipment_id + "_pickup" + equipment_id + "_pickup";
            adddebugcommand(str_cmd);
        }
    }

#/
