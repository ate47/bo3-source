#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace blood;

// Namespace blood
// Params 0, eflags: 0x2
// Checksum 0x78316ba3, Offset: 0x1b8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("blood", &__init__, undefined, undefined);
}

// Namespace blood
// Params 0, eflags: 0x0
// Checksum 0xa02bb25c, Offset: 0x1f8
// Size: 0xc4
function __init__() {
    level.var_3c53fa9a = getdvarfloat("cg_t7HealthOverlay_Threshold3", 0.5);
    level.var_62567503 = getdvarfloat("cg_t7HealthOverlay_Threshold2", 0.8);
    level.var_f04f05c8 = getdvarfloat("cg_t7HealthOverlay_Threshold1", 0.99);
    level.var_d9defa1c = getdvarfloat("scr_use_digital_blood_enabled", 1);
    callback::on_localplayer_spawned(&localplayer_spawned);
}

// Namespace blood
// Params 1, eflags: 0x0
// Checksum 0x8b034714, Offset: 0x2c8
// Size: 0x12c
function localplayer_spawned(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    /#
        level.var_d9defa1c = getdvarfloat("<dev string:x28>", level.var_d9defa1c);
    #/
    self.var_d38c16be = 0;
    bodytype = self getcharacterbodytype();
    if (level.var_d9defa1c && bodytype >= 0) {
        var_f99f1882 = getcharacterfields(bodytype, currentsessionmode());
        self.var_d38c16be = isdefined(var_f99f1882.digitalblood) ? var_f99f1882.digitalblood : 0;
    }
    self thread function_ff801c5b(localclientnum);
    self thread function_d707564c(localclientnum);
}

// Namespace blood
// Params 1, eflags: 0x0
// Checksum 0x134c5b6b, Offset: 0x400
// Size: 0x4c
function function_d707564c(localclientnum) {
    self util::waittill_any("entityshutdown", "death");
    self function_14cd2c76(localclientnum);
}

// Namespace blood
// Params 1, eflags: 0x0
// Checksum 0x70d371a3, Offset: 0x458
// Size: 0xfc
function function_5cc93aa5(localclientnum) {
    self.blood_enabled = 1;
    filter::function_cfe957f(localclientnum, self.var_d38c16be);
    filter::function_c6391b80(localclientnum, 2, 2, self.var_d38c16be);
    filter::function_ba8f6d71(localclientnum, 2, 2, 65, 32);
    filter::function_1532508d(localclientnum, self.var_d38c16be);
    filter::function_c4e616ee(localclientnum, 2, 1, self.var_d38c16be);
    filter::function_db8726c7(localclientnum, 2, 1, randomfloat(1));
}

// Namespace blood
// Params 1, eflags: 0x0
// Checksum 0xd70ee0da, Offset: 0x560
// Size: 0x8c
function function_14cd2c76(localclientnum) {
    if (isdefined(self)) {
        self.blood_enabled = 0;
    }
    filter::function_4a86fcb7(localclientnum, 2, 2);
    filter::function_e8ee9075(localclientnum, 2, 1);
    if (!(isdefined(self.nobloodlightbarchange) && self.nobloodlightbarchange)) {
        setcontrollerlightbarcolor(localclientnum);
    }
}

// Namespace blood
// Params 2, eflags: 0x0
// Checksum 0xa59d1b, Offset: 0x5f8
// Size: 0x1dc
function function_704ec8bf(localclientnum, playerhealth) {
    if (playerhealth < level.var_3c53fa9a) {
        self.stage3amount = (level.var_3c53fa9a - playerhealth) / level.var_3c53fa9a;
    } else {
        self.stage3amount = 0;
    }
    if (playerhealth < level.var_62567503) {
        self.stage2amount = (level.var_62567503 - playerhealth) / level.var_62567503;
    } else {
        self.stage2amount = 0;
    }
    filter::function_fd3a600(localclientnum, 2, 2, self.stage3amount);
    filter::function_f3adf179(localclientnum, 2, 2, self.stage2amount);
    if (playerhealth < level.var_f04f05c8) {
        var_f3107012 = 0.55;
        assert(level.var_f04f05c8 > var_f3107012);
        var_44739e87 = playerhealth - var_f3107012;
        if (var_44739e87 < 0) {
            var_44739e87 = 0;
        }
        self.var_ca7d9806 = 1 - var_44739e87 / (level.var_f04f05c8 - var_f3107012);
    } else {
        self.var_ca7d9806 = 0;
    }
    filter::function_c511e703(localclientnum, 2, 1, self.var_ca7d9806);
    filter::function_5152516c(localclientnum, 2, 1, getservertime(localclientnum));
}

