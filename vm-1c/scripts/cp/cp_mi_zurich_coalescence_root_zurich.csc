#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_6a04e6cd;

// Namespace namespace_6a04e6cd
// Params 0, eflags: 0x1 linked
// Checksum 0xd7d1f50d, Offset: 0x330
// Size: 0x56
function main() {
    init_clientfields();
    level.var_77350bac = [];
    level._effect["snow_burst_fx"] = "snow/fx_snow_root_wall_zurich";
    level._effect["snow_pipe_fx"] = "snow/fx_snow_ground_pipe_zurich";
}

// Namespace namespace_6a04e6cd
// Params 0, eflags: 0x1 linked
// Checksum 0x163eec32, Offset: 0x390
// Size: 0x1b4
function init_clientfields() {
    clientfield::register("scriptmover", "zurich_snow_rise", 1, 1, "counter", &function_920535b4, 0, 0);
    clientfield::register("toplayer", "reflection_extracam", 1, 1, "int", &function_bf3a782e, 0, 0);
    clientfield::register("toplayer", "zurich_vinewall_init", 1, 1, "int", &function_e76c15a0, 0, 0);
    clientfield::register("world", "root_vine_cleanup", 1, 1, "counter", &function_ad59adbe, 0, 0);
    clientfield::register("toplayer", "mirror_break", 1, 1, "int", &function_2a49d204, 0, 0);
    clientfield::register("scriptmover", "mirror_warp", 1, 1, "int", &function_5e9c8d21, 0, 0);
}

// Namespace namespace_6a04e6cd
// Params 7, eflags: 0x1 linked
// Checksum 0x279ae6f3, Offset: 0x550
// Size: 0xbc
function function_920535b4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfx(localclientnum, level._effect["snow_pipe_fx"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
    self playsound(0, "evt_snow_burst");
}

// Namespace namespace_6a04e6cd
// Params 7, eflags: 0x1 linked
// Checksum 0xb206e457, Offset: 0x618
// Size: 0x14c
function function_e76c15a0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (isdefined(level.var_77350bac[localclientnum]) && level.var_77350bac[localclientnum]) {
            return;
        }
        level.var_77350bac[localclientnum] = 1;
        scene::add_scene_func("p7_fxanim_cp_zurich_root_wall_01_bundle", &namespace_8e9083ff::function_4dd02a03, "done", "root_zurich_vine_cleanup");
        scene::add_scene_func("p7_fxanim_cp_zurich_root_wall_02_bundle", &namespace_8e9083ff::function_4dd02a03, "done", "root_zurich_vine_cleanup");
        var_d6e8ed16 = getentarray(localclientnum, "zurich_mazewall_trig", "targetname");
        array::thread_all(var_d6e8ed16, &function_abbe84dc, localclientnum);
    }
}

// Namespace namespace_6a04e6cd
// Params 1, eflags: 0x1 linked
// Checksum 0x788e6e3a, Offset: 0x770
// Size: 0x12e
function function_abbe84dc(localclientnum) {
    a_s_parts = struct::get_array(self.target, "targetname");
    self waittill(#"trigger");
    for (i = 0; i < a_s_parts.size; i++) {
        if (a_s_parts[i].classname === "scriptbundle_scene") {
            playfx(localclientnum, level._effect["snow_burst_fx"], a_s_parts[i].origin, anglestoforward(a_s_parts[i].angles), anglestoup(a_s_parts[i].angles));
            a_s_parts[i] scene::play();
        }
    }
}

// Namespace namespace_6a04e6cd
// Params 7, eflags: 0x1 linked
// Checksum 0xf7f9181a, Offset: 0x8a8
// Size: 0x58
function function_ad59adbe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level notify(#"hash_86c401a9");
    level.var_77350bac[localclientnum] = undefined;
}

// Namespace namespace_6a04e6cd
// Params 7, eflags: 0x1 linked
// Checksum 0xa42de8f0, Offset: 0x908
// Size: 0x134
function function_bf3a782e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        level.var_29613ea0 = getent(localclientnum, "zurich_root_mirror", "targetname");
        assert(isdefined(level.var_29613ea0), "reflection_extracam");
        level.var_29613ea0 setextracam(0);
        setdvar("r_extracam_custom_aspectratio", 0.769);
        return;
    }
    setdvar("r_extracam_custom_aspectratio", -1);
    if (isdefined(level.var_29613ea0)) {
        level.var_29613ea0 clearextracam();
        level.var_29613ea0 delete();
    }
}

// Namespace namespace_6a04e6cd
// Params 7, eflags: 0x1 linked
// Checksum 0x87ffbe56, Offset: 0xa48
// Size: 0x9c
function function_2a49d204(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        var_29613ea0 = getent(localclientnum, "zurich_root_mirror", "targetname");
        if (isdefined(var_29613ea0)) {
            var_29613ea0 hide();
        }
    }
}

// Namespace namespace_6a04e6cd
// Params 7, eflags: 0x1 linked
// Checksum 0x3e3d246a, Offset: 0xaf0
// Size: 0x190
function function_5e9c8d21(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        n_start_time = gettime();
        var_9aad594c = 0;
        while (var_9aad594c < 1) {
            n_time = gettime();
            var_348e23ad = (n_time - n_start_time) / 1000;
            var_9aad594c = 1 * var_348e23ad / 4;
            self mapshaderconstant(localclientnum, 0, "scriptVector4", var_9aad594c, 0, 0);
            wait(0.01);
        }
        return;
    }
    n_start_time = gettime();
    var_9aad594c = 1;
    while (isdefined(self) && var_9aad594c > 0) {
        n_time = gettime();
        var_348e23ad = (n_time - n_start_time) / 1000;
        var_9aad594c = 1 - var_348e23ad / 4;
        self mapshaderconstant(localclientnum, 0, "scriptVector4", var_9aad594c, 0, 0);
        wait(0.01);
    }
}

