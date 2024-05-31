#using scripts/zm/zm_tomb_vo;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_ee_main;
#using scripts/zm/zm_tomb_chamber;
#using scripts/zm/_zm_sidequests;
#using scripts/shared/util_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_85688477;

// Namespace namespace_85688477
// Params 0, eflags: 0x1 linked
// namespace_85688477<file_0>::function_c35e6aab
// Checksum 0x3560a554, Offset: 0x2a0
// Size: 0x54
function init() {
    namespace_6e97c459::function_5a90ed82("little_girl_lost", "step_7", &init_stage, &function_7747c56, &function_cc3f3f6a);
}

// Namespace namespace_85688477
// Params 0, eflags: 0x1 linked
// namespace_85688477<file_0>::function_bf888e64
// Checksum 0x9db3fba0, Offset: 0x300
// Size: 0x20
function init_stage() {
    level.var_ca733eed = "step_7";
    level.var_cad4b3aa = 0;
}

// Namespace namespace_85688477
// Params 0, eflags: 0x1 linked
// namespace_85688477<file_0>::function_7747c56
// Checksum 0xaaa60187, Offset: 0x328
// Size: 0x94
function function_7747c56() {
    /#
        iprintln(level.var_ca733eed + "ee_sam_portal_active");
    #/
    level thread function_1efeda5d();
    level flag::wait_till("ee_souls_absorbed");
    util::wait_network_frame();
    namespace_6e97c459::function_2f3ced1f("little_girl_lost", level.var_ca733eed);
}

// Namespace namespace_85688477
// Params 1, eflags: 0x1 linked
// namespace_85688477<file_0>::function_cc3f3f6a
// Checksum 0xbd8c55d0, Offset: 0x3c8
// Size: 0x1a
function function_cc3f3f6a(success) {
    level notify(#"hash_7f00c03c");
}

// Namespace namespace_85688477
// Params 8, eflags: 0x1 linked
// namespace_85688477<file_0>::function_116238af
// Checksum 0xdc7252bc, Offset: 0x3f0
// Size: 0x1a4
function function_116238af(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime) {
    if (isdefined(attacker) && isplayer(attacker) && namespace_435339fc::function_34b281af(self.origin)) {
        level.var_cad4b3aa++;
        if (level.var_cad4b3aa == 1) {
            level thread namespace_69d27510::function_13f8b19b("vox_sam_generic_encourage_3");
        } else if (level.var_cad4b3aa == floor(33.3333)) {
            level thread namespace_69d27510::function_13f8b19b("vox_sam_generic_encourage_4");
        } else if (level.var_cad4b3aa == floor(66.6667)) {
            level thread namespace_69d27510::function_13f8b19b("vox_sam_generic_encourage_5");
        } else if (level.var_cad4b3aa == 100) {
            level thread namespace_69d27510::function_13f8b19b("vox_sam_generic_encourage_0");
            level flag::set("ee_souls_absorbed");
        }
        self clientfield::set("ee_zombie_soul_portal", 1);
    }
}

// Namespace namespace_85688477
// Params 0, eflags: 0x1 linked
// namespace_85688477<file_0>::function_1efeda5d
// Checksum 0x29a31f6, Offset: 0x5a0
// Size: 0x178
function function_1efeda5d() {
    /#
        if (isdefined(level.var_89b873d7) && level.var_89b873d7) {
            level flag::set("ee_sam_portal_active");
            level clientfield::set("ee_sam_portal_active", 1);
            return;
        }
    #/
    while (!level flag::get("ee_souls_absorbed")) {
        if (namespace_69d27510::function_f8ba2e08() && !level flag::get("ee_sam_portal_active")) {
            level flag::set("ee_sam_portal_active");
            level clientfield::set("ee_sam_portal", 1);
        } else if (!namespace_69d27510::function_f8ba2e08() && level flag::get("ee_sam_portal_active")) {
            level flag::clear("ee_sam_portal_active");
            level clientfield::set("ee_sam_portal", 0);
        }
        wait(0.5);
    }
}

