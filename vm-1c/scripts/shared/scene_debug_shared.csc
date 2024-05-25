#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scriptbundle_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace scene;

/#

    // Namespace scene
    // Params 0, eflags: 0x2
    // Checksum 0x190b6660, Offset: 0x180
    // Size: 0x34
    function autoexec function_2dc19561() {
        system::register("<unknown string>", &__init__, undefined, undefined);
    }

    // Namespace scene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8f374282, Offset: 0x1c0
    // Size: 0xa4
    function __init__() {
        if (getdvarstring("<unknown string>", "<unknown string>") == "<unknown string>") {
            setdvar("<unknown string>", "<unknown string>");
        }
        level thread run_scene_tests();
        level thread toggle_scene_menu();
        level thread function_f69ab75e();
    }

    // Namespace scene
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa6ab3bd5, Offset: 0x270
    // Size: 0xd8
    function function_f69ab75e() {
        while (true) {
            level flagsys::wait_till("<unknown string>");
            foreach (var_4d881e03 in function_c4a37ed9()) {
                var_4d881e03 thread debug_display();
            }
            level flagsys::wait_till_clear("<unknown string>");
        }
    }

    // Namespace scene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8a28e2c5, Offset: 0x350
    // Size: 0x104
    function function_c4a37ed9() {
        a_scenes = arraycombine(struct::get_array("<unknown string>", "<unknown string>"), struct::get_array("<unknown string>", "<unknown string>"), 0, 0);
        foreach (a_active_scenes in level.active_scenes) {
            a_scenes = arraycombine(a_scenes, a_active_scenes, 0, 0);
        }
        return a_scenes;
    }

    // Namespace scene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x712831c9, Offset: 0x460
    // Size: 0x4a0
    function run_scene_tests() {
        level endon(#"run_scene_tests");
        level.scene_test_struct = spawnstruct();
        level.scene_test_struct.origin = (0, 0, 0);
        level.scene_test_struct.angles = (0, 0, 0);
        while (true) {
            str_scene = getdvarstring("<unknown string>");
            str_mode = tolower(getdvarstring("<unknown string>", "<unknown string>"));
            if (str_scene != "<unknown string>") {
                setdvar("<unknown string>", "<unknown string>");
                clear_old_ents(str_scene);
                b_found = 0;
                a_scenes = struct::get_array(str_scene, "<unknown string>");
                foreach (s_instance in a_scenes) {
                    if (isdefined(s_instance)) {
                        b_found = 1;
                        s_instance thread test_play(undefined, str_mode);
                    }
                }
                if (isdefined(level.active_scenes[str_scene])) {
                    foreach (s_instance in level.active_scenes[str_scene]) {
                        if (!isinarray(a_scenes, s_instance)) {
                            b_found = 1;
                            s_instance thread test_play(str_scene, str_mode);
                        }
                    }
                }
                if (!b_found) {
                    level.scene_test_struct thread test_play(str_scene, str_mode);
                }
            }
            str_scene = getdvarstring("<unknown string>");
            if (str_scene != "<unknown string>") {
                setdvar("<unknown string>", "<unknown string>");
                clear_old_ents(str_scene);
                b_found = 0;
                a_scenes = struct::get_array(str_scene, "<unknown string>");
                foreach (s_instance in a_scenes) {
                    if (isdefined(s_instance)) {
                        b_found = 1;
                        s_instance thread test_init();
                    }
                }
                if (!b_found) {
                    level.scene_test_struct thread test_init(str_scene);
                }
            }
            str_scene = getdvarstring("<unknown string>");
            if (str_scene != "<unknown string>") {
                setdvar("<unknown string>", "<unknown string>");
                level stop(str_scene, 1);
            }
            wait(0.016);
        }
    }

    // Namespace scene
    // Params 1, eflags: 0x1 linked
    // Checksum 0xf9d73b94, Offset: 0x908
    // Size: 0xd2
    function clear_old_ents(str_scene) {
        foreach (ent in getentarray(0)) {
            if (ent.scene_spawned === str_scene && ent.finished_scene === str_scene) {
                ent delete();
            }
        }
    }

    // Namespace scene
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa9046d1b, Offset: 0x9e8
    // Size: 0x158
    function toggle_scene_menu() {
        setdvar("<unknown string>", 0);
        n_scene_menu_last = -1;
        while (true) {
            n_scene_menu = getdvarstring("<unknown string>");
            if (n_scene_menu != "<unknown string>") {
                n_scene_menu = int(n_scene_menu);
                if (n_scene_menu != n_scene_menu_last) {
                    switch (n_scene_menu) {
                    case 1:
                        level thread display_scene_menu("<unknown string>");
                        break;
                    case 2:
                        level thread display_scene_menu("<unknown string>");
                        break;
                    default:
                        level flagsys::clear("<unknown string>");
                        level notify(#"scene_menu_cleanup");
                        setdvar("<unknown string>", 1);
                        break;
                    }
                    n_scene_menu_last = n_scene_menu;
                }
            }
            wait(0.05);
        }
    }

    // Namespace scene
    // Params 2, eflags: 0x1 linked
    // Checksum 0x85068a1f, Offset: 0xb48
    // Size: 0x19a
    function function_5d3bb86a(scene_name, index) {
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
        hudelem = createluimenu(0, "<unknown string>");
        setluimenudata(0, hudelem, "<unknown string>", scene_name);
        setluimenudata(0, hudelem, "<unknown string>", 100);
        setluimenudata(0, hudelem, "<unknown string>", 80 + index * 18);
        setluimenudata(0, hudelem, "<unknown string>", 1000);
        openluimenu(0, hudelem);
        return hudelem;
    }

    // Namespace scene
    // Params 1, eflags: 0x1 linked
    // Checksum 0x95c64570, Offset: 0xcf0
    // Size: 0x730
    function display_scene_menu(str_type) {
        if (!isdefined(str_type)) {
            str_type = "<unknown string>";
        }
        level notify(#"scene_menu_cleanup");
        level endon(#"scene_menu_cleanup");
        waittillframeend();
        level flagsys::set("<unknown string>");
        setdvar("<unknown string>", 0);
        level thread function_96d7ecd1();
        a_scenedefs = get_scenedefs(str_type);
        if (str_type == "<unknown string>") {
            a_scenedefs = arraycombine(a_scenedefs, get_scenedefs("<unknown string>"), 0, 1);
        }
        names = [];
        foreach (s_scenedef in a_scenedefs) {
            array::add_sorted(names, s_scenedef.name, 0);
        }
        names[names.size] = "<unknown string>";
        elems = function_b0ed6108();
        title = function_5d3bb86a(str_type + "<unknown string>", -1);
        selected = 0;
        up_pressed = 0;
        down_pressed = 0;
        held = 0;
        scene_list_settext(elems, names, selected);
        old_selected = selected;
        level thread scene_menu_cleanup(elems, title);
        while (true) {
            scene_list_settext(elems, names, selected);
            if (held) {
                wait(0.5);
            }
            if (!up_pressed) {
                if (level.localplayers[0] util::up_button_pressed()) {
                    up_pressed = 1;
                    selected--;
                }
            } else if (level.localplayers[0] util::up_button_held()) {
                held = 1;
                selected -= 10;
            } else if (!level.localplayers[0] util::up_button_pressed()) {
                held = 0;
                up_pressed = 0;
            }
            if (!down_pressed) {
                if (level.localplayers[0] util::down_button_pressed()) {
                    down_pressed = 1;
                    selected++;
                }
            } else if (level.localplayers[0] util::down_button_held()) {
                held = 1;
                selected += 10;
            } else if (!level.localplayers[0] util::down_button_pressed()) {
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
            if (level.localplayers[0] buttonpressed("<unknown string>")) {
                setdvar("<unknown string>", 0);
            }
            if (level.localplayers[0] buttonpressed("<unknown string>") || level.localplayers[0] buttonpressed("<unknown string>") || level.localplayers[0] buttonpressed("<unknown string>")) {
                if (names[selected] == "<unknown string>") {
                    setdvar("<unknown string>", 0);
                } else if (is_scene_playing(names[selected])) {
                    setdvar("<unknown string>", names[selected]);
                } else if (is_scene_initialized(names[selected])) {
                    setdvar("<unknown string>", names[selected]);
                } else if (has_init_state(names[selected])) {
                    setdvar("<unknown string>", names[selected]);
                } else {
                    setdvar("<unknown string>", names[selected]);
                }
                while (level.localplayers[0] buttonpressed("<unknown string>") || level.localplayers[0] buttonpressed("<unknown string>") || level.localplayers[0] buttonpressed("<unknown string>")) {
                    wait(0.016);
                }
            }
            wait(0.016);
        }
    }

    // Namespace scene
    // Params 0, eflags: 0x1 linked
    // Checksum 0xddc307aa, Offset: 0x1428
    // Size: 0x234
    function function_96d7ecd1() {
        hudelem = createluimenu(0, "<unknown string>");
        setluimenudata(0, hudelem, "<unknown string>", 100);
        setluimenudata(0, hudelem, "<unknown string>", 490);
        setluimenudata(0, hudelem, "<unknown string>", 500);
        openluimenu(0, hudelem);
        while (level flagsys::get("<unknown string>")) {
            str_mode = tolower(getdvarstring("<unknown string>", "<unknown string>"));
            switch (str_mode) {
            case 8:
                setluimenudata(0, hudelem, "<unknown string>", "<unknown string>");
                break;
            case 8:
                setluimenudata(0, hudelem, "<unknown string>", "<unknown string>");
                break;
            case 8:
                setluimenudata(0, hudelem, "<unknown string>", "<unknown string>");
                break;
            case 8:
                setluimenudata(0, hudelem, "<unknown string>", "<unknown string>");
                break;
            }
            wait(0.05);
        }
        closeluimenu(0, hudelem);
    }

    // Namespace scene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x3bae486b, Offset: 0x1668
    // Size: 0x82
    function function_b0ed6108() {
        hud_array = [];
        for (i = 0; i < 22; i++) {
            hud = function_5d3bb86a("<unknown string>", i);
            hud_array[hud_array.size] = hud;
        }
        return hud_array;
    }

    // Namespace scene
    // Params 3, eflags: 0x1 linked
    // Checksum 0xac6c5028, Offset: 0x16f8
    // Size: 0x1ee
    function scene_list_settext(hud_array, strings, num) {
                for (i = 0; i < hud_array.size; i++) {
            index = i + num - 5;
            if (isdefined(strings[index])) {
                text = strings[index];
            } else {
                text = "<unknown string>";
            }
            if (is_scene_playing(text)) {
                setluimenudata(0, hud_array[i], "<unknown string>", 1);
                text += "<unknown string>";
            } else if (is_scene_initialized(text)) {
                setluimenudata(0, hud_array[i], "<unknown string>", 1);
                text += "<unknown string>";
            } else {
                setluimenudata(0, hud_array[i], "<unknown string>", 0.5);
            }
            if (i == 5) {
                setluimenudata(0, hud_array[i], "<unknown string>", 1);
                text = "<unknown string>" + text + "<unknown string>";
            }
            setluimenudata(0, hud_array[i], "<unknown string>", text);
        }
    }

    // Namespace scene
    // Params 1, eflags: 0x1 linked
    // Checksum 0xefe33b74, Offset: 0x18f0
    // Size: 0x60
    function is_scene_playing(str_scene) {
        if (str_scene != "<unknown string>" && str_scene != "<unknown string>") {
            if (level flagsys::get(str_scene + "<unknown string>")) {
                return 1;
            }
        }
        return 0;
    }

    // Namespace scene
    // Params 1, eflags: 0x1 linked
    // Checksum 0xf642cc53, Offset: 0x1958
    // Size: 0x60
    function is_scene_initialized(str_scene) {
        if (str_scene != "<unknown string>" && str_scene != "<unknown string>") {
            if (level flagsys::get(str_scene + "<unknown string>")) {
                return 1;
            }
        }
        return 0;
    }

    // Namespace scene
    // Params 2, eflags: 0x1 linked
    // Checksum 0x5e39b8cd, Offset: 0x19c0
    // Size: 0x86
    function scene_menu_cleanup(elems, title) {
        level waittill(#"scene_menu_cleanup");
        closeluimenu(0, title);
        for (i = 0; i < elems.size; i++) {
            closeluimenu(0, elems[i]);
        }
    }

    // Namespace scene
    // Params 1, eflags: 0x1 linked
    // Checksum 0x5f195845, Offset: 0x1a50
    // Size: 0x2c
    function test_init(arg1) {
        init(arg1, undefined, undefined, 1);
    }

    // Namespace scene
    // Params 2, eflags: 0x1 linked
    // Checksum 0xdac5a38d, Offset: 0x1a88
    // Size: 0x3c
    function test_play(arg1, str_mode) {
        play(arg1, undefined, undefined, 1, str_mode);
    }

    // Namespace scene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8d177824, Offset: 0x1ad0
    // Size: 0x2ce
    function debug_display() {
        self endon(#"entityshutdown");
        self notify(#"hash_87671d41");
        self endon(#"hash_87671d41");
        level endon(#"kill_anim_debug");
        while (true) {
            debug_frames = randomintrange(5, 15);
            debug_time = debug_frames / 60;
            sphere(self.origin, 1, (0, 1, 1), 1, 1, 8, debug_frames);
            if (isdefined(self.scenes)) {
                foreach (i, o_scene in self.scenes) {
                    n_offset = 15 * (i + 1);
                    print3d(self.origin - (0, 0, n_offset), [[ o_scene ]]->get_name(), (0.8, 0.2, 0.8), 1, 0.3, debug_frames);
                    print3d(self.origin - (0, 0, n_offset + 5), "<unknown string>" + (isdefined([[ o_scene ]]->get_state()) ? "<unknown string>" + [[ o_scene ]]->get_state() : "<unknown string>") + "<unknown string>", (0.8, 0.2, 0.8), 1, 0.15, debug_frames);
                }
            } else if (isdefined(self.scriptbundlename)) {
                print3d(self.origin - (0, 0, 15), self.scriptbundlename, (0.8, 0.2, 0.8), 1, 0.3, debug_frames);
            } else {
                break;
            }
            wait(debug_time);
        }
    }

#/
