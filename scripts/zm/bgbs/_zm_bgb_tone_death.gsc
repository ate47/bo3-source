#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/spawner_shared;
#using scripts/shared/array_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_66043662;

// Namespace namespace_66043662
// Params 0, eflags: 0x2
// Checksum 0x4e9009c1, Offset: 0x200
// Size: 0x34
function function_2dc19561() {
    system::register("zm_bgb_tone_death", &__init__, undefined, "bgb");
}

// Namespace namespace_66043662
// Params 0, eflags: 0x1 linked
// Checksum 0x7413b4ce, Offset: 0x240
// Size: 0x7c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_tone_death", "event", &event, undefined, undefined, undefined);
    bgb::register_actor_death_override("zm_bgb_tone_death", &actor_death_override);
}

// Namespace namespace_66043662
// Params 0, eflags: 0x1 linked
// Checksum 0xdf37c053, Offset: 0x2c8
// Size: 0x5c
function event() {
    self endon(#"disconnect");
    self thread function_1473087b();
    self util::waittill_any("disconnect", "bled_out", "bgb_gumball_anim_give", "bgb_tone_death_maxed");
}

// Namespace namespace_66043662
// Params 0, eflags: 0x1 linked
// Checksum 0xe8d77d2f, Offset: 0x330
// Size: 0x46
function function_1473087b() {
    self util::waittill_any("disconnect", "bled_out", "bgb_gumball_anim_give", "bgb_tone_death_maxed");
    self.var_9d977a5f = undefined;
}

// Namespace namespace_66043662
// Params 1, eflags: 0x1 linked
// Checksum 0x32ecd2b7, Offset: 0x380
// Size: 0xe8
function actor_death_override(e_attacker) {
    if (self.archetype !== "zombie" || !isplayer(e_attacker)) {
        return;
    }
    if (e_attacker bgb::is_enabled("zm_bgb_tone_death")) {
        self.bgb_tone_death = 1;
        if (!isdefined(e_attacker.var_9d977a5f)) {
            e_attacker.var_9d977a5f = 25;
        }
        e_attacker.var_9d977a5f--;
        e_attacker bgb::set_timer(e_attacker.var_9d977a5f, 25);
        if (e_attacker.var_9d977a5f <= 0) {
            e_attacker notify(#"hash_c2ed79d2");
        }
    }
}

