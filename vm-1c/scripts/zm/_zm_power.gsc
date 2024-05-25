#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_blockers;
#using scripts/zm/_util;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_power;

// Namespace zm_power
// Params 0, eflags: 0x2
// Checksum 0x9d24991, Offset: 0x348
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_power", &__init__, &__main__, undefined);
}

// Namespace zm_power
// Params 0, eflags: 0x1 linked
// Checksum 0x1c217daa, Offset: 0x390
// Size: 0x1c
function __init__() {
    level.powered_items = [];
    level.local_power = [];
}

// Namespace zm_power
// Params 0, eflags: 0x1 linked
// Checksum 0x288a06e2, Offset: 0x3b8
// Size: 0x44
function __main__() {
    thread standard_powered_items();
    level thread electric_switch_init();
    /#
        thread debug_powered_items();
    #/
}

/#

    // Namespace zm_power
    // Params 0, eflags: 0x1 linked
    // Checksum 0xefb921af, Offset: 0x408
    // Size: 0xf0
    function debug_powered_items() {
        while (true) {
            if (getdvarint("zmb_turn_on")) {
                if (isdefined(level.local_power)) {
                    foreach (localpower in level.local_power) {
                        circle(localpower.origin, localpower.radius, (1, 0, 0), 0, 1, 1);
                    }
                }
            }
            wait(0.05);
        }
    }

#/

// Namespace zm_power
// Params 0, eflags: 0x1 linked
// Checksum 0xfe37e5d, Offset: 0x500
// Size: 0x84
function electric_switch_init() {
    trigs = getentarray("use_elec_switch", "targetname");
    if (isdefined(level.temporary_power_switch_logic)) {
        array::thread_all(trigs, level.temporary_power_switch_logic, trigs);
        return;
    }
    array::thread_all(trigs, &electric_switch, trigs);
}

