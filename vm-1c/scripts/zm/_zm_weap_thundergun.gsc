#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_audio;
#using scripts/zm/_util;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_weap_thundergun;

// Namespace zm_weap_thundergun
// Params 0, eflags: 0x2
// namespace_e82459b9<file_0>::function_2dc19561
// Checksum 0x2c68e14d, Offset: 0x560
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_weap_thundergun", &__init__, &__main__, undefined);
}

// Namespace zm_weap_thundergun
// Params 0, eflags: 0x1 linked
// namespace_e82459b9<file_0>::function_8c87d8eb
// Checksum 0xdf106bd1, Offset: 0x5a8
// Size: 0x44
function __init__() {
    level.var_65cd3ef2 = getweapon("thundergun");
    level.var_15a75be2 = getweapon("thundergun_upgraded");
}

// Namespace zm_weap_thundergun
// Params 0, eflags: 0x1 linked
// namespace_e82459b9<file_0>::function_5b6b9132
// Checksum 0xe7a8636e, Offset: 0x5f8
// Size: 0x1c4
function __main__() {
    level._effect["thundergun_knockdown_ground"] = "zombie/fx_thundergun_knockback_ground";
    level._effect["thundergun_smoke_cloud"] = "zombie/fx_thundergun_smoke_cloud";
    zombie_utility::set_zombie_var("thundergun_cylinder_radius", -76);
    zombie_utility::set_zombie_var("thundergun_fling_range", 480);
    zombie_utility::set_zombie_var("thundergun_gib_range", 900);
    zombie_utility::set_zombie_var("thundergun_gib_damage", 75);
    zombie_utility::set_zombie_var("thundergun_knockdown_range", 1200);
    zombie_utility::set_zombie_var("thundergun_knockdown_damage", 15);
    level.thundergun_gib_refs = [];
    level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "guts";
    level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "right_arm";
    level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "left_arm";
    level.basic_zombie_thundergun_knockdown = &zombie_knockdown;
    if (!isdefined(level.override_thundergun_damage_func)) {
        level.override_thundergun_damage_func = &override_thundergun_damage_func;
    }
    /#
        level thread thundergun_devgui_dvar_think();
    #/
    callback::on_connect(&thundergun_on_player_connect);
}

/#

    // Namespace zm_weap_thundergun
    // Params 0, eflags: 0x1 linked
    // namespace_e82459b9<file_0>::function_f54101e7
    // Checksum 0x1dd000fc, Offset: 0x7c8
    // Size: 0x21c
    function thundergun_devgui_dvar_think() {
        if (!zm_weapons::is_weapon_included(level.var_65cd3ef2)) {
            return;
        }
        setdvar("thundergun_fling_range", level.zombie_vars["thundergun_fling_range"]);
        setdvar("thundergun_fling_range", level.zombie_vars["thundergun_fling_range"]);
        setdvar("thundergun_fling_range", level.zombie_vars["thundergun_fling_range"]);
        setdvar("thundergun_fling_range", level.zombie_vars["thundergun_fling_range"]);
        setdvar("thundergun_fling_range", level.zombie_vars["thundergun_fling_range"]);
        setdvar("thundergun_fling_range", level.zombie_vars["thundergun_fling_range"]);
        for (;;) {
            level.zombie_vars["thundergun_fling_range"] = getdvarint("thundergun_fling_range");
            level.zombie_vars["thundergun_fling_range"] = getdvarint("thundergun_fling_range");
            level.zombie_vars["thundergun_fling_range"] = getdvarint("thundergun_fling_range");
            level.zombie_vars["thundergun_fling_range"] = getdvarint("thundergun_fling_range");
            level.zombie_vars["thundergun_fling_range"] = getdvarint("thundergun_fling_range");
            level.zombie_vars["thundergun_fling_range"] = getdvarint("thundergun_fling_range");
            wait(0.5);
        }
    }

#/

// Namespace zm_weap_thundergun
// Params 0, eflags: 0x1 linked
// namespace_e82459b9<file_0>::function_a1ec502a
// Checksum 0xdce0c8b1, Offset: 0x9f0
// Size: 0x1c
function thundergun_on_player_connect() {
    self thread wait_for_thundergun_fired();
}

