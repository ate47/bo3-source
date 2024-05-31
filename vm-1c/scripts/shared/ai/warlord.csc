#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/ai_shared;

#namespace warlord;

// Namespace warlord
// Params 0, eflags: 0x2
// namespace_2cbc0af0<file_0>::function_2dc19561
// Checksum 0xbac6971b, Offset: 0x3c0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("warlord", &__init__, undefined, undefined);
}

// Namespace warlord
// Params 0, eflags: 0x2
// namespace_2cbc0af0<file_0>::function_f7046c76
// Checksum 0x6ab4e328, Offset: 0x400
// Size: 0xe2
function autoexec precache() {
    level._effect["fx_elec_warlord_damage_1"] = "electric/fx_elec_warlord_damage_1";
    level._effect["fx_elec_warlord_damage_2"] = "electric/fx_elec_warlord_damage_2";
    level._effect["fx_elec_warlord_lower_damage_1"] = "electric/fx_elec_warlord_lower_damage_1";
    level._effect["fx_elec_warlord_lower_damage_2"] = "electric/fx_elec_warlord_lower_damage_2";
    level._effect["fx_exp_warlord_death"] = "explosions/fx_exp_warlord_death";
    level._effect["fx_exhaust_jetpack_warlord_juke"] = "vehicle/fx_exhaust_jetpack_warlord_juke";
    level._effect["fx_light_eye_glow_warlord"] = "light/fx_light_eye_glow_warlord";
    level._effect["fx_light_body_glow_warlord"] = "light/fx_light_body_glow_warlord";
}

// Namespace warlord
// Params 0, eflags: 0x1 linked
// namespace_2cbc0af0<file_0>::function_8c87d8eb
// Checksum 0x64a4deb8, Offset: 0x4f0
// Size: 0x13c
function __init__() {
    if (ai::shouldregisterclientfieldforarchetype("warlord")) {
        clientfield::register("actor", "warlord_type", 1, 2, "int", &namespace_e95b29c8::function_6765fb9c, 0, 0);
        clientfield::register("actor", "warlord_damage_state", 1, 2, "int", &namespace_e95b29c8::function_695d7dee, 0, 0);
        clientfield::register("actor", "warlord_thruster_direction", 1, 3, "int", &namespace_e95b29c8::function_a4d15a01, 0, 0);
        clientfield::register("actor", "warlord_lights_state", 1, 1, "int", &namespace_e95b29c8::function_5620f99, 0, 0);
    }
}

#namespace namespace_e95b29c8;

// Namespace namespace_e95b29c8
// Params 7, eflags: 0x1 linked
// namespace_e95b29c8<file_0>::function_695d7dee
// Checksum 0xe0444911, Offset: 0x638
// Size: 0x22e
function function_695d7dee(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    if (isdefined(entity.var_4154355f)) {
        stopfx(localclientnum, entity.var_4154355f);
        entity.var_4154355f = undefined;
    }
    if (isdefined(entity.var_c57c11b8)) {
        stopfx(localclientnum, entity.var_c57c11b8);
        entity.var_c57c11b8 = undefined;
    }
    switch (newvalue) {
    case 0:
        break;
    case 2:
        entity.var_c57c11b8 = playfxontag(localclientnum, level._effect["fx_elec_warlord_damage_2"], entity, "j_spine4");
        playfxontag(localclientnum, level._effect["fx_elec_warlord_lower_damage_2"], entity, "j_mainroot");
    case 1:
        entity.var_4154355f = playfxontag(localclientnum, level._effect["fx_elec_warlord_damage_1"], entity, "j_spine4");
        playfxontag(localclientnum, level._effect["fx_elec_warlord_lower_damage_1"], entity, "j_mainroot");
        break;
    case 3:
        playfxontag(localclientnum, level._effect["fx_exp_warlord_death"], entity, "j_spine4");
        break;
    }
}

// Namespace namespace_e95b29c8
// Params 7, eflags: 0x1 linked
// namespace_e95b29c8<file_0>::function_6765fb9c
// Checksum 0x6af2e411, Offset: 0x870
// Size: 0x60
function function_6765fb9c(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    entity.warlordtype = newvalue;
}

// Namespace namespace_e95b29c8
// Params 7, eflags: 0x1 linked
// namespace_e95b29c8<file_0>::function_a4d15a01
// Checksum 0xf139463b, Offset: 0x8d8
// Size: 0x25c
function function_a4d15a01(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    if (isdefined(entity.var_a8d008e0)) {
        assert(isarray(entity.var_a8d008e0));
        for (index = 0; index < entity.var_a8d008e0.size; index++) {
            stopfx(localclientnum, entity.var_a8d008e0[index]);
        }
    }
    entity.var_a8d008e0 = [];
    tags = [];
    switch (newvalue) {
    case 0:
        break;
    case 1:
        tags = array("tag_jets_left_front", "tag_jets_right_front");
        break;
    case 2:
        tags = array("tag_jets_left_back", "tag_jets_right_back");
        break;
    case 3:
        tags = array("tag_jets_left_side");
        break;
    case 4:
        tags = array("tag_jets_right_side");
        break;
    }
    for (index = 0; index < tags.size; index++) {
        entity.var_a8d008e0[entity.var_a8d008e0.size] = playfxontag(localclientnum, level._effect["fx_exhaust_jetpack_warlord_juke"], entity, tags[index]);
    }
}

// Namespace namespace_e95b29c8
// Params 7, eflags: 0x1 linked
// namespace_e95b29c8<file_0>::function_5620f99
// Checksum 0xbf029161, Offset: 0xb40
// Size: 0xc4
function function_5620f99(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    if (newvalue == 1) {
        playfxontag(localclientnum, level._effect["fx_light_eye_glow_warlord"], entity, "tag_eye");
        playfxontag(localclientnum, level._effect["fx_light_body_glow_warlord"], entity, "j_spine4");
    }
}

