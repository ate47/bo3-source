#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace zm_island_zones;

// Namespace zm_island_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x3a38c980, Offset: 0x190
// Size: 0x4c
function init() {
    clientfield::register("scriptmover", "vine_door_play_fx", 9000, 1, "int", &vine_door_play_fx, 0, 0);
}

// Namespace zm_island_zones
// Params 7, eflags: 0x1 linked
// Checksum 0x1e219594, Offset: 0x1e8
// Size: 0x6c
function vine_door_play_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["door_vine_fx"], self, "tag_fx_origin");
}

// Namespace zm_island_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x260
// Size: 0x4
function main() {
    
}

