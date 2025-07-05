#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/zm/_zm_powerups;

#namespace zm_powerup_nuke;

// Namespace zm_powerup_nuke
// Params 0, eflags: 0x2
// Checksum 0x32ec6fb2, Offset: 0x150
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_powerup_nuke", &__init__, undefined, undefined);
}

// Namespace zm_powerup_nuke
// Params 0, eflags: 0x0
// Checksum 0x79aaee42, Offset: 0x190
// Size: 0xc4
function __init__() {
    zm_powerups::include_zombie_powerup("nuke");
    zm_powerups::add_zombie_powerup("nuke");
    clientfield::register("actor", "zm_nuked", 1000, 1, "counter", &zombie_nuked, 0, 0);
    clientfield::register("vehicle", "zm_nuked", 1000, 1, "counter", &zombie_nuked, 0, 0);
}

// Namespace zm_powerup_nuke
// Params 7, eflags: 0x0
// Checksum 0x24b21264, Offset: 0x260
// Size: 0x54
function zombie_nuked(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self zombie_death::flame_death_fx(localclientnum);
}

