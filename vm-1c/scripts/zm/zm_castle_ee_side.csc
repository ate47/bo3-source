#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/audio_shared;
#using scripts/codescripts/struct;

#namespace namespace_61c0be00;

// Namespace namespace_61c0be00
// Params 0, eflags: 0x2
// namespace_61c0be00<file_0>::function_2dc19561
// Checksum 0xcc1194b6, Offset: 0x308
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_zod_ee_side", &__init__, undefined, undefined);
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_8c87d8eb
// Checksum 0x9e99a542, Offset: 0x348
// Size: 0x154
function __init__() {
    level._effect["clocktower_flash"] = "dlc1/castle/fx_lightning_strike_weathervane";
    level._effect["exploding_death"] = "dlc1/zmb_weapon/fx_ee_plunger_teleport_impact";
    clientfield::register("world", "clocktower_flash", 5000, 1, "counter", &function_c7500953, 0, 0);
    clientfield::register("world", "sndUEB", 5000, 1, "int", &function_b5d300ce, 0, 0);
    clientfield::register("actor", "plunger_exploding_ai", 5000, 1, "int", &function_b3f0d569, 0, 0);
    clientfield::register("toplayer", "plunger_charged_strike", 5000, 1, "counter", &function_e43cd8, 0, 0);
}

// Namespace namespace_61c0be00
// Params 7, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_c7500953
// Checksum 0x8665134f, Offset: 0x4a8
// Size: 0x9c
function function_c7500953(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_1f1c6e96 = struct::get("ee_clocktower_lightning_rod", "targetname");
    playfx(localclientnum, level._effect["clocktower_flash"], var_1f1c6e96.origin);
}

// Namespace namespace_61c0be00
// Params 7, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_b5d300ce
// Checksum 0xcf7258a2, Offset: 0x550
// Size: 0xec
function function_b5d300ce(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playsound(0, "zmb_pyramid_energy_ball_start", (-1192, 2256, 320));
        audio::playloopat("zmb_pyramid_energy_ball_lp", (-1192, 2256, 320));
        return;
    }
    playsound(0, "zmb_pyramid_energy_ball_end", (-1192, 2256, 320));
    audio::stoploopat("zmb_pyramid_energy_ball_lp", (-1192, 2256, 320));
}

// Namespace namespace_61c0be00
// Params 7, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_b3f0d569
// Checksum 0xf12d3c0e, Offset: 0x648
// Size: 0x13c
function function_b3f0d569(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        v_pos = self gettagorigin("j_spine4");
        v_angles = self gettagangles("j_spine4");
        var_e6ddb5de = util::spawn_model(localclientnum, "tag_origin", v_pos, v_angles);
        playfxontag(localclientnum, level._effect["exploding_death"], var_e6ddb5de, "tag_origin");
        var_e6ddb5de playsound(localclientnum, "evt_ai_explode");
        wait(6);
        var_e6ddb5de delete();
    }
}

// Namespace namespace_61c0be00
// Params 7, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_e43cd8
// Checksum 0xdbeed443, Offset: 0x790
// Size: 0x9c
function function_e43cd8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playviewmodelfx(localclientnum, level._effect["plunger_charge_1p"], "tag_fx");
    playfxontag(localclientnum, level._effect["plunger_charge_3p"], self, "tag_fx");
}

