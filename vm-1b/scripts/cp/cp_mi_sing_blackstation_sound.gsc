#using scripts/shared/clientfield_shared;
#using scripts/shared/music_shared;
#using scripts/codescripts/struct;

#namespace cp_mi_sing_blackstation_sound;

// Namespace cp_mi_sing_blackstation_sound
// Params 0, eflags: 0x0
// Checksum 0xde7fc5b9, Offset: 0x218
// Size: 0x5a
function main() {
    level thread function_8a682a34();
    level thread function_70f35bef();
    level thread function_329c89f();
    clientfield::register("toplayer", "slowmo_duck_active", 1, 2, "int");
}

// Namespace cp_mi_sing_blackstation_sound
// Params 0, eflags: 0x0
// Checksum 0x11e2c125, Offset: 0x280
// Size: 0x22
function function_8a682a34() {
    level waittill(#"hash_d195be99");
    music::setmusicstate("military_action");
}

// Namespace cp_mi_sing_blackstation_sound
// Params 0, eflags: 0x0
// Checksum 0x6aa4fea1, Offset: 0x2b0
// Size: 0x2a
function function_70f35bef() {
    level waittill(#"hash_9074b8ad");
    wait 1.85;
    music::setmusicstate("none");
}

// Namespace cp_mi_sing_blackstation_sound
// Params 0, eflags: 0x0
// Checksum 0xb609616, Offset: 0x2e8
// Size: 0x22
function function_329c89f() {
    level waittill(#"hash_329c89f");
    level clientfield::set("sndDrillWalla", 0);
}

#namespace namespace_4297372;

// Namespace namespace_4297372
// Params 0, eflags: 0x0
// Checksum 0x408faa5f, Offset: 0x318
// Size: 0x1a
function function_973b77f9() {
    music::setmusicstate("none");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x0
// Checksum 0xb13f4db9, Offset: 0x340
// Size: 0x1a
function function_fcea1d9() {
    wait 3;
    music::setmusicstate("none");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x0
// Checksum 0xcc654a9f, Offset: 0x368
// Size: 0x1a
function function_240ac8fa() {
    music::setmusicstate("shanty_town");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x0
// Checksum 0x2b1d5a86, Offset: 0x390
// Size: 0x1a
function function_4f531ae2() {
    music::setmusicstate("54i_theme_igc");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x0
// Checksum 0x1035ffd0, Offset: 0x3b8
// Size: 0x1a
function function_fa2e45b8() {
    music::setmusicstate("battle_1");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x0
// Checksum 0x48cbc4c1, Offset: 0x3e0
// Size: 0x1a
function function_91146001() {
    music::setmusicstate("battle_1_docks");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x0
// Checksum 0xcc659815, Offset: 0x408
// Size: 0x1a
function function_11139d81() {
    music::setmusicstate("boat_ride");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x0
// Checksum 0x525548ec, Offset: 0x430
// Size: 0x1a
function function_5b1a53ea() {
    music::setmusicstate("rachael");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x0
// Checksum 0x7d742617, Offset: 0x458
// Size: 0x1a
function function_6c35b4f3() {
    music::setmusicstate("battle_2");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x0
// Checksum 0xd7bf4993, Offset: 0x480
// Size: 0x1a
function function_d4c52995() {
    music::setmusicstate("tension_loop");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x0
// Checksum 0x41eef52d, Offset: 0x4a8
// Size: 0x1a
function function_cde82250() {
    music::setmusicstate("data_relay");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x0
// Checksum 0x892da37d, Offset: 0x4d0
// Size: 0x1a
function function_f152b1dc() {
    wait 3;
    music::setmusicstate("zip_line");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x0
// Checksum 0x8ca17643, Offset: 0x4f8
// Size: 0x1a
function function_674f7650() {
    music::setmusicstate("last_building_underscore");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x0
// Checksum 0x5c27eef4, Offset: 0x520
// Size: 0x1a
function function_37f7c98d() {
    music::setmusicstate("underwater");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x0
// Checksum 0xc86afcc5, Offset: 0x548
// Size: 0x1a
function function_bed0eaad() {
    wait 9;
    music::setmusicstate("police_station");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x0
// Checksum 0xcd2bae9c, Offset: 0x570
// Size: 0x1a
function function_6048af60() {
    music::setmusicstate("discovery");
}

// Namespace namespace_4297372
// Params 0, eflags: 0x0
// Checksum 0x857dd03d, Offset: 0x598
// Size: 0xab
function function_a339da70() {
    playerlist = getplayers();
    foreach (player in playerlist) {
        player playsoundtoplayer("evt_takedown_slowmo_02", player);
        player playloopsound("evt_time_slow_loop");
        player clientfield::set_to_player("slowmo_duck_active", 1);
    }
}

// Namespace namespace_4297372
// Params 0, eflags: 0x0
// Checksum 0xc6fb3f28, Offset: 0x650
// Size: 0xa3
function function_69fc18eb() {
    playerlist = getplayers();
    foreach (player in playerlist) {
        player playsoundtoplayer("evt_takedown_slowmo_exit", player);
        player stoploopsound();
        player clientfield::set_to_player("slowmo_duck_active", 0);
    }
}

