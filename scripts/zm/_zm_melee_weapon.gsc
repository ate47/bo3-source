#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_audio;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_melee_weapon;

// Namespace zm_melee_weapon
// Params 0, eflags: 0x2
// Checksum 0x9a7de1d3, Offset: 0x280
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("melee_weapon", &__init__, &__main__, undefined);
}

// Namespace zm_melee_weapon
// Params 0, eflags: 0x5 linked
// Checksum 0xea98a32d, Offset: 0x2c8
// Size: 0x1c
function private __init__() {
    if (!isdefined(level._melee_weapons)) {
        level._melee_weapons = [];
    }
}

// Namespace zm_melee_weapon
// Params 0, eflags: 0x5 linked
// Checksum 0x99ec1590, Offset: 0x2f0
// Size: 0x4
function private __main__() {
    
}

// Namespace zm_melee_weapon
// Params 9, eflags: 0x1 linked
// Checksum 0x69ceac63, Offset: 0x300
// Size: 0x404
function init(weapon_name, flourish_weapon_name, var_ae3c4699, var_92998c6a, cost, wallbuy_targetname, hint_string, vo_dialog_id, flourish_fn) {
    weapon = getweapon(weapon_name);
    flourish_weapon = getweapon(flourish_weapon_name);
    var_834ec52d = level.weaponnone;
    if (isdefined(var_ae3c4699)) {
        var_834ec52d = getweapon(var_ae3c4699);
    }
    var_499da020 = level.weaponnone;
    if (isdefined(var_92998c6a)) {
        var_499da020 = getweapon(var_92998c6a);
    }
    add_melee_weapon(weapon, flourish_weapon, var_834ec52d, var_499da020, cost, wallbuy_targetname, hint_string, vo_dialog_id, flourish_fn);
    melee_weapon_triggers = getentarray(wallbuy_targetname, "targetname");
    for (i = 0; i < melee_weapon_triggers.size; i++) {
        knife_model = getent(melee_weapon_triggers[i].target, "targetname");
        if (isdefined(knife_model)) {
            knife_model hide();
        }
        melee_weapon_triggers[i] thread melee_weapon_think(weapon, cost, flourish_fn, vo_dialog_id, flourish_weapon, var_834ec52d, var_499da020);
        melee_weapon_triggers[i] sethintstring(hint_string, cost);
        cursor_hint = "HINT_WEAPON";
        cursor_hint_weapon = weapon;
        melee_weapon_triggers[i] setcursorhint(cursor_hint, cursor_hint_weapon);
        melee_weapon_triggers[i] usetriggerrequirelookat();
    }
    melee_weapon_structs = struct::get_array(wallbuy_targetname, "targetname");
    for (i = 0; i < melee_weapon_structs.size; i++) {
        prepare_stub(melee_weapon_structs[i].trigger_stub, weapon, flourish_weapon, var_834ec52d, var_499da020, cost, wallbuy_targetname, hint_string, vo_dialog_id, flourish_fn);
    }
    zm_utility::register_melee_weapon_for_level(weapon.name);
    if (!isdefined(level.var_834ec52d)) {
        level.var_834ec52d = [];
    }
    level.var_834ec52d[weapon] = var_834ec52d;
    if (!isdefined(level.var_499da020)) {
        level.var_499da020 = [];
    }
    level.var_499da020[weapon] = var_499da020;
    /#
        if (!isdefined(level.zombie_weapons[weapon])) {
            if (isdefined(level.devgui_add_weapon)) {
                [[ level.devgui_add_weapon ]](weapon, "weapon_change_complete", weapon_name, cost);
            }
        }
    #/
}

// Namespace zm_melee_weapon
// Params 10, eflags: 0x1 linked
// Checksum 0xdd92b386, Offset: 0x710
// Size: 0x164
function prepare_stub(stub, weapon, flourish_weapon, var_834ec52d, var_499da020, cost, wallbuy_targetname, hint_string, vo_dialog_id, flourish_fn) {
    if (isdefined(stub)) {
        stub.hint_string = hint_string;
        stub.cursor_hint = "HINT_WEAPON";
        stub.cursor_hint_weapon = weapon;
        stub.cost = cost;
        if (!(isdefined(level.var_dc23b46e) && level.var_dc23b46e)) {
            stub.hint_parm1 = cost;
        }
        stub.weapon = weapon;
        stub.vo_dialog_id = vo_dialog_id;
        stub.flourish_weapon = flourish_weapon;
        stub.var_834ec52d = var_834ec52d;
        stub.var_499da020 = var_499da020;
        stub.trigger_func = &melee_weapon_think;
        stub.flourish_fn = flourish_fn;
    }
}

