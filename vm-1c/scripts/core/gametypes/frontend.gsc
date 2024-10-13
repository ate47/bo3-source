#using scripts/shared/ai/zombie;
#using scripts/shared/ai/archetype_damage_effects;
#using scripts/shared/ai/behavior_state_machine_planners_utility;
#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/shared/ai/archetype_locomotion_utility;
#using scripts/shared/ai/archetype_cover_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/animation_selector_table_evaluators;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/player_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/math_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;
#using scripts/core/gametypes/frontend_zm_bgb_chance;

#using_animtree("all_player");

#namespace frontend;

// Namespace frontend
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x7f0
// Size: 0x4
function callback_void() {
    
}

// Namespace frontend
// Params 1, eflags: 0x1 linked
// Checksum 0xd71a51e, Offset: 0x800
// Size: 0x24
function callback_actorspawnedfrontend(spawner) {
    self thread spawner::spawn_think(spawner);
}

// Namespace frontend
// Params 0, eflags: 0x1 linked
// Checksum 0xd2cabd20, Offset: 0x830
// Size: 0x324
function main() {
    level.callbackstartgametype = &callback_void;
    level.callbackplayerconnect = &callback_playerconnect;
    level.callbackplayerdisconnect = &callback_void;
    level.callbackentityspawned = &callback_void;
    level.callbackactorspawned = &callback_actorspawnedfrontend;
    level.orbis = getdvarstring("orbisGame") == "true";
    level.durango = getdvarstring("durangoGame") == "true";
    scene::add_scene_func("sb_frontend_black_market", &function_98e4f876, "play");
    clientfield::register("world", "first_time_flow", 1, getminbitcountfornum(1), "int");
    clientfield::register("world", "cp_bunk_anim_type", 1, getminbitcountfornum(1), "int");
    clientfield::register("actor", "zombie_has_eyes", 1, 1, "int");
    clientfield::register("scriptmover", "dni_eyes", 1000, 1, "int");
    level.weaponnone = getweapon("none");
    /#
        level thread dailychallengedevguiinit();
        level thread function_4afc218();
        setdvar("<dev string:x28>", 0);
        adddebugcommand("<dev string:x41>");
        setdvar("<dev string:x91>", "<dev string:xa8>");
        adddebugcommand("<dev string:xb0>");
        adddebugcommand("<dev string:x104>");
        adddebugcommand("<dev string:x15a>");
        adddebugcommand("<dev string:x1b6>");
    #/
    level thread function_78987129();
    level thread zm_frontend_zm_bgb_chance::zm_frontend_bgb_slots_logic();
    level thread function_f7d50167();
}

// Namespace frontend
// Params 0, eflags: 0x1 linked
// Checksum 0x88cb220a, Offset: 0xb60
// Size: 0x114
function function_f7d50167() {
    wait 0.05;
    if (world.var_1048aced !== 0) {
        world.cp_bunk_anim_type = 0;
        level clientfield::set("first_time_flow", 1);
        /#
            printtoprightln("<dev string:x20e>", (1, 1, 1));
        #/
        return;
    }
    if (math::cointoss()) {
        world.cp_bunk_anim_type = 0;
        /#
            printtoprightln("<dev string:x22e>", (1, 1, 1));
        #/
    } else {
        world.cp_bunk_anim_type = 1;
        /#
            printtoprightln("<dev string:x23b>", (1, 1, 1));
        #/
    }
    level clientfield::set("cp_bunk_anim_type", world.cp_bunk_anim_type);
}

