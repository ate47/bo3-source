#using scripts/zm/_zm_ai_spiders;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/zm/_util;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/systems/gib;
#using scripts/codescripts/struct;

#namespace namespace_7cee2b44;

// Namespace namespace_7cee2b44
// Params 0, eflags: 0x2
// namespace_7cee2b44<file_0>::function_2dc19561
// Checksum 0xbac84cb5, Offset: 0x708
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("mirg2000", &__init__, &__main__, undefined);
}

// Namespace namespace_7cee2b44
// Params 0, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_8c87d8eb
// Checksum 0xfbc1135b, Offset: 0x750
// Size: 0x1f4
function __init__() {
    level.var_5e75629a = getweapon("hero_mirg2000");
    level.var_a367ea52 = getweapon("hero_mirg2000_1");
    level.var_7d656fe9 = getweapon("hero_mirg2000_2");
    level.var_a4052592 = getweapon("hero_mirg2000_upgraded");
    level.var_5c210a9a = getweapon("hero_mirg2000_upgraded_1");
    level.var_361e9031 = getweapon("hero_mirg2000_upgraded_2");
    clientfield::register("scriptmover", "plant_killer", 9000, getminbitcountfornum(4), "int");
    clientfield::register("vehicle", "mirg2000_spider_death_fx", 9000, 2, "int");
    clientfield::register("actor", "mirg2000_enemy_impact_fx", 9000, 2, "int");
    clientfield::register("vehicle", "mirg2000_enemy_impact_fx", 9000, 2, "int");
    clientfield::register("allplayers", "mirg2000_fire_button_held_sound", 9000, 1, "int");
    clientfield::register("toplayer", "mirg2000_charge_glow", 9000, 2, "int");
}

// Namespace namespace_7cee2b44
// Params 0, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_5b6b9132
// Checksum 0xcc835182, Offset: 0x950
// Size: 0x24
function __main__() {
    callback::on_connect(&function_182a023);
}

// Namespace namespace_7cee2b44
// Params 0, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_182a023
// Checksum 0x8f90155c, Offset: 0x980
// Size: 0x64
function function_182a023() {
    self thread function_56c8d7bb();
    self thread function_3940d816();
    self thread function_fd4b8044();
    self thread function_9e09b719();
}

// Namespace namespace_7cee2b44
// Params 2, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_c4054b34
// Checksum 0xcb816734, Offset: 0x9f0
// Size: 0x228
function is_wonder_weapon(weapon, str_type) {
    if (!isdefined(str_type)) {
        str_type = "any";
    }
    if (!isdefined(weapon)) {
        return false;
    }
    switch (str_type) {
    case 18:
        if (weapon == level.var_5e75629a || weapon == level.var_a367ea52 || weapon == level.var_7d656fe9 || weapon == level.var_a4052592 || weapon == level.var_5c210a9a || weapon == level.var_361e9031) {
            return true;
        }
        break;
    case 19:
        if (weapon == level.var_5e75629a || weapon == level.var_a367ea52 || weapon == level.var_7d656fe9) {
            return true;
        }
        break;
    case 20:
        if (weapon == level.var_a367ea52 || weapon == level.var_7d656fe9) {
            return true;
        }
        break;
    case 21:
        if (weapon == level.var_a4052592 || weapon == level.var_5c210a9a || weapon == level.var_361e9031) {
            return true;
        }
        break;
    case 22:
        if (weapon == level.var_5c210a9a || weapon == level.var_361e9031) {
            return true;
        }
        break;
    default:
        if (weapon == level.var_5e75629a || weapon == level.var_a367ea52 || weapon == level.var_7d656fe9 || weapon == level.var_a4052592 || weapon == level.var_5c210a9a || weapon == level.var_361e9031) {
            return true;
        }
        break;
    }
    return false;
}

// Namespace namespace_7cee2b44
// Params 1, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_a1fce678
// Checksum 0x447ebd4, Offset: 0xc20
// Size: 0xce
function function_a1fce678(var_2b568a63) {
    if (!isdefined(var_2b568a63)) {
        var_2b568a63 = 0;
    }
    if (self hasweapon(level.var_a4052592)) {
        if (var_2b568a63) {
            if (self.chargeshotlevel > 2) {
                n_range_sq = 22500;
            } else {
                n_range_sq = 7225;
            }
        } else {
            n_range_sq = 7225;
        }
    } else if (var_2b568a63) {
        if (self.chargeshotlevel > 2) {
            n_range_sq = 22500;
        } else {
            n_range_sq = 7225;
        }
    } else {
        n_range_sq = 7225;
    }
    return n_range_sq;
}

