#using scripts/zm/zm_tomb_vo;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_main_quest;
#using scripts/zm/zm_tomb_amb;
#using scripts/zm/_zm_ai_quadrotor;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_audio;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_tomb_craftables;

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0x6863187a, Offset: 0x1308
// Size: 0x1a6
function function_cdc13aec() {
    var_b48ac10c = array("gramophone_vinyl_ice", "gramophone_vinyl_air", "gramophone_vinyl_elec", "gramophone_vinyl_fire", "gramophone_vinyl_master", "gramophone_vinyl_player");
    foreach (var_deec1671 in var_b48ac10c) {
        var_d1ad01b9 = struct::get(var_deec1671, "targetname");
        var_87da21cb = struct::get_array(var_deec1671 + "_alt", "targetname");
        n_loc_index = randomintrange(0, var_87da21cb.size + 1);
        if (n_loc_index == var_87da21cb.size) {
            continue;
        }
        var_d1ad01b9.origin = var_87da21cb[n_loc_index].origin;
        var_d1ad01b9.angles = var_87da21cb[n_loc_index].angles;
    }
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0x471f27ce, Offset: 0x14b8
// Size: 0x4a0
function function_95743e9f() {
    level flag::init("quadrotor_cooling_down");
    level.var_90238c9a = 4;
    level flag::init("any_crystal_picked_up");
    level flag::init("staff_air_zm_enabled");
    level flag::init("staff_fire_zm_enabled");
    level flag::init("staff_lightning_zm_enabled");
    level flag::init("staff_water_zm_enabled");
    level flag::init("staff_air_picked_up");
    level flag::init("staff_fire_picked_up");
    level flag::init("staff_lightning_picked_up");
    level flag::init("staff_water_picked_up");
    zm_craftables::function_8421d708("equip_dieseldrone", %ZM_TOMB_CRQ, %ZM_TOMB_CRQ, %ZM_TOMB_TQ, &function_e2076525, 1);
    zm_craftables::function_b2caef35("equip_dieseldrone", "build_dd");
    zm_craftables::function_c86d092("equip_dieseldrone", "veh_t7_dlc_zm_quadrotor", (0, 0, 0), (0, -4, 10));
    zm_craftables::function_8421d708("elemental_staff_fire", %ZM_TOMB_CRF, %ZM_TOMB_INS, %ZM_TOMB_BOF, &function_6a4fbed6, 1);
    zm_craftables::function_b2caef35("elemental_staff_fire", "fire_staff");
    zm_craftables::function_8421d708("elemental_staff_air", %ZM_TOMB_CRA, %ZM_TOMB_INS, %ZM_TOMB_BOA, &function_c67d74ce, 1);
    zm_craftables::function_b2caef35("elemental_staff_air", "air_staff");
    zm_craftables::function_8421d708("elemental_staff_lightning", %ZM_TOMB_CRL, %ZM_TOMB_INS, %ZM_TOMB_BOL, &function_8feb5840, 1);
    zm_craftables::function_b2caef35("elemental_staff_lightning", "light_staff");
    zm_craftables::function_8421d708("elemental_staff_water", %ZM_TOMB_CRW, %ZM_TOMB_INS, %ZM_TOMB_BOW, &function_11d70761, 1);
    zm_craftables::function_b2caef35("elemental_staff_water", "ice_staff");
    zm_craftables::function_8421d708("gramophone", %ZM_TOMB_CRAFT_GRAMOPHONE, %ZM_TOMB_CRAFT_GRAMOPHONE, %ZM_TOMB_BOUGHT_GRAMOPHONE, undefined, 0);
    zm_craftables::function_b2caef35("gramophone", "gramophone");
    level.var_443764ab = &function_db3359f1;
    level.var_93b7659f = &function_568dc89e;
    level.var_14adb6f4 = &function_d00832ac;
    level thread function_80834820();
    level.var_3c3bf0e1 = spawnstruct();
    level.var_3c3bf0e1.crafted = 0;
    level.var_3c3bf0e1.picked_up = 0;
    level.var_a133a800 = [];
    level.var_b79a2c38 = [];
    level.var_c01c54cd = 0;
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0xc1681eef, Offset: 0x1960
// Size: 0x392
function function_6442c1bd(craftable) {
    /#
        if (!isdefined(level.var_b68fa2a8)) {
            level.var_b68fa2a8 = [];
        }
        foreach (var_b1028d0b in craftable.var_7a5f63bc) {
            var_9cd24e96 = undefined;
            var_33246a9d = undefined;
            if (isdefined(var_b1028d0b.var_c05b32e7)) {
                var_9cd24e96 = var_b1028d0b.var_c05b32e7;
                var_33246a9d = var_9cd24e96;
            } else if (isdefined(var_b1028d0b.var_dcc30f2f)) {
                var_9cd24e96 = "<dev string:x28>";
                var_33246a9d = var_b1028d0b.var_dcc30f2f;
            } else {
                continue;
            }
            tokens = strtok(var_9cd24e96, "<dev string:x2c>");
            var_bbbb8e53 = "<dev string:x2e>";
            foreach (token in tokens) {
                if (token != "<dev string:x2e>" && token != "<dev string:x34>" && token != "<dev string:x3a>") {
                    var_bbbb8e53 = var_bbbb8e53 + "<dev string:x2c>" + token;
                }
            }
            level.var_b68fa2a8["<dev string:x3d>" + var_33246a9d] = var_b1028d0b;
            adddebugcommand("<dev string:x3e>" + craftable.name + "<dev string:x5e>" + var_bbbb8e53 + "<dev string:x60>" + var_33246a9d + "<dev string:x73>");
            var_b1028d0b.var_7080cd19 = "<dev string:x76>";
        }
        wait 0.05;
        level flag::wait_till("<dev string:x7c>");
        wait 0.05;
        foreach (var_b1028d0b in craftable.var_7a5f63bc) {
            var_b1028d0b function_c3207981();
            var_b1028d0b.var_5b55e566.model thread zm_tomb_utility::function_5de0d079("<dev string:x95>", (0, 255, 0), undefined, "<dev string:x97>");
        }
    #/
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0x810fa213, Offset: 0x1d00
// Size: 0x2c6
function autocraft_staffs() {
    setdvar("autocraft_staffs", "off");
    /#
        adddebugcommand("<dev string:xb0>");
    #/
    while (getdvarstring("autocraft_staffs") != "on") {
        util::wait_network_frame();
    }
    level flag::wait_till("start_zombie_round_logic");
    keys = getarraykeys(level.var_b68fa2a8);
    a_players = getplayers();
    foreach (key in keys) {
        if (issubstr(key, "staff") || issubstr(key, "record")) {
            var_b1028d0b = level.var_b68fa2a8[key];
            if (isdefined(var_b1028d0b.var_5b55e566)) {
                a_players[0] zm_craftables::function_d1aff147(var_b1028d0b.var_5b55e566);
            }
        }
    }
    for (i = 1; i <= 4; i++) {
        level notify(#"hash_62857917", a_players[0], i);
        util::wait_network_frame();
        var_6e606195 = level.var_b68fa2a8["" + i].var_5b55e566;
        if (isdefined(var_6e606195)) {
            if (isdefined(a_players[i - 1])) {
                a_players[i - 1] zm_craftables::function_d1aff147(var_6e606195);
                util::wait_network_frame();
            }
        }
        util::wait_network_frame();
    }
}

/#

    // Namespace zm_tomb_craftables
    // Params 0, eflags: 0x0
    // Checksum 0x2dd7e159, Offset: 0x1fd0
    // Size: 0x110
    function function_bd335247() {
        level thread autocraft_staffs();
        setdvar("<dev string:xfa>", "<dev string:x3d>");
        while (true) {
            var_6d9966ef = getdvarstring("<dev string:xfa>");
            if (var_6d9966ef != "<dev string:x3d>") {
                var_6e606195 = level.var_b68fa2a8[var_6d9966ef].var_5b55e566;
                if (isdefined(var_6e606195)) {
                    players = getplayers();
                    players[0] zm_craftables::function_d1aff147(var_6e606195);
                }
                setdvar("<dev string:xfa>", "<dev string:x3d>");
            }
            wait 0.05;
        }
    }

#/

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0xc5597f56, Offset: 0x20e8
// Size: 0x13ac
function function_3ebec56b() {
    var_9967ff1 = "equip_dieseldrone";
    var_b0e1f6b = zm_craftables::function_5cf75ff1(var_9967ff1, "body", 32, 64, 0, undefined, &function_66a9cb86, &function_31edd14b, undefined, undefined, undefined, undefined, "piece_quadrotor_zm_body", 1, "build_dd", 0);
    var_35fab2b5 = zm_craftables::function_5cf75ff1(var_9967ff1, "brain", 32, 64, 0, undefined, &function_66a9cb86, &function_31edd14b, undefined, undefined, undefined, undefined, "piece_quadrotor_zm_brain", 1, "build_dd_brain", 0);
    var_d015c5a5 = zm_craftables::function_5cf75ff1(var_9967ff1, "engine", 32, 64, 0, undefined, &function_66a9cb86, &function_31edd14b, undefined, undefined, undefined, undefined, "piece_quadrotor_zm_engine", 1, "build_dd", 0);
    var_b0e1f6b thread function_eebc4ca9("piece_quadrotor_zm_body", 1, "zmInventory.show_maxis_drone_parts_widget");
    var_35fab2b5 thread function_eebc4ca9("piece_quadrotor_zm_brain", 1, "zmInventory.show_maxis_drone_parts_widget");
    var_d015c5a5 thread function_eebc4ca9("piece_quadrotor_zm_engine", 1, "zmInventory.show_maxis_drone_parts_widget");
    var_28c00c94 = spawnstruct();
    var_28c00c94.name = var_9967ff1;
    var_28c00c94 zm_craftables::function_b0deb4e6(var_b0e1f6b);
    var_28c00c94 zm_craftables::function_b0deb4e6(var_35fab2b5);
    var_28c00c94 zm_craftables::function_b0deb4e6(var_d015c5a5);
    var_28c00c94.var_41f0f8cd = &function_69ac47ee;
    zm_craftables::function_ac4e44a7(var_28c00c94);
    level thread function_6442c1bd(var_28c00c94);
    var_9967ff1 = "gramophone";
    var_c057ef82 = function_f130c3de(var_9967ff1, "vinyl_player", "p7_spl_gramophone", "piece_record_zm_player", undefined, "gramophone", "zmInventory.show_musical_parts_widget");
    var_51b81757 = function_f130c3de(var_9967ff1, "vinyl_master", "p7_zm_ori_record_vinyl_master", "piece_record_zm_vinyl_master", undefined, "record", "zmInventory.show_musical_parts_widget");
    var_82e2c59b = function_f130c3de(var_9967ff1, "vinyl_air", "p7_zm_ori_record_vinyl_wind", "piece_record_zm_vinyl_air", "air_staff.quest_state", "record", "zmInventory.air_staff.visible");
    var_156bde2e = function_f130c3de(var_9967ff1, "vinyl_ice", "p7_zm_ori_record_vinyl_ice", "piece_record_zm_vinyl_water", "water_staff.quest_state", "record", "zmInventory.water_staff.visible");
    var_6c9c14c9 = function_f130c3de(var_9967ff1, "vinyl_fire", "p7_zm_ori_record_vinyl_fire", "piece_record_zm_vinyl_fire", "fire_staff.quest_state", "record", "zmInventory.fire_staff.visible");
    var_1654caa2 = function_f130c3de(var_9967ff1, "vinyl_elec", "p7_zm_ori_record_vinyl_lightning", "piece_record_zm_vinyl_lightning", "lightning_staff.quest_state", "record", "zmInventory.lightning_staff.visible");
    var_c057ef82.var_4f3cca3 = "gramophone_found";
    var_51b81757.var_4f3cca3 = "master_found";
    var_82e2c59b.var_4f3cca3 = "first_record_found";
    var_156bde2e.var_4f3cca3 = "first_record_found";
    var_6c9c14c9.var_4f3cca3 = "first_record_found";
    var_1654caa2.var_4f3cca3 = "first_record_found";
    level thread zm_tomb_vo::function_68eb779("vox_sam_1st_record_found_0", "first_record_found");
    level thread zm_tomb_vo::function_68eb779("vox_sam_gramophone_found_0", "gramophone_found");
    level thread zm_tomb_vo::function_68eb779("vox_sam_master_found_0", "master_found");
    gramophone = spawnstruct();
    gramophone.name = var_9967ff1;
    gramophone zm_craftables::function_b0deb4e6(var_c057ef82);
    gramophone zm_craftables::function_b0deb4e6(var_51b81757);
    gramophone zm_craftables::function_b0deb4e6(var_82e2c59b);
    gramophone zm_craftables::function_b0deb4e6(var_156bde2e);
    gramophone zm_craftables::function_b0deb4e6(var_6c9c14c9);
    gramophone zm_craftables::function_b0deb4e6(var_1654caa2);
    gramophone.var_41f0f8cd = &function_84d14ecd;
    zm_craftables::function_ac4e44a7(gramophone);
    level thread function_6442c1bd(gramophone);
    var_9967ff1 = "elemental_staff_air";
    var_ce6bcac4 = zm_craftables::function_5cf75ff1(var_9967ff1, "gem", 48, 64, 0, undefined, &function_a0621a83, &function_5c80788a, undefined, undefined, undefined, undefined, 2, 0, "crystal", 1);
    var_6a48ae22 = zm_craftables::function_5cf75ff1(var_9967ff1, "upper_staff", 32, 64, 0, undefined, &function_f35af043, &function_31edd14b, undefined, undefined, undefined, undefined, "air_staff.piece_zm_ustaff", 1, "staff_part");
    var_187b2973 = zm_craftables::function_5cf75ff1(var_9967ff1, "middle_staff", 32, 64, 0, undefined, &function_f35af043, &function_31edd14b, undefined, undefined, undefined, undefined, "air_staff.piece_zm_mstaff", 1, "staff_part");
    var_437c8f91 = zm_craftables::function_5cf75ff1(var_9967ff1, "lower_staff", 32, 64, 0, undefined, &function_f35af043, &function_31edd14b, undefined, undefined, undefined, undefined, "air_staff.piece_zm_lstaff", 1, "staff_part");
    staff = spawnstruct();
    staff.name = var_9967ff1;
    staff zm_craftables::function_b0deb4e6(var_ce6bcac4);
    staff zm_craftables::function_b0deb4e6(var_6a48ae22);
    staff zm_craftables::function_b0deb4e6(var_187b2973);
    staff zm_craftables::function_b0deb4e6(var_437c8f91);
    staff.var_41f0f8cd = &function_a6c22658;
    staff.var_855e2ef2 = &function_db7cb849;
    zm_craftables::function_ac4e44a7(staff);
    level thread function_6442c1bd(staff);
    function_6c0a645(array(var_6a48ae22, var_187b2973, var_437c8f91));
    var_9967ff1 = "elemental_staff_fire";
    var_ea18101c = zm_craftables::function_5cf75ff1(var_9967ff1, "gem", 48, 64, 0, undefined, &function_15f35ef1, &function_8eba867a, undefined, undefined, undefined, undefined, 1, 0, "crystal", 1);
    var_2b72ecda = zm_craftables::function_5cf75ff1(var_9967ff1, "upper_staff", 32, 64, 0, undefined, &function_4d932a71, &function_31edd14b, undefined, undefined, undefined, undefined, "fire_staff.piece_zm_ustaff", 1, "staff_part");
    var_ff1e128b = zm_craftables::function_5cf75ff1(var_9967ff1, "middle_staff", 32, 64, 0, undefined, &function_4d932a71, &function_31edd14b, undefined, undefined, undefined, undefined, "fire_staff.piece_zm_mstaff", 1, "staff_part");
    var_dad0d129 = zm_craftables::function_5cf75ff1(var_9967ff1, "lower_staff", 64, -128, 0, undefined, &function_4d932a71, &function_31edd14b, undefined, undefined, undefined, undefined, "fire_staff.piece_zm_lstaff", 1, "staff_part");
    level thread zm_tomb_main_quest::function_4e6893a1(var_dad0d129);
    level thread zm_tomb_main_quest::function_bf15ae49(array(var_ff1e128b));
    level thread zm_tomb_main_quest::function_ba3cc7f(var_2b72ecda);
    staff = spawnstruct();
    staff.name = var_9967ff1;
    staff zm_craftables::function_b0deb4e6(var_ea18101c);
    staff zm_craftables::function_b0deb4e6(var_2b72ecda);
    staff zm_craftables::function_b0deb4e6(var_ff1e128b);
    staff zm_craftables::function_b0deb4e6(var_dad0d129);
    staff.var_41f0f8cd = &function_2b5ac210;
    staff.var_855e2ef2 = &function_db7cb849;
    zm_craftables::function_ac4e44a7(staff);
    level thread function_6442c1bd(staff);
    function_6c0a645(array(var_2b72ecda, var_ff1e128b, var_dad0d129));
    var_9967ff1 = "elemental_staff_lightning";
    var_a7744dee = zm_craftables::function_5cf75ff1(var_9967ff1, "gem", 48, 64, 0, undefined, &function_f138eba9, &function_2e9c07f4, undefined, undefined, undefined, undefined, 3, 0, "crystal", 1);
    var_1af5cbd4 = zm_craftables::function_5cf75ff1(var_9967ff1, "upper_staff", 32, 64, 0, undefined, &function_47c3d969, &function_31edd14b, undefined, undefined, undefined, undefined, "lightning_staff.piece_zm_ustaff", 1, "staff_part");
    var_1ca5615 = zm_craftables::function_5cf75ff1(var_9967ff1, "middle_staff", 32, 64, 0, undefined, &function_47c3d969, &function_31edd14b, undefined, undefined, undefined, undefined, "lightning_staff.piece_zm_mstaff", 1, "staff_part");
    var_8a2c31b3 = zm_craftables::function_5cf75ff1(var_9967ff1, "lower_staff", 32, 64, 0, undefined, &function_47c3d969, &function_31edd14b, undefined, undefined, undefined, undefined, "lightning_staff.piece_zm_lstaff", 1, "staff_part");
    staff = spawnstruct();
    staff.name = var_9967ff1;
    staff zm_craftables::function_b0deb4e6(var_a7744dee);
    staff zm_craftables::function_b0deb4e6(var_1af5cbd4);
    staff zm_craftables::function_b0deb4e6(var_1ca5615);
    staff zm_craftables::function_b0deb4e6(var_8a2c31b3);
    staff.var_41f0f8cd = &function_c2ade9a2;
    staff.var_855e2ef2 = &function_db7cb849;
    zm_craftables::function_ac4e44a7(staff);
    level thread function_6442c1bd(staff);
    function_6c0a645(array(var_1af5cbd4, var_1ca5615, var_8a2c31b3));
    var_9967ff1 = "elemental_staff_water";
    var_8bc6e0d9 = zm_craftables::function_5cf75ff1(var_9967ff1, "gem", 48, 64, 0, undefined, &function_4d965f64, &function_543ed0c1, undefined, undefined, undefined, undefined, 4, 0, "crystal", 1);
    var_729020bb = zm_craftables::function_5cf75ff1(var_9967ff1, "upper_staff", 32, 64, 0, undefined, &function_6c091d36, &function_31edd14b, undefined, undefined, undefined, undefined, "water_staff.piece_zm_ustaff", 1, "staff_part");
    var_d5151e38 = zm_craftables::function_5cf75ff1(var_9967ff1, "middle_staff", 32, 64, 0, undefined, &function_6c091d36, &function_31edd14b, undefined, undefined, undefined, undefined, "water_staff.piece_zm_mstaff", 1, "staff_part");
    var_4fd16468 = zm_craftables::function_5cf75ff1(var_9967ff1, "lower_staff", 32, 64, 0, undefined, &function_6c091d36, &function_31edd14b, undefined, undefined, undefined, undefined, "water_staff.piece_zm_lstaff", 1, "staff_part");
    var_9013fd72 = array(var_4fd16468, var_d5151e38, var_729020bb);
    level thread zm_tomb_main_quest::function_ca57c87a(var_9013fd72);
    staff = spawnstruct();
    staff.name = var_9967ff1;
    staff zm_craftables::function_b0deb4e6(var_8bc6e0d9);
    staff zm_craftables::function_b0deb4e6(var_729020bb);
    staff zm_craftables::function_b0deb4e6(var_d5151e38);
    staff zm_craftables::function_b0deb4e6(var_4fd16468);
    staff.var_41f0f8cd = &function_cac3b361;
    staff.var_855e2ef2 = &function_db7cb849;
    zm_craftables::function_ac4e44a7(staff);
    level thread function_6442c1bd(staff);
    function_6c0a645(array(var_729020bb, var_d5151e38, var_4fd16468));
    var_ea18101c thread function_eebc4ca9("fire_staff.quest_state", 2);
    var_ce6bcac4 thread function_eebc4ca9("air_staff.quest_state", 2);
    var_a7744dee thread function_eebc4ca9("lightning_staff.quest_state", 2);
    var_8bc6e0d9 thread function_eebc4ca9("water_staff.quest_state", 2);
    var_ea18101c thread zm_tomb_main_quest::function_b15d5ee0(1);
    var_ce6bcac4 thread zm_tomb_main_quest::function_b15d5ee0(2);
    var_a7744dee thread zm_tomb_main_quest::function_b15d5ee0(3);
    var_8bc6e0d9 thread zm_tomb_main_quest::function_b15d5ee0(4);
    level thread function_1bf61c98();
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0x8a9261b9, Offset: 0x34a0
// Size: 0x964
function register_clientfields() {
    bits = 1;
    clientfield::register("world", "piece_quadrotor_zm_body", 21000, bits, "int");
    clientfield::register("world", "piece_quadrotor_zm_brain", 21000, bits, "int");
    clientfield::register("world", "piece_quadrotor_zm_engine", 21000, bits, "int");
    clientfield::register("world", "air_staff.piece_zm_gem", 21000, bits, "int");
    clientfield::register("world", "air_staff.piece_zm_ustaff", 21000, bits, "int");
    clientfield::register("world", "air_staff.piece_zm_mstaff", 21000, bits, "int");
    clientfield::register("world", "air_staff.piece_zm_lstaff", 21000, bits, "int");
    clientfield::register("clientuimodel", "zmInventory.air_staff.visible", 21000, bits, "int");
    clientfield::register("world", "fire_staff.piece_zm_gem", 21000, bits, "int");
    clientfield::register("world", "fire_staff.piece_zm_ustaff", 21000, bits, "int");
    clientfield::register("world", "fire_staff.piece_zm_mstaff", 21000, bits, "int");
    clientfield::register("world", "fire_staff.piece_zm_lstaff", 21000, bits, "int");
    clientfield::register("clientuimodel", "zmInventory.fire_staff.visible", 21000, bits, "int");
    clientfield::register("world", "lightning_staff.piece_zm_gem", 21000, bits, "int");
    clientfield::register("world", "lightning_staff.piece_zm_ustaff", 21000, bits, "int");
    clientfield::register("world", "lightning_staff.piece_zm_mstaff", 21000, bits, "int");
    clientfield::register("world", "lightning_staff.piece_zm_lstaff", 21000, bits, "int");
    clientfield::register("clientuimodel", "zmInventory.lightning_staff.visible", 21000, bits, "int");
    clientfield::register("world", "water_staff.piece_zm_gem", 21000, bits, "int");
    clientfield::register("world", "water_staff.piece_zm_ustaff", 21000, bits, "int");
    clientfield::register("world", "water_staff.piece_zm_mstaff", 21000, bits, "int");
    clientfield::register("world", "water_staff.piece_zm_lstaff", 21000, bits, "int");
    clientfield::register("clientuimodel", "zmInventory.water_staff.visible", 21000, bits, "int");
    clientfield::register("world", "piece_record_zm_player", 21000, bits, "int");
    clientfield::register("world", "piece_record_zm_vinyl_master", 21000, bits, "int");
    clientfield::register("world", "piece_record_zm_vinyl_air", 21000, bits, "int");
    clientfield::register("world", "piece_record_zm_vinyl_water", 21000, bits, "int");
    clientfield::register("world", "piece_record_zm_vinyl_fire", 21000, bits, "int");
    clientfield::register("world", "piece_record_zm_vinyl_lightning", 21000, bits, "int");
    clientfield::register("scriptmover", "element_glow_fx", 21000, 4, "int");
    clientfield::register("scriptmover", "bryce_cake", 21000, 2, "int");
    clientfield::register("scriptmover", "switch_spark", 21000, 1, "int");
    clientfield::register("scriptmover", "plane_fx", 21000, 1, "int");
    bits = getminbitcountfornum(5);
    clientfield::register("world", "air_staff.holder", 21000, bits, "int");
    clientfield::register("world", "fire_staff.holder", 21000, bits, "int");
    clientfield::register("world", "lightning_staff.holder", 21000, bits, "int");
    clientfield::register("world", "water_staff.holder", 21000, bits, "int");
    bits = getminbitcountfornum(5);
    clientfield::register("world", "fire_staff.quest_state", 21000, bits, "int");
    clientfield::register("world", "air_staff.quest_state", 21000, bits, "int");
    clientfield::register("world", "lightning_staff.quest_state", 21000, bits, "int");
    clientfield::register("world", "water_staff.quest_state", 21000, bits, "int");
    clientfield::register("toplayer", "sndMudSlow", 21000, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.show_maxis_drone_parts_widget", 21000, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.current_gem", 21000, getminbitcountfornum(5), "int");
    clientfield::register("clientuimodel", "zmInventory.show_musical_parts_widget", 21000, 1, "int");
    clientfield::register("clientuimodel", "hudItems.showDpadRight_Drone", 21000, 1, "int");
    clientfield::register("clientuimodel", "hudItems.showDpadLeft_Staff", 21000, 1, "int");
    clientfield::register("clientuimodel", "hudItems.dpadLeftAmmo", 21000, 2, "int");
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0x8f68ef57, Offset: 0x3e10
// Size: 0x300
function function_1bf61c98() {
    level flagsys::wait_till("load_main_complete");
    level flag::wait_till("start_zombie_round_logic");
    foreach (var_3111271f in level.var_b09bbe80) {
        if (!issubstr(var_3111271f.name, "elemental_staff")) {
            continue;
        }
        var_f48065fd = 0;
        if (issubstr(var_3111271f.name, "fire")) {
            var_f48065fd = 1;
        } else if (issubstr(var_3111271f.name, "air")) {
            var_f48065fd = 2;
        } else if (issubstr(var_3111271f.name, "lightning")) {
            var_f48065fd = 3;
        } else if (issubstr(var_3111271f.name, "water")) {
            var_f48065fd = 4;
        } else {
            /#
                iprintlnbold("<dev string:x109>" + var_3111271f.name);
            #/
            return;
        }
        foreach (var_b1028d0b in var_3111271f.var_7a5f63bc) {
            if (var_b1028d0b.piecename == "gem") {
                continue;
            }
            var_b1028d0b function_c3207981();
            var_276da4fb = var_f48065fd == 3 || var_f48065fd == 2;
            var_b1028d0b.var_5b55e566.model thread function_8cf5108b(var_f48065fd, var_276da4fb);
        }
    }
}

// Namespace zm_tomb_craftables
// Params 2, eflags: 0x1 linked
// Checksum 0x178dc82c, Offset: 0x4118
// Size: 0x54
function function_8cf5108b(var_f48065fd, var_276da4fb) {
    self endon(#"death");
    if (!var_276da4fb) {
        self waittill(#"hash_cac472aa");
    }
    self clientfield::set("element_glow_fx", var_f48065fd);
}

// Namespace zm_tomb_craftables
// Params 3, eflags: 0x1 linked
// Checksum 0x8bded710, Offset: 0x4178
// Size: 0x15e
function function_db7cb849(player, var_818b04f5, trigger) {
    str_flag = self.weaponname.name + "_picked_up";
    if (level flag::get(str_flag)) {
        return 0;
    }
    if (isdefined(self.crafted) && self.crafted) {
        return 1;
    }
    self.hint_string = %ZOMBIE_BUILD_PIECE_MORE;
    if (isdefined(player)) {
        if (!isdefined(player.var_1666fe57) || player.var_1666fe57.size < 1) {
            return 0;
        }
        if (!self.craftablespawn zm_craftables::function_b008df77(player.var_1666fe57[0])) {
            self.hint_string = %ZOMBIE_BUILD_PIECE_WRONG;
            return 0;
        }
    }
    if (level.var_6b14ee9b[self.craftablespawn.var_9967ff1] == 0) {
        self.hint_string = level.var_a7e9c2bf[self.equipname].var_d6fd6d9d;
        return 1;
    }
    return 0;
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0xe9b1b6a3, Offset: 0x42e0
// Size: 0x3c
function function_f89bb811() {
    level.var_f72b0650 = 0;
    while (true) {
        util::wait_network_frame();
        level.var_f72b0650 = 0;
    }
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0xb2c122b, Offset: 0x4328
// Size: 0x58
function function_e1832857() {
    if (!isdefined(level.var_f72b0650)) {
        level thread function_f89bb811();
    }
    while (level.var_f72b0650 >= 2) {
        util::wait_network_frame();
    }
    level.var_f72b0650++;
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0x48a6173f, Offset: 0x4388
// Size: 0x4c
function function_69ac47ee() {
    function_e1832857();
    zm_craftables::function_4f91b11d("quadrotor_zm_craftable_trigger", "equip_dieseldrone", "equip_dieseldrone", %ZM_TOMB_TQ, 1, 1);
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0x1c31d231, Offset: 0x43e0
// Size: 0x4c
function function_a6c22658() {
    function_e1832857();
    zm_craftables::function_4f91b11d("staff_air_craftable_trigger", "elemental_staff_air", "staff_air", %ZM_TOMB_PUAS, 1, 1);
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0x1d8610bd, Offset: 0x4438
// Size: 0x4c
function function_2b5ac210() {
    function_e1832857();
    zm_craftables::function_4f91b11d("staff_fire_craftable_trigger", "elemental_staff_fire", "staff_fire", %ZM_TOMB_PUFS, 1, 1);
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0xdcc289de, Offset: 0x4490
// Size: 0x4c
function function_c2ade9a2() {
    function_e1832857();
    zm_craftables::function_4f91b11d("staff_lightning_craftable_trigger", "elemental_staff_lightning", "staff_lightning", %ZM_TOMB_PULS, 1, 1);
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0x247f7b66, Offset: 0x44e8
// Size: 0x4c
function function_cac3b361() {
    function_e1832857();
    zm_craftables::function_4f91b11d("staff_water_craftable_trigger", "elemental_staff_water", "staff_water", %ZM_TOMB_PUIS, 1, 1);
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0xd07735ef, Offset: 0x4540
// Size: 0x4c
function function_84d14ecd() {
    function_e1832857();
    zm_craftables::function_4f91b11d("gramophone_craftable_trigger", "gramophone", "gramophone", %ZOMBIE_GRAB_GRAMOPHONE, 1, 1);
}

// Namespace zm_tomb_craftables
// Params 3, eflags: 0x0
// Checksum 0xc1256e2b, Offset: 0x4598
// Size: 0x9c
function function_ba68e20(player, var_6786d459, var_81f08be9) {
    if (level.var_f793f80e getspeedmph() > 0) {
        if (isdefined(self)) {
            self.hint_string = "";
            if (isdefined(var_6786d459) && var_6786d459 && isdefined(var_81f08be9)) {
                var_81f08be9 sethintstring(self.hint_string);
            }
        }
        return false;
    }
    return true;
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0x7b71d7c0, Offset: 0x4640
// Size: 0x16
function function_31edd14b(player) {
    self.var_77a0498d = undefined;
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0x2233d270, Offset: 0x4660
// Size: 0x110
function function_318b7336(player) {
    function_31edd14b(player);
    var_b1028d0b = self.var_da5b715d;
    var_b1028d0b.var_5b55e566.canmove = 1;
    zm_unitrigger::reregister_unitrigger_as_dynamic(var_b1028d0b.var_5b55e566.unitrigger);
    var_d1ad01b9 = struct::get(self.var_dba2448c + "_" + self.piecename);
    var_b1028d0b.var_5b55e566.model.origin = var_d1ad01b9.origin;
    var_b1028d0b.var_5b55e566.model.angles = var_d1ad01b9.angles;
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0xd730f0f6, Offset: 0x4778
// Size: 0xa4
function function_8eba867a(player) {
    level clientfield::set("fire_staff.piece_zm_gem", 0);
    level clientfield::set("fire_staff.quest_state", 1);
    level clientfield::set("piece_record_zm_vinyl_fire", 0);
    player function_9d221ddb(1, "fire_staff.holder");
    function_318b7336(player);
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0xbf32898c, Offset: 0x4828
// Size: 0xa4
function function_5c80788a(player) {
    level clientfield::set("air_staff.piece_zm_gem", 0);
    level clientfield::set("air_staff.quest_state", 1);
    level clientfield::set("piece_record_zm_vinyl_air", 0);
    player function_9d221ddb(2, "air_staff.holder");
    function_318b7336(player);
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0x21ee29ed, Offset: 0x48d8
// Size: 0xa4
function function_2e9c07f4(player) {
    level clientfield::set("lightning_staff.piece_zm_gem", 0);
    level clientfield::set("lightning_staff.quest_state", 1);
    level clientfield::set("piece_record_zm_vinyl_lightning", 0);
    player function_9d221ddb(3, "lightning_staff.holder");
    function_318b7336(player);
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0xca92f55, Offset: 0x4988
// Size: 0xa4
function function_543ed0c1(player) {
    level clientfield::set("water_staff.piece_zm_gem", 0);
    level clientfield::set("water_staff.quest_state", 1);
    level clientfield::set("piece_record_zm_vinyl_water", 0);
    player function_9d221ddb(4, "water_staff.holder");
    function_318b7336(player);
}

// Namespace zm_tomb_craftables
// Params 2, eflags: 0x1 linked
// Checksum 0x9976fcd6, Offset: 0x4a38
// Size: 0x68
function function_9d221ddb(var_b5f6f4e4, var_94f38c49) {
    if (var_b5f6f4e4 == self.var_5f154d23) {
        level clientfield::set(var_94f38c49, 0);
        self clientfield::set_player_uimodel("zmInventory.current_gem", 0);
        self.var_5f154d23 = 0;
    }
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0x7d9d49cf, Offset: 0x4aa8
// Size: 0xea
function function_a4b5301e(player) {
    wait 1;
    while (isdefined(player.isspeaking) && player.isspeaking) {
        util::wait_network_frame();
    }
    if (isdefined(self.var_da5b715d.var_e9202857)) {
        level notify(#"hash_9b82fb76", player, 0);
        level notify(self.var_da5b715d.var_e9202857, player);
        return;
    }
    if (isdefined(self.var_da5b715d.var_4f3cca3)) {
        level notify(#"hash_9b82fb76", player, 0);
        level notify(self.var_da5b715d.var_4f3cca3, player);
        return;
    }
    level notify(#"hash_9b82fb76", player, 1);
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0x6eaf8823, Offset: 0x4ba0
// Size: 0xd6
function function_66a9cb86(player) {
    player playsound("zmb_craftable_pickup");
    self.var_77a0498d = player;
    self thread function_a4b5301e(player);
    /#
        foreach (spawn in self.spawns) {
            spawn notify(#"stop_debug_position");
        }
    #/
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0x774b5f58, Offset: 0x4c80
// Size: 0xe4
function function_1f8b4ee() {
    if (!level flag::get("samantha_intro_done")) {
        return;
    }
    if (!(isdefined(level.var_ec22d724) && level.var_ec22d724)) {
        level.var_ec22d724 = 1;
        wait 1;
        zm_tomb_vo::function_eee384d4(1);
        zm_tomb_vo::function_10d15bb5("vox_sam_1st_staff_found_1_0", self, 1);
        zm_tomb_vo::function_10d15bb5("vox_sam_1st_staff_found_2_0", self);
        zm_tomb_vo::function_eee384d4(0);
        self zm_audio::create_and_play_dialog("staff", "first_piece");
    }
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0x663eb4ed, Offset: 0x4d70
// Size: 0x2c
function function_4d932a71(player) {
    function_a58e2875(player, "fire");
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0xd59fc7cb, Offset: 0x4da8
// Size: 0x2c
function function_f35af043(player) {
    function_a58e2875(player, "air");
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0x74964fee, Offset: 0x4de0
// Size: 0x2c
function function_47c3d969(player) {
    function_a58e2875(player, "lightning");
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0xc8e9a3f6, Offset: 0x4e18
// Size: 0x2c
function function_6c091d36(player) {
    function_a58e2875(player, "water");
}

// Namespace zm_tomb_craftables
// Params 2, eflags: 0x1 linked
// Checksum 0xebf24f6d, Offset: 0x4e50
// Size: 0x154
function function_a58e2875(player, elementname) {
    function_66a9cb86(player);
    if (!isdefined(level.var_a133a800[self.var_dba2448c])) {
        level.var_a133a800[self.var_dba2448c] = 0;
    }
    level.var_a133a800[self.var_dba2448c]++;
    if (level.var_a133a800[self.var_dba2448c] == 3) {
        level notify(self.var_dba2448c + "_all_pieces_found");
    }
    foreach (e_player in level.players) {
        e_player thread zm_craftables::function_97be99b3(undefined, "zmInventory." + elementname + "_staff.visible", 0);
    }
    player thread function_1f8b4ee();
}

// Namespace zm_tomb_craftables
// Params 3, eflags: 0x1 linked
// Checksum 0xede50013, Offset: 0x4fb0
// Size: 0x1cc
function function_d69dc795(player, elementname, var_36e3cbd4) {
    function_66a9cb86(player);
    level clientfield::set(elementname + "_staff.piece_zm_gem", 1);
    level clientfield::set(elementname + "_staff.holder", player.characterindex + 1);
    if (level flag::get("any_crystal_picked_up")) {
        self.var_da5b715d.var_5dbbf224 = undefined;
    }
    foreach (e_player in level.players) {
        e_player thread zm_craftables::function_97be99b3(undefined, "zmInventory." + elementname + "_staff.visible", 0);
    }
    player thread zm_craftables::function_97be99b3(undefined, "zmInventory.show_musical_parts_widget", 0);
    level flag::set("any_crystal_picked_up");
    player clientfield::set_player_uimodel("zmInventory.current_gem", player.var_5f154d23);
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0xe88811aa, Offset: 0x5188
// Size: 0x64
function function_15f35ef1(player) {
    level clientfield::set("fire_staff.quest_state", 2);
    player.var_5f154d23 = 1;
    function_d69dc795(player, "fire", 1);
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0x26bbc2ed, Offset: 0x51f8
// Size: 0x64
function function_a0621a83(player) {
    level clientfield::set("air_staff.quest_state", 2);
    player.var_5f154d23 = 2;
    function_d69dc795(player, "air", 2);
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0x641e52a6, Offset: 0x5268
// Size: 0x64
function function_f138eba9(player) {
    level clientfield::set("lightning_staff.quest_state", 2);
    player.var_5f154d23 = 3;
    function_d69dc795(player, "lightning", 3);
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0xd36e5ca6, Offset: 0x52d8
// Size: 0x64
function function_4d965f64(player) {
    level clientfield::set("water_staff.quest_state", 2);
    player.var_5f154d23 = 4;
    function_d69dc795(player, "water", 4);
}

// Namespace zm_tomb_craftables
// Params 7, eflags: 0x1 linked
// Checksum 0xf8d180c8, Offset: 0x5348
// Size: 0xe0
function function_f130c3de(var_7d7d7875, var_eb7058d5, str_model_name, var_aebb2010, var_69361faf, var_9d2951e8, var_e46422e8) {
    var_f36883de = 1;
    craftable = zm_craftables::function_5cf75ff1(var_7d7d7875, var_eb7058d5, 32, 64, 0, undefined, &function_66a9cb86, &function_31edd14b, undefined, undefined, undefined, undefined, var_aebb2010, 1, var_9d2951e8, var_f36883de, undefined, 0);
    craftable thread function_eebc4ca9(var_69361faf, 1, var_e46422e8);
    return craftable;
}

// Namespace zm_tomb_craftables
// Params 3, eflags: 0x1 linked
// Checksum 0x81978821, Offset: 0x5430
// Size: 0x13a
function function_eebc4ca9(var_69361faf, n_clientfield_val, var_e46422e8) {
    self function_c3207981();
    self.var_5b55e566 waittill(#"pickup");
    level notify(self.var_dba2448c + "_" + self.piecename + "_picked_up");
    if (isdefined(var_69361faf) && isdefined(n_clientfield_val)) {
        level clientfield::set(var_69361faf, n_clientfield_val);
    }
    if (isdefined(var_e46422e8)) {
        foreach (e_player in level.players) {
            e_player thread zm_craftables::function_97be99b3(undefined, var_e46422e8, 0);
        }
    }
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0x26b5ff8f, Offset: 0x5578
// Size: 0x10a
function function_6c0a645(var_dc2f4915) {
    if (!isdefined(level.var_6b14ee9b)) {
        level.var_6b14ee9b = [];
    }
    str_name = var_dc2f4915[0].var_dba2448c;
    level.var_6b14ee9b[str_name] = var_dc2f4915.size;
    foreach (piece in var_dc2f4915) {
        assert(piece.var_dba2448c == str_name);
        piece thread function_e7dc448c();
    }
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0xde284e20, Offset: 0x5690
// Size: 0x28
function function_c3207981() {
    while (!isdefined(self.var_5b55e566)) {
        util::wait_network_frame();
    }
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0xb9fdf290, Offset: 0x56c0
// Size: 0x42
function function_e7dc448c() {
    self function_c3207981();
    self.var_5b55e566 waittill(#"pickup");
    level.var_6b14ee9b[self.var_dba2448c]--;
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0x5b866dfa, Offset: 0x5710
// Size: 0x10e
function function_e2076525(player) {
    level.var_3c3bf0e1.crafted = 1;
    zm_craftables::function_21cc3865("equip_dieseldrone", 1);
    self.var_855e2ef2 = &function_52fbdde1;
    pickup_trig = level.var_3c3bf0e1.pickup_trig;
    level.var_3c3bf0e1.str_zone = zm_zonemgr::get_zone_from_position(pickup_trig.origin, 1);
    pickup_trig.model setmodel("veh_t7_dlc_zm_quadrotor");
    pickup_trig.model setscale(0.7);
    level notify(#"hash_9b82fb76", player, 1);
    return true;
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0x1cbb14b, Offset: 0x5828
// Size: 0x170
function function_52fbdde1(player) {
    var_703e6a13 = getweapon("equip_dieseldrone");
    if (player hasweapon(var_703e6a13)) {
        self.hint_string = %ZOMBIE_BUILD_PIECE_HAVE_ONE;
        return false;
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (players[i] hasweapon(var_703e6a13)) {
            self.hint_string = %DLC5_QUADROTOR_UNAVAILABLE;
            return false;
        }
    }
    var_d217d07 = getentarray("quadrotor_ai", "targetname");
    if (var_d217d07.size >= 1) {
        self.hint_string = %DLC5_QUADROTOR_UNAVAILABLE;
        return false;
    }
    if (level flag::get("quadrotor_cooling_down")) {
        self.hint_string = %DLC5_QUADROTOR_COOLDOWN;
        return false;
    }
    return true;
}

// Namespace zm_tomb_craftables
// Params 2, eflags: 0x1 linked
// Checksum 0xdd3e0db3, Offset: 0x59a0
// Size: 0x388
function function_407ad7f1(modelname, var_36e3cbd4) {
    player = zm_utility::get_closest_player(self.origin);
    var_2f5ce50b = getent(modelname, "targetname");
    var_abcf76c0 = function_9cc411fa(var_36e3cbd4);
    var_2f5ce50b useweaponmodel(var_abcf76c0.w_weapon);
    var_2f5ce50b showallparts();
    switch (var_abcf76c0.var_9967ff1) {
    case "elemental_staff_air":
        var_2f5ce50b.angles = (0, 130, 0);
        break;
    case "elemental_staff_fire":
        var_2f5ce50b.angles = (0, 50, 0);
        break;
    case "elemental_staff_lightning":
        var_2f5ce50b.angles = (0, 90, 0);
        break;
    case "elemental_staff_water":
        var_2f5ce50b.angles = (0, 0, 0);
        break;
    }
    level notify(#"hash_9b82fb76", player, 0);
    if (!isdefined(var_2f5ce50b.var_bf1b6093)) {
        var_2f5ce50b.origin -= (0, 0, 30);
        player function_9d221ddb(var_36e3cbd4, var_abcf76c0.element + "_staff.holder");
        var_2f5ce50b show();
        var_2f5ce50b.var_bf1b6093 = 1;
        level.var_c01c54cd++;
        if (level.var_c01c54cd == 4) {
            level flag::set("ee_all_staffs_crafted");
        }
        foreach (e_player in level.players) {
            e_player thread zm_craftables::function_97be99b3(undefined, "zmInventory." + var_abcf76c0.element + "_staff.visible", 1);
        }
    }
    if (!isdefined(var_abcf76c0.var_43f3f5e5) || !(isdefined(var_abcf76c0.var_43f3f5e5.is_charged) && var_abcf76c0.var_43f3f5e5.is_charged)) {
        var_3d4e0762 = var_abcf76c0.element + "_staff.quest_state";
        level clientfield::set(var_3d4e0762, 3);
    }
    return true;
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0xfc3a34d8, Offset: 0x5d30
// Size: 0x42
function function_6a4fbed6() {
    level thread function_2a34116f("fire");
    return function_407ad7f1("craftable_staff_fire_zm", 1);
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0xf0f1cddc, Offset: 0x5d80
// Size: 0x42
function function_c67d74ce() {
    level thread function_2a34116f("air");
    return function_407ad7f1("craftable_staff_air_zm", 2);
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0xeda55fcf, Offset: 0x5dd0
// Size: 0x42
function function_8feb5840() {
    level thread function_2a34116f("lightning");
    return function_407ad7f1("craftable_staff_lightning_zm", 3);
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0x9e586018, Offset: 0x5e20
// Size: 0x42
function function_11d70761() {
    level thread function_2a34116f("ice");
    return function_407ad7f1("craftable_staff_water_zm", 4);
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0x11062620, Offset: 0x5e70
// Size: 0x7c
function function_2a34116f(type) {
    if (!isdefined(level.var_acb362cc)) {
        level.var_acb362cc = [];
    }
    if (!isinarray(level.var_acb362cc, type)) {
        level.var_acb362cc[level.var_acb362cc.size] = type;
        level thread zm_tomb_amb::function_5f9c184e("staff_" + type);
    }
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0xef33309d, Offset: 0x5ef8
// Size: 0xac
function function_ece63a79(player) {
    function_d37fcc8e();
    player thread function_408befde();
    player thread function_ae140b95();
    level waittill(#"hash_3577ab25");
    level.var_461e417 = undefined;
    if (level flag::get("ee_quadrotor_disabled")) {
        level flag::wait_till_clear("ee_quadrotor_disabled");
    }
    function_969deae1();
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0x5456c10, Offset: 0x5fb0
// Size: 0x76
function function_408befde() {
    self notify(#"hash_408befde");
    self endon(#"hash_408befde");
    self endon(#"hash_333eea01");
    self util::waittill_any("bled_out", "disconnect");
    if (isdefined(level.var_461e417)) {
        level notify(#"hash_159cbfb2");
        return;
    }
    level notify(#"hash_3577ab25");
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0x74c80716, Offset: 0x6030
// Size: 0x234
function function_ae140b95() {
    self notify(#"hash_ae140b95");
    self endon(#"hash_ae140b95");
    self endon(#"bled_out");
    self endon(#"disconnect");
    self endon(#"hash_333eea01");
    while (true) {
        var_703e6a13 = getweapon("equip_dieseldrone");
        if (self actionslotfourbuttonpressed() && self hasweapon(var_703e6a13)) {
            self util::waittill_any_timeout(1, "weapon_change_complete");
            self playsound("veh_qrdrone_takeoff");
            self zm_weapons::switch_back_primary_weapon();
            self util::waittill_any_timeout(1, "weapon_change_complete");
            self zm_weapons::weapon_take(var_703e6a13);
            self setactionslot(4, "");
            str_vehicle = "heli_quadrotor_zm";
            if (level flag::get("ee_maxis_drone_retrieved")) {
                str_vehicle = "heli_quadrotor_upgraded_zm";
            }
            var_a3ffacc8 = spawnvehicle(str_vehicle, self.origin + (0, 0, 96), self.angles, "quadrotor_ai");
            level thread function_2aa9031e(var_a3ffacc8);
            var_a3ffacc8 thread function_8e1e797(self);
            var_a3ffacc8 thread zm_tomb_vo::function_a808bc8e();
            return;
        }
        wait 0.05;
    }
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x0
// Checksum 0x28dcd8de, Offset: 0x6270
// Size: 0x68
function function_c5069b29(player_owner) {
    self endon(#"hash_159cbfb2");
    level endon(#"hash_3577ab25");
    while (true) {
        if (player_owner actionslotfourbuttonpressed()) {
            self function_8dbb407d();
        }
        wait 0.05;
    }
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0x27e4c3c6, Offset: 0x62e0
// Size: 0xbc
function function_8e1e797(player_owner) {
    self endon(#"death");
    self.player_owner = player_owner;
    self.health = -56;
    level.var_461e417 = self;
    self makevehicleunusable();
    self thread namespace_3a47cb81::follow_ent(player_owner);
    self thread function_b0d2a612();
    self thread function_e8aad972(player_owner);
    level waittill(#"hash_159cbfb2");
    self function_8dbb407d();
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0x564934b, Offset: 0x63a8
// Size: 0x32
function function_2aa9031e(var_28c00c94) {
    level endon(#"hash_3577ab25");
    var_28c00c94 waittill(#"death");
    level notify(#"hash_3577ab25");
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0x7cdf2090, Offset: 0x63e8
// Size: 0x162
function function_8dbb407d() {
    self endon(#"death");
    level endon(#"hash_3577ab25");
    if (isdefined(self)) {
        /#
            iprintln("<dev string:x146>");
        #/
        self.var_73545c79 = 1;
        self thread function_58326159();
        self util::waittill_any("attempting_return", "return_timeout");
    }
    if (isdefined(self)) {
        self util::waittill_any("near_goal", "force_goal", "reached_end_node", "return_timeout");
    }
    if (isdefined(self)) {
        playfx(level._effect["tesla_elec_kill"], self.origin);
        self playsound("zmb_qrdrone_leave");
        self delete();
        /#
            iprintln("<dev string:x160>");
        #/
    }
    level notify(#"hash_3577ab25");
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x0
// Checksum 0x5edfd75f, Offset: 0x6558
// Size: 0x2c
function function_b0768a15(str_notify) {
    self waittill(str_notify);
    iprintln(str_notify);
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0x8589fd7a, Offset: 0x6590
// Size: 0x6a
function function_58326159() {
    self endon(#"death");
    level endon(#"hash_3577ab25");
    wait 30;
    if (isdefined(self)) {
        self delete();
        /#
            iprintln("<dev string:x160>");
        #/
    }
    self notify(#"return_timeout");
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0x1f21aee2, Offset: 0x6608
// Size: 0xa2
function function_b0d2a612() {
    self endon(#"death");
    level endon(#"hash_3577ab25");
    wait 80;
    var_d072a269 = "vox_maxi_drone_cool_down_" + randomintrange(0, 2);
    self thread zm_tomb_vo::function_7dc74a72(var_d072a269, self);
    wait 10;
    var_d072a269 = "vox_maxi_drone_cool_down_2";
    self thread zm_tomb_vo::function_7dc74a72(var_d072a269, self);
    level notify(#"hash_159cbfb2");
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0x82e47fee, Offset: 0x66b8
// Size: 0x2f4
function function_969deae1() {
    /#
        iprintln("<dev string:x16e>");
    #/
    playfx(level._effect["tesla_elec_kill"], level.var_3c3bf0e1.pickup_trig.model.origin);
    level.var_3c3bf0e1.pickup_trig.model playsound("zmb_qrdrone_leave");
    level.var_3c3bf0e1.picked_up = 0;
    level.var_3c3bf0e1.pickup_trig.model show();
    level flag::set("quadrotor_cooling_down");
    str_zone = level.var_3c3bf0e1.str_zone;
    switch (str_zone) {
    case "zone_nml_9":
        clientfield::set("cooldown_steam", 1);
        break;
    case "zone_bunker_5a":
        clientfield::set("cooldown_steam", 2);
        break;
    case "zone_village_1":
        clientfield::set("cooldown_steam", 3);
        break;
    }
    var_d072a269 = "vox_maxi_drone_cool_down_3";
    thread zm_tomb_vo::function_7dc74a72(var_d072a269, level.var_3c3bf0e1.pickup_trig.model);
    wait 60;
    level flag::clear("quadrotor_cooling_down");
    clientfield::set("cooldown_steam", 0);
    foreach (var_c0cba69a in level.var_3c3bf0e1.pickup_trig.playertrigger) {
        var_c0cba69a triggerenable(1);
    }
    var_d072a269 = "vox_maxi_drone_cool_down_4";
    zm_tomb_vo::function_7dc74a72(var_d072a269, level.var_3c3bf0e1.pickup_trig.model);
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0xde18118, Offset: 0x69b8
// Size: 0xdc
function function_d37fcc8e() {
    level.var_3c3bf0e1.picked_up = 1;
    foreach (var_c0cba69a in level.var_3c3bf0e1.pickup_trig.playertrigger) {
        var_c0cba69a triggerenable(0);
    }
    level.var_3c3bf0e1.pickup_trig.model ghost();
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0x4cb3b618, Offset: 0x6aa0
// Size: 0xb8
function function_e8aad972(e_player_owner) {
    self endon(#"death");
    level endon(#"hash_3577ab25");
    while (true) {
        e_player_owner util::waittill_any("teleport_finished", "gr_eject_sequence_complete");
        self clientfield::increment("teleport_arrival_departure_fx");
        self.origin = e_player_owner.origin + (0, 0, 100);
        self clientfield::increment("teleport_arrival_departure_fx");
    }
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x0
// Checksum 0xd1056bd5, Offset: 0x6b60
// Size: 0x44
function function_77842f20() {
    level.var_972f2ae2 = zm_craftables::function_4f91b11d("sq_common_craftable_trigger", "sq_common", "sq_common", "", 1, 0);
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x0
// Checksum 0xc135297d, Offset: 0x6bb0
// Size: 0xc
function function_be206d34(player) {
    
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x6bc8
// Size: 0x4
function function_832dcda8() {
    
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0x9d0a5661, Offset: 0x6bd8
// Size: 0x214
function function_d00832ac(player) {
    var_703e6a13 = getweapon("equip_dieseldrone");
    if (self.stub.equipname == "equip_dieseldrone") {
        if (function_e5ad4beb(var_703e6a13)) {
            return true;
        }
        var_28c00c94 = getentarray("quadrotor_ai", "targetname");
        if (var_28c00c94.size >= 1) {
            return true;
        }
        function_d37fcc8e();
        player zm_weapons::weapon_give(var_703e6a13);
        player setweaponammoclip(var_703e6a13, 1);
        player playsoundtoplayer("zmb_buildable_pickup_complete", player);
        if (isdefined(self.stub.var_e312521d.var_41456707)) {
            player setactionslot(self.stub.var_e312521d.var_41456707, "weapon", var_703e6a13);
        } else {
            player setactionslot(4, "weapon", var_703e6a13);
        }
        player clientfield::set_player_uimodel("hudItems.showDpadRight_Drone", 1);
        player notify(#"hash_1423b780");
        level thread function_ece63a79(player);
        player thread zm_audio::create_and_play_dialog("general", "build_dd_plc");
        return true;
    }
    return false;
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0xd47de52d, Offset: 0x6df8
// Size: 0xc0
function function_e5ad4beb(weaponname) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (players[i] hasweapon(weaponname)) {
            return true;
        }
    }
    var_d217d07 = getentarray("quadrotor_ai", "targetname");
    if (var_d217d07.size >= 1) {
        return true;
    }
    return false;
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0xefb36241, Offset: 0x6ec0
// Size: 0x27e
function function_568dc89e(player) {
    if (self.stub.equipname == "equip_dieseldrone") {
        level.var_3c3bf0e1.pickup_trig = self.stub;
        if (level.var_3c3bf0e1.crafted) {
            var_703e6a13 = getweapon("equip_dieseldrone");
            return (!function_e5ad4beb(var_703e6a13) && !level flag::get("quadrotor_cooling_down"));
        }
    }
    if (!issubstr(self.stub.weaponname.name, "staff")) {
        return true;
    }
    var_deec1671 = self.stub.equipname;
    if (!(isdefined(level.var_84ae2a3c[var_deec1671]) && level.var_84ae2a3c[var_deec1671])) {
        return true;
    }
    if (!player zm_tomb_main_quest::function_d19c6953()) {
        return false;
    }
    var_455ad94d = function_9b485a9(self.stub.weaponname, 0);
    var_5030d28c = var_455ad94d.weapname;
    a_weapons = player getweaponslistprimaries();
    foreach (weapon in a_weapons) {
        if (issubstr(weapon.name, "staff") && weapon.name != var_5030d28c) {
            player takeweapon(weapon);
        }
    }
    return true;
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0xa94c1858, Offset: 0x7148
// Size: 0x44c
function function_db3359f1(player) {
    if (self.stub.equipname == "equip_dieseldrone") {
        if (level.var_3c3bf0e1.crafted) {
            return false;
        }
    } else if (self.stub.weaponname == level.var_b0d8f1fe["staff_air"].w_weapon || self.stub.weaponname == level.var_b0d8f1fe["staff_fire"].w_weapon || self.stub.weaponname == level.var_b0d8f1fe["staff_lightning"].w_weapon || self.stub.weaponname == level.var_b0d8f1fe["staff_water"].w_weapon) {
        if (self function_2b1a7826(self.stub.weaponname) && !(isdefined(level.var_b79a2c38[self.stub.equipname]) && level.var_b79a2c38[self.stub.equipname])) {
            level thread function_fcebb932(self.stub.equipname);
            var_455ad94d = function_9b485a9(self.stub.weaponname, 0);
            player zm_weapons::weapon_give(var_455ad94d.w_weapon, 0, 0);
            if (isdefined(var_455ad94d.var_e1678378) && isdefined(var_455ad94d.var_960d7618)) {
                player setweaponammostock(var_455ad94d.w_weapon, var_455ad94d.var_e1678378);
                player setweaponammoclip(var_455ad94d.w_weapon, var_455ad94d.var_960d7618);
            }
            if (isdefined(level.var_a7e9c2bf[self.stub.equipname].var_6cabc9d6)) {
                self.stub.hint_string = level.var_a7e9c2bf[self.stub.equipname].var_6cabc9d6;
            } else {
                self.stub.hint_string = "";
            }
            self sethintstring(self.stub.hint_string);
            player zm_craftables::track_craftables_pickedup(self.stub.craftablespawn);
            str_name = "craftable_" + self.stub.weaponname.name + "_zm";
            model = getent(str_name, "targetname");
            model ghost();
            self.stub thread function_2c9b5fc();
            self.stub thread function_53ad8621(player);
            function_476c0e12(self.stub.weaponname, player);
        } else {
            self.stub.hint_string = "";
            self sethintstring(self.stub.hint_string);
        }
        return true;
    }
    return false;
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0xf750e0db, Offset: 0x75a0
// Size: 0x3a
function function_fcebb932(var_3c381d2a) {
    level.var_b79a2c38[var_3c381d2a] = 1;
    wait 0.2;
    level.var_b79a2c38[var_3c381d2a] = 0;
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0xeafef3f9, Offset: 0x75e8
// Size: 0x144
function function_2b1a7826(w_check) {
    if (!zm_equipment::is_limited(w_check)) {
        return true;
    } else {
        var_455ad94d = function_9b485a9(w_check, 0);
        var_5030d28c = var_455ad94d.weapname;
        players = getplayers();
        foreach (player in players) {
            if (isdefined(player) && player.sessionstate == "playing" && player zm_weapons::has_weapon_or_upgrade(w_check)) {
                return false;
            }
        }
    }
    return true;
}

// Namespace zm_tomb_craftables
// Params 2, eflags: 0x1 linked
// Checksum 0x72c9a67b, Offset: 0x7738
// Size: 0x12a
function function_9b485a9(w_weapon, var_3b73b37f) {
    if (!isdefined(var_3b73b37f)) {
        var_3b73b37f = 1;
    }
    str_name = w_weapon.name;
    foreach (s_staff in level.var_b0d8f1fe) {
        if (s_staff.weapname == str_name || s_staff.upgrade.weapname == str_name) {
            if (s_staff.var_43f3f5e5.is_charged && !var_3b73b37f) {
                return s_staff.upgrade;
            }
            return s_staff;
        }
    }
    return undefined;
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0x7b042fdf, Offset: 0x7870
// Size: 0x9a
function function_9cc411fa(n_index) {
    foreach (s_staff in level.var_b0d8f1fe) {
        if (s_staff.enum == n_index) {
            return s_staff;
        }
    }
    return undefined;
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0xa4bb3ee0, Offset: 0x7918
// Size: 0xf4
function function_2c9b5fc() {
    var_455ad94d = function_9b485a9(self.weaponname, 1);
    if (!isdefined(self.var_c1a4f1fc)) {
        self.var_c1a4f1fc = var_455ad94d.weapname;
    }
    level flag::wait_till_clear(self.var_c1a4f1fc + "_zm_enabled");
    level flag::set(self.var_c1a4f1fc + "_picked_up");
    level flag::wait_till(self.var_c1a4f1fc + "_zm_enabled");
    level flag::clear(self.var_c1a4f1fc + "_picked_up");
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0x6331944f, Offset: 0x7a18
// Size: 0x79c
function function_53ad8621(player) {
    self notify(#"hash_5a911f90");
    self endon(#"hash_5a911f90");
    var_455ad94d = undefined;
    if (issubstr(self.targetname, "prop_")) {
        var_455ad94d = function_9b485a9(self.w_weapon, 1);
    } else {
        var_455ad94d = function_9b485a9(self.weaponname, 1);
    }
    var_5b7c5a14 = var_455ad94d.upgrade;
    if (!isdefined(self.var_c1a4f1fc)) {
        self.var_c1a4f1fc = var_455ad94d.weapname;
    }
    level flag::clear(self.var_c1a4f1fc + "_zm_enabled");
    for (has_weapon = 0; isalive(player); has_weapon = 0) {
        if (isdefined(var_5b7c5a14.var_260a328b) && (isdefined(var_5b7c5a14.var_43f3f5e5.var_2d46dee8) && (isdefined(var_455ad94d.var_43f3f5e5.var_2d46dee8) && var_455ad94d.var_43f3f5e5.var_2d46dee8 || var_5b7c5a14.var_43f3f5e5.var_2d46dee8) || var_5b7c5a14.var_260a328b)) {
            has_weapon = 1;
        } else {
            weapons = player getweaponslistprimaries();
            foreach (weapon in weapons) {
                var_a904111d = 0;
                if (weapon.name == self.var_c1a4f1fc) {
                    var_455ad94d.var_e1678378 = player getweaponammostock(weapon);
                    var_455ad94d.var_960d7618 = player getweaponammoclip(weapon);
                    has_weapon = 1;
                } else if (weapon.name == var_5b7c5a14.weapname) {
                    var_5b7c5a14.var_e1678378 = player getweaponammostock(weapon);
                    var_5b7c5a14.var_960d7618 = player getweaponammoclip(weapon);
                    has_weapon = 1;
                    var_a904111d = var_5b7c5a14.enum;
                }
                if (player hasweapon(level.var_2b2f83e5)) {
                    var_5b7c5a14.var_ac4510c = player getweaponammostock(level.var_2b2f83e5);
                    var_5b7c5a14.var_45c5f54c = player getweaponammoclip(level.var_2b2f83e5);
                }
                if (has_weapon && !(isdefined(player.var_5fc3c5c7) && player.var_5fc3c5c7) && var_a904111d != 0 && !player hasperk("specialty_widowswine")) {
                    var_c2577628 = player getcurrentweapon();
                    if (isdefined(player.var_27eb897c) && var_c2577628 != weapon && player.var_27eb897c) {
                        player zm_tomb_utility::function_84442246(0);
                        continue;
                    }
                    if (var_c2577628 == weapon && !(isdefined(player.var_27eb897c) && player.var_27eb897c)) {
                        player zm_tomb_utility::function_84442246(var_a904111d);
                    }
                }
            }
        }
        if (!has_weapon && !player laststand::player_is_in_laststand()) {
            break;
        }
        wait 0.5;
    }
    var_3fc001bc = 0;
    a_players = getplayers();
    foreach (var_4f953f09 in a_players) {
        if (var_4f953f09.sessionstate == "playing") {
            weapons = var_4f953f09 getweaponslistprimaries();
            foreach (weapon in weapons) {
                if (weapon.name == self.var_c1a4f1fc || weapon.name == var_5b7c5a14.weapname) {
                    var_3fc001bc = 1;
                }
            }
        }
    }
    if (!var_3fc001bc) {
        str_name = "craftable_" + self.var_c1a4f1fc + "_zm";
        model = getent(str_name, "targetname");
        model show();
        level flag::set(self.var_c1a4f1fc + "_zm_enabled");
    }
    if (isweapon(self.weaponname)) {
        function_abd72df3(self.weaponname, player);
        return;
    }
    function_abd72df3(self.w_weapon, player);
}

// Namespace zm_tomb_craftables
// Params 2, eflags: 0x1 linked
// Checksum 0xf911db0b, Offset: 0x81c0
// Size: 0x12c
function function_476c0e12(var_5ec0aa73, e_player) {
    s_staff = function_9b485a9(var_5ec0aa73);
    s_staff.e_owner = e_player;
    n_player = e_player getentitynumber() + 1;
    e_player.var_381c0e5b = s_staff.enum;
    level clientfield::set(s_staff.element + "_staff.holder", e_player.characterindex + 1);
    e_player zm_tomb_utility::function_84442246(s_staff.enum);
    /#
        iprintlnbold("<dev string:x185>" + n_player + "<dev string:x18d>" + s_staff.enum);
    #/
}

// Namespace zm_tomb_craftables
// Params 1, eflags: 0x1 linked
// Checksum 0x1b9c190a, Offset: 0x82f8
// Size: 0xe2
function function_fca8537d(var_d95a0cf3) {
    foreach (s_staff in level.var_b0d8f1fe) {
        if (level clientfield::get(s_staff.element + "_staff.holder") == var_d95a0cf3) {
            level clientfield::set(s_staff.element + "_staff.holder", 0);
        }
    }
}

// Namespace zm_tomb_craftables
// Params 2, eflags: 0x1 linked
// Checksum 0x4c29de8, Offset: 0x83e8
// Size: 0x19a
function function_abd72df3(w_check, e_owner) {
    s_staff = function_9b485a9(w_check);
    if (isdefined(e_owner) && isdefined(s_staff.e_owner) && e_owner != s_staff.e_owner) {
        return;
    }
    if (!isdefined(e_owner)) {
        e_owner = s_staff.e_owner;
    }
    if (isdefined(e_owner)) {
        if (level clientfield::get(s_staff.element + "_staff.holder") == e_owner.characterindex + 1) {
            n_player = e_owner getentitynumber() + 1;
            e_owner.var_381c0e5b = 0;
            level clientfield::set(s_staff.element + "_staff.holder", 0);
            e_owner zm_tomb_utility::function_84442246(0);
        }
    }
    /#
        iprintlnbold("<dev string:x199>" + s_staff.enum);
    #/
    s_staff.e_owner = undefined;
}

// Namespace zm_tomb_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0x27c53e80, Offset: 0x8590
// Size: 0xb2
function function_80834820() {
    var_3f840e58 = getentarray("craftable_staff_model", "script_noteworthy");
    foreach (var_7bea32a in var_3f840e58) {
        var_7bea32a ghost();
    }
}

