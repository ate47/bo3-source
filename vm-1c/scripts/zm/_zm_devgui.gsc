#using scripts/codescripts/struct;
#using scripts/shared/aat_shared;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/dev_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_rat;
#using scripts/zm/_util;
#using scripts/zm/_zm;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_placeable_mine;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_turned;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace zm_devgui;

/#

    // Namespace zm_devgui
    // Params 0, eflags: 0x2
    // Checksum 0x4ce78bc, Offset: 0x3e0
    // Size: 0x44
    function autoexec __init__sytem__() {
        system::register("<dev string:x28>", &__init__, &__main__, undefined);
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xe1065e72, Offset: 0x430
    // Size: 0x1e4
    function __init__() {
        setdvar("<dev string:x32>", "<dev string:x40>");
        setdvar("<dev string:x41>", "<dev string:x40>");
        setdvar("<dev string:x52>", "<dev string:x63>");
        setdvar("<dev string:x65>", "<dev string:x63>");
        setdvar("<dev string:x75>", "<dev string:x40>");
        setdvar("<dev string:x85>", "<dev string:x9d>");
        level.devgui_add_weapon = &devgui_add_weapon;
        level.devgui_add_ability = &devgui_add_ability;
        level thread zombie_devgui_think();
        thread zombie_weapon_devgui_think();
        thread function_315fab2d();
        thread devgui_zombie_healthbar();
        thread devgui_test_chart_think();
        if (getdvarstring("<dev string:xa0>") == "<dev string:x40>") {
            setdvar("<dev string:xa0>", "<dev string:xbb>");
        }
        level thread dev::body_customization_devgui(0);
        thread testscriptruntimeerror();
        callback::on_connect(&player_on_connect);
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x61e7fd8f, Offset: 0x620
    // Size: 0x64
    function __main__() {
        level thread zombie_devgui_player_commands();
        level thread zombie_devgui_validation_commands();
        level thread zombie_draw_traversals();
        level thread function_1d21f4f();
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x70c4e3f4, Offset: 0x690
    // Size: 0x8
    function zombie_devgui_player_commands() {
        
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x42a9c1cd, Offset: 0x6a0
    // Size: 0x44
    function player_on_connect() {
        level flag::wait_till("<dev string:xbd>");
        wait 1;
        if (isdefined(self)) {
            zombie_devgui_player_menu(self);
        }
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x15a4f6b3, Offset: 0x6f0
    // Size: 0x4c
    function zombie_devgui_player_menu_clear(playername) {
        rootclear = "<dev string:xd6>" + playername + "<dev string:xf3>";
        adddebugcommand(rootclear);
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xeabbcdc6, Offset: 0x748
    // Size: 0x454
    function zombie_devgui_player_menu(player) {
        zombie_devgui_player_menu_clear(player.name);
        ip1 = player getentitynumber() + 1;
        adddebugcommand("<dev string:xf7>" + player.name + "<dev string:x111>" + ip1 + "<dev string:x115>" + ip1 + "<dev string:x13e>");
        adddebugcommand("<dev string:xf7>" + player.name + "<dev string:x111>" + ip1 + "<dev string:x148>" + ip1 + "<dev string:x173>");
        adddebugcommand("<dev string:xf7>" + player.name + "<dev string:x111>" + ip1 + "<dev string:x180>" + ip1 + "<dev string:x1a9>");
        adddebugcommand("<dev string:xf7>" + player.name + "<dev string:x111>" + ip1 + "<dev string:x1b7>" + ip1 + "<dev string:x1e4>");
        adddebugcommand("<dev string:xf7>" + player.name + "<dev string:x111>" + ip1 + "<dev string:x1ef>" + ip1 + "<dev string:x219>");
        adddebugcommand("<dev string:xf7>" + player.name + "<dev string:x111>" + ip1 + "<dev string:x224>" + ip1 + "<dev string:x24e>");
        adddebugcommand("<dev string:xf7>" + player.name + "<dev string:x111>" + ip1 + "<dev string:x25c>" + ip1 + "<dev string:x27f>");
        adddebugcommand("<dev string:xf7>" + player.name + "<dev string:x111>" + ip1 + "<dev string:x288>" + ip1 + "<dev string:x2ad>");
        adddebugcommand("<dev string:xf7>" + player.name + "<dev string:x111>" + ip1 + "<dev string:x2b8>" + ip1 + "<dev string:x2e1>");
        adddebugcommand("<dev string:xf7>" + player.name + "<dev string:x111>" + ip1 + "<dev string:x2f0>" + ip1 + "<dev string:x31b>");
        adddebugcommand("<dev string:xf7>" + player.name + "<dev string:x111>" + ip1 + "<dev string:x329>" + ip1 + "<dev string:x355>");
        adddebugcommand("<dev string:xf7>" + player.name + "<dev string:x111>" + ip1 + "<dev string:x361>" + ip1 + "<dev string:x38e>");
        if (isdefined(level.var_e26adf8d)) {
            level thread [[ level.var_e26adf8d ]](player, ip1);
        }
        self thread zombie_devgui_player_menu_clear_on_disconnect(player);
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x854843d, Offset: 0xba8
    // Size: 0x54
    function zombie_devgui_player_menu_clear_on_disconnect(player) {
        playername = player.name;
        player waittill(#"disconnect");
        zombie_devgui_player_menu_clear(playername);
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x17eca99d, Offset: 0xc08
    // Size: 0x180
    function zombie_devgui_validation_commands() {
        setdvar("<dev string:x39b>", "<dev string:x40>");
        adddebugcommand("<dev string:x3b5>");
        adddebugcommand("<dev string:x3fd>");
        adddebugcommand("<dev string:x44a>");
        while (true) {
            cmd = getdvarstring("<dev string:x39b>");
            if (cmd != "<dev string:x40>") {
                switch (cmd) {
                case "<dev string:x499>":
                    zombie_spawner_validation();
                    break;
                case "<dev string:x4a1>":
                    if (!isdefined(level.toggle_zone_adjacencies_validation)) {
                        level.toggle_zone_adjacencies_validation = 1;
                    } else {
                        level.toggle_zone_adjacencies_validation = !level.toggle_zone_adjacencies_validation;
                    }
                    thread zone_adjacencies_validation();
                    break;
                case "<dev string:x4aa>":
                    thread zombie_pathing_validation();
                default:
                    break;
                }
                setdvar("<dev string:x39b>", "<dev string:x40>");
            }
            util::wait_network_frame();
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x8833465f, Offset: 0xd90
    // Size: 0x3f4
    function zombie_spawner_validation() {
        level.validation_errors_count = 0;
        if (!isdefined(level.toggle_spawner_validation)) {
            level.toggle_spawner_validation = 1;
            zombie_devgui_open_sesame();
            spawner = level.zombie_spawners[0];
            enemy = undefined;
            foreach (zone in level.zones) {
                foreach (spawn_point in zone.a_loc_types["<dev string:x4b2>"]) {
                    if (!isdefined(zone.a_loc_types["<dev string:x4c2>"]) || zone.a_loc_types["<dev string:x4c2>"].size <= 0) {
                        level.validation_errors_count++;
                        thread drawvalidation(spawn_point.origin, spawn_point.zone_name);
                        println("<dev string:x4d0>" + spawn_point.zone_name);
                        iprintlnbold("<dev string:x4d0>" + spawn_point.zone_name);
                        break;
                    }
                    if (!isdefined(enemy)) {
                        enemy = zombie_utility::spawn_zombie(spawner, spawner.targetname, spawn_point);
                    }
                    node = undefined;
                    spawn_point_origin = spawn_point.origin;
                    if (isdefined(spawn_point.script_string) && spawn_point.script_string != "<dev string:x4f5>") {
                        spawn_point_origin = enemy validate_to_board(spawn_point, spawn_point_origin);
                    }
                    new_spawn_point_origin = getclosestpointonnavmesh(spawn_point_origin, 40, 30);
                    if (!isdefined(new_spawn_point_origin)) {
                        new_spawn_point_origin = getclosestpointonnavmesh(spawn_point_origin, 100, 30);
                        if (!isdefined(new_spawn_point_origin)) {
                            level.validation_errors_count++;
                            thread drawvalidation(spawn_point_origin);
                        }
                    }
                    ispath = enemy validate_to_wait_point(zone, new_spawn_point_origin, spawn_point);
                }
            }
            println("<dev string:x500>" + level.validation_errors_count);
            iprintlnbold("<dev string:x500>" + level.validation_errors_count);
            level.validation_errors_count = undefined;
            return;
        }
        level.toggle_spawner_validation = !level.toggle_spawner_validation;
    }

    // Namespace zm_devgui
    // Params 2, eflags: 0x0
    // Checksum 0x5f62e36b, Offset: 0x1190
    // Size: 0x20c
    function validate_to_board(spawn_point, spawn_point_origin_backup) {
        for (j = 0; j < level.exterior_goals.size; j++) {
            if (isdefined(level.exterior_goals[j].script_string) && level.exterior_goals[j].script_string == spawn_point.script_string) {
                node = level.exterior_goals[j];
                break;
            }
        }
        if (isdefined(node)) {
            ispath = self canpath(spawn_point.origin, node.origin);
            if (!ispath) {
                level.validation_errors_count++;
                thread drawvalidation(spawn_point_origin_backup, undefined, undefined, node.origin);
                println("<dev string:x529>" + spawn_point_origin_backup + "<dev string:x55b>" + spawn_point.targetname);
                iprintlnbold("<dev string:x529>" + spawn_point_origin_backup + "<dev string:x55b>" + spawn_point.targetname);
            }
            nodeforward = anglestoforward(node.angles);
            nodeforward = vectornormalize(nodeforward);
            spawn_point_origin = node.origin + nodeforward * 100;
            return spawn_point_origin;
        }
        return spawn_point_origin_backup;
    }

    // Namespace zm_devgui
    // Params 3, eflags: 0x0
    // Checksum 0xaa60c80d, Offset: 0x13a8
    // Size: 0x21a
    function validate_to_wait_point(zone, new_spawn_point_origin, spawn_point) {
        foreach (loc in zone.a_loc_types["<dev string:x4c2>"]) {
            if (isdefined(loc)) {
                wait_point = loc.origin;
                if (isdefined(wait_point)) {
                    new_wait_point = getclosestpointonnavmesh(wait_point, 40, 30);
                    if (!isdefined(new_wait_point)) {
                        new_wait_point = getclosestpointonnavmesh(wait_point, 100, 30);
                    }
                    if (isdefined(new_spawn_point_origin) && isdefined(new_wait_point)) {
                        ispath = self canpath(new_spawn_point_origin, new_wait_point);
                        if (ispath) {
                            return 1;
                        }
                        level.validation_errors_count++;
                        thread drawvalidation(new_spawn_point_origin, undefined, new_wait_point);
                        println("<dev string:x529>" + new_spawn_point_origin + "<dev string:x574>" + spawn_point.targetname);
                        iprintlnbold("<dev string:x529>" + new_spawn_point_origin + "<dev string:x574>" + spawn_point.targetname);
                        return 0;
                    }
                }
            }
        }
        return 0;
    }

    // Namespace zm_devgui
    // Params 4, eflags: 0x0
    // Checksum 0x7678f58, Offset: 0x15d0
    // Size: 0x310
    function drawvalidation(origin, zone_name, nav_mesh_wait_point, boards_point) {
        if (!isdefined(zone_name)) {
            zone_name = undefined;
        }
        if (!isdefined(nav_mesh_wait_point)) {
            nav_mesh_wait_point = undefined;
        }
        if (!isdefined(boards_point)) {
            boards_point = undefined;
        }
        while (true) {
            if (isdefined(level.toggle_spawner_validation) && level.toggle_spawner_validation) {
                if (!isdefined(origin)) {
                    break;
                }
                if (isdefined(zone_name)) {
                    circle(origin, 32, (1, 0, 0));
                    print3d(origin, "<dev string:x594>" + zone_name, (1, 1, 1), 1, 0.5);
                } else if (isdefined(nav_mesh_wait_point)) {
                    circle(origin, 32, (0, 0, 1));
                    print3d(origin, "<dev string:x5af>" + origin, (1, 1, 1), 1, 0.5);
                    line(origin, nav_mesh_wait_point, (1, 0, 0));
                    circle(nav_mesh_wait_point, 32, (1, 0, 0));
                    print3d(nav_mesh_wait_point, "<dev string:x5d6>" + nav_mesh_wait_point, (1, 1, 1), 1, 0.5);
                } else if (isdefined(boards_point)) {
                    circle(origin, 32, (0, 0, 1));
                    print3d(origin, "<dev string:x5af>" + origin, (1, 1, 1), 1, 0.5);
                    line(origin, boards_point, (1, 0, 0));
                    circle(boards_point, 32, (1, 0, 0));
                    print3d(boards_point, "<dev string:x5e6>" + boards_point, (1, 1, 1), 1, 0.5);
                } else {
                    circle(origin, 32, (0, 0, 1));
                    print3d(origin, "<dev string:x5f5>" + origin, (1, 1, 1), 1, 0.5);
                }
            }
            wait 0.05;
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x5020e431, Offset: 0x18e8
    // Size: 0x260
    function zone_adjacencies_validation() {
        zombie_devgui_open_sesame();
        while (true) {
            if (isdefined(level.toggle_zone_adjacencies_validation) && level.toggle_zone_adjacencies_validation) {
                if (!isdefined(getplayers()[0].zone_name)) {
                    wait 0.05;
                    continue;
                }
                str_zone = getplayers()[0].zone_name;
                keys = getarraykeys(level.zones);
                offset = 0;
                foreach (key in keys) {
                    if (key === str_zone) {
                        draw_zone_adjacencies_validation(level.zones[key], 2, key);
                        continue;
                    }
                    if (isdefined(level.zones[str_zone].adjacent_zones[key])) {
                        if (level.zones[str_zone].adjacent_zones[key].is_connected) {
                            offset += 10;
                            draw_zone_adjacencies_validation(level.zones[key], 1, key, level.zones[str_zone], offset);
                        } else {
                            draw_zone_adjacencies_validation(level.zones[key], 0, key);
                        }
                        continue;
                    }
                    draw_zone_adjacencies_validation(level.zones[key], 0, key);
                }
            }
            wait 0.05;
        }
    }

    // Namespace zm_devgui
    // Params 5, eflags: 0x0
    // Checksum 0x3101df27, Offset: 0x1b50
    // Size: 0x244
    function draw_zone_adjacencies_validation(zone, status, name, current_zone, offset) {
        if (!isdefined(current_zone)) {
            current_zone = undefined;
        }
        if (!isdefined(offset)) {
            offset = 0;
        }
        if (!isdefined(zone.volumes[0])) {
            return;
        }
        if (status == 2) {
            circle(zone.volumes[0].origin, 30, (0, 1, 0));
            print3d(zone.volumes[0].origin, name, (0, 1, 0), 1, 0.5);
            return;
        }
        if (status == 1) {
            circle(zone.volumes[0].origin, 30, (0, 0, 1));
            print3d(zone.volumes[0].origin, name, (0, 0, 1), 1, 0.5);
            print3d(current_zone.volumes[0].origin + (0, 20, offset * -1), name, (0, 0, 1), 1, 0.5);
            return;
        }
        circle(zone.volumes[0].origin, 30, (1, 0, 0));
        print3d(zone.volumes[0].origin, name, (1, 0, 0), 1, 0.5);
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xcac8d0e0, Offset: 0x1da0
    // Size: 0x150
    function zombie_pathing_validation() {
        if (!isdefined(level.zombie_spawners[0])) {
            return;
        }
        if (!isdefined(level.zombie_pathing_validation)) {
            level.zombie_pathing_validation = 1;
        }
        zombie_devgui_open_sesame();
        setdvar("<dev string:x60c>", 0);
        zombie_devgui_goto_round(20);
        wait 2;
        spawner = level.zombie_spawners[0];
        slums_station = (808, -1856, 544);
        enemy = zombie_utility::spawn_zombie(spawner, spawner.targetname);
        wait 1;
        while (isdefined(enemy) && enemy.completed_emerging_into_playable_area !== 1) {
            wait 0.05;
        }
        if (isdefined(enemy)) {
            enemy forceteleport(slums_station);
            enemy.b_ignore_cleanup = 1;
        }
    }

    // Namespace zm_devgui
    // Params 3, eflags: 0x0
    // Checksum 0xc72218ba, Offset: 0x1ef8
    // Size: 0xec
    function function_300fe60f(weapon_name, up, root) {
        rootslash = "<dev string:x40>";
        if (isdefined(root) && root.size) {
            rootslash = root + "<dev string:x61f>";
        }
        uppath = "<dev string:x61f>" + up;
        if (up.size < 1) {
            uppath = "<dev string:x40>";
        }
        cmd = "<dev string:x621>" + rootslash + weapon_name + uppath + "<dev string:x643>" + weapon_name + "<dev string:xf3>";
        adddebugcommand(cmd);
    }

    // Namespace zm_devgui
    // Params 3, eflags: 0x0
    // Checksum 0x5055821b, Offset: 0x1ff0
    // Size: 0xec
    function devgui_add_weapon_entry(weapon_name, up, root) {
        rootslash = "<dev string:x40>";
        if (isdefined(root) && root.size) {
            rootslash = root + "<dev string:x61f>";
        }
        uppath = "<dev string:x61f>" + up;
        if (up.size < 1) {
            uppath = "<dev string:x40>";
        }
        cmd = "<dev string:x66d>" + rootslash + weapon_name + uppath + "<dev string:x685>" + weapon_name + "<dev string:xf3>";
        adddebugcommand(cmd);
    }

    // Namespace zm_devgui
    // Params 3, eflags: 0x0
    // Checksum 0xfb274287, Offset: 0x20e8
    // Size: 0x3c
    function function_1567189b(weapon_name, up, root) {
        devgui_add_weapon_entry(weapon_name, up, root);
    }

    // Namespace zm_devgui
    // Params 7, eflags: 0x0
    // Checksum 0x19d2aed5, Offset: 0x2130
    // Size: 0x13c
    function devgui_add_weapon(weapon, upgrade, hint, cost, weaponvo, weaponvoresp, ammo_cost) {
        function_300fe60f(weapon.name, "<dev string:x40>", "<dev string:x40>");
        if (zm_utility::is_offhand_weapon(weapon) && !zm_utility::is_melee_weapon(weapon)) {
            return;
        }
        if (!isdefined(level.devgui_weapons_added)) {
            level.devgui_weapons_added = 0;
        }
        level.devgui_weapons_added++;
        if (zm_utility::is_melee_weapon(weapon)) {
            function_1567189b(weapon.name, "<dev string:x40>", "<dev string:x69f>");
            return;
        }
        function_1567189b(weapon.name, "<dev string:x40>", "<dev string:x40>");
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x8b84ba27, Offset: 0x2278
    // Size: 0x300
    function function_315fab2d() {
        level.zombie_devgui_gun = getdvarstring("<dev string:x6a5>");
        for (;;) {
            wait 0.1;
            cmd = getdvarstring("<dev string:x6a5>");
            if (isdefined(cmd) && cmd.size > 0) {
                level.zombie_devgui_gun = cmd;
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
                }
                setdvar("<dev string:x6a5>", "<dev string:x40>");
            }
            wait 0.1;
            cmd = getdvarstring("<dev string:x6bf>");
            if (isdefined(cmd) && cmd.size > 0) {
                level.zombie_devgui_gun = cmd;
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
                }
                setdvar("<dev string:x6bf>", "<dev string:x40>");
            }
            wait 0.1;
            cmd = getdvarstring("<dev string:x6d9>");
            if (isdefined(cmd) && cmd.size > 0) {
                level.zombie_devgui_gun = cmd;
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
                }
                setdvar("<dev string:x6d9>", "<dev string:x40>");
            }
            wait 0.1;
            cmd = getdvarstring("<dev string:x6f3>");
            if (isdefined(cmd) && cmd.size > 0) {
                level.zombie_devgui_gun = cmd;
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread zombie_devgui_weapon_give(level.zombie_devgui_gun);
                }
                setdvar("<dev string:x6f3>", "<dev string:x40>");
            }
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x22c61e2a, Offset: 0x2580
    // Size: 0x1a0
    function zombie_weapon_devgui_think() {
        level.zombie_devgui_gun = getdvarstring("<dev string:x70d>");
        level.var_a77e5044 = getdvarstring("<dev string:x71f>");
        for (;;) {
            wait 0.25;
            cmd = getdvarstring("<dev string:x70d>");
            if (isdefined(cmd) && cmd.size > 0) {
                level.zombie_devgui_gun = cmd;
                array::thread_all(getplayers(), &zombie_devgui_weapon_give, level.zombie_devgui_gun);
                setdvar("<dev string:x70d>", "<dev string:x40>");
            }
            wait 0.25;
            att = getdvarstring("<dev string:x71f>");
            if (isdefined(att) && att.size > 0) {
                level.var_a77e5044 = att;
                array::thread_all(getplayers(), &function_4e8e32dc, level.var_a77e5044);
                setdvar("<dev string:x71f>", "<dev string:x40>");
            }
        }
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xb9d8da6d, Offset: 0x2728
    // Size: 0x64
    function zombie_devgui_weapon_give(weapon_name) {
        weapon = getweapon(weapon_name);
        self zm_weapons::weapon_give(weapon, zm_weapons::is_weapon_upgraded(weapon), 0);
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x7ef518a7, Offset: 0x2798
    // Size: 0x94
    function function_4e8e32dc(attachment) {
        weapon = self getcurrentweapon();
        weapon = getweapon(weapon.rootweapon.name, attachment);
        self zm_weapons::weapon_give(weapon, zm_weapons::is_weapon_upgraded(weapon), 0);
    }

    // Namespace zm_devgui
    // Params 5, eflags: 0x0
    // Checksum 0x48bbe3e2, Offset: 0x2838
    // Size: 0x164
    function devgui_add_ability(name, upgrade_active_func, stat_name, stat_desired_value, game_end_reset_if_not_achieved) {
        online_game = sessionmodeisonlinegame();
        if (!online_game) {
            return;
        }
        if (!(isdefined(level.devgui_watch_abilities) && level.devgui_watch_abilities)) {
            cmd = "<dev string:x734>";
            adddebugcommand(cmd);
            cmd = "<dev string:x78e>";
            adddebugcommand(cmd);
            level thread zombie_ability_devgui_think();
            level.devgui_watch_abilities = 1;
        }
        cmd = "<dev string:x7e6>" + name + "<dev string:x808>" + name + "<dev string:xf3>";
        adddebugcommand(cmd);
        cmd = "<dev string:x82b>" + name + "<dev string:x852>" + name + "<dev string:xf3>";
        adddebugcommand(cmd);
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x2f6f8013, Offset: 0x29a8
    // Size: 0xd2
    function zombie_devgui_ability_give(name) {
        var_3ed63b1c = level.var_d830ee5f[name];
        if (isdefined(var_3ed63b1c)) {
            for (i = 0; i < var_3ed63b1c.var_e45eb34e.size; i++) {
                stat_name = var_3ed63b1c.var_e45eb34e[i];
                stat_value = var_3ed63b1c.var_3f39db75[i];
                self zm_stats::set_global_stat(stat_name, stat_value);
                self.var_8d6e7587 = 1;
            }
        }
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xe2044081, Offset: 0x2a88
    // Size: 0xc2
    function zombie_devgui_ability_take(name) {
        var_3ed63b1c = level.var_d830ee5f[name];
        if (isdefined(var_3ed63b1c)) {
            for (i = 0; i < var_3ed63b1c.var_e45eb34e.size; i++) {
                stat_name = var_3ed63b1c.var_e45eb34e[i];
                stat_value = 0;
                self zm_stats::set_global_stat(stat_name, stat_value);
                self.var_8d6e7587 = 1;
            }
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xb96a3e57, Offset: 0x2b58
    // Size: 0x1c8
    function zombie_ability_devgui_think() {
        level.zombie_devgui_give_ability = getdvarstring("<dev string:x875>");
        level.zombie_devgui_take_ability = getdvarstring("<dev string:x890>");
        for (;;) {
            wait 0.25;
            cmd = getdvarstring("<dev string:x875>");
            if (!isdefined(level.zombie_devgui_give_ability) || level.zombie_devgui_give_ability != cmd) {
                if (cmd == "<dev string:x8ab>") {
                    level flag::set("<dev string:x8b4>");
                } else if (cmd == "<dev string:x8c7>") {
                    level flag::clear("<dev string:x8b4>");
                } else {
                    level.zombie_devgui_give_ability = cmd;
                    array::thread_all(getplayers(), &zombie_devgui_ability_give, level.zombie_devgui_give_ability);
                }
            }
            wait 0.25;
            cmd = getdvarstring("<dev string:x890>");
            if (!isdefined(level.zombie_devgui_take_ability) || level.zombie_devgui_take_ability != cmd) {
                level.zombie_devgui_take_ability = cmd;
                array::thread_all(getplayers(), &zombie_devgui_ability_take, level.zombie_devgui_take_ability);
            }
        }
    }

    // Namespace zm_devgui
    // Params 2, eflags: 0x0
    // Checksum 0x2ebcc66c, Offset: 0x2d28
    // Size: 0xfc
    function zombie_healthbar(pos, dsquared) {
        if (distancesquared(pos, self.origin) > dsquared) {
            return;
        }
        rate = 1;
        if (isdefined(self.maxhealth)) {
            rate = self.health / self.maxhealth;
        }
        color = (1 - rate, rate, 0);
        text = "<dev string:x40>" + int(self.health);
        print3d(self.origin + (0, 0, 0), text, color, 1, 0.5, 1);
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xd6449724, Offset: 0x2e30
    // Size: 0x138
    function devgui_zombie_healthbar() {
        while (true) {
            if (getdvarint("<dev string:x8cf>") == 1) {
                lp = getplayers()[0];
                zombies = getaispeciesarray("<dev string:x8e5>", "<dev string:x8e5>");
                if (isdefined(zombies)) {
                    foreach (zombie in zombies) {
                        zombie zombie_healthbar(lp.origin, 360000);
                    }
                }
            }
            wait 0.05;
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x6a616da9, Offset: 0x2f70
    // Size: 0x8e
    function zombie_devgui_watch_input() {
        level flag::wait_till("<dev string:xbd>");
        wait 1;
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            players[i] thread watch_debug_input();
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x1e1e5523, Offset: 0x3008
    // Size: 0x44
    function damage_player() {
        self disableinvulnerability();
        self dodamage(self.health / 2, self.origin);
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xdea01d12, Offset: 0x3058
    // Size: 0x9c
    function kill_player() {
        self disableinvulnerability();
        death_from = (randomfloatrange(-20, 20), randomfloatrange(-20, 20), randomfloatrange(-20, 20));
        self dodamage(self.health + 666, self.origin + death_from);
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x750309ff, Offset: 0x3100
    // Size: 0x274
    function force_drink() {
        wait 0.01;
        lean = self allowlean(0);
        ads = self allowads(0);
        sprint = self allowsprint(0);
        crouch = self allowcrouch(1);
        prone = self allowprone(0);
        melee = self allowmelee(0);
        self zm_utility::increment_is_drinking();
        orgweapon = self getcurrentweapon();
        build_weapon = getweapon("<dev string:x8e9>");
        self giveweapon(build_weapon);
        self switchtoweapon(build_weapon);
        self.build_time = self.usetime;
        self.var_29dc61fe = gettime();
        wait 2;
        self zm_weapons::switch_back_primary_weapon(orgweapon);
        self takeweapon(build_weapon);
        if (isdefined(self.is_drinking) && self.is_drinking) {
            self zm_utility::decrement_is_drinking();
        }
        self allowlean(lean);
        self allowads(ads);
        self allowsprint(sprint);
        self allowprone(prone);
        self allowcrouch(crouch);
        self allowmelee(melee);
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x934a27f1, Offset: 0x3380
    // Size: 0x1c
    function zombie_devgui_dpad_none() {
        self thread watch_debug_input();
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x157772c6, Offset: 0x33a8
    // Size: 0x2c
    function zombie_devgui_dpad_death() {
        self thread watch_debug_input(&kill_player);
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xfbde5089, Offset: 0x33e0
    // Size: 0x2c
    function zombie_devgui_dpad_damage() {
        self thread watch_debug_input(&damage_player);
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xdf9f2bc2, Offset: 0x3418
    // Size: 0x2c
    function zombie_devgui_dpad_changeweapon() {
        self thread watch_debug_input(&force_drink);
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x3f9f83dd, Offset: 0x3450
    // Size: 0xb0
    function watch_debug_input(callback) {
        self endon(#"disconnect");
        self notify(#"watch_debug_input");
        self endon(#"watch_debug_input");
        level.devgui_dpad_watch = 0;
        if (isdefined(callback)) {
            level.devgui_dpad_watch = 1;
            for (;;) {
                if (self actionslottwobuttonpressed()) {
                    self thread [[ callback ]]();
                    while (self actionslottwobuttonpressed()) {
                        wait 0.05;
                    }
                }
                wait 0.05;
            }
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x6fd74e0, Offset: 0x3508
    // Size: 0x2220
    function zombie_devgui_think() {
        level notify(#"zombie_devgui_think");
        level endon(#"zombie_devgui_think");
        for (;;) {
            cmd = getdvarstring("<dev string:x32>");
            switch (cmd) {
            case "<dev string:x8f8>":
                players = getplayers();
                array::thread_all(players, &zombie_devgui_give_money);
                break;
            case "<dev string:x8fe>":
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread zombie_devgui_give_money();
                }
                break;
            case "<dev string:x90c>":
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread zombie_devgui_give_money();
                }
                break;
            case "<dev string:x91a>":
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread zombie_devgui_give_money();
                }
                break;
            case "<dev string:x928>":
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread zombie_devgui_give_money();
                }
                break;
            case "<dev string:x936>":
                players = getplayers();
                array::thread_all(players, &zombie_devgui_take_money);
                break;
            case "<dev string:x940>":
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread zombie_devgui_take_money();
                }
                break;
            case "<dev string:x952>":
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread zombie_devgui_take_money();
                }
                break;
            case "<dev string:x964>":
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread zombie_devgui_take_money();
                }
                break;
            case "<dev string:x976>":
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread zombie_devgui_take_money();
                }
                break;
            case "<dev string:x988>":
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread zombie_devgui_give_xp(1000);
                }
                break;
            case "<dev string:x998>":
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread zombie_devgui_give_xp(1000);
                }
                break;
            case "<dev string:x9a8>":
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread zombie_devgui_give_xp(1000);
                }
                break;
            case "<dev string:x9b8>":
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread zombie_devgui_give_xp(1000);
                }
                break;
            case "<dev string:x9c8>":
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread zombie_devgui_give_xp(10000);
                }
                break;
            case "<dev string:x9d9>":
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread zombie_devgui_give_xp(10000);
                }
                break;
            case "<dev string:x9ea>":
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread zombie_devgui_give_xp(10000);
                }
                break;
            case "<dev string:x9fb>":
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread zombie_devgui_give_xp(10000);
                }
                break;
            case "<dev string:xa0c>":
                array::thread_all(getplayers(), &zombie_devgui_give_health);
                break;
            case "<dev string:xa13>":
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread zombie_devgui_give_health();
                }
                break;
            case "<dev string:xa22>":
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread zombie_devgui_give_health();
                }
                break;
            case "<dev string:xa31>":
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread zombie_devgui_give_health();
                }
                break;
            case "<dev string:xa40>":
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread zombie_devgui_give_health();
                }
                break;
            case "<dev string:xa4f>":
                array::thread_all(getplayers(), &zombie_devgui_low_health);
                break;
            case "<dev string:xa59>":
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread zombie_devgui_low_health();
                }
                break;
            case "<dev string:xa6b>":
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread zombie_devgui_low_health();
                }
                break;
            case "<dev string:xa7d>":
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread zombie_devgui_low_health();
                }
                break;
            case "<dev string:xa8f>":
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread zombie_devgui_low_health();
                }
                break;
            case "<dev string:xaa1>":
                array::thread_all(getplayers(), &zombie_devgui_toggle_ammo);
                break;
            case "<dev string:xaa6>":
                array::thread_all(getplayers(), &zombie_devgui_toggle_ignore);
                break;
            case "<dev string:xaad>":
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread zombie_devgui_toggle_ignore();
                }
                break;
            case "<dev string:xabc>":
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread zombie_devgui_toggle_ignore();
                }
                break;
            case "<dev string:xacb>":
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread zombie_devgui_toggle_ignore();
                }
                break;
            case "<dev string:xada>":
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread zombie_devgui_toggle_ignore();
                }
                break;
            case "<dev string:xae9>":
                zombie_devgui_invulnerable(undefined, 1);
                break;
            case "<dev string:xaf2>":
                zombie_devgui_invulnerable(undefined, 0);
                break;
            case "<dev string:xafc>":
                zombie_devgui_invulnerable(0, 1);
                break;
            case "<dev string:xb0d>":
                zombie_devgui_invulnerable(0, 0);
                break;
            case "<dev string:xb1f>":
                zombie_devgui_invulnerable(1, 1);
                break;
            case "<dev string:xb30>":
                zombie_devgui_invulnerable(1, 0);
                break;
            case "<dev string:xb42>":
                zombie_devgui_invulnerable(2, 1);
                break;
            case "<dev string:xb53>":
                zombie_devgui_invulnerable(2, 0);
                break;
            case "<dev string:xb65>":
                zombie_devgui_invulnerable(3, 1);
                break;
            case "<dev string:xb76>":
                zombie_devgui_invulnerable(3, 0);
                break;
            case "<dev string:xb88>":
                array::thread_all(getplayers(), &zombie_devgui_revive);
                break;
            case "<dev string:xb93>":
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread zombie_devgui_revive();
                }
                break;
            case "<dev string:xba2>":
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread zombie_devgui_revive();
                }
                break;
            case "<dev string:xbb1>":
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread zombie_devgui_revive();
                }
                break;
            case "<dev string:xbc0>":
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread zombie_devgui_revive();
                }
                break;
            case "<dev string:xbcf>":
                players = getplayers();
                if (players.size >= 1) {
                    players[0] thread zombie_devgui_kill();
                }
                break;
            case "<dev string:xbdc>":
                players = getplayers();
                if (players.size >= 2) {
                    players[1] thread zombie_devgui_kill();
                }
                break;
            case "<dev string:xbe9>":
                players = getplayers();
                if (players.size >= 3) {
                    players[2] thread zombie_devgui_kill();
                }
                break;
            case "<dev string:xbf6>":
                players = getplayers();
                if (players.size >= 4) {
                    players[3] thread zombie_devgui_kill();
                }
                break;
            case "<dev string:xc03>":
                player = util::gethostplayer();
                team = player.team;
                function_ed94fcf9(team);
                break;
            case "<dev string:xc16>":
                level.solo_lives_given = 0;
            case "<dev string:xca5>":
            case "<dev string:xd1b>":
            case "<dev string:xc6a>":
            case "<dev string:xcdb>":
            case "<dev string:xd06>":
            case "<dev string:xcc7>":
            case "<dev string:xd30>":
            case "<dev string:xc7d>":
            case "<dev string:xc40>":
            case "<dev string:xd46>":
            case "<dev string:xced>":
            case "<dev string:xc55>":
            case "<dev string:xc92>":
            case "<dev string:xc2c>":
                zombie_devgui_give_perk(cmd);
                break;
            case "<dev string:xd62>":
                function_af69dfbe(cmd);
                break;
            case "<dev string:xd75>":
                function_3df1388a(cmd);
                break;
            case "<dev string:xd89>":
                function_f976401d(cmd);
                break;
            case "<dev string:xd9c>":
                function_a888b17c(cmd);
                break;
            case "<dev string:xdac>":
                function_7743668b(cmd);
                break;
            case "<dev string:xdc1>":
                function_7d8af9ea(cmd);
                break;
            case "<dev string:xdd4>":
                function_7d8af9ea(cmd);
                break;
            case "<dev string:xde4>":
                zombie_devgui_take_perks(cmd);
                break;
            case "<dev string:xdf1>":
                zombie_devgui_turn_player();
                break;
            case "<dev string:xdfc>":
                zombie_devgui_turn_player(0);
                break;
            case "<dev string:xe0f>":
                zombie_devgui_turn_player(1);
                break;
            case "<dev string:xe22>":
                zombie_devgui_turn_player(2);
                break;
            case "<dev string:xe35>":
                zombie_devgui_turn_player(3);
                break;
            case "<dev string:xe48>":
                function_be875f57(0);
                break;
            case "<dev string:xe5b>":
                function_be875f57(1);
                break;
            case "<dev string:xe6e>":
                function_be875f57(2);
                break;
            case "<dev string:xe81>":
                function_be875f57(3);
                break;
            case "<dev string:xee5>":
            case "<dev string:xeb2>":
            case "<dev string:xe99>":
            case "<dev string:xf3a>":
            case "<dev string:xf29>":
            case "<dev string:xedd>":
            case "<dev string:xe94>":
            case "<dev string:xf4f>":
            case "<dev string:xef5>":
            case "<dev string:xeef>":
            case "<dev string:xf44>":
            case "<dev string:xed0>":
            case "<dev string:xf03>":
            case "<dev string:xf17>":
            case "<dev string:xebc>":
            case "<dev string:xea4>":
            case "<dev string:xec6>":
                zombie_devgui_give_powerup(cmd, 1);
                break;
            case "<dev string:xf87>":
            case "<dev string:xfd3>":
            case "<dev string:xfa5>":
            case "<dev string:x1055>":
            case "<dev string:xf74>":
            case "<dev string:xf96>":
            case "<dev string:x1019>":
            case "<dev string:x1000>":
            case "<dev string:xfb4>":
            case "<dev string:xf5a>":
            case "<dev string:xfc6>":
            case "<dev string:x1065>":
            case "<dev string:x1030>":
            case "<dev string:x1046>":
            case "<dev string:xf64>":
            case "<dev string:xfe2>":
            case "<dev string:xfed>":
                zombie_devgui_give_powerup(getsubstr(cmd, 5), 0);
                break;
            case "<dev string:x1075>":
                zombie_devgui_goto_round(getdvarint("<dev string:x52>"));
                break;
            case "<dev string:x107b>":
                zombie_devgui_goto_round(level.round_number + 1);
                break;
            case "<dev string:x1086>":
                zombie_devgui_goto_round(level.round_number - 1);
                break;
            case "<dev string:x1091>":
                array::thread_all(getplayers(), &function_4619dfa7);
                break;
            case "<dev string:x109c>":
                if (isdefined(level.chest_accessed)) {
                    level notify(#"devgui_chest_end_monitor");
                    level.chest_accessed = 100;
                }
                break;
            case "<dev string:x10a7>":
                if (isdefined(level.chest_accessed)) {
                    level thread zombie_devgui_chest_never_move();
                }
                break;
            case "<dev string:x10b8>":
                if (isdefined(level.zombie_weapons[getweapon(getdvarstring("<dev string:x41>"))])) {
                }
                break;
            case "<dev string:x10be>":
                array::thread_all(getplayers(), &zombie_devgui_preserve_turbines);
                break;
            case "<dev string:x10d0>":
                array::thread_all(getplayers(), &zombie_devgui_equipment_stays_healthy);
                break;
            case "<dev string:x10e2>":
                array::thread_all(getplayers(), &zombie_devgui_disown_equipment);
                break;
            case "<dev string:x10f3>":
                array::thread_all(getplayers(), &zombie_devgui_give_placeable_mine, getweapon("<dev string:x1102>"));
                break;
            case "<dev string:x110b>":
                array::thread_all(getplayers(), &zombie_devgui_give_placeable_mine, getweapon("<dev string:x1120>"));
                break;
            case "<dev string:x112e>":
                array::thread_all(getplayers(), &zombie_devgui_give_frags);
                break;
            case "<dev string:x1139>":
                array::thread_all(getplayers(), &zombie_devgui_give_sticky);
                break;
            case "<dev string:x1145>":
                array::thread_all(getplayers(), &zombie_devgui_give_monkey);
                break;
            case "<dev string:x1151>":
                array::thread_all(getplayers(), &zombie_devgui_give_bhb);
                break;
            case "<dev string:x115a>":
                array::thread_all(getplayers(), &zombie_devgui_give_qed);
                break;
            case "<dev string:x1167>":
                array::thread_all(getplayers(), &zombie_devgui_give_dolls);
                break;
            case "<dev string:x1172>":
                array::thread_all(getplayers(), &zombie_devgui_give_emp_bomb);
                break;
            case "<dev string:x1180>":
                zombie_devgui_dog_round(getdvarint("<dev string:x65>"));
                break;
            case "<dev string:x118a>":
                zombie_devgui_dog_round_skip();
                break;
            case "<dev string:x1199>":
                zombie_devgui_dump_zombie_vars();
                break;
            case "<dev string:x11a9>":
                zombie_devgui_pack_current_weapon();
                break;
            case "<dev string:x11bd>":
                function_9e5bfd9d();
                break;
            case "<dev string:x11cc>":
                function_435ea700();
                break;
            case "<dev string:x11e2>":
                function_525facc6();
                break;
            case "<dev string:x11f2>":
                function_935f6cc2();
                break;
            case "<dev string:x1203>":
                zombie_devgui_repack_current_weapon();
                break;
            case "<dev string:x1219>":
                zombie_devgui_unpack_current_weapon();
                break;
            case "<dev string:x122f>":
                function_2306f73c();
                break;
            case "<dev string:x1246>":
                function_5da1c3cd();
                break;
            case "<dev string:x1264>":
                function_6afc4c2f();
                break;
            case "<dev string:x127c>":
                function_9b4ea903();
                break;
            case "<dev string:x1295>":
                function_4d2e8278();
                break;
            case "<dev string:x12aa>":
                function_ce561484();
                break;
            case "<dev string:x12c0>":
                zombie_devgui_reopt_current_weapon();
                break;
            case "<dev string:x12d5>":
                zombie_devgui_take_weapons(1);
                break;
            case "<dev string:x12ee>":
                zombie_devgui_take_weapons(0);
                break;
            case "<dev string:x12fe>":
                zombie_devgui_take_weapon();
                break;
            case "<dev string:x1312>":
                level flag::set("<dev string:x1312>");
                level clientfield::set("<dev string:x131b>", 0);
                power_trigs = getentarray("<dev string:x132b>", "<dev string:x133b>");
                foreach (trig in power_trigs) {
                    if (isdefined(trig.script_int)) {
                        level flag::set("<dev string:x1312>" + trig.script_int);
                        level clientfield::set("<dev string:x131b>", trig.script_int);
                    }
                }
                break;
            case "<dev string:x1346>":
                level flag::clear("<dev string:x1312>");
                level clientfield::set("<dev string:x1350>", 0);
                power_trigs = getentarray("<dev string:x132b>", "<dev string:x133b>");
                foreach (trig in power_trigs) {
                    if (isdefined(trig.script_int)) {
                        level flag::clear("<dev string:x1312>" + trig.script_int);
                        level clientfield::set("<dev string:x1350>", trig.script_int);
                    }
                }
                break;
            case "<dev string:x1361>":
                array::thread_all(getplayers(), &zombie_devgui_dpad_none);
                break;
            case "<dev string:x1372>":
                array::thread_all(getplayers(), &zombie_devgui_dpad_damage);
                break;
            case "<dev string:x1385>":
                array::thread_all(getplayers(), &zombie_devgui_dpad_death);
                break;
            case "<dev string:x1396>":
                array::thread_all(getplayers(), &zombie_devgui_dpad_changeweapon);
                break;
            case "<dev string:x13a8>":
                zombie_devgui_director_easy();
                break;
            case "<dev string:x13b6>":
                zombie_devgui_open_sesame();
                break;
            case "<dev string:x13c2>":
                zombie_devgui_allow_fog();
                break;
            case "<dev string:x13cc>":
                zombie_devgui_disable_kill_thread_toggle();
                break;
            case "<dev string:x13e7>":
                zombie_devgui_check_kill_thread_every_frame_toggle();
                break;
            case "<dev string:x140c>":
                zombie_devgui_kill_thread_test_mode_toggle();
                break;
            case "<dev string:x1429>":
                level notify(#"zombie_failsafe_debug_flush");
                break;
            case "<dev string:x1445>":
                level thread rat::derriesezombiespawnnavmeshtest(0, 0);
                break;
            case "<dev string:x1451>":
                devgui_zombie_spawn();
                break;
            case "<dev string:x1457>":
                devgui_all_spawn();
                break;
            case "<dev string:x1461>":
                devgui_make_crawler();
                break;
            case "<dev string:x1469>":
                devgui_toggle_show_spawn_locations();
                break;
            case "<dev string:x1485>":
                devgui_toggle_show_exterior_goals();
                break;
            case "<dev string:x14a0>":
                zombie_devgui_draw_traversals();
                break;
            case "<dev string:x14b0>":
                function_364ed1b9();
                break;
            case "<dev string:x14c0>":
                array::thread_all(getplayers(), &devgui_debug_hud);
                break;
            case "<dev string:x14ca>":
                zombie_devgui_keyline_always();
                break;
            case "<dev string:x14d9>":
                function_13d8ea87();
                break;
            case "<dev string:x14e6>":
                thread function_1acc8e35();
                break;
            case "<dev string:x14fb>":
                function_eec2d58b();
                break;
            case "<dev string:x40>":
                break;
            default:
                if (isdefined(level.custom_devgui)) {
                    if (isarray(level.custom_devgui)) {
                        foreach (devgui in level.custom_devgui) {
                            b_result = [[ devgui ]](cmd);
                            if (isdefined(b_result) && b_result) {
                                break;
                            }
                        }
                    } else {
                        [[ level.custom_devgui ]](cmd);
                    }
                }
                break;
            }
            setdvar("<dev string:x32>", "<dev string:x40>");
            wait 0.5;
        }
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x8076baf9, Offset: 0x5730
    // Size: 0x13a
    function add_custom_devgui_callback(callback) {
        if (isdefined(level.custom_devgui)) {
            if (!isarray(level.custom_devgui)) {
                cdgui = level.custom_devgui;
                level.custom_devgui = [];
                if (!isdefined(level.custom_devgui)) {
                    level.custom_devgui = [];
                } else if (!isarray(level.custom_devgui)) {
                    level.custom_devgui = array(level.custom_devgui);
                }
                level.custom_devgui[level.custom_devgui.size] = cdgui;
            }
        } else {
            level.custom_devgui = [];
        }
        if (!isdefined(level.custom_devgui)) {
            level.custom_devgui = [];
        } else if (!isarray(level.custom_devgui)) {
            level.custom_devgui = array(level.custom_devgui);
        }
        level.custom_devgui[level.custom_devgui.size] = callback;
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x833924a5, Offset: 0x5878
    // Size: 0xb4
    function devgui_all_spawn() {
        player = util::gethostplayer();
        function_ed94fcf9(player.team);
        wait 0.1;
        function_ed94fcf9(player.team);
        wait 0.1;
        function_ed94fcf9(player.team);
        wait 0.1;
        zombie_devgui_goto_round(8);
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xddeffc9, Offset: 0x5938
    // Size: 0x34
    function devgui_toggle_show_spawn_locations() {
        if (!isdefined(level.toggle_show_spawn_locations)) {
            level.toggle_show_spawn_locations = 1;
            return;
        }
        level.toggle_show_spawn_locations = !level.toggle_show_spawn_locations;
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xb4ee3e52, Offset: 0x5978
    // Size: 0x34
    function devgui_toggle_show_exterior_goals() {
        if (!isdefined(level.toggle_show_exterior_goals)) {
            level.toggle_show_exterior_goals = 1;
            return;
        }
        level.toggle_show_exterior_goals = !level.toggle_show_exterior_goals;
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x809796ad, Offset: 0x59b8
    // Size: 0x1fa
    function devgui_zombie_spawn() {
        player = getplayers()[0];
        spawnername = undefined;
        spawnername = "<dev string:x150f>";
        direction = player getplayerangles();
        direction_vec = anglestoforward(direction);
        eye = player geteye();
        scale = 8000;
        direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
        trace = bullettrace(eye, eye + direction_vec, 0, undefined);
        guy = undefined;
        spawners = getentarray(spawnername, "<dev string:x151e>");
        spawner = spawners[0];
        guy = zombie_utility::spawn_zombie(spawner);
        if (isdefined(guy)) {
            guy.script_string = "<dev string:x4f5>";
            wait 0.5;
            guy forceteleport(trace["<dev string:x1530>"], player.angles + (0, 180, 0));
        }
        return guy;
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x5b569de, Offset: 0x5bc0
    // Size: 0x1ea
    function devgui_make_crawler() {
        zombies = zombie_utility::get_round_enemy_array();
        foreach (zombie in zombies) {
            gib_style = [];
            gib_style[gib_style.size] = "<dev string:x1539>";
            gib_style[gib_style.size] = "<dev string:x1541>";
            gib_style[gib_style.size] = "<dev string:x154b>";
            gib_style = zombie_death::randomize_array(gib_style);
            zombie.a.gib_ref = gib_style[0];
            zombie.missinglegs = 1;
            zombie allowedstances("<dev string:x1554>");
            zombie setphysparams(15, 0, 24);
            zombie allowpitchangle(1);
            zombie setpitchorient();
            health = zombie.health;
            health *= 0.1;
            zombie thread zombie_death::do_gib();
        }
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xa122d596, Offset: 0x5db8
    // Size: 0x24c
    function function_ed94fcf9(team) {
        player = util::gethostplayer();
        direction = player getplayerangles();
        direction_vec = anglestoforward(direction);
        eye = player geteye();
        scale = 8000;
        direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
        trace = bullettrace(eye, eye + direction_vec, 0, undefined);
        direction_vec = player.origin - trace["<dev string:x1530>"];
        direction = vectortoangles(direction_vec);
        bot = addtestclient();
        if (!isdefined(bot)) {
            println("<dev string:x155b>");
            return;
        }
        bot.pers["<dev string:x1575>"] = 1;
        bot.equipment_enabled = 0;
        bot demo::reset_actor_bookmark_kill_times();
        bot.team = "<dev string:x157b>";
        bot.var_204b58db = bot getentitynumber();
        yaw = direction[1];
        bot thread function_84ca773c(trace["<dev string:x1530>"], yaw);
    }

    // Namespace zm_devgui
    // Params 2, eflags: 0x0
    // Checksum 0x146c070, Offset: 0x6010
    // Size: 0x80
    function function_84ca773c(origin, yaw) {
        self endon(#"disconnect");
        for (;;) {
            self waittill(#"spawned_player");
            self setorigin(origin);
            angles = (0, yaw, 0);
            self setplayerangles(angles);
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xf23439c6, Offset: 0x6098
    // Size: 0x38c
    function zombie_devgui_open_sesame() {
        setdvar("<dev string:x1582>", 1);
        level flag::set("<dev string:x1312>");
        level clientfield::set("<dev string:x131b>", 0);
        power_trigs = getentarray("<dev string:x132b>", "<dev string:x133b>");
        foreach (trig in power_trigs) {
            if (isdefined(trig.script_int)) {
                level flag::set("<dev string:x1312>" + trig.script_int);
                level clientfield::set("<dev string:x131b>", trig.script_int);
            }
        }
        players = getplayers();
        array::thread_all(players, &zombie_devgui_give_money);
        zombie_doors = getentarray("<dev string:x1594>", "<dev string:x133b>");
        for (i = 0; i < zombie_doors.size; i++) {
            zombie_doors[i] notify(#"trigger", players[0]);
            if (isdefined(zombie_doors[i].power_door_ignore_flag_wait) && zombie_doors[i].power_door_ignore_flag_wait) {
                zombie_doors[i] notify(#"power_on");
            }
            wait 0.05;
        }
        zombie_airlock_doors = getentarray("<dev string:x15a0>", "<dev string:x133b>");
        for (i = 0; i < zombie_airlock_doors.size; i++) {
            zombie_airlock_doors[i] notify(#"trigger", players[0]);
            wait 0.05;
        }
        zombie_debris = getentarray("<dev string:x15b3>", "<dev string:x133b>");
        for (i = 0; i < zombie_debris.size; i++) {
            if (isdefined(zombie_debris[i])) {
                zombie_debris[i] notify(#"trigger", players[0]);
            }
            wait 0.05;
        }
        level notify(#"open_sesame");
        wait 1;
        setdvar("<dev string:x1582>", 0);
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x948d7f16, Offset: 0x6430
    // Size: 0xb6
    function any_player_in_noclip() {
        foreach (player in getplayers()) {
            if (player isinmovemode("<dev string:x15c1>", "<dev string:x15c5>")) {
                return 1;
            }
        }
        return 0;
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xe69e3a05, Offset: 0x64f0
    // Size: 0x150
    function diable_fog_in_noclip() {
        level.fog_disabled_in_noclip = 1;
        level endon(#"allowfoginnoclip");
        level flag::wait_till("<dev string:xbd>");
        while (true) {
            while (!any_player_in_noclip()) {
                wait 1;
            }
            setdvar("<dev string:x15cc>", "<dev string:x63>");
            setdvar("<dev string:x15dc>", "<dev string:x63>");
            if (isdefined(level.culldist)) {
                setculldist(0);
            }
            while (any_player_in_noclip()) {
                wait 1;
            }
            setdvar("<dev string:x15cc>", "<dev string:xbb>");
            setdvar("<dev string:x15dc>", "<dev string:xbb>");
            if (isdefined(level.culldist)) {
                setculldist(level.culldist);
            }
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x9c47bc0f, Offset: 0x6648
    // Size: 0x8c
    function zombie_devgui_allow_fog() {
        if (isdefined(level.fog_disabled_in_noclip) && level.fog_disabled_in_noclip) {
            level notify(#"allowfoginnoclip");
            level.fog_disabled_in_noclip = 0;
            setdvar("<dev string:x15cc>", "<dev string:xbb>");
            setdvar("<dev string:x15dc>", "<dev string:xbb>");
            return;
        }
        thread diable_fog_in_noclip();
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xc344fed, Offset: 0x66e0
    // Size: 0x9c
    function zombie_devgui_give_money() {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        level.devcheater = 1;
        self zm_score::add_to_player_score(100000);
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x9679e5f, Offset: 0x6788
    // Size: 0xc4
    function zombie_devgui_take_money() {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        if (self.score > 100) {
            self zm_score::player_reduce_points("<dev string:x15ea>");
            return;
        }
        self zm_score::player_reduce_points("<dev string:x15f4>");
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x1e3e20c3, Offset: 0x6858
    // Size: 0xb4
    function zombie_devgui_give_xp(amount) {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        self addrankxp("<dev string:x15fd>", self.currentweapon, undefined, undefined, 1, amount / 50);
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x7db63dc1, Offset: 0x6918
    // Size: 0x184
    function zombie_devgui_turn_player(index) {
        players = getplayers();
        if (!isdefined(index) || index >= players.size) {
            player = players[0];
        } else {
            player = players[index];
        }
        assert(isdefined(player));
        assert(isplayer(player));
        assert(isalive(player));
        level.devcheater = 1;
        if (player hasperk("<dev string:x1602>")) {
            println("<dev string:x161b>");
            player zm_turned::turn_to_human();
            return;
        }
        println("<dev string:x162f>");
        player zm_turned::turn_to_zombie();
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x829c7890, Offset: 0x6aa8
    // Size: 0x384
    function function_be875f57(index) {
        players = getplayers();
        if (!isdefined(index) || index >= players.size) {
            player = players[0];
        } else {
            player = players[index];
        }
        assert(isdefined(player));
        assert(isplayer(player));
        assert(isalive(player));
        level.devcheater = 1;
        println("<dev string:x1644>");
        println("<dev string:x16a5>" + level.var_2cd32f16.size + "<dev string:x16c8>");
        for (var_76226b65 = 0; var_76226b65 < level.var_2cd32f16.size; var_76226b65++) {
            name = level.var_2cd32f16[var_76226b65];
            println(var_76226b65 + "<dev string:x16ca>" + name);
            var_3ed63b1c = level.var_d830ee5f[name];
            for (i = 0; i < var_3ed63b1c.var_e45eb34e.size; i++) {
                stat_name = var_3ed63b1c.var_e45eb34e[i];
                stat_desired_value = var_3ed63b1c.var_3f39db75[i];
                var_ac9e66f = player zm_stats::get_global_stat(stat_name);
                println("<dev string:x16e0>" + i + "<dev string:x16e3>" + stat_name);
                println("<dev string:x16e0>" + i + "<dev string:x16f1>" + stat_desired_value);
                println("<dev string:x16e0>" + i + "<dev string:x1709>" + var_ac9e66f);
            }
            if (isdefined(player.var_698f7e[name]) && player.var_698f7e[name]) {
                println("<dev string:x1727>" + name);
                continue;
            }
            println("<dev string:x1735>" + name);
        }
        println("<dev string:x174d>");
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xefaacbe, Offset: 0x6e38
    // Size: 0x1d4
    function function_4619dfa7() {
        entnum = self getentitynumber();
        chest = level.chests[level.chest_index];
        origin = chest.zbarrier.origin;
        forward = anglestoforward(chest.zbarrier.angles);
        right = anglestoright(chest.zbarrier.angles);
        var_d9191ee9 = vectortoangles(right);
        plorigin = origin - 48 * right;
        switch (entnum) {
        case 0:
            plorigin += 16 * right;
            break;
        case 1:
            plorigin += 16 * forward;
            break;
        case 2:
            plorigin -= 16 * right;
            break;
        case 3:
            plorigin -= 16 * forward;
            break;
        }
        self setorigin(plorigin);
        self setplayerangles(var_d9191ee9);
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xe50b7b5c, Offset: 0x7018
    // Size: 0x24
    function zombie_devgui_cool_jetgun() {
        if (isdefined(level.zm_devgui_jetgun_never_overheat)) {
            self thread [[ level.zm_devgui_jetgun_never_overheat ]]();
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xe2aa2f6e, Offset: 0x7048
    // Size: 0x78
    function zombie_devgui_preserve_turbines() {
        self endon(#"disconnect");
        self notify(#"preserve_turbines");
        self endon(#"preserve_turbines");
        if (!(isdefined(self.preserving_turbines) && self.preserving_turbines)) {
            self.preserving_turbines = 1;
            while (true) {
                self.turbine_health = 1200;
                wait 1;
            }
        }
        self.preserving_turbines = 0;
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x7c28d7fb, Offset: 0x70c8
    // Size: 0x160
    function zombie_devgui_equipment_stays_healthy() {
        self endon(#"disconnect");
        self notify(#"preserve_equipment");
        self endon(#"preserve_equipment");
        if (!(isdefined(self.preserving_equipment) && self.preserving_equipment)) {
            self.preserving_equipment = 1;
            while (true) {
                self.equipment_damage = [];
                self.shielddamagetaken = 0;
                if (isdefined(level.destructible_equipment)) {
                    foreach (equip in level.destructible_equipment) {
                        if (isdefined(equip)) {
                            equip.shielddamagetaken = 0;
                            equip.damage = 0;
                            equip.headchopper_kills = 0;
                            equip.springpad_kills = 0;
                            equip.subwoofer_kills = 0;
                        }
                    }
                }
                wait 0.1;
            }
        }
        self.preserving_equipment = 0;
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x633c714b, Offset: 0x7230
    // Size: 0x14
    function zombie_devgui_disown_equipment() {
        self.deployed_equipment = [];
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x329e5679, Offset: 0x7250
    // Size: 0xb4
    function zombie_devgui_equipment_give(equipment) {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        level.devcheater = 1;
        if (zm_equipment::is_included(equipment)) {
            self zm_equipment::buy(equipment);
        }
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x5e236d4e, Offset: 0x7310
    // Size: 0x13e
    function zombie_devgui_give_placeable_mine(weapon) {
        self endon(#"disconnect");
        self notify(#"give_planted_grenade_thread");
        self endon(#"give_planted_grenade_thread");
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        level.devcheater = 1;
        if (!zm_utility::is_placeable_mine(weapon)) {
            return;
        }
        if (isdefined(self zm_utility::get_player_placeable_mine())) {
            self takeweapon(self zm_utility::get_player_placeable_mine());
        }
        self thread zm_placeable_mine::setup_for_player(weapon);
        while (true) {
            self givemaxammo(weapon);
            wait 1;
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xb131c463, Offset: 0x7458
    // Size: 0x14e
    function zombie_devgui_give_claymores() {
        self endon(#"disconnect");
        self notify(#"give_planted_grenade_thread");
        self endon(#"give_planted_grenade_thread");
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        level.devcheater = 1;
        if (isdefined(self zm_utility::get_player_placeable_mine())) {
            self takeweapon(self zm_utility::get_player_placeable_mine());
        }
        wpn_type = zm_placeable_mine::get_first_available();
        if (wpn_type != level.weaponnone) {
            self thread zm_placeable_mine::setup_for_player(wpn_type);
        }
        while (true) {
            self givemaxammo(wpn_type);
            wait 1;
        }
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x104f9c84, Offset: 0x75b0
    // Size: 0x13e
    function zombie_devgui_give_lethal(weapon) {
        self endon(#"disconnect");
        self notify(#"give_lethal_grenade_thread");
        self endon(#"give_lethal_grenade_thread");
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        level.devcheater = 1;
        if (isdefined(self zm_utility::get_player_lethal_grenade())) {
            self takeweapon(self zm_utility::get_player_lethal_grenade());
        }
        self giveweapon(weapon);
        self zm_utility::set_player_lethal_grenade(weapon);
        while (true) {
            self givemaxammo(weapon);
            wait 1;
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x2d088871, Offset: 0x76f8
    // Size: 0x34
    function zombie_devgui_give_frags() {
        zombie_devgui_give_lethal(getweapon("<dev string:x17ae>"));
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xc317352d, Offset: 0x7738
    // Size: 0x34
    function zombie_devgui_give_sticky() {
        zombie_devgui_give_lethal(getweapon("<dev string:x17bb>"));
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x99f040aa, Offset: 0x7778
    // Size: 0x136
    function zombie_devgui_give_monkey() {
        self endon(#"disconnect");
        self notify(#"give_tactical_grenade_thread");
        self endon(#"give_tactical_grenade_thread");
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        level.devcheater = 1;
        if (isdefined(self zm_utility::get_player_tactical_grenade())) {
            self takeweapon(self zm_utility::get_player_tactical_grenade());
        }
        if (isdefined(level.zombiemode_devgui_cymbal_monkey_give)) {
            self [[ level.zombiemode_devgui_cymbal_monkey_give ]]();
            while (true) {
                self givemaxammo(getweapon("<dev string:x17ca>"));
                wait 1;
            }
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x3fe4dfd1, Offset: 0x78b8
    // Size: 0x126
    function zombie_devgui_give_bhb() {
        self endon(#"disconnect");
        self notify(#"give_tactical_grenade_thread");
        self endon(#"give_tactical_grenade_thread");
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        level.devcheater = 1;
        if (isdefined(self zm_utility::get_player_tactical_grenade())) {
            self takeweapon(self zm_utility::get_player_tactical_grenade());
        }
        if (isdefined(level.var_ee99d38d)) {
            self [[ level.var_ee99d38d ]]();
            while (true) {
                self givemaxammo(level.w_black_hole_bomb);
                wait 1;
            }
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x44978d04, Offset: 0x79e8
    // Size: 0x126
    function zombie_devgui_give_qed() {
        self endon(#"disconnect");
        self notify(#"give_tactical_grenade_thread");
        self endon(#"give_tactical_grenade_thread");
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        level.devcheater = 1;
        if (isdefined(self zm_utility::get_player_tactical_grenade())) {
            self takeweapon(self zm_utility::get_player_tactical_grenade());
        }
        if (isdefined(level.var_3cddfdc)) {
            self [[ level.var_3cddfdc ]]();
            while (true) {
                self givemaxammo(level.w_quantum_bomb);
                wait 1;
            }
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xd7b02818, Offset: 0x7b18
    // Size: 0x126
    function zombie_devgui_give_dolls() {
        self endon(#"disconnect");
        self notify(#"give_tactical_grenade_thread");
        self endon(#"give_tactical_grenade_thread");
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        level.devcheater = 1;
        if (isdefined(self zm_utility::get_player_tactical_grenade())) {
            self takeweapon(self zm_utility::get_player_tactical_grenade());
        }
        if (isdefined(level.var_c1f3b949)) {
            self [[ level.var_c1f3b949 ]]();
            while (true) {
                self givemaxammo(level.w_nesting_dolls);
                wait 1;
            }
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x168406c, Offset: 0x7c48
    // Size: 0x136
    function zombie_devgui_give_emp_bomb() {
        self endon(#"disconnect");
        self notify(#"give_tactical_grenade_thread");
        self endon(#"give_tactical_grenade_thread");
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        level.devcheater = 1;
        if (isdefined(self zm_utility::get_player_tactical_grenade())) {
            self takeweapon(self zm_utility::get_player_tactical_grenade());
        }
        if (isdefined(level.var_af6671e1)) {
            self [[ level.var_af6671e1 ]]();
            while (true) {
                self givemaxammo(getweapon("<dev string:x17d8>"));
                wait 1;
            }
        }
    }

    // Namespace zm_devgui
    // Params 2, eflags: 0x0
    // Checksum 0xb2667b7f, Offset: 0x7d88
    // Size: 0xdc
    function zombie_devgui_invulnerable(playerindex, onoff) {
        players = getplayers();
        if (!isdefined(playerindex)) {
            for (i = 0; i < players.size; i++) {
                zombie_devgui_invulnerable(i, onoff);
            }
            return;
        }
        if (players.size > playerindex) {
            if (onoff) {
                players[playerindex] enableinvulnerability();
                return;
            }
            players[playerindex] disableinvulnerability();
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xcaa0ac9f, Offset: 0x7e70
    // Size: 0x10c
    function zombie_devgui_kill() {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        self disableinvulnerability();
        death_from = (randomfloatrange(-20, 20), randomfloatrange(-20, 20), randomfloatrange(-20, 20));
        self dodamage(self.health + 666, self.origin + death_from);
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xbe8d35a7, Offset: 0x7f88
    // Size: 0x1ee
    function zombie_devgui_toggle_ammo() {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        self notify(#"devgui_toggle_ammo");
        self endon(#"devgui_toggle_ammo");
        self.ammo4evah = !(isdefined(self.ammo4evah) && self.ammo4evah);
        while (isdefined(self) && self.ammo4evah) {
            if (!(isdefined(self.is_drinking) && self.is_drinking)) {
                weapon = self getcurrentweapon();
                if (weapon != level.weaponnone) {
                    self setweaponoverheating(0, 0);
                    max = weapon.maxammo;
                    if (isdefined(max)) {
                        self setweaponammostock(weapon, max);
                    }
                    if (isdefined(self zm_utility::get_player_tactical_grenade())) {
                        self givemaxammo(self zm_utility::get_player_tactical_grenade());
                    }
                    if (isdefined(self zm_utility::get_player_lethal_grenade())) {
                        self givemaxammo(self zm_utility::get_player_lethal_grenade());
                    }
                }
            }
            wait 1;
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x15ca9588, Offset: 0x8180
    // Size: 0xfc
    function zombie_devgui_toggle_ignore() {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        if (!isdefined(self.devgui_ignoreme)) {
            self.devgui_ignoreme = 0;
        }
        self.devgui_ignoreme = !self.devgui_ignoreme;
        if (self.devgui_ignoreme) {
            self zm_utility::function_139befeb();
        } else {
            self zm_utility::function_36f941b3();
        }
        if (self.ignoreme) {
            setdvar("<dev string:x17e4>", 0);
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xbb822371, Offset: 0x8288
    // Size: 0x116
    function zombie_devgui_revive() {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        self reviveplayer();
        self notify(#"stop_revive_trigger");
        if (isdefined(self.revivetrigger)) {
            self.revivetrigger delete();
            self.revivetrigger = undefined;
        }
        self allowjump(1);
        self zm_laststand::set_ignoreme(0);
        self.laststand = undefined;
        self notify(#"player_revived", self);
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xa745ef8e, Offset: 0x83a8
    // Size: 0x116
    function zombie_devgui_give_health() {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        self notify(#"devgui_health");
        self endon(#"devgui_health");
        self endon(#"disconnect");
        self endon(#"death");
        level.devcheater = 1;
        while (true) {
            self.maxhealth = 100000;
            self.health = 100000;
            self util::waittill_any("<dev string:x17f7>", "<dev string:x1806>", "<dev string:x1810>");
            wait 2;
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xd5bf64c4, Offset: 0x84c8
    // Size: 0x10e
    function zombie_devgui_low_health() {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        self notify(#"devgui_health");
        self endon(#"devgui_health");
        self endon(#"disconnect");
        self endon(#"death");
        level.devcheater = 1;
        while (true) {
            self.maxhealth = 10;
            self.health = 10;
            self util::waittill_any("<dev string:x17f7>", "<dev string:x1806>", "<dev string:x1810>");
            wait 2;
        }
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x149c56c3, Offset: 0x85e0
    // Size: 0x148
    function zombie_devgui_give_perk(perk) {
        var_3be8a3b8 = getentarray("<dev string:x181f>", "<dev string:x133b>");
        level.devcheater = 1;
        if (var_3be8a3b8.size < 1) {
            return;
        }
        foreach (player in getplayers()) {
            for (i = 0; i < var_3be8a3b8.size; i++) {
                if (var_3be8a3b8[i].script_noteworthy == perk) {
                    var_3be8a3b8[i] notify(#"trigger", player);
                    break;
                }
            }
            wait 1;
        }
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xd64d3f60, Offset: 0x8730
    // Size: 0x1d2
    function zombie_devgui_take_perks(cmd) {
        var_3be8a3b8 = getentarray("<dev string:x181f>", "<dev string:x133b>");
        perks = [];
        for (i = 0; i < var_3be8a3b8.size; i++) {
            perk = var_3be8a3b8[i].script_noteworthy;
            if (isdefined(self.perk_purchased) && self.perk_purchased == perk) {
                continue;
            }
            perks[perks.size] = perk;
        }
        foreach (player in getplayers()) {
            foreach (perk in perks) {
                perk_str = perk + "<dev string:x182e>";
                player notify(perk_str);
            }
        }
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xcb69f9e6, Offset: 0x8910
    // Size: 0x30
    function function_af69dfbe(cmd) {
        if (isdefined(level.perk_random_devgui_callback)) {
            self [[ level.perk_random_devgui_callback ]](cmd);
        }
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x704d7a31, Offset: 0x8948
    // Size: 0x30
    function function_3df1388a(cmd) {
        if (isdefined(level.perk_random_devgui_callback)) {
            self [[ level.perk_random_devgui_callback ]](cmd);
        }
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x6638e0ac, Offset: 0x8980
    // Size: 0x30
    function function_f976401d(cmd) {
        if (isdefined(level.perk_random_devgui_callback)) {
            self [[ level.perk_random_devgui_callback ]](cmd);
        }
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xecab6c91, Offset: 0x89b8
    // Size: 0x30
    function function_a888b17c(cmd) {
        if (isdefined(level.perk_random_devgui_callback)) {
            self [[ level.perk_random_devgui_callback ]](cmd);
        }
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x85c7891e, Offset: 0x89f0
    // Size: 0x30
    function function_7743668b(cmd) {
        if (isdefined(level.perk_random_devgui_callback)) {
            self [[ level.perk_random_devgui_callback ]](cmd);
        }
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x98232765, Offset: 0x8a28
    // Size: 0x30
    function function_7d8af9ea(cmd) {
        if (isdefined(level.perk_random_devgui_callback)) {
            self [[ level.perk_random_devgui_callback ]](cmd);
        }
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x4c5c50af, Offset: 0x8a60
    // Size: 0x30
    function function_c2cda548(cmd) {
        if (isdefined(level.perk_random_devgui_callback)) {
            self [[ level.perk_random_devgui_callback ]](cmd);
        }
    }

    // Namespace zm_devgui
    // Params 3, eflags: 0x0
    // Checksum 0xba0ce416, Offset: 0x8a98
    // Size: 0x234
    function zombie_devgui_give_powerup(powerup_name, now, origin) {
        player = getplayers()[0];
        found = 0;
        level.devcheater = 1;
        if (isdefined(now) && !now) {
            for (i = 0; i < level.zombie_powerup_array.size; i++) {
                if (level.zombie_powerup_array[i] == powerup_name) {
                    level.zombie_powerup_index = i;
                    found = 1;
                    break;
                }
            }
            if (!found) {
                return;
            }
            level.zombie_devgui_power = 1;
            level.zombie_vars["<dev string:x1834>"] = 1;
            level.powerup_drop_count = 0;
            return;
        }
        direction = player getplayerangles();
        direction_vec = anglestoforward(direction);
        eye = player geteye();
        scale = 8000;
        direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
        trace = bullettrace(eye, eye + direction_vec, 0, undefined);
        if (isdefined(origin)) {
            level thread zm_powerups::specific_powerup_drop(powerup_name, origin);
            return;
        }
        level thread zm_powerups::specific_powerup_drop(powerup_name, trace["<dev string:x1530>"]);
    }

    // Namespace zm_devgui
    // Params 2, eflags: 0x0
    // Checksum 0x309f0d12, Offset: 0x8cd8
    // Size: 0x1fc
    function zombie_devgui_give_powerup_player(powerup_name, now) {
        player = self;
        found = 0;
        level.devcheater = 1;
        if (isdefined(now) && !now) {
            for (i = 0; i < level.zombie_powerup_array.size; i++) {
                if (level.zombie_powerup_array[i] == powerup_name) {
                    level.zombie_powerup_index = i;
                    found = 1;
                    break;
                }
            }
            if (!found) {
                return;
            }
            level.zombie_devgui_power = 1;
            level.zombie_vars["<dev string:x1834>"] = 1;
            level.powerup_drop_count = 0;
            return;
        }
        direction = player getplayerangles();
        direction_vec = anglestoforward(direction);
        eye = player geteye();
        scale = 8000;
        direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
        trace = bullettrace(eye, eye + direction_vec, 0, undefined);
        level thread zm_powerups::specific_powerup_drop(powerup_name, trace["<dev string:x1530>"], undefined, undefined, undefined, player);
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x6b0a6aa6, Offset: 0x8ee0
    // Size: 0x186
    function zombie_devgui_goto_round(target_round) {
        player = getplayers()[0];
        if (target_round < 1) {
            target_round = 1;
        }
        level.devcheater = 1;
        level.zombie_total = 0;
        zombie_utility::ai_calculate_health(target_round);
        zm::set_round_number(target_round - 1);
        level notify(#"kill_round");
        wait 1;
        zombies = getaiteamarray(level.zombie_team);
        if (isdefined(zombies)) {
            for (i = 0; i < zombies.size; i++) {
                if (isdefined(zombies[i].ignore_devgui_death) && zombies[i].ignore_devgui_death) {
                    continue;
                }
                zombies[i] dodamage(zombies[i].health + 666, zombies[i].origin);
            }
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x55beab9f, Offset: 0x9070
    // Size: 0x2c
    function zombie_devgui_monkey_round() {
        if (isdefined(level.var_175c18a7)) {
            zombie_devgui_goto_round(level.var_175c18a7);
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x1e41250b, Offset: 0x90a8
    // Size: 0x2c
    function zombie_devgui_thief_round() {
        if (isdefined(level.var_a60cad7e)) {
            zombie_devgui_goto_round(level.var_a60cad7e);
        }
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x8de0d88b, Offset: 0x90e0
    // Size: 0xdc
    function zombie_devgui_dog_round(num_dogs) {
        if (!isdefined(level.var_61c54e76) || !level.var_61c54e76) {
            return;
        }
        if (!isdefined(level.var_459c76d) || !level.var_459c76d) {
            return;
        }
        if (!isdefined(level.enemy_dog_spawns) || level.enemy_dog_spawns.size < 1) {
            return;
        }
        if (!level flag::get("<dev string:x1180>")) {
            setdvar("<dev string:x1845>", num_dogs);
        }
        zombie_devgui_goto_round(level.round_number + 1);
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x43b82ae4, Offset: 0x91c8
    // Size: 0x2c
    function zombie_devgui_dog_round_skip() {
        if (isdefined(level.next_dog_round)) {
            zombie_devgui_goto_round(level.next_dog_round);
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x44b987d5, Offset: 0x9200
    // Size: 0xf4
    function zombie_devgui_dump_zombie_vars() {
        if (!isdefined(level.zombie_vars)) {
            return;
        }
        if (level.zombie_vars.size > 0) {
            println("<dev string:x1850>");
        } else {
            return;
        }
        var_names = getarraykeys(level.zombie_vars);
        for (i = 0; i < level.zombie_vars.size; i++) {
            key = var_names[i];
            println(key + "<dev string:x186b>" + level.zombie_vars[key]);
        }
        println("<dev string:x1872>");
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x82f9acb8, Offset: 0x9300
    // Size: 0x196
    function zombie_devgui_pack_current_weapon() {
        players = getplayers();
        reviver = players[0];
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            if (!players[i] laststand::player_is_in_laststand()) {
                weap = players[i] getcurrentweapon();
                weapon = get_upgrade(weap.rootweapon);
                players[i] takeweapon(weap);
                weapon = players[i] zm_weapons::give_build_kit_weapon(weapon);
                players[i] thread aat::remove(weapon);
                players[i] givestartammo(weapon);
                players[i] switchtoweapon(weapon);
            }
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x7f17b085, Offset: 0x94a0
    // Size: 0x10e
    function zombie_devgui_repack_current_weapon() {
        players = getplayers();
        reviver = players[0];
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            if (!players[i] laststand::player_is_in_laststand()) {
                weap = players[i] getcurrentweapon();
                if (isdefined(level.aat_in_use) && level.aat_in_use && zm_weapons::weapon_supports_aat(weap)) {
                    players[i] thread aat::acquire(weap);
                }
            }
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x17d3cf37, Offset: 0x95b8
    // Size: 0x16e
    function zombie_devgui_unpack_current_weapon() {
        players = getplayers();
        reviver = players[0];
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            if (!players[i] laststand::player_is_in_laststand()) {
                weap = players[i] getcurrentweapon();
                weapon = zm_weapons::get_base_weapon(weap);
                players[i] takeweapon(weap);
                weapon = players[i] zm_weapons::give_build_kit_weapon(weapon);
                players[i] givestartammo(weapon);
                players[i] switchtoweapon(weapon);
            }
        }
    }

    // Namespace zm_devgui
    // Params 2, eflags: 0x0
    // Checksum 0xb4fd818f, Offset: 0x9730
    // Size: 0x74
    function function_3ec0de8d(itemindex, xp) {
        if (!itemindex || !level.onlinegame) {
            return;
        }
        if (0 > xp) {
            xp = 0;
        }
        self setdstat("<dev string:x1893>", itemindex, "<dev string:x189d>", xp);
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xe3d71c52, Offset: 0x97b0
    // Size: 0xfe
    function function_949d6013(weapon) {
        gunlevels = [];
        table = popups::devgui_notif_getgunleveltablename();
        weapon_name = weapon.rootweapon.name;
        for (i = 0; i < 15; i++) {
            var_d4b6b0ab = tablelookup(table, 2, weapon_name, 0, i, 1);
            if ("<dev string:x40>" == var_d4b6b0ab) {
                break;
            }
            gunlevels[i] = int(var_d4b6b0ab);
        }
        return gunlevels;
    }

    // Namespace zm_devgui
    // Params 2, eflags: 0x0
    // Checksum 0xc8132c5f, Offset: 0x98b8
    // Size: 0x90
    function function_718c64af(weapon, var_2e8a2b5e) {
        xp = 0;
        gunlevels = function_949d6013(weapon);
        if (gunlevels.size) {
            xp = gunlevels[gunlevels.size - 1];
            if (var_2e8a2b5e < gunlevels.size) {
                xp = gunlevels[var_2e8a2b5e];
            }
        }
        return xp;
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x1b99ec5c, Offset: 0x9950
    // Size: 0x68
    function function_e9906f08(weapon) {
        xp = 0;
        gunlevels = function_949d6013(weapon);
        if (gunlevels.size) {
            xp = gunlevels[gunlevels.size - 1];
        }
        return xp;
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x6908cf36, Offset: 0x99c0
    // Size: 0x13e
    function function_2306f73c() {
        players = getplayers();
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!player laststand::player_is_in_laststand()) {
                weapon = player getcurrentweapon();
                itemindex = getbaseweaponitemindex(weapon);
                var_2e8a2b5e = player getcurrentgunrank(itemindex);
                xp = function_718c64af(weapon, var_2e8a2b5e);
                player function_3ec0de8d(itemindex, xp);
            }
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x48447650, Offset: 0x9b08
    // Size: 0x146
    function function_5da1c3cd() {
        players = getplayers();
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!player laststand::player_is_in_laststand()) {
                weapon = player getcurrentweapon();
                itemindex = getbaseweaponitemindex(weapon);
                var_2e8a2b5e = player getcurrentgunrank(itemindex);
                xp = function_718c64af(weapon, var_2e8a2b5e);
                player function_3ec0de8d(itemindex, xp - 50);
            }
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x5c269215, Offset: 0x9c58
    // Size: 0x10e
    function function_6afc4c2f() {
        players = getplayers();
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!player laststand::player_is_in_laststand()) {
                weapon = player getcurrentweapon();
                itemindex = getbaseweaponitemindex(weapon);
                xp = function_e9906f08(weapon);
                player function_3ec0de8d(itemindex, xp);
            }
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xa2f66bf6, Offset: 0x9d70
    // Size: 0xee
    function function_9b4ea903() {
        players = getplayers();
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!player laststand::player_is_in_laststand()) {
                weapon = player getcurrentweapon();
                itemindex = getbaseweaponitemindex(weapon);
                player function_3ec0de8d(itemindex, 0);
            }
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x98bd74cd, Offset: 0x9e68
    // Size: 0x160
    function function_4d2e8278() {
        players = getplayers();
        level.devcheater = 1;
        a_weapons = enumerateweapons("<dev string:x18a0>");
        for (weapon_index = 0; weapon_index < a_weapons.size; weapon_index++) {
            weapon = a_weapons[weapon_index];
            itemindex = getbaseweaponitemindex(weapon);
            if (!itemindex) {
                continue;
            }
            xp = function_e9906f08(weapon);
            for (i = 0; i < players.size; i++) {
                player = players[i];
                if (!player laststand::player_is_in_laststand()) {
                    player function_3ec0de8d(itemindex, xp);
                }
            }
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x2550312c, Offset: 0x9fd0
    // Size: 0x140
    function function_ce561484() {
        players = getplayers();
        level.devcheater = 1;
        a_weapons = enumerateweapons("<dev string:x18a0>");
        for (weapon_index = 0; weapon_index < a_weapons.size; weapon_index++) {
            weapon = a_weapons[weapon_index];
            itemindex = getbaseweaponitemindex(weapon);
            if (!itemindex) {
                continue;
            }
            for (i = 0; i < players.size; i++) {
                player = players[i];
                if (!player laststand::player_is_in_laststand()) {
                    player function_3ec0de8d(itemindex, 0);
                }
            }
        }
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0xf89a404a, Offset: 0xa118
    // Size: 0x104
    function function_be6b95c4(xp) {
        if (self.pers["<dev string:x18a7>"] > xp) {
            self.pers["<dev string:x18ae>"] = 0;
            self setrank(0);
            self setdstat("<dev string:x18b3>", "<dev string:x18ae>", "<dev string:x18c3>", 0);
        }
        self.pers["<dev string:x18a7>"] = xp;
        self rank::syncxpstat();
        self rank::updaterank();
        self setdstat("<dev string:x18b3>", "<dev string:x18ae>", "<dev string:x18c3>", self.pers["<dev string:x18ae>"]);
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x43d61e30, Offset: 0xa228
    // Size: 0x34
    function function_1a6e88f7(var_2e8a2b5e) {
        return int(level.ranktable[var_2e8a2b5e][7]);
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x8a6a9550, Offset: 0xa268
    // Size: 0x46
    function function_b207ef2e() {
        xp = 0;
        xp = function_1a6e88f7(level.ranktable.size - 1);
        return xp;
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x2231105c, Offset: 0xa2b8
    // Size: 0xee
    function function_9e5bfd9d() {
        players = getplayers();
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!player laststand::player_is_in_laststand()) {
                var_2e8a2b5e = player rank::getrank();
                xp = function_1a6e88f7(var_2e8a2b5e);
                player function_be6b95c4(xp);
            }
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xe743155f, Offset: 0xa3b0
    // Size: 0xf6
    function function_435ea700() {
        players = getplayers();
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!player laststand::player_is_in_laststand()) {
                var_2e8a2b5e = player rank::getrank();
                xp = function_1a6e88f7(var_2e8a2b5e);
                player function_be6b95c4(xp - 50);
            }
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x50878941, Offset: 0xa4b0
    // Size: 0xce
    function function_525facc6() {
        players = getplayers();
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!player laststand::player_is_in_laststand()) {
                xp = function_b207ef2e();
                player function_be6b95c4(xp);
            }
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xba7ef207, Offset: 0xa588
    // Size: 0xa6
    function function_935f6cc2() {
        players = getplayers();
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!player laststand::player_is_in_laststand()) {
                player function_be6b95c4(0);
            }
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x16a4b86f, Offset: 0xa638
    // Size: 0x17e
    function zombie_devgui_reopt_current_weapon() {
        players = getplayers();
        reviver = players[0];
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            if (!players[i] laststand::player_is_in_laststand()) {
                weapon = players[i] getcurrentweapon();
                if (isdefined(players[i].pack_a_punch_weapon_options)) {
                    players[i].pack_a_punch_weapon_options[weapon] = undefined;
                }
                players[i] takeweapon(weapon);
                weapon = players[i] zm_weapons::give_build_kit_weapon(weapon);
                players[i] givestartammo(weapon);
                players[i] switchtoweapon(weapon);
            }
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xea16f241, Offset: 0xa7c0
    // Size: 0xee
    function zombie_devgui_take_weapon() {
        players = getplayers();
        reviver = players[0];
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            if (!players[i] laststand::player_is_in_laststand()) {
                players[i] takeweapon(players[i] getcurrentweapon());
                players[i] zm_weapons::switch_back_primary_weapon(undefined);
            }
        }
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x2ee68388, Offset: 0xa8b8
    // Size: 0xe6
    function zombie_devgui_take_weapons(give_fallback) {
        players = getplayers();
        reviver = players[0];
        level.devcheater = 1;
        for (i = 0; i < players.size; i++) {
            if (!players[i] laststand::player_is_in_laststand()) {
                players[i] takeallweapons();
                if (give_fallback) {
                    players[i] zm_weapons::give_fallback_weapon();
                }
            }
        }
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x87747146, Offset: 0xa9a8
    // Size: 0x7c
    function get_upgrade(weapon) {
        if (isdefined(level.zombie_weapons[weapon]) && isdefined(level.zombie_weapons[weapon].upgrade_name)) {
            return zm_weapons::get_upgrade_weapon(weapon, 0);
        }
        return zm_weapons::get_upgrade_weapon(weapon, 1);
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x70ce405d, Offset: 0xaa30
    // Size: 0x24
    function zombie_devgui_director_easy() {
        if (isdefined(level.var_fb47b57)) {
            [[ level.var_fb47b57 ]]();
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xdece5edc, Offset: 0xaa60
    // Size: 0x36
    function zombie_devgui_chest_never_move() {
        level notify(#"devgui_chest_end_monitor");
        level endon(#"devgui_chest_end_monitor");
        for (;;) {
            level.chest_accessed = 0;
            wait 5;
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x7e716bac, Offset: 0xaaa0
    // Size: 0x3c
    function zombie_devgui_disable_kill_thread_toggle() {
        if (!(isdefined(level.disable_kill_thread) && level.disable_kill_thread)) {
            level.disable_kill_thread = 1;
            return;
        }
        level.disable_kill_thread = 0;
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x4a9c1e0f, Offset: 0xaae8
    // Size: 0x3c
    function zombie_devgui_check_kill_thread_every_frame_toggle() {
        if (!(isdefined(level.check_kill_thread_every_frame) && level.check_kill_thread_every_frame)) {
            level.check_kill_thread_every_frame = 1;
            return;
        }
        level.check_kill_thread_every_frame = 0;
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xebdec2d6, Offset: 0xab30
    // Size: 0x3c
    function zombie_devgui_kill_thread_test_mode_toggle() {
        if (!(isdefined(level.kill_thread_test_mode) && level.kill_thread_test_mode)) {
            level.kill_thread_test_mode = 1;
            return;
        }
        level.kill_thread_test_mode = 0;
    }

    // Namespace zm_devgui
    // Params 5, eflags: 0x0
    // Checksum 0x25b235d5, Offset: 0xab78
    // Size: 0x58e
    function showonespawnpoint(spawn_point, color, notification, height, print) {
        if (!isdefined(height) || height <= 0) {
            height = util::get_player_height();
        }
        if (!isdefined(print)) {
            print = spawn_point.classname;
        }
        center = spawn_point.origin;
        forward = anglestoforward(spawn_point.angles);
        right = anglestoright(spawn_point.angles);
        forward = vectorscale(forward, 16);
        right = vectorscale(right, 16);
        a = center + forward - right;
        b = center + forward + right;
        c = center - forward + right;
        d = center - forward - right;
        thread lineuntilnotified(a, b, color, 0, notification);
        thread lineuntilnotified(b, c, color, 0, notification);
        thread lineuntilnotified(c, d, color, 0, notification);
        thread lineuntilnotified(d, a, color, 0, notification);
        thread lineuntilnotified(a, a + (0, 0, height), color, 0, notification);
        thread lineuntilnotified(b, b + (0, 0, height), color, 0, notification);
        thread lineuntilnotified(c, c + (0, 0, height), color, 0, notification);
        thread lineuntilnotified(d, d + (0, 0, height), color, 0, notification);
        a += (0, 0, height);
        b += (0, 0, height);
        c += (0, 0, height);
        d += (0, 0, height);
        thread lineuntilnotified(a, b, color, 0, notification);
        thread lineuntilnotified(b, c, color, 0, notification);
        thread lineuntilnotified(c, d, color, 0, notification);
        thread lineuntilnotified(d, a, color, 0, notification);
        center += (0, 0, height / 2);
        arrow_forward = anglestoforward(spawn_point.angles);
        arrowhead_forward = anglestoforward(spawn_point.angles);
        arrowhead_right = anglestoright(spawn_point.angles);
        arrow_forward = vectorscale(arrow_forward, 32);
        arrowhead_forward = vectorscale(arrowhead_forward, 24);
        arrowhead_right = vectorscale(arrowhead_right, 8);
        a = center + arrow_forward;
        b = center + arrowhead_forward - arrowhead_right;
        c = center + arrowhead_forward + arrowhead_right;
        thread lineuntilnotified(center, a, color, 0, notification);
        thread lineuntilnotified(a, b, color, 0, notification);
        thread lineuntilnotified(a, c, color, 0, notification);
        thread print3duntilnotified(spawn_point.origin + (0, 0, height), print, color, 1, 1, notification);
        return;
    }

    // Namespace zm_devgui
    // Params 6, eflags: 0x0
    // Checksum 0x6bca5a04, Offset: 0xb110
    // Size: 0x70
    function print3duntilnotified(origin, text, color, alpha, scale, notification) {
        level endon(notification);
        for (;;) {
            print3d(origin, text, color, alpha, scale);
            wait 0.05;
        }
    }

    // Namespace zm_devgui
    // Params 5, eflags: 0x0
    // Checksum 0xce6240a4, Offset: 0xb188
    // Size: 0x68
    function lineuntilnotified(start, end, color, depthtest, notification) {
        level endon(notification);
        for (;;) {
            line(start, end, color, depthtest);
            wait 0.05;
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xadf4520d, Offset: 0xb1f8
    // Size: 0x2dc
    function devgui_debug_hud() {
        if (isdefined(self zm_utility::get_player_lethal_grenade())) {
            self givemaxammo(self zm_utility::get_player_lethal_grenade());
        }
        wpn_type = zm_placeable_mine::get_first_available();
        if (wpn_type != level.weaponnone) {
            self thread zm_placeable_mine::setup_for_player(wpn_type);
        }
        if (isdefined(level.zombiemode_devgui_cymbal_monkey_give)) {
            if (isdefined(self zm_utility::get_player_tactical_grenade())) {
                self takeweapon(self zm_utility::get_player_tactical_grenade());
            }
            self [[ level.zombiemode_devgui_cymbal_monkey_give ]]();
        } else if (isdefined(self zm_utility::get_player_tactical_grenade())) {
            self givemaxammo(self zm_utility::get_player_tactical_grenade());
        }
        if (isdefined(level.zombie_include_equipment) && !isdefined(self zm_equipment::get_player_equipment())) {
            equipment = getarraykeys(level.zombie_include_equipment);
            if (isdefined(equipment[0])) {
                self zombie_devgui_equipment_give(equipment[0]);
            }
        }
        for (i = 0; i < 10; i++) {
            zombie_devgui_give_powerup("<dev string:xee5>", 1, self.origin);
            wait 0.25;
        }
        zombie_devgui_give_powerup("<dev string:xe99>", 1, self.origin);
        wait 0.25;
        zombie_devgui_give_powerup("<dev string:xea4>", 1, self.origin);
        wait 0.25;
        zombie_devgui_give_powerup("<dev string:xec6>", 1, self.origin);
        wait 0.25;
        zombie_devgui_give_powerup("<dev string:xedd>", 1, self.origin);
        wait 0.25;
        zombie_devgui_give_powerup("<dev string:xed0>", 1, self.origin);
        wait 0.25;
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x515572a3, Offset: 0xb4e0
    // Size: 0x20c
    function devgui_test_chart_think() {
        wait 0.05;
        old_val = getdvarint("<dev string:x18cd>");
        for (;;) {
            val = getdvarint("<dev string:x18cd>");
            if (old_val != val) {
                if (isdefined(level.test_chart_model)) {
                    level.test_chart_model delete();
                    level.test_chart_model = undefined;
                }
                if (val) {
                    player = getplayers()[0];
                    direction = player getplayerangles();
                    direction_vec = anglestoforward((0, direction[1], 0));
                    scale = 120;
                    direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
                    level.test_chart_model = spawn("<dev string:x18e2>", player geteye() + direction_vec);
                    level.test_chart_model setmodel("<dev string:x18ef>");
                    level.test_chart_model.angles = (0, direction[1], 0) + (0, 90, 0);
                }
            }
            old_val = val;
            wait 0.05;
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xc735cb95, Offset: 0xb6f8
    // Size: 0x34
    function zombie_devgui_draw_traversals() {
        if (!isdefined(level.toggle_draw_traversals)) {
            level.toggle_draw_traversals = 1;
            return;
        }
        level.toggle_draw_traversals = !level.toggle_draw_traversals;
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x6c9b94d7, Offset: 0xb738
    // Size: 0x34
    function zombie_devgui_keyline_always() {
        if (!isdefined(level.toggle_keyline_always)) {
            level.toggle_keyline_always = 1;
            return;
        }
        level.toggle_keyline_always = !level.toggle_keyline_always;
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xba2ffa47, Offset: 0xb778
    // Size: 0x34
    function function_13d8ea87() {
        if (!isdefined(level.var_c2a01768)) {
            level.var_c2a01768 = 1;
            return;
        }
        level.var_c2a01768 = !level.var_c2a01768;
    }

    // Namespace zm_devgui
    // Params 1, eflags: 0x0
    // Checksum 0x528dc1d1, Offset: 0xb7b8
    // Size: 0x2dc
    function wait_for_zombie(crawler) {
        nodes = getallnodes();
        while (true) {
            ai = getactorarray();
            zombie = ai[0];
            if (isdefined(zombie)) {
                foreach (node in nodes) {
                    if (node.type == "<dev string:x1900>" || node.type == "<dev string:x1906>" || node.type == "<dev string:x190a>") {
                        if (isdefined(node.animscript)) {
                            blackboard::setblackboardattribute(zombie, "<dev string:x1913>", "<dev string:x191b>");
                            blackboard::setblackboardattribute(zombie, "<dev string:x1921>", node.animscript);
                            table = istring("<dev string:x1931>");
                            if (isdefined(crawler) && crawler) {
                                table = istring("<dev string:x1941>");
                            }
                            if (isdefined(zombie.debug_traversal_ast)) {
                                table = istring(zombie.debug_traversal_ast);
                            }
                            anim_results = zombie astsearch(table);
                            if (!isdefined(anim_results["<dev string:x1959>"])) {
                                if (isdefined(crawler) && crawler) {
                                    node.bad_crawler_traverse = 1;
                                } else {
                                    node.bad_traverse = 1;
                                }
                                continue;
                            }
                            if (anim_results["<dev string:x1959>"] == "<dev string:x1963>") {
                                teleport = 1;
                            }
                        }
                    }
                }
                break;
            }
            wait 0.25;
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xd1714b48, Offset: 0xbaa0
    // Size: 0x230
    function zombie_draw_traversals() {
        level thread wait_for_zombie();
        level thread wait_for_zombie(1);
        nodes = getallnodes();
        while (true) {
            if (isdefined(level.toggle_draw_traversals) && level.toggle_draw_traversals) {
                foreach (node in nodes) {
                    if (isdefined(node.animscript)) {
                        txt_color = (0, 0.8, 0.6);
                        circle_color = (1, 1, 1);
                        if (isdefined(node.bad_traverse) && node.bad_traverse) {
                            txt_color = (1, 0, 0);
                            circle_color = (1, 0, 0);
                        }
                        circle(node.origin, 16, circle_color);
                        print3d(node.origin, node.animscript, txt_color, 1, 0.5);
                        if (isdefined(node.bad_crawler_traverse) && node.bad_crawler_traverse) {
                            print3d(node.origin + (0, 0, -12), "<dev string:x197c>", (1, 0, 0), 1, 0.5);
                        }
                    }
                }
            }
            wait 0.05;
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x362aa267, Offset: 0xbcd8
    // Size: 0x1fc
    function function_364ed1b9() {
        nodes = getallnodes();
        var_242e809d = [];
        foreach (node in nodes) {
            if (isdefined(node.animscript) && node.animscript != "<dev string:x40>") {
                var_242e809d[node.animscript] = 1;
            }
        }
        var_d1e1ebcf = getarraykeys(var_242e809d);
        sortednames = array::sort_by_value(var_d1e1ebcf, 1);
        println("<dev string:x1994>");
        foreach (name in sortednames) {
            println("<dev string:x19af>" + name);
        }
        println("<dev string:x19bc>");
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x6d5e3542, Offset: 0xbee0
    // Size: 0x220
    function function_1d21f4f() {
        while (true) {
            if (isdefined(level.var_c2a01768) && level.var_c2a01768) {
                if (!isdefined(level.var_ff15f442)) {
                    level.var_ff15f442 = newhudelem();
                    level.var_ff15f442.alignx = "<dev string:x19d5>";
                    level.var_ff15f442.x = 2;
                    level.var_ff15f442.y = -96;
                    level.var_ff15f442.fontscale = 1.5;
                    level.var_ff15f442.color = (1, 1, 1);
                }
                zombie_count = zombie_utility::get_current_zombie_count();
                zombie_left = level.zombie_total;
                zombie_runners = 0;
                var_8cbe658b = zombie_utility::get_zombie_array();
                foreach (ai_zombie in var_8cbe658b) {
                    if (ai_zombie.zombie_move_speed == "<dev string:x19da>") {
                        zombie_runners++;
                    }
                }
                level.var_ff15f442 settext("<dev string:x19de>" + zombie_count + "<dev string:x19e6>" + zombie_left + "<dev string:x19f2>" + zombie_runners);
            } else if (isdefined(level.var_ff15f442)) {
                level.var_ff15f442 destroy();
            }
            wait 0.05;
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x4b960277, Offset: 0xc108
    // Size: 0x24
    function testscriptruntimeerrorassert() {
        wait 1;
        assert(0);
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xc866f8f9, Offset: 0xc138
    // Size: 0x44
    function testscriptruntimeerror2() {
        myundefined = "<dev string:x19fe>";
        if (myundefined == 1) {
            println("<dev string:x1a03>");
        }
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x901d1cbd, Offset: 0xc188
    // Size: 0x1c
    function testscriptruntimeerror1() {
        testscriptruntimeerror2();
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x92534bc4, Offset: 0xc1b0
    // Size: 0xcc
    function testscriptruntimeerror() {
        wait 5;
        for (;;) {
            if (getdvarstring("<dev string:xa0>") != "<dev string:xbb>") {
                break;
            }
            wait 1;
        }
        myerror = getdvarstring("<dev string:xa0>");
        setdvar("<dev string:xa0>", "<dev string:xbb>");
        if (myerror == "<dev string:x1a29>") {
            testscriptruntimeerrorassert();
        } else {
            testscriptruntimeerror1();
        }
        thread testscriptruntimeerror();
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0xa7661b2d, Offset: 0xc288
    // Size: 0x84
    function function_2fcc56bd() {
        var_9857308b = getdvarint("<dev string:x1a30>");
        return array(array(var_9857308b / 2, 30), array(var_9857308b - 1, 20));
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x43faf036, Offset: 0xc318
    // Size: 0x244
    function function_1acc8e35() {
        self endon(#"hash_eec2d58b");
        setdvar("<dev string:x1a49>", 1);
        var_9857308b = getdvarint("<dev string:x1a30>");
        timescale = getdvarint("<dev string:x1a5c>");
        var_da0f3f6 = function_2fcc56bd();
        setdvar("<dev string:x1a75>", timescale);
        while (level.round_number < var_9857308b) {
            foreach (round_info in var_da0f3f6) {
                if (level.round_number < round_info[0]) {
                    wait round_info[1];
                    break;
                }
            }
            ai_enemies = getaiteamarray("<dev string:x1a83>");
            foreach (ai in ai_enemies) {
                ai kill();
            }
            adddebugcommand("<dev string:x1a88>");
            wait 0.2;
        }
        setdvar("<dev string:x1a75>", 1);
    }

    // Namespace zm_devgui
    // Params 0, eflags: 0x0
    // Checksum 0x6e03069e, Offset: 0xc568
    // Size: 0x34
    function function_eec2d58b() {
        self notify(#"hash_eec2d58b");
        setdvar("<dev string:x1a75>", 1);
    }

#/
