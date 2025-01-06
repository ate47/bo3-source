#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/shared/music_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_cairo_lotus3_sound;

// Namespace cp_mi_cairo_lotus3_sound
// Params 0, eflags: 0x0
// Checksum 0xcab480e1, Offset: 0x138
// Size: 0x1c
function main() {
    level thread kill_alarm();
}

// Namespace cp_mi_cairo_lotus3_sound
// Params 0, eflags: 0x0
// Checksum 0xc96c2380, Offset: 0x160
// Size: 0x2c
function kill_alarm() {
    level waittill(#"hash_3369554");
    level util::clientnotify("kill_alarm");
}

#namespace namespace_3bad5a01;

// Namespace namespace_3bad5a01
// Params 0, eflags: 0x0
// Checksum 0x322b0dd6, Offset: 0x198
// Size: 0x1c
function function_d641bfe3() {
    music::setmusicstate("battle_four");
}

// Namespace namespace_3bad5a01
// Params 0, eflags: 0x0
// Checksum 0xa0b28c6c, Offset: 0x1c0
// Size: 0x1c
function function_d6e5b30() {
    music::setmusicstate("leviathan");
}

// Namespace namespace_3bad5a01
// Params 0, eflags: 0x0
// Checksum 0x6269eac4, Offset: 0x1e8
// Size: 0x1c
function function_6be50b2c() {
    music::setmusicstate("hospital");
}

// Namespace namespace_3bad5a01
// Params 0, eflags: 0x0
// Checksum 0xfd4dbae6, Offset: 0x210
// Size: 0x1c
function function_43ead72c() {
    music::setmusicstate("taylor_entrance");
}

// Namespace namespace_3bad5a01
// Params 0, eflags: 0x0
// Checksum 0x8e6c317b, Offset: 0x238
// Size: 0x1c
function function_dae48a54() {
    music::setmusicstate("old_friend");
}

// Namespace namespace_3bad5a01
// Params 0, eflags: 0x0
// Checksum 0xf5bf568d, Offset: 0x260
// Size: 0x1c
function function_973b77f9() {
    music::setmusicstate("none");
}

