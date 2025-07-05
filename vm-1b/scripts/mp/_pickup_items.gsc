#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_weaponobjects;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/weapons/_weapons;

#namespace pickup_items;

// Namespace pickup_items
// Params 0, eflags: 0x2
// Checksum 0xecdf8e0, Offset: 0x2a0
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("pickup_items", &__init__, undefined, undefined);
}

// Namespace pickup_items
// Params 0, eflags: 0x0
// Checksum 0x3bba985c, Offset: 0x2d8
// Size: 0x32
function __init__() {
    callback::on_start_gametype(&start_gametype);
    level.pickup_items = [];
    level.pickupitemrespawn = 1;
}

// Namespace pickup_items
// Params 0, eflags: 0x0
// Checksum 0xbb7697f1, Offset: 0x318
// Size: 0x11
function on_player_spawned() {
    self.pickup_damage_scale = undefined;
    self.pickup_damage_scale_time = undefined;
}

// Namespace pickup_items
// Params 0, eflags: 0x0
// Checksum 0x515dacb9, Offset: 0x338
// Size: 0x193
function start_gametype() {
    callback::on_spawned(&on_player_spawned);
    pickup_triggers = getentarray("pickup_item", "targetname");
    pickup_models = getentarray("pickup_model", "targetname");
    visuals = [];
    foreach (trigger in pickup_triggers) {
        visuals[0] = get_visual_for_trigger(trigger, pickup_models);
        assert(isdefined(visuals[0]));
        visuals[0] pickup_item_init();
        pickup_item_object = gameobjects::create_use_object("neutral", trigger, visuals, (0, 0, 32), istring("pickup_item"));
        pickup_item_object gameobjects::allow_use("any");
        pickup_item_object gameobjects::set_use_time(0);
        pickup_item_object.onuse = &on_touch;
        level.pickup_items[level.pickup_items.size] = pickup_item_object;
    }
}

// Namespace pickup_items
// Params 2, eflags: 0x0
// Checksum 0x5f97f62, Offset: 0x4d8
// Size: 0x7a
function get_visual_for_trigger(trigger, pickup_models) {
    foreach (model in pickup_models) {
        if (model istouchingswept(trigger)) {
            return model;
        }
    }
    return undefined;
}

// Namespace pickup_items
// Params 0, eflags: 0x0
// Checksum 0x1567d1ef, Offset: 0x560
// Size: 0x1a
function set_pickup_bobbing() {
    self bobbing((0, 0, 1), 4, 1);
}

// Namespace pickup_items
// Params 0, eflags: 0x0
// Checksum 0xef9b7a56, Offset: 0x588
// Size: 0x1a
function set_pickup_rotation() {
    self rotate((0, 175, 0));
}

// Namespace pickup_items
// Params 0, eflags: 0x0
// Checksum 0x7c6b6059, Offset: 0x5b0
// Size: 0x71
function get_item_for_pickup() {
    if (self.items.size == 1) {
        return self.items[0];
    }
    if (self.items_shuffle.size == 0) {
        self.items_shuffle = arraycopy(self.items);
        array::randomize(self.items_shuffle);
    }
    return array::pop_front(self.items_shuffle);
}

// Namespace pickup_items
// Params 0, eflags: 0x0
// Checksum 0xa6d45090, Offset: 0x630
// Size: 0x4a
function cycle_item() {
    self.current_item = self get_item_for_pickup();
    if (isdefined(self.current_item.model)) {
        self setmodel(self.current_item.model);
    }
}

// Namespace pickup_items
// Params 1, eflags: 0x0
// Checksum 0x2b20744b, Offset: 0x688
// Size: 0x94
function get_item_from_string_ammo(perks_string) {
    item_struct = spawnstruct();
    item_struct.name = "ammo";
    item_struct.weapon = getweapon("scavenger_item");
    item_struct.model = item_struct.weapon.worldmodel;
    self.angles = (0, 0, 90);
    self thread weapons::scavenger_think();
    return item_struct;
}

// Namespace pickup_items
// Params 1, eflags: 0x0
// Checksum 0xd4747a7c, Offset: 0x728
// Size: 0x7c
function get_item_from_string_damage(perks_string) {
    item_struct = spawnstruct();
    item_struct.name = "damage";
    item_struct.damage_scale = float(perks_string);
    item_struct.model = "wpn_t7_igc_bullet_prop";
    self.angles = (-45, 0, 0);
    self setscale(2);
    return item_struct;
}

// Namespace pickup_items
// Params 1, eflags: 0x0
// Checksum 0x45ce1bc9, Offset: 0x7b0
// Size: 0x7c
function get_item_from_string_health(perks_string) {
    item_struct = spawnstruct();
    item_struct.name = "health";
    item_struct.extra_health = int(perks_string);
    item_struct.model = "p7_medical_surgical_tools_syringe";
    self.angles = (-45, 0, 45);
    self setscale(5);
    return item_struct;
}

