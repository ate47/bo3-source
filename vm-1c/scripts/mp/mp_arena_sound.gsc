#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_1b1d095e;

// Namespace namespace_1b1d095e
// Params 0, eflags: 0x1 linked
// Checksum 0xece8b3ed, Offset: 0x148
// Size: 0x114
function main() {
    clientfield::register("world", "arena_announcer_line", 12000, 4, "int");
    clientfield::register("world", "arena_fighter", 12000, 2, "int");
    clientfield::register("world", "arena_fighter_line", 12000, 3, "int");
    clientfield::register("world", "arena_event", 12000, 3, "int");
    level.var_fcd3814c = array::randomize(array(0, 1, 2));
    level thread function_b205c01b();
}

// Namespace namespace_1b1d095e
// Params 0, eflags: 0x1 linked
// Checksum 0x33b89258, Offset: 0x268
// Size: 0x84
function function_b205c01b() {
    wait(0.05);
    while (level.inprematchperiod) {
        wait(1);
    }
    wait(20);
    function_e0b7e5b1();
    wait(-126);
    playintro();
    wait(-6);
    function_e1a89b2();
    wait(100);
    function_1982fa4a();
}

// Namespace namespace_1b1d095e
// Params 0, eflags: 0x1 linked
// Checksum 0xd4a14508, Offset: 0x2f8
// Size: 0x1c
function function_e0b7e5b1() {
    playevent(1, 10);
}

// Namespace namespace_1b1d095e
// Params 0, eflags: 0x1 linked
// Checksum 0x732b8e43, Offset: 0x320
// Size: 0x54
function playintro() {
    fighter = level.var_fcd3814c[randomint(2)];
    playevent(2, 3, fighter, 5);
}

// Namespace namespace_1b1d095e
// Params 0, eflags: 0x1 linked
// Checksum 0x1ac63891, Offset: 0x380
// Size: 0x44
function function_e1a89b2() {
    fighter = level.var_fcd3814c[1];
    playevent(3, 3, fighter, 5);
}

// Namespace namespace_1b1d095e
// Params 0, eflags: 0x1 linked
// Checksum 0xf9f964c, Offset: 0x3d0
// Size: 0x44
function function_1982fa4a() {
    fighter = level.var_fcd3814c[0];
    playevent(4, 3, fighter, 5);
}

// Namespace namespace_1b1d095e
// Params 4, eflags: 0x1 linked
// Checksum 0xad4bdf7e, Offset: 0x420
// Size: 0xdc
function playevent(event, var_d145aed1, fighter, var_9751e39f) {
    level clientfield::set("arena_announcer_line", randomint(var_d145aed1));
    if (isdefined(fighter) && isdefined(var_9751e39f)) {
        level clientfield::set("arena_fighter", fighter);
        level clientfield::set("arena_fighter_line", randomint(var_9751e39f));
    }
    level clientfield::set("arena_event", event);
}

