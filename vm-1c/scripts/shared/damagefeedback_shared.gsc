#using scripts/shared/abilities/gadgets/_gadget_armor;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/weapons_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace damagefeedback;

// Namespace damagefeedback
// Params 0, eflags: 0x2
// namespace_fc79db9f<file_0>::function_2dc19561
// Checksum 0xcc0be710, Offset: 0x460
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("damagefeedback", &__init__, undefined, undefined);
}

// Namespace damagefeedback
// Params 0, eflags: 0x1 linked
// namespace_fc79db9f<file_0>::function_8c87d8eb
// Checksum 0x512f8a1a, Offset: 0x4a0
// Size: 0x44
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
}

// Namespace damagefeedback
// Params 0, eflags: 0x1 linked
// namespace_fc79db9f<file_0>::function_c35e6aab
// Checksum 0x99ec1590, Offset: 0x4f0
// Size: 0x4
function init() {
    
}

// Namespace damagefeedback
// Params 0, eflags: 0x1 linked
// namespace_fc79db9f<file_0>::function_fb4f96b5
// Checksum 0xaee135b6, Offset: 0x500
// Size: 0x1a4
function on_player_connect() {
    if (!sessionmodeismultiplayergame()) {
        self.hud_damagefeedback = newdamageindicatorhudelem(self);
        self.hud_damagefeedback.horzalign = "center";
        self.hud_damagefeedback.vertalign = "middle";
        self.hud_damagefeedback.x = -11;
        self.hud_damagefeedback.y = -11;
        self.hud_damagefeedback.alpha = 0;
        self.hud_damagefeedback.archived = 1;
        self.hud_damagefeedback setshader("damage_feedback", 22, 44);
        self.hud_damagefeedback_additional = newdamageindicatorhudelem(self);
        self.hud_damagefeedback_additional.horzalign = "center";
        self.hud_damagefeedback_additional.vertalign = "middle";
        self.hud_damagefeedback_additional.x = -12;
        self.hud_damagefeedback_additional.y = -12;
        self.hud_damagefeedback_additional.alpha = 0;
        self.hud_damagefeedback_additional.archived = 1;
        self.hud_damagefeedback_additional setshader("damage_feedback", 24, 48);
    }
}

// Namespace damagefeedback
// Params 1, eflags: 0x1 linked
// namespace_fc79db9f<file_0>::function_660af82d
// Checksum 0x2c4ef333, Offset: 0x6b0
// Size: 0x66
function should_play_sound(mod) {
    if (!isdefined(mod)) {
        return false;
    }
    switch (mod) {
    case 4:
    case 5:
    case 6:
    case 7:
    case 8:
    case 9:
        return false;
    }
    return true;
}

