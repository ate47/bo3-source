#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/cp/voice/voice_ramses1;
#using scripts/cp/voice/voice_ramses;
#using scripts/shared/music_shared;
#using scripts/codescripts/struct;

#namespace namespace_39972b4;

// Namespace namespace_39972b4
// Params 0, eflags: 0x0
// Checksum 0x97c896de, Offset: 0x1b0
// Size: 0x84
function main() {
    namespace_aa1e4213::init_voice();
    namespace_db167d30::init_voice();
    level thread function_785c9e9c();
    level thread function_1af9b46e();
    level thread function_b23a802b();
    level thread function_aa79274f();
}

// Namespace namespace_39972b4
// Params 0, eflags: 0x0
// Checksum 0xf66de9ce, Offset: 0x240
// Size: 0x2c
function function_785c9e9c() {
    level waittill(#"hash_18eb2769");
    music::setmusicstate("menendez_stinger");
}

// Namespace namespace_39972b4
// Params 0, eflags: 0x0
// Checksum 0x19b40246, Offset: 0x278
// Size: 0x24
function function_1af9b46e() {
    level waittill(#"hash_ca1862bd");
    level thread namespace_e4c0c552::function_973b77f9();
}

// Namespace namespace_39972b4
// Params 0, eflags: 0x0
// Checksum 0x2e1583ce, Offset: 0x2a8
// Size: 0x2c
function function_aa79274f() {
    level waittill(#"hash_89bfff84");
    music::setmusicstate("raps_intro");
}

// Namespace namespace_39972b4
// Params 0, eflags: 0x0
// Checksum 0xf4ad8a04, Offset: 0x2e0
// Size: 0x2c
function function_abcd4714() {
    level waittill(#"hash_8626937b");
    music::setmusicstate("none");
}

// Namespace namespace_39972b4
// Params 0, eflags: 0x0
// Checksum 0xc2a49871, Offset: 0x318
// Size: 0x2c
function function_b23a802b() {
    level waittill(#"hash_47329bcb");
    music::setmusicstate("post_interrogation");
}

#namespace namespace_e4c0c552;

// Namespace namespace_e4c0c552
// Params 0, eflags: 0x0
// Checksum 0x61205c66, Offset: 0x350
// Size: 0x1c
function function_4f8bda39() {
    music::setmusicstate("intro");
}

// Namespace namespace_e4c0c552
// Params 0, eflags: 0x0
// Checksum 0xbd230536, Offset: 0x378
// Size: 0x1c
function function_53de5c02() {
    music::setmusicstate("interrogation");
}

// Namespace namespace_e4c0c552
// Params 0, eflags: 0x0
// Checksum 0xac9ca406, Offset: 0x3a0
// Size: 0x24
function function_f444bf8e() {
    wait(5);
    music::setmusicstate("station_defend");
}

// Namespace namespace_e4c0c552
// Params 0, eflags: 0x0
// Checksum 0x402a7cc3, Offset: 0x3d0
// Size: 0x1c
function function_9bda9447() {
    music::setmusicstate("station_defend_outro");
}

// Namespace namespace_e4c0c552
// Params 0, eflags: 0x0
// Checksum 0x58a62085, Offset: 0x3f8
// Size: 0x1c
function function_973b77f9() {
    music::setmusicstate("none");
}

