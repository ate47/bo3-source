#using scripts/codescripts/struct;
#using scripts/cp/voice/voice_biodomes2;
#using scripts/shared/clientfield_shared;
#using scripts/shared/music_shared;

#namespace cp_mi_sing_biodomes2_sound;

// Namespace cp_mi_sing_biodomes2_sound
// Params 0, eflags: 0x0
// Checksum 0x995bde10, Offset: 0x148
// Size: 0x2c
function main() {
    voice_biodomes2::init_voice();
    level thread namespace_76133733::function_f9551b60();
}

#namespace namespace_76133733;

// Namespace namespace_76133733
// Params 0, eflags: 0x0
// Checksum 0x318dc125, Offset: 0x180
// Size: 0x1c
function function_973b77f9() {
    music::setmusicstate("none");
}

// Namespace namespace_76133733
// Params 1, eflags: 0x0
// Checksum 0x36c6c88b, Offset: 0x1a8
// Size: 0x2c
function function_fcea1d9(var_4f269041) {
    wait var_4f269041;
    music::setmusicstate("none");
}

// Namespace namespace_76133733
// Params 0, eflags: 0x0
// Checksum 0x2618c52, Offset: 0x1e0
// Size: 0x1c
function function_683d15e() {
    music::setmusicstate("supertrees");
}

// Namespace namespace_76133733
// Params 0, eflags: 0x0
// Checksum 0x5ab8a416, Offset: 0x208
// Size: 0x1c
function function_ec357599() {
    music::setmusicstate("dome_slide");
}

// Namespace namespace_76133733
// Params 0, eflags: 0x0
// Checksum 0xcb2b9dda, Offset: 0x230
// Size: 0x1c
function function_11139d81() {
    music::setmusicstate("boat_ride");
}

// Namespace namespace_76133733
// Params 0, eflags: 0x0
// Checksum 0xf04b658f, Offset: 0x258
// Size: 0x1c
function function_a6bf2d53() {
    music::setmusicstate("slide_slam");
}

// Namespace namespace_76133733
// Params 0, eflags: 0x0
// Checksum 0x243bf246, Offset: 0x280
// Size: 0x34
function function_f9551b60() {
    level waittill(#"hash_8fd3985");
    level clientfield::set("sndIGCsnapshot", 4);
}

