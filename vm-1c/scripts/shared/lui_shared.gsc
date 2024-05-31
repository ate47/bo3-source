#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/string_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace lui;

// Namespace lui
// Params 0, eflags: 0x2
// namespace_ce7c3ed5<file_0>::function_2dc19561
// Checksum 0x7c192381, Offset: 0x310
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("lui_shared", &__init__, undefined, undefined);
}

// Namespace lui
// Params 0, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_8c87d8eb
// Checksum 0x3a3fbbd1, Offset: 0x350
// Size: 0x24
function __init__() {
    callback::on_spawned(&refresh_menu_values);
}

// Namespace lui
// Params 0, eflags: 0x5 linked
// namespace_ce7c3ed5<file_0>::function_53c7e831
// Checksum 0x156ebb14, Offset: 0x380
// Size: 0x130
function private refresh_menu_values() {
    if (!isdefined(level.lui_script_globals)) {
        return;
    }
    var_7f819867 = getarraykeys(level.lui_script_globals);
    for (i = 0; i < var_7f819867.size; i++) {
        str_menu = var_7f819867[i];
        var_6733360b = getarraykeys(level.lui_script_globals[str_menu]);
        for (j = 0; j < var_6733360b.size; j++) {
            var_f0ab9680 = var_6733360b[j];
            value = level.lui_script_globals[str_menu][var_f0ab9680];
            self set_value_for_player(str_menu, var_f0ab9680, value);
        }
    }
}

// Namespace lui
// Params 2, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_5f70476c
// Checksum 0x1eebb1f7, Offset: 0x4b8
// Size: 0x9c
function play_animation(menu, str_anim) {
    str_curr_anim = self getluimenudata(menu, "current_animation");
    str_new_anim = str_anim;
    if (isdefined(str_curr_anim) && str_curr_anim == str_anim) {
        str_new_anim = "";
    }
    self setluimenudata(menu, "current_animation", str_new_anim);
}

// Namespace lui
// Params 2, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_46534793
// Checksum 0x28dc005, Offset: 0x560
// Size: 0x8c
function set_color(menu, color) {
    self setluimenudata(menu, "red", color[0]);
    self setluimenudata(menu, "green", color[1]);
    self setluimenudata(menu, "blue", color[2]);
}

// Namespace lui
// Params 3, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_d2ef5fff
// Checksum 0x64f2902b, Offset: 0x5f8
// Size: 0x94
function set_value_for_player(str_menu_id, str_variable_id, value) {
    if (!isdefined(self.lui_script_menus)) {
        self.lui_script_menus = [];
    }
    if (!isdefined(self.lui_script_menus[str_menu_id])) {
        self.lui_script_menus[str_menu_id] = self openluimenu(str_menu_id);
    }
    self setluimenudata(self.lui_script_menus[str_menu_id], str_variable_id, value);
}

// Namespace lui
// Params 3, eflags: 0x0
// namespace_ce7c3ed5<file_0>::function_494af3ab
// Checksum 0xc284cb4e, Offset: 0x698
// Size: 0x112
function set_global(str_menu_id, str_variable_id, value) {
    if (!isdefined(level.lui_script_globals)) {
        level.lui_script_globals = [];
    }
    if (!isdefined(level.lui_script_globals[str_menu_id])) {
        level.lui_script_globals[str_menu_id] = [];
    }
    level.lui_script_globals[str_menu_id][str_variable_id] = value;
    if (isdefined(level.players)) {
        foreach (player in level.players) {
            player set_value_for_player(str_menu_id, str_variable_id, value);
        }
    }
}

// Namespace lui
// Params 5, eflags: 0x0
// namespace_ce7c3ed5<file_0>::function_6f6f10c
// Checksum 0xba93beb8, Offset: 0x7b8
// Size: 0x17c
function timer(n_time, str_endon, x, y, height) {
    if (!isdefined(x)) {
        x = 1080;
    }
    if (!isdefined(y)) {
        y = -56;
    }
    if (!isdefined(height)) {
        height = 60;
    }
    lui = self openluimenu("HudElementTimer");
    self setluimenudata(lui, "x", x);
    self setluimenudata(lui, "y", y);
    self setluimenudata(lui, "height", height);
    self setluimenudata(lui, "time", gettime() + n_time * 1000);
    if (isdefined(str_endon)) {
        self util::waittill_notify_or_timeout(str_endon, n_time);
    } else {
        wait(n_time);
    }
    self closeluimenu(lui);
}

// Namespace lui
// Params 3, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_2222cd4f
// Checksum 0x1b165576, Offset: 0x940
// Size: 0x10c
function prime_movie(str_movie, b_looping, str_key) {
    if (!isdefined(b_looping)) {
        b_looping = 0;
    }
    if (!isdefined(str_key)) {
        str_key = "";
    }
    if (self == level) {
        foreach (player in level.players) {
            player primemovie(str_movie, b_looping, str_key);
        }
        return;
    }
    player primemovie(str_movie, b_looping, str_key);
}