// Namespace damagefeedback
// Params 7, eflags: 0x1 linked
// namespace_fc79db9f<file_0>::function_debccd1a
// Checksum 0xd46f59ff, Offset: 0x720
// Size: 0x810
function update(mod, inflictor, perkfeedback, weapon, victim, psoffsettime, shitloc) {
    if (!isplayer(self)) {
        return;
    }
    if (isdefined(self.nohitmarkers) && self.nohitmarkers) {
        return 0;
    }
    if (isdefined(weapon.nohitmarker) && isdefined(weapon) && weapon.nohitmarker) {
        return;
    }
    if (!isdefined(self.lasthitmarkertime)) {
        self.lasthitmarkertimes = [];
        self.lasthitmarkertime = 0;
        self.lasthitmarkeroffsettime = 0;
    }
    if (isdefined(psoffsettime)) {
        victim_id = victim getentitynumber();
        if (!isdefined(self.lasthitmarkertimes[victim_id])) {
            self.lasthitmarkertimes[victim_id] = 0;
        }
        if (self.lasthitmarkertime == gettime()) {
            if (self.lasthitmarkertimes[victim_id] === psoffsettime) {
                return;
            }
        }
        self.lasthitmarkeroffsettime = psoffsettime;
        self.lasthitmarkertimes[victim_id] = psoffsettime;
    } else if (self.lasthitmarkertime == gettime()) {
        return;
    }
    self.lasthitmarkertime = gettime();
    hitalias = undefined;
    if (should_play_sound(mod)) {
        if (isdefined(victim) && isdefined(victim.victimsoundmod)) {
            switch (victim.victimsoundmod) {
            case 12:
                hitalias = "mpl_hit_alert_escort";
                break;
            default:
                hitalias = "mpl_hit_alert";
                break;
            }
        } else if (isdefined(inflictor) && isdefined(inflictor.soundmod)) {
            switch (inflictor.soundmod) {
            case 32:
                if (isdefined(victim.isaiclone) && isdefined(victim) && victim.isaiclone) {
                    hitalias = "mpl_hit_alert_clone";
                } else if (isdefined(victim) && isplayer(victim) && victim flagsys::get("gadget_armor_on") && armor::function_4a835afe(inflictor, weapon, mod, shitloc)) {
                    hitalias = "mpl_hit_alert_armor";
                } else if (isdefined(victim) && isplayer(victim) && isdefined(victim.carryobject) && isdefined(victim.carryobject.hitsound) && isdefined(perkfeedback) && perkfeedback == "armor") {
                    hitalias = victim.carryobject.hitsound;
                } else if (mod == "MOD_BURNED") {
                    hitalias = "mpl_hit_alert_burn";
                } else {
                    hitalias = "mpl_hit_alert";
                }
                break;
            case 29:
                hitalias = "mpl_hit_alert_heatwave";
                break;
            case 30:
                hitalias = "mpl_hit_alert_air";
                break;
            case 31:
                hitalias = "mpl_hit_alert_hpm";
                break;
            case 35:
                hitalias = "mpl_hit_alert_taser_spike";
                break;
            case 26:
            case 34:
                break;
            case 28:
                hitalias = "mpl_hit_alert_firefly";
                break;
            case 27:
                hitalias = "mpl_hit_alert_air";
                break;
            case 33:
                hitalias = "mpl_hit_alert_air";
                break;
            case 25:
                hitalias = "mpl_hit_heli_gunner";
                break;
            default:
                hitalias = "mpl_hit_alert";
                break;
            }
        } else if (mod == "MOD_BURNED") {
            hitalias = "mpl_hit_alert_burn";
        } else {
            hitalias = "mpl_hit_alert";
        }
    }
    if (isdefined(victim.isaiclone) && isdefined(victim) && victim.isaiclone) {
        self playhitmarker(hitalias);
        return;
    }
    damagestage = 1;
    if (isdefined(level.growing_hitmarker) && isdefined(victim) && isplayer(victim)) {
        damagestage = damage_feedback_get_stage(victim);
    }
    self playhitmarker(hitalias, damagestage, perkfeedback, damage_feedback_get_dead(victim, mod, weapon, damagestage));
    if (isdefined(perkfeedback)) {
        if (isdefined(self.hud_damagefeedback_additional)) {
            switch (perkfeedback) {
            case 39:
                self.hud_damagefeedback_additional setshader("damage_feedback_flak", 24, 48);
                break;
            case 40:
                self.hud_damagefeedback_additional setshader("damage_feedback_tac", 24, 48);
                break;
            case 16:
                self.hud_damagefeedback_additional setshader("damage_feedback_armor", 24, 48);
                break;
            }
            self.hud_damagefeedback_additional.alpha = 1;
            self.hud_damagefeedback_additional fadeovertime(1);
            self.hud_damagefeedback_additional.alpha = 0;
        }
    } else if (isdefined(self.hud_damagefeedback)) {
        self.hud_damagefeedback setshader("damage_feedback", 24, 48);
    }
    if (isdefined(self.hud_damagefeedback) && isdefined(level.growing_hitmarker) && isdefined(victim) && isplayer(victim)) {
        self thread damage_feedback_growth(victim, mod, weapon);
        return;
    }
    if (isdefined(self.hud_damagefeedback)) {
        self.hud_damagefeedback.x = -12;
        self.hud_damagefeedback.y = -12;
        self.hud_damagefeedback.alpha = 1;
        self.hud_damagefeedback fadeovertime(1);
        self.hud_damagefeedback.alpha = 0;
    }
}

// Namespace damagefeedback
// Params 1, eflags: 0x1 linked
// namespace_fc79db9f<file_0>::function_fa6998f2
// Checksum 0x84feb203, Offset: 0xf38
// Size: 0xf2
function damage_feedback_get_stage(victim) {
    if (isdefined(victim.laststand) && victim.laststand) {
        return 5;
    }
    if (victim.health / victim.maxhealth > 0.74) {
        return 1;
    }
    if (victim.health / victim.maxhealth > 0.49) {
        return 2;
    }
    if (victim.health / victim.maxhealth > 0.24) {
        return 3;
    }
    if (victim.health > 0) {
        return 4;
    }
    return 5;
}