// Namespace zm_melee_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0xedaaeec5, Offset: 0x880
// Size: 0x7a
function find_melee_weapon(weapon) {
    melee_weapon = undefined;
    for (i = 0; i < level._melee_weapons.size; i++) {
        if (level._melee_weapons[i].weapon == weapon) {
            return level._melee_weapons[i];
        }
    }
    return undefined;
}

// Namespace zm_melee_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0xd2855f80, Offset: 0x908
// Size: 0xcc
function add_stub(stub, weapon) {
    melee_weapon = find_melee_weapon(weapon);
    if (isdefined(stub) && isdefined(melee_weapon)) {
        prepare_stub(stub, melee_weapon.weapon, melee_weapon.flourish_weapon, melee_weapon.var_834ec52d, melee_weapon.var_499da020, melee_weapon.cost, melee_weapon.wallbuy_targetname, melee_weapon.hint_string, melee_weapon.vo_dialog_id, melee_weapon.flourish_fn);
    }
}

// Namespace zm_melee_weapon
// Params 9, eflags: 0x1 linked
// Checksum 0xd01bf85e, Offset: 0x9e0
// Size: 0x14a
function add_melee_weapon(weapon, flourish_weapon, var_834ec52d, var_499da020, cost, wallbuy_targetname, hint_string, vo_dialog_id, flourish_fn) {
    melee_weapon = spawnstruct();
    melee_weapon.weapon = weapon;
    melee_weapon.flourish_weapon = flourish_weapon;
    melee_weapon.var_834ec52d = var_834ec52d;
    melee_weapon.var_499da020 = var_499da020;
    melee_weapon.cost = cost;
    melee_weapon.wallbuy_targetname = wallbuy_targetname;
    melee_weapon.hint_string = hint_string;
    melee_weapon.vo_dialog_id = vo_dialog_id;
    melee_weapon.flourish_fn = flourish_fn;
    if (!isdefined(level._melee_weapons)) {
        level._melee_weapons = [];
    }
    level._melee_weapons[level._melee_weapons.size] = melee_weapon;
}

// Namespace zm_melee_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0x552d9317, Offset: 0xb38
// Size: 0x78
function set_fallback_weapon(weapon_name, fallback_weapon_name) {
    melee_weapon = find_melee_weapon(getweapon(weapon_name));
    if (isdefined(melee_weapon)) {
        melee_weapon.fallback_weapon = getweapon(fallback_weapon_name);
    }
}

// Namespace zm_melee_weapon
// Params 0, eflags: 0x1 linked
// Checksum 0xb95c5400, Offset: 0xbb8
// Size: 0xb8
function determine_fallback_weapon() {
    fallback_weapon = level.weaponzmfists;
    if (isdefined(self zm_utility::get_player_melee_weapon()) && self hasweapon(self zm_utility::get_player_melee_weapon())) {
        melee_weapon = find_melee_weapon(self zm_utility::get_player_melee_weapon());
        if (isdefined(melee_weapon) && isdefined(melee_weapon.fallback_weapon)) {
            return melee_weapon.fallback_weapon;
        }
    }
    return fallback_weapon;
}

// Namespace zm_melee_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0x8fdca476, Offset: 0xc78
// Size: 0xcc
function give_fallback_weapon(immediate) {
    if (!isdefined(immediate)) {
        immediate = 0;
    }
    fallback_weapon = self determine_fallback_weapon();
    had_weapon = self hasweapon(fallback_weapon);
    self giveweapon(fallback_weapon);
    if (immediate && had_weapon) {
        self switchtoweaponimmediate(fallback_weapon);
        return;
    }
    self switchtoweapon(fallback_weapon);
}

// Namespace zm_melee_weapon
// Params 0, eflags: 0x1 linked
// Checksum 0x3d84e3c, Offset: 0xd50
// Size: 0x70
function take_fallback_weapon() {
    fallback_weapon = self determine_fallback_weapon();
    had_weapon = self hasweapon(fallback_weapon);
    self zm_weapons::weapon_take(fallback_weapon);
    return had_weapon;
}

// Namespace zm_melee_weapon
// Params 0, eflags: 0x1 linked
// Checksum 0xbbd14c45, Offset: 0xdc8
// Size: 0x66
function player_can_see_weapon_prompt() {
    if (isdefined(level._allow_melee_weapon_switching) && level._allow_melee_weapon_switching) {
        return true;
    }
    if (isdefined(self zm_utility::get_player_melee_weapon()) && self hasweapon(self zm_utility::get_player_melee_weapon())) {
        return false;
    }
    return true;
}

