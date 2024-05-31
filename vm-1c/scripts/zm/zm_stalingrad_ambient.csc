#using scripts/shared/audio_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_c71bfefb;

// Namespace namespace_c71bfefb
// Params 0, eflags: 0x2
// Checksum 0x321bce00, Offset: 0x360
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_stalingrad_ambient", &__init__, undefined, undefined);
}

// Namespace namespace_c71bfefb
// Params 0, eflags: 0x1 linked
// Checksum 0x2c9d783d, Offset: 0x3a0
// Size: 0x154
function __init__() {
    clientfield::register("scriptmover", "ambient_mortar_strike", 12000, 2, "int", &function_c6cda7e2, 0, 0);
    clientfield::register("scriptmover", "ambient_artillery_strike", 12000, 2, "int", &function_9c206421, 0, 0);
    clientfield::register("world", "power_on_level", 12000, 1, "int", &function_bad0de07, 0, 0);
    level thread function_866a2751();
    level thread function_a8bcf075();
    level thread function_1eb91e4b();
    level thread function_b833e317();
    level thread function_65c51e85();
}

// Namespace namespace_c71bfefb
// Params 7, eflags: 0x1 linked
// Checksum 0xbdbeba14, Offset: 0x500
// Size: 0xc4
function function_c6cda7e2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 1:
        var_df2299f9 = "ambient_mortar_small";
        break;
    case 2:
        var_df2299f9 = "ambient_mortar_medium";
        break;
    case 3:
        var_df2299f9 = "ambient_mortar_large";
        break;
    default:
        return;
    }
    self thread function_a7d3e4ff(localclientnum, var_df2299f9);
}

// Namespace namespace_c71bfefb
// Params 7, eflags: 0x1 linked
// Checksum 0xa0bf571e, Offset: 0x5d0
// Size: 0xc4
function function_9c206421(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 1:
        var_df2299f9 = "ambient_artillery_small";
        break;
    case 2:
        var_df2299f9 = "ambient_artillery_medium";
        break;
    case 3:
        var_df2299f9 = "ambient_artillery_large";
        break;
    default:
        return;
    }
    self thread function_a7d3e4ff(localclientnum, var_df2299f9);
}

// Namespace namespace_c71bfefb
// Params 2, eflags: 0x1 linked
// Checksum 0xb40305a0, Offset: 0x6a0
// Size: 0xcc
function function_a7d3e4ff(localclientnum, var_df2299f9) {
    level endon(#"demo_jump");
    playsound(localclientnum, "prj_mortar_incoming", self.origin);
    wait(1);
    playsound(localclientnum, "exp_mortar", self.origin);
    playfx(localclientnum, level._effect[var_df2299f9], self.origin);
    playrumbleonposition(localclientnum, "artillery_rumble", self.origin);
}

// Namespace namespace_c71bfefb
// Params 7, eflags: 0x1 linked
// Checksum 0x2024e277, Offset: 0x778
// Size: 0x52
function function_bad0de07(var_6575414d, var_a53f7c1b, var_143c4e26, var_f16ed138, var_406ad39b, str_field, var_ffbb7dc) {
    if (var_143c4e26) {
        level notify(#"hash_bad0de07");
    }
}

// Namespace namespace_c71bfefb
// Params 0, eflags: 0x1 linked
// Checksum 0x4636f9d7, Offset: 0x7d8
// Size: 0x164
function function_866a2751() {
    level thread function_916d6917("comm_monitor_lrg_combined");
    level thread function_916d6917("comm_equip_top_01");
    level thread function_916d6917("comm_equip_top_02");
    level thread function_916d6917("comm_equip_top_03");
    level thread function_916d6917("comm_equip_top_04");
    level thread function_916d6917("comm_equip_base_02");
    level waittill(#"hash_bad0de07");
    function_4820908f("comm_monitor_lrg_combined_off");
    function_4820908f("comm_equip_top_01_off");
    function_4820908f("comm_equip_top_02_off");
    function_4820908f("comm_equip_top_03_off");
    function_4820908f("comm_equip_top_04_off");
    function_4820908f("comm_equip_base_02_off");
}

// Namespace namespace_c71bfefb
// Params 1, eflags: 0x1 linked
// Checksum 0x736496a9, Offset: 0x948
// Size: 0x13a
function function_916d6917(str_targetname) {
    var_1bbd14fd = findstaticmodelindexarray(str_targetname);
    foreach (var_269779a in var_1bbd14fd) {
        hidestaticmodel(var_269779a);
    }
    level waittill(#"hash_bad0de07");
    foreach (var_269779a in var_1bbd14fd) {
        unhidestaticmodel(var_269779a);
    }
}

// Namespace namespace_c71bfefb
// Params 1, eflags: 0x1 linked
// Checksum 0x7602f239, Offset: 0xa90
// Size: 0x13a
function function_4820908f(str_targetname) {
    var_1bbd14fd = findstaticmodelindexarray(str_targetname);
    foreach (var_269779a in var_1bbd14fd) {
        unhidestaticmodel(var_269779a);
    }
    level waittill(#"hash_bad0de07");
    foreach (var_269779a in var_1bbd14fd) {
        hidestaticmodel(var_269779a);
    }
}

// Namespace namespace_c71bfefb
// Params 0, eflags: 0x1 linked
// Checksum 0x89a66a65, Offset: 0xbd8
// Size: 0x2c
function function_a8bcf075() {
    level waittill(#"hash_350165d0");
    audio::snd_set_snapshot("zmb_stal_boss_fight");
}

// Namespace namespace_c71bfefb
// Params 0, eflags: 0x1 linked
// Checksum 0xc24baac2, Offset: 0xc10
// Size: 0x2c
function function_1eb91e4b() {
    level waittill(#"hash_2a3c981c");
    audio::snd_set_snapshot("default");
}

// Namespace namespace_c71bfefb
// Params 0, eflags: 0x1 linked
// Checksum 0x30fab8dc, Offset: 0xc48
// Size: 0x2c
function function_b833e317() {
    level waittill(#"hash_18671e96");
    audio::snd_set_snapshot("zmb_stal_dragon_fight");
}

// Namespace namespace_c71bfefb
// Params 0, eflags: 0x0
// Checksum 0x47ab23dc, Offset: 0xc80
// Size: 0x2c
function function_b6e2489() {
    level waittill(#"hash_b9dbb809");
    audio::snd_set_snapshot("default");
}

// Namespace namespace_c71bfefb
// Params 0, eflags: 0x1 linked
// Checksum 0xb0bec197, Offset: 0xcb8
// Size: 0x2c
function function_65c51e85() {
    audio::playloopat("amb_air_raid", (-1819, 2705, 1167));
}

