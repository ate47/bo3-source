#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace damagefeedback;

// Namespace damagefeedback
// Params 0, eflags: 0x0
// Checksum 0xc1cddca, Offset: 0x210
// Size: 0x44
function __init__() {
    callback::on_start_gametype(&main);
    callback::on_connect(&on_player_connect);
}

// Namespace damagefeedback
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x260
// Size: 0x4
function main() {
    
}

// Namespace damagefeedback
// Params 0, eflags: 0x1 linked
// Checksum 0x1a5d1ac9, Offset: 0x270
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
// Params 1, eflags: 0x1 linked
// Checksum 0xd1f3c81d, Offset: 0x350
// Size: 0x66
function should_play_sound(mod) {
    if (!isdefined(mod)) {
        return false;
    }
    switch (mod) {
    case 3:
    case 4:
    case 5:
    case 6:
    case 7:
    case 8:
        return false;
    }
    return true;
}

// Namespace damagefeedback
// Params 3, eflags: 0x1 linked
// Checksum 0x2ecbf3a1, Offset: 0x3c0
// Size: 0x270
function updatedamagefeedback(mod, inflictor, perkfeedback) {
    if (!isplayer(self) || sessionmodeiszombiesgame()) {
        return;
    }
    if (should_play_sound(mod)) {
        if (isdefined(inflictor) && isdefined(inflictor.soundmod)) {
            switch (inflictor.soundmod) {
            case 19:
                self thread function_624a623b(mod, "mpl_hit_alert");
                break;
            case 17:
                self thread function_624a623b(mod, "mpl_hit_alert_air");
                break;
            case 18:
                self thread function_624a623b(mod, "mpl_hit_alert_hpm");
                break;
            case 21:
                self thread function_624a623b(mod, "mpl_hit_alert_taser_spike");
                break;
            case 16:
            case 20:
                break;
            case 15:
                self thread function_624a623b(mod, "mpl_hit_heli_gunner");
                break;
            default:
                self thread function_624a623b(mod, "mpl_hit_alert_low");
                break;
            }
        } else {
            self thread function_624a623b(mod, "mpl_hit_alert_low");
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
// Params 2, eflags: 0x1 linked
// Checksum 0x6f63d84d, Offset: 0x638
// Size: 0x60
function function_624a623b(mod, alert) {
    self endon(#"disconnect");
    if (self.hitsoundtracker) {
        self.hitsoundtracker = 0;
        self playlocalsound(alert);
        wait(0.05);
        self.hitsoundtracker = 1;
    }
}

// Namespace damagefeedback
// Params 1, eflags: 0x0
// Checksum 0x9659774, Offset: 0x6a0
// Size: 0xea
function function_cffe043d(hitent) {
    if (!isplayer(self)) {
        return;
    }
    if (!isdefined(hitent)) {
        return;
    }
    if (!isplayer(hitent)) {
        return;
    }
    wait(0.05);
    if (!isdefined(self.var_3f443551)) {
        self.var_3f443551 = [];
        var_1dbcf329 = hitent getentitynumber();
        self.var_3f443551[var_1dbcf329] = 1;
        self thread function_4c506f90(hitent);
        return;
    }
    var_1dbcf329 = hitent getentitynumber();
    self.var_3f443551[var_1dbcf329] = 1;
}

// Namespace damagefeedback
// Params 1, eflags: 0x1 linked
// Checksum 0xeea33415, Offset: 0x798
// Size: 0x17e
function function_4c506f90(hitent) {
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

