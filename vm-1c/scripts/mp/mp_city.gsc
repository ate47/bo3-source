#using scripts/mp/vehicles/_siegebot_theia;
#using scripts/mp/vehicles/_siegebot;
#using scripts/mp/vehicles/_quadtank;
#using scripts/mp/_vehicle;
#using scripts/mp/mp_city_sound;
#using scripts/mp/mp_city_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/compass;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace mp_city;

// Namespace mp_city
// Params 0, eflags: 0x1 linked
// Checksum 0x275b5a20, Offset: 0x3d8
// Size: 0x26c
function main() {
    clientfield::register("scriptmover", "ring_state", 15000, 2, "int");
    var_ae867510 = getdvarfloat("tu16_physicsPushOutThreshold", -1);
    if (var_ae867510 != -1) {
        setdvar("tu16_physicsPushOutThreshold", 10);
    }
    precache();
    level.var_76013c83 = &function_76013c83;
    level.var_692b3bc7 = &function_692b3bc7;
    level.var_e49e51d3 = &function_e49e51d3;
    level.var_cb38303b = &function_cb38303b;
    level.var_a5427f76 = 1;
    function_f0cb6507();
    level flag::init("city_vortex_sequence_playing");
    mp_city_fx::main();
    mp_city_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_city");
    setdvar("compassmaxrange", "2100");
    level.cleandepositpoints = array((-137.668, 68.4889, -1567.88), (1252.24, -1316.22, -1688.46), (1150.05, 2627.64, -1311.88), (-1944.21, -742.548, -1767.88));
    vehicle::initvehiclemap();
    level function_573ef330();
    level thread function_73cc292();
}

// Namespace mp_city
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x650
// Size: 0x4
function precache() {
    
}

// Namespace mp_city
// Params 0, eflags: 0x1 linked
// Checksum 0xa4ba7100, Offset: 0x660
// Size: 0x194
function function_f0cb6507() {
    level.var_5355f796 = [];
    for (i = 0; i < 4; i++) {
        level.var_5355f796[i] = spawnstruct();
    }
    level.var_5355f796[0].origin = (-2468.5, -2125.5, -1901);
    level.var_5355f796[0].angles = (359.4, 309.5, 3.5);
    level.var_5355f796[1].origin = (-582, -2689, -1580);
    level.var_5355f796[1].angles = (0, 0, 0);
    level.var_5355f796[2].origin = (3043.14, 713.521, -1393.5);
    level.var_5355f796[2].angles = (0, 270, 0);
    level.var_5355f796[3].origin = (1129, 3182, -1310);
    level.var_5355f796[3].angles = (0, 0, 0);
}

// Namespace mp_city
// Params 1, eflags: 0x1 linked
// Checksum 0xa228fd60, Offset: 0x800
// Size: 0x74
function function_6c91e817(origin) {
    for (i = 0; i < 4; i++) {
        if (distancesquared(origin, level.var_5355f796[i].origin) < 24 * 24) {
            return i;
        }
    }
    return 0;
}

// Namespace mp_city
// Params 0, eflags: 0x1 linked
// Checksum 0xb6c06aa, Offset: 0x880
// Size: 0xcc
function function_573ef330() {
    scene::add_scene_func("p7_fxanim_mp_city_vista_energy_ball_bundle", &function_a26d4506, "done");
    level thread function_8b863b50();
    /#
        mapname = getdvarstring("<dev string:x28>");
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x3e>");
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x96>");
    #/
}

// Namespace mp_city
// Params 1, eflags: 0x1 linked
// Checksum 0xbcbef152, Offset: 0x958
// Size: 0x9a
function function_ed2ffe3e(state) {
    foreach (ring in level.var_183f5eae) {
        ring clientfield::set("ring_state", state);
    }
}

// Namespace mp_city
// Params 2, eflags: 0x1 linked
// Checksum 0x3933f55b, Offset: 0xa00
// Size: 0xda
function function_5d8520c1(ringindex, state) {
    var_535676d8 = "" + ringindex;
    rings = level.rings[var_535676d8];
    foreach (ring in rings) {
        ring clientfield::set("ring_state", state);
    }
}

