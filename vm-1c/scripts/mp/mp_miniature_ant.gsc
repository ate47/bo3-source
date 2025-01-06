#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace mp_miniature_ant;

// Namespace mp_miniature_ant
// Params 0, eflags: 0x0
// Checksum 0xe13cf0ad, Offset: 0x178
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

// Namespace mp_miniature_ant
// Params 1, eflags: 0x0
// Checksum 0x744056f5, Offset: 0x268
// Size: 0x14e
function function_4f20813f(var_ba2f73bb) {
    level.var_6b3738f3[level.var_6b3738f3.size] = spawnstruct();
    ant = level.var_6b3738f3[level.var_6b3738f3.size - 1];
    ant.bundles = [];
    ant.bundles[ant.bundles.size] = "p7_fxanim_mp_mini_ant_" + level.var_5cba0818[var_ba2f73bb] + "_path_01_bundle";
    ant.bundles[ant.bundles.size] = "p7_fxanim_mp_mini_ant_" + level.var_5cba0818[var_ba2f73bb] + "_path_02_bundle";
    ant.currentcount = 0;
    for (i = 0; i < 2; i++) {
        level thread function_4a46c01d(ant.bundles);
    }
}

// Namespace mp_miniature_ant
// Params 1, eflags: 0x0
// Checksum 0xfc998a70, Offset: 0x3c0
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
        waittime = randomintrange(3, 7);
        wait waittime;
        var_fe85e3de = array::random(var_3e34d085);
        var_b7a43bf0 = spawnstruct();
        var_b7a43bf0.origin = var_fe85e3de.origin;
        var_b7a43bf0.angles = var_fe85e3de.angles;
        var_b7a43bf0 thread scene::play(var_fe85e3de.scriptbundlename);
    }
}

// Namespace mp_miniature_ant
// Params 1, eflags: 0x0
// Checksum 0x23e4f657, Offset: 0x5c0
// Size: 0x84
function function_98d963dd(a_ents) {
    var_8b1cef3c = a_ents["ant"];
    var_8b1cef3c endon(#"death");
    var_8b1cef3c waittill(#"damage");
    playfx("dlc4/mp_mini/fx_ant_death", var_8b1cef3c.origin);
    var_8b1cef3c delete();
}

