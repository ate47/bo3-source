#using scripts/shared/util_shared;
#using scripts/shared/array_shared;
#using scripts/shared/scene_shared;
#using scripts/codescripts/struct;

#namespace namespace_5bde54f9;

// Namespace namespace_5bde54f9
// Params 0, eflags: 0x1 linked
// namespace_5bde54f9<file_0>::function_d290ebfa
// Checksum 0xc1431485, Offset: 0x1c0
// Size: 0xc4
function main() {
    scene::add_scene_func("p7_fxanim_mp_mini_fly_idle_01_bundle", &function_92ba15b6);
    scene::add_scene_func("p7_fxanim_mp_mini_fly_idle_02_bundle", &function_92ba15b6);
    scene::add_scene_func("p7_fxanim_mp_mini_fly_land_01_bundle", &function_b66aa97f, "done");
    level thread scene::play("p7_fxanim_mp_mini_fly_idle_01_bundle");
    level thread scene::play("p7_fxanim_mp_mini_fly_idle_02_bundle");
}

// Namespace namespace_5bde54f9
// Params 1, eflags: 0x1 linked
// namespace_5bde54f9<file_0>::function_92ba15b6
// Checksum 0xa507032a, Offset: 0x290
// Size: 0xf4
function function_92ba15b6(a_ents) {
    self endon(#"killed");
    var_4f4f6520 = a_ents["fxanim_fly"];
    self thread function_b6d62783(var_4f4f6520);
    wait(1);
    function_e010169f(var_4f4f6520);
    self scene::play("p7_fxanim_mp_mini_fly_takeoff_01_bundle", a_ents);
    if (issubstr(self.targetname, "vista")) {
        self.script_play_multiple = 1;
        wait(randomfloatrange(10, 30));
        self scene::play("p7_fxanim_mp_mini_fly_land_01_bundle");
    }
}

// Namespace namespace_5bde54f9
// Params 1, eflags: 0x1 linked
// namespace_5bde54f9<file_0>::function_b66aa97f
// Checksum 0x57a1f1ca, Offset: 0x390
// Size: 0x24
function function_b66aa97f(a_ents) {
    self thread scene::play(a_ents);
}

// Namespace namespace_5bde54f9
// Params 1, eflags: 0x1 linked
// namespace_5bde54f9<file_0>::function_b6d62783
// Checksum 0x678e3c30, Offset: 0x3c0
// Size: 0x8a
function function_b6d62783(var_4f4f6520) {
    var_4f4f6520 notify(#"hash_b6d62783");
    var_4f4f6520 endon(#"hash_b6d62783");
    var_4f4f6520 waittill(#"damage");
    playfxontag("dlc4/mp_mini/fx_fly_death", var_4f4f6520, "body_jnt");
    wait(0.05);
    var_4f4f6520 delete();
    self notify(#"killed");
}

// Namespace namespace_5bde54f9
// Params 1, eflags: 0x1 linked
// namespace_5bde54f9<file_0>::function_e010169f
// Checksum 0xb2ff52a7, Offset: 0x458
// Size: 0xcc
function function_e010169f(var_4f4f6520) {
    while (true) {
        foreach (player in level.players) {
            if (distancesquared(player.origin, var_4f4f6520.origin) < 90000) {
                return;
            }
        }
        wait(0.05);
    }
}

