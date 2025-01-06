#using scripts/codescripts/struct;
#using scripts/cp/voice/voice_infection3;
#using scripts/shared/music_shared;

#namespace cp_mi_cairo_infection3_sound;

// Namespace cp_mi_cairo_infection3_sound
// Params 0, eflags: 0x0
// Checksum 0x271b95, Offset: 0x128
// Size: 0x22
function main() {
    voice_infection3::init_voice();
    level thread function_db38b214();
}

// Namespace cp_mi_cairo_infection3_sound
// Params 0, eflags: 0x0
// Checksum 0x2f46ddc1, Offset: 0x158
// Size: 0x22
function function_db38b214() {
    level waittill(#"hash_14bd0ef3");
    music::setmusicstate("corvus_stinger_2");
}

#namespace namespace_99d8554b;

// Namespace namespace_99d8554b
// Params 0, eflags: 0x0
// Checksum 0x3895348a, Offset: 0x188
// Size: 0x1a
function function_973b77f9() {
    music::setmusicstate("none");
}

// Namespace namespace_99d8554b
// Params 0, eflags: 0x0
// Checksum 0x33b11937, Offset: 0x1b0
// Size: 0x1a
function function_63b34b78() {
    music::setmusicstate("salim_interview_igc");
}

// Namespace namespace_99d8554b
// Params 0, eflags: 0x0
// Checksum 0x1b784ee0, Offset: 0x1d8
// Size: 0x1a
function function_faa82017() {
    music::setmusicstate("zombies");
}

// Namespace namespace_99d8554b
// Params 0, eflags: 0x0
// Checksum 0x8c295771, Offset: 0x200
// Size: 0x1a
function function_3d7fd2ca() {
    music::setmusicstate("sarah_ff");
}

// Namespace namespace_99d8554b
// Params 0, eflags: 0x0
// Checksum 0xf8fc7425, Offset: 0x228
// Size: 0x1a
function function_a0a44ed9() {
    music::setmusicstate("exit_mind");
}

