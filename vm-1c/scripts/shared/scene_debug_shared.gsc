#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scriptbundle_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace scene;

/#

    // Namespace scene
    // Params 0, eflags: 0x2
    // Checksum 0x90cc8e04, Offset: 0x1a8
    // Size: 0x34
    function autoexec function_2dc19561() {
        system::register("<dev string:x28>", &__init__, undefined, undefined);
    }

    // Namespace scene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x945419c1, Offset: 0x1e8
    // Size: 0x11c
    function __init__() {
        if (getdvarstring("<dev string:x34>", "<dev string:x44>") == "<dev string:x44>") {
            setdvar("<dev string:x34>", "<dev string:x45>");
        }
        setdvar("<dev string:x4d>", "<dev string:x44>");
        setdvar("<dev string:x5e>", "<dev string:x44>");
        setdvar("<dev string:x70>", "<dev string:x44>");
        level thread run_scene_tests();
        level thread toggle_scene_menu();
        level thread toggle_postfx_igc_loop();
        level thread function_f69ab75e();
    }

    // Namespace scene
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf81a5076, Offset: 0x310
    // Size: 0xd8
    function function_f69ab75e() {
        while (true) {
            level flagsys::wait_till("<dev string:x82>");
            foreach (var_4d881e03 in function_c4a37ed9()) {
                var_4d881e03 thread debug_display();
            }
            level flagsys::wait_till_clear("<dev string:x82>");
        }
    }

    // Namespace scene
    // Params 0, eflags: 0x1 linked
    // Checksum 0xb19f2ffc, Offset: 0x3f0
    // Size: 0x104
    function function_c4a37ed9() {
        a_scenes = arraycombine(struct::get_array("<dev string:x8d>", "<dev string:xa0>"), struct::get_array("<dev string:xaa>", "<dev string:xa0>"), 0, 0);
        foreach (a_active_scenes in level.active_scenes) {
            a_scenes = arraycombine(a_scenes, a_active_scenes, 0, 0);
        }
        return a_scenes;
    }

    // Namespace scene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8208f8ca, Offset: 0x500
    // Size: 0x698
    function run_scene_tests() {
        level endon(#"run_scene_tests");
        level.scene_test_struct = spawnstruct();
        level.scene_test_struct.origin = (0, 0, 0);
        level.scene_test_struct.angles = (0, 0, 0);
        while (true) {
            str_scene = getdvarstring("<dev string:xbe>");
            str_client_scene = getdvarstring("<dev string:x4d>");
            str_mode = tolower(getdvarstring("<dev string:x34>", "<dev string:x45>"));
            b_capture = str_mode == "<dev string:xc8>" || str_mode == "<dev string:xd7>";
            if (b_capture) {
                if (ispc()) {
                    if (str_scene != "<dev string:x44>") {
                        setdvar("<dev string:xe6>", str_scene);
                        setdvar("<dev string:xbe>", "<dev string:x44>");
                    }
                } else {
                    setdvar("<dev string:x34>", "<dev string:x45>");
                }
            } else {
                if (str_client_scene != "<dev string:x44>") {
                    level util::clientnotify(str_client_scene + "<dev string:xf1>");
                    util::wait_network_frame();
                }
                if (str_scene != "<dev string:x44>") {
                    setdvar("<dev string:xbe>", "<dev string:x44>");
                    clear_old_ents(str_scene);
                    b_found = 0;
                    a_scenes = struct::get_array(str_scene, "<dev string:xfa>");
                    foreach (s_instance in a_scenes) {
                        if (isdefined(s_instance)) {
                            b_found = 1;
                            s_instance thread test_play(undefined, str_mode);
                        }
                    }
                    if (!b_found && isdefined(level.active_scenes[str_scene])) {
                        foreach (s_instance in level.active_scenes[str_scene]) {
                            b_found = 1;
                            s_instance thread test_play(str_scene, str_mode);
                        }
                    }
                    if (!b_found) {
                        level.scene_test_struct thread test_play(str_scene, str_mode);
                    }
                }
            }
            str_scene = getdvarstring("<dev string:xe6>");
            str_client_scene = getdvarstring("<dev string:x5e>");
            if (str_client_scene != "<dev string:x44>") {
                level util::clientnotify(str_client_scene + "<dev string:x10b>");
                util::wait_network_frame();
            }
            if (str_scene != "<dev string:x44>") {
                setdvar("<dev string:xe6>", "<dev string:x44>");
                clear_old_ents(str_scene);
                b_found = 0;
                a_scenes = struct::get_array(str_scene, "<dev string:xfa>");
                foreach (s_instance in a_scenes) {
                    if (isdefined(s_instance)) {
                        b_found = 1;
                        s_instance thread test_init();
                    }
                }
                if (!b_found) {
                    level.scene_test_struct thread test_init(str_scene);
                }
                if (b_capture) {
                    capture_scene(str_scene, str_mode);
                }
            }
            str_scene = getdvarstring("<dev string:x114>");
            str_client_scene = getdvarstring("<dev string:x70>");
            if (str_client_scene != "<dev string:x44>") {
                level util::clientnotify(str_client_scene + "<dev string:x11f>");
                util::wait_network_frame();
            }
            if (str_scene != "<dev string:x44>") {
                setdvar("<dev string:x114>", "<dev string:x44>");
                level stop(str_scene, 1);
            }
            wait 0.05;
        }
    }

    // Namespace scene
    // Params 2, eflags: 0x1 linked
    // Checksum 0xcdc90501, Offset: 0xba0
    // Size: 0x5c
    function capture_scene(str_scene, str_mode) {
        setdvar("<dev string:x128>", 0);
        level play(str_scene, undefined, undefined, 1, undefined, str_mode);
    }

    // Namespace scene
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb17abb79, Offset: 0xc08
    // Size: 0xc2
    function clear_old_ents(str_scene) {
        foreach (ent in getentarray(str_scene, "<dev string:x133>")) {
            if (ent.scene_spawned === str_scene) {
                ent delete();
            }
        }
    }

    // Namespace scene
    // Params 0, eflags: 0x1 linked
    // Checksum 0xccf595b1, Offset: 0xcd8
    // Size: 0x178
    function toggle_scene_menu() {
        setdvar("<dev string:x128>", 0);
        n_scene_menu_last = -1;
        while (true) {
            n_scene_menu = getdvarstring("<dev string:x128>");
            if (n_scene_menu != "<dev string:x44>") {
                n_scene_menu = int(n_scene_menu);
                if (n_scene_menu != n_scene_menu_last) {
                    switch (n_scene_menu) {
                    case 1:
                        level thread display_scene_menu("<dev string:x142>");
                        break;
                    case 2:
                        level thread display_scene_menu("<dev string:x148>");
                        break;
                    default:
                        level flagsys::clear("<dev string:x14f>");
                        level notify(#"scene_menu_cleanup");
                        setdvar("<dev string:x159>", 0);
                        setdvar("<dev string:x175>", 1);
                        break;
                    }
                    n_scene_menu_last = n_scene_menu;
                }
            }
            wait 0.05;
        }
    }

    // Namespace scene
    // Params 2, eflags: 0x1 linked
    // Checksum 0x4b1c36ed, Offset: 0xe58
    // Size: 0x192
    function function_5d3bb86a(scene_name, index) {
        player = level.host;
        alpha = 1;
        color = (0.9, 0.9, 0.9);
        if (index != -1) {
            if (index != 5) {
                alpha = 1 - abs(5 - index) / 5;
            }
        }
        if (alpha == 0) {
            alpha = 0.05;
        }
        hudelem = player openluimenu("<dev string:x184>");
        player setluimenudata(hudelem, "<dev string:x193>", scene_name);
        player setluimenudata(hudelem, "<dev string:x198>", 100);
        player setluimenudata(hudelem, "<dev string:x19a>", 80 + index * 18);
        player setluimenudata(hudelem, "<dev string:x19c>", 1000);
        return hudelem;
    }

    // Namespace scene
    // Params 1, eflags: 0x1 linked
    // Checksum 0x8ec5f1b4, Offset: 0xff8
    // Size: 0x948
    function display_scene_menu(str_type) {
        if (!isdefined(str_type)) {
            str_type = "<dev string:x142>";
        }
        level notify(#"scene_menu_cleanup");
        level endon(#"scene_menu_cleanup");
        waittillframeend();
        level flagsys::set("<dev string:x14f>");
        setdvar("<dev string:x159>", 1);
        setdvar("<dev string:x175>", 0);
        level thread function_96d7ecd1();
        hudelem = level.host openluimenu("<dev string:x184>");
        level.host setluimenudata(hudelem, "<dev string:x193>", "<dev string:x1a2>");
        level.host setluimenudata(hudelem, "<dev string:x198>", 100);
        level.host setluimenudata(hudelem, "<dev string:x19a>", 520);
        level.host setluimenudata(hudelem, "<dev string:x19c>", 500);
        a_scenedefs = get_scenedefs(str_type);
        if (str_type == "<dev string:x142>") {
            a_scenedefs = arraycombine(a_scenedefs, get_scenedefs("<dev string:x1c4>"), 0, 1);
        }
        names = [];
        foreach (s_scenedef in a_scenedefs) {
            array::add_sorted(names, s_scenedef.name, 0);
        }
        names[names.size] = "<dev string:x1ce>";
        elems = function_b0ed6108();
        title = function_5d3bb86a(str_type + "<dev string:x1d3>", -1);
        selected = 0;
        up_pressed = 0;
        down_pressed = 0;
        held = 0;
        scene_list_settext(elems, names, selected);
        old_selected = selected;
        level thread scene_menu_cleanup(elems, title, hudelem);
        while (true) {
            scene_list_settext(elems, names, selected);
            if (held) {
                wait 0.5;
            }
            if (!up_pressed) {
                if (level.host util::up_button_pressed()) {
                    up_pressed = 1;
                    selected--;
                }
            } else if (level.host util::up_button_held()) {
                held = 1;
                selected -= 10;
            } else if (!level.host util::up_button_pressed()) {
                held = 0;
                up_pressed = 0;
            }
            if (!down_pressed) {
                if (level.host util::down_button_pressed()) {
                    down_pressed = 1;
                    selected++;
                }
            } else if (level.host util::down_button_held()) {
                held = 1;
                selected += 10;
            } else if (!level.host util::down_button_pressed()) {
                held = 0;
                down_pressed = 0;
            }
            if (held) {
                if (selected < 0) {
                    selected = 0;
                } else if (selected >= names.size) {
                    selected = names.size - 1;
                }
            } else if (selected < 0) {
                selected = names.size - 1;
            } else if (selected >= names.size) {
                selected = 0;
            }
            if (level.host buttonpressed("<dev string:x1d6>")) {
                setdvar("<dev string:x128>", 0);
            }
            if (names[selected] != "<dev string:x1ce>") {
                if (level.host buttonpressed("<dev string:x1df>") || level.host buttonpressed("<dev string:x1ea>")) {
                    level.host move_to_scene(names[selected]);
                    while (level.host buttonpressed("<dev string:x1df>") || level.host buttonpressed("<dev string:x1ea>")) {
                        wait 0.05;
                    }
                } else if (level.host buttonpressed("<dev string:x1f5>") || level.host buttonpressed("<dev string:x1ff>")) {
                    level.host move_to_scene(names[selected], 1);
                    while (level.host buttonpressed("<dev string:x1f5>") || level.host buttonpressed("<dev string:x1ff>")) {
                        wait 0.05;
                    }
                }
            }
            if (level.host buttonpressed("<dev string:x209>") || level.host buttonpressed("<dev string:x212>") || level.host buttonpressed("<dev string:x21b>")) {
                if (names[selected] == "<dev string:x1ce>") {
                    setdvar("<dev string:x128>", 0);
                } else if (is_scene_playing(names[selected])) {
                    setdvar("<dev string:x114>", names[selected]);
                } else if (is_scene_initialized(names[selected])) {
                    setdvar("<dev string:xbe>", names[selected]);
                } else if (has_init_state(names[selected])) {
                    setdvar("<dev string:xe6>", names[selected]);
                } else {
                    setdvar("<dev string:xbe>", names[selected]);
                }
                while (level.host buttonpressed("<dev string:x209>") || level.host buttonpressed("<dev string:x212>") || level.host buttonpressed("<dev string:x21b>")) {
                    wait 0.05;
                }
            }
            wait 0.05;
        }
    }

    // Namespace scene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1b325cc0, Offset: 0x1948
    // Size: 0x234
    function function_96d7ecd1() {
        hudelem = level.host openluimenu("<dev string:x184>");
        level.host setluimenudata(hudelem, "<dev string:x198>", 100);
        level.host setluimenudata(hudelem, "<dev string:x19a>", 490);
        level.host setluimenudata(hudelem, "<dev string:x19c>", 500);
        while (level flagsys::get("<dev string:x14f>")) {
            str_mode = tolower(getdvarstring("<dev string:x34>", "<dev string:x45>"));
            switch (str_mode) {
            case "<dev string:x45>":
                level.host setluimenudata(hudelem, "<dev string:x193>", "<dev string:x221>");
                break;
            case "<dev string:x22f>":
                level.host setluimenudata(hudelem, "<dev string:x193>", "<dev string:x234>");
                break;
            case "<dev string:xc8>":
                level.host setluimenudata(hudelem, "<dev string:x193>", "<dev string:x23f>");
                break;
            case "<dev string:xd7>":
                level.host setluimenudata(hudelem, "<dev string:x193>", "<dev string:x254>");
                break;
            }
            wait 0.05;
        }
        level.host closeluimenu(hudelem);
    }

    // Namespace scene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8c620ae4, Offset: 0x1b88
    // Size: 0x82
    function function_b0ed6108() {
        hud_array = [];
        for (i = 0; i < 22; i++) {
            hud = function_5d3bb86a("<dev string:x44>", i);
            hud_array[hud_array.size] = hud;
        }
        return hud_array;
    }

    // Namespace scene
    // Params 3, eflags: 0x1 linked
    // Checksum 0x6704776f, Offset: 0x1c18
    // Size: 0x20e
    function scene_list_settext(hud_array, strings, num) {
        for (i = 0; i < hud_array.size; i++) {
            index = i + num - 5;
            if (isdefined(strings[index])) {
                text = strings[index];
            } else {
                text = "<dev string:x44>";
            }
            if (is_scene_playing(text)) {
                level.host setluimenudata(hud_array[i], "<dev string:x269>", 1);
                text += "<dev string:x26f>";
            } else if (is_scene_initialized(text)) {
                level.host setluimenudata(hud_array[i], "<dev string:x269>", 1);
                text += "<dev string:x27a>";
            } else {
                level.host setluimenudata(hud_array[i], "<dev string:x269>", 0.5);
            }
            if (i == 5) {
                level.host setluimenudata(hud_array[i], "<dev string:x269>", 1);
                text = "<dev string:x289>" + text + "<dev string:x28b>";
            }
            level.host setluimenudata(hud_array[i], "<dev string:x193>", text);
        }
    }

    // Namespace scene
    // Params 1, eflags: 0x1 linked
    // Checksum 0x6a7fe4c7, Offset: 0x1e30
    // Size: 0x60
    function is_scene_playing(str_scene) {
        if (str_scene != "<dev string:x44>" && str_scene != "<dev string:x1ce>") {
            if (level flagsys::get(str_scene + "<dev string:x28d>")) {
                return 1;
            }
        }
        return 0;
    }

    // Namespace scene
    // Params 1, eflags: 0x1 linked
    // Checksum 0x2672de33, Offset: 0x1e98
    // Size: 0x60
    function is_scene_initialized(str_scene) {
        if (str_scene != "<dev string:x44>" && str_scene != "<dev string:x1ce>") {
            if (level flagsys::get(str_scene + "<dev string:x296>")) {
                return 1;
            }
        }
        return 0;
    }

    // Namespace scene
    // Params 3, eflags: 0x1 linked
    // Checksum 0x3fd7833b, Offset: 0x1f00
    // Size: 0xb4
    function scene_menu_cleanup(elems, title, hudelem) {
        level waittill(#"scene_menu_cleanup");
        level.host closeluimenu(title);
        for (i = 0; i < elems.size; i++) {
            level.host closeluimenu(elems[i]);
        }
        level.host closeluimenu(hudelem);
    }

    // Namespace scene
    // Params 1, eflags: 0x1 linked
    // Checksum 0xf08f4948, Offset: 0x1fc0
    // Size: 0x2c
    function test_init(arg1) {
        init(arg1, undefined, undefined, 1);
    }

    // Namespace scene
    // Params 2, eflags: 0x1 linked
    // Checksum 0x712082f7, Offset: 0x1ff8
    // Size: 0x3c
    function test_play(arg1, str_mode) {
        play(arg1, undefined, undefined, 1, undefined, str_mode);
    }

    // Namespace scene
    // Params 0, eflags: 0x1 linked
    // Checksum 0xfaae9549, Offset: 0x2040
    // Size: 0x2de
    function debug_display() {
        self endon(#"death");
        self notify(#"hash_87671d41");
        self endon(#"hash_87671d41");
        level endon(#"kill_anim_debug");
        while (true) {
            debug_frames = randomintrange(5, 15);
            debug_time = debug_frames / 20;
            v_origin = isdefined(self.origin) ? self.origin : (0, 0, 0);
            sphere(v_origin, 1, (1, 1, 0), 1, 1, 8, debug_frames);
            if (isdefined(self.scenes)) {
                foreach (i, o_scene in self.scenes) {
                    n_offset = 15 * (i + 1);
                    print3d(v_origin - (0, 0, n_offset), [[ o_scene ]]->get_name(), (0.8, 0.2, 0.8), 1, 0.3, debug_frames);
                    print3d(v_origin - (0, 0, n_offset + 5), "<dev string:x2a3>" + (isdefined([[ o_scene ]]->get_state()) ? "<dev string:x44>" + [[ o_scene ]]->get_state() : "<dev string:x44>") + "<dev string:x2a5>", (0.8, 0.2, 0.8), 1, 0.15, debug_frames);
                }
            } else if (isdefined(self.scriptbundlename)) {
                print3d(v_origin - (0, 0, 15), self.scriptbundlename, (0.8, 0.2, 0.8), 1, 0.3, debug_frames);
            } else {
                break;
            }
            wait debug_time;
        }
    }

    // Namespace scene
    // Params 2, eflags: 0x1 linked
    // Checksum 0x2546c035, Offset: 0x2328
    // Size: 0x224
    function move_to_scene(str_scene, b_reverse_dir) {
        if (!isdefined(b_reverse_dir)) {
            b_reverse_dir = 0;
        }
        if (!(level.debug_current_scene_name === str_scene)) {
            level.debug_current_scene_instances = struct::get_array(str_scene, "<dev string:xfa>");
            level.debug_current_scene_index = 0;
            level.debug_current_scene_name = str_scene;
        } else if (b_reverse_dir) {
            level.debug_current_scene_index--;
            if (level.debug_current_scene_index == -1) {
                level.debug_current_scene_index = level.debug_current_scene_instances.size - 1;
            }
        } else {
            level.debug_current_scene_index++;
            if (level.debug_current_scene_index == level.debug_current_scene_instances.size) {
                level.debug_current_scene_index = 0;
            }
        }
        if (level.debug_current_scene_instances.size == 0) {
            s_bundle = struct::get_script_bundle("<dev string:x142>", str_scene);
            if (isdefined(s_bundle.aligntarget)) {
                e_align = get_existing_ent(s_bundle.aligntarget, 0, 1);
                if (isdefined(e_align)) {
                    level.host set_origin(e_align.origin);
                } else {
                    scriptbundle::error_on_screen("<dev string:x2a7>");
                }
            } else {
                scriptbundle::error_on_screen("<dev string:x2d7>");
            }
            return;
        }
        s_scene = level.debug_current_scene_instances[level.debug_current_scene_index];
        level.host set_origin(s_scene.origin);
    }

    // Namespace scene
    // Params 1, eflags: 0x1 linked
    // Checksum 0x6126f971, Offset: 0x2558
    // Size: 0x64
    function set_origin(v_origin) {
        if (!self isinmovemode("<dev string:x306>", "<dev string:x30a>")) {
            adddebugcommand("<dev string:x30a>");
        }
        self setorigin(v_origin);
    }

    // Namespace scene
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf20f5baf, Offset: 0x25c8
    // Size: 0x74
    function toggle_postfx_igc_loop() {
        while (true) {
            if (getdvarint("<dev string:x311>", 0)) {
                array::run_all(level.activeplayers, &clientfield::increment_to_player, "<dev string:x325>", 1);
                wait 4;
            }
            wait 1;
        }
    }

#/
