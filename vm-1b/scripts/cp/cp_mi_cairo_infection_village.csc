#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace village;

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x13186597, Offset: 0x520
// Size: 0x32
function main() {
    init_clientfields();
    level thread function_afd04353();
    level thread mortar_test();
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0xb6c8081c, Offset: 0x560
// Size: 0x11a
function init_clientfields() {
    clientfield::register("world", "village_mortar_index", 1, 3, "int", &function_130beaa2, 0, 0);
    clientfield::register("world", "village_intro_mortar", 1, 1, "int", &function_f0638072, 0, 0);
    clientfield::register("world", "init_fold", 1, 1, "int", &function_aa7aa249, 0, 0);
    clientfield::register("world", "start_fold", 1, 1, "int", &function_5058bf3d, 0, 0);
    clientfield::register("scriptmover", "fold_buildings", 1, 1, "int", &function_b459a9c8, 0, 0);
}

// Namespace village
// Params 7, eflags: 0x0
// Checksum 0xb9848601, Offset: 0x688
// Size: 0x82
function function_aa7aa249(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval != oldval) {
        flag::init("fold_done");
        level thread scene::init("p7_fxanim_cp_infection_fold_debris_rise_bundle");
        level thread function_abc51a3c(localclientnum);
    }
}

// Namespace village
// Params 7, eflags: 0x0
// Checksum 0x51126ce2, Offset: 0x718
// Size: 0x9a
function function_5058bf3d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval != oldval) {
        level thread function_983280bc(localclientnum, 1);
        level scene::play("p7_fxanim_cp_infection_fold_debris_rise_bundle");
        flag::set("fold_done");
        level thread function_983280bc(localclientnum, 0);
    }
}

// Namespace village
// Params 1, eflags: 0x0
// Checksum 0x18a60298, Offset: 0x7c0
// Size: 0x6a
function function_abc51a3c(localclientnum) {
    flag::wait_till("fold_done");
    e_trigger = getent(localclientnum, "t_fold_debris_fall", "targetname");
    e_trigger waittill(#"trigger");
    level thread scene::play("p7_fxanim_cp_infection_fold_debris_fall_bundle");
}

// Namespace village
// Params 2, eflags: 0x0
// Checksum 0xed8c8ee2, Offset: 0x838
// Size: 0x9a
function function_983280bc(localclientnum, benable) {
    var_2c19440 = getent(localclientnum, "fold_earthquake_origin", "targetname");
    assert(isdefined(var_2c19440), "<dev string:x28>");
    if (benable) {
        var_2c19440 playrumblelooponentity(localclientnum, "cp_infection_fold");
        return;
    }
    var_2c19440 stoprumble(localclientnum, "cp_infection_fold");
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0xdda0e0df, Offset: 0x8e0
// Size: 0x82
function function_afd04353() {
    level waittill(#"hash_fcce54d0");
    audio::playloopat("evt_infection_record_outdoor", (-66583, -8277, 539));
    audio::playloopat("evt_infection_record_outdoor", (-66974, -5736, 481));
    audio::playloopat("evt_infection_record_outdoor", (-68367, -4740, 469));
}

// Namespace village
// Params 7, eflags: 0x0
// Checksum 0xda096e88, Offset: 0x970
// Size: 0x4a
function function_130beaa2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.village_mortar_index = newval;
    level.var_a50160b4 = 1;
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x454c56f, Offset: 0x9c8
// Size: 0x1c1
function mortar_test() {
    if (!isdefined(level.village_mortar_index)) {
        level.village_mortar_index = 0;
        level.var_a50160b4 = 1;
    }
    index = 0;
    delay = 0.1;
    while (true) {
        switch (level.village_mortar_index) {
        case 1:
            var_1e806caa = struct::get_array("s_village_mortar_1", "targetname");
            delay = randomfloatrange(1.3, 2);
            break;
        case 2:
            var_1e806caa = struct::get_array("s_village_mortar_2", "targetname");
            delay = randomfloatrange(1.3, 2);
            break;
        case 3:
            var_1e806caa = struct::get_array("s_village_mortar_3", "targetname");
            delay = randomfloatrange(1.3, 2.2);
            break;
        case 0:
        default:
            var_1e806caa = undefined;
            break;
        }
        if (isdefined(var_1e806caa)) {
            if (isdefined(level.var_a50160b4)) {
                index = randomint(var_1e806caa.size);
                level.var_a50160b4 = undefined;
            }
            playfx(0, "explosions/fx_exp_mortar_snow", var_1e806caa[index].origin);
            index++;
            if (index >= var_1e806caa.size) {
                index = 0;
            }
        }
        wait delay;
    }
}

// Namespace village
// Params 7, eflags: 0x0
// Checksum 0xec13b3fd, Offset: 0xb98
// Size: 0x82
function function_f0638072(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    s_village_intro_mortar = struct::get("s_village_intro_mortar", "targetname");
    playfx(0, "explosions/fx_exp_mortar_snow", s_village_intro_mortar.origin);
}

// Namespace village
// Params 7, eflags: 0x0
// Checksum 0xc749fb3, Offset: 0xc28
// Size: 0x1ab
function function_b459a9c8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_f45c8a8 = [];
    var_f45c8a8["bank_jnt"] = "p7_fxanim_cp_infection_fold_bank_mod";
    var_f45c8a8["barn_01_jnt"] = "p7_fxanim_cp_infection_fold_barn01_mod";
    var_f45c8a8["barn_02_jnt"] = "p7_fxanim_cp_infection_fold_barn02_mod";
    var_f45c8a8["boarding_jnt"] = "p7_fxanim_cp_infection_fold_boarding_mod";
    var_f45c8a8["church_jnt"] = "p7_fxanim_cp_infection_fold_church_mod";
    var_f45c8a8["hotel_jnt"] = "p7_fxanim_cp_infection_fold_hotel_mod";
    var_f45c8a8["house_01_jnt"] = "p7_fxanim_cp_infection_fold_house01_mod";
    var_f45c8a8["house_02_jnt"] = "p7_fxanim_cp_infection_fold_house02_mod";
    var_f45c8a8["tankhouse_jnt"] = "p7_fxanim_cp_infection_fold_tankhouse_mod";
    var_f45c8a8["tenements_jnt"] = "p7_fxanim_cp_infection_fold_tenements_mod";
    foreach (str_tag, var_bfcb06ed in var_f45c8a8) {
        var_e7e10be5 = util::spawn_model(localclientnum, var_bfcb06ed, self gettagorigin(str_tag), self gettagangles(str_tag));
        var_e7e10be5 linkto(self, str_tag);
    }
}

