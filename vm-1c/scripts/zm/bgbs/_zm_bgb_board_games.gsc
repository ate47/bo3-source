#using scripts/zm/_zm_blockers;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_board_games;

// Namespace zm_bgb_board_games
// Params 0, eflags: 0x2
// namespace_93a0c6cf<file_0>::function_2dc19561
// Checksum 0x939e567d, Offset: 0x1d0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_board_games", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_board_games
// Params 0, eflags: 0x1 linked
// namespace_93a0c6cf<file_0>::function_8c87d8eb
// Checksum 0x76e19a19, Offset: 0x210
// Size: 0x5c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_board_games", "rounds", 5, &enable, &disable, undefined);
}

// Namespace zm_bgb_board_games
// Params 0, eflags: 0x1 linked
// namespace_93a0c6cf<file_0>::function_bae40a28
// Checksum 0x17e56e38, Offset: 0x278
// Size: 0x1c
function enable() {
    self thread function_7b627622();
}

// Namespace zm_bgb_board_games
// Params 0, eflags: 0x1 linked
// namespace_93a0c6cf<file_0>::function_54bdb053
// Checksum 0x99ec1590, Offset: 0x2a0
// Size: 0x4
function disable() {
    
}

// Namespace zm_bgb_board_games
// Params 0, eflags: 0x1 linked
// namespace_93a0c6cf<file_0>::function_7b627622
// Checksum 0x418d6917, Offset: 0x2b0
// Size: 0x78
function function_7b627622() {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"bgb_update");
    while (true) {
        s_window = self waittill(#"boarding_window");
        self bgb::do_one_shot_use();
        self thread function_d5ed5165(s_window);
    }
}

// Namespace zm_bgb_board_games
// Params 1, eflags: 0x1 linked
// namespace_93a0c6cf<file_0>::function_d5ed5165
// Checksum 0x8481ee4b, Offset: 0x330
// Size: 0x2dc
function function_d5ed5165(s_window) {
    carp_ent = spawn("script_origin", (0, 0, 0));
    carp_ent playloopsound("evt_carpenter");
    num_chunks_checked = 0;
    while (true) {
        if (zm_utility::all_chunks_intact(s_window, s_window.barrier_chunks)) {
            break;
        }
        chunk = zm_utility::get_random_destroyed_chunk(s_window, s_window.barrier_chunks);
        if (!isdefined(chunk)) {
            break;
        }
        s_window thread zm_blockers::replace_chunk(s_window, chunk, undefined, 0, 1);
        last_repaired_chunk = chunk;
        if (isdefined(s_window.clip)) {
            s_window.clip triggerenable(1);
            s_window.clip disconnectpaths();
        } else {
            zm_blockers::blocker_disconnect_paths(s_window.neg_start, s_window.neg_end);
        }
        util::wait_network_frame();
        num_chunks_checked++;
        if (num_chunks_checked >= 20) {
            break;
        }
    }
    if (isdefined(s_window.zbarrier)) {
        if (isdefined(last_repaired_chunk)) {
            while (s_window.zbarrier getzbarrierpiecestate(last_repaired_chunk) == "closing") {
                wait(0.05);
            }
            if (isdefined(s_window._post_carpenter_callback)) {
                s_window [[ s_window._post_carpenter_callback ]]();
            }
        }
    } else {
        while (isdefined(last_repaired_chunk) && last_repaired_chunk.state == "mid_repair") {
            wait(0.05);
        }
    }
    carp_ent stoploopsound(1);
    carp_ent playsoundwithnotify("evt_carpenter_end", "sound_done");
    carp_ent waittill(#"sound_done");
    carp_ent delete();
}

