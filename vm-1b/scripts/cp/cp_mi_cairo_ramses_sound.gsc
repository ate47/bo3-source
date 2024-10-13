#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/cp/voice/voice_ramses1;
#using scripts/cp/voice/voice_ramses;
#using scripts/shared/music_shared;
#using scripts/codescripts/struct;

#namespace cp_mi_cairo_ramses_sound;

// Namespace cp_mi_cairo_ramses_sound
// Params 0, eflags: 0x0
// Checksum 0xce042786, Offset: 0x1b0
// Size: 0x62
function main() {
    voice_ramses::init_voice();
    voice_ramses1::init_voice();
    level thread function_785c9e9c();
    level thread function_1af9b46e();
    level thread function_b23a802b();
    level thread function_aa79274f();
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0, eflags: 0x0
// Checksum 0xf6d6d38c, Offset: 0x220
// Size: 0x22
function function_785c9e9c() {
    level waittill(#"hash_18eb2769");
    music::setmusicstate("menendez_stinger");
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0, eflags: 0x0
// Checksum 0x791a79ac, Offset: 0x250
// Size: 0x1a
function function_1af9b46e() {
    level waittill(#"hash_ca1862bd");
    level thread namespace_e4c0c552::function_973b77f9();
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0, eflags: 0x0
// Checksum 0x329b29db, Offset: 0x278
// Size: 0x22
function function_aa79274f() {
    level waittill(#"hash_89bfff84");
    music::setmusicstate("raps_intro");
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0, eflags: 0x0
// Checksum 0xa663e1ef, Offset: 0x2a8
// Size: 0x22
function function_abcd4714() {
    level waittill(#"hash_8626937b");
    music::setmusicstate("none");
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0, eflags: 0x0
// Checksum 0xd3ef282c, Offset: 0x2d8
// Size: 0x22
function function_b23a802b() {
    level waittill(#"hash_47329bcb");
    music::setmusicstate("post_interrogation");
}

#namespace namespace_e4c0c552;

// Namespace namespace_e4c0c552
// Params 0, eflags: 0x0
// Checksum 0x48c0a495, Offset: 0x308
// Size: 0x1a
function function_4f8bda39() {
    music::setmusicstate("intro");
}

// Namespace namespace_e4c0c552
// Params 0, eflags: 0x0
// Checksum 0x6aaa4159, Offset: 0x330
// Size: 0x1a
function function_53de5c02() {
    music::setmusicstate("interrogation");
}

// Namespace namespace_e4c0c552
// Params 0, eflags: 0x0
// Checksum 0xd2060ec3, Offset: 0x358
// Size: 0x1a
function function_f444bf8e() {
    wait 5;
    music::setmusicstate("station_defend");
}

// Namespace namespace_e4c0c552
// Params 0, eflags: 0x0
// Checksum 0x2be6c46, Offset: 0x380
// Size: 0x1a
function function_9bda9447() {
    music::setmusicstate("station_defend_outro");
}

// Namespace namespace_e4c0c552
// Params 0, eflags: 0x0
// Checksum 0xa9bca655, Offset: 0x3a8
// Size: 0x1a
function function_973b77f9() {
    music::setmusicstate("none");
}

