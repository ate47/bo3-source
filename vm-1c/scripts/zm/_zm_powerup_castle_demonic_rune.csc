#using scripts/zm/_zm_powerups;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace namespace_e581e076;

// Namespace namespace_e581e076
// Params 0, eflags: 0x2
// namespace_e581e076<file_0>::function_2dc19561
// Checksum 0xd7ff5007, Offset: 0x1d0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_demonic_rune", &__init__, undefined, undefined);
}

// Namespace namespace_e581e076
// Params 0, eflags: 0x1 linked
// namespace_e581e076<file_0>::function_8c87d8eb
// Checksum 0xe4ced1f7, Offset: 0x210
// Size: 0x16c
function __init__() {
    clientfield::register("scriptmover", "demonic_rune_fx", 5000, 1, "int", &function_4a94c040, 0, 0);
    zm_powerups::include_zombie_powerup("demonic_rune_lor");
    zm_powerups::add_zombie_powerup("demonic_rune_lor");
    zm_powerups::include_zombie_powerup("demonic_rune_ulla");
    zm_powerups::add_zombie_powerup("demonic_rune_ulla");
    zm_powerups::include_zombie_powerup("demonic_rune_oth");
    zm_powerups::add_zombie_powerup("demonic_rune_oth");
    zm_powerups::include_zombie_powerup("demonic_rune_zor");
    zm_powerups::add_zombie_powerup("demonic_rune_zor");
    zm_powerups::include_zombie_powerup("demonic_rune_mar");
    zm_powerups::add_zombie_powerup("demonic_rune_mar");
    zm_powerups::include_zombie_powerup("demonic_rune_uja");
    zm_powerups::add_zombie_powerup("demonic_rune_uja");
}

// Namespace namespace_e581e076
// Params 7, eflags: 0x1 linked
// namespace_e581e076<file_0>::function_4a94c040
// Checksum 0x50a77ded, Offset: 0x388
// Size: 0x6c
function function_4a94c040(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        playfxontag(localclientnum, "dlc1/castle/fx_demon_gate_rune_glow", self, "tag_origin");
    }
}

