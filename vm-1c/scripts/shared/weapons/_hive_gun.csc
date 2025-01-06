#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/weapons/_weaponobjects;

#namespace hive_gun;

// Namespace hive_gun
// Params 0, eflags: 0x0
// Checksum 0xa687986d, Offset: 0x3a0
// Size: 0x1c
function init_shared() {
    level thread register();
}

// Namespace hive_gun
// Params 0, eflags: 0x0
// Checksum 0x72891d0a, Offset: 0x3c8
// Size: 0xdc
function register() {
    clientfield::register("scriptmover", "firefly_state", 1, 3, "int", &function_4dc1ebd, 0, 0);
    clientfield::register("toplayer", "fireflies_attacking", 1, 1, "int", &fireflies_attacking, 0, 1);
    clientfield::register("toplayer", "fireflies_chasing", 1, 1, "int", &fireflies_chasing, 0, 1);
}

// Namespace hive_gun
// Params 1, eflags: 0x0
// Checksum 0x2a432276, Offset: 0x4b0
// Size: 0x4c
function getotherteam(team) {
    if (team == "allies") {
        return "axis";
    }
    if (team == "axis") {
        return "allies";
    }
    return "free";
}

// Namespace hive_gun
// Params 7, eflags: 0x0
// Checksum 0xf387e8a9, Offset: 0x508
// Size: 0x10e
function fireflies_attacking(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        self notify(#"stop_player_fx");
        if (self islocalplayer() && !self getinkillcam(localclientnum)) {
            fx = playfxoncamera(localclientnum, "weapon/fx_ability_firefly_attack_1p", (0, 0, 0), (1, 0, 0), (0, 0, 1));
            self thread function_38574d7c(localclientnum, fx);
        }
        return;
    }
    self notify(#"stop_player_fx");
}

// Namespace hive_gun
// Params 7, eflags: 0x0
// Checksum 0xa5d1ac2a, Offset: 0x620
// Size: 0x15e
function fireflies_chasing(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        self notify(#"stop_player_fx");
        if (self islocalplayer() && !self getinkillcam(localclientnum)) {
            fx = playfxoncamera(localclientnum, "weapon/fx_ability_firefly_chase_1p", (0, 0, 0), (1, 0, 0), (0, 0, 1));
            sound = self playloopsound("wpn_gelgun_hive_hunt_lp");
            self playrumblelooponentity(localclientnum, "firefly_chase_rumble_loop");
            self thread function_38574d7c(localclientnum, fx, sound);
        }
        return;
    }
    self notify(#"stop_player_fx");
}

// Namespace hive_gun
// Params 3, eflags: 0x0
// Checksum 0x67fc62a1, Offset: 0x788
// Size: 0xbc
function function_38574d7c(localclientnum, fx, sound) {
    self util::waittill_any("entityshutdown", "stop_player_fx");
    if (isdefined(self)) {
        self stoprumble(localclientnum, "firefly_chase_rumble_loop");
    }
    if (isdefined(fx)) {
        stopfx(localclientnum, fx);
    }
    if (isdefined(sound) && isdefined(self)) {
        self stoploopsound(sound);
    }
}

// Namespace hive_gun
// Params 7, eflags: 0x0
// Checksum 0x184cfd32, Offset: 0x850
// Size: 0x14e
function function_4dc1ebd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.var_80262773)) {
        self thread function_40245849(localclientnum);
        self.var_80262773 = 1;
    }
    switch (newval) {
    case 0:
        break;
    case 1:
        self function_231d32d6(localclientnum);
        break;
    case 2:
        self function_3115859c(localclientnum);
        break;
    case 3:
        self function_c0c4f0d9(localclientnum);
        break;
    case 4:
        self function_c2dd71e6(localclientnum);
        break;
    }
}

// Namespace hive_gun
// Params 2, eflags: 0x0
// Checksum 0x93f98983, Offset: 0x9a8
// Size: 0xb4
function on_shutdown(localclientnum, ent) {
    if (isdefined(ent) && isdefined(ent.origin) && self === ent && !(isdefined(self.var_98cbe294) && self.var_98cbe294)) {
        fx = playfx(localclientnum, "weapon/fx_hero_firefly_death", ent.origin, (0, 0, 1));
        setfxteam(localclientnum, fx, ent.team);
    }
}

// Namespace hive_gun
// Params 1, eflags: 0x0
// Checksum 0x51aaee7f, Offset: 0xa68
// Size: 0x2c
function function_40245849(localclientnum) {
    self callback::on_shutdown(&on_shutdown, self);
}

