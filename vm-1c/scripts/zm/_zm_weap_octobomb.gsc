#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/zm/_zm_clone;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;

#namespace _zm_weap_octobomb;

// Namespace _zm_weap_octobomb
// Params 0, eflags: 0x2
// Checksum 0x51ace1ea, Offset: 0x628
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_weap_octobomb", &__init__, &__main__, undefined);
}

// Namespace _zm_weap_octobomb
// Params 0, eflags: 0x0
// Checksum 0x4dfb5d0, Offset: 0x670
// Size: 0x13c
function __init__() {
    clientfield::register("scriptmover", "octobomb_fx", 1, 2, "int");
    clientfield::register("actor", "octobomb_spores_fx", 1, 2, "int");
    clientfield::register("actor", "octobomb_tentacle_hit_fx", 1, 1, "int");
    clientfield::register("actor", "octobomb_zombie_explode_fx", 8000, 1, "counter");
    clientfield::register("toplayer", "octobomb_state", 1, 3, "int");
    clientfield::register("missile", "octobomb_spit_fx", 1, 2, "int");
    /#
        level thread function_60df0cfd();
    #/
}

// Namespace _zm_weap_octobomb
// Params 0, eflags: 0x0
// Checksum 0xf33bb175, Offset: 0x7b8
// Size: 0xe0
function __main__() {
    level.var_90b60862 = getweapon("octobomb");
    level.var_5327e29d = getweapon("octobomb_upgraded");
    level.var_ecd8678c = "p7_fxanim_zm_zod_octobomb_mod";
    if (!function_4ffaebc7()) {
        return;
    }
    level._effect["grenade_samantha_steal"] = "zombie/fx_monkey_lightning_zmb";
    zm_weapons::register_zombie_weapon_callback(level.var_90b60862, &function_82e4a388);
    zm_weapons::register_zombie_weapon_callback(level.var_5327e29d, &function_ae90088b);
    level.var_9baa9723 = [];
}

// Namespace _zm_weap_octobomb
// Params 0, eflags: 0x0
// Checksum 0x66860b28, Offset: 0x8a0
// Size: 0x24
function function_ae90088b() {
    self function_82e4a388("octobomb_upgraded");
}

// Namespace _zm_weap_octobomb
// Params 1, eflags: 0x0
// Checksum 0x6bbe70ae, Offset: 0x8d0
// Size: 0xdc
function function_82e4a388(str_weapon) {
    if (!isdefined(str_weapon)) {
        str_weapon = "octobomb";
    }
    var_8f3e38cc = self zm_utility::get_player_tactical_grenade();
    if (isdefined(var_8f3e38cc)) {
        self takeweapon(var_8f3e38cc);
    }
    w_weapon = getweapon(str_weapon);
    self giveweapon(w_weapon);
    self zm_utility::set_player_tactical_grenade(w_weapon);
    self thread function_964187bf();
}