// Namespace damagefeedback
// Params 4, eflags: 0x1 linked
// namespace_fc79db9f<file_0>::function_1ddcb8f2
// Checksum 0x9ef09f7c, Offset: 0x1038
// Size: 0xee
function damage_feedback_get_dead(victim, mod, weapon, stage) {
    return isdefined(weapon.isheroweapon) && (mod == "MOD_BULLET" || mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET" || stage == 5 && mod == "MOD_HEAD_SHOT") && !weapon.isheroweapon && !killstreaks::is_killstreak_weapon(weapon) && !(weapon.name === "siegebot_gun_turret") && !(weapon.name === "siegebot_launcher_turret");
}

// Namespace damagefeedback
// Params 3, eflags: 0x1 linked
// namespace_fc79db9f<file_0>::function_89f05052
// Checksum 0x124420a5, Offset: 0x1130
// Size: 0x1b8
function damage_feedback_growth(victim, mod, weapon) {
    if (isdefined(self.hud_damagefeedback)) {
        stage = damage_feedback_get_stage(victim);
        self.hud_damagefeedback.x = -11 + -1 * stage;
        self.hud_damagefeedback.y = -11 + -1 * stage;
        size_x = 22 + 2 * stage;
        size_y = size_x * 2;
        self.hud_damagefeedback setshader("damage_feedback", size_x, size_y);
        if (damage_feedback_get_dead(victim, mod, weapon, stage)) {
            self.hud_damagefeedback setshader("damage_feedback_glow_orange", size_x, size_y);
            self thread kill_hitmarker_fade();
            return;
        }
        self.hud_damagefeedback setshader("damage_feedback", size_x, size_y);
        self.hud_damagefeedback.alpha = 1;
        self.hud_damagefeedback fadeovertime(1);
        self.hud_damagefeedback.alpha = 0;
    }
}

// Namespace damagefeedback
// Params 0, eflags: 0x1 linked
// namespace_fc79db9f<file_0>::function_31f1133a
// Checksum 0x9954625d, Offset: 0x12f0
// Size: 0x80
function kill_hitmarker_fade() {
    self notify(#"kill_hitmarker_fade");
    self endon(#"kill_hitmarker_fade");
    self endon(#"disconnect");
    self.hud_damagefeedback.alpha = 1;
    wait(0.25);
    self.hud_damagefeedback fadeovertime(0.3);
    self.hud_damagefeedback.alpha = 0;
}

// Namespace damagefeedback
// Params 3, eflags: 0x1 linked
// namespace_fc79db9f<file_0>::function_2a720981
// Checksum 0x96fde0, Offset: 0x1378
// Size: 0x160
function update_override(icon, sound, additional_icon) {
    if (!isplayer(self)) {
        return;
    }
    self playlocalsound(sound);
    if (isdefined(self.hud_damagefeedback)) {
        self.hud_damagefeedback setshader(icon, 24, 48);
        self.hud_damagefeedback.alpha = 1;
        self.hud_damagefeedback fadeovertime(1);
        self.hud_damagefeedback.alpha = 0;
    }
    if (isdefined(self.hud_damagefeedback_additional)) {
        if (!isdefined(additional_icon)) {
            self.hud_damagefeedback_additional.alpha = 0;
            return;
        }
        self.hud_damagefeedback_additional setshader(additional_icon, 24, 48);
        self.hud_damagefeedback_additional.alpha = 1;
        self.hud_damagefeedback_additional fadeovertime(1);
        self.hud_damagefeedback_additional.alpha = 0;
    }
}

// Namespace damagefeedback
// Params 1, eflags: 0x0
// namespace_fc79db9f<file_0>::function_7fef183e
// Checksum 0x53efd249, Offset: 0x14e0
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
    wait(0.05);
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
// Params 1, eflags: 0x1 linked
// namespace_fc79db9f<file_0>::function_353402e0
// Checksum 0xa662c161, Offset: 0x15d8
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

// Namespace damagefeedback
// Params 4, eflags: 0x1 linked
// namespace_fc79db9f<file_0>::function_a2f24e04
// Checksum 0x9ad3c964, Offset: 0x1760
// Size: 0xbe
function dodamagefeedback(weapon, einflictor, idamage, smeansofdeath) {
    if (!isdefined(weapon)) {
        return false;
    }
    if (isdefined(weapon.nohitmarker) && weapon.nohitmarker) {
        return false;
    }
    if (level.allowhitmarkers == 0) {
        return false;
    }
    if (level.allowhitmarkers == 1) {
        if (isdefined(smeansofdeath) && isdefined(idamage)) {
            if (istacticalhitmarker(weapon, smeansofdeath, idamage)) {
                return false;
            }
        }
    }
    return true;
}

// Namespace damagefeedback
// Params 3, eflags: 0x1 linked
// namespace_fc79db9f<file_0>::function_9e573ca3
// Checksum 0xfc86bb54, Offset: 0x1828
// Size: 0x80
function istacticalhitmarker(weapon, smeansofdeath, idamage) {
    if (weapons::is_grenade(weapon)) {
        if ("Smoke Grenade" == weapon.offhandclass) {
            if (smeansofdeath == "MOD_GRENADE_SPLASH") {
                return true;
            }
        } else if (idamage == 1) {
            return true;
        }
    }
    return false;
}

