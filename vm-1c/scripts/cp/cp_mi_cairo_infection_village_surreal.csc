#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_skipto;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace namespace_4e2074f4;

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0x9b4262e3, Offset: 0x370
// Size: 0x14
function main() {
    init_clientfields();
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0xd30126ec, Offset: 0x390
// Size: 0x244
function init_clientfields() {
    clientfield::register("world", "infection_fold_debris_1", 1, 1, "counter", &infection_fold_debris_1, 0, 0);
    clientfield::register("world", "infection_fold_debris_2", 1, 1, "int", &infection_fold_debris_2, 0, 1);
    clientfield::register("world", "infection_fold_debris_3", 1, 1, "int", &infection_fold_debris_3, 0, 1);
    clientfield::register("world", "infection_fold_debris_4", 1, 1, "int", &infection_fold_debris_4, 0, 1);
    clientfield::register("world", "light_church_ext_window", 1, 1, "int", &function_b21f76c4, 0, 1);
    clientfield::register("world", "kill_light_church_ext_window", 1, 1, "int", &function_ba29b6bb, 0, 1);
    clientfield::register("world", "light_church_int_all", 1, 1, "int", &function_92fbb98f, 0, 0);
    clientfield::register("world", "dynent_catcher", 1, 1, "int", &function_826e310e, 0, 0);
}

// Namespace namespace_4e2074f4
// Params 7, eflags: 0x0
// Checksum 0x7821b802, Offset: 0x5e0
// Size: 0x64
function infection_fold_debris_1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread fold_debris(localclientnum, 1);
    }
}

// Namespace namespace_4e2074f4
// Params 7, eflags: 0x0
// Checksum 0x478096da, Offset: 0x650
// Size: 0x74
function infection_fold_debris_2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval != newval && newval != 0) {
        level thread fold_debris(localclientnum, 2);
    }
}

// Namespace namespace_4e2074f4
// Params 7, eflags: 0x0
// Checksum 0x280e61f0, Offset: 0x6d0
// Size: 0x74
function infection_fold_debris_3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval != newval && newval != 0) {
        level thread fold_debris(localclientnum, 3);
    }
}

// Namespace namespace_4e2074f4
// Params 7, eflags: 0x0
// Checksum 0x7321bd90, Offset: 0x750
// Size: 0x74
function infection_fold_debris_4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval != newval && newval != 0) {
        level thread fold_debris(localclientnum, 4);
    }
}

// Namespace namespace_4e2074f4
// Params 7, eflags: 0x0
// Checksum 0x20eb57cd, Offset: 0x7d0
// Size: 0x15e
function function_b21f76c4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_aace7bde = skipto::function_8b19ec5d();
    if (isdefined(var_aace7bde) && var_aace7bde.size > 0) {
        switch (var_aace7bde[0]) {
        case "black_station":
        case "forest_intro":
        case "forest_sky_bridge":
        case "forest_surreal":
        case "forest_tunnel":
        case "forest_wolves":
        case "sgen_server_room":
        case "village":
        case "village_house":
        case "village_inception":
            if (bnewent) {
                level thread function_fac6ef5e(localclientnum);
            } else if (!binitialsnap) {
                if (newval != oldval && newval == 1) {
                    exploder::exploder("light_church_ext_window");
                } else {
                    exploder::stop_exploder("light_church_ext_window");
                }
            }
        default:
            break;
        }
    }
}

// Namespace namespace_4e2074f4
// Params 7, eflags: 0x0
// Checksum 0x858f0502, Offset: 0x938
// Size: 0x84
function function_92fbb98f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        exploder::exploder("light_church_int_all");
        return;
    }
    exploder::stop_exploder("light_church_int_all");
}

// Namespace namespace_4e2074f4
// Params 2, eflags: 0x0
// Checksum 0x321d615e, Offset: 0x9c8
// Size: 0x2ba
function fold_debris(localclientnum, n_path_id) {
    debris = [];
    position = struct::get_array("fold_debris");
    for (i = 0; i < position.size; i++) {
        if (isdefined(position[i].model) && position[i].script_index == n_path_id) {
            junk = spawn(localclientnum, position[i].origin, "script_model");
            junk setmodel(position[i].model);
            junk.targetname = position[i].targetname;
            junk.speed = randomfloatrange(position[i].script_physics, position[i].script_physics + 50);
            junk.var_588704d4 = randomfloatrange(position[i].var_d66f2978, position[i].var_d66f2978 + 0.5);
            if (isdefined(position[i].angles)) {
                junk.angles = position[i].angles;
            }
            array::add(debris, junk, 0);
        }
    }
    foreach (junk in debris) {
        junk thread function_ba900c87(localclientnum, n_path_id);
        junk thread function_567a9a23();
    }
}

