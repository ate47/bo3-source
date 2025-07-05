#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/zm/_zm_powerups;

#namespace zm_powerup_genesis_random_weapon;

// Namespace zm_powerup_genesis_random_weapon
// Params 0, eflags: 0x2
// Checksum 0x8b64d9ee, Offset: 0x188
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_powerup_genesis_random_weapon", &__init__, undefined, undefined);
}

// Namespace zm_powerup_genesis_random_weapon
// Params 0, eflags: 0x0
// Checksum 0x55209953, Offset: 0x1c8
// Size: 0x7c
function __init__() {
    clientfield::register("scriptmover", "random_weap_fx", 15000, 1, "int", &function_1913104f, 0, 0);
    zm_powerups::include_zombie_powerup("genesis_random_weapon");
    zm_powerups::add_zombie_powerup("genesis_random_weapon");
}

// Namespace zm_powerup_genesis_random_weapon
// Params 7, eflags: 0x0
// Checksum 0xcad2fce0, Offset: 0x250
// Size: 0x6c
function function_1913104f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        playfxontag(localclientnum, "dlc1/castle/fx_demon_gate_rune_glow", self, "tag_origin");
    }
}

