#using scripts/cp/_load;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_c024ffd;

// Namespace namespace_c024ffd
// Params 0, eflags: 0x0
// Checksum 0x693f3515, Offset: 0x4e0
// Size: 0x114
function main() {
    level thread function_6b2436b8();
    level.var_b4ad2ec5 = [];
    level.var_b4ad2ec5["p7_fxanim_cp_infection_sarah_building_03_bundle"] = &function_9bd322a9;
    level.var_b4ad2ec5["p7_fxanim_cp_infection_sarah_building_04_bundle"] = &function_362b8d1c;
    level.var_b4ad2ec5["p7_fxanim_cp_infection_sarah_building_05_bundle"] = &function_538e886b;
    level.var_b4ad2ec5["p7_fxanim_cp_infection_sarah_building_06_bundle"] = &function_8cb957be;
    level.var_b4ad2ec5["p7_fxanim_cp_infection_sarah_building_07_bundle"] = &function_c22685d5;
    level.var_b4ad2ec5["p7_fxanim_cp_infection_sarah_building_08_bundle"] = &function_1733f8a8;
    init_clientfields();
    level thread function_7b244c18();
}

// Namespace namespace_c024ffd
// Params 0, eflags: 0x0
// Checksum 0xe999a021, Offset: 0x600
// Size: 0xa6
function function_7b244c18() {
    wait(0.05);
    for (i = 3; i <= 8; i++) {
        str_name = "p7_fxanim_cp_infection_sarah_building_0" + i + "_bundle";
        var_666ebfcb = struct::get(str_name, "scriptbundlename");
        if (isdefined(var_666ebfcb)) {
            level scene::init(str_name);
        }
    }
}

// Namespace namespace_c024ffd
// Params 0, eflags: 0x0
// Checksum 0xa5ffd154, Offset: 0x6b0
// Size: 0x90
function function_6b2436b8() {
    util::waitforallclients();
    for (i = 3; i <= 8; i++) {
        for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
            function_6712dcb2(localclientnum, "m_sarah_building_0" + i, 0);
        }
    }
}

// Namespace namespace_c024ffd
// Params 0, eflags: 0x0
// Checksum 0xde71b7e2, Offset: 0x748
// Size: 0x144
function init_clientfields() {
    n_clientbits = getminbitcountfornum(8);
    clientfield::register("world", "building_destruction_callback", 1, n_clientbits, "int", &function_a77a502, 0, 0);
    clientfield::register("world", "building_end_callback", 1, 1, "int", &function_cc506aa7, 0, 0);
    clientfield::register("world", "vtol_fog_bank", 1, 1, "int", &function_68142842, 0, 0);
    clientfield::register("scriptmover", "sarah_tac_mode_disable", 1, 1, "int", &function_a722d56a, 0, 0);
}

// Namespace namespace_c024ffd
// Params 7, eflags: 0x0
// Checksum 0x62814f02, Offset: 0x898
// Size: 0x7c
function function_a722d56a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self tmodesetflag(9);
        return;
    }
    self tmodeclearflag(9);
}

// Namespace namespace_c024ffd
// Params 7, eflags: 0x0
// Checksum 0x331ef2b7, Offset: 0x920
// Size: 0xdc
function function_a77a502(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        str_name = "p7_fxanim_cp_infection_sarah_building_0" + newval + "_bundle";
        var_666ebfcb = struct::get(str_name, "scriptbundlename");
        if (isdefined(var_666ebfcb)) {
            level scene::play(str_name);
            function_6712dcb2(localclientnum, "m_sarah_building_0" + newval, 1);
        }
    }
}

// Namespace namespace_c024ffd
// Params 7, eflags: 0x0
// Checksum 0xf385b375, Offset: 0xa08
// Size: 0x10e
function function_cc506aa7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!binitialsnap) {
        if (newval) {
            for (i = 3; i <= 8; i++) {
                str_name = "p7_fxanim_cp_infection_sarah_building_0" + i + "_bundle";
                var_666ebfcb = struct::get(str_name, "scriptbundlename");
                if (isdefined(var_666ebfcb)) {
                    level scene::add_scene_func(str_name, level.var_b4ad2ec5[str_name], "play");
                    level thread scene::play(str_name);
                }
            }
        }
    }
}

// Namespace namespace_c024ffd
// Params 3, eflags: 0x0
// Checksum 0x5642f8f5, Offset: 0xb20
// Size: 0x16a
function function_6712dcb2(localclientnum, str_targetname, b_show) {
    if (!isdefined(b_show)) {
        b_show = 1;
    }
    var_5cee1345 = getentarray(localclientnum, str_targetname, "targetname");
    if (b_show) {
        foreach (model in var_5cee1345) {
            model show();
        }
        return;
    }
    foreach (model in var_5cee1345) {
        model hide();
    }
}

// Namespace namespace_c024ffd
// Params 7, eflags: 0x0
// Checksum 0x4816b96b, Offset: 0xc98
// Size: 0x94
function function_68142842(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval != newval) {
        if (newval == 1) {
            setworldfogactivebank(localclientnum, 2);
            return;
        }
        setworldfogactivebank(localclientnum, 1);
    }
}

// Namespace namespace_c024ffd
// Params 1, eflags: 0x0
// Checksum 0xcf6f875c, Offset: 0xd38
// Size: 0x5c
function function_9bd322a9(a_ents) {
    a_ents["sarah_building_03"] siegecmd("set_anim", "p7_fxanim_cp_infection_sarah_building_03_sanim", "set_shot", "default", "pause", "goto_end");
}

// Namespace namespace_c024ffd
// Params 1, eflags: 0x0
// Checksum 0xa3abe36f, Offset: 0xda0
// Size: 0x5c
function function_362b8d1c(a_ents) {
    a_ents["sarah_building_04"] siegecmd("set_anim", "p7_fxanim_cp_infection_sarah_building_04_sanim", "set_shot", "default", "pause", "goto_end");
}

// Namespace namespace_c024ffd
// Params 1, eflags: 0x0
// Checksum 0x4dbadff5, Offset: 0xe08
// Size: 0x5c
function function_538e886b(a_ents) {
    a_ents["sarah_building_05"] siegecmd("set_anim", "p7_fxanim_cp_infection_sarah_building_05_sanim", "set_shot", "default", "pause", "goto_end");
}

// Namespace namespace_c024ffd
// Params 1, eflags: 0x0
// Checksum 0x4d8add33, Offset: 0xe70
// Size: 0x5c
function function_8cb957be(a_ents) {
    a_ents["sarah_building_06"] siegecmd("set_anim", "p7_fxanim_cp_infection_sarah_building_06_sanim", "set_shot", "default", "pause", "goto_end");
}

// Namespace namespace_c024ffd
// Params 1, eflags: 0x0
// Checksum 0x804d9a74, Offset: 0xed8
// Size: 0x5c
function function_c22685d5(a_ents) {
    a_ents["sarah_building_07"] siegecmd("set_anim", "p7_fxanim_cp_infection_sarah_building_07_sanim", "set_shot", "default", "pause", "goto_end");
}

// Namespace namespace_c024ffd
// Params 1, eflags: 0x0
// Checksum 0xfb07830b, Offset: 0xf40
// Size: 0x5c
function function_1733f8a8(a_ents) {
    a_ents["sarah_building_08"] siegecmd("set_anim", "p7_fxanim_cp_infection_sarah_building_08_sanim", "set_shot", "default", "pause", "goto_end");
}

