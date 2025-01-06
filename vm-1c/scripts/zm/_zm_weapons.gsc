#using scripts/codescripts/struct;
#using scripts/shared/aat_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weaponobjects;
#using scripts/zm/_bb;
#using scripts/zm/_util;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_melee_weapon;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_placeable_mine;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_ballistic_knife;
#using scripts/zm/gametypes/_weapons;

#namespace zm_weapons;

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0xd9cb0822, Offset: 0x8e8
// Size: 0xbc
function init() {
    if (!isdefined(level.pack_a_punch_camo_index)) {
        level.pack_a_punch_camo_index = 42;
    }
    if (!isdefined(level.var_dc23b46e)) {
        level.var_dc23b46e = 1;
    }
    if (!isdefined(level.var_9b83d7)) {
        level.var_9b83d7 = 0;
    }
    init_weapons();
    init_weapon_upgrade();
    level._weaponobjects_on_player_connect_override = &function_fc84698b;
    level._zombiemode_check_firesale_loc_valid_func = &default_check_firesale_loc_valid_func;
    level.missileentities = [];
    level thread onplayerconnect();
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x61e8c6a, Offset: 0x9b0
// Size: 0x38
function onplayerconnect() {
    for (;;) {
        level waittill(#"connecting", player);
        player thread onplayerspawned();
    }
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x52b9e73a, Offset: 0x9f0
// Size: 0x5c
function onplayerspawned() {
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"spawned_player");
        self thread watchforgrenadeduds();
        self thread watchforgrenadelauncherduds();
        self.staticweaponsstarttime = gettime();
    }
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0xa914751d, Offset: 0xa58
// Size: 0xc0
function watchforgrenadeduds() {
    self endon(#"spawned_player");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"grenade_fire", grenade, weapon);
        if (!zm_equipment::is_equipment(weapon) && !zm_utility::is_placeable_mine(weapon)) {
            grenade thread checkgrenadefordud(weapon, 1, self);
            grenade thread function_c6d62e4f(weapon, 1, self);
        }
    }
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x5bd0b4ca, Offset: 0xb20
// Size: 0x88
function watchforgrenadelauncherduds() {
    self endon(#"spawned_player");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"grenade_launcher_fire", grenade, weapon);
        grenade thread checkgrenadefordud(weapon, 0, self);
        grenade thread function_c6d62e4f(weapon, 0, self);
    }
}

// Namespace zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x26b6066d, Offset: 0xbb0
// Size: 0x3c
function grenade_safe_to_throw(player, weapon) {
    if (isdefined(level.grenade_safe_to_throw)) {
        return self [[ level.grenade_safe_to_throw ]](player, weapon);
    }
    return 1;
}

// Namespace zm_weapons
// Params 2, eflags: 0x0
// Checksum 0xd9bcdeed, Offset: 0xbf8
// Size: 0x3c
function grenade_safe_to_bounce(player, weapon) {
    if (isdefined(level.grenade_safe_to_bounce)) {
        return self [[ level.grenade_safe_to_bounce ]](player, weapon);
    }
    return 1;
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x10f24109, Offset: 0xc40
// Size: 0x4c
function makegrenadedudanddestroy() {
    self endon(#"death");
    self notify(#"grenade_dud");
    self makegrenadedud();
    wait 3;
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace zm_weapons
// Params 3, eflags: 0x0
// Checksum 0x7d49cb78, Offset: 0xc98
// Size: 0xf2
function checkgrenadefordud(weapon, isthrowngrenade, player) {
    self endon(#"death");
    player endon(#"zombify");
    if (!isdefined(self)) {
        return;
    }
    if (!self grenade_safe_to_throw(player, weapon)) {
        self thread makegrenadedudanddestroy();
        return;
    }
    for (;;) {
        self util::function_183e3618(0.25, "grenade_bounce", "stationary", "death", player, "zombify");
        if (!self grenade_safe_to_bounce(player, weapon)) {
            self thread makegrenadedudanddestroy();
            return;
        }
    }
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x6a662672, Offset: 0xd98
// Size: 0x5a
function function_567b6554() {
    self endon(#"grenade_dud");
    self endon(#"done");
    self waittill(#"explode", position);
    level.var_12ec6646 = position;
    level.var_a1672eb9 = 1;
    self notify(#"done");
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x37623555, Offset: 0xe00
// Size: 0x4a
function function_5846b5e2(time) {
    self endon(#"grenade_dud");
    self endon(#"done");
    self endon(#"explode");
    wait time;
    if (isdefined(self)) {
        self notify(#"done");
    }
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xf5140818, Offset: 0xe58
// Size: 0x7e
function function_b0aaa19e(time) {
    level.var_12ec6646 = (0, 0, 0);
    level.var_a1672eb9 = 0;
    self thread function_567b6554();
    self thread function_5846b5e2(time);
    self waittill(#"done");
    self notify(#"hash_55b80a65", level.var_a1672eb9, level.var_12ec6646);
}

// Namespace zm_weapons
// Params 3, eflags: 0x0
// Checksum 0x3fe36e4b, Offset: 0xee0
// Size: 0xae
function function_c6d62e4f(weapon, isthrowngrenade, player) {
    self endon(#"grenade_dud");
    if (zm_utility::is_lethal_grenade(weapon) || weapon.islauncher) {
        self thread function_b0aaa19e(20);
        self waittill(#"hash_55b80a65", exploded, position);
        if (exploded) {
            level notify(#"grenade_exploded", position, 256, 300, 75);
        }
    }
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xe5a5abea, Offset: 0xf98
// Size: 0x30
function get_nonalternate_weapon(weapon) {
    if (weapon.isaltmode) {
        return weapon.altweapon;
    }
    return weapon;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x51a046b9, Offset: 0xfd0
// Size: 0xb6
function switch_from_alt_weapon(weapon) {
    if (weapon.ischargeshot) {
        return weapon;
    }
    alt = get_nonalternate_weapon(weapon);
    if (alt != weapon) {
        if (!weaponhasattachment(weapon, "dualoptic")) {
            self switchtoweaponimmediate(alt);
            self util::waittill_any_timeout(1, "weapon_change_complete");
        }
        return alt;
    }
    return weapon;
}

// Namespace zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x7beec2e7, Offset: 0x1090
// Size: 0x4c
function give_start_weapons(takeallweapons, alreadyspawned) {
    self giveweapon(level.weaponbasemelee);
    self zm_utility::give_start_weapon(1);
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x1ff0a4e6, Offset: 0x10e8
// Size: 0x34
function give_fallback_weapon(immediate) {
    if (!isdefined(immediate)) {
        immediate = 0;
    }
    zm_melee_weapon::give_fallback_weapon(immediate);
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x1405e12e, Offset: 0x1128
// Size: 0x14
function take_fallback_weapon() {
    zm_melee_weapon::take_fallback_weapon();
}

// Namespace zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x67f8e602, Offset: 0x1148
// Size: 0x224
function switch_back_primary_weapon(oldprimary, immediate) {
    if (!isdefined(immediate)) {
        immediate = 0;
    }
    if (isdefined(self.laststand) && self.laststand) {
        return;
    }
    if (!isdefined(oldprimary) || oldprimary == level.weaponnone || oldprimary.isflourishweapon || zm_utility::is_melee_weapon(oldprimary) || zm_utility::is_placeable_mine(oldprimary) || zm_utility::is_lethal_grenade(oldprimary) || zm_utility::is_tactical_grenade(oldprimary) || !self hasweapon(oldprimary)) {
        oldprimary = undefined;
    } else if (!isdefined(self.hero_power) || (oldprimary.isheroweapon || oldprimary.isgadget) && self.hero_power <= 0) {
        oldprimary = undefined;
    }
    primaryweapons = self getweaponslistprimaries();
    if (isdefined(oldprimary) && isinarray(primaryweapons, oldprimary)) {
        if (immediate) {
            self switchtoweaponimmediate(oldprimary);
        } else {
            self switchtoweapon(oldprimary);
        }
        return;
    }
    if (primaryweapons.size > 0) {
        if (immediate) {
            self switchtoweaponimmediate();
        } else {
            self switchtoweapon();
        }
        return;
    }
    give_fallback_weapon(immediate);
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x2c01a14c, Offset: 0x1378
// Size: 0x3a
function function_94719ba3(name) {
    if (!isdefined(level.var_ba14e572)) {
        level.var_ba14e572 = [];
    }
    level.var_ba14e572[level.var_ba14e572.size] = name;
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x4b17d5cc, Offset: 0x13c0
// Size: 0x116
function function_4f42dd4c() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    for (;;) {
        self waittill(#"weapon_fired", curweapon);
        self.lastfiretime = gettime();
        self.hasdonecombat = 1;
        switch (curweapon.weapclass) {
        case "mg":
        case "pistol":
        case "pistol spread":
        case "pistolspread":
        case "rifle":
        case "smg":
        case "spread":
            self weapons::trackweaponfire(curweapon);
            level.globalshotsfired++;
            break;
        case "grenade":
        case "rocketlauncher":
            self addweaponstat(curweapon, "shots", 1);
            break;
        default:
            break;
        }
    }
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x365bfd, Offset: 0x14e0
// Size: 0x162
function function_26d88099() {
    self.currentweapon = self getcurrentweapon();
    self.currenttime = gettime();
    spawnid = getplayerspawnid(self);
    while (true) {
        event = self util::waittill_any_return("weapon_change", "death", "disconnect", "bled_out");
        newtime = gettime();
        if (event == "weapon_change") {
            newweapon = self getcurrentweapon();
            if (newweapon != level.weaponnone && newweapon != self.currentweapon) {
                updatelastheldweapontimingszm(newtime);
                self.currentweapon = newweapon;
                self.currenttime = newtime;
            }
            continue;
        }
        if (event != "death" && event != "disconnect") {
            updateweapontimingszm(newtime);
        }
        return;
    }
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xd1030997, Offset: 0x1650
// Size: 0x9c
function updatelastheldweapontimingszm(newtime) {
    if (isdefined(self.currentweapon) && isdefined(self.currenttime)) {
        curweapon = self.currentweapon;
        totaltime = int((newtime - self.currenttime) / 1000);
        if (totaltime > 0) {
            self addweaponstat(curweapon, "timeUsed", totaltime);
        }
    }
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xfe622a7a, Offset: 0x16f8
// Size: 0x94
function updateweapontimingszm(newtime) {
    if (self util::is_bot()) {
        return;
    }
    updatelastheldweapontimingszm(newtime);
    if (!isdefined(self.staticweaponsstarttime)) {
        return;
    }
    totaltime = int((newtime - self.staticweaponsstarttime) / 1000);
    if (totaltime < 0) {
        return;
    }
    self.staticweaponsstarttime = newtime;
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x1a59b42f, Offset: 0x1798
// Size: 0xc8
function function_a7ba05ad() {
    self endon(#"death");
    self endon(#"disconnect");
    self.lastdroppableweapon = self getcurrentweapon();
    self.hitsthismag = [];
    weapon = self getcurrentweapon();
    while (true) {
        previous_weapon = self getcurrentweapon();
        self waittill(#"weapon_change", newweapon);
        if (weapons::function_355e787(newweapon)) {
            self.lastdroppableweapon = newweapon;
        }
    }
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x910ac24, Offset: 0x1868
// Size: 0x152
function function_22d8e9bd() {
    self weaponobjects::function_59d41911();
    self zm_placeable_mine::setup_watchers();
    for (i = 0; i < level.var_ba14e572.size; i++) {
        self function_10ac3f1(level.var_ba14e572[i]);
    }
    self weaponobjects::setupretrievablewatcher();
    if (!isdefined(self.weaponobjectwatcherarray)) {
        self.weaponobjectwatcherarray = [];
    }
    self.concussionendtime = 0;
    self.hasdonecombat = 0;
    self.lastfiretime = 0;
    self thread function_4f42dd4c();
    self thread weapons::watchgrenadeusage();
    self thread weapons::watchmissileusage();
    self thread function_a7ba05ad();
    self thread function_26d88099();
    self notify(#"hash_593f018a");
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x2669961d, Offset: 0x19c8
// Size: 0x54
function function_fc84698b() {
    function_94719ba3("knife_ballistic");
    function_94719ba3("knife_ballistic_upgraded");
    callback::on_connect(&function_22d8e9bd);
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x393e9191, Offset: 0x1a28
// Size: 0x8c
function function_10ac3f1(weaponname) {
    watcher = self weaponobjects::createuseweaponobjectwatcher(weaponname, self.team);
    watcher.onspawn = &_zm_weap_ballistic_knife::on_spawn;
    watcher.onspawnretrievetriggers = &_zm_weap_ballistic_knife::on_spawn_retrieve_trigger;
    watcher.storedifferentobject = 1;
    watcher.headicon = 0;
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0xc5a2a25f, Offset: 0x1ac0
// Size: 0x8
function default_check_firesale_loc_valid_func() {
    return true;
}

// Namespace zm_weapons
// Params 10, eflags: 0x0
// Checksum 0x9e2fdfb7, Offset: 0x1ad0
// Size: 0x4c8
function add_zombie_weapon(weapon_name, upgrade_name, hint, cost, weaponvo, weaponvoresp, ammo_cost, create_vox, is_wonder_weapon, var_e44dc8f1) {
    weapon = getweapon(weapon_name);
    upgrade = undefined;
    if (isdefined(upgrade_name)) {
        upgrade = getweapon(upgrade_name);
    }
    if (isdefined(level.zombie_include_weapons) && !isdefined(level.zombie_include_weapons[weapon])) {
        return;
    }
    struct = spawnstruct();
    if (!isdefined(level.zombie_weapons)) {
        level.zombie_weapons = [];
    }
    if (!isdefined(level.zombie_weapons_upgraded)) {
        level.zombie_weapons_upgraded = [];
    }
    if (isdefined(upgrade_name)) {
        level.zombie_weapons_upgraded[upgrade] = weapon;
    }
    struct.weapon = weapon;
    struct.upgrade = upgrade;
    struct.weapon_classname = "weapon_" + weapon_name + "_zm";
    if (isdefined(level.var_dc23b46e) && level.var_dc23b46e) {
        struct.hint = %ZOMBIE_WEAPONCOSTONLY_CFILL;
    } else {
        struct.hint = %ZOMBIE_WEAPONCOSTONLYFILL;
    }
    struct.cost = cost;
    struct.vox = weaponvo;
    struct.vox_response = weaponvoresp;
    struct.is_wonder_weapon = is_wonder_weapon;
    struct.var_e44dc8f1 = [];
    if ("" != var_e44dc8f1) {
        var_334cc84c = strtok(var_e44dc8f1, " ");
        assert(6 >= var_334cc84c.size, weapon_name + "<dev string:x28>");
        foreach (attachment in var_334cc84c) {
            struct.var_e44dc8f1[struct.var_e44dc8f1.size] = attachment;
        }
    }
    println("<dev string:x51>" + weapon_name);
    struct.is_in_box = level.zombie_include_weapons[weapon];
    if (!isdefined(ammo_cost)) {
        ammo_cost = zm_utility::round_up_to_ten(int(cost * 0.5));
    }
    struct.ammo_cost = ammo_cost;
    if (isdefined(upgrade) && (weapon.isemp || upgrade.isemp)) {
        level.should_watch_for_emp = 1;
    }
    level.zombie_weapons[weapon] = struct;
    if (zm_pap_util::function_53616d7e() && isdefined(upgrade_name)) {
        function_e3556381(weapon_name, upgrade_name);
    }
    if (isdefined(create_vox)) {
        level.vox zm_audio::zmbvoxadd("player", "weapon_pickup", weapon, weaponvo, undefined);
    }
    /#
        if (isdefined(level.devgui_add_weapon)) {
            [[ level.devgui_add_weapon ]](weapon, upgrade, hint, cost, weaponvo, weaponvoresp, ammo_cost);
        }
    #/
}

// Namespace zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x39882fc8, Offset: 0x1fa0
// Size: 0x1a4
function function_e3556381(weapon, upgrade) {
    table = "gamedata/weapons/zm/pap_attach.csv";
    if (isdefined(level.var_3986937e)) {
        table = level.var_3986937e;
    }
    row = tablelookuprownum(table, 0, upgrade);
    if (row > -1) {
        level.zombie_weapons[weapon].default_attachment = tablelookup(table, 0, upgrade.name, 1);
        level.zombie_weapons[weapon].addon_attachments = [];
        index = 2;
        for (var_da6c9bed = tablelookup(table, 0, upgrade.name, index); isdefined(var_da6c9bed) && var_da6c9bed.size > 0; var_da6c9bed = tablelookup(table, 0, upgrade.name, index)) {
            level.zombie_weapons[weapon].addon_attachments[level.zombie_weapons[weapon].addon_attachments.size] = var_da6c9bed;
            index++;
        }
    }
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x833e67c3, Offset: 0x2150
// Size: 0x52
function is_weapon_included(weapon) {
    if (!isdefined(level.zombie_weapons)) {
        return false;
    }
    weapon = get_nonalternate_weapon(weapon);
    return isdefined(level.zombie_weapons[weapon.rootweapon]);
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x12dce875, Offset: 0x21b0
// Size: 0x66
function is_weapon_or_base_included(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    return isdefined(level.zombie_weapons[weapon.rootweapon]) || isdefined(level.zombie_weapons[get_base_weapon(weapon)]);
}

// Namespace zm_weapons
// Params 2, eflags: 0x0
// Checksum 0xec4fde8d, Offset: 0x2220
// Size: 0x86
function include_zombie_weapon(weapon_name, in_box) {
    if (!isdefined(level.zombie_include_weapons)) {
        level.zombie_include_weapons = [];
    }
    if (!isdefined(in_box)) {
        in_box = 1;
    }
    println("<dev string:x6d>" + weapon_name);
    level.zombie_include_weapons[getweapon(weapon_name)] = in_box;
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x21ce456a, Offset: 0x22b0
// Size: 0x20
function init_weapons() {
    if (isdefined(level.var_237b30e2)) {
        [[ level.var_237b30e2 ]]();
    }
}

// Namespace zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x8702e701, Offset: 0x22d8
// Size: 0x4e
function add_limited_weapon(weapon_name, amount) {
    if (!isdefined(level.limited_weapons)) {
        level.limited_weapons = [];
    }
    level.limited_weapons[getweapon(weapon_name)] = amount;
}

// Namespace zm_weapons
// Params 3, eflags: 0x0
// Checksum 0x40171222, Offset: 0x2330
// Size: 0x3f2
function limited_weapon_below_quota(weapon, ignore_player, var_10f9c82c) {
    if (isdefined(level.limited_weapons[weapon])) {
        if (!isdefined(var_10f9c82c)) {
            var_10f9c82c = zm_pap_util::function_f925b7b9();
        }
        if (isdefined(level.no_limited_weapons) && level.no_limited_weapons) {
            return false;
        }
        upgradedweapon = weapon;
        if (isdefined(level.zombie_weapons[weapon]) && isdefined(level.zombie_weapons[weapon].upgrade)) {
            upgradedweapon = level.zombie_weapons[weapon].upgrade;
        }
        players = getplayers();
        count = 0;
        limit = level.limited_weapons[weapon];
        for (i = 0; i < players.size; i++) {
            if (isdefined(ignore_player) && ignore_player == players[i]) {
                continue;
            }
            if (players[i] has_weapon_or_upgrade(weapon)) {
                count++;
                if (count >= limit) {
                    return false;
                }
            }
        }
        for (k = 0; k < var_10f9c82c.size; k++) {
            if (var_10f9c82c[k].current_weapon == weapon || isdefined(var_10f9c82c[k].current_weapon) && var_10f9c82c[k].current_weapon == upgradedweapon) {
                count++;
                if (count >= limit) {
                    return false;
                }
            }
        }
        for (var_f0013e88 = 0; var_f0013e88 < level.chests.size; var_f0013e88++) {
            if (isdefined(level.chests[var_f0013e88].zbarrier.weapon) && level.chests[var_f0013e88].zbarrier.weapon == weapon) {
                count++;
                if (count >= limit) {
                    return false;
                }
            }
        }
        if (isdefined(level.custom_limited_weapon_checks)) {
            foreach (check in level.custom_limited_weapon_checks) {
                count += [[ check ]](weapon);
            }
            if (count >= limit) {
                return false;
            }
        }
        if (isdefined(level.random_weapon_powerups)) {
            for (powerupindex = 0; powerupindex < level.random_weapon_powerups.size; powerupindex++) {
                if (isdefined(level.random_weapon_powerups[powerupindex]) && level.random_weapon_powerups[powerupindex].base_weapon == weapon) {
                    count++;
                    if (count >= limit) {
                        return false;
                    }
                }
            }
        }
    }
    return true;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x855ae8a0, Offset: 0x2730
// Size: 0x3a
function add_custom_limited_weapon_check(callback) {
    if (!isdefined(level.custom_limited_weapon_checks)) {
        level.custom_limited_weapon_checks = [];
    }
    level.custom_limited_weapon_checks[level.custom_limited_weapon_checks.size] = callback;
}

// Namespace zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x9c10f4e4, Offset: 0x2778
// Size: 0x4e
function add_weapon_to_content(weapon_name, package) {
    if (!isdefined(level.content_weapons)) {
        level.content_weapons = [];
    }
    level.content_weapons[getweapon(weapon_name)] = package;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x83859d78, Offset: 0x27d0
// Size: 0x50
function player_can_use_content(weapon) {
    if (isdefined(level.content_weapons)) {
        if (isdefined(level.content_weapons[weapon])) {
            return self hasdlcavailable(level.content_weapons[weapon]);
        }
    }
    return 1;
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x7cc187af, Offset: 0x2828
// Size: 0xc34
function init_spawnable_weapon_upgrade() {
    spawn_list = [];
    spawnable_weapon_spawns = struct::get_array("weapon_upgrade", "targetname");
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("bowie_upgrade", "targetname"), 1, 0);
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("sickle_upgrade", "targetname"), 1, 0);
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("tazer_upgrade", "targetname"), 1, 0);
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("buildable_wallbuy", "targetname"), 1, 0);
    if (isdefined(level.use_autofill_wallbuy) && level.use_autofill_wallbuy) {
        spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, level.active_autofill_wallbuys, 1, 0);
    }
    if (!(isdefined(level.headshots_only) && level.headshots_only)) {
        spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("claymore_purchase", "targetname"), 1, 0);
    }
    location = level.scr_zm_map_start_location;
    if ((location == "default" || location == "") && isdefined(level.default_start_location)) {
        location = level.default_start_location;
    }
    match_string = level.scr_zm_ui_gametype;
    if ("" != location) {
        match_string = match_string + "_" + location;
    }
    match_string_plus_space = " " + match_string;
    for (i = 0; i < spawnable_weapon_spawns.size; i++) {
        spawnable_weapon = spawnable_weapon_spawns[i];
        spawnable_weapon.weapon = getweapon(spawnable_weapon.zombie_weapon_upgrade);
        if (isdefined(level.headshots_only) && isdefined(spawnable_weapon.zombie_weapon_upgrade) && spawnable_weapon.weapon.isgrenadeweapon && level.headshots_only) {
            continue;
        }
        if (!isdefined(spawnable_weapon.script_noteworthy) || spawnable_weapon.script_noteworthy == "") {
            spawn_list[spawn_list.size] = spawnable_weapon;
            continue;
        }
        matches = strtok(spawnable_weapon.script_noteworthy, ",");
        for (j = 0; j < matches.size; j++) {
            if (matches[j] == match_string || matches[j] == match_string_plus_space) {
                spawn_list[spawn_list.size] = spawnable_weapon;
            }
        }
    }
    tempmodel = spawn("script_model", (0, 0, 0));
    for (i = 0; i < spawn_list.size; i++) {
        clientfieldname = spawn_list[i].zombie_weapon_upgrade + "_" + spawn_list[i].origin;
        numbits = 2;
        if (isdefined(level._wallbuy_override_num_bits)) {
            numbits = level._wallbuy_override_num_bits;
        }
        clientfield::register("world", clientfieldname, 1, numbits, "int");
        target_struct = struct::get(spawn_list[i].target, "targetname");
        if (spawn_list[i].targetname == "buildable_wallbuy") {
            bits = 4;
            if (isdefined(level.buildable_wallbuy_weapons)) {
                bits = getminbitcountfornum(level.buildable_wallbuy_weapons.size + 1);
            }
            clientfield::register("world", clientfieldname + "_idx", 1, bits, "int");
            spawn_list[i].clientfieldname = clientfieldname;
            continue;
        }
        unitrigger_stub = spawnstruct();
        unitrigger_stub.origin = spawn_list[i].origin;
        unitrigger_stub.angles = spawn_list[i].angles;
        tempmodel.origin = spawn_list[i].origin;
        tempmodel.angles = spawn_list[i].angles;
        mins = undefined;
        maxs = undefined;
        absmins = undefined;
        absmaxs = undefined;
        tempmodel setmodel(target_struct.model);
        tempmodel useweaponhidetags(spawn_list[i].weapon);
        mins = tempmodel getmins();
        maxs = tempmodel getmaxs();
        absmins = tempmodel getabsmins();
        absmaxs = tempmodel getabsmaxs();
        bounds = absmaxs - absmins;
        unitrigger_stub.script_length = bounds[0] * 0.25;
        unitrigger_stub.script_width = bounds[1];
        unitrigger_stub.script_height = bounds[2];
        unitrigger_stub.origin -= anglestoright(unitrigger_stub.angles) * unitrigger_stub.script_length * 0.4;
        unitrigger_stub.target = spawn_list[i].target;
        unitrigger_stub.targetname = spawn_list[i].targetname;
        unitrigger_stub.cursor_hint = "HINT_NOICON";
        if (spawn_list[i].targetname == "weapon_upgrade") {
            unitrigger_stub.cost = get_weapon_cost(spawn_list[i].weapon);
            unitrigger_stub.hint_string = get_weapon_hint(spawn_list[i].weapon);
            if (!(isdefined(level.var_dc23b46e) && level.var_dc23b46e)) {
                unitrigger_stub.hint_parm1 = unitrigger_stub.cost;
            }
            unitrigger_stub.cursor_hint = "HINT_WEAPON";
            unitrigger_stub.cursor_hint_weapon = spawn_list[i].weapon;
        }
        unitrigger_stub.weapon = spawn_list[i].weapon;
        unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
        if (isdefined(int(spawn_list[i].script_string)) && isdefined(spawn_list[i].script_string) && int(spawn_list[i].script_string)) {
            unitrigger_stub.require_look_toward = 0;
            unitrigger_stub.require_look_at = 0;
            unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
            unitrigger_stub.script_length = bounds[0] * 0.4;
            unitrigger_stub.script_width = bounds[1] * 2;
            unitrigger_stub.script_height = bounds[2];
        } else {
            unitrigger_stub.require_look_at = 1;
        }
        if (isdefined(spawn_list[i].require_look_from) && spawn_list[i].require_look_from) {
            unitrigger_stub.require_look_from = 1;
        }
        unitrigger_stub.clientfieldname = clientfieldname;
        zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
        if (unitrigger_stub.weapon.ismeleeweapon || unitrigger_stub.weapon.isgrenadeweapon) {
            if (unitrigger_stub.weapon.name == "tazer_knuckles" && isdefined(level.taser_trig_adjustment)) {
                unitrigger_stub.origin += level.taser_trig_adjustment;
            }
            zm_unitrigger::register_static_unitrigger(unitrigger_stub, &weapon_spawn_think);
        } else {
            unitrigger_stub.prompt_and_visibility_func = &wall_weapon_update_prompt;
            zm_unitrigger::register_static_unitrigger(unitrigger_stub, &weapon_spawn_think);
        }
        spawn_list[i].trigger_stub = unitrigger_stub;
    }
    level._spawned_wallbuys = spawn_list;
    tempmodel delete();
}

// Namespace zm_weapons
// Params 3, eflags: 0x0
// Checksum 0xa392a838, Offset: 0x3468
// Size: 0x73c
function add_dynamic_wallbuy(weapon, wallbuy, pristine) {
    spawned_wallbuy = undefined;
    for (i = 0; i < level._spawned_wallbuys.size; i++) {
        if (level._spawned_wallbuys[i].target == wallbuy) {
            spawned_wallbuy = level._spawned_wallbuys[i];
            break;
        }
    }
    if (!isdefined(spawned_wallbuy)) {
        assertmsg("<dev string:x87>");
        return;
    }
    if (isdefined(spawned_wallbuy.trigger_stub)) {
        assertmsg("<dev string:xa3>");
        return;
    }
    target_struct = struct::get(wallbuy, "targetname");
    wallmodel = zm_utility::spawn_weapon_model(weapon, undefined, target_struct.origin, target_struct.angles, undefined);
    clientfieldname = spawned_wallbuy.clientfieldname;
    model = weapon.worldmodel;
    unitrigger_stub = spawnstruct();
    unitrigger_stub.origin = target_struct.origin;
    unitrigger_stub.angles = target_struct.angles;
    wallmodel.origin = target_struct.origin;
    wallmodel.angles = target_struct.angles;
    mins = undefined;
    maxs = undefined;
    absmins = undefined;
    absmaxs = undefined;
    wallmodel setmodel(model);
    wallmodel useweaponhidetags(weapon);
    mins = wallmodel getmins();
    maxs = wallmodel getmaxs();
    absmins = wallmodel getabsmins();
    absmaxs = wallmodel getabsmaxs();
    bounds = absmaxs - absmins;
    unitrigger_stub.script_length = bounds[0] * 0.25;
    unitrigger_stub.script_width = bounds[1];
    unitrigger_stub.script_height = bounds[2];
    unitrigger_stub.origin -= anglestoright(unitrigger_stub.angles) * unitrigger_stub.script_length * 0.4;
    unitrigger_stub.target = spawned_wallbuy.target;
    unitrigger_stub.targetname = "weapon_upgrade";
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    unitrigger_stub.first_time_triggered = !pristine;
    if (!weapon.ismeleeweapon) {
        if (pristine || zm_utility::is_placeable_mine(weapon)) {
            unitrigger_stub.hint_string = get_weapon_hint(weapon);
        } else {
            unitrigger_stub.hint_string = get_weapon_hint_ammo();
        }
        unitrigger_stub.cost = get_weapon_cost(weapon);
        if (!(isdefined(level.var_dc23b46e) && level.var_dc23b46e)) {
            unitrigger_stub.hint_parm1 = unitrigger_stub.cost;
        }
    }
    unitrigger_stub.weapon = weapon;
    unitrigger_stub.weapon_upgrade = weapon;
    unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    unitrigger_stub.require_look_at = 1;
    unitrigger_stub.clientfieldname = clientfieldname;
    zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
    if (weapon.ismeleeweapon) {
        if (weapon == "tazer_knuckles" && isdefined(level.taser_trig_adjustment)) {
            unitrigger_stub.origin += level.taser_trig_adjustment;
        }
        zm_melee_weapon::add_stub(unitrigger_stub, weapon);
        zm_unitrigger::register_static_unitrigger(unitrigger_stub, &zm_melee_weapon::melee_weapon_think);
    } else {
        unitrigger_stub.prompt_and_visibility_func = &wall_weapon_update_prompt;
        zm_unitrigger::register_static_unitrigger(unitrigger_stub, &weapon_spawn_think);
    }
    spawned_wallbuy.trigger_stub = unitrigger_stub;
    weaponidx = undefined;
    if (isdefined(level.buildable_wallbuy_weapons)) {
        for (i = 0; i < level.buildable_wallbuy_weapons.size; i++) {
            if (weapon == level.buildable_wallbuy_weapons[i]) {
                weaponidx = i;
                break;
            }
        }
    }
    if (isdefined(weaponidx)) {
        level clientfield::set(clientfieldname + "_idx", weaponidx + 1);
        wallmodel delete();
        if (!pristine) {
            level clientfield::set(clientfieldname, 1);
        }
        return;
    }
    level clientfield::set(clientfieldname, 1);
    wallmodel show();
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x1e5461ab, Offset: 0x3bb0
// Size: 0x738
function wall_weapon_update_prompt(player) {
    weapon = self.stub.weapon;
    player_has_weapon = player has_weapon_or_upgrade(weapon);
    if (isdefined(level.weapons_using_ammo_sharing) && !player_has_weapon && level.weapons_using_ammo_sharing) {
        shared_ammo_weapon = player get_shared_ammo_weapon(self.zombie_weapon_upgrade);
        if (isdefined(shared_ammo_weapon)) {
            weapon = shared_ammo_weapon;
            player_has_weapon = 1;
        }
    }
    if (isdefined(level.func_override_wallbuy_prompt)) {
        if (!self [[ level.func_override_wallbuy_prompt ]](player)) {
            return false;
        }
    }
    if (!player_has_weapon) {
        self.stub.cursor_hint = "HINT_WEAPON";
        cost = get_weapon_cost(weapon);
        if (isdefined(level.var_dc23b46e) && level.var_dc23b46e) {
            if (player bgb::is_enabled("zm_bgb_secret_shopper") && !is_wonder_weapon(player.currentweapon) && player.currentweapon.type !== "melee") {
                self.stub.hint_string = %ZOMBIE_WEAPONCOSTONLY_CFILL_BGB_SECRET_SHOPPER;
                self sethintstring(self.stub.hint_string);
            } else {
                self.stub.hint_string = %ZOMBIE_WEAPONCOSTONLY_CFILL;
                self sethintstring(self.stub.hint_string);
            }
        } else if (player bgb::is_enabled("zm_bgb_secret_shopper") && !is_wonder_weapon(player.currentweapon) && player.currentweapon.type !== "melee") {
            self.stub.hint_string = %ZOMBIE_WEAPONCOSTONLYFILL_BGB_SECRET_SHOPPER;
            var_7e03d6a7 = player get_ammo_cost_for_weapon(player.currentweapon);
            self sethintstring(self.stub.hint_string, cost, var_7e03d6a7);
        } else {
            self.stub.hint_string = %ZOMBIE_WEAPONCOSTONLYFILL;
            self sethintstring(self.stub.hint_string, cost);
        }
    } else {
        if (player bgb::is_enabled("zm_bgb_secret_shopper") && !is_wonder_weapon(player.currentweapon) && player.currentweapon.type !== "melee") {
            ammo_cost = player get_ammo_cost_for_weapon(weapon);
        } else if (player has_upgrade(weapon) && self.stub.hacked !== 1) {
            ammo_cost = get_upgraded_ammo_cost(weapon);
        } else {
            ammo_cost = get_ammo_cost(weapon);
        }
        if (isdefined(level.var_dc23b46e) && level.var_dc23b46e) {
            if (player bgb::is_enabled("zm_bgb_secret_shopper") && !is_wonder_weapon(player.currentweapon) && player.currentweapon.type !== "melee") {
                if (isdefined(self.stub.hacked) && self.stub.hacked) {
                    self.stub.hint_string = %ZOMBIE_WEAPONAMMOHACKED_CFILL_BGB_SECRET_SHOPPER;
                } else {
                    self.stub.hint_string = %ZOMBIE_WEAPONAMMOONLY_CFILL_BGB_SECRET_SHOPPER;
                }
                self sethintstring(self.stub.hint_string);
            } else {
                if (isdefined(self.stub.hacked) && self.stub.hacked) {
                    self.stub.hint_string = %ZOMBIE_WEAPONAMMOHACKED_CFILL;
                } else {
                    self.stub.hint_string = %ZOMBIE_WEAPONAMMOONLY_CFILL;
                }
                self sethintstring(self.stub.hint_string);
            }
        } else if (player bgb::is_enabled("zm_bgb_secret_shopper") && !is_wonder_weapon(player.currentweapon) && player.currentweapon.type !== "melee") {
            self.stub.hint_string = %ZOMBIE_WEAPONAMMOONLY_BGB_SECRET_SHOPPER;
            var_7e03d6a7 = player get_ammo_cost_for_weapon(player.currentweapon);
            self sethintstring(self.stub.hint_string, ammo_cost, var_7e03d6a7);
        } else {
            self.stub.hint_string = %ZOMBIE_WEAPONAMMOONLY;
            self sethintstring(self.stub.hint_string, ammo_cost);
        }
    }
    self.stub.cursor_hint = "HINT_WEAPON";
    self.stub.cursor_hint_weapon = weapon;
    self setcursorhint(self.stub.cursor_hint, self.stub.cursor_hint_weapon);
    return true;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x6cf46906, Offset: 0x42f0
// Size: 0xf4
function reset_wallbuy_internal(set_hint_string) {
    if (isdefined(self.first_time_triggered) && self.first_time_triggered) {
        self.first_time_triggered = 0;
        if (isdefined(self.clientfieldname)) {
            level clientfield::set(self.clientfieldname, 0);
        }
        if (set_hint_string) {
            hint_string = get_weapon_hint(self.weapon);
            cost = get_weapon_cost(self.weapon);
            if (isdefined(level.var_dc23b46e) && level.var_dc23b46e) {
                self sethintstring(hint_string);
                return;
            }
            self sethintstring(hint_string, cost);
        }
    }
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0xdd7564c9, Offset: 0x43f0
// Size: 0x3f2
function reset_wallbuys() {
    weapon_spawns = [];
    weapon_spawns = getentarray("weapon_upgrade", "targetname");
    melee_and_grenade_spawns = [];
    melee_and_grenade_spawns = getentarray("bowie_upgrade", "targetname");
    melee_and_grenade_spawns = arraycombine(melee_and_grenade_spawns, getentarray("sickle_upgrade", "targetname"), 1, 0);
    melee_and_grenade_spawns = arraycombine(melee_and_grenade_spawns, getentarray("tazer_upgrade", "targetname"), 1, 0);
    if (!(isdefined(level.headshots_only) && level.headshots_only)) {
        melee_and_grenade_spawns = arraycombine(melee_and_grenade_spawns, getentarray("claymore_purchase", "targetname"), 1, 0);
    }
    for (i = 0; i < weapon_spawns.size; i++) {
        weapon_spawns[i].weapon = getweapon(weapon_spawns[i].zombie_weapon_upgrade);
        weapon_spawns[i] reset_wallbuy_internal(1);
    }
    for (i = 0; i < melee_and_grenade_spawns.size; i++) {
        melee_and_grenade_spawns[i].weapon = getweapon(melee_and_grenade_spawns[i].zombie_weapon_upgrade);
        melee_and_grenade_spawns[i] reset_wallbuy_internal(0);
    }
    if (isdefined(level._unitriggers)) {
        candidates = [];
        for (i = 0; i < level._unitriggers.trigger_stubs.size; i++) {
            stub = level._unitriggers.trigger_stubs[i];
            tn = stub.targetname;
            if (tn == "weapon_upgrade" || tn == "bowie_upgrade" || tn == "sickle_upgrade" || tn == "tazer_upgrade" || tn == "claymore_purchase") {
                stub.first_time_triggered = 0;
                if (isdefined(stub.clientfieldname)) {
                    level clientfield::set(stub.clientfieldname, 0);
                }
                if (tn == "weapon_upgrade") {
                    stub.hint_string = get_weapon_hint(stub.weapon);
                    stub.cost = get_weapon_cost(stub.weapon);
                    if (!(isdefined(level.var_dc23b46e) && level.var_dc23b46e)) {
                        stub.hint_parm1 = stub.cost;
                    }
                }
            }
        }
    }
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x91fb393d, Offset: 0x47f0
// Size: 0x256
function init_weapon_upgrade() {
    init_spawnable_weapon_upgrade();
    weapon_spawns = [];
    weapon_spawns = getentarray("weapon_upgrade", "targetname");
    for (i = 0; i < weapon_spawns.size; i++) {
        weapon_spawns[i].weapon = getweapon(weapon_spawns[i].zombie_weapon_upgrade);
        hint_string = get_weapon_hint(weapon_spawns[i].weapon);
        cost = get_weapon_cost(weapon_spawns[i].weapon);
        if (isdefined(level.var_dc23b46e) && level.var_dc23b46e) {
            weapon_spawns[i] sethintstring(hint_string);
        } else {
            weapon_spawns[i] sethintstring(hint_string, cost);
        }
        weapon_spawns[i] setcursorhint("HINT_NOICON");
        weapon_spawns[i] usetriggerrequirelookat();
        weapon_spawns[i] thread weapon_spawn_think();
        model = getent(weapon_spawns[i].target, "targetname");
        if (isdefined(model)) {
            model useweaponhidetags(weapon_spawns[i].weapon);
            model hide();
        }
    }
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xc5d047a7, Offset: 0x4a50
// Size: 0x5a
function get_weapon_hint(weapon) {
    assert(isdefined(level.zombie_weapons[weapon]), weapon.name + "<dev string:xc1>");
    return level.zombie_weapons[weapon].hint;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xdff295ff, Offset: 0x4ab8
// Size: 0x5a
function get_weapon_cost(weapon) {
    assert(isdefined(level.zombie_weapons[weapon]), weapon.name + "<dev string:xc1>");
    return level.zombie_weapons[weapon].cost;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xebbf3f4f, Offset: 0x4b20
// Size: 0x5a
function get_ammo_cost(weapon) {
    assert(isdefined(level.zombie_weapons[weapon]), weapon.name + "<dev string:xc1>");
    return level.zombie_weapons[weapon].ammo_cost;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x7049ba4, Offset: 0x4b88
// Size: 0x7c
function get_upgraded_ammo_cost(weapon) {
    assert(isdefined(level.zombie_weapons[weapon]), weapon.name + "<dev string:xc1>");
    if (isdefined(level.zombie_weapons[weapon].upgraded_ammo_cost)) {
        return level.zombie_weapons[weapon].upgraded_ammo_cost;
    }
    return 4500;
}

// Namespace zm_weapons
// Params 3, eflags: 0x0
// Checksum 0x120a26bc, Offset: 0x4c10
// Size: 0x152
function get_ammo_cost_for_weapon(w_current, n_base_non_wallbuy_cost, n_upgraded_non_wallbuy_cost) {
    if (!isdefined(n_base_non_wallbuy_cost)) {
        n_base_non_wallbuy_cost = 750;
    }
    if (!isdefined(n_upgraded_non_wallbuy_cost)) {
        n_upgraded_non_wallbuy_cost = 5000;
    }
    w_root = w_current.rootweapon;
    if (is_weapon_upgraded(w_root)) {
        w_root = get_base_weapon(w_root);
    }
    if (self has_upgrade(w_root)) {
        if (is_wallbuy(w_root)) {
            n_ammo_cost = 4000;
        } else {
            n_ammo_cost = n_upgraded_non_wallbuy_cost;
        }
    } else if (is_wallbuy(w_root)) {
        n_ammo_cost = get_ammo_cost(w_root);
        n_ammo_cost = zm_utility::halve_score(n_ammo_cost);
    } else {
        n_ammo_cost = n_base_non_wallbuy_cost;
    }
    return n_ammo_cost;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xb857a559, Offset: 0x4d70
// Size: 0x5a
function get_is_in_box(weapon) {
    assert(isdefined(level.zombie_weapons[weapon]), weapon.name + "<dev string:xc1>");
    return level.zombie_weapons[weapon].is_in_box;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xe92b5690, Offset: 0x4dd8
// Size: 0x5a
function function_4f54ceec(weapon) {
    assert(isdefined(level.zombie_weapons[weapon]), weapon.name + "<dev string:xc1>");
    return level.zombie_weapons[weapon].var_e44dc8f1;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xf61a9121, Offset: 0x4e40
// Size: 0x52
function weapon_supports_default_attachment(weapon) {
    weapon = get_base_weapon(weapon);
    attachment = level.zombie_weapons[weapon].default_attachment;
    return isdefined(attachment);
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xb9967d75, Offset: 0x4ea0
// Size: 0x68
function default_attachment(weapon) {
    weapon = get_base_weapon(weapon);
    attachment = level.zombie_weapons[weapon].default_attachment;
    if (isdefined(attachment)) {
        return attachment;
    }
    return "none";
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x60d456b6, Offset: 0x4f10
// Size: 0x62
function weapon_supports_attachments(weapon) {
    weapon = get_base_weapon(weapon);
    attachments = level.zombie_weapons[weapon].addon_attachments;
    return isdefined(attachments) && attachments.size > 1;
}

// Namespace zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x9c48358d, Offset: 0x4f80
// Size: 0x166
function random_attachment(weapon, exclude) {
    lo = 0;
    if (isdefined(level.zombie_weapons[weapon].addon_attachments) && level.zombie_weapons[weapon].addon_attachments.size > 0) {
        attachments = level.zombie_weapons[weapon].addon_attachments;
    } else {
        attachments = weapon.supportedattachments;
        lo = 1;
    }
    minatt = lo;
    if (isdefined(exclude) && exclude != "none") {
        minatt = lo + 1;
    }
    if (attachments.size > minatt) {
        while (true) {
            idx = randomint(attachments.size - lo) + lo;
            if (!isdefined(exclude) || attachments[idx] != exclude) {
                return attachments[idx];
            }
        }
    }
    return "none";
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xcdc17296, Offset: 0x50f0
// Size: 0x158
function get_attachment_index(weapon) {
    attachments = weapon.attachments;
    if (!attachments.size) {
        return -1;
    }
    weapon = get_nonalternate_weapon(weapon);
    base = weapon.rootweapon;
    if (attachments[0] == level.zombie_weapons[base].default_attachment) {
        return 0;
    }
    if (isdefined(level.zombie_weapons[base].addon_attachments)) {
        for (i = 0; i < level.zombie_weapons[base].addon_attachments.size; i++) {
            if (level.zombie_weapons[base].addon_attachments[i] == attachments[0]) {
                return (i + 1);
            }
        }
    }
    println("<dev string:xfd>" + weapon.name);
    return -1;
}

// Namespace zm_weapons
// Params 2, eflags: 0x0
// Checksum 0xdcb3587e, Offset: 0x5250
// Size: 0xfc
function weapon_supports_this_attachment(weapon, att) {
    weapon = get_nonalternate_weapon(weapon);
    base = weapon.rootweapon;
    if (att == level.zombie_weapons[base].default_attachment) {
        return true;
    }
    if (isdefined(level.zombie_weapons[base].addon_attachments)) {
        for (i = 0; i < level.zombie_weapons[base].addon_attachments.size; i++) {
            if (level.zombie_weapons[base].addon_attachments[i] == att) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xb299aed7, Offset: 0x5358
// Size: 0x62
function get_base_weapon(upgradedweapon) {
    upgradedweapon = get_nonalternate_weapon(upgradedweapon);
    upgradedweapon = upgradedweapon.rootweapon;
    if (isdefined(level.zombie_weapons_upgraded[upgradedweapon])) {
        return level.zombie_weapons_upgraded[upgradedweapon];
    }
    return upgradedweapon;
}

// Namespace zm_weapons
// Params 2, eflags: 0x0
// Checksum 0xd2ade535, Offset: 0x53c8
// Size: 0x1ec
function get_upgrade_weapon(weapon, add_attachment) {
    weapon = get_nonalternate_weapon(weapon);
    rootweapon = weapon.rootweapon;
    newweapon = rootweapon;
    baseweapon = get_base_weapon(weapon);
    if (!is_weapon_upgraded(rootweapon)) {
        newweapon = level.zombie_weapons[rootweapon].upgrade;
    }
    if (isdefined(add_attachment) && add_attachment && zm_pap_util::function_53616d7e()) {
        var_39e3939 = "none";
        if (weapon.attachments.size) {
            var_39e3939 = weapon.attachments[0];
        }
        att = random_attachment(baseweapon, var_39e3939);
        newweapon = getweapon(newweapon.name, att);
    } else if (isdefined(level.zombie_weapons[rootweapon]) && isdefined(level.zombie_weapons[rootweapon].default_attachment)) {
        att = level.zombie_weapons[rootweapon].default_attachment;
        newweapon = getweapon(newweapon.name, att);
    }
    return newweapon;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x98305b82, Offset: 0x55c0
// Size: 0xee
function can_upgrade_weapon(weapon) {
    if (weapon == level.weaponnone || weapon == level.weaponzmfists || !is_weapon_included(weapon)) {
        return false;
    }
    weapon = get_nonalternate_weapon(weapon);
    rootweapon = weapon.rootweapon;
    if (!is_weapon_upgraded(rootweapon)) {
        return isdefined(level.zombie_weapons[rootweapon].upgrade);
    }
    if (zm_pap_util::function_53616d7e() && weapon_supports_attachments(rootweapon)) {
        return true;
    }
    return false;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xc916a679, Offset: 0x56b8
// Size: 0xae
function weapon_supports_aat(weapon) {
    if (weapon == level.weaponnone || weapon == level.weaponzmfists) {
        return false;
    }
    weapontopack = get_nonalternate_weapon(weapon);
    rootweapon = weapontopack.rootweapon;
    if (!is_weapon_upgraded(rootweapon)) {
        return false;
    }
    if (!aat::is_exempt_weapon(weapontopack)) {
        return true;
    }
    return false;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x242dad3f, Offset: 0x5770
// Size: 0x7e
function is_weapon_upgraded(weapon) {
    if (weapon == level.weaponnone || weapon == level.weaponzmfists) {
        return false;
    }
    weapon = get_nonalternate_weapon(weapon);
    rootweapon = weapon.rootweapon;
    if (isdefined(level.zombie_weapons_upgraded[rootweapon])) {
        return true;
    }
    return false;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x9dd5b888, Offset: 0x57f8
// Size: 0x1d6
function get_weapon_with_attachments(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    if (self hasweapon(weapon.rootweapon, 1)) {
        upgraded = is_weapon_upgraded(weapon);
        if (is_weapon_included(weapon) || upgraded) {
            if (upgraded) {
                base_weapon = get_base_weapon(weapon);
                var_e44dc8f1 = function_4f54ceec(base_weapon.rootweapon);
            } else {
                var_e44dc8f1 = function_4f54ceec(weapon.rootweapon);
            }
        }
        if (isdefined(var_e44dc8f1) && var_e44dc8f1.size) {
            if (upgraded) {
                var_acad7baa = [];
                var_acad7baa[var_acad7baa.size] = "extclip";
                var_acad7baa[var_acad7baa.size] = "fmj";
                var_e44dc8f1 = arraycombine(var_e44dc8f1, var_acad7baa, 0, 0);
            }
            return getweapon(weapon.rootweapon.name, var_e44dc8f1);
        } else {
            return self getbuildkitweapon(weapon.rootweapon, upgraded);
        }
    }
    return undefined;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x39f29a94, Offset: 0x59d8
// Size: 0x116
function has_weapon_or_attachments(weapon) {
    if (self hasweapon(weapon, 1)) {
        return true;
    }
    if (zm_pap_util::function_53616d7e()) {
        rootweapon = weapon.rootweapon;
        weapons = self getweaponslist(1);
        foreach (w in weapons) {
            if (rootweapon == w.rootweapon) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xe88737dd, Offset: 0x5af8
// Size: 0xf4
function has_upgrade(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    rootweapon = weapon.rootweapon;
    has_upgrade = 0;
    if (isdefined(level.zombie_weapons[rootweapon]) && isdefined(level.zombie_weapons[rootweapon].upgrade)) {
        has_upgrade = self has_weapon_or_attachments(level.zombie_weapons[rootweapon].upgrade);
    }
    if (!has_upgrade && rootweapon.isballisticknife) {
        has_weapon = self zm_melee_weapon::function_9f93cad8();
    }
    return has_upgrade;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x9c58dbf8, Offset: 0x5bf8
// Size: 0x174
function has_weapon_or_upgrade(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    rootweapon = weapon.rootweapon;
    upgradedweaponname = rootweapon;
    if (isdefined(level.zombie_weapons[rootweapon]) && isdefined(level.zombie_weapons[rootweapon].upgrade)) {
        upgradedweaponname = level.zombie_weapons[rootweapon].upgrade;
    }
    has_weapon = 0;
    if (isdefined(level.zombie_weapons[rootweapon])) {
        has_weapon = self has_weapon_or_attachments(rootweapon) || self has_upgrade(rootweapon);
    }
    if (!has_weapon && level.weaponballisticknife == rootweapon) {
        has_weapon = self zm_melee_weapon::function_52b66e86();
    }
    if (!has_weapon && zm_equipment::is_equipment(rootweapon)) {
        has_weapon = self zm_equipment::is_active(rootweapon);
    }
    return has_weapon;
}

// Namespace zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x740c9d6b, Offset: 0x5d78
// Size: 0x30
function add_shared_ammo_weapon(weapon, base_weapon) {
    level.zombie_weapons[weapon].shared_ammo_weapon = base_weapon;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xbb7d5, Offset: 0x5db0
// Size: 0x17e
function get_shared_ammo_weapon(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    rootweapon = weapon.rootweapon;
    weapons = self getweaponslist(1);
    foreach (w in weapons) {
        w = w.rootweapon;
        if (!isdefined(level.zombie_weapons[w]) && isdefined(level.zombie_weapons_upgraded[w])) {
            w = level.zombie_weapons_upgraded[w];
        }
        if (isdefined(level.zombie_weapons[w]) && isdefined(level.zombie_weapons[w].shared_ammo_weapon) && level.zombie_weapons[w].shared_ammo_weapon == rootweapon) {
            return w;
        }
    }
    return undefined;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xaf4640d2, Offset: 0x5f38
// Size: 0x114
function get_player_weapon_with_same_base(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    rootweapon = weapon.rootweapon;
    retweapon = self get_weapon_with_attachments(rootweapon);
    if (!isdefined(retweapon)) {
        if (isdefined(level.zombie_weapons[rootweapon])) {
            if (isdefined(level.zombie_weapons[rootweapon].upgrade)) {
                retweapon = self get_weapon_with_attachments(level.zombie_weapons[rootweapon].upgrade);
            }
        } else if (isdefined(level.zombie_weapons_upgraded[rootweapon])) {
            retweapon = self get_weapon_with_attachments(level.zombie_weapons_upgraded[rootweapon]);
        }
    }
    return retweapon;
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x2fa0eef7, Offset: 0x6058
// Size: 0x78
function get_weapon_hint_ammo() {
    if (!(isdefined(level.var_9b83d7) && level.var_9b83d7)) {
        if (isdefined(level.var_dc23b46e) && level.var_dc23b46e) {
            return %ZOMBIE_WEAPONCOSTONLY_CFILL;
        } else {
            return %ZOMBIE_WEAPONCOSTONLYFILL;
        }
        return;
    }
    if (isdefined(level.var_88fc178c) && !level.var_88fc178c) {
        return %ZOMBIE_WEAPONCOSTAMMO;
    }
    return %ZOMBIE_WEAPONCOSTAMMO_UPGRADE;
}

// Namespace zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x70e6f096, Offset: 0x60d8
// Size: 0xc4
function weapon_set_first_time_hint(cost, ammo_cost) {
    if (!(isdefined(level.var_9b83d7) && level.var_9b83d7)) {
        if (isdefined(level.var_dc23b46e) && level.var_dc23b46e) {
            self sethintstring(get_weapon_hint_ammo());
        } else {
            self sethintstring(get_weapon_hint_ammo(), cost, ammo_cost);
        }
        return;
    }
    self sethintstring(get_weapon_hint_ammo(), cost, ammo_cost);
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x64212dda, Offset: 0x61a8
// Size: 0x38
function placeable_mine_can_buy_weapon_extra_check_func(w_weapon) {
    if (isdefined(w_weapon) && w_weapon == self zm_utility::get_player_placeable_mine()) {
        return false;
    }
    return true;
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0xf9e81e95, Offset: 0x61e8
// Size: 0xe44
function weapon_spawn_think() {
    cost = get_weapon_cost(self.weapon);
    ammo_cost = get_ammo_cost(self.weapon);
    is_grenade = self.weapon.isgrenadeweapon;
    shared_ammo_weapon = undefined;
    if (isdefined(self.parent_player) && !is_grenade) {
        self.parent_player notify(#"zm_bgb_secret_shopper", self);
    }
    second_endon = undefined;
    if (isdefined(self.stub)) {
        second_endon = "kill_trigger";
        self.first_time_triggered = self.stub.first_time_triggered;
    }
    onlyplayer = undefined;
    can_buy_weapon_extra_check_func = undefined;
    if (isdefined(self.stub.trigger_per_player) && isdefined(self.stub) && self.stub.trigger_per_player) {
        onlyplayer = self.parent_player;
        if (zm_utility::is_placeable_mine(self.weapon)) {
            can_buy_weapon_extra_check_func = &placeable_mine_can_buy_weapon_extra_check_func;
        }
    }
    self thread zm_magicbox::decide_hide_show_hint("stop_hint_logic", second_endon, onlyplayer, can_buy_weapon_extra_check_func);
    if (is_grenade || zm_utility::is_melee_weapon(self.weapon)) {
        self.first_time_triggered = 0;
        hint = get_weapon_hint(self.weapon);
        if (isdefined(level.var_dc23b46e) && level.var_dc23b46e) {
            self sethintstring(hint);
        } else {
            self sethintstring(hint, cost);
        }
        cursor_hint = "HINT_WEAPON";
        cursor_hint_weapon = self.weapon;
        self setcursorhint(cursor_hint, cursor_hint_weapon);
    } else if (!isdefined(self.first_time_triggered)) {
        self.first_time_triggered = 0;
        if (isdefined(self.stub)) {
            self.stub.first_time_triggered = 0;
        }
    }
    for (;;) {
        self waittill(#"trigger", player);
        if (!zm_utility::is_player_valid(player)) {
            player thread zm_utility::ignore_triggers(0.5);
            continue;
        }
        if (!player zm_magicbox::can_buy_weapon()) {
            wait 0.1;
            continue;
        }
        if (isdefined(self.stub.require_look_from) && isdefined(self.stub) && self.stub.require_look_from) {
            toplayer = player util::get_eye() - self.origin;
            forward = -1 * anglestoright(self.angles);
            dot = vectordot(toplayer, forward);
            if (dot < 0) {
                continue;
            }
        }
        if (player zm_utility::has_powerup_weapon()) {
            wait 0.1;
            continue;
        }
        player_has_weapon = player has_weapon_or_upgrade(self.weapon);
        if (isdefined(level.weapons_using_ammo_sharing) && !player_has_weapon && level.weapons_using_ammo_sharing) {
            shared_ammo_weapon = player get_shared_ammo_weapon(self.weapon);
            if (isdefined(shared_ammo_weapon)) {
                player_has_weapon = 1;
            }
        }
        if (isdefined(level.var_f4735dd3) && level.var_f4735dd3) {
            player_has_weapon = namespace_25f8c2ad::function_e8007b34(player_has_weapon, player, self.weapon);
        }
        cost = get_weapon_cost(self.weapon);
        if (player namespace_25f8c2ad::function_dc08b4af()) {
            cost = int(cost / 2);
        }
        if (isdefined(player.check_override_wallbuy_purchase)) {
            if (player [[ player.check_override_wallbuy_purchase ]](self.weapon, self)) {
                continue;
            }
        }
        if (!player_has_weapon) {
            if (player zm_score::can_player_purchase(cost)) {
                if (self.first_time_triggered == 0) {
                    self show_all_weapon_buys(player, cost, ammo_cost, is_grenade);
                }
                player zm_score::minus_to_player_score(cost);
                level notify(#"weapon_bought", player, self.weapon);
                player zm_stats::increment_challenge_stat("SURVIVALIST_BUY_WALLBUY");
                if (self.weapon.isriotshield) {
                    player zm_equipment::give(self.weapon);
                    if (isdefined(player.player_shield_reset_health)) {
                        player [[ player.player_shield_reset_health ]]();
                    }
                } else {
                    if (zm_utility::is_lethal_grenade(self.weapon)) {
                        player weapon_take(player zm_utility::get_player_lethal_grenade());
                        player zm_utility::set_player_lethal_grenade(self.weapon);
                    }
                    weapon = self.weapon;
                    if (isdefined(level.var_f4735dd3) && level.var_f4735dd3) {
                        weapon = namespace_25f8c2ad::function_11390813(player, weapon);
                    }
                    if (should_upgrade_weapon(player)) {
                        if (player can_upgrade_weapon(weapon)) {
                            weapon = get_upgrade_weapon(weapon);
                            player notify(#"zm_bgb_wall_power_used");
                        }
                    }
                    weapon = player weapon_give(weapon);
                    if (isdefined(weapon)) {
                        player thread aat::remove(weapon);
                    }
                }
                if (isdefined(weapon)) {
                    player zm_stats::increment_client_stat("wallbuy_weapons_purchased");
                    player zm_stats::increment_player_stat("wallbuy_weapons_purchased");
                    bb::logpurchaseevent(player, self, cost, weapon.name, player has_upgrade(weapon), "_weapon", "_purchase");
                    weaponindex = undefined;
                    if (isdefined(weaponindex)) {
                        weaponindex = matchrecordgetweaponindex(weapon);
                    }
                    if (isdefined(weaponindex)) {
                        player recordmapevent(6, gettime(), player.origin, level.round_number, weaponindex, cost);
                    }
                }
            } else {
                zm_utility::play_sound_on_ent("no_purchase");
                player zm_audio::create_and_play_dialog("general", "outofmoney");
            }
        } else {
            weapon = self.weapon;
            if (isdefined(shared_ammo_weapon)) {
                weapon = shared_ammo_weapon;
            }
            if (isdefined(level.var_f4735dd3) && level.var_f4735dd3) {
                weapon = namespace_25f8c2ad::function_8c231229(player, weapon);
            }
            if (isdefined(self.stub.hacked) && self.stub.hacked) {
                if (!player has_upgrade(weapon)) {
                    ammo_cost = 4500;
                } else {
                    ammo_cost = get_ammo_cost(weapon);
                }
            } else if (player has_upgrade(weapon)) {
                ammo_cost = 4500;
            } else {
                ammo_cost = get_ammo_cost(weapon);
            }
            if (isdefined(player.var_698f7e["nube"]) && player.var_698f7e["nube"]) {
                ammo_cost = namespace_25f8c2ad::function_3c5b1e58(player, self.weapon, ammo_cost);
            }
            if (player namespace_25f8c2ad::function_dc08b4af()) {
                ammo_cost = int(ammo_cost / 2);
            }
            if (player bgb::is_enabled("zm_bgb_secret_shopper") && !is_wonder_weapon(weapon)) {
                ammo_cost = player get_ammo_cost_for_weapon(weapon);
            }
            if (weapon.isriotshield) {
                zm_utility::play_sound_on_ent("no_purchase");
            } else if (player zm_score::can_player_purchase(ammo_cost)) {
                if (self.first_time_triggered == 0) {
                    self show_all_weapon_buys(player, cost, ammo_cost, is_grenade);
                }
                if (player has_upgrade(weapon)) {
                    player zm_stats::increment_client_stat("upgraded_ammo_purchased");
                    player zm_stats::increment_player_stat("upgraded_ammo_purchased");
                } else {
                    player zm_stats::increment_client_stat("ammo_purchased");
                    player zm_stats::increment_player_stat("ammo_purchased");
                }
                if (player has_upgrade(weapon)) {
                    ammo_given = player ammo_give(level.zombie_weapons[weapon].upgrade);
                } else {
                    ammo_given = player ammo_give(weapon);
                }
                if (ammo_given) {
                    player zm_score::minus_to_player_score(ammo_cost);
                }
                bb::logpurchaseevent(player, self, ammo_cost, weapon.name, player has_upgrade(weapon), "_ammo", "_purchase");
                weaponindex = undefined;
                if (isdefined(weapon)) {
                    weaponindex = matchrecordgetweaponindex(weapon);
                }
                if (isdefined(weaponindex)) {
                    player recordmapevent(7, gettime(), player.origin, level.round_number, weaponindex, cost);
                }
            } else {
                zm_utility::play_sound_on_ent("no_purchase");
                if (isdefined(level.custom_generic_deny_vo_func)) {
                    player [[ level.custom_generic_deny_vo_func ]]();
                } else {
                    player zm_audio::create_and_play_dialog("general", "outofmoney");
                }
            }
        }
        if (isdefined(self.stub) && isdefined(self.stub.prompt_and_visibility_func)) {
            self [[ self.stub.prompt_and_visibility_func ]](player);
        }
    }
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x24ca17d4, Offset: 0x7038
// Size: 0x4e
function should_upgrade_weapon(player) {
    if (isdefined(level.var_5d888f14)) {
        return [[ level.var_5d888f14 ]]();
    }
    if (player bgb::is_enabled("zm_bgb_wall_power")) {
        return 1;
    }
    return 0;
}

// Namespace zm_weapons
// Params 4, eflags: 0x0
// Checksum 0xf00fe3c4, Offset: 0x7090
// Size: 0x3ae
function show_all_weapon_buys(player, cost, ammo_cost, is_grenade) {
    model = getent(self.target, "targetname");
    is_melee = zm_utility::is_melee_weapon(self.weapon);
    if (isdefined(model)) {
        model thread weapon_show(player);
    } else if (isdefined(self.clientfieldname)) {
        level clientfield::set(self.clientfieldname, 1);
    }
    self.first_time_triggered = 1;
    if (isdefined(self.stub)) {
        self.stub.first_time_triggered = 1;
    }
    if (!is_grenade && !is_melee) {
        self weapon_set_first_time_hint(cost, ammo_cost);
    }
    if (!(isdefined(level.dont_link_common_wallbuys) && level.dont_link_common_wallbuys) && isdefined(level._spawned_wallbuys)) {
        for (i = 0; i < level._spawned_wallbuys.size; i++) {
            wallbuy = level._spawned_wallbuys[i];
            if (isdefined(self.stub) && isdefined(wallbuy.trigger_stub) && self.stub.clientfieldname == wallbuy.trigger_stub.clientfieldname) {
                continue;
            }
            if (self.weapon == wallbuy.weapon) {
                if (isdefined(wallbuy.trigger_stub) && isdefined(wallbuy.trigger_stub.clientfieldname)) {
                    level clientfield::set(wallbuy.trigger_stub.clientfieldname, 1);
                } else if (isdefined(wallbuy.target)) {
                    model = getent(wallbuy.target, "targetname");
                    if (isdefined(model)) {
                        model thread weapon_show(player);
                    }
                }
                if (isdefined(wallbuy.trigger_stub)) {
                    wallbuy.trigger_stub.first_time_triggered = 1;
                    if (isdefined(wallbuy.trigger_stub.trigger)) {
                        wallbuy.trigger_stub.trigger.first_time_triggered = 1;
                        if (!is_grenade && !is_melee) {
                            wallbuy.trigger_stub.trigger weapon_set_first_time_hint(cost, ammo_cost);
                        }
                    }
                    continue;
                }
                if (!is_grenade && !is_melee) {
                    wallbuy weapon_set_first_time_hint(cost, ammo_cost);
                }
            }
        }
    }
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xaaeb59d1, Offset: 0x7448
// Size: 0x1b4
function weapon_show(player) {
    player_angles = vectortoangles(player.origin - self.origin);
    player_yaw = player_angles[1];
    weapon_yaw = self.angles[1];
    if (isdefined(self.script_int)) {
        weapon_yaw -= self.script_int;
    }
    yaw_diff = angleclamp180(player_yaw - weapon_yaw);
    if (yaw_diff > 0) {
        yaw = weapon_yaw - 90;
    } else {
        yaw = weapon_yaw + 90;
    }
    self.og_origin = self.origin;
    self.origin += anglestoforward((0, yaw, 0)) * 8;
    wait 0.05;
    self show();
    zm_utility::play_sound_at_pos("weapon_show", self.origin, self);
    time = 1;
    if (!isdefined(self._linked_ent)) {
        self moveto(self.og_origin, time);
    }
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xfbd26071, Offset: 0x7608
// Size: 0xac
function function_11a37a(var_d074477d) {
    if (isdefined(level.pack_a_punch_camo_index_number_variants)) {
        if (isdefined(var_d074477d)) {
            var_39a21497 = var_d074477d + 1;
            if (var_39a21497 >= level.pack_a_punch_camo_index + level.pack_a_punch_camo_index_number_variants) {
                var_39a21497 = level.pack_a_punch_camo_index;
            }
            return var_39a21497;
        } else {
            var_39a21497 = randomintrange(0, level.pack_a_punch_camo_index_number_variants);
            return (level.pack_a_punch_camo_index + var_39a21497);
        }
        return;
    }
    return level.pack_a_punch_camo_index;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xc1dc143d, Offset: 0x76c0
// Size: 0x2e0
function get_pack_a_punch_weapon_options(weapon) {
    if (!isdefined(self.pack_a_punch_weapon_options)) {
        self.pack_a_punch_weapon_options = [];
    }
    if (!is_weapon_upgraded(weapon)) {
        return self calcweaponoptions(0, 0, 0, 0, 0);
    }
    if (isdefined(self.pack_a_punch_weapon_options[weapon])) {
        return self.pack_a_punch_weapon_options[weapon];
    }
    var_ee96c320 = 1;
    camo_index = function_11a37a(undefined);
    var_674a54c = randomintrange(0, 6);
    reticle_index = randomintrange(0, 16);
    var_ede1c4ca = randomintrange(0, 6);
    plain_reticle_index = 16;
    use_plain = randomint(10) < 1;
    if ("saritch_upgraded" == weapon.rootweapon.name) {
        reticle_index = var_ee96c320;
    } else if (use_plain) {
        reticle_index = plain_reticle_index;
    }
    /#
        if (getdvarint("<dev string:x131>") >= 0) {
            reticle_index = getdvarint("<dev string:x131>");
        }
    #/
    var_87239a14 = 8;
    var_d255cb7b = 3;
    if (reticle_index == var_87239a14) {
        var_ede1c4ca = var_d255cb7b;
    }
    var_d9a23831 = 2;
    var_41c5b601 = 6;
    if (reticle_index == var_d9a23831) {
        var_ede1c4ca = var_41c5b601;
    }
    var_8c90e025 = 7;
    var_e8da3926 = 1;
    if (reticle_index == var_8c90e025) {
        var_ede1c4ca = var_e8da3926;
    }
    self.pack_a_punch_weapon_options[weapon] = self calcweaponoptions(camo_index, var_674a54c, reticle_index, var_ede1c4ca);
    return self.pack_a_punch_weapon_options[weapon];
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x72b78483, Offset: 0x79a8
// Size: 0x280
function give_build_kit_weapon(weapon) {
    upgraded = 0;
    camo = undefined;
    base_weapon = weapon;
    if (is_weapon_upgraded(weapon)) {
        if (isdefined(weapon.var_a61c0755)) {
            camo = weapon.var_a61c0755;
        } else {
            camo = function_11a37a(undefined);
        }
        upgraded = 1;
        base_weapon = get_base_weapon(weapon);
    }
    if (is_weapon_included(base_weapon)) {
        var_e44dc8f1 = function_4f54ceec(base_weapon.rootweapon);
    }
    if (isdefined(var_e44dc8f1) && var_e44dc8f1.size) {
        if (upgraded) {
            var_acad7baa = [];
            var_acad7baa[var_acad7baa.size] = "extclip";
            var_acad7baa[var_acad7baa.size] = "fmj";
            var_e44dc8f1 = arraycombine(var_e44dc8f1, var_acad7baa, 0, 0);
        }
        weapon = getweapon(weapon.rootweapon.name, var_e44dc8f1);
        if (!isdefined(camo)) {
            camo = 0;
        }
        weapon_options = self calcweaponoptions(camo, 0, 0);
        acvi = 0;
    } else {
        weapon = self getbuildkitweapon(weapon, upgraded);
        weapon_options = self getbuildkitweaponoptions(weapon, camo);
        acvi = self getbuildkitattachmentcosmeticvariantindexes(weapon, upgraded);
    }
    self giveweapon(weapon, weapon_options, acvi);
    return weapon;
}

// Namespace zm_weapons
// Params 5, eflags: 0x0
// Checksum 0xef0866d1, Offset: 0x7c30
// Size: 0xa48
function weapon_give(weapon, var_f9f5d998, magic_box, nosound, b_switch_weapon) {
    if (!isdefined(var_f9f5d998)) {
        var_f9f5d998 = 0;
    }
    if (!isdefined(magic_box)) {
        magic_box = 0;
    }
    if (!isdefined(nosound)) {
        nosound = 0;
    }
    if (!isdefined(b_switch_weapon)) {
        b_switch_weapon = 1;
    }
    primaryweapons = self getweaponslistprimaries();
    initial_current_weapon = self getcurrentweapon();
    current_weapon = self switch_from_alt_weapon(initial_current_weapon);
    assert(self player_can_use_content(weapon));
    if (!isdefined(var_f9f5d998)) {
        var_f9f5d998 = 0;
    }
    weapon_limit = zm_utility::get_player_weapon_limit(self);
    if (zm_equipment::is_equipment(weapon)) {
        self zm_equipment::give(weapon);
    }
    if (weapon.isriotshield) {
        if (isdefined(self.player_shield_reset_health)) {
            self [[ self.player_shield_reset_health ]]();
        }
    }
    if (self hasweapon(weapon)) {
        if (weapon.isballisticknife) {
            self notify(#"zmb_lost_knife");
        }
        self givestartammo(weapon);
        if (!zm_utility::is_offhand_weapon(weapon)) {
            self switchtoweapon(weapon);
        }
        self notify(#"weapon_give", weapon);
        return weapon;
    }
    if (weapon.name == "ray_gun" || weapon.name == "raygun_mark2") {
        if (self has_weapon_or_upgrade(getweapon("raygun_mark2")) && weapon.name == "ray_gun") {
            for (i = 0; i < primaryweapons.size; i++) {
                if (issubstr(primaryweapons[i].name, "raygun_mark2")) {
                    self givestartammo(primaryweapons[i]);
                    break;
                }
            }
            self notify(#"weapon_give", weapon);
            return weapon;
        } else if (self has_weapon_or_upgrade(getweapon("ray_gun")) && weapon.name == "raygun_mark2") {
            for (i = 0; i < primaryweapons.size; i++) {
                if (issubstr(primaryweapons[i].name, "ray_gun")) {
                    self weapon_take(primaryweapons[i]);
                    break;
                }
            }
            weapon = self give_build_kit_weapon(weapon);
            self notify(#"weapon_give", weapon);
            self givestartammo(weapon);
            self switchtoweapon(weapon);
            return weapon;
        }
    }
    if (zm_utility::is_melee_weapon(weapon)) {
        current_weapon = zm_melee_weapon::change_melee_weapon(weapon, current_weapon);
    } else if (zm_utility::is_hero_weapon(weapon)) {
        var_e2db2353 = self zm_utility::get_player_hero_weapon();
        if (var_e2db2353 != level.weaponnone) {
            self weapon_take(var_e2db2353);
        }
        self zm_utility::set_player_hero_weapon(weapon);
    } else if (zm_utility::is_lethal_grenade(weapon)) {
        var_b321cee9 = self zm_utility::get_player_lethal_grenade();
        if (var_b321cee9 != level.weaponnone) {
            self weapon_take(var_b321cee9);
        }
        self zm_utility::set_player_lethal_grenade(weapon);
    } else if (zm_utility::is_tactical_grenade(weapon)) {
        var_a7578af4 = self zm_utility::get_player_tactical_grenade();
        if (var_a7578af4 != level.weaponnone) {
            self weapon_take(var_a7578af4);
        }
        self zm_utility::set_player_tactical_grenade(weapon);
    } else if (zm_utility::is_placeable_mine(weapon)) {
        var_1a81b3aa = self zm_utility::get_player_placeable_mine();
        if (var_1a81b3aa != level.weaponnone) {
            self weapon_take(var_1a81b3aa);
        }
        self zm_utility::set_player_placeable_mine(weapon);
    }
    if (!zm_utility::is_offhand_weapon(weapon)) {
        self take_fallback_weapon();
    }
    if (primaryweapons.size >= weapon_limit) {
        if (zm_utility::is_placeable_mine(current_weapon) || zm_equipment::is_equipment(current_weapon)) {
            current_weapon = undefined;
        }
        if (isdefined(current_weapon)) {
            if (!zm_utility::is_offhand_weapon(weapon)) {
                if (current_weapon.isballisticknife) {
                    self notify(#"zmb_lost_knife");
                }
                self weapon_take(current_weapon);
                if (isdefined(initial_current_weapon) && issubstr(initial_current_weapon.name, "dualoptic")) {
                    self weapon_take(initial_current_weapon);
                }
            }
        }
    }
    if (isdefined(level.zombiemode_offhand_weapon_give_override)) {
        if (self [[ level.zombiemode_offhand_weapon_give_override ]](weapon)) {
            self notify(#"weapon_give", weapon);
            self zm_utility::play_sound_on_ent("purchase");
            return weapon;
        }
    }
    if (weapon.isballisticknife) {
        weapon = self zm_melee_weapon::function_b81c1f0(weapon, is_weapon_upgraded(weapon));
    } else if (zm_utility::is_placeable_mine(weapon)) {
        self thread zm_placeable_mine::setup_for_player(weapon);
        self play_weapon_vo(weapon, magic_box);
        self notify(#"weapon_give", weapon);
        return weapon;
    }
    if (isdefined(level.zombie_weapons_callbacks) && isdefined(level.zombie_weapons_callbacks[weapon])) {
        self thread [[ level.zombie_weapons_callbacks[weapon] ]]();
        play_weapon_vo(weapon, magic_box);
        self notify(#"weapon_give", weapon);
        return weapon;
    }
    if (!(isdefined(nosound) && nosound)) {
        self zm_utility::play_sound_on_ent("purchase");
    }
    weapon = self give_build_kit_weapon(weapon);
    self notify(#"weapon_give", weapon);
    self givestartammo(weapon);
    if (b_switch_weapon && !zm_utility::is_offhand_weapon(weapon)) {
        if (!zm_utility::is_melee_weapon(weapon)) {
            self switchtoweapon(weapon);
        } else {
            self switchtoweapon(current_weapon);
        }
    }
    if (!(isdefined(nosound) && nosound)) {
        self play_weapon_vo(weapon, magic_box);
    }
    return weapon;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xc0d61261, Offset: 0x8680
// Size: 0x4c
function weapon_take(weapon) {
    self notify(#"weapon_take", weapon);
    if (self hasweapon(weapon)) {
        self takeweapon(weapon);
    }
}

// Namespace zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x2970475e, Offset: 0x86d8
// Size: 0x204
function play_weapon_vo(weapon, magic_box) {
    if (isdefined(level._audio_custom_weapon_check)) {
        type = self [[ level._audio_custom_weapon_check ]](weapon, magic_box);
    } else {
        type = self weapon_type_check(weapon);
    }
    if (!isdefined(type)) {
        return;
    }
    if (isdefined(level.sndweaponpickupoverride)) {
        foreach (override in level.sndweaponpickupoverride) {
            if (weapon.name === override) {
                self zm_audio::create_and_play_dialog("weapon_pickup", override);
                return;
            }
        }
    }
    if (isdefined(magic_box) && magic_box) {
        self zm_audio::create_and_play_dialog("box_pickup", type);
        return;
    }
    if (type == "upgrade") {
        self zm_audio::create_and_play_dialog("weapon_pickup", "upgrade");
        return;
    }
    if (randomintrange(0, 100) <= 50) {
        self zm_audio::create_and_play_dialog("weapon_pickup", type);
        return;
    }
    self zm_audio::create_and_play_dialog("weapon_pickup", "generic");
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x3f740074, Offset: 0x88e8
// Size: 0x120
function weapon_type_check(weapon) {
    if (weapon.name == "zombie_beast_grapple_dwr" || weapon.name == "zombie_beast_lightning_dwl" || weapon.name == "zombie_beast_lightning_dwl2" || weapon.name == "zombie_beast_lightning_dwl3") {
        return undefined;
    }
    if (!isdefined(self.entity_num)) {
        return "crappy";
    }
    weapon = get_nonalternate_weapon(weapon);
    weapon = weapon.rootweapon;
    if (is_weapon_upgraded(weapon)) {
        return "upgrade";
    }
    if (isdefined(level.zombie_weapons[weapon])) {
        return level.zombie_weapons[weapon].vox;
    }
    return "crappy";
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xd6c98b8, Offset: 0x8a10
// Size: 0x20e
function ammo_give(weapon) {
    give_ammo = 0;
    if (!zm_utility::is_offhand_weapon(weapon)) {
        weapon = self get_weapon_with_attachments(weapon);
        if (isdefined(weapon)) {
            stockmax = 0;
            stockmax = weapon.maxammo;
            var_fd9df870 = self getweaponammoclip(weapon);
            var_5a23c658 = self getweaponammoclip(weapon.dualwieldweapon);
            var_93a433cd = self getammocount(weapon);
            if (var_93a433cd - var_fd9df870 + var_5a23c658 >= stockmax) {
                give_ammo = 0;
            } else {
                give_ammo = 1;
            }
        }
    } else if (self has_weapon_or_upgrade(weapon)) {
        if (self getammocount(weapon) < weapon.maxammo) {
            give_ammo = 1;
        }
    }
    if (give_ammo) {
        self zm_utility::play_sound_on_ent("purchase");
        self givemaxammo(weapon);
        var_23835f5a = weapon.altweapon;
        if (level.weaponnone != var_23835f5a) {
            self givemaxammo(var_23835f5a);
        }
        return 1;
    }
    if (!give_ammo) {
        return 0;
    }
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x58f21b8e, Offset: 0x8c28
// Size: 0x1d2
function get_default_weapondata(weapon) {
    weapondata = [];
    weapondata["weapon"] = weapon;
    dw_weapon = weapon.dualwieldweapon;
    alt_weapon = weapon.altweapon;
    weaponnone = getweapon("none");
    if (isdefined(level.weaponnone)) {
        weaponnone = level.weaponnone;
    }
    if (weapon != weaponnone) {
        weapondata["clip"] = weapon.clipsize;
        weapondata["stock"] = weapon.maxammo;
        weapondata["fuel"] = weapon.fuellife;
        weapondata["heat"] = 0;
        weapondata["overheat"] = 0;
    }
    if (dw_weapon != weaponnone) {
        weapondata["lh_clip"] = dw_weapon.clipsize;
    } else {
        weapondata["lh_clip"] = 0;
    }
    if (alt_weapon != weaponnone) {
        weapondata["alt_clip"] = alt_weapon.clipsize;
        weapondata["alt_stock"] = alt_weapon.maxammo;
    } else {
        weapondata["alt_clip"] = 0;
        weapondata["alt_stock"] = 0;
    }
    return weapondata;
}

// Namespace zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x105be506, Offset: 0x8e08
// Size: 0x2a2
function get_player_weapondata(player, weapon) {
    weapondata = [];
    if (!isdefined(weapon)) {
        weapon = player getcurrentweapon();
    }
    weapondata["weapon"] = weapon;
    if (weapondata["weapon"] != level.weaponnone) {
        weapondata["clip"] = player getweaponammoclip(weapon);
        weapondata["stock"] = player getweaponammostock(weapon);
        weapondata["fuel"] = player getweaponammofuel(weapon);
        weapondata["heat"] = player isweaponoverheating(1, weapon);
        weapondata["overheat"] = player isweaponoverheating(0, weapon);
    } else {
        weapondata["clip"] = 0;
        weapondata["stock"] = 0;
        weapondata["fuel"] = 0;
        weapondata["heat"] = 0;
        weapondata["overheat"] = 0;
    }
    dw_weapon = weapon.dualwieldweapon;
    if (dw_weapon != level.weaponnone) {
        weapondata["lh_clip"] = player getweaponammoclip(dw_weapon);
    } else {
        weapondata["lh_clip"] = 0;
    }
    alt_weapon = weapon.altweapon;
    if (alt_weapon != level.weaponnone) {
        weapondata["alt_clip"] = player getweaponammoclip(alt_weapon);
        weapondata["alt_stock"] = player getweaponammostock(alt_weapon);
    } else {
        weapondata["alt_clip"] = 0;
        weapondata["alt_stock"] = 0;
    }
    return weapondata;
}

// Namespace zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x22b38581, Offset: 0x90b8
// Size: 0xd8
function weapon_is_better(left, right) {
    if (left != right) {
        left_upgraded = !isdefined(level.zombie_weapons[left]);
        right_upgraded = !isdefined(level.zombie_weapons[right]);
        if (left_upgraded && right_upgraded) {
            var_74d3322f = get_attachment_index(left);
            var_c82602ca = get_attachment_index(right);
            return (var_74d3322f > var_c82602ca);
        } else if (left_upgraded) {
            return true;
        }
    }
    return false;
}

// Namespace zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x6cb8dce3, Offset: 0x9198
// Size: 0x486
function merge_weapons(oldweapondata, newweapondata) {
    weapondata = [];
    if (weapon_is_better(oldweapondata["weapon"], newweapondata["weapon"])) {
        weapondata["weapon"] = oldweapondata["weapon"];
    } else {
        weapondata["weapon"] = newweapondata["weapon"];
    }
    weapon = weapondata["weapon"];
    dw_weapon = weapon.dualwieldweapon;
    alt_weapon = weapon.altweapon;
    if (weapon != level.weaponnone) {
        weapondata["clip"] = newweapondata["clip"] + oldweapondata["clip"];
        weapondata["clip"] = int(min(weapondata["clip"], weapon.clipsize));
        weapondata["stock"] = newweapondata["stock"] + oldweapondata["stock"];
        weapondata["stock"] = int(min(weapondata["stock"], weapon.maxammo));
        weapondata["fuel"] = newweapondata["fuel"] + oldweapondata["fuel"];
        weapondata["fuel"] = int(min(weapondata["fuel"], weapon.fuellife));
        weapondata["heat"] = int(min(newweapondata["heat"], oldweapondata["heat"]));
        weapondata["overheat"] = int(min(newweapondata["overheat"], oldweapondata["overheat"]));
    }
    if (dw_weapon != level.weaponnone) {
        weapondata["lh_clip"] = newweapondata["lh_clip"] + oldweapondata["lh_clip"];
        weapondata["lh_clip"] = int(min(weapondata["lh_clip"], dw_weapon.clipsize));
    }
    if (alt_weapon != level.weaponnone) {
        weapondata["alt_clip"] = newweapondata["alt_clip"] + oldweapondata["alt_clip"];
        weapondata["alt_clip"] = int(min(weapondata["alt_clip"], alt_weapon.clipsize));
        weapondata["alt_stock"] = newweapondata["alt_stock"] + oldweapondata["alt_stock"];
        weapondata["alt_stock"] = int(min(weapondata["alt_stock"], alt_weapon.maxammo));
    }
    return weapondata;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xb78b0ad2, Offset: 0x9628
// Size: 0x31c
function weapondata_give(weapondata) {
    current = self get_player_weapon_with_same_base(weapondata["weapon"]);
    if (isdefined(current)) {
        curweapondata = get_player_weapondata(self, current);
        self weapon_take(current);
        weapondata = merge_weapons(curweapondata, weapondata);
    }
    weapon = weapondata["weapon"];
    weapon_give(weapon, undefined, undefined, 1);
    if (weapon != level.weaponnone) {
        self setweaponammoclip(weapon, weapondata["clip"]);
        self setweaponammostock(weapon, weapondata["stock"]);
        if (isdefined(weapondata["fuel"])) {
            self setweaponammofuel(weapon, weapondata["fuel"]);
        }
        if (isdefined(weapondata["heat"]) && isdefined(weapondata["overheat"])) {
            self setweaponoverheating(weapondata["overheat"], weapondata["heat"], weapon);
        }
    }
    dw_weapon = weapon.dualwieldweapon;
    if (dw_weapon != level.weaponnone) {
        if (!self hasweapon(dw_weapon)) {
            self giveweapon(dw_weapon);
        }
        self setweaponammoclip(dw_weapon, weapondata["lh_clip"]);
    }
    alt_weapon = weapon.altweapon;
    if (alt_weapon != level.weaponnone && alt_weapon.altweapon == weapon) {
        if (!self hasweapon(alt_weapon)) {
            self giveweapon(alt_weapon);
        }
        self setweaponammoclip(alt_weapon, weapondata["alt_clip"]);
        self setweaponammostock(alt_weapon, weapondata["alt_stock"]);
    }
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x1fdc094a, Offset: 0x9950
// Size: 0x144
function weapondata_take(weapondata) {
    weapon = weapondata["weapon"];
    if (weapon != level.weaponnone) {
        if (self hasweapon(weapon)) {
            self weapon_take(weapon);
        }
    }
    dw_weapon = weapon.dualwieldweapon;
    if (dw_weapon != level.weaponnone) {
        if (self hasweapon(dw_weapon)) {
            self weapon_take(dw_weapon);
        }
    }
    for (alt_weapon = weapon.altweapon; alt_weapon != level.weaponnone; alt_weapon = alt_weapon.altweapon) {
        if (self hasweapon(alt_weapon)) {
            self weapon_take(alt_weapon);
        }
    }
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x7e6772e1, Offset: 0x9aa0
// Size: 0x1ae
function create_loadout(weapons) {
    weaponnone = getweapon("none");
    if (isdefined(level.weaponnone)) {
        weaponnone = level.weaponnone;
    }
    loadout = spawnstruct();
    loadout.weapons = [];
    foreach (weapon in weapons) {
        if (isstring(weapon)) {
            weapon = getweapon(weapon);
        }
        if (weapon == weaponnone) {
            println("<dev string:x149>" + weapon.name);
        }
        loadout.weapons[weapon.name] = get_default_weapondata(weapon);
        if (!isdefined(loadout.current)) {
            loadout.current = weapon;
        }
    }
    return loadout;
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0xc25f2bb0, Offset: 0x9c58
// Size: 0x120
function player_get_loadout() {
    loadout = spawnstruct();
    loadout.current = self getcurrentweapon();
    loadout.stowed = self getstowedweapon();
    loadout.weapons = [];
    foreach (weapon in self getweaponslist()) {
        loadout.weapons[weapon.name] = get_player_weapondata(self, weapon);
    }
    return loadout;
}

// Namespace zm_weapons
// Params 3, eflags: 0x0
// Checksum 0xf6710b16, Offset: 0x9d80
// Size: 0x1e4
function player_give_loadout(loadout, replace_existing, immediate_switch) {
    if (!isdefined(replace_existing)) {
        replace_existing = 1;
    }
    if (!isdefined(immediate_switch)) {
        immediate_switch = 0;
    }
    if (isdefined(replace_existing) && replace_existing) {
        self takeallweapons();
    }
    foreach (weapondata in loadout.weapons) {
        self weapondata_give(weapondata);
    }
    if (!zm_utility::is_offhand_weapon(loadout.current)) {
        if (immediate_switch) {
            self switchtoweaponimmediate(loadout.current);
        } else {
            self switchtoweapon(loadout.current);
        }
    } else if (immediate_switch) {
        self switchtoweaponimmediate();
    } else {
        self switchtoweapon();
    }
    if (isdefined(loadout.stowed)) {
        self setstowedweapon(loadout.stowed);
    }
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x3ed37bba, Offset: 0x9f70
// Size: 0x9a
function player_take_loadout(loadout) {
    foreach (weapondata in loadout.weapons) {
        self weapondata_take(weapondata);
    }
}

// Namespace zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x2ae33781, Offset: 0xa018
// Size: 0x52
function register_zombie_weapon_callback(weapon, func) {
    if (!isdefined(level.zombie_weapons_callbacks)) {
        level.zombie_weapons_callbacks = [];
    }
    if (!isdefined(level.zombie_weapons_callbacks[weapon])) {
        level.zombie_weapons_callbacks[weapon] = func;
    }
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xc8fa7bbf, Offset: 0xa078
// Size: 0x4c
function set_stowed_weapon(weapon) {
    self.weapon_stowed = weapon;
    if (!(isdefined(self.stowed_weapon_suppressed) && self.stowed_weapon_suppressed)) {
        self setstowedweapon(self.weapon_stowed);
    }
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x549a831a, Offset: 0xa0d0
// Size: 0x24
function clear_stowed_weapon() {
    self.weapon_stowed = undefined;
    self clearstowedweapon();
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x39fb5d74, Offset: 0xa100
// Size: 0x64
function suppress_stowed_weapon(onoff) {
    self.stowed_weapon_suppressed = onoff;
    if (onoff || !isdefined(self.weapon_stowed)) {
        self clearstowedweapon();
        return;
    }
    self setstowedweapon(self.weapon_stowed);
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x93e2ab52, Offset: 0xa170
// Size: 0x24
function checkstringvalid(str) {
    if (str != "") {
        return str;
    }
    return undefined;
}

// Namespace zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x69e8aa05, Offset: 0xa1a0
// Size: 0x51c
function load_weapon_spec_from_table(table, first_row) {
    gametype = getdvarstring("ui_gametype");
    index = 1;
    for (row = tablelookuprow(table, index); isdefined(row); row = tablelookuprow(table, index)) {
        weapon_name = checkstringvalid(row[0]);
        upgrade_name = checkstringvalid(row[1]);
        hint = checkstringvalid(row[2]);
        cost = int(row[3]);
        weaponvo = checkstringvalid(row[4]);
        weaponvoresp = checkstringvalid(row[5]);
        ammo_cost = undefined;
        if ("" != row[6]) {
            ammo_cost = int(row[6]);
        }
        create_vox = checkstringvalid(row[7]);
        is_zcleansed = tolower(row[8]) == "true";
        in_box = tolower(row[9]) == "true";
        upgrade_in_box = tolower(row[10]) == "true";
        is_limited = tolower(row[11]) == "true";
        var_1549a8fc = tolower(row[17]) == "true";
        limit = int(row[12]);
        upgrade_limit = int(row[13]);
        content_restrict = row[14];
        wallbuy_autospawn = tolower(row[15]) == "true";
        weapon_class = checkstringvalid(row[16]);
        is_wonder_weapon = tolower(row[18]) == "true";
        var_e44dc8f1 = tolower(row[19]);
        zm_utility::include_weapon(weapon_name, in_box);
        if (isdefined(upgrade_name)) {
            zm_utility::include_weapon(upgrade_name, upgrade_in_box);
        }
        add_zombie_weapon(weapon_name, upgrade_name, hint, cost, weaponvo, weaponvoresp, ammo_cost, create_vox, is_wonder_weapon, var_e44dc8f1);
        if (is_limited) {
            if (isdefined(limit)) {
                add_limited_weapon(weapon_name, limit);
            }
            if (isdefined(upgrade_limit) && isdefined(upgrade_name)) {
                add_limited_weapon(upgrade_name, upgrade_limit);
            }
        }
        if (var_1549a8fc && isdefined(upgrade_name)) {
            aat::register_aat_exemption(getweapon(upgrade_name));
        }
        index++;
    }
}

// Namespace zm_weapons
// Params 0, eflags: 0x0
// Checksum 0xa7f3d169, Offset: 0xa6c8
// Size: 0x696
function function_9e8dccbe() {
    wallbuys = struct::get_array("wallbuy_autofill", "targetname");
    if (!isdefined(wallbuys) || wallbuys.size == 0 || !isdefined(level.var_723d0afa) || level.var_723d0afa.size == 0) {
        return;
    }
    level.use_autofill_wallbuy = 1;
    level.active_autofill_wallbuys = [];
    var_69e24b8b["all"] = getarraykeys(level.var_723d0afa["all"]);
    var_7e5108a3 = [];
    index = 0;
    foreach (wallbuy in wallbuys) {
        weapon_class = wallbuy.script_string;
        weapon = undefined;
        if (isdefined(weapon_class) && weapon_class != "") {
            if (!isdefined(var_69e24b8b[weapon_class]) && isdefined(level.var_723d0afa[weapon_class])) {
                var_69e24b8b[weapon_class] = getarraykeys(level.var_723d0afa[weapon_class]);
            }
            if (isdefined(var_69e24b8b[weapon_class])) {
                for (i = 0; i < var_69e24b8b[weapon_class].size; i++) {
                    if (level.var_723d0afa["all"][var_69e24b8b[weapon_class][i]]) {
                        weapon = var_69e24b8b[weapon_class][i];
                        level.var_723d0afa["all"][weapon] = 0;
                        break;
                    }
                }
            } else {
                continue;
            }
        } else {
            var_7e5108a3[var_7e5108a3.size] = wallbuy;
            continue;
        }
        if (!isdefined(weapon)) {
            continue;
        }
        wallbuy.zombie_weapon_upgrade = weapon.name;
        wallbuy.weapon = weapon;
        right = anglestoright(wallbuy.angles);
        wallbuy.origin -= right * 2;
        wallbuy.target = "autofill_wallbuy_" + index;
        target_struct = spawnstruct();
        target_struct.targetname = wallbuy.target;
        target_struct.angles = wallbuy.angles;
        target_struct.origin = wallbuy.origin;
        model = wallbuy.weapon.worldmodel;
        target_struct.model = model;
        target_struct struct::init();
        level.active_autofill_wallbuys[level.active_autofill_wallbuys.size] = wallbuy;
        index++;
    }
    foreach (wallbuy in var_7e5108a3) {
        weapon = undefined;
        for (i = 0; i < var_69e24b8b["all"].size; i++) {
            if (level.var_723d0afa["all"][var_69e24b8b["all"][i]]) {
                weapon = var_69e24b8b["all"][i];
                level.var_723d0afa["all"][weapon] = 0;
                break;
            }
        }
        if (!isdefined(weapon)) {
            break;
        }
        wallbuy.zombie_weapon_upgrade = weapon.name;
        wallbuy.weapon = weapon;
        right = anglestoright(wallbuy.angles);
        wallbuy.origin -= right * 2;
        wallbuy.target = "autofill_wallbuy_" + index;
        target_struct = spawnstruct();
        target_struct.targetname = wallbuy.target;
        target_struct.angles = wallbuy.angles;
        target_struct.origin = wallbuy.origin;
        model = wallbuy.weapon.worldmodel;
        target_struct.model = model;
        target_struct struct::init();
        level.active_autofill_wallbuys[level.active_autofill_wallbuys.size] = wallbuy;
        index++;
    }
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xf7745372, Offset: 0xad68
// Size: 0xbe
function is_wallbuy(w_to_check) {
    w_base = get_base_weapon(w_to_check);
    foreach (s_wallbuy in level._spawned_wallbuys) {
        if (s_wallbuy.weapon == w_base) {
            return true;
        }
    }
    return false;
}

// Namespace zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x9164f3bf, Offset: 0xae30
// Size: 0x66
function is_wonder_weapon(w_to_check) {
    w_base = get_base_weapon(w_to_check);
    if (isdefined(level.zombie_weapons[w_base]) && level.zombie_weapons[w_base].is_wonder_weapon) {
        return true;
    }
    return false;
}

