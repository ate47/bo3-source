#using scripts/codescripts/struct;
#using scripts/core/_multi_extracam;
#using scripts/shared/_character_customization;
#using scripts/shared/_weapon_customization_icon;
#using scripts/shared/ai/archetype_damage_effects;
#using scripts/shared/ai/systems/destructible_character;
#using scripts/shared/ai/zombie;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/custom_class;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/util_shared;

#using_animtree("generic");

#namespace frontend;

// Namespace frontend
// Method(s) 0 Total 0
class class_38d92933 {

}

// Namespace frontend
// Method(s) 0 Total 0
class class_5ad92933 {

}

// Namespace frontend
// Method(s) 0 Total 0
class class_34d92933 {

}

// Namespace frontend
// Method(s) 0 Total 0
class class_57d92933 {

}

// Namespace frontend
// Method(s) 0 Total 0
class class_37d92933 {

}

// Namespace frontend
// Method(s) 0 Total 0
class class_2bd92933 {

}

// Namespace frontend
// Params 0, eflags: 0x0
// Checksum 0x679fd9a3, Offset: 0x1ce8
// Size: 0x23a
function main() {
    level.callbackentityspawned = &entityspawned;
    level.callbacklocalclientconnect = &localclientconnect;
    level.var_8b2854b2 = 0;
    if (!isdefined(level.var_f22d5918)) {
        level.var_f22d5918 = "mobile";
    }
    level.orbis = getdvarstring("orbisGame") == "true";
    level.durango = getdvarstring("durangoGame") == "true";
    clientfield::register("world", "first_time_flow", 1, getminbitcountfornum(1), "int", &first_time_flow, 0, 1);
    clientfield::register("world", "cp_bunk_anim_type", 1, getminbitcountfornum(1), "int", &cp_bunk_anim_type, 0, 1);
    customclass::init();
    level.var_90b3cbac = 0;
    clientfield::register("actor", "zombie_has_eyes", 1, 1, "int", &zombie_eyes_clientfield_cb, 0, 1);
    level._effect["eye_glow"] = "zombie/fx_igc_glow_eye_orange_zod";
    level._effect["bgb_machine_available"] = "zombie/fx_bgb_machine_available_zmb";
    /#
        clientfield::register("<dev string:x28>", "<dev string:x2e>", 1, 1, "<dev string:x49>", undefined, 0, 1);
        clientfield::register("<dev string:x28>", "<dev string:x4d>", 1, 1, "<dev string:x49>", undefined, 0, 1);
    #/
    level thread blackscreen_watcher();
    setstreamerrequest(1, "core_frontend");
}

