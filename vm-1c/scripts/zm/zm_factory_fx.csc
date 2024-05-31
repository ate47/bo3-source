#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/exploder_shared;
#using scripts/codescripts/struct;

#namespace namespace_e59f4632;

// Namespace namespace_e59f4632
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x6e8
// Size: 0x4
function function_8d0ec42e() {
    
}

// Namespace namespace_e59f4632
// Params 0, eflags: 0x1 linked
// Checksum 0xd2f160b4, Offset: 0x6f8
// Size: 0x274
function main() {
    function_8d0ec42e();
    function_e6258024();
    var_c65a3ce5 = getdvarint("disable_fx");
    if (!isdefined(var_c65a3ce5) || var_c65a3ce5 <= 0) {
        function_f45953c();
    }
    level.var_ed70cfe7 = [];
    level.var_ed70cfe7[0] = "a";
    level.var_ed70cfe7[1] = "c";
    level.var_ed70cfe7[2] = "b";
    level thread function_6b84da80("pw0", "pad_0_wire", "t01");
    level thread function_6b84da80("pw1", "pad_1_wire", "t11");
    level thread function_6b84da80("pw2", "pad_2_wire", "t21");
    level thread function_76a40d4f(0, "t01");
    level thread function_76a40d4f(1, "t11");
    level thread function_76a40d4f(2, "t21");
    level.var_f6e1290c = 0;
    level thread function_9b2eeb61();
    level thread function_54ae2c5f();
    level thread function_9c6ed203();
    level thread function_30e2d0b9("smodel_light_electric", "lights_indlight_on");
    level thread function_30e2d0b9("smodel_light_electric_milit", "lights_milit_lamp_single_int_on");
    level thread function_30e2d0b9("smodel_light_electric_tinhatlamp", "lights_tinhatlamp_on");
}

// Namespace namespace_e59f4632
// Params 0, eflags: 0x1 linked
// Checksum 0x1c888c2d, Offset: 0x978
// Size: 0x18a
function function_f45953c() {
    level._effect["electric_short_oneshot"] = "electrical/fx_elec_sparks_burst_sm_circuit_os";
    level._effect["switch_sparks"] = "electric/fx_elec_sparks_directional_orange";
    level._effect["elec_trail_one_shot"] = "electric/fx_elec_sparks_burst_sm_circuit_os";
    level._effect["zapper_light_ready"] = "maps/zombie/fx_zombie_light_glow_green";
    level._effect["zapper_light_notready"] = "maps/zombie/fx_zombie_light_glow_red";
    level._effect["wire_sparks_oneshot"] = "electrical/fx_elec_wire_spark_dl_oneshot";
    level._effect["wire_spark"] = "electric/fx_elec_sparks_burst_sm_circuit_os";
    level._effect["eye_glow"] = "zombie/fx_glow_eye_orange";
    level._effect["headshot"] = "zombie/fx_bul_flesh_head_fatal_zmb";
    level._effect["headshot_nochunks"] = "zombie/fx_bul_flesh_head_nochunks_zmb";
    level._effect["bloodspurt"] = "zombie/fx_bul_flesh_neck_spurt_zmb";
    level._effect["powerup_on"] = "zombie/fx_powerup_on_green_zmb";
    level._effect["animscript_gib_fx"] = "zombie/fx_blood_torso_explo_zmb";
    level._effect["animscript_gibtrail_fx"] = "trail/fx_trail_blood_streak";
}

// Namespace namespace_e59f4632
// Params 0, eflags: 0x1 linked
// Checksum 0xf5991f53, Offset: 0xb10
// Size: 0xfe
function function_e6258024() {
    level._effect["a_embers_falling_sm"] = "env/fire/fx_embers_falling_sm";
    level._effect["mp_smoke_stack"] = "zombie/fx_smk_stack_burning_zmb";
    level._effect["mp_elec_spark_fast_random"] = "electric/fx_elec_sparks_burst_sm_circuit_os";
    level._effect["zombie_elec_gen_idle"] = "zombie/fx_elec_gen_idle_zmb";
    level._effect["zombie_moon_eclipse"] = "zombie/fx_moon_eclipse_zmb";
    level._effect["zombie_clock_hand"] = "zombie/fx_clock_hand_zmb";
    level._effect["zombie_elec_pole_terminal"] = "zombie/fx_elec_pole_terminal_zmb";
    level._effect["mp_elec_broken_light_1shot"] = "electric/fx_elec_sparks_burst_sm_circuit_os";
    level._effect["zapper"] = "dlc0/factory/fx_elec_trap_factory";
}

