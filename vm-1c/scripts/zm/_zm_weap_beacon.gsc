#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_clone;
#using scripts/zm/_zm_audio;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#using_animtree("zombie_beacon");

#namespace namespace_ba8619ac;

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_c35e6aab
// Checksum 0x7920f28e, Offset: 0x4d0
// Size: 0x16c
function init() {
    level.w_beacon = getweapon("beacon");
    clientfield::register("world", "play_launch_artillery_fx_robot_0", 21000, 1, "int");
    clientfield::register("world", "play_launch_artillery_fx_robot_1", 21000, 1, "int");
    clientfield::register("world", "play_launch_artillery_fx_robot_2", 21000, 1, "int");
    clientfield::register("scriptmover", "play_beacon_fx", 21000, 1, "int");
    clientfield::register("scriptmover", "play_artillery_barrage", 21000, 2, "int");
    level._effect["grenade_samantha_steal"] = "dlc5/zmhd/fx_zombie_couch_effect";
    level.beacons = [];
    level.zombie_weapons_callbacks[level.w_beacon] = &function_5726bda1;
    /#
        level thread function_45216da2();
    #/
}

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_5726bda1
// Checksum 0xc37d65e2, Offset: 0x648
// Size: 0x5c
function function_5726bda1() {
    self giveweapon(level.w_beacon);
    self zm_utility::set_player_tactical_grenade(level.w_beacon);
    self thread function_96588ebe();
}

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_96588ebe
// Checksum 0x590c63b5, Offset: 0x6b0
// Size: 0xf8
function function_96588ebe() {
    self notify(#"hash_a4dda5d0");
    self endon(#"disconnect");
    self endon(#"hash_a4dda5d0");
    attract_dist_diff = level.var_39ecf97c;
    if (!isdefined(attract_dist_diff)) {
        attract_dist_diff = 45;
    }
    num_attractors = level.var_9d4ce622;
    if (!isdefined(num_attractors)) {
        num_attractors = 96;
    }
    max_attract_dist = level.var_7f5c914e;
    if (!isdefined(max_attract_dist)) {
        max_attract_dist = 1536;
    }
    while (true) {
        grenade = function_85b998c7();
        self thread function_bad2cfee(grenade, num_attractors, max_attract_dist, attract_dist_diff);
        wait(0.05);
    }
}

// Namespace namespace_ba8619ac
// Params 2, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_d673d804
// Checksum 0xef5a6e95, Offset: 0x7b0
// Size: 0xdc
function watch_for_dud(model, actor) {
    self endon(#"death");
    self waittill(#"grenade_dud");
    model.dud = 1;
    self.monk_scream_vox = 1;
    wait(3);
    if (isdefined(model)) {
        model delete();
    }
    if (isdefined(actor)) {
        actor delete();
    }
    if (isdefined(self.damagearea)) {
        self.damagearea delete();
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_ba8619ac
// Params 2, eflags: 0x0
// namespace_ba8619ac<file_0>::function_e8b9d8b5
// Checksum 0xc2517402, Offset: 0x898
// Size: 0x1cc
function watch_for_emp(model, actor) {
    self endon(#"death");
    if (!zm_utility::should_watch_for_emp()) {
        return;
    }
    while (true) {
        origin, radius = level waittill(#"emp_detonate");
        if (distancesquared(origin, self.origin) < radius * radius) {
            break;
        }
    }
    self.stun_fx = 1;
    if (isdefined(level._equipment_emp_destroy_fx)) {
        playfx(level._equipment_emp_destroy_fx, self.origin + (0, 0, 5), (0, randomfloat(360), 0));
    }
    wait(0.15);
    self.attract_to_origin = 0;
    self zm_utility::deactivate_zombie_point_of_interest();
    wait(1);
    self detonate();
    wait(1);
    if (isdefined(model)) {
        model delete();
    }
    if (isdefined(actor)) {
        actor delete();
    }
    if (isdefined(self.damagearea)) {
        self.damagearea delete();
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_ba8619ac
// Params 1, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_eddd2027
// Checksum 0xf373dec9, Offset: 0xa70
// Size: 0x50
function clone_player_angles(owner) {
    self endon(#"death");
    owner endon(#"bled_out");
    while (isdefined(self)) {
        self.angles = owner.angles;
        wait(0.05);
    }
}

// Namespace namespace_ba8619ac
// Params 1, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_568ab2ee
// Checksum 0xf4118ad3, Offset: 0xac8
// Size: 0xae
function show_briefly(showtime) {
    self endon(#"show_owner");
    if (isdefined(self.show_for_time)) {
        self.show_for_time = showtime;
        return;
    }
    self.show_for_time = showtime;
    self setvisibletoall();
    while (self.show_for_time > 0) {
        self.show_for_time -= 0.05;
        wait(0.05);
    }
    self setvisibletoallexceptteam(level.zombie_team);
    self.show_for_time = undefined;
}

// Namespace namespace_ba8619ac
// Params 1, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_6f1a957d
// Checksum 0xe29e4179, Offset: 0xb80
// Size: 0x80
function show_owner_on_attack(owner) {
    owner endon(#"hide_owner");
    owner endon(#"show_owner");
    self endon(#"explode");
    self endon(#"death");
    self endon(#"grenade_dud");
    owner.show_for_time = undefined;
    for (;;) {
        owner waittill(#"weapon_fired");
        owner thread show_briefly(0.5);
    }
}

// Namespace namespace_ba8619ac
// Params 1, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_de8ef005
// Checksum 0xec36eb24, Offset: 0xc08
// Size: 0x23c
function hide_owner(owner) {
    self notify(#"hide_owner");
    owner notify(#"hide_owner");
    owner endon(#"hide_owner");
    owner setperk("specialty_immunemms");
    owner.no_burning_sfx = 1;
    owner notify(#"stop_flame_sounds");
    owner setvisibletoallexceptteam(level.zombie_team);
    owner.hide_owner = 1;
    if (isdefined(level._effect["human_disappears"])) {
        playfx(level._effect["human_disappears"], owner.origin);
    }
    self thread show_owner_on_attack(owner);
    evt = self util::waittill_any_return("explode", "death", "grenade_dud", "hide_owner");
    println("play_artillery_barrage" + evt);
    owner notify(#"show_owner");
    owner unsetperk("specialty_immunemms");
    if (isdefined(level._effect["human_disappears"])) {
        playfx(level._effect["human_disappears"], owner.origin);
    }
    owner.no_burning_sfx = undefined;
    owner setvisibletoall();
    owner.hide_owner = undefined;
    owner show();
}

// Namespace namespace_ba8619ac
// Params 1, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_e35ebac3
// Checksum 0x8bd3f3e0, Offset: 0xe50
// Size: 0x26c
function proximity_detonate(owner) {
    wait(1.5);
    if (!isdefined(self)) {
        return;
    }
    detonateradius = 96;
    explosionradius = detonateradius * 2;
    damagearea = spawn("trigger_radius", self.origin + (0, 0, 0 - detonateradius), 4, detonateradius, detonateradius * 1.5);
    damagearea setexcludeteamfortrigger(owner.team);
    damagearea enablelinkto();
    damagearea linkto(self);
    self.damagearea = damagearea;
    while (isdefined(self)) {
        ent = damagearea waittill(#"trigger");
        if (isdefined(owner) && ent == owner) {
            continue;
        }
        if (isdefined(ent.team) && ent.team == owner.team) {
            continue;
        }
        self playsound("wpn_claymore_alert");
        dist = distance(self.origin, ent.origin);
        radiusdamage(self.origin + (0, 0, 12), explosionradius, 1, 1, owner, "MOD_GRENADE_SPLASH", level.w_beacon);
        if (isdefined(owner)) {
            self detonate(owner);
        } else {
            self detonate(undefined);
        }
        break;
    }
    if (isdefined(damagearea)) {
        damagearea delete();
    }
}

// Namespace namespace_ba8619ac
// Params 4, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_bad2cfee
// Checksum 0xba2713de, Offset: 0x10c8
// Size: 0x704
function function_bad2cfee(grenade, num_attractors, max_attract_dist, attract_dist_diff) {
    self endon(#"disconnect");
    self endon(#"hash_a4dda5d0");
    if (isdefined(grenade)) {
        grenade endon(#"death");
        if (self laststand::player_is_in_laststand()) {
            if (isdefined(grenade.damagearea)) {
                grenade.damagearea delete();
            }
            grenade delete();
            return;
        }
        var_65f5946c = (0, 0, 8);
        grenade ghost();
        model = spawn("script_model", grenade.origin + var_65f5946c);
        model endon(#"hash_eeb0f02c");
        model setmodel("wpn_t7_zmb_hd_g_strike_world");
        model useanimtree(#zombie_beacon);
        model linkto(grenade, "", var_65f5946c);
        model.angles = grenade.angles;
        model thread function_4b01a0e0(grenade);
        model.owner = self;
        clone = undefined;
        if (isdefined(level.var_c259064e) && level.var_c259064e) {
            model setvisibletoallexceptteam(level.zombie_team);
            clone = zm_clone::spawn_player_clone(self, (0, 0, -999), level.var_9786fb0e, undefined);
            model.simulacrum = clone;
            clone zm_clone::clone_animate("idle");
            clone thread clone_player_angles(self);
            clone notsolid();
            clone ghost();
        }
        grenade thread watch_for_dud(model, clone);
        info = spawnstruct();
        info.sound_attractors = [];
        grenade waittill(#"stationary");
        if (isdefined(level.grenade_planted)) {
            self thread [[ level.grenade_planted ]](grenade, model);
        }
        if (isdefined(grenade)) {
            if (isdefined(model)) {
                if (!(isdefined(grenade.var_27feb63b) && grenade.var_27feb63b)) {
                    model unlink();
                    model.origin = grenade.origin + var_65f5946c;
                    model.angles = grenade.angles;
                }
            }
            if (isdefined(clone)) {
                clone forceteleport(grenade.origin, grenade.angles);
                clone thread hide_owner(self);
                grenade thread proximity_detonate(self);
                clone show();
                clone setinvisibletoall();
                clone setvisibletoteam(level.zombie_team);
            }
            grenade resetmissiledetonationtime();
            model clientfield::set("play_beacon_fx", 1);
            valid_poi = zm_utility::check_point_in_enabled_zone(grenade.origin, undefined, undefined);
            if (isdefined(level.var_db78371d)) {
                valid_poi = grenade [[ level.var_db78371d ]](valid_poi);
            }
            if (valid_poi) {
                grenade zm_utility::create_zombie_point_of_interest(max_attract_dist, num_attractors, 10000);
                grenade.attract_to_origin = 1;
                grenade thread zm_utility::create_zombie_point_of_interest_attractor_positions(4, attract_dist_diff);
                grenade thread zm_utility::wait_for_attractor_positions_complete();
                grenade thread function_faa88799(model, info);
                model thread wait_and_explode(grenade);
                model thread function_5bed2b9f();
                model.var_97297083 = gettime();
                while (isdefined(level.var_a20c4cb4) && level.var_a20c4cb4) {
                    wait(0.1);
                    continue;
                }
                if (level flag::get("three_robot_round") && level flag::get("fire_link_enabled")) {
                    model thread function_a3a36ae7(grenade);
                } else {
                    model thread function_518079dc(grenade);
                }
                level.beacons[level.beacons.size] = grenade;
            } else {
                grenade.script_noteworthy = undefined;
                level thread grenade_stolen_by_sam(grenade, model, clone);
            }
            return;
        }
        grenade.script_noteworthy = undefined;
        level thread grenade_stolen_by_sam(grenade, model, clone);
    }
}

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_5bed2b9f
// Checksum 0xa32f09f5, Offset: 0x17d8
// Size: 0xb4
function function_5bed2b9f() {
    n_time = getanimlength(zombie_beacon%o_zm_dlc5_zombie_homing_deploy);
    self animscripted("beacon_deploy", self.origin, self.angles, zombie_beacon%o_zm_dlc5_zombie_homing_deploy);
    wait(n_time);
    if (isdefined(self)) {
        self animscripted("beacon_spin", self.origin, self.angles, zombie_beacon%o_zm_dlc5_zombie_homing_spin);
    }
}

// Namespace namespace_ba8619ac
// Params 3, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_aa2bc3cf
// Checksum 0xc314e9fe, Offset: 0x1898
// Size: 0x2ac
function grenade_stolen_by_sam(var_dbce19b3, ent_model, var_29cc71a2) {
    if (!isdefined(ent_model)) {
        return;
    }
    direction = ent_model.origin;
    direction = (direction[1], direction[0], 0);
    if (direction[0] > 0 && (direction[1] < 0 || direction[1] > 0)) {
        direction = (direction[0], direction[1] * -1, 0);
    } else if (direction[0] < 0) {
        direction = (direction[0] * -1, direction[1], 0);
    }
    for (i = 0; i < level.players.size; i++) {
        if (isalive(level.players[i])) {
            level.players[i] playlocalsound(level.zmb_laugh_alias);
        }
    }
    playfxontag(level._effect["grenade_samantha_steal"], ent_model, "tag_origin");
    ent_model movez(60, 1, 0.25, 0.25);
    ent_model vibrate(direction, 1.5, 2.5, 1);
    ent_model waittill(#"movedone");
    if (isdefined(self.damagearea)) {
        self.damagearea delete();
    }
    ent_model delete();
    if (isdefined(var_29cc71a2)) {
        var_29cc71a2 delete();
    }
    if (isdefined(var_dbce19b3)) {
        if (isdefined(var_dbce19b3.damagearea)) {
            var_dbce19b3.damagearea delete();
        }
        var_dbce19b3 delete();
    }
}

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x0
// namespace_ba8619ac<file_0>::function_fdc23c50
// Checksum 0xa5d3f40b, Offset: 0x1b50
// Size: 0x1c
function wait_for_attractor_positions_complete() {
    self waittill(#"attractor_positions_generated");
    self.attract_to_origin = 0;
}

// Namespace namespace_ba8619ac
// Params 1, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_4b01a0e0
// Checksum 0xe5511937, Offset: 0x1b78
// Size: 0x8c
function function_4b01a0e0(parent) {
    while (true) {
        if (!isdefined(parent)) {
            if (isdefined(self.dud) && isdefined(self) && self.dud) {
                wait(6);
            }
            if (isdefined(self.simulacrum)) {
                self.simulacrum delete();
            }
            zm_utility::self_delete();
            return;
        }
        wait(0.05);
    }
}

// Namespace namespace_ba8619ac
// Params 2, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_faa88799
// Checksum 0x185ebf16, Offset: 0x1c10
// Size: 0x234
function function_faa88799(model, info) {
    self.monk_scream_vox = 0;
    if (isdefined(level.grenade_safe_to_bounce)) {
        if (![[ level.grenade_safe_to_bounce ]](self.owner, level.w_beacon)) {
            self.monk_scream_vox = 1;
        }
    }
    if (!self.monk_scream_vox && !(isdefined(level.var_5738e0e5) && level.var_5738e0e5)) {
        if (isdefined(level.var_c259064e) && level.var_c259064e) {
            self playsoundtoteam("null", "allies");
        } else {
            self playsound("null");
        }
    }
    if (!self.monk_scream_vox) {
        self thread play_delayed_explode_vox();
    }
    position = self waittill(#"hash_de9fc9a9");
    level notify(#"grenade_exploded", position, 100, 5000, 450);
    var_f26b4518 = -1;
    for (i = 0; i < level.beacons.size; i++) {
        if (!isdefined(level.beacons[i])) {
            var_f26b4518 = i;
            break;
        }
    }
    if (var_f26b4518 >= 0) {
        arrayremoveindex(level.beacons, var_f26b4518);
    }
    for (i = 0; i < info.sound_attractors.size; i++) {
        if (isdefined(info.sound_attractors[i])) {
            info.sound_attractors[i] notify(#"hash_b38dbb5e");
        }
    }
    self delete();
}

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_e76160f8
// Checksum 0xde401303, Offset: 0x1e50
// Size: 0x14
function play_delayed_explode_vox() {
    wait(6.5);
    if (isdefined(self)) {
    }
}

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_85b998c7
// Checksum 0xf16a9000, Offset: 0x1e70
// Size: 0x94
function function_85b998c7() {
    self endon(#"disconnect");
    self endon(#"hash_a4dda5d0");
    while (true) {
        grenade, weapon = self waittill(#"grenade_fire");
        if (weapon == level.w_beacon) {
            grenade.use_grenade_special_long_bookmark = 1;
            grenade.grenade_multiattack_bookmark_count = 1;
            return grenade;
        }
        wait(0.05);
    }
}

// Namespace namespace_ba8619ac
// Params 1, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_d5f2e4be
// Checksum 0x87c66e1b, Offset: 0x1f10
// Size: 0x60
function wait_and_explode(grenade) {
    self endon(#"hash_b8437d8e");
    position = grenade waittill(#"explode");
    self notify(#"hash_eeb0f02c");
    if (isdefined(grenade)) {
        grenade notify(#"hash_de9fc9a9", self.origin);
    }
}

// Namespace namespace_ba8619ac
// Params 1, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_518079dc
// Checksum 0x9624a788, Offset: 0x1f78
// Size: 0x168
function function_518079dc(grenade) {
    self endon(#"hash_eeb0f02c");
    var_d2b126c7 = undefined;
    while (!isdefined(var_d2b126c7)) {
        for (i = 0; i < 3; i++) {
            if (isdefined(level.var_64f7be48[i].var_614b2431) && level.var_64f7be48[i].var_614b2431) {
                if (!(isdefined(level.var_64f7be48[i].var_eeb7cc65) && level.var_64f7be48[i].var_eeb7cc65)) {
                    var_d2b126c7 = level.var_64f7be48[i];
                    self thread function_29381f5(var_d2b126c7, grenade);
                    self notify(#"hash_b8437d8e");
                    level.var_a20c4cb4 = 1;
                    grenade.var_6370145a = 1;
                    grenade.fuse_time = 100;
                    grenade resetmissiledetonationtime(100);
                    break;
                }
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_ba8619ac
// Params 1, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_a3a36ae7
// Checksum 0x295ee644, Offset: 0x20e8
// Size: 0x22c
function function_a3a36ae7(grenade) {
    self endon(#"hash_eeb0f02c");
    var_d2b126c7 = undefined;
    n_index = 0;
    var_f63431f6 = [];
    var_f63431f6[0] = 1;
    var_f63431f6[1] = 0;
    var_f63431f6[2] = 2;
    while (n_index < var_f63431f6.size) {
        var_27f11bd5 = var_f63431f6[n_index];
        if (isdefined(level.var_64f7be48[var_27f11bd5].var_614b2431) && level.var_64f7be48[var_27f11bd5].var_614b2431) {
            if (!(isdefined(level.var_64f7be48[var_27f11bd5].var_eeb7cc65) && level.var_64f7be48[var_27f11bd5].var_eeb7cc65)) {
                var_d2b126c7 = level.var_64f7be48[var_27f11bd5];
                self thread function_9234f6f2(var_d2b126c7, grenade);
                self notify(#"hash_b8437d8e");
                level.var_a20c4cb4 = 1;
                grenade.var_6370145a = 1;
                grenade.fuse_time = 100;
                grenade resetmissiledetonationtime(100);
                wait(2);
                n_index++;
            }
        } else if (n_index == 0) {
            if (!level flag::get("three_robot_round")) {
                self thread function_518079dc(grenade);
                break;
            }
        } else if (n_index > 0) {
            break;
        }
        wait(0.1);
    }
    self thread function_8fb06e7f(grenade, 1);
}

// Namespace namespace_ba8619ac
// Params 2, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_29381f5
// Checksum 0x21985a45, Offset: 0x2320
// Size: 0xe4
function function_29381f5(var_d2b126c7, grenade) {
    var_d2b126c7.var_eeb7cc65 = 1;
    level clientfield::set("play_launch_artillery_fx_robot_" + var_d2b126c7.var_582adcd3, 1);
    self thread function_4eab201a();
    wait(0.5);
    if (isdefined(var_d2b126c7)) {
        level clientfield::set("play_launch_artillery_fx_robot_" + var_d2b126c7.var_582adcd3, 0);
        wait(3);
        self thread function_8fb06e7f(grenade);
        wait(1);
        var_d2b126c7.var_eeb7cc65 = 0;
    }
}

// Namespace namespace_ba8619ac
// Params 2, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_9234f6f2
// Checksum 0x80efa85b, Offset: 0x2410
// Size: 0xe4
function function_9234f6f2(var_d2b126c7, grenade) {
    var_d2b126c7.var_eeb7cc65 = 1;
    var_d2b126c7 playsound("zmb_homingbeacon_missiile_alarm");
    level clientfield::set("play_launch_artillery_fx_robot_" + var_d2b126c7.var_582adcd3, 1);
    self thread function_4eab201a();
    wait(0.5);
    if (isdefined(var_d2b126c7)) {
        level clientfield::set("play_launch_artillery_fx_robot_" + var_d2b126c7.var_582adcd3, 0);
    }
    wait(1);
    var_d2b126c7.var_eeb7cc65 = 0;
}

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_4eab201a
// Checksum 0xa9047e8d, Offset: 0x2500
// Size: 0x8c
function function_4eab201a() {
    if (isdefined(self.owner) && isplayer(self.owner)) {
        n_time = gettime();
        if (isdefined(self.var_97297083)) {
            if (n_time < self.var_97297083 + 3000) {
                self.owner zm_audio::create_and_play_dialog("general", "use_beacon");
            }
        }
    }
}

// Namespace namespace_ba8619ac
// Params 2, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_8fb06e7f
// Checksum 0x7243bf56, Offset: 0x2598
// Size: 0x2cc
function function_8fb06e7f(grenade, var_99333052) {
    if (!isdefined(var_99333052)) {
        var_99333052 = 0;
    }
    if (isdefined(var_99333052) && var_99333052) {
        var_6357a0d6 = self function_8752cc8a();
        var_14202479 = self function_a6461985();
        var_ecb43f9c = 15;
        n_clientfield = 2;
    } else {
        var_6357a0d6 = self function_2978ee2d();
        var_14202479 = self function_14e104a0();
        var_ecb43f9c = 5;
        n_clientfield = 1;
    }
    self.var_33a39fb9 = [];
    self.var_5a8f2256 = [];
    for (i = 0; i < var_ecb43f9c; i++) {
        self.var_5a8f2256[i] = self.origin + var_14202479[i];
        self.var_33a39fb9[i] = self.origin + var_6357a0d6[i];
        var_671ea392 = self.var_5a8f2256[i] - (0, 0, 5000);
        trace = bullettrace(var_671ea392, self.var_33a39fb9[i], 0, undefined);
        self.var_33a39fb9[i] = trace["position"];
        wait(0.05);
    }
    for (i = 0; i < var_ecb43f9c; i++) {
        self clientfield::set("play_artillery_barrage", n_clientfield);
        self thread function_1799dd36(i);
        util::wait_network_frame();
        self clientfield::set("play_artillery_barrage", 0);
        if (i == 0) {
            wait(1);
            continue;
        }
        wait(0.25);
    }
    level thread function_eaffab54();
    wait(6);
    grenade notify(#"hash_de9fc9a9", self.origin);
}

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_eaffab54
// Checksum 0x3241c1f9, Offset: 0x2870
// Size: 0x18
function function_eaffab54() {
    wait(3);
    level.var_a20c4cb4 = 0;
}

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_2978ee2d
// Checksum 0x8852ef93, Offset: 0x2890
// Size: 0x88
function function_2978ee2d() {
    var_a6604bff = [];
    var_a6604bff[0] = (0, 0, 0);
    var_a6604bff[1] = (-72, 72, 0);
    var_a6604bff[2] = (72, 72, 0);
    var_a6604bff[3] = (72, -72, 0);
    var_a6604bff[4] = (-72, -72, 0);
    return var_a6604bff;
}

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_14e104a0
// Checksum 0x3519b2bf, Offset: 0x2920
// Size: 0x96
function function_14e104a0() {
    var_a6604bff = [];
    var_a6604bff[0] = (0, 0, 8500);
    var_a6604bff[1] = (-6500, 6500, 8500);
    var_a6604bff[2] = (6500, 6500, 8500);
    var_a6604bff[3] = (6500, -6500, 8500);
    var_a6604bff[4] = (-6500, -6500, 8500);
    return var_a6604bff;
}

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_8752cc8a
// Checksum 0xebaff4e4, Offset: 0x29c0
// Size: 0x178
function function_8752cc8a() {
    var_a6604bff = [];
    var_a6604bff[0] = (0, 0, 0);
    var_a6604bff[1] = (-72, 72, 0);
    var_a6604bff[2] = (72, 72, 0);
    var_a6604bff[3] = (72, -72, 0);
    var_a6604bff[4] = (-72, -72, 0);
    var_a6604bff[5] = (-72, 72, 0);
    var_a6604bff[6] = (72, 72, 0);
    var_a6604bff[7] = (72, -72, 0);
    var_a6604bff[8] = (-72, -72, 0);
    var_a6604bff[9] = (-72, 72, 0);
    var_a6604bff[10] = (72, 72, 0);
    var_a6604bff[11] = (72, -72, 0);
    var_a6604bff[12] = (-72, -72, 0);
    var_a6604bff[13] = (-72, 72, 0);
    var_a6604bff[14] = (72, 72, 0);
    return var_a6604bff;
}

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_a6461985
// Checksum 0xb7e5d2c1, Offset: 0x2b40
// Size: 0x19a
function function_a6461985() {
    var_a6604bff = [];
    var_a6604bff[0] = (0, 0, 8500);
    var_a6604bff[1] = (-6500, 6500, 8500);
    var_a6604bff[2] = (6500, 6500, 8500);
    var_a6604bff[3] = (6500, -6500, 8500);
    var_a6604bff[4] = (-6500, -6500, 8500);
    var_a6604bff[5] = (-6500, 6500, 8500);
    var_a6604bff[6] = (6500, 6500, 8500);
    var_a6604bff[7] = (6500, -6500, 8500);
    var_a6604bff[8] = (-6500, -6500, 8500);
    var_a6604bff[9] = (-6500, 6500, 8500);
    var_a6604bff[10] = (6500, 6500, 8500);
    var_a6604bff[11] = (6500, -6500, 8500);
    var_a6604bff[12] = (-6500, -6500, 8500);
    var_a6604bff[13] = (-6500, 6500, 8500);
    var_a6604bff[14] = (6500, 6500, 8500);
    return var_a6604bff;
}

// Namespace namespace_ba8619ac
// Params 1, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_1799dd36
// Checksum 0xcab8ada, Offset: 0x2ce8
// Size: 0x2a4
function function_1799dd36(index) {
    wait(3);
    var_46043680 = self.var_33a39fb9[index];
    level.var_ccb968ec = 0;
    var_7aa21f35 = [];
    a_zombies = getaispeciesarray("axis", "all");
    foreach (zombie in a_zombies) {
        n_distance = distance(zombie.origin, var_46043680);
        if (n_distance <= -56) {
            n_damage = math::linear_map(n_distance, -56, 0, 7000, 8000);
            if (n_damage >= zombie.health) {
                var_7aa21f35[var_7aa21f35.size] = zombie;
                continue;
            }
            zombie thread function_6fb1ac4a();
            zombie dodamage(n_damage, zombie.origin, self.owner, self.owner, "none", "MOD_GRENADE_SPLASH", 0, level.w_beacon);
        }
    }
    if (index == 0) {
        radiusdamage(self.origin + (0, 0, 12), 10, 1, 1, self.owner, "MOD_GRENADE_SPLASH", level.w_beacon);
        self ghost();
        self stopanimscripted(0);
    }
    level thread function_2d277b01(self, var_7aa21f35);
    self thread function_ca385d0f();
}

// Namespace namespace_ba8619ac
// Params 2, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_2d277b01
// Checksum 0x9eed7b5a, Offset: 0x2f98
// Size: 0x14e
function function_2d277b01(model, var_7aa21f35) {
    n_interval = 0;
    for (i = 0; i < var_7aa21f35.size; i++) {
        zombie = var_7aa21f35[i];
        if (!isdefined(zombie) || !isalive(zombie)) {
            continue;
        }
        zombie thread function_6fb1ac4a();
        zombie dodamage(zombie.health, zombie.origin, model.owner, model.owner, "none", "MOD_GRENADE_SPLASH", 0, level.w_beacon);
        n_interval++;
        zombie thread function_54370306();
        if (n_interval >= 4) {
            util::wait_network_frame();
            n_interval = 0;
        }
    }
}

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_54370306
// Checksum 0x2ef9c21f, Offset: 0x30f0
// Size: 0x184
function function_54370306() {
    if (isdefined(self.is_mechz) && self.is_mechz) {
        return;
    }
    if (isdefined(self.var_7b846142) && self.var_7b846142) {
        return;
    }
    if (level.var_ccb968ec >= 5) {
        return;
    }
    level.var_ccb968ec++;
    if (isdefined(level.var_cfba6d83) && ![[ level.var_cfba6d83 ]]()) {
        level thread function_4d8edd06(self);
        return;
    }
    self startragdoll();
    n_x = randomintrange(50, -106);
    n_y = randomintrange(50, -106);
    if (math::cointoss()) {
        n_x *= -1;
    }
    if (math::cointoss()) {
        n_y *= -1;
    }
    v_launch = (n_x, n_y, randomintrange(75, -6));
    self launchragdoll(v_launch);
}

// Namespace namespace_ba8619ac
// Params 1, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_4d8edd06
// Checksum 0x454a3fc0, Offset: 0x3280
// Size: 0x4c
function function_4d8edd06(ai_zombie) {
    var_8c74d8bb = [];
    var_8c74d8bb[0] = level._zombie_gib_piece_index_all;
    ai_zombie gib("normal", var_8c74d8bb);
}

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_ca385d0f
// Checksum 0xbe7aa98b, Offset: 0x32d8
// Size: 0xf2
function function_ca385d0f() {
    a_players = getplayers();
    foreach (player in a_players) {
        if (isalive(player) && isdefined(player)) {
            if (distance2dsquared(player.origin, self.origin) < 250000) {
                player thread function_7086da57();
            }
        }
    }
}

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_7086da57
// Checksum 0xcee3c05b, Offset: 0x33d8
// Size: 0x6c
function function_7086da57() {
    self endon(#"death");
    self endon(#"disconnect");
    self clientfield::set_to_player("player_rumble_and_shake", 3);
    util::wait_network_frame();
    self clientfield::set_to_player("player_rumble_and_shake", 0);
}

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_6fb1ac4a
// Checksum 0xbb6090f4, Offset: 0x3450
// Size: 0x30
function function_6fb1ac4a() {
    self endon(#"death");
    self.var_6fb1ac4a = 1;
    wait(0.05);
    self.var_6fb1ac4a = 0;
}

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_45216da2
// Checksum 0xa4f6d6ec, Offset: 0x3488
// Size: 0x3c
function function_45216da2() {
    level thread function_72260d3a("ZM/Weapons/Offhand/Give Beacon", "give_beacon", 4, &function_eeb65596);
}

// Namespace namespace_ba8619ac
// Params 5, eflags: 0x5 linked
// namespace_ba8619ac<file_0>::function_72260d3a
// Checksum 0x1c1ec45c, Offset: 0x34d0
// Size: 0x120
function private function_72260d3a(var_2fa24527, str_dvar, n_value, func, var_f0ee45c9) {
    if (!isdefined(var_f0ee45c9)) {
        var_f0ee45c9 = -1;
    }
    setdvar(str_dvar, var_f0ee45c9);
    adddebugcommand("devgui_cmd \"" + var_2fa24527 + "\" \"" + str_dvar + " " + n_value + "\"\n");
    while (true) {
        var_608d58e3 = getdvarint(str_dvar);
        if (var_608d58e3 > var_f0ee45c9) {
            [[ func ]](var_608d58e3);
            setdvar(str_dvar, var_f0ee45c9);
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_ba8619ac
// Params 1, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_eeb65596
// Checksum 0x9626ddf6, Offset: 0x35f8
// Size: 0xd2
function function_eeb65596(n_player_index) {
    players = getplayers();
    foreach (player in players) {
        player takeweapon(level.w_beacon);
        player zm_weapons::weapon_give(level.w_beacon);
    }
}