// Namespace pickup_items
// Params 1, eflags: 0x0
// Checksum 0x5b267719, Offset: 0x838
// Size: 0xbc
function get_item_from_string_perk(perks_string) {
    item_struct = spawnstruct();
    if (!isdefined(level.perkspecialties[perks_string])) {
        /#
            util::error("<dev string:x28>" + perks_string + "<dev string:x3b>" + self.origin);
        #/
        return;
    }
    item_struct.name = perks_string;
    item_struct.specialties = strtok(level.perkspecialties[perks_string], "|");
    item_struct.model = "p7_perk_" + level.perkicons[perks_string];
    self setscale(2);
    return item_struct;
}

// Namespace pickup_items
// Params 1, eflags: 0x0
// Checksum 0xecdcefbd, Offset: 0x900
// Size: 0xdc
function get_item_from_string_weapon(weapon_and_attachments_string) {
    item_struct = spawnstruct();
    weapon_and_attachments = strtok(weapon_and_attachments_string, "+");
    weapon_name = getsubstr(weapon_and_attachments[0], 0, weapon_and_attachments[0].size);
    attachments = array::remove_index(weapon_and_attachments, 0);
    item_struct.name = weapon_name;
    item_struct.weapon = getweapon(weapon_name, attachments);
    item_struct.model = item_struct.weapon.worldmodel;
    self setscale(1.5);
    return item_struct;
}

// Namespace pickup_items
// Params 1, eflags: 0x0
// Checksum 0x98f2d37c, Offset: 0x9e8
// Size: 0x99
function get_item_from_string(item_string) {
    switch (self.script_noteworthy) {
    case "ammo":
        return self get_item_from_string_ammo(item_string);
    case "damage":
        return self get_item_from_string_damage(item_string);
    case "health":
        return self get_item_from_string_health(item_string);
    case "perk":
        return self get_item_from_string_perk(item_string);
    case "weapon":
        return self get_item_from_string_weapon(item_string);
    }
}

// Namespace pickup_items
// Params 0, eflags: 0x0
// Checksum 0x4980e485, Offset: 0xa90
// Size: 0xa3
function init_items_for_pickup() {
    items_string = self.script_parameters;
    items_array = strtok(items_string, " ");
    items = [];
    foreach (item_string in items_array) {
        items[items.size] = self get_item_from_string(item_string);
    }
    return items;
}

// Namespace pickup_items
// Params 0, eflags: 0x0
// Checksum 0x59fac563, Offset: 0xb40
// Size: 0x4d
function pickup_item_respawn_time() {
    switch (self.script_noteworthy) {
    case "ammo":
        return 10;
    case "damage":
        return 30;
    case "health":
        return 10;
    case "perk":
        return 10;
    case "weapon":
        return 15;
    }
}

// Namespace pickup_items
// Params 0, eflags: 0x0
// Checksum 0x1597e882, Offset: 0xb98
// Size: 0x69
function pickup_item_sound_pickup() {
    switch (self.script_noteworthy) {
    case "ammo":
        return "wpn_ammo_pickup";
    case "damage":
        return "wpn_weap_pickup";
    case "health":
        return "wpn_weap_pickup";
    case "perk":
        return "wpn_weap_pickup";
    case "weapon":
        return "wpn_weap_pickup";
    }
}

// Namespace pickup_items
// Params 0, eflags: 0x0
// Checksum 0xdf42966c, Offset: 0xc10
// Size: 0x69
function pickup_item_sound_respawn() {
    switch (self.script_noteworthy) {
    case "ammo":
        return "wpn_ammo_pickup";
    case "damage":
        return "wpn_weap_pickup";
    case "health":
        return "wpn_weap_pickup";
    case "perk":
        return "wpn_weap_pickup";
    case "weapon":
        return "wpn_weap_pickup";
    }
}

// Namespace pickup_items
// Params 0, eflags: 0x0
// Checksum 0xcd7d8802, Offset: 0xc88
// Size: 0x9a
function pickup_item_init() {
    self.items_shuffle = [];
    self set_pickup_bobbing();
    self.items = self init_items_for_pickup();
    self.respawn_time = self pickup_item_respawn_time();
    self.sound_pickup = self pickup_item_sound_pickup();
    self.sound_respawn = self pickup_item_sound_respawn();
    self set_pickup_rotation();
    self cycle_item();
}

