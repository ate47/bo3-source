#using scripts/codescripts/struct;
#using scripts/mp/_callbacks;
#using scripts/mp/_util;
#using scripts/mp/_vehicle;
#using scripts/shared/clientfield_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_driving_fx;

#namespace rcbomb;

// Namespace rcbomb
// Params 0, eflags: 0x2
// Checksum 0x2e55d1b4, Offset: 0x3f8
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("rcbomb", &__init__, undefined, undefined);
}

// Namespace rcbomb
// Params 0, eflags: 0x0
// Checksum 0xeb5ec001, Offset: 0x430
// Size: 0x102
function __init__() {
    level._effect["rcbomb_enemy_light"] = "killstreaks/fx_rcxd_lights_blinky";
    level._effect["rcbomb_friendly_light"] = "killstreaks/fx_rcxd_lights_solid";
    level._effect["rcbomb_enemy_light_blink"] = "killstreaks/fx_rcxd_lights_red";
    level._effect["rcbomb_friendly_light_blink"] = "killstreaks/fx_rcxd_lights_grn";
    level._effect["rcbomb_stunned"] = "_t6/weapon/grenade/fx_spark_disabled_rc_car";
    level.var_59d1e4 = struct::get_script_bundle("killstreak", "killstreak_rcbomb");
    clientfield::register("vehicle", "rcbomb_stunned", 1, 1, "int", &callback::callback_stunned, 0, 0);
    vehicle::add_vehicletype_callback("rc_car_mp", &spawned);
}

// Namespace rcbomb
// Params 1, eflags: 0x0
// Checksum 0xa7147045, Offset: 0x540
// Size: 0x8a
function spawned(localclientnum) {
    self thread demo_think(localclientnum);
    self thread stunnedhandler(localclientnum);
    self thread boost_think(localclientnum);
    self thread shutdown_think(localclientnum);
    self.driving_fx_collision_override = &ondrivingfxcollision;
    self.driving_fx_jump_landing_override = &ondrivingfxjumplanding;
    self.killstreakbundle = level.var_59d1e4;
}

