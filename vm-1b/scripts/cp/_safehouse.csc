#using scripts/codescripts/struct;
#using scripts/core/_multi_extracam;
#using scripts/cp/_training_sim;
#using scripts/shared/_character_customization;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/custom_class;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace safehouse;

// Namespace safehouse
// Params 0, eflags: 0x2
// Checksum 0xe5439e8d, Offset: 0xe70
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("safehouse", &__init__, undefined, undefined);
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0xe14b6d7d, Offset: 0xea8
// Size: 0x32a
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
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x1b5e5a92, Offset: 0x11e0
// Size: 0x54a
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
}

// Namespace safehouse
// Params 3, eflags: 0x0
// Checksum 0xe7a6f746, Offset: 0x1738
// Size: 0xa0
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
// Checksum 0xa9dd7f43, Offset: 0x17e0
// Size: 0x2a
function function_2f834a09(var_404ab86) {
    stopforcingstreamer();
    forcestreamweapons(0);
}

// Namespace safehouse
// Params 7, eflags: 0x0
// Checksum 0x19e7ac36, Offset: 0x1818
// Size: 0xa2
function function_9887cf30(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_cb97644f = createuimodel(getglobaluimodel(), "nextMap");
    var_aed90fc4 = getmapatindex(newval);
    setupfieldopskitloadouts(var_aed90fc4);
    setuimodelvalue(var_cb97644f, var_aed90fc4);
}

