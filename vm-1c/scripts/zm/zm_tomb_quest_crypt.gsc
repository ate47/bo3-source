#using scripts/zm/zm_tomb_vo;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_amb;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_audio;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_acbbd1f9;

// Namespace namespace_acbbd1f9
// Params 0, eflags: 0x1 linked
// Checksum 0xe8a89fe7, Offset: 0x680
// Size: 0x94
function main() {
    callback::on_connect(&function_9f789b54);
    level flag::init("disc_rotation_active");
    level thread namespace_ad52727b::function_d22bb7("puzzle", "try_puzzle", "vo_try_puzzle_crypt");
    function_39524a5();
    function_31813267();
}

// Namespace namespace_acbbd1f9
// Params 0, eflags: 0x1 linked
// Checksum 0x5059281b, Offset: 0x720
// Size: 0xca
function function_9f789b54() {
    var_d8c2b9bd = getentarray("crypt_puzzle_disc", "script_noteworthy");
    foreach (var_5868c432 in var_d8c2b9bd) {
        var_5868c432 util::delay(0.5, undefined, &function_f78a1a6c, 0);
    }
}

// Namespace namespace_acbbd1f9
// Params 0, eflags: 0x1 linked
// Checksum 0xf521c73f, Offset: 0x7f8
// Size: 0x12c
function function_31813267() {
    scene::add_scene_func("p7_fxanim_zm_ori_chamber_mid_ring_bundle", &function_746282b3, "init");
    level.var_a89ce290 = [];
    level.var_a89ce290["crypt_gem_fire"] = 2;
    level.var_a89ce290["crypt_gem_air"] = 3;
    level.var_a89ce290["crypt_gem_ice"] = 0;
    level.var_a89ce290["crypt_gem_elec"] = 1;
    var_c0617dfa = getentarray("crypt_puzzle_disc", "script_noteworthy");
    array::thread_all(var_c0617dfa, &function_ac2cc469);
    level util::waittill_any("gramophone_vinyl_player_picked_up", "open_sesame", "open_all_gramophone_doors");
    function_53089652();
}

