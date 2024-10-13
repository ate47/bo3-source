#using scripts/shared/music_shared;
#using scripts/cp/voice/voice_biodomes;
#using scripts/codescripts/struct;

#namespace cp_mi_sing_biodomes_sound;

// Namespace cp_mi_sing_biodomes_sound
// Params 0, eflags: 0x0
// Checksum 0xb1e6dfd1, Offset: 0x178
// Size: 0x22
function main() {
    voice_biodomes::init_voice();
    level thread function_ced15c18();
}

// Namespace cp_mi_sing_biodomes_sound
// Params 0, eflags: 0x0
// Checksum 0x4b93ee31, Offset: 0x1a8
// Size: 0x42
function function_ced15c18() {
    wait 2;
    var_a66f2065 = spawn("script_origin", (15049, 15030, -120));
    var_a66f2065 playloopsound("mus_bar_background");
}

#namespace namespace_f1b4cbbc;

// Namespace namespace_f1b4cbbc
// Params 0, eflags: 0x0
// Checksum 0x9d1c0836, Offset: 0x1f8
// Size: 0x1a
function function_973b77f9() {
    music::setmusicstate("none");
}

// Namespace namespace_f1b4cbbc
// Params 0, eflags: 0x0
// Checksum 0x1dc7d377, Offset: 0x220
// Size: 0x1a
function function_f936f64e() {
    music::setmusicstate("igc_intro");
}

// Namespace namespace_f1b4cbbc
// Params 0, eflags: 0x0
// Checksum 0xa34471d, Offset: 0x248
// Size: 0x1a
function function_fa2e45b8() {
    music::setmusicstate("battle_1");
}

// Namespace namespace_f1b4cbbc
// Params 0, eflags: 0x0
// Checksum 0x3ceb9a66, Offset: 0x270
// Size: 0x1a
function function_6c35b4f3() {
    music::setmusicstate("battle_2");
}

// Namespace namespace_f1b4cbbc
// Params 0, eflags: 0x0
// Checksum 0xfe49c203, Offset: 0x298
// Size: 0x1a
function function_ac7f09b1() {
    music::setmusicstate("warlord");
}

// Namespace namespace_f1b4cbbc
// Params 0, eflags: 0x0
// Checksum 0x3ceccf6, Offset: 0x2c0
// Size: 0x1a
function function_2e34977e() {
    music::setmusicstate("siegebot");
}

// Namespace namespace_f1b4cbbc
// Params 0, eflags: 0x0
// Checksum 0x9d747215, Offset: 0x2e8
// Size: 0x1a
function function_ae96b33c() {
    music::setmusicstate("eyes_on_xiulan");
}

// Namespace namespace_f1b4cbbc
// Params 0, eflags: 0x0
// Checksum 0x44d15719, Offset: 0x310
// Size: 0x1a
function function_46333a8a() {
    music::setmusicstate("battle_3");
}

// Namespace namespace_f1b4cbbc
// Params 0, eflags: 0x0
// Checksum 0x67f70e7f, Offset: 0x338
// Size: 0x1a
function function_6f733943() {
    music::setmusicstate("jump_loop");
}

// Namespace namespace_f1b4cbbc
// Params 0, eflags: 0x0
// Checksum 0x57bfd3e6, Offset: 0x360
// Size: 0x1a
function function_cc3270ca() {
    music::setmusicstate("jump");
}

// Namespace namespace_f1b4cbbc
// Params 0, eflags: 0x0
// Checksum 0xdced7cdc, Offset: 0x388
// Size: 0x1a
function function_11139d81() {
    music::setmusicstate("boat_ride");
}

// Namespace namespace_f1b4cbbc
// Params 0, eflags: 0x0
// Checksum 0xd1075ee3, Offset: 0x3b0
// Size: 0x1a
function function_3919d226() {
    music::setmusicstate("igc_3_data_drives");
}

