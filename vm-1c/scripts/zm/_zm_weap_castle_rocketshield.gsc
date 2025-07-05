#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_riotshield;
#using scripts/zm/_zm_weapons;
#using scripts/zm/craftables/_zm_craft_shield;
#using scripts/zm/zm_castle_vo;

#namespace namespace_48e69557;

// Namespace namespace_48e69557
// Params 0, eflags: 0x2
// Checksum 0x57b348d5, Offset: 0x610
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_weap_castle_rocketshield", &__init__, &__main__, undefined);
}

// Namespace namespace_48e69557
// Params 0, eflags: 0x0
// Checksum 0x17500068, Offset: 0x658
// Size: 0x13c
function __init__() {
    zm_craft_shield::init("craft_shield_zm", "castle_riotshield", "wpn_t7_zmb_zod_rocket_shield_world");
    clientfield::register("allplayers", "rs_ammo", 1, 1, "int");
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    level.weaponriotshield = getweapon("castle_riotshield");
    zm_equipment::register("castle_riotshield", %ZOMBIE_EQUIP_RIOTSHIELD_PICKUP_HINT_STRING, %ZOMBIE_EQUIP_RIOTSHIELD_HOWTO, undefined, "riotshield");
    level.var_cff260cc = getweapon("castle_riotshield_upgraded");
    zm_equipment::register("castle_riotshield_upgraded", %ZOMBIE_EQUIP_RIOTSHIELD_PICKUP_HINT_STRING, %ZOMBIE_EQUIP_RIOTSHIELD_HOWTO, undefined, "riotshield");
}

// Namespace namespace_48e69557
// Params 0, eflags: 0x0
// Checksum 0x252e4dc0, Offset: 0x7a0
// Size: 0x214
function __main__() {
    zm_equipment::register_for_level("castle_riotshield");
    zm_equipment::include("castle_riotshield");
    zm_equipment::set_ammo_driven("castle_riotshield", level.weaponriotshield.startammo, 1);
    zm_equipment::register_for_level("castle_riotshield_upgraded");
    zm_equipment::include("castle_riotshield_upgraded");
    zm_equipment::set_ammo_driven("castle_riotshield_upgraded", level.var_cff260cc.startammo, 1);
    setdvar("juke_enabled", 1);
    zombie_utility::set_zombie_var("riotshield_fling_damage_shield", 100);
    zombie_utility::set_zombie_var("riotshield_knockdown_damage_shield", 15);
    zombie_utility::set_zombie_var("riotshield_juke_damage_shield", 0);
    zombie_utility::set_zombie_var("riotshield_fling_force_juke", -81);
    zombie_utility::set_zombie_var("riotshield_fling_range", 120);
    zombie_utility::set_zombie_var("riotshield_gib_range", 120);
    zombie_utility::set_zombie_var("riotshield_knockdown_range", 120);
    level thread function_4301c4bc();
    level.var_a7e9c2bf["craft_shield_zm"].v_origin_offset = (0, 0, 30);
    /#
        level thread function_3f94d6cf();
    #/
}

// Namespace namespace_48e69557
// Params 0, eflags: 0x0
// Checksum 0x62e18907, Offset: 0x9c0
// Size: 0x34
function on_player_connect() {
    self thread function_e8141489();
    self thread function_bbf98b84();
}

