#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_blockers;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_powerup_carpenter;

// Namespace zm_powerup_carpenter
// Params 0, eflags: 0x2
// namespace_a5ab9a0e<file_0>::function_2dc19561
// Checksum 0x6f65eba2, Offset: 0x2d8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_carpenter", &__init__, undefined, undefined);
}

// Namespace zm_powerup_carpenter
// Params 0, eflags: 0x1 linked
// namespace_a5ab9a0e<file_0>::function_8c87d8eb
// Checksum 0xe83bfb6c, Offset: 0x318
// Size: 0xb4
function __init__() {
    zm_powerups::register_powerup("carpenter", &grab_carpenter);
    if (tolower(getdvarstring("g_gametype")) != "zcleansed") {
        zm_powerups::add_zombie_powerup("carpenter", "p7_zm_power_up_carpenter", %ZOMBIE_POWERUP_MAX_AMMO, &func_should_drop_carpenter, 0, 0, 0);
    }
    level.var_baf97dad = &function_8cf31031;
}

// Namespace zm_powerup_carpenter
// Params 1, eflags: 0x1 linked
// namespace_a5ab9a0e<file_0>::function_88d5fa3a
// Checksum 0x56f49635, Offset: 0x3d8
// Size: 0x9c
function grab_carpenter(player) {
    if (zm_utility::is_classic()) {
        player thread namespace_95add22b::function_ce147d1();
    }
    if (isdefined(level.var_baf97dad)) {
        level thread [[ level.var_baf97dad ]](self.origin);
    } else {
        level thread start_carpenter(self.origin);
    }
    player thread zm_powerups::powerup_vo("carpenter");
}

// Namespace zm_powerup_carpenter
// Params 1, eflags: 0x1 linked
// namespace_a5ab9a0e<file_0>::function_30475bf2
// Checksum 0xa77760ca, Offset: 0x480
// Size: 0x324
function start_carpenter(origin) {
    window_boards = struct::get_array("exterior_goal", "targetname");
    total = level.exterior_goals.size;
    carp_ent = spawn("script_origin", (0, 0, 0));
    carp_ent playloopsound("evt_carpenter");
    while (true) {
        windows = get_closest_window_repair(window_boards, origin);
        if (!isdefined(windows)) {
            carp_ent stoploopsound(1);
            carp_ent playsoundwithnotify("evt_carpenter_end", "sound_done");
            carp_ent waittill(#"sound_done");
            break;
        } else {
            arrayremovevalue(window_boards, windows);
        }
        while (true) {
            if (zm_utility::all_chunks_intact(windows, windows.barrier_chunks)) {
                break;
            }
            chunk = zm_utility::get_random_destroyed_chunk(windows, windows.barrier_chunks);
            if (!isdefined(chunk)) {
                break;
            }
            windows thread zm_blockers::replace_chunk(windows, chunk, undefined, zm_powerups::function_108ccd4b(), 1);
            if (isdefined(windows.clip)) {
                windows.clip triggerenable(1);
                windows.clip disconnectpaths();
            } else {
                zm_blockers::blocker_disconnect_paths(windows.neg_start, windows.neg_end);
            }
            util::wait_network_frame();
            wait(0.05);
        }
        util::wait_network_frame();
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] zm_score::player_add_points("carpenter_powerup", -56);
    }
    carp_ent delete();
}

// Namespace zm_powerup_carpenter
// Params 2, eflags: 0x1 linked
// namespace_a5ab9a0e<file_0>::function_476f2c76
// Checksum 0xbb715fe8, Offset: 0x7b0
// Size: 0x13e
function get_closest_window_repair(windows, origin) {
    current_window = undefined;
    shortest_distance = undefined;
    for (i = 0; i < windows.size; i++) {
        if (zm_utility::all_chunks_intact(windows, windows[i].barrier_chunks)) {
            continue;
        }
        if (!isdefined(current_window)) {
            current_window = windows[i];
            shortest_distance = distancesquared(current_window.origin, origin);
            continue;
        }
        if (distancesquared(windows[i].origin, origin) < shortest_distance) {
            current_window = windows[i];
            shortest_distance = distancesquared(windows[i].origin, origin);
        }
    }
    return current_window;
}