// Namespace mp_city
// Params 0, eflags: 0x1 linked
// Checksum 0x5f482e2e, Offset: 0xae8
// Size: 0x124
function function_8b863b50() {
    level.var_183f5eae = getentarray("city_ring", "targetname");
    level.rings = [];
    level.rings["1"] = [];
    level.rings["2"] = [];
    level.rings["3"] = [];
    level.rings["4"] = [];
    for (i = 0; i < level.var_183f5eae.size; i++) {
        index = level.var_183f5eae[i].script_noteworthy;
        level.rings[index][level.rings[index].size] = level.var_183f5eae[i];
    }
    function_ed2ffe3e(3);
}

// Namespace mp_city
// Params 0, eflags: 0x1 linked
// Checksum 0x7639b36c, Offset: 0xc18
// Size: 0x64
function function_73cc292() {
    level thread function_216797ea();
    level function_e1a5f5b4();
    level thread function_9c9f20e6();
    level thread function_a71ab527();
}

// Namespace mp_city
// Params 0, eflags: 0x1 linked
// Checksum 0x5d948103, Offset: 0xc88
// Size: 0x66
function function_216797ea() {
    played = 0;
    while (played < 2) {
        waittime = randomintrange(120, 360);
        wait waittime;
        played++;
        level notify(#"hash_c84a6138");
    }
}

// Namespace mp_city
// Params 0, eflags: 0x1 linked
// Checksum 0xcc60ce11, Offset: 0xcf8
// Size: 0xa8
function function_9c9f20e6() {
    level scene::init("p7_fxanim_mp_city_vista_energy_ball_bundle");
    level endon(#"hash_352f2eb9");
    for (;;) {
        level waittill(#"hash_c84a6138");
        level flag::set("city_vortex_sequence_playing");
        level thread scene::play("p7_fxanim_mp_city_vista_energy_ball_bundle");
        level array::thread_all(level.var_a439908d, &mp_city_sound::function_56481761);
    }
}

// Namespace mp_city
// Params 0, eflags: 0x1 linked
// Checksum 0x685426a5, Offset: 0xda8
// Size: 0x64
function function_e1a5f5b4() {
    level thread function_8637c721();
    level thread function_4bac34c2();
    level thread function_34dbb1db();
    level thread function_362bb0a8();
}

// Namespace mp_city
// Params 0, eflags: 0x1 linked
// Checksum 0xa7c63487, Offset: 0xe18
// Size: 0x90
function function_8637c721() {
    for (;;) {
        level waittill(#"hash_2716af92");
        function_5d8520c1(1, 0);
        wait 1;
        function_5d8520c1(2, 0);
        wait 1;
        function_5d8520c1(3, 0);
        wait 1;
        function_5d8520c1(4, 0);
    }
}

// Namespace mp_city
// Params 0, eflags: 0x1 linked
// Checksum 0x99dbbc60, Offset: 0xeb0
// Size: 0x28
function function_4bac34c2() {
    for (;;) {
        level waittill(#"hash_f64c6779");
        function_ed2ffe3e(1);
    }
}

// Namespace mp_city
// Params 0, eflags: 0x1 linked
// Checksum 0xb7b5836e, Offset: 0xee0
// Size: 0x28
function function_34dbb1db() {
    for (;;) {
        level waittill(#"hash_251fac9e");
        function_ed2ffe3e(2);
    }
}

// Namespace mp_city
// Params 0, eflags: 0x1 linked
// Checksum 0xe29b1510, Offset: 0xf10
// Size: 0x28
function function_362bb0a8() {
    for (;;) {
        level waittill(#"hash_b6322585");
        function_ed2ffe3e(3);
    }
}

// Namespace mp_city
// Params 1, eflags: 0x1 linked
// Checksum 0x86695587, Offset: 0xf40
// Size: 0x2c
function function_a26d4506(ents) {
    level thread scene::init("p7_fxanim_mp_city_vista_energy_ball_bundle");
}

// Namespace mp_city
// Params 0, eflags: 0x1 linked
// Checksum 0x465e34f3, Offset: 0xf78
// Size: 0x60
function function_a71ab527() {
    for (;;) {
        level waittill(#"hash_352f2eb9");
        level flag::clear("city_vortex_sequence_playing");
        level thread function_9c9f20e6();
        function_ed2ffe3e(3);
    }
}

// Namespace mp_city
// Params 4, eflags: 0x1 linked
// Checksum 0x5945d8bf, Offset: 0xfe0
// Size: 0x19c
function function_692b3bc7(var_f8e744ad, veh_name, origin, angles) {
    if (!isdefined(level.var_f0d5ca04)) {
        level.var_f0d5ca04 = [];
    }
    var_dd57cef7 = function_6c91e817(origin);
    var_7b0a32fb = level.var_5355f796[var_dd57cef7].origin;
    var_9909d085 = level.var_5355f796[var_dd57cef7].angles;
    forward = anglestoforward(var_9909d085);
    up = anglestoup(var_9909d085);
    var_e208fe99 = spawnstruct();
    var_e208fe99.var_96997dd6 = spawnfx("vehicle/fx_siegebot_spawn_teleport_light_yellow", var_7b0a32fb, forward, up);
    var_e208fe99.var_3bfd5383 = spawnfx("vehicle/fx_siegebot_spawn_teleport_light_red", var_7b0a32fb, forward, up);
    level.var_f0d5ca04[var_f8e744ad] = var_e208fe99;
    level thread function_938a8c2b(var_f8e744ad, 1);
}

// Namespace mp_city
// Params 0, eflags: 0x1 linked
// Checksum 0xdf4393c3, Offset: 0x1188
// Size: 0x2c
function function_cb38303b() {
    wait 5;
    level.var_5355f796 = [];
    level.var_692b3bc7 = [];
    wait 1;
}

// Namespace mp_city
// Params 2, eflags: 0x1 linked
// Checksum 0x3414ce96, Offset: 0x11c0
// Size: 0xc4
function function_938a8c2b(var_f8e744ad, delay) {
    wait delay;
    triggerfx(level.var_f0d5ca04[var_f8e744ad].var_96997dd6);
    triggerfx(level.var_f0d5ca04[var_f8e744ad].var_3bfd5383);
    wait 0.1;
    level.var_f0d5ca04[var_f8e744ad].var_96997dd6 hide();
    level.var_f0d5ca04[var_f8e744ad].var_3bfd5383 hide();
}

// Namespace mp_city
// Params 5, eflags: 0x1 linked
// Checksum 0xadd96c41, Offset: 0x1290
// Size: 0xc4
function function_76013c83(var_f8e744ad, veh_name, origin, angles, var_d47ecfec) {
    playfx("vehicle/fx_siegebot_spawn_teleport", origin, anglestoforward(angles), anglestoup(angles));
    level.var_f0d5ca04[var_f8e744ad].var_3bfd5383 hide();
    level thread function_8464fee5(var_f8e744ad, veh_name, origin, angles, var_d47ecfec);
}

// Namespace mp_city
// Params 5, eflags: 0x1 linked
// Checksum 0x1c67c695, Offset: 0x1360
// Size: 0x1dc
function function_8464fee5(var_f8e744ad, veh_name, origin, angles, var_d47ecfec) {
    remaining_time = float(var_d47ecfec);
    var_35c1d8a6 = level.var_f0d5ca04[var_f8e744ad].var_96997dd6;
    while (remaining_time >= 0.2) {
        playsoundatposition("evt_siegepad_yellow", level.var_f0d5ca04[var_f8e744ad].var_96997dd6.origin + (0, 0, 10));
        var_35c1d8a6 show();
        var_349e89f3 = max(remaining_time / 20, min(0.1, remaining_time));
        wait var_349e89f3;
        var_35c1d8a6 hide();
        wait 0.1;
        remaining_time -= var_349e89f3 + 0.1;
    }
    if (remaining_time > 0) {
        wait remaining_time;
    }
    level.var_f0d5ca04[var_f8e744ad].var_96997dd6 hide();
    playsoundatposition("evt_siegepad_green", origin + (0, 0, 10));
}

// Namespace mp_city
// Params 1, eflags: 0x1 linked
// Checksum 0x7d0752d, Offset: 0x1548
// Size: 0x7c
function function_e49e51d3(var_f8e744ad) {
    level.var_f0d5ca04[var_f8e744ad].var_3bfd5383 show();
    playsoundatposition("evt_siegepad_red", level.var_f0d5ca04[var_f8e744ad].var_3bfd5383.origin + (0, 0, 10));
}

