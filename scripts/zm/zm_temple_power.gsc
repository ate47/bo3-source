#using scripts/zm/_zm_power;
#using scripts/zm/_zm_audio;
#using scripts/shared/util_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_b89de338;

// Namespace namespace_b89de338
// Params 0, eflags: 0x1 linked
// Checksum 0xdc89b75f, Offset: 0x430
// Size: 0x204
function function_4323754a() {
    level flag::wait_till("initial_players_connected");
    level.var_c43f63de = getentarray("temple_power_door", "targetname");
    level flag::init("left_switch_pulled");
    level flag::init("right_switch_pulled");
    level flag::init("left_switch_done");
    level flag::init("right_switch_done");
    function_d89f08d3();
    var_af844e4d = struct::get("power_switch_left", "targetname");
    var_5e17cc70 = struct::get("power_switch_right", "targetname");
    level thread power_switch("power_trigger_left", "left_switch_pulled");
    level thread power_switch("power_trigger_right", "right_switch_pulled");
    var_af844e4d thread function_3046fbc7("left_switch_pulled", "left_switch_done");
    var_5e17cc70 thread function_3046fbc7("right_switch_pulled", "right_switch_done");
    level thread wait_for_power();
    level thread function_7ea2ce8();
}

// Namespace namespace_b89de338
// Params 0, eflags: 0x1 linked
// Checksum 0x5c45ca1, Offset: 0x640
// Size: 0x94
function function_d89f08d3() {
    level thread function_e9d25b3("left_switch_done", 48, 25, 0, "evt_waterwheel02");
    level thread function_e9d25b3("right_switch_done", 49, 26, 1, "evt_waterwheel01");
    level thread function_2507931f();
    level thread function_ee647c3a();
}