// Namespace frontend
// Params 0, eflags: 0x1 linked
// Checksum 0xf94ac8b6, Offset: 0xc80
// Size: 0x206
function function_78987129() {
    wait 5;
    var_765b3a01 = getentarray("sp_zombie_frontend", "targetname");
    while (true) {
        var_765b3a01 = array::randomize(var_765b3a01);
        foreach (sp_zombie in var_765b3a01) {
            while (getaicount() >= 20) {
                wait 1;
            }
            ai_zombie = sp_zombie spawnfromspawner();
            if (isdefined(ai_zombie)) {
                ai_zombie sethighdetail(1);
                ai_zombie setavoidancemask("avoid all");
                ai_zombie function_1762804b(0);
                ai_zombie clientfield::set("zombie_has_eyes", 1);
                ai_zombie.delete_on_path_end = 1;
                ai_zombie.disabletargetservice = 1;
                ai_zombie.ignoreall = 1;
                sp_zombie.count++;
            }
            wait randomfloatrange(3, 8);
        }
    }
}

// Namespace frontend
// Params 0, eflags: 0x1 linked
// Checksum 0xb8d35bf, Offset: 0xe90
// Size: 0x4c
function callback_playerconnect() {
    self thread function_c7410880();
    /#
        self thread dailychallengedevguithink();
        self thread function_ead1dc1a();
    #/
}

// Namespace frontend
// Params 1, eflags: 0x1 linked
// Checksum 0xeda11b44, Offset: 0xee8
// Size: 0xac
function function_98e4f876(a_ents) {
    level.var_65f83320 = self.origin;
    level.var_a1674e6e = self.angles;
    level.var_cc4f1e31 = a_ents["sb_frontend_black_market_character"];
    level.var_bd18dfbe = a_ents["lefthand"];
    level.var_54a434fc = a_ents["righthand"];
    level scene::stop("sb_frontend_black_market");
    level.var_cc4f1e31 clientfield::set("dni_eyes", 1);
}

