#using scripts/zm/_zm_weap_rocketshield;
#using scripts/zm/zm_zod_vo;
#using scripts/zm/zm_zod_util;
#using scripts/zm/zm_zod_shadowman;
#using scripts/zm/zm_zod_quest;
#using scripts/zm/zm_zod_idgun_quest;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_ai_wasp;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/craftables/_zm_craft_shield;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/table_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_81256d2f;

// Namespace namespace_81256d2f
// Params 0, eflags: 0x2
// Checksum 0xedef4cc, Offset: 0x8c0
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_zod_pods", &__init__, &__main__, undefined);
}

// Namespace namespace_81256d2f
// Params 0, eflags: 0x0
// Checksum 0x827a14be, Offset: 0x908
// Size: 0x67c
function __init__() {
    clientfield::register("toplayer", "ZM_ZOD_UI_POD_SPRAYER_PICKUP", 1, 1, "int");
    clientfield::register("scriptmover", "update_fungus_pod_level", 1, 3, "int");
    clientfield::register("scriptmover", "pod_sprayer_glint", 1, 1, "int");
    clientfield::register("scriptmover", "pod_miasma", 1, 1, "counter");
    clientfield::register("scriptmover", "pod_harvest", 1, 1, "counter");
    clientfield::register("scriptmover", "pod_self_destruct", 1, 1, "counter");
    clientfield::register("toplayer", "pod_sprayer_held", 1, 1, "int");
    clientfield::register("toplayer", "pod_sprayer_hint_range", 1, 1, "int");
    level.var_6fa2f6ca = spawnstruct();
    level.var_6fa2f6ca.var_653c4928 = array(0, 0, 0, 0.25, 0.25, 0.5, 0.5, 1);
    a_table = table::load("gamedata/tables/zm/zm_zod_pods.csv", "ScriptID");
    level.var_6fa2f6ca.rewards = [];
    level.var_6fa2f6ca.rewards[1] = [];
    level.var_6fa2f6ca.rewards[2] = [];
    level.var_6fa2f6ca.rewards[3] = [];
    level.var_6fa2f6ca.var_568a16f7 = 100;
    level.bonus_points_powerup_override = &function_20affc0e;
    /#
        level.var_6fa2f6ca.var_8d5d5fa7 = [];
    #/
    var_d1a5ae2b = getweapon("none");
    a_keys = getarraykeys(a_table);
    for (i = 0; i < a_keys.size; i++) {
        str_key = a_keys[i];
        s_reward = spawnstruct();
        s_reward.var_847eee17 = a_table[str_key]["Level"];
        s_reward.type = a_table[str_key]["Type"];
        if (s_reward.type == "weapon") {
            s_reward.item = getweapon(a_table[str_key]["Item"]);
            if (s_reward.item == var_d1a5ae2b) {
                /#
                    /#
                        assertmsg("zmInventory.player_using_sprayer" + a_table[str_key]["frag_grenade"] + "evt_zod_pod_open_weapon");
                    #/
                #/
                continue;
            }
        } else {
            s_reward.item = a_table[str_key]["Item"];
        }
        s_reward.count = a_table[str_key]["Count"];
        s_reward.chance = a_table[str_key]["Weight"];
        if (!isdefined(level.var_6fa2f6ca.rewards[s_reward.var_847eee17])) {
            level.var_6fa2f6ca.rewards[s_reward.var_847eee17] = [];
        } else if (!isarray(level.var_6fa2f6ca.rewards[s_reward.var_847eee17])) {
            level.var_6fa2f6ca.rewards[s_reward.var_847eee17] = array(level.var_6fa2f6ca.rewards[s_reward.var_847eee17]);
        }
        level.var_6fa2f6ca.rewards[s_reward.var_847eee17][level.var_6fa2f6ca.rewards[s_reward.var_847eee17].size] = s_reward;
        /#
            level.var_6fa2f6ca.var_8d5d5fa7[str_key] = s_reward;
        #/
    }
    function_bcc1a076();
    thread function_77d7e068();
    function_956d3c82();
    level flag::init("any_player_has_pod_sprayer");
    level flag::init("hide_pods_for_trailer");
    /#
        level thread function_5c18476f();
    #/
}

