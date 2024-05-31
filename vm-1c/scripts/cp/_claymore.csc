#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_7df5be44;

// Namespace namespace_7df5be44
// Params 1, eflags: 0x1 linked
// Checksum 0x3d9a17fe, Offset: 0xe8
// Size: 0x26
function init(localclientnum) {
    level._effect["fx_claymore_laser"] = "_t6/weapon/claymore/fx_claymore_laser";
}

// Namespace namespace_7df5be44
// Params 1, eflags: 0x1 linked
// Checksum 0x6f4fcf8c, Offset: 0x118
// Size: 0xc0
function spawned(localclientnum) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    while (true) {
        if (isdefined(self.stunned) && self.stunned) {
            wait(0.1);
            continue;
        }
        self.claymorelaserfxid = playfxontag(localclientnum, level._effect["fx_claymore_laser"], self, "tag_fx");
        self waittill(#"stunned");
        stopfx(localclientnum, self.claymorelaserfxid);
    }
}