// Namespace zm_power
// Params 1, eflags: 0x1 linked
// Checksum 0x2d686987, Offset: 0x590
// Size: 0x558
function electric_switch(var_5aaf79b7) {
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(self.target)) {
        ent_parts = getentarray(self.target, "targetname");
        struct_parts = struct::get_array(self.target, "targetname");
        foreach (ent in ent_parts) {
            if (isdefined(ent.script_noteworthy) && ent.script_noteworthy == "elec_switch") {
                master_switch = ent;
                master_switch notsolid();
            }
        }
        foreach (struct in struct_parts) {
            if (isdefined(struct.script_noteworthy) && struct.script_noteworthy == "elec_switch_fx") {
                fx_pos = struct;
            }
        }
    }
    while (isdefined(self)) {
        self sethintstring(%ZOMBIE_ELECTRIC_SWITCH);
        self setvisibletoall();
        user = self waittill(#"trigger");
        self setinvisibletoall();
        if (isdefined(master_switch)) {
            master_switch rotateroll(-90, 0.3);
            master_switch playsound("zmb_switch_flip");
        }
        power_zone = undefined;
        if (isdefined(self.script_int)) {
            power_zone = self.script_int;
        }
        level thread zm_perks::perk_unpause_all_perks(power_zone);
        if (isdefined(master_switch)) {
            master_switch waittill(#"rotatedone");
            playfx(level._effect["switch_sparks"], fx_pos.origin);
            master_switch playsound("zmb_turn_on");
        }
        level turn_power_on_and_open_doors(power_zone);
        switchentnum = self getentitynumber();
        if (isdefined(switchentnum) && isdefined(user)) {
            user recordmapevent(17, gettime(), user.origin, level.round_number, switchentnum);
        }
        if (!isdefined(self.script_noteworthy) || self.script_noteworthy != "allow_power_off") {
            self delete();
            return;
        }
        self sethintstring(%ZOMBIE_ELECTRIC_SWITCH_OFF);
        self setvisibletoall();
        user = self waittill(#"trigger");
        self setinvisibletoall();
        if (isdefined(master_switch)) {
            master_switch rotateroll(90, 0.3);
            master_switch playsound("zmb_switch_flip");
        }
        level thread zm_perks::perk_pause_all_perks(power_zone);
        if (isdefined(master_switch)) {
            master_switch waittill(#"rotatedone");
        }
        if (isdefined(switchentnum) && isdefined(user)) {
            user recordmapevent(18, gettime(), user.origin, level.round_number, switchentnum);
        }
        level turn_power_off_and_close_doors(power_zone);
    }
}

// Namespace zm_power
// Params 0, eflags: 0x1 linked
// Checksum 0xf25715a, Offset: 0xaf0
// Size: 0x80
function watch_global_power() {
    while (true) {
        level flag::wait_till("power_on");
        level thread set_global_power(1);
        level flag::wait_till_clear("power_on");
        level thread set_global_power(0);
    }
}

// Namespace zm_power
// Params 0, eflags: 0x1 linked
// Checksum 0xb9327cee, Offset: 0xb78
// Size: 0x394
function standard_powered_items() {
    level flag::wait_till("start_zombie_round_logic");
    var_3be8a3b8 = getentarray("zombie_vending", "targetname");
    foreach (trigger in var_3be8a3b8) {
        powered_on = zm_perks::get_perk_machine_start_state(trigger.script_noteworthy);
        powered_perk = add_powered_item(&perk_power_on, &perk_power_off, &perk_range, &cost_low_if_local, 0, powered_on, trigger);
        if (isdefined(trigger.script_int)) {
            powered_perk thread zone_controlled_perk(trigger.script_int);
        }
    }
    zombie_doors = getentarray("zombie_door", "targetname");
    foreach (door in zombie_doors) {
        if (door.script_noteworthy == "electric_door" || isdefined(door.script_noteworthy) && door.script_noteworthy == "electric_buyable_door") {
            add_powered_item(&door_power_on, &door_power_off, &door_range, &cost_door, 0, 0, door);
            continue;
        }
        if (isdefined(door.script_noteworthy) && door.script_noteworthy == "local_electric_door") {
            power_sources = 0;
            if (!(isdefined(level.power_local_doors_globally) && level.power_local_doors_globally)) {
                power_sources = 1;
            }
            add_powered_item(&door_local_power_on, &door_local_power_off, &door_range, &cost_door, power_sources, 0, door);
        }
    }
    thread watch_global_power();
}

// Namespace zm_power
// Params 1, eflags: 0x1 linked
// Checksum 0x5178115d, Offset: 0xf18
// Size: 0x90
function zone_controlled_perk(zone) {
    while (true) {
        power_flag = "power_on" + zone;
        level flag::wait_till(power_flag);
        self thread perk_power_on();
        level flag::wait_till_clear(power_flag);
        self thread perk_power_off();
    }
}

// Namespace zm_power
// Params 7, eflags: 0x1 linked
// Checksum 0xa4ee2ab8, Offset: 0xfb0
// Size: 0x136
function add_powered_item(power_on_func, power_off_func, range_func, cost_func, power_sources, self_powered, target) {
    powered = spawnstruct();
    powered.power_on_func = power_on_func;
    powered.power_off_func = power_off_func;
    powered.range_func = range_func;
    powered.power_sources = power_sources;
    powered.self_powered = self_powered;
    powered.target = target;
    powered.cost_func = cost_func;
    powered.power = self_powered;
    powered.powered_count = self_powered;
    powered.depowered_count = 0;
    level.powered_items[level.powered_items.size] = powered;
    return powered;
}

// Namespace zm_power
// Params 1, eflags: 0x1 linked
// Checksum 0x4d2ff890, Offset: 0x10f0
// Size: 0x2c
function remove_powered_item(powered) {
    arrayremovevalue(level.powered_items, powered, 0);
}

// Namespace zm_power
// Params 7, eflags: 0x0
// Checksum 0x59ebe7c1, Offset: 0x1128
// Size: 0x1c8
function add_temp_powered_item(power_on_func, power_off_func, range_func, cost_func, power_sources, self_powered, target) {
    powered = add_powered_item(power_on_func, power_off_func, range_func, cost_func, power_sources, self_powered, target);
    if (isdefined(level.local_power)) {
        foreach (localpower in level.local_power) {
            if (powered [[ powered.range_func ]](1, localpower.origin, localpower.radius)) {
                powered change_power(1, localpower.origin, localpower.radius);
                if (!isdefined(localpower.added_list)) {
                    localpower.added_list = [];
                }
                localpower.added_list[localpower.added_list.size] = powered;
            }
        }
    }
    thread watch_temp_powered_item(powered);
    return powered;
}

// Namespace zm_power
// Params 1, eflags: 0x1 linked
// Checksum 0xb11c6e5, Offset: 0x12f8
// Size: 0x12a
function watch_temp_powered_item(powered) {
    powered.target waittill(#"death");
    remove_powered_item(powered);
    if (isdefined(level.local_power)) {
        foreach (localpower in level.local_power) {
            if (isdefined(localpower.added_list)) {
                arrayremovevalue(localpower.added_list, powered, 0);
            }
            if (isdefined(localpower.enabled_list)) {
                arrayremovevalue(localpower.enabled_list, powered, 0);
            }
        }
    }
}

// Namespace zm_power
// Params 3, eflags: 0x1 linked
// Checksum 0x64cc3cee, Offset: 0x1430
// Size: 0xec
function change_power_in_radius(delta, origin, radius) {
    changed_list = [];
    for (i = 0; i < level.powered_items.size; i++) {
        powered = level.powered_items[i];
        if (powered.power_sources != 2) {
            if (powered [[ powered.range_func ]](delta, origin, radius)) {
                powered change_power(delta, origin, radius);
                changed_list[changed_list.size] = powered;
            }
        }
    }
    return changed_list;
}

// Namespace zm_power
// Params 3, eflags: 0x1 linked
// Checksum 0x522da944, Offset: 0x1528
// Size: 0xa4
function change_power(delta, origin, radius) {
    if (delta > 0) {
        if (!self.power) {
            self.power = 1;
            self [[ self.power_on_func ]](origin, radius);
        }
        self.powered_count++;
        return;
    }
    if (delta < 0) {
        if (self.power) {
            self.power = 0;
            self [[ self.power_off_func ]](origin, radius);
        }
        self.depowered_count++;
    }
}

// Namespace zm_power
// Params 4, eflags: 0x1 linked
// Checksum 0xffb25b9c, Offset: 0x15d8
// Size: 0x86
function revert_power_to_list(delta, origin, radius, powered_list) {
    for (i = 0; i < powered_list.size; i++) {
        powered = powered_list[i];
        powered revert_power(delta, origin, radius);
    }
}

// Namespace zm_power
// Params 4, eflags: 0x1 linked
// Checksum 0xb1bf899b, Offset: 0x1668
// Size: 0x130
function revert_power(delta, origin, radius, powered_list) {
    if (delta > 0) {
        self.depowered_count--;
        assert(self.depowered_count >= 0, "zmb_turn_on");
        if (self.depowered_count == 0 && self.powered_count > 0 && !self.power) {
            self.power = 1;
            self [[ self.power_on_func ]](origin, radius);
        }
        return;
    }
    if (delta < 0) {
        self.powered_count--;
        assert(self.powered_count >= 0, "zmb_turn_on");
        if (self.powered_count == 0 && self.power) {
            self.power = 0;
            self [[ self.power_off_func ]](origin, radius);
        }
    }
}

// Namespace zm_power
// Params 2, eflags: 0x0
// Checksum 0x51c24384, Offset: 0x17a0
// Size: 0xda
function add_local_power(origin, radius) {
    localpower = spawnstruct();
    println("zmb_turn_on" + origin + "zmb_turn_on" + radius + "zmb_turn_on");
    localpower.origin = origin;
    localpower.radius = radius;
    localpower.enabled_list = change_power_in_radius(1, origin, radius);
    level.local_power[level.local_power.size] = localpower;
    return localpower;
}

// Namespace zm_power
// Params 2, eflags: 0x0
// Checksum 0xa5430c8d, Offset: 0x1888
// Size: 0x1dc
function move_local_power(localpower, origin) {
    changed_list = [];
    for (i = 0; i < level.powered_items.size; i++) {
        powered = level.powered_items[i];
        if (powered.power_sources == 2) {
            continue;
        }
        waspowered = isinarray(localpower.enabled_list, powered);
        ispowered = powered [[ powered.range_func ]](1, origin, localpower.radius);
        if (ispowered && !waspowered) {
            powered change_power(1, origin, localpower.radius);
            localpower.enabled_list[localpower.enabled_list.size] = powered;
            continue;
        }
        if (!ispowered && waspowered) {
            powered revert_power(-1, localpower.origin, localpower.radius, localpower.enabled_list);
            arrayremovevalue(localpower.enabled_list, powered, 0);
        }
    }
    localpower.origin = origin;
    return localpower;
}

// Namespace zm_power
// Params 1, eflags: 0x0
// Checksum 0xf495497b, Offset: 0x1a70
// Size: 0x134
function end_local_power(localpower) {
    println("zmb_turn_on" + localpower.origin + "zmb_turn_on" + localpower.radius + "zmb_turn_on");
    if (isdefined(localpower.enabled_list)) {
        revert_power_to_list(-1, localpower.origin, localpower.radius, localpower.enabled_list);
    }
    localpower.enabled_list = undefined;
    if (isdefined(localpower.added_list)) {
        revert_power_to_list(-1, localpower.origin, localpower.radius, localpower.added_list);
    }
    localpower.added_list = undefined;
    arrayremovevalue(level.local_power, localpower, 0);
}

// Namespace zm_power
// Params 1, eflags: 0x0
// Checksum 0xec5b16da, Offset: 0x1bb0
// Size: 0xd0
function has_local_power(origin) {
    if (isdefined(level.local_power)) {
        foreach (localpower in level.local_power) {
            if (distancesquared(localpower.origin, origin) < localpower.radius * localpower.radius) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_power
// Params 0, eflags: 0x1 linked
// Checksum 0xf227a709, Offset: 0x1c88
// Size: 0x9e
function get_powered_item_cost() {
    if (!(isdefined(self.power) && self.power)) {
        return 0;
    }
    if (isdefined(level._power_global) && level._power_global && !(self.power_sources == 1)) {
        return 0;
    }
    cost = [[ self.cost_func ]]();
    power_sources = self.powered_count;
    if (power_sources < 1) {
        power_sources = 1;
    }
    return cost / power_sources;
}

// Namespace zm_power
// Params 1, eflags: 0x0
// Checksum 0x256f808b, Offset: 0x1d30
// Size: 0x184
function get_local_power_cost(localpower) {
    cost = 0;
    if (isdefined(localpower) && isdefined(localpower.enabled_list)) {
        foreach (powered in localpower.enabled_list) {
            cost += powered get_powered_item_cost();
        }
    }
    if (isdefined(localpower) && isdefined(localpower.added_list)) {
        foreach (powered in localpower.added_list) {
            cost += powered get_powered_item_cost();
        }
    }
    return cost;
}

// Namespace zm_power
// Params 1, eflags: 0x1 linked
// Checksum 0xb59cd9b4, Offset: 0x1ec0
// Size: 0xd6
function set_global_power(on_off) {
    demo::bookmark("zm_power", gettime(), undefined, undefined, 1);
    level._power_global = on_off;
    for (i = 0; i < level.powered_items.size; i++) {
        powered = level.powered_items[i];
        if (isdefined(powered.target) && powered.power_sources != 1) {
            powered global_power(on_off);
            util::wait_network_frame();
        }
    }
}

// Namespace zm_power
// Params 1, eflags: 0x1 linked
// Checksum 0x358b3b94, Offset: 0x1fa0
// Size: 0xe8
function global_power(on_off) {
    if (on_off) {
        println("zmb_turn_on");
        if (!self.power) {
            self.power = 1;
            self [[ self.power_on_func ]]();
        }
        self.powered_count++;
        return;
    }
    println("zmb_turn_on");
    self.powered_count--;
    assert(self.powered_count >= 0, "zmb_turn_on");
    if (self.powered_count == 0 && self.power) {
        self.power = 0;
        self [[ self.power_off_func ]]();
    }
}

// Namespace zm_power
// Params 2, eflags: 0x0
// Checksum 0xfe136be2, Offset: 0x2090
// Size: 0x14
function never_power_on(origin, radius) {
    
}

// Namespace zm_power
// Params 2, eflags: 0x0
// Checksum 0xf9bf478e, Offset: 0x20b0
// Size: 0x14
function never_power_off(origin, radius) {
    
}

// Namespace zm_power
// Params 0, eflags: 0x0
// Checksum 0x95f32f82, Offset: 0x20d0
// Size: 0x36
function cost_negligible() {
    if (isdefined(self.one_time_cost)) {
        cost = self.one_time_cost;
        self.one_time_cost = undefined;
        return cost;
    }
    return 0;
}

// Namespace zm_power
// Params 0, eflags: 0x1 linked
// Checksum 0xaaa78d1c, Offset: 0x2110
// Size: 0x6e
function cost_low_if_local() {
    if (isdefined(self.one_time_cost)) {
        cost = self.one_time_cost;
        self.one_time_cost = undefined;
        return cost;
    }
    if (isdefined(level._power_global) && level._power_global) {
        return 0;
    }
    if (isdefined(self.self_powered) && self.self_powered) {
        return 0;
    }
    return 1;
}

// Namespace zm_power
// Params 0, eflags: 0x0
// Checksum 0x3513dfb0, Offset: 0x2188
// Size: 0x38
function cost_high() {
    if (isdefined(self.one_time_cost)) {
        cost = self.one_time_cost;
        self.one_time_cost = undefined;
        return cost;
    }
    return 10;
}

// Namespace zm_power
// Params 3, eflags: 0x1 linked
// Checksum 0xbeb4323d, Offset: 0x21c8
// Size: 0x6a
function door_range(delta, origin, radius) {
    if (delta < 0) {
        return false;
    }
    if (distancesquared(self.target.origin, origin) < radius * radius) {
        return true;
    }
    return false;
}

// Namespace zm_power
// Params 2, eflags: 0x1 linked
// Checksum 0xc771f54d, Offset: 0x2240
// Size: 0x5c
function door_power_on(origin, radius) {
    println("zmb_turn_on");
    self.target.power_on = 1;
    self.target notify(#"power_on");
}

// Namespace zm_power
// Params 2, eflags: 0x1 linked
// Checksum 0xc649f6, Offset: 0x22a8
// Size: 0x5c
function door_power_off(origin, radius) {
    println("zmb_turn_on");
    self.target notify(#"power_off");
    self.target.power_on = 0;
}

// Namespace zm_power
// Params 2, eflags: 0x1 linked
// Checksum 0x2210bc04, Offset: 0x2310
// Size: 0x5c
function door_local_power_on(origin, radius) {
    println("zmb_turn_on");
    self.target.local_power_on = 1;
    self.target notify(#"local_power_on");
}

// Namespace zm_power
// Params 2, eflags: 0x1 linked
// Checksum 0x4e5d2eb9, Offset: 0x2378
// Size: 0x5c
function door_local_power_off(origin, radius) {
    println("zmb_turn_on");
    self.target notify(#"local_power_off");
    self.target.local_power_on = 0;
}

// Namespace zm_power
// Params 0, eflags: 0x1 linked
// Checksum 0x564679f6, Offset: 0x23e0
// Size: 0x96
function cost_door() {
    if (isdefined(self.target.power_cost)) {
        if (!isdefined(self.one_time_cost)) {
            self.one_time_cost = 0;
        }
        self.one_time_cost += self.target.power_cost;
        self.target.power_cost = 0;
    }
    if (isdefined(self.one_time_cost)) {
        cost = self.one_time_cost;
        self.one_time_cost = undefined;
        return cost;
    }
    return 0;
}

// Namespace zm_power
// Params 3, eflags: 0x0
// Checksum 0x9ce183f0, Offset: 0x2480
// Size: 0x84
function zombie_range(delta, origin, radius) {
    if (delta > 0) {
        return false;
    }
    self.zombies = array::get_all_closest(origin, zombie_utility::get_round_enemy_array(), undefined, undefined, radius);
    if (!isdefined(self.zombies)) {
        return false;
    }
    self.power = 1;
    return true;
}

// Namespace zm_power
// Params 2, eflags: 0x0
// Checksum 0x6937ec36, Offset: 0x2510
// Size: 0x86
function zombie_power_off(origin, radius) {
    println("zmb_turn_on");
    for (i = 0; i < self.zombies.size; i++) {
        self.zombies[i] thread stun_zombie();
        wait(0.05);
    }
}

// Namespace zm_power
// Params 0, eflags: 0x1 linked
// Checksum 0xd03c1990, Offset: 0x25a0
// Size: 0x8e
function stun_zombie() {
    self endon(#"death");
    self notify(#"stun_zombie");
    self endon(#"stun_zombie");
    if (self.health <= 0) {
        /#
            iprintln("zmb_turn_on");
        #/
        return;
    }
    if (isdefined(self.ignore_inert) && self.ignore_inert) {
        return;
    }
    if (isdefined(self.stun_zombie)) {
        self thread [[ self.stun_zombie ]]();
        return;
    }
}

// Namespace zm_power
// Params 3, eflags: 0x1 linked
// Checksum 0xc04ce1d3, Offset: 0x2638
// Size: 0xf2
function perk_range(delta, origin, radius) {
    if (isdefined(self.target)) {
        perkorigin = self.target.origin;
        if (isdefined(self.target.trigger_off) && self.target.trigger_off) {
            perkorigin = self.target.realorigin;
        } else if (isdefined(self.target.disabled) && self.target.disabled) {
            perkorigin += (0, 0, 10000);
        }
        if (distancesquared(perkorigin, origin) < radius * radius) {
            return true;
        }
    }
    return false;
}

// Namespace zm_power
// Params 2, eflags: 0x1 linked
// Checksum 0x8bad1c29, Offset: 0x2738
// Size: 0x9c
function perk_power_on(origin, radius) {
    println("zmb_turn_on" + self.target zm_perks::getvendingmachinenotify() + "zmb_turn_on");
    level notify(self.target zm_perks::getvendingmachinenotify() + "_on");
    zm_perks::perk_unpause(self.target.script_noteworthy);
}

// Namespace zm_power
// Params 2, eflags: 0x1 linked
// Checksum 0x37e84189, Offset: 0x27e0
// Size: 0x180
function perk_power_off(origin, radius) {
    notify_name = self.target zm_perks::getvendingmachinenotify();
    if (isdefined(notify_name) && notify_name == "revive") {
        if (level flag::exists("solo_game") && level flag::get("solo_game")) {
            return;
        }
    }
    println("zmb_turn_on" + self.target.script_noteworthy + "zmb_turn_on");
    self.target notify(#"death");
    self.target thread zm_perks::vending_trigger_think();
    if (isdefined(self.target.perk_hum)) {
        self.target.perk_hum delete();
    }
    zm_perks::perk_pause(self.target.script_noteworthy);
    level notify(self.target zm_perks::getvendingmachinenotify() + "_off");
}

// Namespace zm_power
// Params 1, eflags: 0x1 linked
// Checksum 0x8d4d5068, Offset: 0x2968
// Size: 0x2ae
function turn_power_on_and_open_doors(power_zone) {
    level.local_doors_stay_open = 1;
    level.power_local_doors_globally = 1;
    if (!isdefined(power_zone)) {
        level flag::set("power_on");
        level clientfield::set("zombie_power_on", 0);
    } else {
        level flag::set("power_on" + power_zone);
        level clientfield::set("zombie_power_on", power_zone);
    }
    zombie_doors = getentarray("zombie_door", "targetname");
    foreach (door in zombie_doors) {
        if (!isdefined(door.script_noteworthy)) {
            continue;
        }
        if (door.script_noteworthy == "electric_door" || !isdefined(power_zone) && door.script_noteworthy == "electric_buyable_door") {
            door notify(#"power_on");
            continue;
        }
        if (door.script_noteworthy == "electric_door" || isdefined(door.script_int) && door.script_int == power_zone && door.script_noteworthy == "electric_buyable_door") {
            door notify(#"power_on");
            if (isdefined(level.temporary_power_switch_logic)) {
                door.power_on = 1;
            }
            continue;
        }
        if (isdefined(door.script_int) && door.script_int == power_zone && door.script_noteworthy === "local_electric_door") {
            door notify(#"local_power_on");
        }
    }
}

// Namespace zm_power
// Params 1, eflags: 0x1 linked
// Checksum 0x62ac6b9c, Offset: 0x2c20
// Size: 0x2d6
function turn_power_off_and_close_doors(power_zone) {
    level.local_doors_stay_open = 0;
    level.power_local_doors_globally = 0;
    if (!isdefined(power_zone)) {
        level flag::clear("power_on");
        level clientfield::set("zombie_power_off", 0);
    } else {
        level flag::clear("power_on" + power_zone);
        level clientfield::set("zombie_power_off", power_zone);
    }
    zombie_doors = getentarray("zombie_door", "targetname");
    foreach (door in zombie_doors) {
        if (!isdefined(door.script_noteworthy)) {
            continue;
        }
        if (door.script_noteworthy == "electric_door" || !isdefined(power_zone) && door.script_noteworthy == "electric_buyable_door") {
            door notify(#"power_on");
            continue;
        }
        if (door.script_noteworthy == "electric_door" || isdefined(door.script_int) && door.script_int == power_zone && door.script_noteworthy == "electric_buyable_door") {
            door notify(#"power_on");
            if (isdefined(level.temporary_power_switch_logic)) {
                door.power_on = 0;
                door sethintstring(%ZOMBIE_NEED_POWER);
                door notify(#"kill_door_think");
                door thread zm_blockers::door_think();
            }
            continue;
        }
        if (isdefined(door.script_noteworthy) && door.script_noteworthy == "local_electric_door") {
            door notify(#"local_power_on");
        }
    }
}