// Namespace namespace_81256d2f
// Params 0, eflags: 0x0
// Checksum 0x5c3c873d, Offset: 0xf90
// Size: 0x374
function __main__() {
    level flag::wait_till("start_zombie_round_logic");
    if (getdvarint("splitscreen_playerCount") > 2) {
        return;
    }
    level.var_6fa2f6ca.var_4042b27e = struct::get_array("fungus_pod", "targetname");
    level.var_6fa2f6ca.var_5d8c3695 = [];
    foreach (var_194575a7 in level.var_6fa2f6ca.var_4042b27e) {
        var_194575a7.model = util::spawn_model("tag_origin", var_194575a7.origin, var_194575a7.angles);
        if (isdefined(var_194575a7.script_noteworthy) && var_194575a7.script_noteworthy == "active") {
            var_194575a7.var_8486ae6a = 1;
        } else {
            var_194575a7.var_8486ae6a = 0;
        }
        var_194575a7.model clientfield::set("update_fungus_pod_level", 4);
    }
    level.var_6fa2f6ca.var_99e7e50c = [];
    var_9e82592c = struct::get_array("pod_sprayer_location", "targetname");
    var_9e82592c = array::randomize(var_9e82592c);
    var_60b120ef = [];
    foreach (var_134d595b in var_9e82592c) {
        if (isdefined(var_60b120ef[var_134d595b.script_int])) {
            continue;
        }
        var_60b120ef[var_134d595b.script_int] = var_134d595b;
    }
    foreach (var_134d595b in var_60b120ef) {
        var_134d595b thread function_1ba9c604();
    }
    thread function_ab887f9d();
    level thread function_bf70a1ff();
}

