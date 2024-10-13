#using scripts/zm/zm_tomb_utility;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_tomb_chamber;

// Namespace zm_tomb_chamber
// Params 0, eflags: 0x2
// Checksum 0x6822ca56, Offset: 0x270
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_tomb_chamber", &__init__, undefined, undefined);
}

// Namespace zm_tomb_chamber
// Params 0, eflags: 0x1 linked
// Checksum 0x720f42cf, Offset: 0x2b0
// Size: 0x34
function __init__() {
    clientfield::register("scriptmover", "divider_fx", 21000, 1, "counter");
}

// Namespace zm_tomb_chamber
// Params 0, eflags: 0x1 linked
// Checksum 0x90f11457, Offset: 0x2f0
// Size: 0x20c
function main() {
    level thread function_ad70490e();
    var_373dc638 = getentarray("chamber_wall", "script_noteworthy");
    foreach (var_ec523dd5 in var_373dc638) {
        var_ec523dd5.down_origin = var_ec523dd5.origin;
        var_ec523dd5.up_origin = (var_ec523dd5.origin[0], var_ec523dd5.origin[1], var_ec523dd5.origin[2] + 1000);
    }
    level.var_b9b4b136 = 0;
    level flag::wait_till("start_zombie_round_logic");
    wait 3;
    foreach (var_ec523dd5 in var_373dc638) {
        var_ec523dd5 moveto(var_ec523dd5.up_origin, 0.05);
        var_ec523dd5 connectpaths();
    }
    /#
        level thread function_9bc87ad2();
    #/
}

/#

    // Namespace zm_tomb_chamber
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1c921373, Offset: 0x508
    // Size: 0xbc
    function function_9bc87ad2() {
        setdvar("<dev string:x28>", 5);
        adddebugcommand("<dev string:x35>");
        adddebugcommand("<dev string:x6b>");
        adddebugcommand("<dev string:xa0>");
        adddebugcommand("<dev string:xdb>");
        adddebugcommand("<dev string:x112>");
        level thread function_761dcf3c();
    }

    // Namespace zm_tomb_chamber
    // Params 0, eflags: 0x1 linked
    // Checksum 0xb60e131, Offset: 0x5d0
    // Size: 0x90
    function function_761dcf3c() {
        while (true) {
            if (getdvarint("<dev string:x28>") != 5) {
                function_ea272f42(getdvarint("<dev string:x28>"));
                setdvar("<dev string:x28>", 5);
            }
            wait 0.05;
        }
    }

#/

// Namespace zm_tomb_chamber
// Params 3, eflags: 0x1 linked
// Checksum 0x6da7302c, Offset: 0x668
// Size: 0x52
function function_19a40a5(val, min, max) {
    if (val < min) {
        return min;
    }
    if (val > max) {
        return max;
    }
    return val;
}

// Namespace zm_tomb_chamber
// Params 1, eflags: 0x1 linked
// Checksum 0x8fd2d0fa, Offset: 0x6c8
// Size: 0x170
function function_ea272f42(var_b5f6f4e4) {
    if (var_b5f6f4e4 == level.var_b9b4b136) {
        return;
    }
    var_56a50043 = undefined;
    var_d8598e0 = undefined;
    playsoundatposition("zmb_chamber_wallchange", (10342, -7921, -272));
    var_373dc638 = getentarray("chamber_wall", "script_noteworthy");
    foreach (var_ec523dd5 in var_373dc638) {
        if (var_ec523dd5.script_int == var_b5f6f4e4) {
            var_ec523dd5 thread function_ce7a61a4();
            continue;
        }
        if (var_ec523dd5.script_int == level.var_b9b4b136) {
            var_ec523dd5 thread function_6780a3d7();
        }
    }
    level.var_b9b4b136 = var_b5f6f4e4;
}

// Namespace zm_tomb_chamber
// Params 0, eflags: 0x1 linked
// Checksum 0xc111772a, Offset: 0x840
// Size: 0xb4
function function_55f62409() {
    a_players = getplayers();
    foreach (e_player in a_players) {
        if (function_34b281af(e_player.origin)) {
            return true;
        }
    }
    return false;
}

// Namespace zm_tomb_chamber
// Params 1, eflags: 0x1 linked
// Checksum 0x863250c1, Offset: 0x900
// Size: 0xac
function function_34b281af(v_origin) {
    if (!isdefined(level.var_a2bf8bd9)) {
        level.var_a2bf8bd9 = struct::get("chamber_center", "targetname");
        level.var_a2bf8bd9.radius_sq = level.var_a2bf8bd9.script_float * level.var_a2bf8bd9.script_float;
    }
    return distance2dsquared(level.var_a2bf8bd9.origin, v_origin) < level.var_a2bf8bd9.radius_sq;
}