// Namespace hive_gun
// Params 1, eflags: 0x0
// Checksum 0x4f834a09, Offset: 0xaa0
// Size: 0x74
function function_231d32d6(localclientnum) {
    fx = playfx(localclientnum, "weapon/fx_hero_firefly_start", self.origin, anglestoup(self.angles));
    setfxteam(localclientnum, fx, self.team);
}

// Namespace hive_gun
// Params 1, eflags: 0x0
// Checksum 0x7bff501f, Offset: 0xb20
// Size: 0x84
function function_3115859c(localclientnum) {
    fx = playfxontag(localclientnum, "weapon/fx_hero_firefly_hunting", self, "tag_origin");
    setfxteam(localclientnum, fx, self.team);
    self thread function_e7ff9fa6(localclientnum, fx);
}

// Namespace hive_gun
// Params 2, eflags: 0x0
// Checksum 0xc31b21cb, Offset: 0xbb0
// Size: 0x64
function function_e7ff9fa6(localclientnum, fx) {
    self util::waittill_any("entityshutdown", "stop_effects");
    if (isdefined(fx)) {
        stopfx(localclientnum, fx);
    }
}

// Namespace hive_gun
// Params 1, eflags: 0x0
// Checksum 0x2e3a5c2b, Offset: 0xc20
// Size: 0x28
function function_c0c4f0d9(localclientnum) {
    self notify(#"stop_effects");
    self.var_98cbe294 = 1;
}

// Namespace hive_gun
// Params 1, eflags: 0x0
// Checksum 0xdbacaaa3, Offset: 0xc50
// Size: 0x90
function function_c2dd71e6(localclientnum) {
    fx = playfx(localclientnum, "weapon/fx_hero_firefly_start_entity", self.origin, anglestoup(self.angles));
    setfxteam(localclientnum, fx, self.team);
    self notify(#"stop_effects");
    self.var_98cbe294 = 1;
}

// Namespace hive_gun
// Params 3, eflags: 0x0
// Checksum 0xb1549db5, Offset: 0xce8
// Size: 0xac
function gib_fx(localclientnum, fxfilename, gibflag) {
    fxtag = gibclientutils::playergibtag(localclientnum, gibflag);
    if (isdefined(fxtag)) {
        fx = playfxontag(localclientnum, fxfilename, self, fxtag);
        setfxteam(localclientnum, fx, getotherteam(self.team));
    }
}

// Namespace hive_gun
// Params 2, eflags: 0x0
// Checksum 0xd2504f7c, Offset: 0xda0
// Size: 0x34
function function_efe10ed8(localclientnum, value) {
    self endon(#"entityshutdown");
    self thread function_e802f658(localclientnum);
}

// Namespace hive_gun
// Params 1, eflags: 0x0
// Checksum 0xf782d03, Offset: 0xde0
// Size: 0x34e
function function_e802f658(localclientnum) {
    self endon(#"entityshutdown");
    if (!util::is_mature() || util::is_gib_restricted_build()) {
        return;
    }
    fxfilename = "weapon/fx_hero_firefly_attack_limb";
    bodytype = self getcharacterbodytype();
    if (bodytype >= 0) {
        var_f99f1882 = getcharacterfields(bodytype, currentsessionmode());
        if (isdefined(var_f99f1882.digitalblood) ? var_f99f1882.digitalblood : 0) {
            fxfilename = "weapon/fx_hero_firefly_attack_limb_reaper";
        }
    }
    var_eeee776 = 0;
    var_52fa99e0 = 0;
    while (true) {
        notetrack = self util::waittill_any_return("gib_leftarm", "gib_leftleg", "gib_rightarm", "gib_rightleg", "entityshutdown");
        switch (notetrack) {
        case "gib_rightarm":
            var_eeee776 |= 1;
            gib_fx(localclientnum, fxfilename, 16);
            self gibclientutils::playergibleftarm(localclientnum);
            self setcorpsegibstate(var_52fa99e0, var_eeee776);
            break;
        case "gib_leftarm":
            var_eeee776 |= 2;
            gib_fx(localclientnum, fxfilename, 32);
            self gibclientutils::playergibleftarm(localclientnum);
            self setcorpsegibstate(var_52fa99e0, var_eeee776);
            break;
        case "gib_rightleg":
            var_52fa99e0 |= 1;
            gib_fx(localclientnum, fxfilename, -128);
            self gibclientutils::playergibleftleg(localclientnum);
            self setcorpsegibstate(var_52fa99e0, var_eeee776);
            break;
        case "gib_leftleg":
            var_52fa99e0 |= 2;
            gib_fx(localclientnum, fxfilename, 256);
            self gibclientutils::playergibleftleg(localclientnum);
            self setcorpsegibstate(var_52fa99e0, var_eeee776);
            break;
        default:
            break;
        }
    }
}

