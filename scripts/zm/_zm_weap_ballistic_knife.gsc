#using scripts/zm/_zm_stats;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_d5fba823;

// Namespace namespace_d5fba823
// Params 0, eflags: 0x0
// Checksum 0x9d4d6aeb, Offset: 0x198
// Size: 0x1c
function init() {
    if (!isdefined(level.var_2547ba72)) {
        level.var_2547ba72 = 1;
    }
}

// Namespace namespace_d5fba823
// Params 2, eflags: 0x1 linked
// Checksum 0x2cbfacf8, Offset: 0x1c0
// Size: 0x354
function on_spawn(watcher, player) {
    player endon(#"death");
    player endon(#"disconnect");
    player endon(#"hash_987c489b");
    level endon(#"game_ended");
    endpos, normal, angles, attacker, prey, bone = self waittill(#"stationary");
    isfriendly = 0;
    if (isdefined(endpos)) {
        retrievable_model = spawn("script_model", endpos);
        retrievable_model setmodel("t6_wpn_ballistic_knife_projectile");
        retrievable_model setowner(player);
        retrievable_model.owner = player;
        retrievable_model.angles = angles;
        retrievable_model.weapon = watcher.weapon;
        if (isdefined(prey)) {
            if (isplayer(prey) && player.team == prey.team) {
                isfriendly = 1;
            } else if (isai(prey) && player.team == prey.team) {
                isfriendly = 1;
            }
            if (!isfriendly) {
                retrievable_model linkto(prey, bone);
                retrievable_model thread function_ae011034(player, prey);
            } else if (isfriendly) {
                retrievable_model physicslaunch(normal, (randomint(10), randomint(10), randomint(10)));
                normal = (0, 0, 1);
            }
        }
        watcher.objectarray[watcher.objectarray.size] = retrievable_model;
        if (isfriendly) {
            retrievable_model waittill(#"stationary");
        }
        retrievable_model thread function_c6372501(player);
        if (isfriendly) {
            player notify(#"ballistic_knife_stationary", retrievable_model, normal);
        } else {
            player notify(#"ballistic_knife_stationary", retrievable_model, normal, prey);
        }
        retrievable_model thread function_9830e7bc(prey);
    }
}

// Namespace namespace_d5fba823
// Params 1, eflags: 0x1 linked
// Checksum 0xa37d9a67, Offset: 0x520
// Size: 0x44
function function_9830e7bc(prey) {
    level endon(#"game_ended");
    self endon(#"death");
    wait(2);
    self setmodel("t6_wpn_ballistic_knife_projectile");
}

// Namespace namespace_d5fba823
// Params 2, eflags: 0x1 linked
// Checksum 0x449804a3, Offset: 0x570
// Size: 0x454
function on_spawn_retrieve_trigger(watcher, player) {
    player endon(#"death");
    player endon(#"disconnect");
    player endon(#"hash_987c489b");
    level endon(#"game_ended");
    retrievable_model, normal, prey = player waittill(#"ballistic_knife_stationary");
    if (!isdefined(retrievable_model)) {
        return;
    }
    trigger_pos = [];
    if (isplayer(prey) || isdefined(prey) && isai(prey)) {
        trigger_pos[0] = prey.origin[0];
        trigger_pos[1] = prey.origin[1];
        trigger_pos[2] = prey.origin[2] + 10;
    } else {
        trigger_pos[0] = retrievable_model.origin[0] + 10 * normal[0];
        trigger_pos[1] = retrievable_model.origin[1] + 10 * normal[1];
        trigger_pos[2] = retrievable_model.origin[2] + 10 * normal[2];
    }
    if (isdefined(level.var_2547ba72) && level.var_2547ba72) {
        trigger_pos[2] = trigger_pos[2] - 50;
        var_9dbe9414 = spawn("trigger_radius", (trigger_pos[0], trigger_pos[1], trigger_pos[2]), 0, 50, 100);
    } else {
        var_9dbe9414 = spawn("trigger_radius_use", (trigger_pos[0], trigger_pos[1], trigger_pos[2]));
        var_9dbe9414 setcursorhint("HINT_NOICON");
    }
    var_9dbe9414.owner = player;
    retrievable_model.var_a7c7bd14 = var_9dbe9414;
    hint_string = %WEAPON_BALLISTIC_KNIFE_PICKUP;
    if (isdefined(hint_string)) {
        var_9dbe9414 sethintstring(hint_string);
    } else {
        var_9dbe9414 sethintstring(%GENERIC_PICKUP);
    }
    var_9dbe9414 setteamfortrigger(player.team);
    player clientclaimtrigger(var_9dbe9414);
    var_9dbe9414 enablelinkto();
    if (isdefined(prey)) {
        var_9dbe9414 linkto(prey);
    } else {
        var_9dbe9414 linkto(retrievable_model);
    }
    if (isdefined(level.var_b33b8405)) {
        [[ level.var_b33b8405 ]](retrievable_model, var_9dbe9414, prey);
    }
    retrievable_model thread function_35579833(var_9dbe9414, retrievable_model, &pick_up, watcher.weapon, watcher.pickupsoundplayer, watcher.pickupsound);
    player thread watch_shutdown(var_9dbe9414, retrievable_model);
}

/#

    // Namespace namespace_d5fba823
    // Params 1, eflags: 0x0
    // Checksum 0x14729f32, Offset: 0x9d0
    // Size: 0x48
    function debug_print(endpos) {
        self endon(#"death");
        while (true) {
            print3d(endpos, "zmb_lost_knife");
            wait(0.05);
        }
    }

#/

// Namespace namespace_d5fba823
// Params 6, eflags: 0x1 linked
// Checksum 0x8396dddf, Offset: 0xa20
// Size: 0x350
function function_35579833(trigger, model, callback, weapon, playersoundonuse, npcsoundonuse) {
    self endon(#"death");
    self endon(#"delete");
    level endon(#"game_ended");
    max_ammo = weapon.maxammo + 1;
    var_462338e8 = isdefined(level.var_2547ba72) && level.var_2547ba72;
    while (true) {
        player = trigger waittill(#"trigger");
        if (!isalive(player)) {
            continue;
        }
        if (!player isonground() && !(isdefined(trigger.var_de9cafd) && trigger.var_de9cafd)) {
            continue;
        }
        if (isdefined(trigger.triggerteam) && player.team != trigger.triggerteam) {
            continue;
        }
        if (isdefined(trigger.claimedby) && player != trigger.claimedby) {
            continue;
        }
        var_f9d374f8 = player getweaponammostock(weapon);
        var_b58eae98 = player getweaponammoclip(weapon);
        current_weapon = player getcurrentweapon();
        total_ammo = var_f9d374f8 + var_b58eae98;
        var_34eba11f = 1;
        if (total_ammo > 0 && var_f9d374f8 == total_ammo && current_weapon == weapon) {
            var_34eba11f = 0;
        }
        if (total_ammo >= max_ammo || !var_34eba11f) {
            continue;
        }
        if (isdefined(trigger.var_de9cafd) && (player usebuttonpressed() && !player.throwinggrenade && (var_462338e8 || !player meleebuttonpressed()) || trigger.var_de9cafd)) {
            if (isdefined(playersoundonuse)) {
                player playlocalsound(playersoundonuse);
            }
            if (isdefined(npcsoundonuse)) {
                player playsound(npcsoundonuse);
            }
            player thread [[ callback ]](weapon, model, trigger);
            break;
        }
    }
}

// Namespace namespace_d5fba823
// Params 3, eflags: 0x1 linked
// Checksum 0x9d254968, Offset: 0xd78
// Size: 0x1b4
function pick_up(weapon, model, trigger) {
    if (self hasweapon(weapon)) {
        current_weapon = self getcurrentweapon();
        if (current_weapon != weapon) {
            clip_ammo = self getweaponammoclip(weapon);
            if (!clip_ammo) {
                self setweaponammoclip(weapon, 1);
            } else {
                var_e728627d = self getweaponammostock(weapon) + 1;
                self setweaponammostock(weapon, var_e728627d);
            }
        } else {
            var_e728627d = self getweaponammostock(weapon) + 1;
            self setweaponammostock(weapon, var_e728627d);
        }
    }
    self zm_stats::increment_client_stat("ballistic_knives_pickedup");
    self zm_stats::increment_player_stat("ballistic_knives_pickedup");
    model destroy_ent();
    trigger destroy_ent();
}

// Namespace namespace_d5fba823
// Params 0, eflags: 0x1 linked
// Checksum 0xbf0dd262, Offset: 0xf38
// Size: 0x4c
function destroy_ent() {
    if (isdefined(self)) {
        if (isdefined(self.var_ceaf3848)) {
            self.var_ceaf3848 delete();
        }
        self delete();
    }
}

// Namespace namespace_d5fba823
// Params 2, eflags: 0x1 linked
// Checksum 0x76ed68ab, Offset: 0xf90
// Size: 0x74
function watch_shutdown(trigger, model) {
    self util::waittill_any("death", "disconnect", "zmb_lost_knife");
    trigger destroy_ent();
    model destroy_ent();
}

// Namespace namespace_d5fba823
// Params 1, eflags: 0x1 linked
// Checksum 0x6260a55a, Offset: 0x1010
// Size: 0xb0
function function_c6372501(player) {
    player endon(#"death");
    player endon(#"hash_987c489b");
    for (;;) {
        origin, radius = level waittill(#"drop_objects_to_ground");
        if (distancesquared(origin, self.origin) < radius * radius) {
            self physicslaunch((0, 0, 1), (5, 5, 5));
            self thread function_963df1d8(player);
        }
    }
}

// Namespace namespace_d5fba823
// Params 2, eflags: 0x1 linked
// Checksum 0xa9ccb7d4, Offset: 0x10c8
// Size: 0x8c
function function_ae011034(player, prey) {
    self endon(#"death");
    player endon(#"hash_987c489b");
    prey waittill(#"death");
    self unlink();
    self physicslaunch((0, 0, 1), (5, 5, 5));
    self thread function_963df1d8(player);
}

// Namespace namespace_d5fba823
// Params 1, eflags: 0x1 linked
// Checksum 0x54f633ab, Offset: 0x1160
// Size: 0xbc
function function_963df1d8(player) {
    self endon(#"death");
    player endon(#"hash_987c489b");
    if (isdefined(level.var_b7b04aa6)) {
        self [[ level.var_b7b04aa6 ]](player);
        return;
    }
    self waittill(#"stationary");
    trigger = self.var_a7c7bd14;
    trigger.origin = (self.origin[0], self.origin[1], self.origin[2] + 10);
    trigger linkto(self);
}

