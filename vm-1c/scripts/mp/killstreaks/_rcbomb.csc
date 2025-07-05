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
// Checksum 0x5841e3e2, Offset: 0x3f8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("rcbomb", &__init__, undefined, undefined);
}

// Namespace rcbomb
// Params 0, eflags: 0x0
// Checksum 0xc34ec220, Offset: 0x438
// Size: 0x124
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
// Checksum 0x589b0510, Offset: 0x568
// Size: 0xac
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
// Checksum 0xe2b080b1, Offset: 0x620
// Size: 0x70
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
// Checksum 0x92166ed, Offset: 0x698
// Size: 0xec
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
// Checksum 0xbbe128ca, Offset: 0x790
// Size: 0x40
function boost_think(localclientnum) {
    self endon(#"entityshutdown");
    for (;;) {
        self waittill(#"veh_boost");
        self boost_blur(localclientnum);
    }
}

// Namespace rcbomb
// Params 1, eflags: 0x0
// Checksum 0x352b2b00, Offset: 0x7d8
// Size: 0x2c
function shutdown_think(localclientnum) {
    self waittill(#"entityshutdown");
    disablespeedblur(localclientnum);
}

// Namespace rcbomb
// Params 1, eflags: 0x0
// Checksum 0xe90b31e1, Offset: 0x810
// Size: 0xc
function function_3e13e5c5(localclientnum) {
    
}

// Namespace rcbomb
// Params 1, eflags: 0x0
// Checksum 0xcf6f7b27, Offset: 0x828
// Size: 0xc
function function_ba7b10a6(localclientnum) {
    
}

// Namespace rcbomb
// Params 1, eflags: 0x0
// Checksum 0xa1ee086d, Offset: 0x840
// Size: 0x122
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
// Checksum 0x6453fcfe, Offset: 0x970
// Size: 0x90
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
// Checksum 0x949acdba, Offset: 0xa08
// Size: 0x90
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
// Checksum 0x1e3e0337, Offset: 0xaa0
// Size: 0x44
function notstunnedhandler(localclientnum) {
    self endon(#"entityshutdown");
    self endon(#"stunned");
    self waittill(#"not_stunned");
    self setstunned(0);
}

// Namespace rcbomb
// Params 1, eflags: 0x0
// Checksum 0x8c318aa1, Offset: 0xaf0
// Size: 0x70
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
// Checksum 0x13a9b3a4, Offset: 0xb68
// Size: 0x98
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
// Checksum 0xfacf62c9, Offset: 0xc08
// Size: 0x124
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
// Checksum 0xebcdba72, Offset: 0xd38
// Size: 0x14
function ondrivingfxjumplanding(localclientnum, player) {
    
}

