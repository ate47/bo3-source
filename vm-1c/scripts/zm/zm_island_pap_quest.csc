#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace zm_island_pap_quest;

// Namespace zm_island_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xa54e5072, Offset: 0x1b0
// Size: 0xdc
function init() {
    clientfield::register("scriptmover", "show_part", 9000, 1, "int", &function_97bd83a7, 0, 0);
    clientfield::register("actor", "zombie_splash", 9000, 1, "int", &function_b2ce2a08, 0, 0);
    clientfield::register("world", "lower_pap_water", 9000, 2, "int", &lower_pap_water, 0, 0);
}

// Namespace zm_island_pap_quest
// Params 7, eflags: 0x1 linked
// Checksum 0xa569e8b2, Offset: 0x298
// Size: 0x6c
function function_97bd83a7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["glow_piece"], self, "tag_origin");
}

// Namespace zm_island_pap_quest
// Params 7, eflags: 0x1 linked
// Checksum 0x4533eec, Offset: 0x310
// Size: 0x7c
function function_b2ce2a08(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfx(localclientnum, level._effect["water_splash"], self.origin + (0, 0, -48));
}

// Namespace zm_island_pap_quest
// Params 7, eflags: 0x1 linked
// Checksum 0x37068f87, Offset: 0x398
// Size: 0xdc
function lower_pap_water(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        level thread function_cc69986f(-432, 22, 3);
        return;
    }
    if (newval == 2) {
        level thread function_cc69986f(-454, 22, 3);
        return;
    }
    if (newval == 3) {
        level thread function_cc69986f(-476, 22, 3);
    }
}

// Namespace zm_island_pap_quest
// Params 3, eflags: 0x1 linked
// Checksum 0x787062fd, Offset: 0x480
// Size: 0xe4
function function_cc69986f(var_55fa7b94, var_e1344a83, n_time) {
    var_77d40fdb = var_55fa7b94 - var_e1344a83;
    var_c1c93aba = 187.5;
    n_delta = var_e1344a83 / var_c1c93aba;
    var_c0b3756a = var_55fa7b94;
    while (var_c0b3756a >= var_77d40fdb) {
        var_c0b3756a -= n_delta;
        setwavewaterheight("bunker_pap_room_water", var_c0b3756a);
        wait 0.016;
    }
    if (var_c0b3756a < var_77d40fdb) {
        setwavewaterheight("bunker_pap_room_water", var_77d40fdb);
    }
}