// Namespace namespace_7cee2b44
// Params 4, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_8734b840
// Checksum 0xa80a1ef1, Offset: 0xcf8
// Size: 0xb0
function function_8734b840(v_start, v_end, n_range_sq, var_a8ed33a) {
    if (!isdefined(var_a8ed33a)) {
        var_a8ed33a = 72;
    }
    n_height_diff = abs(v_end[2] - v_start[2]);
    if (distance2dsquared(v_start, v_end) <= n_range_sq && n_height_diff <= var_a8ed33a) {
        return 1;
    }
    return 0;
}

// Namespace namespace_7cee2b44
// Params 2, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_794992bd
// Checksum 0x20d778ae, Offset: 0xdb0
// Size: 0xb4
function function_794992bd(player, v_pos) {
    if (player hasweapon(level.var_a4052592)) {
        n_damage = 7000;
        var_a9fb62c6 = 2;
    } else {
        n_damage = 1750;
        var_a9fb62c6 = 1;
    }
    self dodamage(n_damage, v_pos, player, player);
    self clientfield::set("mirg2000_enemy_impact_fx", var_a9fb62c6);
}

// Namespace namespace_7cee2b44
// Params 2, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_b926526f
// Checksum 0x3d4a684c, Offset: 0xe70
// Size: 0x4c
function function_b926526f(mod, weapon) {
    return mod == "MOD_GRENADE" || is_wonder_weapon(weapon) && mod == "MOD_GRENADE_SPLASH";
}

