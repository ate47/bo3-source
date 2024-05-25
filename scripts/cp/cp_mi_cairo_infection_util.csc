#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/clientfield_shared;
#using scripts/cp/_load;
#using scripts/codescripts/struct;

#namespace namespace_36cbf523;

// Namespace namespace_36cbf523
// Params 0, eflags: 0x2
// Checksum 0x925456a1, Offset: 0xab0
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("infection_util", &__init__, undefined, undefined);
}

// Namespace namespace_36cbf523
// Params 0, eflags: 0x0
// Checksum 0x5befa148, Offset: 0xae8
// Size: 0x22
function __init__() {
    init_fx();
    init_clientfields();
}

// Namespace namespace_36cbf523
// Params 0, eflags: 0x0
// Checksum 0x928c531c, Offset: 0xb18
// Size: 0x1cb
function init_fx() {
    level._effect["ai_dni_rez_in_arm_left"] = "player/fx_ai_dni_rez_in_arm_left_dirty";
    level._effect["ai_dni_rez_in_arm_right"] = "player/fx_ai_dni_rez_in_arm_right_dirty";
    level._effect["ai_dni_rez_in_head"] = "player/fx_ai_dni_rez_in_head_dirty";
    level._effect["ai_dni_rez_in_hip_left"] = "player/fx_ai_dni_rez_in_hip_left_dirty";
    level._effect["ai_dni_rez_in_hip_right"] = "player/fx_ai_dni_rez_in_hip_right_dirty";
    level._effect["ai_dni_rez_in_leg_left"] = "player/fx_ai_dni_rez_in_leg_left_dirty";
    level._effect["ai_dni_rez_in_leg_right"] = "player/fx_ai_dni_rez_in_leg_right_dirty";
    level._effect["ai_dni_rez_in_torso"] = "player/fx_ai_dni_rez_in_torso_dirty";
    level._effect["ai_dni_rez_in_waist"] = "player/fx_ai_dni_rez_in_waist_dirty";
    level._effect["ai_dni_rez_out_arm_left"] = "player/fx_ai_dni_rez_out_arm_left_dirty";
    level._effect["ai_dni_rez_out_arm_right"] = "player/fx_ai_dni_rez_out_arm_right_dirty";
    level._effect["ai_dni_rez_out_head"] = "player/fx_ai_dni_rez_out_head_dirty";
    level._effect["ai_dni_rez_out_hip_left"] = "player/fx_ai_dni_rez_out_hip_left_dirty";
    level._effect["ai_dni_rez_out_hip_right"] = "player/fx_ai_dni_rez_out_hip_right_dirty";
    level._effect["ai_dni_rez_out_leg_left"] = "player/fx_ai_dni_rez_out_leg_left_dirty";
    level._effect["ai_dni_rez_out_leg_right"] = "player/fx_ai_dni_rez_out_leg_right_dirty";
    level._effect["ai_dni_rez_out_torso"] = "player/fx_ai_dni_rez_out_torso_dirty";
    level._effect["ai_dni_rez_out_waist"] = "player/fx_ai_dni_rez_out_waist_dirty";
    level._effect["ai_dni_rez_out_wolf_dirty"] = "player/fx_ai_dni_rez_out_wolf_dirty";
}

// Namespace namespace_36cbf523
// Params 0, eflags: 0x0
// Checksum 0x730b1f86, Offset: 0xcf0
// Size: 0x3
function init_clientfields() {
    // Can't decompile export namespace_36cbf523::init_clientfields Unknown operator 0x76
}

// Namespace namespace_36cbf523
// Params 7, eflags: 0x0
// Checksum 0xe58a220c, Offset: 0x1070
// Size: 0x3a
function function_e5419867(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_36cbf523::function_e5419867 Unknown operator 0x5d
}

// Namespace namespace_36cbf523
// Params 7, eflags: 0x0
// Checksum 0xcacbb5df, Offset: 0x10e0
// Size: 0x3a
function function_f5a73f1e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_36cbf523::function_f5a73f1e Unknown operator 0x5d
}

// Namespace namespace_36cbf523
// Params 7, eflags: 0x0
// Checksum 0xa49965f, Offset: 0x1188
// Size: 0x3a
function function_a3b6a74a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_36cbf523::function_a3b6a74a Unknown operator 0x5d
}

// Namespace namespace_36cbf523
// Params 7, eflags: 0x0
// Checksum 0x81db8d03, Offset: 0x1228
// Size: 0x52
function function_b3f0d569(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_36cbf523::function_b3f0d569 Unknown operator 0x5d
}

