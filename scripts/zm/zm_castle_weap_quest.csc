#using scripts/zm/_filter;
#using scripts/shared/exploder_shared;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#using_animtree("zm_castle");

#namespace namespace_2a78f3c;

// Namespace namespace_2a78f3c
// Params 0, eflags: 0x2
// Checksum 0x62117a76, Offset: 0x878
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_castle_weap_quest", &__init__, undefined, undefined);
}

// Namespace namespace_2a78f3c
// Params 0, eflags: 0x0
// Checksum 0xa87e869f, Offset: 0x8b8
// Size: 0x13c
function __init__() {
    level.var_f302359b = struct::get_array("dragon_position", "targetname");
    clientfield::register("actor", "make_client_clone", 5000, 4, "int", &function_90c151e6, 0, 0);
    for (i = 0; i < level.var_f302359b.size; i++) {
        clientfield::register("world", level.var_f302359b[i].script_parameters, 5000, 3, "int", &function_cda3a15d, 0, 0);
    }
    clientfield::register("toplayer", "bow_pickup_fx", 5000, 1, "int", &function_4e75b7c1, 0, 0);
}

// Namespace namespace_2a78f3c
// Params 0, eflags: 0x0
// Checksum 0xa1bd4bc4, Offset: 0xa00
// Size: 0x6e4
function main() {
    level._effect["bow_spawn_fx"] = "dlc1/castle/fx_plinth_pick_up_base_bow";
    level._effect["mini_dragon_fire"] = "dlc1/castle/fx_dragon_head_mouth_fire_sm";
    level._effect["mini_dragon_eye"] = "dlc1/castle/fx_dragon_head_eye_glow_sm";
    level.var_b86a93ed = "cin_t7_ai_zm_dlc1_dragonhead_static";
    level.var_dd277883 = "cin_t7_ai_zm_dlc1_dragonhead_intro";
    level.var_160f7e80 = "cin_t7_zm_dlc1_dragonhead_depart";
    level.var_a79e1598 = [];
    level.var_a79e1598["dragonhead_1"] = "p7_fxanim_zm_castle_dragon_crumble_undercroft_bundle";
    level.var_a79e1598["dragonhead_2"] = "p7_fxanim_zm_castle_dragon_crumble_courtyard_bundle";
    level.var_a79e1598["dragonhead_3"] = "p7_fxanim_zm_castle_dragon_crumble_greathall_bundle";
    level.var_c7a1f434 = [];
    level.var_c7a1f434["right"] = "cin_t7_ai_zm_dlc1_dragonhead_pre_eat_r";
    level.var_c7a1f434["left"] = "cin_t7_ai_zm_dlc1_dragonhead_pre_eat_l";
    level.var_c7a1f434["front"] = "cin_t7_ai_zm_dlc1_dragonhead_pre_eat_f";
    level.var_c7a1f434["left_2_right"] = "cin_t7_ai_zm_dlc1_dragonhead_pre_eat_l_2_r";
    level.var_c7a1f434["right_2_left"] = "cin_t7_ai_zm_dlc1_dragonhead_pre_eat_r_2_l";
    level.var_977975d2 = [];
    level.var_977975d2["right"] = "cin_t7_ai_zm_dlc1_dragonhead_consume_r";
    level.var_977975d2["left"] = "cin_t7_ai_zm_dlc1_dragonhead_consume_l";
    level.var_977975d2["front"] = "cin_t7_ai_zm_dlc1_dragonhead_consume_f";
    level.var_d198ed8e = [];
    level.var_d198ed8e["right"] = zm_castle%rtrg_ai_zm_dlc1_dragonhead_consume_zombie_align_r;
    level.var_d198ed8e["left"] = zm_castle%rtrg_ai_zm_dlc1_dragonhead_consume_zombie_align_l;
    level.var_d198ed8e["front"] = zm_castle%rtrg_ai_zm_dlc1_dragonhead_consume_zombie_align_f;
    level.var_93ad1521 = [];
    level.var_93ad1521[0] = "cin_t7_ai_zm_dlc1_dragonhead_idle";
    level.var_93ad1521[1] = "cin_t7_ai_zm_dlc1_dragonhead_idle_b";
    level.var_16db17aa = [];
    level.var_16db17aa[0] = "cin_t7_ai_zm_dlc1_dragonhead_idle_twitch_roar";
    scene::add_scene_func(level.var_93ad1521[0], &function_8cce2397);
    scene::add_scene_func(level.var_93ad1521[1], &function_8cce2397);
    scene::add_scene_func(level.var_16db17aa[0], &function_def5820e);
    level.var_f41bc81e = zm_castle%ai_zm_dlc1_dragonhead_zombie_impact;
    function_46c9cb0();
    util::waitforallclients();
    wait(1);
    level.var_792780c0 = [];
    level.var_3cc6503b = [];
    level.var_abd9e961 = [];
    players = getlocalplayers();
    for (j = 0; j < players.size; j++) {
        level.var_792780c0[j] = [];
        level.var_3cc6503b[j] = [];
        level.var_abd9e961[j] = [];
        for (i = 0; i < level.var_f302359b.size; i++) {
            level.var_792780c0[j][level.var_f302359b[i].script_parameters] = getent(j, level.var_f302359b[i].script_label, "targetname");
            level.var_792780c0[j][level.var_f302359b[i].script_parameters] useanimtree(#zm_castle);
            level.var_792780c0[j][level.var_f302359b[i].script_parameters] flag::init("dragon_far_right");
            level.var_792780c0[j][level.var_f302359b[i].script_parameters] flag::init("dragon_far_left");
            level.var_792780c0[j][level.var_f302359b[i].script_parameters].var_7d382bfa = 1;
            level.var_3cc6503b[j][level.var_f302359b[i].script_parameters] = getent(j, level.var_f302359b[i].script_friendname, "targetname");
            level.var_3cc6503b[j][level.var_f302359b[i].script_parameters] hide();
            level.var_3cc6503b[j][level.var_f302359b[i].script_parameters] useanimtree(#zm_castle);
            level.var_abd9e961[j][level.var_f302359b[i].script_parameters] = getent(j, level.var_f302359b[i].script_label + "_mini", "targetname");
        }
        array::run_all(level.var_abd9e961[j], &function_c9ca8c4b, j);
    }
    level.var_ab74f2fa = 1;
}

// Namespace namespace_2a78f3c
// Params 7, eflags: 0x0
// Checksum 0x9156a2ab, Offset: 0x10f0
// Size: 0x5e4
function function_cda3a15d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    while (!isdefined(level.var_ab74f2fa)) {
        wait(0.05);
    }
    if (newval == 7) {
        if (isdefined(level.var_792780c0[localclientnum][fieldname])) {
            level.var_792780c0[localclientnum][fieldname] thread function_a5ee5367(localclientnum);
        }
        return;
    }
    if (newval == 1) {
        level.var_3cc6503b[localclientnum][fieldname] hide();
        if (isdefined(level.var_792780c0[localclientnum][fieldname])) {
            level.var_792780c0[localclientnum][fieldname] show();
            level.var_792780c0[localclientnum][fieldname] thread function_2731927f(localclientnum);
            level.var_792780c0[localclientnum][fieldname] scene::play(level.var_dd277883, level.var_792780c0[localclientnum][fieldname]);
        }
        return;
    }
    if (newval == 2) {
        level.var_3cc6503b[localclientnum][fieldname] hide();
        if (isdefined(level.var_3cc6503b[localclientnum][fieldname].head)) {
            if (isdefined(level.var_3cc6503b[localclientnum][fieldname].head.hat)) {
                level.var_3cc6503b[localclientnum][fieldname].head.hat hide();
            }
            level.var_3cc6503b[localclientnum][fieldname].head hide();
        }
        if (isdefined(level.var_792780c0[localclientnum][fieldname])) {
            level.var_792780c0[localclientnum][fieldname] show();
            level.var_792780c0[localclientnum][fieldname] thread dragonhead_idle(localclientnum);
        }
        return;
    }
    if (newval == 3 || newval == 5 || newval == 4) {
        if (isdefined(level.var_792780c0[localclientnum][fieldname])) {
            level.var_792780c0[localclientnum][fieldname] show();
            if (newval == 3) {
                level.var_792780c0[localclientnum][fieldname] thread function_4ae89880(level.var_3cc6503b[localclientnum][fieldname], localclientnum, "front");
            } else if (newval == 4) {
                level.var_792780c0[localclientnum][fieldname] thread function_4ae89880(level.var_3cc6503b[localclientnum][fieldname], localclientnum, "right");
            } else {
                level.var_792780c0[localclientnum][fieldname] thread function_4ae89880(level.var_3cc6503b[localclientnum][fieldname], localclientnum, "left");
            }
        }
        return;
    }
    if (newval == 6) {
        level.var_3cc6503b[localclientnum][fieldname] hide();
        if (isdefined(level.var_3cc6503b[localclientnum][fieldname].head)) {
            if (isdefined(level.var_3cc6503b[localclientnum][fieldname].head.hat)) {
                level.var_3cc6503b[localclientnum][fieldname].head.hat hide();
            }
            level.var_3cc6503b[localclientnum][fieldname].head hide();
        }
        if (isdefined(level.var_792780c0[localclientnum][fieldname])) {
            level.var_792780c0[localclientnum][fieldname] show();
            level.var_792780c0[localclientnum][fieldname] thread function_aba7532b(localclientnum, level.var_3cc6503b[localclientnum][fieldname], level.var_abd9e961[localclientnum][fieldname]);
        }
        return;
    }
    if (newval == 0) {
        level.var_792780c0[localclientnum][fieldname] thread function_8e438650();
    }
}

// Namespace namespace_2a78f3c
// Params 1, eflags: 0x0
// Checksum 0xf06bfb33, Offset: 0x16e0
// Size: 0x8c
function function_2731927f(localclientnum) {
    forcestreamxmodel("c_zom_dragonhead_e");
    self function_c54660fa(localclientnum);
    self setmodel("c_zom_dragonhead_e");
    stopforcestreamingxmodel("c_zom_dragonhead_e");
    self thread function_aa74062f(localclientnum);
}

// Namespace namespace_2a78f3c
// Params 1, eflags: 0x0
// Checksum 0x65efc1b9, Offset: 0x1778
// Size: 0x208
function function_c54660fa(localclientnum) {
    n_start_time = gettime();
    n_end_time = n_start_time + 3.6 * 1000;
    var_2f4dbfb7 = n_start_time + 0.5 * 1000;
    b_is_updating = 1;
    while (b_is_updating) {
        n_time = gettime();
        if (n_time >= n_end_time) {
            n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_end_time);
            b_is_updating = 0;
        } else {
            n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_time);
        }
        if (n_time >= var_2f4dbfb7) {
            var_da3d41af = mapfloat(n_start_time, var_2f4dbfb7, 0, 3, var_2f4dbfb7);
        } else {
            var_da3d41af = mapfloat(n_start_time, var_2f4dbfb7, 0, 3, n_time);
        }
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, var_da3d41af, 0);
        self mapshaderconstant(localclientnum, 0, "scriptVector0", n_shader_value, 0, 0);
        wait(0.01);
    }
}

