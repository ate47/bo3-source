#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/beam_shared;
#using scripts/shared/audio_shared;
#using scripts/codescripts/struct;

#namespace namespace_52adc03e;

// Namespace namespace_52adc03e
// Params 0, eflags: 0x2
// Checksum 0xb5103422, Offset: 0x5f0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_audio_zhd", &__init__, undefined, undefined);
}

// Namespace namespace_52adc03e
// Params 0, eflags: 0x0
// Checksum 0x839bd7d2, Offset: 0x630
// Size: 0xfc
function __init__() {
    clientfield::register("scriptmover", "snd_zhdegg", 21000, 2, "int", &function_97d247be, 0, 0);
    clientfield::register("scriptmover", "snd_zhdegg_arm", 21000, 1, "counter", &function_e312f684, 0, 0);
    level._effect["zhdegg_ballerina_appear"] = "dlc3/stalingrad/fx_main_impact_success";
    level._effect["zhdegg_ballerina_disappear"] = "dlc3/stalingrad/fx_main_impact_success";
    level._effect["zhdegg_arm_appear"] = "dlc3/stalingrad/fx_dirt_hand_burst_challenges";
    level thread setup_personality_character_exerts();
}

// Namespace namespace_52adc03e
// Params 7, eflags: 0x0
// Checksum 0xf6f1245, Offset: 0x738
// Size: 0x10c
function function_97d247be(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (newval == 1) {
            playfx(localclientnum, level._effect["zhdegg_ballerina_appear"], self.origin);
            playsound(0, "zmb_sam_egg_appear", self.origin);
        }
        return;
    }
    playfx(localclientnum, level._effect["zhdegg_ballerina_disappear"], self.origin);
    playsound(0, "zmb_sam_egg_disappear", self.origin);
}

// Namespace namespace_52adc03e
// Params 7, eflags: 0x0
// Checksum 0x4d78cb81, Offset: 0x850
// Size: 0x7c
function function_e312f684(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfx(localclientnum, level._effect["zhdegg_arm_appear"], self.origin, (0, 0, 1));
    }
}

// Namespace namespace_52adc03e
// Params 0, eflags: 0x0
// Checksum 0x43dc65dd, Offset: 0x8d8
// Size: 0x4da
function setup_personality_character_exerts() {
    util::waitforclient(0);
    level.exert_sounds[1]["meleeswipesoundplayer"][0] = "vox_plr_0_exert_knife_swipe_0";
    level.exert_sounds[1]["meleeswipesoundplayer"][1] = "vox_plr_0_exert_knife_swipe_1";
    level.exert_sounds[1]["meleeswipesoundplayer"][2] = "vox_plr_0_exert_knife_swipe_2";
    level.exert_sounds[1]["meleeswipesoundplayer"][3] = "vox_plr_0_exert_knife_swipe_3";
    level.exert_sounds[1]["meleeswipesoundplayer"][4] = "vox_plr_0_exert_knife_swipe_4";
    level.exert_sounds[2]["meleeswipesoundplayer"][0] = "vox_plr_1_exert_knife_swipe_0";
    level.exert_sounds[2]["meleeswipesoundplayer"][1] = "vox_plr_1_exert_knife_swipe_1";
    level.exert_sounds[2]["meleeswipesoundplayer"][2] = "vox_plr_1_exert_knife_swipe_2";
    level.exert_sounds[2]["meleeswipesoundplayer"][3] = "vox_plr_1_exert_knife_swipe_3";
    level.exert_sounds[2]["meleeswipesoundplayer"][4] = "vox_plr_1_exert_knife_swipe_4";
    level.exert_sounds[3]["meleeswipesoundplayer"][0] = "vox_plr_2_exert_knife_swipe_0";
    level.exert_sounds[3]["meleeswipesoundplayer"][1] = "vox_plr_2_exert_knife_swipe_1";
    level.exert_sounds[3]["meleeswipesoundplayer"][2] = "vox_plr_2_exert_knife_swipe_2";
    level.exert_sounds[3]["meleeswipesoundplayer"][3] = "vox_plr_2_exert_knife_swipe_3";
    level.exert_sounds[3]["meleeswipesoundplayer"][4] = "vox_plr_2_exert_knife_swipe_4";
    level.exert_sounds[4]["meleeswipesoundplayer"][0] = "vox_plr_3_exert_knife_swipe_0";
    level.exert_sounds[4]["meleeswipesoundplayer"][1] = "vox_plr_3_exert_knife_swipe_1";
    level.exert_sounds[4]["meleeswipesoundplayer"][2] = "vox_plr_3_exert_knife_swipe_2";
    level.exert_sounds[4]["meleeswipesoundplayer"][3] = "vox_plr_3_exert_knife_swipe_3";
    level.exert_sounds[4]["meleeswipesoundplayer"][4] = "vox_plr_3_exert_knife_swipe_4";
    level.exert_sounds[1]["playerbreathinsound"][0] = "vox_plr_0_exert_inhale_0";
    level.exert_sounds[2]["playerbreathinsound"][0] = "vox_plr_1_exert_inhale_0";
    level.exert_sounds[3]["playerbreathinsound"][0] = "vox_plr_2_exert_inhale_0";
    level.exert_sounds[4]["playerbreathinsound"][0] = "vox_plr_3_exert_inhale_0";
    level.exert_sounds[1]["playerbreathoutsound"][0] = "vox_plr_0_exert_exhale_0";
    level.exert_sounds[2]["playerbreathoutsound"][0] = "vox_plr_1_exert_exhale_0";
    level.exert_sounds[3]["playerbreathoutsound"][0] = "vox_plr_2_exert_exhale_0";
    level.exert_sounds[4]["playerbreathoutsound"][0] = "vox_plr_3_exert_exhale_0";
    level.exert_sounds[1]["playerbreathgaspsound"][0] = "vox_plr_0_exert_exhale_0";
    level.exert_sounds[2]["playerbreathgaspsound"][0] = "vox_plr_1_exert_exhale_0";
    level.exert_sounds[3]["playerbreathgaspsound"][0] = "vox_plr_2_exert_exhale_0";
    level.exert_sounds[4]["playerbreathgaspsound"][0] = "vox_plr_3_exert_exhale_0";
}