// Namespace pickup_items
// Params 1, eflags: 0x0
// Checksum 0x92eca420, Offset: 0xd30
// Size: 0x14a
function on_touch(player) {
    self endon(#"respawned");
    pickup_item = self.visuals[0];
    switch (pickup_item.script_noteworthy) {
    case "ammo":
        pickup_item on_touch_ammo(player);
        break;
    case "damage":
        pickup_item on_touch_damage(player);
        break;
    case "health":
        pickup_item on_touch_health(player);
        break;
    case "perk":
        pickup_item on_touch_perk(player);
        break;
    case "weapon":
        pickup_item on_touch_weapon(player);
        break;
    }
    pickup_item playsound(pickup_item.sound_pickup);
    self gameobjects::set_model_visibility(0);
    self gameobjects::allow_use("none");
    if (level.pickupitemrespawn) {
        wait pickup_item.respawn_time;
        self respawn_pickup();
    }
}

// Namespace pickup_items
// Params 0, eflags: 0x0
// Checksum 0x9993c5a9, Offset: 0xe88
// Size: 0x72
function respawn_pickup() {
    self notify(#"respawned");
    pickup_item = self.visuals[0];
    pickup_item playsound(pickup_item.sound_respawn);
    pickup_item cycle_item();
    self gameobjects::set_model_visibility(1);
    self gameobjects::allow_use("any");
}

// Namespace pickup_items
// Params 0, eflags: 0x0
// Checksum 0x32d9a8ab, Offset: 0xf08
// Size: 0x63
function respawn_all_pickups() {
    foreach (item in level.pickup_items) {
        item respawn_pickup();
    }
}

// Namespace pickup_items
// Params 1, eflags: 0x0
// Checksum 0x3b2cd6a1, Offset: 0xf78
// Size: 0x2a
function on_touch_ammo(player) {
    self notify(#"scavenger", player);
    player pickupammoevent();
}

// Namespace pickup_items
// Params 1, eflags: 0x0
// Checksum 0xbae303a7, Offset: 0xfb0
// Size: 0x3e
function on_touch_damage(player) {
    damage_scale_length = 15000;
    player.pickup_damage_scale = self.current_item.damage_scale;
    player.pickup_damage_scale_time = gettime() + damage_scale_length;
}

// Namespace pickup_items
// Params 1, eflags: 0x0
// Checksum 0x55b580a, Offset: 0xff8
// Size: 0x76
function on_touch_health(player) {
    if (self.current_item.extra_health <= 100) {
        health = player.health + self.current_item.extra_health;
        if (health > 100) {
            health = 100;
        }
    } else {
        health = self.current_item.extra_health;
    }
    player.health = health;
}

// Namespace pickup_items
// Params 1, eflags: 0x0
// Checksum 0xbfecc8f5, Offset: 0x1078
// Size: 0x73
function on_touch_perk(player) {
    foreach (specialty in self.current_item.specialties) {
        player setperk(specialty);
    }
}

// Namespace pickup_items
// Params 0, eflags: 0x0
// Checksum 0x7f853404, Offset: 0x10f8
// Size: 0x83
function take_player_gadgets() {
    weapons = self getweaponslist(1);
    foreach (weapon in weapons) {
        if (weapon.isgadget) {
            self takeweapon(weapon);
        }
    }
}

// Namespace pickup_items
// Params 1, eflags: 0x0
// Checksum 0x2e2c7cc2, Offset: 0x1188
// Size: 0x2d
function should_switch_to_pickup_weapon(weapon) {
    if (weapon.isgadget) {
        return false;
    }
    if (weapon.isgrenadeweapon) {
        return false;
    }
    return true;
}

// Namespace pickup_items
// Params 1, eflags: 0x0
// Checksum 0x8c90d4d, Offset: 0x11c0
// Size: 0x1da
function on_touch_weapon(player) {
    weapon = self.current_item.weapon;
    had_weapon = player hasweapon(weapon);
    player pickupweaponevent(weapon);
    ammo_in_reserve = player getweaponammostock(weapon);
    if (!had_weapon && weapon.isgadget && weapon.isheroweapon) {
        player take_player_gadgets();
    }
    player giveweapon(weapon);
    if (!player hasweapon(weapon)) {
        return;
    }
    if (isdefined(self.script_ammo_clip) && isdefined(self.script_ammo_extra)) {
        if (had_weapon) {
            player setweaponammostock(weapon, ammo_in_reserve + self.script_ammo_clip + self.script_ammo_extra);
        } else {
            if (self.script_ammo_clip >= 0) {
                player setweaponammoclip(weapon, self.script_ammo_clip);
            }
            if (self.script_ammo_extra >= 0) {
                player setweaponammostock(weapon, self.script_ammo_extra);
            }
        }
    }
    if (weapon.isgadget) {
        slot = player gadgetgetslot(weapon);
        player gadgetpowerset(slot, 100);
    }
    if (!had_weapon && should_switch_to_pickup_weapon(weapon)) {
        player switchtoweapon(weapon);
    }
}

