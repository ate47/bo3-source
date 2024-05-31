#using scripts/shared/music_shared;
#using scripts/shared/util_shared;
#using scripts/cp/_util;
#using scripts/codescripts/struct;

#namespace namespace_9750c824;

// Namespace namespace_9750c824
// Params 0, eflags: 0x0
// namespace_9750c824<file_0>::function_d290ebfa
// Checksum 0x6a001a49, Offset: 0x1a8
// Size: 0x22
function main() {
    level thread function_cf637cc();
    level thread function_ba59ec78();
}

// Namespace namespace_9750c824
// Params 0, eflags: 0x0
// namespace_9750c824<file_0>::function_cf637cc
// Checksum 0xf95ae48, Offset: 0x1d8
// Size: 0x22
function function_cf637cc() {
    level waittill(#"hash_72d53556");
    level util::clientnotify("start_battle_sound");
}

// Namespace namespace_9750c824
// Params 0, eflags: 0x0
// namespace_9750c824<file_0>::function_ba59ec78
// Checksum 0x4b855ceb, Offset: 0x208
// Size: 0x22
function function_ba59ec78() {
    level waittill(#"hash_fe7439eb");
    level util::clientnotify("kill_security_chatter");
}

#namespace namespace_66fe78fb;

// Namespace namespace_66fe78fb
// Params 0, eflags: 0x0
// namespace_66fe78fb<file_0>::function_2c69b4a0
// Checksum 0x9db1123a, Offset: 0x238
// Size: 0x1a
function play_intro() {
    music::setmusicstate("intro");
}

// Namespace namespace_66fe78fb
// Params 0, eflags: 0x0
// namespace_66fe78fb<file_0>::function_36e942f6
// Checksum 0xaf908b94, Offset: 0x260
// Size: 0x1a
function function_36e942f6() {
    music::setmusicstate("battle_one_part_one");
}

// Namespace namespace_66fe78fb
// Params 0, eflags: 0x0
// namespace_66fe78fb<file_0>::function_f3bdd599
// Checksum 0x75016482, Offset: 0x288
// Size: 0x1a
function function_f3bdd599() {
    music::setmusicstate("elevator_ride");
}

// Namespace namespace_66fe78fb
// Params 0, eflags: 0x0
// namespace_66fe78fb<file_0>::function_d116b1d8
// Checksum 0x89371007, Offset: 0x2b0
// Size: 0x1a
function function_d116b1d8() {
    wait(10);
    music::setmusicstate("battle_one_part_two");
}

// Namespace namespace_66fe78fb
// Params 0, eflags: 0x0
// namespace_66fe78fb<file_0>::function_f2d3d939
// Checksum 0xd09d8cca, Offset: 0x2d8
// Size: 0x4a
function function_f2d3d939() {
    music::setmusicstate("air_duct");
    wait(15);
    util::clientnotify("sndRampair");
    wait(25);
    util::clientnotify("sndRampEnd");
}

// Namespace namespace_66fe78fb
// Params 0, eflags: 0x0
// namespace_66fe78fb<file_0>::function_86781870
// Checksum 0xe407ae7d, Offset: 0x330
// Size: 0x22
function function_86781870() {
    wait(0.5);
    music::setmusicstate("hq_battle");
}

// Namespace namespace_66fe78fb
// Params 0, eflags: 0x0
// namespace_66fe78fb<file_0>::function_8836c025
// Checksum 0xdcfaa99b, Offset: 0x360
// Size: 0x1a
function function_8836c025() {
    music::setmusicstate("computer_hack");
}

// Namespace namespace_66fe78fb
// Params 0, eflags: 0x0
// namespace_66fe78fb<file_0>::function_fd00a4f2
// Checksum 0x5f73fc78, Offset: 0x388
// Size: 0x1a
function function_fd00a4f2() {
    music::setmusicstate("breach_stinger");
}

// Namespace namespace_66fe78fb
// Params 0, eflags: 0x0
// namespace_66fe78fb<file_0>::function_51e72857
// Checksum 0xb3a139a1, Offset: 0x3b0
// Size: 0x1a
function function_51e72857() {
    music::setmusicstate("battle_two");
}

// Namespace namespace_66fe78fb
// Params 0, eflags: 0x0
// namespace_66fe78fb<file_0>::function_973b77f9
// Checksum 0x8e88a199, Offset: 0x3d8
// Size: 0x1a
function function_973b77f9() {
    music::setmusicstate("none");
}

