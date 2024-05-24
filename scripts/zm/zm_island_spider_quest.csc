#using scripts/zm/_zm_weapons;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_13425205;

// Namespace namespace_13425205
// Params 0, eflags: 0x0
// Checksum 0xc0f65dd8, Offset: 0x250
// Size: 0x164
function init() {
    var_8b462b02 = getminbitcountfornum(2);
    var_fbab08c0 = getminbitcountfornum(3);
    clientfield::register("scriptmover", "spider_queen_mouth_weakspot", 9000, var_8b462b02, "int", &function_4bd58cb8, 0, 0);
    clientfield::register("scriptmover", "spider_queen_bleed", 9000, 1, "counter", &function_dfc06604, 0, 0);
    clientfield::register("scriptmover", "spider_queen_stage_bleed", 9000, var_fbab08c0, "int", &function_e658f597, 0, 0);
    clientfield::register("scriptmover", "spider_queen_emissive_material", 9000, 1, "int", &function_5945974f, 0, 0);
}

// Namespace namespace_13425205
// Params 7, eflags: 0x0
// Checksum 0x7974707b, Offset: 0x3c0
// Size: 0xfc
function function_4bd58cb8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_8dd4267f)) {
        stopfx(localclientnum, self.var_8dd4267f);
        self.var_8dd4267f = undefined;
    }
    if (newval == 1) {
        self.var_8dd4267f = playfxontag(localclientnum, level._effect["spider_queen_weakspot"], self, "tag_turret");
        return;
    }
    if (newval == 2) {
        self.var_8dd4267f = playfxontag(localclientnum, level._effect["spider_queen_mouth_glow"], self, "tag_turret");
    }
}

// Namespace namespace_13425205
// Params 7, eflags: 0x0
// Checksum 0xa74fc48e, Offset: 0x4c8
// Size: 0x6c
function function_dfc06604(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["spider_queen_bleed_sm"], self, "tag_turret");
}

// Namespace namespace_13425205
// Params 7, eflags: 0x0
// Checksum 0xaaf8e76e, Offset: 0x540
// Size: 0x14e
function function_e658f597(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_770499e7 = playfxontag(localclientnum, level._effect["spider_queen_bleed_lg"], self, "tag_turret");
    }
    if (newval == 2) {
        self.var_770499e7 = playfxontag(localclientnum, level._effect["spider_queen_bleed_md"], self, "tag_turret");
    }
    if (newval == 3) {
        self.var_770499e7 = playfxontag(localclientnum, level._effect["spider_queen_bleed_md"], self, "tag_turret");
    }
    wait(2.5);
    if (isdefined(self.var_770499e7)) {
        stopfx(localclientnum, self.var_770499e7);
        self.var_770499e7 = undefined;
    }
}

// Namespace namespace_13425205
// Params 7, eflags: 0x0
// Checksum 0x18df7cf9, Offset: 0x698
// Size: 0xac
function function_5945974f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 1, 1, 1, 0);
        return;
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0, 0);
}

