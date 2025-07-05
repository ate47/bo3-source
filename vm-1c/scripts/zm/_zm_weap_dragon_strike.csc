#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace dragon_strike;

// Namespace dragon_strike
// Params 0, eflags: 0x2
// Checksum 0x3b620db8, Offset: 0x490
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_weap_dragon_strike", &__init__, undefined, undefined);
}

// Namespace dragon_strike
// Params 0, eflags: 0x0
// Checksum 0x356358dd, Offset: 0x4d0
// Size: 0x416
function __init__() {
    clientfield::register("scriptmover", "dragon_strike_spawn_fx", 12000, 1, "int", &dragon_strike_spawn_fx, 0, 0);
    clientfield::register("scriptmover", "dragon_strike_marker_on", 12000, 1, "int", &dragon_strike_marker_on, 0, 0);
    clientfield::register("scriptmover", "dragon_strike_marker_fx", 12000, 1, "counter", &dragon_strike_marker_fx, 0, 0);
    clientfield::register("scriptmover", "dragon_strike_marker_upgraded_fx", 12000, 1, "counter", &dragon_strike_marker_upgraded_fx, 0, 0);
    clientfield::register("scriptmover", "dragon_strike_marker_invalid_fx", 12000, 1, "counter", &dragon_strike_marker_invalid_fx, 0, 0);
    clientfield::register("scriptmover", "dragon_strike_marker_upgraded_invalid_fx", 12000, 1, "counter", &dragon_strike_marker_upgraded_invalid_fx, 0, 0);
    clientfield::register("scriptmover", "dragon_strike_flare_fx", 12000, 1, "int", &dragon_strike_flare_fx, 0, 0);
    clientfield::register("scriptmover", "dragon_strike_marker_fx_fadeout", 12000, 1, "counter", &dragon_strike_marker_fx_fadeout, 0, 0);
    clientfield::register("scriptmover", "dragon_strike_marker_upgraded_fx_fadeout", 12000, 1, "counter", &dragon_strike_marker_upgraded_fx_fadeout, 0, 0);
    clientfield::register("actor", "dragon_strike_zombie_fire", 12000, 2, "int", &dragon_strike_zombie_fire, 0, 0);
    clientfield::register("vehicle", "dragon_strike_zombie_fire", 12000, 2, "int", &dragon_strike_zombie_fire, 0, 0);
    clientfield::register("clientuimodel", "dragon_strike_invalid_use", 12000, 1, "counter", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.showDpadRight_DragonStrike", 12000, 1, "int", undefined, 0, 0);
    level._effect["dragon_strike_portal"] = "dlc3/stalingrad/fx_dragonstrike_portal_flash";
    level._effect["dragon_strike_beacon"] = "dlc3/stalingrad/fx_light_flare_sky_marker_red";
    level._effect["dragon_strike_zombie_fire"] = "dlc3/stalingrad/fx_fire_torso_zmb_green";
    level._effect["dragon_strike_mouth"] = "dlc3/stalingrad/fx_dragon_mouth_drips_boss";
    level._effect["dragon_strike_tongue"] = "dlc3/stalingrad/fx_dragon_mouth_drips_tongue_boss";
}

// Namespace dragon_strike
// Params 7, eflags: 0x0
// Checksum 0x4c679876, Offset: 0x8f0
// Size: 0xd4
function dragon_strike_spawn_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfxontag(localclientnum, level._effect["dragon_strike_portal"], self, "tag_neck_fx");
        playfxontag(localclientnum, level._effect["dragon_strike_mouth"], self, "tag_throat_fx");
        playfxontag(localclientnum, level._effect["dragon_strike_tongue"], self, "tag_mouth_floor_fx");
    }
}

// Namespace dragon_strike
// Params 7, eflags: 0x0
// Checksum 0x3f7b2534, Offset: 0x9d0
// Size: 0x9c
function dragon_strike_marker_on(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self dragonstrike_enable(1);
        self thread function_778495b0(localclientnum);
        return;
    }
    self notify(#"hash_e98f7ec4");
    self dragonstrike_enable(0);
}