// Namespace frontend
// Params 0, eflags: 0x1 linked
// Checksum 0x2b9c7fd8, Offset: 0xfa0
// Size: 0x276
function function_c7410880() {
    self endon(#"disconnect");
    while (true) {
        menu, response = self waittill(#"menuresponse");
        if (menu != "BlackMarket") {
            continue;
        }
        switch (response) {
        case "greeting":
            thread function_d9abcfe();
            break;
        case "greeting_first":
            function_888326b9("vox_mark_greeting_first");
            break;
        case "greeting_broke":
            thread function_f174105a();
            break;
        case "roll":
            function_888326b9("vox_mark_roll_in_progress");
            break;
        case "complete_common":
            function_888326b9("vox_mark_complete_common");
            break;
        case "complete_rare":
            function_888326b9("vox_mark_complete_rare");
            break;
        case "complete_legendary":
            function_888326b9("vox_mark_complete_legendary");
            break;
        case "complete_epic":
            function_888326b9("vox_mark_complete_epic");
            break;
        case "burn_duplicates":
            thread function_ae2deb8();
            break;
        case "stopsounds":
            level.var_cc4f1e31 stopsounds();
            break;
        case "closed":
            level.var_cc4f1e31 stopsounds();
            level.var_cc4f1e31 thread animation::stop(0.2);
            level.var_bd18dfbe thread animation::stop(0.2);
            level.var_54a434fc thread animation::stop(0.2);
            level.var_cc4f1e31 notify(#"closed");
            break;
        }
    }
}

// Namespace frontend
// Params 1, eflags: 0x1 linked
// Checksum 0xbddac410, Offset: 0x1220
// Size: 0x5c
function function_888326b9(dialogalias) {
    if (!isdefined(dialogalias)) {
        return;
    }
    level.var_cc4f1e31 stopsounds();
    level.var_cc4f1e31 playsoundontag(dialogalias, "J_Head");
}

// Namespace frontend
// Params 0, eflags: 0x1 linked
// Checksum 0x703e9e33, Offset: 0x1288
// Size: 0x98
function function_c2c50a17() {
    if (getlocalprofileint("com_firsttime_blackmarket")) {
        return false;
    }
    level.var_cc4f1e31 endon(#"closed");
    function_c5205bdc("pb_black_marketeer_1st_time_greeting_", "o_black_marketeer_tumbler_1st_time_greeting_", "o_black_marketeer_pistol_1st_time_greeting_", "01");
    level.var_cc4f1e31 waittill(#"hash_d75a7209");
    setlocalprofilevar("com_firsttime_blackmarket", 1);
    return true;
}

// Namespace frontend
// Params 0, eflags: 0x1 linked
// Checksum 0x777801b0, Offset: 0x1328
// Size: 0x74
function function_d9abcfe() {
    level.var_cc4f1e31 endon(#"closed");
    if (function_c2c50a17()) {
        return;
    }
    var_27284619 = function_b64618f7(11);
    function_c5205bdc("pb_black_marketeer_greeting_", "o_black_marketeer_tumbler_greeting_", "o_black_marketeer_pistol_greeting_", var_27284619);
}

// Namespace frontend
// Params 0, eflags: 0x1 linked
// Checksum 0xcd573e99, Offset: 0x13a8
// Size: 0x74
function function_f174105a() {
    level.var_cc4f1e31 endon(#"closed");
    if (function_c2c50a17()) {
        return;
    }
    var_27284619 = function_b64618f7(10);
    function_c5205bdc("pb_black_marketeer_insufficient_funds_", "o_black_marketeer_tumbler_insufficient_funds_", "o_black_marketeer_pistol_insufficient_funds_", var_27284619);
}

// Namespace frontend
// Params 0, eflags: 0x1 linked
// Checksum 0x4e854c65, Offset: 0x1428
// Size: 0x54
function function_ae2deb8() {
    var_27284619 = function_b64618f7(6);
    function_c5205bdc("pb_black_marketeer_burn_dupes_", "o_black_marketeer_tumbler_burn_dupes_", "o_black_marketeer_pistol_burn_dupes_", var_27284619);
}

// Namespace frontend
// Params 1, eflags: 0x1 linked
// Checksum 0x6b767cb5, Offset: 0x1488
// Size: 0x52
function function_b64618f7(var_1c7f095f) {
    var_27284619 = randomint(var_1c7f095f);
    if (var_27284619 < 10) {
        return ("0" + var_27284619);
    }
    return var_27284619;
}

// Namespace frontend
// Params 4, eflags: 0x1 linked
// Checksum 0x847c4682, Offset: 0x14e8
// Size: 0xfc
function function_c5205bdc(var_515c5969, var_2759f5e5, var_a12eee4f, var_27284619) {
    if (!isdefined(var_27284619)) {
        var_27284619 = "";
    }
    level.var_cc4f1e31 stopsounds();
    level.var_cc4f1e31 thread function_c0d629d(var_515c5969 + var_27284619, "pb_black_marketeer_idle", level.var_65f83320, level.var_a1674e6e);
    level.var_bd18dfbe thread function_c0d629d(var_2759f5e5 + var_27284619, "o_black_marketeer_tumbler_idle", level.var_cc4f1e31, "tag_origin");
    level.var_54a434fc thread function_c0d629d(var_a12eee4f + var_27284619, "o_black_marketeer_pistol_idle", level.var_cc4f1e31, "tag_origin");
}

// Namespace frontend
// Params 4, eflags: 0x1 linked
// Checksum 0xde984d95, Offset: 0x15f0
// Size: 0xe4
function function_c0d629d(animname, idleanimname, var_19357182, tagangles) {
    self notify(#"hash_c0d629d");
    self endon(#"hash_c0d629d");
    level.var_cc4f1e31 endon(#"closed");
    self thread animation::stop(0.2);
    self animation::play(animname, var_19357182, tagangles, 1, 0.2, 0.2);
    self notify(#"hash_d75a7209");
    self thread animation::play(idleanimname, var_19357182, tagangles, 1, 0.2, 0);
}

/#

    // Namespace frontend
    // Params 0, eflags: 0x1 linked
    // Checksum 0x95cc8cec, Offset: 0x16e0
    // Size: 0x15e
    function dailychallengedevguiinit() {
        setdvar("<dev string:x249>", 0);
        num_rows = tablelookuprowcount("<dev string:x25d>");
        for (row_num = 2; row_num < num_rows; row_num++) {
            challenge_name = tablelookupcolumnforrow("<dev string:x25d>", row_num, 5);
            challenge_name = getsubstr(challenge_name, 11);
            display_row_num = row_num - 2;
            devgui_string = "<dev string:x284>" + "<dev string:x291>" + (display_row_num < 10 ? "<dev string:x2a6>" + display_row_num : display_row_num) + "<dev string:x2a8>" + challenge_name + "<dev string:x2aa>" + row_num + "<dev string:x2c2>";
            adddebugcommand(devgui_string);
        }
    }

    // Namespace frontend
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1cb2d5a5, Offset: 0x1848
    // Size: 0x178
    function dailychallengedevguithink() {
        self endon(#"disconnect");
        while (true) {
            daily_challenge_cmd = getdvarint("<dev string:x249>");
            if (daily_challenge_cmd == 0 || !sessionmodeiszombiesgame()) {
                wait 1;
                continue;
            }
            daily_challenge_row = daily_challenge_cmd;
            daily_challenge_index = tablelookupcolumnforrow("<dev string:x25d>", daily_challenge_row, 0);
            daily_challenge_stat = tablelookupcolumnforrow("<dev string:x25d>", daily_challenge_row, 4);
            adddebugcommand("<dev string:x2c6>" + daily_challenge_stat + "<dev string:x2e4>" + "<dev string:x2f6>");
            adddebugcommand("<dev string:x2f9>" + daily_challenge_index + "<dev string:x2f6>");
            adddebugcommand("<dev string:x33c>" + "<dev string:x2f6>");
            setdvar("<dev string:x249>", 0);
        }
    }

    // Namespace frontend
    // Params 0, eflags: 0x1 linked
    // Checksum 0x498c0abc, Offset: 0x19c8
    // Size: 0x194
    function function_4afc218() {
        setdvar("<dev string:x382>", 0);
        while (true) {
            if (getdvarint("<dev string:x395>") <= 0 || !sessionmodeiszombiesgame()) {
                wait 1;
                continue;
            }
            adddebugcommand("<dev string:x3a2>");
            adddebugcommand("<dev string:x3e9>");
            adddebugcommand("<dev string:x432>");
            adddebugcommand("<dev string:x481>");
            adddebugcommand("<dev string:x4d2>");
            adddebugcommand("<dev string:x51f>");
            adddebugcommand("<dev string:x56e>");
            adddebugcommand("<dev string:x5bb>");
            adddebugcommand("<dev string:x60a>");
            adddebugcommand("<dev string:x65f>");
            adddebugcommand("<dev string:x6b6>");
            adddebugcommand("<dev string:x705>");
            break;
        }
    }

    // Namespace frontend
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd0c5cf35, Offset: 0x1b68
    // Size: 0x1f8
    function function_ead1dc1a() {
        self endon(#"disconnect");
        while (true) {
            if (getdvarstring("<dev string:x382>") == "<dev string:x756>") {
                wait 0.2;
                continue;
            }
            var_a508ba69 = getdvarstring("<dev string:x382>");
            command = getsubstr(var_a508ba69, 0, 3);
            map_name = getsubstr(var_a508ba69, 4, var_a508ba69.size);
            switch (command) {
            case "<dev string:x757>":
                adddebugcommand("<dev string:x75b>" + map_name + "<dev string:x781>" + "<dev string:x2f6>");
                adddebugcommand("<dev string:x75b>" + map_name + "<dev string:x797>");
                adddebugcommand("<dev string:x7b4>");
                break;
            case "<dev string:x7c1>":
                adddebugcommand("<dev string:x75b>" + map_name + "<dev string:x7c5>");
                adddebugcommand("<dev string:x75b>" + map_name + "<dev string:x7dd>");
                adddebugcommand("<dev string:x7b4>");
                break;
            }
            setdvar("<dev string:x382>", "<dev string:x756>");
            wait 0.2;
        }
    }

#/