// Namespace namespace_b89de338
// Params 2, eflags: 0x1 linked
// Checksum 0xbd726961, Offset: 0x6e0
// Size: 0x104
function power_switch(trigger_name, var_1e1fc126) {
    var_31353764 = getent(trigger_name, "targetname");
    var_31353764 sethintstring(%ZM_TEMPLE_RELEASE_WATER);
    var_31353764 setcursorhint("HINT_NOICON");
    while (true) {
        player = var_31353764 waittill(#"trigger");
        if (isplayer(player)) {
            level flag::set(var_1e1fc126);
            break;
        }
    }
    var_31353764 delete();
    level thread function_4ebc92cc(player);
}

// Namespace namespace_b89de338
// Params 1, eflags: 0x1 linked
// Checksum 0x5a776816, Offset: 0x7f0
// Size: 0x7c
function function_4ebc92cc(player) {
    level notify(#"hash_a300e69");
    level endon(#"hash_a300e69");
    wait(5);
    if (isdefined(player) && level flag::get("power_on")) {
        player thread zm_audio::create_and_play_dialog("general", "poweron");
    }
}

// Namespace namespace_b89de338
// Params 2, eflags: 0x1 linked
// Checksum 0x30f51cce, Offset: 0x878
// Size: 0x13c
function function_3046fbc7(var_1e1fc126, var_91c79b1d) {
    level flag::wait_till(var_1e1fc126);
    playsoundatposition("zmb_switch_flip_temple", self.origin);
    if (issubstr(self.targetname, "left")) {
        var_1e69bd24 = "elec_switch_fx_left";
    } else {
        var_1e69bd24 = "elec_switch_fx_right";
    }
    playfx(level._effect["switch_sparks"], struct::get(var_1e69bd24, "targetname").origin);
    level scene::play(self.targetname, "targetname");
    playsoundatposition("zmb_turn_on", self.origin);
    level flag::set(var_91c79b1d);
}

// Namespace namespace_b89de338
// Params 0, eflags: 0x1 linked
// Checksum 0xff34737e, Offset: 0x9c0
// Size: 0x5c
function wait_for_power() {
    level flag::wait_till("left_switch_done");
    level flag::wait_till("right_switch_done");
    wait(1);
    zm_power::turn_power_on_and_open_doors();
}

// Namespace namespace_b89de338
// Params 0, eflags: 0x1 linked
// Checksum 0x29b3bcd9, Offset: 0xa28
// Size: 0x174
function function_7ea2ce8() {
    level flag::wait_till("power_on");
    level clientfield::set("zombie_power_on", 1);
    level flag::set("left_switch_pulled");
    level flag::set("right_switch_pulled");
    level thread function_f8d52bb6();
    exploder::exploder("power_on");
    for (i = 0; i < level.var_c43f63de.size; i++) {
        level.var_c43f63de[i] connectpaths();
    }
    array::delete_all(level.var_c43f63de);
    playsoundatposition("zmb_poweron_front", (0, 0, 0));
    playsoundatposition("zmb_poweron_rear", (0, 0, 0));
    wait(4.5);
    exploder::exploder("fxexp_15");
}

// Namespace namespace_b89de338
// Params 0, eflags: 0x1 linked
// Checksum 0x9b931b40, Offset: 0xba8
// Size: 0xf2
function function_f8d52bb6() {
    level notify(#"hash_ce46a7cd");
    util::wait_network_frame();
    level notify(#"hash_2680d19f");
    util::wait_network_frame();
    level notify(#"hash_a7912f12");
    util::wait_network_frame();
    level notify(#"hash_ec4676f1");
    util::wait_network_frame();
    level notify(#"hash_ab41efa1");
    util::wait_network_frame();
    level notify(#"hash_e3fa9df1");
    util::wait_network_frame();
    level notify(#"hash_bd00857f");
    util::wait_network_frame();
    level notify(#"pack_a_punch_on");
}

// Namespace namespace_b89de338
// Params 1, eflags: 0x0
// Checksum 0xafd5bee, Offset: 0xca8
// Size: 0x9e
function function_fb70e1ed(var_68f7eb77) {
    var_760c8bf1 = getentarray(var_68f7eb77, "targetname");
    for (i = 0; i < var_760c8bf1.size; i++) {
        var_760c8bf1[i] thread function_d57d875f(-180, 4, 0.25, 0.25);
    }
}

// Namespace namespace_b89de338
// Params 4, eflags: 0x1 linked
// Checksum 0x62125e92, Offset: 0xd50
// Size: 0x4c
function function_d57d875f(var_2ac38233, time, acceleration_time, var_cff30a24) {
    self movez(var_2ac38233, time, acceleration_time, var_cff30a24);
}

// Namespace namespace_b89de338
// Params 5, eflags: 0x1 linked
// Checksum 0x960574f1, Offset: 0xda8
// Size: 0x10c
function function_e9d25b3(var_91c79b1d, var_57b77c66, var_b8c57a38, isright, sound) {
    level flag::wait_till(var_91c79b1d);
    wait(3.5);
    exploder::exploder("fxexp_" + var_57b77c66);
    exploder::stop_exploder("fxexp_" + var_b8c57a38);
    wait(1.2);
    soundent = getent(sound + "_origin", "targetname");
    if (isdefined(soundent)) {
        soundent playloopsound(sound, 1);
    }
    function_2a5dbecb(isright);
}

// Namespace namespace_b89de338
// Params 0, eflags: 0x1 linked
// Checksum 0x67fe4648, Offset: 0xec0
// Size: 0x12c
function function_2507931f() {
    level flag::wait_till("left_switch_done");
    wait(3.5);
    start_struct = struct::get("water_spout_01", "targetname");
    if (isdefined(start_struct)) {
        level thread sound::play_in_space("evt_water_spout01", start_struct.origin);
    }
    wait(1);
    var_388f2981 = struct::get("water_pour_01", "targetname");
    if (isdefined(var_388f2981)) {
        sound_entity = spawn("script_origin", (0, 0, 1));
        sound_entity.origin = var_388f2981.origin;
        sound_entity playloopsound("evt_water_pour01");
    }
}

// Namespace namespace_b89de338
// Params 0, eflags: 0x1 linked
// Checksum 0xb47b2116, Offset: 0xff8
// Size: 0x12c
function function_ee647c3a() {
    level flag::wait_till("right_switch_done");
    wait(3.5);
    start_struct = struct::get("water_spout_02", "targetname");
    if (isdefined(start_struct)) {
        level thread sound::play_in_space("evt_water_spout02", start_struct.origin);
    }
    wait(1);
    var_388f2981 = struct::get("water_pour_02", "targetname");
    if (isdefined(var_388f2981)) {
        sound_entity = spawn("script_origin", (0, 0, 1));
        sound_entity.origin = var_388f2981.origin;
        sound_entity playloopsound("evt_water_pour02");
    }
}

// Namespace namespace_b89de338
// Params 1, eflags: 0x1 linked
// Checksum 0x3f5bbffb, Offset: 0x1130
// Size: 0x5c
function function_2a5dbecb(isright) {
    if (isright) {
        level clientfield::set("water_wheel_right", 1);
        return;
    }
    level clientfield::set("water_wheel_left", 1);
}