// Namespace rcbomb
// Params 1, eflags: 0x0
// Checksum 0x58a15fac, Offset: 0x5d8
// Size: 0x55
function demo_think(localclientnum) {
    self endon(#"entityshutdown");
    if (!isdemoplaying()) {
        return;
    }
    for (;;) {
        level util::waittill_any("demo_jump", "demo_player_switch");
        self vehicle::lights_off(localclientnum);
    }
}

// Namespace rcbomb
// Params 1, eflags: 0x0
// Checksum 0x5d32c249, Offset: 0x638
// Size: 0xda
function boost_blur(localclientnum) {
    self endon(#"entityshutdown");
    if (isdefined(self.owner) && self.owner islocalplayer()) {
        enablespeedblur(localclientnum, getdvarfloat("scr_rcbomb_amount", 0.1), getdvarfloat("scr_rcbomb_inner_radius", 0.5), getdvarfloat("scr_rcbomb_outer_radius", 0.75), 0, 0);
        wait getdvarfloat("scr_rcbomb_duration", 1);
        disablespeedblur(localclientnum);
    }
}

// Namespace rcbomb
// Params 1, eflags: 0x0
// Checksum 0x8a4d95cd, Offset: 0x720
// Size: 0x35
function boost_think(localclientnum) {
    self endon(#"entityshutdown");
    for (;;) {
        self waittill(#"veh_boost");
        self boost_blur(localclientnum);
    }
}

// Namespace rcbomb
// Params 1, eflags: 0x0
// Checksum 0x6930e2d9, Offset: 0x760
// Size: 0x22
function shutdown_think(localclientnum) {
    self waittill(#"entityshutdown");
    disablespeedblur(localclientnum);
}

// Namespace rcbomb
// Params 1, eflags: 0x0
// Checksum 0xc3e05d78, Offset: 0x790
// Size: 0xa
function function_3e13e5c5(localclientnum) {
    
}

// Namespace rcbomb
// Params 1, eflags: 0x0
// Checksum 0x25062a0e, Offset: 0x7a8
// Size: 0xa
function function_ba7b10a6(localclientnum) {
    
}

// Namespace rcbomb
// Params 1, eflags: 0x0
// Checksum 0x513432c6, Offset: 0x7c0
// Size: 0xd1
function function_99f36ceb(localclientnum) {
    var_53b07afb = 0;
    while (true) {
        speed = self getspeed();
        maxspeed = self getmaxspeed();
        if (speed < 0) {
            maxspeed = self getmaxreversespeed();
        }
        if (maxspeed > 0) {
            var_53b07afb = abs(speed) / maxspeed;
        } else {
            var_53b07afb = 0;
        }
        if (self iswheelcolliding("back_left") || self iswheelcolliding("back_right")) {
            if (self islocalclientdriver(localclientnum)) {
            }
        }
    }
}

// Namespace rcbomb
// Params 1, eflags: 0x0
// Checksum 0x2be44796, Offset: 0x8a0
// Size: 0x75
function play_boost_fx(localclientnum) {
    self endon(#"entityshutdown");
    while (true) {
        speed = self getspeed();
        if (speed > 400) {
            self playsound(localclientnum, "mpl_veh_rc_boost");
            return;
        }
        util::server_wait(localclientnum, 0.1);
    }
}

// Namespace rcbomb
// Params 1, eflags: 0x0
// Checksum 0x4d07510a, Offset: 0x920
// Size: 0x65
function stunnedhandler(localclientnum) {
    self endon(#"entityshutdown");
    self thread enginestutterhandler(localclientnum);
    while (true) {
        self waittill(#"stunned");
        self setstunned(1);
        self thread notstunnedhandler(localclientnum);
        self thread play_stunned_fx_handler(localclientnum);
    }
}

// Namespace rcbomb
// Params 1, eflags: 0x0
// Checksum 0x3f5f8a26, Offset: 0x990
// Size: 0x32
function notstunnedhandler(localclientnum) {
    self endon(#"entityshutdown");
    self endon(#"stunned");
    self waittill(#"not_stunned");
    self setstunned(0);
}

// Namespace rcbomb
// Params 1, eflags: 0x0
// Checksum 0x3eb77c1f, Offset: 0x9d0
// Size: 0x5d
function play_stunned_fx_handler(localclientnum) {
    self endon(#"entityshutdown");
    self endon(#"stunned");
    self endon(#"not_stunned");
    while (true) {
        playfxontag(localclientnum, level._effect["rcbomb_stunned"], self, "tag_origin");
        wait 0.5;
    }
}

// Namespace rcbomb
// Params 1, eflags: 0x0
// Checksum 0x56327326, Offset: 0xa38
// Size: 0x7d
function enginestutterhandler(localclientnum) {
    self endon(#"entityshutdown");
    while (true) {
        self waittill(#"veh_engine_stutter");
        if (self islocalclientdriver(localclientnum)) {
            player = getlocalplayer(localclientnum);
            if (isdefined(player)) {
                player playrumbleonentity(localclientnum, "rcbomb_engine_stutter");
            }
        }
    }
}

// Namespace rcbomb
// Params 5, eflags: 0x0
// Checksum 0x4b485ec5, Offset: 0xac0
// Size: 0xf2
function ondrivingfxcollision(localclientnum, player, hip, hitn, hit_intensity) {
    if (isdefined(hit_intensity) && hit_intensity > 15) {
        volume = driving_fx::get_impact_vol_from_speed();
        if (isdefined(self.sounddef)) {
            alias = self.sounddef + "_suspension_lg_hd";
        } else {
            alias = "veh_default_suspension_lg_hd";
        }
        id = playsound(0, alias, self.origin, volume);
        player earthquake(0.7, 0.25, player.origin, 1500);
        player playrumbleonentity(localclientnum, "damage_heavy");
    }
}

// Namespace rcbomb
// Params 2, eflags: 0x0
// Checksum 0x58bc22a2, Offset: 0xbc0
// Size: 0x12
function ondrivingfxjumplanding(localclientnum, player) {
    
}

