#using scripts/zm/zm_genesis_util;
#using scripts/zm/zm_genesis_power;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_ai_margwa_elemental;
#using scripts/zm/_zm;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_6b38abe3;

// Namespace namespace_6b38abe3
// Params 0, eflags: 0x2
// Checksum 0x1b3dfa48, Offset: 0xca0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_genesis_wearables", &__init__, undefined, undefined);
}

// Namespace namespace_6b38abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x2b3a9a78, Offset: 0xce0
// Size: 0x204
function __init__() {
    clientfield::register("scriptmover", "battery_fx", 15000, 2, "int");
    clientfield::register("clientuimodel", "zmInventory.wearable_perk_icons", 15000, 2, "int");
    zm_spawner::register_zombie_death_event_callback(&function_9d85b9ce);
    zm_spawner::register_zombie_damage_callback(&function_cb27f92e);
    for (i = 0; i < 4; i++) {
        registerclientfield("world", "player" + i + "wearableItem", 15000, 4, "int");
    }
    level thread function_aa6437f1();
    level thread function_b4575902();
    level thread function_796904fd();
    level thread function_4fddc919();
    level thread function_6d72c0dc();
    level thread function_8454afd5();
    level thread function_3167c564();
    level thread function_37ba4813();
    /#
        zm_devgui::add_custom_devgui_callback(&function_82e9c58d);
        level thread function_e8a31296();
    #/
}

