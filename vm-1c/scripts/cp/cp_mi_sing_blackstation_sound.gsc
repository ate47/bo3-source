#using scripts/shared/clientfield_shared;
#using scripts/shared/music_shared;
#using scripts/codescripts/struct;

#namespace cp_mi_sing_blackstation_sound;

// Namespace cp_mi_sing_blackstation_sound
// Params 0, eflags: 0x1 linked
// Checksum 0x57ea5086, Offset: 0x218
// Size: 0x7c
function main() {
    level thread function_8a682a34();
    level thread function_70f35bef();
    level thread function_329c89f();
    clientfield::register("toplayer", "slowmo_duck_active", 1, 2, "int");
}

// Namespace cp_mi_sing_blackstation_sound
// Params 0, eflags: 0x1 linked
// Checksum 0x6fd6c53d, Offset: 0x2a0
// Size: 0x2c
function function_8a682a34() {
    level waittill(#"hash_d195be99");
    music::setmusicstate("military_action");
}

// Namespace cp_mi_sing_blackstation_sound
// Params 0, eflags: 0x1 linked
// Checksum 0x780b2ad0, Offset: 0x2d8
// Size: 0x34
function function_70f35bef() {
    level waittill(#"hash_9074b8ad");
    wait 1.85;
    music::setmusicstate("none");
}

// Namespace cp_mi_sing_blackstation_sound
// Params 0, eflags: 0x1 linked
// Checksum 0x113976a, Offset: 0x318
// Size: 0x2c
function function_329c89f() {
    level waittill(#"hash_329c89f");
    level clientfield::set("sndDrillWalla", 0);
}

#namespace namespace_4297372;

// Namespace namespace_4297372
// Params 0, eflags: 0x1 linked
// Checksum 0x57830479, Offset: 0x350
// Size: 0x1c
function function_973b77f9() {
    music::setmusicstate("none");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x1 linked
// Checksum 0xb8de633b, Offset: 0x378
// Size: 0x24
function function_fcea1d9() {
    wait 3;
    music::setmusicstate("none");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x1 linked
// Checksum 0xb3e813d4, Offset: 0x3a8
// Size: 0x1c
function function_240ac8fa() {
    music::setmusicstate("shanty_town");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x1 linked
// Checksum 0x8b8773a1, Offset: 0x3d0
// Size: 0x1c
function function_4f531ae2() {
    music::setmusicstate("54i_theme_igc");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x1 linked
// Checksum 0xffc98e45, Offset: 0x3f8
// Size: 0x1c
function function_fa2e45b8() {
    music::setmusicstate("battle_1");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x1 linked
// Checksum 0xf3dda14f, Offset: 0x420
// Size: 0x1c
function function_91146001() {
    music::setmusicstate("battle_1_docks");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x1 linked
// Checksum 0xa5aca76f, Offset: 0x448
// Size: 0x1c
function function_11139d81() {
    music::setmusicstate("boat_ride");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x1 linked
// Checksum 0x4a7c2014, Offset: 0x470
// Size: 0x1c
function function_5b1a53ea() {
    music::setmusicstate("rachael");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x1 linked
// Checksum 0x6caad59c, Offset: 0x498
// Size: 0x1c
function function_6c35b4f3() {
    music::setmusicstate("battle_2");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x1 linked
// Checksum 0xffa4f035, Offset: 0x4c0
// Size: 0x1c
function function_d4c52995() {
    music::setmusicstate("tension_loop");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x1 linked
// Checksum 0x71d83084, Offset: 0x4e8
// Size: 0x1c
function function_cde82250() {
    music::setmusicstate("data_relay");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x1 linked
// Checksum 0x1e7c8f83, Offset: 0x510
// Size: 0x24
function function_f152b1dc() {
    wait 3;
    music::setmusicstate("zip_line");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x1 linked
// Checksum 0x99a0339a, Offset: 0x540
// Size: 0x1c
function function_674f7650() {
    music::setmusicstate("last_building_underscore");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x1 linked
// Checksum 0x6a5fb495, Offset: 0x568
// Size: 0x1c
function function_37f7c98d() {
    music::setmusicstate("underwater");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x1 linked
// Checksum 0xf75d65f3, Offset: 0x590
// Size: 0x24
function function_bed0eaad() {
    wait 9;
    music::setmusicstate("police_station");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x1 linked
// Checksum 0x7350c032, Offset: 0x5c0
// Size: 0x1c
function function_6048af60() {
    music::setmusicstate("discovery");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x1 linked
// Checksum 0x1533e53f, Offset: 0x5e8
// Size: 0xf2
function function_a339da70() {
    playerlist = getplayers();
    foreach (player in playerlist) {
        player playsoundtoplayer("evt_takedown_slowmo_02", player);
        player playloopsound("evt_time_slow_loop");
        player clientfield::set_to_player("slowmo_duck_active", 1);
    }
}

// Namespace namespace_4297372
// Params 0, eflags: 0x1 linked
// Checksum 0x6f99f35d, Offset: 0x6e8
// Size: 0xea
function function_69fc18eb() {
    playerlist = getplayers();
    foreach (player in playerlist) {
        player playsoundtoplayer("evt_takedown_slowmo_exit", player);
        player stoploopsound();
        player clientfield::set_to_player("slowmo_duck_active", 0);
    }
}