// Namespace lui
// Params 5, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_8f7bd062
// Checksum 0xbc4cec1c, Offset: 0xa58
// Size: 0x2fe
function play_movie(str_movie, str_type, show_black_screen, b_looping, str_key) {
    if (!isdefined(show_black_screen)) {
        show_black_screen = 0;
    }
    if (!isdefined(b_looping)) {
        b_looping = 0;
    }
    if (!isdefined(str_key)) {
        str_key = "";
    }
    if (str_type === "fullscreen" || str_type === "fullscreen_additive") {
        b_hide_hud = 1;
    }
    if (self == level) {
        foreach (player in level.players) {
            if (isdefined(b_hide_hud)) {
                player flagsys::set("playing_movie_hide_hud");
                player util::show_hud(0);
            }
            player thread _play_movie_for_player(str_movie, str_type, show_black_screen, b_looping, str_key);
        }
        array::wait_till(level.players, "movie_done");
        if (isdefined(b_hide_hud)) {
            foreach (player in level.players) {
                player flagsys::clear("playing_movie_hide_hud");
                player util::show_hud(1);
            }
        }
    } else {
        if (isdefined(b_hide_hud)) {
            self flagsys::set("playing_movie_hide_hud");
            self util::show_hud(0);
        }
        _play_movie_for_player(str_movie, str_type, 0, b_looping, str_key);
        if (isdefined(b_hide_hud)) {
            self flagsys::clear("playing_movie_hide_hud");
            self util::show_hud(1);
        }
    }
    level notify(#"movie_done", str_type);
}

// Namespace lui
// Params 5, eflags: 0x5 linked
// namespace_ce7c3ed5<file_0>::function_42f28535
// Checksum 0xa6f7e2b, Offset: 0xd60
// Size: 0x2ce
function private _play_movie_for_player(str_movie, str_type, show_black_screen, b_looping, str_key) {
    self endon(#"disconnect");
    str_menu = undefined;
    switch (str_type) {
    case 11:
    case 12:
        str_menu = "FullscreenMovie";
        break;
    case 17:
        str_menu = "PiPMenu";
        break;
    default:
        assertmsg("y" + str_type + "y");
        break;
    }
    if (str_type == "pip") {
        self playsoundtoplayer("uin_pip_open", self);
    }
    lui_menu = self openluimenu(str_menu);
    if (isdefined(lui_menu)) {
        self setluimenudata(lui_menu, "movieName", str_movie);
        self setluimenudata(lui_menu, "movieKey", str_key);
        self setluimenudata(lui_menu, "showBlackScreen", show_black_screen);
        self setluimenudata(lui_menu, "looping", b_looping);
        self setluimenudata(lui_menu, "additive", 0);
        if (issubstr(str_type, "additive")) {
            self setluimenudata(lui_menu, "additive", 1);
        }
        while (true) {
            menu, response = self waittill(#"menuresponse");
            if (menu == str_menu && response == "finished_movie_playback") {
                if (str_type == "pip") {
                    self playsoundtoplayer("uin_pip_close", self);
                }
                self closeluimenu(lui_menu);
                self notify(#"movie_done");
            }
        }
    }
}

// Namespace lui
// Params 6, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_be38d8cd
// Checksum 0x77729e83, Offset: 0x1038
// Size: 0x272
function function_be38d8cd(str_movie, str_type, timeout, show_black_screen, b_looping, str_key) {
    if (!isdefined(show_black_screen)) {
        show_black_screen = 0;
    }
    if (!isdefined(b_looping)) {
        b_looping = 0;
    }
    if (!isdefined(str_key)) {
        str_key = "";
    }
    if (str_type === "fullscreen" || str_type === "fullscreen_additive") {
        b_hide_hud = 1;
    }
    assert(self == level);
    foreach (player in level.players) {
        if (isdefined(b_hide_hud)) {
            player flagsys::set("playing_movie_hide_hud");
            player util::show_hud(0);
        }
        player thread function_adc333e0(str_movie, str_type, timeout, show_black_screen, b_looping, str_key);
    }
    array::wait_till(level.players, "movie_done");
    if (isdefined(b_hide_hud)) {
        foreach (player in level.players) {
            player flagsys::clear("playing_movie_hide_hud");
            player util::show_hud(1);
        }
    }
    level notify(#"movie_done", str_type);
}

// Namespace lui
// Params 6, eflags: 0x5 linked
// namespace_ce7c3ed5<file_0>::function_adc333e0
// Checksum 0x55f86ea1, Offset: 0x12b8
// Size: 0x292
function private function_adc333e0(str_movie, str_type, timeout, show_black_screen, b_looping, str_key) {
    self endon(#"disconnect");
    str_menu = undefined;
    switch (str_type) {
    case 11:
    case 12:
        str_menu = "FullscreenMovie";
        break;
    case 17:
        str_menu = "PiPMenu";
        break;
    default:
        assertmsg("y" + str_type + "y");
        break;
    }
    if (str_type == "pip") {
        self playsoundtoplayer("uin_pip_open", self);
    }
    lui_menu = self openluimenu(str_menu);
    if (isdefined(lui_menu)) {
        self setluimenudata(lui_menu, "movieName", str_movie);
        self setluimenudata(lui_menu, "movieKey", str_key);
        self setluimenudata(lui_menu, "showBlackScreen", show_black_screen);
        self setluimenudata(lui_menu, "looping", b_looping);
        self setluimenudata(lui_menu, "additive", 0);
        if (issubstr(str_type, "additive")) {
            self setluimenudata(lui_menu, "additive", 1);
        }
        wait(timeout);
        if (str_type == "pip") {
            self playsoundtoplayer("uin_pip_close", self);
        }
        self closeluimenu(lui_menu);
        self notify(#"movie_done");
    }
}

// Namespace lui
// Params 6, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_724abc52
// Checksum 0x148d648b, Offset: 0x1558
// Size: 0x16c
function screen_flash(n_fadein_time, n_hold_time, n_fadeout_time, n_target_alpha, v_color, b_force_close_menu) {
    if (!isdefined(n_target_alpha)) {
        n_target_alpha = 1;
    }
    if (!isdefined(b_force_close_menu)) {
        b_force_close_menu = 0;
    }
    if (self == level) {
        foreach (player in level.players) {
            player thread screen_flash(n_fadein_time, n_hold_time, n_fadeout_time, n_target_alpha, v_color, b_force_close_menu);
        }
        return;
    }
    self endon(#"disconnect");
    self _screen_fade(n_fadein_time, n_target_alpha, 0, v_color, b_force_close_menu);
    wait(n_hold_time);
    self _screen_fade(n_fadeout_time, 0, n_target_alpha, v_color, b_force_close_menu);
}

// Namespace lui
// Params 6, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_3f0b2996
// Checksum 0x712f7821, Offset: 0x16d0
// Size: 0x14c
function screen_fade(n_time, n_target_alpha, n_start_alpha, v_color, b_force_close_menu, str_menu_id) {
    if (!isdefined(n_target_alpha)) {
        n_target_alpha = 1;
    }
    if (!isdefined(n_start_alpha)) {
        n_start_alpha = 0;
    }
    if (!isdefined(b_force_close_menu)) {
        b_force_close_menu = 0;
    }
    if (self == level) {
        foreach (player in level.players) {
            player thread _screen_fade(n_time, n_target_alpha, n_start_alpha, v_color, b_force_close_menu, str_menu_id);
        }
        return;
    }
    self thread _screen_fade(n_time, n_target_alpha, n_start_alpha, v_color, b_force_close_menu, str_menu_id);
}

// Namespace lui
// Params 3, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_7e61de2b
// Checksum 0x1f809824, Offset: 0x1828
// Size: 0x4a
function screen_fade_out(n_time, v_color, str_menu_id) {
    screen_fade(n_time, 1, 0, v_color, 0, str_menu_id);
    wait(n_time);
}

// Namespace lui
// Params 3, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_593c2af4
// Checksum 0xc7383e51, Offset: 0x1880
// Size: 0x4a
function screen_fade_in(n_time, v_color, str_menu_id) {
    screen_fade(n_time, 0, 1, v_color, 1, str_menu_id);
    wait(n_time);
}

// Namespace lui
// Params 0, eflags: 0x1 linked
// namespace_ce7c3ed5<file_0>::function_23157de
// Checksum 0xa3a594ad, Offset: 0x18d8
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
// Checksum 0x3dec8ba6, Offset: 0x1998
// Size: 0xd6
function private _screen_close_menu() {
    self notify(#"_screen_fade");
    self endon(#"_screen_fade");
    self endon(#"disconnect");
    if (isdefined(self.screen_fade_menus)) {
        foreach (str_menu_id, lui_menu in self.screen_fade_menus) {
            self closeluimenu(lui_menu.lui_menu);
            self.screen_fade_menus[str_menu_id] = undefined;
        }
    }
}

// Namespace lui
// Params 6, eflags: 0x5 linked
// namespace_ce7c3ed5<file_0>::function_3dad5d35
// Checksum 0x6d24d048, Offset: 0x1a78
// Size: 0x54e
function private _screen_fade(n_time, n_target_alpha, n_start_alpha, v_color, b_force_close_menu, str_menu_id) {
    if (!isdefined(str_menu_id)) {
        str_menu_id = "default";
    }
    self notify("_screen_fade_" + str_menu_id);
    self endon("_screen_fade_" + str_menu_id);
    self endon(#"disconnect");
    if (!isdefined(self.screen_fade_menus)) {
        self.screen_fade_menus = [];
    }
    if (!isdefined(level.screen_fade_network_frame)) {
        level.screen_fade_network_frame = 0;
    }
    if (!isdefined(v_color)) {
        v_color = (0, 0, 0);
    }
    n_time_ms = int(n_time * 1000);
    str_menu = "FullScreenBlack";
    if (isstring(v_color)) {
        switch (v_color) {
        case 29:
            v_color = (0, 0, 0);
            break;
        case 30:
            v_color = (1, 1, 1);
            break;
        }
    }
    lui_menu = "";
    if (isdefined(self.screen_fade_menus[str_menu_id])) {
        s_menu = self.screen_fade_menus[str_menu_id];
        lui_menu = s_menu.lui_menu;
        _one_screen_fade_per_network_frame(s_menu);
        n_start_alpha = lerpfloat(s_menu.n_start_alpha, s_menu.n_target_alpha, gettime() - s_menu.n_start_time);
    } else {
        lui_menu = self openluimenu(str_menu);
        self.screen_fade_menus[str_menu_id] = spawnstruct();
        self.screen_fade_menus[str_menu_id].lui_menu = lui_menu;
    }
    self.screen_fade_menus[str_menu_id].n_start_alpha = n_start_alpha;
    self.screen_fade_menus[str_menu_id].n_target_alpha = n_target_alpha;
    self.screen_fade_menus[str_menu_id].n_target_time = n_time_ms;
    self.screen_fade_menus[str_menu_id].n_start_time = gettime();
    self set_color(lui_menu, v_color);
    self setluimenudata(lui_menu, "startAlpha", n_start_alpha);
    self setluimenudata(lui_menu, "endAlpha", n_target_alpha);
    self setluimenudata(lui_menu, "fadeOverTime", n_time_ms);
    /#
        if (!isdefined(level.n_fade_debug_time)) {
            level.n_fade_debug_time = 0;
        }
        n_debug_time = gettime();
        if (n_debug_time - level.n_fade_debug_time > 5000) {
            printtoprightln("y");
        }
        level.n_fade_debug_time = n_debug_time;
        printtoprightln("y" + string::function_8e23acba("y" + gettime(), 6) + "y" + string::function_8e23acba(str_menu_id, 10) + "y" + string::function_8e23acba(v_color, 11) + "y" + string::function_8e23acba(n_start_alpha + "y" + n_target_alpha, 10) + "y" + string::function_8e23acba(n_time, 6) + "y", (1, 1, 1));
    #/
    if (n_time > 0) {
        wait(n_time);
    }
    self setluimenudata(lui_menu, "fadeOverTime", 0);
    if (b_force_close_menu || n_target_alpha == 0) {
        if (isdefined(self.screen_fade_menus[str_menu_id])) {
            self closeluimenu(self.screen_fade_menus[str_menu_id].lui_menu);
        }
        self.screen_fade_menus[str_menu_id] = undefined;
        if (!self.screen_fade_menus.size) {
            self.screen_fade_menus = undefined;
        }
    }
}

// Namespace lui
// Params 1, eflags: 0x5 linked
// namespace_ce7c3ed5<file_0>::function_ae1c7ad1
// Checksum 0x47e2b193, Offset: 0x1fd0
// Size: 0x54
function private _one_screen_fade_per_network_frame(s_menu) {
    while (s_menu.screen_fade_network_frame === level.network_frame) {
        util::wait_network_frame();
    }
    s_menu.screen_fade_network_frame = level.network_frame;
}

// Namespace lui
// Params 2, eflags: 0x0
// namespace_ce7c3ed5<file_0>::function_c7825a26
// Checksum 0x5433e658, Offset: 0x2030
// Size: 0xf4
function open_generic_script_dialog(title, description) {
    self endon(#"disconnect");
    dialog = self openluimenu("ScriptMessageDialog_Compact");
    self setluimenudata(dialog, "title", title);
    self setluimenudata(dialog, "description", description);
    do {
        menu, response = self waittill(#"menuresponse");
    } while (menu != "ScriptMessageDialog_Compact" || response != "close");
    self closeluimenu(dialog);
}

// Namespace lui
// Params 1, eflags: 0x0
// namespace_ce7c3ed5<file_0>::function_979762b0
// Checksum 0x6a19f2b5, Offset: 0x2130
// Size: 0x94
function open_script_dialog(dialog_name) {
    self endon(#"disconnect");
    dialog = self openluimenu(dialog_name);
    do {
        menu, response = self waittill(#"menuresponse");
    } while (menu != dialog_name || response != "close");
    self closeluimenu(dialog);
}

