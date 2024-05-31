#using scripts/zm/_zm_zonemgr;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_c71bfefb;

// Namespace namespace_c71bfefb
// Params 0, eflags: 0x2
// Checksum 0x5d309f37, Offset: 0x298
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_stalingrad_ambient", &__init__, &__main__, undefined);
}

// Namespace namespace_c71bfefb
// Params 0, eflags: 0x1 linked
// Checksum 0xd151ed8e, Offset: 0x2e0
// Size: 0xcc
function __init__() {
    level flag::init("ambient_mortar_fire_on");
    clientfield::register("scriptmover", "ambient_mortar_strike", 12000, 2, "int");
    clientfield::register("scriptmover", "ambient_artillery_strike", 12000, 2, "int");
    clientfield::register("world", "power_on_level", 12000, 1, "int");
    level thread function_8c898920();
}

// Namespace namespace_c71bfefb
// Params 0, eflags: 0x1 linked
// Checksum 0x45ce0ef6, Offset: 0x3b8
// Size: 0x1c
function __main__() {
    level thread wait_for_power();
}

// Namespace namespace_c71bfefb
// Params 0, eflags: 0x1 linked
// Checksum 0xb4cb2b8f, Offset: 0x3e0
// Size: 0x1fe
function function_46a16b31() {
    level.var_10752e7a = [];
    var_10752e7a = struct::get_array("ambient_mortar", "targetname");
    foreach (var_b058183b in var_10752e7a) {
        str_location = var_b058183b.script_string;
        if (!isdefined(level.var_10752e7a[str_location])) {
            level.var_10752e7a[str_location] = [];
        }
        if (!isdefined(level.var_10752e7a[str_location])) {
            level.var_10752e7a[str_location] = [];
        } else if (!isarray(level.var_10752e7a[str_location])) {
            level.var_10752e7a[str_location] = array(level.var_10752e7a[str_location]);
        }
        level.var_10752e7a[str_location][level.var_10752e7a[str_location].size] = var_b058183b;
    }
    level.var_2b8ea588 = [];
    for (i = 0; i < 6; i++) {
        level.var_2b8ea588[i] = util::spawn_model("tag_origin", (0, 0, 0));
        level.var_2b8ea588[i].b_in_use = 0;
    }
}

// Namespace namespace_c71bfefb
// Params 0, eflags: 0x1 linked
// Checksum 0xd6ed29ec, Offset: 0x5e8
// Size: 0x348
function function_8c898920() {
    level flag::wait_till("all_players_spawned");
    if (getdvarint("splitscreen_playerCount") >= 2) {
        return;
    }
    level flag::set("ambient_mortar_fire_on");
    function_46a16b31();
    wait(randomfloatrange(20, 30));
    while (true) {
        if (!level flag::get("ambient_mortar_fire_on")) {
            level flag::wait_till("ambient_mortar_fire_on");
        }
        do {
            var_165e92cc = array::random(level.activeplayers);
            str_zone = var_165e92cc zm_zonemgr::get_player_zone();
            if (isdefined(str_zone)) {
                var_32db8f92 = strtok(str_zone, "_");
                str_zone = var_32db8f92[0];
                if (str_zone == "powered") {
                    if (var_32db8f92[2] == "A") {
                        str_zone = "red";
                    } else {
                        str_zone = "yellow";
                    }
                }
            }
            wait(0.05);
        } while (!isdefined(str_zone) || !isdefined(level.var_10752e7a[str_zone]));
        if (str_zone == "pavlovs" || str_zone == "alley") {
            var_e3975fbf = 1;
        } else {
            var_e3975fbf = 0;
        }
        var_89d001a3 = randomintrange(10, 15);
        for (i = 0; i < var_89d001a3; i++) {
            var_620fe12a = function_7af373ba(str_zone);
            if (isdefined(var_620fe12a)) {
                var_620fe12a thread function_8affee60(var_e3975fbf);
            }
            wait(randomfloatrange(0.5, 1.5));
        }
        if (flag::get("nikolai_start") && (!flag::get("nikolai_start") || flag::get("nikolai_complete"))) {
            level function_20bdb71();
        }
        wait(randomfloatrange(45, 60));
    }
}

// Namespace namespace_c71bfefb
// Params 0, eflags: 0x1 linked
// Checksum 0xb1812fce, Offset: 0x938
// Size: 0x42
function function_20bdb71() {
    level endon(#"hash_cb701c27");
    for (i = 0; i < 2; i++) {
        level waittill(#"start_of_round");
    }
}

// Namespace namespace_c71bfefb
// Params 1, eflags: 0x1 linked
// Checksum 0xe2d1a99f, Offset: 0x988
// Size: 0x16c
function function_7af373ba(str_zone) {
    var_b8f2d177 = [];
    var_d8f8470c = arraycopy(level.var_10752e7a[str_zone]);
    var_1bbdbab3 = 0;
    while (!var_b8f2d177.size) {
        foreach (var_b058183b in var_d8f8470c) {
            if (!isdefined(var_b058183b.b_claimed) || var_1bbdbab3) {
                var_b058183b.b_claimed = 0;
            }
            if (!var_b058183b.b_claimed) {
                array::add(var_b8f2d177, var_b058183b, 0);
            }
        }
        if (!var_b8f2d177.size) {
            var_1bbdbab3 = 1;
        }
        wait(0.05);
    }
    var_b058183b = array::random(var_b8f2d177);
    return var_b058183b;
}

// Namespace namespace_c71bfefb
// Params 1, eflags: 0x1 linked
// Checksum 0x3b6a51c1, Offset: 0xb00
// Size: 0x160
function function_8affee60(var_e3975fbf) {
    i = 0;
    while (level.var_2b8ea588[i].b_in_use == 1) {
        i++;
        if (i == level.var_2b8ea588.size) {
            i = 0;
            wait(0.05);
        }
    }
    level.var_2b8ea588[i].origin = self.origin;
    level.var_2b8ea588[i].b_in_use = 1;
    if (var_e3975fbf) {
        var_efccacc4 = "ambient_mortar_strike";
    } else {
        var_efccacc4 = "ambient_artillery_strike";
    }
    var_23919be6 = self.script_int + 1;
    level.var_2b8ea588[i] clientfield::set(var_efccacc4, var_23919be6);
    wait(3);
    level.var_2b8ea588[i] clientfield::set(var_efccacc4, 0);
    level.var_2b8ea588[i].b_in_use = 0;
}

// Namespace namespace_c71bfefb
// Params 0, eflags: 0x1 linked
// Checksum 0x57b82cd3, Offset: 0xc68
// Size: 0x44
function wait_for_power() {
    level flag::wait_till("power_on");
    level clientfield::set("power_on_level", 1);
}

