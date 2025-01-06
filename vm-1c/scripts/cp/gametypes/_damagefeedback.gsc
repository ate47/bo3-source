#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace damagefeedback;

// Namespace damagefeedback
// Params 0, eflags: 0x2
// Checksum 0x33bed38c, Offset: 0x218
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("damagefeedback", &__init__, undefined, undefined);
}

// Namespace damagefeedback
// Params 0, eflags: 0x0
// Checksum 0x84de7fec, Offset: 0x258
// Size: 0x44
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
}

// Namespace damagefeedback
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x2a8
// Size: 0x4
function init() {
    
}

// Namespace damagefeedback
// Params 0, eflags: 0x0
// Checksum 0xe54991a1, Offset: 0x2b8
// Size: 0xd8
function on_player_connect() {
    self.hud_damagefeedback = newdamageindicatorhudelem(self);
    self.hud_damagefeedback.horzalign = "center";
    self.hud_damagefeedback.vertalign = "middle";
    self.hud_damagefeedback.x = -12;
    self.hud_damagefeedback.y = -12;
    self.hud_damagefeedback.alpha = 0;
    self.hud_damagefeedback.archived = 1;
    self.hud_damagefeedback setshader("damage_feedback", 24, 48);
    self.hitsoundtracker = 1;
}

// Namespace damagefeedback
// Params 1, eflags: 0x0
// Checksum 0xb9b79e31, Offset: 0x398
// Size: 0x66
function should_play_sound(mod) {
    if (!isdefined(mod)) {
        return false;
    }
    switch (mod) {
    case "MOD_CRUSH":
    case "MOD_GRENADE_SPLASH":
    case "MOD_HIT_BY_OBJECT":
    case "MOD_MELEE":
    case "MOD_MELEE_ASSASSINATE":
    case "MOD_MELEE_WEAPON_BUTT":
        return false;
    }
    return true;
}

// Namespace damagefeedback
// Params 3, eflags: 0x0
// Checksum 0x8fd6a397, Offset: 0x408
// Size: 0x260
function update(mod, inflictor, perkfeedback) {
    if (!isplayer(self) || sessionmodeiszombiesgame()) {
        return;
    }
    if (should_play_sound(mod)) {
        if (isdefined(inflictor) && isdefined(inflictor.soundmod)) {
            switch (inflictor.soundmod) {
            case "player":
                self playlocalsound("mpl_hit_alert");
                break;
            case "heli":
                self thread function_a6594fd5(mod, "mpl_hit_alert_air");
                break;
            case "hpm":
                self thread function_a6594fd5(mod, "mpl_hit_alert_hpm");
                break;
            case "taser_spike":
                self thread function_a6594fd5(mod, "mpl_hit_alert_taser_spike");
                break;
            case "dog":
            case "straferun":
                break;
            case "default_loud":
                self thread function_a6594fd5(mod, "mpl_hit_heli_gunner");
                break;
            default:
                self thread function_a6594fd5(mod, "mpl_hit_alert_low");
                break;
            }
        } else {
            self playlocalsound("mpl_hit_alert_low");
        }
    }
    if (isdefined(perkfeedback)) {
    } else {
        self.hud_damagefeedback setshader("damage_feedback", 24, 48);
    }
    self.hud_damagefeedback.alpha = 1;
    self.hud_damagefeedback fadeovertime(1);
    self.hud_damagefeedback.alpha = 0;
}

// Namespace damagefeedback
// Params 2, eflags: 0x0
// Checksum 0x83d2869b, Offset: 0x670
// Size: 0x60
function function_a6594fd5(mod, alert) {
    self endon(#"disconnect");
    if (self.hitsoundtracker) {
        self.hitsoundtracker = 0;
        self playlocalsound(alert);
        wait 0.05;
        self.hitsoundtracker = 1;
    }
}

// Namespace damagefeedback
// Params 1, eflags: 0x0
// Checksum 0x67a874e3, Offset: 0x6d8
// Size: 0xea
function function_7fef183e(hitent) {
    if (!isplayer(self)) {
        return;
    }
    if (!isdefined(hitent)) {
        return;
    }
    if (!isplayer(hitent)) {
        return;
    }
    wait 0.05;
    if (!isdefined(self.var_3f443551)) {
        self.var_3f443551 = [];
        var_1dbcf329 = hitent getentitynumber();
        self.var_3f443551[var_1dbcf329] = 1;
        self thread function_353402e0(hitent);
        return;
    }
    var_1dbcf329 = hitent getentitynumber();
    self.var_3f443551[var_1dbcf329] = 1;
}

// Namespace damagefeedback
// Params 1, eflags: 0x0
// Checksum 0x4c16db74, Offset: 0x7d0
// Size: 0x17e
function function_353402e0(hitent) {
    self endon(#"disconnect");
    waittillframeend();
    var_e1c02941 = 0;
    value = 1;
    var_4f484664 = 0;
    for (i = 0; i < 32; i++) {
        if (isdefined(self.var_3f443551[i]) && self.var_3f443551[i] != 0) {
            var_4f484664 += value;
            var_e1c02941++;
        }
        value *= 2;
    }
    var_754ac0cd = 0;
    for (i = 33; i < 64; i++) {
        if (isdefined(self.var_3f443551[i]) && self.var_3f443551[i] != 0) {
            var_754ac0cd += value;
            var_e1c02941++;
        }
        value *= 2;
    }
    if (var_e1c02941) {
        self directionalhitindicator(var_4f484664, var_754ac0cd);
    }
    self.var_3f443551 = undefined;
    var_4f484664 = 0;
    var_754ac0cd = 0;
}

