#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_eaae7728;

// Namespace namespace_eaae7728
// Params 0, eflags: 0x0
// Checksum 0x7410e9e2, Offset: 0x210
// Size: 0x16c
function init_quest() {
    clientfield::register("scriptmover", "play_underwater_plant_fx", 9000, 1, "int", &function_54254560, 0, 0);
    clientfield::register("actor", "play_carrier_fx", 9000, 1, "int", &function_f0e89ab2, 0, 0);
    clientfield::register("scriptmover", "play_vial_fx", 9000, 1, "int", &function_e9572f40, 0, 0);
    clientfield::register("world", "add_ww_to_box", 9000, 4, "int", &function_fcdf674f, 0, 0);
    clientfield::register("scriptmover", "spider_bait", 9000, 1, "int", &function_6eb27bd9, 0, 0);
}

// Namespace namespace_eaae7728
// Params 7, eflags: 0x0
// Checksum 0x46d171d6, Offset: 0x388
// Size: 0x94
function function_fcdf674f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        var_989d36e = getweapon("hero_mirg2000");
        addzombieboxweapon(var_989d36e, var_989d36e.worldmodel, var_989d36e.isdualwield);
    }
}

// Namespace namespace_eaae7728
// Params 7, eflags: 0x0
// Checksum 0xe2bddd9b, Offset: 0x428
// Size: 0x6c
function function_54254560(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["ww_part_underwater_plant"], self, "tag_origin");
}

// Namespace namespace_eaae7728
// Params 7, eflags: 0x0
// Checksum 0x6e9cc6a7, Offset: 0x4a0
// Size: 0x6c
function function_f0e89ab2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["ww_part_scientist_vial"], self, "j_spineupper");
}

// Namespace namespace_eaae7728
// Params 7, eflags: 0x0
// Checksum 0x4934485f, Offset: 0x518
// Size: 0x6c
function function_e9572f40(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["ww_part_scientist_vial"], self, "tag_origin");
}

// Namespace namespace_eaae7728
// Params 7, eflags: 0x0
// Checksum 0xd98ee7d8, Offset: 0x590
// Size: 0xbc
function function_6eb27bd9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.n_fx_id = playfx(localclientnum, level._effect["spider_pheromone"], self.origin + (0, 0, -100));
        return;
    }
    if (isdefined(self.n_fx_id)) {
        stopfx(localclientnum, self.n_fx_id);
    }
}