// Namespace zm_melee_weapon
// Params 0, eflags: 0x1 linked
// Checksum 0x7106c360, Offset: 0xe38
// Size: 0x76
function spectator_respawn_all() {
    for (i = 0; i < level._melee_weapons.size; i++) {
        self spectator_respawn(level._melee_weapons[i].wallbuy_targetname, level._melee_weapons[i].weapon);
    }
}

// Namespace zm_melee_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0x7a5a2924, Offset: 0xeb8
// Size: 0x128
function spectator_respawn(wallbuy_targetname, weapon) {
    melee_triggers = getentarray(wallbuy_targetname, "targetname");
    players = getplayers();
    for (i = 0; i < melee_triggers.size; i++) {
        melee_triggers[i] setvisibletoall();
        if (!(isdefined(level._allow_melee_weapon_switching) && level._allow_melee_weapon_switching)) {
            for (j = 0; j < players.size; j++) {
                if (!players[j] player_can_see_weapon_prompt()) {
                    melee_triggers[i] setinvisibletoplayer(players[j]);
                }
            }
        }
    }
}

// Namespace zm_melee_weapon
// Params 0, eflags: 0x1 linked
// Checksum 0x34b95186, Offset: 0xfe8
// Size: 0x5e
function trigger_hide_all() {
    for (i = 0; i < level._melee_weapons.size; i++) {
        self trigger_hide(level._melee_weapons[i].wallbuy_targetname);
    }
}

// Namespace zm_melee_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0xbe4f1451, Offset: 0x1050
// Size: 0x7e
function trigger_hide(wallbuy_targetname) {
    melee_triggers = getentarray(wallbuy_targetname, "targetname");
    for (i = 0; i < melee_triggers.size; i++) {
        melee_triggers[i] setinvisibletoplayer(self);
    }
}

// Namespace zm_melee_weapon
// Params 0, eflags: 0x1 linked
// Checksum 0xed60ebe7, Offset: 0x10d8
// Size: 0x70
function function_52b66e86() {
    primaryweapons = self getweaponslistprimaries();
    for (i = 0; i < primaryweapons.size; i++) {
        if (primaryweapons[i].isballisticknife) {
            return true;
        }
    }
    return false;
}

// Namespace zm_melee_weapon
// Params 0, eflags: 0x1 linked
// Checksum 0x9c70b984, Offset: 0x1150
// Size: 0x90
function function_9f93cad8() {
    primaryweapons = self getweaponslistprimaries();
    for (i = 0; i < primaryweapons.size; i++) {
        if (primaryweapons[i].isballisticknife && zm_weapons::is_weapon_upgraded(primaryweapons[i])) {
            return true;
        }
    }
    return false;
}

// Namespace zm_melee_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0x83e1b7b9, Offset: 0x11e8
// Size: 0xbe
function function_b81c1f0(weapon, upgraded) {
    current_melee_weapon = self zm_utility::get_player_melee_weapon();
    if (isdefined(current_melee_weapon)) {
        if (upgraded && isdefined(level.var_499da020) && isdefined(level.var_499da020[current_melee_weapon])) {
            weapon = level.var_499da020[current_melee_weapon];
        }
        if (!upgraded && isdefined(level.var_834ec52d) && isdefined(level.var_834ec52d[current_melee_weapon])) {
            weapon = level.var_834ec52d[current_melee_weapon];
        }
    }
    return weapon;
}

