#using scripts/zm/zm_island_util;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_audio;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_14b4d4ab;

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x2
// Checksum 0x17eea3f6, Offset: 0xa10
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_island_traps", &__init__, undefined, undefined);
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0xb7ead024, Offset: 0xa50
// Size: 0x104
function __init__() {
    clientfield::register("world", "proptrap_downdraft_rumble", 9000, 1, "int");
    clientfield::register("toplayer", "proptrap_downdraft_blur", 9000, 1, "int");
    clientfield::register("world", "walltrap_draft_rumble", 9000, 1, "int");
    clientfield::register("toplayer", "walltrap_draft_blur", 9000, 1, "int");
    level flag::init("witnessed_trapkill_dialog");
    callback::on_player_killed(&function_2ee3731e);
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0x828a3182, Offset: 0xb60
// Size: 0x44
function function_2ee3731e() {
    self clientfield::set("proptrap_downdraft_blur", 0);
    self clientfield::set("walltrap_draft_blur", 0);
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0x99fa3a57, Offset: 0xbb0
// Size: 0x66
function function_7309e48() {
    function_b2e2a102();
    function_7dea397f();
    function_17303d81();
    level thread function_74ddcad3();
    level notify(#"hash_288b3c6c");
    level notify(#"power_on1");
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0x56f1902f, Offset: 0xc20
// Size: 0x74
function function_7dea397f() {
    level thread scene::init("p7_fxanim_zm_island_engine_trap_on_bundle");
    level thread scene::add_scene_func("p7_fxanim_zm_island_engine_trap_on_bundle", &function_3c8c2e02, "init");
    function_9a88139e();
    function_74859935();
}

// Namespace namespace_14b4d4ab
// Params 1, eflags: 0x0
// Checksum 0x1a1030a9, Offset: 0xca0
// Size: 0x44
function function_3c8c2e02(a_ents) {
    var_f6dbc18f = a_ents["fxanim_engine_trap"];
    var_f6dbc18f setignorepauseworld(1);
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0x842c1cdf, Offset: 0xcf0
// Size: 0x204
function function_9a88139e() {
    level.var_e938db57 = getent("mdl_propellertrap_a_body", "script_string");
    level.var_e938db57.str_type = "PROPTRAP_a";
    level.var_e938db57.var_e80e0d58 = "fxexp_110";
    level.var_e938db57.var_efa7240e = getent("mdl_propellertrap_a_propeller", "script_string");
    level.var_e938db57 hide();
    level.var_e938db57.var_efa7240e hide();
    level.var_e938db57.var_d93f9cb8 = getent("t_propellertrap_a_death", "script_string");
    level.var_e938db57.var_2a4af70 = getent("t_proptrap_a_spiders", "targetname");
    level.var_e938db57.var_7117876c = level.var_e938db57.origin;
    level.var_e938db57.var_c780fb80 = level.var_e938db57.origin + (0, 0, 30);
    level.var_e938db57.var_380861c6 = level.var_e938db57.angles;
    level.var_e938db57.var_401e166a = level.var_e938db57.angles;
    level.var_e938db57.var_16e1fdfb = &function_b0658775;
    level.var_e938db57._trap_type = "propeller";
    level.var_e938db57 function_3a8453ed();
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0xeaffa2d4, Offset: 0xf00
// Size: 0x204
function function_74859935() {
    level.var_77316c1c = getent("mdl_propellertrap_b_body", "script_string");
    level.var_77316c1c.str_type = "PROPTRAP_b";
    level.var_77316c1c.var_e80e0d58 = "fxexp_112";
    level.var_77316c1c.var_efa7240e = getent("mdl_propellertrap_b_propeller", "script_string");
    level.var_77316c1c hide();
    level.var_77316c1c.var_efa7240e hide();
    level.var_77316c1c.var_d93f9cb8 = getent("t_propellertrap_b_death", "script_string");
    level.var_77316c1c.var_2a4af70 = getent("t_proptrap_b_spiders", "targetname");
    level.var_77316c1c.var_7117876c = level.var_77316c1c.origin;
    level.var_77316c1c.var_c780fb80 = level.var_77316c1c.origin + (0, 0, 100);
    level.var_77316c1c.var_380861c6 = (75, 270, -89.992);
    level.var_77316c1c.var_401e166a = (75, 270, -90);
    level.var_77316c1c.var_16e1fdfb = &function_bc1706ea;
    level.var_77316c1c._trap_type = "propeller";
    level.var_77316c1c function_3a8453ed();
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0xa3d8c03c, Offset: 0x1110
// Size: 0x144
function function_97e8fd81() {
    self.var_efa7240e linkto(self);
    wait(0.1);
    self moveto(self.var_7117876c, 1);
    self rotateto(self.var_380861c6, 1);
    self playsound("evt_propeller_trap_engine_start");
    self waittill(#"movedone");
    self.var_efa7240e unlink();
    self.b_on = 1;
    self.var_d93f9cb8 triggerenable(1);
    self thread function_74e1faeb();
    self thread [[ self.var_16e1fdfb ]]();
    exploder::exploder(self.var_e80e0d58);
    self thread sound::loop_fx_sound("evt_propeller_trap_engine", self.origin, "stoploop");
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0x7607b7d5, Offset: 0x1260
// Size: 0xfc
function function_3a8453ed() {
    self notify(#"hash_a7a4f8be");
    self.b_on = 0;
    self.var_d93f9cb8 triggerenable(0);
    exploder::stop_exploder(self.var_e80e0d58);
    self notify(#"hash_12997be7");
    self playsound("evt_propeller_trap_engine_stop");
    wait(0.5);
    self.var_efa7240e linkto(self);
    wait(0.1);
    self moveto(self.var_c780fb80, 1);
    self rotateto(self.var_401e166a, 1);
    wait(1.5);
    self.var_efa7240e unlink();
}

// Namespace namespace_14b4d4ab
// Params 1, eflags: 0x0
// Checksum 0x1bc3bcec, Offset: 0x1368
// Size: 0x28c
function function_fd097b36(var_6afd6b) {
    var_609ec145 = struct::get("s_engine_trap_loc", "targetname");
    var_609ec145 thread scene::play("p7_fxanim_zm_island_engine_trap_on_bundle");
    level.var_e938db57 thread function_d93740e5(var_6afd6b);
    level.var_77316c1c thread function_d93740e5(var_6afd6b);
    mdl_lever = level.var_cefa7a2a[self.stub.script_noteworthy];
    mdl_lever thread scene::play("p7_fxanim_zm_island_switch_trap_lever_bundle", mdl_lever);
    level clientfield::set("proptrap_downdraft_rumble", 1);
    foreach (player in level.activeplayers) {
        player clientfield::set_to_player("proptrap_downdraft_blur", 1);
    }
    self playsound("evt_propeller_trap_start");
    wait(30);
    level clientfield::set("proptrap_downdraft_rumble", 0);
    foreach (player in level.activeplayers) {
        player clientfield::set_to_player("proptrap_downdraft_blur", 0);
    }
    var_609ec145 scene::play("p7_fxanim_zm_island_engine_trap_off_bundle");
    var_609ec145 scene::init("p7_fxanim_zm_island_engine_trap_on_bundle");
}

// Namespace namespace_14b4d4ab
// Params 3, eflags: 0x0
// Checksum 0x113658, Offset: 0x1600
// Size: 0x194
function function_d93740e5(e_player, var_edd82165, var_614a7182) {
    if (!isdefined(var_edd82165)) {
        var_edd82165 = 30;
    }
    if (!isdefined(var_614a7182)) {
        var_614a7182 = 30;
    }
    if (self.b_on !== 1 && self.var_b44dbcd2 !== 1) {
        self.var_6afd6b = e_player;
        if (isdefined(e_player)) {
            e_player notify(#"hash_3b447bc1");
        }
        exploder::exploder_stop("ex_prop_switch");
        self playsound("zmb_trap_activated");
        self thread function_97e8fd81();
        wait(var_edd82165);
        self thread function_3a8453ed();
        self.var_6afd6b = undefined;
        self.var_b44dbcd2 = 1;
        wait(var_614a7182);
        self.var_b44dbcd2 = 0;
        self playsound("zmb_trap_ready");
        if (level flag::get("power_on1") || level flag::get("power_on")) {
            exploder::exploder("ex_prop_switch");
        }
    }
}

// Namespace namespace_14b4d4ab
// Params 1, eflags: 0x0
// Checksum 0xfbb3654f, Offset: 0x17a0
// Size: 0x1da
function function_a9e415bd(b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    if (isdefined(b_on) && b_on) {
        var_719bbcb8 = struct::get_array("s_proptrap_downdraft_rumble", "targetname");
        level.var_69abefde = [];
        foreach (var_dd3351d8 in var_719bbcb8) {
            var_9866f6f9 = util::spawn_model("tag_origin", var_dd3351d8.origin, var_dd3351d8.angles);
            array::add(level.var_69abefde, var_9866f6f9);
            var_9866f6f9 playrumbleonentity("zm_island_rumble_proptrap_downdraft");
        }
        return;
    }
    foreach (var_9866f6f9 in level.var_69abefde) {
        var_9866f6f9 delete();
    }
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0xcc73468c, Offset: 0x1988
// Size: 0x50
function function_b0658775() {
    self endon(#"hash_a7a4f8be");
    while (self.b_on === 1) {
        self.var_efa7240e rotateroll(1000, 0.5);
        wait(0.5);
    }
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0x4c22eb2f, Offset: 0x19e0
// Size: 0x50
function function_bc1706ea() {
    self endon(#"hash_a7a4f8be");
    while (self.b_on === 1) {
        self.var_efa7240e rotateroll(1000, 0.5);
        wait(0.5);
    }
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0xf22ccd89, Offset: 0x1a38
// Size: 0xd8
function function_74e1faeb() {
    self endon(#"hash_a7a4f8be");
    self._trap_type = "rotating";
    self.activated_by_player = self.var_6afd6b;
    self thread function_b3390115();
    while (self.b_on === 1) {
        ent = self.var_d93f9cb8 waittill(#"trigger");
        if (zombie_utility::is_player_valid(ent)) {
            ent thread function_de0d7531(self);
            continue;
        }
        ent thread function_12a70fc8(self, ent.origin);
        wait(0.1);
    }
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0x9334f159, Offset: 0x1b18
// Size: 0xc8
function function_b3390115() {
    self endon(#"hash_a7a4f8be");
    while (self.b_on === 1) {
        ent = self.var_2a4af70 waittill(#"trigger");
        if (ent.archetype === "spider" && isalive(ent) && !(isdefined(ent.var_b6e7a15) && ent.var_b6e7a15)) {
            ent.var_b6e7a15 = 1;
            ent thread function_2319463d(self);
        }
    }
}

// Namespace namespace_14b4d4ab
// Params 1, eflags: 0x0
// Checksum 0x50710a09, Offset: 0x1be8
// Size: 0x14c
function function_2319463d(var_68fe148c) {
    self endon(#"death");
    var_1ee590e5 = var_68fe148c.var_efa7240e.origin;
    var_4ed4eec0 = util::spawn_model("tag_origin", self.origin, self.angles);
    self linkto(var_4ed4eec0);
    self thread function_e4b540d1(var_4ed4eec0);
    wait(0.1);
    if (isalive(self)) {
        self playsound("evt_wall_trap_suck");
        self thread scene::play("scene_zm_dlc2_spider_death_vacuum_sucked_upward", self);
        self waittill(#"scene_done");
        self playsound("evt_wall_trap_grind");
        self thread function_12a70fc8(var_68fe148c, var_1ee590e5);
    }
}

// Namespace namespace_14b4d4ab
// Params 1, eflags: 0x0
// Checksum 0x909533b4, Offset: 0x1d40
// Size: 0x2c
function function_e4b540d1(var_4ed4eec0) {
    self waittill(#"death");
    var_4ed4eec0 delete();
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0x6b19f6bb, Offset: 0x1d78
// Size: 0x64a
function function_17303d81() {
    var_d730823e = getentarray("lever", "script_tag");
    level.var_cefa7a2a = [];
    level.var_9c725b07 = [];
    foreach (mdl_lever in var_d730823e) {
        if (mdl_lever.script_noteworthy == "proptrap_a_onswitch" || mdl_lever.script_noteworthy == "proptrap_b_onswitch") {
            level.var_cefa7a2a[mdl_lever.script_noteworthy] = mdl_lever;
        } else {
            level.var_9c725b07[mdl_lever.script_noteworthy] = mdl_lever;
        }
        mdl_lever thread scene::init("p7_fxanim_zm_island_switch_trap_lever_bundle", mdl_lever);
        mdl_lever setignorepauseworld(1);
    }
    var_d3782b4c = struct::get_array("s_onswitch_unitrigger", "script_label");
    if (var_d3782b4c.size > 0) {
        foreach (var_2e0c3d2c in var_d3782b4c) {
            var_2e0c3d2c.script_unitrigger_type = "unitrigger_box_use";
            var_2e0c3d2c.cursor_hint = "HINT_NOICON";
            var_2e0c3d2c.require_look_at = 1;
            var_2e0c3d2c.var_a6a648f0 = self;
            var_2e0c3d2c.script_width = 100;
            var_2e0c3d2c.script_length = 100;
            var_2e0c3d2c.script_height = 100;
        }
        level.var_84662f56 = [];
        level.var_84662f56["proptraps_onswitch"] = %ZM_ISLAND_TRAP_PROPTRAP_USE;
        level.var_84662f56["walltrap_onswitch"] = %ZM_ISLAND_TRAP_WALLTRAP_USE;
        level.var_2e0a18df = [];
        level.var_2e0a18df["proptraps_onswitch"] = %ZM_ISLAND_TRAP_PROPTRAP_REST;
        level.var_2e0a18df["walltrap_onswitch"] = %ZM_ISLAND_TRAP_WALLTRAP_REST;
        level.var_af480c69 = [];
        level.var_af480c69["proptraps_onswitch"] = 1000;
        level.var_af480c69["walltrap_onswitch"] = 1000;
        level.var_8e8608e3 = [];
        level.var_569af21a = [];
        foreach (var_2e0c3d2c in var_d3782b4c) {
            /#
                assert(isdefined(var_2e0c3d2c.script_int), "s_proptrap_downdraft_rumble" + var_2e0c3d2c.targetname + "proptraps_onswitch");
            #/
            var_9ef8e179 = "power_on" + var_2e0c3d2c.script_int;
            var_2e0c3d2c.var_b28029bc = array(var_9ef8e179, "power_on");
            if (var_2e0c3d2c.targetname == "walltrap_onswitch") {
                var_2e0c3d2c.var_71dddffe = level.var_84662f56["walltrap_onswitch"];
                var_2e0c3d2c.var_d7141317 = level.var_2e0a18df["walltrap_onswitch"];
                var_2e0c3d2c.var_de0db1fd = 30;
                var_2e0c3d2c.var_614a7182 = 30;
                var_2e0c3d2c.n_cost = 1000;
                level.var_569af21a[var_2e0c3d2c.script_noteworthy] = var_2e0c3d2c;
                var_2e0c3d2c.prompt_and_visibility_func = &function_2f33d1b;
                zm_unitrigger::register_static_unitrigger(var_2e0c3d2c, &function_d6b07530);
                continue;
            }
            if (var_2e0c3d2c.targetname == "proptraps_onswitch") {
                var_2e0c3d2c.var_71dddffe = level.var_84662f56["proptraps_onswitch"];
                var_2e0c3d2c.var_d7141317 = level.var_2e0a18df["proptraps_onswitch"];
                var_2e0c3d2c.var_de0db1fd = 30;
                var_2e0c3d2c.var_614a7182 = 30;
                var_2e0c3d2c.n_cost = 1000;
                level.var_8e8608e3[var_2e0c3d2c.script_noteworthy] = var_2e0c3d2c;
                var_2e0c3d2c.prompt_and_visibility_func = &function_25bf44e4;
                zm_unitrigger::register_static_unitrigger(var_2e0c3d2c, &function_5245e8c3);
            }
        }
    }
}

// Namespace namespace_14b4d4ab
// Params 1, eflags: 0x0
// Checksum 0xca6af825, Offset: 0x23d0
// Size: 0x1d0
function function_2f33d1b(player) {
    if (isdefined(self.stub.script_int) && !level flag::get_any(self.stub.var_b28029bc) && level.var_dd5501c7[self.stub.target].b_on !== 1) {
        self sethintstring(%ZM_ISLAND_NO_POWER);
        exploder::stop_exploder("ex_fan_switch");
        return 0;
    }
    if (isdefined(self.stub.target) && level.var_dd5501c7[self.stub.target].b_on !== 1 && level.var_dd5501c7[self.stub.target].var_b44dbcd2 !== 1) {
        self sethintstring(level.var_84662f56[self.stub.targetname], level.var_af480c69[self.stub.targetname]);
        exploder::exploder("ex_fan_switch");
        return 1;
    }
    self sethintstring(level.var_2e0a18df[self.stub.targetname]);
    exploder::stop_exploder("ex_fan_switch");
    return 0;
}

// Namespace namespace_14b4d4ab
// Params 1, eflags: 0x0
// Checksum 0x8d5571d4, Offset: 0x25a8
// Size: 0x198
function function_25bf44e4(player) {
    if (level.var_e938db57.b_on !== 1 && isdefined(self.stub.script_int) && !level flag::get_any(self.stub.var_b28029bc) && level.var_77316c1c.b_on !== 1) {
        self sethintstring(%ZM_ISLAND_NO_POWER);
        exploder::stop_exploder("ex_prop_switch");
        return 0;
    }
    if (level.var_e938db57.b_on !== 1 && level.var_e938db57.var_b44dbcd2 !== 1) {
        self sethintstring(level.var_84662f56[self.stub.targetname], level.var_af480c69[self.stub.targetname]);
        exploder::exploder("ex_prop_switch");
        return 1;
    }
    self sethintstring(level.var_2e0a18df[self.stub.targetname]);
    exploder::stop_exploder("ex_prop_switch");
    return 0;
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0xda70b8aa, Offset: 0x2748
// Size: 0x320
function function_d6b07530() {
    while (true) {
        ent = self waittill(#"trigger");
        var_df549564 = 0;
        if (level.var_dd5501c7[self.stub.target].b_on !== 1 && level.var_dd5501c7[self.stub.target].var_b44dbcd2 !== 1) {
            if (isplayer(ent)) {
                if (self.stub.n_cost <= ent.score) {
                    ent zm_score::minus_to_player_score(self.stub.n_cost);
                    self playsound("evt_wall_trap_start");
                    if (isdefined(self.stub.script_linkto)) {
                        foreach (var_2b23f444 in level.var_569af21a) {
                            if (self.stub.script_linkto === var_2b23f444.script_noteworthy) {
                                mdl_lever = level.var_9c725b07[self.stub.script_noteworthy];
                                mdl_lever thread scene::play("p7_fxanim_zm_island_switch_trap_lever_bundle", mdl_lever);
                                level.var_dd5501c7[var_2b23f444.target] thread [[ level.var_dd5501c7[var_2b23f444.target].var_8bf7f16f ]](ent);
                                var_2b23f444.var_df549564 = 1;
                            }
                        }
                    }
                    var_df549564 = 1;
                } else {
                    ent function_770b3c6e();
                    var_df549564 = 0;
                }
            } else {
                var_df549564 = 1;
            }
            if (isdefined(var_df549564) && var_df549564) {
                level.var_dd5501c7[self.stub.target] thread [[ level.var_dd5501c7[self.stub.target].var_8bf7f16f ]](ent);
                self.stub.var_b44dbcd2 = 1;
                wait(self.stub.var_de0db1fd);
                self.stub.var_b44dbcd2 = 0;
            }
        }
    }
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0x3a745f4c, Offset: 0x2a70
// Size: 0x1f8
function function_5245e8c3() {
    while (true) {
        ent = self waittill(#"trigger");
        if (level.var_e938db57.b_on !== 1 && level.var_e938db57.var_b44dbcd2 !== 1) {
            if (zm_utility::is_player_valid(ent) && self.stub.n_cost <= ent.score) {
                ent zm_score::minus_to_player_score(self.stub.n_cost);
                self thread function_fd097b36(ent);
                foreach (var_f13de5d6 in level.var_8e8608e3) {
                    var_f13de5d6.var_b44dbcd2 = 1;
                }
                wait(self.stub.var_de0db1fd);
                foreach (var_f13de5d6 in level.var_8e8608e3) {
                    var_f13de5d6.var_b44dbcd2 = 0;
                }
                continue;
            }
            ent function_770b3c6e();
        }
    }
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0xb510e5e7, Offset: 0x2c70
// Size: 0x4c
function function_770b3c6e() {
    self playsound("evt_perk_deny");
    self zm_audio::create_and_play_dialog("general", "outofmoney");
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0xec98bc1, Offset: 0x2cc8
// Size: 0x462
function function_b2e2a102() {
    var_39467626 = getentarray("mdl_walltrap_blade", "script_string");
    var_790a24b0 = getentarray("t_walltrap_hazard", "script_string");
    var_7e25b6ee = getentarray("t_walltrap_death", "script_string");
    var_2b73bb92 = [];
    var_947d0bae = [];
    level.var_dd5501c7 = [];
    for (i = 0; i < var_790a24b0.size; i++) {
        if (isdefined(var_790a24b0[i].targetname) && var_790a24b0[i].targetname !== "") {
            level.var_dd5501c7[var_790a24b0[i].targetname] = var_790a24b0[i];
            level.var_dd5501c7[var_790a24b0[i].targetname].str_type = "WALLTRAP";
        }
        if (isdefined(var_39467626[i].targetname) && var_39467626[i].targetname !== "") {
            var_2b73bb92[var_39467626[i].targetname] = var_39467626[i];
        }
        if (isdefined(var_7e25b6ee[i].targetname) && var_7e25b6ee[i].targetname !== "") {
            var_947d0bae[var_7e25b6ee[i].targetname] = var_7e25b6ee[i];
        }
    }
    foreach (var_84d67e66 in level.var_dd5501c7) {
        if (isdefined(var_84d67e66.targetname) && var_84d67e66.targetname !== "") {
            level.var_dd5501c7[var_84d67e66.targetname].var_7e5afbd = var_2b73bb92[var_84d67e66.targetname];
            level.var_dd5501c7[var_84d67e66.targetname].var_d6d6c058 = anglestoforward(var_2b73bb92[var_84d67e66.targetname].angles) * -1;
            level.var_dd5501c7[var_84d67e66.targetname].var_6b281b64 = anglestoright(var_2b73bb92[var_84d67e66.targetname].angles) + level.var_dd5501c7[var_84d67e66.targetname].var_d6d6c058;
            level.var_dd5501c7[var_84d67e66.targetname].var_d93f9cb8 = var_947d0bae[var_84d67e66.targetname];
            level.var_dd5501c7[var_84d67e66.targetname].var_8bf7f16f = &function_4ed6e5ec;
            level.var_dd5501c7[var_84d67e66.targetname] function_823c5c5a();
        }
    }
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0xcd16dddb, Offset: 0x3138
// Size: 0x94
function function_ddff768c() {
    self.b_on = 1;
    self thread sound::loop_fx_sound("evt_wall_trap_loop", self.origin + (20, 100, 0), "walltrap_off");
    playsoundatposition("evt_wall_trap_start", self.origin + (20, 100, 0));
    self thread function_fde9856();
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0xab0c5177, Offset: 0x31d8
// Size: 0x92
function function_823c5c5a() {
    self.b_on = 0;
    self triggerenable(0);
    self.var_d93f9cb8 triggerenable(0);
    self function_4778351d(0);
    playsoundatposition("evt_wall_trap_end", self.origin + (20, 100, 0));
    self notify(#"hash_823c5c5a");
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0x633fd6d0, Offset: 0x3278
// Size: 0x44
function function_327061db() {
    if (self.b_on === 1) {
        self function_823c5c5a();
        return;
    }
    self function_ddff768c();
}

// Namespace namespace_14b4d4ab
// Params 1, eflags: 0x0
// Checksum 0xb8e5d6c7, Offset: 0x32c8
// Size: 0x94
function function_4778351d(b_turn_on) {
    if (!isdefined(b_turn_on)) {
        b_turn_on = 1;
    }
    if (b_turn_on) {
        exploder::exploder("fxexp_100");
        exploder::exploder("lgt_fan");
        return;
    }
    exploder::stop_exploder("fxexp_100");
    exploder::stop_exploder("lgt_fan");
}

// Namespace namespace_14b4d4ab
// Params 3, eflags: 0x0
// Checksum 0x4eefb3e9, Offset: 0x3368
// Size: 0x2a4
function function_4ed6e5ec(e_player, var_de0db1fd, var_614a7182) {
    if (!isdefined(var_de0db1fd)) {
        var_de0db1fd = 30;
    }
    if (!isdefined(var_614a7182)) {
        var_614a7182 = 30;
    }
    if (self.b_on !== 1 && self.var_b44dbcd2 !== 1) {
        self.var_6afd6b = e_player;
        if (isdefined(e_player)) {
            e_player notify(#"hash_9eca5f86");
        }
        level clientfield::set("walltrap_draft_rumble", 1);
        foreach (player in level.activeplayers) {
            player clientfield::set_to_player("walltrap_draft_blur", 1);
        }
        exploder::exploder_stop("ex_fan_switch");
        self playsound("zmb_trap_activated");
        self function_ddff768c();
        wait(var_de0db1fd);
        self function_823c5c5a();
        level clientfield::set("walltrap_draft_rumble", 0);
        foreach (player in level.activeplayers) {
            player clientfield::set_to_player("walltrap_draft_blur", 0);
        }
        self.var_6afd6b = undefined;
        self.var_b44dbcd2 = 1;
        wait(var_614a7182);
        self.var_b44dbcd2 = 0;
        self playsound("zmb_trap_ready");
        exploder::exploder("ex_fan_switch");
    }
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0xfa2b6591, Offset: 0x3618
// Size: 0x90
function function_fde9856() {
    self.var_7e5afbd rotateroll(1000, 1.5, 1);
    wait(1.5);
    self thread function_c801c84a();
    while (self.b_on === 1) {
        self.var_7e5afbd rotateroll(1000, 0.5);
        wait(0.5);
    }
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0x4c6ad2fe, Offset: 0x36b0
// Size: 0x108
function function_c801c84a() {
    self endon(#"hash_823c5c5a");
    self._trap_type = "rotating";
    self.activated_by_player = self.var_6afd6b;
    self function_4778351d(1);
    self triggerenable(1);
    self.var_d93f9cb8 triggerenable(1);
    while (self.b_on) {
        ent = self waittill(#"trigger");
        if (!ent laststand::player_is_in_laststand() && isalive(ent) && ent.var_96ff34d0 !== 1) {
            ent thread function_55a15733(self);
        }
    }
}

// Namespace namespace_14b4d4ab
// Params 1, eflags: 0x0
// Checksum 0x88026f7d, Offset: 0x37c0
// Size: 0x364
function function_55a15733(var_a464d35b) {
    self endon(#"hash_5798c1b0");
    var_a464d35b endon(#"hash_823c5c5a");
    self.var_96ff34d0 = 1;
    if (isplayer(self)) {
        var_b14e6934 = var_a464d35b.var_d6d6c058 * 75;
        while (isalive(self) && self istouching(var_a464d35b)) {
            if (self istouching(var_a464d35b.var_d93f9cb8)) {
                self function_de0d7531(var_a464d35b);
                self notify(#"hash_5798c1b0");
                break;
            }
            if (self issliding() || self issprinting()) {
                v_player_velocity = self getvelocity();
                var_64c3f8ef = v_player_velocity + var_b14e6934;
            } else {
                var_64c3f8ef = var_b14e6934;
            }
            self setvelocity(var_64c3f8ef);
            wait(0.05);
        }
        self.var_96ff34d0 = 0;
        return;
    }
    if (!(isdefined(self.var_61f7b3a0) && self.var_61f7b3a0)) {
        var_4ed4eec0 = util::spawn_model("tag_origin", self.origin, self.angles);
        self linkto(var_4ed4eec0);
        self playsound("evt_wall_trap_suck");
        n_time = distance(var_4ed4eec0.origin, var_a464d35b.var_d93f9cb8.origin) / 400;
        var_1ee590e5 = (var_a464d35b.var_d93f9cb8.origin[0], var_a464d35b.var_d93f9cb8.origin[1], self.origin[2]);
        level thread function_a569a27d(var_a464d35b, var_4ed4eec0, self);
        var_4ed4eec0 moveto(var_1ee590e5, n_time);
        var_4ed4eec0 waittill(#"movedone");
        self unlink();
        self playsound("evt_wall_trap_grind");
        self.var_96ff34d0 = 0;
        self thread function_12a70fc8(var_a464d35b, var_1ee590e5);
        var_4ed4eec0 delete();
    }
}

// Namespace namespace_14b4d4ab
// Params 3, eflags: 0x0
// Checksum 0xa284bddf, Offset: 0x3b30
// Size: 0x94
function function_a569a27d(var_a464d35b, var_4ed4eec0, e_victim) {
    var_a464d35b util::waittill_notify_or_timeout("walltrap_off", 1);
    if (isdefined(e_victim) && isalive(e_victim)) {
        e_victim unlink();
    }
    if (isdefined(var_4ed4eec0)) {
        var_4ed4eec0 delete();
    }
}

// Namespace namespace_14b4d4ab
// Params 2, eflags: 0x0
// Checksum 0x33bc2c7a, Offset: 0x3bd0
// Size: 0x4a4
function function_12a70fc8(e_trap, v_pos) {
    var_8f4b8aaf = "";
    if (e_trap.str_type == "PROPTRAP_a") {
        var_3497ae15 = "UPPERONLY";
        self.var_a35053a6 = 1;
        if (self.archetype == "thrasher") {
            exploder::exploder("fxexp_117");
        }
        if (self.archetype === "zombie") {
            exploder::exploder("fxexp_111");
            var_6afd6b = e_trap.var_6afd6b;
            var_401318b0 = array("update_challenge_3_4");
            var_8f4b8aaf = "player_saw_proptrap_kill";
        }
        if (self.archetype === "spider") {
            exploder::exploder("fxexp_119");
        }
    } else if (e_trap.str_type == "PROPTRAP_b") {
        var_3497ae15 = "UPPERONLY";
        self.var_a35053a6 = 1;
        if (self.archetype == "thrasher") {
            exploder::exploder("fxexp_116");
        }
        if (self.archetype === "zombie") {
            exploder::exploder("fxexp_113");
            var_6afd6b = e_trap.var_6afd6b;
            var_401318b0 = array("update_challenge_3_4");
            var_8f4b8aaf = "player_saw_proptrap_kill";
        }
        if (self.archetype === "spider") {
            exploder::exploder("fxexp_118");
        }
    } else {
        exploder::exploder("fxexp_101");
        if (self.archetype === "spider") {
            var_3497ae15 = "ALL";
            exploder::exploder("fxexp_102");
        }
        if (self.archetype === "zombie") {
            var_3497ae15 = "DELETE";
            var_6afd6b = e_trap.var_6afd6b;
            var_401318b0 = array("update_challenge_2_6");
            var_8f4b8aaf = "player_saw_walltrap_kill";
        }
    }
    if (var_3497ae15 !== "DELETE") {
        self thread function_21fd498a(var_3497ae15);
        self dodamage(self.health * 2, v_pos, e_trap, e_trap, "MOD_MELEE");
    } else {
        self dodamage(self.health * 2, v_pos, e_trap, e_trap, "MOD_MELEE");
        wait(0.05);
        self delete();
    }
    if (zm_utility::is_player_valid(var_6afd6b)) {
        var_6afd6b zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_TRAP");
        foreach (var_52b8c4f8 in var_401318b0) {
            var_6afd6b notify(var_52b8c4f8);
            wait(0.1);
        }
    }
    if (var_8f4b8aaf != "") {
        level thread function_df83b6d1(v_pos, var_8f4b8aaf);
    }
}

// Namespace namespace_14b4d4ab
// Params 2, eflags: 0x0
// Checksum 0x802f09cb, Offset: 0x4080
// Size: 0x18c
function function_df83b6d1(v_pos, var_8f4b8aaf) {
    self endon(#"death");
    if (!level flag::get("witnessed_trapkill_dialog")) {
        level flag::set("witnessed_trapkill_dialog");
        a_players = arraycopy(level.players);
        do {
            e_player = arraygetclosest(v_pos, a_players);
            if (zm_utility::is_player_valid(e_player) && e_player namespace_8aed53c9::is_facing(v_pos)) {
                var_520430be = e_player;
                continue;
            }
            arrayremovevalue(a_players, e_player);
        } while (!isdefined(var_520430be) && a_players.size > 0);
        if (zm_utility::is_player_valid(var_520430be)) {
            level flag::set("witnessed_trapkill_dialog");
            var_520430be notify(var_8f4b8aaf);
            wait(10);
            level flag::clear("witnessed_trapkill_dialog");
        }
    }
}

// Namespace namespace_14b4d4ab
// Params 1, eflags: 0x0
// Checksum 0x992276f6, Offset: 0x4218
// Size: 0xa4
function function_21fd498a(str_mode) {
    if (!isdefined(str_mode)) {
        str_mode = "ALL";
    }
    if (!(isdefined(self.no_gib) && self.no_gib)) {
        gibserverutils::gibhead(self);
    }
    gibserverutils::gibleftarm(self);
    gibserverutils::gibrightarm(self);
    if (str_mode == "ALL") {
        gibserverutils::giblegs(self);
    }
}

// Namespace namespace_14b4d4ab
// Params 1, eflags: 0x0
// Checksum 0x26172fd8, Offset: 0x42c8
// Size: 0xbc
function function_de0d7531(t_trap) {
    if (isdefined(t_trap.var_6b281b64)) {
        var_23b6ded0 = t_trap.var_6b281b64 * 75 * 10;
    } else {
        var_23b6ded0 = self.origin - t_trap.origin;
    }
    self setvelocity(var_23b6ded0);
    wait(0.05);
    self.var_96ff34d0 = 0;
    self dodamage(self.health * 2, self.origin);
}

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x0
// Checksum 0xd74ebd73, Offset: 0x4390
// Size: 0xe8
function function_74ddcad3() {
    level flag::wait_till("defend_over");
    var_fdcf3636 = getent("t_penstock_flow", "targetname");
    while (true) {
        ent = var_fdcf3636 waittill(#"trigger");
        if (zm_utility::is_player_valid(ent) && !(isdefined(ent.var_c73f00e0) && ent.var_c73f00e0)) {
            ent.var_c73f00e0 = 1;
            ent thread function_b90ebe4e(var_fdcf3636);
        }
    }
}

// Namespace namespace_14b4d4ab
// Params 1, eflags: 0x0
// Checksum 0xee0c0f4b, Offset: 0x4480
// Size: 0xcc
function function_b90ebe4e(var_fdcf3636) {
    self endon(#"death");
    var_b14e6934 = (0, -20, 0);
    while (zm_utility::is_player_valid(self) && self istouching(var_fdcf3636)) {
        v_player_velocity = self getvelocity();
        var_64c3f8ef = v_player_velocity + var_b14e6934;
        self setvelocity(var_64c3f8ef);
        wait(0.1);
    }
    self.var_c73f00e0 = 0;
}