// Namespace zm_powerup_carpenter
// Params 1, eflags: 0x1 linked
// namespace_a5ab9a0e<file_0>::function_8cf31031
// Checksum 0xa2666c73, Offset: 0x8f8
// Size: 0x492
function function_8cf31031(origin) {
    level.carpenter_powerup_active = 1;
    window_boards = struct::get_array("exterior_goal", "targetname");
    if (isdefined(level._additional_carpenter_nodes)) {
        window_boards = arraycombine(window_boards, level._additional_carpenter_nodes, 0, 0);
    }
    carp_ent = spawn("script_origin", (0, 0, 0));
    carp_ent playloopsound("evt_carpenter");
    boards_near_players = get_near_boards(window_boards);
    boards_far_from_players = get_far_boards(window_boards);
    level repair_far_boards(boards_far_from_players, zm_powerups::function_108ccd4b());
    for (i = 0; i < boards_near_players.size; i++) {
        window = boards_near_players[i];
        num_chunks_checked = 0;
        last_repaired_chunk = undefined;
        while (true) {
            if (zm_utility::all_chunks_intact(window, window.barrier_chunks)) {
                break;
            }
            chunk = zm_utility::get_random_destroyed_chunk(window, window.barrier_chunks);
            if (!isdefined(chunk)) {
                break;
            }
            window thread zm_blockers::replace_chunk(window, chunk, undefined, zm_powerups::function_108ccd4b(), 1);
            last_repaired_chunk = chunk;
            if (isdefined(window.clip)) {
                window.clip triggerenable(1);
                window.clip disconnectpaths();
            } else {
                zm_blockers::blocker_disconnect_paths(window.neg_start, window.neg_end);
            }
            util::wait_network_frame();
            num_chunks_checked++;
            if (num_chunks_checked >= 20) {
                break;
            }
        }
        if (isdefined(window.zbarrier)) {
            if (isdefined(last_repaired_chunk)) {
                while (window.zbarrier getzbarrierpiecestate(last_repaired_chunk) == "closing") {
                    wait(0.05);
                }
                if (isdefined(window._post_carpenter_callback)) {
                    window [[ window._post_carpenter_callback ]]();
                }
            }
            continue;
        }
        while (isdefined(last_repaired_chunk) && last_repaired_chunk.state == "mid_repair") {
            wait(0.05);
        }
    }
    carp_ent stoploopsound(1);
    carp_ent playsoundwithnotify("evt_carpenter_end", "sound_done");
    carp_ent waittill(#"sound_done");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] zm_score::player_add_points("carpenter_powerup", -56);
    }
    carp_ent delete();
    level notify(#"carpenter_finished");
    level.carpenter_powerup_active = undefined;
}

// Namespace zm_powerup_carpenter
// Params 1, eflags: 0x1 linked
// namespace_a5ab9a0e<file_0>::function_3a823ae4
// Checksum 0x23cf1427, Offset: 0xd98
// Size: 0x166
function get_near_boards(windows) {
    players = getplayers();
    boards_near_players = [];
    for (j = 0; j < windows.size; j++) {
        close = 0;
        for (i = 0; i < players.size; i++) {
            origin = undefined;
            if (isdefined(windows[j].zbarrier)) {
                origin = windows[j].zbarrier.origin;
            } else {
                origin = windows[j].origin;
            }
            if (distancesquared(players[i].origin, origin) <= 562500) {
                close = 1;
                break;
            }
        }
        if (close) {
            boards_near_players[boards_near_players.size] = windows[j];
        }
    }
    return boards_near_players;
}

// Namespace zm_powerup_carpenter
// Params 1, eflags: 0x1 linked
// namespace_a5ab9a0e<file_0>::function_50224fab
// Checksum 0x6ef7041a, Offset: 0xf08
// Size: 0x166
function get_far_boards(windows) {
    players = getplayers();
    boards_far_from_players = [];
    for (j = 0; j < windows.size; j++) {
        close = 0;
        for (i = 0; i < players.size; i++) {
            origin = undefined;
            if (isdefined(windows[j].zbarrier)) {
                origin = windows[j].zbarrier.origin;
            } else {
                origin = windows[j].origin;
            }
            if (distancesquared(players[i].origin, origin) >= 562500) {
                close = 1;
                break;
            }
        }
        if (close) {
            boards_far_from_players[boards_far_from_players.size] = windows[j];
        }
    }
    return boards_far_from_players;
}

// Namespace zm_powerup_carpenter
// Params 2, eflags: 0x1 linked
// namespace_a5ab9a0e<file_0>::function_9ce998a0
// Checksum 0xea39f32e, Offset: 0x1078
// Size: 0x2ee
function repair_far_boards(barriers, upgrade) {
    for (i = 0; i < barriers.size; i++) {
        barrier = barriers[i];
        if (zm_utility::all_chunks_intact(barrier, barrier.barrier_chunks)) {
            continue;
        }
        if (isdefined(barrier.zbarrier)) {
            a_pieces = barrier.zbarrier getzbarrierpieceindicesinstate("open");
            if (isdefined(a_pieces)) {
                for (xx = 0; xx < a_pieces.size; xx++) {
                    chunk = a_pieces[xx];
                    if (upgrade) {
                        barrier.zbarrier zbarrierpieceuseupgradedmodel(chunk);
                        barrier.zbarrier.chunk_health[chunk] = barrier.zbarrier getupgradedpiecenumlives(chunk);
                        continue;
                    }
                    barrier.zbarrier zbarrierpieceusedefaultmodel(chunk);
                    barrier.zbarrier.chunk_health[chunk] = 0;
                }
            }
            for (x = 0; x < barrier.zbarrier getnumzbarrierpieces(); x++) {
                barrier.zbarrier setzbarrierpiecestate(x, "closed");
                barrier.zbarrier showzbarrierpiece(x);
            }
        }
        if (isdefined(barrier.clip)) {
            barrier.clip triggerenable(1);
            barrier.clip disconnectpaths();
        } else {
            zm_blockers::blocker_disconnect_paths(barrier.neg_start, barrier.neg_end);
        }
        if (i % 4 == 0) {
            util::wait_network_frame();
        }
    }
}

// Namespace zm_powerup_carpenter
// Params 0, eflags: 0x1 linked
// namespace_a5ab9a0e<file_0>::function_8ebc0f8c
// Checksum 0xe0d6046e, Offset: 0x1370
// Size: 0x24
function func_should_drop_carpenter() {
    if (get_num_window_destroyed() < 5) {
        return false;
    }
    return true;
}

// Namespace zm_powerup_carpenter
// Params 0, eflags: 0x1 linked
// namespace_a5ab9a0e<file_0>::function_280a3281
// Checksum 0x37bb78a1, Offset: 0x13a0
// Size: 0x8c
function get_num_window_destroyed() {
    num = 0;
    for (i = 0; i < level.exterior_goals.size; i++) {
        if (zm_utility::all_chunks_destroyed(level.exterior_goals[i], level.exterior_goals[i].barrier_chunks)) {
            num += 1;
        }
    }
    return num;
}