// Namespace namespace_4e2074f4
// Params 2, eflags: 0x0
// Checksum 0x8473aa2e, Offset: 0xc90
// Size: 0x284
function function_ba900c87(localclientnum, n_path_id) {
    s_current = struct::get("fold_debris_path_" + n_path_id);
    offset = self.origin - s_current.origin;
    var_97b57bc3 = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
    self linkto(var_97b57bc3);
    var_52e2b50d = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
    var_97b57bc3 linkto(var_52e2b50d);
    self thread function_7684532d(var_97b57bc3);
    while (isdefined(s_current.target)) {
        s_next = struct::get(s_current.target);
        s_next.origin += offset;
        n_dist = distance(self.origin, s_next.origin);
        n_time = n_dist / self.speed;
        var_52e2b50d moveto(s_next.origin, n_time, 0, 0);
        var_52e2b50d waittill(#"movedone");
        s_current = s_next;
    }
    self notify(#"hash_d2ba04dd");
    self unlink();
    self delete();
    var_52e2b50d delete();
    var_97b57bc3 delete();
}

// Namespace namespace_4e2074f4
// Params 1, eflags: 0x0
// Checksum 0x6906c764, Offset: 0xf20
// Size: 0x9e
function function_7684532d(var_97b57bc3) {
    self endon(#"hash_d2ba04dd");
    var_a92f960d = 1000;
    n_rotation = 360 * var_a92f960d;
    n_time = n_rotation / 360 * self.var_588704d4;
    while (true) {
        var_97b57bc3 rotateroll(n_rotation, n_time, 0, 0);
        var_97b57bc3 waittill(#"rotatedone");
    }
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0xe85b60c8, Offset: 0xfc8
// Size: 0xdc
function function_567a9a23() {
    self endon(#"hash_d2ba04dd");
    self endon(#"death");
    players = level.localplayers;
    while (isdefined(self) && isdefined(self.origin)) {
        if (isdefined(players[0]) && isdefined(players[0].origin)) {
            var_ddd68b9a = distancesquared(self.origin, players[0].origin);
            if (var_ddd68b9a <= 90000) {
                self playsound(0, "amb_junk_flyby");
                return;
            }
        }
        wait 0.2;
    }
}

// Namespace namespace_4e2074f4
// Params 7, eflags: 0x0
// Checksum 0x99477934, Offset: 0x10b0
// Size: 0x76
function function_826e310e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        level thread dynent_catcher(localclientnum);
        return;
    }
    level notify(#"hash_ace32285");
}

// Namespace namespace_4e2074f4
// Params 1, eflags: 0x0
// Checksum 0x9539481f, Offset: 0x1130
// Size: 0x1dc
function dynent_catcher(localclientnum) {
    level endon(#"hash_ace32285");
    t_dynent_catcher = getent(localclientnum, "t_dynent_catcher", "targetname");
    var_7c3acc51 = spawn(localclientnum, (0, 0, 0), "script_origin");
    var_7c3acc51 setmodel("tag_origin");
    var_12a4322c = [];
    while (true) {
        var_873f8029 = getdynentarray("fold_dynent");
        foreach (var_fb9bf56 in var_873f8029) {
            var_7c3acc51.origin = var_fb9bf56.origin;
            if (var_7c3acc51 istouching(t_dynent_catcher)) {
                if (!isinarray(var_12a4322c, var_fb9bf56)) {
                    array::add(var_12a4322c, var_fb9bf56);
                    setdynentenabled(var_fb9bf56, 0);
                    wait 0.1;
                }
            }
        }
        wait 1;
    }
}

// Namespace namespace_4e2074f4
// Params 1, eflags: 0x0
// Checksum 0xaf3d4206, Offset: 0x1318
// Size: 0x64
function function_fac6ef5e(localclientnum) {
    e_trigger = getent(localclientnum, "t_light_church_ext_window_off", "targetname");
    e_trigger waittill(#"trigger");
    exploder::stop_exploder("light_church_ext_window");
}

// Namespace namespace_4e2074f4
// Params 7, eflags: 0x0
// Checksum 0xb3888d9b, Offset: 0x1388
// Size: 0x5c
function function_ba29b6bb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        exploder::stop_exploder("light_church_ext_window");
    }
}

