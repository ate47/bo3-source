#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_safehouse;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_sh_cairo_fx;
#using scripts/cp/cp_sh_cairo_sound;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/music_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace cp_sh_cairo;

// Namespace cp_sh_cairo
// Params 0, eflags: 0x0
// Checksum 0xc38907c8, Offset: 0x498
// Size: 0x8c
function main() {
    setclearanceceiling(120);
    function_673254cc();
    cp_sh_cairo_fx::main();
    cp_sh_cairo_sound::main();
    load::main();
    level thread function_ad7adee8();
    level thread function_56051a78();
}

// Namespace cp_sh_cairo
// Params 0, eflags: 0x0
// Checksum 0x43373189, Offset: 0x530
// Size: 0x34
function function_673254cc() {
    skipto::add_dev("dev_no_bunk", &function_d525a88c, "No Bunk Start");
}

// Namespace cp_sh_cairo
// Params 2, eflags: 0x0
// Checksum 0x47462886, Offset: 0x570
// Size: 0x20
function function_d525a88c(str_objective, var_74cd64bc) {
    level.var_2e24ecad = 1;
}

// Namespace cp_sh_cairo
// Params 0, eflags: 0x0
// Checksum 0x49100808, Offset: 0x598
// Size: 0xf6
function function_ad7adee8() {
    level flag::wait_till("all_players_connected");
    level thread function_b7170f9e();
    safehouse::function_a85e8026(1);
    switch (level.next_map) {
    case "cp_mi_cairo_infection":
    case "cp_mi_cairo_infection2":
    case "cp_mi_cairo_infection3":
        level util::set_lighting_state(0);
        break;
    case "cp_mi_cairo_aquifer":
        level util::set_lighting_state(1);
        break;
    case "cp_mi_cairo_lotus":
    case "cp_mi_cairo_lotus2":
    case "cp_mi_cairo_lotus3":
        level util::set_lighting_state(0);
        break;
    }
}

// Namespace cp_sh_cairo
// Params 0, eflags: 0x0
// Checksum 0x98a7a80e, Offset: 0x698
// Size: 0x19e
function function_b7170f9e() {
    var_67a453fb = getvehiclespawnerarray("ambient_vtol", "targetname");
    while (true) {
        var_67a453fb = array::randomize(var_67a453fb);
        foreach (var_1f3f1cb0 in var_67a453fb) {
            var_1f3f1cb0.count++;
            nd_start = getvehiclenode(var_1f3f1cb0.target, "targetname");
            var_edc6e0e1 = spawner::simple_spawn_single(var_1f3f1cb0);
            var_edc6e0e1 pathvariableoffset((300, 300, 300), 3);
            var_edc6e0e1 thread vehicle::get_on_and_go_path(nd_start);
            wait randomfloatrange(30, 90);
        }
    }
}

// Namespace cp_sh_cairo
// Params 0, eflags: 0x0
// Checksum 0x6a875da3, Offset: 0x840
// Size: 0x366
function function_56051a78() {
    a_str_scenes = [];
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_saf_ram_armory_vign_repair_3dprinter";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_saf_ram_armory_vign_tech_bunk";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_saf_ram_armory_vign_tech_inspect";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_saf_ram_armory_vign_tech_diagnostics";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_saf_ram_armory_vign_tech_firerange";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_saf_ram_armory_vign_tech_datavault";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_saf_ram_armory_vign_supply_box";
    a_str_scenes = array::randomize(a_str_scenes);
    var_c25c66df = randomintrange(4, 6);
    /#
    #/
    for (var_8640fa79 = 0; var_8640fa79 < var_c25c66df; var_8640fa79++) {
        str_scene = a_str_scenes[var_8640fa79];
        level thread scene::play(str_scene);
    }
}

