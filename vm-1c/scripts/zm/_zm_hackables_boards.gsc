#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_equip_hacker;
#using scripts/zm/_zm_blockers;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_b1d3fbb7;

// Namespace namespace_b1d3fbb7
// Params 0, eflags: 0x1 linked
// Checksum 0x4fb0f4fe, Offset: 0x190
// Size: 0x296
function function_22bc5906() {
    windows = struct::get_array("exterior_goal", "targetname");
    for (i = 0; i < windows.size; i++) {
        window = windows[i];
        struct = spawnstruct();
        spot = window;
        if (isdefined(window.trigger_location)) {
            spot = window.trigger_location;
        }
        org = zm_utility::groundpos(spot.origin) + (0, 0, 4);
        r = 96;
        h = 96;
        if (isdefined(spot.radius)) {
            r = spot.radius;
        }
        if (isdefined(spot.height)) {
            h = spot.height;
        }
        struct.origin = org + (0, 0, 48);
        struct.radius = r;
        struct.height = h;
        struct.script_float = 2;
        struct.script_int = 0;
        struct.window = window;
        struct.var_39787651 = 1;
        struct.var_9aa3be3b = 1;
        struct.var_e984946e = 0.7;
        struct.var_ae10f09 = 1;
        struct.var_69fde2c9 = 0;
        struct.var_306a0884 = 0;
        zm_equip_hacker::function_66764564(struct, &function_8550d095, &function_5c288522);
    }
}

// Namespace namespace_b1d3fbb7
// Params 1, eflags: 0x1 linked
// Checksum 0x1e06e7dd, Offset: 0x430
// Size: 0x364
function function_8550d095(hacker) {
    zm_equip_hacker::function_fcbe2f17(self);
    num_chunks_checked = 0;
    last_repaired_chunk = undefined;
    if (self.var_69fde2c9 != level.round_number) {
        self.var_69fde2c9 = level.round_number;
        self.var_306a0884 = 0;
    }
    self.var_306a0884++;
    if (self.var_306a0884 < 3) {
        hacker zm_score::add_to_player_score(100);
    } else {
        cost = int(min(300, hacker.score));
        if (cost) {
            hacker zm_score::minus_to_player_score(cost);
        }
    }
    while (true) {
        if (zm_utility::all_chunks_intact(self.window, self.window.barrier_chunks)) {
            break;
        }
        chunk = zm_utility::get_random_destroyed_chunk(self.window, self.window.barrier_chunks);
        if (!isdefined(chunk)) {
            break;
        }
        self.window thread zm_blockers::replace_chunk(self.window, chunk, undefined, 0, 1);
        last_repaired_chunk = chunk;
        if (isdefined(self.clip)) {
            self.window.clip triggerenable(1);
            self.window.clip disconnectpaths();
        } else {
            zm_blockers::blocker_disconnect_paths(self.window.neg_start, self.window.neg_end);
        }
        util::wait_network_frame();
        num_chunks_checked++;
        if (num_chunks_checked >= 20) {
            break;
        }
    }
    if (isdefined(self.window.zbarrier)) {
        if (isdefined(last_repaired_chunk)) {
            while (self.window.zbarrier getzbarrierpiecestate(last_repaired_chunk) == "closing") {
                wait 0.05;
            }
        }
    } else {
        while (isdefined(last_repaired_chunk) && last_repaired_chunk.state == "mid_repair") {
            wait 0.05;
        }
    }
    zm_equip_hacker::function_66764564(self, &function_8550d095, &function_5c288522);
    self.window notify(#"blocker_hacked");
    self.window notify(#"no valid boards");
}

// Namespace namespace_b1d3fbb7
// Params 1, eflags: 0x1 linked
// Checksum 0xde0c4af9, Offset: 0x7a0
// Size: 0x66
function function_5c288522(player) {
    if (zm_utility::all_chunks_intact(self.window, self.window.barrier_chunks) || zm_utility::no_valid_repairable_boards(self.window, self.window.barrier_chunks)) {
        return false;
    }
    return true;
}