// Namespace namespace_7cee2b44
// Params 0, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_fd4b8044
// Checksum 0x658a0233, Offset: 0xec8
// Size: 0x178
function function_fd4b8044() {
    self endon(#"disconnect");
    while (true) {
        str_notify = self util::waittill_any_return("weapon_fired", "weapon_melee", "weapon_change", "reload", "reload_start", "disconnect");
        w_current = self getcurrentweapon();
        if (is_wonder_weapon(w_current)) {
            n_ammo_clip = self getweaponammoclip(w_current);
            if (n_ammo_clip == 0 || str_notify == "reload_start") {
                self clientfield::set_to_player("mirg2000_charge_glow", 3);
            } else {
                self clientfield::set_to_player("mirg2000_charge_glow", 2);
            }
            continue;
        }
        if (str_notify == "weapon_change" && !is_wonder_weapon(w_current)) {
            self clientfield::set_to_player("mirg2000_charge_glow", 3);
        }
    }
}

// Namespace namespace_7cee2b44
// Params 0, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_3940d816
// Checksum 0x85f78ee3, Offset: 0x1048
// Size: 0x228
function function_3940d816() {
    self endon(#"disconnect");
    while (true) {
        w_current = self getcurrentweapon();
        if (is_wonder_weapon(w_current) && self.chargeshotlevel > 1) {
            var_6e3a6054 = self getweaponammoclip(w_current);
            if (self.chargeshotlevel > var_6e3a6054) {
                var_941e50a8 = var_6e3a6054;
            } else {
                var_941e50a8 = self.chargeshotlevel;
                self playsound("zmb_mirg_charge_" + var_941e50a8);
            }
            switch (var_941e50a8) {
            case 1:
                self clientfield::set_to_player("mirg2000_charge_glow", 2);
                break;
            case 2:
                self clientfield::set_to_player("mirg2000_charge_glow", 1);
                self notify(#"hash_be077d23");
                break;
            case 3:
                self clientfield::set_to_player("mirg2000_charge_glow", 0);
                self notify(#"hash_be077d23");
                break;
            default:
                self clientfield::set_to_player("mirg2000_charge_glow", 3);
                break;
            }
            while (self.chargeshotlevel == var_941e50a8) {
                wait(0.1);
            }
            if (self.chargeshotlevel == 0 && !self isreloading()) {
                self clientfield::set_to_player("mirg2000_charge_glow", 2);
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_7cee2b44
// Params 0, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_9e09b719
// Checksum 0x1ea364cd, Offset: 0x1278
// Size: 0x108
function function_9e09b719() {
    self endon(#"disconnect");
    self.var_c654a75a = 0;
    while (true) {
        if (self util::attack_button_held()) {
            weapon = self getcurrentweapon();
            if (is_wonder_weapon(weapon) && !self.var_c654a75a) {
                self.var_c654a75a = 1;
                self clientfield::set("mirg2000_fire_button_held_sound", 1);
            }
        } else if (!self util::attack_button_held() && self.var_c654a75a) {
            self.var_c654a75a = 0;
            self clientfield::set("mirg2000_fire_button_held_sound", 0);
        }
        wait(0.05);
    }
}

// Namespace namespace_7cee2b44
// Params 0, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_56c8d7bb
// Checksum 0xc87ec92c, Offset: 0x1388
// Size: 0x100
function function_56c8d7bb() {
    self endon(#"disconnect");
    while (true) {
        grenade, weapon = self waittill(#"grenade_launcher_fire");
        if (!is_wonder_weapon(weapon)) {
            continue;
        }
        if (!isdefined(grenade)) {
            continue;
        }
        if (!isdefined(self.chargeshotlevel)) {
            continue;
        }
        self.var_72053d6e = 0;
        var_e4a438f3 = self getweaponammoclip(self getcurrentweapon());
        var_d24bfa82 = self function_25db292d(var_e4a438f3 + 1);
        grenade thread function_74a68c49(self, var_d24bfa82);
    }
}

// Namespace namespace_7cee2b44
// Params 1, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_25db292d
// Checksum 0xba5691c4, Offset: 0x1490
// Size: 0xe0
function function_25db292d(var_e4a438f3) {
    if (var_e4a438f3 >= self.chargeshotlevel) {
        n_ammo = var_e4a438f3 - self.chargeshotlevel;
        self setweaponammoclip(self getcurrentweapon(), n_ammo);
        var_9780eb62 = self.chargeshotlevel;
    } else if (var_e4a438f3 > 1 && self.chargeshotlevel > var_e4a438f3) {
        self setweaponammoclip(self getcurrentweapon(), 0);
        var_9780eb62 = var_e4a438f3;
    } else {
        var_9780eb62 = var_e4a438f3;
    }
    return var_9780eb62;
}

// Namespace namespace_7cee2b44
// Params 2, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_74a68c49
// Checksum 0x92f1dc7e, Offset: 0x1578
// Size: 0x174
function function_74a68c49(player, var_d24bfa82) {
    self waittill(#"death");
    v_position = self.origin;
    v_angles = self.angles;
    if (!isdefined(v_position) || !isdefined(v_angles)) {
        return;
    }
    switch (var_d24bfa82) {
    case 1:
        player thread function_e0d7bd91(v_position);
        break;
    case 2:
    case 3:
        player thread function_1e4094ac(v_position, var_d24bfa82);
        break;
    default:
        player thread function_e0d7bd91(v_position);
        break;
    }
    level thread function_4a06c777(v_position, player);
    level thread function_508749d7(v_position, player);
    level thread function_570d6f32(v_position, player);
    level thread function_9844cc8a(v_position, player);
}

// Namespace namespace_7cee2b44
// Params 2, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_1e4094ac
// Checksum 0x881e80c6, Offset: 0x16f8
// Size: 0x17c
function function_1e4094ac(v_position, var_d24bfa82) {
    self endon(#"disconnect");
    v_pos = getclosestpointonnavmesh(v_position, 80);
    if (isdefined(v_pos)) {
        var_31678178 = util::spawn_model("tag_origin", v_pos);
        var_31678178 endon(#"death");
        if (self hasweapon(level.var_a4052592)) {
            var_a00b8053 = var_d24bfa82 + 1;
        } else {
            var_a00b8053 = var_d24bfa82 - 1;
        }
        var_31678178 clientfield::set("plant_killer", var_a00b8053);
        var_31678178 thread function_3604c7ec(self);
        self thread function_d3b8fbb0(v_pos, var_31678178);
        var_31678178 waittill(#"hash_2b1c6c7");
        var_31678178 clientfield::set("plant_killer", 0);
        wait(0.1);
        var_31678178 delete();
    }
}

// Namespace namespace_7cee2b44
// Params 1, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_3604c7ec
// Checksum 0xc26c17db, Offset: 0x1880
// Size: 0xb6
function function_3604c7ec(player) {
    self endon(#"death");
    player endon(#"disconnect");
    w_current_weapon = player getcurrentweapon();
    if (is_wonder_weapon(w_current_weapon, "upgraded")) {
        n_timeout = player.chargeshotlevel * 5;
    } else {
        n_timeout = player.chargeshotlevel * 3;
    }
    wait(n_timeout);
    self notify(#"hash_2b1c6c7");
}

// Namespace namespace_7cee2b44
// Params 2, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_d3b8fbb0
// Checksum 0x13dcd105, Offset: 0x1940
// Size: 0x2b4
function function_d3b8fbb0(v_pos, var_31678178) {
    self endon(#"disconnect");
    var_31678178 endon(#"hash_2b1c6c7");
    n_kills = 0;
    n_range_sq = self function_a1fce678(1);
    w_current_weapon = self getcurrentweapon();
    if (is_wonder_weapon(w_current_weapon, "upgraded")) {
        var_31678178.n_kills = 9;
    } else {
        var_31678178.n_kills = 6;
    }
    while (true) {
        a_ai_zombies = getaiteamarray(level.zombie_team);
        foreach (ai_zombie in a_ai_zombies) {
            if (isalive(ai_zombie) && !isdefined(ai_zombie.var_3f6ea790) && !(isdefined(ai_zombie.var_9d35623c) && ai_zombie.var_9d35623c)) {
                if (!(isdefined(ai_zombie.var_20b8c74a) && ai_zombie.var_20b8c74a) && function_8734b840(ai_zombie.origin, v_pos, n_range_sq)) {
                    self thread function_79504f13(ai_zombie, v_pos);
                    n_kills++;
                    if (n_kills >= var_31678178.n_kills) {
                        var_31678178 notify(#"hash_2b1c6c7");
                    }
                    if (!(isdefined(ai_zombie.var_61f7b3a0) && ai_zombie.var_61f7b3a0) && !(isdefined(ai_zombie.var_3940f450) && ai_zombie.var_3940f450)) {
                        wait(0.5);
                    }
                }
            }
        }
        wait(0.25);
    }
}

// Namespace namespace_7cee2b44
// Params 2, eflags: 0x0
// namespace_7cee2b44<file_0>::function_b6ac59ff
// Checksum 0xa559da82, Offset: 0x1c00
// Size: 0xb8
function function_b6ac59ff(v_pos, n_range_sq) {
    self endon(#"death");
    self.is_slowed = 1;
    self.var_317d58a6 = self.zombie_move_speed;
    self zombie_utility::set_zombie_run_cycle("walk");
    while (function_8734b840(self.origin, v_pos, n_range_sq)) {
        wait(0.5);
    }
    self zombie_utility::set_zombie_run_cycle(self.var_317d58a6);
    self.is_slowed = 0;
}

// Namespace namespace_7cee2b44
// Params 2, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_4a06c777
// Checksum 0x93f3ee7b, Offset: 0x1cc0
// Size: 0x122
function function_4a06c777(v_position, player) {
    if (!isdefined(level.var_1abc7758)) {
        return;
    }
    n_range_sq = player function_a1fce678();
    foreach (var_f58ff028 in level.var_1abc7758) {
        if (!isdefined(var_f58ff028.var_eec2cd7b)) {
            continue;
        }
        if (function_8734b840(var_f58ff028.origin, v_position, n_range_sq)) {
            var_f58ff028.var_eec2cd7b dodamage(1, v_position, player, player);
        }
    }
}

// Namespace namespace_7cee2b44
// Params 2, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_508749d7
// Checksum 0x48c44cc4, Offset: 0x1df0
// Size: 0x132
function function_508749d7(v_position, player) {
    player endon(#"disconnect");
    if (!isdefined(level.var_ac51aa3c)) {
        return;
    }
    n_range_sq = player function_a1fce678();
    foreach (var_a87feedd in level.var_ac51aa3c) {
        if (!(isdefined(var_a87feedd.var_75c7a97e) && var_a87feedd.var_75c7a97e)) {
            continue;
        }
        if (function_8734b840(var_a87feedd.origin, v_position, n_range_sq)) {
            var_a87feedd notify(#"hash_8dfde2c8");
            player notify(#"hash_e7c74581");
        }
    }
}

// Namespace namespace_7cee2b44
// Params 2, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_570d6f32
// Checksum 0x3e6aba17, Offset: 0x1f30
// Size: 0x132
function function_570d6f32(v_position, player) {
    player endon(#"disconnect");
    if (!isdefined(level.var_d3b40681)) {
        return;
    }
    n_range_sq = player function_a1fce678();
    foreach (trigger in level.var_d3b40681) {
        if (!(isdefined(trigger.var_f83345c7) && trigger.var_f83345c7)) {
            continue;
        }
        if (function_8734b840(trigger.origin, v_position, n_range_sq)) {
            trigger thread function_4a1cb794(player);
        }
    }
}

// Namespace namespace_7cee2b44
// Params 1, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_4a1cb794
// Checksum 0xfa36c998, Offset: 0x2070
// Size: 0x294
function function_4a1cb794(player) {
    self endon(#"death");
    player endon(#"disconnect");
    if (player hasweapon(level.var_a4052592)) {
        var_6d5757ae = 1;
    } else {
        var_6d5757ae = 0;
    }
    if (isdefined(self.var_1c12769f)) {
        v_origin = self.var_1c12769f.origin;
        v_angles = self.var_1c12769f.angles;
        switch (self.var_1c12769f.script_string) {
        case 40:
            if (var_6d5757ae) {
                self thread fx::play("bgb_web_ww_dissolve_ug", v_origin, v_angles);
            } else {
                self thread fx::play("bgb_web_ww_dissolve", v_origin, v_angles);
            }
            break;
        case 42:
            if (var_6d5757ae) {
                self thread fx::play("perk_web_ww_dissolve_ug", v_origin, v_angles);
            } else {
                self thread fx::play("perk_web_ww_dissolve", v_origin, v_angles);
            }
            break;
        case 41:
            if (var_6d5757ae) {
                self thread fx::play("doorbuy_web_ww_dissolve_ug", v_origin, v_angles);
            } else {
                self thread fx::play("doorbuy_web_ww_dissolve", v_origin, v_angles);
            }
            break;
        default:
            if (var_6d5757ae) {
                self thread fx::play("bgb_web_ww_dissolve_ug", v_origin, v_angles);
            } else {
                self thread fx::play("bgb_web_ww_dissolve", v_origin, v_angles);
            }
            break;
        }
    }
    if (isdefined(self.var_f83345c7) && self.var_f83345c7) {
        self notify(#"hash_bbf62f57");
        player.var_5c159c87 = 1;
        player namespace_27f8b154::function_20915a1a();
    }
}

// Namespace namespace_7cee2b44
// Params 2, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_79504f13
// Checksum 0x9df526a8, Offset: 0x2310
// Size: 0x104
function function_79504f13(ai_zombie, v_pos) {
    self endon(#"disconnect");
    ai_zombie endon(#"death");
    if (self hasweapon(level.var_a4052592)) {
        e_grenade = magicbullet(level.var_a4052592, v_pos, ai_zombie getcentroid());
    } else {
        e_grenade = magicbullet(level.var_5e75629a, v_pos, ai_zombie getcentroid());
    }
    if (isdefined(e_grenade)) {
        e_grenade thread function_74a68c49(self, 1);
        wait(0.5);
        self thread function_d150c3fe(ai_zombie);
    }
}

// Namespace namespace_7cee2b44
// Params 2, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_9844cc8a
// Checksum 0x614564bf, Offset: 0x2420
// Size: 0x12c
function function_9844cc8a(v_position, player) {
    player endon(#"disconnect");
    if (!isdefined(level.var_49c3bf90)) {
        return;
    }
    if (level flag::exists("spider_queen_weak_spot_exposed") && level flag::exists("spider_queen_dead")) {
        if (level flag::get("spider_queen_dead")) {
            return;
        }
        n_range_sq = player function_a1fce678();
        if (level flag::get("spider_queen_weak_spot_exposed")) {
            if (function_8734b840(level.var_49c3bf90.origin, v_position, n_range_sq)) {
                level.var_49c3bf90 dodamage(10, level.var_49c3bf90.origin, player, player);
            }
        }
    }
}

// Namespace namespace_7cee2b44
// Params 1, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_e0d7bd91
// Checksum 0x84e4ff88, Offset: 0x2558
// Size: 0x294
function function_e0d7bd91(v_position) {
    self endon(#"disconnect");
    a_ai_zombies = getaiteamarray(level.zombie_team);
    if (!a_ai_zombies.size) {
        return;
    }
    n_range_sq = self function_a1fce678();
    var_bd236d05 = 0;
    var_75e02ae0 = arraygetclosest(v_position, a_ai_zombies);
    if (function_8734b840(var_75e02ae0.origin, v_position, n_range_sq) && !(isdefined(var_75e02ae0.var_3f6ea790) && var_75e02ae0.var_3f6ea790)) {
        self thread function_d150c3fe(var_75e02ae0);
        arrayremovevalue(a_ai_zombies, var_75e02ae0);
        var_bd236d05++;
    }
    foreach (ai_zombie in a_ai_zombies) {
        if (isalive(ai_zombie) && !isdefined(ai_zombie.var_3f6ea790)) {
            if (function_8734b840(ai_zombie.origin, v_position, n_range_sq) && var_bd236d05 < 1) {
                self thread function_d150c3fe(ai_zombie);
                if (!(isdefined(ai_zombie.var_61f7b3a0) && ai_zombie.var_61f7b3a0)) {
                    var_bd236d05++;
                }
                if (!(isdefined(ai_zombie.var_61f7b3a0) && ai_zombie.var_61f7b3a0) && !(isdefined(ai_zombie.var_3940f450) && ai_zombie.var_3940f450)) {
                    wait(1);
                }
            }
        }
    }
}

// Namespace namespace_7cee2b44
// Params 1, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_d150c3fe
// Checksum 0xf2c76906, Offset: 0x27f8
// Size: 0x64c
function function_d150c3fe(ai_zombie) {
    self endon(#"disconnect");
    ai_zombie endon(#"death");
    if (isdefined(ai_zombie.var_61f7b3a0) && ai_zombie.var_61f7b3a0) {
        if (!(isdefined(ai_zombie.var_365c1d50) && ai_zombie.var_365c1d50)) {
            foreach (var_92b2f038 in ai_zombie.var_64d28ed0) {
                if (var_92b2f038.health > 0) {
                    var_278bf215 = var_92b2f038;
                    break;
                }
            }
            if (isdefined(ai_zombie.maxhealth) && isdefined(var_278bf215)) {
                switch (self.chargeshotlevel) {
                case 1:
                    ai_zombie dodamage(var_278bf215.maxhealth / 2, ai_zombie gettagorigin(var_278bf215.tag), self);
                    ai_zombie thread function_dadca53(1.5);
                    break;
                case 2:
                    ai_zombie dodamage(var_278bf215.maxhealth / 2, ai_zombie gettagorigin(var_278bf215.tag), self);
                    ai_zombie thread function_dadca53(0.75);
                    break;
                case 3:
                    ai_zombie dodamage(var_278bf215.maxhealth / 2, ai_zombie gettagorigin(var_278bf215.tag), self);
                    ai_zombie thread function_dadca53(0.5);
                    break;
                default:
                    ai_zombie dodamage(var_278bf215.maxhealth / 2, ai_zombie gettagorigin(var_278bf215.tag), self);
                    ai_zombie thread function_dadca53(1.5);
                    return;
                }
            }
        }
        return;
    }
    if (ai_zombie.var_3f6ea790 !== 1 && !(isdefined(ai_zombie.var_20b8c74a) && ai_zombie.var_20b8c74a) && !(isdefined(ai_zombie.var_34d00e7) && ai_zombie.var_34d00e7) && !(isdefined(ai_zombie.var_9d35623c) && ai_zombie.var_9d35623c)) {
        ai_zombie ai::set_ignoreall(1);
        ai_zombie.var_3f6ea790 = 1;
        ai_zombie notify(#"hash_87952665");
        if (!(isdefined(ai_zombie.var_3940f450) && ai_zombie.var_3940f450) && !(isdefined(ai_zombie.var_2f846873) && ai_zombie.var_2f846873)) {
            if (zm_utility::is_player_valid(self)) {
                self notify(#"hash_9befe1fc");
            }
            ai_zombie.ignore_game_over_death = 1;
            if (isdefined(ai_zombie.missinglegs) && ai_zombie.missinglegs) {
                ai_zombie function_b7e68127(1);
            } else {
                ai_zombie function_b7e68127(0);
            }
            self.var_72053d6e++;
            if (self.var_72053d6e >= 10) {
                self notify(#"hash_cf72c127");
            }
            self thread function_3bc42e24(ai_zombie);
        }
        if (isdefined(ai_zombie.var_3940f450) && ai_zombie.var_3940f450) {
            if (self hasweapon(level.var_a4052592)) {
                ai_zombie clientfield::set("mirg2000_spider_death_fx", 2);
            } else {
                ai_zombie clientfield::set("mirg2000_spider_death_fx", 1);
            }
        }
        if (!(isdefined(ai_zombie.var_3940f450) && ai_zombie.var_3940f450)) {
            level thread zm_spawner::zombie_death_points(ai_zombie.origin, "MOD_EXPLOSIVE", "head", self, ai_zombie);
        }
        ai_zombie thread zombie_utility::zombie_gut_explosion();
        ai_zombie dodamage(ai_zombie.health, ai_zombie.origin, self);
    }
}

// Namespace namespace_7cee2b44
// Params 1, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_3bc42e24
// Checksum 0x4b657d12, Offset: 0x2e50
// Size: 0x192
function function_3bc42e24(var_8b84dc1b) {
    a_ai_zombies = getaiteamarray(level.zombie_team);
    var_5074f697 = var_8b84dc1b getcentroid();
    n_range_sq = self function_a1fce678();
    arrayremovevalue(a_ai_zombies, var_8b84dc1b);
    foreach (var_fd970238 in a_ai_zombies) {
        if (isalive(var_fd970238) && !(isdefined(var_fd970238.var_3f6ea790) && var_fd970238.var_3f6ea790) && function_8734b840(var_fd970238.origin, var_5074f697, n_range_sq)) {
            var_fd970238 function_794992bd(self, var_5074f697);
            util::wait_network_frame();
        }
    }
}

// Namespace namespace_7cee2b44
// Params 1, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_b7e68127
// Checksum 0x94530d4f, Offset: 0x2ff0
// Size: 0x174
function function_b7e68127(var_7364b0dd) {
    self endon(#"death");
    if (!isdefined(level.var_d290a02b)) {
        level.var_d290a02b = 0;
    }
    if (!isdefined(level.var_7a9b882a)) {
        level.var_7a9b882a = 0;
    }
    self.marked_for_death = 1;
    if (var_7364b0dd) {
        level.var_d290a02b++;
        if (level.var_d290a02b > 2) {
            level.var_d290a02b = 1;
        }
        if (isalive(self) && !self isragdoll()) {
            self scene::play("p7_fxanim_zm_island_mirg_trap_crawl_" + level.var_d290a02b + "_bundle", self);
        }
        return;
    }
    level.var_7a9b882a++;
    if (level.var_7a9b882a > 5) {
        level.var_7a9b882a = 1;
    }
    if (isalive(self) && !self isragdoll()) {
        self scene::play("p7_fxanim_zm_island_mirg_trap_" + level.var_7a9b882a + "_bundle", self);
    }
}

// Namespace namespace_7cee2b44
// Params 1, eflags: 0x1 linked
// namespace_7cee2b44<file_0>::function_dadca53
// Checksum 0xd133573a, Offset: 0x3170
// Size: 0x48
function function_dadca53(var_2b49e04f) {
    if (!isdefined(var_2b49e04f)) {
        var_2b49e04f = 1;
    }
    self endon(#"death");
    self.var_365c1d50 = 1;
    wait(var_2b49e04f);
    self.var_365c1d50 = 0;
}

// Namespace namespace_7cee2b44
// Params 15, eflags: 0x0
// namespace_7cee2b44<file_0>::function_24d57358
// Checksum 0x4a551a9f, Offset: 0x31c0
// Size: 0xc4
function function_24d57358(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (isdefined(weapon)) {
        if (function_b926526f(weapon) && !(isdefined(self.var_91bc5bf2) && self.var_91bc5bf2)) {
            idamage = 0;
        }
    }
    return idamage;
}

