#using scripts/shared/util_shared;
#using scripts/shared/array_shared;
#using scripts/shared/scene_shared;
#using scripts/codescripts/struct;

#namespace namespace_33aa6d71;

// Namespace namespace_33aa6d71
// Params 0, eflags: 0x1 linked
// namespace_33aa6d71<file_0>::function_d290ebfa
// Checksum 0xdd704090, Offset: 0x180
// Size: 0xe6
function main() {
    level.var_5cba0818 = [];
    level.var_5cba0818[level.var_5cba0818.size] = "beer";
    level.var_5cba0818[level.var_5cba0818.size] = "coffee";
    level.var_5cba0818[level.var_5cba0818.size] = "cooler";
    level.var_5cba0818[level.var_5cba0818.size] = "pizza";
    level.var_5cba0818[level.var_5cba0818.size] = "soda";
    level.var_6b3738f3 = [];
    for (i = 0; i < level.var_5cba0818.size; i++) {
        function_4f20813f(i);
    }
}

// Namespace namespace_33aa6d71
// Params 1, eflags: 0x1 linked
// namespace_33aa6d71<file_0>::function_4f20813f
// Checksum 0xee6a5266, Offset: 0x270
// Size: 0x14e
function function_4f20813f(var_ba2f73bb) {
    level.var_6b3738f3[level.var_6b3738f3.size] = spawnstruct();
    var_25a35218 = level.var_6b3738f3[level.var_6b3738f3.size - 1];
    var_25a35218.bundles = [];
    var_25a35218.bundles[var_25a35218.bundles.size] = "p7_fxanim_mp_mini_ant_" + level.var_5cba0818[var_ba2f73bb] + "_path_01_bundle";
    var_25a35218.bundles[var_25a35218.bundles.size] = "p7_fxanim_mp_mini_ant_" + level.var_5cba0818[var_ba2f73bb] + "_path_02_bundle";
    var_25a35218.currentcount = 0;
    for (i = 0; i < 2; i++) {
        level thread function_4a46c01d(var_25a35218.bundles);
    }
}

// Namespace namespace_33aa6d71
// Params 1, eflags: 0x1 linked
// namespace_33aa6d71<file_0>::function_4a46c01d
// Checksum 0x7f4a08cd, Offset: 0x3c8
// Size: 0x1f8
function function_4a46c01d(var_9cc495a4) {
    var_3e34d085 = [];
    foreach (str_scene in var_9cc495a4) {
        scene::add_scene_func(str_scene, &function_98d963dd);
        if (!isdefined(var_3e34d085)) {
            var_3e34d085 = [];
        } else if (!isarray(var_3e34d085)) {
            var_3e34d085 = array(var_3e34d085);
        }
        var_3e34d085[var_3e34d085.size] = struct::get(str_scene, "scriptbundlename");
    }
    while (true) {
        waittime = randomintrange(9, 12);
        wait(waittime);
        var_fe85e3de = array::random(var_3e34d085);
        var_b7a43bf0 = spawnstruct();
        var_b7a43bf0.origin = var_fe85e3de.origin;
        var_b7a43bf0.angles = var_fe85e3de.angles;
        var_b7a43bf0 thread scene::play(var_fe85e3de.scriptbundlename);
    }
}

// Namespace namespace_33aa6d71
// Params 1, eflags: 0x1 linked
// namespace_33aa6d71<file_0>::function_98d963dd
// Checksum 0xc75c61a9, Offset: 0x5c8
// Size: 0x84
function function_98d963dd(a_ents) {
    var_8b1cef3c = a_ents["ant"];
    var_8b1cef3c endon(#"death");
    var_8b1cef3c waittill(#"damage");
    playfxontag("dlc4/mp_mini/fx_ant_death", var_8b1cef3c, "body_jnt");
    wait(0.05);
    var_8b1cef3c delete();
}