// Namespace zm_weap_thundergun
// Params 0, eflags: 0x1 linked
// namespace_e82459b9<file_0>::function_e52bd440
// Checksum 0xf87bf045, Offset: 0xa18
// Size: 0x140
function wait_for_thundergun_fired() {
    self endon(#"disconnect");
    self waittill(#"spawned_player");
    for (;;) {
        self waittill(#"weapon_fired");
        currentweapon = self getcurrentweapon();
        if (currentweapon == level.var_65cd3ef2 || currentweapon == level.var_15a75be2) {
            self thread thundergun_fired();
            view_pos = self gettagorigin("tag_flash") - self getplayerviewheight();
            view_angles = self gettagangles("tag_flash");
            playfx(level._effect["thundergun_smoke_cloud"], view_pos, anglestoforward(view_angles), anglestoup(view_angles));
        }
    }
}

// Namespace zm_weap_thundergun
// Params 0, eflags: 0x0
// namespace_e82459b9<file_0>::function_b69d791b
// Checksum 0xe3906625, Offset: 0xb60
// Size: 0x4c
function thundergun_network_choke() {
    level.thundergun_network_choke_count++;
    if (!(level.thundergun_network_choke_count % 10)) {
        util::wait_network_frame();
        util::wait_network_frame();
        util::wait_network_frame();
    }
}

// Namespace zm_weap_thundergun
// Params 0, eflags: 0x1 linked
// namespace_e82459b9<file_0>::function_d2538434
// Checksum 0x4ac0fde7, Offset: 0xbb8
// Size: 0x44
function thundergun_fired() {
    physicsexplosioncylinder(self.origin, 600, -16, 1);
    self thread thundergun_affect_ais();
}

// Namespace zm_weap_thundergun
// Params 0, eflags: 0x1 linked
// namespace_e82459b9<file_0>::function_28be86fb
// Checksum 0x20fa565b, Offset: 0xc08
// Size: 0x144
function thundergun_affect_ais() {
    if (!isdefined(level.thundergun_knockdown_enemies)) {
        level.thundergun_knockdown_enemies = [];
        level.thundergun_knockdown_gib = [];
        level.thundergun_fling_enemies = [];
        level.thundergun_fling_vecs = [];
    }
    self thundergun_get_enemies_in_range();
    level.thundergun_network_choke_count = 0;
    for (i = 0; i < level.thundergun_fling_enemies.size; i++) {
        level.thundergun_fling_enemies[i] thread thundergun_fling_zombie(self, level.thundergun_fling_vecs[i], i);
    }
    for (i = 0; i < level.thundergun_knockdown_enemies.size; i++) {
        level.thundergun_knockdown_enemies[i] thread thundergun_knockdown_zombie(self, level.thundergun_knockdown_gib[i]);
    }
    level.thundergun_knockdown_enemies = [];
    level.thundergun_knockdown_gib = [];
    level.thundergun_fling_enemies = [];
    level.thundergun_fling_vecs = [];
}

// Namespace zm_weap_thundergun
// Params 0, eflags: 0x1 linked
// namespace_e82459b9<file_0>::function_34b34cbb
// Checksum 0x4e22f80f, Offset: 0xd58
// Size: 0x6ae
function thundergun_get_enemies_in_range() {
    view_pos = self getweaponmuzzlepoint();
    zombies = array::get_all_closest(view_pos, getaiteamarray(level.zombie_team), undefined, undefined, level.zombie_vars["thundergun_knockdown_range"]);
    if (!isdefined(zombies)) {
        return;
    }
    knockdown_range_squared = level.zombie_vars["thundergun_knockdown_range"] * level.zombie_vars["thundergun_knockdown_range"];
    gib_range_squared = level.zombie_vars["thundergun_gib_range"] * level.zombie_vars["thundergun_gib_range"];
    fling_range_squared = level.zombie_vars["thundergun_fling_range"] * level.zombie_vars["thundergun_fling_range"];
    cylinder_radius_squared = level.zombie_vars["thundergun_cylinder_radius"] * level.zombie_vars["thundergun_cylinder_radius"];
    forward_view_angles = self getweaponforwarddir();
    end_pos = view_pos + vectorscale(forward_view_angles, level.zombie_vars["thundergun_knockdown_range"]);
    /#
        if (2 == getdvarint("thundergun_fling_range")) {
            near_circle_pos = view_pos + vectorscale(forward_view_angles, 2);
            circle(near_circle_pos, level.zombie_vars["thundergun_fling_range"], (1, 0, 0), 0, 0, 100);
            line(near_circle_pos, end_pos, (0, 0, 1), 1, 0, 100);
            circle(end_pos, level.zombie_vars["thundergun_fling_range"], (1, 0, 0), 0, 0, 100);
        }
    #/
    for (i = 0; i < zombies.size; i++) {
        if (!isdefined(zombies[i]) || !isalive(zombies[i])) {
            continue;
        }
        test_origin = zombies[i] getcentroid();
        test_range_squared = distancesquared(view_pos, test_origin);
        if (test_range_squared > knockdown_range_squared) {
            zombies[i] thundergun_debug_print("range", (1, 0, 0));
            return;
        }
        normal = vectornormalize(test_origin - view_pos);
        dot = vectordot(forward_view_angles, normal);
        if (0 > dot) {
            zombies[i] thundergun_debug_print("dot", (1, 0, 0));
            continue;
        }
        radial_origin = pointonsegmentnearesttopoint(view_pos, end_pos, test_origin);
        if (distancesquared(test_origin, radial_origin) > cylinder_radius_squared) {
            zombies[i] thundergun_debug_print("cylinder", (1, 0, 0));
            continue;
        }
        if (0 == zombies[i] damageconetrace(view_pos, self)) {
            zombies[i] thundergun_debug_print("cone", (1, 0, 0));
            continue;
        }
        if (test_range_squared < fling_range_squared) {
            level.thundergun_fling_enemies[level.thundergun_fling_enemies.size] = zombies[i];
            dist_mult = (fling_range_squared - test_range_squared) / fling_range_squared;
            fling_vec = vectornormalize(test_origin - view_pos);
            if (5000 < test_range_squared) {
                fling_vec += vectornormalize(test_origin - radial_origin);
            }
            fling_vec = (fling_vec[0], fling_vec[1], abs(fling_vec[2]));
            fling_vec = vectorscale(fling_vec, 100 + 100 * dist_mult);
            level.thundergun_fling_vecs[level.thundergun_fling_vecs.size] = fling_vec;
            zombies[i] thread setup_thundergun_vox(self, 1, 0, 0);
            continue;
        }
        if (test_range_squared < gib_range_squared) {
            level.thundergun_knockdown_enemies[level.thundergun_knockdown_enemies.size] = zombies[i];
            level.thundergun_knockdown_gib[level.thundergun_knockdown_gib.size] = 1;
            zombies[i] thread setup_thundergun_vox(self, 0, 1, 0);
            continue;
        }
        level.thundergun_knockdown_enemies[level.thundergun_knockdown_enemies.size] = zombies[i];
        level.thundergun_knockdown_gib[level.thundergun_knockdown_gib.size] = 0;
        zombies[i] thread setup_thundergun_vox(self, 0, 0, 1);
    }
}

// Namespace zm_weap_thundergun
// Params 2, eflags: 0x1 linked
// namespace_e82459b9<file_0>::function_99964c81
// Checksum 0xd731606, Offset: 0x1410
// Size: 0x8c
function thundergun_debug_print(msg, color) {
    /#
        if (!getdvarint("thundergun_fling_range")) {
            return;
        }
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        print3d(self.origin + (0, 0, 60), msg, color, 1, 1, 40);
    #/
}

// Namespace zm_weap_thundergun
// Params 3, eflags: 0x1 linked
// namespace_e82459b9<file_0>::function_952e71ef
// Checksum 0x8ef260ee, Offset: 0x14a8
// Size: 0x188
function thundergun_fling_zombie(player, fling_vec, index) {
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    if (isdefined(self.var_c8806297)) {
        self [[ self.var_c8806297 ]](player);
        return;
    }
    self.deathpoints_already_given = 1;
    self dodamage(self.health + 666, player.origin, player);
    if (self.health <= 0) {
        if (isdefined(player) && isdefined(level.hero_power_update)) {
            level thread [[ level.hero_power_update ]](player, self);
        }
        points = 10;
        if (!index) {
            points = zm_score::function_b2baf1b5();
        } else if (1 == index) {
            points = 30;
        }
        player zm_score::player_add_points("thundergun_fling", points);
        self startragdoll();
        self launchragdoll(fling_vec);
        self.thundergun_death = 1;
    }
}

// Namespace zm_weap_thundergun
// Params 2, eflags: 0x1 linked
// namespace_e82459b9<file_0>::function_6db68516
// Checksum 0x60991e4c, Offset: 0x1638
// Size: 0x12c
function zombie_knockdown(player, gib) {
    if (gib && !self.gibbed) {
        self.a.gib_ref = array::random(level.thundergun_gib_refs);
        self thread zombie_death::do_gib();
    }
    if (isdefined(level.override_thundergun_damage_func)) {
        self [[ level.override_thundergun_damage_func ]](player, gib);
        return;
    }
    damage = level.zombie_vars["thundergun_knockdown_damage"];
    self playsound("fly_thundergun_forcehit");
    self.thundergun_handle_pain_notetracks = &handle_thundergun_pain_notetracks;
    self dodamage(damage, player.origin, player);
    self animcustom(&playthundergunpainanim);
}

// Namespace zm_weap_thundergun
// Params 0, eflags: 0x1 linked
// namespace_e82459b9<file_0>::function_182137c4
// Checksum 0xeb9451dd, Offset: 0x1770
// Size: 0x23c
function playthundergunpainanim() {
    self notify(#"end_play_thundergun_pain_anim");
    self endon(#"killanimscript");
    self endon(#"death");
    self endon(#"end_play_thundergun_pain_anim");
    if (isdefined(self.marked_for_death) && self.marked_for_death) {
        return;
    }
    if (self.damageyaw <= -135 || self.damageyaw >= -121) {
        if (self.missinglegs) {
            fallanim = "zm_thundergun_fall_front_crawl";
        } else {
            fallanim = "zm_thundergun_fall_front";
        }
        getupanim = "zm_thundergun_getup_belly_early";
    } else if (self.damageyaw > -135 && self.damageyaw < -45) {
        fallanim = "zm_thundergun_fall_left";
        getupanim = "zm_thundergun_getup_belly_early";
    } else if (self.damageyaw > 45 && self.damageyaw < -121) {
        fallanim = "zm_thundergun_fall_right";
        getupanim = "zm_thundergun_getup_belly_early";
    } else {
        fallanim = "zm_thundergun_fall_back";
        if (randomint(100) < 50) {
            getupanim = "zm_thundergun_getup_back_early";
        } else {
            getupanim = "zm_thundergun_getup_back_late";
        }
    }
    self setanimstatefromasd(fallanim);
    self zombie_shared::donotetracks("thundergun_fall_anim", self.thundergun_handle_pain_notetracks);
    if (isdefined(self.marked_for_death) && (!isdefined(self) || !isalive(self) || self.missinglegs || self.marked_for_death)) {
        return;
    }
    self setanimstatefromasd(getupanim);
    self zombie_shared::donotetracks("thundergun_getup_anim");
}

// Namespace zm_weap_thundergun
// Params 2, eflags: 0x1 linked
// namespace_e82459b9<file_0>::function_426da741
// Checksum 0x5269231b, Offset: 0x19b8
// Size: 0x88
function thundergun_knockdown_zombie(player, gib) {
    self endon(#"death");
    playsoundatposition("wpn_thundergun_proj_impact", self.origin);
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    if (isdefined(self.thundergun_knockdown_func)) {
        self [[ self.thundergun_knockdown_func ]](player, gib);
    }
}

// Namespace zm_weap_thundergun
// Params 1, eflags: 0x1 linked
// namespace_e82459b9<file_0>::function_a024186c
// Checksum 0x16883d66, Offset: 0x1a48
// Size: 0x94
function handle_thundergun_pain_notetracks(note) {
    if (note == "zombie_knockdown_ground_impact") {
        playfx(level._effect["thundergun_knockdown_ground"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
        self playsound("fly_thundergun_forcehit");
    }
}

// Namespace zm_weap_thundergun
// Params 0, eflags: 0x0
// namespace_e82459b9<file_0>::function_b8c1ec1c
// Checksum 0xc69eacb0, Offset: 0x1ae8
// Size: 0x50
function is_thundergun_damage() {
    return self.damagemod != "MOD_GRENADE" && (self.damageweapon == level.var_65cd3ef2 || self.damageweapon == level.var_15a75be2) && self.damagemod != "MOD_GRENADE_SPLASH";
}

// Namespace zm_weap_thundergun
// Params 0, eflags: 0x0
// namespace_e82459b9<file_0>::function_5705ab6
// Checksum 0xdd8a143c, Offset: 0x1b40
// Size: 0x16
function enemy_killed_by_thundergun() {
    return isdefined(self.thundergun_death) && self.thundergun_death;
}

// Namespace zm_weap_thundergun
// Params 0, eflags: 0x0
// namespace_e82459b9<file_0>::function_20dfb524
// Checksum 0xdec31bb9, Offset: 0x1b60
// Size: 0x118
function thundergun_sound_thread() {
    self endon(#"disconnect");
    self waittill(#"spawned_player");
    for (;;) {
        result = self util::waittill_any_return("grenade_fire", "death", "player_downed", "weapon_change", "grenade_pullback", "disconnect");
        if (!isdefined(result)) {
            continue;
        }
        if ((result == "weapon_change" || result == "grenade_fire") && self getcurrentweapon() == level.var_65cd3ef2) {
            self playloopsound("tesla_idle", 0.25);
            continue;
        }
        self notify(#"weap_away");
        self stoploopsound(0.25);
    }
}

// Namespace zm_weap_thundergun
// Params 4, eflags: 0x1 linked
// namespace_e82459b9<file_0>::function_c6a823b9
// Checksum 0xae630ff9, Offset: 0x1c80
// Size: 0xd4
function setup_thundergun_vox(player, fling, gib, knockdown) {
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    if (gib || !fling && knockdown) {
        if (25 > randomintrange(1, 100)) {
        }
    }
    if (fling) {
        if (30 > randomintrange(1, 100)) {
            player zm_audio::create_and_play_dialog("kill", "thundergun");
        }
    }
}

// Namespace zm_weap_thundergun
// Params 2, eflags: 0x1 linked
// namespace_e82459b9<file_0>::function_76846f3d
// Checksum 0x1d632cb6, Offset: 0x1d60
// Size: 0x2c
function override_thundergun_damage_func(player, gib) {
    self zombie_utility::setup_zombie_knockdown(player);
}