// Namespace safehouse
// Params 7, eflags: 0x0
// Checksum 0x87fa4065, Offset: 0x18c8
// Size: 0x2db
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
// Checksum 0x9150d489, Offset: 0x1bb0
// Size: 0x3a
function near_gun_rack(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace safehouse
// Params 7, eflags: 0x0
// Checksum 0x47c1a14a, Offset: 0x1bf8
// Size: 0x9a
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
// Checksum 0x4fb0cd97, Offset: 0x1ca0
// Size: 0x9a
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
// Checksum 0x2fbf3ffa, Offset: 0x1d48
// Size: 0x9a
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
// Checksum 0x2a1ac708, Offset: 0x1df0
// Size: 0x9a
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
// Checksum 0xeb837cfd, Offset: 0x1e98
// Size: 0x9a
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
// Checksum 0x690b39b4, Offset: 0x1f40
// Size: 0x5a
function on_player_connect(localclientnum) {
    println("<dev string:x28>" + localclientnum);
    function_7e781987(localclientnum);
    customclass::localclientconnect(localclientnum);
    setupclientmenus(localclientnum);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x6c5223d9, Offset: 0x1fa8
// Size: 0x32
function open_choose_class(localclientnum, menu_data) {
    level thread character_customization::rotation_thread_spawner(localclientnum, menu_data.custom_character, "choose_class_closed");
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x699bcbd3, Offset: 0x1fe8
// Size: 0x1b
function close_choose_class(localclientnum, menu_data) {
    level notify(#"choose_class_closed");
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x63c4f3dd, Offset: 0x2010
// Size: 0x22
function function_85a15cfc(localclientnum, menu_data) {
    enablefrontendstreamingoverlay(localclientnum, 1);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0xe6a3f34f, Offset: 0x2040
// Size: 0x32
function function_62845c2(localclientnum, menu_data) {
    enablefrontendstreamingoverlay(localclientnum, 0);
    enablefrontendlockedweaponoverlay(localclientnum, 0);
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x1e126d37, Offset: 0x2080
// Size: 0x352
function function_7e781987(localclientnum) {
    level.var_19c61a80 = associativearray();
    collectibles = struct::function_10500222("collectible");
    foreach (item in collectibles) {
        if (!isdefined(level.var_19c61a80[item.var_4ac27406]) && isdefined(item.uimodel) && item.uimodel !== "tag_origin") {
            level.var_19c61a80[item.var_4ac27406] = item.uimodel;
        }
    }
    level.rooms = [];
    for (n_player_index = 0; n_player_index < 4; n_player_index++) {
        level.rooms[n_player_index] = spawnstruct();
        level.rooms[n_player_index].a_coll = [];
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
                level.rooms[n_player_index].a_coll[var_f607056a] = var_e44d919a;
            }
        }
    }
    var_1dd8c4d6 = struct::get("browse_collectible_position");
    if (isdefined(var_1dd8c4d6)) {
        level.var_51cfdd5 = util::spawn_model(localclientnum, "tag_origin", var_1dd8c4d6.origin, var_1dd8c4d6.angles);
        level.var_51cfdd5.baseorigin = var_1dd8c4d6.origin;
        level.var_51cfdd5.baseangles = var_1dd8c4d6.angles;
        level.var_51cfdd5.var_f3e9c22 = (0, 0, 0);
        level.var_51cfdd5 hide();
    }
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x9e757a91, Offset: 0x23e0
// Size: 0x69
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
// Checksum 0x59ea71d9, Offset: 0x2458
// Size: 0x27d
function on_collectibles_change(var_79678dca, var_7217384b, localclientnum) {
    if (!isdefined(localclientnum)) {
        localclientnum = 0;
    }
    assert(var_7217384b.size == 9);
    assert(isdefined(level.rooms));
    for (slot = 0; slot < var_7217384b.size; slot++) {
        if (!(isdefined(level.rooms[var_79678dca].a_coll[slot].var_d3fca4df) && level.rooms[var_79678dca].a_coll[slot].var_d3fca4df)) {
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
                level.rooms[var_79678dca].a_coll[slot].model hide();
                level.rooms[var_79678dca].a_coll[slot].visible = undefined;
            }
            level.rooms[var_79678dca].a_coll[slot].model setmodel(modelname);
            level.rooms[var_79678dca].a_coll[slot].model function_ee4604c8(localclientnum, function_b24300d0(modelname));
            if (!isdefault) {
                level.rooms[var_79678dca].a_coll[slot].model show();
                level.rooms[var_79678dca].a_coll[slot].visible = 1;
            }
        }
    }
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0xc68d8e80, Offset: 0x26e0
// Size: 0x25
function on_player_spawned(localclientnum) {
    self endon(#"disconnect");
    clearlastupdatedcollectibles(localclientnum);
    wait 1;
}

// Namespace safehouse
// Params 3, eflags: 0x0
// Checksum 0x644ef826, Offset: 0x2710
// Size: 0x3a
function function_89e3b03e(xcam, lerpduration, subxcam) {
    self notify(#"xcammoved");
    self playextracamxcam(xcam, lerpduration, subxcam);
}

// Namespace safehouse
// Params 4, eflags: 0x0
// Checksum 0x5d888109, Offset: 0x2758
// Size: 0x52
function function_f1f14ab8(xcam, initialdelay, lerpduration, subxcam) {
    self endon(#"entityshutdown");
    self notify(#"xcammoved");
    self endon(#"xcammoved");
    wait initialdelay;
    self playextracamxcam(xcam, lerpduration, subxcam);
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0xaab4ec71, Offset: 0x27b8
// Size: 0x2bd
function function_d63e54a8(type) {
    level endon(#"disconnect");
    while (true) {
        level waittill("CustomClass_" + type, var_987227b8, var_2cc40b49);
        camera_ent = level.camera_ents[0];
        if (type == "secondary") {
            camera_ent = level.camera_ents[1];
        }
        if (var_987227b8 == "custom" || var_987227b8 == "custom_removeattach") {
            lerpduration = 1;
            var_fcccfca6 = strtok(var_2cc40b49, "+");
            weaponname = getsubstr(var_fcccfca6[0], 0, var_fcccfca6[0].size - 3);
            var_1867e9cc = "cam_custom";
            if (weaponname == "ar_standard") {
                suppressed = 0;
                extbarrel = 0;
                for (i = 1; i < var_fcccfca6.size; i++) {
                    if (var_fcccfca6[i] == "suppressed") {
                        suppressed = 1;
                        continue;
                    }
                    if (var_fcccfca6[i] == "extbarrel") {
                        extbarrel = 1;
                    }
                }
                if (suppressed + extbarrel > 0) {
                    var_1867e9cc = "cam_zoom" + suppressed + extbarrel;
                }
            }
            if (var_987227b8 == "custom_removeattach") {
                lerpduration = 300;
            }
            if (type == "primary") {
                level.primaryweapon = weaponname;
            }
            xcamname = "ui_cam_cac_select_" + weaponname;
            camera_ent function_89e3b03e(xcamname, lerpduration, var_1867e9cc);
            continue;
        }
        if (var_987227b8 == "select") {
            xcamname = "ui_cam_cac_select_" + var_2cc40b49;
            camera_ent function_89e3b03e(xcamname, 500, "cam_select");
            continue;
        }
        if (var_987227b8 == "attachment") {
            if (type == "primary" && isdefined(level.primaryweapon) && level.primaryweapon == "ar_standard") {
                for (i = 2; i < level.camera_ents.size; i++) {
                    if (isdefined(level.camera_ents[i])) {
                        level.camera_ents[i] delete();
                    }
                }
                if (var_2cc40b49 == "reflex") {
                    var_2cc40b49 = "optics";
                }
                camera_ent thread function_f1f14ab8("ui_cam_cac_attachments_ar_arak", 0.3, 400, "cam_" + var_2cc40b49);
            }
        }
    }
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x3b707b76, Offset: 0x2a80
// Size: 0x5a
function function_336d330b(localclientnum, menu_name) {
    level thread function_9b46e51(localclientnum, menu_name);
    level thread function_a0fa5ef7(localclientnum, menu_name, 1);
    level thread function_8b8118fc(localclientnum, menu_name);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0xf2b143d8, Offset: 0x2ae8
// Size: 0x5a
function function_5f0902f7(localclientnum, menu_name) {
    level thread function_9b46e51(localclientnum, menu_name);
    level thread function_a0fa5ef7(localclientnum, menu_name, 0);
    level thread function_8b8118fc(localclientnum, menu_name);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0xadfccc4e, Offset: 0x2b50
// Size: 0x2a
function function_74e49d6f(localclientnum, menu_name) {
    level.var_51cfdd5 hide();
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x7989b50b, Offset: 0x2b88
// Size: 0x23d
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
        level waittill(#"hash_3c3eb4de", slot);
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
// Params 3, eflags: 0x0
// Checksum 0xfa913ee6, Offset: 0x2dd0
// Size: 0x8e
function function_6b23f34f(var_1e2ce4de, var_34a4eb6d, model_name) {
    level.rooms[var_1e2ce4de].a_coll[var_34a4eb6d].model setmodel(model_name);
    level.rooms[var_1e2ce4de].a_coll[var_34a4eb6d].model show();
    level.rooms[var_1e2ce4de].a_coll[var_34a4eb6d].var_d3fca4df = 1;
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x8e219e30, Offset: 0x2e68
// Size: 0x96
function function_884c7480(var_1e2ce4de, var_34a4eb6d) {
    level.rooms[var_1e2ce4de].a_coll[var_34a4eb6d].model hide();
    level.rooms[var_1e2ce4de].a_coll[var_34a4eb6d].model setmodel(level.var_19c61a80[function_48fdc243(var_34a4eb6d)]);
    level.rooms[var_1e2ce4de].a_coll[var_34a4eb6d].var_d3fca4df = 1;
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x881290f7, Offset: 0x2f08
// Size: 0xb
function function_b24300d0(str_model) {
    return false;
}

// Namespace safehouse
// Params 3, eflags: 0x0
// Checksum 0xc3717fed, Offset: 0x2f20
// Size: 0x7c5
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
    level.var_51cfdd5 show();
    level.var_51cfdd5 sethighdetail(1, 1);
    while (true) {
        level waittill(#"hash_3de20343", event, var_34a4eb6d, model);
        if (event === "inspecting") {
            if (isdefined(level.var_51cfdd5)) {
                level.var_51cfdd5 setmodel(var_34a4eb6d);
                level.var_51cfdd5 function_ee4604c8(localclientnum, function_b24300d0(var_34a4eb6d));
                level.var_51cfdd5.var_f3e9c22 = getxmodelcenteroffset(var_34a4eb6d) * -1;
                level.var_51cfdd5.angles = level.var_51cfdd5.baseangles - (0, 5, 0);
            }
            continue;
        }
        if (event === "inspect_focus_change") {
            if (isdefined(level.rooms[var_a7f04717].var_9e6f06a8)) {
                killfx(localclientnum, level.rooms[var_a7f04717].var_9e6f06a8);
            }
            level.rooms[var_a7f04717].var_9e6f06a8 = playfxontag(localclientnum, "light/fx_glow_collectible_white", level.rooms[var_a7f04717].a_coll[var_34a4eb6d].var_56ad232d, "tag_center_rotate_anim");
            continue;
        }
        if (var_64bc1c63) {
            if (event === "clear_preview_collectible") {
                if (isdefined(var_47da189b.visible) && var_47da189b.visible) {
                    function_6b23f34f(var_a7f04717, var_47da189b.slot, var_47da189b.model);
                } else {
                    function_884c7480(var_a7f04717, var_47da189b.slot);
                }
                for (collectibleindex = 0; collectibleindex < level.rooms[var_a7f04717].a_coll.size; collectibleindex++) {
                    var_2de04519 = level.rooms[var_a7f04717].a_coll[collectibleindex];
                    if (isdefined(var_2de04519.visible) && isdefined(var_2de04519.var_c62c5c23) && var_2de04519.var_c62c5c23 && var_2de04519.visible) {
                        var_2de04519.model show();
                    }
                    var_2de04519.var_c62c5c23 = undefined;
                }
            }
            if (event === "equip") {
                function_6b23f34f(var_a7f04717, var_34a4eb6d, model);
                level.rooms[var_a7f04717].a_coll[var_34a4eb6d].visible = 1;
                level.rooms[var_a7f04717].a_coll[var_34a4eb6d].model function_ee4604c8(localclientnum, function_b24300d0(model));
                var_47da189b.slot = undefined;
                var_47da189b.visible = undefined;
                var_47da189b.model = undefined;
                for (collectibleindex = 0; collectibleindex < level.rooms[var_a7f04717].a_coll.size; collectibleindex++) {
                    var_2de04519 = level.rooms[var_a7f04717].a_coll[collectibleindex];
                    var_2de04519.var_c62c5c23 = undefined;
                }
            } else if (event === "unequip") {
                function_884c7480(var_a7f04717, var_34a4eb6d);
                level.rooms[var_a7f04717].a_coll[var_34a4eb6d].visible = 0;
                var_47da189b.slot = undefined;
                var_47da189b.visible = undefined;
                var_47da189b.model = undefined;
                for (collectibleindex = 0; collectibleindex < level.rooms[var_a7f04717].a_coll.size; collectibleindex++) {
                    var_2de04519 = level.rooms[var_a7f04717].a_coll[collectibleindex];
                    var_2de04519.var_c62c5c23 = undefined;
                    if (isdefined(var_2de04519.visible) && var_2de04519.visible) {
                        var_2de04519.model show();
                    }
                }
            } else if (event === "focus_change") {
                if (isdefined(var_47da189b.slot)) {
                    if (isdefined(var_47da189b.visible) && var_47da189b.visible) {
                        function_6b23f34f(var_a7f04717, var_47da189b.slot, var_47da189b.model);
                        level.rooms[var_a7f04717].a_coll[var_47da189b.slot].model function_ee4604c8(localclientnum, function_b24300d0(var_47da189b.model));
                    } else {
                        function_884c7480(var_a7f04717, var_47da189b.slot);
                    }
                    if (isdefined(level.rooms[var_a7f04717].a_coll[var_47da189b.slot].var_9e6f06a8)) {
                    }
                }
                var_47da189b.slot = var_34a4eb6d;
                var_47da189b.model = level.rooms[var_a7f04717].a_coll[var_47da189b.slot].model.model;
                var_47da189b.visible = level.rooms[var_a7f04717].a_coll[var_47da189b.slot].visible;
                for (collectibleindex = 0; collectibleindex < level.rooms[var_a7f04717].a_coll.size; collectibleindex++) {
                    var_2de04519 = level.rooms[var_a7f04717].a_coll[collectibleindex];
                    if (var_2de04519.model.model == model && collectibleindex != var_47da189b.slot) {
                        var_2de04519.var_c62c5c23 = 1;
                        continue;
                    }
                    var_2de04519.var_c62c5c23 = undefined;
                }
                if (isdefined(level.rooms[var_a7f04717].a_coll[var_47da189b.slot].var_9e6f06a8)) {
                }
                function_6b23f34f(var_a7f04717, var_47da189b.slot, model);
                level.rooms[var_a7f04717].a_coll[var_47da189b.slot].model function_ee4604c8(localclientnum, function_b24300d0(model));
            }
            for (collectibleindex = 0; collectibleindex < level.rooms[var_a7f04717].a_coll.size; collectibleindex++) {
                var_2de04519 = level.rooms[var_a7f04717].a_coll[collectibleindex];
                if (isdefined(var_2de04519.var_c62c5c23) && var_2de04519.var_c62c5c23) {
                    var_2de04519.model hide();
                }
            }
        }
    }
}

// Namespace safehouse
// Params 3, eflags: 0x0
// Checksum 0x1aa17c27, Offset: 0x36f0
// Size: 0x10d
function function_a2e25254(localclientnum, menu_name, extracam_data) {
    level endon(#"disconnect");
    level endon(menu_name + "_closed");
    camera_ent = multi_extracam::extracam_init_index(localclientnum, "browse_collectible_position", 1);
    if (isdefined(camera_ent)) {
        camera_ent playextracamxcam("c_saf_collectibles_staging_small_cam", 0, "cam_1");
    }
    while (true) {
        level waittill(#"hash_43040a73", size);
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
// Checksum 0x7c2f7bce, Offset: 0x3808
// Size: 0x10d
function function_d9350b98(localclientnum, menu_name, extracam_data) {
    level endon(#"disconnect");
    level endon(menu_name + "_closed");
    camera_ent = multi_extracam::extracam_init_index(localclientnum, "browse_collectible_position", 1);
    if (isdefined(camera_ent)) {
        camera_ent playextracamxcam("c_saf_collectibles_staging_small_cam", 0, "cam_1");
    }
    while (true) {
        level waittill(#"hash_3c3eb4de", size);
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
// Checksum 0xa445f3f1, Offset: 0x3920
// Size: 0x1bd
function function_8b8118fc(localclientnum, menu_name) {
    level endon(#"disconnect");
    level endon(menu_name + "_closed");
    if (isdefined(level.var_51cfdd5)) {
        while (true) {
            pos = getcontrollerposition(localclientnum);
            n_yaw = 0;
            n_pitch = 0;
            n_yaw = pos["look"][0];
            n_pitch = pos["look"][1];
            rotation = (0, n_yaw * 3, 0);
            level.var_51cfdd5.angles = (absangleclamp360(level.var_51cfdd5.angles[0] + rotation[0]), absangleclamp360(level.var_51cfdd5.angles[1] + rotation[1]), absangleclamp360(level.var_51cfdd5.angles[2] + rotation[2]));
            v_offset = level.var_51cfdd5.var_f3e9c22;
            v_base = level.var_51cfdd5.baseorigin;
            n_yaw = level.var_51cfdd5.angles[1];
            n_pitch = level.var_51cfdd5.angles[2];
            var_e1664ef3 = rotatepointaroundaxis(v_offset, (0, 0, 1), n_yaw);
            level.var_51cfdd5.origin = var_e1664ef3 + v_base;
            wait 0.01;
        }
    }
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x3c72d45b, Offset: 0x3ae8
// Size: 0xdb
function function_d9b15719(localclientnum, menu_name) {
    level endon(#"disconnect");
    level waittill(menu_name + "_closed");
    var_c5958671 = getuimodelforcontroller(localclientnum);
    var_a7f04717 = getuimodelvalue(getuimodel(var_c5958671, "safehouse.inClientBunk"));
    for (var_f607056a = 0; var_f607056a <= 8; var_f607056a++) {
        if (isdefined(level.rooms[var_a7f04717].var_9e6f06a8)) {
            killfx(localclientnum, level.rooms[var_a7f04717].var_9e6f06a8);
        }
        level.rooms[var_a7f04717].a_coll[var_f607056a].var_9e6f06a8 = undefined;
    }
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0xfd867771, Offset: 0x3bd0
// Size: 0x3a
function open_choose_head_menu(localclientnum, menu_data) {
    enablefrontendstreamingoverlay(localclientnum, 1);
    character_customization::function_ea9faed5(localclientnum, level.liveccdata, 0);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x93f3f38b, Offset: 0x3c18
// Size: 0x3a
function close_choose_head_menu(localclientnum, menu_data) {
    character_customization::function_ea9faed5(localclientnum, level.liveccdata, 1);
    enablefrontendstreamingoverlay(localclientnum, 0);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x3593c918, Offset: 0x3c60
// Size: 0x18d
function personalize_characters_watch(localclientnum, menu_name) {
    level endon(#"disconnect");
    level endon(menu_name + "_closed");
    s_cam = struct::get("personalizeHero_camera", "targetname");
    assert(isdefined(s_cam));
    playmaincamxcam(localclientnum, "ui_cam_character_customization", 0, "cam_preview");
    while (true) {
        level waittill(#"camera_change", pose);
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
// Checksum 0x8260c4f1, Offset: 0x3df8
// Size: 0x32
function function_fa299ef0(localclientnum, menu_data) {
    enablefrontendstreamingoverlay(localclientnum, 1);
    start_character_rotating(localclientnum, menu_data);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x9fb212d6, Offset: 0x3e38
// Size: 0x32
function function_9236c726(localclientnum, menu_data) {
    end_character_rotating(localclientnum, menu_data);
    enablefrontendstreamingoverlay(localclientnum, 0);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x9b0a3952, Offset: 0x3e78
// Size: 0x32
function start_character_rotating(localclientnum, menu_data) {
    level thread character_customization::rotation_thread_spawner(localclientnum, menu_data.custom_character, "end_character_rotating");
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0xe18e0b34, Offset: 0x3eb8
// Size: 0x1b
function end_character_rotating(localclientnum, menu_data) {
    level notify(#"end_character_rotating");
}

// Namespace safehouse
// Params 7, eflags: 0x0
// Checksum 0x7d7261c4, Offset: 0x3ee0
// Size: 0x6a
function training_sim_extracam(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self setextracam(newval - 1, 640, -1);
        return;
    }
    self clearextracam();
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0xcee90ea5, Offset: 0x3f58
// Size: 0x22
function function_66ec7bf3(localclientnum, menu_data) {
    stopmaincamxcam(localclientnum);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x93f6616d, Offset: 0x3f88
// Size: 0x22
function function_59622cb6(localclientnum, menu_data) {
    stopmaincamxcam(localclientnum);
}

// Namespace safehouse
// Params 7, eflags: 0x0
// Checksum 0xe8311e32, Offset: 0x3fb8
// Size: 0x72
function function_2b8cf6a0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval > 0) {
        audio::snd_set_snapshot("cp_safehouse_exit");
        return;
    }
    audio::snd_set_snapshot("default");
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x4e3db9fd, Offset: 0x4038
// Size: 0x32
function function_ee4604c8(localclientnum, b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    self thread function_6b0a5a71(localclientnum, b_on);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x9bce9085, Offset: 0x4078
// Size: 0x172
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

