#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#using_animtree("all_player");

#namespace end_game_flow;

// Namespace end_game_flow
// Params 0, eflags: 0x2
// Checksum 0xd9ddb46, Offset: 0x720
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("end_game_flow", &__init__, undefined, undefined);
}

// Namespace end_game_flow
// Params 0, eflags: 0x0
// Checksum 0x7e3660f7, Offset: 0x758
// Size: 0x82
function __init__() {
    clientfield::register("world", "displayTop3Players", 1, 1, "int", &function_ae4f634e, 0, 0);
    clientfield::register("world", "triggerScoreboardCamera", 1, 1, "int", &showscoreboard, 0, 0);
    level thread function_32cc2aa4();
}

// Namespace end_game_flow
// Params 3, eflags: 0x0
// Checksum 0xc601c850, Offset: 0x7e8
// Size: 0x512
function function_2d7e91bf(localclientnum, charactermodel, var_c55b8047) {
    if (isdefined(charactermodel.weapon)) {
        weapon_group = getitemgroupforweaponname(charactermodel.weapon.rootweapon.name);
        if (weapon_group == "weapon_launcher" && charactermodel.weapon.rootweapon.name == "launcher_lockonly") {
            weapon_group = "weapon_launcher_alt";
        }
        if (isdefined(associativearray("weapon_smg", array("pb_smg_endgame_1stplace_idle", "pb_smg_endgame_2ndplace_idle", "pb_smg_endgame_3rdplace_idle"), "weapon_assault", array("pb_rifle_endgame_1stplace_idle", "pb_rifle_endgame_2ndplace_idle", "pb_rifle_endgame_3rdplace_idle"), "weapon_cqb", array("pb_shotgun_endgame_1stplace_idle", "pb_shotgun_endgame_2ndplace_idle", "pb_shotgun_endgame_3rdplace_idle"), "weapon_lmg", array("pb_lmg_endgame_1stplace_idle", "pb_lmg_endgame_2ndplace_idle", "pb_lmg_endgame_3rdplace_idle"), "weapon_sniper", array("pb_sniper_endgame_1stplace_idle", "pb_sniper_endgame_2ndplace_idle", "pb_sniper_endgame_3rdplace_idle"), "weapon_pistol", array("pb_pistol_endgame_1stplace_idle", "pb_pistol_endgame_2ndplace_idle", "pb_pistol_endgame_3rdplace_idle"), "weapon_pistol_dw", array("pb_pistol_dw_endgame_1stplace_idle", "pb_pistol_dw_endgame_2ndplace_idle", "pb_pistol_dw_endgame_3rdplace_idle"), "weapon_launcher", array("pb_launcher_endgame_1stplace_idle", "pb_launcher_endgame_2ndplace_idle", "pb_launcher_endgame_3rdplace_idle"), "weapon_launcher_alt", array("pb_launcher_alt_endgame_1stplace_idle", "pb_launcher_alt_endgame_2ndplace_idle", "pb_launcher_alt_endgame_3rdplace_idle"), "weapon_knife", array("pb_knife_endgame_1stplace_idle", "pb_knife_endgame_2ndplace_idle", "pb_knife_endgame_3rdplace_idle"))[weapon_group])) {
            anim_name = associativearray("weapon_smg", array("pb_smg_endgame_1stplace_idle", "pb_smg_endgame_2ndplace_idle", "pb_smg_endgame_3rdplace_idle"), "weapon_assault", array("pb_rifle_endgame_1stplace_idle", "pb_rifle_endgame_2ndplace_idle", "pb_rifle_endgame_3rdplace_idle"), "weapon_cqb", array("pb_shotgun_endgame_1stplace_idle", "pb_shotgun_endgame_2ndplace_idle", "pb_shotgun_endgame_3rdplace_idle"), "weapon_lmg", array("pb_lmg_endgame_1stplace_idle", "pb_lmg_endgame_2ndplace_idle", "pb_lmg_endgame_3rdplace_idle"), "weapon_sniper", array("pb_sniper_endgame_1stplace_idle", "pb_sniper_endgame_2ndplace_idle", "pb_sniper_endgame_3rdplace_idle"), "weapon_pistol", array("pb_pistol_endgame_1stplace_idle", "pb_pistol_endgame_2ndplace_idle", "pb_pistol_endgame_3rdplace_idle"), "weapon_pistol_dw", array("pb_pistol_dw_endgame_1stplace_idle", "pb_pistol_dw_endgame_2ndplace_idle", "pb_pistol_dw_endgame_3rdplace_idle"), "weapon_launcher", array("pb_launcher_endgame_1stplace_idle", "pb_launcher_endgame_2ndplace_idle", "pb_launcher_endgame_3rdplace_idle"), "weapon_launcher_alt", array("pb_launcher_alt_endgame_1stplace_idle", "pb_launcher_alt_endgame_2ndplace_idle", "pb_launcher_alt_endgame_3rdplace_idle"), "weapon_knife", array("pb_knife_endgame_1stplace_idle", "pb_knife_endgame_2ndplace_idle", "pb_knife_endgame_3rdplace_idle"))[weapon_group][var_c55b8047];
        }
    }
    if (!isdefined(anim_name)) {
        anim_name = array("pb_brawler_endgame_1stplace_idle", "pb_brawler_endgame_2ndplace_idle", "pb_brawler_endgame_3rdplace_idle")[var_c55b8047];
    }
    if (isdefined(anim_name)) {
        charactermodel util::waittill_dobj(localclientnum);
        if (!charactermodel hasanimtree()) {
            charactermodel useanimtree(#all_player);
        }
        charactermodel setanim(anim_name);
    }
}

// Namespace end_game_flow
// Params 3, eflags: 0x0
// Checksum 0x9cbb010f, Offset: 0xd08
// Size: 0x292
function function_478d992c(localclientnum, charactermodel, var_c55b8047) {
    assert(isdefined(charactermodel));
    bodymodel = gettopplayersbodymodel(localclientnum, var_c55b8047);
    var_e289d4b4 = createuimodel(getuimodelforcontroller(localclientnum), "displayTopPlayer" + var_c55b8047 + 1);
    setuimodelvalue(var_e289d4b4, 1);
    if (!isdefined(bodymodel) || bodymodel == "") {
        setuimodelvalue(var_e289d4b4, 0);
        return;
    }
    charactermodel setmodel(bodymodel);
    var_f1a3fa15 = gettopplayershelmetmodel(localclientnum, var_c55b8047);
    if (!charactermodel isattached(var_f1a3fa15, "")) {
        charactermodel attach(var_f1a3fa15, "");
    }
    var_957cc42 = getcharactermoderenderoptions(currentsessionmode());
    var_6f30937d = gettopplayersbodyrenderoptions(localclientnum, var_c55b8047);
    var_d44a8060 = gettopplayershelmetrenderoptions(localclientnum, var_c55b8047);
    weaponrenderoptions = gettopplayersweaponrenderoptions(localclientnum, var_c55b8047);
    weapon_right = gettopplayersweaponinfo(localclientnum, var_c55b8047);
    if (!isdefined(level.weaponnone)) {
        level.weaponnone = getweapon("none");
    }
    charactermodel setbodyrenderoptions(var_957cc42, var_6f30937d, var_d44a8060, var_d44a8060);
    if (weapon_right["weapon"] == level.weaponnone) {
        weapon_right["weapon"] = getweapon("ar_standard");
        charactermodel attachweapon(weapon_right["weapon"]);
        return;
    }
    charactermodel attachweapon(weapon_right["weapon"], weaponrenderoptions, weapon_right["acvi"]);
}

// Namespace end_game_flow
// Params 3, eflags: 0x0
// Checksum 0xc911ce0b, Offset: 0xfa8
// Size: 0x52
function function_d9779084(localclientnum, charactermodel, var_c55b8047) {
    charactermodel endon(#"entityshutdown");
    function_478d992c(localclientnum, charactermodel, var_c55b8047);
    function_2d7e91bf(localclientnum, charactermodel, var_c55b8047);
}

// Namespace end_game_flow
// Params 1, eflags: 0x0
// Checksum 0xefba1ada, Offset: 0x1008
// Size: 0xd9
function function_6b822cb1(localclientnum) {
    numclients = gettopscorercount(localclientnum);
    position = struct::get("endgame_top_players_struct", "targetname");
    if (!isdefined(position)) {
        return;
    }
    for (index = 0; index < 3; index++) {
        if (index < numclients) {
            model = spawn(localclientnum, position.origin, "script_model");
            function_478d992c(localclientnum, model, index);
            model hide();
            model sethighdetail(1);
        }
    }
}

// Namespace end_game_flow
// Params 1, eflags: 0x0
// Checksum 0x471a855a, Offset: 0x10f0
// Size: 0x23a
function function_edb35629(localclientnum) {
    var_62c15215 = [];
    var_538e08ea = [];
    var_538e08ea[0] = struct::get("TopPlayer1", "targetname");
    var_538e08ea[1] = struct::get("TopPlayer2", "targetname");
    var_538e08ea[2] = struct::get("TopPlayer3", "targetname");
    foreach (index, scriptstruct in var_538e08ea) {
        var_62c15215[index] = spawn(localclientnum, scriptstruct.origin, "script_model");
        var_62c15215[index].angles = scriptstruct.angles;
    }
    numclients = gettopscorercount(localclientnum);
    foreach (index, charactermodel in var_62c15215) {
        if (index < numclients) {
            thread function_d9779084(localclientnum, charactermodel, index);
        }
    }
    position = struct::get("endgame_top_players_struct", "targetname");
    playmaincamxcam(localclientnum, level.endgamexcamname, 0, "cam_topscorers", "topscorers", position.origin, position.angles);
    playradiantexploder(localclientnum, "exploder_mp_endgame_lights");
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "displayTop3Players"), 1);
}

// Namespace end_game_flow
// Params 0, eflags: 0x0
// Checksum 0x89818043, Offset: 0x1338
// Size: 0x2d
function function_32cc2aa4() {
    while (true) {
        level waittill(#"streamfksl", localclientnum);
        function_6b822cb1(localclientnum);
    }
}

// Namespace end_game_flow
// Params 7, eflags: 0x0
// Checksum 0xeb63da7c, Offset: 0x1370
// Size: 0x6a
function function_ae4f634e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(newval) && newval > 0 && isdefined(level.endgamexcamname)) {
        function_edb35629(localclientnum);
    }
}

// Namespace end_game_flow
// Params 7, eflags: 0x0
// Checksum 0xf3a0b309, Offset: 0x13e8
// Size: 0xfa
function showscoreboard(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(newval) && newval > 0 && isdefined(level.endgamexcamname)) {
        position = struct::get("endgame_top_players_struct", "targetname");
        playmaincamxcam(localclientnum, level.endgamexcamname, 0, "cam_topscorers", "", position.origin, position.angles);
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "forceScoreboard"), 1);
        level.var_4104e7ed = 1;
    }
}

