#using scripts/codescripts/struct;
#using scripts/core/_multi_extracam;
#using scripts/cp/_training_sim;
#using scripts/shared/_character_customization;
#using scripts/shared/_weapon_customization_icon;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/custom_class;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/lui_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace safehouse;

// Namespace safehouse
// Params 0, eflags: 0x2
// Checksum 0xb6d19fe2, Offset: 0xec8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("safehouse", &__init__, undefined, undefined);
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0xdba8d5d5, Offset: 0xf08
// Size: 0x41c
function __init__() {
    clientfield::register("world", "nextMap", 1, 6, "int", &function_9887cf30, 0, 1);
    clientfield::register("world", "near_gun_rack", 1, 1, "int", &near_gun_rack, 0, 0);
    clientfield::register("world", "toggle_console_1", 1, 1, "int", &toggle_console_1, 0, 0);
    clientfield::register("world", "toggle_console_2", 1, 1, "int", &toggle_console_2, 0, 0);
    clientfield::register("world", "toggle_console_3", 1, 1, "int", &toggle_console_3, 0, 0);
    clientfield::register("world", "toggle_console_4", 1, 1, "int", &toggle_console_4, 0, 0);
    clientfield::register("scriptmover", "player_clone", 1, 1, "int", &player_clone, 0, 0);
    clientfield::register("scriptmover", "training_sim_extracam", 1, getminbitcountfornum(4), "int", &training_sim_extracam, 0, 0);
    clientfield::register("scriptmover", "gun_rack_init", 1, getminbitcountfornum(1), "int", &gun_rack_init, 0, 0);
    clientfield::register("toplayer", "sh_exit_duck_active", 1, 1, "int", &function_2b8cf6a0, 0, 0);
    callback::on_localclient_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    customclass::init();
    level.on_collectibles_change = &on_collectibles_change;
    function_2f834a09(0);
    var_cb97644f = createuimodel(getglobaluimodel(), "nextMap");
    var_aed90fc4 = getmapatindex(0);
    setuimodelvalue(var_cb97644f, var_aed90fc4);
    if (!isdefined(level.var_51cfdd5)) {
        level.var_51cfdd5 = [];
    }
    if (!isdefined(level.rooms)) {
        level.rooms = [];
    }
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x3910fe00, Offset: 0x1330
// Size: 0x74c
function setupclientmenus(localclientnum) {
    lui::initmenudata(localclientnum);
    lui::createcustomcameramenu("BrowseCollectibles", localclientnum, &function_336d330b, 0, undefined, &function_74e49d6f);
    lui::createcustomextracamxcamdata("BrowseCollectibles", localclientnum, 1, &function_a2e25254);
    lui::addmenuexploders("BrowseCollectibles", localclientnum, array("weapon_kick", "lights_paintshop"));
    lui::createcustomcameramenu("InspectingCollectibles", localclientnum, &function_5f0902f7, 0, undefined, &function_74e49d6f);
    lui::createcustomextracamxcamdata("InspectingCollectibles", localclientnum, 1, &function_d9350b98);
    lui::addmenuexploders("InspectingCollectibles", localclientnum, array("weapon_kick", "lights_paintshop"));
    lui::createcameramenu("ChooseOutfit", localclientnum, "personalizeHero_camera", undefined, "ui_cam_character_customization", "cam_preview");
    lui::addmenuexploders("ChooseOutfit", localclientnum, array("char_custom_bg", "char_customization"));
    lui::linktocustomcharacter("ChooseOutfit", localclientnum, "character_customization");
    lui::createcustomcameramenu("PersonalizeCharacter", localclientnum, &personalize_characters_watch, 0, &function_fa299ef0, &function_9236c726);
    lui::addmenuexploders("PersonalizeCharacter", localclientnum, array("char_custom_bg", "char_customization"));
    lui::linktocustomcharacter("PersonalizeCharacter", localclientnum, "character_customization");
    lui::createcameramenu("ChooseHead", localclientnum, "personalizeHero_camera", "ui_cam_character_customization", "cam_helmet", undefined, &open_choose_head_menu, &close_choose_head_menu);
    lui::addmenuexploders("ChooseHead", localclientnum, array("char_custom_bg", "char_customization"));
    lui::linktocustomcharacter("ChooseHead", localclientnum, "character_customization");
    lui::createcameramenu("chooseClass", localclientnum, "spawn_char_cac_choose", "ui_cam_cac_specialist", "cam_specialist", undefined, &open_choose_class, &close_choose_class);
    lui::linktocustomcharacter("chooseClass", localclientnum, "character_customization");
    lui::addmenuexploders("chooseClass", localclientnum, array("char_custom_bg", "char_customization", "weapon_kick", "lights_paintshop"));
    lui::createcameramenu("chooseClass_TrainingSim", localclientnum, "spawn_char_cac_choose", "ui_cam_cac_specialist", "cam_specialist", undefined, &open_choose_class, &close_choose_class);
    lui::linktocustomcharacter("chooseClass_TrainingSim", localclientnum, "character_customization");
    lui::addmenuexploders("chooseClass_TrainingSim", localclientnum, array("char_custom_bg", "char_customization", "weapon_kick", "lights_paintshop"));
    lui::createcameramenu("CybercoreUpgrade", localclientnum, "spawn_char_cac_choose", "ui_cam_cac_perk", "cam_cac", undefined, &function_85a15cfc, &function_62845c2);
    lui::linktocustomcharacter("CybercoreUpgrade", localclientnum, "character_customization");
    lui::createcustomcameramenu("Paintshop", localclientnum, undefined, 0, undefined, &function_59622cb6);
    lui::createcustomcameramenu("Gunsmith", localclientnum, undefined, 0, undefined, &function_66ec7bf3);
    lui::createcustomcameramenu("CombatRecordWeapons", localclientnum, undefined, 0, undefined, &function_30eb9463);
    lui::addmenuexploders("CombatRecordWeapons", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("CombatRecordEquipment", localclientnum, undefined, 0, undefined, &function_30eb9463);
    lui::addmenuexploders("CombatRecordEquipment", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("CombatRecordCybercore", localclientnum, undefined, 0, undefined, &function_30eb9463);
    lui::addmenuexploders("CombatRecordCybercore", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("CombatRecordCollectibles", localclientnum, undefined, 0, undefined, &function_30eb9463);
    lui::addmenuexploders("CombatRecordCollectibles", localclientnum, array("char_customization", "char_custom_bg"));
}

// Namespace safehouse
// Params 3, eflags: 0x0
// Checksum 0x75b29448, Offset: 0x1a88
// Size: 0xde
function function_1bbcb5e2(localclientnum, var_1e2ce4de, script_noteworthy) {
    items = struct::get_array("player_bunk_" + var_1e2ce4de);
    if (isdefined(items)) {
        foreach (item in items) {
            if (item.script_noteworthy === script_noteworthy) {
                return item;
            }
        }
    }
    return undefined;
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0xd38615a3, Offset: 0x1b70
// Size: 0x34
function function_2f834a09(var_404ab86) {
    stopforcingstreamer();
    forcestreamweapons(0);
}

// Namespace safehouse
// Params 7, eflags: 0x0
// Checksum 0xee17a1e5, Offset: 0x1bb0
// Size: 0xc4
function function_9887cf30(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_cb97644f = createuimodel(getglobaluimodel(), "nextMap");
    var_aed90fc4 = getmapatindex(newval);
    setupfieldopskitloadouts(var_aed90fc4);
    setuimodelvalue(var_cb97644f, var_aed90fc4);
}

// Namespace safehouse
// Params 7, eflags: 0x0
// Checksum 0x8b23b396, Offset: 0x1c80
// Size: 0x382
function gun_rack_init(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    a_weapons = [];
    a_weapons["link_wpn_t7_shotgun_spartan_world01_jnt"] = "wpn_t7_shotgun_spartan_world";
    a_weapons["link_wpn_t7_shotgun_spartan_world02_jnt"] = "wpn_t7_shotgun_spartan_world";
    a_weapons["link_wpn_t7_m229_world01_jnt"] = "wpn_t7_shotgun_spartan_world";
    a_weapons["link_wpn_t7_m229_world02_jnt"] = "wpn_t7_shotgun_spartan_world";
    a_weapons["link_wpn_t7_lmg_dingo_world01_jnt"] = "wpn_t7_lmg_dingo_world";
    a_weapons["link_wpn_t7_lmg_dingo_world02_jnt"] = "wpn_t7_lmg_dingo_world";
    a_weapons["link_wpn_t7_arak_world_cp01_jnt"] = "wpn_t7_arak_world_cp";
    a_weapons["link_wpn_t7_arak_world_cp02_jnt"] = "wpn_t7_arak_world_cp";
    a_weapons["link_wpn_t7_base_rifle_world01_jnt"] = "wpn_t7_ar_isr27_world";
    a_weapons["link_wpn_t7_base_rifle_world02_jnt"] = "wpn_t7_ar_isr27_world";
    a_weapons["link_wpn_t7_xr2_world01_jnt"] = "wpn_t7_xr2_world";
    a_weapons["link_wpn_t7_xr2_world02_jnt"] = "wpn_t7_xr2_world";
    a_weapons["link_wpn_t7_grenade_emp_world_jnt"] = "wpn_t7_grenade_emp_world";
    a_weapons["link_wpn_t7_grenade_flashbang_world_jnt"] = "wpn_t7_grenade_flashbang_world";
    a_weapons["link_wpn_t7_grenade_semtex_jnt"] = "wpn_t7_grenade_semtex_world";
    a_weapons["link_wpn_t7_grenade_frag_jnt"] = "wpn_t7_grenade_frag_world";
    a_weapons["link_wpn_t7_grenade_sensor_world_jnt"] = "wpn_t7_grenade_sensor_world";
    a_weapons["link_wpn_t7_grenade_supply_world01_jnt"] = "wpn_t7_grenade_supply_world";
    a_weapons["link_wpn_t7_grenade_supply_world02_jnt"] = "wpn_t7_grenade_supply_world";
    a_weapons["link_wpn_t7_pistol_triton01_jnt"] = "wpn_t7_pistol_triton_world";
    a_weapons["link_wpn_t7_pistol_triton02_jnt"] = "wpn_t7_pistol_triton_world";
    a_weapons["link_wpn_t7_mr6_world_cac01_jnt"] = "wpn_t7_mr6_world";
    a_weapons["link_wpn_t7_mr6_world_cac02_jnt"] = "wpn_t7_mr6_world";
    a_weapons["link_wpn_t7_base_pistol_01_jnt"] = "wpn_t7_pistol_triton_world";
    a_weapons["link_wpn_t7_base_pistol_02_jnt"] = "wpn_t7_pistol_triton_world";
    foreach (str_tag, str_weapon in a_weapons) {
        e_weapon = util::spawn_model(localclientnum, str_weapon, self gettagorigin(str_tag), self gettagangles(str_tag));
        e_weapon linkto(self, str_tag);
    }
}

// Namespace safehouse
// Params 7, eflags: 0x0
// Checksum 0x19f30812, Offset: 0x2010
// Size: 0x3c
function near_gun_rack(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace safehouse
// Params 7, eflags: 0x0
// Checksum 0xa1b43bcf, Offset: 0x2058
// Size: 0xbc
function toggle_console_1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_46813487 = getent(localclientnum, "arm_1", "targetname");
    if (newval == 1) {
        var_46813487 thread scene::play("p7_fxanim_cp_safehouse_arm_console_1_down_bundle");
        return;
    }
    var_46813487 thread scene::play("p7_fxanim_cp_safehouse_arm_console_1_up_bundle");
}

// Namespace safehouse
// Params 7, eflags: 0x0
// Checksum 0x66b6d4e2, Offset: 0x2120
// Size: 0xbc
function toggle_console_2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_46813487 = getent(localclientnum, "arm_2", "targetname");
    if (newval == 1) {
        var_46813487 thread scene::play("p7_fxanim_cp_safehouse_arm_console_2_down_bundle");
        return;
    }
    var_46813487 thread scene::play("p7_fxanim_cp_safehouse_arm_console_2_up_bundle");
}

// Namespace safehouse
// Params 7, eflags: 0x0
// Checksum 0x8a3f4999, Offset: 0x21e8
// Size: 0xbc
function toggle_console_3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_46813487 = getent(localclientnum, "arm_3", "targetname");
    if (newval == 1) {
        var_46813487 thread scene::play("p7_fxanim_cp_safehouse_arm_console_3_down_bundle");
        return;
    }
    var_46813487 thread scene::play("p7_fxanim_cp_safehouse_arm_console_3_up_bundle");
}

// Namespace safehouse
// Params 7, eflags: 0x0
// Checksum 0x4dc37fee, Offset: 0x22b0
// Size: 0xbc
function toggle_console_4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_46813487 = getent(localclientnum, "arm_4", "targetname");
    if (newval == 1) {
        var_46813487 thread scene::play("p7_fxanim_cp_safehouse_arm_console_4_down_bundle");
        return;
    }
    var_46813487 thread scene::play("p7_fxanim_cp_safehouse_arm_console_4_up_bundle");
}

// Namespace safehouse
// Params 7, eflags: 0x0
// Checksum 0xcdbbb5e5, Offset: 0x2378
// Size: 0xb4
function player_clone(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    clone = self;
    owner = clone getowner(localclientnum);
    if (owner isplayer()) {
        clone makefakeai();
        clone setdrawownername(1);
    }
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x4d1ebd22, Offset: 0x2438
// Size: 0x7c
function on_player_connect(localclientnum) {
    println("<dev string:x28>" + localclientnum);
    function_7e781987(localclientnum);
    customclass::localclientconnect(localclientnum);
    setupclientmenus(localclientnum);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0xd379b8e8, Offset: 0x24c0
// Size: 0x4c
function open_choose_class(localclientnum, menu_data) {
    level thread character_customization::rotation_thread_spawner(localclientnum, menu_data.custom_character, "choose_class_closed" + localclientnum);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0xb5297ddf, Offset: 0x2518
// Size: 0x28
function close_choose_class(localclientnum, menu_data) {
    level notify("choose_class_closed" + localclientnum);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x3347b326, Offset: 0x2548
// Size: 0x34
function function_85a15cfc(localclientnum, menu_data) {
    postfx::setfrontendstreamingoverlay(localclientnum, "cybercore", 1);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x7a96940f, Offset: 0x2588
// Size: 0x64
function function_62845c2(localclientnum, menu_data) {
    enablefrontendlockedweaponoverlay(localclientnum, 0);
    enablefrontendtokenlockedweaponoverlay(localclientnum, 0);
    postfx::setfrontendstreamingoverlay(localclientnum, "cybercore", 0);
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0xb6827216, Offset: 0x25f8
// Size: 0x484
function function_7e781987(localclientnum) {
    level.var_19c61a80 = associativearray();
    collectibles = struct::function_10500222("collectible");
    foreach (item in collectibles) {
        if (!isdefined(level.var_19c61a80[item.var_4ac27406]) && isdefined(item.uimodel) && item.uimodel !== "tag_origin") {
            level.var_19c61a80[item.var_4ac27406] = item.uimodel;
        }
    }
    level.rooms[localclientnum] = [];
    for (n_player_index = 0; n_player_index < 4; n_player_index++) {
        level.rooms[localclientnum][n_player_index] = spawnstruct();
        level.rooms[localclientnum][n_player_index].a_coll = [];
        for (var_f607056a = 0; var_f607056a <= 8; var_f607056a++) {
            item = function_1bbcb5e2(localclientnum, n_player_index, "collectible_" + var_f607056a);
            if (isdefined(item)) {
                var_e44d919a = spawnstruct();
                var_e44d919a.model = util::spawn_model(localclientnum, level.var_19c61a80[function_48fdc243(var_f607056a)], item.origin, item.angles);
                var_e44d919a.model hide();
                var_e44d919a.var_56ad232d = util::spawn_model(localclientnum, "tag_origin", var_e44d919a.model gettagorigin("tag_center_rotate_anim"), var_e44d919a.model gettagangles("tag_center_rotate_anim"));
                if (function_48fdc243(var_f607056a) == 0) {
                    var_e44d919a.var_56ad232d.origin += (0, 0, -4);
                }
                level.rooms[localclientnum][n_player_index].a_coll[var_f607056a] = var_e44d919a;
            }
        }
    }
    var_1dd8c4d6 = struct::get("browse_collectible_position");
    if (isdefined(var_1dd8c4d6)) {
        level.var_51cfdd5[localclientnum] = util::spawn_model(localclientnum, "tag_origin", var_1dd8c4d6.origin, var_1dd8c4d6.angles);
        level.var_51cfdd5[localclientnum].baseorigin = var_1dd8c4d6.origin;
        level.var_51cfdd5[localclientnum].baseangles = var_1dd8c4d6.angles;
        level.var_51cfdd5[localclientnum].var_f3e9c22 = (0, 0, 0);
        level.var_51cfdd5[localclientnum] hide();
    }
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x75061057, Offset: 0x2a88
// Size: 0x76
function function_48fdc243(slot) {
    switch (slot) {
    case 0:
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
        return 0;
    case 6:
    case 7:
        return 1;
    case 8:
        return 2;
    }
}

// Namespace safehouse
// Params 3, eflags: 0x0
// Checksum 0xc9f40890, Offset: 0x2b08
// Size: 0x39e
function on_collectibles_change(var_79678dca, var_7217384b, localclientnum) {
    if (!isdefined(localclientnum)) {
        localclientnum = 0;
    }
    assert(var_7217384b.size == 9);
    assert(isdefined(level.rooms));
    for (slot = 0; slot < var_7217384b.size; slot++) {
        if (!(isdefined(level.rooms[localclientnum][var_79678dca].a_coll[slot].var_d3fca4df) && level.rooms[localclientnum][var_79678dca].a_coll[slot].var_d3fca4df)) {
            modelname = level.var_19c61a80[function_48fdc243(slot)];
            isdefault = 1;
            if (isdefined(var_7217384b[slot])) {
                var_89573eb4 = struct::get_script_bundle_list("collectible", var_7217384b[slot]["collectiblelist"]);
                if (isdefined(var_89573eb4)) {
                    collectible = struct::get_script_bundle("collectible", var_89573eb4[var_7217384b[slot]["index"]]);
                    if (isdefined(collectible)) {
                        modelname = collectible.uimodel;
                        if (isdefined(collectible.var_250662be)) {
                            modelname = collectible.var_250662be;
                        }
                        isdefault = 0;
                    }
                }
            }
            if (isdefault) {
                level.rooms[localclientnum][var_79678dca].a_coll[slot].model hide();
                level.rooms[localclientnum][var_79678dca].a_coll[slot].visible = undefined;
            }
            level.rooms[localclientnum][var_79678dca].a_coll[slot].model setmodel(modelname);
            level.rooms[localclientnum][var_79678dca].a_coll[slot].model function_ee4604c8(localclientnum, function_b24300d0(modelname));
            if (!isdefault) {
                level.rooms[localclientnum][var_79678dca].a_coll[slot].model show();
                level.rooms[localclientnum][var_79678dca].a_coll[slot].visible = 1;
            }
        }
    }
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0xbe811777, Offset: 0x2eb0
// Size: 0x32
function on_player_spawned(localclientnum) {
    self endon(#"disconnect");
    clearlastupdatedcollectibles(localclientnum);
    wait 1;
}

// Namespace safehouse
// Params 3, eflags: 0x0
// Checksum 0x63768277, Offset: 0x2ef0
// Size: 0x4c
function function_89e3b03e(xcam, lerpduration, subxcam) {
    self notify(#"xcammoved");
    self playextracamxcam(xcam, lerpduration, subxcam);
}

// Namespace safehouse
// Params 4, eflags: 0x0
// Checksum 0xdb1167de, Offset: 0x2f48
// Size: 0x6c
function function_f1f14ab8(xcam, initialdelay, lerpduration, subxcam) {
    self endon(#"entityshutdown");
    self notify(#"xcammoved");
    self endon(#"xcammoved");
    wait initialdelay;
    self playextracamxcam(xcam, lerpduration, subxcam);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0xee83cf3d, Offset: 0x2fc0
// Size: 0x74
function function_336d330b(localclientnum, menu_name) {
    level thread function_9b46e51(localclientnum, menu_name);
    level thread function_a0fa5ef7(localclientnum, menu_name, 1);
    level thread function_8b8118fc(localclientnum, menu_name);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0xfd7afa6d, Offset: 0x3040
// Size: 0x74
function function_5f0902f7(localclientnum, menu_name) {
    level thread function_9b46e51(localclientnum, menu_name);
    level thread function_a0fa5ef7(localclientnum, menu_name, 0);
    level thread function_8b8118fc(localclientnum, menu_name);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0xc2f999ad, Offset: 0x30c0
// Size: 0x34
function function_74e49d6f(localclientnum, menu_name) {
    level.var_51cfdd5[localclientnum] hide();
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0xad261af5, Offset: 0x3100
// Size: 0x2d8
function function_9b46e51(localclientnum, menu_name) {
    level endon(#"disconnect");
    level endon(menu_name + "_closed");
    var_c5958671 = getuimodelforcontroller(localclientnum);
    var_a7f04717 = getuimodelvalue(getuimodel(var_c5958671, "safehouse.inClientBunk"));
    var_e4e20590 = function_1bbcb5e2(localclientnum, var_a7f04717, "tag_align_cam_coll_sm");
    var_b2f25812 = function_1bbcb5e2(localclientnum, var_a7f04717, "tag_align_cam_coll_med");
    var_89ca8dbc = function_1bbcb5e2(localclientnum, var_a7f04717, "tag_align_cam_coll_lg");
    assert(isdefined(var_e4e20590) && isdefined(var_b2f25812) && isdefined(var_89ca8dbc));
    playmaincamxcam(localclientnum, "c_saf_ram_bunk_vign_sm", 0, "cam1", "s_collectible", var_e4e20590.origin, var_e4e20590.angles);
    while (true) {
        level waittill("collectibles_slot_change" + localclientnum, slot);
        if (slot === 0) {
            playmaincamxcam(localclientnum, "c_saf_ram_bunk_vign_sm", 500, "cam1", "s_collectible", var_e4e20590.origin, var_e4e20590.angles);
            continue;
        }
        if (slot === 1) {
            playmaincamxcam(localclientnum, "c_saf_ram_bunk_vign_med", 500, "cam1", "m_collectible", var_b2f25812.origin, var_b2f25812.angles);
            continue;
        }
        if (slot === 2) {
            playmaincamxcam(localclientnum, "c_saf_ram_bunk_vign_lg", 500, "cam1", "l_collectible", var_89ca8dbc.origin, var_89ca8dbc.angles);
        }
    }
}

// Namespace safehouse
// Params 4, eflags: 0x0
// Checksum 0x8e7239b2, Offset: 0x33e0
// Size: 0xd4
function function_6b23f34f(localclientnum, var_1e2ce4de, var_34a4eb6d, model_name) {
    level.rooms[localclientnum][var_1e2ce4de].a_coll[var_34a4eb6d].model setmodel(model_name);
    level.rooms[localclientnum][var_1e2ce4de].a_coll[var_34a4eb6d].model show();
    level.rooms[localclientnum][var_1e2ce4de].a_coll[var_34a4eb6d].var_d3fca4df = 1;
}

// Namespace safehouse
// Params 3, eflags: 0x0
// Checksum 0x3e3ef663, Offset: 0x34c0
// Size: 0xe4
function function_884c7480(localclientnum, var_1e2ce4de, var_34a4eb6d) {
    level.rooms[localclientnum][var_1e2ce4de].a_coll[var_34a4eb6d].model hide();
    level.rooms[localclientnum][var_1e2ce4de].a_coll[var_34a4eb6d].model setmodel(level.var_19c61a80[function_48fdc243(var_34a4eb6d)]);
    level.rooms[localclientnum][var_1e2ce4de].a_coll[var_34a4eb6d].var_d3fca4df = 1;
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x7e6497f2, Offset: 0x35b0
// Size: 0xe
function function_b24300d0(str_model) {
    return false;
}

// Namespace safehouse
// Params 3, eflags: 0x0
// Checksum 0x88436d0a, Offset: 0x35c8
// Size: 0xb7a
function function_a0fa5ef7(localclientnum, menu_name, var_64bc1c63) {
    level endon(#"disconnect");
    level endon(menu_name + "_closed");
    level thread function_d9b15719(localclientnum, menu_name);
    var_c5958671 = getuimodelforcontroller(localclientnum);
    var_a7f04717 = getuimodelvalue(getuimodel(var_c5958671, "safehouse.inClientBunk"));
    if (var_64bc1c63) {
        for (var_f607056a = 0; var_f607056a <= 8; var_f607056a++) {
        }
    }
    var_47da189b = spawnstruct();
    level.var_51cfdd5[localclientnum] show();
    level.var_51cfdd5[localclientnum] sethighdetail(1, 1);
    while (true) {
        level waittill("collectible_update" + localclientnum, event, var_34a4eb6d, model);
        if (event === "inspecting") {
            if (isdefined(level.var_51cfdd5[localclientnum])) {
                level.var_51cfdd5[localclientnum] setmodel(var_34a4eb6d);
                level.var_51cfdd5[localclientnum] function_ee4604c8(localclientnum, function_b24300d0(var_34a4eb6d));
                level.var_51cfdd5[localclientnum].var_f3e9c22 = getxmodelcenteroffset(var_34a4eb6d) * -1;
                level.var_51cfdd5[localclientnum].angles = level.var_51cfdd5[localclientnum].baseangles - (0, 5, 0);
            }
            continue;
        }
        if (event === "inspect_focus_change") {
            if (isdefined(level.rooms[localclientnum][var_a7f04717].var_9e6f06a8)) {
                killfx(localclientnum, level.rooms[localclientnum][var_a7f04717].var_9e6f06a8);
            }
            level.rooms[localclientnum][var_a7f04717].var_9e6f06a8 = playfxontag(localclientnum, "light/fx_glow_collectible_white", level.rooms[localclientnum][var_a7f04717].a_coll[var_34a4eb6d].var_56ad232d, "tag_center_rotate_anim");
            continue;
        }
        if (var_64bc1c63) {
            if (event === "clear_preview_collectible") {
                if (isdefined(var_47da189b.visible) && var_47da189b.visible) {
                    function_6b23f34f(localclientnum, var_a7f04717, var_47da189b.slot, var_47da189b.model);
                } else {
                    function_884c7480(localclientnum, var_a7f04717, var_47da189b.slot);
                }
                for (collectibleindex = 0; collectibleindex < level.rooms[localclientnum][var_a7f04717].a_coll.size; collectibleindex++) {
                    var_2de04519 = level.rooms[localclientnum][var_a7f04717].a_coll[collectibleindex];
                    if (isdefined(var_2de04519.visible) && isdefined(var_2de04519.var_c62c5c23) && var_2de04519.var_c62c5c23 && var_2de04519.visible) {
                        var_2de04519.model show();
                    }
                    var_2de04519.var_c62c5c23 = undefined;
                }
            }
            if (event === "equip") {
                function_6b23f34f(localclientnum, var_a7f04717, var_34a4eb6d, model);
                level.rooms[localclientnum][var_a7f04717].a_coll[var_34a4eb6d].visible = 1;
                level.rooms[localclientnum][var_a7f04717].a_coll[var_34a4eb6d].model function_ee4604c8(localclientnum, function_b24300d0(model));
                var_47da189b.slot = undefined;
                var_47da189b.visible = undefined;
                var_47da189b.model = undefined;
                for (collectibleindex = 0; collectibleindex < level.rooms[localclientnum][var_a7f04717].a_coll.size; collectibleindex++) {
                    var_2de04519 = level.rooms[localclientnum][var_a7f04717].a_coll[collectibleindex];
                    var_2de04519.var_c62c5c23 = undefined;
                }
            } else if (event === "unequip") {
                function_884c7480(localclientnum, var_a7f04717, var_34a4eb6d);
                level.rooms[localclientnum][var_a7f04717].a_coll[var_34a4eb6d].visible = 0;
                var_47da189b.slot = undefined;
                var_47da189b.visible = undefined;
                var_47da189b.model = undefined;
                for (collectibleindex = 0; collectibleindex < level.rooms[localclientnum][var_a7f04717].a_coll.size; collectibleindex++) {
                    var_2de04519 = level.rooms[localclientnum][var_a7f04717].a_coll[collectibleindex];
                    var_2de04519.var_c62c5c23 = undefined;
                    if (isdefined(var_2de04519.visible) && var_2de04519.visible) {
                        var_2de04519.model show();
                    }
                }
            } else if (event === "focus_change") {
                if (isdefined(var_47da189b.slot)) {
                    if (isdefined(var_47da189b.visible) && var_47da189b.visible) {
                        function_6b23f34f(localclientnum, var_a7f04717, var_47da189b.slot, var_47da189b.model);
                        level.rooms[localclientnum][var_a7f04717].a_coll[var_47da189b.slot].model function_ee4604c8(localclientnum, function_b24300d0(var_47da189b.model));
                    } else {
                        function_884c7480(localclientnum, var_a7f04717, var_47da189b.slot);
                    }
                    if (isdefined(level.rooms[localclientnum][var_a7f04717].a_coll[var_47da189b.slot].var_9e6f06a8)) {
                    }
                }
                var_47da189b.slot = var_34a4eb6d;
                var_47da189b.model = level.rooms[localclientnum][var_a7f04717].a_coll[var_47da189b.slot].model.model;
                var_47da189b.visible = level.rooms[localclientnum][var_a7f04717].a_coll[var_47da189b.slot].visible;
                for (collectibleindex = 0; collectibleindex < level.rooms[localclientnum][var_a7f04717].a_coll.size; collectibleindex++) {
                    var_2de04519 = level.rooms[localclientnum][var_a7f04717].a_coll[collectibleindex];
                    if (var_2de04519.model.model == model && collectibleindex != var_47da189b.slot) {
                        var_2de04519.var_c62c5c23 = 1;
                        continue;
                    }
                    var_2de04519.var_c62c5c23 = undefined;
                }
                if (isdefined(level.rooms[localclientnum][var_a7f04717].a_coll[var_47da189b.slot].var_9e6f06a8)) {
                }
                function_6b23f34f(localclientnum, var_a7f04717, var_47da189b.slot, model);
                level.rooms[localclientnum][var_a7f04717].a_coll[var_47da189b.slot].model function_ee4604c8(localclientnum, function_b24300d0(model));
            }
            for (collectibleindex = 0; collectibleindex < level.rooms[localclientnum][var_a7f04717].a_coll.size; collectibleindex++) {
                var_2de04519 = level.rooms[localclientnum][var_a7f04717].a_coll[collectibleindex];
                if (isdefined(var_2de04519.var_c62c5c23) && var_2de04519.var_c62c5c23) {
                    var_2de04519.model hide();
                }
            }
        }
    }
}

// Namespace safehouse
// Params 3, eflags: 0x0
// Checksum 0x345de1b1, Offset: 0x4150
// Size: 0x160
function function_a2e25254(localclientnum, menu_name, extracam_data) {
    level endon(#"disconnect");
    level endon(menu_name + "_closed");
    camera_ent = multi_extracam::extracam_init_index(localclientnum, "browse_collectible_position", 1);
    if (isdefined(camera_ent)) {
        camera_ent playextracamxcam("c_saf_collectibles_staging_small_cam", 0, "cam_1");
    }
    while (true) {
        level waittill("collectible_size" + localclientnum, size);
        if (size === 0) {
            camera_ent playextracamxcam("c_saf_collectibles_staging_small_cam", 0, "cam_1");
            continue;
        }
        if (size === 1) {
            camera_ent playextracamxcam("c_saf_collectibles_staging_cam", 0, "cam_1");
            continue;
        }
        if (size === 2) {
            camera_ent playextracamxcam("c_saf_collectibles_staging_large_cam", 0, "cam_1");
        }
    }
}

// Namespace safehouse
// Params 3, eflags: 0x0
// Checksum 0xc6f20c1c, Offset: 0x42b8
// Size: 0x160
function function_d9350b98(localclientnum, menu_name, extracam_data) {
    level endon(#"disconnect");
    level endon(menu_name + "_closed");
    camera_ent = multi_extracam::extracam_init_index(localclientnum, "browse_collectible_position", 1);
    if (isdefined(camera_ent)) {
        camera_ent playextracamxcam("c_saf_collectibles_staging_small_cam", 0, "cam_1");
    }
    while (true) {
        level waittill("collectibles_slot_change" + localclientnum, size);
        if (size === 0) {
            camera_ent playextracamxcam("c_saf_collectibles_staging_small_cam", 0, "cam_1");
            continue;
        }
        if (size === 1) {
            camera_ent playextracamxcam("c_saf_collectibles_staging_cam", 0, "cam_1");
            continue;
        }
        if (size === 2) {
            camera_ent playextracamxcam("c_saf_collectibles_staging_large_cam", 0, "cam_1");
        }
    }
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0xe48befca, Offset: 0x4420
// Size: 0x330
function function_8b8118fc(localclientnum, menu_name) {
    level endon(#"disconnect");
    level endon(menu_name + "_closed");
    if (isdefined(level.var_51cfdd5[localclientnum])) {
        while (true) {
            pos = getcontrollerposition(localclientnum);
            n_yaw = 0;
            n_pitch = 0;
            if (isdefined(pos["rightStick"])) {
                n_yaw = pos["rightStick"][0];
                n_pitch = pos["rightStick"][1];
            } else {
                n_yaw = pos["look"][0];
                n_pitch = pos["look"][1];
            }
            if (ispc()) {
                pos = getxcammousecontrol(localclientnum);
                n_yaw -= pos["yaw"];
                n_pitch -= pos["pitch"];
            }
            rotation = (0, n_yaw * 3, 0);
            level.var_51cfdd5[localclientnum].angles = (absangleclamp360(level.var_51cfdd5[localclientnum].angles[0] + rotation[0]), absangleclamp360(level.var_51cfdd5[localclientnum].angles[1] + rotation[1]), absangleclamp360(level.var_51cfdd5[localclientnum].angles[2] + rotation[2]));
            v_offset = level.var_51cfdd5[localclientnum].var_f3e9c22;
            v_base = level.var_51cfdd5[localclientnum].baseorigin;
            n_yaw = level.var_51cfdd5[localclientnum].angles[1];
            n_pitch = level.var_51cfdd5[localclientnum].angles[2];
            var_e1664ef3 = rotatepointaroundaxis(v_offset, (0, 0, 1), n_yaw);
            level.var_51cfdd5[localclientnum].origin = var_e1664ef3 + v_base;
            wait 0.01;
        }
    }
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x228d032, Offset: 0x4758
// Size: 0x138
function function_d9b15719(localclientnum, menu_name) {
    level endon(#"disconnect");
    level waittill(menu_name + "_closed");
    var_c5958671 = getuimodelforcontroller(localclientnum);
    var_a7f04717 = getuimodelvalue(getuimodel(var_c5958671, "safehouse.inClientBunk"));
    for (var_f607056a = 0; var_f607056a <= 8; var_f607056a++) {
        if (isdefined(level.rooms[localclientnum][var_a7f04717].var_9e6f06a8)) {
            killfx(localclientnum, level.rooms[localclientnum][var_a7f04717].var_9e6f06a8);
        }
        level.rooms[localclientnum][var_a7f04717].a_coll[var_f607056a].var_9e6f06a8 = undefined;
    }
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x687b6fa, Offset: 0x4898
// Size: 0x5c
function open_choose_head_menu(localclientnum, menu_data) {
    postfx::setfrontendstreamingoverlay(localclientnum, "heads", 1);
    character_customization::function_ea9faed5(localclientnum, level.liveccdata[localclientnum], 0);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0xdd88c343, Offset: 0x4900
// Size: 0x5c
function close_choose_head_menu(localclientnum, menu_data) {
    character_customization::function_ea9faed5(localclientnum, level.liveccdata[localclientnum], 1);
    postfx::setfrontendstreamingoverlay(localclientnum, "heads", 0);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x9b216ef8, Offset: 0x4968
// Size: 0x1e8
function personalize_characters_watch(localclientnum, menu_name) {
    level endon(#"disconnect");
    level endon(menu_name + "_closed");
    s_cam = struct::get("personalizeHero_camera", "targetname");
    assert(isdefined(s_cam));
    playmaincamxcam(localclientnum, "ui_cam_character_customization", 0, "cam_preview");
    while (true) {
        level waittill("camera_change" + localclientnum, pose);
        if (pose === "exploring") {
            playmaincamxcam(localclientnum, "ui_cam_character_customization", 300, "cam_preview", "", s_cam.origin, s_cam.angles);
            continue;
        }
        if (pose === "inspecting_helmet") {
            playmaincamxcam(localclientnum, "ui_cam_character_customization", 300, "cam_helmet", "", s_cam.origin, s_cam.angles);
            continue;
        }
        if (pose === "inspecting_body") {
            playmaincamxcam(localclientnum, "ui_cam_character_customization", 300, "cam_select", "", s_cam.origin, s_cam.angles);
        }
    }
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x59094cc9, Offset: 0x4b58
// Size: 0x4c
function function_fa299ef0(localclientnum, menu_data) {
    postfx::setfrontendstreamingoverlay(localclientnum, "character", 1);
    start_character_rotating(localclientnum, menu_data);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0xc8d29ebf, Offset: 0x4bb0
// Size: 0x4c
function function_9236c726(localclientnum, menu_data) {
    end_character_rotating(localclientnum, menu_data);
    postfx::setfrontendstreamingoverlay(localclientnum, "character", 0);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x1372240b, Offset: 0x4c08
// Size: 0x4c
function start_character_rotating(localclientnum, menu_data) {
    level thread character_customization::rotation_thread_spawner(localclientnum, menu_data.custom_character, "end_character_rotating" + localclientnum);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x7956f949, Offset: 0x4c60
// Size: 0x28
function end_character_rotating(localclientnum, menu_data) {
    level notify("end_character_rotating" + localclientnum);
}

// Namespace safehouse
// Params 7, eflags: 0x0
// Checksum 0x70a0ed44, Offset: 0x4c90
// Size: 0x84
function training_sim_extracam(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self setextracam(newval - 1, 640, -1);
        return;
    }
    self clearextracam();
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x2942b910, Offset: 0x4d20
// Size: 0x2c
function function_66ec7bf3(localclientnum, menu_data) {
    stopmaincamxcam(localclientnum);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0xd0b16520, Offset: 0x4d58
// Size: 0x2c
function function_59622cb6(localclientnum, menu_data) {
    stopmaincamxcam(localclientnum);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0xf7eab759, Offset: 0x4d90
// Size: 0x2c
function function_30eb9463(localclientnum, menu_data) {
    stopmaincamxcam(localclientnum);
}

// Namespace safehouse
// Params 7, eflags: 0x0
// Checksum 0xf1e950c8, Offset: 0x4dc8
// Size: 0x84
function function_2b8cf6a0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval > 0) {
        audio::snd_set_snapshot("cp_safehouse_exit");
        return;
    }
    audio::snd_set_snapshot("default");
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0xad2e766, Offset: 0x4e58
// Size: 0x44
function function_ee4604c8(localclientnum, b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    self thread function_6b0a5a71(localclientnum, b_on);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x1ddf5d9f, Offset: 0x4ea8
// Size: 0x1ec
function function_6b0a5a71(localclientnum, b_on) {
    self endon(#"entityshutdown");
    self notify(#"hash_ee4604c8");
    self endon(#"hash_ee4604c8");
    while (b_on) {
        self duplicate_render::set_dr_flag("armor_on", 1);
        self duplicate_render::update_dr_filters(localclientnum);
        var_aa5d763a = "scriptVector3";
        var_fc81e73c = 0.4;
        var_754d7044 = 1;
        var_e754df7f = 0.45;
        var_595c4eba = 0;
        var_6c5c3132 = "scriptVector4";
        var_93429fd9 = 0.6;
        self mapshaderconstant(localclientnum, 0, var_aa5d763a, var_fc81e73c, var_754d7044, var_e754df7f, var_595c4eba);
        self mapshaderconstant(localclientnum, 0, var_6c5c3132, var_93429fd9, 0, 0, 0);
        self tmodesetflag(10);
        wait 0.5;
        self duplicate_render::set_dr_flag("armor_on", 0);
        self duplicate_render::update_dr_filters(localclientnum);
        wait 10;
    }
    self duplicate_render::set_dr_flag("armor_on", 0);
    self duplicate_render::update_dr_filters(localclientnum);
}

