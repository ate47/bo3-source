#using scripts/shared/postfx_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace sticky_grenade;

// Namespace sticky_grenade
// Params 0, eflags: 0x2
// Checksum 0xf63bfe3b, Offset: 0x1d0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("spike_charge", &__init__, undefined, undefined);
}

// Namespace sticky_grenade
// Params 0, eflags: 0x1 linked
// Checksum 0xba7cf905, Offset: 0x210
// Size: 0x94
function __init__() {
    level._effect["spike_light"] = "weapon/fx_light_spike_launcher";
    callback::add_weapon_type("spike_launcher", &spawned);
    callback::add_weapon_type("spike_launcher_cpzm", &spawned);
    callback::add_weapon_type("spike_charge", &spawned_spike_charge);
}

// Namespace sticky_grenade
// Params 1, eflags: 0x1 linked
// Checksum 0xd5bf0bf6, Offset: 0x2b0
// Size: 0x24
function spawned(localclientnum) {
    self thread fx_think(localclientnum);
}

// Namespace sticky_grenade
// Params 1, eflags: 0x1 linked
// Checksum 0xf6da891f, Offset: 0x2e0
// Size: 0x3c
function spawned_spike_charge(localclientnum) {
    self thread fx_think(localclientnum);
    self thread spike_detonation(localclientnum);
}

// Namespace sticky_grenade
// Params 1, eflags: 0x1 linked
// Checksum 0x59ff6660, Offset: 0x328
// Size: 0x10c
function fx_think(localclientnum) {
    self notify(#"light_disable");
    self endon(#"entityshutdown");
    self endon(#"light_disable");
    self util::waittill_dobj(localclientnum);
    for (interval = 0.3; ; interval = math::clamp(interval / 1.2, 0.08, 0.3)) {
        self stop_light_fx(localclientnum);
        self start_light_fx(localclientnum);
        util::server_wait(localclientnum, interval, 0.01, "player_switch");
        self util::waittill_dobj(localclientnum);
    }
}

// Namespace sticky_grenade
// Params 1, eflags: 0x1 linked
// Checksum 0x4ad23d31, Offset: 0x440
// Size: 0x6c
function start_light_fx(localclientnum) {
    player = getlocalplayer(localclientnum);
    self.fx = playfxontag(localclientnum, level._effect["spike_light"], self, "tag_fx");
}

// Namespace sticky_grenade
// Params 1, eflags: 0x1 linked
// Checksum 0x37edc037, Offset: 0x4b8
// Size: 0x4e
function stop_light_fx(localclientnum) {
    if (isdefined(self.fx) && self.fx != 0) {
        stopfx(localclientnum, self.fx);
        self.fx = undefined;
    }
}

// Namespace sticky_grenade
// Params 1, eflags: 0x1 linked
// Checksum 0x501c98ef, Offset: 0x510
// Size: 0x104
function spike_detonation(localclientnum) {
    spike_position = self.origin;
    while (isdefined(self)) {
        wait 0.016;
    }
    if (!isigcactive(localclientnum)) {
        player = getlocalplayer(localclientnum);
        explosion_distance = distancesquared(spike_position, player.origin);
        if (explosion_distance <= 450 * 450) {
            player thread postfx::playpostfxbundle("pstfx_dust_chalk");
        }
        if (explosion_distance <= 300 * 300) {
            player thread postfx::playpostfxbundle("pstfx_dust_concrete");
        }
    }
}

