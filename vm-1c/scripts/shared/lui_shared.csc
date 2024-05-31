#using scripts/core/_multi_extracam;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/_character_customization;
#using scripts/codescripts/struct;

#using_animtree("all_player");

#namespace lui;

// Namespace lui
// Params 0, eflags: 0x2
// namespace_ce7c3ed5<file_0>::function_2dc19561
// Checksum 0x9856002, Offset: 0x228
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("lui_shared", &__init__, undefined, undefined);
}

// Namespace lui
// Params 0, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_8c87d8eb
// Checksum 0x16b8ac5f, Offset: 0x268
// Size: 0x3c
function __init__() {
    level.client_menus = associativearray();
    callback::on_localclient_connect(&on_player_connect);
}

// Namespace lui
// Params 1, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_fb4f96b5
// Checksum 0xa0d86ac1, Offset: 0x2b0
// Size: 0x24
function on_player_connect(localclientnum) {
    level thread client_menus(localclientnum);
}

// Namespace lui
// Params 1, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_2d7df35a
// Checksum 0x98e37b12, Offset: 0x2e0
// Size: 0x52
function initmenudata(localclientnum) {
    assert(!isdefined(level.client_menus[localclientnum]));
    level.client_menus[localclientnum] = associativearray();
}

// Namespace lui
// Params 7, eflags: 0x0
// namespace_ce7c3ed5<file_0>::function_4e061d57
// Checksum 0xd3bb87f4, Offset: 0x340
// Size: 0x1a6
function createextracamxcamdata(menu_name, localclientnum, extracam_index, target_name, xcam, sub_xcam, xcam_frame) {
    assert(isdefined(level.client_menus[localclientnum][menu_name]));
    menu_data = level.client_menus[localclientnum][menu_name];
    extracam_data = spawnstruct();
    extracam_data.extracam_index = extracam_index;
    extracam_data.target_name = target_name;
    extracam_data.xcam = xcam;
    extracam_data.sub_xcam = sub_xcam;
    extracam_data.xcam_frame = xcam_frame;
    if (!isdefined(menu_data.extra_cams)) {
        menu_data.extra_cams = [];
    } else if (!isarray(menu_data.extra_cams)) {
        menu_data.extra_cams = array(menu_data.extra_cams);
    }
    menu_data.extra_cams[menu_data.extra_cams.size] = extracam_data;
}

// Namespace lui
// Params 4, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_37071106
// Checksum 0x886a3fce, Offset: 0x4f0
// Size: 0x14e
function createcustomextracamxcamdata(menu_name, localclientnum, extracam_index, camera_function) {
    assert(isdefined(level.client_menus[localclientnum][menu_name]));
    menu_data = level.client_menus[localclientnum][menu_name];
    extracam_data = spawnstruct();
    extracam_data.extracam_index = extracam_index;
    extracam_data.camera_function = camera_function;
    if (!isdefined(menu_data.extra_cams)) {
        menu_data.extra_cams = [];
    } else if (!isarray(menu_data.extra_cams)) {
        menu_data.extra_cams = array(menu_data.extra_cams);
    }
    menu_data.extra_cams[menu_data.extra_cams.size] = extracam_data;
}

// Namespace lui
// Params 3, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_ad22f2bf
// Checksum 0xdf29c4b5, Offset: 0x648
// Size: 0x226
function addmenuexploders(menu_name, localclientnum, exploder) {
    assert(isdefined(level.client_menus[localclientnum][menu_name]));
    menu_data = level.client_menus[localclientnum][menu_name];
    if (isarray(exploder)) {
        foreach (expl in exploder) {
            if (!isdefined(menu_data.exploders)) {
                menu_data.exploders = [];
            } else if (!isarray(menu_data.exploders)) {
                menu_data.exploders = array(menu_data.exploders);
            }
            menu_data.exploders[menu_data.exploders.size] = expl;
        }
        return;
    }
    if (!isdefined(menu_data.exploders)) {
        menu_data.exploders = [];
    } else if (!isarray(menu_data.exploders)) {
        menu_data.exploders = array(menu_data.exploders);
    }
    menu_data.exploders[menu_data.exploders.size] = exploder;
}