// Namespace namespace_6b38abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x16e4d927, Offset: 0xef0
// Size: 0x84
function function_2436f867() {
    self notify(#"hash_2436f867");
    self endon(#"hash_2436f867");
    self util::waittill_any("disconnect", "bled_out", "death");
    self.var_bc5f242a = undefined;
    function_b712ee6f(0);
    function_30fb8e63(0);
}

// Namespace namespace_6b38abe3
// Params 1, eflags: 0x1 linked
// Checksum 0xec71efc0, Offset: 0xf80
// Size: 0x3c
function function_b712ee6f(var_908867a0) {
    level clientfield::set("player" + self.entity_num + "wearableItem", var_908867a0);
}

// Namespace namespace_6b38abe3
// Params 1, eflags: 0x1 linked
// Checksum 0x3c64be7a, Offset: 0xfc8
// Size: 0x2c
function function_30fb8e63(n_perks) {
    self clientfield::set_player_uimodel("zmInventory.wearable_perk_icons", n_perks);
}

// Namespace namespace_6b38abe3
// Params 4, eflags: 0x1 linked
// Checksum 0xd1dd04eb, Offset: 0x1000
// Size: 0x194
function function_f6b20985(var_8fca9f8c, var_f48b681c, str_tag, var_f3776824) {
    s_loc = struct::get(var_8fca9f8c, "targetname");
    level.var_6d65545f = spawn("script_model", s_loc.origin);
    level.var_6d65545f.angles = s_loc.angles;
    level.var_6d65545f setmodel(var_f48b681c);
    var_750a9baa = s_loc zm_unitrigger::create_unitrigger(%ZM_GENESIS_WEARABLE_PICKUP, undefined, &function_24061b58, &function_7f0ec71c);
    var_750a9baa.var_f4b4f2f2 = var_f48b681c;
    var_750a9baa.str_tag = str_tag;
    var_750a9baa.var_475b0a4e = var_8fca9f8c;
    v_offset = (0, 0, var_f3776824);
    var_750a9baa.origin += v_offset;
    zm_unitrigger::unitrigger_force_per_player_triggers(var_750a9baa, 1);
}

// Namespace namespace_6b38abe3
// Params 1, eflags: 0x1 linked
// Checksum 0x5e459be1, Offset: 0x11a0
// Size: 0x9a
function function_24061b58(e_player) {
    if (isdefined(e_player.var_bc5f242a) && e_player.var_bc5f242a.str_model === self.stub.var_f4b4f2f2) {
        self sethintstring(%ZM_GENESIS_WEARABLE_EQUIPPED);
        return 0;
    }
    self sethintstring(%ZM_GENESIS_WEARABLE_PICKUP);
    return 1;
}

// Namespace namespace_6b38abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x34f01979, Offset: 0x1248
// Size: 0xf0
function function_7f0ec71c() {
    self endon(#"death");
    while (true) {
        self trigger::wait_till();
        e_player = self.who;
        if (!isdefined(e_player.var_bc5f242a)) {
            e_player.var_bc5f242a = spawnstruct();
        }
        e_player function_e5974b49();
        str_tag = self.stub.str_tag;
        var_475b0a4e = self.stub.var_475b0a4e;
        e_player function_a16ce474(self.stub.var_f4b4f2f2, var_475b0a4e, str_tag);
    }
}

// Namespace namespace_6b38abe3
// Params 3, eflags: 0x1 linked
// Checksum 0x4b93df8c, Offset: 0x1340
// Size: 0x60e
function function_a16ce474(str_model, var_475b0a4e, str_tag) {
    self function_e5515520();
    self.var_bc5f242a.str_model = str_model;
    self.var_bc5f242a.str_tag = str_tag;
    self attach(self.var_bc5f242a.str_model, str_tag);
    self playsound("zmb_craftable_pickup");
    self notify(#"changed_wearable", var_475b0a4e);
    self thread function_2436f867();
    switch (var_475b0a4e) {
    case "s_weasels_hat":
        self playsound("zmb_wearable_weasel_wear");
        self function_b712ee6f(1);
        self function_30fb8e63(0);
        break;
    case "s_helm_of_siegfried":
        self playsound("zmb_wearable_siegfried_wear");
        self thread function_edd475ab(20, 10, "c_zom_dlc4_player_siegfried_helmet");
        self.var_5feb5a44 = 45;
        self zm_perks::function_78f42790("health_reboot", 0, 0);
        self function_b712ee6f(2);
        self function_30fb8e63(2);
        break;
    case "s_helm_of_the_king":
        self playsound("zmb_wearable_mechz_wear");
        self.var_e1384d1e = 0.5;
        self.var_ad21546 = 0.5;
        self.var_13804b27 = 1.33;
        self.var_bbd3efb8 = 1.33;
        self.ctffriendlyflagreturned = 1;
        self setperk("specialty_tombstone");
        self function_b712ee6f(4);
        self function_30fb8e63(1);
        break;
    case "s_dire_wolf_head":
        self playsound("zmb_wearable_wolf_wear");
        self setperk("specialty_tombstone");
        self thread function_edd475ab(20, 10, "c_zom_dlc4_player_direwolf_helmet");
        self function_b712ee6f(7);
        self function_30fb8e63(1);
        break;
    case "s_margwa_head":
        self playsound("zmb_wearable_margwa_wear");
        self.var_e1384d1e = 0.5;
        self.var_13804b27 = 1.33;
        self setperk("specialty_tombstone");
        self function_b712ee6f(6);
        self function_30fb8e63(1);
        break;
    case "s_keeper_skull_head":
        self playsound("zmb_wearable_keeper_wear");
        self.var_5feb5a44 = 45;
        self zm_perks::function_78f42790("health_reboot", 0, 0);
        self.var_e7f63e2e = 30;
        self.var_ebafd972 = 0.5;
        self.var_74fe492b = 1;
        self function_b712ee6f(5);
        self function_30fb8e63(2);
        break;
    case "s_apothicon_mask":
        self playsound("zmb_wearable_apothigod_wear");
        self.var_e8e8daad = 1;
        self.var_bcff1de = 1;
        self.var_13804b27 = 1.5;
        self.var_bbd3efb8 = 1.5;
        self setperk("specialty_tombstone");
        self.var_5feb5a44 = 45;
        self zm_perks::function_78f42790("health_reboot", 0, 0);
        self function_b712ee6f(3);
        self function_30fb8e63(3);
        break;
    case "s_fury_head":
        self playsound("zmb_wearable_fury_wear");
        self.var_eef0616b = 0.66;
        self.var_15c79ed8 = 1;
        self.var_5feb5a44 = 45;
        self zm_perks::function_78f42790("health_reboot", 0, 0);
        self function_b712ee6f(8);
        self function_30fb8e63(2);
        break;
    }
}

// Namespace namespace_6b38abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x11624876, Offset: 0x1958
// Size: 0x86
function function_e5515520() {
    var_77268fe9 = self getcharacterbodymodel();
    switch (var_77268fe9) {
    case "c_zom_dlc3_nikolai_mpc_fb":
        self setcharacterbodystyle(2);
        break;
    case "c_zom_dlc3_takeo_mpc_fb":
        self setcharacterbodystyle(2);
        break;
    }
}

// Namespace namespace_6b38abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x121e0f29, Offset: 0x19e8
// Size: 0x134
function function_e5974b49() {
    self notify(#"hash_baf651e0");
    self.var_e8e8daad = undefined;
    self.var_bcff1de = undefined;
    self.var_e1384d1e = undefined;
    self.var_ad21546 = undefined;
    self.var_13804b27 = undefined;
    self.var_bbd3efb8 = undefined;
    self.var_e7f63e2e = undefined;
    self.var_ebafd972 = undefined;
    self.b_no_trap_damage = undefined;
    self.var_74fe492b = undefined;
    self.var_adaec269 = undefined;
    self.ctffriendlyflagreturned = undefined;
    self.var_eef0616b = undefined;
    self.var_15c79ed8 = undefined;
    self.var_5feb5a44 = undefined;
    self zm_perks::function_78f42790("health_reboot", 0, 0);
    if (self hasperk("specialty_tombstone")) {
        self unsetperk("specialty_tombstone");
    }
    if (isdefined(self.var_bc5f242a.str_model)) {
        self detach(self.var_bc5f242a.str_model, self.var_bc5f242a.str_tag);
    }
}

// Namespace namespace_6b38abe3
// Params 0, eflags: 0x1 linked
// Checksum 0xd1fc1244, Offset: 0x1b28
// Size: 0x3c
function function_aa6437f1() {
    level waittill(#"all_players_spawned");
    function_f6b20985("s_weasels_hat", "c_zom_dlc4_player_arlington_helmet", "j_head", 0);
}

// Namespace namespace_6b38abe3
// Params 0, eflags: 0x1 linked
// Checksum 0xf157f5e6, Offset: 0x1b70
// Size: 0x304
function function_b4575902() {
    var_66b0cbbe = struct::get_array("ancient_battery", "targetname");
    var_5a533244 = [];
    foreach (var_d186cfae in var_66b0cbbe) {
        var_8d2dd868 = util::spawn_model("p7_zm_ctl_battery_ceramic", var_d186cfae.origin, var_d186cfae.angles);
        var_8d2dd868.target = var_d186cfae.target;
        if (!isdefined(var_5a533244)) {
            var_5a533244 = [];
        } else if (!isarray(var_5a533244)) {
            var_5a533244 = array(var_5a533244);
        }
        var_5a533244[var_5a533244.size] = var_8d2dd868;
    }
    function_9157236c();
    foreach (var_8d2dd868 in var_5a533244) {
        var_8d2dd868 clientfield::set("battery_fx", 1);
    }
    function_b8449f8c(var_5a533244);
    foreach (var_8d2dd868 in var_5a533244) {
        var_8d2dd868 clientfield::set("battery_fx", 0);
    }
    playsoundatposition("zmb_wearable_siegfried_horn_1", (0, 0, 0));
    /#
        iprintlnbold("<dev string:x28>");
    #/
    function_f6b20985("s_helm_of_siegfried", "c_zom_dlc4_player_siegfried_helmet", "j_head", 0);
}

// Namespace namespace_6b38abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x795e943b, Offset: 0x1e80
// Size: 0x2b4
function function_9157236c() {
    var_7bd91d87 = struct::get_array("s_ee_clock", "targetname");
    var_687cab15 = getent("ee_grand_tour_undercroft", "targetname");
    var_687cab15 setcandamage(1);
    n_stage = 9;
    var_c52419ba = 1;
    while (var_c52419ba) {
        damage, attacker, direction_vec, v_point, type, modelname, tagname, partname, weapon, idflags = var_687cab15 waittill(#"damage");
        n_closest = 9999999;
        s_closest = var_7bd91d87[0];
        for (i = 0; i < var_7bd91d87.size; i++) {
            n_dist = distance(var_7bd91d87[i].origin, v_point);
            if (n_dist < n_closest) {
                n_closest = n_dist;
                s_closest = var_7bd91d87[i];
            }
        }
        switch (n_stage) {
        case 9:
            if (s_closest.script_int == 9) {
                n_stage = 3;
            }
            break;
        case 3:
            if (s_closest.script_int == 3) {
                n_stage = 5;
            } else {
                n_stage = 9;
            }
            break;
        case 5:
            if (s_closest.script_int == 5) {
                var_c52419ba = 0;
            } else {
                n_stage = 9;
            }
            break;
        }
    }
    var_687cab15 playsound("zmb_wearable_siegfried_bell");
}

// Namespace namespace_6b38abe3
// Params 1, eflags: 0x1 linked
// Checksum 0x5474adc2, Offset: 0x2140
// Size: 0x2d4
function function_b8449f8c(var_5a533244) {
    level.var_5317b760 = 1;
    for (i = 0; i < var_5a533244.size; i++) {
        var_5a533244[i].var_b4a21360 = 5;
    }
    while (var_5a533244.size > 0) {
        level waittill(#"hash_e8c3642d");
        var_61dd0ed7 = level.var_98fdd784;
        var_e84c42f6 = 0;
        var_688f490b = undefined;
        n_closest_dist = 9999999;
        for (i = 0; i < var_5a533244.size; i++) {
            var_8d2dd868 = var_5a533244[i];
            s_center = struct::get(var_8d2dd868.target, "targetname");
            n_dist = distance(s_center.origin, var_61dd0ed7);
            if (n_dist < n_closest_dist) {
                n_closest_dist = n_dist;
                var_688f490b = var_8d2dd868;
                if (isdefined(s_center.var_afc6be09)) {
                    var_e84c42f6 = 1;
                    continue;
                }
                var_e84c42f6 = 0;
            }
        }
        if (var_e84c42f6) {
            var_6b63f67e = s_center.var_afc6be09;
        } else {
            var_6b63f67e = 256;
        }
        if (n_closest_dist <= var_6b63f67e) {
            zm_genesis_power::function_dfd0ecb2(var_61dd0ed7 + (0, 0, 50), (0, 0, 0), var_688f490b.origin, 0.75);
            var_688f490b.var_b4a21360--;
            if (var_688f490b.var_b4a21360 <= 0) {
                var_688f490b clientfield::set("battery_fx", 2);
                arrayremovevalue(var_5a533244, var_688f490b);
                var_688f490b playsound("zmb_wearable_siegfried_battery_charged");
                /#
                    iprintlnbold("<dev string:x43>");
                #/
            }
        }
    }
    level.var_5317b760 = 0;
}

// Namespace namespace_6b38abe3
// Params 3, eflags: 0x1 linked
// Checksum 0xae3f892e, Offset: 0x2420
// Size: 0x16c
function function_edd475ab(var_dd087d43, var_33c3e058, var_e7d196cc) {
    self endon(#"disconnect");
    self endon(#"hash_baf651e0");
    self.var_adaec269 = 1;
    n_start_time = undefined;
    for (var_fce7f186 = 0; true; var_fce7f186 = 0) {
        self waittill(#"hash_ab106e77");
        n_time = gettime();
        if (!isdefined(n_start_time)) {
            n_start_time = n_time;
        }
        var_84e70e75 = (n_time - n_start_time) / 1000;
        if (var_84e70e75 > var_33c3e058) {
            n_start_time = n_time;
            var_fce7f186 = 0;
            continue;
        }
        var_fce7f186++;
        if (var_fce7f186 >= var_dd087d43) {
            switch (var_e7d196cc) {
            case "c_zom_dlc4_player_siegfried_helmet":
                self playsoundtoplayer("zmb_wearable_siegfried_horn_2", self);
                break;
            case "c_zom_dlc4_player_direwolf_helmet":
                self playsoundtoplayer("zmb_wearable_wolf_howl", self);
                break;
            }
            n_start_time = n_time;
        }
    }
}

// Namespace namespace_6b38abe3
// Params 0, eflags: 0x1 linked
// Checksum 0xec936b93, Offset: 0x2598
// Size: 0x144
function function_8454afd5() {
    level flag::init("mechz_gun_flag");
    level flag::init("mechz_mask_flag");
    level flag::init("mechz_trap_flag");
    level thread function_59c5b722("mechz_gun_flag");
    level thread function_1a3ef9c4("mechz_mask_flag");
    level thread function_a4ae62cc("mechz_trap_flag");
    level flag::wait_till_all(array("mechz_gun_flag", "mechz_mask_flag", "mechz_trap_flag"));
    playsoundatposition("zmb_wearable_mechz_complete", (0, 0, 0));
    function_f6b20985("s_helm_of_the_king", "c_zom_dlc4_player_king_helmet", "j_head", 0);
}

// Namespace namespace_6b38abe3
// Params 1, eflags: 0x1 linked
// Checksum 0x98bcaf96, Offset: 0x26e8
// Size: 0x44
function function_59c5b722(str_flag) {
    level waittill(#"hash_19eedb70");
    level flag::set(str_flag);
    function_c81a7efa();
}

// Namespace namespace_6b38abe3
// Params 1, eflags: 0x1 linked
// Checksum 0xe113fc98, Offset: 0x2738
// Size: 0x44
function function_1a3ef9c4(str_flag) {
    level waittill(#"mechz_faceplate_detached");
    level flag::set(str_flag);
    function_c81a7efa();
}

// Namespace namespace_6b38abe3
// Params 1, eflags: 0x1 linked
// Checksum 0x355a65c, Offset: 0x2788
// Size: 0x84
function function_a4ae62cc(str_flag) {
    for (var_fce7f186 = 0; var_fce7f186 < 50; var_fce7f186++) {
        level util::waittill_any("flogger_killed_zombie", "trap_kill", "autoturret_killed_zombie");
    }
    level flag::set(str_flag);
    function_c81a7efa();
}

// Namespace namespace_6b38abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x2481a381, Offset: 0x2818
// Size: 0x44
function function_c81a7efa() {
    /#
        iprintlnbold("<dev string:x54>");
    #/
    playsoundatposition("zmb_wearable_mechz_step", (0, 0, 0));
}

// Namespace namespace_6b38abe3
// Params 0, eflags: 0x1 linked
// Checksum 0xef210d27, Offset: 0x2868
// Size: 0x11c
function function_796904fd() {
    level flag::init("keeper_skull_dg4_flag");
    level flag::init("keeper_skull_turret_flag");
    level thread function_c489ad78("keeper_skull_dg4_flag");
    level thread function_f4caac35("keeper_skull_turret_flag");
    level flag::wait_till_all(array("keeper_skull_dg4_flag", "keeper_skull_turret_flag"));
    /#
        iprintlnbold("<dev string:x74>");
    #/
    playsoundatposition("zmb_wearable_wolf_howl_finish", (0, 0, 0));
    function_f6b20985("s_dire_wolf_head", "c_zom_dlc4_player_direwolf_helmet", "j_head", 0);
}

// Namespace namespace_6b38abe3
// Params 1, eflags: 0x1 linked
// Checksum 0x4006bc8f, Offset: 0x2990
// Size: 0x162
function function_c489ad78(str_flag) {
    var_3f709380 = struct::get("s_dire_wolf_coffin", "targetname");
    t_damage = spawn("trigger_damage", var_3f709380.origin, 0, 15, 10);
    while (true) {
        amount, attacker, dir, point, mod = t_damage waittill(#"damage");
        if (isdefined(mod) && mod == "MOD_GRENADE_SPLASH") {
            n_dist = distance(point, var_3f709380.origin);
            if (n_dist <= 90) {
                break;
            }
        }
    }
    level flag::set(str_flag);
    t_damage delete();
    level notify(#"hash_208ce56d");
}

// Namespace namespace_6b38abe3
// Params 1, eflags: 0x1 linked
// Checksum 0xee508679, Offset: 0x2b00
// Size: 0x234
function function_f4caac35(str_flag) {
    level waittill(#"hash_208ce56d");
    var_3f709380 = struct::get("s_dire_wolf_coffin", "targetname");
    mdl_skull = util::spawn_model("tag_origin", var_3f709380.origin, (0, 0, 0));
    mdl_skull setmodel("p7_ban_north_tribe_lion_skull");
    for (s_path = struct::get("s_dire_wolf_path_start", "targetname"); true; s_path = struct::get(s_path.target, "targetname")) {
        n_time = 0.4;
        mdl_skull moveto(s_path.origin, n_time);
        if (!isdefined(s_path.target)) {
            mdl_skull waittill(#"movedone");
            mdl_skull playsound("zmb_wearable_wolf_skull_land");
            break;
        }
        wait n_time - 0.05;
    }
    mdl_skull thread function_579caadc();
    level.var_a92f045 = 1;
    level.var_ab7d79d8 = mdl_skull;
    for (var_fce7f186 = 0; var_fce7f186 < 15; var_fce7f186++) {
        level waittill(#"hash_3171c43f");
    }
    level.var_a92f045 = 0;
    wait 0.2;
    mdl_skull delete();
    level flag::set(str_flag);
}

// Namespace namespace_6b38abe3
// Params 0, eflags: 0x1 linked
// Checksum 0xae47cc3d, Offset: 0x2d40
// Size: 0x24c
function function_579caadc() {
    self endon(#"death");
    v_ground_pos = self.origin;
    n_move_time = 1.5;
    var_504ff975 = 1;
    while (true) {
        if (level flag::get("low_grav_on") && var_504ff975) {
            self playsound("zmb_wearable_wolf_skull_rise");
            self playloopsound("zmb_wearable_wolf_skull_lp", 2);
            self moveto(v_ground_pos + (0, 0, 65), n_move_time, n_move_time / 8, n_move_time / 8);
            self waittill(#"movedone");
            var_504ff975 = 0;
            continue;
        }
        if (level flag::get("low_grav_on") == 0 && !var_504ff975) {
            self playsound("zmb_wearable_wolf_skull_lower");
            self stoploopsound(2);
            self moveto(v_ground_pos, n_move_time, n_move_time / 8, n_move_time / 8);
            self waittill(#"movedone");
            self playsound("zmb_wearable_wolf_skull_land");
            var_504ff975 = 1;
            continue;
        }
        if (level flag::get("low_grav_on") && !var_504ff975) {
            self rotateto(self.angles + (0, 180, 0), 0.5);
            wait 0.45;
            continue;
        }
        wait 0.5;
    }
}

// Namespace namespace_6b38abe3
// Params 0, eflags: 0x1 linked
// Checksum 0xb918f02f, Offset: 0x2f98
// Size: 0x154
function function_3167c564() {
    level flag::init("keeper_skull_dg4_flag");
    level flag::init("keeper_skull_turret_flag");
    level flag::init("keeper_skull_zombie_flag");
    level thread function_5aca8a04("keeper_skull_turret_flag");
    level thread function_cceea36c("keeper_skull_zombie_flag");
    level.var_1c301ed2 = 1;
    level flag::wait_till_all(array("keeper_skull_turret_flag", "keeper_skull_zombie_flag"));
    level.var_1c301ed2 = 0;
    /#
        iprintlnbold("<dev string:x8d>");
    #/
    playsoundatposition("zmb_wearable_keeper_complete", (0, 0, 0));
    function_f6b20985("s_keeper_skull_head", "c_zom_dlc4_player_keeper_helmet", "j_head", 0);
}

// Namespace namespace_6b38abe3
// Params 1, eflags: 0x1 linked
// Checksum 0xf44fad3d, Offset: 0x30f8
// Size: 0x74
function function_5aca8a04(str_flag) {
    for (var_fce7f186 = 0; var_fce7f186 < 10; var_fce7f186++) {
        level waittill(#"hash_353fc85a");
    }
    playsoundatposition("zmb_wearable_keeper_step", (0, 0, 0));
    level flag::set(str_flag);
}

// Namespace namespace_6b38abe3
// Params 1, eflags: 0x1 linked
// Checksum 0x42fa448f, Offset: 0x3178
// Size: 0x74
function function_cceea36c(str_flag) {
    for (var_fce7f186 = 0; var_fce7f186 < 30; var_fce7f186++) {
        level waittill(#"hash_dcb6576d");
    }
    playsoundatposition("zmb_wearable_keeper_step", (0, 0, 0));
    level flag::set(str_flag);
}

// Namespace namespace_6b38abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x27150da9, Offset: 0x31f8
// Size: 0x1a4
function function_4fddc919() {
    level flag::init("margwa_head_wasps_flag");
    level flag::init("margwa_head_fire_flag");
    level flag::init("margwa_head_shadow_flag");
    level thread function_43e9a25a("margwa_head_wasps_flag");
    level thread function_9b35bbf0("margwa_head_fire_flag", "margwa_head_shadow_flag");
    level thread function_bf2067a4("margwa_head_shadow_flag", "margwa_head_fire_flag");
    level.var_16f4dfa5 = 1;
    level.var_64a92274 = &function_a5131f0d;
    level flag::wait_till_all(array("margwa_head_wasps_flag", "margwa_head_fire_flag", "margwa_head_shadow_flag"));
    level.var_16f4dfa5 = 0;
    level.var_64a92274 = undefined;
    /#
        iprintlnbold("<dev string:xa9>");
    #/
    playsoundatposition("zmb_wearable_margwa_complete", (0, 0, 0));
    function_f6b20985("s_margwa_head", "c_zom_dlc4_player_margwa_helmet", "j_head", 0);
}

// Namespace namespace_6b38abe3
// Params 2, eflags: 0x1 linked
// Checksum 0xa5eff186, Offset: 0x33a8
// Size: 0xae
function function_a5131f0d(var_4ef2ab6, weapon) {
    var_b6eb007c = util::getweaponclass(weapon);
    if (isdefined(var_b6eb007c) && var_b6eb007c == "weapon_sniper") {
        if (!isdefined(var_4ef2ab6.var_9e4e3d01)) {
            var_4ef2ab6.var_9e4e3d01 = 0;
        }
        var_4ef2ab6.var_9e4e3d01++;
        if (var_4ef2ab6.var_9e4e3d01 == 3) {
            level notify(#"hash_b2146d93");
        }
    }
}

// Namespace namespace_6b38abe3
// Params 1, eflags: 0x1 linked
// Checksum 0xf6b93a6e, Offset: 0x3460
// Size: 0x4c
function function_43e9a25a(str_flag) {
    level waittill(#"hash_b2146d93");
    level flag::set(str_flag);
    level thread function_838522a5();
}

// Namespace namespace_6b38abe3
// Params 2, eflags: 0x1 linked
// Checksum 0x399ac3c3, Offset: 0x34b8
// Size: 0x6c
function function_9b35bbf0(str_flag, var_c5b75477) {
    level waittill(#"hash_8b3deb9");
    level flag::set(str_flag);
    if (level flag::get(var_c5b75477)) {
        level thread function_838522a5();
    }
}

// Namespace namespace_6b38abe3
// Params 2, eflags: 0x1 linked
// Checksum 0x1f68a960, Offset: 0x3530
// Size: 0x6c
function function_bf2067a4(str_flag, var_c5b75477) {
    level waittill(#"hash_e3170555");
    level flag::set(str_flag);
    if (level flag::get(var_c5b75477)) {
        level thread function_838522a5();
    }
}

// Namespace namespace_6b38abe3
// Params 0, eflags: 0x1 linked
// Checksum 0xe8fbcd17, Offset: 0x35a8
// Size: 0x24
function function_838522a5() {
    playsoundatposition("zmb_wearable_margwa_step", (0, 0, 0));
}

// Namespace namespace_6b38abe3
// Params 0, eflags: 0x1 linked
// Checksum 0xee2fe8bc, Offset: 0x35d8
// Size: 0x25c
function function_37ba4813() {
    level flag::init("apothicon_mask_all_zombies_killed");
    level flag::init("apothicon_mask_all_wasps_killed");
    level flag::init("apothicon_mask_all_spiders_killed");
    level flag::init("apothicon_mask_all_margwas_killed");
    level flag::init("apothicon_mask_all_fury_killed");
    level flag::init("apothicon_mask_all_keepers_killed");
    level thread function_b464a575("apothicon_mask_all_zombies_killed");
    level thread function_b507724f("apothicon_mask_all_wasps_killed");
    level thread function_d3f5f766("apothicon_mask_all_spiders_killed");
    level thread function_f6aa218a("apothicon_mask_all_margwas_killed");
    level thread function_904f0f67("apothicon_mask_all_fury_killed");
    level thread function_a94b36fd("apothicon_mask_all_keepers_killed");
    level.var_26af7b39 = 1;
    level flag::wait_till_all(array("apothicon_mask_all_zombies_killed", "apothicon_mask_all_wasps_killed", "apothicon_mask_all_spiders_killed", "apothicon_mask_all_margwas_killed", "apothicon_mask_all_fury_killed", "apothicon_mask_all_keepers_killed"));
    level.var_26af7b39 = 0;
    /#
        iprintlnbold("<dev string:xbf>");
    #/
    playsoundatposition("zmb_wearable_apothigod_complete", (0, 0, 0));
    function_f6b20985("s_apothicon_mask", "c_zom_dlc4_player_apothican_helmet", "j_head", -30);
}

// Namespace namespace_6b38abe3
// Params 1, eflags: 0x1 linked
// Checksum 0x53235599, Offset: 0x3840
// Size: 0x74
function function_b464a575(var_776628b2) {
    for (var_fce7f186 = 0; var_fce7f186 < 50; var_fce7f186++) {
        level waittill(#"hash_69f0d192");
    }
    level flag::set(var_776628b2);
    level thread function_70b329b3();
}

// Namespace namespace_6b38abe3
// Params 1, eflags: 0x1 linked
// Checksum 0xea3f3bb6, Offset: 0x38c0
// Size: 0x74
function function_b507724f(var_776628b2) {
    for (var_fce7f186 = 0; var_fce7f186 < 5; var_fce7f186++) {
        level waittill(#"hash_b7ed57c7");
    }
    level flag::set(var_776628b2);
    level thread function_70b329b3();
}

// Namespace namespace_6b38abe3
// Params 1, eflags: 0x1 linked
// Checksum 0xb8d599ca, Offset: 0x3940
// Size: 0x74
function function_d3f5f766(var_776628b2) {
    for (var_fce7f186 = 0; var_fce7f186 < 5; var_fce7f186++) {
        level waittill(#"hash_ca3a841");
    }
    level flag::set(var_776628b2);
    level thread function_70b329b3();
}

// Namespace namespace_6b38abe3
// Params 1, eflags: 0x1 linked
// Checksum 0x2cdee76d, Offset: 0x39c0
// Size: 0x74
function function_f6aa218a(var_776628b2) {
    for (var_fce7f186 = 0; var_fce7f186 < 3; var_fce7f186++) {
        level waittill(#"hash_6571fc3d");
    }
    level flag::set(var_776628b2);
    level thread function_70b329b3();
}

// Namespace namespace_6b38abe3
// Params 1, eflags: 0x1 linked
// Checksum 0xf62ee0a6, Offset: 0x3a40
// Size: 0x74
function function_904f0f67(var_776628b2) {
    for (var_fce7f186 = 0; var_fce7f186 < 10; var_fce7f186++) {
        level waittill(#"hash_67009580");
    }
    level flag::set(var_776628b2);
    level thread function_70b329b3();
}

// Namespace namespace_6b38abe3
// Params 1, eflags: 0x1 linked
// Checksum 0x4ecbb282, Offset: 0x3ac0
// Size: 0x74
function function_a94b36fd(var_776628b2) {
    for (var_fce7f186 = 0; var_fce7f186 < 10; var_fce7f186++) {
        level waittill(#"hash_6a066b2e");
    }
    level flag::set(var_776628b2);
    level thread function_70b329b3();
}

// Namespace namespace_6b38abe3
// Params 0, eflags: 0x1 linked
// Checksum 0xf401682d, Offset: 0x3b40
// Size: 0x7c
function function_70b329b3() {
    /#
        iprintlnbold("<dev string:xd7>");
    #/
    playsoundatposition("zmb_wearable_apothigod_step", (0, 0, 0));
    level thread zm_genesis_util::function_2a0bc326(level.var_b1471d99, 0.65, 2, 800, 4);
}

// Namespace namespace_6b38abe3
// Params 0, eflags: 0x1 linked
// Checksum 0xc231471c, Offset: 0x3bc8
// Size: 0xe4
function function_6d72c0dc() {
    level flag::init("fury_head_sniper_kill");
    level thread function_f1691f03("fury_head_sniper_kill");
    level.var_2bb34f66 = 1;
    level flag::wait_till("fury_head_sniper_kill");
    level.var_2bb34f66 = 0;
    /#
        iprintlnbold("<dev string:xee>");
    #/
    playsoundatposition("zmb_wearable_fury_complete", (0, 0, 0));
    function_f6b20985("s_fury_head", "c_zom_dlc4_player_fury_helmet", "j_head", -30);
}

// Namespace namespace_6b38abe3
// Params 1, eflags: 0x1 linked
// Checksum 0x302921a4, Offset: 0x3cb8
// Size: 0xb4
function function_f1691f03(var_776628b2) {
    level flag::wait_till_all(array("power_on1", "power_on2", "power_on3", "power_on4"));
    for (var_fce7f186 = 0; var_fce7f186 < 40; var_fce7f186++) {
        level waittill(#"fury_head_sniper_kill");
    }
    level flag::set(var_776628b2);
    level thread function_716f6548();
}

// Namespace namespace_6b38abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x59a3f01f, Offset: 0x3d78
// Size: 0x24
function function_716f6548() {
    playsoundatposition("zmb_wearable_fury_step", (0, 0, 0));
}

// Namespace namespace_6b38abe3
// Params 1, eflags: 0x1 linked
// Checksum 0xed9070d1, Offset: 0x3da8
// Size: 0x4c8
function function_9d85b9ce(e_attacker) {
    if (isdefined(level.var_5317b760) && level.var_5317b760 && isplayer(e_attacker)) {
        if (zm_utility::is_headshot(self.damageweapon, self.damagelocation, self.damagemod)) {
            level.var_98fdd784 = self.origin;
            level notify(#"hash_e8c3642d");
        }
    }
    if (isdefined(e_attacker.var_adaec269) && isplayer(e_attacker) && e_attacker.var_adaec269) {
        e_attacker notify(#"hash_ab106e77");
    }
    if (isdefined(level.var_a5d2ba4) && isdefined(level.var_26af7b39) && isplayer(e_attacker) && level.var_26af7b39 && level.var_a5d2ba4) {
        var_46927a7e = getent("apothicon_belly_center", "targetname");
        if (e_attacker istouching(var_46927a7e) && self istouching(var_46927a7e)) {
            if (isdefined(self.archetype)) {
                switch (self.archetype) {
                case "parasite":
                    level notify(#"hash_b7ed57c7");
                    break;
                case "margwa":
                    level notify(#"hash_6571fc3d");
                    break;
                case "zombie":
                    level notify(#"hash_69f0d192");
                    break;
                case "keeper":
                    level notify(#"hash_6a066b2e");
                    break;
                case "apothicon_fury":
                    level notify(#"hash_67009580");
                    break;
                }
            }
            level.var_b1471d99 = self.origin;
        }
    }
    if (isdefined(level.var_1c301ed2) && level.var_1c301ed2) {
        if (isdefined(e_attacker) && isdefined(e_attacker.archetype) && e_attacker.archetype == "keeper_companion") {
            if (isdefined(self.archetype) && self.archetype == "zombie") {
                level notify(#"hash_dcb6576d");
            }
        }
        if (self.damageweapon.name == "hero_gravityspikes" || self.archetype === "keeper" && isdefined(self.damageweapon) && self.damageweapon.name == "hero_gravityspikes_melee") {
            level notify(#"hash_d81381c8");
        }
    }
    if (isdefined(level.var_16f4dfa5) && level.var_16f4dfa5) {
        if (namespace_3de4ab6f::function_6bbd2a18(self)) {
            level notify(#"hash_8b3deb9");
        } else if (namespace_3de4ab6f::function_b9fad980(self)) {
            level notify(#"hash_e3170555");
        }
    }
    if (isdefined(level.var_a92f045) && level.var_a92f045) {
        if (level flag::get("low_grav_on")) {
            var_d0c30abc = level.var_ab7d79d8.origin;
            n_dist = distance(var_d0c30abc, self.origin);
            if (n_dist <= 256) {
                level thread zm_genesis_power::function_dfd0ecb2(self.origin + (0, 0, 50), self.angles, var_d0c30abc, 1);
                level notify(#"hash_3171c43f");
            }
        }
    }
    if (isdefined(level.var_2bb34f66) && level.var_2bb34f66) {
        if (isdefined(self.archetype) && self.archetype == "apothicon_fury") {
            if (isdefined(self.damageweapon) && self.damageweapon.isbulletweapon) {
                level notify(#"fury_head_sniper_kill");
            }
        }
    }
    if (isdefined(self.var_9f6fbb95) && self.var_9f6fbb95) {
        level.var_2306bf38--;
    }
}

// Namespace namespace_6b38abe3
// Params 13, eflags: 0x1 linked
// Checksum 0x7a3d3b3e, Offset: 0x4278
// Size: 0x176
function function_cb27f92e(mod, hit_location, var_8a2b6fe5, player, amount, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel) {
    if (isdefined(player.var_e8e8daad) && isplayer(player) && player.var_e8e8daad) {
        n_amount = amount / 2;
        self dodamage(n_amount, var_8a2b6fe5, player);
    }
    if (isdefined(player.var_15c79ed8) && isplayer(player) && player.var_15c79ed8) {
        if (isdefined(self.archetype) && self.archetype == "apothicon_fury") {
            n_amount = amount / 2;
            self dodamage(n_amount, var_8a2b6fe5, player);
        }
    }
    return false;
}

/#

    // Namespace namespace_6b38abe3
    // Params 0, eflags: 0x1 linked
    // Checksum 0x11c41e5c, Offset: 0x43f8
    // Size: 0x244
    function function_e8a31296() {
        adddebugcommand("<dev string:x101>" + "<dev string:x143>" + "<dev string:x151>");
        adddebugcommand("<dev string:x154>" + "<dev string:x19c>" + "<dev string:x151>");
        adddebugcommand("<dev string:x1b0>" + "<dev string:x1f5>" + "<dev string:x151>");
        adddebugcommand("<dev string:x206>" + "<dev string:x24d>" + "<dev string:x151>");
        adddebugcommand("<dev string:x260>" + "<dev string:x2a8>" + "<dev string:x151>");
        adddebugcommand("<dev string:x2bc>" + "<dev string:x2fe>" + "<dev string:x151>");
        adddebugcommand("<dev string:x30c>" + "<dev string:x351>" + "<dev string:x151>");
        adddebugcommand("<dev string:x362>" + "<dev string:x3a2>" + "<dev string:x151>");
        adddebugcommand("<dev string:x3ae>");
        adddebugcommand("<dev string:x40d>");
        adddebugcommand("<dev string:x478>");
        adddebugcommand("<dev string:x4dd>");
        adddebugcommand("<dev string:x546>");
        adddebugcommand("<dev string:x5b1>");
        adddebugcommand("<dev string:x610>");
        adddebugcommand("<dev string:x675>");
    }

    // Namespace namespace_6b38abe3
    // Params 1, eflags: 0x1 linked
    // Checksum 0x92cd238e, Offset: 0x4648
    // Size: 0x9c
    function function_b03acf4e(var_b3ecaf28) {
        s_loc = struct::get(var_b3ecaf28, "<dev string:x6d0>");
        var_9f8b01da = getclosestpointonnavmesh(s_loc.origin, 100);
        if (!isdefined(var_9f8b01da)) {
            var_9f8b01da = s_loc.origin;
        }
        self setorigin(var_9f8b01da);
    }

    // Namespace namespace_6b38abe3
    // Params 1, eflags: 0x1 linked
    // Checksum 0x49d7be7a, Offset: 0x46f0
    // Size: 0x33e
    function function_82e9c58d(cmd) {
        player = level.players[0];
        switch (cmd) {
        case "<dev string:x143>":
            function_f6b20985("<dev string:x143>", "<dev string:x6db>", "<dev string:x6fe>", 0);
            break;
        case "<dev string:x19c>":
            function_f6b20985("<dev string:x19c>", "<dev string:x705>", "<dev string:x6fe>", 0);
            break;
        case "<dev string:x1f5>":
            function_f6b20985("<dev string:x1f5>", "<dev string:x728>", "<dev string:x6fe>", 0);
            break;
        case "<dev string:x24d>":
            function_f6b20985("<dev string:x24d>", "<dev string:x74b>", "<dev string:x6fe>", 0);
            break;
        case "<dev string:x2a8>":
            function_f6b20985("<dev string:x2a8>", "<dev string:x769>", "<dev string:x6fe>", 0);
            break;
        case "<dev string:x2fe>":
            function_f6b20985("<dev string:x2fe>", "<dev string:x789>", "<dev string:x6fe>", 0);
            break;
        case "<dev string:x351>":
            function_f6b20985("<dev string:x351>", "<dev string:x7a9>", "<dev string:x6fe>", 0);
            break;
        case "<dev string:x3a2>":
            function_f6b20985("<dev string:x3a2>", "<dev string:x7cb>", "<dev string:x6fe>", 0);
            break;
        case "<dev string:x7e9>":
            player function_b03acf4e("<dev string:x143>");
            break;
        case "<dev string:x7fe>":
            player function_b03acf4e("<dev string:x19c>");
            break;
        case "<dev string:x819>":
            player function_b03acf4e("<dev string:x1f5>");
            break;
        case "<dev string:x831>":
            player function_b03acf4e("<dev string:x24d>");
            break;
        case "<dev string:x84b>":
            player function_b03acf4e("<dev string:x2a8>");
            break;
        case "<dev string:x866>":
            player function_b03acf4e("<dev string:x2fe>");
            break;
        case "<dev string:x87b>":
            player function_b03acf4e("<dev string:x351>");
            break;
        case "<dev string:x893>":
            player function_b03acf4e("<dev string:x3a2>");
            break;
        }
    }

#/
