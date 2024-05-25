#using scripts/shared/ai/zombie_utility;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm;
#using scripts/zm/_zm_powerups;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_a7758d0b;

// Namespace namespace_a7758d0b
// Params 0, eflags: 0x2
// Checksum 0xd39f7aa2, Offset: 0x250
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_self_medication", &__init__, undefined, "bgb");
}

// Namespace namespace_a7758d0b
// Params 0, eflags: 0x1 linked
// Checksum 0x99dff58a, Offset: 0x290
// Size: 0xac
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_self_medication", "event", &event, undefined, undefined, &validation);
    bgb::register_actor_death_override("zm_bgb_self_medication", &actor_death_override);
    bgb::register_lost_perk_override("zm_bgb_self_medication", &lost_perk_override, 0);
}

// Namespace namespace_a7758d0b
// Params 0, eflags: 0x1 linked
// Checksum 0x94de5bae, Offset: 0x348
// Size: 0xc8
function event() {
    self endon(#"disconnect");
    self endon(#"bgb_update");
    self endon(#"hash_1c39189f");
    self.var_25b88da = 3;
    self.w_min_last_stand_pistol_override = getweapon("ray_gun");
    level zm_utility::function_fb450820();
    self thread function_5816d71a();
    self thread function_cfc2c8d5();
    while (true) {
        self waittill(#"player_downed");
        self thread function_a8fd61f4();
    }
}

// Namespace namespace_a7758d0b
// Params 0, eflags: 0x1 linked
// Checksum 0x898c956d, Offset: 0x418
// Size: 0x22
function validation() {
    if (isdefined(self.var_df0decf1) && self.var_df0decf1) {
        return false;
    }
    return true;
}

// Namespace namespace_a7758d0b
// Params 0, eflags: 0x1 linked
// Checksum 0x20389a43, Offset: 0x448
// Size: 0x64
function function_5816d71a() {
    self util::waittill_any("disconnect", "bgb_update", "bgb_self_medication_complete");
    if (isdefined(self)) {
        self.w_min_last_stand_pistol_override = undefined;
    }
    wait(0.2);
    level zm_utility::function_53d28288();
}

// Namespace namespace_a7758d0b
// Params 1, eflags: 0x1 linked
// Checksum 0xde13f5f, Offset: 0x4b8
// Size: 0x74
function actor_death_override(e_attacker) {
    if (e_attacker laststand::player_is_in_laststand() && !(isdefined(e_attacker.var_df0decf1) && e_attacker.var_df0decf1)) {
        e_attacker thread bgb::bgb_revive_watcher();
        e_attacker notify(#"hash_935cc366");
    }
}

// Namespace namespace_a7758d0b
// Params 0, eflags: 0x1 linked
// Checksum 0x7ca72261, Offset: 0x538
// Size: 0x1a4
function function_cfc2c8d5() {
    self endon(#"disconnect");
    self endon(#"bgb_update");
    while (true) {
        self waittill(#"hash_935cc366");
        while (self getcurrentweapon() !== self.laststandpistol) {
            wait(0.05);
        }
        if (isdefined(self.has_specific_powerup_weapon["minigun"]) && isdefined(self.has_specific_powerup_weapon) && self.has_specific_powerup_weapon["minigun"]) {
            zm_powerups::weapon_powerup_remove(self, "minigun_time_over", "minigun", 1);
        }
        self bgb::do_one_shot_use();
        self playsoundtoplayer("zmb_bgb_self_medication", self);
        if (isdefined(self.revivetrigger) && isdefined(self.revivetrigger.beingrevived)) {
            self.revivetrigger setinvisibletoall();
            self.revivetrigger.beingrevived = 0;
        }
        self zm_laststand::auto_revive(self, 0);
        self.var_25b88da--;
        self bgb::set_timer(self.var_25b88da, 3);
        if (self.var_25b88da == 0) {
            self notify(#"hash_1c39189f");
            return;
        }
    }
}

// Namespace namespace_a7758d0b
// Params 0, eflags: 0x1 linked
// Checksum 0xaff20de, Offset: 0x6e8
// Size: 0x5c
function function_a8fd61f4() {
    self endon(#"player_revived");
    self endon(#"disconnect");
    self endon(#"bled_out");
    self waittill(#"hash_89eb445c");
    self.thrasher kill(self.thrasher.origin, self);
}

// Namespace namespace_a7758d0b
// Params 3, eflags: 0x1 linked
// Checksum 0x51cbb794, Offset: 0x750
// Size: 0x7e
function lost_perk_override(perk, var_2488e46a, var_24df4040) {
    if (!isdefined(var_2488e46a)) {
        var_2488e46a = undefined;
    }
    if (!isdefined(var_24df4040)) {
        var_24df4040 = undefined;
    }
    if (isdefined(var_2488e46a) && isdefined(var_24df4040) && var_2488e46a == var_24df4040) {
        self thread bgb::function_41ed378b(perk);
    }
    return false;
}

