#using scripts/codescripts/struct;
#using scripts/cp/voice/voice_infection1;
#using scripts/shared/music_shared;

#namespace cp_mi_cairo_infection_sound;

// Namespace cp_mi_cairo_infection_sound
// Params 0, eflags: 0x0
// Checksum 0xedfcd52f, Offset: 0x188
// Size: 0x12
function main() {
    voice_infection1::init_voice();
}

#namespace namespace_eccdd5d1;

// Namespace namespace_eccdd5d1
// Params 0, eflags: 0x0
// Checksum 0x67c63fdb, Offset: 0x1a8
// Size: 0x1a
function function_14588839() {
    wait 1;
    playsoundatposition("evt_baby_cry", (0, 0, 0));
}

// Namespace namespace_eccdd5d1
// Params 0, eflags: 0x0
// Checksum 0xf154a20c, Offset: 0x1d0
// Size: 0x1a
function function_973b77f9() {
    music::setmusicstate("none");
}

// Namespace namespace_eccdd5d1
// Params 0, eflags: 0x0
// Checksum 0xd5236145, Offset: 0x1f8
// Size: 0x1a
function play_intro() {
    music::setmusicstate("intro");
}

// Namespace namespace_eccdd5d1
// Params 0, eflags: 0x0
// Checksum 0x1f90d3a, Offset: 0x220
// Size: 0x1a
function function_97020766() {
    music::setmusicstate("theia_battle");
}

// Namespace namespace_eccdd5d1
// Params 0, eflags: 0x0
// Checksum 0x72c6a876, Offset: 0x248
// Size: 0x1a
function function_a693b757() {
    music::setmusicstate("interface");
}

// Namespace namespace_eccdd5d1
// Params 0, eflags: 0x0
// Checksum 0x1852e57, Offset: 0x270
// Size: 0x1a
function function_8e8e5a12() {
    music::setmusicstate("frozen_trees_1");
}

// Namespace namespace_eccdd5d1
// Params 0, eflags: 0x0
// Checksum 0x4f417f51, Offset: 0x298
// Size: 0x1a
function function_688bdfa9() {
    music::setmusicstate("frozen_trees_2");
}

// Namespace namespace_eccdd5d1
// Params 0, eflags: 0x0
// Checksum 0x84adf4d4, Offset: 0x2c0
// Size: 0x1a
function function_42896540() {
    music::setmusicstate("frozen_trees_3");
}

// Namespace namespace_eccdd5d1
// Params 0, eflags: 0x0
// Checksum 0xe123a815, Offset: 0x2e8
// Size: 0x1a
function function_4c9abe1f() {
    music::setmusicstate("frozen_trees_4");
}

// Namespace namespace_eccdd5d1
// Params 0, eflags: 0x0
// Checksum 0x73f4b7ef, Offset: 0x310
// Size: 0x1a
function function_582799a6() {
    music::setmusicstate("baby");
}

// Namespace namespace_eccdd5d1
// Params 0, eflags: 0x0
// Checksum 0x50a0fa0e, Offset: 0x338
// Size: 0x1a
function function_6ef2bfc6() {
    music::setmusicstate("coalescense_destruction");
}

// Namespace namespace_eccdd5d1
// Params 0, eflags: 0x0
// Checksum 0x8b02b8c, Offset: 0x360
// Size: 0x1a
function function_e0a3aca4() {
    music::setmusicstate("coalescense_investigation");
}

