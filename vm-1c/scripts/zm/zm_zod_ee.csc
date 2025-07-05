#using scripts/codescripts/struct;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/beam_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/zm_zod;
#using scripts/zm/zm_zod_quest;

#using_animtree("generic");

#namespace zm_zod_ee;

// Namespace zm_zod_ee
// Method(s) 8 Total 8
class class_b454dc63 {

    // Namespace namespace_b454dc63
    // Params 2, eflags: 0x0
    // Checksum 0x79c68e9, Offset: 0x5920
    // Size: 0x12c
    function function_66844d0d(localclientnum, b_active) {
        self.var_3b3701c9 = b_active;
        if (!self.var_3b3701c9) {
            self.var_dbea7369 stoploopsound(3);
            return;
        }
        if (!self.var_8d207f9b) {
            self.var_a9547cdf = "p7_fxanim_zm_zod_apothicons_god_loop_anim";
            self.var_dbea7369 setanim("p7_fxanim_zm_zod_apothicons_god_loop_anim", 1, 0, 1);
            self.var_dbea7369 playsound(localclientnum, "zmb_zod_apothigod_vox_spawn");
            return;
        }
        level notify(#"hash_465ed3ec");
        self.var_a9547cdf = "p7_fxanim_zm_zod_apothicons_god_body_idle_anim";
        self.var_dbea7369 setanim(self.var_a9547cdf, 1, 0, 1);
        self.var_dbea7369 playloopsound("zmb_zod_apothigod_vox_lookat_lp", 12);
    }

    // Namespace namespace_b454dc63
    // Params 2, eflags: 0x0
    // Checksum 0x309f06b9, Offset: 0x5860
    // Size: 0xb2
    function function_839ff35f(localclientnum, var_7c8ba0d5) {
        if (!isdefined(var_7c8ba0d5)) {
            return;
        }
        self.var_dbea7369 util::waittill_dobj(localclientnum);
        var_7c8ba0d5 setanim("p7_fxanim_zm_zod_apothicons_god_mouth_death_anim", 1, 0, 1);
        var_32613e03 = getanimlength("p7_fxanim_zm_zod_apothicons_god_body_death_anim");
        var_7c8ba0d5 setanim("p7_fxanim_zm_zod_apothicons_god_body_death_anim", 1, 0, 1);
        wait var_32613e03;
    }

    // Namespace namespace_b454dc63
    // Params 2, eflags: 0x0
    // Checksum 0x641658df, Offset: 0x5750
    // Size: 0x104
    function function_2de612ff(localclientnum, var_7c8ba0d5) {
        if (!isdefined(var_7c8ba0d5)) {
            return;
        }
        self.var_dbea7369 util::waittill_dobj(localclientnum);
        var_7c8ba0d5 setanim(self.var_a9547cdf, 1, 0, 1);
        var_32613e03 = getanimlength("p7_fxanim_zm_zod_apothicons_god_mouth_roar_anim");
        var_7c8ba0d5 setanim("p7_fxanim_zm_zod_apothicons_god_mouth_roar_anim", 1, 0, 1);
        wait var_32613e03;
        var_7c8ba0d5 setanim("p7_fxanim_zm_zod_apothicons_god_mouth_idle_anim", 1, 0, 1);
        var_7c8ba0d5 setanim(self.var_a9547cdf, 1, 0, 1);
    }

    // Namespace namespace_b454dc63
    // Params 2, eflags: 0x0
    // Checksum 0x2f609b58, Offset: 0x56c0
    // Size: 0x82
    function function_465ed3ec(localclientnum, var_7c8ba0d5) {
        level notify(#"hash_465ed3ec");
        level endon(#"hash_465ed3ec");
        while (true) {
            self thread function_2de612ff(localclientnum, var_7c8ba0d5);
            var_7397ca31 = randomintrange(15, 60);
            wait var_7397ca31;
        }
    }

    // Namespace namespace_b454dc63
    // Params 0, eflags: 0x0
    // Checksum 0x3f7c6a0f, Offset: 0x56a8
    // Size: 0xa
    function function_9e0e6936() {
        return self.var_8d207f9b;
    }

    // Namespace namespace_b454dc63
    // Params 3, eflags: 0x0
    // Checksum 0x8c5e4990, Offset: 0x5600
    // Size: 0x9c
    function init(localclientnum, var_7c8ba0d5, var_bae1bdd7) {
        self.var_dbea7369 = var_7c8ba0d5;
        self.var_8d207f9b = var_bae1bdd7;
        self.var_dbea7369 util::waittill_dobj(localclientnum);
        self.var_dbea7369 useanimtree(#generic);
        self.var_dbea7369 setanim("p7_fxanim_zm_zod_apothicons_god_mouth_idle_anim", 1, 0, 1);
    }

}

// Namespace zm_zod_ee
// Params 0, eflags: 0x2
// Checksum 0x1604008a, Offset: 0x1168
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_zod_ee", &__init__, undefined, undefined);
}

// Namespace zm_zod_ee
// Params 0, eflags: 0x0
// Checksum 0x46556135, Offset: 0x11a8
// Size: 0x6d4
function __init__() {
    level._effect["player_cleanse"] = "zombie/fx_ee_player_cleanse_zod_zmb";
    level._effect["ee_quest_keeper_spirit_mist"] = "zombie/fx_ee_altar_mist_zod_zmb";
    level._effect["ee_quest_powerbox"] = "zombie/fx_bmode_dest_pwrbox_zod_zmb";
    level._effect["ee_superworm_death"] = "zombie/fx_ee_gateworm_lg_death_zod_zmb";
    level._effect["zombie/fx_ee_gateworm_lg_teleport_zod_zmb"] = "zombie/fx_ee_gateworm_lg_teleport_zod_zmb";
    level._effect["fx_ee_apothigod_beam_impact_zod_zmb"] = "fx_ee_apothigod_beam_impact_zod_zmb";
    level._effect["ee_totem_to_ghost"] = "zombie/fx_totem_beam_zod_zmb";
    level._effect["ee_ghost_charging"] = "zombie/fx_ee_ghost_charging_zod_zmb";
    level._effect["ee_ghost_charged"] = "zombie/fx_ee_ghost_full_charge_zod_zmb";
    level._effect["ee_quest_book_mist"] = "zombie/fx_ee_book_mist_zod_zmb";
    level._effect["zombie/fx_ee_keeper_beam_shield1_fail_zod_zmb"] = "zombie/fx_ee_keeper_beam_shield1_fail_zod_zmb";
    level._effect["zombie/fx_ee_keeper_beam_shield2_fail_zod_zmb"] = "zombie/fx_ee_keeper_beam_shield2_fail_zod_zmb";
    n_bits = getminbitcountfornum(5);
    clientfield::register("world", "ee_quest_state", 1, n_bits, "int", &function_f2a0dbdc, 0, 0);
    n_bits = getminbitcountfornum(6);
    clientfield::register("world", "ee_totem_state", 1, n_bits, "int", undefined, 0, 0);
    n_bits = getminbitcountfornum(10);
    clientfield::register("world", "ee_keeper_boxer_state", 1, n_bits, "int", &ee_keeper_boxer_state, 0, 0);
    clientfield::register("world", "ee_keeper_detective_state", 1, n_bits, "int", &ee_keeper_detective_state, 0, 0);
    clientfield::register("world", "ee_keeper_femme_state", 1, n_bits, "int", &ee_keeper_femme_state, 0, 0);
    clientfield::register("world", "ee_keeper_magician_state", 1, n_bits, "int", &ee_keeper_magician_state, 0, 0);
    clientfield::register("world", "ee_shadowman_battle_active", 1, 1, "int", &ee_shadowman_battle_active, 0, 0);
    n_bits = getminbitcountfornum(5);
    clientfield::register("world", "ee_superworm_state", 1, n_bits, "int", &ee_superworm_state, 0, 0);
    clientfield::register("scriptmover", "near_apothigod_active", 1, 1, "int", &near_apothigod_active, 0, 0);
    clientfield::register("scriptmover", "far_apothigod_active", 1, 1, "int", &far_apothigod_active, 0, 0);
    clientfield::register("scriptmover", "near_apothigod_roar", 1, 1, "counter", &near_apothigod_active, 0, 0);
    clientfield::register("scriptmover", "far_apothigod_roar", 1, 1, "counter", &far_apothigod_active, 0, 0);
    clientfield::register("scriptmover", "apothigod_death", 1, 1, "counter", &apothigod_death, 0, 0);
    n_bits = getminbitcountfornum(3);
    clientfield::register("world", "ee_keeper_beam_state", 1, n_bits, "int", &ee_keeper_beam_state, 0, 0);
    clientfield::register("world", "ee_final_boss_shields", 1, 1, "int", &ee_final_boss_shields, 0, 0);
    clientfield::register("toplayer", "ee_final_boss_attack_tell", 1, 1, "int", &ee_final_boss_attack_tell, 0, 0);
    clientfield::register("scriptmover", "ee_rail_electricity_state", 1, 1, "int", &ee_rail_electricity_state, 0, 0);
    clientfield::register("world", "sndEndIGC", 1, 1, "int", &sndEndIGC, 0, 0);
}

// Namespace zm_zod_ee
// Params 7, eflags: 0x0
// Checksum 0x6c2c3db1, Offset: 0x1888
// Size: 0x7c
function sndEndIGC(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        audio::snd_set_snapshot("zmb_zod_endigc");
        return;
    }
    audio::snd_set_snapshot("default");
}

// Namespace zm_zod_ee
// Params 7, eflags: 0x0
// Checksum 0xcbc2c4f5, Offset: 0x1910
// Size: 0xe4
function ee_shadowman_battle_active(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        s_loc = struct::get("defend_area_pap", "targetname");
        level.var_65b446c1 = playfx(localclientnum, level._effect["portal_shortcut_closed_base"], s_loc.origin, (0, 0, 0));
        return;
    }
    if (isdefined(level.var_65b446c1)) {
        stopfx(localclientnum, level.var_65b446c1);
    }
}

// Namespace zm_zod_ee
// Params 7, eflags: 0x0
// Checksum 0x36c60824, Offset: 0x1a00
// Size: 0x76c
function function_f2a0dbdc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval !== 3 && newval !== 2) {
        return;
    }
    if (newval == 4) {
        return;
    }
    function_373d3423(localclientnum);
    var_5283b18c = level.main_quest[localclientnum]["pap"].var_cc38f8bd;
    var_5283b18c util::waittill_dobj(localclientnum);
    if (!var_5283b18c hasanimtree()) {
        var_5283b18c useanimtree(#generic);
    }
    var_f1148651 = level.main_quest[localclientnum]["pap"].e_victim;
    if (!var_f1148651 hasanimtree()) {
        var_f1148651 useanimtree(#generic);
    }
    var_5283b18c show();
    var_f1148651 show();
    for (i = 0; i < 4; i++) {
        var_5283b18c.var_476820c9[i] = playfxontag(localclientnum, level._effect["ritual_trail"], var_5283b18c, "key_pcs0" + i + 1 + "_jnt");
    }
    level thread zm_zod_quest::function_f7d8d98b(2, var_5283b18c);
    level thread exploder::exploder("ritual_light_pap");
    playsound(0, "zmb_zod_shadfight_ending", (0, 0, 0));
    zm_zod_quest::function_fdbf1ed5(localclientnum, "pap", 1);
    var_f1148651 thread animation::play("ai_zombie_zod_shadowman_captured_intro");
    var_5283b18c animation::play("p7_fxanim_zm_zod_redemption_key_ritual_start_anim");
    var_f1148651 clearanim("ai_zombie_zod_shadowman_captured_intro", 0);
    var_f1148651 thread animation::play("ai_zombie_zod_shadowman_captured_loop");
    var_5283b18c clearanim("p7_fxanim_zm_zod_redemption_key_ritual_start_anim", 0);
    var_5283b18c thread animation::play("p7_fxanim_zm_zod_redemption_key_ritual_loop_anim");
    wait 1.5;
    var_f1148651 playsound(0, "zmb_shadowman_die");
    var_f1148651 clearanim("ai_zombie_zod_shadowman_captured_loop", 0);
    var_f1148651 thread animation::play("ai_zombie_zod_shadowman_captured_outro");
    var_5283b18c clearanim("p7_fxanim_zm_zod_redemption_key_ritual_loop_anim", 0);
    var_5283b18c thread animation::play("p7_fxanim_zm_zod_redemption_key_ritual_loop_fast_anim");
    wait 1.5;
    var_f1148651 = level.main_quest[localclientnum]["pap"].e_victim;
    var_f1148651.var_d981f405 = playfxontag(localclientnum, level._effect["ritual_glow_chest"], var_f1148651, "j_spineupper");
    var_f1148651.var_cde8f060 = playfxontag(localclientnum, level._effect["ritual_glow_head"], var_f1148651, "tag_eye");
    var_5283b18c clearanim("p7_fxanim_zm_zod_redemption_key_ritual_loop_fast_anim", 0);
    if (isdefined(var_5283b18c.var_476820c9)) {
        foreach (var_2d3cc156 in var_5283b18c.var_476820c9) {
            stopfx(localclientnum, var_2d3cc156);
        }
    }
    level thread zm_zod_quest::function_dd358b4e(localclientnum, var_5283b18c, undefined, var_f1148651, "pap");
    if (newval == 3) {
        level thread function_cf8ff04b(localclientnum);
    } else if (newval == 2) {
        for (i = 1; i <= 4; i++) {
            var_4fafa709 = function_e1e53e16(localclientnum, i);
            var_4fafa709.model util::waittill_dobj(localclientnum);
            v_fwd = anglestoforward(var_4fafa709.model.angles);
            level thread function_705b696b(localclientnum, level._effect["keeper_spawn"], var_4fafa709.model.origin, v_fwd, 2);
            var_4fafa709.model hide();
        }
    }
    var_5283b18c animation::play("p7_fxanim_zm_zod_redemption_key_ritual_end_anim");
    var_5283b18c hide();
    s_loc = struct::get("defend_area_pap", "targetname");
    if (isdefined(s_loc.var_dda4503d)) {
        stopfx(localclientnum, s_loc.var_dda4503d);
    }
}

// Namespace zm_zod_ee
// Params 5, eflags: 0x0
// Checksum 0x6dd815a, Offset: 0x2178
// Size: 0x7c
function function_705b696b(localclientnum, str_fx, v_origin, v_fwd, n_seconds) {
    fx_id = playfx(localclientnum, str_fx, v_origin, v_fwd);
    wait n_seconds;
    stopfx(localclientnum, fx_id);
}

// Namespace zm_zod_ee
// Params 1, eflags: 0x0
// Checksum 0x30a76634, Offset: 0x2200
// Size: 0x44
function function_cf8ff04b(localclientnum) {
    flag::wait_till("set_ritual_finished_flag");
    ee_superworm_state(localclientnum, undefined, 1);
}

// Namespace zm_zod_ee
// Params 1, eflags: 0x0
// Checksum 0xa9c07a96, Offset: 0x2250
// Size: 0x2d4
function function_373d3423(localclientnum) {
    s_position = struct::get("defend_area_pap", "targetname");
    level.main_quest[localclientnum]["pap"] = s_position;
    level.main_quest[localclientnum]["pap"].var_cc38f8bd = spawn(localclientnum, s_position.origin, "script_model");
    level.main_quest[localclientnum]["pap"].var_cc38f8bd.angles = s_position.angles;
    level.main_quest[localclientnum]["pap"].var_cc38f8bd setmodel("p7_fxanim_zm_zod_redemption_key_ritual_mod");
    level.main_quest[localclientnum]["pap"].var_cc38f8bd.var_476820c9 = [];
    v_tag_origin = level.main_quest[localclientnum]["pap"].var_cc38f8bd gettagorigin("tag_char_jnt");
    v_tag_angles = level.main_quest[localclientnum]["pap"].var_cc38f8bd gettagangles("tag_char_jnt");
    level.main_quest[localclientnum]["pap"].e_victim = spawn(localclientnum, v_tag_origin, "script_model");
    level.main_quest[localclientnum]["pap"].e_victim setmodel("c_zom_zod_shadowman_tentacles_fb");
    var_dd690641 = struct::get("shadowman_death_loc", "targetname");
    level.main_quest[localclientnum]["pap"].e_victim.origin = var_dd690641.origin;
    level.main_quest[localclientnum]["pap"].e_victim.angles = v_tag_angles;
}

// Namespace zm_zod_ee
// Params 7, eflags: 0x0
// Checksum 0x6fddc0b1, Offset: 0x2530
// Size: 0x5c
function ee_keeper_boxer_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_a39c9866(localclientnum, newval, oldval, 1);
}