// Namespace namespace_acbbd1f9
// Params 0, eflags: 0x1 linked
// Checksum 0x6cddbd4a, Offset: 0x930
// Size: 0x2bc
function function_ac2cc469() {
    self.position = 0;
    if (!isdefined(level.var_6d86123b)) {
        level.var_6d86123b = [];
    }
    level flag::wait_till("start_zombie_round_logic");
    self function_f78a1a6c(0);
    if (isdefined(self.target)) {
        var_d0a8b9f2 = getentarray(self.target, "targetname");
        foreach (var_8305c467 in var_d0a8b9f2) {
            var_8305c467.trigger_stub = namespace_d7c0ce12::function_52854313(var_8305c467.origin, 100, 1);
            var_8305c467.trigger_stub.require_look_at = 0;
            clockwise = var_8305c467.script_string === "clockwise";
            var_8305c467.trigger_stub thread function_865b0a10(self, var_8305c467, clockwise);
        }
        self thread function_60de7457();
    }
    self useanimtree(#generic);
    if (!isdefined(self.script_int)) {
        self animscripted("disc_idle", self.origin, self.angles, "p7_fxanim_zm_ori_chamber_mid_ring_idle_anim");
        return;
    }
    level.var_6d86123b[self.script_int] = self;
    n_wait = randomfloatrange(0, 5);
    wait(n_wait);
    self.v_start_origin = self.origin;
    self.v_start_angles = self.angles;
    wait(0.05);
    str_name = "fxanim_disc" + self.script_int;
    level scene::play(str_name, "targetname");
}

// Namespace namespace_acbbd1f9
// Params 1, eflags: 0x1 linked
// Checksum 0x983b703d, Offset: 0xbf8
// Size: 0x10c
function function_746282b3(a_ents) {
    var_4316fdf6 = a_ents["chamber_mid_ring"];
    switch (self.targetname) {
    case 22:
        n_index = 1;
        break;
    case 23:
        n_index = 2;
        break;
    case 24:
        n_index = 3;
        break;
    case 25:
        n_index = 4;
        break;
    }
    var_4316fdf6 linkto(level.var_6d86123b[n_index]);
    level.var_6d86123b[n_index].var_b1c02d8a = var_4316fdf6;
    wait(0.05);
    level.var_6d86123b[n_index] ghost();
}

// Namespace namespace_acbbd1f9
// Params 0, eflags: 0x1 linked
// Checksum 0xaa1acf72, Offset: 0xd10
// Size: 0x102
function function_39524a5() {
    var_5868c432 = getent("crypt_puzzle_disc_main", "targetname");
    gems = getentarray("crypt_gem", "script_noteworthy");
    foreach (gem in gems) {
        gem linkto(var_5868c432);
        gem thread function_e99137c6();
    }
}

// Namespace namespace_acbbd1f9
// Params 0, eflags: 0x1 linked
// Checksum 0x7b6498ef, Offset: 0xe20
// Size: 0x10a
function function_65f2169e() {
    var_d8c2b9bd = getentarray("crypt_puzzle_disc", "script_noteworthy");
    for (i = 1; i <= 4; i++) {
        foreach (var_5868c432 in var_d8c2b9bd) {
            if (var_5868c432.script_int === i) {
                var_5868c432 function_f78a1a6c(1);
                break;
            }
        }
        wait(1);
    }
}

// Namespace namespace_acbbd1f9
// Params 0, eflags: 0x1 linked
// Checksum 0xbc46551b, Offset: 0xf38
// Size: 0x7d4
function function_e99137c6() {
    str_weapon = undefined;
    complete_flag = undefined;
    var_4d0e732 = undefined;
    var_822dcf97 = undefined;
    var_b5f6f4e4 = self.script_int;
    switch (self.targetname) {
    case 9:
        w_weapon = level.var_b0d8f1fe["staff_air"].w_weapon;
        complete_flag = "staff_air_upgrade_unlocked";
        var_4d0e732 = "air_orb_exit_path";
        var_e62cf580 = "air_orb_plinth_final";
        break;
    case 10:
        w_weapon = level.var_b0d8f1fe["staff_water"].w_weapon;
        complete_flag = "staff_water_upgrade_unlocked";
        var_4d0e732 = "ice_orb_exit_path";
        var_e62cf580 = "ice_orb_plinth_final";
        break;
    case 8:
        w_weapon = level.var_b0d8f1fe["staff_fire"].w_weapon;
        complete_flag = "staff_fire_upgrade_unlocked";
        var_4d0e732 = "fire_orb_exit_path";
        var_e62cf580 = "fire_orb_plinth_final";
        break;
    case 11:
        w_weapon = level.var_b0d8f1fe["staff_lightning"].w_weapon;
        complete_flag = "staff_lightning_upgrade_unlocked";
        var_4d0e732 = "lightning_orb_exit_path";
        var_e62cf580 = "lightning_orb_plinth_final";
        break;
    default:
        assertmsg("crypt_gem_fire" + self.targetname);
        return;
    }
    var_2370450c = namespace_d7c0ce12::function_bfec48b1(var_4d0e732, self);
    var_4ba6250a = getent("crypt_puzzle_disc_main", "targetname");
    var_2370450c linkto(var_4ba6250a);
    str_targetname = self.targetname;
    self delete();
    var_2370450c setcandamage(1);
    while (true) {
        damage, attacker, direction_vec, point, mod, tagname, modelname, partname, weapon = var_2370450c waittill(#"damage");
        if (weapon == w_weapon) {
            break;
        }
    }
    var_2370450c clientfield::set("element_glow_fx", var_b5f6f4e4);
    var_2370450c playsound("zmb_squest_crystal_charge");
    var_2370450c playloopsound("zmb_squest_crystal_charge_loop", 2);
    while (true) {
        if (function_f73a5201(str_targetname)) {
            break;
        }
        level waittill(#"hash_9d912aa6");
    }
    level flag::set("disc_rotation_active");
    level thread namespace_54a425fe::function_5f9c184e("side_sting_5");
    function_65f2169e();
    level thread namespace_d7c0ce12::function_159aac02();
    var_2370450c unlink();
    var_6e2b621 = struct::get("orb_crypt_ascent_path", "targetname");
    var_faaa889c = (var_2370450c.origin[0], var_2370450c.origin[1], var_6e2b621.origin[2]);
    var_2370450c clientfield::set("element_glow_fx", var_b5f6f4e4);
    playfxontag(level._effect["puzzle_orb_trail"], var_2370450c, "tag_origin");
    var_2370450c playsound("zmb_squest_crystal_leave");
    var_2370450c namespace_d7c0ce12::function_9b31d651(var_faaa889c);
    level flag::clear("disc_rotation_active");
    level thread function_53089652();
    var_2370450c namespace_d7c0ce12::function_7ac77501(var_6e2b621);
    var_faaa889c = (var_2370450c.origin[0], var_2370450c.origin[1], var_2370450c.origin[2] + 2000);
    var_2370450c namespace_d7c0ce12::function_9b31d651(var_faaa889c);
    var_f1f293ff = struct::get(var_4d0e732, "targetname");
    str_model = var_2370450c.model;
    var_2370450c delete();
    var_2370450c = namespace_d7c0ce12::function_cd40ebb0(var_f1f293ff, var_b5f6f4e4);
    s_final = struct::get(var_e62cf580, "targetname");
    var_2370450c namespace_d7c0ce12::function_9b31d651(s_final.origin);
    var_296bd711 = spawn("script_model", s_final.origin);
    var_296bd711 setmodel(var_2370450c.model);
    var_296bd711.script_int = var_b5f6f4e4;
    var_296bd711 clientfield::set("element_glow_fx", var_b5f6f4e4);
    var_2370450c delete();
    var_296bd711 playsound("zmb_squest_crystal_arrive");
    var_296bd711 playloopsound("zmb_squest_crystal_charge_loop", 0.1);
    level flag::set(complete_flag);
}

// Namespace namespace_acbbd1f9
// Params 0, eflags: 0x1 linked
// Checksum 0xea7c1173, Offset: 0x1718
// Size: 0x11c
function function_60de7457() {
    new_angles = (self.angles[0], self.position * 90, self.angles[2]);
    self rotateto(new_angles, 1, 0, 0);
    self playsound("zmb_crypt_disc_turn");
    wait(1 * 0.75);
    self function_f78a1a6c(0);
    wait(1 * 0.25);
    self function_f78a1a6c(0);
    self playsound("zmb_crypt_disc_stop");
    namespace_d7c0ce12::rumble_nearby_players(self.origin, 1000, 2);
}

// Namespace namespace_acbbd1f9
// Params 1, eflags: 0x1 linked
// Checksum 0x8c1c62ac, Offset: 0x1840
// Size: 0x104
function function_dadea124(var_d8c2b9bd) {
    if (!isdefined(var_d8c2b9bd)) {
        var_d8c2b9bd = undefined;
    }
    level flag::set("disc_rotation_active");
    if (!isdefined(var_d8c2b9bd)) {
        var_d8c2b9bd = getentarray("chamber_puzzle_disc", "script_noteworthy");
    }
    foreach (var_4768a576 in var_d8c2b9bd) {
        var_4768a576 function_60de7457();
    }
    level flag::clear("disc_rotation_active");
}

// Namespace namespace_acbbd1f9
// Params 1, eflags: 0x1 linked
// Checksum 0x655d3709, Offset: 0x1950
// Size: 0x5c
function function_46d994bc(var_261dd588) {
    var_5868c432 = getent("crypt_puzzle_disc_main", "targetname");
    return (var_5868c432.position + level.var_a89ce290[var_261dd588]) % 4;
}

// Namespace namespace_acbbd1f9
// Params 1, eflags: 0x1 linked
// Checksum 0x98c0c8a1, Offset: 0x19b8
// Size: 0x10e
function function_f73a5201(var_261dd588) {
    var_4b4ac40 = function_46d994bc(var_261dd588);
    var_d8c2b9bd = getentarray("crypt_puzzle_disc", "script_noteworthy");
    foreach (var_5868c432 in var_d8c2b9bd) {
        if (var_5868c432.targetname === "crypt_puzzle_disc_main") {
            continue;
        }
        if (var_5868c432.position != var_4b4ac40) {
            return false;
        }
    }
    return true;
}

// Namespace namespace_acbbd1f9
// Params 1, eflags: 0x1 linked
// Checksum 0xc402872e, Offset: 0x1ad0
// Size: 0x64
function function_93f3ba53(b_clockwise) {
    if (b_clockwise) {
        self.position = (self.position + 1) % 4;
    } else {
        self.position = (self.position + 3) % 4;
    }
    self function_60de7457();
}

// Namespace namespace_acbbd1f9
// Params 1, eflags: 0x1 linked
// Checksum 0x497f5ba8, Offset: 0x1b40
// Size: 0xa4
function function_f78a1a6c(b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    if (!isdefined(self.var_da06dbf4)) {
        self.var_da06dbf4 = 0;
    }
    if (!b_on) {
        self.var_da06dbf4 = (self.var_da06dbf4 + 1) % 2;
    } else {
        self.var_da06dbf4 = 2;
    }
    if (isdefined(self.var_b1c02d8a)) {
        self.var_b1c02d8a clientfield::set("bryce_cake", self.var_da06dbf4);
    }
}

// Namespace namespace_acbbd1f9
// Params 0, eflags: 0x1 linked
// Checksum 0x40aaa704, Offset: 0x1bf0
// Size: 0x124
function function_53089652() {
    var_d8c2b9bd = getentarray("crypt_puzzle_disc", "script_noteworthy");
    var_7f582b31 = 0;
    foreach (var_5868c432 in var_d8c2b9bd) {
        if (!isdefined(var_5868c432.target)) {
            continue;
        }
        var_5868c432.position = (var_7f582b31 + randomintrange(1, 3)) % 4;
        var_7f582b31 = var_5868c432.position;
    }
    function_dadea124(var_d8c2b9bd);
}

// Namespace namespace_acbbd1f9
// Params 0, eflags: 0x1 linked
// Checksum 0x87c4f173, Offset: 0x1d20
// Size: 0x4c
function function_bf093c24() {
    self clientfield::set("switch_spark", 1);
    wait(0.5);
    self clientfield::set("switch_spark", 0);
}

// Namespace namespace_acbbd1f9
// Params 3, eflags: 0x1 linked
// Checksum 0x81149237, Offset: 0x1d78
// Size: 0x1de
function function_865b0a10(var_4768a576, var_8305c467, b_clockwise) {
    var_2f4608f3 = array(var_4768a576);
    var_8305c467 useanimtree(#generic);
    var_427f919 = getanimlength(generic%p7_fxanim_zm_ori_puzzle_switch_anim);
    while (true) {
        e_triggerer = self waittill(#"trigger");
        if (!level flag::get("disc_rotation_active")) {
            level flag::set("disc_rotation_active");
            var_8305c467 animscripted("lever_switch", var_8305c467.origin, var_8305c467.angles, "p7_fxanim_zm_ori_puzzle_switch_anim");
            var_8305c467 playsound("zmb_crypt_lever");
            wait(var_427f919 * 0.5);
            var_8305c467 thread function_bf093c24();
            array::thread_all(var_2f4608f3, &function_93f3ba53, b_clockwise);
            wait(1);
            level flag::clear("disc_rotation_active");
            level notify(#"hash_2bda1c0c", e_triggerer);
        }
        level notify(#"hash_9d912aa6");
    }
}

