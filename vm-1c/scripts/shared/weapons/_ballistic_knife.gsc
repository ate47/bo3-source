#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace ballistic_knife;

// Namespace ballistic_knife
// Params 0, eflags: 0x1 linked
// namespace_a474294<file_0>::function_1463e4e5
// Checksum 0x79ad53c6, Offset: 0x1c8
// Size: 0x24
function init_shared() {
    callback::function_367a33a8(&createballisticknifewatcher);
}

// Namespace ballistic_knife
// Params 2, eflags: 0x1 linked
// namespace_a474294<file_0>::function_e0e5c163
// Checksum 0xb6f9f2bc, Offset: 0x1f8
// Size: 0x334
function onspawn(watcher, player) {
    player endon(#"death");
    player endon(#"disconnect");
    level endon(#"game_ended");
    endpos, normal, angles, attacker, prey, bone = self waittill(#"stationary");
    isfriendly = 0;
    if (isdefined(endpos)) {
        retrievable_model = spawn("script_model", endpos);
        retrievable_model setmodel("wpn_t7_loot_ballistic_knife_projectile");
        retrievable_model setteam(player.team);
        retrievable_model setowner(player);
        retrievable_model.owner = player;
        retrievable_model.angles = angles;
        retrievable_model.name = watcher.weapon;
        retrievable_model.targetname = "sticky_weapon";
        if (isdefined(prey)) {
            if (level.teambased && player.team == prey.team) {
                isfriendly = 1;
            }
            if (!isfriendly) {
                if (isalive(prey)) {
                    retrievable_model droptoground(retrievable_model.origin, 80);
                } else {
                    retrievable_model linkto(prey, bone);
                }
            } else if (isfriendly) {
                retrievable_model physicslaunch(normal, (randomint(10), randomint(10), randomint(10)));
                normal = (0, 0, 1);
            }
        }
        watcher.objectarray[watcher.objectarray.size] = retrievable_model;
        if (isfriendly) {
            retrievable_model waittill(#"stationary");
        }
        retrievable_model thread dropknivestoground();
        if (isfriendly) {
            player notify(#"ballistic_knife_stationary", retrievable_model, normal);
            return;
        }
        player notify(#"ballistic_knife_stationary", retrievable_model, normal, prey);
    }
}

// Namespace ballistic_knife
// Params 0, eflags: 0x1 linked
// namespace_a474294<file_0>::function_dba9bc53
// Checksum 0xbed08e73, Offset: 0x538
// Size: 0x44
function watch_shutdown() {
    pickuptrigger = self.pickuptrigger;
    self waittill(#"death");
    if (isdefined(pickuptrigger)) {
        pickuptrigger delete();
    }
}

// Namespace ballistic_knife
// Params 2, eflags: 0x1 linked
// namespace_a474294<file_0>::function_caded721
// Checksum 0x33386e08, Offset: 0x588
// Size: 0x32c
function onspawnretrievetrigger(watcher, player) {
    player endon(#"death");
    player endon(#"disconnect");
    level endon(#"game_ended");
    retrievable_model, normal, prey = player waittill(#"ballistic_knife_stationary");
    if (!isdefined(retrievable_model)) {
        return;
    }
    vec_scale = 10;
    trigger_pos = [];
    if (isplayer(prey) || isdefined(prey) && isai(prey)) {
        trigger_pos[0] = prey.origin[0];
        trigger_pos[1] = prey.origin[1];
        trigger_pos[2] = prey.origin[2] + vec_scale;
    } else {
        trigger_pos[0] = retrievable_model.origin[0] + vec_scale * normal[0];
        trigger_pos[1] = retrievable_model.origin[1] + vec_scale * normal[1];
        trigger_pos[2] = retrievable_model.origin[2] + vec_scale * normal[2];
    }
    trigger_pos[2] = trigger_pos[2] - 50;
    retrievable_model clientfield::set("retrievable", 1);
    var_9dbe9414 = spawn("trigger_radius", (trigger_pos[0], trigger_pos[1], trigger_pos[2]), 0, 50, 100);
    var_9dbe9414.owner = player;
    retrievable_model.pickuptrigger = var_9dbe9414;
    var_9dbe9414 enablelinkto();
    if (isdefined(prey)) {
        var_9dbe9414 linkto(prey);
    } else {
        var_9dbe9414 linkto(retrievable_model);
    }
    retrievable_model thread function_35579833(var_9dbe9414, retrievable_model, &pick_up, watcher.pickupsoundplayer, watcher.pickupsound);
    retrievable_model thread watch_shutdown();
}

// Namespace ballistic_knife
// Params 5, eflags: 0x1 linked
// namespace_a474294<file_0>::function_35579833
// Checksum 0xa5c5fe6c, Offset: 0x8c0
// Size: 0x2ce
function function_35579833(trigger, model, callback, playersoundonuse, npcsoundonuse) {
    self endon(#"death");
    self endon(#"delete");
    level endon(#"game_ended");
    max_ammo = level.weaponballisticknife.maxammo + 1;
    while (true) {
        player = trigger waittill(#"trigger");
        if (!isalive(player)) {
            continue;
        }
        if (!player isonground() && !sessionmodeismultiplayergame()) {
            continue;
        }
        if (isdefined(trigger.triggerteam) && player.team != trigger.triggerteam) {
            continue;
        }
        if (isdefined(trigger.claimedby) && player != trigger.claimedby) {
            continue;
        }
        if (!player hasweapon(level.weaponballisticknife, 1)) {
            continue;
        }
        var_e22a57bc = player getweaponforweaponroot(level.weaponballisticknife);
        if (!isdefined(var_e22a57bc)) {
            continue;
        }
        var_f9d374f8 = player getweaponammostock(var_e22a57bc);
        var_b58eae98 = player getweaponammoclip(var_e22a57bc);
        total_ammo = var_f9d374f8 + var_b58eae98;
        var_34eba11f = 1;
        if (total_ammo > 0 && var_f9d374f8 == total_ammo) {
            var_34eba11f = 0;
        }
        if (total_ammo >= max_ammo || !var_34eba11f) {
            continue;
        }
        if (isdefined(playersoundonuse)) {
            player playlocalsound(playersoundonuse);
        }
        if (isdefined(npcsoundonuse)) {
            player playsound(npcsoundonuse);
        }
        self thread [[ callback ]](player);
        break;
    }
}

// Namespace ballistic_knife
// Params 1, eflags: 0x1 linked
// namespace_a474294<file_0>::function_6f9992d6
// Checksum 0xf774c980, Offset: 0xb98
// Size: 0x18c
function pick_up(player) {
    self destroy_ent();
    current_weapon = player getcurrentweapon();
    player challenges::pickedupballisticknife();
    if (current_weapon.rootweapon != level.weaponballisticknife) {
        var_e22a57bc = player getweaponforweaponroot(level.weaponballisticknife);
        if (!isdefined(var_e22a57bc)) {
            return;
        }
        clip_ammo = player getweaponammoclip(var_e22a57bc);
        if (!clip_ammo) {
            player setweaponammoclip(var_e22a57bc, 1);
        } else {
            var_e728627d = player getweaponammostock(var_e22a57bc) + 1;
            player setweaponammostock(var_e22a57bc, var_e728627d);
        }
        return;
    }
    var_e728627d = player getweaponammostock(current_weapon) + 1;
    player setweaponammostock(current_weapon, var_e728627d);
}

// Namespace ballistic_knife
// Params 0, eflags: 0x1 linked
// namespace_a474294<file_0>::function_c5341e6f
// Checksum 0xa5eff024, Offset: 0xd30
// Size: 0x5c
function destroy_ent() {
    if (isdefined(self)) {
        pickuptrigger = self.pickuptrigger;
        if (isdefined(pickuptrigger)) {
            pickuptrigger delete();
        }
        self delete();
    }
}

// Namespace ballistic_knife
// Params 0, eflags: 0x1 linked
// namespace_a474294<file_0>::function_d36601c2
// Checksum 0x748f31aa, Offset: 0xd98
// Size: 0x58
function dropknivestoground() {
    self endon(#"death");
    for (;;) {
        origin, radius = level waittill(#"drop_objects_to_ground");
        self droptoground(origin, radius);
    }
}

// Namespace ballistic_knife
// Params 2, eflags: 0x1 linked
// namespace_a474294<file_0>::function_e773b7dc
// Checksum 0xf9503a0b, Offset: 0xdf8
// Size: 0x7c
function droptoground(origin, radius) {
    if (distancesquared(origin, self.origin) < radius * radius) {
        self physicslaunch((0, 0, 1), (5, 5, 5));
        self thread updateretrievetrigger();
    }
}

// Namespace ballistic_knife
// Params 0, eflags: 0x1 linked
// namespace_a474294<file_0>::function_ccac0732
// Checksum 0x4cdefeb9, Offset: 0xe80
// Size: 0x84
function updateretrievetrigger() {
    self endon(#"death");
    self waittill(#"stationary");
    trigger = self.pickuptrigger;
    trigger.origin = (self.origin[0], self.origin[1], self.origin[2] + 10);
    trigger linkto(self);
}

// Namespace ballistic_knife
// Params 0, eflags: 0x1 linked
// namespace_a474294<file_0>::function_29761697
// Checksum 0x34016e70, Offset: 0xf10
// Size: 0x94
function createballisticknifewatcher() {
    watcher = self weaponobjects::createuseweaponobjectwatcher("knife_ballistic", self.team);
    watcher.onspawn = &onspawn;
    watcher.ondetonatecallback = &weaponobjects::deleteent;
    watcher.onspawnretrievetriggers = &onspawnretrievetrigger;
    watcher.storedifferentobject = 1;
}

