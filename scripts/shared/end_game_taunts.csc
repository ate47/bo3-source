#using scripts/shared/ai/systems/fx_character;
#using scripts/shared/abilities/gadgets/_gadget_clone_render;
#using scripts/shared/abilities/gadgets/_gadget_camo_render;
#using scripts/shared/audio_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;

#using_animtree("all_player");

#namespace namespace_3cadf69b;

// Namespace namespace_3cadf69b
// Params 0, eflags: 0x2
// Checksum 0x807e8586, Offset: 0x20d0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("end_game_taunts", &__init__, undefined, undefined);
}

// Namespace namespace_3cadf69b
// Params 0, eflags: 0x1 linked
// Checksum 0x8780258c, Offset: 0x2110
// Size: 0x3a4
function __init__() {
    animation::add_notetrack_func("taunts::hide", &hidemodel);
    animation::add_notetrack_func("taunts::show", &showmodel);
    animation::add_notetrack_func("taunts::cloneshaderon", &function_fedfdee8);
    animation::add_notetrack_func("taunts::cloneshaderoff", &function_ce5743f6);
    animation::add_notetrack_func("taunts::camoshaderon", &function_66f2d7fd);
    animation::add_notetrack_func("taunts::camoshaderoff", &function_60217209);
    animation::add_notetrack_func("taunts::spawncameraglass", &function_77868cd5);
    animation::add_notetrack_func("taunts::deletecameraglass", &function_6a310293);
    animation::add_notetrack_func("taunts::reaperbulletglass", &function_bb6820f0);
    animation::add_notetrack_func("taunts::centerbulletglass", &function_51285b7e);
    animation::add_notetrack_func("taunts::talonbulletglassleft", &function_7a6fc182);
    animation::add_notetrack_func("taunts::talonbulletglassright", &function_2b2136f1);
    animation::add_notetrack_func("taunts::fireweapon", &fireweapon);
    animation::add_notetrack_func("taunts::stopfireweapon", &stopfireweapon);
    animation::add_notetrack_func("taunts::firebeam", &function_cb36d98c);
    animation::add_notetrack_func("taunts::stopfirebeam", &function_3ec7f964);
    animation::add_notetrack_func("taunts::playwinnerteamfx", &function_8efd00a3);
    animation::add_notetrack_func("taunts::playlocalteamfx", &function_e72c395d);
    level.var_13674108 = array("gfx_p7_zm_asc_data_recorder_glass", "wpn_t7_hero_reaper_minigun_prop", "wpn_t7_loot_hero_reaper3_minigun_prop", "c_zsf_robot_grunt_body", "c_zsf_robot_grunt_head", "veh_t7_drone_raps_mp_lite", "veh_t7_drone_raps_mp_dark", "veh_t7_drone_attack_gun_litecolor", "veh_t7_drone_attack_gun_darkcolor", "wpn_t7_arm_blade_prop", "wpn_t7_hero_annihilator_prop", "wpn_t7_hero_bow_prop", "wpn_t7_hero_electro_prop_animate", "wpn_t7_hero_flamethrower_world", "wpn_t7_hero_mgl_world", "wpn_t7_hero_mgl_prop", "wpn_t7_hero_spike_prop", "wpn_t7_hero_seraph_machete_prop", "wpn_t7_loot_crowbar_world", "wpn_t7_spider_mine_world", "wpn_t7_zmb_katana_prop");
    function_be586671();
}

/#

    // Namespace namespace_3cadf69b
    // Params 0, eflags: 0x1 linked
    // Checksum 0x7542072f, Offset: 0x24c0
    // Size: 0x238
    function function_93ddf1a2() {
        while (true) {
            setdvar("taunts::deletecameraglass", "taunts::deletecameraglass");
            wait(0.05);
            taunt = getdvarstring("taunts::deletecameraglass");
            if (taunt == "taunts::deletecameraglass") {
                continue;
            }
            model = level.var_62c15215[0];
            if (isdefined(model.var_1e465ba6) && (!isdefined(model) || isdefined(model.var_7ca854a3) || model.var_1e465ba6)) {
                continue;
            }
            bodytype = getdvarint("taunts::deletecameraglass", -1);
            setdvar("taunts::deletecameraglass", -1);
            if (bodytype >= 0) {
                var_7941bf2e = function_dd121ebf(model.localclientnum, bodytype, model.origin, model.angles, model.showcaseweapon);
                model hide();
            } else {
                var_7941bf2e = model;
            }
            idleanimname = function_466e285f(model.localclientnum, model, 0);
            function_f2a89d41(model.localclientnum, var_7941bf2e, 0, idleanimname, taunt);
            if (var_7941bf2e != model) {
                var_7941bf2e delete();
                model show();
            }
        }
    }

    // Namespace namespace_3cadf69b
    // Params 0, eflags: 0x1 linked
    // Checksum 0x3007c725, Offset: 0x2700
    // Size: 0x140
    function function_d90bdba7() {
        while (true) {
            setdvar("taunts::deletecameraglass", "taunts::deletecameraglass");
            wait(0.05);
            gesture = getdvarstring("taunts::deletecameraglass");
            if (gesture == "taunts::deletecameraglass") {
                continue;
            }
            model = level.var_62c15215[0];
            if (isdefined(model.var_1e465ba6) && (!isdefined(model) || isdefined(model.var_7ca854a3) || model.var_1e465ba6)) {
                continue;
            }
            idleanimname = function_466e285f(model.localclientnum, model, 0);
            playgesture(model.localclientnum, model, 0, idleanimname, gesture, 1);
        }
    }

    // Namespace namespace_3cadf69b
    // Params 0, eflags: 0x1 linked
    // Checksum 0x7143c398, Offset: 0x2848
    // Size: 0xda
    function function_41f59618() {
        while (true) {
            wait(0.016);
            if (!getdvarint("taunts::deletecameraglass", 0)) {
                continue;
            }
            for (i = 1; i < 3; i++) {
                model = level.var_62c15215[i];
                box(model.origin, (-15, -15, 0), (15, 15, 72), model.angles[1], (0, 0, 1), 0, 1);
            }
        }
    }

    // Namespace namespace_3cadf69b
    // Params 5, eflags: 0x1 linked
    // Checksum 0x37198b44, Offset: 0x2930
    // Size: 0x212
    function function_dd121ebf(localclientnum, characterindex, origin, angles, showcaseweapon) {
        tempmodel = spawn(localclientnum, origin, "taunts::deletecameraglass");
        tempmodel.angles = angles;
        tempmodel.showcaseweapon = showcaseweapon;
        tempmodel.bodymodel = getcharacterbodymodel(characterindex, 0, currentsessionmode());
        tempmodel.var_f1a3fa15 = getcharacterhelmetmodel(characterindex, 0, currentsessionmode());
        tempmodel setmodel(tempmodel.bodymodel);
        tempmodel attach(tempmodel.var_f1a3fa15, "taunts::deletecameraglass");
        tempmodel.var_957cc42 = getcharactermoderenderoptions(currentsessionmode());
        tempmodel.var_6f30937d = getcharacterbodyrenderoptions(characterindex, 0, 0, 0, 0);
        tempmodel.var_d44a8060 = getcharacterhelmetrenderoptions(characterindex, 0, 0, 0, 0);
        tempmodel setbodyrenderoptions(tempmodel.var_957cc42, tempmodel.var_6f30937d, tempmodel.var_d44a8060, tempmodel.var_d44a8060);
        return tempmodel;
    }

#/

// Namespace namespace_3cadf69b
// Params 3, eflags: 0x1 linked
// Checksum 0x2984b9c6, Offset: 0x2b50
// Size: 0x94
function function_206ff6ca(localclientnum, charactermodel, var_c55b8047) {
    var_7b22aba9 = gettopplayerstaunt(localclientnum, var_c55b8047, 0);
    idleanimname = function_466e285f(localclientnum, charactermodel, var_c55b8047);
    function_f2a89d41(localclientnum, charactermodel, var_c55b8047, idleanimname, var_7b22aba9);
}

