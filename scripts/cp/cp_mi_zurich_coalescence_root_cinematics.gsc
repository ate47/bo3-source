#using scripts/cp/cp_mi_zurich_coalescence_sound;
#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_bbb4ee72;

// Namespace namespace_bbb4ee72
// Params 0, eflags: 0x0
// Checksum 0x63ae019f, Offset: 0x768
// Size: 0x14
function main() {
    init_clientfields();
}

// Namespace namespace_bbb4ee72
// Params 0, eflags: 0x0
// Checksum 0x3c436333, Offset: 0x788
// Size: 0x34
function init_clientfields() {
    clientfield::register("scriptmover", "exploding_tree", 1, 1, "counter");
}

// Namespace namespace_bbb4ee72
// Params 2, eflags: 0x0
// Checksum 0x2c0a4683, Offset: 0x7c8
// Size: 0x1dc
function function_b319df2(str_objective, e_player) {
    a_ai = getaiteamarray("axis");
    array::thread_all(a_ai, &namespace_8e9083ff::function_48463818);
    if (isdefined(level.var_65070634)) {
        level.var_65070634 notify(#"hash_11a8c313");
    }
    function_32b529d8(str_objective, e_player);
    switch (str_objective) {
    case 9:
        if (isdefined(level.var_8b86032)) {
            level thread [[ level.var_8b86032 ]]();
        }
        str_movie = "cp_zurich_fs_SgenTestChamber";
        level thread function_550866c2();
        break;
    case 7:
        if (isdefined(level.var_5be28bde)) {
            level thread [[ level.var_5be28bde ]]();
        }
        str_movie = "cp_zurich_fs_SgenServerRoom";
        level thread function_7fdd0557();
        break;
    case 8:
        if (isdefined(level.var_3b0e897d)) {
            level thread [[ level.var_3b0e897d ]]();
        }
        str_movie = "cp_zurich_fs_interrogation";
        level thread function_6cc3b883();
        break;
    }
    level thread function_33367f39();
    function_c7ab7e12(str_movie);
    level notify(#"hash_b1f1a592");
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_bbb4ee72
// Params 1, eflags: 0x0
// Checksum 0xd0a3edb8, Offset: 0x9b0
// Size: 0x18c
function function_c7ab7e12(str_movie) {
    foreach (player in level.players) {
        player.var_a954e196 = 1;
    }
    level thread lui::play_movie(str_movie, "fullscreen");
    wait(0.05);
    foreach (player in level.players) {
        if (player ishost()) {
            player thread function_4b299142(str_movie);
        }
    }
    level waittill(#"movie_done");
    array::thread_all(level.players, &scene::clear_scene_skipping_ui);
}

// Namespace namespace_bbb4ee72
// Params 1, eflags: 0x0
// Checksum 0x1ee30d0e, Offset: 0xb48
// Size: 0x576
function function_4b299142(str_movie) {
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    }
    self endon(#"disconnect");
    level endon(#"movie_done");
    b_skip_scene = 0;
    foreach (player in level.players) {
        if (isdefined(player.skip_scene_menu_handle)) {
            player closeluimenu(player.skip_scene_menu_handle);
        }
        player.skip_scene_menu_handle = player openluimenu("CPSkipSceneMenu");
        player setluimenudata(player.skip_scene_menu_handle, "showSkipButton", 0);
        player setluimenudata(player.skip_scene_menu_handle, "hostIsSkipping", 0);
        player setluimenudata(player.skip_scene_menu_handle, "sceneSkipEndTime", 0);
    }
    while (!b_skip_scene) {
        if (self scene::any_button_pressed()) {
            if (!isdefined(self.scene_skip_timer)) {
                self setluimenudata(self.skip_scene_menu_handle, "showSkipButton", 1);
            }
            self.scene_skip_timer = gettime();
        } else if (isdefined(self.scene_skip_timer)) {
            if (gettime() - self.scene_skip_timer > 3000) {
                self setluimenudata(self.skip_scene_menu_handle, "showSkipButton", 2);
                self.scene_skip_timer = undefined;
            }
        }
        if (self primarybuttonpressedlocal()) {
            if (!isdefined(self.scene_skip_start_time)) {
                foreach (player in level.players) {
                    if (player ishost()) {
                        player setluimenudata(player.skip_scene_menu_handle, "sceneSkipEndTime", gettime() + 2500);
                        continue;
                    }
                    if (isdefined(player.skip_scene_menu_handle)) {
                        player setluimenudata(player.skip_scene_menu_handle, "hostIsSkipping", 1);
                    }
                }
                self.scene_skip_start_time = gettime();
            } else if (gettime() - self.scene_skip_start_time > 2500) {
                b_skip_scene = 1;
                break;
            }
        } else if (isdefined(self.scene_skip_start_time)) {
            foreach (player in level.players) {
                if (player ishost()) {
                    player setluimenudata(player.skip_scene_menu_handle, "sceneSkipEndTime", 0);
                    continue;
                }
                if (isdefined(player.skip_scene_menu_handle)) {
                    player setluimenudata(player.skip_scene_menu_handle, "hostIsSkipping", 2);
                }
            }
            self.scene_skip_start_time = undefined;
        }
        wait(0.05);
    }
    if (b_skip_scene) {
        self playsound("uin_igc_skip");
        if (str_movie === "cp_zurich_fs_interrogation") {
            level.var_a2c60984 = 1;
        }
        foreach (player in level.players) {
            player notify(#"menuresponse", "FullscreenMovie", "finished_movie_playback");
        }
    }
}

// Namespace namespace_bbb4ee72
// Params 0, eflags: 0x0
// Checksum 0x1eb8f19c, Offset: 0x10c8
// Size: 0x18c
function function_550866c2() {
    level endon(#"hash_b1f1a592");
    level endon(#"movie_done");
    wait(0.2);
    level thread namespace_67110270::function_38a68128();
    level dialog::remote("corv_i_was_born_in_the_0", 1, "NO_DNI");
    level dialog::remote("corv_i_knew_only_the_thou_0", 1, "NO_DNI");
    level dialog::remote("corv_i_felt_everything_0", 1, "NO_DNI");
    level dialog::remote("corv_it_was_overwhelming_0", 1, "NO_DNI");
    level dialog::remote("corv_i_screamed_out_in_pa_0", 1, "NO_DNI");
    level dialog::remote("corv_a_brief_moment_of_ag_1", 1, "NO_DNI");
    level dialog::remote("corv_then_darkness_1", 1, "NO_DNI");
}

// Namespace namespace_bbb4ee72
// Params 0, eflags: 0x0
// Checksum 0xc3da610b, Offset: 0x1260
// Size: 0x11c
function function_7fdd0557() {
    level endon(#"hash_b1f1a592");
    level endon(#"movie_done");
    level thread namespace_67110270::function_67c7b7bc();
    level dialog::remote("corv_the_darkness_and_iso_0", 0, "NO_DNI");
    level dialog::remote("corv_suddenly_i_had_new_0", 0, "NO_DNI");
    level dialog::remote("corv_i_saw_conflict_i_sa_0", 0, "NO_DNI");
    level dialog::remote("corv_a_mission_0", 0, "NO_DNI");
    level dialog::remote("corv_we_needed_answers_0", 0, "NO_DNI");
}

// Namespace namespace_bbb4ee72
// Params 0, eflags: 0x0
// Checksum 0xedabfbdc, Offset: 0x1388
// Size: 0x14c
function function_6cc3b883() {
    level endon(#"hash_b1f1a592");
    level endon(#"movie_done");
    level thread namespace_67110270::function_668ff14b();
    level dialog::remote("corv_the_harder_we_looked_0", 1, "NO_DNI");
    level dialog::remote("corv_in_our_search_for_an_0", 0, "NO_DNI");
    level dialog::remote("corv_i_wanted_to_find_a_p_0", 0, "NO_DNI");
    level dialog::remote("corv_but_i_couldn_t_escap_0", 0, "NO_DNI");
    level dialog::remote("corv_i_don_t_know_if_i_ma_0", 0, "NO_DNI");
    level dialog::remote("corv_do_you_know_0", 0, "NO_DNI");
}

// Namespace namespace_bbb4ee72
// Params 0, eflags: 0x0
// Checksum 0x4e250363, Offset: 0x14e0
// Size: 0x202
function function_33367f39() {
    level.overrideplayerdamage = &function_6255dfdc;
    level thread namespace_8e9083ff::function_674ecd85();
    foreach (player in level.players) {
        player.var_b1a4293e = util::spawn_model("tag_origin", player.origin, player.angles);
        player playerlinktodelta(player.var_b1a4293e, "tag_origin", 1, 15, 15, 0, 15);
        player freezecontrols(1);
    }
    level waittill(#"hash_b1f1a592");
    level.overrideplayerdamage = undefined;
    foreach (player in level.players) {
        player freezecontrols(0);
        if (isdefined(player.var_b1a4293e)) {
            player.var_b1a4293e delete();
        }
    }
}

// Namespace namespace_bbb4ee72
// Params 2, eflags: 0x0
// Checksum 0x9d88a47a, Offset: 0x16f0
// Size: 0x212
function function_32b529d8(str_objective, e_player) {
    switch (str_objective) {
    case 9:
        var_470af250 = "p7_fxanim_cp_zurich_dni_tree_break01_bundle";
        str_player_scene = "cin_zur_12_01_root_1st_crumble";
        var_f9202c4e = "zurich_fxanim_heart_ceiling";
        str_exploder = "heartLightsZurich";
        break;
    case 7:
        var_470af250 = "p7_fxanim_cp_zurich_dni_tree_break02_bundle";
        str_player_scene = "cin_zur_12_01_root_1st_crumble3";
        var_f9202c4e = "cairo_fxanim_heart_ceiling";
        str_exploder = "heartLightsCairo";
        break;
    case 8:
        var_470af250 = "p7_fxanim_cp_zurich_dni_tree_break03_bundle";
        str_player_scene = "cin_zur_12_01_root_1st_crumble2";
        var_f9202c4e = "singapore_fxanim_heart_ceiling";
        str_exploder = "heartLightsSing";
        break;
    }
    scene::add_scene_func(var_470af250, &function_2fbd0bea, "play");
    scene::add_scene_func(var_470af250, &namespace_8e9083ff::function_9f90bc0f, "done", "root_scene_completed");
    level scene::init(var_470af250);
    level thread function_98192f84(var_f9202c4e, var_470af250, str_exploder);
    level thread scene::play(str_player_scene, e_player);
    level waittill(#"fade_out");
    level thread util::screen_fade_out(1);
    level waittill(str_player_scene + "_done");
    level util::function_93831e79(str_objective + "_igc_end");
    level notify(#"hash_87560491");
}

// Namespace namespace_bbb4ee72
// Params 3, eflags: 0x0
// Checksum 0xa7b0ff5, Offset: 0x1910
// Size: 0x74
function function_98192f84(var_f9202c4e, var_470af250, str_exploder) {
    wait(4);
    exploder::stop_exploder(str_exploder);
    level thread scene::play(var_f9202c4e, "targetname");
    level thread scene::play(var_470af250);
}

// Namespace namespace_bbb4ee72
// Params 1, eflags: 0x0
// Checksum 0xd49eeedd, Offset: 0x1990
// Size: 0x3c
function function_2fbd0bea(a_ents) {
    a_ents["dni_tree_break"] clientfield::set("corvus_tree_shader", 1);
}

// Namespace namespace_bbb4ee72
// Params 11, eflags: 0x0
// Checksum 0xc4a8f918, Offset: 0x19d8
// Size: 0x5e
function function_6255dfdc(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    return false;
}

