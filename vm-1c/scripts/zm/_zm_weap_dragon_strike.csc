#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/ai/zombie_death;
#using scripts/codescripts/struct;

#namespace namespace_42aab40d;

// Namespace namespace_42aab40d
// Params 0, eflags: 0x2
// Checksum 0x85945c75, Offset: 0x490
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_weap_dragon_strike", &__init__, undefined, undefined);
}

// Namespace namespace_42aab40d
// Params 0, eflags: 0x1 linked
// Checksum 0xeb709240, Offset: 0x4d0
// Size: 0x416
function __init__() {
    clientfield::register("scriptmover", "dragon_strike_spawn_fx", 12000, 1, "int", &function_9edf1eca, 0, 0);
    clientfield::register("scriptmover", "dragon_strike_marker_on", 12000, 1, "int", &function_a911d32e, 0, 0);
    clientfield::register("scriptmover", "dragon_strike_marker_fx", 12000, 1, "counter", &function_ba315afb, 0, 0);
    clientfield::register("scriptmover", "dragon_strike_marker_upgraded_fx", 12000, 1, "counter", &function_64751666, 0, 0);
    clientfield::register("scriptmover", "dragon_strike_marker_invalid_fx", 12000, 1, "counter", &function_20b03867, 0, 0);
    clientfield::register("scriptmover", "dragon_strike_marker_upgraded_invalid_fx", 12000, 1, "counter", &function_6072780a, 0, 0);
    clientfield::register("scriptmover", "dragon_strike_flare_fx", 12000, 1, "int", &function_67175345, 0, 0);
    clientfield::register("scriptmover", "dragon_strike_marker_fx_fadeout", 12000, 1, "counter", &function_3fd3d9a8, 0, 0);
    clientfield::register("scriptmover", "dragon_strike_marker_upgraded_fx_fadeout", 12000, 1, "counter", &function_adb23339, 0, 0);
    clientfield::register("actor", "dragon_strike_zombie_fire", 12000, 2, "int", &function_aea822d9, 0, 0);
    clientfield::register("vehicle", "dragon_strike_zombie_fire", 12000, 2, "int", &function_aea822d9, 0, 0);
    clientfield::register("clientuimodel", "dragon_strike_invalid_use", 12000, 1, "counter", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.showDpadRight_DragonStrike", 12000, 1, "int", undefined, 0, 0);
    level._effect["dragon_strike_portal"] = "dlc3/stalingrad/fx_dragonstrike_portal_flash";
    level._effect["dragon_strike_beacon"] = "dlc3/stalingrad/fx_light_flare_sky_marker_red";
    level._effect["dragon_strike_zombie_fire"] = "dlc3/stalingrad/fx_fire_torso_zmb_green";
    level._effect["dragon_strike_mouth"] = "dlc3/stalingrad/fx_dragon_mouth_drips_boss";
    level._effect["dragon_strike_tongue"] = "dlc3/stalingrad/fx_dragon_mouth_drips_tongue_boss";
}

// Namespace namespace_42aab40d
// Params 7, eflags: 0x1 linked
// Checksum 0xf7191940, Offset: 0x8f0
// Size: 0xd4
function function_9edf1eca(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfxontag(localclientnum, level._effect["dragon_strike_portal"], self, "tag_neck_fx");
        playfxontag(localclientnum, level._effect["dragon_strike_mouth"], self, "tag_throat_fx");
        playfxontag(localclientnum, level._effect["dragon_strike_tongue"], self, "tag_mouth_floor_fx");
    }
}

// Namespace namespace_42aab40d
// Params 7, eflags: 0x1 linked
// Checksum 0xb2f88330, Offset: 0x9d0
// Size: 0x9c
function function_a911d32e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self dragonstrike_enable(1);
        self thread function_778495b0(localclientnum);
        return;
    }
    self notify(#"hash_e98f7ec4");
    self dragonstrike_enable(0);
}

// Namespace namespace_42aab40d
// Params 1, eflags: 0x1 linked
// Checksum 0xa1162ba9, Offset: 0xa78
// Size: 0x50
function function_778495b0(localclientnum) {
    self endon(#"hash_e98f7ec4");
    self endon(#"entityshutdown");
    while (isdefined(self)) {
        self dragonstrike_setposition(self.origin);
        wait(0.016);
    }
}

// Namespace namespace_42aab40d
// Params 7, eflags: 0x1 linked
// Checksum 0x587ac41, Offset: 0xad0
// Size: 0x7c
function function_ba315afb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self dragonstrike_setcolorradiusspinpulse(0.25, 3, 0.25, 128, 0.5, 0);
}

// Namespace namespace_42aab40d
// Params 7, eflags: 0x1 linked
// Checksum 0x883118c2, Offset: 0xb58
// Size: 0x7c
function function_64751666(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self dragonstrike_setcolorradiusspinpulse(0.15, 3, 0.15, 128, 0.75, 0);
}

// Namespace namespace_42aab40d
// Params 7, eflags: 0x1 linked
// Checksum 0xe7c651ac, Offset: 0xbe0
// Size: 0x7c
function function_20b03867(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self dragonstrike_setcolorradiusspinpulse(4, 0.5, 0.25, 128, 0.5, 0);
}

// Namespace namespace_42aab40d
// Params 7, eflags: 0x1 linked
// Checksum 0x31ea806e, Offset: 0xc68
// Size: 0x7c
function function_6072780a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self dragonstrike_setcolorradiusspinpulse(4, 0.5, 0.25, 128, 0.75, 0);
}

// Namespace namespace_42aab40d
// Params 7, eflags: 0x1 linked
// Checksum 0x907f069b, Offset: 0xcf0
// Size: 0xb6
function function_67175345(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.fx_flare = playfx(localclientnum, level._effect["dragon_strike_beacon"], self.origin);
        return;
    }
    if (isdefined(self.fx_flare)) {
        deletefx(localclientnum, self.fx_flare, 1);
        self.fx_flare = undefined;
    }
}

// Namespace namespace_42aab40d
// Params 7, eflags: 0x1 linked
// Checksum 0x6bff3cee, Offset: 0xdb0
// Size: 0x74
function function_3fd3d9a8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread function_1ba92b11(0.25, 3, 0.25, 0.5);
}

// Namespace namespace_42aab40d
// Params 7, eflags: 0x1 linked
// Checksum 0x8dda959, Offset: 0xe30
// Size: 0x74
function function_adb23339(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread function_1ba92b11(0.15, 3, 0.15, 0.75);
}

// Namespace namespace_42aab40d
// Params 4, eflags: 0x1 linked
// Checksum 0x6d30c0fa, Offset: 0xeb0
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
        wait(0.016);
    }
}

// Namespace namespace_42aab40d
// Params 7, eflags: 0x1 linked
// Checksum 0xdf4d5eff, Offset: 0xfb8
// Size: 0x11c
function function_aea822d9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
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
        self.var_aea822d9 = playfxontag(localclientnum, level._effect["dragon_strike_zombie_fire"], self, str_tag);
        self thread function_3cc1555d(localclientnum);
    }
}

// Namespace namespace_42aab40d
// Params 1, eflags: 0x1 linked
// Checksum 0x805c8365, Offset: 0x10e0
// Size: 0x68
function function_3cc1555d(localclientnum) {
    self endon(#"entityshutdown");
    wait(12);
    if (isdefined(self) && isalive(self)) {
        stopfx(localclientnum, self.var_aea822d9);
        self.var_9f5c18b = 0;
    }
}

