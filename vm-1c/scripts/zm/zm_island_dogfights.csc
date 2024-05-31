#using scripts/shared/scene_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_14c8b75c;

// Namespace namespace_14c8b75c
// Params 0, eflags: 0x1 linked
// namespace_14c8b75c<file_0>::function_c35e6aab
// Checksum 0xa0b91949, Offset: 0x3a8
// Size: 0x19c
function init() {
    clientfield::register("world", "play_dogfight_scenes", 9000, 3, "int", &function_546d70b6, 0, 0);
    scene::add_scene_func("p7_fxanim_zm_island_plane_teleport_chase1_bundle", &function_618223cc, "play");
    scene::add_scene_func("p7_fxanim_zm_island_plane_teleport_chase2_bundle", &function_618223cc, "play");
    scene::add_scene_func("p7_fxanim_zm_island_plane_teleport_chase3_bundle", &function_618223cc, "play");
    scene::add_scene_func("p7_fxanim_zm_island_plane_teleport_chase4_bundle", &function_618223cc, "play");
    scene::add_scene_func("p7_fxanim_zm_island_plane_teleport_corsair1_bundle", &function_618223cc, "play");
    scene::add_scene_func("p7_fxanim_zm_island_plane_teleport_zero1_bundle", &function_618223cc, "play");
    scene::add_scene_func("p7_fxanim_zm_island_plane_teleport_mob_bundle", &function_618223cc, "play");
}

// Namespace namespace_14c8b75c
// Params 1, eflags: 0x1 linked
// namespace_14c8b75c<file_0>::function_618223cc
// Checksum 0x2dc3da18, Offset: 0x550
// Size: 0xa2
function function_618223cc(a_ents) {
    foreach (ent in a_ents) {
        if (isdefined(ent)) {
            ent sethighdetail(1);
        }
    }
}

// Namespace namespace_14c8b75c
// Params 7, eflags: 0x1 linked
// namespace_14c8b75c<file_0>::function_546d70b6
// Checksum 0x3143b5b4, Offset: 0x600
// Size: 0x11a
function function_546d70b6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 0:
        level thread function_7a1c330();
        break;
    case 1:
        level thread function_5daf587e();
        break;
    case 2:
        level thread function_2737bcd8();
        break;
    case 3:
        level thread function_99236d51();
        break;
    case 4:
        level thread function_b9d547c();
        break;
    case 5:
        level thread function_63045f7a();
        break;
    default:
        break;
    }
}

// Namespace namespace_14c8b75c
// Params 0, eflags: 0x1 linked
// namespace_14c8b75c<file_0>::function_7a1c330
// Checksum 0xf97be436, Offset: 0x728
// Size: 0x68
function function_7a1c330() {
    level notify(#"hash_fbb697ce");
    level endon(#"hash_fbb697ce");
    while (true) {
        function_4fc200d2("scene_dogfight_ambient", 40, 60, 1);
        wait(randomintrange(10, 20));
    }
}

// Namespace namespace_14c8b75c
// Params 0, eflags: 0x1 linked
// namespace_14c8b75c<file_0>::function_5daf587e
// Checksum 0xa8f5d961, Offset: 0x798
// Size: 0x48
function function_5daf587e() {
    while (true) {
        function_4fc200d2("scene_dogfight_intro", 1, 4);
        wait(randomintrange(60, 90));
    }
}

// Namespace namespace_14c8b75c
// Params 0, eflags: 0x1 linked
// namespace_14c8b75c<file_0>::function_2737bcd8
// Checksum 0x9aa6ea39, Offset: 0x7e8
// Size: 0x48
function function_2737bcd8() {
    while (true) {
        function_4fc200d2("scene_dogfight_swamp_lab", 2, 5);
        wait(randomintrange(60, 90));
    }
}

// Namespace namespace_14c8b75c
// Params 0, eflags: 0x1 linked
// namespace_14c8b75c<file_0>::function_99236d51
// Checksum 0x54fdb09f, Offset: 0x838
// Size: 0x48
function function_99236d51() {
    while (true) {
        function_4fc200d2("scene_dogfight_jungle_lab", 1, 3);
        wait(randomintrange(60, 90));
    }
}

// Namespace namespace_14c8b75c
// Params 0, eflags: 0x1 linked
// namespace_14c8b75c<file_0>::function_b9d547c
// Checksum 0x4b1b31ca, Offset: 0x888
// Size: 0x48
function function_b9d547c() {
    while (true) {
        function_4fc200d2("scene_dogfight_upper_bunker", 1, 3);
        wait(randomintrange(60, 90));
    }
}

// Namespace namespace_14c8b75c
// Params 0, eflags: 0x1 linked
// namespace_14c8b75c<file_0>::function_63045f7a
// Checksum 0xe83138f5, Offset: 0x8d8
// Size: 0x68
function function_63045f7a() {
    while (true) {
        if (randomint(100) <= 1) {
            function_4fc200d2("scene_dogfight_mob", 2, 5);
        }
        wait(randomintrange(30, 45));
    }
}

// Namespace namespace_14c8b75c
// Params 4, eflags: 0x1 linked
// namespace_14c8b75c<file_0>::function_4fc200d2
// Checksum 0xbddda490, Offset: 0x948
// Size: 0x13a
function function_4fc200d2(str_targetname, var_595a599c, var_83ec64e2, var_193e3630) {
    if (!isdefined(var_595a599c)) {
        var_595a599c = 0;
    }
    if (!isdefined(var_83ec64e2)) {
        var_83ec64e2 = 3;
    }
    if (!isdefined(var_193e3630)) {
        var_193e3630 = 0;
    }
    if (var_193e3630) {
        level endon(#"hash_fbb697ce");
    }
    var_bbd34e6b = struct::get_array(str_targetname, "targetname");
    foreach (s_scene in var_bbd34e6b) {
        wait(randomintrange(var_595a599c, var_83ec64e2));
        s_scene thread scene::play();
    }
}

