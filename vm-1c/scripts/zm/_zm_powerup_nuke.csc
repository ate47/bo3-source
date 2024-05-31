#using scripts/zm/_zm_powerups;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_powerup_nuke;

// Namespace zm_powerup_nuke
// Params 0, eflags: 0x2
// Checksum 0x73611491, Offset: 0x150
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_nuke", &__init__, undefined, undefined);
}

// Namespace zm_powerup_nuke
// Params 0, eflags: 0x1 linked
// Checksum 0x730244fa, Offset: 0x190
// Size: 0xc4
function __init__() {
    zm_powerups::include_zombie_powerup("nuke");
    zm_powerups::add_zombie_powerup("nuke");
    clientfield::register("actor", "zm_nuked", 1000, 1, "counter", &zombie_nuked, 0, 0);
    clientfield::register("vehicle", "zm_nuked", 1000, 1, "counter", &zombie_nuked, 0, 0);
}

// Namespace zm_powerup_nuke
// Params 7, eflags: 0x1 linked
// Checksum 0xed743393, Offset: 0x260
// Size: 0x54
function zombie_nuked(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self zombie_death::flame_death_fx(localclientnum);
}

