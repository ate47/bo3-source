#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_genesis_util;
#using scripts/zm/zm_genesis_vo;

#namespace zm_genesis_radios;

// Namespace zm_genesis_radios
// Params 0, eflags: 0x2
// Checksum 0x5850a557, Offset: 0x5c0
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_genesis_radios", &__init__, &__main__, undefined);
}

// Namespace zm_genesis_radios
// Params 0, eflags: 0x0
// Checksum 0x6950c7eb, Offset: 0x608
// Size: 0x24
function __init__() {
    callback::on_disconnect(&on_player_disconnect);
}

// Namespace zm_genesis_radios
// Params 0, eflags: 0x0
// Checksum 0x2ee61a66, Offset: 0x638
// Size: 0x3c
function __main__() {
    /#
        level thread function_9ef4291();
    #/
    level waittill(#"start_zombie_round_logic");
    level thread function_a999a42a();
}

// Namespace zm_genesis_radios
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x680
// Size: 0x4
function on_player_disconnect() {
    
}

// Namespace zm_genesis_radios
// Params 0, eflags: 0x0
// Checksum 0xc4040217, Offset: 0x690
// Size: 0x3b6
function function_a999a42a() {
    level.var_66b7ed7e = [];
    level.var_22e09be4 = [];
    level.var_22e09be4["divine_comedy"] = array("vox_abcd_excerpt_divine_0");
    level.var_22e09be4["theatre"] = array("vox_abcd_excerpt_tempest_0");
    level.var_22e09be4["asylum"] = array("vox_sfx_radio_stem_verruckt_0");
    level.var_22e09be4["mob"] = array("vox_sfx_radio_stem_mob_log_1_0", "vox_sfx_radio_stem_mob_log_2_0", "vox_sfx_radio_stem_mob_log_3_0");
    level.var_22e09be4["trenches"] = array("vox_sfx_radio_stem_origins_log_0");
    level.var_22e09be4["romeros_assistant"] = array("vox_sall_shangri_log_1_0", "vox_sall_shangri_log_2_0", "vox_sall_shangri_log_3_0", "vox_sfx_radio_stem_shangri_log_4_0");
    level.var_22e09be4["island"] = array("vox_sfx_radio_stem_shinonuma_log_0");
    level.var_22e09be4["mcnamara"] = array("vox_nama_namara_log_0");
    var_1ee7893 = struct::get_array("s_radio", "targetname");
    level.var_1ee7893 = array::sort_by_script_int(var_1ee7893, 1);
    var_64dfb3ba = getentarray("clip_radio", "targetname");
    var_a399b51e = array::sort_by_script_int(var_64dfb3ba, 1);
    var_ff34523e = array(5, 8, 10, 11, 12, 13);
    for (i = 0; i < level.var_1ee7893.size; i++) {
        level.var_1ee7893[i].clip = arraygetclosest(level.var_1ee7893[i].origin, var_64dfb3ba);
        s_unitrigger = level.var_1ee7893[i] zm_unitrigger::create_unitrigger(%, 64, &function_2c776a2a);
        s_unitrigger.require_look_at = 1;
        s_unitrigger.b_on = 1;
        level.var_1ee7893[i] thread function_795f4e6();
        var_32be5a3 = i + 1;
        if (isinarray(var_ff34523e, var_32be5a3)) {
            level.var_1ee7893[i] thread function_35f4f25f();
        }
    }
}

// Namespace zm_genesis_radios
// Params 1, eflags: 0x0
// Checksum 0x1f2a9cdc, Offset: 0xa50
// Size: 0x80
function function_2c776a2a(e_player) {
    if (isdefined(self.stub.b_on) && self.stub.b_on) {
        /#
            self sethintstring("<dev string:x28>");
        #/
        return 1;
    }
    /#
        self sethintstring("<dev string:x38>");
    #/
    return 0;
}

// Namespace zm_genesis_radios
// Params 0, eflags: 0x0
// Checksum 0xe6879e94, Offset: 0xad8
// Size: 0xe2
function function_795f4e6() {
    self endon(#"hash_e37d497d");
    while (true) {
        self waittill(#"trigger_activated", e_user);
        if (isplayer(e_user) && !level flag::get("abcd_speaking") && !level flag::get("sophia_speaking") && !level flag::get("shadowman_speaking") && !self function_94b3b616()) {
            self thread function_66d50897("trigger");
            return;
        }
    }
}

// Namespace zm_genesis_radios
// Params 0, eflags: 0x0
// Checksum 0x259a6fe9, Offset: 0xbc8
// Size: 0x174
function function_35f4f25f() {
    self endon(#"hash_e37d497d");
    self endon(#"hash_27f23694");
    self.clip setcandamage(1);
    var_b1c8a081 = 0;
    while (!var_b1c8a081) {
        self.clip waittill(#"damage", n_amount, e_attacker, v_org, v_dir, str_mod);
        if (isplayer(e_attacker) && !level flag::get("abcd_speaking") && !level flag::get("sophia_speaking") && !level flag::get("shadowman_speaking") && !self function_94b3b616()) {
            var_b1c8a081 = 1;
            self thread function_66d50897("damage");
            continue;
        }
        self.clip.health = 100000;
    }
}

// Namespace zm_genesis_radios
// Params 1, eflags: 0x0
// Checksum 0x81be40bc, Offset: 0xd48
// Size: 0x1b4
function function_66d50897(var_ffc8395e) {
    if (self.s_unitrigger.b_on) {
        self notify(#"hash_e37d497d");
        self.clip setcandamage(0);
        self.s_unitrigger.b_on = 0;
        zm_unitrigger::unregister_unitrigger(self);
        str_set = self.script_noteworthy;
        if (level.var_22e09be4[str_set].size) {
            str_vo = level.var_22e09be4[str_set][0];
            if (isdefined(str_vo)) {
                if (var_ffc8395e == "damage") {
                    var_c46d7830 = self.clip.origin;
                } else {
                    var_c46d7830 = self.origin;
                }
                array::add(level.var_66b7ed7e, self, 0);
                arrayremoveindex(level.var_22e09be4[str_set], 0);
                var_5cd02106 = soundgetplaybacktime(str_vo);
                if (var_5cd02106 > 0) {
                    var_269117b2 = var_5cd02106 / 1000;
                    playsoundatposition(str_vo, var_c46d7830);
                    wait var_269117b2;
                }
                arrayremovevalue(level.var_66b7ed7e, self);
            }
        }
    }
}

// Namespace zm_genesis_radios
// Params 1, eflags: 0x0
// Checksum 0xcc885a81, Offset: 0xf08
// Size: 0xb4
function function_94b3b616(n_range) {
    if (!isdefined(n_range)) {
        n_range = 800;
    }
    if (level.var_66b7ed7e.size == 0) {
        return 0;
    }
    var_f39e4895 = arraygetclosest(self.origin, level.var_66b7ed7e);
    if (isdefined(var_f39e4895)) {
        n_dist = distance(self.origin, var_f39e4895.origin);
        return (n_dist <= n_range);
    }
    return 0;
}

/#

    // Namespace zm_genesis_radios
    // Params 0, eflags: 0x0
    // Checksum 0x2495d42f, Offset: 0xfc8
    // Size: 0x5bc
    function function_9ef4291() {
        level thread zm_genesis_util::function_72260d3a("<dev string:x49>", "<dev string:x71>", 1, &function_418d5e87);
        level thread zm_genesis_util::function_72260d3a("<dev string:x80>", "<dev string:xa4>", 1, &function_dda18b8e);
        level thread zm_genesis_util::function_72260d3a("<dev string:xb2>", "<dev string:x71>", 2, &function_418d5e87);
        level thread zm_genesis_util::function_72260d3a("<dev string:xda>", "<dev string:xa4>", 2, &function_dda18b8e);
        level thread zm_genesis_util::function_72260d3a("<dev string:xfe>", "<dev string:x71>", 3, &function_418d5e87);
        level thread zm_genesis_util::function_72260d3a("<dev string:x126>", "<dev string:xa4>", 3, &function_dda18b8e);
        level thread zm_genesis_util::function_72260d3a("<dev string:x14a>", "<dev string:x71>", 4, &function_418d5e87);
        level thread zm_genesis_util::function_72260d3a("<dev string:x172>", "<dev string:xa4>", 4, &function_dda18b8e);
        level thread zm_genesis_util::function_72260d3a("<dev string:x196>", "<dev string:x71>", 5, &function_418d5e87);
        level thread zm_genesis_util::function_72260d3a("<dev string:x1be>", "<dev string:xa4>", 5, &function_dda18b8e);
        level thread zm_genesis_util::function_72260d3a("<dev string:x1e2>", "<dev string:x71>", 6, &function_418d5e87);
        level thread zm_genesis_util::function_72260d3a("<dev string:x20a>", "<dev string:xa4>", 6, &function_dda18b8e);
        level thread zm_genesis_util::function_72260d3a("<dev string:x22e>", "<dev string:x71>", 7, &function_418d5e87);
        level thread zm_genesis_util::function_72260d3a("<dev string:x256>", "<dev string:xa4>", 7, &function_dda18b8e);
        level thread zm_genesis_util::function_72260d3a("<dev string:x27a>", "<dev string:x71>", 8, &function_418d5e87);
        level thread zm_genesis_util::function_72260d3a("<dev string:x2a2>", "<dev string:xa4>", 8, &function_dda18b8e);
        level thread zm_genesis_util::function_72260d3a("<dev string:x2c6>", "<dev string:x71>", 9, &function_418d5e87);
        level thread zm_genesis_util::function_72260d3a("<dev string:x2ee>", "<dev string:xa4>", 9, &function_dda18b8e);
        level thread zm_genesis_util::function_72260d3a("<dev string:x312>", "<dev string:x71>", 10, &function_418d5e87);
        level thread zm_genesis_util::function_72260d3a("<dev string:x33a>", "<dev string:xa4>", 10, &function_dda18b8e);
        level thread zm_genesis_util::function_72260d3a("<dev string:x35e>", "<dev string:x71>", 11, &function_418d5e87);
        level thread zm_genesis_util::function_72260d3a("<dev string:x386>", "<dev string:xa4>", 11, &function_dda18b8e);
        level thread zm_genesis_util::function_72260d3a("<dev string:x3aa>", "<dev string:x71>", 12, &function_418d5e87);
        level thread zm_genesis_util::function_72260d3a("<dev string:x3d2>", "<dev string:xa4>", 12, &function_dda18b8e);
        level thread zm_genesis_util::function_72260d3a("<dev string:x3f6>", "<dev string:x71>", 13, &function_418d5e87);
        level thread zm_genesis_util::function_72260d3a("<dev string:x41e>", "<dev string:xa4>", 13, &function_dda18b8e);
    }

    // Namespace zm_genesis_radios
    // Params 1, eflags: 0x0
    // Checksum 0x76a068ae, Offset: 0x1590
    // Size: 0x34
    function function_dda18b8e(n_val) {
        level.var_1ee7893[n_val - 1] thread function_66d50897();
    }

    // Namespace zm_genesis_radios
    // Params 1, eflags: 0x0
    // Checksum 0xe19ea38b, Offset: 0x15d0
    // Size: 0x11c
    function function_418d5e87(n_val) {
        str_dest = "<dev string:x442>" + n_val;
        s_dest = struct::get(str_dest);
        if (isdefined(s_dest)) {
            player = level.activeplayers[0];
            var_5d8a4d6d = util::spawn_model("<dev string:x454>", player.origin, player.angles);
            player linkto(var_5d8a4d6d);
            var_5d8a4d6d.origin = s_dest.origin;
            wait 0.5;
            player unlink();
            var_5d8a4d6d delete();
        }
    }

#/
