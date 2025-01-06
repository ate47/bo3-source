#using scripts/codescripts/struct;
#using scripts/core/_multi_extracam;
#using scripts/shared/_character_customization;
#using scripts/shared/ai/archetype_damage_effects;
#using scripts/shared/ai/systems/destructible_character;
#using scripts/shared/ai/zombie;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/exploder_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/util_shared;

#namespace customclass;

// Namespace customclass
// Params 1, eflags: 0x0
// Checksum 0xf18ff8ff, Offset: 0x4e8
// Size: 0x1a
function localclientconnect(localclientnum) {
    level thread custom_class_init(localclientnum);
}

// Namespace customclass
// Params 0, eflags: 0x0
// Checksum 0x8b0282d4, Offset: 0x510
// Size: 0x6a
function init() {
    level.weaponnone = getweapon("none");
    level.weapon_position = struct::get("paintshop_weapon_position");
    duplicate_render::set_dr_filter_offscreen("cac_locked_weapon", 10, "cac_locked_weapon", undefined, 2, "mc/sonar_frontend_locked_gun", 1);
}

// Namespace customclass
// Params 1, eflags: 0x0
// Checksum 0xf9b1b684, Offset: 0x588
// Size: 0x42
function custom_class_init(localclientnum) {
    level.last_weapon_name = "";
    level.current_weapon = undefined;
    level thread custom_class_start_threads(localclientnum);
    level thread handle_cac_customization(localclientnum);
}