// Namespace namespace_3cadf69b
// Params 4, eflags: 0x1 linked
// Checksum 0xf74c229, Offset: 0x2bf0
// Size: 0x7c
function function_b5457a9d(localclientnum, charactermodel, idleanimname, var_7b22aba9) {
    function_1926278(charactermodel);
    function_6a310293(undefined);
    function_f2a89d41(localclientnum, charactermodel, 0, idleanimname, var_7b22aba9, 0, 0);
}

// Namespace namespace_3cadf69b
// Params 7, eflags: 0x1 linked
// Checksum 0x2bf2e78c, Offset: 0x2c78
// Size: 0x29c
function function_f2a89d41(localclientnum, charactermodel, var_c55b8047, idleanimname, var_7b22aba9, var_87e82ec, var_19a5a3c1) {
    if (!isdefined(var_87e82ec)) {
        var_87e82ec = 0;
    }
    if (!isdefined(var_19a5a3c1)) {
        var_19a5a3c1 = 1;
    }
    if (!isdefined(var_7b22aba9) || var_7b22aba9 == "") {
        return;
    }
    function_7222354d(localclientnum, charactermodel);
    charactermodel stopsounds();
    charactermodel endon(#"hash_7222354d");
    charactermodel util::waittill_dobj(localclientnum);
    if (!charactermodel hasanimtree()) {
        charactermodel useanimtree(#all_player);
    }
    charactermodel.var_7ca854a3 = var_7b22aba9;
    charactermodel notify(#"hash_1bd6a53a");
    charactermodel clearanim(idleanimname, var_87e82ec);
    var_85489c4 = function_ae20af86(charactermodel, var_c55b8047);
    hideweapon(charactermodel);
    charactermodel thread function_eb8cdf14(localclientnum, var_7b22aba9);
    charactermodel animation::play(var_7b22aba9, undefined, undefined, 1, var_87e82ec, 0.4);
    if (isdefined(var_19a5a3c1) && var_19a5a3c1) {
        self thread function_21c398b1(charactermodel);
        function_f7b75149(charactermodel, var_85489c4, 0.4, 0.4);
    }
    function_6030b386(charactermodel);
    charactermodel thread animation::play(idleanimname, undefined, undefined, 1, 0.4, 0);
    charactermodel.var_7ca854a3 = undefined;
    charactermodel notify(#"hash_447fd19");
    charactermodel function_cfed633a();
}

// Namespace namespace_3cadf69b
// Params 2, eflags: 0x1 linked
// Checksum 0x2bfb978a, Offset: 0x2f20
// Size: 0xbe
function function_7222354d(localclientnum, charactermodel) {
    if (isdefined(charactermodel.var_7ca854a3)) {
        charactermodel function_ce5743f6();
        charactermodel function_cfed633a();
        charactermodel function_5f04ba5e(localclientnum, charactermodel.var_7ca854a3);
        charactermodel stopsounds();
    }
    charactermodel notify(#"hash_7222354d");
    charactermodel.var_7ca854a3 = undefined;
    charactermodel.var_bd3c8c = undefined;
}

// Namespace namespace_3cadf69b
// Params 4, eflags: 0x1 linked
// Checksum 0x2ad0302c, Offset: 0x2fe8
// Size: 0x9c
function function_2794f71c(localclientnum, charactermodel, var_c55b8047, gesturetype) {
    idleanimname = function_466e285f(localclientnum, charactermodel, var_c55b8047);
    var_77c5fbfc = gettopplayersgesture(localclientnum, var_c55b8047, gesturetype);
    playgesture(localclientnum, charactermodel, var_c55b8047, idleanimname, var_77c5fbfc);
}

// Namespace namespace_3cadf69b
// Params 4, eflags: 0x1 linked
// Checksum 0xf2f74fe6, Offset: 0x3090
// Size: 0x7c
function previewgesture(localclientnum, charactermodel, idleanimname, var_77c5fbfc) {
    function_7222354d(localclientnum, charactermodel);
    function_6a310293(undefined);
    playgesture(localclientnum, charactermodel, 0, idleanimname, var_77c5fbfc, 0);
}

// Namespace namespace_3cadf69b
// Params 6, eflags: 0x1 linked
// Checksum 0x7e7752dc, Offset: 0x3118
// Size: 0x2bc
function playgesture(localclientnum, charactermodel, var_c55b8047, idleanimname, var_77c5fbfc, var_19a5a3c1) {
    if (!isdefined(var_19a5a3c1)) {
        var_19a5a3c1 = 1;
    }
    if (!isdefined(var_77c5fbfc) || var_77c5fbfc == "") {
        return;
    }
    function_1926278(charactermodel);
    charactermodel endon(#"hash_1926278");
    charactermodel util::waittill_dobj(localclientnum);
    if (!charactermodel hasanimtree()) {
        charactermodel useanimtree(#all_player);
    }
    charactermodel.var_1e465ba6 = 1;
    charactermodel notify(#"hash_584b58ed");
    charactermodel clearanim(idleanimname, 0.4);
    var_fd422097 = function_3a5977e5(charactermodel, var_c55b8047);
    var_85489c4 = function_ae20af86(charactermodel, var_c55b8047);
    if (isdefined(var_19a5a3c1) && var_19a5a3c1) {
        self thread function_31dca0d6(charactermodel);
        function_f7b75149(charactermodel, var_fd422097, 0.4, 0.4);
    }
    hideweapon(charactermodel);
    charactermodel animation::play(var_77c5fbfc, undefined, undefined, 1, 0.4, 0.4);
    if (isdefined(var_19a5a3c1) && var_19a5a3c1) {
        self thread function_21c398b1(charactermodel);
        function_f7b75149(charactermodel, var_85489c4, 0.4, 0.4);
    }
    function_6030b386(charactermodel);
    charactermodel thread animation::play(idleanimname, undefined, undefined, 1, 0.4, 0);
    charactermodel.var_1e465ba6 = 0;
    charactermodel notify(#"hash_27e17e90");
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0x1fcd374e, Offset: 0x33e0
// Size: 0x2c
function function_1926278(charactermodel) {
    charactermodel notify(#"hash_1926278");
    charactermodel.var_1e465ba6 = 0;
}

// Namespace namespace_3cadf69b
// Params 4, eflags: 0x1 linked
// Checksum 0xba3e102c, Offset: 0x3418
// Size: 0x9c
function function_f7b75149(charactermodel, var_9753d2, blendintime, blendouttime) {
    if (!isdefined(blendintime)) {
        blendintime = 0;
    }
    if (!isdefined(blendouttime)) {
        blendouttime = 0;
    }
    charactermodel endon(#"hash_7222354d");
    if (!isdefined(var_9753d2) || var_9753d2 == "") {
        return;
    }
    charactermodel animation::play(var_9753d2, undefined, undefined, 1, blendintime, blendouttime);
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0x2b49bbc0, Offset: 0x34c0
// Size: 0x6a
function function_31dca0d6(charactermodel) {
    charactermodel endon(#"hash_7fdd4e6d");
    while (true) {
        param1 = charactermodel waittill(#"_anim_notify_");
        if (param1 == "remove_from_hand") {
            hideweapon(charactermodel);
            return;
        }
    }
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0xdf6fa944, Offset: 0x3538
// Size: 0x6a
function function_21c398b1(charactermodel) {
    charactermodel endon(#"hash_de430a8c");
    while (true) {
        param1 = charactermodel waittill(#"_anim_notify_");
        if (param1 == "appear_in_hand") {
            function_6030b386(charactermodel);
            return;
        }
    }
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0x866cee6a, Offset: 0x35b0
// Size: 0x94
function hideweapon(charactermodel) {
    if (charactermodel.weapon == level.weaponnone) {
        return;
    }
    markasdirty(charactermodel);
    charactermodel attachweapon(level.weaponnone);
    charactermodel useweaponhidetags(level.weaponnone);
    charactermodel notify(#"hash_7fdd4e6d");
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0xe9f9f1eb, Offset: 0x3650
// Size: 0xfc
function function_6030b386(charactermodel) {
    if (!isdefined(charactermodel.showcaseweapon) || charactermodel.weapon != level.weaponnone) {
        return;
    }
    markasdirty(charactermodel);
    if (isdefined(charactermodel.var_7ff9e1d4)) {
        charactermodel attachweapon(charactermodel.showcaseweapon, charactermodel.var_7ff9e1d4, charactermodel.var_4b073b25);
        charactermodel useweaponhidetags(charactermodel.showcaseweapon);
    } else {
        charactermodel attachweapon(charactermodel.showcaseweapon);
    }
    charactermodel notify(#"hash_de430a8c");
}

// Namespace namespace_3cadf69b
// Params 3, eflags: 0x1 linked
// Checksum 0xfaf2f370, Offset: 0x3758
// Size: 0x10ae
function function_466e285f(localclientnum, charactermodel, var_c55b8047) {
    if (isdefined(charactermodel.weapon)) {
        weapon_group = getitemgroupforweaponname(charactermodel.weapon.rootweapon.name);
        if (weapon_group == "weapon_launcher") {
            if (charactermodel.weapon.rootweapon.name == "launcher_lockonly" || charactermodel.weapon.rootweapon.name == "launcher_multi") {
                weapon_group = "weapon_launcher_alt";
            } else if (charactermodel.weapon.rootweapon.name == "launcher_ex41") {
                weapon_group = "weapon_smg_ppsh";
            }
        } else if (weapon_group == "weapon_pistol" && charactermodel.weapon.isdualwield) {
            weapon_group = "weapon_pistol_dw";
        } else if (weapon_group == "weapon_smg") {
            if (charactermodel.weapon.rootweapon.name == "smg_ppsh") {
                weapon_group = "weapon_smg_ppsh";
            }
        } else if (weapon_group == "weapon_cqb") {
            if (charactermodel.weapon.rootweapon.name == "shotgun_olympia") {
                weapon_group = "weapon_smg_ppsh";
            }
        } else if (weapon_group == "weapon_special") {
            if (charactermodel.weapon.rootweapon.name == "special_crossbow" || charactermodel.weapon.rootweapon.name == "special_discgun") {
                weapon_group = "weapon_smg";
            } else if (charactermodel.weapon.rootweapon.name == "special_crossbow_dw") {
                weapon_group = "weapon_pistol_dw";
            } else if (charactermodel.weapon.rootweapon.name == "knife_ballistic") {
                weapon_group = "weapon_knife_ballistic";
            }
        } else if (weapon_group == "weapon_knife") {
            if (charactermodel.weapon.rootweapon.name == "melee_wrench" || charactermodel.weapon.rootweapon.name == "melee_crowbar" || charactermodel.weapon.rootweapon.name == "melee_improvise" || charactermodel.weapon.rootweapon.name == "melee_shockbaton" || charactermodel.weapon.rootweapon.name == "melee_shovel") {
                return array("pb_wrench_endgame_1stplace_idle", "pb_wrench_endgame_2ndplace_idle", "pb_wrench_endgame_3rdplace_idle")[var_c55b8047];
            } else if (charactermodel.weapon.rootweapon.name == "melee_knuckles") {
                return array("pb_brass_knuckles_endgame_1stplace_idle", "pb_brass_knuckles_endgame_2ndplace_idle", "pb_brass_knuckles_endgame_3rdplace_idle")[var_c55b8047];
            } else if (charactermodel.weapon.rootweapon.name == "melee_chainsaw" || charactermodel.weapon.rootweapon.name == "melee_boneglass" || charactermodel.weapon.rootweapon.name == "melee_crescent") {
                return array("pb_chainsaw_endgame_1stplace_idle", "pb_chainsaw_endgame_1stplace_idle", "pb_chainsaw_endgame_1stplace_idle")[var_c55b8047];
            } else if (charactermodel.weapon.rootweapon.name == "melee_boxing") {
                return array("pb_boxing_gloves_endgame_1stplace_idle", "pb_boxing_gloves_endgame_2ndplace_idle", "pb_boxing_gloves_endgame_3rdplace_idle")[var_c55b8047];
            } else if (charactermodel.weapon.rootweapon.name == "melee_sword" || charactermodel.weapon.rootweapon.name == "melee_katana") {
                return array("pb_sword_endgame_1stplace_idle", "pb_sword_endgame_2ndplace_idle", "pb_sword_endgame_3rdplace_idle")[var_c55b8047];
            } else if (charactermodel.weapon.rootweapon.name == "melee_nunchuks") {
                return array("pb_nunchucks_endgame_1stplace_idle", "pb_nunchucks_endgame_2ndplace_idle", "pb_nunchucks_endgame_3rdplace_idle")[var_c55b8047];
            } else if (charactermodel.weapon.rootweapon.name == "melee_bat" || charactermodel.weapon.rootweapon.name == "melee_fireaxe" || charactermodel.weapon.rootweapon.name == "melee_mace") {
                return array("pb_mace_endgame_1stplace_idle", "pb_mace_endgame_2ndplace_idle", "pb_mace_endgame_3rdplace_idle")[var_c55b8047];
            } else if (charactermodel.weapon.rootweapon.name == "melee_prosthetic") {
                return array("pb_prosthetic_arm_endgame_1stplace_idle", "pb_prosthetic_arm_endgame_2ndplace_idle", "pb_prosthetic_arm_endgame_3rdplace_idle")[var_c55b8047];
            }
        } else if (weapon_group == "miscweapon") {
            if (charactermodel.weapon.rootweapon.name == "blackjack_coin") {
                return array("pb_brawler_endgame_1stplace_idle", "pb_brawler_endgame_2ndplace_idle", "pb_brawler_endgame_3rdplace_idle")[var_c55b8047];
            } else if (charactermodel.weapon.rootweapon.name == "blackjack_cards") {
                return array("pb_brawler_endgame_1stplace_idle", "pb_brawler_endgame_2ndplace_idle", "pb_brawler_endgame_3rdplace_idle")[var_c55b8047];
            }
        }
        if (isdefined(associativearray("weapon_smg", array("pb_smg_endgame_1stplace_idle", "pb_smg_endgame_2ndplace_idle", "pb_smg_endgame_3rdplace_idle"), "weapon_assault", array("pb_rifle_endgame_1stplace_idle", "pb_rifle_endgame_2ndplace_idle", "pb_rifle_endgame_3rdplace_idle"), "weapon_cqb", array("pb_shotgun_endgame_1stplace_idle", "pb_shotgun_endgame_2ndplace_idle", "pb_shotgun_endgame_3rdplace_idle"), "weapon_lmg", array("pb_lmg_endgame_1stplace_idle", "pb_lmg_endgame_2ndplace_idle", "pb_lmg_endgame_3rdplace_idle"), "weapon_sniper", array("pb_sniper_endgame_1stplace_idle", "pb_sniper_endgame_2ndplace_idle", "pb_sniper_endgame_3rdplace_idle"), "weapon_pistol", array("pb_pistol_endgame_1stplace_idle", "pb_pistol_endgame_2ndplace_idle", "pb_pistol_endgame_3rdplace_idle"), "weapon_pistol_dw", array("pb_pistol_dw_endgame_1stplace_idle", "pb_pistol_dw_endgame_2ndplace_idle", "pb_pistol_dw_endgame_3rdplace_idle"), "weapon_launcher", array("pb_launcher_endgame_1stplace_idle", "pb_launcher_endgame_2ndplace_idle", "pb_launcher_endgame_3rdplace_idle"), "weapon_launcher_alt", array("pb_launcher_alt_endgame_1stplace_idle", "pb_launcher_alt_endgame_2ndplace_idle", "pb_launcher_alt_endgame_3rdplace_idle"), "weapon_knife", array("pb_knife_endgame_1stplace_idle", "pb_knife_endgame_2ndplace_idle", "pb_knife_endgame_3rdplace_idle"), "weapon_knuckles", array("pb_brass_knuckles_endgame_1stplace_idle", "pb_brass_knuckles_endgame_2ndplace_idle", "pb_brass_knuckles_endgame_3rdplace_idle"), "weapon_boxing", array("pb_boxing_gloves_endgame_1stplace_idle", "pb_boxing_gloves_endgame_2ndplace_idle", "pb_boxing_gloves_endgame_3rdplace_idle"), "weapon_wrench", array("pb_wrench_endgame_1stplace_idle", "pb_wrench_endgame_2ndplace_idle", "pb_wrench_endgame_3rdplace_idle"), "weapon_sword", array("pb_sword_endgame_1stplace_idle", "pb_sword_endgame_2ndplace_idle", "pb_sword_endgame_3rdplace_idle"), "weapon_nunchucks", array("pb_nunchucks_endgame_1stplace_idle", "pb_nunchucks_endgame_2ndplace_idle", "pb_nunchucks_endgame_3rdplace_idle"), "weapon_mace", array("pb_mace_endgame_1stplace_idle", "pb_mace_endgame_2ndplace_idle", "pb_mace_endgame_3rdplace_idle"), "brawler", array("pb_brawler_endgame_1stplace_idle", "pb_brawler_endgame_2ndplace_idle", "pb_brawler_endgame_3rdplace_idle"), "weapon_prosthetic", array("pb_prosthetic_arm_endgame_1stplace_idle", "pb_prosthetic_arm_endgame_2ndplace_idle", "pb_prosthetic_arm_endgame_3rdplace_idle"), "weapon_chainsaw", array("pb_chainsaw_endgame_1stplace_idle", "pb_chainsaw_endgame_1stplace_idle", "pb_chainsaw_endgame_1stplace_idle"), "weapon_smg_ppsh", array("pb_smg_ppsh_endgame_1stplace_idle", "pb_smg_ppsh_endgame_1stplace_idle", "pb_smg_ppsh_endgame_1stplace_idle"), "weapon_knife_ballistic", array("pb_b_knife_endgame_1stplace_idle", "pb_b_knife_endgame_2ndplace_idle", "pb_b_knife_endgame_3rdplace_idle"))[weapon_group])) {
            anim_name = associativearray("weapon_smg", array("pb_smg_endgame_1stplace_idle", "pb_smg_endgame_2ndplace_idle", "pb_smg_endgame_3rdplace_idle"), "weapon_assault", array("pb_rifle_endgame_1stplace_idle", "pb_rifle_endgame_2ndplace_idle", "pb_rifle_endgame_3rdplace_idle"), "weapon_cqb", array("pb_shotgun_endgame_1stplace_idle", "pb_shotgun_endgame_2ndplace_idle", "pb_shotgun_endgame_3rdplace_idle"), "weapon_lmg", array("pb_lmg_endgame_1stplace_idle", "pb_lmg_endgame_2ndplace_idle", "pb_lmg_endgame_3rdplace_idle"), "weapon_sniper", array("pb_sniper_endgame_1stplace_idle", "pb_sniper_endgame_2ndplace_idle", "pb_sniper_endgame_3rdplace_idle"), "weapon_pistol", array("pb_pistol_endgame_1stplace_idle", "pb_pistol_endgame_2ndplace_idle", "pb_pistol_endgame_3rdplace_idle"), "weapon_pistol_dw", array("pb_pistol_dw_endgame_1stplace_idle", "pb_pistol_dw_endgame_2ndplace_idle", "pb_pistol_dw_endgame_3rdplace_idle"), "weapon_launcher", array("pb_launcher_endgame_1stplace_idle", "pb_launcher_endgame_2ndplace_idle", "pb_launcher_endgame_3rdplace_idle"), "weapon_launcher_alt", array("pb_launcher_alt_endgame_1stplace_idle", "pb_launcher_alt_endgame_2ndplace_idle", "pb_launcher_alt_endgame_3rdplace_idle"), "weapon_knife", array("pb_knife_endgame_1stplace_idle", "pb_knife_endgame_2ndplace_idle", "pb_knife_endgame_3rdplace_idle"), "weapon_knuckles", array("pb_brass_knuckles_endgame_1stplace_idle", "pb_brass_knuckles_endgame_2ndplace_idle", "pb_brass_knuckles_endgame_3rdplace_idle"), "weapon_boxing", array("pb_boxing_gloves_endgame_1stplace_idle", "pb_boxing_gloves_endgame_2ndplace_idle", "pb_boxing_gloves_endgame_3rdplace_idle"), "weapon_wrench", array("pb_wrench_endgame_1stplace_idle", "pb_wrench_endgame_2ndplace_idle", "pb_wrench_endgame_3rdplace_idle"), "weapon_sword", array("pb_sword_endgame_1stplace_idle", "pb_sword_endgame_2ndplace_idle", "pb_sword_endgame_3rdplace_idle"), "weapon_nunchucks", array("pb_nunchucks_endgame_1stplace_idle", "pb_nunchucks_endgame_2ndplace_idle", "pb_nunchucks_endgame_3rdplace_idle"), "weapon_mace", array("pb_mace_endgame_1stplace_idle", "pb_mace_endgame_2ndplace_idle", "pb_mace_endgame_3rdplace_idle"), "brawler", array("pb_brawler_endgame_1stplace_idle", "pb_brawler_endgame_2ndplace_idle", "pb_brawler_endgame_3rdplace_idle"), "weapon_prosthetic", array("pb_prosthetic_arm_endgame_1stplace_idle", "pb_prosthetic_arm_endgame_2ndplace_idle", "pb_prosthetic_arm_endgame_3rdplace_idle"), "weapon_chainsaw", array("pb_chainsaw_endgame_1stplace_idle", "pb_chainsaw_endgame_1stplace_idle", "pb_chainsaw_endgame_1stplace_idle"), "weapon_smg_ppsh", array("pb_smg_ppsh_endgame_1stplace_idle", "pb_smg_ppsh_endgame_1stplace_idle", "pb_smg_ppsh_endgame_1stplace_idle"), "weapon_knife_ballistic", array("pb_b_knife_endgame_1stplace_idle", "pb_b_knife_endgame_2ndplace_idle", "pb_b_knife_endgame_3rdplace_idle"))[weapon_group][var_c55b8047];
        }
    }
    if (!isdefined(anim_name)) {
        anim_name = array("pb_brawler_endgame_1stplace_idle", "pb_brawler_endgame_2ndplace_idle", "pb_brawler_endgame_3rdplace_idle")[var_c55b8047];
    }
    return anim_name;
}

// Namespace namespace_3cadf69b
// Params 2, eflags: 0x1 linked
// Checksum 0x2d91fad9, Offset: 0x4810
// Size: 0x4ae
function function_3a5977e5(charactermodel, var_c55b8047) {
    weapon_group = getweapongroup(charactermodel);
    switch (weapon_group) {
    case 51:
        return array("pb_smg_endgame_1stplace_out", "pb_smg_endgame_2ndplace_out", "pb_smg_endgame_3rdplace_out")[var_c55b8047];
    case 149:
        return array("pb_rifle_endgame_1stplace_out", "pb_rifle_endgame_2ndplace_out", "pb_rifle_endgame_3rdplace_out")[var_c55b8047];
    case 53:
        return array("pb_shotgun_endgame_1stplace_out", "pb_shotgun_endgame_2ndplace_out", "pb_shotgun_endgame_3rdplace_out")[var_c55b8047];
    case 142:
        return array("pb_lmg_endgame_1stplace_out", "pb_lmg_endgame_2ndplace_out", "pb_lmg_endgame_3rdplace_out")[var_c55b8047];
    case 138:
        return array("pb_sniper_endgame_1stplace_out", "pb_sniper_endgame_2ndplace_out", "pb_sniper_endgame_3rdplace_out")[var_c55b8047];
    case 49:
        return array("pb_pistol_endgame_1stplace_out", "pb_pistol_endgame_2ndplace_out", "pb_pistol_endgame_3rdplace_out")[var_c55b8047];
    case 50:
        return array("pb_pistol_dw_endgame_1stplace_out", "pb_pistol_dw_endgame_2ndplace_out", "pb_pistol_dw_endgame_3rdplace_out")[var_c55b8047];
    case 43:
        return array("pb_launcher_endgame_1stplace_out", "pb_launcher_endgame_2ndplace_out", "pb_launcher_endgame_3rdplace_out")[var_c55b8047];
    case 46:
        return array("pb_launcher_alt_endgame_1stplace_out", "pb_launcher_alt_endgame_2ndplace_out", "pb_launcher_alt_endgame_3rdplace_out")[var_c55b8047];
    case 61:
        return array("pb_knife_endgame_1stplace_out", "pb_knife_endgame_2ndplace_out", "pb_knife_endgame_3rdplace_out")[var_c55b8047];
    case 119:
        return array("pb_brass_knuckles_endgame_1stplace_out", "pb_brass_knuckles_endgame_2ndplace_out", "pb_brass_knuckles_endgame_3rdplace_out")[var_c55b8047];
    case 118:
        return array("pb_boxing_gloves_endgame_1stplace_out", "pb_boxing_gloves_endgame_2ndplace_out", "pb_boxing_gloves_endgame_3rdplace_out")[var_c55b8047];
    case 117:
        return array("pb_wrench_endgame_1stplace_out", "pb_wrench_endgame_2ndplace_out", "pb_wrench_endgame_3rdplace_out")[var_c55b8047];
    case 116:
        return array("pb_sword_endgame_1stplace_out", "pb_sword_endgame_2ndplace_out", "pb_sword_endgame_3rdplace_out")[var_c55b8047];
    case 115:
        return array("pb_nunchucks_endgame_1stplace_out", "pb_nunchucks_endgame_2ndplace_out", "pb_nunchucks_endgame_3rdplace_out")[var_c55b8047];
    case 114:
        return array("pb_mace_endgame_1stplace_out", "pb_mace_endgame_2ndplace_out", "pb_mace_endgame_3rdplace_out")[var_c55b8047];
    case 112:
        return array("pb_prosthetic_arm_endgame_1stplace_out", "pb_prosthetic_arm_endgame_2ndplace_out", "pb_prosthetic_arm_endgame_3rdplace_out")[var_c55b8047];
    case 111:
        return array("pb_chainsaw_endgame_1stplace_idle_out", "pb_chainsaw_endgame_1stplace_idle_out", "pb_chainsaw_endgame_1stplace_idle_out")[var_c55b8047];
    case 48:
        return array("pb_smg_ppsh_endgame_1stplace_out", "pb_smg_ppsh_endgame_1stplace_out", "pb_smg_ppsh_endgame_1stplace_out")[var_c55b8047];
    case 60:
        return array("pb_b_knife_endgame_1stplace_out", "pb_b_knife_endgame_1stplace_out", "pb_b_knife_endgame_1stplace_out")[var_c55b8047];
    }
    return "";
}

// Namespace namespace_3cadf69b
// Params 2, eflags: 0x1 linked
// Checksum 0xc84431fe, Offset: 0x4cc8
// Size: 0x4ae
function function_ae20af86(charactermodel, var_c55b8047) {
    weapon_group = getweapongroup(charactermodel);
    switch (weapon_group) {
    case 51:
        return array("pb_smg_endgame_1stplace_in", "pb_smg_endgame_2ndplace_in", "pb_smg_endgame_3rdplace_in")[var_c55b8047];
    case 149:
        return array("pb_rifle_endgame_1stplace_in", "pb_rifle_endgame_2ndplace_in", "pb_rifle_endgame_3rdplace_in")[var_c55b8047];
    case 53:
        return array("pb_shotgun_endgame_1stplace_in", "pb_shotgun_endgame_2ndplace_in", "pb_shotgun_endgame_3rdplace_in")[var_c55b8047];
    case 142:
        return array("pb_lmg_endgame_1stplace_in", "pb_lmg_endgame_2ndplace_in", "pb_lmg_endgame_3rdplace_in")[var_c55b8047];
    case 138:
        return array("pb_sniper_endgame_1stplace_in", "pb_sniper_endgame_2ndplace_in", "pb_sniper_endgame_3rdplace_in")[var_c55b8047];
    case 49:
        return array("pb_pistol_endgame_1stplace_in", "pb_pistol_endgame_2ndplace_in", "pb_pistol_endgame_3rdplace_in")[var_c55b8047];
    case 50:
        return array("pb_pistol_dw_endgame_1stplace_in", "pb_pistol_dw_endgame_2ndplace_in", "pb_pistol_dw_endgame_3rdplace_in")[var_c55b8047];
    case 43:
        return array("pb_launcher_endgame_1stplace_in", "pb_launcher_endgame_2ndplace_in", "pb_launcher_endgame_3rdplace_in")[var_c55b8047];
    case 46:
        return array("pb_launcher_alt_endgame_1stplace_in", "pb_launcher_alt_endgame_2ndplace_in", "pb_launcher_alt_endgame_3rdplace_in")[var_c55b8047];
    case 61:
        return array("pb_knife_endgame_1stplace_in", "pb_knife_endgame_2ndplace_in", "pb_knife_endgame_3rdplace_in")[var_c55b8047];
    case 119:
        return array("pb_brass_knuckles_endgame_1stplace_in", "pb_brass_knuckles_endgame_2ndplace_in", "pb_brass_knuckles_endgame_3rdplace_in")[var_c55b8047];
    case 118:
        return array("pb_boxing_gloves_endgame_1stplace_in", "pb_boxing_gloves_endgame_2ndplace_in", "pb_boxing_gloves_endgame_3rdplace_in")[var_c55b8047];
    case 117:
        return array("pb_wrench_endgame_1stplace_in", "pb_wrench_endgame_2ndplace_in", "pb_wrench_endgame_3rdplace_in")[var_c55b8047];
    case 116:
        return array("pb_sword_endgame_1stplace_in", "pb_sword_endgame_2ndplace_in", "pb_sword_endgame_3rdplace_in")[var_c55b8047];
    case 115:
        return array("pb_nunchucks_endgame_1stplace_in", "pb_nunchucks_endgame_2ndplace_in", "pb_nunchucks_endgame_3rdplace_in")[var_c55b8047];
    case 114:
        return array("pb_mace_endgame_1stplace_in", "pb_mace_endgame_2ndplace_in", "pb_mace_endgame_3rdplace_in")[var_c55b8047];
    case 112:
        return array("pb_prosthetic_arm_endgame_1stplace_in", "pb_prosthetic_arm_endgame_2ndplace_in", "pb_prosthetic_arm_endgame_3rdplace_in")[var_c55b8047];
    case 111:
        return array("pb_chainsaw_endgame_1stplace_idle_in", "pb_chainsaw_endgame_1stplace_idle_in", "pb_chainsaw_endgame_1stplace_idle_in")[var_c55b8047];
    case 48:
        return array("pb_smg_ppsh_endgame_1stplace_in", "pb_smg_ppsh_endgame_1stplace_in", "pb_smg_ppsh_endgame_1stplace_in")[var_c55b8047];
    case 60:
        return array("pb_b_knife_endgame_1stplace_in", "pb_b_knife_endgame_1stplace_in", "pb_b_knife_endgame_1stplace_in")[var_c55b8047];
    }
    return "";
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0x80f9ed8, Offset: 0x5180
// Size: 0x69c
function getweapongroup(charactermodel) {
    if (!isdefined(charactermodel.weapon)) {
        return "";
    }
    weapon = charactermodel.weapon;
    if (weapon == level.weaponnone && isdefined(charactermodel.showcaseweapon)) {
        weapon = charactermodel.showcaseweapon;
    }
    weapon_group = getitemgroupforweaponname(weapon.rootweapon.name);
    if (weapon_group == "weapon_launcher") {
        if (charactermodel.weapon.rootweapon.name == "launcher_lockonly" || charactermodel.weapon.rootweapon.name == "launcher_multi") {
            weapon_group = "weapon_launcher_alt";
        } else if (charactermodel.weapon.rootweapon.name == "launcher_ex41") {
            weapon_group = "weapon_smg_ppsh";
        }
    } else if (weapon_group == "weapon_pistol" && weapon.isdualwield) {
        weapon_group = "weapon_pistol_dw";
    } else if (weapon_group == "weapon_smg") {
        if (charactermodel.weapon.rootweapon.name == "smg_ppsh") {
            weapon_group = "weapon_smg_ppsh";
        }
    } else if (weapon_group == "weapon_cqb") {
        if (charactermodel.weapon.rootweapon.name == "shotgun_olympia") {
            weapon_group = "weapon_smg_ppsh";
        }
    } else if (weapon_group == "weapon_special") {
        if (charactermodel.weapon.rootweapon.name == "special_crossbow" || charactermodel.weapon.rootweapon.name == "special_discgun") {
            weapon_group = "weapon_smg";
        } else if (charactermodel.weapon.rootweapon.name == "special_crossbow_dw") {
            weapon_group = "weapon_pistol_dw";
        } else if (charactermodel.weapon.rootweapon.name == "knife_ballistic") {
            weapon_group = "weapon_knife_ballistic";
        }
    } else if (weapon_group == "weapon_knife") {
        if (charactermodel.weapon.rootweapon.name == "melee_wrench" || charactermodel.weapon.rootweapon.name == "melee_crowbar" || charactermodel.weapon.rootweapon.name == "melee_improvise" || charactermodel.weapon.rootweapon.name == "melee_shockbaton" || charactermodel.weapon.rootweapon.name == "melee_shovel") {
            weapon_group = "weapon_wrench";
        } else if (charactermodel.weapon.rootweapon.name == "melee_knuckles") {
            weapon_group = "weapon_knuckles";
        } else if (charactermodel.weapon.rootweapon.name == "melee_chainsaw" || charactermodel.weapon.rootweapon.name == "melee_boneglass" || charactermodel.weapon.rootweapon.name == "melee_crescent") {
            weapon_group = "weapon_chainsaw";
        } else if (charactermodel.weapon.rootweapon.name == "melee_boxing") {
            weapon_group = "weapon_boxing";
        } else if (charactermodel.weapon.rootweapon.name == "melee_sword" || charactermodel.weapon.rootweapon.name == "melee_katana") {
            weapon_group = "weapon_sword";
        } else if (charactermodel.weapon.rootweapon.name == "melee_nunchuks") {
            weapon_group = "weapon_nunchucks";
        } else if (charactermodel.weapon.rootweapon.name == "melee_bat" || charactermodel.weapon.rootweapon.name == "melee_fireaxe" || charactermodel.weapon.rootweapon.name == "melee_mace") {
            weapon_group = "weapon_mace";
        } else if (charactermodel.weapon.rootweapon.name == "melee_prosthetic") {
            weapon_group = "weapon_prosthetic";
        }
    }
    return weapon_group;
}

// Namespace namespace_3cadf69b
// Params 0, eflags: 0x1 linked
// Checksum 0xc0b1a3ab, Offset: 0x5828
// Size: 0x8a
function function_6eace780() {
    foreach (model in level.var_13674108) {
        forcestreamxmodel(model);
    }
}

// Namespace namespace_3cadf69b
// Params 0, eflags: 0x1 linked
// Checksum 0x3b56f213, Offset: 0x58c0
// Size: 0x8a
function function_be586671() {
    foreach (model in level.var_13674108) {
        stopforcestreamingxmodel(model);
    }
}

// Namespace namespace_3cadf69b
// Params 2, eflags: 0x1 linked
// Checksum 0x756dbdd1, Offset: 0x5958
// Size: 0x280
function function_eb8cdf14(localclientnum, var_7b22aba9) {
    var_bff02df7 = struct::get_script_bundle("scene", var_7b22aba9);
    if (!isdefined(var_bff02df7)) {
        return false;
    }
    switch (var_7b22aba9) {
    case 273:
        self thread function_f39abb1e(localclientnum);
        break;
    case 271:
        self thread function_302396b4(localclientnum, "gi_unit_victim");
        break;
    case 275:
        self thread function_3d9257f3(localclientnum, "rap_1");
        self thread function_3d9257f3(localclientnum, "rap_2");
        break;
    case 274:
        self thread function_67866405(localclientnum, "reaper_l");
        self thread function_67866405(localclientnum, "reaper_r");
        break;
    case 276:
        if (getdvarstring("mapname") == "core_frontend") {
            self sethighdetail(1, 0);
            self function_c51bf7(self.localclientnum, 1);
        } else {
            self thread gadget_camo_render::forceon(localclientnum);
        }
        self thread function_302396b4(localclientnum, "gi_unit_victim");
        break;
    case 272:
        self thread function_d435beb6(localclientnum, "talon_bro_1", 0.65);
        self thread function_d435beb6(localclientnum, "talon_bro_2", 0.65);
        break;
    }
    self thread scene::play(var_7b22aba9);
    return true;
}

// Namespace namespace_3cadf69b
// Params 2, eflags: 0x1 linked
// Checksum 0x46049441, Offset: 0x5be0
// Size: 0xbc
function function_5f04ba5e(localclientnum, var_7b22aba9) {
    var_bff02df7 = struct::get_script_bundle("scene", var_7b22aba9);
    if (!isdefined(var_bff02df7)) {
        return;
    }
    switch (var_7b22aba9) {
    case 276:
        if (getdvarstring("mapname") == "core_frontend") {
            self sethighdetail(1, 0);
        }
        break;
    }
    self thread scene::stop(var_7b22aba9);
}

// Namespace namespace_3cadf69b
// Params 3, eflags: 0x0
// Checksum 0xaf4b0597, Offset: 0x5ca8
// Size: 0x74
function function_6c468939(var_7b22aba9, func, state) {
    var_bff02df7 = struct::get_script_bundle("scene", var_7b22aba9);
    if (!isdefined(var_bff02df7)) {
        return;
    }
    scene::add_scene_func(var_7b22aba9, func, state);
}

// Namespace namespace_3cadf69b
// Params 0, eflags: 0x1 linked
// Checksum 0x1e3c7e0, Offset: 0x5d28
// Size: 0xc2
function function_cfed633a() {
    if (isdefined(self.var_bd3c8c)) {
        foreach (model in self.var_bd3c8c) {
            if (isdefined(model)) {
                model stopsounds();
                model delete();
            }
        }
        self.var_bd3c8c = undefined;
    }
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0x326600be, Offset: 0x5df8
// Size: 0x24
function hidemodel(param) {
    self hide();
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0x86b4a77f, Offset: 0x5e28
// Size: 0x24
function showmodel(param) {
    self show();
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0x2f187be, Offset: 0x5e58
// Size: 0xb4
function function_77868cd5(param) {
    if (isdefined(level.var_cb631c4)) {
        function_6a310293(param);
    }
    level.var_cb631c4 = spawn(self.localclientnum, (0, 0, 0), "script_model");
    level.var_cb631c4 setmodel("gfx_p7_zm_asc_data_recorder_glass");
    level.var_cb631c4 setscale(2);
    level.var_cb631c4 thread function_1ac3684f();
}

// Namespace namespace_3cadf69b
// Params 0, eflags: 0x1 linked
// Checksum 0x7fcd81e2, Offset: 0x5f18
// Size: 0xc0
function function_1ac3684f() {
    self endon(#"entityshutdown");
    while (true) {
        camangles = getcamanglesbylocalclientnum(self.localclientnum);
        campos = getcamposbylocalclientnum(self.localclientnum);
        fwd = anglestoforward(camangles);
        self.origin = campos + fwd * 60;
        self.angles = camangles + (0, 180, 0);
        wait(0.016);
    }
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0x77db1c2d, Offset: 0x5fe0
// Size: 0x3e
function function_6a310293(param) {
    if (!isdefined(level.var_cb631c4)) {
        return;
    }
    level.var_cb631c4 delete();
    level.var_cb631c4 = undefined;
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0x2086f689, Offset: 0x6028
// Size: 0xe0
function function_bb6820f0(param) {
    waittillframeend();
    minigun = getweapon("hero_minigun");
    for (i = 30; i > -30; i -= 7) {
        if (!isdefined(self)) {
            return;
        }
        self function_6c7d3666(self.localclientnum, minigun, randomfloatrange(2, 12), i);
        self playsound(0, "pfx_magic_bullet_glass");
        wait(minigun.firetime);
    }
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0x52a7eb9d, Offset: 0x6110
// Size: 0x8c
function function_51285b7e(weaponname) {
    waittillframeend();
    weapon = getweapon(weaponname);
    if (weapon == level.weaponnone) {
        return;
    }
    self function_6c7d3666(self.localclientnum, weapon, 4, -2);
    self playsound(0, "pfx_magic_bullet_glass");
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0xb89878cb, Offset: 0x61a8
// Size: 0x2c
function function_7a6fc182(param) {
    self function_5f844ccd(-28, -10);
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0x2abc79ee, Offset: 0x61e0
// Size: 0x2c
function function_2b2136f1(param) {
    self function_5f844ccd(10, 28);
}

// Namespace namespace_3cadf69b
// Params 2, eflags: 0x1 linked
// Checksum 0x415873a1, Offset: 0x6218
// Size: 0xee
function function_5f844ccd(yawmin, yawmax) {
    waittillframeend();
    minigun = getweapon("hero_minigun");
    for (i = 0; i < 15; i++) {
        if (!isdefined(self)) {
            return;
        }
        self function_6c7d3666(self.localclientnum, minigun, randomfloatrange(4, 16), randomfloatrange(yawmin, yawmax));
        self playsound(0, "pfx_magic_bullet_glass");
        wait(minigun.firetime);
    }
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0xbd49f12f, Offset: 0x6310
// Size: 0x134
function function_fedfdee8(param) {
    if (getdvarstring("mapname") == "core_frontend") {
        self sethighdetail(1, 0);
    }
    localplayerteam = getlocalplayerteam(self.localclientnum);
    var_6ca16392 = gettopplayersteam(self.localclientnum, 0);
    friendly = localplayerteam === var_6ca16392;
    if (friendly) {
        self duplicate_render::update_dr_flag(self.localclientnum, "clone_ally_on", 1);
    } else {
        self duplicate_render::update_dr_flag(self.localclientnum, "clone_enemy_on", 1);
    }
    self thread namespace_1e7514ce::function_9bad5680(self.localclientnum);
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0x564291c7, Offset: 0x6450
// Size: 0x5c
function function_ce5743f6(param) {
    self duplicate_render::update_dr_flag(self.localclientnum, "clone_ally_on", 0);
    self duplicate_render::update_dr_flag(self.localclientnum, "clone_enemy_on", 0);
}

// Namespace namespace_3cadf69b
// Params 2, eflags: 0x1 linked
// Checksum 0x36e8f8c2, Offset: 0x64b8
// Size: 0x13c
function function_c51bf7(localclientnum, var_7f56e8cf) {
    flags_changed = self duplicate_render::set_dr_flag("gadget_camo_friend", 0);
    flags_changed = flags_changed && self duplicate_render::set_dr_flag("gadget_camo_flicker", 0);
    flags_changed = flags_changed && self duplicate_render::set_dr_flag("gadget_camo_break", 0);
    flags_changed = flags_changed && self duplicate_render::set_dr_flag("gadget_camo_reveal", 0);
    flags_changed = flags_changed && self duplicate_render::set_dr_flag("gadget_camo_on", 0);
    if (flags_changed) {
        self duplicate_render::update_dr_filters();
    }
    if (var_7f56e8cf) {
        self thread gadget_camo_render::forceon(localclientnum);
        return;
    }
    self thread gadget_camo_render::doreveal(self.localclientnum, 0);
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0xeb61ccf2, Offset: 0x6600
// Size: 0x7c
function function_66f2d7fd(param) {
    if (getdvarstring("mapname") == "core_frontend") {
        self function_c51bf7(self.localclientnum, 1);
        return;
    }
    self thread gadget_camo_render::doreveal(self.localclientnum, 1);
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0x702fdfce, Offset: 0x6688
// Size: 0x6c
function function_60217209(param) {
    if (getdvarstring("mapname") == "core_frontend") {
        self function_c51bf7(self.localclientnum, 0);
        return;
    }
    self thread gadget_camo_render::doreveal(self.localclientnum, 0);
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0x89d96e8, Offset: 0x6700
// Size: 0x90
function fireweapon(weaponname) {
    if (!isdefined(weaponname)) {
        return;
    }
    self endon(#"stopfireweapon");
    weapon = getweapon(weaponname);
    waittillframeend();
    while (1 && isdefined(self)) {
        self magicbullet(weapon, (0, 0, 0), (0, 0, 0));
        wait(weapon.firetime);
    }
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0x7e3b1268, Offset: 0x6798
// Size: 0x1a
function stopfireweapon(param) {
    self notify(#"stopfireweapon");
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0x4e6681c8, Offset: 0x67c0
// Size: 0x4c
function function_cb36d98c(beam) {
    if (isdefined(self.beamfx)) {
        return;
    }
    self.beamfx = beamlaunch(self.localclientnum, self, "tag_flash", undefined, "none", beam);
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0xb0a7aa00, Offset: 0x6818
// Size: 0x46
function function_3ec7f964(param) {
    if (!isdefined(self.beamfx)) {
        return;
    }
    beamkill(self.localclientnum, self.beamfx);
    self.beamfx = undefined;
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0xdd69d537, Offset: 0x6868
// Size: 0xbc
function function_8efd00a3(fxname) {
    waittillframeend();
    var_6ca16392 = gettopplayersteam(self.localclientnum, 0);
    if (!isdefined(var_6ca16392)) {
        var_6ca16392 = getlocalplayerteam(self.localclientnum);
    }
    fxhandle = playfxontag(self.localclientnum, fxname, self, "tag_origin");
    if (isdefined(fxhandle)) {
        setfxteam(self.localclientnum, fxhandle, var_6ca16392);
    }
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0x98dd951a, Offset: 0x6930
// Size: 0x8c
function function_e72c395d(fxname) {
    waittillframeend();
    localplayerteam = getlocalplayerteam(self.localclientnum);
    fxhandle = playfxontag(self.localclientnum, fxname, self, "tag_origin");
    if (isdefined(fxhandle)) {
        setfxteam(self.localclientnum, fxhandle, localplayerteam);
    }
}

// Namespace namespace_3cadf69b
// Params 4, eflags: 0x1 linked
// Checksum 0xbc5cd021, Offset: 0x69c8
// Size: 0xac
function function_6c7d3666(localclientnum, weapon, var_8983d19e, yawangle) {
    campos = getcamposbylocalclientnum(localclientnum);
    camangles = getcamanglesbylocalclientnum(localclientnum);
    var_4ebc5205 = camangles + (var_8983d19e, yawangle, 0);
    self magicbullet(weapon, campos, var_4ebc5205);
}

// Namespace namespace_3cadf69b
// Params 3, eflags: 0x0
// Checksum 0xe1888072, Offset: 0x6a80
// Size: 0xf4
function function_507afdb5(localclientnum, projectilemodel, var_86add0c8) {
    launchorigin = self gettagorigin("tag_flash");
    if (!isdefined(launchorigin)) {
        return;
    }
    var_80709230 = self gettagangles("tag_flash");
    launchdir = anglestoforward(var_80709230);
    createdynentandlaunch(localclientnum, projectilemodel, launchorigin, (0, 0, 0), launchorigin, launchdir * getdvarfloat("launchspeed", 3.5), var_86add0c8);
}

// Namespace namespace_3cadf69b
// Params 1, eflags: 0x1 linked
// Checksum 0x3c938b09, Offset: 0x6b80
// Size: 0x1b2
function function_f39abb1e(localclientnum) {
    model = spawn(localclientnum, self.origin, "script_model");
    model.angles = self.angles;
    model.targetname = "scythe_prop";
    model sethighdetail(1);
    var_c5b8b9c = "wpn_t7_hero_reaper_minigun_prop";
    if (isdefined(self.bodymodel)) {
        if (strstartswith(self.bodymodel, "c_t7_mp_reaper_mpc_body3")) {
            var_c5b8b9c = "wpn_t7_loot_hero_reaper3_minigun_prop";
        }
    }
    model setmodel(var_c5b8b9c);
    model setbodyrenderoptions(self.var_957cc42, self.var_6f30937d, self.var_d44a8060, self.var_d44a8060);
    self hidepart(localclientnum, "tag_minigun_flaps");
    if (!isdefined(self.var_bd3c8c)) {
        self.var_bd3c8c = [];
    } else if (!isarray(self.var_bd3c8c)) {
        self.var_bd3c8c = array(self.var_bd3c8c);
    }
    self.var_bd3c8c[self.var_bd3c8c.size] = model;
}

// Namespace namespace_3cadf69b
// Params 2, eflags: 0x1 linked
// Checksum 0x9774556b, Offset: 0x6d40
// Size: 0x13a
function function_67866405(localclientnum, targetname) {
    clone = self function_9d823940(localclientnum, targetname, self.origin, self.angles, self.bodymodel, self.var_f1a3fa15, self.var_957cc42, self.var_6f30937d, self.var_d44a8060);
    clone setscale(0);
    wait(0.016);
    clone hide();
    clone setscale(1);
    if (!isdefined(self.var_bd3c8c)) {
        self.var_bd3c8c = [];
    } else if (!isarray(self.var_bd3c8c)) {
        self.var_bd3c8c = array(self.var_bd3c8c);
    }
    self.var_bd3c8c[self.var_bd3c8c.size] = clone;
}

// Namespace namespace_3cadf69b
// Params 5, eflags: 0x0
// Checksum 0xcb6cfad, Offset: 0x6e88
// Size: 0x12a
function function_802dd60f(localclientnum, targetname, origin, angles, var_c55b8047) {
    bodymodel = gettopplayersbodymodel(localclientnum, var_c55b8047);
    var_f1a3fa15 = gettopplayershelmetmodel(localclientnum, var_c55b8047);
    var_957cc42 = getcharactermoderenderoptions(currentsessionmode());
    var_6f30937d = gettopplayersbodyrenderoptions(localclientnum, var_c55b8047);
    var_d44a8060 = gettopplayershelmetrenderoptions(localclientnum, var_c55b8047);
    return function_9d823940(localclientnum, targetname, origin, angles, bodymodel, var_f1a3fa15, var_957cc42, var_6f30937d, var_d44a8060);
}

// Namespace namespace_3cadf69b
// Params 9, eflags: 0x1 linked
// Checksum 0x271fd9d1, Offset: 0x6fc0
// Size: 0x158
function function_9d823940(localclientnum, targetname, origin, angles, bodymodel, var_f1a3fa15, var_957cc42, var_6f30937d, var_d44a8060) {
    model = spawn(localclientnum, origin, "script_model");
    model.angles = angles;
    model.targetname = targetname;
    model sethighdetail(1);
    model setmodel(bodymodel);
    model attach(var_f1a3fa15, "");
    model setbodyrenderoptions(var_957cc42, var_6f30937d, var_d44a8060, var_d44a8060);
    model hide();
    model useanimtree(#all_player);
    return model;
}

// Namespace namespace_3cadf69b
// Params 2, eflags: 0x1 linked
// Checksum 0xaeafa648, Offset: 0x7120
// Size: 0x142
function function_302396b4(localclientnum, targetname) {
    model = spawn(localclientnum, self.origin, "script_model");
    model.angles = self.angles;
    model.targetname = targetname;
    model sethighdetail(1);
    model setmodel("c_zsf_robot_grunt_body");
    model attach("c_zsf_robot_grunt_head", "");
    if (!isdefined(self.var_bd3c8c)) {
        self.var_bd3c8c = [];
    } else if (!isarray(self.var_bd3c8c)) {
        self.var_bd3c8c = array(self.var_bd3c8c);
    }
    self.var_bd3c8c[self.var_bd3c8c.size] = model;
}

// Namespace namespace_3cadf69b
// Params 2, eflags: 0x1 linked
// Checksum 0xbc048767, Offset: 0x7270
// Size: 0x1ba
function function_3d9257f3(localclientnum, targetname) {
    model = spawn(localclientnum, self.origin, "script_model");
    model.angles = self.angles;
    model.targetname = targetname;
    localplayerteam = getlocalplayerteam(self.localclientnum);
    var_6ca16392 = gettopplayersteam(localclientnum, 0);
    if (!isdefined(var_6ca16392) || localplayerteam == var_6ca16392) {
        model setmodel("veh_t7_drone_raps_mp_lite");
        var_2df466a8 = localplayerteam;
    } else {
        model setmodel("veh_t7_drone_raps_mp_dark");
        var_2df466a8 = var_6ca16392;
    }
    model util::waittill_dobj(localclientnum);
    if (!isdefined(self.var_bd3c8c)) {
        self.var_bd3c8c = [];
    } else if (!isarray(self.var_bd3c8c)) {
        self.var_bd3c8c = array(self.var_bd3c8c);
    }
    self.var_bd3c8c[self.var_bd3c8c.size] = model;
}

// Namespace namespace_3cadf69b
// Params 3, eflags: 0x1 linked
// Checksum 0x7664f7d, Offset: 0x7438
// Size: 0x242
function function_d435beb6(localclientnum, targetname, scale) {
    if (!isdefined(scale)) {
        scale = 1;
    }
    model = spawn(localclientnum, self.origin, "script_model");
    model.angles = self.angles;
    model.targetname = targetname;
    localplayerteam = getlocalplayerteam(self.localclientnum);
    var_6ca16392 = gettopplayersteam(localclientnum, 0);
    if (!isdefined(var_6ca16392) || localplayerteam == var_6ca16392) {
        model setmodel("veh_t7_drone_attack_gun_litecolor");
        var_2df466a8 = localplayerteam;
    } else {
        model setmodel("veh_t7_drone_attack_gun_darkcolor");
        var_2df466a8 = var_6ca16392;
    }
    model setscale(scale);
    model util::waittill_dobj(localclientnum);
    fxhandle = playfxontag(localclientnum, "player/fx_loot_taunt_outrider_talon_lights", model, "tag_body");
    setfxteam(localclientnum, fxhandle, var_2df466a8);
    if (!isdefined(self.var_bd3c8c)) {
        self.var_bd3c8c = [];
    } else if (!isarray(self.var_bd3c8c)) {
        self.var_bd3c8c = array(self.var_bd3c8c);
    }
    self.var_bd3c8c[self.var_bd3c8c.size] = model;
}

