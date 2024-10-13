#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/beam_shared;
#using scripts/shared/audio_shared;
#using scripts/codescripts/struct;

#namespace zm_stalingrad_audio;

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x2
// Checksum 0x717361b0, Offset: 0x2a8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_stalingrad_audio", &__init__, undefined, undefined);
}

// Namespace zm_stalingrad_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x2fcd0a30, Offset: 0x2e8
// Size: 0x102
function __init__() {
    clientfield::register("scriptmover", "ee_anthem_pa", 12000, 1, "int", &function_a50e0efb, 0, 0);
    clientfield::register("scriptmover", "ee_ballerina", 12000, 2, "int", &function_41eaf8b8, 0, 0);
    level._effect["ee_anthem_pa_appear"] = "dlc3/stalingrad/fx_main_anomoly_emp_pulse";
    level._effect["ee_anthem_pa_explode"] = "dlc3/stalingrad/fx_main_impact_success";
    level._effect["ee_ballerina_appear"] = "dlc3/stalingrad/fx_main_impact_success";
    level._effect["ee_ballerina_disappear"] = "dlc3/stalingrad/fx_main_impact_success";
}

// Namespace zm_stalingrad_audio
// Params 7, eflags: 0x1 linked
// Checksum 0x95348088, Offset: 0x3f8
// Size: 0x134
function function_a50e0efb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfx(localclientnum, level._effect["ee_anthem_pa_appear"], self.origin);
        audio::playloopat("zmb_nikolai_mus_pa_anthem_lp", self.origin);
        wait randomfloatrange(0.05, 0.35);
        playsound(0, "zmb_nikolai_mus_pa_anthem_start", self.origin);
        return;
    }
    playfx(localclientnum, level._effect["ee_anthem_pa_explode"], self.origin);
    audio::stoploopat("zmb_nikolai_mus_pa_anthem_lp", self.origin);
}

// Namespace zm_stalingrad_audio
// Params 7, eflags: 0x1 linked
// Checksum 0x6c8710d3, Offset: 0x538
// Size: 0x10c
function function_41eaf8b8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (newval == 1) {
            playfx(localclientnum, level._effect["ee_ballerina_appear"], self.origin);
            playsound(0, "zmb_sam_egg_appear", self.origin);
        }
        return;
    }
    playfx(localclientnum, level._effect["ee_ballerina_disappear"], self.origin);
    playsound(0, "zmb_sam_egg_disappear", self.origin);
}

