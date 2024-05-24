#using scripts/zm/_zm_weapons;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace lightning_chain;

// Namespace lightning_chain
// Params 0, eflags: 0x2
// Checksum 0x31266cca, Offset: 0x258
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("lightning_chain", &init, undefined, undefined);
}

// Namespace lightning_chain
// Params 0, eflags: 0x1 linked
// Checksum 0x43b3577a, Offset: 0x298
// Size: 0x1ac
function init() {
    level._effect["tesla_bolt"] = "zombie/fx_tesla_bolt_secondary_zmb";
    level._effect["tesla_shock"] = "zombie/fx_tesla_shock_zmb";
    level._effect["tesla_shock_secondary"] = "zombie/fx_tesla_bolt_secondary_zmb";
    level._effect["tesla_shock_nonfatal"] = "zombie/fx_bmode_shock_os_zod_zmb";
    level._effect["tesla_shock_eyes"] = "zombie/fx_tesla_shock_eyes_zmb";
    clientfield::register("actor", "lc_fx", 1, 2, "int", &lc_shock_fx, 0, 1);
    clientfield::register("vehicle", "lc_fx", 1, 2, "int", &lc_shock_fx, 0, 0);
    clientfield::register("actor", "lc_death_fx", 1, 2, "int", &lc_play_death_fx, 0, 0);
    clientfield::register("vehicle", "lc_death_fx", 8000, 2, "int", &lc_play_death_fx, 0, 0);
}

// Namespace lightning_chain
// Params 7, eflags: 0x1 linked
// Checksum 0x7a432861, Offset: 0x450
// Size: 0x166
function lc_shock_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (newval) {
        if (!isdefined(self.lc_shock_fx)) {
            str_tag = "J_SpineUpper";
            str_fx = "tesla_shock";
            if (!self isai()) {
                str_tag = "tag_origin";
            }
            if (newval > 1) {
                str_fx = "tesla_shock_secondary";
            }
            self.lc_shock_fx = playfxontag(localclientnum, level._effect[str_fx], self, str_tag);
            self playsound(0, "zmb_electrocute_zombie");
        }
        return;
    }
    if (isdefined(self.lc_shock_fx)) {
        stopfx(localclientnum, self.lc_shock_fx);
        self.lc_shock_fx = undefined;
    }
}

// Namespace lightning_chain
// Params 7, eflags: 0x1 linked
// Checksum 0x9e4ac16f, Offset: 0x5c0
// Size: 0x164
function lc_play_death_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    str_tag = "J_SpineUpper";
    if (isdefined(self.isdog) && self.isdog) {
        str_tag = "J_Spine1";
    }
    if (!(self.archetype === "zombie")) {
        tag = "tag_origin";
    }
    switch (newval) {
    case 2:
        str_fx = level._effect["tesla_shock_secondary"];
        break;
    case 3:
        str_fx = level._effect["tesla_shock_nonfatal"];
        break;
    default:
        str_fx = level._effect["tesla_shock"];
        break;
    }
    playfxontag(localclientnum, str_fx, self, str_tag);
}

