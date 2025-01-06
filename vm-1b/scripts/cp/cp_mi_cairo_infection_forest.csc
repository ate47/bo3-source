#using scripts/codescripts/struct;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_cairo_infection_forest;

// Namespace cp_mi_cairo_infection_forest
// Params 0, eflags: 0x0
// Checksum 0x8ef615f, Offset: 0x338
// Size: 0x22
function main() {
    init_clientfields();
    level thread mortar_test();
}

// Namespace cp_mi_cairo_infection_forest
// Params 0, eflags: 0x0
// Checksum 0x1f8133ea, Offset: 0x368
// Size: 0x18a
function init_clientfields() {
    clientfield::register("world", "forest_mortar_index", 1, 3, "int", &function_67664f3d, 0, 0);
    clientfield::register("world", "forest_surreal_exposure", 1, 1, "int", &function_bcf75575, 0, 0);
    clientfield::register("toplayer", "pstfx_frost_up", 1, 1, "counter", &function_fa9ecbf7, 0, 0);
    clientfield::register("toplayer", "pstfx_frost_down", 1, 1, "counter", &function_a34472c4, 0, 0);
    clientfield::register("scriptmover", "wfa_steam_sound", 1, 1, "counter", &function_1a244510, 0, 0);
    clientfield::register("scriptmover", "cp_infection_world_falls_break_rumble", 1, 1, "counter", &function_5d6ca4fb, 0, 0);
    clientfield::register("scriptmover", "cp_infection_world_falls_away_rumble", 1, 1, "counter", &function_5d6ca4fb, 0, 0);
}

// Namespace cp_mi_cairo_infection_forest
// Params 7, eflags: 0x0
// Checksum 0x4180b4d7, Offset: 0x500
// Size: 0x71
function function_67664f3d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        level.mortar_start = 0;
        return;
    }
    if (newval) {
        level.mortar_start = 1;
        level.var_773fdd87 = newval;
        level.var_bf551cdb = 1;
    }
}

// Namespace cp_mi_cairo_infection_forest
// Params 0, eflags: 0x0
// Checksum 0x960ce755, Offset: 0x580
// Size: 0x299
function mortar_test() {
    if (!isdefined(level.var_773fdd87)) {
        level.var_773fdd87 = 0;
        level.var_bf551cdb = 1;
    }
    index = 0;
    delay = 3;
    while (true) {
        while (!(isdefined(level.mortar_start) && level.mortar_start)) {
            wait 1;
        }
        switch (level.var_773fdd87) {
        case 0:
            var_1e806caa = struct::get_array("s_background_mortar_0", "targetname");
            delay = randomfloatrange(0.5, 1);
            break;
        case 1:
            var_1e806caa = struct::get_array("s_background_mortar_1", "targetname");
            delay = randomfloatrange(1.5, 2.5);
            break;
        case 2:
            var_1e806caa = struct::get_array("s_background_mortar_2", "targetname");
            delay = randomfloatrange(1.5, 2);
            break;
        case 3:
            var_1e806caa = struct::get_array("s_background_mortar_3", "targetname");
            delay = randomfloatrange(1.5, 2.5);
            break;
        case 4:
            var_1e806caa = struct::get_array("s_background_mortar_4", "targetname");
            delay = randomfloatrange(5, 8);
            break;
        case 5:
            var_1e806caa = struct::get_array("s_background_mortar_5", "targetname");
            delay = randomfloatrange(5, 8);
            break;
        case 6:
        default:
            return;
        }
        if (isdefined(level.var_bf551cdb)) {
            index = randomint(var_1e806caa.size);
            level.var_bf551cdb = undefined;
        }
        playfx(0, "explosions/fx_exp_mortar_snow_reverse", var_1e806caa[index].origin);
        index++;
        if (index >= var_1e806caa.size) {
            index = 0;
        }
        wait delay;
    }
}

// Namespace cp_mi_cairo_infection_forest
// Params 7, eflags: 0x0
// Checksum 0x3bf2521c, Offset: 0x828
// Size: 0xaf
function function_eada2afe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread function_b71abfbc(localclientnum, 1, 0.4);
        level thread function_b71abfbc(localclientnum, 5, 0.4);
        level thread function_b71abfbc(localclientnum, 9, 0.4);
        level thread function_b71abfbc(localclientnum, 12, 0.4);
        return;
    }
    level notify(#"hash_693a8925");
}