// Namespace zm_zod_ee
// Params 7, eflags: 0x0
// Checksum 0x1cef5d46, Offset: 0x2598
// Size: 0x5c
function ee_keeper_detective_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_a39c9866(localclientnum, newval, oldval, 2);
}

// Namespace zm_zod_ee
// Params 7, eflags: 0x0
// Checksum 0x1ced8764, Offset: 0x2600
// Size: 0x5c
function ee_keeper_femme_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_a39c9866(localclientnum, newval, oldval, 3);
}

// Namespace zm_zod_ee
// Params 7, eflags: 0x0
// Checksum 0xaa20489a, Offset: 0x2668
// Size: 0x5c
function ee_keeper_magician_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_a39c9866(localclientnum, newval, oldval, 4);
}

// Namespace zm_zod_ee
// Params 4, eflags: 0x0
// Checksum 0x5f243027, Offset: 0x26d0
// Size: 0x12b6
function function_a39c9866(localclientnum, var_fe2fb4b9, var_f471914b, n_character_index) {
    var_4fafa709 = function_e1e53e16(localclientnum, n_character_index);
    mdl_target = function_2c557738(localclientnum, n_character_index);
    function_4d0c8ca8(var_4fafa709, var_fe2fb4b9, n_character_index);
    var_4fafa709.model util::waittill_dobj(localclientnum);
    if (!var_4fafa709.model hasanimtree()) {
        var_4fafa709.model useanimtree(#generic);
    }
    if (isdefined(var_4fafa709.model.var_5ad6cc0c)) {
        var_4fafa709.model stoploopsound(var_4fafa709.model.var_5ad6cc0c, 2);
        var_4fafa709.model.var_5ad6cc0c = undefined;
    }
    switch (var_fe2fb4b9) {
    case 0:
        var_4fafa709.model hide();
        break;
    case 1:
        var_4fafa709.model show();
        var_4fafa709.model notify(#"hash_274ba0e6");
        var_4fafa709.model clearanim("ai_zombie_zod_keeper_give_egg_intro", 0);
        var_4fafa709.model clearanim("ai_zombie_zod_keeper_give_egg_loop", 0);
        var_4fafa709.var_c8ca4ded = playfx(localclientnum, level._effect["ee_quest_keeper_spirit_mist"], var_4fafa709.model.origin, var_4fafa709.model.angles);
        var_4fafa709.model.var_5ad6cc0c = var_4fafa709.model playloopsound("zmb_ee_keeper_ghost_appear_lp", 2);
        var_4fafa709.model playsound(0, "zmb_ee_keeper_ghost_appear");
        var_4fafa709.model animation::play("ai_zombie_zod_keeper_idle", undefined, undefined, 1);
        break;
    case 2:
        var_4fafa709.model notify(#"hash_274ba0e6");
        var_4fafa709.model clearanim("ai_zombie_zod_keeper_idle", 0);
        var_4fafa709.model clearanim("ai_zombie_zod_keeper_give_egg_intro", 0);
        var_4fafa709.model clearanim("ai_zombie_zod_keeper_give_egg_loop", 0);
        var_4fafa709.model.var_5ad6cc0c = var_4fafa709.model playloopsound("zmb_zod_totem_resurrecting_lp", 2);
        var_4fafa709.mdl_totem show();
        var_4fafa709.var_b0ff8d18 = playfxontag(localclientnum, level._effect["ee_totem_to_ghost"], var_4fafa709.mdl_totem, "j_head");
        var_4fafa709.var_a0b06f1c = playfxontag(localclientnum, level._effect["ee_ghost_charging"], var_4fafa709.model, "tag_origin");
        var_4fafa709.model animation::play("ai_zombie_zod_keeper_give_egg_outro", undefined, undefined, 1);
        break;
    case 3:
        if (isdefined(var_4fafa709.var_b0ff8d18)) {
            stopfx(localclientnum, var_4fafa709.var_b0ff8d18);
        }
        if (isdefined(var_4fafa709.var_a0b06f1c)) {
            stopfx(localclientnum, var_4fafa709.var_a0b06f1c);
        }
        playfxontag(localclientnum, level._effect["ee_ghost_charged"], var_4fafa709.model, "tag_origin");
        var_4fafa709.model clearanim("ai_zombie_zod_keeper_give_egg_outro", 0);
        var_4fafa709.model zm_zod::ghost_actor(localclientnum, 1, 0);
        var_4fafa709.model zm_zod_quest::keeper_fx(localclientnum, 0, 1);
        if (isdefined(var_4fafa709.var_c8ca4ded)) {
            stopfx(localclientnum, var_4fafa709.var_c8ca4ded);
        }
        var_4fafa709.model playsound(0, "zmb_ee_keeper_resurrect");
        wait 3;
        var_4fafa709.var_f87c0436 = playfxontag(localclientnum, level._effect["keeper_spawn"], var_4fafa709.model, "tag_origin");
        var_4fafa709.var_6b0fc6a1 = playfxontag(localclientnum, level._effect["keeper_spawn"], var_4fafa709.mdl_totem, "tag_origin");
        var_4fafa709.model playsound(0, "evt_keeper_portal_end");
        var_4fafa709.mdl_totem playsound(0, "evt_keeper_portal_end");
        wait 1;
        var_4fafa709.model hide();
        var_4fafa709.mdl_totem hide();
        stopfx(localclientnum, var_4fafa709.var_f87c0436);
        stopfx(localclientnum, var_4fafa709.var_6b0fc6a1);
        str_targetname = "ee_keeper_8_" + n_character_index - 1;
        s_loc = struct::get(str_targetname, "targetname");
        var_4fafa709.model.origin = s_loc.origin;
        var_4fafa709.model.angles = s_loc.angles + (0, 180, 0);
        var_4fafa709.model show();
        var_4fafa709.model animation::play("ai_zombie_zod_keeper_sword_quest_intro_idle", undefined, undefined, 1, 0, 0);
        break;
    case 4:
        function_6f29ee45(var_4fafa709);
        var_4fafa709.model notify(#"hash_274ba0e6");
        var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_intro_idle", 0);
        var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_injured_idle", 0);
        var_4fafa709.model.var_5ad6cc0c = var_4fafa709.model playloopsound("zmb_zod_shadfight_keeper_up_lp", 2);
        s_loc = struct::get("defend_area_pap", "targetname");
        if (!isdefined(s_loc.var_dda4503d)) {
            v_fwd = anglestoforward(s_loc.angles);
            s_loc.var_dda4503d = playfx(localclientnum, level._effect["portal_shortcut_closed_base"], s_loc.origin, v_fwd);
        }
        str_targetname = "ee_keeper_8_" + n_character_index - 1;
        s_loc = struct::get(str_targetname, "targetname");
        if (var_f471914b === 6) {
            var_4fafa709.model playsound(0, "zmb_zod_shadfight_keeper_up");
            var_4fafa709.model.angles = s_loc.angles;
            var_4fafa709.model zm_zod_quest::keeper_fx(localclientnum, 0, 1);
            var_4fafa709.model function_267f859f(localclientnum, level._effect["curse_tell"], 0, 1, "tag_origin");
            var_4fafa709.model animation::play("ai_zombie_zod_keeper_sword_quest_revived", undefined, undefined, 1, 0, 0);
            var_4fafa709.model thread function_274ba0e6("ai_zombie_zod_keeper_sword_quest_ready_idle", 1);
        } else {
            var_4fafa709.model.angles = s_loc.angles + (0, 180, 0);
            var_4fafa709.model animation::play("ai_zombie_zod_keeper_sword_quest_take_sword", undefined, undefined, 1, 0, 0);
            var_4fafa709.model thread function_274ba0e6("ai_zombie_zod_keeper_sword_quest_ready_idle", 1);
        }
        break;
    case 5:
        var_4fafa709.model notify(#"hash_274ba0e6");
        var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_revived", 0);
        var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_take_sword", 0);
        var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_ready_idle", 0);
        var_4fafa709.model playsound(0, "zmb_zod_shadfight_keeper_attack");
        var_4fafa709.model function_267f859f(localclientnum, level._effect["curse_tell"], 0, 1, "tag_origin");
        var_4fafa709.model animation::play("ai_zombie_zod_keeper_sword_quest_attack_intro", undefined, undefined, 1, 0, 0);
        var_4fafa709.model thread function_274ba0e6("ai_zombie_zod_keeper_sword_quest_attack_idle", 1);
        var_4fafa709 function_a48022e(localclientnum, 1, n_character_index);
        wait 3;
        var_4fafa709 function_a48022e(localclientnum, 0, n_character_index);
        break;
    case 6:
        var_4fafa709.model notify(#"hash_274ba0e6");
        var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_attack_intro", 0);
        var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_attack_idle", 0);
        var_4fafa709.model.var_5ad6cc0c = var_4fafa709.model playloopsound("zmb_zod_shadfight_keeper_down_lp", 2);
        var_4fafa709.model playsound(0, "zmb_zod_shadfight_keeper_down");
        var_4fafa709.model zm_zod_quest::keeper_fx(localclientnum, 1, 0);
        var_4fafa709.model function_267f859f(localclientnum, level._effect["curse_tell"], 1, 1, "tag_origin");
        var_4fafa709.model animation::play("ai_zombie_zod_keeper_sword_quest_injured_intro", undefined, undefined, 1, 0, 0);
        var_4fafa709.model thread function_274ba0e6("ai_zombie_zod_keeper_sword_quest_injured_idle", 1);
        break;
    case 7:
        var_4fafa709.model notify(#"hash_274ba0e6");
        var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_attack_intro", 0);
        var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_attack_idle", 0);
        str_targetname = "ee_apothigod_keeper_" + n_character_index - 1;
        s_loc = struct::get(str_targetname, "targetname");
        var_4fafa709.model.origin = s_loc.origin;
        var_4fafa709.model.angles = s_loc.angles;
        var_4fafa709.model thread function_274ba0e6("ai_zombie_zod_keeper_sword_quest_ready_idle", 1);
        break;
    case 8:
        function_6f29ee45(var_4fafa709);
        var_4fafa709.model notify(#"hash_274ba0e6");
        var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_attack_intro", 0);
        var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_attack_idle", 0);
        str_targetname = "ee_apothigod_keeper_" + n_character_index - 1;
        s_loc = struct::get(str_targetname, "targetname");
        var_4fafa709.model.origin = s_loc.origin;
        var_4fafa709.model.angles = s_loc.angles;
        var_4fafa709.model thread function_274ba0e6("ai_zombie_zod_keeper_sword_quest_ready_idle", 1);
        break;
    case 9:
        var_4fafa709.model notify(#"hash_274ba0e6");
        var_4fafa709.model clearanim("ai_zombie_zod_keeper_sword_quest_ready_idle", 0);
        var_4fafa709.model animation::play("ai_zombie_zod_keeper_sword_quest_attack_intro", undefined, undefined, 1, 0, 0);
        var_4fafa709.model thread function_274ba0e6("ai_zombie_zod_keeper_sword_quest_attack_idle", 1);
        break;
    }
}

// Namespace zm_zod_ee
// Params 3, eflags: 0x0
// Checksum 0x74b28fc4, Offset: 0x3990
// Size: 0x144
function function_a48022e(localclientnum, b_on, n_character_index) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    if (n_character_index == 1 || n_character_index == 4) {
        str_beam = level._effect["zombie/fx_ee_keeper_beam_shield1_fail_zod_zmb"];
    } else {
        str_beam = level._effect["zombie/fx_ee_keeper_beam_shield2_fail_zod_zmb"];
    }
    if (b_on) {
        s_loc = struct::get("keeper_vs_shadowman_beam_" + n_character_index);
        v_fwd = anglestoforward(s_loc.angles);
        v_origin = s_loc.origin;
        self.var_f5366edb = playfx(localclientnum, str_beam, v_origin, v_fwd);
        return;
    }
    stopfx(localclientnum, self.var_f5366edb);
}

// Namespace zm_zod_ee
// Params 1, eflags: 0x0
// Checksum 0x38ea5cbb, Offset: 0x3ae0
// Size: 0x6c
function function_6f29ee45(var_4fafa709) {
    if (var_4fafa709.model isattached("wpn_t7_zmb_zod_sword2_world", "tag_weapon_right")) {
        return;
    }
    var_4fafa709.model attach("wpn_t7_zmb_zod_sword2_world", "tag_weapon_right");
}

// Namespace zm_zod_ee
// Params 3, eflags: 0x0
// Checksum 0xacd25163, Offset: 0x3b58
// Size: 0x18c
function function_4d0c8ca8(var_4fafa709, var_fe2fb4b9, n_character_index) {
    if (var_fe2fb4b9 < 4) {
        var_64c74a6d = 0;
    } else if (var_fe2fb4b9 < 8) {
        var_64c74a6d = 1;
    } else {
        var_64c74a6d = 2;
    }
    if (var_4fafa709.var_64c74a6d === var_64c74a6d) {
        return;
    }
    switch (var_64c74a6d) {
    case 0:
        str_targetname = "keeper_spirit_" + n_character_index - 1;
        break;
    case 1:
        str_targetname = "ee_keeper_8_" + n_character_index - 1;
        break;
    case 2:
        str_targetname = "ee_apothigod_keeper_" + n_character_index - 1;
        break;
    }
    s_loc = struct::get(str_targetname, "targetname");
    var_4fafa709.model.origin = s_loc.origin;
    var_4fafa709.model.angles = s_loc.angles;
    var_4fafa709.var_64c74a6d = var_64c74a6d;
}

// Namespace zm_zod_ee
// Params 2, eflags: 0x0
// Checksum 0x79c34e13, Offset: 0x3cf0
// Size: 0x248
function function_e1e53e16(localclientnum, n_character_index) {
    function_1461c206(localclientnum, n_character_index);
    s_loc = struct::get("keeper_spirit_" + n_character_index - 1, "targetname");
    var_4fafa709 = level.var_673f721c[localclientnum][n_character_index];
    if (!isdefined(var_4fafa709.model)) {
        var_4fafa709.model = spawn(localclientnum, s_loc.origin, "script_model");
        var_4fafa709.model.angles = s_loc.angles;
        var_4fafa709.var_64c74a6d = 0;
        var_4fafa709.model setmodel("c_zom_zod_keeper_fb");
        var_4fafa709.model zm_zod::ghost_actor(localclientnum, 0, 1);
    }
    if (!isdefined(var_4fafa709.mdl_totem)) {
        var_f4fc4f28 = struct::get("keeper_resurrection_totem_" + n_character_index - 1, "targetname");
        var_4fafa709.mdl_totem = spawn(localclientnum, var_f4fc4f28.origin, "script_model");
        var_4fafa709.mdl_totem.angles = var_f4fc4f28.angles;
        var_4fafa709.mdl_totem setmodel("t7_zm_zod_keepers_totem");
        var_4fafa709.mdl_totem hide();
    }
    return var_4fafa709;
}

// Namespace zm_zod_ee
// Params 2, eflags: 0x0
// Checksum 0xc05a3fa9, Offset: 0x3f40
// Size: 0x112
function function_2c557738(localclientnum, n_character_index) {
    function_1461c206(localclientnum, n_character_index);
    var_4fafa709 = level.var_673f721c[localclientnum][n_character_index];
    if (isdefined(var_4fafa709.var_f929ecf4)) {
        return var_4fafa709.var_f929ecf4;
    }
    s_target = struct::get("ee_shadowman_beam_" + n_character_index, "targetname");
    var_4fafa709.var_f929ecf4 = spawn(localclientnum, s_target.origin, "script_model");
    var_4fafa709.var_f929ecf4 setmodel("tag_origin");
    return var_4fafa709.var_f929ecf4;
}

// Namespace zm_zod_ee
// Params 1, eflags: 0x0
// Checksum 0x6adba04, Offset: 0x4060
// Size: 0x21c
function function_27e2b2cc(localclientnum) {
    if (!isdefined(level.var_a9f994a9)) {
        level.var_a9f994a9 = spawnstruct();
    }
    if (!isdefined(level.var_a9f994a9.var_8cf34592)) {
        s_loc = struct::get("ee_apothigod_gateworm_reveal", "targetname");
        level.var_a9f994a9.var_8cf34592 = spawn(localclientnum, s_loc.origin, "script_model");
        level.var_a9f994a9.var_8cf34592.angles = s_loc.angles;
        level.var_a9f994a9.var_8cf34592 setmodel("p7_zm_zod_gateworm_large");
        level.var_a9f994a9.var_8cf34592 useanimtree(#generic);
    }
    if (!isdefined(level.var_a9f994a9.var_dbb35f4d)) {
        s_loc = struct::get("ee_apothigod_gateworm_junction", "targetname");
        level.var_a9f994a9.var_dbb35f4d = spawn(localclientnum, s_loc.origin, "script_model");
        level.var_a9f994a9.var_dbb35f4d.angles = s_loc.angles;
        level.var_a9f994a9.var_dbb35f4d setmodel("p7_zm_zod_gateworm_large");
        level.var_a9f994a9.var_8cf34592 useanimtree(#generic);
    }
}

// Namespace zm_zod_ee
// Params 7, eflags: 0x0
// Checksum 0xe75f4482, Offset: 0x4288
// Size: 0x536
function ee_superworm_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 4) {
        return;
    }
    function_27e2b2cc(localclientnum);
    level.var_a9f994a9.var_8cf34592 util::waittill_dobj(localclientnum);
    if (!level.var_a9f994a9.var_8cf34592 hasanimtree()) {
        level.var_a9f994a9.var_8cf34592 useanimtree(#generic);
    }
    level.var_a9f994a9.var_dbb35f4d util::waittill_dobj(localclientnum);
    if (!level.var_a9f994a9.var_dbb35f4d hasanimtree()) {
        level.var_a9f994a9.var_dbb35f4d useanimtree(#generic);
    }
    switch (newval) {
    case 0:
        level.var_a9f994a9.var_8cf34592 hide();
        level.var_a9f994a9.var_dbb35f4d hide();
        break;
    case 1:
        level.var_a9f994a9.var_8cf34592 show();
        level.var_a9f994a9.var_dbb35f4d hide();
        level.var_a9f994a9.var_8cf34592 function_bdd91321(localclientnum, 0, 0);
        level.var_a9f994a9.var_8cf34592 thread animation::play("ai_zombie_zod_gateworm_large_idle_loop_active", undefined, undefined, 1);
        wait 5;
        level.var_a9f994a9.var_8cf34592 hide();
        level.var_a9f994a9.var_8cf34592 function_bdd91321(localclientnum, 0, 0);
        level.var_a9f994a9.var_dbb35f4d show();
        level.var_a9f994a9.var_dbb35f4d function_bdd91321(localclientnum, 1, 0);
        break;
    case 2:
        level.var_a9f994a9.var_8cf34592 hide();
        level.var_a9f994a9.var_dbb35f4d show();
        level.var_a9f994a9.var_dbb35f4d function_bdd91321(localclientnum, 1, 1);
        level.var_a9f994a9.var_dbb35f4d hide();
        break;
    case 3:
        level.var_a9f994a9.var_8cf34592 hide();
        level.var_a9f994a9.var_dbb35f4d show();
        level.var_a9f994a9.var_dbb35f4d function_bdd91321(localclientnum, 0, 0);
        level.var_a9f994a9.var_dbb35f4d clearanim("ai_zombie_zod_gateworm_large_idle_loop_active", 0);
        level.var_a9f994a9.var_dbb35f4d thread animation::play("ai_zombie_zod_gateworm_large_idle_loop", undefined, undefined, 1);
        break;
    case 4:
        level.var_a9f994a9.var_8cf34592 hide();
        level.var_a9f994a9.var_dbb35f4d show();
        level.var_a9f994a9.var_dbb35f4d function_bdd91321(localclientnum, 0, 0);
        level.var_a9f994a9.var_dbb35f4d clearanim("ai_zombie_zod_gateworm_large_idle_loop", 0);
        level.var_a9f994a9.var_dbb35f4d thread animation::play("ai_zombie_zod_gateworm_large_idle_loop_active", undefined, undefined, 1);
        break;
    }
}

// Namespace zm_zod_ee
// Params 3, eflags: 0x0
// Checksum 0xbdd8746, Offset: 0x47c8
// Size: 0x314
function function_bdd91321(localclientnum, b_hide, var_b4c5825f) {
    if (!isdefined(var_b4c5825f)) {
        var_b4c5825f = 0;
    }
    if (b_hide) {
        if (isdefined(self.sndlooper)) {
            self stoploopsound(self.sndlooper, 1);
            self.sndlooper = undefined;
        }
        if (var_b4c5825f) {
            var_840a016a = self gettagorigin("j_spine_1_anim");
            var_5e078701 = self gettagorigin("j_spine_4_anim");
            var_38050c98 = self gettagorigin("j_upper_jaw_1_anim");
            playfx(localclientnum, level._effect["ee_superworm_death"], var_840a016a);
            playfx(localclientnum, level._effect["ee_superworm_death"], var_5e078701);
            playfx(localclientnum, level._effect["ee_superworm_death"], var_38050c98);
            self playsound(0, "zmb_zod_superworm_smash");
        } else {
            v_origin = self gettagorigin("j_spine_6_anim");
            v_angles = self gettagangles("j_spine_6_anim");
            playfx(localclientnum, level._effect["zombie/fx_ee_gateworm_lg_teleport_zod_zmb"], v_origin, v_angles);
            self playsound(0, "zmb_zod_superworm_warpout");
        }
        return;
    }
    v_origin = self gettagorigin("j_spine_6_anim");
    v_angles = self gettagangles("j_spine_6_anim");
    playfx(localclientnum, level._effect["zombie/fx_ee_gateworm_lg_teleport_zod_zmb"], v_origin, v_angles);
    self playsound(0, "zmb_zod_superworm_warpin");
    if (!isdefined(self.sndlooper)) {
        self.sndlooper = self playloopsound("zmb_zod_superworm_loop", 2);
    }
}

// Namespace zm_zod_ee
// Params 7, eflags: 0x0
// Checksum 0x6bec491e, Offset: 0x4ae8
// Size: 0x236
function ee_keeper_beam_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_4c0f7435)) {
        var_7cb357a4 = struct::get("ee_apothigod_beam_unite", "targetname");
        level.var_4c0f7435 = spawn(localclientnum, var_7cb357a4.origin, "script_model");
        level.var_4c0f7435 setmodel("tag_origin");
    }
    v_origin = level.var_4c0f7435.origin + (0, 0, 1000);
    v_angles = anglestoforward(level.var_4c0f7435.angles);
    switch (newval) {
    case 0:
        exploder::stop_exploder("fx_exploder_ee_final_battle_fail");
        exploder::stop_exploder("fx_exploder_ee_final_batttle_success");
        break;
    case 1:
        exploder::exploder("fx_exploder_ee_final_battle_fail");
        level.var_4c0f7435 playsound(0, "zmb_zod_beam_fire_fail");
        break;
    case 2:
        exploder::exploder("fx_exploder_ee_final_batttle_success");
        playfx(localclientnum, level._effect["fx_ee_apothigod_beam_impact_zod_zmb"], v_origin, v_angles);
        level.var_4c0f7435 playsound(0, "zmb_zod_beam_fire_success");
        break;
    }
}

// Namespace zm_zod_ee
// Params 7, eflags: 0x0
// Checksum 0x62b5cd0e, Offset: 0x4d28
// Size: 0x162
function ee_final_boss_shields(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_dcd4f61a = struct::get_array("final_boss_safepoint", "targetname");
    foreach (var_495730fe in var_dcd4f61a) {
        var_495730fe function_267f859f(localclientnum, level._effect["player_cleanse"], newval, 0);
        if (newval) {
            audio::playloopat("zmb_zod_player_cleanse_point", var_495730fe.origin);
            continue;
        }
        audio::stoploopat("zmb_zod_player_cleanse_point", var_495730fe.origin);
    }
}

// Namespace zm_zod_ee
// Params 7, eflags: 0x0
// Checksum 0xec248245, Offset: 0x4e98
// Size: 0x1a4
function ee_final_boss_attack_tell(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread postfx::playpostfxbundle("pstfx_ring_loop_purple");
        self playsound(0, "zmb_zod_player_cursed");
        if (!isdefined(self.var_379c83c)) {
            self.var_379c83c = self playloopsound("zmb_zod_player_cursed_lp", 2);
        }
    } else {
        self postfx::exitpostfxbundle();
        self thread postfx::playpostfxbundle("pstfx_ring_loop_white");
        self playsound(0, "zmb_zod_player_cleansed");
        if (isdefined(self.var_379c83c)) {
            self stoploopsound(self.var_379c83c, 0.5);
            self.var_379c83c = undefined;
        }
        wait 0.25;
        self postfx::exitpostfxbundle();
    }
    self function_267f859f(localclientnum, level._effect["curse_tell"], newval, 1, "tag_origin");
}

// Namespace zm_zod_ee
// Params 7, eflags: 0x0
// Checksum 0xc1a52efc, Offset: 0x5048
// Size: 0x9c
function ee_rail_electricity_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_267f859f(localclientnum, level._effect["ee_quest_powerbox"], newval, 1, "tag_origin");
    if (newval == 1) {
        self playsound(0, "zmb_zod_rail_powerup");
    }
}

// Namespace zm_zod_ee
// Params 2, eflags: 0x0
// Checksum 0x2d3d1e37, Offset: 0x50f0
// Size: 0x90
function function_1461c206(localclientnum, n_character_index) {
    if (!isdefined(level.var_673f721c)) {
        level.var_673f721c = [];
    }
    if (!isdefined(level.var_673f721c[localclientnum])) {
        level.var_673f721c[localclientnum] = [];
    }
    if (!isdefined(level.var_673f721c[localclientnum][n_character_index])) {
        level.var_673f721c[localclientnum][n_character_index] = spawnstruct();
    }
}

// Namespace zm_zod_ee
// Params 2, eflags: 0x0
// Checksum 0x81aa5b4c, Offset: 0x5188
// Size: 0x78
function function_274ba0e6(var_f521672b, var_e3c27047) {
    self notify(#"hash_274ba0e6");
    self endon(#"hash_274ba0e6");
    if (!isdefined(var_e3c27047)) {
        var_e3c27047 = 1;
    }
    while (true) {
        self animation::play(var_f521672b, undefined, undefined, var_e3c27047, 0, 0);
    }
}

// Namespace zm_zod_ee
// Params 5, eflags: 0x0
// Checksum 0x1186dd63, Offset: 0x5208
// Size: 0x18e
function function_267f859f(localclientnum, fx_id, b_on, var_afcc5d76, str_tag) {
    if (!isdefined(fx_id)) {
        fx_id = undefined;
    }
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    if (!isdefined(var_afcc5d76)) {
        var_afcc5d76 = 0;
    }
    if (!isdefined(str_tag)) {
        str_tag = "tag_origin";
    }
    if (b_on) {
        if (isdefined(self.var_270913b5)) {
            stopfx(localclientnum, self.var_270913b5);
        }
        if (var_afcc5d76) {
            self.var_270913b5 = playfxontag(localclientnum, fx_id, self, str_tag);
        } else if (self.angles === (0, 0, 0)) {
            self.var_270913b5 = playfx(localclientnum, fx_id, self.origin);
        } else {
            self.var_270913b5 = playfx(localclientnum, fx_id, self.origin, self.angles);
        }
        return;
    }
    if (isdefined(self.var_270913b5)) {
        stopfx(localclientnum, self.var_270913b5);
        self.var_270913b5 = undefined;
    }
}

// Namespace zm_zod_ee
// Params 7, eflags: 0x0
// Checksum 0x53cb2fe4, Offset: 0x53a0
// Size: 0x98
function near_apothigod_active(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_76ed0403)) {
        level.var_76ed0403 = new class_b454dc63();
        [[ level.var_76ed0403 ]]->init(localclientnum, self, 1);
    }
    thread [[ level.var_76ed0403 ]]->function_66844d0d(localclientnum, newval);
}

// Namespace zm_zod_ee
// Params 7, eflags: 0x0
// Checksum 0x768a8b63, Offset: 0x5440
// Size: 0x98
function far_apothigod_active(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_d566da8c)) {
        level.var_d566da8c = new class_b454dc63();
        [[ level.var_d566da8c ]]->init(localclientnum, self, 0);
    }
    thread [[ level.var_d566da8c ]]->function_66844d0d(localclientnum, newval);
}

// Namespace zm_zod_ee
// Params 7, eflags: 0x0
// Checksum 0x368cdf31, Offset: 0x54e0
// Size: 0x54
function far_apothigod_roar(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    thread [[ level.var_d566da8c ]]->function_2de612ff(localclientnum, self);
}

// Namespace zm_zod_ee
// Params 7, eflags: 0x0
// Checksum 0x76bb163b, Offset: 0x5540
// Size: 0x54
function near_apothigod_roar(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    thread [[ level.var_76ed0403 ]]->function_2de612ff(localclientnum, self);
}

// Namespace zm_zod_ee
// Params 7, eflags: 0x0
// Checksum 0x81da6929, Offset: 0x55a0
// Size: 0x54
function apothigod_death(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    thread [[ level.var_76ed0403 ]]->function_839ff35f(localclientnum, self);
}