// Namespace namespace_2a78f3c
// Params 1, eflags: 0x0
// Checksum 0x46aec7d, Offset: 0x1988
// Size: 0x160
function function_2ea674b8(localclientnum) {
    n_start_time = gettime();
    n_end_time = n_start_time + 7 * 1000;
    b_is_updating = 1;
    while (b_is_updating && isdefined(self)) {
        n_time = gettime();
        if (n_time >= n_end_time) {
            n_shader_value = mapfloat(n_start_time, n_end_time, 0, 1, n_end_time);
            b_is_updating = 0;
        } else {
            n_shader_value = mapfloat(n_start_time, n_end_time, 0, 1, n_time);
        }
        self mapshaderconstant(localclientnum, 0, "scriptVector0", n_shader_value, 0, 0);
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0);
        wait(0.01);
    }
}

// Namespace namespace_2a78f3c
// Params 1, eflags: 0x0
// Checksum 0x95f0896e, Offset: 0x1af0
// Size: 0x130
function function_aa74062f(localclientnum) {
    n_start_time = gettime();
    n_end_time = n_start_time + 5 * 1000;
    b_is_updating = 1;
    while (b_is_updating) {
        n_time = gettime();
        if (n_time >= n_end_time) {
            n_shader_value = mapfloat(n_start_time, n_end_time, 0, 2, n_end_time);
            b_is_updating = 0;
        } else {
            n_shader_value = mapfloat(n_start_time, n_end_time, 0, 2, n_time);
        }
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
        wait(0.01);
    }
}

