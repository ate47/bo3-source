#using scripts/shared/array_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/end_game_taunts;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/animation_shared;
#using scripts/shared/abilities/gadgets/_gadget_camo_render;
#using scripts/codescripts/struct;
#using scripts/core/_multi_extracam;

#using_animtree("all_player");
#using_animtree("generic");

#namespace character_customization;

// Namespace character_customization
// Params 0, eflags: 0x2
// Checksum 0xf8d150b6, Offset: 0xab0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("character_customization", &__init__, undefined, undefined);
}

// Namespace character_customization
// Params 0, eflags: 0x1 linked
// Checksum 0x8ec07dc2, Offset: 0xaf0
// Size: 0x18c
function __init__() {
    level.var_81c41302 = &function_bc334e1a;
    level.var_c35758c9 = &function_cdc26129;
    level.extra_cam_render_current_hero_headshot_func_callback = &process_current_hero_headshot_extracam_request;
    level.var_ce31346 = &function_25aa300b;
    level.var_63d084fe = &function_c27b6e13;
    level.var_a89ad62b = &function_b345c4d8;
    level.extra_cam_render_character_head_item_func_callback = &process_character_head_item_extracam_request;
    level.model_type_bones = associativearray("helmet", "", "head", "");
    if (!isdefined(level.liveccdata)) {
        level.liveccdata = [];
    }
    if (!isdefined(level.custom_characters)) {
        level.custom_characters = [];
    }
    if (!isdefined(level.extra_cam_hero_data)) {
        level.extra_cam_hero_data = [];
    }
    if (!isdefined(level.var_3bd0563c)) {
        level.var_3bd0563c = [];
    }
    if (!isdefined(level.extra_cam_headshot_hero_data)) {
        level.extra_cam_headshot_hero_data = [];
    }
    if (!isdefined(level.extra_cam_outfit_preview_data)) {
        level.extra_cam_outfit_preview_data = [];
    }
    level.charactercustomizationsetup = &localclientconnect;
}

// Namespace character_customization
// Params 1, eflags: 0x1 linked
// Checksum 0xd8ec5c0d, Offset: 0xc88
// Size: 0x84
function localclientconnect(localclientnum) {
    level.liveccdata[localclientnum] = setup_live_character_customization_target(localclientnum);
    if (isdefined(level.liveccdata[localclientnum])) {
        function_f61cd9d1(level.liveccdata[localclientnum]);
    }
    level.staticccdata = setup_static_character_customization_target(localclientnum);
}

// Namespace character_customization
// Params 3, eflags: 0x1 linked
// Checksum 0xbef7c521, Offset: 0xd18
// Size: 0x418
function function_b79cb078(charactermodel, localclientnum, alt_render_mode) {
    if (!isdefined(alt_render_mode)) {
        alt_render_mode = 1;
    }
    if (!isdefined(charactermodel)) {
        return undefined;
    }
    if (!isdefined(level.custom_characters[localclientnum])) {
        level.custom_characters[localclientnum] = [];
    }
    if (isdefined(level.custom_characters[localclientnum][charactermodel.targetname])) {
        return level.custom_characters[localclientnum][charactermodel.targetname];
    }
    var_ddbfd9e3 = spawnstruct();
    level.custom_characters[localclientnum][charactermodel.targetname] = var_ddbfd9e3;
    var_ddbfd9e3.charactermodel = charactermodel;
    var_ddbfd9e3.var_b6087788 = array();
    var_ddbfd9e3.attached_models = array();
    var_ddbfd9e3.var_14726a6d = array();
    var_ddbfd9e3.origin = charactermodel.origin;
    var_ddbfd9e3.angles = charactermodel.angles;
    var_ddbfd9e3.characterindex = 0;
    var_ddbfd9e3.charactermode = 3;
    var_ddbfd9e3.var_2fee1906 = undefined;
    var_ddbfd9e3.bodyindex = 0;
    var_ddbfd9e3.bodycolors = array(0, 0, 0);
    var_ddbfd9e3.var_bf37af0a = 0;
    var_ddbfd9e3.helmetcolors = array(0, 0, 0);
    var_ddbfd9e3.headindex = 0;
    var_ddbfd9e3.align_target = undefined;
    var_ddbfd9e3.var_a5c8c7ea = undefined;
    var_ddbfd9e3.var_b1813a38 = undefined;
    var_ddbfd9e3.var_d3b4ae4f = getcharacterbodyrenderoptions(0, 0, 0, 0, 0);
    var_ddbfd9e3.var_a75d14ae = getcharacterhelmetrenderoptions(0, 0, 0, 0, 0);
    var_ddbfd9e3.var_19072699 = getcharacterheadrenderoptions(0);
    var_ddbfd9e3.var_b841ac58 = getcharactermoderenderoptions(0);
    var_ddbfd9e3.alt_render_mode = alt_render_mode;
    var_ddbfd9e3.var_62e980f = 0;
    var_ddbfd9e3.var_d11acdfe = "weapon";
    var_ddbfd9e3.show_helmets = 1;
    var_ddbfd9e3.var_418b6e8a = 0;
    var_ddbfd9e3.var_28223325 = 0;
    if (sessionmodeiscampaigngame()) {
        highestmapreached = getdstat(localclientnum, "highestMapReached");
        var_ddbfd9e3.var_28223325 = (!isdefined(highestmapreached) || highestmapreached == 0) && getdvarstring("mapname") == "core_frontend";
    }
    charactermodel sethighdetail(1, var_ddbfd9e3.alt_render_mode);
    return var_ddbfd9e3;
}

// Namespace character_customization
// Params 1, eflags: 0x0
// Checksum 0x38c1b610, Offset: 0x1138
// Size: 0xac
function function_3a4cce98(game_mode) {
    
}

// Namespace character_customization
// Params 4, eflags: 0x1 linked
// Checksum 0xd7ff6f8, Offset: 0x13f8
// Size: 0x38a
function function_d79d6d7(localclientnum, var_ddbfd9e3, characterindex, params) {
    /#
        assert(isdefined(var_ddbfd9e3));
    #/
    data_lcn = isdefined(var_ddbfd9e3.var_2fee1906) ? var_ddbfd9e3.var_2fee1906 : localclientnum;
    if (!isdefined(characterindex)) {
        characterindex = getequippedheroindex(data_lcn, params.sessionmode);
    }
    defaultindex = undefined;
    if (isdefined(params.isdefaulthero) && params.isdefaulthero) {
        defaultindex = 0;
    }
    set_character(var_ddbfd9e3, characterindex);
    charactermode = params.sessionmode;
    set_character_mode(var_ddbfd9e3, charactermode);
    body = function_7d59e996(data_lcn, charactermode, characterindex, params.extracam_data);
    bodycolors = function_a4a750bd(data_lcn, charactermode, characterindex, body, params.extracam_data);
    function_56dceb6(var_ddbfd9e3, charactermode, characterindex, body, bodycolors);
    head = function_ba2060c8(data_lcn, charactermode, params.extracam_data);
    function_5b80fae8(var_ddbfd9e3, charactermode, head);
    helmet = function_f9865c49(data_lcn, charactermode, characterindex, params.extracam_data);
    helmetcolors = function_227c64d8(data_lcn, charactermode, var_ddbfd9e3.characterindex, helmet, params.extracam_data);
    function_5fa9d769(var_ddbfd9e3, charactermode, characterindex, helmet, helmetcolors);
    if (isdefined(var_ddbfd9e3.var_418b6e8a) && var_ddbfd9e3.var_418b6e8a) {
        showcaseweapon = function_e37bf19c(data_lcn, charactermode, characterindex, params.extracam_data);
        function_f374c6fc(var_ddbfd9e3, charactermode, data_lcn, undefined, characterindex, showcaseweapon.weaponname, showcaseweapon.attachmentinfo, showcaseweapon.weaponrenderoptions, 0, 1);
    }
    return update(localclientnum, var_ddbfd9e3, params);
}

