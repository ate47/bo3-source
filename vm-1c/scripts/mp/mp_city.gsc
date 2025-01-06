#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/_vehicle;
#using scripts/mp/mp_city_fx;
#using scripts/mp/mp_city_sound;
#using scripts/mp/vehicles/_quadtank;
#using scripts/mp/vehicles/_siegebot;
#using scripts/mp/vehicles/_siegebot_theia;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace mp_city;

// Namespace mp_city
// Params 0, eflags: 0x0
// Checksum 0x787ac5ba, Offset: 0x320
// Size: 0x1a4
function main() {
    clientfield::register("scriptmover", "ring_state", 15000, 2, "int");
    precache();
    level flag::init("city_vortex_sequence_playing");
    mp_city_fx::main();
    mp_city_sound::main();
    level.var_76013c83 = &function_76013c83;
    load::main();
    compass::setupminimap("compass_map_mp_city");
    setdvar("compassmaxrange", "2100");
    level.cleandepositpoints = array((-137.668, 68.4889, -1567.88), (1252.24, -1316.22, -1688.46), (1150.05, 2627.64, -1311.88), (-1944.21, -742.548, -1767.88));
    vehicle::initvehiclemap();
    level function_573ef330();
    level thread function_73cc292();
}

// Namespace mp_city
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x4d0
// Size: 0x4
function precache() {
    
}

// Namespace mp_city
// Params 0, eflags: 0x0
// Checksum 0xd5f581cb, Offset: 0x4e0
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
// Params 1, eflags: 0x0
// Checksum 0xe04a766c, Offset: 0x5b8
// Size: 0x9a
function function_ed2ffe3e(state) {
    foreach (ring in level.var_183f5eae) {
        ring clientfield::set("ring_state", state);
    }
}

// Namespace mp_city
// Params 2, eflags: 0x0
// Checksum 0x3b842251, Offset: 0x660
// Size: 0xda
function function_5d8520c1(ringindex, state) {
    var_535676d8 = "" + ringindex;
    rings = level.rings[var_535676d8];
    foreach (ring in rings) {
        ring clientfield::set("ring_state", state);
    }
}

// Namespace mp_city
// Params 0, eflags: 0x0
// Checksum 0xb3ec61e3, Offset: 0x748
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
// Params 0, eflags: 0x0
// Checksum 0x4d1da72b, Offset: 0x878
// Size: 0x64
function function_73cc292() {
    level thread function_216797ea();
    level function_e1a5f5b4();
    level thread function_9c9f20e6();
    level thread function_a71ab527();
}

// Namespace mp_city
// Params 0, eflags: 0x0
// Checksum 0xbdd75ff3, Offset: 0x8e8
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
// Params 0, eflags: 0x0
// Checksum 0x1619ea6a, Offset: 0x958
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
// Params 0, eflags: 0x0
// Checksum 0x62b61b47, Offset: 0xa08
// Size: 0x64
function function_e1a5f5b4() {
    level thread function_8637c721();
    level thread function_4bac34c2();
    level thread function_34dbb1db();
    level thread function_362bb0a8();
}

// Namespace mp_city
// Params 0, eflags: 0x0
// Checksum 0x1dd82c8e, Offset: 0xa78
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
// Params 0, eflags: 0x0
// Checksum 0x72e2e43, Offset: 0xb10
// Size: 0x28
function function_4bac34c2() {
    for (;;) {
        level waittill(#"hash_f64c6779");
        function_ed2ffe3e(1);
    }
}

// Namespace mp_city
// Params 0, eflags: 0x0
// Checksum 0xc0bdf82c, Offset: 0xb40
// Size: 0x28
function function_34dbb1db() {
    for (;;) {
        level waittill(#"hash_251fac9e");
        function_ed2ffe3e(2);
    }
}

// Namespace mp_city
// Params 0, eflags: 0x0
// Checksum 0x7a30fae, Offset: 0xb70
// Size: 0x28
function function_362bb0a8() {
    for (;;) {
        level waittill(#"hash_b6322585");
        function_ed2ffe3e(3);
    }
}

// Namespace mp_city
// Params 1, eflags: 0x0
// Checksum 0xa83c1b0a, Offset: 0xba0
// Size: 0x2c
function function_a26d4506(ents) {
    level thread scene::init("p7_fxanim_mp_city_vista_energy_ball_bundle");
}

// Namespace mp_city
// Params 0, eflags: 0x0
// Checksum 0x29b3e8c8, Offset: 0xbd8
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
// Params 4, eflags: 0x0
// Checksum 0x507289df, Offset: 0xc40
// Size: 0x6c
function function_76013c83(veh_name, origin, angles, var_d47ecfec) {
    playfx("vehicle/fx_siegebot_spawn_teleport", origin, anglestoforward(angles), anglestoup(angles));
}

