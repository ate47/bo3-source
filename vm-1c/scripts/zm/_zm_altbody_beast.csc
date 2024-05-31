#using scripts/zm/_zm_altbody;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_util;
#using scripts/shared/weapons/grapple;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/beam_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_215602b6;

// Namespace namespace_215602b6
// Params 0, eflags: 0x2
// namespace_215602b6<file_0>::function_2dc19561
// Checksum 0x2911ac80, Offset: 0xa88
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_altbody_beast", &__init__, undefined, undefined);
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// namespace_215602b6<file_0>::function_8c87d8eb
// Checksum 0x21eaae4, Offset: 0xac8
// Size: 0x41e
function __init__() {
    if (!isdefined(level.bminteract)) {
        level.bminteract = [];
    }
    clientfield::register("missile", "bminteract", 1, 2, "int", &function_d9d8e4d9, 0, 0);
    clientfield::register("scriptmover", "bminteract", 1, 2, "int", &function_d9d8e4d9, 0, 0);
    clientfield::register("actor", "bm_zombie_melee_kill", 1, 1, "int", &function_b2532c75, 0, 0);
    clientfield::register("actor", "bm_zombie_grapple_kill", 1, 1, "int", &function_46405286, 0, 0);
    clientfield::register("toplayer", "beast_blood_on_player", 1, 1, "counter", &function_70f7f4d2, 0, 0);
    clientfield::register("world", "bm_superbeast", 1, 1, "int", undefined, 0, 0);
    function_10dcd1d5("beast_mode_kiosk");
    duplicate_render::set_dr_filter_offscreen("bmint", 35, "bminteract,bmplayer", undefined, 2, "mc/hud_keyline_beastmode", 0);
    zm_altbody::init("beast_mode", "beast_mode_kiosk", %ZM_ZOD_ENTER_BEAST_MODE, "zombie_beast_2", 123, &function_1699b690, &function_b2631b3c, &function_df3032fc, &function_da014198);
    callback::on_localclient_connect(&player_on_connect);
    callback::on_spawned(&player_on_spawned);
    level._effect["beast_kiosk_fx_reset"] = "zombie/fx_bmode_kiosk_fire_reset_zod_zmb";
    level._effect["beast_kiosk_fx_enabled"] = "zombie/fx_bmode_kiosk_fire_zod_zmb";
    level._effect["beast_kiosk_fx_disabled"] = "zombie/fx_bmode_kiosk_idle_zod_zmb";
    level._effect["beast_kiosk_fx_cursed"] = "zombie/fx_bmode_kiosk_fire_tainted_zod_zmb";
    level._effect["beast_kiosk_fx_super"] = "zombie/fx_ritual_pap_basin_fire_lg_zod_zmb";
    level._effect["beast_fork"] = "zombie/fx_bmode_tent_fork_zod_zmb";
    level._effect["beast_fork_1"] = "zombie/fx_bmode_tent_charging1_zod_zmb";
    level._effect["beast_fork_2"] = "zombie/fx_bmode_tent_charging2_zod_zmb";
    level._effect["beast_fork_3"] = "zombie/fx_bmode_tent_charging3_zod_zmb";
    level._effect["beast_3p_trail"] = "zombie/fx_bmode_trail_3p_zod_zmb";
    level._effect["beast_1p_light"] = "zombie/fx_bmode_tent_light_zod_zmb";
    level._effect["beast_melee_kill"] = "zombie/fx_bmode_attack_grapple_zod_zmb";
    level._effect["beast_grapple_kill"] = "zombie/fx_bmode_attack_grapple_zod_zmb";
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// namespace_215602b6<file_0>::function_e3031b65
// Checksum 0x8323681c, Offset: 0xef0
// Size: 0x2e
function player_on_connect(localclientnum) {
    if (!isdefined(level.bminteract[localclientnum])) {
        level.bminteract[localclientnum] = [];
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// namespace_215602b6<file_0>::function_eaa5b495
// Checksum 0xe77c623f, Offset: 0xf28
// Size: 0x13c
function player_on_spawned(localclientnum) {
    if (!self islocalplayer() || !isdefined(self getlocalclientnumber()) || localclientnum != self getlocalclientnumber()) {
        return;
    }
    setbeastmodeiconmaterial(localclientnum, 1, "t7_hud_zm_beastmode_meleeattack");
    setbeastmodeiconmaterial(localclientnum, 2, "t7_hud_zm_beastmode_electricityattack");
    setbeastmodeiconmaterial(localclientnum, 3, "t7_hud_zm_beastmode_grapplehook");
    self function_62095f03(localclientnum);
    filter::function_2c6745d7(self);
    self thread function_a1b60d91(localclientnum, 0);
    self oed_sitrepscan_setradius(1800);
    /#
        self thread function_ac7706bc();
    #/
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// namespace_215602b6<file_0>::function_1699b690
// Checksum 0x76d2d048, Offset: 0x1070
// Size: 0x2b4
function function_1699b690(localclientnum) {
    var_84301bb1 = getnonpredictedlocalplayer(localclientnum);
    player = getlocalplayer(localclientnum);
    self.beast_mode = 1;
    self thread function_a1b60d91(localclientnum, !function_faf41e73(localclientnum));
    self thread function_96cc48fa(player === var_84301bb1);
    self thread function_2a7bb7b3(localclientnum, 1);
    self thread function_b25c9962(1, "tag_flash", 0.15);
    self thread function_89d6f49a(localclientnum, 1);
    self function_2d565c0(localclientnum, 0);
    function_cce7ef03(localclientnum, 1);
    var_1ee18766 = 0;
    /#
        var_1ee18766 = getdvarint("zombie/fx_bmode_tent_light_zod_zmb") > 0;
        self thread function_5d7a94fa(localclientnum);
    #/
    if (isdemoplaying()) {
        self thread function_cb236f81(localclientnum);
    }
    if (!var_1ee18766 && !function_faf41e73(localclientnum) && player === var_84301bb1) {
        setpbgactivebank(localclientnum, 2);
        self thread function_56c9cf9d(localclientnum);
        self.var_b65bad1f = playfxoncamera(localclientnum, level._effect["beast_1p_light"]);
    }
    /#
        if (getdvarint("bmplayer") > 0) {
            self.var_45a700e5 = playfxontag(localclientnum, level._effect["_crs_"], self, "grapple_beam_off");
        }
    #/
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// namespace_215602b6<file_0>::function_5d7a94fa
// Checksum 0xaf52451d, Offset: 0x1330
// Size: 0x168
function function_5d7a94fa(localclientnum) {
    self endon(#"hash_dd954547");
    var_3f39d2cc = getdvarint("scr_beast_no_visionset") > 0;
    while (isdefined(self)) {
        var_1ee18766 = getdvarint("scr_beast_no_visionset") > 0;
        if (var_1ee18766 != var_3f39d2cc) {
            if (var_1ee18766) {
                if (isdefined(self.var_b65bad1f)) {
                    stopfx(localclientnum, self.var_b65bad1f);
                    self.var_b65bad1f = undefined;
                }
                setpbgactivebank(localclientnum, 1);
                self thread function_ea06d888(localclientnum);
            } else {
                setpbgactivebank(localclientnum, 2);
                self thread function_56c9cf9d(localclientnum);
                self.var_b65bad1f = playfxoncamera(localclientnum, level._effect["beast_1p_light"]);
            }
        }
        var_3f39d2cc = var_1ee18766;
        wait(1);
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// namespace_215602b6<file_0>::function_faf41e73
// Checksum 0xa8290583, Offset: 0x14a0
// Size: 0x32
function function_faf41e73(localclientnum) {
    return isdemoplaying() && demoisanyfreemovecamera();
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// namespace_215602b6<file_0>::function_cb236f81
// Checksum 0x562f9096, Offset: 0x14e0
// Size: 0x198
function function_cb236f81(localclientnum) {
    self endon(#"hash_dd954547");
    if (!isdemoplaying()) {
        return;
    }
    var_af2f137b = function_faf41e73(localclientnum);
    while (isdefined(self)) {
        var_26495de5 = function_faf41e73(localclientnum);
        if (var_26495de5 != var_af2f137b) {
            if (var_26495de5) {
                if (isdefined(self.var_b65bad1f)) {
                    stopfx(localclientnum, self.var_b65bad1f);
                    self.var_b65bad1f = undefined;
                }
                setpbgactivebank(localclientnum, 1);
                self thread function_ea06d888(localclientnum);
            } else {
                setpbgactivebank(localclientnum, 2);
                self thread function_56c9cf9d(localclientnum);
                self.var_b65bad1f = playfxoncamera(localclientnum, level._effect["beast_1p_light"]);
            }
            self thread function_a1b60d91(localclientnum, !var_26495de5);
        }
        var_af2f137b = var_26495de5;
        wait(1);
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// namespace_215602b6<file_0>::function_56c9cf9d
// Checksum 0x3e8fc19f, Offset: 0x1680
// Size: 0x2c
function function_56c9cf9d(localclientnum) {
    self thread postfx::playpostfxbundle("pstfx_zm_beast_mode_loop");
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// namespace_215602b6<file_0>::function_b2631b3c
// Checksum 0xa4650177, Offset: 0x16b8
// Size: 0x170
function function_b2631b3c(localclientnum) {
    self notify(#"hash_dd954547");
    /#
        if (isdefined(self.var_45a700e5)) {
            stopfx(localclientnum, self.var_45a700e5);
            self.var_45a700e5 = undefined;
        }
    #/
    if (isdefined(self.var_b65bad1f)) {
        stopfx(localclientnum, self.var_b65bad1f);
        self.var_b65bad1f = undefined;
    }
    function_cce7ef03(localclientnum, 0);
    setpbgactivebank(localclientnum, 1);
    self thread function_89d6f49a(localclientnum, 0);
    self thread function_ea06d888(localclientnum);
    self thread function_b25c9962(0);
    self thread function_a1b60d91(localclientnum, 0);
    self thread function_2a7bb7b3(localclientnum, 0);
    self thread function_96cc48fa(0);
    self oed_sitrepscan_enable(4);
    self.beast_mode = 0;
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// namespace_215602b6<file_0>::function_ea06d888
// Checksum 0x13add9ef, Offset: 0x1830
// Size: 0x24
function function_ea06d888(localclientnum) {
    self thread postfx::exitpostfxbundle();
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// namespace_215602b6<file_0>::function_df3032fc
// Checksum 0x594e1169, Offset: 0x1860
// Size: 0x6c
function function_df3032fc(localclientnum) {
    self.var_45a700e5 = playfxontag(localclientnum, level._effect["beast_3p_trail"], self, "j_spinelower");
    self thread function_b25c9962(1, "J_Tent_Main_14_RI", 0.05);
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// namespace_215602b6<file_0>::function_da014198
// Checksum 0xae109876, Offset: 0x18d8
// Size: 0x56
function function_da014198(localclientnum) {
    self thread function_b25c9962(0);
    if (isdefined(self.var_45a700e5)) {
        stopfx(localclientnum, self.var_45a700e5);
        self.var_45a700e5 = undefined;
    }
}

// Namespace namespace_215602b6
// Params 3, eflags: 0x0
// namespace_215602b6<file_0>::function_4c36abd
// Checksum 0x1213e76e, Offset: 0x1938
// Size: 0x100
function function_4c36abd(localclientnum, val, key) {
    all = getentarray(localclientnum);
    ret = [];
    foreach (ent in all) {
        if (isdefined(ent.script_noteworthy)) {
            if (ent.script_noteworthy === val) {
                ret[ret.size] = ent;
            }
        }
    }
    return ret;
}

// Namespace namespace_215602b6
// Params 7, eflags: 0x0
// namespace_215602b6<file_0>::function_70f7f4d2
// Checksum 0xcbd9ff07, Offset: 0x1a40
// Size: 0x8c
function function_70f7f4d2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setsoundcontext("foley", "normal");
    if (newval == 1) {
        self thread function_4685bc0f(localclientnum, 0.1, 3);
    }
}

// Namespace namespace_215602b6
// Params 3, eflags: 0x0
// namespace_215602b6<file_0>::function_4685bc0f
// Checksum 0xb7ff55e9, Offset: 0x1ad8
// Size: 0xb4
function function_4685bc0f(localclientnum, var_2646032, var_72af98b3) {
    self endon(#"entityshutdown");
    if (isdefined(self)) {
        filter::function_aaeba942(self, 5);
        self thread function_ef4c8536(localclientnum, var_2646032, var_72af98b3);
        self util::waittill_any_timeout(var_2646032 + var_72af98b3, "beast_mode_exit", "entityshutdown");
        if (isdefined(self)) {
            filter::function_5dc1f50f(self, 5);
        }
    }
}

// Namespace namespace_215602b6
// Params 3, eflags: 0x0
// namespace_215602b6<file_0>::function_ef4c8536
// Checksum 0x3574e92, Offset: 0x1b98
// Size: 0x23c
function function_ef4c8536(localclientnum, var_2646032, var_72af98b3) {
    self notify(#"hash_ef4c8536");
    self endon(#"hash_ef4c8536");
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    if (!isdefined(self.var_90b6339d)) {
        self.var_90b6339d = 0;
    }
    filter::function_3e6453dd(self, 5, 0, 0);
    for (t = 0; t <= var_2646032 && isdefined(self); t += 0.05) {
        self.var_90b6339d = max(self.var_90b6339d, t / var_2646032);
        filter::function_3e6453dd(self, 5, self.var_90b6339d, 0);
        wait(0.05);
    }
    self.var_90b6339d = 1;
    filter::function_3e6453dd(self, 5, self.var_90b6339d, 0);
    for (t = 0; t <= var_72af98b3 && isdefined(self); t += 0.05) {
        self.var_90b6339d = min(self.var_90b6339d, 1 - t / var_72af98b3);
        filter::function_3e6453dd(self, 5, self.var_90b6339d, 0);
        wait(0.05);
    }
    self.var_90b6339d = 0;
    filter::function_3e6453dd(self, 5, self.var_90b6339d, 0);
}

// Namespace namespace_215602b6
// Params 2, eflags: 0x0
// namespace_215602b6<file_0>::function_cce7ef03
// Checksum 0x96b4f06c, Offset: 0x1de0
// Size: 0xdc
function function_cce7ef03(localclientnum, onoff) {
    if (getdvarint("splitscreen_playerCount") == 2) {
        var_b401f607 = getdvarint("scr_num_in_beast");
        if (onoff) {
            var_b401f607++;
            setdvar("cg_focalLength", 21);
        } else {
            var_b401f607--;
            if (var_b401f607 == 0) {
                setdvar("cg_focalLength", 14.64);
            }
        }
        setdvar("scr_num_in_beast", var_b401f607);
    }
}

// Namespace namespace_215602b6
// Params 2, eflags: 0x0
// namespace_215602b6<file_0>::function_a1b60d91
// Checksum 0xa0c18453, Offset: 0x1ec8
// Size: 0x134
function function_a1b60d91(localclientnum, onoff) {
    var_f023f29 = function_4c36abd(localclientnum, "beast_mode", "script_noteworthy");
    array::run_all(var_f023f29, &function_77fcc1c2, localclientnum, self, onoff);
    var_66757da5 = function_4c36abd(localclientnum, "not_beast_mode", "script_noteworthy");
    array::run_all(var_66757da5, &function_77fcc1c2, localclientnum, self, !onoff);
    wait(0.016);
    clean_deleted(level.bminteract[localclientnum]);
    array::run_all(level.bminteract[localclientnum], &function_392fd748, localclientnum, onoff);
}

// Namespace namespace_215602b6
// Params 2, eflags: 0x0
// namespace_215602b6<file_0>::function_392fd748
// Checksum 0x5225610a, Offset: 0x2008
// Size: 0x16c
function function_392fd748(localclientnum, onoff) {
    if (!isdefined(self.var_2a7bb7b3)) {
        self.var_2a7bb7b3 = [];
    }
    if (isdefined(self.var_2a7bb7b3[localclientnum])) {
        stopfx(localclientnum, self.var_2a7bb7b3[localclientnum]);
        self.var_2a7bb7b3[localclientnum] = undefined;
    }
    if (isdefined(self.model)) {
        if (onoff) {
            fx = function_d9f5b74d(self.model);
        } else {
            fx = function_f74ecbae(self.model);
        }
        if (isdefined(fx)) {
            self.var_2a7bb7b3[localclientnum] = playfxontag(localclientnum, fx, self, "tag_origin");
        }
    }
    if (!issplitscreen() && !isdemoplaying()) {
        self duplicate_render::set_dr_flag("bmplayer", onoff);
        self duplicate_render::update_dr_filters(localclientnum);
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// namespace_215602b6<file_0>::function_d9f5b74d
// Checksum 0x726560ee, Offset: 0x2180
// Size: 0x80
function function_d9f5b74d(modelname) {
    switch (modelname) {
    case 72:
        return "zombie/fx_bmode_glow_hook_zod_zmb";
    case 74:
        return "zombie/fx_bmode_glow_pwrbox_zod_zmb";
    case 69:
        return "zombie/fx_bmode_glow_door_zod_zmb";
    case 73:
        return "zombie/fx_bmode_glow_crate_zod_zmb";
    case 71:
        return "zombie/fx_bmode_glow_crate_zod_zmb";
    case 70:
        return "zombie/fx_bmode_glow_crate_tall_zod_zmb";
    }
    return undefined;
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// namespace_215602b6<file_0>::function_f74ecbae
// Checksum 0xff139ac7, Offset: 0x2208
// Size: 0x30
function function_f74ecbae(modelname) {
    switch (modelname) {
    case 72:
        return "zombie/fx_bmode_glint_hook_zod_zmb";
    }
    return undefined;
}

// Namespace namespace_215602b6
// Params 3, eflags: 0x0
// namespace_215602b6<file_0>::function_77fcc1c2
// Checksum 0xa29a5215, Offset: 0x2240
// Size: 0x54
function function_77fcc1c2(localclientnum, player, onoff) {
    if (onoff) {
        self show();
        return;
    }
    self hide();
}

// Namespace namespace_215602b6
// Params 2, eflags: 0x0
// namespace_215602b6<file_0>::function_124423a4
// Checksum 0x59747a3a, Offset: 0x22a0
// Size: 0x84
function add_remove_list(&a, on_off) {
    if (!isdefined(a)) {
        a = [];
    }
    if (on_off) {
        if (!isinarray(a, self)) {
            arrayinsert(a, self, a.size);
        }
        return;
    }
    arrayremovevalue(a, self, 0);
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// namespace_215602b6<file_0>::function_2d5c2e92
// Checksum 0x96643789, Offset: 0x2330
// Size: 0xe2
function clean_deleted(&array) {
    done = 0;
    while (!done && array.size > 0) {
        done = 1;
        foreach (key, val in array) {
            if (!isdefined(val)) {
                arrayremoveindex(array, key, 0);
                done = 0;
                break;
            }
        }
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// namespace_215602b6<file_0>::function_7d675424
// Checksum 0x69f457d7, Offset: 0x2420
// Size: 0x90
function function_7d675424(type) {
    if (type == 2) {
        up = anglestoup(self.angles);
        forward = anglestoforward(self.angles);
        location = self.origin + 12 * forward;
        return location;
    }
    return undefined;
}

// Namespace namespace_215602b6
// Params 7, eflags: 0x0
// namespace_215602b6<file_0>::function_d9d8e4d9
// Checksum 0x5bdededc, Offset: 0x24b8
// Size: 0x22c
function function_d9d8e4d9(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    onoff = newval != 0;
    location = self function_7d675424(newval);
    if (isdefined(location)) {
        self setentbeastmodeicontype(newval, location);
    } else {
        self setentbeastmodeicontype(newval);
    }
    self add_remove_list(level.bminteract[local_client_num], onoff);
    if (!issplitscreen()) {
        self duplicate_render::set_dr_flag("bmplayer", isdefined(getlocalplayer(local_client_num).beast_mode) && getlocalplayer(local_client_num).beast_mode);
    }
    if (onoff) {
        self duplicate_render::set_dr_flag("bminteract", onoff);
        self duplicate_render::update_dr_filters(local_client_num);
        return;
    }
    if (!isdefined(self.var_2a7bb7b3)) {
        self.var_2a7bb7b3 = [];
    }
    if (isdefined(self.var_2a7bb7b3[local_client_num])) {
        stopfx(local_client_num, self.var_2a7bb7b3[local_client_num]);
        self.var_2a7bb7b3[local_client_num] = undefined;
    }
    if (isdefined(self.currentdrfilter)) {
        self duplicate_render::set_dr_flag("bminteract", onoff);
        self duplicate_render::update_dr_filters(local_client_num);
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// namespace_215602b6<file_0>::function_10dcd1d5
// Checksum 0x3b840a5a, Offset: 0x26f0
// Size: 0x1da
function function_10dcd1d5(kiosk_name) {
    level.var_8ad0ec05 = struct::get_array(kiosk_name, "targetname");
    level.var_dc56ce87 = [];
    level.var_104eabe = [];
    foreach (kiosk in level.var_8ad0ec05) {
        if (!isdefined(kiosk.state)) {
            kiosk.state = [];
        }
        if (!isdefined(kiosk.fake_ent)) {
            kiosk.fake_ent = [];
        }
        kiosk.var_80eeb471 = kiosk_name + "_plr_" + kiosk.origin;
        kiosk.var_39a60f4a = kiosk_name + "_crs_" + kiosk.origin;
        level.var_dc56ce87[kiosk.var_80eeb471] = kiosk;
        level.var_104eabe[kiosk.var_39a60f4a] = kiosk;
        clientfield::register("world", kiosk.var_80eeb471, 1, 4, "int", &function_fa828651, 0, 0);
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// namespace_215602b6<file_0>::function_62095f03
// Checksum 0xff86efd0, Offset: 0x28d8
// Size: 0x1a2
function function_62095f03(localclientnum) {
    foreach (kiosk in level.var_8ad0ec05) {
        if (!isdefined(kiosk.state)) {
            kiosk.state = [];
        }
        if (!isdefined(kiosk.fake_ent)) {
            kiosk.fake_ent = [];
        }
        if (!isdefined(kiosk.fake_ent[localclientnum])) {
            kiosk.fake_ent[localclientnum] = util::spawn_model(localclientnum, "tag_origin", kiosk.origin, kiosk.angles);
            if (isdefined(kiosk.state[localclientnum])) {
                kiosk.fake_ent[localclientnum] function_1dd72620(localclientnum, kiosk.state[localclientnum], kiosk.state[localclientnum], 1, 0, kiosk.var_80eeb471, 0);
            }
        }
    }
}

// Namespace namespace_215602b6
// Params 7, eflags: 0x0
// namespace_215602b6<file_0>::function_fa828651
// Checksum 0x353b920e, Offset: 0x2a88
// Size: 0x11c
function function_fa828651(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    kiosk = level.var_dc56ce87[fieldname];
    if (isdefined(kiosk)) {
        if (!isdefined(kiosk.state)) {
            kiosk.state = [];
        }
        if (!isdefined(kiosk.fake_ent)) {
            kiosk.fake_ent = [];
        }
        kiosk.state[localclientnum] = newval;
        if (isdefined(kiosk.fake_ent[localclientnum])) {
            kiosk.fake_ent[localclientnum] function_1dd72620(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
        }
    }
}

// Namespace namespace_215602b6
// Params 7, eflags: 0x0
// namespace_215602b6<file_0>::function_1dd72620
// Checksum 0x7580e43, Offset: 0x2bb0
// Size: 0x334
function function_1dd72620(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    n_entnum = player getentitynumber();
    if (!isdefined(self.var_1fa5299f)) {
        self.var_1fa5299f = [];
    }
    if (!isdefined(self.var_1fa5299f[localclientnum])) {
        self.var_1fa5299f[localclientnum] = [];
    }
    if (newval & 1 << n_entnum) {
        if (isdefined(self.var_1fa5299f[localclientnum]["disabled"])) {
            stopfx(localclientnum, self.var_1fa5299f[localclientnum]["disabled"]);
            self.var_1fa5299f[localclientnum]["disabled"] = undefined;
        }
        if (!isdefined(self.var_1fa5299f[localclientnum]["enabled"])) {
            playfxontag(localclientnum, level._effect["beast_kiosk_fx_reset"], self, "tag_origin");
            playsound(0, "evt_beastmode_torch_ignite", self.origin);
            if (level clientfield::get("bm_superbeast")) {
                self.var_1fa5299f[localclientnum]["enabled"] = playfxontag(localclientnum, level._effect["beast_kiosk_fx_super"], self, "tag_origin");
            } else {
                self.var_1fa5299f[localclientnum]["enabled"] = playfxontag(localclientnum, level._effect["beast_kiosk_fx_enabled"], self, "tag_origin");
            }
        }
        return;
    }
    if (isdefined(self.var_1fa5299f[localclientnum]["enabled"])) {
        stopfx(localclientnum, self.var_1fa5299f[localclientnum]["enabled"]);
        self.var_1fa5299f[localclientnum]["enabled"] = undefined;
    }
    if (!isdefined(self.var_1fa5299f[localclientnum]["disabled"])) {
        self.var_1fa5299f[localclientnum]["disabled"] = playfxontag(localclientnum, level._effect["beast_kiosk_fx_disabled"], self, "tag_origin");
    }
}

// Namespace namespace_215602b6
// Params 7, eflags: 0x0
// namespace_215602b6<file_0>::function_5e873a4e
// Checksum 0xf71cf6cd, Offset: 0x2ef0
// Size: 0x9c
function function_5e873a4e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    kiosk = level.var_104eabe[fieldname];
    if (isdefined(kiosk)) {
        kiosk.fake_ent function_e97fecd7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    }
}

// Namespace namespace_215602b6
// Params 7, eflags: 0x0
// namespace_215602b6<file_0>::function_e97fecd7
// Checksum 0xba005edb, Offset: 0x2f98
// Size: 0x15c
function function_e97fecd7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    if (!isdefined(self.var_1fa5299f)) {
        self.var_1fa5299f = [];
    }
    if (!isdefined(self.var_1fa5299f[localclientnum])) {
        self.var_1fa5299f[localclientnum] = [];
    }
    if (newval) {
        if (!isdefined(self.var_1fa5299f[localclientnum]["denied"])) {
            self.var_1fa5299f[localclientnum]["denied"] = playfxontag(localclientnum, level._effect["beast_kiosk_fx_cursed"], self, "tag_origin");
        }
        return;
    }
    if (isdefined(self.var_1fa5299f[localclientnum]["denied"])) {
        stopfx(localclientnum, self.var_1fa5299f[localclientnum]["denied"]);
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// namespace_215602b6<file_0>::function_96cc48fa
// Checksum 0x280e7a3d, Offset: 0x3100
// Size: 0x7c
function function_96cc48fa(activate) {
    if (activate) {
        forceambientroom("zm_zod_beastmode");
        self thread function_f61ba6c8();
        return;
    }
    forceambientroom("");
    self thread function_9b30fbf4();
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// namespace_215602b6<file_0>::function_f61ba6c8
// Checksum 0x3c2397f0, Offset: 0x3188
// Size: 0x118
function function_f61ba6c8() {
    level endon(#"hash_dbd2b3ab");
    self endon(#"entityshutdown");
    if (!isdefined(level.var_4e467911)) {
        level.var_4e467911 = spawn(0, (0, 0, 0), "script_origin");
        soundid = level.var_4e467911 playloopsound("zmb_beastmode_mana_looper", 2);
        setsoundvolume(soundid, 0);
    }
    while (true) {
        if (isdefined(self.mana)) {
            if (self.mana <= 0.5) {
                volume = 0.51 - self.mana;
                if (isdefined(soundid)) {
                    setsoundvolume(soundid, volume);
                }
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_215602b6
// Params 0, eflags: 0x0
// namespace_215602b6<file_0>::function_9b30fbf4
// Checksum 0x12619a13, Offset: 0x32a8
// Size: 0x46
function function_9b30fbf4() {
    level notify(#"hash_dbd2b3ab");
    if (isdefined(level.var_4e467911)) {
        level.var_4e467911 delete();
        level.var_4e467911 = undefined;
    }
}

// Namespace namespace_215602b6
// Params 1, eflags: 0x0
// namespace_215602b6<file_0>::function_14637ad2
// Checksum 0xeb78a48d, Offset: 0x32f8
// Size: 0x3e
function function_14637ad2(localclientnum) {
    if (isdefined(self.var_a4e22c06)) {
        stopfx(localclientnum, self.var_a4e22c06);
        self.var_a4e22c06 = undefined;
    }
}

// Namespace namespace_215602b6
// Params 2, eflags: 0x0
// namespace_215602b6<file_0>::function_2a7bb7b3
// Checksum 0xbdd54bdc, Offset: 0x3340
// Size: 0x1f8
function function_2a7bb7b3(localclientnum, on_off) {
    self notify(#"hash_2a7bb7b3");
    self endon(#"hash_2a7bb7b3");
    function_14637ad2(localclientnum);
    if (on_off) {
        while (isdefined(self)) {
            lcn, note = level waittill(#"notetrack");
            if (note == "shock_loop") {
                function_14637ad2(localclientnum);
                charge = getweaponchargelevel(localclientnum);
                switch (charge) {
                case 2:
                    self.var_a4e22c06 = playviewmodelfx(localclientnum, level._effect["beast_fork_2"], "tag_flash_le");
                    break;
                case 3:
                    self.var_a4e22c06 = playviewmodelfx(localclientnum, level._effect["beast_fork_3"], "tag_flash_le");
                    break;
                case 1:
                default:
                    self.var_a4e22c06 = playviewmodelfx(localclientnum, level._effect["beast_fork_1"], "tag_flash_le");
                    break;
                }
                self function_2d565c0(localclientnum, charge);
                continue;
            }
            if (note == "shock_loop_end") {
                function_14637ad2(localclientnum);
            }
        }
    }
}

// Namespace namespace_215602b6
// Params 2, eflags: 0x0
// namespace_215602b6<file_0>::function_2d565c0
// Checksum 0x54dfa2e9, Offset: 0x3540
// Size: 0xec
function function_2d565c0(localclientnum, charge) {
    time = 0.85;
    var_c6eef0d = 0;
    var_49d2fa23 = 1;
    switch (charge) {
    default:
        time = 2;
        break;
    case 1:
        time = 0.5;
        break;
    case 2:
        time = 0.25;
        break;
    case 3:
        time = 0.15;
        break;
    }
    self thread function_892cc334(localclientnum, time, var_c6eef0d, var_49d2fa23, charge);
}

// Namespace namespace_215602b6
// Params 5, eflags: 0x0
// namespace_215602b6<file_0>::function_892cc334
// Checksum 0x76fec9a1, Offset: 0x3638
// Size: 0x160
function function_892cc334(localclientnum, time, var_c6eef0d, var_49d2fa23, charge) {
    self notify(#"hash_892cc334");
    self endon(#"hash_892cc334");
    self endon(#"hash_dd954547");
    if (!isdefined(self.var_652e98)) {
        self.var_652e98 = 0;
    }
    while (isdefined(self)) {
        self.var_652e98 += 0.016;
        if (self.var_652e98 > time) {
            self.var_652e98 -= time;
        }
        val = lerpfloat(var_c6eef0d, var_49d2fa23, self.var_652e98 / time);
        self setarmpulseposition(val);
        if (charge != getweaponchargelevel(localclientnum)) {
            self function_2d565c0(localclientnum, getweaponchargelevel(localclientnum));
        }
        wait(0.016);
    }
}

/#

    // Namespace namespace_215602b6
    // Params 0, eflags: 0x0
    // namespace_215602b6<file_0>::function_ac7706bc
    // Checksum 0xbb7b6d6b, Offset: 0x37a0
    // Size: 0x2dc
    function function_ac7706bc() {
        self notify(#"hash_ac7706bc");
        self endon(#"hash_ac7706bc");
        if (!isdefined(self.var_652e98)) {
            self.var_652e98 = 0;
        }
        while (isdefined(self)) {
            if (getdvarint("<unknown string>") > 0) {
                self notify(#"hash_892cc334");
                time = getdvarfloat("<unknown string>");
                speed = getdvarfloat("<unknown string>");
                pulse = getdvarfloat("<unknown string>");
                if (time > 0) {
                    self setarmpulse(time, speed, pulse, "<unknown string>");
                    wait(time);
                } else {
                    wait(0.016);
                }
                continue;
            }
            if (getdvarint("<unknown string>") > 0) {
                self notify(#"hash_892cc334");
                pos = getdvarfloat("<unknown string>");
                self setarmpulseposition(pos);
                wait(0.016);
                continue;
            }
            if (getdvarint("<unknown string>") > 0) {
                self notify(#"hash_892cc334");
                time = getdvarfloat("<unknown string>");
                var_c6eef0d = getdvarfloat("<unknown string>");
                var_49d2fa23 = getdvarfloat("<unknown string>");
                self.var_652e98 += 0.016;
                if (self.var_652e98 > time) {
                    self.var_652e98 -= time;
                }
                val = lerpfloat(var_c6eef0d, var_49d2fa23, self.var_652e98 / time);
                self setarmpulseposition(val);
                wait(0.016);
                continue;
            }
            wait(0.016);
        }
    }

#/

// Namespace namespace_215602b6
// Params 4, eflags: 0x0
// namespace_215602b6<file_0>::function_55af4b5b
// Checksum 0xc2cbff8d, Offset: 0x3a88
// Size: 0x54
function function_55af4b5b(player, tag, pivot, delay) {
    player endon(#"hash_2f0976f1");
    wait(delay);
    thread grapple_beam(player, tag, pivot);
}

// Namespace namespace_215602b6
// Params 3, eflags: 0x0
// namespace_215602b6<file_0>::function_1de33e08
// Checksum 0xf46c7c5b, Offset: 0x3ae8
// Size: 0x8c
function grapple_beam(player, tag, pivot) {
    level beam::launch(player, tag, pivot, "tag_origin", "zod_beast_grapple_beam");
    player waittill(#"hash_2f0976f1");
    level beam::kill(player, tag, pivot, "tag_origin", "zod_beast_grapple_beam");
}

// Namespace namespace_215602b6
// Params 3, eflags: 0x0
// namespace_215602b6<file_0>::function_b25c9962
// Checksum 0x1062b659, Offset: 0x3b80
// Size: 0x19a
function function_b25c9962(onoff, tag, delay) {
    if (!isdefined(tag)) {
        tag = "tag_flash";
    }
    if (!isdefined(delay)) {
        delay = 0.15;
    }
    self notify(#"hash_2f0976f1");
    self notify(#"hash_b25c9962");
    self endon(#"hash_b25c9962");
    if (onoff) {
        while (isdefined(self)) {
            pivot = self waittill(#"grapple_beam_on");
            var_1e66ebb1 = tag;
            /#
                if (getdvarint("bmplayer") > 0) {
                    var_1e66ebb1 = "<unknown string>";
                }
            #/
            if (isdefined(pivot) && !pivot isplayer()) {
                thread function_55af4b5b(self, var_1e66ebb1, pivot, delay);
            }
            evt = self util::function_183e3618(7.5, "grapple_pulled", "grapple_landed", "grapple_cancel", "grapple_beam_off", "grapple_watch", "disconnect");
            self notify(#"hash_2f0976f1");
        }
    }
}

// Namespace namespace_215602b6
// Params 2, eflags: 0x0
// namespace_215602b6<file_0>::function_4778b020
// Checksum 0x4780dd3a, Offset: 0x3d28
// Size: 0x96
function function_4778b020(lo, hi) {
    color = (randomfloatrange(lo[0], hi[0]), randomfloatrange(lo[1], hi[1]), randomfloatrange(lo[2], hi[2]));
    return color;
}

// Namespace namespace_215602b6
// Params 3, eflags: 0x0
// namespace_215602b6<file_0>::function_4b2bbece
// Checksum 0x3cfedac2, Offset: 0x3dc8
// Size: 0xaa
function function_4b2bbece(var_3ae5c24, var_1bfa7cb7, frac) {
    var_8df9803f = 1 - frac;
    color = (var_8df9803f * var_3ae5c24[0] + frac * var_1bfa7cb7[0], var_8df9803f * var_3ae5c24[1] + frac * var_1bfa7cb7[1], var_8df9803f * var_3ae5c24[2] + frac * var_1bfa7cb7[2]);
    return color;
}

// Namespace namespace_215602b6
// Params 2, eflags: 0x0
// namespace_215602b6<file_0>::function_89d6f49a
// Checksum 0xee1f3fd6, Offset: 0x3e80
// Size: 0x1e2
function function_89d6f49a(localclientnum, onoff) {
    self notify(#"hash_89d6f49a");
    self endon(#"hash_89d6f49a");
    if (!onoff) {
        self setcontrollerlightbarcolor(localclientnum);
        self.controllercolor = undefined;
        return;
    }
    if (isdemoplaying()) {
        return;
    }
    var_781fc232 = (63, 103, 4) / -1;
    var_27745be8 = (105, -108, 24) / -1;
    var_d7805253 = 2;
    var_ec055171 = 0.25;
    var_c051243b = var_d7805253;
    old_color = function_4778b020(var_781fc232, var_27745be8);
    new_color = old_color;
    while (isdefined(self)) {
        if (var_c051243b >= var_d7805253) {
            old_color = new_color;
            new_color = function_4778b020(var_781fc232, var_27745be8);
            var_c051243b = 0;
        }
        color = function_4b2bbece(old_color, new_color, var_c051243b / var_d7805253);
        self setcontrollerlightbarcolor(localclientnum, color);
        self.controllercolor = color;
        var_c051243b += var_ec055171;
        wait(var_ec055171);
    }
}

// Namespace namespace_215602b6
// Params 7, eflags: 0x0
// namespace_215602b6<file_0>::function_b2532c75
// Checksum 0x8404d992, Offset: 0x4070
// Size: 0x9c
function function_b2532c75(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (util::is_mature() && !util::is_gib_restricted_build()) {
        playfxontag(localclientnum, level._effect["beast_melee_kill"], self, "j_spineupper");
    }
}

// Namespace namespace_215602b6
// Params 7, eflags: 0x0
// namespace_215602b6<file_0>::function_46405286
// Checksum 0x2df04b7a, Offset: 0x4118
// Size: 0x9c
function function_46405286(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (util::is_mature() && !util::is_gib_restricted_build()) {
        playfxontag(localclientnum, level._effect["beast_grapple_kill"], self, "j_spineupper");
    }
}