// Namespace character_customization
// Params 7, eflags: 0x1 linked
// Checksum 0xc01e0981, Offset: 0x1790
// Size: 0x514
function update_model_attachment(localclientnum, var_ddbfd9e3, attached_model, slot, model_anim, model_intro_anim, force_update) {
    /#
        assert(isdefined(var_ddbfd9e3.attached_models));
    #/
    /#
        assert(isdefined(var_ddbfd9e3.var_b6087788));
    #/
    /#
        assert(isdefined(level.model_type_bones));
    #/
    if (force_update || attached_model !== var_ddbfd9e3.attached_models[slot] || model_anim !== var_ddbfd9e3.var_b6087788[slot]) {
        bone = slot;
        if (isdefined(level.model_type_bones[slot])) {
            bone = level.model_type_bones[slot];
        }
        /#
            assert(isdefined(bone));
        #/
        if (isdefined(var_ddbfd9e3.attached_models[slot])) {
            if (isdefined(var_ddbfd9e3.var_14726a6d[slot])) {
                var_ddbfd9e3.var_14726a6d[slot] unlink();
                var_ddbfd9e3.var_14726a6d[slot] delete();
                var_ddbfd9e3.var_14726a6d[slot] = undefined;
            } else if (var_ddbfd9e3.charactermodel isattached(var_ddbfd9e3.attached_models[slot], bone)) {
                var_ddbfd9e3.charactermodel detach(var_ddbfd9e3.attached_models[slot], bone);
            }
            var_ddbfd9e3.attached_models[slot] = undefined;
        }
        var_ddbfd9e3.attached_models[slot] = attached_model;
        if (isdefined(var_ddbfd9e3.attached_models[slot])) {
            if (isdefined(model_anim)) {
                ent = spawn(localclientnum, var_ddbfd9e3.charactermodel.origin, "script_model");
                ent sethighdetail(1, var_ddbfd9e3.alt_render_mode);
                var_ddbfd9e3.var_14726a6d[slot] = ent;
                ent setmodel(var_ddbfd9e3.attached_models[slot]);
                if (!ent hasanimtree()) {
                    ent useanimtree(#generic);
                }
                ent.origin = var_ddbfd9e3.charactermodel.origin;
                ent.angles = var_ddbfd9e3.charactermodel.angles;
                ent.var_efd873ed = ent.origin;
                ent.var_81ec66f3 = ent.angles;
                ent thread play_intro_and_animation(model_intro_anim, model_anim, 1);
            } else if (!var_ddbfd9e3.charactermodel isattached(var_ddbfd9e3.attached_models[slot], bone)) {
                var_ddbfd9e3.charactermodel attach(var_ddbfd9e3.attached_models[slot], bone);
            }
            var_ddbfd9e3.var_b6087788[slot] = model_anim;
        }
    }
    if (isdefined(var_ddbfd9e3.var_14726a6d[slot])) {
        var_ddbfd9e3.var_14726a6d[slot] setbodyrenderoptions(var_ddbfd9e3.var_b841ac58, var_ddbfd9e3.var_d3b4ae4f, var_ddbfd9e3.var_a75d14ae, var_ddbfd9e3.var_19072699);
    }
}

// Namespace character_customization
// Params 2, eflags: 0x1 linked
// Checksum 0x27b5d188, Offset: 0x1cb0
// Size: 0x28
function set_character(var_ddbfd9e3, characterindex) {
    var_ddbfd9e3.characterindex = characterindex;
}

// Namespace character_customization
// Params 2, eflags: 0x1 linked
// Checksum 0xec73505a, Offset: 0x1ce0
// Size: 0x68
function set_character_mode(var_ddbfd9e3, charactermode) {
    /#
        assert(isdefined(charactermode));
    #/
    var_ddbfd9e3.charactermode = charactermode;
    var_ddbfd9e3.var_b841ac58 = getcharactermoderenderoptions(charactermode);
}

// Namespace character_customization
// Params 5, eflags: 0x1 linked
// Checksum 0xb3943ca1, Offset: 0x1d50
// Size: 0x1cc
function function_56dceb6(var_ddbfd9e3, mode, characterindex, bodyindex, bodycolors) {
    /#
        assert(isdefined(mode));
    #/
    /#
        assert(mode != 3);
    #/
    if (isdefined(var_ddbfd9e3.var_28223325) && mode == 2 && var_ddbfd9e3.var_28223325) {
        bodyindex = 1;
    }
    var_ddbfd9e3.bodyindex = bodyindex;
    var_ddbfd9e3.bodymodel = getcharacterbodymodel(characterindex, bodyindex, mode);
    if (isdefined(var_ddbfd9e3.bodymodel)) {
        var_ddbfd9e3.charactermodel setmodel(var_ddbfd9e3.bodymodel);
    }
    if (isdefined(bodycolors)) {
        function_b36a5f9d(var_ddbfd9e3, mode, bodycolors);
    }
    render_options = getcharacterbodyrenderoptions(var_ddbfd9e3.characterindex, var_ddbfd9e3.bodyindex, var_ddbfd9e3.bodycolors[0], var_ddbfd9e3.bodycolors[1], var_ddbfd9e3.bodycolors[2]);
    var_ddbfd9e3.var_d3b4ae4f = render_options;
}

// Namespace character_customization
// Params 3, eflags: 0x1 linked
// Checksum 0x36da94c7, Offset: 0x1f28
// Size: 0x7e
function function_b36a5f9d(var_ddbfd9e3, mode, bodycolors) {
    for (i = 0; i < bodycolors.size && i < bodycolors.size; i++) {
        function_f87a1792(var_ddbfd9e3, i, bodycolors[i]);
    }
}

// Namespace character_customization
// Params 3, eflags: 0x1 linked
// Checksum 0xf3f5d371, Offset: 0x1fb0
// Size: 0xbc
function function_f87a1792(var_ddbfd9e3, var_6f15f34e, colorindex) {
    var_ddbfd9e3.bodycolors[var_6f15f34e] = colorindex;
    render_options = getcharacterbodyrenderoptions(var_ddbfd9e3.characterindex, var_ddbfd9e3.bodyindex, var_ddbfd9e3.bodycolors[0], var_ddbfd9e3.bodycolors[1], var_ddbfd9e3.bodycolors[2]);
    var_ddbfd9e3.var_d3b4ae4f = render_options;
}

// Namespace character_customization
// Params 3, eflags: 0x1 linked
// Checksum 0x28a683a9, Offset: 0x2078
// Size: 0x8c
function function_5b80fae8(var_ddbfd9e3, mode, headindex) {
    var_ddbfd9e3.headindex = headindex;
    var_ddbfd9e3.headmodel = getcharacterheadmodel(headindex, mode);
    render_options = getcharacterheadrenderoptions(headindex);
    var_ddbfd9e3.var_19072699 = render_options;
}

// Namespace character_customization
// Params 5, eflags: 0x1 linked
// Checksum 0x26b32404, Offset: 0x2110
// Size: 0x84
function function_5fa9d769(var_ddbfd9e3, mode, characterindex, var_bf37af0a, helmetcolors) {
    var_ddbfd9e3.var_bf37af0a = var_bf37af0a;
    var_ddbfd9e3.var_f1a3fa15 = getcharacterhelmetmodel(characterindex, var_bf37af0a, mode);
    function_f8e56a38(var_ddbfd9e3, helmetcolors);
}

// Namespace character_customization
// Params a, eflags: 0x1 linked
// Checksum 0x88493af2, Offset: 0x21a0
// Size: 0xbcc
function function_f374c6fc(var_ddbfd9e3, mode, localclientnum, xuid, characterindex, var_a7a58d47, var_93ecb41d, weaponrenderoptions, var_58d20c34, var_974ed5f5) {
    if (isdefined(xuid)) {
        setshowcaseweaponpaintshopxuid(localclientnum, xuid);
    } else {
        setshowcaseweaponpaintshopxuid(localclientnum);
    }
    var_ddbfd9e3.var_a7a58d47 = var_a7a58d47;
    var_ddbfd9e3.var_8f9c1e31 = getweaponwithattachments(var_a7a58d47);
    if (var_ddbfd9e3.var_8f9c1e31 == getweapon("none")) {
        var_ddbfd9e3.var_8f9c1e31 = getweapon("ar_standard");
        var_ddbfd9e3.var_a7a58d47 = var_ddbfd9e3.var_8f9c1e31.name;
    }
    attachmentnames = [];
    var_9853d5dd = [];
    tokenizedattachmentinfo = strtok(var_93ecb41d, ",");
    for (index = 0; index + 1 < tokenizedattachmentinfo.size; index += 2) {
        attachmentnames[attachmentnames.size] = tokenizedattachmentinfo[index];
        var_9853d5dd[var_9853d5dd.size] = int(tokenizedattachmentinfo[index + 1]);
    }
    for (index = tokenizedattachmentinfo.size; index + 1 < 16; index += 2) {
        attachmentnames[attachmentnames.size] = "none";
        var_9853d5dd[var_9853d5dd.size] = 0;
    }
    var_ddbfd9e3.var_65ce895e = getattachmentcosmeticvariantindexes(var_ddbfd9e3.var_8f9c1e31, attachmentnames[0], var_9853d5dd[0], attachmentnames[1], var_9853d5dd[1], attachmentnames[2], var_9853d5dd[2], attachmentnames[3], var_9853d5dd[3], attachmentnames[4], var_9853d5dd[4], attachmentnames[5], var_9853d5dd[5], attachmentnames[6], var_9853d5dd[6], attachmentnames[7], var_9853d5dd[7]);
    camoindex = 0;
    paintjobslot = 15;
    paintjobindex = 15;
    showpaintshop = 0;
    tokenizedweaponrenderoptions = strtok(weaponrenderoptions, ",");
    if (tokenizedweaponrenderoptions.size > 2) {
        camoindex = int(tokenizedweaponrenderoptions[0]);
        paintjobslot = int(tokenizedweaponrenderoptions[1]);
        paintjobindex = int(tokenizedweaponrenderoptions[2]);
        showpaintshop = paintjobslot != 15 && paintjobindex != 15;
    }
    var_ab7e5449 = 0;
    if (var_58d20c34) {
        var_ab7e5449 = 1;
    } else if (var_974ed5f5) {
        var_ab7e5449 = 2;
    }
    var_ddbfd9e3.weaponrenderoptions = calcweaponoptions(localclientnum, camoindex, 0, 0, 0, 0, showpaintshop, var_ab7e5449);
    var_59883122 = var_ddbfd9e3.var_8f9c1e31.rootweapon.name;
    var_17092b81 = var_ddbfd9e3.var_8f9c1e31.isdualwield;
    weapon_group = getitemgroupforweaponname(var_59883122);
    if (weapon_group == "weapon_launcher") {
        if (var_59883122 == "launcher_lockonly" || var_59883122 == "launcher_multi") {
            weapon_group = "weapon_launcher_alt";
        } else if (var_59883122 == "launcher_ex41") {
            weapon_group = "weapon_smg_ppsh";
        }
    } else if (weapon_group == "weapon_assault") {
        if (var_59883122 == "ar_m14") {
            weapon_group = "weapon_shotgun_olympia";
        }
    } else if (weapon_group == "weapon_pistol" && var_17092b81) {
        weapon_group = "weapon_pistol_dw";
    } else if (weapon_group == "weapon_smg") {
        if (var_59883122 == "smg_ppsh") {
            weapon_group = "weapon_smg_ppsh";
        } else if (var_59883122 == "smg_sten2") {
            weapon_group = "weapon_knuckles";
        }
    } else if (weapon_group == "weapon_cqb") {
        if (var_59883122 == "shotgun_olympia") {
            weapon_group = "weapon_shotgun_olympia";
        }
    } else if (weapon_group == "weapon_special") {
        if (var_59883122 == "special_crossbow" || var_59883122 == "special_discgun") {
            weapon_group = "weapon_smg";
        } else if (var_59883122 == "special_crossbow_dw") {
            weapon_group = "weapon_pistol_dw";
        } else if (var_59883122 == "knife_ballistic") {
            weapon_group = "weapon_knife_ballistic";
        }
    } else if (weapon_group == "weapon_knife") {
        if (var_59883122 == "melee_knuckles" || var_59883122 == "melee_boxing") {
            weapon_group = "weapon_knuckles";
        } else if (var_59883122 == "melee_chainsaw" || var_59883122 == "melee_boneglass" || var_59883122 == "melee_crescent") {
            weapon_group = "weapon_chainsaw";
        } else if (var_59883122 == "melee_improvise" || var_59883122 == "melee_shovel") {
            weapon_group = "weapon_improvise";
        } else if (var_59883122 == "melee_wrench" || var_59883122 == "melee_crowbar" || var_59883122 == "melee_shockbaton") {
            weapon_group = "weapon_wrench";
        } else if (var_59883122 == "melee_nunchuks") {
            weapon_group = "weapon_nunchucks";
        } else if (var_59883122 == "melee_sword" || var_59883122 == "melee_bat" || var_59883122 == "melee_fireaxe" || var_59883122 == "melee_mace" || var_59883122 == "melee_katana") {
            weapon_group = "weapon_sword";
        } else if (var_59883122 == "melee_prosthetic") {
            weapon_group = "weapon_prosthetic";
        }
    } else if (weapon_group == "miscweapon") {
        if (var_59883122 == "blackjack_coin") {
            weapon_group = "brawler";
        } else if (var_59883122 == "blackjack_cards") {
            weapon_group = "brawler";
        }
    }
    if (var_ddbfd9e3.charactermode === 0) {
        var_ddbfd9e3.anim_name = "pb_cac_rifle_showcase_cp";
        return;
    }
    if (isdefined(associativearray("weapon_smg", "pb_cac_smg_showcase", "weapon_assault", "pb_cac_rifle_showcase", "weapon_cqb", "pb_cac_rifle_showcase", "weapon_lmg", "pb_cac_rifle_showcase", "weapon_sniper", "pb_cac_sniper_showcase", "weapon_pistol", "pb_cac_pistol_showcase", "weapon_pistol_dw", "pb_cac_pistol_dw_showcase", "weapon_launcher", "pb_cac_launcher_showcase", "weapon_launcher_alt", "pb_cac_launcher_alt_showcase", "weapon_knife", "pb_cac_knife_showcase", "weapon_knuckles", "pb_cac_brass_knuckles_showcase", "weapon_wrench", "pb_cac_wrench_showcase", "weapon_improvise", "pb_cac_improvise_showcase", "weapon_sword", "pb_cac_sword_showcase", "weapon_nunchucks", "pb_cac_nunchucks_showcase", "weapon_mace", "pb_cac_sword_showcase", "brawler", "pb_cac_brawler_showcase", "weapon_prosthetic", "pb_cac_prosthetic_arm_showcase", "weapon_chainsaw", "pb_cac_chainsaw_showcase", "weapon_smg_ppsh", "pb_cac_smg_ppsh_showcase", "weapon_knife_ballistic", "pb_cac_b_knife_showcase", "weapon_shotgun_olympia", "pb_cac_shotgun_olympia_showcase")[weapon_group])) {
        var_ddbfd9e3.anim_name = associativearray("weapon_smg", "pb_cac_smg_showcase", "weapon_assault", "pb_cac_rifle_showcase", "weapon_cqb", "pb_cac_rifle_showcase", "weapon_lmg", "pb_cac_rifle_showcase", "weapon_sniper", "pb_cac_sniper_showcase", "weapon_pistol", "pb_cac_pistol_showcase", "weapon_pistol_dw", "pb_cac_pistol_dw_showcase", "weapon_launcher", "pb_cac_launcher_showcase", "weapon_launcher_alt", "pb_cac_launcher_alt_showcase", "weapon_knife", "pb_cac_knife_showcase", "weapon_knuckles", "pb_cac_brass_knuckles_showcase", "weapon_wrench", "pb_cac_wrench_showcase", "weapon_improvise", "pb_cac_improvise_showcase", "weapon_sword", "pb_cac_sword_showcase", "weapon_nunchucks", "pb_cac_nunchucks_showcase", "weapon_mace", "pb_cac_sword_showcase", "brawler", "pb_cac_brawler_showcase", "weapon_prosthetic", "pb_cac_prosthetic_arm_showcase", "weapon_chainsaw", "pb_cac_chainsaw_showcase", "weapon_smg_ppsh", "pb_cac_smg_ppsh_showcase", "weapon_knife_ballistic", "pb_cac_b_knife_showcase", "weapon_shotgun_olympia", "pb_cac_shotgun_olympia_showcase")[weapon_group];
    }
}

// Namespace character_customization
// Params 2, eflags: 0x1 linked
// Checksum 0xda774788, Offset: 0x2d78
// Size: 0x104
function function_f8e56a38(var_ddbfd9e3, colors) {
    for (i = 0; i < colors.size && i < var_ddbfd9e3.helmetcolors.size; i++) {
        function_883d8451(var_ddbfd9e3, i, colors[i]);
    }
    render_options = getcharacterhelmetrenderoptions(var_ddbfd9e3.characterindex, var_ddbfd9e3.var_bf37af0a, var_ddbfd9e3.helmetcolors[0], var_ddbfd9e3.helmetcolors[1], var_ddbfd9e3.helmetcolors[2]);
    var_ddbfd9e3.var_a75d14ae = render_options;
}

// Namespace character_customization
// Params 3, eflags: 0x1 linked
// Checksum 0x91b57759, Offset: 0x2e88
// Size: 0xbc
function function_883d8451(var_ddbfd9e3, var_6f15f34e, colorindex) {
    var_ddbfd9e3.helmetcolors[var_6f15f34e] = colorindex;
    render_options = getcharacterhelmetrenderoptions(var_ddbfd9e3.characterindex, var_ddbfd9e3.var_bf37af0a, var_ddbfd9e3.helmetcolors[0], var_ddbfd9e3.helmetcolors[1], var_ddbfd9e3.helmetcolors[2]);
    var_ddbfd9e3.var_a75d14ae = render_options;
}

// Namespace character_customization
// Params 3, eflags: 0x1 linked
// Checksum 0xa763d5bc, Offset: 0x2f50
// Size: 0x304
function update(localclientnum, var_ddbfd9e3, params) {
    var_ddbfd9e3.charactermodel setbodyrenderoptions(var_ddbfd9e3.var_b841ac58, var_ddbfd9e3.var_d3b4ae4f, var_ddbfd9e3.var_a75d14ae, var_ddbfd9e3.var_19072699);
    var_88932ad4 = "tag_origin";
    var_8f53ef86 = !isdefined(params) || var_ddbfd9e3.show_helmets && !(isdefined(params.hide_helmet) && params.hide_helmet);
    if (var_8f53ef86) {
        var_88932ad4 = var_ddbfd9e3.var_f1a3fa15;
    }
    update_model_attachment(localclientnum, var_ddbfd9e3, var_88932ad4, "helmet", undefined, undefined, 1);
    head_model = var_ddbfd9e3.headmodel;
    if (var_8f53ef86 && isdefined(params) && getcharacterhelmethideshead(var_ddbfd9e3.characterindex, var_ddbfd9e3.var_bf37af0a, isdefined(params.sessionmode) ? params.sessionmode : var_ddbfd9e3.charactermode)) {
        /#
            assert(var_88932ad4 != "script_model");
        #/
        head_model = "tag_origin";
    }
    update_model_attachment(localclientnum, var_ddbfd9e3, head_model, "head", undefined, undefined, 1);
    changed = function_873d37c(localclientnum, var_ddbfd9e3, params);
    var_ddbfd9e3.charactermodel.bodymodel = var_ddbfd9e3.bodymodel;
    var_ddbfd9e3.charactermodel.var_f1a3fa15 = var_ddbfd9e3.var_f1a3fa15;
    var_ddbfd9e3.charactermodel.var_957cc42 = var_ddbfd9e3.var_b841ac58;
    var_ddbfd9e3.charactermodel.var_6f30937d = var_ddbfd9e3.var_d3b4ae4f;
    var_ddbfd9e3.charactermodel.var_d44a8060 = var_ddbfd9e3.var_a75d14ae;
    var_ddbfd9e3.charactermodel.var_ebda9e17 = var_ddbfd9e3.var_19072699;
    return changed;
}

// Namespace character_customization
// Params 1, eflags: 0x1 linked
// Checksum 0x329c6342, Offset: 0x3260
// Size: 0xe4
function function_ddd0628f(var_ddbfd9e3) {
    if (isdefined(var_ddbfd9e3.charactermodel)) {
        if (!var_ddbfd9e3.charactermodel isstreamed()) {
            return false;
        }
    }
    foreach (ent in var_ddbfd9e3.var_14726a6d) {
        if (isdefined(ent)) {
            if (!ent isstreamed()) {
                return false;
            }
        }
    }
    return true;
}

// Namespace character_customization
// Params 1, eflags: 0x1 linked
// Checksum 0x6f785b67, Offset: 0x3350
// Size: 0xf2
function function_f61cd9d1(var_ddbfd9e3) {
    if (isdefined(var_ddbfd9e3.charactermodel)) {
        var_ddbfd9e3.charactermodel sethighdetail(1, var_ddbfd9e3.alt_render_mode);
    }
    foreach (ent in var_ddbfd9e3.var_14726a6d) {
        if (isdefined(ent)) {
            ent sethighdetail(1, var_ddbfd9e3.alt_render_mode);
        }
    }
}

// Namespace character_customization
// Params 1, eflags: 0x0
// Checksum 0xfeb99280, Offset: 0x3450
// Size: 0x22
function get_character_mode(localclientnum) {
    return getequippedheromode(localclientnum);
}

// Namespace character_customization
// Params 4, eflags: 0x1 linked
// Checksum 0x2385b98a, Offset: 0x3480
// Size: 0x24c
function function_7d59e996(localclientnum, charactermode, characterindex, var_66ec6e) {
    /#
        assert(isdefined(characterindex));
    #/
    if (charactermode === 2 && sessionmodeiscampaigngame() && getdvarstring("mapname") == "core_frontend") {
        var_5fc3b52f = getdstat(localclientnum, "highestMapReached");
        if (isdefined(var_5fc3b52f) && var_5fc3b52f < 1) {
            var_2af702f6 = getherogender(getequippedheroindex(localclientnum, 2), "cp");
            var_e1e06c8 = getcharacterbodystyleindex(var_2af702f6 == "female", "CPUI_OUTFIT_PROLOGUE");
            return var_e1e06c8;
        }
    }
    if (isdefined(var_66ec6e.isdefaulthero) && isdefined(var_66ec6e) && var_66ec6e.isdefaulthero) {
        return 0;
    }
    if (isdefined(var_66ec6e) && var_66ec6e.var_9d818304) {
        return getequippedbodyindexforhero(localclientnum, charactermode, var_66ec6e.jobindex, 1);
    }
    if (isdefined(var_66ec6e) && isdefined(var_66ec6e.var_59ecf1ca)) {
        return var_66ec6e.var_59ecf1ca;
    }
    if (isdefined(var_66ec6e.defaultimagerender) && isdefined(var_66ec6e) && var_66ec6e.defaultimagerender) {
        return 0;
    }
    return getequippedbodyindexforhero(localclientnum, charactermode, characterindex);
}

// Namespace character_customization
// Params 6, eflags: 0x1 linked
// Checksum 0xefb6bf0e, Offset: 0x36d8
// Size: 0x11c
function function_87ec3132(localclientnum, charactermode, characterindex, bodyindex, var_6f15f34e, var_66ec6e) {
    if (isdefined(var_66ec6e.isdefaulthero) && isdefined(var_66ec6e) && var_66ec6e.isdefaulthero) {
        return 0;
    }
    if (isdefined(var_66ec6e) && var_66ec6e.var_9d818304) {
        return getequippedbodyaccentcolorforhero(localclientnum, charactermode, var_66ec6e.jobindex, bodyindex, var_6f15f34e, 1);
    }
    if (isdefined(var_66ec6e.defaultimagerender) && isdefined(var_66ec6e) && var_66ec6e.defaultimagerender) {
        return 0;
    }
    return getequippedbodyaccentcolorforhero(localclientnum, charactermode, characterindex, bodyindex, var_6f15f34e);
}

// Namespace character_customization
// Params 5, eflags: 0x1 linked
// Checksum 0xc6081c42, Offset: 0x3800
// Size: 0xf4
function function_a4a750bd(localclientnum, charactermode, characterindex, bodyindex, var_66ec6e) {
    var_a86f93e5 = getbodyaccentcolorcountforhero(localclientnum, charactermode, characterindex, bodyindex);
    colors = [];
    for (i = 0; i < 3; i++) {
        colors[i] = 0;
    }
    for (i = 0; i < var_a86f93e5; i++) {
        colors[i] = function_87ec3132(localclientnum, charactermode, characterindex, bodyindex, i, var_66ec6e);
    }
    return colors;
}

// Namespace character_customization
// Params 3, eflags: 0x1 linked
// Checksum 0xc705f92e, Offset: 0x3900
// Size: 0x11c
function function_ba2060c8(localclientnum, charactermode, var_66ec6e) {
    if (isdefined(var_66ec6e.isdefaulthero) && isdefined(var_66ec6e) && var_66ec6e.isdefaulthero) {
        return 0;
    }
    if (isdefined(var_66ec6e) && var_66ec6e.var_9d818304) {
        return getequippedheadindexforhero(localclientnum, charactermode, var_66ec6e.jobindex);
    }
    if (isdefined(var_66ec6e) && isdefined(var_66ec6e.useheadindex)) {
        return var_66ec6e.useheadindex;
    }
    if (isdefined(var_66ec6e.defaultimagerender) && isdefined(var_66ec6e) && var_66ec6e.defaultimagerender) {
        return 0;
    }
    return getequippedheadindexforhero(localclientnum, charactermode);
}

// Namespace character_customization
// Params 4, eflags: 0x1 linked
// Checksum 0xc2b5987f, Offset: 0x3a28
// Size: 0x12c
function function_f9865c49(localclientnum, charactermode, characterindex, var_66ec6e) {
    if (isdefined(var_66ec6e.isdefaulthero) && isdefined(var_66ec6e) && var_66ec6e.isdefaulthero) {
        return 0;
    }
    if (isdefined(var_66ec6e) && var_66ec6e.var_9d818304) {
        return getequippedhelmetindexforhero(localclientnum, charactermode, var_66ec6e.jobindex, 1);
    }
    if (isdefined(var_66ec6e) && isdefined(var_66ec6e.var_3c23be53)) {
        return var_66ec6e.var_3c23be53;
    }
    if (isdefined(var_66ec6e.defaultimagerender) && isdefined(var_66ec6e) && var_66ec6e.defaultimagerender) {
        return 0;
    }
    return getequippedhelmetindexforhero(localclientnum, charactermode, characterindex);
}

// Namespace character_customization
// Params 4, eflags: 0x1 linked
// Checksum 0x70bce869, Offset: 0x3b60
// Size: 0xf4
function function_e37bf19c(localclientnum, charactermode, characterindex, var_66ec6e) {
    if (isdefined(var_66ec6e.isdefaulthero) && isdefined(var_66ec6e) && var_66ec6e.isdefaulthero) {
        return undefined;
    }
    if (isdefined(var_66ec6e) && var_66ec6e.var_9d818304) {
        return getequippedshowcaseweaponforhero(localclientnum, charactermode, var_66ec6e.jobindex, 1);
    }
    if (isdefined(var_66ec6e) && isdefined(var_66ec6e.var_77b585e5)) {
        return var_66ec6e.var_77b585e5;
    }
    return getequippedshowcaseweaponforhero(localclientnum, charactermode, characterindex);
}

// Namespace character_customization
// Params 6, eflags: 0x1 linked
// Checksum 0x7f254641, Offset: 0x3c60
// Size: 0x11c
function function_6abaf171(localclientnum, charactermode, characterindex, var_bf37af0a, var_6f15f34e, var_66ec6e) {
    if (isdefined(var_66ec6e.isdefaulthero) && isdefined(var_66ec6e) && var_66ec6e.isdefaulthero) {
        return 0;
    }
    if (isdefined(var_66ec6e) && var_66ec6e.var_9d818304) {
        return getequippedhelmetaccentcolorforhero(localclientnum, charactermode, var_66ec6e.jobindex, var_bf37af0a, var_6f15f34e, 1);
    }
    if (isdefined(var_66ec6e.defaultimagerender) && isdefined(var_66ec6e) && var_66ec6e.defaultimagerender) {
        return 0;
    }
    return getequippedhelmetaccentcolorforhero(localclientnum, charactermode, characterindex, var_bf37af0a, var_6f15f34e);
}

// Namespace character_customization
// Params 5, eflags: 0x1 linked
// Checksum 0xba60c942, Offset: 0x3d88
// Size: 0xf4
function function_227c64d8(localclientnum, charactermode, characterindex, var_bf37af0a, var_66ec6e) {
    var_54f15524 = gethelmetaccentcolorcountforhero(localclientnum, charactermode, characterindex, var_bf37af0a);
    colors = [];
    for (i = 0; i < 3; i++) {
        colors[i] = 0;
    }
    for (i = 0; i < var_54f15524; i++) {
        colors[i] = function_6abaf171(localclientnum, charactermode, characterindex, var_bf37af0a, i, var_66ec6e);
    }
    return colors;
}

// Namespace character_customization
// Params 1, eflags: 0x1 linked
// Checksum 0xff379647, Offset: 0x3e88
// Size: 0x44
function function_2142a641(charactermodel) {
    if (!charactermodel hasanimtree()) {
        charactermodel useanimtree(#all_player);
    }
}

// Namespace character_customization
// Params 1, eflags: 0x1 linked
// Checksum 0x225eaff0, Offset: 0x3ed8
// Size: 0xc8
function function_40b8ba(params) {
    if (isdefined(params.weapon_right) && params.weapon_right == "wpn_t7_hero_reaper_minigun_prop" && isdefined(level.var_5b12555e.charactermodel) && issubstr(level.var_5b12555e.charactermodel.model, "body3")) {
        params.weapon_right = "wpn_t7_loot_hero_reaper3_minigun_prop";
        params.weapon = getweapon("hero_minigun_body3");
        return true;
    }
    return false;
}

// Namespace character_customization
// Params 3, eflags: 0x1 linked
// Checksum 0x796d2f6f, Offset: 0x3fa8
// Size: 0x4d4
function function_fd188096(localclientnum, var_ddbfd9e3, params) {
    fields = getcharacterfields(var_ddbfd9e3.characterindex, var_ddbfd9e3.charactermode);
    if (var_ddbfd9e3.var_d11acdfe == "weapon") {
        if (isdefined(fields.var_a58a63b2)) {
            params.anim_name = fields.var_a58a63b2;
        }
        params.scene = undefined;
        if (isdefined(fields.var_8bf65b3)) {
            params.weapon_left = fields.var_8bf65b3;
        }
        if (isdefined(fields.var_1eb5dbdb)) {
            params.weapon_left_anim = fields.var_1eb5dbdb;
        }
        if (isdefined(fields.var_49430442)) {
            params.weapon_right = fields.var_49430442;
        }
        if (isdefined(fields.var_f2fe4e54)) {
            params.weapon_right_anim = fields.var_f2fe4e54;
        }
        if (isdefined(fields.var_4635da0c)) {
            params.exploder_id = fields.var_4635da0c;
        }
        if (isdefined(struct::get(fields.var_4e6dd005))) {
            params.align_struct = struct::get(fields.var_4e6dd005);
        }
        if (isdefined(fields.var_32517f52)) {
            params.xcam = fields.var_32517f52;
        }
        if (isdefined(fields.var_4b2ece39)) {
            params.subxcam = fields.var_4b2ece39;
        }
        if (isdefined(fields.var_a61911f5)) {
            params.xcamframe = fields.var_a61911f5;
        }
    } else if (var_ddbfd9e3.var_d11acdfe == "ability") {
        if (isdefined(fields.var_7eecb64e)) {
            params.anim_name = fields.var_7eecb64e;
        }
        params.scene = undefined;
        if (isdefined(fields.var_b59ca217)) {
            params.weapon_left = fields.var_b59ca217;
        }
        if (isdefined(fields.var_631e94bf)) {
            params.weapon_left_anim = fields.var_631e94bf;
        }
        if (isdefined(fields.var_bb57939e)) {
            params.weapon_right = fields.var_bb57939e;
        }
        if (isdefined(fields.var_2e64080)) {
            params.weapon_right_anim = fields.var_2e64080;
        }
        if (isdefined(fields.var_b46f15b8)) {
            params.exploder_id = fields.var_b46f15b8;
        }
        if (isdefined(struct::get(fields.var_a5b9d889))) {
            params.align_struct = struct::get(fields.var_a5b9d889);
        }
        if (isdefined(fields.var_538075fe)) {
            params.xcam = fields.var_538075fe;
        }
        if (isdefined(fields.var_f621fcd)) {
            params.subxcam = fields.var_f621fcd;
        }
        if (isdefined(fields.var_502195e1)) {
            params.xcamframe = fields.var_502195e1;
        }
    }
    function_40b8ba(params);
    if (!isdefined(params.align_struct)) {
        params.align_struct = var_ddbfd9e3;
    }
}

// Namespace character_customization
// Params 3, eflags: 0x1 linked
// Checksum 0xbba413b5, Offset: 0x4488
// Size: 0xac
function play_intro_and_animation(intro_anim_name, anim_name, b_keep_link) {
    self notify(#"hash_4ff7fd85");
    self endon(#"hash_4ff7fd85");
    if (isdefined(intro_anim_name)) {
        self animation::play(intro_anim_name, self.var_efd873ed, self.var_81ec66f3, 1, 0, 0, 0, b_keep_link);
    }
    self animation::play(anim_name, self.var_efd873ed, self.var_81ec66f3, 1, 0, 0, 0, b_keep_link);
}

// Namespace character_customization
// Params 2, eflags: 0x1 linked
// Checksum 0x198f8b20, Offset: 0x4540
// Size: 0x6c
function function_e6f3ac24(var_ddbfd9e3, params) {
    if (!isdefined(params.weapon_right) && !isdefined(params.weapon_left)) {
        if (isdefined(var_ddbfd9e3.anim_name)) {
            params.anim_name = var_ddbfd9e3.anim_name;
        }
    }
}

// Namespace character_customization
// Params 3, eflags: 0x1 linked
// Checksum 0xfc2dfaee, Offset: 0x45b8
// Size: 0x88c
function function_873d37c(localclientnum, var_ddbfd9e3, params) {
    changed = 0;
    if (!isdefined(params)) {
        params = spawnstruct();
    }
    if (var_ddbfd9e3.var_62e980f && isdefined(var_ddbfd9e3.var_d11acdfe)) {
        function_fd188096(localclientnum, var_ddbfd9e3, params);
    }
    if (!isdefined(params.exploder_id)) {
        params.exploder_id = var_ddbfd9e3.default_exploder;
    }
    align_changed = 0;
    if (!isdefined(params.align_struct)) {
        params.align_struct = struct::get(var_ddbfd9e3.align_target);
    }
    if (!isdefined(params.align_struct)) {
        params.align_struct = var_ddbfd9e3;
    }
    if (params.align_struct.origin !== var_ddbfd9e3.charactermodel.var_efd873ed || isdefined(params.align_struct) && params.align_struct.angles !== var_ddbfd9e3.charactermodel.var_81ec66f3) {
        var_ddbfd9e3.charactermodel.var_efd873ed = params.align_struct.origin;
        var_ddbfd9e3.charactermodel.var_81ec66f3 = params.align_struct.angles;
        params.anim_name = isdefined(params.anim_name) ? params.anim_name : var_ddbfd9e3.var_a5c8c7ea;
        align_changed = 1;
    }
    if (isdefined(var_ddbfd9e3.var_418b6e8a) && var_ddbfd9e3.var_418b6e8a) {
        function_e6f3ac24(var_ddbfd9e3, params);
    }
    if (function_40b8ba(params)) {
        align_changed = 1;
        changed = 1;
    }
    if (isdefined(params.weapon_right) && params.weapon_right !== var_ddbfd9e3.weapon_right) {
        align_changed = 1;
    }
    if (params.anim_name !== var_ddbfd9e3.var_a5c8c7ea || isdefined(params.anim_name) && align_changed) {
        changed = 1;
        namespace_3cadf69b::function_7222354d(localclientnum, var_ddbfd9e3.charactermodel);
        namespace_3cadf69b::function_1926278(var_ddbfd9e3.charactermodel);
        var_ddbfd9e3.var_a5c8c7ea = params.anim_name;
        var_ddbfd9e3.weapon_right = params.weapon_right;
        if (!var_ddbfd9e3.charactermodel hasanimtree()) {
            var_ddbfd9e3.charactermodel useanimtree(#all_player);
        }
        var_ddbfd9e3.charactermodel thread play_intro_and_animation(params.anim_intro_name, params.anim_name, 0);
    } else if (isdefined(params.scene) && params.scene !== var_ddbfd9e3.var_b1813a38) {
        if (isdefined(var_ddbfd9e3.var_b1813a38)) {
            level scene::stop(var_ddbfd9e3.var_b1813a38, 0);
        }
        function_2142a641(var_ddbfd9e3.charactermodel);
        var_ddbfd9e3.var_b1813a38 = params.scene;
        level thread scene::play(params.scene);
    }
    if (var_ddbfd9e3.exploder_id !== params.exploder_id) {
        if (isdefined(var_ddbfd9e3.exploder_id)) {
            killradiantexploder(localclientnum, var_ddbfd9e3.exploder_id);
        }
        if (isdefined(params.exploder_id)) {
            playradiantexploder(localclientnum, params.exploder_id);
        }
        var_ddbfd9e3.exploder_id = params.exploder_id;
    }
    if (isdefined(params.weapon_right) || isdefined(params.weapon_left)) {
        update_model_attachment(localclientnum, var_ddbfd9e3, params.weapon_right, "tag_weapon_right", params.weapon_right_anim, params.weapon_right_anim_intro, align_changed);
        update_model_attachment(localclientnum, var_ddbfd9e3, params.weapon_left, "tag_weapon_left", params.weapon_left_anim, params.weapon_left_anim_intro, align_changed);
    } else if (isdefined(var_ddbfd9e3.var_8f9c1e31)) {
        if (isdefined(var_ddbfd9e3.attached_models["tag_weapon_right"]) && var_ddbfd9e3.charactermodel isattached(var_ddbfd9e3.attached_models["tag_weapon_right"], "tag_weapon_right")) {
            var_ddbfd9e3.charactermodel detach(var_ddbfd9e3.attached_models["tag_weapon_right"], "tag_weapon_right");
        }
        if (isdefined(var_ddbfd9e3.attached_models["tag_weapon_left"]) && var_ddbfd9e3.charactermodel isattached(var_ddbfd9e3.attached_models["tag_weapon_left"], "tag_weapon_left")) {
            var_ddbfd9e3.charactermodel detach(var_ddbfd9e3.attached_models["tag_weapon_left"], "tag_weapon_left");
        }
        var_ddbfd9e3.charactermodel attachweapon(var_ddbfd9e3.var_8f9c1e31, var_ddbfd9e3.weaponrenderoptions, var_ddbfd9e3.var_65ce895e);
        var_ddbfd9e3.charactermodel useweaponhidetags(var_ddbfd9e3.var_8f9c1e31);
        var_ddbfd9e3.charactermodel.showcaseweapon = var_ddbfd9e3.var_8f9c1e31;
        var_ddbfd9e3.charactermodel.var_7ff9e1d4 = var_ddbfd9e3.weaponrenderoptions;
        var_ddbfd9e3.charactermodel.var_4b073b25 = var_ddbfd9e3.var_65ce895e;
    }
    return changed;
}

// Namespace character_customization
// Params 3, eflags: 0x1 linked
// Checksum 0x14272d55, Offset: 0x4e50
// Size: 0x118
function function_b0a8e76d(localclientnum, var_ddbfd9e3, var_51a4f7fb) {
    if (var_ddbfd9e3.var_62e980f != var_51a4f7fb) {
        var_ddbfd9e3.var_62e980f = var_51a4f7fb;
        params = spawnstruct();
        if (!var_ddbfd9e3.var_62e980f) {
            params.align_struct = struct::get("character_customization");
            params.anim_name = "pb_cac_main_lobby_idle";
        }
        markasdirty(var_ddbfd9e3.charactermodel);
        function_873d37c(localclientnum, var_ddbfd9e3, params);
        if (var_ddbfd9e3.var_62e980f) {
            level notify("frozenMomentChanged" + localclientnum);
        }
    }
}

// Namespace character_customization
// Params 3, eflags: 0x1 linked
// Checksum 0x8a740eaf, Offset: 0x4f70
// Size: 0xcc
function function_ea9faed5(localclientnum, var_ddbfd9e3, show_helmets) {
    if (var_ddbfd9e3.show_helmets != show_helmets) {
        var_ddbfd9e3.show_helmets = show_helmets;
        params = spawnstruct();
        params.weapon_right = var_ddbfd9e3.attached_models["tag_weapon_right"];
        params.weapon_left = var_ddbfd9e3.attached_models["tag_weapon_left"];
        update(localclientnum, var_ddbfd9e3, params);
    }
}

// Namespace character_customization
// Params 3, eflags: 0x1 linked
// Checksum 0x6c7e1bac, Offset: 0x5048
// Size: 0xcc
function function_474a5989(localclientnum, var_ddbfd9e3, align_target) {
    if (var_ddbfd9e3.align_target !== align_target) {
        var_ddbfd9e3.align_target = align_target;
        params = spawnstruct();
        params.weapon_right = var_ddbfd9e3.attached_models["tag_weapon_right"];
        params.weapon_left = var_ddbfd9e3.attached_models["tag_weapon_left"];
        update(localclientnum, var_ddbfd9e3, params);
    }
}

// Namespace character_customization
// Params 1, eflags: 0x1 linked
// Checksum 0x9153773a, Offset: 0x5120
// Size: 0xc4
function setup_live_character_customization_target(localclientnum) {
    characterent = getent(localclientnum, "character_customization", "targetname");
    if (isdefined(characterent)) {
        var_fbfb9ecd = function_b79cb078(characterent, localclientnum, 1);
        var_fbfb9ecd.default_exploder = "char_customization";
        var_fbfb9ecd.var_418b6e8a = 1;
        level thread updateeventthread(localclientnum, var_fbfb9ecd);
        return var_fbfb9ecd;
    }
    return undefined;
}

// Namespace character_customization
// Params 2, eflags: 0x1 linked
// Checksum 0xc732cb99, Offset: 0x51f0
// Size: 0x7c
function update_locked_shader(localclientnum, params) {
    if (isdefined(params.isitemunlocked) && params.isitemunlocked != 1) {
        enablefrontendlockedweaponoverlay(localclientnum, 1);
        return;
    }
    enablefrontendlockedweaponoverlay(localclientnum, 0);
}

// Namespace character_customization
// Params 2, eflags: 0x1 linked
// Checksum 0x9dcc7968, Offset: 0x5278
// Size: 0x6ba
function updateeventthread(localclientnum, var_ddbfd9e3) {
    while (true) {
        eventtype, param1, param2, param3, param4 = level waittill("updateHero" + localclientnum);
        switch (eventtype) {
        case 113:
            var_ddbfd9e3.var_2fee1906 = param1;
            break;
        case 112:
            var_ddbfd9e3.var_2fee1906 = param1;
            params = spawnstruct();
            params.anim_name = "pb_cac_main_lobby_idle";
            params.sessionmode = param2;
            function_d79d6d7(localclientnum, var_ddbfd9e3, undefined, params);
            if (isdefined(param3) && param3 != "") {
                level.var_5b12555e.playsound = param3;
            }
            break;
        case 108:
            params = spawnstruct();
            params.anim_name = "pb_cac_main_lobby_idle";
            params.sessionmode = param2;
            function_d79d6d7(localclientnum, var_ddbfd9e3, param1, params);
            break;
        case 102:
            params = spawnstruct();
            params.sessionmode = param2;
            params.isitemunlocked = param3;
            function_56dceb6(var_ddbfd9e3, param2, var_ddbfd9e3.characterindex, param1, function_a4a750bd(localclientnum, param2, var_ddbfd9e3.characterindex, param1));
            update(localclientnum, var_ddbfd9e3, params);
            update_locked_shader(localclientnum, params);
            break;
        case 106:
            params = spawnstruct();
            params.sessionmode = param2;
            params.isitemunlocked = param3;
            function_5fa9d769(var_ddbfd9e3, param2, var_ddbfd9e3.characterindex, param1, function_227c64d8(localclientnum, param2, var_ddbfd9e3.characterindex, param1));
            update(localclientnum, var_ddbfd9e3, params);
            update_locked_shader(localclientnum, params);
            break;
        case 109:
            params = spawnstruct();
            params.sessionmode = param4;
            function_f374c6fc(var_ddbfd9e3, param4, localclientnum, undefined, var_ddbfd9e3.characterindex, param1, param2, param3, 0, 1);
            update(localclientnum, var_ddbfd9e3, params);
            break;
        case 105:
            params = spawnstruct();
            params.sessionmode = param2;
            function_5b80fae8(var_ddbfd9e3, param2, param1);
            update(localclientnum, var_ddbfd9e3, params);
            break;
        case 103:
            params = spawnstruct();
            params.sessionmode = param3;
            function_f87a1792(var_ddbfd9e3, param1, param2);
            update(localclientnum, var_ddbfd9e3, params);
            break;
        case 107:
            params = spawnstruct();
            params.sessionmode = param3;
            function_883d8451(var_ddbfd9e3, param1, param2);
            update(localclientnum, var_ddbfd9e3, params);
            break;
        case 104:
            var_ddbfd9e3.var_d11acdfe = param1;
            if (var_ddbfd9e3.var_62e980f) {
                markasdirty(var_ddbfd9e3.charactermodel);
                function_873d37c(localclientnum, var_ddbfd9e3, undefined);
            }
            level notify("frozenMomentChanged" + localclientnum);
            break;
        case 110:
            var_ddbfd9e3.var_a5c8c7ea = param1;
            thread namespace_3cadf69b::previewgesture(localclientnum, var_ddbfd9e3.charactermodel, var_ddbfd9e3.anim_name, param1);
            break;
        case 111:
            if (function_ddd0628f(var_ddbfd9e3)) {
                var_ddbfd9e3.var_a5c8c7ea = param1;
                thread namespace_3cadf69b::function_b5457a9d(localclientnum, var_ddbfd9e3.charactermodel, var_ddbfd9e3.anim_name, param1);
            }
            break;
        }
    }
}

// Namespace character_customization
// Params 3, eflags: 0x1 linked
// Checksum 0xaddd4aec, Offset: 0x5940
// Size: 0xf4
function rotation_thread_spawner(localclientnum, var_ddbfd9e3, endonevent) {
    if (!isdefined(endonevent)) {
        return;
    }
    /#
        assert(isdefined(var_ddbfd9e3.charactermodel));
    #/
    model = var_ddbfd9e3.charactermodel;
    baseangles = model.angles;
    level thread update_model_rotation_for_right_stick(localclientnum, var_ddbfd9e3, endonevent);
    level waittill(endonevent);
    if (!(isdefined(var_ddbfd9e3.charactermodel.var_e10c584d) && var_ddbfd9e3.charactermodel.var_e10c584d)) {
        model.angles = baseangles;
    }
}

// Namespace character_customization
// Params 3, eflags: 0x1 linked
// Checksum 0xdb18ea1a, Offset: 0x5a40
// Size: 0x2b8
function update_model_rotation_for_right_stick(localclientnum, var_ddbfd9e3, endonevent) {
    level endon(endonevent);
    /#
        assert(isdefined(var_ddbfd9e3.charactermodel));
    #/
    model = var_ddbfd9e3.charactermodel;
    while (true) {
        data_lcn = isdefined(var_ddbfd9e3.var_2fee1906) ? var_ddbfd9e3.var_2fee1906 : localclientnum;
        if (localclientactive(data_lcn) && !(isdefined(var_ddbfd9e3.charactermodel.var_e10c584d) && var_ddbfd9e3.charactermodel.var_e10c584d)) {
            pos = getcontrollerposition(data_lcn);
            if (isdefined(pos["rightStick"])) {
                model.angles = (model.angles[0], absangleclamp360(model.angles[1] + pos["rightStick"][0] * 3), model.angles[2]);
            } else {
                model.angles = (model.angles[0], absangleclamp360(model.angles[1] + pos["look"][0] * 3), model.angles[2]);
            }
            if (ispc()) {
                pos = getxcammousecontrol(data_lcn);
                model.angles = (model.angles[0], absangleclamp360(model.angles[1] - pos["yaw"] * 3), model.angles[2]);
            }
        }
        wait(0.016);
    }
}

// Namespace character_customization
// Params 1, eflags: 0x1 linked
// Checksum 0x953566bd, Offset: 0x5d00
// Size: 0x17c
function setup_static_character_customization_target(localclientnum) {
    characterent = getent(localclientnum, "character_customization_staging", "targetname");
    level.extra_cam_hero_data[localclientnum] = setup_character_extracam_struct("ui_cam_character_customization", "cam_menu_unfocus", "pb_cac_main_lobby_idle", 0);
    level.var_3bd0563c[localclientnum] = setup_character_extracam_struct("ui_cam_char_identity", "cam_bust", "pb_cac_vs_screen_idle_1", 1);
    level.extra_cam_headshot_hero_data[localclientnum] = setup_character_extracam_struct("ui_cam_char_identity", "cam_bust", "pb_cac_vs_screen_idle_1", 0);
    level.extra_cam_outfit_preview_data[localclientnum] = setup_character_extracam_struct("ui_cam_char_identity", "cam_bust", "pb_cac_main_lobby_idle", 0);
    if (isdefined(characterent)) {
        var_fbfb9ecd = function_b79cb078(characterent, localclientnum, 0);
        level thread update_character_extracam(localclientnum, var_fbfb9ecd);
        return var_fbfb9ecd;
    }
    return undefined;
}

// Namespace character_customization
// Params 4, eflags: 0x1 linked
// Checksum 0x47133de6, Offset: 0x5e88
// Size: 0x94
function setup_character_extracam_struct(xcam, subxcam, model_animation, var_9d818304) {
    newstruct = spawnstruct();
    newstruct.xcam = xcam;
    newstruct.subxcam = subxcam;
    newstruct.anim_name = model_animation;
    newstruct.var_9d818304 = var_9d818304;
    return newstruct;
}

// Namespace character_customization
// Params 3, eflags: 0x1 linked
// Checksum 0x5f015678, Offset: 0x5f28
// Size: 0x54
function wait_for_extracam_close(localclientnum, camera_ent, extracamindex) {
    level waittill("render_complete_" + localclientnum + "_" + extracamindex);
    multi_extracam::extracam_reset_index(localclientnum, extracamindex);
}

// Namespace character_customization
// Params 3, eflags: 0x1 linked
// Checksum 0x3c73414, Offset: 0x5f88
// Size: 0x324
function setup_character_extracam_settings(localclientnum, var_ddbfd9e3, extracam_data_struct) {
    /#
        assert(isdefined(extracam_data_struct.jobindex));
    #/
    if (!isdefined(level.camera_ents)) {
        level.camera_ents = [];
    }
    initializedextracam = 0;
    camera_ent = isdefined(level.camera_ents[localclientnum]) ? level.camera_ents[localclientnum][extracam_data_struct.extracamindex] : undefined;
    if (!isdefined(camera_ent)) {
        initializedextracam = 1;
        multi_extracam::extracam_init_index(localclientnum, "character_staging_extracam" + extracam_data_struct.extracamindex + 1, extracam_data_struct.extracamindex);
        camera_ent = level.camera_ents[localclientnum][extracam_data_struct.extracamindex];
    }
    /#
        assert(isdefined(camera_ent));
    #/
    camera_ent playextracamxcam(extracam_data_struct.xcam, 0, extracam_data_struct.subxcam);
    params = spawnstruct();
    params.anim_name = extracam_data_struct.anim_name;
    params.extracam_data = extracam_data_struct;
    params.isdefaulthero = extracam_data_struct.isdefaulthero;
    params.sessionmode = extracam_data_struct.sessionmode;
    params.hide_helmet = isdefined(extracam_data_struct.hidehelmet) && extracam_data_struct.hidehelmet;
    var_ddbfd9e3.alt_render_mode = 0;
    function_d79d6d7(localclientnum, var_ddbfd9e3, extracam_data_struct.characterindex, params);
    while (!function_ddd0628f(var_ddbfd9e3)) {
        wait(0.016);
    }
    if (isdefined(extracam_data_struct.defaultimagerender) && extracam_data_struct.defaultimagerender) {
        wait(0.5);
    } else {
        wait(0.1);
    }
    setextracamrenderready(extracam_data_struct.jobindex);
    extracam_data_struct.jobindex = undefined;
    if (initializedextracam) {
        level thread wait_for_extracam_close(localclientnum, camera_ent, extracam_data_struct.extracamindex);
    }
}

// Namespace character_customization
// Params 2, eflags: 0x1 linked
// Checksum 0x3a1a1507, Offset: 0x62b8
// Size: 0x68
function update_character_extracam(localclientnum, var_ddbfd9e3) {
    level endon(#"disconnect");
    while (true) {
        extracam_data_struct = level waittill("process_character_extracam" + localclientnum);
        setup_character_extracam_settings(localclientnum, var_ddbfd9e3, extracam_data_struct);
    }
}

// Namespace character_customization
// Params 5, eflags: 0x1 linked
// Checksum 0x43a318d, Offset: 0x6328
// Size: 0xbc
function function_bc334e1a(localclientnum, jobindex, extracamindex, sessionmode, characterindex) {
    level.extra_cam_hero_data[localclientnum].jobindex = jobindex;
    level.extra_cam_hero_data[localclientnum].extracamindex = extracamindex;
    level.extra_cam_hero_data[localclientnum].characterindex = characterindex;
    level.extra_cam_hero_data[localclientnum].sessionmode = sessionmode;
    level notify("process_character_extracam" + localclientnum, level.extra_cam_hero_data[localclientnum]);
}

// Namespace character_customization
// Params 4, eflags: 0x1 linked
// Checksum 0x58265a59, Offset: 0x63f0
// Size: 0xc8
function function_cdc26129(localclientnum, jobindex, extracamindex, sessionmode) {
    level.var_3bd0563c[localclientnum].jobindex = jobindex;
    level.var_3bd0563c[localclientnum].extracamindex = extracamindex;
    level.var_3bd0563c[localclientnum].characterindex = getequippedcharacterindexforlobbyclienthero(localclientnum, jobindex);
    level.var_3bd0563c[localclientnum].sessionmode = sessionmode;
    level notify("process_character_extracam" + localclientnum, level.var_3bd0563c[localclientnum]);
}

// Namespace character_customization
// Params 6, eflags: 0x1 linked
// Checksum 0x8eb5ce75, Offset: 0x64c0
// Size: 0xe0
function process_current_hero_headshot_extracam_request(localclientnum, jobindex, extracamindex, sessionmode, characterindex, isdefaulthero) {
    level.extra_cam_headshot_hero_data[localclientnum].jobindex = jobindex;
    level.extra_cam_headshot_hero_data[localclientnum].extracamindex = extracamindex;
    level.extra_cam_headshot_hero_data[localclientnum].characterindex = characterindex;
    level.extra_cam_headshot_hero_data[localclientnum].isdefaulthero = isdefaulthero;
    level.extra_cam_headshot_hero_data[localclientnum].sessionmode = sessionmode;
    level notify("process_character_extracam" + localclientnum, level.extra_cam_headshot_hero_data[localclientnum]);
}

// Namespace character_customization
// Params 5, eflags: 0x1 linked
// Checksum 0xa20bae34, Offset: 0x65a8
// Size: 0xbc
function function_25aa300b(localclientnum, jobindex, extracamindex, sessionmode, outfitindex) {
    level.extra_cam_outfit_preview_data[localclientnum].jobindex = jobindex;
    level.extra_cam_outfit_preview_data[localclientnum].extracamindex = extracamindex;
    level.extra_cam_outfit_preview_data[localclientnum].characterindex = outfitindex;
    level.extra_cam_outfit_preview_data[localclientnum].sessionmode = sessionmode;
    level notify("process_character_extracam" + localclientnum, level.extra_cam_outfit_preview_data[localclientnum]);
}

// Namespace character_customization
// Params 7, eflags: 0x1 linked
// Checksum 0xb812158c, Offset: 0x6670
// Size: 0x180
function function_c27b6e13(localclientnum, jobindex, extracamindex, sessionmode, characterindex, itemindex, defaultimagerender) {
    extracam_data = undefined;
    if (defaultimagerender) {
        extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons_render", "loot_body", "pb_cac_vs_screen_idle_1", 0);
        extracam_data.useheadindex = getfirstheadofgender(getherogender(characterindex, sessionmode), sessionmode);
    } else {
        extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons", "cam_body", "pb_cac_vs_screen_idle_1", 0);
    }
    extracam_data.jobindex = jobindex;
    extracam_data.extracamindex = extracamindex;
    extracam_data.sessionmode = sessionmode;
    extracam_data.characterindex = characterindex;
    extracam_data.var_59ecf1ca = itemindex;
    extracam_data.defaultimagerender = defaultimagerender;
    level notify("process_character_extracam" + localclientnum, extracam_data);
}

// Namespace character_customization
// Params 7, eflags: 0x1 linked
// Checksum 0xf26e4081, Offset: 0x67f8
// Size: 0x180
function function_b345c4d8(localclientnum, jobindex, extracamindex, sessionmode, characterindex, itemindex, defaultimagerender) {
    extracam_data = undefined;
    if (defaultimagerender) {
        extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons_render", "loot_helmet", "pb_cac_vs_screen_idle_1", 0);
        extracam_data.useheadindex = getfirstheadofgender(getherogender(characterindex, sessionmode), sessionmode);
    } else {
        extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons", "cam_helmet", "pb_cac_vs_screen_idle_1", 0);
    }
    extracam_data.jobindex = jobindex;
    extracam_data.extracamindex = extracamindex;
    extracam_data.sessionmode = sessionmode;
    extracam_data.characterindex = characterindex;
    extracam_data.var_3c23be53 = itemindex;
    extracam_data.defaultimagerender = defaultimagerender;
    level notify("process_character_extracam" + localclientnum, extracam_data);
}

// Namespace character_customization
// Params 6, eflags: 0x1 linked
// Checksum 0xf3653415, Offset: 0x6980
// Size: 0x178
function process_character_head_item_extracam_request(localclientnum, jobindex, extracamindex, sessionmode, headindex, defaultimagerender) {
    extracam_data = undefined;
    if (defaultimagerender) {
        extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons_render", "cam_head", "pb_cac_vs_screen_idle_1", 0);
        extracam_data.characterindex = getfirstheroofgender(getheadgender(headindex, sessionmode), sessionmode);
    } else {
        extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons", "cam_head", "pb_cac_vs_screen_idle_1", 0);
    }
    extracam_data.jobindex = jobindex;
    extracam_data.extracamindex = extracamindex;
    extracam_data.sessionmode = sessionmode;
    extracam_data.useheadindex = headindex;
    extracam_data.hidehelmet = 1;
    extracam_data.defaultimagerender = defaultimagerender;
    level notify("process_character_extracam" + localclientnum, extracam_data);
}