// Namespace zm_melee_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0xb5a06e8b, Offset: 0x12b0
// Size: 0x278
function change_melee_weapon(weapon, current_weapon) {
    had_fallback_weapon = self take_fallback_weapon();
    current_melee_weapon = self zm_utility::get_player_melee_weapon();
    if (current_melee_weapon != level.weaponnone && current_melee_weapon != weapon) {
        self takeweapon(current_melee_weapon);
    }
    self zm_utility::set_player_melee_weapon(weapon);
    var_b8e08f70 = 0;
    var_c0d5ccf3 = 0;
    var_beeec9b = 0;
    primaryweapons = self getweaponslistprimaries();
    for (i = 0; i < primaryweapons.size; i++) {
        primary_weapon = primaryweapons[i];
        if (primary_weapon.isballisticknife) {
            var_b8e08f70 = 1;
            if (primary_weapon == current_weapon) {
                var_beeec9b = 1;
            }
            self notify(#"hash_987c489b");
            self takeweapon(primary_weapon);
            if (zm_weapons::is_weapon_upgraded(primary_weapon)) {
                var_c0d5ccf3 = 1;
            }
        }
    }
    if (var_b8e08f70) {
        if (var_c0d5ccf3) {
            var_c5f559e5 = level.var_499da020[weapon];
            if (var_beeec9b) {
                current_weapon = var_c5f559e5;
            }
            self zm_weapons::give_build_kit_weapon(var_c5f559e5);
        } else {
            var_c5f559e5 = level.var_834ec52d[weapon];
            if (var_beeec9b) {
                current_weapon = var_c5f559e5;
            }
            self giveweapon(var_c5f559e5, 0);
        }
    }
    if (had_fallback_weapon) {
        self give_fallback_weapon();
    }
    return current_weapon;
}

// Namespace zm_melee_weapon
// Params 7, eflags: 0x1 linked
// Checksum 0x5d150929, Offset: 0x1530
// Size: 0x5e8
function melee_weapon_think(weapon, cost, flourish_fn, vo_dialog_id, flourish_weapon, var_834ec52d, var_499da020) {
    self.first_time_triggered = 0;
    if (isdefined(self.stub)) {
        self endon(#"kill_trigger");
        if (isdefined(self.stub.first_time_triggered)) {
            self.first_time_triggered = self.stub.first_time_triggered;
        }
        weapon = self.stub.weapon;
        cost = self.stub.cost;
        flourish_fn = self.stub.flourish_fn;
        vo_dialog_id = self.stub.vo_dialog_id;
        flourish_weapon = self.stub.flourish_weapon;
        var_834ec52d = self.stub.var_834ec52d;
        var_499da020 = self.stub.var_499da020;
        players = getplayers();
        if (!(isdefined(level._allow_melee_weapon_switching) && level._allow_melee_weapon_switching)) {
            for (i = 0; i < players.size; i++) {
                if (!players[i] player_can_see_weapon_prompt()) {
                    self setinvisibletoplayer(players[i]);
                }
            }
        }
    }
    for (;;) {
        player = self waittill(#"trigger");
        if (!zm_utility::is_player_valid(player)) {
            player thread zm_utility::ignore_triggers(0.5);
            continue;
        }
        if (player zm_utility::in_revive_trigger()) {
            wait(0.1);
            continue;
        }
        if (player isthrowinggrenade()) {
            wait(0.1);
            continue;
        }
        if (player.is_drinking > 0) {
            wait(0.1);
            continue;
        }
        player_has_weapon = player hasweapon(weapon);
        if (player_has_weapon || player zm_utility::has_powerup_weapon()) {
            wait(0.1);
            continue;
        }
        if (player isswitchingweapons()) {
            wait(0.1);
            continue;
        }
        current_weapon = player getcurrentweapon();
        if (zm_utility::is_placeable_mine(current_weapon) || zm_equipment::is_equipment(current_weapon)) {
            wait(0.1);
            continue;
        }
        if (isdefined(player.intermission) && (player laststand::player_is_in_laststand() || player.intermission)) {
            wait(0.1);
            continue;
        }
        if (isdefined(player.check_override_melee_wallbuy_purchase)) {
            if (player [[ player.check_override_melee_wallbuy_purchase ]](vo_dialog_id, flourish_weapon, weapon, var_834ec52d, var_499da020, flourish_fn, self)) {
                continue;
            }
        }
        if (!player_has_weapon) {
            cost = self.stub.cost;
            if (player namespace_25f8c2ad::function_dc08b4af()) {
                cost = int(cost / 2);
            }
            if (player zm_score::can_player_purchase(cost)) {
                if (self.first_time_triggered == 0) {
                    model = getent(self.target, "targetname");
                    if (isdefined(model)) {
                        model thread melee_weapon_show(player);
                    } else if (isdefined(self.clientfieldname)) {
                        level clientfield::set(self.clientfieldname, 1);
                    }
                    self.first_time_triggered = 1;
                    if (isdefined(self.stub)) {
                        self.stub.first_time_triggered = 1;
                    }
                }
                player zm_score::minus_to_player_score(cost);
                player thread give_melee_weapon(vo_dialog_id, flourish_weapon, weapon, var_834ec52d, var_499da020, flourish_fn, self);
            } else {
                zm_utility::play_sound_on_ent("no_purchase");
                player zm_audio::create_and_play_dialog("general", "outofmoney", 1);
            }
            continue;
        }
        if (!(isdefined(level._allow_melee_weapon_switching) && level._allow_melee_weapon_switching)) {
            self setinvisibletoplayer(player);
        }
    }
}

// Namespace zm_melee_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0x23c93adf, Offset: 0x1b20
// Size: 0x184
function melee_weapon_show(player) {
    player_angles = vectortoangles(player.origin - self.origin);
    player_yaw = player_angles[1];
    weapon_yaw = self.angles[1];
    yaw_diff = angleclamp180(player_yaw - weapon_yaw);
    if (yaw_diff > 0) {
        yaw = weapon_yaw - 90;
    } else {
        yaw = weapon_yaw + 90;
    }
    self.og_origin = self.origin;
    self.origin += anglestoforward((0, yaw, 0)) * 8;
    wait(0.05);
    self show();
    zm_utility::play_sound_at_pos("weapon_show", self.origin, self);
    time = 1;
    self moveto(self.og_origin, time);
}

// Namespace zm_melee_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0xc586c5b5, Offset: 0x1cb0
// Size: 0xbc
function award_melee_weapon(weapon_name) {
    weapon = getweapon(weapon_name);
    melee_weapon = find_melee_weapon(weapon);
    if (isdefined(melee_weapon)) {
        self give_melee_weapon(melee_weapon.vo_dialog_id, melee_weapon.flourish_weapon, melee_weapon.weapon, melee_weapon.var_834ec52d, melee_weapon.var_499da020, melee_weapon.flourish_fn, undefined);
    }
}

// Namespace zm_melee_weapon
// Params 7, eflags: 0x1 linked
// Checksum 0xfce404a5, Offset: 0x1d78
// Size: 0x184
function give_melee_weapon(vo_dialog_id, flourish_weapon, weapon, var_834ec52d, var_499da020, flourish_fn, trigger) {
    if (isdefined(flourish_fn)) {
        self thread [[ flourish_fn ]]();
    }
    original_weapon = self do_melee_weapon_flourish_begin(flourish_weapon);
    self zm_audio::create_and_play_dialog("weapon_pickup", vo_dialog_id);
    self util::waittill_any("fake_death", "death", "player_downed", "weapon_change_complete");
    self do_melee_weapon_flourish_end(original_weapon, flourish_weapon, weapon, var_834ec52d, var_499da020);
    if (isdefined(self.intermission) && (self laststand::player_is_in_laststand() || self.intermission)) {
        return;
    }
    if (!(isdefined(level._allow_melee_weapon_switching) && level._allow_melee_weapon_switching)) {
        if (isdefined(trigger)) {
            trigger setinvisibletoplayer(self);
        }
        self trigger_hide_all();
    }
}

// Namespace zm_melee_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0x26783d8a, Offset: 0x1f08
// Size: 0xa8
function do_melee_weapon_flourish_begin(flourish_weapon) {
    self zm_utility::increment_is_drinking();
    self zm_utility::disable_player_move_states(1);
    original_weapon = self getcurrentweapon();
    weapon = flourish_weapon;
    self zm_weapons::give_build_kit_weapon(weapon);
    self switchtoweapon(weapon);
    return original_weapon;
}

// Namespace zm_melee_weapon
// Params 5, eflags: 0x1 linked
// Checksum 0x4c0df75b, Offset: 0x1fb8
// Size: 0x2bc
function do_melee_weapon_flourish_end(original_weapon, flourish_weapon, weapon, var_834ec52d, var_499da020) {
    /#
        assert(!original_weapon.isperkbottle);
    #/
    /#
        assert(original_weapon != level.weaponrevivetool);
    #/
    self zm_utility::enable_player_move_states();
    if (isdefined(self.intermission) && (self laststand::player_is_in_laststand() || self.intermission)) {
        self takeweapon(weapon);
        self.lastactiveweapon = level.weaponnone;
        return;
    }
    self takeweapon(flourish_weapon);
    self zm_weapons::give_build_kit_weapon(weapon);
    original_weapon = change_melee_weapon(weapon, original_weapon);
    if (self hasweapon(level.weaponbasemelee)) {
        self takeweapon(level.weaponbasemelee);
    }
    if (self zm_utility::is_multiple_drinking()) {
        self zm_utility::decrement_is_drinking();
        return;
    } else if (original_weapon == level.weaponbasemelee) {
        self switchtoweapon(weapon);
        self zm_utility::decrement_is_drinking();
        return;
    } else if (original_weapon != level.weaponbasemelee && !zm_utility::is_placeable_mine(original_weapon) && !zm_equipment::is_equipment(original_weapon)) {
        self zm_weapons::switch_back_primary_weapon(original_weapon);
    } else {
        self zm_weapons::switch_back_primary_weapon();
    }
    self waittill(#"weapon_change_complete");
    if (!self laststand::player_is_in_laststand() && !(isdefined(self.intermission) && self.intermission)) {
        self zm_utility::decrement_is_drinking();
    }
}

