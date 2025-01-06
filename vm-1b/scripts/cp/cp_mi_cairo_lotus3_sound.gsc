#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/shared/music_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_cairo_lotus3_sound;

// Namespace cp_mi_cairo_lotus3_sound
// Params 0, eflags: 0x0
// Checksum 0xc8cf20b0, Offset: 0x138
// Size: 0x12
function main() {
    level thread kill_alarm();
}

// Namespace cp_mi_cairo_lotus3_sound
// Params 0, eflags: 0x0
// Checksum 0xed82e8d5, Offset: 0x158
// Size: 0x22
function kill_alarm() {
    level waittill(#"hash_3369554");
    level util::clientnotify("kill_alarm");
}

#namespace namespace_3bad5a01;

// Namespace namespace_3bad5a01
// Params 0, eflags: 0x0
// Checksum 0xe1e0ce4d, Offset: 0x188
// Size: 0x1a
function function_d641bfe3() {
    music::setmusicstate("battle_four");
}

// Namespace namespace_3bad5a01
// Params 0, eflags: 0x0
// Checksum 0x292dfec0, Offset: 0x1b0
// Size: 0x1a
function function_d6e5b30() {
    music::setmusicstate("leviathan");
}

// Namespace namespace_3bad5a01
// Params 0, eflags: 0x0
// Checksum 0xa15601bf, Offset: 0x1d8
// Size: 0x1a
function function_6be50b2c() {
    music::setmusicstate("hospital");
}

// Namespace namespace_3bad5a01
// Params 0, eflags: 0x0
// Checksum 0xe2494f77, Offset: 0x200
// Size: 0x1a
function function_43ead72c() {
    music::setmusicstate("taylor_entrance");
}

// Namespace namespace_3bad5a01
// Params 0, eflags: 0x0
// Checksum 0x6b640115, Offset: 0x228
// Size: 0x1a
function function_dae48a54() {
    music::setmusicstate("old_friend");
}

// Namespace namespace_3bad5a01
// Params 0, eflags: 0x0
// Checksum 0x1b44f5d2, Offset: 0x250
// Size: 0x1a
function function_973b77f9() {
    music::setmusicstate("none");
}