// Namespace namespace_e59f4632
// Params 3, eflags: 0x1 linked
// Checksum 0x65be98d4, Offset: 0xc18
// Size: 0x9e
function function_6b84da80(var_7ff7f902, var_1dc3abd8, var_947e05f) {
    level waittill(var_7ff7f902);
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        players[i] thread function_f5f47a62(i, var_1dc3abd8, var_947e05f);
    }
}

// Namespace namespace_e59f4632
// Params 3, eflags: 0x1 linked
// Checksum 0x45169203, Offset: 0xcc0
// Size: 0x25e
function function_f5f47a62(clientnum, var_1dc3abd8, var_947e05f) {
    println("pad_1_wire" + clientnum);
    targ = struct::get(var_1dc3abd8, "targetname");
    if (!isdefined(targ)) {
        return;
    }
    mover = spawn(clientnum, targ.origin, "script_model");
    mover setmodel("tag_origin");
    fx = playfxontag(clientnum, level._effect["wire_spark"], mover, "tag_origin");
    playsound(0, "tele_spark_hit", mover.origin);
    mover playloopsound("tele_spark_loop");
    while (isdefined(targ)) {
        if (isdefined(targ.target)) {
            println("pad_1_wire" + clientnum + "pad_1_wire" + targ.target);
            target = struct::get(targ.target, "targetname");
            mover moveto(target.origin, 0.1);
            wait(0.1);
            targ = target;
            continue;
        }
        break;
    }
    level notify(#"hash_f78a45bf");
    mover delete();
    level notify(var_947e05f);
}

// Namespace namespace_e59f4632
// Params 0, eflags: 0x1 linked
// Checksum 0x2539b9aa, Offset: 0xf28
// Size: 0xd6
function function_95c61c0f() {
    for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
        setlitfogbank(localclientnum, -1, 1, -1);
        setworldfogactivebank(localclientnum, 2);
    }
    wait(2.5);
    for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
        setlitfogbank(localclientnum, -1, 0, -1);
        setworldfogactivebank(localclientnum, 1);
    }
}

