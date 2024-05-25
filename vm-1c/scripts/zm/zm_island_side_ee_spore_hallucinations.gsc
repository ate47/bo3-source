#using scripts/zm/zm_island_util;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
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
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_c63a0940;

// Namespace namespace_c63a0940
// Params 0, eflags: 0x2
// Checksum 0x361863ef, Offset: 0x4a8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_island_side_ee_spore_hallucinations", &__init__, undefined, undefined);
}

// Namespace namespace_c63a0940
// Params 0, eflags: 0x1 linked
// Checksum 0x5b969e32, Offset: 0x4e8
// Size: 0x116
function __init__() {
    clientfield::register("toplayer", "hallucinate_bloody_walls", 9000, 1, "int");
    clientfield::register("toplayer", "hallucinate_spooky_sounds", 9000, 1, "int");
    callback::on_spawned(&on_player_spawned);
    callback::on_connect(&on_player_connected);
    level.var_40e8eaa5 = [];
    level.var_40e8eaa5["bloody_walls"] = getent("vol_hallucinate_bloody_walls", "targetname");
    level.var_40e8eaa5["corpses"] = getent("vol_hallucinate_corpses", "targetname");
}

/#

    // Namespace namespace_c63a0940
    // Params 0, eflags: 0x1 linked
    // Checksum 0x6fb9bff0, Offset: 0x608
    // Size: 0x1c
    function main() {
        level thread function_c6d55b0d();
    }

#/

// Namespace namespace_c63a0940
// Params 0, eflags: 0x1 linked
// Checksum 0x8e40123b, Offset: 0x630
// Size: 0x44
function on_player_connected() {
    self flag::init("hallucination_spookysounds_on");
    self flag::init("hallucination_bloodywalls_on");
}

// Namespace namespace_c63a0940
// Params 0, eflags: 0x1 linked
// Checksum 0x73ebbde2, Offset: 0x680
// Size: 0x24
function on_player_spawned() {
    self.var_5f5af9f0 = 0;
    self thread function_e58be395();
}

// Namespace namespace_c63a0940
// Params 0, eflags: 0x1 linked
// Checksum 0x213284e0, Offset: 0x6b0
// Size: 0x90
function function_e58be395() {
    self endon(#"death");
    self thread function_b200c473();
    while (true) {
        self waittill(#"hash_ece519d9");
        self.var_5f5af9f0++;
        if (self.var_5f5af9f0 > 5) {
            self thread function_51d3efd();
        }
        if (self.var_5f5af9f0 > 15) {
            self thread function_5d6bcf98();
        }
    }
}

// Namespace namespace_c63a0940
// Params 0, eflags: 0x1 linked
// Checksum 0x63d0e2e4, Offset: 0x748
// Size: 0x38
function function_b200c473() {
    self endon(#"death");
    while (true) {
        wait(300);
        if (self.var_5f5af9f0 > 0) {
            self.var_5f5af9f0--;
        }
    }
}

// Namespace namespace_c63a0940
// Params 0, eflags: 0x1 linked
// Checksum 0x7268493c, Offset: 0x788
// Size: 0xfc
function function_51d3efd() {
    self endon(#"death");
    if (!self flag::get("hallucination_spookysounds_on")) {
        self flag::set("hallucination_spookysounds_on");
        while (self.var_5f5af9f0 >= 5) {
            var_2499b02a = self namespace_8aed53c9::function_1867f3e8(800);
            if (var_2499b02a <= 3 && !self laststand::player_is_in_laststand()) {
                self function_5d3a5f36();
                wait(randomintrange(360, 480));
            }
            wait(5);
        }
        self flag::clear("hallucination_spookysounds_on");
    }
}

// Namespace namespace_c63a0940
// Params 0, eflags: 0x1 linked
// Checksum 0xd00b27ff, Offset: 0x890
// Size: 0x14c
function function_5d6bcf98() {
    self endon(#"death");
    if (!self flag::get("hallucination_bloodywalls_on")) {
        self flag::set("hallucination_bloodywalls_on");
        var_558d1e01 = getent("vol_hallucinate_bloody_walls", "targetname");
        var_58077680 = array("zone_jungle_lab_upper", "zone_swamp_lab_inside", "zone_operating_rooms");
        while (self.var_5f5af9f0 >= 15) {
            if (self namespace_8aed53c9::function_f2a55b5f(var_58077680) && self istouching(var_558d1e01)) {
                self function_f0e36b57();
                wait(randomintrange(360, 480));
            }
            wait(5);
        }
        self flag::clear("hallucination_bloodywalls_on");
    }
}

// Namespace namespace_c63a0940
// Params 0, eflags: 0x1 linked
// Checksum 0xebcb71dd, Offset: 0x9e8
// Size: 0x4c
function function_5d3a5f36() {
    self function_f0aa6b80(1);
    wait(randomintrange(10, 20));
    self function_f0aa6b80(0);
}

// Namespace namespace_c63a0940
// Params 0, eflags: 0x1 linked
// Checksum 0x27cca0d3, Offset: 0xa40
// Size: 0x7c
function function_f0e36b57() {
    self function_38943e4d(1);
    exploder::exploder("ex_ee_redtanks");
    wait(randomintrange(10, 20));
    self function_38943e4d(0);
    exploder::stop_exploder("ex_ee_redtanks");
}

// Namespace namespace_c63a0940
// Params 1, eflags: 0x1 linked
// Checksum 0x5a7450c2, Offset: 0xac8
// Size: 0x44
function function_38943e4d(b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    self clientfield::set_to_player("hallucinate_bloody_walls", b_on);
}

// Namespace namespace_c63a0940
// Params 1, eflags: 0x1 linked
// Checksum 0xe06f5d35, Offset: 0xb18
// Size: 0x44
function function_f0aa6b80(b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    self clientfield::set_to_player("hallucinate_spooky_sounds", b_on);
}

/#

    // Namespace namespace_c63a0940
    // Params 0, eflags: 0x1 linked
    // Checksum 0xcf38628a, Offset: 0xb68
    // Size: 0xa4
    function function_c6d55b0d() {
        zm_devgui::add_custom_devgui_callback(&function_4c6daca1);
        adddebugcommand("vol_hallucinate_corpses");
        adddebugcommand("vol_hallucinate_corpses");
        adddebugcommand("vol_hallucinate_corpses");
        adddebugcommand("vol_hallucinate_corpses");
        adddebugcommand("vol_hallucinate_corpses");
    }

    // Namespace namespace_c63a0940
    // Params 1, eflags: 0x1 linked
    // Checksum 0xab39e749, Offset: 0xc18
    // Size: 0xfe
    function function_4c6daca1(cmd) {
        switch (cmd) {
        case 8:
            level.activeplayers[0] thread function_f0e36b57();
            return 1;
        case 8:
            level.activeplayers[0] thread function_5d3a5f36();
            return 1;
        case 8:
            level thread function_ef6cd11(5);
            return 1;
        case 8:
            level thread function_ef6cd11(10);
            return 1;
        case 8:
            level thread function_ef6cd11(20);
            return 1;
        }
        return 0;
    }

    // Namespace namespace_c63a0940
    // Params 1, eflags: 0x1 linked
    // Checksum 0x96b544d3, Offset: 0xd20
    // Size: 0xe2
    function function_ef6cd11(var_7156fcfa) {
        foreach (player in level.activeplayers) {
            player.var_5f5af9f0 = var_7156fcfa;
            if (var_7156fcfa > 5) {
                player thread function_51d3efd();
            }
            if (var_7156fcfa > 15) {
                player thread function_5d6bcf98();
            }
        }
    }

#/