/#

    // Namespace namespace_81256d2f
    // Params 0, eflags: 0x0
    // Checksum 0x70f9f283, Offset: 0x1310
    // Size: 0x240
    function function_5c18476f() {
        setdvar("<unknown string>", "<unknown string>");
        setdvar("<unknown string>", "<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        a_keys = getarraykeys(level.var_6fa2f6ca.var_8d5d5fa7);
        for (i = 0; i < a_keys.size; i++) {
            str_id = a_keys[i];
            adddebugcommand("<unknown string>" + str_id + "<unknown string>" + str_id + "<unknown string>");
        }
        var_511a9112 = struct::get("<unknown string>", "<unknown string>");
        while (true) {
            cmd = getdvarstring("<unknown string>");
            if (cmd != "<unknown string>") {
                switch (cmd) {
                case 0:
                    level notify(#"hash_c0150ce6");
                    break;
                case 0:
                    level.var_7cf7b906 = 1;
                    level notify(#"hash_c0150ce6");
                    util::wait_network_frame();
                    level.var_7cf7b906 = 0;
                    break;
                default:
                    break;
                }
                setdvar("<unknown string>", "<unknown string>");
            }
            util::wait_network_frame();
        }
    }

#/

// Namespace namespace_81256d2f
// Params 0, eflags: 0x0
// Checksum 0x5cdca32, Offset: 0x1558
// Size: 0x118
function function_bcc1a076() {
    foreach (var_3c1def9d in level.var_6fa2f6ca.rewards) {
        foreach (s_reward in var_3c1def9d) {
            if (s_reward.type == "shield_recharge") {
                s_reward.var_17fcbfca = 1;
            }
        }
    }
}

// Namespace namespace_81256d2f
// Params 0, eflags: 0x0
// Checksum 0xb9f25afc, Offset: 0x1678
// Size: 0x120
function function_77d7e068() {
    level waittill(#"shield_built");
    foreach (var_3c1def9d in level.var_6fa2f6ca.rewards) {
        foreach (s_reward in var_3c1def9d) {
            if (s_reward.type == "shield_recharge") {
                s_reward.var_17fcbfca = 0;
            }
        }
    }
}

// Namespace namespace_81256d2f
// Params 1, eflags: 0x4
// Checksum 0x9d2f7099, Offset: 0x17a0
// Size: 0x44
function private function_4f94c8ae(e_player) {
    if (e_player clientfield::get_to_player("pod_sprayer_held")) {
        return %;
    }
    return %ZM_ZOD_PICKUP_SPRAYER;
}

// Namespace namespace_81256d2f
// Params 0, eflags: 0x4
// Checksum 0x695e38b5, Offset: 0x17f0
// Size: 0x21e
function private function_1ba9c604() {
    while (true) {
        self.model = util::spawn_model("p7_zm_zod_bug_sprayer", self.origin, self.angles);
        self.model clientfield::set("pod_sprayer_glint", 1);
        self.trigger = namespace_8e578893::function_d095318(self.origin, 50, 1, &function_4f94c8ae);
        while (true) {
            e_who = self.trigger waittill(#"trigger");
            if (e_who clientfield::get_to_player("pod_sprayer_held")) {
                continue;
            }
            e_who thread zm_audio::create_and_play_dialog("sprayer", "pickup");
            e_who clientfield::set_to_player("pod_sprayer_held", 1);
            e_who thread namespace_8e578893::function_55f114f9("zmInventory.widget_sprayer", 3.5);
            e_who thread namespace_8e578893::function_69e0fb83("ZM_ZOD_UI_POD_SPRAYER_PICKUP", 3.5);
            e_who.var_abe77dc0 = 1;
            self.model delete();
            playsoundatposition("zmb_zod_sprayer_pickup", self.origin);
            zm_unitrigger::unregister_unitrigger(self.trigger);
            self.trigger = undefined;
            level flag::set("any_player_has_pod_sprayer");
            break;
        }
        e_who waittill(#"disconnect");
    }
}

// Namespace namespace_81256d2f
// Params 0, eflags: 0x4
// Checksum 0x641c8bfa, Offset: 0x1a18
// Size: 0x13a
function private function_5f89f77a() {
    self waittill(#"hash_e446a51c");
    self thread function_a7a6257b();
    self thread function_42bd572d();
    while (true) {
        e_who = self.trigger waittill(#"trigger");
        /#
            assert(self.var_8486ae6a > 0);
        #/
        if (isdefined(level.bzm_worldpaused) && level.bzm_worldpaused) {
            continue;
        }
        if (e_who clientfield::get_to_player("pod_sprayer_held") == 0) {
            e_who thread function_8d53a342(0);
            continue;
        }
        playsoundatposition("zmb_zod_sprayer_use", self.origin);
        e_who thread function_8d53a342(1);
        self function_7e428fa9(e_who);
        return;
    }
}

// Namespace namespace_81256d2f
// Params 1, eflags: 0x4
// Checksum 0x24c8822e, Offset: 0x1b60
// Size: 0xac
function private function_8d53a342(b_success) {
    self notify(#"hash_8d53a342");
    self endon(#"hash_8d53a342");
    self thread clientfield::set_player_uimodel("zmInventory.player_using_sprayer", b_success);
    self thread clientfield::set_player_uimodel("zmInventory.widget_sprayer", 1);
    wait(2);
    self thread clientfield::set_player_uimodel("zmInventory.widget_sprayer", 0);
    self thread clientfield::set_player_uimodel("zmInventory.player_using_sprayer", 0);
}

// Namespace namespace_81256d2f
// Params 0, eflags: 0x0
// Checksum 0x40180597, Offset: 0x1c18
// Size: 0xea
function function_ab887f9d() {
    var_15c80043 = getentarray("fungus_pod_clip", "targetname");
    level.var_6fa2f6ca.var_755232db = array::sort_by_script_int(var_15c80043, 1);
    foreach (e_clip in level.var_6fa2f6ca.var_755232db) {
        e_clip thread function_254faf4d();
    }
}

// Namespace namespace_81256d2f
// Params 0, eflags: 0x0
// Checksum 0x3f503035, Offset: 0x1d10
// Size: 0x9a
function function_254faf4d() {
    level endon(#"_zombie_game_over");
    while (true) {
        self.origin -= (0, 0, 5000);
        level waittill("pod_" + self.script_int + "_hatched");
        self.origin += (0, 0, 5000);
        level waittill("pod_" + self.script_int + "_harvested");
    }
}

// Namespace namespace_81256d2f
// Params 1, eflags: 0x4
// Checksum 0x7fba9d4, Offset: 0x1db8
// Size: 0x7c
function private function_cb4c560e(var_8486ae6a) {
    if (!isdefined(var_8486ae6a)) {
        var_8486ae6a = undefined;
    }
    if (self.var_8486ae6a < 3) {
        if (isdefined(var_8486ae6a)) {
            self.var_8486ae6a = var_8486ae6a;
        } else {
            self.var_8486ae6a++;
        }
        self.model clientfield::set("update_fungus_pod_level", self.var_8486ae6a);
    }
}

// Namespace namespace_81256d2f
// Params 0, eflags: 0x0
// Checksum 0x1efd0efe, Offset: 0x1e40
// Size: 0x9a
function function_be2abe() {
    foreach (s_pod in level.var_6fa2f6ca.var_5d8c3695) {
        s_pod function_cb4c560e(3);
    }
}

// Namespace namespace_81256d2f
// Params 0, eflags: 0x4
// Checksum 0x9dde99f0, Offset: 0x1ee8
// Size: 0x182
function private function_a7a6257b() {
    self endon(#"hash_ed807797");
    var_7df5847c = 0;
    if (isdefined(self.zone)) {
        zm_zonemgr::zone_wait_till_enabled(self.zone);
    }
    if (level clientfield::get("bm_superbeast")) {
        self function_cb4c560e(3);
    }
    while (true) {
        level util::waittill_any("between_round_over", "debug_pod_spawn");
        var_7df5847c++;
        var_1e942f25 = level.var_6fa2f6ca.var_653c4928[var_7df5847c];
        if (!isdefined(var_1e942f25)) {
            var_1e942f25 = 1;
        } else if (isdefined(level.var_7cf7b906) && level.var_7cf7b906) {
            var_1e942f25 = 1;
        } else if (var_1e942f25 == 0) {
            continue;
        }
        if (randomfloat(1) <= var_1e942f25) {
            self function_cb4c560e();
            var_7df5847c = 0;
            if (self.var_8486ae6a >= 3) {
                return;
            }
        }
    }
}

// Namespace namespace_81256d2f
// Params 0, eflags: 0x4
// Checksum 0x38ba8a37, Offset: 0x2078
// Size: 0x188
function private function_42bd572d() {
    self endon(#"hash_ed807797");
    level flag::wait_till("all_players_spawned");
    while (true) {
        level waittill(#"kill_round");
        if (self.var_8486ae6a == 3) {
            self.model clientfield::increment("pod_harvest");
            wait(0.05);
            zm_unitrigger::unregister_unitrigger(self.trigger);
            arrayremovevalue(level.var_6fa2f6ca.var_5d8c3695, self);
            if (!isdefined(level.var_6fa2f6ca.var_4042b27e)) {
                level.var_6fa2f6ca.var_4042b27e = [];
            } else if (!isarray(level.var_6fa2f6ca.var_4042b27e)) {
                level.var_6fa2f6ca.var_4042b27e = array(level.var_6fa2f6ca.var_4042b27e);
            }
            level.var_6fa2f6ca.var_4042b27e[level.var_6fa2f6ca.var_4042b27e.size] = self;
            self notify(#"hash_ed807797");
            level notify("pod_" + self.script_int + "_harvested");
        }
    }
}

// Namespace namespace_81256d2f
// Params 0, eflags: 0x4
// Checksum 0x1fa4a4a5, Offset: 0x2208
// Size: 0x260
function private function_bf70a1ff() {
    level flag::wait_till("start_zombie_round_logic");
    for (i = 0; i < level.var_6fa2f6ca.var_4042b27e.size; i++) {
        var_f64bb476 = level.var_6fa2f6ca.var_4042b27e[i];
        var_f64bb476.zone = zm_zonemgr::get_zone_from_position(var_f64bb476.origin + (0, 0, 20), 1);
        if (!isdefined(var_f64bb476.zone)) {
            /#
                println("<unknown string>" + namespace_8e578893::function_f7f2ffed(var_f64bb476.origin) + "<unknown string>");
            #/
            arrayremovevalue(level.var_6fa2f6ca.var_4042b27e, var_f64bb476);
        }
    }
    var_d23318a4 = int(0.4 * level.var_6fa2f6ca.var_4042b27e.size);
    function_d6abde0a(var_d23318a4);
    while (true) {
        level util::waittill_any("between_round_over", "debug_pod_spawn");
        if (level.round_number < 4 && !level flag::get("any_player_has_pod_sprayer") && !(isdefined(level.var_7cf7b906) && level.var_7cf7b906)) {
            continue;
        }
        var_d23318a4 = randomintrange(3, 6);
        if (isdefined(level.var_7cf7b906) && level.var_7cf7b906) {
            var_d23318a4 = 1000;
        }
        function_d6abde0a(var_d23318a4);
    }
}

// Namespace namespace_81256d2f
// Params 1, eflags: 0x0
// Checksum 0x30955c65, Offset: 0x2470
// Size: 0xac2
function function_7e428fa9(var_38618a65) {
    self.model clientfield::increment("pod_harvest");
    var_38618a65 thread zm_audio::create_and_play_dialog("sprayer", "use");
    wait(0.1);
    self.var_6cfbf8d6 = level.round_number;
    zm_unitrigger::unregister_unitrigger(self.trigger);
    self.trigger = undefined;
    self notify(#"hash_ed807797", var_38618a65);
    var_785a5f87 = self.var_8486ae6a;
    self.var_8486ae6a = 0;
    self.model clientfield::set("update_fungus_pod_level", self.var_8486ae6a);
    wait(getanimlength("p7_fxanim_zm_zod_fungus_pod_stage" + var_785a5f87 + "_death_bundle") - 0.5);
    var_38618a65 recordmapevent(24, gettime(), self.origin, level.round_number, var_785a5f87);
    level notify("pod_" + self.script_int + "_harvested");
    n_roll = randomint(100);
    var_cf622a2d = 0;
    var_68a89987 = 0;
    foreach (s_reward in level.var_6fa2f6ca.rewards[var_785a5f87]) {
        /#
            var_c243efe2 = getdvarstring("<unknown string>");
            if (isdefined(var_c243efe2) && var_c243efe2 != "<unknown string>") {
                var_d82f154a = 1;
                s_reward = level.var_6fa2f6ca.var_8d5d5fa7[var_c243efe2];
                setdvar("<unknown string>", "<unknown string>");
            }
        #/
        if (s_reward.type == "weapon") {
            s_reward.var_17fcbfca = function_b0138b1(s_reward.item);
        }
        if (isdefined(s_reward.var_17fcbfca) && s_reward.var_17fcbfca) {
            continue;
        }
        var_cf622a2d += s_reward.chance;
        if (isdefined(var_d82f154a) && (var_cf622a2d >= n_roll || var_d82f154a)) {
            var_68a89987 = 1;
            switch (s_reward.type) {
            case 66:
                s_reward.var_17fcbfca = 1;
                function_956d3c82();
                playsoundatposition("evt_zod_pod_open_craftable", self.origin);
                drop_point = self.origin + (0, 0, 36);
                namespace_54bf13f5::function_f5469e1(drop_point, "part_skeleton");
                if (level flag::get("part_skeleton" + "_found")) {
                    break;
                } else {
                    mdl_part = level namespace_f37770c8::function_1f5d26ed("idgun", "part_skeleton");
                    var_55d0f940 = struct::get("safe_place_for_items", "targetname");
                    mdl_part.origin = var_55d0f940.origin;
                    s_reward.var_17fcbfca = 0;
                    function_956d3c82();
                }
                break;
            case 67:
                v_spawnpt = self.origin;
                grenade = getweapon("frag_grenade");
                n_rand = randomintrange(0, 4);
                var_38618a65 magicgrenadetype(grenade, v_spawnpt, (0, 0, 300), 3);
                playsoundatposition("evt_zod_pod_open_grenade", self.origin);
                if (n_rand) {
                    wait(0.3);
                    if (math::cointoss()) {
                        var_38618a65 magicgrenadetype(grenade, v_spawnpt, (0, 0, 300), 3);
                    }
                }
                break;
            case 68:
                if (isdefined(var_38618a65)) {
                    array::add(level.var_95315b60, var_38618a65);
                }
                s_temp = spawnstruct();
                s_temp.origin = self.origin + (0, 0, 30);
                var_b20468d0 = namespace_b1ca30af::function_8aeb3564(1, s_temp, 32, 32, 1, 1, 1);
                if (!ispointinnavvolume(var_b20468d0.origin, "navvolume_small")) {
                    v_nearest_navmesh_point = var_b20468d0 getclosestpointonnavvolume(s_temp.origin, 100);
                    if (isdefined(v_nearest_navmesh_point)) {
                        var_b20468d0.origin = v_nearest_navmesh_point;
                    }
                }
                break;
            case 69:
                for (str_item = s_reward.item; str_item === "full_ammo" && (!isdefined(str_item) || var_785a5f87 != 3); str_item = zm_powerups::get_valid_powerup()) {
                }
                if (isdefined(s_reward.count) && str_item == "bonus_points_team") {
                    level.var_6fa2f6ca.var_568a16f7 = s_reward.count;
                }
                zm_powerups::specific_powerup_drop(str_item, self.origin, undefined, undefined, 1);
                break;
            case 18:
                playsoundatposition("evt_zod_pod_open_weapon", self.origin);
                self thread function_e07a8850(var_38618a65, s_reward.item);
                break;
            case 70:
                s_temp = spawnstruct();
                s_temp.origin = function_c9466e61(self.origin, 20);
                if (!isdefined(s_temp.origin)) {
                    s_temp.origin = self.origin;
                }
                s_temp.script_noteworthy = "riser_location";
                s_temp.script_string = "find_flesh";
                zombie_utility::spawn_zombie(level.zombie_spawners[0], "aether_zombie", s_temp);
                break;
            case 31:
                v_origin = function_c9466e61(self.origin, 20);
                var_7905adb2 = rocketshield::function_c94e27cd(v_origin, (0, 0, 0));
                var_7905adb2 thread function_92f587b4();
                break;
            default:
                break;
            }
            break;
        }
    }
    if (!var_68a89987) {
        str_item = zm_powerups::get_valid_powerup();
        zm_powerups::specific_powerup_drop(str_item, self.origin, undefined, undefined, 1);
    }
    arrayremovevalue(level.var_6fa2f6ca.var_5d8c3695, self);
    if (!isdefined(level.var_6fa2f6ca.var_4042b27e)) {
        level.var_6fa2f6ca.var_4042b27e = [];
    } else if (!isarray(level.var_6fa2f6ca.var_4042b27e)) {
        level.var_6fa2f6ca.var_4042b27e = array(level.var_6fa2f6ca.var_4042b27e);
    }
    level.var_6fa2f6ca.var_4042b27e[level.var_6fa2f6ca.var_4042b27e.size] = self;
}

// Namespace namespace_81256d2f
// Params 2, eflags: 0x0
// Checksum 0xd0f3167, Offset: 0x2f40
// Size: 0xa8
function function_c9466e61(v_pos, radius) {
    v_origin = getclosestpointonnavmesh(v_pos, radius);
    if (!isdefined(v_origin)) {
        e_player = zm_utility::get_closest_player(v_pos);
        v_origin = getclosestpointonnavmesh(e_player.origin, radius);
    }
    if (!isdefined(v_origin)) {
        v_origin = v_pos;
    }
    return v_origin;
}

// Namespace namespace_81256d2f
// Params 0, eflags: 0x0
// Checksum 0x8b5e488d, Offset: 0x2ff0
// Size: 0xf4
function function_92f587b4() {
    self endon(#"hash_c2022405");
    wait(15);
    for (i = 0; i < 40; i++) {
        if (i % 2) {
            self.var_8fcb4b32 ghost();
        } else {
            self.var_8fcb4b32 show();
        }
        if (i < 15) {
            wait(0.5);
            continue;
        }
        if (i < 25) {
            wait(0.25);
            continue;
        }
        wait(0.1);
    }
    self.var_8fcb4b32 delete();
    zm_unitrigger::unregister_unitrigger(self);
}

// Namespace namespace_81256d2f
// Params 1, eflags: 0x0
// Checksum 0xd191ef97, Offset: 0x30f0
// Size: 0x84
function function_bc9cb328(e_player) {
    if (e_player clientfield::get_to_player("pod_sprayer_held")) {
        return %ZM_ZOD_POD_HARVEST;
    }
    if (e_player clientfield::get_to_player("pod_sprayer_hint_range") == 0) {
        e_player thread function_3f5779c4();
    }
    return %;
}

// Namespace namespace_81256d2f
// Params 0, eflags: 0x0
// Checksum 0x6afb123, Offset: 0x3180
// Size: 0x54
function function_3f5779c4() {
    self endon(#"disconnect");
    self clientfield::set_to_player("pod_sprayer_hint_range", 1);
    wait(1);
    self clientfield::set_to_player("pod_sprayer_hint_range", 0);
}

// Namespace namespace_81256d2f
// Params 1, eflags: 0x0
// Checksum 0xefbae72f, Offset: 0x31e0
// Size: 0x508
function function_d6abde0a(var_d23318a4) {
    if (level flag::get("hide_pods_for_trailer")) {
        return;
    }
    var_a908275a = [];
    foreach (var_f64bb476 in level.var_6fa2f6ca.var_4042b27e) {
        if (isdefined(var_f64bb476.var_6cfbf8d6)) {
            var_3b9e1bb8 = level.round_number - var_f64bb476.var_6cfbf8d6;
            if (var_3b9e1bb8 < 2 && !(isdefined(level.var_7cf7b906) && level.var_7cf7b906)) {
                continue;
            }
        }
        var_11fb7a41 = 0;
        a_players = getplayers();
        foreach (player in a_players) {
            if (distance(player.origin, var_f64bb476.origin) < 200) {
                var_11fb7a41 = 1;
                break;
            }
        }
        if (var_11fb7a41) {
            continue;
        }
        if (!isdefined(var_a908275a)) {
            var_a908275a = [];
        } else if (!isarray(var_a908275a)) {
            var_a908275a = array(var_a908275a);
        }
        var_a908275a[var_a908275a.size] = var_f64bb476;
    }
    var_a908275a = array::randomize(var_a908275a);
    var_25d26371 = [];
    for (i = 0; i < var_d23318a4 && var_a908275a.size > 0; i++) {
        n_index = var_a908275a.size - 1;
        s_pod = var_a908275a[n_index];
        if (var_d23318a4 <= 5 && isdefined(s_pod.zone) && isdefined(var_25d26371[s_pod.zone])) {
            continue;
        }
        arrayremovevalue(level.var_6fa2f6ca.var_4042b27e, s_pod);
        arrayremoveindex(var_a908275a, n_index);
        if (!isdefined(level.var_6fa2f6ca.var_5d8c3695)) {
            level.var_6fa2f6ca.var_5d8c3695 = [];
        } else if (!isarray(level.var_6fa2f6ca.var_5d8c3695)) {
            level.var_6fa2f6ca.var_5d8c3695 = array(level.var_6fa2f6ca.var_5d8c3695);
        }
        level.var_6fa2f6ca.var_5d8c3695[level.var_6fa2f6ca.var_5d8c3695.size] = s_pod;
        s_pod.var_8486ae6a = 1;
        level notify("pod_" + s_pod.script_int + "_hatched");
        s_pod.model clientfield::set("update_fungus_pod_level", s_pod.var_8486ae6a);
        s_pod thread function_e1065706();
        s_pod thread function_5f89f77a();
        if (isdefined(s_pod.zone)) {
            if (!isdefined(var_25d26371[s_pod.zone])) {
                var_25d26371[s_pod.zone] = 0;
            }
            var_25d26371[s_pod.zone]++;
        }
    }
}

// Namespace namespace_81256d2f
// Params 0, eflags: 0x0
// Checksum 0xcbe7deec, Offset: 0x36f0
// Size: 0x82
function function_e1065706() {
    wait(getanimlength("p7_fxanim_zm_zod_fungus_pod_base_birth_anim"));
    self.trigger = namespace_8e578893::function_d095318(self.origin + anglestoup(self.angles) * 8, 50, 1, &function_bc9cb328);
    self notify(#"hash_e446a51c");
}

// Namespace namespace_81256d2f
// Params 1, eflags: 0x0
// Checksum 0xb5d1fb0a, Offset: 0x3780
// Size: 0xe8
function function_3674f451(player) {
    if (!zm_utility::is_player_valid(player) || player.is_drinking > 0 || !player zm_magicbox::can_buy_weapon() || player bgb::is_enabled("zm_bgb_disorderly_combat")) {
        self sethintstring(%);
        return false;
    }
    self setcursorhint("HINT_WEAPON", self.stub.wpn);
    self sethintstring(%ZOMBIE_TRADE_WEAPON_FILL);
    return true;
}

// Namespace namespace_81256d2f
// Params 1, eflags: 0x0
// Checksum 0x4aa6dbcc, Offset: 0x3870
// Size: 0x10c
function function_b0138b1(w_weapon) {
    w_base_weapon = zm_weapons::get_base_weapon(w_weapon);
    players = getplayers();
    foreach (player in players) {
        if (!isdefined(player) || !isalive(player)) {
            continue;
        }
        if (player zm_weapons::has_weapon_or_upgrade(w_base_weapon)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_81256d2f
// Params 2, eflags: 0x0
// Checksum 0x7e0e5b06, Offset: 0x3988
// Size: 0x250
function function_e07a8850(var_6413b107, var_c74eff46) {
    v_spawnpt = self.origin + (0, 0, 40);
    var_f8c6b1d7 = (0, 0, 0);
    v_angles = var_6413b107 getplayerangles();
    v_angles = (0, v_angles[1], 0) + (0, 90, 0) + var_f8c6b1d7;
    m_weapon = zm_utility::spawn_buildkit_weapon_model(var_6413b107, var_c74eff46, undefined, v_spawnpt, v_angles);
    m_weapon.angles = v_angles;
    m_weapon thread timer_til_despawn(v_spawnpt, 40 * -1);
    m_weapon endon(#"hash_8bc1969d");
    m_weapon.trigger = namespace_8e578893::function_d095318(v_spawnpt, 100, 1);
    m_weapon.trigger.wpn = var_c74eff46;
    m_weapon.trigger.prompt_and_visibility_func = &function_3674f451;
    player = m_weapon.trigger waittill(#"trigger");
    m_weapon.trigger notify(#"weapon_grabbed");
    m_weapon.trigger thread swap_weapon(var_c74eff46, player);
    if (isdefined(m_weapon.trigger)) {
        zm_unitrigger::unregister_unitrigger(m_weapon.trigger);
        m_weapon.trigger = undefined;
    }
    if (isdefined(m_weapon)) {
        m_weapon delete();
    }
    if (player != var_6413b107) {
        var_6413b107 notify(#"hash_f8352f34");
    }
}

// Namespace namespace_81256d2f
// Params 2, eflags: 0x0
// Checksum 0x6b29bdba, Offset: 0x3be0
// Size: 0x114
function swap_weapon(var_9f85aad5, e_player) {
    wpn_current = e_player getcurrentweapon();
    if (!zm_utility::is_player_valid(e_player)) {
        return;
    }
    if (e_player.is_drinking > 0) {
        return;
    }
    if (zm_utility::is_placeable_mine(wpn_current) || zm_equipment::is_equipment(wpn_current) || wpn_current == level.weaponnone) {
        return;
    }
    if (!e_player hasweapon(var_9f85aad5.rootweapon, 1)) {
        e_player function_dcfc8bde(wpn_current, var_9f85aad5);
        return;
    }
    e_player givemaxammo(var_9f85aad5);
}

// Namespace namespace_81256d2f
// Params 2, eflags: 0x0
// Checksum 0x1f5a90c4, Offset: 0x3d00
// Size: 0xd4
function function_dcfc8bde(current_weapon, weapon) {
    a_weapons = self getweaponslistprimaries();
    if (isdefined(a_weapons) && a_weapons.size >= zm_utility::get_player_weapon_limit(self)) {
        self takeweapon(current_weapon);
    }
    var_7b9ca68 = self zm_weapons::give_build_kit_weapon(weapon);
    self giveweapon(var_7b9ca68);
    self switchtoweapon(var_7b9ca68);
}

// Namespace namespace_81256d2f
// Params 2, eflags: 0x0
// Checksum 0x42f99c7c, Offset: 0x3de0
// Size: 0xc4
function timer_til_despawn(v_float, n_dist) {
    self endon(#"weapon_grabbed");
    putbacktime = 12;
    self movez(n_dist, putbacktime, putbacktime * 0.5);
    self waittill(#"movedone");
    self notify(#"hash_8bc1969d");
    if (isdefined(self.trigger)) {
        zm_unitrigger::unregister_unitrigger(self.trigger);
        self.trigger = undefined;
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_81256d2f
// Params 0, eflags: 0x0
// Checksum 0x7821053a, Offset: 0x3eb0
// Size: 0x12
function function_20affc0e() {
    return level.var_6fa2f6ca.var_568a16f7;
}

// Namespace namespace_81256d2f
// Params 0, eflags: 0x0
// Checksum 0xed998e9f, Offset: 0x3ed0
// Size: 0x1f8
function function_956d3c82() {
    for (i = 1; i <= 3; i++) {
        n_total = 0;
        foreach (reward in level.var_6fa2f6ca.rewards[i]) {
            if (!(isdefined(reward.var_17fcbfca) && reward.var_17fcbfca)) {
                n_total += float(reward.chance);
            }
        }
        /#
            assert(reward.chance > 0);
        #/
        foreach (reward in level.var_6fa2f6ca.rewards[i]) {
            if (!(isdefined(reward.var_17fcbfca) && reward.var_17fcbfca)) {
                reward.chance = reward.chance / n_total * 100;
            }
        }
    }
}

// Namespace namespace_81256d2f
// Params 0, eflags: 0x0
// Checksum 0x4c5a526d, Offset: 0x40d0
// Size: 0x122
function function_2947f395() {
    level flag::set("hide_pods_for_trailer");
    foreach (pod in level.var_6fa2f6ca.spawned) {
        pod.buff = 0;
        pod.var_70ac16f8 = 0;
        zm_unitrigger::unregister_unitrigger(pod.trigger);
        if (isdefined(self.var_7a88c258)) {
            pod.var_7a88c258 delete();
        }
        arrayremovevalue(level.var_6fa2f6ca.spawned, self);
    }
}

// Namespace namespace_81256d2f
// Params 0, eflags: 0x0
// Checksum 0x993e3bfb, Offset: 0x4200
// Size: 0xea
function function_3f95af32() {
    foreach (player in level.activeplayers) {
        player clientfield::set_to_player("pod_sprayer_held", 1);
        player thread namespace_8e578893::function_55f114f9("zmInventory.widget_sprayer", 3.5);
        player.var_abe77dc0 = 1;
        level flag::set("any_player_has_pod_sprayer");
    }
}

