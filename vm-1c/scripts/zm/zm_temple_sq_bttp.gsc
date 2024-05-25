#using scripts/zm/zm_temple_sq_skits;
#using scripts/zm/zm_temple_sq_brock;
#using scripts/zm/zm_temple_sq;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_audio;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_3335be;

// Namespace namespace_3335be
// Params 0, eflags: 0x1 linked
// Checksum 0x830fafc7, Offset: 0x520
// Size: 0xb4
function init() {
    namespace_6e97c459::function_5a90ed82("sq", "bttp", &init_stage, &function_7747c56, &function_cc3f3f6a);
    namespace_6e97c459::function_b9676730("sq", "bttp", 300);
    namespace_6e97c459::function_9a85e396("sq", "bttp", "sq_bttp_glyph", undefined, &function_8feeec3c);
}

// Namespace namespace_3335be
// Params 0, eflags: 0x1 linked
// Checksum 0x78374dee, Offset: 0x5e0
// Size: 0xb4
function init_stage() {
    if (isdefined(level.var_561c8f96)) {
        level.var_561c8f96 ghost();
    }
    level.var_5f315f0b = 0;
    namespace_abd6a8a5::function_ac4ad5b0();
    var_b28c3b10 = getentarray("sq_spiketrap", "targetname");
    array::thread_all(var_b28c3b10, &trap_thread);
    level thread function_9873f186();
}

// Namespace namespace_3335be
// Params 0, eflags: 0x1 linked
// Checksum 0xee9f00a7, Offset: 0x6a0
// Size: 0x2c
function function_9873f186() {
    wait(0.5);
    level thread namespace_435c2400::function_acc79afb("tt6");
}

