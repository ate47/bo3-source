#using scripts/zm/zm_genesis_util;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_f153ce01;

// Namespace namespace_f153ce01
// Params 0, eflags: 0x2
// Checksum 0xabac82cd, Offset: 0x878
// Size: 0x34
function function_2dc19561() {
    system::register("zm_genesis_arena", &__init__, undefined, undefined);
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x0
// Checksum 0x86409fd2, Offset: 0x8b8
// Size: 0x7ac
function __init__() {
    level.var_51541120 = [];
    clientfield::register("world", "arena_state", 15000, getminbitcountfornum(5), "int", &function_6d54bbfc, 0, 0);
    clientfield::register("world", "circle_state", 15000, getminbitcountfornum(6), "int", &function_82eec527, 0, 0);
    clientfield::register("world", "circle_challenge_identity", 15000, getminbitcountfornum(6), "int", undefined, 0, 0);
    clientfield::register("world", "summoning_key_charge_state", 15000, getminbitcountfornum(4), "int", &function_27bc8ef9, 0, 1);
    clientfield::register("toplayer", "fire_postfx_set", 15000, 1, "int", &function_2a4ba289, 0, 0);
    clientfield::register("scriptmover", "fire_column", 15000, 1, "int", &function_12d2195a, 0, 0);
    clientfield::register("scriptmover", "summoning_circle_fx", 15000, 1, "int", &function_fa762da4, 0, 0);
    clientfield::register("toplayer", "darkness_postfx_set", 15000, 1, "int", &function_cca0826e, 0, 0);
    clientfield::register("toplayer", "electricity_postfx_set", 15000, 1, "int", &function_25564e, 0, 0);
    clientfield::register("world", "light_challenge_floor", 15000, 1, "int", &function_4906c6c6, 0, 0);
    clientfield::register("actor", "arena_margwa_init", 15000, 1, "int", &function_9fdd5be3, 0, 0);
    clientfield::register("scriptmover", "arena_tornado", 15000, 1, "int", &function_646dab34, 0, 0);
    clientfield::register("scriptmover", "arena_shadow_pillar", 15000, 1, "int", &function_1a0568f8, 0, 0);
    clientfield::register("scriptmover", "elec_wall_tell", 15000, 1, "counter", &function_15141049, 0, 0);
    clientfield::register("world", "summoning_key_pickup", 15000, getminbitcountfornum(3), "int", &function_cdca4773, 0, 0);
    clientfield::register("world", "arena_timeout_warning", 15000, 1, "int", &function_60eb7d3f, 0, 0);
    clientfield::register("world", "basin_state_0", 15000, getminbitcountfornum(5), "int", &function_2af6ffb, 0, 1);
    clientfield::register("world", "basin_state_1", 15000, getminbitcountfornum(5), "int", &function_dcacf592, 0, 1);
    clientfield::register("world", "basin_state_2", 15000, getminbitcountfornum(5), "int", &function_b6aa7b29, 0, 1);
    clientfield::register("world", "basin_state_3", 15000, getminbitcountfornum(5), "int", &function_90a800c0, 0, 1);
    clientfield::register("scriptmover", "runeprison_rock_fx", 5000, 1, "int", &function_63be352d, 0, 0);
    clientfield::register("scriptmover", "runeprison_explode_fx", 5000, 1, "int", &function_409bb06f, 0, 0);
    var_29441edd = struct::get_array("powerup_visual", "targetname");
    foreach (var_f05dfe32 in var_29441edd) {
        var_f05dfe32.var_90369c89 = [];
    }
    clientfield::register("toplayer", "powerup_visual_marker", 15000, 2, "int", &function_b9c422c3, 0, 1);
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0xa9179433, Offset: 0x1070
// Size: 0x124
function function_27bc8ef9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_244d3483(localclientnum);
    level.var_530ae70[localclientnum] util::waittill_dobj(localclientnum);
    if (isdefined(level.var_530ae70[localclientnum].var_1397ba8a)) {
        stopfx(localclientnum, level.var_530ae70[localclientnum].var_1397ba8a);
    }
    level.var_530ae70[localclientnum].var_1397ba8a = playfxontag(localclientnum, level._effect["summoning_key_charge_" + newval + 1], level.var_530ae70[localclientnum], "key_root_jnt");
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0xd00ef7da, Offset: 0x11a0
// Size: 0x12a
function function_60eb7d3f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    a_players = getplayers(localclientnum);
    foreach (player in a_players) {
        if (newval > 0) {
            var_946b7723 = 5;
        } else {
            var_946b7723 = 0;
        }
        player thread namespace_cb655c88::function_f118a0e7(localclientnum, oldval, var_946b7723, bnewent, binitialsnap, fieldname, bwastimejump);
    }
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0x4e2c699c, Offset: 0x12d8
// Size: 0x12c
function function_15141049(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        playfxontag(localclientnum, level._effect["elec_wall_tell"], self, "tag_origin");
        v_origin = self.origin;
        wait(0.25);
        if (isdefined(self)) {
            fx = playfx(localclientnum, level._effect["elec_wall_arc"], v_origin, anglestoforward(self.angles));
            self waittill(#"entityshutdown");
            stopfx(localclientnum, fx);
        }
    }
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0x8e5c403e, Offset: 0x1410
// Size: 0x176
function function_63be352d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 0:
        self.var_f8ac8c8b animation::play("p7_fxanim_zm_bow_rune_prison_02_anim");
        if (!isdefined(self)) {
            return;
        }
        self.var_f8ac8c8b setmodel("p7_fxanim_zm_bow_rune_prison_dissolve_mod");
        self.var_f8ac8c8b thread function_79854312(localclientnum);
        self.var_f8ac8c8b animation::play("p7_fxanim_zm_bow_rune_prison_dissolve_anim");
        self.var_f8ac8c8b delete();
        break;
    case 1:
        self.var_f8ac8c8b = util::spawn_model(localclientnum, "p7_fxanim_zm_bow_rune_prison_mod", self.origin, self.angles);
        self.var_f8ac8c8b useanimtree(#generic);
        self.var_f8ac8c8b animation::play("p7_fxanim_zm_bow_rune_prison_01_anim");
        break;
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x0
// Checksum 0xdbda4f78, Offset: 0x1590
// Size: 0x118
function function_79854312(localclientnum) {
    self endon(#"entityshutdown");
    n_start_time = gettime();
    n_end_time = n_start_time + 1633;
    b_is_updating = 1;
    while (b_is_updating) {
        n_time = gettime();
        if (n_time >= n_end_time) {
            n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_end_time);
            b_is_updating = 0;
        } else {
            n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_time);
        }
        self mapshaderconstant(localclientnum, 0, "scriptVector0", n_shader_value, 0, 0);
        wait(0.016);
    }
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0x3973cc21, Offset: 0x16b0
// Size: 0x7c
function function_409bb06f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfx(localclientnum, level._effect["rune_fire_eruption"], self.origin, (0, 0, 1), (1, 0, 0));
    }
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0x21e9d9f7, Offset: 0x1738
// Size: 0x5c
function function_2af6ffb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_bb70f55a(localclientnum, newval, 0);
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0xbf945907, Offset: 0x17a0
// Size: 0x5c
function function_dcacf592(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_bb70f55a(localclientnum, newval, 1);
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0x86561420, Offset: 0x1808
// Size: 0x5c
function function_b6aa7b29(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_bb70f55a(localclientnum, newval, 2);
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0xbadf53eb, Offset: 0x1870
// Size: 0x5c
function function_90a800c0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_bb70f55a(localclientnum, newval, 3);
}

// Namespace namespace_f153ce01
// Params 3, eflags: 0x0
// Checksum 0xad58c89c, Offset: 0x18d8
// Size: 0xaee
function function_bb70f55a(localclientnum, newval, var_549b41ba) {
    function_244d3483(localclientnum);
    level.var_530ae70[localclientnum] util::waittill_dobj(localclientnum);
    switch (newval) {
    case 0:
        if (isdefined(level.var_9431a5ac) && isdefined(level.var_9431a5ac[var_549b41ba])) {
            stopfx(localclientnum, level.var_9431a5ac[var_549b41ba]);
        }
        if (isdefined(level.var_1da8ae2)) {
            stopfx(localclientnum, level.var_1da8ae2);
        }
        level.var_530ae70[localclientnum] hide();
        if (isdefined(level.var_57b86889) && isdefined(level.var_57b86889[var_549b41ba])) {
            stopfx(localclientnum, level.var_57b86889[var_549b41ba]);
        }
        var_e764f9dc = struct::get("clientside_flame_" + var_549b41ba, "targetname");
        audio::stoploopat("zmb_finalfight_key_holder_lp", var_e764f9dc.origin);
        audio::stoploopat("zmb_finalfight_key_charging_lp", var_e764f9dc.origin);
        break;
    case 1:
        if (isdefined(level.var_9431a5ac) && isdefined(level.var_9431a5ac[var_549b41ba])) {
            stopfx(localclientnum, level.var_9431a5ac[var_549b41ba]);
        }
        if (isdefined(level.var_1da8ae2)) {
            stopfx(localclientnum, level.var_1da8ae2);
        }
        level.var_530ae70[localclientnum] hide();
        if (isdefined(level.var_57b86889) && isdefined(level.var_57b86889[var_549b41ba])) {
            stopfx(localclientnum, level.var_57b86889[var_549b41ba]);
        }
        if (!isdefined(level.var_57b86889)) {
            level.var_57b86889 = array(undefined, undefined, undefined, undefined);
        }
        if (isdefined(level.var_57b86889[var_549b41ba])) {
            stopfx(localclientnum, level.var_57b86889[var_549b41ba]);
        }
        var_e764f9dc = struct::get("clientside_flame_" + var_549b41ba, "targetname");
        level.var_57b86889[var_549b41ba] = playfx(localclientnum, level._effect["gateworm_basin_ready"], var_e764f9dc.origin, (90, 0, 0));
        audio::playloopat("zmb_finalfight_key_holder_lp", var_e764f9dc.origin);
        audio::stoploopat("zmb_finalfight_key_charging_lp", var_e764f9dc.origin);
        break;
    case 2:
        if (isdefined(level.var_9431a5ac) && isdefined(level.var_9431a5ac[var_549b41ba])) {
            stopfx(localclientnum, level.var_9431a5ac[var_549b41ba]);
        }
        s_loc = struct::get("clientside_key_" + var_549b41ba, "targetname");
        level.var_530ae70[localclientnum].origin = s_loc.origin;
        level.var_530ae70[localclientnum] thread animation::play("p7_fxanim_zm_zod_summoning_key_idle_anim");
        if (!isdefined(level.var_1da8ae2)) {
            level.var_1da8ae2 = playfxontag(localclientnum, level._effect["summoning_key_glow"], level.var_530ae70[localclientnum], "key_root_jnt");
        }
        level.var_530ae70[localclientnum] show();
        level.var_530ae70[localclientnum] playsound(0, "zmb_finalfight_key_place");
        if (!isdefined(level.var_57b86889)) {
            level.var_57b86889 = array(undefined, undefined, undefined, undefined);
        }
        if (isdefined(level.var_57b86889[var_549b41ba])) {
            stopfx(localclientnum, level.var_57b86889[var_549b41ba]);
        }
        var_e764f9dc = struct::get("clientside_flame_" + var_549b41ba, "targetname");
        level.var_57b86889[var_549b41ba] = playfx(localclientnum, level._effect["gateworm_basin_start"], var_e764f9dc.origin, (90, 0, 0));
        audio::stoploopat("zmb_finalfight_key_holder_lp", var_e764f9dc.origin);
        audio::playloopat("zmb_finalfight_key_charging_lp", var_e764f9dc.origin);
        break;
    case 3:
        if (isdefined(level.var_9431a5ac) && isdefined(level.var_9431a5ac[var_549b41ba])) {
            stopfx(localclientnum, level.var_9431a5ac[var_549b41ba]);
        }
        s_loc = struct::get("clientside_key_" + var_549b41ba, "targetname");
        level.var_530ae70[localclientnum].origin = s_loc.origin;
        level.var_530ae70[localclientnum] thread animation::play("p7_fxanim_zm_zod_summoning_key_idle_anim");
        if (!isdefined(level.var_1da8ae2)) {
            level.var_1da8ae2 = playfxontag(localclientnum, level._effect["summoning_key_glow"], level.var_530ae70[localclientnum], "key_root_jnt");
        }
        level.var_530ae70[localclientnum] show();
        level.var_530ae70[localclientnum] playsound(0, "zmb_finalfight_key_ready");
        if (!isdefined(level.var_57b86889)) {
            level.var_57b86889 = array(undefined, undefined, undefined, undefined);
        }
        if (isdefined(level.var_57b86889[var_549b41ba])) {
            stopfx(localclientnum, level.var_57b86889[var_549b41ba]);
        }
        var_e764f9dc = struct::get("clientside_flame_" + var_549b41ba, "targetname");
        level.var_57b86889[var_549b41ba] = playfx(localclientnum, level._effect["gateworm_basin_charging"], var_e764f9dc.origin, (90, 0, 0));
        audio::playloopat("zmb_finalfight_key_holder_lp", var_e764f9dc.origin);
        audio::stoploopat("zmb_finalfight_key_charging_lp", var_e764f9dc.origin);
        break;
    case 4:
        if (isdefined(level.var_1da8ae2)) {
            stopfx(localclientnum, level.var_1da8ae2);
        }
        if (!isdefined(level.var_9431a5ac)) {
            level.var_9431a5ac = array(undefined, undefined, undefined, undefined);
        }
        if (!isdefined(level.var_9431a5ac[var_549b41ba])) {
            var_e764f9dc = struct::get("clientside_flame_" + var_549b41ba, "targetname");
            level.var_9431a5ac[var_549b41ba] = playfx(localclientnum, level._effect["curse_tell"], var_e764f9dc.origin, (90, 0, 0));
        }
        if (isdefined(level.var_57b86889) && isdefined(level.var_57b86889[var_549b41ba])) {
            stopfx(localclientnum, level.var_57b86889[var_549b41ba]);
        }
        var_e764f9dc = struct::get("clientside_flame_" + var_549b41ba, "targetname");
        audio::stoploopat("zmb_finalfight_key_holder_lp", var_e764f9dc.origin);
        audio::stoploopat("zmb_finalfight_key_charging_lp", var_e764f9dc.origin);
        level.var_530ae70[localclientnum] hide();
        break;
    }
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0xaf37010c, Offset: 0x23d0
// Size: 0x116
function function_4c31bb81(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
            setlitfogbank(localclientnum, -1, 1, -1);
            setworldfogactivebank(localclientnum, 2);
        }
    }
    if (newval == 2) {
        for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
            setlitfogbank(localclientnum, -1, 0, -1);
            setworldfogactivebank(localclientnum, 1);
        }
    }
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0x93a36279, Offset: 0x24f0
// Size: 0xb4
function function_fa762da4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_63082da9 = playfx(localclientnum, level._effect["summoning_circle_fx"], self.origin, self.angles);
        return;
    }
    if (isdefined(self.var_63082da9)) {
        stopfx(localclientnum, self.var_63082da9);
    }
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0x40e29b38, Offset: 0x25b0
// Size: 0x466
function function_cdca4773(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level notify(#"hash_cdca4773");
    level endon(#"hash_cdca4773");
    function_244d3483(localclientnum);
    level.var_530ae70[localclientnum] util::waittill_dobj(localclientnum);
    var_1f5092c = struct::get("arena_reward_pickup", "targetname");
    switch (newval) {
    case 0:
        level.var_530ae70[localclientnum] hide();
        if (isdefined(level.var_530ae70[localclientnum].fxid)) {
            stopfx(localclientnum, level.var_530ae70[localclientnum].fxid);
            level.var_530ae70[localclientnum].fxid = undefined;
        }
        if (isdefined(level.var_530ae70[localclientnum].var_e377eac9)) {
            stopfx(localclientnum, level.var_530ae70[localclientnum].var_e377eac9);
            level.var_530ae70[localclientnum].var_e377eac9 = undefined;
        }
        break;
    case 1:
        level.var_530ae70[localclientnum].origin = var_1f5092c.origin + (0, 0, 196);
        level.var_530ae70[localclientnum] show();
        if (!isdefined(level.var_530ae70[localclientnum].fxid)) {
            level.var_530ae70[localclientnum].fxid = playfxontag(localclientnum, level._effect["summoning_key_glow"], level.var_530ae70[localclientnum], "key_root_jnt");
        }
        if (!isdefined(level.var_530ae70[localclientnum].var_e377eac9)) {
            level.var_530ae70[localclientnum].var_e377eac9 = playfxontag(localclientnum, level._effect["summoning_key_holder"], level.var_530ae70[localclientnum], "key_root_jnt");
        }
        break;
    case 2:
        level.var_530ae70[localclientnum].origin = var_1f5092c.origin + (0, 0, 196);
        level.var_530ae70[localclientnum] show();
        level.var_530ae70[localclientnum] moveto(var_1f5092c.origin, 3);
        if (!isdefined(level.var_530ae70[localclientnum].fxid)) {
            level.var_530ae70[localclientnum].fxid = playfxontag(localclientnum, level._effect["summoning_key_glow"], level.var_530ae70[localclientnum], "key_root_jnt");
        }
        if (isdefined(level.var_530ae70[localclientnum].var_e377eac9)) {
            stopfx(localclientnum, level.var_530ae70[localclientnum].var_e377eac9);
            level.var_530ae70[localclientnum].var_e377eac9 = undefined;
        }
        break;
    }
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0x372afd03, Offset: 0x2a20
// Size: 0xca
function function_6d54bbfc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level notify(#"hash_6d54bbfc");
    level endon(#"hash_6d54bbfc");
    if (!isdefined(level.var_b175da10)) {
        function_8fbd23f4(localclientnum);
    }
    switch (newval) {
    case 0:
        break;
    case 1:
        break;
    case 2:
        break;
    case 3:
        break;
    case 4:
        break;
    }
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0x93cccae4, Offset: 0x2af8
// Size: 0x20e
function function_82eec527(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level notify(#"hash_82eec527");
    level endon(#"hash_82eec527");
    n_challenge_index = clientfield::get("circle_challenge_identity");
    switch (newval) {
    case 0:
        if (n_challenge_index == 0) {
            level thread function_e6fd161a(localclientnum, 0);
            level thread function_df81c23d(localclientnum, 0);
        }
        break;
    case 1:
        if (n_challenge_index == 0) {
            level thread function_e6fd161a(localclientnum, 0);
            level thread function_df81c23d(localclientnum, 0);
        }
        break;
    case 2:
        break;
    case 3:
        if (n_challenge_index == 0) {
            level thread function_e6fd161a(localclientnum, 1);
            level thread function_df81c23d(localclientnum, 1);
        }
        break;
    case 4:
        if (n_challenge_index == 0) {
            level thread function_e6fd161a(localclientnum, 0);
            level thread function_df81c23d(localclientnum, 0);
        }
        break;
    case 5:
        if (n_challenge_index == 0) {
            level thread function_e6fd161a(localclientnum, 0);
            level thread function_df81c23d(localclientnum, 0);
        }
        break;
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x0
// Checksum 0x60312c7d, Offset: 0x2d10
// Size: 0x24
function function_8fbd23f4(localclientnum) {
    level.var_b175da10 = spawnstruct();
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x0
// Checksum 0xd53e48e7, Offset: 0x2d40
// Size: 0x19c
function function_244d3483(localclientnum) {
    if (!isdefined(level.var_530ae70)) {
        level.var_530ae70 = [];
    }
    if (!isdefined(level.var_530ae70[localclientnum])) {
        s_summoning_key = struct::get("summoning_key", "targetname");
        level.var_530ae70[localclientnum] = spawn(localclientnum, s_summoning_key.origin, "script_model");
        level.var_530ae70[localclientnum] setmodel("p7_fxanim_zm_zod_summoning_key_mod");
        level.var_530ae70[localclientnum] useanimtree(#generic);
        level.var_530ae70[localclientnum] hide();
        var_3b86bdff = struct::get("dark_arena_podium", "targetname");
        v_fwd = anglestoforward(var_3b86bdff.angles);
        playfx(localclientnum, level._effect["dark_arena_podium"], var_3b86bdff.origin, v_fwd);
    }
}

// Namespace namespace_f153ce01
// Params 3, eflags: 0x0
// Checksum 0x554d3560, Offset: 0x2ee8
// Size: 0xb0
function function_a8a110ed(localclientnum, s_location, v_angle_offset) {
    if (!isdefined(v_angle_offset)) {
        v_angle_offset = (0, 0, 0);
    }
    var_244bacb5 = spawn(localclientnum, s_location.origin, "script_model");
    var_244bacb5.angles = s_location.angles + v_angle_offset;
    var_244bacb5 setmodel(s_location.model);
    return var_244bacb5;
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x0
// Checksum 0x33419f08, Offset: 0x2fa0
// Size: 0x94
function function_3d5c3a74(var_9494ad2f) {
    s_summoning_key = struct::get("summoning_key", "targetname");
    v_offset = (0, 0, 512);
    if (!var_9494ad2f) {
        v_offset = (0, 0, 0);
    }
    self moveto(s_summoning_key.origin + v_offset, 3);
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x0
// Checksum 0xa4d77e9c, Offset: 0x3040
// Size: 0x11e
function function_17ef53cd() {
    self notify(#"hash_17ef53cd");
    self endon(#"hash_17ef53cd");
    v_origin = self.v_origin;
    n_duration = randomfloatrange(4.75, 5);
    while (true) {
        self.mdl_light moveto(v_origin + (0, 0, 4), n_duration);
        self.var_4100f709 moveto(v_origin + (0, 0, 4), n_duration);
        wait(n_duration);
        self.mdl_light moveto(v_origin, n_duration);
        self.var_4100f709 moveto(v_origin, n_duration);
        wait(n_duration);
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x0
// Checksum 0xbb058083, Offset: 0x3168
// Size: 0x56
function function_5ce8eb7d(n_height) {
    for (i = 0; i < 5; i++) {
        level.var_8962a8a0[i] thread function_fad1f25a(n_height);
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x0
// Checksum 0x1b08a6a4, Offset: 0x31c8
// Size: 0x1de
function function_fad1f25a(n_height) {
    self notify(#"hash_17ef53cd");
    switch (n_height) {
    case 0:
        n_duration = randomfloatrange(1.75, 2);
        self.mdl_light moveto(self.v_origin + (0, 0, -128), n_duration);
        self.var_4100f709 moveto(self.v_origin + (0, 0, -128), n_duration);
        break;
    case 1:
        n_duration = randomfloatrange(1.75, 2);
        self.mdl_light moveto(self.v_origin, n_duration);
        self.var_4100f709 moveto(self.v_origin, n_duration);
        break;
    case 2:
        n_duration = randomfloatrange(1.75, 2);
        self.mdl_light moveto(self.v_origin + (0, 0, 128), n_duration);
        self.var_4100f709 moveto(self.v_origin + (0, 0, 128), n_duration);
        break;
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x0
// Checksum 0x7327a660, Offset: 0x33b0
// Size: 0x4e
function function_99a05235(b_on) {
    for (i = 0; i < 5; i++) {
        function_7277f824(i, b_on);
    }
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x0
// Checksum 0xcb4859e1, Offset: 0x3408
// Size: 0xc4
function function_7277f824(n_index, b_on) {
    if (b_on) {
        level.var_8962a8a0[n_index].mdl_light show();
        level.var_8962a8a0[n_index].var_4100f709 hide();
        return;
    }
    level.var_8962a8a0[n_index].mdl_light hide();
    level.var_8962a8a0[n_index].var_4100f709 show();
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x0
// Checksum 0xd8e85edc, Offset: 0x34d8
// Size: 0x32e
function function_3de943fb(state, e_model) {
    level notify(#"hash_3de943fb");
    level endon(#"hash_3de943fb");
    switch (state) {
    case 0:
        e_model playsound(0, "evt_zod_ritual_reset");
        if (isdefined(e_model.sndent)) {
            e_model.sndent delete();
            e_model.sndent = undefined;
        }
        break;
    case 1:
        e_model playsound(0, "evt_zod_ritual_ready");
        if (!isdefined(e_model.sndent)) {
            e_model.sndent = spawn(0, e_model.origin, "script_origin");
            e_model.sndent linkto(e_model, "tag_origin");
        }
        e_model.sndent playloopsound("evt_zod_ritual_ready_loop", 2);
        break;
    case 2:
        e_model playsound(0, "evt_zod_ritual_started");
        if (!isdefined(e_model.sndent)) {
            e_model.sndent = spawn(0, e_model.origin, "script_origin");
            e_model.sndent linkto(e_model, "tag_origin");
        }
        looper = e_model.sndent playloopsound("evt_zod_ritual_started_loop", 2);
        for (pitch = 0.5; true; pitch += 0.05) {
            setsoundpitch(looper, pitch);
            setsoundpitchrate(looper, 0.1);
            wait(1);
        }
        break;
    case 4:
        e_model playsound(0, "evt_zod_ritual_finished");
        if (isdefined(e_model.sndent)) {
            e_model.sndent delete();
            e_model.sndent = undefined;
        }
        break;
    }
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x0
// Checksum 0x276aa2ea, Offset: 0x3810
// Size: 0x4ce
function function_2bcc6bd2(state, e_model) {
    level notify(#"hash_2bcc6bd2");
    level endon(#"hash_2bcc6bd2");
    switch (state) {
    case 0:
        e_model playsound(0, "evt_zod_ritual_reset");
        if (isdefined(e_model.sndent)) {
            e_model.sndent delete();
            e_model.sndent = undefined;
        }
        break;
    case 1:
        e_model playsound(0, "evt_zod_ritual_ready");
        if (!isdefined(e_model.sndent)) {
            e_model.sndent = spawn(0, e_model.origin, "script_origin");
            e_model.sndent linkto(e_model, "tag_origin");
        }
        e_model.sndent playloopsound("evt_zod_ritual_ready_loop", 2);
        break;
    case 2:
        e_model playsound(0, "evt_zod_ritual_started");
        if (!isdefined(e_model.sndent)) {
            e_model.sndent = spawn(0, e_model.origin, "script_origin");
            e_model.sndent linkto(e_model, "tag_origin");
        }
        looper = e_model.sndent playloopsound("evt_zod_ritual_started_loop", 2);
        for (pitch = 0.5; true; pitch += 0.05) {
            setsoundpitch(looper, pitch);
            setsoundpitchrate(looper, 0.1);
            wait(1);
        }
        break;
    case 3:
        e_model playsound(0, "evt_zod_ritual_started");
        if (!isdefined(e_model.sndent)) {
            e_model.sndent = spawn(0, e_model.origin, "script_origin");
            e_model.sndent linkto(e_model, "tag_origin");
        }
        looper = e_model.sndent playloopsound("evt_zod_ritual_started_loop", 2);
        for (pitch = 0.5; true; pitch += 0.05) {
            setsoundpitch(looper, pitch);
            setsoundpitchrate(looper, 0.1);
            wait(1);
        }
        break;
    case 4:
        e_model playsound(0, "evt_zod_ritual_finished");
        if (isdefined(e_model.sndent)) {
            e_model.sndent delete();
            e_model.sndent = undefined;
        }
        break;
    case 5:
        e_model playsound(0, "evt_zod_ritual_finished");
        if (isdefined(e_model.sndent)) {
            e_model.sndent delete();
            e_model.sndent = undefined;
        }
        break;
    }
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0x64f401c8, Offset: 0x3ce8
// Size: 0x1ce
function function_b9c422c3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_a42274ee = struct::get_array("challenge_fire_struct", "targetname");
    foreach (var_d2c81bd9 in var_a42274ee) {
        if (var_d2c81bd9.script_int == self getentitynumber()) {
            if (!isdefined(var_d2c81bd9.var_90369c89[localclientnum])) {
                var_d2c81bd9.var_90369c89[localclientnum] = playfx(localclientnum, level._effect["random_weapon_powerup_marker"], var_d2c81bd9.origin + (0, 0, -8));
            }
            continue;
        }
        if (isdefined(var_d2c81bd9.var_90369c89[localclientnum])) {
            deletefx(localclientnum, var_d2c81bd9.var_90369c89[localclientnum]);
            var_d2c81bd9.var_90369c89[localclientnum] = undefined;
        }
    }
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0x469db4b7, Offset: 0x3ec0
// Size: 0x54
function function_9fdd5be3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.var_12c4e9d2 = level._effect["arena_margwa_spawn"];
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0xc8265b11, Offset: 0x3f20
// Size: 0x7c
function function_25564e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self thread postfx::playpostfxbundle("pstfx_shock_charge");
        return;
    }
    self thread postfx::exitpostfxbundle();
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0x893202b, Offset: 0x3fa8
// Size: 0x7c
function function_cca0826e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self thread postfx::playpostfxbundle("pstfx_gen_chal_shadow");
        return;
    }
    self thread postfx::exitpostfxbundle();
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0x46dc7963, Offset: 0x4030
// Size: 0x7c
function function_2a4ba289(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self thread postfx::playpostfxbundle("pstfx_burn_loop");
        return;
    }
    self thread postfx::exitpostfxbundle();
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0x91814dc1, Offset: 0x40b8
// Size: 0xbe
function function_12d2195a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_7dec59b4 = playfx(localclientnum, level._effect["fire_column"], self.origin + (0, 0, -90), (0, -1, 0));
        return;
    }
    stopfx(localclientnum, self.var_7dec59b4);
    self.var_7dec59b4 = undefined;
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x0
// Checksum 0xbb9d48bb, Offset: 0x4180
// Size: 0xd4
function function_e6fd161a(localclientnum, newval) {
    if (newval == 1) {
        if (isdefined(level.var_51541120[localclientnum])) {
            deletefx(localclientnum, level.var_51541120[localclientnum], 1);
        }
        level.var_51541120[localclientnum] = playfxoncamera(localclientnum, level._effect["low_grav_screen_fx"]);
        return;
    }
    if (isdefined(level.var_51541120[localclientnum])) {
        deletefx(localclientnum, level.var_51541120[localclientnum], 1);
    }
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x0
// Checksum 0xc65774aa, Offset: 0x4260
// Size: 0xa4
function function_df81c23d(localclientnum, newval) {
    if (newval == 1) {
        setpbgactivebank(localclientnum, 2);
        level.localplayers[0] thread postfx::playpostfxbundle("pstfx_115_castle_loop");
        return;
    }
    setpbgactivebank(localclientnum, 1);
    level.localplayers[0] thread postfx::exitpostfxbundle();
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0x18559008, Offset: 0x4310
// Size: 0xe4
function function_4906c6c6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        var_377bdd93 = struct::get("arena_light_challenge_floor", "targetname");
        level.var_be73cf11 = util::spawn_model(localclientnum, var_377bdd93.model, var_377bdd93.origin, var_377bdd93.angles);
        return;
    }
    if (isdefined(level.var_be73cf11)) {
        level.var_be73cf11 delete();
    }
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0x2c40c50c, Offset: 0x4400
// Size: 0xac
function function_646dab34(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_247afb5a = playfxontag(localclientnum, level._effect["arena_tornado"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_247afb5a)) {
        stopfx(localclientnum, self.var_247afb5a);
    }
}

// Namespace namespace_f153ce01
// Params 7, eflags: 0x0
// Checksum 0x1a0a0ec1, Offset: 0x44b8
// Size: 0xac
function function_1a0568f8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_e29992ef = playfxontag(localclientnum, level._effect["arena_shadow_pillar"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_e29992ef)) {
        stopfx(localclientnum, self.var_e29992ef);
    }
}