// Namespace zm_tomb_chamber
// Params 0, eflags: 0x1 linked
// Checksum 0xcfe789cc, Offset: 0x9b8
// Size: 0x1d0
function function_ad70490e() {
    level flag::wait_till("start_zombie_round_logic");
    var_26fcd3c8 = array(1, 2, 3, 4);
    level endon(#"hash_9e19b240");
    for (var_df79d9d7 = undefined; true; var_df79d9d7 = var_f48065fd) {
        while (!function_55f62409()) {
            wait 1;
        }
        level flag::wait_till("any_crystal_picked_up");
        n_round = function_19a40a5(level.round_number, 10, 30);
        var_62e0c521 = (n_round - 10) / (30 - 10);
        var_41718f9 = lerpfloat(15, 5, var_62e0c521);
        var_f48065fd = array::random(var_26fcd3c8);
        arrayremovevalue(var_26fcd3c8, var_f48065fd, 0);
        if (isdefined(var_df79d9d7)) {
            var_26fcd3c8[var_26fcd3c8.size] = var_df79d9d7;
        }
        function_ea272f42(var_f48065fd);
        wait var_41718f9;
    }
}

// Namespace zm_tomb_chamber
// Params 0, eflags: 0x1 linked
// Checksum 0x68444f8b, Offset: 0xb90
// Size: 0x44
function function_6780a3d7() {
    self moveto(self.up_origin, 1);
    self waittill(#"movedone");
    self connectpaths();
}

// Namespace zm_tomb_chamber
// Params 0, eflags: 0x1 linked
// Checksum 0x5b5eb426, Offset: 0xbe0
// Size: 0x84
function function_ce7a61a4() {
    self moveto(self.down_origin, 1);
    self waittill(#"movedone");
    zm_tomb_utility::function_d0dc88b2(2, 0.1);
    self clientfield::increment("divider_fx");
    self disconnectpaths();
}

// Namespace zm_tomb_chamber
// Params 2, eflags: 0x0
// Checksum 0x944aba54, Offset: 0xc70
// Size: 0x9c
function function_f1a5312(a_items, item) {
    var_1cb55aeb = undefined;
    if (!isdefined(item)) {
        item = a_items[a_items.size - 1];
    }
    while (!(isdefined(var_1cb55aeb) && var_1cb55aeb)) {
        a_items = array::randomize(a_items);
        if (a_items[0] != item) {
            var_1cb55aeb = 1;
        }
        wait 0.05;
    }
    return a_items;
}

// Namespace zm_tomb_chamber
// Params 0, eflags: 0x1 linked
// Checksum 0x2db07a5, Offset: 0xd18
// Size: 0x218
function function_6be58d92() {
    self endon(#"death");
    player = getplayers()[0];
    dist_zombie = 0;
    dist_player = 0;
    dest = 0;
    away = vectornormalize(self.origin - player.origin);
    endpos = self.origin + vectorscale(away, 600);
    locs = array::randomize(level.zm_loc_types["wait_location"]);
    for (i = 0; i < locs.size; i++) {
        dist_zombie = distancesquared(locs[i].origin, endpos);
        dist_player = distancesquared(locs[i].origin, player.origin);
        if (dist_zombie < dist_player) {
            dest = i;
            break;
        }
    }
    self notify(#"stop_find_flesh");
    self notify(#"zombie_acquire_enemy");
    if (isdefined(locs[dest])) {
        self setgoalpos(locs[dest].origin);
    }
    self.var_a8e97efe = 1;
    level flag::wait_till("player_active_in_chamber");
    self.var_a8e97efe = 0;
}

// Namespace zm_tomb_chamber
// Params 0, eflags: 0x1 linked
// Checksum 0xb5071755, Offset: 0xf38
// Size: 0xc6
function function_c9cf1178() {
    zombies = getaiteamarray(level.zombie_team);
    for (i = 0; i < zombies.size; i++) {
        if (isdefined(zombies[i].var_a8e97efe) && zombies[i].var_a8e97efe) {
            continue;
        }
        if (!function_34b281af(zombies[i].origin)) {
            continue;
        }
        zombies[i] thread function_6be58d92();
    }
}

// Namespace zm_tomb_chamber
// Params 0, eflags: 0x1 linked
// Checksum 0xaa700fb9, Offset: 0x1008
// Size: 0x120
function function_a2f4c20c() {
    a_players = getplayers();
    foreach (e_player in a_players) {
        if (e_player laststand::player_is_in_laststand()) {
            continue;
        }
        if (isdefined(e_player.ignoreme) && (isdefined(e_player.var_eac947e3) && e_player.var_eac947e3 || e_player.ignoreme)) {
            continue;
        }
        if (!function_34b281af(e_player.origin)) {
            continue;
        }
        return true;
    }
    return false;
}

// Namespace zm_tomb_chamber
// Params 0, eflags: 0x1 linked
// Checksum 0xd97ded6c, Offset: 0x1130
// Size: 0x2c
function function_cd5b3a70() {
    if (function_34b281af(self.origin)) {
        return 1;
    }
    return 0;
}

// Namespace zm_tomb_chamber
// Params 0, eflags: 0x1 linked
// Checksum 0xcf2751a9, Offset: 0x1168
// Size: 0xd0
function function_21560ef4() {
    level flag::init("player_active_in_chamber");
    level flag::wait_till("start_zombie_round_logic");
    while (true) {
        wait 1;
        if (function_55f62409()) {
            if (function_a2f4c20c()) {
                level flag::set("player_active_in_chamber");
                continue;
            }
            level flag::clear("player_active_in_chamber");
            function_c9cf1178();
        }
    }
}