// Namespace cp_mi_cairo_infection_forest
// Params 3, eflags: 0x0
// Checksum 0xc923c935, Offset: 0x8e0
// Size: 0x8b
function function_b71abfbc(localclientnum, start_index, delay) {
    level endon(#"hash_693a8925");
    for (var_ee164041 = start_index; true; var_ee164041 = 1) {
        level thread forest_debris(localclientnum, var_ee164041);
        wait_time = delay + randomfloatrange(delay * -1 / 4, delay / 4);
        wait wait_time;
        var_ee164041++;
        if (var_ee164041 > 15) {
        }
    }
}

// Namespace cp_mi_cairo_infection_forest
// Params 2, eflags: 0x0
// Checksum 0x2db059de, Offset: 0x978
// Size: 0x1db
function forest_debris(localclientnum, n_path_id) {
    debris = [];
    var_51ea8b3e = struct::get_array("forest_debris");
    for (i = 0; i < var_51ea8b3e.size; i++) {
        if (isdefined(var_51ea8b3e[i].model) && var_51ea8b3e[i].script_index == n_path_id) {
            junk = spawn(localclientnum, var_51ea8b3e[i].origin, "script_model");
            junk setmodel(var_51ea8b3e[i].model);
            junk.targetname = var_51ea8b3e[i].targetname;
            speed = var_51ea8b3e[i].script_physics;
            speed = 120;
            junk.speed = randomfloatrange(speed, speed + -106);
            junk.var_588704d4 = randomfloatrange(var_51ea8b3e[i].var_d66f2978, var_51ea8b3e[i].var_d66f2978 + 1.5);
            if (isdefined(var_51ea8b3e[i].angles)) {
                junk.angles = var_51ea8b3e[i].angles;
            }
            array::add(debris, junk, 0);
        }
    }
    foreach (junk in debris) {
        junk thread function_ba900c87(localclientnum, n_path_id);
    }
}

// Namespace cp_mi_cairo_infection_forest
// Params 2, eflags: 0x0
// Checksum 0x3e9a22a8, Offset: 0xb60
// Size: 0x1d2
function function_ba900c87(localclientnum, n_path_id) {
    s_current = struct::get("forest_debris_path_" + n_path_id);
    var_97b57bc3 = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
    self linkto(var_97b57bc3);
    var_52e2b50d = util::spawn_model(localclientnum, "tag_origin", s_current.origin, self.angles);
    var_97b57bc3 linkto(var_52e2b50d);
    self thread function_7684532d(var_97b57bc3);
    while (isdefined(s_current.target)) {
        s_next = struct::get(s_current.target);
        n_dist = distance(s_current.origin, s_next.origin);
        n_time = n_dist / self.speed;
        var_52e2b50d moveto(s_next.origin, n_time, 0, 0);
        var_52e2b50d waittill(#"movedone");
        s_current = s_next;
    }
    self notify(#"hash_d2ba04dd");
    self unlink();
    pos = self.origin;
    angles = self.angles;
    self delete();
    var_52e2b50d delete();
}

// Namespace cp_mi_cairo_infection_forest
// Params 1, eflags: 0x0
// Checksum 0x1e4dc293, Offset: 0xd40
// Size: 0x8a
function function_7684532d(var_97b57bc3) {
    self endon(#"hash_d2ba04dd");
    var_a92f960d = 1000;
    n_rotation = 360 * var_a92f960d;
    n_time = n_rotation / 360 * self.var_588704d4;
    while (true) {
        var_97b57bc3 rotateroll(n_rotation, n_time, 0, 0);
        var_97b57bc3 waittill(#"rotatedone");
    }
    var_97b57bc3 delete();
}

// Namespace cp_mi_cairo_infection_forest
// Params 7, eflags: 0x0
// Checksum 0x3194e678, Offset: 0xdd8
// Size: 0xa2
function function_fa9ecbf7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    if (!isdefined(player.var_8afc17fb)) {
        player.var_8afc17fb = 0;
    }
    if (player.var_8afc17fb == 0) {
        player.var_8afc17fb = 1;
        player postfx::playpostfxbundle("pstfx_frost_loop");
    }
}

// Namespace cp_mi_cairo_infection_forest
// Params 7, eflags: 0x0
// Checksum 0xab6e990, Offset: 0xe88
// Size: 0x82
function function_a34472c4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    if (player.var_8afc17fb === 1) {
        player.var_8afc17fb = 0;
        player thread postfx::exitpostfxbundle();
    }
}

// Namespace cp_mi_cairo_infection_forest
// Params 7, eflags: 0x0
// Checksum 0x3a427eaa, Offset: 0xf18
// Size: 0x5a
function function_1a244510(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playsound(localclientnum, "evt_small_flyaway_steam", self.origin);
    }
}

// Namespace cp_mi_cairo_infection_forest
// Params 7, eflags: 0x0
// Checksum 0x983e7c66, Offset: 0xf80
// Size: 0x5a
function function_5d6ca4fb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playrumbleonposition(localclientnum, fieldname, self.origin);
    }
}

// Namespace cp_mi_cairo_infection_forest
// Params 7, eflags: 0x0
// Checksum 0xebe37e9e, Offset: 0xfe8
// Size: 0x5a
function function_bcf75575(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval && newval != oldval) {
        level thread function_3d919555(localclientnum);
    }
}

// Namespace cp_mi_cairo_infection_forest
// Params 1, eflags: 0x0
// Checksum 0xace8ebbf, Offset: 0x1050
// Size: 0x32
function function_3d919555(localclientnum) {
    setexposureactivebank(localclientnum, 2);
    wait 1;
    setexposureactivebank(localclientnum, 1);
}