// Namespace dragon_strike
// Params 1, eflags: 0x0
// Checksum 0x79d6d7c0, Offset: 0xa78
// Size: 0x50
function function_778495b0(localclientnum) {
    self endon(#"hash_e98f7ec4");
    self endon(#"entityshutdown");
    while (isdefined(self)) {
        self dragonstrike_setposition(self.origin);
        wait 0.016;
    }
}

// Namespace dragon_strike
// Params 7, eflags: 0x0
// Checksum 0x222cec20, Offset: 0xad0
// Size: 0x7c
function dragon_strike_marker_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self dragonstrike_setcolorradiusspinpulse(0.25, 3, 0.25, 128, 0.5, 0);
}

// Namespace dragon_strike
// Params 7, eflags: 0x0
// Checksum 0xa0f6a8c8, Offset: 0xb58
// Size: 0x7c
function dragon_strike_marker_upgraded_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self dragonstrike_setcolorradiusspinpulse(0.15, 3, 0.15, 128, 0.75, 0);
}

// Namespace dragon_strike
// Params 7, eflags: 0x0
// Checksum 0xabbf7e1f, Offset: 0xbe0
// Size: 0x7c
function dragon_strike_marker_invalid_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self dragonstrike_setcolorradiusspinpulse(4, 0.5, 0.25, 128, 0.5, 0);
}

// Namespace dragon_strike
// Params 7, eflags: 0x0
// Checksum 0xef0e6351, Offset: 0xc68
// Size: 0x7c
function dragon_strike_marker_upgraded_invalid_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self dragonstrike_setcolorradiusspinpulse(4, 0.5, 0.25, 128, 0.75, 0);
}

// Namespace dragon_strike
// Params 7, eflags: 0x0
// Checksum 0xc8e7ea1a, Offset: 0xcf0
// Size: 0xb6
function dragon_strike_flare_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.fx_flare = playfx(localclientnum, level._effect["dragon_strike_beacon"], self.origin);
        return;
    }
    if (isdefined(self.fx_flare)) {
        deletefx(localclientnum, self.fx_flare, 1);
        self.fx_flare = undefined;
    }
}

// Namespace dragon_strike
// Params 7, eflags: 0x0
// Checksum 0x235de35d, Offset: 0xdb0
// Size: 0x74
function dragon_strike_marker_fx_fadeout(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread function_1ba92b11(0.25, 3, 0.25, 0.5);
}

// Namespace dragon_strike
// Params 7, eflags: 0x0
// Checksum 0x45c02ec4, Offset: 0xe30
// Size: 0x74
function dragon_strike_marker_upgraded_fx_fadeout(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread function_1ba92b11(0.15, 3, 0.15, 0.75);
}

// Namespace dragon_strike
// Params 4, eflags: 0x0
// Checksum 0x2189f563, Offset: 0xeb0
// Size: 0xfe
function function_1ba92b11(var_6d056a0e, var_9ad65443, var_cddc37e, var_76d07324) {
    var_e0a873d1 = var_6d056a0e / 16;
    var_24ce51da = var_9ad65443 / 16;
    var_1e73d761 = var_cddc37e / 16;
    for (i = 0; i < 16; i++) {
        var_6d056a0e -= var_e0a873d1;
        var_9ad65443 -= var_24ce51da;
        var_cddc37e -= var_1e73d761;
        self dragonstrike_setcolorradiusspinpulse(var_6d056a0e, var_9ad65443, var_cddc37e, 128, var_76d07324, 0);
        wait 0.016;
    }
}

// Namespace dragon_strike
// Params 7, eflags: 0x0
// Checksum 0x98e285c, Offset: 0xfb8
// Size: 0x11c
function dragon_strike_zombie_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 2) {
        self zombie_death::flame_death_fx(localclientnum);
        return;
    }
    str_tag = "j_spinelower";
    v_tag = self gettagorigin(str_tag);
    if (!isdefined(v_tag)) {
        str_tag = "tag_origin";
    }
    self.var_9f5c18b = 1;
    if (isdefined(self)) {
        self.dragon_strike_zombie_fire = playfxontag(localclientnum, level._effect["dragon_strike_zombie_fire"], self, str_tag);
        self thread function_3cc1555d(localclientnum);
    }
}

// Namespace dragon_strike
// Params 1, eflags: 0x0
// Checksum 0x271d424, Offset: 0x10e0
// Size: 0x68
function function_3cc1555d(localclientnum) {
    self endon(#"entityshutdown");
    wait 12;
    if (isdefined(self) && isalive(self)) {
        stopfx(localclientnum, self.dragon_strike_zombie_fire);
        self.var_9f5c18b = 0;
    }
}

