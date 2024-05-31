#using scripts/shared/postfx_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/fx_shared;
#using scripts/zm/_zm;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_27f8b154;

// Namespace namespace_27f8b154
// Params 0, eflags: 0x2
// namespace_27f8b154<file_0>::function_2dc19561
// Checksum 0x7716e3f, Offset: 0x480
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_ai_spiders", &__init__, &__main__, undefined);
}

// Namespace namespace_27f8b154
// Params 0, eflags: 0x1 linked
// namespace_27f8b154<file_0>::function_8c87d8eb
// Checksum 0x3efc832b, Offset: 0x4c8
// Size: 0x164
function __init__() {
    level._effect["spider_round"] = "dlc2/island/fx_spider_round_tell";
    level._effect["spider_web_grenade_stuck"] = "dlc2/island/fx_web_grenade_tell";
    level._effect["spider_web_bgb_tear"] = "dlc2/island/fx_web_bgb_tearing";
    level._effect["spider_web_bgb_tear_complete"] = "dlc2/island/fx_web_bgb_reveal";
    level._effect["spider_web_perk_machine_tear"] = "dlc2/island/fx_web_perk_machine_tearing";
    level._effect["spider_web_perk_machine_tear_complete"] = "dlc2/island/fx_web_perk_machine_reveal";
    level._effect["spider_web_doorbuy_tear"] = "dlc2/island/fx_web_barrier_tearing";
    level._effect["spider_web_doorbuy_tear_complete"] = "dlc2/island/fx_web_barrier_reveal";
    level._effect["spider_web_tear_explosive"] = "dlc2/island/fx_web_impact_rocket";
    register_clientfields();
    vehicle::add_vehicletype_callback("spider", &function_7c1ef59b);
    visionset_mgr::register_visionset_info("zm_isl_parasite_spider_visionset", 9000, 16, undefined, "zm_isl_parasite_spider");
}

// Namespace namespace_27f8b154
// Params 0, eflags: 0x1 linked
// namespace_27f8b154<file_0>::function_5b6b9132
// Checksum 0x99ec1590, Offset: 0x638
// Size: 0x4
function __main__() {
    
}

// Namespace namespace_27f8b154
// Params 0, eflags: 0x1 linked
// namespace_27f8b154<file_0>::function_4ece4a2f
// Checksum 0xb64d9ac7, Offset: 0x648
// Size: 0xdc
function register_clientfields() {
    clientfield::register("toplayer", "spider_round_fx", 9000, 1, "counter", &function_cf314378, 0, 0);
    clientfield::register("toplayer", "spider_round_ring_fx", 9000, 1, "counter", &function_ea4a561d, 0, 0);
    clientfield::register("toplayer", "spider_end_of_round_reset", 9000, 1, "counter", &function_5a0b8305, 0, 0);
}

// Namespace namespace_27f8b154
// Params 1, eflags: 0x1 linked
// namespace_27f8b154<file_0>::function_7c1ef59b
// Checksum 0xa6a88e9, Offset: 0x730
// Size: 0x2c
function function_7c1ef59b(localclientnum) {
    self.str_tag_tesla_death_fx = "J_SpineUpper";
    self.str_tag_tesla_shock_eyes_fx = "J_SpineUpper";
}

// Namespace namespace_27f8b154
// Params 7, eflags: 0x1 linked
// namespace_27f8b154<file_0>::function_cf314378
// Checksum 0x8568a821, Offset: 0x768
// Size: 0x124
function function_cf314378(var_6575414d, var_d5fa7963, var_3a04fa7e, var_3a8c4f80, var_406ad39b, str_field, var_f9aa8824) {
    self endon(#"disconnect");
    setworldfogactivebank(var_6575414d, 8);
    if (isspectating(var_6575414d)) {
        return;
    }
    self.var_d5173f21 = playfxoncamera(var_6575414d, level._effect["spider_round"]);
    playsound(0, "zmb_spider_round_webup", (0, 0, 0));
    wait(0.016);
    self thread postfx::playpostfxbundle("pstfx_parasite_spider");
    wait(3.5);
    deletefx(var_6575414d, self.var_d5173f21);
}

// Namespace namespace_27f8b154
// Params 7, eflags: 0x1 linked
// namespace_27f8b154<file_0>::function_5a0b8305
// Checksum 0xc9a29df5, Offset: 0x898
// Size: 0x64
function function_5a0b8305(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        setworldfogactivebank(localclientnum, 1);
    }
}

// Namespace namespace_27f8b154
// Params 7, eflags: 0x1 linked
// namespace_27f8b154<file_0>::function_ea4a561d
// Checksum 0xccf6013f, Offset: 0x908
// Size: 0x9c
function function_ea4a561d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"disconnect");
    if (isspectating(localclientnum)) {
        return;
    }
    self thread postfx::playpostfxbundle("pstfx_ring_loop");
    wait(1.5);
    self postfx::exitpostfxbundle();
}

