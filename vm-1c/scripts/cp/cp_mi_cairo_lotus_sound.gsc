#using scripts/shared/music_shared;
#using scripts/shared/util_shared;
#using scripts/cp/_util;
#using scripts/codescripts/struct;

#namespace cp_mi_cairo_lotus_sound;

// Namespace cp_mi_cairo_lotus_sound
// Params 0, eflags: 0x1 linked
// Checksum 0xb4b6074b, Offset: 0x1a8
// Size: 0x34
function main() {
    level thread start_battle();
    level thread function_ba59ec78();
}

// Namespace cp_mi_cairo_lotus_sound
// Params 0, eflags: 0x1 linked
// Checksum 0xf899ac1b, Offset: 0x1e8
// Size: 0x2c
function start_battle() {
    level waittill(#"hash_72d53556");
    level util::clientnotify("start_battle_sound");
}

// Namespace cp_mi_cairo_lotus_sound
// Params 0, eflags: 0x1 linked
// Checksum 0x19e4574d, Offset: 0x220
// Size: 0x2c
function function_ba59ec78() {
    level waittill(#"hash_fe7439eb");
    level util::clientnotify("kill_security_chatter");
}

#namespace namespace_66fe78fb;

// Namespace namespace_66fe78fb
// Params 0, eflags: 0x1 linked
// Checksum 0xe25aaf7d, Offset: 0x258
// Size: 0x1c
function play_intro() {
    music::setmusicstate("intro");
}

// Namespace namespace_66fe78fb
// Params 0, eflags: 0x1 linked
// Checksum 0x9fe9c94b, Offset: 0x280
// Size: 0x1c
function function_36e942f6() {
    music::setmusicstate("battle_one_part_one");
}

// Namespace namespace_66fe78fb
// Params 0, eflags: 0x1 linked
// Checksum 0xdbf01aa6, Offset: 0x2a8
// Size: 0x1c
function function_f3bdd599() {
    music::setmusicstate("elevator_ride");
}

// Namespace namespace_66fe78fb
// Params 0, eflags: 0x1 linked
// Checksum 0xc238b5b0, Offset: 0x2d0
// Size: 0x24
function function_d116b1d8() {
    wait 10;
    music::setmusicstate("battle_one_part_two");
}

// Namespace namespace_66fe78fb
// Params 0, eflags: 0x1 linked
// Checksum 0x3725fc8b, Offset: 0x300
// Size: 0x5c
function function_f2d3d939() {
    music::setmusicstate("air_duct");
    wait 15;
    util::clientnotify("sndRampair");
    wait 25;
    util::clientnotify("sndRampEnd");
}

// Namespace namespace_66fe78fb
// Params 0, eflags: 0x1 linked
// Checksum 0x3cfa9b48, Offset: 0x368
// Size: 0x24
function function_86781870() {
    wait 0.5;
    music::setmusicstate("hq_battle");
}

// Namespace namespace_66fe78fb
// Params 0, eflags: 0x1 linked
// Checksum 0xc5595ac1, Offset: 0x398
// Size: 0x1c
function function_8836c025() {
    music::setmusicstate("computer_hack");
}

// Namespace namespace_66fe78fb
// Params 0, eflags: 0x0
// Checksum 0x392417eb, Offset: 0x3c0
// Size: 0x1c
function function_fd00a4f2() {
    music::setmusicstate("breach_stinger");
}

// Namespace namespace_66fe78fb
// Params 0, eflags: 0x0
// Checksum 0xa2151a2e, Offset: 0x3e8
// Size: 0x1c
function function_51e72857() {
    music::setmusicstate("battle_two");
}

// Namespace namespace_66fe78fb
// Params 0, eflags: 0x1 linked
// Checksum 0x83899d83, Offset: 0x410
// Size: 0x1c
function function_973b77f9() {
    music::setmusicstate("none");
}