// Namespace blood
// Params 1, eflags: 0x0
// Checksum 0x99281da8, Offset: 0x7e0
// Size: 0x1c4
function function_2bd5d4ea(localclientnum) {
    currenttime = getservertime(localclientnum);
    elapsedtime = currenttime - self.lastbloodupdate;
    self.lastbloodupdate = currenttime;
    subtract = elapsedtime / 1000;
    if (self.stage3amount > 0) {
        self.stage3amount -= subtract;
    }
    if (self.stage3amount < 0) {
        self.stage3amount = 0;
    }
    if (self.stage2amount > 0) {
        self.stage2amount -= subtract;
    }
    if (self.stage2amount < 0) {
        self.stage2amount = 0;
    }
    filter::function_fd3a600(localclientnum, 2, 2, self.stage3amount);
    filter::function_f3adf179(localclientnum, 2, 2, self.stage2amount);
    if (self.var_ca7d9806 > 0) {
        self.var_ca7d9806 -= subtract;
    }
    if (self.var_ca7d9806 < 0) {
        self.var_ca7d9806 = 0;
    }
    filter::function_c511e703(localclientnum, 2, 1, self.var_ca7d9806);
    filter::function_5152516c(localclientnum, 2, 1, getservertime(localclientnum));
}

// Namespace blood
// Params 1, eflags: 0x0
// Checksum 0xea9ec669, Offset: 0x9b0
// Size: 0x3d0
function function_ff801c5b(localclientnum) {
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    self endon(#"death");
    self endon(#"killbloodoverlay");
    self.stage2amount = 0;
    self.stage3amount = 0;
    self.lastbloodupdate = 0;
    priorplayerhealth = renderhealthoverlayhealth(localclientnum);
    self function_704ec8bf(localclientnum, priorplayerhealth);
    while (true) {
        if (renderhealthoverlay(localclientnum) && !(isdefined(self.nobloodoverlay) && self.nobloodoverlay)) {
            shouldenabledoverlay = 0;
            playerhealth = renderhealthoverlayhealth(localclientnum);
            if (playerhealth < priorplayerhealth) {
                shouldenabledoverlay = 1;
                self function_704ec8bf(localclientnum, playerhealth);
            } else if (playerhealth == priorplayerhealth && playerhealth != 1) {
                shouldenabledoverlay = 1;
                self.lastbloodupdate = getservertime(localclientnum);
            } else if (self.stage2amount > 0 || self.stage3amount > 0) {
                shouldenabledoverlay = 1;
                self function_2bd5d4ea(localclientnum);
            } else if (isdefined(self.blood_enabled) && self.blood_enabled) {
                self function_14cd2c76(localclientnum);
            }
            priorplayerhealth = playerhealth;
            if (!(isdefined(self.blood_enabled) && self.blood_enabled) && shouldenabledoverlay) {
                self function_5cc93aa5(localclientnum);
            }
            if (!(isdefined(self.nobloodlightbarchange) && self.nobloodlightbarchange)) {
                if (self.stage3amount > 0) {
                    setcontrollerlightbarcolorpulsing(localclientnum, (1, 0, 0), 600);
                } else if (self.stage2amount == 1) {
                    setcontrollerlightbarcolorpulsing(localclientnum, (0.8, 0, 0), 1200);
                } else if (!sessionmodeiscampaigngame() || getgadgetpower(localclientnum) == 1 && codegetuimodelclientfield(self, "playerAbilities.inRange")) {
                    setcontrollerlightbarcolorpulsing(localclientnum, (1, 1, 0), 2000);
                } else if (isdefined(self.controllercolor)) {
                    setcontrollerlightbarcolor(localclientnum, self.controllercolor);
                } else {
                    setcontrollerlightbarcolor(localclientnum);
                }
            }
        } else if (isdefined(self.blood_enabled) && self.blood_enabled) {
            self function_14cd2c76(localclientnum);
        }
        wait 0.016;
    }
}

// Namespace blood
// Params 3, eflags: 0x0
// Checksum 0xc2ea4d1f, Offset: 0xd88
// Size: 0xc4
function setcontrollerlightbarcolorpulsing(localclientnum, color, pulserate) {
    curcolor = color * 0.2;
    scale = gettime() % pulserate / pulserate * 0.5;
    if (scale > 1) {
        scale = (scale - 2) * -1;
    }
    curcolor += color * 0.8 * scale;
    setcontrollerlightbarcolor(localclientnum, curcolor);
}

