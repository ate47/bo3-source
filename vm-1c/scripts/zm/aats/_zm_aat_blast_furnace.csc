#using scripts/shared/aat_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace zm_aat_blast_furnace;

// Namespace zm_aat_blast_furnace
// Params 0, eflags: 0x2
// Checksum 0xd0f7f4e4, Offset: 0x208
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_aat_blast_furnace", &__init__, undefined, undefined);
}

// Namespace zm_aat_blast_furnace
// Params 0, eflags: 0x0
// Checksum 0xcc7fffcc, Offset: 0x248
// Size: 0x19e
function __init__() {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_blast_furnace", "zmui_zm_aat_blast_furnace", "t7_icon_zm_aat_blast_furnace");
    clientfield::register("actor", "zm_aat_blast_furnace" + "_explosion", 1, 1, "counter", &function_c0b26b7b, 0, 0);
    clientfield::register("vehicle", "zm_aat_blast_furnace" + "_explosion_vehicle", 1, 1, "counter", &function_76a1734a, 0, 0);
    clientfield::register("actor", "zm_aat_blast_furnace" + "_burn", 1, 1, "counter", &function_354949d, 0, 0);
    clientfield::register("vehicle", "zm_aat_blast_furnace" + "_burn_vehicle", 1, 1, "counter", &function_1ea0a980, 0, 0);
    level._effect["zm_aat_blast_furnace"] = "zombie/fx_aat_blast_furnace_zmb";
}

// Namespace zm_aat_blast_furnace
// Params 7, eflags: 0x0
// Checksum 0xcd864aef, Offset: 0x3f0
// Size: 0xc4
function function_c0b26b7b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playsound(0, "wpn_aat_blastfurnace_explo", self.origin);
    var_9338d2bd = spawnstruct();
    var_9338d2bd.origin = self.origin;
    var_9338d2bd.angles = self.angles;
    var_9338d2bd thread function_a2e115ca(localclientnum);
}

// Namespace zm_aat_blast_furnace
// Params 7, eflags: 0x0
// Checksum 0x94a81634, Offset: 0x4c0
// Size: 0xc4
function function_76a1734a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playsound(0, "wpn_aat_blastfurnace_explo", self.origin);
    var_9338d2bd = spawnstruct();
    var_9338d2bd.origin = self.origin;
    var_9338d2bd.angles = self.angles;
    var_9338d2bd thread function_a2e115ca(localclientnum);
}

// Namespace zm_aat_blast_furnace
// Params 1, eflags: 0x0
// Checksum 0x24f5845d, Offset: 0x590
// Size: 0xae
function function_a2e115ca(localclientnum) {
    angles = self.angles;
    if (lengthsquared(angles) < 0.001) {
        angles = (1, 0, 0);
    }
    self.var_b1903fd4 = playfx(localclientnum, "zombie/fx_aat_blast_furnace_zmb", self.origin, angles);
    wait 2.5;
    stopfx(localclientnum, self.var_b1903fd4);
    self.var_b1903fd4 = undefined;
}

// Namespace zm_aat_blast_furnace
// Params 7, eflags: 0x0
// Checksum 0xc1cce69, Offset: 0x648
// Size: 0xac
function function_354949d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    tag = "j_spine4";
    v_tag = self gettagorigin(tag);
    if (!isdefined(v_tag)) {
        tag = "tag_origin";
    }
    level thread function_ff63e348(localclientnum, self, tag);
}

// Namespace zm_aat_blast_furnace
// Params 7, eflags: 0x0
// Checksum 0xa860803b, Offset: 0x700
// Size: 0xac
function function_1ea0a980(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    tag = "tag_body";
    v_tag = self gettagorigin(tag);
    if (!isdefined(v_tag)) {
        tag = "tag_origin";
    }
    level thread function_ff63e348(localclientnum, self, tag);
}

// Namespace zm_aat_blast_furnace
// Params 3, eflags: 0x0
// Checksum 0x590d4a43, Offset: 0x7b8
// Size: 0xcc
function function_ff63e348(localclientnum, e_zombie, tag) {
    e_zombie.var_1703df46 = playfxontag(localclientnum, "zombie/fx_bgb_burned_out_fire_torso_zmb", e_zombie, tag);
    e_zombie playloopsound("chr_burn_npc_loop1", 0.5);
    e_zombie waittill(#"entityshutdown");
    if (isdefined(e_zombie)) {
        e_zombie stopallloopsounds(1.5);
        stopfx(localclientnum, e_zombie.var_1703df46);
    }
}

