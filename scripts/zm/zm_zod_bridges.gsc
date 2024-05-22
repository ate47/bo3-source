#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_f76f5b63;

// Namespace namespace_f76f5b63
// Method(s) 7 Total 7
class class_1f041243 {

    // Namespace namespace_1f041243
    // Params 0, eflags: 0x0
    // Checksum 0xe2e1d080, Offset: 0xb38
    // Size: 0x44
    function function_64c24459() {
        self moveto(self.origin - (0, 0, 10000), 0.05);
        wait(0.05);
    }

    // Namespace namespace_1f041243
    // Params 0, eflags: 0x0
    // Checksum 0xb3e1e759, Offset: 0xa80
    // Size: 0xac
    function function_35b36f55() {
        var_c7c6602e = self.var_8ba3e653 + "_district_zone_high";
        if (!zm_zonemgr::zone_is_enabled(var_c7c6602e)) {
            zm_zonemgr::zone_init(var_c7c6602e);
            zm_zonemgr::enable_zone(var_c7c6602e);
        }
        zm_zonemgr::add_adjacent_zone(self.var_8ba3e653 + "_district_zone_B", var_c7c6602e, "enter_" + self.var_8ba3e653 + "_district_high_from_B");
    }

    // Namespace namespace_1f041243
    // Params 2, eflags: 0x0
    // Checksum 0xceed0c4d, Offset: 0x8a8
    // Size: 0x1cc
    function function_266e1445(var_f68bad2e, var_d08932c5) {
        util::waittill_any_ents_two(var_f68bad2e, "trigger", var_d08932c5, "trigger");
        foreach (e_blocker in self.var_1c98028c) {
            e_blocker setanim(generic%p7_fxanim_zm_zod_gate_scissor_short_open_anim);
        }
        self.var_746f1e93 setanim(generic%p7_fxanim_zm_zod_beast_bridge_open_anim);
        self.var_746f1e93 setvisibletoall();
        self.var_c7107160 setinvisibletoall();
        self.var_c7107160 clientfield::set("bminteract", 0);
        self.var_c7107160 setgrapplabletype(0);
        level.var_701d7eb = array::exclude(level.var_701d7eb, self.var_c7107160);
        wait(1);
        self.var_17d1cc44 function_64c24459();
        self.var_17d1cc44 connectpaths();
        function_35b36f55();
    }

    // Namespace namespace_1f041243
    // Params 2, eflags: 0x0
    // Checksum 0x5a78bae8, Offset: 0x858
    // Size: 0x48
    function function_1bfbfa4c(e_entity, var_d42f02cf) {
        if (!isdefined(e_entity.script_string) || e_entity.script_string != var_d42f02cf) {
            return false;
        }
        return true;
    }

    // Namespace namespace_1f041243
    // Params 1, eflags: 0x0
    // Checksum 0x5ffbac61, Offset: 0x488
    // Size: 0x3c4
    function function_69d1a149(var_d42f02cf) {
        self.var_8ba3e653 = var_d42f02cf;
        var_5fd95ddf = 0;
        var_5db129b = 0.1;
        door_name = var_d42f02cf + "_bridge_door";
        var_e8ecea33 = getentarray(door_name, "script_noteworthy");
        self.var_1c98028c = getentarray("bridge_blocker", "targetname");
        var_a2660e03 = getentarray("bridge_clip_blocker", "targetname");
        var_ed804e7f = getentarray("bridge_walkway", "targetname");
        var_bb00a9de = getentarray("bridge_pull_trigger", "targetname");
        var_60dfdb84 = getentarray("bridge_pull_target", "targetname");
        self.var_1c98028c = array::filter(self.var_1c98028c, 0, &function_1bfbfa4c, var_d42f02cf);
        var_a2660e03 = array::filter(var_a2660e03, 0, &function_1bfbfa4c, var_d42f02cf);
        self.var_17d1cc44 = var_a2660e03[0];
        var_ed804e7f = array::filter(var_ed804e7f, 0, &function_1bfbfa4c, var_d42f02cf);
        self.var_746f1e93 = var_ed804e7f[0];
        var_60dfdb84 = array::filter(var_60dfdb84, 0, &function_1bfbfa4c, var_d42f02cf);
        self.var_c7107160 = var_60dfdb84[0];
        self.var_7a01aaae = 0;
        self.var_746f1e93 setinvisibletoall();
        foreach (e_blocker in self.var_1c98028c) {
            e_blocker useanimtree(#generic);
        }
        self.var_746f1e93 useanimtree(#generic);
        self.var_c7107160 setgrapplabletype(3);
        array::add(level.var_701d7eb, self.var_c7107160, 0);
        self.var_c7107160 clientfield::set("bminteract", 3);
        self thread function_266e1445(var_e8ecea33[0], var_e8ecea33[1]);
    }

}

// Namespace namespace_f76f5b63
// Params 0, eflags: 0x2
// Checksum 0xd1f51ee3, Offset: 0x330
// Size: 0x2c
function function_2dc19561() {
    system::register("zm_zod_bridges", undefined, &__main__, undefined);
}

// Namespace namespace_f76f5b63
// Params 0, eflags: 0x0
// Checksum 0x9b24a9a6, Offset: 0x368
// Size: 0x1c
function __main__() {
    level thread function_cc211d40();
}

// Namespace namespace_f76f5b63
// Params 0, eflags: 0x0
// Checksum 0xee322fe9, Offset: 0x390
// Size: 0x94
function function_cc211d40() {
    if (!isdefined(level.var_701d7eb)) {
        level.var_701d7eb = [];
    }
    if (!isdefined(level.var_c70d218)) {
        level.var_c70d218 = [];
        function_69d1a149("slums", 1);
        function_69d1a149("canal", 2);
        function_69d1a149("theater", 3);
    }
}

// Namespace namespace_f76f5b63
// Params 2, eflags: 0x0
// Checksum 0x645bb9c5, Offset: 0x430
// Size: 0x50
function function_69d1a149(var_d42f02cf, n_index) {
    level.var_c70d218[n_index] = new class_1f041243();
    [[ level.var_c70d218[n_index] ]]->function_69d1a149(var_d42f02cf);
}