// Namespace lui
// Params 3, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_1c470db0
// Checksum 0x22739eae, Offset: 0x878
// Size: 0x154
function linktocustomcharacter(menu_name, localclientnum, target_name) {
    assert(isdefined(level.client_menus[localclientnum][menu_name]));
    menu_data = level.client_menus[localclientnum][menu_name];
    assert(!isdefined(menu_data.custom_character));
    model = getent(localclientnum, target_name, "targetname");
    if (!isdefined(model)) {
        model = util::spawn_model(localclientnum, "tag_origin");
        model.targetname = target_name;
    }
    model useanimtree(#all_player);
    menu_data.custom_character = character_customization::function_b79cb078(model, localclientnum);
    model hide();
}

// Namespace lui
// Params 2, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_a01a0104
// Checksum 0xdc1c6dd2, Offset: 0x9d8
// Size: 0x4a
function getcharacterdataformenu(menu_name, localclientnum) {
    if (isdefined(level.client_menus[localclientnum][menu_name])) {
        return level.client_menus[localclientnum][menu_name].custom_character;
    }
    return undefined;
}

// Namespace lui
// Params 8, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_c9647d4d
// Checksum 0xd6cbf158, Offset: 0xa30
// Size: 0x164
function createcameramenu(menu_name, localclientnum, target_name, xcam, sub_xcam, xcam_frame, var_3122eae6, var_dd603074) {
    if (!isdefined(xcam_frame)) {
        xcam_frame = undefined;
    }
    if (!isdefined(var_3122eae6)) {
        var_3122eae6 = undefined;
    }
    if (!isdefined(var_dd603074)) {
        var_dd603074 = undefined;
    }
    assert(!isdefined(level.client_menus[localclientnum][menu_name]));
    level.client_menus[localclientnum][menu_name] = spawnstruct();
    menu_data = level.client_menus[localclientnum][menu_name];
    menu_data.target_name = target_name;
    menu_data.xcam = xcam;
    menu_data.sub_xcam = sub_xcam;
    menu_data.xcam_frame = xcam_frame;
    menu_data.var_3122eae6 = var_3122eae6;
    menu_data.var_dd603074 = var_dd603074;
    return menu_data;
}

// Namespace lui
// Params 6, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_25d4b1fc
// Checksum 0x594a6769, Offset: 0xba0
// Size: 0x11c
function createcustomcameramenu(menu_name, localclientnum, camera_function, has_state, var_3122eae6, var_dd603074) {
    if (!isdefined(var_3122eae6)) {
        var_3122eae6 = undefined;
    }
    if (!isdefined(var_dd603074)) {
        var_dd603074 = undefined;
    }
    assert(!isdefined(level.client_menus[localclientnum][menu_name]));
    level.client_menus[localclientnum][menu_name] = spawnstruct();
    menu_data = level.client_menus[localclientnum][menu_name];
    menu_data.camera_function = camera_function;
    menu_data.has_state = has_state;
    menu_data.var_3122eae6 = var_3122eae6;
    menu_data.var_dd603074 = var_dd603074;
    return menu_data;
}

// Namespace lui
// Params 3, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_516718d6
// Checksum 0x7f3f05d1, Offset: 0xcc8
// Size: 0x86a
function setup_menu(localclientnum, menu_data, previous_menu) {
    if (isdefined(previous_menu) && isdefined(level.client_menus[localclientnum][previous_menu.menu_name])) {
        previous_menu_info = level.client_menus[localclientnum][previous_menu.menu_name];
        if (isdefined(previous_menu_info.var_dd603074)) {
            if (isarray(previous_menu_info.var_dd603074)) {
                foreach (fn in previous_menu_info.var_dd603074) {
                    [[ fn ]](localclientnum, previous_menu_info);
                }
            } else {
                [[ previous_menu_info.var_dd603074 ]](localclientnum, previous_menu_info);
            }
        }
        if (isdefined(previous_menu_info.extra_cams)) {
            foreach (extracam_data in previous_menu_info.extra_cams) {
                multi_extracam::extracam_reset_index(localclientnum, extracam_data.extracam_index);
            }
        }
        level notify(previous_menu.menu_name + "_closed");
        if (isdefined(previous_menu_info.camera_function)) {
            stopmaincamxcam(localclientnum);
        } else if (isdefined(previous_menu_info.xcam)) {
            stopmaincamxcam(localclientnum);
        }
        if (isdefined(previous_menu_info.custom_character)) {
            previous_menu_info.custom_character.charactermodel hide();
        }
        if (isdefined(previous_menu_info.exploders)) {
            foreach (exploder in previous_menu_info.exploders) {
                killradiantexploder(localclientnum, exploder);
            }
        }
    }
    if (isdefined(menu_data) && isdefined(level.client_menus[localclientnum][menu_data.menu_name])) {
        new_menu = level.client_menus[localclientnum][menu_data.menu_name];
        if (isdefined(new_menu.custom_character)) {
            new_menu.custom_character.charactermodel show();
        }
        if (isdefined(new_menu.exploders)) {
            foreach (exploder in new_menu.exploders) {
                playradiantexploder(localclientnum, exploder);
            }
        }
        if (isdefined(new_menu.camera_function)) {
            if (new_menu.has_state === 1) {
                level thread [[ new_menu.camera_function ]](localclientnum, menu_data.menu_name, menu_data.state);
            } else {
                level thread [[ new_menu.camera_function ]](localclientnum, menu_data.menu_name);
            }
        } else if (isdefined(new_menu.xcam)) {
            camera_ent = struct::get(new_menu.target_name);
            if (isdefined(camera_ent)) {
                playmaincamxcam(localclientnum, new_menu.xcam, 0, new_menu.sub_xcam, "", camera_ent.origin, camera_ent.angles);
            }
        }
        if (isdefined(new_menu.var_3122eae6)) {
            if (isarray(new_menu.var_3122eae6)) {
                foreach (fn in new_menu.var_3122eae6) {
                    [[ fn ]](localclientnum, new_menu);
                }
            } else {
                [[ new_menu.var_3122eae6 ]](localclientnum, new_menu);
            }
        }
        if (isdefined(new_menu.extra_cams)) {
            foreach (extracam_data in new_menu.extra_cams) {
                if (isdefined(extracam_data.camera_function)) {
                    if (new_menu.has_state === 1) {
                        level thread [[ extracam_data.camera_function ]](localclientnum, menu_data.menu_name, extracam_data, menu_data.state);
                    } else {
                        level thread [[ extracam_data.camera_function ]](localclientnum, menu_data.menu_name, extracam_data);
                    }
                    continue;
                }
                camera_ent = multi_extracam::extracam_init_index(localclientnum, extracam_data.target_name, extracam_data.extracam_index);
                if (isdefined(camera_ent)) {
                    if (isdefined(extracam_data.xcam_frame)) {
                        camera_ent playextracamxcam(extracam_data.xcam, 0, extracam_data.sub_xcam, extracam_data.xcam_frame);
                        continue;
                    }
                    camera_ent playextracamxcam(extracam_data.xcam, 0, extracam_data.sub_xcam);
                }
            }
        }
    }
}

// Namespace lui
// Params 1, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_d271da99
// Checksum 0x9a1959c6, Offset: 0x1540
// Size: 0x3f0
function client_menus(localclientnum) {
    level endon(#"disconnect");
    clientmenustack = array();
    while (true) {
        menu_name, status, state = level waittill("menu_change" + localclientnum);
        menu_index = undefined;
        for (i = 0; i < clientmenustack.size; i++) {
            if (clientmenustack[i].menu_name == menu_name) {
                menu_index = i;
                break;
            }
        }
        if (status === "closeToMenu" && isdefined(menu_index)) {
            topmenu = undefined;
            for (i = 0; i < menu_index; i++) {
                popped = array::pop_front(clientmenustack, 0);
                if (!isdefined(topmenu)) {
                    topmenu = popped;
                }
            }
            setup_menu(localclientnum, clientmenustack[0], topmenu);
            continue;
        }
        statechange = isdefined(menu_index) && status !== "closed" && clientmenustack[menu_index].state !== state && !(!isdefined(clientmenustack[menu_index].state) && !isdefined(state));
        updateonly = statechange && menu_index !== 0;
        if (updateonly) {
            clientmenustack[i].state = state;
            continue;
        }
        if ((status === "closed" || statechange) && isdefined(menu_index)) {
            popped = undefined;
            if (getdvarint("ui_execdemo_e3") == 1) {
                while (menu_index >= 0) {
                    if (!isdefined(popped)) {
                        popped = array::pop_front(clientmenustack, 0);
                    }
                    menu_index--;
                }
            } else {
                assert(menu_index == 0);
                popped = array::pop_front(clientmenustack, 0);
            }
            setup_menu(localclientnum, clientmenustack[0], popped);
        }
        if (!isdefined(menu_index) || status === "opened" && statechange) {
            menu_data = spawnstruct();
            menu_data.menu_name = menu_name;
            menu_data.state = state;
            lastmenu = clientmenustack.size > 0 ? clientmenustack[0] : undefined;
            setup_menu(localclientnum, menu_data, lastmenu);
            array::push_front(clientmenustack, menu_data);
        }
    }
}

// Namespace lui
// Params 5, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_3f0b2996
// Checksum 0x83b27f4e, Offset: 0x1938
// Size: 0x14c
function screen_fade(n_time, n_target_alpha, n_start_alpha, str_color, b_force_close_menu) {
    if (!isdefined(n_target_alpha)) {
        n_target_alpha = 1;
    }
    if (!isdefined(n_start_alpha)) {
        n_start_alpha = 0;
    }
    if (!isdefined(str_color)) {
        str_color = "black";
    }
    if (!isdefined(b_force_close_menu)) {
        b_force_close_menu = 0;
    }
    if (self == level) {
        foreach (player in level.players) {
            player thread _screen_fade(n_time, n_target_alpha, n_start_alpha, str_color, b_force_close_menu);
        }
        return;
    }
    self thread _screen_fade(n_time, n_target_alpha, n_start_alpha, str_color, b_force_close_menu);
}

// Namespace lui
// Params 2, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_7e61de2b
// Checksum 0xb533994f, Offset: 0x1a90
// Size: 0x3a
function screen_fade_out(n_time, str_color) {
    screen_fade(n_time, 1, 0, str_color, 0);
    wait(n_time);
}

// Namespace lui
// Params 2, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_593c2af4
// Checksum 0xe6f355b3, Offset: 0x1ad8
// Size: 0x42
function screen_fade_in(n_time, str_color) {
    screen_fade(n_time, 0, 1, str_color, 1);
    wait(n_time);
}

// Namespace lui
// Params 0, eflags: 0x0
// namespace_ce7c3ed5<file_0>::function_23157de
// Checksum 0xb531d4ab, Offset: 0x1b28
// Size: 0xb4
function screen_close_menu() {
    if (self == level) {
        foreach (player in level.players) {
            player thread _screen_close_menu();
        }
        return;
    }
    self thread _screen_close_menu();
}

// Namespace lui
// Params 0, eflags: 0x5 linked
// namespace_ce7c3ed5<file_0>::function_2811b925
// Checksum 0xeefc9064, Offset: 0x1be8
// Size: 0xf0
function private _screen_close_menu() {
    self notify(#"_screen_fade");
    self endon(#"_screen_fade");
    self endon(#"disconnect");
    if (isdefined(self.screen_fade_menus)) {
        str_menu = "FullScreenBlack";
        if (isdefined(self.screen_fade_menus[str_menu])) {
            closeluimenu(self.localclientnum, self.screen_fade_menus[str_menu].lui_menu);
            self.screen_fade_menus[str_menu] = undefined;
        }
        str_menu = "FullScreenWhite";
        if (isdefined(self.screen_fade_menus[str_menu])) {
            closeluimenu(self.localclientnum, self.screen_fade_menus[str_menu].lui_menu);
            self.screen_fade_menus[str_menu] = undefined;
        }
    }
}

// Namespace lui
// Params 5, eflags: 0x5 linked
// namespace_ce7c3ed5<file_0>::function_3dad5d35
// Checksum 0xbca20e54, Offset: 0x1ce0
// Size: 0x3d8
function private _screen_fade(n_time, n_target_alpha, n_start_alpha, v_color, b_force_close_menu) {
    self notify(#"_screen_fade");
    self endon(#"_screen_fade");
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    if (!isdefined(self.screen_fade_menus)) {
        self.screen_fade_menus = [];
    }
    if (!isdefined(v_color)) {
        v_color = (0, 0, 0);
    }
    n_time_ms = int(n_time * 1000);
    str_menu = "FullScreenBlack";
    if (isstring(v_color)) {
        switch (v_color) {
        case 10:
            v_color = (0, 0, 0);
            break;
        case 13:
            v_color = (1, 1, 1);
            break;
        default:
            assertmsg("ui_execdemo_e3");
            break;
        }
    }
    lui_menu = "";
    if (isdefined(self.screen_fade_menus[str_menu])) {
        s_menu = self.screen_fade_menus[str_menu];
        lui_menu = s_menu.lui_menu;
        closeluimenu(self.localclientnum, lui_menu);
        n_start_alpha = lerpfloat(s_menu.n_start_alpha, s_menu.n_target_alpha, gettime() - s_menu.n_start_time);
    }
    lui_menu = createluimenu(self.localclientnum, str_menu);
    self.screen_fade_menus[str_menu] = spawnstruct();
    self.screen_fade_menus[str_menu].lui_menu = lui_menu;
    self.screen_fade_menus[str_menu].n_start_alpha = n_start_alpha;
    self.screen_fade_menus[str_menu].n_target_alpha = n_target_alpha;
    self.screen_fade_menus[str_menu].n_target_time = n_time_ms;
    self.screen_fade_menus[str_menu].n_start_time = gettime();
    self set_color(lui_menu, v_color);
    setluimenudata(self.localclientnum, lui_menu, "startAlpha", n_start_alpha);
    setluimenudata(self.localclientnum, lui_menu, "endAlpha", n_target_alpha);
    setluimenudata(self.localclientnum, lui_menu, "fadeOverTime", n_time_ms);
    openluimenu(self.localclientnum, lui_menu);
    wait(n_time);
    if (b_force_close_menu || n_target_alpha == 0) {
        closeluimenu(self.localclientnum, self.screen_fade_menus[str_menu].lui_menu);
        self.screen_fade_menus[str_menu] = undefined;
    }
}

// Namespace lui
// Params 2, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_46534793
// Checksum 0xaeb53d61, Offset: 0x20c0
// Size: 0xa4
function set_color(menu, color) {
    setluimenudata(self.localclientnum, menu, "red", color[0]);
    setluimenudata(self.localclientnum, menu, "green", color[1]);
    setluimenudata(self.localclientnum, menu, "blue", color[2]);
}