// Namespace namespace_36cbf523
// Params 7, eflags: 0x0
// Checksum 0x28f0988f, Offset: 0x1340
// Size: 0x3a
function function_39ba15ad(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_36cbf523::function_39ba15ad Unknown operator 0xfa
}

// Namespace namespace_36cbf523
// Params 2, eflags: 0x0
// Checksum 0x3cf2279f, Offset: 0x1498
// Size: 0x19
function function_cdbbde70(var_42189297, ground_ent) {
    // Can't decompile export namespace_36cbf523::function_cdbbde70 Unknown operator 0xd4
}

// Namespace namespace_36cbf523
// Params 7, eflags: 0x0
// Checksum 0xc187a251, Offset: 0x1540
// Size: 0x3a
function function_206d5db6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_36cbf523::function_206d5db6 Unknown operator 0x5d
}

// Namespace namespace_36cbf523
// Params 7, eflags: 0x0
// Checksum 0x5dc5f871, Offset: 0x15f0
// Size: 0x3a
function function_baff6dde(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_36cbf523::function_baff6dde Unknown operator 0x5d
}

// Namespace namespace_36cbf523
// Params 3, eflags: 0x0
// Checksum 0xf09ec68f, Offset: 0x16f8
// Size: 0x29
function function_be968491(localclientnum, str_type, str_fx) {
    // Can't decompile export namespace_36cbf523::function_be968491 Unknown operator 0x18
}

// Namespace namespace_36cbf523
// Params 3, eflags: 0x0
// Checksum 0x9d7608bf, Offset: 0x17c0
// Size: 0x2a
function function_400e6e82(localclientnum, str_type, var_91599cfb) {
    // Can't decompile export namespace_36cbf523::function_400e6e82 Unknown operator 0x5d
}

// Namespace namespace_36cbf523
// Params 5, eflags: 0x0
// Checksum 0x73ed7b45, Offset: 0x1898
// Size: 0x32
function function_88a10e85(localclientnum, str_type, str_fx, str_tag, var_cffd17f8) {
    // Can't decompile export namespace_36cbf523::function_88a10e85 Unknown operator 0x5d
}

// Namespace namespace_36cbf523
// Params 7, eflags: 0x0
// Checksum 0x163c43ee, Offset: 0x1950
// Size: 0x42
function function_ea0e7704(localclientnum, str_type, str_fx, var_cffd17f8, v_pos, v_forward, v_up) {
    // Can't decompile export namespace_36cbf523::function_ea0e7704 Unknown operator 0x5d
}

// Namespace namespace_36cbf523
// Params 7, eflags: 0x0
// Checksum 0x5320064c, Offset: 0x1a48
// Size: 0x3a
function function_aebc5072(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_36cbf523::function_aebc5072 Unknown operator 0x5d
}

// Namespace namespace_36cbf523
// Params 7, eflags: 0x0
// Checksum 0xc6d7c446, Offset: 0x1af8
// Size: 0x43
function function_7bd51e31(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_36cbf523::function_7bd51e31 Unknown operator 0x5d
}

// Namespace namespace_36cbf523
// Params 7, eflags: 0x0
// Checksum 0x5b900fe2, Offset: 0x1b68
// Size: 0x3a
function function_82164883(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_36cbf523::function_82164883 Unknown operator 0x5d
}

// Namespace namespace_36cbf523
// Params 7, eflags: 0x0
// Checksum 0x973e353e, Offset: 0x1bd0
// Size: 0x3a
function function_baae4949(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_36cbf523::function_baae4949 Unknown operator 0x5d
}

// Namespace namespace_36cbf523
// Params 7, eflags: 0x0
// Checksum 0x47b8712e, Offset: 0x1c38
// Size: 0x3b
function function_f532bd65(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_36cbf523::function_f532bd65 Unknown operator 0x5d
}

// Namespace namespace_36cbf523
// Params 7, eflags: 0x0
// Checksum 0xaa89ed9b, Offset: 0x1cc0
// Size: 0x41
function function_207ed741(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_36cbf523::function_207ed741 Unknown operator 0x76
}

// Namespace namespace_36cbf523
// Params 7, eflags: 0x0
// Checksum 0x5e756993, Offset: 0x1ee0
// Size: 0x41
function function_5ae9b898(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    // Can't decompile export namespace_36cbf523::function_5ae9b898 Unknown operator 0x76
}

