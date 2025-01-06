#using scripts/codescripts/struct;

#namespace zm_temple_ffotd;

// Namespace zm_temple_ffotd
// Params 0, eflags: 0x0
// Checksum 0xc297980b, Offset: 0xe8
// Size: 0x102
function main_start() {
    a_wallbuys = struct::get_array("weapon_upgrade", "targetname");
    foreach (s_wallbuy in a_wallbuys) {
        if (s_wallbuy.zombie_weapon_upgrade == "smg_standard") {
            s_wallbuy.origin += (0, 5, 0);
        }
    }
    level._effect["powerup_on_red"] = "zombie/fx_powerup_on_red_zmb";
}

// Namespace zm_temple_ffotd
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1f8
// Size: 0x4
function main_end() {
    
}

