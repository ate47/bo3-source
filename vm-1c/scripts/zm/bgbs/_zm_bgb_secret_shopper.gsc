#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_secret_shopper;

// Namespace zm_bgb_secret_shopper
// Params 0, eflags: 0x2
// namespace_48b6019<file_0>::function_2dc19561
// Checksum 0xe152893d, Offset: 0x1a8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_secret_shopper", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_secret_shopper
// Params 0, eflags: 0x1 linked
// namespace_48b6019<file_0>::function_8c87d8eb
// Checksum 0xd030a5f9, Offset: 0x1e8
// Size: 0x64
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_secret_shopper", "time", 600, &enable, &disable, undefined, undefined);
}

// Namespace zm_bgb_secret_shopper
// Params 0, eflags: 0x1 linked
// namespace_48b6019<file_0>::function_bae40a28
// Checksum 0xb9b1440, Offset: 0x258
// Size: 0x78
function enable() {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"bgb_update");
    bgb::function_650ca64(7);
    while (true) {
        var_2757208f = self waittill(#"zm_bgb_secret_shopper");
        var_2757208f thread function_127dc5ca(self);
    }
}

// Namespace zm_bgb_secret_shopper
// Params 0, eflags: 0x1 linked
// namespace_48b6019<file_0>::function_54bdb053
// Checksum 0x57902796, Offset: 0x2d8
// Size: 0x14
function disable() {
    bgb::function_eabb0903();
}

// Namespace zm_bgb_secret_shopper
// Params 1, eflags: 0x1 linked
// namespace_48b6019<file_0>::function_127dc5ca
// Checksum 0x1b3f0ce1, Offset: 0x2f8
// Size: 0x1a0
function function_127dc5ca(player) {
    self notify(#"hash_127dc5ca");
    self endon(#"hash_127dc5ca");
    self endon(#"kill_trigger");
    self endon(#"hash_a09e2c64");
    player endon(#"bgb_update");
    while (true) {
        player waittill(#"bgb_activation_request");
        if (player.useholdent !== self) {
            continue;
        }
        if (!player bgb::is_enabled("zm_bgb_secret_shopper")) {
            continue;
        }
        w_current = player.currentweapon;
        n_ammo_cost = player zm_weapons::get_ammo_cost_for_weapon(w_current);
        var_b2860cb0 = 0;
        if (player zm_score::can_player_purchase(n_ammo_cost) && !zm_weapons::is_wonder_weapon(w_current)) {
            var_b2860cb0 = player zm_weapons::ammo_give(w_current);
        }
        if (var_b2860cb0) {
            player zm_score::minus_to_player_score(n_ammo_cost);
            player bgb::do_one_shot_use(1);
        } else {
            player bgb::function_ca189700();
        }
        wait(0.05);
    }
}