// Namespace frontend
// Params 7, eflags: 0x0
// Checksum 0xe268b18b, Offset: 0x1f30
// Size: 0x3a
function first_time_flow(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace frontend
// Params 7, eflags: 0x0
// Checksum 0x6bfee89f, Offset: 0x1f78
// Size: 0x3a
function cp_bunk_anim_type(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace frontend
// Params 1, eflags: 0x0
// Checksum 0xa5d18e7a, Offset: 0x1fc0
// Size: 0xd1a
function setupclientmenus(localclientnum) {
    lui::initmenudata(localclientnum);
    lui::createcustomcameramenu("Main", localclientnum, &lobby_main, 1);
    lui::createcustomextracamxcamdata("Main", localclientnum, 0, &function_1425cd9e);
    lui::createcustomextracamxcamdata("Main", localclientnum, 1, &function_3a284807);
    lui::createcustomextracamxcamdata("Main", localclientnum, 2, &function_c820d8cc);
    lui::createcustomextracamxcamdata("Main", localclientnum, 3, &function_ee235335);
    lui::createcameramenu("Inspection", localclientnum, "spawn_char_lobbyslide", "cac_main_lobby_camera_01", "cam1", undefined, &start_character_rotating, &end_character_rotating);
    lui::linktocustomcharacter("Inspection", localclientnum, "inspection_character");
    data_struct = lui::getcharacterdataformenu("Inspection", localclientnum);
    data_struct.var_418b6e8a = 1;
    lui::createcameramenu("CPConfirmSelection", localclientnum, "spawn_char_custom", "c_fe_confirm_selection_cam", "cam1", undefined, &open_choose_head_menu, &close_choose_head_menu);
    lui::addmenuexploders("CPConfirmSelection", localclientnum, array("char_customization", "char_custom_bg"));
    lui::linktocustomcharacter("CPConfirmSelection", localclientnum, "character_customization");
    lui::createcustomcameramenu("PersonalizeCharacter", localclientnum, &personalize_characters_watch, 0, &start_character_rotating, &end_character_rotating);
    lui::addmenuexploders("PersonalizeCharacter", localclientnum, array("char_customization", "char_custom_bg"));
    lui::linktocustomcharacter("PersonalizeCharacter", localclientnum, "character_customization");
    lui::createcameramenu("OutfitsMainMenu", localclientnum, "spawn_char_custom", "ui_cam_character_customization", "cam_preview");
    lui::addmenuexploders("OutfitsMainMenu", localclientnum, array("char_customization", "char_custom_bg"));
    lui::linktocustomcharacter("OutfitsMainMenu", localclientnum, "character_customization");
    lui::createcameramenu("ChooseOutfit", localclientnum, "spawn_char_custom", "ui_cam_character_customization", "cam_preview", undefined, &start_character_rotating, &end_character_rotating);
    lui::addmenuexploders("ChooseOutfit", localclientnum, array("char_customization", "char_custom_bg"));
    lui::linktocustomcharacter("ChooseOutfit", localclientnum, "character_customization");
    lui::createcameramenu("ChooseHead", localclientnum, "spawn_char_custom", "ui_cam_character_customization", "cam_helmet", undefined, &open_choose_head_menu, &close_choose_head_menu);
    lui::addmenuexploders("ChooseHead", localclientnum, array("char_customization", "char_custom_bg"));
    lui::linktocustomcharacter("ChooseHead", localclientnum, "character_customization");
    lui::createcameramenu("ChoosePersonalizationCharacter", localclientnum, "room2_frontend_camera", "ui_cam_char_selection_background", "cam1", undefined, &function_8d1a05f8, &function_ef0109fe);
    lui::createcustomextracamxcamdata("ChoosePersonalizationCharacter", localclientnum, 1, &function_b9b7c881);
    lui::linktocustomcharacter("ChoosePersonalizationCharacter", localclientnum, "character_customization");
    lui::createcameramenu("ChooseCharacterLoadout", localclientnum, "room2_frontend_camera", "ui_cam_char_selection_background", "cam1", undefined, &function_8d1a05f8, &function_ef0109fe);
    lui::linktocustomcharacter("ChooseCharacterLoadout", localclientnum, "character_customization");
    lui::createcameramenu("ChooseGender", localclientnum, "room2_frontend_camera", "ui_cam_char_selection_background", "cam1");
    lui::addmenuexploders("ChooseGender", localclientnum, array("char_customization", "char_custom_bg"));
    lui::linktocustomcharacter("ChooseGender", localclientnum, "character_customization");
    lui::createcameramenu("chooseClass", localclientnum, "spawn_char_cac_choose", "ui_cam_cac_specialist", "cam_specialist", undefined, &open_choose_class, &close_choose_class);
    lui::addmenuexploders("chooseClass", localclientnum, array("char_customization", "lights_paintshop", "weapon_kick", "char_custom_bg"));
    lui::linktocustomcharacter("chooseClass", localclientnum, "character_customization");
    lui::createcustomcameramenu("Paintshop", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("Paintshop", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("Gunsmith", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("Gunsmith", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("MyShowcase_Paintjobs", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("MyShowcase_Paintjobs", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("MyShowcase_Variants", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("MyShowcase_Variants", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("MyShowcase_Emblems", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("MyShowcase_Emblems", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("MyShowcase_CategorySelector", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("MyShowcase_CategorySelector", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("MediaManager", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("MediaManager", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcameramenu("WeaponBuildKits", localclientnum, "zm_weapon_position", "ui_cam_cac_specialist", "cam_specialist", undefined, &function_5f5f7f43, &function_baec4b95);
    lui::addmenuexploders("WeaponBuildKits", localclientnum, array("zm_weapon_kick", "zm_weapon_room"));
    lui::createcameramenu("BubblegumBuffs", localclientnum, "zm_loadout_position", "c_fe_zm_megachew_vign_camera_2", "c_fe_zm_megachew_vign_camera_2", undefined, &function_5f5f7f43, &function_baec4b95);
    lui::addmenuexploders("BubblegumBuffs", localclientnum, array("zm_gum_kick", "zm_gum_room", "zm_gumball_room_2"));
    playfx(localclientnum, level._effect["bgb_machine_available"], (-2542, 3996, 62) + (64, -1168, 0), anglestoforward((0, 330, 0)), anglestoup((0, 330, 0)));
    lui::createcameramenu("BubblegumPacks", localclientnum, "zm_loadout_position_shift", "c_fe_zm_megachew_vign_camera_2", "c_fe_zm_megachew_vign_camera_2");
    lui::addmenuexploders("BubblegumPacks", localclientnum, array("zm_gum_kick", "zm_gum_room", "zm_gumball_room_2"));
    lui::createcustomcameramenu("BubblegumPackEdit", localclientnum, undefined, undefined, &function_d4153501, &function_6069e673);
    lui::addmenuexploders("BubblegumPackEdit", localclientnum, array("zm_weapon_kick", "zm_weapon_room", "zm_gumball_room_3"));
    lui::createcustomcameramenu("BubblegumBuffSelect", localclientnum, undefined, undefined, &function_d4153501, &function_6069e673);
    lui::addmenuexploders("BubblegumBuffSelect", localclientnum, array("zm_weapon_kick", "zm_weapon_room", "zm_gumball_room_3"));
    lui::createcameramenu("MegaChewFactory", localclientnum, "zm_gum_position", "c_fe_zm_megachew_vign_camera", "default", undefined, &function_5f5f7f43, &function_baec4b95);
    lui::addmenuexploders("MegaChewFactory", localclientnum, array("zm_gum_kick", "zm_gum_room"));
    lui::createcameramenu("Pregame_Main", localclientnum, "character_frozen_moment_extracam1", "ui_cam_char_identity", "cam_bust", undefined, undefined, undefined);
    lui::createcameramenu("BlackMarket", localclientnum, "mp_frontend_blackmarket", "ui_cam_frontend_blackmarket", "cam_mpmain");
}

// Namespace frontend
// Params 7, eflags: 0x0
// Checksum 0x43b3d636, Offset: 0x2ce8
// Size: 0x108
function zombie_eyes_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(newval)) {
        return;
    }
    if (newval) {
        self createzombieeyes(localclientnum);
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, get_eyeball_on_luminance(), self get_eyeball_color());
    } else {
        self deletezombieeyes(localclientnum);
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, get_eyeball_off_luminance(), self get_eyeball_color());
    }
    if (isdefined(level.var_3ae99156)) {
        self [[ level.var_3ae99156 ]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    }
}

// Namespace frontend
// Params 0, eflags: 0x0
// Checksum 0x32623e64, Offset: 0x2df8
// Size: 0x18
function get_eyeball_on_luminance() {
    if (isdefined(level.eyeball_on_luminance_override)) {
        return level.eyeball_on_luminance_override;
    }
    return 1;
}

// Namespace frontend
// Params 0, eflags: 0x0
// Checksum 0xe8f9a5d1, Offset: 0x2e18
// Size: 0x17
function get_eyeball_off_luminance() {
    if (isdefined(level.eyeball_off_luminance_override)) {
        return level.eyeball_off_luminance_override;
    }
    return 0;
}

// Namespace frontend
// Params 0, eflags: 0x0
// Checksum 0x39fac69e, Offset: 0x2e38
// Size: 0x3a
function get_eyeball_color() {
    val = 0;
    if (isdefined(level.zombie_eyeball_color_override)) {
        val = level.zombie_eyeball_color_override;
    }
    if (isdefined(self.zombie_eyeball_color_override)) {
        val = self.zombie_eyeball_color_override;
    }
    return val;
}

// Namespace frontend
// Params 1, eflags: 0x0
// Checksum 0xaf3b2b5e, Offset: 0x2e80
// Size: 0x1a
function createzombieeyes(localclientnum) {
    self thread createzombieeyesinternal(localclientnum);
}

// Namespace frontend
// Params 1, eflags: 0x0
// Checksum 0x4afd27d1, Offset: 0x2ea8
// Size: 0x4a
function deletezombieeyes(localclientnum) {
    if (isdefined(self._eyearray)) {
        if (isdefined(self._eyearray[localclientnum])) {
            deletefx(localclientnum, self._eyearray[localclientnum], 1);
            self._eyearray[localclientnum] = undefined;
        }
    }
}

// Namespace frontend
// Params 1, eflags: 0x0
// Checksum 0x8da5d74a, Offset: 0x2f00
// Size: 0xcb
function createzombieeyesinternal(localclientnum) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self._eyearray)) {
        self._eyearray = [];
    }
    if (!isdefined(self._eyearray[localclientnum])) {
        linktag = "j_eyeball_le";
        effect = level._effect["eye_glow"];
        if (isdefined(level._override_eye_fx)) {
            effect = level._override_eye_fx;
        }
        if (isdefined(self._eyeglow_fx_override)) {
            effect = self._eyeglow_fx_override;
        }
        if (isdefined(self._eyeglow_tag_override)) {
            linktag = self._eyeglow_tag_override;
        }
        self._eyearray[localclientnum] = playfxontag(localclientnum, effect, self, linktag);
    }
}

// Namespace frontend
// Params 0, eflags: 0x0
// Checksum 0x5c2f6462, Offset: 0x2fd8
// Size: 0xed
function blackscreen_watcher() {
    blackscreenuimodel = createuimodel(getglobaluimodel(), "hideWorldForStreamer");
    setuimodelvalue(blackscreenuimodel, 1);
    while (true) {
        level waittill(#"streamer_change", data_struct);
        setuimodelvalue(blackscreenuimodel, 1);
        wait 0.1;
        while (true) {
            charready = 1;
            if (isdefined(data_struct)) {
                charready = character_customization::function_ddd0628f(data_struct);
            }
            sceneready = getstreamerrequestprogress(0) >= 100;
            if (charready && sceneready) {
                break;
            }
            wait 0.1;
        }
        setuimodelvalue(blackscreenuimodel, 0);
    }
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0x589aec3e, Offset: 0x30d0
// Size: 0x47
function streamer_change(hint, data_struct) {
    if (isdefined(hint)) {
        setstreamerrequest(0, hint);
    } else {
        clearstreamerrequest(0);
    }
    level notify(#"streamer_change", data_struct);
}

// Namespace frontend
// Params 3, eflags: 0x0
// Checksum 0x3013ccca, Offset: 0x3120
// Size: 0xea
function function_19f2b8a3(localclientnum, data_struct, changed) {
    fields = getcharacterfields(data_struct.characterindex, 1);
    if (isdefined(fields) && isdefined(fields.var_d0ff12a0) && isdefined(fields.var_4998666a)) {
        if (isdefined(fields.var_92636759) && changed) {
            streamer_change(fields.var_92636759, data_struct);
        }
        position = struct::get(fields.var_d0ff12a0);
        playmaincamxcam(localclientnum, fields.var_4998666a, 0, "", "", position.origin, position.angles);
    }
}

// Namespace frontend
// Params 1, eflags: 0x0
// Checksum 0xf93a17ad, Offset: 0x3218
// Size: 0x5d
function handle_inspect_player(localclientnum) {
    level endon(#"disconnect");
    while (true) {
        level waittill(#"inspect_player", xuid);
        assert(isdefined(xuid));
        level thread update_inspection_character(localclientnum, xuid);
    }
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0x7fb4d25, Offset: 0x3280
// Size: 0x34a
function update_inspection_character(localclientnum, xuid) {
    level endon(#"disconnect");
    level endon(#"inspect_player");
    customization = getcharactercustomizationforxuid(localclientnum, xuid);
    while (!isdefined(customization)) {
        customization = getcharactercustomizationforxuid(localclientnum, xuid);
        wait 1;
    }
    fields = getcharacterfields(customization.charactertype, customization.charactermode);
    params = spawnstruct();
    if (!isdefined(fields)) {
        fields = spawnstruct();
    }
    params.anim_name = "pb_cac_main_lobby_idle";
    s_scene = struct::get_script_bundle("scene", "sb_frontend_inspection");
    s_align = struct::get(s_scene.aligntarget, "targetname");
    s_params = spawnstruct();
    s_params.scene = s_scene.name;
    data_struct = lui::getcharacterdataformenu("Inspection", localclientnum);
    character_customization::set_character(data_struct, customization.charactertype);
    character_customization::set_character_mode(data_struct, customization.charactermode);
    character_customization::function_56dceb6(data_struct, customization.charactermode, customization.charactertype, customization.body.selectedindex, customization.body.colors);
    character_customization::function_5b80fae8(data_struct, customization.charactermode, customization.head);
    character_customization::function_5fa9d769(data_struct, customization.charactermode, customization.charactertype, customization.helmet.selectedindex, customization.helmet.colors);
    character_customization::function_f374c6fc(data_struct, customization.charactermode, localclientnum, xuid, customization.charactertype, customization.showcaseweapon.weaponname, customization.showcaseweapon.attachmentinfo, customization.showcaseweapon.weaponrenderoptions);
    if (isdefined(data_struct.anim_name)) {
        var_70df0eb8 = struct::get_script_bundle("scene", s_scene.name);
        if (var_70df0eb8.objects.size > 0) {
            var_70df0eb8.objects[0].mainanim = data_struct.anim_name;
        }
    }
    character_customization::update(localclientnum, data_struct, params);
    if (isdefined(data_struct.charactermodel)) {
        data_struct.charactermodel sethighdetail(1, 1);
    }
}

// Namespace frontend
// Params 1, eflags: 0x0
// Checksum 0x7e2df522, Offset: 0x35d8
// Size: 0xa
function entityspawned(localclientnum) {
    
}

// Namespace frontend
// Params 1, eflags: 0x0
// Checksum 0xc2c1e339, Offset: 0x35f0
// Size: 0x20f
function localclientconnect(localclientnum) {
    println("<dev string:x69>" + localclientnum);
    setupclientmenus(localclientnum);
    if (isdefined(level.charactercustomizationsetup)) {
        [[ level.charactercustomizationsetup ]](localclientnum);
    }
    if (isdefined(level.weaponcustomizationiconsetup)) {
        [[ level.weaponcustomizationiconsetup ]](localclientnum);
    }
    level.var_5b12555e = character_customization::function_b79cb078(getent(localclientnum, "customization", "targetname"), localclientnum);
    var_a33f21a6 = util::spawn_model(localclientnum, "tag_origin", (0, 0, 0));
    var_a33f21a6.targetname = "cp_lobby_player_model";
    level.var_74625f60 = character_customization::function_b79cb078(var_a33f21a6, localclientnum);
    character_customization::function_ea9faed5(localclientnum, level.var_74625f60, 0);
    var_a33f21a6 = util::spawn_model(localclientnum, "tag_origin", (0, 0, 0));
    var_a33f21a6.targetname = "zm_lobby_player_model";
    level.var_647ea5fa = character_customization::function_b79cb078(var_a33f21a6, localclientnum);
    callback::callback(#"hash_da8d7d74", localclientnum);
    customclass::localclientconnect(localclientnum);
    level thread handle_inspect_player(localclientnum);
    customclass::hide_paintshop_bg(localclientnum);
    globalmodel = getglobaluimodel();
    roommodel = createuimodel(globalmodel, "lobbyRoot.room");
    room = getuimodelvalue(roommodel);
    enablefrontendstreamingoverlay(localclientnum, 1);
    level.frontendclientconnected = 1;
    level notify(#"menu_change", "Main", "opened", room);
}

// Namespace frontend
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x3808
// Size: 0x2
function onprecachegametype() {
    
}

// Namespace frontend
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x3818
// Size: 0x2
function onstartgametype() {
    
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0xbfe85501, Offset: 0x3828
// Size: 0x32
function open_choose_class(localclientnum, menu_data) {
    level thread character_customization::rotation_thread_spawner(localclientnum, menu_data.custom_character, "choose_class_closed");
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0xbc990076, Offset: 0x3868
// Size: 0x2b
function close_choose_class(localclientnum, menu_data) {
    enablefrontendlockedweaponoverlay(localclientnum, 0);
    level notify(#"choose_class_closed");
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0xaad15766, Offset: 0x38a0
// Size: 0x42
function function_d4153501(localclientnum, menu_data) {
    enablefrontendstreamingoverlay(localclientnum, 1);
    level.weapon_position = struct::get("zm_loadout_gumball");
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0x87d3330f, Offset: 0x38f0
// Size: 0x32
function function_6069e673(localclientnum, menu_data) {
    level.weapon_position = struct::get("paintshop_weapon_position");
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0xf2ecfa43, Offset: 0x3930
// Size: 0xfa
function function_5f5f7f43(localclientnum, menu_data) {
    enablefrontendstreamingoverlay(localclientnum, 1);
    level.var_6eb4dd6e = getdvarint("r_maxSpotShadowUpdates");
    setdvar("r_maxSpotShadowUpdates", 24);
    level.weapon_position = struct::get(menu_data.target_name);
    playradiantexploder(localclientnum, "zm_gum_room");
    playradiantexploder(localclientnum, "zm_gum_kick");
    if (!isdefined(level.var_b15bae32)) {
        level.var_b15bae32 = new cmegachewfactory();
        [[ level.var_b15bae32 ]]->init(localclientnum);
    }
    level thread function_8732c6a1(localclientnum, menu_data);
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0xf13d28c, Offset: 0x3a38
// Size: 0x92
function function_baec4b95(localclientnum, menu_data) {
    level.weapon_position = struct::get("paintshop_weapon_position");
    killradiantexploder(localclientnum, "zm_gum_room");
    killradiantexploder(localclientnum, "zm_gum_kick");
    setdvar("r_maxSpotShadowUpdates", level.var_6eb4dd6e);
    enablefrontendlockedweaponoverlay(localclientnum, 0);
}

// Namespace frontend
// Params 1, eflags: 0x0
// Checksum 0x4cccf064, Offset: 0x3ad8
// Size: 0x52
function function_b254ba02(localclientnum) {
    var_e8a29b7c = getuimodel(getuimodelforcontroller(localclientnum), "MegaChewFactory.disableInput");
    setuimodelvalue(var_e8a29b7c, 1);
}

// Namespace frontend
// Params 1, eflags: 0x0
// Checksum 0xe7248fdd, Offset: 0x3b38
// Size: 0x6a
function function_8519a971(localclientnum) {
    level util::waittill_any_timeout(17, "megachew_factory_cycle_complete");
    var_e8a29b7c = getuimodel(getuimodelforcontroller(localclientnum), "MegaChewFactory.disableInput");
    setuimodelvalue(var_e8a29b7c, 0);
}

// Namespace frontend
// Params 1, eflags: 0x0
// Checksum 0x3faf20f1, Offset: 0x3bb0
// Size: 0x79
function function_797567e3(localclientnum) {
    level endon(#"hash_8732c6a1");
    level endon(#"disconnect");
    level endon(#"hash_34999717");
    while (true) {
        level waittill(#"hash_94d147b7", var_971a0262);
        if (var_971a0262 > 999) {
            var_971a0262 = 999;
        }
        [[ level.var_b15bae32 ]]->function_f02acef4(var_971a0262);
        [[ level.var_b15bae32 ]]->function_1fdaf4e2(localclientnum, 1);
    }
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0x2bd4c110, Offset: 0x3c38
// Size: 0x13d
function function_8732c6a1(localclientnum, menu_data) {
    level notify(#"hash_8732c6a1");
    level endon(#"hash_8732c6a1");
    level endon(#"disconnect");
    level endon(#"hash_34999717");
    [[ level.var_b15bae32 ]]->function_9111df18(localclientnum, 0);
    level thread function_797567e3(localclientnum);
    while (true) {
        level waittill(#"hash_7f3572a1", event, index, var_206dbebc);
        switch (event) {
        case "focus_changed":
            [[ level.var_b15bae32 ]]->function_2b1651c(localclientnum, index);
            break;
        case "selected":
            /#
                iprintlnbold("<dev string:x96>" + index);
                println("<dev string:x96>" + index);
            #/
            break;
        case "purchased":
            function_b254ba02(localclientnum);
            thread function_8519a971(localclientnum);
            [[ level.var_b15bae32 ]]->activate(localclientnum, index);
            break;
        }
    }
}

#namespace cmegachewfactory;

// Namespace cmegachewfactory
// Params 1, eflags: 0x0
// Checksum 0x3f2f08f6, Offset: 0x3d80
// Size: 0xad2
function init(localclientnum) {
    self.m_a_str_megachew_factory_door_flags = [];
    self.m_a_str_megachew_factory_result_flags = [];
    self.m_a_mdl_domes = [];
    self.m_a_mdl_bodies = [];
    self.m_a_mdl_doors = [];
    var_a156e3de = [];
    self.m_a_mdl_balls = [];
    self.m_uimodel_instructions = createuimodel(getglobaluimodel(), "MegaChewLabelInstructions");
    self.m_a_uimodel_megachew = [];
    self.m_a_uimodel_megachew[0] = createuimodel(getglobaluimodel(), "MegaChewLabelLeft");
    self.m_a_uimodel_megachew[1] = createuimodel(getglobaluimodel(), "MegaChewLabelMiddle");
    self.m_a_uimodel_megachew[2] = createuimodel(getglobaluimodel(), "MegaChewLabelRight");
    function_abb52ef2(localclientnum);
    self.m_a_mdl_gearbox = getentarray(localclientnum, "ambient_gearbox", "targetname");
    foreach (var_f13fd0e7 in self.m_a_mdl_gearbox) {
        var_f13fd0e7 useanimtree(#generic);
    }
    self.m_a_mdl_gear = getentarray(localclientnum, "ambient_gear", "targetname");
    foreach (var_98d6609c in self.m_a_mdl_gear) {
        var_98d6609c useanimtree(#generic);
    }
    self.m_mdl_tube_front = getent(localclientnum, "tube_front", "targetname");
    self.m_mdl_tube_front useanimtree(#generic);
    level._effect["megachew_gumball_poof_out"] = "ui/fx_megachew_ball_poof_01";
    level._effect["megachew_gumball_poof_blue"] = "ui/fx_megachew_ball_poof_blue";
    level._effect["megachew_gumball_poof_green"] = "ui/fx_megachew_ball_poof_green";
    level._effect["megachew_gumball_poof_orange"] = "ui/fx_megachew_ball_poof_orange";
    level._effect["megachew_gumball_poof_purple"] = "ui/fx_megachew_ball_poof_purple";
    level._effect["megachew_gumball_power_boost"] = "ui/fx_megachew_ball_power_boost";
    level._effect["megachew_vat_electrode_lg"] = "ui/fx_megachew_vat_electrode_lg_loop";
    level._effect["megachew_vat_electrode_sm"] = "ui/fx_megachew_vat_electrode_sm_loop";
    level._effect["megachew_vat_light_lg"] = "ui/fx_megachew_vat_light_lg_loop";
    level._effect["megachew_vat_light_sm"] = "ui/fx_megachew_vat_light_sm_loop";
    level._effect["megachew_vat_whistle"] = "ui/fx_megachew_vat_whistle_loop";
    level._effect["megachew_vat_electrode_center_lg"] = "ui/fx_megachew_vat_electrode_center_lg_loop";
    level._effect["megachew_vat_electrode_center_sm"] = "ui/fx_megachew_vat_electrode_center_sm_loop";
    level._effect["megachew_vat_electrode_surge_lg"] = "ui/fx_megachew_vat_electrode_surge_lg";
    level._effect["megachew_vat_electrode_surge_sm"] = "ui/fx_megachew_vat_electrode_surge_sm";
    level._effect["megachew_vat_whistle_sm"] = "ui/fx_megachew_vat_whistle_sm_loop";
    level._effect["ui/fx_megachew_ball_divinium"] = "ui/fx_megachew_ball_divinium";
    level._effect["ui/fx_megachew_ball_double"] = "ui/fx_megachew_ball_double";
    level._effect["ui/fx_megachew_ball_power_boost"] = "ui/fx_megachew_ball_power_boost";
    level._effect["ui/fx_megachew_ball_divinium"] = "ui/fx_megachew_ball_divinium";
    level._effect["ui/fx_megachew_ball_double"] = "ui/fx_megachew_ball_double";
    level._effect["ui/fx_megachew_ball_power_boost"] = "ui/fx_megachew_ball_power_boost";
    level flag::init("megachew_sequence_active");
    if (!isdefined(self.m_a_o_megachewcarousels)) {
        self.m_a_o_megachewcarousels = [];
        for (i = 0; i < 3; i++) {
            if (!isdefined(self.m_a_o_megachewcarousels[i])) {
                self.m_a_o_megachewcarousels[i] = new class_7c51d14d();
                [[ self.m_a_o_megachewcarousels[i] ]]->init(localclientnum, i + 1);
            }
        }
    }
    if (!isdefined(self.m_a_o_megachewvat)) {
        self.m_a_o_megachewvat = [];
        for (i = 0; i < 3; i++) {
            if (!isdefined(self.m_a_o_megachewvat[i])) {
                self.m_a_o_megachewvat[i] = new class_67b49468();
                [[ self.m_a_o_megachewvat[i] ]]->init(localclientnum, i + 1);
            }
        }
    }
    if (!isdefined(self.m_a_o_megachewvatdialset)) {
        self.m_a_o_megachewvatdialset = [];
        for (i = 0; i < 3; i++) {
            if (!isdefined(self.m_a_o_megachewvatdialset[i])) {
                self.m_a_o_megachewvatdialset[i] = new class_2a92124e();
                [[ self.m_a_o_megachewvatdialset[i] ]]->init(localclientnum, i + 1);
            }
        }
    }
    if (!isdefined(self.m_o_megachewbuttons)) {
        self.m_o_megachewbuttons = new class_513a44f6();
        [[ self.m_o_megachewbuttons ]]->init(localclientnum);
    }
    if (!isdefined(self.m_o_megachewcounter)) {
        self.m_o_megachewcounter = new class_cc6fa95d();
        [[ self.m_o_megachewcounter ]]->init(localclientnum);
    }
    for (i = 1; i <= 3; i++) {
        var_d4d80499 = "megachew_factory_door_" + i + "_anim_done";
        if (!isdefined(self.m_a_str_megachew_factory_door_flags)) {
            self.m_a_str_megachew_factory_door_flags = [];
        } else if (!isarray(self.m_a_str_megachew_factory_door_flags)) {
            self.m_a_str_megachew_factory_door_flags = array(self.m_a_str_megachew_factory_door_flags);
        }
        self.m_a_str_megachew_factory_door_flags[self.m_a_str_megachew_factory_door_flags.size] = var_d4d80499;
        level flag::init(var_d4d80499);
        var_263dadfc = getent(localclientnum, "bgb_0" + i + "_dome", "targetname");
        if (!var_263dadfc hasanimtree()) {
            var_263dadfc useanimtree(#generic);
        }
        if (!isdefined(self.m_a_mdl_domes)) {
            self.m_a_mdl_domes = [];
        } else if (!isarray(self.m_a_mdl_domes)) {
            self.m_a_mdl_domes = array(self.m_a_mdl_domes);
        }
        self.m_a_mdl_domes[self.m_a_mdl_domes.size] = var_263dadfc;
        mdl_body = getent(localclientnum, "bgb_0" + i + "_body", "targetname");
        if (!mdl_body hasanimtree()) {
            mdl_body useanimtree(#generic);
        }
        if (!isdefined(self.m_a_mdl_bodies)) {
            self.m_a_mdl_bodies = [];
        } else if (!isarray(self.m_a_mdl_bodies)) {
            self.m_a_mdl_bodies = array(self.m_a_mdl_bodies);
        }
        self.m_a_mdl_bodies[self.m_a_mdl_bodies.size] = mdl_body;
        mdl_door = getent(localclientnum, "main_doors_0" + i, "targetname");
        if (!mdl_door hasanimtree()) {
            mdl_door useanimtree(#generic);
        }
        if (!isdefined(self.m_a_mdl_doors)) {
            self.m_a_mdl_doors = [];
        } else if (!isarray(self.m_a_mdl_doors)) {
            self.m_a_mdl_doors = array(self.m_a_mdl_doors);
        }
        self.m_a_mdl_doors[self.m_a_mdl_doors.size] = mdl_door;
    }
    for (i = 0; i < 6; i++) {
        var_134fb6ff = "tube_ball_" + i;
        mdl_ball = getent(localclientnum, var_134fb6ff, "targetname");
        mdl_ball hidepart(localclientnum, "tag_ball_" + i);
        if (!mdl_ball hasanimtree()) {
            mdl_ball useanimtree(#generic);
        }
        if (!isdefined(self.m_a_mdl_balls)) {
            self.m_a_mdl_balls = [];
        } else if (!isarray(self.m_a_mdl_balls)) {
            self.m_a_mdl_balls = array(self.m_a_mdl_balls);
        }
        self.m_a_mdl_balls[self.m_a_mdl_balls.size] = mdl_ball;
        var_fd4ab0c8 = "megachew_factory_result_" + i + "_anim_done";
        if (!isdefined(self.m_a_str_megachew_factory_result_flags)) {
            self.m_a_str_megachew_factory_result_flags = [];
        } else if (!isarray(self.m_a_str_megachew_factory_result_flags)) {
            self.m_a_str_megachew_factory_result_flags = array(self.m_a_str_megachew_factory_result_flags);
        }
        self.m_a_str_megachew_factory_result_flags[self.m_a_str_megachew_factory_result_flags.size] = var_fd4ab0c8;
        level flag::init(var_fd4ab0c8);
    }
    level flag::init("megachew_carousel_show_result");
    self thread function_9111df18(localclientnum, 0);
    function_2b1651c(localclientnum, 0);
}

// Namespace cmegachewfactory
// Params 1, eflags: 0x0
// Checksum 0xc3d55cd9, Offset: 0x4860
// Size: 0x12
function function_f02acef4(var_971a0262) {
    self.m_n_tokens_remaining = var_971a0262;
}

// Namespace cmegachewfactory
// Params 2, eflags: 0x0
// Checksum 0x542fc575, Offset: 0x4880
// Size: 0x4e
function function_1fdaf4e2(localclientnum, var_d9cd47bf) {
    if (!isdefined(var_d9cd47bf)) {
        var_d9cd47bf = 0;
    }
    [[ self.m_o_megachewcounter ]]->function_ce2f631(localclientnum, self.m_n_tokens_remaining);
    if (var_d9cd47bf) {
        [[ self.m_o_megachewcounter ]]->function_aa6d32cd(localclientnum);
    }
}

// Namespace cmegachewfactory
// Params 2, eflags: 0x0
// Checksum 0x78a06d3f, Offset: 0x48d8
// Size: 0x52
function function_2b1651c(localclientnum, var_4d37bbe9) {
    [[ self.m_o_megachewbuttons ]]->function_2b1651c(localclientnum, var_4d37bbe9);
    setuimodelvalue(self.m_uimodel_instructions, "ZMUI_MEGACHEW_" + var_4d37bbe9 + 1 + "_TOKEN");
}

// Namespace cmegachewfactory
// Params 2, eflags: 0x0
// Checksum 0x89ea5a50, Offset: 0x4938
// Size: 0x85
function activate(localclientnum, var_4d37bbe9) {
    level flag::set("megachew_sequence_active");
    self.m_n_tokens_spent = var_4d37bbe9;
    self.m_a_vat_contents = array(undefined, undefined, undefined);
    level flag::clear("megachew_carousel_show_result");
    InvalidOpCode(0xb5, self.m_o_megachewcounter, localclientnum, 1);
    // Unknown operator (0xb5, t7_1b, PC)
}

// Namespace cmegachewfactory
// Params 1, eflags: 0x0
// Checksum 0x7c7338fc, Offset: 0x4ca8
// Size: 0x3d
function rumble_loop(localclientnum) {
    while (true) {
        playrumbleonposition(localclientnum, "damage_light", (-3243, 2521, 101));
        wait 0.1;
    }
}

// Namespace cmegachewfactory
// Params 1, eflags: 0x0
// Checksum 0x36167620, Offset: 0x4cf0
// Size: 0x59
function function_abb52ef2(localclientnum) {
    for (i = 0; i < 3; i++) {
        setuimodelvalue(self.m_a_uimodel_megachew[i], "");
        function_c8a456c2(localclientnum, i + 1, 0);
    }
}

// Namespace cmegachewfactory
// Params 2, eflags: 0x0
// Checksum 0x1d95716f, Offset: 0x4d58
// Size: 0x11b
function function_d15f1610(var_65daa900, var_332d5ba9) {
    switch (self.m_a_vat_contents[var_65daa900]) {
    case "power_boost":
        var_881e36c1 = "p7_zm_bgb_wildcard_boost" + "_large";
        break;
    case "doubler":
        var_881e36c1 = "p7_zm_bgb_wildcard_2x" + "_large";
        break;
    case "free_token":
        if (var_332d5ba9) {
            var_881e36c1 = "p7_zm_bgb_wildcard_vial" + "_large";
        } else {
            var_881e36c1 = "p7_zm_bgb_wildcard_vial" + "_small";
        }
        break;
    default:
        var_123b4aed = tablelookup("gamedata/stats/zm/zm_statstable.csv", 0, self.m_a_vat_contents[var_65daa900], 4);
        if (var_332d5ba9) {
            var_881e36c1 = "p7_" + var_123b4aed + "_ui_large";
        } else {
            var_881e36c1 = "p7_" + var_123b4aed + "_ui_small";
        }
        break;
    }
    return var_881e36c1;
}

// Namespace cmegachewfactory
// Params 0, eflags: 0x0
// Checksum 0xbb15887a, Offset: 0x4e80
// Size: 0xcf
function function_5c92770() {
    n_roll = randomint(100);
    if (n_roll < 85) {
        var_123b4aed = tablelookup("gamedata/stats/zm/zm_statstable.csv", 0, randomintrange(-40, -22), 4);
        var_881e36c1 = "p7_" + var_123b4aed + "_ui_large";
    } else if (n_roll < 90) {
        var_881e36c1 = "p7_zm_bgb_wildcard_vial" + "_large";
    } else if (n_roll < 95) {
        var_881e36c1 = "p7_zm_bgb_wildcard_2x" + "_large";
    } else {
        var_881e36c1 = "p7_zm_bgb_wildcard_boost" + "_large";
    }
    return var_881e36c1;
}

// Namespace cmegachewfactory
// Params 1, eflags: 0x0
// Checksum 0x36e886e1, Offset: 0x4f58
// Size: 0x39
function function_670a0ffe(var_65daa900) {
    if (function_8092a3a4(var_65daa900) && function_8dd5b778(var_65daa900)) {
        return true;
    }
    return false;
}

// Namespace cmegachewfactory
// Params 1, eflags: 0x0
// Checksum 0x99810132, Offset: 0x4fa0
// Size: 0x39
function function_8092a3a4(var_65daa900) {
    if (self.m_a_vat_contents[var_65daa900] === "power_boost") {
        return false;
    }
    if (self.m_a_vat_contents[var_65daa900] === "doubler") {
        return false;
    }
    return true;
}

// Namespace cmegachewfactory
// Params 1, eflags: 0x0
// Checksum 0x828ded3, Offset: 0x4fe8
// Size: 0x31
function function_8dd5b778(var_65daa900) {
    if (isdefined(self.m_b_power_boost) && (var_65daa900 < self.m_n_tokens_spent || self.m_b_power_boost)) {
        return true;
    }
    return false;
}

// Namespace cmegachewfactory
// Params 1, eflags: 0x0
// Checksum 0x3b7a2354, Offset: 0x5028
// Size: 0xa
function function_aa29ec18(var_65daa900) {
    
}

// Namespace cmegachewfactory
// Params 1, eflags: 0x0
// Checksum 0x519ed6d9, Offset: 0x5040
// Size: 0x322
function function_eaf86658(localclientnum) {
    self.m_n_result_ball_count = 0;
    var_5625771d = 0;
    for (var_65daa900 = 1; var_65daa900 <= 3; var_65daa900++) {
        str_model = function_d15f1610(var_65daa900 - 1, 0);
        if (self.m_a_vat_contents[var_65daa900 - 1] === "power_boost") {
            continue;
        }
        if (self.m_a_vat_contents[var_65daa900 - 1] === "doubler") {
            continue;
        }
        if (var_65daa900 <= self.m_n_tokens_spent || self.m_b_power_boost) {
            var_985bc9c2 = pow(2, self.m_n_doubler_count);
            for (i = 0; i < var_985bc9c2; i++) {
                str_notify = "megachew_factory_cycle_complete";
                mdl_ball = self.m_a_mdl_balls[self.m_n_result_ball_count];
                var_263dadfc = self.m_a_mdl_domes[var_65daa900 - 1];
                self thread function_98591098(mdl_ball, str_model, "tag_ball_" + self.m_n_result_ball_count, str_notify);
                self thread function_98591098(var_263dadfc, str_model, "tag_ball_" + i, str_notify);
                self.m_n_result_ball_count = self.m_n_result_ball_count + 1;
            }
            if (self.m_a_vat_contents[var_65daa900 - 1] !== "free_token") {
                var_5625771d += 1;
                switch (var_5625771d) {
                case 1:
                    var_1363d019 = getuimodel(getuimodelforcontroller(localclientnum), "MegaChewFactory.bgbs.bgb0");
                    break;
                case 2:
                    var_1363d019 = getuimodel(getuimodelforcontroller(localclientnum), "MegaChewFactory.bgbs.bgb1");
                    break;
                case 3:
                    var_1363d019 = getuimodel(getuimodelforcontroller(localclientnum), "MegaChewFactory.bgbs.bgb2");
                    break;
                }
                var_edb87775 = getuimodel(var_1363d019, "index");
                var_a340ec8e = getuimodel(var_1363d019, "count");
                setuimodelvalue(var_edb87775, self.m_a_vat_contents[var_65daa900 - 1]);
                setuimodelvalue(var_a340ec8e, var_985bc9c2);
            }
        }
    }
    if (var_5625771d > 0) {
        var_54ceae01 = getuimodel(getuimodelforcontroller(localclientnum), "MegaChewFactory.bgbs.count");
        setuimodelvalue(var_54ceae01, var_5625771d);
    }
}

// Namespace cmegachewfactory
// Params 4, eflags: 0x0
// Checksum 0xf78b65ae, Offset: 0x5370
// Size: 0xb6
function function_98591098(mdl_base, var_68ee4eae, str_tag, str_notify) {
    if (!isdefined(mdl_base.var_d6b40191)) {
        mdl_base.var_d6b40191 = [];
    }
    if (isdefined(mdl_base.var_d6b40191[str_tag])) {
        mdl_base detach(mdl_base.var_9dd0a3f1, str_tag);
    }
    mdl_base attach(var_68ee4eae, str_tag);
    mdl_base.var_9dd0a3f1[str_tag] = var_68ee4eae;
    level waittill(str_notify);
    mdl_base detach(var_68ee4eae, str_tag);
    mdl_base.var_9dd0a3f1[str_tag] = undefined;
}

// Namespace cmegachewfactory
// Params 2, eflags: 0x0
// Checksum 0x4eb8fbdb, Offset: 0x5430
// Size: 0x591
function function_9111df18(localclientnum, var_dda27c05) {
    switch (var_dda27c05) {
    case 0:
        self.m_b_power_boost = 0;
        function_abb52ef2(localclientnum);
        self thread function_391d29bf(localclientnum, 0);
        function_28c320ea(localclientnum, 0);
        for (i = 1; i <= 3; i++) {
            [[ self.m_a_o_megachewvat[i - 1] ]]->function_62f4b701(localclientnum, 0, 0);
            [[ self.m_a_o_megachewvatdialset[i - 1] ]]->function_f9042a9d(0);
        }
        break;
    case 1:
        self thread show_random_starting_gumballs_on_carousels(localclientnum);
        for (i = 0; i < 3; i++) {
            var_467a5275 = function_8dd5b778(i);
            [[ self.m_a_o_megachewvat[i] ]]->function_62f4b701(localclientnum, 1, var_467a5275);
            [[ self.m_a_o_megachewvatdialset[i] ]]->function_f9042a9d(var_467a5275);
        }
        self thread function_391d29bf(localclientnum, 1);
        wait 0.2;
        for (i = 1; i <= 3; i++) {
            self thread function_afb1aa26(localclientnum, i, var_dda27c05);
        }
        for (i = 1; i <= 3; i++) {
            self thread set_megachew_factory_carousel_anim_state(localclientnum, i, var_dda27c05);
        }
        wait 0.2;
        function_28c320ea(localclientnum, 1);
        break;
    case 2:
        level flag::set("megachew_carousel_show_result");
        for (i = 1; i <= 3; i++) {
            self thread function_afb1aa26(localclientnum, i, 2);
            self thread set_megachew_factory_carousel_anim_state(localclientnum, i, var_dda27c05);
            if (function_670a0ffe(i - 1)) {
                InvalidOpCode(0xb5, self.m_a_o_megachewvat[i - 1], localclientnum);
                // Unknown operator (0xb5, t7_1b, PC)
            }
        }
        self thread function_391d29bf(localclientnum, 2);
        wait 0.25;
        for (i = 0; i < 3; i++) {
            [[ self.m_a_o_megachewvat[i] ]]->function_d9405817(localclientnum, 0);
            [[ self.m_a_o_megachewvatdialset[i] ]]->function_f9042a9d(0);
        }
        wait 0.25;
        function_a81cf932(localclientnum);
        if (self.m_b_power_boost) {
            wait 0.125;
            for (i = 0; i < 3; i++) {
                [[ self.m_a_o_megachewvat[i] ]]->function_62f4b701(localclientnum, 0, 1);
                [[ self.m_a_o_megachewvatdialset[i] ]]->function_f9042a9d(1);
            }
        }
        for (i = 1; i <= 3; i++) {
            [[ self.m_a_o_megachewvat[i - 1] ]]->function_75246ac0(localclientnum, 0);
        }
        for (i = 1; i <= 3; i++) {
            if (function_670a0ffe(i - 1)) {
                [[ self.m_a_o_megachewvatdialset[i - 1] ]]->function_35919adb(0);
                self thread function_afb1aa26(localclientnum, i, 3);
            }
        }
        wait 0.5;
        self thread function_6484d763(localclientnum);
        wait 0.25;
        function_28c320ea(localclientnum, 0);
        wait 0.5;
        for (i = 1; i <= 3; i++) {
            if (function_670a0ffe(i - 1)) {
                self thread function_afb1aa26(localclientnum, i, 4);
            }
        }
        wait 0.25;
        for (i = 1; i <= 3; i++) {
            if (function_670a0ffe(i - 1)) {
                self thread function_afb1aa26(localclientnum, i, 5);
            }
        }
        for (i = 1; i <= 3; i++) {
            if (function_670a0ffe(i - 1)) {
                [[ self.m_a_o_megachewvatdialset[i - 1] ]]->function_35919adb(1);
            }
        }
        for (i = 0; i < 3; i++) {
            [[ self.m_a_o_megachewvat[i] ]]->function_205cc563(localclientnum, 0);
        }
        for (i = 0; i < 3; i++) {
            [[ self.m_a_o_megachewcarousels[i] ]]->function_ecd47aa9();
        }
        break;
    case 3:
        level flag::set("megachew_carousel_show_result");
        self thread function_391d29bf(localclientnum, 2);
        function_28c320ea(localclientnum, 0);
        for (i = 1; i <= 3; i++) {
            self thread set_megachew_factory_carousel_anim_state(localclientnum, i, var_dda27c05);
            self thread function_afb1aa26(localclientnum, i, 2);
        }
        for (i = 0; i < 3; i++) {
            [[ self.m_a_o_megachewcarousels[i] ]]->function_ecd47aa9();
        }
        break;
    }
}

// Namespace cmegachewfactory
// Params 2, eflags: 0x0
// Checksum 0xad14fb9f, Offset: 0x59d0
// Size: 0x2bb
function function_391d29bf(localclientnum, var_48d243ae) {
    switch (var_48d243ae) {
    case 0:
        var_d9508af5 = "p7_fxanim_zm_bgb_gears_idle_anim";
        var_98e65d7c = "p7_fxanim_zm_bgb_gear_01_idle_anim";
        var_df72b01b = "p7_fxanim_zm_bgb_gears_end_anim";
        var_6a05bb84 = "p7_fxanim_zm_bgb_gear_01_end_anim";
        break;
    case 1:
        var_d9508af5 = "p7_fxanim_zm_bgb_gears_active_anim";
        var_98e65d7c = "p7_fxanim_zm_bgb_gear_01_active_anim";
        var_df72b01b = "p7_fxanim_zm_bgb_gears_idle_anim";
        var_6a05bb84 = "p7_fxanim_zm_bgb_gear_01_idle_anim";
        break;
    case 2:
        var_d9508af5 = "p7_fxanim_zm_bgb_gears_end_anim";
        var_98e65d7c = "p7_fxanim_zm_bgb_gear_01_end_anim";
        var_df72b01b = "p7_fxanim_zm_bgb_gears_active_anim";
        var_6a05bb84 = "p7_fxanim_zm_bgb_gear_01_active_anim";
        break;
    }
    if (var_48d243ae === 2) {
        foreach (var_f13fd0e7 in self.m_a_mdl_gearbox) {
            self thread function_c7a5623d(var_f13fd0e7, var_df72b01b, "p7_fxanim_zm_bgb_gears_end_anim", "p7_fxanim_zm_bgb_gears_idle_anim");
        }
        foreach (var_98d6609c in self.m_a_mdl_gear) {
            self thread function_c7a5623d(var_98d6609c, var_df72b01b, "p7_fxanim_zm_bgb_gear_01_end_anim", "p7_fxanim_zm_bgb_gear_01_idle_anim");
        }
        return;
    }
    foreach (var_f13fd0e7 in self.m_a_mdl_gearbox) {
        var_f13fd0e7 clearanim(var_df72b01b, 0.1);
        var_f13fd0e7 thread animation::play(var_d9508af5, undefined, undefined, 1, 0.1);
    }
    foreach (var_98d6609c in self.m_a_mdl_gear) {
        var_98d6609c clearanim(var_6a05bb84, 0.1);
        var_98d6609c thread animation::play(var_98e65d7c, undefined, undefined, 1, 0.1);
    }
}

// Namespace cmegachewfactory
// Params 4, eflags: 0x0
// Checksum 0x9c37c6e3, Offset: 0x5c98
// Size: 0x7a
function function_c7a5623d(mdl_model, var_3dbb27c6, var_43899630, var_8930339) {
    mdl_model clearanim(var_3dbb27c6, 0.1);
    mdl_model animation::play(var_43899630, undefined, undefined, 1, 0.1);
    mdl_model thread animation::play(var_8930339, undefined, undefined, 1, 0.1);
}

// Namespace cmegachewfactory
// Params 1, eflags: 0x0
// Checksum 0xb117906f, Offset: 0x5d20
// Size: 0x2bd
function function_6484d763(localclientnum) {
    for (i = 0; i < 3; i++) {
        var_62ad21f3 = function_670a0ffe(i);
        if (var_62ad21f3) {
            if (self.m_a_vat_contents[i] === "free_token") {
                self thread function_5bb9a8c3(i + 1, "2");
                InvalidOpCode(0xb5, self.m_a_o_megachewcarousels[i], localclientnum, level._effect["ui/fx_megachew_ball_power_boost"], "tag_ball_0", 1);
                // Unknown operator (0xb5, t7_1b, PC)
            }
            var_477f7b08 = tablelookup("gamedata/stats/zm/zm_statstable.csv", 0, self.m_a_vat_contents[i], 17);
            self thread function_5bb9a8c3(i + 1, var_477f7b08);
            switch (var_477f7b08) {
            case "0":
                InvalidOpCode(0xb5, self.m_a_o_megachewcarousels[i], localclientnum, level._effect["megachew_gumball_poof_purple"]);
                // Unknown operator (0xb5, t7_1b, PC)
            case "1":
                InvalidOpCode(0xb5, self.m_a_o_megachewcarousels[i], localclientnum, level._effect["megachew_gumball_poof_orange"]);
                // Unknown operator (0xb5, t7_1b, PC)
            case "2":
                InvalidOpCode(0xb5, self.m_a_o_megachewcarousels[i], localclientnum, level._effect["megachew_gumball_poof_blue"]);
                // Unknown operator (0xb5, t7_1b, PC)
            case "3":
                InvalidOpCode(0xb5, self.m_a_o_megachewcarousels[i], localclientnum, level._effect["megachew_gumball_poof_green"]);
                // Unknown operator (0xb5, t7_1b, PC)
            }
            [[ self.m_a_o_megachewcarousels[i] ]]->function_ecd47aa9();
            continue;
        }
        if (function_8dd5b778(i)) {
            if (self.m_a_vat_contents[i] === "power_boost") {
                self thread function_5bb9a8c3(i + 1, "2");
                InvalidOpCode(0xb5, self.m_a_o_megachewcarousels[i], localclientnum, level._effect["ui/fx_megachew_ball_divinium"], "tag_ball_0", 1);
                // Unknown operator (0xb5, t7_1b, PC)
            }
            if (self.m_a_vat_contents[i] === "doubler") {
                self thread function_5bb9a8c3(i + 1, "2");
                InvalidOpCode(0xb5, self.m_a_o_megachewcarousels[i], localclientnum, level._effect["ui/fx_megachew_ball_double"], "tag_ball_0", 1);
                // Unknown operator (0xb5, t7_1b, PC)
            }
            [[ self.m_a_o_megachewcarousels[i] ]]->function_ecd47aa9();
        }
    }
}

// Namespace cmegachewfactory
// Params 2, eflags: 0x0
// Checksum 0x84d9e0ce, Offset: 0x5fe8
// Size: 0xaa
function function_5bb9a8c3(var_65daa900, var_477f7b08) {
    switch (var_477f7b08) {
    case "0":
        var_a58a7b24 = "zm_gumball_purple_machine_";
        break;
    case "1":
        var_a58a7b24 = "zm_gumball_orange_machine_";
        break;
    case "2":
        var_a58a7b24 = "zm_gumball_blue_machine_";
        break;
    case "3":
        var_a58a7b24 = "zm_gumball_green_machine_";
        break;
    }
    exploder::exploder(var_a58a7b24 + var_65daa900);
    level waittill(#"hash_7e96273a");
    exploder::stop_exploder(var_a58a7b24 + var_65daa900);
}

// Namespace cmegachewfactory
// Params 1, eflags: 0x0
// Checksum 0x8e38be4b, Offset: 0x60a0
// Size: 0x12a
function function_a81cf932(localclientnum) {
    for (i = 0; i < 3; i++) {
        if (!function_8dd5b778(i)) {
            continue;
        }
        if (self.m_a_vat_contents[i] === "power_boost") {
            InvalidOpCode(0xb5, self.m_a_o_megachewcarousels[i], localclientnum, level._effect["ui/fx_megachew_ball_power_boost"], "tag_ball_0", 0.5);
            // Unknown operator (0xb5, t7_1b, PC)
        }
        if (self.m_a_vat_contents[i] === "doubler") {
            InvalidOpCode(0xb5, self.m_a_o_megachewcarousels[i], localclientnum, level._effect["ui/fx_megachew_ball_double"], "tag_ball_0", 0.5);
            // Unknown operator (0xb5, t7_1b, PC)
        }
        if (self.m_a_vat_contents[i] === "free_token") {
            InvalidOpCode(0xb5, self.m_a_o_megachewcarousels[i], localclientnum, level._effect["ui/fx_megachew_ball_divinium"], "tag_ball_0", 0.5);
            // Unknown operator (0xb5, t7_1b, PC)
        }
    }
    wait 0.5;
}

// Namespace cmegachewfactory
// Params 3, eflags: 0x0
// Checksum 0x902baa20, Offset: 0x61d8
// Size: 0x56
function set_megachew_factory_carousel_anim_state(localclientnum, var_c268ab, var_dda27c05) {
    var_467a5275 = function_8dd5b778(var_c268ab - 1);
    [[ self.m_a_o_megachewcarousels[var_c268ab - 1] ]]->function_ff34eb22(localclientnum, var_dda27c05, var_467a5275);
}

// Namespace cmegachewfactory
// Params 1, eflags: 0x0
// Checksum 0x38b16e4a, Offset: 0x6238
// Size: 0x39
function show_random_starting_gumballs_on_carousels(localclientnum) {
    for (var_65daa900 = 0; var_65daa900 < 3; var_65daa900++) {
        self thread show_random_starting_gumballs_on_carousel(localclientnum, var_65daa900);
    }
}

// Namespace cmegachewfactory
// Params 2, eflags: 0x0
// Checksum 0xa57e71c4, Offset: 0x6280
// Size: 0x41
function show_random_starting_gumballs_on_carousel(localclientnum, var_65daa900) {
    for (var_22f33582 = 0; var_22f33582 < 4; var_22f33582++) {
        self thread swap_spinning_carousel_gumball_on_notify(localclientnum, var_65daa900, var_22f33582);
    }
}

// Namespace cmegachewfactory
// Params 3, eflags: 0x0
// Checksum 0xfbd3bb7b, Offset: 0x62d0
// Size: 0x111
function swap_spinning_carousel_gumball_on_notify(localclientnum, var_65daa900, var_22f33582) {
    self notify("swap_spinning_carousel_gumball_on_notify_" + var_65daa900 + "_" + var_22f33582);
    self endon("swap_spinning_carousel_gumball_on_notify_" + var_65daa900 + "_" + var_22f33582);
    self endon(#"hash_7e96273a");
    var_a194bfb = getent(localclientnum, "gumball_carousel_0" + var_65daa900 + 1, "targetname");
    while (true) {
        if (level flag::get("megachew_carousel_show_result") && var_22f33582 == 0) {
            str_model = function_d15f1610(var_65daa900, 1);
        } else {
            str_model = function_5c92770();
        }
        [[ self.m_a_o_megachewcarousels[var_65daa900] ]]->function_1adedb74(var_22f33582, str_model);
        var_a194bfb waittillmatch(#"_anim_notify_", "ball_" + var_22f33582 + "_swap");
    }
}

// Namespace cmegachewfactory
// Params 3, eflags: 0x0
// Checksum 0x4628c48f, Offset: 0x63f0
// Size: 0x3e5
function function_afb1aa26(localclientnum, var_84faa044, var_dda27c05) {
    var_50a3a8f7 = "p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_idle_anim";
    if (function_8dd5b778(var_84faa044 - 1)) {
        var_be4e383 = "p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_active_powered_anim";
        var_b2e31b1e = "p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_end_powered_anim";
        var_baade4f6 = "p7_fxanim_zm_bgb_body_active_powered_anim";
        var_60c12291 = "p7_fxanim_zm_bgb_body_end_powered_anim";
    } else {
        var_be4e383 = "p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_active_unpowered_anim";
        var_b2e31b1e = "p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_end_unpowered_anim";
        var_baade4f6 = "p7_fxanim_zm_bgb_body_active_unpowered_anim";
        var_60c12291 = "p7_fxanim_zm_bgb_body_end_unpowered_anim";
    }
    var_623cf36 = "p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_turn_anim";
    var_2e757f3 = "p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_turn_select_anim";
    var_c80f5bb9 = "p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_turn_reverse_anim";
    var_263dadfc = self.m_a_mdl_domes[var_84faa044 - 1];
    mdl_body = self.m_a_mdl_bodies[var_84faa044 - 1];
    var_263dadfc util::waittill_dobj(localclientnum);
    var_263dadfc clearanim(var_50a3a8f7, 0);
    var_263dadfc clearanim("p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_active_powered_anim", 0);
    var_263dadfc clearanim("p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_active_unpowered_anim", 0);
    var_263dadfc clearanim("p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_end_powered_anim", 0);
    var_263dadfc clearanim("p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_end_unpowered_anim", 0);
    var_263dadfc clearanim(var_623cf36, 0);
    var_263dadfc clearanim(var_2e757f3, 0);
    var_263dadfc clearanim(var_c80f5bb9, 0);
    var_ca5e193e = 0.1;
    var_f6c62f08 = 1 + (var_84faa044 - 1) * var_ca5e193e;
    switch (var_dda27c05) {
    case 0:
        var_263dadfc animation::play(var_50a3a8f7, undefined, undefined, 1);
        break;
    case 1:
        mdl_body thread animation::play(var_baade4f6, undefined, undefined, var_f6c62f08);
        var_263dadfc animation::play(var_be4e383, undefined, undefined, var_f6c62f08);
        break;
    case 2:
        mdl_body thread animation::play(var_60c12291, undefined, undefined, 1);
        var_263dadfc animation::play(var_b2e31b1e, undefined, undefined, 1);
        break;
    case 3:
        var_263dadfc animation::play(var_623cf36, undefined, undefined, 1);
        break;
    case 4:
        exploder::exploder("zm_gumball_pipe_" + var_84faa044);
        var_263dadfc animation::play(var_2e757f3, undefined, undefined, 1);
        exploder::stop_exploder("zm_gumball_pipe_" + var_84faa044);
        break;
    case 5:
        var_263dadfc animation::play(var_c80f5bb9, undefined, undefined, 1);
        level notify(#"hash_b1090686");
        break;
    }
}

// Namespace cmegachewfactory
// Params 3, eflags: 0x0
// Checksum 0x9040767c, Offset: 0x67e0
// Size: 0xb5
function function_c8a456c2(localclientnum, var_65daa900, var_28303bfd) {
    switch (var_28303bfd) {
    case 0:
        exploder::stop_exploder("zm_gumball_sign_m_" + var_65daa900);
        exploder::stop_exploder("zm_gumball_sign_b_" + var_65daa900);
        break;
    case 1:
        exploder::exploder("zm_gumball_sign_m_" + var_65daa900);
        break;
    case 2:
        exploder::exploder("zm_gumball_sign_b_" + var_65daa900);
        break;
    }
}

// Namespace cmegachewfactory
// Params 2, eflags: 0x0
// Checksum 0x523b4f85, Offset: 0x68a0
// Size: 0x87
function function_28c320ea(localclientnum, b_open) {
    if (self.m_b_doors_open === b_open) {
        return;
    }
    self.m_b_doors_open = b_open;
    for (i = 1; i <= 3; i++) {
        self thread function_16b474d(localclientnum, i);
    }
    level flag::wait_till_all(self.m_a_str_megachew_factory_door_flags);
    if (!self.m_b_doors_open) {
        level notify(#"hash_7e96273a");
    }
}

// Namespace cmegachewfactory
// Params 2, eflags: 0x0
// Checksum 0xb0b4ff2b, Offset: 0x6930
// Size: 0x132
function function_16b474d(localclientnum, var_88e3572d) {
    level flag::clear("megachew_factory_door_" + var_88e3572d + "_anim_done");
    mdl_door = self.m_a_mdl_doors[var_88e3572d - 1];
    mdl_door util::waittill_dobj(localclientnum);
    if (self.m_b_doors_open) {
        exploder::exploder("zm_gumball_inside_" + var_88e3572d);
        mdl_door clearanim("p7_fxanim_zm_bgb_door_close_anim", 0);
        mdl_door animation::play("p7_fxanim_zm_bgb_door_open_anim", undefined, undefined, 1);
    } else {
        exploder::stop_exploder("zm_gumball_inside_" + var_88e3572d);
        mdl_door clearanim("p7_fxanim_zm_bgb_door_open_anim", 0);
        mdl_door animation::play("p7_fxanim_zm_bgb_door_close_anim", undefined, undefined, 1);
    }
    level flag::set("megachew_factory_door_" + var_88e3572d + "_anim_done");
}

// Namespace cmegachewfactory
// Params 3, eflags: 0x0
// Checksum 0xd9ab04b, Offset: 0x6a70
// Size: 0x62
function function_ef1ebe78(localclientnum, var_81ba58cf, var_dda27c05) {
    for (i = 0; i < 6; i++) {
        self thread function_4a017b6b(localclientnum, i, var_dda27c05);
    }
    level flag::wait_till_all(self.m_a_str_megachew_factory_result_flags);
}

// Namespace cmegachewfactory
// Params 3, eflags: 0x0
// Checksum 0xbacf8a4f, Offset: 0x6ae0
// Size: 0x24a
function function_4a017b6b(localclientnum, var_22f33582, var_dda27c05) {
    level flag::clear("megachew_factory_result_" + var_22f33582 + "_anim_done");
    var_9791d8f2 = "p7_fxanim_zm_bgb_tube_ball_" + var_22f33582 + "_drop_anim";
    var_528cf711 = "p7_fxanim_zm_bgb_tube_ball_" + var_22f33582 + "_idle_anim";
    var_5bf69b77 = "p7_fxanim_zm_bgb_tube_ball_" + var_22f33582 + "_flush_anim";
    var_e9950fa3 = "p7_fxanim_zm_bgb_tube_front_drop_anim";
    var_b5ba2990 = "p7_fxanim_zm_bgb_tube_front_flush_anim";
    self.m_mdl_tube_front util::waittill_dobj(localclientnum);
    self.m_mdl_tube_front clearanim(var_e9950fa3, 0);
    self.m_mdl_tube_front clearanim(var_b5ba2990, 0);
    mdl_ball = self.m_a_mdl_balls[var_22f33582];
    mdl_ball util::waittill_dobj(localclientnum);
    mdl_ball clearanim(var_9791d8f2, 0);
    mdl_ball clearanim(var_528cf711, 0);
    mdl_ball clearanim(var_5bf69b77, 0);
    switch (var_dda27c05) {
    case 0:
        self.m_mdl_tube_front thread animation::play(var_e9950fa3, undefined, undefined, 1);
        mdl_ball animation::play(var_9791d8f2, undefined, undefined, 1);
        break;
    case 1:
        mdl_ball animation::play(var_528cf711, undefined, undefined, 1);
        break;
    case 2:
        self.m_mdl_tube_front thread animation::play(var_b5ba2990, undefined, undefined, 1);
        mdl_ball animation::play(var_5bf69b77, undefined, undefined, 1);
        break;
    }
    level flag::set("megachew_factory_result_" + var_22f33582 + "_anim_done");
}

// Namespace cmegachewfactory
// Params 0, eflags: 0x0
// Checksum 0xf270e754, Offset: 0x6d38
// Size: 0x462
function function_cad50ca5() {
    self.m_b_power_boost = 0;
    self.var_980f92d3 = 0;
    self.m_n_doubler_count = 0;
    var_31ed4895 = 0;
    /#
        var_d2e13975 = level clientfield::get("<dev string:x2e>") == 1;
    #/
    if (isdefined(var_d2e13975) && var_d2e13975) {
        self.m_a_vat_contents[0] = "power_boost";
        self.m_b_power_boost = 1;
        var_31ed4895 += 1;
    } else {
        n_roll = randomint(100);
        if (n_roll < 80) {
            self.m_a_vat_contents[0] = randomintrange(-40, -22);
        } else if (n_roll < 94) {
            self.m_a_vat_contents[0] = randomintrange(-40, -22);
        } else if (self.m_n_tokens_spent < 3) {
            self.m_a_vat_contents[0] = "power_boost";
            self.m_b_power_boost = 1;
            var_31ed4895 += 1;
        } else {
            self.m_a_vat_contents[0] = randomintrange(-40, -22);
        }
    }
    n_roll = randomint(100);
    if (n_roll < 45) {
        self.m_a_vat_contents[1] = randomintrange(-40, -22);
    } else if (n_roll < 73) {
        self.m_a_vat_contents[1] = randomintrange(-40, -22);
    } else if (n_roll < 83) {
        self.m_a_vat_contents[1] = "free_token";
        if (self.m_n_tokens_spent >= 2 || self.m_b_power_boost) {
            self.var_980f92d3 = self.var_980f92d3 + 1;
        }
    } else if (n_roll < 98) {
        if (self.m_b_power_boost || self.m_n_tokens_spent === 3) {
            self.m_a_vat_contents[1] = "doubler";
            self.m_n_doubler_count = self.m_n_doubler_count + 1;
            var_31ed4895 += 1;
        } else {
            var_d6afc60a = randomint(100);
            if (var_d6afc60a < 50) {
                self.m_a_vat_contents[1] = "power_boost";
                if (function_8dd5b778(1)) {
                    self.m_b_power_boost = 1;
                }
                var_31ed4895 += 1;
            } else {
                self.m_a_vat_contents[1] = "doubler";
                if (self.m_n_tokens_spent >= 2 || self.m_b_power_boost) {
                    self.m_n_doubler_count = self.m_n_doubler_count + 1;
                    var_31ed4895 += 1;
                }
            }
        }
    } else {
        self.m_a_vat_contents[1] = randomintrange(-40, -22);
    }
    n_roll = randomint(100);
    if (n_roll < 45) {
        self.m_a_vat_contents[2] = randomintrange(-40, -22);
    } else if (n_roll < 73) {
        self.m_a_vat_contents[2] = randomintrange(-40, -22);
    } else if (n_roll < 83) {
        self.m_a_vat_contents[2] = "free_token";
        if (self.m_n_tokens_spent === 3 || self.m_b_power_boost) {
            self.var_980f92d3 = self.var_980f92d3 + 1;
        }
    } else if (n_roll < 98) {
        if (var_31ed4895 == 2) {
            self.m_a_vat_contents[2] = "free_token";
            if (self.m_n_tokens_spent === 3 || self.m_b_power_boost) {
                self.var_980f92d3 = self.var_980f92d3 + 1;
            }
        } else {
            self.m_a_vat_contents[2] = "doubler";
            if (self.m_n_tokens_spent === 3 || self.m_b_power_boost) {
                self.m_n_doubler_count = self.m_n_doubler_count + 1;
            }
        }
    } else {
        self.m_a_vat_contents[2] = randomintrange(-40, -22);
    }
    self.var_980f92d3 = self.var_980f92d3 * pow(2, self.m_n_doubler_count);
}

// Namespace cmegachewfactory
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x71a8
// Size: 0x2
function __constructor() {
    
}

// Namespace cmegachewfactory
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x71b8
// Size: 0x2
function __destructor() {
    
}

#namespace namespace_cc6fa95d;

// Namespace namespace_cc6fa95d
// Params 1, eflags: 0x0
// Checksum 0x341a1819, Offset: 0x7740
// Size: 0x162
function init(localclientnum) {
    self.var_be6614cf = getent(localclientnum, "vial_counter", "targetname");
    self.var_2692452d = [];
    self.var_39ebc94d = 0;
    for (i = 0; i < 3; i++) {
        v_origin = self.var_be6614cf gettagorigin("tag_numbers_position_" + i);
        v_angles = self.var_be6614cf gettagangles("tag_numbers_position_" + i);
        mdl_number = spawn(localclientnum, v_origin, "script_model");
        mdl_number setmodel("p7_zm_bgb_nixie_number_on");
        mdl_number.angles = v_angles;
        if (!isdefined(self.var_2692452d)) {
            self.var_2692452d = [];
        } else if (!isarray(self.var_2692452d)) {
            self.var_2692452d = array(self.var_2692452d);
        }
        self.var_2692452d[self.var_2692452d.size] = mdl_number;
    }
    function_aa6d32cd(localclientnum);
}

// Namespace namespace_cc6fa95d
// Params 2, eflags: 0x0
// Checksum 0x595b4499, Offset: 0x78b0
// Size: 0x1a
function function_ce2f631(localclientnum, n_count) {
    self.var_39ebc94d = n_count;
}

// Namespace namespace_cc6fa95d
// Params 2, eflags: 0x0
// Checksum 0x618c620, Offset: 0x78d8
// Size: 0x85
function function_c8f331c(localclientnum, b_on) {
    self notify(#"hash_1dd7e0f3");
    self endon(#"hash_1dd7e0f3");
    if (b_on) {
        while (true) {
            for (i = 1; i <= 3; i++) {
                self thread function_bbf6a142(localclientnum, i);
            }
            wait 0.2;
            function_aa6d32cd(localclientnum);
            wait 0.2;
        }
    }
}

// Namespace namespace_cc6fa95d
// Params 1, eflags: 0x0
// Checksum 0xd3ce428e, Offset: 0x7968
// Size: 0x59
function function_aa6d32cd(localclientnum) {
    for (i = 1; i <= 3; i++) {
        n_digit = function_a77a3e55(i, self.var_39ebc94d);
        function_8bbe8655(localclientnum, i, n_digit);
    }
}

// Namespace namespace_cc6fa95d
// Params 2, eflags: 0x4
// Checksum 0xc116b9cc, Offset: 0x79d0
// Size: 0xa2
function private function_a77a3e55(var_75e21c4d, n_count) {
    var_7b513c34 = int(pow(10, var_75e21c4d));
    var_ed58ab6f = int(pow(10, var_75e21c4d - 1));
    var_70ae6ae6 = n_count % var_7b513c34;
    if (var_75e21c4d > 1) {
        var_70ae6ae6 -= n_count % var_ed58ab6f;
        var_70ae6ae6 /= var_ed58ab6f;
    }
    return var_70ae6ae6;
}

// Namespace namespace_cc6fa95d
// Params 3, eflags: 0x0
// Checksum 0x4654fbd5, Offset: 0x7a80
// Size: 0x91
function function_8bbe8655(localclientnum, var_75e21c4d, n_digit) {
    mdl_number = self.var_2692452d[var_75e21c4d - 1];
    for (i = 0; i < 10; i++) {
        if (i === n_digit) {
            mdl_number showpart(localclientnum, "tag_number_" + i);
            continue;
        }
        mdl_number hidepart(localclientnum, "tag_number_" + i);
    }
}

// Namespace namespace_cc6fa95d
// Params 2, eflags: 0x0
// Checksum 0x9570f656, Offset: 0x7b20
// Size: 0x61
function function_bbf6a142(localclientnum, var_75e21c4d) {
    mdl_number = self.var_2692452d[var_75e21c4d - 1];
    for (i = 0; i < 10; i++) {
        mdl_number hidepart(localclientnum, "tag_number_" + i);
    }
}

// Namespace namespace_cc6fa95d
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x7b90
// Size: 0x2
function __constructor() {
    
}

// Namespace namespace_cc6fa95d
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x7ba0
// Size: 0x2
function __destructor() {
    
}

#namespace namespace_67b49468;

// Namespace namespace_67b49468
// Params 2, eflags: 0x0
// Checksum 0x322667e7, Offset: 0x7d40
// Size: 0x72
function init(localclientnum, var_65daa900) {
    self.var_3093c559 = [];
    self.var_bbdd2958 = [];
    self.var_ae72b394 = [];
    self.var_ac86d96c = var_65daa900;
    self.var_1b7928a0 = getent(localclientnum, "bgb_0" + var_65daa900 + "_dome", "targetname");
    self.var_27ae53c5 = 0;
    self.var_8d8be3f9 = 0;
}

// Namespace namespace_67b49468
// Params 3, eflags: 0x0
// Checksum 0x9fb94321, Offset: 0x7dc0
// Size: 0x52
function function_62f4b701(localclientnum, var_3eb4c129, var_901e562d) {
    if (var_3eb4c129 != self.var_27ae53c5) {
        self.var_27ae53c5 = var_3eb4c129;
    }
    if (var_901e562d != self.var_8d8be3f9) {
        self.var_8d8be3f9 = var_901e562d;
    }
    function_de87be81(localclientnum);
}

// Namespace namespace_67b49468
// Params 1, eflags: 0x0
// Checksum 0x3413a7b, Offset: 0x7e20
// Size: 0x9a
function function_de87be81(localclientnum) {
    if (self.var_27ae53c5) {
        if (self.var_8d8be3f9) {
            function_d9405817(localclientnum, 2);
        } else {
            function_d9405817(localclientnum, 1);
        }
    } else {
        function_d9405817(localclientnum, 0);
    }
    wait 0.1;
    function_75246ac0(localclientnum, self.var_8d8be3f9);
    function_205cc563(localclientnum, self.var_8d8be3f9);
}

// Namespace namespace_67b49468
// Params 2, eflags: 0x0
// Checksum 0xe5f6a9e4, Offset: 0x7ec8
// Size: 0x265
function function_75246ac0(localclientnum, b_on) {
    if (!b_on) {
        foreach (fx_id in self.var_3093c559) {
            stopfx(localclientnum, fx_id);
        }
        self.var_3093c559 = [];
        return;
    }
    switch (self.var_ac86d96c) {
    case 1:
        break;
    case 2:
        function_376191fe(localclientnum, level._effect["megachew_vat_electrode_sm"], "tag_dome2_elect_01", 2);
        function_376191fe(localclientnum, level._effect["megachew_vat_electrode_sm"], "tag_dome2_elect_02", 2);
        function_376191fe(localclientnum, level._effect["megachew_vat_electrode_center_sm"], "tag_dome2_elect_cnt_01", 2);
        break;
    case 3:
        function_376191fe(localclientnum, level._effect["megachew_vat_electrode_sm"], "tag_dome3_elect_01", 2);
        function_376191fe(localclientnum, level._effect["megachew_vat_electrode_sm"], "tag_dome3_elect_02", 2);
        function_376191fe(localclientnum, level._effect["megachew_vat_electrode_center_sm"], "tag_dome3_elect_cnt_01", 2);
        function_376191fe(localclientnum, level._effect["megachew_vat_electrode_lg"], "tag_dome3_elect_03", 2);
        function_376191fe(localclientnum, level._effect["megachew_vat_electrode_lg"], "tag_dome3_elect_04", 2);
        function_376191fe(localclientnum, level._effect["megachew_vat_electrode_center_lg"], "tag_dome3_elect_cnt_02", 2);
        break;
    }
}

// Namespace namespace_67b49468
// Params 2, eflags: 0x0
// Checksum 0x2b5eadc1, Offset: 0x8138
// Size: 0x3dd
function function_205cc563(localclientnum, b_on) {
    if (!b_on) {
        foreach (fx_id in self.var_bbdd2958) {
            stopfx(localclientnum, fx_id);
        }
        self.var_bbdd2958 = [];
        return;
    }
    switch (self.var_ac86d96c) {
    case 1:
        function_376191fe(localclientnum, level._effect["megachew_vat_light_lg"], "tag_dome1_light_01", 1);
        function_376191fe(localclientnum, level._effect["megachew_vat_light_lg"], "tag_dome1_light_02", 1);
        break;
    case 2:
        function_376191fe(localclientnum, level._effect["megachew_vat_light_lg"], "tag_dome2_light_01", 1);
        function_376191fe(localclientnum, level._effect["megachew_vat_light_lg"], "tag_dome2_light_02", 1);
        function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome2_light_03", 1);
        function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome2_light_04", 1);
        function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome2_light_06", 1);
    case 3:
        function_376191fe(localclientnum, level._effect["megachew_vat_light_lg"], "tag_dome3_light_01", 1);
        function_376191fe(localclientnum, level._effect["megachew_vat_light_lg"], "tag_dome3_light_02", 1);
        function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome3_light_03", 1);
        function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome3_light_04", 1);
        function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome3_light_05", 1);
        function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome3_light_06", 1);
        function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome3_light_07", 1);
        function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome3_light_10", 1);
        function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome3_light_11", 1);
        function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome3_light_12", 1);
        break;
    }
}

// Namespace namespace_67b49468
// Params 2, eflags: 0x0
// Checksum 0x22e564da, Offset: 0x8520
// Size: 0x112
function function_d9405817(localclientnum, var_844b5d83) {
    if (var_844b5d83 == 0) {
        foreach (fx_id in self.var_ae72b394) {
            stopfx(localclientnum, fx_id);
        }
        self.var_ae72b394 = [];
        return;
    }
    if (var_844b5d83 == 1) {
        function_376191fe(localclientnum, level._effect["megachew_vat_whistle_sm"], "tag_dome" + self.var_ac86d96c + "_whistle", 3);
        return;
    }
    if (var_844b5d83 == 2) {
        function_376191fe(localclientnum, level._effect["megachew_vat_whistle"], "tag_dome" + self.var_ac86d96c + "_whistle", 3);
    }
}

// Namespace namespace_67b49468
// Params 4, eflags: 0x4
// Checksum 0xa7db7db5, Offset: 0x8640
// Size: 0x195
function private function_376191fe(localclientnum, str_fx, str_tag, var_bda11dad) {
    fx_id = playfxontag(localclientnum, str_fx, self.var_1b7928a0, str_tag);
    switch (var_bda11dad) {
    case 2:
        if (!isdefined(self.var_3093c559)) {
            self.var_3093c559 = [];
        } else if (!isarray(self.var_3093c559)) {
            self.var_3093c559 = array(self.var_3093c559);
        }
        self.var_3093c559[self.var_3093c559.size] = fx_id;
        break;
    case 1:
        if (!isdefined(self.var_bbdd2958)) {
            self.var_bbdd2958 = [];
        } else if (!isarray(self.var_bbdd2958)) {
            self.var_bbdd2958 = array(self.var_bbdd2958);
        }
        self.var_bbdd2958[self.var_bbdd2958.size] = fx_id;
        break;
    case 3:
        if (!isdefined(self.var_ae72b394)) {
            self.var_ae72b394 = [];
        } else if (!isarray(self.var_ae72b394)) {
            self.var_ae72b394 = array(self.var_ae72b394);
        }
        self.var_ae72b394[self.var_ae72b394.size] = fx_id;
        break;
    }
}

// Namespace namespace_67b49468
// Params 1, eflags: 0x0
// Checksum 0xd7bee7dc, Offset: 0x87e0
// Size: 0x1b5
function function_9a4e22cc(localclientnum) {
    switch (self.var_ac86d96c) {
    case 1:
        break;
    case 2:
        self thread function_c857e43f(localclientnum, level._effect["megachew_vat_electrode_surge_sm"], "tag_dome2_elect_01");
        self thread function_c857e43f(localclientnum, level._effect["megachew_vat_electrode_surge_sm"], "tag_dome2_elect_02");
        self thread function_c857e43f(localclientnum, level._effect["megachew_vat_electrode_center_sm"], "tag_dome2_elect_cnt_01");
        break;
    case 3:
        self thread function_c857e43f(localclientnum, level._effect["megachew_vat_electrode_surge_sm"], "tag_dome3_elect_01");
        self thread function_c857e43f(localclientnum, level._effect["megachew_vat_electrode_surge_sm"], "tag_dome3_elect_02");
        self thread function_c857e43f(localclientnum, level._effect["megachew_vat_electrode_center_sm"], "tag_dome3_elect_cnt_01");
        self thread function_c857e43f(localclientnum, level._effect["megachew_vat_electrode_center_lg"], "tag_dome3_elect_cnt_02");
        self thread function_c857e43f(localclientnum, level._effect["megachew_vat_electrode_surge_lg"], "tag_dome3_elect_03");
        self thread function_c857e43f(localclientnum, level._effect["megachew_vat_electrode_surge_lg"], "tag_dome3_elect_04");
        break;
    }
}

// Namespace namespace_67b49468
// Params 4, eflags: 0x4
// Checksum 0xf5a59aaf, Offset: 0x89a0
// Size: 0x72
function private function_c857e43f(localclientnum, str_fx, str_tag, var_40276d2a) {
    if (!isdefined(var_40276d2a)) {
        var_40276d2a = 2;
    }
    fx_id = playfxontag(localclientnum, str_fx, self.var_1b7928a0, str_tag);
    wait var_40276d2a;
    stopfx(localclientnum, fx_id);
}

// Namespace namespace_67b49468
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x8a20
// Size: 0x2
function __constructor() {
    
}

// Namespace namespace_67b49468
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x8a30
// Size: 0x2
function __destructor() {
    
}

#namespace namespace_7c51d14d;

// Namespace namespace_7c51d14d
// Params 2, eflags: 0x0
// Checksum 0x71ad234f, Offset: 0x8c20
// Size: 0x96
function init(localclientnum, var_c268ab) {
    if (!isdefined(self.var_165c359f)) {
        self.var_165c359f = getent(localclientnum, "gumball_carousel_0" + var_c268ab, "targetname");
    }
    if (!self.var_165c359f hasanimtree()) {
        self.var_165c359f useanimtree(#generic);
    }
    if (!isdefined(self.var_526762bf)) {
        self.var_526762bf = [];
    }
}

// Namespace namespace_7c51d14d
// Params 3, eflags: 0x0
// Checksum 0x7fad6c6d, Offset: 0x8cc0
// Size: 0x112
function function_ff34eb22(localclientnum, var_dda27c05, var_467a5275) {
    if (var_467a5275) {
        var_1ecf2c7b = "p7_fxanim_zm_bgb_carousel_active_powered_anim";
        var_4196b15c = "p7_fxanim_zm_bgb_carousel_end_powered_anim";
    } else {
        var_1ecf2c7b = "p7_fxanim_zm_bgb_carousel_active_unpowered_anim";
        var_4196b15c = "p7_fxanim_zm_bgb_carousel_end_unpowered_anim";
    }
    self.var_165c359f util::waittill_dobj(localclientnum);
    if (isdefined(self.m_str_anim)) {
        self.var_165c359f clearanim(self.m_str_anim, 0);
    }
    switch (var_dda27c05) {
    case 0:
        break;
    case 1:
        self.m_str_anim = var_1ecf2c7b;
        break;
    case 2:
        self.m_str_anim = var_4196b15c;
        break;
    case 3:
        self.m_str_anim = var_4196b15c;
        break;
    }
    self.var_165c359f animation::play(self.m_str_anim, undefined, undefined, 1);
}

// Namespace namespace_7c51d14d
// Params 0, eflags: 0x0
// Checksum 0x40f83e48, Offset: 0x8de0
// Size: 0x31
function function_ecd47aa9() {
    for (i = 0; i < 4; i++) {
        function_5cfdd76b(i);
    }
}

// Namespace namespace_7c51d14d
// Params 2, eflags: 0x0
// Checksum 0xc2818dc0, Offset: 0x8e20
// Size: 0x32
function function_1adedb74(var_9bcca82d, str_model) {
    function_5cfdd76b(var_9bcca82d);
    function_37558b34(var_9bcca82d, str_model);
}

// Namespace namespace_7c51d14d
// Params 2, eflags: 0x4
// Checksum 0x530c706d, Offset: 0x8e60
// Size: 0x3f
function private function_37558b34(var_9bcca82d, str_model) {
    self.var_165c359f attach(str_model, "tag_ball_" + var_9bcca82d);
    self.var_526762bf[var_9bcca82d] = str_model;
}

// Namespace namespace_7c51d14d
// Params 1, eflags: 0x4
// Checksum 0xc20a16d8, Offset: 0x8ea8
// Size: 0x82
function private function_5cfdd76b(var_9bcca82d) {
    if (!isdefined(self.var_526762bf[var_9bcca82d])) {
        return;
    }
    str_model = self.var_526762bf[var_9bcca82d];
    if (self.var_165c359f isattached(str_model, "tag_ball_" + var_9bcca82d)) {
        self.var_165c359f detach(str_model, "tag_ball_" + var_9bcca82d);
    }
    self.var_526762bf[var_9bcca82d] = undefined;
}

// Namespace namespace_7c51d14d
// Params 4, eflags: 0x0
// Checksum 0x54143498, Offset: 0x8f38
// Size: 0x8a
function function_441bde3c(localclientnum, fx_id, str_tag, var_9e6999a1) {
    if (!isdefined(str_tag)) {
        str_tag = "tag_ball_0";
    }
    self.var_165c359f util::waittill_dobj(localclientnum);
    fx_id = playfxontag(localclientnum, fx_id, self.var_165c359f, str_tag);
    if (isdefined(var_9e6999a1)) {
        wait var_9e6999a1;
        stopfx(localclientnum, fx_id);
    }
}

// Namespace namespace_7c51d14d
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x8fd0
// Size: 0x2
function __constructor() {
    
}

// Namespace namespace_7c51d14d
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x8fe0
// Size: 0x2
function __destructor() {
    
}

#namespace namespace_2a92124e;

// Namespace namespace_2a92124e
// Params 2, eflags: 0x0
// Checksum 0xf70f5c90, Offset: 0x9180
// Size: 0x571
function init(localclientnum, var_65daa900) {
    self.var_ea9963fa = [];
    self.var_903eb306 = [];
    self.var_6247d870 = [];
    var_263dadfc = getent(localclientnum, "bgb_0" + var_65daa900 + "_dome", "targetname");
    mdl_body = getent(localclientnum, "bgb_0" + var_65daa900 + "_body", "targetname");
    for (i = 1; i <= 2; i++) {
        str_tagname = "tag_body_dial_0" + i + "_link";
        v_origin = mdl_body gettagorigin(str_tagname);
        var_c59494bb = spawn(localclientnum, v_origin, "script_model");
        var_c59494bb.angles = mdl_body gettagangles(str_tagname);
        var_c59494bb setmodel("p7_fxanim_zm_bgb_machine_dial_lrg_mod");
        var_c59494bb useanimtree(#generic);
        if (!isdefined(self.var_ea9963fa)) {
            self.var_ea9963fa = [];
        } else if (!isarray(self.var_ea9963fa)) {
            self.var_ea9963fa = array(self.var_ea9963fa);
        }
        self.var_ea9963fa[self.var_ea9963fa.size] = var_c59494bb;
    }
    if (var_65daa900 === 2) {
        str_tagname = "tag_dome2_dial_sml_01_link";
        v_origin = var_263dadfc gettagorigin(str_tagname);
        var_c59494bb = spawn(localclientnum, v_origin, "script_model");
        var_c59494bb setmodel("p7_fxanim_zm_bgb_machine_dial_sml_mod");
        var_c59494bb useanimtree(#generic);
        var_c59494bb.angles = var_263dadfc gettagangles(str_tagname);
        if (!isdefined(self.var_903eb306)) {
            self.var_903eb306 = [];
        } else if (!isarray(self.var_903eb306)) {
            self.var_903eb306 = array(self.var_903eb306);
        }
        self.var_903eb306[self.var_903eb306.size] = var_c59494bb;
        if (!isdefined(self.var_6247d870)) {
            self.var_6247d870 = [];
        } else if (!isarray(self.var_6247d870)) {
            self.var_6247d870 = array(self.var_6247d870);
        }
        self.var_6247d870[self.var_6247d870.size] = var_c59494bb;
        return;
    }
    if (var_65daa900 === 3) {
        str_tagname = "tag_dome3_dial_lrg_01_link";
        v_origin = var_263dadfc gettagorigin(str_tagname);
        var_c59494bb = spawn(localclientnum, v_origin, "script_model");
        var_c59494bb setmodel("p7_fxanim_zm_bgb_machine_dial_lrg_mod");
        var_c59494bb useanimtree(#generic);
        var_c59494bb.angles = var_263dadfc gettagangles(str_tagname);
        if (!isdefined(self.var_ea9963fa)) {
            self.var_ea9963fa = [];
        } else if (!isarray(self.var_ea9963fa)) {
            self.var_ea9963fa = array(self.var_ea9963fa);
        }
        self.var_ea9963fa[self.var_ea9963fa.size] = var_c59494bb;
        for (i = 1; i <= 4; i++) {
            str_tagname = "tag_dome3_dial_sml_0" + i + "_link";
            v_origin = var_263dadfc gettagorigin(str_tagname);
            var_c59494bb = spawn(localclientnum, v_origin, "script_model");
            var_c59494bb setmodel("p7_fxanim_zm_bgb_machine_dial_sml_mod");
            var_c59494bb useanimtree(#generic);
            var_c59494bb.angles = var_263dadfc gettagangles(str_tagname);
            if (!isdefined(self.var_903eb306)) {
                self.var_903eb306 = [];
            } else if (!isarray(self.var_903eb306)) {
                self.var_903eb306 = array(self.var_903eb306);
            }
            self.var_903eb306[self.var_903eb306.size] = var_c59494bb;
            if (i <= 2) {
                if (!isdefined(self.var_6247d870)) {
                    self.var_6247d870 = [];
                } else if (!isarray(self.var_6247d870)) {
                    self.var_6247d870 = array(self.var_6247d870);
                }
                self.var_6247d870[self.var_6247d870.size] = var_c59494bb;
            }
        }
    }
}

// Namespace namespace_2a92124e
// Params 1, eflags: 0x0
// Checksum 0x33675a48, Offset: 0x9700
// Size: 0x179
function function_f9042a9d(b_on) {
    for (i = 0; i < self.var_903eb306.size; i++) {
        var_c59494bb = self.var_903eb306[i];
        if (b_on) {
            var_c59494bb clearanim("p7_fxanim_zm_bgb_dial_sml_idle_anim", 0);
            var_c59494bb thread animation::play("p7_fxanim_zm_bgb_dial_sml_active_anim", undefined, undefined, 1 + i * 0.05);
            continue;
        }
        var_c59494bb clearanim("p7_fxanim_zm_bgb_dial_sml_active_anim", 0);
        var_c59494bb thread animation::play("p7_fxanim_zm_bgb_dial_sml_idle_anim", undefined, undefined, 1 + i * 0.05);
    }
    for (i = 0; i < self.var_ea9963fa.size; i++) {
        var_c59494bb = self.var_ea9963fa[i];
        if (b_on) {
            var_c59494bb clearanim("p7_fxanim_zm_bgb_dial_lrg_idle_anim", 0);
            var_c59494bb thread animation::play("p7_fxanim_zm_bgb_dial_lrg_active_anim", undefined, undefined, 1 + i * 0.05);
            continue;
        }
        var_c59494bb clearanim("p7_fxanim_zm_bgb_dial_lrg_active_anim", 0);
        var_c59494bb thread animation::play("p7_fxanim_zm_bgb_dial_lrg_idle_anim", undefined, undefined, 1 + i * 0.05);
    }
}

// Namespace namespace_2a92124e
// Params 1, eflags: 0x0
// Checksum 0xcadc0076, Offset: 0x9888
// Size: 0x8b
function function_35919adb(b_on) {
    foreach (var_c59494bb in self.var_6247d870) {
        if (b_on) {
            var_c59494bb show();
            continue;
        }
        var_c59494bb hide();
    }
}

// Namespace namespace_2a92124e
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x9920
// Size: 0x2
function __constructor() {
    
}

// Namespace namespace_2a92124e
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x9930
// Size: 0x2
function __destructor() {
    
}

#namespace namespace_513a44f6;

// Namespace namespace_513a44f6
// Params 1, eflags: 0x0
// Checksum 0x4931dba2, Offset: 0x9a30
// Size: 0x102
function init(localclientnum) {
    self.var_fb7ce594 = [];
    self.var_bbdd2958 = [];
    self.var_a261993f = [];
    for (i = 1; i <= 3; i++) {
        var_c2d73a21 = getent(localclientnum, "bgb_button_0" + i, "targetname");
        if (!var_c2d73a21 hasanimtree()) {
            var_c2d73a21 useanimtree(#generic);
        }
        if (!isdefined(self.var_fb7ce594)) {
            self.var_fb7ce594 = [];
        } else if (!isarray(self.var_fb7ce594)) {
            self.var_fb7ce594 = array(self.var_fb7ce594);
        }
        self.var_fb7ce594[self.var_fb7ce594.size] = var_c2d73a21;
    }
    function_2b1651c(localclientnum, 1);
}

// Namespace namespace_513a44f6
// Params 2, eflags: 0x0
// Checksum 0x4ba2e1a, Offset: 0x9b40
// Size: 0x32
function function_2b1651c(localclientnum, var_4d37bbe9) {
    self.var_2da25cd0 = var_4d37bbe9 + 1;
    function_bc49558a(localclientnum);
}

// Namespace namespace_513a44f6
// Params 2, eflags: 0x0
// Checksum 0xeed33f30, Offset: 0x9b80
// Size: 0x72
function press_button(localclientnum, var_4d37bbe9) {
    var_c2d73a21 = self.var_fb7ce594[var_4d37bbe9 - 1];
    var_c2d73a21 util::waittill_dobj(localclientnum);
    var_c2d73a21 clearanim("p7_fxanim_zm_bgb_button_push_anim", 0);
    var_c2d73a21 animation::play("p7_fxanim_zm_bgb_button_push_anim", undefined, undefined, 1);
}

// Namespace namespace_513a44f6
// Params 1, eflags: 0x0
// Checksum 0x9714e63b, Offset: 0x9c00
// Size: 0xb9
function function_bc49558a(localclientnum) {
    for (i = 0; i < 3; i++) {
        var_c2d73a21 = self.var_fb7ce594[i];
        if (i === self.var_2da25cd0 - 1) {
            var_c2d73a21 hidepart(localclientnum, "tag_filament_off");
            var_c2d73a21 showpart(localclientnum, "tag_filament_on");
            continue;
        }
        var_c2d73a21 hidepart(localclientnum, "tag_filament_on");
        var_c2d73a21 showpart(localclientnum, "tag_filament_off");
    }
}

// Namespace namespace_513a44f6
// Params 2, eflags: 0x0
// Checksum 0xfcbf76ac, Offset: 0x9cc8
// Size: 0xc9
function function_c379aa(localclientnum, b_on) {
    if (!b_on) {
        function_8ab5d4f1(localclientnum, 0);
        exploder::stop_exploder("zm_gumball_" + self.var_2da25cd0 + "cent");
        return;
    }
    for (i = 1; i <= 3; i++) {
        if (i == self.var_2da25cd0) {
            exploder::exploder("zm_gumball_" + i + "cent");
            function_8ab5d4f1(localclientnum, 1);
            continue;
        }
        exploder::stop_exploder("zm_gumball_" + i + "cent");
    }
}

// Namespace namespace_513a44f6
// Params 2, eflags: 0x0
// Checksum 0x32a293c5, Offset: 0x9da0
// Size: 0x1ab
function function_8ab5d4f1(localclientnum, b_on) {
    if (b_on) {
        fx_id = playfxontag(localclientnum, level._effect["megachew_vat_light_lg"], self.var_fb7ce594[2], "tag_button3_light1");
        if (!isdefined(self.var_a261993f)) {
            self.var_a261993f = [];
        } else if (!isarray(self.var_a261993f)) {
            self.var_a261993f = array(self.var_a261993f);
        }
        self.var_a261993f[self.var_a261993f.size] = fx_id;
        fx_id = playfxontag(localclientnum, level._effect["megachew_vat_light_lg"], self.var_fb7ce594[2], "tag_button3_light2");
        if (!isdefined(self.var_a261993f)) {
            self.var_a261993f = [];
        } else if (!isarray(self.var_a261993f)) {
            self.var_a261993f = array(self.var_a261993f);
        }
        self.var_a261993f[self.var_a261993f.size] = fx_id;
        return;
    }
    foreach (fx_id in self.var_a261993f) {
        stopfx(localclientnum, fx_id);
    }
    self.var_a261993f = [];
    return;
}

// Namespace namespace_513a44f6
// Params 3, eflags: 0x4
// Checksum 0xe612c63a, Offset: 0x9f58
// Size: 0xa3
function private function_376191fe(localclientnum, str_fx, str_tag) {
    fx_id = playfxontag(localclientnum, str_fx, self.var_fb7ce594[2], str_tag);
    if (!isdefined(self.var_bbdd2958)) {
        self.var_bbdd2958 = [];
    } else if (!isarray(self.var_bbdd2958)) {
        self.var_bbdd2958 = array(self.var_bbdd2958);
    }
    self.var_bbdd2958[self.var_bbdd2958.size] = fx_id;
}

// Namespace namespace_513a44f6
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0xa008
// Size: 0x2
function __constructor() {
    
}

// Namespace namespace_513a44f6
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0xa018
// Size: 0x2
function __destructor() {
    
}

#namespace frontend;

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0xf0a29c78, Offset: 0xa1b8
// Size: 0x52
function open_character_menu(localclientnum, menu_data) {
    character_ent = getent(localclientnum, menu_data.target_name, "targetname");
    if (isdefined(character_ent)) {
        character_ent show();
    }
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0xb20855d8, Offset: 0xa218
// Size: 0x52
function close_character_menu(localclientnum, menu_data) {
    character_ent = getent(localclientnum, menu_data.target_name, "targetname");
    if (isdefined(character_ent)) {
        character_ent hide();
    }
}

// Namespace frontend
// Params 3, eflags: 0x0
// Checksum 0x6f0a8a51, Offset: 0xa278
// Size: 0x117
function function_b9b7c881(localclientnum, menu_name, extracam_data) {
    level endon(menu_name + "_closed");
    while (true) {
        params = spawnstruct();
        character_customization::function_fd188096(localclientnum, level.liveccdata, params);
        if (isdefined(params.align_struct)) {
            camera_ent = multi_extracam::extracam_init_item(localclientnum, params.align_struct, extracam_data.extracam_index);
            if (isdefined(camera_ent) && isdefined(params.xcam)) {
                if (isdefined(params.xcamframe)) {
                    camera_ent playextracamxcam(params.xcam, 0, params.subxcam, params.xcamframe);
                } else {
                    camera_ent playextracamxcam(params.xcam, 0, params.subxcam);
                }
            }
        }
        level waittill(#"frozenMomentChanged");
    }
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0x1f712c74, Offset: 0xa398
// Size: 0x42
function function_8d1a05f8(localclientnum, menu_data) {
    menu_data.custom_character.charactermode = 1;
    character_customization::function_b0a8e76d(localclientnum, menu_data.custom_character, 1);
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0xdfb3d0ab, Offset: 0xa3e8
// Size: 0x2a
function function_ef0109fe(localclientnum, menu_data) {
    character_customization::function_b0a8e76d(localclientnum, menu_data.custom_character, 0);
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0xdfcd28ac, Offset: 0xa420
// Size: 0x32
function start_character_rotating(localclientnum, menu_data) {
    level thread character_customization::rotation_thread_spawner(localclientnum, menu_data.custom_character, "end_character_rotating");
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0x6258f954, Offset: 0xa460
// Size: 0x1b
function end_character_rotating(localclientnum, menu_data) {
    level notify(#"end_character_rotating");
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0xe605167e, Offset: 0xa488
// Size: 0x32
function function_2aeaebe3(localclientnum, menu_data) {
    character_customization::function_474a5989(localclientnum, menu_data.custom_character, "spawn_char_lobbyslide");
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0x15009451, Offset: 0xa4c8
// Size: 0x2a
function function_4a0bdf8e(localclientnum, menu_data) {
    character_customization::function_474a5989(localclientnum, menu_data.custom_character, undefined);
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0xcfdc03f0, Offset: 0xa500
// Size: 0x43
function open_choose_head_menu(localclientnum, menu_data) {
    enablefrontendstreamingoverlay(localclientnum, 1);
    character_customization::function_ea9faed5(localclientnum, menu_data.custom_character, 0);
    level notify(#"begin_personalizing_hero");
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0xa3ee79af, Offset: 0xa550
// Size: 0x43
function close_choose_head_menu(localclientnum, menu_data) {
    enablefrontendstreamingoverlay(localclientnum, 0);
    character_customization::function_ea9faed5(localclientnum, menu_data.custom_character, 1);
    level notify(#"done_personalizing_hero");
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0xdbaff277, Offset: 0xa5a0
// Size: 0x16b
function personalize_characters_watch(localclientnum, menu_name) {
    level endon(#"disconnect");
    level endon(menu_name + "_closed");
    s_cam = struct::get("personalizeHero_camera", "targetname");
    assert(isdefined(s_cam));
    for (animtime = 0; true; animtime = 300) {
        level waittill(#"camera_change", pose);
        if (pose === "exploring") {
            playmaincamxcam(localclientnum, "ui_cam_character_customization", animtime, "cam_preview", "", s_cam.origin, s_cam.angles);
            continue;
        }
        if (pose === "inspecting_helmet") {
            playmaincamxcam(localclientnum, "ui_cam_character_customization", animtime, "cam_helmet", "", s_cam.origin, s_cam.angles);
            continue;
        }
        if (pose === "inspecting_body") {
            playmaincamxcam(localclientnum, "ui_cam_character_customization", animtime, "cam_select", "", s_cam.origin, s_cam.angles);
        }
    }
}

// Namespace frontend
// Params 1, eflags: 0x0
// Checksum 0xeed65d19, Offset: 0xa718
// Size: 0x9e9
function function_fb006449(localclientnum) {
    level endon(#"hash_22b30258");
    while (true) {
        var_ab91e00d = getdvarstring("ui_mapname");
        if (util::is_safehouse(var_ab91e00d)) {
            var_74cfff2 = var_ab91e00d;
        } else {
            var_74cfff2 = util::function_3eb32a89(var_ab91e00d);
        }
        var_74cfff2 = getsubstr(var_74cfff2, "cp_sh_".size);
        /#
            printtoprightln("<dev string:xb1>" + var_ab91e00d, (1, 1, 1));
            var_d14d3a96 = getdvarstring("<dev string:xbe>", "<dev string:xd5>");
            if (var_d14d3a96 != "<dev string:xd5>") {
                var_74cfff2 = var_d14d3a96;
            }
        #/
        level.var_8ab87915 = [];
        if (!isdefined(level.var_8ab87915)) {
            level.var_8ab87915 = [];
        } else if (!isarray(level.var_8ab87915)) {
            level.var_8ab87915 = array(level.var_8ab87915);
        }
        level.var_8ab87915[level.var_8ab87915.size] = "cp_cac_cp_lobby_idle_" + var_74cfff2;
        if (!isdefined(level.var_8ab87915)) {
            level.var_8ab87915 = [];
        } else if (!isarray(level.var_8ab87915)) {
            level.var_8ab87915 = array(level.var_8ab87915);
        }
        level.var_8ab87915[level.var_8ab87915.size] = "cin_fe_cp_bunk_vign_smoke_read_" + var_74cfff2;
        if (!isdefined(level.var_8ab87915)) {
            level.var_8ab87915 = [];
        } else if (!isarray(level.var_8ab87915)) {
            level.var_8ab87915 = array(level.var_8ab87915);
        }
        level.var_8ab87915[level.var_8ab87915.size] = "cin_fe_cp_desk_vign_work_" + var_74cfff2;
        if (!isdefined(level.var_8ab87915)) {
            level.var_8ab87915 = [];
        } else if (!isarray(level.var_8ab87915)) {
            level.var_8ab87915 = array(level.var_8ab87915);
        }
        level.var_8ab87915[level.var_8ab87915.size] = "cin_fe_cp_desk_vign_type_" + var_74cfff2;
        if (isdefined(level.var_67da5b39) && level.var_67da5b39.size) {
            for (i = 0; i < level.var_8ab87915.size; i++) {
                killradiantexploder(0, level.var_67da5b39[i]);
            }
        }
        level.var_67da5b39 = [];
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "cp_frontend_idle";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "cp_frontend_read";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "cp_frontend_work";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "cp_frontend_type";
        level.var_3bb399f9 = [];
        if (!isdefined(level.var_3bb399f9)) {
            level.var_3bb399f9 = [];
        } else if (!isarray(level.var_3bb399f9)) {
            level.var_3bb399f9 = array(level.var_3bb399f9);
        }
        level.var_3bb399f9[level.var_3bb399f9.size] = "cp_frontend_idle";
        if (!isdefined(level.var_3bb399f9)) {
            level.var_3bb399f9 = [];
        } else if (!isarray(level.var_3bb399f9)) {
            level.var_3bb399f9 = array(level.var_3bb399f9);
        }
        level.var_3bb399f9[level.var_3bb399f9.size] = "cp_frontend_read";
        if (!isdefined(level.var_3bb399f9)) {
            level.var_3bb399f9 = [];
        } else if (!isarray(level.var_3bb399f9)) {
            level.var_3bb399f9 = array(level.var_3bb399f9);
        }
        level.var_3bb399f9[level.var_3bb399f9.size] = "cp_frontend_work";
        if (!isdefined(level.var_3bb399f9)) {
            level.var_3bb399f9 = [];
        } else if (!isarray(level.var_3bb399f9)) {
            level.var_3bb399f9 = array(level.var_3bb399f9);
        }
        level.var_3bb399f9[level.var_3bb399f9.size] = "cp_frontend_type";
        if (!isdefined(level.var_f31ebae4)) {
            if (level clientfield::get("first_time_flow")) {
                level.var_f31ebae4 = 0;
                /#
                    printtoprightln("<dev string:xdd>", (1, 1, 1));
                #/
            } else if (level clientfield::get("cp_bunk_anim_type") == 0) {
                level.var_f31ebae4 = randomintrange(0, 2);
                /#
                    printtoprightln("<dev string:xfd>", (1, 1, 1));
                #/
            } else if (level clientfield::get("cp_bunk_anim_type") == 1) {
                level.var_f31ebae4 = randomintrange(2, 4);
                /#
                    printtoprightln("<dev string:x10a>", (1, 1, 1));
                #/
            }
        }
        /#
            if (getdvarint("<dev string:x118>", 0)) {
                if (!isdefined(level.var_b126daa5)) {
                    level.var_b126daa5 = level.var_f31ebae4;
                }
                level.var_b126daa5++;
                if (level.var_b126daa5 == level.var_8ab87915.size) {
                    level.var_b126daa5 = 0;
                }
                level.var_f31ebae4 = level.var_b126daa5;
            }
        #/
        s_scene = struct::get_script_bundle("scene", level.var_8ab87915[level.var_f31ebae4]);
        var_2af702f6 = getherogender(getequippedheroindex(localclientnum, 2), "cp");
        if (var_2af702f6 === "female" && isdefined(s_scene.femalebundle)) {
            s_scene = struct::get_script_bundle("scene", s_scene.femalebundle);
        }
        /#
            printtoprightln(s_scene.name, (1, 1, 1));
        #/
        s_align = struct::get(s_scene.aligntarget, "targetname");
        playmaincamxcam(localclientnum, s_scene.cameraswitcher, 0, "", "", s_align.origin, s_align.angles);
        for (i = 0; i < level.var_8ab87915.size; i++) {
            if (i == level.var_f31ebae4) {
                playradiantexploder(0, level.var_67da5b39[i]);
                continue;
            }
            killradiantexploder(0, level.var_67da5b39[i]);
        }
        s_params = spawnstruct();
        s_params.scene = s_scene.name;
        s_params.sessionmode = 2;
        character_customization::function_d79d6d7(localclientnum, level.var_74625f60, undefined, s_params);
        streamer_change(level.var_3bb399f9[level.var_f31ebae4], level.var_74625f60);
        setpbgactivebank(localclientnum, 1);
        /#
            if (getdvarint("<dev string:x118>", 0)) {
                level.var_f31ebae4 = undefined;
            }
        #/
        do {
            wait 0.016;
            var_9cd812ba = getdvarstring("ui_mapname");
        } while (var_9cd812ba == var_ab91e00d);
    }
}

// Namespace frontend
// Params 1, eflags: 0x0
// Checksum 0x4da6478b, Offset: 0xb110
// Size: 0xa15
function function_e5f8ef8c(localclientnum) {
    var_74cfff2 = level.var_f22d5918;
    /#
        var_d14d3a96 = getdvarstring("<dev string:xbe>", "<dev string:xd5>");
        if (var_d14d3a96 != "<dev string:xd5>") {
            var_74cfff2 = var_d14d3a96;
        }
    #/
    level.var_8ab87915 = [];
    level.var_784ba6c9 = "zm_cp_" + var_74cfff2 + "_lobby_idle";
    if (!isdefined(level.var_8ab87915)) {
        level.var_8ab87915 = [];
    } else if (!isarray(level.var_8ab87915)) {
        level.var_8ab87915 = array(level.var_8ab87915);
    }
    level.var_8ab87915[level.var_8ab87915.size] = level.var_784ba6c9;
    if (isdefined(level.var_67da5b39) && level.var_67da5b39.size) {
        for (i = 0; i < level.var_8ab87915.size; i++) {
            killradiantexploder(0, level.var_67da5b39[i]);
        }
    }
    level.var_67da5b39 = [];
    if (var_74cfff2 == "cairo") {
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_cairo";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_cairo";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_cairo";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_cairo";
    } else if (var_74cfff2 == "mobile") {
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_mobile";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_mobile";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_mobile";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_mobile";
    } else {
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_singapore";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_singapore";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_singapore";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_singapore";
    }
    level.var_3bb399f9 = [];
    if (!isdefined(level.var_3bb399f9)) {
        level.var_3bb399f9 = [];
    } else if (!isarray(level.var_3bb399f9)) {
        level.var_3bb399f9 = array(level.var_3bb399f9);
    }
    level.var_3bb399f9[level.var_3bb399f9.size] = "cp_frontend_idle";
    if (!isdefined(level.var_3bb399f9)) {
        level.var_3bb399f9 = [];
    } else if (!isarray(level.var_3bb399f9)) {
        level.var_3bb399f9 = array(level.var_3bb399f9);
    }
    level.var_3bb399f9[level.var_3bb399f9.size] = "cp_frontend_read";
    if (!isdefined(level.var_3bb399f9)) {
        level.var_3bb399f9 = [];
    } else if (!isarray(level.var_3bb399f9)) {
        level.var_3bb399f9 = array(level.var_3bb399f9);
    }
    level.var_3bb399f9[level.var_3bb399f9.size] = "cp_frontend_work";
    if (!isdefined(level.var_3bb399f9)) {
        level.var_3bb399f9 = [];
    } else if (!isarray(level.var_3bb399f9)) {
        level.var_3bb399f9 = array(level.var_3bb399f9);
    }
    level.var_3bb399f9[level.var_3bb399f9.size] = "cp_frontend_type";
    level.var_f31ebae4 = 0;
    streamer_change(level.var_3bb399f9[level.var_f31ebae4]);
    setpbgactivebank(localclientnum, 2);
    s_scene = struct::get_script_bundle("scene", level.var_8ab87915[level.var_f31ebae4]);
    var_2af702f6 = getherogender(getequippedheroindex(localclientnum, 2), "cp");
    if (var_2af702f6 === "female" && isdefined(s_scene.femalebundle)) {
        s_scene = struct::get_script_bundle("scene", s_scene.femalebundle);
    }
    /#
        printtoprightln(s_scene.name, (1, 1, 1));
    #/
    s_align = struct::get(s_scene.aligntarget, "targetname");
    playmaincamxcam(localclientnum, s_scene.cameraswitcher, 0, "", "", s_align.origin, s_align.angles);
    for (i = 0; i < level.var_8ab87915.size; i++) {
        if (i == level.var_f31ebae4) {
            playradiantexploder(0, level.var_67da5b39[i]);
            continue;
        }
        killradiantexploder(0, level.var_67da5b39[i]);
    }
    s_params = spawnstruct();
    s_params.scene = s_scene.name;
    s_params.sessionmode = 2;
    female = 1;
    function_d8c96cea(localclientnum, level.var_74625f60, female, s_params);
    /#
        if (getdvarint("<dev string:x118>", 0)) {
            level.var_f31ebae4 = undefined;
        }
    #/
}

// Namespace frontend
// Params 4, eflags: 0x0
// Checksum 0x226a8460, Offset: 0xbb30
// Size: 0x181
function function_d8c96cea(localclientnum, data_struct, characterindex, params) {
    assert(isdefined(data_struct));
    defaultindex = undefined;
    if (isdefined(params.isdefaulthero) && params.isdefaulthero) {
        defaultindex = 0;
    }
    character_customization::set_character(data_struct, characterindex);
    charactermode = params.sessionmode;
    character_customization::set_character_mode(data_struct, charactermode);
    body = 1;
    bodycolors = character_customization::function_a4a750bd(localclientnum, charactermode, characterindex, body, params.extracam_data);
    character_customization::function_56dceb6(data_struct, charactermode, characterindex, body, bodycolors);
    head = 14;
    character_customization::function_5b80fae8(data_struct, charactermode, head);
    helmet = 0;
    helmetcolors = character_customization::function_227c64d8(localclientnum, charactermode, data_struct.characterindex, helmet, params.extracam_data);
    character_customization::function_5fa9d769(data_struct, charactermode, characterindex, helmet, helmetcolors);
    return character_customization::update(localclientnum, data_struct, params);
}

// Namespace frontend
// Params 1, eflags: 0x0
// Checksum 0x7b7f95e0, Offset: 0xbcc0
// Size: 0xf6
function function_8c70104b(localclientnum) {
    /#
        var_1fdfc146 = 8;
        if (getdvarint("<dev string:x118>", 0)) {
            if (!isdefined(level.var_e50218e7) || level.var_e50218e7 > var_1fdfc146) {
                level.var_e50218e7 = 0;
            }
        }
    #/
    s_scene = struct::get_script_bundle("scene", "cin_fe_zm_forest_vign_sitting");
    s_params = spawnstruct();
    s_params.scene = s_scene.name;
    s_params.sessionmode = 0;
    character_customization::function_d79d6d7(localclientnum, level.var_647ea5fa, level.var_e50218e7, s_params);
    /#
        if (getdvarint("<dev string:x118>", 0)) {
            level.var_e50218e7++;
        }
    #/
}

// Namespace frontend
// Params 1, eflags: 0x0
// Checksum 0x45a5d766, Offset: 0xbdc0
// Size: 0x2e2
function function_1ca6d8df(localclientnum) {
    character_index = getequippedheroindex(localclientnum, 1);
    fields = getcharacterfields(character_index, 1);
    params = spawnstruct();
    if (!isdefined(fields)) {
        fields = spawnstruct();
    }
    if (isdefined(fields.var_d0ff12a0)) {
        params.align_struct = struct::get(fields.var_d0ff12a0);
    }
    params.weapon_left = fields.var_5309507b;
    params.weapon_right = fields.var_69b4cf02;
    var_1500d96e = 1 == getequippedloadoutitemforhero(localclientnum, character_index);
    if (var_1500d96e) {
        params.anim_intro_name = fields.var_54945d04;
        params.anim_name = fields.var_37917886;
        params.weapon_left_anim_intro = fields.var_3ec4722b;
        params.weapon_left_anim = fields.var_beddabc7;
        params.weapon_right_anim_intro = fields.var_d1a6c0ee;
        params.weapon_right_anim = fields.var_a2b0a508;
    } else {
        params.anim_intro_name = fields.var_1f879308;
        params.anim_name = fields.var_d11b865a;
        params.weapon_left_anim_intro = fields.var_8ce91957;
        params.weapon_left_anim = fields.var_623e2733;
        params.weapon_right_anim_intro = fields.var_1ac723ea;
        params.weapon_right_anim = fields.var_9ebfda14;
        params.weapon = getweaponforcharacter(character_index, 1);
    }
    params.sessionmode = 1;
    changed = character_customization::function_d79d6d7(localclientnum, level.var_5b12555e, character_index, params);
    if (isdefined(level.var_5b12555e.charactermodel)) {
        level.var_5b12555e.charactermodel sethighdetail(1, 1);
        if (isdefined(params.weapon)) {
            level.var_5b12555e.charactermodel useweaponhidetags(params.weapon);
        } else {
            wait 0.016;
            level.var_5b12555e.charactermodel showallparts(localclientnum);
        }
    }
    function_19f2b8a3(localclientnum, level.var_5b12555e, changed);
}

// Namespace frontend
// Params 3, eflags: 0x0
// Checksum 0x385b3aa0, Offset: 0xc0b0
// Size: 0x403
function lobby_main(localclientnum, menu_name, state) {
    level notify(#"hash_22b30258");
    enablefrontendstreamingoverlay(localclientnum, 1);
    if (!isdefined(state) || state == "room2") {
        streamer_change();
        camera_ent = struct::get("mainmenu_frontend_camera");
        if (isdefined(camera_ent)) {
            playmaincamxcam(localclientnum, "startmenu_camera_01", 0, "cam1", "", camera_ent.origin, camera_ent.angles);
        }
    } else if (state == "room1") {
        streamer_change("core_frontend_sitting_bull");
        camera_ent = struct::get("room1_frontend_camera");
        setallcontrollerslightbarcolor((1, 0.4, 0));
        level thread pulse_controller_color();
        if (isdefined(camera_ent)) {
            playmaincamxcam(localclientnum, "startmenu_camera_01", 0, "cam1", "", camera_ent.origin, camera_ent.angles);
        }
    } else if (state == "mp_theater") {
        streamer_change("frontend_theater");
        camera_ent = struct::get("frontend_theater");
        if (isdefined(camera_ent)) {
            playmaincamxcam(localclientnum, "ui_cam_frontend_theater", 0, "cam1", "", camera_ent.origin, camera_ent.angles);
        }
    } else if (state == "mp_freerun") {
        streamer_change("frontend_freerun");
        camera_ent = struct::get("frontend_freerun");
        if (isdefined(camera_ent)) {
            playmaincamxcam(localclientnum, "ui_cam_frontend_freerun", 0, "cam1", "", camera_ent.origin, camera_ent.angles);
        }
    } else if (strstartswith(state, "cpzm")) {
        function_e5f8ef8c(localclientnum);
    } else if (strstartswith(state, "cp")) {
        enablefrontendstreamingoverlay(localclientnum, 0);
        function_fb006449(localclientnum);
        enablefrontendstreamingoverlay(localclientnum, 1);
    } else if (strstartswith(state, "mp")) {
        function_1ca6d8df(localclientnum);
    } else if (strstartswith(state, "zm")) {
        streamer_change("core_frontend_zm_lobby");
        camera_ent = struct::get("zm_frontend_camera");
        if (isdefined(camera_ent)) {
            playmaincamxcam(localclientnum, "zm_lobby_cam", 0, "default", "", camera_ent.origin, camera_ent.angles);
        }
        enablefrontendstreamingoverlay(localclientnum, 0);
        function_8c70104b(localclientnum);
    } else {
        streamer_change();
    }
    if (!isdefined(state) || state != "room1") {
        setallcontrollerslightbarcolor();
        level notify(#"end_controller_pulse");
    }
}

// Namespace frontend
// Params 4, eflags: 0x0
// Checksum 0x11012268, Offset: 0xc4c0
// Size: 0xaa
function function_1425cd9e(localclientnum, menu_name, extracam_data, state) {
    if (state == "mp_theater") {
        camera_ent = multi_extracam::extracam_init_index(localclientnum, "mp_frontend_battery", extracam_data.extracam_index);
        camera_ent playextracamxcam("ui_cam_frontend_hero_battery", extracam_data.extracam_index, "cam_mpmain", "hero01");
        return;
    }
    multi_extracam::extracam_reset_index(extracam_data.extracam_index);
}

// Namespace frontend
// Params 4, eflags: 0x0
// Checksum 0x5645c6c6, Offset: 0xc578
// Size: 0xa2
function function_3a284807(localclientnum, menu_name, extracam_data, state) {
    if (state == "mp_theater") {
        camera_ent = multi_extracam::extracam_init_index(localclientnum, "zm_frontend_camera", extracam_data.extracam_index);
        camera_ent playextracamxcam("zm_lobby_cam", extracam_data.extracam_index, "default");
        return;
    }
    multi_extracam::extracam_reset_index(extracam_data.extracam_index);
}

// Namespace frontend
// Params 4, eflags: 0x0
// Checksum 0x581c2b42, Offset: 0xc628
// Size: 0xaa
function function_c820d8cc(localclientnum, menu_name, extracam_data, state) {
    if (state == "mp_theater") {
        camera_ent = multi_extracam::extracam_init_index(localclientnum, "mp_frontend_spectre", extracam_data.extracam_index);
        camera_ent playextracamxcam("ui_cam_frontend_hero_spectre", extracam_data.extracam_index, "cam_mpmain", "hero01");
        return;
    }
    multi_extracam::extracam_reset_index(extracam_data.extracam_index);
}

// Namespace frontend
// Params 4, eflags: 0x0
// Checksum 0xb419f46c, Offset: 0xc6e0
// Size: 0xaa
function function_ee235335(localclientnum, menu_name, extracam_data, state) {
    if (state == "mp_theater") {
        camera_ent = multi_extracam::extracam_init_index(localclientnum, "mp_frontend_firebreak", extracam_data.extracam_index);
        camera_ent playextracamxcam("ui_cam_frontend_hero_firebreak", extracam_data.extracam_index, "cam_mpmain", "hero01");
        return;
    }
    multi_extracam::extracam_reset_index(extracam_data.extracam_index);
}

// Namespace frontend
// Params 0, eflags: 0x0
// Checksum 0xc24f5003, Offset: 0xc798
// Size: 0x91
function pulse_controller_color() {
    level endon(#"end_controller_pulse");
    delta_t = -0.01;
    t = 1;
    while (true) {
        setallcontrollerslightbarcolor((1 * t, 0.2 * t, 0));
        t += delta_t;
        if (t < 0.2 || t > 0.99) {
            delta_t *= -1;
        }
        wait 0.016;
    }
}