// Namespace namespace_e59f4632
// Params 0, eflags: 0x1 linked
// Checksum 0x50d9434a, Offset: 0x1008
// Size: 0x188
function function_54ae2c5f() {
    while (true) {
        level waittill(#"dog_start");
        level thread function_95c61c0f();
        var_82267cf6 = -27;
        var_370979c5 = -56;
        half_height = 380;
        var_ce3acb38 = -56;
        var_4f40cb18 = 0.0117647;
        var_ad258895 = 0.0156863;
        var_ef192488 = 0.0235294;
        var_e6f7f220 = 5.5;
        var_ffae135d = 0.0313726;
        var_e17a08c0 = 0.0470588;
        var_9f866ccd = 0.0823529;
        var_706cff38 = -0.1761;
        var_966f79a1 = 0.689918;
        var_bc71f40a = 0.702141;
        var_14c07505 = 0;
        var_7b5a55b1 = 49.8549;
        time = 7;
        var_d6eebf82 = 1;
    }
}

// Namespace namespace_e59f4632
// Params 0, eflags: 0x1 linked
// Checksum 0x6dbbc603, Offset: 0x1198
// Size: 0x180
function function_9c6ed203() {
    while (true) {
        level waittill(#"hash_d3c06010");
        level thread function_95c61c0f();
        var_82267cf6 = 440;
        var_370979c5 = 3200;
        half_height = -31;
        var_ce3acb38 = 64;
        var_4f40cb18 = 0.533;
        var_ad258895 = 0.717;
        var_ef192488 = 1;
        var_e6f7f220 = 1;
        var_ffae135d = 0.0313726;
        var_e17a08c0 = 0.0470588;
        var_9f866ccd = 0.0823529;
        var_706cff38 = -0.1761;
        var_966f79a1 = 0.689918;
        var_bc71f40a = 0.702141;
        var_14c07505 = 0;
        var_7b5a55b1 = 0;
        time = 7;
        var_d6eebf82 = 1;
    }
}

// Namespace namespace_e59f4632
// Params 0, eflags: 0x0
// Checksum 0x83d2ed7f, Offset: 0x1320
// Size: 0x156
function function_51352561() {
    var_82267cf6 = 440;
    var_370979c5 = 3200;
    half_height = -31;
    var_ce3acb38 = 64;
    var_4f40cb18 = 0.219608;
    var_ad258895 = 0.403922;
    var_ef192488 = 0.686275;
    var_e6f7f220 = 1;
    var_ffae135d = 0.0313726;
    var_e17a08c0 = 0.0470588;
    var_9f866ccd = 0.0823529;
    var_706cff38 = -0.1761;
    var_966f79a1 = 0.689918;
    var_bc71f40a = 0.702141;
    var_14c07505 = 0;
    var_7b5a55b1 = 0;
    time = 0;
    var_d6eebf82 = 1;
}

// Namespace namespace_e59f4632
// Params 2, eflags: 0x1 linked
// Checksum 0xdfd533c1, Offset: 0x1480
// Size: 0xe8
function function_30e2d0b9(name, model) {
    level waittill(#"hash_a39e7bd2");
    players = getlocalplayers();
    for (p = 0; p < players.size; p++) {
        var_8f5c2f5e = getentarray(p, name, "targetname");
        for (i = 0; i < var_8f5c2f5e.size; i++) {
            var_8f5c2f5e[i] setmodel(model);
        }
    }
}

// Namespace namespace_e59f4632
// Params 1, eflags: 0x0
// Checksum 0xd41484e4, Offset: 0x1570
// Size: 0x134
function function_d0ccb51(ent) {
    var_60639690 = struct::get_array("map_fx_guide_struct", "targetname");
    if (var_60639690.size > 0) {
        var_21f205d7 = var_60639690[0];
        dist = distancesquared(ent.origin, var_21f205d7.origin);
        for (i = 1; i < var_60639690.size; i++) {
            var_34f63ce0 = distancesquared(ent.origin, var_60639690[i].origin);
            if (var_34f63ce0 < dist) {
                var_21f205d7 = var_60639690[i];
                dist = var_34f63ce0;
            }
        }
        return var_21f205d7.angles;
    }
    return (0, 0, 0);
}

// Namespace namespace_e59f4632
// Params 2, eflags: 0x1 linked
// Checksum 0xca338342, Offset: 0x16b0
// Size: 0x184
function function_76a40d4f(index, var_7e9d5868) {
    level waittill(#"hash_a39e7bd2");
    exploder::exploder("map_lgt_" + level.var_ed70cfe7[index] + "_red");
    level waittill(var_7e9d5868);
    exploder::stop_exploder("map_lgt_" + level.var_ed70cfe7[index] + "_red");
    exploder::exploder("map_lgt_" + level.var_ed70cfe7[index] + "_green");
    level thread scene::play("fxanim_diff_engine_zone_" + level.var_ed70cfe7[index] + "1", "targetname");
    level thread scene::play("fxanim_diff_engine_zone_" + level.var_ed70cfe7[index] + "2", "targetname");
    level thread scene::play("fxanim_powerline_" + level.var_ed70cfe7[index], "targetname");
}

// Namespace namespace_e59f4632
// Params 0, eflags: 0x1 linked
// Checksum 0x7e5f9e49, Offset: 0x1840
// Size: 0x9c
function function_9b2eeb61() {
    level waittill(#"hash_a39e7bd2");
    level thread function_6af49b4a();
    exploder::exploder("map_lgt_pap_red");
    level waittill(#"hash_eba48475");
    wait(1.5);
    exploder::stop_exploder("map_lgt_pap_red");
    exploder::stop_exploder("map_lgt_pap_flash");
    exploder::exploder("map_lgt_pap_green");
}

// Namespace namespace_e59f4632
// Params 0, eflags: 0x1 linked
// Checksum 0xe2db1265, Offset: 0x18e8
// Size: 0x6c
function function_6af49b4a() {
    level endon(#"hash_eba48475");
    level waittill(#"hash_b8d5dc47");
    level endon(#"hash_5af11eca");
    level thread function_b4fa8eac();
    exploder::stop_exploder("map_lgt_pap_red");
    exploder::exploder("map_lgt_pap_flash");
}

// Namespace namespace_e59f4632
// Params 0, eflags: 0x1 linked
// Checksum 0xfe26b782, Offset: 0x1960
// Size: 0x64
function function_b4fa8eac() {
    level endon(#"hash_eba48475");
    level waittill(#"hash_5af11eca");
    exploder::stop_exploder("map_lgt_pap_flash");
    exploder::exploder("map_lgt_pap_red");
    level thread function_6af49b4a();
}

