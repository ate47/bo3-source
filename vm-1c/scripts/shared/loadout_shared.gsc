#namespace loadout;

// Namespace loadout
// Params 1, eflags: 0x0
// Checksum 0xa8dce69b, Offset: 0x78
// Size: 0xe
function is_warlord_perk(itemindex) {
    return false;
}

// Namespace loadout
// Params 1, eflags: 0x0
// Checksum 0x2c4d7a5f, Offset: 0x90
// Size: 0x78
function is_item_excluded(itemindex) {
    if (!level.onlinegame) {
        return false;
    }
    numexclusions = level.itemexclusions.size;
    for (exclusionindex = 0; exclusionindex < numexclusions; exclusionindex++) {
        if (itemindex == level.itemexclusions[exclusionindex]) {
            return true;
        }
    }
    return false;
}

// Namespace loadout
// Params 2, eflags: 0x0
// Checksum 0xcf017f4f, Offset: 0x110
// Size: 0x78
function getloadoutitemfromddlstats(customclassnum, loadoutslot) {
    itemindex = self getloadoutitem(customclassnum, loadoutslot);
    if (is_item_excluded(itemindex) && !is_warlord_perk(itemindex)) {
        return 0;
    }
    return itemindex;
}

// Namespace loadout
// Params 1, eflags: 0x0
// Checksum 0x46e5e5ef, Offset: 0x190
// Size: 0x24
function initweaponattachments(weapon) {
    self.currentweaponstarttime = gettime();
    self.currentweapon = weapon;
}

