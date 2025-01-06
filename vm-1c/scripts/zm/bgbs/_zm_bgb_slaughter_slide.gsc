#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_slaughter_slide;

// Namespace zm_bgb_slaughter_slide
// Params 0, eflags: 0x2
// Checksum 0x7a3a96b, Offset: 0x170
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_slaughter_slide", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_slaughter_slide
// Params 0, eflags: 0x0
// Checksum 0xd3822a92, Offset: 0x1b0
// Size: 0xc4
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_slaughter_slide", "event", &event, undefined, undefined, undefined);
    bgb::register_actor_damage_override("zm_bgb_slaughter_slide", &actor_damage_override);
    bgb::register_vehicle_damage_override("zm_bgb_slaughter_slide", &vehicle_damage_override);
    level.var_77eb3698 = getweapon("frag_grenade_slaughter_slide");
}

// Namespace zm_bgb_slaughter_slide
// Params 0, eflags: 0x0
// Checksum 0xecf54b59, Offset: 0x280
// Size: 0xb8
function event() {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"bgb_update");
    self.var_abd23dd0 = 6;
    while (self.var_abd23dd0 > 0) {
        var_2a23ce90 = self is_sliding(2);
        if (var_2a23ce90) {
            self thread function_42722ac4();
            while (self issliding()) {
                wait 0.2;
            }
        }
        wait 0.05;
    }
}

// Namespace zm_bgb_slaughter_slide
// Params 1, eflags: 0x0
// Checksum 0xbc1fb679, Offset: 0x340
// Size: 0x66
function is_sliding(n_count) {
    var_2a23ce90 = 0;
    for (x = 0; x < n_count; x++) {
        var_2a23ce90 = self issliding();
        wait 0.05;
    }
    return var_2a23ce90;
}

// Namespace zm_bgb_slaughter_slide
// Params 0, eflags: 0x0
// Checksum 0x85313658, Offset: 0x3b0
// Size: 0x164
function function_42722ac4() {
    var_f9ff0ca1 = (0, 0, 48);
    v_facing = anglestoforward(self.angles);
    v_right = anglestoright(self.angles);
    self magicgrenadetype(level.var_77eb3698, self.origin + var_f9ff0ca1, v_facing * 1000, 0.5);
    util::wait_network_frame();
    self magicgrenadetype(level.var_77eb3698, self.origin + var_f9ff0ca1, v_facing * -1 * 100, 0.05);
    self bgb::do_one_shot_use();
    self.var_abd23dd0--;
    self bgb::set_timer(self.var_abd23dd0, 6);
}

// Namespace zm_bgb_slaughter_slide
// Params 12, eflags: 0x0
// Checksum 0x4be7629a, Offset: 0x520
// Size: 0xce
function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (weapon === level.var_77eb3698) {
        if (isdefined(self.marked_for_death) && (isdefined(self.ignore_nuke) && self.ignore_nuke || self.marked_for_death) || zm_utility::is_magic_bullet_shield_enabled(self)) {
            return damage;
        }
        return (self.health + 666);
    }
    return damage;
}

// Namespace zm_bgb_slaughter_slide
// Params 15, eflags: 0x0
// Checksum 0x5428ec4d, Offset: 0x5f8
// Size: 0xe6
function vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (weapon === level.var_77eb3698) {
        if (isdefined(self.marked_for_death) && (isdefined(self.ignore_nuke) && self.ignore_nuke || self.marked_for_death) || zm_utility::is_magic_bullet_shield_enabled(self)) {
            return idamage;
        }
        return (self.health + 666);
    }
    return idamage;
}

