#using scripts/mp/killstreaks/_supplydrop;
#using scripts/mp/killstreaks/_killstreak_weapons;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_dogs;
#using scripts/mp/_util;
#using scripts/mp/_scoreevents;
#using scripts/mp/_challenges;
#using scripts/mp/gametypes/_weaponobjects;
#using scripts/mp/gametypes/_weapon_utils;
#using scripts/mp/gametypes/_shellshock;
#using scripts/mp/gametypes/_loadout;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/shared/weapons/_weapons;
#using scripts/shared/weapons_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace weapons;

// Namespace weapons
// Params 0, eflags: 0x2
// namespace_f996a5bc<file_0>::function_2dc19561
// Checksum 0x6acead72, Offset: 0x3a0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("weapons", &__init__, undefined, undefined);
}

// Namespace weapons
// Params 0, eflags: 0x1 linked
// namespace_f996a5bc<file_0>::function_8c87d8eb
// Checksum 0x8e70bb25, Offset: 0x3e0
// Size: 0x14
function __init__() {
    init_shared();
}

// Namespace weapons
// Params 1, eflags: 0x1 linked
// namespace_f996a5bc<file_0>::function_1146dd0e
// Checksum 0x7736f1df, Offset: 0x400
// Size: 0xc
function function_1146dd0e(weapon) {
    
}

// Namespace weapons
// Params 3, eflags: 0x1 linked
// namespace_f996a5bc<file_0>::function_5be8b6af
// Checksum 0x6d3a70d9, Offset: 0x418
// Size: 0x1c
function function_5be8b6af(weapon, options, var_65ce895e) {
    
}

// Namespace weapons
// Params 3, eflags: 0x0
// namespace_f996a5bc<file_0>::function_27ed864
// Checksum 0x1d0dc094, Offset: 0x440
// Size: 0xe6
function bestweapon_init(weapon, options, var_65ce895e) {
    weapon_data = [];
    weapon_data["weapon"] = weapon;
    weapon_data["options"] = options;
    weapon_data["acvi"] = var_65ce895e;
    weapon_data["kill_count"] = 0;
    weapon_data["spawned_with"] = 0;
    key = self.pers["bestWeapon"][weapon.name].size;
    self.pers["bestWeapon"][weapon.name][key] = weapon_data;
    return key;
}

// Namespace weapons
// Params 3, eflags: 0x0
// namespace_f996a5bc<file_0>::function_4a709de3
// Checksum 0xfbd35e31, Offset: 0x530
// Size: 0x192
function bestweapon_find(weapon, options, var_65ce895e) {
    if (!isdefined(self.pers["bestWeapon"])) {
        self.pers["bestWeapon"] = [];
    }
    if (!isdefined(self.pers["bestWeapon"][weapon.name])) {
        self.pers["bestWeapon"][weapon.name] = [];
    }
    name = weapon.name;
    size = self.pers["bestWeapon"][name].size;
    for (index = 0; index < size; index++) {
        if (self.pers["bestWeapon"][name][index]["weapon"] == weapon && self.pers["bestWeapon"][name][index]["options"] == options && self.pers["bestWeapon"][name][index]["acvi"] == var_65ce895e) {
            return index;
        }
    }
    return undefined;
}

// Namespace weapons
// Params 0, eflags: 0x0
// namespace_f996a5bc<file_0>::function_fb8e236
// Checksum 0xdcc9fe36, Offset: 0x6d0
// Size: 0x224
function bestweapon_get() {
    most_kills = 0;
    most_spawns = 0;
    if (!isdefined(self.pers["bestWeapon"])) {
        return;
    }
    best_key = 0;
    best_index = 0;
    weapon_keys = getarraykeys(self.pers["bestWeapon"]);
    for (key_index = 0; key_index < weapon_keys.size; key_index++) {
        key = weapon_keys[key_index];
        size = self.pers["bestWeapon"][key].size;
        for (index = 0; index < size; index++) {
            kill_count = self.pers["bestWeapon"][key][index]["kill_count"];
            spawned_with = self.pers["bestWeapon"][key][index]["spawned_with"];
            if (kill_count > most_kills) {
                best_index = index;
                best_key = key;
                most_kills = kill_count;
                most_spawns = spawned_with;
                continue;
            }
            if (kill_count == most_kills && spawned_with > most_spawns) {
                best_index = index;
                best_key = key;
                most_kills = kill_count;
                most_spawns = spawned_with;
            }
        }
    }
    return self.pers["bestWeapon"][best_key][best_index];
}

// Namespace weapons
// Params 0, eflags: 0x1 linked
// namespace_f996a5bc<file_0>::function_7f1938e7
// Checksum 0xd2203524, Offset: 0x900
// Size: 0x38e
function showcaseweapon_get() {
    showcaseweapondata = self getplayershowcaseweapon();
    if (!isdefined(showcaseweapondata)) {
        return undefined;
    }
    showcase_weapon = [];
    showcase_weapon["weapon"] = showcaseweapondata.weapon;
    attachmentnames = [];
    var_9853d5dd = [];
    tokenizedattachmentinfo = strtok(showcaseweapondata.attachmentinfo, ",");
    for (index = 0; index + 1 < tokenizedattachmentinfo.size; index += 2) {
        attachmentnames[attachmentnames.size] = tokenizedattachmentinfo[index];
        var_9853d5dd[var_9853d5dd.size] = int(tokenizedattachmentinfo[index + 1]);
    }
    for (index = tokenizedattachmentinfo.size; index + 1 < 16; index += 2) {
        attachmentnames[attachmentnames.size] = "none";
        var_9853d5dd[var_9853d5dd.size] = 0;
    }
    showcase_weapon["acvi"] = getattachmentcosmeticvariantindexes(showcaseweapondata.weapon, attachmentnames[0], var_9853d5dd[0], attachmentnames[1], var_9853d5dd[1], attachmentnames[2], var_9853d5dd[2], attachmentnames[3], var_9853d5dd[3], attachmentnames[4], var_9853d5dd[4], attachmentnames[5], var_9853d5dd[5], attachmentnames[6], var_9853d5dd[6], attachmentnames[7], var_9853d5dd[7]);
    camoindex = 0;
    paintjobslot = 15;
    paintjobindex = 15;
    showpaintshop = 0;
    tokenizedweaponrenderoptions = strtok(showcaseweapondata.weaponrenderoptions, ",");
    if (tokenizedweaponrenderoptions.size > 2) {
        camoindex = int(tokenizedweaponrenderoptions[0]);
        paintjobslot = int(tokenizedweaponrenderoptions[1]);
        paintjobindex = int(tokenizedweaponrenderoptions[2]);
        showpaintshop = paintjobslot != 15 && paintjobindex != 15;
    }
    showcase_weapon["options"] = self calcweaponoptions(camoindex, 0, 0, 0, 0, showpaintshop, 1);
    return showcase_weapon;
}