// Namespace namespace_48e69557
// Params 0, eflags: 0x0
// Checksum 0xeeb34bcd, Offset: 0xa00
// Size: 0x74
function function_e8141489() {
    self endon(#"disconnect");
    while (isdefined(self)) {
        self waittill(#"weapon_change", w_weapon);
        if (w_weapon.isriotshield) {
            break;
        }
    }
    self.var_ed53639f = 1;
    zm_equipment::show_hint_text(%ZM_CASTLE_ROCKET_HINT, 5);
}

// Namespace namespace_48e69557
// Params 0, eflags: 0x0
// Checksum 0xd687adaa, Offset: 0xa80
// Size: 0x60
function function_bbf98b84() {
    self endon(#"disconnect");
    while (isdefined(self)) {
        level waittill(#"shield_built", e_who);
        if (e_who === self) {
            self playrumbleonentity("zm_castle_interact_rumble");
        }
    }
}

// Namespace namespace_48e69557
// Params 0, eflags: 0x0
// Checksum 0xd5fe91f9, Offset: 0xae8
// Size: 0x4c
function on_player_spawned() {
    self thread function_aace298e();
    self thread function_9fdb0cd6();
    self thread function_3fbc315a();
}

// Namespace namespace_48e69557
// Params 0, eflags: 0x0
// Checksum 0x85c7760, Offset: 0xb40
// Size: 0xc8
function function_9fdb0cd6() {
    self notify(#"hash_9fdb0cd6");
    self endon(#"hash_9fdb0cd6");
    for (;;) {
        self waittill(#"equipment_ammo_changed", equipment);
        if (isstring(equipment)) {
            equipment = getweapon(equipment);
        }
        if (equipment == getweapon("castle_riotshield") || equipment == getweapon("castle_riotshield_upgraded")) {
            self thread function_7221d39f(equipment);
        }
    }
}

// Namespace namespace_48e69557
// Params 0, eflags: 0x0
// Checksum 0x275f5d62, Offset: 0xc10
// Size: 0x68
function function_3fbc315a() {
    self notify(#"hash_3fbc315a");
    self endon(#"hash_3fbc315a");
    for (;;) {
        self waittill(#"zmb_max_ammo");
        wait 0.05;
        if (isdefined(self.hasriotshield) && self.hasriotshield) {
            self thread function_7221d39f(self.weaponriotshield);
        }
    }
}

// Namespace namespace_48e69557
// Params 1, eflags: 0x0
// Checksum 0xd01e0872, Offset: 0xc80
// Size: 0x64
function function_7221d39f(weapon) {
    wait 0.05;
    if (isdefined(self)) {
        ammo = self getweaponammoclip(weapon);
        self clientfield::set("rs_ammo", ammo);
    }
}

// Namespace namespace_48e69557
// Params 0, eflags: 0x0
// Checksum 0x46241c3f, Offset: 0xcf0
// Size: 0xf6
function function_aace298e() {
    self notify(#"hash_aace298e");
    self endon(#"hash_aace298e");
    for (;;) {
        self waittill(#"weapon_melee_juke", weapon);
        if (weapon.isriotshield) {
            self disableoffhandweapons();
            self playsound("zmb_rocketshield_start");
            self function_f9e0085b(weapon);
            self playsound("zmb_rocketshield_end");
            self enableoffhandweapons();
            self thread function_7221d39f(weapon);
            self notify(#"hash_45488759");
        }
    }
}

// Namespace namespace_48e69557
// Params 1, eflags: 0x0
// Checksum 0x51e891b7, Offset: 0xdf0
// Size: 0x2c8
function function_f9e0085b(weapon) {
    self endon(#"weapon_melee");
    self endon(#"weapon_melee_power");
    self endon(#"weapon_melee_charge");
    var_27e95375 = 0;
    start_time = gettime();
    if (!isdefined(level.riotshield_knockdown_enemies)) {
        level.riotshield_knockdown_enemies = [];
    }
    if (!isdefined(level.riotshield_knockdown_gib)) {
        level.riotshield_knockdown_gib = [];
    }
    if (!isdefined(level.riotshield_fling_enemies)) {
        level.riotshield_fling_enemies = [];
    }
    if (!isdefined(level.riotshield_fling_vecs)) {
        level.riotshield_fling_vecs = [];
    }
    while (start_time + 3000 > gettime()) {
        self playrumbleonentity("zod_shield_juke");
        forward = anglestoforward(self getplayerangles());
        shield_damage = 0;
        enemies = function_dd62c0c2();
        if (isdefined(level.var_72c07c3f) && isfunctionptr(level.var_72c07c3f)) {
            [[ level.var_72c07c3f ]](enemies);
        }
        foreach (zombie in enemies) {
            self playsound("zmb_rocketshield_imp");
            zombie thread riotshield::riotshield_fling_zombie(self, zombie.fling_vec, 0);
            shield_damage += level.zombie_vars["riotshield_juke_damage_shield"];
            if (!var_27e95375) {
                self thread zm_castle_vo::function_c166f48();
                var_27e95375 = 1;
            }
        }
        if (shield_damage) {
            self riotshield::player_damage_shield(shield_damage, 0);
        }
        level.riotshield_knockdown_enemies = [];
        level.riotshield_knockdown_gib = [];
        level.riotshield_fling_enemies = [];
        level.riotshield_fling_vecs = [];
        wait 0.1;
    }
}

/#

    // Namespace namespace_48e69557
    // Params 0, eflags: 0x0
    // Checksum 0x206269ee, Offset: 0x10c0
    // Size: 0x15e
    function function_92debe0a() {
        level waittill(#"start_of_round");
        foreach (player in getplayers()) {
        }
        while (true) {
            level waittill(#"start_of_round");
            foreach (player in getplayers()) {
                if (isdefined(player.hasriotshield) && player.hasriotshield) {
                    player givestartammo(player.weaponriotshield);
                }
            }
        }
    }

#/

// Namespace namespace_48e69557
// Params 0, eflags: 0x0
// Checksum 0x5b8fc41f, Offset: 0x1228
// Size: 0x356
function function_dd62c0c2() {
    view_pos = self.origin;
    zombies = array::get_all_closest(view_pos, getaiteamarray(level.zombie_team), undefined, undefined, 120);
    if (!isdefined(zombies)) {
        return;
    }
    forward = anglestoforward(self getplayerangles());
    up = anglestoup(self getplayerangles());
    var_e09fef25 = view_pos + 36 * forward;
    var_faa0b366 = var_e09fef25 + (120 - 36) * forward;
    fling_force = level.zombie_vars["riotshield_fling_force_juke"];
    var_7ae8c5ad = fling_force * 0.5;
    var_b2aa696f = fling_force * 0.6;
    enemies = [];
    for (i = 0; i < zombies.size; i++) {
        if (!isdefined(zombies[i]) || !isalive(zombies[i])) {
            continue;
        }
        if (zombies[i].archetype == "margwa") {
            continue;
        }
        test_origin = zombies[i] getcentroid();
        radial_origin = pointonsegmentnearesttopoint(var_e09fef25, var_faa0b366, test_origin);
        var_6c1219a = test_origin - radial_origin;
        if (abs(var_6c1219a[2]) > 72) {
            continue;
        }
        var_6c1219a = (var_6c1219a[0], var_6c1219a[1], 0);
        len = length(var_6c1219a);
        if (len > 36) {
            continue;
        }
        var_6c1219a = (var_6c1219a[0], var_6c1219a[1], 0);
        zombies[i].fling_vec = fling_force * forward + randomfloatrange(var_7ae8c5ad, var_b2aa696f) * up;
        enemies[enemies.size] = zombies[i];
    }
    return enemies;
}

// Namespace namespace_48e69557
// Params 0, eflags: 0x0
// Checksum 0xe1ec2936, Offset: 0x1588
// Size: 0x23c
function function_4301c4bc() {
    level flag::wait_till("all_players_spawned");
    n_spawned = 0;
    n_charges = level.players.size + 3;
    var_f4f18733 = array::randomize(struct::get_array("castle_shield_charge"));
    /#
        level thread function_fc8bb1d(var_f4f18733);
    #/
    foreach (var_67dac978 in var_f4f18733) {
        if (isdefined(var_67dac978.spawned) && var_67dac978.spawned) {
            n_spawned++;
        }
    }
    foreach (var_67dac978 in var_f4f18733) {
        if (n_spawned < n_charges) {
            if (!(isdefined(var_67dac978.spawned) && var_67dac978.spawned)) {
                var_67dac978 thread function_c94e27cd(var_67dac978.origin, var_67dac978.angles);
                n_spawned++;
            }
            continue;
        }
        break;
    }
    level waittill(#"start_of_round");
    level thread function_4301c4bc();
}

// Namespace namespace_48e69557
// Params 2, eflags: 0x0
// Checksum 0xba21900c, Offset: 0x17d0
// Size: 0x290
function function_c94e27cd(v_origin, v_angles) {
    s_struct = self;
    if (self == level) {
        s_struct = spawnstruct();
        s_struct.origin = v_origin;
        s_struct.angles = v_angles;
    }
    width = -128;
    height = -128;
    length = -128;
    unitrigger_stub = spawnstruct();
    unitrigger_stub.origin = v_origin;
    unitrigger_stub.angles = v_angles;
    unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    unitrigger_stub.script_width = width;
    unitrigger_stub.script_height = height;
    unitrigger_stub.script_length = length;
    unitrigger_stub.require_look_at = 0;
    unitrigger_stub.var_8fcb4b32 = spawn("script_model", v_origin);
    modelname = "p7_zm_zod_nitrous_tank";
    if (isdefined(s_struct.model) && isstring(s_struct.model)) {
        modelname = s_struct.model;
    }
    unitrigger_stub.var_8fcb4b32 setmodel(modelname);
    unitrigger_stub.var_8fcb4b32.angles = v_angles;
    s_struct.spawned = 1;
    unitrigger_stub.var_7aed589c = s_struct;
    unitrigger_stub.prompt_and_visibility_func = &function_299e82af;
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_defde6ba);
    return unitrigger_stub;
}

/#

    // Namespace namespace_48e69557
    // Params 1, eflags: 0x0
    // Checksum 0xd96273ed, Offset: 0x1a68
    // Size: 0x166
    function function_fc8bb1d(a_spawnpoints) {
        level notify(#"hash_afd0dfa9");
        level endon(#"hash_afd0dfa9");
        while (true) {
            var_228edad9 = getdvarint("<dev string:x28>", 0);
            if (var_228edad9 > 0) {
                foreach (spawnpoint in a_spawnpoints) {
                    v_color = (1, 1, 1);
                    if (isdefined(spawnpoint.spawned) && spawnpoint.spawned) {
                        v_color = (0, 1, 0);
                    }
                    sphere(spawnpoint.origin, 25, v_color, 0.1, 0, 25, 10);
                }
            }
            wait 10 * 0.05;
        }
    }

#/

// Namespace namespace_48e69557
// Params 1, eflags: 0x0
// Checksum 0x6d69e46f, Offset: 0x1bd8
// Size: 0xca
function function_299e82af(player) {
    self sethintstring(%ZM_CASTLE_PICKUP_BOTTLE);
    if (!(isdefined(player.hasriotshield) && player.hasriotshield) || player getammocount(player.weaponriotshield) == player.weaponriotshield.maxammo) {
        b_is_invis = 1;
    } else {
        b_is_invis = 0;
    }
    self setinvisibletoplayer(player, b_is_invis);
    return !b_is_invis;
}

// Namespace namespace_48e69557
// Params 0, eflags: 0x0
// Checksum 0xd2301469, Offset: 0x1cb0
// Size: 0xa4
function function_defde6ba() {
    while (true) {
        self waittill(#"trigger", player);
        if (player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (player.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(player)) {
            continue;
        }
        level thread function_5c7f3b20(self.stub, player);
        break;
    }
}

// Namespace namespace_48e69557
// Params 2, eflags: 0x0
// Checksum 0xdb8f4b56, Offset: 0x1d60
// Size: 0x10a
function function_5c7f3b20(var_91089b66, player) {
    var_91089b66 notify(#"hash_c2022405");
    if (isdefined(player.hasriotshield) && player.hasriotshield) {
        player zm_equipment::change_ammo(player.weaponriotshield, 1);
    }
    v_origin = var_91089b66.var_8fcb4b32.origin;
    v_angles = var_91089b66.var_8fcb4b32.angles;
    var_91089b66.var_8fcb4b32 delete();
    zm_unitrigger::unregister_unitrigger(var_91089b66);
    var_91089b66.var_7aed589c.spawned = undefined;
}

/#

    // Namespace namespace_48e69557
    // Params 0, eflags: 0x0
    // Checksum 0xc244a8d0, Offset: 0x1e78
    // Size: 0xda
    function function_3f94d6cf() {
        level flagsys::wait_till("<dev string:x4c>");
        wait 1;
        zm_devgui::add_custom_devgui_callback(&function_e2f5a93);
        adddebugcommand("<dev string:x65>");
        adddebugcommand("<dev string:xb4>");
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            ip1 = i + 1;
        }
    }

    // Namespace namespace_48e69557
    // Params 1, eflags: 0x0
    // Checksum 0x1b44271f, Offset: 0x1f60
    // Size: 0xd0
    function function_e2f5a93(cmd) {
        players = getplayers();
        retval = 0;
        switch (cmd) {
        case "<dev string:x116>":
            array::thread_all(players, &zm_devgui::zombie_devgui_equipment_give, "<dev string:x128>");
            retval = 1;
            break;
        case "<dev string:x13a>":
            array::thread_all(players, &function_3796f8bc);
            retval = 1;
            break;
        }
        return retval;
    }

    // Namespace namespace_48e69557
    // Params 0, eflags: 0x0
    // Checksum 0xf37cd911, Offset: 0x2038
    // Size: 0x38
    function function_2449723c() {
        if (isdefined(self.var_9dc82bca)) {
            if (self.var_9dc82bca == gettime()) {
                return 1;
            }
        }
        self.var_9dc82bca = gettime();
        return 0;
    }

    // Namespace namespace_48e69557
    // Params 0, eflags: 0x0
    // Checksum 0x5ceb888f, Offset: 0x2078
    // Size: 0x154
    function function_3796f8bc() {
        if (self function_2449723c()) {
            return;
        }
        self notify(#"hash_3796f8bc");
        self endon(#"hash_3796f8bc");
        level flagsys::wait_till("<dev string:x4c>");
        self.var_3796f8bc = !(isdefined(self.var_3796f8bc) && self.var_3796f8bc);
        if (self.var_3796f8bc) {
            while (isdefined(self)) {
                damagemax = level.weaponriotshield.weaponstarthitpoints;
                if (isdefined(self.weaponriotshield)) {
                    damagemax = self.weaponriotshield.weaponstarthitpoints;
                }
                shieldhealth = self damageriotshield(0);
                if (shieldhealth == 0) {
                    shieldhealth = self damageriotshield(damagemax * -1);
                } else {
                    shieldhealth = self damageriotshield(int(damagemax / 10));
                }
                wait 0.5;
            }
        }
    }

#/
