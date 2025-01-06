#using scripts/codescripts/struct;
#using scripts/shared/filter_shared;

#namespace filter;

// Namespace filter
// Params 1, eflags: 0x0
// Checksum 0x54402168, Offset: 0xc0
// Size: 0x3c
function function_d8df67b5(player) {
    init_filter_indices();
    map_material_helper(player, "generic_filter_zm_turned");
}

// Namespace filter
// Params 3, eflags: 0x0
// Checksum 0xc5533eb0, Offset: 0x108
// Size: 0x7c
function function_8cb14040(player, filterid, var_5a938650) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, level.filter_matid["generic_filter_zm_turned"]);
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

// Namespace filter
// Params 3, eflags: 0x0
// Checksum 0x21d2bedc, Offset: 0x190
// Size: 0x44
function function_decc230d(player, filterid, var_5a938650) {
    setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

