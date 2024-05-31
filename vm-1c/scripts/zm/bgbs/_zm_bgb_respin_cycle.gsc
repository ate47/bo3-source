#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_respin_cycle;

// Namespace zm_bgb_respin_cycle
// Params 0, eflags: 0x2
// namespace_ddb9c921<file_0>::function_2dc19561
// Checksum 0x303ac2b3, Offset: 0x200
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_respin_cycle", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_respin_cycle
// Params 0, eflags: 0x1 linked
// namespace_ddb9c921<file_0>::function_8c87d8eb
// Checksum 0x9cff218c, Offset: 0x240
// Size: 0x94
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_respin_cycle", "activated", 2, undefined, undefined, &validation, &activation);
    clientfield::register("zbarrier", "zm_bgb_respin_cycle", 1, 1, "counter");
}

// Namespace zm_bgb_respin_cycle
// Params 0, eflags: 0x1 linked
// namespace_ddb9c921<file_0>::function_e4776d0
// Checksum 0x98b25939, Offset: 0x2e0
// Size: 0x96
function validation() {
    for (i = 0; i < level.chests.size; i++) {
        chest = level.chests[i];
        if (isdefined(chest.zbarrier.weapon_model) && isdefined(chest.chest_user) && self == chest.chest_user) {
            return true;
        }
    }
    return false;
}

// Namespace zm_bgb_respin_cycle
// Params 0, eflags: 0x1 linked
// namespace_ddb9c921<file_0>::function_7afbf7cd
// Checksum 0xb4e0655, Offset: 0x380
// Size: 0xb6
function activation() {
    self endon(#"disconnect");
    for (i = 0; i < level.chests.size; i++) {
        chest = level.chests[i];
        if (isdefined(chest.zbarrier.weapon_model) && isdefined(chest.chest_user) && self == chest.chest_user) {
            chest thread function_7a5dc39b(self);
        }
    }
}

// Namespace zm_bgb_respin_cycle
// Params 1, eflags: 0x1 linked
// namespace_ddb9c921<file_0>::function_7a5dc39b
// Checksum 0x898a9edb, Offset: 0x440
// Size: 0x1cc
function function_7a5dc39b(player) {
    self.zbarrier clientfield::increment("zm_bgb_respin_cycle");
    if (isdefined(self.zbarrier.weapon_model)) {
        self.zbarrier.weapon_model notify(#"kill_respin_think_thread");
    }
    self.no_fly_away = 1;
    self.zbarrier notify(#"box_hacked_respin");
    self.zbarrier playsound("zmb_bgb_powerup_respin");
    self thread zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
    zm_utility::play_sound_at_pos("open_chest", self.zbarrier.origin);
    zm_utility::play_sound_at_pos("music_chest", self.zbarrier.origin);
    self.zbarrier thread zm_magicbox::treasure_chest_weapon_spawn(self, player);
    self.zbarrier waittill(#"randomization_done");
    self.no_fly_away = undefined;
    if (!level flag::get("moving_chest_now")) {
        self.grab_weapon_hint = 1;
        self.grab_weapon = self.zbarrier.weapon;
        self thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &zm_magicbox::magicbox_unitrigger_think);
        self thread zm_magicbox::treasure_chest_timeout();
    }
}