// Namespace customclass
// Params 1, eflags: 0x0
// Checksum 0xa02886e5, Offset: 0x5d8
// Size: 0x8d
function custom_class_start_threads(localclientnum) {
    level endon(#"disconnect");
    while (true) {
        level thread custom_class_update(localclientnum);
        level thread custom_class_attachment_select_focus(localclientnum);
        level thread custom_class_remove(localclientnum);
        level thread custom_class_closed(localclientnum);
        level util::waittill_any("CustomClass_update", "CustomClass_focus", "CustomClass_remove", "CustomClass_closed");
    }
}

// Namespace customclass
// Params 1, eflags: 0x0
// Checksum 0xf380101d, Offset: 0x670
// Size: 0x7f
function handle_cac_customization(localclientnum) {
    level endon(#"disconnect");
    self.lastxcam = [];
    self.lastsubxcam = [];
    self.lastnotetrack = [];
    while (true) {
        level thread handle_cac_customization_focus(localclientnum);
        level thread function_db76bfd5(localclientnum);
        level thread function_ade2f410(localclientnum);
        level thread handle_cac_customization_closed(localclientnum);
        level waittill(#"cam_customization_closed");
    }
}

// Namespace customclass
// Params 1, eflags: 0x0
// Checksum 0xcc673bc5, Offset: 0x6f8
// Size: 0x23a
function custom_class_update(localclientnum) {
    level endon(#"disconnect");
    level endon(#"CustomClass_focus");
    level endon(#"CustomClass_remove");
    level endon(#"customclass_closed");
    level waittill(#"customclass_update", param1, param2, param3, param4, param5, param6);
    base_weapon_slot = param1;
    var_dacb3c7 = param2;
    camera = param3;
    weapon_options_param = param4;
    var_cf4497db = param5;
    is_item_unlocked = param6;
    if (isdefined(var_dacb3c7)) {
        if (isdefined(var_cf4497db) && var_cf4497db != "none") {
            function_2632634e(var_cf4497db);
        }
        if (isdefined(weapon_options_param) && weapon_options_param != "none") {
            function_f3037b75(weapon_options_param);
        }
        enablefrontendstreamingoverlay(localclientnum, 1);
        if (level.last_weapon_name != var_dacb3c7) {
            position = level.weapon_position;
            if (!isdefined(level.weapon_script_model)) {
                level.weapon_script_model = spawn_weapon_model(localclientnum, position.origin, position.angles);
                level.preload_weapon_model = spawn_weapon_model(localclientnum, position.origin, position.angles);
                level.preload_weapon_model hide();
            }
            toggle_locked_weapon_shader(localclientnum, is_item_unlocked);
            update_weapon_script_model(localclientnum, var_dacb3c7, undefined, is_item_unlocked);
        }
        level notify(#"xcammoved");
        lerpduration = get_lerp_duration(camera);
        setup_paintshop_bg(localclientnum, camera);
        level transition_camera_immediate(localclientnum, base_weapon_slot, "cam_cac_weapon", "cam_cac", lerpduration, camera);
    }
}

// Namespace customclass
// Params 2, eflags: 0x0
// Checksum 0x43469aee, Offset: 0x940
// Size: 0x62
function toggle_locked_weapon_shader(localclientnum, is_item_unlocked) {
    if (!isdefined(is_item_unlocked)) {
        is_item_unlocked = 1;
    }
    if (!isdefined(level.weapon_script_model)) {
        return;
    }
    if (is_item_unlocked != 1) {
        enablefrontendlockedweaponoverlay(localclientnum, 1);
        return;
    }
    enablefrontendlockedweaponoverlay(localclientnum, 0);
}

// Namespace customclass
// Params 1, eflags: 0x0
// Checksum 0x91b43413, Offset: 0x9b0
// Size: 0x70
function is_optic(attachmentname) {
    csv_filename = "gamedata/weapons/common/attachmentTable.csv";
    row = tablelookuprownum(csv_filename, 4, attachmentname);
    if (row > -1) {
        group = tablelookupcolumnforrow(csv_filename, row, 2);
        return (group == "optic");
    }
    return false;
}

// Namespace customclass
// Params 1, eflags: 0x0
// Checksum 0xe4c230d2, Offset: 0xa28
// Size: 0x1da
function custom_class_attachment_select_focus(localclientnum) {
    level endon(#"disconnect");
    level endon(#"customclass_update");
    level endon(#"CustomClass_remove");
    level endon(#"customclass_closed");
    level waittill(#"CustomClass_focus", param1, param2, param3, param4, param5, param6);
    base_weapon_slot = param1;
    var_dacb3c7 = param2;
    attachment = param3;
    weapon_options_param = param4;
    var_cf4497db = param5;
    update_weapon_options = 0;
    weaponattachmentintersection = get_attachments_intersection(level.last_weapon_name, var_dacb3c7);
    if (isdefined(var_cf4497db) && var_cf4497db != "none") {
        function_2632634e(var_cf4497db);
    }
    if (isdefined(weapon_options_param) && weapon_options_param != "none") {
        function_f3037b75(weapon_options_param);
    }
    initialdelay = 0.3;
    lerpduration = 400;
    if (is_optic(attachment)) {
        initialdelay = 0;
        lerpduration = -56;
    }
    preload_weapon_model(localclientnum, weaponattachmentintersection, update_weapon_options);
    wait_preload_weapon();
    update_weapon_script_model(localclientnum, weaponattachmentintersection, update_weapon_options);
    if (var_dacb3c7 == weaponattachmentintersection) {
        var_dacb3c7 = undefined;
    }
    level thread transition_camera(localclientnum, base_weapon_slot, "cam_cac_attachments", "cam_cac", initialdelay, lerpduration, attachment, var_dacb3c7);
}

// Namespace customclass
// Params 1, eflags: 0x0
// Checksum 0xde279711, Offset: 0xc10
// Size: 0x132
function custom_class_remove(localclientnum) {
    level endon(#"disconnect");
    level endon(#"customclass_update");
    level endon(#"CustomClass_focus");
    level endon(#"customclass_closed");
    level waittill(#"CustomClass_remove", param1, param2, param3, param4, param5, param6);
    enablefrontendstreamingoverlay(localclientnum, 0);
    enablefrontendlockedweaponoverlay(localclientnum, 0);
    position = level.weapon_position;
    camera = "select01";
    xcamname = "ui_cam_cac_ar_standard";
    playmaincamxcam(localclientnum, xcamname, 0, "cam_cac", camera, position.origin, position.angles);
    setup_paintshop_bg(localclientnum, camera);
    if (isdefined(level.weapon_script_model)) {
        level.weapon_script_model forcedelete();
    }
    level.last_weapon_name = "";
}

// Namespace customclass
// Params 1, eflags: 0x0
// Checksum 0x8d69f034, Offset: 0xd50
// Size: 0xb2
function custom_class_closed(localclientnum) {
    level endon(#"disconnect");
    level endon(#"customclass_update");
    level endon(#"CustomClass_focus");
    level endon(#"CustomClass_remove");
    level waittill(#"customclass_closed", param1, param2, param3, param4, param5, param6);
    if (isdefined(level.weapon_script_model)) {
        level.weapon_script_model forcedelete();
    }
    enablefrontendstreamingoverlay(localclientnum, 0);
    level.last_weapon_name = "";
}

// Namespace customclass
// Params 3, eflags: 0x0
// Checksum 0xa8813c35, Offset: 0xe10
// Size: 0x68
function spawn_weapon_model(localclientnum, origin, angles) {
    weapon_model = spawn(localclientnum, origin, "script_model");
    weapon_model sethighdetail(1, 1);
    if (isdefined(angles)) {
        weapon_model.angles = angles;
    }
    return weapon_model;
}

// Namespace customclass
// Params 1, eflags: 0x0
// Checksum 0x43ed05f2, Offset: 0xe80
// Size: 0x9f
function function_2632634e(var_cf4497db) {
    var_5a183cc0 = strtok(var_cf4497db, ",");
    level.attachment_names = [];
    level.var_ac376924 = [];
    for (i = 0; i + 1 < var_5a183cc0.size; i += 2) {
        level.attachment_names[level.attachment_names.size] = var_5a183cc0[i];
        level.var_ac376924[level.var_ac376924.size] = int(var_5a183cc0[i + 1]);
    }
}

// Namespace customclass
// Params 1, eflags: 0x0
// Checksum 0x8dcba8c3, Offset: 0xf28
// Size: 0x8a
function hide_paintshop_bg(localclientnum) {
    paintshop_bg = getent(localclientnum, "paintshop_black", "targetname");
    if (isdefined(paintshop_bg)) {
        if (!isdefined(level.paintshophiddenposition)) {
            level.paintshophiddenposition = paintshop_bg.origin;
        }
        paintshop_bg hide();
        paintshop_bg moveto(level.paintshophiddenposition, 0.01);
    }
}

// Namespace customclass
// Params 1, eflags: 0x0
// Checksum 0x4a7137aa, Offset: 0xfc0
// Size: 0x72
function show_paintshop_bg(localclientnum) {
    paintshop_bg = getent(localclientnum, "paintshop_black", "targetname");
    if (isdefined(paintshop_bg)) {
        paintshop_bg show();
        paintshop_bg moveto(level.paintshophiddenposition + (0, 0, 227), 0.01);
    }
}

// Namespace customclass
// Params 0, eflags: 0x0
// Checksum 0x54d9c126, Offset: 0x1040
// Size: 0x1d
function get_camo_index() {
    if (!isdefined(level.camo_index)) {
        level.camo_index = 0;
    }
    return level.camo_index;
}

// Namespace customclass
// Params 0, eflags: 0x0
// Checksum 0x812b22c4, Offset: 0x1068
// Size: 0x1d
function get_reticle_index() {
    if (!isdefined(level.reticle_index)) {
        level.reticle_index = 0;
    }
    return level.reticle_index;
}

// Namespace customclass
// Params 0, eflags: 0x0
// Checksum 0x3de60997, Offset: 0x1090
// Size: 0x1d
function function_bcfb8776() {
    if (!isdefined(level.show_player_tag)) {
        level.show_player_tag = 0;
    }
    return level.show_player_tag;
}

// Namespace customclass
// Params 0, eflags: 0x0
// Checksum 0x9daca591, Offset: 0x10b8
// Size: 0x1d
function get_show_emblem() {
    if (!isdefined(level.show_emblem)) {
        level.show_emblem = 0;
    }
    return level.show_emblem;
}

// Namespace customclass
// Params 0, eflags: 0x0
// Checksum 0x5c36616, Offset: 0x10e0
// Size: 0x1d
function get_show_paintshop() {
    if (!isdefined(level.show_paintshop)) {
        level.show_paintshop = 0;
    }
    return level.show_paintshop;
}

// Namespace customclass
// Params 1, eflags: 0x0
// Checksum 0xda11067a, Offset: 0x1108
// Size: 0x112
function function_f3037b75(weapon_options_param) {
    weapon_options = strtok(weapon_options_param, ",");
    level.camo_index = int(weapon_options[0]);
    level.show_player_tag = 0;
    level.show_emblem = 0;
    level.reticle_index = int(weapon_options[1]);
    level.show_paintshop = int(weapon_options[2]);
    if (isdefined(weapon_options) && isdefined(level.weapon_script_model)) {
        level.weapon_script_model setweaponrenderoptions(get_camo_index(), get_reticle_index(), function_bcfb8776(), get_show_emblem(), get_show_paintshop());
    }
}

// Namespace customclass
// Params 1, eflags: 0x0
// Checksum 0x7fb1367a, Offset: 0x1228
// Size: 0x7c
function get_lerp_duration(camera) {
    lerpduration = 0;
    if (isdefined(camera)) {
        paintshopcameracloseup = camera == "left" || camera == "right" || camera == "top" || camera == "paintshop_preview_left" || camera == "paintshop_preview_right" || camera == "paintshop_preview_top";
        if (paintshopcameracloseup) {
            lerpduration = 500;
        }
    }
    return lerpduration;
}

// Namespace customclass
// Params 2, eflags: 0x0
// Checksum 0xabde6562, Offset: 0x12b0
// Size: 0x142
function setup_paintshop_bg(localclientnum, camera) {
    if (isdefined(camera)) {
        paintshopcameracloseup = camera == "left" || camera == "right" || camera == "top" || camera == "paintshop_preview_left" || camera == "paintshop_preview_right" || camera == "paintshop_preview_top";
        playradiantexploder(localclientnum, "weapon_kick");
        if (paintshopcameracloseup) {
            show_paintshop_bg(localclientnum);
            killradiantexploder(localclientnum, "lights_paintshop");
            killradiantexploder(localclientnum, "weapon_kick");
            playradiantexploder(localclientnum, "lights_paintshop_zoom");
            return;
        }
        hide_paintshop_bg(localclientnum);
        killradiantexploder(localclientnum, "lights_paintshop_zoom");
        playradiantexploder(localclientnum, "lights_paintshop");
        playradiantexploder(localclientnum, "weapon_kick");
    }
}

// Namespace customclass
// Params 6, eflags: 0x0
// Checksum 0xf8b88040, Offset: 0x1400
// Size: 0x1f2
function transition_camera_immediate(localclientnum, weapontype, camera, subxcam, lerpduration, notetrack) {
    xcam = getweaponxcam(level.current_weapon, camera);
    if (!isdefined(xcam)) {
        if (strstartswith(weapontype, "specialty")) {
            xcam = "ui_cam_cac_perk";
        } else if (strstartswith(weapontype, "bonuscard")) {
            xcam = "ui_cam_cac_wildcard";
        } else if (strstartswith(weapontype, "cybercore") || strstartswith(weapontype, "cybercom")) {
            xcam = "ui_cam_cac_perk";
        } else if (strstartswith(weapontype, "bubblegum")) {
            xcam = "ui_cam_cac_bgb";
        } else {
            xcam = getweaponxcam(getweapon("ar_standard"), camera);
        }
    }
    self.lastxcam[weapontype] = xcam;
    self.lastsubxcam[weapontype] = subxcam;
    self.lastnotetrack[weapontype] = notetrack;
    position = level.weapon_position;
    model = level.weapon_script_model;
    playmaincamxcam(localclientnum, xcam, lerpduration, subxcam, notetrack, position.origin, position.angles, model, position.origin, position.angles);
    if (notetrack == "top" || notetrack == "right" || notetrack == "left") {
        setallowxcamrightstickrotation(localclientnum, 0);
    }
}

// Namespace customclass
// Params 0, eflags: 0x0
// Checksum 0x5a565417, Offset: 0x1600
// Size: 0x18
function wait_preload_weapon() {
    if (level.preload_weapon_complete) {
        return;
    }
    level waittill(#"preload_weapon_complete");
}

// Namespace customclass
// Params 1, eflags: 0x0
// Checksum 0x63ed27e0, Offset: 0x1620
// Size: 0x59
function preload_weapon_watcher(localclientnum) {
    level endon(#"hash_5964ddf");
    level endon(#"preload_weapon_complete");
    while (true) {
        if (level.preload_weapon_model isstreamed()) {
            level.preload_weapon_complete = 1;
            level notify(#"preload_weapon_complete");
            return;
        }
        wait 0.1;
    }
}

// Namespace customclass
// Params 3, eflags: 0x0
// Checksum 0x3a959b3f, Offset: 0x1688
// Size: 0x1aa
function preload_weapon_model(localclientnum, newweaponstring, should_update_weapon_options) {
    if (!isdefined(should_update_weapon_options)) {
        should_update_weapon_options = 1;
    }
    level notify(#"hash_5964ddf");
    level.preload_weapon_complete = 0;
    current_weapon = getweaponwithattachments(newweaponstring);
    if (current_weapon == level.weaponnone) {
        level.preload_weapon_complete = 1;
        level notify(#"preload_weapon_complete");
        return;
    }
    if (isdefined(current_weapon.frontendmodel)) {
        level.preload_weapon_model useweaponmodel(current_weapon, current_weapon.frontendmodel);
    } else {
        level.preload_weapon_model useweaponmodel(current_weapon);
    }
    if (isdefined(level.preload_weapon_model)) {
        if (isdefined(level.attachment_names) && isdefined(level.var_ac376924)) {
            for (i = 0; i < level.attachment_names.size; i++) {
                level.preload_weapon_model setattachmentcosmeticvariantindex(newweaponstring, level.attachment_names[i], level.var_ac376924[i]);
            }
        }
        if (should_update_weapon_options) {
            level.preload_weapon_model setweaponrenderoptions(get_camo_index(), get_reticle_index(), function_bcfb8776(), get_show_emblem(), get_show_paintshop());
        }
    }
    level thread preload_weapon_watcher(localclientnum);
}

// Namespace customclass
// Params 4, eflags: 0x0
// Checksum 0xc1cb03c9, Offset: 0x1840
// Size: 0x262
function update_weapon_script_model(localclientnum, newweaponstring, should_update_weapon_options, is_item_unlocked) {
    if (!isdefined(should_update_weapon_options)) {
        should_update_weapon_options = 1;
    }
    if (!isdefined(is_item_unlocked)) {
        is_item_unlocked = 1;
    }
    level.last_weapon_name = newweaponstring;
    level.current_weapon = getweaponwithattachments(level.last_weapon_name);
    if (level.current_weapon == level.weaponnone) {
        level.weapon_script_model delete();
        position = level.weapon_position;
        level.weapon_script_model = spawn_weapon_model(localclientnum, position.origin, position.angles);
        toggle_locked_weapon_shader(localclientnum, is_item_unlocked);
        level.weapon_script_model setmodel(level.last_weapon_name);
        level.weapon_script_model setdedicatedshadow(1);
        return;
    }
    if (isdefined(level.current_weapon.frontendmodel)) {
        level.weapon_script_model useweaponmodel(level.current_weapon, level.current_weapon.frontendmodel);
    } else {
        level.weapon_script_model useweaponmodel(level.current_weapon);
    }
    if (isdefined(level.weapon_script_model)) {
        if (isdefined(level.attachment_names) && isdefined(level.var_ac376924)) {
            for (i = 0; i < level.attachment_names.size; i++) {
                level.weapon_script_model setattachmentcosmeticvariantindex(newweaponstring, level.attachment_names[i], level.var_ac376924[i]);
            }
        }
        if (should_update_weapon_options) {
            level.weapon_script_model setweaponrenderoptions(get_camo_index(), get_reticle_index(), function_bcfb8776(), get_show_emblem(), get_show_paintshop());
        }
    }
    level.weapon_script_model setdedicatedshadow(1);
}

// Namespace customclass
// Params 9, eflags: 0x0
// Checksum 0x329e6272, Offset: 0x1ab0
// Size: 0xea
function transition_camera(localclientnum, weapontype, camera, subxcam, initialdelay, lerpduration, notetrack, newweaponstring, should_update_weapon_options) {
    if (!isdefined(should_update_weapon_options)) {
        should_update_weapon_options = 0;
    }
    self endon(#"entityshutdown");
    self notify(#"xcammoved");
    self endon(#"xcammoved");
    level endon(#"cam_customization_closed");
    if (isdefined(newweaponstring)) {
        preload_weapon_model(localclientnum, newweaponstring, should_update_weapon_options);
    }
    wait initialdelay;
    transition_camera_immediate(localclientnum, weapontype, camera, subxcam, lerpduration, notetrack);
    if (isdefined(newweaponstring)) {
        wait lerpduration / 1000;
        wait_preload_weapon();
        update_weapon_script_model(localclientnum, newweaponstring, should_update_weapon_options);
    }
}

// Namespace customclass
// Params 2, eflags: 0x0
// Checksum 0x7f47edc6, Offset: 0x1ba8
// Size: 0x9a
function function_7b5896d5(localclientnum, type) {
    if (isdefined(self.lastxcam) && isdefined(self.lastsubxcam)) {
        if (type == "primary") {
            position = level.weapon_position;
            model = level.weapon_script_model;
            playmaincamxcam(localclientnum, self.lastxcam[type], 0, self.lastsubxcam[type], self.lastnotetrack[type], position.origin, position.angles);
        }
    }
}

// Namespace customclass
// Params 2, eflags: 0x0
// Checksum 0x33aa7e68, Offset: 0x1c50
// Size: 0xc7
function get_attachments_intersection(oldweapon, newweapon) {
    if (!isdefined(oldweapon)) {
        return newweapon;
    }
    var_76a49db6 = strtok(oldweapon, "+");
    var_e1181707 = strtok(newweapon, "+");
    if (var_76a49db6[0] != var_e1181707[0]) {
        return newweapon;
    }
    newweaponstring = var_e1181707[0];
    for (i = 1; i < var_e1181707.size; i++) {
        if (isinarray(var_76a49db6, var_e1181707[i])) {
            newweaponstring += "+" + var_e1181707[i];
        }
    }
    return newweaponstring;
}

// Namespace customclass
// Params 1, eflags: 0x0
// Checksum 0x57831a68, Offset: 0x1d20
// Size: 0xad
function handle_cac_customization_focus(localclientnum) {
    level endon(#"disconnect");
    level endon(#"cam_customization_closed");
    while (true) {
        level waittill(#"cam_customization_focus", param1, param2);
        base_weapon_slot = param1;
        notetrack = param2;
        if (isdefined(level.weapon_script_model)) {
            should_update_weapon_options = 1;
            level thread transition_camera(localclientnum, base_weapon_slot, "cam_cac_weapon", "cam_cac", 0.3, 400, notetrack, level.last_weapon_name, should_update_weapon_options);
        }
    }
}

// Namespace customclass
// Params 1, eflags: 0x0
// Checksum 0x13bb8fce, Offset: 0x1dd8
// Size: 0x165
function function_db76bfd5(localclientnum) {
    level endon(#"disconnect");
    level endon(#"cam_customization_closed");
    while (true) {
        level waittill(#"cam_customization_wo", var_d01f310b, var_f19f1a0d, var_a7708f26);
        if (isdefined(level.weapon_script_model)) {
            if (isdefined(var_a7708f26) && var_a7708f26) {
                var_f19f1a0d = 0;
            }
            switch (var_d01f310b) {
            case "camo":
                level.camo_index = int(var_f19f1a0d);
                break;
            case "reticle":
                level.reticle_index = int(var_f19f1a0d);
                break;
            case "paintjob":
                level.show_paintshop = int(var_f19f1a0d);
                break;
            default:
                break;
            }
            level.weapon_script_model setweaponrenderoptions(get_camo_index(), get_reticle_index(), function_bcfb8776(), get_show_emblem(), get_show_paintshop());
        }
    }
}

// Namespace customclass
// Params 1, eflags: 0x0
// Checksum 0x2cd7204a, Offset: 0x1f48
// Size: 0xd5
function function_ade2f410(localclientnum) {
    level endon(#"disconnect");
    level endon(#"cam_customization_closed");
    while (true) {
        level waittill(#"cam_customization_acv", var_d1a9fc4f, var_73feac4c);
        for (i = 0; i < level.attachment_names.size; i++) {
            if (level.attachment_names[i] == var_d1a9fc4f) {
                level.var_ac376924[i] = int(var_73feac4c);
                break;
            }
        }
        if (isdefined(level.weapon_script_model)) {
            level.weapon_script_model setattachmentcosmeticvariantindex(level.last_weapon_name, var_d1a9fc4f, int(var_73feac4c));
        }
    }
}

// Namespace customclass
// Params 1, eflags: 0x0
// Checksum 0xa6836c67, Offset: 0x2028
// Size: 0x191
function handle_cac_customization_closed(localclientnum) {
    level endon(#"disconnect");
    level waittill(#"cam_customization_closed", param1, param2, param3, param4);
    level function_7b5896d5(localclientnum, "primary");
    camera = "select01";
    base_weapon_slot = "primary";
    level transition_camera_immediate(localclientnum, base_weapon_slot, "cam_cac_weapon", "cam_cac", -6, camera);
    if (isdefined(level.weapon_clientscript_cac_model) && isdefined(level.weapon_clientscript_cac_model[level.var_26fcd0f0])) {
        level.weapon_clientscript_cac_model[level.var_26fcd0f0] setweaponrenderoptions(get_camo_index(), get_reticle_index(), function_bcfb8776(), get_show_emblem(), get_show_paintshop());
        for (i = 0; i < level.attachment_names.size; i++) {
            level.weapon_clientscript_cac_model[level.var_26fcd0f0] setattachmentcosmeticvariantindex(level.last_weapon_name, level.attachment_names[i], level.var_ac376924[i]);
        }
    }
}

