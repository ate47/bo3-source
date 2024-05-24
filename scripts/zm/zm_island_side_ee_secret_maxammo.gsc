#using scripts/zm/zm_island_util;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_5a453011;

// Namespace namespace_5a453011
// Params 0, eflags: 0x2
// Checksum 0x8ec3ddd7, Offset: 0x430
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_island_side_ee_secret_maxammo", &__init__, undefined, undefined);
}

// Namespace namespace_5a453011
// Params 0, eflags: 0x0
// Checksum 0x763f90c3, Offset: 0x470
// Size: 0x16c
function __init__() {
    level.var_e9cb2217 = spawnstruct();
    level.var_e9cb2217.mdl_wall = getent("side_ee_secret_maxammo_wall", "targetname");
    level.var_e9cb2217.var_66253114 = getent("side_ee_secret_maxammo_decal", "targetname");
    level.var_e9cb2217.mdl_clip = getent("side_ee_secret_maxammo_clip", "targetname");
    level.var_e9cb2217.var_fc7e1b7a = struct::get("s_secret_ammo_pos", "targetname");
    level.var_e9cb2217.var_2559c370 = getent("easter_egg_hidden_max_ammo_appear", "targetname");
    level.var_e9cb2217.var_2559c370 hide();
    callback::on_spawned(&on_player_spawned);
    callback::on_connect(&on_player_connected);
}

// Namespace namespace_5a453011
// Params 0, eflags: 0x0
// Checksum 0xbe1d8fa5, Offset: 0x5e8
// Size: 0x7c
function main() {
    level.var_e9cb2217.mdl_wall clientfield::set("do_fade_material", 1);
    level.var_e9cb2217.var_66253114 clientfield::set("do_fade_material", 0.5);
    /#
        level thread function_35b46d1a();
    #/
}

// Namespace namespace_5a453011
// Params 0, eflags: 0x0
// Checksum 0x12185fee, Offset: 0x670
// Size: 0x2c
function on_player_spawned() {
    self thread function_1c4fc4a7(level.var_e9cb2217.mdl_wall);
}

// Namespace namespace_5a453011
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x6a8
// Size: 0x4
function on_player_connected() {
    
}

// Namespace namespace_5a453011
// Params 1, eflags: 0x0
// Checksum 0xc03c180a, Offset: 0x6b8
// Size: 0xbc
function function_1c4fc4a7(mdl_target) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"hash_49419595");
    if (isdefined(mdl_target)) {
        self namespace_8aed53c9::function_7448e472(mdl_target);
        if (!isdefined(mdl_target) || mdl_target.var_f0b65c0a !== self) {
            self notify(#"hash_49419595");
            return;
        }
        function_8ae0d6df();
        callback::remove_on_spawned(&on_player_spawned);
    }
}

// Namespace namespace_5a453011
// Params 0, eflags: 0x0
// Checksum 0xea5ba053, Offset: 0x780
// Size: 0x16c
function function_8ae0d6df() {
    exploder::exploder("fxexp_507");
    var_7ddcf23 = level.var_e9cb2217.var_fc7e1b7a;
    var_b1f3f7cd = var_7ddcf23.origin;
    zm_powerups::specific_powerup_drop("full_ammo", var_b1f3f7cd);
    level.var_e9cb2217.var_2559c370 show();
    level.var_e9cb2217.var_66253114 clientfield::set("do_fade_material", 0);
    wait(0.25);
    level.var_e9cb2217.mdl_wall clientfield::set("do_fade_material", 0);
    wait(0.25);
    level.var_e9cb2217.var_66253114 delete();
    level.var_e9cb2217.mdl_wall delete();
    if (isdefined(level.var_e9cb2217.mdl_clip)) {
        level.var_e9cb2217.mdl_clip delete();
    }
}

/#

    // Namespace namespace_5a453011
    // Params 0, eflags: 0x0
    // Checksum 0x89ac6280, Offset: 0x8f8
    // Size: 0x44
    function function_35b46d1a() {
        zm_devgui::add_custom_devgui_callback(&function_41601624);
        adddebugcommand("<unknown string>");
    }

    // Namespace namespace_5a453011
    // Params 1, eflags: 0x0
    // Checksum 0xe807f219, Offset: 0x948
    // Size: 0x46
    function function_41601624(cmd) {
        switch (cmd) {
        default:
            function_8ae0d6df();
            return 1;
        }
        return 0;
    }

#/