// Namespace namespace_3335be
// Params 0, eflags: 0x1 linked
// Checksum 0x6d10cb84, Offset: 0x6d8
// Size: 0xee
function function_20f15b9() {
    level endon(#"hash_20531487");
    while (true) {
        amount, attacker, direction, point, var_e5f012d6, modelname, tagname = self waittill(#"damage");
        if (var_e5f012d6 == "MOD_EXPLOSIVE" || var_e5f012d6 == "MOD_EXPLOSIVE_SPLASH" || var_e5f012d6 == "MOD_GRENADE" || isplayer(attacker) && var_e5f012d6 == "MOD_GRENADE_SPLASH") {
            self.var_bbca234 notify(#"triggered", attacker);
            return;
        }
    }
}

// Namespace namespace_3335be
// Params 0, eflags: 0x1 linked
// Checksum 0x319f992a, Offset: 0x7d0
// Size: 0x134
function trap_thread() {
    level endon(#"hash_20531487");
    self.trigger = spawn("trigger_damage", self.origin, 0, 32, 72);
    self.trigger.height = 72;
    self.trigger.radius = 32;
    self.trigger.var_bbca234 = self;
    self.trigger thread function_20f15b9();
    who = self waittill(#"triggered");
    who thread zm_audio::create_and_play_dialog("eggs", "quest1", 7);
    self.trigger playsound("evt_sq_bttp_wood_explo");
    self ghost();
    level flag::set("trap_destroyed");
}

// Namespace namespace_3335be
// Params 0, eflags: 0x1 linked
// Checksum 0x7b4b813d, Offset: 0x910
// Size: 0x80
function function_e3bf4adb() {
    /#
        self endon(#"death");
        self endon(#"done");
        level endon(#"hash_20531487");
        while (!(isdefined(level.disable_print3d_ent) && level.disable_print3d_ent)) {
            print3d(self.origin, "MOD_GRENADE", (0, 0, 255), 1);
            wait(0.1);
        }
    #/
}

// Namespace namespace_3335be
// Params 0, eflags: 0x1 linked
// Checksum 0x56da5f35, Offset: 0x998
// Size: 0x1bc
function function_8feeec3c() {
    hits = 0;
    self thread function_e3bf4adb();
    while (true) {
        amount, attacker, dir, point, type = self waittill(#"damage");
        self playsound("evt_sq_bttp_carve");
        if (type == "MOD_MELEE") {
            hits++;
            if (hits >= 1) {
                break;
            }
        }
    }
    self setmodel(self.tile);
    self notify(#"done");
    level.var_5f315f0b++;
    if (isdefined(attacker) && isplayer(attacker)) {
        if (level.var_5f315f0b < level.var_13439433) {
            if (randomintrange(0, 101) <= 75) {
                attacker thread zm_audio::create_and_play_dialog("eggs", "quest6", randomintrange(0, 4));
            }
            return;
        }
        attacker thread zm_audio::create_and_play_dialog("eggs", "quest6", 4);
    }
}

// Namespace namespace_3335be
// Params 1, eflags: 0x1 linked
// Checksum 0x8a414554, Offset: 0xb60
// Size: 0x156
function function_87175782(tile) {
    retval = "p_ztem_glyphs_01_unfinished";
    switch (tile) {
    case 31:
        retval = "p7_zm_sha_glyph_stone_01";
        break;
    case 32:
        retval = "p7_zm_sha_glyph_stone_02";
        break;
    case 33:
        retval = "p7_zm_sha_glyph_stone_03";
        break;
    case 34:
        retval = "p7_zm_sha_glyph_stone_04";
        break;
    case 35:
        retval = "p7_zm_sha_glyph_stone_05";
        break;
    case 36:
        retval = "p7_zm_sha_glyph_stone_06";
        break;
    case 37:
        retval = "p7_zm_sha_glyph_stone_07";
        break;
    case 38:
        retval = "p7_zm_sha_glyph_stone_08";
        break;
    case 39:
        retval = "p7_zm_sha_glyph_stone_09";
        break;
    case 40:
        retval = "p7_zm_sha_glyph_stone_10";
        break;
    case 41:
        retval = "p7_zm_sha_glyph_stone_11";
        break;
    case 42:
        retval = "p7_zm_sha_glyph_stone_12";
        break;
    }
    return retval;
}

// Namespace namespace_3335be
// Params 0, eflags: 0x1 linked
// Checksum 0x5e39524a, Offset: 0xcc0
// Size: 0x1e4
function function_7747c56() {
    level endon(#"hash_20531487");
    var_b6e112da = array("p7_zm_sha_glyph_stone_01_unlit", "p7_zm_sha_glyph_stone_02_unlit", "p7_zm_sha_glyph_stone_03_unlit", "p7_zm_sha_glyph_stone_04_unlit", "p7_zm_sha_glyph_stone_05_unlit", "p7_zm_sha_glyph_stone_06_unlit", "p7_zm_sha_glyph_stone_07_unlit", "p7_zm_sha_glyph_stone_08_unlit", "p7_zm_sha_glyph_stone_09_unlit", "p7_zm_sha_glyph_stone_10_unlit", "p7_zm_sha_glyph_stone_11_unlit", "p7_zm_sha_glyph_stone_12_unlit");
    var_b6e112da = array::randomize(var_b6e112da);
    ents = getentarray("sq_bttp_glyph", "targetname");
    level.var_13439433 = ents.size;
    for (i = 0; i < ents.size; i++) {
        ents[i].tile = function_87175782(var_b6e112da[i]);
        ents[i] setmodel(var_b6e112da[i]);
    }
    while (true) {
        if (level.var_5f315f0b == ents.size) {
            break;
        }
        wait(0.1);
    }
    level flag::wait_till("trap_destroyed");
    level notify(#"hash_bd6f486d");
    wait(5);
    namespace_6e97c459::function_2f3ced1f("sq", "bttp");
}

// Namespace namespace_3335be
// Params 1, eflags: 0x1 linked
// Checksum 0x9e6c47b2, Offset: 0xeb0
// Size: 0x1e2
function function_cc3f3f6a(success) {
    var_b28c3b10 = getentarray("sq_spiketrap", "targetname");
    if (success) {
        namespace_1e4bbaa5::function_5f10d4a9();
        namespace_abd6a8a5::function_67e052f1(7, &namespace_abd6a8a5::function_437f8b58);
    } else {
        if (isdefined(level.var_561c8f96)) {
            level.var_561c8f96 show();
        }
        namespace_abd6a8a5::function_67e052f1(6);
        foreach (e_trap in var_b28c3b10) {
            e_trap show();
        }
        level thread namespace_435c2400::function_b6268f3d();
    }
    foreach (e_trap in var_b28c3b10) {
        if (isdefined(e_trap.trigger)) {
            e_trap.trigger delete();
        }
    }
}