// Namespace _zm_weap_octobomb
// Params 0, eflags: 0x0
// Checksum 0xbc22068e, Offset: 0x9b8
// Size: 0xf8
function function_964187bf() {
    self notify(#"hash_69fff51d");
    self endon(#"death");
    self endon(#"hash_69fff51d");
    var_dcb46b6f = level.var_9d3f923d;
    if (!isdefined(var_dcb46b6f)) {
        var_dcb46b6f = 10;
    }
    num_attractors = level.var_f033bae1;
    if (!isdefined(num_attractors)) {
        num_attractors = 64;
    }
    max_attract_dist = level.var_bc88d0f9;
    if (!isdefined(max_attract_dist)) {
        max_attract_dist = 1024;
    }
    while (true) {
        e_grenade = function_9e041fe();
        if (isdefined(e_grenade)) {
            self thread function_f2ee3a8f(e_grenade, num_attractors, max_attract_dist, var_dcb46b6f);
        }
    }
}

// Namespace _zm_weap_octobomb
// Params 1, eflags: 0x0
// Checksum 0x1dc08bc5, Offset: 0xab8
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
        wait 0.05;
    }
    self setvisibletoallexceptteam(level.zombie_team);
    self.show_for_time = undefined;
}

// Namespace _zm_weap_octobomb
// Params 1, eflags: 0x0
// Checksum 0x6eb61a86, Offset: 0xb70
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

// Namespace _zm_weap_octobomb
// Params 1, eflags: 0x0
// Checksum 0x3f16585c, Offset: 0xbf8
// Size: 0x22c
function hide_owner(owner) {
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
    evt = self util::function_183e3618("explode", "death", "grenade_dud", owner, "hide_owner");
    println("<dev string:x28>" + evt);
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

// Namespace _zm_weap_octobomb
// Params 1, eflags: 0x0
// Checksum 0xcad41153, Offset: 0xe30
// Size: 0x80
function fakelinkto(var_968690f) {
    self notify(#"fakelinkto");
    self endon(#"fakelinkto");
    self.var_27feb63b = 1;
    while (isdefined(self) && isdefined(var_968690f)) {
        self.origin = var_968690f.origin;
        self.angles = var_968690f.angles;
        wait 0.05;
    }
}

// Namespace _zm_weap_octobomb
// Params 2, eflags: 0x0
// Checksum 0xf1b25d27, Offset: 0xeb8
// Size: 0x184
function grenade_planted(grenade, model) {
    var_e97bad1e = undefined;
    grenade.ground_ent = grenade getgroundent();
    if (isdefined(grenade.ground_ent)) {
        if (isvehicle(grenade.ground_ent) && !(level.zombie_team === grenade.ground_ent)) {
            var_e97bad1e = grenade.ground_ent;
        }
    }
    if (isdefined(var_e97bad1e)) {
        if (isdefined(grenade)) {
            grenade setmovingplatformenabled(1);
            grenade.var_d8519a4 = 1;
            grenade.var_fb197c56 = 1;
            grenade.var_a55f2e89 = var_e97bad1e;
            if (isdefined(model)) {
                model setmovingplatformenabled(1);
                model linkto(var_e97bad1e);
                model.var_fb197c56 = 1;
                grenade fakelinkto(model);
            }
        }
    }
}

// Namespace _zm_weap_octobomb
// Params 0, eflags: 0x0
// Checksum 0xacd4817c, Offset: 0x1048
// Size: 0x74
function function_ca9c42b2() {
    self endon(#"death");
    if (self zm_zonemgr::entity_in_zone("zone_train_rail")) {
        while (!level.var_292a0ac9 flag::get("moving")) {
            wait 0.05;
            continue;
        }
        self detonate();
    }
}

// Namespace _zm_weap_octobomb
// Params 4, eflags: 0x0
// Checksum 0xe43c1baf, Offset: 0x10c8
// Size: 0x61c
function function_f2ee3a8f(e_grenade, num_attractors, max_attract_dist, var_dcb46b6f) {
    self endon(#"hash_69fff51d");
    e_grenade endon(#"death");
    if (self laststand::player_is_in_laststand()) {
        if (isdefined(e_grenade.damagearea)) {
            e_grenade.damagearea delete();
        }
        e_grenade delete();
        return;
    }
    var_68e59e30 = self.angles + (90, 0, 90);
    var_1b106cd2 = self.angles - (0, 90, 0);
    is_upgraded = e_grenade.weapon == level.var_5327e29d;
    if (is_upgraded) {
        var_df02f4b3 = 2;
    } else {
        var_df02f4b3 = 1;
    }
    e_grenade ghost();
    e_grenade.angles = var_68e59e30;
    e_grenade.var_499ed1ba = util::spawn_model(e_grenade.model, e_grenade.origin, e_grenade.angles);
    e_grenade.var_499ed1ba linkto(e_grenade);
    e_grenade thread function_76874e09();
    e_grenade waittill(#"stationary", v_position, v_normal);
    e_grenade thread function_ca9c42b2();
    self thread grenade_planted(e_grenade, e_grenade.var_499ed1ba);
    e_grenade resetmissiledetonationtime();
    e_grenade is_on_navmesh();
    var_d80ab647 = zm_utility::check_point_in_enabled_zone(e_grenade.origin, undefined, undefined);
    if (isdefined(level.var_3b03b43a)) {
        var_d80ab647 = e_grenade [[ level.var_3b03b43a ]](var_d80ab647);
    }
    if (var_d80ab647 && e_grenade.var_307512ca) {
        if (isdefined(level.var_a579e2fb) && isfunctionptr(level.var_a579e2fb)) {
            [[ level.var_a579e2fb ]](e_grenade);
        }
        e_grenade function_704217d1();
        e_grenade zm_utility::create_zombie_point_of_interest(max_attract_dist, num_attractors, 10000);
        e_grenade thread zm_utility::create_zombie_point_of_interest_attractor_positions(4, var_dcb46b6f);
        e_grenade thread zm_utility::wait_for_attractor_positions_complete();
        if (!(isdefined(e_grenade.var_4005b2a9) && e_grenade.var_4005b2a9)) {
            e_grenade.var_499ed1ba zm_utility::self_delete();
            e_grenade.angles = var_1b106cd2;
            e_grenade.anim_model = util::spawn_model(level.var_ecd8678c, e_grenade.origin, e_grenade.angles);
            if (isdefined(e_grenade.var_fb197c56) && e_grenade.var_fb197c56) {
                e_grenade.anim_model setmovingplatformenabled(1);
                e_grenade.anim_model linkto(e_grenade.ground_ent);
                e_grenade.anim_model.var_fb197c56 = 1;
                e_grenade thread fakelinkto(e_grenade.anim_model);
            }
            e_grenade.anim_model clientfield::set("octobomb_fx", 3);
            wait 0.05;
            e_grenade.anim_model clientfield::set("octobomb_fx", var_df02f4b3);
            e_grenade thread function_a74e7f10(is_upgraded);
            e_grenade thread function_8ba4840c();
        }
        e_grenade thread function_de45c38c(self, is_upgraded);
        e_grenade thread function_25521204(self, is_upgraded);
        e_grenade thread sndattackvox();
        e_grenade thread function_55721dd7(self, max_attract_dist);
        level.var_9baa9723[level.var_9baa9723.size] = e_grenade;
        return;
    }
    e_grenade.script_noteworthy = undefined;
    level thread grenade_stolen_by_sam(e_grenade);
}

// Namespace _zm_weap_octobomb
// Params 0, eflags: 0x0
// Checksum 0x215730c8, Offset: 0x16f0
// Size: 0xf4
function is_on_navmesh() {
    self endon(#"death");
    if (ispointonnavmesh(self.origin, 60) == 1) {
        self.var_307512ca = 1;
        return;
    }
    v_valid_point = getclosestpointonnavmesh(self.origin, 100);
    if (isdefined(v_valid_point)) {
        n_z_correct = 0;
        if (self.origin[2] > v_valid_point[2]) {
            n_z_correct = self.origin[2] - v_valid_point[2];
        }
        self.origin = v_valid_point + (0, 0, n_z_correct);
        self.var_307512ca = 1;
        return;
    }
    self.var_307512ca = 0;
}

// Namespace _zm_weap_octobomb
// Params 1, eflags: 0x0
// Checksum 0x4e4583a9, Offset: 0x17f0
// Size: 0x1b4
function function_a74e7f10(is_upgraded) {
    self endon(#"death");
    self playsound("wpn_octobomb_explode");
    self scene::play("p7_fxanim_zm_zod_octobomb_start_bundle", self.anim_model);
    self thread scene::play("p7_fxanim_zm_zod_octobomb_loop_bundle", self.anim_model);
    var_b97c1dd7 = getanimlength("p7_fxanim_zm_zod_octobomb_start_anim");
    var_b669eeb0 = getanimlength("p7_fxanim_zm_zod_octobomb_end_anim");
    var_19894dae = (self.weapon.fusetime - var_b669eeb0 * 1000 - var_b97c1dd7 * 1000) / 1000;
    wait var_19894dae * 0.75;
    if (is_upgraded) {
        n_fx = 2;
    } else {
        n_fx = 1;
    }
    self thread clientfield::set("octobomb_spit_fx", n_fx);
    wait var_19894dae * 0.25;
    self scene::play("p7_fxanim_zm_zod_octobomb_end_bundle", self.anim_model);
    self playsound("wpn_octobomb_end");
}

// Namespace _zm_weap_octobomb
// Params 0, eflags: 0x0
// Checksum 0xa4b302b0, Offset: 0x19b0
// Size: 0x1da
function function_704217d1() {
    v_orig = self.origin;
    var_88f4c2cc = self.angles;
    n_z_correct = 0;
    queryresult = positionquery_source_navigation(self.origin, 0, -56, 100, 2, 20);
    if (queryresult.data.size) {
        foreach (point in queryresult.data) {
            if (bullettracepassed(point.origin + (0, 0, 20), v_orig + (0, 0, 20), 0, self, undefined, 0, 0)) {
                if (self.origin[2] > queryresult.origin[2]) {
                    n_z_correct = self.origin[2] - queryresult.origin[2];
                }
                self.origin = point.origin + (0, 0, n_z_correct);
                self.angles = var_88f4c2cc;
                break;
            }
        }
    }
}

// Namespace _zm_weap_octobomb
// Params 1, eflags: 0x0
// Checksum 0x2b271fdb, Offset: 0x1b98
// Size: 0x2fc
function grenade_stolen_by_sam(e_grenade) {
    if (!isdefined(e_grenade)) {
        return;
    }
    direction = e_grenade.origin;
    direction = (direction[1], direction[0], 0);
    if (direction[0] > 0 && (direction[1] < 0 || direction[1] > 0)) {
        direction = (direction[0], direction[1] * -1, 0);
    } else if (direction[0] < 0) {
        direction = (direction[0] * -1, direction[1], 0);
    }
    if (!(isdefined(e_grenade.sndnosamlaugh) && e_grenade.sndnosamlaugh)) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (isalive(players[i])) {
                players[i] playlocalsound(level.zmb_laugh_alias);
            }
        }
    }
    playfxontag(level._effect["grenade_samantha_steal"], e_grenade, "tag_origin");
    e_grenade.var_499ed1ba unlink();
    e_grenade.var_499ed1ba movez(60, 1, 0.25, 0.25);
    e_grenade.var_499ed1ba vibrate(direction, 1.5, 2.5, 1);
    e_grenade.var_499ed1ba waittill(#"movedone");
    if (isdefined(self.damagearea)) {
        self.damagearea delete();
    }
    e_grenade.var_499ed1ba delete();
    if (isdefined(e_grenade)) {
        if (isdefined(e_grenade.damagearea)) {
            e_grenade.damagearea delete();
        }
        e_grenade delete();
    }
}

// Namespace _zm_weap_octobomb
// Params 0, eflags: 0x0
// Checksum 0xd9072a32, Offset: 0x1ea0
// Size: 0xcc
function function_76874e09() {
    while (true) {
        if (!isdefined(self)) {
            if (isdefined(self.var_499ed1ba)) {
                self.var_499ed1ba delete();
            }
            if (isdefined(self.anim_model)) {
                self.anim_model delete();
            }
            if (isdefined(self.dud) && isdefined(self) && self.dud) {
                wait 6;
            }
            if (isdefined(self.simulacrum)) {
                self.simulacrum delete();
            }
            zm_utility::self_delete();
            return;
        }
        wait 0.05;
    }
}

// Namespace _zm_weap_octobomb
// Params 0, eflags: 0x0
// Checksum 0x1469fe2f, Offset: 0x1f78
// Size: 0xc4
function function_8ba4840c() {
    self waittill(#"explode", position);
    level notify(#"grenade_exploded", position, 100, 5000, 450);
    var_e653671 = -1;
    for (i = 0; i < level.var_9baa9723.size; i++) {
        if (!isdefined(level.var_9baa9723[i])) {
            var_e653671 = i;
            break;
        }
    }
    if (var_e653671 >= 0) {
        arrayremoveindex(level.var_9baa9723, var_e653671);
    }
}

// Namespace _zm_weap_octobomb
// Params 2, eflags: 0x0
// Checksum 0x321c0a6c, Offset: 0x2048
// Size: 0x288
function function_de45c38c(e_player, is_upgraded) {
    self endon(#"explode");
    n_time_started = gettime() / 1000;
    while (true) {
        n_time_current = gettime() / 1000;
        n_time_elapsed = n_time_current - n_time_started;
        if (n_time_elapsed < 1) {
            n_radius = lerpfloat(0, 100, n_time_elapsed / 1);
        } else if (n_time_elapsed == 1) {
            n_radius = 100;
        }
        a_ai_potential_targets = zombie_utility::get_zombie_array();
        if (isdefined(level.var_cf277073)) {
            a_ai_potential_targets = [[ level.var_cf277073 ]](a_ai_potential_targets);
        }
        a_ai_targets = arraysortclosest(a_ai_potential_targets, self.origin, a_ai_potential_targets.size, 0, 100);
        foreach (ai_target in a_ai_targets) {
            if (isalive(ai_target)) {
                ai_target thread clientfield::set("octobomb_tentacle_hit_fx", 1);
                if (ai_target.var_e987c31c !== 1) {
                    self notify(#"sndkillvox");
                    ai_target playsound("wpn_octobomb_zombie_imp");
                    ai_target thread function_7692d210();
                    ai_target thread function_19a0e723(e_player, self, is_upgraded);
                }
                wait 0.05;
                ai_target thread clientfield::set("octobomb_tentacle_hit_fx", 0);
            }
        }
        wait 0.5;
    }
}

// Namespace _zm_weap_octobomb
// Params 3, eflags: 0x0
// Checksum 0x605d82e8, Offset: 0x22d8
// Size: 0x14c
function function_19a0e723(e_player, e_grenade, is_upgraded) {
    self endon(#"death");
    self.var_fda76a9b = 1;
    var_501d1e91 = 0;
    var_a2ad7ba3 = 3.5;
    var_450e4402 = 3;
    if (is_upgraded) {
        n_damage = 1200;
        var_b84da6b3 = 2;
    } else {
        n_damage = 600;
        var_b84da6b3 = 1;
    }
    self clientfield::set("octobomb_spores_fx", var_b84da6b3);
    while (var_501d1e91 < 7) {
        wait 0.5;
        var_501d1e91++;
        self dodamage(n_damage * var_450e4402, self.origin, e_player, e_grenade);
        var_450e4402 = 1;
    }
    self.var_fda76a9b = 0;
    self clientfield::set("octobomb_spores_fx", 0);
}

// Namespace _zm_weap_octobomb
// Params 0, eflags: 0x0
// Checksum 0xd42bfe1c, Offset: 0x2430
// Size: 0x64
function function_7692d210() {
    self waittill(#"death");
    if (isdefined(self)) {
        if (self.var_fda76a9b == 1) {
            self clientfield::increment("octobomb_zombie_explode_fx", 1);
            self function_1a8c5dc7();
        }
    }
}

// Namespace _zm_weap_octobomb
// Params 2, eflags: 0x0
// Checksum 0x8c57e552, Offset: 0x24a0
// Size: 0x380
function function_25521204(e_player, is_upgraded) {
    self endon(#"death");
    var_97a5bbe3 = 1;
    var_682a92cd = 0;
    if (is_upgraded) {
        var_b84da6b3 = 2;
        n_time_min = 0.5;
        n_time_max = 1.5;
    } else {
        var_b84da6b3 = 1;
        n_time_min = 1.5;
        n_time_max = 2.5;
    }
    while (true) {
        if (var_97a5bbe3 == 0) {
            var_ed3fc9bc = randomfloatrange(n_time_min, n_time_max);
        } else {
            var_ed3fc9bc = 0.1;
        }
        wait var_ed3fc9bc;
        a_ai_potential_targets = zombie_utility::get_zombie_array();
        if (isdefined(level.var_cf277073)) {
            a_ai_potential_targets = [[ level.var_cf277073 ]](a_ai_potential_targets);
        }
        a_ai_targets = arraysort(a_ai_potential_targets, self.origin, 1, a_ai_potential_targets.size, 112);
        n_random_x = randomfloatrange(-5, 5);
        n_random_y = randomfloatrange(-5, 5);
        if (a_ai_targets.size > 0) {
            ai_target = array::random(a_ai_targets);
            if (isalive(ai_target)) {
                ai_target clientfield::set("octobomb_spores_fx", var_b84da6b3);
                self.var_fda76a9b = 1;
                self notify(#"sndkillvox");
                ai_target playsound("wpn_octobomb_zombie_imp");
                ai_target function_1a8c5dc7();
                ai_target dodamage(ai_target.health, ai_target.origin, e_player, self);
                ai_target startragdoll();
                ai_target launchragdoll(105 * vectornormalize(ai_target.origin - self.origin + (n_random_x, n_random_y, -56)));
            }
            if (randomint(6) > var_682a92cd + 3) {
                var_97a5bbe3 = 1;
                var_682a92cd++;
            } else {
                var_97a5bbe3 = 0;
                var_682a92cd = 0;
            }
            continue;
        }
        var_97a5bbe3 = 1;
    }
}

// Namespace _zm_weap_octobomb
// Params 0, eflags: 0x0
// Checksum 0xd03fc6fb, Offset: 0x2828
// Size: 0x74
function function_1a8c5dc7() {
    gibserverutils::gibhead(self);
    if (math::cointoss()) {
        gibserverutils::gibleftarm(self);
    } else {
        gibserverutils::gibrightarm(self);
    }
    gibserverutils::giblegs(self);
}

// Namespace _zm_weap_octobomb
// Params 2, eflags: 0x0
// Checksum 0xcd367f35, Offset: 0x28a8
// Size: 0x350
function function_55721dd7(e_player, max_attract_dist) {
    self endon(#"death");
    self makesentient();
    self setmaxhealth(1000);
    self setnormalhealth(1);
    self thread function_77d36058(self);
    while (true) {
        a_ai_zombies = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, max_attract_dist * 1.5);
        foreach (ai_zombie in a_ai_zombies) {
            if (isvehicle(ai_zombie)) {
                if (ai_zombie.archetype == "parasite" && ai_zombie.ignoreme !== 1 && ai_zombie vehicle_ai::get_current_state() != "scripted") {
                    if (!isdefined(self.var_662cce0a)) {
                        self function_5f8a3880();
                    }
                    ai_zombie thread function_fd0d2dc8(self);
                    ai_zombie thread function_729653c3(self);
                    continue;
                }
                if (ai_zombie.archetype == "raps" && ai_zombie.var_ffab6a26 !== 1) {
                    ai_zombie thread function_63e3acb6(self);
                }
                if (ai_zombie.archetype == "raps" && ai_zombie.var_fda76a9b !== 1 && distance(self.origin, ai_zombie.origin) <= 100) {
                    ai_zombie thread function_dd34ace2(e_player);
                }
                if (ai_zombie.archetype == "spider" && ai_zombie.var_fda76a9b !== 1 && distance(self.origin, ai_zombie.origin) <= 100) {
                    ai_zombie thread function_dd34ace2(e_player);
                }
            }
        }
        wait 0.05;
    }
}

// Namespace _zm_weap_octobomb
// Params 1, eflags: 0x0
// Checksum 0x4ac33718, Offset: 0x2c00
// Size: 0x60
function function_63e3acb6(e_grenade) {
    self endon(#"death");
    self.favoriteenemy = e_grenade;
    self.var_ffab6a26 = 1;
    self.ignoreme = 1;
    e_grenade waittill(#"death");
    self.var_ffab6a26 = 0;
    self.ignoreme = 0;
}

// Namespace _zm_weap_octobomb
// Params 1, eflags: 0x0
// Checksum 0xbf318b1a, Offset: 0x2c68
// Size: 0x7c
function function_dd34ace2(e_player) {
    self endon(#"death");
    self.var_fda76a9b = 1;
    var_501d1e91 = 0;
    while (var_501d1e91 < 7) {
        self dodamage(600, self.origin, e_player);
        wait 0.5;
    }
    self.var_fda76a9b = 0;
}

// Namespace _zm_weap_octobomb
// Params 0, eflags: 0x0
// Checksum 0x66612a2e, Offset: 0x2cf0
// Size: 0x22e
function function_5f8a3880() {
    self.var_662cce0a = self.origin + (0, 0, 80);
    self.var_e1d73ddd = [];
    if (!isdefined(self.var_e1d73ddd)) {
        self.var_e1d73ddd = [];
    } else if (!isarray(self.var_e1d73ddd)) {
        self.var_e1d73ddd = array(self.var_e1d73ddd);
    }
    self.var_e1d73ddd[self.var_e1d73ddd.size] = self.var_662cce0a + (80, 0, 0);
    if (!isdefined(self.var_e1d73ddd)) {
        self.var_e1d73ddd = [];
    } else if (!isarray(self.var_e1d73ddd)) {
        self.var_e1d73ddd = array(self.var_e1d73ddd);
    }
    self.var_e1d73ddd[self.var_e1d73ddd.size] = self.var_662cce0a + (0, 80, 0);
    if (!isdefined(self.var_e1d73ddd)) {
        self.var_e1d73ddd = [];
    } else if (!isarray(self.var_e1d73ddd)) {
        self.var_e1d73ddd = array(self.var_e1d73ddd);
    }
    self.var_e1d73ddd[self.var_e1d73ddd.size] = self.var_662cce0a + (-80, 0, 0);
    if (!isdefined(self.var_e1d73ddd)) {
        self.var_e1d73ddd = [];
    } else if (!isarray(self.var_e1d73ddd)) {
        self.var_e1d73ddd = array(self.var_e1d73ddd);
    }
    self.var_e1d73ddd[self.var_e1d73ddd.size] = self.var_662cce0a + (0, -80, 0);
}

// Namespace _zm_weap_octobomb
// Params 1, eflags: 0x0
// Checksum 0xd738a365, Offset: 0x2f28
// Size: 0xf4
function function_fd0d2dc8(e_grenade) {
    self endon(#"death");
    self.favoriteenemy = e_grenade;
    self vehicle_ai::set_state("scripted");
    self.var_77bb0c1e = 1;
    self.ignoreme = 1;
    self.parasiteenemy = e_grenade;
    self ai::set_ignoreall(1);
    e_grenade waittill(#"death");
    self resumespeed();
    self vehicle_ai::set_state("combat");
    self.var_77bb0c1e = 0;
    self.ignoreme = 0;
    self ai::set_ignoreall(0);
}

// Namespace _zm_weap_octobomb
// Params 1, eflags: 0x0
// Checksum 0xa3e24b1f, Offset: 0x3028
// Size: 0x1d0
function function_729653c3(e_grenade) {
    self endon(#"death");
    e_grenade endon(#"death");
    var_fa42eff5 = 10;
    if (distance(e_grenade.var_662cce0a, self.origin) > 80) {
        self setspeed(10);
        self setvehgoalpos(e_grenade.var_662cce0a, 0, 1);
        while (distance(e_grenade.var_662cce0a, self.origin) > 80) {
            wait 0.05;
        }
        self clearvehgoalpos();
    }
    i = 0;
    while (self.var_77bb0c1e) {
        if (i == 4) {
            i = 0;
        }
        self setvehgoalpos(e_grenade.var_e1d73ddd[i], 0, 1);
        while (distance(e_grenade.var_e1d73ddd[i], self.origin) > 10) {
            if (!self.var_77bb0c1e) {
                break;
            }
            wait 0.05;
        }
        self clearvehgoalpos();
        i++;
        wait 0.05;
    }
}

// Namespace _zm_weap_octobomb
// Params 1, eflags: 0x0
// Checksum 0x61a6c658, Offset: 0x3200
// Size: 0x260
function function_77d36058(e_grenade) {
    e_grenade endon(#"death");
    self endon(#"death");
    var_97a5bbe3 = 1;
    var_682a92cd = 0;
    while (true) {
        if (var_97a5bbe3 == 0) {
            var_ed3fc9bc = randomfloatrange(1.5, 2.5);
        } else {
            var_ed3fc9bc = 0.1;
        }
        wait var_ed3fc9bc;
        var_9c474fb4 = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, -106);
        for (i = 0; i < var_9c474fb4.size; i++) {
            if (isdefined(var_9c474fb4[i]) && var_9c474fb4[i].archetype != "parasite") {
                arrayremovevalue(var_9c474fb4, var_9c474fb4[i]);
                i = 0;
                continue;
            }
        }
        if (var_9c474fb4.size > 0) {
            var_1faf0ec5 = array::random(var_9c474fb4);
            v_fling = vectornormalize(var_1faf0ec5.origin - e_grenade.origin);
            var_1faf0ec5 dodamage(var_1faf0ec5.maxhealth, self.origin);
            if (randomint(6) > var_682a92cd + 3) {
                var_97a5bbe3 = 1;
                var_682a92cd++;
            } else {
                var_97a5bbe3 = 0;
                var_682a92cd = 0;
            }
            continue;
        }
        var_97a5bbe3 = 1;
    }
}

// Namespace _zm_weap_octobomb
// Params 0, eflags: 0x0
// Checksum 0x1a76b328, Offset: 0x3468
// Size: 0x58
function sndattackvox() {
    self endon(#"explode");
    while (true) {
        self waittill(#"sndkillvox");
        wait 0.25;
        self playsound("wpn_octobomb_attack_vox");
        wait 2.5;
    }
}

// Namespace _zm_weap_octobomb
// Params 0, eflags: 0x0
// Checksum 0xa00e9117, Offset: 0x34c8
// Size: 0xb8
function function_9e041fe() {
    self endon(#"death");
    self endon(#"hash_69fff51d");
    while (true) {
        self waittill(#"grenade_fire", e_grenade, w_weapon);
        if (w_weapon == level.var_90b60862 || w_weapon == level.var_5327e29d) {
            e_grenade.use_grenade_special_long_bookmark = 1;
            e_grenade.grenade_multiattack_bookmark_count = 1;
            e_grenade.weapon = w_weapon;
            return e_grenade;
        }
        wait 0.05;
    }
}

// Namespace _zm_weap_octobomb
// Params 0, eflags: 0x0
// Checksum 0x188abbd, Offset: 0x3588
// Size: 0x1a
function function_4ffaebc7() {
    return zm_weapons::is_weapon_included(level.var_90b60862);
}

// Namespace _zm_weap_octobomb
// Params 0, eflags: 0x0
// Checksum 0xfaa6a6a7, Offset: 0x35b0
// Size: 0x9c
function function_60df0cfd() {
    for (i = 0; i < 4; i++) {
        level thread function_72260d3a("ZM/Weapons/Offhand/Octobomb/Give" + i, "zod_give_octobomb", i, &function_283c5c9);
    }
    level thread function_72260d3a("ZM/Weapons/Offhand/Octobomb/Give to All", "zod_give_octobomb", 4, &function_283c5c9);
}

// Namespace _zm_weap_octobomb
// Params 5, eflags: 0x4
// Checksum 0xe4fd05db, Offset: 0x3658
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

// Namespace _zm_weap_octobomb
// Params 1, eflags: 0x0
// Checksum 0x35598070, Offset: 0x3780
// Size: 0xf2
function function_283c5c9(n_player_index) {
    players = getplayers();
    player = players[n_player_index];
    if (isdefined(player)) {
        function_e53a7954(player);
        return;
    }
    if (n_player_index === 4) {
        foreach (player in players) {
            function_e53a7954(player);
        }
    }
}

// Namespace _zm_weap_octobomb
// Params 1, eflags: 0x0
// Checksum 0x6b955389, Offset: 0x3880
// Size: 0x8c
function function_e53a7954(player) {
    player clientfield::set_to_player("octobomb_state", 3);
    weapon = getweapon("octobomb");
    player takeweapon(weapon);
    player zm_weapons::weapon_give(weapon, undefined, undefined, 1);
}

