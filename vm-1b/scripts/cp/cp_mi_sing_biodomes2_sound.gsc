#using scripts/codescripts/struct;
#using scripts/cp/voice/voice_biodomes2;
#using scripts/shared/clientfield_shared;
#using scripts/shared/music_shared;

#namespace cp_mi_sing_biodomes2_sound;

// Namespace cp_mi_sing_biodomes2_sound
// Params 0, eflags: 0x0
// Checksum 0x8e08d181, Offset: 0x148
// Size: 0x22
function main() {
    voice_biodomes2::init_voice();
    level thread namespace_76133733::function_f9551b60();
}

#namespace namespace_76133733;

// Namespace namespace_76133733
// Params 0, eflags: 0x0
// Checksum 0x2177bf94, Offset: 0x178
// Size: 0x1a
function function_973b77f9() {
    music::setmusicstate("none");
}

// Namespace namespace_76133733
// Params 1, eflags: 0x0
// Checksum 0xc27fb5d4, Offset: 0x1a0
// Size: 0x22
function function_fcea1d9(var_4f269041) {
    wait var_4f269041;
    music::setmusicstate("none");
}

// Namespace namespace_76133733
// Params 0, eflags: 0x0
// Checksum 0x2c80295e, Offset: 0x1d0
// Size: 0x1a
function function_683d15e() {
    music::setmusicstate("supertrees");
}

// Namespace namespace_76133733
// Params 0, eflags: 0x0
// Checksum 0x9dbf03c9, Offset: 0x1f8
// Size: 0x1a
function function_ec357599() {
    music::setmusicstate("dome_slide");
}

// Namespace namespace_76133733
// Params 0, eflags: 0x0
// Checksum 0xc55948d3, Offset: 0x220
// Size: 0x1a
function function_11139d81() {
    music::setmusicstate("boat_ride");
}

// Namespace namespace_76133733
// Params 0, eflags: 0x0
// Checksum 0xb39da68f, Offset: 0x248
// Size: 0x1a
function function_a6bf2d53() {
    music::setmusicstate("slide_slam");
}

// Namespace namespace_76133733
// Params 0, eflags: 0x0
// Checksum 0xf7583ab2, Offset: 0x270
// Size: 0x22
function function_f9551b60() {
    level waittill(#"hash_8fd3985");
    level clientfield::set("sndIGCsnapshot", 4);
}

