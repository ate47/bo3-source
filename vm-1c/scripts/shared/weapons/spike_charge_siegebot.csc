#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace spike_charge_siegebot;

// Namespace spike_charge_siegebot
// Params 0, eflags: 0x2
// namespace_edb77a33<file_0>::function_2dc19561
// Checksum 0x1ab6f6e8, Offset: 0x210
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("spike_charge_siegebot", &__init__, undefined, undefined);
}

// Namespace spike_charge_siegebot
// Params 0, eflags: 0x1 linked
// namespace_edb77a33<file_0>::function_8c87d8eb
// Checksum 0xe9fe437f, Offset: 0x250
// Size: 0xe4
function __init__() {
    level._effect["spike_charge_siegebot_light"] = "light/fx_light_red_spike_charge_os";
    callback::add_weapon_type("spike_charge_siegebot", &spawned);
    callback::add_weapon_type("spike_charge_siegebot_theia", &spawned);
    callback::add_weapon_type("siegebot_launcher_turret", &spawned);
    callback::add_weapon_type("siegebot_launcher_turret_theia", &spawned);
    callback::add_weapon_type("siegebot_javelin_turret", &spawned);
}

// Namespace spike_charge_siegebot
// Params 1, eflags: 0x1 linked
// namespace_edb77a33<file_0>::function_ab1f9ea1
// Checksum 0x2589692d, Offset: 0x340
// Size: 0x24
function spawned(localclientnum) {
    self thread fx_think(localclientnum);
}

// Namespace spike_charge_siegebot
// Params 1, eflags: 0x1 linked
// namespace_edb77a33<file_0>::function_e18161a
// Checksum 0x52ff7fb3, Offset: 0x370
// Size: 0x12c
function fx_think(localclientnum) {
    self notify(#"light_disable");
    self endon(#"entityshutdown");
    self endon(#"light_disable");
    self util::waittill_dobj(localclientnum);
    for (interval = 0.3; ; interval = math::clamp(interval / 1.2, 0.08, 0.3)) {
        self stop_light_fx(localclientnum);
        self start_light_fx(localclientnum);
        self playsound(localclientnum, "wpn_semtex_alert");
        util::server_wait(localclientnum, interval, 0.01, "player_switch");
        self util::waittill_dobj(localclientnum);
    }
}

// Namespace spike_charge_siegebot
// Params 1, eflags: 0x1 linked
// namespace_edb77a33<file_0>::function_d2e7a133
// Checksum 0xb2adaa4c, Offset: 0x4a8
// Size: 0x6c
function start_light_fx(localclientnum) {
    player = getlocalplayer(localclientnum);
    self.fx = playfxontag(localclientnum, level._effect["spike_charge_siegebot_light"], self, "tag_fx");
}

// Namespace spike_charge_siegebot
// Params 1, eflags: 0x1 linked
// namespace_edb77a33<file_0>::function_958821cd
// Checksum 0x8bfb3149, Offset: 0x520
// Size: 0x4e
function stop_light_fx(localclientnum) {
    if (isdefined(self.fx) && self.fx != 0) {
        stopfx(localclientnum, self.fx);
        self.fx = undefined;
    }
}