// Namespace namespace_2a78f3c
// Params 1, eflags: 0x0
// Checksum 0x113ab1a7, Offset: 0x1c28
// Size: 0x54
function function_a5ee5367(localclientnum) {
    self mapshaderconstant(localclientnum, 0, "scriptVector0", 1, 0, 0);
    self thread scene::play(level.var_b86a93ed, self);
}

// Namespace namespace_2a78f3c
// Params 1, eflags: 0x0
// Checksum 0xfd1e4ed3, Offset: 0x1c88
// Size: 0xe0
function dragonhead_idle(localclientnum) {
    self endon(#"hash_4b8a9b1");
    self endon(#"hash_4846b79f");
    self notify(#"hash_8c17cec");
    if (isdefined(self.var_d90397ef) && self.var_d90397ef) {
        return;
    }
    self.var_d90397ef = 1;
    while (true) {
        var_68e7aa53 = array::random(level.var_93ad1521);
        self scene::play(var_68e7aa53, self);
        var_c5577e8a = array::random(level.var_16db17aa);
        self scene::play(var_c5577e8a, self);
    }
}

// Namespace namespace_2a78f3c
// Params 7, eflags: 0x0
// Checksum 0xb10c46ac, Offset: 0x1d70
// Size: 0x29e
function function_90c151e6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    if (!self hasdobj(localclientnum)) {
        self util::waittill_dobj(localclientnum);
        wait(0.016);
    }
    while (!isdefined(level.var_ab74f2fa)) {
        wait(0.05);
    }
    if (!isdefined(self)) {
        return;
    }
    s_closest = array::get_all_closest(self.origin, level.var_f302359b);
    fieldname = s_closest[0].script_parameters;
    var_22c286f9 = level.var_3cc6503b[localclientnum][fieldname];
    if (isdefined(var_22c286f9)) {
        var_22c286f9 delete();
        var_22c286f9 = gibclientutils::createscriptmodelofentity(localclientnum, self);
        if (issubstr(var_22c286f9.model, "skeleton")) {
            var_22c286f9 hidepart(localclientnum, "tag_weapon_left");
            var_22c286f9 hidepart(localclientnum, "tag_weapon_right");
        }
        var_22c286f9 gibclientutils::handlegibnotetracks(localclientnum);
        level.var_3cc6503b[localclientnum][fieldname] = var_22c286f9;
    }
    var_22c286f9 useanimtree(#zm_castle);
    var_22c286f9.origin = self.origin;
    var_22c286f9 show();
    var_22c286f9 clearanim(zm_castle%root, 0.1);
    var_22c286f9 setanimrestart(level.var_f41bc81e, 1, 0.2, 1);
    var_427f919 = getanimlength(level.var_f41bc81e) / 1;
}

// Namespace namespace_2a78f3c
// Params 4, eflags: 0x0
// Checksum 0xaadb632a, Offset: 0x2018
// Size: 0x1bc
function function_4bdc99a(var_22c286f9, var_e88629ec, localclientnum, direction) {
    /#
        iprintlnbold("dragon_far_right" + direction);
    #/
    var_3b282900 = level.var_c7a1f434[direction];
    if (var_e88629ec flag::get("dragon_far_left") && direction == "right") {
        var_3b282900 = level.var_c7a1f434["left_2_right"];
    } else if (var_e88629ec flag::get("dragon_far_right") && direction == "left") {
        var_3b282900 = level.var_c7a1f434["right_2_left"];
    }
    s_scenedef = struct::get_script_bundle("scene", var_3b282900);
    var_3c6f5c75 = s_scenedef.objects[0].mainanim;
    var_22c286f9 unlink();
    var_22c286f9 show();
    var_22c286f9 thread function_939ae9de(var_e88629ec, localclientnum, direction, var_3c6f5c75);
    var_e88629ec scene::play(var_3b282900, var_e88629ec);
}

// Namespace namespace_2a78f3c
// Params 1, eflags: 0x0
// Checksum 0x63737e2d, Offset: 0x21e0
// Size: 0x110
function function_8cce2397(a_ents) {
    self notify(#"hash_7291a140");
    self endon(#"hash_7291a140");
    self endon(#"hash_4b8a9b1");
    self endon(#"hash_4846b79f");
    while (true) {
        self waittillmatch(#"_anim_notify_", "dragon_side");
        self flag::set("dragon_far_right");
        self waittillmatch(#"_anim_notify_", "dragon_side");
        self flag::clear("dragon_far_right");
        self waittillmatch(#"_anim_notify_", "dragon_side");
        self flag::set("dragon_far_left");
        self waittillmatch(#"_anim_notify_", "dragon_side");
        self flag::clear("dragon_far_left");
    }
}

// Namespace namespace_2a78f3c
// Params 1, eflags: 0x0
// Checksum 0x9ffb944, Offset: 0x22f8
// Size: 0x110
function function_def5820e(a_ents) {
    self notify(#"hash_7291a140");
    self endon(#"hash_7291a140");
    self endon(#"hash_4b8a9b1");
    self endon(#"hash_4846b79f");
    while (true) {
        self waittillmatch(#"_anim_notify_", "dragon_side");
        self flag::set("dragon_far_left");
        self waittillmatch(#"_anim_notify_", "dragon_side");
        self flag::clear("dragon_far_left");
        self waittillmatch(#"_anim_notify_", "dragon_side");
        self flag::set("dragon_far_right");
        self waittillmatch(#"_anim_notify_", "dragon_side");
        self flag::clear("dragon_far_right");
    }
}

// Namespace namespace_2a78f3c
// Params 4, eflags: 0x0
// Checksum 0xd7f1e87b, Offset: 0x2410
// Size: 0x386
function function_939ae9de(var_e88629ec, localclientnum, direction, var_3c6f5c75) {
    if (!isdefined(self.var_bbb1ef87)) {
        self.var_bbb1ef87 = spawn(localclientnum, self gettagorigin("J_SpineLower"), "script_model");
        self.var_bbb1ef87 setmodel("tag_origin");
    }
    self clearanim(zm_castle%root, 0.2);
    self setanimrestart("ai_zm_dlc1_dragonhead_zombie_rise");
    vec_dir = var_e88629ec.origin - self.origin;
    var_6ea7737a = vectorscale(vec_dir, 0.2);
    self.var_bbb1ef87.angles = vectortoangles(vec_dir);
    self.var_bbb1ef87 linkto(self);
    wait(0.3);
    if (!isdefined(self)) {
        return;
    }
    animlength = getanimlength(var_3c6f5c75);
    animlength -= animlength * var_e88629ec getanimtime(var_3c6f5c75);
    animlength = max(animlength, 0.05);
    self moveto(self.origin + var_6ea7737a, animlength * 0.75, animlength * 0.75, 0);
    var_31e7de73 = var_e88629ec gettagangles("tag_attach");
    self rotateto(var_31e7de73, animlength * 0.75);
    self waittill(#"movedone");
    animlength = getanimlength(var_3c6f5c75);
    animlength -= animlength * var_e88629ec getanimtime(var_3c6f5c75);
    animlength = max(animlength, 0.05);
    var_6b61dff7 = var_e88629ec gettagorigin("tag_attach");
    self moveto(var_6b61dff7, animlength, animlength, 0);
    self waittill(#"movedone");
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(self.var_bbb1ef87)) {
        self.var_bbb1ef87 unlink();
        self.var_bbb1ef87 delete();
        self.var_bbb1ef87 = undefined;
    }
}

// Namespace namespace_2a78f3c
// Params 3, eflags: 0x0
// Checksum 0x9f166a76, Offset: 0x27a0
// Size: 0x224
function function_4ae89880(body, localclientnum, direction) {
    self endon(#"hash_8c17cec");
    self endon(#"hash_4846b79f");
    self notify(#"hash_4b8a9b1");
    self.var_d90397ef = 0;
    s_closest = array::get_all_closest(self.origin, level.var_f302359b);
    fieldname = s_closest[0].script_parameters;
    var_22c286f9 = level.var_3cc6503b[localclientnum][fieldname];
    var_e88629ec = level.var_792780c0[localclientnum][fieldname];
    level function_4bdc99a(var_22c286f9, var_e88629ec, localclientnum, direction);
    if (!isdefined(var_e88629ec) || !isdefined(var_22c286f9)) {
        return;
    }
    var_22c286f9.animname = "zombie";
    var_e88629ec.animname = "dragon";
    self thread function_badc23de(localclientnum);
    self scene::play(level.var_977975d2[direction], array(var_22c286f9, var_e88629ec));
    if (!isdefined(var_e88629ec) || !isdefined(var_22c286f9)) {
        return;
    }
    var_22c286f9.animname = "";
    var_e88629ec.animname = "";
    playsound(0, "zmb_weap_wall", var_e88629ec.origin);
    var_e88629ec thread dragonhead_idle(localclientnum);
}

// Namespace namespace_2a78f3c
// Params 1, eflags: 0x0
// Checksum 0xfec7b7a0, Offset: 0x29d0
// Size: 0x54
function function_badc23de(localclientnum) {
    while (true) {
        note = self waittill(#"hash_d4c1c307");
        if (note == "blood") {
            continue;
        }
        if (note == "blood_sm") {
        }
    }
}

// Namespace namespace_2a78f3c
// Params 3, eflags: 0x0
// Checksum 0xb361205c, Offset: 0x2a30
// Size: 0x18c
function function_aba7532b(localclientnum, body, var_ec7bd060) {
    if (isdefined(self.var_7d382bfa) && self.var_7d382bfa) {
        self notify(#"hash_4846b79f");
        self.var_7d382bfa = undefined;
        var_1656bbd4 = level.var_a79e1598[self.targetname];
        self.var_d90397ef = 0;
        forcestreambundle(level.var_a79e1598[self.targetname]);
        self setmodel("c_zom_dragonhead");
        self thread function_2ea674b8(localclientnum);
        self scene::play(level.var_160f7e80, self);
        var_ec7bd060 thread function_63f39fc0(localclientnum);
        self thread scene::play(var_1656bbd4);
        if (isdefined(self)) {
            self hide();
        }
        stopforcestreamingxmodel("p7_fxanim_zm_castle_dragon_chunks_mod");
        stopforcestreamingxmodel("c_zom_dragonhead");
        return;
    }
    if (isdefined(self)) {
        self hide();
    }
}

// Namespace namespace_2a78f3c
// Params 1, eflags: 0x0
// Checksum 0x1fab82b, Offset: 0x2bc8
// Size: 0x34
function function_c9ca8c4b(localclientnum) {
    self mapshaderconstant(localclientnum, 0, "scriptVector0", 1, 0, 0);
}

// Namespace namespace_2a78f3c
// Params 1, eflags: 0x0
// Checksum 0x3cd014e3, Offset: 0x2c08
// Size: 0x128
function function_63f39fc0(localclientnum) {
    forcestreamxmodel("c_zom_dragonhead_small_e");
    self function_c54660fa(localclientnum);
    self setmodel("c_zom_dragonhead_small_e");
    stopforcestreamingxmodel("c_zom_dragonhead_small_e");
    self function_aa74062f(localclientnum);
    playfxontag(localclientnum, level._effect["mini_dragon_eye"], self, "tag_eye_left_fx");
    while (true) {
        wait(randomintrange(20, 40));
        playfxontag(localclientnum, level._effect["mini_dragon_fire"], self, "tag_throat_fx");
        wait(randomintrange(3, 5));
    }
}

// Namespace namespace_2a78f3c
// Params 0, eflags: 0x0
// Checksum 0x8ec37435, Offset: 0x2d38
// Size: 0x62
function function_46c9cb0() {
    level.var_9c6cddc9[1] = "c_zom_der_zombie_head1";
    level.var_9c6cddc9[2] = "c_zom_der_zombie_head1";
    level.var_9c6cddc9[3] = "c_zom_der_zombie_head1";
    level.var_9c6cddc9[4] = "c_zom_der_zombie_head1";
}

// Namespace namespace_2a78f3c
// Params 0, eflags: 0x0
// Checksum 0x8943ac47, Offset: 0x2da8
// Size: 0x34
function function_8e438650() {
    forcestreamxmodel("p7_fxanim_zm_castle_dragon_chunks_mod");
    forcestreamxmodel("c_zom_dragonhead");
}

// Namespace namespace_2a78f3c
// Params 7, eflags: 0x0
// Checksum 0x784f4360, Offset: 0x2de8
// Size: 0xec
function function_4e75b7c1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        exploder::exploder("lgt_bow_family");
    } else {
        exploder::stop_exploder("lgt_bow_family");
    }
    var_14ea0734 = struct::get("base_bow_pickup_struct", "targetname");
    if (isdefined(var_14ea0734)) {
        playfx(localclientnum, level._effect["bow_spawn_fx"], var_14ea0734.origin);
    }
}

